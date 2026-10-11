/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_2918bb19a23cae35.gsc
*************************************************/

#using script_102d83a437e2b29f;
#using script_1505086636c2f010;
#using script_1b5e21ec19a8960b;
#using script_222a289abd7b1064;
#using script_2386704e3c08f8ca;
#using script_2ae5b9052148587;
#using script_2bd16c90e9c5c546;
#using script_3a8f9ace195c9da9;
#using script_3ae866a6dd08daf9;
#using script_3b0812a5fdfecf0;
#using script_3cb1beed718e7650;
#using script_40bcf9e683efc7ac;
#using script_42f868a5dda17294;
#using script_43808fb6ab5311d4;
#using script_46b342a079938c68;
#using script_48324b060b129b7b;
#using script_48874a5e41200245;
#using script_4d5598fb7043bac9;
#using script_5d9826c14d0c0fc4;
#using script_79246b6319aaf0dd;
#using script_7bfb62cd6fe6118e;
#using script_7db80de62748c769;
#using script_f603f40349f99c8;
#using scripts\anim\dialogue;
#using scripts\anim\utility_common;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_paths;
#using scripts\cp\coop_stealth;
#using scripts\cp\cp_aiparachute;
#using scripts\cp\cp_checkpoint;
#using scripts\cp\cp_claymore;
#using scripts\cp\cp_compass;
#using scripts\cp\cp_create_script_utility;
#using scripts\cp\cp_hud_message;
#using scripts\cp\cp_interaction;
#using scripts\cp\cp_objectives;
#using scripts\cp\cp_outofbounds;
#using scripts\cp\cp_spawning_util;
#using scripts\cp\globallogic;
#using scripts\cp\loadout;
#using scripts\cp\pickups;
#using scripts\cp\player\offhand_box;
#using scripts\cp\player_death;
#using scripts\cp\spawning;
#using scripts\cp\starts;
#using scripts\cp\super;
#using scripts\cp\utility;
#using scripts\cp\utility\player;
#using scripts\cp\vehicles;
#using scripts\cp\weapon;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\equipment\geiger_counter;
#using scripts\cp_mp\killstreaks\sentry_gun;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\stealth\utility;
#namespace cp_jup_dam;

function main() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0)) {
    return;
  }

  namespace_ca8d3ef876710d75::main();
  namespace_aa51f46c4e9f6395::main();
  namespace_7f9553b90d7dde8e::main();
  thread namespace_98841a455c1f61d4::main();
  thread namespace_95af3005fd2ed66a::main();

  if(level.createfx_enabled) {
    return;
  }

  scripts\cp\cp_checkpoint::function_4bfef22c47a65be5("obj_bombs_complete");
  precacheshader("icon_waypoint_enemy_marker");
  level.bombsdefused = 0;
  level.numbombs = 4;
  level.lastbomb = undefined;

  if(level.mapname == "cp_jup_dam") {
    level.var_61a54be8038f3a95 = 1;
    level.var_41957e049a51e8bc = "stealth_ai_music_bundle_cp_jup_dam";
    level.var_8e4a4897f3b80823 = 1;
  }

  game_utility::registernightmap();
  utility::coop_mode_enable("sp_stealth");
  level thread function_fb457f7cdf0ac39e();
  setDvar(@ "hash_df03d7ac5b31599", 1);
  level thread super::init_super();
  setdvarifuninitialized(@ "hash_28f8434dbc4fa9dd", 1);
  setdvarifuninitialized(@ "hash_13896166e283ef7e", 20);
  setDvar(@ "hash_35bab6c292a12242", 2250);
  setDvar(@ "hash_f983d652b2640512", 800);
  setdvarifuninitialized(@ "hash_1b9c3014fa4762f1", 180);
  setdvarifuninitialized(@ "hash_1b9c2d14fa475c58", 180);
  setdvarifuninitialized(@ "hash_1b9c2e14fa475e8b", 180);
  level.var_d0f9a08690a8075[0] = getdvarint(@ "hash_1b9c3014fa4762f1");
  level.var_d0f9a08690a8075[1] = getdvarint(@ "hash_1b9c2d14fa475c58");
  level.var_d0f9a08690a8075[2] = getdvarint(@ "hash_1b9c2e14fa475e8b");
  utility::add_start("start", &function_3092d75b53b2f41);
  utility::add_start("assault", &function_ccb61ff92fa51926, &assault_main, &level_setup);
  utility::add_start("exfil", &exfil_setup, &exfil_main);
  utility::function_bb3e0c926b0667c4("start,assault,exfil");
  level.disable_start_spawn_on_navmesh = 1;
  function_d525f1534752bfc7();
  function_2cfef434ce6a1c44();
  function_279964c2c969dda3();
  function_3861eb0a004e0d38();
  function_c4d555bf9485ac3b();
  function_c3e34853ee15f719();
  thread function_4faf77b13696a43f();
  namespace_96731f4d002634f6::function_61411c49eaca86e2("ghost");
  thread play_intro();
  thread function_de5ae0c94d33b9c8();
  setdvarifuninitialized(@ "hash_e63044d7b59f5713", 1);

  if(getdvarint(@ "hash_2e4907ccd20a8761", 0)) {
    ai_spawn_director::director_init();
  }

  if(!isDefined(level.valstruct)) {
    level.valstruct = spawnStruct();
  }

  level.valstruct val::set("level", "global_esc_total_combat_time", 500);
  level.valstruct val::set("level", "global_esc_percent_threshold", 0.3);
  function_cdfd74e95368bd63(15000);
  level.valstruct val::set("level", "stealth_ttlt_lkp", 20000);
  level.valstruct val::set("level", "stealth_ttlt_not_lkp", 20000);
}

function function_4faf77b13696a43f() {
  while(!isDefined(level.player)) {
    waitframe();
  }

  level.checkpoint = level.player namespace_1170726b2799ea65::function_50f02a42c72031cb(level.mapname);

  if(!isDefined(level.checkpoint)) {
    level.checkpoint = scripts\cp\cp_checkpoint::checkpoint_get();
  }

  level.checkpoint_reached = level.checkpoint == "obj_bombs_complete" ? 1 : 0;
  utility::flag_set("checkpoint_data_retrieved");
}

function function_2cfef434ce6a1c44() {
  level.custom_onspawnplayer_func = &onplayerspawned;
  level.custom_onplayerconnect_func = &onplayerconnect;
}

function onplayerconnect(player) {}

function onplayerspawned() {}

function function_279964c2c969dda3() {}

function function_3861eb0a004e0d38() {
  level.objectivesfunc = &function_c2a86f682bf1ab71;
  level thread cp_objectives::objectives_init();
}

function function_c4d555bf9485ac3b() {
  level.var_5966c39cb60075f1 = &function_da58f5fca036ffaa;
  setup_create_script();
  laser_traps::load_laser_fx();
  laser_traps::initsentrysettings();
  function_e00cc8c1c5cc38fb(1);
  level thread function_b4b9b2e0a359b378();
  level thread function_fc4803dc319a81d2();
  cp_compass::setupminimap("compass_map_cp_jup_dam_floor_0");
  namespace_946bd24de7c11f31::function_b04f37f19c6631e0();
  level thread cp_objectives::run_debug_start_objective();

  level.devgui_setup_func = &function_d8fb18a58a875db6;
  level thread setup_map_specific_devgui();

  thread function_e6e31cf1988f3dbe();
  thread function_9533067432945711();
  thread function_a14c656a3b11227d();
  thread function_d7398803f3fe830();
  thread namespace_96731f4d002634f6::function_cece888a7dfbeb0b();
  level.team = "allies";
}

function function_d7398803f3fe830() {
  level endon("game_ended");
  utility::flag_wait("flag_dungeon_intro_complete");
  level.var_5528b06a2cfce7f9 = 0;

  while(true) {
    if(!level.var_5528b06a2cfce7f9 && function_3f51c5f6398bff45()) {
      level.var_5528b06a2cfce7f9 = 1;
      function_f9e5c241d348306a(1);
    } else if(level.var_5528b06a2cfce7f9 && !function_3f51c5f6398bff45()) {
      level.var_5528b06a2cfce7f9 = 0;
      function_f9e5c241d348306a(0);
    }

    waitframe();
  }
}

function function_f9e5c241d348306a(val) {
  if(istrue(val)) {}
}

function setup_create_script() {
  cp_create_script_utility::init_create_script_for_level();
  cp_create_script_utility::register_create_script_arrays("cp_jup_dam_create_script", "cp_jup_dam_create_script", level.scripted_spawner_func.size, &cp_jup_dam_create_script::main);
}

function function_a882f221bbf726e8() {
  hiddenranges["stand"] = 3500;
  hiddenranges["crouch"] = 3500;
  hiddenranges["prone"] = 3500;
  spottedranges["stand"] = 7500;
  spottedranges["crouch"] = 7500;
  spottedranges["prone"] = 7500;
  utility::set_detect_ranges(hiddenranges, spottedranges);
}

function function_9533067432945711() {
  utility::flag_wait("flag_dungeon_intro_complete");
  level endon("player_jumped_off_starting_catwalk");
  trigger_dam_catwalk = function_1c4d592029f2b0d3("trigger_dam_catwalk");
  var_9d9fd5ebfbf50f01 = undefined;

  while(true) {
    is_touching = level.player istouching(trigger_dam_catwalk);

    if(!isDefined(var_9d9fd5ebfbf50f01) || var_9d9fd5ebfbf50f01 != is_touching) {
      if(is_touching) {
        function_a882f221bbf726e8();
      } else {
        function_fb457f7cdf0ac39e();
        enemy_ai = getaiarray("axis");

        foreach(ai in enemy_ai) {
          ai function_40cf59cafe23b2d4();

          if(isDefined(ai.weapon) && ai.weapon.classname != "sniper") {
            ai function_d493e7fe15e5eaf4("jup_sandbox_dark");
          }
        }

        flag_set("player_jumped_off_starting_catwalk");
      }
    }

    var_9d9fd5ebfbf50f01 = is_touching;
    wait 0.5;
  }
}

function function_a14c656a3b11227d() {
  utility::flag_wait("flag_dungeon_intro_complete");
  level.player endon("death");
  tower_trigger = function_1c4d592029f2b0d3("radio_tower_trigger");

  if(!isDefined(tower_trigger)) {
    return;
  }

  var_9d9fd5ebfbf50f01 = undefined;

  while(true) {
    is_touching = level.player istouching(tower_trigger);

    if(!isDefined(var_9d9fd5ebfbf50f01) || var_9d9fd5ebfbf50f01 != is_touching) {
      if(is_touching) {
        function_a882f221bbf726e8();
      } else {
        function_fb457f7cdf0ac39e();
        enemy_ai = getaiarray("axis");
        enemy_ai = utility::array_removedead_or_dying(enemy_ai);

        foreach(ai in enemy_ai) {
          ai function_40cf59cafe23b2d4();
        }
      }
    }

    var_9d9fd5ebfbf50f01 = is_touching;
    waitframe();
  }
}

function function_40cf59cafe23b2d4() {
  class = self.weapon.classname;

  switch (class) {
    case #"hash_6191aaef9f922f96":
      self function_9215ce6fc83759b9(8192);
      break;
    case #"hash_8cdaf2e4ecfe5b51":
    case #"hash_fa24dff6bd60a12d":
      self function_9215ce6fc83759b9(2400);
      break;
    case #"hash_900cb96c552c5e8e":
      self function_9215ce6fc83759b9(1600);
    case #"hash_690c0d6a821b42e":
      self function_9215ce6fc83759b9(1400);
      break;
    default:
      self function_9215ce6fc83759b9(2400);
      break;
  }
}

function function_fb457f7cdf0ac39e() {
  level notify("level_setStealthSettings");
  level endon("level_setStealthSettings");

  while(!isDefined(level.stealth)) {
    waitframe();
  }

  hiddenranges["prone"] = 2800;
  hiddenranges["crouch"] = 3200;
  hiddenranges["stand"] = 4096;
  spottedranges["prone"] = 4800;
  spottedranges["crouch"] = 6400;
  spottedranges["stand"] = 8000;
  var_8f3f480583606401["prone"] = 1.1;
  var_8f3f480583606401["crouch"] = 1.15;
  var_8f3f480583606401["stand"] = 1.2;
  var_dd084edad2fd6dbf["prone"] = 50;
  var_dd084edad2fd6dbf["crouch"] = 200;
  var_dd084edad2fd6dbf["stand"] = 800;
  namespace_96731f4d002634f6::function_ec0d7ba8c7cd4120("truck_bed_stealth_vol", var_dd084edad2fd6dbf);
  utility::set_detect_ranges(hiddenranges, spottedranges, var_8f3f480583606401);
  function_531194f673a06de5(0);
  function_d5823c94e8131ea6(1);
  function_3c6ca4287e09d8b4(2400);
  level.valstruct val::set("level", "ai_eventlist", "jup_dam_aieventlist");
  utility::flag_set("stealth_ranges_initialized");
}

function function_fc4803dc319a81d2() {
  level wait_for_pre_game_period();
  level wait_for_strike_init_complete();
  level thread function_fe42b2ae1bc834ba();
  thread function_30160e0f4ccb9aaf();
  level thread function_c0926f2d29510c1c();
}

function function_c0926f2d29510c1c() {
  thread dam_main();
}

function wait_for_pre_game_period() {
  level endon("game_ended");
  utility::flag_wait("bsp_structs_initialized");
  utility::flag_wait("level_ready_for_script");
}

function wait_for_strike_init_complete() {
  level endon("game_ended");

  if(utility::flag_exist("strike_init_done")) {
    utility::flag_wait("strike_init_done");
  }
}

function function_c2a86f682bf1ab71() {
  level.objectives_table = "cp/cp_jup_dam_objectives.csv";
  level.objectivesmatrixtable = "cp/cp_jup_dam_objectives_matrix.csv";
  level.objectiveregistration = &function_77765e5dd4c9db54;
  cp_objectives::parseobjectivestable(level.objectives_table);
}

function function_77765e5dd4c9db54() {
  level endon("game_ended");
  utility::flag_wait("level_ready_for_script");
  utility::flag_wait("objective_table_parsed");
}

function function_d525f1534752bfc7() {
  setDvar(@ "hash_7686fcb92ccc5edb", 4);
  setDvar(@ "r_umbraaccurateocclusionthreshold", 2048);
  setDvar(@ "hash_3d71016015e6ad0c", 0.5);
  utility::flag_set("infil_complete");
  setDvar(@ "hash_ef675b8b6b09b0f", 1);
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

function function_744e0fabaf3e8db6() {}

function play_intro() {
  utility::flag_wait("dungeon_load_finished");
  utility::flag_wait("checkpoint_data_retrieved");
  utility::flag_clear("intro_skipped");
  level endon("intro_skipped");
  level.player.var_f296f7e55b9e9150 = getdvarint(@ "hash_b38fcf293d1e91a8");
  namespace_96731f4d002634f6::function_a88c360e19062b00(1);
  level.player freezecontrols(1);
  level.player waittill("loadout_class_selected");

  if(!namespace_96731f4d002634f6::should_play_intro() || istrue(level.var_1369e1e96a31be5e) || istrue(level.checkpoint_reached)) {
    if(!level.checkpoint_reached) {
      thread namespace_7f4f66b90d3178e7::function_6b12ac7ec1c1c0b();
      wait 1;

      if(!istrue(level.var_1369e1e96a31be5e)) {
        level.player setplayerangles((30, -60, 0));
      }
    }

    wait 2;
    level.player freezecontrols(0);
    utility::flag_set("flag_dungeon_intro_complete");
    return;
  }

  actors = [level.player_rig, level.var_5e84860df880bbce];
  anim_org = namespace_96731f4d002634f6::function_7a18da6e48b71c35("animnode_infil");
  animname = "infil";
  anim_org namespace_96731f4d002634f6::link_player_to_rig(animname, "stand", 0, 0, 1);
  level.player utility::hidehudenable();
  anim_org thread function_330eeeb728d01302(&function_2ee55da41f99e495);
  utility::flag_set("flag_intro_start");
  thread infil_music();
  level notify("show_chyrons");
  anim_org = namespace_96731f4d002634f6::function_7a18da6e48b71c35("dam_infil_node");
  anim_org scripts\common\scene::pre_stream(undefined, undefined, undefined, "jup_dam_infil");
  anim_org thread play_notify(undefined, undefined, "jup_dam_infil");
  anim_org waittill("scene_complete");
  function_2ee55da41f99e495(level.playback_scene);
}

function function_2ee55da41f99e495(anim_org) {
  level.player allowslide(1);

  if(!utility::flag("intro_skipped")) {
    anim_org scripts\common\scene::cleanup(1);
  }

  namespace_96731f4d002634f6::function_860a5c1214190a7c(anim_org);
  level.player setplayerangles((30, -60, 0));
  level.player freezecontrols(1);
  wait 2;
  level.player freezecontrols(0);
  utility::flag_set("intro_done");
}

function infil_music() {
  setmusicstate("mx_dam_infil");
}

function play_notify(existingentities, shotnames, scriptbundlename, fromtimefrac, prestreamtime) {
  level endon("intro_skipped");
  level.playback_scene = self;
  scripts\common\scene::play(existingentities, shotnames, scriptbundlename, fromtimefrac);
  self notify("scene_complete");
}

function function_330eeeb728d01302(var_6b3bd87d12cded0f) {
  userskipped = level.player scripts\cp\globallogic::userskip_wait();

  if(!userskipped) {
    return;
  }

  utility::flag_set("intro_skipped");
  namespace_15df8b4c55fd9ffe::function_c8abae08e191a6c7();
  namespace_15df8b4c55fd9ffe::function_7b3ec3155fda930b();
  namespace_15df8b4c55fd9ffe::function_26280fbed5700639();
  thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.player, 1);
  delaythread(0.1, &scripts\cp_mp\utility\game_utility::fadetoblackforplayer, level.player, 0);

  if(isDefined(level.playback_scene)) {
    soap_head = level.playback_scene scene::get_entity("soap_head");
    soap_head hide();
    level.playback_scene scripts\common\scene::stop();
    level.playback_scene namespace_96731f4d002634f6::function_b96b3877eda7204();
  }

  if(isDefined(var_6b3bd87d12cded0f)) {
    [[var_6b3bd87d12cded0f]](level.playback_scene);
  }
}

function function_de5ae0c94d33b9c8() {
  utility::flag_wait("dungeon_load_finished");
  utility::flag_wait("flag_dungeon_intro_complete");
  level endon("game_ended");
  level.player endon("death");
  oow_vol = function_1c4d592029f2b0d3("backrooms");

  while(isDefined(oow_vol)) {
    oow_vol waittill("trigger", ent);

    if(isPlayer(ent) && (ent isnoclip() || ent isufo())) {
      wait 0.1;
      continue;
    }

    assertmsg("<dev string:x1c>" + ent.origin);
    iprintlnbold("<dev string:x1c>" + ent.origin);

    if(isPlayer(ent)) {
      function_fa7c87f2585bd907(0);
      continue;
    }

    if(isai(ent) || ent scripts\common\vehicle::isvehicle()) {
      ent kill();
    }
  }
}

function function_30160e0f4ccb9aaf() {
  if(!isDefined(level.player_rig)) {
    level.player_rig = namespace_96731f4d002634f6::spawn_anim_model("player_rig");
  }

  if(!isDefined(level.var_5e84860df880bbce)) {
    level.var_5e84860df880bbce = namespace_96731f4d002634f6::spawn_anim_model("3rd_person_player");
  }

  level.player_rig hide();
  namespace_96731f4d002634f6::function_a88c360e19062b00(0);
  level.heli_model = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("exfil_heli");
  level.heli_model hide();
  level.var_b577a3b12d46dfc1 = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("exfil_heli_clip_block");

  if(isDefined(level.var_b577a3b12d46dfc1)) {
    level.var_b577a3b12d46dfc1 notsolid();
  }

  level.var_a0ea4461b934370f = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("exfil_heli_clip_floor");

  if(isDefined(level.var_a0ea4461b934370f)) {
    level.var_a0ea4461b934370f notsolid();
  }
}

function dam_main() {
  utility::flag_wait("player_spawned_with_loadout");
  thread namespace_7f4f66b90d3178e7::function_ffc7dd3a5adfd5cf();
  utility::flag_wait("flag_dungeon_intro_complete");
  utility::flag_wait("checkpoint_data_retrieved");
  thread function_2c31d268382bedb0();
  thread obj_flow();
  thread function_2a7cebc730abe77a();
  thread function_8488742ee64fe782();
  thread function_137fc90d1f21350c();
  thread offhand_box::offhand_box_setup();
  var_86e0c5a49cdc06f3 = getentitylessscriptablearray("catwalk_door", "script_noteworthy");

  foreach(door in var_86e0c5a49cdc06f3) {
    door function_9af4c9b2cc1bf989();
  }

  thread function_3b557584befa142e();

  if(istrue(level.checkpoint_reached) && !istrue(level.var_f8c5ab19e120757d)) {
    function_aff580e238d55059();
  }
}

function function_3092d75b53b2f41() {
  utility::flag_set("setup_finished");
}

function level_setup() {
  var_92d80bbd11ae8f3b = utility::getStructArray("veh_initial_truck", "targetname");

  foreach(var_af695cb17fb8e179 in var_92d80bbd11ae8f3b) {
    namespace_48d38898a22ee3d7::function_136d8a6a5c016d7e(var_af695cb17fb8e179);
  }

  thread function_ad873d6b224de9df();
  thread sentry_truck();
  thread function_7022c3b07d4d5a70("water");
  thread function_7022c3b07d4d5a70("catwalk");
  thread function_7022c3b07d4d5a70("bunker");
}

function function_7022c3b07d4d5a70(bombsite) {
  switch (bombsite) {
    case #"hash_7651db02434beff0":
      var_45150b414b5d373e = "bridge_c4";
      flag_name = "flag_bomb_1_defused";
      break;
    case #"hash_32afa0932832c1e2":
      var_45150b414b5d373e = "catwalk_c4";
      flag_name = "flag_bomb_2_defused";
      break;
    case #"hash_ec91a685aa7f22c0":
      var_45150b414b5d373e = "bunker_c4";
      flag_name = "flag_bomb_3_defused";
      break;
  }

  var_5993636f597cc250 = getentitylessscriptablearray(var_45150b414b5d373e, "targetname");

  foreach(c4 in var_5993636f597cc250) {
    c4 setscriptablepartstate("cp_beacon", "light_on");
  }

  utility::flag_wait(flag_name);

  foreach(c4 in var_5993636f597cc250) {
    c4 setscriptablepartstate("cp_beacon", "light_off");
  }
}

function function_b4b9b2e0a359b378() {
  utility::flag_wait("strike_init_done");
  utility::flag_wait("player_spawned_with_loadout");
  var_8bdd1937dc080cca = utility::getStructArray("laser_sentry_defuse", "script_noteworthy");

  foreach(str in var_8bdd1937dc080cca) {
    str.script_index = "3";
  }

  laser_traps::function_4855a66011f5974b(var_8bdd1937dc080cca);
  level.var_98847a9ecfe2a090 = getEntArray("dam_laser_trap", "targetname");
}

function function_fe42b2ae1bc834ba() {
  utility::flag_wait("player_spawned_with_loadout");
  level.var_c91a0e8fe84fb300 = &cp_claymore::function_e2b6464932ab9b06;
  level.claymores = cp_claymore::spawn_claymore_group("claymore");
}

function function_3b557584befa142e() {
  utility::flag_wait("player_spawned_with_loadout");
  level.player endon("death");
  var_e43d751b859d00e5 = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("vehicle_clip_ceiling");
  var_63582ca9a5f2ad78 = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("vehicle_clip_dam");

  if(!isDefined(var_e43d751b859d00e5) || !isDefined(var_63582ca9a5f2ad78)) {
    return;
  }

  var_e43d751b859d00e5 notsolid();
  var_51557168c3163f5d = 0;
  var_63582ca9a5f2ad78 notsolid();
  var_5e5bf4ce057cedb2 = 0;

  while(true) {
    if(var_51557168c3163f5d && !flag("player_using_munition")) {
      var_e43d751b859d00e5 notsolid();
      var_51557168c3163f5d = 0;
    } else if(!var_51557168c3163f5d && flag("player_using_munition") && isDefined(level.var_f2dd7048c6084bbe) && level.var_f2dd7048c6084bbe != "chopper_gunner" && !utility::flag("flag_start_new_exfil")) {
      var_e43d751b859d00e5 solid();
      var_51557168c3163f5d = 1;
    }

    if(var_5e5bf4ce057cedb2 && !flag("player_using_munition")) {
      var_63582ca9a5f2ad78 notsolid();
      var_5e5bf4ce057cedb2 = 0;
    } else if(!var_5e5bf4ce057cedb2 && flag("player_using_munition") && isDefined(level.var_f2dd7048c6084bbe) && level.var_f2dd7048c6084bbe == "chopper_gunner" && !utility::flag("flag_start_new_exfil")) {
      var_63582ca9a5f2ad78 solid();
      var_5e5bf4ce057cedb2 = 1;
    }

    waitframe();
  }
}

function function_ccb61ff92fa51926() {
  namespace_96731f4d002634f6::function_9250dfcc43a9ccb9();
  utility::flag_wait("dungeon_load_finished");
  level.var_1369e1e96a31be5e = 1;
  wait 1;
  function_71a51c41fcd32631();
  var_ab15037bb428fc34 = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("default_player_start");

  if(isDefined(var_ab15037bb428fc34)) {
    level.player player::teleport_player(var_ab15037bb428fc34);
  }

  utility::flag_set("setup_finished");
  utility::flag_wait("checkpoint_data_retrieved");
  level.var_63a384932dd6c5a7 = 1;
  utility::flag_wait("player_spawned_with_loadout");
  utility::flag_set("flag_intro_start");
  utility::flag_set("flag_dungeon_intro_complete");
  hidecinematicletterboxing(2.5);
}

function assault_main() {
  utility::flag_wait("setup_finished");
  utility::flag_wait("player_spawned_with_loadout");
  level_setup();
  utility::flag_wait("dungeon_load_finished");
  thread namespace_15df8b4c55fd9ffe::function_26280fbed5700639();

  if(istrue(level.checkpoint_reached)) {
    return;
  }

  thread assault_ai();
  thread namespace_7f4f66b90d3178e7::function_86cf2e4b31d401();

  while(level.bombsdefused < level.numbombs) {
    waitframe();
  }

  level.var_5843e823f7ef9a57 = 0;
  var_4e706e1f61c803da = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("bomb_search_water");

  if(level.player istouching(var_4e706e1f61c803da)) {
    level.var_5843e823f7ef9a57 = 1;
  }
}

function assault_ai() {
  utility::flag_wait("stealth_ranges_initialized");
  utility::flag_wait("flag_dungeon_intro_complete");

  if(istrue(level.var_2067c1c6a29f4998)) {
    return;
  }

  level.var_2067c1c6a29f4998 = 1;
  level.var_a24a4cc213c846cc = [];
  namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_initial", &function_1014e5c131b2afd3);
  namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_initial_sniper", &function_836a1e5643d1606);
  level.var_489135071ae5090c = 0;
  level.bunker_alerted = 0;
  level.var_fee873cab0bb6a56 = 0;
  level.var_909a1937565d7664 = 0;
  level.var_6cc119b2f0ef77f = 0;
  level.var_d2113b3fb11372f = 0;
  level.var_d8229d42991a54ad = 0;
  level.var_3f8da442d7840637 = 0;
  level thread function_aafa1b6007c6bd6f();
  namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_initial_bridge", &function_9b9136303c62b3cc);
  namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_initial_bunker", &function_59b2cebeb49d173c);
  namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_initial_catwalk", &function_5965475d85a1ab7a);
  namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_initial_truck", &function_ee124b618926eae4);
  level thread function_805419b846c8e9d6();
  level thread function_4518d11f0fa51f36();
  level thread function_f917b99d7bb6a590();
  level thread function_3c8763aad7c140e();
  start_trigger = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("dam_start_trigger");

  if(!isDefined(start_trigger)) {
    return;
  }

  level.var_ee71c0848a6901d2 = [];
  thread spawn_start_ai();
  thread parachute_hint(start_trigger);
  function_e40d56e8b967bcf7();

  while(level.player istouching(start_trigger)) {
    waitframe();
  }

  start_left = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("dam_start_left");
  start_right = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("dam_start_right");

  if(isDefined(start_left) && isDefined(start_right)) {
    while(level.player istouching(start_left) || level.player istouching(start_right)) {
      waitframe();
    }
  }

  thread function_24b38f6efc470d93();
  objpoints = utility::getStructArray("obj_bomb_interact", "targetname");
  var_12dd524bd33a44eb = getEnt("obj_bomb_interact", "targetname");
  objpoints = utility::array_add(objpoints, var_12dd524bd33a44eb);
  thread function_a63852b8dbbbd42e();
  thread function_7d46be4ce480ee1a();
  thread function_a94ae0bd7db49b48();
  thread function_85c6ec8acba73e06();
}

function function_24b38f6efc470d93() {
  flag_wait("player_jumped_off_starting_catwalk");
  thread function_9a317a92ee9bd3c8();
  thread function_1fc5ae142717810a();
  thread function_f84d364ed4c388bb();
}

function function_9a317a92ee9bd3c8() {
  while(!utility::flag("bunker_bomb_site_approached") && level.bunker_alerted < 1) {
    waitframe();
  }

  namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_initial_bunker_latespawn", &function_59b2cebeb49d173c);
}

function function_1fc5ae142717810a() {
  while(!utility::flag("bunker_bomb_site_approached") && !utility::flag("catwalk_bomb_site_approached") && level.var_fee873cab0bb6a56 < 1) {
    waitframe();
  }

  namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_initial_catwalk_latespawn", &function_5965475d85a1ab7a);
}

function function_f84d364ed4c388bb() {
  trigger1 = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("defend_trigger");

  while(!level.player istouching(trigger1) && level.bunker_alerted < 3 && level.var_fee873cab0bb6a56 < 3) {
    waitframe();
  }

  namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_initial_powerplant", &function_1014e5c131b2afd3);
}

function function_e40d56e8b967bcf7() {
  wait 0.5;
  var_bfbd8f66b67dfc29 = getaiarray("axis");

  if(!isDefined(var_bfbd8f66b67dfc29)) {
    return;
  }

  foreach(ai in var_bfbd8f66b67dfc29) {
    ai function_d493e7fe15e5eaf4("jup_sandbox_sniper");
    ai function_9215ce6fc83759b9(8000);
  }
}

function parachute_hint(start_trigger) {
  utility::flag_wait("flag_dungeon_intro_complete");
  wait 30;

  while(level.player istouching(start_trigger)) {
    level.player scripts\cp\cp_hud_message::tutorialprint(&"CP_DAM/HINTPARACHUTE", 3);
    wait 1;
  }

  level.player clearhudtutorialmessage();
}

function function_aafa1b6007c6bd6f() {
  utility::flag_wait("flag_dungeon_intro_complete");

  while(!function_1bb1470f934a81eb()) {
    waitframe();
  }

  function_401d0838f4f47c3e(1);
}

function function_805419b846c8e9d6() {
  var_1f86984ce9e500eb = getEnt("truck_bomb_site_vol", "targetname");

  if(!isDefined(var_1f86984ce9e500eb)) {
    return;
  }

  while(!level.player istouching(var_1f86984ce9e500eb)) {
    waitframe();
  }

  flag_set("truck_bomb_site_approached");
  level notify("truck_bomb_site_approached");
}

function function_4518d11f0fa51f36() {
  var_326d504541c0f5cb = getEnt("water_bomb_site_vol", "targetname");

  if(!isDefined(var_326d504541c0f5cb)) {
    return;
  }

  while(!level.player istouching(var_326d504541c0f5cb)) {
    waitframe();
  }

  flag_set("water_bomb_site_approached");
  level notify("water_bomb_site_approached");
}

function function_f917b99d7bb6a590() {
  var_384c9400ef6cddd = getEnt("catwalk_bomb_site_vol", "targetname");

  if(!isDefined(var_384c9400ef6cddd)) {
    return;
  }

  while(!level.player istouching(var_384c9400ef6cddd)) {
    waitframe();
  }

  flag_set("catwalk_bomb_site_approached");
  level notify("catwalk_bomb_site_approached");
}

function function_3c8763aad7c140e() {
  var_7acf4d30564ce813 = getEnt("bunker_bomb_site_vol", "targetname");

  if(!isDefined(var_7acf4d30564ce813)) {
    return;
  }

  while(!level.player istouching(var_7acf4d30564ce813)) {
    waitframe();
  }

  flag_set("bunker_bomb_site_approached");
  level notify("bunker_bomb_site_approached");
}

function function_a63852b8dbbbd42e() {
  areatrigger = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("truck_reinf_trigger");

  if(!isDefined(areatrigger)) {
    return;
  }

  while(level.var_909a1937565d7664 < 3 || level.var_3f8da442d7840637 > 3) {
    waitframe();
  }

  if(utility::flag("flag_bomb_truck_defused")) {
    return;
  }

  if(!any_groups_in_combat()) {
    return;
  }

  if(level.bombsdefused < 3) {
    thread namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_truck_reinf1", &function_5d1d7155fc16521f);
  }

  if(level.var_3f8da442d7840637 < 2) {
    thread namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_truck_reinf_extra", &function_5d1d7155fc16521f);
  }

  if(level.bombsdefused == 1) {
    thread function_15b27cf8040b9751("truck_reinf_truck");
    thread namespace_7f4f66b90d3178e7::function_537b15c65ccae79();
    return;
  }

  if(level.bombsdefused == 2) {
    thread function_55eb507e8423fd3b("truck_reinf_heli", "truck_helo_unload");
    thread namespace_7f4f66b90d3178e7::function_57a8fcb266b0f311();
    return;
  }

  if(level.bombsdefused > 2) {
    thread function_15b27cf8040b9751("truck_reinf_truck");
    thread function_7ca52a2b3f9615af("truck_paratrooper_plane");
    thread namespace_7f4f66b90d3178e7::function_8115d486ae5ddaa();
    return;
  }

  thread namespace_7f4f66b90d3178e7::function_694866c779854c31();
}

function function_a94ae0bd7db49b48() {
  lefttrigger = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("reinf_trigger_catwalk_left");
  var_13e94466b336236f = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("reinf_trigger_catwalk_right");

  while(level.var_fee873cab0bb6a56 < 3 || level.var_d8229d42991a54ad > 3) {
    waitframe();
  }

  if(utility::flag("flag_bomb_2_defused")) {
    return;
  }

  if(!any_groups_in_combat()) {
    return;
  }

  if(distance(level.player.origin, var_13e94466b336236f.origin) < distance(level.player.origin, lefttrigger.origin)) {
    if(level.bombsdefused < 3) {
      thread namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_catwalk_left_reinf1", &function_5d1d7155fc16521f);
    }

    if(level.var_d8229d42991a54ad < 2) {
      thread namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_catwalk_reinf_extra", &function_5d1d7155fc16521f);
    }

    if(level.bombsdefused == 1) {
      thread function_15b27cf8040b9751("catwalk_reinf_truck");
      thread namespace_7f4f66b90d3178e7::function_537b15c65ccae79();
    } else if(level.bombsdefused == 2) {
      thread function_55eb507e8423fd3b("catwalk_reinf_heli", "catwalk_helo_unload");
      thread namespace_7f4f66b90d3178e7::function_57a8fcb266b0f311();
    } else if(level.bombsdefused > 2) {
      thread function_15b27cf8040b9751("catwalk_reinf_truck");
      thread function_7ca52a2b3f9615af("catwalk_paratrooper_plane");
      thread namespace_7f4f66b90d3178e7::function_8115d486ae5ddaa();
    } else {
      thread namespace_7f4f66b90d3178e7::function_694866c779854c31();
    }

    return;
  }

  if(level.bombsdefused < 3) {
    thread namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_catwalk_right_reinf1", &function_5d1d7155fc16521f);
  }

  if(level.var_d8229d42991a54ad < 2) {
    thread namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_catwalk_reinf_extra", &function_5d1d7155fc16521f);
  }

  if(level.bombsdefused == 1) {
    thread function_15b27cf8040b9751("catwalk_reinf_truck");
    thread namespace_7f4f66b90d3178e7::function_537b15c65ccae79();
    return;
  }

  if(level.bombsdefused == 2) {
    thread function_55eb507e8423fd3b("catwalk_reinf_heli", "catwalk_helo_unload");
    thread namespace_7f4f66b90d3178e7::function_57a8fcb266b0f311();
    return;
  }

  if(level.bombsdefused > 2) {
    thread function_15b27cf8040b9751("catwalk_reinf_truck");
    thread function_7ca52a2b3f9615af("catwalk_paratrooper_plane");
    thread namespace_7f4f66b90d3178e7::function_8115d486ae5ddaa();
    return;
  }

  thread namespace_7f4f66b90d3178e7::function_694866c779854c31();
}

function function_7d46be4ce480ee1a() {
  lefttrigger = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("reinf_trigger_water_left");
  var_13e94466b336236f = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("reinf_trigger_water_right");

  while(level.var_489135071ae5090c < 3 || level.var_6cc119b2f0ef77f > 3) {
    waitframe();
  }

  if(utility::flag("flag_bomb_1_defused")) {
    return;
  }

  if(!any_groups_in_combat()) {
    return;
  }

  if(distance(level.player.origin, var_13e94466b336236f.origin) < distance(level.player.origin, lefttrigger.origin)) {
    if(level.bombsdefused < 3) {
      thread namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_bridge_left_reinf1", &function_5d1d7155fc16521f);
    }

    if(level.var_6cc119b2f0ef77f < 2) {
      thread namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_bridge_left_reinf_extra", &function_5d1d7155fc16521f);
    }

    if(level.bombsdefused == 1) {
      thread function_15b27cf8040b9751("bridge_left_reinf_truck");
      thread namespace_7f4f66b90d3178e7::function_537b15c65ccae79();
    } else if(level.bombsdefused == 2) {
      thread function_55eb507e8423fd3b("bridge_left_reinf_heli", "bridge_left_helo_unload");
      thread namespace_7f4f66b90d3178e7::function_57a8fcb266b0f311();
    } else if(level.bombsdefused > 2) {
      thread function_15b27cf8040b9751("bridge_left_reinf_truck");
      thread function_7ca52a2b3f9615af("bridge_paratrooper_plane");
      thread namespace_7f4f66b90d3178e7::function_8115d486ae5ddaa();
    } else {
      thread namespace_7f4f66b90d3178e7::function_694866c779854c31();
    }

    return;
  }

  if(level.bombsdefused < 3) {
    thread namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_bridge_right_reinf1", &function_5d1d7155fc16521f);
  }

  if(level.var_6cc119b2f0ef77f < 2) {
    thread namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_bridge_right_reinf_extra", &function_5d1d7155fc16521f);
  }

  if(level.bombsdefused == 1) {
    thread function_15b27cf8040b9751("bridge_right_reinf_truck");
    thread namespace_7f4f66b90d3178e7::function_537b15c65ccae79();
    return;
  }

  if(level.bombsdefused == 2) {
    thread function_55eb507e8423fd3b("bridge_right_reinf_heli", "bridge_right_helo_unload");
    thread namespace_7f4f66b90d3178e7::function_57a8fcb266b0f311();
    return;
  }

  if(level.bombsdefused > 2) {
    thread function_15b27cf8040b9751("bridge_right_reinf_truck");
    thread function_7ca52a2b3f9615af("bridge_paratrooper_plane");
    thread namespace_7f4f66b90d3178e7::function_8115d486ae5ddaa();
    return;
  }

  thread namespace_7f4f66b90d3178e7::function_694866c779854c31();
}

function function_85c6ec8acba73e06() {
  lefttrigger = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("reinf_trigger_bunker_left");
  var_13e94466b336236f = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("reinf_trigger_bunker_right");

  while(level.bunker_alerted < 3 || level.var_d2113b3fb11372f > 3) {
    waitframe();
  }

  if(utility::flag("flag_bomb_3_defused")) {
    return;
  }

  if(!any_groups_in_combat()) {
    return;
  }

  if(distance(level.player.origin, var_13e94466b336236f.origin) < distance(level.player.origin, lefttrigger.origin)) {
    thread namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_bunker_left_reinf1", &function_5d1d7155fc16521f);

    if(level.bombsdefused == 1) {
      thread function_15b27cf8040b9751("bunker_reinf_truck");
      thread namespace_7f4f66b90d3178e7::function_537b15c65ccae79();
    } else if(level.bombsdefused == 2) {
      thread function_55eb507e8423fd3b("bunker_reinf_heli", "bunker_helo_unload");
      thread namespace_7f4f66b90d3178e7::function_57a8fcb266b0f311();
    } else if(level.bombsdefused > 2) {
      if(level.var_d2113b3fb11372f < 2) {
        thread function_15b27cf8040b9751("bunker_reinf_truck");
      }

      thread function_7ca52a2b3f9615af("bunker_paratrooper_plane");
      thread namespace_7f4f66b90d3178e7::function_8115d486ae5ddaa();
    } else {
      thread namespace_7f4f66b90d3178e7::function_694866c779854c31();
    }

    return;
  }

  thread namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_bunker_right_reinf1", &function_5d1d7155fc16521f);

  if(level.bombsdefused == 1) {
    thread function_15b27cf8040b9751("bunker_reinf_truck");
    thread namespace_7f4f66b90d3178e7::function_537b15c65ccae79();
    return;
  }

  if(level.bombsdefused == 2) {
    thread function_55eb507e8423fd3b("bunker_reinf_heli", "bunker_helo_unload");
    thread namespace_7f4f66b90d3178e7::function_57a8fcb266b0f311();
    return;
  }

  if(level.bombsdefused > 2) {
    if(level.var_d2113b3fb11372f < 2) {
      thread function_15b27cf8040b9751("bunker_reinf_truck");
    }

    thread function_7ca52a2b3f9615af("bunker_paratrooper_plane");
    thread namespace_7f4f66b90d3178e7::function_8115d486ae5ddaa();
    return;
  }

  thread namespace_7f4f66b90d3178e7::function_694866c779854c31();
}

function function_15b27cf8040b9751(var_a0a8ab202195217, isexfil) {
  isexfil = utility::default_to(isexfil, 0);
  vehspawner = namespace_96731f4d002634f6::function_7a18da6e48b71c35(var_a0a8ab202195217);
  aispawner = utility::getStructArray(vehspawner.spawngroup, "targetname");
  var_3d938229096599c6 = [];

  for(i = 0; i < aispawner.size; i++) {
    if(isDefined(aispawner[i])) {
      var_3d938229096599c6 = utility::array_add(var_3d938229096599c6, aispawner[i]);
    }
  }

  vehicle = namespace_48d38898a22ee3d7::function_136d8a6a5c016d7e(vehspawner, var_3d938229096599c6, "p2p", vehspawner.target);

  foreach(rider in vehicle.riders) {
    if(isexfil) {
      rider thread function_59b37ce2be8fec73();
      continue;
    }

    rider thread function_5d1d7155fc16521f();
  }

  vehicle.var_9442d439c225c3fe = &function_dce79af7a92d464d;
  vehicle thread function_efdaa03bfc25c1a0();
  setDvar(@ "hash_3d71016015e6ad0c", 1);
}

function function_efdaa03bfc25c1a0() {
  level.player endon("death");
  self endon("vehicle_stopped");
  self endon("explode");
  self endon("death");
  lookaheadtime = 1.8;
  var_a7796ca2eb0bab7a = self getboundshalfsize();
  var_959588624f3402b3 = level.player physics_getcharactercollisioncapsule();
  var_352c5930ea8d4ee9 = var_a7796ca2eb0bab7a[1] + var_959588624f3402b3["radius"] * 4;
  var_be24014547f24daf = var_a7796ca2eb0bab7a[0] + var_959588624f3402b3["radius"] * 4;
  var_5886126ea90b44e0 = var_a7796ca2eb0bab7a[2] + var_959588624f3402b3["half_height"] * 4;

  while(true) {
    waitframe();
    var_6b051c16c0678276 = self physics_getentitycenterofmass()["unscaled"];
    vehiclespeedips = utility::mph_to_ips(self vehicle_getspeed());
    var_8ed7efe8cbdd0211 = var_be24014547f24daf + vehiclespeedips * lookaheadtime;
    var_4d81310885ca021e = anglestoaxis(self.angles);
    var_eb6c281422e00431 = 0;
    var_a893f387d3cc76c7 = level.player.origin - var_6b051c16c0678276;
    forwarddistance = vectordot(var_a893f387d3cc76c7, var_4d81310885ca021e["forward"]);

    if(forwarddistance < 0 || forwarddistance > var_8ed7efe8cbdd0211) {
      continue;
    }

    var_aecc8dacc19cf9b = abs(vectordot(var_a893f387d3cc76c7, var_4d81310885ca021e["right"]));

    if(var_aecc8dacc19cf9b < 0 || var_aecc8dacc19cf9b > var_352c5930ea8d4ee9) {
      continue;
    }

    verticaldistance = abs(vectordot(var_a893f387d3cc76c7, var_4d81310885ca021e["up"]));

    if(verticaldistance < 0 || verticaldistance > var_5886126ea90b44e0) {
      continue;
    }

    var_eb6c281422e00431 = 1;

    if(var_eb6c281422e00431) {
      namespace_48d38898a22ee3d7::function_ecbcec373d227be(1);
      self notify("vehicle_stopped");
    }

    waitframe();
  }
}

function function_55eb507e8423fd3b(var_a0a8ab202195217, var_32fb14fffb7e88f1) {
  vehspawner = namespace_96731f4d002634f6::function_7a18da6e48b71c35(var_a0a8ab202195217);
  heli = namespace_8b141a01ef32f9c7::function_e48fde1878d8a034(vehspawner);
  heli.nocrash = 1;
  thread namespace_cf0990776c0e3528::function_bfe011965db768b6(heli, var_a0a8ab202195217);

  foreach(rider in heli.riders) {
    rider.heli = heli;
    rider thread function_5d1d7155fc16521f();
  }

  heli utility::ent_flag_wait("helo_ready_to_unload");
  utility::flag_set(var_32fb14fffb7e88f1);
  heli utility::ent_flag_wait("heli_end");

  foreach(rider in heli.riders) {
    if(rider function_38100a5de7d29508()) {
      rider.diequietly = 1;
      rider.nocorpse = 1;
      rider kill();
    }
  }

  heli delete();
}

function function_38100a5de7d29508() {
  var_4f06cc2bc2e7c2f5 = getEntArray("OutOfBounds", "targetname");

  foreach(oob in var_4f06cc2bc2e7c2f5) {
    if(self istouching(oob)) {
      return true;
    }
  }

  return false;
}

function function_7ca52a2b3f9615af(var_d00ac3fea82a21fa, isexfil) {
  isexfil = utility::default_to(isexfil, 0);
  plane = utility::getStruct(var_d00ac3fea82a21fa, "targetname");
  plane = cp_aiparachute::function_512ce2eff75c0873(plane, plane.groupname);
  group = cp_aiparachute::function_fd00e772c1cf3d49(plane);
  level waittill("spawn_module_" + group.moduleid + "_completed");

  foreach(para in group.ai_spawned) {
    if(isexfil) {
      para thread function_59b37ce2be8fec73();
      continue;
    }

    para thread function_5d1d7155fc16521f();
  }
}

function spawn_start_ai() {
  start_trigger = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("dam_start_trigger");

  if(!isDefined(start_trigger)) {
    return;
  }

  thread function_220ab5bd71cd151(start_trigger);

  while(!isDefined(level.var_5528b06a2cfce7f9) || !level.var_5528b06a2cfce7f9) {
    wait 1;
  }

  enemies = getaiarray("axis");

  foreach(enemy in enemies) {
    enemy getenemyinfo(level.player);
  }

  spawn_time = utility::default_to(getdvarint(@ "hash_13896166e283ef7e"), 20);
  wait spawn_time;
  level notify("spawn_start_ai");
  namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_start", &function_730e59bca72a6ae1, 30, 5);

  while(level.player istouching(start_trigger)) {
    waitframe();
  }

  spawning::stop_module_by_groupname("ai_start", 0);
  wait 1;

  foreach(ai in level.var_ee71c0848a6901d2) {
    if(isDefined(ai)) {
      ai.nocorpse = 1;
      ai.diequietly = 1;
      ai kill();
    }
  }

  start_left = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("dam_start_left");
  start_right = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("dam_start_right");
  spawn_name = "";

  if(!isDefined(start_left) || !isDefined(start_right)) {
    return;
  }

  if(level.player istouching(start_left)) {
    spawn_name = "ai_start_right";
  } else if(level.player istouching(start_right)) {
    spawn_name = "ai_start_left";
  }

  namespace_9871da81deb2e4b0::function_6149b301ce19988b(spawn_name, &function_730e59bca72a6ae1, 30, 10);

  while(level.player istouching(start_left) || level.player istouching(start_right)) {
    waitframe();
  }

  spawning::stop_module_by_groupname(spawn_name, 0);
  wait 3;

  foreach(ai in level.var_ee71c0848a6901d2) {
    if(isDefined(ai)) {
      ai.nocorpse = 1;
      ai.diequietly = 1;
      ai kill();
    }
  }
}

function function_220ab5bd71cd151(area) {
  wait 1;
  var_9aaf9f80d352bcc6 = level.var_a24a4cc213c846cc[0].weapon;
  bullet_start = function_7a18da6e48b71c35("magic_bullet");
  level waittill("spawn_start_ai");
  wait 15;
  var_236c224b1e9d9d3e = 1;

  while(level.player istouching(area) && !level.player isparachuting()) {
    for(i = 0; i < var_236c224b1e9d9d3e; i++) {
      magicbullet(var_9aaf9f80d352bcc6, bullet_start.origin, level.player gettagorigin("j_spine4"));
    }

    var_236c224b1e9d9d3e++;
    wait randomfloatrange(2, 7);
  }
}

function function_730e59bca72a6ae1(group_name, func) {
  level.var_ee71c0848a6901d2 = utility::array_add(level.var_ee71c0848a6901d2, self);
  thread function_f98463d49e2f9067();
  thread function_dd08a1c6eb250371(1);
  utility::set_battlechatter(1);
}

function function_9b9136303c62b3cc(group_name, func) {
  level.var_6cc119b2f0ef77f++;
  thread function_f97c2129d696f18c("bridge");
  thread function_f98463d49e2f9067();
}

function function_7df9c03b918465f7(group_name) {
  if(isDefined(group_name)) {
    return issubstr(group_name.group_name, "latespawn");
  }

  return 0;
}

function function_59b2cebeb49d173c(group_name, func) {
  level.var_d2113b3fb11372f++;
  thread function_f97c2129d696f18c("bunker");
  self.var_ed226d8102009b82 = function_7df9c03b918465f7(group_name);
  thread function_f98463d49e2f9067();
}

function function_5965475d85a1ab7a(group_name, func) {
  level.var_d8229d42991a54ad++;
  thread function_f97c2129d696f18c("catwalk");
  self.var_ed226d8102009b82 = function_7df9c03b918465f7(group_name);
  thread function_f98463d49e2f9067();
}

function function_ee124b618926eae4(group_name, func) {
  level.var_3f8da442d7840637++;
  thread function_f97c2129d696f18c("truck");
  self.var_ed226d8102009b82 = function_7df9c03b918465f7(group_name);
  thread function_f98463d49e2f9067();
}

function function_f97c2129d696f18c(location) {
  thread function_858583064c2814fb(location);
  self endon("death");

  while(true) {
    while(!self[[self.fnisinstealthcombat]]()) {
      waitframe();
    }

    wait 3;

    if(self[[self.fnisinstealthcombat]]()) {
      break;
    }
  }

  switch (location) {
    case #"hash_bd09950854d77c70":
      level.var_489135071ae5090c++;
      break;
    case #"hash_ec91a685aa7f22c0":
      level.bunker_alerted++;
      break;
    case #"hash_32afa0932832c1e2":
      level.var_fee873cab0bb6a56++;
      break;
    case #"hash_bd2b14a6c78f31a8":
      level.var_909a1937565d7664++;
      break;
  }
}

function function_858583064c2814fb(location) {
  self waittill("death");

  switch (location) {
    case #"hash_bd09950854d77c70":
      level.var_6cc119b2f0ef77f--;
      break;
    case #"hash_ec91a685aa7f22c0":
      level.var_d2113b3fb11372f--;
      break;
    case #"hash_32afa0932832c1e2":
      level.var_d8229d42991a54ad--;
      break;
    case #"hash_bd2b14a6c78f31a8":
      level.var_3f8da442d7840637--;
      break;
  }
}

function function_1014e5c131b2afd3(group_name, func) {
  thread function_f98463d49e2f9067();
}

function function_f98463d49e2f9067(var_4f855452f4b35b26, override_damage_sight_range) {
  var_4f855452f4b35b26 = default_to(var_4f855452f4b35b26, "jup_sandbox_dark");
  function_6afcdc96a6ce9a56(var_4f855452f4b35b26, &namespace_7f4f66b90d3178e7::function_cc116388b57ace53, override_damage_sight_range);
  function_40cf59cafe23b2d4();

  if(istrue(self.var_ed226d8102009b82)) {} else {
    namespace_e1447aac8628ea7d::function_95515c853e90472c("dam_main", self);
  }

  setdvarifuninitialized(@ "hash_42417cffcfb34e5", 0);

  if(isDefined(self.group)) {
    childthread function_e6fc53e242f10d37(self.group.group_name);
  }

  if(isDefined(self.spawner) && isDefined(self.spawner.script_laser) && self.spawner.script_laser == "1") {
    thread function_44b8500225eefffd();
  }
}

function function_44b8500225eefffd() {
  flag_wait("player_spawned_with_loadout");
  self endon("death");
  level.player endon("death");
  ent_flag_set("laser_visible");
  var_69640bfba5a5d313 = 16000000;

  while(true) {
    wait 1;
    dist_sq = distancesquared(level.player.origin, self.origin);
    should_show = dist_sq < var_69640bfba5a5d313;

    if(!should_show) {
      should_show = isDefined(self.enemy) && self.enemy == level.player && self seerecently(level.player, 1) && dist_sq < self.var_57956d515cda7d03 * self.var_57956d515cda7d03;
    }

    if(ent_flag("laser_visible") && !should_show) {
      self laserforceoff();
      ent_flag_clear("laser_visible");
      continue;
    }

    if(!ent_flag("laser_visible") && should_show) {
      self laserforceon();
      ent_flag_set("laser_visible");
    }
  }
}

function private function_e6fc53e242f10d37(string) {
  while(true) {
    if(getdvarint(@ "hash_42417cffcfb34e5", 0)) {
      if(isDefined(string)) {
        print3d(self.origin - (0, 0, 10), string, (0.1, 1, 0), 1, 0.75);
      }

      if(istrue(self.var_4ebe755e0a0a430e)) {
        print3d(self.origin - (0, 0, 15), "<dev string:x93>", (0.1, 1, 0), 1, 0.75);
      }
    }

    waitframe();
  }
}

function function_836a1e5643d1606(group_name, func) {
  thread function_f98463d49e2f9067("jup_sandbox_sniper");
  level.var_a24a4cc213c846cc = utility::array_add(level.var_a24a4cc213c846cc, self);
}

function function_5d1d7155fc16521f(group_name, func) {
  thread function_f98463d49e2f9067();
  self.baseaccuracy *= 1.1;
  self.aggressivemode = 1;
  thread function_dd08a1c6eb250371(1);
}

function function_b83cbee4a86a2bce(var_c1651f9104447a56, var_fee4eb5d0ea10ea9) {
  for(var_6de05f91a204c737 = 0; var_6de05f91a204c737 < var_fee4eb5d0ea10ea9 && var_c1651f9104447a56.size > 0; var_6de05f91a204c737++) {
    wait 0.25;
    var_55d44c537d7dcfb8 = var_c1651f9104447a56[var_c1651f9104447a56.size - 1];

    if(isDefined(var_55d44c537d7dcfb8)) {
      var_55d44c537d7dcfb8 function_dd08a1c6eb250371();
      var_c1651f9104447a56 = utility::array_remove(var_c1651f9104447a56, var_55d44c537d7dcfb8);
    }
  }
}

function function_dd08a1c6eb250371(var_4d229ef15616a8d2) {
  player = level.player;

  if(isDefined(player)) {
    event = spawnStruct();
    event.typeorig = "combat";
    event.type = "combat";
    event.origin = player.origin;
    event.investigate_pos = player.origin;
    self[[self.fnsetstealthstate]]("combat", event);
  }

  utility::set_ai_number();

  if(isDefined(var_4d229ef15616a8d2) && istrue(var_4d229ef15616a8d2)) {
    thread function_17ec2637c87d3402();
  }
}

function function_b478a0e9fe306b62() {
  heli = level.attackheli;

  if(isDefined(heli)) {
    var_9ea0313a47d6115 = heli.heli_targets[0];

    if(isDefined(var_9ea0313a47d6115)) {
      event = spawnStruct();
      event.typeorig = "combat";
      event.type = "combat";
      event.origin = var_9ea0313a47d6115.origin;
      event.investigate_pos = var_9ea0313a47d6115.origin;
      self function_9215ce6fc83759b9(5500);
      self[[self.fnsetstealthstate]]("combat", event);
      self getenemyinfo(var_9ea0313a47d6115);
    }
  }
}

function function_17ec2637c87d3402() {
  self.goalheight = 1024;
  self getenemyinfo(level.player);
  self setgoalentity(level.player);
}

function exfil_setup() {
  utility::flag_wait("checkpoint_data_retrieved");
  level.var_63a384932dd6c5a7 = 1;
  level.checkpoint = "debug";
  level.var_1369e1e96a31be5e = 1;
  utility::flag_set("flag_obj_all_bombs_defused");
  utility::flag_set("flag_start_new_exfil");
  namespace_96731f4d002634f6::function_9250dfcc43a9ccb9();
  wait 1;
  utility::flag_set("flag_obj_all_bombs_defused");
  level notify("defend_transition_vo_complete");
  level.var_5843e823f7ef9a57 = 0;
  level.lastbomb = "obj_bomb_3";
  thread function_698e27a413352904();
  hidecinematicletterboxing(2.5);
}

function setup_pilot() {
  if(!isDefined(level.heli_model)) {
    return;
  }

  tag_pilot = "TAG_SEAT_0";
  heli = level.heli_model;
  heli.driver = spawn("script_model", heli gettagorigin(tag_pilot));
  heli.driver setModel("fullbody_sp_ally_pilot_western_vm");
  heli.driver linkTo(heli, tag_pilot, (0, 0, 17), (0, 0, 0));
  heli.driver scriptmodelplayanimdeltamotion("reb_vh_palfa_driver_idle_search01");
  heli.driver notsolid();
}

function function_c8c5e38506a02661() {
  level endon("game_ended");
  var_7fef2db5c1cf0510 = "attack_chopper_lookat_pos";

  if(level.var_5843e823f7ef9a57) {
    var_7fef2db5c1cf0510 = "attack_chopper_lookat_pos_alt";
  }

  var_ad685e9f56dec1ad = namespace_96731f4d002634f6::function_7a18da6e48b71c35(var_7fef2db5c1cf0510);
  exfil_ai = namespace_9871da81deb2e4b0::function_a5089164a46c97d(var_ad685e9f56dec1ad.origin, 2500);
  total_ai = getaiarray("axis");

  while(exfil_ai.size > 6 || total_ai.size > 26) {
    exfil_ai = utility::array_removedead_or_dying(exfil_ai);
    total_ai = array_removedead_or_dying(total_ai);
    wait 0.25;
  }

  utility::flag_set("ready_for_exfil_reinforcements");
}

function function_46fb5cdb3f650df7() {
  level endon("game_ended");
  total_ai = getaiarray("axis");

  while(total_ai.size > 26) {
    total_ai = array_removedead_or_dying(total_ai);
    wait 0.25;
  }

  utility::flag_set("ready_for_exfil_reinforcements");
}

function function_9697555a6ebfe655(group_name, func) {
  thread function_ed6987f69e6da409();
}

function function_ed6987f69e6da409() {
  self endon("death");
  var_479fbcab982b7080 = "path_exfil_foot_west";
  var_99154cef3cce1536 = "path_exfil_foot_east_3";

  if(level.var_5843e823f7ef9a57) {
    var_479fbcab982b7080 = "path_exfil_foot_west_alt";
    var_99154cef3cce1536 = "path_exfil_foot_turbine";
  }

  goal1 = utility::getStruct(var_479fbcab982b7080, "targetname");
  goal2 = utility::getStruct(var_99154cef3cce1536, "targetname");

  if(isDefined(goal1) && isDefined(goal2)) {
    ai::set_forcegoal();
    distance1 = distance(self.origin, goal1.origin);
    distance2 = distance(self.origin, goal2.origin);

    if(distance1 > distance2) {
      goal1 = goal2;
    }

    utility::demeanor_override("cqb");
    self setgoalpos(goal1.origin, goal1.radius);

    while(distance(goal1.origin, self.origin) > goal1.radius && !namespace_9871da81deb2e4b0::player_spotted()) {
      wait 0.1;
    }

    ai::unset_forcegoal();

    if(namespace_9871da81deb2e4b0::player_spotted()) {
      utility::clear_demeanor_override();
    }
  }

  function_59b37ce2be8fec73();
}

function function_220e1611c0424d2b() {
  heli = level.attackheli;

  if(isDefined(heli)) {
    dist = distance(heli.origin, self.origin);

    if(dist <= 5000) {
      function_b478a0e9fe306b62();
      return true;
    }
  }

  return false;
}

function function_490df5f4f810ab6c() {
  self endon("death");
  self.var_ed226d8102009b82 = 1;
  function_f98463d49e2f9067();
  self.aggressivemode = 1;
  utility::set_battlechatter(0);
  [[self.fnsetstealthstate]]("combat");
  self.var_587d8840dea10869 = 1;
  self.var_97db6f81ba0702e3 = 0;
  wait 0.05;
  level.forced_hunt = 1;
  self.forced_investigate = 1;
  coop_stealth::function_7e00903590974138();
  utility::set_battlechatter(1);
  wait 1;
  self.var_587d8840dea10869 = 0;
  self.var_97db6f81ba0702e3 = undefined;
}

function function_f945e416f1d784d3(group_name, func) {
  thread function_c66058c7ddf92ff();
}

function function_c66058c7ddf92ff() {
  self endon("death");
  function_490df5f4f810ab6c();

  while(!function_220e1611c0424d2b() && (!isDefined(self.enemy) || self.enemy != level.player)) {
    wait 0.25;
  }

  level.var_c72a8ac12cf04000 = 1;
  self function_9215ce6fc83759b9(5500);
  self setcanusecover(1);
}

function function_59b37ce2be8fec73(group_name, func) {
  thread function_92a8b4471d60a65f();
}

function function_92a8b4471d60a65f(group_name, func) {
  self endon("death");
  function_490df5f4f810ab6c();

  while(!function_220e1611c0424d2b() && (!isDefined(self.enemy) || self.enemy != level.player)) {
    wait 0.25;
  }

  level.var_c72a8ac12cf04000 = 1;
  self function_9215ce6fc83759b9(5500);
  self setcanusecover(1);
  var_cfd6efff001e296b = "volume_exfil_combat";

  if(level.var_5843e823f7ef9a57) {
    var_cfd6efff001e296b = "volume_exfil_combat_alt";
  }

  self cleargoalvolume();
  self clearentitytarget();
  self.goalradius = 1500;
  goal_vol = namespace_96731f4d002634f6::function_1c4d592029f2b0d3(var_cfd6efff001e296b);
  self setgoalvolumeauto(goal_vol);
  is_rusher = self.aitype == "shotgun_t3_rus_pmc_konni_elite" || self.aitype == "smg_t3_rus_pmc_konni_elite";

  if(is_rusher) {
    while(!isDefined(self.enemy) || self.enemy != level.player) {
      wait 0.5;
    }

    wait 6;

    if(!isDefined(level.rushers) || !isarray(level.rushers)) {
      level.rushers = [];
    }

    while(true) {
      if(level.rushers.size < 1) {
        level.rushers[level.rushers.size] = self;
        wait randomfloatrange(4, 5);
        self function_710bd6843f902d50(level.player, 1);
        thread function_dd08a1c6eb250371(1);
        self clearentitytarget();
        self.script_stealthgroup = "";
        self.favoriteenemy = level.player;
        self getenemyinfo(level.player);
        self.lastenemysightpos = level.player.origin;
        thread close_in_on_player();

        if(getdvarint(@ "hash_4571b64acc30928f", 0)) {
          while(true) {
            thread utility::drawsphere(self getEye(), 10, 0.1, (0, 1, 0));
            wait 0.1;
          }
        }

        return;
      }

      level.rushers = utility::array_removedead_or_dying(level.rushers);
      wait 1;
    }
  }
}

function close_in_on_player() {
  self endon("death");
  self getenemyinfo(level.player);
  self cleargoalvolume();
  self.goalradius = 600 + randomint(150);
  self setgoalentity(level.player);

  while(self.goalradius > 300) {
    wait 15;
    self.goalradius = max(300, self.goalradius - 100);
  }
}

function function_4c0665979aa0df16() {
  level endon("game_ended");
  level.player endon("death");
  wait 1;

  if(level.var_5843e823f7ef9a57) {
    var_99048828f621b4f0 = "trigger_exfil_b";
  } else {
    var_99048828f621b4f0 = "trigger_exfil_a";
  }

  var_5418e14b7e29902b = namespace_96731f4d002634f6::function_1c4d592029f2b0d3(var_99048828f621b4f0);

  if(!level.player istouching(var_5418e14b7e29902b)) {
    while(true) {
      var_5418e14b7e29902b waittill("trigger", entity);
      is_player = isPlayer(entity) || function_61e2a08d58acf36c(entity);

      if(!is_player) {
        continue;
      } else if(!player::isreallyalive(entity)) {
        continue;
      }

      break;
    }
  }

  utility::flag_set("player_hit_start_exfil_trigger");
}

function function_5b4ddbf2020959fe() {
  thread function_c8c5e38506a02661();
  level waittill("ready_for_exfil_reinforcements");
  var_e4333fc705124c98 = "exfil_right_truck";
  var_98d85a512b28018d = "ai_bridge_reinf_foot_adds";
  var_a9d541fee0c57ed4 = "exfil_truck_add";

  if(level.var_5843e823f7ef9a57) {
    var_e4333fc705124c98 = "exfil_reinf_truck_alt";
    var_98d85a512b28018d = "ai_bridge_reinf_foot_adds_alt";
  }

  function_15b27cf8040b9751(var_e4333fc705124c98, 1);
  thread function_46fb5cdb3f650df7();
  level waittill("ready_for_exfil_reinforcements");
  thread namespace_9871da81deb2e4b0::function_6149b301ce19988b(var_98d85a512b28018d, &function_59b37ce2be8fec73);
  wait 10;
  thread function_46fb5cdb3f650df7();
  level waittill("ready_for_exfil_reinforcements");
  areatrigger = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("reinf_trigger_water_right");

  while(!level.player istouching(areatrigger)) {
    waitframe();
  }

  function_15b27cf8040b9751(var_a9d541fee0c57ed4, 1);
}

function function_b26596bbf4c27bdd() {
  if(!isDefined(level.player)) {
    return;
  }

  ai_array = getaiarray("axis");
  ai_array = array_removedead_or_dying(ai_array);

  foreach(ai in ai_array) {
    dist_from_player = distance2d(level.player.origin, ai.origin);

    if(dist_from_player > 2500) {
      if(ai namespace_9871da81deb2e4b0::player_spotted()) {
        continue;
      }

      if(player_can_see_ai(level.player, ai, 250)) {
        continue;
      }

      ai.nocorpse = 1;
      ai.diequietly = 1;
      ai kill();
    }
  }

  ai_array = array_removedead_or_dying(ai_array);

  if(ai_array.size > 26) {
    foreach(ai in ai_array) {
      dist_from_player = distance2d(level.player.origin, ai.origin);

      if(dist_from_player > 2500) {
        if(player_can_see_ai(level.player, ai, 250)) {
          continue;
        }

        ai.nocorpse = 1;
        ai.diequietly = 1;
        ai kill();
      }
    }

    ai_array = array_removedead_or_dying(ai_array);
  }

  if(ai_array.size > 26) {
    ai_array = sortbydistance(ai_array, level.player.origin);

    for(i = ai_array.size - 1; i >= 0; i--) {
      ai = ai_array[i];
      dist_from_player = distance2d(level.player.origin, ai.origin);

      if(dist_from_player > 1500) {
        if(player_can_see_ai(level.player, ai, 250)) {
          continue;
        }

        ai.nocorpse = 1;
        ai.diequietly = 1;
        ai kill();
      }
    }
  }

  return array_removedead_or_dying(ai_array);
}

function function_8a277436ede7285e(ai_array, amount, spawner_location) {
  var_1ff22602090a47ad = level.player.origin;

  if(isDefined(spawner_location)) {
    spawns = getStructArray(spawner_location, "targetname");

    if(isDefined(spawns) && isarray(spawns) && isDefined(spawns[0]) && isDefined(spawns[0].origin)) {
      var_1ff22602090a47ad = spawns[0].origin;
    }
  }

  while(amount > 0 && isDefined(ai_array) && isarray(ai_array) && ai_array.size > 0) {
    ai = function_4d046f33253e46e0(var_1ff22602090a47ad, ai_array);
    ai_array = array_remove(ai_array, ai);

    if(isDefined(ai.weapon) && ai.weapon.classname != "sniper") {
      ai thread function_ed6987f69e6da409();
      amount -= 1;

      ai thread function_8de2f3d6c722a517();
    }
  }

  return ai_array;
}

function function_8de2f3d6c722a517() {
  self endon("<dev string:xa8>");

  if(getdvarint(@ "hash_4571b64acc30928f", 0)) {
    while(true) {
      utility::drawsphere(self getEye(), 10, 0.1, (0, 1, 0));
    }
  }
}

function exfil_main() {
  level endon("game_ended");
  level.var_c72a8ac12cf04000 = 0;
  utility::flag_wait("player_spawned_with_loadout");
  utility::flag_wait("flag_start_new_exfil");
  utility::flag_wait("flag_obj_all_bombs_defused");
  level.player endon("death");
  namespace_b96fa4d8ce10f926::function_ebd9a9c9789d200f();

  if(istrue(level.var_22e44d0ca481bd01)) {
    return;
  }

  level.var_22e44d0ca481bd01 = 1;
  namespace_15df8b4c55fd9ffe::function_c8abae08e191a6c7();
  namespace_15df8b4c55fd9ffe::function_7b3ec3155fda930b();
  namespace_15df8b4c55fd9ffe::function_26280fbed5700639();
  ai_array = function_b26596bbf4c27bdd();
  thread function_4c0665979aa0df16();
  utility::delaythread(75, &utility::flag_set, "timer_force_start_exfil");
  level utility::waittill_any_2("player_hit_start_exfil_trigger", "timer_force_start_exfil");
  var_beacb13fcc97102c = "ai_bridge_reinf_foot_east";
  var_9873ebf2ce3c5c7e = "ai_bridge_reinf_foot_west";

  if(level.var_5843e823f7ef9a57) {
    var_beacb13fcc97102c = "ai_reinf_foot_turbine";
    var_9873ebf2ce3c5c7e = "ai_reinf_foot_west";
  }

  ai_array = array_removedead_or_dying(ai_array);
  ai_count = ai_array.size;
  thread namespace_9871da81deb2e4b0::function_6149b301ce19988b(var_beacb13fcc97102c, &function_9697555a6ebfe655);

  if(ai_count <= 22) {
    thread namespace_9871da81deb2e4b0::function_6149b301ce19988b(var_9873ebf2ce3c5c7e, &function_9697555a6ebfe655);
  } else {
    ai_array = function_8a277436ede7285e(ai_array, 4, var_9873ebf2ce3c5c7e);
  }

  if(ai_count <= 18) {
    thread function_7ff19688fb258b53();
  } else if(isDefined(level.lastbomb)) {
    switch (level.lastbomb) {
      case #"hash_c1d4a8d83a2e610b":
        ai_array = function_8a277436ede7285e(ai_array, 4, "ai_exfil_bridge_reinf1");
        break;
      case #"hash_c1d4a9d83a2e629e":
        ai_array = function_8a277436ede7285e(ai_array, 4, "ai_exfil_catwalk_reinf1");
        break;
      case #"hash_c1d4aad83a2e6431":
        ai_array = function_8a277436ede7285e(ai_array, 3, "ai_exfil_bunker_reinf1");
        break;
      case #"hash_d0e94206b15c8a8b":
        ai_array = function_8a277436ede7285e(ai_array, 4, "ai_exfil_truck_reinf1");
        break;
    }
  }

  utility::delaythread(35, &function_a882f221bbf726e8);
  utility::delaythread(35, &utility::flag_set, "timer_force_start_heli_entry");

  while(!level.var_c72a8ac12cf04000 && !flag("timer_force_start_heli_entry")) {
    wait 0.1;
  }

  var_ad2833555a8dc455 = "ally_attack_chopper_spawn";
  var_74274ab3980b6e8e = "entry_position_1";
  var_7fef2db5c1cf0510 = "attack_chopper_lookat_pos";

  if(level.var_5843e823f7ef9a57) {
    var_ad2833555a8dc455 = "ally_attack_chopper_spawn_alt";
    var_74274ab3980b6e8e = "entry_position_1_alt";
    var_7fef2db5c1cf0510 = "attack_chopper_lookat_pos_alt";
  }

  thread namespace_c970f31a41969fea::function_b5e04289b0ad9ca3(var_ad2833555a8dc455, var_74274ab3980b6e8e, var_7fef2db5c1cf0510);
  thread namespace_95af3005fd2ed66a::function_ed5e75134533a928();
  wait 10;
  level.var_db9ec95ee6e4d501 = 0;
  thread function_eb20c1fa064de361();
  thread namespace_95af3005fd2ed66a::function_22162fa427f12df8();
  thread function_5b4ddbf2020959fe();
  namespace_15df8b4c55fd9ffe::function_18b504ad8c1a063a();
  level waittill("exfil_vo_complete");
  utility::flag_set("flag_dungeon_outro_complete");
  wait 2;
  namespace_96731f4d002634f6::function_fa7c87f2585bd907();
}

function function_7ff19688fb258b53() {
  if(isDefined(level.lastbomb)) {
    switch (level.lastbomb) {
      case #"hash_c1d4a8d83a2e610b":
        thread namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_exfil_bridge_reinf1", &function_f945e416f1d784d3);
        thread namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_exfil_bridge_reinf2", &function_f945e416f1d784d3);
        break;
      case #"hash_c1d4a9d83a2e629e":
        thread namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_exfil_catwalk_reinf1", &function_f945e416f1d784d3);
        thread namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_exfil_catwalk_reinf2", &function_f945e416f1d784d3);
        break;
      case #"hash_c1d4aad83a2e6431":
        thread namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_exfil_bunker_reinf1", &function_f945e416f1d784d3);
        thread namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_exfil_bunker_reinf2", &function_f945e416f1d784d3);
        break;
      case #"hash_d0e94206b15c8a8b":
        thread namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_exfil_truck_reinf1", &function_f945e416f1d784d3);
        thread namespace_9871da81deb2e4b0::function_6149b301ce19988b("ai_exfil_truck_reinf2", &function_f945e416f1d784d3);
        break;
    }
  }
}

function function_69730d5fe4ade1e4() {
  ai_array = getaiarray("axis");
  ai_array = array_removedead_or_dying(ai_array);

  foreach(ai in ai_array) {
    ai thread function_dd08a1c6eb250371(0);
  }
}

function function_f59121d1c83e2e55() {
  level endon("game_ended");
  level.player endon("death");
  level.attackheli endon("death");
  level.attackheli thread namespace_c970f31a41969fea::function_ee9dc585f1b57c21("leave_position_1");
}

function function_878ae35ca0e14059() {
  level endon("game_ended");
  level.player endon("death");

  if(isDefined(level.var_9975e87c04b2847d)) {
    time_total = 3;
    time_elapsed = 0;
    attach_point = level.heli_model.origin - (0, 0, 150);

    while(level.var_9975e87c04b2847d.origin != attach_point) {
      new_percent = min(time_elapsed / time_total, 1);
      level.var_9975e87c04b2847d.origin = vectorlerp(level.var_9975e87c04b2847d.origin, attach_point, new_percent);
      time_elapsed += 0.03;
      attach_point = level.heli_model.origin - (0, 0, 150);
      wait 0.03;
    }

    level.var_9975e87c04b2847d linkTo(level.heli_model, "tag_origin", (0, 0, -150), (0, 0, 0));
  }
}

function function_51550970704fbc67(var_14ee3a596b49c480) {
  wait var_14ee3a596b49c480 * 0.1;
  playFXOnTag(level._effect["vfx_dam_glow_red_02"], level.heli_model, "tag_light_tail");
  playFXOnTag(level._effect["vfx_dam_heli_headlight"], level.heli_model, "tag_headlight");
  playFXOnTag(level._effect["vfx_dam_heli_cockpit_light"], level.heli_model, "tag_light_cockpit01");
  playFXOnTag(level._effect["vfx_dam_heli_cargo"], level.heli_model, "tag_light_cargo02");
}

function function_925b8e4b39a46e0d() {
  var_14ee3a596b49c480 = getanimlength(level.scr_anim["heli"]["exfil_enter"]);
  thread function_51550970704fbc67(var_14ee3a596b49c480);
  wait var_14ee3a596b49c480 * 0.5;
  utility::flag_set("flag_exfil_heli_arriving");
}

function function_eb20c1fa064de361() {
  spawner_name = "exfil_heli_spawner_new";
  heli_exit = "exfil_heli_exit";

  if(level.var_5843e823f7ef9a57) {
    spawner_name = "exfil_heli_spawner_alt";
    heli_exit = "exfil_heli_exit_alt";
  }

  spawner = utility::getStruct(spawner_name, "targetname");
  level.heli_model = namespace_8b141a01ef32f9c7::function_60437debbda12a43(spawner);
  level.heli_model.var_9bd69326cfeb9fe9 = 1;
  heli_nodes = getEnt("exfil_heli_nodes", "targetname");
  heli_nodes linkTo(level.heli_model, "tag_flare", (150, -60, 60), (30, 90, 0));

  if(isDefined(level.var_b577a3b12d46dfc1)) {
    level.var_b577a3b12d46dfc1 linkTo(level.heli_model, "tag_origin", (-70, 0, -180), (0, 100, 0));
  }

  if(isDefined(level.var_a0ea4461b934370f)) {
    level.var_a0ea4461b934370f linkTo(level.heli_model, "tag_origin", (-75, 10, -242), (0, 65, 0));
    level.var_a0ea4461b934370f solid();
  }

  level vehicle_interact::vehicle_interact_makeunusable(level.heli_model);
  level.heli_model.unload_land_offset = 260;
  level.heli_model.script_disconnectpaths = 1;
  level.heli_model vehicle::godon();
  heli_path = utility::getStruct(spawner.target, "targetname");
  level.heli_model vehicles::create_simple_path(heli_path, level.heli_model.angles);
  level.heli_model vehicle_setspeed(100, 20, 5);
  level.heli_model thread vehicle_paths::vehicle_paths_helicopter(heli_path);
  level thread function_c5343cea4a3be2cc(level.heli_model);
  level thread function_bf39df40ef93332(level.heli_model);
  playertrigger = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("exfil_player_trigger");

  if(!isDefined(playertrigger)) {
    return;
  }

  playertrigger enablelinkTo();
  playertrigger linkTo(level.heli_model, "tag_origin", (-75, 0, -205), (0, 65, 0));
  var_d507bebc454357fa = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("attack_heli_collision_zone");
  level.heli_model sethoverparams(1);

  while(!level.player istouching(playertrigger)) {
    waitframe();
  }

  level.player notify("armor_plate_done");
  level thread cp_outofbounds::enableoobimmunity(level.player);
  thread function_98dc2cdb46804c0b();
  level.var_db9ec95ee6e4d501 = 1;
  level.var_b577a3b12d46dfc1 solid();
  utility::flag_set("player_god");
  utility::flag_set("flag_exfil_heli_player_on_board");
  utility::flag_set("flag_dungeon_outro_start");
  level thread stop_exploder(204);
  thread namespace_95af3005fd2ed66a::function_a043be3abda84ede();
  thread function_f59121d1c83e2e55();
  thread function_8cef7b2083c9a101();
  var_b33cbce979768e10 = utility::getStruct(heli_exit, "targetname");
  level.heli_model vehicles::create_simple_path(var_b33cbce979768e10, level.heli_model.angles);
  level.heli_model vehicle_setspeed(50, 10, 5);
  level.heli_model setmaxpitchroll(7, 5);
  level.heli_model setyawspeed(60, 60, 60, 0.1);
  level.heli_model setturningability(0.1);
  level.heli_model thread vehicle_paths::vehicle_paths_helicopter(var_b33cbce979768e10);
}

function function_8cef7b2083c9a101() {
  level endon("game_ended");
  wait 0.5;
  level.player utility::hidehudenable();

  if(level.var_5843e823f7ef9a57) {
    view_struct = utility::getStruct("attack_chopper_lookat_pos_alt", "targetname");
  } else {
    view_struct = utility::getStruct("obj_exfil_escape", "script_noteworthy");
  }

  lockent = utility::spawn_script_origin(level.player.origin, level.player.angles);
  lockent setModel("tag_origin");
  lockent linkTo(level.heli_model);
  level.player playerlinkTo(lockent, "tag_origin");
  level.player freezecontrols(1);
  start_angle = level.player getplayerangles();
  end_angle = vectortoangles(view_struct.origin - level.player getEye());
  var_932e31f3e4e8aee9 = 25;
  var_35a0cdacf8ac5036 = abs(angleclamp180(end_angle[1] - start_angle[1]));
  var_35a0cdacf8ac5036 = max(var_35a0cdacf8ac5036 - var_932e31f3e4e8aee9, 0);
  var_4fd01f31827e6615 = abs(angleclamp180(end_angle[0] - start_angle[0]));
  var_4fd01f31827e6615 = max(var_4fd01f31827e6615 - var_932e31f3e4e8aee9, 0);

  if(var_35a0cdacf8ac5036 > 0 || var_4fd01f31827e6615 > 0) {
    var_71580efc9f6f7711 = 600;
    var_bd6c439d9dc0cfdd = clamp(math::remap(var_35a0cdacf8ac5036, 0, 180 - var_932e31f3e4e8aee9, 0, var_71580efc9f6f7711), 0, var_71580efc9f6f7711);
    var_44d170f06141358a = clamp(math::remap(var_4fd01f31827e6615, 0, 180 - var_932e31f3e4e8aee9, 0, var_71580efc9f6f7711), 0, var_71580efc9f6f7711);
    time_total = var_bd6c439d9dc0cfdd > var_44d170f06141358a ? var_bd6c439d9dc0cfdd : var_44d170f06141358a;
    start_time = gettime();
    elapsed_time = 0;
    new_percent = 0;

    while(elapsed_time < time_total) {
      elapsed_time = gettime() - start_time;
      new_percent = min(elapsed_time / time_total, 1);
      new_percent = easesine(new_percent, 1, 1);
      player_angles = level.player getplayerangles();
      new_yaw = player_angles[1];
      new_pitch = player_angles[0];

      if(var_35a0cdacf8ac5036 > 0) {
        var_220dba414ecd9e7b = clamp(math::remap(new_percent, 0, 1, 0, var_35a0cdacf8ac5036), 0, var_35a0cdacf8ac5036);
        new_yaw = math::function_804deea7a479c83b(start_angle[1], end_angle[1], var_220dba414ecd9e7b);
      }

      if(var_4fd01f31827e6615 > 0) {
        var_a3ebbbc1b8dba316 = clamp(math::remap(new_percent, 0, 1, 0, var_4fd01f31827e6615), 0, var_4fd01f31827e6615);
        new_pitch = math::function_804deea7a479c83b(start_angle[0], end_angle[0], var_a3ebbbc1b8dba316);
      }

      level.player setplayerangles((new_pitch, new_yaw, player_angles[2]));
      waitframe();
    }
  }

  var_8a255e18f4e97c7e = utility::spawn_script_origin(level.player.origin, end_angle);
  var_8a255e18f4e97c7e setModel("tag_origin");
  var_8a255e18f4e97c7e linkTo(level.heli_model);
  level.player playerlinktodelta(var_8a255e18f4e97c7e, "tag_origin", 0, 50, 50, 25, 50, 1);
}

function function_98dc2cdb46804c0b() {
  level endon("game_ended");
  level.heli_model notify("rumble_players");
  var_f92fad7f6aa2f0da = utility::getStruct("obj_exfil_escape", "script_noteworthy");

  while(true) {
    playrumbleonposition("cp_chopper_rumble", var_f92fad7f6aa2f0da.origin);
    waitframe();
  }
}

function function_c5343cea4a3be2cc(heli) {
  heli endon("death");
  utility::flag_wait("flag_exfil_heli_prepare_landing");
  utility::flag_set("flag_exfil_heli_arriving");
  level thread exploder(204);
  utility::flag_set("hover_lz");
  wait 5;
  thread function_1aa8529bb4d21c81();
  utility::flag_set("flag_exfil_heli_idle_start");
  thread namespace_95af3005fd2ed66a::function_3868039f299dfe34();
}

function function_1aa8529bb4d21c81() {
  level endon("game_ended");
  var_aeb436fe6d162639 = level.var_5843e823f7ef9a57 ? "heli_killbox_alt" : "heli_killbox";
  killbox = namespace_96731f4d002634f6::function_1c4d592029f2b0d3(var_aeb436fe6d162639);

  if(!isDefined(killbox)) {
    return;
  }

  while(!flag("flag_exfil_heli_player_on_board")) {
    if(level.player istouching(killbox)) {
      level.player kill();
      function_fa7c87f2585bd907(0);
    }

    waitframe();
  }
}

function function_bf39df40ef93332(heli) {
  utility::flag_wait("flag_exfil_heli_spawn_soap");

  if(level.var_5843e823f7ef9a57) {
    move_delay = 20;
    var_5a4687504aca1cd5 = 15;
  } else {
    move_delay = 13;
    var_5a4687504aca1cd5 = 8;
  }

  delaythread(move_delay, &function_878ae35ca0e14059);
  delaythread(var_5a4687504aca1cd5, &function_b338aa1e9ec37fbd, 14);
  level.ally = namespace_d273e883d01a4b27::function_b93dc4966b6ac70d("soap_teleport");
  level.ally.invulnerable = 1;
  level.ally.var_98e373d243c1936f = 1;
  level.ally show();
  level.ally linkTo(heli, "tag_flare", (0, 0, 0), (0, 0, 0));
  level.ally playerlinkedoffsetenable();
  level.ally fixlinktointerpolationbug(1);
  level.ally._blackboard.linkedtovehicle = 1;
  level.ally animmode("angle deltas");
  utility::flag_wait("flag_exfil_heli_prepare_landing");
  wait 2;
  level.ally utility::set_movement_speed(90);
  level.ally unlink();
  var_83405cd55ba2927 = getnode("exfil_heli_node1", "targetname");
  level.ally.goalradius = 5;
  level.ally setgoalnode(var_83405cd55ba2927);
  level.ally allowedstances("crouch");
  level.ally namespace_1170726b2799ea65::function_624150e2bc78e81f();
  level.ally waittill("goal");
  level.ally utility::set_movement_speed(0);
  lockent = spawn("script_origin", level.ally.origin);
  lockent setModel("tag_origin");
  lockent linkTo(level.heli_model);
  level.ally linkTo(lockent, "tag_origin");
  utility::flag_wait("flag_exfil_heli_player_on_board");
  level.ally allowedstances("stand");
  level.ally utility::set_movement_speed(90);
  level.ally unlink();
  var_fc6daf7825c7508a = getnode("exfil_heli_node2", "targetname");
  can_see_target = isDefined(self.currenttarget) ? level.ally cansee(self.currenttarget) : 0;

  if(!can_see_target) {
    look_struct = namespace_96731f4d002634f6::function_7a18da6e48b71c35("attack_chopper_lookat_pos");
    look_ent = spawn("script_origin", look_struct.origin);
    level.ally setentitytarget(look_ent, 1);
  }

  level.ally setgoalnode(var_fc6daf7825c7508a);
  level.ally.goalradius = 5;
  level.ally waittill("goal");
  level.ally cleargoalentity();
  level.ally utility::set_movement_speed(0);
  lockent unlink();
  lockent.origin = level.ally.origin;
  lockent linkTo(level.heli_model);
  level.ally linkTo(lockent, "tag_origin");
  wait 3;
  level.ally clearentitytarget();
  level.ally function_9215ce6fc83759b9(1);
  level.ally ai::set_gunpose("gun_down");
  level.ally.gunposeoverride = "gun_down";
  level.ally.gunposeoverride_internal = "gun_down";
  level.ally demeanoroverride("alert");
  level.ally function_1c339daaba3f71db(1);
  level.ally setlookatentity(level.player, 1);

  while(!utility::within_fov(level.ally.origin, level.ally.angles, level.player.origin, cos(15))) {
    level.ally.smartfacingpos = level.player getEye();
    level.ally ai::set_gunpose("gun_down");
    level.ally.gunposeoverride = "gun_down";
    level.ally.gunposeoverride_internal = "gun_down";
    waitframe();
  }

  level.ally function_1c339daaba3f71db(1);
  level.ally setlookatentity(level.player, 1);
}

function obj_flow() {
  utility::flag_wait("flag_objectives_registered");

  if(istrue(level.checkpoint_reached)) {
    return;
  }

  if(!utility::flag("flag_obj_all_bombs_defused")) {
    objstruct = level.objectivestabledata["obj_bombs"];
    cp_objectives::initializeobjective(objstruct, "obj_bombs", "primary");
    cp_objectives::startobjective(objstruct, "obj_bombs", "primary");
    scripts\cp\utility::objective_update("obj_bombs", undefined, undefined, undefined, undefined, level.bombsdefused);
    thread function_430de8e88f5a6516();
    utility::flag_wait("flag_obj_all_bombs_defused");
    waitframe();
    cp_objectives::completeobjective(objstruct, "obj_bombs", "primary");
  }

  level waittill("defend_transition_vo_complete");
  obj_exfil();
}

function function_e6e31cf1988f3dbe() {
  utility::flag_wait("level_ready_for_script");
  wait 3;
  thread cp_objectives::registerobjective("obj_bombs", &function_93f7737b64c0454b, &function_bec4384be8b1a1f7);
  thread cp_objectives::registerobjective("obj_exfil", &function_ad00417005075d12, &function_1b3155a6a06c0d5e);

  if(!objective_isunlimited()) {
    namespace_9d6ed0911e2ddf09::reserve_objectiveid([0, 1, 2, 3, 4]);
  }

  scripts\cp\cp_checkpoint::function_d37e0c86fbcf710b("obj_bombs", "obj_bombs_complete", &function_aff580e238d55059);
  utility::flag_set("flag_objectives_registered");
}

function function_430de8e88f5a6516() {
  while(level.bombsdefused < level.numbombs) {
    level waittill("obj_complete");
    scripts\cp\utility::objective_update("obj_bombs", undefined, undefined, undefined, undefined, level.bombsdefused);
  }

  utility::flag_set("flag_obj_all_bombs_defused");
  utility::flag_set("flag_start_new_exfil");
  level notify("all_bombs_defused");

  if(!level.checkpoint_reached) {
    function_24a31aa73c9f14a8();
  }
}

function function_24a31aa73c9f14a8() {
  level endon("game_ended");
  level.player endon("death");

  while(true) {
    while(!function_d35d9c0a5b4e48fa()) {
      waitframe();
    }

    wait 1;

    if(function_d35d9c0a5b4e48fa()) {
      break;
    }
  }

  scripts\cp\cp_checkpoint::checkpoint_set("obj_bombs_complete");
  scripts\cp\cp_checkpoint::function_5b0a03741aa420d7();
}

function function_d35d9c0a5b4e48fa() {
  return (level.player isonground() || isDefined(level.player.vehicle)) && !scripts\cp\cp_outofbounds::isoob(level.player);
}

function function_93f7737b64c0454b(objectivestruct, var_5dcdfd3a4eff9961) {
  if(isDefined(level.var_1b908bf18691b097) && isDefined(level.var_1b908bf18691b097.checkpoint)) {
    checkpoint = level.var_1b908bf18691b097.checkpoint;
  } else {
    checkpoint = 0;
  }

  if(utility::flag("flag_obj_all_bombs_defused") || checkpoint > 0) {
    utility::flag_set("flag_obj_all_bombs_defused");
    thread function_698e27a413352904();
    return;
  }

  objname = objectivestruct.objname;
  objpoints = utility::getStructArray("obj_bomb_interact", "targetname");
  var_12dd524bd33a44eb = getEnt("obj_bomb_interact", "targetname");
  objpoints = utility::array_add(objpoints, var_12dd524bd33a44eb);

  foreach(objpoint in objpoints) {
    obj_unlocked = 0;
    obj_num = undefined;
    obj_radius = 50;
    obj_moving = 0;
    var_df457c4579c02d1c = undefined;
    var_43c8545250d1a22f = undefined;

    switch (objpoint.script_noteworthy) {
      case #"hash_c1d4a8d83a2e610b":
        thread namespace_7f4f66b90d3178e7::function_8bb62aecfdc15fc8();
        obj_num = 1;
        obj_radius = 75;
        var_df457c4579c02d1c = &namespace_7f4f66b90d3178e7::function_e4aaefc47fd1b2e9;
        var_43c8545250d1a22f = &namespace_7f4f66b90d3178e7::function_2f6c6ed8cf9a2038;
        break;
      case #"hash_c1d4a9d83a2e629e":
        thread namespace_7f4f66b90d3178e7::function_bcf5cbc27f24fada();
        obj_num = 2;
        var_df457c4579c02d1c = &namespace_7f4f66b90d3178e7::function_4c599e4a22902ee1;
        var_43c8545250d1a22f = &namespace_7f4f66b90d3178e7::function_1384390d0791f3aa;
        break;
      case #"hash_c1d4aad83a2e6431":
        thread namespace_7f4f66b90d3178e7::function_65841865d493fc29();
        obj_num = 3;
        var_df457c4579c02d1c = &namespace_7f4f66b90d3178e7::function_5438611515fae301;
        var_43c8545250d1a22f = &namespace_7f4f66b90d3178e7::function_5cd1cc2cfe5c1858;
        break;
      case #"hash_d0e94206b15c8a8b":
        thread namespace_7f4f66b90d3178e7::function_90a3dd0b61222a10();
        obj_num = 0;
        var_df457c4579c02d1c = &namespace_7f4f66b90d3178e7::function_8387b0f4f7906acd;
        var_43c8545250d1a22f = &namespace_7f4f66b90d3178e7::function_884156c6f254680;
        obj_moving = 1;
        break;
    }

    var_39b470b56b1f351 = undefined;
    searchindex = undefined;
    objpoint thread namespace_9d6ed0911e2ddf09::function_dc3c295fcb6d7c77(obj_num, objpoint.script_noteworthy + "_complete", obj_radius, 1200, 500, undefined, var_df457c4579c02d1c, var_43c8545250d1a22f, obj_moving, undefined, &"CP_DAM/DEFUSE_LABEL");
    thread obj_bomb_interact(objectivestruct, objpoint, obj_moving);
  }

  var_dc5b6e9be1120180 = getEntArray("obj_bomb_model", "targetname");

  foreach(obj in var_dc5b6e9be1120180) {
    thread function_8a265440b4dee85f(obj);
  }
}

function function_8a265440b4dee85f(obj) {
  playFXOnTag(utility::getfx("vfx_dam_bomb_light_red_on"), obj, "tag_origin");

  switch (obj.script_noteworthy) {
    case #"hash_c1d4a8d83a2e610b":
      utility::flag_wait("flag_bomb_1_defused");
      break;
    case #"hash_c1d4a9d83a2e629e":
      utility::flag_wait("flag_bomb_2_defused");
      break;
    case #"hash_c1d4aad83a2e6431":
      utility::flag_wait("flag_bomb_3_defused");
      break;
  }

  killfxontag(utility::getfx("vfx_dam_bomb_light_red_on"), obj, "tag_origin");
  playFXOnTag(level._effect["vfx_dam_bomb_light_red_off"], obj, "tag_origin");
}

function function_a8ab76df89c16d59(var_956f5cfaa1473a42) {
  switch (var_956f5cfaa1473a42.script_noteworthy) {
    case #"hash_c1d4a8d83a2e610b":
      return utility::getStruct("bomb_circle_water", "targetname");
    case #"hash_c1d4a9d83a2e629e":
      return utility::getStruct("bomb_circle_catwalk", "targetname");
    case #"hash_c1d4aad83a2e6431":
      return utility::getStruct("bomb_circle_dam", "targetname");
    case #"hash_d0e94206b15c8a8b":
      return utility::getStruct("bomb_circle_truck", "targetname");
  }
}

function function_e7c30095a6cdc3ef(var_956f5cfaa1473a42, angle, dist) {
  if(!isDefined(level.player)) {
    return false;
  }

  if(!isDefined(dist)) {
    dist = 65536;
  }

  var_6bad2c3ae399c7a7 = distance(level.player.origin, var_956f5cfaa1473a42.origin);

  if(var_6bad2c3ae399c7a7 > dist) {
    return false;
  }

  wait 1;
  in_fov = utility::within_fov(level.player getEye(), level.player getplayerangles(), var_956f5cfaa1473a42.origin, cos(angle));

  if(!in_fov) {
    return false;
  }

  contents = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_ainosight"]);
  castresult = physics_raycast(level.player getEye(), var_956f5cfaa1473a42.origin, contents, undefined, 0, "physicsquery_closest", 0);

  if(isDefined(castresult) && castresult.size > 0) {
    return false;
  }

  return true;
}

function function_bec4384be8b1a1f7(objectivestruct, var_5dcdfd3a4eff9961) {}

function function_aff580e238d55059() {
  if(istrue(level.var_1369e1e96a31be5e)) {
    return;
  }

  if(!isDefined(level.var_ebc1f5321a243d72)) {
    function_ad873d6b224de9df();
    sentry_truck();
  }

  utility::flag_wait("player_spawned_with_loadout");

  if(!level.checkpoint_reached) {
    return;
  }

  level.var_f8c5ab19e120757d = 1;
  level.var_5843e823f7ef9a57 = 0;
  var_4e706e1f61c803da = namespace_96731f4d002634f6::function_1c4d592029f2b0d3("bomb_search_water");

  if(level.player istouching(var_4e706e1f61c803da)) {
    level.var_5843e823f7ef9a57 = 1;
  }

  utility::flag_set("flag_obj_all_bombs_defused");
  utility::flag_set("flag_start_new_exfil");
  thread obj_exfil();
  exfil_main();
}

function obj_exfil() {
  objstruct = level.objectivestabledata["obj_exfil"];
  cp_objectives::initializeobjective(objstruct, "obj_exfil", "primary");
  cp_objectives::startobjective(objstruct, "obj_exfil", "primary");
  utility::flag_wait("flag_dungeon_outro_start");
  cp_objectives::completeobjective(objstruct, "obj_exfil", "primary");
}

function obj_bomb_interact(objectivestruct, objpoint, truck) {
  var_bd23fae48727f19b = 1;

  if(var_bd23fae48727f19b) {
    var_cffca1a9623f41d5 = spawn("script_model", objpoint.origin);
    var_cffca1a9623f41d5.angles = objpoint.angles;
    var_cffca1a9623f41d5 setModel("jup_cp_dam_bomb_hackable");
    var_cffca1a9623f41d5.equipmentref = "equip_hackable_bomb";
    var_cffca1a9623f41d5.var_c9f381a81d2b42ed = 3;
    var_cffca1a9623f41d5.var_58dec9951efefbed = 1.5;
    var_cffca1a9623f41d5 setscriptablepartstate("hack_usable", "on");
    var_cffca1a9623f41d5.var_11e2b1aee679c522 = &function_f154ebab455c7713;
  } else {
    var_cffca1a9623f41d5 = objpoint namespace_96731f4d002634f6::create_interact(undefined, undefined, undefined, undefined, &"CP_DAM/DEFUSE_INTERACT");
    var_cffca1a9623f41d5 setuseholdduration(4000);
  }

  if(istrue(truck)) {
    var_cffca1a9623f41d5 linkTo(objpoint, "", (0, 0, -6), (0, 0, 0));

    if(getdvarint(@ "hash_e63044d7b59f5713", 0) == 1) {
      var_b657d76564c1edc4 = utility::getStruct("initial_bomb_truck", "targetname");
      var_b657d76564c1edc4.target = "bomb_truck_start_p2p_new";
      level.var_8c550b3ecc84a260 = namespace_48d38898a22ee3d7::function_136d8a6a5c016d7e(var_b657d76564c1edc4, undefined, "p2p");
      level.vehicle.var_9442d439c225c3fe = &function_dce79af7a92d464d;
    } else {
      var_b657d76564c1edc4 = utility::getStruct("initial_bomb_truck", "targetname");
      var_b657d76564c1edc4.target = "bomb_truck_start_spline";
      level.var_8c550b3ecc84a260 = namespace_48d38898a22ee3d7::function_136d8a6a5c016d7e(var_b657d76564c1edc4, undefined, "radiant_spline");
    }

    level.var_8c550b3ecc84a260 setscriptablepartstate("lights_front_cheap_dim", "on");
    level.var_8c550b3ecc84a260 setscriptablepartstate("lights_back_cheap_dim", "on");
    vehicle_interact::vehicle_interact_makeunusable(level.var_8c550b3ecc84a260);
    level.var_8c550b3ecc84a260 vehicle_damage::vehicle_damage_setCanDamage(0);
    function_401d0838f4f47c3e(0);
    thread function_797f8140e50dcfee(level.var_8c550b3ecc84a260, objectivestruct, objpoint);
    wait 10;
    namespace_b96fa4d8ce10f926::function_6ae6331457ff833d();
  }

  thread function_416fbec3871b843(objpoint);

  if(var_bd23fae48727f19b) {
    var_cffca1a9623f41d5 waittill("hacked");
  } else {
    var_cffca1a9623f41d5 waittill("trigger");
    var_cffca1a9623f41d5 delete();
  }

  level.bombsdefused++;

  if(level.bombsdefused == 4) {
    thread function_c834a17f42e70e9a(objpoint);
  }

  level notify("obj_complete");
  objpoint notify(objpoint.script_noteworthy + "_complete");

  if(istrue(truck)) {
    vehicle_interact::vehicle_interact_makeusable(level.var_8c550b3ecc84a260);
    level.var_8c550b3ecc84a260 vehicle_damage::vehicle_damage_setCanDamage(1);
    function_401d0838f4f47c3e(1);

    if(!flag("flag_bomb_truck_arrived") && length(level.var_8c550b3ecc84a260 vehicle_getvelocity()) > 1) {
      level.player function_6a369480dbaf1090("jup_sp_hitchhiker");
    }
  }

  switch (objpoint.script_noteworthy) {
    case #"hash_c1d4a8d83a2e610b":
      utility::flag_set("flag_bomb_1_defused");
      thread namespace_95af3005fd2ed66a::function_f77f935c8021b2a8();
      namespace_e1447aac8628ea7d::function_dfc307bd256d27d("bomb_1");
      utility::exploder(201);
      break;
    case #"hash_c1d4a9d83a2e629e":
      utility::flag_set("flag_bomb_2_defused");
      thread namespace_95af3005fd2ed66a::function_8b6ce0aefcf1e116();
      namespace_e1447aac8628ea7d::function_dfc307bd256d27d("bomb_2");
      utility::exploder(202);
      break;
    case #"hash_c1d4aad83a2e6431":
      utility::flag_set("flag_bomb_3_defused");
      thread namespace_95af3005fd2ed66a::function_aa298192682ee26e();
      namespace_e1447aac8628ea7d::function_dfc307bd256d27d("bomb_3");
      utility::exploder(203);
      break;
    case #"hash_d0e94206b15c8a8b":
      utility::flag_set("flag_bomb_truck_defused");
      thread namespace_95af3005fd2ed66a::function_5257909d38af100();
      namespace_e1447aac8628ea7d::function_dfc307bd256d27d("bomb_truck");
      break;
  }
}

function function_c834a17f42e70e9a(var_956f5cfaa1473a42) {
  if(var_956f5cfaa1473a42.script_noteworthy == "obj_bomb_truck" && !flag("flag_bomb_truck_arrived")) {
    mindistance = 999999;
    var_20b9e42a21960470 = utility::getStructArray("obj_bomb_interact", "targetname");

    foreach(bomb in var_20b9e42a21960470) {
      var_ad81818b14720dd6 = distance(level.player.origin, bomb.origin);

      if(var_ad81818b14720dd6 < mindistance) {
        mindistance = var_ad81818b14720dd6;
        level.lastbomb = bomb.script_noteworthy;
      }
    }

    return;
  }

  level.lastbomb = var_956f5cfaa1473a42.script_noteworthy;
}

function function_f154ebab455c7713(player) {
  self notify("hacked");
  self setscriptablepartstate("hack_usable", "off");
  self.ishacked = 1;
  self delete();
}

function function_416fbec3871b843(bomb) {
  var_6178bf8890a46508 = "";

  switch (bomb.script_noteworthy) {
    case #"hash_c1d4a8d83a2e610b":
      var_6178bf8890a46508 = "flag_bomb_1_defused";
      break;
    case #"hash_c1d4a9d83a2e629e":
      var_6178bf8890a46508 = "flag_bomb_2_defused";
      break;
    case #"hash_c1d4aad83a2e6431":
      var_6178bf8890a46508 = "flag_bomb_3_defused";
      break;
    case #"hash_d0e94206b15c8a8b":
      var_6178bf8890a46508 = "flag_bomb_truck_defused";
      break;
  }

  if(var_6178bf8890a46508 == "") {
    return;
  }

  vo_played = 0;

  while(!utility::flag(var_6178bf8890a46508) && !vo_played) {
    level.player waittill("interact_started");

    if(function_e7c30095a6cdc3ef(bomb, 45)) {
      vo_played = 1;
      thread namespace_7f4f66b90d3178e7::function_38c914390b41befb();
    }
  }
}

function function_ad00417005075d12(objectivestruct, var_5dcdfd3a4eff9961) {
  objname = objectivestruct.objname;
  locname = objname + "_escape";

  if(level.var_5843e823f7ef9a57) {
    locname += "_alt";
  }

  objpoint = utility::getStruct(locname, "script_noteworthy");
  var_fc1dd9ea1f3f2a3b = objpoint.origin;
  level.var_9975e87c04b2847d = spawn("script_model", var_fc1dd9ea1f3f2a3b);
  objpoint thread namespace_9d6ed0911e2ddf09::function_dc3c295fcb6d7c77(4, locname, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, &"CP_DAM/EXFIL", 1);
  objindex = isDefined(objpoint) && isDefined(objpoint.var_191d2524aa36a7e) ? objpoint.var_191d2524aa36a7e : 4;
  objective_onentity(objindex, level.var_9975e87c04b2847d);
}

function function_1b3155a6a06c0d5e(objectivestruct, var_5dcdfd3a4eff9961) {}

function function_698e27a413352904() {
  bombmodel = getEnt("obj_bomb_truck_model", "targetname");

  if(isDefined(bombmodel)) {
    bombmodel delete();
  }

  var_ff60a24bf9e230b3 = getEnt("obj_bomb_truck_clip", "targetname");

  if(isDefined(var_ff60a24bf9e230b3)) {
    var_ff60a24bf9e230b3 delete();
  }
}

function function_797f8140e50dcfee(truck, objectivestruct, objpoint) {
  var_e9bd389679f827 = getEnt("obj_bomb_truck", "script_noteworthy");
  bombmodel = getEnt("obj_bomb_truck_model", "targetname");
  var_ff60a24bf9e230b3 = getEnt("obj_bomb_truck_clip", "targetname");
  var_1a9aa561318ed3a = getEnt("truck_bed_stealth_vol", "targetname");
  var_e9bd389679f827 linkTo(bombmodel);
  var_ff60a24bf9e230b3 linkTo(bombmodel);

  if(getdvarint(@ "hash_e63044d7b59f5713", 0) == 1) {
    bombmodel linkTo(truck, "tag_seat_wm_4", (18, -22, -8), (0, 180, 0));
  } else {
    bombmodel linkTo(truck);
  }

  var_1a9aa561318ed3a enablelinkTo();
  var_1a9aa561318ed3a linkTo(truck);

  for(i = 0; i < truck.riders.size; i++) {
    truck.riders[i] thread function_85673151a7943df8(i, truck);
  }

  level thread function_10149af4ddf22da1(truck);
  truck thread function_71f28167af4e7122();
  truck thread function_3d6e2564dd516712();
  thread function_a4f5d802863ef992(bombmodel);
}

function function_dce79af7a92d464d(vehicle) {
  if(vehicle == level.var_8c550b3ecc84a260) {
    if(vehicle hascomponent("p2p")) {
      vehicle removecomponent("p2p");
    }
  }

  return true;
}

function function_71f28167af4e7122() {
  self endon("death");
  utility::flag_wait("flag_bomb_truck_arrived");
  function_401d0838f4f47c3e(1);
  self setscriptablepartstate("lights_front_cheap_dim", "off");
  self setscriptablepartstate("lights_back_cheap_dim", "off");
  self vehicle_turnengineoff();
}

function function_3d6e2564dd516712() {
  self endon("death");
  utility::flag_wait("flag_bomb_truck_rider_exit");

  if(self hascomponent("p2p")) {
    self removecomponent("p2p");
  }

  utility::flag_set("flag_bomb_truck_arrived");
}

function function_a4f5d802863ef992(bombmodel) {
  playFXOnTag(utility::getfx("vfx_dam_bomb_light_red_on"), bombmodel, "tag_origin");
  utility::flag_wait("flag_bomb_truck_defused");
  killfxontag(utility::getfx("vfx_dam_bomb_light_red_on"), bombmodel, "tag_origin");
  playFXOnTag(level._effect["vfx_dam_bomb_disarm_sparks_truck"], bombmodel, "tag_origin");
  playFXOnTag(level._effect["vfx_dam_bomb_light_red_off"], bombmodel, "tag_origin");
}

function function_10149af4ddf22da1(var_9360ab4355a918a1) {
  while(isDefined(var_9360ab4355a918a1) && !var_9360ab4355a918a1 vehicle::isvehicledestroyed()) {
    waitframe();
  }

  if(!utility::flag("flag_bomb_truck_defused")) {
    wait 1;
    namespace_96731f4d002634f6::function_fa7c87f2585bd907(0);
    return;
  }

  function_698e27a413352904();
}

function function_85673151a7943df8(var_7373dfba539de786, truck) {
  self endon("death");
  thread function_afd2306ade9600c3();
  thread function_f98463d49e2f9067();
}

function function_afd2306ade9600c3() {
  self endon("death");

  while(isDefined(self.vehicle)) {
    waitframe();
  }

  utility::flag_set("flag_bomb_truck_rider_exit");
}

function function_f57b6781116362c2(bomb) {
  while(!self[[self.fnisinstealthcombat]]()) {
    waitframe();
  }

  utility::flag_set("flag_truck_bomb_rider_player_detected");
  bomb unlink();
}

function sentry_truck() {
  var_d403781f4aa5743b = utility::getStruct("sentry_truck", "targetname");

  if(!isDefined(level.var_e6ea43bf8f7f8971)) {
    level.var_e6ea43bf8f7f8971 = namespace_48d38898a22ee3d7::function_136d8a6a5c016d7e(var_d403781f4aa5743b);
  }

  var_6e7032bc1694f593 = utility::getStruct("truck_sentrygun", "targetname");
  var_6e7032bc1694f593.var_2108ba0559bdaaff = &namespace_4848403b6f5b0da0::function_5e66cae8a3e9f368;
  var_eb0ad382dcbc2e63 = namespace_4848403b6f5b0da0::setup_enemy_sentry(var_6e7032bc1694f593);
  level.var_ebc1f5321a243d72 = utility::array_add_safe(level.var_ebc1f5321a243d72, var_eb0ad382dcbc2e63);
  var_47c0752bc7314adb = level.var_e6ea43bf8f7f8971 gettagorigin("tag_seat_wm_5");
  var_eb0ad382dcbc2e63.origin = var_47c0752bc7314adb;
  var_eb0ad382dcbc2e63 linkTo(level.var_e6ea43bf8f7f8971, "tag_seat_wm_5", (0, 25, 0), (0, 180, 0));
  level.var_e6ea43bf8f7f8971 thread function_bbbd47775054d035(var_eb0ad382dcbc2e63);
  level.var_e6ea43bf8f7f8971 thread function_a2853bf75e62b63f(var_eb0ad382dcbc2e63);
  var_eb0ad382dcbc2e63 thread function_50e57771a1307ecb();
}

function function_a2853bf75e62b63f(turret) {
  self waittill("death");

  if(isDefined(turret)) {
    turret kill();
  }
}

function function_ad873d6b224de9df() {
  if(utility::flag("flag_obj_all_bombs_defused")) {
    return;
  }

  var_949753aaaa6edfca = utility::getStructArray("initial_sentrygun", "targetname");
  level.var_ebc1f5321a243d72 = [];

  foreach(var_72ae510fc35f3b7d in var_949753aaaa6edfca) {
    var_72ae510fc35f3b7d.var_2108ba0559bdaaff = &namespace_4848403b6f5b0da0::function_5e66cae8a3e9f368;
    turret = namespace_4848403b6f5b0da0::setup_enemy_sentry(var_72ae510fc35f3b7d);
    level.var_ebc1f5321a243d72 = utility::array_add(level.var_ebc1f5321a243d72, turret);
    turret thread function_50e57771a1307ecb();
    turret thread function_807c27ebd8e133c();
  }

  utility::flag_set("init_sentryturrets_dam");
}

function function_bbbd47775054d035(turret) {
  self endon("death");
  utility::flag_wait("flag_obj_all_bombs_defused");

  if(isDefined(self.health) && self.health > 25) {
    self.health = 25;
  }

  if(isDefined(turret.fake_health) && turret.fake_health > 25) {
    turret.fake_health = 25;
  }
}

function function_50e57771a1307ecb() {
  self endon("death");
  thread function_5b80037f89595923();

  if(istrue(level.checkpoint_reached)) {
    self notify("hacked");
    return;
  }

  self waittill("hacked");
  level notify("turret_hacked");
}

function function_5b80037f89595923() {
  self endon("death");
  self waittill("converted");
  level notify("turret_converted");
}

function function_807c27ebd8e133c() {
  if(istrue(level.checkpoint_reached)) {
    return;
  }

  utility::flag_wait("flag_obj_all_bombs_defused");

  while(!isDefined(level.lastbomb)) {
    waitframe();
  }

  if(!istrue(self.hacked) && level.lastbomb != "obj_bomb_1") {
    if(level.lastbomb == "obj_bomb_2") {
      while(!istrue(level.var_c72a8ac12cf04000)) {
        waitframe();
      }
    }

    namespace_4848403b6f5b0da0::sentry_disable();
    self setscriptablepartstate("empd", "neutral");
  }
}

function function_2c31d268382bedb0() {
  level.players[0] skydive_setbasejumpingstatus(1);
  level.players[0] skydive_setdeploymentstatus(1);
}

function function_1c8c03372bade56e(wait_till) {
  p_weapon = weapon::function_768c9a047aed19f4("iw9_ar_mike4_mp");
  p_weapon = p_weapon weapon::function_dcb52bcbbcb80b00(["silencer", "reddot"]);
  s_weapon = weapon::function_768c9a047aed19f4("papa220");
  s_weapon = s_weapon weapon::function_dcb52bcbbcb80b00(["silencer", "laser", "reddot"]);
  self.last_stand_pistol = s_weapon;
  loadout::function_e2d370937c694c58(p_weapon.basename, p_weapon.attachments, s_weapon.basename, s_weapon.attachments);
  loadout::function_ebf2582b122904fc("equip_frag", "equip_flash");
}

function function_da58f5fca036ffaa() {
  utility::giveperk("specialty_hack");
}

function function_2a7cebc730abe77a() {
  var_a2f87793f0a25c06 = utility::getStructArray("armor_pickup", "targetname");

  foreach(var_d87fbb7f6e0e991 in var_a2f87793f0a25c06) {
    var_d87fbb7f6e0e991.angles = utility::ter_op(isDefined(var_d87fbb7f6e0e991.angles), var_d87fbb7f6e0e991.angles, (0, 0, 0));
    dropinfo = pickups::getitemdropinfo(var_d87fbb7f6e0e991.origin, var_d87fbb7f6e0e991.angles);
    armordrop = pickups::spawnpickup("brloot_armor_plate", dropinfo);
  }
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
  iprintlnbold(self.vehiclename + "<dev string:xae>");

  if(self.vehiclename == "veh9_rhib" || self.vehiclename == "veh_jup_rhib" || self.vehiclename == "veh_jup_rhib_2man") {
    thread function_e5eba6f645b52498();
    return;
  }

  self setscriptablepartstate("lights_front_cheap_dim", "on");
  self setscriptablepartstate("lights_back_cheap_dim", "on");
}

function function_e5f869d16eb9abea() {
  iprintlnbold(self.vehiclename + "<dev string:xb5>");

  if(self.vehiclename == "veh9_rhib" || self.vehiclename == "veh_jup_rhib" || self.vehiclename == "veh_jup_rhib_2man") {
    level notify("player_exited_rhib");
    return;
  }

  self setscriptablepartstate("lights_front_cheap_dim", "off");
  self setscriptablepartstate("lights_back_cheap_dim", "off");
}

function function_e5eba6f645b52498() {
  level endon("player_exited_rhib");

  while(isDefined(self) && !vehicle::isvehicledestroyed()) {
    waitframe();
  }

  wait 1;
  namespace_96731f4d002634f6::function_fa7c87f2585bd907(0);
}

function function_137fc90d1f21350c() {
  level.player endon("death");
  thread function_6c806512591b5314();

  while(!utility::flag("flag_obj_all_bombs_defused")) {
    level.player waittill("damage", amt, attacker, dir, point, type, modelname, tagname, partname, dflags, objweapon);

    if(isDefined(attacker)) {
      if(issubstr(type, "EXPLOSIVE")) {
        if(is_in_array(attacker, level.var_a24a4cc213c846cc)) {
          namespace_96731f4d002634f6::function_2311740fe797906a("deathBy", "claymore");
        } else {
          namespace_96731f4d002634f6::function_2311740fe797906a("deathBy", "laser");
        }
      } else if(is_in_array(attacker, level.var_ebc1f5321a243d72)) {
        namespace_96731f4d002634f6::function_2311740fe797906a("deathBy", "turret");
      } else if(is_in_array(attacker, level.var_a24a4cc213c846cc)) {
        namespace_96731f4d002634f6::function_2311740fe797906a("deathBy", "sniper");
      } else {
        namespace_96731f4d002634f6::function_2311740fe797906a("deathBy", "generic");
      }
    }

    wait 1;
  }

  while(true) {
    level.player waittill("damage", amt, attacker, dir, point, type, modelname, tagname, partname, dflags, objweapon);

    if(isDefined(attacker)) {
      namespace_96731f4d002634f6::function_2311740fe797906a("deathBy", "generic");
    }

    wait 1;
  }
}

function function_6c806512591b5314() {
  level.player waittill("killed_player", attacker, meansofdeath, objweapon, inflictor);
  attacker = default_to(attacker, level.player.attacker);
  attacker_weapon = isDefined(level.player.laststanddowneddata) && isDefined(level.player.laststanddowneddata.weaponfullstring) ? level.player.laststanddowneddata.weaponfullstring : undefined;
  deathquote = undefined;

  if(isDefined(attacker)) {
    if(isDefined(level.var_a24a4cc213c846cc) && array_contains(level.var_a24a4cc213c846cc, attacker)) {
      deathquote = 994;
    } else if(!flag("player_jumped_off_starting_catwalk")) {
      deathquote = 995;
    } else if(isDefined(level.var_80569951efad4eb5) && array_contains(level.var_ebc1f5321a243d72, attacker)) {
      deathquote = 996;
    }
  }

  if(is_equal(meansofdeath, "MOD_SUICIDE") && is_equal(attacker_weapon, "iw9_drown_mp")) {
    deathquote = 153;
  }

  if(isDefined(deathquote)) {
    scripts\cp\player_death::set_custom_death_quote(deathquote, 1);
  }
}

function is_in_array(obj, array) {
  if(!isDefined(array) || array.size < 1) {
    return false;
  }

  foreach(item in array) {
    if(obj == item) {
      return true;
    }
  }

  return false;
}

function function_c3e34853ee15f719() {
  namespace_e1447aac8628ea7d::function_786c10d84c135d5c("dam_main");
  namespace_e1447aac8628ea7d::function_9cb60ba3067949a3("bomb_1");
  namespace_e1447aac8628ea7d::function_9cb60ba3067949a3("bomb_1_surrounding");
  namespace_e1447aac8628ea7d::function_9cb60ba3067949a3("bomb_2");
  namespace_e1447aac8628ea7d::function_9cb60ba3067949a3("bomb_2_surrounding");
  namespace_e1447aac8628ea7d::function_9cb60ba3067949a3("bomb_3");
  namespace_e1447aac8628ea7d::function_9cb60ba3067949a3("bomb_3_surrounding");
  namespace_e1447aac8628ea7d::function_9cb60ba3067949a3("bomb_truck");
  namespace_e1447aac8628ea7d::function_9cb60ba3067949a3("bomb_truck_surrounding");
  function_1cdf8543ead5f85("dam_main", "stage_initial");
  utility::flag_init("choreographer_ready");
  utility::flag_set("choreographer_ready");
  println("<dev string:xbb>");
}

function function_71a51c41fcd32631() {
  namespace_96731f4d002634f6::function_bd9c984cefed4209(0);

  if(isDefined(level.var_4898102a23066ba.objectives)) {
    for(i = 0; i < 4; i++) {
      level.player namespace_96731f4d002634f6::function_a9652366b0728328(0, i);
    }
  }

  var_643da509e62816cc = namespace_96731f4d002634f6::function_e1e2c6c4a3a0ebad();

  for(i = 0; i < var_643da509e62816cc; i++) {
    namespace_96731f4d002634f6::function_cc8a338bb3b0a9fe(i, 0);
  }
}