CREATE DEFINER=`root`@`localhost` PROCEDURE `CRUD_update_pedido_detalle`(
IN pId INT ,
IN pModelo_Id INT,
IN pCantidadModelo INT,
IN pEliminado BIT,
IN pFechaEliminado DATETIME,

 OUT nResultado INT,
 OUT cMensaje VARCHAR(125))
BEGIN

DECLARE VarId INT DEFAULT NULL;
DECLARE VarModelo INT DEFAULT NULL;

SELECT Id FROM pedido_detalle WHERE Id = pId INTO VarId;
SELECT count(Id) FROM modelo WHERE Id = pModelo_Id into VarModelo;


IF VarId IS NOT NULL THEN
	IF VarModelo = 1 THEN
		START TRANSACTION;
			UPDATE pedido_detalle SET
			modelo_Id = pModelo_Id,
            Cantidad_modelo = pCantidadModelo,
			Eliminado = pEliminado,
			FechaEliminado = pFechaEliminado    
			WHERE Id = VarId;
				
			set nResultado = 0;
			set cMensaje ='';
				
			COMMIT;
		ELSE
			set nResultado = -2;
			set cMensaje = 'No existe modelo con ese Id';
	END IF;
ELSE
	set nResultado = -1;
	set cMensaje = 'No existe detalle con ese Id';
		
END IF;

END