class Player
{
  char symbol;
  color col;
  
  Player(char s, color c)
  {
     symbol = s;
     col = c;
  }
  
  void drawSymbol()
  {
    fill(col);
    textAlign(CENTER, CENTER);
    textSize(cellWidth);
    text(symbol, 0, 0);
  }
}
