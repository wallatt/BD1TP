CREATE DEFINER=`root`@`localhost` PROCEDURE `CRUD_delete_consecionario`(IN pId INT, OUT nResultado INT, OUT cMensaje VARCHAR(125))
BEGIN

DECLARE VarId INT DEFAULT NULL;
DECLARE bEliminado BIT DEFAULT NULL;
SELECT Id, Eliminado FROM consecionaria WHERE Id = pId into VarId, bEliminado;

IF VarId IS NOT NULL AND bEliminado = 0 THEN
	UPDATE consecionaria SET
	Eliminado = 1,
	FechaEliminado = now()
	WHERE Id = pId;
    
    set nResultado = 0;
	set cMensaje = '';
ELSE
	IF bEliminado = 1 THEN
		set nResultado = -2;
		set cMensaje = Concat('El consecionario ya habia sido eliminado ');
    ELSE
		set nResultado = -1;
		set cMensaje = Concat('No se encontro consecionario con Id ', pId);
    END IF;
END IF;
    

END