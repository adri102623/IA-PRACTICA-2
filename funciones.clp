(deffunction get-all-instances-of (?class-name)
  (bind $?results (create$))
  (do-for-all-instances ((?x ?class-name)) TRUE
    (bind $?results (create$ $?results ?x))
  )
  $?results
)

(defglobal
  ?*TIPO_EVENTO* = (get-all-instances-of TipoEvento)
  ?*TIPO_BEBIDA* = (get-all-instances-of TipoBebida)
  ?*TIPO_COMIDA* = (get-all-instances-of TipoComidaPlato)
  ?*TIPO_INGREDIENTE* = (get-all-instances-of TipoIngrediente)
  ?*MESES* = (get-all-instances-of Mes)
)


; Pregunta de sí/no
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

; Pregunta con opciones obtenidas de instancias de una clase
(deffunction ask-instance-from-class (?question ?class-name)
  (bind $?allowed-values (get-all-instances-of ?class-name))
  (printout t "| > " ?question " " $?allowed-values crlf "| ")
  (bind ?answer (read))
  (while (not (member$ ?answer $?allowed-values)) do
    (printout t "| > " ?question crlf "| ")
    (bind ?answer (read))
  )
  ?answer
)

; Pregunta con múltiples respuestas, también usando instancias de una clase
(deffunction ask-multi-instance-from-class (?question ?class-name)
  (bind $?allowed-values (get-all-instances-of ?class-name))
  (printout t "| > " ?question " " $?allowed-values crlf "| ")
  (bind ?line (readline))
  (bind $?answer (explode$ ?line))
  (bind ?valid FALSE)
  (while (not ?valid) do
    (loop-for-count (?i 1 (length$ $?answer)) do
      (bind ?valid FALSE)
      (bind ?value-belongs FALSE)
      (loop-for-count (?j 1 (length$ $?allowed-values)) do
        (if (eq (nth$ ?i $?answer) (nth$ ?j $?allowed-values)) then
          (bind ?value-belongs TRUE)
          (break))
      )
      (if (not ?value-belongs) then
        (printout t "| > " (nth$ ?i $?answer) " is not a valid option" crlf)
        (break))
      (bind ?valid TRUE)
    )
    (if ?valid then (break))
    (printout t "| > " ?question crlf "| ")
    (bind ?line (readline))
    (bind $?answer (explode$ ?line))
  )
  $?answer
)

; Pregunta una fecha con formato día mes
(deffunction ask-question-date-format (?question)
  (printout t "| > " ?question crlf "| ")
  (while TRUE do
    (bind ?date (readline))
    (bind $?answer (explode$ ?date))
    (if (not (eq (length$ ?answer) 2)) then
      (printout t "| > Incorrect format, date should have the format DD MM" crlf "| ")
    else (if (and
      (and (>= (nth$ 1 ?answer) 1) (<= (nth$ 1 ?answer) 31))
      (and (>= (nth$ 2 ?answer) 1) (<= (nth$ 2 ?answer) 12)))
    then (break)
    else (printout t "| > Check that date is valid" crlf "| ")))
  )
  ?answer
)

; Pregunta un número dentro de un rango
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
  (loop-for-count (?i 1 (length$ ?elements)) do
    (loop-for-count (?j 1 (length$ ?collection)) do
      (if (eq (nth$ ?i ?elements) (nth$ ?j ?collection))
      then (return TRUE))
    )
  )
  FALSE
)

(deffunction collection-contains-all-elements (?elements ?collection)
  (loop-for-count (?i 1 (length$ ?elements)) do
    (bind ?found FALSE)
    (loop-for-count (?j 1 (length$ ?collection)) do
      (if (eq (nth$ ?i ?elements) (nth$ ?j ?collection)) then
        (bind ?found TRUE)
        (break)
      )
    )
    (if (not ?found) then (return FALSE))
  )
  TRUE
)

(deffunction calculate-price-drinks ($?bebidas)
  (bind ?precio-total 0.0)
  (loop-for-count (?i 1 (length$ $?bebidas)) do
    (bind ?precio-total (+ ?precio-total (send (nth$ ?i $?bebidas) get-precio)))
  )
  ?precio-total
)

