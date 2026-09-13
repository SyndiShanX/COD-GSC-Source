/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\unittest\threads.gsc
***********************************************/

thread_wait() {
  scripts\unittest\util::test_print("thread_wait: 0");
  wait 0.1;
  scripts\unittest\util::test_print("thread_wait: 1");
  wait 0.1;
  scripts\unittest\util::test_print("thread_wait: 2");
}

f_resume(_id_AC0E594AC96AA3A8) {
  scripts\unittest\util::test_print("f_resume: 0: " + _id_AC0E594AC96AA3A8);
  wait 0.1;
  scripts\unittest\util::test_print("f_resume: 1: " + _id_AC0E594AC96AA3A8);
}

thread_resume() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++)
    thread f_resume(_id_AC0E594AC96AA3A8);

  wait 0.2;
}

f_notify(_id_AC0E594AC96AA3A8) {
  scripts\unittest\util::test_print("f_notify wait: " + _id_AC0E594AC96AA3A8);
  level waittill("f", x, y);
  scripts\unittest\util::test_print("f_notify: " + _id_AC0E594AC96AA3A8 + " " + x + " " + y);
}

thread_wait_notify() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++)
    thread f_notify(_id_AC0E594AC96AA3A8);

  level notify("f", 1, "a");
}

thread_terminate_child() {
  level notify("thread_terminate_endon");
  return 2;
}

thread_terminate_wrapper() {
  level endon("thread_terminate_endon");
  level thread thread_terminate_child();
  return 1;
}

thread_terminate_notify() {
  x = thread_terminate_wrapper();

  if(!isDefined(x))
    scripts\unittest\util::test_print("thread_terminate_notify: <undefined>");
  else
    scripts\unittest\util::test_print("thread_terminate_notify: " + x);
}

f_match(_id_DEE1E90C5A8243B7, _id_AC0E594AC96AA3A8) {
  scripts\unittest\util::test_print("f_match wait: " + _id_AC0E594AC96AA3A8);
  level waittillmatch(_id_DEE1E90C5A8243B7, "yes");
  scripts\unittest\util::test_print("f_match: " + _id_AC0E594AC96AA3A8);
}

waittillmatch_wait(index) {
  scripts\unittest\util::test_print("waittillmatch_wait: " + index);
  wait 1.0;
  scripts\unittest\util::test_print("waittillmatch_wait end: " + index);
}

waittillmatch_loop(index) {
  level endon("waittillmatch_end");

  for(;;) {
    level waittillmatch("wtm_loop", "loop");
    level thread waittillmatch_wait(index);
  }
}

thread_waittill_match() {
  _id_DEE1E90C5A8243B7 = "f";

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++)
    thread f_match(_id_DEE1E90C5A8243B7, _id_AC0E594AC96AA3A8);

  scripts\unittest\util::test_print("thread waittillmatch no");
  level notify(_id_DEE1E90C5A8243B7, "no");
  scripts\unittest\util::test_print("thread waittillmatch yes");
  level notify(_id_DEE1E90C5A8243B7, "yes");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++)
    level thread waittillmatch_loop(_id_AC0E594AC96AA3A8);

  waittillframeend;
  level notify("wtm_loop", "nope");
  level notify("wtm_loop", "loop");
  waittillframeend;
  level notify("wtm_loop", "loop");
  level notify("waittillmatch_end");
}

f_endon(_id_AC0E594AC96AA3A8) {
  level endon("f_endon");

  for(;;) {
    scripts\unittest\util::test_print("f_endon: " + _id_AC0E594AC96AA3A8);
    wait 10;
  }
}

stack_endon_recurse(_id_AC0E594AC96AA3A8) {
  if(_id_AC0E594AC96AA3A8 < 0) {
    scripts\unittest\util::test_print("stack_endon: notify before");
    level notify("stack_endon");
    scripts\unittest\util::test_print("stack_endon: notify after");
  }

  scripts\unittest\util::test_print("stack_endon: " + _id_AC0E594AC96AA3A8);
  stack_endon_recurse(_id_AC0E594AC96AA3A8 - 1);
  scripts\unittest\util::test_print("stack_endon_recurse: end");
}

stack_endon() {
  level endon("stack_endon");
  stack_endon_recurse(3);
}

thread_endon() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++)
    thread f_endon(_id_AC0E594AC96AA3A8);

  wait 0.1;
  level notify("f_endon");
  scripts\unittest\util::test_print("stack_endon: begin");
  stack_endon();
  scripts\unittest\util::test_print("stack_endon: end");
}

f_churn(_id_AC0E594AC96AA3A8) {
  scripts\unittest\util::test_print("f_churn wait: " + _id_AC0E594AC96AA3A8);
  level waittill("churn", x);
  scripts\unittest\util::test_print("f_churn notify: " + _id_AC0E594AC96AA3A8 + ": " + x);
}

thread_churn() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++)
    thread f_churn(_id_AC0E594AC96AA3A8);
}

thread_churn_notify() {
  level notify("churn", 4);
}

f_waitframe(_id_AC0E594AC96AA3A8) {
  scripts\unittest\util::test_print("f_waitframe wait: " + _id_AC0E594AC96AA3A8);
  waitframe();
  scripts\unittest\util::test_print("f_waitframe: " + _id_AC0E594AC96AA3A8);
}

thread_waitframe() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++)
    thread f_waitframe(_id_AC0E594AC96AA3A8);
}

f_waitframeend(_id_AC0E594AC96AA3A8) {
  scripts\unittest\util::test_print("f_waitframeend wait: " + _id_AC0E594AC96AA3A8);
  waittillframeend;
  scripts\unittest\util::test_print("f_waitframeend: " + _id_AC0E594AC96AA3A8);
}

thread_waitframeend() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++)
    thread f_waitframeend(_id_AC0E594AC96AA3A8);
}

f_running_func() {
  _id_AC0E594AC96AA3A8 = 0;

  for(;;) {
    scripts\unittest\util::test_print("f_running: " + _id_AC0E594AC96AA3A8);

    if(_id_AC0E594AC96AA3A8 == 3)
      level notify("f_running");

    _id_AC0E594AC96AA3A8++;
  }

  return _id_AC0E594AC96AA3A8;
}

f_running_func_call() {
  level endon("f_running");
  return f_running_func();
}

f_running_thread_call() {
  level endon("f_running");
  return childthread f_running_func();
}

f_running_nested_1() {
  scripts\unittest\util::test_print("f_nested_1: pre");
  f_running_nested_2();
  scripts\unittest\util::test_print("f_nested_1: post");
}

f_running_nested_2() {
  level endon("f_running");
  scripts\unittest\util::test_print("f_nested_2: pre");
  f_running_nested_3();
  scripts\unittest\util::test_print("f_nested_2: post");
}

f_running_nested_3() {
  scripts\unittest\util::test_print("f_nested_3: pre");
  f_running_nested_4();
  scripts\unittest\util::test_print("f_nested_3: post");
}

f_running_nested_4() {
  scripts\unittest\util::test_print("f_nested_4: pre");
  f_running_nested_5();
  level notify("f_running");
  scripts\unittest\util::test_print("f_nested_4: post");
}

f_running_nested_5() {
  scripts\unittest\util::test_print("f_nested_5");
}

f_running_nested_call() {
  scripts\unittest\util::test_print("f_nested: pre");
  thread f_running_nested_1();
  scripts\unittest\util::test_print("f_nested: post");
}

thread_running_notify() {
  _id_AC0E594AC96AA3A8 = thread f_running_func_call();
  scripts\unittest\util::test_print("thread_running_func_call: IsDefined: " + isDefined(_id_AC0E594AC96AA3A8));
  _id_AC0E594AC96AA3A8 = thread f_running_thread_call();
  scripts\unittest\util::test_print("thread_running_thread_call: IsDefined: " + isDefined(_id_AC0E594AC96AA3A8));
  _id_AC0E594AC96AA3A8 = thread f_running_nested_call();
  scripts\unittest\util::test_print("thread_running_nested_call: IsDefined: " + isDefined(_id_AC0E594AC96AA3A8));
}

main() {
  scripts\unittest\util::test_begin("Threads");
  thread_churn();
  thread_wait();
  wait 0.1;
  thread_resume();
  wait 0.1;
  thread_wait_notify();
  wait 0.1;
  thread_terminate_notify();
  wait 0.1;
  thread_waittill_match();
  wait 0.1;
  thread_endon();
  wait 0.1;
  thread_waitframe();
  wait 0.1;
  thread_waitframeend();
  wait 0.1;
  thread_running_notify();
  thread_churn_notify();
  waittillframeend;
  scripts\unittest\util::test_end("Threads");
}