/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_tundragun.csc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_weapons;

#namespace zm_weap_tundragun;

autoexec __init__system__() {
  system::register(#"zm_weap_tundragun", &__init__, &__main__, undefined);
}

__init__() {
  level.w_tundragun = getweapon(#"tundragun");
  level.w_tundragun_upgraded = getweapon(#"tundragun_upgraded");
}

__main__() {
  callback::on_weapon_change(&on_weapon_change);
}

on_weapon_change(s_params) {
  w_new_weapon = s_params.weapon;
  w_old_weapon = s_params.last_weapon;

  if(w_new_weapon == level.w_tundragun || w_new_weapon == level.w_tundragun_upgraded) {

    iprintlnbold("<dev string:x38>");

  }
}

function_4017174b(localclientnum, w_weapon) {
  self endon(#"disconnect");
  self endon(#"weapon_change");
  self endon(#"death");
  n_old_ammo = -1;
  n_shader_val = 0;

  while(true) {
    wait 0.1;

    if(!isDefined(self)) {
      return;
    }

    n_ammo = getweaponammoclip(localclientnum, w_weapon);

    if(n_old_ammo > 0 && n_old_ammo != n_ammo) {
      function_ac62a2fd(localclientnum);
    }

    n_old_ammo = n_ammo;

    if(n_ammo == 0) {
      self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 0, 0, 0);
      continue;
    }

    n_shader_val = 4 - n_ammo;
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, n_shader_val, 0);
  }
}

function_ac62a2fd(localclientnum) {
  playSound(localclientnum, #"wpn_thunder_breath", (0, 0, 0));
}