#Se recomienda haber ejecutado el Script de Inserts para llenar tablas de dimensiones con minimos datos
#Consecionario
#Doy de alta consecionario
CALL CRUD_alta_consecionario('GuidoGuidi',@rta1,@rta2);
SELECT @rta1,@rta2;

#cambio nombre del consecionario
CALL CRUD_update_consecionario(1,'Consecionario del Sur',@rta1,@rta2);
SELECT @rta1,@rta2;

#intento dar de alta consecionario con nombre repetido
CALL CRUD_alta_consecionario('Consecionario del Sur',@rta1,@rta2);
SELECT @rta1,@rta2;

#doy de baja consecionario
CALL CRUD_delete_consecionario(2,@rta1,@rta2);
SELECT @rta1,@rta2;

SELECT * FROM consecionaria;

#Pedido
#doy alta pedido
CALL CRUD_alta_pedido(1,@rta1,@rta2);
SELECT @rta1,@rta2;
#intento dar alta pedido con consecionario que no existe(No se implemento excepcion para consecionario eliminado)
CALL CRUD_alta_pedido(1542,@rta1,@rta2);
SELECT @rta1,@rta2;
#intento eliminar pedido que no existe
CALL CRUD_delete_pedido(1542,@rta1,@rta2);
SELECT @rta1,@rta2;
#elimino pedido
CALL CRUD_delete_pedido(1,@rta1,@rta2);
SELECT @rta1,@rta2;
#doy de alta otro pedido
CALL CRUD_alta_pedido(1,@rta1,@rta2);
SELECT @rta1,@rta2;


SELECT * from pedido;
#Pedido Detalle
#Aniado al pedido 1, 4 autos del modelo 1
CALL CRUD_alta_pedido_detalle(1,4,1,@rta1,@rta2);
SELECT @rta1,@rta2;

#Aniado al pedido 1, 3 autos del modelo 2
CALL CRUD_alta_pedido_detalle(1,3,2,@rta1,@rta2);
SELECT @rta1,@rta2;

#Intento hacer pedido de modelo que no existe
CALL CRUD_alta_pedido_detalle(1,3,35,@rta1,@rta2);
SELECT @rta1,@rta2;

#Intento hacer pedido de pedido que no existe
CALL CRUD_alta_pedido_detalle(57,3,3,@rta1,@rta2);
SELECT @rta1,@rta2;

#Al detalle 1 le aniado 1 auto
CALL CRUD_update_pedido_detalle(1,1,5,0,null,@rta1,@rta2);
SELECT @rta1,@rta2;

#Intento cambiar el detalle 1 a un modelo que no existe
CALL CRUD_update_pedido_detalle(1,35,5,0,null,@rta1,@rta2);
SELECT @rta1,@rta2;

SELECT * FROM pedido_detalle;

#3ra Etapa
#Punto 8
#Se crean los automoviles del pedido 1. 
CALL creacion_Automoviles_de_Pedido(1);

SELECT * from automovil;
#Automoviles creados y sus lineas de produccion asignadas
SELECT a.Id, a.Chasis, m.Nombre, m.linea_montaje_Id as linea_asignada, a.pedido_detalle_Id as IdDetallePedido FROM automovil a inner join modelo m on m.Id = a.pedido_detalle_modelo_Id;

#Punto 9
#Se inicia un automovil, llamar siguienteEstacionAutomovil() tambien puede iniciar un auto y ponerlo en la primera estacion, si el auto no fue iniciado previamente
CALL inicioAutomovil('1-76b76a2b',@rta1,@rta2);
SELECT @rta1,@rta2;

SELECT * FROM automovil_estacion;

#Intento iniciar auto ya iniciado
CALL inicioAutomovil('1-76b76a2b',@rta1,@rta2);
SELECT @rta1,@rta2;

#Intento iniciar otro auto cuando primera estacion esta ocupada
CALL inicioAutomovil('2-cc9c8861',@rta1,@rta2);
SELECT @rta1,@rta2;

#Intento iniciar auto con chasis que no existe
CALL inicioAutomovil('NoExiste123',@rta1,@rta2);
SELECT @rta1,@rta2;

#Punto 10
#Se pasa auto a siguiente estacion
CALL siguienteEstacionAutomovil('1-76b76a2b',@rta1,@rta2);
SELECT @rta1,@rta2;

#Auto que antes no pudo iniciarse, se inicia y pasa a la siguiente estacion
CALL siguienteEstacionAutomovil('2-cc9c8861',@rta1,@rta2);
SELECT @rta1,@rta2;
SELECT * FROM automovil_estacion;

#Se pasa auto por el resto de estaciones y se finaliza
CALL siguienteEstacionAutomovil('1-76b76a2b',@rta1,@rta2);
SELECT @rta1,@rta2;
CALL siguienteEstacionAutomovil('1-76b76a2b',@rta1,@rta2);
SELECT @rta1,@rta2;

#Parte 4 Reportes
#Reporte estado vehiculos del pedido 1
CALL reporte_vehiculos(1);

#reporte insumos necesario para pedido 1
CALL reporte_insumos_necesarios(1);

#reporte tiempo promedio linea 1
CALL reporte_tiempo_promedio(1);





