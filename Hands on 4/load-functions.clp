;; Funcion que actualiza el stock

(deffunction actualizar_stock (?producto_actualizado)
	(modify ?producto_actualizado (cantidad 10))
) 

;; Funcion que decrementa el stock

(deffunction decrementar_stock (?producto_actualizado ?cantidad-producto ?cantidad-orden)
	(bind ?resultado (- ?cantidad-producto ?cantidad-orden))
	(modify ?producto_actualizado (cantidad ?resultado))
)


(deffunction test_ (?producto_actualizado ?cantidad-producto ?cantidad-orden)
	(bind ?resultado (- ?cantidad-producto ?cantidad-orden))
	(modify ?producto_actualizado (cantidad ?resultado))
)
 