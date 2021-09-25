CREATE PROCEDURE `delete_automovil` (IN Id_Automovil INT)
BEGIN

update automovil SET
Eliminado = 1,
FechaEliminado = now()
where Id = Id_Automovil;

END
