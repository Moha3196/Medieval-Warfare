class HUD {
  int selectorX, selectorY;
  
  int row = 1;

  HUD () {
    
    
    selectorX = 25;
    selectorY = 115;
    
    
    
  }


  void selector(int row) {  //the arrow that indicates the selected lane
    
    circle(selectorX, selectorY + (75 * row), 30);  //placeholder
    
  }
}
