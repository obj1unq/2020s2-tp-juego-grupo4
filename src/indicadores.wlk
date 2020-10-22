import wollok.game.*
import jugador.*

class Indicador {
	//ver si corresponde al jugador
	const nivelMin = null
	const nivelMax = null

// esto lo puede pedir al personaje
//	var property tiempo = null
//	var property nivelActual = null
	
	//No le corresponde al indicador la accion
//	method incrementaEnergia(personajePpal){ personajePpal.modificaEnergia(1)}
//	method decrementaEnergia(personajePpal){ personajePpal.modificaEnergia(-1)}
//	
		
//	method excedeNiveles(personajePpal){ 
//		const proximoNivel = personajePpal.nivelActual() + 1 
//		return proximoNivel.between(nivelMin,nivelMax)
//	}

	method muestraValores(vida, corazones){
//		indicadorVida.		
	}
}	
object indicadorVida inherits Indicador{
	var property valor = 12
//method
}


class Numero{
	var property image = null //ejemplo"nro1.png"
	var property position = null//referencia para unidad de vida game.at(9,8)
	var property valor = null
}

object vidasFactory{
	var property unidad = new Numero(image = "nro2.png", position=game.at(9,8), valor=2)
	var property decena = new Numero(image = "nro1.png", position=game.at(8,8), valor=1)
	var vidas = (decena.valor()*10)+unidad.valor()
}

object tiempoFactory{
	var property unidad = new Numero(image = "nro0.png", position=game.at(9,7), valor=0)
	var property decena = new Numero(image = "nro0.png", position=game.at(8,7), valor=0)
	var tiempo = (decena.valor()*10)+unidad.valor()
}





object decena{
	var property position = game.at(8,4)
	var property image = "nro6.png"
	const tiempoMax = 6
	var property tiempoContador = tiempoMax

	method tiempo(){ 
		
		tiempoContador--
		image = "nro" + tiempoContador.toString() + ".png"
		
	}
	
}

object unidad{
	var property position = game.at(9,4)
	var property image = "nro0.png"
	const tiempoMax = 9
	var property tiempoContador = 0

	method tiempo(){
		if(game.hasVisual(unidad) && game.hasVisual(decena)){
			game.removeVisual(unidad)
			game.removeVisual(decena)
		}
		if(tiempoContador >= 0){
			image = "nro" + tiempoContador.toString() + ".png"
			tiempoContador--
		}else{
			decena.tiempo()		
			tiempoContador = 9
		}

		game.addVisual(decena)
		game.addVisual(self)
	}
}




//Puede ser una imagen fija parte del fondo
object tablero{
	var property position = game.at(7,7)
	var property image = "cartelConIndicadores.png"
	
}

//Puede ser una imagen fija parte del fondo
object reloj{
	var property position = game.at(7,4)
	var property image = "tiempo.png"
}
