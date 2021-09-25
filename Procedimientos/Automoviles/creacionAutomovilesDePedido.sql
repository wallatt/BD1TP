CREATE DEFINER=`root`@`localhost` PROCEDURE `creacion_Automoviles_de_Pedido`(IN ParamIdPedido INT)
BEGIN

DECLARE idDetallePedido INT;
DECLARE finished INT default 0;
DECLARE curDetallePedido CURSOR FOR
select Id FROM pedido_detalle WHERE pedido_Id = ParamIdPedido;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

OPEN curDetallePedido;

getModelo: LOOP
FETCH curDetallePedido INTO idDetallePedido;

IF finished = 1 THEN 
	LEAVE getModelo;
END IF;
call creacion_automoviles(idDetallePedido);

END LOOP getModelo;

CLOSE curDetallePedido;



END