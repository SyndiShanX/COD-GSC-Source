/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_stalingrad_finger_trap.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\scene_shared;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\zm_stalingrad_util;
#using scripts\zm\zm_stalingrad_vo;
#namespace zm_stalingrad_finger_trap;

function main() {
  level waittill("start_zombie_round_logic");
  level flag::init("finger_trap_on");
  level flag::init("finger_trap_cooldown");
  level function_7715178d();
}

function function_7715178d() {
  level thread scene::init("p7_fxanim_zm_stal_finger_trap_bundle");
  level.var_79dbe0dd = [];
  scene::add_scene_func("p7_fxanim_zm_stal_finger_trap_bundle", & function_2d729696, "init");
  var_bbadd4a4 = struct::get_array("finger_trap_activate", "targetname");
  array::thread_all(var_bbadd4a4, & function_eeb24547);
}

function function_2d729696(a_ents) {
  wait(1);
  t_left = getent("finger_damage_trig_left", "targetname");
  t_right = getent("finger_damage_trig_right", "targetname");
  level.var_79dbe0dd[0] = t_right;
  level.var_79dbe0dd[1] = t_left;
  t_left enablelinkto();
  t_right enablelinkto();
  t_left linkto(a_ents["trap_finger_left"], "tag_mid_animate");
  t_right linkto(a_ents["trap_finger_right"], "tag_mid_animate");
}

function function_eeb24547() {
  self zm_unitrigger::create_unitrigger("", 64, & function_512d92f4);
  self.s_unitrigger.hint_parm1 = 1500;
  self.s_unitrigger.require_look_at = 0;
  self thread function_891da2d8();
}

function function_512d92f4(e_player) {
  if(e_player.is_drinking > 0) {
    self sethintstring("");
    return false;
  }
  if(!level flag::get("power_on")) {
    self sethintstring(&"ZOMBIE_NEED_POWER");
    return false;
  }
  if(level flag::get("finger_trap_on")) {
    self sethintstring(&"ZOMBIE_TRAP_ACTIVE");
    return false;
  }
  if(level flag::get("finger_trap_cooldown")) {
    self sethintstring(&"ZM_STALINGRAD_TRAP_COOLDOWN");
    return false;
  }
  self sethintstring(&"ZM_STALINGRAD_FINGER_TRAP", self.stub.hint_parm1);
  return true;
}

function function_891da2d8() {
  while(true) {
    if(level flag::get("finger_trap_cooldown")) {
      level flag::wait_till_clear("finger_trap_cooldown");
    }
    self waittill("trigger_activated", e_who);
    if(!level flag::get("finger_trap_on") && !level flag::get("finger_trap_cooldown")) {
      if(!e_who zm_score::can_player_purchase(1500)) {
        zm_utility::play_sound_at_pos("no_purchase", self.origin);
        e_who zm_audio::create_and_play_dialog("general", "outofmoney");
      } else {
        level flag::set("finger_trap_on");
        e_who clientfield::increment_to_player("interact_rumble");
        e_who notify("hash_ad9aba38");
        e_who zm_score::minus_to_player_score(1500);
        self zm_stalingrad_util::function_903f6b36(1);
        level finger_trap_activate(e_who);
        self zm_stalingrad_util::function_903f6b36(0);
      }
    }
  }
}

function finger_trap_activate(var_3778532a) {
  var_3778532a thread zm_stalingrad_vo::function_c0914f1b();
  array::run_all(level.var_79dbe0dd, & triggerenable, 1);
  array::thread_all(level.var_79dbe0dd, & function_f5af37c6, var_3778532a);
  level function_88a65f39();
  array::run_all(level.var_79dbe0dd, & triggerenable, 0);
  level flag::clear("finger_trap_on");
  level flag::set("finger_trap_cooldown");
  level endon("hash_f8b849b9");
  wait(90);
  level flag::clear("finger_trap_cooldown");
}

function function_88a65f39() {
  n_start_time = gettime();
  n_total_time = 0;
  while(n_total_time < 15) {
    level scene::play("p7_fxanim_zm_stal_finger_trap_bundle");
    n_total_time = (gettime() - n_start_time) / 1000;
  }
}

function function_f5af37c6(var_3778532a) {
  level endon("finger_trap_cooldown");
  while(true) {
    self waittill("trigger", e_who);
    if(!(isDefined(e_who.var_bd3a4420) && e_who.var_bd3a4420)) {
      if(e_who.health <= 20000) {
        if(!isplayer(e_who) && isDefined(var_3778532a)) {
          var_3778532a notify("hash_2637f64f");
          var_3778532a zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_KILL_TRAP");
        }
        if(e_who.archetype === "zombie") {
          e_who thread zombie_utility::zombie_gut_explosion();
        }
      } else if(!isplayer(e_who)) {
        e_who.var_bd3a4420 = 1;
        e_who thread function_fe885d6b();
      }
      if(isplayer(e_who) && e_who issliding()) {
        continue;
      }
      e_who dodamage(20000, e_who.origin, self, undefined, "none", "MOD_IMPACT");
    }
  }
}

function function_fe885d6b() {
  self endon("death");
  wait(0.25);
  self.var_bd3a4420 = undefined;
}

function function_ddb9991b() {
  if(!level flag::get("")) {
    level flag::set("");
    level flag::clear("");
    level notify("hash_f8b849b9");
    level finger_trap_activate(level.players[0]);
  }
}

function function_fc99caf5() {
  if(level flag::get("")) {
    level flag::clear("");
    level notify("hash_f8b849b9");
  }
}