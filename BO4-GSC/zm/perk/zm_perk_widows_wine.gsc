/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_widows_wine.gsc
***********************************************/

#include script_24c32478acf44108;
#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_melee_weapon;
#include scripts\zm_common\zm_perks;
#include scripts\zm_common\zm_powerups;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_utility;

#namespace zm_perk_widows_wine;

autoexec __init__system__() {
  system::register(#"zm_perk_widows_wine", &__init__, undefined, undefined);
}

__init__() {
  enable_widows_wine_perk_for_level();
  namespace_9ff9f642::register_slowdown(#"hash_54016f8b03c9745e", 0.7, 12);
  namespace_9ff9f642::register_slowdown(#"hash_6b28a9e80349ad7e", 0.8, 6);
  namespace_9ff9f642::register_slowdown(#"hash_fa4899571ae8dbd", 0.85, 3);
}

enable_widows_wine_perk_for_level() {
  if(function_8b1a219a()) {
    zm_perks::register_perk_basic_info(#"specialty_widowswine", #"perk_widows_wine", 3000, #"hash_618fdb0398552569", getweapon("zombie_perk_bottle_widows_wine"), getweapon("zombie_perk_totem_winters_wail"), #"zmperkswidowswail");
  } else {
    zm_perks::register_perk_basic_info(#"specialty_widowswine", #"perk_widows_wine", 3000, #"zombie/perk_widowswine", getweapon("zombie_perk_bottle_widows_wine"), getweapon("zombie_perk_totem_winters_wail"), #"zmperkswidowswail");
  }

  zm_perks::register_perk_precache_func(#"specialty_widowswine", &widows_wine_precache);
  zm_perks::register_perk_clientfields(#"specialty_widowswine", &widows_wine_register_clientfield, &widows_wine_set_clientfield);
  zm_perks::register_perk_machine(#"specialty_widowswine", &widows_wine_perk_machine_setup);
  zm_perks::register_perk_host_migration_params(#"specialty_widowswine", "vending_widowswine", "widow_light");
  zm_perks::register_perk_threads(#"specialty_widowswine", &widows_wine_perk_activate, &widows_wine_perk_lost, &reset_charges);

  if(isDefined(level.custom_widows_wine_perk_threads) && level.custom_widows_wine_perk_threads) {
    level thread[[level.custom_widows_wine_perk_threads]]();
  }

  init_widows_wine();
}

widows_wine_precache() {
  if(isDefined(level.var_ea6a217f)) {
    [[level.var_ea6a217f]]();
    return;
  }

  level._effect[#"widow_light"] = "zombie/fx_perk_widows_wine_zmb";
  level.machine_assets[#"specialty_widowswine"] = spawnStruct();
  level.machine_assets[#"specialty_widowswine"].weapon = getweapon("zombie_perk_bottle_widows_wine");
  level.machine_assets[#"specialty_widowswine"].off_model = "p7_zm_vending_widows_wine";
  level.machine_assets[#"specialty_widowswine"].on_model = "p7_zm_vending_widows_wine";
}

widows_wine_register_clientfield() {
  clientfield::register("actor", "winters_wail_freeze", 1, 1, "int");
  clientfield::register("vehicle", "winters_wail_freeze", 1, 1, "int");
  clientfield::register("allplayers", "winters_wail_explosion", 1, 1, "counter");
  clientfield::register("allplayers", "winters_wail_slow_field", 1, 1, "int");
}

widows_wine_set_clientfield(state) {}

widows_wine_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision) {
  use_trigger.script_sound = "mus_perks_widow_jingle";
  use_trigger.script_string = "widowswine_perk";
  use_trigger.script_label = "mus_perks_widow_sting";
  use_trigger.target = "vending_widowswine";
  perk_machine.script_string = "widowswine_perk";
  perk_machine.targetname = "vending_widowswine";

  if(isDefined(bump_trigger)) {
    bump_trigger.script_string = "widowswine_perk";
  }
}

init_widows_wine() {
  zm_perks::register_perk_damage_override_func(&widows_wine_damage_callback);
}

widows_wine_perk_activate() {
  self.var_828492e6 = zm_perks::function_c1efcc57(#"specialty_widowswine");
  self reset_charges();
  self thread function_bcb4c0e3();
  self thread function_b2e5df58();
}

widows_wine_contact_explosion() {
  self endon(#"disconnect");
  level endon(#"end_game");
  self clientfield::increment("winters_wail_explosion");
  a_ai_targets = self getenemiesinradius(self.origin, 256);
  a_ai_targets = arraysortclosest(a_ai_targets, self.origin);

  foreach(ai_target in a_ai_targets) {
    b_freeze = 0;

    if(!isDefined(ai_target)) {
      continue;
    }

    if(!isDefined(ai_target.zm_ai_category)) {
      continue;
    }

    switch (ai_target.zm_ai_category) {
      case #"heavy":
        var_3e5502b5 = #"hash_6b28a9e80349ad7e";
        var_ca6267ad = 6;
        break;
      case #"miniboss":
        var_3e5502b5 = #"hash_fa4899571ae8dbd";
        var_ca6267ad = 3;
        break;
      case #"boss":
        continue;
      default:
        var_3e5502b5 = #"hash_54016f8b03c9745e";
        var_ca6267ad = 12;
        b_freeze = 1;
        break;
    }

    n_dist_sq = distancesquared(self.origin, ai_target.origin);

    if(b_freeze && n_dist_sq <= 10000) {
      ai_target thread function_5c114d09(self);
    } else {
      ai_target thread widows_wine_slow_zombie(self, var_3e5502b5, var_ca6267ad);
    }

    waitframe(1);
  }

  if(!self hasperk(#"specialty_widowswine")) {
    return;
  }

  self.var_a33a5a37--;
  self zm_perks::function_2ac7579(self.var_828492e6, 2, #"perk_widows_wine");
  self zm_perks::function_f2ff97a6(self.var_828492e6, self.var_a33a5a37, #"perk_widows_wine");

  if(self hasperk(#"specialty_mod_widowswine")) {
    self thread function_c6366dbe();
  }
}

function_c6366dbe() {
  self notify(#"start_slow_field");
  self endoncallback(&function_10519783, #"disconnect", #"player_downed", #"start_slow_field");
  level endoncallback(&function_10519783, #"end_game");
  n_end_time = gettime() + int(5 * 1000);
  self clientfield::set("winters_wail_slow_field", 1);

  while(gettime() < n_end_time) {
    a_ai = self getenemiesinradius(self.origin, 256);

    foreach(ai in a_ai) {
      if(!isDefined(ai.zm_ai_category)) {
        continue;
      }

      switch (ai.zm_ai_category) {
        case #"heavy":
          var_3e5502b5 = #"hash_6b28a9e80349ad7e";
          var_ca6267ad = 6;
          break;
        case #"miniboss":
          var_3e5502b5 = #"hash_fa4899571ae8dbd";
          var_ca6267ad = 3;
          break;
        case #"boss":
          continue;
        default:
          var_3e5502b5 = #"hash_54016f8b03c9745e";
          var_ca6267ad = 12;
          break;
      }

      ai thread widows_wine_slow_zombie(self, var_3e5502b5, var_ca6267ad);
    }

    wait 0.1;
  }

  self thread function_10519783();
}

function_10519783(var_c34665fc) {
  if(isDefined(var_c34665fc) && (var_c34665fc == "disconnect" || var_c34665fc == "start_slow_field")) {
    return;
  }

  if(isplayer(self)) {
    self clientfield::set("winters_wail_slow_field", 0);
    return;
  }

  array::thread_all(level.players, &clientfield::set, "winters_wail_slow_field", 0);
}

widows_wine_vehicle_damage_response(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(isDefined(weapon) && weapon == level.w_widows_wine_grenade && !(isDefined(self.b_widows_wine_cocoon) && self.b_widows_wine_cocoon)) {
    self thread widows_wine_vehicle_behavior(eattacker, weapon);
    return 0;
  }

  return idamage;
}

widows_wine_damage_callback(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime) {
  if(self hasperk(#"specialty_widowswine") && self has_charge() && !self bgb::is_enabled(#"zm_bgb_burned_out")) {
    if(smeansofdeath == "MOD_MELEE" && isai(eattacker) || smeansofdeath == "MOD_EXPLOSIVE" && isvehicle(eattacker)) {
      if(level.gamedifficulty == 3 || !(isDefined(eattacker.var_1c33120d) && eattacker.var_1c33120d) && self.maxhealth != self.health) {
        self thread widows_wine_contact_explosion();
      }
    }
  }
}

function_5c114d09(e_player) {
  self notify(#"widows_wine_cocoon");
  self endon(#"widows_wine_cocoon");

  if(isDefined(self.kill_on_wine_coccon) && self.kill_on_wine_coccon) {
    self kill();
    return;
  }

  if(!(isDefined(self.b_widows_wine_cocoon) && self.b_widows_wine_cocoon)) {
    self.b_widows_wine_cocoon = 1;
    self.e_widows_wine_player = e_player;
    self namespace_9ff9f642::freeze();
    self.var_e8920729 = 1;
    self clientfield::set("winters_wail_freeze", 1);
  }

  self waittilltimeout(16, #"death");

  if(!isDefined(self)) {
    return;
  }

  self namespace_9ff9f642::unfreeze();
  self.b_widows_wine_cocoon = undefined;
  self.var_e8920729 = 0;

  if(!(isDefined(self.b_widows_wine_slow) && self.b_widows_wine_slow)) {
    self clientfield::set("winters_wail_freeze", 0);
  }
}

widows_wine_slow_zombie(e_player, var_3e5502b5, var_ca6267ad) {
  self notify(#"widows_wine_slow");
  self endon(#"widows_wine_slow");

  if(isDefined(self.b_widows_wine_cocoon) && self.b_widows_wine_cocoon) {
    self thread function_5c114d09(e_player);
    self.b_widows_wine_slow = undefined;
    return;
  }

  if(!(isDefined(self.b_widows_wine_slow) && self.b_widows_wine_slow)) {
    self.b_widows_wine_slow = 1;
    self clientfield::set("winters_wail_freeze", 1);
  }

  self thread namespace_9ff9f642::slowdown(var_3e5502b5);
  self waittilltimeout(var_ca6267ad, #"death");

  if(!isDefined(self)) {
    return;
  }

  self.b_widows_wine_slow = undefined;

  if(!(isDefined(self.b_widows_wine_cocoon) && self.b_widows_wine_cocoon)) {
    self clientfield::set("winters_wail_freeze", 0);
  }
}

widows_wine_vehicle_behavior(attacker, weapon) {
  self endon(#"death");
  self.b_widows_wine_cocoon = 1;

  if(isDefined(self.archetype)) {
    if(self.archetype == #"raps") {
      self clientfield::set("winters_wail_freeze", 1);
      self._override_raps_combat_speed = 5;
      wait 6;
      self dodamage(self.health + 1000, self.origin, attacker, undefined, "none", "MOD_EXPLOSIVE", 0, weapon);
      return;
    }

    if(self.archetype == #"parasite") {
      waitframe(1);
      self dodamage(self.maxhealth, self.origin);
    }
  }
}

widows_wine_perk_lost(b_pause, str_perk, str_result, n_slot) {
  self notify(#"stop_widows_wine");
  self endon(#"death");
  assert(isDefined(self.var_828492e6), "<dev string:x38>");

  if(isDefined(self.var_828492e6)) {
    self zm_perks::function_13880aa5(self.var_828492e6, 0, #"perk_widows_wine");
    self zm_perks::function_f2ff97a6(self.var_828492e6, 0, #"perk_widows_wine");
    self.var_828492e6 = undefined;
  }
}

has_charge() {
  if(isDefined(self.var_a33a5a37) && self.var_a33a5a37 > 0) {
    return true;
  }

  return false;
}

function_fc256a55() {
  if(self hasperk(#"specialty_mod_widowswine")) {
    return 4;
  }

  return 3;
}

function_276e3360() {
  n_total_charges = self function_fc256a55();
  return 1 / n_total_charges;
}

function_bcb4c0e3() {
  self endon(#"stop_widows_wine", #"death");

  while(true) {
    wait 1;
    n_total_charges = self function_fc256a55();

    if(self.var_a33a5a37 < n_total_charges) {
      self.var_8376b1a += 1 / 60;

      if(self.var_8376b1a >= 1) {
        self.var_a33a5a37++;
        self.var_8376b1a = 0;
      }
    } else if(self.var_a33a5a37 > n_total_charges) {
      self.var_a33a5a37 = n_total_charges;
    }

    self function_2de8f9a5();
  }
}

function_2de8f9a5() {
  if(self hasperk(#"specialty_widowswine")) {
    self zm_perks::function_f2ff97a6(self.var_828492e6, self.var_a33a5a37, #"perk_widows_wine");
    n_progress = self.var_8376b1a;

    if(self.var_a33a5a37 == self function_fc256a55()) {
      n_progress = 1;
      self zm_perks::function_2ac7579(self.var_828492e6, 1, #"perk_widows_wine");
    } else {
      self zm_perks::function_2ac7579(self.var_828492e6, 2, #"perk_widows_wine");
    }

    self zm_perks::function_13880aa5(self.var_828492e6, n_progress, #"perk_widows_wine");
  }
}

reset_charges() {
  self.var_8376b1a = 0;
  self.var_a33a5a37 = self function_fc256a55();
  self function_2de8f9a5();
}

function_b2e5df58() {
  self endon(#"stop_widows_wine", #"death");

  while(true) {
    level waittill(#"end_of_round");
    self reset_charges();
  }
}