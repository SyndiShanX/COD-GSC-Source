/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_sing_blackstation_subway.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_dialog;
#using scripts\cp\_objectives;
#using scripts\cp\_skipto;
#using scripts\cp\_util;
#using scripts\cp\cp_mi_sing_blackstation_police_station;
#using scripts\cp\cp_mi_sing_blackstation_sound;
#using scripts\cp\cp_mi_sing_blackstation_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\animation_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\colors_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#namespace cp_mi_sing_blackstation_subway;

function subway_main() {
  level clientfield::set("flotsam", 1);
  level thread subway_waypoints();
  level thread subway_completion();
  level thread subway_floating_bodies();
  level thread subway_scare_scene_01();
  level thread subway_scare_scene_02();
  level thread subway_scare_scene_03();
  level thread hendricks_swimming();
  level thread subway_dialog();
  level thread function_c7ea2242();
  level thread function_27e6ca54();
  level thread function_eb060258();
  objectives::set("cp_level_blackstation_goto_comm_relay");
  level.ai_hendricks ai::set_behavior_attribute("cqb", 1);
  foreach(ai in getaiteamarray("axis")) {
    ai delete();
  }
  level clientfield::set("subway_entrance_crash", 1);
  if(isDefined(level.bzm_blackstationdialogue3_5callback)) {
    level thread[[level.bzm_blackstationdialogue3_5callback]]();
  }
  a_s_subway = struct::get_array("player_subway_pos");
  exploder::exploder("fx_expl_tanker_splashes_mist");
}

function function_eb060258() {
  trigger::wait_till("trigger_underwater_vo");
  level dialog::player_say("plyr_kane_we_re_approac_0");
  level dialog::remote("kane_better_make_it_fast_0");
  level dialog::player_say("plyr_understood_1");
}

function function_27e6ca54() {
  var_ec39b8a8 = getEntArray("subway_corpse_floating", "targetname");
  foreach(e_corpse in var_ec39b8a8) {
    e_corpse thread function_62437267();
  }
  var_40eadcd7 = getent("subway_corpse_3", "targetname");
  var_40eadcd7 thread function_62437267();
}

function function_62437267() {
  self thread scene::play(self.script_noteworthy, self);
}

function function_c7ea2242() {
  trigger::wait_till("trigger_subway_tiles");
  clientfield::set("subway_tiles", 1);
}

function function_99f304f0() {
  self endon("death");
  self.var_15caaa0c = 0;
  while(!level flag::get("flag_kane_intro_complete")) {
    while(!self isplayerunderwater()) {
      wait(0.1);
    }
    if(!self.var_15caaa0c) {
      self.var_15caaa0c = 1;
      self thread util::show_hint_text(&"COOP_SWIM_INSTRUCTIONS");
    }
    self clientfield::set_to_player("play_bubbles", 1);
    self fx::play("bubbles", self.origin, (0, 0, 0), "swim_done", 1, "j_spineupper");
    while(self isplayerunderwater()) {
      wait(0.1);
    }
    self clientfield::set_to_player("play_bubbles", 0);
    self notify("swim_done");
    wait(0.1);
  }
  self clientfield::set_to_player("play_bubbles", 0);
  self notify("swim_done");
}

function subway_waypoints() {
  level objectives::breadcrumb("subway_breadcrumb");
  level objectives::breadcrumb("trigger_breadcrumb_subway_exit");
  level objectives::breadcrumb("trigger_breadcrumb_police_street", "cp_level_blackstation_climb");
}

function subway_completion() {
  level flag::wait_till("flag_waypoint_subway01");
  wait(2);
  level thread scene::play("p7_fxanim_cp_blackstation_subway_stair_debris_bundle");
  skipto::objective_completed("objective_subway");
}

function subway_dialog() {
  trigger::wait_till("trig_hendricks_swim");
  level thread namespace_4297372::function_37f7c98d();
  level thread cp_mi_sing_blackstation_police_station::function_a7bb8a82();
}

function hendricks_swimming() {
  level scene::init("cin_bla_08_02_subway_vign_swim_first_section");
  trigger::wait_till("trig_hendricks_swim");
  level scene::add_scene_func("cin_bla_08_02_subway_vign_swim_first_section", & function_561cae8a, "play");
  level scene::play("cin_bla_08_02_subway_vign_swim_first_section");
  level flag::wait_till("subway_second_section");
  level scene::play("cin_bla_08_02_subway_vign_swim_second_section");
  level flag::wait_till("subway_third_section");
  level scene::add_scene_func("cin_bla_08_02_subway_vign_swim_third_section", & function_5f8ce82c, "done");
  level scene::play("cin_bla_08_02_subway_vign_swim_third_section");
  if(!level flag::get("flag_waypoint_subway01")) {
    trigger::use("trig_hendricks_color_b2", "targetname");
  }
  level.ai_hendricks notify("move_to_subway_exit");
  level.ai_hendricks ai::set_behavior_attribute("forceTacticalWalk", 1);
  level flag::wait_till("subway_exit");
  level.ai_hendricks ai::set_behavior_attribute("forceTacticalWalk", 0);
}

function function_561cae8a(a_ents) {
  wait(2);
  level.ai_hendricks fx::play("bubbles", level.ai_hendricks.origin, (0, 0, 0), "swim_done", 1, "j_spineupper");
}

function function_5f8ce82c(a_ents) {
  level.ai_hendricks notify("swim_done");
}

function subway_floating_bodies() {
  level endon("out_of_water");
  e_floating_bodies = getEntArray("subway_corpse_floating", "targetname");
  array::thread_all(e_floating_bodies, & subway_floating_bodies_move);
}

function subway_floating_bodies_move() {
  level endon("out_of_water");
  self endon("death");
  e_body = self;
  n_rotate_angle = 60;
  while(true) {
    e_body rotatepitch(n_rotate_angle, 5);
    wait(4.5);
  }
}

function subway_scare_scene_01() {
  level endon("out_of_water");
  level endon("cancel_scare");
  e_corpse = getent("subway_corpse", "targetname");
  e_linkto = util::spawn_model("tag_origin", e_corpse.origin, e_corpse.angles);
  e_corpse linkto(e_linkto);
  e_corpse thread scene::play("cin_bla_08_02_subway_vign_dead_body_scare", e_corpse);
  t_trigger = getent("trig_subway_scare", "targetname");
  t_trigger waittill("trigger", player);
  playsoundatposition("mus_subway_scare", (0, 0, 0));
  level notify("scare_happened");
  level thread corpse_dialog(player);
  e_linkto movey(-60, 0.5);
  e_linkto rotateroll(50, 2);
  e_linkto rotateyaw(90, 1);
  e_linkto waittill("movedone");
  e_linkto moveto(e_corpse.origin - (0, 50, 25), 5);
}

function subway_scare_scene_02() {
  level endon("out_of_water");
  t_trigger = getent("trig_subway_scare_2", "targetname");
  e_corpse = getent("subway_corpse_2", "targetname");
  level waittill("scare_happened");
  e_corpse endon("death");
  t_trigger waittill("trigger", player);
  e_corpse movex(-80, 2);
  e_corpse rotatepitch(60, 5);
  e_corpse waittill("movedone");
  e_corpse moveto(e_corpse.origin - (0, -50, 50), 5);
}

function subway_scare_scene_03() {
  level endon("out_of_water");
  t_trigger = getent("trig_subway_scare_3", "targetname");
  e_corpse = getent("subway_corpse_3", "targetname");
  e_corpse endon("death");
  t_trigger waittill("trigger", player);
  e_corpse movez(-24, 0.75);
  e_corpse rotateroll(60, 5);
  e_corpse waittill("movedone");
  e_corpse moveto(e_corpse.origin - (25, 25, 75), 5);
}

function corpse_dialog(player) {
  level endon("out_of_water");
}