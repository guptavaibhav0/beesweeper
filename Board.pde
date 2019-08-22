class Board {
  Cell[] grid;
  float size;
  PVector origin = new PVector(width/2, height/2);
  int startTime, currentTime;
  int flagCount = 0;

  Board(int N, float cellSize) {
    /**
    * Initialization method of the board
    */
    this.size = cellSize;
    ArrayList<Cell> tempGrid = new ArrayList<Cell>();
    for (int x = -N; x <= N; x++) {
      for (int y = max(-N, -x-N); y <= min(+N, -x+N); y++) {
        tempGrid.add(new Cell(x, y, this.size));
      }
    }
    grid = tempGrid.toArray(new Cell[tempGrid.size()]);
    this.startTime = millis();
  }

  void show() {  
    /**
    * Show method of the board
    */  
    pushMatrix();
    
    // Translate to center
    translate(origin.x, origin.y);
    
    // Game Over & Game Won check
    boolean gameWonCheck = true;
    if (gameOver) {
      gameWonCheck = false;
      for (Cell c : grid) {
        c.revealCell();
      }
    } else {
      for (Cell c : grid) {
        if (!c.bee && !c.revealed) {
          gameWonCheck = false;
        }
      }
    }
    
    // Create a grid
    for (Cell c : grid) {
      c.show();
    }
    
    if (gameOver) {
      // Game Over
      noStroke();
      fill(255, 255, 255, 127);
      rectMode(CENTER);
      rect(0, 0, width, 200);
      fill(0, 0, 0);
      textSize(100);
      textAlign(CENTER, CENTER);
      text("Game Over...", 0, -40);
      textSize(60);
      text("Press SPACE to restart...", 0, 60);
    } else if (gameWonCheck) {
      // Game Won
      noStroke();
      fill(255, 255, 255, 127);
      rectMode(CENTER);
      rect(0, 0, width, 200);
      fill(0, 0, 0);
      textSize(100);
      textAlign(CENTER, CENTER);
      text("You Won...", 0, -40);
      textSize(60);
      text("Press SPACE to restart...", 0, 60);
    } else {
      // Update time
      currentTime = floor((millis() - this.startTime) / 100.0);
    }
    popMatrix();

    fill(0, 0, 0);
    textSize(60);

    // Display Time
    textAlign(LEFT, TOP);
    text("Time: " + nf(currentTime/10.0, 2, 1), 0, 0);
    
    // Display Flags
    textAlign(RIGHT, TOP);
    text("Flags: " + nf(this.flagCount, 2), width, 0);
  }

  void addBees(int totalBees) { 
    /**
    * Ass bees to the board
    */  
    int count = 0;
    while (count < totalBees) {
      int index = round(random(grid.length-1));
      if (!grid[index].bee) {
        grid[index].bee = true;
        count++;
      }
    }

    // Update neighbouring bees data in cell
    for (Cell c : grid) {
      countNeigbouringBees(c);
    }
  }

  ArrayList<Cell> getNeighbours(Cell inputCell) {
    /**
    * Get neighbours method of the board
    */  
    ArrayList<Cell> neighbours = new ArrayList<Cell>();
    int[][] axial_dir = {{+1, 0}, {-1, 0}, {+1, -1}, {-1, +1}, {0, -1}, {0, +1}};
    for (int i = 0; i<6; i++) {
      int dq = axial_dir[i][0];
      int dr = axial_dir[i][1];
      for (int j = 0; j<grid.length; j++) {
        if ((dq+inputCell.q == grid[j].q) && (dr+inputCell.r == grid[j].r)) {
          neighbours.add(grid[j]);
        }
      }
    }
    return neighbours;
  }

  Cell pixel2cell(int pixelX, int pixelY) { 
    /**
    * pixel2cell method of the board
    */  
    PVector pt = this.origin.copy();
    pt.sub(pixelX, pixelY);
    pt.div(this.size);

    float q = -2.0/3.0 * pt.x;
    float r = 1.0/3.0 * pt.x - sqrt(3.0)/3.0 * pt.y;

    int rounded_q = round(q);
    int rounded_r = round(r);
    int rounded_s = round(-q-r);

    float error_q = abs(q - rounded_q);
    float error_r = abs(q - rounded_s);
    float error_s = abs(q - rounded_s);

    if ((error_q > error_r) || (error_q > error_s)) {
      rounded_q = - rounded_r - rounded_s;
    } else if (error_r > error_s) {
      rounded_r = - rounded_q - rounded_s;
    }

    for (Cell cell : grid) {
      if ((rounded_q == cell.q) && (rounded_r == cell.r)) {
        return cell;
      }
    }
    return null;
  }

  void countNeigbouringBees(Cell c) {
    /**
    * count neighbouring bees method of the board
    */  
    c.neighbours = getNeighbours(c);
    for (Cell neighbourC : c.neighbours) {
      if (neighbourC.bee) {
        c.neighbouringBeeCount++;
      }
    }
  }
}
