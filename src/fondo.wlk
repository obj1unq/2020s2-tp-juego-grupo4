import contadores.*

object pantalla{
	var property menu = true
	var property imagen = true //true: background1.png | false: background2.png	

	method alternarImagen(){
		imagen = !imagen
	}	
	
	method fondo(){
		if(menu){
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
	
	
}