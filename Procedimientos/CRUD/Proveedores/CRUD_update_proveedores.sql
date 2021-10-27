CREATE DEFINER=`root`@`localhost` PROCEDURE `CRUD_update_proveedores`(IN pId INT, IN pNombre VARCHAR(45), IN pCUIT VARCHAR(45),IN pEliminado BIT, IN pFechaEliminado datetime , OUT nResultado INT, OUT cMensaje VARCHAR(125))
BEGIN

DECLARE VarId INT DEFAULT NULL;
DECLARE VarCUIT VARCHAR(45) DEFAULT NULL;
DECLARE VarIdCuit VARCHAR(45) DEFAULT NULL;

SELECT count(Id) FROM proveedor WHERE Id = pId INTO VarId;
SELECT Id from proveedor WHERE CUIT = pCUIT INTO VarIdCuit;
SELECT CUIT from proveedor WHERE Id = pId INTO VarCUIT;

#Existe el proveedor
IF  VarId = 1 AND 
	#Si encuentro el CUIT en la base, es del mismo proveedor que quiero cambiar
	(pCUIT = VarCUIT AND VarIdCuit = pId) OR
    VarCUIT IS NULL THEN
    
	START TRANSACTION;
    UPDATE proveedor
    SET Nombre = pNombre,
    CUIT = pCUIT,
    Eliminado = pEliminado,
    FechaEliminado = pFechaEliminado;
    
    SET nResultado = 0;
	SET cMensaje = '';
    COMMIT;
ELSE 
	IF VarId = 0 THEN
		SET nResultado = -1;
		SET cMensaje = CONCAT('No se encontro pedido con Id ', pId);
	ELSE 
		SET nResultado = -2;
		SET cMensaje = CONCAT('Intentando aniadir un CUIT duplicado');
	END IF;
END IF;

END