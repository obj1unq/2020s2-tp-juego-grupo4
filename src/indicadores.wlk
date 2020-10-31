import wollok.game.*
import jugador.*

class Numero{
	var property valor = null
	var property position = null//referencia para unidad de vida game.at(9,8)
	method image(){ return "nro" + valor.toString() + ".png"} 
}

class Actualizador{
	method update(unidad,decena,nivel){
		unidad.valor(self.conversionUnidad(nivel))
		decena.valor(self.conversionDecena(nivel))
	}
	method conversionUnidad(nivel){ return nivel % 10 }
	method conversionDecena(nivel){ return nivel.div(10) }			
	method actualizaValores(cantidad){
		//return self.updater() + cantidad
	}
}

object digitFactory{
	method nuevo(nroImagen, posicion){
		return new Numero(valor = nroImagen,position=posicion)
	}
}

object vidas inherits Actualizador{
	var property unidadVidas = digitFactory.nuevo(2,game.at(9,8))
	var property decenaVidas = digitFactory.nuevo(1,game.at(8,8))
	method unidad(){ return unidadVidas}
	method decena(){ return decenaVidas}
	method digitUpdate(unidad, decena){
		self.update(unidadVidas, decenaVidas, self.valores())
	}
	method valores(){ return personaje.energia()}

}
object pasajeros inherits Actualizador{
	var property unidadPasajeros = digitFactory.nuevo(0,game.at(9,7))
	var property decenaPasajeros = digitFactory.nuevo(0,game.at(8,7))
	method unidad(){ return unidadPasajeros}
	method decena(){ return decenaPasajeros}
	method digitUpdate(unidad, decena){
	//	self.update(unidadPasajeros, decenaPasajeros, self.valores())
	}
//	method valores(){ return personaje.pasajeros()}
		
}
object timer inherits Actualizador{
	var property unidadTiempo = digitFactory.nuevo(6,game.at(9,4))
	var property decenaTiempo = digitFactory.nuevo(0,game.at(8,4))
	var property tiempo = 60
	method unidad(){ return unidadTiempo}
	method decena(){ return decenaTiempo}
	method digitUpdate(unidad, decena){
		self.update(unidadTiempo, decenaTiempo, tiempo)
	}
	method segundero(){
		if(tiempo>0){
			tiempo--
		}else{
			tiempo=0
		}
		self.digitUpdate(unidadTiempo,decenaTiempo)
	}
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


