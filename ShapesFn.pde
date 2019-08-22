PShape cellShapeInit() { //<>//
  PShape cellShape = createShape();
  cellShape.beginShape();
  cellShape.fill(unrevealedColor);
  cellShape.strokeWeight(cellSize * 0.1);
  cellShape.stroke(boundaryColor);
  for (int i=0; i<6; i++) {  // Flat Top Hexagon
    cellShape.vertex(cellSize * cos(i * PI/3), 
      cellSize * sin(i * PI/3));
  }
  cellShape.endShape(CLOSE);
  
  return cellShape;
}

PShape flagShapeInit() {
  PShape flagShape = createShape();
  flagShape.beginShape();
  flagShape.noFill();
  flagShape.strokeWeight(cellSize * 0.1);
  flagShape.stroke(boundaryColor);
  flagShape.vertex(0, 0);
  flagShape.vertex(0.4 * cellSize, 0);
  flagShape.vertex(0, -0.4 * cellSize);
  flagShape.vertex(0, 0.4 * cellSize);
  flagShape.vertex(0.4 * cellSize, 0.4 * cellSize);
  flagShape.vertex(-0.4 * cellSize, 0.4 * cellSize);
  flagShape.endShape();
  return flagShape;
}

PShape beeShapeInit() {
  PShape beeShape = createShape(ELLIPSE, 0, 0, cellSize * 0.8, cellSize * 0.8);
  beeShape.setFill(boundaryColor);
  beeShape.setStroke(false);
  return beeShape;
}
