/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_ee_misc.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;

#namespace zm_orange_ee_misc;

preload() {
  init_clientfields();
  level thread pareidolia_ee();
}

function

init_clientfields() {
  clientfield::register("toplayer", "" + #"hash_12114abc7407913b", 24000, 1, "counter", &function_30ed45c9, 0, 0);
  clientfield::register("toplayer", "" + #"hash_5e38e846ce88405b", 24000, 1, "counter", &function_48a634b7, 0, 0);
}

function_30ed45c9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self thread postfx::playpostfxbundle(#"hash_34d554b44dfcb81d");
    playSound(localclientnum, #"hash_750bc40787e0e29f", (0, 0, 0));
  }
}

function_48a634b7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self thread postfx::playpostfxbundle(#"hash_34d551b44dfcb304");
    playSound(localclientnum, #"hash_750bc50787e0e452", (0, 0, 0));
  }
}

pareidolia_ee() {
  t_pareidolia = getent(0, "t_pareidolia", "targetname");
  waitresult = t_pareidolia waittill(#"trigger");
  playSound(0, #"mus_pareidolia", (-7053, -24906, 222));
}