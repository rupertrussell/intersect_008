// Thanks to: Wally Glutton https://www.openprocessing.org/user/4474
// Thanks to: https://www.openprocessing.org/sketch/135314 


PVector v1, v2, v3, v4, v5, v6;

class Line {
  PVector start, end;

  Line(PVector _start, PVector _end) {
    start = _start;
    end   = _end;
  }

  void set_start(PVector _start) {
    start = _start;
  }

  void set_end(PVector _end) {
    end = _end;
  }

  PVector get_start() {
    return start;
  }

  PVector get_end() {
    return end;
  }

  void draw() {
    line(start.x, start.y, end.x, end.y);
  }

  PVector line_itersection(Line one, Line two) {
    float x1 = one.get_start().x;
    float y1 = one.get_start().y;
    float x2 = one.get_end().x;
    float y2 = one.get_end().y;

    float x3 = two.get_start().x;
    float y3 = two.get_start().y;
    float x4 = two.get_end().x;
    float y4 = two.get_end().y;

    float bx = x2 - x1;
    float by = y2 - y1;
    float dx = x4 - x3;
    float dy = y4 - y3;

    float b_dot_d_perp = bx * dy - by * dx;

    if (b_dot_d_perp == 0) return null;

    float cx = x3 - x1;
    float cy = y3 - y1;

    float t = (cx * dy - cy * dx) / b_dot_d_perp;
    if (t < 0 || t > 1) return null;

    float u = (cx * by - cy * bx) / b_dot_d_perp;
    if (u < 0 || u > 1) return null;

    return new PVector(x1+t*bx, y1+t*by);
  }

  PVector intersects_at(Line other) {
    return line_itersection(this, other);
  }
}

PVector random_bounded_vector() {
  return new PVector(random(width), random(height));
}

Line the_user;
Line the_others[];
int NUMBER_OF_OTHERS = 3;

void initialize_lines() {
  the_others = new Line[NUMBER_OF_OTHERS];

 // create some test lines
  v1 = new PVector(0, height/2);
  v2 = new PVector(width,  height/2);
  
  v3 = new PVector(width/2, 0);
  v4 = new PVector(width/2, height);

  v5 = new PVector(0, height);
  v6 = new PVector(width, 0);

  the_others[0] = new Line(v1, v2);
  the_others[1] = new Line(v3, v4);
  the_others[2] = new Line(v5, v6);

   the_user  = new Line(new PVector(0, 0), new PVector(width, height));
}

void setup() {
  size(450, 450);
  smooth();
  fill(color(240, 10, 20));
  initialize_lines();
}

void draw() {
  background(255);
  the_user.set_end(new PVector(mouseX, mouseY));

  for (int i = 0; i < NUMBER_OF_OTHERS; i++) {
    PVector intersection = the_user.intersects_at(the_others[i]);
    if (intersection != null) {
      ellipse(intersection.x, intersection.y, 15, 15);
    }
    the_others[i].draw();
  }

  the_user.draw();
}

void mouseClicked() {
  initialize_lines();
}
