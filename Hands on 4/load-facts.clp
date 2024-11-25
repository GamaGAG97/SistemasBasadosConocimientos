

(deffacts productos 
 	(producto (producto_id aa1) (nombre Iphone_16_pro) (categoria smartphone) (marca apple) (precio 25000.99))
 	(producto (producto_id aa2) (nombre Samnsung_galaxy_s24) (categoria electronica) (marca samnsung) (precio 20000.00))
 	(producto (producto_id aa3) (nombre Xbox_series_x) (categoria videojuegos) (marca xbox) (precio 14000.00))
	(producto (producto_id aa4) (nombre PlayStation_5) (categoria videojuegos) (marca playstation) (precio 10000.99))
	(producto (producto_id aa5) (nombre Lenovo_ideapad_slim3) (categoria computo) (marca lenovo) (precio 17100.99))
	(producto (producto_id aa6) (nombre MacBook_Air) (categoria computo) (marca apple) (precio 54000.99))
	(producto (producto_id aa7) (nombre LG_Top_Mount_20) (categoria linea_blanca) (marca lg) (precio 13199.99))
	(producto (producto_id aa8) (nombre Horno_eléctrico_empotrable) (categoria linea_blanca) (marca whirlpool) (precio 32700.99))
	(producto (producto_id aa9) (nombre Audifonos_WH-1000XM5) (categoria audio) (marca sony) (precio 7163.99))
	(producto (producto_id bb1) (nombre Barra_Sonido_SNH5) (categoria audio) (marca lg) (precio 5001.99))
	(producto (producto_id bb2) (nombre Galaxy_Note_21) (categoria smartphone) (marca samnsung) (precio 10000.99))
	(producto (producto_id bb3) (nombre mica_celular) (categoria accesorios) (marca samnsung) (precio 400.99))
	(producto (producto_id bb4) (nombre soporte_celular) (categoria accesorios) (marca samnsung) (precio 800.99))
)

(deffacts clientes
  (cliente (cliente_id aaa1) (nombre joe) (direccion bla bla bla) (telefono 3313073905))
  (cliente (cliente_id aaa2) (nombre mary) (direccion bla bla bla) (telefono 333222345))
  (cliente (cliente_id aaa3) (nombre bob) (direccion bla bla bla) (telefono 331567890)) 
)  	 

(deffacts tarjetas
  (tarjeta (id_tarjeta aaaa1) (banco Santander) (nombre LikeU) (grupo visa) (exp_fecha 11-10-29))
  (tarjeta (id_tarjeta aaaa2) (banco Banamex) (nombre Simplicity) (grupo mastercard) (exp_fecha 05-08-26))
  (tarjeta (id_tarjeta aaaa3) (banco BBVA) (nombre Tarjeta_azul) (grupo visa) (exp_fecha 01-03-29))
  (tarjeta (id_tarjeta aaaa4) (banco Liverpool) (nombre Liverpool) (grupo visa) (exp_fecha 11-10-29))
)


(deffacts ordenes
	;; Fact que dispara los 24 meses en la compra de iphone y pago con banamex, tambien la regla de los descuentos en accesorios, regla minorista
  (orden (orden_id aaaaa1) (tarjeta_id aaaa2) (cliente_id aaa1) (producto_id aa1) (cantidad 2))
	;; Fact que activs los 12 meses en la compra de la galaxy note 21 y pago con liverpool visa, tambien regla de los descuentos accesorios, regla mayorista
  (orden (orden_id aaaaa2) (tarjeta_id aaaa4) (cliente_id aaa2) (producto_id bb2) (cantidad 11))
	;;Facts que disparan la regla 100 de vales por cada 1000 de compra, tambien los descuentos de accesorios, regla minorista
  (orden (orden_id aaaaa3) (tarjeta_id aaaa2) (cliente_id aaa3) (producto_id aa1) (cantidad 1) (tipo_pago contado))
  (orden (orden_id aaaaa3) (tarjeta_id aaaa2) (cliente_id aaa3) (producto_id aa6) (cantidad 1) (tipo_pago contado))
)


