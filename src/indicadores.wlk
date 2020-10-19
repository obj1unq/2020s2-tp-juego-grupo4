import wollok.game.*
import jugador.*

class Indicador {
	const nivelMin = null
	const nivelMax = null
	var property position = game.at(8,9)
	var property image = null
	var property tiempo = null
	var property nivelActual = null
	
	method incrementaEnergia(personajePpal){ personajePpal.modificaEnergia(1)}
	method decrementaEnergia(personajePpal){ personajePpal.modificaEnergia(-1)}
	
		
	method excedeNiveles(personajePpal){ 
		const proximoNivel = personajePpal.nivelActual() + 1 
		return proximoNivel.between(nivelMin,nivelMax)
	}
	method muestraValores(personajePpal){
		game.say(self, personajePpal.energia().toString())
		
	}
	
}

object tablero{
	var property position = game.at(7,7)
	var property image = "cartelConIndicadores.png"
	
}
object reloj{
	var property position = game.at(7,4)
	var property image = "tiempo.png"
}

object timerMSD{
	var property position = game.at(8,4)
	var property image = "nro6.png"
	const tiempoMax = 6
	var property tiempoContador = tiempoMax

	method tiempo(){ 
		
		tiempoContador--
		image = "nro" + tiempoContador.toString() + ".png"
		
	}
	
}


object timerLSD{
	var property position = game.at(9,4)
	var property image = "nro0.png"
	const tiempoMax = 9
	var property tiempoContador = 0

	method tiempo(){
		if(game.hasVisual(timerLSD) && game.hasVisual(timerMSD)){
			game.removeVisual(timerLSD)
			game.removeVisual(timerMSD)
		}
		if(tiempoContador >= 0){
			
			image = "nro" + tiempoContador.toString() + ".png"
			tiempoContador--
		}else{
			timerMSD.tiempo()		
			tiempoContador = 9
		}

		game.addVisualIn(timerMSD,timerMSD.position())
		game.schedule(100,{})
		game.addVisualIn(self,position)
	}
	
}

