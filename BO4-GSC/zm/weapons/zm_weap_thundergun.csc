/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_thundergun.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm_utility;

#namespace zm_weap_thundergun;

autoexec __init__system__() {
  system::register(#"zm_weap_thundergun", &__init__, &__main__, undefined);
}

__init__() {
  level.w_thundergun = getweapon(#"thundergun");
  level.w_thundergun_upgraded = getweapon(#"thundergun_upgraded");
  clientfield::register("actor", "" + #"hash_7549405bcfcbcfb", 24000, 1, "counter", &function_5059c81b, 0, 0);
}

__main__() {
  callback::on_weapon_change(&on_weapon_change);
}

on_weapon_change(s_params) {
  w_new_weapon = s_params.weapon;
  w_old_weapon = s_params.last_weapon;

  if(w_new_weapon == level.w_thundergun || w_new_weapon == level.w_thundergun_upgraded) {

    iprintlnbold("<dev string:x38>");

  }
}

thundergun_fx_fire(localclientnum) {
  playSound(localclientnum, #"wpn_thunder_breath", (0, 0, 0));
}

private function_5059c81b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self)) {
    v_fx_origin = self gettagorigin(self zm_utility::function_467efa7b(1));

    if(!isDefined(v_fx_origin)) {
      v_fx_origin = self.origin;
    }

    playFX(localclientnum, "zm_weapons/fx8_ww_thundergun_impact_zombie", v_fx_origin);
  }
}