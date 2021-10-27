CREATE DEFINER=`root`@`localhost` PROCEDURE `CRUD_delete_pedido`(IN ParamPedido INT,  OUT nResultado INT, OUT cMensaje VARCHAR(125))
BEGIN

#En este procedimiento ademas de eliminarse el pedido, se llama a la eliminacion de los detalles del pedido

DECLARE finished INT DEFAULT 0;
DECLARE Id_PedidoDetalle INT;
DECLARE VarId INT DEFAULT NULL;
DECLARE C CURSOR FOR
SELECT Id FROM pedido_detalle WHERE pedido_Id = ParamPedido;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

SELECT COUNT(Id) FROM pedido where pedido.Id = ParamPedido INTO VarId;

IF VarId = 1 THEN
	UPDATE pedido
	SET Eliminado = 1,
	FechaEliminado = now()
	WHERE Id = ParamPedido;
	
    SET nResultado = 0;
	SET cMensaje = '';

	OPEN C;
	delDetalle: LOOP

	FETCH C into Id_PedidoDetalle;

	IF finished = 1 THEN 
		LEAVE delDetalle;
	END IF;

	call CRUD_delete_pedido_detalle(Id_PedidoDetalle, nResultado,  cMensaje);

	END LOOP delDetalle;

	CLOSE C;
ELSE
	set nResultado = -1;
	set cMensaje = CONCAT('No se encontro el pedido con Id ',ParamPedido);
END IF;

END