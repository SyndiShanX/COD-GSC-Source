/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\benchmark.gsc
***********************************************/

_id_63ABC2408F9EF4BA(name) {
  level._id_2B911118B9F2E6C0[name] = getsystemtimeinmicroseconds();
}

_id_B41D4C50A5CB0A36(name) {
  time = getsystemtimeinmicroseconds();

  if(!isDefined(level._id_5ABCC6F847B4E3EE[name]))
    level._id_5ABCC6F847B4E3EE[name] = 0;

  _id_4573A8725DD3748E = time - level._id_2B911118B9F2E6C0[name];
  level._id_5ABCC6F847B4E3EE[name] = level._id_5ABCC6F847B4E3EE[name] + _id_4573A8725DD3748E;
}

_id_988C6C7C7776406C() {
  sysprint("Bench_ForLoopRef\n");
  _id_380081ED3D43C6AA = getdvarint("dvar_939FFA702B7DA068", 10000);
  _id_63ABC2408F9EF4BA("ForLoopRef");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_380081ED3D43C6AA; _id_AC0E594AC96AA3A8++) {}

  _id_B41D4C50A5CB0A36("ForLoopRef");
}

_id_176ECC9D5B3767F0() {
  sysprint("Bench_ForEach\n");
  _id_380081ED3D43C6AA = getdvarint("dvar_939FFA702B7DA068", 10000);
  a = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10000; _id_AC0E594AC96AA3A8++)
    a[_id_AC0E594AC96AA3A8] = _id_AC0E594AC96AA3A8;

  _id_63ABC2408F9EF4BA("ForEach");

  foreach(_id_AC0E5B4AC96AA80E, v in a) {}

  _id_B41D4C50A5CB0A36("ForEach");
  _id_63ABC2408F9EF4BA("ForEach_Val");

  foreach(x in a) {}

  _id_B41D4C50A5CB0A36("ForEach_Val");
}

_id_18CB5FB798C607CD() {
  sysprint("Bench_ForEachSetup\n");
  _id_380081ED3D43C6AA = getdvarint("dvar_939FFA702B7DA068", 10000);
  a = [];
  a[0] = 0;
  _id_63ABC2408F9EF4BA("ForEachSetup");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_380081ED3D43C6AA; _id_AC0E594AC96AA3A8++) {
    foreach(_id_AC0E5B4AC96AA80E, v in a) {}
  }

  _id_B41D4C50A5CB0A36("ForEachSetup");
  _id_63ABC2408F9EF4BA("ForEachSetup_Val");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_380081ED3D43C6AA; _id_AC0E594AC96AA3A8++) {
    foreach(x in a) {}
  }

  _id_B41D4C50A5CB0A36("ForEachSetup_Val");
}

_id_E4E266C2C4EBF49E() {
  sysprint("Bench_ForArray\n");
  _id_380081ED3D43C6AA = getdvarint("dvar_939FFA702B7DA068", 10000);
  a = [];
  _id_63ABC2408F9EF4BA("ForArray");
  _id_63ABC2408F9EF4BA("ForArray_Init");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10000; _id_AC0E594AC96AA3A8++)
    a[_id_AC0E594AC96AA3A8] = _id_AC0E594AC96AA3A8;

  _id_B41D4C50A5CB0A36("ForArray_Init");
  _id_63ABC2408F9EF4BA("ForArray_Eval");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < a.size; _id_AC0E594AC96AA3A8++)
    t = a[_id_AC0E594AC96AA3A8];

  _id_B41D4C50A5CB0A36("ForArray_Eval");
  _id_B41D4C50A5CB0A36("ForArray");
}

_id_723EBFCDAA798C34() {
  sysprint("Bench_ForLoopSetup\n");
  _id_380081ED3D43C6AA = getdvarint("dvar_939FFA702B7DA068", 10000);
  _id_63ABC2408F9EF4BA("ForLoopSetup");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_380081ED3D43C6AA; _id_AC0E594AC96AA3A8++) {
    for(_id_AC0E5C4AC96AAA41 = 0; _id_AC0E5C4AC96AAA41 < 1; _id_AC0E5C4AC96AAA41++) {}
  }

  _id_B41D4C50A5CB0A36("ForLoopSetup");
}

_id_10F6D810677CEE84() {
  sysprint("Bench_IfElse\n");
  _id_380081ED3D43C6AA = getdvarint("dvar_939FFA702B7DA068", 10000);
  a = 1;
  _id_63ABC2408F9EF4BA("IfElse");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_380081ED3D43C6AA; _id_AC0E594AC96AA3A8++) {
    if(a == 0) {
      a = 1;
      continue;
    }

    a = 0;
  }

  _id_B41D4C50A5CB0A36("IfElse");
}

_id_9628BF5282B8BAFC() {
  sysprint("Bench_AllocVar\n");
  _id_380081ED3D43C6AA = getdvarint("dvar_939FFA702B7DA068", 10000);
  a = 0;
  _id_63ABC2408F9EF4BA("AllocVar");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_380081ED3D43C6AA; _id_AC0E594AC96AA3A8++) {
    if(_id_AC0E594AC96AA3A8 & 1) {
      x = 0;
      y = 1;
      z = 2;
    }

    a++;
  }

  _id_B41D4C50A5CB0A36("AllocVar");
}

_id_41D5B4596B4CF805() {}

_id_DFF6885D265DB0FD() {
  sysprint("Bench_MinScriptFunction\n");
  _id_380081ED3D43C6AA = getdvarint("dvar_939FFA702B7DA068", 10000);
  _id_63ABC2408F9EF4BA("MinScriptFunction");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_380081ED3D43C6AA; _id_AC0E594AC96AA3A8++)
    _id_41D5B4596B4CF805();

  _id_B41D4C50A5CB0A36("MinScriptFunction");
}

_id_EFADCC2E0FB51AAA(a) {}

_id_2308F139D0FFBC41() {
  sysprint("Bench_OneArgScriptFunction\n");
  _id_380081ED3D43C6AA = getdvarint("dvar_939FFA702B7DA068", 10000);
  a = 0;
  _id_63ABC2408F9EF4BA("OneArgScriptFunction");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_380081ED3D43C6AA; _id_AC0E594AC96AA3A8++)
    _id_EFADCC2E0FB51AAA(a);

  _id_B41D4C50A5CB0A36("OneArgScriptFunction");
}

_id_C7C4508CA492914F(a, b, c, _id_AC0E564AC96A9D0F, e, f, g, h, _id_AC0E5C4AC96AAA41, _id_AC0E5B4AC96AA80E) {}

_id_76D6D0FEEDD3126B() {
  sysprint("Bench_MaxScriptFunc\n");
  _id_380081ED3D43C6AA = getdvarint("dvar_939FFA702B7DA068", 10000);
  a = 0;
  b = 1;
  c = 2;
  _id_AC0E564AC96A9D0F = 3;
  e = 4;
  f = 5;
  g = 6;
  h = 7;
  _id_AC0E5C4AC96AAA41 = 8;
  _id_AC0E5B4AC96AA80E = 9;
  _id_63ABC2408F9EF4BA("MaxScriptFunc");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_380081ED3D43C6AA; _id_AC0E594AC96AA3A8++)
    _id_C7C4508CA492914F(a, b, c, _id_AC0E564AC96A9D0F, e, f, g, h, _id_AC0E5C4AC96AAA41, _id_AC0E5B4AC96AA80E);

  _id_B41D4C50A5CB0A36("MaxScriptFunc");
}

_id_589FD6B13CA60155() {
  sysprint("Bench_BuiltinFunction\n");
  _id_380081ED3D43C6AA = getdvarint("dvar_939FFA702B7DA068", 10000);
  _id_63ABC2408F9EF4BA("BuiltinFunction");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_380081ED3D43C6AA; _id_AC0E594AC96AA3A8++)
    t = gettime();

  _id_B41D4C50A5CB0A36("BuiltinFunction");
}

_id_CAE58617E7945254() {
  sysprint("Bench_BuiltinMethod\n");
  _id_380081ED3D43C6AA = getdvarint("dvar_939FFA702B7DA068", 10000);
  _id_AC0E424AC96A7113 = level.players[0];

  if(!isDefined(_id_AC0E424AC96A7113)) {
    _id_63ABC2408F9EF4BA("BuiltinMethod");
    _id_B41D4C50A5CB0A36("BuiltinMethod");
    return;
  }

  _id_63ABC2408F9EF4BA("BuiltinMethod");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_380081ED3D43C6AA; _id_AC0E594AC96AA3A8++)
    _id_AC0E424AC96A7113 allowfire(0);

  _id_B41D4C50A5CB0A36("BuiltinMethod");
  _id_AC0E424AC96A7113 allowfire(1);
}

_id_D887BC54EF7149B3() {
  sysprint("Bench_Variables\n");
  _id_380081ED3D43C6AA = getdvarint("dvar_939FFA702B7DA068", 10000);
  _id_63ABC2408F9EF4BA("Variables");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_380081ED3D43C6AA; _id_AC0E594AC96AA3A8++) {
    a = 0;
    b = 1;
    c = 2;
    _id_AC0E564AC96A9D0F = 3;
    e = 4;
    f = 5;
    g = 6;
    h = 7;
    _id_AC0E5C4AC96AAA41 = 8;
    _id_AC0E5B4AC96AA80E = 9;
  }

  _id_B41D4C50A5CB0A36("Variables");
}

_id_5C2E9DBA74D2864C() {
  sysprint("Bench_Strings\n");
  _id_380081ED3D43C6AA = getdvarint("dvar_939FFA702B7DA068", 10000);
  _id_63ABC2408F9EF4BA("Strings");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_380081ED3D43C6AA; _id_AC0E594AC96AA3A8++) {
    a = "foo";
    b = "foo";
    c = "foo2";
    _id_AC0E564AC96A9D0F = "foo2";
    e = a == b;
    f = c == a;
    g = a + b;
    h = c + _id_AC0E564AC96A9D0F;
    _id_AC0E5C4AC96AAA41 = a + c;
    _id_AC0E5B4AC96AA80E = _id_AC0E564AC96A9D0F + a;
  }

  _id_B41D4C50A5CB0A36("Strings");
}

_id_ADD278CEB4188914() {
  sysprint("Bench_Arrays\n");
  _id_380081ED3D43C6AA = getdvarint("dvar_939FFA702B7DA068", 10000);
  _id_63ABC2408F9EF4BA("Arrays");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_380081ED3D43C6AA; _id_AC0E594AC96AA3A8++) {
    _id_63ABC2408F9EF4BA("Arrays_Number");
    a = [];
    a[0] = 0;
    a[1] = 1;
    x = a[0] + a[1];
    a[0] = undefined;
    a[1] = undefined;
    _id_B41D4C50A5CB0A36("Arrays_Number");
    _id_63ABC2408F9EF4BA("Arrays_String");
    a = [];
    a["foo"] = 0;
    a["bar"] = 1;
    x = a["foo"] + a["bar"];
    a["foo"] = undefined;
    a["bar"] = undefined;
    _id_B41D4C50A5CB0A36("Arrays_String");
  }

  _id_B41D4C50A5CB0A36("Arrays");
}

_id_8373207C6B8FE2C3() {
  sysprint("Bench_Fields\n");
  _id_380081ED3D43C6AA = getdvarint("dvar_939FFA702B7DA068", 10000);
  s = spawnStruct();
  level.s = spawnStruct();
  _id_63ABC2408F9EF4BA("Fields");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_380081ED3D43C6AA; _id_AC0E594AC96AA3A8++) {
    _id_63ABC2408F9EF4BA("Fields_Local");
    s.foo = 0;
    s.bar = 1;
    s._id_BE66DE030B25508C = s.foo + s.bar;
    s.foo = "hi";
    s.msg = s.foo + s.bar;
    s.foo = undefined;
    s.bar = undefined;
    _id_B41D4C50A5CB0A36("Fields_Local");
    _id_63ABC2408F9EF4BA("Fields_Level");
    level.foo = 0;
    level.bar = 1;
    level._id_BE66DE030B25508C = level.foo + level.bar;
    level.foo = "hi";
    level.msg = level.foo + level.bar;
    level.foo = undefined;
    level.bar = undefined;
    _id_B41D4C50A5CB0A36("Fields_Level");
    _id_63ABC2408F9EF4BA("Fields_Level_Nested");
    level.s.foo = 0;
    level.s.bar = 1;
    level.s._id_BE66DE030B25508C = level.s.foo + level.s.bar;
    level.s.foo = "hi";
    level.s.msg = level.s.foo + level.s.bar;
    level.s.foo = undefined;
    level.s.bar = undefined;
    _id_B41D4C50A5CB0A36("Fields_Level_Nested");
  }

  _id_B41D4C50A5CB0A36("Fields");
}

_id_713ED9AE70C22B36() {
  sysprint("Bench_Ops\n");
  _id_380081ED3D43C6AA = getdvarint("dvar_939FFA702B7DA068", 10000);
  s = spawnStruct();
  _id_63ABC2408F9EF4BA("Ops");
  x = 0;
  s.x = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_380081ED3D43C6AA; _id_AC0E594AC96AA3A8++) {
    _id_63ABC2408F9EF4BA("Ops_Local");
    x = x + _id_AC0E594AC96AA3A8;
    x = x + 2;
    _id_B41D4C50A5CB0A36("Ops_Local");
    _id_63ABC2408F9EF4BA("Ops_Object");
    s.x = s.x + _id_AC0E594AC96AA3A8;
    s.x = s.x + 2;
    _id_B41D4C50A5CB0A36("Ops_Object");
  }

  _id_B41D4C50A5CB0A36("Ops");
  _id_63ABC2408F9EF4BA("OpsCast");
  x = "a";
  s.x = "a";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_380081ED3D43C6AA; _id_AC0E594AC96AA3A8++) {
    _id_63ABC2408F9EF4BA("OpsCast_Local");
    y = x + _id_AC0E594AC96AA3A8;
    y = x + 2;
    _id_B41D4C50A5CB0A36("OpsCast_Local");
    _id_63ABC2408F9EF4BA("OpsCast_Object");
    s.y = s.x + _id_AC0E594AC96AA3A8;
    s.y = s.x + 2;
    _id_B41D4C50A5CB0A36("OpsCast_Object");
  }

  _id_B41D4C50A5CB0A36("OpsCast");
}

_id_9CD6CC4B2F8E5E8F() {}

_id_C0C13C7D2F02753B() {
  sysprint("Bench_FunctionPointer\n");
  _id_380081ED3D43C6AA = getdvarint("dvar_939FFA702B7DA068", 10000);
  f = ::_id_9CD6CC4B2F8E5E8F;
  _id_63ABC2408F9EF4BA("FunctionPointer");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_380081ED3D43C6AA; _id_AC0E594AC96AA3A8++)
    [[f]]();

  _id_B41D4C50A5CB0A36("FunctionPointer");
}

_id_56F6DEFB83C08190() {
  sysprint("Bench_MethodPointer\n");
  _id_380081ED3D43C6AA = getdvarint("dvar_939FFA702B7DA068", 10000);
  f = ::_id_9CD6CC4B2F8E5E8F;
  s = spawnStruct();
  _id_63ABC2408F9EF4BA("MethodPointer");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_380081ED3D43C6AA; _id_AC0E594AC96AA3A8++)
    s[[f]]();

  _id_B41D4C50A5CB0A36("MethodPointer");
}

_id_E9372CB2B92B01E7(waittime, _id_08942D67F3B4BB0F) {
  level endon("bench_thread_end");

  for(;;) {
    wait(waittime);
    _id_63ABC2408F9EF4BA("Thread_Function");
    _id_CE2D7178F580AABF = 0;
    f1 = 1;
    _id_F5993B554811E35D = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_08942D67F3B4BB0F; _id_AC0E594AC96AA3A8++) {
      f = _id_CE2D7178F580AABF + f1;
      _id_CE2D7178F580AABF = f1;
      f1 = f;

      if(f % 2 == 0) {
        val = 1;
        continue;
      }

      val = 0;
    }

    _id_B41D4C50A5CB0A36("Thread_Function");
  }
}

_id_399C9C5744905103() {
  sysprint("Bench_Threads\n");
  _id_FFAEA134A9BA7EBB = 100;
  _id_63ABC2408F9EF4BA("Threads");
  waittime = 0.01;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FFAEA134A9BA7EBB; _id_AC0E594AC96AA3A8++) {
    level thread _id_E9372CB2B92B01E7(waittime, _id_AC0E594AC96AA3A8);
    waittime = waittime + 0.01;

    if(waittime > 0.5)
      waittime = 0.01;
  }

  _id_B41D4C50A5CB0A36("Threads");
  sysprint("Bench_Threads_Wait\n");
  wait 1;
  sysprint("Bench_Threads_Notify\n");
  level notify("bench_thread_end");
}

_id_1CB0315D0CDACBA4() {
  sysprint("Bench_getdvars\n");
  _id_380081ED3D43C6AA = getdvarint("dvar_939FFA702B7DA068", 10000);
  _id_63ABC2408F9EF4BA("GetDvars");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_380081ED3D43C6AA; _id_AC0E594AC96AA3A8++)
    test = getdvarint("dvar_939FFA702B7DA068", 10000);

  _id_B41D4C50A5CB0A36("GetDvars");
}

_id_D5BCE87878A08018() {
  sysprint("Bench_setdvars\n");
  _id_380081ED3D43C6AA = getdvarint("dvar_939FFA702B7DA068", 10000);
  _id_63ABC2408F9EF4BA("SetDvars");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_380081ED3D43C6AA; _id_AC0E594AC96AA3A8++)
    setDvar("benchmark_test", _id_AC0E594AC96AA3A8);

  _id_B41D4C50A5CB0A36("SetDvars");
}

_id_8193A06614F54E87() {
  sysprint("Bench_Start\n");
  _id_AC0E594AC96AA3A8 = 0;
  level._id_2B911118B9F2E6C0 = [];
  level._id_5ABCC6F847B4E3EE = [];
}

_id_4912BD03F307546C() {
  sysprint("Bench_End\n");
  _id_AC0E594AC96AA3A8 = 0;
  s = "\n";

  foreach(_id_AC0E5B4AC96AA80E, v in level._id_5ABCC6F847B4E3EE) {
    s = s + _id_AC0E5B4AC96AA80E;
    s = s + ",";
  }

  sysprint(s);
  s = "";

  foreach(v in level._id_5ABCC6F847B4E3EE) {
    s = s + v / 1000;
    s = s + ",";
  }

  s = s + "\n";
  sysprint(s);
}

_id_D69DB7DFBC818978() {
  _id_AC669A8C41355734 = [];

  if(getdvarint("dvar_44E9F4A106F9B4A1", 0) > 0) {
    _id_D468F1D46482F846 = getdvarint("dvar_44E9F4A106F9B4A1", 0);

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D468F1D46482F846; _id_AC0E594AC96AA3A8++)
      _id_AC669A8C41355734[_id_AC0E594AC96AA3A8] = _id_AC0E594AC96AA3A8;
  }

  _id_8193A06614F54E87();

  if(_id_63D722F2C9E256A4("0")) {
    _id_988C6C7C7776406C();
    wait 0.05;
  }

  if(_id_63D722F2C9E256A4("I")) {
    _id_723EBFCDAA798C34();
    wait 0.05;
  }

  if(_id_63D722F2C9E256A4("1")) {
    _id_E4E266C2C4EBF49E();
    wait 0.05;
  }

  if(_id_63D722F2C9E256A4("J")) {
    _id_18CB5FB798C607CD();
    wait 0.05;
  }

  if(_id_63D722F2C9E256A4("2")) {
    _id_176ECC9D5B3767F0();
    wait 0.05;
  }

  if(_id_63D722F2C9E256A4("3")) {
    _id_10F6D810677CEE84();
    wait 0.05;
  }

  if(_id_63D722F2C9E256A4("K")) {
    _id_9628BF5282B8BAFC();
    wait 0.05;
  }

  if(_id_63D722F2C9E256A4("4")) {
    _id_DFF6885D265DB0FD();
    wait 0.05;
  }

  if(_id_63D722F2C9E256A4("5")) {
    _id_2308F139D0FFBC41();
    wait 0.05;
  }

  if(_id_63D722F2C9E256A4("6")) {
    _id_76D6D0FEEDD3126B();
    wait 0.05;
  }

  if(_id_63D722F2C9E256A4("7")) {
    _id_589FD6B13CA60155();
    wait 0.05;
  }

  if(_id_63D722F2C9E256A4("8")) {
    _id_CAE58617E7945254();
    wait 0.05;
  }

  if(_id_63D722F2C9E256A4("9")) {
    _id_D887BC54EF7149B3();
    wait 0.05;
  }

  if(_id_63D722F2C9E256A4("A")) {
    _id_ADD278CEB4188914();
    wait 0.05;
  }

  if(_id_63D722F2C9E256A4("B")) {
    _id_8373207C6B8FE2C3();
    wait 0.05;
  }

  if(_id_63D722F2C9E256A4("C")) {
    _id_713ED9AE70C22B36();
    wait 0.05;
  }

  if(_id_63D722F2C9E256A4("D")) {
    _id_C0C13C7D2F02753B();
    wait 0.05;
  }

  if(_id_63D722F2C9E256A4("E")) {
    _id_56F6DEFB83C08190();
    wait 0.05;
  }

  if(_id_63D722F2C9E256A4("F")) {
    _id_399C9C5744905103();
    wait 0.05;
  }

  if(_id_63D722F2C9E256A4("G")) {
    _id_1CB0315D0CDACBA4();
    wait 0.05;
  }

  if(_id_63D722F2C9E256A4("H")) {
    _id_D5BCE87878A08018();
    wait 0.05;
  }

  if(_id_63D722F2C9E256A4("L")) {
    _id_5C2E9DBA74D2864C();
    wait 0.05;
  }

  _id_4912BD03F307546C();
}

_id_63D722F2C9E256A4(a) {
  if(issubstr(getDvar("dvar_86EF66E581C77F50", ""), a + ","))
    return 1;

  return 0;
}

main() {
  level thread _id_041E013DCB5B7B2A();
  setdvarifuninitialized("dvar_939FFA702B7DA068", 10000);
  setdvarifuninitialized("scr_benchmark", 0);
  setdvarifuninitialized("dvar_44E9F4A106F9B4A1", 0);
  setdvarifuninitialized("dvar_86EF66E581C77F50", "0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,");

  for(;;) {
    while(getdvarint("scr_benchmark", 0) == 0)
      wait 1;

    _id_D69DB7DFBC818978();
    setDvar("scr_benchmark", 0);
  }
}

_id_3F799A2B0456480A() {
  a = spawnStruct();
  b = spawnStruct();
  a.next = b;
  b.next = a;
}

_id_041E013DCB5B7B2A() {
  setdvarifuninitialized("dvar_8C14A9CFACA224D4", 0);

  for(;;) {
    while(getdvarint("dvar_8C14A9CFACA224D4", 0) == 0)
      wait 1;

    _id_3F799A2B0456480A();
    setDvar("dvar_8C14A9CFACA224D4", 0);
  }
}