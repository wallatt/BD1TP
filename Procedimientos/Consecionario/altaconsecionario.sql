CREATE DEFINER=`root`@`localhost` PROCEDURE `alta_consecionario`(IN nombre VARCHAR(45), out msg VARCHAR(45))
BEGIN
if consecionariosRepetidos(nombre) = 0 THEN
START TRANSACTION;
	insert into consecionaria(Nombre, Eliminado) VALUES
    (nombre, 0);
    set @msg = 'insercion correcta';
COMMIT;
    end if;


END