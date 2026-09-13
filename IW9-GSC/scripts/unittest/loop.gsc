/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\unittest\loop.gsc
***********************************************/

for_simple() {
  scripts\unittest\util::test_print("for simple");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++)
    scripts\unittest\util::test_print("for: " + _id_AC0E594AC96AA3A8);

  x = 0;
  scripts\unittest\util::test_print("for 2 cond");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10 && x < 20; _id_AC0E594AC96AA3A8++) {
    x = x + _id_AC0E594AC96AA3A8;
    scripts\unittest\util::test_print("for: " + _id_AC0E594AC96AA3A8);
  }

  scripts\unittest\util::test_print("for empty");
  _id_AC0E594AC96AA3A8 = 0;

  for(;;) {
    scripts\unittest\util::test_print("for: " + _id_AC0E594AC96AA3A8);

    if(_id_AC0E594AC96AA3A8 >= 9) {
      break;
    }

    _id_AC0E594AC96AA3A8++;
  }
}

foreach_shared_variables(x) {
  scripts\unittest\util::test_print("foreach_shared_variables");

  if(isDefined(x)) {
    foreach(a in x)
    scripts\unittest\util::test_print(" " + a);
  } else
    return;

  foreach(a in x)
  scripts\unittest\util::test_print(" " + a);
}

_id_FDA6CA11E664041C() {
  scripts\unittest\util::test_print("foreach_mutable_key");
  a = [1, 2, 3, 4];

  foreach(x, y in a) {
    scripts\unittest\util::test_print(" " + x + "," + y);
    x = x + 1;
  }
}

foreach_simple() {
  scripts\unittest\util::test_print("foreach_simple");
  a = [1, 2, 3, 4];

  foreach(x in a)
  scripts\unittest\util::test_print(" " + x);

  scripts\unittest\util::test_print("foreach_simple(x,y)");

  foreach(x, y in a)
  scripts\unittest\util::test_print(" " + x + "," + y);

  foreach_shared_variables(a);
  _id_FDA6CA11E664041C();
}

while_simple() {
  scripts\unittest\util::test_print("while simple");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++)
    scripts\unittest\util::test_print("while: " + _id_AC0E594AC96AA3A8);

  scripts\unittest\util::test_print("while 2 cond");
  x = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10 && x < 20; _id_AC0E594AC96AA3A8++) {
    x = x + _id_AC0E594AC96AA3A8;
    scripts\unittest\util::test_print("while: " + _id_AC0E594AC96AA3A8);
  }

  scripts\unittest\util::test_print("while true");
  _id_AC0E594AC96AA3A8 = 0;

  for(;;) {
    scripts\unittest\util::test_print("while: " + _id_AC0E594AC96AA3A8);

    if(_id_AC0E594AC96AA3A8 >= 9) {
      break;
    }

    _id_AC0E594AC96AA3A8++;
  }
}

loop_control() {
  scripts\unittest\util::test_print("for control");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 1; _id_AC0E594AC96AA3A8++) {
    if(_id_AC0E594AC96AA3A8 % 1)
      _id_BE66DE030B25508C = 1;
    else
      _id_BE66DE030B25508C = 0;

    scripts\unittest\util::test_print("for var exposed: sum: " + _id_BE66DE030B25508C);
  }

  for(;;) {
    _id_AC0E414AC96A6EE0 = 1;
    break;
  }

  scripts\unittest\util::test_print("for break: q: " + _id_AC0E414AC96A6EE0);

  for(;;) {
    z = 2;
    break;
  }

  scripts\unittest\util::test_print("while break: z: " + z);
}

main() {
  scripts\unittest\util::test_begin("Loops");
  for_simple();
  foreach_simple();
  while_simple();
  loop_control();
  scripts\unittest\util::test_end("Loops");
}