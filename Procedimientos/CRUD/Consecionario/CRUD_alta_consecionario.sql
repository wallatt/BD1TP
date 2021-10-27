CREATE DEFINER=`root`@`localhost` PROCEDURE `CRUD_alta_consecionario`(IN nombre VARCHAR(45), OUT nResultado INT, OUT cMensaje VARCHAR(125))
BEGIN
IF consecionariosRepetidos(nombre) = 0 THEN
START TRANSACTION;
	INSERT INTO consecionaria(Nombre, Eliminado) VALUES
    (nombre, 0);
    SET nResultado = 0;
	SET cMensaje = '';
COMMIT;

ELSE 
	SET nResultado = -1;
	SET cMensaje = 'Nombre de consecionario repetido';
END IF;


END