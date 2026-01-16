/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_tomb_ee_main_step_8.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\hud_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_sidequests;
#using scripts\zm\zm_tomb_chamber;
#using scripts\zm\zm_tomb_ee_main;
#using scripts\zm\zm_tomb_utility;
#using scripts\zm\zm_tomb_vo;
#namespace zm_tomb_ee_main_step_8;

function init() {
  zm_sidequests::declare_sidequest_stage("little_girl_lost", "step_8", & init_stage, & stage_logic, & exit_stage);
}

function init_stage() {
  level._cur_stage_name = "step_8";
  level.quadrotor_custom_behavior = & move_into_portal;
}

function stage_logic() {
  iprintln(level._cur_stage_name + "");
  level notify("tomb_sidequest_complete");
  foreach(player in getplayers()) {
    if(player zm_tomb_chamber::is_player_in_chamber()) {
      player thread hud::fade_to_black_for_x_sec(0, 1, 0.5, 0.5, "white");
    }
  }
  wait(0.5);
  level clientfield::set("ee_sam_portal", 2);
  exploder::exploder("fxexp_500");
  level notify("stop_random_chamber_walls");
  a_walls = getentarray("chamber_wall", "script_noteworthy");
  foreach(e_wall in a_walls) {
    e_wall thread zm_tomb_chamber::move_wall_up();
    e_wall hide();
  }
  level flag::wait_till("ee_quadrotor_disabled");
  wait(1);
  level thread zm_tomb_ee_main::ee_samantha_say("vox_sam_all_staff_freedom_0");
  s_pos = struct::get("player_portal_final", "targetname");
  t_portal = zm_tomb_utility::tomb_spawn_trigger_radius(s_pos.origin, 100, 1);
  t_portal.require_look_at = 1;
  t_portal.hint_string = & "ZM_TOMB_TELE";
  t_portal thread waittill_player_activates();
  level.ee_ending_beam_fx = spawn("script_model", s_pos.origin + (vectorscale((0, 0, -1), 300)));
  level.ee_ending_beam_fx.angles = vectorscale((0, 1, 0), 90);
  level.ee_ending_beam_fx setmodel("tag_origin");
  playfxontag(level._effect["ee_beam"], level.ee_ending_beam_fx, "tag_origin");
  level.ee_ending_beam_fx playsound("zmb_squest_crystal_sky_pillar_start");
  level.ee_ending_beam_fx playloopsound("zmb_squest_crystal_sky_pillar_loop");
  level flag::wait_till("ee_samantha_released");
  t_portal zm_tomb_utility::tomb_unitrigger_delete();
  util::wait_network_frame();
  zm_sidequests::stage_completed("little_girl_lost", level._cur_stage_name);
}

function exit_stage(success) {
  level notify("hash_738ebd3d");
}

function waittill_player_activates() {
  while (true) {
    self waittill("trigger", player);
    level flag::set("ee_samantha_released");
  }
}

function move_into_portal() {
  s_goal = struct::get("maxis_portal_path", "targetname");
  if(distance2dsquared(self.origin, s_goal.origin) < 250000) {
    self setvehgoalpos(s_goal.origin, 1, 2);
    self util::waittill_any("near_goal", "force_goal", "reached_end_node");
    zm_tomb_vo::maxissay("vox_maxi_drone_upgraded_1", self);
    wait(1);
    level thread zm_tomb_vo::maxissay("vox_maxi_drone_upgraded_2", self);
    s_goal = struct::get(s_goal.target, "targetname");
    self setvehgoalpos(s_goal.origin, 1, 0);
    self util::waittill_any("near_goal", "force_goal", "reached_end_node");
    self playsound("zmb_qrdrone_leave");
    level flag::set("ee_quadrotor_disabled");
    self dodamage(200, self.origin);
    self delete();
    level.maxis_quadrotor = undefined;
  }
}