/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5ab2e91e565f1fae.gsc
***********************************************/

#using script_1b9f100b85b7e21d;
#using script_237e957844a8197c;
#using script_3dc93ca9902a9cda;
#using script_5991d6501121591f;
#using script_6b2490222adab2af;
#using script_7728aa611ab72ad9;
#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#namespace namespace_69b8cbbe;

function start(str_objective) {
  level hms_util::function_ee1d1df6("park", "Park", "park_church_struct");
  level hms_util::function_ee1d1df6("lazar", "Lazar", "lazar_church_struct");
  level.player setmovespeedscale(0.85);
}

function main(str_objective, var_50cc0d4f) {
  hms_util::print("<dev string:x38>");

  hms_util::function_eaa0342e("church_containment_warnings", "church_containment_fails");
  level thread function_90611d3c();
  level thread function_ed8e64e1();
  level thread function_e1ea1ec2();
  level thread function_9c0ed7ec();
  level thread function_99e351b3();
  namespace_232ddc52::music("2.0_tension");
  level hms_util::function_ee1d1df6("adler", "Adler", "adler_plaza_struct", "plaza_squad_2_spawn_colors");
  level hms_util::function_ee1d1df6("mason", "Mason", "mason_plaza_struct");
  level hms_util::function_ee1d1df6("woods", "Woods", "woods_plaza_struct");
  level thread namespace_a789f8ae::function_716ff5d8("church");
  savegame::checkpoint_save();
  level.park.ignoreall = 1;
  level.lazar.ignoreall = 1;
  level flag::wait_till("flg_church_explosion");
  level.park.ignoreall = 0;
  level.lazar.ignoreall = 0;
  var_322fd646 = struct::get("ride_initial_explosion", "targetname");
  var_5094cb26 = getent("ride_sfx_ent", "targetname");
  level exploder::exploder("fxexp_church_explosion_falling_dust_fx");
  earthquake(0.5, 1, var_322fd646.origin, 2000);
  level.player playrumbleonentity("damage_light");
  snd::client_msg("church_explosion_event");
}

function function_9c0ed7ec() {
  church_exit_door = doors::function_73f09315("church_exit_door", "targetname");
  church_exit_door doors::waittill_door_opened();
  level flag::set("flg_church_door_opened");
  namespace_232ddc52::music("3.0_plaza");
}

function cleanup(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  hms_util::print("<dev string:x4b>");
}

function function_ed8e64e1() {
  var_b6ac0499 = struct::get("s_church_objective", "targetname");
  objectives::goto("obj_church", var_b6ac0499.origin, #"hash_1c332385c05be388");
  level thread function_a77ca5fc();
}

function function_a77ca5fc() {
  level flag::wait_till("flag_obj_church_done");
  objectives::complete("obj_church");
}

function function_90611d3c() {
  namespace_307260b8::function_2b6287f4("church_allies_path_trigger");
  level.lazar function_77316c32();
  level.park function_77316c32();
  var_39327768 = struct::get("church_path_chain_1", "targetname");
  var_5e3f4181 = struct::get("church_path_chain_2", "targetname");
  level.park spawner::function_461ce3e9();
  level.park thread spawner::go_to_struct(var_5e3f4181);
  wait 0.15;
  level.lazar spawner::function_461ce3e9();
  level.lazar thread spawner::go_to_struct(var_39327768);
}

function function_77316c32() {
  self setdesiredspeed(250);
  self.pushable = 0;
  self val::set(#"hash_5b20d1b59a41939d", "push_player", 1);
  self ai::set_behavior_attribute("vignette_mode", "fast");
  self ai::set_behavior_attribute("disablepeek", 1);
  self ai::set_behavior_attribute("disablelean", 1);
}

function function_89d8a2ed(s_info) {
  if(isDefined(self.go_to_node.script_noteworthy)) {
    self ai::function_3a5e9945(0);
    var_bccd1cd = struct::get(self.go_to_node.script_noteworthy, "targetname");
    self ai::poi_enable(1, var_bccd1cd);
    return;
  }

  self ai::function_3a5e9945(1);
}

function function_e1ea1ec2() {
  level.player endon(#"death");
  level endon(#"flg_vo_church_done");
  level flag::set("flg_vo_ride_done");
  var_e534dcb = struct::get("ai_alder_radio", "targetname");
  var_662759db = struct::get("ai_woods_radio", "targetname");
  var_e534dcb hms_util::dialogue("vox_cp_cbcr_01000_adlr_alrightwoodslig_e8", 1, "allies", "Adler");
  var_662759db hms_util::dialogue("vox_cp_cbcr_01000_wood_boutfuckingtime_8b", 1, "allies", "Woods");
  level flag::set("flg_church_explosion");
  wait 1;
  level.park hms_util::dialogue("vox_cp_cbcr_01100_park_gogogo_c5", undefined, "allies", "Park");
  level flag::wait_till("flg_open_church_door");
  level.park hms_util::dialogue("vox_cp_cbcr_01100_park_dothehonorsbell_b9", undefined, "allies", "Park");
  level thread function_9d00d19b();
}

function function_9d00d19b() {
  level endon(#"flag_obj_church_done");
  level endon(#"flg_church_door_opened");
  wait 10;
  var_ffbbfc35 = [];
  var_ffbbfc35[0] = hms_util::function_e1449992(level.park, "vox_cp_cbcr_01100_park_bellweneedtomov_33");
  var_ffbbfc35[1] = hms_util::function_e1449992(level.park, "vox_cp_cbcr_01100_park_kickopenthedoor_aa");
  var_ffbbfc35[2] = hms_util::function_e1449992(level.lazar, "vox_cp_cbcr_01100_lazr_bellgetyourhead_f0");
  var_ffbbfc35[3] = hms_util::function_e1449992(level.park, "vox_cp_cbcr_01100_park_bellthedoor_d6");

  while(true) {
    hms_util::vo_knockout_manager("cuban_church_nags", var_ffbbfc35);
    wait 15;
  }
}

function function_99e351b3() {
  var_931f6882 = getEntArray("plaza_veh_destructibles", "script_noteworthy");

  foreach(veh in var_931f6882) {
    veh val::set("plaza_destructibles", "takedamage", 0);
  }

  level flag::wait_till("flg_initial_plaza_guys_normal_combat");

  foreach(veh in var_931f6882) {
    veh val::set("plaza_destructibles", "takedamage", 1);
  }
}