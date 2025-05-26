;;; Mensaje de inicio para el usuario.
(defrule mensaje-de-bienvenida "Mensaje inicial del programa"
    (declare (salience 0))
    =>
    (printout t "[Mensaje inicial]" crlf crlf)                                
)

;;; Recopilar la información:

(defrule iniciar-recoleccion-automatica
  (declare (salience -1))
  =>
    (recolectar-restricciones)
)

(defrule crear-menus-una-bebida
    (declare (salience -3))
    (object (is-a Restriccion)
            (bebidaParaCadaPlato ?bebida-por-plato&:(eq ?bebida-por-plato FALSE))
            (condicionPrecioMin ?min)
            (condicionPrecioMax ?max))
    =>
    (bind ?limite1 (+ ?min (/ (- ?max ?min) 3)))
    (bind ?limite2 (+ ?limite1 (/ (- ?max ?min) 3)))
    ;(printout t "limite1: " ?limite1 crlf)
    ;(printout t "limite2: " ?limite2 crlf)
    (elegir-menu-una-bebida ?min ?limite1 "bajo")
    (elegir-menu-una-bebida ?limite1 ?limite2 "medio")
    (elegir-menu-una-bebida ?limite2 ?max "alto")
)

(defrule crear-menus-multiples-bebidas
    (declare (salience -3))
    (object (is-a Restriccion)
            (bebidaParaCadaPlato ?bebida-por-plato&:(eq ?bebida-por-plato TRUE))
            (condicionPrecioMin ?min)
            (condicionPrecioMax ?max))
    =>
    (bind ?limite1 (+ ?min (/ (- ?max ?min) 3)))
    (bind ?limite2 (+ ?limite1 (/ (- ?max ?min) 3)))
    (printout t "limite1: " ?limite1 crlf)
    (printout t "limite2: " ?limite2 crlf)
    (elegir-menu-multiples-bebida ?min ?limite1 "bajo")
    (elegir-menu-multiples-bebida ?limite1 ?limite2 "medio")
    (elegir-menu-multiples-bebida ?limite2 ?max "alto")
)

;;; Regla para filtrar platos por tipo de comida favorito
(defrule filtrar-por-tipo-comida-favorito "Descarta instancias de Plato que no sean del estilo que el usuario haya elegido"
    (object (is-a Restriccion)
            (esDeTipoComida $?tipos-comida&:(neq ?tipos-comida (create$))))
    ?plato <- (object (is-a Plato)
            (nombre ?nombre)
            (esDeTipoComida $?tipos-plato))
    (test (not (collection-contains-alo-element ?tipos-comida ?tipos-plato)))
    =>
    (printout t "El plato " ?nombre " Ha sido eliminado debido a que no cumplia las preferencias culinarias del usuario." crlf)
    (send ?plato delete))

;;; Regla para filtrar platos por tipo de comida favorito
(defrule filtrar-por-tipo-comida-prohibido "Descarta instancias de Plato que no sean del estilo que el usuario haya elegido"
    (object (is-a Restriccion)
            (prohibeTipoComida $?prohibidos&:(neq ?prohibidos (create$))))
    ?plato <- (object (is-a Plato)
            (nombre ?nombre)
            (esDeTipoComida $?tipos-plato))
    (test (collection-contains-alo-element ?prohibidos ?tipos-plato))
    =>
    (printout t "El plato " ?nombre " Ha sido eliminado debido a que no cumplia las preferencias culinarias del usuario." crlf)
    (send ?plato delete))


;;; Regla para excluir platos con ingredientes prohibidos
(defrule filtrar-por-ingrediente-prohibido "Descarta platos si contienen ingredientes que están prohibidos"
    (object (is-a Restriccion)
            (prohibeIngrediente $?prohibidos&:(neq ?prohibidos (create$))))
    ?plato <- (object (is-a Plato) (nombre ?nombre) (tieneIngredientes $?ingredientes))
    (test (collection-contains-alo-element ?prohibidos ?ingredientes))
    =>
    (printout t "Excluyendo " ?nombre " por contener ingredientes prohibidos." crlf)
    (send ?plato delete))


(defrule filtrar-bebidas-por-tipo "Descarta bebidas si son del mismo tipo prohibido por el usuario"
    (object (is-a Restriccion)
            (prohibeTipoBebida $?prohibidos&:(neq ?prohibidos (create$))))
    ?bebida <- (object (is-a Bebida)
            (nombre ?nombre)
            (tieneTipoBebida $?tipo-bebida))
    (test (collection-contains-alo-element ?prohibidos ?tipo-bebida))
    =>
    (printout t "Excluyendo " ?nombre " por contener ingredientes prohibidos." crlf)
    (send ?bebida delete))

;;; Regla para filtrar por estacionalidad
(defrule filtrar-por-estacionalidad "Descarta instancias de Plato que no sean propios de la temporada del evento"
    (object (is-a Evento)
            (tieneMes ?mes-evento))
    ?plato <- (object (is-a Plato)
            (nombre ?nombre-plato)
            (tieneIngredientes $?ingredientes-plato))  
    ?i <- (object (is-a Ingrediente)
            (nombre ?nombre-ingrediente)
            (disponibleEn $?meses-ingrediente))
    (test (not (member$ ?mes-evento $?meses-ingrediente)))
    (test (elemento-en-lista ?nombre-ingrediente $?ingredientes-plato))
    =>
    (printout t "El plato " ?nombre-plato " Ha sido eliminado debido a que el ingrediente " ?nombre-ingrediente " no se puede obtener en este mes" crlf)
    (send ?plato delete)
    
)


;;; Regla para filtrar por tipo de evento 
(defrule filtrar-por-tipo-evento
    (object (is-a Evento)
            (tieneTipoEvento ?e))
    ?plato <- (object (is-a Plato)
            (nombre ?nombre-plato)
            (esAdecuadoParaEvento $?tipos))
    (test (not (member$ ?e ?tipos)))
    =>
    (printout t "El plato " ?nombre-plato " Ha sido eliminado porque no es adeucado para el evento" crlf)
    (send ?plato delete))

;;; Regla para filtrar por dificultad según comensales
(defrule filtrar-por-dificultad
    (object (is-a Evento) (numeroComensales ?comensales&:(>= ?comensales 500)))
    ?p <- (object (is-a Plato) (nombre ?nombre) (dificultad ?d&:(> ?d 2)))
    =>
    (printout t "El plato " ?nombre " Ha sido eliminado porque es muy complicado para el número de comensales" crlf)
    (send ?p delete))

(defrule generar-menus-con-una-bebida "Genera un menú con una bebida por menú"
    (declare (salience -2))
    (object (is-a Restriccion)
            (condicionPrecioMin ?min)
            (condicionPrecioMax ?max)
            (bebidaParaCadaPlato ?bebida-por-plato&:(eq ?bebida-por-plato FALSE)))
    ?p1 <- (object (is-a PrimerPlato)
                    (nombre ?n1)
                    (esIncompatibleCon $?comp1)
                    (precio ?precio1))
    ?p2 <- (object (is-a SegundoPlato)
                    (nombre ?n2)
                    (esIncompatibleCon $?comp2)
                    (precio ?precio2))
    ?p3 <- (object (is-a Postre)
                    (nombre ?n3)
                    (esIncompatibleCon $?comp3)
                    (precio ?precio3))
    ?b <- (object (is-a Bebida)
                  (nombre ?bn)
                  (esIncompatibleCon $?compb)
                  (precio ?preciob))
    (test (not (eq ?n1 ?n2)))
    (test (not (elemento-en-lista ?n2 $?comp1)))
    (test (not (elemento-en-lista ?n3 $?comp1)))
    (test (not (elemento-en-lista ?bn $?comp1)))
    (test (not (elemento-en-lista ?n1 $?comp2)))
    (test (not (elemento-en-lista ?n3 $?comp2)))
    (test (not (elemento-en-lista ?bn $?comp2)))
    (test (not (elemento-en-lista ?n1 $?comp3)))
    (test (not (elemento-en-lista ?n2 $?comp3)))
    (test (not (elemento-en-lista ?bn $?comp3)))
    (test (not (elemento-en-lista ?n1 $?compb)))
    (test (not (elemento-en-lista ?n2 $?compb)))
    (test (not (elemento-en-lista ?n3 $?compb)))
    (test (and
        (>= (get-price(create$ ?precio1 ?precio2 ?precio3 ?preciob)) ?min)
        (<= (get-price(create$ ?precio1 ?precio2 ?precio3 ?preciob)) ?max)))
    =>
    (bind ?menu (make-instance of Menu
                    (tienePrimerPlato ?p1)
                    (tieneSegundoPlato ?p2)
                    (tienePostre ?p3)
                    (tieneBebida (create$ ?b))
                    (precio (get-price (create$ ?precio1 ?precio2 ?precio3 ?preciob)))
                    (puntuacion 0.9))))


(defrule generar-menu-con-varias-bebidas "Genera un menú con una bebida por plato"
    (declare (salience -2))
    (object (is-a Restriccion)
            (condicionPrecioMin ?min)
            (condicionPrecioMax ?max)
            (bebidaParaCadaPlato ?bebida-por-plato&:(eq ?bebida-por-plato TRUE)))
    ?p1 <- (object (is-a PrimerPlato)
                    (nombre ?n1)
                    (esIncompatibleCon $?comp1)
                    (precio ?precio1))
    ?p2 <- (object (is-a SegundoPlato)
                    (nombre ?n2)
                    (esIncompatibleCon $?comp2)
                    (precio ?precio2))
    ?p3 <- (object (is-a Postre)
                    (nombre ?n3)
                    (esIncompatibleCon $?comp3)
                    (precio ?precio3))
    ?b1 <- (object (is-a Bebida)
                  (nombre ?bn1)
                  (esIncompatibleCon $?compb1)
                  (precio ?preciob1))
    ?b2 <- (object (is-a Bebida)
                  (nombre ?bn2)
                  (esIncompatibleCon $?compb2)
                  (precio ?preciob2))
    ?b3 <- (object (is-a Bebida)
                  (nombre ?bn3)
                  (esIncompatibleCon $?compb3)
                  (precio ?preciob3))
    (test (not (eq ?n1 ?n2)))
    (test (not (eq ?b1 ?b2)))
    (test (not (eq ?b1 ?b3)))
    (test (not (eq ?b2 ?b3)))
    ; Comprobaciones Plato 1 [Primero] 
    (test (not (elemento-en-lista ?n1 $?comp2)))
    (test (not (elemento-en-lista ?n1 $?comp3)))   
    (test (not (elemento-en-lista ?n1 $?compb1)))
    (test (not (elemento-en-lista ?bn1 $?comp1)))
    (test (not (elemento-en-lista ?bn2 $?comp1)))
    (test (not (elemento-en-lista ?bn3 $?comp1)))



    ; Comprobaciones Plato 2 [Segundo] 
    (test (not (elemento-en-lista ?n2 $?comp1)))
    (test (not (elemento-en-lista ?n2 $?comp3)))
    (test (not (elemento-en-lista ?n2 $?compb2)))
    (test (not (elemento-en-lista ?bn2 $?comp2)))
    (test (not (elemento-en-lista ?bn1 $?comp2)))
    (test (not (elemento-en-lista ?bn3 $?comp2)))


    ; Comprobaciones Plato 3 [Postre] 
    (test (not (elemento-en-lista ?n3 $?comp1)))
    (test (not (elemento-en-lista ?n3 $?comp2)))
    (test (not (elemento-en-lista ?n3 $?compb3)))
    (test (not (elemento-en-lista ?bn3 $?comp3)))
    (test (not (elemento-en-lista ?bn2 $?comp2)))
    (test (not (elemento-en-lista ?bn1 $?comp2)))
    (test (and
        (>= (get-price(create$ ?precio1 ?precio2 ?precio3 ?preciob1 ?preciob2 ?preciob3)) ?min)
        (<= (get-price(create$ ?precio1 ?precio2 ?precio3 ?preciob1 ?preciob2 ?preciob3)) ?max)))
    =>
    (bind ?menu (make-instance of Menu
                    (tienePrimerPlato ?p1)
                    (tieneSegundoPlato ?p2)
                    (tienePostre ?p3)
                    (tieneBebida (create$ ?b1 ?b2 ?b3))
                    (precio (get-price (create$ ?precio1 ?precio2 ?precio3 ?preciob1 ?preciob2 ?preciob3)))
                    (puntuacion 0.9)))
    ; (printout t crlf "========== Menú Generado ==========" crlf)
    ; (printout t "Primer Plato: " (send ?p1 get-nombre) crlf)
    ; (printout t "Bebida acompañante: " (send ?b1 get-nombre) crlf crlf)
    ; (printout t "Segundo Plato: " (send ?p2 get-nombre) crlf)
    ; (printout t "Bebida acompañante: " (send ?b2 get-nombre) crlf crlf)
    ; (printout t "Postre: " (send ?p3 get-nombre) crlf)
    ; (printout t "Bebida acompañante: " (send ?b3 get-nombre) crlf)
    ; (printout t "===================================" crlf)
)