class Cell
{
  PVector position;
  int col;
  int row;
  Player owner;

  Cell top = null;
  Cell top_right = null;
  Cell right = null;
  Cell bottom_right = null;
  Cell bottom = null;
  Cell bottom_left = null;
  Cell left = null;
  Cell top_left = null;

  Cell(int c, int r)
  {
    col = c;
    row = r;
    position = new PVector(col * cellWidth + cellWidth * 0.5, row * cellHeight + cellHeight * 0.5);
    owner = null;
  }

  void calculateNeighbors()
  {
    if (row - 1 > -1)top = cells[col][row - 1];
    if (row - 1 > -1 && col + 1 < COLS)top_right = cells[col + 1][row - 1];
    if (col + 1 < COLS)right = cells[col + 1][row];
    if (row + 1 < ROWS && col + 1 < COLS)bottom_right = cells[col + 1][row + 1];
    if (row + 1 < ROWS)bottom = cells[col][row + 1];
    if (row + 1 < ROWS && col - 1 > -1)bottom_left = cells[col - 1][row + 1];
    if (col - 1 > -1)left = cells[col - 1][row];
    if (col - 1 > -1 && row - 1 > -1)top_left = cells[col - 1][row -1];
  }

  void render()
  {
    pushMatrix();
    translate(position.x, position.y);
    noFill();
    stroke(0);
    strokeWeight(5);
    rect(0, 0, cellWidth, cellHeight);
    if (owner != null)
    {
      owner.drawSymbol();
    }
    popMatrix();
  }

  boolean mouseOver()
  {
    return mouseX > position.x - cellWidth * 0.5 &&
      mouseX < position.x + cellWidth * 0.5 &&
      mouseY > position.y - cellHeight * 0.5 &&
      mouseY < position.y + cellHeight * 0.5;
  }

  void setOwner(Player p)
  {
    if (owner != null)return;
    owner = p;
    calculateWinner();
    turn = 1 - turn;
  }

  void calculateWinner()
  {
    //vertical condition
    int counter = 1;
    Cell actualCell = this;
    while (actualCell.top != null)
    {
      actualCell = actualCell.top;
      if (this.owner == actualCell.owner)
      {
        ++counter;
      } else
      {
        break;
      }
    }
    actualCell = this;
    while (actualCell.bottom != null)
    {
      actualCell = actualCell.bottom;
      if (this.owner == actualCell.owner)
      {
        ++counter;
      } else
      {
        break;
      }
    }
    if (counter >= CONDITION)
    {
      finished = true;
      winner = owner.symbol + " WINS!";
      winner_color = owner.col;
    }

    //horizontal condition
    counter = 1;
    actualCell = this;
    while (actualCell.left != null)
    {
      actualCell = actualCell.left;
      if (this.owner == actualCell.owner)
      {
        ++counter;
      } else
      {
        break;
      }
    }
    actualCell = this;
    while (actualCell.right != null)
    {
      actualCell = actualCell.right;
      if (this.owner == actualCell.owner)
      {
        ++counter;
      } else
      {
        break;
      }
    }
    if (counter >= CONDITION)
    {
      finished = true;
      winner = owner.symbol + " WINS!";
      winner_color = owner.col;
    }

    //tl to br condition
    counter = 1;
    actualCell = this;
    while (actualCell.top_left != null)
    {
      actualCell = actualCell.top_left;
      if (this.owner == actualCell.owner)
      {
        ++counter;
      } else
      {
        break;
      }
    }
    actualCell = this;
    while (actualCell.bottom_right != null)
    {
      actualCell = actualCell.bottom_right;
      if (this.owner == actualCell.owner)
      {
        ++counter;
      } else
      {
        break;
      }
    }
    if (counter >= CONDITION)
    {
      finished = true;
      winner = owner.symbol + " WINS!";
      winner_color = owner.col;
    }

    //bl to tr condition
    counter = 1;
    actualCell = this;
    while (actualCell.bottom_left != null)
    {
      actualCell = actualCell.bottom_left;
      if (this.owner == actualCell.owner)
      {
        ++counter;
      } else
      {
        break;
      }
    }
    actualCell = this;
    while (actualCell.top_right != null)
    {
      actualCell = actualCell.top_right;
      if (this.owner == actualCell.owner)
      {
        ++counter;
      } else
      {
        break;
      }
    }
    if (counter >= CONDITION)
    {
      finished = true;
      winner = owner.symbol + " WINS!";
      winner_color = owner.col;
    }
  }
}
