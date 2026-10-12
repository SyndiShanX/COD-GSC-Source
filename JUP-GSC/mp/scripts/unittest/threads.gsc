/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\unittest\threads.gsc
***********************************************/

#using scripts\unittest\util;
#namespace unittest_threads;

function thread_wait() {
  test_print("thread_wait: 0");
  wait 0.1;
  test_print("thread_wait: 1");
  wait 0.1;
  test_print("thread_wait: 2");
}

function f_resume(i) {
  test_print("f_resume: 0: " + i);
  wait 0.1;
  test_print("f_resume: 1: " + i);
}

function thread_resume() {
  for(i = 0; i < 10; i++) {
    thread f_resume(i);
  }

  wait 0.2;
}

function f_notify(i) {
  test_print("f_notify wait: " + i);
  level waittill("f", x, y);
  test_print("f_notify: " + i + " " + x + " " + y);
}

function thread_wait_notify() {
  for(i = 0; i < 10; i++) {
    thread f_notify(i);
  }

  level notify("f", 1, "a");
}

function thread_terminate_child() {
  level notify("thread_terminate_endon");
  return 2;
}

function thread_terminate_wrapper() {
  level endon("thread_terminate_endon");
  level thread thread_terminate_child();
  return true;
}

function thread_terminate_notify() {
  x = thread_terminate_wrapper();

  if(!isDefined(x)) {
    test_print("thread_terminate_notify: <undefined>");
    return;
  }

  test_print("thread_terminate_notify: " + x);
}

function f_match(notifystr, i) {
  test_print("f_match wait: " + i);
  level waittillmatch(notifystr, "yes");
  test_print("f_match: " + i);
}

function waittillmatch_wait(index) {
  test_print("waittillmatch_wait: " + index);
  wait 1;
  test_print("waittillmatch_wait end: " + index);
}

function waittillmatch_loop(index) {
  level endon("waittillmatch_end");

  while(true) {
    level waittillmatch("wtm_loop", "loop");
    level thread waittillmatch_wait(index);
  }
}

function thread_waittill_match() {
  notifystr = "f";

  for(i = 0; i < 10; i++) {
    thread f_match(notifystr, i);
  }

  test_print("thread waittillmatch no");
  level notify(notifystr, "no");
  test_print("thread waittillmatch yes");
  level notify(notifystr, "yes");

  for(i = 0; i < 4; i++) {
    level thread waittillmatch_loop(i);
  }

  waittillframeend();
  level notify("wtm_loop", "nope");
  level notify("wtm_loop", "loop");
  waittillframeend();
  level notify("wtm_loop", "loop");
  level notify("waittillmatch_end");
}

function f_endon(i) {
  level endon("f_endon");

  for(;;) {
    test_print("f_endon: " + i);
    wait 10;
  }
}

function stack_endon_recurse(i) {
  if(i < 0) {
    test_print("stack_endon: notify before");
    level notify("stack_endon");
    test_print("stack_endon: notify after");
  }

  test_print("stack_endon: " + i);
  stack_endon_recurse(i - 1);
  test_print("stack_endon_recurse: end");
}

function stack_endon() {
  level endon("stack_endon");
  stack_endon_recurse(3);
}

function thread_endon() {
  for(i = 0; i < 10; i++) {
    thread f_endon(i);
  }

  wait 0.1;
  level notify("f_endon");
  test_print("stack_endon: begin");
  stack_endon();
  test_print("stack_endon: end");
}

function f_churn(i) {
  test_print("f_churn wait: " + i);
  level waittill("churn", x);
  test_print("f_churn notify: " + i + ": " + x);
}

function thread_churn() {
  for(i = 0; i < 10; i++) {
    thread f_churn(i);
  }
}

function thread_churn_notify() {
  level notify("churn", 4);
}

function f_waitframe(i) {
  test_print("f_waitframe wait: " + i);
  waitframe();
  test_print("f_waitframe: " + i);
}

function thread_waitframe() {
  for(i = 0; i < 10; i++) {
    thread f_waitframe(i);
  }
}

function f_waitframeend(i) {
  test_print("f_waitframeend wait: " + i);
  waittillframeend();
  test_print("f_waitframeend: " + i);
}

function thread_waitframeend() {
  for(i = 0; i < 10; i++) {
    thread f_waitframeend(i);
  }
}

function f_running_func() {
  for(i = 0; true; i++) {
    test_print("f_running: " + i);

    if(i == 3) {
      level notify("f_running");
    }
  }

  return i;
}

function f_running_func_call() {
  level endon("f_running");
  return f_running_func();
}

function f_running_thread_call() {
  level endon("f_running");
  return childthread f_running_func();
}

function f_running_nested_1() {
  test_print("f_nested_1: pre");
  f_running_nested_2();
  test_print("f_nested_1: post");
}

function f_running_nested_2() {
  level endon("f_running");
  test_print("f_nested_2: pre");
  f_running_nested_3();
  test_print("f_nested_2: post");
}

function f_running_nested_3() {
  test_print("f_nested_3: pre");
  f_running_nested_4();
  test_print("f_nested_3: post");
}

function f_running_nested_4() {
  test_print("f_nested_4: pre");
  f_running_nested_5();
  level notify("f_running");
  test_print("f_nested_4: post");
}

function f_running_nested_5() {
  test_print("f_nested_5");
}

function f_running_nested_call() {
  test_print("f_nested: pre");
  thread f_running_nested_1();
  test_print("f_nested: post");
}

function thread_running_notify() {
  i = thread f_running_func_call();
  test_print("thread_running_func_call: IsDefined: " + isDefined(i));
  i = thread f_running_thread_call();
  test_print("thread_running_thread_call: IsDefined: " + isDefined(i));
  i = thread f_running_nested_call();
  test_print("thread_running_nested_call: IsDefined: " + isDefined(i));
}

function main() {
  test_begin("Threads");
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
  waittillframeend();
  test_end("Threads");
}