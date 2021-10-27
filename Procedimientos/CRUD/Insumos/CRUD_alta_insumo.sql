CREATE DEFINER=`root`@`localhost` PROCEDURE `CRUD_alta_insumo`(IN pDescripcion VARCHAR(45),IN pUnidad VARCHAR(45), OUT nResultado INT, OUT cMensaje VARCHAR(125))
BEGIN


DECLARE VarId INT DEFAULT NULL;
DECLARE VarUnidad INT DEFAULT NULL;

SELECT Id FROM insumos WHERE Descripcion = pDescripcion into VarId;
SELECT Id FROM unidad WHERE Descripcion = pUnidad into VarUnidad;

IF VarUnidad IS NULL THEN
	INSERT INTO unidad(Descripcion,Eliminar) VALUES
    (pUnidad,0);
    SET VarUnidad = last_insert_id();
END IF;

IF VarId IS NULL THEN
	INSERT INTO insumos(Descripcion, Eliminado, unidad_Id) VALUES
    (pDescripcion,0,VarUnidad);
    
    SET nResultado = 0;
	SET cMensaje = '';
ELSE
    SET nResultado = -1;
	SET cMensaje = 'Ya existe ese insumo';
    
    
END IF;

END