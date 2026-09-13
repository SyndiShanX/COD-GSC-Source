/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\unittest\patch.gsc
***********************************************/

add() {
  scripts\unittest\util::test_print("add");
}

patch_self_check() {}

meth_patch() {
  self.value = 1;
}

meth() {
  s = spawnStruct();
  s meth_patch();
  scripts\unittest\util::test_print("meth: " + s.value);
  patch_self_check();
}

func_patch() {
  return 0;
}

func() {
  x = func_patch();
  scripts\unittest\util::test_print("func: " + x);
}

vars_print(s) {
  scripts\unittest\util::test_print("s.active: " + s.active);
  scripts\unittest\util::test_print("s.notcanon: " + s.notcanon);
}

vars_update(s) {
  scripts\unittest\util::test_print("vars_update");
  vars_print(s);
  scripts\unittest\util::test_print("vars_update: end");
}

vars() {
  s = spawnStruct();
  s.active = 1;
  s.notcanon = "hi";
  scripts\unittest\util::test_print("vars");
  vars_print(s);
  vars_update(s);
  vars_print(s);
  scripts\unittest\util::test_print("vars: end");
}

func_thread() {
  scripts\unittest\util::test_print("func_thread");
}

thread_wait_patch(_id_819B28728AB38C03) {
  x = 0;
  scripts\unittest\util::test_print("thread_wait_patch:(" + x + "): " + _id_819B28728AB38C03);

  if(_id_819B28728AB38C03 == 0)
    level waittill("thread_wait");
  else if(_id_819B28728AB38C03 > 0)
    thread_wait_native(_id_819B28728AB38C03 - 1);
  else
    thread thread_wait_native(_id_819B28728AB38C03 + 1);

  scripts\unittest\util::test_print("thread_wait_patch end: " + _id_819B28728AB38C03);
}

thread_wait_native(_id_819B28728AB38C03) {
  scripts\unittest\util::test_print("thread_wait_native: " + _id_819B28728AB38C03);
  thread_wait_patch(_id_819B28728AB38C03);
  scripts\unittest\util::test_print("thread_wait_native end: " + _id_819B28728AB38C03);
}

thread_wait_local() {
  x = 0;
  scripts\unittest\util::test_print("thread_wait_local");
  thread_wait(1);
  scripts\unittest\util::test_print("thread_wait_local end");
}

thread_wait(_id_EC256753C321F81E) {
  scripts\unittest\util::test_print("thread_wait");
  thread thread_wait_native(0);
  level notify("thread_wait");
  waittillframeend;
  thread thread_wait_native(1);
  level notify("thread_wait");
  waittillframeend;
  thread thread_wait_native(-1);
  level notify("thread_wait");
  waittillframeend;

  if(!istrue(_id_EC256753C321F81E)) {
    thread_wait_local();
    waittillframeend;
  }

  scripts\unittest\util::test_print("thread_wait end");
}

native_wait() {
  scripts\unittest\util::test_print("native_wait");
  waittillframeend;
}

patch_wait_frameend() {
  waittillframeend;
}

patch_wait() {
  scripts\unittest\util::test_print("patch_wait: start");
  patch_wait_frameend();
  waittillframeend;
  scripts\unittest\util::test_print("patch_wait: end");
}

define() {
  scripts\unittest\util::test_print("define: int: 1 float: 2.2");
}

f1() {
  scripts\unittest\util::test_print("fp1");
}

f2(_id_CDDE4578F5299BDD) {
  [[_id_CDDE4578F5299BDD]]("fp2");
}

func_pointer() {
  _id_ED819B03E8C18C0A = ::f1;
  [[_id_ED819B03E8C18C0A]]();
  _id_ED819A03E8C189D7 = scripts\unittest\util::test_print;
  f2(_id_ED819A03E8C189D7);
}

far() {
  scripts\unittest\patch_far::patch_far();
}

e5(t, n) {
  scripts\unittest\util::test_print("e5 start: " + t);
  f = 6;
  scripts\unittest\util::test_print("e5 end: " + t);
}

e4(t, n) {
  scripts\unittest\util::test_print("e4 start: " + t);
  e = 5;
  e5(t, n);
  scripts\unittest\util::test_print("e4 end: " + t);
}

e3(t, n) {
  scripts\unittest\util::test_print("e3 start: " + t);
  _id_AC0E564AC96A9D0F = 4;
  e4(t, n);
  scripts\unittest\util::test_print("e3 end: " + t);
}

e2(t, n) {
  scripts\unittest\util::test_print("e2 start: " + t);
  c = 3;
  e3(t, n);
  scripts\unittest\util::test_print("e2 end: " + t);
}

e1(t, n) {
  scripts\unittest\util::test_print("e1 start: " + t);
  b = 2;
  e2(t, n);
  scripts\unittest\util::test_print("e1 end: " + t);
}

endontest_endon(t, n) {
  test = "endontest_" + t;
  scripts\unittest\util::test_print(test + "_start: " + n);
  level endon(test);
  e1(t, n);
  scripts\unittest\util::test_print(test + "_end: " + n);
}

endontest() {}

#using_animtree("multiplayer");

anim_test() {
  foo = % mp_stand_reload;
  bar = % mp_crouch_reload;
}

stack_patch_waittill_leaf() {
  scripts\unittest\util::test_print("stack_patch_waittill_leaf");
}

stack_patch_waittill_node() {
  scripts\unittest\util::test_print("stack_patch_waittill_node");
  stack_patch_waittill_leaf();
}

stack_patch_waittill_stack() {
  scripts\unittest\util::test_print("stack_patch_waittill_stack");
  stack_patch_waittill_leaf();
}

stack_patch_waittill_root() {
  scripts\unittest\util::test_print("stack_patch_waittill_root");
  stack_patch_waittill_node();
  stack_patch_waittill_stack();
}

stack_patch_waittill_context_patch() {
  scripts\unittest\util::test_print("stack_patch_waittill_context_patch");
  scripts\unittest\util::test_print("stack_patch_waittill_context_patch: end");
}

stack_patch_waittill_context(s) {
  scripts\unittest\util::test_print("stack_patch_waittill_context: start: " + s.value);
  s.value++;
  stack_patch_waittill_context_patch();
  waittillframeend;
  scripts\unittest\util::test_print("stack_patch_waitill_context: end: " + s.value);
}

stack_patch_waittill_context_far_patch() {
  scripts\unittest\util::test_print("stack_patch_waittill_context_far_patch");
  scripts\unittest\util::test_print("stack_patch_waittill_context_far_patch: end");
}

stack_patch_waittill_context_far(s) {
  scripts\unittest\util::test_print("stack_patch_waittill_context_far: start: " + s.value);
  s.value++;
  stack_patch_waittill_context_far_patch();
  waittillframeend;
  scripts\unittest\util::test_print("stack_patch_waitill_context_far: end: " + s.value);
}

stack_patch_thread() {
  scripts\unittest\util::test_print("stack_patch_thread");
  level waittill("stack_patch");
  scripts\unittest\util::test_print("stack_patch_thread: end");
}

stack_patch_thread_leaf() {
  scripts\unittest\util::test_print("stack_patch_thread_leaf");
  stack_patch_thread();
  scripts\unittest\util::test_print("stack_patch_thread_leaf: end");
}

stack_patch_thread_node() {
  scripts\unittest\util::test_print("stack_patch_thread_node");
  scripts\unittest\util::test_print("stack_patch_thread_node: end");
}

stack_patch_thread_root() {
  scripts\unittest\util::test_print("stack_patch_thread_root");
  stack_patch_thread_node();
  scripts\unittest\util::test_print("stack_patch_thread_root: end");
}

stack_patch() {
  scripts\unittest\util::test_print("stack_patch");
  thread stack_patch_waittill_root();
  s = spawnStruct();
  s.value = 0;
  thread stack_patch_waittill_context(s);
  thread stack_patch_waittill_context_far(s);
  stack_patch_thread_root();
  scripts\unittest\util::test_print("stack_patch: notify");
  level notify("stack_patch");
  waittillframeend;
}

_id_A65AA16B3C5889A5() {
  x = getdvarint("builtin_patch", 1);
  scripts\unittest\util::test_print("builtin_patch: " + x);
}

sre() {}

main() {
  scripts\unittest\util::test_begin("Patch");
  s = spawnStruct();
  func();
  s meth();
  add();
  vars();
  thread func_thread();
  thread_wait();
  patch_wait();
  define();
  func_pointer();
  far();
  endontest();
  anim_test();
  stack_patch();
  _id_A65AA16B3C5889A5();
  sre();
  scripts\unittest\util::test_end("Patch");
}