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
		game.addVisual(timer.unidadTiempo())
		game.addVisual(timer.decenaTiempo())
//		game.addVisual(tiempoExtra.unidadTiempoExtra())
//		game.addVisual(tiempoExtra.decenaTiempoExtra())
		game.addVisual(vidas.unidadVidas())
		game.addVisual(vidas.decenaVidas())
		
		
		
		
		config.configurarTeclas()
		game.onTick(1000,"tiempo",{timer.segundero()})
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




