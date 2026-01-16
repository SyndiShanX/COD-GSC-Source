/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_tesla_gun_t8.gsc
***********************************************/

#include scripts\core_common\ai_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\zm\zm_lightning_chain;
#include scripts\zm_common\zm;

#namespace zm_weap_tesla_gun_t8;

autoexec __init__system__() {
  system::register(#"tesla_gun", &__init__, undefined, undefined);
}

__init__() {
  level.w_tesla_gun_t8 = getweapon(#"ww_tesla_gun_t8");
  level.w_tesla_gun_t8_upgraded = getweapon(#"ww_tesla_gun_t8_upgraded");
  level.s_tesla_gun = spawnStruct();
  level.s_tesla_gun.base = spawnStruct();
  level.s_tesla_gun.upgraded = spawnStruct();
  level.s_tesla_gun.base.var_38cd3d0e = lightning_chain::create_lightning_chain_params();
  level.s_tesla_gun.upgraded.var_38cd3d0e = lightning_chain::create_lightning_chain_params();
  zm::function_84d343d(#"ww_tesla_gun_t8", &function_5ff12a45);
  zm::function_84d343d(#"ww_tesla_gun_t8_upgraded", &function_52d66433);
  callback::on_weapon_change(&on_weapon_change);
  clientfield::register("toplayer", "" + #"hash_611f27e5d51d036f", 28000, 1, "int");
}

function_5ff12a45(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  self function_de59b16a(attacker, meansofdeath, level.s_tesla_gun.base.var_38cd3d0e);
  return damage;
}

function_52d66433(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  self function_de59b16a(attacker, meansofdeath, level.s_tesla_gun.upgraded.var_38cd3d0e);
  return damage;
}

on_weapon_change(s_params) {
  if(is_tesla_gun(s_params.weapon)) {
    clientfield::set_to_player("" + #"hash_611f27e5d51d036f", 1);
    return;
  }

  if(is_tesla_gun(s_params.last_weapon)) {
    clientfield::set_to_player("" + #"hash_611f27e5d51d036f", 0);
  }
}

function_de59b16a(e_source, str_mod, var_8e05c280) {
  if(isplayer(e_source) && (str_mod == "MOD_PROJECTILE" || str_mod == "MOD_PROJECTILE_SPLASH") && !self ai::is_stunned()) {
    e_source.tesla_enemies_hit = 1;
    self lightning_chain::arc_damage(self, e_source, 1, var_8e05c280);
  }
}

is_tesla_gun(w_weapon) {
  return isDefined(w_weapon) && (w_weapon == level.w_tesla_gun_t8 || w_weapon == level.w_tesla_gun_t8_upgraded);
}