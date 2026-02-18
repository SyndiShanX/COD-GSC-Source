/********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\aats\ammomods\ammomod_deadwire.gsc
********************************************************/

#using script_62caa307a394c18c;
#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lightning_chain;
#using scripts\core_common\system_shared;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_utility;
#namespace ammomod_deadwire;

function init_deadwire() {
  if(!is_true(level.aat_in_use)) {
    return;
  }

  if(!is_true(getgametypesetting(#"hash_66cad2a554f4d928"))) {
    level.var_92b7028a = 1;
  }

  aat::register("ammomod_deadwire", 0.2, 0, 15, 15, 1, &result, "t7_hud_zm_aat_deadwire", "wpn_aat_dead_wire_plr", undefined, #"electrical", &function_742f2da3, #"hash_bc4e073326251a8");
  aat::register("ammomod_deadwire_1", 0.2, 0, 15, 15, 1, &result, "t7_hud_zm_aat_deadwire", "wpn_aat_dead_wire_plr", undefined, #"electrical", &function_742f2da3, #"hash_bc4e073326251a8");
  aat::register("ammomod_deadwire_2", 0.2, 0, 15, 15, 1, &result, "t7_hud_zm_aat_deadwire", "wpn_aat_dead_wire_plr", undefined, #"electrical", &function_742f2da3, #"hash_bc4e073326251a8");
  aat::register("ammomod_deadwire_3", 0.2, 0, 15, 15, 1, &result, "t7_hud_zm_aat_deadwire", "wpn_aat_dead_wire_plr", undefined, #"electrical", &function_742f2da3, #"hash_bc4e073326251a8");
  aat::register("ammomod_deadwire_4", 0.2, 0, 15, 15, 1, &result, "t7_hud_zm_aat_deadwire", "wpn_aat_dead_wire_plr", undefined, #"electrical", &function_742f2da3, #"hash_bc4e073326251a8");
  aat::register("ammomod_deadwire_5", 0.2, 0, 15, 15, 1, &result, "t7_hud_zm_aat_deadwire", "wpn_aat_dead_wire_plr", undefined, #"electrical", &function_742f2da3, #"hash_bc4e073326251a8");
  clientfield::register("actor", "zm_ammomod_deadwire_explosion", 1, 1, "counter");
  clientfield::register("vehicle", "zm_ammomod_deadwire_explosion", 1, 1, "counter");
  clientfield::register("actor", "zm_ammomod_deadwire_zap", 1, 4, "int");
  clientfield::register("vehicle", "zm_ammomod_deadwire_zap", 1, 4, "int");
  clientfield::register("toplayer", "ammomod_deadwire_proc", 1, 1, "counter");
  level.var_6f993f47 = lightning_chain::create_lightning_chain_params(0, 1, 1);
  level.var_620d4080 = lightning_chain::create_lightning_chain_params(0, 1, 1);
  level.var_8ec0ca14 = lightning_chain::create_lightning_chain_params(0, 1, 1);
  level.var_b347489f = lightning_chain::create_lightning_chain_params(0, 1, 1);
  level.var_9d477dfa = lightning_chain::create_lightning_chain_params(0, 1, 1);
  level.var_7659ca85 = lightning_chain::create_lightning_chain_params(3, 4, 144);
  level.var_6f993f47.head_gib_chance = 0;
  level.var_6f993f47.network_death_choke = 4;
  level.var_6f993f47.should_kill_enemies = 0;
  level.var_6f993f47.challenge_stat_name = # "zm_ammomod_deadwire";
  level.var_6f993f47.no_fx = 1;
  level.var_6f993f47.clientside_fx = 0;
  level.var_6f993f47.str_mod = "MOD_AAT";
  level.var_6f993f47.var_a9255d36 = # "hash_ff52504bb0aceb9";
  level.var_6f993f47.stun_duration = 2;
  level.var_6f993f47.tier = 0;
  level.var_620d4080.head_gib_chance = 0;
  level.var_620d4080.network_death_choke = 4;
  level.var_620d4080.should_kill_enemies = 0;
  level.var_620d4080.challenge_stat_name = # "zm_ammomod_deadwire";
  level.var_620d4080.no_fx = 1;
  level.var_620d4080.clientside_fx = 0;
  level.var_620d4080.str_mod = "MOD_AAT";
  level.var_620d4080.var_a9255d36 = # "hash_ff52504bb0aceb9";
  level.var_620d4080.stun_duration = 4;
  level.var_620d4080.tier = 1;
  level.var_8ec0ca14.head_gib_chance = 0;
  level.var_8ec0ca14.network_death_choke = 4;
  level.var_8ec0ca14.should_kill_enemies = 0;
  level.var_8ec0ca14.challenge_stat_name = # "zm_ammomod_deadwire";
  level.var_8ec0ca14.no_fx = 1;
  level.var_8ec0ca14.clientside_fx = 0;
  level.var_8ec0ca14.str_mod = "MOD_AAT";
  level.var_8ec0ca14.var_a9255d36 = # "hash_ff52504bb0aceb9";
  level.var_8ec0ca14.stun_duration = 4;
  level.var_8ec0ca14.tier = 2;
  level.var_b347489f.head_gib_chance = 0;
  level.var_b347489f.network_death_choke = 4;
  level.var_b347489f.should_kill_enemies = 0;
  level.var_b347489f.challenge_stat_name = # "zm_ammomod_deadwire";
  level.var_b347489f.no_fx = 1;
  level.var_b347489f.clientside_fx = 0;
  level.var_b347489f.str_mod = "MOD_AAT";
  level.var_b347489f.var_a9255d36 = # "hash_ff52504bb0aceb9";
  level.var_b347489f.stun_duration = 4;
  level.var_b347489f.tier = 3;
  level.var_9d477dfa.head_gib_chance = 0;
  level.var_9d477dfa.network_death_choke = 4;
  level.var_9d477dfa.should_kill_enemies = 0;
  level.var_9d477dfa.challenge_stat_name = # "zm_ammomod_deadwire";
  level.var_9d477dfa.no_fx = 1;
  level.var_9d477dfa.clientside_fx = 0;
  level.var_9d477dfa.str_mod = "MOD_AAT";
  level.var_9d477dfa.var_a9255d36 = # "hash_ff52504bb0aceb9";
  level.var_9d477dfa.stun_duration = 4;
  level.var_9d477dfa.tier = 4;
  level.var_7659ca85.head_gib_chance = 0;
  level.var_7659ca85.network_death_choke = 4;
  level.var_7659ca85.should_kill_enemies = 0;
  level.var_7659ca85.challenge_stat_name = # "zm_ammomod_deadwire";
  level.var_7659ca85.no_fx = 1;
  level.var_7659ca85.clientside_fx = 0;
  level.var_7659ca85.str_mod = "MOD_AAT";
  level.var_7659ca85.var_a9255d36 = # "hash_ff52504bb0aceb9";
  level.var_7659ca85.stun_duration = 4;
  level.var_7659ca85.tier = 5;
  callback::add_callback(#"hash_210adcf09e99fba1", &function_ffe2bb2f);
}

function private function_832f84f6(aat_name = "ammomod_deadwire") {
  switch (aat_name) {
    case # "ammomod_deadwire":
      return 0;
    case # "ammomod_deadwire_1":
      return 1;
    case # "ammomod_deadwire_2":
      return 2;
    case # "ammomod_deadwire_3":
      return 3;
    case # "ammomod_deadwire_4":
      return 4;
    case # "ammomod_deadwire_5":
      return 5;
  }

  return 0;
}

function result(death, attacker, mod, weapon, var_fd90b0bb, vpoint, shitloc, boneindex = self.origin) {
  if(is_true(level.var_92b7028a)) {
    return;
  }

  if(!isactor(self) && !isvehicle(self)) {
    return;
  }

  if(is_true(self.aat_turned)) {
    return;
  }

  if(!aat::function_42918474(vpoint)) {
    return;
  }

  if(self.zm_ai_category === # "elite" || self.zm_ai_category === # "boss") {
    return;
  }

  aat_name = vpoint aat::getaatonweapon(shitloc, 1);
  tier = function_832f84f6(aat_name);

  if(tier < 4 && self.zm_ai_category === # "special") {
    return;
  }

  if(isPlayer(vpoint)) {
    vpoint clientfield::increment_to_player("ammomod_deadwire_proc", 1);
  }

  playFX("zm_weapons/fx9_aat_bul_impact_electric", boneindex);

  if(!isDefined(zombie_utility::get_zombie_var(#"tesla_head_gib_chance"))) {
    zombie_utility::set_zombie_var(#"tesla_head_gib_chance", 50);
  }

  vpoint zm_utility::function_5d356609(aat_name, tier);

  switch (tier) {
    case 0:
      level.var_6f993f47.weapon = shitloc;
      s_params = level.var_6f993f47;
      break;
    case 1:
      level.var_620d4080.weapon = shitloc;
      s_params = level.var_620d4080;
      break;
    case 2:
      level.var_8ec0ca14.weapon = shitloc;
      s_params = level.var_8ec0ca14;
      break;
    case 3:
      level.var_b347489f.weapon = shitloc;
      s_params = level.var_b347489f;
      break;
    case 4:
      level.var_9d477dfa.weapon = shitloc;
      s_params = level.var_9d477dfa;
      break;
    case 5:
      level.var_7659ca85.weapon = shitloc;
      s_params = level.var_7659ca85;
      break;
  }

  if(self.zm_ai_category === # "special") {
    if(tier >= 4) {
      self thread function_e0e02bed(vpoint, s_params, tier);
    }

    return;
  }

  if(self.zm_ai_category === # "normal") {
    self thread function_e0e02bed(vpoint, s_params, tier);
  }
}

function function_b686c867(e_attacker) {
  n_current_time = float(gettime()) / 1000;

  if(isPlayer(e_attacker)) {
    if(!isDefined(e_attacker.aat_cooldown_start[# "zm_ammomod_deadwire_explosion"])) {
      return true;
    } else if(isDefined(e_attacker.aat_cooldown_start[# "zm_ammomod_deadwire_explosion"]) && n_current_time >= e_attacker.aat_cooldown_start[# "zm_ammomod_deadwire_explosion"] + 30) {
      return true;
    }
  }

  return false;
}

function function_e0e02bed(attacker, s_params, tier) {
  self endon(#"death");

  if(isDefined(self.spawn_time) && gettime() == self.spawn_time) {
    waitframe(1);
  }

  if(!aat::function_42918474(attacker)) {
    return;
  }

  if(tier >= 5 && function_b686c867(attacker)) {
    function_5e4b580b(attacker, s_params, tier);
    return;
  }

  self function_de99f2ad(attacker, self, s_params, tier);
}

function function_5e4b580b(player, s_params, tier) {
  if(isactor(self) || isvehicle(self)) {
    self clientfield::increment("zm_ammomod_deadwire_explosion", 1);
  }

  a_zombies = getentitiesinradius(self.origin, 144, 15);
  count = 0;
  self function_de99f2ad(player, self, s_params, tier);

  foreach(e_zombie in a_zombies) {
    if(count >= 3) {
      return;
    }

    if(e_zombie == self) {
      continue;
    }

    if(e_zombie.zm_ai_category === # "elite" || e_zombie.zm_ai_category === # "special") {
      continue;
    }

    e_zombie function_de99f2ad(player, self, s_params, tier, 1);
    count++;
  }
}

function function_de99f2ad(player, var_fb0999c0, s_params, tier, var_ebf63dce = 0) {
  if(!isalive(self)) {
    return;
  }

  if(is_true(level.aat[# "ammomod_deadwire"].immune_result_indirect[self.archetype])) {
    return;
  }

  if(self == var_fb0999c0 && is_true(level.aat[# "ammomod_deadwire"].immune_result_direct[self.archetype])) {
    return;
  }

  if(self ai::is_stunned() || self flag::get(#"deadwire_stun") || !self ai::function_28aab32a()) {
    return;
  }

  if(self.zm_ai_category === # "elite") {
    return;
  }

  self flag::set(#"deadwire_stun");
  self.var_9c33fa32 = player;
  self thread function_30c7f12c(player, s_params, tier, var_ebf63dce);
}

function function_13d4bcdf(origin, player, params) {
  if(!isPlayer(player) || !isalive(self)) {
    return;
  }

  tier = isDefined(params.tier) ? params.tier : 0;
  stun_duration = isDefined(params.stun_duration) ? params.stun_duration : 2;
  weapon = player getcurrentweapon();
  damage_percent = tier >= 3 ? 0.25 : 0.16;
  self thread function_2bd8c11(player, damage_percent, weapon, stun_duration);
}

function function_2bd8c11(player, damage_percent, weapon, stun_duration) {
  self endon(#"death", #"deadwire_stunned", #"hash_3a0cc85cce9af776", #"deadwire_stun");
  var_4691e777 = self.origin;
  time = 0;

  while(time <= stun_duration) {
    a_potential_targets = getentitiesinradius(self.origin, 64, 15);

    foreach(zombie in a_potential_targets) {
      if(isalive(zombie) && isPlayer(player) && isDefined(var_4691e777)) {
        if(zombie == self) {
          if(zombie.zm_ai_category === # "special") {
            damage = zombie.maxhealth * 0.1;
          } else {
            damage = zombie.maxhealth * damage_percent;
          }
        } else {
          damage = zombie.maxhealth * 0.1;
        }

        zombie namespace_42457a0::function_601fabe9(#"electrical", damage, var_4691e777, player, undefined, "none", "MOD_AAT", 0, weapon);
      }

      waitframe(1);
    }

    time += 1;
    wait 1;
  }
}

function function_30c7f12c(player, s_params, tier, var_ebf63dce = 0) {
  self notify(#"deadwire_stunned");
  self endon(#"death", #"deadwire_stunned");
  waitframe(1);
  var_5c68bd89 = var_ebf63dce + 1;

  if(isactor(self) || isvehicle(self)) {
    self clientfield::set("zm_ammomod_deadwire_zap", var_5c68bd89);
  }

  if(var_ebf63dce >= 1) {
    self.tesla_damage_func = &function_13d4bcdf;
  }

  self lightning_chain::arc_damage_ent(s_params, 2, tier);
  wait 6;
  self thread function_ffe2bb2f();
}

function function_ffe2bb2f() {
  self endon(#"death", #"deadwire_stunned");
  waitframe(1);

  if(self flag::get(#"deadwire_stun")) {
    self flag::clear(#"deadwire_stun");
    self.var_9c33fa32 = undefined;

    if(isactor(self) || isvehicle(self)) {
      self clientfield::set("zm_ammomod_deadwire_zap", 0);
    }
  }
}

function function_742f2da3(damage = 0, attacker, weapon) {
  if(self flag::get(#"deadwire_stun")) {
    self.health = damage + 1;
    self thread function_851db518(attacker, weapon);
  }
}

function function_851db518(attacker, weapon) {
  self notify("4d0ff4a6c6cb4c74");
  self endon("4d0ff4a6c6cb4c74");
  self endon(#"death");
  self flag::wait_till_clear(#"deadwire_stun");

  if(!zm_utility::is_magic_bullet_shield_enabled(self)) {
    self.var_fc304017 = 1;
    self kill(self.origin, attacker, undefined, weapon, undefined, 1);
  }
}