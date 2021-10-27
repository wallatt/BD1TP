CREATE DEFINER=`root`@`localhost` PROCEDURE `creacion_automoviles`(IN ParamIdDetalle INT)
BEGIN


DECLARE idModeloParametro INT;
DECLARE nCantidadDetalle INT;


DECLARE finished INT DEFAULT 0;
DECLARE nInsertados INT;

DECLARE curDetallePedido CURSOR
FOR 
	SELECT modelo_Id, Cantidad_modelo FROM pedido_detalle WHERE pedido_detalle.Id = ParamIdDetalle;
    
DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'  
SET finished = 1;  
DECLARE CONTINUE HANDLER FOR SQLSTATE '23000'  
SET finished = 1;  


OPEN curDetallePedido;



FETCH curDetallePedido INTO idModeloParametro, nCantidadDetalle;

SET nInsertados = 0;

WHILE nInsertados < nCantidadDetalle DO

	call CRUD_alta_vehiculo(idModeloParametro, ParamIdDetalle);
    
	SET nInsertados = nInsertados +1;
END WHILE;




CLOSE curDetallePedido;

END