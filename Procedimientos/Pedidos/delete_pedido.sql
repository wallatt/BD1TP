CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_Pedido`(IN ParamPedido INT)
BEGIN

DECLARE finished int default 0;
DECLARE Id_PedidoDetalle INT;
DECLARE C cursor for
select Id from pedido_detalle where pedido_Id = ParamPedido;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

update pedido
SET Eliminado = 1,
FechaEliminado = now()
WHERE Id = ParamPedido;

OPEN C;
delDetalle: LOOP

FETCH C into Id_PedidoDetalle;

IF finished = 1 THEN 
	LEAVE delDetalle;
END IF;

call delete_PedidoDetalle(Id_PedidoDetalle);



END LOOP delDetalle;

CLOSE C;

END