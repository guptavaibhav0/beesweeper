/**
 * <h1>BeeSweeper</h1>
 * Minesweeper variant with hexagonal beehive and bees
 *
 * Inspired from "Coding Challenge #71" by "The Coding Train"
 * YouTube: https://www.youtube.com/watch?v=LFU5ZlrR21E
 *
 * @author  Vaibhav Gupta
 * @version 0.5
 * @since   2019-08-22
 *
 */

int N = 6;          // Hexagonal grid size
int totalBees = 25; // Total number of bees
float cellSize;

/* Hexadecimal Colors for grid */
color revealedColor   = #913a00;
color boundaryColor   = #de874c;
color unrevealedColor = #d05400;

/* Game Board */
Board board;
boolean gameOver = false;

void setup() {
  /**
   * Main Setup
   */

  //size(1000, 1000);
  fullScreen();
  pixelDensity(displayDensity()); // Normalization for high density screens

  // Calculate cell size based on grid size and window size
  cellSize = min(
    height / sqrt(3) / (2*N+1) * 0.95, 
    width / (3*N+2) * 0.95);

  // Initialize new board
  board = new Board(N, cellSize);
  board.addBees(totalBees);
}

void draw() {
  background(201);
  board.show();
}

void mousePressed() {
  if (!gameOver) {
    if (mouseButton == LEFT) {
      // left click
      Cell c = board.pixel2cell(mouseX, mouseY);
      if (c != null) {
        c.leftClicked();
      }
    } else if (mouseButton == RIGHT) {
      // right click
      Cell c = board.pixel2cell(mouseX, mouseY);
      if (c!=null) {
        c.rightClicked();
      }
    }
  }
}

void keyPressed() {
  if (keyCode == 32) {
    // space bar
    if (gameOver) {
      gameOver = false;
      board = new Board(N, cellSize);
      board.addBees(totalBees);
    }
  }
}
