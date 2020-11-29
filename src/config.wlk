import wollok.game.*
import contadores.*
import jugador.*
import obstaculos.*


object inicioDeJuego {

	method iniciar() {
		
		//Visuales
		game.onTick(600, "Movimiento de calle", {fondo.alternarImagen()})//tenia 400ms
		
		visualesEnPantalla.iniciar()

		
		
		game.onTick(800, "NUEVO_AUTO", { calle.generarNuevoObjeto([calle.auto()])})
		game.onTick(1000, "NUEVO_OBSTACULO", { calle.generarNuevoObjeto(calle.obtaculosAGenerar())})
		game.onTick(300, "AVANZA_OBSTACULO", { calle.avanzar()})
		
		timer.iniciar()
		vida.iniciar()
		pasajeros.iniciar()
		
		vida.puntos(5)
		pasajeros.puntos(10)
		
		
		//config.configurarTeclas()
		config.contrarreloj()
		game.onCollideDo(personaje, { obstaculo => obstaculo.impacto(personaje) })
		sonidos.reproducirLoop("interiorAuto.mp3")
	}

}

class Visuales{
	var property position = null
	var property image = null
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


object fondo {
	
const property position = game.origin()

var property imagen = true //true: background1.png | false: background2.png
var property finJuego = false
var property menu = true
var property estado = true

	method alternarImagen(){
		imagen = !imagen
	}
	method image(){
		return
		if(menu){
			self.imagenMenu()
		}else{
			self.tipoFondo()
		}
	}	
	method tipoFondo(){
		return 
			if(estado){
				self.imagenEnJuego()
			}else{
				self.imagenFinDeJuego()
			}
	}
	/* 
	method fondoDeJuego(){	
		return
//		if(estadoJuego.terminoJuego()){
//			""//self.imagenFinDeJuego()
//		}
//		else{
			self.imagenEnJuego()		
//		}
	}*/
			

	method imagenEnJuego(){
		var imagenAMostrar = null
		if(imagen){
			imagenAMostrar = "background2.jpg"
		}else{
			imagenAMostrar = "background1.jpg"
		}	
		self.alternarImagen()
		return imagenAMostrar
	}
	
	method imagenMenu(){ return "menuPrincipal.png"}
	
	method imagenFinDeJuego(){ return "backgroundFinal.png" }
		
}

object estadoJuego{
		
	method terminoJuego(){ return ( vida.cantidad()==0 || timer.cantidad()==0 )}

	method pantallaFinal(){
		self.limpieza()
		fondo.estado(false)
		game.addVisual(fondo)
		vida.iniciar()
		pasajeros.iniciar()
		visualesEnPantalla.finalDeJuego()
		sonidos.interior().stop()
	}
	
	method reinicio(){
		self.limpieza()
		fondo.estado(true)
		vida.cantidad(vidasIniciales.vidas())
		timer.cantidad(tiempoDeJuego.tiempo())
		pasajeros.cantidad(0)
		fondo.menu(true)
		game.addVisual(fondo)
	
	}
		method limpieza(){
			calle.limpiezaObstaculosGenerados()
			game.clear()
			config.configurarTeclas()
		
	}
	
}


object config {
	var property testeo = false
	
	method configurarTeclas() {
		//movimientos
		keyboard.left().onPressDo({personaje.mover(-1)})
    	keyboard.right().onPressDo({personaje.mover(1)})
    	keyboard.enter().onPressDo({fondo.menu(false)
    								inicioDeJuego.iniciar()})
    	keyboard.r().onPressDo ({estadoJuego.reinicio()})
	}


	method contrarreloj(){
		game.onTick(1000,"tiempo",{timer.reducir()})
	}

}

object sonidos{
	var property interior

	method reproducir(pista){
		if(!config.testeo())
			game.sound(pista).play()
	}

	method reproducirLoop(pista){
		interior= game.sound(pista)
		interior.shouldLoop(true)
		if(!config.testeo()){
			interior.play()
		}
	}
	 
}