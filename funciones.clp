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

(deffunction get-TipoComida (?pregunta)
    (printout t ?pregunta crlf)
    (bind ?tipos-comida (get-all-instances-of TipoComidaPlato))
    (ask-multi-instance-from-class ?tipos-comida "Selecciona los tipos de comida preferidos (separados por espacios, o 'ninguno' para omitir): ")
)

(deffunction get-TipoComidaProhibido (?pregunta)
    (printout t ?pregunta crlf)
    (bind ?tipos-comida (get-all-instances-of TipoComidaPlato))
    (ask-multi-instance-from-class ?tipos-comida "Selecciona los tipos de comida prohibidos (separados por espacios, o 'ninguno' para omitir): ")
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

(deffunction get-price-menu (?menu)
    (bind ?precio 0)
    (bind ?primer-plato (send ?menu get-tienePrimerPlato))
    (bind ?segundo-plato (send ?menu get-tieneSegundoPlato))
    (bind ?postre (send ?menu get-tienePostre))
    (bind ?bebida (send ?menu get-tieneBebida))
    (if (and (instancep ?primer-plato) (instance-existp ?primer-plato)) then
        (bind ?p1-precio (send ?primer-plato get-precio))
        (bind ?precio (+ ?precio ?p1-precio))
        (printout t "Adding PrimerPlato price: " ?p1-precio ", Total: " ?precio crlf)
    else
        (printout t "Debug: PrimerPlato = " ?primer-plato ", Is instance? " (instancep ?primer-plato) ", Class: " (class ?primer-plato) crlf)
        (printout t "Skipping PrimerPlato: Not a valid instance" crlf))
    (if (and (instancep ?segundo-plato) (instance-existp ?segundo-plato)) then
        (bind ?p2-precio (send ?segundo-plato get-precio))
        (bind ?precio (+ ?precio ?p2-precio))
        (printout t "Adding SegundoPlato price: " ?p2-precio ", Total: " ?precio crlf)
    else
        (printout t "Debug: SegundoPlato = " ?segundo-plato ", Is instance? " (instancep ?segundo-plato) ", Class: " (class ?segundo-plato) crlf)
        (printout t "Skipping SegundoPlato: Not a valid instance" crlf))
    (if (and (instancep ?postre) (instance-existp ?postre)) then
        (bind ?p3-precio (send ?postre get-precio))
        (bind ?precio (+ ?precio ?p3-precio))
        (printout t "Adding Postre price: " ?p3-precio ", Total: " ?precio crlf)
    else
        (printout t "Debug: Postre = " ?postre ", Is instance? " (instancep ?postre) ", Class: " (class ?postre) crlf)
        (printout t "Skipping Postre: Not a valid instance" crlf))
    (if (and (instancep ?bebida) (instance-existp ?bebida)) then
        (bind ?b-precio (send ?bebida get-precio))
        (bind ?precio (+ ?precio ?b-precio))
        (printout t "Adding Bebida price: " ?b-precio ", Total: " ?precio crlf)
    else
        (printout t "Debug: Bebida = " ?bebida ", Is instance? " (instancep ?bebida) ", Class: " (class ?bebida) crlf)
        (printout t "Skipping Bebida: Not a valid instance" crlf))
    (printout t "Final Total: " ?precio crlf)
    ?precio)


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
    (send [EventoUsuario] put-tieneMes ?mes)
    (bind ?tipo-evento (get-TipoEvento "¿Qué tipo de evento es? (e.g., Familiar, Congreso)"))
    (send [EventoUsuario] put-tieneTipoEvento ?tipo-evento)
    (bind ?comensales (get-num-comensales "¿Cuántos comensales asistirán?" 1 1000))
    (send [EventoUsuario] put-numeroComensales ?comensales)
    (bind ?presupuesto (get-presupuesto "¿Cuál es el presupuesto mínimo por menú?" "¿Cuál es el presupuesto máximo por menú?"))
    (send [RestriccionesUsuario] put-condicionPrecioMin (nth$ 1 ?presupuesto))
    (send [RestriccionesUsuario] put-condicionPrecioMax (nth$ 2 ?presupuesto))
    (create$ [EventoUsuario] [RestriccionesUsuario])
)

(defglobal
  ?*TIPO_EVENTO* = (get-all-instances-of TipoEvento)
  ?*TIPO_BEBIDA* = (get-all-instances-of TipoBebida)
  ?*TIPO_COMIDA* = (get-all-instances-of TipoComidaPlato)
  ?*TIPO_INGREDIENTE* = (get-all-instances-of TipoIngrediente)
  ?*MESES* = (get-all-instances-of Mes)
)