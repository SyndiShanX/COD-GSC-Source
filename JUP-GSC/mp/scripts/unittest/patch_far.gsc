/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\unittest\patch_far.gsc
***********************************************/

#using scripts\unittest\util;
#namespace patch_far;

function patch_far() {
  test_print("patch_far");
}

function patch_far_notify() {
  test_print("patch_far_notify");
  level notify("patch_far_notify");
}

function patch_far_wait() {
  test_print("patch_far_wait");
}