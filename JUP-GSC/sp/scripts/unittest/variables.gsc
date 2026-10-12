/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\unittest\variables.gsc
***********************************************/



#using scripts\unittest\util;
#namespace unittest_variables;

function local() {
  a = 0;
  b = 1;
  c = "hi";
  d = "bye" + 0;
  test_print("constant: " + a + " " + b + " " + c + " " + d);
  a = 0;
  b = a;
  b = 2;
  c = b;
  a = a;
  test_print("assign: " + a + " " + b + " " + c + " " + d);
  c = 0;
  a = 1;
  b = 2;
  d = 3;
  test_print("constant 2: " + a + " " + b + " " + c + " " + d);
  v = (0, 0, 0);
  test_print("v0: (" + v[0] + ", " + v[1] + ", " + v[2] + " )");
  v = (1, 0, 0);
  test_print("v1: (" + v[0] + ", " + v[1] + ", " + v[2] + " )");
  v = (1, 2, 3.1);
  test_print("v2: (" + v[0] + ", " + v[1] + ", " + v[2] + " )");
  x = v;
  test_print("x0: (" + x[0] + ", " + x[1] + ", " + x[2] + " )");
  x = (a, b, c);
  test_print("x1: (" + x[0] + ", " + x[1] + ", " + x[2] + " )");
  x = (a, 0, c);
  test_print("x2: (" + x[0] + ", " + x[1] + ", " + x[2] + " )");
  u = undefined;
  test_print("u: " + isDefined(u));
  s0 = spawnStruct();
  s = s0;
  s = spawnStruct();
  a0 = [];
  a1 = a0;
  a0 = [1, 2, 3];
}

function defines() {
  test_print("defines");
  test_print("DEF_STR: " + "foo");
  test_print("DEF_INT: " + 22);
  test_print("DEF_VEC: (" + (1, 2, 3)[0] + ", " + (1, 2, 3)[1] + ", " + (1, 2, 3)[2] + " )");
  test_print("DEF_EXPR: " + 23);
  test_print("DEF_MIX_EXPR: " + "foo" + 0);
}

function local_array() {
  test_print("local array");
  a = [];
  a[0] = 0;
  a[1] = 2;
  a[2] = "bye";
  test_print("local array index: size: " + a.size + " val: " + a[0] + " " + a[1] + " " + a[2]);
  b = a;
  b[0] = 1;
  test_print("local array index a: size: " + a.size + " val: " + a[0] + " " + a[1] + " " + a[2]);
  test_print("local array index b: size: " + b.size + " val: " + b[0] + " " + b[1] + " " + b[2]);
  a[0]++;
  a["foo"] = 5;
  a["bar"] = 6;
  a["baz"] = "no";
  test_print("local array string: size: " + a.size + " val: " + a["foo"] + " " + a["bar"] + " " + a["baz"]);
  test_print("local array index(after): size: " + a.size + " val: " + a[0] + " " + a[1] + " " + a[2]);
  a[@ "dvar"] = 8;
  a[#"xhash"] = 9;
  a[t "hash_9d1b361a"] = 10;
  a[%"asset"] = 11;
  test_print("local array xhash: size: " + a.size + " val: " + a[@ "dvar"] + " " + a[#"xhash"] + " " + a[t "hash_9d1b361a"] + " " + a[%"asset"]);
  test_print("local array string: size: " + a.size + " val: " + a["foo"] + " " + a["bar"] + " " + a["baz"]);
  test_print("local array index(after): size: " + a.size + " val: " + a[0] + " " + a[1] + " " + a[2]);
  test_print("local array foreach");

  foreach(v in a) {
    test_print(v);
  }

  test_print("local array foreach end");
  a[2] = undefined;
  a["bar"] = undefined;
  a[@ "dvar"] = undefined;
  a[#"xhash"] = undefined;
  a[t "hash_9d1b361a"] = undefined;
  a[%"asset"] = undefined;
  test_print("local array remove index: size: " + a.size);

  foreach(v in a) {
    test_print(v);
  }

  a["nest"][0][0] = 0;
  a["nest"][0][1] = 1;
  a["nest"][1][0] = "yes";
  test_print("local array nest: " + a["nest"][0][0] + " " + a["nest"][0][1] + " " + a["nest"][1][0]);
  a = undefined;
  test_print("local array clear: IsDefined: " + isDefined(a));
}

function level_array() {
  test_print("level array");
  level.a = [];
  level.a[0] = 0;
  level.a[1] = 2;
  level.a[2] = "bye";
  test_print("level array index: size: " + level.a.size + " val: " + level.a[0] + " " + level.a[1] + " " + level.a[2]);
  level.a[0]++;
  level.a["foo"] = 5;
  level.a["bar"] = 6;
  level.a["baz"] = "no";
  test_print("level array string: size: " + level.a.size + " val: " + level.a["foo"] + " " + level.a["bar"] + " " + level.a["baz"]);
  test_print("level array index(after): size: " + level.a.size + " val: " + level.a[0] + " " + level.a[1] + " " + level.a[2]);
  test_print("level array foreach");

  foreach(v in level.a) {
    test_print(v);
  }

  test_print("level array foreach end");
  level.a[2] = undefined;
  level.a["bar"] = undefined;
  test_print("level array remove index: size: " + level.a.size);

  foreach(v in level.a) {
    test_print(v);
  }

  level.a["nest"][0][0] = 0;
  level.a["nest"][0][1] = 1;
  level.a["nest"][1][0] = "yes";
  test_print("level array nest: " + level.a["nest"][0][0] + " " + level.a["nest"][0][1] + " " + level.a["nest"][1][0]);
  level.a = undefined;
  test_print("level array clear: IsDefined: " + isDefined(level.a));
}

function local_object() {
  test_print("local object");
  s = spawnStruct();
  s.a = 0;
  s.b = 1;
  s.c = "hi";
  test_print("object constant: " + s.a + " " + s.b + " " + s.c);
  s.a = 0;
  s.b = s.a;
  s.b = 2;
  s.c = s.b;
  s.a = s.a;
  s.a++;
  test_print("local object assign: " + s.a + " " + s.b + " " + s.c);
  s.s = spawnStruct();
  x = s.s;
  s.s.a = 0;
  s.s.b = 1;
  s.s.c = "hi";
  test_print("local object nested: " + s.s.a + " " + s.s.b + " " + s.s.c);
  test_print("local object clear before: IsDefined: s.s: " + isDefined(s.s));
  s.s = undefined;
  test_print("local object clear after: IsDefined: s.s: " + isDefined(s.s));
  s.a = [];
  s.a[0] = 0;
  s.a[1] = 2;
  s.a[2] = "bye";
  test_print("local object array index: size: " + s.a.size + " val: " + s.a[0] + " " + s.a[1] + " " + s.a[2]);
  s.a[0]++;
  s.a["foo"] = 5;
  s.a["bar"] = 6;
  s.a["baz"] = "no";
  test_print("local object array string: size: " + s.a.size + " val: " + s.a["foo"] + " " + s.a["bar"] + " " + s.a["baz"]);
  test_print("local object array index(after): size: " + s.a.size + " val: " + s.a[0] + " " + s.a[1] + " " + s.a[2]);
  test_print("local object array foreach");

  foreach(v in s.a) {
    test_print(v);
  }

  test_print("local object array foreach end");
  s.a[2] = undefined;
  s.a["bar"] = undefined;
  test_print("local object array remove index: size: " + s.a.size);

  foreach(v in s.a) {
    test_print(v);
  }

  s.a = undefined;
  test_print("local object array clear: IsDefined: " + isDefined(s.a));
}

function level_object() {
  test_print("level object");
  level.s = spawnStruct();
  level.s.a = 0;
  level.s.b = 1;
  level.s.c = "hi";
  test_print("level object constant: " + level.s.a + " " + level.s.b + " " + level.s.c);
  level.s.a++;
  level.s.b = level.s.a;
  level.s.b = 2;
  level.s.c = level.s.b;
  level.s.a = level.s.a;
  test_print("level object assign: " + level.s.a + " " + level.s.b + " " + level.s.c);
  level.s.s = spawnStruct();
  level.s.s.a = 0;
  level.s.s.b = 1;
  level.s.s.c = "hi";
  test_print("level object nested: " + level.s.s.a + " " + level.s.s.b + " " + level.s.s.c);
  test_print("level object clear before: IsDefined: level.s.s: " + isDefined(level.s.s));
  level.s.s = undefined;
  test_print("level object clear after: IsDefined: level.s.s: " + isDefined(level.s.s));
  level.s.a = [];
  level.s.a[0] = 0;
  level.s.a[1] = 2;
  level.s.a[2] = "bye";
  test_print("level object array index: size: " + level.s.a.size + " val: " + level.s.a[0] + " " + level.s.a[1] + " " + level.s.a[2]);
  level.s.a[0]++;
  level.s.a["foo"] = 5;
  level.s.a["bar"] = 6;
  level.s.a["baz"] = "no";
  test_print("level object array string: size: " + level.s.a.size + " val: " + level.s.a["foo"] + " " + level.s.a["bar"] + " " + level.s.a["baz"]);
  test_print("level object array index(after): size: " + level.s.a.size + " val: " + level.s.a[0] + " " + level.s.a[1] + " " + level.s.a[2]);
  test_print("level object array foreach");

  foreach(v in level.s.a) {
    test_print(v);
  }

  test_print("level object array foreach end");
  level.s.a[2] = undefined;
  level.s.a["bar"] = undefined;
  test_print("level object array remove index: size: " + level.s.a.size);

  foreach(v in level.s.a) {
    test_print(v);
  }

  level.s.a = undefined;
  test_print("level object array clear: IsDefined: " + isDefined(level.s.a));
}

function local_combo() {
  a[0] = spawnStruct();
  a[0].a = 0;
  a[0].b = 1;
  a[0].c = "hi";
  test_print("local combo 1: " + a[0].a + " " + a[0].b + " " + a[0].c);
  a[1] = spawnStruct();
  a[1].a["nest"] = spawnStruct();
  a[1].a["nest"].a = 5;
  a[1].a["nest"].b = 6;
  a[1].a["nest"].c = "no";
  test_print("local combo 2: " + a[1].a["nest"].a + " " + a[1].a["nest"].b + " " + a[1].a["nest"].c);
  a[2][0][0] = spawnStruct();
  a[2][0][0].a = 10;
  a[2][0][0].b = 11;
  a[2][0][1] = "yes";
  test_print("local combo 3: " + a[2][0][0].a + " " + a[2][0][0].b + " " + a[2][0][1]);
}

function level_combo() {
  level.a[0] = spawnStruct();
  level.a[0].a = 0;
  level.a[0].b = 1;
  level.a[0].c = "hi";
  test_print("level combo 1: " + level.a[0].a + " " + level.a[0].b + " " + level.a[0].c);
  level.a[1] = spawnStruct();
  level.a[1].a["nest"] = spawnStruct();
  level.a[1].a["nest"].a = 5;
  level.a[1].a["nest"].b = 6;
  level.a[1].a["nest"].c = "no";
  test_print("level combo 2: " + level.a[1].a["nest"].a + " " + level.a[1].a["nest"].b + " " + level.a[1].a["nest"].c);
  level.a[2][0][0] = spawnStruct();
  level.a[2][0][0].a = 10;
  level.a[2][0][0].b = 11;
  level.a[2][0][1] = "yes";
  test_print("level combo 3: " + level.a[2][0][0].a + " " + level.a[2][0][0].b + " " + level.a[2][0][1]);
}

function is_true_print(val, name) {
  b = istrue(val);

  if(!isDefined(b)) {
    b = "undefined";
  }

  d = isDefined(val);
  test_print("is_true: " + name + ": " + b + " isdefined: " + d);
}

function is_true() {
  u = undefined;
  int_false = 0;
  int_true = 1;
  float_false = 0;
  float_true = 2;
  is_true_print(u, "u");
  is_true_print(int_false, "int_false");
  is_true_print(int_true, "int_true");
  is_true_print(float_false, "float_false");
  is_true_print(float_true, "float_true");
}

function main() {
  test_begin("Variables");
  local();
  defines();
  local_array();
  level_array();
  local_object();
  level_object();
  local_combo();
  level_combo();
  is_true();
  test_end("Variables");
}