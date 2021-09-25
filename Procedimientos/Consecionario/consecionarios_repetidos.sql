CREATE DEFINER=`root`@`localhost` FUNCTION `consecionariosRepetidos`(nombre VARCHAR(45)) RETURNS int(11)
BEGIN

declare b INT;
call CantConsecionarios(nombre,b);
return b;
END