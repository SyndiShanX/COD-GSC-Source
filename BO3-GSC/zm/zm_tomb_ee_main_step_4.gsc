/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_tomb_ee_main_step_4.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\hud_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_sidequests;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\zm_tomb_chamber;
#using scripts\zm\zm_tomb_ee_main;
#using scripts\zm\zm_tomb_utility;
#using scripts\zm\zm_tomb_vo;
#namespace zm_tomb_ee_main_step_4;

function init() {
  zm_sidequests::declare_sidequest_stage("little_girl_lost", "step_4", & init_stage, & stage_logic, & exit_stage);
}

function init_stage() {
  level._cur_stage_name = "step_4";
  level.ee_mech_zombies_killed = 0;
  level.ee_mech_zombies_alive = 0;
  level.ee_mech_zombies_spawned = 0;
  level.quadrotor_custom_behavior = & mech_zombie_hole_search;
}

function stage_logic() {
  iprintln(level._cur_stage_name + "");
  level flag::wait_till("ee_quadrotor_disabled");
  level thread sndee4music();
  if(!level flag::get("ee_mech_zombie_fight_completed")) {
    while (level.ee_mech_zombies_spawned < 8) {
      if(level.ee_mech_zombies_alive < 4) {
        ai = zombie_utility::spawn_zombie(level.mechz_spawners[0]);
        ai thread ee_mechz_spawn(level.ee_mech_zombies_spawned % 4);
        level.ee_mech_zombies_alive++;
        level.ee_mech_zombies_spawned++;
      }
      wait(randomfloatrange(0.5, 1));
    }
  }
  level flag::wait_till("ee_mech_zombie_fight_completed");
  util::wait_network_frame();
  zm_sidequests::stage_completed("little_girl_lost", level._cur_stage_name);
}

function exit_stage(success) {
  level.quadrotor_custom_behavior = undefined;
  level notify("hash_4f3f0441");
}

function mech_zombie_hole_search() {
  s_goal = struct::get("ee_mech_hole_goal_0", "targetname");
  if(distance2dsquared(self.origin, s_goal.origin) < 250000) {
    self setvehgoalpos(s_goal.origin, 1, 2);
    self util::waittill_any("near_goal", "force_goal", "reached_end_node");
    s_goal = struct::get("ee_mech_hole_goal_1", "targetname");
    self setvehgoalpos(s_goal.origin, 1, 0);
    self util::waittill_any("near_goal", "force_goal", "reached_end_node");
    wait(2);
    s_goal = struct::get("ee_mech_hole_goal_2", "targetname");
    self setvehgoalpos(s_goal.origin, 1, 0);
    self util::waittill_any("near_goal", "force_goal", "reached_end_node");
    playsoundatposition("zmb_squest_maxis_folly", s_goal.origin);
    zm_tomb_vo::maxissay("vox_maxi_drone_upgraded_3", self);
    level flag::set("ee_quadrotor_disabled");
    self dodamage(200, self.origin);
    self delete();
    level.maxis_quadrotor = undefined;
  }
}

function ee_mechz_spawn(n_spawn_pos) {
  self endon("death");
  level endon("intermission");
  self.animname = "mechz_zombie";
  self.missinglegs = 0;
  self.no_gib = 1;
  self.ignore_all_poi = 1;
  self.is_mechz = 1;
  self.ignore_enemy_count = 1;
  self.no_damage_points = 1;
  self.meleedamage = 75;
  zm_utility::recalc_zombie_array();
  self setphysparams(20, 0, 80);
  self.zombie_init_done = 1;
  self notify("zombie_init_done");
  self.allowpain = 0;
  self animmode("normal");
  self orientmode("face enemy");
  self zm_spawner::zombie_setup_attack_properties();
  self.completed_emerging_into_playable_area = 1;
  self notify("completed_emerging_into_playable_area");
  self.no_powerups = 0;
  self setfreecameralockonallowed(0);
  self thread zombie_utility::zombie_eye_glow();
  waittillframeend();
  self clientfield::set("tomb_mech_eye", 1);
  self.health = level.mechz_health;
  level thread zm_spawner::zombie_death_event(self);
  self thread zm_spawner::enemy_death_detection();
  a_spawner_structs = struct::get_array("mech_hole_spawner", "targetname");
  spawn_pos = a_spawner_structs[n_spawn_pos];
  if(!isdefined(spawn_pos.angles)) {
    spawn_pos.angles = (0, 0, 0);
  }
  self thread mechz_death_ee();
  self forceteleport(spawn_pos.origin, spawn_pos.angles);
  self zombie_utility::set_zombie_run_cycle("walk");
  if(isdefined(level.mechz_find_flesh_override_func)) {
    level thread[[level.mechz_find_flesh_override_func]]();
  }
  self ee_mechz_do_jump(spawn_pos);
}

function mechz_death_ee() {
  self waittill("death");
  self clientfield::set("tomb_mech_eye", 0);
  level.ee_mech_zombies_killed++;
  level.ee_mech_zombies_alive--;
  if(level.ee_mech_zombies_killed == 4) {
    v_max_ammo_origin = self.origin;
    level thread zm_powerups::specific_powerup_drop("full_ammo", v_max_ammo_origin);
  }
  if(level.ee_mech_zombies_killed == 8) {
    v_nuke_origin = self.origin;
    level thread zm_powerups::specific_powerup_drop("nuke", v_nuke_origin);
    level flag::set("ee_mech_zombie_fight_completed");
  }
}

function ee_mechz_do_jump(s_spawn_pos) {
  self endon("death");
  self endon("kill_jump");
  if(getdvarint("") > 0) {
    println("");
  }
  if(getdvarint("") > 1) {
    println("");
  }
  self.not_interruptable = 1;
  self setfreecameralockonallowed(0);
  self animscripted("zm_fly_out", self.origin, self.angles, "ai_zombie_mech_exit");
  self zombie_shared::donotetracks("zm_fly_out");
  self ghost();
  if(isdefined(self.m_claw)) {
    self.m_claw ghost();
  }
  old_fx = self.fx_field;
  self thread zombie_utility::zombie_eye_glow_stop();
  self animscripted("zm_fly_hover_finished", self.origin, self.angles, "ai_zombie_mech_exit_hover");
  wait(level.mechz_jump_delay);
  s_landing_point = struct::get(s_spawn_pos.target, "targetname");
  if(!isdefined(s_landing_point.angles)) {
    s_landing_point.angles = (0, 0, 0);
  }
  self animscripted("zm_fly_in", s_landing_point.origin, s_landing_point.angles, "ai_zombie_mech_arrive");
  self show();
  self.fx_field = old_fx;
  self clientfield::set("mechz_fx", self.fx_field);
  if(isdefined(self.m_claw)) {
    self.m_claw show();
  }
  self zombie_shared::donotetracks("zm_fly_in");
  self.not_interruptable = 0;
  self setfreecameralockonallowed(1);
  if(getdvarint("") > 1) {
    println("");
  }
  self.closest_jump_point = s_landing_point;
}

function sndee4music() {
  shouldplay = sndwait();
  if(!shouldplay) {
    return;
  }
  level.music_override = 1;
  level clientfield::set("mus_zmb_egg_snapshot_loop", 1);
  ent = spawn("script_origin", (0, 0, 0));
  ent playloopsound("mus_mechz_fight_loop");
  level flag::wait_till("ee_mech_zombie_fight_completed");
  level clientfield::set("mus_zmb_egg_snapshot_loop", 0);
  level.music_override = 0;
  wait(0.05);
  ent delete();
}

function sndwait() {
  counter = 0;
  while (isdefined(level.music_override) && level.music_override) {
    wait(1);
    counter++;
    if(counter >= 60) {
      return false;
    }
  }
  return true;
}