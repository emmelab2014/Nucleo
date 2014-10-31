class Atr_Color extends Atributo{
  static String key = "Color";
  String getKey() {
    return key;
  }
  Atributo soloPonerNewX() {
    return new Atr_Color();
  }
  Atributo[] soloPonerNewArray(int tam) {
    return new Atr_Color[tam];
  }
  //;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  //;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
  int col;
  
  Atributo[] iniciar(Sistema s, Atributo[] nuevas){
    for(int i=0; i<nuevas.length; i++){
      Atr_Color c= (Atr_Color) nuevas[i];
      
      float loteria=s.p5.random(1);
      if(loteria<0.5){
        c.col = s.p5.color(0,255,0);
      }else{
        c.col = s.p5.color(255,0,0);
      }
      
    }
    return nuevas;
  }
}
