CREATE DEFINER=`root`@`localhost` PROCEDURE `CRUD_update_consecionario`(IN ParamId INT ,IN nombreNuevo VARCHAR(45), OUT nResultado INT, OUT cMensaje VARCHAR(125))
BEGIN
DECLARE VarId INT DEFAULT NULL;
SELECT Id FROM consecionaria WHERE Id = ParamId into VarId;

IF VarId IS NOT NULL THEN
	IF consecionariosRepetidos(nombreNuevo) = 0 THEN
	START TRANSACTION;
		update consecionaria c
		set Nombre = nombreNuevo
		where c.Id = ParamId;
		set nResultado = 0;
		set cMensaje = '';
	COMMIT;
	ELSE
		set nResultado = -1;
		set cMensaje = 'Ya existe consecionario con ese nombre';
	END IF;
ELSE
	set nResultado = -2;
	set cMensaje = 'No existe consecionario con ese Id';
END IF;
END