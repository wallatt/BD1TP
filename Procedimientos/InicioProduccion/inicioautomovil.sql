CREATE DEFINER=`root`@`localhost` PROCEDURE `inicioAutomovil`(IN Paramchasis VARCHAR(45),out msg VARCHAR(125), out VarFechaInicio datetime)
BEGIN


DECLARE VarEstacionInicioId INT;
DECLARE VarAutoId INT;
DECLARE VarIngreso DATETIME default NULL;
DECLARE VarEgreso DATETIME default NULL;
DECLARE VarAutoEnEstacion INT default NULL;

set msg = "";

select Id, FechaInicio into VarAutoId, VarFechaInicio 
from automovil
where Chasis = Paramchasis;

PROCLABEL: BEGIN
IF VarAutoId IS NOT NULL THEN
	set msg = 'existe auto';
    IF VarFechaInicio IS NULL THEN
		set msg = 'no esta iniciado, chequeo estacion';
        
        select IdEstacion from (
        select min(e.OrdenEstacion) AS IdPrimeraEstacion, e.Id AS IdEstacion from estacion e 
		inner join linea_montaje li on e.linea_montaje_Id = li.Id
		inner join modelo mo on mo.linea_montaje_Id = li.Id
		inner join automovil au on mo.Id = au.pedido_detalle_modelo_Id
		where au.Id = VarAutoId) as t 
        INTO VarEstacionInicioId;
         
         select max(FechaIngresoEstacion), FechaEgresoEstacion, automovil_Id from automovil_estacion aue 
         where aue.estacion_Id = VarEstacionInicioId
         into VarIngreso, VarEgreso, VarAutoEnEstacion;
         
		IF VarEgreso IS NOT NULL OR VarIngreso IS NULL THEN
         
			START transaction;
            insert into automovil_estacion(FechaIngresoEstacion, Eliminado, estacion_Id, automovil_Id)
            VALUES(now(),0,VarEstacionInicioId,VarAutoId);
			
            update automovil set FechaInicio = now() where automovil.Id = VarAutoId;
			
            set VarFechaInicio = now();
            set msg = CONCAT('se introdujo el automovil en el momento ',now(),' Id: ',VarAutoId);
			COMMIT;
            
		ELSE
        select Chasis from automovil a where a.Id = VarAutoEnEstacion into @chasis;
		set msg = concat('estacion de automovil ocupada por auto con chasis: ',  @chasis);
        
		END IF;
         
        
    ELSE
		set msg = 'ya esta iniciado';
        LEAVE PROCLABEL;
    END IF;
ELSE
	LEAVE PROCLABEL;
END IF;

END PROCLABEL;





END