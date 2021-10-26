CREATE DEFINER=`root`@`localhost` PROCEDURE `reporte_vehiculos`(IN ParamNumPedido INT)
BEGIN



SELECT ParamNumPedido as PedidoId, m.Nombre as modelo, a.Chasis,
							IF(a.FechaFIn IS NULL,							
                            IFNULL(CONCAT('Estacion ',MAX(e.OrdenEstacion),' ' ,MAX(e.TareaDeterminada)),
                            'No Iniciado'),
                            'Terminado') AS Estado_Vehiculo,
                            IF(MAX(e.Id)IS NULL OR a.FechaFin IS NOT NULL,'n/a',MAX(e.Id)) AS Id_Estacion
FROM automovil a 
INNER JOIN pedido_detalle pe ON
pe.Id = a.pedido_detalle_Id 
left JOIN automovil_estacion aue ON
aue.automovil_Id = a.Id
left JOIN estacion e ON
e.Id = aue.estacion_Id
INNER JOIN modelo m ON
m.Id = pe.modelo_Id
WHERE pe.pedido_Id = ParamNumPedido
GROUP BY a.Chasis

;

END