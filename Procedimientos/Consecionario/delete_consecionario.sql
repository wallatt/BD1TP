CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_consecionario`(IN Id_Cons INT)
BEGIN

update consecionaria SET
Eliminado = 1,
FechaEliminado = now()
where Id = Id_Cons;

END