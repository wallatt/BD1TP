CREATE DEFINER=`root`@`localhost` PROCEDURE `inicioAutomovil`(IN Paramchasis VARCHAR(45),out cMensaje VARCHAR(125), out nResultado int)
BEGIN


DECLARE VarEstacionInicioId INT;
DECLARE VarAutoId INT;
DECLARE VarIngreso DATETIME default NULL;
DECLARE VarEgreso DATETIME default NULL;
DECLARE VarAutoEnEstacion INT default NULL;
DECLARE VarEliminado INT default 0;

DECLARE VarFechaInicio DATETIME default NULL;
DECLARE VarFechaElim DATETIME default NULL;

set cMensaje = "";

select Id, FechaInicio, Eliminado, FechaEliminado into VarAutoId, VarFechaInicio, VarEliminado, VarFechaElim
from automovil
where Chasis = Paramchasis;

PROCLABEL: BEGIN
IF VarAutoId IS NOT NULL THEN
	IF VarEliminado = 0 THEN
		IF VarFechaInicio IS NULL THEN
			set cMensaje = 'no esta iniciado, chequeo estacion';
			
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
				
				set nResultado = 0;
				set cMensaje = CONCAT('Se inicio correctamente el automovil en el momento ',now(),' Id: ',VarAutoId);
				COMMIT;
				
			ELSE
				select Chasis from automovil a where a.Id = VarAutoEnEstacion into @chasis;
				set cMensaje = CONCAT('No se puede iniciar, estacion de automovil ocupada por auto con chasis: ',  @chasis);
				set nResultado = -1;
			END IF;
			 
			
		ELSE
			set cMensaje = CONCAT('No se puede iniciar, el automovil ya fue iniciado en ', VarFechaInicio);
			set nResultado = -2;
			LEAVE PROCLABEL;
		END IF;
	ELSE
		set cMensaje = CONCAT('No se puede iniciar, el automovil fue eliminado en ', VarFechaElim);
		set nResultado = -3;
        LEAVE PROCLABEL;
    END IF;
ELSE
	set cMensaje = CONCAT('No se puede iniciar, no se encontro el auto con Id ',VarAutoId);
    set nResultado = -4;
	LEAVE PROCLABEL;
END IF;

END PROCLABEL;





END