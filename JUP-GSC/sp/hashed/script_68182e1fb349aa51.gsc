/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_68182e1fb349aa51.gsc
*************************************************/

#using script_102d83a437e2b29f;
#using script_10ad0d85ed5c421;
#using script_1b5e21ec19a8960b;
#using script_2386704e3c08f8ca;
#using script_23c3032ee0d6f079;
#using script_24e4405cf93f20ed;
#using script_2e412bc5469193c;
#using script_33b87726793c8128;
#using script_39ffaf38efb8b030;
#using script_3a8f9ace195c9da9;
#using script_3ae866a6dd08daf9;
#using script_3cb1beed718e7650;
#using script_46b342a079938c68;
#using script_47b1f3ded54580b8;
#using script_48324b060b129b7b;
#using script_5ac996d59c382112;
#using script_68182e1fb349aa51;
#using script_7db80de62748c769;
#using script_7e7eaa110dbb1c83;
#using scripts\anim\dialogue;
#using scripts\anim\utility_common;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\basic_wind;
#using scripts\common\callbacks;
#using scripts\common\lighting;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_aianim;
#using scripts\cp\coop_stealth;
#using scripts\cp\cp_checkpoint;
#using scripts\cp\cp_claymore;
#using scripts\cp\cp_compass;
#using scripts\cp\cp_create_script_utility;
#using scripts\cp\cp_hud_message;
#using scripts\cp\cp_objectives;
#using scripts\cp\cp_weapon;
#using scripts\cp\globallogic;
#using scripts\cp\munitions;
#using scripts\cp\nvg_ai;
#using scripts\cp\player\offhand_box;
#using scripts\cp\spawning;
#using scripts\cp\starts;
#using scripts\cp\utility;
#using scripts\cp\utility\player;
#using scripts\cp\weapon;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\equipment_interact;
#using scripts\cp_mp\killstreaks\cluster_spike;
#using scripts\cp_mp\stealth\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\stealth\enemy;
#using scripts\stealth\event;
#using scripts\stealth\manager;
#using scripts\stealth\utility;
#namespace cp_jup_ranch;

function main() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0)) {
    return;
  }

  namespace_efc90da1b0662f2c::main();
  namespace_beeb5bb1aac36797::main();
  namespace_55fcf4b86e1f5da0::main();
  thread namespace_5bdaf1e2d5da506e::main();
  thread namespace_9faa61bf1903f9b8::main();

  if(level.createfx_enabled) {
    return;
  }

  if(!isDefined(level.valstruct)) {
    level.valstruct = spawnStruct();
  }

  function_61411c49eaca86e2("farah");
  level.var_2a226e97d7ab297 = "jup_execution_first_person_farah_001";
  scripts\cp_mp\utility\game_utility::registernightmap();
  scripts\cp\utility\player::overridevisionsetnightforlevel("nvg_base_color_outline_jup_ranch");

  if(level.mapname == "cp_jup_ranch") {
    level.var_61a54be8038f3a95 = 1;
    level.var_41957e049a51e8bc = "stealth_ai_music_bundle_cp_jup_ranch";
    level.var_8e4a4897f3b80823 = 1;
    level.var_3b1ccf105481b5e6 = 1;
  }

  coop_mode_enable("sp_stealth");
  level thread function_fb457f7cdf0ac39e();
  add_start("intro", &start_intro, &intro_flow);
  add_start("search", &start_search, &function_bd4866180ba60842);
  add_start("escape", &function_7c921888c7d44907, &function_17006546f61dd733);
  add_start("exfil", &function_b0f6d6910f3b8af8, &function_cce1ca1325cccbe4);
  add_start("stealth_tuning", &function_fa91d979da460f3b, &function_f27f353ab374e92d);
  add_start("rescue_alex", &function_95ec6454223ce5de, &function_157750052141e0e2);
  function_bb3e0c926b0667c4("search,escape,exfil,stealth_tuning,rescue_alex");
  scripts\common\values::group_register("infil_player", ["offhand_weapons", "prone", "melee", "crouch", "cp_munitions", "sprint", "killstreaks", "stance_change"]);
  thread function_ac2e42c678489275();
  function_cdfd74e95368bd63(8000);
  level.valstruct val::set("level", "stealth_ttlt_lkp", 16000);
  level.valstruct val::set("level", "stealth_ttlt_not_lkp", 8000);
  function_8368f8fe908ce8be(3000);
  function_c3c56969a259ab89(1500);
  thread function_87a8f380543e4b27();
  thread nvg_player();
  function_d525f1534752bfc7();
  function_2cfef434ce6a1c44();
  function_988743dcde6885a6();
  function_635532f54eac01c7();
  function_c4d555bf9485ac3b();
}

function nvg_player() {
  setdvarifuninitialized(@ "hash_6cb1c50089b6d4d6", 1);
  setdvarifuninitialized(@ "hash_2d59deb63c029ea8", 0);
  setdvarifuninitialized(@ "hash_636b1c9e9c44d382", 0);
  thread function_b1b8627b47c5cb79(getdvarint(@ "hash_6cb1c50089b6d4d6"));
}

function function_b1b8627b47c5cb79(var_103e6bcc518ecb9d) {
  if(istrue(var_103e6bcc518ecb9d)) {
    flag_wait("player_spawned_with_loadout");
    return;
  }

  flag_wait("player_spawned_with_loadout");
}

function function_2cfef434ce6a1c44() {
  level.custom_onspawnplayer_func = &onplayerspawned;
  level.custom_onplayerconnect_func = &onplayerconnect;
  level.var_eedf56f300b6c661 = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0, 1, 1);
  registersharedfunc("killstreak", "enableDroneTracking", &enableDroneTracking);
  scripts\common\callbacks::add("player_connect", &function_389e2a3700a9adc8);
}

function onplayerconnect(player) {}

function function_389e2a3700a9adc8(player) {
  player = self;
  player endon("disconnect");
  waitframe();

  if(should_play_intro() && !istrue(level.var_70ba8a796731bebb)) {
    level.var_70ba8a796731bebb = 1;
    anim_org = function_7a18da6e48b71c35("intro_anim_org");
    anim_org scene::pre_stream(player, undefined, -1, "jup_ranch_infil");
  }
}

function onplayerspawned() {
  thread function_e810892fbd8560c6();
}

function function_988743dcde6885a6() {
  setDvar(@ "hash_93b8374b5b3983a8", 0);
}

function function_e810892fbd8560c6() {
  level endon("game_ended");
  self waittill("disconnect");
  setDvar(@ "hash_93b8374b5b3983a8", 1);
  setDvar(@ "hash_42ec046969fe5985", 0);
}

function function_635532f54eac01c7() {
  level.objectivesfunc = &function_c2a86f682bf1ab71;
  level thread scripts\cp\cp_objectives::objectives_init();
}

function function_c4d555bf9485ac3b() {
  level.var_4a4e365abca4649c = spawnStruct();
  level.var_4a4e365abca4649c.origin = (1649, -1870, 402);
  level.var_4a4e365abca4649c.angles = (0, 0, 0);
  level.var_5966c39cb60075f1 = &function_da58f5fca036ffaa;
  level.var_3715dfcccf50ccdb = &function_297f5406ec15234b;
  level.var_9696753a29908c90 = 1;
  level.var_8ee9c5604a4fb6c0 = 2048;
  level.var_318ceae290567709 = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 0, 0, 1, 0);
  level.var_ee2589b82e1aed1b = [];
  level.var_ee2589b82e1aed1b["kill_squad_patrol"] = [];
  level.var_ee2589b82e1aed1b["kill_squad_patrol_exfil_left"] = [];
  level.var_ee2589b82e1aed1b["kill_squad_patrol_exfil_right"] = [];
  setup_create_script();
  scripts\cp\cp_checkpoint::function_4bfef22c47a65be5("flight_recorder_found");
  scripts\cp\cp_checkpoint::function_63e1728c535014c9("flight_recorder_found", &scripts\cp\cp_checkpoint::function_5b0a03741aa420d7);
  level thread function_fc4803dc319a81d2();
  function_e00cc8c1c5cc38fb(1);
  scripts\cp\cp_compass::setupminimap("compass_map_cp_jup_ranch");
  namespace_2db57d98c14dbbf::function_b04f37f19c6631e0();
  level function_77765e5dd4c9db54();
  level thread scripts\cp\cp_objectives::run_debug_start_objective();
  namespace_4c21e3c2da3d8585::function_57912920f3ffc52b();
  thread namespace_4c21e3c2da3d8585::function_1a36b4303dafa62();
  thread function_dc2ca7e835560d4e();

  level.devgui_setup_func = &function_d8fb18a58a875db6;
  level thread setup_map_specific_devgui();
}

function function_dc2ca7e835560d4e() {
  level.player endon("death");
  level endon("game_ended");

  while(true) {
    if(level.player scripts\cp\utility::touchingbadtrigger(1)) {
      level.player setscriptablepartstate("burning", "active");
    } else {
      level.player setscriptablepartstate("burning", "neutral");
    }

    wait 0.2;
  }
}

function function_57044f11a129c99d() {
  if(isDefined(game["phones_found"])) {
    foreach(crate in level.var_c46b5c83b58aefb4) {
      if(istrue(game["phones_found"][index])) {
        crate.var_1ab92c9426b975ca = 1;
      }
    }
  }
}

function function_bc14acc20f41302f() {
  flag_wait("dungeon_intro_complete");
  waitframe();
  namespace_d18e5dabdf7709e4::function_1ebfa39eec539a06(1);
}

function function_da58f5fca036ffaa() {
  self visionsetthermalforplayer("flir_2_color_gradient");
  scripts\cp\munitions::check_for_empty_munitions();
  scripts\cp\munitions::assign_highest_full_slot_to_active();
  self.munition_splash_supress = undefined;
  self.var_7269deeba689cd65 = 1;
  self.var_a8440da4d5f5a9ad = 1;
  level thread function_2c2cfa49e4db44ce();
  scripts\cp\utility::giveperk("specialty_hack");
}

function function_770ea0c7f3dfcda() {
  if(level.start_point != "search") {
    return;
  }

  flag_wait("flag_dungeon_intro_complete");
}

function function_2c2cfa49e4db44ce() {
  flag_wait("dungeon_load_finished");

  if(isDefined(level.var_1b908bf18691b097)) {
    if(!istrue(level.var_1b908bf18691b097.nvg)) {
      namespace_1170726b2799ea65::function_ed4f7e1b0b42e2c4(1);
    }
  }
}

function setup_create_script() {
  scripts\cp\cp_create_script_utility::init_create_script_for_level();
  scripts\cp\cp_create_script_utility::register_create_script_arrays("cp_jup_ranch_create_script", "cp_jup_ranch_create_script", level.scripted_spawner_func.size, &namespace_c2826c5d1775f958::main);
}

function function_fb457f7cdf0ac39e() {
  level notify("level_setStealthSettings");
  level endon("level_setStealthSettings");

  while(!isDefined(level.stealth)) {
    waitframe();
  }

  hiddenranges["prone"] = 8192;
  hiddenranges["crouch"] = 8192;
  hiddenranges["stand"] = 8192;
  spottedranges["prone"] = 8192;
  spottedranges["crouch"] = 8192;
  spottedranges["stand"] = 8192;
  var_8f3f480583606401["prone"] = 1;
  var_8f3f480583606401["crouch"] = 1;
  var_8f3f480583606401["stand"] = 1;
  scripts\stealth\utility::set_detect_ranges(hiddenranges, spottedranges, var_8f3f480583606401);
  level.stealth.override_damage_auto_range = 128;
  level.stealth.override_damage_sight_range = 1200;
  level thread function_524c262c0a2973a();
  flag_set("stealth_ranges_initialized");
}

function function_524c262c0a2973a() {
  level endon("game_ended");
  flag_wait("flag_dungeon_intro_complete");

  while(!isDefined(level.player)) {
    waitframe();
  }

  level.player endon("death");
  level.player endon("disconnect");

  while(!isDefined(level.player.var_bec156d5a2918db9)) {
    waitframe();
  }

  var_3098da2405473bb9 = "start";
  function_f73da2869bc109b1("found_corpse", 2);
  function_e5e2e8722feb4e00("found_corpse", 2);

  while(true) {
    waitframe();

    if(level.player.var_bec156d5a2918db9 == var_3098da2405473bb9) {
      continue;
    }

    if(level.player.var_bec156d5a2918db9 == "hilltop") {
      level.valstruct val::set("level", "ai_eventlist", "ranch_hilltop_aieventlist");
      function_f73da2869bc109b1("found_corpse", 2);
      function_e5e2e8722feb4e00("found_corpse", 2);
      level.event_distances["spotted"]["bottle_impact"] = 300;
      level.event_distances["hidden"]["bottle_impact"] = 300;
      scripts\stealth\manager::set_event_distances(level.event_distances);
    } else if(var_3098da2405473bb9 == "hilltop") {
      level.valstruct val::set("level", "ai_eventlist", "ranch_aieventlist");
      function_f73da2869bc109b1("found_corpse", 2);
      function_e5e2e8722feb4e00("found_corpse", 2);
    }

    var_3098da2405473bb9 = level.player.var_bec156d5a2918db9;
  }
}

function function_20a67c381e6b83bc() {
  if(!isDefined(level.stealth)) {
    return false;
  }

  enemies = function_3f31da16d025933b();

  foreach(enemy in enemies) {
    if(enemy.ignoreall) {
      continue;
    }

    if(!isDefined(enemy.stealth)) {
      return false;
    }

    if(enemy function_6a86dd83c01f8faa()) {
      return false;
    }
  }

  return true;
}

function function_fc4803dc319a81d2() {
  level thread wait_for_pre_game_period();
  level thread wait_for_strike_init_complete();
  flag_wait("start_mission_flow");
  level thread function_76475ab344bd0cf3();
  level.player waittill("loadout_class_selected");
  scripts\cp\coop_stealth::function_53c55a0c7af36050();
  scripts\cp\coop_stealth::function_18cd746ff947ff3c("ranch");
  level thread function_3b80f9364e41d471();
  level thread function_c0926f2d29510c1c();
}

function function_c0926f2d29510c1c() {
  if(!function_4bcd86b926d48155()) {
    flag_wait("flag_dungeon_intro_complete");
  }

  level thread obj_flow();
  level thread function_dd9645b711916a73();
  level thread function_b27598ebbbfaa3b6();
  level thread function_a3b78aa482a0cd19();
  level thread function_4ba8a7b003d2a3d8();
  level thread function_c6541a1eb7bd31a1();
  level thread function_9d0e41419bcd28f5();
  level thread function_8488742ee64fe782();
  level thread recorder_house_sentry();
  level thread function_7df46845d188e201();
  level thread scripts\cp\player\offhand_box::offhand_box_setup();
}

function wait_for_pre_game_period() {
  level endon("game_ended");
  flag_wait("bsp_structs_initialized");
  flag_wait("level_ready_for_script");

  while(!isDefined(level.player)) {
    waitframe();
  }

  flag_set("start_mission_flow");
}

function wait_for_strike_init_complete() {
  level endon("game_ended");

  if(flag_exist("strike_init_done")) {
    flag_wait("strike_init_done");
  }
}

function function_30160e0f4ccb9aaf() {
  if(!isDefined(level.player_rig)) {
    level.player_rig = spawn_anim_model("player_rig");
  }

  if(!isDefined(level.var_5e84860df880bbce)) {
    level.var_5e84860df880bbce = spawn_anim_model("3rd_person_player");
  }

  level.player_rig hide();
  function_a88c360e19062b00(0);
}

function play_intro() {
  anim_org = function_7a18da6e48b71c35("intro_anim_org");

  if(should_play_intro() && !istrue(level.var_70ba8a796731bebb)) {
    level.var_70ba8a796731bebb = 1;
    anim_org = function_7a18da6e48b71c35("intro_anim_org");
    anim_org scene::pre_stream(level.player, undefined, -1, "jup_ranch_infil");
  }

  flag_wait("dungeon_load_finished");
  level.player waittill("loadout_class_selected");
  level.player scripts\common\values::group_set("infil_player", 0);
  level.player scripts\cp_mp\utility\game_utility::function_20cb4a5f727abe6e(0);

  if(!scripts\cp\starts::is_first_start()) {
    thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.player, 0);
    flag_set("flag_dungeon_intro_complete");
    return;
  }

  thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.player, 0, 1);
  thread infil_music();
  level.player.var_f296f7e55b9e9150 = getdvarint(@ "hash_b38fcf293d1e91a8");
  level.player utility::hidehudenable();

  if(isDefined(level.player)) {
    level.player playerhide();
  }

  if(should_play_intro()) {
    thread namespace_9faa61bf1903f9b8::function_89c1c5d06e96b565();
    thread vo_infil();
    thread function_2fc988b03f81818c();
    anim_org scripts\common\scene::play(undefined, undefined, "jup_ranch_infil");
  }

  level.player playershow();
  function_860a5c1214190a7c(anim_org);
  thread namespace_9faa61bf1903f9b8::function_804e583857d3cde0();
  thread function_bbbe8a635002a8aa();
  level.player scripts\common\values::group_set("infil_player", 1);

  if(getdvarint(@ "hash_636b1c9e9c44d382")) {
    thread function_3306b8e88262dd5c(anim_org);
  }
}

function function_b3739f0bd0a78d4f() {
  struct = getStruct("start_intro", "targetname");

  if(isDefined(struct)) {}
}

function function_c73bedd682445503(var_cfbabf722f371f00, scenenode, var_a30e8edeaa31671a) {
  var_cac6fef29bc4e7ad = [];
  actor = self;

  if(istrue(var_a30e8edeaa31671a)) {
    var_cac6fef29bc4e7ad[0] = actor getxcamposition(var_cfbabf722f371f00, 1, scenenode.origin, scenenode.angles);
    var_cac6fef29bc4e7ad[1] = actor getxcamangles(var_cfbabf722f371f00, 1, scenenode.origin, scenenode.angles);
    return var_cac6fef29bc4e7ad;
  } else {
    movedelta = getmovedelta(var_cfbabf722f371f00, 0, 1);
    rotation = getangledelta3d(var_cfbabf722f371f00, 0, 1);
    rotatedtranslation = rotatevector(movedelta, actor.angles);
    origin = actor.origin + rotatedtranslation;
    angles = combineangles(actor.angles, rotation);
    var_cac6fef29bc4e7ad[0] = origin;
    var_cac6fef29bc4e7ad[1] = angles;
  }

  return var_cac6fef29bc4e7ad;
}

function function_3306b8e88262dd5c(animnode) {}

function infil_music() {
  setmusicstate("mx_ranch_infil");
}

function vo_infil() {
  farah = level.player;
  alex = level;
  sequence = [alex, 0.3, "dx_cp_rnch_vist_alex_youinposition", farah, 0.4, "dx_cp_rnch_vist_fara_affirmeyesonmultiple", alex, 0.3, "dx_cp_rnch_vist_alex_looksliketheyresecur", farah, 0.5, "dx_cp_rnch_vist_fara_theulfdidntdothiswen"];
  say_sequence(sequence, 1, 2);
}

function motorcycle_intro_end() {
  if(!isDefined(level.var_7d812ba1dbc5c9af)) {
    level.var_7d812ba1dbc5c9af = spawn_anim_model("dirtbike");
  }

  anim_org = function_7a18da6e48b71c35("intro_anim_org");
  anim_org thread anim_first_frame_solo(level.var_7d812ba1dbc5c9af, "exfil");
  level notify("motorcycle_intro_end");
}

function function_bbbe8a635002a8aa() {
  wait 15;
  namespace_b96fa4d8ce10f926::function_6ae6331457ff833d();
}

function play_outro(var_331d53db9a7c323) {
  flag_set("flag_dungeon_outro_start");
  level.player.var_f296f7e55b9e9150 = getdvarint(@ "hash_b38fcf293d1e91a8");
  outro_cleanup();

  if(!istrue(var_331d53db9a7c323)) {
    anim_org = function_7a18da6e48b71c35("outro_anim_org");
    anim_org scripts\common\scene::play(undefined, undefined, "jup_ranch_exfil");
  }

  flag_set("flag_dungeon_outro_complete");
}

function outro_cleanup() {
  if(isDefined(level.var_7d812ba1dbc5c9af)) {
    level.var_7d812ba1dbc5c9af hide();
  }

  level.player playerhide();
  function_a88c360e19062b00(0);
}

function function_c2a86f682bf1ab71() {
  level.objectives_table = "cp/cp_jup_ranch_objectives.csv";
  level.objectivesmatrixtable = "cp/cp_jup_ranch_objectives_matrix.csv";
  level.objectiveregistration = &function_77765e5dd4c9db54;
  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

function function_77765e5dd4c9db54() {
  level endon("game_ended");
  flag_wait("level_ready_for_script");
  thread registerobjective("obj_phones");
  thread registerobjective("obj_search", undefined, &function_10e7f2840996cff8);
  thread registerobjective("obj_escape", undefined, &obj_escape_start);
}

function function_d525f1534752bfc7() {
  setDvar(@ "sm_sunsamplesizenear", 1.25);
  setDvar(@ "hash_7686fcb92ccc5edb", 4);
  setDvar(@ "r_umbraaccurateocclusionthreshold", 2048);
  setDvar(@ "hash_1dde331a8e0153d8", 8);
  setDvar(@ "hash_63eb1893f96ac98d", 8);
  setDvar(@ "hash_f983d652b2640512", 400);
  setDvar(@ "hash_35bab6c292a12242", 1000);
  flag_set("infil_complete");
}

function function_76475ab344bd0cf3() {
  level thread function_d72190c4b04b681a();
  level thread function_dafb3a3f4a103ccd();
  function_30160e0f4ccb9aaf();
}

function function_d72190c4b04b681a() {
  var_92d80bbd11ae8f3b = getStructArray("veh_initial_truck", "targetname");

  foreach(var_af695cb17fb8e179 in var_92d80bbd11ae8f3b) {
    veh = namespace_ba155a12c323dc5a::function_136d8a6a5c016d7e(var_af695cb17fb8e179);
    veh function_65aa053c077c003a(1);
    veh.var_eb504fc7e1cfeb4c = 1;
  }
}

function function_dafb3a3f4a103ccd() {
  flag_wait("player_spawned_with_loadout");
  level.var_c91a0e8fe84fb300 = &scripts\cp\cp_claymore::function_e2b6464932ab9b06;
}

function function_4380ce742d375bba() {
  flag_wait("dungeon_load_finished");
  level.var_69424e5ded8586a3 = [];
  level.var_9c949dc48c5bdffa = [];
  level.var_d0d5526a0a139791 = [];
  level.var_e746e3bf44ecc904 = undefined;
  flag_wait("stealth_ranges_initialized");
  level thread vo_jltv_reinforcements();
  level thread function_b682757cf13272f2();
  level thread function_bba4b941623c75f2();
  level thread function_611d1fbdcc4f83ab();
  level thread function_6f3f36ca225a1f02();
  level thread function_a73f32ec62ccefb1();
  var_15996dd4490eba0f = getDvar(@ "hash_debe79d6a0c9331e", "default");

  if(!isDefined(var_15996dd4490eba0f) || var_15996dd4490eba0f == "default") {
    if(!function_4bcd86b926d48155()) {
      level.var_57157ccb0f54801 = function_6149b301ce19988b("stealth_ai", &function_b863dcd61d90ee40);
      level.var_e746e3bf44ecc904 = function_6149b301ce19988b("stealth_ai_intro", &function_b863dcd61d90ee40);
    }
  }

  wait 3;
  allai = getaiarray();

  foreach(ai in allai) {
    ai function_d493e7fe15e5eaf4("jup_sandbox_ranch");
  }

  flag_set("ranch_ais_initialized");
}

function function_b863dcd61d90ee40(group_name, func) {
  namespace_a0852b262a68d01::function_fac67371e80874db(group_name, func);
  function_916233af1855619c();
  thread function_46645d44530594cf();
  thread function_c0a7a77b68c2fdfa();
  thread function_ddf2ee39214008f9();
  thread function_24d8a34dc26894d2();
  function_6afcdc96a6ce9a56("jup_sandbox_ranch", &function_cc116388b57ace53);

  thread function_f670b8ed0116f85f();

  thread function_89a3d3da215fc2a8();
  thread scripts\cp\coop_stealth::stealth_watchweaponfired("ranch");

  if(isDefined(self.var_55cc71192b8f1931) && array_contains(self.var_55cc71192b8f1931, "dem_alert")) {
    self.var_7bd1c0edbaafb6e0 = "alert";
  }

  self function_8bbcaeb23a1512ef("all", 1);

  if(isDefined(self.spawner) && isDefined(self.spawner.script_patrolname) && self.spawner.script_patrolname != "") {
    namespace_6faf037a3568d157::function_b41baf16d62d21d8(self.spawner.script_patrolname, self, 1);

    if(isDefined(self.spawner.target)) {
      namespace_6faf037a3568d157::function_cc7045b3f96482ce();
    }

    namespace_6faf037a3568d157::function_e1f50b1f60aa1b25(self.spawner.script_patrolname, 3, 75, 75, 1);
    thread function_46e4a8cf824cfcf3();

    if(level.player isxb3player() || level.player isps4player()) {
      thread function_d9d2626b54a2c5e9();
    }

    scripts\stealth\utility::set_stealth_func("event_combat", &function_ee2c06b142d32bf7);
  }

  if(isDefined(self.spawner) && issubstr(group_name.group_name, "reinforcements_")) {
    if(level.var_91ebedd109ae8466 >= 3) {
      thread function_50bcab0484efab3b(2);
    }
  }
}

function function_d9d2626b54a2c5e9() {
  self endon("death");

  if(self.spawner.script_patrolname == "kill_squad_patrol") {
    if(level.var_ee2589b82e1aed1b[self.spawner.script_patrolname].size >= 2) {
      self laserforceoff();
    } else {
      level.var_ee2589b82e1aed1b[self.spawner.script_patrolname] = array_add(level.var_ee2589b82e1aed1b[self.spawner.script_patrolname], self);
    }
  }

  if(self.spawner.script_patrolname == "kill_squad_patrol_exfil_right" || self.spawner.script_patrolname == "kill_squad_patrol_exfil_left") {
    function_2c008ea33c3929c6();
  }
}

function function_2c008ea33c3929c6() {
  level.var_ee2589b82e1aed1b["kill_squad_patrol"] = array_removedead_or_dying(level.var_ee2589b82e1aed1b["kill_squad_patrol"]);

  if(level.var_ee2589b82e1aed1b["kill_squad_patrol"].size > 1) {
    self laserforceoff();
    return;
  }

  if(level.var_ee2589b82e1aed1b["kill_squad_patrol"].size > 0) {
    if(level.var_ee2589b82e1aed1b[self.spawner.script_patrolname].size >= 1) {
      self laserforceoff();
    } else {
      level.var_ee2589b82e1aed1b[self.spawner.script_patrolname] = array_add(level.var_ee2589b82e1aed1b[self.spawner.script_patrolname], self);
    }

    return;
  }

  if(level.var_ee2589b82e1aed1b[self.spawner.script_patrolname].size >= 1) {
    self laserforceoff();
    return;
  }

  level.var_ee2589b82e1aed1b[self.spawner.script_patrolname] = array_add(level.var_ee2589b82e1aed1b[self.spawner.script_patrolname], self);
}

function function_46e4a8cf824cfcf3() {
  self endon("death");
  wait 2;
  self.var_7bd1c0edbaafb6e0 = "alert";
}

function function_2fc988b03f81818c() {
  wait 6;
  level notify("show_chyrons");
}

function function_5ee9957d137e621b(event) {
  self endon("death");

  switch (event.typeorig) {
    case #"hash_f796130a9b9cec5":
    case #"hash_2d1406e602f0875d":
    case #"hash_641050446d8ad59e":
    case #"hash_9567f12963cd5717":
    case #"hash_9e02cd4a0f3ca981":
    case #"hash_f4eac828cdfe2da9":
      if(istrue(level.player.discovered)) {
        return 1;
      } else {
        return 0;
      }
    case #"hash_161d2d6c65d1cc82":
      if(!flag("flag_player_in_curtained_area")) {
        if(istrue(level.player.discovered)) {
          return 1;
        } else {
          return 0;
        }
      } else {
        return 1;
      }
    case #"hash_9ef2596c4c4ce657":
      return 0;
    case #"hash_c5c143ba1ce58744":
      if(istrue(level.player.discovered)) {
        return 1;
      } else {
        return 0;
      }
    default:
      return 0;
  }
}

function function_740482dd5a644509(event) {
  ignore_events = ["bulletwhizby", "silenced_shot", "silenced_shot_impact", "death", "ally_killed", "ally_damaged", "footstep", "footstep_sprint", "footstep_walk", "projectile_impact", "door_bash", "landing", "missile_spawned"];

  if(array_contains(ignore_events, event.typeorig)) {
    if(isDefined(event.origin)) {
      if(!self hastacvis(event.origin, 1) && !function_ca53f38b1eb70113(event.origin, 1, level.stealth.override_damage_auto_range)) {
        return true;
      } else {
        if(scripts\cp_mp\stealth\utility::function_e39a555170607456()) {
          line(self.origin, self.origin + (0, 0, 10000), (1, 0, 0), 1, 0, 100000);
          print3d(self.origin + (0, 0, 50), "<dev string:x1c>" + event.typeorig, (1, 0, 0), 1, 1, 50000, 1);
        }
      }
    }
  }

  if(function_9a9b91c11482389f(event)) {
    return true;
  }

  if(event.typeorig == "saw_corpse") {
    if(isDefined(self.vehicle) && isDefined(self.vehicle.var_f626b845d8c284e2)) {
      self.vehicle.var_f626b845d8c284e2 = 1;
      self.vehicle.var_fda9ea513d557243 = event;
      return false;
    }
  }

  if(event.type == "combat") {
    if(scripts\cp\spawning::is_specified_unittype("juggernaut")) {
      self function_9f82c74eb1b7caf9(0);
      self.var_2626d6897d71b728 = 2000;
      scripts\cp\spawning::set_goal_radius(4096);
      self setgoalpos(event.origin);
      return false;
    }

    self laseron();
    self.goalradius = 1024;
    self setgoalpos(event.origin);
    return false;
  }

  return false;
}

function function_8c7693e96a9c9933(event) {
  if(!isDefined(event.typeorig)) {
    return 0;
  }

  if(!isDefined(event.entity)) {
    return 0;
  }

  if(event.typeorig != "grenade danger" && event.typeorig != "missile_spawned") {
    return 0;
  }

  if(!isDefined(event.entity.weapon_name)) {
    return 0;
  }

  var_1c01519bd9cec9a6 = is_equal(event.entity.weapon_name, "cluster_spike_jup_mp");
  return var_1c01519bd9cec9a6;
}

function function_9a9b91c11482389f(event) {
  ignoreevents = [];

  if(isDefined(self.stealth.var_90cdc499fc2bddd7)) {
    ignoreevents = array_merge(ignoreevents, self.stealth.var_90cdc499fc2bddd7);
  }

  if(array_contains(ignoreevents, event.typeorig)) {
    return true;
  }

  if(isDefined(event.typeorig) && event.typeorig == "missile_spawned" || event.typeorig == "grenade danger") {
    return true;
  }

  if(!isDefined(event.entity)) {
    return false;
  }

  if(!isDefined(event.entity.weapon_name)) {
    return false;
  }

  var_1c01519bd9cec9a6 = is_equal(event.entity.weapon_name, "geiger_counter_mp") || is_equal(event.entity.weapon_name, "cluster_spike_jup_mp");

  if(var_1c01519bd9cec9a6) {
    return true;
  }

  return false;
}

function function_ca53f38b1eb70113(origin, checkfov, dist) {
  if(!isDefined(checkfov)) {
    checkfov = 1;
  }

  if(checkfov && !within_fov(self.origin, self.angles, origin, cos(180))) {
    return 0;
  }

  eye_origin = function_cabcc7c3e8682497();
  eye_angles = function_b071913d4b91319();

  if(!isDefined(dist)) {
    dist = 1024;
  }

  if(function_86c6afb41a6c383b(eye_origin, origin, level.stealth.override_damage_auto_range)) {
    return 1;
  }

  if(checkfov) {
    if(isai(self) && !self aipointinfov(origin)) {
      return 0;
    }
  }

  sight_contents = level.var_318ceae290567709;
  return scripts\engine\trace::ray_trace_passed(eye_origin, origin, [self], sight_contents);
}

function function_86c6afb41a6c383b(start, end, dist) {
  if(!isDefined(start) || !isDefined(end)) {
    return false;
  }

  return distancesquared(start, end) <= dist * dist;
}

function function_cabcc7c3e8682497() {
  if(isDefined(self.eyeorigin)) {
    if(self.eyeorigintime == gettime()) {
      return self.eyeorigin;
    }

    if(isDefined(self.eyeoriginpos) && self.eyeoriginpos == self.origin) {
      return self.eyeorigin;
    }
  }

  if(isai(self)) {
    self.eyeorigin = self getEye();
  } else {
    self.eyeorigin = self gettagorigin("tag_eye");
    self.eyeoriginpos = self.origin;
  }

  self.eyeorigintime = gettime();
  return self.eyeorigin;
}

function function_b071913d4b91319() {
  if(isDefined(self.eyeangles)) {
    if(self.eyeanglestime == gettime()) {
      return self.eyeangles;
    }

    if(isDefined(self.eyeanglesang) && self.eyeanglesang == self.angles) {
      return self.eyeangles;
    }
  }

  self.eyeangles = self gettagangles("tag_eye");
  self.eyeanglestime = gettime();
  return self.eyeangles;
}

function function_c0a7a77b68c2fdfa() {
  level endon("game_ended");
  var_da550b5655593cfe = self.script_dialogue;
  self waittill("death", attacker);

  if(isDefined(attacker)) {
    if(attacker == level.player) {
      if(self.alertlevel == "combat") {
        level.var_9c949dc48c5bdffa[level.var_9c949dc48c5bdffa.size] = gettime();
        level notify("killed_combat_ai", var_da550b5655593cfe);
      } else {
        level.var_d0d5526a0a139791[level.var_d0d5526a0a139791.size] = gettime();
        level notify("killed_unaware_ai", var_da550b5655593cfe);
      }

      return;
    }

    if(isDefined(level.ally) && attacker == level.ally) {
      if(self.alertlevel == "combat") {
        level.var_9c949dc48c5bdffa[level.var_9c949dc48c5bdffa.size] = gettime();
        level notify("killed_combat_ai", var_da550b5655593cfe);
        return;
      }

      level.var_d0d5526a0a139791[level.var_d0d5526a0a139791.size] = gettime();
      level notify("killed_unaware_ai", var_da550b5655593cfe);
    }
  }
}

function function_1a5601bd2b19f321(tag_array) {
  ai_array = getaiarray("axis");
  ai_array = function_fdc9d5557c53078e(ai_array);
  return_array = [];

  foreach(ai in ai_array) {
    if(isDefined(ai.script_dialogue)) {
      if(array_contains(tag_array, ai.script_dialogue)) {
        return_array = array_add(return_array, ai);
      }
    }
  }

  return return_array;
}

function function_ddf2ee39214008f9() {
  self endon("death");
  level endon("game_ended");

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(attacker == level.player) {
      level notify("player_causing_damage");
    }

    if(attacker == level.player && self[[self.fnisinstealthcombat]]()) {
      self.var_2934f33785c2acc = gettime();
    }
  }
}

function function_4a9c38c112e95771(numenemies, var_39c7280c1ef8e754) {
  enemies = function_3f31da16d025933b();
  var_5db02447e1939f7f = 0;
  enemies = array_removeundefined(enemies);

  foreach(ai in enemies) {
    if(isDefined(ai.var_2934f33785c2acc) && gettime() - ai.var_2934f33785c2acc <= 10000) {
      var_5db02447e1939f7f++;
    }
  }

  for(i = level.var_9c949dc48c5bdffa.size - 1; i >= 0; i--) {
    if(gettime() - level.var_9c949dc48c5bdffa[i] <= 10000) {
      var_5db02447e1939f7f++;
      continue;
    }

    break;
  }

  return var_5db02447e1939f7f >= numenemies;
}

function function_611d1fbdcc4f83ab() {
  level endon("active_combat_begun");

  while(!isDefined(level.player.var_bec156d5a2918db9) || level.player.var_bec156d5a2918db9 == "hilltop") {
    waitframe();
  }

  level thread function_96247e7595b40c0a(&function_1ff42e159b7b59c4, undefined, "active_combat_begun");
}

function function_1ff42e159b7b59c4() {
  ai_array = getaiarray("axis");
  ai_array = array_removedead_or_dying(ai_array);
  ai_array = array_removeundefined(ai_array);
  var_69293efbb0100182 = [];

  foreach(ai in ai_array) {
    if(isDefined(ai.var_55cc71192b8f1931) && array_contains(ai.var_55cc71192b8f1931, "patrol_flashlight")) {
      var_69293efbb0100182 = array_add(var_69293efbb0100182, ai);
    }
  }

  return var_69293efbb0100182;
}

function function_6f3f36ca225a1f02() {
  flag_wait("active_combat_begun");
  level thread function_96247e7595b40c0a(&function_d2c44371a392b93f, level.var_6609794f0e75c6be);
}

function function_24d8a34dc26894d2() {
  wait 1;

  if(function_d137525f29290a18()) {
    function_76e85d0aa8db406d("vfx_flashlight_npc_perf_short");
  } else {
    function_76e85d0aa8db406d();
  }

  if(isDefined(self.var_55cc71192b8f1931) && array_contains(self.var_55cc71192b8f1931, "vista_flashlight")) {
    scripts\cp\nvg_ai::enable_flashlight(1);
  }

  thread function_5e0add34a14e5d96();
}

function function_5e0add34a14e5d96() {
  self endon("death");

  while((!isDefined(level.player.var_bec156d5a2918db9) || level.player.var_bec156d5a2918db9 == "hilltop") && !function_489a0835e10a9b55()) {
    waitframe();
  }

  while(true) {
    while(!function_d137525f29290a18()) {
      waitframe();
    }

    function_76e85d0aa8db406d("vfx_flashlight_npc_perf_short");

    if(istrue(self.flashlight)) {
      scripts\cp\nvg_ai::enable_flashlight(0);
    }

    while(function_d137525f29290a18()) {
      if(function_34ae20339607955a()) {
        if(!isDefined(self.noflashlight) && function_ff54a17f83f0f0b()) {
          function_e14e675415036a40();
          wait randomfloatrange(1, 3);
        } else {
          function_11330e1d1c604ea5();
        }
      }

      waitframe();
    }

    function_76e85d0aa8db406d();
    function_11330e1d1c604ea5();
  }
}

function function_d137525f29290a18() {
  return distance(self.origin, level.var_63b40830aaf1479a.origin) < 1200;
}

function function_34ae20339607955a() {
  foreach(vol in level.var_2b58e2b063a747ad) {
    if(level.player istouching(vol)) {
      return true;
    }
  }

  return false;
}

function function_ff54a17f83f0f0b() {
  if(!isDefined(self.flashlightfxtag) && !isDefined(self.var_b5ce31099294cf74)) {
    return 0;
  }

  if(isDefined(self.var_b5ce31099294cf74)) {
    var_e47f8a7629b4cd8 = "tag_flash";
  } else {
    var_e47f8a7629b4cd8 = self.flashlightfxtag;
  }

  var_ae8f6c4aa4f86eea = self gettagorigin(var_e47f8a7629b4cd8);
  var_a3b4bd6fc3cb4a28 = self gettagangles(var_e47f8a7629b4cd8);
  ang = vectordot(anglesToForward(var_a3b4bd6fc3cb4a28), level.var_63b40830aaf1479a.origin - var_ae8f6c4aa4f86eea);

  if(ang >= 0) {
    return 1;
  }

  return 0;
}

function function_e14e675415036a40() {
  self.noflashlight = 1;
  scripts\cp\nvg_ai::enable_flashlight(0);
}

function function_11330e1d1c604ea5() {
  if(isDefined(self.noflashlight) && self.noflashlight) {
    self.noflashlight = undefined;
  }
}

function function_46645d44530594cf() {
  level endon("active_combat_begun");
  self endon("death");

  while(true) {
    if(self[[self.fnisinstealthcombat]]()) {
      level notify("ai_in_stealth_combat");
    }

    waitframe();
  }
}

function function_3aee6d8ad45b2a04(maxdist) {
  self endon("death");
  self.scripted_mode = 1;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.fixednode = 1;
  flag_wait("hostage_ai_goto_combat");
  self.scripted_mode = 0;
  self.ignoreme = 0;
  self.ignoreall = 0;
  self.fixednode = 0;
}

function function_a73f32ec62ccefb1() {
  level endon("game_ended");
  level endon("flag_dungeon_outro_start");
  level endon("black_box_picked_up");
  level waittill("ai_in_stealth_combat");
  wait 3;

  while(true) {
    var_742f29209b97b38f = 0;
    all_ai = getaiarray("axis");

    foreach(ai in all_ai) {
      if(isalive(ai) && ai.alertlevel == "combat") {
        var_742f29209b97b38f++;
      }
    }

    if(var_742f29209b97b38f >= 1) {
      flag_set("active_combat_begun");
      waitframe();
      flag_clear("active_combat_cooldown");
    } else {
      flag_set("active_combat_cooldown");
      waitframe();
      flag_clear("active_combat_begun");
    }

    wait 1;
  }
}

function function_bba4b941623c75f2() {
  level endon("game_ended");
  level.var_cf4e5973327b7ec2 = [];
  level.var_f3afd4fea623aee1 = [getEnt("goal_vol_manor", "targetname"), getEnt("goal_vol_building_1", "targetname"), getEnt("goal_vol_building_2", "targetname")];
  level.var_ec6c5a27751de31a = level.var_f3afd4fea623aee1[0];

  while(true) {
    while(level.var_cf4e5973327b7ec2.size == 0) {
      waitframe();
    }

    while(true) {
      if(!isDefined(level.var_ec6c5a27751de31a)) {
        return;
      }

      level.var_cf4e5973327b7ec2 = array_removeundefined(level.var_cf4e5973327b7ec2);
      level.var_cf4e5973327b7ec2 = array_removedead_or_dying(level.var_cf4e5973327b7ec2);
      var_6763ab527c2909e = 1;

      foreach(ai in level.var_cf4e5973327b7ec2) {
        if(!ai istouching(level.var_ec6c5a27751de31a)) {
          var_6763ab527c2909e = 0;
          break;
        }
      }

      if(var_6763ab527c2909e) {
        break;
      }

      waitframe();
    }

    if(level.var_cf4e5973327b7ec2.size == 0) {
      return;
    }

    wait 60;
    var_f5603f5eeec9cc57 = random(array_remove(level.var_f3afd4fea623aee1, level.var_ec6c5a27751de31a));
    level.var_ec6c5a27751de31a = var_f5603f5eeec9cc57;
  }
}

function function_f670b8ed0116f85f() {
  level endon("<dev string:x36>");
  self endon("<dev string:x41>");
  oow_vol = function_1c4d592029f2b0d3("<dev string:x47>");

  while(!self istouching(oow_vol)) {
    waitframe();
  }

  var_705c44e0014db4e1 = self.origin;
  assertmsg("<dev string:x58>");

  while(true) {
    iprintlnbold("<dev string:xda>" + var_705c44e0014db4e1);
    wait 3;
  }
}

function function_77a2e0c93467a72f() {
  if(function_4bcd86b926d48155()) {
    return;
  }

  if(!isDefined(game["phones_found"])) {
    game["phones_found"] = [];
  }

  level.var_c46b5c83b58aefb4 = getStructArray("ranch_phones_interact", "targetname");

  foreach(index, crate in level.var_c46b5c83b58aefb4) {
    if(getdvarint(@ "hash_e7b166857767d484")) {
      thread draw_line_for_time(crate.origin, crate.origin + (0, 0, 128), 1, 1, 1, 120000, "game_ended");
    }

    if(!isDefined(game["phones_found"][index])) {
      game["phones_found"][index] = 0;
    }

    crate.var_a70dce4a0f035ec3 = function_1c4d592029f2b0d3(crate.target);
    crate function_916233af1855619c();
  }
}

function function_e48aa70b47dec5f8() {
  var_bb25b33fdf76825c = getStruct("obj_search", "targetname");
  blackbox = spawn("script_model", var_bb25b33fdf76825c.origin);
  blackbox.angles = var_bb25b33fdf76825c.angles;
  blackbox setModel("jup_hardware_black_box_flight_recorder_hackable");
  level.blackbox = blackbox;
}

function function_5eaea7a4d366e1df() {
  if(function_4bcd86b926d48155()) {
    return;
  }

  level endon("game_ended");
  level endon("obj_escape_start");
  level endon("obj_phones_completed");
  level.var_660132cc97da2719 = 0;
  setdvarifuninitialized(@ "hash_6aa4278a8cd0b45e", 1);
  setdvarifuninitialized(@ "hash_8af6cfba8f2cc56", 0);

  foreach(crate in level.var_c46b5c83b58aefb4) {
    crate childthread function_a0121a5d1c92c8d8(index);
  }
}

function function_6f1620db91509bd7(origin, endonname, var_761c058f44a31b3a) {
  level endon("game_ended");
  level endon("obj_escape_start");
  level endon("obj_phones_completed");

  if(!isDefined(var_761c058f44a31b3a)) {
    var_761c058f44a31b3a = 350;
  }

  while(true) {
    var_c2f0471ecfe728f2 = getaiarrayinradius(origin, var_761c058f44a31b3a);

    if(!isDefined(self.var_2bbd56a52bc8f02c)) {
      self.var_2bbd56a52bc8f02c = var_c2f0471ecfe728f2;
    }

    foreach(enemy in var_c2f0471ecfe728f2) {
      if(!istrue(enemy.var_a0cb39f1fce66086)) {
        enemy.var_a0cb39f1fce66086 = 1;
      }
    }

    foreach(enemy in self.var_2bbd56a52bc8f02c) {
      var_17e0ebad64a016a0 = 1;

      foreach(newenemy in var_c2f0471ecfe728f2) {
        if(enemy == newenemy) {
          var_17e0ebad64a016a0 = 0;
          break;
        }
      }

      if(istrue(var_17e0ebad64a016a0)) {
        enemy.var_a0cb39f1fce66086 = 0;
      }
    }

    self.var_2bbd56a52bc8f02c = var_c2f0471ecfe728f2;
    wait 2;
  }
}

function function_18f7c48b37514e04(endnotify) {
  level endon("game_ended");
  level endon("obj_escape_start");
  level endon("obj_phones_completed");

  if(!isDefined(level.objpoints)) {
    level.objpoints = scripts\engine\utility::getStructArray("obj_phone_plane_interact", "targetname");
  }

  closeststruct = getclosest(self.origin, level.objpoints);
  objindex = 0;

  for(i = 0; i < level.objpoints.size; i++) {
    if(level.objpoints[i] == closeststruct) {
      objindex = i;
      break;
    }
  }

  objpoint = level.objpoints[objindex];
  objpoint thread function_dc3c295fcb6d7c77(objindex, objpoint.script_noteworthy + "_complete", undefined, 200, 350, undefined, undefined, undefined, undefined, undefined, undefined, 0, 0);
  self waittill(endnotify);
  objpoint notify(objpoint.script_noteworthy + "_complete");
  flag_set(objpoint.script_noteworthy + "_complete");
}

function function_ddc7acae2ba5e1dc() {
  wait 4;
  objpoint = scripts\engine\utility::getStruct("obj_blackbox_interact", "targetname");
  objpoint thread function_dc3c295fcb6d7c77(9, objpoint.script_noteworthy + "_complete", undefined, 1, 1, undefined, undefined, undefined, undefined, undefined, undefined, 0);
  flag_wait("player_in_blackbox_room");
  objpoint notify(objpoint.script_noteworthy + "_complete");
  flag_set(objpoint.script_noteworthy + "_complete");
}

function function_a0121a5d1c92c8d8(var_8d32bbd27c5b2161) {
  level endon("obj_phones_completed");
  self endon("delete");
  compassicon = undefined;
  model = spawn("script_model", self.origin);
  model.angles = self.angles;
  model setModel("electronics_smartphone_01_on_hackable");
  model.equipmentref = "equip_phone";
  model setscriptablepartstate("hack_usable", "on");
  model.var_c9f381a81d2b42ed = 5;
  model.var_bf11ca1f75257311 = 3.5;
  model.var_f980def4500c0769 = 2;
  model.var_af6b61c84f019e58 = &function_ed9354f51804b6c1;
  model.var_28801f64e1d308be = &function_b76f40a3f74c7382;
  model.var_ad414715a4dbed05 = makeweapon("ks_remote_hack_cinematic_mp");
  model.var_2c080d51c26d0785 = &function_30f81397557291da;
  model.var_3b863b2cb4c0df2e = &function_e040d639d0b95e42;
  model.var_1f6c1f17ced6df4b = 253;
  circleradius = self.var_a70dce4a0f035ec3.struct.radius;
  var_8c892b1f78bfeeb7 = randomfloatrange(0.2, 0.45);
  var_44dc7150398a594c = circleradius * var_8c892b1f78bfeeb7 * ter_op(cointoss(), -1, 1);
  var_44dc7250398a5b7f = circleradius * var_8c892b1f78bfeeb7 * ter_op(cointoss(), -1, 1);
  var_a1f8532fcba75fe5 = self.origin[0] + var_44dc7150398a594c;
  var_a1f8522fcba75db2 = self.origin[1] + var_44dc7250398a5b7f;
  circleorigin = (var_a1f8532fcba75fe5, var_a1f8522fcba75db2, 0);
  model thread function_6f1620db91509bd7(model.origin);
  bitfield = getdvarint(@ "hash_8af6cfba8f2cc56");
  var_509dba5928b43b0f = bitfield & 1 << var_8d32bbd27c5b2161;

  if(!getdvarint(@ "hash_6aa4278a8cd0b45e") || var_509dba5928b43b0f) {
    self.var_a70dce4a0f035ec3.origin = circleorigin;
  }

  thread function_57060108b538f86c(model);

  while(true) {
    self.var_a70dce4a0f035ec3 waittill("trigger", who);

    if(who == level.player) {
      break;
    }
  }

  bitfield = getdvarint(@ "hash_8af6cfba8f2cc56");
  var_3701bd3b856e9636 = 1 << var_8d32bbd27c5b2161;
  setDvar(@ "hash_8af6cfba8f2cc56", bitfield | var_3701bd3b856e9636);

  if(getdvarint(@ "hash_6aa4278a8cd0b45e") && !var_509dba5928b43b0f) {
    self.var_a70dce4a0f035ec3.origin = circleorigin;
  }

  level notify("phone_crate_nearby", self);
  model thread function_18f7c48b37514e04("hacked");
  model waittill("hacked");
  game["phones_found"][var_8d32bbd27c5b2161] = 1;
  level.var_660132cc97da2719++;
  self.var_1ab92c9426b975ca = 1;

  foreach(crate in level.var_c46b5c83b58aefb4) {
    if(istrue(crate.var_1ab92c9426b975ca)) {
      continue;
    }

    break;
  }

  model setscriptablepartstate("hack_usable", "off");
  level.var_c46b5c83b58aefb4 = array_remove(level.var_c46b5c83b58aefb4, self);

  if(level.var_c46b5c83b58aefb4.size <= 3) {
    flag_set("all_phones_found");

    foreach(phone in level.var_c46b5c83b58aefb4) {}
  }

  level notify("phone_crate_hacked");
  model setModel("electronics_smartphone_01");
}

function function_5a1c04c58cf0a2f1(position) {
  if(!isDefined(level.var_7dde1bdd72c01010)) {
    level.var_7dde1bdd72c01010 = [];
  }

  var_7bcbfac86574f627 = scripts\cp\cp_objectives::requestworldid(level.var_7dde1bdd72c01010.size);
  objective_state(var_7bcbfac86574f627, "active");
  objective_icon(var_7bcbfac86574f627, "jup_question_mark");
  objective_setbackground(var_7bcbfac86574f627, 1);
  objective_position(var_7bcbfac86574f627, position);
  objective_setshowoncompass(var_7bcbfac86574f627, 1);
  function_9766d0b79eada249(var_7bcbfac86574f627, 1);
  level.var_7dde1bdd72c01010[level.var_7dde1bdd72c01010.size] = var_7bcbfac86574f627;
  return level.var_7dde1bdd72c01010[level.var_7dde1bdd72c01010.size - 1];
}

function function_57060108b538f86c(model) {
  model endon("hacked");
  level waittill("obj_phones_completed");
  model hudoutlinedisable();
  model setscriptablepartstate("hack_usable", "off");
  model setModel("electronics_smartphone_01");
  level.var_7dde1bdd72c01010 = undefined;
}

function function_cbc288fb616c8c34(areaname) {
  foreach(phone in level.var_c46b5c83b58aefb4) {
    if(isDefined(phone.var_55cc71192b8f1931) && array_contains(phone.var_55cc71192b8f1931, areaname)) {
      return true;
    }
  }

  return false;
}

function function_ac2e42c678489275() {
  flag_wait("start_is_set");
  start = level.start_point;

  if(!isDefined(start) || start == "") {
    return;
  }

  if(start == "intro") {
    return;
  }

  if(start == "search") {
    return;
  }

  flag_set("player_in_blackbox_room");
  flag_set("obj_search_completed");
  flag_set("obj_phones_completed");
  flag_set("obj_phones_completed_vo");

  if(start == "escape") {
    return;
  }

  flag_set("obj_escape_completed");

  if(start == "exfil") {
    return;
  }

  if(start == "stealth_tuning") {
    return;
  }
}

function start_intro() {
  function_9250dfcc43a9ccb9();
}

function start_search() {
  thread namespace_5bdaf1e2d5da506e::function_4f634c9fb994a397();
  function_9250dfcc43a9ccb9();
}

function function_95ec6454223ce5de() {
  game["checkpoints_completed"]["flight_recorder_found"] = 1;
  flag_set("obj_phones_completed_vo");
  flag_set("obj_search_completed_vo");
  flag_set("player_in_blackbox_room");
  flag_set("obj_phones_completed");
  flag_set("obj_phone_complete_vo_begin");
  namespace_4c21e3c2da3d8585::function_e48aa70b47dec5f8();
  flag_set("obj_search_completed");
  thread namespace_5bdaf1e2d5da506e::function_4f634c9fb994a397();
  function_9250dfcc43a9ccb9();
  thread function_95a1718574f2b4b7();
}

function function_7c921888c7d44907() {
  thread namespace_5bdaf1e2d5da506e::function_1d37f9a755d93118();
  function_9250dfcc43a9ccb9();
  flag_wait("start_mission_flow");
}

function function_b0f6d6910f3b8af8() {
  thread namespace_5bdaf1e2d5da506e::function_a03a8a9f23f22041();
  flag_set("enable_exfil_lighting");
  function_9250dfcc43a9ccb9();
}

function function_fa91d979da460f3b() {
  thread namespace_5bdaf1e2d5da506e::function_4f634c9fb994a397();
  function_9250dfcc43a9ccb9();
  scripts\stealth\utility::function_6516755416a6584b(&function_1a011c0ac5964a96);
}

function intro_flow() {
  flag_wait("start_mission_flow");
  setdvarifuninitialized(@ "hash_218d241fdacc359b", 0);
  thread play_intro();
}

function function_bd4866180ba60842() {
  flag_wait("start_mission_flow");
  level.player thread function_4d42ee8130c22006();
  level.player thread function_587cdfe8e3f8e79b();
  level thread function_36318a2e1c3e9bdc();
  level thread scripts\cp\utility\player::function_1c0f3b6933eb1c87();
  function_77a2e0c93467a72f();
  function_e48aa70b47dec5f8();
  thread function_319ffcfe3a782858();
  thread function_5eaea7a4d366e1df();
  thread function_bc14acc20f41302f();
  flag_wait("blackbox_interacted");
  thread namespace_4c21e3c2da3d8585::function_cef303186b6867a2();
  flag_set("obj_search_completed");
  level notify("obj_search_completed");
}

function function_3b80f9364e41d471() {
  flag_wait("start_mission_flow");
  checkpoint = scripts\cp\cp_checkpoint::checkpoint_get();
  checkpoint = ter_op(checkpoint != "", checkpoint, getDvar(@ "start"));

  if(checkpoint == "stealth_tuning" || checkpoint == "rescue_alex") {
    return;
  }

  level.var_63b40830aaf1479a = getStruct("headlight_ref_point", "targetname");
  var_6609794f0e75c6be = array_merge(getEntArray("shadow_vol", "targetname"), getEntArray("tall_grass_vol", "targetname"));
  var_2b58e2b063a747ad = [];

  foreach(vol in var_6609794f0e75c6be) {
    vol function_916233af1855619c();

    if(isDefined(vol.var_55cc71192b8f1931)) {
      if(array_contains(vol.var_55cc71192b8f1931, "flashlight_ignore")) {
        var_6609794f0e75c6be = array_remove(var_6609794f0e75c6be, vol);
        continue;
      }

      if(array_contains(vol.var_55cc71192b8f1931, "control_flashlight_angles")) {
        var_2b58e2b063a747ad = array_add(var_2b58e2b063a747ad, vol);
      }
    }
  }

  level.var_6609794f0e75c6be = var_6609794f0e75c6be;
  level.var_2b58e2b063a747ad = var_2b58e2b063a747ad;
  waitframe();
  level thread function_4380ce742d375bba();
}

function function_7e376867985b0dc9(doors) {
  if(function_4bcd86b926d48155()) {
    flag_set("blackbox_interacted");

    foreach(door in doors) {
      door function_80902296b05be00a();
      door.blocked = undefined;
      door.var_a16669fdd0578e00 = 1;
    }

    return;
  }

  level endon("game_ended");
  var_bb25b33fdf76825c = function_a05e0ed00f762915();
  blackbox = level.blackbox;
  blackbox.equipmentref = "equip_black_box";
  blackbox setscriptablepartstate("hack_usable", "on");
  compassicon = undefined;
  blackbox.var_a70dce4a0f035ec3 = function_1c4d592029f2b0d3(var_bb25b33fdf76825c.target);
  circleradius = blackbox.var_a70dce4a0f035ec3.struct.radius;
  var_8c892b1f78bfeeb7 = randomfloatrange(0.2, 0.45);
  var_44dc7150398a594c = circleradius * var_8c892b1f78bfeeb7 * ter_op(cointoss(), -1, 1);
  var_44dc7250398a5b7f = circleradius * var_8c892b1f78bfeeb7 * ter_op(cointoss(), -1, 1);
  var_784f9abe32ef47b3 = getStruct("recorder_circle", "targetname");
  var_a1f8532fcba75fe5 = var_784f9abe32ef47b3.origin[0] + var_44dc7150398a594c;
  var_a1f8522fcba75db2 = var_784f9abe32ef47b3.origin[1] + var_44dc7250398a5b7f;
  circleorigin = (var_a1f8532fcba75fe5, var_a1f8522fcba75db2, 0);
  blackbox thread function_ddc7acae2ba5e1dc();
  blackbox.var_a70dce4a0f035ec3.origin = circleorigin;

  while(true) {
    blackbox.var_a70dce4a0f035ec3 waittill("trigger", who);

    if(who == level.player) {
      break;
    }
  }

  level notify("recorder_nearby", self);
  blackbox waittill("hacked");
  thread function_95a1718574f2b4b7();
  scripts\cp\cp_checkpoint::function_f64efae7665a7baa(2, "flight_recorder_found");
  blackbox hudoutlinedisable();
  blackbox setscriptablepartstate("hack_usable", "off");
  flag_set("blackbox_interacted");
  thread namespace_9faa61bf1903f9b8::function_6bb2d4f65ab5b358();
}

function function_a05e0ed00f762915() {
  blackbox = level.blackbox;
  var_bb25b33fdf76825c = getStruct("obj_search", "targetname");

  if(isDefined(blackbox)) {
    blackbox hudoutlinedisable();
    blackbox setscriptablepartstate("hack_usable", "off");
  }

  flag_wait("all_phones_found");
  return var_bb25b33fdf76825c;
}

function function_4bcd86b926d48155() {
  return scripts\cp\cp_checkpoint::function_cd10e09e02e4eb07("flight_recorder_found");
}

function function_987f835f9b6ea4a4() {
  var_5f9446889da88fc7 = getEnt("blackbox_room", "targetname");

  if(!isDefined(var_5f9446889da88fc7)) {
    return;
  }

  while(!level.player istouching(var_5f9446889da88fc7)) {
    waitframe();
  }

  flag_set("player_in_blackbox_room");
  level notify("player_in_blackbox_room");
}

function function_e0e62ffbaed1b250() {
  while(!isDefined(level.player)) {
    waitframe();
  }

  level.player nightvisionviewon();
}

function function_157750052141e0e2() {
  flag_wait("obj_search_completed");
  flag_set("start_escape_flow");
  level.var_69424e5ded8586a3 = [];
  level.var_9c949dc48c5bdffa = [];
  level.var_d0d5526a0a139791 = [];
  level.var_63b40830aaf1479a = getStruct("headlight_ref_point", "targetname");
  level.var_63b40830aaf1479a = getStruct("headlight_ref_point", "targetname");
  var_6609794f0e75c6be = array_merge(getEntArray("shadow_vol", "targetname"), getEntArray("tall_grass_vol", "targetname"));
  var_2b58e2b063a747ad = [];

  foreach(vol in var_6609794f0e75c6be) {
    vol function_916233af1855619c();

    if(isDefined(vol.var_55cc71192b8f1931)) {
      if(array_contains(vol.var_55cc71192b8f1931, "flashlight_ignore")) {
        var_6609794f0e75c6be = array_remove(var_6609794f0e75c6be, vol);
        continue;
      }

      if(array_contains(vol.var_55cc71192b8f1931, "control_flashlight_angles")) {
        var_2b58e2b063a747ad = array_add(var_2b58e2b063a747ad, vol);
      }
    }
  }

  level.var_6609794f0e75c6be = var_6609794f0e75c6be;
  level.var_2b58e2b063a747ad = var_2b58e2b063a747ad;
  waitframe();
  level.var_e746e3bf44ecc904 = function_6149b301ce19988b("stealth_ai_intro", &function_b863dcd61d90ee40);
  level.var_57157ccb0f54801 = function_6149b301ce19988b("stealth_ai", &function_b863dcd61d90ee40);
}

function function_95a1718574f2b4b7() {
  veh_spawner = getStruct("hostage_veh_spawn", "targetname");
  leveldataforvehicle = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle("veh_jup_jltv");
  leveldataforvehicle.var_14cde247ac3313a4 = undefined;
  level.var_69c070ef9dc50848 = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh_jup_jltv", veh_spawner);
  level.var_69c070ef9dc50848.animname = "jltv";
  level.var_69c070ef9dc50848 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(0);
  level.var_69c070ef9dc50848.var_547a08a57461960d = 1;
  level.var_4a4e365abca4649c thread anim_first_frame_solo(level.var_69c070ef9dc50848, "outro_scene");
  level.var_69c070ef9dc50848 thread function_33e506c75b550da2();
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable(level.var_69c070ef9dc50848);
}

function function_dcca511867827ee(objectivestruct) {
  level.player endon("death");
  level.player endon("disconnect");
  level endon("game_ended");
  namespace_96731f4d002634f6::function_666769c607f16d10();
  function_ecc682b5a8f2f5c3();
  veh_spawner = getStruct("hostage_veh_spawn", "targetname");
  var_e62df0718b7dcbca = veh_spawner.origin + (0, 0, 200);
  objindex = namespace_1170726b2799ea65::function_f60f3ac2fb2776f7(objectivestruct, "icon_waypoint_objective_general", "icon_small", var_e62df0718b7dcbca, "current", &"CP_JUP_RANCH/OBJ_EXFIL_LABEL", &"CP_JUP_RANCH/OBJ_EXFIL_LABEL");
  level notify("black_box_picked_up");
  flag_set("end_ally_overwatch");
  namespace_b96fa4d8ce10f926::function_ebd9a9c9789d200f();
  thread function_906082ab22ccb3cb();

  if(isDefined(level.alex)) {
    if(isDefined(level.alex.turrets)) {
      foreach(var_60ceb64cf953474c in level.alex.turrets) {
        linkedchildren = var_60ceb64cf953474c getlinkedchildren();

        foreach(child in linkedchildren) {
          child delete();
        }

        var_60ceb64cf953474c delete();
      }
    }
  }

  namespace_1170726b2799ea65::function_cece888a7dfbeb0b();
  level.var_86c9e0bb5de52aa1 = getEnt("hostage_sequence_start_trigger", "targetname");
  level.var_86c9e0bb5de52aa1 thread function_8d2a95d942a2826f();

  if(isDefined(level.player.var_7578715840982db8)) {
    level.player.var_7578715840982db8 thread function_2576ba31a26a3c96(level.var_86c9e0bb5de52aa1);
  }

  if(!isDefined(level.var_57157ccb0f54801)) {
    level.var_57157ccb0f54801 = function_6149b301ce19988b("hostage_sequence_ai", &function_3801107217cbf809);
  } else {
    level.var_132242b98a11bc6f = function_6149b301ce19988b("hostage_sequence_ai", &function_3801107217cbf809);
  }

  setDvar(@ "hash_42ec046969fe5985", 1);
  level.var_633ee74e2649aac7 = &function_633ee74e2649aac7;
  level.var_42afc805d63fbe6e = 0;
  var_4ba71dd582ae5a9f = getStruct("hostage_sequence_alex", "targetname");
  namespace_4c21e3c2da3d8585::spawn_alex(var_4ba71dd582ae5a9f, "hostage_sequence_alex");
  level.alex.ignoreall = 1;
  level.alex.ignoreme = 1;
  level.alex.dontevershoot = 1;
  level.alex.goalradius = 8;
  level.alex.invulnerable = 0;
  thread namespace_1170726b2799ea65::function_4576aecf9d0c4082(level.alex);
  level.alex thread watchfordeath();

  if(!function_4bcd86b926d48155() || isDefined(level.start_point) && level.start_point != "rescue_alex") {
    flag_wait("alex_captured_sequence_vo");

    while(flag("alex_captured_sequence_vo") && !flag("hostage_ai_goto_combat")) {
      waitframe();
    }
  } else {
    thread namespace_4c21e3c2da3d8585::function_cef303186b6867a2();
  }

  objective_onentity(objindex, level.alex);
  objective_setzoffset(objindex, 70);
  objective_setdescription(objindex, &"CP_JUP_RANCH/OBJ_EXFIL_LABEL");
  objective_setlabel(objindex, &"CP_JUP_RANCH/RESCUE_ALEX");
  function_8615a6b7cd263577();
  level.var_3560bc2e9e99b27f = objindex;

  if(!isDefined(level.soldier_allies)) {
    level.soldier_allies = [];
  }

  level.soldier_allies[level.soldier_allies.size] = level.alex;
  level.alex.ally_index = level.soldier_allies.size - 1;
  level.alex.entity_number = level.alex getentitynumber();
  level.alex allowedstances("crouch");
  level.alex endon("death");
  level.alex.animnode = spawnStruct();
  level.alex.animnode.origin = level.alex.origin;
  level.alex.animnode.angles = level.alex.angles;
  level.alex.animnode anim_single_solo(level.alex, "surrender");

  if(!flag("alex_guards_were_attacked")) {
    level.alex.animnode thread anim_loop([level.alex], "kneel_2", "stop_looped_idle");
  }

  flag_wait("player_spawned_with_loadout");
}

function function_633ee74e2649aac7(var_8b065b1b8825808b) {
  setDvar(@ "hash_42ec046969fe5985", 0);
}

function function_8615a6b7cd263577() {
  setmusicstate("mx_ranch_exfil_end");
}

function function_ee3e5652179e305d() {
  level endon("game_ended");
  level.player endon("death");
  level.player unlink();
  level.player_rig delete();

  if(!isDefined(level.player_rig)) {
    level.player_rig = spawn_anim_model("player_rig");
  }

  level.player_rig hide();
  level.var_4a4e365abca4649c anim_first_frame_solo(level.player_rig, "outro_scene");
  flag_wait("player_entered_exfil_vehicle");
  level.player thread function_306ed11b28612f09();
  stopmusicstate("mx_ranch_exfil_end");
  namespace_9766820f5baa93fb::function_cd054d9ba5a62557(0);
  function_bc0d98d43446799a();
  setDvar(@ "hash_93b8374b5b3983a8", 1);
  setDvar(@ "hash_42ec046969fe5985", 0);
  thread namespace_9faa61bf1903f9b8::function_e5fa9c74eac6670b();
  function_fa7c87f2585bd907(1);
}

function function_bc0d98d43446799a() {
  level endon("scene_skipped");
  namespace_1170726b2799ea65::function_5b13a92c82e81024(1, 0);
  level.player scripts\common\values::group_set("infil_player", 0);
  thread function_cc514f4104398f38(&function_62f0d40233e81a82);
  thread exploder(201);
  level.var_69c070ef9dc50848.animname = "jltv";
  level.alex.animname = "hostage_alex";
  level.alex.animnode notify("stop_looped_idle");
  level.var_4a4e365abca4649c notify("stop_looped_idle");
  level.alex namespace_1170726b2799ea65::function_e483413541e6f5cc();

  if(!isDefined(level.player_rig.allows)) {
    namespace_1170726b2799ea65::set_player_rig_allows();
  }

  level.player namespace_1170726b2799ea65::function_73341653f76b4e43();
  level.player.rig = level.player_rig;
  level.player.rig hide();
  level.player disableweapons();
  level.player allowfire(0);
  level.player playerhide();
  level.alex hide();
  level.var_69c070ef9dc50848 delete();
  function_ef3e8f10f229e1c4(level.player);
  thread namespace_5bdaf1e2d5da506e::function_12d204d855154905();
  var_9e072f9449de49eb = getStruct("outro_scene_node", "targetname");
  level.playback_scene = var_9e072f9449de49eb;
  level.playback_scene thread scene::pre_stream(level.player, undefined, -1, "jup_ranch_infil");
  thread namespace_9faa61bf1903f9b8::function_ced0986f270ad64();
  level.playback_scene thread scripts\common\scene::play(undefined, undefined, "jup_ranch_1000_igc_outro_scene");
  var_5018a9a0d40ed758 = getanimlength(level.scr_anim["player_rig"]["outro_scene"]) - 1;
  wait var_5018a9a0d40ed758;
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.player, 1, 1);
  thread namespace_9faa61bf1903f9b8::function_3e5ca72ec676d4bd();
}

function function_7ec46428e15d50b1() {
  level.player scripts\common\values::reset_all("player_rig");
  level.player stopanimScripted();
  level.player castshadows();
  level.player hidelegsandshadow();
  level.player unlink();
}

function function_62f0d40233e81a82(var_4ddfee90066836ac) {
  flag_set("flag_dungeon_exfil_complete");
}

function function_cc514f4104398f38(var_6b3bd87d12cded0f) {
  userskipped = level.player scripts\cp\globallogic::userskip_wait();

  if(!userskipped) {
    return;
  }

  thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.player, 1);
  flag_set("scene_skipped");
  level.player stopsounds();
  level.player stopxcam();

  if(isDefined(level.playback_scene)) {
    level.playback_scene scripts\common\scene::stop();
    level.playback_scene scene_cleanup();
  }

  function_7ec46428e15d50b1();
  level.player utility::hidehuddisable();
  level.player scripts\common\values::reset_all("scene_shot");
  level.player playershow();
  level.player allowfire(1);
  level.player function_3671ec427c125cb(0);
  level.player disablephysicaldepthoffieldscripting();
  level.var_5e84860df880bbce hide();
  hidecinematicletterboxing(0.3, 0);
  thread scripts\common\lighting::function_9160006a3f10b2cd();
  setsaveddvar(@ "hash_e08232af8b8b695c", 4);
  setsaveddvar(@ "hash_63eb1893f96ac98d", 6);
  setDvar(@ "hash_6e3f8cef6be16b33", 1);
  setDvar(@ "hash_1ea8544d78048529", 1);
  setDvar(@ "hash_5d66c2ef5a9612e0", 1);
  level.player clearcinematicmotionoverride();

  if(isDefined(var_6b3bd87d12cded0f)) {
    [[var_6b3bd87d12cded0f]](level.playback_scene);
  }
}

function function_4bf386ec03f83200() {
  start_struct = getStruct("exfil_camera", "targetname");
  level.player_rig = spawn_anim_model("player_rig");
  level.var_f128acd0aa1a786b = [];
  var_e3aac1a4be64b85a = spawnStruct();
  var_e3aac1a4be64b85a.origin = level.player.origin;
  var_e3aac1a4be64b85a.angles = level.player.angles;
  var_e3aac1a4be64b85a.targetname = "player_loc";
  var_e3aac1a4be64b85a.target = "exfil_camera";
  level.var_f128acd0aa1a786b = array_add(level.var_f128acd0aa1a786b, var_e3aac1a4be64b85a);
  var_f999f9fa729739af = getStruct("exfil_camera", "targetname");

  while(isDefined(var_f999f9fa729739af)) {
    level.var_f128acd0aa1a786b = array_add(level.var_f128acd0aa1a786b, var_f999f9fa729739af);

    if(isDefined(var_f999f9fa729739af.target)) {
      var_f999f9fa729739af = getStruct(var_f999f9fa729739af.target, "targetname");
      continue;
    }

    break;
  }
}

function function_e08be1c0db594560(cament, path, time) {
  level.player endon("death");
  level endon("game_ended");
  starttime = gettime();
  totaldist = 0;

  for(i = 0; i < 1; i++) {
    if(isDefined(path[i + 1])) {
      path[i].dist = distance(path[i].origin, path[i + 1].origin);
    } else {
      path[i].dist = totaldist;
    }

    totaldist += path[i].dist;
  }

  var_969e785c4e00a1d1 = 0;
  var_976824f5544dc282 = 0;

  for(i = 0; i < 1; i++) {
    segmentsize = path[i].dist / totaldist;
    var_969e785c4e00a1d1 = var_976824f5544dc282;
    var_976824f5544dc282 += segmentsize;
    timepercent = (gettime() - starttime) / 1000 / time;

    while(timepercent < var_976824f5544dc282) {
      timepercent = (gettime() - starttime) / 1000 / time;
      var_774e0f07388b5aab = (timepercent - var_969e785c4e00a1d1) / segmentsize;

      if(isDefined(path[i + 1])) {
        cament.angles = anglelerpquatfrac(path[i].angles, path[i + 1].angles, var_774e0f07388b5aab);
        cament.origin = vectorlerp(path[i].origin, path[i + 1].origin, var_774e0f07388b5aab);
      } else {
        cament.angles = anglelerpquatfrac(path[i].angles, path[i].angles, var_774e0f07388b5aab);
        cament.origin = vectorlerp(path[i].origin, path[i].origin, var_774e0f07388b5aab);
      }

      waitframe();
    }
  }

  flag_set("exfil_cam_pan_path_done");
}

function function_7ee920f8fb6da4a6() {
  level.player cameraset("cam_car_orbit");
}

function function_53dbc22d3a89de30() {
  level endon("game_ended");

  iprintln("<dev string:x101>");

  convo = ["dx_cp_rnch_rnes_alex_whatsnext", "dx_cp_rnch_rnes_fara_weneedtofindwheretho", "dx_cp_rnch_rnes_alex_illkeepmydistance", "dx_cp_rnch_rnes_fara_trynottogetcaughtthi", "dx_cp_rnch_rnes_alex_nopromises"];
  level.player say_sequence(convo, 1, 0, 0, 0, "team");
  flag_set("exfil_ending_vo_done");
}

function function_8d2a95d942a2826f() {
  self endon("death");

  while(true) {
    self waittill("trigger", entity);

    if(isagent(entity)) {
      continue;
    }

    if(isDefined(entity.owner)) {
      if(!isPlayer(entity.owner)) {
        continue;
      }
    } else if(!isPlayer(entity)) {
      continue;
    }

    break;
  }

  flag_set("hostage_ai_goto_combat");

  if(isDefined(level.player.var_7578715840982db8)) {
    level.player.var_7578715840982db8 function_fa001c17a9b3919d(self);
  }

  self delete();
}

function watchfordeath() {
  level endon("kill_alex_death_watcher");
  self notify("watchForDeath");
  self endon("watchForDeath");
  level.player endon("death");
  level endon("game_ended");
  self waittill("death");

  if(isDefined(self.lastattacker)) {
    level notify("alex_was_killed");
    setDvar(@ "hash_93b8374b5b3983a8", 1);
    setDvar(@ "hash_42ec046969fe5985", 0);

    if(self.lastattacker != level.player) {
      setomnvar("ui_death_hint", 992);
      thread function_fa7c87f2585bd907(0);
      return;
    }

    setomnvar("ui_death_hint", 991);
    thread function_fa7c87f2585bd907(0);
    level notify("ff_mission_failed");
  }
}

function function_33e506c75b550da2() {
  wait 1;
  self setscriptablepartstate("lights_front_exfil", "on");
  self setscriptablepartstate("lights_back_exfil", "on");
  self setscriptablepartstate("exfil_roof_light", "on");
}

function spawn_alex(teleport_node, spawner_name) {
  spawner_name = default_to(spawner_name, "alex");

  if(isDefined(level.alex)) {
    if(level.alex.birthtime == gettime()) {
      waitframe();
    }

    function_daa4962dfb2d15fc(level.alex, spawner_name);
  }

  level.alex = function_3863b0f90ec0baca(teleport_node, spawner_name);
  level.alex.name = "Alex";
  level.alex.agentname = &"CP_JUP_RANCH/ALEX";
  level.alex.var_e0143f4f183d8a12 = 1;
  var_de9797d3db12075 = level.alex.primaryweapon;
  level.alex takeweapon(level.alex.primaryweapon);
  var_de9797d3db12075 = var_de9797d3db12075 scripts\cp\weapon::function_dcb52bcbbcb80b00("silencer");
  level.alex giveweapon(var_de9797d3db12075);
  level.alex setspawnweapon(var_de9797d3db12075);
  level.alex.bulletsinclip = weaponclipsize(var_de9797d3db12075);
  level.alex.primaryweapon = var_de9797d3db12075;
  return level.alex;
}

function spawn_farah(teleport_node, spawner_name) {
  spawner_name = default_to(spawner_name, "alex");

  if(isDefined(level.farah)) {
    if(level.farah.birthtime == gettime()) {
      waitframe();
    }

    function_daa4962dfb2d15fc(level.farah, spawner_name);
  }

  level.farah = function_3863b0f90ec0baca(teleport_node, spawner_name);
  level.farah.name = "Farah";
  level.farah.var_e0143f4f183d8a12 = 0;
  return level.farah;
}

function function_3863b0f90ec0baca(teleport_node, spawner_name) {
  spawner = function_7a18da6e48b71c35(spawner_name);
  ally_ai = spawner scripts\cp\spawning::spawn_ai();
  ally_ai.goalradius = 8;
  ally_ai.animname = default_to(spawner.script_animname, "guy");

  if(isDefined(teleport_node)) {
    ally_ai forceteleport(teleport_node.origin, teleport_node.angles);
    ally_ai setgoalpos(teleport_node.origin);
  }

  ally_ai.invulnerable = 1;
  return ally_ai;
}

function function_daa4962dfb2d15fc(ally, spawner_name) {
  if(!isDefined(ally)) {
    ally = self;
    assertex(isDefined(ally) && isai(ally), "Attempting to delete undefined or something that isn't an AI in delete_ally()");
  }

  ally.invulnerable = 0;
  ally scripts\cp_mp\agents\agent_utils::despawnagent();
  ally_spawner = function_7a18da6e48b71c35(spawner_name);
  ally_spawner.count = 1;
}

function setup_soldier_stealth(struct) {
  scripts\cp\coop_stealth::run_common_functions(self);

  if(!isDefined(level.var_ac08a05fe794c883)) {
    level.var_ac08a05fe794c883 = [];
  }

  level.var_ac08a05fe794c883 = array_add(level.var_ac08a05fe794c883, self);
}

function function_dbc69dd27be53201(group_name, func) {
  if(getdvarint(@ "hash_dcf5fcede3345fb8", 0) != 0) {
    self.ignoreall = 1;
  }

  scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 160000);
  self.var_d4c11c85ee9c6a42 = 1500;
  self.var_a4709d00b598b7bf = 1;
  self.var_ba67494935b9726b = 1;
}

function function_3801107217cbf809(group_name, func) {
  if(!isDefined(level.var_87a24dcbeb99b940)) {
    level.var_87a24dcbeb99b940 = [];
  }

  self.var_c3b6984b9532af5b = 1;
  self.var_6f04e01158b20542 = 1;
  thread function_3aee6d8ad45b2a04();
  function_dbc69dd27be53201(group_name, func);
  self function_d493e7fe15e5eaf4("jup_sandbox_hostage_ranch");
  function_916233af1855619c();
  thread function_46645d44530594cf();
  thread function_ddf2ee39214008f9();
  thread function_ff73160486845c04();

  thread function_f670b8ed0116f85f();

  thread function_89a3d3da215fc2a8();
  function_85900015f5d62385();
  self.dontmeleeme = 1;
  level.var_87a24dcbeb99b940 = array_add(level.var_87a24dcbeb99b940, self);
  scripts\stealth\utility::function_6516755416a6584b(&function_564bd7f619787bcc);
}

function function_89a3d3da215fc2a8() {
  level endon("game_ended");
  self endon("death");
  oow_vol = function_1c4d592029f2b0d3("debug_outofworld");

  while(!self istouching(oow_vol)) {
    waitframe();
  }

  self.armorhealth = 0;
  self.armor_health = 0;
  self.diequietly = 1;
  scripts\cp\spawning::script_kill_ai();
}

function function_ff73160486845c04() {
  level endon("game_ended");
  level endon("flag_dungeon_outro_start");
  level endon("alex_was_killed");
  self waittill("death");

  if(!flag("hostage_ai_goto_combat")) {
    flag_set("hostage_ai_goto_combat");
  }

  level.var_87a24dcbeb99b940 = array_removedead_or_dying(level.var_87a24dcbeb99b940);

  if(level.var_87a24dcbeb99b940.size == 1) {
    foreach(ai in level.var_87a24dcbeb99b940) {
      ai.dontmeleeme = 0;
    }

    thread function_6f57cb374140eff1();
  }

  if(level.var_87a24dcbeb99b940.size == 0) {
    thread function_6f57cb374140eff1();
    thread ally_kickOffExfilBehavior();
  }
}

function function_f91bc3964c4cfd2b() {
  level endon("game_ended");
  level.alex endon("death");
  level.alex.var_a4531c2f0e9c1384 = 0;

  while(true) {
    level.alex.var_a4531c2f0e9c1384 = 1;
    waitframe();
  }
}

function ai_killFaroffAndObsoleteAI(var_c48a8da587d19f4b, aiarray, excluders) {
  level endon("game_ended");
  level notify("ai_killFaroffAndObsoleteAI");
  level endon("ai_killFaroffAndObsoleteAI");

  while(true) {
    ai_alive = array_removedead_or_dying(aiarray);
    ai_alive = array_removeundefined(aiarray);
    level.var_87a24dcbeb99b940 = array_removedead_or_dying(level.var_87a24dcbeb99b940);

    if(isDefined(excluders)) {
      excluders = array_removedead_or_dying(excluders);
    }

    maxdist = 4000;

    if(isDefined(var_c48a8da587d19f4b)) {
      maxdist = var_c48a8da587d19f4b;
    }

    maxdistsq = squared(maxdist);

    for(i = 0; i < ai_alive.size; i++) {
      if(isalive(ai_alive[i])) {
        if(array_contains(level.var_87a24dcbeb99b940, ai_alive[i])) {
          continue;
        }

        if(isDefined(excluders)) {
          if(array_contains(excluders, ai_alive[i])) {
            continue;
          }
        }

        if(istrue(ai_alive[i].var_5323a94889eff1de)) {
          continue;
        }

        ai_alive[i].dontkilloff = 0;
        var_d26c161386b2b083 = 0;

        foreach(player in level.players) {
          if(scripts\anim\utility_common::player_can_see_ai(player, ai_alive[i])) {
            var_d26c161386b2b083 = 1;
          }
        }

        if(!var_d26c161386b2b083) {
          ai_alive[i].diequietly = 1;
          ai_alive[i] scripts\cp\spawning::script_kill_ai();
        }
      }
    }

    wait 1;
  }

  waitframe();
}

function function_d24590f588a71ca2(var_8a2b88181115580f) {
  if(scripts\cp\spawning::is_juggernaut_aitype() || scripts\cp\spawning::is_specified_unittype("juggernaut")) {
    return;
  }

  closest_player = get_closest_living_player();

  if(!isDefined(closest_player)) {
    closest_player = getclosest(self.origin, level.players);
  }

  thread function_43a45e199254ce4f(closest_player, var_8a2b88181115580f);
}

function function_43a45e199254ce4f(player, var_8a2b88181115580f) {
  self endon("death");
  self getenemyinfo(player);
  self.lastenemysightpos = player.origin;

  if(!istrue(var_8a2b88181115580f)) {
    self.var_5323a94889eff1de = 1;
  }

  self.goalradius = 1024;
  self.aggressivemode = 1;
  thread function_6dae2816a58b8a6d(player);
}

function function_6dae2816a58b8a6d(player) {
  self endon("death");
  self endon("stop_player_seek");
  g_radius = 1200;
  newgoalradius = distance(self.origin, player.origin);

  for(;;) {
    wait 2;
    self getenemyinfo(player);
    self setgoalpos(player.origin);
    newgoalradius -= 175;

    if(newgoalradius < g_radius) {
      newgoalradius = g_radius;
      return;
    }
  }
}

function ally_kickOffExfilBehavior() {
  level endon("game_ended");
  level notify("ally_kickOffExfilBehavior");
  level endon("ally_kickOffExfilBehavior");
  flag_wait("alex_getup_done");
  level.alex scripts\common\ai::magic_bullet_shield(1);
  level.var_4f436273682324 = 0;
  ai_array = getaiarray("axis");
  var_adbcfcbe0cd05a83 = [];

  while(function_1bb1470f934a81eb()) {
    if(!istrue(level.var_4f436273682324)) {
      level.alex.goalradius = 2048;
      level.alex setgoalpos(level.alex.origin);
      level.alex thread watchfordeath();
      thread function_4576aecf9d0c4082(level.alex);
      level.var_4f436273682324 = 1;
      var_adbcfcbe0cd05a83 = get_array_of_closest(level.alex.origin, getaiarray("axis"), undefined, 5, 8000);

      foreach(ai in var_adbcfcbe0cd05a83) {
        ai setstealthstate("combat");
        ai getenemyinfo(level.player);
        ai setgoalpos(level.player.origin);
        ai function_9f82c74eb1b7caf9(0);
        ai thread function_d24590f588a71ca2();
      }
    }

    thread namespace_4c21e3c2da3d8585::ai_killFaroffAndObsoleteAI(8000, getaiarray("axis"), var_adbcfcbe0cd05a83);
    wait 2;
  }

  level.alex.var_175892e4721b5cfb = 0;
  level.alex.goalradius = 32;
  level.alex setgoalpos(level.alex.origin);
  level.alex scripts\common\ai::set_forcegoal();
  wait 1;

  if(!function_1bb1470f934a81eb()) {
    thread namespace_4c21e3c2da3d8585::ai_killFaroffAndObsoleteAI(8000, getaiarray("axis"), var_adbcfcbe0cd05a83);
  }

  function_401d0838f4f47c3e(0);
  level.alex scripts\engine\utility::set_movement_speed(150);
  flag_set("alex_enemies_killed");
  level.alex scripts\common\ai::stop_magic_bullet_shield();

  level.alex thread function_f91bc3964c4cfd2b();

  function_83ba9b6ffc39e72a();
  level.alex scripts\common\utility::lookatentity(level.player, 1);
  flag_wait("alex_ack_farah_vo");
  vehicleref = level.var_69c070ef9dc50848 scripts\cp_mp\vehicles\vehicle::function_d93ec4635290febd();

  if(!level.var_69c070ef9dc50848 ent_flag("ai_initted")) {
    level.var_69c070ef9dc50848 scripts\cp_mp\vehicles\vehicle::function_810dfd134e9a7a04(scripts\cp_mp\vehicles\vehicle::function_29b4292c92443328(vehicleref));
  }

  level.alex.script_startingposition = 0;
  anim_pos = scripts\common\vehicle_aianim::anim_pos(level.var_69c070ef9dc50848, level.alex.script_startingposition);
  org = level.var_69c070ef9dc50848 gettagorigin(anim_pos.sittag);
  angles = level.var_69c070ef9dc50848 gettagangles(anim_pos.sittag);
  org = getstartorigin(level.var_4a4e365abca4649c.origin, level.var_4a4e365abca4649c.angles, level.scr_anim[level.alex.animname]["outro_jltv_idle"][0]);
  angles = getstartangles(level.var_4a4e365abca4649c.origin, level.var_4a4e365abca4649c.angles, level.scr_anim[level.alex.animname]["outro_jltv_idle"][0]);
  waittime = istrue(level.alex.var_175892e4721b5cfb) ? 1.5 : 0.25;
  level.alex thread function_fc0eb6b81c66c661(waittime, "dx_cp_rnch_rnes_alex_thetruckgettothetruc", 0, 1);
  level.alex demeanoroverride("combat");
  level.alex.animnode notify("stop_looped_idle");
  level.var_4a4e365abca4649c notify("stop_looped_idle");
  level.alex function_3983bc89459e6124(org, angles, 0);
  level.alex allowedstances("crouch");
  level.var_69c070ef9dc50848.useent = spawn("script_model", level.var_69c070ef9dc50848 gettagorigin("tag_origin"));
  level.var_69c070ef9dc50848.useent setModel("tag_origin");
  level.var_69c070ef9dc50848.useent linkTo(level.var_69c070ef9dc50848, "tag_door_back_right", (40, 0, -5), (0, 0, 0));
  function_1d46e1efc318fe7e(level.var_69c070ef9dc50848.useent);
  level.var_69c070ef9dc50848 thread function_ee3e5652179e305d();
  level function_fc0eb6b81c66c661(2, "dx_cp_rnch_rnes_alex_kilogetin", 0, 1);
  thread function_ec984c2da2cd43ab();
}

function function_ec984c2da2cd43ab() {
  if(flag("player_entered_exfil_vehicle")) {
    return;
  }

  level.player endon("entered_fake_vehicle_interact");
  level endon("flag_dungeon_outro_start");
  level endon("jltv_exfil_failed");
  aliases = utility::create_deck(["dx_cp_rnch_rnes_alex_kiloletsgonow", "dx_cp_rnch_rnes_alex_comeongetinkilo", "dx_cp_rnch_rnes_alex_kilowegottago", "dx_cp_rnch_rnes_alex_inthetruckkilowereos", "dx_cp_rnch_rnes_alex_wegotwhatwecamforkil"]);
  level.alex childthread nagtill("player_entered_exfil_vehicle", aliases, growing_delay(7, 12, aliases.size));

  while(distancesquared(level.player.origin, level.var_69c070ef9dc50848.useent.origin) > 10000) {
    wait 0.2;
  }

  level.player say_team("dx_cp_rnch_rnes_fara_go", 0.8, 6);
  flag_set("exfil_nag_vo_complete");
}

function function_8fad69175440ade6(timeout) {
  level endon("exfil_nag_vo_complete");
  level.player endon("player_entered_exfil_vehicle");
  level endon("disconnect");
  wait timeout;
  flag_set("jltv_exfil_failed");
  setomnvar("ui_death_hint", 993);
  setDvar(@ "hash_93b8374b5b3983a8", 1);
  setDvar(@ "hash_42ec046969fe5985", 0);
  thread function_fa7c87f2585bd907(0);
}

function function_1d46e1efc318fe7e(usable_ent) {
  usable_ent endon("death");
  level endon("game_ended");
  usable_ent.use_func = &function_4f2924c80698a60d;
  usable_ent makeusable();
  usable_ent sethinttag("tag_origin");
  usable_ent setusepriority(0);
  usable_ent setCursorHint("HINT_BUTTON");
  usable_ent sethintdisplayrange(444);
  usable_ent sethintdisplayfov(90);
  usable_ent setuserange(56);
  usable_ent setusefov(32);
  usable_ent sethintonobstruction("hide");
  usable_ent setHintString(&"CP_JUP_RANCH/EXFIL_INTERACT");
  usable_ent setuseholdduration("duration_short");
  usable_ent thread function_861a9323c7365688();
}

function function_4f2924c80698a60d(player) {
  player notify("entered_fake_vehicle_interact");
  level.var_69c070ef9dc50848 thread scripts\common\vehicle_aianim::guy_enter(level.alex);

  iprintln("<dev string:x11a>");

  flag_set("player_entered_exfil_vehicle");
}

function function_861a9323c7365688() {
  self endon("death");
  level endon("game_ended");

  while(true) {
    self waittill("trigger", player);

    if(!player is_valid_player()) {
      continue;
    }

    if(isDefined(self.use_func)) {
      self thread[[self.use_func]](player);
    }

    return;
  }
}

function function_6f57cb374140eff1() {
  level endon("game_ended");
  level.alex endon("death");

  if(istrue(level.alex.var_8b5b5a633f9a05ff)) {
    return;
  }

  if(!isDefined(level.alex)) {
    return;
  }

  if(scripts\engine\utility::is_dead_or_dying(level.alex)) {
    return;
  }

  level.alex.var_8b5b5a633f9a05ff = 1;

  if(isDefined(level.alex.ogweapon)) {
    level.alex.weapon = level.alex.ogweapon;
    level.alex utility::initweapon(level.alex.weapon);
    level.alex giveweapon(level.alex.weapon);
    level.alex setspawnweapon(level.alex.weapon);
    level.alex.bulletsinclip = weaponclipsize(level.alex.weapon);
    level.alex.primaryweapon = level.alex.weapon;
  }

  level.alex.animnode notify("stop_looped_idle");
  level.alex.dontmeleeme = 1;
  level.alex.meleealwayswin = 1;
  level.alex.health = 150;
  level.alex.maxhealth = 150;
  level.alex allowedstances("stand", "prone", "crouch");
  level.alex namespace_1170726b2799ea65::function_e483413541e6f5cc();
  level.alex thread anim_single_solo(level.alex, "grab_gun_4");
  wait getanimlength(level.scr_anim["hostage_alex"]["grab_gun_4"]);
  level.alex.ignoreall = 0;
  level.alex.ignoreme = 0;
  level.alex.dontevershoot = 0;
  level.var_87a24dcbeb99b940 = array_removedead_or_dying(level.var_87a24dcbeb99b940);

  if(level.var_87a24dcbeb99b940.size == 1) {
    level.alex.goalradius = 2048;
    level.alex.favoriteenemy = level.var_87a24dcbeb99b940[0];
    level.alex setgoalentity(level.var_87a24dcbeb99b940[0]);
    level.alex agentsetfavoriteenemy(level.var_87a24dcbeb99b940[0]);
    level.alex function_710bd6843f902d50(level.var_87a24dcbeb99b940[0], 1);
    level.alex forcethreatupdate();
    level.alex getenemyinfo(level.var_87a24dcbeb99b940[0]);
    level.alex updateaiminfo();
  } else {
    level.alex.goalradius = 1024;
    level.alex setgoalentity(level.player);
  }

  flag_set("alex_getup_done");
}

function private function_3983bc89459e6124(goalorigin, goalangles, link, delay) {
  self endon("death");

  if(isDefined(delay)) {
    wait delay;
  }

  self.ignoreall = 1;
  level.alex scripts\engine\utility::set_movement_speed(150);
  self setgoalpos(self getclosestreachablepointonnavmesh(goalorigin));

  if(getdvarint(@ "hash_240a0a270a10ac23", 0)) {
    level thread scripts\cp\utility::drawsphere(self.origin, self.goalradius, 45, (1, 0, 1));
    level thread scripts\cp\utility::drawsphere(goalorigin, 5, 40, (0, 0, 1));
  }

  self.goalradius = 8;
  self.script_radius = 8;
  self waittill("goal");

  if(!isDefined(goalangles)) {
    goalangles = (0, 0, 0);
  }

  if(istrue(link)) {
    self.anchor = spawn("script_origin", goalorigin);
    self.anchor.angles = goalangles;
    self linkTo(self.anchor);
  }
}

function private waittill_near_goal(origin, radius) {
  if(!isDefined(origin)) {
    assertmsg("<dev string:x136>");
    return;
  }

  while(distancesquared(self.origin, origin) > radius) {
    wait 0.1;
  }
}

function function_1a011c0ac5964a96(event) {
  if(function_8c7693e96a9c9933(event)) {
    return true;
  }

  return false;
}

function function_564bd7f619787bcc(event) {
  var_fbd834203635e263 = ["bulletwhizby", "silenced_shot", "silenced_shot_impact", "death", "ally_killed", "ally_damaged", "footstep", "footstep_sprint", "footstep_walk", "projectile_impact", "door_bash", "landing", "missile_spawned", "saw_corpse", "curiousenemy", "cover_blown", "explosion"];

  if(!flag("hostage_ai_goto_combat")) {
    return true;
  }

  if(array_contains(var_fbd834203635e263, event.typeorig)) {
    if(!istrue(self.var_795cc27ae7258081)) {
      self setstealthstate("combat");

      if(isDefined(level.alex)) {
        self.goalradius = 2048;
        self.var_795cc27ae7258081 = 1;
        self.favoriteenemy = level.player;
        self setgoalentity(level.player);
        self agentsetfavoriteenemy(level.player);
        self function_710bd6843f902d50(level.player, 1);
        self forcethreatupdate();
        self getenemyinfo(level.player);
        self updateaiminfo();
        thread function_fe810daeeb68301c(5);
      }
    }

    return false;
  }

  if(function_9a9b91c11482389f(event)) {
    return true;
  }

  if(event.typeorig == "saw_corpse") {
    if(isDefined(self.vehicle) && isDefined(self.vehicle.var_f626b845d8c284e2)) {
      self.vehicle.var_f626b845d8c284e2 = 1;
      self.vehicle.var_fda9ea513d557243 = event;
      return false;
    }
  }

  if(event.type == "combat" || event.type == "cover_blown") {
    self.goalradius = 1024;

    if(!istrue(self.var_795cc27ae7258081)) {
      if(isDefined(level.alex)) {
        self.goalradius = 2048;
        self.var_795cc27ae7258081 = 1;
        self.favoriteenemy = level.player;
        self setgoalentity(level.player);
        self agentsetfavoriteenemy(level.player);
        self function_710bd6843f902d50(level.player, 1);
        self forcethreatupdate();
        self getenemyinfo(level.player);
        self updateaiminfo();
        thread function_fe810daeeb68301c(5);
      }
    }

    return false;
  }

  return false;
}

function function_ee2c06b142d32bf7(event) {
  if(!istrue(self.var_c0a575d7e52b6fea)) {
    thread ai_runSeekLogicAfterShotsFired();
    return 0;
  }
}

function ai_runSeekLogicAfterShotsFired() {
  self endon("death");
  self notify("ai_runSeekLogicAfterShotsFired");
  self endon("ai_runSeekLogicAfterShotsFired");

  while(level.shots_fired["ranch"] == 0) {
    waitframe();
  }

  self.var_c0a575d7e52b6fea = 1;
  self getenemyinfo(level.player);
  self setgoalpos(level.player.origin);
  thread function_d24590f588a71ca2(1);
  thread function_58364fac8e911f65();
}

function function_58364fac8e911f65() {
  self endon("death");
  self waittill("stealth_hunt");
  scripts\cp\spawning::set_goal_radius(2048);
  scripts\stealth\enemy::bt_set_stealth_state("idle", undefined);
  self.var_c0a575d7e52b6fea = undefined;
  self notify("stop_player_seek");
}

function function_fe810daeeb68301c(timeout) {
  self endon("death");
  self endon("force_kill_favorite_enemy_thread");
  level.alex endon("death");

  if(!flag("alex_guards_were_attacked")) {
    flag_set("alex_guards_were_attacked");
    level.player say("dx_cp_rnch_rnes_fara_echogetdown", 1, 1, 0);
  }

  wait timeout;

  if(istrue(level.alex.marked_for_death)) {
    return;
  }

  var_de75c116ff5e3add = undefined;

  if(isDefined(level.var_87a24dcbeb99b940) && level.var_87a24dcbeb99b940.size > 1) {
    level.alex.marked_for_death = 1;
    var_ae7ff4d3ccc92af6 = function_2ddd38fa467c381a(self.origin, level.var_87a24dcbeb99b940, [self]);

    if(isDefined(var_ae7ff4d3ccc92af6)) {
      foreach(var_de75c116ff5e3add in var_ae7ff4d3ccc92af6) {
        var_de75c116ff5e3add notify("force_kill_favorite_enemy_thread");
        level.alex.ignoreme = 0;
        level.alex.health = 20;
        level.alex.maxhealth = 20;
        var_de75c116ff5e3add.goalradius = 2048;
        var_de75c116ff5e3add.favoriteenemy = level.alex;
        var_de75c116ff5e3add setgoalentity(level.alex);
        var_de75c116ff5e3add agentsetfavoriteenemy(level.alex);
        var_de75c116ff5e3add function_710bd6843f902d50(level.alex, 1);
        var_de75c116ff5e3add forcethreatupdate();
        var_de75c116ff5e3add getenemyinfo(level.alex);
        var_de75c116ff5e3add updateaiminfo();
      }

      return;
    }

    level.alex.ignoreme = 0;
    self.goalradius = 2048;
    self.favoriteenemy = level.alex;
    level.alex.health = 20;
    level.alex.maxhealth = 20;
    self setgoalentity(level.alex);
    self agentsetfavoriteenemy(level.alex);
    self function_710bd6843f902d50(level.alex, 1);
    self forcethreatupdate();
    self getenemyinfo(level.alex);
    self updateaiminfo();
  }
}

function function_2ddd38fa467c381a(origin, aiarray, var_3562affa79cfe81d) {
  return scripts\engine\utility::array_exclude(aiarray, var_3562affa79cfe81d);
}

function function_17006546f61dd733() {
  flag_wait("start_mission_flow");
  flag_wait("obj_search_completed");
  flag_wait("obj_phones_completed");
  flag_set("start_escape_flow");
  flag_wait("alex_enemies_killed");
  function_8c9d8ceb57e488e2();
}

function function_8c9d8ceb57e488e2() {
  level.player endon("death");
  level.player endon("disconnect");
  level endon("game_ended");
  escapestruct = getStruct("obj_escape", "targetname");
  flag_wait("obj_escape_completed");
}

function function_f57cfcbd4a89055e(escapestruct) {
  level endon("obj_escape_completed");
  var_cffca1a9623f41d5 = escapestruct create_interact(undefined, undefined, undefined, undefined, &"CP_JUP_RANCH/EXFIL_INTERACT");
  var_cffca1a9623f41d5 setuseholdduration("duration_none");
  var_cffca1a9623f41d5 waittill("trigger");
  var_cffca1a9623f41d5 delete();
  flag_set("obj_escape_completed");

  if(isDefined(level.var_3560bc2e9e99b27f)) {
    objective_state(level.var_3560bc2e9e99b27f, "done");
    scripts\cp\cp_objectives::freeworldidbyobjid(level.var_3560bc2e9e99b27f);
    objective_delete(level.var_3560bc2e9e99b27f);
  }
}

function function_7d8870e0c4833d08(escapestruct) {
  level endon("obj_escape_completed");
  trigger = getEnt("exfil_vehicle_trigger", "targetname");

  while(true) {
    trigger waittill("trigger");

    if(isDefined(level.player.vehicle)) {
      break;
    }
  }

  flag_set("jltv_escape");
  flag_set("obj_escape_completed");
}

function function_cce1ca1325cccbe4() {
  flag_wait("start_mission_flow");
  flag_wait("dungeon_load_finished");
  namespace_9766820f5baa93fb::function_cd054d9ba5a62557(0);

  if(!flag("jltv_escape")) {
    play_outro();
  }

  setDvar(@ "hash_93b8374b5b3983a8", 1);
  setDvar(@ "hash_42ec046969fe5985", 0);
  function_fa7c87f2585bd907(1);
}

function function_f27f353ab374e92d() {
  flag_wait("start_mission_flow");
  level.var_69424e5ded8586a3 = [];
  level.player.ignoreme = 1;
  level thread scripts\cp\utility\player::function_1c0f3b6933eb1c87();
  level thread damage_debug();
  level.var_63b40830aaf1479a = getStruct("headlight_ref_point", "targetname");
  var_6609794f0e75c6be = array_merge(getEntArray("shadow_vol", "targetname"), getEntArray("tall_grass_vol", "targetname"));
  var_2b58e2b063a747ad = [];

  foreach(vol in var_6609794f0e75c6be) {
    vol function_916233af1855619c();

    if(isDefined(vol.var_55cc71192b8f1931)) {
      if(array_contains(vol.var_55cc71192b8f1931, "flashlight_ignore")) {
        var_6609794f0e75c6be = array_remove(var_6609794f0e75c6be, vol);
        continue;
      }

      if(array_contains(vol.var_55cc71192b8f1931, "control_flashlight_angles")) {
        var_2b58e2b063a747ad = array_add(var_2b58e2b063a747ad, vol);
      }
    }
  }

  level.var_6609794f0e75c6be = var_6609794f0e75c6be;
  level.var_2b58e2b063a747ad = var_2b58e2b063a747ad;
  waitframe();
  level thread function_b682757cf13272f2();
  wait 1;
  flag_set("active_combat_begun");
  flag_set("active_combat_cooldown");
  level waittill("spawn_reinforcement_vehicle");
  flag_clear("active_combat_cooldown");
  flag_wait("stealth_tuning_end");
}

function function_7df46845d188e201() {
  level.player endon("death");
  level.player endon("disconnect");
  level endon("game_ended");
  level endon("obj_escape_completed");
  hilltop = getEnt("hilltop", "targetname");
  var_3a664e7d4852fd4a = getEnt("goal_vol_building_1", "targetname");
  var_f8e6f91ff10d8f27 = getEnt("goal_vol_building_2", "targetname");
  var_f90874a8b4d576c8 = getEnt("goal_vol_manor", "targetname");

  while(true) {
    waitframe();

    if(level.player istouching(hilltop)) {
      function_6bba37af4d180e78("hilltop");
      continue;
    }

    if(level.player istouching(var_f90874a8b4d576c8)) {
      function_6bba37af4d180e78("manor");
      continue;
    }

    if(level.player istouching(var_3a664e7d4852fd4a)) {
      function_6bba37af4d180e78("building1");
      continue;
    }

    if(level.player istouching(var_f8e6f91ff10d8f27)) {
      function_6bba37af4d180e78("building2");
      continue;
    }

    function_6bba37af4d180e78("exterior");
  }
}

function function_6bba37af4d180e78(var_1959d9eed24cdcbc) {
  if(!isDefined(level.player.var_bec156d5a2918db9) || level.player.var_bec156d5a2918db9 != var_1959d9eed24cdcbc) {
    level.player.var_30c91008e477cc78 = gettime();
    level.player.var_bec156d5a2918db9 = var_1959d9eed24cdcbc;
    level notify("player_enter_" + var_1959d9eed24cdcbc);
  }
}

function function_30464adb821a12f5() {
  level thread function_5d7badec2d2bd038();
  level thread function_b5bd4585f3ea4b12();
}

function function_5d7badec2d2bd038() {
  level endon("game_ended");

  while(!isDefined(level.player)) {
    waitframe();
  }

  level.player endon("death");

  while(true) {
    level.player waittill("laser_trap_exploded");
    function_2311740fe797906a("playerDefeatReason", "TRIPWIRE");
  }
}

function function_b5bd4585f3ea4b12() {
  level endon("game_ended");

  while(!isDefined(level.player)) {
    waitframe();
  }

  level.player endon("death");

  while(true) {
    level.player waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(!isDefined(attacker)) {
      continue;
    }

    if(isDefined(level.var_20a7c4701df58193.mgturret[0]) && isalive(level.var_20a7c4701df58193) && attacker == level.var_20a7c4701df58193.mgturret[0]) {
      function_2311740fe797906a("playerDefeatReason", "JLTV");
    }
  }
}

function function_85efd2b1fb22ed02() {
  level endon("game_ended");

  while(!isDefined(level.player)) {
    waitframe();
  }

  level.player endon("death");

  while(!isDefined(level.var_20a7c4701df58193)) {
    waitframe();
  }

  while(true) {
    level.player waittill("damage_armor", damage, attacker);

    if(!isDefined(attacker)) {
      continue;
    }

    if(isDefined(level.var_20a7c4701df58193.mgturret[0]) && isalive(level.var_20a7c4701df58193) && attacker == level.var_20a7c4701df58193.mgturret[0]) {
      function_2311740fe797906a("playerDefeatReason", "JLTV");
    }
  }
}

function function_6645b741c02aa09a() {
  level endon("game_ended");

  while(!isDefined(level.player)) {
    waitframe();
  }

  level.player endon("death");

  while(true) {
    level waittill("player_swarmed");
    function_2311740fe797906a("playerDefeatReason", "SWARM");
  }
}

function function_b682757cf13272f2() {
  level.player endon("death");
  level.player endon("disconnect");
  level endon("game_ended");
  level.var_89a2b6842bada623 = [];
  level.var_89a2b6842bada623[0] = ["reinforcements_truck_start", "reinforcements_riders_start", "reinforcements_start_group", getStruct("reinforcements_start_dest", "targetname")];
  level.var_89a2b6842bada623[1] = ["reinforcements_truck_roadwest", "reinforcements_riders_roadwest", "reinforcements_pickup_group", getStruct("reinforcements_roadwest_dest", "targetname")];
  level.var_89a2b6842bada623[2] = ["reinforcements_truck_barn", "reinforcements_riders_barn", "reinforcements_pickup_group", getStruct("reinforcements_barn_dest", "targetname")];
  level.var_89a2b6842bada623[3] = ["reinforcements_truck_manor_side", "reinforcements_riders_manor_side", "reinforcements_pickup_group", getStruct("reinforcements_manor_side_dest", "targetname")];
  level.var_89a2b6842bada623[4] = ["reinforcements_truck_center", "reinforcements_riders_center", "reinforcements_pickup_group", getStruct("reinforcements_center_dest", "targetname")];
  level.var_89a2b6842bada623[5] = ["reinforcements_truck_building1_rear", "reinforcements_riders_building1_rear", "reinforcements_pickup_group", getStruct("reinforcements_building1_rear_dest", "targetname")];
  level.var_89a2b6842bada623[6] = ["reinforcements_truck_building1_side", "reinforcements_riders_building1_side", "reinforcements_pickup_group", getStruct("reinforcements_building1_side_dest", "targetname")];
  level.var_89a2b6842bada623[7] = ["reinforcements_truck_south", "reinforcements_riders_south", "reinforcements_pickup_group", getStruct("reinforcements_south_dest", "targetname")];
  level.var_3a5931e53926a8d6 = [];
  level.var_91ebedd109ae8466 = 0;
  flag_wait("stealth_ranges_initialized");
  wait 5;
  level thread function_ccb3181593bcad38();

  while(level.var_89a2b6842bada623.size > 0) {
    level waittill("spawn_reinforcement_vehicle");

    if(level.var_91ebedd109ae8466 < 3) {
      var_22ebbef1a711401 = function_13851a116f31b743(level.var_89a2b6842bada623);
      var_54306d6c0a0664d5 = level.var_89a2b6842bada623[var_22ebbef1a711401];
      level.var_89a2b6842bada623 = array_remove_index(level.var_89a2b6842bada623, var_22ebbef1a711401);

      iprintlnbold("<dev string:x156>");

      level thread function_343943373914751a(var_54306d6c0a0664d5[0], var_54306d6c0a0664d5[1], var_54306d6c0a0664d5[2]);
    } else {
      iprintlnbold("<dev string:x16c>");

      var_d78e817a9254a50b = function_721467680b395f40(level.var_89a2b6842bada623);
      level.var_a8ddfc0c805b2244 = getaiarray("axis");
      waitframe();

      if(isDefined(var_d78e817a9254a50b)) {
        level thread function_f871a83652d88295(var_d78e817a9254a50b);
      }
    }

    function_c63d2b9d18f029e1();
  }
}

function function_c63d2b9d18f029e1() {
  if(!flag("obj_search_completed")) {
    level endon("obj_search_completed");
    wait 20;
    return;
  }

  wait 10;
}

function function_13851a116f31b743(var_89a2b6842bada623) {
  shortest = undefined;
  var_e509b06e0217c3b0 = undefined;

  for(i = 0; i < var_89a2b6842bada623.size; i++) {
    dist = distance(level.player.origin, var_89a2b6842bada623[i][3].origin);

    if(!isDefined(shortest) || dist < shortest) {
      shortest = dist;
      var_e509b06e0217c3b0 = i;
    }
  }

  return var_e509b06e0217c3b0;
}

function function_721467680b395f40(var_89a2b6842bada623) {
  var_746f0814ed68d9b4 = getStructArray("reinforcements_spawn_struct", "script_noteworthy");
  var_746f0814ed68d9b4 = sortbydistance(var_746f0814ed68d9b4, level.player.origin);
  var_b5cf3d36323ea3f3 = [];

  for(i = 0; i < var_746f0814ed68d9b4.size; i++) {
    for(j = 0; j < level.var_89a2b6842bada623.size; j++) {
      if(level.var_89a2b6842bada623[j][3].targetname == var_746f0814ed68d9b4[i].targetname) {
        var_b5cf3d36323ea3f3 = array_add(var_b5cf3d36323ea3f3, level.var_89a2b6842bada623[j][1]);
      }
    }
  }

  return var_b5cf3d36323ea3f3[var_b5cf3d36323ea3f3.size - 1];
}

function function_dc90c95adcc3fd88(var_b5cf3d36323ea3f3) {
  for(i = 0; i < var_b5cf3d36323ea3f3.size; i++) {
    spawners = getStructArray(var_b5cf3d36323ea3f3[i], "targetname");
    var_5dad8ab9ce86e842 = 0;
    dist = distance2d(level.player.origin, spawners[0].origin);

    if(dist < 1000) {
      continue;
    }

    foreach(spawner in spawners) {
      if(within_fov(level.player.origin, level.player.angles, spawner.origin, 0)) {
        var_5dad8ab9ce86e842++;
      }
    }

    if(var_5dad8ab9ce86e842 > 0) {
      continue;
    }

    return spawners[0].targetname;
  }
}

function function_ccb3181593bcad38() {
  level.player endon("death");
  level.player endon("disconnect");
  level endon("game_ended");
  level endon("black_box_picked_up");
  wait 10;

  while(true) {
    enemy_array = getaiarray("axis");

    if(!isDefined(enemy_array)) {
      return;
    } else {
      var_61ebee12b90dde41 = enemy_array.size;
    }

    if(var_61ebee12b90dde41 < 14) {
      if(flag("active_combat_begun")) {
        flag_wait("active_combat_cooldown");
        level.var_51e628aa4bdc6cd4 = function_61ea85620bfd2294();

        iprintlnbold("<dev string:x181>");

        thread function_c600266435c46de();
        wait 25;
        level notify("spawn_reinforcement_vehicle");
        level.var_91ebedd109ae8466++;
      }
    }

    if(level.var_91ebedd109ae8466 > 20) {
      break;
    }

    wait 5;
  }
}

function function_cf7e29c6b5b7cb9c() {
  level.player endon("death");
  level.player endon("disconnect");
  level endon("game_ended");
  flag_wait("active_combat_begun");
  wait 120;
  flag_set("reinforcement_phase1_timeout");
}

function function_4d5979770e3dcb1() {
  level.player endon("death");
  level.player endon("disconnect");
  level endon("game_ended");
  flag_wait("active_combat_begun");
  wait 180;
  flag_set("reinforcement_phase2_timeout");
}

function function_80e0118ebfbf03b0() {
  var_7f2d3ad95ec1ccf9 = level.var_57157ccb0f54801.ai_spawned;
  var_7f2d3ad95ec1ccf9 = array_merge(var_7f2d3ad95ec1ccf9, level.var_69424e5ded8586a3);
  var_7f2d3ad95ec1ccf9 = function_fdc9d5557c53078e(var_7f2d3ad95ec1ccf9);
  return var_7f2d3ad95ec1ccf9.size;
}

function function_3f31da16d025933b() {
  var_7f2d3ad95ec1ccf9 = level.var_57157ccb0f54801.ai_spawned;
  var_7f2d3ad95ec1ccf9 = array_merge(var_7f2d3ad95ec1ccf9, level.var_69424e5ded8586a3);
  var_7f2d3ad95ec1ccf9 = array_removeundefined(var_7f2d3ad95ec1ccf9);
  return var_7f2d3ad95ec1ccf9;
}

function function_d2c44371a392b93f() {
  var_e1e2b31e8a161432 = function_fdc9d5557c53078e(level.var_69424e5ded8586a3);
  var_7f2d3ad95ec1ccf9 = level.var_57157ccb0f54801.ai_spawned;
  var_7f2d3ad95ec1ccf9 = function_fdc9d5557c53078e(var_7f2d3ad95ec1ccf9);
  all_ais = [];
  all_ais = array_merge(var_e1e2b31e8a161432, var_7f2d3ad95ec1ccf9);
  return all_ais;
}

function is_in_combat() {
  if(!flag("start_mission_flow")) {
    return 0;
  }

  if(!isDefined(level.var_69424e5ded8586a3)) {
    return 0;
  }

  return function_489a0835e10a9b55(function_d2c44371a392b93f());
}

function vo_jltv_reinforcements() {
  level endon("obj_search_completed");
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_rnra_alex_kilobeadvisedenemyre";
  aliases[aliases.size] = "dx_cp_rnch_rnra_alex_headsupfarahyougotko";
  aliases[aliases.size] = "dx_cp_rnch_rnra_alex_konnissendingreinfor";
  aliases[aliases.size] = "dx_cp_rnch_rnra_alex_goteyesonkonnigunner";
  var_1dd7283b8862d8e1 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_rnrb_alex_wegotmorekonniincomi";
  aliases[aliases.size] = "dx_cp_rnch_rnrb_alex_seeingmorereinforcem";
  aliases[aliases.size] = "dx_cp_rnch_rnrb_alex_morekonnireinforceme";
  aliases[aliases.size] = "dx_cp_rnch_rnrb_alex_konnisgotmorereinfor";
  aliases[aliases.size] = "dx_cp_rnch_rnrb_alex_farahtheyresendingin";
  aliases[aliases.size] = "dx_cp_rnch_rnrb_alex_youvegotmoreenemyrei";
  aliases[aliases.size] = "dx_cp_rnch_rnrb_alex_moreenemyreinforceme";
  aliases[aliases.size] = "dx_cp_rnch_rnrc_alex_konnicalledinmoresup";
  aliases[aliases.size] = "dx_cp_rnch_rnwa_alex_multiplesquadsconver";
  var_f88c87769264cee6 = create_deck(aliases, 1, 1);

  while(true) {
    level waittill("spawn_reinforcement_vehicle");

    if(!isDefined(level.var_f11828e9cc4efd13)) {
      level.var_f11828e9cc4efd13 = 0;
    }

    if(!time_has_passed(level.var_f11828e9cc4efd13, 7)) {
      wait 2;
      continue;
    }

    said = level.player function_c02941e07491127e(var_1dd7283b8862d8e1 deck_draw(), var_f88c87769264cee6 deck_draw(), 0, 2, 0, 0.5);

    if(istrue(said)) {
      level.var_f11828e9cc4efd13 = gettime();
    }

    thread function_ee973ff3fd2f2306();
  }
}

function function_907f11a8ccd2d5a8() {
  iprintlnbold("<dev string:x18d>");

  wait 3;

  iprintlnbold("<dev string:x1bb>");

  level thread function_343943373914751a("reinforcements_truck_center", "reinforcements_riders_center", "reinforcements_pickup_group");
  wait 10;

  iprintlnbold("<dev string:x1d7>");

  level thread function_343943373914751a("reinforcements_truck_start", "reinforcements_riders_start", "reinforcements_pickup_group");
  wait 10;

  iprintlnbold("<dev string:x1f2>");

  level thread function_343943373914751a("reinforcements_truck_barn", "reinforcements_riders_barn", "reinforcements_pickup_group");
  wait 10;

  iprintlnbold("<dev string:x20c>");

  level thread function_343943373914751a("reinforcements_truck_building1_rear", "reinforcements_riders_building1_rear", "reinforcements_pickup_group");
  wait 10;

  iprintlnbold("<dev string:x230>");

  level thread function_343943373914751a("reinforcements_truck_building1_side", "reinforcements_riders_building1_side", "reinforcements_pickup_group");
  wait 10;

  iprintlnbold("<dev string:x254>");

  level thread function_343943373914751a("reinforcements_truck_manor_side", "reinforcements_riders_manor_side", "reinforcements_pickup_group");
  wait 10;

  iprintlnbold("<dev string:x274>");

  level thread function_343943373914751a("reinforcements_truck_roadwest", "reinforcements_riders_roadwest", "reinforcements_pickup_group");
}

function function_995243c3c0cf685f() {
  flag_wait("dungeon_load_finished");
  level.var_a8dc22c62ba69b88["spawn_func_patrols_pickup"] = &spawn_func_patrols_pickup;
  group_name = "patrols_pickup_group";
  group_size = 5;
  vehicle_spawner = getStruct("spawner_patrols_pickup", "targetname");

  if(isDefined(vehicle_spawner.var_1e33f32152f60866)) {
    data = scripts\cp_mp\vehicles\vehicle::function_29b4292c92443328(vehicle_spawner.var_1e33f32152f60866);
    group_size = data.aiseats.size;
  }

  scripts\cp\spawning::registerambientgroup(group_name, group_size, group_size, group_size, 0.05, undefined, group_name, undefined, undefined, undefined);
  vehicle_spawner.var_79a88fdcf2bbdd5 = 1;
  ai_spawners = getStructArray(group_name, "targetname");
  var_1c4a29f2a139392 = array_slice(ai_spawners, 0, group_size);
  vehicle = level namespace_ba155a12c323dc5a::function_136d8a6a5c016d7e(vehicle_spawner, var_1c4a29f2a139392, "p2p");
  vehicle function_7bab36d00691fb59();
  vehicle thread function_ca64fb35a3e0f92d();
  level.var_20a7c4701df58193 = vehicle;
  function_401d0838f4f47c3e(1);
}

function function_7bab36d00691fb59() {
  startingnode = self.currentnode;
  startingnode function_916233af1855619c();

  for(curnode = getStruct(startingnode.target, "targetname"); curnode != startingnode; curnode = getStruct(curnode.target, "targetname")) {
    curnode function_916233af1855619c();
  }
}

function function_ca64fb35a3e0f92d() {
  self endon("death");
  level endon("game_ended");
  self.var_f7532aedaddbfafd = 0;
  function_53d41f8646e67572();
  flag_wait("active_combat_begun");

  while(!function_e21f35146826825e()) {
    waitframe();

    switch (getDvar(@ "hash_68dcaa014759d7ef", "default")) {
      case #"hash_ce928420e180f157":
        function_46c6b08b85e55790();
        continue;
      case #"hash_23d3b48a2fabf145":
        function_ab71e0ff1e67c211();
        continue;
    }

    if(function_721b743416d34678()) {
      if(!flag("obj_search_completed") || !flag("obj_phones_completed")) {
        if(distance(level.player.origin, self.mgturret[0].origin) < 400) {
          function_46c6b08b85e55790();
          continue;
        }
      }

      function_ab71e0ff1e67c211();
      continue;
    }

    if(flag("obj_search_completed") && flag("obj_phones_completed")) {
      function_298cf564da42aee("exfil_guard_point");
      continue;
    }

    if(function_e925df9a8a7e1aef()) {
      function_46c6b08b85e55790();
      continue;
    }

    if(function_4a9c38c112e95771(3, 10)) {
      level notify("vo_ai_call_for_fire_support");
      function_46c6b08b85e55790();
      continue;
    }

    if(is_in_combat()) {
      if(flag("flag_ranch_patrol_vehicle_continue")) {
        function_46c6b08b85e55790();
        continue;
      } else {
        function_ab71e0ff1e67c211();
        continue;
      }
    }

    if(flag("flag_ranch_patrol_vehicle_continue")) {
      function_298cf564da42aee("poi");
      continue;
    }

    function_ab71e0ff1e67c211();
    continue;
  }

  self notify("newpath");
  self.forced_speed = 0;
  self notify("reached_dynamic_path_end");
  thread namespace_ba155a12c323dc5a::common_unload();
}

function function_46c6b08b85e55790() {
  self.forced_speed = 20;
  flag_set("flag_ranch_patrol_vehicle_continue");
}

function function_ab71e0ff1e67c211() {
  flag_clear("flag_ranch_patrol_vehicle_continue");
  var_3e8899a5ba89ac6f = getStruct(self.currentnode.target, "targetname");
  var_3e8899a5ba89ac6f.script_flag_wait = "flag_ranch_patrol_vehicle_continue";
}

function function_298cf564da42aee(parameter) {
  if(isDefined(self.currentnode.var_55cc71192b8f1931) && array_contains(self.currentnode.var_55cc71192b8f1931, parameter)) {
    function_ab71e0ff1e67c211();
    return;
  }

  var_3e8899a5ba89ac6f = getStruct(self.currentnode.target, "targetname");

  if(isDefined(var_3e8899a5ba89ac6f.var_55cc71192b8f1931) && array_contains(var_3e8899a5ba89ac6f.var_55cc71192b8f1931, parameter)) {
    function_ab71e0ff1e67c211();
    return;
  }

  function_46c6b08b85e55790();
}

function function_e21f35146826825e() {
  if(!isalive(self.riders[0])) {
    return true;
  }

  if(!isalive(self.riders[4])) {
    return true;
  }

  return false;
}

function function_721b743416d34678() {
  self endon("death");
  level endon("game_ended");
  var_c6cc481297bce5c2 = function_155f16ed1b7f00cd(self.riders, 3);

  if(var_c6cc481297bce5c2) {
    if(!isDefined(self.var_c6cc481297bce5c2) || self.var_c6cc481297bce5c2 == 0) {
      level notify("vo_patrol_truck_sees_enemy");
    }
  }

  self.var_c6cc481297bce5c2 = var_c6cc481297bce5c2;
  return self.var_c6cc481297bce5c2;
}

function function_e925df9a8a7e1aef() {
  return flag("patrol_truck_under_attack");
}

function function_53d41f8646e67572() {
  thread function_bfacce01d458567f();

  foreach(rider in self.riders) {
    rider thread function_bfacce01d458567f();
  }

  thread function_d5b92794251bb8f4();
}

function function_d5b92794251bb8f4() {
  self endon("death");
  level endon("game_ended");

  while(true) {
    level waittill("patrol_truck_or_rider_damage");
    flag_set("patrol_truck_under_attack");
    thread function_7086acd9a6cee420();
  }
}

function function_7086acd9a6cee420() {
  self endon("death");
  level endon("game_ended");
  self notify("patrol_truck_recent_damage_timer");
  self endon("patrol_truck_recent_damage_timer");
  wait 5;
  level flag_clear("patrol_truck_under_attack");
}

function function_bfacce01d458567f() {
  self endon("death");
  level endon("game_ended");

  while(true) {
    self waittill("damage", amount, attacker, direction, point, means);
    level notify("patrol_truck_or_rider_damage");
  }
}

function function_343943373914751a(var_ee2c109a3d60932b, var_d87d5070ace6a023, group_name) {
  level.var_a8dc22c62ba69b88["spawn_func_reinforcements_pickup"] = &spawn_func_reinforcements_pickup;
  vehicle_spawner = getStruct(var_ee2c109a3d60932b, "targetname");
  group_size = 5;

  if(isDefined(vehicle_spawner.var_1e33f32152f60866)) {
    data = scripts\cp_mp\vehicles\vehicle::function_29b4292c92443328(vehicle_spawner.var_1e33f32152f60866);
    group_size = data.aiseats.size;
  }

  vehicle_spawner.var_79a88fdcf2bbdd5 = 1;
  ai_spawners = getStructArray(var_d87d5070ace6a023, "targetname");
  var_1c4a29f2a139392 = array_slice(ai_spawners, 0, group_size);
  vehicle = level namespace_ba155a12c323dc5a::function_136d8a6a5c016d7e(vehicle_spawner, var_1c4a29f2a139392, "p2p");
  thread namespace_9faa61bf1903f9b8::function_6e702f33ebd498d7(vehicle);
  vehicle.var_f7532aedaddbfafd = 1;
  vehicle.var_eb504fc7e1cfeb4c = 1;
  level.var_69424e5ded8586a3 = array_merge(level.var_69424e5ded8586a3, vehicle.riders);
  vehicle thread function_27279b12dec10048();
}

function function_f29e9e88cd69b3bd() {
  namespace_cbe993018617a21d::function_5d3dd28d4c5af8b2(self.riders);
  return undefined;
}

function function_f871a83652d88295(var_d87d5070ace6a023) {
  var_283c07d93f1cfaa9 = function_6149b301ce19988b(var_d87d5070ace6a023, &function_b863dcd61d90ee40);
  wait 0.5;

  if(isDefined(var_283c07d93f1cfaa9.ai_spawned[0])) {
    level.var_3a5931e53926a8d6 = array_merge(level.var_3a5931e53926a8d6, var_283c07d93f1cfaa9.ai_spawned);
  }
}

function function_27279b12dec10048() {
  level endon("game_ended");
  self endon("death");
  self endon("reached_dynamic_path_end");

  for(last_pos = self.origin; true; last_pos = self.origin) {
    wait 1;
    dist = distance(last_pos, self.origin);

    if(dist < 1) {
      break;
    }
  }

  self.forced_speed = 0;
  thread namespace_cbe993018617a21d::unloadvehicle();
}

function spawn_func_patrols_pickup() {
  function_5a44f27c93a4bbff();
  self setscriptablepartstate("lights_front_cheap", "on");
  self setscriptablepartstate("lights_back_cheap", "on");
  spawn_func_reinforcements_pickup();
}

function spawn_func_reinforcements_pickup() {
  if(!flag_exist("level_ready_for_script")) {
    flag_init("level_ready_for_script");
  }

  flag_wait("level_ready_for_script");
  self endon("death");
  self.var_f7532aedaddbfafd = 1;
  self.goal_threshold = 200;

  if(scripts\engine\utility::issharedfuncdefined("veh9_techo_rebel_armor", "damageIgnoresArmor")) {
    self.var_7a646ff827387ac0 = scripts\engine\utility::getsharedfunc("veh9_techo_rebel_armor", "damageIgnoresArmor");
  }

  level.vehicle.var_3dfa81ab7ac6a1b3 = &function_df6a8acc9d5c7765;
}

function function_df6a8acc9d5c7765(vehicle, var_23c7137b7d74fee2) {
  if(isDefined(var_23c7137b7d74fee2)) {
    foreach(rider in var_23c7137b7d74fee2) {
      rider thread function_50bcab0484efab3b();
      rider thread function_ddf2ee39214008f9();
    }
  }

  return true;
}

function function_50bcab0484efab3b(delay) {
  self endon("death");

  if(isDefined(delay)) {
    wait delay;
  }

  if(function_eac0cd99c9c6d8ee() == "spotted") {
    self getenemyinfo(level.player);
    return;
  }

  if(isDefined(level.var_51e628aa4bdc6cd4)) {
    last_known_position = level.var_51e628aa4bdc6cd4;
  } else {
    last_known_position = level.player.origin;
  }

  self.var_9a04c6cfe15e92a7 = last_known_position;
  self[[self.fnsetstealthstate]]("hunt");
  self.var_587d8840dea10869 = 1;
  self.var_97db6f81ba0702e3 = 0;
  wait 1;
  self.var_587d8840dea10869 = 0;
  self.var_97db6f81ba0702e3 = undefined;
}

function function_ffc7dd3a5adfd5cf() {
  level thread function_36318a2e1c3e9bdc();
  level thread function_1111f0bd1213841b();
  level thread function_dd9645b711916a73();
  level thread function_b27598ebbbfaa3b6();
  level thread function_a3b78aa482a0cd19();
  level thread function_285573daf178e366();
  level thread function_215d63eb1ee370c9();
  level thread function_5b64fc0bb16498ac();
  level thread function_ca578b8a333224b2();
  level thread function_9b08b4ebd51bd18f();
  level thread function_429272af11ed4dec();
  level thread function_9d0e41419bcd28f5();
  level.var_c3198933a25f88c3 = 0;
  level thread vo_wreck_cockpit();
  level thread vo_wreck_engine();
  level thread vo_wreck_misc3();
  level thread vo_wreck_misc4();
  level thread vo_wreck_misc5();
  level thread vo_wreck_misc6();
  level thread vo_wreck_tail();
  level thread function_a82119d616d087a7();
  level thread function_13ee2c4638944ea1();
  level thread function_493a50678d954a0f();
  level thread function_7261ea21b4dfb8e();
  level thread function_429367c89185c6c3();
  level thread function_2d165890c1714bd9();
  level thread vo_combat();
  level thread function_dc287a2e74c25f0a();
  level thread function_85fb5089307c2bef();
  level thread vo_ai_combatbegun();
  level thread vo_ai_call_for_fire_support();
  level thread function_9957d9e924ff4f5d();
  level thread vo_patrol_truck_sees_enemy();
}

function function_36318a2e1c3e9bdc() {
  level endon("phone_crate_hacked");
  flag_wait("flag_dungeon_intro_complete");
  var_4ba3ec1cab336c96 = function_69fa4a2561ada985("playerDefeatReason");
  aliases = [0.4, "dx_cp_rnch_vist_alex_laswellranatracertol", 0.3, "dx_cp_rnch_vist_fara_copyonthemove", 0.6, "dx_cp_rnch_vist_alex_iseeyougotyoursixill"];
  level.player say_sequence(aliases, 1, 6);
  flag_set("starting_vo_end");

  if(isDefined(var_4ba3ec1cab336c96)) {
    switch (var_4ba3ec1cab336c96) {
      case #"hash_92fe2edbe0c2bb97":
        level.player function_8f7dd478ffe07d07("dx_cp_rnch_vist_fara_copymovinginnow");
        break;
      case #"hash_f868b525aa8054f9":
        aliases = ["dx_cp_rnch_vist_alex_goteyesonmultiplejlt", "dx_cp_rnch_vist_alex_headsupforarmoredjlt"];
        said_line = level.player say(random(aliases), 1, 2);

        if(said_line) {
          level.player say("dx_cp_rnch_vist_fara_goodeyepushingup");
        }

        break;
      case #"hash_c5b31a5ef53745f":
        var_a739ab0e1d996cf3 = create_deck(["dx_cp_rnch_vist_alex_konnisgotanarmyheref", "dx_cp_rnch_vist_alex_weshouldtryandlaylow", "dx_cp_rnch_vist_alex_heavykonnipresenceco", "dx_cp_rnch_vist_alex_lottaenemyactivityou"], 1, 1);
        var_ec44c06676021f69 = create_deck(["dx_cp_rnch_vist_fara_theywontseemeunlessi", "dx_cp_rnch_vist_fara_iplanontakingasmanyd", "dx_cp_rnch_vist_fara_eitherwaywewontgodow", "dx_cp_rnch_vist_fara_theydeclaredwardoing"], 1, 1);
        said = level.player say_team(var_a739ab0e1d996cf3 deck_draw(), 1, 3);

        if(said) {
          level.player say_team(var_ec44c06676021f69 deck_draw(), 1, 3);
        }

        break;
    }
  } else {
    childthread function_80ece9efc607ac0c();
  }

  function_2311740fe797906a("playerDefeatReason", undefined);
}

function function_80ece9efc607ac0c() {
  level endon("obj_phones1_completed_vo");
  level endon("phone_crate_nearby");

  if(function_4bcd86b926d48155()) {
    return;
  }

  wait 3;
  aliases = [0.4, &function_ce7ae9bbd9964faf, "dx_cp_rnch_vist_fara_thesemenarenotwelcom", 0.3, &function_ce7ae9bbd9964faf, "dx_cp_rnch_vist_alex_letemknow", 0.6, &function_ce7ae9bbd9964faf, "dx_cp_rnch_vist_fara_iintendto"];
  level.player say_sequence(aliases, 0.4, 3);
  origin = (406, 1929, 12);
  dist = 3480;

  while(true) {
    if(distance2dsquared(level.player.origin, origin) < dist * dist) {
      break;
    }

    wait 0.2;
  }

  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_rnl1_fara_imthroughkonnisperim";
  aliases[aliases.size] = "dx_cp_rnch_rnl1_fara_headingfurtherintoth";
  aliases[aliases.size] = "dx_cp_rnch_rnl1_fara_immovingfurtherin";
  aliases[aliases.size] = "dx_cp_rnch_rnl1_fara_pressingup";
  aliases[aliases.size] = "dx_cp_rnch_rnl1_fara_pushingforward";
  aliases[aliases.size] = "dx_cp_rnch_rnl1_fara_advancingnow";
  aliases[aliases.size] = "dx_cp_rnch_rnl1_fara_movingahead";
  aliases[aliases.size] = "dx_cp_rnch_rnl1_fara_pushingout";
  var_32887cf9d13fe7e5 = create_deck(aliases, 1, 1);
  var_547f428d285b4438 = "dx_cp_rnch_rnl1_alex_iseeyoustillplentymo";
  aliases = [1, &function_ce7ae9bbd9964faf, var_32887cf9d13fe7e5 deck_draw(), 0.3, &function_ce7ae9bbd9964faf, "dx_cp_rnch_rnl1_alex_iseeyoustillplentymo"];
  level.player say_sequence(aliases, 0, 2);
}

function function_ce7ae9bbd9964faf() {
  if(function_1bb1470f934a81eb()) {
    return 0;
  }
}

function function_1111f0bd1213841b() {}

function function_9561eabafa550648() {
  var_5f9446889da88fc7 = getEnt("blackbox_room", "targetname");

  if(level.player istouching(var_5f9446889da88fc7)) {
    return 1;
  }

  return 0;
}

function function_d1099663764b5503() {
  if(!isDefined(level.player.var_bec156d5a2918db9)) {
    return 0;
  }

  return level.player.var_bec156d5a2918db9 == "building1" || level.player.var_bec156d5a2918db9 == "building2" || level.player.var_bec156d5a2918db9 == "building3" || level.player.var_bec156d5a2918db9 == "manor";
}

function function_fe2f63188287bd33() {
  if(!isDefined(level.player.var_bec156d5a2918db9)) {
    return 0;
  }

  return level.player.var_bec156d5a2918db9 == "building1";
}

function function_fe2f64188287bf66() {
  if(!isDefined(level.player.var_bec156d5a2918db9)) {
    return 0;
  }

  return level.player.var_bec156d5a2918db9 == "building2";
}

function function_fe2f65188287c199() {
  if(!isDefined(level.player.var_bec156d5a2918db9)) {
    return 0;
  }

  return level.player.var_bec156d5a2918db9 == "building3";
}

function function_11fa1824365f2e37() {
  if(flag("obj_search_completed")) {
    return;
  }

  level endon("obj_search_completed");
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_seeingmultiplehostil";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_thatsmallhouseaheadh";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_gotakonnipatrolneart";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_smallbrickhouseahead";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_enemiesaregroupedupo";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_seeingguardsatasmall";
  var_9a078606cc82bdc2 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_multiplehostilesnear";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_gotasmallhouseaheadt";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_konnipatrolnearthebr";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_smallbrickhouseahead_01";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_gotastructureseclude";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_gotasmallbrickhouseo";
  var_f4565945c5987f0f = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_poid_fara_headingtothebuilding";
  aliases[aliases.size] = "dx_cp_rnch_poid_fara_iseeatruckandajltvou";
  aliases[aliases.size] = "dx_cp_rnch_poid_fara_brickhouseaheadwitht";
  aliases[aliases.size] = "dx_cp_rnch_poid_fara_headingtothesmallbri";
  var_ac56441af2cf12d0 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_poid_fara_headingtothebuilding_01";
  aliases[aliases.size] = "dx_cp_rnch_poid_fara_iseevehiclesatasmall";
  aliases[aliases.size] = "dx_cp_rnch_poid_fara_brickhouseaheadkonni";
  aliases[aliases.size] = "dx_cp_rnch_poid_fara_headingtothesmallbri_01";
  var_f5f9180455de08d9 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_iseeit";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_eyeson";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_visual";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_copythat";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_gotit";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_tracking";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_havevisual";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_onit";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_wilco";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_gotyoursix";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_gotyourback";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_covering";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_dontgetseen";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_rolleasyunlessyouwan";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_keepittightkilo";
  var_5c41c5acdc2b88cd = create_deck(aliases, 1, 1);
}

function function_dd9645b711916a73() {
  level endon("obj_search_completed");
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_rp1a_fara_nothingusefulhere";
  aliases[aliases.size] = "dx_cp_rnch_rp1a_fara_nothingusefulhere";
  aliases[aliases.size] = "dx_cp_rnch_rp1a_fara_nothingusefulhere";
  aliases[aliases.size] = "dx_cp_rnch_rp1a_fara_nothingusefulhere";
  aliases[aliases.size] = "dx_cp_rnch_rp1a_fara_nothingusefulhere";
  aliases[aliases.size] = "dx_cp_rnch_rp1a_fara_nothingusefulhere";
  aliases[aliases.size] = "dx_cp_rnch_rp1a_fara_nothingusefulhere";
  var_ac56441af2cf12d0 = create_deck(aliases, 1, 1);
  var_f5f9180455de08d9 = create_deck(["dx_cp_rnch_rp1a_fara_placeispickedapart", "dx_cp_rnch_rp1a_fara_buildingsempty", "dx_cp_rnch_rp1a_fara_nothinghere"]);
  var_5c41c5acdc2b88cd = create_deck(["dx_cp_rnch_rp1a_alex_ifkonnifoundanything", "dx_cp_rnch_rp1a_alex_whateverkonnifoundth", "dx_cp_rnch_rp1a_alex_konnimustvetakenanyt"]);
  level waittill("player_enter_building1");
  wait 3;

  if(level.player.var_bec156d5a2918db9 == "building1") {
    said = level.player function_c02941e07491127e(var_ac56441af2cf12d0 deck_draw(), var_f5f9180455de08d9 deck_draw(), 0, 2, 0, 0.5);
    wait 1.5;

    if(istrue(said)) {
      level.player function_c02941e07491127e(var_5c41c5acdc2b88cd deck_draw(), undefined, 0, 2, 0, 0.5);
    }
  }
}

function function_757f5137a032293c() {
  if(flag("obj_search_completed")) {
    return;
  }

  level endon("obj_search_completed");
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_theresabrokenturbine";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_smallbrickbuildingha";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_ajltvisparkednearsom";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_goteyesonasmallbuild";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_worklightsarefloodin";
  var_9a078606cc82bdc2 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_kilodownedenginebyat";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_watchforthebrickbuil";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_twostorybuildinggota";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_goteyesonasmallbuild_01";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_gotworklightsarounda";
  var_f4565945c5987f0f = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_poid_fara_approachingatwostory";
  aliases[aliases.size] = "dx_cp_rnch_poid_fara_gotsomeenginewreckag";
  aliases[aliases.size] = "dx_cp_rnch_poid_fara_brickbuildinghasanop";
  aliases[aliases.size] = "dx_cp_rnch_poid_fara_approachingajltvpark";
  aliases[aliases.size] = "dx_cp_rnch_poid_fara_approachingasmallbui";
  aliases[aliases.size] = "dx_cp_rnch_poid_fara_approachingthesideof";
  var_ac56441af2cf12d0 = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_rnch_poid_fara_approachingatwostory_01", "dx_cp_rnch_poid_fara_gotsenginewreckageon", "dx_cp_rnch_poid_fara_brickbuildinghasanop_01"];
  var_f5f9180455de08d9 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_iseeit";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_eyeson";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_visual";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_copythat";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_gotit";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_tracking";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_havevisual";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_onit";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_wilco";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_gotyoursix";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_gotyourback";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_covering";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_dontgetseen";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_rolleasyunlessyouwan";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_keepittightkilo";
  var_5c41c5acdc2b88cd = create_deck(aliases, 1, 1);
}

function function_b27598ebbbfaa3b6() {
  level endon("obj_search_completed");
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_rp2a_alex_theymayhaveclearedit";
  aliases[aliases.size] = "dx_cp_rnch_rp2a_alex_theymayhaveclearedit";
  aliases[aliases.size] = "dx_cp_rnch_rp2a_alex_theymayhaveclearedit";
  aliases[aliases.size] = "dx_cp_rnch_rp2a_alex_theymayhaveclearedit";
  aliases[aliases.size] = "dx_cp_rnch_rp2a_alex_theymayhaveclearedit";
  var_9a078606cc82bdc2 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_b2pc_fara_seeingnothinghere";
  aliases[aliases.size] = "dx_cp_rnch_b2pc_fara_gotnothingherealex";
  aliases[aliases.size] = "dx_cp_rnch_b2pc_fara_buildingsgotnothing";
  aliases[aliases.size] = "dx_cp_rnch_b2pc_fara_dryholeecho";
  aliases[aliases.size] = "dx_cp_rnch_b2pc_fara_nojoy31nothinginside";
  aliases[aliases.size] = "dx_cp_rnch_b2pc_fara_nothinghereecho";
  aliases[aliases.size] = "dx_cp_rnch_b2nc_fara_nothingheretryingels";
  aliases[aliases.size] = "dx_cp_rnch_b2nc_fara_nothingheremovingon";
  aliases[aliases.size] = "dx_cp_rnch_b2nc_fara_konnisalreadybeenher";
  var_f5f9180455de08d9 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_rp2a_fara_illmoveon";
  aliases[aliases.size] = "dx_cp_rnch_rp2a_fara_copythatmovingon";
  aliases[aliases.size] = "dx_cp_rnch_rp2a_fara_illtrysomewhereelse";
  aliases[aliases.size] = "dx_cp_rnch_rp2a_fara_copymoving";
  var_f7c9f25a298e6ab = create_deck(aliases, 1, 1);
  var_5c41c5acdc2b88cd = create_deck(["dx_cp_rnch_rp1a_alex_ifkonnifoundanything", "dx_cp_rnch_rp1a_alex_whateverkonnifoundth", "dx_cp_rnch_rp1a_alex_konnimustvetakenanyt"]);
  level waittill("player_enter_building2");
  wait 3;

  if(level.player.var_bec156d5a2918db9 == "building2") {
    said = level.player function_c02941e07491127e(var_9a078606cc82bdc2 deck_draw(), var_f5f9180455de08d9 deck_draw(), 0, 2, 0, 0.5);
    wait 1.5;

    if(istrue(said)) {
      level.player function_c02941e07491127e(var_f7c9f25a298e6ab deck_draw(), undefined, 0, 2, 0, 0.5);
    }
  }
}

function function_ebdcc0fd0c505485() {
  if(flag("obj_search_completed")) {
    return;
  }

  level endon("obj_search_completed");
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_mustbethemainranchho";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_checkoutthebuildingw";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_seealargeranchhousef";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_thebuildingclosestto";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_thatbuildingsclosest";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_gotheavyactivitynear";
  var_9a078606cc82bdc2 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_mainranchhouseaheadl";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_checkthebuildingwith";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_gotalargeranchhousef";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_buildingclosesttothe";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_thatbuildingsnearthe";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_gotheavyactivitynear_01";
  var_f4565945c5987f0f = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_poid_fara_headingintotheranchh";
  aliases[aliases.size] = "dx_cp_rnch_poid_fara_farmersmustvelivedhe";
  aliases[aliases.size] = "dx_cp_rnch_poid_fara_nearwhatlookslikeara";
  aliases[aliases.size] = "dx_cp_rnch_poid_fara_thisbuildingsclosest";
  aliases[aliases.size] = "dx_cp_rnch_poid_fara_approachingahousenea";
  aliases[aliases.size] = "dx_cp_rnch_poid_fara_ranchhouseaheadishea";
  var_ac56441af2cf12d0 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_poid_fara_headingintotheranchh_01";
  aliases[aliases.size] = "dx_cp_rnch_poid_fara_farmersmustvelivedhe_01";
  aliases[aliases.size] = "dx_cp_rnch_poid_fara_neartheranchhousekon";
  aliases[aliases.size] = "dx_cp_rnch_poid_fara_thisbuildingsclosest_01";
  aliases[aliases.size] = "dx_cp_rnch_poid_fara_approachingaranchhou";
  aliases[aliases.size] = "dx_cp_rnch_poid_fara_ranchhouseaheadwellg";
  var_f5f9180455de08d9 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_iseeit";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_eyeson";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_visual";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_copythat";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_gotit";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_tracking";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_havevisual";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_onit";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_wilco";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_gotyoursix";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_gotyourback";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_covering";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_dontgetseen";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_rolleasyunlessyouwan";
  aliases[aliases.size] = "dx_cp_rnch_poid_alex_keepittightkilo";
  var_5c41c5acdc2b88cd = create_deck(aliases, 1, 1);
}

function function_a3b78aa482a0cd19() {
  if(function_4bcd86b926d48155()) {
    flag_set("vo_manor_box_hint_said");
    return;
  }

  level endon("obj_search_completed");
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_b2pc_fara_seeingnothinghere";
  aliases[aliases.size] = "dx_cp_rnch_b2pc_fara_gotnothingherealex";
  aliases[aliases.size] = "dx_cp_rnch_b2pc_fara_buildingsgotnothing";
  aliases[aliases.size] = "dx_cp_rnch_b2pc_fara_dryholeecho";
  aliases[aliases.size] = "dx_cp_rnch_b2pc_fara_nojoy31nothinginside";
  aliases[aliases.size] = "dx_cp_rnch_b2pc_fara_nothinghereecho";
  aliases[aliases.size] = "dx_cp_rnch_b2nc_fara_nothingheretryingels";
  aliases[aliases.size] = "dx_cp_rnch_b2nc_fara_nothingheremovingon";
  aliases[aliases.size] = "dx_cp_rnch_b2nc_fara_konnisalreadybeenher";
  var_f5f9180455de08d9 = create_deck(aliases, 1, 1);
  var_4d7beb17ae3e3137 = create_deck(["dx_cp_rnch_rp3a_fara_illtakealook", "dx_cp_rnch_rp3a_fara_copyillcheckit", "dx_cp_rnch_rp3a_fara_illlook"]);
  var_d3c0b258a6361308 = create_deck(["dx_cp_rnch_rb3a_fara_searching", "dx_cp_rnch_rb3a_fara_copyilllookaround", "dx_cp_rnch_rb3a_fara_copyillsearchit"]);
  var_2b9189e97100804 = create_deck(["dx_cp_rnch_rdca_fara_onit", "dx_cp_rnch_rdca_fara_agreed", "dx_cp_rnch_rdca_fara_rogerthatecho"]);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_b3pc_alex_theresalotofdebrison";
  aliases[aliases.size] = "dx_cp_rnch_b3pc_alex_gotalotofdebrisonthe";
  aliases[aliases.size] = "dx_cp_rnch_b3pc_alex_plentyofcrashdebrisn";
  aliases[aliases.size] = "dx_cp_rnch_b3pc_alex_gotasignalcomingofft";
  aliases[aliases.size] = "dx_cp_rnch_b3pc_alex_gotasignaloffthetrac";
  aliases[aliases.size] = "dx_cp_rnch_b3pc_alex_tracersignalsaysther";
  var_31fb2d0e55f0f9ac = create_deck(aliases, 1, 1);

  while(true) {
    level waittill("player_enter_manor");

    if(flag("obj_phones_completed") && !flag("vo_manor_box_hint_said")) {
      aliases = [];
      aliases[aliases.size] = "dx_cp_rnch_rb3a_alex_lookslikeastagingare";
      aliases[aliases.size] = "dx_cp_rnch_rb3a_alex_thatbuildingwasheavi";
      aliases[aliases.size] = "dx_cp_rnch_rb3a_alex_seriousfirepoweranda";
      var_9a4d5333fb4683bc = aliases;
      aliases = [];
      aliases[aliases.size] = "dx_cp_rnch_rb3a_alex_lotofkonniaroundthat";
      aliases[aliases.size] = "dx_cp_rnch_rb3a_alex_signalsaysyourcloset";
      var_6f672130daaa122a = aliases;

      if(getaiarrayinradius(level.player.origin, 300, "axis").size > 0) {
        var_9a4d5333fb4683bc = array_merge(var_9a4d5333fb4683bc, var_6f672130daaa122a);
      }

      var_cb779aabadc582d9 = create_deck(var_9a4d5333fb4683bc, 1, 1);
      var_9a078606cc82bdc2 = var_cb779aabadc582d9 deck_draw();
      var_f4565945c5987f0f = "dx_cp_rnch_rdca_alex_theyreguardingthatbu";
      said = level.player function_c02941e07491127e(var_9a078606cc82bdc2, var_f4565945c5987f0f, 0.5, 2, 0, 0.5);
      wait 1;

      if(istrue(said)) {
        level.player function_c02941e07491127e(var_d3c0b258a6361308 deck_draw(), var_2b9189e97100804 deck_draw(), 0.5, 2, 0, 0.5);
        flag_set("vo_manor_box_hint_said");
      }

      continue;
    }

    if(!flag("obj_phones_completed")) {
      wait 3;

      if(level.player.var_bec156d5a2918db9 == "manor" && !flag("vo_manor_phone_hint_said")) {
        var_4824dfb8bedb8de5 = "dx_cp_rnch_rp3a_alex_gotkonniactivitynear";
        said = level.player function_c02941e07491127e(var_4824dfb8bedb8de5, var_31fb2d0e55f0f9ac deck_draw(), 0.5, 2, 0, 0.5);

        if(istrue(said)) {
          level.player function_c02941e07491127e(var_4d7beb17ae3e3137 deck_draw(), var_2b9189e97100804 deck_draw(), 0.5, 2, 0, 0.7);
          flag_set("vo_manor_phone_hint_said");
        }
      }
    }
  }
}

function function_285573daf178e366() {
  level endon("game_ended");
  level endon("start_escape_flow");
  level.player endon("death");
  var_2b804dae8f79c417 = 0;
  var_e7177db08210f80b = 0;

  while(true) {
    waitframe();

    if(level.player.var_bec156d5a2918db9 != "building1") {
      level.var_671d8e9990ee8440 = undefined;
      continue;
    }

    if(is_in_combat()) {
      level.var_671d8e9990ee8440 = undefined;
      continue;
    }

    if(!isDefined(level.var_671d8e9990ee8440)) {
      level.var_671d8e9990ee8440 = gettime();
    }

    if(level.var_d0d5526a0a139791.size > 0 && gettime() - level.var_d0d5526a0a139791[level.var_d0d5526a0a139791.size - 1] < 60000) {
      level.var_671d8e9990ee8440 = undefined;
      continue;
    }

    if(!isDefined(level.var_671d8e9990ee8440) || gettime() - level.var_671d8e9990ee8440 < 60000) {
      continue;
    }

    if(function_6c31b0b0edd184ed([level.player])) {
      continue;
    }

    if(!flag("obj_phones_completed")) {
      if(function_cbc288fb616c8c34("building1")) {
        level.player say("dx_cp_rnch_rp1a_fara_nothingusefulhere", 0.5, 0);

        if(!var_2b804dae8f79c417 && !function_155f16ed1b7f00cd()) {
          var_2b804dae8f79c417 = 1;
          level.player say("dx_cp_rnch_rp1a_alex_ifkonnifoundanything", 0, 0);
        }
      } else {
        level.player say("dx_cp_rnch_rx1a_alex_tracersgotnosignalsi", 0.5, 0);

        if(!var_e7177db08210f80b && !function_155f16ed1b7f00cd()) {
          var_e7177db08210f80b = 1;
          level.player say("dx_cp_rnch_rx1a_fara_copyilltryanotherare", 0, 0);
        }
      }
    } else if(!flag("obj_search_completed")) {
      level.player say("dx_cp_rnch_rb1a_alex_doesntappeartheyresa", 0.5, 0);
    }

    level.var_671d8e9990ee8440 = undefined;

    while(level.player.var_bec156d5a2918db9 == "building1" || !is_in_combat()) {
      waitframe();
    }
  }
}

function function_215d63eb1ee370c9() {
  level endon("game_ended");
  level endon("start_escape_flow");
  level.player endon("death");
  var_2b804dae8f79c417 = 0;
  var_e7177db08210f80b = 0;

  while(true) {
    waitframe();

    if(level.player.var_bec156d5a2918db9 != "building2") {
      level.var_e922ecb549020f15 = undefined;
      continue;
    }

    if(is_in_combat()) {
      level.var_e922ecb549020f15 = undefined;
      continue;
    }

    if(!isDefined(level.var_e922ecb549020f15)) {
      level.var_e922ecb549020f15 = gettime();
    }

    if(level.var_d0d5526a0a139791.size > 0 && gettime() - level.var_d0d5526a0a139791[level.var_d0d5526a0a139791.size - 1] < 60000) {
      level.var_e922ecb549020f15 = undefined;
      continue;
    }

    if((!isDefined(level.var_e922ecb549020f15) || gettime() - level.var_e922ecb549020f15) < 60000) {
      continue;
    }

    if(function_6c31b0b0edd184ed([level.player])) {
      continue;
    }

    if(!flag("obj_phones_completed")) {
      if(function_cbc288fb616c8c34("building2")) {
        level.player say("dx_cp_rnch_rp2a_alex_theymayhaveclearedit", 0.5, 0);

        if(!var_2b804dae8f79c417 && !function_155f16ed1b7f00cd()) {
          var_2b804dae8f79c417 = 1;
          level.player say("dx_cp_rnch_rni2_fara_iseemeninhoodiesspea", 0, 0);
        }
      } else if(!var_e7177db08210f80b && !function_155f16ed1b7f00cd()) {
        var_e7177db08210f80b = 1;
      }
    } else if(!flag("obj_search_completed")) {
      level.player say("dx_cp_rnch_rb2a_alex_flightrecorderwasthe", 0.5, 0);
    }

    level.var_e922ecb549020f15 = undefined;

    while(level.player.var_bec156d5a2918db9 == "building2" || !is_in_combat()) {
      waitframe();
    }
  }
}

function function_5b64fc0bb16498ac() {
  level endon("game_ended");
  level endon("start_escape_flow");
  level.player endon("death");
  var_2b804dae8f79c417 = 0;
  var_e7177db08210f80b = 0;
  var_75a010861d9dcf75 = 0;

  while(true) {
    waitframe();

    if(level.player.var_bec156d5a2918db9 != "manor") {
      level.var_7b6bcd017801922a = undefined;
      continue;
    }

    if(is_in_combat()) {
      level.var_7b6bcd017801922a = undefined;
      continue;
    }

    if(!isDefined(level.var_7b6bcd017801922a)) {
      level.var_7b6bcd017801922a = gettime();
    }

    if(isDefined(level.var_d0d5526a0a139791) && level.var_d0d5526a0a139791.size > 0 && gettime() - level.var_d0d5526a0a139791[level.var_d0d5526a0a139791.size - 1] < 60000) {
      level.var_7b6bcd017801922a = undefined;
      continue;
    }

    if(!isDefined(level.var_7b6bcd017801922a) || gettime() - level.var_7b6bcd017801922a < 60000) {
      continue;
    }

    if(function_6c31b0b0edd184ed([level.player])) {
      continue;
    }

    if(!flag("obj_phones_completed")) {
      if(function_cbc288fb616c8c34("manor")) {
        level.player say("dx_cp_rnch_rp3a_alex_gotkonniactivitynear", 0.5, 0);

        if(!var_2b804dae8f79c417 && !function_155f16ed1b7f00cd()) {
          var_2b804dae8f79c417 = 1;
          level.player say("dx_cp_rnch_rp3a_fara_illtakealook", 0, 0);
        }
      } else {
        level.player say("dx_cp_rnch_rx3a_alex_howsitlooking", 0.5, 0);

        if(!var_e7177db08210f80b && !function_155f16ed1b7f00cd()) {
          var_e7177db08210f80b = 1;
          level.player say("dx_cp_rnch_rx3a_fara_buildingsclean", 0, 0);
        }
      }
    } else if(!flag("obj_search_completed")) {
      level.player say("dx_cp_rnch_rb3a_alex_seriousfirepoweranda", 1, 0);

      if(!var_75a010861d9dcf75 && !function_155f16ed1b7f00cd()) {
        var_75a010861d9dcf75 = 1;
        level.player say("dx_cp_rnch_rb3a_fara_searching", 0, 0);
      }
    }

    level.var_7b6bcd017801922a = undefined;

    while(level.player.var_bec156d5a2918db9 == "manor" || !is_in_combat()) {
      waitframe();
    }
  }
}

function function_ca578b8a333224b2() {
  level endon("game_ended");
  level endon("start_escape_flow");
  level.player endon("death");
  vo_played = 0;
  var_2e0fb9945519ab38 = ["dx_cp_rnch_rnl1_fara_imthroughkonnisperim", "dx_cp_rnch_rnl1_alex_iseeyoustillplentymo"];

  while(!isDefined(level.player.var_bec156d5a2918db9)) {
    waitframe();
  }

  while(level.player.var_bec156d5a2918db9 != "building1") {
    waitframe();
  }

  while(!vo_played) {
    waitframe();

    while(level.player.var_bec156d5a2918db9 == "building1") {
      waitframe();
    }

    wait randomfloatrange(3, 5);

    if(level.player.var_bec156d5a2918db9 != "building1") {
      vo_played = level.player function_86ee87fa1ec56de9(var_2e0fb9945519ab38, undefined, "start_escape_flow", "dx_cp_rnch_rnk1_alex_morekonnicomingyourw", &is_in_combat);
    }
  }
}

function function_9b08b4ebd51bd18f() {
  level endon("game_ended");
  level endon("start_escape_flow");
  level.player endon("death");
  vo_played = 0;
  var_ad451464907eb97f = ["dx_cp_rnch_rnk2_alex_farahmoreenemypatrol"];

  while(!isDefined(level.player.var_bec156d5a2918db9)) {
    waitframe();
  }

  while(level.player.var_bec156d5a2918db9 != "building2") {
    waitframe();
  }

  while(!vo_played) {
    waitframe();

    while(level.player.var_bec156d5a2918db9 == "building2") {
      waitframe();
    }

    wait randomfloatrange(3, 5);

    if(level.player.var_bec156d5a2918db9 != "building2") {
      vo_played = level.player function_86ee87fa1ec56de9("dx_cp_rnch_rnl2_alex_advisecautionwhencir", undefined, "start_escape_flow", var_ad451464907eb97f, &is_in_combat);
    }
  }
}

function function_429272af11ed4dec() {
  level endon("game_ended");
  level endon("start_escape_flow");
  level.player endon("death");
  vo_played = 0;

  while(!isDefined(level.player.var_bec156d5a2918db9)) {
    waitframe();
  }

  while(level.player.var_bec156d5a2918db9 != "building3") {
    waitframe();
  }

  while(!vo_played) {
    waitframe();

    while(level.player.var_bec156d5a2918db9 == "building3") {
      waitframe();
    }

    wait randomfloatrange(3, 5);

    if(level.player.var_bec156d5a2918db9 != "building3") {
      var_2e0fb9945519ab38 = undefined;
      var_ad451464907eb97f = undefined;

      if(flag("obj_phones_completed")) {
        var_2e0fb9945519ab38 = ["dx_cp_rnch_rdba_alex_recommendyousearchth"];
        var_ad451464907eb97f = ["dx_cp_rnch_rdca_alex_theyreguardingthatbu", "dx_cp_rnch_rdca_fara_onit"];
      }
    }
  }
}

function function_9d0e41419bcd28f5() {
  if(function_4bcd86b926d48155()) {
    flag_set("obj_search_completed_vo");
    return;
  }

  alternates = ["dx_cp_rnch_rnbi_fara_foundtheflightrecord", "dx_cp_rnch_rnbi_fara_ihavetheflightrecord"];
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_rner_fara_foundtheflightrecord";
  aliases[aliases.size] = "dx_cp_rnch_rner_fara_ivelocatedtheflightr";
  aliases[aliases.size] = "dx_cp_rnch_rner_fara_imattheflightrecorde";
  aliases[aliases.size] = "dx_cp_rnch_rner_fara_blackboxlocated";
  aliases[aliases.size] = "dx_cp_rnch_rner_fara_eyesontheblackbox";
  aliases[aliases.size] = "dx_cp_rnch_rner_fara_echogottheblackbox";
  var_98f162f32a37a5ff = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_rnec_fara_foundtheflightrecord";
  aliases[aliases.size] = "dx_cp_rnch_rnec_fara_alexivegoteyesonthef";
  aliases[aliases.size] = "dx_cp_rnch_rnec_fara_imattheflightrecorde";
  aliases[aliases.size] = "dx_cp_rnch_rnec_fara_blackboxlocated";
  aliases[aliases.size] = "dx_cp_rnch_rnec_fara_eyesontheblackbox31";
  aliases[aliases.size] = "dx_cp_rnch_rnec_fara_echogottheblackbox";
  var_1aa00f0361ae7790 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_rnbi_fara_foundtheflightrecord";
  aliases[aliases.size] = "dx_cp_rnch_rnbi_fara_ihavetheflightrecord";
  aliases[aliases.size] = "dx_cp_rnch_rnbi_fara_flightrecordersecure";
  aliases[aliases.size] = "dx_cp_rnch_rnbi_fara_blackboxsecurecoverm";
  aliases[aliases.size] = "dx_cp_rnch_rnbi_fara_flightrecordersecure_01";
  aliases[aliases.size] = "dx_cp_rnch_rnbi_fara_blackboxsecurecoverm_01";
  var_6b7349279cf226d8 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_bbic_fara_foundtheflightrecord";
  aliases[aliases.size] = "dx_cp_rnch_bbic_fara_flightrecordersecure";
  aliases[aliases.size] = "dx_cp_rnch_bbic_fara_imfryingtheflightrec";
  aliases[aliases.size] = "dx_cp_rnch_bbic_fara_flightrecordersecure_01";
  aliases[aliases.size] = "dx_cp_rnch_bbic_fara_blackboxsecurecoverm";
  aliases[aliases.size] = "dx_cp_rnch_bbic_fara_flightrecordersecure_02";
  aliases[aliases.size] = "dx_cp_rnch_bbic_fara_blackboxsecurecoverm_01";
  var_bdf2f9843ed98c61 = create_deck(aliases, 1, 1);
  var_5f9446889da88fc7 = getEnt("blackbox_room", "targetname");

  if(!isDefined(var_5f9446889da88fc7)) {
    return;
  }

  while(!level.player istouching(var_5f9446889da88fc7)) {
    waitframe();
  }

  if(function_1bb1470f934a81eb()) {
    level.player thread function_fc0eb6b81c66c661(0.6, var_1aa00f0361ae7790 deck_draw(), 1, 2);
  } else {
    level.player thread function_fc0eb6b81c66c661(0.6, var_98f162f32a37a5ff deck_draw(), 1, 2);
  }

  function_62e62f03cbec7018(var_6b7349279cf226d8, var_bdf2f9843ed98c61);
  flag_set("obj_search_completed_vo");
}

function function_62e62f03cbec7018(var_6b7349279cf226d8, var_bdf2f9843ed98c61) {
  level endon("obj_escape_completed");

  while(true) {
    level.player waittill("interact_started");

    if(distance2d(level.player.origin, level.blackbox.origin) < 90) {
      break;
    }
  }

  if(function_1bb1470f934a81eb()) {
    level.player say_team(var_bdf2f9843ed98c61 deck_draw(), 1, 3);
    level.player function_fc0eb6b81c66c661(0.4, "dx_cp_rnch_bbic_alex_yousurefarah", 1, 3);
    level.player function_fc0eb6b81c66c661(0.6, "dx_cp_rnch_bbic_fara_affirmyouwithme", 1, 3);
    var_a739ab0e1d996cf3 = create_deck(["dx_cp_rnch_bbic_alex_alwayskilofryit", "dx_cp_rnch_bbic_alex_thisiswarkilodoit", "dx_cp_rnch_bbic_alex_didntcomethisfartofo"]);
    level.player function_fc0eb6b81c66c661(0.4, var_a739ab0e1d996cf3 deck_draw(), 1, 3);
    return;
  }

  level.player say_team(var_6b7349279cf226d8 deck_draw(), 1, 3);
  var_a739ab0e1d996cf3 = create_deck(["dx_cp_rnch_rnbi_alex_affirmativefryitkilo", "dx_cp_rnch_rnbi_alex_thisiswarkilogottafi", "dx_cp_rnch_rnbi_alex_affirmdidntcomethisf"]);
  level.player function_fc0eb6b81c66c661(0.3, var_a739ab0e1d996cf3 deck_draw(), 1, 3);
}

function function_2f6e24618fb44893() {
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_rnk3_alex_lottakonniheadingyou";
  aliases[aliases.size] = "dx_cp_rnch_rnk3_alex_kiloyougotkonniswarm";
  aliases[aliases.size] = "dx_cp_rnch_rnk3_alex_morekonnisoldiersadv";
  aliases[aliases.size] = "dx_cp_rnch_rnk3_alex_konnisalloveryouillg";
  var_66c5a5d2ead05c5e = create_deck(aliases, 1, 1);
  level.player function_fc0eb6b81c66c661(0.8, var_66c5a5d2ead05c5e deck_draw(), 1, 2);
  level.player function_fc0eb6b81c66c661(0.6, "dx_cp_rnch_rnk3_fara_pleasedo", 0.5, 1);
}

function vo_wreck_cockpit() {
  level endon("game_ended");
  level endon("obj_search_completed");
  var_d7072067e4495ae8 = function_1c4d592029f2b0d3("vo_wreck_cockpit");
  level.var_b289530118a15c75 = 0;

  while(!level.var_b289530118a15c75) {
    wait 1;

    if(level.player istouching(var_d7072067e4495ae8)) {
      if(function_6c31b0b0edd184ed([level.player])) {
        continue;
      }

      if(function_155f16ed1b7f00cd(undefined, 4)) {
        if(!level.var_c3198933a25f88c3) {
          level.var_c3198933a25f88c3 = 1;
        }

        while(is_in_combat()) {
          wait 5;
        }

        continue;
      }

      if(!var_d7072067e4495ae8 function_bfdf6860886a11a5("wreckcockpit")) {
        continue;
      }

      level.var_b289530118a15c75 = 1;
    }
  }
}

function vo_wreck_engine() {
  level endon("game_ended");
  level endon("obj_escape_start");
  var_d7072067e4495ae8 = function_1c4d592029f2b0d3("vo_wreck_engine");
  level.var_815e376a335ac70 = 0;

  while(!level.var_815e376a335ac70) {
    wait 1;

    if(level.player istouching(var_d7072067e4495ae8)) {
      if(function_6c31b0b0edd184ed([level.player])) {
        continue;
      }

      if(function_155f16ed1b7f00cd(undefined, 4)) {
        if(!level.var_c3198933a25f88c3) {
          level.var_c3198933a25f88c3 = 1;
        }

        while(is_in_combat()) {
          wait 5;
        }

        continue;
      }

      if(!var_d7072067e4495ae8 function_bfdf6860886a11a5("wreckengine")) {
        continue;
      }

      level.var_815e376a335ac70 = 1;
    }
  }
}

function vo_wreck_misc3() {
  level endon("game_ended");
  level endon("obj_escape_start");
  var_d7072067e4495ae8 = function_1c4d592029f2b0d3("vo_wreck_misc3");
  level.var_27ca858c090341b1 = 0;

  while(!level.var_27ca858c090341b1) {
    wait 1;

    if(level.player istouching(var_d7072067e4495ae8)) {
      if(function_6c31b0b0edd184ed([level.player])) {
        continue;
      }

      if(function_155f16ed1b7f00cd(undefined, 4)) {
        if(!level.var_c3198933a25f88c3) {
          level.var_c3198933a25f88c3 = 1;
        }

        while(is_in_combat()) {
          wait 5;
        }

        continue;
      }

      if(!var_d7072067e4495ae8 function_bfdf6860886a11a5("wreck3")) {
        continue;
      }

      level.var_27ca858c090341b1 = 1;
      level.player say("dx_guidffff5b953340445695c2953a7114ba64", 0.5, 5);
    }
  }
}

function vo_wreck_misc4() {
  level endon("game_ended");
  level endon("obj_escape_start");
  var_d7072067e4495ae8 = function_1c4d592029f2b0d3("vo_wreck_misc4");
  level.var_11a457ff90a76a1a = 0;

  while(!level.var_11a457ff90a76a1a) {
    wait 1;

    if(level.player istouching(var_d7072067e4495ae8)) {
      if(function_6c31b0b0edd184ed([level.player])) {
        continue;
      }

      if(function_155f16ed1b7f00cd(undefined, 4)) {
        if(!level.var_c3198933a25f88c3) {
          level.var_c3198933a25f88c3 = 1;
        }

        while(is_in_combat()) {
          wait 5;
        }

        continue;
      }

      if(!var_d7072067e4495ae8 function_bfdf6860886a11a5("wreck4")) {
        continue;
      }

      level.var_11a457ff90a76a1a = 1;
    }
  }
}

function vo_wreck_misc5() {
  level endon("game_ended");
  level endon("obj_escape_start");
  var_d7072067e4495ae8 = function_1c4d592029f2b0d3("vo_wreck_misc5");
  level.var_10dfe16f2ef02aff = 0;

  while(!level.var_10dfe16f2ef02aff) {
    wait 1;

    if(level.player istouching(var_d7072067e4495ae8)) {
      if(function_6c31b0b0edd184ed([level.player])) {
        continue;
      }

      if(function_155f16ed1b7f00cd(undefined, 4)) {
        if(!level.var_c3198933a25f88c3) {
          level.var_c3198933a25f88c3 = 1;
        }

        while(is_in_combat()) {
          wait 5;
        }

        continue;
      }

      if(!var_d7072067e4495ae8 function_bfdf6860886a11a5("wreck5")) {
        continue;
      }

      level.var_10dfe16f2ef02aff = 1;
    }
  }
}

function vo_wreck_misc6() {
  level endon("game_ended");
  level endon("obj_escape_start");
  var_d7072067e4495ae8 = function_1c4d592029f2b0d3("vo_wreck_misc6");
  level.var_a21411e9784976f8 = 0;

  while(!level.var_a21411e9784976f8) {
    wait 1;

    if(level.player istouching(var_d7072067e4495ae8)) {
      if(function_6c31b0b0edd184ed([level.player])) {
        continue;
      }

      if(function_155f16ed1b7f00cd(undefined, 4)) {
        if(!level.var_c3198933a25f88c3) {
          level.var_c3198933a25f88c3 = 1;
        }

        while(is_in_combat()) {
          wait 5;
        }

        continue;
      }

      if(!var_d7072067e4495ae8 function_bfdf6860886a11a5("wreck6")) {
        continue;
      }

      level.var_a21411e9784976f8 = 1;
    }
  }
}

function vo_wreck_tail() {
  level endon("game_ended");
  level endon("obj_escape_start");
  var_d7072067e4495ae8 = function_1c4d592029f2b0d3("vo_wreck_tail");

  while(true) {
    if(level.player istouching(var_d7072067e4495ae8)) {
      if(function_155f16ed1b7f00cd()) {
        wait 5;
      } else {
        break;
      }
    }

    waitframe();
  }
}

function function_bfdf6860886a11a5(var_316960aad4b146c6) {
  if(!isDefined(level.var_c46b5c83b58aefb4)) {
    return true;
  }

  if(flag("obj_phones_completed")) {
    return true;
  }

  self.var_61963259a4a1434b = [];

  foreach(crate in level.var_c46b5c83b58aefb4) {
    if(isDefined(var_316960aad4b146c6)) {
      if(isDefined(crate.var_55cc71192b8f1931) && array_contains(crate.var_55cc71192b8f1931, var_316960aad4b146c6)) {
        if(!istrue(crate.var_1ab92c9426b975ca)) {
          return false;
        }
      }

      continue;
    }

    if(distance(self.origin, crate.origin) <= self.struct.radius) {
      if(!istrue(crate.var_1ab92c9426b975ca)) {
        return false;
      }
    }
  }

  return true;
}

function function_14b22466db147a4b(waittime, var_316960aad4b146c6) {
  level endon("game_ended");
  level endon("obj_escape_start");
  level endon("obj_phones_completed_vo");

  while(!isDefined(level.var_c46b5c83b58aefb4)) {
    waitframe();
  }

  self.var_61963259a4a1434b = [];

  foreach(crate in level.var_c46b5c83b58aefb4) {
    if(isDefined(var_316960aad4b146c6)) {
      if(isDefined(crate.var_55cc71192b8f1931) && array_contains(crate.var_55cc71192b8f1931, var_316960aad4b146c6)) {
        self.var_61963259a4a1434b = array_add(self.var_61963259a4a1434b, crate);
      }

      continue;
    }

    if(distance(self.origin, crate.origin) <= self.struct.radius) {
      self.var_61963259a4a1434b = array_add(self.var_61963259a4a1434b, crate);
    }
  }

  if(self.var_61963259a4a1434b.size > 0) {
    while(true) {
      var_697f1abee2b52475 = 1;

      foreach(var_8e2f0e46d8edfa2f in self.var_61963259a4a1434b) {
        if(!istrue(var_8e2f0e46d8edfa2f.var_1ab92c9426b975ca)) {
          var_697f1abee2b52475 = 0;
          break;
        }
      }

      if(var_697f1abee2b52475) {
        break;
      }

      wait 1;
    }
  }

  if(isDefined(waittime)) {
    wait waittime;
  }
}

function function_4ba8a7b003d2a3d8() {
  level endon("obj_search_completed");
  level.player endon("death");
  level.player endon("disconnect");
  aliases = ["dx_cp_rnch_bfnd_alex_gotsomething", 0.2, "dx_cp_rnch_bfnd_fara_konniequipmentcratet", 0.2, "dx_cp_rnch_bfnd_alex_welltheyfoundit"];
  var_3cacaa7e3e6ddc28 = aliases;
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_bfnd_fara_foundoneofkonnissupp";
  aliases[aliases.size] = "dx_cp_rnch_bfnd_fara_gotoneofkonnisstashe";
  aliases[aliases.size] = "dx_cp_rnch_bfnd_fara_konnisuppliescrackin";
  aliases[aliases.size] = "dx_cp_rnch_bfnd_fara_gotaboxofkonniequipm";
  var_d00963ed83a67ce = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_bfnd_fara_sawakonnisupplycrate";
  aliases[aliases.size] = "dx_cp_rnch_bfnd_fara_gotakonnistashhere";
  aliases[aliases.size] = "dx_cp_rnch_bfnd_fara_foundakonniequipment";
  aliases[aliases.size] = "dx_cp_rnch_bfnd_fara_konnisupplieshere";
  aliases[aliases.size] = "dx_cp_rnch_bfnd_fara_gotacrateofkonniequi";
  var_f86bea40fa06fbd3 = create_deck(aliases, 1, 1);
  structs = getStructArray("dungeon_weapon_crate", "targetname");
  var_31e40e7712c5c799 = 0;

  while(!isDefined(level.var_c46b5c83b58aefb4)) {
    wait 0.1;
  }

  while(true) {
    if(function_4bcd86b926d48155()) {
      return;
    }

    structs waittill_player_lookat(65, 20, 150, undefined, undefined, 0.1);
    var_33cf0a2aa3420bc7 = getclosest(level.player.origin, level.var_c46b5c83b58aefb4, 1000);

    if(isDefined(var_33cf0a2aa3420bc7)) {
      continue;
    }

    if(function_d1099663764b5503()) {
      continue;
    }

    aliases = [var_d00963ed83a67ce deck_draw(), 0.2, "dx_cp_rnch_bfnd_alex_useitagainstemkilo", 0.2, "dx_cp_rnch_bfnd_fara_iintendto"];
    var_9cae6378bba9ac80 = aliases;
    aliases = [var_f86bea40fa06fbd3 deck_draw(), 0.2, "dx_cp_rnch_bfnd_alex_useitagainstemkilo_01", 0.1, "dx_cp_rnch_bfnd_fara_iintendtoecho"];
    var_ebf0861851970e25 = aliases;

    if(!isDefined(function_ce7ae9bbd9964faf())) {
      if(cointoss()) {
        var_31e40e7712c5c799 = level.player function_c9a09b3ba9c68f8d(0.4, var_3cacaa7e3e6ddc28, 0, 2);
      } else {
        var_31e40e7712c5c799 = level.player function_c9a09b3ba9c68f8d(0.4, var_9cae6378bba9ac80, 0, 2);
      }
    } else {
      var_31e40e7712c5c799 = level.player function_c9a09b3ba9c68f8d(0.4, var_ebf0861851970e25, 0, 2);
    }

    if(!isDefined(var_31e40e7712c5c799)) {
      wait 30;
      continue;
    }

    if(var_31e40e7712c5c799) {
      return;
    }
  }
}

function function_a7fe82293147c8cc() {
  if(isDefined(level.var_2b779d5555888c41)) {
    return;
  }

  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_rnp1_alex_lotsofdebrisnearyoug";
  aliases[aliases.size] = "dx_cp_rnch_rnp1_alex_crashscatteredalotof";
  aliases[aliases.size] = "dx_cp_rnch_rnp1_alex_sawkonniwasdiggingar";
  aliases[aliases.size] = "dx_cp_rnch_rnp1_alex_gotsomewreckagethere";
  aliases[aliases.size] = "dx_cp_rnch_rnp1_alex_maybesomethingkonnih";
  level.var_2b779d5555888c41[0] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_pn1c_alex_lotsofdebristherehav";
  aliases[aliases.size] = "dx_cp_rnch_pn1c_alex_crashdebrisandasigna";
  aliases[aliases.size] = "dx_cp_rnch_pn1c_alex_sawkonnidiggingthere";
  aliases[aliases.size] = "dx_cp_rnch_pn1c_alex_tracergotasignalther";
  aliases[aliases.size] = "dx_cp_rnch_pn1c_alex_nearasignalkilosearc";
  level.var_f065e4603fbde5c0[0] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_rnp2_alex_lotoffreshdebrisinyo";
  aliases[aliases.size] = "dx_cp_rnch_rnp2_alex_goteyesoncrashdebris";
  aliases[aliases.size] = "dx_cp_rnch_rnp2_alex_heapsofscrapanddebri";
  aliases[aliases.size] = "dx_cp_rnch_rnp2_alex_tracerssignalssayyou";
  aliases[aliases.size] = "dx_cp_rnch_rnp2_alex_yourenotfarfromasign";
  aliases[aliases.size] = "dx_cp_rnch_rnp2_alex_checkthatareacommand";
  level.var_2b779d5555888c41[1] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_pn2c_alex_gotmoredebrisinyoura";
  aliases[aliases.size] = "dx_cp_rnch_pn2c_alex_lotofdebrisnearyouco";
  aliases[aliases.size] = "dx_cp_rnch_pn2c_alex_heapsofscrapanddebri";
  aliases[aliases.size] = "dx_cp_rnch_pn2c_alex_gotasignalnearbykilo";
  aliases[aliases.size] = "dx_cp_rnch_pn2c_alex_signalscominoffthatd";
  aliases[aliases.size] = "dx_cp_rnch_pn2c_alex_signalsaystheressome";
  level.var_f065e4603fbde5c0[1] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_rnp3_alex_eyesonalotmoredebris";
  aliases[aliases.size] = "dx_cp_rnch_rnp3_alex_lotofwreckagenearyou";
  aliases[aliases.size] = "dx_cp_rnch_rnp3_alex_theresdebrisonthegro";
  aliases[aliases.size] = "dx_cp_rnch_rnp3_alex_tracersaystheresasig";
  aliases[aliases.size] = "dx_cp_rnch_rnp3_alex_gotasignalnearbygott";
  aliases[aliases.size] = "dx_cp_rnch_rnp3_alex_keepsearchingkilotra";
  level.var_2b779d5555888c41[2] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_pn3c_alex_lotmoredebrisnearbyc";
  aliases[aliases.size] = "dx_cp_rnch_pn3c_alex_lotofwreckagenearyou";
  aliases[aliases.size] = "dx_cp_rnch_pn3c_alex_theresdebrisonthegro";
  aliases[aliases.size] = "dx_cp_rnch_pn3c_alex_gotasignalnearbykeep";
  aliases[aliases.size] = "dx_cp_rnch_pn3c_alex_tracersaysyourinprox";
  aliases[aliases.size] = "dx_cp_rnch_pn3c_alex_theresasignalinthata";
  level.var_f065e4603fbde5c0[2] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_rnp1_fara_acknowledged";
  aliases[aliases.size] = "dx_cp_rnch_rnp1_fara_copy";
  aliases[aliases.size] = "dx_cp_rnch_rnp1_fara_roggoodeye";
  aliases[aliases.size] = "dx_cp_rnch_rnp1_fara_goodcallecho";
  aliases[aliases.size] = "dx_cp_rnch_rnp1_fara_copythat31";
  aliases[aliases.size] = "dx_cp_rnch_rnp1_fara_affirmecho";
  level.var_a7f8d7c49643ad08 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_pn1c_fara_copy";
  aliases[aliases.size] = "dx_cp_rnch_pn1c_fara_acknowledged";
  aliases[aliases.size] = "dx_cp_rnch_pn1c_fara_rogerthat";
  aliases[aliases.size] = "dx_cp_rnch_pn1c_fara_copy_01";
  aliases[aliases.size] = "dx_cp_rnch_pn1c_fara_rogecho";
  aliases[aliases.size] = "dx_cp_rnch_pn1c_fara_goodcall31";
  aliases[aliases.size] = "dx_cp_rnch_pn1c_fara_copyalex";
  aliases[aliases.size] = "dx_cp_rnch_pn1c_fara_wilcoecho";
  level.var_cfc315a2c4740971 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_rnp1_alex_lotsofdebrisnearyoug";
  aliases[aliases.size] = "dx_cp_rnch_rnp1_alex_crashscatteredalotof";
  aliases[aliases.size] = "dx_cp_rnch_rnp1_alex_sawkonniwasdiggingar";
  aliases[aliases.size] = "dx_cp_rnch_rnp1_alex_gotsomewreckagethere";
  aliases[aliases.size] = "dx_cp_rnch_rnp1_alex_maybesomethingkonnih";
  aliases[aliases.size] = "dx_cp_rnch_rnp2_alex_lotoffreshdebrisinyo";
  aliases[aliases.size] = "dx_cp_rnch_rnp2_alex_goteyesoncrashdebris";
  aliases[aliases.size] = "dx_cp_rnch_rnp2_alex_heapsofscrapanddebri";
  aliases[aliases.size] = "dx_cp_rnch_rnp2_alex_tracerssignalssayyou";
  aliases[aliases.size] = "dx_cp_rnch_rnp2_alex_yourenotfarfromasign";
  aliases[aliases.size] = "dx_cp_rnch_rnp2_alex_checkthatareacommand";
  aliases[aliases.size] = "dx_cp_rnch_rnp3_alex_eyesonalotmoredebris";
  aliases[aliases.size] = "dx_cp_rnch_rnp3_alex_lotofwreckagenearyou";
  aliases[aliases.size] = "dx_cp_rnch_rnp3_alex_theresdebrisonthegro";
  aliases[aliases.size] = "dx_cp_rnch_rnp3_alex_tracersaystheresasig";
  aliases[aliases.size] = "dx_cp_rnch_rnp3_alex_gotasignalnearbygott";
  aliases[aliases.size] = "dx_cp_rnch_rnp3_alex_keepsearchingkilotra";
  level.var_661799511c55bc7a = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_pn1c_alex_lotsofdebristherehav";
  aliases[aliases.size] = "dx_cp_rnch_pn1c_alex_crashdebrisandasigna";
  aliases[aliases.size] = "dx_cp_rnch_pn1c_alex_sawkonnidiggingthere";
  aliases[aliases.size] = "dx_cp_rnch_pn1c_alex_tracergotasignalther";
  aliases[aliases.size] = "dx_cp_rnch_pn1c_alex_nearasignalkilosearc";
  aliases[aliases.size] = "dx_cp_rnch_pn2c_alex_gotmoredebrisinyoura";
  aliases[aliases.size] = "dx_cp_rnch_pn2c_alex_lotofdebrisnearyouco";
  aliases[aliases.size] = "dx_cp_rnch_pn2c_alex_heapsofscrapanddebri";
  aliases[aliases.size] = "dx_cp_rnch_pn2c_alex_gotasignalnearbykilo";
  aliases[aliases.size] = "dx_cp_rnch_pn2c_alex_signalscominoffthatd";
  aliases[aliases.size] = "dx_cp_rnch_pn2c_alex_signalsaystheressome";
  aliases[aliases.size] = "dx_cp_rnch_pn3c_alex_lotmoredebrisnearbyc";
  aliases[aliases.size] = "dx_cp_rnch_pn3c_alex_lotofwreckagenearyou";
  aliases[aliases.size] = "dx_cp_rnch_pn3c_alex_theresdebrisonthegro";
  aliases[aliases.size] = "dx_cp_rnch_pn3c_alex_gotasignalnearbykeep";
  aliases[aliases.size] = "dx_cp_rnch_pn3c_alex_tracersaysyourinprox";
  aliases[aliases.size] = "dx_cp_rnch_pn3c_alex_theresasignalinthata";
  level.var_32cdd9da473c3e7 = create_deck(aliases, 1, 1);
}

function function_933d18cf92b85750() {
  level endon("game_ended");
  level endon("obj_phones_completed_vo");
  function_a7fe82293147c8cc();
  thread namespace_4c21e3c2da3d8585::hint_showPhoneNearbyHint();

  if(function_1bb1470f934a81eb()) {
    level.player say_sequence([level.var_f065e4603fbde5c0[0] deck_draw(), 0.8, level.var_cfc315a2c4740971 deck_draw(), 0.8], 0.8, 2, 0, 1);
    return;
  }

  level.player say_sequence([level.var_2b779d5555888c41[0] deck_draw(), 0.8, level.var_a7f8d7c49643ad08 deck_draw(), 0.8], 0.8, 2, 0, 1);
}

function function_933d1bcf92b85de9() {
  level endon("game_ended");
  level endon("obj_phones_completed_vo");
  function_a7fe82293147c8cc();
  thread namespace_4c21e3c2da3d8585::hint_showPhoneNearbyHint();

  if(function_1bb1470f934a81eb()) {
    level.player say_sequence([level.var_f065e4603fbde5c0[1] deck_draw(), 0.8, level.var_cfc315a2c4740971 deck_draw(), 0.8], 0.8, 2, 0, 1);
    return;
  }

  level.player say_sequence([level.var_2b779d5555888c41[1] deck_draw(), 0.8, level.var_a7f8d7c49643ad08 deck_draw(), 0.8], 0.8, 2, 0, 1);
}

function function_933d1acf92b85bb6() {
  level endon("game_ended");
  level endon("obj_phones_completed_vo");
  function_a7fe82293147c8cc();
  thread namespace_4c21e3c2da3d8585::hint_showPhoneNearbyHint();

  if(function_1bb1470f934a81eb()) {
    level.player say_sequence([level.var_f065e4603fbde5c0[2] deck_draw(), 0.8, level.var_cfc315a2c4740971 deck_draw(), 0.8], 0.8, 2, 0, 1);
    return;
  }

  level.player say_sequence([level.var_2b779d5555888c41[2] deck_draw(), 0.8, level.var_a7f8d7c49643ad08 deck_draw(), 0.8], 0.8, 2, 0, 1);
}

function function_d1b3ae24a71a64c3() {
  level endon("game_ended");
  level endon("obj_phones_completed_vo");
  function_a7fe82293147c8cc();
  thread namespace_4c21e3c2da3d8585::hint_showPhoneNearbyHint();

  if(function_1bb1470f934a81eb()) {
    level.player say_sequence([level.var_32cdd9da473c3e7 deck_draw(), 0.8, level.var_cfc315a2c4740971 deck_draw(), 0.8], 0.8, 2, 0, 1);
    return;
  }

  level.player say_sequence([level.var_661799511c55bc7a deck_draw(), 0.8, level.var_a7f8d7c49643ad08 deck_draw(), 0.8], 0.8, 2, 0, 1);
}

function function_1c9f85a57dd1d972() {
  if(isDefined(level.var_273a7d4448369971)) {
    return;
  }

  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_rni1_fara_alexivefoundacellpho";
  aliases[aliases.size] = "dx_cp_rnch_rni1_fara_foundacellphonereadi";
  aliases[aliases.size] = "dx_cp_rnch_rni1_fara_alexivegotsomethings";
  aliases[aliases.size] = "dx_cp_rnch_rni1_fara_locatedacellphone";
  aliases[aliases.size] = "dx_cp_rnch_rni1_fara_pickedupaphone";
  aliases[aliases.size] = "dx_cp_rnch_rni1_fara_gotaphonehereecho";
  aliases[aliases.size] = "dx_cp_rnch_rni1_fara_31foundaphone";
  level.var_273a7d4448369971 = [create_deck(aliases, 1, 1)];
  aliases = ["dx_cp_rnch_pi1c_fara_foundaphone", "dx_cp_rnch_pi1c_fara_gotacellphone", "dx_cp_rnch_pi1c_fara_igotsomething"];
  level.var_b93e1f07b8d8c3d0 = [create_deck(aliases, 1, 1)];
  aliases = ["dx_cp_rnch_pi2c_fara_foundanotherphone", "dx_cp_rnch_rni2_fara_foundanother", "dx_cp_rnch_rni2_fara_alexifoundanotherone"];
  level.var_273a7d4448369971[1] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_pi3c_alex_tellmeyoufoundsometh";
  aliases[aliases.size] = "dx_cp_rnch_pi3c_alex_whatdyoufindfarah";
  aliases[aliases.size] = "dx_cp_rnch_pi3c_alex_anythinguseful";
  aliases[aliases.size] = "dx_cp_rnch_pi3c_alex_tellmewegotsomething";
  level.var_273a7d4448369971[2] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_rni1_alex_letsseewhatwevegot";
  aliases[aliases.size] = "dx_cp_rnch_rni1_alex_letshopeitsuseful";
  aliases[aliases.size] = "dx_cp_rnch_rni1_alex_hopewegotsomething";
  aliases[aliases.size] = "dx_cp_rnch_rni1_alex_hopeithelps";
  level.var_102e792833bdb9da = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_pi1c_alex_letsseewhatwevegot";
  aliases[aliases.size] = "dx_cp_rnch_pi1c_alex_letshopeitsuseful";
  aliases[aliases.size] = "dx_cp_rnch_pi1c_alex_hopewegotsomething";
  aliases[aliases.size] = "dx_cp_rnch_pi1c_alex_hopeithelps";
  level.var_92fc9f3353e76707 = create_deck(aliases, 1, 1);
}

function function_c2638b66a6982924() {
  function_1c9f85a57dd1d972();
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_rni1_fara_itsshakyshoutinginar";
  aliases[aliases.size] = "dx_cp_rnch_rni1_fara_hardtomakeoutyelling";
  aliases[aliases.size] = "dx_cp_rnch_rni1_fara_videoisshakypassenge";
  aliases[aliases.size] = "dx_cp_rnch_rni1_fara_russianairmarshalsth";
  var_1d003c21747507dd = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_pi1c_fara_contactaleximsending";
  aliases[aliases.size] = "dx_cp_rnch_pi1c_fara_ivegotincomingsendin";
  aliases[aliases.size] = "dx_cp_rnch_pi1c_fara_contactsendingvideot";
  aliases[aliases.size] = "dx_cp_rnch_pi1c_fara_takingfireuploadingn";
  aliases[aliases.size] = "dx_cp_rnch_pi1c_fara_gotcontactwatchittel";
  aliases[aliases.size] = "dx_cp_rnch_pi1c_fara_underfiresendingyout";
  var_30cffe352788b96a = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_pi1c_alex_russianpassengersscr";
  aliases[aliases.size] = "dx_cp_rnch_pi1c_alex_receivedlookslikesom";
  aliases[aliases.size] = "dx_cp_rnch_pi1c_alex_gotitseeingfrightene";
  aliases[aliases.size] = "dx_cp_rnch_pi1c_alex_scaredpassengerssome";
  aliases[aliases.size] = "dx_cp_rnch_pi1c_alex_russianairmarshalsar";
  aliases[aliases.size] = "dx_cp_rnch_pi1c_alex_theyreyellinginrussi";
  var_decaa2b1a06cb7eb = create_deck(aliases, 1, 1);

  if(function_1bb1470f934a81eb()) {
    var_413657c925d88d3e = [level.var_b93e1f07b8d8c3d0[0] deck_draw(), 0.6, level.var_92fc9f3353e76707 deck_draw(), 0.8, var_30cffe352788b96a deck_draw(), 0.8, var_decaa2b1a06cb7eb deck_draw()];
    level.player say_sequence(var_413657c925d88d3e, 1, 4);
  } else {
    var_7724d8b5e3785775 = [level.var_273a7d4448369971[0] deck_draw(), 0.6, level.var_102e792833bdb9da deck_draw(), 0.8, var_1d003c21747507dd deck_draw()];
    level.player say_sequence(var_7724d8b5e3785775, 1, 4);
  }

  flag_set("obj_phones1_completed_vo");
}

function function_c2638e66a6982fbd() {
  function_1c9f85a57dd1d972();
  aliases = ["dx_cp_rnch_rni2_fara_foundanother", "dx_cp_rnch_rni2_fara_alexifoundanotherone"];
  var_2fd1237ff0d59da0 = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_rnch_pi2c_fara_foundanotherphone", "dx_cp_rnch_pi2c_fara_foundanother"];
  var_4f88109285d36089 = create_deck(aliases, 1, 1);
  var_547f428d285b4438 = create_deck(["dx_cp_rnch_rni2_alex_whatdoyousee", "dx_cp_rnch_rni2_alex_hopeitsgotmorethanth", "dx_cp_rnch_rni2_alex_tellme"]);
  var_8c83e549536e8a01 = create_deck(["dx_cp_rnch_pi2c_alex_whatdoyousee", "dx_cp_rnch_pi2c_alex_hopeitsgotmorethanth", "dx_cp_rnch_pi2c_alex_imallears"]);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_rni2_fara_iseeawomanwithagun";
  var_f7c9f25a298e6ab = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_pi2c_fara_oneofmyfightersisont";
  var_2b9189e97100804 = create_deck(aliases, 1, 1);

  if(function_1bb1470f934a81eb()) {
    var_413657c925d88d3e = [var_4f88109285d36089 deck_draw(), 0.5, var_8c83e549536e8a01 deck_draw(), 0.8, var_2b9189e97100804 deck_draw()];
    level.player say_sequence(var_413657c925d88d3e, 1, 4);
    level.player say_sequence([0.4, "dx_cp_rnch_pi2c_alex_yousure", 0.3, "dx_cp_rnch_pi2c_fara_yes", 0.6, "dx_cp_rnch_pi2c_alex_thisisnogoodfarah", 0.6, "dx_cp_rnch_pi2c_fara_iknowalexsomethingsv"], 1, 3);
  } else {
    var_7724d8b5e3785775 = [var_2fd1237ff0d59da0 deck_draw(), 0.5, var_547f428d285b4438 deck_draw(), 0.8, var_f7c9f25a298e6ab deck_draw()];
    level.player say_sequence(var_7724d8b5e3785775, 1, 4);
    level.player say_sequence([0.3, "dx_cp_rnch_rni2_fara_samarashesoneofmysol", 0.4, "dx_cp_rnch_rni2_alex_yousure", 0.3, "dx_cp_rnch_rni2_fara_yesshewouldneverdoth", 0.6, "dx_cp_rnch_rni2_alex_farahpeoplechangeyou", 0.6, "dx_cp_rnch_rni2_fara_thisisdifferentalex", 0.5, "dx_cp_rnch_rni2_alex_ihopesoletsseewhatel"], 1, 3);
  }

  flag_set("obj_phones2_completed_vo");
}

function function_c2638d66a6982d8a() {
  if(function_4bcd86b926d48155()) {
    return;
  }

  level endon("game_ended");
  function_1c9f85a57dd1d972();
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_pi3c_fara_konnisonmesendingtoy";
  aliases[aliases.size] = "dx_cp_rnch_pi3c_alex_samewomanyoursoldier";
  aliases[aliases.size] = "dx_cp_rnch_pi3c_fara_shewasforcedtodothis_01";
  aliases[aliases.size] = "dx_cp_rnch_pi3c_alex_youdontknowthatfarah";
  aliases[aliases.size] = "dx_cp_rnch_pi3c_fara_idoalexiknowit";
  flag_set("obj_phone_complete_vo_begin");

  if(function_1bb1470f934a81eb()) {
    level.player say_sequence([0.4, "dx_cp_rnch_pi3c_fara_konnisonmesendingtoy", 0.3, "dx_cp_rnch_pi3c_alex_samewomanyoursoldier", 0.6, "dx_cp_rnch_pi3c_fara_shewasforcedtodothis_01", 0.6, "dx_cp_rnch_pi3c_alex_youdontknowthatfarah", 0.4, "dx_cp_rnch_pi3c_fara_idoalexiknowit"], 1, 3);
  } else {
    level.player say_sequence([0.4, "dx_cp_rnch_rni3_fara_iseemysoldiersamarai", 0.3, "dx_cp_rnch_rni3_alex_agunnowavest", 0.6, "dx_cp_rnch_rni3_fara_shelooksafraidshedoe", 0.6, "dx_cp_rnch_rni3_alex_webothknowtheworldwo", 0.4, "dx_cp_rnch_rni3_fara_makarovwantstheworld", 0.5, "dx_cp_rnch_rni3_alex_understood"], 1, 3);
  }

  flag_set("obj_phones_completed_vo");
  childthread function_b398f53b86f73e6a();
}

function function_b398f53b86f73e6a() {
  level endon("blackbox_interacted");
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_rnim_alex_flightrecordersstill_01";
  aliases[aliases.size] = "dx_cp_rnch_rnim_alex_flightrecordercouldh";
  aliases[aliases.size] = "dx_cp_rnch_rnim_alex_theflightrecordersst";
  aliases[aliases.size] = "dx_cp_rnch_rnim_alex_stillneedtosecuretha";
  aliases[aliases.size] = "dx_cp_rnch_rnim_alex_flightrecordersstill";
  aliases[aliases.size] = "dx_cp_rnch_rnim_alex_findtheblackboxfarah";
  aliases[aliases.size] = "dx_cp_rnch_rnim_alex_flightdatawillhelpus";
  aliases[aliases.size] = "dx_cp_rnch_rnck_alex_tracerspickingupabea";

  if(!isDefined(level.var_15c503082a522952)) {
    level.var_15c503082a522952 = create_deck(aliases, 1, 1);
  }

  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_pmec_alex_flightrecordersstill";
  aliases[aliases.size] = "dx_cp_rnch_pmec_alex_blackboxhasimportant";
  aliases[aliases.size] = "dx_cp_rnch_pmec_alex_theflightrecordersst";
  aliases[aliases.size] = "dx_cp_rnch_pmec_alex_stillneedtosecurethe";
  aliases[aliases.size] = "dx_cp_rnch_cpwc_alex_tracerspickingupabea";

  if(!isDefined(level.var_5409bd71699bab1)) {
    level.var_5409bd71699bab1 = create_deck(aliases, 1, 1);
  }

  if(function_1bb1470f934a81eb()) {
    level function_fc0eb6b81c66c661(0.4, level.var_5409bd71699bab1 deck_draw(), 0, 2);
  } else {
    level function_fc0eb6b81c66c661(0.4, level.var_15c503082a522952 deck_draw(), 0, 2);
  }

  wait 6;

  if(!function_1bb1470f934a81eb() && level.player.var_bec156d5a2918db9 != "manor") {
    function_99dab8618282ca8d();
  }

  var_5f9446889da88fc7 = getEnt("blackbox_room", "targetname");
  delay = growing_delay(15, 40, 5);

  while(true) {
    waitfor(delay);

    if(!isDefined(level.player.var_bec156d5a2918db9) || level.player.var_bec156d5a2918db9 == "manor") {
      continue;
    }

    if(level.player istouching(var_5f9446889da88fc7)) {
      continue;
    }

    if(function_1bb1470f934a81eb()) {
      level.player say_delayed(0.4, level.var_5409bd71699bab1 deck_draw(), 0, 3);
      continue;
    }

    level.player say_delayed(0.4, level.var_15c503082a522952 deck_draw(), 0, 3);
  }
}

function function_7118b43524ec9a99() {
  level endon("game_ended");
  level endon("obj_escape_completed");
  level.player endon("death");
  flag_wait("obj_search_completed_vo");
  flag_wait("obj_phones_completed_vo");
  flag_wait("vo_escape_completed");
  var_ed6a48de4fc48852 = 0;

  while(true) {
    waitframe();

    if(is_in_combat()) {
      level.var_93c46429bd668f2 = undefined;
      continue;
    }

    if(!isDefined(level.var_93c46429bd668f2)) {
      level.var_93c46429bd668f2 = gettime();
    }

    if(level.var_d0d5526a0a139791.size > 0 && gettime() - level.var_d0d5526a0a139791[level.var_d0d5526a0a139791.size - 1] < 60000) {
      level.var_93c46429bd668f2 = undefined;
      continue;
    }

    if(!isDefined(level.var_93c46429bd668f2) || gettime() - level.var_93c46429bd668f2 < 60000) {
      continue;
    }

    if(function_6c31b0b0edd184ed([level.player])) {
      continue;
    }

    level.player say("dx_guid2ddcbd514b6a42b98a150cfca8135b5b", 0.5, 5);

    if(!var_ed6a48de4fc48852 && !function_155f16ed1b7f00cd()) {
      var_ed6a48de4fc48852 = 1;
      level.player say("dx_guid1b8d136ae63c42c7ba54a551c2024db1", 0, 0);
    }

    level.var_93c46429bd668f2 = undefined;
  }
}

function function_eafb7adf3879e19d() {
  level endon("game_ended");
  level endon("obj_escape_completed");
  level.player endon("death");
  flag_wait("obj_search_completed_vo");
  flag_wait("obj_phones_completed_vo");
  flag_wait("active_combat_begun");
  vo_trigger = function_1c4d592029f2b0d3("vo_exfil_approach");

  while(!level.player istouching(vo_trigger) || function_6c31b0b0edd184ed([level.player])) {
    waitframe();
  }

  var_b65189c5f659aa08 = getaiarray("axis").size;

  if(isalive(level.var_20a7c4701df58193) || var_b65189c5f659aa08 > 7) {}
}

function function_a82119d616d087a7() {
  if(function_155f16ed1b7f00cd()) {}
}

function function_13ee2c4638944ea1() {
  level endon("game_ended");
  level.player endon("death");
  alternates = ["dx_guid0661980308d6417398489e467ecc1386", "dx_guid4e9f85cfb1f64cb2a7fbe4c5cf013e76", "dx_guid98cd80bf6a294fcea4b9d16196964088", "dx_guid050fbd6d977e4d4daf66bd7a02d0af43"];
  level.player function_171dea4e0c9a6281(1, alternates, "obj_phones_completed_vo", "start_escape_flow");
}

function function_493a50678d954a0f() {
  level endon("game_ended");
  level.player endon("death");
  level endon("flag_dungeon_outro_start");

  while(!isDefined(level.player.var_bec156d5a2918db9) || level.player.var_bec156d5a2918db9 == "hilltop") {
    waitframe();
  }

  var_28a53bdaa51870e4 = 0;

  while(true) {
    wait 1;
    stance = level.player getstance();

    if(!isDefined(level.var_9e86aa94cdbc3b82)) {
      return;
    }

    if(!level.var_9e86aa94cdbc3b82 || stance == "stand") {
      level.var_9b6e65c0146044f4 = undefined;
      continue;
    }

    if(!isDefined(level.var_9b6e65c0146044f4)) {
      level.var_9b6e65c0146044f4 = gettime();
    }

    if(function_1c988b6c6d6719b8(undefined, 225) < 1) {
      continue;
    }

    if(function_155f16ed1b7f00cd(undefined, 5)) {
      continue;
    }

    if(!isDefined(level.var_9b6e65c0146044f4) || gettime() - level.var_9b6e65c0146044f4 < 3000) {
      continue;
    }

    level.var_9b6e65c0146044f4 = undefined;

    if(!flag("active_combat_begun") && !var_28a53bdaa51870e4) {
      var_28a53bdaa51870e4 = 1;
      level.player say("dx_guid607e86ba7a4d4094868f1746c48d33ee", 0.5, 0);
    } else {
      level.player say("dx_guid9515636dfc59498881d0a2e3242ff114", 0.5, 0);
    }

    wait 120;
  }
}

function function_7261ea21b4dfb8e() {
  level endon("game_ended");
  level.player endon("death");
  level endon("active_combat_begun");

  for(on_cooldown = 1; true; on_cooldown = 0) {
    level waittill("killed_unaware_ai", var_7298db0bc3cecb85);

    if(on_cooldown) {
      if(function_6c31b0b0edd184ed([level.player])) {
        continue;
      }
    }

    if(isDefined(var_7298db0bc3cecb85)) {
      var_4807087bdfe65937 = function_1a5601bd2b19f321([var_7298db0bc3cecb85]);
      var_c7f1b6e82e0f97a8 = var_4807087bdfe65937.size;
      wait randomfloatrange(0.5, 1.5);

      if(!function_20a67c381e6b83bc()) {
        continue;
      }

      switch (var_7298db0bc3cecb85) {
        case #"hash_11e50acd1d847493":
          level.player thread say("dx_guide777bbf0d5ff40279c78ccd83ff7b418", 0, 0);
          break;
        case #"hash_a052c7771e4bc57e":
          switch (var_c7f1b6e82e0f97a8) {
            case 0:
              level.player thread say("dx_guid0dd9c1779ed24e93b93c5eafc9a76655", 0, 0);
              break;
            case 1:
              level.player thread say("dx_guid2d8e1968a468450d8546f1f7f06a3a4b", 0, 0);
              break;
            default:
              level.player thread say("dx_guidd5224043d41e4e7db69ee78743c6c770", 0, 0);
              break;
          }

          break;
        case #"hash_a052c6771e4bc3eb":
          switch (var_c7f1b6e82e0f97a8) {
            case 0:
              level.player thread say("dx_guid60e0a34f874547c4b1f44b85bcea31e7", 0, 0);
              break;
            default:
              level.player thread say("dx_guidd5224043d41e4e7db69ee78743c6c770", 0, 0);
              break;
          }

          break;
        case #"hash_a052c0771e4bba79":
        case #"hash_a052c5771e4bc258":
        case #"hash_a052c9771e4bc8a4":
        case #"hash_a052ca771e4bca37":
        case #"hash_a052cb771e4bcbca":
        case #"hash_a052cc771e4bcd5d":
          vo = random(["dx_guide777bbf0d5ff40279c78ccd83ff7b418", "dx_guid6325a66227e845f7916806ade96d4a59", "dx_guid60e0a34f874547c4b1f44b85bcea31e7"]);
          level.player thread say(vo, 0, 0);
          break;
        case #"hash_1c48e0d877ab695f":
          switch (var_c7f1b6e82e0f97a8) {
            case 0:
              vo = random(["dx_guidb8e67ce2f1be4710838c1695cd15d720", "dx_guid6d344726b059485f87d5c6812f487eb4"]);
              level.player thread say(vo, 0, 0);
              break;
            default:
              level.player thread say("dx_guid1496286e91474457802968291e977fbd", 0, 0);
              break;
          }

          break;
        case #"hash_b4a0ade5a2c5acd4":
          switch (var_c7f1b6e82e0f97a8) {
            case 0:
              vo = random(["dx_guid2fdcf5a5aa66419bbe84fdb71325bf37"]);
              level.player thread say(vo, 0, 0);
              break;
            default:
              level.player thread say("dx_guid2d8e1968a468450d8546f1f7f06a3a4b", 0, 0);
              break;
          }

          break;
        case #"hash_95ee744947fa98":
        case #"hash_363ee3c469a41d7e":
        case #"hash_3675b46e2a800a64":
          vo = random(["dx_guid1496286e91474457802968291e977fbd", "dx_guid60e0a34f874547c4b1f44b85bcea31e7"]);
          level.player thread say(vo, 0, 0);
          break;
        case #"hash_4a5e36747260fa66":
          level.player thread say("dx_guid6d344726b059485f87d5c6812f487eb4", 0, 0);
          break;
        case #"hash_6c0165f807907a9":
          switch (var_c7f1b6e82e0f97a8) {
            case 0:
              level.player thread say("dx_guid9b68848ea7084c6fb3510abc492e9287", 0, 0);
              break;
            default:
              level.player thread say("dx_guid2d8e1968a468450d8546f1f7f06a3a4b", 0, 0);
              break;
          }

          break;
        case #"hash_9ca83d49097a234b":
          switch (var_c7f1b6e82e0f97a8) {
            case 0:
              level.player thread say("dx_guid9b68848ea7084c6fb3510abc492e9287", 0, 0);
              break;
            case 1:
              level.player thread say("dx_guid60e0a34f874547c4b1f44b85bcea31e7", 0, 0);
              break;
            default:
              level.player thread say("dx_guidd5224043d41e4e7db69ee78743c6c770", 0, 0);
              break;
          }

          break;
      }

      if(var_c7f1b6e82e0f97a8 == 0) {
        on_cooldown = 1;
        wait 30;
        continue;
      }
    }
  }
}

function function_429367c89185c6c3() {
  level endon("game_ended");
  level.player endon("death");
  flag_wait("active_combat_begun");

  while(true) {
    level waittill_any_2("killed_unaware_ai", "killed_combat_ai");
    wait randomfloatrange(0.5, 1.5);

    if(!function_20a67c381e6b83bc()) {
      continue;
    }

    vo_played = level.player function_86ee87fa1ec56de9("dx_guidcbb8a2cd20e94fdaa4777707f83056cf", undefined, undefined, "", &function_56c0f24ff10b0e72);

    if(istrue(vo_played)) {
      wait 30;
    }
  }
}

function function_56c0f24ff10b0e72() {
  return function_155f16ed1b7f00cd(undefined, 10);
}

function function_2d165890c1714bd9() {
  level endon("game_ended");
  level.player endon("death");
  var_96e6c220a8a43546 = 0;

  while(!flag("flag_dungeon_outro_start")) {
    level waittill("spawn_reinforcement_vehicle");
    wait randomfloatrange(0, 4);

    if(flag("start_escape_flow")) {
      if(var_96e6c220a8a43546 == 0) {
        level.player say("dx_guid657c85cc97ee49969e50958702b1f291", 0.5, 0);
      } else {
        level.player say("dx_guid17ae80d35cb444b8a51502c1b41e9bd7", 0.5, 0);
      }

      var_96e6c220a8a43546++;
    } else {
      level.player say("dx_guidef800bfb87744f21952d1cdf191f47ef", 0.5, 0);
    }

    wait 30;
  }
}

function vo_combat() {
  level endon("game_ended");
  level.player endon("death");
  var_86e66b439655ac84 = 1;
  var_47d94983834af790 = 0;
  var_5c599499f828b745 = 0;
  var_9eaf6951bc46fc98 = 0;
  flag_wait("active_combat_begun");

  while(true) {
    wait 1;
    var_75cbf8e4320883a4 = function_155f16ed1b7f00cd(undefined, 3);

    if(function_1c988b6c6d6719b8(undefined, 700) >= 10) {
      var_86e66b439655ac84 = 0;

      if(flag("vo_ai_combatbegun")) {
        var_5bd1018e630fd821 = level.player function_86ee87fa1ec56de9("dx_guid2fc6bcc706774e09b4a51e73daed3eea");

        if(istrue(var_5bd1018e630fd821)) {
          level notify("player_swarmed");

          if(var_9eaf6951bc46fc98) {}
        }
      }

      wait 13;
      continue;
    }

    if(var_75cbf8e4320883a4 && var_86e66b439655ac84 && function_155f16ed1b7f00cd()) {
      var_86e66b439655ac84 = 0;

      if(flag("vo_ai_combatbegun")) {
        var_5bd1018e630fd821 = level.player function_86ee87fa1ec56de9("dx_guidd7d50e1d2cda48a194795a2607143b37");

        if(istrue(var_5bd1018e630fd821)) {
          if(!var_5c599499f828b745) {
            var_5c599499f828b745 = level.player function_86ee87fa1ec56de9("dx_guida3e8348d69fd44ba8a500890200bca4c");
          }
        }
      }

      wait 13;
      continue;
    }

    if(!var_75cbf8e4320883a4 && !var_86e66b439655ac84) {
      var_86e66b439655ac84 = 1;

      if(var_47d94983834af790) {
        level.player function_86ee87fa1ec56de9("dx_guida710cf17b4eb4becab27cf7e07bac833");
      } else {
        sequence = ["dx_guid9fc07c1cc3ed44849e03d5866ca13f16", "dx_guidbf29e50a0585475599d94422d04ad38b"];
        var_47d94983834af790 = level.player function_86ee87fa1ec56de9(sequence);
      }

      wait 13;
    }
  }
}

function function_dc287a2e74c25f0a() {
  level endon("active_combat_begun");
  flag_wait("flag_dungeon_intro_complete");
  function_7cc9b8f5c34a4300("vol_vo_trap_perimeter_trigger");
  var_e68e72dc8f058a8d = function_6a86ad418e0171d9(undefined, "vol_vo_trap_perimeter");

  if(!isDefined(var_e68e72dc8f058a8d)) {
    return;
  }

  alternates = ["dx_cp_rnch_rnaa_kon1_perimetertrapsareset", "dx_cp_rnch_rnaa_kon1_perimeterscoveredint", "dx_cp_rnch_rnaa_kon1_ivefinishedriggingth", "dx_cp_rnch_rnaa_kon1_tripwiresaresetperim"];
  var_e68e72dc8f058a8d function_171dea4e0c9a6281(1, alternates);
}

function function_85fb5089307c2bef() {
  level endon("active_combat_begun");
  flag_wait("flag_dungeon_intro_complete");
  function_7cc9b8f5c34a4300("vol_vo_trap_interior_trigger");
  var_e68e72dc8f058a8d = function_6a86ad418e0171d9(undefined, "vol_vo_trap_interior");

  if(!isDefined(var_e68e72dc8f058a8d)) {
    return;
  }

  alternates = ["dx_guid6b9ad9b2ebe8498584c4ab32b6be0afb", "dx_guidd1dd3624198a45ada249b62441d4f6d2", "dx_guid479763f3778743c9be9dbb6cb2140349"];
  var_e68e72dc8f058a8d function_171dea4e0c9a6281(1, alternates);
}

function vo_ai_combatbegun() {
  level endon("game_ended");
  level endon("start_escape_flow");
  flag_wait("active_combat_begun");
  var_e68e72dc8f058a8d = level.player function_95ecff6ac09a31ed();

  if(!isDefined(var_e68e72dc8f058a8d)) {
    return;
  }

  alternates = ["dx_guidaf0e20d7c752400182d2ed4f41ade4d0", "dx_guide636a0c94c76411e9f8d1c1e0eb334a2", "dx_guid56aaf29dc45e44adbce8dbd005f29747", "dx_guidf5e54a9372604d13a30c3dd7263aad93"];
  var_e68e72dc8f058a8d function_171dea4e0c9a6281(0, alternates);
  flag_set("vo_ai_combatbegun");
}

function vo_ai_call_for_fire_support() {
  level endon("game_ended");
  level.player endon("death");

  while(!isDefined(level.var_20a7c4701df58193)) {
    waitframe();
  }

  level.var_20a7c4701df58193 endon("death");
  level.var_20a7c4701df58193 endon("reached_dynamic_path_end");
  level endon("turret_EndBehavior");

  while(true) {
    level waittill("vo_ai_call_for_fire_support");

    if(!level.var_20a7c4701df58193.var_c6cc481297bce5c2) {
      var_64f4d0b6c176e4da = level.player function_d0b6fd4fc2332c8c(undefined, 3);

      if(!isDefined(var_64f4d0b6c176e4da)) {
        continue;
      }

      function_b020837be462da86("SOLDIER: Taking heavy fire! Need fire support!");
      var_64f4d0b6c176e4da function_31fcf0528e5d8d3f("dx_cp_rnch_rnia_kon3_wehavecasualtiesrequ");
      function_b020837be462da86("JLTV: Roger, JLTV enroute.");
      level.var_20a7c4701df58193.riders[0] function_31fcf0528e5d8d3f("dx_cp_rnch_rnja_konl_jltvsenrouteholdyour");
    }

    wait 30;
  }
}

function function_9957d9e924ff4f5d() {
  level endon("game_ended");
  level endon("flag_dungeon_outro_start");
  level.player endon("death");
  var_e68e72dc8f058a8d = level.player function_95ecff6ac09a31ed();

  if(!isDefined(var_e68e72dc8f058a8d)) {
    return;
  }

  alternates = ["dx_guidddd96a28a63042a49ea4f2e15c201a8a", "dx_guid851f48555ca0431eb086f3ed721fe622", "dx_guid473d9aecbf2b413b947964df646cb3c0", "dx_guidd521db6db9c0468b948688b096bd22f0"];
  var_e68e72dc8f058a8d function_eef4df793801949(0, alternates, "start_escape_flow", "flag_dungeon_outro_start");

  for(vo_played = 0; !istrue(vo_played); vo_played = var_e68e72dc8f058a8d function_86ee87fa1ec56de9("dx_cp_rnch_rnap_kon1_intruderstryingtoesc")) {
    wait 1;

    while(!function_155f16ed1b7f00cd()) {
      waitframe();
    }

    var_e68e72dc8f058a8d = level.player function_95ecff6ac09a31ed();

    if(!isDefined(var_e68e72dc8f058a8d)) {
      continue;
    }
  }
}

function vo_patrol_truck_sees_enemy() {
  level endon("game_ended");
  level.player endon("death");

  while(!isDefined(level.var_20a7c4701df58193)) {
    waitframe();
  }

  level.var_20a7c4701df58193 endon("death");
  level endon("turret_EndBehavior");

  while(true) {
    level waittill("vo_patrol_truck_sees_enemy");
    function_b020837be462da86("Target spotted. JLTV turret engaging.");
    level.var_20a7c4701df58193.riders[4] function_31fcf0528e5d8d3f("dx_cp_rnch_rnjb_konl_targetspottedengagin");
    wait 30;
  }
}

function obj_flow() {
  doors = getentitylessscriptablearray(undefined, undefined, (1763, 1829, 100), 56, "door");

  foreach(door in doors) {
    door function_9af4c9b2cc1bf989();
    door.blocked = 1;
  }

  level obj_phones();
  flag_wait("obj_phones_completed");

  if(isDefined(level.objpoints)) {
    foreach(point in level.objpoints) {
      point notify(point.script_noteworthy + "_complete");
    }
  }

  level thread function_987f835f9b6ea4a4();
  level thread function_7e376867985b0dc9(doors);
  level obj_search();
  function_d533135f9587fdda();
  flag_set("obj_escape_start");
  wait 1;
  objstruct = level.objectivestabledata["obj_escape"];
  initializeobjective(objstruct, "obj_escape", "primary");
  startobjective(objstruct, "obj_escape", "primary");
  flag_wait("obj_escape_completed");
  completeobjective(objstruct, "obj_escape", "primary");
}

function obj_search() {
  if(function_4bcd86b926d48155()) {
    flag_set("obj_search_completed");
    thread function_95a1718574f2b4b7();
    return;
  }

  objstruct = level.objectivestabledata["obj_search"];
  initializeobjective(objstruct, "obj_search", "primary");
  startobjective(objstruct, "obj_search", "primary");
  scripts\cp\utility::function_3069b525e1c98faf("search recorder");
}

function obj_phones() {
  if(function_4bcd86b926d48155()) {
    flag_set("obj_phones_completed");
    flag_set("obj_phones1_completed_vo");
    flag_set("obj_phones2_completed_vo");
    flag_set("obj_phones_completed_vo");
    level.player scripts\common\values::group_set("infil_player", 1);
    level.player scripts\cp_mp\utility\game_utility::function_20cb4a5f727abe6e(0);
    thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.player, 0, 1);
    return;
  }

  objstruct = level.objectivestabledata["obj_phones"];
  initializeobjective(objstruct, "obj_phones", "primary");
  startobjective(objstruct, "obj_phones", "primary");
  thread function_7795eef0d57a5427();
  flag_wait("obj_phone_complete_vo_begin");
  flag_set("obj_phones_completed");

  if(isDefined(level.var_7dde1bdd72c01010)) {
    foreach(obj in level.var_7dde1bdd72c01010) {
      objective_state(obj, "done");
      scripts\cp\cp_objectives::freeworldidbyobjid(obj);
      objective_delete(obj);
    }
  }

  completeobjective(objstruct, "obj_phones", "primary");
}

function function_7795eef0d57a5427() {
  if(function_4bcd86b926d48155()) {
    flag_set("obj_phones1_completed_vo");
    flag_set("obj_phones2_completed_vo");
    flag_set("obj_phones_completed_vo");
    return;
  }

  var_2a0b12e49a8bf11e = [ &function_933d18cf92b85750, &function_933d1bcf92b85de9, &function_933d1acf92b85bb6, &function_d1b3ae24a71a64c3, &function_d1b3ae24a71a64c3, &function_d1b3ae24a71a64c3];
  var_ab06382e5055c412 = [ &function_c2638b66a6982924, &function_c2638e66a6982fbd, &function_c2638d66a6982d8a];
  thread function_fbb6e84af6ec5790(var_2a0b12e49a8bf11e);
  thread function_a944deaa25a012d7(var_ab06382e5055c412);
}

function function_fbb6e84af6ec5790(var_344af5e735539ec9) {
  for(var_8d32bbd27c5b2161 = 0; var_8d32bbd27c5b2161 < 6; var_8d32bbd27c5b2161++) {
    level waittill("phone_crate_nearby");

    if(isDefined(var_344af5e735539ec9[var_8d32bbd27c5b2161])) {
      thread[[var_344af5e735539ec9[var_8d32bbd27c5b2161]]]();
    }
  }
}

function function_a944deaa25a012d7(var_c4390ef06dbf5e76) {
  for(var_8d32bbd27c5b2161 = 0; var_8d32bbd27c5b2161 < 3; var_8d32bbd27c5b2161++) {
    level waittill("phone_crate_hacked");

    if(isDefined(var_c4390ef06dbf5e76[var_8d32bbd27c5b2161])) {
      thread[[var_c4390ef06dbf5e76[var_8d32bbd27c5b2161]]]();
    }
  }
}

function function_d533135f9587fdda() {
  flag_wait("obj_phones_completed_vo");
  flag_wait("obj_search_completed_vo");
}

function function_10e7f2840996cff8(objectivestruct, var_5dcdfd3a4eff9961) {
  flag_wait("player_in_blackbox_room");
  var_c49d7039fc3727a2 = getStruct("obj_search", "targetname").origin + (0, 0, 10);
  namespace_1170726b2799ea65::function_f60f3ac2fb2776f7(objectivestruct, "icon_waypoint_objective_general", "icon_medium", var_c49d7039fc3727a2, "current", "Flight Recorder", undefined, undefined, 0, 0);
  flag_wait("obj_search_completed");
  completeobjective(objectivestruct, "obj_search", "primary");
  scripts\cp\utility::function_3069b525e1c98faf("START");
}

function obj_escape_start(objectivestruct, var_5dcdfd3a4eff9961) {
  thread namespace_4c21e3c2da3d8585::function_dcca511867827ee(objectivestruct);
  flag_wait("alex_enemies_killed");
  namespace_1170726b2799ea65::function_448adabb169120d7(objectivestruct);
  var_36d6ba093b407471 = level.var_69c070ef9dc50848;
  var_e62df0718b7dcbca = var_36d6ba093b407471.origin + (0, 0, 70);
  objindex = namespace_1170726b2799ea65::function_f60f3ac2fb2776f7(objectivestruct, "icon_waypoint_objective_general", "icon_medium", var_e62df0718b7dcbca, "current", &"CP_JUP_RANCH/OBJ_EXFIL_LABEL", &"CP_JUP_RANCH/ESCAPE_RANCH");
}

function setup_map_specific_devgui() {}

function function_d8fb18a58a875db6(player) {
  playername = player.name;
  playernum = undefined;

  for(i = 0; i < level.players.size; i++) {
    if(level.players[i] == player) {
      player thread function_cab08c75e0639ea0(player, playername, i);
      break;
    }
  }
}

function function_cab08c75e0639ea0(player, name, num) {}

function function_9db3aebbe08d390c(time, msg) {
  wait time;
  iprintlnbold(msg);
}

function function_8488742ee64fe782() {
  level endon("game_ended");
  level.player endon("death");

  while(true) {
    if(isDefined(level.player.vehicle)) {
      vehicle = level.player.vehicle;
      vehicle thread function_fbef61d68f733524();

      while(isDefined(level.player.vehicle)) {
        waitframe();
      }

      vehicle thread function_e5f869d16eb9abea();
    }

    waitframe();
  }
}

function function_fbef61d68f733524() {
  self endon("death");
  wait 0.1;

  if(!isDefined(self)) {
    return;
  }

  self setscriptablepartstate("lights_front_cheap", "on");
  self setscriptablepartstate("lights_back_cheap", "on");
}

function function_e5f869d16eb9abea() {
  self endon("death");
  wait 0.1;

  if(!isDefined(self)) {
    return;
  }

  self setscriptablepartstate("lights_front_cheap", "off");
  self setscriptablepartstate("lights_back_cheap", "off");
}

function function_297f5406ec15234b() {
  if(isDefined(level.var_20a7c4701df58193)) {
    jltv = level.var_20a7c4701df58193;
    var_6e333f311ff80281 = function_9d30fd63965bafa9("gunshot");
    scripts\stealth\event::event_broadcast_generic("gunshot", jltv.origin, var_6e333f311ff80281, jltv);
  }
}

function function_d4bb412060b41644() {
  while(true) {
    wait 0.25;

    if(isDefined(self.alertlevel) && !(self.alertlevel == "noncombat")) {
      continue;
    }

    stance = level.player getstance();

    switch (stance) {
      case #"hash_c6775c88e38f7803":
        function_a7b3e69ccd6fb7cb();
        break;
      case #"hash_3fed0cbd303639eb":
        function_85900015f5d62385();
        break;
      case #"hash_d91940431ed7c605":
        function_ff6c94d002d76cbd();
        break;
      default:
        break;
    }
  }
}

function function_a7b3e69ccd6fb7cb() {
  if(isDefined(level.var_1c0f3b6933eb1c87) && istrue(level.var_1c0f3b6933eb1c87)) {
    level.player scripts\cp\coop_stealth::set_maxvisibledist(900);
    return;
  }

  level.player scripts\cp\coop_stealth::set_maxvisibledist(1400);
}

function function_85900015f5d62385() {
  if(isDefined(level.var_1c0f3b6933eb1c87) && istrue(level.var_1c0f3b6933eb1c87)) {
    level.player scripts\cp\coop_stealth::set_maxvisibledist(500);
    return;
  }

  level.player scripts\cp\coop_stealth::set_maxvisibledist(800);
}

function function_ff6c94d002d76cbd() {
  if(isDefined(level.var_1c0f3b6933eb1c87) && istrue(level.var_1c0f3b6933eb1c87)) {
    level.player scripts\cp\coop_stealth::set_maxvisibledist(200);
    return;
  }

  level.player scripts\cp\coop_stealth::set_maxvisibledist(400);
}

function function_ebf9deb154f7a9d8() {
  if(isDefined(self.inventory_visible) && self.inventory_visible == 1) {
    return 1;
  }

  return 0;
}

function player_nvg_on() {
  return self isnightvisionon();
}

function function_4d42ee8130c22006() {
  level.player endon("death");
  level.player endon("disconnect");
  level endon("game_ended");
  level.player endon("player_on_nvg");
  level waittill("flag_dungeon_intro_complete");
  wait 5;
  flag_waitopen_all_array(["objective_splash_onscreen", "other_splash_onscreen"]);
  var_55c83680627efe37 = 0;

  while(var_55c83680627efe37 < 15) {
    if(!player_nvg_on()) {
      if(level.player usinggamepad()) {
        scripts\cp\cp_hud_message::tutorialprint(&"CP_JUP_RANCH/NVG_DPAD", 3);
      } else {
        scripts\cp\cp_hud_message::tutorialprint(&"CP_JUP_RANCH/NVG_KBM", 3);
      }
    }

    wait 2;
    var_55c83680627efe37 += 5;
  }
}

function function_587cdfe8e3f8e79b() {
  level.player endon("death");
  level.player endon("disconnect");
  level endon("game_ended");

  while(true) {
    if(player_nvg_on()) {
      self notify("player_on_nvg");
      self notify("clear_tutorial_messages");
      waitframe();
      self clearhudtutorialmessage();
      return;
    }

    waitframe();
  }
}

function function_57912920f3ffc52b(teleport_struct) {
  flag_wait("player_spawned_with_loadout");
  checkpoint = scripts\cp\cp_checkpoint::checkpoint_get();
  checkpoint = ter_op(checkpoint != "", checkpoint, getDvar(@ "start"));

  if(checkpoint == "rescue_alex") {
    return;
  }

  spawner = getStruct("ally_scout_sniper", "targetname");
  ally = namespace_4c21e3c2da3d8585::spawn_alex(spawner, "ally_scout_sniper");
  ally visiblenotsolid();
  ally.name = "Alex";
  ally.team = "allies";
  ally.ignoreme = 1;
  ally.dontevershoot = 1;
  ally.goalradius = 1;
  ally set_movement_speed(220);
  ally.ignoreall = 1;
  ally.agentname = &"CP_JUP_RANCH/ALEX";
  ally.var_e0143f4f183d8a12 = 1;
  ally disableaimassist();
  ally.baseaccuracy = 1;
  ally.accuracy = ally.baseaccuracy;
  ally setengagementmindist(300, 200);
  ally setengagementmaxdist(4000, 7000);
  ally function_9215ce6fc83759b9(7000);
  ally.disablepistol = 1;
  primaryweaponhash = "iw9_dm_xmike2010, [ bar_sn_heavy_p20_xmike2010, laserbox_hip04 ], none, none";

  if(!isDefined(level.var_67b54180a55f70e1[primaryweaponhash])) {
    level.var_67b54180a55f70e1[primaryweaponhash] = scripts\cp\cp_weapon::function_e83615f8a92e4378("iw9_dm_xmike2010", ["bar_sn_heavy_p20_xmike2010", "laserbox_hip04"], "none", "none");
  }

  secondaryweaponhash = "iw9_sm_mpapa5_sp";

  if(!isDefined(level.var_67b54180a55f70e1[secondaryweaponhash])) {
    level.var_67b54180a55f70e1[secondaryweaponhash] = scripts\cp\cp_weapon::function_e83615f8a92e4378("iw9_sm_mpapa5_sp");
  }

  ally.weapon = level.var_67b54180a55f70e1[primaryweaponhash];
  ally giveweapon(ally.weapon);
  ally setspawnweapon(ally.weapon);
  ally.bulletsinclip = weaponclipsize(ally.weapon);
  ally.primaryweapon = ally.weapon;
  ally.weapon = level.var_67b54180a55f70e1[secondaryweaponhash];
  ally giveweapon(ally.weapon);
  ally.bulletsinclip = weaponclipsize(ally.secondaryweapon);
  ally.secondaryweapon = ally.weapon;
  ally allowedstances("crouch");
  ally scripts\common\ai::set_gunpose("ads");

  if(isDefined(teleport_struct)) {
    start_pos = function_7a18da6e48b71c35(teleport_struct);
    ally.origin = start_pos.origin;
  }

  level.ally = ally;
  level.ally hide();
  flag_set("ally_overwatch_created");
}

function function_1a36b4303dafa62() {
  level endon("blackbox_interacted");
  flag_wait("ally_overwatch_created");
  flag_wait("start_mission_flow");
  var_e7a262fc921cd1f2 = [getEnt("goal_vol_manor", "targetname"), getEnt("goal_vol_building_1", "targetname"), getEnt("goal_vol_building_2", "targetname")];
  interior_triggers = getEntArray("INTERIOR_TRIGGERS", "targetname");
  level.var_e7a262fc921cd1f2 = array_combine(var_e7a262fc921cd1f2, interior_triggers);
  level endon("end_ally_overwatch");
  var_3796fe8cf560b672 = getStruct("ally_scout_sniper", "targetname");
  contents = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_ainosight"]);
  var_a93fe0cfcd3db568 = undefined;
  level.var_ba93a89dd62a7de8 = [];
  level.var_2cbf7c46e18d45d8 = 0;
  flag_set("flag_dungeon_ranch_overwatch_enabled");
  thread function_e4447c9494b98b9a();
  thread function_f02483a63f2a588b();
  thread function_4e54a620b47d5cd();
  thread function_1261e355f265d546();
  thread function_bbd871da16e8e09c();
  flag_wait("active_combat_begun");
  wait 5;

  while(true) {
    wait 1;

    if(!flag("flag_dungeon_ranch_overwatch_enabled")) {
      continue;
    }

    if(flag("flag_ally_repositioning")) {
      continue;
    }

    if(isDefined(var_a93fe0cfcd3db568)) {
      var_aaecca81af75003b = var_a93fe0cfcd3db568 + 13000;

      if(gettime() < var_aaecca81af75003b) {
        continue;
      }
    }

    guys = getaiarray("axis");

    if(!isDefined(guys)) {
      continue;
    }

    if(function_eac0cd99c9c6d8ee() != "spotted") {
      continue;
    }

    if(level.shots_fired["ranch"] == 0) {
      continue;
    }

    if(flag("flag_ally_combat_delay")) {
      continue;
    }

    guys = array_remove(guys, level.ally);
    guys = array_removedead_or_dying(guys);
    guys = sortbydistance(guys, level.player.origin);
    var_93e1519594d97c9d = [];
    shoot_target = undefined;
    var_57a6f36ed19b10a6 = 0;

    foreach(guy in guys) {
      castend = guy gettagorigin("j_head");
      in_fov = within_fov(level.player getEye(), level.player getplayerangles(), castend, cos(namespace_1170726b2799ea65::function_1418dfaca3b1702a()));

      if(!in_fov) {
        continue;
      }

      if(guy.alertlevel != "combat") {
        continue;
      }

      var_4052761e50418935 = 0;

      foreach(vol in level.var_e7a262fc921cd1f2) {
        if(guy istouching(vol)) {
          var_4052761e50418935 = 1;
          break;
        }
      }

      if(istrue(var_4052761e50418935)) {
        continue;
      }

      if(!function_e301b7aa09acbb51(guy)) {
        continue;
      }

      if(getdvarint(@ "hash_7f43bb1bfcaba897", 0)) {
        thread function_cef11b93c9685345(guy, "white");
      }

      var_93e1519594d97c9d = function_6d6af8144a5131f1(var_93e1519594d97c9d, guy);
    }

    if(var_93e1519594d97c9d.size > 0) {
      foreach(enemy in var_93e1519594d97c9d) {
        var_b3c44708dfcab166 = function_2c6a90fe7e0daede(enemy);

        if(istrue(var_b3c44708dfcab166)) {
          if(getdvarint(@ "hash_7c1ccb5a923d4758", 0)) {
            thread function_cef11b93c9685345(enemy, "<dev string:x292>");
          }

          var_93e1519594d97c9d = array_remove(var_93e1519594d97c9d, enemy);
          break;
        }
      }
    }

    shoot_target = getclosest(level.player.origin, var_93e1519594d97c9d);
    var_7c1a7eb01bfc05a7 = sortbydistance(var_93e1519594d97c9d, level.player.origin);
    var_654a0d092e31678f = undefined;

    foreach(guy in var_7c1a7eb01bfc05a7) {
      if(function_e301b7aa09acbb51(guy) && within_fov(level.player getEye(), level.player getplayerangles(), guy gettagorigin("j_head"), cos(namespace_1170726b2799ea65::function_1418dfaca3b1702a()))) {
        var_654a0d092e31678f = guy;
        break;
      }
    }

    if(isDefined(var_654a0d092e31678f)) {
      shoot_target = guy;
    }

    if(!isDefined(shoot_target)) {
      continue;
    }

    shot_end = undefined;
    var_98ccb7441919420b = 0;
    var_e014aa33281c00d8 = 0.8;

    if(randomfloat(1) <= var_e014aa33281c00d8 && !var_57a6f36ed19b10a6) {
      var_98ccb7441919420b = 1;
      thread function_37bd1c32c1e3741b(shoot_target);
      shot_end = shoot_target gettagorigin("j_head");
    } else {
      shot_end = shoot_target gettagorigin("j_head") + (0, 0, 40);
    }

    if(flag("flag_ally_repositioning")) {
      continue;
    }

    if(getdvarint(@ "hash_7c1ccb5a923d4758", 0)) {
      thread function_cef11b93c9685345(shoot_target, "<dev string:x298>");
    }

    if(istrue(var_98ccb7441919420b)) {
      if(shoot_target scripts\cp\spawning::is_armored() || shoot_target namespace_4c21e3c2da3d8585::function_18109acd56066fbb()) {}

      namespace_4c21e3c2da3d8585::function_54ce77ef41ea9dcc(shoot_target);

      print3d(shot_end, "<dev string:x29c>", undefined, undefined, 0.7, 20);

      var_a93fe0cfcd3db568 = gettime();
    }
  }
}

function function_cef11b93c9685345(enemy, color) {
  enemy endon("death");
  enemy hudoutlineenable("outlinefill_nodepth_" + color);
  wait 0.5;
  enemy hudoutlinedisable();
}

function function_2c6a90fe7e0daede(enemy) {
  if(level.player worldpointinreticle_circle(enemy getEye(), namespace_1170726b2799ea65::function_1418dfaca3b1702a(), 115)) {
    return true;
  }

  if(level.player worldpointinreticle_circle(enemy.origin, namespace_1170726b2799ea65::function_1418dfaca3b1702a(), 115)) {
    return true;
  }

  var_2e3d6eea78f62507 = (enemy getEye() + enemy.origin) * 0.5;

  if(level.player worldpointinreticle_circle(var_2e3d6eea78f62507, namespace_1170726b2799ea65::function_1418dfaca3b1702a(), 115)) {
    return true;
  }

  return false;
}

function function_b8b03b085492e2b4(aiarray) {
  playereye = level.player getEye();
  var_f9da37799c4903b3 = scripts\engine\trace::ray_trace_detail(playereye, playereye + anglesToForward(level.player getgunangles()) * 99999, level.player)["entity"];
  var_357c938526b20c2 = undefined;
  var_d153c90cafe4aa37 = 2147483647;
  playerfov = namespace_1170726b2799ea65::function_1418dfaca3b1702a();
  playerforward = anglesToForward(level.player.angles);
  var_f477cf5c4aea6fd0 = anglesToForward(level.player getgunangles());

  foreach(ai in aiarray) {
    aieye = ai getEye();
    var_939c99e13b712828 = length(aieye - playereye);
    var_eff85b1b7dce4474 = aieye;
    var_94a15224c3a5c409 = level.player worldpointtoscreenpos(var_eff85b1b7dce4474, playerfov);

    if(!isDefined(var_94a15224c3a5c409)) {
      continue;
    }

    var_6c6e8f9a7ce22763 = level.player worldpointtoscreenpos(ai.origin, playerfov);

    if(!isDefined(var_6c6e8f9a7ce22763)) {
      continue;
    }

    if(!function_e301b7aa09acbb51(ai)) {
      continue;
    }

    var_dfba4f3905493878 = var_6c6e8f9a7ce22763[1] - var_94a15224c3a5c409[1];

    if(ai.currentpose == "prone") {
      var_cd12cbdcf0630571 = var_94a15224c3a5c409;
      var_2a2a9ee9c954ff1e = scripts\engine\math::get_mid_point(ai gettagorigin("J_Ball_LE"), ai gettagorigin("J_Ball_RI"));
      var_189e08181d4069e3 = level.player worldpointtoscreenpos(var_2a2a9ee9c954ff1e, playerfov);

      if(!isDefined(var_189e08181d4069e3)) {
        continue;
      }

      var_a2ee902c004e8487 = length2d(var_189e08181d4069e3 - var_cd12cbdcf0630571);
      var_f8c8bd71283e5e45 = var_dfba4f3905493878 * 1.98 * 0.5;
      var_3b419bec212c7f4a = var_a2ee902c004e8487 * 2 * 0.5;
    } else {
      var_f8c8bd71283e5e45 = var_dfba4f3905493878 * 1.25 * 0.5;
      var_3b419bec212c7f4a = var_dfba4f3905493878 * 0.9 * 0.5;
    }

    var_9d49b078d78455 = (var_6c6e8f9a7ce22763 + var_94a15224c3a5c409) * 0.5;
    var_2973e4f888a288f5 = var_9d49b078d78455[1] - var_f8c8bd71283e5e45;

    if(var_2973e4f888a288f5 >= 0) {
      continue;
    }

    var_4bb58d28251baf3b = var_9d49b078d78455[1] + var_f8c8bd71283e5e45;

    if(var_4bb58d28251baf3b <= 0) {
      continue;
    }

    var_4a8b76fdba5d05b2 = var_9d49b078d78455[0] + var_3b419bec212c7f4a;

    if(var_4a8b76fdba5d05b2 <= 0) {
      continue;
    }

    var_3dfc8967fdfcf321 = var_9d49b078d78455[0] - var_3b419bec212c7f4a;

    if(var_3dfc8967fdfcf321 >= 0) {
      continue;
    }

    if(true) {
      topline = newhudelem();
      topline.horzalign = "<dev string:x2ac>";
      topline.vertalign = "<dev string:x2b3>";
      topline.x = var_4a8b76fdba5d05b2 * -1;
      topline.y = var_2973e4f888a288f5;
      topline.sort = -1;
      topline.color = (0, 1, 0);
      topline setshader("<dev string:x2ba>", int(var_3b419bec212c7f4a * 2), 1);
      topline delaycall(0.15, &destroy);
      var_bba6682d8b042774 = newhudelem();
      var_bba6682d8b042774.horzalign = "<dev string:x2ac>";
      var_bba6682d8b042774.vertalign = "<dev string:x2b3>";
      var_bba6682d8b042774.x = var_4a8b76fdba5d05b2 * -1;
      var_bba6682d8b042774.y = var_4bb58d28251baf3b - 1;
      var_bba6682d8b042774.sort = -1;
      var_bba6682d8b042774.color = (0, 1, 0);
      var_bba6682d8b042774 setshader("<dev string:x2ba>", int(var_3b419bec212c7f4a * 2), 1);
      var_bba6682d8b042774 delaycall(0.15, &destroy);
      var_3cc245c6b88759de = newhudelem();
      var_3cc245c6b88759de.horzalign = "<dev string:x2ac>";
      var_3cc245c6b88759de.vertalign = "<dev string:x2b3>";
      var_3cc245c6b88759de.x = var_4a8b76fdba5d05b2 * -1;
      var_3cc245c6b88759de.y = var_2973e4f888a288f5;
      var_3cc245c6b88759de.sort = -1;
      var_3cc245c6b88759de.color = (0, 1, 0);
      var_3cc245c6b88759de setshader("<dev string:x2ba>", 1, int(var_f8c8bd71283e5e45 * 2));
      var_3cc245c6b88759de delaycall(0.15, &destroy);
      var_f8aa2f8f4db73cd3 = newhudelem();
      var_f8aa2f8f4db73cd3.horzalign = "<dev string:x2ac>";
      var_f8aa2f8f4db73cd3.vertalign = "<dev string:x2b3>";
      var_f8aa2f8f4db73cd3.x = var_3dfc8967fdfcf321 * -1 - 1;
      var_f8aa2f8f4db73cd3.y = var_2973e4f888a288f5;
      var_f8aa2f8f4db73cd3.sort = -1;
      var_f8aa2f8f4db73cd3.color = (0, 1, 0);
      var_f8aa2f8f4db73cd3 setshader("<dev string:x2ba>", 1, int(var_f8c8bd71283e5e45 * 2));
      var_f8aa2f8f4db73cd3 delaycall(0.15, &destroy);
    }

    var_aac98045cac39195 = ai.origin - ai.velocity;
    var_6f7a384f90ea3798 = vectorNormalize(var_aac98045cac39195 - playereye);
    var_b67e98fb220e1f72 = vectorNormalize(ai.origin - playereye);
    var_21335cd4c8c1cc1 = var_b67e98fb220e1f72 - var_6f7a384f90ea3798;
    var_7695451d2a4da8d6 = anglestoaxis(level.player getgunangles());
    var_f477cf5c4aea6fd0 = var_7695451d2a4da8d6["forward"];
    var_1c6b2d3155d4c0df = var_7695451d2a4da8d6["right"];
    var_9e68309fab957e = var_7695451d2a4da8d6["up"];
    var_a139abd5309c5752 = scripts\engine\math::scalar_projection(var_1c6b2d3155d4c0df, var_21335cd4c8c1cc1);
    var_cdf5485d10a5e9df = scripts\engine\math::scalar_projection(var_9e68309fab957e, var_21335cd4c8c1cc1);
    var_a5a1d18d38578012 = (var_a139abd5309c5752, var_cdf5485d10a5e9df, 0);
    var_971050504390a48e = length(var_9d49b078d78455);

    if(var_971050504390a48e < var_d153c90cafe4aa37) {
      var_357c938526b20c2 = ai;
      var_d153c90cafe4aa37 = var_971050504390a48e;
    }
  }

  return var_357c938526b20c2;
}

function function_e301b7aa09acbb51(ai) {
  tracestart = level.player getEye();
  var_e2fc3046576e18ea = ai getEye() + (0, 0, 15);

  if(sighttracepassed(tracestart, var_e2fc3046576e18ea, 0, level.player, 1)) {
    return true;
  }

  if(sighttracepassed(tracestart, ai.origin + (0, 0, 15), 0, level.player, 1)) {
    return true;
  }

  if(sighttracepassed(tracestart, ai gettagorigin("j_shoulder_le"), 0, level.player, 1)) {
    return true;
  }

  if(sighttracepassed(tracestart, ai gettagorigin("j_shoulder_ri"), 0, level.player, 1)) {
    return true;
  }

  if(sighttracepassed(tracestart, ai gettagorigin("j_elbow_le"), 0, level.player, 1)) {
    return true;
  }

  if(sighttracepassed(tracestart, ai gettagorigin("j_elbow_ri"), 0, level.player, 1)) {
    return true;
  }

  var_2e3d6eea78f62507 = (var_e2fc3046576e18ea + ai.origin) * 0.5;

  if(sighttracepassed(tracestart, var_2e3d6eea78f62507, 0, level.player, 1)) {
    return true;
  }

  return false;
}

function getplayersinradiusview(origin, radius, desiredteam, excludeent) {
  var_305f0639560a5707 = [];
  playersinradius = getplayersinradius(origin, radius, desiredteam, excludeent);

  foreach(player in playersinradius) {
    structcreated = undefined;
    tracepoints = [player gettagorigin("j_head"), player gettagorigin("j_mainroot"), player gettagorigin("tag_origin")];

    for(i = 0; i < tracepoints.size; i++) {
      if(!scripts\engine\trace::ray_trace_passed(origin, tracepoints[i], level.characters, scripts\engine\trace::create_contents(0, 1, 1, 1, 1, 1))) {
        continue;
      }

      if(!isDefined(structcreated)) {
        var_305f0639560a5707[var_305f0639560a5707.size] = spawnStruct();
        var_305f0639560a5707[var_305f0639560a5707.size - 1].player = player;
        var_305f0639560a5707[var_305f0639560a5707.size - 1].visiblelocations = [];
        structcreated = 1;
      }

      var_305f0639560a5707[var_305f0639560a5707.size - 1].visiblelocations[var_305f0639560a5707[var_305f0639560a5707.size - 1].visiblelocations.size] = tracepoints[i];
    }
  }

  return var_305f0639560a5707;
}

function function_581b69a0b787b8a5(guys) {
  guys = sortbydistance(guys, level.player.origin);

  foreach(guy in guys) {
    can_see = level.ally function_ca53f38b1eb70113(guy getEye(), 0, 4000);

    if(can_see) {
      return guy;
    }
  }

  return guys[0];
}

function function_e4447c9494b98b9a() {
  level.player endon("death");
  level endon("end_ally_overwatch");
  level endon("game_ended");

  while(true) {
    wait 0.25;

    if(level.player.health < 50) {
      flag_set("flag_dungeon_RANCH_player_low_health");
      continue;
    }

    flag_clear("flag_dungeon_RANCH_player_low_health");
  }
}

function function_37bd1c32c1e3741b(var_662f372e4d310c25) {
  level endon("end_ally_overwatch");
  level endon("game_ended");
  results = var_662f372e4d310c25 waittill_any_timeout_1(4, "death");

  if(is_equal(results, "timeout")) {
    return;
  }

  level notify("ally_overwatch_kill");
}

function function_f02483a63f2a588b() {
  level endon("game_ended");
  level endon("end_ally_overwatch");
  var_e18fa49f7e6a8dbc = utility::create_deck(["dx_cp_rnch_assp_alex_haventlostmytouch", "dx_cp_rnch_assp_alex_gotthatoneforyakilo", "dx_cp_rnch_assp_alex_droppedhim", "dx_cp_rnch_assp_alex_gotyourback", "dx_cp_rnch_assp_alex_thatonesonme", "dx_cp_rnch_assp_alex_downedhim", "dx_cp_rnch_assp_alex_yourewelcome", "dx_cp_rnch_assp_alex_goodfuckineffectonta", "dx_cp_rnch_assp_alex_lovekillingmesomekon"]);
  var_e4a70a41aeb36d90 = utility::create_deck(["dx_cp_rnch_alsn_alex_ivegotyourback", "dx_cp_rnch_alsn_alex_gothim", "dx_cp_rnch_alsn_alex_baggedhim", "dx_cp_rnch_alsn_alex_downedthatone", "dx_cp_rnch_alsn_alex_gotthatone", "dx_cp_rnch_alsn_alex_covering", "dx_cp_rnch_alsn_alex_downedhimforyou", "dx_cp_rnch_alsn_alex_droppedone", "dx_cp_rnch_alsn_alex_dispatched", "dx_cp_rnch_alsn_alex_terminated", "dx_cp_rnch_alsn_alex_eliminated", "dx_cp_rnch_alsn_alex_tangodown", "dx_cp_rnch_alsn_alex_threatneutralized", "dx_cp_rnch_alsn_alex_konnidown", "dx_cp_rnch_alsn_alex_burnedanother", "dx_cp_rnch_alsn_alex_tookanotherout", "dx_cp_rnch_alsn_alex_dontmindifido"]);
  count = 0;
  alias = "";

  while(true) {
    level waittill("ally_overwatch_kill");

    if(function_1bb1470f934a81eb()) {
      alias = var_e4a70a41aeb36d90 deck_draw();
    } else {
      alias = var_e18fa49f7e6a8dbc deck_draw();
    }

    wait 0.25;
    level.player function_fc0eb6b81c66c661(0.5, alias, 0, 1);
  }
}

function function_bbd871da16e8e09c() {
  level endon("end_ally_overwatch");
  level endon("game_ended");
  flag_wait("active_combat_begun");

  while(true) {
    stealth_status = level waittill_any_return_2("back_in_combat", "back_in_stealth");

    if(stealth_status == "back_in_stealth") {
      if(function_eac0cd99c9c6d8ee() == "spotted") {
        continue;
      }

      level.var_2cbf7c46e18d45d8++;

      if(level.var_2cbf7c46e18d45d8 >= level.var_ba93a89dd62a7de8.size) {
        level.var_2cbf7c46e18d45d8 = 0;
      }

      thread function_40c23dd13d90dbf1("flag_ally_repositioning", 12);
      level notify("ally_reposition");
      continue;
    }

    if(stealth_status == "back_in_combat") {
      thread function_40c23dd13d90dbf1("flag_ally_combat_delay", 8);
    }
  }
}

function function_40c23dd13d90dbf1(var_799bebae5bb7d70e, timeout) {
  flag_set(var_799bebae5bb7d70e);
  wait timeout;
  flag_clear(var_799bebae5bb7d70e);
}

function function_1261e355f265d546() {
  level endon("game_ended");
  level endon("end_ally_overwatch");

  while(true) {
    flag_wait("stealth_enabled");

    if(!flag("active_combat_begun")) {
      flag_wait("active_combat_begun");
      wait 3;

      while(function_eac0cd99c9c6d8ee() == "spotted") {
        waitframe();
      }
    } else {
      function_596f7ba9fd709c5d(1);
    }

    level notify("back_in_stealth");
    scripts\cp\coop_stealth::function_52d8a3ce21f0dfe8("ranch");

    if(!flag("stealth_enabled")) {
      continue;
    }

    function_4326dd7de6e87a4e(1);
    level notify("back_in_combat");

    if(!flag("stealth_enabled")) {
      continue;
    }

    waittillframeend();
  }
}

function function_596f7ba9fd709c5d(timeslice) {
  level endon("game_ended");
  level endon("end_ally_overwatch");

  while(!scripts\stealth\utility::any_groups_in_combat()) {
    wait timeslice;
  }
}

function function_4326dd7de6e87a4e(timeslice) {
  level endon("game_ended");
  level endon("end_ally_overwatch");

  while(scripts\stealth\utility::any_groups_in_combat()) {
    wait timeslice;
  }
}

function function_4e54a620b47d5cd() {
  level endon("game_ended");
  level endon("end_ally_overwatch");
  level.var_1e4159c964f93da2 = 0;
  level.var_ba93a89dd62a7de8[0] = utility::create_deck(["dx_cp_rnch_alrp_alex_konnimightbeontomeim", "dx_cp_rnch_alrp_alex_thinkkonnisgettingsu", "dx_cp_rnch_alrp_alex_couplekonnilookingmy", "dx_cp_rnch_alrp_alex_thinkioverstayedmywe", "dx_cp_rnch_alrp_alex_konnimightbecatching", "dx_cp_rnch_alrp_alex_couplekonniglancingm", "dx_cp_rnch_alrp_alex_mypositionmightbecom", "dx_cp_rnch_alrp_alex_lostmyvisualonyoukil", "dx_cp_rnch_alrp_alex_lostvisualwillrepo", "dx_cp_rnch_alrp_alex_cantseeyoufromherefa", "dx_cp_rnch_alrp_alex_noeyesonyoufromherek", "dx_cp_rnch_alrp_alex_repositioningforabet", "dx_cp_rnch_alrp_alex_lostvisualrelocating"]);
  level.var_ba93a89dd62a7de8[1] = utility::create_deck(["dx_cp_rnch_alr2_alex_konnisscanningthehil", "dx_cp_rnch_alr2_alex_gotakonnisquadlookin", "dx_cp_rnch_alr2_alex_konnimightknowwherei", "dx_cp_rnch_alr2_alex_konnistryingtosniffm", "dx_cp_rnch_alr2_alex_konnishuntingformeim", "dx_cp_rnch_alr2_alex_couplesquadsheadingm", "dx_cp_rnch_alr2_alex_ithinkkonnisontomemo"]);
  level.var_ba93a89dd62a7de8[2] = utility::create_deck(["dx_cp_rnch_alr3_alex_gotalotofkonniuphere", "dx_cp_rnch_alr3_alex_konniknowswhereiamre", "dx_cp_rnch_alr3_alex_konnissendingafullsq", "dx_cp_rnch_alr3_alex_konnisgettingtooclos", "dx_cp_rnch_alr3_alex_gotkonnisearchingfor", "dx_cp_rnch_alr3_alex_konniscloseonmyposit", "dx_cp_rnch_alr3_fara_securingatrap", "dx_cp_rnch_alr3_fara_disarmingatrap", "dx_cp_rnch_alr3_fara_hackingatrap", "dx_cp_rnch_alr3_fara_securingatrap_01", "dx_cp_rnch_alr3_fara_disarmingatrap_01", "dx_cp_rnch_alr3_fara_disablingatrap"]);
  alias = "";

  while(true) {
    level waittill("ally_reposition");

    if(flag("obj_search_completed")) {
      return;
    }

    if(!scripts\engine\utility::time_has_passed(level.var_1e4159c964f93da2, 12)) {
      waitframe();
      continue;
    }

    alias = level.var_ba93a89dd62a7de8[level.var_2cbf7c46e18d45d8] deck_draw();
    wait 1;
    said = level.player function_fc0eb6b81c66c661(0.5, alias, 0, 1);

    if(istrue(said)) {
      level.var_1e4159c964f93da2 = gettime();
    }
  }
}

function function_e7c30095a6cdc3ef(position) {
  if(!isDefined(level.player)) {
    return false;
  }

  in_fov = within_fov(level.player getEye(), level.player getplayerangles(), position, cos(namespace_1170726b2799ea65::function_1418dfaca3b1702a()));

  if(!in_fov) {
    return false;
  }

  contents = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_ainosight"]);
  castresult = physics_raycast(level.player getEye(), position, contents, undefined, 0, "physicsquery_closest", 0);

  if(isDefined(castresult) && castresult.size > 0) {
    return false;
  }

  return true;
}

function function_18109acd56066fbb() {
  aitype = scripts\cp\spawning::function_2ee1dc768d1a4703(self.spawnpoint);

  if(issubstr(aitype, "_t3_") || issubstr(aitype, "_tier3_")) {
    return true;
  }

  return false;
}

function function_54ce77ef41ea9dcc(guy) {
  level endon("end_ally_overwatch");
  thread function_b28047f36bd9d715(guy);
  wait 0.5;

  if(!isalive(guy) && guy.lastattacker == level.player) {
    return false;
  }

  guy_eye = guy getEye();
  num = randomintrange(1, 7);
  thread play_sound_in_space("generic_explodeath_enemy_" + num, guy_eye);
  magicbullet(level.alex.weapon, level.alex getshootfrompos(), guy_eye, level.alex, level.alex);
  playFX(level._effect["human_gib_head"], guy_eye);
  waitframe();

  if(isalive(guy)) {
    guy kill(guy_eye, level.ally);
  }

  wait 0.7;
  return true;
}

function function_d084bbbdcf7f2853() {
  self.lasertag = spawn("script_model", (0, 0, 0));
  self.lasertag setModel("tag_laser");
  self.lasertag notsolid();
  temp = makeweapon("iw9_armored_enemy_laser_cp");
  self.lasertag setmoverlaserweapon(temp);
  var_52a0c5f3380b4694 = getStructArray("laser_struct", "targetname");
  function_2a227bf43b1b2354(["alex_laser_targetting"]);
  self.turrets = [];

  foreach(laser in var_52a0c5f3380b4694) {
    turret = namespace_84c374d417dc82cf::setup_sentry(laser, undefined, undefined, self, "alex_laser_targetting");
    turret notify("stop_idle_movement");
    self.turrets = array_add(self.turrets, turret);
    turret hide();
  }
}

function function_437b1223a35a3e4d(var_90784eeaf26d3f22) {
  foreach(turret in self.turrets) {
    if(namespace_4c21e3c2da3d8585::function_f610c036d3cfc4ed(turret, var_90784eeaf26d3f22)) {
      turret show();
      return turret;
    }
  }

  var_dd21d0330af2362f = getclosest(self.origin, self.turrets);
  var_dd21d0330af2362f show();
  return var_dd21d0330af2362f;
}

function function_b28047f36bd9d715(guy) {
  level endon("end_ally_overwatch");

  if(!isDefined(level.alex.lasertag)) {
    level.alex function_d084bbbdcf7f2853();
  }

  lasertag = level.alex.lasertag;
  var_ff8224b52138466c = 10;
  var_dd21d0330af2362f = level.alex function_437b1223a35a3e4d(guy);

  if(!isDefined(var_dd21d0330af2362f)) {
    var_dd21d0330af2362f = getclosest(level.player.origin, level.alex.turrets);
    var_dd21d0330af2362f show();
  }

  thread namespace_9faa61bf1903f9b8::function_53669ce4cec22991(var_dd21d0330af2362f, guy);

  for(i = 0; i < var_ff8224b52138466c; i++) {
    from = level.alex gettagorigin("tag_flash");
    lasertag.origin = from;
    start = guy.origin;
    end = guy getEye();
    normalizedtime = scripts\engine\math::normalize_value(0, var_ff8224b52138466c, i);
    endvector = scripts\engine\math::factor_value(guy.origin, guy getEye(), normalizedtime);
    to = endvector;
    level.var_d950088294f8fef4 = to;
    lasertag.angles = vectortoangles(to - from);
    waitframe();
    var_dd21d0330af2362f.targetent.origin = level.var_d950088294f8fef4;

    if(i == 0) {
      lasertag laserforceon();
      var_c76d765bc10fd0d = vectorNormalize(level.var_d950088294f8fef4 - from);
      var_19236043c1720782 = vectorcross(var_c76d765bc10fd0d, (0, 0, 1));
      var_1c8061c31d6046ad = vectorcross(var_19236043c1720782, var_c76d765bc10fd0d);
    }
  }

  targetorigin = guy getEye();
  var_8e1060ec0682d1af = targetorigin;
  seconds = 1;
  frames = seconds * 20;

  for(i = 0; i < frames; i++) {
    from = level.alex gettagorigin("tag_flash");
    lasertag.origin = from;
    to = isalive(guy) ? guy getEye() : var_8e1060ec0682d1af;
    to += scripts\engine\utility::randomvectorrange(1, 2);
    level.var_d950088294f8fef4 = to;
    lasertag.angles = vectortoangles(to - from);
    var_dd21d0330af2362f.targetent.origin = level.var_d950088294f8fef4;
    waitframe();
  }

  zoffset = 12;
  var_61aba1c4b2487ad0 = zoffset;
  accel = 0;

  for(i = 0; i < 40; i++) {
    from = level.alex gettagorigin("tag_flash");
    lasertag.origin = from;
    to = var_8e1060ec0682d1af + (0, 0, var_61aba1c4b2487ad0);
    to += scripts\engine\utility::randomvectorrange(1, 2);
    lasertag.angles = vectortoangles(to - from);
    waitframe();
    accel += 3;
    var_61aba1c4b2487ad0 += zoffset + accel;
    var_dd21d0330af2362f.targetent.origin = to;
  }

  if(isDefined(self.fx_thermal)) {
    self.fx_thermal delete();
  }

  lasertag laserforceoff();
  level notify("end_laser_sequence");
  var_dd21d0330af2362f hide();
}

function function_906082ab22ccb3cb() {
  level endon("game_ended");
  random_line = "";
  convo = [];
  start = level.start_point;

  if(isDefined(start) && start == "rescue_alex") {
    flag_set("alex_captured_sequence_vo");
    wait 2;
    flag_clear("alex_captured_sequence_vo");
  } else {
    if(function_1bb1470f934a81eb()) {
      random_line = random(["dx_cp_rnch_rnez_alex_thatsallweneededfara", "dx_cp_rnch_rnez_alex_nosignalsleftwhatgot"]);
      convo = [ &function_9456cbcf80e3a624, random_line, &function_9456cbcf80e3a624, 0.8, "dx_cp_rnch_rnez_fara_letsgetoffthexwellli", &function_9456cbcf80e3a624, 0.3, "dx_cp_rnch_rnez_alex_copythatcommander"];
      var_5bca5ff13be12708 = [ &function_9456cbcf80e3a624, 1.3, "dx_cp_rnch_rnez_alex_kiloigotaproblem", &function_9456cbcf80e3a624, 0.4, "dx_cp_rnch_rnez_fara_copywhatisit", &function_9456cbcf80e3a624, 0.4, "dx_cp_rnch_rnez_alex_gotkonniconvergingon"];
      var_b39e8d8b9a7a4f4 = [ &function_9456cbcf80e3a624, "dx_cp_rnch_rnez_fara_alexwhereareyou", &function_9456cbcf80e3a624, "dx_cp_rnch_rnez_fara_31howcopyecho31doyou", &function_9456cbcf80e3a624, 0.8, "dx_cp_rnch_rnez_alex_contacttheyreonme", &function_9456cbcf80e3a624, 0.3, "dx_cp_rnch_rnez_alex_farahgogetoutofheren", &function_9456cbcf80e3a624, 0.5, "dx_cp_rnch_rnez_fara_noalexillfindyou"];
    } else {
      random_line = random(["dx_cp_rnch_rnes_alex_thatsallweneededfara", "dx_cp_rnch_rnes_alex_nosignalsleftwegotwh"]);
      convo = [ &function_9456cbcf80e3a624, random_line, &function_9456cbcf80e3a624, 1, "dx_cp_rnch_rnes_fara_letsgetoffthexwelink", &function_9456cbcf80e3a624, 0.5, "dx_cp_rnch_rnes_alex_copythatcommander", &function_9456cbcf80e3a624];
      var_5bca5ff13be12708 = [ &function_9456cbcf80e3a624, 1.3, "dx_cp_rnch_rnes_alex_kiloigotaproblem", &function_9456cbcf80e3a624, 0.4, "dx_cp_rnch_rnes_fara_copywhatisit", &function_9456cbcf80e3a624, 0.4, "dx_cp_rnch_rnes_alex_gotkonniconvergingon"];
      var_b39e8d8b9a7a4f4 = [ &function_9456cbcf80e3a624, "dx_cp_rnch_rnes_fara_alexwhereareyou", &function_9456cbcf80e3a624, "dx_cp_rnch_rnes_fara_31howcopyecho31doyou", &function_9456cbcf80e3a624, 0.5, "dx_cp_rnch_rnes_alex_contacttheyreonme", &function_9456cbcf80e3a624, 0.4, "dx_cp_rnch_rnes_alex_farahgogetoutofheren", &function_9456cbcf80e3a624, 0.5, "dx_cp_rnch_rnes_fara_noalexillfindyou"];
    }

    flag_set("alex_captured_sequence_vo");
    level.player say_sequence(convo, 1, 0, 0, 0, "team", &function_998637aa231bf89d);
    wait 4;

    if(!flag("alex_guards_were_attacked")) {
      level.player say_sequence(var_5bca5ff13be12708, 1, 0, 0, 0, "team", &function_998637aa231bf89d);
      thread namespace_9faa61bf1903f9b8::function_f93ac0b6a493f09e();
      level.player say_sequence(var_b39e8d8b9a7a4f4, 1, 0, 0, 0, "team", &function_998637aa231bf89d);
    }

    flag_clear("alex_captured_sequence_vo");
  }

  flag_wait("hostage_ai_goto_combat");
  childthread function_4dd77880649db453();
  flag_clear("alex_captured_sequence_post_spawn_vo");
}

function function_9456cbcf80e3a624() {
  if(flag("alex_guards_were_attacked") || flag("hostage_ai_goto_combat")) {
    return false;
  }

  return true;
}

function function_998637aa231bf89d() {
  if(flag("alex_guards_were_attacked")) {
    return 0;
  }
}

function function_4dd77880649db453() {
  level endon("alex_guards_were_attacked");

  if(flag("alex_guards_were_attacked")) {
    return;
  }

  if(isDefined(level.var_87a24dcbeb99b940) && level.var_87a24dcbeb99b940.size == 0) {
    return;
  }

  foreach(guy in level.var_87a24dcbeb99b940) {
    if(isalive(guy)) {
      enemy_speaker = guy;
      break;
    }
  }

  enemy_speaker endon("death");
  enemy_speaker say_global("dx_cp_rnch_rnes_kgfc_getonyourknees", 1, 0, 0, 0);
  enemy_speaker say_global("dx_cp_rnch_rnes_kgfc_theremorethanoneofyo", 1, 0, 0, 0.4);
  level.alex say_team("dx_cp_rnch_rnes_alex_imalonetheresnooneel", 1, 0, 0, 0.3);
  enemy_speaker say_global("dx_cp_rnch_rnes_kgfc_hesamerican", 1, 0, 0, 0.5);
  enemy_speaker say_global("dx_cp_rnch_rnes_ktrp_howdidtheygethere", 1, 0, 0, 0.3);
  enemy_speaker say_global("dx_cp_rnch_rnes_kgfc_wherearetheothers", 1, 0, 0, 0.2);
  level.alex say_team("dx_cp_rnch_rnes_alex_therearenoothersonly", 1, 0, 0, 0.5);
  enemy_speaker say_global("dx_cp_rnch_rnes_kgfc_whereisyourunit", 1, 0, 0, 0.3);
}

function function_d3d3694243fab89e(lasertag, guy) {
  level endon("game_ended");
  level endon("end_ally_overwatch");
  level endon("end_laser_sequence");
  guy endon("death");
  self.fx_thermal = playfxontagsbetweenclients(level._effect["vfx_laser_pointer"], lasertag, "tag_laser", guy, "tag_origin", level.player);

  if(isDefined(self.fx_thermal)) {
    self.fx_thermal forcenetfieldhighlod(1);
  }

  while(true) {
    startpos = lasertag.origin;
    to = level.var_d950088294f8fef4;

    if(getdvarint(@ "hash_7c1ccb5a923d4758", 0)) {
      thread drawsphere(startpos, 10, 0.05, (1, 0, 0));
      thread drawsphere(to, 10, 0.05, (0, 1, 0));
    }

    waitframe();
  }
}

function recorder_house_sentry() {
  flag_wait("flag_dungeon_intro_complete");
  var_6e7032bc1694f593 = utility::getStruct("recorder_house_sentry", "targetname");
  var_6e7032bc1694f593.var_2108ba0559bdaaff = &namespace_4848403b6f5b0da0::function_5e66cae8a3e9f368;
  var_eb0ad382dcbc2e63 = namespace_4848403b6f5b0da0::setup_enemy_sentry(var_6e7032bc1694f593);
  var_eb0ad382dcbc2e63 waittill("hacked");
  function_edd7c7c3c333611();
}

function function_c02941e07491127e(alias, var_f8c085fc89a3d57a, priority, timeout, overlap, delay, scope) {
  said = undefined;

  if(function_1bb1470f934a81eb()) {
    if(isDefined(var_f8c085fc89a3d57a)) {
      said = say(var_f8c085fc89a3d57a, priority, timeout, overlap, delay, scope);
    } else {
      return;
    }
  } else {
    said = say(alias, priority, timeout, overlap, delay, scope);
  }

  return said;
}

function function_5566ac041b7b0778() {
  if(!isDefined(level.var_9d5d088e5be65970)) {
    level.var_7112fc7583c654b7 = {
      #targetname: "flattop", #script_noteworthy: "building_struct", #angles: (0, 0, 0), #origin: (1118, -254, 11)
    };
    level.var_81895d45a6276051 = {
      #targetname: "ranchhouse", #script_noteworthy: "building_struct", #angles: (0, 0, 0), #origin: (1461, 1861, 89)
    };
    level.var_99a314038ed69107 = {
      #targetname: "twochimneys", #script_noteworthy: "building_struct", #angles: (0, 0, 0), #origin: (-762, 658, 16)
    };
  }

  struct = getcloseststruct(self.origin, "building_struct");

  if(!isDefined(struct)) {
    return;
  }

  return struct.targetname;
}

function function_319ffcfe3a782858() {
  level endon("game_ended");
  trigger = getEnt("recorder_door_trigger", "targetname");
  trigger trigger_off();
  flag_wait("obj_phones_completed");
  trigger trigger_on();
  trigger waittill("trigger");
  level.var_319ffcfe3a782858 = function_6149b301ce19988b("stealth_ai_recorder", &function_b863dcd61d90ee40);
  wait 0.5;
  doors = getentitylessscriptablearray(undefined, undefined, (1763, 1829, 100), 56, "door");

  foreach(door in doors) {
    door setscriptablepartstate("door", "bash_left_90");
    door.blocked = undefined;
    door.var_a16669fdd0578e00 = 1;
  }
}

function function_9e29987a3ba34738(tracerfx, tracehit, var_c76d765bc10fd0d, var_1c8061c31d6046ad, numshots) {
  self endon("death");
  level endon("end_ally_overwatch");
  var_4648b75503218e34 = 0;
  var_684fc496fbbee4d5 = ter_op(isDefined(numshots), numshots, 0);

  while(var_4648b75503218e34 < var_684fc496fbbee4d5) {
    randomoffsetx = 0;
    randomoffsety = 0;
    playFX(tracerfx, tracehit + (randomoffsetx, randomoffsety, 0), var_c76d765bc10fd0d, var_1c8061c31d6046ad);
    var_4648b75503218e34++;
    wait 0.05;
  }
}

function damage_debug() {
  wait 6;

  while(true) {
    [enemy] = getaiarray("axis");

    if(!isDefined(enemy)) {
      break;
    }

    enemy waittill("damage", damage);

    iprintlnbold(damage);
  }
}

function function_2a227bf43b1b2354(var_52a0c5f3380b4694) {
  foreach(noteworthy in var_52a0c5f3380b4694) {
    level.sentrysettings[noteworthy] = spawnStruct();
    level.sentrysettings[noteworthy].health = 999999;
    level.sentrysettings[noteworthy].maxhealth = 350;
    level.sentrysettings[noteworthy].burstmin = 20;
    level.sentrysettings[noteworthy].burstmax = 120;
    level.sentrysettings[noteworthy].pausemin = 0.15;
    level.sentrysettings[noteworthy].pausemax = 0.35;
    level.sentrysettings[noteworthy].maxrange = 4000000;
    level.sentrysettings[noteworthy].laserrange = 7562500;
    level.sentrysettings[noteworthy].lockstrength = 2;
    level.sentrysettings[noteworthy].sentrymodeon = "manual";
    level.sentrysettings[noteworthy].sentrymodeoff = "sentry_offline";
    level.sentrysettings[noteworthy].ammo = 200;
    level.sentrysettings[noteworthy].timeout = 999999;
    level.sentrysettings[noteworthy].spinuptime = 0.65;
    level.sentrysettings[noteworthy].overheattime = 8;
    level.sentrysettings[noteworthy].cooldowntime = 0.1;
    level.sentrysettings[noteworthy].fxtime = 0.3;
    level.sentrysettings[noteworthy].streakname = "sentry_gun";
    level.sentrysettings[noteworthy].weaponinfo = "laser_trap_ranch";
    level.sentrysettings[noteworthy].playerweaponinfo = "laser_trap_ranch";
    level.sentrysettings[noteworthy].scriptable = "ks_sentry_turret_mp";
    level.sentrysettings[noteworthy].modelbasecover = "electronics_ir_laser_device_assembly_nogeo";
    level.sentrysettings[noteworthy].modelbaseground = "electronics_ir_laser_device_assembly_nogeo";
    level.sentrysettings[noteworthy].modeldestroyedcover = "electronics_ir_laser_device_assembly_nogeo";
    level.sentrysettings[noteworthy].modeldestroyedground = "electronics_ir_laser_device_assembly_nogeo";
    level.sentrysettings[noteworthy].placementhintstring = &"KILLSTREAKS_HINTS/SENTRY_GUN_PLACE";
    level.sentrysettings[noteworthy].ownerusehintstring = &"KILLSTREAKS_HINTS/SENTRY_USE";
    level.sentrysettings[noteworthy].otherusehintstring = &"KILLSTREAKS_HINTS/SENTRY_OTHER_USE";
    level.sentrysettings[noteworthy].dismantlehintstring = &"KILLSTREAKS_HINTS/SENTRY_DISMANTLE";
    level.sentrysettings[noteworthy].headicon = 1;
    level.sentrysettings[noteworthy].teamsplash = "used_sentry_gun";
    level.sentrysettings[noteworthy].destroyedsplash = "callout_destroyed_sentry_gun";
    level.sentrysettings[noteworthy].shouldsplash = 1;
    level.sentrysettings[noteworthy].votimeout = "sentry_shock_timeout";
    level.sentrysettings[noteworthy].vodestroyed = "sentry_shock_destroy";
    level.sentrysettings[noteworthy].scorepopup = "destroyed_sentry";
    level.sentrysettings[noteworthy].lightfxtag = "tag_fx";
    level.sentrysettings[noteworthy].iskillstreak = 1;
    level.sentrysettings[noteworthy].headiconoffset = (0, 0, 75);
    level.sentrysettings[noteworthy].modelbasecover = "electronics_ir_laser_device_assembly_rig_skeleton";
    level.sentrysettings[noteworthy].modelbaseground = "electronics_ir_laser_device_assembly_rig_skeleton";
    level.sentrysettings[noteworthy].modeldestroyedcover = "electronics_ir_laser_device_assembly_rig_skeleton";
    level.sentrysettings[noteworthy].modeldestroyedground = "electronics_ir_laser_device_assembly_rig_skeleton";
  }
}

function function_d68d98760105e4f9(origin, ent) {
  while(true) {
    line(origin, ent.origin);
    waitframe();
  }
}

function function_11f26c1850a16bf9(origin) {
  range = 4;

  while(true) {
    line(origin - (0, 0, range), origin + (0, 0, range));
    line(origin - (0, range, 0), origin + (0, range, 0));
    line(origin - (range, 0, 0), origin + (range, 0, 0));
    waitframe();
  }
}

function _ontabletputaway(streakinfo) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  scripts\cp_mp\equipment_interact::_ontabletputaway(streakinfo);
}

function function_b76f40a3f74c7382() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("interact_cancelled");

  while(istrue(self.var_95404f4af3770f63)) {
    waitframe();
  }
}

function function_ed9354f51804b6c1(streakinfo) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("interact_cancelled");

  if(streakinfo.interactstate != 0) {
    return;
  }

  self waittill("interact_finished");

  while(istrue(self.var_95404f4af3770f63)) {
    waitframe();
  }

  flag_clear("equipment_interact");

  if(streakinfo.interactstate == 2) {
    successtime = getdvarfloat(@ "hash_f1b36a05bc8c07af", 0.5);
    wait successtime;
  }
}

function function_30f81397557291da() {
  self.var_95404f4af3770f63 = 1;
  self.var_a7c3d72d12591063 = gettime();
  setDvar(@ "hash_d3ee5a6578fe61de", 0);
  movie = "cp_jup_ranch_cine_phone01";

  switch (level.var_660132cc97da2719) {
    case 1:
      movie = "cp_jup_ranch_cine_phone02";
      break;
    case 2:
      movie = "cp_jup_ranch_cine_phone03";
      break;
  }

  playcinematicforall(movie);
}

function function_e040d639d0b95e42() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("interact_cancelled");

  while(self useButtonPressed() && gettime() <= self.var_a7c3d72d12591063 + 4600) {
    waitframe();
  }

  self.var_95404f4af3770f63 = undefined;
  stopcinematicforall(1);
  wait 0.5;
  self setclientomnvar("ui_hack_index", 0);
  setDvar(@ "hash_d3ee5a6578fe61de", 1);
}

function function_83ba9b6ffc39e72a() {
  level endon("alex_ack_farah_vo");
  level.alex.ignoreall = 1;
  level.alex.ignoreme = 1;
  level.alex.dontevershoot = 1;
  level.alex scripts\engine\utility::set_movement_speed(150);
  level.alex demeanoroverride("alert");
  level.alex scripts\common\utility::lookatentity(level.player, 1);
  level.alex function_9215ce6fc83759b9(1);
  level.alex scripts\common\ai::set_gunpose("gun_down");
  level.alex.gunposeoverride = "gun_down";
  level.alex.gunposeoverride_internal = "gun_down";
  thread function_64c14317b3748d70();

  while(!utility::within_fov(level.alex.origin, level.alex.angles, level.player.origin, cos(15))) {
    level.alex.smartfacingpos = level.player getEye();
    level.alex scripts\common\ai::set_gunpose("gun_down");
    level.alex.gunposeoverride = "gun_down";
    level.alex.gunposeoverride_internal = "gun_down";
    waitframe();
  }

  level.alex scripts\common\utility::lookatentity(level.player, 1);
}

function function_64c14317b3748d70() {
  flag_set("alex_ack_farah_vo");
}

function function_61ea85620bfd2294() {
  return level.player.origin;
}

function function_cef303186b6867a2() {
  var_9dc57b4d93211dee = getaiarray("axis").size;
  var_4ba7baebc9143e7e = function_6149b301ce19988b("stealth_ai_exfil_patrol_left", &function_b863dcd61d90ee40);
  var_b5c1c2b126f214f3 = function_6149b301ce19988b("stealth_ai_exfil_patrol_right", &function_b863dcd61d90ee40);
  level.exfil_reinforcements = [var_4ba7baebc9143e7e, var_b5c1c2b126f214f3];
}

function function_87a8f380543e4b27() {
  flag_wait("scriptables_ready");
  structs = getStructArray("unlock_ascender", "targetname");

  foreach(struct in structs) {
    var_89019d958485f73a = getentitylessscriptablearray(struct.target, "targetname");
    var_89019d958485f73a[0] thread function_1083fd74c5a3eece(var_89019d958485f73a[0], 1);
  }
}

function function_7af2acad56dd498() {
  level endon("game_ended");
  self endon("death");
  var_931cb7dc546ebfed = "noncombat";
  var_81783e44d8dacab6 = undefined;

  while(true) {
    if(self.alertlevel == "combat" && var_931cb7dc546ebfed != "combat") {
      var_931cb7dc546ebfed = "combat";
      var_81783e44d8dacab6 = gettime();
    } else if(self.alertlevel == "combat" && var_931cb7dc546ebfed == "combat") {
      currenttime = gettime();
      deltatime = currenttime - var_81783e44d8dacab6;

      if(deltatime > 10000 && self.goalradius > 400) {
        self.goalradius *= 0.7;
        var_81783e44d8dacab6 = gettime();
      }
    } else if(self.alertlevel == "noncombat" || self.alertlevel == "alert") {
      var_931cb7dc546ebfed = "noncombat";
    }

    wait 1;
  }
}

function hint_showPhoneNearbyHint(delay) {
  level.player notify("hint_showPhoneNearbyHint");
  level.player endon("hint_showPhoneNearbyHint");
  level.player endon("disconnect");
  level endon("obj_phones_completed_vo");

  if(!isDefined(level.var_1561b5def912cfa)) {
    level.var_1561b5def912cfa = 0;
  }

  if(!isDefined(level.var_a603d4653d44209b)) {
    level.var_a603d4653d44209b = gettime();
  }

  if(level.var_1561b5def912cfa >= 2) {
    return;
  }

  if(istrue(level.var_a5e12c52cb5454aa)) {
    return;
  }

  if(gettime() < level.var_a603d4653d44209b) {
    return;
  }

  if(function_eac0cd99c9c6d8ee() == "spotted") {
    return;
  }

  if(!isDefined(delay)) {
    delay = 1;
  }

  wait delay;
  level.var_1561b5def912cfa++;
  level.var_a5e12c52cb5454aa = 1;

  if(gettime() >= level.var_a603d4653d44209b) {
    level.var_a603d4653d44209b = gettime() + 15000;
  }

  level.player thread scripts\cp\cp_hud_message::tutorialprint(&"CP_JUP_RANCH/TACMAP_HINT", 10);
  level.player thread hint_waitForTacMapbuttonPressed();
  wait 10;
  level.player clearhudtutorialmessage();
  level.player notify("hint_waitForTacMapButtonPressed");
  level.var_a5e12c52cb5454aa = undefined;
}

function hint_waitForTacMapbuttonPressed() {
  level.player endon("disconnect");
  level.player endon("hint_waitForTacMapButtonPressed");

  while(level.player istacmapactive() == 0) {
    waitframe();
  }

  level.var_a5e12c52cb5454aa = undefined;
  level.player clearhudtutorialmessage();
  level.player notify("hint_showPhoneNearbyHint");
}

function function_ea101df42d86cfe3() {
  level.var_a5f1c40b25d964fb = spawnStruct();
  level.var_a5f1c40b25d964fb.var_f0bd52af6aad7180 = [];
  level.var_a5f1c40b25d964fb.var_14c8645f1ccefa33 = [];
  level.var_a5f1c40b25d964fb.var_d11ae1a01ebe7bdf = [];
  level.var_a5f1c40b25d964fb.var_cb841c75d3137fda = [];
  level.var_a5f1c40b25d964fb.var_a2219b17e2af487f = [];
  level.var_a5f1c40b25d964fb.var_6250721938d267ba = [];
  level.var_a5f1c40b25d964fb.var_558d4b716a723db3 = [];
  level.var_a5f1c40b25d964fb.multikills = [];
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_rnza_alex_thatsonedown";
  aliases[aliases.size] = "dx_cp_rnch_rnza_alex_hesnotgettingup";
  aliases[aliases.size] = "dx_cp_rnch_rnza_alex_quickandquiet";
  aliases[aliases.size] = "dx_cp_rnch_rnza_alex_kiloyoureleavingatra";
  aliases[aliases.size] = "dx_cp_rnch_rnza_alex_thathighbodycountcan";
  aliases[aliases.size] = "dx_cp_rnch_rnza_alex_farahyoukeepstacking";
  aliases[aliases.size] = "dx_cp_rnch_rnza_alex_enemysniperdown";
  aliases[aliases.size] = "dx_cp_rnch_rnza_alex_cleanshotsniperelimi";
  aliases[aliases.size] = "dx_cp_rnch_rnza_alex_goodnightsniperyougo";
  aliases[aliases.size] = "dx_cp_rnch_rnza_alex_solidkill";
  aliases[aliases.size] = "dx_cp_rnch_rnza_alex_goodhit";
  aliases[aliases.size] = "dx_cp_rnch_rnza_alex_enemydown";
  aliases[aliases.size] = "dx_cp_rnch_rnza_alex_baggedemkilo";
  aliases[aliases.size] = "dx_cp_rnch_rnza_alex_goodkill";
  aliases[aliases.size] = "dx_cp_rnch_rnza_alex_yougotem";
  aliases[aliases.size] = "dx_cp_rnch_rnza_alex_hesdone";
  aliases[aliases.size] = "dx_cp_rnch_rnza_alex_quickndirty";
  aliases[aliases.size] = "dx_cp_rnch_rnza_alex_niceshot";
  aliases[aliases.size] = "dx_cp_rnch_rnza_alex_nailedhim";
  aliases[aliases.size] = "dx_cp_rnch_rnza_alex_boomdismissed";
  aliases[aliases.size] = "dx_cp_rnch_rnza_alex_thatsabodybag";
  level.var_a5f1c40b25d964fb.var_f0bd52af6aad7180 = scripts\engine\utility::create_deck(["dx_cp_rnch_rnsk_alex_nicefarahtheystilldo", "dx_cp_rnch_rnsk_alex_goodshotkilonoissues", "dx_cp_rnch_rnsk_alex_nicefarahtheystilldo", "dx_cp_rnch_rnza_alex_thatsonedown", "dx_cp_rnch_rnza_alex_quickandquiet", "dx_cp_rnch_rnza_alex_kiloyoureleavingatra", "dx_cp_rnch_rnza_alex_thathighbodycountcan", "dx_cp_rnch_rnza_alex_solidkill", "dx_cp_rnch_rnza_alex_goodhit", "dx_cp_rnch_rnza_alex_enemydown", "dx_cp_rnch_rnza_alex_baggedemkilo", "dx_cp_rnch_rnza_alex_goodkill", "dx_cp_rnch_rnza_alex_yougotem", "dx_cp_rnch_rnza_alex_quickndirty"]);
  level.var_a5f1c40b25d964fb.var_14c8645f1ccefa33 = scripts\engine\utility::create_deck(["dx_cp_rnch_rnzd_alex_guardsdown", "dx_cp_rnch_rnzd_alex_hisnightsover", "dx_cp_rnch_rnzd_alex_sleeptimeson"]);
  level.var_a5f1c40b25d964fb.var_d11ae1a01ebe7bdf = scripts\engine\utility::create_deck(["dx_cp_rnch_rnze_alex_secondguardneutraliz", "dx_cp_rnch_rnze_alex_hecanjoinhisbuddy", "dx_cp_rnch_rnze_alex_secondhostilesdown"]);
  level.var_a5f1c40b25d964fb.var_cb841c75d3137fda = scripts\engine\utility::create_deck(["dx_cp_rnch_rnzf_alex_konnidown", "dx_cp_rnch_rnzf_alex_downedhim", "dx_cp_rnch_rnzf_alex_goodnighttohim"]);
  level.var_a5f1c40b25d964fb.var_a2219b17e2af487f = scripts\engine\utility::create_deck(["dx_cp_rnch_rnzg_alex_patroldown", "dx_cp_rnch_rnzg_alex_onelesspatrol", "dx_cp_rnch_rnzg_alex_welldonekilo"]);
  level.var_a5f1c40b25d964fb.var_6250721938d267ba = scripts\engine\utility::create_deck(["dx_cp_rnch_rnzi_alex_cleankillnoonesontoy", "dx_cp_rnch_rnzi_alex_heneversawitcoming", "dx_cp_rnch_rnzi_alex_thatonesdown"]);
  level.var_a5f1c40b25d964fb.var_558d4b716a723db3 = scripts\engine\utility::create_deck(["dx_cp_rnch_rnzj_alex_carefulhisbuddysclos", "dx_cp_rnch_rnzj_alex_watchithisfriendsnea", "dx_cp_rnch_rnzj_alex_hesgotafriendcareful"]);
  level.var_a5f1c40b25d964fb.multikills = scripts\engine\utility::create_deck(["dx_cp_rnch_rnzk_alex_quickworkkilo", "dx_cp_rnch_rnzk_alex_twoinarow", "dx_cp_rnch_rnzk_alex_twoforone"]);
}

function function_24826309c0f1e64d(cooldown) {
  cooldown = default_to(cooldown, 5);

  if(!isDefined(level.var_f28cd27ab5141310)) {
    level.var_f28cd27ab5141310 = -10001;
  }

  if(time_has_passed(level.var_f28cd27ab5141310, cooldown)) {
    return true;
  }

  return false;
}

function function_a8cf239507277966(radius) {
  ai = coop_stealth::get_ai_within_range(level.player.origin, radius * radius, 12);

  foreach(bot in ai) {
    if(bot scripts\stealth\utility::function_6a86dd83c01f8faa()) {
      return true;
    }
  }

  return false;
}

function function_b040f21595f033c(origin, radius) {
  ai = scripts\cp\coop_stealth::get_ai_within_range(level.player.origin, radius * radius, 20);
  var_9cc05aa827880781 = 0;

  foreach(bot in ai) {
    state = bot.var_fe5ebefa740c7106;

    if(state > var_9cc05aa827880781) {
      var_9cc05aa827880781 = state;
    }
  }

  return var_9cc05aa827880781;
}

function function_cc116388b57ace53(kill_dist, issniper) {
  flag_set("vo_in_kill");

  if(!isDefined(level.var_f28cd27ab5141310)) {
    level.var_f28cd27ab5141310 = -10001;
  }

  if(!isDefined(level.var_a5f1c40b25d964fb)) {
    function_ea101df42d86cfe3();
  }

  var_31f8b11328b07f8a = percent_chance(70);
  alias = "";

  if(isDefined(level.var_f28cd27ab5141310) && (var_31f8b11328b07f8a || kill_dist > 300) && !function_96c92abe3592782f()) {
    if(function_24826309c0f1e64d(5)) {
      if(level.shots_fired["ranch"] == 0 && !flag("active_combat_begun")) {
        alias = level.var_a5f1c40b25d964fb.var_f0bd52af6aad7180 deck_draw();
      }
    }
  }

  wait randomfloatrange(0.3, 1.2);
  var_715db78dca5b22bf = level.player say_team(alias, 0.2, 0.2, 0, 0.3);
  flag_clear("vo_in_kill");

  if(istrue(var_715db78dca5b22bf)) {
    level.var_5ef076251e7516c7 = 1;
    wait 7;
    level.var_5ef076251e7516c7 = 0;
  }
}

function function_c6541a1eb7bd31a1() {
  if(flag("obj_search_completed")) {
    return;
  }

  if(function_4bcd86b926d48155()) {
    return;
  }

  level endon("obj_search_completed");
  level.player endon("death");
  level endon("disconnect");
  level endon("spawn_reinforcement_vehicle");
  aliases = [];
  aliases[aliases.size] = "dx_cp_rnch_rgst_alex_looksliketheyvelostt";
  aliases[aliases.size] = "dx_cp_rnch_rgst_alex_theylosttrackofyoubu";
  aliases[aliases.size] = "dx_cp_rnch_rgst_alex_theyvelostyoubutdont";
  aliases[aliases.size] = "dx_cp_rnch_rgst_alex_lookslikeyoureinthec";
  aliases[aliases.size] = "dx_cp_rnch_rgst_alex_closecallbutithinkth";
  aliases[aliases.size] = "dx_cp_rnch_rgst_alex_ithinktheyvelosttrac";
  aliases[aliases.size] = "dx_cp_rnch_rgst_alex_thatwasclosebutithin";
  var_bf7b8c36f639f8a7 = create_deck(aliases, 1, 1);

  while(true) {
    level waittill("back_in_stealth");

    if(!function_1bb1470f934a81eb()) {
      level.player say_delayed(0.2, var_bf7b8c36f639f8a7 deck_draw(), 0, 1);
    }
  }
}

function function_96c92abe3592782f() {
  if(!isDefined(level.var_e7a262fc921cd1f2)) {
    var_e7a262fc921cd1f2 = [getEnt("goal_vol_manor", "targetname"), getEnt("goal_vol_building_1", "targetname"), getEnt("goal_vol_building_2", "targetname")];
    interior_triggers = getEntArray("INTERIOR_TRIGGERS", "targetname");
    level.var_e7a262fc921cd1f2 = array_combine(var_e7a262fc921cd1f2, interior_triggers);
  }

  foreach(vol in level.var_e7a262fc921cd1f2) {
    if(level.player istouching(vol)) {
      return true;
    }
  }

  return false;
}

function function_ecc682b5a8f2f5c3() {
  player = level.player;
  level.var_f0d6bc06cb445e79 = getEnt("hostage_sequence_start_trigger", "targetname");
  vehicles = getvehiclearray();

  if(isDefined(vehicles)) {
    foreach(vehicle in vehicles) {
      if(isDefined(level.var_69c070ef9dc50848) && level.var_69c070ef9dc50848 == vehicle) {
        continue;
      }

      if(vehicle istouching(level.var_f0d6bc06cb445e79)) {
        vehicle delete();
      }
    }
  }

  if(isDefined(level.player.plantedlethalequip)) {
    level.player.plantedlethalequip = array_removeundefined(level.player.plantedlethalequip);

    foreach(mine in level.player.plantedlethalequip) {
      if(mine istouching(level.var_f0d6bc06cb445e79)) {
        mine scripts\cp\weapon::deleteexplosive();
      }
    }
  }

  if(isDefined(level.mines)) {
    level.mines = array_removeundefined(level.mines);

    foreach(var_3bc20565c1f4604a in level.mines) {
      if(var_3bc20565c1f4604a istouching(level.var_f0d6bc06cb445e79)) {
        var_3bc20565c1f4604a scripts\cp\weapon::deleteexplosive();
      }
    }
  }

  function_ef3e8f10f229e1c4(player);
  ownedmines = scripts\cp_mp\killstreaks\cluster_spike::function_a868fa9dc357d535(player);

  if(isDefined(ownedmines)) {
    foreach(mine in ownedmines) {
      if(!isDefined(mine)) {
        iprintln("<dev string:x2c0>");

        level.clusterspikes[self.team]["ownerID_" + self getxuid()] = array_removeundefined(level.clusterspikes[self.team]["ownerID_" + self getxuid()]);
      }

      if(mine istouching(level.var_f0d6bc06cb445e79)) {
        mine thread scripts\cp_mp\killstreaks\cluster_spike::clusterspike_explode("destroy");
      }
    }
  }
}

function function_ef3e8f10f229e1c4(player) {
  if(isDefined(player.placedsentries)) {
    if(isDefined(player.placedsentries["sentry_turret"]) && isarray(player.placedsentries["sentry_turret"]) && player.placedsentries["sentry_turret"].size > 0) {
      foreach(turret in player.placedsentries["sentry_turret"]) {
        if(isDefined(turret)) {
          if(isDefined(level.var_f0d6bc06cb445e79)) {
            if(turret istouching(level.var_f0d6bc06cb445e79)) {
              turret notify("kill_turret", 1, 0);
            }

            continue;
          }

          turret notify("kill_turret", 1, 0);
        }
      }
    }

    if(isDefined(player.placedsentries["manual_turret"]) && isarray(player.placedsentries["manual_turret"]) && player.placedsentries["manual_turret"].size > 0) {
      foreach(turret in player.placedsentries["manual_turret"]) {
        if(isDefined(turret)) {
          if(isDefined(level.var_f0d6bc06cb445e79)) {
            if(turret istouching(level.var_f0d6bc06cb445e79)) {
              turret notify("kill_turret", 1, 0);
            }

            continue;
          }

          turret notify("kill_turret", 1, 0);
        }
      }
    }
  }
}

function function_3b809471376c796(keep_hidden) {
  playerspeed = length(level.player getvelocity());
  blendtime = playerspeed > 45 ? 0.5 : 1;
  var_858203d3d31e76f2 = 0.6;

  if(level.player getstance() != "stand") {
    level.player setstance("stand", 1, 0, 0);
    waitframe();
  }

  level.player_rig.allows = ["weapon", "offhand_weapons", "melee", "sprint", "allow_jump", "mantle", "crouch", "prone", "freezecontrols"];
  level.player val::set_array("player_rig", level.player_rig.allows, 0);
  level.player playerlinktoblend(level.player_rig, "tag_player", blendtime, blendtime * 0.5, blendtime * 0.5);
  level.player delaycall(blendtime, &playerlinktodelta, level.player_rig, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player delaycall(blendtime + 0.5, &lerpviewangleclamp, 1, 0.5, 0.5, 30, 30, 30, 30);
  wait var_858203d3d31e76f2;
}

function function_101fa08ce181773f(view_fraction, right_arc, left_arc, top_arc, bottom_arc, var_dbe269f3b6799cb4, var_3b6451bc8c0344ba) {
  assert(isDefined(self.rig));
  var_dbe269f3b6799cb4 = default_to(var_dbe269f3b6799cb4, 0);
  var_3b6451bc8c0344ba = default_to(var_3b6451bc8c0344ba, 1);
  self playerlinktodelta(self.rig, "tag_player", view_fraction, right_arc, left_arc, top_arc, bottom_arc);

  if(var_3b6451bc8c0344ba) {
    self setplayerangles(self.rig gettagangles("tag_player"));
  }

  self dontinterpolate();
  self.rig dontinterpolate();

  if(var_dbe269f3b6799cb4) {
    self.rig hide();
    return;
  }

  self.rig show();
}

function function_f610c036d3cfc4ed(turret, potentialtarget, var_935ba61e1c5c6320) {
  var_b9d5783a4f34efbc = [turret];
  var_15c3c1d963654f89 = 0;

  if(istrue(var_935ba61e1c5c6320)) {
    var_15c3c1d963654f89 = potentialtarget scripts\cp_mp\utility\player_utility::isinvehicle();

    if(istrue(var_15c3c1d963654f89)) {
      occupiedvehicle = potentialtarget scripts\cp_mp\utility\player_utility::getvehicle();
      var_b9d5783a4f34efbc[var_b9d5783a4f34efbc.size] = occupiedvehicle;
      linkedmodels = occupiedvehicle getlinkedchildren();

      if(isDefined(linkedmodels) && linkedmodels.size > 0) {
        var_b9d5783a4f34efbc = array_combine(var_b9d5783a4f34efbc, linkedmodels);
      }
    }
  }

  tracelist = [];

  if(isPlayer(potentialtarget) || isagent(potentialtarget)) {
    headpos = potentialtarget gettagorigin("j_head");

    if(isDefined(headpos)) {
      tracelist[tracelist.size] = headpos;
    }

    midpos = potentialtarget gettagorigin("j_mainroot");

    if(isDefined(midpos)) {
      tracelist[tracelist.size] = midpos;
    }
  }

  tracelist[tracelist.size] = potentialtarget.origin;
  canseetarget = 0;
  tracestartpos = turret gettagorigin("tag_barrel");

  foreach(traceendpos in tracelist) {
    canseetarget = scripts\engine\trace::ray_trace_passed(tracestartpos, traceendpos, var_b9d5783a4f34efbc, level.var_eedf56f300b6c661);

    if(istrue(canseetarget)) {
      break;
    }

    if(getdvarint(@ "hash_8f43102e410dc88f", 0) != 0) {
      wait 0.05;
    }
  }

  return canseetarget;
}

function enableDroneTracking(drone) {
  self.var_7578715840982db8 = drone;

  if(isDefined(level.var_86c9e0bb5de52aa1)) {
    self.var_7578715840982db8 thread function_2576ba31a26a3c96(level.var_86c9e0bb5de52aa1);
  }
}

function function_2576ba31a26a3c96(trigger) {
  if(!isDefined(self.var_972fe6d8186429e3)) {
    self.var_972fe6d8186429e3 = [];
  }

  self.var_972fe6d8186429e3 = array_add(self.var_972fe6d8186429e3, trigger);
  thread assaultDrone_watchForDroneTriggeringTrackedTrigger();
}

function function_fa001c17a9b3919d(trigger) {
  self.var_972fe6d8186429e3 = array_remove(self.var_972fe6d8186429e3, trigger);
}

function assaultDrone_watchForDroneTriggeringTrackedTrigger() {
  self endon("death");
  self notify("assaultDrone_watchForDroneTriggeringTrackedTrigger");
  self endon("assaultDrone_watchForDroneTriggeringTrackedTrigger");
  level endon("hostage_ai_goto_combat");

  while(true) {
    foreach(trig in self.var_972fe6d8186429e3) {
      if(self istouching(trig)) {
        if(!ent_flag("trigger_" + trig.targetname)) {
          ent_flag_set("trigger_" + trig.targetname);
          trig notify("trigger", self.owner);
        }

        continue;
      }

      if(ent_flag("trigger_" + trig.targetname)) {
        ent_flag_clear("trigger_" + trig.targetname);
      }
    }

    waitframe();
  }
}

function function_ee973ff3fd2f2306() {
  level endon("game_ended");
  level endon("spawn_reinforcement_vehicle");
  childthread function_6c8117005f764863();
  level waittill_any_2("player_causing_damage", "player_damaged");
  var_bd9be67123fe7726 = utility::create_deck(["dx_cp_rnch_rnva_fara_engaging", "dx_cp_rnch_rnva_fara_openingfire", "dx_cp_rnch_rnva_fara_contacting", "dx_cp_rnch_rnva_fara_sendingrounds"]);
  alias = var_bd9be67123fe7726 deck_draw();
  level.player say_team(alias, 1, 0);
}

function function_6c8117005f764863() {
  level endon("game_ended");
  level endon("spawn_reinforcement_vehicle");

  while(!isDefined(level.player)) {
    waitframe();
  }

  level.player endon("death");

  while(true) {
    level.player waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(!isDefined(attacker)) {
      continue;
    }

    if(isDefined(attacker.targetname) && attacker.targetname == "stealth_ai") {
      level notify("player_damaged");
    }

    if(isDefined(attacker.script_stealthgroup) && attacker.script_stealthgroup == "reinforcements_pickup_group") {
      level notify("player_damaged");
    }
  }
}

function function_edd7c7c3c333611() {
  level endon("game_ended");
  var_f6a6ff4c8413b16e = utility::create_deck(["dx_cp_rnch_turh_fara_tookcontrolofasentry", "dx_cp_rnch_turh_fara_sentrygunhacked"]);
  var_f9c482c81fb78db3 = utility::create_deck(["dx_cp_rnch_turh_fara_turretgunisminenow_01", "dx_cp_rnch_turh_fara_hackedthesentrygun", "dx_cp_rnch_turh_fara_tookcontrolofaturret", "dx_cp_rnch_turh_fara_sentrygunhacked_01"]);
  level.player function_c02941e07491127e(var_f6a6ff4c8413b16e deck_draw(), var_f9c482c81fb78db3 deck_draw(), 0, 1, 0, 1);
}

function function_c600266435c46de() {
  level endon("game_ended");
  level endon("spawn_reinforcement_vehicle");
  level endon("black_box_picked_up");
  rnd = randomintrange(2, 4);
  level.player function_fc0eb6b81c66c661(rnd, "dx_cp_rnch_rnpa_alex_theyreregroupingouts", 1, 0);

  if(isDefined(level.var_91ebedd109ae8466) && level.var_91ebedd109ae8466 < 1) {
    level.player function_fc0eb6b81c66c661(2, "dx_cp_rnch_rnpa_fara_makarovsmenwilldiehe", 1, 0);
    level.player function_fc0eb6b81c66c661(1, "dx_cp_rnch_rnpa_alex_gettinwhattheydeserv", 1, 0);
    level.player function_fc0eb6b81c66c661(1, "dx_cp_rnch_rnpa_fara_ifonlywecouldkillthe", 1, 0);
  }
}

function function_99dab8618282ca8d() {
  level endon("game_ended");
  level endon("black_box_picked_up");
  dialogue = [ &function_f47878301e7be106, "dx_cp_rnch_rny2_alex_howdotheengineslook", &function_f47878301e7be106, 0.8, "dx_cp_rnch_rny2_fara_shreddedsomeblastres", &function_f47878301e7be106, 0.8, "dx_cp_rnch_rny2_alex_whatthehellhappenedu", &function_f47878301e7be106, 0.5, "dx_cp_rnch_rny2_fara_heusedthemaspawns", &function_f47878301e7be106, 0.7, "dx_cp_rnch_rny2_alex_beyondthefuckinpale", &function_f47878301e7be106, 0.8, "dx_cp_rnch_rny2_fara_yesthatswhoweredeali"];
  level.player say_sequence(dialogue, 0, 1, 0, 0, "team", &function_f47878301e7be106);
}

function function_f47878301e7be106() {
  if(function_1bb1470f934a81eb()) {
    return 0;
  }
}

function function_306ed11b28612f09() {
  if(player_nvg_on()) {
    self nightvisionviewoff(1);
  }
}