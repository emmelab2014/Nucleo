Sistema sistema;

void setup() {
  size(800,600);
  sistema = new Sistema(this,100);
  
  sistema.agregarModificador(mMover);
  sistema.agregarModificador(mGravedad);
  sistema.agregarModificador(mDibujar);
}

void draw() {
  background(0);
  
  sistema.actualizar();
}
