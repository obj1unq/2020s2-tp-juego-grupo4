import wollok.game.*
import indicadores.*
import jugador.*
import obstaculos.*

object inicioDeJuego {

	method iniciar() {
		
		
		//Visuales
		game.onTick(600, "Movimiento de calle", {fondo.alternarImagen()})//tenia 400ms
		//game.addVisual(fondo)
		visualesEnPantalla.iniciar()

		game.sound("interiorAuto.mp3").play()
		
		game.onTick(800, "NUEVO_AUTO", { calle.generarNuevoObjeto([calle.auto()])})
		game.onTick(2000, "NUEVO_OBSTACULO", { calle.generarNuevoObjeto(calle.obtaculosAGenerar())})
		game.onTick(2000, "NUEVO_AYUDA", { calle.generarNuevoObjeto(calle.ayudasAGenerar())})
		game.onTick(300, "AVANZA_OBSTACULO", { calle.avanzar()})
		
		timer.iniciar()
		vida.iniciar()
		pasajeros.iniciar()
		
		vida.puntos(5)
		pasajeros.puntos(10)
		
		
		//config.configurarTeclas()
		config.contrarreloj()
		game.onCollideDo(personaje, { obstaculo => obstaculo.impacto(personaje) })
		
			}

}

object visualesEnPantalla{
	method iniciar(){
		const tablero = new Visuales(position = game.at(7,6),image = "cartel.png")
		const reloj = new Visuales(position = game.at(7,4), image = "tiempo.png")
		game.addVisual(personaje)
		game.addVisual(tablero)
		game.addVisual(reloj)
		

	
	}
	method finalDeJuego(){
		const corazones = new Visuales(position = game.at(2,6), image = "corazon.png")
		const pasajero = new Visuales(position = game.at(2,4), image = "pasajero.png")
		const copa = new Visuales(position = game.at(2,2), image="copa.png")

		vida.decena().position(game.at(4,6))
		vida.unidad().position(game.at(5,6))
		
		pasajeros.decena().position(game.at(4,4))
		pasajeros.unidad().position(game.at(5,4))
		
		
		game.addVisual(corazones)
		game.addVisual(pasajero)
		game.addVisual(copa)
		contadorPuntos.iniciar()
				
	}
	
}



object config {

	method configurarTeclas() {
		//movimientos
		keyboard.left().onPressDo({personaje.mover(-1)})
    	keyboard.right().onPressDo({personaje.mover(1)})
    	keyboard.enter().onPressDo({fondo.menu(false)
    								inicioDeJuego.iniciar()})
    	keyboard.r().onPressDo ({fondo.reinicio() 
    							//self.configurarTeclas()
    							})
	}


	method contrarreloj(){
		game.onTick(1000,"tiempo",{timer.reducir()})
	}

}





