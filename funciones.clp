(deffunction get-all-instances-of (?class-name)
  (find-all-instances ((?x ?class-name)) TRUE)
)

(deffunction ask-question-yes-no (?question)
  (printout t "| > " ?question crlf "| ")
  (bind ?answer (read))
  (bind ?allowed-values (create$ Yes No yes no Y N y n))
  (while (not (member$ ?answer ?allowed-values)) do
    (printout t "| > " ?question crlf "| ")
    (bind ?answer (read))
  )
  (if (or (eq ?answer Yes) (eq ?answer yes) (eq ?answer Y) (eq ?answer y))
    then TRUE
    else FALSE)
)

(deffunction ask-instance-from-class (?allowed-values ?question)
  (printout t "| > " ?question " " $?allowed-values crlf "| ")
  (bind ?answer (read))
  (while (not (member$ ?answer $?allowed-values)) do
    (printout t "| > " ?question crlf "| ")
    (bind ?answer (read))
  )
  ?answer
)

(deffunction ask-multi-instance-from-class (?allowed-values ?question)
  (printout t "| > " ?question " " $?allowed-values crlf "| ")
  (bind ?line (readline))
  (bind $?answer (explode$ ?line))
  ;; Check if the input is "ninguno"
  (if (eq (nth$ 1 $?answer) ninguno) then
      (return (create$ "ninguno")))
  (bind ?valid FALSE)
  (while (not ?valid) do
    (bind ?valid TRUE) ; Assume valid until proven otherwise
    (loop-for-count (?i 1 (length$ $?answer)) do
      (bind ?value-belongs FALSE)
      (loop-for-count (?j 1 (length$ $?allowed-values)) do
        (if (eq (nth$ ?i $?answer) (nth$ ?j $?allowed-values)) then
          (bind ?value-belongs TRUE)
          (break))
      )
      (if (not ?value-belongs) then
        (printout t "| > " (nth$ ?i $?answer) " is not a valid option" crlf)
        (bind ?valid FALSE)
        (break))
    )
    (if ?valid then (break))
    (printout t "| > " ?question " " $?allowed-values crlf "| ")
    (bind ?line (readline))
    (bind $?answer (explode$ ?line))
    ;; Check again for "ninguno" in the new input
    (if (eq (nth$ 1 $?answer) ninguno) then
        (return (create$ "ninguno")))
  )
  $?answer
)



(deffunction is-num (?num)
  (bind ?ret (or (eq (type ?num) INTEGER) (eq (type ?num) FLOAT)))
  ?ret
)

(deffunction ask-question-num (?question ?min ?max)
  (printout t "| > " ?question)
  (bind ?answer (read))
  (while (not (and (is-num ?answer) (>= ?answer ?min) (<= ?answer ?max))) do
    (printout t "| " ?question)
    (bind ?answer (read)))
  ?answer
)

(deffunction collection-contains-alo-element (?elements ?collection)
  (loop-for-count (?i 1 (length$ $?elements)) do
    (loop-for-count (?j 1 (length$ $?collection)) do
      (if (eq (nth$ ?i ?elements) (nth$ ?j ?collection))
      then (return TRUE))
    )
  )
  FALSE
)

(deffunction elemento-en-lista (?element ?collection)
  (foreach ?ingrediente ?collection
      (if (eq ?element (str-cat ?ingrediente)) then
          (return TRUE)))
)

(deffunction get-TipoComida (?pregunta)
    (printout t ?pregunta crlf)
    (bind $?tipos-comida (get-all-instances-of TipoComidaPlato))
    (ask-multi-instance-from-class $?tipos-comida "Selecciona los tipos de comida preferidos (separados por espacios, o 'ninguno' para omitir): ")
)

(deffunction get-TipoComidaProhibido (?pregunta)
    (printout t ?pregunta crlf)
    (bind ?tipos-comida (get-all-instances-of TipoComidaPlato))
    (ask-multi-instance-from-class ?tipos-comida "Selecciona los tipos de comida prohibidos (separados por espacios, o 'ninguno' para omitir): ")
)

(deffunction get-TipoBebidaProhibido (?pregunta)
    (printout t ?pregunta crlf)
    (bind ?tipos-bebida (get-all-instances-of TipoBebida))
    (ask-multi-instance-from-class ?tipos-bebida "Selecciona los tipos de bebidas prohibidos (separados por espacios, o 'ninguno' para omitir): ")
)

(deffunction get-ingredienteProhibido (?pregunta)
    (printout t ?pregunta crlf)
    (bind ?ingredientes (get-all-instances-of Ingrediente))
    (ask-multi-instance-from-class ?ingredientes "Selecciona los ingredientes prohibidos (separados por espacios, o 'ninguno' para omitir): ")
)

(deffunction get-time (?pregunta)
    (printout t ?pregunta crlf)
    (bind ?meses (get-all-instances-of Mes))
    (ask-instance-from-class ?meses "Selecciona el mes del evento: ")
)

(deffunction is-temperature (?mes)
    (if (member$ ?mes (create$ [Marzo] [Abril] [Mayo])) then
        (return "Primavera")
    else
        (if (member$ ?mes (create$ [Junio] [Julio] [Agosto])) then
            (return "Verano")
        else
            (if (member$ ?mes (create$ [Septiembre] [Octubre] [Noviembre])) then
                (return "Otoño")
            else
                (return "Invierno")
            )
        )
    )
)

(deffunction get-TipoEvento (?pregunta)
    (printout t ?pregunta crlf)
    (bind ?tipos-evento (get-all-instances-of TipoEvento))
    (ask-instance-from-class ?tipos-evento "Selecciona el tipo de evento: ")
)

(deffunction get-num-comensales (?pregunta ?min ?max)
    (ask-question-num ?pregunta ?min ?max)
)

(deffunction get-presupuesto (?pregunta-min ?pregunta-max)
    (bind ?min (ask-question-num ?pregunta-min 0 1000))
    (bind ?max (ask-question-num ?pregunta-max ?min 1000))
    (create$ ?min ?max)
)

(deffunction get-bebidaPorPlato ()
    (printout t "| > Elija una de las siguientes opciones marcando el número de la opción (Ejemplo: 1):" crlf)
    (printout t "1- Una bebida para cada plato" crlf)
    (printout t "2- Una bebida general para todo el menú" crlf)
    (printout t crlf "| ")
    (bind ?answer (read))
    (bind $?allowed-values (create$ 1 2))
    (while (not (member$ ?answer $?allowed-values)) do
      (printout t "| > Elija una de las siguientes opciones marcando el número de la opción (Ejemplo: 1):" crlf)
      (printout t "1- Una bebida para cada plato" crlf)
      (printout t "2- Una bebida general para todo el menú" crlf)
      (printout t "| ")
      (bind ?answer (read))
    )
    ?answer
)

(deffunction get-price (?precios)
   (bind ?total 0)
   (foreach ?precio ?precios
      (bind ?total (+ ?total ?precio)))
   ?total)


(deffunction recolectar-restricciones ()
    (make-instance [EventoUsuario] of Evento)
    (make-instance [RestriccionesUsuario] of Restriccion)
    (bind ?tipos-comida (get-TipoComida "¿Qué tipo de comida prefieres para el menú? (e.g., Vegano, Español)"))
    (if (neq ?tipos-comida (create$ "ninguno")) then
        (send [RestriccionesUsuario] put-esDeTipoComida ?tipos-comida))
    (bind ?tipos-comida-prohibidos (get-TipoComidaProhibido "¿Qué tipos de comida deseas prohibir? (e.g., Vegano, Español)"))
    (if (neq ?tipos-comida-prohibidos (create$ "ninguno")) then
        (send [RestriccionesUsuario] put-prohibeTipoComida ?tipos-comida-prohibidos))
    (bind ?ingredientes-prohibidos (get-ingredienteProhibido "¿Qué ingredientes están prohibidos?"))
    (if (neq ?ingredientes-prohibidos (create$ "ninguno")) then
        (send [RestriccionesUsuario] put-prohibeIngrediente ?ingredientes-prohibidos))
    (bind ?mes (get-time "¿En qué mes se celebra el evento?"))
    (bind ?tipos-bebidas-prohibidas (get-TipoBebidaProhibido "¿Qué tipos de bebida deseas prohibir? (e.g., Alcohol, Zumo)"))
    (if (neq ?tipos-bebidas-prohibidas (create$ "ninguno")) then
        (send [RestriccionesUsuario] put-prohibeTipoBebida ?tipos-bebidas-prohibidas))
    (bind ?bebida-por-plato (get-bebidaPorPlato))
    (if (eq ?bebida-por-plato 1) then
       (send [RestriccionesUsuario] put-bebidaParaCadaPlato TRUE)
    else
       (send [RestriccionesUsuario] put-bebidaParaCadaPlato FALSE))
    (send [EventoUsuario] put-tieneMes ?mes)
    (bind ?tipo-evento (get-TipoEvento "¿Qué tipo de evento es? (e.g., Familiar, Congreso)"))
    (send [EventoUsuario] put-tieneTipoEvento ?tipo-evento)
    (bind ?comensales (get-num-comensales "¿Cuántos comensales asistirán? [Mínimo 1] [Máximo 1000] " 1 1000))
    (send [EventoUsuario] put-numeroComensales ?comensales)
    (bind ?presupuesto (get-presupuesto "¿Cuál es el presupuesto mínimo por menú? " "¿Cuál es el presupuesto máximo por menú? "))
    (send [RestriccionesUsuario] put-condicionPrecioMin (nth$ 1 ?presupuesto))
    (send [RestriccionesUsuario] put-condicionPrecioMax (nth$ 2 ?presupuesto))
    (create$ [EventoUsuario] [RestriccionesUsuario])
)

(deffunction elegir-menu-una-bebida (?min ?max ?e)
  (bind ?resultado FALSE)
  (foreach ?m (find-all-instances ((?m Menu)) TRUE)
    (if (and
      (>= (send ?m get-precio) ?min)
      (< (send ?m get-precio) ?max)
      (eq ?resultado FALSE))
      then
        (printout t crlf)
        (printout t "===== Información del Menú de coste " ?e " =====" crlf)
        (printout t "Primer Plato: " (send (send ?m get-tienePrimerPlato) get-nombre) crlf)
        (printout t "Segundo Plato: " (send (send ?m get-tieneSegundoPlato) get-nombre) crlf)
        (printout t "Postre: " (send (send ?m get-tienePostre) get-nombre) crlf)
        (printout t "Bebida: " (send (send ?m get-tieneBebida) get-nombre) crlf)
        (printout t "Precio total: " (send ?m get-precio) crlf)
        (printout t "===============================" crlf crlf)
        (bind ?resultado TRUE)))
    (if (eq ?resultado FALSE)
      then
      (printout t crlf)
      (printout t "===== Información del Menú de coste " ?e " =====" crlf)
      (printout t "No se ha encontrado un plato de coste bajo" crlf)
      (printout t "===============================" crlf crlf))
    )

(defglobal
  ?*TIPO_EVENTO* = (get-all-instances-of TipoEvento)
  ?*TIPO_BEBIDA* = (get-all-instances-of TipoBebida)
  ?*TIPO_COMIDA* = (get-all-instances-of TipoComidaPlato)
  ?*TIPO_INGREDIENTE* = (get-all-instances-of TipoIngrediente)
  ?*MESES* = (get-all-instances-of Mes)
)

