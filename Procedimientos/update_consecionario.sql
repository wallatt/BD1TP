CREATE DEFINER=`root`@`localhost` PROCEDURE `update_consecionario`(id INT ,nombreNuevo VARCHAR(45))
BEGIN
if consecionariosRepetidos(nombreNuevo) = 0 THEN
	update consecionaria
    set Nombre = nombreNuevo
    where Id = id;
END IF;

END