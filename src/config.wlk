import wollok.game.*
import indicadores.*
import jugador.*
import obstaculos.*

object inicioDeJuego {

	method iniciar() {
		
		//Visuales
		game.onTick(400, "Movimiento de calle", {fondo.alternarImagen()})
		game.addVisual(fondo)
		game.addVisual(tablero)
		game.addVisual(personaje)
		game.addVisual(reloj)
		game.addVisual(corazones)
		
		timer.iniciar()
		vida.iniciar()
		pasajeros.iniciar()
		
		
		config.configurarTeclas()
		config.contrarreloj()
		game.onCollideDo(personaje, { obstaculo => obstaculo.impacto(personaje) })
		
			}

}


object config {

	method configurarTeclas() {
		//movimientos
		keyboard.left().onPressDo({personaje.mover(-1)})
    	keyboard.right().onPressDo({personaje.mover(1)})
	}
	method removerVisuales(){
		game.removeVisual(tablero)
		game.removeVisual(personaje)
	}
	method contrarreloj(){
		game.onTick(1000,"tiempo",{timer.reducir()})
	}

}




