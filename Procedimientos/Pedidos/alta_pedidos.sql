CREATE DEFINER=`root`@`localhost` PROCEDURE `altapedido`(IN Id_Cons INT)
BEGIN
insert into pedido(consecionaria_Id,FechaDeVenta,  Eliminado ) values 
(Id_Cons,now(),0);


END