CREATE DEFINER=`root`@`localhost` PROCEDURE `reporte_tiempo_promedio`(IN ParamLineaMontaje INT)
BEGIN


SELECT ParamLineaMontaje AS Linea_Montaje ,SEC_TO_TIME(AVG(TIME_TO_SEC(tiempodefabricacion))) AS Promedio, count(tiempodefabricacion) AS Autos_construidos
FROM (
SELECT TIMEDIFF(FechaFin, FechaInicio) AS tiempodefabricacion
FROM automovil 
INNER JOIN pedido_detalle pd ON
automovil.pedido_detalle_Id = pd.Id
INNER JOIN modelo m ON
m.Id = pd.modelo_Id
where FechaFin is NOT NULL and FechaInicio IS NOT NULL
AND m.linea_montaje_Id = ParamLineaMontaje
) AS T
;




END