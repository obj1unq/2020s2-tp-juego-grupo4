import wollok.game.*
import contadores.*
import jugador.*
import obstaculos.*


object inicioDeJuego {
	var property interior

	method iniciar() {
		
		//Visuales
		game.onTick(600, "Movimiento de calle", {fondo.alternarImagen()})//tenia 400ms
		//game.addVisual(fondo)
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
		interior = game.sound("interiorAuto.mp3")
		if(!config.testeo()){
			interior.shouldLoop(true)
			interior.play()
		}
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


	method alternarImagen(){
		imagen = !imagen
	}
	method image(){
		if(self.menu()){
			return self.imagenMenu()
		}
		else if(self.terminoJuego()){
			return self.imagenFinDeJuego()
		}
		else{
			return self.imagenEnJuego()		
		}
	}
			

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
		
	method terminoJuego(){ return ( vida.cantidad()==0 || timer.cantidad()==0 )}

	method pantallaFinal(){

		game.clear()
		config.configurarTeclas()
		game.addVisual(self)
		vida.iniciar()
		pasajeros.iniciar()
		visualesEnPantalla.finalDeJuego()
		inicioDeJuego.interior().stop()
	}
	
	method reinicio(){
		game.clear()
		config.configurarTeclas()
		calle.obtaculosGenerados().clear()
		vida.cantidad(12)
		timer.cantidad(60)
		pasajeros.cantidad(0)
		self.menu(true)
		game.addVisual(self)
	
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
    	keyboard.r().onPressDo ({fondo.reinicio() 
    							//self.configurarTeclas()
    							})
	}


	method contrarreloj(){
		game.onTick(1000,"tiempo",{timer.reducir()})
	}

}

