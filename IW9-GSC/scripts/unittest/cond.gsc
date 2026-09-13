/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\unittest\cond.gsc
***********************************************/

vars() {
  x = 0;
  y = 1;
  a = x < y;
  scripts\unittest\util::test_print("x < y: " + a);
  a = !(x < y);
  scripts\unittest\util::test_print("!(x < y): " + a);
  a = !x;
  scripts\unittest\util::test_print("!x: " + a);
  a = !x + y;
  scripts\unittest\util::test_print("!x + y: " + a);
  a = !(!x + y);
  scripts\unittest\util::test_print("!(!x + y): " + a);
  a = x != y && y != x;
  scripts\unittest\util::test_print("(x != y) && (y != x): " + a);
  a = !(x != y) && !(y != x);
  scripts\unittest\util::test_print("!(x != y) && !(y != x): " + a);
  a = !(!(x != y) && !(y != x));
  scripts\unittest\util::test_print("!(!(x != y) && !(y != x)): " + a);
  a = x != y || y != x;
  scripts\unittest\util::test_print("(x != y) || (y != x): " + a);
  a = !(x != y) || !(y != x);
  scripts\unittest\util::test_print("!(x != y) || !(y != x): " + a);
  a = !(!(x != y) || !(y != x));
  scripts\unittest\util::test_print("!(!(x != y) || !(y != x)): " + a);
  a = 1 && x;
  scripts\unittest\util::test_print("ONE && x: " + a);
  a = x && 1;
  scripts\unittest\util::test_print("x && ONE: " + a);
  a = 1 || x;
  scripts\unittest\util::test_print("ONE || x: " + a);
  a = x || 1;
  scripts\unittest\util::test_print("x || ONE: " + a);
  a = 2.0 && x;
  scripts\unittest\util::test_print("TWOF && x: " + a);
  a = x && 2.0;
  scripts\unittest\util::test_print("x && TWOF: " + a);
  a = 2.0 || x;
  scripts\unittest\util::test_print("TWOF || x: " + a);
  a = x || 2.0;
  scripts\unittest\util::test_print("x || TWOF: " + a);
  a = x && 0;
  scripts\unittest\util::test_print("x && F: " + a);
  a = 0 && x;
  scripts\unittest\util::test_print("F && x: " + a);
  a = x || 0;
  scripts\unittest\util::test_print("x || F: " + a);
  a = 0 || x;
  scripts\unittest\util::test_print("F || x: " + a);
  a = !1 && x;
  scripts\unittest\util::test_print("!ONE && x: " + a);
  a = x && !1;
  scripts\unittest\util::test_print("x && !ONE: " + a);
  a = !1 || x;
  scripts\unittest\util::test_print("!ONE || x: " + a);
  a = x || !1;
  scripts\unittest\util::test_print("x || !ONE: " + a);
  a = !2.0 && x;
  scripts\unittest\util::test_print("!TWOF && x: " + a);
  a = x && !2.0;
  scripts\unittest\util::test_print("x && !TWOF: " + a);
  a = !2.0 || x;
  scripts\unittest\util::test_print("!TWOF || x: " + a);
  a = x || !2.0;
  scripts\unittest\util::test_print("x || !TWOF: " + a);
  a = x && !0;
  scripts\unittest\util::test_print("x && !F: " + a);
  a = !0 && x;
  scripts\unittest\util::test_print("!F && x: " + a);
  a = x || !0;
  scripts\unittest\util::test_print("x || !F: " + a);
  a = !0 || x;
  scripts\unittest\util::test_print("!F || x: " + a);
  a = x && y;
  scripts\unittest\util::test_print("x && y: " + a);
  a = !x && y;
  scripts\unittest\util::test_print("!x && y: " + a);
  a = x && !y;
  scripts\unittest\util::test_print("x && !y: " + a);
  a = !x && !y;
  scripts\unittest\util::test_print("!x && !y: " + a);
  a = x || y;
  scripts\unittest\util::test_print("x || y: " + a);
  a = !x || y;
  scripts\unittest\util::test_print("!x || y: " + a);
  a = x || !y;
  scripts\unittest\util::test_print("x || !y: " + a);
  a = !x || !y;
  scripts\unittest\util::test_print("!x || !y: " + a);
  a = !(x && y);
  scripts\unittest\util::test_print("!(x && y): " + a);
  a = !(!x && y);
  scripts\unittest\util::test_print("!(!x && y): " + a);
  a = !(x && !y);
  scripts\unittest\util::test_print("!(x && !y): " + a);
  a = !(!x && !y);
  scripts\unittest\util::test_print("!(!x && !y): " + a);
  a = !(x || y);
  scripts\unittest\util::test_print("!(x || y): " + a);
  a = !(!x || y);
  scripts\unittest\util::test_print("!(!x || y): " + a);
  a = !(x || !y);
  scripts\unittest\util::test_print("!(x || !y): " + a);
  a = !(!x || !y);
  scripts\unittest\util::test_print("!(!x || !y): " + a);
}

iftest() {
  x = 0;
  y = 1;

  if(x)
    scripts\unittest\util::test_print("x: true");
  else
    scripts\unittest\util::test_print("x: false");

  if(y)
    scripts\unittest\util::test_print("y: true");
  else
    scripts\unittest\util::test_print("y: false");

  if(!x)
    scripts\unittest\util::test_print("!x: true");
  else
    scripts\unittest\util::test_print("!x: false");

  if(!y)
    scripts\unittest\util::test_print("!y: true");
  else
    scripts\unittest\util::test_print("!y: false");

  if(!x + y)
    scripts\unittest\util::test_print("!x + y: true");
  else
    scripts\unittest\util::test_print("!x + y: false");

  if(!(!x + y))
    scripts\unittest\util::test_print("!(!x + y): true");
  else
    scripts\unittest\util::test_print("!(!x + y): false");

  if(!(!(x < 0) + y))
    scripts\unittest\util::test_print("!(!(x < 0) + y): true");
  else
    scripts\unittest\util::test_print("!(!(x < 0) + y): false");

  if(!(!(x < 0) != y))
    scripts\unittest\util::test_print("!(!(x < 0) != y): true");
  else
    scripts\unittest\util::test_print("!(!(x < 0) != y): false");

  if(1)
    scripts\unittest\util::test_print("ONE: true");
  else
    scripts\unittest\util::test_print("ONE: false");

  if(!1)
    scripts\unittest\util::test_print("!ONE: true");
  else
    scripts\unittest\util::test_print("!ONE: false");

  if(0)
    scripts\unittest\util::test_print("F: true");
  else
    scripts\unittest\util::test_print("F: false");

  if(!0)
    scripts\unittest\util::test_print("!F: true");
  else
    scripts\unittest\util::test_print("!F: false");

  if(x && 1)
    scripts\unittest\util::test_print("x && ONE: true");
  else
    scripts\unittest\util::test_print("x && ONE: false");

  if(!x && 1)
    scripts\unittest\util::test_print("!x && ONE: true");
  else
    scripts\unittest\util::test_print("!x && ONE: false");

  if(x && !1)
    scripts\unittest\util::test_print("x && !ONE: true");
  else
    scripts\unittest\util::test_print("x && !ONE: false");

  if(!x && !1)
    scripts\unittest\util::test_print("!x && !ONE: true");
  else
    scripts\unittest\util::test_print("!x && !ONE: false");

  if(x || 1)
    scripts\unittest\util::test_print("x || ONE: true");
  else
    scripts\unittest\util::test_print("x || ONE: false");

  if(!x || 1)
    scripts\unittest\util::test_print("!x || ONE: true");
  else
    scripts\unittest\util::test_print("!x || ONE: false");

  if(x || !1)
    scripts\unittest\util::test_print("x || !ONE: true");
  else
    scripts\unittest\util::test_print("x || !ONE: false");

  if(!x || !1)
    scripts\unittest\util::test_print("!x || !ONE: true");
  else
    scripts\unittest\util::test_print("!x || !ONE: false");

  if(x && y)
    scripts\unittest\util::test_print("x && y: true");
  else
    scripts\unittest\util::test_print("x && y: false");

  if(!x && y)
    scripts\unittest\util::test_print("!x && y: true");
  else
    scripts\unittest\util::test_print("x && y: false");

  if(x && !y)
    scripts\unittest\util::test_print("x && !y: true");
  else
    scripts\unittest\util::test_print("x && !y: false");

  if(!x && !y)
    scripts\unittest\util::test_print("!x && !y: true");
  else
    scripts\unittest\util::test_print("!x &!y: false");

  if(x || y)
    scripts\unittest\util::test_print("x || y: true");
  else
    scripts\unittest\util::test_print("x || y: false");

  if(!x || y)
    scripts\unittest\util::test_print("!x || y: true");
  else
    scripts\unittest\util::test_print("x || y: false");

  if(x || !y)
    scripts\unittest\util::test_print("x || !y: true");
  else
    scripts\unittest\util::test_print("x || !y: false");

  if(!x || !y)
    scripts\unittest\util::test_print("!x || !y: true");
  else
    scripts\unittest\util::test_print("!x &!y: false");

  if(!(x && y))
    scripts\unittest\util::test_print("!(x && y): true");
  else
    scripts\unittest\util::test_print("!(x && y): false");

  if(!(!x && y))
    scripts\unittest\util::test_print("!(!x && y): true");
  else
    scripts\unittest\util::test_print("!(x && y): false");

  if(!(x && !y))
    scripts\unittest\util::test_print("!(x && !y): true");
  else
    scripts\unittest\util::test_print("!(x && !y): false");

  if(!(!x && !y))
    scripts\unittest\util::test_print("!(!x && !y): true");
  else
    scripts\unittest\util::test_print("!(!x && !y): false");

  if(!(x || y))
    scripts\unittest\util::test_print("!(x || y): true");
  else
    scripts\unittest\util::test_print("!(x || y): false");

  if(!(!x || y))
    scripts\unittest\util::test_print("!(!x || y): true");
  else
    scripts\unittest\util::test_print("!(x || y): false");

  if(!(x || !y))
    scripts\unittest\util::test_print("!(x || !y): true");
  else
    scripts\unittest\util::test_print("!(x || !y): false");

  if(!(!x || !y))
    scripts\unittest\util::test_print("!(!x || !y): true");
  else
    scripts\unittest\util::test_print("!(!x || !y): false");
}

main() {
  scripts\unittest\util::test_begin("Cond");
  vars();
  iftest();
  scripts\unittest\util::test_end("Cond");
}