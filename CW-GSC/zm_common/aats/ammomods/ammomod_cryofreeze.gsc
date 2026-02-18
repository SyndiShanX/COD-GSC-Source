/**********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\aats\ammomods\ammomod_cryofreeze.gsc
**********************************************************/

#using script_7464a3005f61a5f6;
#using script_7f6cd71c43c45c57;
#using scripts\core_common\aat_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_utility;
#namespace ammomod_cryofreeze;

function init_cryofreeze() {
  if(!is_true(level.aat_in_use)) {
    return;
  }

  if(!is_true(getgametypesetting(#"hash_54537cc749c2001d"))) {
    level.var_8b4e3a9f = 1;
  }

  aat::register("ammomod_cryofreeze", 0.9, 0, 0, 1, 1, &result, "t7_hud_zm_aat_thunderwall", "wpn_aat_thunder_wall_plr", undefined, #"cold", undefined, #"hash_42ab7b3bdc482a44");
  aat::register("ammomod_cryofreeze_1", 0.9, 0, 0, 1, 1, &result, "t7_hud_zm_aat_thunderwall", "wpn_aat_thunder_wall_plr", undefined, #"cold", undefined, #"hash_42ab7b3bdc482a44");
  aat::register("ammomod_cryofreeze_2", 0.9, 0, 0, 1, 1, &result, "t7_hud_zm_aat_thunderwall", "wpn_aat_thunder_wall_plr", undefined, #"cold", undefined, #"hash_42ab7b3bdc482a44");
  aat::register("ammomod_cryofreeze_3", 0.9, 0, 0, 1, 1, &result, "t7_hud_zm_aat_thunderwall", "wpn_aat_thunder_wall_plr", undefined, #"cold", undefined, #"hash_42ab7b3bdc482a44");
  aat::register("ammomod_cryofreeze_4", 0.9, 0, 0, 1, 1, &result, "t7_hud_zm_aat_thunderwall", "wpn_aat_thunder_wall_plr", undefined, #"cold", undefined, #"hash_42ab7b3bdc482a44");
  aat::register("ammomod_cryofreeze_5", 0.9, 0, 0, 1, 1, &result, "t7_hud_zm_aat_thunderwall", "wpn_aat_thunder_wall_plr", undefined, #"cold", undefined, #"hash_42ab7b3bdc482a44");
  clientfield::register("actor", "zm_ammomod_cryofreeze_trail_clientfield", 1, 1, "int");
  clientfield::register("vehicle", "zm_ammomod_cryofreeze_trail_clientfield", 1, 1, "int");
  clientfield::register("actor", "zm_ammomod_cryofreeze_explosion_clientfield", 1, 1, "counter");
  clientfield::register("vehicle", "zm_ammomod_cryofreeze_explosion_clientfield", 1, 1, "counter");
  clientfield::register("toplayer", "ammomod_cryofreeze_proc", 1, 1, "counter");
  namespace_df7b10e3::register_slowdown(#"hash_11428bfe58012e24", 0.7, 3);
  namespace_df7b10e3::register_slowdown(#"hash_61bdd7c7815dd7a9", 0.7, 5);
  namespace_df7b10e3::register_slowdown(#"hash_61bdd6c7815dd5f6", 0.5, 5);
}

function private function_a0c6cb5d(aat_name = "ammomod_cryofreeze") {
  switch (aat_name) {
    case # "ammomod_cryofreeze":
    default:
      return 0;
    case # "ammomod_cryofreeze_1":
      return 1;
    case # "ammomod_cryofreeze_2":
      return 2;
    case # "ammomod_cryofreeze_3":
      return 3;
    case # "ammomod_cryofreeze_4":
      return 4;
    case # "ammomod_cryofreeze_5":
      return 5;
  }

  return 0;
}

function result(death, attacker, mod, weapon, var_fd90b0bb, vpoint, shitloc, boneindex = self.origin) {
  self notify(#"hash_3c2776b4262d3359");
  self endon(#"hash_3c2776b4262d3359");
  waitframe(1);

  if(is_true(level.var_8b4e3a9f)) {
    return;
  }

  if(!isactor(self) && !isvehicle(self)) {
    return;
  }

  if(is_true(self.aat_turned)) {
    return;
  }

  if(!isPlayer(var_fd90b0bb)) {
    return;
  }

  if(self.zm_ai_category === # "elite" || self.zm_ai_category === # "boss") {
    return;
  }

  aat_name = var_fd90b0bb aat::getaatonweapon(shitloc, 1);
  tier = function_a0c6cb5d(aat_name);

  if(tier < 4 && self.zm_ai_category === # "special") {
    return;
  }

  var_fd90b0bb clientfield::increment_to_player("ammomod_cryofreeze_proc", 1);
  playFX("zm_weapons/fx9_aat_bul_impact_frost", boneindex);
  var_fd90b0bb zm_utility::function_5d356609(aat_name, tier);

  if(is_true(weapon) && function_3be79107(var_fd90b0bb) && tier >= 5 && (self.zm_ai_category === # "normal" || self.zm_ai_category === # "special")) {
    level thread function_9366890d(self, self.origin, var_fd90b0bb, vpoint, shitloc);
    return;
  }

  if(self.zm_ai_category === # "special") {
    if(tier >= 4) {
      self thread function_f00409f3(var_fd90b0bb, vpoint, shitloc, 0, tier);
    }

    return;
  }

  if(self.zm_ai_category === # "normal") {
    self thread function_f00409f3(var_fd90b0bb, vpoint, shitloc, 0, tier);
  }
}

function private function_3be79107(e_attacker) {
  n_current_time = float(gettime()) / 1000;

  if(isPlayer(e_attacker)) {
    if(!isDefined(e_attacker.aat_cooldown_start[# "hash_6c45efdfc5561fe0"])) {
      return true;
    } else if(isDefined(e_attacker.aat_cooldown_start[# "hash_6c45efdfc5561fe0"]) && n_current_time >= e_attacker.aat_cooldown_start[# "hash_6c45efdfc5561fe0"] + 30) {
      return true;
    }
  }

  return false;
}

function function_f00409f3(attacker, mod, weapon, var_e1ec1eee = 0, tier = 0) {
  self endon(#"death");

  if(!isDefined(self.var_d70e35fb)) {
    self.var_d70e35fb = 1;
  } else if(self.var_d70e35fb <= 0.4) {
    return;
  }

  if(!isDefined(weapon) || !isDefined(mod) || !isPlayer(mod)) {
    return;
  }

  if(var_e1ec1eee) {
    self.var_d70e35fb = 0.4;
  } else {
    n_baseweapon = weapons::getbaseweapon(weapon);
    var_fa87e189 = n_baseweapon.firetime;
    multiplier = 1.5;

    if(tier >= 1) {
      multiplier = 3;
    }

    self.var_d70e35fb -= var_fa87e189 * multiplier;

    if(self.var_d70e35fb <= 0.4) {
      self.var_d70e35fb = 0.4;
    }
  }

  if(!self clientfield::get("zm_ammomod_cryofreeze_trail_clientfield")) {
    self callback::callback(#"hash_7f690ab86160d4f6");
  }

  self clientfield::set("zm_ammomod_cryofreeze_trail_clientfield", 1);
  self.var_958cf9c5 = 1;
  self.var_e5d5f66e = mod;

  switch (tier) {
    case 0:
    case 1:
      self thread namespace_df7b10e3::slowdown(#"hash_11428bfe58012e24", self.var_d70e35fb, &function_4279213e);
      break;
    case 2:
      self thread namespace_df7b10e3::slowdown(#"hash_61bdd7c7815dd7a9", self.var_d70e35fb, &function_4279213e);
      break;
    case 3:
    case 4:
    case 5:
      self thread namespace_df7b10e3::slowdown(#"hash_61bdd6c7815dd5f6", self.var_d70e35fb, &function_4279213e);
      break;
  }

  self thread function_76d7d189(mod, weapon, tier);
  self thread function_6af83db3(mod, undefined, weapon, tier);
}

function function_76d7d189(e_attacker, weapon, tier = 0) {
  self notify(#"hash_271e03ecc07954ab");
  self endon(#"hash_271e03ecc07954ab", #"death");
  var_b543d2cf = 3;

  if(tier >= 2) {
    var_b543d2cf = 5;
  }

  for(i = 0; i < 8; i++) {
    wait var_b543d2cf / 8;
    self.var_d70e35fb += 0.125;

    if(self.var_d70e35fb >= 1) {
      break;
    }

    switch (tier) {
      case 0:
      case 1:
        self thread namespace_df7b10e3::slowdown(#"hash_11428bfe58012e24", self.var_d70e35fb, &function_4279213e);
        break;
      case 2:
        self thread namespace_df7b10e3::slowdown(#"hash_61bdd7c7815dd7a9", self.var_d70e35fb, &function_4279213e);
        break;
      case 3:
      case 4:
      case 5:
        self thread namespace_df7b10e3::slowdown(#"hash_61bdd6c7815dd5f6", self.var_d70e35fb, &function_4279213e);
        break;
    }
  }
}

function function_4279213e() {
  if(!isDefined(self)) {
    return;
  }

  self clientfield::set("zm_ammomod_cryofreeze_trail_clientfield", 0);
  self.var_958cf9c5 = undefined;
  self.var_e5d5f66e = undefined;
  self.var_d70e35fb = 1;
  self notify(#"hash_4e1fee0199a7c7c9");
  self callback::callback(#"hash_40f6b51ae82126a4");
}

function function_6af83db3(attacker, mod, weapon, tier = 0) {
  self notify(#"hash_42f4135c766a4dd0");
  self endon(#"hash_42f4135c766a4dd0", #"hash_4e1fee0199a7c7c9");
  self waittill(#"death");

  if(isDefined(self)) {
    if(is_true(self.var_958cf9c5) && function_3be79107(attacker) && tier == 5) {
      level thread function_9366890d(self, self.origin, attacker, mod, weapon);
      return;
    }

    self namespace_df7b10e3::function_520f4da5(#"hash_11428bfe58012e24");
  }
}

function function_9366890d(var_4589e270, var_23255fc5, attacker, mod, weapon) {
  self endon(#"death");
  var_4589e270 clientfield::increment("zm_ammomod_cryofreeze_explosion_clientfield");

  if(isPlayer(attacker)) {
    attacker.aat_cooldown_start[# "hash_6c45efdfc5561fe0"] = float(gettime()) / 1000;
  }

  a_potential_targets = getentitiesinradius(var_23255fc5, 144, 15);
  count = 0;

  foreach(e_target in a_potential_targets) {
    if(!isalive(e_target)) {
      continue;
    }

    if(count >= 5) {
      return;
    }

    if(var_4589e270 === e_target) {
      continue;
    }

    if(e_target.team !== level.zombie_team) {
      continue;
    }

    if(isalive(e_target) && (e_target.zm_ai_category === # "normal" || e_target.archetype === # "zombie_dog")) {
      e_target thread function_f00409f3(attacker, mod, weapon, 1, 5);
    }

    count++;
    util::wait_network_frame();
  }
}