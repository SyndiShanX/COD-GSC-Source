/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\ct_ruin.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\util_shared;
#include scripts\mp_common\gametypes\ct_core;
#include scripts\mp_common\gametypes\ct_ruin_tutorial;

#namespace ct_ruin;

event_handler[gametype_init] main(eventstruct) {
  ct_core::function_46e95cc7();
  ct_core::function_fa03fc55();
  clientfield::register("scriptmover", "follow_path_fx", 1, 1, "int", &follow_path_fx, 0, 0);
  ct_ruin_tutorial::init();
}

follow_path_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.fx = util::playFXOnTag(localclientnum, #"zombie/fx_trail_blood_soul_zmb", self, "tag_origin");
    return;
  }

  stopfx(localclientnum, self.fx);
}