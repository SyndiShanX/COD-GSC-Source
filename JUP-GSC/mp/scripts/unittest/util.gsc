/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\unittest\util.gsc
***********************************************/

#namespace util;

function test_print(msg) {
  msg = "SCR_TEST: " + msg;
  sysprint(msg);
}

function test_begin(tag) {
  test_print(tag + "_begin");
}

function test_end(tag) {
  test_print(tag + "_end");
}