CREATE DEFINER=`root`@`localhost` PROCEDURE `CRUD_delete_consecionario`(IN pId INT, OUT nResultado INT, OUT cMensaje VARCHAR(125))
BEGIN

DECLARE VarId INT DEFAULT NULL;
SELECT Id FROM consecionaria WHERE Id = pId into VarId;

IF VarId IS NOT NULL THEN

	UPDATE consecionaria SET
	Eliminado = 1,
	FechaEliminado = now()
	WHERE Id = pId;
    
    set nResultado = 0;
	set cMensaje = '';
ELSE
	set nResultado = -1;
	set cMensaje = Concat('No se encontro consecionario con Id ', pId);
END IF;
    

END