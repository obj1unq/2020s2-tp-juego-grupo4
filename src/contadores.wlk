import wollok.game.*
import jugador.*
import config.*
import obstaculos.*

class Numero{
	var property valor = null
	var property position = null
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
    
    method puntaje(){
		return puntos*self.cantidad()
	}
}

object contadorPuntos inherits ContadorGenerico{
	var property centena = new Numero()
	
	
	override method iniciar() {
		cantidad = personaje.puntajeFinal()
		if(cantidad.between(1,1000)){
			self.puntajeVisuales()
		}
		if(cantidad==0){
			self.puntajeVisuales()
					   
			sonidos.reproducir("noPuntos.mp3")			
   
		}
		if(cantidad>1000){
			self.puntajeMax()
					   
			sonidos.reproducir("maximaPuntuacion.mp3")
  
		}

	}
	
	method puntajeMax(){
		const maximo = new Visual(position=game.at(5,2),image="corona.png")
		game.addVisual(maximo)
	}
	method puntajeVisuales(){
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
object tiempoDeJuego{
	method tiempo(){
		return 60
	}
}
object vidasIniciales{
	method vidas(){
		return 12
	}
}


object timer inherits ContadorGenerico(cantidad=tiempoDeJuego.tiempo(), decenaPosition=game.at(8,4), unidadPosition=game.at(9,4)) { 
	const tiempo = 5
	
	method sumaTiempo(){ cantidad +=tiempo }

	override method reducir() {
		super()
		if(estadoJuego.terminoJuego()){
			estadoJuego.pantallaFinal()
			
		}
	}	
}

object vida inherits ContadorGenerico(cantidad = vidasIniciales.vidas(), decenaPosition=game.at(8,8), unidadPosition=game.at(9,8)){}

object pasajeros inherits ContadorGenerico(cantidad=0, decenaPosition=game.at(8,6), unidadPosition=game.at(9,6)){
	

	method aumentar() {
		if(cantidad < 99) {
			cantidad++
			self.digitUpdate()
		}
	}
}



