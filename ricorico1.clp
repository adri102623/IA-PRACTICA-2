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
    (multislot tieneBebida
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
   ;;;PRIMEROS PLATOS
([EnsaladaCaprese] of PrimerPlato
    (nombre "EnsaladaCaprese")
    (precio 6.0)           ; bajo
    (dificultad 2)         ; media
    (tieneIngredientes [Tomate] [QuesoMozzarella] [Albahaca] [AceiteOliva])
    (esDeTipoComida [Frio] [Vegetariano] [Italiano])
    (esAdecuadoParaEvento [Familiar] [Congreso])
    (esIncompatibleCon ))

([SopaMiso] of PrimerPlato
    (nombre "SopaMiso")
    (precio 5.5)           ; bajo
    (dificultad 2)         ; media
    (tieneIngredientes [Miso] [Tofu] [Alga] [Cebolleta])
    (esDeTipoComida [Caliente] [Japonés] [Vegano])
    (esAdecuadoParaEvento [Familiar] [Congreso])
    (esIncompatibleCon ))

([CevichePescado] of PrimerPlato
    (nombre "CevichePescado")
    (precio 9.0)           ; medio
    (dificultad 3)         ; media-alta
    (tieneIngredientes [Pescado] [Limon] [Cilantro] [Cebolla])
    (esDeTipoComida [Frio] [Pescado] [Internacional])
    (esAdecuadoParaEvento [Congreso])
    (esIncompatibleCon ))

([CarpaccioTernera] of PrimerPlato
    (nombre "CarpaccioTernera")
    (precio 10.0)          ; medio
    (dificultad 2)         ; media
    (tieneIngredientes [Ternera] [Parmesano] [AceiteOliva] [Limon])
    (esDeTipoComida [Frio] [Carne] [Italiano])
    (esAdecuadoParaEvento [Congreso])
    (esIncompatibleCon ))

([CremaCalabaza] of PrimerPlato
    (nombre "CremaCalabaza")
    (precio 6.5)           ; bajo
    (dificultad 2)         ; media
    (tieneIngredientes [Calabaza] [Nata] [Cebolla] [Caldo])
    (esDeTipoComida [Caliente] [Vegetariano] [Clasico])
    (esAdecuadoParaEvento [Familiar])
    (esIncompatibleCon [PolloCurry]))

([Bruschetta] of PrimerPlato
    (nombre "Bruschetta")
    (precio 5.0)           ; bajo
    (dificultad 1)         ; baja
    (tieneIngredientes [Tomate] [PanI] [Ajo] [AceiteOliva])
    (esDeTipoComida [Frio] [Vegetariano] [Italiano])
    (esAdecuadoParaEvento [Familiar] [Congreso])
    (esIncompatibleCon ))

([EnsaladaQuinoa] of PrimerPlato
    (nombre "EnsaladaQuinoa")
    (precio 7.0)           ; bajo
    (dificultad 2)         ; media
    (tieneIngredientes [Quinoa] [Aguacate] [Tomate] [Limon])
    (esDeTipoComida [Frio] [Vegano] [Moderno])
    (esAdecuadoParaEvento [Familiar] [Congreso])
    (esIncompatibleCon ))

([Gazpacho] of PrimerPlato
    (nombre "Gazpacho")
    (precio 5.5)           ; bajo
    (dificultad 2)         ; media
    (tieneIngredientes [Tomate] [Pimiento] [Pepino] [AceiteOliva])
    (esDeTipoComida [Frio] [Vegano] [Español])
    (esAdecuadoParaEvento [Familiar])
    (esIncompatibleCon ))

([TartarAtun] of PrimerPlato
    (nombre "TartarAtun")
    (precio 11.0)          ; medio
    (dificultad 3)         ; media-alta
    (tieneIngredientes [Atun] [Aguacate] [SalsaSoja] [Sesamo])
    (esDeTipoComida [Frio] [Pescado] [Japonés])
    (esAdecuadoParaEvento [Congreso])
    (esIncompatibleCon ))

([Hummus] of PrimerPlato
    (nombre "Hummus")
    (precio 6.0)           ; bajo
    (dificultad 2)         ; media
    (tieneIngredientes [Garbanzo] [Tahini] [Limon] [Ajo])
    (esDeTipoComida [Frio] [Vegano] [Internacional])
    (esAdecuadoParaEvento [Familiar] [Congreso])
    (esIncompatibleCon [Baklava]))

;;;SEGUNDO PLATO

([SolomilloCerdo] of SegundoPlato
    (nombre "SolomilloCerdo")
    (precio 15.0)          ; medio
    (dificultad 1)         ; media-alta
    (tieneIngredientes [Cerdo] [VinoTinto] [Ajo] [Romero])
    (esDeTipoComida [Caliente] [Carne] [Clasico])
    (esAdecuadoParaEvento [Familiar] [Congreso])
    (esIncompatibleCon ))

([SalmónPlancha] of SegundoPlato
    (nombre "SalmónPlancha")
    (precio 14.0)          ; medio
    (dificultad 2)         ; media
    (tieneIngredientes [Salmón] [Limon] [Perejil] [AceiteOliva])
    (esDeTipoComida [Caliente] [Pescado])
    (esAdecuadoParaEvento [Congreso])
    (esIncompatibleCon ))

([PaellaMariscos] of SegundoPlato
    (nombre "PaellaMariscos")
    (precio 16.0)          ; medio-alto
    (dificultad 2)         ; alta
    (tieneIngredientes [Arroz] [Gamba] [Calamar] [Pimiento])
    (esDeTipoComida [Caliente] [Marisco] [Español])
    (esAdecuadoParaEvento [Familiar])
    (esIncompatibleCon [Sangría]))

([PolloCurry] of SegundoPlato
    (nombre "PolloCurry")
    (precio 12.0)          ; medio
    (dificultad 2)         ; media-alta
    (tieneIngredientes [Pollo] [Curry] [LecheCoco] [Cebolla])
    (esDeTipoComida [Caliente] [Carne] [Internacional])
    (esAdecuadoParaEvento [Familiar] [Congreso])
    (esIncompatibleCon ))

([BerenjenasRellenas] of SegundoPlato
    (nombre "BerenjenasRellenas")
    (precio 9.0)           ; bajo
    (dificultad 2)         ; media-alta
    (tieneIngredientes [Berenjena] [Tomate] [QuesoMozzarella] [Albahaca])
    (esDeTipoComida [Caliente] [Vegetariano] [Italiano])
    (esAdecuadoParaEvento [Familiar])
    (esIncompatibleCon ))

([CorderoAsado] of SegundoPlato
    (nombre "CorderoAsado")
    (precio 17.0)          ; alto
    (dificultad 2)         ; alta
    (tieneIngredientes [Cordero] [Ajo] [Romero] [AceiteOliva])
    (esDeTipoComida [Caliente] [Carne] [Clasico])
    (esAdecuadoParaEvento [Familiar])
    (esIncompatibleCon ))

([TofuSalteado] of SegundoPlato
    (nombre "TofuSalteado")
    (precio 8.0)           ; bajo
    (dificultad 2)         ; media
    (tieneIngredientes [Tofu] [SalsaSoja] [Pimiento] [Cebolla])
    (esDeTipoComida [Caliente] [Vegano] [Internacional])
    (esAdecuadoParaEvento [Familiar] [Congreso])
    (esIncompatibleCon ))

([MerluzaSalsaVerde] of SegundoPlato
    (nombre "MerluzaSalsaVerde")
    (precio 13.0)          ; medio
    (dificultad 2)         ; media-alta
    (tieneIngredientes [Merluza] [Perejil] [Ajo] [Caldo])
    (esDeTipoComida [Caliente] [Pescado] [Español])
    (esAdecuadoParaEvento [Congreso])
    (esIncompatibleCon ))

([LasañaVegetal] of SegundoPlato
    (nombre "LasañaVegetal")
    (precio 10.0)          ; medio
    (dificultad 3)         ; media-alta
    (tieneIngredientes [PastaI] [Calabaza] [QuesoMozzarella] [Tomate])
    (esDeTipoComida [Caliente] [Vegetariano] [Italiano])
    (esAdecuadoParaEvento [Familiar])
    (esIncompatibleCon ))

([TerneraWellington] of SegundoPlato
    (nombre "TerneraWellington")
    (precio 20.0)          ; alto
    (dificultad 2)         ; alta
    (tieneIngredientes [Ternera] [Hojaldre] [Champiñones] [Panceta])
    (esDeTipoComida [Caliente] [Carne] [Internacional])
    (esAdecuadoParaEvento [Congreso])
    (esIncompatibleCon ))

([TartaQueso] of Postre
    (nombre "TartaQueso")
    (precio 6.0)           ; medio
    (dificultad 2)         ; media-alta
    (tieneIngredientes [QuesoCrema] [Galleta] [Azucar] [Nata])
    (esDeTipoComida [Dulce] [Clasico])
    (esAdecuadoParaEvento [Familiar] [Congreso])
    (esIncompatibleCon ))

([SorbeteLimon] of Postre
    (nombre "SorbeteLimon")
    (precio 4.5)           ; bajo
    (dificultad 2)         ; media
    (tieneIngredientes [Limon] [Azucar] [Agua])
    (esDeTipoComida [Dulce] [Frio])
    (esAdecuadoParaEvento [Familiar] [Congreso])
    (esIncompatibleCon ))

([FlanVainilla] of Postre
    (nombre "FlanVainilla")
    (precio 5.0)           ; bajo
    (dificultad 2)         ; media
    (tieneIngredientes [Huevo] [Leche] [Vainilla] [Azucar])
    (esDeTipoComida [Dulce] [Clasico])
    (esAdecuadoParaEvento [Familiar])
    (esIncompatibleCon ))

([Tiramisu] of Postre
    (nombre "Tiramisu")
    (precio 7.0)           ; medio
    (dificultad 2)         ; media-alta
    (tieneIngredientes [QuesoMascarpone] [Café] [Cacao] [Bizcocho])
    (esDeTipoComida [Dulce] [Italiano])
    (esAdecuadoParaEvento [Familiar] [Congreso])
    (esIncompatibleCon ))

([CoulantChocolate] of Postre
    (nombre "CoulantChocolate")
    (precio 6.5)           ; medio
    (dificultad 2)         ; media-alta
    (tieneIngredientes [Chocolate] [Huevo] [Harina] [Mantequilla])
    (esDeTipoComida [Dulce] [Caliente])
    (esAdecuadoParaEvento [Familiar])
    (esIncompatibleCon ))

([PannaCotta] of Postre
    (nombre "PannaCotta")
    (precio 5.5)           ; bajo
    (dificultad 2)         ; media
    (tieneIngredientes [Nata] [Gelatina] [Azucar] [Vainilla])
    (esDeTipoComida [Dulce] [Italiano])
    (esAdecuadoParaEvento [Familiar] [Congreso])
    (esIncompatibleCon ))

([CremaCatalana] of Postre
    (nombre "CremaCatalana")
    (precio 15.0)           ; bajo
    (dificultad 2)         ; media-alta
    (tieneIngredientes [Leche] [Huevo] [Azucar] [Canela])
    (esDeTipoComida [Dulce] [Español])
    (esAdecuadoParaEvento [Familiar])
    (esIncompatibleCon ))

([MousseMango] of Postre
    (nombre "MousseMango")
    (precio 6.0)           ; medio
    (dificultad 2)         ; media
    (tieneIngredientes [Mango] [Nata] [Gelatina] [Azucar])
    (esDeTipoComida [Dulce] [Frio] [Internacional])
    (esAdecuadoParaEvento [Familiar] [Congreso])
    (esIncompatibleCon ))

([Baklava] of Postre
    (nombre "Baklava")
    (precio 7.0)           ; medio
    (dificultad 4)         ; alta
    (tieneIngredientes [Miel] [Nuez] [MasaFilo] [Mantequilla])
    (esDeTipoComida [Dulce] [Internacional])
    (esAdecuadoParaEvento [Congreso])
    (esIncompatibleCon ))

([ArrozLeche] of Postre
    (nombre "ArrozLeche")
    (precio 4.5)           ; bajo
    (dificultad 2)         ; media
    (tieneIngredientes [Arroz] [Leche] [Canela] [Azucar])
    (esDeTipoComida [Dulce] [Clasico] [Español])
    (esAdecuadoParaEvento [Familiar])
    (esIncompatibleCon ))

;;;BEBIDAS
([AguaMineral] of Bebida
    (nombre "AguaMineral")
    (precio 2.0)           ; bajo
    (tieneTipoBebida [Agua])
    (esIncompatibleCon ))

([LimonadaCasera] of Bebida
    (nombre "LimonadaCasera")
    (precio 2.5)           ; bajo
    (tieneTipoBebida [Zumo])
    (esIncompatibleCon ))

([TéVerde] of Bebida
    (nombre "TéVerde")
    (precio 3.0)           ; bajo
    (tieneTipoBebida [Cafeina])
    (esIncompatibleCon ))

([CervezaArtesanal] of Bebida
    (nombre "CervezaArtesanal")
    (precio 4.5)           ; medio
    (tieneTipoBebida [Cerveza])
    (esIncompatibleCon ))

([VinoBlanco] of Bebida
    (nombre "VinoBlanco")
    (precio 15.0)           ; medio
    (tieneTipoBebida [Alcohol])
    (esIncompatibleCon ))

([RefrescoCola] of Bebida
    (nombre "RefrescoCola")
    (precio 2.5)           ; bajo
    (tieneTipoBebida [Light])
    (esIncompatibleCon ))

([ZumoNaranja] of Bebida
    (nombre "ZumoNaranja")
    (precio 3.5)           ; bajo
    (tieneTipoBebida [Zumo])
    (esIncompatibleCon ))

([CaféExpreso] of Bebida
    (nombre "CaféExpreso")
    (precio 2.5)           ; bajo
    (tieneTipoBebida [Cafeina])
    (esIncompatibleCon ))

([Sangría] of Bebida
    (nombre "Sangría")
    (precio 5.0)           ; medio
    (tieneTipoBebida [Alcohol])
    (esIncompatibleCon ))

([Kombucha] of Bebida
    (nombre "Kombucha")
    (precio 4.0)           ; medio
    (tieneTipoBebida [Light])
    (esIncompatibleCon ))

([QuesoCrema] of Ingrediente
    (nombre "Queso Crema")
    (tieneTipoIngrediente [Lacteo])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Galleta] of Ingrediente
    (nombre "Galleta")
    (tieneTipoIngrediente [Cereal])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Vainilla] of Ingrediente
    (nombre "Vainilla")
    (tieneTipoIngrediente [Aromatizante])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([QuesoMascarpone] of Ingrediente
    (nombre "Queso Mascarpone")
    (tieneTipoIngrediente [Lacteo])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Café] of Ingrediente
    (nombre "Café")
    (tieneTipoIngrediente [Aromatizante])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Cacao] of Ingrediente
    (nombre "Cacao")
    (tieneTipoIngrediente [Endulzante])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Bizcocho] of Ingrediente
    (nombre "Bizcocho")
    (tieneTipoIngrediente [Cereal])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Gelatina] of Ingrediente
    (nombre "Gelatina")
    (tieneTipoIngrediente [Espesante])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Canela] of Ingrediente
    (nombre "Canela")
    (tieneTipoIngrediente [Aromatizante])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Mango] of Ingrediente
    (nombre "Mango")
    (tieneTipoIngrediente [Fruta])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Miel] of Ingrediente
    (nombre "Miel")
    (tieneTipoIngrediente [Endulzante])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Nuez] of Ingrediente
    (nombre "Nuez")
    (tieneTipoIngrediente [FrutoSeco])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([MasaFilo] of Ingrediente
    (nombre "Masa Filo")
    (tieneTipoIngrediente [Cereal])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))

([Cerdo] of Ingrediente
    (nombre "Cerdo")
    (tieneTipoIngrediente [Carne])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([VinoTinto] of Ingrediente
    (nombre "Vino Tinto")
    (tieneTipoIngrediente [Liquido])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Romero] of Ingrediente
    (nombre "Romero")
    (tieneTipoIngrediente [Aromatizante])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Salmón] of Ingrediente
    (nombre "Salmón")
    (tieneTipoIngrediente [Pescado])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Perejil] of Ingrediente
    (nombre "Perejil")
    (tieneTipoIngrediente [Aromatizante])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Arroz] of Ingrediente
    (nombre "Arroz")
    (tieneTipoIngrediente [Cereal])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Gamba] of Ingrediente
    (nombre "Gamba")
    (tieneTipoIngrediente [Marisco])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Calamar] of Ingrediente
    (nombre "Calamar")
    (tieneTipoIngrediente [Marisco])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Pollo] of Ingrediente
    (nombre "Pollo")
    (tieneTipoIngrediente [Carne])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Curry] of Ingrediente
    (nombre "Curry")
    (tieneTipoIngrediente [Condimento])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([LecheCoco] of Ingrediente
    (nombre "Leche de Coco")
    (tieneTipoIngrediente [Liquido])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Berenjena] of Ingrediente
    (nombre "Berenjena")
    (tieneTipoIngrediente [Verdura])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Cordero] of Ingrediente
    (nombre "Cordero")
    (tieneTipoIngrediente [Carne])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Merluza] of Ingrediente
    (nombre "Merluza")
    (tieneTipoIngrediente [PescadoI])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([PastaI] of Ingrediente
    (nombre "PastaI")
    (tieneTipoIngrediente [Pasta])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Hojaldre] of Ingrediente
    (nombre "Hojaldre")
    (tieneTipoIngrediente [Pan])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Champiñones] of Ingrediente
    (nombre "Champiñones")
    (tieneTipoIngrediente [Hongo])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Panceta] of Ingrediente
    (nombre "Panceta")
    (tieneTipoIngrediente [Carne])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))

([Tomate] of Ingrediente
    (nombre "Tomate")
    (tieneTipoIngrediente [Verdura])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([QuesoMozzarella] of Ingrediente
    (nombre "QuesoMozzarella")
    (tieneTipoIngrediente [Lacteo])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Albahaca] of Ingrediente
    (nombre "Albahaca")
    (tieneTipoIngrediente [Aromatizante])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([AceiteOliva] of Ingrediente
    (nombre "Aceite de Oliva")
    (tieneTipoIngrediente [Grasa])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Miso] of Ingrediente
    (nombre "Miso")
    (tieneTipoIngrediente [Salsa])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Tofu] of Ingrediente
    (nombre "Tofu")
    (tieneTipoIngrediente [Legumbre])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Alga] of Ingrediente
    (nombre "Alga")
    (tieneTipoIngrediente [Verdura])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Cebolleta] of Ingrediente
    (nombre "Cebolleta")
    (tieneTipoIngrediente [Verdura])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([PescadoI] of Ingrediente
    (nombre "PescadoI")
    (tieneTipoIngrediente [Pescado])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Limon] of Ingrediente
    (nombre "Limón")
    (tieneTipoIngrediente [Fruta])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Cilantro] of Ingrediente
    (nombre "Cilantro")
    (tieneTipoIngrediente [Aromatizante])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Cebolla] of Ingrediente
    (nombre "Cebolla")
    (tieneTipoIngrediente [Verdura])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Ternera] of Ingrediente
    (nombre "Ternera")
    (tieneTipoIngrediente [Carne])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Parmesano] of Ingrediente
    (nombre "Parmesano")
    (tieneTipoIngrediente [Lacteo])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Calabaza] of Ingrediente
    (nombre "Calabaza")
    (tieneTipoIngrediente [Verdura])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Nata] of Ingrediente
    (nombre "Nata")
    (tieneTipoIngrediente [Lacteo])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Caldo] of Ingrediente
    (nombre "Caldo")
    (tieneTipoIngrediente [Liquido])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([PanI] of Ingrediente
    (nombre "PanI")
    (tieneTipoIngrediente [Pan])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Ajo] of Ingrediente
    (nombre "Ajo")
    (tieneTipoIngrediente [Condimento])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Quinoa] of Ingrediente
    (nombre "Quinoa")
    (tieneTipoIngrediente [Cereal])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Aguacate] of Ingrediente
    (nombre "Aguacate")
    (tieneTipoIngrediente [Fruta])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Pimiento] of Ingrediente
    (nombre "Pimiento")
    (tieneTipoIngrediente [Verdura])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Pepino] of Ingrediente
    (nombre "Pepino")
    (tieneTipoIngrediente [Verdura])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Atun] of Ingrediente
    (nombre "Atún")
    (tieneTipoIngrediente [Pescado])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([SalsaSoja] of Ingrediente
    (nombre "Salsa de Soja")
    (tieneTipoIngrediente [Salsa])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Sesamo] of Ingrediente
    (nombre "Sésamo")
    (tieneTipoIngrediente [FrutoSeco])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Garbanzo] of Ingrediente
    (nombre "Garbanzo")
    (tieneTipoIngrediente [Legumbre])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
([Tahini] of Ingrediente
    (nombre "Tahini")
    (tieneTipoIngrediente [Salsa])
    (disponibleEn [Enero] [Febrero] [Marzo] [Abril] [Mayo] [Junio] [Julio] [Agosto] [Septiembre] [Octubre] [Noviembre] [Diciembre]))
)