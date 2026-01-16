/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_ray_gun_mk2y.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\system_shared;

#namespace zm_weap_ray_gun_mk2y;

autoexec __init__system__() {
  system::register(#"ray_gun_mk2y", &__init__, undefined, undefined);
}

__init__() {
  level.var_585eeded = spawnStruct();
  level.var_585eeded.var_ba76fe32[#"ray_gun_mk2y"] = getweapon("ray_gun_mk2y");
  level.var_585eeded.var_ba76fe32[#"ray_gun_mk2y_charged"] = getweapon("ray_gun_mk2y_charged");
  level.var_585eeded.var_ba76fe32[#"ray_gun_mk2y_upgraded"] = getweapon("ray_gun_mk2y_upgraded");
  level.var_585eeded.var_ba76fe32[#"ray_gun_mk2y_upgraded_charged"] = getweapon("ray_gun_mk2y_upgraded_charged");
  callback::on_weapon_change(&on_weapon_change);
  callback::add_weapon_fired(level.var_585eeded.var_ba76fe32[#"ray_gun_mk2y_charged"], &function_8a977b42);
  callback::add_weapon_fired(level.var_585eeded.var_ba76fe32[#"ray_gun_mk2y_upgraded_charged"], &function_8a977b42);
  clientfield::register("allplayers", "" + #"ray_gun_mk2y_charged", 20000, 1, "int");
}

on_weapon_change(s_params) {
  if(function_5b0214e(s_params.weapon)) {
    self thread function_54922a21();
    return;
  }

  if(function_5b0214e(s_params.last_weapon)) {
    self notify(#"hash_414b2baf34e01af8");
  }
}

function_54922a21() {
  self endoncallback(&function_a059fe7f, #"death", #"hash_414b2baf34e01af8");
  w_current = self getcurrentweapon();

  while(true) {
    b_charged = 0;

    while(self attackbuttonpressed() && !self meleebuttonpressed() && !self laststand::player_is_in_laststand()) {
      if(!b_charged && isDefined(self.chargeshotlevel) && self.chargeshotlevel > 1) {
        self function_bfbef8cc(self getcurrentweapon());
        self clientfield::set("" + #"ray_gun_mk2y_charged", 1);
        b_charged = 1;
      }

      waitframe(1);
    }

    if(b_charged) {
      self function_a059fe7f();
      wait 1;
      continue;
    }

    waitframe(1);
  }
}

function_a059fe7f(str_notify) {
  self clientfield::set("" + #"ray_gun_mk2y_charged", 0);
}

function_5b0214e(weapon) {
  return isDefined(weapon) && isinarray(level.var_585eeded.var_ba76fe32, weapon);
}

function_60365a28(weapon) {
  if(weapon == level.var_585eeded.var_ba76fe32[#"ray_gun_mk2y"] || weapon == level.var_585eeded.var_ba76fe32[#"ray_gun_mk2y_charged"]) {
    return level.var_585eeded.var_ba76fe32[#"ray_gun_mk2y"];
  }

  return level.var_585eeded.var_ba76fe32[#"ray_gun_mk2y_upgraded"];
}

function_8a977b42(weapon) {
  self setweaponammoclip(function_60365a28(weapon), 0);
}

function_bfbef8cc(weapon) {
  w_uncharged = function_60365a28(weapon);
  n_clip_ammo = self getweaponammoclip(w_uncharged);

  if(n_clip_ammo < w_uncharged.clipsize) {
    n_ammo_diff = w_uncharged.clipsize - n_clip_ammo;
    n_stock_ammo = self getweaponammostock(w_uncharged);
    self setweaponammostock(w_uncharged, n_stock_ammo - n_ammo_diff);
    self setweaponammoclip(w_uncharged, w_uncharged.clipsize);
  }
}