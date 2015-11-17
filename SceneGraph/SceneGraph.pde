import remixlab.bias.branch.*;
import remixlab.bias.core.*;
import remixlab.bias.event.*;
import remixlab.dandelion.branch.*;
import remixlab.dandelion.constraint.*;
import remixlab.dandelion.core.*;
import remixlab.dandelion.geom.*;
import remixlab.fpstiming.*;
import remixlab.proscene.*;
import remixlab.util.*;

String renderer = P2D;
PGraphics portrait, zoom;
Horse horsep, horsez;
Window window;
Point prewMouseLocation, mouseLocation, pointDragged;
float sx, sy;
int w, h;
Line[] borders;
LineClippingFunction clipping;

void setup() {
  size(840, 600, P2D);
  w = width - 40;
  h = height - 40;
  portrait = createGraphics(width/5, height/4, renderer);
  zoom = createGraphics(width, height, renderer);
  horsep = new Horse(28, color(105, 201, 224));
  window = new Window(20);
  scaleHorse();
  borders = new Line[4];
  borders[0] = new Line(new Point(20, 20), new Point(20, height - 20));
  borders[1] = new Line(new Point(20, 20), new Point(width - 20, 20));
  borders[2] = new Line(new Point(width - 20, 20), new Point(width - 20, height - 20));
  borders[3] = new Line(new Point(20, height - 20), new Point(width - 20, height - 20));
  clipping =  new CohenSutherland();
}

void scaleHorse() {
  sx = h / window.getW();
  sy = w / window.getH();
  horsez = horsep.copy();
  horsez.scale(sx, sy);
}

void draw() {
  background(255);
  drawZoom();
  drawPortrait();
}

void drawZoom() {
  zoom.beginDraw();
  zoom.background(color(120, 120, 120));
  for(Line border: borders)
    border.draw(zoom, color(255, 255, 255));
  drawBigHorse(
    new Point((-window.getOrigin().x * sx) + 20, (-window.getOrigin().y * sy) + 20),
    horsez.getColor()
  );
  zoom.endDraw();
  image(zoom, 0, 0);
}

void drawBigHorse(Point translation, color c) {
  for(Line line: horsez.getLines()) {
    line.rotate(-window.getAngle());
    line.translate(translation);
    Line dw = clipping.cut(line, borders);
    if(dw != null)
      dw.draw(zoom, c);
  }
}

void drawPortrait() {
  portrait.beginDraw();
  portrait.background(color(100, 100, 100));
  window.draw(portrait);
  horsep.drawWhitRestoredLines(portrait);
  portrait.endDraw();
  image(portrait, 10 + (width * 0.80), 0);
}

boolean cinit = true;

void mouseClicked() {
  mouseLocation = new Point(mouseX, mouseY);
  
  if(cinit)
    cinit = false;
  else
    cinit = true;
  prewMouseLocation = mouseLocation;
}

boolean dinit = true;

void mouseDragged() {
  mouseLocation = new Point(mouseX, mouseY);
  
  cinit = true;
  if(dinit) {
    prewMouseLocation = mouseLocation;
    dinit = false;
  }
  float dx = mouseLocation.x - prewMouseLocation.x;
  float dy = mouseLocation.y - prewMouseLocation.y;
  
  if(pointDragged != null)
    pointDragged.translate(new Point(dx, dy));
  else {
    window.setCenter(new Point(
      window.getCenter().x + dx,
      window.getCenter().y + dy
    ));
  }
  prewMouseLocation = mouseLocation;
}
  
void mouseReleased() {
  dinit = true;
  pointDragged = null;
}

void mouseWheel(MouseEvent event) {
  int inc = (event.getCount() > 0)? 1 : (event.getCount() < 0)? -1 : 0;
  int wzoom = window.getZoom() + inc;
  if(wzoom > 4 && wzoom < 50) {
    window.setZoom(window.getZoom() + inc);
    scaleHorse();
  }
}

void keyReleased() {
  if(keyCode == 38)
    window.setAngle(window.getAngle() - (PI / 180));
  if(keyCode == 40)
    window.setAngle(window.getAngle() + (PI / 180));
}