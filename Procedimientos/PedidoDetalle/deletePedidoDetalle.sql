CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_PedidoDetalle`(IN ParamPedido_detalle INT)
BEGIN

DECLARE finished int default 0;
DECLARE Id_Automovil INT;
DECLARE C cursor for
select Id from automovil where pedido_detalle_Id = ParamPedido_detalle;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

update pedido_detalle
SET Eliminado = 1,
FechaEliminado = now()
WHERE Id = ParamPedido_detalle;

OPEN C;
delAuto: LOOP

FETCH C into Id_Automovil;

IF finished = 1 THEN 
	LEAVE delAuto;
END IF;

call delete_automovil(Id_Automovil);



END LOOP delAuto;

CLOSE C;

END