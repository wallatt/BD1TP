USE `mydb` ;


INSERT INTO proveedor(Nombre, CUIT,Eliminado)
VALUES	('Proveedor1','10-2030-40',0),
		('Proveedor2','10-3040-40',0),
        ('Proveedor3','10-4050-40',0);


select * from proveedor;

insert into unidad(Descripcion, Eliminar)
VALUES	('Lts',0),
		('Kg',0),
		('g',0),
		('m2',0);

select * from unidad;

insert into insumos(Descripcion, Cantidad, Eliminado, unidad_Id)
VALUES				('pintura',10,0,1),
					('aluminio',500,0,2),
                    ('hierro',100,0,2),
                    ('alfombra',10,0,4);
                    
select * from insumos;


insert into proveedor_insumos(Precio,insumos_Id, proveedor_Id)
VALUES		(100,1, (select min(Id)  from proveedor)),
			(200,1, (select min(Id)+1  from proveedor)),
			(150,2, (select min(Id)+2  from proveedor))
;


select ins.Descripcion, Cantidad, un.Descripcion from insumos ins inner join unidad un on ins.unidad_id = un.Id;


select ins.Descripcion, Cantidad, un.Descripcion , Nombre , Precio from insumos ins inner join unidad un on ins.unidad_id = un.Id inner join proveedor_insumos on insumos_Id = ins.Id inner join proveedor p on p.Id = proveedor_Id;


