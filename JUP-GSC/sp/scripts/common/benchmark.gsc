/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\common\benchmark.gsc
***********************************************/

#namespace benchmark;

function function_63abc2408f9ef4ba(name) {
  level.var_2b911118b9f2e6c0[name] = getsystemtimeinmicroseconds();
}

function function_b41d4c50a5cb0a36(name) {
  time = getsystemtimeinmicroseconds();

  if(!isDefined(level.var_5abcc6f847b4e3ee[name])) {
    level.var_5abcc6f847b4e3ee[name] = 0;
  }

  diff = time - level.var_2b911118b9f2e6c0[name];
  level.var_5abcc6f847b4e3ee[name] += diff;
}

function function_988c6c7c7776406c() {
  println("<dev string:x1c>");
  max_iterations = getdvarint(@ "hash_939ffa702b7da068", 10000);
  function_63abc2408f9ef4ba("ForLoopRef");

  for(i = 0; i < max_iterations; i++) {}

  function_b41d4c50a5cb0a36("ForLoopRef");
}

function bench_foreach() {
  println("<dev string:x2e>");
  max_iterations = getdvarint(@ "hash_939ffa702b7da068", 10000);
  a = [];

  for(i = 0; i < 10000; i++) {
    a[i] = i;
  }

  function_63abc2408f9ef4ba("ForEach");

  foreach(v in a) {}

  function_b41d4c50a5cb0a36("ForEach");
  function_63abc2408f9ef4ba("ForEach_Val");

  foreach(x in a) {}

  function_b41d4c50a5cb0a36("ForEach_Val");
}

function function_18cb5fb798c607cd() {
  println("<dev string:x3d>");
  max_iterations = getdvarint(@ "hash_939ffa702b7da068", 10000);
  a = [];
  a[0] = 0;
  function_63abc2408f9ef4ba("ForEachSetup");

  for(i = 0; i < max_iterations; i++) {
    foreach(v in a) {}
  }

  function_b41d4c50a5cb0a36("ForEachSetup");
  function_63abc2408f9ef4ba("ForEachSetup_Val");

  for(i = 0; i < max_iterations; i++) {
    foreach(x in a) {}
  }

  function_b41d4c50a5cb0a36("ForEachSetup_Val");
}

function function_e4e266c2c4ebf49e() {
  println("<dev string:x51>");
  max_iterations = getdvarint(@ "hash_939ffa702b7da068", 10000);
  a = [];
  function_63abc2408f9ef4ba("ForArray");
  function_63abc2408f9ef4ba("ForArray_Init");

  for(i = 0; i < 10000; i++) {
    a[i] = i;
  }

  function_b41d4c50a5cb0a36("ForArray_Init");
  function_63abc2408f9ef4ba("ForArray_Eval");

  for(i = 0; i < a.size; i++) {
    t = a[i];
  }

  function_b41d4c50a5cb0a36("ForArray_Eval");
  function_b41d4c50a5cb0a36("ForArray");
}

function function_723ebfcdaa798c34() {
  println("<dev string:x61>");
  max_iterations = getdvarint(@ "hash_939ffa702b7da068", 10000);
  function_63abc2408f9ef4ba("ForLoopSetup");

  for(i = 0; i < max_iterations; i++) {
    for(j = 0; j < 1; j++) {}
  }

  function_b41d4c50a5cb0a36("ForLoopSetup");
}

function function_10f6d810677cee84() {
  println("<dev string:x75>");
  max_iterations = getdvarint(@ "hash_939ffa702b7da068", 10000);
  a = 1;
  function_63abc2408f9ef4ba("IfElse");

  for(i = 0; i < max_iterations; i++) {
    if(a == 0) {
      a = 1;
      continue;
    }

    a = 0;
  }

  function_b41d4c50a5cb0a36("IfElse");
}

function function_9628bf5282b8bafc() {
  println("<dev string:x83>");
  max_iterations = getdvarint(@ "hash_939ffa702b7da068", 10000);
  a = 0;
  function_63abc2408f9ef4ba("AllocVar");

  for(i = 0; i < max_iterations; i++) {
    if(i & 1) {
      x = 0;
      y = 1;
      z = 2;
    }

    a++;
  }

  function_b41d4c50a5cb0a36("AllocVar");
}

function function_41d5b4596b4cf805() {}

function function_dff6885d265db0fd() {
  println("<dev string:x93>");
  max_iterations = getdvarint(@ "hash_939ffa702b7da068", 10000);
  function_63abc2408f9ef4ba("MinScriptFunction");

  for(i = 0; i < max_iterations; i++) {
    function_41d5b4596b4cf805();
  }

  function_b41d4c50a5cb0a36("MinScriptFunction");
}

function function_efadcc2e0fb51aaa(a) {}

function function_2308f139d0ffbc41() {
  println("<dev string:xac>");
  max_iterations = getdvarint(@ "hash_939ffa702b7da068", 10000);
  a = 0;
  function_63abc2408f9ef4ba("OneArgScriptFunction");

  for(i = 0; i < max_iterations; i++) {
    function_efadcc2e0fb51aaa(a);
  }

  function_b41d4c50a5cb0a36("OneArgScriptFunction");
}

function function_c7c4508ca492914f(a, b, c, d, e, f, g, h, j, k) {}

function function_76d6d0feedd3126b() {
  println("<dev string:xc8>");
  max_iterations = getdvarint(@ "hash_939ffa702b7da068", 10000);
  a = 0;
  b = 1;
  c = 2;
  d = 3;
  e = 4;
  f = 5;
  g = 6;
  h = 7;
  j = 8;
  k = 9;
  function_63abc2408f9ef4ba("MaxScriptFunc");

  for(i = 0; i < max_iterations; i++) {
    function_c7c4508ca492914f(a, b, c, d, e, f, g, h, j, k);
  }

  function_b41d4c50a5cb0a36("MaxScriptFunc");
}

function function_589fd6b13ca60155() {
  println("<dev string:xdd>");
  max_iterations = getdvarint(@ "hash_939ffa702b7da068", 10000);
  function_63abc2408f9ef4ba("BuiltinFunction");

  for(i = 0; i < max_iterations; i++) {
    t = gettime();
  }

  function_b41d4c50a5cb0a36("BuiltinFunction");
}

function function_cae58617e7945254() {
  println("<dev string:xf4>");
  max_iterations = getdvarint(@ "hash_939ffa702b7da068", 10000);
  p = level.players[0];

  if(!isDefined(p)) {
    function_63abc2408f9ef4ba("BuiltinMethod");
    function_b41d4c50a5cb0a36("BuiltinMethod");
    return;
  }

  function_63abc2408f9ef4ba("BuiltinMethod");

  for(i = 0; i < max_iterations; i++) {
    p allowfire(0);
  }

  function_b41d4c50a5cb0a36("BuiltinMethod");
  p allowfire(1);
}

function bench_variables() {
  println("<dev string:x109>");
  max_iterations = getdvarint(@ "hash_939ffa702b7da068", 10000);
  function_63abc2408f9ef4ba("Variables");

  for(i = 0; i < max_iterations; i++) {
    a = 0;
    b = 1;
    c = 2;
    d = 3;
    e = 4;
    f = 5;
    g = 6;
    h = 7;
    j = 8;
    k = 9;
  }

  function_b41d4c50a5cb0a36("Variables");
}

function bench_strings() {
  println("<dev string:x11a>");
  max_iterations = getdvarint(@ "hash_939ffa702b7da068", 10000);
  function_63abc2408f9ef4ba("Strings");

  for(i = 0; i < max_iterations; i++) {
    a = "foo";
    b = "foo";
    c = "foo2";
    d = "foo2";
    e = a == b;
    f = c == a;
    g = a + b;
    h = c + d;
    j = a + c;
    k = d + a;
  }

  function_b41d4c50a5cb0a36("Strings");
}

function bench_arrays() {
  println("<dev string:x129>");
  max_iterations = getdvarint(@ "hash_939ffa702b7da068", 10000);
  function_63abc2408f9ef4ba("Arrays");

  for(i = 0; i < max_iterations; i++) {
    function_63abc2408f9ef4ba("Arrays_Number");
    a = [];
    a[0] = 0;
    a[1] = 1;
    x = a[0] + a[1];
    a[0] = undefined;
    a[1] = undefined;
    function_b41d4c50a5cb0a36("Arrays_Number");
    function_63abc2408f9ef4ba("Arrays_String");
    a = [];
    a["foo"] = 0;
    a["bar"] = 1;
    x = a["foo"] + a["bar"];
    a["foo"] = undefined;
    a["bar"] = undefined;
    function_b41d4c50a5cb0a36("Arrays_String");
  }

  function_b41d4c50a5cb0a36("Arrays");
}

function bench_fields() {
  println("<dev string:x137>");
  max_iterations = getdvarint(@ "hash_939ffa702b7da068", 10000);
  s = spawnStruct();
  level.s = spawnStruct();
  function_63abc2408f9ef4ba("Fields");

  for(i = 0; i < max_iterations; i++) {
    function_63abc2408f9ef4ba("Fields_Local");
    s.foo = 0;
    s.bar = 1;
    s.sum = s.foo + s.bar;
    s.foo = "hi";
    s.msg = s.foo + s.bar;
    s.foo = undefined;
    s.bar = undefined;
    function_b41d4c50a5cb0a36("Fields_Local");
    function_63abc2408f9ef4ba("Fields_Level");
    level.foo = 0;
    level.bar = 1;
    level.sum = level.foo + level.bar;
    level.foo = "hi";
    level.msg = level.foo + level.bar;
    level.foo = undefined;
    level.bar = undefined;
    function_b41d4c50a5cb0a36("Fields_Level");
    function_63abc2408f9ef4ba("Fields_Level_Nested");
    level.s.foo = 0;
    level.s.bar = 1;
    level.s.sum = level.s.foo + level.s.bar;
    level.s.foo = "hi";
    level.s.msg = level.s.foo + level.s.bar;
    level.s.foo = undefined;
    level.s.bar = undefined;
    function_b41d4c50a5cb0a36("Fields_Level_Nested");
  }

  function_b41d4c50a5cb0a36("Fields");
}

function function_713ed9ae70c22b36() {
  println("<dev string:x145>");
  max_iterations = getdvarint(@ "hash_939ffa702b7da068", 10000);
  s = spawnStruct();
  function_63abc2408f9ef4ba("Ops");
  x = 0;
  s.x = 0;

  for(i = 0; i < max_iterations; i++) {
    function_63abc2408f9ef4ba("Ops_Local");
    x += i;
    x += 2;
    function_b41d4c50a5cb0a36("Ops_Local");
    function_63abc2408f9ef4ba("Ops_Object");
    s.x += i;
    s.x += 2;
    function_b41d4c50a5cb0a36("Ops_Object");
  }

  function_b41d4c50a5cb0a36("Ops");
  function_63abc2408f9ef4ba("OpsCast");
  x = "a";
  s.x = "a";

  for(i = 0; i < max_iterations; i++) {
    function_63abc2408f9ef4ba("OpsCast_Local");
    y = x + i;
    y = x + 2;
    function_b41d4c50a5cb0a36("OpsCast_Local");
    function_63abc2408f9ef4ba("OpsCast_Object");
    s.y = s.x + i;
    s.y = s.x + 2;
    function_b41d4c50a5cb0a36("OpsCast_Object");
  }

  function_b41d4c50a5cb0a36("OpsCast");
}

function function_9cd6cc4b2f8e5e8f() {}

function function_c0c13c7d2f02753b() {
  println("<dev string:x150>");
  max_iterations = getdvarint(@ "hash_939ffa702b7da068", 10000);
  f = &function_9cd6cc4b2f8e5e8f;
  function_63abc2408f9ef4ba("FunctionPointer");

  for(i = 0; i < max_iterations; i++) {
    [[f]]();
  }

  function_b41d4c50a5cb0a36("FunctionPointer");
}

function function_56f6defb83c08190() {
  println("<dev string:x167>");
  max_iterations = getdvarint(@ "hash_939ffa702b7da068", 10000);
  f = &function_9cd6cc4b2f8e5e8f;
  s = spawnStruct();
  function_63abc2408f9ef4ba("MethodPointer");

  for(i = 0; i < max_iterations; i++) {
    s[[f]]();
  }

  function_b41d4c50a5cb0a36("MethodPointer");
}

function function_e9372cb2b92b01e7(waittime, var_8942d67f3b4bb0f) {
  level endon("bench_thread_end");

  while(true) {
    wait waittime;
    function_63abc2408f9ef4ba("Thread_Function");
    f0 = 0;
    f1 = 1;
    even = 0;

    for(i = 0; i < var_8942d67f3b4bb0f; i++) {
      f = f0 + f1;
      f0 = f1;
      f1 = f;

      if(f % 2 == 0) {
        val = 1;
        continue;
      }

      val = 0;
    }

    function_b41d4c50a5cb0a36("Thread_Function");
  }
}

function bench_threads() {
  println("<dev string:x17c>");
  max_threads = 100;
  function_63abc2408f9ef4ba("Threads");
  waittime = 0.01;

  for(i = 0; i < max_threads; i++) {
    level thread function_e9372cb2b92b01e7(waittime, i);
    waittime += 0.01;

    if(waittime > 0.5) {
      waittime = 0.01;
    }
  }

  function_b41d4c50a5cb0a36("Threads");
  println("<dev string:x18b>");
  wait 1;
  println("<dev string:x19f>");
  level notify("bench_thread_end");
}

function function_1cb0315d0cdacba4() {
  println("<dev string:x1b5>");
  max_iterations = getdvarint(@ "hash_939ffa702b7da068", 10000);
  function_63abc2408f9ef4ba("GetDvars");

  for(i = 0; i < max_iterations; i++) {
    test = getdvarint(@ "hash_939ffa702b7da068", 10000);
  }

  function_b41d4c50a5cb0a36("GetDvars");
}

function function_d5bce87878a08018() {
  println("<dev string:x1c5>");
  max_iterations = getdvarint(@ "hash_939ffa702b7da068", 10000);
  function_63abc2408f9ef4ba("SetDvars");

  for(i = 0; i < max_iterations; i++) {
    setDvar(@ "hash_e717cc3034fbdf76", i);
  }

  function_b41d4c50a5cb0a36("SetDvars");
}

function function_8193a06614f54e87() {
  println("<dev string:x1d5>");
  i = 0;
  level.var_2b911118b9f2e6c0 = [];
  level.var_5abcc6f847b4e3ee = [];
}

function function_4912bd03f307546c() {
  println("<dev string:x1e2>");
  i = 0;
  s = "\n";

  foreach(v in level.var_5abcc6f847b4e3ee) {
    s += k;
    s += ",";
  }

  println(s);
  s = "";

  foreach(v in level.var_5abcc6f847b4e3ee) {
    s += v / 1000;
    s += ",";
  }

  s += "\n";
  println(s);
}

function benchmark() {
  test_vars = [];

  if(getdvarint(@ "hash_44e9f4a106f9b4a1", 0) > 0) {
    num_vars = getdvarint(@ "hash_44e9f4a106f9b4a1", 0);

    for(i = 0; i < num_vars; i++) {
      test_vars[i] = i;
    }
  }

  function_8193a06614f54e87();

  if(shouldbench("0")) {
    function_988c6c7c7776406c();
    wait 0.05;
  }

  if(shouldbench("I")) {
    function_723ebfcdaa798c34();
    wait 0.05;
  }

  if(shouldbench("1")) {
    function_e4e266c2c4ebf49e();
    wait 0.05;
  }

  if(shouldbench("J")) {
    function_18cb5fb798c607cd();
    wait 0.05;
  }

  if(shouldbench("2")) {
    bench_foreach();
    wait 0.05;
  }

  if(shouldbench("3")) {
    function_10f6d810677cee84();
    wait 0.05;
  }

  if(shouldbench("K")) {
    function_9628bf5282b8bafc();
    wait 0.05;
  }

  if(shouldbench("4")) {
    function_dff6885d265db0fd();
    wait 0.05;
  }

  if(shouldbench("5")) {
    function_2308f139d0ffbc41();
    wait 0.05;
  }

  if(shouldbench("6")) {
    function_76d6d0feedd3126b();
    wait 0.05;
  }

  if(shouldbench("7")) {
    function_589fd6b13ca60155();
    wait 0.05;
  }

  if(shouldbench("8")) {
    function_cae58617e7945254();
    wait 0.05;
  }

  if(shouldbench("9")) {
    bench_variables();
    wait 0.05;
  }

  if(shouldbench("A")) {
    bench_arrays();
    wait 0.05;
  }

  if(shouldbench("B")) {
    bench_fields();
    wait 0.05;
  }

  if(shouldbench("C")) {
    function_713ed9ae70c22b36();
    wait 0.05;
  }

  if(shouldbench("D")) {
    function_c0c13c7d2f02753b();
    wait 0.05;
  }

  if(shouldbench("E")) {
    function_56f6defb83c08190();
    wait 0.05;
  }

  if(shouldbench("F")) {
    bench_threads();
    wait 0.05;
  }

  if(shouldbench("G")) {
    function_1cb0315d0cdacba4();
    wait 0.05;
  }

  if(shouldbench("H")) {
    function_d5bce87878a08018();
    wait 0.05;
  }

  if(shouldbench("L")) {
    bench_strings();
    wait 0.05;
  }

  function_4912bd03f307546c();
}

function shouldbench(a) {
  if(issubstr(getDvar(@ "hash_86ef66e581c77f50", ""), a + ",")) {
    return true;
  }

  return false;
}

function main() {
  level thread function_41e013dcb5b7b2a();
  setdvarifuninitialized(@ "hash_939ffa702b7da068", 10000);
  setdvarifuninitialized(@ "hash_5217b32eb9c32512", 0);
  setdvarifuninitialized(@ "hash_44e9f4a106f9b4a1", 0);
  setdvarifuninitialized(@ "hash_86ef66e581c77f50", "0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,");

  while(true) {
    while(getdvarint(@ "hash_5217b32eb9c32512", 0) == 0) {
      wait 1;
    }

    benchmark();
    setDvar(@ "hash_5217b32eb9c32512", 0);
  }
}

function leak() {
  a = spawnStruct();
  b = spawnStruct();
  a.next = b;
  b.next = a;
}

function function_41e013dcb5b7b2a() {
  setdvarifuninitialized(@ "hash_8c14a9cfaca224d4", 0);

  while(true) {
    while(getdvarint(@ "hash_8c14a9cfaca224d4", 0) == 0) {
      wait 1;
    }

    leak();
    setDvar(@ "hash_8c14a9cfaca224d4", 0);
  }
}