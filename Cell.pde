class Cell {

  PShape cellShape, flagShape, beeShape;

  int neighbouringBeeCount = 0;
  ArrayList<Cell> neighbours;

  int q, r;
  boolean bee = false, revealed = false, flagged = false;
  float size;
  PVector center;

  Cell(int q, int r, float size) {
    /**
    * Initialization method of a cell
    */
    this.q = q;
    this.r = r;
    this.size = size;

    // Shapes Initialization
    cellShape = cellShapeInit();
    flagShape = flagShapeInit();
    beeShape = beeShapeInit();

    /* Cell Center Calculation */
    float x = this.size * (1.5 * this.q);
    float y = this.size * (sqrt(3) * 0.5 * this.q + sqrt(3.0) * this.r);
    this.center = new PVector(x, y);
  }

  void leftClicked() {
    /**
    * Left click method of a cell
    */
    if (this.flagged) {
      // Remove flag if cell is flagged
      this.flagged = false;
      board.flagCount -= 1;
    } else if (!this.revealed) {
      this.revealCell();
      
      if (this.bee) {
        // Set gameOver flag if cell has bee
        gameOver = true;
      }
    }
  }

  void rightClicked() {
    /**
    * Right click method of a cell
    */
    if (!this.revealed) {
      this.flagged = !this.flagged;
      board.flagCount += 1;
    }
  }

  void revealCell() {
    /**
    * Reveal method of a cell
    */
    this.revealed = true;
    cellShape.setFill(revealedColor);
    if (this.neighbouringBeeCount == 0) {
      // Reveal adjacent cells if no neighbouring bee
      for (Cell c : this.neighbours) {
        if (!c.revealed) {
          c.revealCell();
        }
      }
    }
  }

  void show() {
    /**
    * Show method of a cell
    */
    pushMatrix();

    /* Draw Hexagon */
    translate(this.center.x, this.center.y);
    shape(cellShape, 0, 0);

    /* Draw Bee, Count, Flag */
    if (this.revealed) {
      if (this.bee) {
        /* Draw a bee */
        shape(beeShape, 0, 0);
      } else if (this.neighbouringBeeCount != 0) {
        /* Display Neigbouring Bee Count */
        fill(boundaryColor);
        textAlign(CENTER, CENTER);
        textSize(this.size);
        text(this.neighbouringBeeCount, 0, 0);
      }
    } else if (this.flagged) {
      /* Draw a Flag */
      shape(flagShape, 0, 0);
    }

    popMatrix();
  }
}
