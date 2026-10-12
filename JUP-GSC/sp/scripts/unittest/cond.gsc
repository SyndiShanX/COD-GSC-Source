/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\unittest\cond.gsc
***********************************************/



#using scripts\unittest\util;
#namespace unittest_cond;

function vars() {
  x = 0;
  y = 1;
  a = x < y;
  test_print("x < y: " + a);
  a = !(x < y);
  test_print("!(x < y): " + a);
  a = !x;
  test_print("!x: " + a);
  a = !x + y;
  test_print("!x + y: " + a);
  a = !(!x + y);
  test_print("!(!x + y): " + a);
  a = x != y && y != x;
  test_print("(x != y) && (y != x): " + a);
  a = !(x != y) && !(y != x);
  test_print("!(x != y) && !(y != x): " + a);
  a = !(!(x != y) && !(y != x));
  test_print("!(!(x != y) && !(y != x)): " + a);
  a = x != y || y != x;
  test_print("(x != y) || (y != x): " + a);
  a = !(x != y) || !(y != x);
  test_print("!(x != y) || !(y != x): " + a);
  a = !(!(x != y) || !(y != x));
  test_print("!(!(x != y) || !(y != x)): " + a);
  a = 1 && x;
  test_print("ONE && x: " + a);
  a = x && true;
  test_print("x && ONE: " + a);
  a = 1 || x;
  test_print("ONE || x: " + a);
  a = x || true;
  test_print("x || ONE: " + a);
  a = 2 && x;
  test_print("TWOF && x: " + a);
  a = x && true;
  test_print("x && TWOF: " + a);
  a = 2 || x;
  test_print("TWOF || x: " + a);
  a = x || true;
  test_print("x || TWOF: " + a);
  a = x && false;
  test_print("x && F: " + a);
  a = 0 && x;
  test_print("F && x: " + a);
  a = x || false;
  test_print("x || F: " + a);
  a = 0 || x;
  test_print("F || x: " + a);
  a = 0 && x;
  test_print("!ONE && x: " + a);
  a = x && false;
  test_print("x && !ONE: " + a);
  a = 0 || x;
  test_print("!ONE || x: " + a);
  a = x || false;
  test_print("x || !ONE: " + a);
  a = !true && x;
  test_print("!TWOF && x: " + a);
  a = x && !true;
  test_print("x && !TWOF: " + a);
  a = !true || x;
  test_print("!TWOF || x: " + a);
  a = x || !true;
  test_print("x || !TWOF: " + a);
  a = x && true;
  test_print("x && !F: " + a);
  a = 1 && x;
  test_print("!F && x: " + a);
  a = x || true;
  test_print("x || !F: " + a);
  a = 1 || x;
  test_print("!F || x: " + a);
  a = x && y;
  test_print("x && y: " + a);
  a = !x && y;
  test_print("!x && y: " + a);
  a = x && !y;
  test_print("x && !y: " + a);
  a = !x && !y;
  test_print("!x && !y: " + a);
  a = x || y;
  test_print("x || y: " + a);
  a = !x || y;
  test_print("!x || y: " + a);
  a = x || !y;
  test_print("x || !y: " + a);
  a = !x || !y;
  test_print("!x || !y: " + a);
  a = !(x && y);
  test_print("!(x && y): " + a);
  a = !(!x && y);
  test_print("!(!x && y): " + a);
  a = !(x && !y);
  test_print("!(x && !y): " + a);
  a = !(!x && !y);
  test_print("!(!x && !y): " + a);
  a = !(x || y);
  test_print("!(x || y): " + a);
  a = !(!x || y);
  test_print("!(!x || y): " + a);
  a = !(x || !y);
  test_print("!(x || !y): " + a);
  a = !(!x || !y);
  test_print("!(!x || !y): " + a);
}

function iftest() {
  x = 0;
  y = 1;

  if(x) {
    test_print("x: true");
  } else {
    test_print("x: false");
  }

  if(y) {
    test_print("y: true");
  } else {
    test_print("y: false");
  }

  if(!x) {
    test_print("!x: true");
  } else {
    test_print("!x: false");
  }

  if(!y) {
    test_print("!y: true");
  } else {
    test_print("!y: false");
  }

  if(!x + y) {
    test_print("!x + y: true");
  } else {
    test_print("!x + y: false");
  }

  if(!(!x + y)) {
    test_print("!(!x + y): true");
  } else {
    test_print("!(!x + y): false");
  }

  if(!(!(x < 0) + y)) {
    test_print("!(!(x < 0) + y): true");
  } else {
    test_print("!(!(x < 0) + y): false");
  }

  if(!(!(x < 0) != y)) {
    test_print("!(!(x < 0) != y): true");
  } else {
    test_print("!(!(x < 0) != y): false");
  }

  if(true) {
    test_print("ONE: true");
  } else {
    test_print("ONE: false");
  }

  if(false) {
    test_print("!ONE: true");
  } else {
    test_print("!ONE: false");
  }

  if(false) {
    test_print("F: true");
  } else {
    test_print("F: false");
  }

  if(true) {
    test_print("!F: true");
  } else {
    test_print("!F: false");
  }

  if(x && true) {
    test_print("x && ONE: true");
  } else {
    test_print("x && ONE: false");
  }

  if(!x && true) {
    test_print("!x && ONE: true");
  } else {
    test_print("!x && ONE: false");
  }

  if(x && false) {
    test_print("x && !ONE: true");
  } else {
    test_print("x && !ONE: false");
  }

  if(!x && false) {
    test_print("!x && !ONE: true");
  } else {
    test_print("!x && !ONE: false");
  }

  if(x || true) {
    test_print("x || ONE: true");
  } else {
    test_print("x || ONE: false");
  }

  if(!x || true) {
    test_print("!x || ONE: true");
  } else {
    test_print("!x || ONE: false");
  }

  if(x || false) {
    test_print("x || !ONE: true");
  } else {
    test_print("x || !ONE: false");
  }

  if(!x || false) {
    test_print("!x || !ONE: true");
  } else {
    test_print("!x || !ONE: false");
  }

  if(x && y) {
    test_print("x && y: true");
  } else {
    test_print("x && y: false");
  }

  if(!x && y) {
    test_print("!x && y: true");
  } else {
    test_print("x && y: false");
  }

  if(x && !y) {
    test_print("x && !y: true");
  } else {
    test_print("x && !y: false");
  }

  if(!x && !y) {
    test_print("!x && !y: true");
  } else {
    test_print("!x &!y: false");
  }

  if(x || y) {
    test_print("x || y: true");
  } else {
    test_print("x || y: false");
  }

  if(!x || y) {
    test_print("!x || y: true");
  } else {
    test_print("x || y: false");
  }

  if(x || !y) {
    test_print("x || !y: true");
  } else {
    test_print("x || !y: false");
  }

  if(!x || !y) {
    test_print("!x || !y: true");
  } else {
    test_print("!x &!y: false");
  }

  if(!(x && y)) {
    test_print("!(x && y): true");
  } else {
    test_print("!(x && y): false");
  }

  if(!(!x && y)) {
    test_print("!(!x && y): true");
  } else {
    test_print("!(x && y): false");
  }

  if(!(x && !y)) {
    test_print("!(x && !y): true");
  } else {
    test_print("!(x && !y): false");
  }

  if(!(!x && !y)) {
    test_print("!(!x && !y): true");
  } else {
    test_print("!(!x && !y): false");
  }

  if(!(x || y)) {
    test_print("!(x || y): true");
  } else {
    test_print("!(x || y): false");
  }

  if(!(!x || y)) {
    test_print("!(!x || y): true");
  } else {
    test_print("!(x || y): false");
  }

  if(!(x || !y)) {
    test_print("!(x || !y): true");
  } else {
    test_print("!(x || !y): false");
  }

  if(!(!x || !y)) {
    test_print("!(!x || !y): true");
    return;
  }

  test_print("!(!x || !y): false");
}

function main() {
  test_begin("Cond");
  vars();
  iftest();
  test_end("Cond");
}