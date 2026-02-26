/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_d463fa0083062ba.gsc
***********************************************/

#using script_1fd2c6e5fc8cb1c3;
#using script_3dc93ca9902a9cda;
#using script_44aef2868ad2e317;
#using script_4ec222619bffcfd1;
#using script_779f525443585713;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\districts;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
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
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\ui\ent_name;
#using scripts\cp_common\ui\object_descriptions;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;
#namespace kgb_ins_briefing;

function starting(var_d3440450) {
  level thread namespace_e77bf565::function_277bceaa(1);
  level thread scene::init("scene_kgb_elevator_holdup");
  level thread scene::init("scene_kgb_walkup_adler");
  level thread scene::init("scene_kgb_poison_tea");
  level battlechatter::function_2ab9360b(0);
  level.checkpoint_clip = getent("checkpoint_clip", "targetname");
  level.checkpoint_clip notsolid();
  level.checkpoint_clip_right = getent("checkpoint_clip_right", "targetname");
  level.checkpoint_clip_right notsolid();
  level thread namespace_99e99ffa::function_1d90bc4a();
}

function main(var_d3440450, var_50cc0d4f) {
  level scene::add_scene_func("scene_kgb_briefing", &function_20ecf97d);
  level scene::init("scene_kgb_briefing");
  level thread function_e526d368();
  doors::function_f35467ac();
  namespace_e77bf565::function_e2e72d4(1);

  if(is_true(var_50cc0d4f)) {
    kgb_ins_prepare::function_52f0fcb3(var_d3440450);
    kgb_ins_prepare::function_84d00884();
    level thread namespace_99e99ffa::function_99e99ffa(var_d3440450);
    level thread namespace_e77bf565::function_ada6d016();
    level thread namespace_e77bf565::function_1067ebf5("rotating_object_inside_man", "team_in_elevator");
  }

  level flag::wait_till("ins_briefing_complete");

  if(isDefined(var_d3440450)) {
    skipto::function_4e3ab877(var_d3440450);
  }
}

function cleanup(name, starting, direct, player) {}

function init_flags() {}

function init_clientfields() {}

function function_22b7fffd() {}

function function_e526d368() {
  location = struct::get("briefing_entrance", "targetname");
  objectives::function_4eb5c04a("obj_briefing", location.origin, #"hash_396fd012409151c7");
  level.player endon(#"death");
  briefing_clip = getent("briefing_clip", "targetname");
  briefing_clip notsolid();
  spot = struct::get("briefing_use_prompt", "targetname");
  level scene::init("scene_kgb_briefing");
  level thread scene::play("scene_kgb_briefing", "Enter_Loop");
  level thread function_823fd8b5();
  level flag::wait_till("flag_doorman_opened_enough");
  objectives::update_position("obj_briefing", spot.origin);
  level thread function_3170644c(spot);
  level flag::wait_till("player_in_briefing_room");
  level scene::play("scene_kgb_briefing", "Enter_Start");
  level thread scene::play("scene_kgb_briefing", "Enter_Wait");
  level flag::wait_till("flag_player_seated");
  waitframe(1);
  level flag::set("flag_briefing_started");
  snd::client_msg(#"hash_c1613dbfb7218d0");
  level scene::play("scene_kgb_briefing", "Dialogue_Start");
  level thread scene::play("scene_kgb_briefing", "Dialogue_Choice");
  level thread function_8007a343();
  level flag::wait_till_any(["flag_briefing_choice_1", "flag_briefing_choice_2", "flag_briefing_choice_3"]);

  if(level flag::get("flag_briefing_choice_1")) {
    level scene::play("scene_kgb_briefing", "Response1");
  }

  if(level flag::get("flag_briefing_choice_2")) {
    level scene::play("scene_kgb_briefing", "Response2");
  }

  if(level flag::get("flag_briefing_choice_3")) {
    level scene::play("scene_kgb_briefing", "Response3");
  }

  level scene::play("scene_kgb_briefing", "Question2");
  level thread scene::play("scene_kgb_briefing_doorman", "Krav_Exit");
  level thread scene::play("scene_kgb_briefing", "Dialogue_Choice2");
  level thread function_e2236b33();
  level flag::wait_till_any(["flag_briefing_choice_4", "flag_briefing_choice_5", "flag_briefing_choice_6"]);

  if(level flag::get("flag_briefing_choice_4")) {
    level scene::play("scene_kgb_briefing", "Response4");
  }

  if(level flag::get("flag_briefing_choice_5")) {
    level scene::play("scene_kgb_briefing", "Response5");
  }

  if(level flag::get("flag_briefing_choice_6")) {
    level scene::play("scene_kgb_briefing", "Response6");
  }

  level flag::set("flag_doorman_open");
  snd::client_msg(#"hash_68f5c5f77549c363");
  level thread function_7c779373();
  level thread scene::play("scene_kgb_briefing_player", "Dialogue_End");
  level scene::play("scene_kgb_briefing", "Dialogue_End");
  namespace_e77bf565::function_f6eb250d();
  snd::client_msg(#"hash_43c1a41f59a490d6");
  snd::client_msg(#"hash_4784d9dbd4d07023");
  namespace_353d803e::music("4.0_searching_random");
  level thread scene::play("scene_kgb_briefing", "Door_Hold");
  level flag::wait_till("flag_player_outside_briefing");
  level.player thread util::blend_movespeedscale(0.85, 1);
  briefing_clip solid();
  level flag::set("ins_briefing_complete");
  level thread scene::play("scene_kgb_briefing", "Door_Close");
  namespace_353d803e::function_8dbac4c1();
}

function function_3170644c(spot) {
  spot util::create_cursor_hint(undefined, (0, 0, 0), #"hash_2700aa498f22c978");
  spot prompts::set_objective("obj_briefing");
  spot waittill(#"trigger");
  objectives::complete("obj_briefing");
  level flag::set("flag_player_seated");
  namespace_e77bf565::function_f6eb250d("cinematicmotion_kgb_computer");
  level scene::play("scene_kgb_briefing_player", "Dialogue_Start");
  level thread scene::play("scene_kgb_briefing_player", "Seated_Loop");
}

function function_5a700efe() {
  wait 3;
  level flag::set("flag_player_seated");
}

function function_8007a343() {
  level.player endon(#"death");
  var_bddef49 = dialog_tree::new_tree(undefined, undefined, 1, 1);
  var_bddef49 dialog_tree::add_option(#"hash_222f0df279f071e1", undefined, undefined, undefined, 1, "flag_briefing_choice_1");
  var_bddef49 dialog_tree::add_option(#"hash_222f0af279f06cc8", undefined, undefined, undefined, 1, "flag_briefing_choice_2");
  var_bddef49 dialog_tree::add_option(#"hash_222f0bf279f06e7b", undefined, undefined, undefined, 1, "flag_briefing_choice_3");
  var_bddef49 namespace_e77bf565::function_9090d0cb(45, 45, 45, 25);
}

function function_e2236b33() {
  level.player endon(#"death");
  var_bddef49 = dialog_tree::new_tree(undefined, undefined, 1, 1);
  var_bddef49 dialog_tree::add_option(#"hash_1ae054f2762f2886", undefined, undefined, undefined, 1, "flag_briefing_choice_4");
  var_bddef49 dialog_tree::add_option(#"hash_1ae053f2762f26d3", undefined, undefined, undefined, 1, "flag_briefing_choice_5");
  var_bddef49 dialog_tree::add_option(#"hash_1ae052f2762f2520", undefined, undefined, undefined, 1, "flag_briefing_choice_6");
  var_bddef49 namespace_e77bf565::function_9090d0cb(45, 45, 45, 25);
}

function function_97cbbccf() {
  self.ignoreme = 1;
  self.ignoreall = 1;
  gun = getweapon(#"noweapon");
  self setweapon(gun);
}

function function_823fd8b5() {
  level.player endon(#"death");

  while(!isDefined(level.doorman)) {
    waitframe(1);
  }

  level thread scene::play("scene_kgb_briefing_doorman", "Start_Loop");
  level flag::wait_till("flag_briefing_doorman");
  level.player thread util::blend_movespeedscale(0.5, 1);
  level thread function_b8c31092(3);
  level scene::play("scene_kgb_briefing_doorman", "Open");
  namespace_353d803e::music("3.0_meeting");
  level thread scene::play("scene_kgb_briefing_doorman", "Open_Loop");
  level flag::wait_till("flag_briefing_started");
  level scene::play("scene_kgb_briefing_doorman", "Close");
  level flag::wait_till("flag_doorman_open");
  level scene::play("scene_kgb_briefing_doorman", "Open");
  level thread scene::play("scene_kgb_briefing_doorman", "Open_Loop");
  level flag::wait_till("flag_player_outside_briefing");
  level scene::play("scene_kgb_briefing_doorman", "Close");
  level scene::stop("scene_kgb_briefing", 1);
  level scene::stop("scene_kgb_briefing_player", 1);
  level.player districts::function_930f8c81(["kgb_hq_conference_v2"]);
  level thread scene::play("scene_kgb_briefing_doorman", "Start_Loop");
}

function function_20ecf97d(a_ents) {
  level.var_1588c3c8 = a_ents[#"hash_39b2b3e2b4b9deaa"];
  level.var_1588c3c8 thread entname::add(#"hash_a566926dd89b47", #"axis");
  var_7198a076 = a_ents[#"hash_713540a10ff22151"];
  var_7198a076 thread entname::add(#"hash_6a1195604c394694", #"axis");
  kravchenko = a_ents[#"kravchenko"];
  kravchenko thread entname::add(#"hash_3a5989f4b42dab1e", #"axis");
  general = a_ents[#"hash_1b438d741661c069"];
  general thread entname::add(#"hash_5adf117d46cc06f9", #"axis");
  general = a_ents[#"hash_1b438c741661beb6"];
  general thread entname::add(#"hash_5adf127d46cc08ac", #"axis");
  general = a_ents[#"hash_1b438f741661c3cf"];
  general thread entname::add(#"hash_5adf137d46cc0a5f", #"axis");
  general = a_ents[#"hash_1b438e741661c21c"];
  general thread entname::add(#"hash_5adf147d46cc0c12", #"axis");
  general = a_ents[#"hash_1b4391741661c735"];
  general thread entname::add(#"hash_5adf157d46cc0dc5", #"axis");
  general = a_ents[#"hash_1b4390741661c582"];
  general thread entname::add(#"hash_5adf167d46cc0f78", #"axis");
}

function function_953371eb() {
  var_4f2ba130 = self getweaponslist(1);

  foreach(e_w in var_4f2ba130) {
    self takeweapon(e_w);
  }

  level flag::wait_till("flag_player_outside_briefing");
  w_pistol = getweapon(#"hash_5dbab0bd6a78c6e5");
  self giveweapon(w_pistol);
  self switchtoweapon(w_pistol);
}

function function_b8c31092(timer) {
  wait timer;
  level flag::set("flag_doorman_opened_enough");
}

function function_7c779373() {
  level waittill(#"hash_dc5807361c582");

  if(level flag::get_any(["flag_briefing_choice_5", "flag_briefing_choice_6"])) {
    vox = "vox_cp_rkgb_01500_gorb_verywellseetoit_13";
  } else {
    vox = "vox_cp_rkgb_01500_gorb_soyoullseetoit_ae";
  }

  level.var_1588c3c8 dialogue::queue(vox);
}