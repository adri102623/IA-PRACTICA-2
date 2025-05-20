;;; Regla para filtrar platos por tipo de comida
(defrule filtrar-por-tipo-comida
    (object (is-a Restriccion) 
            (esDeTipoComida $?tipos-comida&:(neq ?tipos-comida (create$))) 
            (prohibeTipoComida $?prohibidos))
    (object (is-a Plato) (nombre ?nombre) (esDeTipoComida $?tipos-plato))
    (test (collection-contains-alo-element ?tipos-comida ?tipos-plato))
    (test (not (collection-contains-alo-element ?prohibidos ?tipos-plato)))
    =>
    (printout t "Plato válido por tipo de comida: " ?nombre crlf))

;;; Regla para excluir platos con ingredientes prohibidos
(defrule excluir-por-ingrediente-prohibido
    (object (is-a Restriccion) (prohibeIngrediente $?prohibidos&:(neq ?prohibidos (create$))))
    (object (is-a Plato) (nombre ?nombre) (tieneIngredientes $?ingredientes))
    (test (collection-contains-alo-element ?prohibidos ?ingredientes))
    =>
    (printout t "Excluyendo " ?nombre " por contener ingredientes prohibidos." crlf))

;;; Regla para filtrar por estacionalidad
(defrule filtrar-por-estacionalidad
    (object (is-a Evento) (tieneMes ?mes))
    (object (is-a Plato) (nombre ?nombre) (disponibleEn $?meses))
    (test (member$ ?mes ?meses))
    =>
    (printout t "Plato válido por estacionalidad: " ?nombre crlf))

;;; Regla para filtrar por temperatura según estación
(defrule filtrar-por-temperatura
    (object (is-a Evento) (tieneMes ?mes))
    (object (is-a Plato) (nombre ?nombre) (esDeTipoComida $?tipos))
    (test (or 
        (and (eq (is-temperature ?mes) "Primavera") (member$ [Frio] ?tipos))
        (and (eq (is-temperature ?mes) "Verano") (member$ [Frio] ?tipos))
        (and (eq (is-temperature ?mes) "Otoño") (member$ [Caliente] ?tipos))
        (and (eq (is-temperature ?mes) "Invierno") (member$ [Caliente] ?tipos))))
    =>
    (printout t "Plato válido por temperatura: " ?nombre crlf))

;;; Regla para filtrar por tipo de evento (Congreso → Moderno)
(defrule filtrar-por-tipo-evento
    (object (is-a Evento) (tieneTipoEvento [Congreso]))
    (object (is-a Plato) (nombre ?nombre) (esDeTipoComida $?tipos))
    (test (member$ [Moderno] ?tipos))
    =>
    (printout t "Plato válido para Congreso (moderno): " ?nombre crlf))

;;; Regla para filtrar por dificultad según comensales
(defrule filtrar-por-dificultad
    (object (is-a Evento) (numeroComensales ?comensales&:(>= ?comensales 500)))
    (object (is-a Plato) (nombre ?nombre) (dificultad ?d&:(<= ?d 2)))
    =>
    (printout t "Plato válido por baja dificultad: " ?nombre crlf))

;;; Regla para generar menús compatibles
(defrule generar-menu
    (object (is-a Evento) (tieneMes ?mes) (tieneTipoEvento ?evento) (numeroComensales ?comensales))
    (object (is-a Restriccion) (esDeTipoComida $?tipos-comida) (prohibeIngrediente $?prohibidos)
            (prohibeTipoComida $?prohibidos-tipo) (condicionPrecioMin ?min) (condicionPrecioMax ?max))
    ?p1 <- (object (is-a PrimerPlato) (disponibleEn $?meses1) (esAdecuadoParaEvento $?eventos1)
                   (esDeTipoComida $?tipos1) (tieneIngredientes $?ing1) (dificultad ?d1) (esCompatibleCon $?comp1))
    ?p2 <- (object (is-a SegundoPlato) (disponibleEn $?meses2) (esAdecuadoParaEvento $?eventos2)
                   (esDeTipoComida $?tipos2) (tieneIngredientes $?ing2) (dificultad ?d2) (esCompatibleCon $?comp2))
    ?p3 <- (object (is-a Postre) (disponibleEn $?meses3) (esAdecuadoParaEvento $?eventos3)
                   (esDeTipoComida $?tipos3) (tieneIngredientes $?ing3) (dificultad ?d3) (esCompatibleCon $?comp3))
    ?b <- (object (is-a Bebida) (esCompatibleCon $?compb))
    (test (member$ ?mes ?meses1))
    (test (member$ ?mes ?meses2))
    (test (member$ ?mes ?meses3))
    (test (member$ ?evento ?eventos1))
    (test (member$ ?evento ?eventos2))
    (test (member$ ?evento ?eventos3))
    (test (or (eq ?tipos-comida (create$)) (collection-contains-alo-element ?tipos-comida ?tipos1)))
    (test (or (eq ?tipos-comida (create$)) (collection-contains-alo-element ?tipos-comida ?tipos2)))
    (test (or (eq ?tipos-comida (create$)) (collection-contains-alo-element ?tipos-comida ?tipos3)))
    (test (not (collection-contains-alo-element ?prohibidos-tipo ?tipos1)))
    (test (not (collection-contains-alo-element ?prohibidos-tipo ?tipos2)))
    (test (not (collection-contains-alo-element ?prohibidos-tipo ?tipos3)))
    (test (or (eq ?prohibidos (create$)) (not (collection-contains-alo-element ?prohibidos ?ing1))))
    (test (or (eq ?prohibidos (create$)) (not (collection-contains-alo-element ?prohibidos ?ing2))))
    (test (or (eq ?prohibidos (create$)) (not (collection-contains-alo-element ?prohibidos ?ing3))))
    (test (or (< ?comensales 500) (<= ?d1 2)))
    (test (or (< ?comensales 500) (<= ?d2 2)))
    (test (or (< ?comensales 500) (<= ?d3 2)))
    (test (member$ ?p2 ?comp1))
    (test (member$ ?p3 ?comp1))
    (test (member$ ?b ?comp1))
    (test (member$ ?p1 ?comp2))
    (test (member$ ?p3 ?comp2))
    (test (member$ ?b ?comp2))
    (test (member$ ?p1 ?comp3))
    (test (member$ ?p2 ?comp3))
    (test (member$ ?b ?comp3))
    (test (member$ ?p1 ?compb))
    (test (member$ ?p2 ?compb))
    (test (member$ ?p3 ?compb))
    (test (and (>= (get-price-menu (make-instance of Menu
                                          (tienePrimerPlato ?p1)
                                          (tieneSegundoPlato ?p2)
                                          (tienePostre ?p3)
                                          (tieneBebida ?b))) ?min)
               (<= (get-price-menu (make-instance of Menu
                                          (tienePrimerPlato ?p1)
                                          (tieneSegundoPlato ?p2)
                                          (tienePostre ?p3)
                                          (tieneBebida ?b))) ?max)))
    =>
    (bind ?menu (make-instance of Menu
                    (tienePrimerPlato ?p1)
                    (tieneSegundoPlato ?p2)
                    (tienePostre ?p3)
                    (tieneBebida ?b)
                    (precio (get-price-menu (make-instance of Menu
                                            (tienePrimerPlato ?p1)
                                            (tieneSegundoPlato ?p2)
                                            (tienePostre ?p3)
                                            (tieneBebida ?b))))
                    (puntuacion 0.9)))
    (printout t "Menú generado: " (send ?p1 get-nombre) ", " (send ?p2 get-nombre) ", " (send ?p3 get-nombre) ", " (send ?b get-nombre) ", Precio: " (send ?menu get-precio) crlf))