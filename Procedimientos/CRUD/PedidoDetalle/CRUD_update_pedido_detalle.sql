CREATE DEFINER=`root`@`localhost` PROCEDURE `CRUD_update_pedido_detalle`(
IN pId INT ,
IN pModelo_Id INT,
IN pEliminado BIT,
IN pFechaEliminado DATETIME,
 OUT nResultado INT,
 OUT cMensaje VARCHAR(125))
BEGIN

DECLARE VarId INT DEFAULT NULL;
SELECT Id FROM pedido_detalle WHERE Id = pId INTO VarId;

IF VarId IS NOT NULL THEN

START TRANSACTION;
	UPDATE pedido_detalle SET
	modelo_Id = pModelo_Id,
    Eliminado = pEliminado,
    FechaEliminado = pFechaEliminado    
	WHERE Id = VarId;
		
	set nResultado = 0;
    set cMensaje ='';
		
	COMMIT;
ELSE
	set nResultado = -1;
	set cMensaje = 'No existe detalle con ese Id';
END IF;

END