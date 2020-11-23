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


//Se le agrega s- a cada objeto para identificar que es un sonido

object s_obstaculo{
	method play(){
		game.sound("choque.mp3").play()
	}
}
object s_barril{}
object s_corazon{
	method play(){	
		game.sound("corazon.mp3").play()
	}
}
//}
//object s_tiempo{
//	var pista = game.sound("tiempo.mp3")
//	method play(){
//		pista.play()
//	}
//}
//object s_aceite{
//	var pista = game.sound("aceite.mp3")
//	method play(){
//		pista.play()
//	}
//}
//object s_pasajero{
//	var pista = game.sound("aceite.mp3")
//	method play(){
//		pista.play()
//	}
//}
//
//




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
    	keyboard.r().onPressDo { 
    		game.clear()
    		self.configurarTeclas()
    		fondo.menu(true)
    		vida.cantidad(12)
    		timer.cantidad(60)
    		pasajeros.cantidad(0)
    		calle.obtaculosGenerados().clear()
			calle.ayudasGeneradas().clear()
    		game.addVisual(fondo)
		}
	}


	method contrarreloj(){
		game.onTick(1000,"tiempo",{timer.reducir()})
	}

}





