/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_cairo_aquifer_ambience.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_load;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#namespace namespace_1254c007;

function autoexec __init__sytem__() {
  system::register("aquifer_ambience", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("toplayer", "show_sand_storm", 1, 1, "int", &function_7ddc918d, 0, 0);
  clientfield::register("world", "hide_sand_storm", 1, 1, "int", &function_e5def758, 0, 0);
  clientfield::register("world", "play_trucks", 1, 1, "int", &function_91528afa, 0, 0);
  clientfield::register("world", "start_ambience", 1, 1, "int", &function_134f3566, 0, 0);
  clientfield::register("world", "stop_ambience", 1, 1, "int", &function_ad396d58, 0, 0);
  clientfield::register("world", "kill_ambience", 1, 1, "int", &function_9ba61e20, 0, 0);
  level thread function_89b52898();
}

function main(localclientnum) {}

function function_134f3566(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.scriptbundles["scene"]["p7_fxanim_cp_aqu_war_dogfight_main_loop_a_bundle_client"])) {
    return;
  }
  thread function_ca056d7e();
  var_acfd8784 = struct::get_array("p7_fxanim_cp_aqu_war_dogfight_main_loop_a_bundle_client", "scriptbundlename");
  var_7056bf21 = struct::get("p7_fxanim_cp_aqu_war_dogfight_a_jet_vtol_bundle", "scriptbundlename");
  array::add(var_acfd8784, var_7056bf21);
  foreach(var_3668f67c in var_acfd8784) {
    var_3668f67c thread scene::play();
  }
}

function function_ad396d58(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level notify("hash_9e245bdd");
  if(!isDefined(level.var_c2750169)) {
    level.var_c2750169 = [];
  }
  foreach(jet in level.var_c2750169) {
    jet thread scene::stop(1);
    jet.scene_played = 0;
  }
  var_acfd8784 = struct::get_array("p7_fxanim_cp_aqu_war_dogfight_main_loop_a_bundle_client", "scriptbundlename");
  var_7056bf21 = struct::get("p7_fxanim_cp_aqu_war_dogfight_a_jet_vtol_bundle", "scriptbundlename");
  var_ffd496bd = struct::get("p7_fxanim_cp_aqu_war_patrol_a_vtol_nrc_bundle", "scriptbundlename");
  var_63f986ef = struct::get("p7_fxanim_cp_aqu_war_patrol_a_vtol_egypt_bundle", "scriptbundlename");
  array::add(var_acfd8784, var_7056bf21);
  array::add(var_acfd8784, var_ffd496bd);
  array::add(var_acfd8784, var_63f986ef);
  foreach(var_3668f67c in var_acfd8784) {
    var_3668f67c thread scene::stop(1);
    var_3668f67c.scene_played = 0;
  }
  array::run_all(level.var_c2750169, &scene::stop, 1);
}

function function_9ba61e20(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level notify("hash_9e245bdd");
  if(isDefined(level.var_c2750169)) {
    foreach(jet in level.var_c2750169) {
      jet thread scene::stop(1);
      jet.scene_played = 0;
    }
  }
  var_acfd8784 = struct::get_array("p7_fxanim_cp_aqu_war_dogfight_main_loop_a_bundle_client", "scriptbundlename");
  var_7056bf21 = struct::get("p7_fxanim_cp_aqu_war_dogfight_a_jet_vtol_bundle", "scriptbundlename");
  var_ffd496bd = struct::get("p7_fxanim_cp_aqu_war_patrol_a_vtol_nrc_bundle", "scriptbundlename");
  var_63f986ef = struct::get("p7_fxanim_cp_aqu_war_patrol_a_vtol_egypt_bundle", "scriptbundlename");
  array::add(var_acfd8784, var_7056bf21);
  array::add(var_acfd8784, var_ffd496bd);
  array::add(var_acfd8784, var_63f986ef);
  foreach(var_3668f67c in var_acfd8784) {
    var_3668f67c thread scene::stop(1);
  }
  waittillframeend();
  struct::delete_script_bundle("scene", "p7_fxanim_cp_aqu_war_dogfight_main_loop_a_bundle_client");
  struct::delete_script_bundle("scene", "p7_fxanim_cp_aqu_war_dogfight_a_jet_vtol_bundle");
  struct::delete_script_bundle("scene", "p7_fxanim_cp_aqu_warpatrol_a_vtol_nrc_bundle");
  struct::delete_script_bundle("scene", "p7_fxanim_cp_aqu_warpatrol_a_vtol_egypt_bundle");
  struct::delete_script_bundle("scene", "p7_fxanim_cp_aqu_war_flyover_a_jet_bundle");
  struct::delete_script_bundle("scene", "p7_fxanim_cp_aqu_war_flyover_b_jet_bundle");
}

function function_ca056d7e() {
  a_pos = struct::get_array("jet_flyover_pos", "targetname");
  if(a_pos.size == 0) {
    return;
  }
  var_ed7818f9 = [];
  array::add(var_ed7818f9, "p7_fxanim_cp_aqu_war_flyover_a_jet_bundle");
  array::add(var_ed7818f9, "p7_fxanim_cp_aqu_war_flyover_b_jet_bundle");
  if(isDefined(level.var_c2750169)) {
    foreach(jet in level.var_c2750169) {
      if(jet scene::is_playing()) {
        jet scene::stop();
      }
    }
  }
  level notify("hash_9e245bdd");
  if(!isDefined(level.var_c2750169)) {
    level.var_c2750169 = [];
    for(i = 0; i < 12; i++) {
      level.var_c2750169[level.var_c2750169.size] = struct::spawn(a_pos[i].origin, a_pos[i].angles);
    }
  }
  for(i = 0; i < 12; i++) {
    level.var_c2750169[i] thread function_5794dab9(var_ed7818f9[i % 2], randomfloatrange(0, 20));
  }
}

function function_5794dab9(s_bundle, delay) {
  level endon("hash_9e245bdd");
  level endon("inside_aquifer");
  level endon("hash_c2988129");
  wait(delay);
  self thread scene::play(s_bundle);
}

function function_e5def758(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_76968f56 = getEntArray(localclientnum, "sand_storm", "targetname");
  if(var_76968f56.size > 0) {
    array::run_all(var_76968f56, &visible, 0);
  }
}

function function_7ddc918d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_76968f56 = getEntArray(localclientnum, "sand_storm", "targetname");
  if(var_76968f56.size > 0) {
    array::run_all(var_76968f56, &visible, 1);
  }
}

function visible(bool) {
  if(bool) {
    self show();
  } else {
    self hide();
  }
}

function function_91528afa(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.scriptbundles["scene"]["p7_fxanim_cp_aqu_war_groundassault_bundle"])) {
    return;
  }
  pos = getent(localclientnum, "dogfighting_scene_client_side", "targetname");
  pos scene::play("p7_fxanim_cp_aqu_war_groundassault_bundle");
  pos scene::stop("p7_fxanim_cp_aqu_war_groundassault_bundle", 1);
  waittillframeend();
  struct::delete_script_bundle("scene", "p7_fxanim_cp_aqu_war_groundassault_bundle");
}

function function_89b52898() {
  level waittill("hash_496d3ee1");
  audio::playloopat("amb_postwateroom_weird_lp", (12618, 1364, 2949));
}