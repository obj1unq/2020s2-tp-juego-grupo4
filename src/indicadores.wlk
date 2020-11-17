import wollok.game.*
import jugador.*
import config.*

class Numero{
	var property valor = null
	var property position = null//referencia para unidad de vida game.at(9,8)
	method image(){ return "nro" + valor.toString() + ".png"} 
}


object tablero{
	var property position = game.at(7,7)
	var property image = "cartelConIndicadores.png"
}

//Puede ser una imagen fija parte del fondo
object reloj{
	var property position = game.at(7,4)
	var property image = "tiempo.png"
}

object corazones{
	var property position = game.at(11,7)
	var property image = "corazon_f.png"
}




class ContadorGenerico {
	var property cantidad = null	
	var property decena = new Numero()
	var property unidad = new Numero()
	const decenaPosition = null
	const unidadPosition = null

	method iniciar() {
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
		if(fondo.terminoJuego()){
			fondo.pantallaFinal()
		}
	}
	
	method aumentar() {
		if(cantidad < 99) {
			cantidad++
			self.digitUpdate()
		}
	}
	

	
	method modificar(cuanto) {
        cantidad = (cantidad + cuanto).max(0).min(12)
        self.digitUpdate()
    }
	
}


//se setea cantidad en 5 a modo de prueba
object timer inherits ContadorGenerico(cantidad=30, decenaPosition=game.at(8,4), unidadPosition=game.at(9,4)) { }

object vida inherits ContadorGenerico(cantidad = 12, decenaPosition=game.at(8,8), unidadPosition=game.at(9,8)){}

object pasajeros inherits ContadorGenerico(cantidad=0, decenaPosition=game.at(8,7), unidadPosition=game.at(9,7)){}


object fondo {
	
const property position = game.origin()
//var property image = "background1.jpg"
var property imagen = true //true: background1.png | false: background2.png
var property finJuego = false


	method alternarImagen(){
		imagen = !imagen
	}
	method image(){
		if(self.terminoJuego()){
			return self.imagenFinDeJuego()
		}else{
			return self.imagenEnJuego()		
		}
	}
			
	//falta arreglar
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
	
	method imagenFinDeJuego(){ return "backgroundFinal.png" }
		
	method terminoJuego(){ return (timer.cantidad()==0 || vida.cantidad()==0) }

	method finDeJuego(){
		vida.decena().position(game.at(5,7))
		vida.unidad().position(game.at(6,7))
		
		pasajeros.decena().position(game.at(5,5))
		pasajeros.unidad().position(game.at(6,5))
		
		corazones.position(game.at(4,7))
		
		//saco indicadores de la vista
		//cuando intento removerlos tira errores
		//VER ESTE PROBLEMA. Esta es una solucion para probar el juego, no debe de ir!!!
		reloj.position(game.at(11,0))
		tablero.position(game.at(11,0))
		timer.decena().position(game.at(11,1))
		timer.unidad().position(game.at(11,2))
		
		
	}
	
	method pantallaFinal(){

		game.clear()
		game.addVisual(self)
		vida.iniciar()
		pasajeros.iniciar()
		self.finDeJuego()
		game.addVisual(corazones)
		
	}
}



