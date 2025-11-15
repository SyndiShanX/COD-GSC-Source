/*****************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_elemental_bow_rune_prison.gsc
*****************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_shared;
#using scripts\shared\ai_shared;
#using scripts\shared\animation_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\math_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weap_elemental_bow;
#using scripts\zm\_zm_weapons;
#namespace _zm_weap_elemental_bow_rune_prison;

function autoexec __init__sytem__() {
  system::register("_zm_weap_elemental_bow_rune_prison", & __init__, & __main__, undefined);
}

function __init__() {
  level.var_fb620116 = getweapon("elemental_bow_rune_prison");
  level.var_791ba87b = getweapon("elemental_bow_rune_prison4");
  clientfield::register("toplayer", "elemental_bow_rune_prison" + "_ambient_bow_fx", 5000, 1, "int");
  clientfield::register("missile", "elemental_bow_rune_prison" + "_arrow_impact_fx", 5000, 1, "int");
  clientfield::register("missile", "elemental_bow_rune_prison4" + "_arrow_impact_fx", 5000, 1, "int");
  clientfield::register("scriptmover", "runeprison_rock_fx", 5000, 1, "int");
  clientfield::register("scriptmover", "runeprison_explode_fx", 5000, 1, "int");
  clientfield::register("scriptmover", "runeprison_lava_geyser_fx", 5000, 1, "int");
  clientfield::register("actor", "runeprison_lava_geyser_dot_fx", 5000, 1, "int");
  clientfield::register("actor", "runeprison_zombie_charring", 5000, 1, "int");
  clientfield::register("actor", "runeprison_zombie_death_skull", 5000, 1, "int");
  callback::on_connect( & function_4d344d97);
}

function __main__() {}

function function_4d344d97() {
  self thread zm_weap_elemental_bow::function_982419bb("elemental_bow_rune_prison");
  self thread zm_weap_elemental_bow::function_ececa597("elemental_bow_rune_prison", "elemental_bow_rune_prison4");
  self thread zm_weap_elemental_bow::function_7bc6b9d("elemental_bow_rune_prison", "elemental_bow_rune_prison4", & function_c8b11b89);
}

function function_c8b11b89(weapon, position, radius, attacker, normal) {
  if(issubstr(weapon.name, "elemental_bow_rune_prison4")) {
    level thread function_94ba3a15(self, position, weapon.name, attacker, 1, 0);
  } else {
    level thread function_48899f7(self, position, weapon.name, attacker);
  }
}

function function_94ba3a15(e_player, v_hit_origin, str_weapon_name, var_3fee16b8, var_df033097, var_8b30ffd9) {
  if(var_df033097) {
    e_player.var_d96b65c1 = & function_1ed3d96d;
    v_spawn_pos = e_player zm_weap_elemental_bow::function_866906f(v_hit_origin, str_weapon_name, var_3fee16b8, 48, e_player.var_d96b65c1);
    if(var_df033097) {
      var_289e02fc = (isDefined(v_spawn_pos) ? v_spawn_pos : v_hit_origin);
      var_852420bf = array::get_all_closest(var_289e02fc, getaiteamarray(level.zombie_team), undefined, undefined, 256);
      var_852420bf = array::filter(var_852420bf, 0, & zm_weap_elemental_bow::function_5aec3adc);
      var_852420bf = array::filter(var_852420bf, 0, & function_71c4b12e, var_289e02fc);
      if(getdvarint("splitscreen_playerCount") > 2) {
        var_852420bf = array::clamp_size(var_852420bf, 6);
      } else {
        var_852420bf = array::clamp_size(var_852420bf, 12);
      }
      foreach(n_index, ai_enemy in var_852420bf) {
        ai_enemy thread function_94ba3a15(e_player, v_hit_origin, str_weapon_name, var_3fee16b8, 0, n_index);
      }
      if(var_852420bf.size) {
        return;
      }
    }
  } else {
    v_spawn_pos = function_46a00a8e(self);
  }
  if(!isDefined(v_spawn_pos)) {
    iprintlnbold("");
    return;
  }
  if(isDefined(v_spawn_pos)) {
    var_c8bd3127 = util::spawn_model("tag_origin", v_spawn_pos, (0, randomintrange(0, 360), 0));
    if(isai(self) && isalive(self)) {
      self.var_a320d911 = 1;
      self.var_98056717 = 1;
      self linkto(var_c8bd3127);
      self setplayercollision(0);
      self thread function_5c74632();
    }
  }
  var_c8bd3127 clientfield::set("runeprison_rock_fx", 1);
  self thread function_378db90d(v_spawn_pos);
  if(isDefined(self) && isalive(self)) {
    if(isDefined(self.isdog) && self.isdog || (isDefined(self.missinglegs) && self.missinglegs)) {
      self dodamage(self.health, var_c8bd3127.origin, e_player, e_player, undefined, "MOD_BURNED", 0, level.var_791ba87b);
    }
  }
  wait(1.8 + (0.07 * var_8b30ffd9));
  var_c8bd3127 clientfield::set("runeprison_explode_fx", 1);
  if(isDefined(self) && isalive(self) && self.archetype === "zombie") {
    self notify("hash_9d9f16be");
    self clientfield::set("runeprison_zombie_charring", 1);
  }
  wait(2);
  if(isDefined(self) && isai(self) && isalive(self)) {
    if(self.archetype === "mechz") {
      var_3bb42832 = level.mechz_health;
      if(isDefined(level.var_f4dc2834)) {
        var_3bb42832 = math::clamp(var_3bb42832, 0, level.var_f4dc2834);
      }
      var_40955aed = (var_3bb42832 * 0.2) / 0.2;
      self.var_a320d911 = 0;
      self.var_98056717 = 0;
      self scene::stop("ai_zm_dlc1_soldat_runeprison_struggle_loop");
      self dodamage(var_40955aed, var_c8bd3127.origin, e_player, e_player, undefined, "MOD_PROJECTILE_SPLASH", 0, level.var_791ba87b);
      self thread function_62837b3a();
    } else if(self.archetype === "zombie") {
      if(math::cointoss()) {
        gibserverutils::gibhead(self);
        self clientfield::set("runeprison_zombie_death_skull", 1);
      }
      self dodamage(self.health, var_c8bd3127.origin, e_player, e_player, undefined, "MOD_BURNED", 0, level.var_791ba87b);
    }
    self setplayercollision(1);
    self unlink();
  }
  var_852420bf = array::get_all_closest(var_c8bd3127.origin, getaiteamarray(level.zombie_team), undefined, undefined, 96);
  var_852420bf = array::filter(var_852420bf, 0, & zm_weap_elemental_bow::function_5aec3adc);
  var_852420bf = array::filter(var_852420bf, 0, & function_e381ab3a);
  foreach(var_b4aadf6b in var_852420bf) {
    var_b4aadf6b dodamage(var_b4aadf6b.health, var_c8bd3127.origin, e_player, e_player, undefined, "MOD_BURNED", 0, level.var_791ba87b);
  }
  var_c8bd3127 clientfield::set("runeprison_rock_fx", 0);
  wait(6);
  var_c8bd3127 delete();
}

function function_378db90d(v_pos) {
  wait(0.1);
  var_852420bf = array::get_all_closest(v_pos, getaiteamarray(level.zombie_team), undefined, undefined, 96);
  var_852420bf = array::filter(var_852420bf, 0, & zm_weap_elemental_bow::function_5aec3adc);
  var_852420bf = array::filter(var_852420bf, 0, & function_cece5ffb);
  var_852420bf = array::clamp_size(var_852420bf, 2);
  foreach(var_b4aadf6b in var_852420bf) {
    var_b4aadf6b thread zm_weap_elemental_bow::function_d1e69389(v_pos);
  }
}

function function_62837b3a() {
  self endon("death");
  self.var_d3c478a0 = 1;
  wait(16);
  self.var_d3c478a0 = 0;
}

function function_71c4b12e(ai_enemy, var_289e02fc) {
  return !(isDefined(ai_enemy.var_a320d911) && ai_enemy.var_a320d911) && (bullettracepassed(ai_enemy getcentroid(), var_289e02fc, 0, undefined) || bullettracepassed(ai_enemy getcentroid(), var_289e02fc + vectorscale((0, 0, 1), 48), 0, undefined));
}

function function_cece5ffb(ai_enemy) {
  return !(isDefined(ai_enemy.var_a320d911) && ai_enemy.var_a320d911) && (!(isDefined(ai_enemy.knockdown) && ai_enemy.knockdown)) && (!(isDefined(ai_enemy.missinglegs) && ai_enemy.missinglegs));
}

function function_e381ab3a(ai_enemy) {
  return !(isDefined(ai_enemy.var_a320d911) && ai_enemy.var_a320d911);
}

function function_5c74632() {
  self endon("death");
  wait(0.1);
  if(self.archetype === "zombie") {
    var_5606e343 = randomintrange(1, 5);
    self thread scene::play("ai_zm_dlc1_zombie_runeprison_locked_struggle_0" + var_5606e343, self);
    self waittill("hash_9d9f16be");
    wait(0.5);
    self scene::play("ai_zm_dlc1_zombie_runeprison_death_loop_0" + randomintrange(1, 5), self);
  } else if(self.archetype === "mechz") {
    self scene::play("ai_zm_dlc1_soldat_runeprison_struggle_loop", self);
  }
}

function function_48899f7(e_player, v_hit_origin, str_weapon_name, var_3fee16b8) {
  v_spawn_pos = e_player zm_weap_elemental_bow::function_866906f(v_hit_origin, str_weapon_name, var_3fee16b8, 32);
  if(!isDefined(v_spawn_pos)) {
    return;
  }
  var_3c817f0d = util::spawn_model("tag_origin", v_spawn_pos);
  var_3c817f0d clientfield::set("runeprison_lava_geyser_fx", 1);
  n_timer = 0;
  var_4275176f = [];
  while(n_timer < 3) {
    var_852420bf = array::get_all_closest(var_3c817f0d.origin, getaiteamarray(level.zombie_team), undefined, undefined, 48);
    var_852420bf = array::filter(var_852420bf, 0, & zm_weap_elemental_bow::function_5aec3adc);
    var_852420bf = array::filter(var_852420bf, 0, & function_6a1a0b32, var_3c817f0d);
    array::thread_all(var_852420bf, & function_e7abbbb8, var_3c817f0d, e_player);
    wait(0.05);
    n_timer = n_timer + 0.05;
  }
  wait(6);
  var_3c817f0d delete();
}

function function_6a1a0b32(ai_enemy, var_3c817f0d) {
  return !(isDefined(ai_enemy.var_ca25d40c) && ai_enemy.var_ca25d40c);
}

function function_e7abbbb8(var_3c817f0d, e_player) {
  self endon("death");
  self.var_ca25d40c = 1;
  n_timer = 0;
  if(self.archetype === "mechz") {
    var_3bb42832 = level.mechz_health;
    if(isDefined(level.var_f4dc2834)) {
      var_3bb42832 = math::clamp(var_3bb42832, 0, level.var_f4dc2834);
    }
    n_max_damage = (var_3bb42832 * 0.05) / 0.2;
    str_mod = "MOD_PROJECTILE_SPLASH";
  } else {
    n_max_damage = (level.zombie_health > 2482 ? 2482 : level.zombie_health);
    str_mod = "MOD_UNKNOWN";
  }
  self clientfield::set("runeprison_lava_geyser_dot_fx", 1);
  var_2a8dacd1 = n_max_damage * 0.3;
  self dodamage(var_2a8dacd1, self.origin, e_player, e_player, undefined, str_mod, 0, level.var_fb620116);
  var_c18df445 = n_max_damage * 0.1;
  while(n_timer < 6 && var_2a8dacd1 < n_max_damage) {
    var_e1fd6746 = randomfloatrange(0.4, 1);
    wait(var_e1fd6746);
    n_timer = n_timer + var_e1fd6746;
    self dodamage(var_c18df445, self.origin, e_player, e_player, undefined, str_mod, 0, level.var_fb620116);
    var_2a8dacd1 = var_2a8dacd1 + var_c18df445;
  }
  self clientfield::set("runeprison_lava_geyser_dot_fx", 0);
  self.var_ca25d40c = 0;
}

function function_46a00a8e(ai_enemy) {
  n_z_diff = 12 * 2;
  while(isDefined(ai_enemy) && isalive(ai_enemy) && (!(isDefined(ai_enemy.var_98056717) && ai_enemy.var_98056717)) && n_z_diff > 12) {
    var_c6f6381a = bulletTrace(ai_enemy.origin, ai_enemy.origin - vectorscale((0, 0, 1), 1000), 0, undefined);
    n_z_diff = ai_enemy.origin[2] - var_c6f6381a["position"][2];
    wait(0.1);
  }
  if(isDefined(ai_enemy) && isalive(ai_enemy) && (!(isDefined(ai_enemy.var_98056717) && ai_enemy.var_98056717))) {
    return ai_enemy.origin;
  }
  return undefined;
}

function function_1ed3d96d(str_weapon_name, v_source, v_destination) {
  wait(0.1);
  str_weapon_name = (str_weapon_name == "elemental_bow_rune_prison4" ? "elemental_bow_rune_prison4_ricochet" : "elemental_bow_rune_prison_ricochet");
  magicbullet(getweapon(str_weapon_name), v_source, v_destination, self);
}