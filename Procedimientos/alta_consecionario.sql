CREATE DEFINER=`root`@`localhost` PROCEDURE `alta_consecionario`(IN nombre VARCHAR(45))
BEGIN
if consecionariosRepetidos(nombre) = 0 THEN
	insert into consecionaria(Nombre, Eliminado) VALUES
    (nombre, 0);
    end if;


END