/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_744ba1f2f99cf072.gsc
***********************************************/

#using script_1fd2c6e5fc8cb1c3;
#using script_396062ed2667195d;
#using script_3dc93ca9902a9cda;
#using script_4134e1e2e7684c4c;
#using script_44aef2868ad2e317;
#using script_4937c6974f43bb71;
#using script_4ec222619bffcfd1;
#using script_779f525443585713;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\districts;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\corpse;
#using scripts\core_common\stealth\enemy;
#using scripts\core_common\stealth\threat_sight;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\dialog_tree;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#namespace kgb_ins_activation;

function starting(var_d3440450) {
  level thread namespace_e77bf565::function_277bceaa(1);
  level.checkpoint_clip = getent("checkpoint_clip", "targetname");
  level.checkpoint_clip notsolid();
  level.checkpoint_clip_right = getent("checkpoint_clip_right", "targetname");
  level.checkpoint_clip_right notsolid();
  level thread scene::init_streamer(#"scene_kgb_activation", getplayers());
  level thread namespace_99e99ffa::function_1d90bc4a();
}

function main(var_d3440450, var_50cc0d4f) {
  namespace_82bfe441::fade(1, "FadeImmediate");
  level thread scene::init("scene_kgb_poison_tea");
  level thread scene::init("scene_kgb_elevator_holdup");
  level thread scene::init("scene_kgb_walkup_adler");
  level scene::add_scene_func("scene_kgb_activation", &function_8fad2177, "End");
  level scene::add_scene_func("scene_kgb_ambient_security_vignette", &function_504f208d);
  level thread function_cb6665bc();
  namespace_353d803e::music("2.0_call");
  snd::client_msg(#"hash_7527c0556d529822");
  snd::client_msg(#"hash_695d2aba2d66c4b2");
  level thread function_ea6a0033();
  kgb_ins_prepare::function_52f0fcb3(var_50cc0d4f);
  kgb_ins_prepare::function_84d00884();
  level thread namespace_99e99ffa::function_99e99ffa(var_50cc0d4f);
  level thread scene::play("scene_kgb_ambient_security_vignette");
  level thread namespace_e77bf565::function_ada6d016();
  level battlechatter::function_2ab9360b(0);
  level thread namespace_e77bf565::function_1067ebf5("rotating_object_inside_man", "team_in_elevator");
  function_30c2cc8f();

  if(isDefined(var_50cc0d4f)) {
    skipto::function_4e3ab877(var_50cc0d4f);
  }

  level flag::wait_till("ins_activation_complete");
  namespace_82bfe441::fade(0, "FadeSlow");
}

function function_cb6665bc() {
  level endon(#"level_restarting");
  namespace_6f1d35e1::function_b2911127(0);
  wait 0.5;
  namespace_6f1d35e1::function_eea42dd9(#"hash_21ac68bbb6070a7b");
  namespace_6f1d35e1::function_487b4340(#"hash_6a49038dbf554db");
  namespace_6f1d35e1::function_5d2e6f6a(1);
  namespace_6f1d35e1::function_4951a2c8(1, 1);
  wait 2;
  namespace_6f1d35e1::function_487b4340(#"hash_35e421d5b19eafa6");
  namespace_6f1d35e1::function_5d2e6f6a(2);
  namespace_6f1d35e1::function_4951a2c8(1, 50);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_5cffb9f2(#"hash_22991d7388c6e6bf", 1, 1);
  level waittill(#"typing_complete");
  wait 1;
  level thread function_ab498154();
  level waittill(#"Establish_Connection");
  namespace_6f1d35e1::function_5cffb9f2(#"hash_3a975e0e1e2ac322", 4, 1, 0, 50);
  level waittill(#"typing_complete");
  wait 1;
  namespace_6f1d35e1::function_487b4340(#"hash_6d61a985c8ec4de");
  namespace_6f1d35e1::function_5d2e6f6a(4);
  namespace_6f1d35e1::function_4951a2c8(1, 50);
  level waittill(#"typing_complete");
  thread namespace_353d803e::function_221625b();
}

function function_ab498154(scene, speed = 10, content) {
  level endon(#"level_restarting");

  if(!isDefined(scene)) {
    scene = 3;
  }

  if(!isDefined(content)) {
    content = # "hash_90177fb520dea18";
  }

  namespace_6f1d35e1::function_f99d2e8a();
  namespace_6f1d35e1::function_487b4340(content);
  namespace_6f1d35e1::function_5d2e6f6a(scene);
  namespace_6f1d35e1::function_4951a2c8(1, speed);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(2, speed);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(3, speed);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(4, speed);
}

function cleanup(name, starting, direct, player) {
  namespace_6f1d35e1::function_b2911127(1);
}

function init_flags() {
  level flag::init("ins_activation_complete");
  level flag::init("informant_alive");
}

function init_clientfields() {}

function function_22b7fffd() {
  level thread scene::init("scene_kgb_activation");
  level thread scene::init("scene_kgb_briefing_doorman");
  level scene::add_scene_func("scene_kgb_activation", &function_6b348535, "init");
}

function function_f0db4949() {}

function function_964bc23e() {}

function function_94e65ad5() {
  level flag::wait_till("player_in_briefing_room");
  self delete();
}

function function_ea6a0033() {
  level flag::wait_till("player_in_briefing_room");
  level scene::stop("scene_kgb_ambient_security_vignette", 1);
}

function function_30c2cc8f() {
  level.player endon(#"death");
  level.player flag::set("cp_rus_kgb_player_ready");
  namespace_e77bf565::function_f6eb250d("cinematicmotion_kgb_computer");
  level thread globallogic_ui::function_7bc0e4b9(0);
  level scene::play("scene_kgb_activation", "Start");
  districts::function_a7d79fcb(["kgb_hq_front_04", "kgb_hq_intersection", "kgb_hq_east_wing", "kgb_hq_prison_stairs", "kgb_hq_elevator", "kgb_hq_armory_wing", "kgb_hq_courtyard", "kgb_hq_second_floor", "kgb_hq_conference_v2"]);
  level thread scene::play("scene_kgb_activation", "Intro_Loop");
  wait 1.75;
  level dialogue::function_96171f6d("vox_cp_rkgb_01000_adlr_imsorryithought_58");
  var_e077503c = dialog_tree::new_tree(undefined, undefined, 1, 1);
  var_e077503c dialog_tree::function_6bb91351(1);
  var_e077503c dialog_tree::add_option(#"hash_54efabbe2388ef19", undefined, undefined, undefined, 1, undefined, undefined);
  var_e077503c namespace_e77bf565::function_9090d0cb(45, 45, 25, 25);
  level notify(#"Establish_Connection");
  thread namespace_353d803e::function_17ac0ede();
  snd::client_msg(#"hash_4b5a6716aab86d8e");
  level scene::play("scene_kgb_activation", "Establish_Connection");
  level thread scene::play("scene_kgb_activation", "Loop");
  wait 1;
  var_5ed6e2b0 = dialog_tree::new_tree(undefined, undefined, 1, 1);
  var_5ed6e2b0 dialog_tree::add_option(#"hash_5c304c1661aee8e8", undefined, undefined, undefined, 1, undefined, undefined, &function_3d2a48a7, "vox_cp_rkgb_01000_adlr_wereinthetunnel_92");
  var_5ed6e2b0 dialog_tree::add_option(#"hash_5c304f1661aeee01", undefined, undefined, undefined, 1, undefined, undefined, &function_3d2a48a7, "vox_cp_rkgb_01000_adlr_werenotfriendsy_ac");
  var_5ed6e2b0 dialog_tree::run();
  namespace_6f1d35e1::function_5cffb9f2(#"hash_3a9bdfda297d3a73", 1, 1, 1, 50);
  thread namespace_353d803e::function_f258ecd8();
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_61f5c9b7(1);
  snd::play("evt_kgb_compute_data_04");
  level thread function_4d361b8e();
  wait 1.5;
  thread namespace_353d803e::function_2945d446();
  wait 1;
  var_ab5165ed = dialog_tree::new_tree(undefined, undefined, 1, 1);
  var_ab5165ed dialog_tree::add_option(#"hash_5c2c281661aac2e5", undefined, undefined, undefined, 1, undefined, undefined, &function_3d2a48a7, "vox_cp_rkgb_01000_adlr_theresalwaysapr_2b");
  var_ab5165ed dialog_tree::add_option(#"hash_5c2c251661aabdcc", undefined, undefined, undefined, 1, undefined, undefined, &function_3d2a48a7, "vox_cp_rkgb_01000_adlr_thatswhatiliket_f2");
  choice = var_ab5165ed dialog_tree::run();
  level thread function_47eb7c9e();
  var_c4ee992b = dialog_tree::new_tree(undefined, undefined, 1, 1);
  var_c4ee992b dialog_tree::add_option(#"hash_5c29401661a8b5d6", undefined, undefined, undefined, 1, undefined, undefined, &function_3d2a48a7, "vox_cp_rkgb_01000_adlr_weregettingthef_8d");
  var_c4ee992b dialog_tree::add_option(#"hash_5c293f1661a8b423", undefined, undefined, undefined, 1, undefined, undefined, &function_3d2a48a7, "vox_cp_rkgb_01000_adlr_notyetiknowyouh_bf");
  var_c4ee992b dialog_tree::run();

  if(namespace_94c47ce5::function_11b2b847()) {
    namespace_94c47ce5::function_ef6de0f0();
  }

  level dialogue::function_96171f6d("vox_cp_rkgb_01000_adlr_wellmeetyouatth_b1");
  snd::client_msg(#"hash_72fda24008633c70");
  var_8fd5aef6 = dialog_tree::new_tree(undefined, undefined, 1, 1);
  var_8fd5aef6 dialog_tree::function_6bb91351(1);
  var_8fd5aef6 dialog_tree::add_option(#"hash_54efa8be2388ea00", undefined, undefined, undefined, 1, undefined, undefined);
  level.player setviewclamp(45, 45, 25, 25, 0, 1, 0);
  var_8fd5aef6 dialog_tree::run();
  level.player setviewclamp(45, 45, 25, 25, 0, 0, 1);

  if(getdvarint(#"hash_7f69dd9ae258d917", 0)) {
    namespace_6f1d35e1::function_f99d2e8a();
    namespace_6f1d35e1::function_487b4340(#"hash_6d61a985c8ec4de");
    namespace_6f1d35e1::function_5d2e6f6a(4);
    namespace_6f1d35e1::function_4951a2c8(1, 50);
  } else {
    level thread function_28165600();
  }

  snd::client_msg(#"hash_3d26d1914456dcbe");
  snd::client_msg(#"hash_3398664455247bac");
  thread namespace_353d803e::function_8677372c();
  snd::client_msg(#"hash_441b6b70aae75c67");
  level notify(#"hash_b7d623ab42e754a");
  level scene::play("scene_kgb_activation", "End");
  namespace_e77bf565::function_f6eb250d();
}

function function_3d2a48a7(var_ef7f50ee) {
  if(!isarray(var_ef7f50ee)) {
    level dialogue::function_96171f6d(var_ef7f50ee);
    return;
  }

  for(i = 0; i < var_ef7f50ee.size; i++) {
    iprintlnbold(var_ef7f50ee[i]);
    wait 0.5;
  }
}

function function_4d361b8e() {
  level endon(#"level_restarting");
  namespace_6f1d35e1::function_5d2e6f6a(5);
  wait 1;
  namespace_6f1d35e1::function_487b4340(#"hash_5880e6b2590035e3");
  namespace_6f1d35e1::function_5d2e6f6a(6);
  wait 1;
  namespace_6f1d35e1::function_4951a2c8(1, 20);
  namespace_6f1d35e1::function_4951a2c8(2, 1);
  namespace_6f1d35e1::function_4951a2c8(3, 1);
  namespace_6f1d35e1::function_4951a2c8(4, 1);
  namespace_6f1d35e1::function_4951a2c8(5, 1);
  thread namespace_353d803e::function_56d07615();
  namespace_6f1d35e1::function_4951a2c8(6, 10);
}

function function_28165600() {
  level endon(#"level_restarting");
  thread namespace_353d803e::function_229cbb8b();
  namespace_6f1d35e1::function_487b4340(#"hash_3f07ae211c112828");
  namespace_6f1d35e1::function_5d2e6f6a(0);
}

function function_47eb7c9e() {
  level endon(#"level_restarting");
  namespace_6f1d35e1::function_487b4340(#"hash_42f252edf3fbdca0");
  namespace_6f1d35e1::function_5d2e6f6a(8);
  namespace_6f1d35e1::function_4951a2c8(1, 20);
  thread namespace_353d803e::function_49feca34();
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(2, 20);
  level waittill(#"typing_complete");
  namespace_6f1d35e1::function_4951a2c8(3, 100);
}

function function_504f208d(a_ents) {
  foreach(guy in a_ents) {
    guy.ignoreme = 1;
    guy.ignoreall = 1;
  }
}

function function_8fad2177(a_ents) {
  guy = a_ents[#"actor 1"];

  if(isDefined(guy)) {
    guy setModel("c_t9_cp_rus_kgb_hq_officer_body2");
    guy detach(guy.head);
    waitframe(1);
    guy attach("c_t9_ger_civ_male_head05c");
  }
}

function function_6b348535(a_ents) {
  level flag::wait_till("level_is_go");
  door = a_ents[#"prop 2"];
  door attach("p9_rus_door_placard_gold_01", "door_plate_a");
  door attach("p9_rus_door_placard_text_01_security", "door_plate_a");
  door namespace_e77bf565::function_aa042bc7("belikov", "door_plate_a", 73);
}