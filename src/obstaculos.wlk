import indicadores.*
import jugador.* 
import wollok.game.*

class ObjetoEnPista {
	
	var property position = null //referencia : game.at(1,0)
	var property image = null
	var property objeto = null
	 
	method tipoDeObjeto(tipo){
		return tipo == objeto
	}
	
	method impacto(alguien)
	
	method avanzar() {
		position = position.down(1)
		if(position.y() < 0) {
			calle.limpiar(self)
			game.removeVisual(self)
		}
	}
	
}

class ObjetoAcumulador inherits ObjetoEnPista {
	
	
	override method impacto(alguien){
		alguien.impactaPasajero()
	}
}

class ObjetoEnergia inherits ObjetoEnPista {
	
	var property energiaEfectuada = 0
	
	override method impacto(alguien) {
		alguien.modificaEnergia(energiaEfectuada)
	}
	
}


class ObjetoMovimiento inherits ObjetoEnPista {
	
	
	override method impacto(alguien) {
		alguien.moverDeMas()
	}
	
}

object energia {}
object acumulador{}
object movimiento{}



object calle {
	
const property barril = new ObjetoEnergia(image="barril.png", energiaEfectuada = -2,objeto=energia)
const property auto = new ObjetoEnergia(image="auto_rojo.png", energiaEfectuada = -4,objeto=energia)
const property bache = new ObjetoEnergia(image="bache.png", energiaEfectuada = -1,objeto=energia)
const property corazon = new ObjetoEnergia(image="corazon_f.png", energiaEfectuada = 1,objeto=energia)
const property persona = new ObjetoAcumulador(image="nazi_malo.png",objeto=acumulador)	
const property nitro = new ObjetoMovimiento(image="nitro_f.png",objeto=movimiento)
const property aceite = new ObjetoMovimiento(image="aceite.png",objeto=movimiento)
	
const property obtaculosAGenerar = [barril, auto, bache, aceite ] //ANYONE SIRVE SOLO CON LISTA
const property ayudasAGenerar = [persona, corazon, nitro]
const property obtaculosGenerados = []
const property ayudasGeneradas = []
	
	method generarNuevoObjeto(lista) {
		
		const posicion = randomizer.emptyPosition()
        const objetoAGenerar = lista.anyOne()
        					   //randomizer.anyObject(objetosAGenerar)
        const objetoGenerado = factory.generate(objetoAGenerar, posicion)
        
        if(lista == obtaculosAGenerar ) {
        	obtaculosGenerados.add(objetoGenerado)
       		game.addVisual(objetoGenerado)
        }
        else{
        	ayudasGeneradas.add(objetoGenerado)
       		game.addVisual(objetoGenerado)
        }
        
	}
	
	
	method avanzar(){
		
		obtaculosGenerados.forEach( {objeto => objeto.avanzar() })
		ayudasGeneradas.forEach( {objeto => objeto.avanzar() })
	}
	
	
	method limpiar(obj) {
		
		obtaculosGenerados.remove(obj)
		ayudasGeneradas.remove(obj)
	}
	
}


object factory {
	
	method generate(struct, pos) {
		return
		if(struct.tipoDeObjeto(movimiento) ) {
			new ObjetoMovimiento(position=pos, image=struct.image()) 
			
		}
		else if(struct.tipoDeObjeto(acumulador) ){
			new ObjetoAcumulador(position=pos, image=struct.image())
		}
		else {
			new ObjetoEnergia(position=pos, image=struct.image(), energiaEfectuada=struct.energiaEfectuada())
		}
	}
	
}



object randomizer {	
	
	method emptyPosition() {
		const position = game.at((1 .. game.width() - 4).anyOne(), game.height() - 1)
		return
		if(game.getObjectsIn(position).isEmpty()) {
			position
		}
		else { 
			self.emptyPosition()
		}
	}
	
	method anyObject(ls) {
		return ls.anyOne()
	}
	
}