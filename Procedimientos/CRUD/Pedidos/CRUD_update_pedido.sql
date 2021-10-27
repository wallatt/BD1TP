CREATE DEFINER=`root`@`localhost` PROCEDURE `CRUD_update_pedido`(
IN pId INT ,
IN pFechaDeVenta DATETIME,
IN pFechaDeEntrega DATETIME,
IN pEliminado BIT,
IN pFechaEliminado DATETIME,
 OUT nResultado INT,
 OUT cMensaje VARCHAR(125))
BEGIN
DECLARE VarId INT DEFAULT NULL;
select Id from pedido where Id = pId into VarId;

IF VarId IS NOT NULL THEN

START TRANSACTION;
	UPDATE pedido p SET
	FechaDeVenta = pFechaDeVenta,
	FechaDeEntrega = pFechaDeEntrega,
	Eliminado = pEliminado,
	FechaEliminado = pFechaEliminado
	WHERE Id = VarId;
		
	set nResultado = 0;
    set cMensaje ='';
		
	COMMIT;
ELSE
	set nResultado = -1;
	set cMensaje = 'No existe pedido con ese Id';
END IF;

END