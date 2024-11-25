;;Regla que imprime todas las enfermedades 

(defrule enfermedades
	(enfermedad 
		(nombre ?n)
		(tipo ?t)
		(signos $?signos)
		(sintomas $?sintomas)
	)
	=>
	(printout t "Estas son todas las enfermedades del sistema: " crlf "Nombre: " ?n " Tipo: " ?t " Signos: " ?signos " Sintomas: " ?sintomas crlf)

)

;;Regla que imprime solo las enfermedades bacterianas

(defrule enfermedades_bacterianas
	(enfermedad
		(nombre ?n)
		(tipo ?t&bacterial)
		(signos $?signos)
		(sintomas $?sintomas)
	)
	=>
	(printout t "Estas son las enfermedades bacterianas:" crlf "Nombre: " ?n " Tipo: " ?t " Signos: " ?signos " Sintomas: " ?sintomas crlf)
)

;;Regla que imprime solo las enfermedades virales 

(defrule enfermedades_virales
	(enfermedad
		(nombre ?n)
		(tipo ?t&viral)
		(signos $?signos)
		(sintomas $?sintomas)
	)
	=>
	(printout t "Estas son las enfermedades virales: " crlf "Nombre: " ?n " Tipo: " ?t " Signos: " ?signos " Sintomas: " ?sintomas crlf)
)


;;Regla que elimina de la lista la colera

(defrule eliminar_colera
	?colera_eliminada <- (enfermedad
		(nombre ?n&colera)
	)
	=>
	(retract ?colera_eliminada)
	(printout t "La enfermedad " ?n "Ha sido eliminada" crlf))
)

;;Regla que modifica una enfermedad (campo signo) en este caso covid 19

(defrule actualizar_enfermedad	
	?enfermedad_actualizada <- (enfermedad
		(nombre ?n&covid_19)
	)
	=>
	(modify ?enfermedad_actualizada (signos fiebre_mayor_38_grados))
)

;;Regla para verificar si el nombre de la nueva entrada esta repetido, si esta repetido eliminara la nueva entrada

(defrule verificar_nombre_entrada
	?new_entry_ <- (new_entry ?n ?t ?sig ?sin)
	?enfermedad_ <- (enfermedad(nombre ?n))
	=>
	(printout t "La enfermedad " ?n " ya existe. Se eliminara la nueva entrada..." crlf)
	(retract ?new_entry_)
)

;;Regla para verificar si el nombre de la nueva etrada existe, sino existe la agregara

(defrule agregar_entrada
	?new_entry_ <- (new_entry ?n ?t ?sig ?sin)
	(not (enfermedad(nombre ?n)))
	=>
	(printout t "La enfermedad " ?n " No existe. Se agregara la nueva entrada..." crlf)
	(assert (enfermedad (nombre ?n) (tipo ?t) (signos ?sig) (sintomas ?sin)))
	(retract ?new_entry_)
)