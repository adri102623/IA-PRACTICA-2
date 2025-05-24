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
    (slot nombre
        (type STRING)
        (create-accessor read-write))
    ;;; Relaciona un ingrediente o un plato con los meses del año en los que est disponible o puede ser preparado. Permite gestionar la estacionalidad de los alimentos y la generación de menús.
    (multislot disponibleEn
        (type INSTANCE)
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
    ;;; Indica si el usuario quiere una bebida por plato. En caso falso, se confeccionará una bebida para todo el menú
    (slot bebidaParaCadaPlato
        (type SYMBOL)
        (allowed-symbols TRUE FALSE)
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
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre])
)

([Pollo] of Ingrediente
    (nombre "Pollo")
    (tieneTipoIngrediente [Carne])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre])
)

([QuesoParmesano] of Ingrediente
    (nombre "Queso Parmesano")
    (tieneTipoIngrediente [Lacteo])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre])
)

([Crutones] of Ingrediente
    (nombre "Crutones")
    (tieneTipoIngrediente [Pan])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre])
)

([SalsaCesar] of Ingrediente
    (nombre "Salsa César")
    (tieneTipoIngrediente [Salsa])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre])
)

;;; Ingredientes para Solomillo de Cerdo (sin precio)
([Cerdo] of Ingrediente
    (nombre "Cerdo")
    (tieneTipoIngrediente [Carne])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre])
)

([VinoTinto] of Ingrediente
    (nombre "Vino Tinto")
    (tieneTipoIngrediente [Salsa]) ; usado como parte de la salsa
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre])
)

([Ajo] of Ingrediente
    (nombre "Ajo")
    (tieneTipoIngrediente [Condimento])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre])
)

([Patata] of Ingrediente
    (nombre "Patata")
    (tieneTipoIngrediente [Verdura])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre])
)

([AceiteOliva] of Ingrediente
    (nombre "Aceite de Oliva")
    (tieneTipoIngrediente [Grasa])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre])
)

;;; Ingredientes para Tarta de Queso (sin precio)
([QuesoCrema] of Ingrediente
    (nombre "Queso Crema")
    (tieneTipoIngrediente [Lacteo])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre])
)

([Azucar] of Ingrediente
    (nombre "Azúcar")
    (tieneTipoIngrediente [Endulzante])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre])
)

([FrutosRojos] of Ingrediente
    (nombre "Frutos Rojos")
    (tieneTipoIngrediente [Fruta])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre])
)

([Galleta] of Ingrediente
    (nombre "Galleta")
    (tieneTipoIngrediente [Cereal])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre])
)

([PescadoI] of Ingrediente
    (nombre "Pescado")
    (tieneTipoIngrediente [Pescado])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre])
)

([Arroz] of Ingrediente
    (nombre "Arroz")
    (tieneTipoIngrediente [Cereal])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre])
)

([Champinon] of Ingrediente
    (nombre "Champiñón")
    (tieneTipoIngrediente [Vegetal])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre])
)

([Nata] of Ingrediente
    (nombre "Nata")
    (tieneTipoIngrediente [Lácteo])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre])
)

([Manzana] of Ingrediente
    (nombre "Manzana")
    (tieneTipoIngrediente [Fruta])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre])
)

([Canela] of Ingrediente
    (nombre "Canela")
    (tieneTipoIngrediente [Especia])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre])
)

([Limon] of Ingrediente
    (nombre "Limón")
    (tieneTipoIngrediente [Fruta])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre])
)

([Menta] of Ingrediente
    (nombre "Menta")
    (tieneTipoIngrediente [Hierba])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre])
)

([Azucar] of Ingrediente
    (nombre "Azúcar")
    (tieneTipoIngrediente [Edulcorante])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre])
)

([QuesoFeta] of Ingrediente
    (nombre "Queso Feta")
    (tieneTipoIngrediente [Lácteo])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre])
)


([CremaChampinones] of PrimerPlato
    (nombre "Crema de Champiñones")
    (precio 7.5)           ; económico
    (dificultad 2)         ; media
    (tieneIngredientes [Champinon] [Nata] [Cebolla] [AceiteOliva])
    (esDeTipoComida [Clasico] [Caliente] [Vegetariano])
    (esAdecuadoParaEvento [Familiar] [Congreso])
    (esIncompatibleCon ))

([EnsaladaMediterranea] of PrimerPlato
    (nombre "Ensalada Mediterránea")
    (precio 6.0)           ; bajo
    (dificultad 1)         ; fácil
    (tieneIngredientes [Lechuga] [Tomate] [Aceituna] [QuesoFeta] [AceiteOliva])
    (esDeTipoComida [Frio] [Vegetariano] [Mediterraneo])
    (esAdecuadoParaEvento [Familiar] [Congreso] [Boda])
    (esIncompatibleCon ))


([PaellaMixta] of SegundoPlato
    (nombre "Paella Mixta")
    (precio 14.0)          ; elevado
    (dificultad 3)         ; media-alta
    (tieneIngredientes [Arroz] [Pollo] [Pescado] [Pimiento] [Azafran])
    (esDeTipoComida [Clasico] [Caliente] [Mediterraneo])
    (esAdecuadoParaEvento [Familiar] [Boda])
    (esIncompatibleCon ))

([MerluzaVapor] of SegundoPlato
    (nombre "Merluza al Vapor con Salsa de Limón")
    (precio 13.0)          ; algo elevado
    (dificultad 3)         ; media-alta
    (tieneIngredientes [Pescado] [Limon] [Perejil] [AceiteOliva])
    (esDeTipoComida [Frio] [Moderno] [Pescado])
    (esAdecuadoParaEvento [Congreso] [Boda])
    (esIncompatibleCon ))

    ([TartaManzana] of Postre
    (nombre "Tarta de Manzana con Canela")
    (precio 5.5)           ; económico
    (dificultad 2)         ; media
    (tieneIngredientes [Manzana] [Canela] [Azucar] [Harina] [Mantequilla])
    (esDeTipoComida [Dulce] [Clasico])
    (esAdecuadoParaEvento [Familiar] [Boda])
    (esIncompatibleCon ))

([SorbeteLimon] of Postre
    (nombre "Sorbete de Limón")
    (precio 4.0)           ; bajo
    (dificultad 1)         ; fácil
    (tieneIngredientes [Limon] [Azucar] [Menta])
    (esDeTipoComida [Frio] [Dulce] [Moderno])
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
    (esAdecuadoParaEvento [Familiar] [Congreso])
    (esIncompatibleCon ))

;;; Tarta de Queso como Postre
([TartaQueso] of Postre
    (nombre "Tarta de Queso con Frutos Rojos")
    (precio 6.0)           ; precio total del plato
    (dificultad 2)         ; dificultad media (1-5)
    (tieneIngredientes [QuesoCrema] [Azucar] [Huevo] [FrutosRojos] [Galleta])
    (esDeTipoComida [Clasico] [Frio])
    (esAdecuadoParaEvento [Familiar] [Congreso])
    (esIncompatibleCon ))
)

