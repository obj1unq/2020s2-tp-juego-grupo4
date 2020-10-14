# Autos Locos

Idea General del Proyecto

Realizar un programa que represente un juego en el cual se pueda manejar un auto para esquivar distintos obstáculos y/o ganar determinadas habilidades.

inicia el juego con 12[a definir] corazones.

Definir fin de nivel(visual) o fin de juego

Definir colisión de obstáculos(visual).

El juego es contrarreloj. Tenemos 60 segundos para recorrer la pista
Al final del juego, se hace una equivalencia entre tiempo restante y corazones


Pista (6 cuadros)
Cesped (2 de cada lado)
Cuadro de 10x10 cuadros

Elementos

  Clase de indicadores - Juanse
   +Indicadores de vida(corazones)

   +indicador de tiempo

Objeto de tipo automóvil

Auto manejado por quien juega

Clase de tipo obstáculos - Leandro

Autos: quitan 4 corazones.  

Barriles: quita 2 corazones. 

Baches: quita 1 corazon


Clase de tipo ayuda - Franco 

Persona en la pista: te suma 1 corazón. 

Corazones : te suma una vida hasta llegar al máximo de 12.

Objetos de tipo ayuda que accionan - Fabian.

Manchas de Aceite: hace que el auto se desplace una celda más con el sentido en el que venía.

Botella de Nitro: aumenta la velocidad *2(a ver). Y no afectan las colisiones con obstáculos, solo las ayudas.

/*******CONSULTAR************/
Reloj: Aumenta el tiempo de refresco en que se mueven los obstáculos permitiéndonos más tiempo para reaccionar(sería como ralentizar todo) incluyendo el contador de tiempo si lo hubiese. 
