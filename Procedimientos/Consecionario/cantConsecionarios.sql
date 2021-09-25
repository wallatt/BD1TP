CREATE DEFINER=`root`@`localhost` PROCEDURE `CantConsecionarios`(IN nombreC VARCHAR(45), OUT resultado INT)
BEGIN

declare valor int;
DECLARE c CURSOR FOR
select Count(Nombre) from consecionaria
WHERE Nombre = nombreC;
OPEN c;
FETCH c into resultado;
CLOSE c;
END