CREATE DEFINER=`root`@`localhost` PROCEDURE `reporte_insumos_necesarios`(IN ParamPedido INT)
BEGIN

SELECT Cod_insumo, DESCRIPCION AS insumo, SUM(TOTAL) AS Cantidad,  unidad

FROM(
SELECT pd.Cantidad_modelo * ine.CantidadConsumida AS TOTAL, pd.Cantidad_modelo, ine.CantidadConsumida, i.Descripcion AS DESCRIPCION, ine.insumos_Id AS Cod_insumo, u.Descripcion AS unidad FROM pedido_detalle pd
INNER JOIN modelo m ON
pd.modelo_Id = m.Id
INNER JOIN linea_montaje li ON
li.Id = m.linea_montaje_Id
INNER JOIN estacion e ON
li.Id = e.linea_montaje_Id
INNER JOIN insumo_estacion ine ON
ine.estacion_Id = e.Id
INNER JOIN insumos i ON
i.Id = ine.insumos_Id
INNER JOIN unidad u ON
i.unidad_Id = u.Id

WHERE pd.pedido_id = ParamPedido) AS SUMA
group by DESCRIPCION, cod_insumo, unidad
;



END