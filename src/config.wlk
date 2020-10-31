import wollok.game.*
import indicadores.*
import jugador.*
import obstaculos.*

object inicioDeJuego {

	method iniciar() {
		
		//Visuales
		game.addVisual(fondo)
		game.onTick(250, "Movimiento de calle", {fondo.alternarImagen()})
		
		
		game.addVisual(tablero)
		game.addVisual(personaje)
		game.addVisual(reloj)
		
		timer.set()
		vida.set()
		extraTimer.set()
		
//		game.addVisual(timer.unidadTiempo())
//		game.addVisual(timer.decenaTiempo())
//		game.addVisual(tiempoExtra.unidadTiempoExtra())
//		game.addVisual(tiempoExtra.decenaTiempoExtra())
//		game.addVisual(vidas.unidadVidas())
//		game.addVisual(vidas.decenaVidas())
		
		
		config.configurarTeclas()
		game.onTick(1000,"tiempo",{timer.reducir()})
		game.whenCollideDo(personaje, { obstaculo => obstaculo.impacto(personaje) })
		
		
	}

}


object config {

	method configurarTeclas() {
		//movimientos
		keyboard.left().onPressDo({personaje.mover(-1)})
    	keyboard.right().onPressDo({personaje.mover(1)})
	}
}




