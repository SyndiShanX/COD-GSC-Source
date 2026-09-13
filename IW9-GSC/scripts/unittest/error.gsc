/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\unittest\error.gsc
***********************************************/

error_print(msg, _id_06B5C8034010B9BA) {
  if(isDefined(_id_06B5C8034010B9BA))
    scripts\unittest\util::test_print(msg + ": defined");
  else
    scripts\unittest\util::test_print(msg + ": not defined");
}

func() {}

cond_func() {
  scripts\unittest\util::test_print("cond func");
  return 1;
}

params() {
  s = spawnStruct();
  scripts\unittest\util::test_print("func param");
  func(1, "x", s);
  scripts\unittest\util::test_print("meth param");
  s func(1, "x", s);
  scripts\unittest\util::test_print("func thread param");
  thread func(1, "x", s);
  scripts\unittest\util::test_print("meth thread param");
  s thread func(1, "x", s);
  f = ::func;
  scripts\unittest\util::test_print("func pointer param");
  thread[[f]](1, "x", s);
  scripts\unittest\util::test_print("meth pointer param");
  s thread[[f]](1, "x", s);
}

types() {
  x = 1;
  s = spawnStruct();
  a = [1, 2, 3, 4, 5, 6];
  v = (1, 2, 3);
  _id_AC0E424AC96A7113 = level.players[0];
  str = "foo";
  y = x + s;
  error_print("+", y);
  y = x < str;
  error_print("lt", y);
  y = x >= str;
  error_print("ge", y);
  y = 1.0;
  y++;
  error_print("inc float", y);
  s++;
  error_print("inc struct", s);
  y = s && cond_func();
  error_print("and struct", y);
  y = s || cond_func();
  error_print("or struct", y);
  y = x < str || cond_func();
  error_print("or expr", y);
  scripts\unittest\util::test_print("array field");
  x = a.foo;
  scripts\unittest\util::test_print("array field ref");
  a.foo = 0;
  scripts\unittest\util::test_print("vector field");
  x = v.foo;
  scripts\unittest\util::test_print("vector field ref");
  v.foo = 0;
  s.a[0] = 1;
  y = s.a[1];
  error_print("unknown array int", y);
  y = s.a["hi"];
  error_print("unknown array string", y);
  scripts\unittest\util::test_print("vec ref");
  v[0] = 0;
  scripts\unittest\util::test_print("str ref");
  str[0] = "x";
  s[0] = 0;
  scripts\unittest\util::test_print("array ref bad int index");
  a[16777216] = 0;
  scripts\unittest\util::test_print("array ref bad struct index");
  a[s] = 0;
  scripts\unittest\util::test_print("ent field array ref");
  _id_AC0E424AC96A7113.team[0] = 0;
  scripts\unittest\util::test_print("ent array ref");
  _id_AC0E424AC96A7113[0] = 0;
  y = v[3];
  error_print("vec bad int index", y);
  y = v["hi"];
  error_print("vec str index", y);
  y = str[3];
  error_print("str bad int index", y);
  y = str["hi"];
  error_print("str str index", y);
  y = a[16777216];
  error_print("array bad int index", y);
  y = a[s];
  error_print("array struct index", y);
  y = _id_AC0E424AC96A7113[0];
  error_print("ent array index", y);
  scripts\unittest\util::test_print("str clear");
  s[0] = undefined;
  scripts\unittest\util::test_print("array clear bad int index");
  a[16777216] = undefined;
  scripts\unittest\util::test_print("array clear struct index");
  a[s] = undefined;
  scripts\unittest\util::test_print("array clear player");
  _id_AC0E424AC96A7113[0] = undefined;
  scripts\unittest\util::test_print("array clear vector");
  v[0] = undefined;
  y = v.size;
  error_print("vector size", y);
  y = s.size;
  error_print("struct size", y);
  y = _id_AC0E424AC96A7113.size;
  error_print("player size", y);
  y = x.size;
  error_print("int size", y);
  scripts\unittest\util::test_print("bad vector");
  _id_B2D20569A97AFF8E = (0, str, 1);
}

wait_notify() {
  s = spawnStruct();
  x = 1;
  wait - 1.0;
  wait 16777216;
  wait(s);
  level waittill(1);
  x waittill("foo");
  level endon(1);
  x endon("foo");
  level notify(1);
  x notify("foo");
}

switch_func(msg, _id_06B5C8034010B9BA) {
  scripts\unittest\util::test_print(msg);

  switch (_id_06B5C8034010B9BA) {
    case 0:
      scripts\unittest\util::test_print("0");
      break;
    case "":
      scripts\unittest\util::test_print("empty");
      break;
    default:
      scripts\unittest\util::test_print("default");
      break;
  }

  scripts\unittest\util::test_print(msg + " end");
}

switch_test() {
  switch_func("switch float", 1.0);
  switch_func("switch bad int", 16777216);
  switch_func("switch struct", spawnStruct());
  switch_func("switch vec", [1, 2, 3]);
}

cond() {
  s = spawnStruct();

  if(s)
    scripts\unittest\util::test_print("struct if");
  else
    scripts\unittest\util::test_print("struct else");

  if(!s)
    scripts\unittest\util::test_print("struct not if");
  else
    scripts\unittest\util::test_print("struct not else");

  x = 1;
  y = "hi";

  if(x < y)
    scripts\unittest\util::test_print("lt if");
  else
    scripts\unittest\util::test_print("lt else");

  if(s && cond_func())
    scripts\unittest\util::test_print("and if");
  else
    scripts\unittest\util::test_print("and else");

  if(s || cond_func())
    scripts\unittest\util::test_print("or if");
  else
    scripts\unittest\util::test_print("or else");

  if(!(s < 1) && cond_func())
    scripts\unittest\util::test_print("!bool and if");
  else
    scripts\unittest\util::test_print("!bool and else");

  if(!(s < 1) || cond_func())
    scripts\unittest\util::test_print("!bool or if");
  else
    scripts\unittest\util::test_print("!bool or else");

  if(!s && cond_func())
    scripts\unittest\util::test_print("!struct and if");
  else
    scripts\unittest\util::test_print("!struct and else");

  if(!s || cond_func())
    scripts\unittest\util::test_print("!struct or if");
  else
    scripts\unittest\util::test_print("!struct or else");

  if(!(s && cond_func()))
    scripts\unittest\util::test_print("!(and) if");
  else
    scripts\unittest\util::test_print("!(and) else");

  if(!(s || cond_func()))
    scripts\unittest\util::test_print("!(or) if");
  else
    scripts\unittest\util::test_print("!(or) else");

  c = 0;

  while(x < y) {
    scripts\unittest\util::test_print("lt while: " + c);
    c++;

    if(c > 2) {
      break;
    }
  }

  c = 0;

  while(!(x < y)) {
    scripts\unittest\util::test_print("!lt while: " + c);
    c++;

    if(c > 2) {
      break;
    }
  }

  for(c = 0; c < 2 && x < y; s++) {
    scripts\unittest\util::test_print("lt for: " + c);
    c++;

    if(c > 2) {
      break;
    }
  }

  for(c = 0; c < 2 && !(x < y); s++) {
    scripts\unittest\util::test_print("!lt for: " + c);
    c++;

    if(c > 2) {
      break;
    }
  }
}

is_true_print(val, name) {
  b = istrue(val);

  if(!isDefined(b))
    b = "undefined";

  _id_AC0E564AC96A9D0F = isDefined(val);
  scripts\unittest\util::test_print("is_true: " + name + ": " + b + " isdefined: " + _id_AC0E564AC96A9D0F);
}

is_true() {
  a = [];
  is_true_print(a, "array");
  s = spawnStruct();
  is_true_print(s, "struct");
}

main() {
  scripts\unittest\util::test_begin("Error");
  params();
  types();
  wait_notify();
  switch_test();
  cond();
  is_true();
  scripts\unittest\util::test_end("Error");
}