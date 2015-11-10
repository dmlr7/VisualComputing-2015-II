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

void setup() {
  size(840, 600, P2D);
  portrait = createGraphics(width/5, height/4, renderer);
  zoom = createGraphics(width, height, renderer);
  horsep = new Horse(28, color(105, 201, 224));
  window = new Window(20);
  scaleHorse();
}

void scaleHorse() {
  sx = height / window.getW();
  sy = width / window.getH();
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
  zoom.pushMatrix();
  zoom.translate(-window.getOrigin().x * sx, -window.getOrigin().y * sy);
  horsez.draw(zoom);
  zoom.popMatrix();
  zoom.endDraw();
  image(zoom, 0, 0);
}

void drawPortrait() {
  portrait.beginDraw();
  portrait.background(color(100, 100, 100));
  window.draw(portrait);
  horsep.draw(portrait);
  portrait.endDraw();
  image(portrait, width * 0.80, 0);
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
    pointDragged.movePoint(dx, dy);
  else {
    window.setOrigin(new Point(
      window.getOrigin().x + dx,
      window.getOrigin().y + dy
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
  if(wzoom > 4 && wzoom < 21) {
    window.setZoom(window.getZoom() + inc);
    scaleHorse();
  }
}