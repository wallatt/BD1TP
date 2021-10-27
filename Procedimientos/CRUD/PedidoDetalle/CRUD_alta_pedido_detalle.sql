CREATE DEFINER=`root`@`localhost` PROCEDURE `CRUD_alta_pedido_detalle`(IN id_pedido INT , IN Cantidad INT, IN modelo_Id INT, OUT nResultado INT, OUT cMensaje VARCHAR(125))
BEGIN

DECLARE VarId INT DEFAULT NULL;
DECLARE VarModelo INT DEFAULT NULL;

SELECT count(Id) FROM pedido WHERE Id = id_pedido INTO VarId;
SELECT count(Id) FROM modelo WHERE Id = modelo_Id into VarModelo;


IF VarModelo = 1 THEN
	IF VarId = 1 THEN

		INSERT INTO pedido_detalle(modelo_Id, Cantidad_modelo, pedido_Id, Eliminado)
		VALUES
		(modelo_Id, Cantidad, id_pedido, 0)
		;
		set nResultado = 0;
		set cMensaje = '';
	ELSE
		set nResultado = -1;
		set cMensaje = CONCAT('No se encontro pedido con Id ', id_pedido);
	END IF;
ELSE
	set nResultado = -2;
	set cMensaje = CONCAT('No se encontro el modelo con Id ', modelo_Id);
END IF;
    

END