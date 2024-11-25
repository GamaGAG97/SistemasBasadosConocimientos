

(deftemplate cliente
  (slot cliente_id)
  (multislot nombre)
  (multislot direccion)
  (slot telefono)
)

(deftemplate producto
  (slot producto_id)
  (slot nombre)
  (slot categoria)
  (slot marca)
  (slot precio) 
  (slot cantidad (default 10))
)

(deftemplate tarjeta
  (slot id_tarjeta)
  (slot banco)
  (slot nombre)
  (slot grupo)
  (slot exp_fecha)
)

(deftemplate orden
  (slot orden_id)
  (slot tarjeta_id)
  (slot cliente_id)
  (slot producto_id)
  (slot cantidad)
  (slot tipo_pago (default tarjeta))
  (slot bandera (default 0))
)

