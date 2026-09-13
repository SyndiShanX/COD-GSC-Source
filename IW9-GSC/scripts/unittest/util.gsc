/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\unittest\util.gsc
***********************************************/

test_print(msg) {
  msg = "SCR_TEST: " + msg;
  sysprint(msg);
}

test_begin(tag) {
  test_print(tag + "_begin");
}

test_end(tag) {
  test_print(tag + "_end");
}