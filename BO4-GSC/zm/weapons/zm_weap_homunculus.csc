/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_homunculus.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_weap_homunculus;

autoexec __init__system__() {
  system::register(#"zm_weap_homunculus", &__init__, &__main__, undefined);
}

__init__() {
  clientfield::register("scriptmover", "" + #"hash_2d49d2cf3d339e18", 1, 1, "int", &function_6fcc4908, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_32c5838be960cfee", 1, 1, "int", &function_3e362ad8, 0, 0);
}

__main__() {
  if(!zm_weapons::is_weapon_included(getweapon(#"homunculus"))) {
    return;
  }
}

function_6fcc4908(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval && isDefined(self)) {
    v_up = (360, 0, 0);
    v_forward = (0, 0, 360);
    origin = self gettagorigin("j_spinelower");

    if(!isDefined(origin)) {
      origin = self.origin;
    }

    playFX(localclientnum, "zm_weapons/fx8_equip_homunc_death_exp", origin, v_forward, v_up);
  }
}

function_3e362ad8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    v_up = (360, 0, 0);
    v_forward = (0, 0, 360);
    playFX(localclientnum, "zm_weapons/fx8_equip_homunc_spawn", self.origin, v_forward, v_up);
    self playSound(localclientnum, #"hash_21206f1b7fb27f81");
  }
}