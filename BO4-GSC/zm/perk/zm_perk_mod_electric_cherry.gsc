/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_mod_electric_cherry.gsc
***************************************************/

#include scripts\core_common\ai_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\values_shared;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_challenges;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_stats;

#namespace zm_perk_mod_electric_cherry;

autoexec __init__system__() {
  system::register(#"zm_perk_mod_electric_cherry", &__init__, undefined, undefined);
}

__init__() {
  function_82ad2d27();
}

function_82ad2d27() {
  zm_perks::register_perk_mod_basic_info(#"specialty_mod_electriccherry", "mod_electric_cherry", #"perk_electric_cherry", #"specialty_electriccherry", 4000);
  zm_perks::register_perk_threads(#"specialty_mod_electriccherry", &function_4b44aa37, &function_cfba6046, &function_b107ce52);
  zm_perks::register_actor_damage_override(#"specialty_mod_electriccherry", &function_f6515ba2);
}

electric_cherry_death_fx() {
  self endon(#"death");

  if(!(isDefined(self.head_gibbed) && self.head_gibbed)) {
    if(isvehicle(self)) {
      self clientfield::set("tesla_shock_eyes_fx_veh", 1);
    } else {
      self clientfield::set("tesla_shock_eyes_fx", 1);
    }

    return;
  }

  if(isvehicle(self)) {
    self clientfield::set("tesla_death_fx_veh", 1);
    return;
  }

  self clientfield::set("tesla_death_fx", 1);
}

electric_cherry_shock_fx() {
  self endon(#"death");

  if(isvehicle(self)) {
    self clientfield::set("tesla_shock_eyes_fx_veh", 1);
  } else {
    self clientfield::set("tesla_shock_eyes_fx", 1);
  }

  self waittill(#"stun_fx_end");

  if(isvehicle(self)) {
    self clientfield::set("tesla_shock_eyes_fx_veh", 0);
    return;
  }

  self clientfield::set("tesla_shock_eyes_fx", 0);
}

electric_cherry_stun() {
  self endon(#"death");
  self notify(#"stun_zombie");
  self endon(#"stun_zombie");

  if(self.health <= 0) {

    iprintln("<dev string:x38>");

      return;
  }

  self ai::stun();
  self val::set(#"electric_cherry_stun", "ignoreall", 1);
  wait 4;

  if(isDefined(self)) {
    self ai::clear_stun();
    self val::reset(#"electric_cherry_stun", "ignoreall");
    self notify(#"stun_fx_end");
  }
}

electric_cherry_reload_attack() {
  self endon(#"death", #"specialty_mod_electriccherry" + "_take");
  self.consecutive_electric_cherry_attacks = 0;
  self.var_c25a91ee = 0;

  if(!isDefined(self.var_dbaad7dd)) {
    self.var_dbaad7dd = 10;
  }

  self function_4debd1a8();

  while(true) {
    s_results = self waittill(#"reload_start");
    w_current = self getcurrentweapon();
    n_clip_current = self getweaponammoclip(w_current);
    n_clip_max = w_current.clipsize;
    self thread check_for_reload_complete(w_current, n_clip_current, n_clip_max);

    if(isDefined(self)) {
      self notify(#"hash_54480fc7f7e6f243");
    }
  }
}

check_for_reload_complete(weapon, n_clip_current, n_clip_max) {
  self endon(#"death", #"specialty_mod_electriccherry" + "_take", "player_lost_weapon_" + weapon.name);

  while(true) {
    self waittill(#"reload");
    current_weapon = self getcurrentweapon();

    if(current_weapon == weapon && !weapon.isabilityweapon) {
      self thread function_97a7641d(weapon, n_clip_current, n_clip_max);
      break;
    }
  }
}

function_f6515ba2(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(meansofdeath == "MOD_MELEE" && attacker.var_dbaad7dd > 0) {
    if(!attacker.var_c25a91ee) {
      attacker thread function_81622feb();
    }

    var_5a8c565a = damage * 3;

    if(self.archetype === #"zombie" || self.archetype === #"catalyst") {
      self thread electric_cherry_death_fx();

      attacker zm_challenges::debug_print("<dev string:x57>");

        attacker zm_stats::increment_challenge_stat(#"perk_electric_cherry_kills");
      return self.health;
    } else if(self.health <= var_5a8c565a) {
      self thread electric_cherry_death_fx();

      attacker zm_challenges::debug_print("<dev string:x57>");

        attacker zm_stats::increment_challenge_stat(#"perk_electric_cherry_kills");
      return var_5a8c565a;
    } else {
      self thread electric_cherry_stun();
      self thread electric_cherry_shock_fx();
      return var_5a8c565a;
    }
  }

  return damage;
}

function_97a7641d(w_current, n_clip_current, n_clip_max) {
  n_fraction = n_clip_current / n_clip_max;

  if(n_fraction == 0) {
    n_time = 10;
  } else {
    n_time = 10 - n_fraction * 10;
  }

  if(n_time < 2) {
    return;
  }

  self thread function_a2ba8a6c(n_time);
}

function_a2ba8a6c(n_time) {
  if(self.var_dbaad7dd < n_time) {
    self.var_dbaad7dd = n_time;
    self function_4debd1a8();
  }
}

function_4debd1a8() {
  self zm_perks::function_c8c7bc5(3, self.var_dbaad7dd > 0, #"perk_electric_cherry");
  n_counter = math::clamp(self.var_dbaad7dd, 0, 10);
  n_counter /= 10;
  self zm_perks::function_13880aa5(3, n_counter, #"perk_electric_cherry");
}

function_81622feb() {
  self notify(#"hash_2e9b55fc4344af57");
  self endon(#"disconnect", #"hash_2e9b55fc4344af57");
  self thread function_857ced89();
  wait self.var_dbaad7dd;
  self playsoundtoplayer(#"hash_ea37a7d6cf6bfb3", self);
  self notify(#"hash_5435513976a87bce");
  self.var_c25a91ee = 0;
  self zm_perks::function_c8c7bc5(3, 0, #"perk_electric_cherry");
  self.var_dbaad7dd = 0;
  self zm_perks::function_13880aa5(3, 0, #"perk_electric_cherry");
}

function_4b44aa37() {
  self zm_perks::function_f0ac059f(3, 1, #"perk_electric_cherry");
  self thread electric_cherry_reload_attack();
}

function_857ced89() {
  self endon(#"disconnect", #"hash_1549266f638bd78f", #"hash_5435513976a87bce", #"hash_2e9b55fc4344af57");
  self.var_c25a91ee = 1;
  self playsoundtoplayer(#"hash_2283cbfbc6b9e736", self);
  var_9ade76c0 = self.var_dbaad7dd;
  n_time_left = var_9ade76c0;
  var_8b3ae2d6 = var_9ade76c0 / 10;
  self zm_perks::function_13880aa5(3, var_8b3ae2d6, #"perk_electric_cherry");

  while(true) {
    wait 0.1;
    n_time_left -= 0.1;
    n_time_left = math::clamp(n_time_left, 0, var_9ade76c0);
    n_percentage = n_time_left / var_9ade76c0;
    n_percentage *= var_8b3ae2d6;
    n_percentage = math::clamp(n_percentage, 0.02, var_9ade76c0);
    self zm_perks::function_13880aa5(3, n_percentage, #"perk_electric_cherry");
  }
}

function_b107ce52() {
  if(!isDefined(self.var_dbaad7dd)) {
    self.var_dbaad7dd = 0;
  }

  self function_a2ba8a6c(10);

  if(isDefined(self.var_c25a91ee) && self.var_c25a91ee) {
    self thread function_81622feb();
  }
}

function_cfba6046(b_pause, str_perk, str_result, n_slot) {
  self notify(#"specialty_mod_electriccherry" + "_take");
  self.var_c25a91ee = undefined;
  self zm_perks::function_c8c7bc5(3, 0, #"perk_electric_cherry");
  self zm_perks::function_f0ac059f(3, 0, #"perk_electric_cherry");
  self zm_perks::function_13880aa5(3, 0, #"perk_electric_cherry");
}