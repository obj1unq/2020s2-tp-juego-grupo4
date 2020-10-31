import wollok.game.*
import jugador.*

class Numero{
	var property valor = null
	var property position = null//referencia para unidad de vida game.at(9,8)
	method image(){ return "nro" + valor.toString() + ".png"} 
}


object tablero{
	var property position = game.at(7,7)
	var property image = "cartelConIndicadores.png"
}

object fondo {
	
const property position = game.origin()
var property image = "background1.jpg"

	method alternarImagen() {
		if(image == "background1.jpg") {
			image = "background2.jpg"
		}
		else {
			image = "background1.jpg"
		}
	}
	
}

//Puede ser una imagen fija parte del fondo
object reloj{
	var property position = game.at(7,4)
	var property image = "tiempo.png"
}


class ContadorGenerico {
	
var property cantidad = null	
var property decena = new Numero()
var property unidad = new Numero()
const decenaPosition = null
const unidadPosition = null

	method set() {
		decena.position(decenaPosition)
		unidad.position(unidadPosition)
		self.digitUpdate()
		game.addVisual(decena)
		game.addVisual(unidad)
	}

	method digitUpdate() {
		decena.valor(cantidad.div(10))
		unidad.valor(cantidad % 10)
	}
	
	method reducir() {
		if(cantidad > 0) {
			cantidad--
			self.digitUpdate()
		}
	}
	
	method aumentar() {
		if(cantidad < 99) {
			cantidad++
			self.digitUpdate()
		}
	}
	
	method reducir(cuanto) {
		cantidad = (cantidad - cuanto).max(0)
		self.digitUpdate()
	}
	
	method aumentar(cuanto) {
		cantidad = (cantidad + cuanto).max(99)
		self.digitUpdate()
	}
	
}



object timer inherits ContadorGenerico(cantidad=60, decenaPosition=game.at(8,4), unidadPosition=game.at(9,4)) { }

object extraTimer inherits ContadorGenerico(cantidad=0, decenaPosition=game.at(8,7), unidadPosition=game.at(9,7)) { }

object vida inherits ContadorGenerico(cantidad = 12, decenaPosition=game.at(8,8), unidadPosition=game.at(9,8)){}

// object pasajeros inherits ContadorGenerico(cantidad=0, decenaPosition=game.at(8,7), unidadPosition=game.at(9,7)){}


