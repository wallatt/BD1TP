CREATE DEFINER=`root`@`localhost` PROCEDURE `alta_pedido_detalle`(IN id_pedido INT , IN Cantidad INT, IN modelo_Id INT)
BEGIN

insert into pedido_detalle(modelo_Id, modelo_Id1, Cantidad_modelo, pedido_Id, Eliminado)
VALUES
			(modelo_Id, modelo_Id, Cantidad, id_pedido, 0)
;

END