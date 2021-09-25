CREATE DEFINER=`root`@`localhost` PROCEDURE `update_consecionario`(id INT ,nombreNuevo VARCHAR(45))
BEGIN
if consecionariosRepetidos(nombreNuevo) = 0 THEN
	update consecionaria c
    set Nombre = nombreNuevo
    where c.Id = id;
END IF;
END