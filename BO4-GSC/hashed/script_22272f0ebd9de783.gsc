/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_22272f0ebd9de783.gsc
***********************************************/

#include scripts\core_common\ai\zombie_death;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\lui_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm\zm_towers_util;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_contracts;
#include scripts\zm_common\zm_round_logic;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_stats;
#include scripts\zm_common\zm_traps;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;

#namespace namespace_a5b1b1d7;

autoexec __init__system__() {
  system::register(#"hash_55c1d88784016490", &__init__, &__main__, undefined);
}

__init__() {
  level thread function_286b5fa9();
  callback::on_finalize_initialization(&init);
}

__main__() {}

init() {
  callback::on_connect(&function_96e29e5f);
}

function_96e29e5f() {}

function_286b5fa9() {
  level.var_6024289d = getEntArray("trap_blade_pillar", "script_label");
  a_zombie_traps = getEntArray("zombie_trap", "targetname");
  level.var_5f47f17d = array::filter(a_zombie_traps, 0, &function_f0f82833);

  foreach(var_dabb9a97 in level.var_5f47f17d) {
    var_dabb9a97 function_d8e7a5e6();
  }

  zm_traps::register_trap_basic_info("blade_pillar", &function_8fe2d903, &function_96f77ea4);
  zm_traps::register_trap_damage("blade_pillar", &player_damage, &damage);
}

function_f0f82833(e_ent) {
  return e_ent.script_noteworthy == "blade_pillar";
}

function_d8e7a5e6() {
  self flag::init("activated");
  soul_whale = arraygetclosest(self.origin, level.var_6024289d);
  soul_whale flag::init("activated");
  self zm_traps::function_19d61a68();
  soul_whale.var_48698f89 = soul_whale.origin;
  soul_whale.var_ab34489f = soul_whale.angles;
  self.soul_whale = soul_whale;
}

function_8fe2d903() {
  self._trap_duration = 30;
  self._trap_cooldown_time = 60;

  if(isDefined(level.sndtrapfunc)) {
    level thread[[level.sndtrapfunc]](self, 1);
  }

  self notify(#"trap_activate");
  level notify(#"trap_activate", self);
  self.activated_by_player thread function_45a2294f(self.script_string);

  foreach(t_trap in level.var_5f47f17d) {
    if(t_trap.script_string === self.script_string) {
      var_deed061f = getEntArray(t_trap.target, "targetname");
      mdl_trap = getent(var_deed061f[0].target, "targetname");
      mdl_trap scene::play("p8_fxanim_zm_towers_trap_blade_01_bundle", "Shot 1", mdl_trap);
      mdl_trap thread scene::play("p8_fxanim_zm_towers_trap_blade_01_bundle", "Shot 2", mdl_trap);
      t_trap thread zm_traps::trap_damage();
    }
  }

  self waittilltimeout(self._trap_duration, #"trap_deactivate");

  foreach(t_trap in level.var_5f47f17d) {
    if(t_trap.script_string === self.script_string) {
      var_deed061f = getEntArray(t_trap.target, "targetname");
      mdl_trap = getent(var_deed061f[0].target, "targetname");
      mdl_trap thread scene::play("p8_fxanim_zm_towers_trap_blade_01_bundle", "Shot 3", mdl_trap);
      t_trap notify(#"trap_done");
    }
  }
}

function_96f77ea4() {}

function_45a2294f(str_id) {
  foreach(e_pillar in level.var_6024289d) {
    if(e_pillar.script_string === str_id) {
      e_pillar thread activate_trap(self);
      level.var_a6b89158 = getent(e_pillar.target, "targetname");
      level.var_a6b89158 thread function_6f34f900();
    }
  }

  level notify(#"traps_activated", {
    #var_be3f58a: str_id
  });
  wait 30;
  level notify(#"traps_cooldown", {
    #var_be3f58a: str_id
  });
  n_cooldown = zm_traps::function_da13db45(60, self);
  wait n_cooldown;
  level notify(#"traps_available", {
    #var_be3f58a: str_id
  });
}

function_6f34f900() {
  level endon(#"traps_cooldown");

  while(true) {
    s_info = self waittill(#"trigger");
    e_player = s_info.activator;

    if(!isplayer(e_player)) {
      continue;
    }

    if(!e_player issliding()) {
      continue;
    }

    var_82cc90a0 = e_player.health;
    wait 0.85;

    if(isDefined(e_player) && var_82cc90a0 == e_player.health) {
      e_player notify(#"hash_731c84be18ae9fa3");
    }
  }
}

activate_trap(e_player) {
  if(!self flag::get("activated")) {
    self flag::set("activated");

    if(isDefined(e_player)) {
      self.activated_by_player = e_player;
    }
  }
}

deactivate_trap(e_trap) {
  e_trap notify(#"trap_deactivate");
  self flag::clear("activated");
  self notify(#"deactivate");
}

damage(e_trap) {
  if(!isalive(self) || self.archetype === #"tiger" || isvehicle(self)) {
    return;
  }

  if(self.zm_ai_category === #"miniboss" || self.zm_ai_category === #"heavy") {
    e_trap.soul_whale deactivate_trap(e_trap);

    if(isDefined(e_trap.activated_by_player)) {
      e_trap.activated_by_player notify(#"hash_74fc45698491be88");
    }

    return;
  }

  self.marked_for_death = 1;

  if(isDefined(e_trap.activated_by_player) && isplayer(e_trap.activated_by_player)) {
    e_trap.activated_by_player zm_stats::increment_challenge_stat(#"zombie_hunter_kill_trap");
    e_trap.activated_by_player contracts::increment_zm_contract(#"contract_zm_trap_kills");
  }

  v_away = self.origin - e_trap.origin;
  v_away = vectornormalize((v_away[0], v_away[1], 0)) * 64;
  v_dest = self.origin + v_away;
  level notify(#"trap_kill", {
    #e_victim: self, 
    #e_trap: e_trap
  });
  self dodamage(self.health + 666, self.origin, e_trap);
  self thread function_373d49f(v_dest, 0.25, 0, 0.125);
  self thread zm_towers_util::function_ae1b4f5b(90, 75, 25);
}

player_damage(t_damage) {
  self endon(#"death");

  if(self getstance() == "stand" && !self issliding()) {
    n_damage = 50;

    if(zm_utility::is_standard()) {
      n_damage *= 0.5;
    }

    if(zm_utility::is_ee_enabled() && self flag::get(#"hash_6757075afacfc1b4")) {
      n_damage *= 0.5;
    }

    self dodamage(n_damage, self.origin, undefined, t_damage);
    wait 0.1;
    self.is_burning = undefined;
  }

  self setstance("crouch");
}

function_373d49f(v_dest, n_time = 1, n_accel = 0, var_99997505 = 0) {
  if(isplayer(self)) {
    var_3fba37cd = util::spawn_model("tag_origin", self.origin, self.angles);
    self linkto(var_3fba37cd);
    var_3fba37cd moveto(v_dest, n_time, n_accel, var_99997505);
    var_3fba37cd waittill(#"movedone");
    var_3fba37cd delete();
    return;
  }

  v_direction = vectornormalize(v_dest);
  v_force = v_direction * 64;
  self startragdoll();
  self launchragdoll(v_force);
}