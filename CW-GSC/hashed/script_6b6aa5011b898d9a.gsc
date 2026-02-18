/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6b6aa5011b898d9a.gsc
***********************************************/

#using script_1b9f100b85b7e21d;
#using script_237e957844a8197c;
#using script_5991d6501121591f;
#using script_7728aa611ab72ad9;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#using scripts\weapons\cp\spy_camera;
#namespace namespace_dca66e72;

function start(str_objective) {
  level hms_util::function_ee1d1df6("park", "Park", "park_vip_struct");
  level hms_util::function_ee1d1df6("lazar", "Lazar", "lazar_vip_struct", "lazar_vip_skipto_color_trig");
  level thread namespace_a789f8ae::function_e73fa40e("2nd_floor");
  level thread namespace_a789f8ae::function_b91f9a58("2nd_floor");
  flag::set("flg_player_nearing_vip_room_vo");
  flag::set("flg_vip_door_last_stand_enemies_dead");
  flag::set("flg_open_nuke_door");
}

function main(str_objective, var_50cc0d4f) {
  hms_util::print("<dev string:x38>");

  level.park ai::set_behavior_attribute("disablepeek", 1);
  level.park ai::set_behavior_attribute("disablelean", 1);
  level thread function_40266ecc();
  level thread namespace_a789f8ae::function_eff61506();
  namespace_232ddc52::music("11.0_nukeroom");
  s_goto = struct::get("nuke_map_look_at");
  objectives::goto("obj_use_bomb", s_goto.origin, #"hash_4f32052106138b69");
  level flag::wait_till("play_nuke_room");
  level thread function_c3a8531c();
  level flag::set("flg_ready_to_enter_nuke_room");
  level thread function_ec0c77eb();
  objectives::complete("obj_use_bomb");
  savegame::checkpoint_save();
  var_9e93f581 = struct::get("obj_nuke_photo");
  objectives::goto("obj_photo", var_9e93f581.origin, #"hash_31f58514a990bca7");
  level.player thread objectives_ui::show_objectives();
  level.player thread objectives_ui::function_1c6b4aeb();
  level flag::wait_till("flg_nuke_room_obj_done");
  objectives::complete("obj_photo");
  level flag::wait_till_all(array("flg_vo_in_nuke_room_complete", "obj_photo_done"));
  skipto::function_4e3ab877("vip_room");
  level.park lookatentity();
}

function cleanup(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  hms_util::print("<dev string:x4d>");
}

function function_40266ecc() {
  level.player endon(#"death");
  level flag::wait_till("flg_nuke_disinfectant");
  exploder::exploder("Disinfectant_exploder");
  snd::client_msg("audio_start_disinfectant_spray");
  wait 7.5;
  exploder::exploder_stop("Disinfectant_exploder");
  snd::client_msg("audio_stop_disinfectant_spray");
}

function function_c1a7ac51(n_time) {
  level endon(#"obj_photo_done");
  id = objectives::function_285e460("obj_photo");

  while(1 && !flag::get("obj_photo_done")) {
    if(!flag::get("obj_photo_done")) {
      wait n_time;
      level.player thread objectives_ui::show_objectives();
      level.player thread objectives_ui::function_1c6b4aeb();
    }

    wait 1;
  }
}

function function_1898210c() {
  level.player endon(#"death");
  level flag::wait_till("flg_obj_start_photo");
  e_photo = getent("e_obj_nuke_photo", "targetname");
  var_d74dc916 = 0;
  level.player spy_camera::function_f785d9e9(e_photo);
  level thread function_cc099c85();
  level thread function_c1a7ac51(10);
  e_photo waittill(#"photo_taken");
  level.player spy_camera::function_b28ab5a9(e_photo);
  e_photo delete();
  level.player waittill(#"end_camera_ads");
  level.player takeweapon(level.var_e3f5eafc);
  level flag::set("obj_photo_done");
}

function function_cc099c85() {
  self endon(#"death");
  w_current = level.player getcurrentweapon();
  level.player thread util::show_hint_text(#"hash_45bb3c09f7cf99ff", undefined, "show_camera_equip_hint", -1);

  while(true) {
    var_6514b336 = level.player getcurrentweapon();

    if(level.player actionslotfourbuttonPressed() && var_6514b336 != level.var_e3f5eafc) {
      level.player thread function_c3c2478a();
      level.player thread util::hide_hint_text();
    } else if(level.player actionslotfourbuttonPressed() && var_6514b336 == level.var_e3f5eafc) {
      level.player thread function_26475976(w_current);
    } else if(level flag::get("obj_photo_done")) {
      level flag::set("flg_nuke_room_obj_done");
      break;
    }

    waitframe(1);
  }
}

function function_c3a8531c() {
  level.player endon(#"death");
  var_f8e5e80 = struct::get("nuke_map_look_at", "targetname");
  var_e534dcb = struct::get("ai_alder_radio", "targetname");
  level waittill(#"obj_start_photo");
  level flag::set("flg_obj_start_photo");
  level waittill(#"lights_on");
  level flag::set("flg_lights_on");
  level flag::set("flg_vip_room_dialogue_finished");
  level waittill(#"hash_5d95cc81cb1adf8d");
  wait 1.25;
  level flag::set("flg_cctv_finished");
  level flag::set("flg_vo_in_nuke_room_complete");
}

function function_ec0c77eb() {
  var_4a3daa0b = struct::get("nuke_map_look_at", "targetname");

  while(true) {
    within_fov = util::within_fov(level.player getplayercamerapos(), level.player getplayerangles(), var_4a3daa0b.origin, cos(35));
    var_19433220 = sighttracepassed(level.player getplayercamerapos(), var_4a3daa0b.origin, 0, undefined);

    if(within_fov == 1 && var_19433220 == 1) {
      level flag::set("flg_looked_at_nuke");
      break;
    }

    waitframe(1);
  }
}

function function_980acf2() {
  level.player endon(#"death");
  level endon(#"vip_room", #"obj_photo_done");
  var_7f3c998e = getent("trig_park_nag_intel", "targetname");
  var_7f3c998e waittill(#"trigger");
  wait 15;
  var_ffbbfc35 = [];
  var_ffbbfc35[0] = "vox_cp_cbcr_01600_park_bellsnapaphotoo_8d";
  var_ffbbfc35[1] = "vox_cp_cbcr_01600_park_bellthemaptakea_1c";
  var_ffbbfc35[2] = "vox_cp_cbcr_01600_park_bellweneedapict_45";
  array::randomize(var_ffbbfc35);
  n_nag = 0;

  while(!level flag::get("flg_nags_done")) {
    if(isDefined(var_ffbbfc35[n_nag])) {
      level.park hms_util::dialogue(var_ffbbfc35[n_nag]);
      n_nag++;
      wait randomfloatrange(10, 15);
      continue;
    }

    level flag::set("flg_nags_done");
    break;
  }
}

function function_c3c2478a() {
  self giveweapon(level.var_e3f5eafc);
  self switchtoweapon(level.var_e3f5eafc);
}

function function_26475976(w_original) {
  self switchtoweapon(w_original);
  self takeweapon(level.var_e3f5eafc);
}