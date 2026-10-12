/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\unittest\private.gsc
***********************************************/

#using scripts\unittest\util;
#namespace namespace_106f587ebebd0cab;

function private dev_internal() {
  test_print("<dev string:x1c>");
}

function private _internal() {
  test_print("call to scriptsunittestprivate::_internal");
}

function main() {
  test_begin("Private");
  _internal();

  dev_internal();

  test_end("Private");
}