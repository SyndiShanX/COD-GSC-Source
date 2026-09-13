/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\unittest\call.gsc
***********************************************/

noargs() {
  scripts\unittest\util::test_print("noargs");
}

onearg(a) {
  if(!isDefined(a))
    a = "<undefined>";

  scripts\unittest\util::test_print("onearg: " + a);
}

multiarg(a, b, c) {
  scripts\unittest\util::test_print("multiarg: " + a + " " + b + " " + c);
}

recurse_internal(n) {
  if(n > 0) {
    scripts\unittest\util::test_print("recurse_internal: " + n);
    return recurse_internal(n - 1);
  } else
    return n;
}

recurse(n) {
  scripts\unittest\util::test_print("recurse: " + recurse_internal(n));
}

main() {
  scripts\unittest\util::test_begin("Call");
  noargs();
  onearg(1);
  onearg("hi");
  onearg();
  multiarg(1, 2, 3);
  multiarg(1, "hi", 2.0);
  scripts\unittest\util::test_print("Method");
  s = spawnStruct();
  s noargs();
  s onearg(1);
  s onearg("hi");
  s onearg();
  s multiarg(1, 2, 3);
  s multiarg(1, "hi", 2.0);
  scripts\unittest\util::test_print("Thread");
  thread noargs();
  thread onearg(1);
  thread onearg("hi");
  thread onearg();
  thread multiarg(1, 2, 3);
  thread multiarg(1, "hi", 2.0);
  scripts\unittest\util::test_print("Method Thread");
  s thread noargs();
  s thread onearg(1);
  s thread onearg("hi");
  s thread onearg();
  s thread multiarg(1, 2, 3);
  s thread multiarg(1, "hi", 2.0);
  scripts\unittest\util::test_print("Child Thread");
  childthread noargs();
  childthread onearg(1);
  childthread onearg("hi");
  childthread onearg();
  childthread multiarg(1, 2, 3);
  childthread multiarg(1, "hi", 2.0);
  scripts\unittest\util::test_print("Method Child Thread");
  s childthread noargs();
  s childthread onearg(1);
  s childthread onearg("hi");
  s childthread onearg();
  s childthread multiarg(1, 2, 3);
  s childthread multiarg(1, "hi", 2.0);
  scripts\unittest\util::test_print("Function Pointer");
  _id_BC867423FF8EB756 = ::noargs;
  _id_8B5A8F4BEB53DFA4 = ::onearg;
  _id_8564D715B7CD5CD3 = ::multiarg;
  [[_id_BC867423FF8EB756]]();
  [[_id_8B5A8F4BEB53DFA4]](1);
  [[_id_8B5A8F4BEB53DFA4]]("hi");
  [[_id_8B5A8F4BEB53DFA4]]();
  [[_id_8564D715B7CD5CD3]](1, 2, 3);
  [[_id_8564D715B7CD5CD3]](1, "hi", 2.0);
  scripts\unittest\util::test_print("Method Pointer");
  s[[_id_BC867423FF8EB756]]();
  s[[_id_8B5A8F4BEB53DFA4]](1);
  s[[_id_8B5A8F4BEB53DFA4]]("hi");
  s[[_id_8B5A8F4BEB53DFA4]]();
  s[[_id_8564D715B7CD5CD3]](1, 2, 3);
  s[[_id_8564D715B7CD5CD3]](1, "hi", 2.0);
  scripts\unittest\util::test_print("Thread Pointer");
  thread[[_id_BC867423FF8EB756]]();
  thread[[_id_8B5A8F4BEB53DFA4]](1);
  thread[[_id_8B5A8F4BEB53DFA4]]("hi");
  thread[[_id_8B5A8F4BEB53DFA4]]();
  thread[[_id_8564D715B7CD5CD3]](1, 2, 3);
  thread[[_id_8564D715B7CD5CD3]](1, "hi", 2.0);
  scripts\unittest\util::test_print("Method Thread Pointer");
  s thread[[_id_BC867423FF8EB756]]();
  s thread[[_id_8B5A8F4BEB53DFA4]](1);
  s thread[[_id_8B5A8F4BEB53DFA4]]("hi");
  s thread[[_id_8B5A8F4BEB53DFA4]]();
  s thread[[_id_8564D715B7CD5CD3]](1, 2, 3);
  s thread[[_id_8564D715B7CD5CD3]](1, "hi", 2.0);
  scripts\unittest\util::test_print("Child Thread Pointer");
  childthread[[_id_BC867423FF8EB756]]();
  childthread[[_id_8B5A8F4BEB53DFA4]](1);
  childthread[[_id_8B5A8F4BEB53DFA4]]("hi");
  childthread[[_id_8B5A8F4BEB53DFA4]]();
  childthread[[_id_8564D715B7CD5CD3]](1, 2, 3);
  childthread[[_id_8564D715B7CD5CD3]](1, "hi", 2.0);
  scripts\unittest\util::test_print("Method Child Thread Pointer");
  s childthread[[_id_BC867423FF8EB756]]();
  s childthread[[_id_8B5A8F4BEB53DFA4]](1);
  s childthread[[_id_8B5A8F4BEB53DFA4]]("hi");
  s childthread[[_id_8B5A8F4BEB53DFA4]]();
  s childthread[[_id_8564D715B7CD5CD3]](1, 2, 3);
  s childthread[[_id_8564D715B7CD5CD3]](1, "hi", 2.0);
  scripts\unittest\util::test_print("Misc Function Logic");
  recurse(10);
  scripts\unittest\util::test_end("Call");
}