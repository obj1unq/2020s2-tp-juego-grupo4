import wollok.game.*
import indicadores.*
import jugador.*
import obstaculos.*

object inicioDeJuego {

	method iniciar() {
		//Declaracion de Objetos
		var obstaculoAuto = new Obstaculo(energiaQueQuita=4 , image="auto_rojo.png", position=game.at(1,0))
		
		//Visuales
		game.addVisual(tablero)
		game.addVisual(personaje)
		game.addVisual(reloj)
		game.addVisual(unidad)
		game.addVisual(decena)
		game.addVisual(obstaculoAuto)
		config.configurarTeclas()
		game.onTick(1000,"tiempo",{unidad.tiempo()})
		game.onCollideDo(personaje, { obstaculo => obstaculo.impactoA(personaje)})
		
	}

}


object config {

	method configurarTeclas() {
		//movimientos
		keyboard.left().onPressDo({personaje.mover(-1)})
    	keyboard.right().onPressDo({personaje.mover(1)})
	}
}




