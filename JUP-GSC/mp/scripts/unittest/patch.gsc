/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\unittest\patch.gsc
***********************************************/

#using scripts\unittest\patch_far;
#using scripts\unittest\util;
#namespace unittest_patch;

function add() {
  test_print("add");
}

function patch_self_check() {}

function meth_patch() {
  self.value = 1;
}

function meth() {
  s = spawnStruct();
  s meth_patch();
  test_print("meth: " + s.value);
  patch_self_check();
}

function func_patch() {
  return false;
}

function func() {
  x = func_patch();
  test_print("func: " + x);
}

function vars_print(s) {
  test_print("s.active: " + s.active);
  test_print("s.notcanon: " + s.notcanon);
}

function vars_update(s) {
  test_print("vars_update");
  vars_print(s);
  test_print("vars_update: end");
}

function vars() {
  s = spawnStruct();
  s.active = 1;
  s.notcanon = "hi";
  test_print("vars");
  vars_print(s);
  vars_update(s);
  vars_print(s);
  test_print("vars: end");
}

function func_thread() {
  test_print("func_thread");
}

function thread_wait_patch(deep) {
  x = 0;
  test_print("thread_wait_patch:(" + x + "): " + deep);

  if(deep == 0) {
    level waittill("thread_wait");
  } else if(deep > 0) {
    thread_wait_native(deep - 1);
  } else {
    thread thread_wait_native(deep + 1);
  }

  test_print("thread_wait_patch end: " + deep);
}

function thread_wait_native(deep) {
  test_print("thread_wait_native: " + deep);
  thread_wait_patch(deep);
  test_print("thread_wait_native end: " + deep);
}

function thread_wait_local() {
  x = 0;
  test_print("thread_wait_local");
  thread_wait(1);
  test_print("thread_wait_local end");
}

function thread_wait(ignorelocal) {
  test_print("thread_wait");
  thread thread_wait_native(0);
  level notify("thread_wait");
  waittillframeend();
  thread thread_wait_native(1);
  level notify("thread_wait");
  waittillframeend();
  thread thread_wait_native(-1);
  level notify("thread_wait");
  waittillframeend();

  if(!istrue(ignorelocal)) {
    thread_wait_local();
    waittillframeend();
  }

  test_print("thread_wait end");
}

function native_wait() {
  test_print("native_wait");
  waittillframeend();
}

function patch_wait_frameend() {
  waittillframeend();
}

function patch_wait() {
  test_print("patch_wait: start");
  patch_wait_frameend();
  waittillframeend();
  test_print("patch_wait: end");
}

function define() {
  test_print("define: int: " + 1 + " float: " + 2.2);
}

function f1() {
  test_print("fp1");
}

function f2(tp) {
  [[tp]]("fp2");
}

function func_pointer() {
  fp1 = &f1;
  [[fp1]]();
  fp2 = &test_print;
  f2(fp2);
}

function far() {
  scripts\unittest\patch_far::patch_far();
}

function e5(t, n) {
  test_print("e5 start: " + t);
  f = 6;
  test_print("e5 end: " + t);
}

function e4(t, n) {
  test_print("e4 start: " + t);
  e = 5;
  e5(t, n);
  test_print("e4 end: " + t);
}

function e3(t, n) {
  test_print("e3 start: " + t);
  d = 4;
  e4(t, n);
  test_print("e3 end: " + t);
}

function e2(t, n) {
  test_print("e2 start: " + t);
  c = 3;
  e3(t, n);
  test_print("e2 end: " + t);
}

function e1(t, n) {
  test_print("e1 start: " + t);
  b = 2;
  e2(t, n);
  test_print("e1 end: " + t);
}

function endontest_endon(t, n) {
  test = "endontest_" + t;
  test_print(test + "_start: " + n);
  level endon(test);
  e1(t, n);
  test_print(test + "_end: " + n);
}

function endontest() {}

#using_animtree("multiplayer");

function anim_test() {
  foo = % mp_stand_reload;
  bar = % mp_crouch_reload;
}

function stack_patch_waittill_leaf() {
  test_print("stack_patch_waittill_leaf");
}

function stack_patch_waittill_node() {
  test_print("stack_patch_waittill_node");
  stack_patch_waittill_leaf();
}

function stack_patch_waittill_stack() {
  test_print("stack_patch_waittill_stack");
  stack_patch_waittill_leaf();
}

function stack_patch_waittill_root() {
  test_print("stack_patch_waittill_root");
  stack_patch_waittill_node();
  stack_patch_waittill_stack();
}

function stack_patch_waittill_context_patch() {
  test_print("stack_patch_waittill_context_patch");
  test_print("stack_patch_waittill_context_patch: end");
}

function stack_patch_waittill_context(s) {
  test_print("stack_patch_waittill_context: start: " + s.value);
  s.value++;
  stack_patch_waittill_context_patch();
  waittillframeend();
  test_print("stack_patch_waitill_context: end: " + s.value);
}

function stack_patch_waittill_context_far_patch() {
  test_print("stack_patch_waittill_context_far_patch");
  test_print("stack_patch_waittill_context_far_patch: end");
}

function stack_patch_waittill_context_far(s) {
  test_print("stack_patch_waittill_context_far: start: " + s.value);
  s.value++;
  stack_patch_waittill_context_far_patch();
  waittillframeend();
  test_print("stack_patch_waitill_context_far: end: " + s.value);
}

function stack_patch_thread() {
  test_print("stack_patch_thread");
  level waittill("stack_patch");
  test_print("stack_patch_thread: end");
}

function stack_patch_thread_leaf() {
  test_print("stack_patch_thread_leaf");
  stack_patch_thread();
  test_print("stack_patch_thread_leaf: end");
}

function stack_patch_thread_node() {
  test_print("stack_patch_thread_node");
  test_print("stack_patch_thread_node: end");
}

function stack_patch_thread_root() {
  test_print("stack_patch_thread_root");
  stack_patch_thread_node();
  test_print("stack_patch_thread_root: end");
}

function stack_patch() {
  test_print("stack_patch");
  thread stack_patch_waittill_root();
  s = spawnStruct();
  s.value = 0;
  thread stack_patch_waittill_context(s);
  thread stack_patch_waittill_context_far(s);
  stack_patch_thread_root();
  test_print("stack_patch: notify");
  level notify("stack_patch");
  waittillframeend();
}

function builtin_patch() {
  x = getdvarint(@ "builtin_patch", 1);
  test_print("builtin_patch: " + x);
}

function sre() {}

function main() {
  test_begin("Patch");
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
  builtin_patch();
  sre();
  test_end("Patch");
}