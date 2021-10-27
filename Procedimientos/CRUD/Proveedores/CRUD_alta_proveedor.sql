CREATE DEFINER=`root`@`localhost` PROCEDURE `CRUD_alta_proveedor`(IN pNombre VARCHAR(45), IN pCUIT VARCHAR(45), OUT nResultado INT, OUT cMensaje VARCHAR(125))
BEGIN

DECLARE pDuplicado INT;

SELECT COUNT(Id) FROM proveedor WHERE CUIT = pCUIT INTO pDuplicado;

IF pDuplicado = 0 THEN

	START TRANSACTION;
    INSERT INTO proveedor(Nombre, CUIT, Eliminado) VALUES
    (pNombre, pCUIT, 0);
	
    set nResultado = 0;
	set cMensaje = '';
    COMMIT;
ELSE
	set nResultado = -1;
	set cMensaje = 'CUIT duplicado';
END IF;
END