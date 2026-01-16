/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_mansion_trap_werewolfer.gsc
***********************************************/

#include scripts\core_common\ai\zombie_death;
#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\fx_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\status_effects\status_effect_util;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\throttle_shared;
#include scripts\core_common\util_shared;
#include scripts\zm\weapons\zm_weap_riotshield;
#include scripts\zm\zm_mansion_util;
#include scripts\zm\zm_mansion_ww_lvl2_quest;
#include scripts\zm\zm_trap_electric;
#include scripts\zm_common\util\ai_werewolf_util;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_contracts;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_items;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_traps;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;

#namespace zm_trap_werewolfer;

autoexec __init__system__() {
  system::register(#"zm_trap_werewolfer", &__init__, &__main__, undefined);
}

__init__() {
  if(!zm_custom::function_901b751c(#"zmtrapsenabled")) {
    return;
  }

  level._effect[#"werewolfer_impact"] = #"hash_6e44fde5d49cfc9b";
  zm_traps::register_trap_basic_info("werewolfer", &function_670dda89, &zm_trap_electric::trap_audio);
  zm_traps::register_trap_damage("werewolfer", &function_436d9a24, &ai_damage);
  level flag::init(#"hash_2287cf5d6310237e");
  level flag::init(#"hash_6f483dda6f8ab19d");

  if(!isDefined(level.var_7aa02c24)) {
    level.var_7aa02c24 = new throttle();
    [[level.var_7aa02c24]] - > initialize(2, 0.1);
  }
}

__main__() {
  if(!zm_custom::function_901b751c(#"zmtrapsenabled")) {
    return;
  }

  level flag::wait_till("all_players_spawned");
  level.var_4cca20a9 = getent("mdl_ww_trap_machine", "targetname");
  level.var_4cca20a9 clientfield::set("" + #"hash_17df66ef5f71c0de", 1);
}

function_670dda89() {
  level.var_4fe07a = self;
  self._trap_duration = 10;
  self._trap_cooldown_time = 30;

  if(isDefined(level.sndtrapfunc)) {
    level thread[[level.sndtrapfunc]](self, 1);
  }

  level notify(#"traps_activated", {
    #var_be3f58a: self.script_string
  });
  level flag::set(#"hash_6f483dda6f8ab19d");
  level thread function_408fcb87();
  level exploder::exploder("fxexp_ele_trap_activate");

  if(!isDefined(self.mdl_handle)) {
    self.mdl_handle = getent("mdl_ww_trap_lever", "targetname");
  }

  self.mdl_handle rotatepitch(90, 0.5);
  level.var_4cca20a9 clientfield::set("" + #"hash_17df66ef5f71c0de", 2);
  fx_points = struct::get_array(self.target, "targetname");

  for(i = 0; i < fx_points.size; i++) {
    util::wait_network_frame();
    fx_points[i] thread zm_trap_electric::trap_audio(self);
  }

  self thread zm_traps::trap_damage();
  self waittilltimeout(self._trap_duration, #"trap_deactivate");
  self notify(#"trap_done");
  level exploder::stop_exploder("fxexp_ele_trap_activate");
  level flag::clear(#"hash_6f483dda6f8ab19d");
  self thread function_38b44aab();
}

function_408fcb87() {
  t_trap = getent("werewolfer", "script_noteworthy");

  while(level flag::get(#"hash_6f483dda6f8ab19d")) {
    foreach(player in getplayers()) {
      if(isDefined(player) && player istouching(t_trap) && player.currentweapon === getweapon(#"zhield_dw")) {
        player riotshield::player_damage_shield(5);
      }
    }

    wait 0.25;
  }
}

function_38b44aab() {
  level notify(#"traps_cooldown", {
    #var_be3f58a: self.script_string
  });
  n_cooldown = zm_traps::function_da13db45(self._trap_cooldown_time, self.activated_by_player);
  wait n_cooldown;
  self.mdl_handle rotatepitch(-90, 0.5);
  wait 0.5;
  level.var_4cca20a9 clientfield::set("" + #"hash_17df66ef5f71c0de", 1);
  level notify(#"traps_available", {
    #var_be3f58a: self.script_string
  });
}

function_436d9a24(t_damage) {
  shock_status_effect = getstatuseffect(#"hash_19533caf858a9f3b");

  if(!(isDefined(self.b_no_trap_damage) && self.b_no_trap_damage)) {
    self thread zm_traps::player_elec_damage(t_damage);
    status_effect::status_effect_apply(shock_status_effect, undefined, self, 0);
  }
}

ai_damage(e_trap) {
  self endon(#"death");

  if(self.subarchetype === #"catalyst_electric") {
    return;
  }

  if(self.team === #"allies") {
    return;
  }

  if(self.archetype === #"blight_father") {
    e_trap notify(#"trap_deactivate");
    return;
  }

  if(isDefined(self.var_3e60a85e) && self.var_3e60a85e) {
    return;
  }

  self.var_3e60a85e = 1;

  if(isDefined(e_trap.activated_by_player) && isplayer(e_trap.activated_by_player)) {
    e_trap.activated_by_player zm_stats::increment_challenge_stat(#"zombie_hunter_kill_trap");
    e_trap.activated_by_player contracts::increment_zm_contract(#"contract_zm_trap_kills");

    if(isDefined(e_trap.activated_by_player.var_a8049e3d)) {
      e_trap.activated_by_player.var_a8049e3d++;
      e_trap.activated_by_player notify(#"zombie_zapped");
    }
  }

  self fx::play("werewolfer_impact", self.origin, self.angles, "death");
  playsoundatposition(#"wpn_zmb_electrap_zap", self.origin);

  if(self.archetype === #"werewolf") {
    self thread zm_traps::electroctute_death_fx();
    self thread zm_traps::play_elec_vocals();
    self function_a3059f6(e_trap);
  } else if(self.archetype === #"zombie") {
    refs[0] = "guts";
    refs[1] = "right_arm";
    refs[2] = "left_arm";
    refs[3] = "right_leg";
    refs[4] = "left_leg";
    refs[5] = "no_legs";
    refs[6] = "head";
    self.a.gib_ref = refs[randomint(refs.size)];

    if(randomint(100) > 50) {
      self thread zm_traps::electroctute_death_fx();
      self thread zm_traps::play_elec_vocals();
    }

    bhtnactionstartevent(self, "electrocute");
    self notify(#"bhtn_action_notify", {
      #action: "electrocute"
    });
    wait randomfloat(1.25);
    self function_a3059f6(e_trap);
  } else {
    self function_a3059f6(e_trap);
  }

  wait 2;
  self.var_3e60a85e = undefined;
}

function_a3059f6(e_trap) {
  self endon(#"death");
  [[level.var_7aa02c24]] - > waitinqueue(self);

  if(isDefined(self.var_5475b4ad)) {
    self[[self.var_5475b4ad]](e_trap);
    return;
  }

  if(self.archetype === #"werewolf") {
    n_damage = self.health + 100;
  } else {
    n_damage = 20000;
  }

  if(self.health < n_damage) {
    level notify(#"trap_kill", {
      #victim: self, 
      #e_trap: e_trap
    });

    if(self.archetype === #"werewolf" && isDefined(e_trap.activated_by_player)) {
      e_trap.activated_by_player notify(#"hash_510f9114e7a6300c");
    }
  }

  self dodamage(n_damage, e_trap.origin, undefined, e_trap, undefined, "MOD_ELECTROCUTED", 0, undefined);
}

function_2b9a3abe() {
  if(isDefined(level.var_4fe07a)) {
    if(level.var_4fe07a._trap_in_use) {
      level.var_4fe07a notify(#"trap_done");
      level.var_4fe07a._trap_cooldown_time = 0.05;
      level.var_4fe07a waittill(#"available");
    }

    if(level.var_4fe07a._trap_use_trigs.size > 0) {
      foreach(trig in level.var_4fe07a._trap_use_trigs) {
        trig triggerenable(0);
      }
    }
  }
}