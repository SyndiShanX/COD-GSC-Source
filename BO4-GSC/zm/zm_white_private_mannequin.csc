/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_white_private_mannequin.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;

#namespace zm_white_private_mannequin;

autoexec __init__system__() {
  system::register(#"zm_white_private_mannequin", &__init__, &__main__, undefined);
}

__init__() {
  clientfield::register("world", "" + #"hash_681de2aa531ffcd0", 20000, 1, "int", &function_a1ee0828, 0, 0);
}

__main__() {}

function_a1ee0828(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    forcestreamxmodel("c_t8_zmb_dlc3_mannequin_male_damage_ally_ready_pose");
    return;
  }

  stopforcestreamingxmodel("c_t8_zmb_dlc3_mannequin_male_damage_ally_ready_pose");
}