import wollok.game.*
import indicadores.*
import jugador.*
import obstaculos.*

object inicioDeJuego {

	method iniciar() {
		
		
		//Visuales
		game.onTick(400, "Movimiento de calle", {fondo.alternarImagen()})
		//game.addVisual(fondo)
		game.addVisual(tablero)
		game.addVisual(personaje)
		game.addVisual(reloj)
		game.addVisual(corazones)
		
		game.onTick(800, "NUEVO_AUTO", { calle.generarNuevoObjeto([calle.auto()])})
		game.onTick(2000, "NUEVO_OBSTACULO", { calle.generarNuevoObjeto(calle.obtaculosAGenerar())})
		game.onTick(2000, "NUEVO_AYUDA", { calle.generarNuevoObjeto(calle.ayudasAGenerar())})
		game.onTick(300, "AVANZA_OBSTACULO", { calle.avanzar()})
		
		timer.iniciar()
		vida.iniciar()
		pasajeros.iniciar()
		
		
		//config.configurarTeclas()
		config.contrarreloj()
		game.onCollideDo(personaje, { obstaculo => obstaculo.impacto(personaje) })
		
			}

}


object config {

	method configurarTeclas() {
		//movimientos
		keyboard.left().onPressDo({personaje.mover(-1)})
    	keyboard.right().onPressDo({personaje.mover(1)})
    	keyboard.enter().onPressDo({inicioDeJuego.iniciar()
    								fondo.menu(false)})
	}
	method removerVisuales(){
		game.removeVisual(tablero)
		game.removeVisual(personaje)
	}
	method contrarreloj(){
		game.onTick(1000,"tiempo",{timer.reducir()})
	}

}




