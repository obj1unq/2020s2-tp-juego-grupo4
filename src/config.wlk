import wollok.game.*
import indicadores.*
import jugador.*
import obstaculos.*

object inicioDeJuego {

	method iniciar() {
		
		//Visuales
		game.addVisual(tablero)
		game.addVisual(personaje)
		game.addVisual(reloj)
		game.addVisual(unidad)
		game.addVisual(decena)
		config.configurarTeclas()
		game.onTick(1000,"tiempo",{unidad.tiempo()})
		game.whenCollideDo(personaje, { obstaculo => obstaculo.impacto() })
		
		
	}

}


object config {

	method configurarTeclas() {
		//movimientos
		keyboard.left().onPressDo({personaje.mover(-1)})
    	keyboard.right().onPressDo({personaje.mover(1)})
	}
}




