/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_snowball.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\system_shared;

#namespace zm_weap_snowball;

autoexec __init__system__() {
  system::register(#"snowball", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("toplayer", "" + #"hash_78aa1dc141a3e27", 24000, 1, "int", &function_25101093, 0, 0);
  clientfield::register("toplayer", "" + #"hash_2fafddfa9f85b8aa", 24000, 1, "int", &function_43d8c5f8, 0, 0);
}

function_25101093(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    self postfx::stoppostfxbundle("pstfx_wz_snowball_hit");
    self postfx::playpostfxbundle("pstfx_wz_snowball_hit");
    return;
  }

  self postfx::exitpostfxbundle("pstfx_wz_snowball_hit");
}

function_43d8c5f8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval == 1) {
    self postfx::stoppostfxbundle("pstfx_wz_snowball_hit_yellow");
    self postfx::playpostfxbundle("pstfx_wz_snowball_hit_yellow");
    return;
  }

  self postfx::exitpostfxbundle("pstfx_wz_snowball_hit_yellow");
}