CREATE DEFINER=`root`@`localhost` PROCEDURE `CRUD_alta_vehiculo`(IN modeloId INT, IN PedidoDetalleId INT)
BEGIN

DECLARE IdAuto INT;
DECLARE ChasisParam VARCHAR(45);
DECLARE FechaInicio datetime;

SELECT LEFT(MD5(RAND()), 8) into ChasisParam;

START TRANSACTION;
Insert INTO automovil(Eliminado, pedido_detalle_Id, pedido_detalle_modelo_Id)
VALUES	(0, PedidoDetalleId, modeloId);

SELECT CONCAT(LAST_INSERT_ID(),'-', ChasisParam) into ChasisParam;

UPDATE automovil a SET Chasis = ChasisParam where a.Id = last_insert_id();

COMMIT;

END