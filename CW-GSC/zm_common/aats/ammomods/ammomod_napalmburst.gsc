/***********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\aats\ammomods\ammomod_napalmburst.gsc
***********************************************************/

#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#namespace ammomod_napalmburst;

function init_napalmburst() {
  if(!is_true(level.aat_in_use)) {
    return;
  }

  if(!is_true(getgametypesetting(#"hash_10de3b1cea667398"))) {
    level.var_172a89cd = 1;
  }

  aat::register("ammomod_napalmburst", 0.15, 0, 3, 3, 1, &result, "t7_hud_zm_aat_blastfurnace", "wpn_aat_blast_furnace_plr", undefined, #"fire", undefined, #"hash_25c5cf4ba6d26606");
  aat::register("ammomod_napalmburst_1", 0.15, 0, 3, 3, 1, &result, "t7_hud_zm_aat_blastfurnace", "wpn_aat_blast_furnace_plr", undefined, #"fire", undefined, #"hash_25c5cf4ba6d26606");
  aat::register("ammomod_napalmburst_2", 0.15, 0, 3, 3, 1, &result, "t7_hud_zm_aat_blastfurnace", "wpn_aat_blast_furnace_plr", undefined, #"fire", undefined, #"hash_25c5cf4ba6d26606");
  aat::register("ammomod_napalmburst_3", 0.15, 0, 3, 3, 1, &result, "t7_hud_zm_aat_blastfurnace", "wpn_aat_blast_furnace_plr", undefined, #"fire", undefined, #"hash_25c5cf4ba6d26606");
  aat::register("ammomod_napalmburst_4", 0.15, 0, 3, 3, 1, &result, "t7_hud_zm_aat_blastfurnace", "wpn_aat_blast_furnace_plr", undefined, #"fire", undefined, #"hash_25c5cf4ba6d26606");
  aat::register("ammomod_napalmburst_5", 0.15, 0, 3, 3, 1, &result, "t7_hud_zm_aat_blastfurnace", "wpn_aat_blast_furnace_plr", undefined, #"fire", undefined, #"hash_25c5cf4ba6d26606");
  clientfield::register("actor", "zm_ammomod_napalmburst_explosion", 1, 1, "counter");
  clientfield::register("vehicle", "zm_ammomod_napalmburst_explosion", 1, 1, "counter");
  clientfield::register("actor", "zm_ammomod_napalmburst_burn", 1, 1, "int");
  clientfield::register("vehicle", "zm_ammomod_napalmburst_burn", 1, 1, "int");
  clientfield::register("toplayer", "ammomod_napalmburst_proc", 1, 1, "counter");
  level.var_da1321f4 = &function_80b0dbe5;
}

function private function_e8018847(aat_name = "ammomod_napalmburst") {
  switch (aat_name) {
    case # "ammomod_napalmburst":
    default:
      return 0;
    case # "ammomod_napalmburst_1":
      return 1;
    case # "ammomod_napalmburst_2":
      return 2;
    case # "ammomod_napalmburst_3":
      return 3;
    case # "ammomod_napalmburst_4":
      return 4;
    case # "ammomod_napalmburst_5":
      return 5;
  }

  return 0;
}

function result(death, attacker, mod, weapon, var_fd90b0bb, vpoint, shitloc, boneindex = self.origin) {
  waitframe(1);

  if(is_true(level.var_172a89cd)) {
    return;
  }

  if(!isactor(self) && !isvehicle(self)) {
    return;
  }

  if(is_true(self.aat_turned)) {
    return;
  }

  if(!isPlayer(weapon)) {
    return;
  }

  if(self.zm_ai_category === # "elite" || self.zm_ai_category === # "boss") {
    return;
  }

  aat_name = weapon aat::getaatonweapon(vpoint, 1);
  tier = function_e8018847(aat_name);

  if(tier < 4 && self.zm_ai_category === # "special") {
    return;
  }

  weapon clientfield::increment_to_player("ammomod_napalmburst_proc", 1);
  playFX("zm_weapons/fx9_aat_bul_impact_fire", boneindex);
  weapon zm_utility::function_5d356609(aat_name, tier);

  if(is_true(mod) && function_4f7f29ab(weapon) && tier >= 5) {
    level thread function_c8e3a0dc(self, self.origin, weapon, var_fd90b0bb, vpoint, shitloc);
    return;
  }

  if(self.zm_ai_category === # "special") {
    if(tier >= 4) {
      self thread function_80b0dbe5(weapon, vpoint, tier);
      self thread function_be5234be(weapon, var_fd90b0bb, vpoint, shitloc, tier);
    }

    return;
  }

  if(self.zm_ai_category === # "normal") {
    self thread function_80b0dbe5(weapon, vpoint, tier);
    self thread function_be5234be(weapon, var_fd90b0bb, vpoint, shitloc, tier);
  }
}

function private function_4f7f29ab(e_attacker) {
  n_current_time = float(gettime()) / 1000;

  if(isPlayer(e_attacker)) {
    if(!isDefined(e_attacker.aat_cooldown_start[#"zm_ammomod_napalmburst_explosion"])) {
      return true;
    } else if(isDefined(e_attacker.aat_cooldown_start[#"zm_ammomod_napalmburst_explosion"]) && n_current_time >= e_attacker.aat_cooldown_start[#"zm_ammomod_napalmburst_explosion"] + 30) {
      return true;
    }
  }

  return false;
}

function function_c8e3a0dc(var_4589e270, var_23255fc5, e_attacker, mod, w_weapon, var_fd90b0bb) {
  if(isDefined(var_23255fc5)) {
    var_23255fc5 thread clientfield::increment("zm_ammomod_napalmburst_explosion");

    if(isactor(var_23255fc5)) {
      var_23255fc5 zombie_death_gib(mod, w_weapon, var_fd90b0bb);
    }
  }

  n_range = 144;

  if(isPlayer(mod)) {
    mod.aat_cooldown_start[#"zm_ammomod_napalmburst_explosion"] = float(gettime()) / 1000;
  }

  a_potential_targets = getentitiesinradius(e_attacker, 144, 15);
  count = 0;

  foreach(zombie in a_potential_targets) {
    if(!isalive(zombie)) {
      continue;
    }

    if(count >= 5) {
      return;
    }

    if(var_23255fc5 === zombie) {
      continue;
    }

    if(isalive(zombie) && (zombie.zm_ai_category === # "normal" || zombie.archetype === # "zombie_dog")) {
      zombie thread function_80b0dbe5(mod, w_weapon, 5);
      zombie thread function_be5234be(mod, undefined, w_weapon, var_fd90b0bb, 5);
    }

    count++;
    util::wait_network_frame();
  }
}

function function_80b0dbe5(e_attacker, w_weapon, tier) {
  self notify(#"hash_8ba8465d56bb40e");
  self endon(#"hash_8ba8465d56bb40e", #"death");
  self function_74816787();
  var_70ab6bc = self.maxhealth * 0.05;
  var_9b6cf9b5 = self.maxhealth * 0.1;

  if(tier >= 3) {
    var_70ab6bc *= 2;
    var_9b6cf9b5 *= 2;
  }

  i = 0;
  total_ticks = 5;

  if(tier >= 2) {
    total_ticks = 10;
  }

  var_2c5684be = 0;

  while(i <= total_ticks) {
    if(tier >= 1 && !var_2c5684be) {
      if(var_9b6cf9b5 >= self.health && w_weapon.name !== # "hero_flamethrower") {
        self.var_9b0f545e = 1;
      }

      self dodamage(var_9b6cf9b5, self.origin, e_attacker, undefined, "none", "MOD_AAT", 0, w_weapon);
      var_2c5684be = 1;
    } else {
      if(var_70ab6bc >= self.health && w_weapon.name !== # "hero_flamethrower") {
        self.var_9b0f545e = 1;
      }

      self dodamage(var_70ab6bc, self.origin, e_attacker, undefined, "none", "MOD_AAT", 0, w_weapon);
    }

    i++;
    wait 1;
  }

  if(self ishidden()) {
    while(self ishidden()) {
      wait 1;
    }

    wait 1;
  }

  self function_68364c40();
  self notify(#"hash_1a322c9f227ee");
  self.var_e7dcb25b = undefined;
}

function function_74816787() {
  if(!isDefined(self.var_2290a541)) {
    self.var_2290a541 = 0;
  }

  if(self.var_2290a541 == 0) {
    self thread clientfield::set("zm_ammomod_napalmburst_burn", 1);
  }

  self.var_2290a541++;
}

function function_68364c40() {
  if(isDefined(self.var_2290a541)) {
    self.var_2290a541--;

    if(self.var_2290a541 <= 0) {
      self.var_2290a541 = 0;
      self thread clientfield::set("zm_ammomod_napalmburst_burn", 0);
    }
  }
}

function function_be5234be(attacker, mod, weapon, var_fd90b0bb, tier = 0) {
  self notify(#"hash_382c4508f36af706");
  self endon(#"hash_382c4508f36af706", #"hash_1a322c9f227ee");
  self waittill(#"death");

  if(isDefined(self)) {
    if(is_true((isDefined(self.var_2290a541) ? self.var_2290a541 : 0) > 0) && function_4f7f29ab(attacker) && tier == 5) {
      level thread function_c8e3a0dc(self, self.origin, attacker, mod, weapon, var_fd90b0bb);
    }
  }
}

function zombie_death_gib(e_attacker, w_weapon, var_fd90b0bb) {
  var_c3317960 = gibserverutils::function_de4d9d(w_weapon, var_fd90b0bb);
  self clientfield::set("zm_ammomod_napalmburst_burn", 1);
  gibserverutils::gibhead(self, var_c3317960);

  if(math::cointoss()) {
    gibserverutils::gibleftarm(self, var_c3317960);
  } else {
    gibserverutils::gibrightarm(self, var_c3317960);
  }

  gibserverutils::giblegs(self, var_c3317960);
}