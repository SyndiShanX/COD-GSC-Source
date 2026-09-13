/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\unittest\variables.gsc
***********************************************/

local() {
  a = 0;
  b = 1.0;
  c = "hi";
  _id_AC0E564AC96A9D0F = "bye0";
  scripts\unittest\util::test_print("constant: " + a + " " + b + " " + c + " " + _id_AC0E564AC96A9D0F);
  a = 0;
  b = a;
  b = 2;
  c = b;
  a = a;
  scripts\unittest\util::test_print("assign: " + a + " " + b + " " + c + " " + _id_AC0E564AC96A9D0F);
  c = 0;
  a = 1;
  b = 2;
  _id_AC0E564AC96A9D0F = 3;
  scripts\unittest\util::test_print("constant 2: " + a + " " + b + " " + c + " " + _id_AC0E564AC96A9D0F);
  v = (0, 0, 0);
  scripts\unittest\util::test_print("v0: (" + v[0] + ", " + v[1] + ", " + v[2] + " )");
  v = (1, 0, 0);
  scripts\unittest\util::test_print("v1: (" + v[0] + ", " + v[1] + ", " + v[2] + " )");
  v = (1, 2, 3.1);
  scripts\unittest\util::test_print("v2: (" + v[0] + ", " + v[1] + ", " + v[2] + " )");
  x = v;
  scripts\unittest\util::test_print("x0: (" + x[0] + ", " + x[1] + ", " + x[2] + " )");
  x = (a, b, c);
  scripts\unittest\util::test_print("x1: (" + x[0] + ", " + x[1] + ", " + x[2] + " )");
  x = (a, 0, c);
  scripts\unittest\util::test_print("x2: (" + x[0] + ", " + x[1] + ", " + x[2] + " )");
  _id_AC0E454AC96A77AC = undefined;
  scripts\unittest\util::test_print("u: " + isDefined(_id_AC0E454AC96A77AC));
  _id_CDD17378F51BEC82 = spawnStruct();
  s = _id_CDD17378F51BEC82;
  s = spawnStruct();
  _id_CE0EE778F55F5C60 = [];
  _id_CE0EE878F55F5E93 = _id_CE0EE778F55F5C60;
  _id_CE0EE778F55F5C60 = [1, 2, 3];
}

defines() {
  scripts\unittest\util::test_print("defines");
  scripts\unittest\util::test_print("DEF_STR: foo");
  scripts\unittest\util::test_print("DEF_INT: 22");
  scripts\unittest\util::test_print("DEF_VEC: (" + (1, 2, 3)[0] + ", " + (1, 2, 3)[1] + ", " + (1, 2, 3)[2] + " )");
  scripts\unittest\util::test_print("DEF_EXPR: 23");
  scripts\unittest\util::test_print("DEF_MIX_EXPR: foo0");
}

local_array() {
  scripts\unittest\util::test_print("local array");
  a = [];
  a[0] = 0;
  a[1] = 2.0;
  a[2] = "bye";
  scripts\unittest\util::test_print("local array index: size: " + a.size + " val: " + a[0] + " " + a[1] + " " + a[2]);
  b = a;
  b[0] = 1;
  scripts\unittest\util::test_print("local array index a: size: " + a.size + " val: " + a[0] + " " + a[1] + " " + a[2]);
  scripts\unittest\util::test_print("local array index b: size: " + b.size + " val: " + b[0] + " " + b[1] + " " + b[2]);
  a[0]++;
  a["foo"] = 5;
  a["bar"] = 6.0;
  a["baz"] = "no";
  scripts\unittest\util::test_print("local array string: size: " + a.size + " val: " + a["foo"] + " " + a["bar"] + " " + a["baz"]);
  scripts\unittest\util::test_print("local array index(after): size: " + a.size + " val: " + a[0] + " " + a[1] + " " + a[2]);
  a["dvar"] = 8;
  a["stat_DFF9438966AE6B57"] = 9;
  a["hunk_9D1B361A"] = 10;
  a["enum_244720E8AE01C14E"] = 11;
  scripts\unittest\util::test_print("local array xhash: size: " + a.size + " val: " + a["dvar"] + " " + a["stat_DFF9438966AE6B57"] + " " + a["hunk_9D1B361A"] + " " + a["enum_244720E8AE01C14E"]);
  scripts\unittest\util::test_print("local array string: size: " + a.size + " val: " + a["foo"] + " " + a["bar"] + " " + a["baz"]);
  scripts\unittest\util::test_print("local array index(after): size: " + a.size + " val: " + a[0] + " " + a[1] + " " + a[2]);
  scripts\unittest\util::test_print("local array foreach");

  foreach(v in a)
  scripts\unittest\util::test_print(v);

  scripts\unittest\util::test_print("local array foreach end");
  a[2] = undefined;
  a["bar"] = undefined;
  a["dvar"] = undefined;
  a["stat_DFF9438966AE6B57"] = undefined;
  a["hunk_9D1B361A"] = undefined;
  a["enum_244720E8AE01C14E"] = undefined;
  scripts\unittest\util::test_print("local array remove index: size: " + a.size);

  foreach(v in a)
  scripts\unittest\util::test_print(v);

  a["nest"][0][0] = 0;
  a["nest"][0][1] = 1.0;
  a["nest"][1][0] = "yes";
  scripts\unittest\util::test_print("local array nest: " + a["nest"][0][0] + " " + a["nest"][0][1] + " " + a["nest"][1][0]);
  a = undefined;
  scripts\unittest\util::test_print("local array clear: IsDefined: " + isDefined(a));
}

level_array() {
  scripts\unittest\util::test_print("level array");
  level.a = [];
  level.a[0] = 0;
  level.a[1] = 2.0;
  level.a[2] = "bye";
  scripts\unittest\util::test_print("level array index: size: " + level.a.size + " val: " + level.a[0] + " " + level.a[1] + " " + level.a[2]);
  level.a[0]++;
  level.a["foo"] = 5;
  level.a["bar"] = 6.0;
  level.a["baz"] = "no";
  scripts\unittest\util::test_print("level array string: size: " + level.a.size + " val: " + level.a["foo"] + " " + level.a["bar"] + " " + level.a["baz"]);
  scripts\unittest\util::test_print("level array index(after): size: " + level.a.size + " val: " + level.a[0] + " " + level.a[1] + " " + level.a[2]);
  scripts\unittest\util::test_print("level array foreach");

  foreach(v in level.a)
  scripts\unittest\util::test_print(v);

  scripts\unittest\util::test_print("level array foreach end");
  level.a[2] = undefined;
  level.a["bar"] = undefined;
  scripts\unittest\util::test_print("level array remove index: size: " + level.a.size);

  foreach(v in level.a)
  scripts\unittest\util::test_print(v);

  level.a["nest"][0][0] = 0;
  level.a["nest"][0][1] = 1.0;
  level.a["nest"][1][0] = "yes";
  scripts\unittest\util::test_print("level array nest: " + level.a["nest"][0][0] + " " + level.a["nest"][0][1] + " " + level.a["nest"][1][0]);
  level.a = undefined;
  scripts\unittest\util::test_print("level array clear: IsDefined: " + isDefined(level.a));
}

local_object() {
  scripts\unittest\util::test_print("local object");
  s = spawnStruct();
  s.a = 0;
  s.b = 1.0;
  s.c = "hi";
  scripts\unittest\util::test_print("object constant: " + s.a + " " + s.b + " " + s.c);
  s.a = 0;
  s.b = s.a;
  s.b = 2;
  s.c = s.b;
  s.a = s.a;
  s.a++;
  scripts\unittest\util::test_print("local object assign: " + s.a + " " + s.b + " " + s.c);
  s.s = spawnStruct();
  x = s.s;
  s.s.a = 0;
  s.s.b = 1.0;
  s.s.c = "hi";
  scripts\unittest\util::test_print("local object nested: " + s.s.a + " " + s.s.b + " " + s.s.c);
  scripts\unittest\util::test_print("local object clear before: IsDefined: s.s: " + isDefined(s.s));
  s.s = undefined;
  scripts\unittest\util::test_print("local object clear after: IsDefined: s.s: " + isDefined(s.s));
  s.a = [];
  s.a[0] = 0;
  s.a[1] = 2.0;
  s.a[2] = "bye";
  scripts\unittest\util::test_print("local object array index: size: " + s.a.size + " val: " + s.a[0] + " " + s.a[1] + " " + s.a[2]);
  s.a[0]++;
  s.a["foo"] = 5;
  s.a["bar"] = 6.0;
  s.a["baz"] = "no";
  scripts\unittest\util::test_print("local object array string: size: " + s.a.size + " val: " + s.a["foo"] + " " + s.a["bar"] + " " + s.a["baz"]);
  scripts\unittest\util::test_print("local object array index(after): size: " + s.a.size + " val: " + s.a[0] + " " + s.a[1] + " " + s.a[2]);
  scripts\unittest\util::test_print("local object array foreach");

  foreach(v in s.a)
  scripts\unittest\util::test_print(v);

  scripts\unittest\util::test_print("local object array foreach end");
  s.a[2] = undefined;
  s.a["bar"] = undefined;
  scripts\unittest\util::test_print("local object array remove index: size: " + s.a.size);

  foreach(v in s.a)
  scripts\unittest\util::test_print(v);

  s.a = undefined;
  scripts\unittest\util::test_print("local object array clear: IsDefined: " + isDefined(s.a));
}

level_object() {
  scripts\unittest\util::test_print("level object");
  level.s = spawnStruct();
  level.s.a = 0;
  level.s.b = 1.0;
  level.s.c = "hi";
  scripts\unittest\util::test_print("level object constant: " + level.s.a + " " + level.s.b + " " + level.s.c);
  level.s.a++;
  level.s.b = level.s.a;
  level.s.b = 2;
  level.s.c = level.s.b;
  level.s.a = level.s.a;
  scripts\unittest\util::test_print("level object assign: " + level.s.a + " " + level.s.b + " " + level.s.c);
  level.s.s = spawnStruct();
  level.s.s.a = 0;
  level.s.s.b = 1.0;
  level.s.s.c = "hi";
  scripts\unittest\util::test_print("level object nested: " + level.s.s.a + " " + level.s.s.b + " " + level.s.s.c);
  scripts\unittest\util::test_print("level object clear before: IsDefined: level.s.s: " + isDefined(level.s.s));
  level.s.s = undefined;
  scripts\unittest\util::test_print("level object clear after: IsDefined: level.s.s: " + isDefined(level.s.s));
  level.s.a = [];
  level.s.a[0] = 0;
  level.s.a[1] = 2.0;
  level.s.a[2] = "bye";
  scripts\unittest\util::test_print("level object array index: size: " + level.s.a.size + " val: " + level.s.a[0] + " " + level.s.a[1] + " " + level.s.a[2]);
  level.s.a[0]++;
  level.s.a["foo"] = 5;
  level.s.a["bar"] = 6.0;
  level.s.a["baz"] = "no";
  scripts\unittest\util::test_print("level object array string: size: " + level.s.a.size + " val: " + level.s.a["foo"] + " " + level.s.a["bar"] + " " + level.s.a["baz"]);
  scripts\unittest\util::test_print("level object array index(after): size: " + level.s.a.size + " val: " + level.s.a[0] + " " + level.s.a[1] + " " + level.s.a[2]);
  scripts\unittest\util::test_print("level object array foreach");

  foreach(v in level.s.a)
  scripts\unittest\util::test_print(v);

  scripts\unittest\util::test_print("level object array foreach end");
  level.s.a[2] = undefined;
  level.s.a["bar"] = undefined;
  scripts\unittest\util::test_print("level object array remove index: size: " + level.s.a.size);

  foreach(v in level.s.a)
  scripts\unittest\util::test_print(v);

  level.s.a = undefined;
  scripts\unittest\util::test_print("level object array clear: IsDefined: " + isDefined(level.s.a));
}

local_combo() {
  a[0] = spawnStruct();
  a[0].a = 0;
  a[0].b = 1.0;
  a[0].c = "hi";
  scripts\unittest\util::test_print("local combo 1: " + a[0].a + " " + a[0].b + " " + a[0].c);
  a[1] = spawnStruct();
  a[1].a["nest"] = spawnStruct();
  a[1].a["nest"].a = 5;
  a[1].a["nest"].b = 6.0;
  a[1].a["nest"].c = "no";
  scripts\unittest\util::test_print("local combo 2: " + a[1].a["nest"].a + " " + a[1].a["nest"].b + " " + a[1].a["nest"].c);
  a[2][0][0] = spawnStruct();
  a[2][0][0].a = 10;
  a[2][0][0].b = 11.0;
  a[2][0][1] = "yes";
  scripts\unittest\util::test_print("local combo 3: " + a[2][0][0].a + " " + a[2][0][0].b + " " + a[2][0][1]);
}

level_combo() {
  level.a[0] = spawnStruct();
  level.a[0].a = 0;
  level.a[0].b = 1.0;
  level.a[0].c = "hi";
  scripts\unittest\util::test_print("level combo 1: " + level.a[0].a + " " + level.a[0].b + " " + level.a[0].c);
  level.a[1] = spawnStruct();
  level.a[1].a["nest"] = spawnStruct();
  level.a[1].a["nest"].a = 5;
  level.a[1].a["nest"].b = 6.0;
  level.a[1].a["nest"].c = "no";
  scripts\unittest\util::test_print("level combo 2: " + level.a[1].a["nest"].a + " " + level.a[1].a["nest"].b + " " + level.a[1].a["nest"].c);
  level.a[2][0][0] = spawnStruct();
  level.a[2][0][0].a = 10;
  level.a[2][0][0].b = 11.0;
  level.a[2][0][1] = "yes";
  scripts\unittest\util::test_print("level combo 3: " + level.a[2][0][0].a + " " + level.a[2][0][0].b + " " + level.a[2][0][1]);
}

is_true_print(val, name) {
  b = istrue(val);

  if(!isDefined(b))
    b = "undefined";

  _id_AC0E564AC96A9D0F = isDefined(val);
  scripts\unittest\util::test_print("is_true: " + name + ": " + b + " isdefined: " + _id_AC0E564AC96A9D0F);
}

is_true() {
  _id_AC0E454AC96A77AC = undefined;
  _id_4CCC5243879C33F6 = 0;
  _id_E85642E4441F9C4B = 1;
  _id_8CECD358300A7A89 = 0.0;
  _id_267D9B52546C7E0E = 2.0;
  is_true_print(_id_AC0E454AC96A77AC, "u");
  is_true_print(_id_4CCC5243879C33F6, "int_false");
  is_true_print(_id_E85642E4441F9C4B, "int_true");
  is_true_print(_id_8CECD358300A7A89, "float_false");
  is_true_print(_id_267D9B52546C7E0E, "float_true");
}

main() {
  scripts\unittest\util::test_begin("Variables");
  local();
  defines();
  local_array();
  level_array();
  local_object();
  level_object();
  local_combo();
  level_combo();
  is_true();
  scripts\unittest\util::test_end("Variables");
}