CREATE DEFINER=`root`@`localhost` PROCEDURE `altaVehiculo`(IN modeloId INT, IN PedidoDetalleId INT)
BEGIN


DECLARE ChasisParam VARCHAR(45);
DECLARE FechaInicio datetime;

SELECT LEFT(MD5(RAND()), 8) into ChasisParam;

Insert INTO automovil(Chasis, Eliminado, pedido_detalle_Id, pedido_detalle_modelo_Id)
VALUES	(ChasisParam,0, PedidoDetalleId, modeloId);

END