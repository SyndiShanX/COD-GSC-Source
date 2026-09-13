/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\unittest\patch_far.gsc
***********************************************/

patch_far() {
  scripts\unittest\util::test_print("patch_far");
}

patch_far_notify() {
  scripts\unittest\util::test_print("patch_far_notify");
  level notify("patch_far_notify");
}

patch_far_wait() {
  scripts\unittest\util::test_print("patch_far_wait");
}