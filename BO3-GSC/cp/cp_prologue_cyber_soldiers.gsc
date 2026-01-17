/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_prologue_cyber_soldiers.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_dialog;
#using scripts\cp\_load;
#using scripts\cp\_skipto;
#using scripts\cp\_util;
#using scripts\cp\cp_mi_eth_prologue;
#using scripts\cp\cp_mi_eth_prologue_fx;
#using scripts\cp\cp_mi_eth_prologue_sound;
#using scripts\cp\cp_prologue_util;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#namespace intro_cyber_soldiers;

function intro_cyber_soldiers_start() {
  intro_cyber_soldiers_precache();
  level thread intro_cyber_soldiers_main();
}

function intro_cyber_soldiers_precache() {}

function intro_cyber_soldiers_main() {
  level thread cp_prologue_util::function_950d1c3b(0);
  level thread ai_cleanup();
  level thread cyber_hangar_gate_close();
  level thread function_55b2b7ce();
  level thread function_e3957b4();
  level.ai_hendricks clearforcedgoal();
  level.ai_hendricks setgoal(level.ai_hendricks.origin, 1);
  level.ai_hyperion = util::get_hero("hyperion");
  level.ai_pallas = util::get_hero("pallas");
  level.ai_prometheus = util::get_hero("prometheus");
  level.ai_theia = util::get_hero("theia");
  level.ai_prometheus sethighdetail(1);
  level.ai_hendricks sethighdetail(1);
  function_9f230ee1();
  cp_prologue_util::function_47a62798(0);
  array::run_all(level.players, &util::set_low_ready, 0);
  callback::remove_on_spawned(&cp_mi_eth_prologue::function_4d4f1d4f);
  level notify("hash_e1626ff0");
  level.ai_prometheus sethighdetail(0);
  level.ai_hendricks sethighdetail(0);
  skipto::objective_completed("skipto_intro_cyber_soldiers");
}

function function_55b2b7ce() {
  level waittill("hash_999aab74");
  var_771bcc8f = getent("cyber_solider_intro_lift_clip", "targetname");
  var_771bcc8f delete();
}

function cyber_hangar_gate_close() {
  wait(20);
  level thread scene::play("p7_fxanim_cp_prologue_hangar_doors_02_bundle");
  cyber_hangar_gate_r_pos = getent("cyber_hangar_gate_r_pos", "targetname");
  cyber_hangar_gate_r_pos playSound("evt_hangar_start_r");
  cyber_hangar_gate_r_pos playLoopSound("evt_hangar_loop_r");
  cyber_hangar_gate_l_pos = getent("cyber_hangar_gate_l_pos", "targetname");
  cyber_hangar_gate_l_pos playSound("evt_hangar_start_l");
  cyber_hangar_gate_l_pos playLoopSound("evt_hangar_loop_l");
  level waittill("hash_8e385112");
  cyber_hangar_gate_r_pos playSound("evt_hangar_stop_r");
  cyber_hangar_gate_l_pos playSound("evt_hangar_stop_l");
  cyber_hangar_gate_r_pos stoploopsound(0.1);
  cyber_hangar_gate_l_pos stoploopsound(0.1);
  level util::clientnotify("sndBW");
  umbragate_set("umbra_gate_hangar_02", 0);
}

function function_4ed5ddb9(s_node) {
  n_node = getnode(s_node, "targetname");
  self forceteleport(n_node.origin, n_node.angles, 1);
  self setgoal(n_node);
}

function ai_goal(str_node) {
  if(isDefined(str_node)) {
    nd_goal = getnode(str_node, "targetname");
    self setgoal(nd_goal, 1, 16);
    return;
  }
  self setgoal(self.origin, 1, 16);
}

function function_9f230ee1() {
  level waittill("hash_af22422d");
  exploder::exploder_stop("light_exploder_igc_cybersoldier");
}

function function_679e7da9(a_ents) {
  level thread function_ac290386();
  scene::add_scene_func("cin_pro_09_01_intro_1st_cybersoldiers_taylor_attack", &namespace_21b2c1f2::function_43ead72c, "play");
  scene::add_scene_func("cin_pro_09_01_intro_1st_cybersoldiers_taylor_attack", &function_39b556d, "play");
  scene::add_scene_func("cin_pro_09_01_intro_1st_cybersoldiers_taylor_attack", &function_e98e1240, "play");
  scene::add_scene_func("cin_pro_09_01_intro_1st_cybersoldiers_sarah_attack", &function_4e5acf5e, "play");
  scene::add_scene_func("cin_pro_09_01_intro_1st_cybersoldiers_taylor_attack", &function_a21df404, "play");
  scene::add_scene_func("cin_pro_09_01_intro_1st_cybersoldiers_confrontation_hkm", &function_89f840a1, "play");
  scene::add_scene_func("cin_pro_09_01_intro_1st_cybersoldiers_confrontation_hkm", &function_d71a5c1b, "play");
  scene::add_scene_func("cin_pro_09_01_intro_1st_cybersoldiers_confrontation", &function_73293683, "play");
  if(isDefined(level.bzm_prologuedialogue5callback)) {
    level thread[[level.bzm_prologuedialogue5callback]]();
  }
  level thread scene::play("cin_pro_09_01_intro_1st_cybersoldiers_diaz_attack");
  level thread scene::play("cin_pro_09_01_intro_1st_cybersoldiers_maretti_attack");
  level thread scene::play("cin_pro_09_01_intro_1st_cybersoldiers_sarah_attack");
  level thread scene::play("cin_pro_09_01_intro_1st_cybersoldiers_taylor_attack");
  level waittill("hash_afbcd4e8");
  util::clear_streamer_hint();
  level notify("hash_af22422d");
}

function function_d71a5c1b(a_ents) {
  level waittill("hash_60921fc7");
  level.ai_hendricks thread ai_goal("node_cyber_hendricks");
  level.ai_khalil thread ai_goal();
  level.ai_minister thread ai_goal();
}

function function_73293683(a_ents) {
  level waittill("hash_afbcd4e8");
  level.ai_prometheus thread ai_goal();
  level.ai_hyperion thread ai_goal();
  level.ai_pallas thread ai_goal("node_cyber_diaz");
  level.ai_theia thread ai_goal();
}

function function_ac290386() {
  level waittill("hash_b7587dcc");
  level waittill("hash_63ae24ea");
  array::run_all(level.players, &util::set_low_ready, 1);
  callback::on_spawned(&cp_mi_eth_prologue::function_4d4f1d4f);
  array::thread_all(level.players, &cp_mi_eth_prologue::function_7072c5d8);
  level waittill("hash_af43d596");
  playsoundatposition("evt_soldierintro_walla_panic_1", (6859, 886, 191));
  playsoundatposition("evt_soldierintro_walla_panic_2", (6870, 598, 197));
}

function function_89f840a1(a_ents) {
  ai_khalil = a_ents["khalil"];
  ai_minister = a_ents["minister"];
  ai_khalil.goalradius = 32;
  ai_minister.goalradius = 32;
  level waittill("hash_fd263aff");
  ai_minister setgoal(ai_minister.origin);
  ai_minister ai::set_behavior_attribute("vignette_mode", "fast");
  level waittill("hash_19175c89");
  ai_khalil setgoal(ai_khalil.origin);
  ai_khalil ai::set_behavior_attribute("vignette_mode", "fast");
}

function function_39b556d(a_ents) {
  var_7b00e29e = a_ents["pallas"];
  var_7b00e29e actor_camo(1, 0);
  var_7b00e29e waittill("uncloak");
  var_7b00e29e actor_camo(0);
}

function function_e98e1240(a_ents) {
  var_7b00e29e = a_ents["prometheus"];
  var_7b00e29e actor_camo(1, 0);
  var_7b00e29e waittill("uncloak");
  var_7b00e29e actor_camo(0);
  var_7b00e29e waittill("cloak");
  nd_goal = getnode("nd_taylor_after_intro", "targetname");
  var_7b00e29e setgoal(nd_goal);
  var_7b00e29e actor_camo(1, 1);
  wait(2);
  var_7b00e29e ghost();
}

function function_4e5acf5e(a_ents) {
  var_7b00e29e = a_ents["theia"];
  var_7b00e29e actor_camo(1, 0);
  var_7b00e29e waittill("uncloak");
  var_7b00e29e actor_camo(0);
  var_7b00e29e waittill("cloak");
  nd_goal = getnode("nd_theia_after_intro", "targetname");
  var_7b00e29e setgoal(nd_goal);
  var_7b00e29e actor_camo(1, 1);
  wait(2);
  var_7b00e29e ghost();
}

function function_a21df404(a_ents) {
  var_7b00e29e = a_ents["hyperion"];
  var_7b00e29e waittill("cloak");
  nd_goal = getnode("nd_hyperion_after_intro", "targetname");
  var_7b00e29e setgoal(nd_goal);
  var_7b00e29e actor_camo(1, 1);
  wait(1.5);
  var_7b00e29e ghost();
}

function actor_camo(n_camo_state, b_use_spawn_fx = 1) {
  self endon("death");
  if(n_camo_state == 1) {
    self playsoundontag("gdt_activecamo_on_npc", "tag_eye");
  } else {
    self playsoundontag("gdt_activecamo_off_npc", "tag_eye");
  }
  if(isDefined(b_use_spawn_fx) && b_use_spawn_fx) {
    self clientfield::set("cyber_soldier_camo", 2);
    wait(2);
  }
  self clientfield::set("cyber_soldier_camo", n_camo_state);
}

function link_traversals() {
  nd_lift_traversal = getnode("ms_lift_exit1_begin", "targetname");
  linktraversal(nd_lift_traversal);
}

function function_e3957b4() {
  if(!isDefined(level.var_3dce3f88)) {
    level.var_3dce3f88 = spawn("script_model", level.e_lift.origin);
    level.e_lift linkto(level.var_3dce3f88);
  }
  level.var_3dce3f88 movez(220, 12.3);
  level.var_3dce3f88 waittill("movedone");
  level.ai_hendricks clearforcedgoal();
  level.ai_hendricks setgoal(level.ai_hendricks.origin, 1);
  level thread link_traversals();
  level.ai_khalil unlink();
  level.snd_lift stoploopsound(0.1);
  level.e_lift playSound("evt_freight_lift_stop");
}

function function_f9753551() {
  level.e_lift = getent("freight_lift", "targetname");
  level.e_lift playSound("evt_freight_lift_start");
  level.snd_lift = spawn("script_origin", level.e_lift.origin);
  level.snd_lift linkto(level.e_lift);
  level.snd_lift playLoopSound("evt_freight_lift_loop");
  level.var_1dd14818 = 1;
  level.var_3dce3f88 movez(-354, 0.05);
  level.var_3dce3f88 waittill("movedone");
  level.snd_lift stoploopsound(0.1);
}

function ai_cleanup() {
  a_ais = getaiteamarray("axis");
  foreach(ai in a_ais) {
    if(isalive(ai)) {
      ai delete();
    }
  }
}