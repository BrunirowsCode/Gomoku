final int COLS = 20;
final int ROWS = 20;
final int CONDITION = 7;
final char P1_SYMBOL = 'X';
final char P2_SYMBOL = 'O';
final color P1_COLOR = color(255, 0, 0);
final color P2_COLOR = color(0, 0, 255);

float cellWidth;
float cellHeight;
boolean finished = false;
String winner = "";
color winner_color = color(0);

Cell[][] cells = new Cell[COLS][ROWS];
Player p1, p2;
int turn = 0;

void setup()
{
  size(1000, 1000);
  rectMode(CENTER);
  cellWidth = width / COLS;
  cellHeight = height / ROWS;

  p1 = new Player(P1_SYMBOL, P1_COLOR);
  p2 = new Player(P2_SYMBOL, P2_COLOR);



  for (int i = 0; i < COLS; ++i)
  {
    for (int j = 0; j < ROWS; ++j)
    {
      cells[i][j] = new Cell(i, j);
    }
  }
  for (int i = 0; i < COLS; ++i)
  {
    for (int j = 0; j < ROWS; ++j)
    {
      cells[i][j].calculateNeighbors();
    }
  }

  background(255);
}

void draw()
{
  for (int i = 0; i < COLS; ++i)
  {
    for (int j = 0; j < ROWS; ++j)
    {
      cells[i][j].render();
    }
  }
  textSize(200);
  fill(winner_color);
  text(winner, width * 0.5, height * 0.5);
}

void mousePressed()
{
  if (finished == true)return;
  for (int i = 0; i < COLS; ++i)
  {
    for (int j = 0; j < ROWS; ++j)
    {
      Cell c = cells[i][j];
      if (c.mouseOver())
      {
        c.setOwner(turn == 0 ? p1 : p2);
        break;
      }
    }
  }
}
