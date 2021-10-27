CREATE DEFINER=`root`@`localhost` PROCEDURE `CRUD_delete_pedido_detalle`(IN pId INT, OUT nResultado INT, OUT cMensaje VARCHAR(125))
BEGIN

#Por cada detalle se eliminan los automoviles que depende del pedido
DECLARE finished int default 0;
DECLARE Id_Automovil INT;
DECLARE VarId INT DEFAULT NULL;
DECLARE C CURSOR FOR SELECT Id FROM automovil WHERE pedido_detalle_Id = pId;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

SELECT count(Id) FROM pedido_detalle WHERE Id = pId into VarId; 


IF VarId = 1 THEN
	UPDATE pedido_detalle
	SET Eliminado = 1,
	FechaEliminado = now()
	WHERE Id = pId;



	OPEN C;
	delAuto: LOOP

	FETCH C into Id_Automovil;

	IF finished = 1 THEN 
		LEAVE delAuto;
	END IF;

	CALL CRUD_delete_vehiculo(Id_Automovil);

	END LOOP delAuto;

	CLOSE C;
    
    set nResultado = 0;
	set cMensaje = '';
    
ELSE
	set nResultado = -1;
	set cMensaje = Concat('No se encontro el detalle con Id ', pId);
END IF;
END