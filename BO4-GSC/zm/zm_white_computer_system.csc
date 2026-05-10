/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_white_computer_system.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#namespace zm_white_computer_system;

preload() {
  init_clientfields();
}

init_clientfields() {
  clientfield::register("toplayer", "" + #"key_press_feedback", 20000, 1, "counter", &key_press_feedback, 0, 0);
}

key_press_feedback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self playrumbleonentity(localclientnum, #"hash_38a12b73c9342fd9");
  }
}