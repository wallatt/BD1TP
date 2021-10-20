CREATE DEFINER=`root`@`localhost` PROCEDURE `siguienteEstacionAutomovil`(IN Paramchasis VARCHAR(45),out cMensaje VARCHAR(125), out nResultado INT)
BEGIN

DECLARE VarAutoId INT;
DECLARE VarEliminado INT default 0;
DECLARE VarFechaElim DATETIME default NULL;
DECLARE VarEstacionId INT default 0;
DECLARE VarFechaIngreso DATETIME default NULL;
DECLARE VarFechaFinalizado DATETIME default NULL;

DECLARE VarOrden INT default 0;
DECLARE VarIdSiguiente INT default NULL;

DECLARE VarTarea VARCHAR(45) default NULL;
DECLARE VarLineaMontaje INT default 0;
DECLARE SiguienteEstaLibre INT default null;

DECLARE ChasisDeOcupado VARCHAR(45);

SELECT Id, Eliminado, FechaEliminado, FechaFin into VarAutoId, VarEliminado, VarFechaElim, VarFechaFinalizado
FROM automovil
WHERE Chasis = Paramchasis;

IF VarEliminado = 0 AND VarFechaFinalizado IS NULL THEN
	#Se obtiene la ultima fecha de ingreso del auto y la estacion a la que corresponde
	SELECT FechaIngresoEstacion, estacion_Id 
	FROM automovil_estacion aue 
	WHERE aue.automovil_Id = VarAutoId AND FechaIngresoEstacion = (select MAX(FechaIngresoEstacion) from automovil_estacion where automovil_Id = VarAutoId)
	INTO VarFechaIngreso, VarEstacionId
	;
	
    IF VarFechaIngreso IS NULL THEN
		call inicioAutomovil(Paramchasis,cMensaje, nResultado);
    ELSE
		#Se obtienen la informacion de la estacion actual, para obtener cual es la siguiente estacion
		SELECT OrdenEstacion, TareaDeterminada, linea_montaje_Id 
		FROM estacion e 
		INNER JOIN automovil_estacion aue ON e.Id = aue.estacion_Id
		WHERE e.Id = VarEstacionId
		AND aue.automovil_Id = VarAutoId
		INTO VarOrden, VarTarea, VarLineaMontaje;

		SELECT Id AS IdSiguienteEstacion FROM estacion e
		WHERE OrdenEstacion = VarOrden+1
		AND linea_montaje_Id = VarLineaMontaje
		INTO VarIdSiguiente;

		IF VarIdSiguiente IS NULL THEN
			#No hay siguiente estacion, finaliza la produccion del auto
			Start transaction;
			UPDATE automovil_estacion 
			SET FechaEgresoEstacion = now()
			WHERE automovil_Id = VarAutoId
			AND estacion_Id = VarEstacionId;
			
			UPDATE automovil
			SET FechaFin = now()
			WHERE Id = VarAutoId;
			
			SET nResultado = 0;
			SET cMensaje = 'El automovil fue finalizado y salio de la linea de montaje';
			commit;
		ELSE
			#Si el numero de egresos es igual al de ingresos en una estacion, entonces la estacion esta libre
			SELECT count(FechaEgresoEstacion) - count(FechaIngresoEstacion) FROM automovil_estacion aue WHERE Eliminado = 0 AND estacion_Id = VarIdSiguiente
			INTO SiguienteEstaLibre;
			
			IF SiguienteEstaLibre = 0 THEN
				#siguiente estacion esta libre, se finaliza la actual
				start transaction;
				UPDATE automovil_estacion SET 
				FechaEgresoEstacion = now()
				WHERE automovil_Id = VarAutoId
				AND estacion_Id = VarEstacionId;
				
				#Se inserta automovil en siguiente estacion
				INSERT INTO automovil_estacion(FechaIngresoEstacion, Eliminado, estacion_Id, automovil_Id)
						VALUES(now(),0,VarIdSiguiente,VarAutoId);
						
				SET nResultado = 0;
				SET cMensaje = CONCAT('Se paso el automovil a la siguiente estacion');
				commit;
			
			ELSE
				#Siguiente estacion esta ocupada
				
				select a.Chasis from automovil_estacion aue
				inner join automovil a on a.Id = aue.automovil_Id
				where aue.estacion_Id = VarIdSiguiente AND FechaIngresoEstacion = (SELECT max(FechaIngresoEstacion) FROM automovil_estacion WHERE estacion_Id = VarIdSiguiente)
				into ChasisDeOcupado;
				
				set nResultado = -1;
				set cMensaje = CONCAT('El automovil no se pudo pasar de estacion, siguiente estacion ocupada por auto con chasis ', ChasisDeOcupado);
				
				
			
			END IF;

		END IF;
	END IF;
ELSE
	IF VarFechaFinalizado IS NOT NULL THEN
		set nResultado = -2;
		set cMensaje = CONCAT('El automovil no se puede pasar de estacion, fue finalizado en: ',VarFechaFinalizado);
    ELSE
		set nResultado = -3;
		set cMensaje = CONCAT('El automovil no se puede pasar de estacion, fue eliminado en: ',VarFechaElim);
	END IF;
END IF;







END