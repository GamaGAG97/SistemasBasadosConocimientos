;; 1) Regla que imprime los clientes

(defrule imprimir_clientes
	(cliente (nombre $?n) (direccion $?dir) (telefono ?tel))
	=>
	(printout t "Cliente: " ?n " Direccion: " ?dir " Telefono: " ?tel crlf)
)

;; 2) Regla que imprime los productos

(defrule imprimir_productos
  	(producto (producto_id ?id) (nombre ?nombre) (categoria ?categoria) (marca ?marca) (precio ?precio) (cantidad ?cantidad))
 	=>
  	(printout t "Producto ID: " ?id " Nombre: " ?nombre " Categoria: " ?categoria " Marca: " ?marca " Precio: " ?precio " Cantidad: " ?cantidad crlf)
)

;; 3) Regla que imprime las tarjetas

(defrule imprimir_tarjetas
	(tarjeta (banco ?banco) (nombre ?nombre) (grupo ?grupo))
	=>
	(printout t "Banco: " ?banco " Tarjeta: " ?nombre " Grupo: " ?grupo crlf)
)

;; 4) Regla que imprime las compras

(defrule imprimir_compras
	(orden (cliente_id ?cliente-id) (producto_id ?producto-id) (tarjeta_id ?tarjeta-id) (bandera 0))
	(cliente (cliente_id ?cliente-id) (nombre $?nombre-cliente))
	(producto (producto_id ?producto-id) (nombre ?nombre-producto))
	(tarjeta (id_tarjeta ?tarjeta-id) (nombre ?nombre-tarjeta))
	=>
	(printout t "Cliente: " ?nombre-cliente " Producto: " ?nombre-producto " Tarjeta: " ?nombre-tarjeta crlf)
)

;; 5) Regla que imprime quien no ha realizado compras

(defrule imprimir_compras_cero
	(cliente (cliente_id ?id) (nombre $?nombre))
	(not (orden (orden_id ?orden_id) (cliente_id ?cliente_id)))
	=>
	(printout t "El cliente " ?nombre " no ha realizado compras" crlf)
)

;; 6) Regla que imprime quien ha realizado compra

(defrule imprimir_quien_compro
	(orden (cliente_id ?cliente-id))
	(cliente (cliente_id ?cliente-id) (nombre $?nombre))	
	=>
	(printout t "El cliente " ?nombre " si ha realizado compras" crlf)
)

;; 7) Regla que imprime que productos han sido comprados y su cantidad

(defrule imprimir_productos_comprados
	(orden (producto_id ?producto-id) (cantidad ?cantidad))
	(producto (producto_id ?producto-id) (nombre ?nombre) (marca ?marca))
	=>
	(printout t ?cantidad " " ?marca "-" ?nombre " ha(n) sido comprado(s)" crlf)
)

;; 8) Regla que imprime que productos no han sido comprados

(defrule imprimir_productos_no_comprados
	(producto (producto_id ?producto-id) (nombre ?nombre) (marca ?marca))
	(not (orden (producto_id ?producto-id)))
	=>
	(printout t "El producto " " " ?marca " " ?nombre " no ha sido comprado!" crlf)
)

;; 9) Regla que imprime que tarjetas han sido utilizadas

(defrule imprimir_tarjetas_usadas
	(orden (tarjeta_id ?tarjeta-id) (bandera 0))
	(tarjeta (id_tarjeta ?tarjeta-id) (nombre ?nombre) (banco ?banco))
	=>
	(printout t "La tarjeta " ?nombre " del banco " ?banco " ha sido usada!" crlf)
)

;; 10) Regla que imprime que tarjetas no han sido utilizadas

(defrule imprimir_tarjetas_no_usadas
	(tarjeta (id_tarjeta ?tarjeta-id) (nombre ?nombre) (banco ?banco))
	(not (orden (tarjeta_id ?tarjeta-id)))
	=>
	(printout t "La tarjeta " ?nombre " del banco " ?banco " no ha sido usada!" crlf)
)

;; 11) Regla que elimina ordenes de compra con articulos iguales o menores a cero

(defrule eliminar_ordenes_con_menos_cero_articulos
	?orden_eliminada <- (orden (orden_id ?orden_id) (cantidad ?cantidad))
	(test (< ?cantidad 1))
	=>
	(printout t "La orden " ?orden_id "sera eliminada porque no puede tener articulos igual o menor a cero!" crlf)
	(retract ?orden_eliminada)
)

;; 12) Regla que elimina productos con precios menores a cero

(defrule eliminar_productos_precios_menores
	?producto_eliminado <- (producto (nombre ?nombre) (precio ?precio))
	(test (< ?precio 1))
	=>
	(printout t "El producto " ?nombre " se ha eliminado porque su precio es bajisimo!" crlf)
	(retract ?producto_eliminado)
)

;; 13) Regla que ofrece 24 meses en la compra de un iphone 16 pro max con tarjetas banamex

(defrule meses_24
	(declare (salience 2))
	(producto (producto_id ?producto-id) (nombre Iphone_16_pro))
	(tarjeta (id_tarjeta ?id-tarjeta) (banco Banamex) (nombre ?nombre))
	(orden (orden_id ?orden_id) (tarjeta_id ?id-tarjeta) (producto_id ?producto-id) (bandera 0))
	=>
	(printout t "ORDEN: " ?orden_id " La compra del Iphone 16 pro puede quedar a 24 meses porque se compro con la tarjeta Banamex (" ?nombre ")" crlf)
)

;; 14) Regla que ofrece 12 meses sin intereses en la compra de un Samsung note 21 con tarjeta liverpool visa

(defrule meses_12
	(declare (salience 1))
	(producto (producto_id ?producto-id) (nombre Galaxy_Note_21) (marca ?marca))
	(tarjeta (id_tarjeta ?id-tarjeta) (banco Liverpool) (grupo visa))
	(orden (orden_id ?orden_id) (tarjeta_id ?id-tarjeta) (producto_id ?producto-id) (bandera 0))
	=>
	(printout t "ORDEN: " ?orden_id " La compra del " ?marca " note 21 puede quedar a 12 meses porque se compro con la tarjeta Liverpool grupo visa" crlf)
)

;; 15) Regla que ofrece 100 pesos de vales por cada 1000 de compra en la compra de una mackBook air y un iphone 16

(defrule vales_x_cada_mil_de_compra
	(orden (orden_id ?orden-id) (producto_id ?producto-id) (tipo_pago contado))
	(orden (orden_id ?orden-id) (producto_id ?producto-id1 &~ ?producto-id) (tipo_pago contado))
	(producto (producto_id ?producto-id) (nombre Iphone_16_pro) (precio ?precio1))
  	(producto (producto_id ?producto-id1) (nombre MacBook_Air) (precio ?precio2))
	=>
	(bind ?suma (+ ?precio1 ?precio2)) 
	(bind ?division (/ ?suma 1000))
	(bind ?resultado (* ?division 100))
  	(printout t "La orden de compra: " ?orden-id " Por la compra del iphone y la macbook tienes " ?resultado " en vales" crlf)	
)

;; 16) Regla que ofrece 15% de descuento sobre accesorios en la compra de un smartphone

(defrule 15_descuento_en_accesorios
	(producto (producto_id ?producto-id) (categoria smartphone))
	(orden (orden_id ?orden-id) (producto_id ?producto-id) (bandera 0))
	(producto (nombre ?nombre) (categoria accesorios))
	=>
	(printout t "La orden de compra: " ?orden-id " Puedes tener el 15% de descuento sobre: " ?nombre crlf)
)

;; 17) Regla que actualiza el stock a 10 pz en caso de que despues de la orden el stock sea menor o igual a cero   

(defrule actualizar_stock
	(orden (producto_id ?producto-id) (cantidad ?cantidad-orden) (bandera 1))
	?producto_actualizado <- (producto (producto_id ?producto-id) (nombre ?nombre) (categoria ?categoria) (marca ?marca) (precio ?precio) (cantidad ?cantidad-producto))
	(test (< ?cantidad-producto ?cantidad-orden))
	=>
	(actualizar_stock ?producto_actualizado)
	(printout t "STOCK ACTUALIZADO... Producto: " ?nombre " a 10 piezas" crlf)	
)

;; 18) Regla que decrementa el stock en cada compra. Se tiene que eliminar dicha orden porque se entra en un loop infinito (ver otras maneras, una flag quiza?)

(defrule dec_stock
	?actualizar_orden <- (orden (producto_id ?producto-id) (cantidad ?cantidad-orden) (bandera 0))
	?producto_actualizado <- (producto (producto_id ?producto-id) (nombre ?nombre) (categoria ?categoria) (marca ?marca) (precio ?precio) (cantidad ?cantidad-producto))
	=>
	(decrementar_stock ?producto_actualizado ?cantidad-producto ?cantidad-orden)
	(modify ?actualizar_orden (bandera 1))
	(printout t "STOCK DECREMENTADO... Producto: " ?nombre crlf)
)

;; 19) Regla que imprime los clientes menudistas

(defrule imprimir_menudistas
	(orden (cliente_id ?cliente-id) (producto_id ?producto-id) (tarjeta_id ?tarjeta-id) (cantidad ?cantidad) (bandera 0))
	(cliente (cliente_id ?cliente-id) (nombre $?nombre-cliente))
	(producto (producto_id ?producto-id) (nombre ?nombre-producto))
	(test (< ?cantidad 10))
	=>
	(printout t "Cliente: " ?nombre-cliente " Producto: " ?nombre-producto " Cantidad: " ?cantidad " MENUDISTA" crlf)
)

;; 20) Regla que imprime los clientes mayoristas

(defrule imprimir_mayoristas
	(orden (cliente_id ?cliente-id) (producto_id ?producto-id) (tarjeta_id ?tarjeta-id) (cantidad ?cantidad) (bandera 0))
	(cliente (cliente_id ?cliente-id) (nombre $?nombre-cliente))
	(producto (producto_id ?producto-id) (nombre ?nombre-producto))
	(test (> ?cantidad 10))
	=>
	(printout t "Cliente: " ?nombre-cliente " Producto: " ?nombre-producto " Cantidad: " ?cantidad " MAYORISTA" crlf)
)

;; Regla que cambia el estado de la orden

(defrule cambiar_estado
	(declare (salience -10))
	?actualizar_orden <- (orden (orden_id ?orden-id))
	=>
	(modify ?actualizar_orden (bandera 1))
)