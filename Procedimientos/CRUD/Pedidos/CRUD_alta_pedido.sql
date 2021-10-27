CREATE DEFINER=`root`@`localhost` PROCEDURE `CRUD_alta_pedido`(IN pIdConsecionario INT, OUT nResultado INT, OUT cMensaje VARCHAR(125))
BEGIN

DECLARE VarId INT DEFAULT NULL;
SELECT count(Id) FROM consecionaria WHERE Id = pIdConsecionario INTO VarId;

IF VarId = 1 THEN
	INSERT INTO pedido(consecionaria_Id,FechaDeVenta,  Eliminado ) VALUES 
	(pIdConsecionario,now(),0);
    set nResultado = 0;
    set cMensaje ='';
ELSE
	set nResultado = -1;
    set cMensaje = CONCAT('No se encontro consecionario con Id ', pIdConsecionario);
END IF;

END