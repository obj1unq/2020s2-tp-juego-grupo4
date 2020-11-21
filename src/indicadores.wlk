import wollok.game.*
import jugador.*
import config.*

class Numero{
	var property valor = null
	var property position = null//referencia para unidad de vida game.at(9,8)
	method image(){ return "nro" + valor.toString() + ".png"} 
}



class Visuales{
	var property position = null
	var property image = null
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

object contadorPuntos inherits ContadorGenerico{
	var property centena = new Numero()
	
	
	override method iniciar() {
		cantidad = pasajeros.puntaje() + vida.puntaje()
		if(cantidad<1000){
			self.puntaje()
		}else{
			self.puntajeMax()
		//SONIDO
		var maximaPuntuacion = game.sound("maximaPuntuacion.mp3")
		maximaPuntuacion.play()
		//SONIDO
		
		}

	}
	
	method puntajeMax(){
		const maximo = new Visuales(position=game.at(5,2),image="corona.png")
		game.addVisual(maximo)
	}
	method puntaje(){
		centena.position(game.at(4,2))
		decena.position(game.at(5,2))
		unidad.position(game.at(6,2))

		self.digitUpdate()

		game.addVisual(centena)
		game.addVisual(decena)
		game.addVisual(unidad)		
		
	}

	override method digitUpdate() {
		centena.valor(cantidad.div(100))
		decena.valor((cantidad % 100).div(10))
		unidad.valor((cantidad % 100) % 10)
	}
	//HACER METODO QUE SI TIENE MAS DE 999 DIBUJE UNA CORONA COMO PUNTUACION MAXIMA
}


//se setea cantidad en 5 a modo de prueba
object timer inherits ContadorGenerico(cantidad=30, decenaPosition=game.at(8,4), unidadPosition=game.at(9,4)) { 
	const tiempo = 5
	method sumaTiempo(){ cantidad +=tiempo }
}

object vida inherits ContadorGenerico(cantidad = 12, decenaPosition=game.at(8,8), unidadPosition=game.at(9,8)){
	const puntos = 10//1 para prueba
	method puntaje(){
		return puntos*self.cantidad()
	}
}

object pasajeros inherits ContadorGenerico(cantidad=0, decenaPosition=game.at(8,6), unidadPosition=game.at(9,6)){
	const puntos = 1100 // 1 para prueba
	method puntaje(){
		return puntos*self.cantidad()
	}
}



object fondo {
	
const property position = game.origin()
//var property image = "background1.jpg"
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
	
	method imagenMenu(){ return "menuPrincipal.png"}
	
	method imagenFinDeJuego(){ return "backgroundFinal.png" }
		
	method terminoJuego(){ return ( vida.cantidad()==0 || timer.cantidad()==0 )}

	method pantallaFinal(){

		game.clear()
		game.addVisual(self)
		vida.iniciar()
		pasajeros.iniciar()
		visualesEnPantalla.finalDeJuego()

	}
}

