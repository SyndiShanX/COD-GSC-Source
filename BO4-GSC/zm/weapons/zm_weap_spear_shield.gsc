/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_spear_shield.gsc
***********************************************/

#include script_24c32478acf44108;
#include scripts\core_common\ai\systems\gib;
#include scripts\core_common\ai\zombie_death;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\player\player_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\throttle_shared;
#include scripts\core_common\util_shared;
#include scripts\zm\weapons\zm_weap_riotshield;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_crafting;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_devgui;
#include scripts\zm_common\zm_equipment;
#include scripts\zm_common\zm_hero_weapon;
#include scripts\zm_common\zm_laststand;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_weapons;

#namespace zm_weap_spear_shield;

autoexec __init__system__() {
  system::register(#"zm_weap_spear_shield", &__init__, &__main__, undefined);
}

__init__() {
  level.var_96059a93 = getweapon(#"zhield_zpear_dw");
  level.var_85ed93f4 = getweapon(#"zhield_zpear_lh");
  level.var_ce3aa8a8 = getweapon(#"zhield_zpear_turret");
}

__main__() {
  level.riotshield_melee = &function_4b03aab;
}

function_64ff58da(color, var_6ab2cf36) {}

  function function_4b03aab(weapon) {
    if(weapon == level.var_ce3aa8a8) {
      riotshield::riotshield_melee(weapon);
      return;
    }

    function_dcdaf81c(weapon, 128, 128, 96, 360, 240);
  }

function_dcdaf81c(weapon, riotshield_knockdown_range, riotshield_gib_range, riotshield_fling_range, var_1c3d89, riotshield_cylinder_radius, riotshield_fling_force_melee) {
  level.riotshield_knockdown_enemies = [];
  level.riotshield_knockdown_gib = [];
  level.riotshield_fling_enemies = [];
  level.riotshield_fling_vecs = [];
  level.var_21ffc192 = [];
  self riotshield::riotshield_get_enemies_in_range(riotshield_knockdown_range, riotshield_gib_range, riotshield_fling_range, var_1c3d89, riotshield_cylinder_radius, riotshield_fling_force_melee);
  shield_damage = 0;

  for(i = 0; i < level.riotshield_fling_enemies.size; i++) {
    [[level.var_2677b8bb]] - > waitinqueue(level.riotshield_fling_enemies[i]);

    if(isDefined(level.riotshield_fling_enemies[i])) {

      function_64ff58da((1, 0, 0), level.riotshield_fling_enemies[i].origin);

        level.riotshield_fling_enemies[i] thread function_80a146c1(self, weapon);
      var_d3f92d4d = 30;

      if(self hasperk(#"specialty_mod_shield")) {
        var_d3f92d4d *= 0.66;
      }

      shield_damage += var_d3f92d4d;
    }
  }

  for(i = 0; i < level.riotshield_knockdown_enemies.size; i++) {

    function_64ff58da((0, 1, 0), level.riotshield_knockdown_enemies[i].origin);

      [
        [level.var_2677b8bb]
      ] - > waitinqueue(level.riotshield_knockdown_enemies[i]);

    if(!isDefined(level.riotshield_knockdown_enemies[i])) {
      continue;
    }

    level.riotshield_knockdown_enemies[i] thread riotshield::riotshield_knockdown_zombie(self, level.riotshield_knockdown_gib[i], weapon);
    shield_damage += 20;
  }

  foreach(ai_enemy in level.var_21ffc192) {
    [[level.var_2677b8bb]] - > waitinqueue(ai_enemy);

    if(!isDefined(ai_enemy)) {
      continue;
    }

    switch (ai_enemy.zm_ai_category) {
      case #"heavy":
      case #"miniboss":
      case #"boss":
        var_d3f92d4d = 30;
        break;
      default:
        var_d3f92d4d = 20;
        break;
    }

    if(self hasperk(#"specialty_mod_shield")) {
      var_d3f92d4d *= 0.66;
    }

    shield_damage += var_d3f92d4d;
  }

  level.riotshield_knockdown_enemies = [];
  level.riotshield_knockdown_gib = [];
  level.riotshield_fling_enemies = [];
  level.riotshield_fling_vecs = [];
  level.var_21ffc192 = [];

  if(shield_damage) {
    self riotshield::player_damage_shield(shield_damage, 0);
  }
}

function_80a146c1(player, weapon) {
  if(!isDefined(self) || !isalive(self)) {
    return;
  }

  if(isDefined(self.ignore_riotshield) && self.ignore_riotshield) {
    return;
  }

  if(isDefined(self.var_9c1f60e8)) {
    self[[self.var_9c1f60e8]](player);
    return;
  }

  self dodamage(3000, player.origin, player, player, "", "MOD_IMPACT", 0, weapon);

  if(self.health < 1 || player zm_powerups::is_insta_kill_active()) {
    gibserverutils::annihilate(self);
  }
}

function_a5ed9221(weapon) {
  if(weapon == level.var_ce3aa8a8) {
    riotshield::riotshield_melee(weapon);
    return;
  }

  view_pos = self.origin;
  var_25e2354 = function_4d8c71ce();
  var_72714481 = getaispeciesarray(level.zombie_team, "all");
  a_e_targets = arraycombine(var_72714481, var_25e2354, 0, 0);
  forward_view_angles = self getweaponforwarddir();
  end_pos = view_pos + vectorscale(forward_view_angles, 64);

  sphere(end_pos, 48, (1, 0, 0), 0.1, 1, 16, int(5 * 1 / float(function_60d95f53()) / 1000));

    a_e_targets = array::get_all_closest(end_pos, a_e_targets, undefined, undefined, 48);

  if(!isDefined(a_e_targets) || a_e_targets.size < 1) {
    return;
  }

  for(i = 0; i < a_e_targets.size; i++) {
    [[level.var_2677b8bb]] - > waitinqueue(a_e_targets[i]);

    if(!isDefined(a_e_targets[i])) {
      continue;
    }

    a_e_targets[i] thread riotshield::riotshield_knockdown_zombie(self, 0, weapon);
  }
}

function_376cd4f6(weapon) {
  if(!isDefined(level.riotshield_knockdown_enemies)) {
    level.riotshield_knockdown_enemies = [];
    level.riotshield_knockdown_gib = [];
    level.riotshield_fling_enemies = [];
    level.riotshield_fling_vecs = [];
    level.var_21ffc192 = [];
  }

  self riotshield::riotshield_get_enemies_in_range(128, 128, 128);
  shield_damage = 0;

  for(i = 0; i < level.riotshield_fling_enemies.size; i++) {
    [[level.var_2677b8bb]] - > waitinqueue(level.riotshield_fling_enemies[i]);

    if(isDefined(level.riotshield_fling_enemies[i])) {
      level.riotshield_fling_enemies[i] thread riotshield::riotshield_fling_zombie(self, level.riotshield_fling_vecs[i], i);
      var_d3f92d4d = zombie_utility::get_zombie_var(#"riotshield_fling_damage_shield");

      if(self hasperk(#"specialty_mod_shield")) {
        var_d3f92d4d *= 0.66;
      }

      shield_damage += var_d3f92d4d;
    }
  }

  for(i = 0; i < level.riotshield_knockdown_enemies.size; i++) {
    [[level.var_2677b8bb]] - > waitinqueue(level.riotshield_knockdown_enemies[i]);

    if(!isDefined(level.riotshield_knockdown_enemies[i])) {
      continue;
    }

    level.riotshield_knockdown_enemies[i] thread riotshield::riotshield_knockdown_zombie(self, level.riotshield_knockdown_gib[i]);
    shield_damage += zombie_utility::get_zombie_var(#"riotshield_knockdown_damage_shield");
  }

  foreach(ai_enemy in level.var_21ffc192) {
    switch (ai_enemy.zm_ai_category) {
      case #"heavy":
      case #"miniboss":
      case #"boss":
        var_d3f92d4d = zombie_utility::get_zombie_var(#"hash_bfdf728041b626a");
        break;
      default:
        var_d3f92d4d = zombie_utility::get_zombie_var(#"hash_6835f7c5524585f3");
        break;
    }

    if(self hasperk(#"specialty_mod_shield")) {
      var_d3f92d4d *= 0.66;
    }

    shield_damage += var_d3f92d4d;
  }

  level.riotshield_knockdown_enemies = [];
  level.riotshield_knockdown_gib = [];
  level.riotshield_fling_enemies = [];
  level.riotshield_fling_vecs = [];
  level.var_21ffc192 = [];

  if(shield_damage) {}
}