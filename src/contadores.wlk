import wollok.game.*
import jugador.*
import config.*
import obstaculos.*

//VER CLASES UNIDAD DECENA CENTENA
class Numero{
	var property valor = null
	var property position = null//referencia para unidad de vida game.at(9,8)
	method image(){ return "nro" + valor.toString() + ".png"} 
}



class ContadorGenerico {
	var property cantidad = null	
	var property decena = new Numero()
	var property unidad = new Numero()
	const decenaPosition = null
	const unidadPosition = null
	var property puntos = null

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
	//Se deja reducir en el contador generico porq se usa tanto en el timer 
	//como en los corazones

	method reducir() {
		if(cantidad > 0) {
			cantidad--
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
		cantidad = personaje.puntajeFinal()
		if(cantidad.between(1,1000)){
			self.puntaje()
		}
		if(cantidad==0){
			self.puntaje()
			if(!config.testeo())
				game.sound("noPuntos.mp3").play()
			
			}
		if(cantidad>1000){
			self.puntajeMax()
			if(!config.testeo())
				game.sound("maximaPuntuacion.mp3").play()
		
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
}



object timer inherits ContadorGenerico(cantidad=30, decenaPosition=game.at(8,4), unidadPosition=game.at(9,4)) { 
	const tiempo = 5
	method sumaTiempo(){ cantidad +=tiempo }

	override method reducir() {
		super()
		if(fondo.terminoJuego()){
			fondo.pantallaFinal()
		}
	}	
}

object vida inherits ContadorGenerico(cantidad = 12, decenaPosition=game.at(8,8), unidadPosition=game.at(9,8)){
	
	method puntaje(){
		return puntos*self.cantidad()
	}
}

object pasajeros inherits ContadorGenerico(cantidad=0, decenaPosition=game.at(8,6), unidadPosition=game.at(9,6)){
	
	method puntaje(){
		return puntos*self.cantidad()
	}
	
	method aumentar() {
		if(cantidad < 99) {
			cantidad++
			self.digitUpdate()
		}
	}
}



