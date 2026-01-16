/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\equip\zm_equip_nesting_doll_grenade.gsc
******************************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_equipment;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_weapons;

#namespace nesting_doll_grenade;

autoexec __init__system__() {
  system::register(#"nesting_doll_grenade", &__init__, undefined, undefined);
}

__init__() {
  level.var_a3e665cc = getweapon(#"hash_166200a2e04510f4");
  level.var_7f6e8568 = getweapon(#"hash_3fec64a2af587850");
  level.var_cf62bc7a = getweapon(#"hash_1b92c0a29a45b07c");
  level.var_e724fe4e = getweapon(#"hash_a2556a2905fd952");
  level.a_w_nesting_doll_grenades = array(getweapon(#"eq_nesting_doll_grenade"), getweapon(#"eq_nesting_doll_grenade_niko"), getweapon(#"eq_nesting_doll_grenade_rich"), getweapon(#"eq_nesting_doll_grenade_takeo"));
  level.var_e027f904 = array(level.var_a3e665cc, level.var_7f6e8568, level.var_cf62bc7a, level.var_e724fe4e);
  callback::on_grenade_fired(&on_grenade_fired);
  zm_loadout::register_lethal_grenade_for_level(#"eq_nesting_doll_grenade");
  zm_loadout::register_lethal_grenade_for_level(#"eq_nesting_doll_grenade_niko");
  zm_loadout::register_lethal_grenade_for_level(#"eq_nesting_doll_grenade_rich");
  zm_loadout::register_lethal_grenade_for_level(#"eq_nesting_doll_grenade_takeo");
  zm::function_84d343d(#"eq_nesting_doll_grenade", &function_23cf8077);
  zm::function_84d343d(#"hash_166200a2e04510f4", &function_23cf8077);
  zm::function_84d343d(#"hash_3fec64a2af587850", &function_23cf8077);
  zm::function_84d343d(#"hash_1b92c0a29a45b07c", &function_23cf8077);
  zm::function_84d343d(#"hash_a2556a2905fd952", &function_23cf8077);
  level thread function_ba2049f5();
}

function_ba2049f5() {
  level endon(#"end_game");
  level flag::wait_till("magicbox_initialized");
  w_doll = array::random(level.a_w_nesting_doll_grenades);
  zm_weapons::function_603af7a8(w_doll);
}

function_23cf8077(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(meansofdeath === "MOD_IMPACT") {
    return 0;
  }

  var_b1c1c5cf = zm_equipment::function_7d948481(0.1, 0.25, 1, 1);
  var_5d7b4163 = zm_equipment::function_379f6b5d(damage, var_b1c1c5cf, 1, 4, 40);
  return var_5d7b4163;
}

on_grenade_fired(s_params) {
  if(is_nesting_doll_grenade(s_params.weapon)) {
    s_params.projectile thread function_a1b7b263(self);
  }
}

function_a1b7b263(e_player) {
  self endon(#"death");
  e_player endon(#"death");
  var_51dacd00 = 0;
  var_4da5977e = (0, randomfloatrange(0, 360), 0);
  s_waitresult = self waittill(#"stationary");
  wait 1;

  while(var_51dacd00 < 6) {
    var_5543f2a9 = array::random(level.var_e027f904);
    e_player magicgrenadetype(var_5543f2a9, self getcentroid(), get_launch_velocity(var_4da5977e), 1);
    self playSound(#"hash_23ebdfd906eaff00");
    var_4da5977e += (0, randomfloatrange(60, 180), 0);
    var_51dacd00++;
    wait 0.4;
  }

  wait 1;
  self detonate(e_player);
}

get_launch_velocity(var_4da5977e) {
  v_angles = var_4da5977e + (randomfloatrange(-75, -55), 0, 0);
  v_launch = randomfloatrange(350, 400) * anglesToForward(v_angles);
  return v_launch;
}

is_nesting_doll_grenade(w_grenade) {
  return isinarray(level.a_w_nesting_doll_grenades, w_grenade);
}