// test for interserction with an array of lines
// set up an array of lines
// thanks to Wally Glutton see: https://www.openprocessing.org/sketch/135314
// click and drag mouse

float x1, y1, x2, y2, x3, y3, x4, y4;


float bx, by, dx, dy, cx, cy;
float b_dot_d_perp;
float t, u;

float userStartX, userStartY;

int numberOfLines = 3;
int[] startX = new int[numberOfLines];
int[] startY = new int[numberOfLines];

int[] endX = new int[numberOfLines];
int[] endY = new int[numberOfLines];

boolean intersects = false;

void setup() {
  size(800, 800);
}

void draw() {
  background(200);
  createTestLines();
  drawTestLines();

  // user line

  for (int n=0; n < numberOfLines; n++) {
    line_itersection(startX[n], startY[n], endX[n], endY[n], userStartX, userStartY, mouseX, mouseY, n);
  }

  line(userStartX, userStartY, mouseX, mouseY);
}


void createTestLines() {
  // create some test lines
  startX[0] = 0;
  startY[0] = height/2; 
  endX[0] = width;
  endY[0] = height/2;


  startX[1] = width/2;
  startY[1] = 0; 
  endX[1] = width/2;
  endY[1] = height;

  startX[2] = 0;
  startY[2] = height; 
  endX[2] = width;
  endY[2] = 0;
}

void drawTestLines() {
  for (int i = 0; i < numberOfLines; i++) {
    line(startX[i], startY[i], endX[i], endY[i]);
  }
}


void mousePressed() {
  userStartX = mouseX;
  userStartY = mouseY;
}

void line_itersection(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4, int n) {

  float bx = x2 - x1;
  float by = y2 - y1;
  float dx = x4 - x3;
  float dy = y4 - y3;

  float b_dot_d_perp = bx * dy - by * dx;
  if (b_dot_d_perp == 0) {
    println(" r1 n=" +n);
    intersects = true;
    return;
  }

  float cx = x3 - x1;
  float cy = y3 - y1;
  float t = (cx * dy - cy * dx) / b_dot_d_perp;
  if (t < 0 || t > 1) {
    println(" r2 n=" +n);
    intersects = true;
    return;
  }
  float u = (cx * by - cy * bx) / b_dot_d_perp;
  if (u < 0 || u > 1) {
    println(" r3 n=" +n);
    intersects = true;
    return;
  }

  // intersects?
  println(intersects + " n="+n);
}
