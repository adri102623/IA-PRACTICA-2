;;; ---------------------------------------------------------
;;; ricorico1.clp
;;; Translated by owl2clips
;;; Translated to CLIPS from ontology /Users/daniela/Desktop/ricorico1.ttl
;;; :Date 18/05/2025 01:51:23

(defclass Alimento "Clase abstracta que representa cualquier alimento comestible dentro de un men. Tiene como subclases Plato y Bebida."
    (is-a USER)
    ;;;(role abstract)
    (role concrete)
    (pattern-match reactive)
    ;;; Relación simétrica que indica si un Alimento es compatible con otro en un menú.
    (multislot esIncompatibleCon
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Nombre identificativo del alimento o ingrediente.
    (slot nombre
        (type STRING)
        (create-accessor read-write))
    ;;; Precio individual de un plato, bebida o ingrediente.
    (slot precio
        (type FLOAT)
        (create-accessor read-write))
)

(defclass Bebida "Subclase de Alimento que representa una bebida. Se le awsocia un tipo (TipoBebida) y puede ser compatible con ciertos platos."
    (is-a Alimento)
    (role concrete)
    (pattern-match reactive)
    ;;; Relación entre una Bebida y su clasificación en TipoBebida.
    (multislot tieneTipoBebida
        (type INSTANCE)
        (create-accessor read-write))
)

(defclass Plato "Subclase de Alimento que representa un plato en el menu.  Se divide en PrimerPlato, SegundoPlardfs:comment to y Postre. Contiene ingredientes, un estilo culinario, nivel de dificultad, prioridad y disponibilidad estacional."
    (is-a Alimento)
    (role concrete)
    (pattern-match reactive)
    ;;; Relaciona un ingrediente o un plato con los meses del año en los que est disponible o puede ser preparado. Permite gestionar la estacionalidad de los alimentos y la generación de menús.
    (multislot disponibleEn
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Restriccion para saber si un plato es adeucado para un evento
    (multislot esAdecuadoParaEvento
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Indica a qu tipo de comida pertenee un plato, como por ejemplo si es de carne, pescado, vegetariano... Es útil para aplicar restricciones alimentarias y las clasificaciones culinarias en la elaboración de menús.
    (multislot esDeTipoComida
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Relación entre un Plato y los Ingredientes que lo componen.
    (multislot tieneIngredientes
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Nivel de complejidad en la preparación de un plato, expresado numéricamente.
    (slot dificultad
        (type INTEGER)
        (create-accessor read-write))
)

(defclass Postre
    (is-a Plato)
    (role concrete)
    (pattern-match reactive)
)

(defclass PrimerPlato
    (is-a Plato)
    (role concrete)
    (pattern-match reactive)
)

(defclass SegundoPlato
    (is-a Plato)
    (role concrete)
    (pattern-match reactive)
)

(defclass Evento "Describe las características del evento para el cual se genera el menú: tipo (TipoEvento), mes de celebración y número de comensales."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Indica en qué mes se celebrará un evento. Es relevante para determinar la disponibilidad estacional de los ingredientes y platos en funciñn de la fecha del evento.
    (slot tieneMes
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Relación entre un Evento y su tipo (Familiar o Congreso).
    (multislot tieneTipoEvento
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Número total de personas que asistirán al evento.
    (slot numeroComensales
        (type INTEGER)
        (create-accessor read-write))
)

(defclass Ingrediente "Representa un ingrediente utilizado en los platos. Tiene propiedades nutricionales y estacionales. Cada ingrediente pertenece a un TipoIngrediente."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Relación entre un Ingrediente y su clasificación en TipoIngrediente.
    (multislot tieneTipoIngrediente
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Cantidad de energía que aporta un ingrediente, expresada en kilocalorías (kcal).
    (slot calorias
        (type INTEGER)
        (create-accessor read-write))
    ;;; Gramos de carbohidratos presentes en un ingrediente o alimento.
    (slot carbohidratos
        (type INTEGER)
        (create-accessor read-write))
    ;;; Miligramos de colesterol contenidos en un ingrediente.
    (slot colesterol
        (type INTEGER)
        (create-accessor read-write))
    ;;; Gramos de grasas totales presentes en un ingrediente.
    (slot grasas
        (type INTEGER)
        (create-accessor read-write))
    ;;; Gramos de proteínas contenidos en un ingrediente.
    (slot proteinas
        (type INTEGER)
        (create-accessor read-write))
    ;;; Nombre identificativo del alimento o ingrediente.
    (slot nombre
        (type STRING)
        (create-accessor read-write))
)

(defclass Menu "Representa un conjunto de platos y bebidas seleccionados para un evento. Tiene un precio total, una puntuación de calidad y referencias a los platos que lo componen."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    (slot tieneBebida
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Asocia un Postre a un Menú.
    (slot tienePostre
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Asocia un PrimerPlato a un Menú.
    (slot tienePrimerPlato
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Asocia un SegundoPlato a un Menú.
    (slot tieneSegundoPlato
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Evaluación de calidad o adecuación del menú final, expresada como puntuación numérica.
    (slot puntuacion
        (type FLOAT)
        (create-accessor read-write))
    ;;; Precio individual de un plato, bebida o ingrediente.
    (slot precio
        (type FLOAT)
        (create-accessor read-write))
)

(defclass Mes "Contiene todos los meses del año."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
)

(defclass Restriccion "Contiene las condiciones y preferencias impuestas por el usuario, como precio máximo, ingredientes prohibidos o estilos de comida requeridos."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Representan las restricciones que el Usuario impone sobre el menú deseado.
    (multislot prohibeIngrediente
        (type INSTANCE)
        (allowed-classes Ingrediente)
        (create-accessor read-write))
    ;;; Representan las restricciones que el Usuario impone sobre el menú deseado.
    (multislot prohibeTipoBebida
        (type INSTANCE)
        (allowed-classes TipoBebida)
        (create-accessor read-write))
    ;;; Representan las restricciones que el Usuario impone sobre el menú deseado.
    (multislot prohibeTipoComida
        (type INSTANCE)
        (allowed-classes TipoComidaPlato)
        (create-accessor read-write))
    ;;; Tipos de comida preferidos por el usuario.
    (multislot esDeTipoComida
        (type INSTANCE)
        (allowed-classes TipoComidaPlato)
        (create-accessor read-write))
    ;;; Precio máximo que un usuario está dispuesto a pagar por el menú completo.
    (slot condicionPrecioMax
        (type FLOAT)
        (create-accessor read-write))
    ;;; Precio mínimo que un usuario espera gastar en el menú completo.
    (slot condicionPrecioMin
        (type FLOAT)
        (create-accessor read-write))
)

(defclass TipoBebida "Define el tipo o clasificación de una bebida (Alcohol, Zumo, Cafeína, etc.)."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
)

(defclass TipoComidaPlato "Categoriza de que tipo es un plato entre carne, pesacado y vegetariano."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
)

(defclass TipoEvento "Categoriza los eventos posibles, como Familiar o Congreso."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
)

(defclass TipoIngrediente "Representa una clasificación general de los ingredientes como Carne, Verdura, Cereal, etc."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
)

(defclass Usuario "Representa al cliente que organiza un evento y define restricciones sobre el menú."
    (is-a USER)
    (role concrete)
    (pattern-match reactive)
    ;;; Relación entre un Usuario y el Evento que organiza.
    (multislot organizaEvento
        (type INSTANCE)
        (create-accessor read-write))
    ;;; Relación entre un Usuario y las Restricciones que ha definido.
    (multislot tieneRestriccion
        (type INSTANCE)
        (create-accessor read-write))
)

(definstances instances
    ;;; MESES DEL AÑO

    ([Enero] of Mes
    )

    ([Febrero] of Mes
    )

    ([Marzo] of Mes
    )

    ([Abril] of Mes
    )

    ([Mayo] of Mes
    )

    ([Junio] of Mes
    )

    ([Julio] of Mes
    )

    ([Agosto] of Mes
    )

    ([Septiembre] of Mes
    )

    ([Octubre] of Mes
    )

    ([Noviembre] of Mes
    )

    ([Diciembre] of Mes
    )

    ;;; TIPOS DE BEBIDA

    ([Agua] of TipoBebida
    )

    ([Alcohol] of TipoBebida
    )

    ([Cafeina] of TipoBebida
    )

    ([Cerveza] of TipoBebida
    )

    ([Light] of TipoBebida
    )

    ([Zumo] of TipoBebida
    )

    ;;; TIPOS DE EVENTO

    ([Congreso] of TipoEvento
    )

    ([Familiar] of TipoEvento
    )

    ;;; TIPOS DE INGREDIENTES

    ([Aromatizante] of TipoIngrediente
    )

    ([Carne] of TipoIngrediente
    )

    ([Cereal] of TipoIngrediente
    )

    ([Condimento] of TipoIngrediente
    )

    ([Endulzante] of TipoIngrediente
    )

    ([Fruta] of TipoIngrediente
    )

    ([FrutoSeco] of TipoIngrediente
    )

    ([Grasa] of TipoIngrediente
    )

    ([Huevo] of TipoIngrediente
    )

    ([Lacteo] of TipoIngrediente
    )

    ([Legumbre] of TipoIngrediente
    )

    ([Marisco] of TipoIngrediente
    )

    ([Pan] of TipoIngrediente
    )

    ([Pasta] of TipoIngrediente
    )

    ([Pescado] of TipoIngrediente
    )

    ([Salsa] of TipoIngrediente
    )

    ([Verdura] of TipoIngrediente
    )

    ;;; TIPOS DE PLATOS

    ([Caliente] of TipoComidaPlato
    )

    ([Clasico] of TipoComidaPlato
    )

    ([Español] of TipoComidaPlato
    )

    ([Frio] of TipoComidaPlato
    )

    ([GlutenFree] of TipoComidaPlato
    )

    ([Internacional] of TipoComidaPlato
    )

    ([Italiano] of TipoComidaPlato
    )

    ([Japonés] of TipoComidaPlato
    )

    ([LactoseFree] of TipoComidaPlato
    )

    ([Moderno] of TipoComidaPlato
    )

    ([Sopa] of TipoComidaPlato
    )

    ([Vegano] of TipoComidaPlato
    )

    ([Vegetariano] of TipoComidaPlato
    )

    ;;; Ingredientes para Ensalada César (sin precio)
([Lechuga] of Ingrediente
    (nombre "Lechuga")
    (tieneTipoIngrediente [Verdura])
    (calorias 15)          ; por 100g, aproximado
    (carbohidratos 3)      ; por 100g, aproximado
    (colesterol 0)         ; por 100g, aproximado
    (grasas 0)             ; por 100g, aproximado
    (proteinas 1)          ; por 100g, aproximado
)

([Pollo] of Ingrediente
    (nombre "Pollo")
    (tieneTipoIngrediente [Carne])
    (calorias 165)         ; por 100g, aproximado
    (carbohidratos 0)      ; por 100g, aproximado
    (colesterol 85)        ; por 100g, aproximado
    (grasas 3)             ; por 100g, aproximado
    (proteinas 31)         ; por 100g, aproximado
)

([QuesoParmesano] of Ingrediente
    (nombre "Queso Parmesano")
    (tieneTipoIngrediente [Lacteo])
    (calorias 431)         ; por 100g, aproximado
    (carbohidratos 4)      ; por 100g, aproximado
    (colesterol 88)        ; por 100g, aproximado
    (grasas 29)            ; por 100g, aproximado
    (proteinas 38)         ; por 100g, aproximado
)

([Crutones] of Ingrediente
    (nombre "Crutones")
    (tieneTipoIngrediente [Pan])
    (calorias 400)         ; por 100g, aproximado
    (carbohidratos 70)     ; por 100g, aproximado
    (colesterol 0)         ; por 100g, aproximado
    (grasas 10)            ; por 100g, aproximado
    (proteinas 10)         ; por 100g, aproximado
)

([SalsaCesar] of Ingrediente
    (nombre "Salsa César")
    (tieneTipoIngrediente [Salsa])
    (calorias 500)         ; por 100g, aproximado
    (carbohidratos 5)      ; por 100g, aproximado
    (colesterol 50)        ; por 100g, aproximado
    (grasas 50)            ; por 100g, aproximado
    (proteinas 2)          ; por 100g, aproximado
)

;;; Ingredientes para Solomillo de Cerdo (sin precio)
([Cerdo] of Ingrediente
    (nombre "Cerdo")
    (tieneTipoIngrediente [Carne])
    (calorias 200)         ; por 100g, aproximado
    (carbohidratos 0)      ; por 100g, aproximado
    (colesterol 80)        ; por 100g, aproximado
    (grasas 10)            ; por 100g, aproximado
    (proteinas 25)         ; por 100g, aproximado
)

([VinoTinto] of Ingrediente
    (nombre "Vino Tinto")
    (tieneTipoIngrediente [Salsa]) ; usado como parte de la salsa
    (calorias 85)          ; por 100ml, aproximado
    (carbohidratos 3)      ; por 100ml, aproximado
    (colesterol 0)         ; por 100ml, aproximado
    (grasas 0)             ; por 100ml, aproximado
    (proteinas 0)          ; por 100ml, aproximado
)

([Ajo] of Ingrediente
    (nombre "Ajo")
    (tieneTipoIngrediente [Condimento])
    (calorias 150)         ; por 100g, aproximado
    (carbohidratos 33)     ; por 100g, aproximado
    (colesterol 0)         ; por 100g, aproximado
    (grasas 0)             ; por 100g, aproximado
    (proteinas 6)          ; por 100g, aproximado
)

([Patata] of Ingrediente
    (nombre "Patata")
    (tieneTipoIngrediente [Verdura])
    (calorias 80)          ; por 100g, aproximado
    (carbohidratos 18)     ; por 100g, aproximado
    (colesterol 0)         ; por 100g, aproximado
    (grasas 0)             ; por 100g, aproximado
    (proteinas 2)          ; por 100g, aproximado
)

([AceiteOliva] of Ingrediente
    (nombre "Aceite de Oliva")
    (tieneTipoIngrediente [Grasa])
    (calorias 900)         ; por 100ml, aproximado
    (carbohidratos 0)      ; por 100ml, aproximado
    (colesterol 0)         ; por 100ml, aproximado
    (grasas 100)           ; por 100ml, aproximado
    (proteinas 0)          ; por 100ml, aproximado
)

;;; Ingredientes para Tarta de Queso (sin precio)
([QuesoCrema] of Ingrediente
    (nombre "Queso Crema")
    (tieneTipoIngrediente [Lacteo])
    (calorias 350)         ; por 100g, aproximado
    (carbohidratos 4)      ; por 100g, aproximado
    (colesterol 100)       ; por 100g, aproximado
    (grasas 35)            ; por 100g, aproximado
    (proteinas 6)          ; por 100g, aproximado
)

([Azucar] of Ingrediente
    (nombre "Azúcar")
    (tieneTipoIngrediente [Endulzante])
    (calorias 400)         ; por 100g, aproximado
    (carbohidratos 100)    ; por 100g, aproximado
    (colesterol 0)         ; por 100g, aproximado
    (grasas 0)             ; por 100g, aproximado
    (proteinas 0)          ; por 100g, aproximado
)

([FrutosRojos] of Ingrediente
    (nombre "Frutos Rojos")
    (tieneTipoIngrediente [Fruta])
    (calorias 50)          ; por 100g, aproximado
    (carbohidratos 12)     ; por 100g, aproximado
    (colesterol 0)         ; por 100g, aproximado
    (grasas 0)             ; por 100g, aproximado
    (proteinas 1)          ; por 100g, aproximado
)

([Galleta] of Ingrediente
    (nombre "Galleta")
    (tieneTipoIngrediente [Cereal])
    (calorias 450)         ; por 100g, aproximado
    (carbohidratos 70)     ; por 100g, aproximado
    (colesterol 10)        ; por 100g, aproximado
    (grasas 15)            ; por 100g, aproximado
    (proteinas 6)          ; por 100g, aproximado
)

([PescadoI] of Ingrediente
    (nombre "Pescado")
    (tieneTipoIngrediente [Pescado])
    (calorias 120)         ; por 100g, aproximado (merluza)
    (carbohidratos 0)      ; por 100g
    (colesterol 60)        ; por 100g
    (grasas 2)             ; por 100g
    (proteinas 22)         ; por 100g
)

([Arroz] of Ingrediente
    (nombre "Arroz")
    (tieneTipoIngrediente [Cereal])
    (calorias 130)         ; por 100g, aproximado
    (carbohidratos 28)     ; por 100g
    (colesterol 0)         ; por 100g
    (grasas 0.3)           ; por 100g
    (proteinas 2.7)        ; por 100g
)

([Champinon] of Ingrediente
    (nombre "Champiñón")
    (tieneTipoIngrediente [Vegetal])
    (calorias 22)          ; por 100g, aproximado
    (carbohidratos 3.3)    ; por 100g
    (colesterol 0)         ; por 100g
    (grasas 0.3)           ; por 100g
    (proteinas 3.1)        ; por 100g
)

([Nata] of Ingrediente
    (nombre "Nata")
    (tieneTipoIngrediente [Lácteo])
    (calorias 300)         ; por 100g, aproximado
    (carbohidratos 3)      ; por 100g
    (colesterol 100)       ; por 100g
    (grasas 30)            ; por 100g
    (proteinas 2)          ; por 100g
)

([Manzana] of Ingrediente
    (nombre "Manzana")
    (tieneTipoIngrediente [Fruta])
    (calorias 52)          ; por 100g, aproximado
    (carbohidratos 14)     ; por 100g
    (colesterol 0)         ; por 100g
    (grasas 0.2)           ; por 100g
    (proteinas 0.3)        ; por 100g
)

([Canela] of Ingrediente
    (nombre "Canela")
    (tieneTipoIngrediente [Especia])
    (calorias 247)         ; por 100g, aproximado
    (carbohidratos 81)     ; por 100g
    (colesterol 0)         ; por 100g
    (grasas 1.2)           ; por 100g
    (proteinas 4)          ; por 100g
)

([Limon] of Ingrediente
    (nombre "Limón")
    (tieneTipoIngrediente [Fruta])
    (calorias 29)          ; por 100g, aproximado
    (carbohidratos 9)      ; por 100g
    (colesterol 0)         ; por 100g
    (grasas 0.3)           ; por 100g
    (proteinas 1.1)        ; por 100g
)

([Menta] of Ingrediente
    (nombre "Menta")
    (tieneTipoIngrediente [Hierba])
    (calorias 70)          ; por 100g, aproximado
    (carbohidratos 15)     ; por 100g
    (colesterol 0)         ; por 100g
    (grasas 1)             ; por 100g
    (proteinas 3.8)        ; por 100g
)

([Azucar] of Ingrediente
    (nombre "Azúcar")
    (tieneTipoIngrediente [Edulcorante])
    (calorias 387)         ; por 100g, aproximado
    (carbohidratos 100)    ; por 100g
    (colesterol 0)         ; por 100g
    (grasas 0)             ; por 100g
    (proteinas 0)          ; por 100g
)

([QuesoFeta] of Ingrediente
    (nombre "Queso Feta")
    (tieneTipoIngrediente [Lácteo])
    (calorias 264)         ; por 100g, aproximado
    (carbohidratos 4)      ; por 100g
    (colesterol 89)        ; por 100g
    (grasas 21)            ; por 100g
    (proteinas 14)         ; por 100g
)


([CremaChampinones] of PrimerPlato
    (nombre "Crema de Champiñones")
    (precio 7.5)           ; económico
    (dificultad 2)         ; media
    (tieneIngredientes [Champinon] [Nata] [Cebolla] [AceiteOliva])
    (esDeTipoComida [Clasico] [Caliente] [Vegetariano])
    (disponibleEn [Enero] [Febrero] [Marzo] [Octubre] [Noviembre] [Diciembre]) ; meses fríos
    (esAdecuadoParaEvento [Familiar] [Congreso])
    (esIncompatibleCon ))

([EnsaladaMediterranea] of PrimerPlato
    (nombre "Ensalada Mediterránea")
    (precio 6.0)           ; bajo
    (dificultad 1)         ; fácil
    (tieneIngredientes [Lechuga] [Tomate] [Aceituna] [QuesoFeta] [AceiteOliva])
    (esDeTipoComida [Frio] [Vegetariano] [Mediterraneo])
    (disponibleEn [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre]) ; meses cálidos
    (esAdecuadoParaEvento [Familiar] [Congreso] [Boda])
    (esIncompatibleCon ))


([PaellaMixta] of SegundoPlato
    (nombre "Paella Mixta")
    (precio 14.0)          ; elevado
    (dificultad 3)         ; media-alta
    (tieneIngredientes [Arroz] [Pollo] [Pescado] [Pimiento] [Azafran])
    (esDeTipoComida [Clasico] [Caliente] [Mediterraneo])
    (disponibleEn [Mayo] [Junio] [Julio] [Agosto] [Septiembre]) ; meses cálidos
    (esAdecuadoParaEvento [Familiar] [Boda])
    (esIncompatibleCon ))

([MerluzaVapor] of SegundoPlato
    (nombre "Merluza al Vapor con Salsa de Limón")
    (precio 13.0)          ; algo elevado
    (dificultad 3)         ; media-alta
    (tieneIngredientes [Pescado] [Limon] [Perejil] [AceiteOliva])
    (esDeTipoComida [Frio] [Moderno] [Pescado])
    (disponibleEn [Mayo] [Junio] [Julio] [Agosto] [Septiembre]) ; meses cálidos
    (esAdecuadoParaEvento [Congreso] [Boda])
    (esIncompatibleCon ))

    ([TartaManzana] of Postre
    (nombre "Tarta de Manzana con Canela")
    (precio 5.5)           ; económico
    (dificultad 2)         ; media
    (tieneIngredientes [Manzana] [Canela] [Azucar] [Harina] [Mantequilla])
    (esDeTipoComida [Dulce] [Clasico])
    (disponibleEn [Septiembre] [Octubre] [Noviembre] [Diciembre]) ; otoño-invierno
    (esAdecuadoParaEvento [Familiar] [Boda])
    (esIncompatibleCon ))

([SorbeteLimon] of Postre
    (nombre "Sorbete de Limón")
    (precio 4.0)           ; bajo
    (dificultad 1)         ; fácil
    (tieneIngredientes [Limon] [Azucar] [Menta])
    (esDeTipoComida [Frio] [Dulce] [Moderno])
    (disponibleEn [Junio] [Julio] [Agosto]) ; verano
    (esAdecuadoParaEvento [Congreso] [Boda])
    (esIncompatibleCon ))

    ([Limonada] of Bebida
    (nombre "Limonada Casera")
    (precio 2.5)           ; bajo
    (tieneTipoBebida [Zumo])
    (esIncompatibleCon ))

([VinoTintoReserva] of Bebida
    (nombre "Vino Tinto Reserva")
    (precio 6.0)           ; moderado
    (tieneTipoBebida [Alcohol])
    (esIncompatibleCon ))

;;; Vino Blanco (actualizado para compatibilidad)
([VinoBlanco] of Bebida
    (nombre "Vino Blanco")
    (tieneTipoBebida [Alcohol])
    (precio 5.0)           ; precio ficticio por botella
    (esIncompatibleCon )
)

;;; Ensalada César (actualizada para compatibilidad)
([EnsaladaCesar] of PrimerPlato
    (nombre "Ensalada César")
    (precio 8.0)           ; precio total del plato
    (dificultad 2)         ; baja dificultad (1-5)
    (tieneIngredientes [Lechuga] [Pollo] [QuesoParmesano] [Crutones] [SalsaCesar])
    (esDeTipoComida [Clasico] [Frio]) 
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]) ; todo el año
    (esAdecuadoParaEvento [Familiar] [Congreso])
    (esIncompatibleCon )
)

;;; Solomillo de Cerdo como SegundoPlato
([SolomilloCerdo] of SegundoPlato
    (nombre "Solomillo de Cerdo con Salsa de Vino")
    (precio 12.0)          ; precio total del plato
    (dificultad 2)         ; dificultad media (1-5)
    (tieneIngredientes [Cerdo] [VinoTinto] [Ajo] [Patata] [AceiteOliva])
    (esDeTipoComida [Clasico] [Caliente] [Moderno])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]) ; todo el año
    (esAdecuadoParaEvento [Familiar] [Congreso])
    (esIncompatibleCon ))

;;; Tarta de Queso como Postre
([TartaQueso] of Postre
    (nombre "Tarta de Queso con Frutos Rojos")
    (precio 6.0)           ; precio total del plato
    (dificultad 2)         ; dificultad media (1-5)
    (tieneIngredientes [QuesoCrema] [Azucar] [Huevo] [FrutosRojos] [Galleta])
    (esDeTipoComida [Clasico] [Frio])
    (disponibleEn [Mayo] [Junio] [Julio]) ; limitado por frutos rojos
    (esAdecuadoParaEvento [Familiar] [Congreso])
    (esIncompatibleCon ))
)

