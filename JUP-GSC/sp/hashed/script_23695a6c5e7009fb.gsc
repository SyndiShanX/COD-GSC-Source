/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_23695a6c5e7009fb.gsc
*************************************************/

#using script_102d83a437e2b29f;
#using script_14f60cd9d886b017;
#using script_16ea1b94f0f381b3;
#using script_1b5e21ec19a8960b;
#using script_235ddc1cf820f89b;
#using script_2386704e3c08f8ca;
#using script_24e4405cf93f20ed;
#using script_2b75016a16c4726a;
#using script_2bd16c90e9c5c546;
#using script_3a8f9ace195c9da9;
#using script_3ae866a6dd08daf9;
#using script_3b0812a5fdfecf0;
#using script_3cb1beed718e7650;
#using script_42f868a5dda17294;
#using script_45acccdc907f4e6b;
#using script_46b342a079938c68;
#using script_48324b060b129b7b;
#using script_51b3a8221287b156;
#using script_52673f140a47e528;
#using script_56abda53e9dd9317;
#using script_7cdb0da8e1834d02;
#using script_7e7eaa110dbb1c83;
#using script_98a64d96183c8f8;
#using script_f603f40349f99c8;
#using scripts\anim\dialogue;
#using scripts\anim\shared;
#using scripts\anim\squadmanager;
#using scripts\asm\gesture;
#using scripts\asm\shared\mp\utility;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\lighting;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_paths;
#using scripts\common\visibility_mode;
#using scripts\cp\coop_stealth;
#using scripts\cp\cp_checkpoint;
#using scripts\cp\cp_claymore;
#using scripts\cp\cp_compass;
#using scripts\cp\cp_create_script_utility;
#using scripts\cp\cp_gameskill;
#using scripts\cp\cp_hud_message;
#using scripts\cp\cp_interaction;
#using scripts\cp\cp_movers;
#using scripts\cp\cp_objectives;
#using scripts\cp\cp_outofbounds;
#using scripts\cp\cp_spawning_util;
#using scripts\cp\equipment\cp_gas_grenade;
#using scripts\cp\globallogic;
#using scripts\cp\helicopter\cp_helicopter;
#using scripts\cp\player\offhand_box;
#using scripts\cp\player_death;
#using scripts\cp\spawning;
#using scripts\cp\utility;
#using scripts\cp\weapon;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;
#using scripts\quaked\script_struct_mp_jup_jltv_mg;
#using scripts\stealth\group;
#using scripts\stealth\utility;
#namespace cp_jup_chemical;

function function_d4cd4743266b57be() {}

function main() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0)) {
    return;
  }

  namespace_23c519c45f2f0649::main();
  namespace_85a6df2c25aa408::main();
  namespace_ffaf7dc1dadf457a::main();
  namespace_d1eabe4308f7c3e0::main();
  thread namespace_11fae4a66a43bd3f::main();

  if(level.createfx_enabled) {
    return;
  }

  if(!isDefined(level.valstruct)) {
    level.valstruct = spawnStruct();
  }

  scripts\cp\cp_checkpoint::function_4bfef22c47a65be5("obj_enterReactor_complete");
  scripts\cp\cp_checkpoint::function_4bfef22c47a65be5("obj_reconArea_complete");
  level.var_dfd215e11ace150f = 1;
  level.var_4f73c33a5235d99c = 1;
  level.var_9df79069dfd8549b = 0;
  level.var_10aad158c29f7d5f = [];
  level.var_7a155fea3b7b30dc = 3;

  if(level.mapname == "cp_jup_chemical") {
    level.var_61a54be8038f3a95 = 1;
    level.var_41957e049a51e8bc = "stealth_ai_music_bundle_cp_jup_chemical";
    level.var_8e4a4897f3b80823 = 1;
  }

  coop_mode_enable("sp_stealth");
  level thread function_fb457f7cdf0ac39e();
  function_61411c49eaca86e2("price");
  function_83afcf8fb8074654();
  add_start("loadout", &function_1fdbf07dcc8fbefc, &function_498bb6295d0e990);
  add_start("investigate", &function_ac8d7ba62722898f, &function_26a01f4af94cb7bd);
  add_start("reactor", &function_6f1065377b6d45ca, &function_446a0ab3bcf9e922);
  add_start("reactor_2", &function_b327d0c532fe8b47, &function_fb2601dbc065a6d0);
  add_start("reactor_3", &function_b327cfc532fe8914, &function_fb2601dbc065a6d0);
  add_start("escape", &function_7c921888c7d44907, &function_17006546f61dd733);
  add_start("exfil", &function_b0f6d6910f3b8af8, &function_cce1ca1325cccbe4);
  add_start("debug_start_on_ground", &function_9dea4b1498c22533, &function_cb7b401ed6a2a0c6);
  add_start("debug_reactor_beta", &function_9dea4b1498c22533, &function_cb7b401ed6a2a0c6);
  add_start("debug_parking_lot", &function_9dea4b1498c22533, &function_cb7b401ed6a2a0c6);
  add_start("debug_turbine", &function_9dea4b1498c22533, &function_cb7b401ed6a2a0c6);
  add_start("debug_spray_zone", &function_9dea4b1498c22533, &function_cb7b401ed6a2a0c6);
  function_bb3e0c926b0667c4("loadout,investigate,reactor,reactor_2,reactor_3,escape,exfil,debug_start_on_ground,debug_reactor_beta,debug_parking_lot,debug_turbine,debug_spray_zone");
  thread init_vehicles();
  thread function_4faf77b13696a43f();
  thread function_de5ae0c94d33b9c8();
  thread function_ac2e42c678489275();
  function_d525f1534752bfc7();
  function_2cfef434ce6a1c44();
  function_3861eb0a004e0d38();
  function_c4d555bf9485ac3b();
  level.valstruct val::set("level", "global_esc_total_combat_time", 300);
  level.valstruct val::set("level", "global_esc_percent_threshold", 0.3);
  callback::add("player_connect", &player_connect);
  flag_wait("scriptables_ready");
  level.fog = getentitylessscriptablearray("fog", "targetname")[0];
  level.fog setscriptablepartstate("test_part", "bbox_underground");
  setdvarifuninitialized(@ "hash_67af7671c334c539", 0);
  setdvarifuninitialized(@ "hash_36d21fcf8f57be47", 1);

  if(getdvarint(@ "hash_36d21fcf8f57be47")) {
    setDvar(@ "hash_f89b527ca99a08bd", 0);
  }
}

function function_4faf77b13696a43f() {
  while(!isDefined(level.player)) {
    waitframe();
  }

  level.checkpoint = "";
  level.checkpoint_reached = 0;

  if(!istrue(level.var_1369e1e96a31be5e)) {
    level.checkpoint = scripts\cp\cp_checkpoint::checkpoint_get();
    level.checkpoint_reached = level.checkpoint == "obj_reconArea_complete" || level.checkpoint == "obj_enterReactor_complete" ? 1 : 0;
    function_7d66551301c281c2();
  }

  level.var_b9d5a2af2d535f77 = !level.checkpoint_reached;
  utility::flag_set("checkpoint_data_retrieved");
}

function function_2cfef434ce6a1c44() {
  level.custom_onspawnplayer_func = &onplayerspawned;
  level.custom_onplayerconnect_func = &onplayerconnect;
}

function onplayerconnect(player) {}

function onplayerspawned() {
  if(getdvarint(@ "hash_36d21fcf8f57be47")) {
    setDvar(@ "hash_61c630da70ceefe8", 1);
  }
}

function init_vehicles() {
  scripts\cp_mp\vehicles\vehicle::vehicle_forceinit("veh_jup_atv");
  scripts\cp_mp\vehicles\vehicle::vehicle_forceinit("veh_jup_jltv");
  scripts\cp_mp\vehicles\vehicle::vehicle_forceinit("veh_jup_jltv_mg");
  scripts\cp_mp\vehicles\vehicle::vehicle_forceinit("veh_jup_pickup_2014");
  scripts\cp_mp\vehicles\vehicle::vehicle_forceinit("veh_jup_suv_1996");
  scripts\cp_mp\vehicles\vehicle::vehicle_forceinit("veh_jup_mil_cargo_truck");
  scripts\cp_mp\vehicles\vehicle::vehicle_forceinit("veh_jup_hind");
  scripts\cp_mp\vehicles\vehicle::vehicle_forceinit("veh_jup_blima");
  scripts\cp_mp\vehicles\vehicle::vehicle_forceinit("veh_jup_heli_med");
  scripts\cp_mp\vehicles\vehicle::vehicle_forceinit("veh_jup_palfa");
}

function function_3861eb0a004e0d38() {
  level.objectivesfunc = &function_c2a86f682bf1ab71;
  level thread scripts\cp\cp_objectives::objectives_init();
}

function function_c4d555bf9485ac3b() {
  setup_create_script();
  level thread function_fc4803dc319a81d2();
  function_e00cc8c1c5cc38fb(1);
  setDvar(@ "hash_2eafab756261f717", 1);
  setDvar(@ "hash_a74d572c7ab93123", 1300);
  scripts\cp\cp_compass::setupminimap("compass_map_cp_jup_chemical");
  namespace_6650a5e3ecceafd5::function_b04f37f19c6631e0();
  level thread function_77765e5dd4c9db54();
  level thread scripts\cp\cp_objectives::run_debug_start_objective();
  level thread function_8047cf77708b61c0();
  level thread function_dafb3a3f4a103ccd();
  level thread init_laser_traps();
  level thread function_ad873d6b224de9df();
  level thread function_feafb69376e58f77();
  level thread function_d7398803f3fe830();
  function_6bba37af4d180e78("parachuting");
  level thread function_5ca302bef5c14ed6();
  level thread function_2743500d7ab05d6e();

  level.devgui_setup_func = &function_d8fb18a58a875db6;
  level thread setup_map_specific_devgui();
}

function setup_create_script() {
  scripts\cp\cp_create_script_utility::init_create_script_for_level();
  scripts\cp\cp_create_script_utility::register_create_script_arrays("cp_jup_chemical_create_script", "cp_jup_chemical_create_script", level.scripted_spawner_func.size, &namespace_355781cd93150472::main);
}

function function_fc4803dc319a81d2() {
  level thread wait_for_pre_game_period();
  level thread wait_for_strike_init_complete();
  level flag_wait("start_mission_flow");
  level flag_wait("level_ready_for_script");
  level flag_wait("checkpoint_data_retrieved");
  namespace_53fc9ddbb516e6e1::function_9bc69c26770d9533(&namespace_1170726b2799ea65::function_a455e04c3087c72b);
  level thread function_76475ab344bd0cf3();
  level.player waittill("loadout_class_selected");
  level.player thread namespace_96731f4d002634f6::function_aa47047a0f7d56da(level.player, 0, 1);
  level thread function_c0926f2d29510c1c();
  namespace_53fc9ddbb516e6e1::function_9bc69c26770d9533(&function_90830af7ed501ee2);
  setDvar(@ "hash_cb0703eeedd5713b", 1);
  setDvar(@ "hash_27f0a65635eefcf6", int(0));
}

function function_c0926f2d29510c1c() {
  flag_wait("flag_dungeon_intro_complete");
  level thread function_7df46845d188e201();
  level thread function_7852db0bc9d7b7ed();
  level thread obj_flow();
  level thread function_ffc7dd3a5adfd5cf();
  level thread function_5a40593ae77d06f4();
  level thread function_c47108031d829dac();
  level thread function_c8b60d93be5d453();
  level thread function_e63c28f08bfec3a5();
  level.var_83782d6266ec4fb4 = &namespace_11fae4a66a43bd3f::function_6c22b1feac90c495;
  level.var_af4d3c79160d24d9 = 600;
  level thread function_8e01c459332b0111();
  level thread function_b8b58deb951e86a4();
  level thread function_75b4b91927ff5a87();
  level thread scripts\cp\player\offhand_box::offhand_box_setup();
  level thread function_2537619733cc78e8();
  level thread function_1ff2812caba159e6();
  level thread function_137fc90d1f21350c();
  level thread function_ba8d6171b09f531a();
}

function function_b6b0da05f1bd84f8() {
  if(isDefined(level.var_4898102a23066ba.objectives)) {
    for(i = 0; i < 15; i++) {
      level.player namespace_96731f4d002634f6::function_a9652366b0728328(0, i);
    }
  }
}

function wait_for_pre_game_period() {
  level endon("game_ended");
  flag_wait("bsp_structs_initialized");
  flag_wait("level_ready_for_script");

  while(!isDefined(level.player)) {
    waitframe();
  }

  level flag_set("start_mission_flow");
}

function wait_for_strike_init_complete() {
  level endon("game_ended");
  flag_wait("level_ready_for_script");
  flag_wait("strike_init_done");
  flag_wait("objective_table_parsed");
  flag_wait("objectives_registered");
}

function function_d525f1534752bfc7() {
  setDvar(@ "sm_sunsamplesizenear", 1.25);
  setDvar(@ "hash_7686fcb92ccc5edb", 4);
  setDvar(@ "r_umbraaccurateocclusionthreshold", 2048);
  setDvar(@ "hash_1dde331a8e0153d8", 8);
  setDvar(@ "hash_63eb1893f96ac98d", 8);
  setDvar(@ "hash_ef675b8b6b09b0f", 1);
  setDvar(@ "hash_ba8282e1a78ac163", 0);
  setsaveddvar(@ "hash_cc8e0b21d7f14dee", 1);
  flag_set("infil_complete");
}

function function_5a40593ae77d06f4() {
  level endon("game_ended");
  helis = getStructArray("chem_obj_heli", "targetname");
  munitions = ["precision_airstrike", "toma_strike", "cruise_missile", "assault_drone", "auto_drone", "hover_jet"];
  var_cd6247c5e18d79b3 = 0;

  while(true) {
    wait 0.25;

    if(var_cd6247c5e18d79b3 >= 5) {
      return;
    }

    if(function_94b00c0fad72704b(5)) {
      return;
    }

    if(isDefined(level.player.vehicle)) {
      continue;
    }

    if(!function_94b00c0fad72704b([1, 0], undefined, 1)) {
      continue;
    }

    if(!array_contains(munitions, level.player.munition_slots[0].ref) || !isDefined(level.player.munition_slots[0].ref) || level.player.munition_slots[0].ref == "empty1") {
      continue;
    }

    tutorial_state = level.player getclientomnvar("ui_tutorial_message_state");

    if(tutorial_state == 1) {
      wait 5;
    }

    if(tutorial_state == 1) {
      continue;
    }

    foreach(heli in helis) {
      thread function_bdc60d1ad098faa4("flag_munition_hint", heli.origin, 35, 1, 10000);
    }

    if(!flag("flag_munition_hint")) {
      continue;
    }

    while(level.splash_active) {
      wait 0.1;
    }

    level.player thread tutorialprint(&"CP_JUP_CHEMICAL/HINTMUNITION", 6);
    start_time = gettime();

    while(!time_has_passed(start_time, 6)) {
      if(level.splash_active) {
        level.player clearhudtutorialmessage();
        break;
      }

      wait 0.25;
    }

    wait 80;
    flag_clear("flag_munition_hint");
    var_cd6247c5e18d79b3 += var_cd6247c5e18d79b3;
  }
}

function function_c47108031d829dac() {
  level endon("death");

  while(true) {
    level waittill("c4_planted", stuckto, hitent);

    if(!flag("c4_tutorial_given")) {
      if(!isDefined(stuckto) || stuckto.model != "black::veh_jup_mil_ru_heli_transport_chemical") {
        level.player scripts\cp\cp_hud_message::tutorialprint(&"CP_JUP_CHEMICAL/HINTC4", 5);
        flag_set("c4_tutorial_given");
      }
    }

    if(isDefined(stuckto) && stuckto.model == "black::veh_jup_mil_ru_heli_transport_chemical") {
      level.player scripts\cp\cp_hud_message::tutorialprint(&"CP_JUP_CHEMICAL/HINTC4", 5);
      return;
    }
  }
}

function function_76475ab344bd0cf3() {
  veh_spawners = getStructArray("player_vehicles", "targetname");

  foreach(spawner in veh_spawners) {
    if(isDefined(spawner.script_parameters)) {
      spawner.var_14cde247ac3313a4 = spawner.script_parameters;
    }

    vehicle = level namespace_ba155a12c323dc5a::function_136d8a6a5c016d7e(spawner, undefined, "none");
    vehicle function_65aa053c077c003a(1);
  }

  level thread function_f1f5881db82ff806();
  level thread function_d631440a2e798daf();
  level.var_571425accdf6489b = function_4e530f6f95f2c50("reactor_turbine_door_interact");
  level.var_2de1558f693bcff4 = function_4e530f6f95f2c50("reactor_parking_door_interact");
  level.var_e77be246fdd8927a = function_4e530f6f95f2c50("reactor_rear_door_interact");
  level.var_571425accdf6489b function_d4ef016d72a62dee(1);
  level.var_2de1558f693bcff4 function_d4ef016d72a62dee(1);
  level.var_e77be246fdd8927a function_d4ef016d72a62dee(1);
  level thread function_a34e94c1f5c85930("flag_obj_all_helis_killed");
  level flag_set("flag_scripted_doors_initialized");
  level.var_d2acca7804d67c9d = function_1c4d592029f2b0d3("vol_airlock_turbine");
  level.var_ee9666af5c4768d0 = function_1c4d592029f2b0d3("vol_airlock_hallway");
  level.var_15212e09697ad715 = getEntArray("vol_airlock_rear", "targetname");
  level thread function_758a0054dcf55fa5();
  level.var_46291596959530d1 = function_1c4d592029f2b0d3("reactor_gas_clear");
  level.var_b98b9f05b5cd26ea = function_1c4d592029f2b0d3("org_reactor_gas_top");
  level thread function_acfeb00654fddaee();
  vols = function_f159c10d5cf8f0b4("recon_poi_crane", "script_noteworthy");

  foreach(vol in vols) {
    vol namespace_8c7f8f6b3076a74a::function_85aedb842bdb548b();
    vol namespace_8c7f8f6b3076a74a::function_c83d1e8771ec8f57("recon_poi_crane_seen");
    vol namespace_8c7f8f6b3076a74a::function_64c508c5eab90d48(0);
    vol namespace_8c7f8f6b3076a74a::function_bc16e47a5d8d241a(1500);
    vol namespace_8c7f8f6b3076a74a::function_13ffcc0bd41e3ed3(1);
    vol namespace_8c7f8f6b3076a74a::function_9ab6c382d227266("flag_vo_recon_disabled");
  }

  vols = function_f159c10d5cf8f0b4("recon_poi_turbine", "script_noteworthy");

  foreach(vol in vols) {
    vol namespace_8c7f8f6b3076a74a::function_85aedb842bdb548b();
    vol namespace_8c7f8f6b3076a74a::function_c83d1e8771ec8f57("recon_poi_turbine_seen");
    vol namespace_8c7f8f6b3076a74a::function_64c508c5eab90d48(0);
    vol namespace_8c7f8f6b3076a74a::function_bc16e47a5d8d241a(500);
    vol namespace_8c7f8f6b3076a74a::function_13ffcc0bd41e3ed3(1);
    vol namespace_8c7f8f6b3076a74a::function_9ab6c382d227266("flag_vo_recon_disabled");
  }

  playmayhem("mayhem_tarp_27");
}

function function_acfeb00654fddaee() {
  while(true) {
    wait 1;

    if(!function_94b00c0fad72704b([0, 1, 4], 1, 2)) {
      flag_set("flag_vo_recon_disabled");
      continue;
    }

    flag_clear("flag_vo_recon_disabled");
  }
}

function function_dafb3a3f4a103ccd() {
  utility::flag_wait("player_spawned_with_loadout");
  level.var_c91a0e8fe84fb300 = &scripts\cp\cp_claymore::function_e2b6464932ab9b06;
  level.claymores = scripts\cp\cp_claymore::spawn_claymore_group("claymore");
}

function init_laser_traps() {
  namespace_84c374d417dc82cf::load_laser_fx();
  namespace_84c374d417dc82cf::initsentrysettings();
  flag_wait("level_ready_for_script");
  level.laser_traps = getStructArray("laser_sentry_defuse", "script_noteworthy");
  namespace_84c374d417dc82cf::function_4855a66011f5974b(level.laser_traps);
}

function function_ad873d6b224de9df() {
  flag_wait("level_ready_for_script");
  flag_wait("player_spawned_with_loadout");
  var_949753aaaa6edfca = getStructArray("initial_sentrygun", "targetname");
  level.var_ebc1f5321a243d72 = [];

  foreach(var_72ae510fc35f3b7d in var_949753aaaa6edfca) {
    var_72ae510fc35f3b7d.var_2108ba0559bdaaff = &namespace_3248c63599f525cf::function_5e66cae8a3e9f368;
    turret = namespace_3248c63599f525cf::setup_enemy_sentry(var_72ae510fc35f3b7d, undefined, undefined, undefined, undefined, 3000);
    level.var_ebc1f5321a243d72 = array_add(level.var_ebc1f5321a243d72, turret);
  }

  sentry_truck();
  flag_set("flag_pre_placed_turrets_setup");
}

function function_c5084212f2f3ac26() {
  if(!flag("flag_sentry_turrets_disabled")) {
    var_181c7fa88a11a6a7 = function_fdc9d5557c53078e(level.var_ebc1f5321a243d72);

    if(var_181c7fa88a11a6a7.size > 0) {
      return true;
    }
  }

  var_47555a315089414e = array_removedead_or_dying(level.var_84c359311680e938);

  if(function_489a0835e10a9b55(var_47555a315089414e)) {
    return true;
  }

  return false;
}

function function_67191706a2afee6c() {
  var_c2f71b511f813b3c = getEntArray("vol_pipeworks", "targetname");

  foreach(vol in var_c2f71b511f813b3c) {
    if(level.player istouching(vol)) {
      return true;
    }
  }

  return false;
}

function private function_7e5eb020777057b8() {}

function function_5b812e5d84bff645(var_701000946938a9ab, button_text) {
  str = getStruct(var_701000946938a9ab, "targetname");
  str thread function_8413d4065227d81b(button_text);
  var_cffca1a9623f41d5 = str create_interact(undefined, undefined, undefined, undefined, &"CP_JUP_CHEMICAL/JLTV_AIRDROP", undefined, "hide", 1);
  var_cffca1a9623f41d5 setuseholdduration(1000);
  return var_cffca1a9623f41d5;
}

function private function_b1eab7c7fda1fb57() {}

function function_8413d4065227d81b(str) {
  while(true) {
    print3d(self.origin, str, undefined, undefined, 0.25);
    waitframe();
  }
}

function function_5ca302bef5c14ed6() {
  flag_wait("level_ready_for_script");
  level thread function_afac931c530dbbf6();
}

function function_afac931c530dbbf6() {
  var_4a91437827b08688 = function_7a18da6e48b71c35("smoke_vfx_jltv_airdrop");
  level.var_4a91437827b08688 = spawn_model("tag_origin", var_4a91437827b08688.origin + (0, 0, 0), var_4a91437827b08688.angles);
  veh_spawner = getStruct("airdrop_jltv", "targetname");
  veh_spawner.spawnmethod = "airdrop_at_position_unsafe";
  var_cffca1a9623f41d5 = function_5b812e5d84bff645("spawn_jltv_airdrop_trigger", "");
  vehicle = undefined;
  var_cffca1a9623f41d5 waittill("trigger");
  playFXOnTag(level._effect["vfx_chemical_smk_signal"], level.var_4a91437827b08688, "tag_origin");
  var_cffca1a9623f41d5 delete();
  vehicle = scripts\quaked\script_struct_mp_jup_jltv_mg::function_41840e7c1272c050(veh_spawner);
  vehicle.var_47a068b6e4f69d26 = 1;
  flag_set("puzzle_jltv_complete");
  level.player thread scripts\cp\cp_movers::player_unresolved_collision_watch();
  wait 10;
  stopFXOnTag(level._effect["vfx_chemical_smk_signal"], level.var_4a91437827b08688, "tag_origin");
}

function function_2743500d7ab05d6e() {
  heli_starts_addstart("heli_killstreak_entrance", "heli_killstreak_goal");
}

function function_aaee9c3bd12b358a() {
  var_32a3b502ac9212b3 = getStructArray("sentry_turret_spawn", "targetname");

  foreach(var_4f249dd727dec398 in var_32a3b502ac9212b3) {
    var_4f249dd727dec398.var_2108ba0559bdaaff = &namespace_3248c63599f525cf::function_5e66cae8a3e9f368;
    turret = namespace_3248c63599f525cf::setup_enemy_sentry(var_4f249dd727dec398);
  }
}

function function_c8b60d93be5d453() {
  level.player endon("death");
  level.player endon("disconnect");
  level endon("game_ended");
  level.var_4bc5fee4300b6905 = undefined;
  level.var_17d23eb017a62c09 = undefined;
  level.var_e84a9897f7a781fa = undefined;

  while(!flag("flag_obj_all_helis_killed")) {
    wait 1;

    if(level.var_2745498dd7dc0a6d == "containment_approach") {
      level.var_4bc5fee4300b6905 = "containment";
      break;
    }

    if(level.var_2745498dd7dc0a6d == "parking_center") {
      level.var_4bc5fee4300b6905 = "parking";
      break;
    }

    if(level.var_2745498dd7dc0a6d == "pipeworks" || level.var_2745498dd7dc0a6d == "pipeworks_turret_alley") {
      level.var_4bc5fee4300b6905 = "spray";
      break;
    }
  }

  while(!flag("flag_obj_all_helis_killed")) {
    wait 1;

    if(level.var_2745498dd7dc0a6d == "containment_approach") {
      if(level.var_4bc5fee4300b6905 != "containment") {
        level.var_17d23eb017a62c09 = "containment";
        break;
      }
    }

    if(level.var_2745498dd7dc0a6d == "parking_center") {
      if(level.var_4bc5fee4300b6905 != "parking") {
        level.var_17d23eb017a62c09 = "parking";
        break;
      }
    }

    if(level.var_2745498dd7dc0a6d == "pipeworks" || level.var_2745498dd7dc0a6d == "pipeworks_turret_alley") {
      if(level.var_4bc5fee4300b6905 != "spray") {
        level.var_17d23eb017a62c09 = "spray";
        break;
      }
    }
  }

  while(!flag("flag_obj_all_helis_killed")) {
    wait 1;

    if(level.var_2745498dd7dc0a6d == "containment_approach") {
      if(level.var_4bc5fee4300b6905 != "containment" && level.var_17d23eb017a62c09 != "containment") {
        level.var_e84a9897f7a781fa = "containment";
        break;
      }
    }

    if(level.var_2745498dd7dc0a6d == "parking_center") {
      if(level.var_4bc5fee4300b6905 != "parking" && level.var_17d23eb017a62c09 != "parking") {
        level.var_e84a9897f7a781fa = "parking";
        break;
      }
    }

    if(level.var_2745498dd7dc0a6d == "pipeworks" || level.var_2745498dd7dc0a6d == "pipeworks_turret_alley") {
      if(level.var_4bc5fee4300b6905 != "spray" && level.var_17d23eb017a62c09 != "spray") {
        level.var_e84a9897f7a781fa = "spray";
        break;
      }
    }
  }
}

function function_7df46845d188e201() {
  level.player endon("death");
  level.player endon("disconnect");
  level endon("game_ended");
  ghost_overlook = getEntArray("vol_ghost_overlook", "targetname");
  beta_hole = getEntArray("vol_beta_hole", "targetname");
  reactorroom = getEntArray("vol_reactor_room", "targetname");
  boilingwater_approach = getEntArray("vol_boilingwater_approach", "targetname");
  pipeworks_turret_alley = getEntArray("vol_pipeworks_turret_alley", "targetname");
  pipeworks = getEntArray("vol_pipeworks", "targetname");
  reactordoors = getEntArray("vol_reactordoors", "targetname");
  entry_building_rooftop = getEntArray("vol_entry_building_rooftop", "targetname");
  crane_top = getEntArray("vol_crane_top", "targetname");
  parking = getEntArray("vol_parking", "targetname");
  turbine_rooftop = getEntArray("vol_turbine_rooftop", "targetname");
  turbines = getEntArray("vol_turbines", "targetname");
  parking_front = getEntArray("vol_parking_front", "targetname");
  parking_side = getEntArray("vol_parking_side", "targetname");
  parking_center = getEntArray("vol_parking_center", "targetname");
  parking_rear = getEntArray("vol_parking_rear", "targetname");
  containment_approach = getEntArray("vol_containment_approach", "targetname");
  firehouse = getEntArray("vol_firehouse", "targetname");
  radio_tower = getEntArray("vol_radiotower", "targetname");
  entrance_wing = getEntArray("vol_entrance_wing", "targetname");
  cooling_towers = getEntArray("vol_cooling_towers", "targetname");
  back_side_airlock = getEntArray("vol_back_side_airlock", "targetname");
  long_dst_plant = getEntArray("vol_long_dist_plant", "targetname");
  front_of_plant = getEntArray("vol_front_of_plant", "targetname");
  containment_post_heli = getEntArray("vol_containment_post_heli", "targetname");
  oob = getEntArray("OutOfBounds", "targetname");
  crane_ascender = getEntArray("vol_crane_ascender", "targetname");
  DOME = getEntArray("vol_vo_dome", "targetname");
  var_94c91455a03f05b = [];
  var_94c91455a03f05b = array_merge(var_94c91455a03f05b, ghost_overlook);
  var_94c91455a03f05b = array_merge(var_94c91455a03f05b, beta_hole);
  var_94c91455a03f05b = array_merge(var_94c91455a03f05b, reactorroom);
  var_94c91455a03f05b = array_merge(var_94c91455a03f05b, boilingwater_approach);
  var_94c91455a03f05b = array_merge(var_94c91455a03f05b, pipeworks_turret_alley);
  var_94c91455a03f05b = array_merge(var_94c91455a03f05b, pipeworks);
  var_94c91455a03f05b = array_merge(var_94c91455a03f05b, reactordoors);
  var_94c91455a03f05b = array_merge(var_94c91455a03f05b, entry_building_rooftop);
  var_94c91455a03f05b = array_merge(var_94c91455a03f05b, crane_top);
  var_94c91455a03f05b = array_merge(var_94c91455a03f05b, parking);
  var_94c91455a03f05b = array_merge(var_94c91455a03f05b, turbine_rooftop);
  var_94c91455a03f05b = array_merge(var_94c91455a03f05b, turbines);
  var_94c91455a03f05b = array_merge(var_94c91455a03f05b, parking_front);
  var_94c91455a03f05b = array_merge(var_94c91455a03f05b, parking_side);
  var_94c91455a03f05b = array_merge(var_94c91455a03f05b, parking_center);
  var_94c91455a03f05b = array_merge(var_94c91455a03f05b, parking_rear);
  var_94c91455a03f05b = array_merge(var_94c91455a03f05b, containment_approach);
  var_94c91455a03f05b = array_merge(var_94c91455a03f05b, firehouse);
  var_94c91455a03f05b = array_merge(var_94c91455a03f05b, radio_tower);
  var_94c91455a03f05b = array_merge(var_94c91455a03f05b, entrance_wing);
  var_94c91455a03f05b = array_merge(var_94c91455a03f05b, cooling_towers);
  var_94c91455a03f05b = array_merge(var_94c91455a03f05b, back_side_airlock);
  var_94c91455a03f05b = array_merge(var_94c91455a03f05b, long_dst_plant);
  var_94c91455a03f05b = array_merge(var_94c91455a03f05b, front_of_plant);
  var_94c91455a03f05b = array_merge(var_94c91455a03f05b, containment_post_heli);
  var_94c91455a03f05b = array_merge(var_94c91455a03f05b, oob);
  var_94c91455a03f05b = array_merge(var_94c91455a03f05b, crane_ascender);
  var_94c91455a03f05b = array_merge(var_94c91455a03f05b, DOME);
  level thread function_ca11fd490cc8bbcc();

  while(true) {
    wait 0.25;
    var_4e11be765018387f = level.player getistouchingentities(var_94c91455a03f05b);

    if(array_intersection(var_4e11be765018387f, oob).size > 0) {
      function_6bba37af4d180e78("oob");
      continue;
    }

    if(array_intersection(var_4e11be765018387f, crane_ascender).size > 0) {
      function_6bba37af4d180e78("crane_ascender");
      continue;
    }

    if(array_intersection(var_4e11be765018387f, DOME).size > 0 && flag("flag_obj_all_helis_killed")) {
      function_6bba37af4d180e78("plant_dome");
      continue;
    }

    if(array_intersection(var_4e11be765018387f, entrance_wing).size > 0 && flag("flag_obj_all_helis_killed")) {
      function_6bba37af4d180e78("entrance_wing");
      continue;
    }

    if(array_intersection(var_4e11be765018387f, cooling_towers).size > 0 && flag("flag_obj_all_helis_killed")) {
      function_6bba37af4d180e78("cooling_towers");
      continue;
    }

    if(array_intersection(var_4e11be765018387f, back_side_airlock).size > 0 && flag("flag_obj_all_helis_killed")) {
      function_6bba37af4d180e78("back_side_airlock");
      continue;
    }

    if(array_intersection(var_4e11be765018387f, front_of_plant).size > 0 && flag("flag_obj_all_helis_killed")) {
      function_6bba37af4d180e78("front_of_plant");
      continue;
    }

    if(array_intersection(var_4e11be765018387f, containment_post_heli).size > 0 && flag("flag_obj_all_helis_killed")) {
      function_6bba37af4d180e78("containment_post_heli");
      continue;
    }

    if(array_intersection(var_4e11be765018387f, firehouse).size > 0) {
      flag_set("flag_player_reached_firehouse");
      function_6bba37af4d180e78("firehouse");
      continue;
    }

    if(array_intersection(var_4e11be765018387f, long_dst_plant).size > 0 && flag("flag_obj_all_helis_killed")) {
      function_6bba37af4d180e78("long_dst_plant");
      continue;
    }

    if(array_intersection(var_4e11be765018387f, ghost_overlook).size > 0) {
      function_6bba37af4d180e78("ghost_overlook");
      continue;
    }

    if(array_intersection(var_4e11be765018387f, beta_hole).size > 0) {
      function_6bba37af4d180e78("beta_hole");
      continue;
    }

    if(array_intersection(var_4e11be765018387f, reactorroom).size > 0) {
      function_6bba37af4d180e78("reactorroom");
      continue;
    }

    if(array_intersection(var_4e11be765018387f, reactordoors).size > 0) {
      function_6bba37af4d180e78("reactordoors");
      continue;
    }

    if(array_intersection(var_4e11be765018387f, boilingwater_approach).size > 0) {
      function_6bba37af4d180e78("boilingwater_approach");
      continue;
    }

    if(array_intersection(var_4e11be765018387f, pipeworks_turret_alley).size > 0) {
      level flag_set("flag_player_reached_spray_approach");
      function_6bba37af4d180e78("pipeworks_turret_alley");
      continue;
    }

    if(array_intersection(var_4e11be765018387f, pipeworks).size > 0) {
      level flag_set("flag_player_reached_spray_approach");
      function_6bba37af4d180e78("pipeworks");
      continue;
    }

    if(array_intersection(var_4e11be765018387f, entry_building_rooftop).size > 0) {
      function_6bba37af4d180e78("entry_building_rooftop");
      continue;
    }

    if(array_intersection(var_4e11be765018387f, crane_top).size > 0) {
      function_6bba37af4d180e78("crane_top");
      continue;
    }

    if(array_intersection(var_4e11be765018387f, turbine_rooftop).size > 0) {
      function_6bba37af4d180e78("turbine_rooftop");
      continue;
    }

    if(array_intersection(var_4e11be765018387f, turbines).size > 0) {
      level flag_set("flag_player_reached_turbines");
      function_6bba37af4d180e78("turbines");
      continue;
    }

    if(array_intersection(var_4e11be765018387f, parking_front).size > 0) {
      flag_set("flag_player_reached_parking_front");
      function_6bba37af4d180e78("parking_front");
      continue;
    }

    if(array_intersection(var_4e11be765018387f, parking_side).size > 0) {
      flag_set("flag_player_reached_parking_side");
      function_6bba37af4d180e78("parking_side");
      continue;
    }

    if(array_intersection(var_4e11be765018387f, parking_center).size > 0) {
      flag_set("flag_player_reached_parking_center");
      function_6bba37af4d180e78("parking_center");
      continue;
    }

    if(array_intersection(var_4e11be765018387f, parking_rear).size > 0) {
      flag_set("flag_player_reached_parking_rear");
      function_6bba37af4d180e78("parking_rear");
      continue;
    }

    if(array_intersection(var_4e11be765018387f, parking).size > 0) {
      function_6bba37af4d180e78("parking");
      continue;
    }

    if(array_intersection(var_4e11be765018387f, containment_approach).size > 0) {
      flag_set("flag_player_reached_containment_approach");
      function_6bba37af4d180e78("containment_approach");
      continue;
    }

    if(array_intersection(var_4e11be765018387f, radio_tower).size > 0) {
      flag_set("flag_player_reached_radio_tower");
      function_6bba37af4d180e78("radio_tower");
      continue;
    }

    function_6bba37af4d180e78("exterior");
  }
}

function function_6bba37af4d180e78(var_1959d9eed24cdcbc) {
  if(!isDefined(level.var_2745498dd7dc0a6d) || level.var_2745498dd7dc0a6d != var_1959d9eed24cdcbc) {
    level.var_52c33d39f2b5db6 = gettime();
    level.var_db20eb0aac334644 = level.var_2745498dd7dc0a6d;
    level.var_2745498dd7dc0a6d = var_1959d9eed24cdcbc;
    level.var_acd2b99cd7e0ad4b = level.var_2745498dd7dc0a6d;
    level notify("player_at_" + var_1959d9eed24cdcbc);
    level notify("player_changed_location");
  }
}

function function_6a929b40729d52b3() {
  if(!isDefined(level.var_52c33d39f2b5db6)) {
    return 0;
  }

  return gettime() - level.var_52c33d39f2b5db6;
}

function play_intro() {
  level endon("intro_skipped");
  flag_wait("dungeon_load_finished");
  level.player utility::hidehudenable();
  flag_set("intro_anim_started");
  anim_org = function_7a18da6e48b71c35("intro_anim_org");
  level.var_42d7fb6665658639 = 0;

  if(namespace_96731f4d002634f6::should_play_intro()) {
    flag_set("infil_start");
    thread infil_music();
    thread namespace_11fae4a66a43bd3f::function_5f1d182a1a42d149();
    anim_org thread function_330eeeb728d01302(&function_9d97cf19b710c998);

    if(!istrue(level.var_70ba8a796731bebb)) {
      anim_org scene::pre_stream(undefined, undefined, 2, "jup_che_infil");
      level.var_70ba8a796731bebb = 1;
    }

    if(isDefined(anim_org)) {
      var_8912c152ca0cf109 = anim_org scene::get_entity("gaz_body");
      var_4217b804e456b5b = scripts\cp\weapon::make_weapon_special("iw9_ar_mcharlie_v2_cp");
      var_24c2257fa2b70cfc = getcompleteweaponname(var_4217b804e456b5b);
      var_490448448ad75254 = spawn("weapon_" + var_24c2257fa2b70cfc, var_8912c152ca0cf109.origin);
      level.var_d9cac0aa3cdaebdc = array_add_safe(level.var_d9cac0aa3cdaebdc, var_490448448ad75254);
      var_b8aeb30263eb33fc = anim_org scene::get_entity("ghost_body");
      var_121fa5b5b26418a2 = scripts\cp\weapon::make_weapon_special("iw9_ar_mcbravo_v1_cp");
      var_c337325338c8c185 = getcompleteweaponname(var_121fa5b5b26418a2);
      var_a0f9aa345937f90d = spawn("weapon_" + var_c337325338c8c185, var_b8aeb30263eb33fc.origin);
      level.var_d9cac0aa3cdaebdc = array_add_safe(level.var_d9cac0aa3cdaebdc, var_a0f9aa345937f90d);
      waitframe();

      if(isDefined(var_490448448ad75254)) {
        var_490448448ad75254 linkTo(var_8912c152ca0cf109, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
      }

      if(isDefined(var_a0f9aa345937f90d)) {
        var_a0f9aa345937f90d linkTo(var_b8aeb30263eb33fc, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
      }
    }

    thread namespace_d1eabe4308f7c3e0::function_292e53c2238646ea(anim_org);
    thread namespace_d1eabe4308f7c3e0::function_8c304f6c47246a43(anim_org);
    anim_org thread function_3d95b6857878990a(undefined, undefined, "jup_che_infil");
    thread function_16003299dc4c309a();
    flag_wait("lgt_infil_face_team");

    if(isDefined(anim_org)) {
      var_8912c152ca0cf109 = anim_org scene::get_entity("gaz_body_wind");
      var_b8aeb30263eb33fc = anim_org scene::get_entity("ghost_body_wind");

      if(isDefined(var_490448448ad75254)) {
        var_490448448ad75254 linkTo(var_8912c152ca0cf109, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
      }

      if(isDefined(var_a0f9aa345937f90d)) {
        var_a0f9aa345937f90d linkTo(var_b8aeb30263eb33fc, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
      }
    }

    anim_org waittill("scene_complete");
    anim_org function_9d97cf19b710c998();
  }

  function_860a5c1214190a7c();
}

function function_16003299dc4c309a() {
  level endon("intro_skipped");
  wait 48;

  if(!issubstr(level.mapname, "_dev")) {
    level notify("show_chyrons");
  }
}

function infil_music() {
  wait 1.4;
  setmusicstate("mx_chemical_infil");
}

function function_9d97cf19b710c998(sceneroot) {
  if(!isDefined(sceneroot)) {
    sceneroot = self;
  }

  if(isDefined(level.var_bb35882347c384b4)) {
    array_thread(level.var_bb35882347c384b4, &function_91da54e1e2dd71a0);
  }

  if(isDefined(level.var_1cd8f1e3b626982a)) {
    array_thread(level.var_1cd8f1e3b626982a.ai_spawned, &function_91da54e1e2dd71a0);
  }

  if(isDefined(level.var_d9cac0aa3cdaebdc)) {
    foreach(prop in level.var_d9cac0aa3cdaebdc) {
      prop delete();
    }
  }

  thread namespace_11fae4a66a43bd3f::function_dcfccfbf8b83acb8();
}

function function_330eeeb728d01302(var_6b3bd87d12cded0f) {
  userskipped = level.player scripts\cp\globallogic::userskip_wait();

  if(!userskipped) {
    return;
  }

  flag_set("intro_skipped");
  thread scripts\common\lighting::function_9160006a3f10b2cd();
  thread namespace_d1eabe4308f7c3e0::function_b4df42d037666638();
  level.playback_scene scripts\common\scene::stop();
  level.playback_scene function_b96b3877eda7204();

  if(isDefined(var_6b3bd87d12cded0f)) {
    [[var_6b3bd87d12cded0f]](level.playback_scene);
  }

  level notify("lgt_infil_end");
  var_e42561c452fdd327 = (0, 0, 0);
  level.var_96e7bf81fce2db80 = function_a3f197f512a38c54();
  level.var_ba79225b4b69742e = var_e42561c452fdd327;
  level.var_42d7fb6665658639 = 1;
  function_860a5c1214190a7c();
}

function function_a3f197f512a38c54() {
  var_43746bf4559cb47b = (-16014.5, 26721.7, 11827.3);
  return function_7f4f3474ccfa80b4(var_43746bf4559cb47b);
}

function function_7f4f3474ccfa80b4(var_43746bf4559cb47b) {
  return var_43746bf4559cb47b - (0, 0, level.player getplayerviewheight("stand"));
}

function function_3d95b6857878990a(existingentities, shotnames, scriptbundlename, var_f7ab585bff4b110, var_198fc279325346db) {
  level endon("intro_skipped");
  var_9f57e5e50ac5c164 = scene::get_entity("jm_body");

  if(isDefined(var_9f57e5e50ac5c164)) {
    scripts\common\visibility_mode::function_8ba05ef17e2b7d10(var_9f57e5e50ac5c164, "allies");
  }

  level.playback_scene = self;
  scene::play(existingentities, shotnames, scriptbundlename, var_f7ab585bff4b110);
  var_43746bf4559cb47b = level.player getxcamposition("jup_che_infil_xcam_08", 1, 0, self.origin, self.angles);
  var_e42561c452fdd327 = level.player getxcamangles("jup_che_infil_xcam_08", 1, 0, self.origin, self.angles);

  if(isDefined(var_43746bf4559cb47b) && isDefined(var_e42561c452fdd327)) {
    level.var_96e7bf81fce2db80 = function_7f4f3474ccfa80b4(var_43746bf4559cb47b);
    level.var_ba79225b4b69742e = var_e42561c452fdd327;
    level.var_42d7fb6665658639 = 1;
  }

  self notify("scene_complete");
}

function play_outro() {
  thread namespace_11fae4a66a43bd3f::function_588af84fad23df23("cp_jup_chemical_sfx_exfil");
  thread namespace_11fae4a66a43bd3f::function_8c3edcd5e0af11af();
  flag_wait("dungeon_load_finished");
  level thread scripts\cp\cp_outofbounds::enableoobimmunity(level.player);
  flag_set("flag_dungeon_outro_start");
  flag_wait("player_spawned_with_loadout");

  if(isDefined(level.allies)) {
    foreach(ally in level.allies) {
      ally.invulnerable = 0;
      ally scripts\cp_mp\agents\agent_utils::despawnagent();
    }
  }

  level.player utility::hidehudenable();
  level.player playerhide();
  thread function_47c41ca30301d5f3(&function_c6cd8f35e178f85);
  function_a925e0022b6646ed();
  function_eabc58ac757c4dd5();
  flag_set("flag_dungeon_outro_complete");
  thread namespace_11fae4a66a43bd3f::function_afad8767dca9b688("cp_jup_chemical_sfx_exfil", 2);
  thread namespace_11fae4a66a43bd3f::function_afad8767dca9b688("cp_jup_chemical_sfx_reactor", 2);
}

function function_a925e0022b6646ed() {
  level endon("outro_skipped");
  anim_org = function_7a18da6e48b71c35("outro_anim_scene_part1");
  level.playback_scene = anim_org;
  thread namespace_d1eabe4308f7c3e0::function_fd6901fbd5afbe90(anim_org);
  level thread function_edc6a3ca521536f4(8);
  level thread function_23000fe67407ff7c();
  anim_org delaythread(level.framedurationseconds, &function_e6fbdf2fdcc09f86);
  anim_org scene::play(undefined, undefined, "jup_che_exfil_part1");
  level.player freezecontrols(1);
  setDvar(@ "cg_drawcrosshair", 0);
  wait 3;
}

function function_eabc58ac757c4dd5() {
  if(flag("outro_skipped")) {
    return;
  }

  level flag_set("outro_bink_started");
  thread namespace_11fae4a66a43bd3f::function_afad8767dca9b688("cp_jup_chemical_sfx_reactor", 2);
  thread namespace_11fae4a66a43bd3f::function_a905955046e1e5da();
  thread namespace_11fae4a66a43bd3f::function_e54f7091bb7fcc18();
  var_7848ff3f98ef4a73 = 0;
  var_8c6c2faac72ea626 = 3;
  videoname = "cp_jup_chemical_cine_outro";
  var_eb7fddb0dd38cf63 = 90;
  var_1bab87417f147c8f = 0;

  foreach(player in level.players) {
    player setclientomnvar("ui_cp_bink_overlay_state", var_8c6c2faac72ea626);
  }

  playcinematicforall(videoname, 1, var_1bab87417f147c8f);
  msg = level waittill_any_timeout_2(var_eb7fddb0dd38cf63, "bink_complete", "skip_bink_input");

  if(msg == "bink_complete") {
    var_dd196a9f7e736ca4 = 0;
  } else {
    var_dd196a9f7e736ca4 = 1;
  }

  stopcinematicforall(var_dd196a9f7e736ca4);

  foreach(player in level.players) {
    player setclientomnvar("ui_cp_bink_overlay_state", var_7848ff3f98ef4a73);
  }
}

function function_90830af7ed501ee2(channel, val) {
  if(channel == "bink_complete") {
    level notify("bink_complete");
    thread namespace_11fae4a66a43bd3f::function_a905955046e1e5da();
  }
}

function function_47c41ca30301d5f3(var_6b3bd87d12cded0f) {
  userskipped = level.player scripts\cp\globallogic::userskip_wait();

  if(!userskipped) {
    return;
  }

  while(!isDefined(level.playback_scene)) {
    waitframe();
  }

  flag_set("outro_skipped");
  thread namespace_11fae4a66a43bd3f::function_afad8767dca9b688("cp_jup_chemical_sfx_exfil", 2);
  thread namespace_11fae4a66a43bd3f::function_afad8767dca9b688("cp_jup_chemical_sfx_reactor", 2);
  thread namespace_11fae4a66a43bd3f::function_a905955046e1e5da();
  thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.player, 1);
  delaythread(0.1, &scripts\cp_mp\utility\game_utility::fadetoblackforplayer, level.player, 0);

  if(!flag("outro_bink_started")) {
    level.playback_scene scripts\common\scene::stop();
  }

  if(isDefined(var_6b3bd87d12cded0f)) {
    [[var_6b3bd87d12cded0f]](level.playback_scene);
  }

  level notify("lgt_exfil_end");
}

function function_c6cd8f35e178f85(sceneroot) {
  setDvar(@ "cg_drawcrosshair", 1);
}

function function_edc6a3ca521536f4(num_frames) {
  level endon("game_ended");
  level endon("outro_skipped");

  for(i = 0; i < num_frames; i++) {
    waitframe();
  }

  level.reactor_rope delete();
}

function function_23000fe67407ff7c() {
  level endon("game_ended");
  level endon("outro_skipped");
  level flag_wait("lgt_exfil_face_exit");
  level.fog setscriptablepartstate("test_part", "bbox_exfil");
}

function function_8d57b2faccc4297e() {
  level endon("game_ended");
  level endon("outro_skipped");
  level flag_wait("exfil_fade_to_black");
  fadetoblackforplayer(level.player, 1, 1);
  level flag_wait("exfil_unfade");
  fadetoblackforplayer(level.player, 0, 1);
}

function function_e6fbdf2fdcc09f86(var_136b512f693efdb) {
  var_136b512f693efdb = utility::default_to(var_136b512f693efdb, 0);

  if(isDefined(self)) {
    var_b8aeb30263eb33fc = scene::get_entity("ghost_body");

    if(isDefined(var_b8aeb30263eb33fc)) {
      var_121fa5b5b26418a2 = scripts\cp\weapon::make_weapon_special("iw9_ar_mcbravo_v1_cp");
      var_c337325338c8c185 = getcompleteweaponname(var_121fa5b5b26418a2);
      var_a0f9aa345937f90d = spawn("weapon_" + var_c337325338c8c185, var_b8aeb30263eb33fc.origin);
    }

    if(!var_136b512f693efdb) {
      var_cdeb472dcd8c14fa = scene::get_entity("soap_body");

      if(isDefined(var_cdeb472dcd8c14fa)) {
        var_ec2c9a40a880fc9 = spawn("weapon_iw9_dm_xmike2010_mp+ammo_300wm+bar_sn_light_p20_xmike2010|1+bipod01|3+bolt_p20|1+mike24_scope|1+pgrip_ass_p20|1+rec_xmike2010|1+stock_sn_heavy_p20|1+xmag_sn_p20|1+loot1", var_cdeb472dcd8c14fa.origin);
      }

      var_8912c152ca0cf109 = scene::get_entity("gaz_body");

      if(isDefined(var_8912c152ca0cf109)) {
        var_4217b804e456b5b = scripts\cp\weapon::make_weapon_special("iw9_ar_mcharlie_v2_cp");
        var_24c2257fa2b70cfc = getcompleteweaponname(var_4217b804e456b5b);
        var_490448448ad75254 = spawn("weapon_" + var_24c2257fa2b70cfc, var_8912c152ca0cf109.origin);
      }
    }

    waitframe();

    if(isDefined(var_a0f9aa345937f90d)) {
      var_a0f9aa345937f90d linkTo(var_b8aeb30263eb33fc, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
    }

    if(isDefined(var_ec2c9a40a880fc9)) {
      var_ec2c9a40a880fc9 linkTo(var_cdeb472dcd8c14fa, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
    }

    if(isDefined(var_490448448ad75254)) {
      var_490448448ad75254 linkTo(var_8912c152ca0cf109, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
    }
  }
}

function function_1fdbf07dcc8fbefc() {}

function function_ac8d7ba62722898f() {
  level.var_1369e1e96a31be5e = 1;
  level.var_b9d5a2af2d535f77 = 0;
  thread function_98912339dc6732a0();
  function_9250dfcc43a9ccb9();
  function_f1adfa1228daaf33();
  thread namespace_d1eabe4308f7c3e0::function_b02ce5451b2a3f4a();
}

function function_6f1065377b6d45ca() {
  level.var_1369e1e96a31be5e = 1;
  level.var_aa14b2beb1308584 = 5;
  level.var_b9d5a2af2d535f77 = 0;
  level thread function_949674a8c3e85573();
  function_9250dfcc43a9ccb9();
  function_f1adfa1228daaf33();
  thread namespace_d1eabe4308f7c3e0::function_50f821da2df0f2f7();
  level flag_set("flag_obj_all_helis_killed");
  function_c72ff775cd61b11(@ "hash_13f7784c917c1e38", 0, 1);
}

function function_b327d0c532fe8b47() {
  function_6f1065377b6d45ca();
}

function function_b327cfc532fe8914() {
  function_6f1065377b6d45ca();
}

function function_7c921888c7d44907() {
  level.var_1369e1e96a31be5e = 1;
  level.var_aa14b2beb1308584 = 5;
  level.var_b9d5a2af2d535f77 = 0;
  function_9250dfcc43a9ccb9();
  function_f1adfa1228daaf33();
  thread namespace_d1eabe4308f7c3e0::function_1d37f9a755d93118();
  function_758a0054dcf55fa5();
  level flag_wait("flag_scripted_doors_initialized");
  level thread function_b0010ece31b338c4();
  level flag_set("reactor_doors_force_closed");
  level thread function_21eea784f61fc97a();
}

function function_b0f6d6910f3b8af8() {
  level.var_1369e1e96a31be5e = 1;
  level.var_b9d5a2af2d535f77 = 0;
  level.var_aa14b2beb1308584 = 5;

  if(true) {
    level.var_f8c6cda869a327d7 = 0;
    level thread function_9046cafa919979b1();
    level thread exfil_interact();
  }

  function_9250dfcc43a9ccb9();
  function_f1adfa1228daaf33();
  thread namespace_d1eabe4308f7c3e0::function_a03a8a9f23f22041();
}

function function_9dea4b1498c22533() {
  level.var_1369e1e96a31be5e = 1;
  level.var_b9d5a2af2d535f77 = 0;
  function_9250dfcc43a9ccb9();
  function_f1adfa1228daaf33();
}

function function_f1adfa1228daaf33() {
  flag_wait("checkpoint_data_retrieved");
  level.player waittill("loadout_class_selected");
  startpoint = getStruct(level.start_point + "_start", "targetname");

  if(level.start_point == "investigate") {
    level.player setOrigin((-16031, 26732.1, 11846.4));
    level.player setplayerangles((360, 2.80852, 0));
    return;
  }

  level.player setOrigin(startpoint.origin);
}

function function_ac2e42c678489275() {
  flag_wait("start_is_set");
  start = level.start_point;

  if(!isDefined(start) || start == "") {
    return;
  }

  if(start == "loadout") {
    return;
  }

  flag_set("flag_loadout_tutorial_completed");
  flag_set("flag_infil_interacted");

  if(start == "investigate" || issubstr(start, "debug_")) {
    return;
  }

  flag_set("flag_power_plant_entered");
  flag_set("flag_reactor_room_entered");
  flag_set("infil_player_landed");
  flag_set("flag_obj_all_helis_killed");

  if(start == "reactor" || start == "reactor_2" || start == "reactor_3") {
    return;
  }

  flag_set("flag_reactor_airlock_passed");
  flag_set("flag_drop_chemical");
  flag_set("flag_escape_start");

  if(start == "escape") {
    return;
  }

  flag_set("flag_chemicals_airlifted");

  if(false) {
    flag_set("flag_exit_interacted");
  }

  if(start == "exfil") {
    return;
  }
}

function function_7d66551301c281c2() {
  if(!isDefined(level.checkpoint)) {
    return;
  }

  if(level.checkpoint != "") {
    flag_set("flag_dungeon_intro_complete");
  }

  if(level.checkpoint_reached) {
    flag_set("infil_player_landed");
    flag_set("flag_obj_reconArea_start");
    flag_set("flag_obj_all_helis_killed");
  }
}

function function_7852db0bc9d7b7ed() {
  level endon("game_ended");
  level thread function_57661187a22eb553();

  if(!level.checkpoint_reached) {
    function_2ac0170535694144();
    function_776d1112874496ce();
  }
}

function function_de5ae0c94d33b9c8() {
  utility::flag_wait("dungeon_load_finished");
  utility::flag_wait("flag_dungeon_intro_complete");
  level endon("game_ended");
  level.player endon("death");
  oow_vol = function_1c4d592029f2b0d3("debug_outofworld");

  while(isDefined(oow_vol)) {
    oow_vol waittill("trigger", ent);

    if(isPlayer(ent) && (ent isnoclip() || ent isufo())) {
      wait 0.1;
      continue;
    }

    assertmsg("<dev string:x1c>" + ent.origin);
    iprintlnbold("<dev string:x1c>" + ent.origin);

    if(isPlayer(ent) || isai(ent) || ent scripts\common\vehicle::isvehicle()) {
      ent kill();
    }
  }
}

function function_42168064f6ef466d(agent, requestid, data) {
  agent thread function_390e9e76979a0a95();

  if(isDefined(agent.directorspawndata) && is_equal(agent.directorspawndata.script_stealthgroup, "heli_backup_group")) {
    spawner = spawnStruct();
    spawner.script_laser = "1";
    agent.spawner = spawner;
  }

  agent function_ac9858751652fb9e();
  agent thread function_1308ec055ee61e28("flag_reactor_airlock_passed");
  agent.team = "axis";
  agent.var_4ebe755e0a0a430e = 1;
  agent thread scripts\anim\squadmanager::addtosquad();

  switch (agent.script_stealthgroup) {
    case #"hash_34541017062c8606":
      agent thread function_6163bb4ead793248();
      break;
    case #"hash_263e5786a4b44262":
      agent thread function_6163bb4ead793248();
      break;
    case #"hash_7eb485fdeeeff677":
      agent thread function_6163bb4ead793248();
      break;
    case #"hash_c9f5f205f871a567":
      agent thread function_c6faafcc2682c012();
      break;
    case #"hash_af970bc5dd2845c":
      break;
    default:
      agent thread function_4d465d050b83fcd2();
      break;
  }

  if(is_equal(requestid, level.var_d3eb8ba0514d4d33)) {
    agent thread function_702e798820b092af();
  }

  agent scripts\cp\spawning::function_389fff85c076f49e();
  agent.dropweapon = 1;
}

function function_702e798820b092af() {
  level endon("game_ended");
  self waittill("death");

  if(!isDefined(level.var_67412c31c80f71fc)) {
    level.var_67412c31c80f71fc = 0;
  }

  if(ai_killed_by_player()) {
    level.var_67412c31c80f71fc++;
  }

  if(level.var_67412c31c80f71fc >= 5) {
    function_fc38783a3da0bc71(level.var_d3eb8ba0514d4d33, 0);
  }
}

function function_c6faafcc2682c012() {
  if(isDefined(self.directorspawndata) && istrue(self.directorspawndata.restored)) {
    thread function_6163bb4ead793248();
    return;
  }

  while(!isDefined(self.ridingvehicle)) {
    wait 0.1;
  }

  thread function_d974cba04d067bfa(&function_fd6ae4370d24af16);
  thread function_d974cba04d067bfa(&function_792bcb78368a1a6b);
  thread function_d974cba04d067bfa(&function_924b9e221b30f091);
}

function function_66d2ad9b363f899b() {
  locs = getStructArray("outskirt_combat_setup", "targetname");
  level.var_d1c683a327fa3693 = [];

  foreach(loc in locs) {
    loc.var_ca9e2734703e3128 = function_1c4d592029f2b0d3(loc.target);
    loc.var_9c50058664583426 = function_1c4d592029f2b0d3(loc.var_ca9e2734703e3128.target);
    level.var_d1c683a327fa3693[loc.script_noteworthy] = loc;
  }
}

function function_a1488439edcfbd1d(stealthgroup) {
  return level.var_d1c683a327fa3693[stealthgroup];
}

function function_4d465d050b83fcd2() {
  level.player endon("death");
  self endon("death");
  var_ef645b5de70c708b = function_a1488439edcfbd1d(self.script_stealthgroup);

  if(!isDefined(var_ef645b5de70c708b)) {
    iprintlnbold("<dev string:x93>" + self.script_stealthgroup);

    return;
  }

  var_5dea04c14ea2fb18 = var_ef645b5de70c708b.var_ca9e2734703e3128;
  var_de199c42d7a7676a = var_ef645b5de70c708b.var_9c50058664583426;
  var_62f80bdfadeffb17 = var_ef645b5de70c708b.radius;

  while(!is_equal(self.alertlevel, "combat")) {
    wait 1;
  }

  if(distance2d(var_ef645b5de70c708b.origin, level.player.origin) > var_62f80bdfadeffb17) {
    self setgoalvolumeauto(var_de199c42d7a7676a);
    self.grenadeammo = 0;
    wait 5;

    while(distance2d(var_ef645b5de70c708b.origin, level.player.origin) > var_62f80bdfadeffb17) {
      wait 0.5;
    }
  }

  while(true) {
    self setgoalvolumeauto(var_5dea04c14ea2fb18);
    self.grenadeammo = 1;
    wait 15;

    while(distance2d(var_ef645b5de70c708b.origin, level.player.origin) < var_62f80bdfadeffb17) {
      wait 0.25;
    }

    self setgoalvolumeauto(var_de199c42d7a7676a);
    self.grenadeammo = 0;
    wait 5;

    while(distance2d(var_ef645b5de70c708b.origin, level.player.origin) > var_62f80bdfadeffb17) {
      wait 0.5;
    }
  }
}

function function_924b9e221b30f091() {
  self endon("death");
  level.player endon("death");
  self.var_4ebe755e0a0a430e = 0;

  while(true) {
    wait 1;
    var_589c0eb9803a3415 = distance(level.player.origin, self.origin);

    if(var_589c0eb9803a3415 < 800) {
      if(!istrue(self.var_4ebe755e0a0a430e)) {
        self.var_4ebe755e0a0a430e = 1;
        wait 16;
      }

      continue;
    }

    if(istrue(self.var_4ebe755e0a0a430e)) {
      self.var_4ebe755e0a0a430e = 0;
      self notify("kill_debug_text_stopandengage");
    }
  }
}

function function_edfdeb5ca879ab4f() {
  flag_set("flag_player_movement_reset");
}

function function_fc79a15a81bb47e(loc) {
  assert(isDefined(level.var_23e3a2d87c67352a));
  var_9ef070d8bdb295d1 = 0;

  foreach(ping in level.var_23e3a2d87c67352a) {
    if(distance(ping, loc) < 1000) {
      var_9ef070d8bdb295d1++;
    }
  }

  return var_9ef070d8bdb295d1;
}

function function_aeaf1c3f29fc4ccf(loc) {
  assert(isDefined(level.var_23e3a2d87c67352a));
  var_9ef070d8bdb295d1 = 0;

  foreach(ping in level.var_23e3a2d87c67352a) {
    if(distance(ping, loc) < 1000) {
      var_9ef070d8bdb295d1++;
    }
  }

  return var_9ef070d8bdb295d1;
}

function player_connect(params) {
  player = self;
  player endon("disconnect");
  waitframe();

  if(level.checkpoint != "") {
    return;
  }

  if(!flag("infil_start") && should_play_intro() && !istrue(level.var_1369e1e96a31be5e) && !istrue(level.var_70ba8a796731bebb)) {
    anim_org = function_7a18da6e48b71c35("intro_anim_org");
    anim_org scene::pre_stream(player, undefined, -1, "jup_che_infil");
    level.var_70ba8a796731bebb = 1;
  }
}

function function_137fc90d1f21350c() {
  level.player waittill("killed_player");
  attacker = level.player.attacker;

  if(isDefined(level.player.laststanddowneddata) && isDefined(level.player.laststanddowneddata.weaponfullstring)) {
    attacker_weapon = level.player.laststanddowneddata.weaponfullstring;
  }

  deathBy = "generic";
  deathquote = undefined;

  if(isDefined(attacker)) {
    if(issubstr(attacker_weapon, "chopper_gunner")) {
      deathBy = "attack_heli";
      deathquote = 525;
    } else if(issubstr(attacker_weapon, "claymore")) {
      deathBy = "claymore";
      deathquote = 527;
    } else if(isDefined(level.var_ebc1f5321a243d72) && array_contains(level.var_ebc1f5321a243d72, attacker)) {
      deathBy = "turret";
      deathquote = 526;
    } else if(issubstr(attacker_weapon, "rpg")) {
      deathBy = "rpg";
      deathquote = 529;
    } else if(function_8ebbf1cd188fd66a(attacker)) {
      deathBy = "rooftop";
      deathquote = 528;
    } else if(flag("flag_marker_on_exit_ascender")) {
      deathquote = 532;
    } else if(isDefined(level.player.var_121e3ac332418d67) && !time_has_passed(level.player.var_121e3ac332418d67, 5)) {
      deathquote = 530;
    } else if(isDefined(level.var_841cae3f1e141ba7) && array_contains(level.var_841cae3f1e141ba7, attacker)) {
      deathquote = 533;
    } else if(flag("flag_reactor_airlock_passed")) {
      deathquote = 531;
    } else if(issubstr(attacker_weapon, "heli_explode")) {
      deathquote = 534;
    }
  }

  namespace_96731f4d002634f6::function_2311740fe797906a("deathBy", deathBy);

  if(isDefined(deathquote)) {
    set_custom_death_quote(deathquote, 1);
  }
}

function function_ba8d6171b09f531a() {
  vols = function_3fd029c94a177d06("vol_interior");

  while(true) {
    wait 1;

    foreach(vol in vols) {
      while(level.player istouching(vol)) {
        flag_clear("player_outside");
        flag_set("player_inside");
        wait 1;
      }

      flag_clear("player_inside");
      flag_set("player_outside");
      wait 1;
    }
  }
}

function function_8ebbf1cd188fd66a(attacker) {
  if(isDefined(level.var_ae387dac8e414d95) && isDefined(level.var_ae387dac8e414d95.ai_spawned) && array_contains(level.var_ae387dac8e414d95.ai_spawned, attacker)) {
    return true;
  }

  if(isDefined(level.var_71cc4d36ef542471) && isDefined(level.var_71cc4d36ef542471.ai_spawned) && array_contains(level.var_71cc4d36ef542471.ai_spawned, attacker)) {
    return true;
  }

  return false;
}

function function_e63c28f08bfec3a5() {
  for(iter = 0; true; iter++) {
    level waittill("vtol_jet_arrived");
    jet = level.hoverjets[iter];
  }
}

function function_6a0923938de9a977() {
  self endon("death");
  self endon("crashing");
  level endon("game_ended");

  while(true) {
    wait 10;
    enemies = getaiarrayinradius(self.origin, 3000, "axis");

    foreach(enemy in enemies) {
      enemy forcethreatupdate();
    }
  }
}

function function_8d08ce0def2d357() {}

function function_498bb6295d0e990() {
  level endon("game_ended");
  level flag_wait("level_ready_for_script");
  level flag_wait("checkpoint_data_retrieved");
  level.player waittill("loadout_class_selected");
  level flag_set("flag_loadout_tutorial_completed");
  level flag_set("obj_loadout_completed");

  if(istrue(level.checkpoint_reached)) {
    return;
  }

  level thread play_intro();
  level flag_wait("flag_dungeon_intro_complete");

  if(!istrue(level.var_1369e1e96a31be5e)) {
    var_c384f4835f91169a = function_a3f197f512a38c54();
    var_7ca4119130e5c3a0 = (0, 0, 0);
    spawnpoint = istrue(level.var_42d7fb6665658639) ? level.var_96e7bf81fce2db80 : var_c384f4835f91169a;
    spawnangles = istrue(level.var_42d7fb6665658639) ? level.var_ba79225b4b69742e : var_7ca4119130e5c3a0;
    level.player setOrigin(spawnpoint);
    level.player setplayerangles(spawnangles);
  }
}

function function_da2fe8342d30c7d1() {}

function function_26a01f4af94cb7bd() {
  level endon("game_ended");
  level flag_wait("flag_loadout_tutorial_completed");
  level flag_wait("flag_dungeon_intro_complete");

  if(istrue(level.checkpoint_reached)) {
    return;
  }

  if(istrue(level.var_1369e1e96a31be5e)) {
    level.player waittill("loadout_class_selected");
  }

  iprintlnbold("<dev string:xbe>");

  level thread function_a1a34ae023aa0548();
  level thread function_7ea45e6216024588();
  level thread function_3b653fc3568d4150();
  level thread function_ce4905c84266e247();
  level thread function_1c966cea6dd38b9();
  level thread function_949674a8c3e85573();
  level thread function_6c4960c6abd68582();
  level thread function_c0c12989d0f845cc("flag_obj_all_helis_killed");
  level thread function_5d7807a0f94f94f0();
  level thread function_e92aa26a36ca25fb();
  level thread function_9fdd4ad49aa8eb0a();
  level thread function_9df0d68419bf4e66();
  level flag_wait("flag_reactor_airlock_passed");
}

function function_5d7807a0f94f94f0() {
  level.intro_jltv_1 = function_19881055369262f5("intro_jltv_1", 0, 0, &function_e6b4df5383358fae, undefined, 1, 1);
  level.intro_jltv_2 = function_19881055369262f5("intro_jltv_2", 0, 0, &function_e6b4df5383358fae, undefined, 1);
  var_139140003df274df = getStruct("containment_veh_start", "targetname");
  trig = function_f159c10d5cf8f0b4("force_intro_vehicle_move_trig", "targetname")[0];
  thread function_d1fdfd8f4cf74e50("flag_force_intro_vehicle_move", trig);

  if(isDefined(var_139140003df274df)) {
    thread function_bdc60d1ad098faa4("flag_player_sees_containment_veh", var_139140003df274df.origin, 60, 0, 3600);
  }

  thread flag_set_delayed("flag_intro_vehicle_move_timeout", 60);
  level waittill_any_3("flag_player_sees_containment_veh", "flag_force_intro_vehicle_move", "flag_intro_vehicle_move_timeout");
  level.intro_jltv_1 ent_flag_set("ent_flag_start_pathing");
  level.intro_jltv_1 thread function_e2ed6513d9251dbd();
  level.intro_jltv_1 thread function_e8351029bc19767e();
  wait 5;
  level.intro_jltv_2 ent_flag_set("ent_flag_start_pathing");
  level.intro_jltv_2 thread function_3140388269519418();
  level.intro_jltv_2 thread function_e2ed6513d9251dbd();
  level.intro_jltv_2 thread function_e8351029bc19767e();
  level thread function_f8932fba652f7653();
}

function function_f8932fba652f7653() {
  level endon("game_ended");
  flag_wait("flag_intro_vehicle_approaching_parking");

  if(function_85b29ade98d536d8()) {
    function_401d0838f4f47c3e(0);
  }

  wait 5;

  if(!function_85b29ade98d536d8()) {
    function_401d0838f4f47c3e(1);
  }
}

function function_4940f7ea4f25cf23(initial_delay, var_4e079fe327d06d85) {
  self endon("death");
  level endon("game_ended");

  if(!isDefined(initial_delay)) {
    initial_delay = 0;
  }

  if(!isDefined(var_4e079fe327d06d85)) {
    var_4e079fe327d06d85 = 5000;
  }

  wait initial_delay;

  while(true) {
    wait 1;

    if(distance2d(level.player.origin, self.origin) < var_4e079fe327d06d85) {
      continue;
    }

    if(is_equal(self.alertlevel, "combat")) {
      continue;
    }

    if(function_e7c30095a6cdc3ef(self getEye(), 65, 1)) {
      continue;
    }

    self.nocorpse = 1;
    self.diequietly = 1;
    self kill();
    self delete();
  }
}

function function_d1fdfd8f4cf74e50(var_acba072b7e847a86, var_4cb1038d4bba19ae) {
  while(true) {
    var_4cb1038d4bba19ae waittill("trigger", triggerer);

    if(isPlayer(triggerer)) {
      break;
    }
  }

  flag_set(var_acba072b7e847a86);
}

function function_3140388269519418() {
  self endon("death");
  self endon("unloaded");
  var_3e63d0fb9b2ae44a = 0;
  var_3a93f1dca1772498 = self.riders[0];
  childthread function_b5f175d7e8538e0a();
  var_31228fa7cb06536e = ["outskirt_const_site_group", "power_grid_group", "parking_lot"];

  while(true) {
    ent_flag_wait("vehicle_health_check_fire");
    group_name = self.currentnode.script_parameters;

    if(isDefined(level.player_kills) && isDefined(level.player_kills[group_name]) && level.player_kills[group_name] > 0) {
      wait 8;
      break;
    }

    stealth_group = function_dbc2d928c8e424d9(group_name);

    if(!isDefined(stealth_group) || !isDefined(stealth_group.members)) {
      break;
    }

    foreach(guy in stealth_group.members) {
      if(guy.alertlevel == "combat") {
        var_3e63d0fb9b2ae44a = 1;
        break;
      }

      if(guy.alertlevel == "alert") {
        break;
      }
    }

    if(stealth_group.members.size > 0 && array_contains(var_31228fa7cb06536e, group_name)) {
      var_1e7181cac69593ef = sortbydistance(stealth_group.members, var_3a93f1dca1772498.origin)[0];
      thread function_2d3c30991cdeb505(var_3a93f1dca1772498, var_1e7181cac69593ef);
    }

    wait randomintrange(6, 12);
    ent_flag_clear("vehicle_health_check_fire");
    ent_flag_set("vehicle_health_check_wait");
    wait 1;
    ent_flag_clear("vehicle_health_check_wait");
  }

  foreach(guy in self.riders) {
    guy thread function_916ff114a4e2c5bf(var_3e63d0fb9b2ae44a);
  }

  thread function_353d8d7e478b3ded();
}

function function_b5f175d7e8538e0a() {
  if(!isDefined(self)) {
    return;
  }

  self endon("death");
  level endon("game_ended");

  while(isDefined(self)) {
    ent_flag_wait("vehicle_health_check_nearby");
    group_name = self.currentnode.script_parameters;

    if(isDefined(level.player_kills) && isDefined(level.player_kills[group_name]) && level.player_kills[group_name] > 0) {
      break;
    }

    wait 1;
    ent_flag_clear("vehicle_health_check_nearby");
  }

  flag_set("flag_patrol_approaching_suspicious_site");
}

function function_916ff114a4e2c5bf(var_a6c648dabc4ceaf0) {
  self endon("death");
  self.ridingvehicle ent_flag_wait("unloaded");
  wait 0.5;

  if(var_a6c648dabc4ceaf0) {
    thread function_d21e3bb0ff589389();
    return;
  }

  thread function_5aaaa9e7705ec9ce();
  self setgoalpos(self.origin, 2000);
}

function function_a1a34ae023aa0548() {
  if(array_contains(["debug_start_on_ground", "debug_reactor_beta", "debug_parking_lot", "debug_turbine"], getDvar(@ "start", ""))) {
    return;
  }

  level.player thread function_3722e0b14a14a441();
  level.player skydive_setdeploymentstatus(0);
  level.player skydive_setbasejumpingstatus(0);

  if(!istrue(level.player.weapongiven)) {
    level.player waittill_notify_or_timeout("gave_weapon", 5);
  }

  waitframe();
  level.player skydive_beginfreefall();
  thread namespace_11fae4a66a43bd3f::function_67d05c35d51c45a6();

  if(level.var_b9d5a2af2d535f77) {
    level.player notify("swap_weapon");
    level.var_b9d5a2af2d535f77 = 0;
  }

  level.player allowmovement(0);
  level thread function_1f53f427400fcac6();

  while(level.player.origin[2] > 5500) {
    waitframe();
  }

  level.player allowmovement(1);
  waitframe();
  level.player skydive_setdeploymentstatus(1);
  level.player skydive_setbasejumpingstatus(1);
}

function function_3722e0b14a14a441() {
  waitframe();
  level thread scripts\cp\cp_outofbounds::enableoobimmunity(level.player);

  while(level.player.origin[2] > 6000) {
    waitframe();
  }

  level thread scripts\cp\cp_outofbounds::disableoobimmunity(level.player);
  flag_set("enable_oob_vo");
}

function function_1f53f427400fcac6() {
  level endon("infil_player_landed");
  var_9ae76f1059b5b4 = undefined;

  while(level.player isonground()) {
    waitframe();
  }

  while(!level.player isonground()) {
    push_vector = (4.7, 1, 0);
    level.player pushplayervector(push_vector, 1);

    if(getdvarint(@ "hash_67af7671c334c539")) {
      printtoscreen2d(100, 400, "<dev string:xcf>" + push_vector, (0, 1, 1), 2);
    }

    while(!level.player isparachuting()) {
      if(getdvarint(@ "hash_67af7671c334c539")) {
        printtoscreen2d(100, 400, "<dev string:xcf>" + push_vector, (0, 1, 1), 2);
      }

      waitframe();
    }

    flag_set("flag_player_has_used_parachute_once");
    var_1b5c185de7ddaad7 = -0.37;
    last_x = level.player.origin[0];

    while(level.player isparachuting()) {
      if(!isDefined(var_9ae76f1059b5b4)) {
        var_9ae76f1059b5b4 = level.player.origin[1];
      }

      diff = level.player.origin[0] - last_x;
      last_x = level.player.origin[0];

      if(diff > 0) {
        var_49bda89f6ae905f6 = var_1b5c185de7ddaad7 * diff;
        level.player pushplayervector((var_49bda89f6ae905f6, 0, 0), 1);

        if(getdvarint(@ "hash_67af7671c334c539")) {
          printtoscreen2d(100, 400, "<dev string:xe0>" + var_49bda89f6ae905f6 + "<dev string:xf2>" + var_9ae76f1059b5b4, (1, 1, 0), 2);
        }
      } else {
        level.player pushplayervector((0, 0, 0), 1);

        if(getdvarint(@ "hash_67af7671c334c539")) {
          printtoscreen2d(100, 400, "<dev string:x10d>" + var_9ae76f1059b5b4, (1, 0, 0), 2);
        }
      }

      waitframe();
    }
  }
}

function function_7ea45e6216024588() {
  level endon("game_ended");
  level endon("flag_reactor_room_entered");
  wait 1;

  while(!level.player isonground()) {
    waitframe();
  }

  level flag_set("infil_player_landed");
  level.player pushplayervector((0, 0, 0));
  level.var_35411b0cfb970845 = gettime();
  level flag_set("flag_vo_on_landing");
  thread function_bbbe8a635002a8aa();
}

function function_bbbe8a635002a8aa() {
  wait 3.5;
  namespace_b96fa4d8ce10f926::function_6ae6331457ff833d();
}

function function_3b653fc3568d4150() {
  level endon("game_ended");
  level.player endon("death");

  while(true) {
    if(level.var_2745498dd7dc0a6d == "reactorroom" || level.var_2745498dd7dc0a6d == "entry_building" || level.var_2745498dd7dc0a6d == "turbines") {
      level flag_set("flag_power_plant_entered");
      level flag_set("flag_currently_in_power_plant");
    } else {
      level flag_clear("flag_currently_in_power_plant");
    }

    waitframe();
  }
}

function function_ce4905c84266e247() {
  level endon("flag_spotterscope_discoverable_spotted");

  while(!namespace_8c7f8f6b3076a74a::function_b86d00bf56de247()) {
    level.player waittill("binoculars_ads_on");
    level flag_set("flag_spotterscope_used");
    level.player waittill("binoculars_ads_off");
  }

  level flag_set("flag_spotterscope_discoverable_spotted");
}

function function_1c966cea6dd38b9() {
  level endon("game_ended");
  level endon("flag_obj_all_helis_killed");
  level flag_set("vo_spotter_nag");

  while(!flag("flag_obj_all_helis_killed")) {
    level.player waittill("binoculars_ads_off");
    var_f2dfdc28fede195d = gettime();
    thread function_5765fce6319d5a76(var_f2dfdc28fede195d);
    level.player waittill("binoculars_ads_on");
  }
}

function function_5765fce6319d5a76(time) {
  while(true) {
    wait 0.25;

    if(time_has_passed(time, 180)) {
      level flag_set("vo_spotter_nag");
      return;
    }

    level flag_clear("vo_spotter_nag");
  }
}

function function_949674a8c3e85573() {
  while(!isDefined(level.player)) {
    waitframe();
  }

  while(!isDefined(level.var_1b908bf18691b097)) {
    waitframe();
  }

  if(!istrue(level.var_1b908bf18691b097.ascender_tool)) {
    level.player waittill("ascender_device_pickedup");
  } else {
    level flag_set("flag_ascender_tool_previously_found");
  }

  level flag_set("flag_ascender_tool_acquired");
}

function function_6c4960c6abd68582() {}

function function_2e10892418fffef3(requestid, userdata, wavenumber) {
  return flag("flag_interior_turbine_spawn_reinforcements");
}

function sentry_truck() {
  var_d403781f4aa5743b = getStruct("sentry_truck", "targetname");
  var_e6ea43bf8f7f8971 = function_136d8a6a5c016d7e(var_d403781f4aa5743b);
  var_6e7032bc1694f593 = getStruct("truck_sentrygun", "targetname");
  var_6e7032bc1694f593.var_2108ba0559bdaaff = &namespace_4848403b6f5b0da0::function_5e66cae8a3e9f368;
  var_eb0ad382dcbc2e63 = namespace_4848403b6f5b0da0::setup_enemy_sentry(var_6e7032bc1694f593);
  level.var_ebc1f5321a243d72 = array_add(level.var_ebc1f5321a243d72, var_eb0ad382dcbc2e63);
  var_47c0752bc7314adb = var_e6ea43bf8f7f8971 gettagorigin("tag_seat_wm_5");
  var_eb0ad382dcbc2e63.origin = var_47c0752bc7314adb;
  var_eb0ad382dcbc2e63 linkTo(var_e6ea43bf8f7f8971, "tag_seat_wm_5", (0, 25, 0), (0, 180, 0));
  var_e6ea43bf8f7f8971 thread function_a2853bf75e62b63f(var_eb0ad382dcbc2e63);
}

function function_a2853bf75e62b63f(turret) {
  self waittill("death");

  if(isDefined(turret)) {
    turret delete();
  }
}

function function_9df0d68419bf4e66() {
  flag_wait("flag_reactor_airlock_passed");
  function_9a2f396c1be344d9();
  thread function_a6393d0f5c4a44b2();
}

function function_a6393d0f5c4a44b2() {
  var_c61f7b58f280d21b = getStruct("anim_pit_org", "targetname");
  var_448a5f56a2e073dd = getEntArray("script_model", "classname");
  offhand_boxes = [];
  var_d71ef87ba9ca8151 = ["un_military_backpack_open_01", "un_military_storage_container_small_open_01", "un_military_storage_container_02_open", "container_ammo_box_01_bottom", "un_military_storage_container_small_base_01"];

  foreach(script_model in var_448a5f56a2e073dd) {
    if(array_contains(var_d71ef87ba9ca8151, script_model.model)) {
      offhand_boxes[offhand_boxes.size] = script_model;
    }
  }

  iprintlnbold("<dev string:x13b>" + offhand_boxes.size);

  var_81e691dcc4218ced = [];

  foreach(offhand_box in offhand_boxes) {
    if(distance2d(var_c61f7b58f280d21b.origin, offhand_box.origin) > 1300) {
      var_81e691dcc4218ced[var_81e691dcc4218ced.size] = offhand_box;
    }
  }

  array_call(var_81e691dcc4218ced, &delete);
}

function function_41cfc853e9ac94cf() {}

function function_446a0ab3bcf9e922() {
  level endon("game_ended");
  flag_wait("player_spawned_with_loadout");

  iprintlnbold("<dev string:x14d>");

  if(istrue(level.checkpoint_reached) && !istrue(level.var_f8c5ab19e120757d)) {
    return;
  }

  if(flag("flag_reactor_flow_start")) {
    return;
  }

  level flag_set("flag_reactor_flow_start");
  level.var_ec09dd198521feea = 1;
  level thread function_dc83644c74cbc343();
  level thread function_1f93ed666bd33c1e();
  level thread function_7ae489caad82fdc3();
  level thread function_21eea784f61fc97a();
  level thread function_f72de2b4a3d97f5f();
  level thread function_a0faf56265cce209();
  thread namespace_11fae4a66a43bd3f::function_7d929ff767b262a5();
  var_c8fe63afaaa93ef0 = function_7a18da6e48b71c35("chemical_exfil_ascender");

  if(isDefined(var_c8fe63afaaa93ef0)) {
    var_c8fe63afaaa93ef0 thread function_543a4476d1c68216();
  }

  level flag_wait("flag_drop_chemical");
  level flag_set("flag_obj_chemicals_completed");
  level thread function_831cf8aa07146901();
}

function function_a0faf56265cce209() {
  level endon("game_ended");
  level.player endon("death");
  level flag_wait("flag_reactor_airlock_passed");
  function_bb5cab9eba6beb39();
  level thread function_fb07fc2630f44f7b();
  level thread function_956327df64af5204();
  level function_665d474ff040b446(["flag_droptrigger_lookedat_pallet", "flag_droptrigger_exited_airlock", "reactor_combat_start"]);
  level flag_set("flag_drop_chemical");
}

function function_fb07fc2630f44f7b() {
  level endon("game_ended");
  level.player endon("death");
  level endon("flag_drop_chemical");

  while(!isDefined(level.var_44a2219576a45ab2)) {
    waitframe();
  }

  while(!function_3e2bc2bbbc65352a()) {
    waitframe();
  }

  level flag_set("flag_droptrigger_lookedat_pallet");
}

function function_3e2bc2bbbc65352a() {
  canisters = [level.canister, level.var_acbd040dd890d0d2];
  var_8ed6ff4fdf60193f = undefined;
  level.var_44a2219576a45ab2 = function_fdc9d5557c53078e(level.var_44a2219576a45ab2);
  var_604f54b5710b25fe = array_merge(level.var_44a2219576a45ab2, canisters);
  var_8ed6ff4fdf60193f = function_61aef23379ae7542(var_604f54b5710b25fe);
  return isDefined(var_8ed6ff4fdf60193f);
}

function function_956327df64af5204() {
  level endon("game_ended");
  level.player endon("death");

  while(level.player function_28f3273faec1d365()) {
    waitframe();
  }

  level flag_set("flag_droptrigger_exited_airlock");
}

function function_21eea784f61fc97a() {
  level flag_wait("flag_reactor_airlock_passed");
  createthreatbiasgroup("tf141");
  setthreatbias("axis", "tf141", 999999999);
  setthreatbias("tf141", "axis", 999999999);
  battlechatter_off("axis");
  level thread function_247cc3032d77371e();
  level thread function_13140103aec7e2b7();
  level thread function_8c9506dbd1391264();
  function_c303cbc3e7b9687b();
  level thread function_1b380ad1840cf139();
  function_bb5cab9eba6beb39();
  level thread function_ad7caabc33076f6a();
  level thread function_5d5bae8387ba9e56();
  var_ad3fc555f28a17f1 = getdvarfloat(@ "hash_c1d16b078776011e", 9);
  level thread function_de6d6ba6e8b5142e(var_ad3fc555f28a17f1, "flag_drop_chemical");
  level thread function_8547bbffc8f0863b();
}

function function_dc83644c74cbc343() {
  spawn_ghost(function_7a18da6e48b71c35("reactor_ally_antiair_start_1"));
  function_64c20cb1068f5051(function_7a18da6e48b71c35("reactor_ally_antiair_start_2"));
  spawn_soap(function_7a18da6e48b71c35("reactor_ally_antiair_start_3"));
  level.ghost.ignoreall = 1;
  level.gaz.ignoreall = 1;
  level.soap.ignoreall = 1;
  gun = make_weapon_special("iw9_ar_mcharlie_v2_cp");
  level.gaz scripts\anim\shared::forceuseweapon(gun, "primary");
}

function function_1f93ed666bd33c1e() {
  level flag_wait("flag_drop_chemical");
  wait 1;
  level flag_set("vo_reactor_enter");
}

function function_bb5cab9eba6beb39() {
  level endon("game_over");

  while(true) {
    if(level.var_571425accdf6489b ent_flag("flag_reactor_door_state_changing") || level.var_2de1558f693bcff4 ent_flag("flag_reactor_door_state_changing") || level.var_e77be246fdd8927a ent_flag("flag_reactor_door_state_changing")) {
      waitframe();
      continue;
    }

    break;
  }
}

function function_8c9506dbd1391264() {
  function_c72ff775cd61b11(@ "hash_13f7784c917c1e38", 0, 1);
  wait 1;
  function_c72ff775cd61b11(@ "hash_13f7784c917c1e38", 0, 1);

  if(isDefined(level.var_cfbf77df948a8404)) {
    foreach(ai in level.var_cfbf77df948a8404.ai_spawned) {
      ai function_ad2155838fbe0770();
    }
  }

  if(isDefined(level.var_69e071ce303ba14b)) {
    foreach(ai in level.var_69e071ce303ba14b.ai_spawned) {
      ai function_ad2155838fbe0770();
    }
  }

  if(isDefined(level.var_604b8a84cd3caa32)) {
    foreach(ai in level.var_604b8a84cd3caa32.ai_spawned) {
      ai function_ad2155838fbe0770();
    }
  }

  if(isDefined(level.var_941a0ebe361e653a)) {
    foreach(ai in level.var_941a0ebe361e653a.ai_spawned) {
      ai function_ad2155838fbe0770();
    }
  }

  if(isDefined(level.var_1889c13ed500fb94)) {
    foreach(ai in level.var_1889c13ed500fb94.ai_spawned) {
      ai function_ad2155838fbe0770();
    }
  }

  if(isDefined(level.var_e75ec81ddc33b487)) {
    foreach(ai in level.var_e75ec81ddc33b487.ai_spawned) {
      ai function_ad2155838fbe0770();
    }
  }

  if(isDefined(level.var_7e6084e2cf3785ec)) {
    foreach(ai in level.var_7e6084e2cf3785ec.ai_spawned) {
      ai function_ad2155838fbe0770();
    }
  }

  if(isDefined(level.var_c80f4e7f11744c54)) {
    foreach(ai in level.var_c80f4e7f11744c54.ai_spawned) {
      ai function_ad2155838fbe0770();
    }
  }
}

function function_ad2155838fbe0770() {
  ai = self;

  if(ai function_28f3273faec1d365()) {
    ai function_db0ff244a1eda638();
    return;
  }

  ai scripts\cp_mp\agents\agent_utils::despawnagent();
}

function function_28f3273faec1d365() {
  if(isDefined(level.var_d2acca7804d67c9d)) {
    if(self istouching(level.var_d2acca7804d67c9d)) {
      return true;
    }
  }

  if(isDefined(level.var_ee9666af5c4768d0)) {
    if(self istouching(level.var_ee9666af5c4768d0)) {
      return true;
    }
  }

  foreach(vol in level.var_15212e09697ad715) {
    if(self istouching(vol)) {
      return true;
    }
  }

  return false;
}

function function_247cc3032d77371e() {
  level endon("reactor_combat_start");

  while(!isDefined(level.var_44a2219576a45ab2) || level.var_44a2219576a45ab2.size < 2) {
    waitframe();
  }

  ais = level.var_44a2219576a45ab2;
  level.var_1f194d0a260f5a4a = random(ais);
  ais = array_remove(ais, level.var_1f194d0a260f5a4a);
  level.var_1f194c0a260f5817 = random(ais);
  function_bb5cab9eba6beb39();
  flag_set("vo_reactor_platform_ais_banter");
}

function function_13140103aec7e2b7() {
  level endon("flag_drop_chemical");
  level flag_wait("reactor_combat_start");
  var_fb3487aa9ee374c6 = level.var_44a2219576a45ab2.size;
  level flag_wait("vo_reactor_player_spotted_completed");

  while(level.var_44a2219576a45ab2.size > var_fb3487aa9ee374c6 * 0.6) {
    wait randomfloatrange(1, 3);
    level.var_44a2219576a45ab2 = array_removedead_or_dying(level.var_44a2219576a45ab2);
  }

  level.var_1f194d0a260f5a4a = random(level.var_44a2219576a45ab2);
  level flag_set("vo_reactor_platform_ais_combat_banter_1");

  while(level.var_44a2219576a45ab2.size > var_fb3487aa9ee374c6 * 0.3) {
    wait randomfloatrange(1, 3);
    level.var_44a2219576a45ab2 = array_removedead_or_dying(level.var_44a2219576a45ab2);
  }

  level.var_1f194c0a260f5817 = random(level.var_44a2219576a45ab2);
  level flag_set("vo_reactor_platform_ais_combat_banter_2");
}

function function_c303cbc3e7b9687b() {
  level notify("level_setStealthSettings");
  level endon("level_setStealthSettings");

  while(!isDefined(level.stealth)) {
    waitframe();
  }

  hiddenranges["prone"] = 3000;
  hiddenranges["crouch"] = 3000;
  hiddenranges["stand"] = 3000;
  spottedranges["prone"] = 3000;
  spottedranges["crouch"] = 3000;
  spottedranges["stand"] = 3000;
  var_8f3f480583606401["prone"] = 1;
  var_8f3f480583606401["crouch"] = 1;
  var_8f3f480583606401["stand"] = 1;
  scripts\stealth\utility::set_detect_ranges(hiddenranges, spottedranges, var_8f3f480583606401);
  level.stealth.override_damage_auto_range = 3000;
  level.stealth.override_damage_sight_range = 3000;
}

function function_5d5bae8387ba9e56() {
  level thread function_8c0818478ddceec7();

  while(!function_489a0835e10a9b55(level.var_d03989799d2951ee)) {
    waitframe();
  }

  level flag_set("reactor_combat_start");
  level.var_5706ce58a3348a2c = level.player function_d0b6fd4fc2332c8c(undefined, 3);

  while(!isDefined(level.var_5706ce58a3348a2c)) {
    waitframe();
    level.var_5706ce58a3348a2c = level.player function_d0b6fd4fc2332c8c(undefined, 3);
  }

  level flag_set("vo_reactor_player_spotted");
}

function function_8c0818478ddceec7() {
  level endon("game_ended");
  level endon("reactor_combat_start");

  while(!isDefined(level.var_d03989799d2951ee)) {
    waitframe();
  }

  wait 1;

  while(level.var_d03989799d2951ee.size > 0) {
    level.var_d03989799d2951ee = function_fdc9d5557c53078e(level.var_d03989799d2951ee);
    waitframe();
  }

  level flag_set("reactor_combat_start");
}

function function_de6d6ba6e8b5142e(time, waitflag) {
  level endon("reactor_combat_start");

  if(isDefined(waitflag)) {
    level flag_wait(waitflag);
  }

  wait time;

  if(!function_155f16ed1b7f00cd(level.var_d03989799d2951ee)) {
    var_4807087bdfe65937 = function_fdc9d5557c53078e(level.var_44a2219576a45ab2);
    level.var_5706ce58a3348a2c = random(var_4807087bdfe65937);

    if(isDefined(level.var_5706ce58a3348a2c) && isalive(level.var_5706ce58a3348a2c)) {
      level flag_set("vo_reactor_player_spotted");
    }

    var_4807087bdfe65937 = function_fdc9d5557c53078e(var_4807087bdfe65937);
    var_eddc124f4cee6040 = random(var_4807087bdfe65937);
    var_4807087bdfe65937 = array_remove(var_4807087bdfe65937, var_eddc124f4cee6040);

    if(isDefined(var_eddc124f4cee6040) && isalive(var_eddc124f4cee6040)) {
      var_eddc124f4cee6040 thread function_860cd414d98539d(1);
    }

    wait randomfloatrange(0.5, 3);
    var_4807087bdfe65937 = function_fdc9d5557c53078e(var_4807087bdfe65937);
    var_eddc154f4cee66d9 = random(var_4807087bdfe65937);

    if(isDefined(var_eddc154f4cee66d9) && isalive(var_eddc154f4cee66d9)) {
      var_eddc154f4cee66d9 thread function_860cd414d98539d(1);
    }
  }
}

function function_127a430bc9e682ef() {
  function_786c10d84c135d5c("chem_reactor");
  function_16ba526dcba21bf6("chem_reactor", 0);
  function_3cc5be4ff7840b12("chem_reactor", 0);
  function_ea38ae8e854c5a02("choreo_reactor_floor1_pit");
  function_ea38ae8e854c5a02("choreo_reactor_floor2_maincover");
  function_ea38ae8e854c5a02("choreo_reactor_floor2");
  function_ea38ae8e854c5a02("choreo_reactor_floor3_maincover");
  stagename = "before_chemicals";
  stage = function_33a0071b309ada3a();
  stage.stagename = stagename;
  stage.priority = 5;
  stage.var_d86443bb4dc09f55 = 2;
  stage.maxai = 2;
  function_522de4e0b6e1fe88("choreo_reactor_floor1_pit", stage);
  stage = function_33a0071b309ada3a();
  stage.stagename = stagename;
  stage.priority = 3;
  stage.var_d86443bb4dc09f55 = 2;
  stage.maxai = 2;
  function_522de4e0b6e1fe88("choreo_reactor_floor2_maincover", stage);
  stage = function_33a0071b309ada3a();
  stage.stagename = stagename;
  stage.priority = 3;
  stage.var_d86443bb4dc09f55 = 2;
  stage.maxai = 2;
  function_522de4e0b6e1fe88("choreo_reactor_floor3_maincover", stage);
  stagename = "chemicals_floor1";
  stage = function_33a0071b309ada3a();
  stage.stagename = stagename;
  stage.priority = 5;
  stage.var_d86443bb4dc09f55 = 6;
  stage.maxai = 4;
  function_522de4e0b6e1fe88("choreo_reactor_floor2", stage);
  stage = function_33a0071b309ada3a();
  stage.stagename = stagename;
  stage.priority = 5;
  stage.var_d86443bb4dc09f55 = 2;
  stage.maxai = 4;
  function_522de4e0b6e1fe88("choreo_reactor_floor3_maincover", stage);
}

function function_ea38ae8e854c5a02(targetname) {
  vol = function_1c4d592029f2b0d3(targetname);
  function_34181ec2298dac40("chem_reactor", vol, targetname, 5);
}

function function_1e8f73f9f6783af1() {
  level flag_wait("reactor_combat_start");

  iprintlnbold("<dev string:x15a>");

  function_1cdf8543ead5f85("chem_reactor", "before_chemicals");
  level flag_wait("flag_gas_effects_started");

  iprintlnbold("<dev string:x172>");

  function_1cdf8543ead5f85("chem_reactor", "chemicals_floor1");
}

function function_8547bbffc8f0863b() {
  iprintlnbold("<dev string:x184>");

  level flag_set("flag_reactor_combat_flow_areas_1b");

  if(isDefined(level.var_d03989799d2951ee)) {
    level.var_d03989799d2951ee = function_fdc9d5557c53078e(level.var_d03989799d2951ee);

    foreach(ai in level.var_d03989799d2951ee) {
      if(ai function_68f8b8bd65b54d3("meltyface")) {
        ai thread function_7bbaabe18a021f24("reactor_cover_meltyface");
        continue;
      }

      if(ai function_68f8b8bd65b54d3("closest_airlock")) {
        ai thread function_7d4c026c62bd813d();
        continue;
      }

      if(ai function_68f8b8bd65b54d3("floor1_pit")) {
        ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor1_pit"));
        continue;
      }

      if(ai function_68f8b8bd65b54d3("floor1_pit_center")) {
        ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor1_pit_center"));
        continue;
      }

      if(ai function_68f8b8bd65b54d3("floor1_pit_under")) {
        ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor1_pit_under"));
        continue;
      }

      if(ai function_68f8b8bd65b54d3("floor1_pit_back")) {
        ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor1_pit_back"));
        continue;
      }

      if(ai function_68f8b8bd65b54d3("floor1_pit_closet")) {
        ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor1_pit_closet"));
        continue;
      }

      if(ai function_68f8b8bd65b54d3("floor2_maincover")) {
        ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor2_cornercover"));
        continue;
      }

      if(ai function_68f8b8bd65b54d3("floor2_turbinecover")) {
        ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor2_turbinecover"));
        continue;
      }

      if(ai function_68f8b8bd65b54d3("floor3_cornercover")) {
        ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor3_cornercover"));
        continue;
      }

      if(ai function_68f8b8bd65b54d3("floor3_maincover")) {
        ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor3_cornercover"));
      }
    }
  }

  level thread function_9dae6ff1f085b457();
  level thread function_3355109d82062520();
  level thread function_5669ff2eb6f5194e();
  level flag_wait("flag_drop_chemical");
  wait 18;
  level flag_set("flag_reactor_combat_flow_areas_pit");

  if(isDefined(level.var_d03989799d2951ee)) {
    level.var_d03989799d2951ee = function_fdc9d5557c53078e(level.var_d03989799d2951ee);

    foreach(ai in level.var_d03989799d2951ee) {
      function_5e1527c35161a24d(ai);
    }
  }

  waitframe();
  level thread function_54ab2435dbea46cb();
  level flag_wait("flag_drop_chemical_vial_hit_ground");
  level flag_set("flag_pit_canisterdefuse_preposition_stop");
  var_8ea713a6ba6424ac = function_cbc8904a4e5d665a();

  if(var_8ea713a6ba6424ac.size > 0) {
    var_4e63b5025759945d = function_7a18da6e48b71c35("reactor_expl_canister_interact");
    var_d98618c6a12d6c22 = function_1c4d592029f2b0d3("reactor_expl_canister_interact_preferredvol");
    var_2be39893ad20be5e = [];

    foreach(ai in var_8ea713a6ba6424ac) {
      if(ai istouching(var_d98618c6a12d6c22)) {
        var_2be39893ad20be5e = array_add(var_2be39893ad20be5e, ai);
      }
    }

    var_8a82918039ae89fb = undefined;

    if(var_2be39893ad20be5e.size > 0) {
      var_8a82918039ae89fb = get_array_of_closest(var_4e63b5025759945d.origin, var_2be39893ad20be5e)[0];
    } else {
      var_8a82918039ae89fb = get_array_of_closest(var_4e63b5025759945d.origin, var_8ea713a6ba6424ac)[0];
    }

    var_8a82918039ae89fb.ignoreall = 1;
    level.var_8a82918039ae89fb = var_8a82918039ae89fb;
    function_a87a516257b67c72(var_4e63b5025759945d, var_8a82918039ae89fb);
  }

  level flag_wait("flag_gas_effects_started");
  level flag_set("flag_reactor_combat_flow_areas_3");

  if(isDefined(level.var_d03989799d2951ee)) {
    level.var_d03989799d2951ee = function_fdc9d5557c53078e(level.var_d03989799d2951ee);

    foreach(ai in level.var_d03989799d2951ee) {
      function_771d4442b39572ab(ai);
    }
  }

  level thread function_e69496c4ee7ff22b(8);
  level thread function_3c814575759f2c48(40);
  var_63bfb35ad2598d28 = getdvarfloat(@ "hash_56334e1c044ffd65", 11);
  level thread function_972b9649d28a5f7a(var_63bfb35ad2598d28);
  var_482a59cb61ce9371 = getdvarfloat(@ "hash_3e032372278652b", 40);
  level thread spawn_ais_reactor_platform1_wave2(var_482a59cb61ce9371);
  var_65718f62a29c2744 = getdvarfloat(@ "hash_53c3f63b378fb05c", 60);
  level thread spawn_ais_reactor_platform2_wave1(var_65718f62a29c2744);
}

function function_9dae6ff1f085b457() {
  level endon("game_ended");
  level endon("flag_reactor_combat_flow_areas_3");
  level flag_wait("reactor_combat_start");
  level flag_set("flag_reactor_combat_flow_areas_2");

  if(isDefined(level.var_d03989799d2951ee)) {
    level.var_d03989799d2951ee = function_fdc9d5557c53078e(level.var_d03989799d2951ee);

    foreach(ai in level.var_d03989799d2951ee) {
      function_771d4342b3957078(ai);
    }
  }
}

function function_3355109d82062520() {
  level endon("game_ended");
  level endon("flag_drop_chemical_vial_hit_ground");
  level flag_wait("reactor_combat_start");
  waitframe();
  waitframe();
  var_677e9afa161f9ab = 0;

  while(true) {
    level.var_44a2219576a45ab2 = function_fdc9d5557c53078e(level.var_44a2219576a45ab2);

    if(var_677e9afa161f9ab != level.var_44a2219576a45ab2.size) {
      var_677e9afa161f9ab = level.var_44a2219576a45ab2.size;
      var_c1314d1adcdc2508 = undefined;

      if(var_677e9afa161f9ab == 3) {
        var_ec3e0727cd796c60 = undefined;

        foreach(ai in level.var_44a2219576a45ab2) {
          if(ai function_68f8b8bd65b54d3("tier3")) {
            var_ec3e0727cd796c60 = ai;
            break;
          }
        }

        var_ec3e0727cd796c60.dontevershoot = 0;
        var_c1314d1adcdc2508 = array_remove(level.var_44a2219576a45ab2, var_ec3e0727cd796c60);
        var_c1314d1adcdc2508 = sortbydistance(var_c1314d1adcdc2508, level.player.origin);
      } else {
        var_c1314d1adcdc2508 = sortbydistance(level.var_44a2219576a45ab2, level.player.origin);
      }

      for(i = 0; i < var_c1314d1adcdc2508.size; i++) {
        if(i == 0) {
          var_c1314d1adcdc2508[i] notify("reactor_platform_ai_loop_gestures");
          var_c1314d1adcdc2508[i].dontevershoot = 0;
          var_c1314d1adcdc2508[i] thread function_e0c4ac89ea300c5f();
          continue;
        }

        var_c1314d1adcdc2508[i].dontevershoot = 1;

        if(!var_c1314d1adcdc2508[i] function_68f8b8bd65b54d3("tier3")) {
          var_c1314d1adcdc2508[i] thread reactor_platform_ai_loop_gestures();
        }
      }
    }

    waitframe();
  }
}

function reactor_platform_ai_loop_gestures() {
  level endon("game_ended");
  self endon("death");
  self notify("reactor_platform_ai_loop_gestures");
  self endon("reactor_platform_ai_loop_gestures");
  thread function_702b34a0a4f832e9();
  gestures = ["military_point", "advance", "getdown", "beckon", "stop"];

  while(true) {
    if(randomint(100) > 50) {
      scripts\asm\gesture::ai_request_gesture(random(gestures), level.player);
    } else {
      self forcereloading();
    }

    wait randomfloatrange(0.5, 1);
  }
}

function function_702b34a0a4f832e9() {
  level endon("game_ended");
  self endon("death");
  self endon("reactor_platform_ai_loop_gestures");
  self waittill("damage");
  self.ignoreall = 0;
  self notify("reactor_platform_ai_loop_gestures");
}

function function_5669ff2eb6f5194e() {
  level endon("game_ended");
  level endon("flag_gas_effects_started");
  level flag_wait("reactor_combat_start");

  while(true) {
    waitframe();

    if(function_cbc8904a4e5d665a().size < 3) {
      level flag_set("flag_reactor_combat_flow_areas_pit");
      level thread function_76bf10ddef9a355c();
      break;
    }
  }
}

function function_771d4342b3957078(ai) {
  if(ai function_ee0aa391d8fad9d5()) {
    return;
  }

  if(ai function_68f8b8bd65b54d3("meltyface")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor4"));
  } else if(ai function_68f8b8bd65b54d3("floor1_pit")) {
    if(!isDefined(level.var_c3f11a12e4b69605)) {
      level.var_c3f11a12e4b69605 = ai;
      ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor1_pit"));
    } else {
      ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor1_pit_under"));
    }
  } else if(ai function_68f8b8bd65b54d3("floor1_pit_closet")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor1_pit_closet"));
  } else if(ai function_68f8b8bd65b54d3("floor2_maincover")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor2_maincover"));
  } else if(ai function_68f8b8bd65b54d3("floor2_turbinecover")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor2_turbinecover"));
  } else if(ai function_68f8b8bd65b54d3("floor3_cornercover")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor3_cornercover"));
  } else if(ai function_68f8b8bd65b54d3("floor3_maincover")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor3_maincover"));
  }

  ai thread function_e0c4ac89ea300c5f();
}

function function_5e1527c35161a24d(ai) {
  if(ai function_ee0aa391d8fad9d5()) {
    return;
  }

  if(ai function_68f8b8bd65b54d3("meltyface")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor4"));
  } else if(ai function_68f8b8bd65b54d3("floor1_pit")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor1_pit"));
  } else if(ai function_68f8b8bd65b54d3("floor1_pit_closet")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor1_pit_center"));
  } else if(ai function_68f8b8bd65b54d3("floor2_maincover")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor2_maincover"));
  } else if(ai function_68f8b8bd65b54d3("floor2_turbinecover")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor2_turbinecover"));
  } else if(ai function_68f8b8bd65b54d3("floor3_cornercover")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor3_cornercover"));
  } else if(ai function_68f8b8bd65b54d3("floor3_maincover")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor3_maincover"));
  }

  ai thread function_e0c4ac89ea300c5f();
}

function function_54ab2435dbea46cb() {
  level endon("game_ended");
  level endon("flag_pit_canisterdefuse_preposition_stop");
  vol = function_1c4d592029f2b0d3("choreo_reactor_floor1_pit_canistercover");
  var_4890195d833cbc68 = [];

  while(true) {
    wait 1;

    if(var_4890195d833cbc68.size > 0) {
      continue;
    }

    var_bf5f8d63ed94667c = get_array_of_closest(vol.origin, function_cbc8904a4e5d665a());
    x = ter_op(var_bf5f8d63ed94667c.size >= 3, 3, var_bf5f8d63ed94667c.size);

    for(i = 0; i < x; i++) {
      var_bf5f8d63ed94667c[0] thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor1_pit_canistercover"));
    }
  }
}

function function_771d4442b39572ab(ai) {
  if(ai function_ee0aa391d8fad9d5()) {
    return;
  }

  if(ai function_68f8b8bd65b54d3("meltyface")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor4"));
  } else if(ai function_68f8b8bd65b54d3("floor1_pit")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor2"));
  } else if(ai function_68f8b8bd65b54d3("floor1_pit_closet")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor2"));
  } else if(ai function_68f8b8bd65b54d3("floor2_maincover")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor2_maincover"));
  } else if(ai function_68f8b8bd65b54d3("floor2_turbinecover")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor2_maincover"));
  } else if(ai function_68f8b8bd65b54d3("floor3_cornercover")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor3_maincover"));
  } else if(ai function_68f8b8bd65b54d3("floor3_maincover")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor3_maincover"));
  }

  ai thread function_e0c4ac89ea300c5f();
}

function function_771d4942b3957daa(ai) {
  if(ai function_ee0aa391d8fad9d5()) {
    return;
  }

  if(ai function_68f8b8bd65b54d3("closest_airlock")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor3"));
  } else if(ai function_68f8b8bd65b54d3("meltyface")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor4"));
  } else if(ai function_68f8b8bd65b54d3("floor3_wave1")) {
    if(ai function_68f8b8bd65b54d3("closet_rear")) {
      ai thread function_c8843b488206211f(function_1c4d592029f2b0d3("choreo_reactor_floor3_maincover"));
    } else {
      ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor3_maincover"));
    }
  } else if(ai function_68f8b8bd65b54d3("floor3_wave2")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor3_cornercover"));
  } else if(ai function_68f8b8bd65b54d3("floor1_pit")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor3"));
  } else if(ai function_68f8b8bd65b54d3("floor2_maincover")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor3"));
  } else if(ai function_68f8b8bd65b54d3("floor2_turbinecover")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor3"));
  } else if(ai function_68f8b8bd65b54d3("floor3_cornercover")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor3_maincover"));
  } else if(ai function_68f8b8bd65b54d3("floor3_maincover")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor3_maincover"));
  }

  ai thread function_e0c4ac89ea300c5f();
}

function function_c8843b488206211f(var_f036595b09cdf96) {
  self endon("death");
  self endon("flag_reactor_combat_flow_areas_5");
  nodes = getnodearray("node_reactor_spawncloset", "targetname");

  if(nodes.size > 0) {
    nodes = get_array_of_closest(self.origin, nodes);
    closest_node = nodes[0];
    self cleargoalvolume();
    self clearentitytarget();
    self setgoalnode(closest_node);
    self aieventlistenerevent("combat", level.player, level.player.origin);
    var_6a9499141b721cb5 = getStructArray("lookat_spawncloset", "targetname");
    var_6a9499141b721cb5 = get_array_of_closest(self.origin, var_6a9499141b721cb5);
    var_6a9499141b721cb5 = array_remove(var_6a9499141b721cb5, var_6a9499141b721cb5[1]);
    var_6a9499141b721cb5 = array_add(var_6a9499141b721cb5, self);
    var_ad04c6fba04ac9b3 = function_1418dfaca3b1702a() * 0.666667;

    for(var_49b0b16c25cd4a95 = undefined; !isDefined(var_49b0b16c25cd4a95); var_49b0b16c25cd4a95 = function_61aef23379ae7542(var_6a9499141b721cb5, var_ad04c6fba04ac9b3, 0, 1200, (0, 0, 30))) {
      waitframe();
    }

    thread function_7d160926856917b1(var_f036595b09cdf96);
    return;
  }

  thread function_7d160926856917b1(var_f036595b09cdf96);
}

function function_e69496c4ee7ff22b(delaytime) {
  level endon("game_ended");
  wait delaytime;
  level flag_set("flag_reactor_combat_flow_areas_4");
  level.var_d03989799d2951ee = function_fdc9d5557c53078e(level.var_d03989799d2951ee);

  foreach(ai in level.var_d03989799d2951ee) {
    function_771d4942b3957daa(ai);
  }
}

function function_771d4a42b3957fdd(ai) {
  if(ai function_ee0aa391d8fad9d5()) {
    return;
  }

  if(ai function_68f8b8bd65b54d3("closest_airlock")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor4"));
  } else if(ai function_68f8b8bd65b54d3("meltyface")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor4"));
  } else if(ai function_68f8b8bd65b54d3("floor3_wave1")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor4"));
  } else if(ai function_68f8b8bd65b54d3("floor3_wave2")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor4"));
  } else if(ai function_68f8b8bd65b54d3("floor1_pit")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor4"));
  } else if(ai function_68f8b8bd65b54d3("floor2_maincover")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor4"));
  } else if(ai function_68f8b8bd65b54d3("floor2_turbinecover")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor4"));
  } else if(ai function_68f8b8bd65b54d3("floor3_cornercover")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor4"));
  } else if(ai function_68f8b8bd65b54d3("floor3_maincover")) {
    ai thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor4"));
  }

  ai thread function_e0c4ac89ea300c5f();
}

function function_3c814575759f2c48(delaytime) {
  level endon("game_ended");
  wait delaytime;
  level flag_set("flag_reactor_combat_flow_areas_5");
  level.var_d03989799d2951ee = function_fdc9d5557c53078e(level.var_d03989799d2951ee);

  foreach(ai in level.var_d03989799d2951ee) {
    function_771d4a42b3957fdd(ai);
  }
}

function function_7d160926856917b1(area) {
  self cleargoalvolume();
  self clearentitytarget();
  self setgoalvolumeauto(area);
  self aieventlistenerevent("combat", level.player, level.player.origin);
}

function function_7bbaabe18a021f24(node_targetname) {
  self cleargoalvolume();
  self clearentitytarget();
  self setgoalnode(function_ef5226389e773adc(node_targetname));
  self aieventlistenerevent("combat", level.player, level.player.origin);
}

function function_6f2f6aa271b4ba70(node_targetname) {
  self.origin = function_ef5226389e773adc(node_targetname).origin;
  function_7bbaabe18a021f24(node_targetname);
}

function reactor_ai_meltyface(node_targetname) {
  level.var_c5c3d3f12df66056 = self;
  scripts\cp\spawning::set_character_models("body_c_jup_sp_enemy_pmc_soldier_03", "head_c_jup_sp_enemy_pmc_soldier_03");
  self cleargoalvolume();
  self clearentitytarget();
  self setgoalnode(function_ef5226389e773adc(node_targetname));
}

function function_9f1adef75e92c9ec() {
  loc = undefined;
  interaction = undefined;

  if(level.player istouching(function_1c4d592029f2b0d3("vol_airlock_hallway"))) {
    var_5bc24e2864ec6277 = function_7a18da6e48b71c35("closest_to_hall");
    interaction = function_7a18da6e48b71c35("reactor_interaction_hall");
    level.var_24f261bb8588fa10 = "closest_to_hall";
  } else if(level.player istouching(function_1c4d592029f2b0d3("vol_airlock_turbine"))) {
    var_5bc24e2864ec6277 = function_7a18da6e48b71c35("closest_to_turbine");
    interaction = function_7a18da6e48b71c35("reactor_interaction_turbine");
    level.var_24f261bb8588fa10 = "closest_to_turbine";
  } else {
    var_5bc24e2864ec6277 = function_7a18da6e48b71c35("closest_to_rear");
    interaction = function_7a18da6e48b71c35("reactor_interaction_rear");
    level.var_24f261bb8588fa10 = "closest_to_rear";
  }

  self.origin = var_5bc24e2864ec6277.origin;
  self.angles = var_5bc24e2864ec6277.angles;
  self cleargoalvolume();
  self clearentitytarget();
  wait 5;
  interactionid = spawninteraction(interaction.interaction, interaction.origin, interaction.angles);
  self function_76b3cfb91ef40b3b(interactionid);
  self waittill("bseq_user_deleted");
  despawninteraction(interactionid);
}

function function_7d4c026c62bd813d() {
  if(level.player istouching(function_1c4d592029f2b0d3("vol_airlock_hallway"))) {
    thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor2_sidecover"));
    return;
  }

  if(level.player istouching(function_1c4d592029f2b0d3("vol_airlock_turbine"))) {
    thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor2_turbinecover"));
    return;
  }

  thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_floor2_rearairlockcover"));
}

function function_4a3a237962834aa0() {
  self.var_f5facf26f3f4f9d1 = 1;
}

function function_6352159e541b9eb1() {
  if(istrue(self.in_gas)) {
    function_d62d7d5cce8eb66c();
    return;
  }

  self.var_c833409fb72d15fb = 0;
  self.allowstrafe = 1;
  self.ignoreall = 0;
  self.fixednode = 0;
  self.goalradius = 250;
  self.var_f5facf26f3f4f9d1 = 0;
  waitframe();
  function_771d4942b3957daa(self);
  self aieventlistenerevent("combat", level.player, level.player.origin);
}

function function_ee0aa391d8fad9d5() {
  return istrue(self.var_f5facf26f3f4f9d1);
}

function function_e183d373f385fbe(ai_array) {
  newarray = [];

  foreach(ai in ai_array) {
    if(!ai function_ee0aa391d8fad9d5()) {
      newarray = array_add(newarray, ai);
    }
  }

  return newarray;
}

function function_f72de2b4a3d97f5f() {
  anim_org = function_7a18da6e48b71c35("anim_exit_exfil_org");
  level.var_b6dc558c136879dc function_702ec76ba0d8ebad();
  level.var_b6dc558c136879dc assign_animtree("pallet_pallet");
  level.var_9e42b50ac8eec4 = spawn_anim_model("pallet_helicopter");
  level thread function_574da8d37a0156c0();
  level.canister = spawn_anim_model("pallet_canister");
  level.var_acbd040dd890d0d2 = spawn_anim_model("pallet_canister_2");
  actors = [level.var_acbd040dd890d0d2, level.canister, level.var_9e42b50ac8eec4, level.var_b6dc558c136879dc];
  anim_org anim_first_frame(actors, "pallet_loop");
  waitframe();
  level flag_set("flag_pallet_first_frame_set");
  wait 1;
  anim_org thread anim_loop(actors, "pallet_loop");
  level flag_wait("flag_drop_chemical");
  thread namespace_11fae4a66a43bd3f::function_bf33082ba673d7();
  anim_org anim_single(actors, "pallet_out");
  level flag_set("flag_pallet_anim_ended");
  level.var_9e42b50ac8eec4 function_c2a4331f598ca13e();
  level.var_b6dc558c136879dc function_c2a4331f598ca13e();
}

function function_574da8d37a0156c0() {
  level endon("flag_pallet_anim_ended");
  level.var_211342392eb633b9 = undefined;
  var_31a753fc0246fdb5 = undefined;

  while(isDefined(level.var_9e42b50ac8eec4)) {
    var_31a753fc0246fdb5 = function_61aef23379ae7542(level.var_9e42b50ac8eec4, undefined, undefined, 3000);

    if(isDefined(var_31a753fc0246fdb5)) {
      if(!isDefined(level.var_211342392eb633b9)) {
        level.var_211342392eb633b9 = missile_createrepulsorent(level.var_9e42b50ac8eec4, 100000, 20000, level.player);
      }
    } else if(isDefined(level.var_211342392eb633b9)) {
      missile_deleteattractor(level.var_211342392eb633b9);
      level.var_211342392eb633b9 = undefined;
    }

    waitframe();
  }
}

function function_758a0054dcf55fa5() {
  level.moving_platform = function_1c4d592029f2b0d3("movingplatform_ai_clip");
  level.var_b6dc558c136879dc = function_1c4d592029f2b0d3("reactor_pallet");
  level.moving_platform linkTo(level.var_b6dc558c136879dc);
  var_513ff17def70bf93 = getStructArray("movingplatform_teleport", "targetname");
  level.var_c2cc8fd9e98e11b4 = [];

  foreach(struct in var_513ff17def70bf93) {
    struct function_916233af1855619c();
    i = undefined;

    if(struct function_68f8b8bd65b54d3("slot1")) {
      i = 1;
    } else if(struct function_68f8b8bd65b54d3("slot2")) {
      i = 2;
    } else if(struct function_68f8b8bd65b54d3("slot3")) {
      i = 3;
    } else {
      assertmsg("Pallet struct does not have a script_parameters kvp to denote its position on the pallet.");
    }

    org = spawn_script_origin();
    org.origin = level.var_b6dc558c136879dc gettagorigin("tag_origin_animate");
    org.angles = level.var_b6dc558c136879dc gettagangles("tag_origin_animate");
    org linkTo(level.var_b6dc558c136879dc, "tag_origin_animate");
    level.var_c2cc8fd9e98e11b4[i] = org;
  }

  level.var_9fa977fba90829c8 = function_1c4d592029f2b0d3("movingplatform_player_clip");
  level.var_9fa977fba90829c8 linkTo(level.moving_platform);
  level.var_99664f35c452ec45 = function_1c4d592029f2b0d3("pallet_obj_marker");
  level.var_99664f35c452ec45 linkTo(level.moving_platform);
  level.var_7abfb7cda643323a = function_1c4d592029f2b0d3("movingplatform_weaponitem_clip");

  if(isDefined(level.var_7abfb7cda643323a)) {
    level.var_7abfb7cda643323a linkTo(level.moving_platform);
  }

  level.var_b6dc558c136879dc function_c2a4331f598ca13e();
  level flag_set("flag_reactor_pallet_initialized");
}

function function_7ae489caad82fdc3() {
  level endon("game_ended");
  level.player endon("death");

  while(!isDefined(level.var_2745498dd7dc0a6d) || level.var_2745498dd7dc0a6d != "reactorroom") {
    waitframe();
  }

  level flag_wait("reactor_combat_start");

  for(var_f1bbc0452b3583e9 = gettime() + 2000; gettime() <= var_f1bbc0452b3583e9; var_f1bbc0452b3583e9 = gettime() + 2000) {
    waitframe();

    if(level.player function_28f3273faec1d365()) {}
  }

  function_b0010ece31b338c4();
}

function function_1215a79c157ac593(door) {
  grenades = getentarrayinradius("grenade", "classname", door.var_31afb84e52e0115f.origin, 100);

  if(isDefined(grenades)) {
    foreach(grenade in grenades) {
      grenade unlink();
      grenade movegravity((0, 0, 0), 1);
    }
  }

  door.isclosed = 0;
  var_ab0bfd12ca02a052 = function_756494cee52d1c17(door.var_a01a4daf5b378e5e.origin, door.var_8acbacf8c2d5ef7c, 0.03);
  var_3b698aec6d614cd = function_756494cee52d1c17(door.var_2ca5f44d93905c17.origin, door.var_52ca60b6d350ae3, 0.03);
  door.var_a01a4daf5b378e5e moveTo(var_ab0bfd12ca02a052, 0.4, 0, 0.4);
  door.var_2ca5f44d93905c17 moveTo(var_3b698aec6d614cd, 0.4, 0, 0.4);
  wait 0.4;
  wait 0.2;
  door.clip_brush function_c2a4331f598ca13e(1);
  door.var_a01a4daf5b378e5e moveTo(door.var_8acbacf8c2d5ef7c, 1.5, 1.5, 0);
  door.var_2ca5f44d93905c17 moveTo(door.var_52ca60b6d350ae3, 1.5, 1.5, 0);
}

function function_756494cee52d1c17(start, end, var_20836ea281b1a927) {
  x = (end[0] - start[0]) * var_20836ea281b1a927 + start[0];
  y = (end[1] - start[1]) * var_20836ea281b1a927 + start[1];
  z = (end[2] - start[2]) * var_20836ea281b1a927 + start[2];
  return (x, y, z);
}

function function_763a6654bc3034d5(door) {
  door.isclosed = 1;
  door.clip_brush function_702ec76ba0d8ebad(1);
  door.var_a01a4daf5b378e5e moveTo(door.var_a6bec06093c00cc6, 1.5);
  door.var_2ca5f44d93905c17 moveTo(door.var_19c789821e08adaf, 1.5);
}

function function_2bd92c578addc9a8(door, timedelay) {
  door.isclosed = 1;
  door.clip_brush function_702ec76ba0d8ebad(1);
  wait timedelay;
  door.var_a01a4daf5b378e5e moveTo(door.var_a6bec06093c00cc6, 1.5);
  door.var_2ca5f44d93905c17 moveTo(door.var_19c789821e08adaf, 1.5);
}

function function_4e530f6f95f2c50(interact_name) {
  var_1ff5d2ac0e927779 = 100;
  instance = getStruct(interact_name, "targetname");
  door_structs = getStructArray(instance.target, "targetname");

  foreach(door_struct in door_structs) {
    door = function_534c70acf71711d4(door_struct);
    function_621d802587a04649(door);

    if(is_equal(door_struct.script_noteworthy, "outer_door")) {
      thread namespace_11fae4a66a43bd3f::function_6f17d48ccb71478b(door);
      thread function_1215a79c157ac593(door);
      instance.outer_door = door;
      continue;
    }

    if(is_equal(door_struct.script_noteworthy, "outer_door_2")) {
      thread namespace_11fae4a66a43bd3f::function_6f17d48ccb71478b(door);
      thread function_1215a79c157ac593(door);
      instance.outer_door_2 = door;
      continue;
    }

    if(is_equal(door_struct.script_noteworthy, "inner_door")) {
      instance.inner_door = door;
    }
  }

  var_a8a6492cc9a3c322 = ter_op(function_9ec2f480552af944(level.player), "duration_short", "duration_none");
  instance.interact = instance create_interact(undefined, undefined, undefined, 600, &"CP_JUP_CHEMICAL/REACTOR_DOOR_INTERACT", undefined, "hide");
  instance.interact setuseholdduration(var_a8a6492cc9a3c322);
  instance.interact setusepriority(0);
  instance thread reactor_door_interact_cleanup();
  instance thread function_71b54450baedefde();
  instance thread function_d1aec69e5af5597a();
  return instance;
}

function function_621d802587a04649(door) {
  move_structs = getStructArray(door.target, "targetname");

  foreach(struct in move_structs) {
    switch (struct.script_noteworthy) {
      case #"hash_eb261080f9c9a2f0":
        door.var_8acbacf8c2d5ef7c = struct.origin;
        break;
      case #"hash_6db7e3af945149dc":
        door.var_a6bec06093c00cc6 = struct.origin;
        break;
      case #"hash_69f9513c9db82c9":
        door.var_52ca60b6d350ae3 = struct.origin;
        break;
      case #"hash_ee300315b02a5523":
        door.var_19c789821e08adaf = struct.origin;
        break;
    }
  }

  ents = getEntArray(door.target, "targetname");

  foreach(ent in ents) {
    switch (ent.script_noteworthy) {
      case #"hash_d8e552ae4a7f8c60":
        door.var_2ca5f44d93905c17 = spawn("script_origin", door.var_19c789821e08adaf);
        door.var_31afb84e52e0115f = ent;
        ent linkTo(door.var_2ca5f44d93905c17);
        break;
      case #"hash_af8e5bcc6816aa6f":
        door.var_a01a4daf5b378e5e = spawn("script_origin", door.var_a6bec06093c00cc6);
        door.var_9c0779ae9cf811ee = ent;
        ent linkTo(door.var_a01a4daf5b378e5e);
        break;
      case #"hash_584ae7cabd7c9f4":
        door.clip_brush = ent;
        break;
    }
  }
}

function function_534c70acf71711d4(door_struct) {
  var_a2e739041d16edb2 = getStructArray("reactor_door_sliding", "targetname");
  var_a2e739041d16edb2 = sortbydistance(var_a2e739041d16edb2, door_struct.origin);
  return var_a2e739041d16edb2[0];
}

function function_d1aec69e5af5597a() {
  self.interact endon("death");
  level endon("reactor_door_interact_cleanup");

  while(true) {
    self.interact waittill("trigger");
    thread namespace_11fae4a66a43bd3f::function_c4f66546640cf4d();
    thread function_b56ec41b686e740d();

    if(level.checkpoint == "obj_enterReactor_complete") {
      break;
    }

    if(ent_flag("flag_reactor_door_state_changing") || ent_flag("flag_reactor_door_disable_interact")) {
      iprintlnbold("<dev string:x198>");

      continue;
    }

    allvehicles = vehicle_getarray();

    if(isDefined(level.attack_heli)) {
      allvehicles = array_remove(allvehicles, level.attack_heli);
    }

    foreach(veh in allvehicles) {
      if(distance(self.interact.origin, veh.origin) < 1000) {
        allvehicles = array_remove(allvehicles, veh);
      }
    }

    array_delete(allvehicles);
    break;
  }

  level thread function_fdee089bd50ba7dd();
  flag_set("flag_reactor_airlock_passed");
  flag_set("lgt_airlocks_passed");
  thread function_29db140cfb94b24(1, 0, "vo_reactor_airlock_transition_complete");
  level flag_set("reactor_door_interact_cleanup");
}

function function_b56ec41b686e740d() {
  namespace_b96fa4d8ce10f926::function_ebd9a9c9789d200f();
}

function function_fdee089bd50ba7dd() {
  level endon("game_ended");
  thread namespace_11fae4a66a43bd3f::function_588af84fad23df23("cp_jup_chemical_sfx_reactor");

  if(level.checkpoint != "obj_enterReactor_complete") {
    level notify("reactor_door_entered");
    wait 1;
    scripts\cp\cp_checkpoint::checkpoint_set("obj_enterReactor_complete");
    scripts\cp\cp_checkpoint::function_5b0a03741aa420d7();
  }
}

function function_71b54450baedefde() {
  self.interact endon("death");
  level endon("reactor_door_interact_cleanup");

  if(level.checkpoint == "obj_enterReactor_complete") {
    self.interact function_dfb78b3e724ad620(1);
    return;
  }

  while(true) {
    ent_flag_wait_either("flag_reactor_door_disable_interact", "flag_reactor_door_state_changing");
    self.interact function_dfb78b3e724ad620(0);
    function_cba0984334ba3279(["flag_reactor_door_disable_interact", "flag_reactor_door_state_changing"]);
    self.interact function_dfb78b3e724ad620(1);
  }
}

function function_d4ef016d72a62dee(should_hide) {
  if(istrue(should_hide)) {
    ent_flag_set("flag_reactor_door_disable_interact");
    return;
  }

  ent_flag_clear("flag_reactor_door_disable_interact");
}

function function_f1f5881db82ff806() {
  var_4f23a300549b3151 = getEntArray("vol_vehicle_kill_airlock", "targetname");
  level flag_wait("reactor_door_interact_cleanup");
  array_thread(var_4f23a300549b3151, &function_4824d9b7637c68a0);
}

function function_d631440a2e798daf() {
  var_4f23a300549b3151 = getEntArray("vol_vehicle_kill_airlock_inner", "targetname");
  level flag_wait("reactor_doors_force_closed");
  array_thread(var_4f23a300549b3151, &function_4824d9b7637c68a0);
}

function function_4824d9b7637c68a0() {
  level.player endon("death");
  level endon("game_over");
  wait 0.6;
  vehicle_list = vehicle_getarray();

  foreach(veh in vehicle_list) {
    if(veh istouching(self)) {
      veh.var_a8f4bb03b366aa80 = 1;
      veh scripts\cp_mp\vehicles\vehicle::function_e3ff0a92ad2bf58d(undefined, 1);
    }
  }
}

function reactor_door_interact_cleanup() {
  level endon("game_over");
  level flag_wait("reactor_door_interact_cleanup");
  self.interact function_dfb78b3e724ad620(0);
  self.interact delete();
}

function function_29db140cfb94b24(var_dcd1587196556605, var_9cbbdbd1bd1e837a, open_flag) {
  ent_flag_set("flag_reactor_door_state_changing");

  if(isDefined(self.inner_door.isclosed) && !istrue(self.inner_door.isclosed)) {
    thread namespace_11fae4a66a43bd3f::function_d4292a6af1824122(self.inner_door);
  }

  if(istrue(var_dcd1587196556605)) {
    if(!istrue(self.outer_door.isclosed)) {
      thread namespace_11fae4a66a43bd3f::function_790b84b56975bf8d(self.outer_door);
      function_2bd92c578addc9a8(self.outer_door, 1);
    }

    if(isDefined(self.outer_door_2) && !istrue(self.outer_door_2.isclosed)) {
      thread namespace_11fae4a66a43bd3f::function_790b84b56975bf8d(self.outer_door_2);
      function_2bd92c578addc9a8(self.outer_door_2, 1);
    }

    if(isDefined(open_flag)) {
      level flag_wait(open_flag);
    } else {
      wait 3;
    }

    thread namespace_11fae4a66a43bd3f::function_42a485923e941c46(self.inner_door);
    function_1215a79c157ac593(self.inner_door);
  } else if(istrue(var_9cbbdbd1bd1e837a)) {
    if(!istrue(self.inner_door.isclosed)) {
      function_763a6654bc3034d5(self.inner_door);
    }

    wait 3;
    function_1215a79c157ac593(self.outer_door);

    if(isDefined(self.outer_door_2)) {
      function_1215a79c157ac593(self.outer_door_2);
    }
  } else if(!istrue(var_dcd1587196556605) && !istrue(var_9cbbdbd1bd1e837a)) {
    if(!istrue(self.inner_door.isclosed)) {
      function_763a6654bc3034d5(self.inner_door);
    }

    if(!istrue(self.outer_door.isclosed)) {
      function_763a6654bc3034d5(self.outer_door);
    }

    if(isDefined(self.outer_door_2) && !istrue(self.outer_door_2.isclosed)) {
      function_763a6654bc3034d5(self.outer_door_2);
    }
  }

  ent_flag_clear("flag_reactor_door_state_changing");
}

function function_b0010ece31b338c4() {
  level flag_set("reactor_doors_force_closed");
  level.var_571425accdf6489b thread function_29db140cfb94b24(0, 0);
  level.var_2de1558f693bcff4 thread function_29db140cfb94b24(0, 0);
  level.var_e77be246fdd8927a thread function_29db140cfb94b24(0, 0);
  waitframe();
  level.var_571425accdf6489b ent_flag_waitopen("flag_reactor_door_state_changing");
  level.var_2de1558f693bcff4 ent_flag_waitopen("flag_reactor_door_state_changing");
  level.var_e77be246fdd8927a ent_flag_waitopen("flag_reactor_door_state_changing");
  level flag_set("reactor_doors_force_closed_finished");
}

function function_a34e94c1f5c85930(flag_name) {
  level endon("game_over");
  level flag_wait(flag_name);
  thread namespace_11fae4a66a43bd3f::function_588af84fad23df23("cp_jup_chemical_sfx_reactor");
  level.var_571425accdf6489b function_d4ef016d72a62dee(0);
  level.var_2de1558f693bcff4 function_d4ef016d72a62dee(0);
  level.var_e77be246fdd8927a function_d4ef016d72a62dee(0);
}

function function_33c7466df3aa05eb(time) {
  level notify("end_platform_random_rotation");
  level endon("end_platform_random_rotation");

  while(true) {
    level.moving_platform rotateTo((0, randomfloatrange(-180, 180), 0), time, 1, 1);
    wait time;
  }
}

function function_20d20e667b1bc1ab() {
  level.moving_platform function_c2a4331f598ca13e();
  level.var_9fa977fba90829c8 function_c2a4331f598ca13e();

  if(isDefined(level.var_7abfb7cda643323a)) {
    level.var_7abfb7cda643323a function_c2a4331f598ca13e();
  }

  level.var_b6dc558c136879dc delete();
}

function function_831cf8aa07146901() {
  level endon("game_ended");
  level flag_wait("flag_drop_chemical");
  level thread flag_set_delayed("vo_stop_reactor_enter", 7.5);
  level flag_set("flag_drop_chemical_platform_upwards");
  level waittill("pallet_141spawn");
  level thread function_35aba5ff25ad92ba();
  level waittill("pallet_attack");
  level flag_set("flag_drop_chemical_ally_attacks");
  wait 3;
  level flag_set("flag_canister_fall_start");
  level waittill("pallet_land");
  level flag_set("flag_drop_chemical_vial_hit_ground");
  level thread flag_set_delayed("vo_reactor_konni_pit_combat_banter_1", 1.5);
  level thread flag_set_delayed("vo_reactor_konni_pit_combat_banter_2", 4);
  level thread function_d1f760259b33bc01();
  level thread function_2a835170b5980742();
  var_8ea713a6ba6424ac = function_cbc8904a4e5d665a();

  foreach(ai in var_8ea713a6ba6424ac) {
    ai thread function_fecabb2254ff24dc();
  }

  level thread flag_set_delayed("flag_pit_anim_preposition", 7);
  level.var_ec68a5df2b5089f9 = gettime() + 7000;
  level thread function_50e82847f9bc9ca8();
  level thread function_23ed4451cd6be483();
  level thread function_8836937ec5e4646d();
  level function_665d474ff040b446(["flag_canister_explosion_delay_completed", "flag_canister_explosion_ainum"]);
  level flag_set("flag_escape_start");
  level flag_set("vo_reactor_vial_on_ground_exploded");
  flag_set("lgt_gas_released");
}

function function_35aba5ff25ad92ba() {
  if(isDefined(level.var_d03989799d2951ee)) {
    level.var_d03989799d2951ee = function_fdc9d5557c53078e(level.var_d03989799d2951ee);
  }

  level.ghost.ignoreall = 0;
  level.gaz.ignoreall = 0;
  level.soap.ignoreall = 0;
  level flag_set("flag_allies_attack_heli");
  level.aiment = utility::spawn_script_origin(level.var_9e42b50ac8eec4.origin);
  level.aiment setCanDamage(1);
  level.aiment.health = 1000;
  level.aiment.maxhealth = 1000;
  level.aiment linkTo(level.var_9e42b50ac8eec4);
  waitframe();
  level thread function_ccd6fa25a11d45da(level.ghost, level.var_9e42b50ac8eec4, 200, 50);
  level thread function_ccd6fa25a11d45da(level.gaz, level.var_9e42b50ac8eec4, 200, 50);
  level thread function_ccd6fa25a11d45da(level.soap, level.var_9e42b50ac8eec4, 200, 50);
}

function function_ccd6fa25a11d45da(ai, attack_target, var_c231f0ecedfe0335, var_c42e0b2dc99cfd7d, var_1d5446ff33d74d9e) {
  level endon("game_ended");
  level endon("flag_exfil_allies_triggered");
  level.aiment endon("death");
  ai endon("death");
  level.aiment.maxvisibledist = 9999999;
  level.aiment.ignoreme = 0;
  ai.aiment = level.aiment;
  ai.ignoreall = 0;
  ai.dontevershoot = 1;
  ai setengagementmaxdist(9999998, 9999999);
  ai function_9215ce6fc83759b9(9999999);
  ai.maxfaceenemydist = 9999999;
  ai.maxsightdistsqrd = squared(9999999);
  ai.maxvisibledist = 9999999;
  ai.ignoresuppression = 1;
  ai.dontshootwhilemoving = 0;
  ai.suppress_uselastenemysightpos = 1;
  ai.forcesuppressai = 1;
  ai.forcesuppression = 1;
  ai.aggressivemode = 1;
  ai.dontgiveuponsuppression = 1;
  ai.aimspeedoverride = 6;
  ai.upaimlimit = -180;
  ai.downaimlimit = 180;
  ai.rightaimlimit = -180;
  ai.leftaimlimit = 180;
  ai childthread function_83061b2ec5df268a();

  if(issentient(level.aiment)) {
    ai.favoriteenemy = level.aiment;
    ai agentsetfavoriteenemy(level.aiment);
    ai function_710bd6843f902d50(level.aiment, 1);
    ai forcethreatupdate();
    ai getenemyinfo(level.aiment);
    ai setagentattacker(level.aiment);
    ai updateaiminfo();
  } else {
    ai.onlyscriptenemy = 1;
    ai setentitytarget(level.aiment, 1);
  }

  var_1d5446ff33d74d9e = default_to(var_1d5446ff33d74d9e, 15);
  var_489587c00c958276 = gettime() + 1000 * var_1d5446ff33d74d9e;

  while(gettime() <= var_489587c00c958276) {
    var_fa7934e74a5ffb06 = 0;
    var_8e0c9fc00ddd3975 = randomintrange(3, 8);

    if(!isDefined(level.aiment)) {
      return;
    }

    var_4ee37762ce15ed82 = level.aiment.origin + (randomfloatrange(var_c231f0ecedfe0335 * -1, var_c231f0ecedfe0335), randomfloatrange(var_c231f0ecedfe0335 * -1, var_c231f0ecedfe0335), randomfloatrange(0, var_c231f0ecedfe0335 / 2));

    while(var_fa7934e74a5ffb06 < var_8e0c9fc00ddd3975) {
      x = randomfloatrange(var_c42e0b2dc99cfd7d * -1, var_c42e0b2dc99cfd7d);
      y = randomfloatrange(var_c42e0b2dc99cfd7d * -1, var_c42e0b2dc99cfd7d);
      z = randomfloatrange(var_c42e0b2dc99cfd7d * -1, var_c42e0b2dc99cfd7d);
      var_a19d48388d4e308a = var_4ee37762ce15ed82 + (x, y, z);
      magicbullet(ai.weapon, ai gettagorigin("tag_flash"), var_a19d48388d4e308a, undefined, ai, 0);
      var_fa7934e74a5ffb06++;

      if(var_fa7934e74a5ffb06 < var_8e0c9fc00ddd3975) {
        wait 0.5;
      }
    }

    var_fa7934e74a5ffb06 = 0;
    wait 2;
  }
}

function function_d1f760259b33bc01() {
  level endon("game_ended");
  level flag_wait("flag_drop_chemical_vial_hit_ground");
  playFXOnTag(getfx("vfx_chemical_seeping_gas"), level.canister, "TAG_CYLINDER_FX");
  playFXOnTag(getfx("vfx_jup_canister_blinking_red_light"), level.canister, "TAG_CYLINDER_FX");
  level.canister playSound("jup_chemical_reactor_seq_canister_impact_leak");
  level flag_wait("flag_gas_effects_started");
  killfxontag(getfx("vfx_chemical_seeping_gas"), level.canister, "TAG_CYLINDER_FX");
  killfxontag(getfx("vfx_jup_canister_blinking_red_light"), level.canister, "TAG_CYLINDER_FX");
}

function private function_83061b2ec5df268a() {
  self endon("death");
  self.aiment endon("death");
  level endon("flag_exfil_allies_triggered");

  while(true) {
    self.var_130b2c98c9d80a1a = self.aiment.origin;
    self.lastenemysightpos = self.aiment.origin;
    self.shootposoverride = self.aiment.origin;
    waitframe();
  }
}

function function_54ca28f416f3bb3b() {
  level endon("game_ended");
  level flag_wait("flag_drop_chemical_ally_attacks");
  var_c2e8b2e6fa08e3a3 = getStructArray("reactor_pit_vignette_structs", "targetname");
  var_8ea713a6ba6424ac = function_cbc8904a4e5d665a();

  foreach(ai in var_8ea713a6ba6424ac) {
    var_cf3ebe03821a8aeb = getclosest(ai.origin, var_c2e8b2e6fa08e3a3);
    function_a87a516257b67c72(var_cf3ebe03821a8aeb, ai);
    var_c2e8b2e6fa08e3a3 = array_remove(var_c2e8b2e6fa08e3a3, var_cf3ebe03821a8aeb);

    if(var_c2e8b2e6fa08e3a3.size == 0) {
      break;
    }
  }

  var_4ed2af72fb5b2b59 = getStructArray("reactor_react_vignette_structs", "targetname");
  var_b94a205eff2489f2 = function_96d133ef2668e18();

  if(var_b94a205eff2489f2.size == 0) {
    return;
  }

  foreach(var_6d8a5034036b479 in var_4ed2af72fb5b2b59) {
    var_c1314d1adcdc2508 = sortbydistance(var_b94a205eff2489f2, var_6d8a5034036b479.origin);
    index = 0;

    while(distance(var_c1314d1adcdc2508[index].origin, var_6d8a5034036b479.origin) < 0) {
      index++;

      if(index >= var_c1314d1adcdc2508.size) {
        break;
      }
    }

    if(index >= var_c1314d1adcdc2508.size) {
      continue;
    }

    while(var_c1314d1adcdc2508[index].origin[2] > var_6d8a5034036b479.origin[2] + 10) {
      index++;

      if(index >= var_c1314d1adcdc2508.size) {
        break;
      }
    }

    if(index >= var_c1314d1adcdc2508.size) {
      continue;
    }

    while(var_c1314d1adcdc2508[index].origin[2] + 175 < var_6d8a5034036b479.origin[2]) {
      index++;

      if(index >= var_c1314d1adcdc2508.size) {
        break;
      }
    }

    if(index >= var_c1314d1adcdc2508.size) {
      continue;
    }

    if(distance(var_c1314d1adcdc2508[index].origin, var_6d8a5034036b479.origin) > 300) {
      continue;
    }

    function_a87a516257b67c72(var_6d8a5034036b479, var_c1314d1adcdc2508[index]);
    var_b94a205eff2489f2 = array_remove(var_b94a205eff2489f2, var_c1314d1adcdc2508[index]);

    if(var_b94a205eff2489f2.size == 0) {
      break;
    }
  }
}

function function_50e82847f9bc9ca8() {
  level endon("game_ended");
  level endon("flag_escape_start");
  thread flag_set_delayed("flag_canister_pre_expl", 13.5);
  wait 15;
  level flag_set("flag_canister_explosion_delay_completed");
}

function function_23ed4451cd6be483() {
  level endon("game_ended");
  level endon("flag_escape_start");
  level flag_wait("flag_reactor_combat_flow_areas_pit");
  wait 1;

  for(var_8ea713a6ba6424ac = function_cbc8904a4e5d665a(); var_8ea713a6ba6424ac.size > 2; var_8ea713a6ba6424ac = function_cbc8904a4e5d665a()) {
    waitframe();
  }

  level flag_set("flag_pit_anim_preposition");

  while(gettime() < level.var_ec68a5df2b5089f9) {
    wait 0.2;
  }

  delay = randomfloatrange(1.5, 3);
  thread flag_set_delayed("flag_canister_pre_expl", delay - 1.5);
  wait delay;
  level flag_set("flag_canister_explosion_ainum");
}

function function_8836937ec5e4646d() {
  level endon("game_ended");
  level flag_wait("flag_canister_pre_expl");
  setmusicstate("mx_chemical_reactorchem");
  level.canister playSound("jup_chemical_reactor_seq_canister_impact_leak_end");
}

function function_2a835170b5980742() {
  level endon("game_ended");
  level flag_wait("flag_pit_anim_preposition");
  var_8ea713a6ba6424ac = function_cbc8904a4e5d665a();

  if(isDefined(level.var_8a82918039ae89fb)) {
    var_8ea713a6ba6424ac = array_remove(var_8ea713a6ba6424ac, level.var_8a82918039ae89fb);
  }

  var_ff96472df5edaa57 = getStructArray("reactor_stair_vignette_structs", "targetname");

  foreach(var_6d8a5034036b479 in var_ff96472df5edaa57) {
    if(!isDefined(var_8ea713a6ba6424ac) || var_8ea713a6ba6424ac.size == 0) {
      break;
    }

    closest_ai = getclosest(var_6d8a5034036b479.origin, var_8ea713a6ba6424ac);
    closest_ai.var_4ebe755e0a0a430e = 0;
    var_8ea713a6ba6424ac = array_remove(var_8ea713a6ba6424ac, closest_ai);
    function_a87a516257b67c72(var_6d8a5034036b479, closest_ai);
  }

  var_2d9016e47d8d3e50 = getStructArray("reactor_expl_vignette_structs", "targetname");

  foreach(ai in var_8ea713a6ba6424ac) {
    if(istrue(ai.var_f5facf26f3f4f9d1)) {
      continue;
    }

    var_cf3ebe03821a8aeb = getclosest(ai.origin, var_2d9016e47d8d3e50);
    ai.var_4ebe755e0a0a430e = 0;
    function_a87a516257b67c72(var_cf3ebe03821a8aeb, ai);
    var_2d9016e47d8d3e50 = array_remove(var_2d9016e47d8d3e50, var_cf3ebe03821a8aeb);

    if(var_2d9016e47d8d3e50.size == 0) {
      break;
    }
  }
}

function function_fecabb2254ff24dc() {
  level endon("game_ended");
  level endon("flag_escape_start");
  self endon("death");

  while(true) {
    scripts\asm\gesture::ai_request_gesture("cough");
    wait randomfloatrange(3, 6);
  }
}

function function_cbc8904a4e5d665a() {
  vol = function_1c4d592029f2b0d3("choreo_reactor_floor1_wide");
  var_8ea713a6ba6424ac = [];

  foreach(ai in level.var_d03989799d2951ee) {
    if(isDefined(ai) && isalive(ai) && ai istouching(vol)) {
      var_8ea713a6ba6424ac = function_6d6af8144a5131f1(var_8ea713a6ba6424ac, ai);
    }
  }

  return var_8ea713a6ba6424ac;
}

function function_96d133ef2668e18() {
  vol = function_1c4d592029f2b0d3("choreo_reactor_floor1_wide");
  var_b94a205eff2489f2 = [];

  foreach(ai in level.var_d03989799d2951ee) {
    if(!ai function_ee0aa391d8fad9d5() && !ai istouching(vol)) {
      var_b94a205eff2489f2 = function_6d6af8144a5131f1(var_b94a205eff2489f2, ai);
    }
  }

  return var_b94a205eff2489f2;
}

function function_9ddb93c229b28493() {
  return (80, 0, 0);
}

function function_298f206d6e2e2e70() {}

function function_17006546f61dd733() {
  level endon("game_ended");
  level flag_wait("flag_dungeon_intro_complete");
  level flag_wait("flag_escape_start");

  if(istrue(level.checkpoint_reached) && !istrue(level.var_f8c5ab19e120757d)) {
    return;
  }

  if(flag("flag_escape_flow_start")) {
    return;
  }

  level flag_set("flag_escape_flow_start");
  level thread flag_set_delayed("vo_reactor_chemical_released", 2);
  setDvar(@ "hash_5240c43ec9603a9b", 1);
  level.var_f8c6cda869a327d7 = getdvarfloat(@ "hash_fea11f41165f4349", 75);
  level thread function_980e5f8b59d6c2f9();
  level thread function_74ec4fbc99601cb1();
  level thread function_3a8d26efc8eae062();
  level thread function_ae6931fa54d5bf7d();
  level thread function_2dd4b26166113e78();
  level thread escape_gas();
  level thread function_bcc11b1ac1caf707();
  level thread function_f6cbc3aeacf89705();
  level thread function_bee9882e91a3cb6d();
  level thread function_e5ed6e1be42f658();
  level thread function_9046cafa919979b1();
  level thread exfil_interact();
  level flag_set("vo_reactor_escape");
  level flag_wait("flag_exit_interacted");
}

function function_980e5f8b59d6c2f9() {
  level endon("game_ended");
  level flag_wait("vo_reactor_escape_completed");

  while(true) {
    while(!level.player function_28f3273faec1d365()) {
      waitframe();
    }

    hint_time = gettime() + 3000;
    abort = 0;

    while(gettime() < hint_time) {
      waitframe();

      if(!level.player function_28f3273faec1d365()) {
        abort = 1;
        break;
      }
    }

    if(istrue(abort)) {
      continue;
    }

    level notify("vo_reactor_airlocks_hint");
  }
}

function function_74ec4fbc99601cb1() {
  level endon("game_ended");
  level flag_wait("vo_reactor_chemical_released_completed");

  while(function_1e5b594c4ab2e8ca() < 845) {
    waitframe();
  }

  if(!function_74d4aa011fa76522()) {
    level flag_set("vo_reactor_gasnear_floor2");
  }

  while(function_1e5b594c4ab2e8ca() < 965) {
    waitframe();
  }

  level flag_set("flag_gas_at_floor2");
  waitframe();
  level flag_set("vo_reactor_ally_progress2");
  var_227083b50143a204 = 1000 - 31.5;

  while(function_1e5b594c4ab2e8ca() < var_227083b50143a204) {
    waitframe();
  }

  level flag_set("flag_reactor_disallow_lowpri_vo");

  while(function_1e5b594c4ab2e8ca() < 1000) {
    waitframe();
  }

  level flag_set("flag_gas_near_floor3");

  if(!function_74d4ab011fa76755()) {
    level flag_set("vo_reactor_gasnear_floor3");
  }

  wait 1;
  level flag_clear("flag_reactor_disallow_lowpri_vo");
  var_227083b50143a204 = 1040 - 31.5;

  while(function_1e5b594c4ab2e8ca() < var_227083b50143a204) {
    waitframe();
  }

  level flag_set("flag_reactor_disallow_lowpri_vo");

  while(function_1e5b594c4ab2e8ca() < 1040) {
    waitframe();
  }

  level flag_set("flag_gas_at_floor3");

  if(!function_74d4ab011fa76755()) {
    level flag_set("vo_reactor_gasat_floor3");
  } else {
    level flag_set("vo_reactor_safe_floor3");
  }

  while(function_1e5b594c4ab2e8ca() < 1183.95) {
    waitframe();
  }

  level flag_set("vo_reactor_gasnear_floor4");

  while(function_1e5b594c4ab2e8ca() < 1303.95) {
    waitframe();
  }

  level flag_set("flag_gas_at_floor4");
}

function function_1e5b594c4ab2e8ca() {
  return level.var_b98b9f05b5cd26ea.origin[2];
}

function function_74d4aa011fa76522() {
  return level.player.origin[2] >= 1005;
}

function function_74d4ab011fa76755() {
  return level.player.origin[2] >= 1160;
}

function function_f6cbc3aeacf89705() {
  level endon("game_ended");
  level endon("flag_allies_spawned");
  level function_665d474ff040b446(["flag_p1w2_started", "flag_p2w1_started"]);

  while(true) {
    wait randomfloatrange(1, 10);

    if(function_8f736cb1a3892236()) {
      level notify("vo_konniwaves_banter_price_winning");
      continue;
    }

    level notify("vo_konniwaves_banter_price_losing");
  }
}

function function_8f736cb1a3892236() {
  if(!isDefined(level.var_4c146c812ce90c91)) {
    return false;
  }

  return gettime() < level.var_4c146c812ce90c91 + 5000;
}

function function_3a8d26efc8eae062() {
  while(!isDefined(level.ghost)) {
    waitframe();
  }

  level.ghost.ignoreall = 1;
}

function function_bcc11b1ac1caf707() {
  level endon("game_ended");
  level.var_a42445fb32c75d02 = getEntArray("reactor_death_start", "targetname");
}

function function_5b062629bfd97a4f() {
  level endon("game_ended");
  self endon("death");
  level flag_wait("flag_gas_effects_started");

  while(!isDefined(level.var_46291596959530d1)) {
    waitframe();
  }

  while(true) {
    if(self istouching(level.var_46291596959530d1)) {
      self.in_gas = 1;
      self notify("ai_in_gas");

      if(isDefined(level.var_d03989799d2951ee) && array_contains(level.var_d03989799d2951ee, self)) {
        level.var_d03989799d2951ee = array_remove(level.var_d03989799d2951ee, self);
      }

      if(!function_ee0aa391d8fad9d5()) {
        var_6d8a5034036b479 = function_d66caccb8c04b49d();

        if(isDefined(var_6d8a5034036b479)) {
          function_a87a516257b67c72(var_6d8a5034036b479, self);
        } else {
          thread function_b55180262be7d4e8();
        }
      }

      level flag_set("flag_ai_killed_by_gas");
    }

    waitframe();
  }
}

function function_d66caccb8c04b49d() {
  if(level.var_a42445fb32c75d02.size > 0) {
    var_14d31d2d94743f4f = sortbydistance(level.var_a42445fb32c75d02, self.origin);
    var_d38541cb201a2ca9 = undefined;

    for(i = 0; i < var_14d31d2d94743f4f.size; i++) {
      if(self istouching(var_14d31d2d94743f4f[i])) {
        var_d38541cb201a2ca9 = var_14d31d2d94743f4f[i];
        break;
      }
    }

    if(!isDefined(var_d38541cb201a2ca9)) {
      return undefined;
    }

    level.var_a42445fb32c75d02 = array_remove(level.var_a42445fb32c75d02, var_d38541cb201a2ca9);
    return function_7a18da6e48b71c35(var_d38541cb201a2ca9.target);
  }

  return undefined;
}

function function_b55180262be7d4e8() {
  level endon("game_ended");
  function_4a3a237962834aa0();
  self.goalradius = 5;
  self cleargoalvolume();
  self clearentitytarget();
  self setgoalpos(self.origin);
  self.animname = "generic";
  org = spawn_script_origin();
  death_anim = random(["jup_che_stand_pain_death_03", "jup_che_stand_pain_death_05", "jup_che_stand_pain_death_09", "jup_che_stand_pain_death_10", "jup_che_stand_pain_death_12", "jup_che_stand_pain_death_13", "jup_che_stand_pain_death_14"]);
  org anim_single_solo(self, death_anim);
  function_d62d7d5cce8eb66c();
}

function function_d62d7d5cce8eb66c() {
  self kill();
}

function function_a87a516257b67c72(vignette_struct, ai) {
  ai function_4a3a237962834aa0();
  function_978c9be612a7da04(vignette_struct, ai);
  ai thread function_44742741c2b5edc2();
}

function function_44742741c2b5edc2() {
  level endon("game_ended");
  self endon("death");

  while(!isDefined(self.animstruct)) {
    waitframe();
  }

  self.animstruct waittill_any_4("killvignettescript", "jup_che_react_canister_fall_signal_01", "jup_che_react_canister_fall_signal_02", "jup_che_react_canister_fall_signal_03");
  function_6352159e541b9eb1();
}

function function_ae6931fa54d5bf7d() {
  level endon("game_ended");
  level endon("flag_exit_interacted");
  level.player endon("death");
  var_8bd6bc5b5df7213a = ["iw9_ges_gas_cough", "iw9_ges_gas_cough", "iw9_ges_gas_cough", "iw9_ges_gas_cough_long"];
  weaponnone = makeweapon("none");

  while(true) {
    gestureplayed = undefined;
    var_7741cd64dd73611 = undefined;
    var_a30a91fcabea0246 = undefined;
    level waittill("request_cough_gesturesound");
    level notify("vo_reactor_gasdamage_cough");
    curweap = level.player getcurrentprimaryweapon();

    if(!issameweapon(curweap, weaponnone)) {
      var_a30a91fcabea0246 = random(var_8bd6bc5b5df7213a);
      gestureplayed = level.player playgestureviewmodel(var_a30a91fcabea0246);
    }

    if(istrue(gestureplayed)) {
      gesturelength = level.player getgestureanimlength(var_a30a91fcabea0246);
      wait gesturelength;
    } else {
      wait 0.1;
    }

    while(istrue(level.var_32e563a546dd9da7)) {
      var_7741cd64dd73611 = 1;
      wait 1;
    }

    if(istrue(gestureplayed) || istrue(var_7741cd64dd73611)) {
      wait randomfloatrange(3, 7);
    }
  }
}

function function_2dd4b26166113e78() {
  level endon("game_ended");
  level endon("flag_exit_interacted");
  level.player endon("death");
  level flag_wait("reactor_cough_near_end");
  var_e9fedd5b9ac26043 = function_1c4d592029f2b0d3("vol_reactor_cough_zone");

  while(!level.player istouching(var_e9fedd5b9ac26043)) {
    waitframe();
  }

  while(!flag("flag_exit_interacted")) {
    level notify("request_cough_gesturesound");
    wait 0.2;
  }
}

function escape_gas() {
  level endon("game_ended");

  if(isDefined(level.canister)) {
    playFX(getfx("vfx_volumetric_particles_1"), level.canister gettagorigin("TAG_CYLINDER_FX"));
    playFX(getfx("vfx_chemical_reactor"), (1877.99, 24443.7, 1123));
    level.canister playSound("jup_chemical_reactor_seq_canister_explode");
    level.player earthquakeforplayer(1, 0.4, level.canister.origin, 500);
  }

  level thread flag_set_delayed("flag_gas_effects_started", 0);
  thread function_2c993f7fe91129ce();
  level thread function_1f024b69355959a7();
  start = function_7a18da6e48b71c35("gas_path");
  destination = function_7a18da6e48b71c35(start.target);
  dist = distance(destination.origin, start.origin);
  level.var_bb8b217506e2d6e4 = spawn_script_origin(start.origin);
  level.var_bb8b217506e2d6e4 thread function_8962ce4b02eb85b7(level.fog);
  level.var_b98b9f05b5cd26ea linkTo(level.var_bb8b217506e2d6e4);
  level.var_46291596959530d1 enablelinkTo();
  level.var_46291596959530d1 linkTo(level.var_bb8b217506e2d6e4);
  level.var_bb8b217506e2d6e4 setModel("tag_origin_animate");
  playFXOnTag(getfx("vfx_chemical_smk_rising"), level.var_bb8b217506e2d6e4, "tag_origin");
  level thread function_24767ea280ff9d08();
}

function function_2c993f7fe91129ce() {}

function function_8962ce4b02eb85b7(var_daad7d20d7a17c02) {
  level endon("game_ended");
  level endon("flag_exit_interacted");
  level.player endon("death");

  while(true) {
    self.origin = (self.origin[0], self.origin[1], var_daad7d20d7a17c02.origin[2]);
    waitframe();
  }
}

function function_1f024b69355959a7() {
  level endon("game_ended");
  level.fog setscriptablepartstate("test_part", "bbox_default");
  wait 0.1;
  level.fog setscriptablepartstate("test_part", "bbox_move_up_start");
  wait 2;
  level.fog setscriptablepartstate("test_part", "bbox_move_up");
  level thread function_81d9dc860f731666();
}

function function_81d9dc860f731666() {
  level endon("game_ended");
  wait 12;
  level.fog setscriptablepartstate("test_part", "bbox_move_up_2");
  level thread function_81d9dd860f731899();
}

function function_81d9dd860f731899() {
  level endon("game_ended");
  wait 42;
  level.fog setscriptablepartstate("test_part", "bbox_move_up_3");
}

function function_24767ea280ff9d08() {
  level endon("game_ended");
  level endon("flag_exit_interacted");
  level.player endon("death");
  level flag_wait("flag_gas_effects_started");
  level.player.var_d5e499e7fe2c490b = 0;
  level.var_e70ce1a0418791bd = array_add_safe(level.var_e70ce1a0418791bd, "gas");
  level thread function_468ed641ecf754fb();
  level thread function_c51c4208452eaff9();
  level thread function_9911d4adcbbc087f();
  thread namespace_11fae4a66a43bd3f::function_d129d0efbe496101();
  thread namespace_11fae4a66a43bd3f::function_c0dfabc36952a884();

  while(true) {
    var_130f9f1116eb1562 = 0;

    switch (function_67fd72f17714d5f6()) {
      case #"hash_45408db06620faea":
        level.player.var_4f984f22c067230d = "above";
        level function_b3657f7e749c93c0();
        break;
      case #"hash_661b8493ce623fe":
        level.player.var_4f984f22c067230d = "lowerbody";
        var_130f9f1116eb1562 = 0;
        level function_b3657f7e749c93c0();
        break;
      case #"hash_8457749ac30ef6d1":
        level.player.var_4f984f22c067230d = "depthA";
        var_130f9f1116eb1562 = 0;
        level function_b3657f7e749c93c0();
        break;
      case #"hash_8457719ac30ef218":
        level.player.var_4f984f22c067230d = "depthB";
        var_130f9f1116eb1562 = 10;
        level function_cc69cc4729351af0();
        break;
    }

    if(var_130f9f1116eb1562 > 0) {
      level.player dodamage(var_130f9f1116eb1562, level.player.origin, undefined, undefined, "MOD_TRIGGER_HURT", makeweapon("gas"));
      level.player.var_121e3ac332418d67 = gettime();
      wait randomfloatrange(0.25, 1.75);
    }

    waitframe();
  }
}

function function_cc69cc4729351af0() {
  if(!istrue(level.player.var_1a15e9b80bf971ec)) {
    level.player.var_1a15e9b80bf971ec = 1;
    level.player setclientomnvar("ui_gettocover_text", "game/chemical_gas");
  }
}

function function_b3657f7e749c93c0() {
  if(istrue(level.player.var_1a15e9b80bf971ec)) {
    level.player.var_1a15e9b80bf971ec = 0;
    level.player setclientomnvar("ui_gettocover_text", "game/get_to_cover");
  }
}

function function_468ed641ecf754fb() {
  level endon("game_ended");
  level.player endon("death");

  while(!isDefined(level.player.var_4f984f22c067230d)) {
    waitframe();
  }

  while(!flag("flag_exit_interacted")) {
    switch (level.player.var_4f984f22c067230d) {
      case #"hash_8457719ac30ef218":
        level.player thread scripts\cp\equipment\cp_gas_grenade::gas_applyblur();
        break;
      default:
        level.player thread scripts\cp\equipment\cp_gas_grenade::gas_clearblur(0);
        break;
    }

    waitframe();
  }

  level.player thread scripts\cp\equipment\cp_gas_grenade::gas_clearblur(0);
}

function function_c51c4208452eaff9() {
  level endon("game_ended");
  level endon("flag_exit_interacted");
  level.player endon("death");

  while(!isDefined(level.player.var_4f984f22c067230d)) {
    waitframe();
  }

  while(!flag("flag_exit_interacted")) {
    switch (level.player.var_4f984f22c067230d) {
      case #"hash_8457719ac30ef218":
      case #"hash_8457749ac30ef6d1":
        level notify("request_cough_gesturesound");
        break;
    }

    waitframe();
  }
}

function function_67fd72f17714d5f6() {
  depth = level.var_bb8b217506e2d6e4.origin[2] - level.player.origin[2];

  switch (level.player getstance()) {
    case #"hash_3fed0cbd303639eb":
      depth += 26;
      break;
    case #"hash_d91940431ed7c605":
      depth += 40;
      break;
  }

  if(depth <= 10) {
    return "above";
  }

  if(depth < 40) {
    return "lowerbody";
  }

  if(depth < 60) {
    return "depthA";
  }

  return "depthB";
}

function function_9911d4adcbbc087f() {
  level endon("game_ended");

  while(true) {
    if(getdvarint(@ "hash_9289ead165b8eae", 0) == 1) {
      level.player radiusdamage(level.var_bb8b217506e2d6e4.origin, 700, 100, 5, level.player, "MOD_FALLING", undefined, undefined, undefined, 1);
    }

    wait 0.1;
  }
}

function function_bee9882e91a3cb6d() {
  level endon("game_ended");
  level flag_wait("flag_gas_effects_started");
  var_1e05b2ba241b6cfd = getdvarfloat(@ "hash_3610ac59a4e8d8c8", 65);
  level thread function_907131c436aa6a3e(var_1e05b2ba241b6cfd);
  level thread function_18144a2abaedef29();
  level thread function_41b0170e7d48d21b(var_1e05b2ba241b6cfd);
  level flag_wait("flag_exfil_allies_triggered");
  level flag_set("reactor_cough_near_end");
  waitframe();
  level.var_d03989799d2951ee = function_fdc9d5557c53078e(level.var_d03989799d2951ee);
  spawn_ghost(function_7a18da6e48b71c35("reactor_ghost_struct"));
  spawn_soap(function_7a18da6e48b71c35("reactor_soap_struct"));
  function_64c20cb1068f5051(function_7a18da6e48b71c35("reactor_gaz_struct"));

  if(!isDefined(level.ghost.weapon)) {
    level.ghost.weapon = level.var_67b54180a55f70e1["iw9_ar_mcbravo_mp, none, none, none"];
  }

  if(!isDefined(level.soap.weapon)) {
    level.soap.weapon = level.var_67b54180a55f70e1["iw9_dm_mike14_mp, none, none, none"];
  }

  gun = make_weapon_special("iw9_ar_mcharlie_v2_cp");
  level.gaz scripts\anim\shared::forceuseweapon(gun, "primary");
  level.ghost thread function_eac3dbb62d486c96();
  level.soap thread function_eac3dbb62d486c96();
  level.gaz thread function_eac3dbb62d486c96();
  level flag_set("flag_allies_spawned");
  level.allies = [level.ghost, level.soap, level.gaz];

  foreach(ally in level.allies) {
    ally setthreatbiasgroup("tf141");
    ally.var_98e373d243c1936f = 1;
  }

  wait 1;

  foreach(ai in level.var_d03989799d2951ee) {
    ally = random(level.allies);
    ai agentsetfavoriteenemy(ally);
    ai function_710bd6843f902d50(ally, 1);
    ai forcethreatupdate();
    ai setagentattacker(ally);
  }
}

function function_18144a2abaedef29() {
  level endon("game_ended");
  level endon("flag_exfil_allies_triggered");
  level flag_wait("reactor_wave_combat_wrapup");
  flag_set("flag_exfil_allies_triggered");
}

function function_41b0170e7d48d21b(var_1e05b2ba241b6cfd) {
  level endon("game_ended");
  level endon("flag_exfil_allies_triggered");
  wait var_1e05b2ba241b6cfd;
  flag_set("flag_exfil_allies_triggered");
}

function function_907131c436aa6a3e(var_1e05b2ba241b6cfd) {
  level endon("game_ended");
  level flag_wait("flag_gas_effects_started");
  wait var_1e05b2ba241b6cfd - 2;
  level flag_set("vo_reactor_konniwaves_end");
}

function function_e5ed6e1be42f658() {
  level endon("game_ended");
  level flag_wait("flag_p2w1_started");

  foreach(ai in level.var_d03989799d2951ee) {
    ai.baseaccuracy *= 0.1;
  }
}

function function_9046cafa919979b1() {
  level endon("game_ended");
  level thread function_edc534f00b8657ba();
  level flag_wait("flag_lower_exit_ascender");
  anim_org = function_7a18da6e48b71c35("outro_anim_scene_part1");
  level.reactor_rope = spawn_anim_model("reactor_rope");
  anim_org thread anim_single_solo(level.reactor_rope, "drop");
  wait 2;
  level flag_set("flag_animated_rope_lowered");
  level flag_set("flag_marker_on_exit_ascender");
  level flag_set("vo_reactor_exfil_rope_nag");
}

function function_eac3dbb62d486c96() {
  level endon("game_ended");
  level endon("flag_exit_interacted");
  self.ignoresuppression = 1;
  self.aggressivemode = 1;
  self.dontgiveuponsuppression = 1;
  self.forcesuppressai = 1;
  self.disablebulletwhizbyreaction = 1;
  self allowedstances("stand");
  self.pushable = 0;
  self setengagementmaxdist(0.1, 10000);
  var_ee572022e598590c = ["j_shoulder_ri", "j_shoulder_le", "j_elbow_ri", "j_elbow_le", "j_hip_ri", "j_hip_le", "j_knee_ri", "j_knee_le", "j_spineupper", "j_head"];

  while(true) {
    level.var_d03989799d2951ee = function_fdc9d5557c53078e(level.var_d03989799d2951ee);
    level.var_d03989799d2951ee = function_e183d373f385fbe(level.var_d03989799d2951ee);

    if(level.var_d03989799d2951ee.size == 0) {
      wait 1;
      continue;
    }

    self.var_89a283a2f92a229b = random(level.var_d03989799d2951ee);
    var_fa7934e74a5ffb06 = 0;
    var_8e0c9fc00ddd3975 = randomintrange(3, 8);

    while(isDefined(self.var_89a283a2f92a229b) && isalive(self.var_89a283a2f92a229b)) {
      var_3796fe8cf560b672 = function_e62e9bcdcdbbfc39();
      results = function_ed89746481ab2c5f(var_3796fe8cf560b672, self.var_89a283a2f92a229b, 4);

      if(!is_equal(results, "shot_available")) {
        break;
      }

      shot_end = undefined;
      shot_end = self.var_89a283a2f92a229b gettagorigin(random(var_ee572022e598590c));
      magicbullet(self.weapon, self gettagorigin("tag_flash"), shot_end, self, self, 0);
      var_fa7934e74a5ffb06++;

      if(var_fa7934e74a5ffb06 > var_8e0c9fc00ddd3975) {
        var_fa7934e74a5ffb06 = 0;
        wait 2;
        continue;
      }

      wait 0.5;
    }

    wait randomfloatrange(2, 5);
  }
}

function function_edc534f00b8657ba() {
  level endon("game_ended");
  level endon("flag_lower_exit_ascender");
  level thread function_7f16e5dc7562912d();
  level thread function_952d803726d4709a();
  wait level.var_f8c6cda869a327d7;
  level flag_set("flag_lower_exit_ascender");
}

function function_7f16e5dc7562912d() {
  level endon("game_ended");
  level endon("flag_lower_exit_ascender");
  level flag_wait("reactor_wave_combat_wrapup");
  level flag_set("flag_lower_exit_ascender");
}

function function_952d803726d4709a() {
  level endon("game_ended");
  level endon("flag_lower_exit_ascender");
  level flag_wait("flag_allies_spawned");
  function_a1d04bd7839d30ad(0);
  level flag_set("flag_lower_exit_ascender");
}

function function_543a4476d1c68216() {
  unlock = self;
  var_89019d958485f73a = getentitylessscriptablearray(unlock.target, "targetname");
  assert(var_89019d958485f73a.size == 1);
  var_4b2a6bd9f76be9de = var_89019d958485f73a[0];
  spool = function_1c4d592029f2b0d3(var_4b2a6bd9f76be9de.target);
  spool hide();
  rope = function_1c4d592029f2b0d3(spool.target);
  rope hide();
  assert(isDefined(unlock.script_noteworthy));
  var_4b2a6bd9f76be9de setscriptablepartstate("top", "off");
  unlock.angles = (0, 0, 0);
  assert(isDefined(unlock.script_flag_wait));
  level flag_wait(unlock.script_flag_wait);
}

function function_db419624c6e1361d() {}

function function_6c009b7b1f7a06fd() {
  return isDefined(level.start_point) && level.start_point == "exfil";
}

function function_cce1ca1325cccbe4() {
  level endon("game_ended");
  level flag_wait("flag_dungeon_intro_complete");

  if(istrue(level.checkpoint_reached) && !istrue(level.var_f8c5ab19e120757d)) {
    return;
  }

  if(flag("flag_exfil_flow_start")) {
    return;
  }

  level flag_set("flag_exfil_flow_start");
  var_57bc32772190fe10 = 0;

  if(function_6c009b7b1f7a06fd()) {
    if(true) {
      var_57bc32772190fe10 = 1;
      function_5933e14a9af84b82(1);
    }
  }

  level flag_wait("flag_exit_interacted");

  iprintlnbold("<dev string:x1b7>");

  if(isDefined(level.var_d03989799d2951ee)) {
    foreach(ai in level.var_d03989799d2951ee) {
      ai kill();
    }
  }

  namespace_9766820f5baa93fb::function_cd054d9ba5a62557(0);
  level thread play_outro();
  level flag_wait("flag_dungeon_outro_complete");

  if(var_57bc32772190fe10) {
    function_9529eb86e25b4574();
  }

  function_fa7c87f2585bd907(1);
  level waittill("eternity");
}

function function_cb7b401ed6a2a0c6() {
  if(getdvarint(@ "hash_a981ed2695836428", 0)) {
    function_63e33dca3525cdde();
  }

  function_26a01f4af94cb7bd();
  function_446a0ab3bcf9e922();
  function_17006546f61dd733();
  function_cce1ca1325cccbe4();
}

function function_fb2601dbc065a6d0() {
  if(!flag("flag_reactor_flow_start")) {
    function_446a0ab3bcf9e922();
  }
}

function function_c0c12989d0f845cc(stop_flag) {
  structs = [];
  structs[0] = function_7a18da6e48b71c35("reactor_turbine_door_interact");
  structs[1] = function_7a18da6e48b71c35("reactor_parking_door_interact");
  structs[2] = function_7a18da6e48b71c35("reactor_rear_door_interact");

  foreach(str in structs) {
    obj = spawn("script_origin", str.origin);
    obj.var_cffca1a9623f41d5 = obj create_interact(undefined, undefined, undefined, 600, &"CP_JUP_CHEMICAL/REACTOR_DOOR_INTERACT", undefined, "hide");
    obj.var_cffca1a9623f41d5 setuseholdduration("duration_short");
    obj.var_cffca1a9623f41d5 thread function_d7ae4d10d010bf27(obj, stop_flag);
    obj.var_cffca1a9623f41d5 thread function_fe932e3b35a1f048(obj, stop_flag);
    obj.var_cffca1a9623f41d5 thread function_8b0b67e316e21c1f(obj, stop_flag);
  }
}

function function_d7ae4d10d010bf27(obj, stop_flag) {
  level endon("game_ended");
  self endon("delete");
  level endon(stop_flag);
  thread function_ecfe77230c4e0ebc(obj, stop_flag);

  while(!flag(stop_flag)) {
    self waittill("trigger");
    level flag_set("flag_inaccessible_button_interacted");
    level notify("vo_reactor_inaccessible_interacted");
    wait 15;
  }
}

function function_fe932e3b35a1f048(obj, stop_flag) {
  level endon("game_ended");
  self endon("delete");
  level endon(stop_flag);

  while(!flag(stop_flag)) {
    self waittill("trigger");
    thread namespace_11fae4a66a43bd3f::function_cba2c362cdb9cfaf();
  }
}

function function_ecfe77230c4e0ebc(obj, stop_flag) {
  level endon("game_ended");
  self endon("delete");
  level endon(stop_flag);
  flag_wait("flag_inaccessible_button_interacted");
  self setHintString(&"CP_JUP_CHEMICAL/REACTOR_DOOR_INTERACT_LOCKED");
}

function function_8b0b67e316e21c1f(obj, stop_flag) {
  level endon("game_ended");
  level flag_wait(stop_flag);
  obj.var_cffca1a9623f41d5 function_dfb78b3e724ad620(0);
  obj.var_cffca1a9623f41d5 = undefined;
  obj delete();
}

function function_b8b58deb951e86a4() {
  level endon("game_ended");
  level endon("flag_power_plant_entered");
  vol_power_plant = function_1c4d592029f2b0d3("vol_power_plant");

  while(!level.player istouching(vol_power_plant)) {
    waitframe();
  }

  level flag_set("flag_power_plant_entered");
}

function function_75b4b91927ff5a87() {
  level endon("game_ended");
  level endon("flag_reactor_room_entered");
  level waittill("player_at_reactorroom");
  level flag_set("flag_reactor_room_entered");
}

function exfil_interact() {
  level flag_wait("flag_animated_rope_lowered");

  if(!function_1f067aa9b7648939()) {
    function_717b4d7bb248f126();

    while(!function_1f067aa9b7648939()) {
      waitframe();
    }

    level.var_824ed1f49ae1e802 delete();
  }

  objectivestruct = function_7a18da6e48b71c35("exfil_interact");
  usefov = 60;
  usedist = 100;
  objectivestruct.var_cffca1a9623f41d5 = objectivestruct create_interact(undefined, undefined, usedist, 500, &"MP/USE_AUTO_ASCENDER", undefined, "hide", undefined, usefov);
  objectivestruct.var_cffca1a9623f41d5 setusefov(usefov);
  objectivestruct.var_cffca1a9623f41d5 setuseholdduration("duration_short");
  objectivestruct.var_cffca1a9623f41d5 thread function_a7d2ebe17f01ff01(objectivestruct);
}

function function_717b4d7bb248f126() {
  objectivestruct = function_7a18da6e48b71c35("exfil_interact");
  objectivestruct.var_cffca1a9623f41d5 = objectivestruct create_interact(undefined, undefined, 100, 500, &"MP/USE_ASCENDER_INOPERABLE", undefined, "hide");
  objectivestruct.var_cffca1a9623f41d5 setuseholdduration("duration_short");
  level.var_824ed1f49ae1e802 = objectivestruct.var_cffca1a9623f41d5;
  objectivestruct.var_cffca1a9623f41d5 thread function_e6549b68ec3c5fed(objectivestruct);
}

function function_e6549b68ec3c5fed(obj) {
  self endon("delete");

  while(true) {
    self waittill("trigger");
    level notify("vo_reactor_exfil_missing_tool_nag");
  }
}

function function_a7d2ebe17f01ff01(obj) {
  self endon("delete");
  self waittill("trigger");
  level flag_set("flag_exit_interacted");
  thread function_adf509f9ba7e98df();
  obj.var_cffca1a9623f41d5 = undefined;
  self delete();
}

function function_ed89746481ab2c5f(shot_start, guy, timeout) {
  level thread delaynotify(timeout, "kill_waittill_target_visible");
  level endon("kill_waittill_target_visible");
  guy endon("death");
  contents = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_ainosight"]);

  while(true) {
    waitframe();
    castend = guy gettagorigin("j_head");
    castresult = physics_raycast(shot_start, castend, contents, undefined, 0, "physicsquery_closest", 0);

    if(isDefined(castresult) && castresult.size > 0) {
      continue;
    }

    return "shot_available";
  }
}

function function_adf509f9ba7e98df() {
  setmusicstate("mx_gb_chemical_exfil");
}

function function_e62e9bcdcdbbfc39() {
  org = self getEye();
  var_2c35f4a11a24796 = vectorNormalize(anglesToForward(self.angles));
  var_2768224e1f9c3e56 = org + var_2c35f4a11a24796 * 50;
  return var_2768224e1f9c3e56;
}

function function_9f3c433728214c41() {}

function function_fb457f7cdf0ac39e() {
  level notify("level_setStealthSettings");
  level endon("level_setStealthSettings");

  while(!isDefined(level.stealth)) {
    waitframe();
  }

  setsaveddvar(@ "hash_d7f5e9fd75782a83", 1);
  function_4cb0815e5108998c();
  function_531194f673a06de5(0);
  function_d5823c94e8131ea6(1);
  function_3c6ca4287e09d8b4(2400);
  level.var_8ee9c5604a4fb6c0 = 8192;
  level.valstruct val::set("level", "ai_eventlist", "jup_chemical_aieventlist");
  function_cdfd74e95368bd63(15000);
  level.valstruct val::set("level", "stealth_ttlt_lkp", 20000);
  level.valstruct val::set("level", "stealth_ttlt_not_lkp", 20000);
  utility::flag_set("stealth_ranges_initialized");
}

function function_4cb0815e5108998c() {
  hiddenranges["prone"] = 400;
  hiddenranges["crouch"] = 4000;
  hiddenranges["stand"] = 6000;
  var_b6b642cbeff52b88["prone"] = 150;
  var_b6b642cbeff52b88["crouch"] = 350;
  var_b6b642cbeff52b88["stand"] = 600;
  hiddenranges["shadow_prone"] = 0.05;
  hiddenranges["shadow_crouch"] = 0.05;
  hiddenranges["shadow_stand"] = 0.3;
  spottedranges["prone"] = 9500;
  spottedranges["crouch"] = 9600;
  spottedranges["stand"] = 9850;
  var_d0f35fc0a5c3df79["prone"] = 250;
  var_d0f35fc0a5c3df79["crouch"] = 1000;
  var_d0f35fc0a5c3df79["stand"] = 1800;
  spottedranges["shadow_prone"] = 0.01;
  spottedranges["shadow_crouch"] = 0.02;
  spottedranges["shadow_stand"] = 0.38;
  var_8f3f480583606401["prone"] = 1.1;
  var_8f3f480583606401["crouch"] = 1.15;
  var_8f3f480583606401["stand"] = 1.2;
  var_fac370d058479827["prone"] = 0;
  var_fac370d058479827["crouch"] = 0;
  var_fac370d058479827["stand"] = 0;
  var_fb574b7959625bf0["prone"] = 0;
  var_fb574b7959625bf0["crouch"] = 0;
  var_fb574b7959625bf0["stand"] = 0;
  utility::set_detect_ranges(hiddenranges, spottedranges, var_8f3f480583606401);
  utility::set_min_detect_range_darkness(var_b6b642cbeff52b88, var_d0f35fc0a5c3df79);
  utility::function_f3883fe06a11269(var_fac370d058479827, var_fb574b7959625bf0);
}

function function_f5233a1596031957() {
  hiddenranges["prone"] = 10000;
  hiddenranges["crouch"] = 10000;
  hiddenranges["stand"] = 10000;
  var_b6b642cbeff52b88["prone"] = 10000;
  var_b6b642cbeff52b88["crouch"] = 10000;
  var_b6b642cbeff52b88["stand"] = 10000;
  hiddenranges["shadow_prone"] = 0.05;
  hiddenranges["shadow_crouch"] = 0.05;
  hiddenranges["shadow_stand"] = 0.3;
  spottedranges["prone"] = 10000;
  spottedranges["crouch"] = 10000;
  spottedranges["stand"] = 10000;
  var_d0f35fc0a5c3df79["prone"] = 10000;
  var_d0f35fc0a5c3df79["crouch"] = 10000;
  var_d0f35fc0a5c3df79["stand"] = 10000;
  spottedranges["shadow_prone"] = 0.01;
  spottedranges["shadow_crouch"] = 0.02;
  spottedranges["shadow_stand"] = 0.38;
  var_8f3f480583606401["prone"] = 1.1;
  var_8f3f480583606401["crouch"] = 1.15;
  var_8f3f480583606401["stand"] = 1.2;
  var_fac370d058479827["prone"] = 0;
  var_fac370d058479827["crouch"] = 0;
  var_fac370d058479827["stand"] = 0;
  var_fb574b7959625bf0["prone"] = 0;
  var_fb574b7959625bf0["crouch"] = 0;
  var_fb574b7959625bf0["stand"] = 0;
  utility::set_detect_ranges(hiddenranges, spottedranges, var_8f3f480583606401);
  utility::set_min_detect_range_darkness(var_b6b642cbeff52b88, var_d0f35fc0a5c3df79);
  utility::function_f3883fe06a11269(var_fac370d058479827, var_fb574b7959625bf0);
}

function function_d7398803f3fe830() {
  level endon("game_ended");
  flag_wait("flag_dungeon_intro_complete");
  var_5528b06a2cfce7f9 = 0;

  while(true) {
    if(flag("flag_reactor_flow_start")) {
      return;
    }

    if(!var_5528b06a2cfce7f9 && function_3f51c5f6398bff45()) {
      var_5528b06a2cfce7f9 = 1;
      function_f9e5c241d348306a(1);
    } else if(var_5528b06a2cfce7f9 && !function_3f51c5f6398bff45()) {
      var_5528b06a2cfce7f9 = 0;
      function_f9e5c241d348306a(0);
    }

    waitframe();
  }
}

function function_f9e5c241d348306a(val) {
  if(istrue(val)) {
    thread function_26e3032a96ab06eb();
  }
}

function function_26e3032a96ab06eb() {
  level notify("red_alert_begin");
}

function function_83afcf8fb8074654() {
  var_a8c94c6fbf487517 = getEntArray("info_volume_stealth_all", "classname");
  var_f966d4c44e89606d = 0;

  foreach(vol in var_a8c94c6fbf487517) {
    if(!is_equal(vol.script_noteworthy, "chemical_stealth_vol")) {
      var_f966d4c44e89606d++;
      vol delete();
    }
  }
}

function function_ac9858751652fb9e(group_name, func) {
  if(isDefined(self.aitype) && issubstr("sniper", self.aitype)) {
    var_aca8515371f9cc5e = "jup_sandbox_sniper";
  }

  function_f98463d49e2f9067(var_aca8515371f9cc5e);
}

function function_292356e10af1286f(group_name, func) {
  function_ac9858751652fb9e(group_name, func);
  thread function_1308ec055ee61e28("flag_reactor_airlock_passed");
}

function function_bcbc82aba2ed13ba(var_fa74ae6b309d8263, var_fb0a5452dcbe0a97, var_607628a9dc547016) {
  level.player endon("death");
  self endon("death");
  var_1369e4f3de42d23f = getEnt(var_fa74ae6b309d8263, "targetname");
  var_4282d09b6ed41beb = getEnt(var_fb0a5452dcbe0a97, "targetname");
  var_ca9e2734703e3128 = getEnt(var_fb0a5452dcbe0a97, "targetname");

  while(!is_equal(self.alertlevel, "combat") && !is_equal(self.alertlevel, "alert")) {
    wait 1;
  }

  self.ignoresuppression = 1;
  self.disablebulletwhizbyreaction = 1;
  self.var_cbd87a0bc497b778 = 1;
  demeanor_override("sprint");
  set_movement_speed(255);
  self function_9f82c74eb1b7caf9(0);
  self endon("stop_hide_behavior");

  if(isDefined(level.player)) {
    event = spawnStruct();
    event.typeorig = "combat";
    event.type = "combat";
    event.origin = level.player.origin;
    event.investigate_pos = level.player.origin;
    self[[self.fnsetstealthstate]]("combat", event);
  }

  while(true) {
    self setgoalvolumeauto(var_4282d09b6ed41beb);
    self.dontevershoot = 0;
    wait 1;

    while(distance(self.origin, level.player.origin) < 3000) {
      wait 0.25;
    }

    self setgoalvolumeauto(var_1369e4f3de42d23f);
    self.dontevershoot = 1;
    wait 1;

    while(distance(self.origin, level.player.origin) > 3000) {
      wait 0.25;
    }
  }
}

function function_a3330ae8347c8089(var_1369e4f3de42d23f, var_ca9e2734703e3128) {
  self endon("death");
  level.player endon("death");

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon);

    if(is_equal(attacker, level.player)) {
      break;
    }
  }

  self notify("stop_hide_behavior");
  wait 0.25;
  self function_9f82c74eb1b7caf9(1);
  self.dontevershoot = 0;
  self setgoalvolumeauto(var_ca9e2734703e3128);
}

function function_f98463d49e2f9067(var_4f855452f4b35b26, override_damage_sight_range) {
  function_916233af1855619c();
  var_4f855452f4b35b26 = default_to(var_4f855452f4b35b26, "jup_sandbox");
  function_6afcdc96a6ce9a56(var_4f855452f4b35b26, &function_cc116388b57ace53);
  self.var_2626d6897d71b728 = 8000;
  self.var_7bd1c0edbaafb6e0 = "alert";

  if(isDefined(self.var_55cc71192b8f1931) && array_contains(self.var_55cc71192b8f1931, "dem_combat")) {
    self.var_7bd1c0edbaafb6e0 = "combat";
  }

  if(isDefined(self.spawner) && is_equal(self.spawner.targetname, "spray_zone_roof_ai")) {
    thread function_bcbc82aba2ed13ba("sniper_hideout_turbine", "sniper_vol_turbine", "sniper_engaged_vol_turbine");
    function_f3dbca0d61b23c79(2, 0);
    thread function_ba47f103a6b487de();
    thread function_24cf7f7c8828b3ad();
  } else if(isDefined(self.spawner) && is_equal(self.spawner.targetname, "parking_roof_ai")) {
    thread function_bcbc82aba2ed13ba("sniper_hideout_parking_lot", "sniper_vol_parking_lot", "sniper_engaged_vol_parking_lot");
    function_f3dbca0d61b23c79(3, 0);
    thread function_ba47f103a6b487de();
    thread function_24cf7f7c8828b3ad();
  }

  if(level.var_9df79069dfd8549b > 0 && !is_equal(self.script_stealthgroup, "reactor_ai")) {
    if(isDefined(level.player)) {
      self[[self.fnsetstealthstate]]("hunt");
    }
  }

  var_85d315c215abc9d0 = self getcurrentweapon();

  if(isDefined(var_85d315c215abc9d0)) {
    if(isDefined(self.spawner) && isDefined(self.spawner.script_laser) && self.spawner.script_laser == "1") {
      if(var_85d315c215abc9d0 canuseattachment("laserbox_ads05_cp_ai")) {
        newweapon = var_85d315c215abc9d0 withattachment("laserbox_ads05_cp_ai");

        if(isDefined(newweapon)) {
          slot = "primary";

          if(self.secondaryweapon == var_85d315c215abc9d0) {
            slot = "secondary";
          }

          if(self.lastweapon == var_85d315c215abc9d0) {
            self.lastweapon = newweapon;
          }

          scripts\anim\shared::detachweapon(var_85d315c215abc9d0);
          scripts\anim\shared::forceuseweapon(newweapon, slot);
          self.dropweapon = 0;
          thread function_44b8500225eefffd();
        }
      }
    }

    fullname = getcompleteweaponname(var_85d315c215abc9d0);

    if(issubstr(fullname, "rpapa7")) {
      thread function_8fdec6f44d407720();
    }
  }

  setdvarifuninitialized(@ "hash_42417cffcfb34e5", 0);

  if(isDefined(self.directorspawndata) && isDefined(self.directorspawndata.script_stealthgroup)) {
    thread namespace_9e536e4fbf2fc370::function_e6fc53e242f10d37(self.directorspawndata.script_stealthgroup, "<dev string:x1c2>");
    return;
  }

  if(isDefined(self.directorspawndata) && isDefined(self.script_stealthgroup)) {
    thread namespace_9e536e4fbf2fc370::function_e6fc53e242f10d37(self.directorspawndata.script_stealthgroup, "<dev string:x1c2>");
    return;
  }

  if(isDefined(self.script_stealthgroup)) {
    thread namespace_9e536e4fbf2fc370::function_e6fc53e242f10d37(self.script_stealthgroup, "<dev string:x1cb>");
    return;
  }

  if(isDefined(self.group)) {
    thread namespace_9e536e4fbf2fc370::function_e6fc53e242f10d37(self.group.group_name, "<dev string:x1d2>");
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

function function_ba47f103a6b487de() {
  var_82b4d7a8d775c747 = getEntArray("rooftop_ai_disable_callout", "targetname");
  var_2929436ec719f8ea = sortbydistance(var_82b4d7a8d775c747, self.origin)[0];
  var_dec7e238effce86a = getEnt(var_2929436ec719f8ea.target, "targetname");
  var_2929436ec719f8ea thread function_d60b9b58b4207be3("player_triggered");
  self endon("death");
  var_2929436ec719f8ea endon("player_triggered");

  while(true) {
    var_dec7e238effce86a waittill("trigger", ent);

    if(isDefined(ent) && isPlayer(ent)) {
      break;
    }
  }

  flag_set("flag_rooftop_guys_warning");
  thread flag_clear_delayed("flag_rooftop_guys_warning", 4);
}

function function_d60b9b58b4207be3(msg) {
  while(true) {
    self waittill("trigger", ent);

    if(isDefined(ent) && isPlayer(ent)) {
      break;
    }
  }

  self notify(msg);
}

function function_dcf4a6b2b7d0f74(group_name, func) {
  thread function_ac9858751652fb9e(group_name, func);
  thread function_65ec3da2c6d515fa();
  thread function_db0ff244a1eda638();
}

function function_db0ff244a1eda638() {
  thread function_8e21743cf2715e0c();
  thread function_5b062629bfd97a4f();
  self.var_4ebe755e0a0a430e = 0;

  if(function_68f8b8bd65b54d3("platform")) {
    thread function_a754c688118f823f();
  } else {
    level.var_d03989799d2951ee = array_add_safe(level.var_d03989799d2951ee, self);
  }

  if(function_68f8b8bd65b54d3("closest_hallway")) {
    level.var_ad5a3f41ddf7fa69 = self;
  }

  if(function_68f8b8bd65b54d3("closest_turbine")) {
    level.var_9451bbdc3d12c944 = self;
  }

  if(function_68f8b8bd65b54d3("closest_airlock")) {
    level.var_35e22cc912803ff0 = self;
    thread function_9f1adef75e92c9ec();
  }

  if(function_68f8b8bd65b54d3("meltyface")) {
    thread reactor_ai_meltyface("reactor_cover_meltyface");
  }

  function_c6ef2f19a4534194();
}

function function_8e21743cf2715e0c() {
  self endon("death");
  level endon("game_ended");
  wait 1;
  self.grenadeammo = 0;
}

function function_c6ef2f19a4534194() {
  if(flag("flag_reactor_combat_flow_areas_5")) {
    function_771d4a42b3957fdd(self);
    return;
  }

  if(flag("flag_reactor_combat_flow_areas_4")) {
    function_771d4942b3957daa(self);
    return;
  }

  if(flag("flag_reactor_combat_flow_areas_3")) {
    function_771d4442b39572ab(self);
    return;
  }

  if(flag("flag_reactor_combat_flow_areas_pit")) {
    function_5e1527c35161a24d(self);
    return;
  }

  if(flag("flag_reactor_combat_flow_areas_2")) {
    function_771d4342b3957078(self);
  }
}

function function_65ec3da2c6d515fa() {
  self endon("death");
  level endon("game_ended");
  self.ignoreall = 1;
  wait 1;
  function_bb5cab9eba6beb39();
  wait 1;
  self.ignoreall = 0;
}

function function_a754c688118f823f() {
  level.var_44a2219576a45ab2 = array_add_safe(level.var_44a2219576a45ab2, self);

  if(function_68f8b8bd65b54d3("slot1")) {
    self.var_ba11ffe36014857 = 1;
  } else if(function_68f8b8bd65b54d3("slot2")) {
    self.var_ba11ffe36014857 = 2;
  } else if(function_68f8b8bd65b54d3("slot3")) {
    self.var_ba11ffe36014857 = 3;
  } else {
    assertmsg("'Platform' AI does not have correct script_paramters kvp to denote its position on the pallet.");
  }

  self.ignoreall = 1;
  thread function_5192e065f1d6eb5f();
  thread function_860cd414d98539d();
  thread function_d504e96d7639dd3c();
  thread function_dc5e3e25a616ae5b();
  level flag_wait("vo_reactor_airlock_transition_complete");
  wait 1;
  self.ignoreall = 0;
  self.baseaccuracy *= 0;
  self.var_98add129a7ecb962 = 0;
  self.forceragdollimmediate = 1;
  self.skipdeathanim = 1;
}

function function_5192e065f1d6eb5f() {
  level endon("game_over");
  self endon("death");
  level flag_wait("flag_pallet_first_frame_set");
  self.var_ef1b479538822707 = level.var_c2cc8fd9e98e11b4[self.var_ba11ffe36014857];

  switch (self.var_ba11ffe36014857) {
    case 1:
      assign_animtree("pallet_enemy1");
      self.var_db7e8c0fe30dea7a = "enemy03_fall";
      break;
    case 2:
      assign_animtree("pallet_enemy2");
      self.var_db7e8c0fe30dea7a = "enemy01_fall";
      break;
    case 3:
      assign_animtree("pallet_enemy4");
      self.var_db7e8c0fe30dea7a = "enemy02_fall";
      break;
  }

  self.var_ef1b479538822707 thread anim_loop_solo(self, "pallet_enemy_precombat", "end_pallet_ai_loop");
  self.var_a049739747b7ae2c = spawn_script_origin(self.origin, self.angles);

  if(getdvarint(@ "hash_4a703a5d3849593b", 0) == 0 && function_68f8b8bd65b54d3("tier3")) {
    self.var_a049739747b7ae2c linkTo(self.var_ef1b479538822707);
    waitframe();
    self.var_ef1b479538822707 notify("end_pallet_ai_loop");
    scripts\asm\shared\mp\utility::cancelanimscriptmp();
    wait 2;
    self.angles = self.var_a049739747b7ae2c.angles;
    self.origin = self.var_a049739747b7ae2c.origin;
    self linkTo(self.var_a049739747b7ae2c);
    return;
  }

  self.var_a049739747b7ae2c linkTo(self.var_ef1b479538822707);
  self linkTo(self.var_a049739747b7ae2c);
}

function function_d504e96d7639dd3c() {
  level endon("game_ended");
  self endon("death");
  level waittill("enemy_sync");
  level_archetype = "agent_scripted_" + getDvar(@ "g_mapname");
  animation = level.scr_anim[self.animname]["pallet_enemy_fall"];
  angles = getstartangles(self.var_ef1b479538822707.origin, self.var_ef1b479538822707.angles, animation);
  forward = anglesToForward(angles);
  targetpos = self.var_ef1b479538822707.origin + forward * 100 + (0, 0, 45);
  var_7e2271ad57a2f0bc = spawn("script_origin", targetpos);
  var_7e2271ad57a2f0bc linkTo(self.var_ef1b479538822707);
  self.smartfacingpos = targetpos;
  self setentitytarget(var_7e2271ad57a2f0bc, 1);
  self.favoriteenemy = var_7e2271ad57a2f0bc;
  self forcethreatupdate();
}

function function_dc5e3e25a616ae5b() {
  level endon("game_ended");
  self endon("death");

  while(!isDefined(self.var_db7e8c0fe30dea7a)) {
    waitframe();
  }

  level waittill(self.var_db7e8c0fe30dea7a);
  self.var_ef1b479538822707 thread anim_single_solo(self, "pallet_enemy_fall");
  anim_entry = getanim("pallet_enemy_fall");
  total_time = getanimlength(anim_entry);
  wait total_time - 0.2;
  self.var_ef1b479538822707 unlink();
  self.forceragdollimmediate = 1;
  self.ragdoll_directionscale = 0;
  self.ragdoll_damagelocation_none = "torso_lower";
  self kill();
}

function function_860cd414d98539d(var_cee406289409e85f) {
  level endon("game_over");
  self endon("death");

  if(riotshield_hasweapon()) {
    thread function_1e8fe6c50926c65();
  }

  if(!istrue(var_cee406289409e85f)) {
    level flag_wait("reactor_combat_start");
  }

  self.var_ef1b479538822707 notify("end_pallet_ai_loop");
  scripts\asm\shared\mp\utility::cancelanimscriptmp();
  waitframe();

  if(getdvarint(@ "hash_4a703a5d3849593b", 0) == 1 || !function_68f8b8bd65b54d3("tier3")) {
    self.var_ef1b479538822707 anim_single_solo(self, "pallet_enemy_precombat_exit");
  }

  self unlink();
  waitframe();
  waitframe();
  self cleargoalvolume();

  if(!riotshield_hasweapon()) {
    self clearentitytarget();
  }

  self.goalradius = 1;
  self.grenadeammo = 0;
  thread function_8e21743cf2715e0c();
  self.pushable = 0;
  self.var_4ebe755e0a0a430e = 0;
  self.var_c833409fb72d15fb = 1;

  if(function_68f8b8bd65b54d3("tier3")) {
    self allowedstances("stand");
  } else {
    self allowedstances("crouch");
  }

  self.ignoreall = 0;
  function_e0c4ac89ea300c5f();
}

function function_1e8fe6c50926c65() {
  level.player endon("death");

  while(!isDefined(self.var_ef1b479538822707)) {
    waitframe();
  }

  forward = anglesToForward(self.angles);
  targetpos = self.origin + forward * 100 + (0, 0, 50);
  var_7e2271ad57a2f0bc = spawn("script_origin", targetpos);
  var_7e2271ad57a2f0bc linkTo(self.var_ef1b479538822707);
  self.smartfacingpos = targetpos;
  self setentitytarget(var_7e2271ad57a2f0bc, 0.9);
  self.favoriteenemy = var_7e2271ad57a2f0bc;
  self forcethreatupdate();
  self.goalradius = 1;
  self.dontevershoot = 1;
  self.var_c833409fb72d15fb = 1;
  level flag_wait("reactor_combat_start");
  waitframe();
  self.favoriteenemy = level.player;
  self.dontevershoot = 0;
  self forcethreatupdate();
}

function function_1e7d4ed4a57ca9ea(var_3980aa4abc4b91d7, time) {
  level endon("game_over");
  self endon("death");
  level flag_wait(var_3980aa4abc4b91d7);

  if(isDefined(time)) {
    wait time;
  }

  self kill();
}

function function_88f30aa2664262fe(group_name, func) {
  function_916233af1855619c();
  level.var_d03989799d2951ee = array_add_safe(level.var_d03989799d2951ee, self);
  level.var_841cae3f1e141ba7 = array_add_safe(level.var_841cae3f1e141ba7, self);
  self.aggressivemode = 1;
  thread function_8e21743cf2715e0c();
  thread function_5b062629bfd97a4f();
  thread function_1a0068261e86423();

  if(function_68f8b8bd65b54d3("meltyface")) {
    thread reactor_ai_meltyface("reactor_cover_meltyface");
  } else if(function_68f8b8bd65b54d3("platform1_wave1")) {
    thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_midplaform_lower"));
  } else if(function_68f8b8bd65b54d3("platform1_wave2")) {
    thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_midplaform_upper"));
  } else if(function_68f8b8bd65b54d3("platform2_wave1")) {
    thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_highplaform_wave1"));
  } else if(function_68f8b8bd65b54d3("platform2_wave2")) {
    thread function_7d160926856917b1(function_1c4d592029f2b0d3("choreo_reactor_highplaform_wave2"));
  }

  function_c6ef2f19a4534194();
  thread function_e0c4ac89ea300c5f();
}

function function_e0c4ac89ea300c5f() {
  waitframe();

  if(flag("flag_allies_spawned")) {
    tf141 = random(level.allies);
    self aieventlistenerevent("combat", tf141, tf141.origin);
    return;
  }

  self aieventlistenerevent("combat", level.player, level.player.origin);
}

function function_1a0068261e86423() {
  self waittill("death");
  level.var_4c146c812ce90c91 = gettime();
}

function function_1b380ad1840cf139() {
  level.var_42b1a90dc7f6d180 = function_6149b301ce19988b("reactor_ai", &function_dcf4a6b2b7d0f74);
}

function function_76bf10ddef9a355c() {
  function_6149b301ce19988b("reactor_pit_closet_ai", &function_88f30aa2664262fe);
}

function function_972b9649d28a5f7a(minwait) {
  level endon("game_ended");
  level endon("flag_allies_spawned");
  level endon("flag_p1w1_started");
  level endon("flag_p1w2_started");
  level endon("flag_p2w1_started");
  level endon("flag_p2w2_started");
  wait minwait;

  if(level.player istouching(function_1c4d592029f2b0d3("reactor_floor3_enemies_playerpositioncheck"))) {
    function_6149b301ce19988b("reactor_floor3_wave1_ai_alt", &function_88f30aa2664262fe);
  } else {
    function_6149b301ce19988b("reactor_floor3_wave1_ai", &function_88f30aa2664262fe);
  }

  iprintlnbold("<dev string:x1da>");

  level flag_set("flag_f3w1_started");
  level thread flag_set_delayed("flag_f3w1_spawned", 0.5);
  level thread flag_set_delayed("vo_reactor_konniwaves_begin", 0);
  wait 1;
  level thread flag_set_delayed("flag_f3w2_spawned", 0.5);
}

function spawn_ais_reactor_platform1_wave2(delay) {
  level endon("game_ended");
  level endon("flag_allies_spawned");
  level endon("flag_p2w1_started");
  level endon("flag_p2w2_started");
  level thread function_66ec16347df1ce11("flag_f3w2_spawned", 1, "spawn_ais_reactor_platform1_wave2");
  level thread notify_delay("spawn_ais_reactor_platform1_wave2", delay);
  level waittill("spawn_ais_reactor_platform1_wave2");

  iprintlnbold("<dev string:x1f0>");

  level flag_set("flag_p1w2_started");
  function_6149b301ce19988b("reactor_platform1_wave2_ai", &function_88f30aa2664262fe);
  level thread flag_set_delayed("flag_p1w2_spawned", 0.5);
  level thread flag_set_delayed("vo_reactor_konniwaves_2", 0);
  wait 1;
  function_a1d04bd7839d30ad(2);
  level flag_set("vo_reactor_konniwaves_2_part_2");
  function_6149b301ce19988b("reactor_platform1_wave2b_ai", &function_88f30aa2664262fe);
  level flag_set("flag_p1w2_finished");
}

function spawn_ais_reactor_platform2_wave1(delay) {
  level endon("game_ended");
  level endon("flag_allies_spawned");
  level thread function_66ec16347df1ce11("flag_p1w2_spawned", 1, "spawn_ais_reactor_platform2_wave1");
  level thread notify_delay("spawn_ais_reactor_platform2_wave1", delay);
  level waittill("spawn_ais_reactor_platform2_wave1");

  iprintlnbold("<dev string:x209>");

  level flag_set("flag_p2w1_started");
  function_6149b301ce19988b("reactor_platform2_wave1_ai", &function_88f30aa2664262fe);
  level flag_set("flag_p2w1_finished");
  level thread flag_set_delayed("vo_reactor_konniwaves_3", 0);
  wait 1;
  function_a1d04bd7839d30ad(2);
  level thread function_399465c47643b9cb();
}

function function_399465c47643b9cb(delay) {
  level endon("flag_allies_spawned");

  iprintlnbold("<dev string:x222>");

  level flag_set("flag_p2w2_started");
  function_6149b301ce19988b("reactor_platform2_wave2_ai", &function_88f30aa2664262fe);
  thread namespace_11fae4a66a43bd3f::function_588af84fad23df23("cp_jup_chemical_sfx_exfil");
  wait 2;
  function_a1d04bd7839d30ad(5);
  level flag_set("reactor_cough_near_end");
  function_a1d04bd7839d30ad(3);
  level flag_set("reactor_wave_combat_wrapup");
}

function function_ad7caabc33076f6a() {
  level endon("game_ended");
  level.player endon("death");
  level thread function_55e1a2ecac50dde4();
  level thread function_cd923d3d013dd6ca(0);
  level thread function_f3f29122ef5a692c();
  level flag_wait("flag_meltyface_spawn_triggered");

  iprintlnbold("<dev string:x23b>");

  function_6149b301ce19988b("reactor_ai_meltyface", &function_88f30aa2664262fe);
  level flag_set("flag_meltyface_spawned");
}

function function_55e1a2ecac50dde4() {
  level endon("game_ended");
  level.player endon("death");
  level flag_wait("flag_reactor_combat_flow_areas_3");
  wait 50;
  level flag_set("flag_meltyface_spawn_triggered");
}

function function_cd923d3d013dd6ca(mindelay) {
  level endon("game_ended");
  level.player endon("death");
  level endon("flag_meltyface_spawned");
  var_adf014b49cb5050 = function_1c4d592029f2b0d3("vol_reactor_meltyface_exclusion");
  var_d8cd79bfc29739d5 = function_1c4d592029f2b0d3("vol_reactor_stairs_upper");
  var_34b4e3ea5cb05ec3 = function_1c4d592029f2b0d3("vol_reactor_stairs_upper_pre");

  while(true) {
    waitframe();

    if(level.player istouching(var_adf014b49cb5050)) {
      var_385f90edc1eb0c8b = 1;
      continue;
    }

    if(istrue(var_385f90edc1eb0c8b)) {
      if(level.player istouching(var_d8cd79bfc29739d5)) {
        continue;
      }
    }

    var_385f90edc1eb0c8b = 0;

    if(flag("flag_gas_effects_started")) {
      if(level.player istouching(var_d8cd79bfc29739d5)) {
        level flag_set("flag_meltyface_spawn_triggered");
      }

      continue;
    }

    if(level.player istouching(var_34b4e3ea5cb05ec3)) {
      level flag_set("flag_meltyface_spawn_triggered");
    }
  }
}

function function_f3f29122ef5a692c() {
  level endon("game_ended");
  level.player endon("death");
  level endon("flag_meltyface_spawned");
  level flag_wait("flag_p2w2_started");
  level flag_set("flag_meltyface_spawn_triggered");
}

function function_a1d04bd7839d30ad(num, endon_notify) {
  if(isDefined(endon_notify)) {
    level endon(endon_notify);
  }

  while(level.var_d03989799d2951ee.size > num) {
    level.var_d03989799d2951ee = function_fdc9d5557c53078e(level.var_d03989799d2951ee);
    level.var_d03989799d2951ee = function_e183d373f385fbe(level.var_d03989799d2951ee);
    waitframe();
  }
}

function function_e78fa12c0460cf5b(num, delay, notify_string) {
  level thread notify_delay(notify_string, delay);
  function_a1d04bd7839d30ad(num, notify_string);
}

function function_e789d17814339f92(num, notify_string) {
  level endon(notify_string);
  function_a1d04bd7839d30ad(num, notify_string);
  level notify(notify_string);
}

function function_66ec16347df1ce11(flag_string, num, notify_string) {
  level endon(notify_string);
  level flag_wait(flag_string);
  function_e789d17814339f92(num, notify_string);
}

function function_2ac0170535694144() {
  if(!flag("flag_reactor_airlock_passed")) {
    level.var_ae387dac8e414d95 = function_6149b301ce19988b("spray_zone_roof_ai", &function_292356e10af1286f);
  }
}

function function_776d1112874496ce() {
  if(!flag("flag_reactor_airlock_passed")) {
    level.var_71cc4d36ef542471 = function_6149b301ce19988b("parking_roof_ai", &function_292356e10af1286f);
  }
}

function get_closest(structs, org, min_dist) {
  structs = sortbydistance(structs, org);

  foreach(struct in structs) {
    if(distance(struct.origin, org) > min_dist) {
      return struct;
    }
  }
}

function function_4702b4ddce11b678() {
  nearest_ai = function_d0b6fd4fc2332c8c(undefined, 3);

  if(!isDefined(nearest_ai)) {
    return 0;
  }

  dist = distance(level.player.origin, nearest_ai.origin);

  if(dist > 1500) {
    return 0;
  }

  return 1;
}

function function_35bad718eb8e9a88() {}

function function_57661187a22eb553() {
  flag_wait("checkpoint_data_retrieved");
  flag_wait("player_spawned_with_loadout");
  function_66d2ad9b363f899b();

  if(flag("flag_reactor_room_entered")) {
    return;
  }

  function_5350c310ac0a490(28);
  setDvar(@ "hash_c5a52a0ae6ed1529", 4000);
  setDvar(@ "hash_9f4f1e52992402ae", 0.05);
  setDvar(@ "hash_2295322ffd8d09a2", 1);
  setDvar(@ "hash_96955f67517b7611", 1);
  setDvar(@ "hash_96b8716751a1e55f", 500);
  setDvar(@ "hash_fb8a73964c11820b", 1);
  setDvar(@ "hash_ef8f1a26fbaa7569", 1);
  level.containment_combat_vol = getEnt("containment_combat_vol", "targetname");
  level.spray_zone_combat_vol = getEnt("spray_zone_combat_vol", "targetname");
  level.parking_combat_vol = getEnt("parking_combat_vol", "targetname");
  level.var_f25fd3ca74044795 = getEntArray("spray_zone_initial_combat_vol", "targetname");
  level.var_8ed22534caf9fe03 = getEntArray("parking_initial_combat_vol", "targetname");
  level.var_92f0e14848b8f1cb = getEntArray("containment_initial_combat_vol", "targetname");
  function_c7f30c19a0e960af();
  function_899c71787d4e9d7f();
  director_init();

  if(getdvarint(@ "hash_915f414d0088a340", 0) == 0) {
    process_create_script();
  }

  function_e4a440552e4cf1f4(&function_42168064f6ef466d);
  var_9b42d00ad7b19919 = ["jltv_enc_heli_1_a", "jltv_enc_heli_1_b", "jltv_enc_heli_2_a", "jltv_enc_heli_2_b", "jltv_enc_heli_3_a", "jltv_enc_heli_3_b", "backup_heli_enc_heli_1", "backup_heli_enc_heli_2", "backup_heli_enc_heli_3"];

  foreach(encounter in var_9b42d00ad7b19919) {
    var_e20078a12c00d86 = scripts\cp_mp\agents\ai_spawn_director::function_930897c0d1a7eb24(encounter);
    function_fc38783a3da0bc71(var_e20078a12c00d86, 0);
  }

  var_e4a95e7785318c5c = scripts\cp_mp\agents\ai_spawn_director::function_930897c0d1a7eb24("heli_pad_a_enc_2");
  scripts\cp_mp\agents\ai_spawn_director::function_7a2920be35f4386(var_e4a95e7785318c5c, &function_50bd8bf629a4b04a, self);
  var_c2c5c3fad535ef64 = scripts\cp_mp\agents\ai_spawn_director::function_930897c0d1a7eb24("parkinglot_enc_sideB");
  scripts\cp_mp\agents\ai_spawn_director::function_7a2920be35f4386(var_c2c5c3fad535ef64, &function_4c3f56ca5e102562, self);
  var_a5e16a86e2fed6b6 = scripts\cp_mp\agents\ai_spawn_director::function_930897c0d1a7eb24("heli_pad_b_enc_3");
  scripts\cp_mp\agents\ai_spawn_director::function_7a2920be35f4386(var_a5e16a86e2fed6b6, &function_88793babe0c59e6c, self);

  if(level.checkpoint_reached) {
    scripts\cp_mp\agents\ai_spawn_director::function_9950e6e485bf5261(var_e4a95e7785318c5c, 0);
    scripts\cp_mp\agents\ai_spawn_director::function_9950e6e485bf5261(var_c2c5c3fad535ef64, 0);
    scripts\cp_mp\agents\ai_spawn_director::function_9950e6e485bf5261(var_a5e16a86e2fed6b6, 0);
    var_8edd56a2e59d5a22 = scripts\cp_mp\agents\ai_spawn_director::function_930897c0d1a7eb24("parking_lot_enc_front_2");
    scripts\cp_mp\agents\ai_spawn_director::function_9950e6e485bf5261(var_8edd56a2e59d5a22, 0);

    if(level.checkpoint == "obj_enterReactor_complete") {
      function_cb4550bbf3d97200();
    }
  }

  level thread function_54f49c0fe991ea6d();
  level thread function_1e88241f646aa6a4();
  flag_wait("flag_obj_helis_setup");
  level.var_4caf3ce302e3487a = &namespace_a3ae8fde81bd3c08::function_9114105b6ad6f6fa;
  flag_set("director_ready");
  wait 0.5;
  level thread function_7bdddb0247e943a3();
  level thread function_1be90f9ef96b6ca9();
  level thread function_e8ef5fb4d11527d();
}

function function_5350c310ac0a490(value) {
  level.var_8f3a60eb4ebbbb7 = value;
  percent = level.var_8f3a60eb4ebbbb7 / 50;
  setDvar(@ "hash_692361d51eb88bd3", percent);
  setDvar(@ "hash_88575482d4198e91", percent);
}

function function_1935a6dd81703016(value) {
  if(!isDefined(value)) {
    value = 1;
  }

  level.var_8f3a60eb4ebbbb7 += value;

  if(level.var_8f3a60eb4ebbbb7 > 35) {
    level.var_8f3a60eb4ebbbb7 = 35;
  }

  percent = level.var_8f3a60eb4ebbbb7 / 50;
  setDvar(@ "hash_692361d51eb88bd3", percent);
  setDvar(@ "hash_88575482d4198e91", percent);
}

function function_24cf7f7c8828b3ad() {
  self waittill("death");
  function_1935a6dd81703016(1);
}

function function_9a2f396c1be344d9() {
  if(!isDefined(level.var_3ae5f7de11d142f)) {
    return;
  }

  var_bba1055b41e2619 = ["heli_pad_a_enc_2", "parkinglot_enc_sideB", "heli_pad_b_enc_3", "reactor_approach_ambient_entrance_ext_001_enc", "reactor_approach_ambient_29_enc", "reactor_approach_ambient_61_enc", "turbine_building_enc", "reactor_approach_ambient_60_enc", "reactor_approach_ambient_59_enc", "reactor_approach_ambient_58_enc", "reactor_approach_ambient_57_enc", "reactor_approach_ambient_56_enc"];

  foreach(encounter_name in var_bba1055b41e2619) {
    encounter = scripts\cp_mp\agents\ai_spawn_director::function_930897c0d1a7eb24(encounter_name);
    scripts\cp_mp\agents\ai_spawn_director::function_9950e6e485bf5261(encounter, 0);
    waitframe();
  }
}

function function_cb4550bbf3d97200() {
  var_87a2880f198d9abe = scripts\cp_mp\agents\ai_spawn_director::function_930897c0d1a7eb24("reactor_approach_ambient_entrance_ext_001_enc");
  scripts\cp_mp\agents\ai_spawn_director::function_9950e6e485bf5261(var_87a2880f198d9abe, 0);
  var_d80bc535326ae1e4 = scripts\cp_mp\agents\ai_spawn_director::function_930897c0d1a7eb24("reactor_approach_ambient_29_enc");
  scripts\cp_mp\agents\ai_spawn_director::function_9950e6e485bf5261(var_d80bc535326ae1e4, 0);
  var_d80bc635326ae417 = scripts\cp_mp\agents\ai_spawn_director::function_930897c0d1a7eb24("reactor_approach_ambient_61_enc");
  scripts\cp_mp\agents\ai_spawn_director::function_9950e6e485bf5261(var_d80bc635326ae417, 0);
  var_d80bc335326add7e = scripts\cp_mp\agents\ai_spawn_director::function_930897c0d1a7eb24("turbine_building_enc");
  scripts\cp_mp\agents\ai_spawn_director::function_9950e6e485bf5261(var_d80bc335326add7e, 0);
  var_d80bc435326adfb1 = scripts\cp_mp\agents\ai_spawn_director::function_930897c0d1a7eb24("reactor_approach_ambient_60_enc");
  scripts\cp_mp\agents\ai_spawn_director::function_9950e6e485bf5261(var_d80bc435326adfb1, 0);
  var_d80bc135326ad918 = scripts\cp_mp\agents\ai_spawn_director::function_930897c0d1a7eb24("reactor_approach_ambient_59_enc");
  scripts\cp_mp\agents\ai_spawn_director::function_9950e6e485bf5261(var_d80bc135326ad918, 0);
  var_d80bc235326adb4b = scripts\cp_mp\agents\ai_spawn_director::function_930897c0d1a7eb24("reactor_approach_ambient_56_enc");
  scripts\cp_mp\agents\ai_spawn_director::function_9950e6e485bf5261(var_d80bc235326adb4b, 0);
  var_d80bbf35326ad4b2 = scripts\cp_mp\agents\ai_spawn_director::function_930897c0d1a7eb24("reactor_approach_ambient_57_enc");
  scripts\cp_mp\agents\ai_spawn_director::function_9950e6e485bf5261(var_d80bbf35326ad4b2, 0);
  var_d80bc035326ad6e5 = scripts\cp_mp\agents\ai_spawn_director::function_930897c0d1a7eb24("reactor_approach_ambient_58_enc");
  scripts\cp_mp\agents\ai_spawn_director::function_9950e6e485bf5261(var_d80bc035326ad6e5, 0);
}

function function_4b696397b1abb4d() {
  all_structs = level.struct_class_names["targetname"];
  filtered_structs = [];

  foreach(struct_array in all_structs) {
    foreach(struct in struct_array) {
      if(!isDefined(struct.interaction) || is_equal(struct.interaction, "interaction") || !isDefined(struct.targetname)) {
        continue;
      }

      var_5a2a5dc9ae4fe33f = getStructArray(struct.targetname, "target");

      if(isDefined(var_5a2a5dc9ae4fe33f[0]) && is_equal(var_5a2a5dc9ae4fe33f[0].script_noteworthy, "ai_encounter_patrol_point")) {
        filtered_structs = array_add(filtered_structs, struct);
      }
    }
  }

  return filtered_structs;
}

function function_899c71787d4e9d7f() {
  interaction_structs = function_4b696397b1abb4d();
  var_dabab34914d33698 = 0;

  foreach(interaction_struct in interaction_structs) {
    var_dabab34914d33698++;
    var_ad733c5b52ab4d13 = "targeted_act_" + var_dabab34914d33698;
    var_d5e6f5fd431414d6 = spawnStruct();
    var_d5e6f5fd431414d6.angles = interaction_struct.angles;
    var_d5e6f5fd431414d6.var_912df596f9f4417f = "1";
    var_d5e6f5fd431414d6.max_wait_time = "0";
    var_d5e6f5fd431414d6.var_acaed5eee748b3f = "0";
    var_d5e6f5fd431414d6.script_delay = float(interaction_struct.script_delay);
    var_d5e6f5fd431414d6.move_speed = "1";
    var_d5e6f5fd431414d6.origin = interaction_struct.origin;
    var_d5e6f5fd431414d6.script_noteworthy = "ai_encounter_patrol_point";
    var_d5e6f5fd431414d6.spawn_filter = "none";
    var_d5e6f5fd431414d6.target = interaction_struct.target;
    var_d5e6f5fd431414d6.targetname = interaction_struct.targetname;
    var_d5e6f5fd431414d6.script_faceangles = interaction_struct.script_faceangles;

    if(isDefined(interaction_struct.script_delay) && float(interaction_struct.script_delay) >= 999) {
      var_d5e6f5fd431414d6.repeat_interaction = 1;
    }

    var_d5e6f5fd431414d6.var_8e71cc2e3851e67c = var_ad733c5b52ab4d13;
    addstruct(var_d5e6f5fd431414d6);
    interaction_struct.targetname = var_ad733c5b52ab4d13;
    interaction_struct.ai_interaction = interaction_struct.interaction;
    interaction_struct.cooldownoverride = "-1";
    interaction_struct.script_noteworthy = "info_act";
    deletestruct_ref(interaction_struct);
    addstruct(interaction_struct);
  }

  var_5d71ac440a47959a = getStructArray("interaction", "targetname");
  var_5c670d8892838cab = 0;

  foreach(struct in var_5d71ac440a47959a) {
    if(!isDefined(struct.script_linkto)) {
      continue;
    }

    struct.ai_interaction = struct.interaction;
    struct.cooldownoverride = "-1";
    struct.script_noteworthy = "info_act";
    var_ad733c5b52ab4d13 = "linked_act_" + var_5c670d8892838cab;
    var_5c670d8892838cab++;
    struct.targetname = var_ad733c5b52ab4d13;
    var_7f03a0fa852966df = struct get_linked_structs();

    foreach(var_d5e6f5fd431414d6 in var_7f03a0fa852966df) {
      var_d5e6f5fd431414d6.var_8e71cc2e3851e67c = var_ad733c5b52ab4d13;
      var_d5e6f5fd431414d6.script_faceangles = struct.script_faceangles;
      deletestruct_ref(var_d5e6f5fd431414d6);
      addstruct(var_d5e6f5fd431414d6);
    }

    deletestruct_ref(struct);
    addstruct(struct);
  }
}

function function_54f49c0fe991ea6d() {
  if(flag("infil_player_landed")) {
    return;
  }

  var_281872cdabcd948e = getStructArray("intro_view_loc", "targetname");
  var_fe65d22c115e3490 = [];

  foreach(var_4b55427cf47b9749 in var_281872cdabcd948e) {
    var_d8073eea3210448e = function_e8998001a61385c6(var_4b55427cf47b9749.origin, 0, 1);
    var_fe65d22c115e3490 = array_add(var_fe65d22c115e3490, var_d8073eea3210448e);
  }

  thread function_effab132f72847b1();
  flag_wait_either("infil_player_landed", "flag_player_close_to_ground");

  foreach(var_d8073eea3210448e in var_fe65d22c115e3490) {
    function_2e1bf251fd0d7853(var_d8073eea3210448e);
    waitframe();
  }
}

function function_effab132f72847b1() {
  trig = getEnt("nearing_ground_trig", "targetname");
  trig waittill("trigger");
  flag_set("flag_player_close_to_ground");
}

function function_1e88241f646aa6a4() {
  thread function_dc4056eea98d12aa("high_vantage_trigger", "flag_player_in_high_vantage");
  var_281872cdabcd948e = getStructArray("high_vantage_view_loc", "targetname");

  while(true) {
    flag_wait("flag_player_in_high_vantage");
    var_fe65d22c115e3490 = [];

    foreach(var_4b55427cf47b9749 in var_281872cdabcd948e) {
      var_d8073eea3210448e = function_e8998001a61385c6(var_4b55427cf47b9749.origin, 0, 1);
      var_fe65d22c115e3490 = array_add(var_fe65d22c115e3490, var_d8073eea3210448e);
    }

    flag_set("flag_ai_extreme_range_enabled");
    function_f5233a1596031957();
    wait 0.1;
    flag_waitopen("flag_player_in_high_vantage");

    foreach(var_d8073eea3210448e in var_fe65d22c115e3490) {
      function_2e1bf251fd0d7853(var_d8073eea3210448e);
      waitframe();
    }

    flag_clear("flag_ai_extreme_range_enabled");
    function_4cb0815e5108998c();
  }
}

function function_50bd8bf629a4b04a(requestid, userdata, wavenumber) {
  return function_a4a91b66a71a0b07("heli_containment_group", wavenumber);
}

function function_4c3f56ca5e102562(requestid, userdata, wavenumber) {
  return function_a4a91b66a71a0b07("parking_lot", wavenumber);
}

function function_88793babe0c59e6c(requestid, userdata, wavenumber) {
  return function_a4a91b66a71a0b07("heli_spray_zone_group", wavenumber);
}

function function_a4a91b66a71a0b07(stealth_group, wavenumber) {
  if(flag("flag_reactor_airlock_passed")) {
    return false;
  }

  if(!flag("flag_sustained_combat_active")) {
    return false;
  }

  var_dadb1301ff5910ca = 0;

  if(wavenumber == 0) {
    var_dadb1301ff5910ca = 1;
  } else {
    return false;
  }

  player_kills = function_a0afdc88b4bb5b9f(stealth_group);
  var_3c382773a0f13b0d = player_kills >= var_dadb1301ff5910ca;

  if(!var_3c382773a0f13b0d) {
    return false;
  }

  if(!function_24e6434a5985d5ec(stealth_group)) {
    function_3d8ebc497f38dec5(stealth_group);
  }

  var_195f6fea4d6234fe = function_a824b95a996ba5c9(stealth_group);

  if(!isDefined(var_195f6fea4d6234fe)) {
    iprintlnbold("<dev string:x245>" + stealth_group + "<dev string:x258>" + wavenumber + "<dev string:x285>");

    return false;
  }

  if(var_195f6fea4d6234fe <= wavenumber) {
    return false;
  }

  return true;
}

function function_3d8ebc497f38dec5(stealth_group) {
  if(!isDefined(level.var_2fc5d0aa34420526)) {
    level.var_2fc5d0aa34420526 = [];
  }

  if(!isDefined(level.var_e8a4ac8bae603187)) {
    level.var_e8a4ac8bae603187 = 1;
  }

  level.var_2fc5d0aa34420526[stealth_group] = level.var_e8a4ac8bae603187;
  level.var_e8a4ac8bae603187++;
}

function function_a824b95a996ba5c9(stealth_group) {
  if(!function_24e6434a5985d5ec(stealth_group)) {
    return 999;
  }

  return level.var_2fc5d0aa34420526[stealth_group];
}

function function_24e6434a5985d5ec(stealth_group) {
  if(!isDefined(level.var_2fc5d0aa34420526) || !isDefined(level.var_2fc5d0aa34420526[stealth_group])) {
    return false;
  }

  return true;
}

function function_7bdddb0247e943a3() {
  level thread function_9aa04ce7618a1a63(2, "heli_spray_zone_group");
  level thread function_8395ae3d9fc900cf(2);
  level thread function_ed81631597ed2172(2);
  level thread function_47f9161df3ed9965("flag_director_ai_cleared_" + 2, "heli_spray_zone_group", 9);
}

function function_1be90f9ef96b6ca9() {
  level thread function_9aa04ce7618a1a63(3, "parking_lot");
  level thread function_8395ae3d9fc900cf(3);
  level thread function_ed81631597ed2172(3);
  level thread function_47f9161df3ed9965("flag_director_ai_cleared_" + 3, "parking_lot", 12);
}

function function_e8ef5fb4d11527d() {
  level thread function_9aa04ce7618a1a63(1, "heli_containment_group");
  level thread function_8395ae3d9fc900cf(1);
  level thread function_ed81631597ed2172(1);
  level thread function_47f9161df3ed9965("flag_director_ai_cleared_" + 1, "heli_containment_group", 10);
}

function function_f1b101a8413b3c69() {
  flag_wait("player_spawned_with_loadout");
  var_168cd8307a3f8807 = function_606f53b43c800acd(level.player.origin);
  flag_set("flag_spawn_jltv_backup_" + var_168cd8307a3f8807);
}

function function_c33318b57c67b04a(var_c8944865a6dade2f, var_168cd8307a3f8807, var_de8c65d9a1d88852) {
  var_16afcb307a65b328 = function_74158609fd64a01f(var_168cd8307a3f8807, 1);
  var_16afcb307a65b328 = array_exclude(var_16afcb307a65b328, var_de8c65d9a1d88852);
  size = min(var_c8944865a6dade2f, var_16afcb307a65b328.size);
  group = [];

  for(i = 0; i < size; i++) {
    if(group.size == 0) {
      guy = random(var_16afcb307a65b328);
    } else {
      var_a7ed23226a79c279 = group[0];
      guy = sortbydistance(var_16afcb307a65b328, var_a7ed23226a79c279.origin)[0];
    }

    var_16afcb307a65b328 = array_remove(var_16afcb307a65b328, guy);
    group[group.size] = guy;
  }

  return group;
}

function function_43167803e92961ea(ai_group, timeout) {
  var_a885a007edb35c43 = gettime() + timeout * 1000;

  while(true) {
    wait 1;

    if(gettime() > var_a885a007edb35c43) {
      return;
    }

    ai_group = array_removedead_or_dying(ai_group);

    if(ai_group.size == 0) {
      return;
    }
  }
}

function function_aa53a3a0d655cc7e(ai_group) {
  while(true) {
    wait 1;
    ai_group = array_removedead_or_dying(ai_group);

    if(ai_group.size == 0) {
      return;
    }
  }
}

function function_86936065b6341f67(var_168cd8307a3f8807) {
  var_dc907aef29b80101 = "";

  switch (var_168cd8307a3f8807) {
    case 1:
      var_dc907aef29b80101 = "containment_heli_org";
      break;
    case 3:
      var_dc907aef29b80101 = "parking_lot_heli_org";
      break;
    case 2:
      var_dc907aef29b80101 = "spray_zone_heli_org";
      break;
  }

  heli_org = function_7a18da6e48b71c35(var_dc907aef29b80101);
  return heli_org;
}

function function_2149a449f40a0515(var_168cd8307a3f8807) {
  switch (var_168cd8307a3f8807) {
    case 1:
      return "containment";
    case 3:
      return "parking_lot";
    case 2:
      return "spray_zone";
  }
}

function function_9aa04ce7618a1a63(var_168cd8307a3f8807, stealth_group) {
  level endon("flag_reactor_airlock_passed");
  var_4409cb8842fbf95 = "flag_combat_started_at_heli_" + var_168cd8307a3f8807;
  var_9c195cd74c7a8ac5 = "flag_kill_count_forcing_backup_at_heli_" + var_168cd8307a3f8807;
  level thread function_47f9161df3ed9965(var_4409cb8842fbf95, stealth_group, 1);
  level thread function_47f9161df3ed9965(var_9c195cd74c7a8ac5, stealth_group, 4);
  poi = function_86936065b6341f67(var_168cd8307a3f8807);

  while(true) {
    wait 0.25;

    if(flag("flag_heli_killed_" + var_168cd8307a3f8807)) {
      break;
    }

    if(!flag("flag_sustained_combat_active")) {
      continue;
    }

    if(flag(var_9c195cd74c7a8ac5)) {
      break;
    }

    if(distance2d(level.player.origin, poi.origin) > 2500) {
      continue;
    }

    if(!flag(var_4409cb8842fbf95)) {
      continue;
    }

    if(flag("flag_heli_damaged_any_" + var_168cd8307a3f8807)) {
      break;
    }

    break;
  }

  if(!isDefined(level.var_6f686505ec735221)) {
    level.var_6f686505ec735221 = 0;
  }

  level.var_6f686505ec735221++;
  flag_set("flag_allow_aggressive_ai_" + var_168cd8307a3f8807);

  switch (level.var_6f686505ec735221) {
    case 1:
      flag_set("flag_spawn_jltv_backup_" + var_168cd8307a3f8807);
      break;
    case 2:
      flag_set("flag_spawn_heli_backup_" + var_168cd8307a3f8807);
      break;
    case 3:
      flag_set("flag_spawn_jltv_mg_backup_" + var_168cd8307a3f8807);
      break;
  }
}

function function_ed81631597ed2172(var_168cd8307a3f8807) {
  level endon("flag_reactor_airlock_passed");
  flag_wait("flag_spawn_heli_backup_" + var_168cd8307a3f8807);
  poi = function_86936065b6341f67(var_168cd8307a3f8807);
  function_6941c0b810d537da(poi.origin, 3500);
  flag_set("vo_heli_backup_arrive");
  encounter_name = "backup_heli_enc_heli_" + var_168cd8307a3f8807;
  var_2d8bceab6fdd3ab2 = function_2149a449f40a0515(var_168cd8307a3f8807);
  level.var_a3ee8115cdcd60cc = var_168cd8307a3f8807;
  level.var_555adeb625193829 = "heli_backup_vol_1_" + var_2d8bceab6fdd3ab2;
  var_e20078a12c00d86 = scripts\cp_mp\agents\ai_spawn_director::function_930897c0d1a7eb24(encounter_name);
  function_9aa732b22b08a6dc(var_e20078a12c00d86, &function_1abeaedee4344b8d);
  function_fc38783a3da0bc71(var_e20078a12c00d86, 1);
}

function function_1abeaedee4344b8d(requestid, userdata, heli) {
  level endon("flag_reactor_airlock_passed");

  if(!isDefined(level.var_d32fa90e4929570d)) {
    level.var_d32fa90e4929570d = [];
  }

  level.var_d32fa90e4929570d = array_add(level.var_d32fa90e4929570d, heli);
  function_ef3a0e9600008e7e(requestid, heli getentitynumber());
  heli.nocrash = 1;
  heli.health = 2000;
  heli.maxhealth = 2000;
  heli.currenthealth = 2000;
  heli.alias = "heli_med";
  heli.team = "axis";
  heli thread function_87594e206888f5e5();
  function_c17f4c5a577bff0(heli);
  heli.var_eae10920b9197a32 = &namespace_548a10c405703106::function_bf9918e38554b480;
  namespace_548a10c405703106::function_63a4589af5fb207c(heli);

  if(!flag("flag_backup_heli_1_spawned")) {
    flag_set("flag_backup_heli_1_spawned");
    goal_vol = level.var_555adeb625193829;
  }

  while(!isDefined(heli.riders) || heli.riders.size <= 2) {
    wait 1;
  }

  foreach(rider in heli.riders) {
    if(!is_equal(rider.classname, "script_model")) {
      rider thread function_e1be77d1746fd244(heli, goal_vol, level.var_a3ee8115cdcd60cc);
    }
  }
}

function function_87594e206888f5e5() {
  self endon("death");
  spawn_loc = self.spawndata.origin;
  self waittill("started_landing");

  while(true) {
    wait 0.25;

    if(distance(self.origin, spawn_loc) < 100) {
      break;
    }
  }

  self notify("ai_spawn_director_heli_landed");
}

function function_4b91a9ce218e6ae0(var_629c9d7a5643f2e4, var_acba072b7e847a86) {
  self waittill(var_629c9d7a5643f2e4);
  flag_set(var_acba072b7e847a86);
}

function function_e1be77d1746fd244(heli, vol_name, var_168cd8307a3f8807) {
  self endon("death");

  if(isDefined(self.directorspawndata) && istrue(self.directorspawndata.restored)) {
    thread function_6163bb4ead793248();
    return;
  }

  self.heli = heli;
  self.script_moveoverride = 1;
  self.grenadeammo = 0;
  self.favoriteenemy = level.player;
  self getenemyinfo(level.player);
  time_started = gettime();

  if(isDefined(self.fnsetstealthstate)) {
    self[[self.fnsetstealthstate]]("combat");
  }

  self.lastenemysightpos = level.player.origin;
  self.var_4ebe755e0a0a430e = 1;

  if(issubstr(self.classname, "rpg")) {
    thread function_8fa02ae1e5d3df2a();
  }

  self.heli waittill("unloaded");

  if(isDefined(vol_name)) {
    vol = getEnt(vol_name, "targetname");
    self setgoalvolumeauto(vol);
    function_f3dbca0d61b23c79(var_168cd8307a3f8807, 0);
  } else {
    function_f3dbca0d61b23c79(var_168cd8307a3f8807, 1);
  }

  thread function_70b45a8ca45190d0(1500, 30);
}

function function_8fa02ae1e5d3df2a() {
  self endon("death");
  self.dontevershoot = 1;
  self.heli waittill("unloaded");
  self.dontevershoot = 0;
}

function function_5aaaa9e7705ec9ce() {
  self endon("death");
  self[[self.fnsetstealthstate]]("hunt");
  self.goalheight = 1024;
}

function function_792bcb78368a1a6b() {
  player = level.player;

  if(isDefined(player)) {
    event = spawnStruct();
    event.typeorig = "combat";
    event.type = "combat";
    event.origin = player.origin;
    event.investigate_pos = player.origin;
    self[[self.fnsetstealthstate]]("combat", event);
  }

  self.goalheight = 1024;
  self getenemyinfo(level.player);
}

function function_70b45a8ca45190d0(radius, var_3ac4a3b72a8c19f9) {
  self endon("death");
  level.player endon("death");
  self.goalheight = 1024;
  self getenemyinfo(level.player);
  time_started = gettime();

  while(true) {
    if(isDefined(self.fnsetstealthstate)) {
      self[[self.fnsetstealthstate]]("combat");
    }

    self.lastenemysightpos = level.player.origin;
    var_9cec57b238516930 = gettime() - time_started;

    if(isDefined(var_3ac4a3b72a8c19f9) && var_9cec57b238516930 > var_3ac4a3b72a8c19f9 * 1000) {
      break;
    }

    wait 0.5;
  }

  thread function_5aaaa9e7705ec9ce();
}

function function_8395ae3d9fc900cf(var_168cd8307a3f8807) {
  level endon("flag_reactor_airlock_passed");
  poi = function_86936065b6341f67(var_168cd8307a3f8807);
  var_2d399715c2629131 = getStructArray(poi.target, "targetname");
  var_8a4fc8b3f2120928 = "flag_spawn_jltv_backup_" + var_168cd8307a3f8807;
  var_b8b41ec9761be159 = "flag_spawn_jltv_mg_backup_" + var_168cd8307a3f8807;
  flag_wait_either(var_8a4fc8b3f2120928, var_b8b41ec9761be159);
  wait 4;
  function_6941c0b810d537da(poi.origin, 3500);

  if(flag(var_8a4fc8b3f2120928)) {
    var_b91ab01147071e40 = undefined;
    var_9e28a33d89557d28 = undefined;

    foreach(var_7f6aa4958cf05101 in var_2d399715c2629131) {
      dist = distance2d(level.player.origin, var_7f6aa4958cf05101.origin);

      if(!isDefined(var_b91ab01147071e40) || dist > var_9e28a33d89557d28) {
        var_b91ab01147071e40 = var_7f6aa4958cf05101.script_noteworthy;
        var_9e28a33d89557d28 = dist;
      }
    }

    flag_set("vo_jltv_reinforcements");
    encounter_name = "jltv_enc_heli_" + var_168cd8307a3f8807 + "_" + var_b91ab01147071e40;
    var_e20078a12c00d86 = scripts\cp_mp\agents\ai_spawn_director::function_930897c0d1a7eb24(encounter_name);
    level.var_d3eb8ba0514d4d33 = var_e20078a12c00d86;
    function_9aa732b22b08a6dc(var_e20078a12c00d86, &function_512bd27b6dea5d95);
    scripts\cp_mp\agents\ai_spawn_director::function_7a2920be35f4386(var_e20078a12c00d86, &function_2381c2186069ab54, self);
    function_fc38783a3da0bc71(var_e20078a12c00d86, 1);
    return;
  }

  var_b91ab01147071e40 = undefined;
  var_9e28a33d89557d28 = undefined;

  foreach(var_7f6aa4958cf05101 in var_2d399715c2629131) {
    dist = distance2d(level.player.origin, var_7f6aa4958cf05101.origin);

    if(!isDefined(var_b91ab01147071e40) || dist > var_9e28a33d89557d28) {
      var_b91ab01147071e40 = var_7f6aa4958cf05101.script_noteworthy;
      var_9e28a33d89557d28 = dist;
    }
  }

  flag_set("vo_jltv_mg_reinforcements");
  level.var_54fd97d1dd628a8c = gettime();
  encounter_name = "jltv_enc_heli_" + var_168cd8307a3f8807 + "_" + var_b91ab01147071e40;
  var_e20078a12c00d86 = scripts\cp_mp\agents\ai_spawn_director::function_930897c0d1a7eb24(encounter_name);
  function_9aa732b22b08a6dc(var_e20078a12c00d86, &function_512bd27b6dea5d95);
  scripts\cp_mp\agents\ai_spawn_director::function_7a2920be35f4386(var_e20078a12c00d86, &function_f2bb88d6e875be60, self);
  function_fc38783a3da0bc71(var_e20078a12c00d86, 1);
}

function function_2381c2186069ab54(requestid, userdata, wavenumber) {
  return false;
}

function function_f2bb88d6e875be60(requestid, userdata, wavenumber) {
  return time_has_passed(level.var_54fd97d1dd628a8c, 2);
}

function function_512bd27b6dea5d95(requestid, userdata, vehicle) {
  if(!isDefined(level.var_66a1156521ee6dea)) {
    level.var_66a1156521ee6dea = [];
  }

  level.var_66a1156521ee6dea = array_add(level.var_66a1156521ee6dea, vehicle);
  function_ef3a0e9600008e7e(requestid, vehicle getentitynumber());
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(vehicle, "axis");

  if(is_equal(vehicle.vehiclename, "veh_jup_jltv_mg")) {
    turrets = [];
    turrets[0] = vehicle.turrets["jup_mg_jltv_dungeons_cp"];
    turrets[1] = vehicle.turrets["jup_mg_jltv_dungeons_cp"];
    vehicle.mgturret = turrets;
    vehicle.var_3f8ba6301ee08ff0 = &function_f7c06ebe6b588ac6;
    vehicle thread function_cc16e9cdd89351be();
    vehicle thread function_69e09579d822712e();
  }

  vehicle.script_team = "axis";
  vehicle.team = "axis";
  vehicle thread function_fa003df5d3a3f0d5();
  vehicle thread function_91b102bb5f5063ed();
  vehicle thread function_4c2b3e7a7ba1996b();
}

function function_4c2b3e7a7ba1996b() {
  if(!isDefined(level.var_fcb7870afd7213d)) {
    level.var_fcb7870afd7213d = 0;
  }

  level.var_fcb7870afd7213d++;

  if(function_85b29ade98d536d8()) {
    function_401d0838f4f47c3e(0);
  }

  wait 3;
  level.var_fcb7870afd7213d--;

  if(level.var_fcb7870afd7213d == 0 && !function_85b29ade98d536d8()) {
    function_401d0838f4f47c3e(1);
  }
}

function function_91b102bb5f5063ed() {
  self endon("death");
  self endon("reached_end_node");

  while(!isDefined(self.driver)) {
    waitframe();
  }

  self.driver waittill("death");
  self notify("reached_end_node");
}

function function_fa003df5d3a3f0d5() {
  self endon("death");
  self waittill("reached_end_node");

  if(!isDefined(self.riders) || self.riders.size == 0) {
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(self, "neutral");
    return;
  }

  thread namespace_ba155a12c323dc5a::function_da00c0e13a055259();
}

function function_cc16e9cdd89351be() {
  self waittill("entitydeleted");

  if(isDefined(self.mgturret) && isDefined(self.mgturret[0])) {
    self.mgturret[0] delete();
  }
}

function function_69e09579d822712e() {
  self endon("death");

  if(!is_equal(self.vehiclename, "veh_jup_jltv_mg")) {
    return;
  }

  while(!isDefined(self.riders) || is_equal(self.riders.size, 0)) {
    wait 1;
  }

  gunner = function_cde7b4002c7a79eb();
  gunner waittill("death");
  self.mgturret[0] setmode("sentry_offline");
  self.mgturret[0] setsentryowner(undefined);
  self.mgturret[0] makeunusable();
  self.mgturret[0] setdefaultdroppitch(0);
  self.mgturret[0] setturretmodechangewait(1);
}

function function_19881055369262f5(var_4a1f886ea078dd45, var_2af58c5670a7a8f7, var_72dc6772b2b7a15b, var_dc08f498aa0ca049, var_168cd8307a3f8807, var_98ffb2f65d9fb964, var_158069b144bcd4a5) {
  vehspawner = function_7a18da6e48b71c35(var_4a1f886ea078dd45);
  vehspawner.goal_threshold = 200;

  if(istrue(var_2af58c5670a7a8f7)) {
    vehspawner.spawngroup = "reinforcement_jltv_mg_group";
    vehspawner.var_1e33f32152f60866 = "veh_jup_jltv_mg";
  }

  var_593a0e63dee8d5a9 = getStructArray(vehspawner.spawngroup, "targetname");

  if(istrue(var_158069b144bcd4a5)) {
    foreach(spawner in var_593a0e63dee8d5a9) {
      if(isDefined(spawner.target)) {
        spawner.var_89ac88ba78378fd3 = getStruct(spawner.target, "targetname");
        spawner.target = undefined;
      }
    }
  }

  vehicle = function_136d8a6a5c016d7e(vehspawner, var_593a0e63dee8d5a9);
  vehicle.var_af63688e8d4f80ee = 1;
  vehicle.var_f7532aedaddbfafd = 0;
  var_e093cae901c3ec03 = 0;

  foreach(rider in vehicle.riders) {
    if(istrue(var_2af58c5670a7a8f7) && rider.script_startingposition == 1) {
      rider.var_770c39224c6159c5 = 1;
    }

    if(isDefined(var_168cd8307a3f8807)) {
      rider.var_168cd8307a3f8807 = var_168cd8307a3f8807;
    }

    rider thread[[var_dc08f498aa0ca049]]();
  }

  vehicle thread function_fb1d6bbed470878d();
  vehicle thread function_d6f951b7c787c5b2();

  if(istrue(var_98ffb2f65d9fb964)) {
    vehicle thread function_b6e35b9680f4c9b8();
    vehicle thread function_b1035e99fa5d391a();
    vehicle thread function_50215ed78826c8b6();
  }

  if(!isDefined(level.var_66a1156521ee6dea)) {
    level.var_66a1156521ee6dea = [];
  }

  level.var_66a1156521ee6dea = array_add(level.var_66a1156521ee6dea, vehicle);
  return vehicle;
}

function function_fb1d6bbed470878d() {
  self endon("death");
  self endon("unloaded");
  thread scripts\common\vehicle_paths::checkvehiclenavsplinestuck();
  self waittill("vehicleStuckNavSpline");
  thread function_353d8d7e478b3ded();
}

function function_b6e35b9680f4c9b8() {
  self endon("death");
  self endon("unloaded");

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon);

    if(is_equal(attacker, level.player)) {
      break;
    }
  }

  array_thread(self.riders, &function_d21e3bb0ff589389);
  ent_flag_set("jltv_aggro_unload");
  thread function_353d8d7e478b3ded();
}

function function_353d8d7e478b3ded() {
  self endon("death");

  if(ent_flag("stop_and_unload")) {
    return;
  }

  ent_flag_set("stop_and_unload");
  self.var_f7532aedaddbfafd = 1;
  self function_65aa053c077c003a(1);
  self notify("path_updated");
  self notify("newpath");

  if(self hascomponent("p2p")) {
    function_ecbcec373d227be();
  }

  wait 1;
  self function_65aa053c077c003a(0);

  if(self hascomponent("p2p")) {
    namespace_cbe993018617a21d::function_1686ecaabfdc542d();
  }

  self vehicle_turnengineoff();
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(self, "neutral");
}

function function_efdaa03bfc25c1a0() {
  level.player endon("death");
  self endon("vehicle_stopped");
  lookaheadtime = 1.8;
  var_a7796ca2eb0bab7a = self getboundshalfsize();
  var_959588624f3402b3 = level.player physics_getcharactercollisioncapsule();
  var_352c5930ea8d4ee9 = var_a7796ca2eb0bab7a[1] + var_959588624f3402b3["radius"] * 4;
  var_be24014547f24daf = var_a7796ca2eb0bab7a[0] + var_959588624f3402b3["radius"] * 4;
  var_5886126ea90b44e0 = var_a7796ca2eb0bab7a[2] + var_959588624f3402b3["half_height"] * 4;

  while(true) {
    waitframe();
    var_6b051c16c0678276 = self physics_getentitycenterofmass()["unscaled"];
    var_1ced658669311db4 = utility::mph_to_ips(self vehicle_getspeed());
    var_8ed7efe8cbdd0211 = var_be24014547f24daf + var_1ced658669311db4 * lookaheadtime;
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
      return;
    }

    waitframe();
  }
}

function function_b1035e99fa5d391a() {
  self endon("death");
  self endon("unloaded");

  while(true) {
    level.player waittill("weapon_fired", objweapon);
    var_135823c8d383ee64 = objweapon issilenced();

    if(var_135823c8d383ee64) {
      continue;
    }

    if(distance2d(level.player.origin, self.origin) > 2000) {
      continue;
    }

    break;
  }

  array_thread(self.riders, &function_d21e3bb0ff589389);
  ent_flag_set("jltv_aggro_unload");
  thread function_353d8d7e478b3ded();
}

function function_d6f951b7c787c5b2() {
  self endon("death");
  self endon("unloaded");

  while(!isDefined(level.player)) {
    waitframe();
  }

  level.player endon("death");
  wait 1;
  function_efdaa03bfc25c1a0();
  array_thread(self.riders, &function_d21e3bb0ff589389);
  ent_flag_set("jltv_aggro_unload");
  thread function_353d8d7e478b3ded();
}

function function_50215ed78826c8b6() {
  self endon("death");
  self endon("unloaded");

  while(true) {
    wait 1;

    foreach(guy in self.riders) {
      if(is_equal(guy.alertlevel, "combat")) {
        wait 2;
        array_thread(self.riders, &function_d21e3bb0ff589389);
        ent_flag_set("jltv_aggro_unload");
        thread function_353d8d7e478b3ded();
        return;
      }
    }
  }
}

function function_d21e3bb0ff589389() {
  if(!isalive(self)) {
    return;
  }

  self endon("death");
  self.aggressivemode = 1;
  self.ignoresuppression = 1;
  self.disabledodge = 0;
  self.cautiousnavigation = 0;
  self.disablebulletwhizbyreaction = 1;
  self.var_cbd87a0bc497b778 = 1;
  demeanor_override("sprint");
  set_movement_speed(255);
  thread function_70b45a8ca45190d0(1200, 15);
}

function function_c26ef71def4d8933() {
  self endon("death");

  if(istrue(self.var_770c39224c6159c5)) {
    return;
  }

  thread function_1308ec055ee61e28("flag_reactor_airlock_passed");
  thread function_d974cba04d067bfa(&function_ac9858751652fb9e);
  thread function_d974cba04d067bfa(&function_fd6ae4370d24af16);
  thread function_d974cba04d067bfa(&function_792bcb78368a1a6b);
  thread function_d974cba04d067bfa(&function_924b9e221b30f091);
}

function function_e6b4df5383358fae() {
  self endon("death");
  function_ac9858751652fb9e();
  thread function_1308ec055ee61e28("flag_reactor_airlock_passed");
  thread function_24cf7f7c8828b3ad();
  thread function_d974cba04d067bfa(&function_975f25188a9e9b34);
  thread function_d974cba04d067bfa(&function_efc0450618ac37f8);
  thread function_d974cba04d067bfa(&function_4940f7ea4f25cf23, 30);
  thread function_924b9e221b30f091();
}

function function_975f25188a9e9b34() {
  self endon("death");
  self.var_4ebe755e0a0a430e = 1;
  var_8d4fb4a124fa5fdd = self.origin;
  self setgoalpos(var_8d4fb4a124fa5fdd, 2000);
  thread function_aaf7cac1f0565f94();
}

function function_aaf7cac1f0565f94() {
  self endon("death");

  while(true) {
    wait 5;

    if(!function_1445c12552b674d4()) {
      continue;
    }

    var_a5e5182fc6d468eb = function_606f53b43c800acd(self.origin);
    var_51bdc71202a251a4 = function_86936065b6341f67(var_a5e5182fc6d468eb);

    if(distance2d(var_51bdc71202a251a4.origin, self.origin) > 2500) {
      continue;
    }

    self.var_168cd8307a3f8807 = var_a5e5182fc6d468eb;
    break;
  }

  function_f3dbca0d61b23c79(self.var_168cd8307a3f8807, 1);
}

function function_2cd6f7d1b19b3739(var_168cd8307a3f8807) {
  if(!isDefined(level.var_16afcb307a65b328)) {
    return false;
  }

  level.var_16afcb307a65b328[var_168cd8307a3f8807] = array_removedead_or_dying(level.var_16afcb307a65b328[var_168cd8307a3f8807]);

  if(level.var_16afcb307a65b328[var_168cd8307a3f8807].size > 0) {
    return false;
  }

  if(!flag("flag_director_ai_cleared_" + var_168cd8307a3f8807)) {
    return false;
  }

  return true;
}

function function_f3dbca0d61b23c79(var_168cd8307a3f8807, var_3c5ac9c6b2350d74) {
  if(!isDefined(level.var_16afcb307a65b328)) {
    level.var_16afcb307a65b328 = [];
    level.var_16afcb307a65b328[1] = [];
    level.var_16afcb307a65b328[2] = [];
    level.var_16afcb307a65b328[3] = [];
  }

  level.var_16afcb307a65b328[var_168cd8307a3f8807] = array_add(level.var_16afcb307a65b328[var_168cd8307a3f8807], self);

  if(!istrue(var_3c5ac9c6b2350d74)) {
    self.stationary = 1;
    return;
  }

  goal_vol = function_d66f6504b7e02fb1(var_168cd8307a3f8807);
  self setgoalvolumeauto(goal_vol);
  self.goalradius = 1500;
}

function function_74158609fd64a01f(var_168cd8307a3f8807, var_3f4fa2f793a4693f) {
  ai_array = [];

  if(isDefined(level.var_16afcb307a65b328) && isDefined(level.var_16afcb307a65b328[var_168cd8307a3f8807])) {
    ai_array = array_combine(ai_array, level.var_16afcb307a65b328[var_168cd8307a3f8807]);
  }

  if(ai_array.size > 0 && istrue(var_3f4fa2f793a4693f)) {
    foreach(guy in ai_array) {
      if(istrue(guy.stationary)) {
        ai_array = array_remove(ai_array, guy);
      }
    }
  }

  group_name = function_c6b135d710ab4c4e(var_168cd8307a3f8807);
  group = scripts\stealth\group::getgroup(group_name);

  if(isDefined(group) && isDefined(group.members)) {
    ai_array = array_combine(ai_array, group.members);
  }

  return ai_array;
}

function function_c6b135d710ab4c4e(var_168cd8307a3f8807) {
  if(var_168cd8307a3f8807 == 1) {
    return "heli_containment_group";
  }

  if(var_168cd8307a3f8807 == 2) {
    return "heli_spray_zone_group";
  }

  if(var_168cd8307a3f8807 == 3) {
    return "parking_lot";
  }
}

function function_bc3fb2105b4aa000(stealth_group) {
  if(stealth_group == "heli_containment_group") {
    return 1;
  }

  if(stealth_group == "heli_spray_zone_group") {
    return 2;
  }

  if(stealth_group == "parking_lot") {
    return 3;
  }
}

function function_fd6ae4370d24af16() {
  self endon("death");

  if(!isDefined(self.var_168cd8307a3f8807)) {
    self.var_168cd8307a3f8807 = function_606f53b43c800acd(self.origin, 1);
  }

  self.var_4ebe755e0a0a430e = 1;
  function_f3dbca0d61b23c79(self.var_168cd8307a3f8807, 1);
}

function function_139c0e11ca76f97e(var_168cd8307a3f8807) {
  if(is_equal(var_168cd8307a3f8807, 1)) {
    return level.var_92f0e14848b8f1cb;
  }

  if(is_equal(var_168cd8307a3f8807, 2)) {
    return level.var_f25fd3ca74044795;
  }

  if(is_equal(var_168cd8307a3f8807, 3)) {
    return level.var_8ed22534caf9fe03;
  }
}

function function_d66f6504b7e02fb1(var_168cd8307a3f8807) {
  if(is_equal(var_168cd8307a3f8807, 1)) {
    return level.containment_combat_vol;
  }

  if(is_equal(var_168cd8307a3f8807, 2)) {
    return level.spray_zone_combat_vol;
  }

  if(is_equal(var_168cd8307a3f8807, 3)) {
    return level.parking_combat_vol;
  }
}

function function_6163bb4ead793248() {
  self endon("death");

  while(!is_equal(self.alertlevel, "combat")) {
    wait 0.5;
  }

  var_168cd8307a3f8807 = function_bc3fb2105b4aa000(self.script_stealthgroup);

  if(!isDefined(var_168cd8307a3f8807)) {
    var_168cd8307a3f8807 = function_606f53b43c800acd(self.origin, 1);
  }

  thread function_3f99278691be58cf(var_168cd8307a3f8807);

  if(!flag("flag_combat_started_at_heli_" + var_168cd8307a3f8807)) {
    var_8f858b54b052a221 = function_563ccf873fe2f39();
    self setgoalvolumeauto(var_8f858b54b052a221);
    wait randomintrange(30, 150);
  }

  var_ec6de4360133c96f = function_c0a09c0e3af9e307();
  self setgoalvolumeauto(var_ec6de4360133c96f);
}

function function_563ccf873fe2f39() {
  if(is_equal(self.script_stealthgroup, "heli_containment_group")) {
    vols = level.var_92f0e14848b8f1cb;
  } else if(is_equal(self.script_stealthgroup, "heli_spray_zone_group")) {
    vols = level.var_f25fd3ca74044795;
  } else if(is_equal(self.script_stealthgroup, "parking_lot")) {
    vols = level.var_8ed22534caf9fe03;
  } else {
    vols = array_combine(level.var_92f0e14848b8f1cb, level.var_f25fd3ca74044795, level.var_8ed22534caf9fe03);
  }

  vols = sortbydistance(vols, self.origin);
  return vols[0];
}

function function_c0a09c0e3af9e307() {
  if(is_equal(self.script_stealthgroup, "heli_containment_group")) {
    var_25228b58df799d30 = level.containment_combat_vol;
  } else if(is_equal(self.script_stealthgroup, "heli_spray_zone_group")) {
    var_25228b58df799d30 = level.spray_zone_combat_vol;
  } else if(is_equal(self.script_stealthgroup, "parking_lot")) {
    var_25228b58df799d30 = level.parking_combat_vol;
  } else {
    vols = [level.containment_combat_vol, level.spray_zone_combat_vol, level.parking_combat_vol];
    var_25228b58df799d30 = sortbydistance(vols, self.origin)[0];
  }

  return var_25228b58df799d30;
}

function function_d974cba04d067bfa(func, var1) {
  self endon("death");
  self.ridingvehicle ent_flag_wait("unloaded");
  wait 0.5;

  if(isDefined(var1)) {
    self[[func]](var1);
    return;
  }

  self[[func]]();
}

function function_efc0450618ac37f8() {
  if(flag("flag_intro_veh_1_arrived_at_dest") && isDefined(self.var_89ac88ba78378fd3)) {
    self.goalradius = 16;
    new_goals = self.var_89ac88ba78378fd3;
    scripts\cp\spawning::go_to_node(new_goals);
  }

  thread scripts\cp\spawning::enter_combat();
}

function function_5ea4745c96ec8441() {
  flag_wait("checkpoint_data_retrieved");
  var_41686a907349671f = level.player namespace_96731f4d002634f6::function_97ccc150115699dc(1);

  if(istrue(var_41686a907349671f) && level.checkpoint == "obj_reconArea_complete") {
    flag_set("flag_spawn_attack_heli");
    return;
  }

  function_4b960aab950cb97b(2);
  var_a40ee82358152199 = [function_86936065b6341f67(1), function_86936065b6341f67(3), function_86936065b6341f67(2)];
  var_77e162dc9e4fb1e5 = function_832430b21ffb7c5e()[0];

  if(!isDefined(var_77e162dc9e4fb1e5)) {
    flag_set("flag_spawn_attack_heli");
    return;
  }

  var_3c78e09620f3a7b9 = function_86936065b6341f67(var_77e162dc9e4fb1e5);
  var_a40ee82358152199 = array_remove(var_a40ee82358152199, var_3c78e09620f3a7b9);

  while(true) {
    wait 0.25;

    if(flag("flag_heli_damaged_any_" + var_77e162dc9e4fb1e5)) {
      break;
    }

    if(isDefined(level.player.vehicle) && distance2d(var_3c78e09620f3a7b9.origin, level.player.origin) < 6300) {
      break;
    }

    if(!isDefined(level.player.vehicle) && distance2d(var_3c78e09620f3a7b9.origin, level.player.origin) < 5200) {
      break;
    }

    if(!flag("flag_all_heli_backup_complete")) {
      continue;
    }
  }

  flag_set("flag_spawn_attack_heli");
}

function function_63b73595615ecb74(origin, radius) {
  while(true) {
    draw_circle(origin, radius, (1, 1, 0), 1, 0, 20);
    wait 1;
  }
}

function function_832430b21ffb7c5e() {
  var_497e918bebcc8c4a = [1, 3, 2];
  var_42baaf33b9b0e1b0 = array_remove_array(var_497e918bebcc8c4a, level.var_10aad158c29f7d5f);
  return var_42baaf33b9b0e1b0;
}

function function_c17f4c5a577bff0(heli) {
  if(!isDefined(level.activekillstreaks)) {
    level.activekillstreaks = [];
  }

  level.activekillstreaks[level.activekillstreaks.size] = heli;
  heli.streakname = "chopper_gunner";
}

function function_606f53b43c800acd(org, var_b2f50895f6518487) {
  if(!isDefined(var_b2f50895f6518487)) {
    var_b2f50895f6518487 = 1;
  }

  containment = getStruct("heli_containment_loc", "targetname");
  parking_lot = getStruct("heli_parking_loc", "targetname");
  spray_zone = getStruct("heli_spray_loc", "targetname");

  if(!isDefined(containment) || !isDefined(parking_lot) || !isDefined(spray_zone)) {
    return undefined;
  }

  var_4df31e9d485396a5 = distance(org, containment.origin);
  var_2026f3f8f0a63291 = distance(org, parking_lot.origin);
  var_9932af62af1fd6b = distance(org, spray_zone.origin);

  if(!istrue(var_b2f50895f6518487) && level.var_10aad158c29f7d5f.size == 3) {
    return undefined;
  }

  if(!istrue(var_b2f50895f6518487) && array_contains(level.var_10aad158c29f7d5f, 1)) {
    var_4df31e9d485396a5 = 9999999;
  }

  if(!istrue(var_b2f50895f6518487) && array_contains(level.var_10aad158c29f7d5f, 3)) {
    var_2026f3f8f0a63291 = 9999999;
  }

  if(!istrue(var_b2f50895f6518487) && array_contains(level.var_10aad158c29f7d5f, 2)) {
    var_9932af62af1fd6b = 9999999;
  }

  if(var_4df31e9d485396a5 < var_2026f3f8f0a63291 && var_4df31e9d485396a5 < var_9932af62af1fd6b) {
    return 1;
  }

  if(var_2026f3f8f0a63291 < var_9932af62af1fd6b) {
    return 3;
  }

  return 2;
}

function function_399c5377091d2b15(org) {
  containment = getStruct("heli_containment_loc", "targetname");
  parking_lot = getStruct("heli_parking_loc", "targetname");
  spray_zone = getStruct("heli_spray_loc", "targetname");
  var_4df31e9d485396a5 = distance(org, containment.origin);
  var_2026f3f8f0a63291 = distance(org, parking_lot.origin);
  var_9932af62af1fd6b = distance(org, spray_zone.origin);

  if(var_4df31e9d485396a5 < var_2026f3f8f0a63291 && var_4df31e9d485396a5 < var_9932af62af1fd6b) {
    return containment.origin;
  }

  if(var_2026f3f8f0a63291 < var_9932af62af1fd6b) {
    return parking_lot.origin;
  }

  return spray_zone.origin;
}

function function_e92aa26a36ca25fb() {
  flag_wait("player_spawned_with_loadout");
  thread function_5ea4745c96ec8441();
  flag_wait_either("flag_spawn_attack_heli", "flag_debug_force_spawn_attack_heli");
  flag_set("vo_attack_heli_arrive");

  if(is_equal(level.checkpoint, "obj_reconArea_complete")) {
    spawn_point = function_191cfa8b553f727c();
  } else {
    var_77e162dc9e4fb1e5 = function_832430b21ffb7c5e()[0];

    if(flag("<dev string:x287>")) {
      var_77e162dc9e4fb1e5 = function_606f53b43c800acd(level.player.origin);
    }

    if(!isDefined(var_77e162dc9e4fb1e5)) {
      var_77e162dc9e4fb1e5 = function_606f53b43c800acd(level.player.origin, 1);
    }

    trig = function_f159c10d5cf8f0b4("behind_reactor_trig", "targetname")[0];
    var_cea7476edd8c7020 = "";

    if(level.player istouching(trig) && !is_equal(var_77e162dc9e4fb1e5, 1)) {
      var_cea7476edd8c7020 = "_alt";
    }

    spawn_point = getStruct("enemy_attack_chopper_spawn_" + var_77e162dc9e4fb1e5 + var_cea7476edd8c7020, "targetname");
    goal_path = "enemy_attack_chopper_path_" + var_77e162dc9e4fb1e5 + var_cea7476edd8c7020;
  }

  spawn_point.var_a4d76f90d6916d81 = 1;

  if(isDefined(spawn_point.script_parameters)) {
    spawn_point.var_14cde247ac3313a4 = spawn_point.script_parameters;
  }

  level.attack_heli = function_15cc3579cdac3cfb(spawn_point, 1000);
  level.attack_heli vehicleshowonminimap(0);
  minimapid = undefined;

  if(scripts\engine\utility::issharedfuncdefined("game", "createObjective")) {
    minimapid = level.attack_heli[[scripts\engine\utility::getsharedfunc("game", "createObjective")]]("hud_icon_minimap_vehicle_heli_hind", level.attack_heli.team, 1, 1, 0, "icon_medium");
  }

  level.attack_heli.minimapid = minimapid;
  level thread function_c55dc81d17a55899(level.attack_heli);
  level.attack_heli.nocrash = 0;
  level.attack_heli.var_78da61277c9dee0a = &function_97b00cd33ff5cfd8;
  level.attack_heli.var_a446c274174c1268 = 0;
  level.attack_heli.crash_style = "rotate";
  level.attack_heli.crash_timeout = 2.5;
  level.attack_heli setmaxpitchroll(25, 25);
  level.attack_heli.var_a8f4bb03b366aa80 = 1;

  if(is_equal(level.checkpoint, "obj_reconArea_complete")) {
    level.attack_heli.var_eb994bdfa396a885 = 1;
  }

  level thread function_49208aaf95d642dc(level.attack_heli, goal_path, "flag_reactor_airlock_passed");
  function_c17f4c5a577bff0(level.attack_heli);
  level thread function_e1a2f716f2ccd865(level.attack_heli);
  level thread function_1092af85d6060d14(level.attack_heli);
  level thread function_4c64f400c4bdddcf(level.attack_heli);
  level thread function_f7daebfcc9a8e58a(level.attack_heli);
  level thread function_6d40e0aa516c69c();
  level thread function_32b770011456e2bd(level.attack_heli);
  thread namespace_11fae4a66a43bd3f::function_53b4c2188bcb1123(level.attack_heli);
}

function function_c55dc81d17a55899(heli) {
  heli waittill("death");

  if(isDefined(heli.minimapid)) {
    if(scripts\engine\utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\engine\utility::getsharedfunc("game", "returnObjectiveID")]](heli.minimapid);
    }
  }
}

function function_191cfa8b553f727c() {
  spawn_points = getStructArray("enemy_attack_chopper_spawn_checkpoint", "targetname");
  spawn_points = sortbydistance(spawn_points, level.player.origin);

  foreach(spawn_point in spawn_points) {
    if(!function_e7c30095a6cdc3ef(spawn_point.origin, 70, 0)) {
      continue;
    }

    if(distance2d(level.player.origin, spawn_point.origin) > 10000) {
      continue;
    }

    if(distance2d(level.player.origin, spawn_point.origin) < 4000) {
      continue;
    }

    var_9a46a4d8cfea25dc = level.player.origin - spawn_point.origin;
    var_4f9fb44c409f4ee0 = vectortoangles(var_9a46a4d8cfea25dc);
    spawn_point.angles = var_4f9fb44c409f4ee0;
    return spawn_point;
  }

  foreach(spawn_point in spawn_points) {
    if(distance2d(level.player.origin, spawn_point.origin) < 4000) {
      continue;
    }

    var_9a46a4d8cfea25dc = level.player.origin - spawn_point.origin;
    var_4f9fb44c409f4ee0 = vectortoangles(var_9a46a4d8cfea25dc);
    spawn_point.angles = var_4f9fb44c409f4ee0;
    return spawn_point;
  }
}

function function_4c64f400c4bdddcf(heli) {
  heli endon("death");

  while(true) {
    level.player waittill("weapon_fired", objweapon);

    if(!issubstr(objweapon.basename, "rpapa7")) {
      continue;
    }

    waitframe();

    foreach(missile in level.missiles) {
      if(!is_equal(missile.owner, level.player)) {
        continue;
      }

      if(!issubstr(missile.weapon_name, "rpapa7")) {
        continue;
      }

      thread function_ac2e716351c2afcd(heli, missile);
    }
  }
}

function function_ac2e716351c2afcd(heli, missile) {
  heli endon("death");
  missile endon("death");

  if(istrue(missile.is_tracked)) {
    return;
  }

  missile.is_tracked = 1;

  while(true) {
    waitframe();

    if(distance(heli.origin, missile.origin) < 300) {
      missile detonate();
    }
  }
}

function function_e1a2f716f2ccd865(heli) {
  heli endon("death");

  while(true) {
    level waittill("heli_killed");
    heli function_a99aeff5794b896c(60);
  }
}

function function_f7daebfcc9a8e58a(heli) {
  heli endon("death");

  while(true) {
    heli waittill("heli_started_searching_patrol");
    flag_set("vo_attack_heli_lost_player");
    wait 0.5;
    heli waittill("gained_new_target");
    flag_set("vo_attack_heli_found_player");
    wait 0.5;
  }
}

function function_6d40e0aa516c69c() {
  level waittill("flares", player, missiletarget);
  wait 2;
  flag_set("vo_attack_heli_damage");
}

function function_32b770011456e2bd(heli) {
  heli waittill("death");
  flag_set("flag_attack_heli_destroyed");
  wait 2;
  flag_set("vo_attack_heli_killed");
}

function function_1092af85d6060d14(heli) {
  heli endon("death");
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_atcc_ghos_contact";
  aliases[aliases.size] = "dx_cp_chem_atcc_ghos_goodeffect";
  aliases[aliases.size] = "dx_cp_chem_atcc_ghos_direct";
  aliases[aliases.size] = "dx_cp_chem_chha_lasw_directhitsixsendanot";
  aliases[aliases.size] = "dx_cp_chem_chha_lasw_sixgoodeffectontarge";
  var_24f27aa2206e250e = create_deck(aliases, undefined, 1);

  while(!flag("flag_attack_heli_destroyed")) {
    heli waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon);

    if(!is_equal(attacker, level.player)) {
      continue;
    }

    if(isDefined(objweapon) && is_equal(meansofdeath, "MOD_RIFLE_BULLET")) {
      flag_set("vo_attack_heli_bullet_damage");
      wait 1;
    }

    if(isDefined(objweapon) && issubstr(objweapon.basename, "_la_rpapa7_")) {
      if(function_94b00c0fad72704b(2, undefined, 5)) {
        level say_delayed(0.5, var_24f27aa2206e250e deck_draw(), 0.3, 0.5);
      }
    }
  }
}

function function_a64e58c1d94add64() {}

function function_ffc7dd3a5adfd5cf() {
  function_80058ee17006f14();
  function_cbfff3495f3639c6();
  level thread function_63529d146fdd5d95();
  level thread function_b97bf8139f37ecc7();
  level thread function_c98248e88663bfc6();
  level thread function_90995caf88d44aab();
  level thread function_880ba338ce41bce5();
  level thread function_240501f2e35044f2();
  level thread function_85c1dc4a99f338c0();
  level thread function_b6e6fe67287fedd6();
  level thread function_ca6ff573e2141c36();
  level thread function_a140cd422b631ebe();
  level thread function_f54ca240c6f1b963();
  level thread function_eaa4586af1abd60c();
  level thread function_b5103d032271b2a1();
  level thread vo_reactor_inaccessible_interacted();
  level thread function_43eca70c1a099d41();
  level thread function_ed3f45c27aa13eb();
  level thread function_321dbb76740a1fda();
  level thread vo_reactor_enter();
  level thread vo_reactor_platform_ais_banter();
  level thread vo_reactor_player_spotted();
  level thread function_ae0124b7e4b6a12f();
  level thread function_9257439ca1b28dfd();
  level thread function_7d61581b58848b60();
  level thread function_50a39a5cc7719fbf();
  level thread function_8eb07f63783e8516();
  level thread function_ac6a77b3720d6fdc();
  level thread function_eb9d4eb741b4ce3d();
  level thread vo_reactor_chemical_released();
  level thread vo_reactor_escape();
  level thread function_f89bb5ae8d84c4ac();
  level thread vo_reactor_gasnear_floor3();
  level thread vo_reactor_gasat_floor3();
  level thread vo_reactor_safe_floor3();
  level thread vo_reactor_ally_progress2();
  level thread function_ba3c7df767be352c();
  level thread function_afe2a68bafb57218();
  level thread function_20028b9709374e42();
  level thread vo_reactor_exfil_missing_tool_nag();
  level thread vo_reactor_exfil_rope_nag();
  level thread function_317c0bf5cd329a53();
  level thread vo_reactor_airlocks_hint();
  level thread function_f7ccc631f578bc61();
  level thread vo_reactor_konniwaves_begin();
  level thread vo_reactor_konniwaves_2();
  level thread vo_reactor_konniwaves_3();
  level thread vo_reactor_konniwaves_end();
  level thread vo_konniwaves_banter_price_winning();
  level thread vo_konniwaves_banter_price_losing();
  level thread function_404f55b59bf36864();
  level thread function_a1e10c0ef3839f79();
  level thread function_ef4ae784f7d1b0cd();
  level thread function_ba344a2452bade79();
  level thread function_9c32642d9b5879d();
  level thread function_703931fcf4b7c0bc();
  level thread function_9a4dca769694ba24();
  level thread function_905425efe3b7f3c8();
  level thread function_a277c3cb045aa9ea();
  level thread function_880046b51f10709a();
  level thread function_21a64e85f0a7fae2();
  level thread function_693b854402e0d21e();
  level thread function_a086f3227105bc58();
  level thread function_33301d971afddb48();
  level thread function_f7a188f6c5c5204d();
  level thread function_fc0715c36b596067();
  level thread function_8edff60b7434fd();
  level thread function_1d977456094e1f4f();
  level thread function_a72e8f4dad5eb6c9();
  level thread function_58cf0a7b623b069b();
  level thread function_96975ba65a514717();
  level thread function_8c6d191a8031541e();
  level thread function_8bdb22a2adad375a();
  level thread function_def66ed89387fc5b();
  level thread function_9baa840cb5e343b8();
  level thread function_9ebbfbd1365cacd3();
  level thread function_49de560c553c9cfe();
  level thread function_edb0e98317abe38b();
  level thread function_5c9189099075a944();
  level thread function_763d44b12429ac5b();
  level thread function_b36752fe87873d62();
  level thread function_5915eee776e9db36();
  level thread function_95254f8b3d3507a8();
  level thread function_313ac6436b8a39a4();
  level thread function_4f828cf3aa821ea1();
  level thread function_1ddd0b91fdecae14();
  level thread function_4bb31b4662ece186();
  level thread function_4f9fc5447add5d41();
  level thread function_8ae924cf32535716();
  level thread function_94f056216a0ed8ee();
  level thread function_bc4ceccca9528c7b();
  level thread function_485eba9406c5e977();
  level thread vo_spotter_nag();
  level thread function_b0436758aa12db92();
  level thread function_c0791d4fbca710d0();
  level thread function_2f0b07d52498f339();
  level thread vo_heli_backup_arrive();
  level thread vo_jltv_reinforcements();
  level thread vo_jltv_mg_reinforcements();
  level thread vo_attack_heli_arrive();
  level thread vo_attack_heli_lost_player();
  level thread vo_attack_heli_killed();
  level thread function_569213882dc66c9e();
  level thread function_8ccc128672142c8d();
  level thread function_6a121b8b5d22f7e5();
  level thread function_c2a789ef4520475f();
  level thread function_be4bdf27dec56891();
  level thread function_7d76321d25c90dfd();
  level thread function_9778fd0c8fb5dc5c();
  level thread function_a18a28cf5bddfe5e();
  level thread function_b318ac8c04543e41();
  level thread function_393409c653af83fc();
  level thread function_578b731e7f4ac46c();
  level thread function_24740fd698aac2cc();
  level thread function_5cf5e508cd2dd387();
  level thread function_4bb76241137e4cab();
  level thread function_1e27329186d2d067();
  level thread function_ef7e90b36127ca23();
  level thread function_de08b769a6e326a7();
  level thread function_9ac1f5d7fc0a7996();
  level thread function_302b9f93bcb66010();
  level thread function_714a3a97028fea45();
  level thread function_584686b5e68303b6();
  level thread function_fe6769318b6e12f2();
  level thread function_e4d64449ae7942c9();
  level thread function_d0ec4b3121a50d6a();
  level thread function_27fe9c2561fe01a6();
  level thread function_2bffdb16381e779f();
  level thread function_f754b2e07106fd83();
}

function function_80058ee17006f14() {
  level.var_37d4ce8c2aa043ce = -10001;
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_cohn_lasw_06theresnomovementat";
  aliases[aliases.size] = "dx_cp_chem_cohn_lasw_constructionsitescle";
  aliases[aliases.size] = "dx_cp_chem_cohn_lasw_bravo06youreclearatt";
  level.var_a8f1c3571f998334 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_phna_lasw_parkinglotsclear06ge";
  aliases[aliases.size] = "dx_cp_chem_phna_lasw_06noenemyactivityatt";
  aliases[aliases.size] = "dx_cp_chem_phna_lasw_bravo06parkinglotisc";
  level.var_4a86deaba64db35 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_sphn_lasw_bravo06nomovementnea";
  aliases[aliases.size] = "dx_cp_chem_sphn_lasw_06smokestackareclear";
  aliases[aliases.size] = "dx_cp_chem_sphn_ghos_aosclearcaptainletsk";
  level.var_b63330ee14bc88dd = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_paht_lasw_bravo06theparkinglot";
  aliases[aliases.size] = "dx_cp_chem_paht_lasw_parkinglotisclearbra";
  aliases[aliases.size] = "dx_cp_chem_paht_lasw_06nomovementinthepar";
  level.var_50aa559cad081a13 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_spht_lasw_yourecleartothehelo0";
  level.var_61ac5901f9940d9b = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_spna_ghos_goodvantagetherefort";
  aliases[aliases.size] = "dx_cp_chem_spna_ghos_clearviewtoscoutwith";
  aliases[aliases.size] = "dx_cp_chem_spna_ghos_youvegotthehighgroun";
  aliases[aliases.size] = "dx_cp_chem_spna_ghos_tacticallyadvantageo";
  level.var_daa4457d192616c6 = create_deck(aliases, undefined, 1);
}

function function_cbfff3495f3639c6() {
  level.vo = function_69fa4a2561ada985("vo_struct");

  if(!isDefined(level.vo)) {
    level.vo = spawnStruct();
    function_2311740fe797906a("vo_struct", level.vo);
  }
}

function function_63529d146fdd5d95() {
  level.player endon("death");

  if(!isDefined(level.var_aa14b2beb1308584)) {
    if(istrue(level.checkpoint_reached)) {
      if(level.checkpoint == "obj_reconArea_complete") {
        var_4fee217231ef5d23 = level.player function_97ccc150115699dc(1);
        level.var_aa14b2beb1308584 = istrue(var_4fee217231ef5d23) ? 2 : 4;
      } else {
        level.var_aa14b2beb1308584 = 4;
      }
    } else {
      level.var_aa14b2beb1308584 = 3;
    }
  }

  level thread function_d04e476ba014b622();

  while(true) {
    switch (level.var_aa14b2beb1308584) {
      case 3:
        function_135075c78c6efe6f();
        break;
      case 0:
        function_7d03c09c1bc0a0d1();
        break;
      case 1:
        function_6624ac0979321c7();
        break;
      case 2:
        function_f41a6b1e6078d94a();
        break;
      case 4:
        function_81450756e54e4137();
        break;
      case 5:
        function_6944e26e81ddf8dd();
        break;
    }

    flag_clear("flag_vo_state_change");
  }
}

function function_135075c78c6efe6f() {
  level endon("flag_vo_state_change");
  level childthread function_63613b052938cdfb();
  level childthread function_bb51fd460115ed91();
  flag_wait("flag_vo_state_change");
}

function function_bb51fd460115ed91() {
  level.player endon("death");
  flag_wait("vo_on_landing_completed");
  function_864970432d2c2607(0);
}

function function_7d03c09c1bc0a0d1() {
  level endon("flag_vo_state_change");
  level childthread function_a3a47caa38bb8b8();
  level childthread function_63613b052938cdfb();
  level childthread function_113beef4d08fe8bd();
  level childthread function_bf0a1d1e0780eb74();
  flag_wait("flag_vo_state_change");
}

function function_a3a47caa38bb8b8() {
  level.player endon("death");
  level waittill("heli_obj_ai_killed");
  flag_set("flag_heli_obj_ai_killed_recently");
  function_864970432d2c2607(1);
}

function function_63613b052938cdfb() {
  level.player endon("death");
  flag_wait("flag_player_near_alive_heli_objective");
  function_864970432d2c2607(1);
}

function function_bf0a1d1e0780eb74() {
  level.player endon("death");
  flag_wait("flag_obj_all_helis_killed");
  function_864970432d2c2607(4);
}

function function_6624ac0979321c7() {
  level endon("flag_vo_state_change");
  wait 5;

  if(flag("flag_heli_obj_ai_killed_recently")) {
    wait 20;
  }

  level childthread function_976ab79d56ce7ed8();
  level childthread function_113beef4d08fe8bd();
  level childthread function_bf0a1d1e0780eb74();
  flag_wait("flag_vo_state_change");
}

function function_976ab79d56ce7ed8() {
  level.player endon("death");

  while(true) {
    flag_waitopen("flag_player_near_alive_heli_objective");

    if(function_1445c12552b674d4() && flag("flag_player_in_combat_range_heli_objective")) {
      wait 0.25;
      continue;
    }

    break;
  }

  if(flag("flag_obj_all_helis_killed")) {
    function_864970432d2c2607(4);
    return;
  }

  function_864970432d2c2607(0);
}

function function_113beef4d08fe8bd() {
  level.player endon("death");

  if(flag("flag_attack_heli_destroyed")) {
    return;
  }

  flag_wait("vo_attack_heli_arrive");
  function_864970432d2c2607(2);
}

function function_39221a150f30ca54() {
  level.player endon("death");
  flag_wait("flag_attack_heli_destroyed");

  if(flag("flag_obj_all_helis_killed")) {
    function_864970432d2c2607(4);
    return;
  }

  if(flag("flag_player_near_alive_heli_objective")) {
    function_864970432d2c2607(1);
    return;
  }

  function_864970432d2c2607(0);
}

function function_f41a6b1e6078d94a() {
  level endon("flag_vo_state_change");
  level childthread function_39221a150f30ca54();
  level childthread function_79e204b578b5b871();
  flag_wait("flag_vo_state_change");
}

function function_81450756e54e4137() {
  level endon("flag_vo_state_change");
  level childthread function_79e204b578b5b871();
  flag_wait("flag_vo_state_change");
}

function function_79e204b578b5b871() {
  flag_wait("flag_reactor_airlock_passed");
  function_864970432d2c2607(5);
}

function function_6944e26e81ddf8dd() {
  flag_wait("flag_hold_forever");
}

function function_864970432d2c2607(state_id) {
  level.var_aa14b2beb1308584 = state_id;
  flag_set("flag_vo_state_change");
}

function function_686cb09132f8a701(state_id) {
  switch (state_id) {
    case 0:
      return "exploration";
    case 1:
      return "heli_obj";
    case 2:
      return "attack_heli";
    case 3:
      return "initial";
    case 4:
      return "goto_reactor";
    case 5:
      return "reactor";
  }
}

function function_d04e476ba014b622() {
  if(getdvarint(@ "hash_58143960e12cabfc", 0) == 0) {
    return;
  }

  x_offset = -50;
  thread function_9a1c6971d0ee4a70(x_offset, 150, &function_64b59274073b4985);
  thread function_9a1c6971d0ee4a70(x_offset, 165, &function_33a1cccc0f11b43);
  thread function_9a1c6971d0ee4a70(x_offset, 180, &function_d32661cda1a49cd);
  thread function_9a1c6971d0ee4a70(x_offset, 195, &function_3195fb1f021e9da8);
  thread function_9a1c6971d0ee4a70(x_offset, 210, &function_7dbb2c4e243a50fa);
  thread function_9a1c6971d0ee4a70(x_offset, 225, &function_bea51c22ed9f8861);
  thread function_9a1c6971d0ee4a70(x_offset, 240, &function_5c011c8efad12c7f);
  thread function_9a1c6971d0ee4a70(x_offset, 255, &function_343480a5ce4692eb);
}

function function_64b59274073b4985() {
  return "state : " + function_686cb09132f8a701(level.var_aa14b2beb1308584);
}

function function_33a1cccc0f11b43() {
  return "detected: " + function_1445c12552b674d4();
}

function function_d32661cda1a49cd() {
  return "near obj: " + flag("flag_player_near_heli_objective") + ", in combat range: " + flag("flag_player_in_combat_range_heli_objective");
}

function function_3195fb1f021e9da8() {
  return "secs since ally spoke: " + function_b37ab5bd353b9965();
}

function function_7dbb2c4e243a50fa() {
  all_ais = getaiarray("axis");

  if(!isDefined(all_ais) || all_ais.size == 0) {
    return "no enemies in level";
  }

  closest_ai = sortbydistance(all_ais, level.player.origin)[0];
  return "closest enemy: " + distance(closest_ai.origin, level.player.origin);
}

function function_bea51c22ed9f8861() {
  if(!isDefined(level.player.var_25d42327330ce213)) {
    return "combat not entered yet";
  }

  return "secs since combat: " + (gettime() - level.player.var_25d42327330ce213) / 1000;
}

function function_5c011c8efad12c7f() {
  return "location: " + function_29e347ba0fe6f857();
}

function function_343480a5ce4692eb() {
  var_e25e2997b9097ebe = function_6a929b40729d52b3() / 1000;
  return "secs at location: " + var_e25e2997b9097ebe;
}

function private function_9a1c6971d0ee4a70(x, y, var_2e13c5e7a5393831) {
  text = newhudelem();
  width = 350;
  text.alignx = "left";
  text.aligny = "middle";
  text.x = x;
  text.y = y;
  text.sort = 5;
  text.fontscale = 1;
  text.alpha = 0.5;
  text.archived = 0;
  instances_allowed = 20;

  for(current_instances = 0; true; current_instances = 0) {
    text setdevtext([[var_2e13c5e7a5393831]]());

    wait 0.1;
    current_instances++;

    if(current_instances > instances_allowed) {
      text clearalltextafterhudelem();
    }
  }
}

function function_182208f0e9f1bad4(seconds) {
  var_659464f6cf7077b8 = function_b37ab5bd353b9965();
  return var_659464f6cf7077b8 > seconds;
}

function function_b37ab5bd353b9965() {
  if(level.player is_speaking() || level is_speaking()) {
    return 0;
  }

  var_39d0653e2d760053 = level.player function_bce20c074033e937();
  var_c37f6c1353fb9c73 = level function_bce20c074033e937();

  if(!isDefined(var_39d0653e2d760053)) {
    var_39d0653e2d760053 = 9999;
  }

  if(!isDefined(var_c37f6c1353fb9c73)) {
    var_c37f6c1353fb9c73 = 9999;
  }

  return min(var_39d0653e2d760053, var_c37f6c1353fb9c73);
}

function function_cc116388b57ace53(kill_dist, issniper) {
  if(flag("flag_reactor_room_entered")) {
    return;
  }

  level endon("flag_reactor_room_entered");
  level.var_2912f8042f907a06 = gettime();
  var_bd7c6dcf75fcb6f7 = 2000;
  var_9ffde7862df6776 = 1500;
  var_a5e60f9c72a42976 = 250;

  if(!isDefined(level.var_6c376f31a01f196f)) {
    function_ea101df42d86cfe3();
  }

  nearby_enemies = function_299424620c86e0e0(self, 500);
  var_2e2e5218316e82fa = function_299424620c86e0e0(self, 250);
  randomrange = randomfloatrange(0.3, 1.2);
  flag_set("vo_in_kill");

  if(!isDefined(level.last_kill_vo)) {
    level.last_kill_vo = -10001;
  }

  if(function_94b00c0fad72704b([1, 0], undefined, 3) && !flag("vo_initial_loud_vo_said")) {
    if(function_eac0cd99c9c6d8ee() == "spotted" && function_335daf3b15d106cd(3)) {
      aliases = [];
      aliases[aliases.size] = "dx_cp_chem_skil_pric_donebeingquiet";
      aliases[aliases.size] = "dx_cp_chem_skil_pric_gettingloud";
      aliases[aliases.size] = "dx_cp_chem_skil_pric_goinhot";
      aliases[aliases.size] = "dx_cp_chem_skil_pric_goingloud";
      var_77769df9eb9fbf3e = create_deck(aliases, 1, 1);
      level.player function_fc0eb6b81c66c661(randomfloatrange(0.6, 0.8), var_77769df9eb9fbf3e deck_draw(), 0.9, 1);
      flag_set("vo_initial_loud_vo_said");
      level.last_kill_vo = gettime();
      flag_clear("vo_in_kill");
      return;
    }
  }

  if(function_94b00c0fad72704b(0, undefined, 5)) {
    var_ed5b4f34b6b8e53f = randomfloatrange(1.2, 1.6);

    if(function_eac0cd99c9c6d8ee() == "hidden" && function_335daf3b15d106cd(20) && nearby_enemies.size < 1) {
      if(kill_dist <= var_9ffde7862df6776 && function_cd5edf848f7a4a5b()) {
        var_d37ae75fcadde388 = [level.var_9645552b6b68bb17 deck_draw(), level.player, 0.3, &function_a4e4a9fc80e228fd, level.var_f4b33d86ff3b1f3f deck_draw()];
        level function_c9a09b3ba9c68f8d(var_ed5b4f34b6b8e53f, var_d37ae75fcadde388, 0, 21);
        level.last_kill_vo = gettime();
      }

      if(kill_dist <= var_9ffde7862df6776) {
        level function_c9a09b3ba9c68f8d(var_ed5b4f34b6b8e53f, level.var_6c376f31a01f196f deck_draw(), 0, 1);
        level.last_kill_vo = gettime();
      }

      if(kill_dist > var_9ffde7862df6776 && function_335daf3b15d106cd(50)) {
        level function_c9a09b3ba9c68f8d(var_ed5b4f34b6b8e53f, level.var_a6435df43d97fcb0 deck_draw(), 0, 1);
        level.last_kill_vo = gettime();
      }
    }

    if(function_eac0cd99c9c6d8ee() == "hidden" && function_335daf3b15d106cd(20) && nearby_enemies.size >= 1) {
      if(kill_dist <= var_9ffde7862df6776) {
        if(nearby_enemies.size == 1) {
          level function_fc0eb6b81c66c661(var_ed5b4f34b6b8e53f, level.var_52d6236f983f789b deck_draw(), 0, 1);
          level.last_kill_vo = gettime();
        }

        if(nearby_enemies.size == 2) {
          level function_fc0eb6b81c66c661(var_ed5b4f34b6b8e53f, level.var_516e215086133bd4 deck_draw(), 0, 1);
          level.last_kill_vo = gettime();
        }

        if(nearby_enemies.size >= 3) {
          level function_fc0eb6b81c66c661(var_ed5b4f34b6b8e53f, level.var_dabae71f4d48e655 deck_draw(), 0, 1);
          level.last_kill_vo = gettime();
        }
      }

      if(kill_dist >= var_bd7c6dcf75fcb6f7 && function_335daf3b15d106cd(25)) {
        if(nearby_enemies.size == 1) {
          if(!flag("vo_sniper_challenge_end")) {
            level function_c9a09b3ba9c68f8d(var_ed5b4f34b6b8e53f, level.var_42ccdf7c48f9f8af deck_draw(), 0.3, 1);
            guy = nearby_enemies[0];
            level.last_kill_vo = gettime();
            function_151afd5bcc06e80e(guy);
          } else {
            if(percent_chance(50)) {
              level function_c9a09b3ba9c68f8d(var_ed5b4f34b6b8e53f, level.var_3416ecfd6779cb15 deck_draw(), 0.2, 1);
            } else {
              level function_fc0eb6b81c66c661(var_ed5b4f34b6b8e53f, level.var_9b7fa61d2f3a1f81 deck_draw(), 0, 1);
            }

            level.last_kill_vo = gettime();
          }
        }

        if(nearby_enemies.size >= 2) {
          if(percent_chance(50)) {
            level function_fc0eb6b81c66c661(var_ed5b4f34b6b8e53f, level.var_58a613e5ec407fc deck_draw(), 0.2, 1);
          } else {
            level function_c9a09b3ba9c68f8d(var_ed5b4f34b6b8e53f, level.var_3416ecfd6779cb15 deck_draw(), 0.2, 1);
          }

          level.last_kill_vo = gettime();
        }
      }
    }

    if(function_eac0cd99c9c6d8ee() == "spotted") {
      if(kill_dist <= var_9ffde7862df6776 && function_335daf3b15d106cd(25)) {
        level function_c9a09b3ba9c68f8d(randomfloatrange(0.6, 1), level.var_e5ebbaf28ed1c844 deck_draw(), 0, 1);
        level.last_kill_vo = gettime();
      }

      if(kill_dist > var_9ffde7862df6776 && function_335daf3b15d106cd(25)) {
        level function_c9a09b3ba9c68f8d(randomfloatrange(0.6, 0.8), level.var_6040b5e7d8fc73bd deck_draw(), 0, 1);
        level.last_kill_vo = gettime();
      }
    }
  }

  if(function_94b00c0fad72704b(1, undefined, 5)) {
    function_6874a7dc3d239c8d();
  }

  flag_clear("vo_in_kill");
}

function function_cd5edf848f7a4a5b() {
  if(!isDefined(self.stealth) || !isDefined(self.stealth.ai_event)) {
    return false;
  }

  return is_equal(self.stealth.ai_event, "curiousenemy") || is_equal(self.stealth.ai_event, "sight");
}

function function_6874a7dc3d239c8d() {
  line_delay = randomfloatrange(0.6, 1.2);

  if(function_335daf3b15d106cd(20)) {
    if(level.var_9df79069dfd8549b == 0) {
      if(flag("flag_player_near_heli_objective") && !flag("vo_kill_first_heli_opener")) {
        if(function_1445c12552b674d4()) {
          level function_c9a09b3ba9c68f8d(line_delay, level.var_2f30c1f94f8d547 deck_draw(), 0.1, 1);
          flag_set("vo_kill_first_heli_opener");
          level.last_kill_vo = gettime();
          return;
        } else {
          level function_c9a09b3ba9c68f8d(line_delay, level.var_1fa9fd5527b218c4 deck_draw(), 0.1, 1);
          flag_set("vo_kill_first_heli_opener");
          level.last_kill_vo = gettime();
          return;
        }
      }

      if(flag("flag_player_near_heli_objective") && flag("vo_kill_first_heli_opener")) {
        if(function_1445c12552b674d4()) {
          if(function_6c93dcce28cfcc28() && function_a0afdc88b4bb5b9f("parking_lot") <= 4) {
            level function_c9a09b3ba9c68f8d(line_delay, level.var_ca967ae8c7f093f2 deck_draw(), 0.1, 1);
          } else if(function_6c93dcce28cfcc28() && function_a0afdc88b4bb5b9f("parking_lot") > 4) {
            level function_c9a09b3ba9c68f8d(line_delay, level.var_e5ebbaf28ed1c844 deck_draw(), 0.1, 1);
          }

          if(function_a9591d332b6b3464() && function_a0afdc88b4bb5b9f("heli_containment_group") <= 4) {
            level function_c9a09b3ba9c68f8d(line_delay, level.var_ca967ae8c7f093f2 deck_draw(), 0.1, 1);
          } else if(function_a9591d332b6b3464() && function_a0afdc88b4bb5b9f("heli_containment_group") > 4) {
            level function_c9a09b3ba9c68f8d(line_delay, level.var_e5ebbaf28ed1c844 deck_draw(), 0.1, 1);
          }

          if(function_f66674e43ad96fc7() && function_a0afdc88b4bb5b9f("heli_spray_zone_group") <= 4) {
            level function_c9a09b3ba9c68f8d(line_delay, level.var_ca967ae8c7f093f2 deck_draw(), 0.1, 1);
          } else if(function_a9591d332b6b3464() && function_a0afdc88b4bb5b9f("heli_spray_zone_group") > 4) {
            level function_c9a09b3ba9c68f8d(line_delay, level.var_e5ebbaf28ed1c844 deck_draw(), 0.1, 1);
          }

          level.last_kill_vo = gettime();
        } else {
          level function_c9a09b3ba9c68f8d(line_delay, level.var_6650a81c4dda0e8f deck_draw(), 0.1, 1);
          level.last_kill_vo = gettime();
        }
      }
    }

    if(level.var_9df79069dfd8549b == 1) {
      if(flag("flag_player_near_heli_objective") && !flag("vo_kill_second_heli_opener")) {
        if(function_1445c12552b674d4()) {
          level function_fc0eb6b81c66c661(line_delay, level.var_aa605542f7b3e393 deck_draw(), 0.1, 1);
          flag_set("vo_kill_second_heli_opener");
          level.last_kill_vo = gettime();
          return;
        } else {
          level function_fc0eb6b81c66c661(line_delay, level.var_90c7e539ca51768 deck_draw(), 0.1, 1);
          flag_set("vo_kill_second_heli_opener");
          level.last_kill_vo = gettime();
          return;
        }
      }

      if(flag("flag_player_near_heli_objective") && flag("vo_kill_second_heli_opener")) {
        if(function_1445c12552b674d4()) {
          if(function_6c93dcce28cfcc28() && function_a0afdc88b4bb5b9f("parking_lot") <= 4) {
            level function_c9a09b3ba9c68f8d(line_delay, level.var_16e0fe7358655dbe deck_draw(), 0.1, 1);
          } else if(function_6c93dcce28cfcc28() && function_a0afdc88b4bb5b9f("parking_lot") > 4) {
            level function_c9a09b3ba9c68f8d(line_delay, level.var_e5ebbaf28ed1c844 deck_draw(), 0.1, 1);
          }

          if(function_a9591d332b6b3464() && function_a0afdc88b4bb5b9f("heli_containment_group") <= 4) {
            level function_c9a09b3ba9c68f8d(line_delay, level.var_16e0fe7358655dbe deck_draw(), 0.1, 1);
          } else if(function_a9591d332b6b3464() && function_a0afdc88b4bb5b9f("heli_containment_group") > 4) {
            level function_c9a09b3ba9c68f8d(line_delay, level.var_e5ebbaf28ed1c844 deck_draw(), 0.1, 1);
          }

          if(function_f66674e43ad96fc7() && function_a0afdc88b4bb5b9f("heli_spray_zone_group") <= 4) {
            level function_c9a09b3ba9c68f8d(line_delay, level.var_16e0fe7358655dbe deck_draw(), 0.1, 1);
          } else if(function_a9591d332b6b3464() && function_a0afdc88b4bb5b9f("heli_spray_zone_group") > 4) {
            level function_c9a09b3ba9c68f8d(line_delay, level.var_e5ebbaf28ed1c844 deck_draw(), 0.1, 1);
          }

          level.last_kill_vo = gettime();
        } else {
          level function_fc0eb6b81c66c661(line_delay, level.var_af15abd2658d5633 deck_draw(), 0.1, 1);
          level.last_kill_vo = gettime();
        }
      }
    }

    if(level.var_9df79069dfd8549b == 2) {
      if(flag("flag_player_near_heli_objective") && !flag("vo_kill_third_heli_opener")) {
        if(function_1445c12552b674d4()) {
          level function_fc0eb6b81c66c661(line_delay, level.var_798793e7a622023c deck_draw(), 0.1, 1);
          flag_set("vo_kill_third_heli_opener");
          level.last_kill_vo = gettime();
          return;
        } else {
          level function_fc0eb6b81c66c661(line_delay, level.var_747c34825c6753a5 deck_draw(), 0.1, 1);
          flag_set("vo_kill_third_heli_opener");
          level.last_kill_vo = gettime();
          return;
        }
      }

      if(flag("flag_player_near_heli_objective") && flag("vo_kill_third_heli_opener")) {
        if(function_1445c12552b674d4()) {
          if(function_6c93dcce28cfcc28() && function_a0afdc88b4bb5b9f("parking_lot") <= 4) {
            level function_c9a09b3ba9c68f8d(line_delay, level.var_8bb551b574c03e29 deck_draw(), 0.1, 1);
          } else if(function_6c93dcce28cfcc28() && function_a0afdc88b4bb5b9f("parking_lot") > 4) {
            level function_c9a09b3ba9c68f8d(line_delay, level.var_e5ebbaf28ed1c844 deck_draw(), 0.1, 1);
          }

          if(function_a9591d332b6b3464() && function_a0afdc88b4bb5b9f("heli_containment_group") <= 4) {
            level function_c9a09b3ba9c68f8d(line_delay, level.var_8bb551b574c03e29 deck_draw(), 0.1, 1);
          } else if(function_a9591d332b6b3464() && function_a0afdc88b4bb5b9f("heli_containment_group") > 4) {
            level function_c9a09b3ba9c68f8d(line_delay, level.var_e5ebbaf28ed1c844 deck_draw(), 0.1, 1);
          }

          if(function_f66674e43ad96fc7() && function_a0afdc88b4bb5b9f("heli_spray_zone_group") <= 4) {
            level function_c9a09b3ba9c68f8d(line_delay, level.var_8bb551b574c03e29 deck_draw(), 0.1, 1);
          } else if(function_a9591d332b6b3464() && function_a0afdc88b4bb5b9f("heli_spray_zone_group") > 4) {
            level function_c9a09b3ba9c68f8d(line_delay, level.var_e5ebbaf28ed1c844 deck_draw(), 0.1, 1);
          }

          level.last_kill_vo = gettime();
          return;
        }

        level function_fc0eb6b81c66c661(line_delay, level.var_b1d970e2438234ca deck_draw(), 0.1, 1);
        level.last_kill_vo = gettime();
      }
    }
  }
}

function function_16b772b16d97af4b() {
  var_168cd8307a3f8807 = function_606f53b43c800acd(level.player.origin);
  return function_86936065b6341f67(var_168cd8307a3f8807);
}

function function_8e739172ab038449() {
  return flag("flag_obj_all_helis_killed");
}

function function_151afd5bcc06e80e(guy) {
  guy waittill_any_timeout_1(5, "death");

  if(time_has_passed(level.last_kill_vo, 5)) {
    level function_fc0eb6b81c66c661(0.5, "dx_cp_chem_stc1_lasw_youjinxedhimghost", 0.5, 2);
    flag_set("vo_sniper_challenge_end");
    return;
  }

  level.player function_fc0eb6b81c66c661(randomfloatrange(0.3, 1.2), level.var_b7100e8718e502d7 deck_draw(), 0.5, 2);
  flag_set("vo_sniper_challenge_end");
}

function function_299424620c86e0e0(ent, dist_radius) {
  if(!isDefined(dist_radius)) {
    max_dist = 500;
  } else {
    max_dist = dist_radius;
  }

  loc = ent.origin;
  ai = function_f1868d2eb5549576();
  ai = sortbydistance(ai, loc);

  if(!isDefined(max_dist)) {
    return ai;
  }

  var_6cf1f7078569eba3 = [];

  foreach(guy in ai) {
    if(distance(guy.origin, loc) < max_dist) {
      var_6cf1f7078569eba3 = array_add(var_6cf1f7078569eba3, guy);
      continue;
    }

    break;
  }

  return var_6cf1f7078569eba3;
}

function function_ea101df42d86cfe3() {
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_stki_pric_onedown", level, 0.4, "dx_cp_chem_stki_ghos_plentymoretogo"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_stki_pric_gotone", level, 0.4, "dx_cp_chem_stki_lasw_cleanwork"];
  aliases[aliases.size] = [level, "dx_cp_chem_stki_lasw_neversawitcoming"];
  aliases[aliases.size] = [level, "dx_cp_chem_stki_lasw_solidwork"];
  aliases[aliases.size] = [level, "dx_cp_chem_stki_lasw_quickandquiet"];
  aliases[aliases.size] = [level, "dx_cp_chem_stki_lasw_stillintheclear"];
  aliases[aliases.size] = [level, "dx_cp_chem_stki_lasw_goodkill"];
  aliases[aliases.size] = [level, "dx_cp_chem_stki_lasw_hesdown"];
  level.var_6c376f31a01f196f = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_loki_pric_konnidown"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_loki_pric_targetdown"];
  aliases[aliases.size] = [level, "dx_cp_chem_loki_ghos_thatsalotofnoise"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_loki_pric_targetkia"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_loki_pric_enemydown"];
  aliases[aliases.size] = [level, "dx_cp_chem_loki_ghos_konniheardthat"];
  aliases[aliases.size] = [level, "dx_cp_chem_loki_ghos_konnisonfullalert"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_loki_pric_xraydown"];
  aliases[aliases.size] = [level, "dx_cp_chem_loki_ghos_theysoundedthealarm"];
  aliases[aliases.size] = [level, "dx_cp_chem_loki_ghos_wereontheirradarnow"];
  level.var_e5ebbaf28ed1c844 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_stlr_pric_blindsided"];
  aliases[aliases.size] = [level, "dx_cp_chem_stlr_lasw_goodshot"];
  aliases[aliases.size] = [level, "dx_cp_chem_snip_lasw_stillgotitprice"];
  aliases[aliases.size] = [level, "dx_cp_chem_snip_lasw_deadlyaccuracycaptai"];
  aliases[aliases.size] = [level, "dx_cp_chem_snip_lasw_excellentshot"];
  aliases[aliases.size] = [level, "dx_cp_chem_snip_lasw_textbooktriggeringsi"];
  aliases[aliases.size] = [level, "dx_cp_chem_snip_lasw_goodaimjohn"];
  aliases[aliases.size] = [level, "dx_cp_chem_snip_lasw_likeicecaptain"];
  level.var_a6435df43d97fcb0 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_llrk_pric_konnidown"];
  aliases[aliases.size] = [level, "dx_cp_chem_llrk_lasw_nicework"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_llrk_pric_gotem"];
  aliases[aliases.size] = [level, "dx_cp_chem_llrk_ghos_goodeye"];
  aliases[aliases.size] = [level, "dx_cp_chem_llrk_ghos_clean"];
  aliases[aliases.size] = [level, "dx_cp_chem_llrk_ghos_youdustedem"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_llrk_pric_dead"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_llrk_pric_dropped"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_llrk_pric_down"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_llrk_pric_chalked"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_llrk_pric_eliminated"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_llrk_pric_taggedhim"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_llrk_pric_burnedone"];
  aliases[aliases.size] = [level, "dx_cp_chem_llrk_lasw_goodeye"];
  aliases[aliases.size] = [level, "dx_cp_chem_llrk_lasw_clean"];
  aliases[aliases.size] = [level, "dx_cp_chem_llrk_lasw_goodkill"];
  aliases[aliases.size] = [level, "dx_cp_chem_llrk_lasw_direct"];
  aliases[aliases.size] = [level, "dx_cp_chem_llrk_lasw_solid"];
  level.var_6040b5e7d8fc73bd = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_stk1_lasw_gotonemorenearhim";
  aliases[aliases.size] = "dx_cp_chem_stk1_lasw_welldonedrophisfrien";
  aliases[aliases.size] = "dx_cp_chem_stk1_lasw_anotheroneclose";
  aliases[aliases.size] = "dx_cp_chem_stk1_lasw_hesgotabuddy";
  aliases[aliases.size] = "dx_cp_chem_stk1_lasw_headuphisfriendsclos";
  level.var_52d6236f983f789b = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_stk2_lasw_twomoreclose";
  aliases[aliases.size] = "dx_cp_chem_stk2_lasw_carefulgottwomoreclo";
  aliases[aliases.size] = "dx_cp_chem_stk2_lasw_twoofhisbuddiesarecl";
  aliases[aliases.size] = "dx_cp_chem_stk2_lasw_hesgottwofriendsinth";
  aliases[aliases.size] = "dx_cp_chem_stk2_lasw_gottwomoreinrange";
  aliases[aliases.size] = "dx_cp_chem_stk2_lasw_anothertwonearyourca";
  level.var_516e215086133bd4 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_stk3_lasw_multiplethreatsthere";
  aliases[aliases.size] = "dx_cp_chem_stk3_lasw_morekonniclosejohnst";
  aliases[aliases.size] = "dx_cp_chem_stk3_lasw_hostilesalloveryourp";
  aliases[aliases.size] = "dx_cp_chem_stk3_lasw_hesgotfriendsbegginf";
  aliases[aliases.size] = "dx_cp_chem_stk3_lasw_threeormorenearbyyou";
  level.var_dabae71f4d48e655 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_lrc1_lasw_anotheroneclosecantl";
  aliases[aliases.size] = "dx_cp_chem_lrc1_lasw_hisfriendstooclosedr";
  aliases[aliases.size] = "dx_cp_chem_lrc1_lasw_hesgotabuddynearbyha";
  aliases[aliases.size] = "dx_cp_chem_lrc1_lasw_advisetakinghisfrien";
  level.var_9b7fa61d2f3a1f81 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_lr2m_lasw_gotafewnearthebodydo";
  aliases[aliases.size] = "dx_cp_chem_lr2m_lasw_couplehostilesareclo";
  aliases[aliases.size] = "dx_cp_chem_lr2m_lasw_couplemoreinthearead";
  aliases[aliases.size] = "dx_cp_chem_lr2m_lasw_hisbuddieshaventnoti";
  level.var_58a613e5ec407fc = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_stlr_pric_gotem"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_stlr_pric_konnidown"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_stlr_pric_deadlyaim"];
  aliases[aliases.size] = [level, "dx_cp_chem_stlr_ghos_cleankill"];
  aliases[aliases.size] = [level, "dx_cp_chem_stlr_ghos_goodaim"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_stlr_pric_cluelessbastard"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_stlr_pric_lethal"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_stlr_pric_precise"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_stlr_pric_laydown"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_stlr_pric_snipedem"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_stlr_pric_lastbreath"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_stlr_pric_neutralized"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_stlr_pric_lightsout"];
  aliases[aliases.size] = [level, "dx_cp_chem_stlr_lasw_cleankill"];
  aliases[aliases.size] = [level, "dx_cp_chem_stlr_lasw_goodaimprice"];
  aliases[aliases.size] = [level, "dx_cp_chem_stlr_lasw_sharpshootingsix"];
  aliases[aliases.size] = [level, "dx_cp_chem_stlr_lasw_marksmanshipcaptain"];
  aliases[aliases.size] = [level, "dx_cp_chem_stlr_lasw_oneless"];
  aliases[aliases.size] = [level, "dx_cp_chem_stlr_ghos_classshotmate"];
  aliases[aliases.size] = [level, "dx_cp_chem_stlr_ghos_textbooksix"];
  aliases[aliases.size] = [level, "dx_cp_chem_stlr_ghos_skill"];
  aliases[aliases.size] = [level, "dx_cp_chem_stlr_ghos_rightthroughem"];
  aliases[aliases.size] = [level, "dx_cp_chem_stlr_ghos_rightontarget"];
  aliases[aliases.size] = [level, "dx_cp_chem_stlr_ghos_onthemoney"];
  aliases[aliases.size] = [level, "dx_cp_chem_stlr_ghos_nocureforthatsir"];
  aliases[aliases.size] = [level, "dx_cp_chem_stlr_ghos_thatspermanent"];
  aliases[aliases.size] = [level, "dx_cp_chem_stlr_ghos_thatsadeadman"];
  aliases[aliases.size] = [level, "dx_cp_chem_stlr_ghos_sleeptime"];
  level.var_3416ecfd6779cb15 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_fonc_ghos_thatkickedthingsoffm"];
  aliases[aliases.size] = [level, "dx_cp_chem_fonc_ghos_konnireinforcementsm"];
  aliases[aliases.size] = [level, "dx_cp_chem_fonc_ghos_konnissendingreinfor"];
  aliases[aliases.size] = [level, "dx_cp_chem_fonc_lasw_06konnireinforcement"];
  aliases[aliases.size] = [level, "dx_cp_chem_fonc_lasw_konnireinforcementsi"];
  aliases[aliases.size] = [level, "dx_cp_chem_fonc_lasw_06konnireinforcement_01"];
  aliases[aliases.size] = [level, "dx_cp_chem_fhck_lasw_06konnisalertedwatch"];
  aliases[aliases.size] = [level, "dx_cp_chem_fhck_lasw_beadvised06konniisse"];
  aliases[aliases.size] = [level, "dx_cp_chem_fhck_lasw_bravo06konnissetting"];
  level.var_2f30c1f94f8d547 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_fhos_ghos_afirmyoureundetected"];
  aliases[aliases.size] = [level, "dx_cp_chem_fhos_ghos_goodkillyoureclear"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_fhos_pric_onedown"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_fhos_pric_xraydown"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_fhos_pric_onekonnidusted"];
  aliases[aliases.size] = [level, "dx_cp_chem_fhos_ghos_plentymorewaitinthei"];
  aliases[aliases.size] = [level, "dx_cp_chem_fhos_lasw_06youreundetected"];
  aliases[aliases.size] = [level, "dx_cp_chem_fhos_lasw_allclearbravo"];
  aliases[aliases.size] = [level, "dx_cp_chem_fhos_lasw_06yourecleartoprocee"];
  level.var_1fa9fd5527b218c4 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_fhck_ghos_moretargetsnearthath"];
  aliases[aliases.size] = [level, "dx_cp_chem_fhck_ghos_konnismaneuveringnea"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_fhck_pric_enemydown"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_fhck_pric_xraydown"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_fhck_pric_droppedone"];
  level.var_ca967ae8c7f093f2 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_fhsk_ghos_cleanstillundetected"];
  aliases[aliases.size] = [level, "dx_cp_chem_fhsk_ghos_niceandquietboss"];
  aliases[aliases.size] = [level, "dx_cp_chem_fhsk_ghos_yourestillclear"];
  aliases[aliases.size] = [level, "dx_cp_chem_fhsk_lasw_06yourestillundetect"];
  aliases[aliases.size] = [level, "dx_cp_chem_fhsk_lasw_stillclearbravo6"];
  aliases[aliases.size] = [level, "dx_cp_chem_fhsk_lasw_konnisstillunaware06"];
  level.var_6650a81c4dda0e8f = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_shck_ghos_konnisalertedtheyred";
  aliases[aliases.size] = "dx_cp_chem_shck_ghos_theyresendingreinfor";
  aliases[aliases.size] = "dx_cp_chem_shck_ghos_goodstartkonniscramb";
  aliases[aliases.size] = "dx_cp_chem_shck_lasw_06yourecompromisedko";
  aliases[aliases.size] = "dx_cp_chem_shck_lasw_06konnireinforcement";
  aliases[aliases.size] = "dx_cp_chem_shck_lasw_konnisdigginginneart";
  level.var_aa605542f7b3e393 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_shsk_ghos_goodkillkonnisunawar";
  aliases[aliases.size] = "dx_cp_chem_shsk_ghos_cleankillkonnihasntc";
  aliases[aliases.size] = "dx_cp_chem_shsk_lasw_06youreundetectedatt";
  aliases[aliases.size] = "dx_cp_chem_shsk_lasw_goodshot06threatsnea";
  aliases[aliases.size] = "dx_cp_chem_shsk_lasw_youreclear06nochange";
  level.var_90c7e539ca51768 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_shoc_ghos_konnisaddingnumbersr";
  aliases[aliases.size] = "dx_cp_chem_shoc_ghos_konnisbringingmoresh";
  aliases[aliases.size] = "dx_cp_chem_shoc_lasw_06konnisreinforcingn";
  aliases[aliases.size] = "dx_cp_chem_shoc_lasw_headsupbravokonnisse";
  level.var_16e0fe7358655dbe = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_shos_ghos_staylowkonnissending";
  aliases[aliases.size] = "dx_cp_chem_shos_ghos_morekonnimovinginsta";
  aliases[aliases.size] = "dx_cp_chem_shos_lasw_headsup06konnissendi";
  aliases[aliases.size] = "dx_cp_chem_shos_lasw_06konnireinforcement";
  level.var_af15abd2658d5633 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_tock_ghos_findcoverkonnisswarm";
  aliases[aliases.size] = "dx_cp_chem_tock_ghos_morekonniincoming";
  aliases[aliases.size] = "dx_cp_chem_tock_lasw_06konnireinforcement";
  aliases[aliases.size] = "dx_cp_chem_tock_lasw_06konnissendingreinf";
  level.var_798793e7a622023c = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_thsk_ghos_youreundetectedbutko";
  aliases[aliases.size] = "dx_cp_chem_thsk_ghos_youreclearfornowbutk";
  aliases[aliases.size] = "dx_cp_chem_thsk_ghos_wereundetectedbutkon";
  aliases[aliases.size] = "dx_cp_chem_thsk_ghos_wereclearfornowbutko";
  aliases[aliases.size] = "dx_cp_chem_thsk_lasw_youreundetected06but";
  aliases[aliases.size] = "dx_cp_chem_thsk_lasw_06konniisunawareofyo";
  level.var_747c34825c6753a5 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_thck_ghos_konnisdigginginatthe";
  aliases[aliases.size] = "dx_cp_chem_thck_ghos_thatpissedemofftheyr";
  aliases[aliases.size] = "dx_cp_chem_thck_lasw_06youvegotkonnireinf";
  aliases[aliases.size] = "dx_cp_chem_thck_lasw_headsup06heavykonnia";
  level.var_8bb551b574c03e29 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_tosk_ghos_lotsosecurityroundth";
  aliases[aliases.size] = "dx_cp_chem_tosk_ghos_konnisreinforcingthe";
  aliases[aliases.size] = "dx_cp_chem_tosk_lasw_06yourestillundetect";
  aliases[aliases.size] = "dx_cp_chem_tosk_lasw_clearfornow06beadvis";
  level.var_b1d970e2438234ca = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_stc1_ghos_howabouthisfriendtou"];
  aliases[aliases.size] = [level, "dx_cp_chem_stc1_ghos_20quidyoumiss", level, 0.4, "dx_cp_chem_stc1_lasw_youbettinagainhimgho"];
  aliases[aliases.size] = [level, "dx_cp_chem_stc1_ghos_doubleornothing"];
  level.var_42ccdf7c48f9f8af = create_deck(aliases, 0, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_stcr_pric_youoweme20";
  aliases[aliases.size] = "dx_cp_chem_stcr_pric_youweresaying";
  aliases[aliases.size] = "dx_cp_chem_stcr_pric_respectyourelderslie";
  level.var_b7100e8718e502d7 = create_deck(aliases, 0, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_geco_lasw_closeone";
  aliases[aliases.size] = "dx_cp_chem_geco_lasw_nickoftime";
  aliases[aliases.size] = "dx_cp_chem_geco_lasw_thatwasclose";
  aliases[aliases.size] = "dx_cp_chem_geco_lasw_closecall";
  aliases[aliases.size] = "dx_cp_chem_geco_lasw_skinoyourteeth";
  aliases[aliases.size] = "dx_cp_chem_geco_lasw_dodgedabullet";
  aliases[aliases.size] = "dx_cp_chem_geco_lasw_almostlostyathere";
  aliases[aliases.size] = "dx_cp_chem_geco_lasw_close";
  level.var_9645552b6b68bb17 = create_deck(aliases, 0, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_geco_pric_closedoesntcount";
  aliases[aliases.size] = "dx_cp_chem_geco_pric_iliketolivedangerous";
  aliases[aliases.size] = "dx_cp_chem_geco_pric_dancinwiththedevil";
  aliases[aliases.size] = "dx_cp_chem_geco_pric_stillhere";
  aliases[aliases.size] = "dx_cp_chem_geco_pric_unscathed";
  aliases[aliases.size] = "dx_cp_chem_geco_pric_nocigar";
  level.var_f4b33d86ff3b1f3f = create_deck(aliases, 0, 1);
}

function function_335daf3b15d106cd(cooldown) {
  cooldown = default_to(cooldown, 5);

  if(!isDefined(level.last_kill_vo)) {
    level.last_kill_vo = -10001;
  }

  if(time_has_passed(level.last_kill_vo, cooldown)) {
    return true;
  }

  return false;
}

function function_7ed8fe8535327e4() {
  level.player scripts\cp\cp_hud_message::tutorialprint(&"CP_JUP_CHEMICAL/HINTOBJECTIVE");
}

function function_a4e4a9fc80e228fd() {
  if(function_1445c12552b674d4()) {
    return 0;
  }
}

function function_dbf7f86edd8a7996() {
  if(flag("any_heli_killed")) {
    return 0;
  }
}

function function_dc63b94812edf63d() {
  if(function_a9591d332b6b3464() && array_contains(level.var_10aad158c29f7d5f, 1)) {
    return false;
  }

  if(function_f66674e43ad96fc7() && array_contains(level.var_10aad158c29f7d5f, 2)) {
    return false;
  }

  if(function_6c93dcce28cfcc28() && array_contains(level.var_10aad158c29f7d5f, 3)) {
    return false;
  }

  return true;
}

function function_87a04356f43d46d9() {
  if(!flag("flag_vo_on_landing")) {
    return 0;
  }
}

function function_880ba338ce41bce5() {
  level endon("game_ended");
  flag_wait("flag_player_has_used_parachute_once");

  if(function_c7b23489dccac22a()) {
    flag_set("flag_open_chute_lines_completed");
    flag_set("flag_obj_reconArea_start");
    var_17ee0dced5d70b1a = function_6b12ac7ec1c1c0b();
    return;
  }

  wait 2;
  thread function_7cb68aa0a38a5b9b();
  aliases = [level, "dx_cp_chem_lein_lasw_watcher1tobravoisris", level, 0.3, "dx_cp_chem_lein_lasw_beadvisedkonnihasthr", &function_a4e4a9fc80e228fd, level, 0.2, "dx_cp_chem_lein_ghos_extractpointsforthen", &function_a4e4a9fc80e228fd, level, 0.2, "dx_cp_chem_lein_lasw_affirmativethosehelo", &function_a4e4a9fc80e228fd, &function_a4e4a9fc80e228fd, level, 0.2, "dx_cp_chem_lein_ghos_rogermovingtooverwat"];
  level.player function_c9a09b3ba9c68f8d(0.6, aliases, 1, 1);
  function_2311740fe797906a("full_airdrop_vo_said", 1);
  flag_set("flag_open_chute_lines_completed");
}

function function_7cb68aa0a38a5b9b() {
  wait 5;
  flag_set("flag_obj_reconArea_start");
}

function function_6b12ac7ec1c1c0b() {
  deathBy = namespace_96731f4d002634f6::function_69fa4a2561ada985("deathBy");
  vo = ["dx_cp_chem_inge_lasw_isrshowsthreekonnihe", "dx_cp_chem_inge_lasw_06targetkonnishelosa", "dx_cp_chem_inge_lasw_targetthosehelos06wh"];

  if(isDefined(deathBy)) {
    switch (deathBy) {
      case #"hash_d4850e4dfbc48417":
        vo = ["dx_cp_chem_intu_ghos_konnihassentryturret", "dx_cp_chem_intu_ghos_multiplesentryturret", "dx_cp_chem_intu_ghos_eyesonmultiplesentry", "dx_cp_chem_intu_ghos_gotvizonmultiplesent", "dx_cp_chem_intu_lasw_bravo06beadvisedkonn", "dx_cp_chem_intu_lasw_konnideployedmultipl", "dx_cp_chem_intu_lasw_06imseeingmultiplese"];
        break;
      case #"hash_980e3152db2cdc0":
        vo = ["dx_cp_chem_infa_ghos_pullyourchutebeforey", "dx_cp_chem_infa_ghos_neverjumpoffarooftop", "dx_cp_chem_infa_ghos_useyourchutetocontro", "dx_cp_chem_infa_lasw_dontforgettopullyour", "dx_cp_chem_infa_lasw_rememberyourparachut"];
        break;
      case #"hash_9c7672a1b4ad986e":
        vo = ["dx_cp_chem_idbr_ghos_checkhighkonnisonroo", "dx_cp_chem_idbr_ghos_visualonkonnicheckth", "dx_cp_chem_idbr_ghos_gotkonnionrooftops", "dx_cp_chem_idbr_lasw_06isrshowskonniactiv", "dx_cp_chem_idbr_lasw_eyeshigh06imseeingko", "dx_cp_chem_idbr_lasw_bravo06beadvisedkonn"];
        break;
      case #"hash_6fbd504f237f8a9e":
        vo = ["dx_cp_chem_idba_ghos_pricekonnihasanarmor", "dx_cp_chem_idba_lasw_06isrshowsanarmoredh", "dx_cp_chem_idba_lasw_staynearcover06konni"];
        break;
    }
  }

  if(!isDefined(deathBy)) {
    deathBy = "<undefined>";
  }

  vo = array_randomize(vo);
  wait 2;
  level.player namespace_e36cb7ca6117d2cc::function_171dea4e0c9a6281(1, vo);
  wait 3;
  aliases = [];
  aliases[aliases.size] = [level, 0.2, "dx_cp_chem_inpa_gazz_bravo61approachingth"];
  aliases[aliases.size] = [level, 0.2, "dx_cp_chem_inpa_soap_touchingdown"];
  aliases[aliases.size] = [level, 0.2, "dx_cp_chem_inpa_soap_71touchingdown"];
  aliases[aliases.size] = [level, 0.2, "dx_cp_chem_inpa_ghos_thisis07movingtohigh", &function_87a04356f43d46d9, level.player, 0.2, "dx_cp_chem_inpa_pric_copythatpreppingtola"];
  level.var_e1380fb7cfef85ee = create_deck(aliases, undefined, 1);

  if(!function_94b00c0fad72704b([3, 0, 1], 1)) {
    return;
  }

  level function_c9a09b3ba9c68f8d(0.3, level.var_e1380fb7cfef85ee deck_draw(), 0.5, 1);
}

function function_240501f2e35044f2() {
  level endon("game_ended");
  level.player endon("death");
  flag_wait("flag_open_chute_lines_completed");

  if(!level.player isonground()) {
    var_6a29209a4a57676a = 1;
  }

  flag_wait("flag_vo_on_landing");
  var_ebdf0b82dfec1bce = function_76d7f307feb10d63("crane_top");
  played_crane_landing = istrue(function_69fa4a2561ada985("played_crane_landing"));
  var_f84c7422c3d8132b = var_ebdf0b82dfec1bce && !played_crane_landing;

  if(function_c7b23489dccac22a() && !var_f84c7422c3d8132b) {
    flag_set("vo_on_landing_completed");
    return;
  }

  if(istrue(var_6a29209a4a57676a)) {
    wait 0.5;
  }

  if(time_has_passed(level.var_35411b0cfb970845, 8)) {
    flag_set("vo_on_landing_completed");
    return;
  }

  if(!var_f84c7422c3d8132b) {
    aliases = [];
    aliases[aliases.size] = [ &function_a4e4a9fc80e228fd, level.player, "dx_cp_chem_lein_pric_sixonthegroundmoving"];
    aliases[aliases.size] = [ &function_a4e4a9fc80e228fd, level.player, "dx_cp_chem_lein_pric_06ontheground"];
    var_139455a364ae74a3 = create_deck(aliases, 1, 1);
    level.player function_c9a09b3ba9c68f8d(randomfloatrange(0.2, 0.5), var_139455a364ae74a3 deck_draw(), 1, 1);
  } else {
    aliases = [];
    aliases[aliases.size] = [level, "dx_cp_chem_flre_lasw_didyoumeanthat"];
    aliases[aliases.size] = [ &function_a4e4a9fc80e228fd, level.player, 0.4, "dx_cp_chem_flre_pric_iwouldnttellyouifidi"];
    aliases[aliases.size] = [ &function_a4e4a9fc80e228fd, level, 0.4, "dx_cp_chem_flre_lasw_rogerthat"];
    level.player function_c9a09b3ba9c68f8d(randomfloatrange(0.2, 0.5), aliases, 1, 1);
    function_2311740fe797906a("played_crane_landing", 1);
  }

  flag_set("vo_on_landing_completed");
}

function function_85c1dc4a99f338c0() {
  if(flag("flag_obj_reconArea_start")) {
    return;
  }

  level endon("flag_obj_reconArea_start");
  flag_wait("stealth_spotted");
  wait 1;
  flag_set("flag_obj_reconArea_start");
}

function function_b6e6fe67287fedd6() {
  if(flag("flag_reactor_room_entered")) {
    return;
  }

  level endon("flag_reactor_room_entered");
  level endon("any_heli_killed");
  level.player endon("death");
  level thread function_42ea64483a255b88();

  if(function_c7b23489dccac22a()) {
    return;
  }

  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_lein_ghos_arecondronecouldhelp";
  aliases[aliases.size] = "dx_cp_chem_lein_lasw_recondronewillhelpus";
  aliases[aliases.size] = "dx_cp_chem_lein_lasw_06yourrecondronewill";
  var_bc31bb9034540bec = create_deck(aliases, 1, 1);

  while(true) {
    function_d307f2590e3f9841(0, 1, 15, 800);

    if(!is_equal(level.player.supername, "super_recon_drone")) {
      return;
    }

    if(flag("flag_recon_drone_used")) {
      return;
    }

    if(isDefined(level.player.vehicle)) {
      continue;
    }

    result = level function_fc0eb6b81c66c661(1, var_bc31bb9034540bec deck_draw(), 0.5, 5);

    if(!istrue(result) || !isDefined(result)) {
      continue;
    }

    if(level.player usinggamepad()) {
      level.player thread scripts\cp\cp_hud_message::tutorialprint(&"CP_JUP_CHEMICAL/FIELDUPGRADE", 5);
      return;
    }

    level.player thread scripts\cp\cp_hud_message::tutorialprint(&"CP_JUP_CHEMICAL/FIELDUPGRADE_KBM", 5);
    return;
  }
}

function function_42ea64483a255b88() {
  level.player endon("death");
  level.player waittill("droneStart");
  flag_set("flag_recon_drone_used");
}

function function_5c90876be5682b83(var_2c89f65e3870e2b6) {
  if(!isDefined(level.player) || !isDefined(level.player.munition_slots)) {
    return false;
  }

  var_b4734440d0f965dd = level.player.munition_slots;

  foreach(munition in var_b4734440d0f965dd) {
    if(!isDefined(munition.ref)) {
      continue;
    }

    if(is_equal(munition.ref, var_2c89f65e3870e2b6)) {
      return true;
    }
  }

  return false;
}

function function_b3a8ac9af2cddbdc(seconds) {
  var_81fb9516d7d755ff = function_6a929b40729d52b3();
  return var_81fb9516d7d755ff / 1000 > seconds;
}

function function_d307f2590e3f9841(var_c5a650d863bd7635, var_1437235d3eda6f10, var_f5c1501f0ac43961, var_2404f10031f4e7c0, var_306987260bfd6e5c, location, wait_flags) {
  level.player endon("death");

  if(isDefined(wait_flags) && !isarray(wait_flags)) {
    wait_flags = [wait_flags];
  }

  while(true) {
    wait 0.25;

    if(isDefined(var_c5a650d863bd7635) && !function_43167219abf74e0d(var_c5a650d863bd7635)) {
      flag_waitopen("flag_vo_state_change");
      continue;
    }

    if(isDefined(wait_flags) && !function_5b9db63ed4d034e0(wait_flags)) {
      function_7a252abaaa15fcd7(wait_flags);
      continue;
    }

    if(isDefined(location) && !function_76d7f307feb10d63(location)) {
      function_f80db1e7cbbe967(location);
      continue;
    }

    if(isDefined(var_1437235d3eda6f10)) {
      if(istrue(var_1437235d3eda6f10) && function_1445c12552b674d4()) {
        continue;
      } else if(!istrue(var_1437235d3eda6f10) && !function_1445c12552b674d4()) {
        continue;
      }
    }

    if(isDefined(var_f5c1501f0ac43961)) {
      results = function_182208f0e9f1bad4(var_f5c1501f0ac43961);

      if(!istrue(results)) {
        continue;
      }
    }

    if(istrue(var_2404f10031f4e7c0)) {
      ai = coop_stealth::get_ai_within_range(level.player.origin, var_2404f10031f4e7c0 * var_2404f10031f4e7c0, 1);

      if(ai.size > 0) {
        continue;
      }
    }

    if(isDefined(var_306987260bfd6e5c)) {
      results = function_ae1ace1c557cc8a9(var_306987260bfd6e5c);

      if(!istrue(results)) {
        continue;
      }
    }

    if(isDefined(level.player) && istrue(level.player.inlaststand)) {
      continue;
    }

    break;
  }
}

function function_94b00c0fad72704b(var_c5a650d863bd7635, var_1437235d3eda6f10, var_f5c1501f0ac43961, var_2404f10031f4e7c0, var_306987260bfd6e5c, location, wait_flags) {
  if(isDefined(wait_flags) && !isarray(wait_flags)) {
    wait_flags = [wait_flags];
  }

  if(isDefined(var_c5a650d863bd7635) && !function_43167219abf74e0d(var_c5a650d863bd7635)) {
    return false;
  }

  if(isDefined(wait_flags) && !function_5b9db63ed4d034e0(wait_flags)) {
    return false;
  }

  if(isDefined(location) && !function_76d7f307feb10d63(location)) {
    return false;
  }

  if(isDefined(var_1437235d3eda6f10)) {
    if(istrue(var_1437235d3eda6f10) && function_1445c12552b674d4()) {
      return false;
    } else if(!istrue(var_1437235d3eda6f10) && !function_1445c12552b674d4()) {
      return false;
    }
  }

  if(istrue(var_1437235d3eda6f10) && function_1445c12552b674d4()) {
    return false;
  }

  if(isDefined(var_f5c1501f0ac43961)) {
    results = function_182208f0e9f1bad4(var_f5c1501f0ac43961);

    if(!istrue(results)) {
      return false;
    }
  }

  if(istrue(var_2404f10031f4e7c0)) {
    ai = coop_stealth::get_ai_within_range(level.player.origin, var_2404f10031f4e7c0 * var_2404f10031f4e7c0, 1);

    if(ai.size > 0) {
      return false;
    }
  }

  if(isDefined(var_306987260bfd6e5c)) {
    results = function_ae1ace1c557cc8a9(var_306987260bfd6e5c);

    if(!istrue(results)) {
      return false;
    }
  }

  if(isDefined(level.player) && istrue(level.player.inlaststand)) {
    return false;
  }

  return true;
}

function function_43167219abf74e0d(states) {
  if(!isarray(states)) {
    states = [states];
  }

  if(!isDefined(level.var_aa14b2beb1308584)) {
    return 0;
  }

  return array_contains(states, level.var_aa14b2beb1308584);
}

function function_2f890cb73a902407(deck, var_87d6595e22e5905e, var_94a761dfc53b0840, endon_flags) {
  if(!isDefined(level.var_ca6ff573e2141c36)) {
    level.var_ca6ff573e2141c36 = [];
    level.var_e9fb8c8af31fb4b6 = [];
  }

  if(!isDefined(var_94a761dfc53b0840)) {
    var_94a761dfc53b0840 = [];
  }

  if(!isarray(var_94a761dfc53b0840)) {
    var_94a761dfc53b0840 = [var_94a761dfc53b0840];
  }

  if(!isDefined(endon_flags)) {
    endon_flags = [];
  }

  if(!isarray(endon_flags)) {
    endon_flags = [endon_flags];
  }

  level.var_ca6ff573e2141c36[level.var_ca6ff573e2141c36.size] = [level.var_ca6ff573e2141c36.size, deck, var_87d6595e22e5905e, var_94a761dfc53b0840, endon_flags];
}

function function_e8a7cb0f0135cbcb() {
  priorities = [0, 1, 2];

  foreach(priority in priorities) {
    foreach(checkin in level.var_ca6ff573e2141c36) {
      var_35205b322f2dd214 = checkin[0];
      deck = checkin[1];
      var_87d6595e22e5905e = checkin[2];
      var_94a761dfc53b0840 = checkin[3];
      endon_flags = checkin[4];

      if(var_87d6595e22e5905e != priority) {
        continue;
      }

      if(arraycontains(level.var_e9fb8c8af31fb4b6, var_35205b322f2dd214)) {
        continue;
      }

      var_48f5344afaa3250d = 1;

      foreach(var_1ecf260737d316b3 in var_94a761dfc53b0840) {
        if(!flag(var_1ecf260737d316b3)) {
          var_48f5344afaa3250d = 0;
        }
      }

      foreach(endon_flag in endon_flags) {
        if(flag(endon_flag)) {
          var_48f5344afaa3250d = 0;
          level.var_e9fb8c8af31fb4b6 = array_add(level.var_e9fb8c8af31fb4b6, var_35205b322f2dd214);
        }
      }

      if(!var_48f5344afaa3250d) {
        continue;
      }

      level.var_e9fb8c8af31fb4b6 = array_add(level.var_e9fb8c8af31fb4b6, var_35205b322f2dd214);
      return deck deck_draw();
    }
  }

  return undefined;
}

function function_ca6ff573e2141c36() {
  level.player endon("death");
  level endon("flag_reactor_room_entered");
  function_ab44590c4ec305a();
  function_5b616aa6747c4394();
  thread function_eea98bdf6a9fdd51();
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_lein_soap_wereatourprimarysetp", level, 0.3, "dx_cp_chem_lein_gazz_konniinsightworkingt", level, 0.4, "dx_cp_chem_lein_ghos_workquietlyuntilthec", level, 0.4, "dx_cp_chem_lein_soap_nopromiseslt"];
  aliases[aliases.size] = [level, "dx_cp_chem_lein_lasw_allbravomaintainthei", level, 0.5, "dx_cp_chem_lein_soap_nopromiseswatcher"];
  function_2f890cb73a902407(create_deck(aliases, 1, 1), 0, "player_not_in_combat", ["any_heli_killed", "player_detected_in_level"]);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_lein_lasw_supplydropsareontarg", &function_a4e4a9fc80e228fd, level.player, 0.3, "dx_cp_chem_lein_pric_copywatcher"];
  aliases[aliases.size] = [level, "dx_cp_chem_wohi_lasw_bravobeadvisedequipm", &function_a4e4a9fc80e228fd, level.player, 0.3, "dx_cp_chem_wohi_pric_solidcopykate"];
  aliases[aliases.size] = [level, "dx_cp_chem_wohi_lasw_yourequipmentpallets", &function_a4e4a9fc80e228fd, level.player, 0.3, "dx_cp_chem_wohi_pric_solidcopykate"];
  aliases[aliases.size] = [level, "dx_cp_chem_wohi_lasw_sixequipmentpalletsa", &function_a4e4a9fc80e228fd, level.player, 0.3, "dx_cp_chem_wohi_pric_solidcopykate"];
  function_2f890cb73a902407(create_deck(aliases, 1, 1), 1, "player_not_in_combat", ["flag_3_helis_destroyed"]);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_lein_ghos_captainlookslikekonn", level.player, 0.3, "dx_cp_chem_lein_pric_orangesmokeacknowled"];
  aliases[aliases.size] = [level, 0.2, "dx_cp_chem_lein_ghos_visualonkonnihlzsthe", &function_a4e4a9fc80e228fd, level.player, 0.2, "dx_cp_chem_lein_pric_copyorangesmoke"];
  function_2f890cb73a902407(create_deck(aliases, 1, 1), 1, "player_not_in_combat", ["any_heli_killed", "flag_player_in_combat_range_heli_objective"]);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_ghsu_soap_allstationsnopopsonr", level, 0.4, "dx_cp_chem_ghsu_lasw_copy71stayouttasight", level, 0.3, "dx_cp_chem_ghsu_soap_rogwerealloverit"];
  aliases[aliases.size] = [level, "dx_cp_chem_ghsu_ghos_allstationsstillnotp", level, 0.3, "dx_cp_chem_ghsu_lasw_nuclearmaybeasmokesc", level, 0.3, "dx_cp_chem_ghsu_soap_whatthehellaretheymo", level, 0.3, "dx_cp_chem_ghsu_lasw_somethingthatpacksap"];
  function_2f890cb73a902407(create_deck(aliases, 1, 1), 0, ["player_not_in_combat", "any_heli_killed"], "flag_3_helis_destroyed");
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_lein_gazz_gottabenuclearmateri", level, 0.3, "dx_cp_chem_lein_soap_doesntseemright", &function_a4e4a9fc80e228fd, level.player, 0.3, "dx_cp_chem_lein_pric_keepscanningghostkee"];
  function_2f890cb73a902407(create_deck(aliases, 1, 1), 1, "player_not_in_combat", "flag_2_helis_destroyed");
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_lein_soap_watcher1bravo71canyo", level, 0.3, "dx_cp_chem_lein_lasw_negativeunknownatthi", level, 0.3, "dx_cp_chem_lein_gazz_hadtosecuresomething"];
  aliases[aliases.size] = [level, "dx_cp_chem_lein_soap_watcher1anyvisualonc", level, 0.3, "dx_cp_chem_lein_lasw_negativeunknownatthi", level, 0.3, "dx_cp_chem_lein_gazz_hadtosecuresomething"];
  function_2f890cb73a902407(create_deck(aliases, 1, 1), 1, ["any_heli_killed", "player_not_in_combat"], "flag_3_helis_destroyed");
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_lein_soap_bravo71inposition", level, 0.3, "dx_cp_chem_lein_gazz_61inpositionouterper", level, 0.3, "dx_cp_chem_lein_ghos_07ready", level, 0.3, "dx_cp_chem_lein_lasw_bravosset06youreclea"];
  function_2f890cb73a902407(create_deck(aliases, 1, 1), 0, undefined, ["player_in_combat", "flag_1_helis_destroyed"]);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_lein_ghos_radiationlevelsarest", level, 0.8, "dx_cp_chem_lein_soap_doesntseemright_01", level, 0.4, "dx_cp_chem_lein_lasw_ghostkeepscanningthe", level, 0.3, "dx_cp_chem_lein_ghos_rog"];
  function_2f890cb73a902407(create_deck(aliases, 1, 1), 0, ["player_not_in_combat", "any_heli_killed"], ["flag_2_helis_destroyed"]);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_gogu_gazz_multiplekonnisquadst", level, 0.4, "dx_cp_chem_gogu_soap_gotsomeheavyhitters"];
  aliases[aliases.size] = [level, "dx_cp_chem_gogu_gazz_gotmultiplekonnichec", level, 0.4, "dx_cp_chem_gogu_soap_mustbesomethingreall"];
  aliases[aliases.size] = [level, "dx_cp_chem_gogu_gazz_konnisquadsarechecki", level, 0.4, "dx_cp_chem_gogu_soap_mustbesomethingimpor"];
  aliases[aliases.size] = [level, "dx_cp_chem_gogu_gazz_konnilookinhighandlo", level, 0.4, "dx_cp_chem_gogu_soap_thehellcouldtheybelo"];
  aliases[aliases.size] = [level, "dx_cp_chem_gogu_gazz_gotmultiplekonnisqua", level, 0.4, "dx_cp_chem_gogu_soap_lotofmanpowerforatre"];
  aliases[aliases.size] = [level, "dx_cp_chem_gogu_gazz_multiplekonnisquadst", level, 0.4, "dx_cp_chem_gogu_gazz_youllfindkonniinever"];
  aliases[aliases.size] = [level, "dx_cp_chem_gogu_gazz_gotmultiplekonnichec", level, 0.4, "dx_cp_chem_gogu_gazz_makarovsmenarecombin"];
  function_2f890cb73a902407(create_deck(aliases, 1, 1), 2, "player_not_in_combat", ["flag_3_helis_destroyed"]);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_gogu_gazz_konnisgoingheavyonth", level, 0.5, "dx_cp_chem_gogu_soap_gotsomeheavyhittersh", level, 0.4, "dx_cp_chem_gogu_ghos_willtellyouwhenifind"];
  aliases[aliases.size] = [level, "dx_cp_chem_gogu_gazz_stillnosignofwhatthe", level, 0.5, "dx_cp_chem_gogu_soap_gotsomeheavyhittersh", level, 0.4, "dx_cp_chem_gogu_ghos_willtellyouwhenifind"];
  aliases[aliases.size] = [level, "dx_cp_chem_gogu_gazz_konnisstilllookingst", level, 0.5, "dx_cp_chem_gogu_soap_gotsomeheavyhittersh", level, 0.4, "dx_cp_chem_gogu_ghos_willtellyouwhenifind"];
  aliases[aliases.size] = [level, "dx_cp_chem_gogu_gazz_theykeeplookingcanti", level, 0.5, "dx_cp_chem_gogu_soap_gotsomeheavyhittersh", level, 0.4, "dx_cp_chem_gogu_ghos_willtellyouwhenifind"];
  function_2f890cb73a902407(create_deck(aliases, 1, 1), 2, "player_not_in_combat", ["flag_3_helis_destroyed"]);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_gogu_soap_thehellcouldtheybelo_01"];
  function_2f890cb73a902407(create_deck(aliases, 1, 1), 2, "player_not_in_combat", ["flag_3_helis_destroyed"]);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_gogu_soap_thehellcouldtheybelo_02"];
  function_2f890cb73a902407(create_deck(aliases, 1, 1), 2, "player_not_in_combat", ["flag_3_helis_destroyed"]);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_gogu_gazz_allstationsnosignofw", level, 0.5, "dx_cp_chem_gogu_ghos_samereportifandwhenw"];
  aliases[aliases.size] = [level, "dx_cp_chem_gogu_gazz_konnisheavyonthehunt"];
  function_2f890cb73a902407(create_deck(aliases, 1, 1), 2, "player_not_in_combat", ["flag_3_helis_destroyed"]);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_gogu_gazz_stillnosignofwhatthe_01", level, 0.4, "dx_cp_chem_gogu_ghos_nothingtoreportherew"];
  aliases[aliases.size] = [level, "dx_cp_chem_gogu_gazz_gaztoallstationscann", level, 0.5, "dx_cp_chem_gogu_ghos_negativekeepcheckini"];
  function_2f890cb73a902407(create_deck(aliases, 1, 1), 2, "player_not_in_combat", ["flag_3_helis_destroyed"]);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_gogu_soap_theystillhaventfoudn", level, 0.5, "dx_cp_chem_gogu_lasw_somethingmakarovwant"];
  aliases[aliases.size] = [level, "dx_cp_chem_gogu_soap_thehellcouldtheybelo_03", level, 0.5, "dx_cp_chem_gogu_lasw_whateversonmakarovsw"];
  aliases[aliases.size] = [level, "dx_cp_chem_gogu_soap_konnischeckingeveryn_01", level, 0.4, "dx_cp_chem_gogu_lasw_makarovsgothishearts"];
  function_2f890cb73a902407(create_deck(aliases, 1, 1), 2, "player_not_in_combat", ["flag_3_helis_destroyed"]);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_sgrd_ghos_soapgazgivemeyoursta", level, 0.4, "dx_cp_chem_sgrd_soap_makingourwaytotherea"];
  aliases[aliases.size] = [level, "dx_cp_chem_sgrd_ghos_soapandgazwhatsyours", level, 0.4, "dx_cp_chem_sgrd_soap_makingourwaytotherea", level, 0.6, "dx_cp_chem_sgrd_ghos_illwatchforyourappro"];
  function_2f890cb73a902407(create_deck(aliases, 1, 1), 2, ["flag_3_helis_destroyed", "player_not_in_combat"], "flag_reactor_room_entered");
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_sghd_lasw_ghostscanforradiatio", level, 0.3, "dx_cp_chem_sghd_ghos_nochangewatcherlevel", level, 0.6, "dx_cp_chem_sghd_soap_konnisstillsearching", level, 0.3, "dx_cp_chem_sghd_gazz_whataretheyafter", level, 0.5, "dx_cp_chem_sghd_lasw_whatevertheyfinditst"];
  function_2f890cb73a902407(create_deck(aliases, 1, 1), 0, ["flag_1_helis_destroyed", "player_not_in_combat"], "flag_2_helis_destroyed");
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_inna_lasw_konnihasaheadstartsi"];
  aliases[aliases.size] = [level, "dx_cp_chem_inna_lasw_getmovingjohnweneedt"];
  aliases[aliases.size] = [level, "dx_cp_chem_inna_lasw_06konnishelosarespin"];
  function_2f890cb73a902407(create_deck(aliases, 1, 1), 2, "player_not_in_combat", ["flag_1_helis_destroyed"]);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_wohi_ghos_konnisgotequipmentar", level.player, 0.2, "dx_cp_chem_wohi_pric_goodeyeghost"];
  aliases[aliases.size] = [level, "dx_cp_chem_wohi_ghos_konnisgotniceequipme", level.player, 0.2, "dx_cp_chem_wohi_pric_goodeyeghost"];
  function_2f890cb73a902407(create_deck(aliases, 1, 1), 1, "player_not_in_combat", "flag_2_helis_destroyed");
  wait 5;
  level.var_ca6ff573e2141c36 = array_randomize(level.var_ca6ff573e2141c36);

  while(true) {
    function_d307f2590e3f9841([0, 1, 2], undefined, 10);
    var_de5d83c035bcf1d1 = function_e8a7cb0f0135cbcb();

    if(isDefined(var_de5d83c035bcf1d1)) {
      level.player function_c9a09b3ba9c68f8d(1.5, var_de5d83c035bcf1d1, 0.8, 8, 0, "team");
    }

    wait randomintrange(40, 80);
  }
}

function function_ab44590c4ec305a() {
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_ghsu_lasw_goteyesonyoucaptaini", &function_a4e4a9fc80e228fd, level.player, 0.3, "dx_cp_chem_ghsu_pric_thanksfortheassistwa", level, 0.3, "dx_cp_chem_ghsu_lasw_makarovmeansallhands"];
  var_bdce45989f8058c9 = create_deck(aliases);

  if(flag("flag_player_in_combat_range_heli_objective")) {
    return;
  }

  level endon("flag_player_in_combat_range_heli_objective");
  flag_wait("vo_on_landing_completed");
  function_d307f2590e3f9841(0, 1, 2);
  level.player function_c9a09b3ba9c68f8d(0.3, var_bdce45989f8058c9 deck_draw(), 0.6, 2, 0, "team");
}

function function_5b616aa6747c4394() {
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_sogi_gazz_allstationswereseein", level, 0.3, "dx_cp_chem_sogi_gazz_theyresearchingthear"];
  var_78d3c3947753cfa = aliases;
  aliases = [];
  aliases[aliases.size] = [level.player, 0.3, "dx_cp_chem_sogi_pric_stayonem"];
  var_b6b968728f8e12a7 = create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = [level.player, 0.3, "dx_cp_chem_sogi_pric_stayonem_01"];
  var_bea81708fdd88ddc = create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = [level, 1.5, "dx_cp_chem_sogi_soap_noradiationgeardoesn"];
  aliases[aliases.size] = [level, 0.4, "dx_cp_chem_sogi_lasw_theycouldbeaftermore", level, 0.5, "dx_cp_chem_sogi_gazz_copywatcher"];
  var_254b43bc261523ec = aliases;

  if(flag("flag_player_in_combat_range_heli_objective")) {
    return;
  }

  level endon("flag_player_in_combat_range_heli_objective");
  function_d307f2590e3f9841([0, 1], undefined, 10);
  response = function_cd70fbc5ff85bc7d(var_bea81708fdd88ddc, var_b6b968728f8e12a7);
  var_4c4f80af97738d40 = array_combine(var_78d3c3947753cfa, response, var_254b43bc261523ec);
  level.player function_c9a09b3ba9c68f8d(0.3, var_4c4f80af97738d40, 0.8, 2, 0, "team");
}

function function_eea98bdf6a9fdd51() {
  if(function_ac995123da286501()) {
    return;
  }

  level endon("flag_3_helis_destroyed");
  sequence = [level.player, "dx_cp_chem_lein_pric_ghostyoupickingupany", level, 0.2, "dx_cp_chem_lein_ghos_negativealltheheloss", &function_a4e4a9fc80e228fd, level.player, 0.4, "dx_cp_chem_lein_pric_copy"];
  flag_wait("vo_on_landing_completed");

  if(flag("player_in_combat")) {
    return;
  }

  level endon("player_in_combat");
  function_d307f2590e3f9841([0, 1], undefined, 3, undefined, undefined, undefined, ["flag_player_in_combat_range_heli_objective", "vo_on_landing_completed"]);
  level.player function_c9a09b3ba9c68f8d(2, sequence, 1, 6, 0, "team");
  function_2311740fe797906a("explosives_vo_said", 1);
}

function function_a140cd422b631ebe() {
  level.player endon("death");
  level endon("flag_reactor_room_entered");
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_sghd_soap_bravo06youvegotkonni"];
  aliases[aliases.size] = [level, "dx_cp_chem_sghd_soap_feltthatexplosionove"];
  aliases[aliases.size] = [level, "dx_cp_chem_sghd_soap_captaintheexplosiong"];
  aliases[aliases.size] = [level, "dx_cp_chem_sghd_soap_bravo71to06wereseein"];
  aliases[aliases.size] = [level, "dx_cp_chem_sghd_soap_yougotkonnisattentio"];
  aliases[aliases.size] = [level, "dx_cp_chem_sghd_gazz_thatblastgottheiratt"];
  aliases[aliases.size] = [level, "dx_cp_chem_sghd_gazz_bosskonnireinforceme"];
  var_cdce0f2cd1d636b6 = create_deck(aliases, 1, 1);
  var_2c29173a81b8e15c = [level, 1.2, "dx_cp_chem_sghd_ghos_captainstillnotpicki", level, 1, "dx_cp_chem_sghd_soap_negativeneitherhasko", level, 0.8, "dx_cp_chem_sghd_gazz_iftheresnoradioactiv"];
  var_6e14effb29ccf731 = [level.player, 0.5, "dx_cp_chem_sghd_pric_stayonitfindout"];
  var_70ef9dc31133531e = [level.player, 0.5, "dx_cp_chem_sghd_pric_stayonitfindout_01"];
  flag_wait("flag_1_helis_destroyed");
  wait 10;
  function_d307f2590e3f9841([0, 1, 2], undefined, 5);
  var_e2f0b6d610b2fed0 = array_combine(var_cdce0f2cd1d636b6 deck_draw(), var_2c29173a81b8e15c, function_70386f0dbf01d6f4(var_70ef9dc31133531e, var_6e14effb29ccf731));
  level.player function_c9a09b3ba9c68f8d(3, var_e2f0b6d610b2fed0, 0.8, 6, 0, "team");
}

function function_f54ca240c6f1b963() {
  level.player endon("death");
  level endon("flag_reactor_room_entered");
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_sgsd_soap_youkickedthenestcapn"];
  aliases[aliases.size] = [level, "dx_cp_chem_sgsd_gazz_morekonnisbreakingof"];
  main_deck = create_deck(aliases, 1, 1);
  var_9976b2ca42e18b73 = [level, "dx_cp_chem_sgsd_lasw_07anychangeinradiati", level, 0.4, "dx_cp_chem_sgsd_ghos_negativewatcher", level, 0.6, "dx_cp_chem_sgsd_soap_doesntmakesensetheys", level, 0.4, "dx_cp_chem_sgsd_gazz_powersoffdoorsaresea"];
  var_6e14effb29ccf731 = [level.player, 0.3, "dx_cp_chem_sgsd_pric_letskeepitthatway"];
  var_70ef9dc31133531e = [level.player, 0.3, "dx_cp_chem_sgsd_pric_letskeepitthatway_01"];
  flag_wait("flag_2_helis_destroyed");
  wait 10;
  function_d307f2590e3f9841([0, 1, 2], undefined, 3);
  level function_c9a09b3ba9c68f8d(3, main_deck deck_draw(), 0.8, 6, 0, "team");

  if(flag("flag_3_helis_destroyed")) {
    return;
  }

  level endon("flag_3_helis_destroyed");
  wait 20;
  function_d307f2590e3f9841([0, 1, 2], undefined, 3);
  var_c493a652403e207d = array_combine(var_9976b2ca42e18b73, function_70386f0dbf01d6f4(var_70ef9dc31133531e, var_6e14effb29ccf731));
  level.player function_c9a09b3ba9c68f8d(3, var_c493a652403e207d, 0.8, 6, 0, "team");
}

function function_eaa4586af1abd60c() {
  level.player endon("death");
  level endon("flag_reactor_room_entered");
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_sgmr_gazz_thinkyouscaredemboss"];
  aliases[aliases.size] = [level, "dx_cp_chem_sgmr_gazz_bravokonnisonthemove"];
  aliases[aliases.size] = [level, "dx_cp_chem_sgmr_gazz_konnimustvegottennew"];
  aliases[aliases.size] = [level, "dx_cp_chem_sgmr_gazz_06wereseeingheavykon"];
  aliases[aliases.size] = [level, "dx_cp_chem_sgmr_gazz_allstationskonnisapp"];
  var_cdce0f2cd1d636b6 = create_deck(aliases, 1, 1);
  var_890fd898d7ef051c = [level, 0.4, "dx_cp_chem_sgmr_soap_theymustvefoundwhatt", level, 0.3, "dx_cp_chem_sgmr_ghos_goteyeslookslikethey"];
  var_6e14effb29ccf731 = [level.player, 0.3, "dx_cp_chem_sgmr_pric_thenthatswhereweneed"];
  var_70ef9dc31133531e = [level.player, 0.3, "dx_cp_chem_sgmr_pric_thenthatswhereweneed_01"];
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_sgmr_soap_headedtoyou"];
  aliases[aliases.size] = [level, "dx_cp_chem_sgmr_soap_roger"];
  var_733ac56d1247dfad = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_sgmr_ghos_gotavisualtheyremovi"];
  aliases[aliases.size] = [level, "dx_cp_chem_sgmr_ghos_imeyesontheyreheadin"];
  var_5883ea5c15923847 = create_deck(aliases, 1, 1);
  var_a2c47ad36d267dcf = [level, 0.3, "dx_cp_chem_sgmr_soap_theyweresearchingfor", level, 0.3, "dx_cp_chem_sgmr_lasw_affirmativewhateverk"];
  aliases = [];
  aliases[aliases.size] = [level, 0.3, "dx_cp_chem_sgmr_pric_allbravomoveinrpisth"];
  aliases[aliases.size] = [level, 0.3, "dx_cp_chem_sgmr_pric_allbravorallypointis"];
  var_9b6cea058a4b5f04 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level, 0.3, "dx_cp_chem_sgmr_pric_allbravomoveinrpisth_01"];
  aliases[aliases.size] = [level, 0.3, "dx_cp_chem_sgmr_pric_allbravorallypointis_01"];
  var_e5abb5a2f4bf5ea3 = create_deck(aliases, 1, 1);
  var_a2c47bd36d268002 = [level, 0.3, "dx_cp_chem_sgmr_gazz_copywereinbound", level, 0.3, "dx_cp_chem_sgmr_ghos_07movingnow"];
  flag_wait("flag_3_helis_destroyed");
  wait 10;
  function_d307f2590e3f9841([0, 1, 2], undefined, 3);
  var_e2f0b6d610b2fed0 = array_combine(var_cdce0f2cd1d636b6 deck_draw(), var_890fd898d7ef051c, function_70386f0dbf01d6f4(var_70ef9dc31133531e, var_6e14effb29ccf731), var_733ac56d1247dfad deck_draw());
  level.player function_c9a09b3ba9c68f8d(3, var_e2f0b6d610b2fed0, 0.8, 6, 0, "team");
  wait 15;
  function_d307f2590e3f9841([0, 1, 2], undefined, 3);
  var_21f3b395ab17a659 = array_combine(var_5883ea5c15923847 deck_draw(), var_a2c47ad36d267dcf, function_cd70fbc5ff85bc7d(var_e5abb5a2f4bf5ea3, var_9b6cea058a4b5f04), var_a2c47bd36d268002);
  level.player function_c9a09b3ba9c68f8d(3, var_21f3b395ab17a659, 0.8, 6, 0, "team");
}

function function_b97bf8139f37ecc7() {
  level endon("death");
  level.player endon("death");
  flag_wait("flag_vo_on_landing");
  var_a40ee82358152199 = [function_86936065b6341f67(1), function_86936065b6341f67(3), function_86936065b6341f67(2)];
  var_e80ff09e502b85a7 = 2500;
  var_6498185d9f831015 = 3000;
  var_b6f7478860a6283 = "flag_player_near_heli_objective";
  var_5a53f28ba12e8c75 = "flag_player_near_alive_heli_objective";
  var_630632ef5f0faec3 = "flag_player_in_combat_range_heli_objective";

  while(true) {
    var_8059b0585c16cb2e = 0;
    var_1746a31099c6d5f7 = 0;
    var_b6b8d421b8624297 = 0;

    foreach(org in var_a40ee82358152199) {
      if(distance(org.origin, level.player.origin) < var_e80ff09e502b85a7) {
        var_8059b0585c16cb2e = 1;
      }

      if(distance(org.origin, level.player.origin) < var_6498185d9f831015) {
        var_b6b8d421b8624297 = 1;
      }
    }

    if(istrue(var_8059b0585c16cb2e) && !flag(var_b6f7478860a6283)) {
      flag_set(var_b6f7478860a6283);
    } else if(!istrue(var_8059b0585c16cb2e) && flag(var_b6f7478860a6283)) {
      flag_clear(var_b6f7478860a6283);
    }

    if(istrue(var_b6b8d421b8624297) && !flag(var_630632ef5f0faec3)) {
      flag_set(var_630632ef5f0faec3);
    } else if(!istrue(var_b6b8d421b8624297) && flag(var_630632ef5f0faec3)) {
      flag_clear(var_630632ef5f0faec3);
    }

    var_e442802fbb846fc1 = function_606f53b43c800acd(level.player.origin, 0);

    if(!isDefined(var_e442802fbb846fc1)) {
      flag_clear(var_5a53f28ba12e8c75);
      wait 0.25;
      continue;
    }

    var_64655cf94d9636a2 = function_86936065b6341f67(var_e442802fbb846fc1);

    if(distance(var_64655cf94d9636a2.origin, level.player.origin) < var_e80ff09e502b85a7) {
      var_1746a31099c6d5f7 = 1;
    }

    if(istrue(var_1746a31099c6d5f7) && !flag(var_5a53f28ba12e8c75)) {
      flag_set(var_5a53f28ba12e8c75);
    } else if(!istrue(var_1746a31099c6d5f7) && flag(var_5a53f28ba12e8c75)) {
      flag_clear(var_5a53f28ba12e8c75);
    }

    wait 0.25;
  }
}

function function_c98248e88663bfc6() {
  level endon("game_ended");
  level.player endon("death");
  level flag_wait("flag_ascender_tool_acquired");

  if(!flag("flag_ascender_tool_previously_found")) {
    wait 5;
    level.player scripts\cp\cp_hud_message::tutorialprint(&"CP_JUP_CHEMICAL/HINTASCENDER");
  }
}

function function_90995caf88d44aab() {
  level.player waittill("death");
  function_a583984eb78c6c32();
}

function function_bc4ceccca9528c7b() {
  level endon("game_ended");
  level.player endon("death");
  function_d307f2590e3f9841(0, 1, undefined, undefined, undefined, "crane_top");
  var_4c4f80af97738d40 = level.var_daa4457d192616c6 deck_draw();
  level function_c9a09b3ba9c68f8d(3, var_4c4f80af97738d40, 0.7, 4);
}

function function_b5103d032271b2a1() {
  level endon("game_ended");
  level.player endon("death");
  sequence = [];
  sequence[sequence.size] = [level.player, "dx_cp_chem_chac_pric_ontheroofseeingskyli"];
  sequence[sequence.size] = [level, 0.3, "dx_cp_chem_chac_lasw_nowweretalkin"];

  if(is_equal(level.checkpoint, "obj_reconArea_complete")) {
    wait 10;
  }

  function_d307f2590e3f9841(4, 1, undefined, undefined, undefined, "turbine_rooftop");
  level.player function_c9a09b3ba9c68f8d(0.3, sequence, 0.2, 1);
}

function vo_reactor_inaccessible_interacted() {
  level endon("game_ended");
  level.player endon("death");
  level endon("flag_obj_all_helis_killed");
  sequence = [];
  sequence[sequence.size] = [level.player, "dx_cp_chem_ranr_pric_watcherfoundanairloc"];
  sequence[sequence.size] = [level, 0.5, "dx_cp_chem_ranr_lasw_thatsthereactor06noe"];
  sequence[sequence.size] = [level.player, 0.6, "dx_cp_chem_ranr_pric_ifitkeepskonniout"];
  level waittill("vo_reactor_inaccessible_interacted");
  level.player function_c9a09b3ba9c68f8d(2, sequence, 1, 4);
}

function function_43eca70c1a099d41() {
  level endon("game_ended");
  level.player endon("death");
  level flag_wait("flag_obj_all_helis_killed");

  if(level.checkpoint == "obj_enterReactor_complete") {
    return;
  }

  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_rair_pric_watcherimattheentran"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_rair_pric_imattheentrancewatch"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_rair_pric_attheentrance"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_rair_pric_locatedtheentrance"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_epin_pric_imatanairlock"];
  deck = create_deck(aliases, undefined, 1);
  sequence = [];
  sequence[sequence.size] = deck deck_draw();
  sequence[sequence.size] = level.player;
  sequence[sequence.size] = 0.3;
  sequence[sequence.size] = "dx_cp_chem_hec4_lasw_copythat";

  while(true) {
    waitframe();

    while(!level.player function_28f3273faec1d365()) {
      wait 0.2;
    }

    if(namespace_a0852b262a68d01::function_155f16ed1b7f00cd()) {
      continue;
    }

    if(!function_94b00c0fad72704b([4])) {
      continue;
    }

    function_c9a09b3ba9c68f8d(1, sequence, 0.9, 4);
    return;
  }
}

function function_ed3f45c27aa13eb() {
  level endon("game_ended");
  level endon("flag_exit_interacted");
  level flag_wait("flag_reactor_airlock_passed");
  wait 2.5;
  sequence = [];
  sequence[sequence.size] = [level.player, &function_4e897a4399ed9ccc, "dx_cp_chem_airc_pric_makingentry"];
  sequence[sequence.size] = [level, 0.6, &function_d19d6af3dbdbbde9, "dx_cp_chem_airc_lasw_sayagainjohnyourebre"];
  sequence[sequence.size] = [level.gaz, &function_55762f03cbf9ea17, 0.3, "dx_cp_chem_airc_gazz_capnyouvegotanenemyh"];
  sequence[sequence.size] = [level.soap, 0.4, &function_e8044d7589b85bfc, "dx_cp_chem_airc_soap_konnifoundsomethingt"];
  say_sequence(sequence, 0.9, 25);
  wait 1;
  level flag_set("vo_reactor_airlock_transition_complete");
}

function function_4e897a4399ed9ccc() {
  thread namespace_11fae4a66a43bd3f::function_4b910d98963d85();
}

function function_d19d6af3dbdbbde9() {
  thread namespace_11fae4a66a43bd3f::function_197f9a69624466d4();
}

function function_55762f03cbf9ea17() {
  thread namespace_11fae4a66a43bd3f::function_568ed3749ee38a1a();
}

function function_e8044d7589b85bfc() {
  thread namespace_11fae4a66a43bd3f::function_1b8ce5a62a0f1a83();
}

function function_321dbb76740a1fda() {
  level endon("game_ended");
  level.player endon("death");
  level endon("flag_drop_chemical");
  level endon("flag_exit_interacted");
  level flag_wait("vo_reactor_airlock_transition_complete");
  wait 1;
  var_9471243e06551409 = [];
  var_9471243e06551409[var_9471243e06551409.size] = [level, "dx_cp_chem_airn_lasw_06sitrepdoyouhavevis"];
  var_9471243e06551409[var_9471243e06551409.size] = [level, "dx_cp_chem_airn_lasw_06doyoureadcanyoucon"];
  var_9471243e06551409[var_9471243e06551409.size] = [level.soap, "dx_cp_chem_airn_soap_captainwereintheblin"];
  level.var_c0c4bbddbce4416b = create_deck(var_9471243e06551409, 1, 1);
  var_d0ebe910de469658 = [];
  var_d0ebe910de469658[var_d0ebe910de469658.size] = [level.player, "dx_cp_chem_airo_pric_airlocksopen"];
  var_d0ebe910de469658[var_d0ebe910de469658.size] = [level.player, "dx_cp_chem_airo_pric_doorsopen"];
  var_d0ebe910de469658[var_d0ebe910de469658.size] = [level.player, "dx_cp_chem_airo_pric_airlocksopen_01"];
  level.var_109f96233fb3b448 = create_deck(var_d0ebe910de469658, 1, 1);
  nag_wait("flag_droptrigger_exited_airlock", [ &function_f6d91d9648b20fbb], growing_delay(5, 15, 5));
}

function function_f6d91d9648b20fbb() {
  var_d84e40483a27994d = getStructArray("airlock_nag_lookpoint", "targetname");
  var_8ed6ff4fdf60193f = function_61aef23379ae7542(var_d84e40483a27994d);

  if(isDefined(var_8ed6ff4fdf60193f)) {
    return level.var_109f96233fb3b448;
  }

  return level.var_c0c4bbddbce4416b;
}

function vo_reactor_enter() {
  level endon("game_ended");
  level endon("flag_drop_chemical_ally_attacks");
  level endon("flag_exit_interacted");
  level flag_wait("vo_reactor_enter");

  while(!function_b8ccbe8a7ffe6189()) {
    waitframe();
  }

  if(!flag("vo_stop_reactor_enter")) {
    sequence = [level.player, &function_d9c8be7f942e40fb, 0.3, level, "dx_cp_chem_konp_lasw_06canyouconfirmtheco", 0.2, level.player, &function_274bccaacb55cb59];
    level function_c9a09b3ba9c68f8d(0.5, sequence, 1, 1);
  }

  level flag_set("vo_reactor_enter_completed");
  level flag_set("flag_obj_chemicals_start");
}

function function_d9c8be7f942e40fb() {
  if(flag("vo_stop_reactor_enter")) {
    return 0;
  }

  return flag("reactor_combat_start") ? "dx_cp_chem_konp_pric_allstationskonnisext_01" : "dx_cp_chem_konp_pric_allstationskonnisext";
}

function function_274bccaacb55cb59() {
  if(flag("vo_stop_reactor_enter")) {
    return 0;
  }

  return flag("reactor_combat_start") ? "dx_cp_chem_konp_pric_negative" : "dx_cp_chem_konp_pric_negativeunknown";
}

function function_b8ccbe8a7ffe6189() {
  return function_3e2bc2bbbc65352a();
}

function vo_reactor_platform_ais_banter() {
  level endon("reactor_combat_start");
  aliases = ["dx_cp_chem_konp_kon1_palletsgoingup", "dx_cp_chem_konp_kon1_copywegotemliftingth", "dx_cp_chem_konp_kon1_steady", "dx_cp_chem_konp_kon1_cargosontheway"];
  deck = create_deck(aliases, undefined, 1);
  flag_wait("vo_reactor_platform_ais_banter");

  if(!isDefined(level.var_1f194d0a260f5a4a) || !isalive(level.var_1f194d0a260f5a4a)) {
    return;
  }

  level.var_1f194d0a260f5a4a say_team(deck deck_draw(), 0.8, 1);

  if(!isDefined(level.var_1f194c0a260f5817) || !isalive(level.var_1f194c0a260f5817)) {
    return;
  }

  level.var_1f194c0a260f5817 say_team(deck deck_draw(), 0.8, 1);
}

function vo_reactor_player_spotted() {
  level endon("game_ended");
  level.player endon("death");
  level endon("flag_exfil_allies_triggered");
  level flag_wait("vo_reactor_player_spotted");
  level.var_5706ce58a3348a2c function_31fcf0528e5d8d3f("dx_cp_chem_kogp_konl_141141inthereactorwe");
  level flag_set("vo_reactor_player_spotted_completed");
}

function function_ae0124b7e4b6a12f() {
  level endon("game_ended");
  level endon("flag_drop_chemical_ally_attacks");
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_koac_kon1_intrudergetamoveonex";
  aliases[aliases.size] = "dx_cp_chem_koac_kon2_killtheintruder";
  aliases[aliases.size] = "dx_cp_chem_koac_kon3_shoothim";
  deck = create_deck(aliases, undefined, 1);
  level flag_wait("vo_reactor_platform_ais_combat_banter_1");
  level.var_1f194d0a260f5a4a say(deck deck_draw(), 0.1, 3);
  level flag_wait("vo_reactor_platform_ais_combat_banter_2");
  level.var_1f194c0a260f5817 say(deck deck_draw(), 0.1, 3);
}

function function_9257439ca1b28dfd() {
  level endon("game_ended");
  level.player endon("death");
  level endon("flag_exit_interacted");
  level flag_wait("flag_drop_chemical");
  wait 9;
  sequence = [];
  sequence[sequence.size] = [level.player, "dx_cp_chem_r1ha_pric_allbravoputfireontha"];
  say_sequence(sequence, 1, 0);
  level.soap thread say("dx_cp_chem_r1ha_soap_copyengaging", 0.8, 0);
  level flag_set("vo_reactor_drop_chemical_start_completed");
}

function function_7d61581b58848b60() {
  level endon("game_ended");
  level flag_wait("flag_drop_chemical_ally_attacks");
  var_42822eabce3b0441 = function_fdc9d5557c53078e(level.var_44a2219576a45ab2);

  if(var_42822eabce3b0441.size == 0) {
    var_42822eabce3b0441 = function_fdc9d5557c53078e(level.var_d03989799d2951ee);

    if(var_42822eabce3b0441.size == 0) {
      return;
    }
  }

  speaker = random(var_42822eabce3b0441);
  speaker say("dx_cp_chem_kafa_kon1_palletscompromised", 1, 0);
  var_42822eabce3b0441 = function_fdc9d5557c53078e(var_42822eabce3b0441);

  if(var_42822eabce3b0441.size == 0) {
    var_42822eabce3b0441 = function_fdc9d5557c53078e(level.var_d03989799d2951ee);

    if(var_42822eabce3b0441.size == 0) {
      return;
    }
  }

  speaker = random(var_42822eabce3b0441);
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_kafa_kon1_pullitoutnow";
  aliases[aliases.size] = "dx_cp_chem_kafa_kon1_getitoutofhere";
  aliases[aliases.size] = "dx_cp_chem_kafa_kon1_gogogo";
  speaker say(random(aliases), 1, 0);
  level flag_wait("flag_canister_fall_start");
  var_42822eabce3b0441 = function_fdc9d5557c53078e(level.var_d03989799d2951ee);
  var_42822eabce3b0441 = array_exclude(var_42822eabce3b0441, level.var_44a2219576a45ab2);

  if(var_42822eabce3b0441.size == 0) {
    return;
  }

  speaker = random(var_42822eabce3b0441);
  speaker say("dx_cp_chem_kafa_kon1_wevegotspillage", 1, 0);
}

function function_50a39a5cc7719fbf() {
  level endon("game_ended");
  level endon("flag_escape_start");
  level flag_wait("vo_reactor_airlock_transition_complete");
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_mhre_pric_anglestoosteep";
  aliases[aliases.size] = "dx_cp_chem_mhre_pric_badangle";
  aliases[aliases.size] = "dx_cp_chem_mhre_pric_noshot";
  deck = create_deck(aliases, 1, 0);

  while(true) {
    level.player waittill("weapon_fired", objweapon);

    if(!isDefined(level.var_211342392eb633b9)) {
      continue;
    }

    if(weaponclass(objweapon) != "rocketlauncher") {
      continue;
    }

    var_e274235250d8ba5e = level.player say(deck deck_draw(), 1, 1);
  }
}

function function_8eb07f63783e8516() {
  level endon("game_ended");
  level.player endon("death");
  level flag_wait("vo_reactor_vial_on_ground_exploded");
  wait 0.5;
  sequence = [];
  sequence[sequence.size] = [level.player, "dx_cp_chem_chre_pric_fuckinhell"];
  sequence[sequence.size] = [0.8, level.player, "dx_cp_chem_chre_pric_allstationskonnisext"];
  level function_c9a09b3ba9c68f8d(0.4, sequence);
  level flag_set("vo_reactor_vial_on_ground_completed");
}

function function_ac6a77b3720d6fdc() {
  level endon("game_ended");
  level.player endon("death");
  level flag_wait("vo_reactor_vial_on_ground_completed");
  sequence = [];
  sequence[sequence.size] = [level, "dx_cp_chem_rhga_gazz_shitkonnisgotthegaso"];
  sequence[sequence.size] = [level, 0.4, "dx_cp_chem_rhga_ghos_watchercanyoutrackem"];
  sequence[sequence.size] = [level, 0.3, "dx_cp_chem_rhga_lasw_onitghoststandby"];
  level function_c9a09b3ba9c68f8d(0.5, sequence);
  level flag_set("vo_reactor_helo_escape_completed");
}

function function_eb9d4eb741b4ce3d() {
  level endon("game_ended");
  level flag_wait("vo_reactor_konni_pit_combat_banter_1");
  level.var_d03989799d2951ee = function_fdc9d5557c53078e(level.var_d03989799d2951ee);

  if(level.var_d03989799d2951ee.size > 0) {
    speaker = random(level.var_d03989799d2951ee);
    speaker say("dx_cp_chem_chre_kon1_thecannisterscomprom", 0.8, 3);
  }

  if(isDefined(level.var_8a82918039ae89fb) && isalive(level.var_8a82918039ae89fb)) {
    level.var_8a82918039ae89fb say("dx_cp_chem_chre_kon1_noicancontainit", 1, 3);
  }
}

function vo_reactor_chemical_released() {
  level endon("game_ended");
  level function_7a252abaaa15fcd7(["vo_reactor_chemical_released", "vo_reactor_konniwaves_begin_completed"]);
  sequence = [];
  sequence[sequence.size] = [level.gaz, "dx_cp_chem_chre_gazz_konniwasntafternucle"];
  sequence[sequence.size] = [level.ghost, "dx_cp_chem_chre_ghos_neverwere"];
  sequence[sequence.size] = [level.soap, "dx_cp_chem_chre_soap_chemswereherethewhol"];
  wait 1.5;
  function_c9a09b3ba9c68f8d(0.5, sequence);
  level flag_set("vo_reactor_chemical_released_completed");
}

function vo_reactor_escape() {
  level endon("game_ended");
  level function_7a252abaaa15fcd7(["vo_reactor_escape", "vo_reactor_helo_escape_completed"]);
  sequence = [];
  sequence[sequence.size] = [level.player, "dx_cp_chem_suga_pric_thisis06reactorsseal"];
  function_c9a09b3ba9c68f8d(0.7, sequence);

  if(flag("vo_play_ascender_vo_during_exposition")) {
    level.player function_c9a09b3ba9c68f8d(0.5, "dx_cp_chem_reae_pric_gotanascender");
  }

  level flag_set("vo_reactor_escape_completed");
  level flag_set("flag_obj_escape_start");
}

function function_f89bb5ae8d84c4ac() {
  level endon("game_ended");
  level.player endon("death");
  level endon("flag_exit_interacted");
  level flag_wait("flag_escape_start");

  while(!flag("flag_exit_interacted")) {
    level waittill("vo_reactor_gasdamage_cough");
    level.var_32e563a546dd9da7 = 1;
    var_e274235250d8ba5e = level.player say("dx_cp_chem_gaex_pric_coughing", 0.1, 0);
    level.var_32e563a546dd9da7 = 0;
  }
}

function vo_reactor_gasnear_floor3() {
  level endon("game_ended");
  level.player endon("death");
  level endon("flag_exfil_allies_triggered");
  level flag_wait("vo_reactor_gasnear_floor3");
  sequence = [];
  sequence[sequence.size] = [level.player, "dx_cp_chem_gasr_pric_gasisclosingbravowha"];
  sequence[sequence.size] = [level.gaz, "dx_cp_chem_fico_gazz_inboundnowbossstandb"];
  level say_sequence(sequence, 1, 0);
}

function vo_reactor_gasat_floor3() {
  level endon("game_ended");
  level.player endon("death");
  level endon("flag_exfil_allies_triggered");
  level flag_wait("vo_reactor_gasat_floor3");
  sequence = [];
  sequence[sequence.size] = [level.player, "dx_cp_chem_gasr_pric_gasisfillingthereact"];
  sequence[sequence.size] = [level.player, "dx_cp_chem_gasr_pric_bravoivegottamovefro"];
  level say_sequence(sequence, 1, 0);

  while(!function_74d4ab011fa76755()) {
    wait 1;
  }

  sequence = [];
  sequence[sequence.size] = [level.player, "dx_cp_chem_fico_pric_cantgoanyhigherthant"];
  sequence[sequence.size] = [level.player, "dx_cp_chem_fico_gazz_wereinboundcapnsitti"];
  level say_sequence(sequence, 0.2, 0);
}

function vo_reactor_safe_floor3() {
  level endon("game_ended");
  level.player endon("death");
  level endon("flag_exfil_allies_triggered");
  level flag_wait("vo_reactor_safe_floor3");
  sequence = [];
  sequence[sequence.size] = [level.player, "dx_cp_chem_gasr_pric_allstationsgroundflo"];
  sequence[sequence.size] = [level.gaz, "dx_cp_chem_fico_gazz_wereinboundcapnsitti"];
  level say_sequence(sequence, 0.2, 0);
}

function vo_reactor_ally_progress2() {
  level endon("game_ended");
  level.player endon("death");
  level endon("flag_exfil_allies_triggered");
  level flag_wait("vo_reactor_ally_progress2");
  level.gaz function_fc0eb6b81c66c661(2, "dx_cp_chem_fico_gazz_takecovercaptainwere", 0.1, 4);
}

function function_ba3c7df767be352c() {
  level endon("game_ended");
  level.player endon("death");
  level flag_wait("flag_allies_spawned");
  level.gaz function_31fcf0528e5d8d3f("dx_cp_chem_reke_gazz_captainwerehere");
  level flag_wait("flag_animated_rope_lowered");
  level.ghost function_31fcf0528e5d8d3f("dx_cp_chem_reke_ghos_grabtherope");
  level flag_set("flag_vo_rope_lowered_completed");
}

function function_317c0bf5cd329a53() {
  level endon("game_ended");
  level.player endon("death");
  level endon("flag_gas_at_floor3");
  level endon("flag_exfil_allies_triggered");
  level flag_wait("vo_reactor_konniwaves_begin_completed");
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_reft_pric_needsomefuckincover"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_reft_pric_imexposeduphereineed"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_reft_pric_icantstayupherethere"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_reft_pric_nocoveruphere"];
  deck = create_deck(aliases, 1, 1);

  if(istrue(level.var_d4aced3f42f82034)) {
    wait 5;
  }

  while(true) {
    while(!function_55ad2c57755c901()) {
      waitframe();
    }

    var_e274235250d8ba5e = level say_sequence(deck deck_draw(), 0.8, 0);

    if(istrue(var_e274235250d8ba5e)) {
      wait randomfloatrange(2, 5);
      continue;
    }

    waitframe();
  }
}

function function_55ad2c57755c901() {
  return level.player istouching(function_1c4d592029f2b0d3("vol_reactor_floor4"));
}

function function_afe2a68bafb57218() {
  level endon("game_ended");
  level.player endon("death");
  level endon("flag_exfil_allies_triggered");
  level flag_wait("reactor_doors_force_closed");

  if(function_1f067aa9b7648939()) {
    return;
  }

  level flag_wait("vo_reactor_chemical_released");

  if(function_1f067aa9b7648939()) {
    level flag_set("vo_play_ascender_vo_during_exposition");
    return;
  }

  level flag_wait("vo_reactor_konniwaves_begin_completed");

  while(true) {
    wait 1;

    if(function_1f067aa9b7648939()) {
      sequence = [];
      sequence[sequence.size] = [level.player, "dx_cp_chem_reae_pric_gotanascender_01"];
      sequence[sequence.size] = [level.gaz, "dx_cp_chem_stpu_gazz_holdwhatyougotcapnwe"];
      function_8f7dd478ffe07d07(sequence, undefined, "flag_exfil_allies_triggered");
      return;
    }
  }
}

function function_20028b9709374e42() {
  level endon("game_ended");
  level.player endon("death");
  level flag_wait("flag_vo_rope_lowered_completed");
  sequence = [];
  sequence[sequence.size] = [level.player, "dx_cp_chem_roan_pric_ineedanascender"];
  sequence[sequence.size] = [level.ghost, "dx_cp_chem_roan_ghos_checkforakonniascend"];
  level function_8f7dd478ffe07d07(sequence, &function_47034f354e29ebe9, "flag_exit_interacted");
  level flag_set("vo_reactor_exfil_missing_tool_completed");
}

function function_47034f354e29ebe9() {
  return !function_1f067aa9b7648939();
}

function vo_reactor_exfil_missing_tool_nag() {
  level endon("game_ended");
  level endon("flag_exit_interacted");
  level.player endon("death");
  sequence1 = [];
  sequence1[sequence1.size] = [level.player, "dx_cp_chem_roan_pric_coulduseanascender"];
  sequence1[sequence1.size] = [level.ghost, "dx_cp_chem_roan_ghos_checkbesideyouuseito"];
  sequence2 = [];
  sequence2[sequence2.size] = [level.player, "dx_cp_chem_roan_pric_wheresanascender"];
  sequence2[sequence2.size] = [level.ghost, "dx_cp_chem_roan_ghos_theresonenearcheckri"];
  aliases = [];
  aliases[aliases.size] = sequence1;
  aliases[aliases.size] = sequence2;
  level.var_5dc28140815bee55 = create_deck(aliases, 1, 0);

  while(true) {
    level waittill("vo_reactor_exfil_missing_tool_nag");
    level say_sequence(level.var_5dc28140815bee55 deck_draw(), 0.8, 0);
  }
}

function vo_reactor_exfil_rope_nag() {
  level endon("game_ended");
  level.player endon("death");
  level endon("flag_exit_interacted");
  level flag_wait("flag_vo_rope_lowered_completed");

  if(!function_1f067aa9b7648939()) {
    level flag_wait("vo_reactor_exfil_missing_tool_completed");
    wait 5;

    while(!flag("flag_ascender_tool_acquired")) {
      say_sequence(level.var_5dc28140815bee55 deck_draw(), 0.2, 0);
      wait randomfloatrange(3, 5);
    }
  }

  nags = [];
  nags[nags.size] = [level.gaz, "dx_cp_chem_ropn_gazz_gasisclosingingetont"];
  nags[nags.size] = [level.ghost, "dx_cp_chem_ropn_ghos_getouttathatgasprice"];
  deck = create_deck(nags, 1, 1);
  nag_wait("flag_exit_interacted", deck, growing_delay(1, 5, 3));
}

function vo_reactor_airlocks_hint() {
  level endon("game_ended");
  level.player endon("death");
  level endon("flag_gas_near_floor3");
  level endon("flag_exfil_allies_triggered");
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_ailo_pric_reactordoorsareseale";
  aliases[aliases.size] = "dx_cp_chem_ailo_pric_reactorslockeddowndo";
  aliases[aliases.size] = "dx_cp_chem_ailo_pric_reactorslockeddownno";
  aliases[aliases.size] = "dx_cp_chem_ailo_pric_reactorssealedtightn";
  deck = create_deck(aliases, undefined, 1);

  while(true) {
    level waittill("vo_reactor_airlocks_hint");
    level.player say_team(deck deck_draw(), 0.5, 0);
  }
}

function function_f7ccc631f578bc61() {
  level endon("game_ended");
  level.player endon("death");
  level flag_set("flag_meltyface_spawned");

  while(!isDefined(level.var_c5c3d3f12df66056)) {
    waitframe();
  }

  wait 0.5;
  level.var_c5c3d3f12df66056 say("dx_cp_chem_crtc_kon1_wehaveanotherangleca", 1, 10);
}

function vo_reactor_konniwaves_begin() {
  level endon("game_ended");
  level function_7a252abaaa15fcd7(["vo_reactor_konniwaves_begin", "vo_reactor_escape_completed"]);
  level say_team("dx_cp_chem_rek1_lasw_06isrshowskonniperso", 1, 0);

  if(level.player istouching(function_1c4d592029f2b0d3("vol_reactor_meltyface_exclusion"))) {
    sequence = [];
    sequence[sequence.size] = [level.player, "dx_cp_chem_reft_pric_icantstayupherethere"];
    sequence[sequence.size] = [level.soap, "dx_cp_chem_refm_soap_hardpointwhereyoucan"];
    var_e274235250d8ba5e = say_sequence(sequence, 1, 0);

    if(istrue(var_e274235250d8ba5e)) {
      level.var_d4aced3f42f82034 = 1;
    }
  } else {
    aliases = [];
    aliases[aliases.size] = [level.gaz, "dx_cp_chem_refm_gazz_findcovercapnwereono"];
    aliases[aliases.size] = [level.gaz, "dx_cp_chem_refm_gazz_sticktocoverwerehead"];
    aliases[aliases.size] = [level.gaz, "dx_cp_chem_refm_gazz_takecoverweremovingy"];
    deck = create_deck(aliases, undefined, 1);
    vo = deck deck_draw();
    vo[0] function_31fcf0528e5d8d3f(vo[1]);
  }

  wait 2;
  level flag_set("vo_reactor_konniwaves_begin_completed");
}

function vo_reactor_konniwaves_2() {
  level endon("game_ended");
  level endon("flag_gas_at_floor3");
  level flag_wait("vo_reactor_konniwaves_begin_completed");

  if(flag("flag_p1w2_started")) {
    level flag_wait("vo_reactor_konniwaves_2_part_2");
  } else {
    level flag_wait("vo_reactor_konniwaves_2");
  }

  if(!flag("flag_reactor_disallow_lowpri_vo")) {
    aliases = [];
    aliases[aliases.size] = [level.soap, "dx_cp_chem_korp_soap_headsupkonnistakingt"];
    aliases[aliases.size] = [level.soap, "dx_cp_chem_korp_soap_konnisaboveyoucapnst"];
    aliases[aliases.size] = [level.soap, "dx_cp_chem_korp_soap_checkhighkonnismovin"];
    deck = create_deck(aliases, undefined, 1);
    vo = deck deck_draw();
    vo[0] function_fc0eb6b81c66c661(2, vo[1], 0.5, 3);
  }
}

function vo_reactor_konniwaves_3() {
  level endon("game_ended");
  level endon("flag_gas_at_floor3");
  level flag_wait("vo_reactor_konniwaves_3");

  if(!flag("flag_reactor_disallow_lowpri_vo")) {
    aliases = [];
    aliases[aliases.size] = [level, "dx_cp_chem_rek3_lasw_morekonniareclosingi"];
    aliases[aliases.size] = [level, "dx_cp_chem_rek2_lasw_06visualonkonnireinf"];
    aliases[aliases.size] = [level, "dx_cp_chem_korp_lasw_eyeshigh06konnismovi"];
    aliases[aliases.size] = [level, "dx_cp_chem_rek3_lasw_bravo06multiplekonni"];
    deck = create_deck(aliases, undefined, 1);
    vo = deck deck_draw();
    vo[0] function_fc0eb6b81c66c661(2, vo[1], 0.5, 3);
  }
}

function vo_reactor_konniwaves_end() {
  level endon("game_ended");
  level flag_wait("vo_reactor_konniwaves_end");
  level.var_841cae3f1e141ba7 = function_fdc9d5557c53078e(level.var_841cae3f1e141ba7);

  if(level.var_841cae3f1e141ba7.size > 0) {
    speaker = random(level.var_841cae3f1e141ba7);
    speaker say("dx_cp_chem_crtc_kon1_hehasnowhereelsetogo", 1, 1);
  }

  level.var_841cae3f1e141ba7 = function_fdc9d5557c53078e(level.var_841cae3f1e141ba7);

  if(level.var_841cae3f1e141ba7.size > 0) {
    speaker = random(level.var_841cae3f1e141ba7);
    speaker say("dx_cp_chem_crtc_kon1_what", 1, 0);
  }

  level.var_841cae3f1e141ba7 = function_fdc9d5557c53078e(level.var_841cae3f1e141ba7);

  if(level.var_841cae3f1e141ba7.size > 0) {
    speaker = random(level.var_841cae3f1e141ba7);
    speaker say("dx_cp_chem_crtc_kon1_ohshithesgotfriendsh", 1, 3);
  }
}

function vo_konniwaves_banter_price_winning() {
  level endon("game_ended");
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_crtc_kon1_weretakingcasualties";
  aliases[aliases.size] = "dx_cp_chem_crtc_kon1_damnitmandown";
  aliases[aliases.size] = "dx_cp_chem_crtc_konl_takingfire";
  aliases[aliases.size] = "dx_cp_chem_crtc_konl_shitbringmehishead";
  aliases[aliases.size] = "dx_cp_chem_crtc_kon1_mandown";
  aliases[aliases.size] = "dx_cp_chem_crtc_kon1_howishestillalive";
  deck = create_deck(aliases, 1, 1);

  while(true) {
    level waittill("vo_konniwaves_banter_price_winning");
    level.var_841cae3f1e141ba7 = function_fdc9d5557c53078e(level.var_841cae3f1e141ba7);

    if(level.var_841cae3f1e141ba7.size > 0) {
      speaker = random(level.var_841cae3f1e141ba7);
      speaker say(deck deck_draw(), 0.5, 0);
    }
  }
}

function vo_konniwaves_banter_price_losing() {
  level endon("game_ended");
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_crtc_kon1_hesexposed";
  aliases[aliases.size] = "dx_cp_chem_crtc_kon1_heslowdown";
  aliases[aliases.size] = "dx_cp_chem_crtc_kon1_letthegasfinishhim";
  aliases[aliases.size] = "dx_cp_chem_crtc_kon1_suppresshim";
  aliases[aliases.size] = "dx_cp_chem_crtc_kon1_keephimpinnedtiltheg";
  deck = create_deck(aliases, 1, 1);

  while(true) {
    level waittill("vo_konniwaves_banter_price_losing");
    level.var_841cae3f1e141ba7 = function_fdc9d5557c53078e(level.var_841cae3f1e141ba7);

    if(level.var_841cae3f1e141ba7.size > 0) {
      speaker = random(level.var_841cae3f1e141ba7);
      speaker say(deck deck_draw(), 0.5, 0);
    }
  }
}

function function_404f55b59bf36864() {
  level endon("game_ended");
  level flag_wait("flag_reactor_combat_flow_areas_5");
  var_202f43123c617d52 = [];
  var_351a5f1307d4e1fc = function_1c4d592029f2b0d3("choreo_reactor_floor3");
  level.var_d03989799d2951ee = function_fdc9d5557c53078e(level.var_d03989799d2951ee);

  foreach(ai in level.var_d03989799d2951ee) {
    if(ai istouching(var_351a5f1307d4e1fc)) {
      var_202f43123c617d52 = array_add(var_202f43123c617d52, ai);
    }
  }

  aliases = [];
  aliases[aliases.size] = "dx_guid32da2f7e908b46dd8951a76a271bafac";
  aliases[aliases.size] = "dx_guid102d895a07a344a798f03dece028f702";
  deck = create_deck(aliases, 1, 1);

  if(var_202f43123c617d52.size > 0) {
    speaker = random(var_202f43123c617d52);
    var_202f43123c617d52 = array_remove(var_202f43123c617d52, speaker);
    speaker say(deck deck_draw(), 0.8, 5);
    wait randomfloatrange(3, 7);
    speaker = undefined;

    if(var_202f43123c617d52.size > 0) {
      speaker = random(var_202f43123c617d52);
    } else if(isDefined(level.var_c5c3d3f12df66056) && isalive(level.var_c5c3d3f12df66056)) {
      speaker = level.var_c5c3d3f12df66056;
    }

    if(isDefined(speaker)) {
      speaker say(deck deck_draw(), 0.8, 5);
    }
  }
}

function function_a1e10c0ef3839f79() {
  level endon("game_ended");
  level endon("flag_reactor_room_entered");
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_oobg_lasw_konnisinthefacilityj";
  aliases[aliases.size] = "dx_cp_chem_oobg_ghos_headbackpriceweneedy";
  aliases[aliases.size] = "dx_cp_chem_wohi_ghos_dontgetoutofrangeont";
  aliases[aliases.size] = "dx_cp_chem_wohi_ghos_keepfocusonthetarget";
  aliases[aliases.size] = "dx_cp_chem_wohi_lasw_noactivityinthatdire";
  aliases[aliases.size] = "dx_cp_chem_oobg_lasw_johnlookslikeyoureof";
  aliases[aliases.size] = "dx_cp_chem_oobg_ghos_needyouonthefieldaga";
  aliases[aliases.size] = "dx_cp_chem_oobg_ghos_getbacktothemissionc";
  aliases[aliases.size] = "dx_cp_chem_oobg_lasw_konnispushingontheob";
  aliases[aliases.size] = "dx_cp_chem_oobg_ghos_priceturnbackonpoint";
  aliases[aliases.size] = "dx_cp_chem_oobg_ghos_getbacktothemissiona";
  var_259cd31f0b384a67 = create_deck(aliases, undefined, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_oobp_lasw_captainlokoslikeyour";
  aliases[aliases.size] = "dx_cp_chem_oobp_lasw_youreleavingtheaojoh";
  aliases[aliases.size] = "dx_cp_chem_wohi_lasw_sixyouremovingfarfro";
  aliases[aliases.size] = "dx_cp_chem_wohi_lasw_youregettingfarfromt";
  aliases[aliases.size] = "dx_cp_chem_wohi_lasw_youremovingoffthetar";
  aliases[aliases.size] = "dx_cp_chem_oobp_ghos_needtodropinoverhere";
  aliases[aliases.size] = "dx_cp_chem_oobp_ghos_youredroppingoutofco";
  aliases[aliases.size] = "dx_cp_chem_oobp_lasw_needtostayontargetsi";
  aliases[aliases.size] = "dx_cp_chem_oobp_lasw_youredroppingoutofth";
  aliases[aliases.size] = "dx_cp_chem_oobp_lasw_bravo6dropbackontarg";
  aliases[aliases.size] = "dx_cp_chem_oobp_lasw_sixweneedyouonpointh";
  var_451bfc458ea3b1cd = create_deck(aliases, undefined, 1);
  flag_wait("enable_oob_vo");

  while(true) {
    function_d307f2590e3f9841(undefined, 1, undefined, undefined, undefined, "oob");

    if(level.player isonground()) {
      level function_fc0eb6b81c66c661(0.5, var_259cd31f0b384a67 deck_draw(), 0.5, 1);
    } else {
      level function_fc0eb6b81c66c661(0.5, var_451bfc458ea3b1cd deck_draw(), 0.5, 1);
    }

    wait 10;
  }
}

function function_ef4ae784f7d1b0cd() {
  level endon("game_ended");
  level endon("flag_obj_all_helis_killed");
  level.var_463a365601c80b7a = [];

  while(!flag("flag_obj_all_helis_killed")) {
    level waittill("c4_planted", stuckto, hitent);

    if(!isDefined(stuckto)) {
      continue;
    }

    if(isDefined(stuckto.targetname)) {
      if(stuckto.targetname == "veh_jup_atv" || stuckto.targetname == "veh_jup_jltv" || stuckto.targetname == "veh_jup_jltv_mg") {
        function_a8135402a6c9dad9(stuckto);
      }

      if(stuckto.model == "black::veh_jup_mil_ru_heli_transport_chemical") {
        function_a929c17d440be55d(stuckto);
      }
    }
  }
}

function function_a8135402a6c9dad9(stuckto) {
  if(flag("c4_vehicle_given")) {
    return;
  }

  if(!function_43167219abf74e0d([0, 1]) || function_1445c12552b674d4()) {
    return;
  }

  level function_c9a09b3ba9c68f8d(0.3, ["dx_cp_chem_flre_ghos_whatareyouworkingonp", level.player, "dx_cp_chem_flre_pric_vehiclemaintenance"], 0.4, 1);
  flag_set("c4_vehicle_given");
}

function function_a929c17d440be55d(stuckto) {
  if(!flag("initiated_lines")) {
    aliases = [];
    aliases[aliases.size] = [level.player, "dx_cp_chem_hec4_pric_chargesset", level, "dx_cp_chem_hec4_ghos_onyourmark"];
    aliases[aliases.size] = [level.player, "dx_cp_chem_hec4_pric_chargesplanted", level, "dx_cp_chem_hec4_lasw_copythat"];
    aliases[aliases.size] = [level.player, "dx_cp_chem_hec4_pric_armed", level, "dx_cp_chem_hec4_lasw_copy06hitit"];
    aliases[aliases.size] = [level.player, "dx_cp_chem_hec4_pric_chargeset_01"];
    aliases[aliases.size] = [level.player, "dx_cp_chem_hec4_pric_chargeplanted_01"];
    aliases[aliases.size] = [level.player, "dx_cp_chem_hec4_pric_goingexplosive_01"];
    aliases[aliases.size] = [level.player, "dx_cp_chem_hec4_pric_chargeset", level, "dx_cp_chem_hec4_ghos_hitit"];
    aliases[aliases.size] = [level.player, "dx_cp_chem_hec4_pric_chargeplanted", level, "dx_cp_chem_hec4_ghos_execute"];
    aliases[aliases.size] = [level.player, "dx_cp_chem_hec4_pric_setacharge", level, "dx_cp_chem_hec4_ghos_doit"];
    aliases[aliases.size] = [level.player, "dx_cp_chem_hec4_pric_goingexplosive", level, "dx_cp_chem_hec4_ghos_copythat"];
    level.var_74bbabd110c25e11 = create_deck(aliases, 1, 1);
    flag_set("initiated_lines");
  }

  if(function_1445c12552b674d4()) {
    if(function_94b00c0fad72704b([3, 0, 1, 2], undefined, 10)) {
      level.player function_c9a09b3ba9c68f8d(0.3, level.var_74bbabd110c25e11 deck_draw(), 0.5, 1);
    }
  }

  if(!flag("flag_alarm_triggered")) {
    if(!array_contains(level.var_463a365601c80b7a, stuckto.script_parameters) && !flag("vo_c4_first_heli")) {
      flag_set("vo_c4_first_heli");
      level.var_463a365601c80b7a = array_add(level.var_463a365601c80b7a, stuckto.script_parameters);

      if(function_94b00c0fad72704b([3, 0, 1, 2], undefined, 10)) {
        aliases = [level.player, "dx_cp_chem_stro_pric_plantingexplosiveson", level, "dx_cp_chem_stro_lasw_copytheydontknowyour"];
        level.player function_c9a09b3ba9c68f8d(0.3, aliases, 0.8, 1);
      }

      return;
    }

    if(!array_contains(level.var_463a365601c80b7a, stuckto.script_parameters) && !flag("vo_c4_second_heli")) {
      flag_set("vo_c4_second_heli");
      level.var_463a365601c80b7a = array_add(level.var_463a365601c80b7a, stuckto.script_parameters);

      if(function_94b00c0fad72704b([3, 0, 1, 2], undefined, 10)) {
        aliases = [level.player, "dx_cp_chem_stro_pric_explosivessetonsecon", level, "dx_cp_chem_stro_lasw_goodplantyourestillu"];
        level.player function_c9a09b3ba9c68f8d(0.3, aliases, 0.8, 1);
      }

      return;
    }

    if(!array_contains(level.var_463a365601c80b7a, stuckto.script_parameters) && !flag("vo_c4_third_heli")) {
      flag_set("vo_c4_third_heli");
      flag_set("vo_c4_planted_on_all_helis_stealth");
      level.var_463a365601c80b7a = array_add(level.var_463a365601c80b7a, stuckto.script_parameters);

      if(function_94b00c0fad72704b([3, 0, 1, 2], undefined, 10)) {
        aliases = [level.player, "dx_cp_chem_stro_pric_allstationsthreeexpl", level, "dx_cp_chem_stro_ghos_copythat", level, "dx_cp_chem_stro_gazz_waitingforthefirewor"];
        level.player function_c9a09b3ba9c68f8d(0.3, aliases, 0.8, 1);
      }

      return;
    }
  }

  var_420f65076a83d9f3 = gettime();
}

function function_ba344a2452bade79() {
  level endon("game_ended");
  level endon("chemical_turret_hacked");
  flag_wait("flag_pre_placed_turrets_setup");

  foreach(turret in level.var_ebc1f5321a243d72) {
    turret thread function_5103131ba645a0e();
  }

  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_geco_pric_sentryturretshere", level, 0.4, "dx_cp_chem_geco_ghos_searchanddestroyfire"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_geco_pric_konnihassentryturret", level, 0.4, "dx_cp_chem_geco_ghos_noarsenaliscompletew"];
  var_5d6a7881b15f3288 = create_deck(aliases, undefined, 1);

  while(true) {
    wait 0.25;
    flag_wait("flag_player_sees_sentry_turret");

    if(!function_94b00c0fad72704b([0, 1], 1)) {
      continue;
    }

    if(isDefined(level.var_de9b3bb2804a4da8) && !time_has_passed(level.var_de9b3bb2804a4da8, 60)) {
      continue;
    }

    level function_c9a09b3ba9c68f8d(0.5, var_5d6a7881b15f3288 deck_draw(), 0.5, 3);
    return;
  }
}

function function_5103131ba645a0e() {
  self endon("death");
  self endon("hacked");
  function_bdc60d1ad098faa4("flag_player_sees_sentry_turret", self.origin + (0, 0, 30), 60, 1, 2000, undefined, "flag_player_sees_sentry_turret", self);
  thread flag_clear_delayed("flag_player_sees_sentry_turret", 5);
}

function function_9c32642d9b5879d() {
  level endon("game_ended");
  flag_wait("flag_pre_placed_turrets_setup");
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_geco_lasw_sentriesareonyoubrav"];
  aliases[aliases.size] = [level, "dx_cp_chem_geco_lasw_watchthesentryturret"];
  var_d8fb32e556588f37 = create_deck(aliases, undefined, 1);

  while(true) {
    waittill_any_ents_array(level.var_ebc1f5321a243d72, "engaging_target");
    var_601f36565066065c = 0;

    foreach(turret in level.var_ebc1f5321a243d72) {
      if(isDefined(turret.curtarget) && is_equal(turret.curtarget, level.player)) {
        var_601f36565066065c = 1;
      }
    }

    if(!var_601f36565066065c) {
      continue;
    }

    wait 0.2;

    if(!function_94b00c0fad72704b([3, 0, 1])) {
      continue;
    }

    level.var_de9b3bb2804a4da8 = gettime();
    level function_c9a09b3ba9c68f8d(0.3, var_d8fb32e556588f37 deck_draw(), 0.8, 1);
    wait 180;
    level.var_ebc1f5321a243d72 = array_removeundefined(level.var_ebc1f5321a243d72);

    if(level.var_ebc1f5321a243d72.size == 0) {
      return;
    }
  }
}

function function_703931fcf4b7c0bc() {
  level endon("game_ended");
  flag_wait("flag_pre_placed_turrets_setup");
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_detn_pric_sentrysdisabled", &function_a4e4a9fc80e228fd, level, 0.3, "dx_cp_chem_detn_ghos_recommendcommandeeri"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_detn_pric_enemyturretsoffline", &function_a4e4a9fc80e228fd, level, 0.3, "dx_cp_chem_detn_ghos_advisegettingitbacko"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_detn_pric_konniturretsdisabled", &function_a4e4a9fc80e228fd, level, 0.3, "dx_cp_chem_detn_lasw_mightwannamakeitours"];
  var_bdd531767d14fdbd = create_deck(aliases, undefined, 1);

  while(true) {
    waittill_any_ents_array(level.var_ebc1f5321a243d72, "hacked");
    level notify("chemical_turret_hacked");
    wait 0.2;

    if(!function_94b00c0fad72704b([0, 1, 2], 1, undefined, 700)) {
      continue;
    }

    level function_c9a09b3ba9c68f8d(0.3, var_bdd531767d14fdbd deck_draw(), 0.7, 1);
    wait 30;
    level.var_ebc1f5321a243d72 = array_removeundefined(level.var_ebc1f5321a243d72);

    if(level.var_ebc1f5321a243d72.size == 0) {
      return;
    }
  }
}

function function_9a4dca769694ba24() {
  level endon("game_ended");
  flag_wait("flag_pre_placed_turrets_setup");
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_detc_pric_sentrysours"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_detc_pric_turretshacked"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_detc_pric_turretsours"];
  var_91bc1a2769f69a92 = create_deck(aliases, undefined, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_haet_pric_turretsours"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_haet_pric_turretshacked"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_haet_pric_sentrysminenow"];
  var_ca3a42df69183d5 = create_deck(aliases, undefined, 1);

  while(true) {
    waittill_any_ents_array(level.var_ebc1f5321a243d72, "converted");
    wait 0.2;

    if(!function_94b00c0fad72704b([0, 1, 2])) {
      continue;
    }

    level function_c9a09b3ba9c68f8d(0.3, function_cd70fbc5ff85bc7d(var_91bc1a2769f69a92, var_ca3a42df69183d5), 0.7, 1);
    wait 60;
  }
}

function function_905425efe3b7f3c8() {
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_geco_lasw_yourepinnedcaptainge"];
  aliases[aliases.size] = [level, "dx_cp_chem_geco_lasw_theyreswarmingcaptai"];
  var_46cef68c68570528 = create_deck(aliases, undefined, 1);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_geco_lasw_konnisallaroundyoujo"];
  aliases[aliases.size] = [level, "dx_cp_chem_geco_lasw_carefulyourekneedeep"];
  aliases[aliases.size] = [level, "dx_cp_chem_geco_lasw_headsuplotsofhostile"];
  aliases[aliases.size] = [level, "dx_cp_chem_geco_lasw_mulitplekonniteamsco"];
  aliases[aliases.size] = [level, "dx_cp_chem_enwa_lasw_yougothostilesclosin"];
  aliases[aliases.size] = [level, "dx_cp_chem_enwa_lasw_beadvisedsquadofkonn"];
  aliases[aliases.size] = [level, "dx_cp_chem_enwa_lasw_konnipatrolsinyourar"];
  var_85e76067f63a9043 = create_deck(aliases, undefined, 1);

  while(true) {
    wait 10;
    nearby_enemies = function_299424620c86e0e0(level.player, 1300);

    if(nearby_enemies.size < 5) {
      continue;
    }

    if(!time_has_passed(level.var_37d4ce8c2aa043ce, 15)) {
      continue;
    }

    if(!function_94b00c0fad72704b([0, 1])) {
      continue;
    }

    var_9a3306f2015e540c = var_85e76067f63a9043;

    if(function_1445c12552b674d4()) {
      var_9a3306f2015e540c = var_46cef68c68570528;
    }

    level function_c9a09b3ba9c68f8d(0.5, var_9a3306f2015e540c deck_draw(), 0.8, 1);
    level.var_37d4ce8c2aa043ce = gettime();
    wait 180;
  }
}

function function_880046b51f10709a() {
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_geco_ghos_pricewatchforhostile", level.player, 0.2, "dx_cp_chem_geco_pric_copythanks"];
  aliases[aliases.size] = [level, "dx_cp_chem_geco_ghos_seeingkonnisonthehig", level.player, 0.2, "dx_cp_chem_geco_pric_illgettothem"];
  aliases[aliases.size] = [level, "dx_cp_chem_geco_ghos_priceseeingkonnionth", level.player, 0.2, "dx_cp_chem_geco_pric_goodeyeghost"];
  var_1039017d59a33e33 = create_deck(aliases, undefined, 1);
  flag_wait("flag_heli_1_backup_unloaded");
  wait 5;

  if(!function_94b00c0fad72704b([0, 1, 2, 4], 0) && flag("player_outside")) {
    return;
  }

  level function_c9a09b3ba9c68f8d(0.5, var_1039017d59a33e33 deck_draw(), 0.8, 5);
}

function function_2d3c30991cdeb505(driver, responder) {
  aliases = [];
  aliases[aliases.size] = [driver, "dx_cp_chem_geco_kon1_anything", &function_a4e4a9fc80e228fd, responder, 0.2, "dx_cp_chem_geco_kon1_notyetstillsearching"];
  aliases[aliases.size] = [driver, "dx_cp_chem_geco_kon1_alpha02snotherecapta", &function_a4e4a9fc80e228fd, responder, 0.2, "dx_cp_chem_geco_kon1_charlie03smiacheckin"];
  var_1fe1dd62747fadf7 = create_deck(aliases, undefined, 1);

  if(!function_94b00c0fad72704b([0, 1, 2])) {
    return;
  }

  if(distance(driver.origin, level.player.origin) > 2000) {
    return;
  }

  driver endon("death");
  driver endon("damage");
  responder endon("death");
  responder endon("damage");
  driver set_battlechatter(0);
  responder set_battlechatter(0);
  wait 1;
  level say_sequence(var_1fe1dd62747fadf7 deck_draw(), 0.8, 5);
  driver set_battlechatter(1);
  responder set_battlechatter(1);
}

function function_e8351029bc19767e() {
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_geco_kon1_intruderonsitepursui";
  aliases[aliases.size] = "dx_cp_chem_geco_kon1_hostileintheao";
  aliases[aliases.size] = "dx_cp_chem_geco_kon1_unknownhostileonsite";
  var_33e9e8c1431c45f8 = create_deck(aliases, undefined, 1);
  driver = self.riders[0];
  self waittill("unloading");

  if(!ent_flag("jltv_aggro_unload")) {
    return;
  }

  if(!function_94b00c0fad72704b([0, 1, 2])) {
    return;
  }

  if(distance(driver.origin, level.player.origin) > 3000) {
    return;
  }

  driver endon("death");
  driver endon("damage");
  driver set_battlechatter(0);
  wait 0.5;
  driver say(var_33e9e8c1431c45f8 deck_draw(), 1, 3);
  driver set_battlechatter(1);
}

function function_e2ed6513d9251dbd() {
  if(!isDefined(self)) {
    return;
  }

  self endon("death");
  self endon("unloaded");
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_geco_ghos_patrolvehiclesclosey"];
  aliases[aliases.size] = [level, "dx_cp_chem_geco_ghos_patrolvehicleheading"];
  aliases[aliases.size] = [level, "dx_cp_chem_geco_lasw_beadvisedkonnisgotap"];
  aliases[aliases.size] = [level, "dx_cp_chem_geco_lasw_konnivehiclecomingyo"];
  aliases[aliases.size] = [level, "dx_cp_chem_geco_ghos_konnivehiclecomingyo"];
  var_f3f293d2dac67180 = create_deck(aliases, undefined, 1);
  aliases = [];
  aliases[aliases.size] = [ &function_a4e4a9fc80e228fd, level.player, "dx_cp_chem_geco_pric_illhandleit"];
  aliases[aliases.size] = [ &function_a4e4a9fc80e228fd, level.player, "dx_cp_chem_geco_pric_copyvehicle"];
  var_7186ce4534aecb3b = create_deck(aliases, undefined, 1);

  while(isDefined(self)) {
    wait 1;

    if(distance(self.origin, level.player.origin) > 2000) {
      continue;
    }

    if(!function_94b00c0fad72704b([0, 2], 1, 10)) {
      continue;
    }

    break;
  }

  if(!isDefined(self)) {
    return;
  }

  var_4c4f80af97738d40 = array_combine(var_f3f293d2dac67180 deck_draw(), var_7186ce4534aecb3b deck_draw());
  level function_c9a09b3ba9c68f8d(1, var_4c4f80af97738d40, 0.8, 2);
}

function function_21a64e85f0a7fae2() {
  flag_wait("flag_patrol_approaching_suspicious_site");
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_geco_lasw_patrolsclosingtheyre"];
  aliases[aliases.size] = [level, "dx_cp_chem_geco_lasw_bravo6theyreontoyou"];
  var_27b1b1d72d2b8ec1 = create_deck(aliases, undefined, 1);

  if(!function_94b00c0fad72704b([0, 1], 1)) {
    return;
  }

  if(distance(level.intro_jltv_2.origin, level.player.origin) > 3000) {
    return;
  }

  level function_c9a09b3ba9c68f8d(1, var_27b1b1d72d2b8ec1 deck_draw(), 0.8, 3);
}

function function_693b854402e0d21e() {
  level endon("game_ended");
  level endon("flag_poor_driver_vo_said");

  while(true) {
    level.player waittill("entered_vehicle");
    level thread function_40dba603c5d3c25();
  }
}

function function_40dba603c5d3c25() {
  level.player endon("vehicle_exit");

  while(!isDefined(level.player.vehicle)) {
    wait 0.5;
  }

  player_vehicle = level.player.vehicle;
  var_e21efbdd508c42f4 = 0;
  var_cccc1fc5d5820507 = 8;
  var_e9a69ce763b3f46 = 30;
  var_dd52b12f8d99e99e = 1000;
  hit_times = [];
  var_98737773354467ac = [];

  while(true) {
    wait 1;
    player_vehicle waittill("collision");
    hit_times[hit_times.size] = gettime();
    var_98737773354467ac[var_98737773354467ac.size] = player_vehicle.origin;

    if(hit_times.size < var_cccc1fc5d5820507) {
      continue;
    }

    var_18629f5a54b995f9 = hit_times[hit_times.size - var_cccc1fc5d5820507];

    if(time_has_passed(var_18629f5a54b995f9, var_e9a69ce763b3f46)) {
      continue;
    }

    var_d5f4a6cb5f8b6b6d = var_98737773354467ac[var_98737773354467ac.size - var_cccc1fc5d5820507];

    if(distance(var_d5f4a6cb5f8b6b6d, player_vehicle.origin) > var_dd52b12f8d99e99e) {
      continue;
    }

    break;
  }

  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_flre_lasw_maybeyoushouldwalkjo"];
  aliases[aliases.size] = [level, "dx_cp_chem_flre_lasw_adviseyouditchtheveh"];
  var_ab5549b14eba238 = create_deck(aliases, undefined, 1);

  if(!function_94b00c0fad72704b([0, 1], 1, 2)) {
    return;
  }

  level function_c9a09b3ba9c68f8d(0.5, var_ab5549b14eba238 deck_draw(), 0.5, 5);
  flag_set("flag_poor_driver_vo_said");
}

function function_a277c3cb045aa9ea() {
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_geco_ghos_watchtherooftopsfore"];
  aliases[aliases.size] = [level, "dx_cp_chem_geco_ghos_watchitenemiesonther"];
  aliases[aliases.size] = [level, "dx_cp_chem_geco_ghos_watchforenemiesonthe"];
  aliases[aliases.size] = [level, "dx_cp_chem_geco_ghos_watchtherooftopsfork"];
  aliases[aliases.size] = [level, "dx_cp_chem_geco_ghos_allstationseyeshighf"];
  var_dd2362d68a358bf9 = create_deck(aliases, undefined, 1);
  aliases = [];
  aliases[aliases.size] = [ &function_a4e4a9fc80e228fd, level.player, "dx_cp_chem_geco_pric_copygoodlookinoutgho"];
  var_333f34007a023305 = create_deck(aliases, undefined, 1);
  var_d8ecf0ad691e687a = "";

  while(true) {
    function_d307f2590e3f9841([0, 1], 1, undefined, undefined, undefined, undefined, "flag_rooftop_guys_warning");
    var_1e0ca6dd7d2c0b0f = function_29e347ba0fe6f857();

    if(is_equal(var_1e0ca6dd7d2c0b0f, var_d8ecf0ad691e687a)) {
      continue;
    }

    var_d8ecf0ad691e687a = var_1e0ca6dd7d2c0b0f;

    if(!flag("flag_rooftop_warning_response_said")) {
      var_4c4f80af97738d40 = array_combine(var_dd2362d68a358bf9 deck_draw(), var_333f34007a023305 deck_draw());
      flag_set("flag_rooftop_warning_response_said");
    } else {
      var_4c4f80af97738d40 = var_dd2362d68a358bf9 deck_draw();
    }

    level function_c9a09b3ba9c68f8d(1, var_4c4f80af97738d40, 0.8, 5);
    wait 90;
  }
}

function function_3f99278691be58cf(var_168cd8307a3f8807) {
  if(flag("flag_combat_kickoff_vo_at_heli_" + var_168cd8307a3f8807)) {
    return;
  }

  flag_set("flag_combat_kickoff_vo_at_heli_" + var_168cd8307a3f8807);

  if(!isDefined(level.var_73bc6f31abadb81b)) {
    level.var_73bc6f31abadb81b = [];
    aliases = [];
    aliases[aliases.size] = "dx_cp_chem_geco_kon1_hesatcontainment";
    aliases[aliases.size] = "dx_cp_chem_geco_kon1_hostilespottedincont";
    aliases[aliases.size] = "dx_cp_chem_geco_kon1_allunitshostilesinco";
    level.var_73bc6f31abadb81b[1] = create_deck(aliases, undefined, 1);
    aliases = [];
    aliases[aliases.size] = "dx_cp_chem_geco_kon1_hostileinthesprayzon";
    aliases[aliases.size] = "dx_cp_chem_geco_kon1_allunitshesinthespra";
    aliases[aliases.size] = "dx_cp_chem_geco_kon1_hostilesightedinthes";
    level.var_73bc6f31abadb81b[2] = create_deck(aliases, undefined, 1);
    aliases = [];
    aliases[aliases.size] = "dx_cp_chem_geco_kon1_hesintheparkinglot";
    aliases[aliases.size] = "dx_cp_chem_geco_kon1_hostilesightedinthep";
    aliases[aliases.size] = "dx_cp_chem_geco_kon1_allunitshostileinthe";
    level.var_73bc6f31abadb81b[3] = create_deck(aliases, undefined, 1);
  }

  self endon("death");
  self endon("damage");
  var_b7648bc563e9a0a = level.var_73bc6f31abadb81b[var_168cd8307a3f8807];

  if(!function_94b00c0fad72704b([0, 1, 2])) {
    return;
  }

  wait 0.2;
  set_battlechatter(0);
  say_self(var_b7648bc563e9a0a deck_draw());
  set_battlechatter(1);
}

function function_8fdec6f44d407720() {
  self endon("death");

  while(true) {
    self waittill("missile_fire");

    if(isDefined(level.var_92b3101bedd41792) && !time_has_passed(level.var_92b3101bedd41792, 180)) {
      continue;
    }

    if(!function_94b00c0fad72704b([0, 1, 2, 4])) {
      continue;
    }

    break;
  }

  level.var_92b3101bedd41792 = gettime();

  if(!isDefined(level.var_a849dedde5b0a801)) {
    aliases = [];
    aliases[aliases.size] = "dx_cp_chem_geco_pric_takingheavyfirerpgs";
    aliases[aliases.size] = "dx_cp_chem_geco_pric_takingrpgfire";
    level.var_a849dedde5b0a801 = create_deck(aliases, 1, 1);
    aliases[aliases.size] = "dx_cp_chem_geco_pric_rpgsfromtheroofs";
    level.var_8fac9bec564558c7 = create_deck(aliases, 1, 1);
  }

  if(self.origin[2] > 1350) {
    level.player function_c9a09b3ba9c68f8d(0.3, level.var_8fac9bec564558c7 deck_draw(), 0.8, 1);
    return;
  }

  level.player function_c9a09b3ba9c68f8d(0.3, level.var_a849dedde5b0a801 deck_draw(), 0.8, 1);
}

function function_a086f3227105bc58() {
  level endon("game_ended");
  level.player endon("death");
  flag_wait("flag_vo_on_landing");
  wait 5;
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_pall_ghos_pricetheresagearpall"];
  var_1186c7338455fce3 = create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_wohi_pric_watcherapproachingap", level, 0.8, "dx_cp_chem_wohi_lasw_useittoputahurtonthe"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_wohi_pric_approachingapalletdr", level, 0.8, "dx_cp_chem_wohi_lasw_checkunleashholyhell"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_wohi_pric_movingtowardapalletd", level, 0.8, "dx_cp_chem_wohi_lasw_copyuseittoyouradvan"];
  aliases[aliases.size] = [level, "dx_cp_chem_pall_lasw_grabsomegearatthepal"];
  level.var_a190a71d6eef0ff0 = create_deck(aliases, undefined, 1);
  var_979b83145e83c366 = [];
  level.var_2ae9b1edaea46cd4 = getStructArray("vo_pallet_loc", "targetname");
  vols = function_3fd029c94a177d06("vol_141_drop");

  foreach(vol in vols) {
    thread function_4b6515d35360eca7(vol);
  }
}

function function_4b6515d35360eca7(vol) {
  level endon("game_ended");
  level.player endon("death");
  level endon("flag_reactor_airlock_passed");

  while(!flag("flag_reactor_airlock_passed")) {
    while(level.player istouching(vol)) {
      look_at = function_61aef23379ae7542(level.var_2ae9b1edaea46cd4, undefined, undefined, 1200);

      if(isDefined(look_at)) {
        if(function_94b00c0fad72704b([0, 1], 1, 3)) {
          level function_c9a09b3ba9c68f8d(0.6, level.var_a190a71d6eef0ff0 deck_draw(), 0.5, 1);
          return;
        } else {
          return;
        }
      }

      wait 0.25;
    }

    wait 0.5;
  }
}

function function_33301d971afddb48() {
  level endon("game_ended");
  flag_wait("flag_vo_on_landing");
  wait 5;
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_pall_ghos_captainspottedapalle"];
  aliases[aliases.size] = [level, "dx_cp_chem_pall_ghos_sawapalletatthefires"];
  var_831d19f2f69ea530 = create_deck(aliases, undefined, 1);
  vol = function_1c4d592029f2b0d3("vol_141_drop_firehouse");
  var_48abf54dd23008d8 = function_1c4d592029f2b0d3("vol_141_drop_fire_complete");

  while(true) {
    if(level.player istouching(var_48abf54dd23008d8)) {
      return;
    }

    if(level.player istouching(vol) && function_94b00c0fad72704b([0, 1], 1, 5)) {
      level function_c9a09b3ba9c68f8d(0.3, var_831d19f2f69ea530 deck_draw(), 0.5, 1);
      return;
    }

    waitframe();
  }
}

function function_f7a188f6c5c5204d() {
  level endon("game_ended");
  flag_wait("flag_vo_on_landing");
  wait 5;
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_pall_lasw_theresapalletnearbyg";
  aliases[aliases.size] = "dx_cp_chem_pall_lasw_sixyoureclosetoapall";
  var_1349fe7346564e37 = create_deck(aliases, undefined, 1);
  vol = function_1c4d592029f2b0d3("vol_141_drop_construction");
  var_48abf54dd23008d8 = function_1c4d592029f2b0d3("vol_141_drop_construction_complete");

  while(true) {
    if(level.player istouching(var_48abf54dd23008d8)) {
      return;
    }

    if(level.player istouching(vol) && function_94b00c0fad72704b([0, 1], 1, 5)) {
      level function_c9a09b3ba9c68f8d(0.3, var_1349fe7346564e37 deck_draw(), 0.5, 1);
      return;
    }

    waitframe();
  }
}

function function_fc0715c36b596067() {
  level endon("game_ended");
  flag_wait("flag_vo_on_landing");
  wait 5;
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_pall_ghos_captainiseeapalleton";
  aliases[aliases.size] = "dx_cp_chem_pall_lasw_palletsontheroofunde";
  var_3f5fc25655c717c9 = create_deck(aliases, undefined, 1);
  vol = function_1c4d592029f2b0d3("vol_141_drop_turbine");
  var_48abf54dd23008d8 = function_1c4d592029f2b0d3("vol_141_drop_turbine_complete");

  while(true) {
    if(level.player istouching(var_48abf54dd23008d8)) {
      return;
    }

    if(level.player istouching(vol) && function_94b00c0fad72704b([0, 1], 1, 5)) {
      level function_fc0eb6b81c66c661(0.5, var_3f5fc25655c717c9 deck_draw(), 0.5, 1);
      return;
    }

    waitframe();
  }
}

function function_8edff60b7434fd() {
  level endon("game_ended");
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_lcre_lasw_supplycratesnearyour";
  aliases[aliases.size] = "dx_cp_chem_lcre_lasw_gotacrateinyourvicin";
  aliases[aliases.size] = "dx_cp_chem_lcre_lasw_allbravosupplydropsa";
  aliases[aliases.size] = "dx_cp_chem_lcre_lasw_bravobeadvisedtherea";
  aliases[aliases.size] = "dx_cp_chem_lcre_lasw_supplypalletshavebee";
  aliases[aliases.size] = "dx_cp_chem_lcre_lasw_yourenearoneofourair";
  aliases[aliases.size] = "dx_cp_chem_lcre_lasw_supplycratesnearyour_01";
  aliases[aliases.size] = "dx_cp_chem_lcre_lasw_gotacrateinyourvicin_01";
  aliases[aliases.size] = "dx_cp_chem_lcre_lasw_seeingacratesnearyou";
  aliases[aliases.size] = "dx_cp_chem_lcre_lasw_johnsupplycratesnear";
  aliases[aliases.size] = "dx_cp_chem_lcre_lasw_allbravosupplydropsa_01";
  aliases[aliases.size] = "dx_cp_chem_lcre_lasw_bravobeadvisedtherea_01";
  aliases[aliases.size] = "dx_cp_chem_lcre_lasw_supplypalletshavebee_01";
  var_a9bf1d3fbeaa60bd = create_deck(aliases, undefined, 1);
  vol = function_1c4d592029f2b0d3("vol_loadout_crate");

  while(true) {
    if(level.player istouching(vol)) {
      function_d307f2590e3f9841([0, 1], 1, 5);
      level function_fc0eb6b81c66c661(0.5, var_a9bf1d3fbeaa60bd deck_draw(), 0.5, 1);
      return;
    }

    wait 1;
  }
}

function function_b0436758aa12db92() {
  level endon("game_ended");
  level.player endon("death");
  aliases = [];
  aliases[aliases.size] = ["dx_cp_chem_ally_pric_scanningthearea"];
  aliases[aliases.size] = ["dx_cp_chem_ally_pric_scopingthearea"];
  aliases[aliases.size] = ["dx_cp_chem_ally_pric_scanningthearea_01"];
  var_ec7c2413ed32007e = create_deck(aliases, 1, 1);
  var_c1dd207783bf9692 = [level, 0.6, "dx_cp_chem_ally_ghos_copy"];
  var_d37ae75fcadde388 = array_combine(var_ec7c2413ed32007e deck_draw(), var_c1dd207783bf9692);
  var_80d9f25079f4ccff = 1;

  while(true) {
    level.player waittill("binoculars_ads_on");
    flag_set("flag_player_ever_scoped");

    if(!function_94b00c0fad72704b([0, 1], 1, 2, 600, 5)) {
      continue;
    }

    if(var_80d9f25079f4ccff) {
      level.player function_c9a09b3ba9c68f8d(0.2, var_d37ae75fcadde388, 0.5, 5);
    } else {
      level.player function_c9a09b3ba9c68f8d(0.2, var_ec7c2413ed32007e deck_draw(), 0.5, 5);
    }

    var_80d9f25079f4ccff = 0;
    wait 90;
  }
}

function function_1d977456094e1f4f() {
  level endon("game_ended");
  aliases = [];
  aliases[aliases.size] = ["dx_cp_chem_chsc_pric_thatcranecouldbeaway"];
  aliases[aliases.size] = ["dx_cp_chem_chsc_pric_couldaccessthereacto"];
  aliases[aliases.size] = ["dx_cp_chem_chsc_pric_thatcranecouldputmeo"];
  aliases[aliases.size] = ["dx_cp_chem_chsc_pric_couldaccessthereacto_01"];
  var_a12b5bb11f0513c9 = create_deck(aliases, 1, 1);

  while(true) {
    level waittill("recon_poi_crane_seen");

    if(!function_94b00c0fad72704b([0, 1, 4], 1)) {
      continue;
    }

    if(function_94b00c0fad72704b([0, 1])) {
      if(flag("flag_ascender_tool_acquired")) {
        level.player function_fc0eb6b81c66c661(0.8, "dx_cp_chem_chsc_ghos_anascenderllgetyouup", 0.5, 5);
      } else {
        level.player function_fc0eb6b81c66c661(0.8, "dx_cp_chem_chsc_ghos_ladderscagedoffanasc", 0.5, 5);
      }
    }

    if(function_94b00c0fad72704b(4)) {
      level.player function_fc0eb6b81c66c661(0.8, var_a12b5bb11f0513c9 deck_draw(), 0.5, 3);
    }

    level.var_abcb2fbd2517634d = gettime();
    return;
  }
}

function function_a72e8f4dad5eb6c9() {
  level endon("game_ended");

  while(true) {
    level waittill("recon_poi_turbine_seen");

    if(!function_94b00c0fad72704b([0, 1, 4], 1)) {
      continue;
    }

    if(flag("flag_ascender_tool_acquired") && flag("flag_obj_all_helis_killed")) {
      level.player function_fc0eb6b81c66c661(0.8, "dx_cp_chem_chst_pric_visualonthereactorro", 0.8, 3);
    }

    if(!flag("flag_ascender_tool_acquired") && flag("flag_obj_all_helis_killed")) {
      level.player function_fc0eb6b81c66c661(0.8, "dx_cp_chem_chst_pric_notseeingagoodentryp", 0.8, 3);
    }

    if(!flag("flag_obj_all_helis_killed")) {
      level.player function_c9a09b3ba9c68f8d(0.8, ["dx_cp_chem_chst_pric_eyesonthereactorroof", level, 0.4, "dx_cp_chem_chst_ghos_affirmascenderllgety"], 0.8, 3);
    }

    level.var_abcb2fbd2517634d = gettime();
    return;
  }
}

function function_bad14d63875a9d63() {
  level endon("game_ended");

  while(true) {
    level waittill("recon_poi_entrancewing_seen");

    if(!function_94b00c0fad72704b([0, 1], 1)) {
      continue;
    }

    level.player function_c9a09b3ba9c68f8d(0.8, ["dx_cp_chem_chse_pric_notseeinggroundacces", level, 0.3, "dx_cp_chem_chse_lasw_checkhighforotherway"], 0.5, 5);
    return;
  }
}

function function_58cf0a7b623b069b() {
  level endon("game_ended");
  level endon("flag_reactor_room_entered");

  while(true) {
    level waittill("recon_poi_pipeworks_seen");

    if(!function_94b00c0fad72704b([0, 1], 1)) {
      continue;
    }

    level.player function_fc0eb6b81c66c661(0.8, "dx_cp_chem_pois_pric_watcheriseekonnipost", 0.5, 5);
    return;
  }
}

function function_96975ba65a514717() {
  level endon("flag_reactor_room_entered");
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_spmi_pric_novisualonthehelosne"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_spmi_pric_noactivityatthepower"];
  var_360fcd1d97ac4e5d = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_spmi_ghos_copywegottahitthoseh"];
  aliases[aliases.size] = [level, "dx_cp_chem_spmi_ghos_checkstillgothelosto"];
  aliases[aliases.size] = [level, "dx_cp_chem_spmi_ghos_advisetakinoutthoseh"];
  var_c59eb69b57fb5e5d = create_deck(aliases, 1, 1);

  while(true) {
    wait 0.5;
    level waittill("recon_poi_power_lines", var_e5b495906761a6cc);

    if(!function_94b00c0fad72704b([0, 1], 1, 3)) {
      continue;
    }

    level.player function_c9a09b3ba9c68f8d(0.8, [var_360fcd1d97ac4e5d deck_draw(), 0.4, var_c59eb69b57fb5e5d deck_draw()], 0.5, 3);
    return;
  }
}

function function_8c6d191a8031541e() {
  level endon("flag_reactor_room_entered");
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_pois_pric_firehouseiscrawlingw", level, 0.3, "dx_cp_chem_pois_lasw_couldbeimportantjohn"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_pois_pric_pickingupatransponde", level, 0.3, "dx_cp_chem_pois_lasw_usefulifyoucangetyou"];
  var_1e0669503aec5404 = create_deck(aliases, 1, 1);

  while(true) {
    level waittill("recon_poi_firehouse", var_e5b495906761a6cc);

    if(!function_94b00c0fad72704b([0, 1], 1)) {
      continue;
    }

    if(var_e5b495906761a6cc == "spotter") {
      level.player function_c9a09b3ba9c68f8d(0.8, var_1e0669503aec5404 deck_draw(), 0.5, 5);
    }

    return;
  }
}

function function_8bdb22a2adad375a() {
  level endon("game_ended");
  level endon("flag_obj_all_helis_killed");
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_pomr_pric_reactorsarelicbutthe"];
  aliases[aliases.size] = [level, 0.3, "dx_cp_chem_pomr_lasw_russiansstartedconst"];
  aliases[aliases.size] = [level, 0.3, "dx_cp_chem_pomr_ghos_therodsarestillinpla"];
  aliases[aliases.size] = [level, 0.5, "dx_cp_chem_pomr_soap_thenwhataretheypulli"];
  aliases[aliases.size] = [level, 0.4, "dx_cp_chem_pomr_gazz_makarovknowssomethin"];

  while(true) {
    level waittill("recon_poi_main_reactor", var_e5b495906761a6cc);

    if(flag("flag_obj_all_helis_killed")) {
      return;
    }

    if(!function_94b00c0fad72704b([0, 1], 1)) {
      continue;
    }

    if(var_e5b495906761a6cc == "spotter") {
      level.player function_c9a09b3ba9c68f8d(0.8, aliases, 0.6, 2);
    }

    return;
  }
}

function function_def66ed89387fc5b() {
  thread function_2531e33f88ec072d();
  thread function_a8c8ef1f2d0cbf2a();
}

function function_2531e33f88ec072d() {
  level endon("game_ended");
  lines = ["dx_cp_chem_crtc_pric_helostakingdamage", "dx_cp_chem_crtc_pric_helosalmostdonefor", "dx_cp_chem_crtc_pric_puttingeffectfireont", "dx_cp_chem_crtc_pric_enemyhelosgoingdown", "dx_cp_chem_crtc_pric_almostthere"];
  deck = create_deck(lines, 1, 1);

  for(i = 0; i < 3; i++) {
    level waittill_any_3("heli_damaged_med_" + 1, "heli_damaged_med_" + 2, "heli_damaged_med_" + 3);
    level.player function_fc0eb6b81c66c661(0.3, deck deck_draw(), 0.2, 0.2, 1);
  }
}

function function_a8c8ef1f2d0cbf2a() {
  level endon("game_ended");
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_hegu_lasw_adviseusingexplosive";
  aliases[aliases.size] = "dx_cp_chem_hegu_ghos_heloarmorstoothickfo";
  aliases[aliases.size] = "dx_cp_chem_hegu_pric_gotthatright";
  aliases[aliases.size] = "dx_cp_chem_hegu_lasw_06engagethatbirdwith";
  var_38e74b5580becfd2 = create_deck(aliases, 1, 1);
  var_277b23d89b6bf476 = [level, "dx_cp_chem_hegu_ghos_hitthathelowithexplo", level.player, 0.3, "dx_cp_chem_hegu_pric_explosivescopy"];
  var_277b22d89b6bf243 = [level, "dx_cp_chem_hegu_ghos_useexplosivestaketha", level.player, 0.3, "dx_cp_chem_hegu_pric_rogerthat"];
  var_f140d95fea99d35a = create_deck([var_277b23d89b6bf476, var_277b22d89b6bf243], 1, 1);
  var_277b21d89b6bf010 = [level, "dx_cp_chem_hegc_ghos_bulletsareshiteagain", level.player, 0.3, "dx_cp_chem_hegc_pric_copythat"];
  var_277b28d89b6bff75 = [level, "dx_cp_chem_hegc_lasw_06useexplosivesagain", level.player, 0.3, "dx_cp_chem_hegc_pric_copywatcher"];
  var_277b27d89b6bfd42 = [level, "dx_cp_chem_hegc_ghos_hitthehelowithexplos", level.player, 0.3, "dx_cp_chem_hegc_pric_explosivescopy"];
  var_277b26d89b6bfb0f = [level, "dx_cp_chem_hegc_ghos_helosarmoreduseexplo", level.player, 0.3, "dx_cp_chem_hegc_pric_rogerthat"];
  var_87a2811525d96711 = create_deck([var_277b21d89b6bf010, var_277b28d89b6bff75, var_277b27d89b6bfd42, var_277b26d89b6bfb0f], 1, 1);
  level thread function_114b1e995f568d11();

  while(true) {
    if(flag("flag_obj_all_helis_killed")) {
      break;
    }

    level waittill("heli_obj_bullet_warning");
    wait randomfloatrange(0.4, 0.8);

    if(function_eac0cd99c9c6d8ee() == "hidden") {
      if(percent_chance(50)) {
        level function_fc0eb6b81c66c661(0.5, var_38e74b5580becfd2 deck_draw(), 0.3, 1);
      } else {
        level function_c9a09b3ba9c68f8d(0.5, var_f140d95fea99d35a deck_draw(), 0.3, 1);
      }
    }

    if(function_eac0cd99c9c6d8ee() == "spotted") {
      if(!time_has_passed(level.var_2912f8042f907a06, 5)) {
        continue;
      }

      if(!function_94b00c0fad72704b(undefined, undefined, undefined, 1000)) {
        continue;
      }

      level function_c9a09b3ba9c68f8d(0.3, var_87a2811525d96711 deck_draw(), 0.3, 1);
    }

    wait 25;
  }
}

function function_114b1e995f568d11() {
  var_9bc1a8d4d7bc24ee = 3;
  var_6e6f39db71fa71c5 = [];
  var_45bdada420284615 = 10;

  while(true) {
    level waittill("heli_damaged_bullet", attacker);

    if(!is_equal(attacker, level.player)) {
      continue;
    }

    if(isDefined(level.var_2912f8042f907a06) && !time_has_passed(level.var_2912f8042f907a06, 4)) {
      continue;
    }

    var_35f9331c8292838d = function_399c5377091d2b15(level.player.origin);

    if(distance(var_35f9331c8292838d, level.player.origin) > 3000) {
      continue;
    }

    var_6e6f39db71fa71c5[var_6e6f39db71fa71c5.size] = gettime();

    if(var_6e6f39db71fa71c5.size >= var_9bc1a8d4d7bc24ee && !time_has_passed(var_6e6f39db71fa71c5[var_9bc1a8d4d7bc24ee - 1], var_45bdada420284615)) {
      level notify("heli_obj_bullet_warning");
      wait 30;
      continue;
    }

    wait 1;
  }
}

function function_9baa840cb5e343b8() {
  level endon("game_ended");
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_he1c_pric_allstationshelodestr", level, 0.3, "dx_cp_chem_he1c_lasw_goodworktwotogo"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_he1c_pric_allstationsfirsthelo", level, 0.3, "dx_cp_chem_he1c_lasw_solidworkmovetothene"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_he1c_pric_allstationsfirsttarg"];
  var_512469418c312c28 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_he1n_pric_allstationsfirsttarg", level, 0.4, "dx_cp_chem_he1n_lasw_goodwork06twotargets"];
  var_d2807aba19368d9 = create_deck(aliases, 1, 1);

  while(true) {
    waitframe();

    if(level.var_9df79069dfd8549b == 1 && !flag("vo_c4_planted_on_all_helis_stealth")) {
      wait 1;

      if(function_eac0cd99c9c6d8ee() == "spotted") {
        level function_c9a09b3ba9c68f8d(1, var_512469418c312c28 deck_draw(), 0.8, 4);
      } else {
        level function_c9a09b3ba9c68f8d(1, var_d2807aba19368d9 deck_draw(), 0.8, 4);
      }

      break;
    }

    if(level.var_9df79069dfd8549b == 3 && flag("vo_c4_planted_on_all_helis_stealth")) {
      aliases = [level.player, "dx_cp_chem_stro_pric_goodhitstargetsdestr", level, 0.3, "dx_cp_chem_stro_ghos_outstanding", level, 0.3, "dx_cp_chem_stro_soap_konnisdownthreebirds", level, 0.4, "dx_cp_chem_stro_lasw_goodkillsobjectivesd", level, 0.6, "dx_cp_chem_stro_lasw_westillgotworktodo"];
      level function_c9a09b3ba9c68f8d(1, aliases, 0.8, 4);
      return;
    }

    if(level.var_9df79069dfd8549b == 3 && !flag("vo_c4_planted_on_all_helis_stealth")) {
      level function_c9a09b3ba9c68f8d(1, [level, 0.4, "dx_cp_chem_stro_lasw_goodkillsobjectivesd", level, 0.6, "dx_cp_chem_stro_lasw_westillgotworktodo"], 0.8, 4);
      return;
    }

    if(level.var_9df79069dfd8549b == 2) {
      level.player function_c9a09b3ba9c68f8d(["dx_cp_chem_he2c_pric_twohelosdown", level, 0.3, "dx_cp_chem_he2c_lasw_copy06onetargettogol"]);
      thread function_f6b2e74b278991ff();
      return;
    }
  }

  function_c03363d375613f5c();
}

function function_c03363d375613f5c() {
  level endon("game_ended");
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_he2c_pric_secondhelosdown", level, 0.3, "dx_cp_chem_he2c_lasw_goodworkonemoretogo"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_he2c_pric_twohelosdown", level, 0.3, "dx_cp_chem_he2c_lasw_copy06onetargettogol"];
  var_512469418c312c28 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_he2n_pric_gooddetsecondhelodow", level, 0.3, "dx_cp_chem_he2n_lasw_copy06onemoreandweke"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_he2n_pric_allstationssecondhel", level, 0.3, "dx_cp_chem_he2n_lasw_goodwork06moveonthel"];
  var_d2807aba19368d9 = create_deck(aliases, 1, 1);

  while(level.var_9df79069dfd8549b <= 2) {
    waitframe();

    if(level.var_9df79069dfd8549b == 2) {
      wait 1;

      if(function_eac0cd99c9c6d8ee() == "spotted") {
        level function_c9a09b3ba9c68f8d(0.3, var_512469418c312c28 deck_draw(), 0.8, 4);
      } else {
        level function_c9a09b3ba9c68f8d(0.5, var_d2807aba19368d9 deck_draw(), 0.8, 4);
      }

      break;
    }
  }

  function_f6b2e74b278991ff();
}

function function_f6b2e74b278991ff() {
  level endon("game_ended");
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_hn3c_pric_lasthelodestroyed", level, 0.4, "dx_cp_chem_hn3c_lasw_niceworkwhateverkonn"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_hn3c_pric_alltargetsdestroyed", level, 0.3, "dx_cp_chem_hn3c_lasw_goodwork06"];
  var_1be5fa1dddde2b2e = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_he3n_pric_allstationslasttarge", level, 0.4, "dx_cp_chem_he3n_lasw_solidworkbravo6whate"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_he3n_pric_thisisbravo06alltarg", level, 0.3, "dx_cp_chem_he3n_lasw_goodworkbravo"];
  var_d2807aba19368d9 = create_deck(aliases, 1, 1);

  while(level.var_9df79069dfd8549b <= 3) {
    waitframe();

    if(level.var_9df79069dfd8549b == 3) {
      wait 1;

      if(function_eac0cd99c9c6d8ee() == "spotted") {
        level function_c9a09b3ba9c68f8d(0.3, var_1be5fa1dddde2b2e deck_draw(), 0.8, 4);
      } else {
        level function_c9a09b3ba9c68f8d(0.5, var_d2807aba19368d9 deck_draw(), 0.8, 4);
      }

      break;
    }
  }
}

function function_c348a33fb4b675ba() {
  level endon("game_ended");
  var_168cd8307a3f8807 = 1;
  level waittill("heli_containment_dead");
  aliases = ["dx_cp_chem_ccre_lasw_goodwork06nexttarget", "dx_cp_chem_ccre_lasw_solidworkbravo6follo", "dx_cp_chem_ccre_lasw_06isrshowstwohelosat"];
  var_9efecba4820fb0d1 = create_deck(aliases, 1, 1);

  if(level.var_9df79069dfd8549b < 3) {
    if(array_contains(level.var_10aad158c29f7d5f, 1) && level.var_9df79069dfd8549b == 1) {
      wait 5;
      level function_c9a09b3ba9c68f8d(0.5, [var_9efecba4820fb0d1 deck_draw(), level.player, 0.3, "dx_cp_chem_ccre_pric_onmyway"], 1, 3);
    }
  }
}

function function_4337509e95d7365e() {
  level endon("game_ended");
  var_168cd8307a3f8807 = 3;
  flag_wait("flag_heli_killed_" + "3");
  flag_set("flag_obj_parking_heli_killed");
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_pcre_lasw_nicework06nexttarget";
  aliases[aliases.size] = "dx_cp_chem_pcre_lasw_welldonebravo6isrsho";
  var_9efecba4820fb0d1 = create_deck(aliases, 1, 1);

  if(level.var_9df79069dfd8549b < 3) {
    if(array_contains(level.var_10aad158c29f7d5f, 3) && level.var_9df79069dfd8549b == 1) {
      wait 5;
      level function_fc0eb6b81c66c661(0.5, var_9efecba4820fb0d1 deck_draw(), 1, 3);
    }
  }
}

function function_d1a3ffa644bde39f() {
  level endon("game_ended");
  var_168cd8307a3f8807 = 2;
  level flag_wait("flag_heli_killed_" + var_168cd8307a3f8807);
  level flag_set("flag_obj_spray_heli_killed");
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_spre_lasw_goodworknexttargetsa";
  aliases[aliases.size] = "dx_cp_chem_spre_lasw_06remainingtargetsar";
  aliases[aliases.size] = "dx_cp_chem_spre_lasw_solidwork06nexttarge";
  var_9efecba4820fb0d1 = create_deck(aliases, 1, 1);

  if(level.var_9df79069dfd8549b < 3) {
    if(array_contains(level.var_10aad158c29f7d5f, 2) && level.var_9df79069dfd8549b == 1) {
      wait 5;
      level function_fc0eb6b81c66c661(0.5, var_9efecba4820fb0d1 deck_draw(), 1, 3);
    }
  }
}

function function_9ebbfbd1365cacd3() {
  level endon("game_ended");
  level waittill("obj_heli_containment");
  wait 0.5;

  if(!isDefined(level.var_67c34d82ff685dd)) {
    level.var_67c34d82ff685dd = 0;
  }

  if(array_contains(level.var_10aad158c29f7d5f, 1)) {
    level.var_67c34d82ff685dd++;
    return;
  }

  if(level.var_67c34d82ff685dd == 0) {
    function_d0e18906b2e5d27f();
  }

  if(level.var_67c34d82ff685dd == 1) {
    function_6e863931522ef8a5();
  }

  if(level.var_67c34d82ff685dd == 2) {
    function_660ec64b937f3eae();
  }

  level.var_67c34d82ff685dd++;
}

function function_49de560c553c9cfe() {
  level endon("game_ended");
  level waittill("obj_heli_spray");
  wait 0.5;

  if(!isDefined(level.var_67c34d82ff685dd)) {
    level.var_67c34d82ff685dd = 0;
  }

  if(array_contains(level.var_10aad158c29f7d5f, 2)) {
    level.var_67c34d82ff685dd++;
    return;
  }

  if(level.var_67c34d82ff685dd == 0) {
    function_d0e18906b2e5d27f();
  }

  if(level.var_67c34d82ff685dd == 1) {
    function_6e863931522ef8a5();
  }

  if(level.var_67c34d82ff685dd == 2) {
    function_660ec64b937f3eae();
  }

  level.var_67c34d82ff685dd++;
}

function function_edb0e98317abe38b() {
  level endon("game_ended");
  level waittill("obj_heli_parking");
  wait 0.5;

  if(!isDefined(level.var_67c34d82ff685dd)) {
    level.var_67c34d82ff685dd = 0;
  }

  if(array_contains(level.var_10aad158c29f7d5f, 3)) {
    level.var_67c34d82ff685dd++;
    return;
  }

  if(level.var_67c34d82ff685dd == 0) {
    function_d0e18906b2e5d27f();
  }

  if(level.var_67c34d82ff685dd == 1) {
    function_6e863931522ef8a5();
  }

  if(level.var_67c34d82ff685dd == 2) {
    function_660ec64b937f3eae();
  }

  level.var_67c34d82ff685dd++;
}

function function_d0e18906b2e5d27f() {
  if(level.var_9df79069dfd8549b == 0 && !flag("flag_obj_all_helis_killed")) {
    if(function_eac0cd99c9c6d8ee() == "hidden") {
      if(function_c7b23489dccac22a() || cointoss()) {
        aliases = [level.player, "dx_cp_chem_he1n_pric_visualonahelo", level, 0.3, "dx_cp_chem_he1n_lasw_copy06thatsyourtarge"];
      } else {
        aliases = [level.player, "dx_cp_chem_lein_pric_atthehelo", &function_dbf7f86edd8a7996, level, 0.3, "dx_cp_chem_lein_lasw_06anysignofcargo", &function_a4e4a9fc80e228fd, &function_dbf7f86edd8a7996, level.player, 0.3, "dx_cp_chem_lein_pric_negative", &function_dbf7f86edd8a7996, level, 0.3, "dx_cp_chem_lein_ghos_konnisstillsearching", &function_dbf7f86edd8a7996, level, 0.3, "dx_cp_chem_lein_lasw_affirmative", &function_dbf7f86edd8a7996];
      }

      level.player function_c9a09b3ba9c68f8d(0.7, aliases, 0.8, 2);
      return;
    }

    aliases = [level.player, "dx_cp_chem_he1c_pric_visualonahelo", &function_dbf7f86edd8a7996, level, 0.3, "dx_cp_chem_he1c_lasw_copy06getitdestroyed", &function_dbf7f86edd8a7996];
    level.player function_c9a09b3ba9c68f8d(0.7, aliases, 0.8, 2);
  }
}

function function_6e863931522ef8a5() {
  if(level.var_9df79069dfd8549b == 1 && !flag("flag_obj_all_helis_killed")) {
    if(function_eac0cd99c9c6d8ee() == "hidden") {
      aliases = [level.player, "dx_cp_chem_he2n_pric_eyesonasecondhelo", level, 0.3, "dx_cp_chem_he2n_lasw_copy06setchargesandc", &function_dc63b94812edf63d];
      level.player function_c9a09b3ba9c68f8d(0.5, aliases, 0.8, 2);
      return;
    }

    aliases = [level.player, "dx_cp_chem_he2c_pric_eyesonanotherhelo", level, 0.3, "dx_cp_chem_he2c_lasw_copy06takeitout", &function_dc63b94812edf63d];
    level.player function_c9a09b3ba9c68f8d(0.5, aliases, 0.8, 2);
  }
}

function function_660ec64b937f3eae() {
  if(level.var_9df79069dfd8549b == 2 && !flag("flag_obj_all_helis_killed")) {
    if(function_eac0cd99c9c6d8ee() == "hiddden") {
      aliases = [level.player, "dx_cp_chem_he3n_pric_visualonthelasthelo", level, 0.3, "dx_cp_chem_he3n_lasw_copy06youknowthedril", &function_dc63b94812edf63d];
      level.player function_c9a09b3ba9c68f8d(0.5, aliases, 0.8, 2);
      return;
    }

    aliases = [level.player, "dx_cp_chem_hn3c_pric_eyesonthelasthelo", level, 0.3, "dx_cp_chem_hn3c_lasw_copytakeitdown", &function_dc63b94812edf63d];
    level.player function_c9a09b3ba9c68f8d(0.5, aliases, 0.8, 2);
  }
}

function function_733de3668eccf373() {
  level endon("game_ended");
  level endon("flag_reactor_entered");
  var_407d185dcf35e79f = [level, "dx_cp_chem_he1e_ghos_multiplekonnineartha", level.player, 0.3, "dx_cp_chem_he1e_pric_copyimonit"];
  var_407d195dcf35e9d2 = [level, "dx_cp_chem_he1e_lasw_06multiplekonniarene", level.player, 0.3, "dx_cp_chem_he1e_pric_solidcopywatcher"];
  var_39ada274bb2706fb = [level, "dx_cp_chem_h1nc_ghos_pricemultiplekonnine", level.player, 0.3, "dx_cp_chem_h1nc_pric_copywatchmysix"];
  var_39ada374bb27092e = [level, "dx_cp_chem_h1nc_lasw_06youvegotmultipleko", level.player, 0.3, "dx_cp_chem_h1nc_pric_copywatcher"];
  var_512469418c312c28 = create_deck([var_407d185dcf35e79f, var_407d195dcf35e9d2], undefined, 1);
  var_d2807aba19368d9 = create_deck([var_39ada274bb2706fb, var_39ada374bb27092e], undefined, 1);
  function_d307f2590e3f9841(1, undefined, 3);

  if(function_eac0cd99c9c6d8ee() == "spotted") {
    level function_c9a09b3ba9c68f8d(0.3, var_512469418c312c28 deck_draw(), 0.4, 3);
    return;
  }

  level function_c9a09b3ba9c68f8d(1, var_d2807aba19368d9 deck_draw(), 0.4, 3);
}

function function_8c496903e22a4af5() {
  level endon("game_ended");
  level endon("flag_reactor_entered");
  var_407d185dcf35e79f = [level, "dx_cp_chem_he2e_ghos_secondheloisclosekon", level.player, 0.4, "dx_cp_chem_he2e_pric_likewise"];
  var_407d195dcf35e9d2 = [level, "dx_cp_chem_he2e_lasw_06secondheloisnearyo", level.player, 0.4, "dx_cp_chem_he2e_pric_solidcopywatcher"];
  var_39ada274bb2706fb = [level, "dx_cp_chem_h2nc_lasw_06youreapproachingas", level.player, 0.4, "dx_cp_chem_h2nc_pric_rogerthat"];
  var_39ada374bb27092e = [level, "dx_cp_chem_h2nc_ghos_secondheloscloseyour", level.player, 0.4, "dx_cp_chem_h2nc_pric_copy"];
  var_512469418c312c28 = create_deck([var_407d185dcf35e79f, var_407d195dcf35e9d2], undefined, 1);
  var_d2807aba19368d9 = create_deck([var_39ada274bb2706fb, var_39ada374bb27092e], undefined, 1);
  function_d307f2590e3f9841(1, undefined, 3);

  if(function_eac0cd99c9c6d8ee() == "spotted") {
    level function_c9a09b3ba9c68f8d(0.4, var_512469418c312c28 deck_draw(), 0.4, 3);
    return;
  }

  level function_c9a09b3ba9c68f8d(1, var_d2807aba19368d9 deck_draw(), 0.4, 3);
}

function function_428fc5a0bd5c0048() {
  level endon("game_ended");
  level endon("flag_reactor_entered");
  var_407d185dcf35e79f = [level.player, "dx_cp_chem_he3e_ghos_lasthelosclosekonnis", level, 0.4, "dx_cp_chem_he3e_pric_copythat"];
  var_407d195dcf35e9d2 = [level.player, "dx_cp_chem_he3e_lasw_06youreapproachingth", level, 0.4, "dx_cp_chem_he3e_pric_copythatwatcher"];
  var_39ada274bb2706fb = [level.player, "dx_cp_chem_h3nc_ghos_lasthelosclosekonnis", level, 0.4, "dx_cp_chem_h3nc_pric_illhandleit"];
  var_39ada374bb27092e = [level.player, "dx_cp_chem_h3nc_lasw_06imseeingheavykonni", level, 0.4, "dx_cp_chem_h3nc_pric_copythat"];
  var_512469418c312c28 = create_deck([var_407d185dcf35e79f, var_407d195dcf35e9d2], undefined, 1);
  var_d2807aba19368d9 = create_deck([var_39ada274bb2706fb, var_39ada374bb27092e], undefined, 1);
  function_d307f2590e3f9841(1, undefined, 3);

  if(function_eac0cd99c9c6d8ee() == "spotted") {
    level function_c9a09b3ba9c68f8d(0.3, var_512469418c312c28 deck_draw(), 0.4, 3);
    return;
  }

  level function_c9a09b3ba9c68f8d(0.5, var_d2807aba19368d9 deck_draw(), 0.4, 3);
}

function function_763d44b12429ac5b() {
  level endon("game_ended");
  level endon("flag_reactor_entered");
  level endon("flag_obj_containment_heli_killed");

  while(true) {
    flag_wait("flag_player_reached_containment_approach");

    if(!function_94b00c0fad72704b([3, 0, 1, 2])) {
      wait 0.5;
      continue;
    }

    break;
  }

  wait 2;

  if(isDefined(level.var_4bc5fee4300b6905) && level.var_4bc5fee4300b6905 == "containment") {
    function_733de3668eccf373();
  }

  if(isDefined(level.var_17d23eb017a62c09) && level.var_17d23eb017a62c09 == "containment") {
    function_8c496903e22a4af5();
  }

  if(isDefined(level.var_e84a9897f7a781fa) && level.var_e84a9897f7a781fa == "containment") {
    function_428fc5a0bd5c0048();
  }
}

function function_b36752fe87873d62() {
  level endon("game_ended");
  level endon("flag_reactor_entered");

  while(true) {
    flag_wait("flag_player_reached_parking_front");

    if(!function_94b00c0fad72704b([3, 0, 1, 2])) {
      wait 0.5;
      continue;
    }

    break;
  }

  if(flag("flag_obj_parking_heli_killed")) {}
}

function function_5915eee776e9db36() {
  level endon("game_ended");
  level endon("flag_reactor_entered");

  while(true) {
    flag_wait("flag_player_reached_parking_center");

    if(!function_94b00c0fad72704b([3, 0, 1, 2])) {
      wait 0.5;
      continue;
    }

    break;
  }

  wait 2;

  if(isDefined(level.var_4bc5fee4300b6905) && level.var_4bc5fee4300b6905 == "parking") {
    function_733de3668eccf373();
  }

  if(isDefined(level.var_17d23eb017a62c09) && level.var_17d23eb017a62c09 == "parking") {
    function_8c496903e22a4af5();
  }

  if(isDefined(level.var_e84a9897f7a781fa) && level.var_e84a9897f7a781fa == "parking") {
    function_428fc5a0bd5c0048();
  }
}

function function_95254f8b3d3507a8() {
  level endon("game_ended");
  level endon("flag_reactor_entered");

  while(true) {
    flag_wait("flag_player_reached_spray_approach");

    if(!function_94b00c0fad72704b([3, 0, 1, 2])) {
      wait 0.5;
      continue;
    }

    break;
  }

  wait 2;

  if(isDefined(level.var_4bc5fee4300b6905) && level.var_4bc5fee4300b6905 == "spray") {
    function_733de3668eccf373();
  }

  if(isDefined(level.var_17d23eb017a62c09) && level.var_17d23eb017a62c09 == "spray") {
    function_8c496903e22a4af5();
  }

  if(isDefined(level.var_e84a9897f7a781fa) && level.var_e84a9897f7a781fa == "spray") {
    function_428fc5a0bd5c0048();
  }
}

function function_313ac6436b8a39a4() {
  level endon("game_ended");
  level endon("flag_reactor_entered");
  var_28cf4776fbc4e2f0 = function_7a18da6e48b71c35("heli_containment_loc");
  flag_wait("flag_director_ai_cleared_" + 1);

  while(!flag("flag_heli_killed_" + 1)) {
    var_49d44d75375d10b0 = function_299424620c86e0e0(var_28cf4776fbc4e2f0, 1000);

    if(var_49d44d75375d10b0.size <= 0 && level.var_2745498dd7dc0a6d == "containment_approach" && !function_1445c12552b674d4()) {
      level.player function_fc0eb6b81c66c661(randomfloatrange(0.3, 1.2), level.var_a8f1c3571f998334 deck_draw(), 0.8, 3);
      wait 1;
      flag_set("flag_containment_cleared");
      break;
    }

    wait 10;
  }
}

function function_a9591d332b6b3464() {
  if(level.var_2745498dd7dc0a6d == "containment_approach" || level.var_2745498dd7dc0a6d == "containment_post_heli") {
    return true;
  }

  return false;
}

function function_4f828cf3aa821ea1() {
  level endon("game_ended");
  level endon("flag_reactor_entered");
  var_dead199864bca301 = function_7a18da6e48b71c35("heli_spray_loc");
  flag_wait("flag_director_ai_cleared_" + 2);

  while(!flag("flag_heli_killed_" + 2)) {
    var_49d43d75375ced80 = function_299424620c86e0e0(var_dead199864bca301, 1000);
    var_d125b941178655ab = function_f66674e43ad96fc7();

    if(var_49d43d75375ced80.size <= 0 && var_d125b941178655ab && !function_1445c12552b674d4()) {
      level.player function_fc0eb6b81c66c661(randomfloatrange(0.3, 1.2), level.var_b63330ee14bc88dd deck_draw(), 0.8, 3);
      wait 1;
      flag_set("flag_spray_cleared");
      break;
    }

    wait 10;
  }
}

function function_f66674e43ad96fc7() {
  if(level.var_2745498dd7dc0a6d == "pipeworks" || level.var_2745498dd7dc0a6d == "pipeworks_turret_alley" || level.var_2745498dd7dc0a6d == "boilingwater_approach") {
    return true;
  }

  return false;
}

function function_1ddd0b91fdecae14() {
  level endon("game_ended");
  level endon("flag_reactor_entered");
  var_fc49c4e55100b758 = function_7a18da6e48b71c35("heli_parking_loc");
  flag_wait("flag_director_ai_cleared_" + 3);

  while(!flag("flag_heli_killed_" + 3)) {
    var_49d44075375cf419 = function_299424620c86e0e0(var_fc49c4e55100b758, 1000);
    var_f0c3f0d809006866 = function_6c93dcce28cfcc28();

    if(var_49d44075375cf419.size <= 0 && var_f0c3f0d809006866 && !function_1445c12552b674d4()) {
      level.player function_fc0eb6b81c66c661(randomfloatrange(0.3, 1.2), level.var_4a86deaba64db35 deck_draw(), 0.8, 3);
      wait 1;
      flag_set("flag_parking_cleared");
      break;
    }

    wait 10;
  }
}

function function_94f056216a0ed8ee() {
  level endon("game_ended");
  level endon("flag_reactor_entered");
  function_d307f2590e3f9841([0, 1], 1, undefined, 1000, 10, "firehouse");
  convo = [level, "dx_cp_chem_pois_ghos_tonsofkonniontarget", &function_a4e4a9fc80e228fd, level.player, 0.3, "dx_cp_chem_pois_pric_makarovsgotplentyofu", &function_a4e4a9fc80e228fd, level, 0.4, "dx_cp_chem_pois_ghos_enoughtostartawar"];
  level.player function_c9a09b3ba9c68f8d(1, convo, 0, 5);
}

function function_485eba9406c5e977() {
  function_d307f2590e3f9841([0, 1], 1, 5, undefined, 2, "radio_tower");
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_coac_ghos_primerealestateforas", &function_a4e4a9fc80e228fd, level.player, 0.5, "dx_cp_chem_coac_pric_greatmindssimon"];
  aliases[aliases.size] = [level, "dx_cp_chem_coac_ghos_goodspotforsnipingpr", &function_a4e4a9fc80e228fd, level.player, 0.5, "dx_cp_chem_coac_pric_readmymind"];
  var_6cfa66cff72430ba = create_deck(aliases, undefined, 1);
  level function_c9a09b3ba9c68f8d(1, var_6cfa66cff72430ba deck_draw(), 0.5, 5);
}

function vo_spotter_nag() {
  level endon("game_ended");
  level endon("flag_obj_all_helis_killed");
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_gosn_pric_gotsomeelevation"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_gosn_pric_sixtoallstationsgota"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_flre_pric_goodvantagehere"];
  var_1b7b7de0179f242e = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_gosn_ghos_scopecouldcomeinhand"];
  aliases[aliases.size] = [level, "dx_cp_chem_gosn_ghos_thescopecouldgiveyou"];
  aliases[aliases.size] = [level, "dx_cp_chem_gosn_ghos_tryusingthescope"];
  aliases[aliases.size] = [level, "dx_cp_chem_gosn_ghos_scopewillgiveasightp"];
  aliases[aliases.size] = [level, "dx_cp_chem_gosn_ghos_scopellgiveyoulonger"];
  aliases[aliases.size] = [level, "dx_cp_chem_gosn_ghos_adviseusingthescopef"];
  aliases[aliases.size] = [level, "dx_cp_chem_flre_lasw_scantheterrain"];
  var_f5f317da206b1b8c = create_deck(aliases, 1, 1);
  vols = function_3fd029c94a177d06("vol_spotter_nag");

  while(true) {
    foreach(vol in vols) {
      if(level.player istouching(vol) && function_94b00c0fad72704b([0, 1], 1, 5, undefined, 2, undefined, "vo_spotter_nag")) {
        level.player function_c9a09b3ba9c68f8d(1.5, [var_1b7b7de0179f242e deck_draw(), 0.4, level, var_f5f317da206b1b8c deck_draw()], 0.2, 2);
        vols = array_remove(vols, vol);
      }

      wait 60;
    }

    waitframe();
  }
}

function function_6c93dcce28cfcc28() {
  if(level.var_2745498dd7dc0a6d == "entry_building_rooftop" || level.var_2745498dd7dc0a6d == "parking_center" || level.var_2745498dd7dc0a6d == "parking") {
    return true;
  }

  return false;
}

function function_c2b1216a9f7fb1c5() {
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_nool_lasw_watchertobravo", 0.3, level.player, "dx_cp_chem_nool_pric_sendtrafficwatcher", 0.3, level, "dx_cp_chem_nool_lasw_thismaynotbenucleara", 0.3, level.player, "dx_cp_chem_nool_pric_whatevertheywantwewo"];
  aliases[aliases.size] = [level, "dx_cp_chem_nool_ghos_whatthehelliskonnihe", 0.3, level.player, "dx_cp_chem_nool_pric_keeplookingtheyreupt"];
  aliases[aliases.size] = [level, "dx_cp_chem_nool_lasw_makarovsmovingquickh", 0.3, level, "dx_cp_chem_nool_ghos_arrangedhisownrescue", 0.3, level, "dx_cp_chem_nool_lasw_exactlyonlyhellknows"];
  aliases[aliases.size] = [level, "dx_cp_chem_nool_lasw_wherewouldyouhidesom", 0.3, level.player, "dx_cp_chem_nool_pric_youthinksomethingels", 0.3, level, "dx_cp_chem_nool_lasw_startingtooyeah", 0.3, level, "dx_cp_chem_nool_ghos_spotonlaswell"];
  level.var_efc57afdf578f887 = create_deck(aliases, 1, 1);
  var_f6fb65b0d63b682b = [level, "dx_cp_chem_hena_lasw_mostfast06konniispre", 0.3, level.player, "dx_cp_chem_hena_pric_copythatwatcher"];
  var_f6fb66b0d63b6a5e = [level, "dx_cp_chem_hena_lasw_targetthosehelos06do", 0.3, level.player, "dx_cp_chem_hena_pric_solidcopy"];
  var_f6fb67b0d63b6c91 = [level, "dx_cp_chem_hena_lasw_isrshowsthreehelosst", 0.3, level.player, "dx_cp_chem_hena_pric_imonit"];
  var_f6fb68b0d63b6ec4 = [level, "dx_cp_chem_hena_lasw_06gettothosehelosdon", 0.3, level.player, "dx_cp_chem_hena_pric_workingonitwatcher"];
  level.var_72679ac4ec7854ec = create_deck([var_f6fb65b0d63b682b, var_f6fb66b0d63b6a5e, var_f6fb67b0d63b6c91, var_f6fb68b0d63b6ec4], 1, 1);
  var_614dadbe26696338 = [level, "dx_cp_chem_hecc_lasw_06threehelosarestill", 0.2, level.player, "dx_cp_chem_hecc_pric_imonit"];
  var_614db0be266969d1 = [level, "dx_cp_chem_hecc_lasw_targetthosehelos06", 0.2, level.player, "dx_cp_chem_hecc_pric_solidcopy"];
  var_614dafbe2669679e = [level, "dx_cp_chem_hecc_lasw_06targetthosehelosdo", 0.2, level.player, "dx_cp_chem_hecc_pric_workingonit"];
  level.var_10cb751e68c74abc = create_deck([var_614dadbe26696338, var_614db0be266969d1, var_614dafbe2669679e], 1, 1);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_hen2_lasw_bravo06twohelosarest", 0.2, level.player, "dx_cp_chem_hen2_pric_rog"];
  aliases[aliases.size] = [level, "dx_cp_chem_hen2_lasw_06isrshowstwokonnihe", 0.2, level.player, "dx_cp_chem_hen2_pric_notforlong"];
  aliases[aliases.size] = [level, "dx_cp_chem_hen2_ghos_beadvised06konnihast", 0.2, level.player, "dx_cp_chem_hen2_pric_onit"];
  aliases[aliases.size] = [level, "dx_cp_chem_hen2_ghos_enemyhelosclose"];
  level.var_668f489b2925d85e = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_hn2c_lasw_06keepmovingtwohelos", 0.2, level.player, "dx_cp_chem_hn2c_pric_onit"];
  aliases[aliases.size] = [level, "dx_cp_chem_hn2c_lasw_06twoenemyhelosarest", 0.2, level.player, "dx_cp_chem_hn2c_pric_copywatcher"];
  aliases[aliases.size] = [level, "dx_cp_chem_hn2c_lasw_twohelosleft06getaft", 0.2, level.player, "dx_cp_chem_hn2c_pric_workingonit"];
  level.var_be13f595214a9e37 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_hen3_lasw_bravo06theresonetarg", 0.2, level.player, "dx_cp_chem_hen3_pric_copythatwatcher"];
  aliases[aliases.size] = [level, "dx_cp_chem_hen3_lasw_movetothelasttarget0", 0.2, level.player, "dx_cp_chem_hen3_pric_rog"];
  aliases[aliases.size] = [level, "dx_cp_chem_hen3_lasw_oneheloleftjohntakei", 0.2, level.player, "dx_cp_chem_hen3_pric_onit"];
  level.var_ee7a7a1f1ff67155 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_he3c_lasw_lasthelo06getmoving", 0.2, level.player, "dx_cp_chem_he3c_pric_copythatwatcher"];
  aliases[aliases.size] = [level, "dx_cp_chem_he3c_lasw_06movetothelasttarge", 0.2, level.player, "dx_cp_chem_he3c_pric_rog"];
  aliases[aliases.size] = [level, "dx_cp_chem_he3c_lasw_bravo6destroythelast", 0.2, level.player, "dx_cp_chem_he3c_pric_onit"];
  level.var_fa8b3f4137683bfa = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_mona_ghos_advisepickinupthepac";
  aliases[aliases.size] = "dx_cp_chem_mona_ghos_stepitupcaptainyoune";
  aliases[aliases.size] = "dx_cp_chem_mona_ghos_stayaheadofemcaptain";
  aliases[aliases.size] = "dx_cp_chem_mona_ghos_needtogetmoving";
  aliases[aliases.size] = "dx_cp_chem_mona_ghos_lotsofkonniaroundple";
  level.var_566183a75efda459 = create_deck(aliases, 1, 1);
}

function function_1088ef0247841cc9(time) {
  if(time_has_passed(level.var_52c33d39f2b5db6, time)) {
    return true;
  }

  return false;
}

function function_ebc1c42b342b43a5(time) {
  if(!isDefined(time)) {
    time = default_to(time, 5);
  }

  if(!time_has_passed(level.var_52c33d39f2b5db6, time)) {
    return true;
  }

  return false;
}

function function_76d7f307feb10d63(location_array) {
  if(!isarray(location_array)) {
    location_array = [location_array];
  }

  return array_contains(location_array, level.var_2745498dd7dc0a6d);
}

function function_f80db1e7cbbe967(location_array) {
  if(!isarray(location_array)) {
    location_array = [location_array];
  }

  if(function_76d7f307feb10d63(location_array)) {
    return;
  }

  foreach(location in location_array) {
    level endon("player_at_" + location);
  }

  flag_wait("forever");
}

function function_29e347ba0fe6f857() {
  location = level.var_2745498dd7dc0a6d;

  if(!isDefined(level.var_2745498dd7dc0a6d)) {
    location = "";
  }

  return location;
}

function function_2537619733cc78e8() {
  while(true) {
    if(level.player getstance() == "crouch") {
      level.player.var_45dd75f29ec01581 = gettime();
      level flag_set("player_crouching");

      while(level.player getstance() == "crouch") {
        wait 0.5;
      }
    }

    level flag_clear("player_crouching");
    wait 0.5;
  }
}

function function_2751618370a3db2e(time) {
  if(time_has_passed(level.player.var_45dd75f29ec01581, time)) {
    return true;
  }

  return false;
}

function function_1ff2812caba159e6() {
  flag_set("player_not_in_combat");

  while(true) {
    if(function_1bb1470f934a81eb() || function_d1eb8de046dd8440()) {
      level.player.var_e175e10a9ce88d03 = gettime();
      flag_clear("player_not_in_combat");
      flag_set("player_in_combat");
      flag_set("player_detected_in_level");

      while(function_1bb1470f934a81eb()) {
        wait 1;
        level.player.var_25d42327330ce213 = gettime();
      }
    }

    if(!function_1bb1470f934a81eb() && isDefined(level.player.var_e175e10a9ce88d03)) {
      level.player.var_25d42327330ce213 = gettime();
      flag_clear("player_in_combat");
      flag_set("player_not_in_combat");

      while(!function_1bb1470f934a81eb()) {
        wait 1;
      }
    }

    wait 1;
  }
}

function function_d1eb8de046dd8440() {
  if(isDefined(level.attack_heli) && istrue(level.attack_heli.var_f31d9f20529f1d15)) {
    return 1;
  }

  return 0;
}

function function_1445c12552b674d4() {
  if(flag("player_in_combat")) {
    return true;
  }

  return false;
}

function function_fb8e359d94e5515d(time) {
  if(!isDefined(level.var_2912f8042f907a06)) {
    return true;
  }

  if(time_has_passed(level.var_2912f8042f907a06, time)) {
    return true;
  }

  return false;
}

function function_ae1ace1c557cc8a9(time) {
  if(!isDefined(level.player) || !isDefined(level.player.var_25d42327330ce213)) {
    return true;
  }

  if(time_has_passed(level.player.var_25d42327330ce213, time)) {
    return true;
  }

  return false;
}

function function_5c9189099075a944() {
  if(flag("flag_reactor_room_entered")) {
    return;
  }

  level endon("flag_reactor_room_entered");

  if(!isDefined(level.var_efc57afdf578f887)) {
    function_c2b1216a9f7fb1c5();
  }

  level endon("game_ended");
  var_617823c5298f2009 = function_f12d4d6f5c75b6ba();

  while(!flag("flag_reactor_entered")) {
    wait 0.25;

    while(level.var_2745498dd7dc0a6d == "exterior") {
      wait 1;

      if(!function_182208f0e9f1bad4(5)) {
        continue;
      }

      var_617823c5298f2009 = function_f12d4d6f5c75b6ba();

      if(level.var_9df79069dfd8549b == 1 && function_94b00c0fad72704b(0, 0, 60, undefined, 30) && function_fb8e359d94e5515d(30)) {
        level function_c9a09b3ba9c68f8d(3, level.var_be13f595214a9e37 deck_draw(), 0.5, 3);
        level.var_5985d0d04d8714d6 = gettime();
      }

      if(level.var_9df79069dfd8549b == 1 && function_94b00c0fad72704b(0, 1, 60, undefined, 30) && !flag("player_crouching") && function_1088ef0247841cc9(60)) {
        if(percent_chance(50)) {
          level function_c9a09b3ba9c68f8d(3, level.var_668f489b2925d85e deck_draw(), 0.5, 3);
          level.var_5985d0d04d8714d6 = gettime();
        } else {
          function_406a7213c37990ec();
        }
      }

      if(level.var_9df79069dfd8549b == 2 && function_94b00c0fad72704b(0, 0, 60, undefined, 30) && function_fb8e359d94e5515d(30)) {
        level function_c9a09b3ba9c68f8d(3, level.var_fa8b3f4137683bfa deck_draw(), 0.5, 3);
        level.var_5985d0d04d8714d6 = gettime();
      }

      if(level.var_9df79069dfd8549b == 2 && function_94b00c0fad72704b(0, 1, 60, undefined, 30) && !flag("player_crouching") && function_1088ef0247841cc9(60)) {
        if(percent_chance(50)) {
          level function_c9a09b3ba9c68f8d(3, level.var_ee7a7a1f1ff67155 deck_draw(), 0.5, 3);
          level.var_5985d0d04d8714d6 = gettime();
        } else {
          function_406a7213c37990ec();
        }
      }

      if(level.var_9df79069dfd8549b == 0 && function_94b00c0fad72704b(0, undefined, 60) && function_1088ef0247841cc9(60)) {
        if(function_eac0cd99c9c6d8ee() == "spotted" && function_fb8e359d94e5515d(10)) {
          level function_c9a09b3ba9c68f8d(3, level.var_10cb751e68c74abc deck_draw(), 0.3, 5);
          level.var_5985d0d04d8714d6 = gettime();
        }

        if(function_eac0cd99c9c6d8ee() == "hidden" && !flag("player_crouching")) {
          level function_c9a09b3ba9c68f8d(3, level.var_72679ac4ec7854ec deck_draw(), 0.3, 5);
          level.var_5985d0d04d8714d6 = gettime();
        }
      }
    }
  }
}

function function_406a7213c37990ec() {
  level function_c9a09b3ba9c68f8d(1, level.var_efc57afdf578f887 deck_draw(), 0.3, 5);
  level.var_5985d0d04d8714d6 = gettime();
}

function function_f12d4d6f5c75b6ba(time) {
  if(!isDefined(level.var_5985d0d04d8714d6)) {
    level.var_5985d0d04d8714d6 = gettime();
  }

  if(!isDefined(time)) {
    time = default_to(time, 75);
  }

  if(function_b37ab5bd353b9965() < 5) {
    return false;
  }

  if(time_has_passed(level.var_5985d0d04d8714d6, time)) {
    return true;
  }

  return false;
}

function function_4bb31b4662ece186() {
  level endon("flag_heli_killed_" + 1);
  flag_wait("flag_containment_cleared");
  var_2d322eae8e542b57 = gettime();

  while(true) {
    wait 1;
    function_d307f2590e3f9841([0, 1], 1, 15, undefined, undefined, "containment_approach");

    if(!time_has_passed(var_2d322eae8e542b57, 45) || function_a8cf239507277966(1000)) {
      continue;
    }

    wait 45;
  }
}

function function_4f9fc5447add5d41() {
  level endon("flag_heli_killed_" + 2);
  flag_wait("flag_spray_cleared");
  var_2d322eae8e542b57 = gettime();

  while(true) {
    wait 1;
    function_d307f2590e3f9841([0, 1], 1, 15);

    if(!function_f66674e43ad96fc7() || !time_has_passed(var_2d322eae8e542b57, 45) || function_a8cf239507277966(1000)) {
      continue;
    }

    level.player function_fc0eb6b81c66c661(0.6, level.var_61ac5901f9940d9b deck_draw(), 0.8, 3);
    wait 45;
  }
}

function function_8ae924cf32535716() {
  level endon("flag_heli_killed_" + 3);
  flag_wait("flag_parking_cleared");
  var_2d322eae8e542b57 = gettime();

  while(true) {
    wait 1;
    function_d307f2590e3f9841([0, 1], 1, 15);

    if(!function_6c93dcce28cfcc28() || !time_has_passed(var_2d322eae8e542b57, 45) || function_a8cf239507277966(1000)) {
      continue;
    }

    level.player function_fc0eb6b81c66c661(0.6, level.var_50aa559cad081a13 deck_draw(), 0.8, 3);
    wait 45;
  }
}

function vo_heli_backup_arrive() {
  level endon("game_ended");
  flag_wait("vo_heli_backup_arrive");

  if(!function_94b00c0fad72704b([0, 1, 2])) {
    return;
  }

  wait 1;
  level.player function_fc0eb6b81c66c661(0.3, "dx_cp_chem_srei_lasw_bravobeadvisedkonnib", 0.8, 5);
}

function vo_jltv_reinforcements() {
  level endon("game_ended");
  level endon("flag_obj_all_helis_killed");
  aliases = ["dx_cp_chem_srei_lasw_sixjltvsapproachingt", "dx_cp_chem_srei_lasw_seeingjltvsclosingon", "dx_cp_chem_srei_lasw_sixyougotreinforceme", "dx_cp_chem_srei_lasw_konnireinforcementsi"];

  while(true) {
    flag_wait("vo_jltv_reinforcements");

    if(!function_94b00c0fad72704b([0, 1, 2])) {
      wait 1;
      flag_clear("vo_jltv_reinforcements");
      continue;
    }

    wait 4;
    alias = array_random(aliases);

    if(is_equal(level.checkpoint, "obj_reconArea_complete")) {
      return;
    }

    level.player function_fc0eb6b81c66c661(0.3, alias, 0.8, 5);
    array_remove(aliases, alias);
    wait 1;
    flag_clear("vo_jltv_reinforcements");
  }
}

function vo_jltv_mg_reinforcements() {
  level endon("game_ended");
  flag_wait("vo_jltv_mg_reinforcements");

  if(!function_94b00c0fad72704b([0, 1, 2])) {
    return;
  }

  wait 1;
  level.player function_fc0eb6b81c66c661(0.3, "dx_cp_chem_srei_lasw_johngotamountedmginc", 0.8, 5);
}

function vo_attack_heli_arrive() {
  level endon("game_ended");
  flag_wait("vo_attack_heli_arrive");

  if(!function_94b00c0fad72704b([2])) {
    return;
  }

  if(is_equal(level.checkpoint, "obj_reconArea_complete")) {
    return;
  }

  level.player function_fc0eb6b81c66c661(0.3, "dx_cp_chem_idba_lasw_bravo06beadvisedakon", 0.8, 5);
}

function vo_attack_heli_lost_player() {
  level endon("game_ended");
  level endon("flag_reactor_room_entered");
  aliases = ["dx_cp_chem_srei_ghos_thinkyoulosttheattac", "dx_cp_chem_srei_lasw_attackheloslostyouyo", "dx_cp_chem_srei_lasw_attackhelolostyoufor"];

  while(true) {
    flag_wait("vo_attack_heli_lost_player");

    if(!function_94b00c0fad72704b([2])) {
      wait 1;
      flag_clear("vo_attack_heli_lost_player");
      continue;
    }

    alias = array_random(aliases);
    level.player function_fc0eb6b81c66c661(1.5, alias, 0.6, 5);
    array_remove(aliases, alias);
    wait 1;
    flag_clear("vo_attack_heli_lost_player");
  }
}

function vo_attack_heli_killed() {
  level endon("game_ended");
  flag_wait("vo_attack_heli_killed");

  if(!function_94b00c0fad72704b([0, 1, 2, 4])) {
    return;
  }

  level.player function_fc0eb6b81c66c661(0.2, "dx_cp_chem_ksre_ghos_birddownpriceniceone", 0.9, 3);
}

function function_569213882dc66c9e() {}

function function_8ccc128672142c8d() {
  level endon("game_ended");
  level endon("flag_attack_heli_destroyed");
  function_d307f2590e3f9841([2]);
  aliases = ["dx_cp_chem_atcc_pric_miss", "dx_cp_chem_atcc_pric_noeffect", "dx_cp_chem_atcc_pric_nojoy"];
  var_d5b600bbf519255f = create_deck(aliases, 1, 1);

  while(true) {
    level.player waittill("weapon_fired", objweapon);

    if(!issubstr(objweapon.basename, "rpapa7")) {
      continue;
    }

    waitframe();

    foreach(missile in level.missiles) {
      if(!is_equal(missile.owner, level.player)) {
        continue;
      }

      if(!issubstr(missile.weapon_name, "rpapa7")) {
        continue;
      }

      thread function_95c70096f956eb56(missile);
    }

    flag_wait_or_timeout("flag_shot_missed_vo_triggered", 5);

    if(flag("flag_shot_missed_vo_triggered")) {
      level.player function_fc0eb6b81c66c661(0.3, var_d5b600bbf519255f deck_draw(), 0.8, 2);
      flag_clear("flag_shot_missed_vo_triggered");
      wait 15;
    }
  }
}

function function_95c70096f956eb56(missile) {
  level endon("game_ended");
  level endon("flag_attack_heli_destroyed");
  level endon("stop_rpg_miss_tracker");
  missile endon("death");
  var_a122e973e4142171 = missile.origin;
  var_3f3b66d7d3a1e95f = distance(var_a122e973e4142171, level.attack_heli.origin);
  wait 0.1;
  var_fb2364af0ee092ac = distance(missile.origin, level.attack_heli.origin);

  if(var_fb2364af0ee092ac > var_3f3b66d7d3a1e95f) {
    return;
  }

  var_a122e973e4142171 = missile.origin;

  for(var_3f3b66d7d3a1e95f = distance(var_a122e973e4142171, level.attack_heli.origin); true; var_3f3b66d7d3a1e95f = var_fb2364af0ee092ac) {
    waitframe();
    var_fb2364af0ee092ac = distance(missile.origin, level.attack_heli.origin);

    if(var_fb2364af0ee092ac > var_3f3b66d7d3a1e95f) {
      break;
    }
  }

  if(var_fb2364af0ee092ac > 800) {
    return;
  }

  wait 0.1;

  if(function_94b00c0fad72704b(2)) {
    flag_set("flag_shot_missed_vo_triggered");
  }
}

function function_6a121b8b5d22f7e5() {
  level endon("game_ended");
  level endon("flag_attack_heli_destroyed");
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_atcn_pric_attackhelosdugin", level, 0.4, "dx_cp_chem_atcn_ghos_staylowseeifyoucange"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_atcn_pric_attackhelosbringingh", level, 0.4, "dx_cp_chem_atcn_lasw_seeifkonnipackedanyt"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_atcn_pric_enemybirdsnotbackino", level, 0.4, "dx_cp_chem_atcn_lasw_findcoverintheconstr"];
  aliases[aliases.size] = [level, "dx_cp_chem_atcc_lasw_findalauncherjohntak"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_atcn_pric_attackhelosfuckinrel", level, 0.4, "dx_cp_chem_atcn_ghos_repositionusethestru"];
  var_cee9b146289dc187 = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_atcc_pric_attackhelospressingh", level, 0.4, "dx_cp_chem_atcc_lasw_pressbackuseantiairm"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_atcc_pric_attackhelosonme", level, 0.4, "dx_cp_chem_atcc_ghos_antiairmeasureswould"];
  aliases[aliases.size] = [level, "dx_cp_chem_atcc_ghos_shouldbealauncherint"];
  aliases[aliases.size] = [level, "dx_cp_chem_atcc_ghos_someofouraaarmaments"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_atcc_pric_helosgotmepinned", level, 0.4, "dx_cp_chem_atcc_lasw_hititwithalauncherjo"];
  var_3c7fb3b70666066c = create_deck(aliases, 1, 1);
  function_d307f2590e3f9841(2, undefined, 5);

  if(is_equal(level.checkpoint, "obj_reconArea_complete")) {
    wait 10;
  } else {
    wait 20;
  }

  while(true) {
    wait 0.5;

    if(function_94b00c0fad72704b(2, 1, 10, undefined, 5)) {
      level.player function_c9a09b3ba9c68f8d(0.6, var_cee9b146289dc187 deck_draw(), 0.5, 2);
      wait 30;
    }

    if(function_94b00c0fad72704b(2, 0, 10, 1000)) {
      level.player function_c9a09b3ba9c68f8d(0.3, var_3c7fb3b70666066c deck_draw(), 0.5, 2);
      wait 30;
    }
  }
}

function function_c0791d4fbca710d0() {
  for(;;) {
    level waittill("red_alert_begin");
    level flag_set("flag_alarm_triggered");

    if(flag("vo_alert_said")) {} else {
      flag_set("vo_alert_said");
    }

    waitframe();
  }
}

function function_c2a789ef4520475f() {
  level endon("game_ended");
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_kicm_pric_foundaguidedcruisemi", level, 0.5, "dx_cp_chem_kicm_lasw_thatsashowstopperfor", level, 0.2, "dx_cp_chem_kicm_ghos_boomgoesthebloodydyn"];
  var_141c625f61d37633 = create_deck(aliases, undefined, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_kisb_pric_gotastealthbomberons", level, 0.5, "dx_cp_chem_kisb_lasw_thatsonetheywontseec"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_kisb_pric_gotastealthbomberons", level, 0.5, "dx_cp_chem_kisb_ghos_useitwiselysix"];
  var_de8599066b9374f7 = create_deck(aliases, undefined, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_kipa_pric_couldcallinaprecisio", level, 0.5, "dx_cp_chem_kipa_lasw_saywhensix"];
  var_e16e57b92ca50c34 = create_deck(aliases, undefined, 1);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_ksre_lasw_uavisonstation"];
  var_502d875901b39e46 = create_deck(aliases, undefined, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_kirt_pric_pickeduparemoteturre", level, 0.5, "dx_cp_chem_kirt_ghos_konnisnotgonnaliketh"];
  var_cfaf5fca74c6fc44 = create_deck(aliases, undefined, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_kibd_pric_gotabombdrone", level, 0.5, "dx_cp_chem_kibd_ghos_c4withwings"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_kibd_pric_gotabombdrone", level, 0.5, "dx_cp_chem_kibd_lasw_onlywaytofly"];
  var_34d766cf17f42b7c = create_deck(aliases, undefined, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_kist_pric_foundasamturret", level, 0.5, "dx_cp_chem_kist_ghos_iftheresahelointheai"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_kist_pric_foundasamturret", level, 0.5, "dx_cp_chem_kist_ghos_iftheresanenemyheloi"];
  var_1d43f18ac20ac9f1 = create_deck(aliases, undefined, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_kims_pric_gotamortarstrike", level, 0.5, "dx_cp_chem_kims_lasw_goodfind"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_kims_pric_gotamortarstrike", level, 0.5, "dx_cp_chem_kims_ghos_unpredictableblastra"];
  var_cdd063fb81fda849 = create_deck(aliases, undefined, 1);
  var_d905479841f8d663 = [];

  for(var_ab3c3ba5750e2586 = 0; true; var_ab3c3ba5750e2586 = gettime()) {
    level waittill("munition_pickup", munition);

    if(array_contains(var_d905479841f8d663, munition)) {
      continue;
    }

    var_d905479841f8d663 = array_add(var_d905479841f8d663, munition);

    if(!time_has_passed(var_ab3c3ba5750e2586, 3)) {
      continue;
    }

    if(!function_94b00c0fad72704b([0, 1, 2], 1, 3, 200, 3)) {
      continue;
    }

    if(munition == "precision_airstrike") {
      level.player function_c9a09b3ba9c68f8d(1, var_e16e57b92ca50c34 deck_draw(), 0.3, 2);
    }

    if(munition == "uav") {
      level.player function_c9a09b3ba9c68f8d(1, var_502d875901b39e46 deck_draw(), 0.3, 2);
    }

    if(munition == "sentry") {
      level.player function_c9a09b3ba9c68f8d(1, var_cfaf5fca74c6fc44 deck_draw(), 0.3, 2);
    }

    if(munition == "auto_drone") {
      level.player function_c9a09b3ba9c68f8d(1, var_de8599066b9374f7 deck_draw(), 0.3, 2);
    }

    if(munition == "toma_strike") {
      level.player function_c9a09b3ba9c68f8d(1, var_cdd063fb81fda849 deck_draw(), 0.3, 2);
    }

    if(munition == "missile_turret") {
      if(level.var_aa14b2beb1308584 == 0) {
        level.player function_c9a09b3ba9c68f8d(1, var_1d43f18ac20ac9f1 deck_draw(), 0.3, 2);
      }

      if(level.var_aa14b2beb1308584 == 2) {
        level.player function_c9a09b3ba9c68f8d(1, ["dx_cp_chem_atcc_pric_foundafriendforthehe", level, "dx_cp_chem_atcc_ghos_niceacquaintthem"], 0.3, 2);
      }
    }

    if(munition == "cruise_missile") {
      level.player function_c9a09b3ba9c68f8d(1, var_141c625f61d37633 deck_draw(), 0.3, 2);
    }

    if(munition == "assault_drone") {
      if(level.var_aa14b2beb1308584 == 0) {
        level.player function_c9a09b3ba9c68f8d(1, var_34d766cf17f42b7c deck_draw(), 0.3, 2);
      }

      if(level.var_aa14b2beb1308584 == 2) {
        level.player function_fc0eb6b81c66c661(1, "dx_cp_chem_atcc_pric_thislltakedownahelo", 0.3, 2);
      }
    }
  }
}

function function_be4bdf27dec56891() {
  if(flag("flag_reactor_room_entered")) {
    return;
  }

  level endon("flag_reactor_room_entered");
  level endon("flag_obj_all_helis_killed");
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_c4pn_pric_gotc4";
  aliases[aliases.size] = "dx_cp_chem_c4pn_pric_pickedupchargestogro";
  aliases[aliases.size] = "dx_cp_chem_c4pn_pric_foundexplosivesforth";
  var_d1705b4d1d903bdd = create_deck(aliases, undefined, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_c4pn_ghos_giveemhell";
  aliases[aliases.size] = "dx_cp_chem_c4pn_ghos_thatllpunchemaoneway";
  var_222120256baec9f3 = create_deck(aliases, undefined, 1);

  while(true) {
    level.player waittill("self_pickedupitem_brloot_offhand_c4");

    if(!function_94b00c0fad72704b([0, 2, 1], 1, 3, 500, 5)) {
      continue;
    }

    level.player function_fc0eb6b81c66c661(0.3, var_d1705b4d1d903bdd deck_draw(), 0.3, 1);
    level function_fc0eb6b81c66c661(0.3, var_222120256baec9f3 deck_draw(), 0.3, 1);
    wait 60;
  }
}

function function_7d76321d25c90dfd() {
  level endon("game_ended");
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_coac_pric_takingenemyjltv";
  aliases[aliases.size] = "dx_cp_chem_coac_pric_jltvjacked";
  aliases[aliases.size] = "dx_cp_chem_coac_pric_inakonnijltv";
  var_692b29e4c426879f = create_deck(aliases, undefined, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_coac_pric_foundacivlianvehicle";
  aliases[aliases.size] = "dx_cp_chem_coac_pric_takingabandonedvehic";
  var_b2ffa5f5a0f9fe24 = create_deck(aliases, undefined, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_coac_pric_gotanatv";
  aliases[aliases.size] = "dx_cp_chem_coac_pric_tookanatv";
  var_3f58184e7d831e76 = create_deck(aliases, undefined, 1);

  while(true) {
    level.player waittill("entered_vehicle");

    if(!function_94b00c0fad72704b([0, 1, 2, 4], undefined, undefined, 800)) {
      continue;
    }

    if(!isDefined(level.player) || !isDefined(level.player.vehicle) || !isDefined(level.player.vehicle.vehiclename)) {
      continue;
    }

    var_cb779aabadc582d9 = "civ";

    if(issubstr(level.player.vehicle.vehiclename, "veh_jup_jltv")) {
      var_cb779aabadc582d9 = "jltv";
    } else if(issubstr(level.player.vehicle.vehiclename, "veh_jup_atv")) {
      var_cb779aabadc582d9 = "atv";
    }

    line_delay = randomfloatrange(0.8, 2);

    switch (var_cb779aabadc582d9) {
      case #"hash_1a9f0a6c17f3d295":
        level.player function_c9a09b3ba9c68f8d(line_delay, var_b2ffa5f5a0f9fe24 deck_draw(), 0.3, 4);
        break;
      case #"hash_d63ab45faf622239":
        level.player function_c9a09b3ba9c68f8d(line_delay, var_692b29e4c426879f deck_draw(), 0.3, 4);
        break;
      case #"hash_c93466c10cc10ba":
        level.player function_c9a09b3ba9c68f8d(line_delay, var_3f58184e7d831e76 deck_draw(), 0.3, 4);
        break;
    }

    wait 60;
  }
}

function function_9778fd0c8fb5dc5c() {
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_hwph_lasw_bringingthebiggunsis"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_hwph_pric_foundsomeheatforthat"];
  aliases[aliases.size] = [level, "dx_cp_chem_hwph_ghos_thatsthegoodstuff"];
  aliases[aliases.size] = [level, "dx_cp_chem_hwph_lasw_thatsabeast"];
  aliases[aliases.size] = [level, "dx_cp_chem_hwph_lasw_thatsaworldohurtrigh"];
  aliases[aliases.size] = [level, "dx_cp_chem_hwph_lasw_talkaboutfirepower"];
  var_96860e5cbb0d4528 = create_deck(aliases, undefined, 1);

  while(true) {
    level waittill("pickedupweapon_all", var_58045689f6b0376);

    if(function_94b00c0fad72704b(1, undefined, 5) && isDefined(var_58045689f6b0376.customweaponname) && issubstr(var_58045689f6b0376.customweaponname, "_la_") && flag("player_outside")) {
      level function_c9a09b3ba9c68f8d(1, var_96860e5cbb0d4528 deck_draw(), 0.5, 1);
    }

    if(function_94b00c0fad72704b(2, undefined, 5) && isDefined(var_58045689f6b0376.customweaponname) && issubstr(var_58045689f6b0376.customweaponname, "iw9_la_rpapa7_mp+dynamic_null_rpapa7+rec_rpapa7") && flag("player_outside")) {
      level.player function_c9a09b3ba9c68f8d(1, ["dx_cp_chem_atcc_pric_foundanrpg", level, "dx_cp_chem_atcc_ghos_thatllbringthehelodo"], 0.5, 1);
    }
  }
}

function function_a18a28cf5bddfe5e() {
  level endon("game_ended");
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_flre_pric_crossbowexplosivetip"];
  var_faa6385a289252a7 = create_deck(aliases);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_flre_ghos_oneofmyalltimefavori"];
  var_6d50867249a96d44 = create_deck(aliases);

  while(true) {
    wait 0.25;
    level waittill("blueprint_crate_used", item_name);

    if(function_94b00c0fad72704b([0, 4, 1], 1)) {
      if(item_name == "iw9_dm_crossbow_jup_sp_v3") {
        level.player function_c9a09b3ba9c68f8d(3, var_faa6385a289252a7 deck_draw(), 0.5, 7);
      }

      if(item_name == "iw9_lm_dblmg_jup_sp_v1") {
        level.player function_c9a09b3ba9c68f8d(4, var_6d50867249a96d44 deck_draw(), 0.5, 7);
      }
    }
  }
}

function function_263fb36ccd070ee3(var_b5ee72e3bf7f9057) {
  level endon("game_ended");
  level endon(var_b5ee72e3bf7f9057 + "_solved");

  while(true) {
    level waittill("door_attempted " + var_b5ee72e3bf7f9057);

    if(function_94b00c0fad72704b([0, 1], 1, undefined, 500)) {
      break;
    }
  }

  if(var_b5ee72e3bf7f9057 == "(-1446.09, 22230.1, 1017)") {
    level.player function_fc0eb6b81c66c661(0.5, "dx_cp_chem_lcdi_pric_lockedneedtofindanot", 0.5, 3);
  }

  if(var_b5ee72e3bf7f9057 == "(-5865.12, 22316.5, 1000)") {
    level.player function_fc0eb6b81c66c661(0.5, "dx_cp_chem_lcdi_pric_nojoyshouldcheckhigh", 0.5, 3);
  }

  if(var_b5ee72e3bf7f9057 == "(700.241, 29487.2, 1010.5)") {
    level.player function_fc0eb6b81c66c661(0.5, "dx_cp_chem_lcdi_pric_barricadedfromopposi", 0.5, 3);
  }

  if(var_b5ee72e3bf7f9057 == "(-10637.2, 29807.4, 1209.5)") {
    level.player function_fc0eb6b81c66c661(0.5, "dx_cp_chem_erpo_pric_lockedmeanstheressom", 0.5, 3);
  }
}

function function_b318ac8c04543e41() {
  level endon("game_ended");

  if(flag("(-1446.09, 22230.1, 1017)" + "_solved")) {
    return;
  }

  level thread function_263fb36ccd070ee3("(-1446.09, 22230.1, 1017)");
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_iods_lasw_equipmentcachecheckf";
  aliases[aliases.size] = "dx_cp_chem_iods_lasw_couldgrabwhatyouneed";
  aliases[aliases.size] = "dx_cp_chem_iods_lasw_couldgrabwhatyouneed_01";
  var_5922d104ac0b2de6 = create_deck(aliases, undefined, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_iods_pric_illgraballican";
  aliases[aliases.size] = "dx_cp_chem_iods_pric_somenewgearwouldbeus";
  aliases[aliases.size] = "dx_cp_chem_iods_pric_rogilltakewhatican";
  aliases[aliases.size] = "dx_cp_chem_iods_pric_copyillgearup";
  aliases[aliases.size] = "dx_cp_chem_iods_pric_goodcallwatcherdontm";
  var_3b9d42608db26ee6 = create_deck(aliases, undefined, 1);
  vol = function_f159c10d5cf8f0b4("PUZZLE_1", "script_noteworthy")[0];
  vol function_85aedb842bdb548b();
  vol function_847531f882fe30d0(1);
  vol function_70c1d0abf9be9b83(1);
  vol function_bab704273dd54bf8(1200);
  vol waittill("PUZZLE_1", var_e5b495906761a6cc);

  if(function_94b00c0fad72704b([0, 1], 1)) {
    level.player thread function_fc0eb6b81c66c661(0.5, "dx_cp_chem_iods_pric_needtolocateanentryw", 0.5, 5);
  }

  level waittill("blocker_destroyed " + "(-1446.09, 22230.1, 1017)");

  if(function_94b00c0fad72704b([0, 1], 1)) {
    level.player function_fc0eb6b81c66c661(0.5, "dx_cp_chem_iods_pric_therewego", 0.5, 3);
  }

  function_a20f67b33165ceb("trigger_puzzle_spray");

  if(function_94b00c0fad72704b([0, 1], 1)) {
    level function_fc0eb6b81c66c661(0.5, var_5922d104ac0b2de6 deck_draw(), 0.5, 1);
    wait 1;
    level.player function_fc0eb6b81c66c661(0.5, var_3b9d42608db26ee6 deck_draw(), 0.5, 2);
  }
}

function function_393409c653af83fc() {
  level endon("game_ended");

  if(flag("(-5865.12, 22316.5, 1000)" + "_solved")) {
    return;
  }

  level thread function_263fb36ccd070ee3("(-5865.12, 22316.5, 1000)");
  vol = function_f159c10d5cf8f0b4("PUZZLE_FIREHOUSE", "script_noteworthy")[0];
  vol function_85aedb842bdb548b();
  vol function_847531f882fe30d0(1);
  vol function_70c1d0abf9be9b83(1);
  vol function_bab704273dd54bf8(400);
  vol waittill("PUZZLE_FIREHOUSE", var_e5b495906761a6cc);

  if(function_94b00c0fad72704b([0, 1], 1)) {
    level.player thread function_c9a09b3ba9c68f8d(0.5, [level.player, "dx_cp_chem_rnkd_pric_lookslikesomethingsh", level, 0.6, "dx_cp_chem_rnkd_ghos_copycaptain"], 0.5, 5);
  }

  level waittill("blocker_destroyed " + "(-5865.12, 22316.5, 1000)");

  if(function_94b00c0fad72704b([0, 1], 1)) {
    level.player function_c9a09b3ba9c68f8d(1, [level.player, "dx_cp_chem_rnkd_pric_betterbeworthit", level, 0.6, "dx_cp_chem_rnkd_lasw_goodmovejohn"], 0.5, 3);
  }

  function_a20f67b33165ceb("trigger_puzzle_firehouse");

  if(function_94b00c0fad72704b([0, 1], 1)) {
    level.player function_c9a09b3ba9c68f8d(0.5, [level.player, "dx_cp_chem_rnkd_pric_oldsupplycacheilltak", level, 0.6, "dx_cp_chem_rnkd_lasw_raiditsix"], 0.5, 3);
  }
}

function function_578b731e7f4ac46c() {
  level endon("game_ended");

  if(flag("(700.241, 29487.2, 1010.5)" + "_solved")) {
    return;
  }

  level thread function_263fb36ccd070ee3("(700.241, 29487.2, 1010.5)");
  vol = function_f159c10d5cf8f0b4("PUZZLE_PARKING", "script_noteworthy")[0];
  vol function_85aedb842bdb548b();
  vol function_847531f882fe30d0(1);
  vol function_70c1d0abf9be9b83(1);
  vol function_bab704273dd54bf8(1800);
  vol waittill("PUZZLE_PARKING", var_e5b495906761a6cc);

  if(function_94b00c0fad72704b([0, 1], 1)) {
    level function_fc0eb6b81c66c661(0.5, "dx_cp_chem_xvfi_lasw_thatbuildinggotflagg", 0.5, 5);
  }

  function_a20f67b33165ceb("trigger_puzzle_parking");

  if(function_94b00c0fad72704b([0, 1], 1)) {
    level.player thread function_fc0eb6b81c66c661(0.5, "dx_cp_chem_xvfi_pric_iminnotabadhaulinher", 0.5, 1);
  }

  level waittill("blocker_destroyed " + "(700.241, 29487.2, 1010.5)");

  if(function_94b00c0fad72704b([0, 1], 1)) {
    level.player function_fc0eb6b81c66c661(0.5, "dx_cp_chem_xvfi_pric_prettyhightechforthi", 0.5, 2);
  }
}

function function_24740fd698aac2cc() {
  level endon("game_ended");
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_nidp_pric_herewego"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_nidp_pric_letstakealook"];
  var_eaf36323942aefbd = create_deck(aliases, undefined, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_nidp_pric_watcheryouseeingthis", level, 0.2, "dx_cp_chem_nidp_lasw_iseeitpackageinbound"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_nidp_pric_requestingvehiclepos", level, 0.2, "dx_cp_chem_nidp_lasw_markacquiredsixpacka"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_nidp_pric_locationmarked", level, 0.2, "dx_cp_chem_nidp_lasw_receivedcomintoyasta"];
  var_692b29e4c426879f = create_deck(aliases, undefined, 1);
  flag_wait("puzzle_jltv_complete");
  level.player function_c9a09b3ba9c68f8d(0.5, var_eaf36323942aefbd deck_draw(), 0.3, 1);

  if(!function_94b00c0fad72704b([0, 1], undefined)) {
    return;
  }

  level.player function_c9a09b3ba9c68f8d(1, var_692b29e4c426879f deck_draw(), 0.3, 4);
}

function function_5cf5e508cd2dd387() {
  level endon("game_ended");

  if(flag("(-10637.2, 29807.4, 1209.5)" + "_solved")) {
    return;
  }

  level thread function_263fb36ccd070ee3("(-10637.2, 29807.4, 1209.5)");
  vol = function_f159c10d5cf8f0b4("PUZZLE_CONTAINMENT", "script_noteworthy")[0];
  vol function_85aedb842bdb548b();
  vol function_847531f882fe30d0(1);
  vol function_70c1d0abf9be9b83(1);
  vol function_bab704273dd54bf8(2500);
  vol waittill("PUZZLE_CONTAINMENT", var_e5b495906761a6cc);

  if(function_94b00c0fad72704b([0, 1], 1, 1)) {
    level.player function_fc0eb6b81c66c661(0.5, "dx_cp_chem_erpo_pric_buildingappearsquest", 0.5, 3);
  }

  function_a20f67b33165ceb("trigger_puzzle_containment");

  if(function_94b00c0fad72704b([0, 1], 1)) {
    level.player function_fc0eb6b81c66c661(0.5, "dx_cp_chem_erpo_pric_makingentry", 0.5, 2);
  }

  function_a20f67b33165ceb("trigger_puzzle_containment_reward");

  if(function_94b00c0fad72704b([0, 1], 1)) {
    level.player function_fc0eb6b81c66c661(0.5, "dx_cp_chem_erpo_pric_couldusethistoouradv", 0.5, 2);
  }
}

function function_394f64ed1da6646c(time) {
  if(!isDefined(level.var_3863a1c73dc4cd3c)) {
    level.var_3863a1c73dc4cd3c = gettime();
  }

  if(!isDefined(time)) {
    time = default_to(time, 75);
  }

  if(time_has_passed(level.var_3863a1c73dc4cd3c, time)) {
    return true;
  }

  return false;
}

function function_4bb76241137e4cab() {
  if(flag("flag_reactor_room_entered")) {
    return;
  }

  level endon("flag_reactor_room_entered");
  level flag_wait("flag_obj_all_helis_killed");
  wait 4;
  level function_fc0eb6b81c66c661(1, "dx_cp_chem_epge_lasw_beadvisedbravo6konni", 1, 6, 0);

  if(function_1445c12552b674d4()) {
    if(function_94b00c0fad72704b(2)) {
      aliases = [];
      aliases[aliases.size] = [level.player, "dx_cp_chem_gtor_pric_attackheloisstillove"];
      aliases[aliases.size] = [level.player, "dx_cp_chem_gtor_pric_theattackheloisntgoi"];
      aliases[aliases.size] = [level.player, "dx_cp_chem_gtor_pric_attackheloisstillout"];
      var_be881118e122c538 = create_deck(aliases, undefined, 1);
      level.player function_c9a09b3ba9c68f8d(0.3, var_be881118e122c538 deck_draw(), 1, 3);
      level.var_3863a1c73dc4cd3c = gettime();
    } else {
      level.player function_fc0eb6b81c66c661(0.3, "dx_cp_chem_gtor_pric_movingtothereactorst", 1, 3);
      response = "dx_cp_chem_gtor_lasw_copythatallbravocoll";
      level function_fc0eb6b81c66c661(0.3, response, 1, 3);
      level.var_3863a1c73dc4cd3c = gettime();
    }
  }

  while(true) {
    if(!function_1445c12552b674d4() &function_fb8e359d94e5515d(5) || function_394f64ed1da6646c(40)) {
      if(function_6c93dcce28cfcc28()) {
        aliases = [];
        aliases[aliases.size] = "dx_cp_chem_epip_lasw_06thereactorshouldha";
        aliases[aliases.size] = "dx_cp_chem_epip_lasw_entrancetothereactor";
        aliases[aliases.size] = "dx_cp_chem_epip_lasw_bravo6lookforanentra";
        var_cc0e137d37861965 = create_deck(aliases, undefined, 1);
        level function_fc0eb6b81c66c661(1, var_cc0e137d37861965 deck_draw(), 0.8, 5);
        flag_set("vo_enter_plant_parking");
        break;
      }

      if(function_f66674e43ad96fc7()) {
        aliases = [];
        aliases[aliases.size] = "dx_cp_chem_epis_lasw_locateanentrypointto";
        aliases[aliases.size] = "dx_cp_chem_epis_lasw_06thereshouldbeanent";
        aliases[aliases.size] = "dx_cp_chem_epis_lasw_yourenearthereactor0";
        var_264c390a1771cb56 = create_deck(aliases, undefined, 1);
        level function_fc0eb6b81c66c661(1, var_264c390a1771cb56 deck_draw(), 0.8, 5);
        flag_set("vo_enter_plant_spray");
        break;
      }

      if(function_a9591d332b6b3464()) {
        aliases = [];
        aliases[aliases.size] = "dx_cp_chem_epic_lasw_06konnisatthereactor";
        aliases[aliases.size] = "dx_cp_chem_epic_lasw_konnifoundanentrypoi";
        aliases[aliases.size] = "dx_cp_chem_epic_lasw_06konnisaccessedther";
        var_fd6634bd0210023d = create_deck(aliases, undefined, 1);
        level function_fc0eb6b81c66c661(1, var_fd6634bd0210023d deck_draw(), 0.8, 5);
        flag_set("vo_enter_plant_containment");
        break;
      }

      if(level.var_2745498dd7dc0a6d == "med_dst_plant" && !level.player function_28f3273faec1d365()) {
        level say("dx_cp_chem_epim_lasw_niceworkwiththehelos", 0.8, 3);
        break;
      }

      if(level.var_2745498dd7dc0a6d == "long_dst_plant" && !level.player function_28f3273faec1d365()) {
        aliases = [];
        aliases[aliases.size] = "dx_cp_chem_epil_lasw_06gettothereactorfas";
        aliases[aliases.size] = "dx_cp_chem_epil_lasw_entrypointtothereact";
        var_d2b28cac22c5bbe9 = create_deck(aliases, undefined, 1);
        level function_fc0eb6b81c66c661(1, var_d2b28cac22c5bbe9 deck_draw(), 0.8, 5);
        break;
      }

      if(level.var_2745498dd7dc0a6d == "exterior" && !level.player function_28f3273faec1d365()) {
        aliases = [];
        aliases[aliases.size] = "dx_cp_chem_epie_lasw_06entrytothereactori";
        aliases[aliases.size] = "dx_cp_chem_epie_lasw_reactorsinthecentero";
        var_8c0f1afb7828ac49 = create_deck(aliases, undefined, 1);
        level function_fc0eb6b81c66c661(1, var_8c0f1afb7828ac49 deck_draw(), 0.8, 5);
        break;
      }
    }

    wait 1;
  }

  level.var_3863a1c73dc4cd3c = gettime();
  flag_set("obj_enter_plant_vo_given");
}

function function_1e27329186d2d067() {
  if(flag("flag_power_plant_entered")) {
    return;
  }

  level endon("flag_power_plant_entered");
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_epew_lasw_entrypointshouldbecl";
  aliases[aliases.size] = "dx_cp_chem_epew_lasw_sweepforanentrypoint";
  aliases[aliases.size] = "dx_cp_chem_epew_lasw_06entrywillbeclosert";
  var_1679ffe32eaf3461 = create_deck(aliases, undefined, 1);
  level flag_wait("flag_obj_all_helis_killed");
  level flag_wait("obj_enter_plant_vo_given");

  while(true) {
    if(level.var_2745498dd7dc0a6d == "entrance_wing" && function_1088ef0247841cc9(10) && !function_1445c12552b674d4() && function_394f64ed1da6646c(10)) {
      level function_fc0eb6b81c66c661(0.3, var_1679ffe32eaf3461 deck_draw(), 0.7, 1);
      level.var_3863a1c73dc4cd3c = gettime();
      return;
    }

    wait 0.5;
  }
}

function function_ef7e90b36127ca23() {
  if(flag("flag_power_plant_entered")) {
    return;
  }

  level endon("flag_power_plant_entered");
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_eper_lasw_06imnotseeinganentry";
  aliases[aliases.size] = "dx_cp_chem_eper_ghos_noentrypointsthatica";
  aliases[aliases.size] = "dx_cp_chem_eper_lasw_06advisecheckingthed";
  var_467bcef66526435d = create_deck(aliases, undefined, 1);
  level flag_wait("flag_obj_all_helis_killed");
  level flag_wait("obj_enter_plant_vo_given");

  while(true) {
    if(level.var_2745498dd7dc0a6d == "entry_building_rooftop" && !function_1445c12552b674d4() && function_1088ef0247841cc9(30) && function_394f64ed1da6646c(10)) {
      level function_fc0eb6b81c66c661(0.3, var_467bcef66526435d deck_draw(), 0.7, 1);
      level.var_3863a1c73dc4cd3c = gettime();
      return;
    }

    wait 0.5;
  }
}

function function_de08b769a6e326a7() {
  if(flag("flag_power_plant_entered")) {
    return;
  }

  level endon("flag_power_plant_entered");
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_epct_lasw_06yourebehindtheplan";
  aliases[aliases.size] = "dx_cp_chem_epct_ghos_yourejustbehindthepl";
  aliases[aliases.size] = "dx_cp_chem_epct_lasw_circlebacktothefront";
  aliases[aliases.size] = "dx_cp_chem_epct_lasw_bravo6youreneartheba";
  var_7539d7c6700cd67a = create_deck(aliases, undefined, 1);
  level flag_wait("flag_obj_all_helis_killed");
  level flag_wait("obj_enter_plant_vo_given");

  while(true) {
    if(level.var_2745498dd7dc0a6d == "cooling_towers" && !function_1445c12552b674d4() && function_1088ef0247841cc9(30) && function_394f64ed1da6646c(10)) {
      level function_fc0eb6b81c66c661(0.3, var_7539d7c6700cd67a deck_draw(), 0.7, 3);
      level.var_3863a1c73dc4cd3c = gettime();
      return;
    }

    wait 0.5;
  }
}

function function_9ac1f5d7fc0a7996() {
  if(flag("flag_power_plant_entered")) {
    return;
  }

  level endon("flag_power_plant_entered");
  level flag_wait("flag_obj_all_helis_killed");
  level flag_wait("obj_enter_plant_vo_given");

  while(true) {
    if(level.var_2745498dd7dc0a6d == "back_side_airlock" && function_394f64ed1da6646c(20)) {
      if(function_299424620c86e0e0(level.player, 1250).size > 0 && !function_1445c12552b674d4()) {
        aliases = [];
        aliases[aliases.size] = "dx_cp_chem_epba_lasw_06multiplekonniahead";
        aliases[aliases.size] = "dx_cp_chem_epba_ghos_hostilesonguardahead";
        aliases[aliases.size] = "dx_cp_chem_epba_ghos_hostilesaheadofyoumu";
        aliases[aliases.size] = "dx_cp_chem_gore_lasw_06youreapproachingth";
        aliases[aliases.size] = "dx_cp_chem_gore_ghos_captaintheresapatrol";
        aliases[aliases.size] = "dx_cp_chem_gore_lasw_bravo06isrshowskonni";
        aliases[aliases.size] = "dx_cp_chem_gore_lasw_beadvised06konnipers";
        aliases[aliases.size] = "dx_cp_chem_epba_lasw_06imseeingkonniahead";
        var_67bbc821d9d64199 = create_deck(aliases, undefined, 1);
        level function_fc0eb6b81c66c661(0.5, var_67bbc821d9d64199 deck_draw(), 0.7, 2);
        level.var_3863a1c73dc4cd3c = gettime();
        return;
      }

      if(function_299424620c86e0e0(level.player, 1250).size <= 0 && !function_1445c12552b674d4()) {
        aliases = [];
        aliases[aliases.size] = "dx_cp_chem_epba_lasw_keepsearchingnearyou";
        aliases[aliases.size] = "dx_cp_chem_grne_ghos_captainiseeyourenear";
        aliases[aliases.size] = "dx_cp_chem_grne_ghos_yourenearthereactorc";
        aliases[aliases.size] = "dx_cp_chem_grne_lasw_thereactorsclose06ko";
        aliases[aliases.size] = "dx_cp_chem_grne_lasw_bravo06yourenearther";
        aliases[aliases.size] = "dx_cp_chem_grne_lasw_06youreapproachingth";
        var_a1471995ff6771a2 = create_deck(aliases, undefined, 1);
        level function_fc0eb6b81c66c661(0.5, var_a1471995ff6771a2 deck_draw(), 0.7, 2);
        level.var_3863a1c73dc4cd3c = gettime();
        return;
      }

      if(function_1445c12552b674d4()) {
        level function_fc0eb6b81c66c661(0.5, "dx_cp_chem_epba_lasw_konnisaheadofyou06po", 0.7, 2);
        level.var_3863a1c73dc4cd3c = gettime();
        return;
      }
    }

    wait 0.5;
  }
}

function function_302b9f93bcb66010() {
  if(flag("flag_power_plant_entered")) {
    return;
  }

  level endon("flag_power_plant_entered");
  level flag_wait("flag_obj_all_helis_killed");
  level flag_wait("obj_enter_plant_vo_given");
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_eprf_ghos_shouldbeclosetoanent";
  aliases[aliases.size] = "dx_cp_chem_eprf_lasw_06lookforanentrypoin";
  aliases[aliases.size] = "dx_cp_chem_eprf_lasw_checktheareaforanent";
  aliases[aliases.size] = "dx_cp_chem_eprf_lasw_sweepthearea06locate";
  var_7696854b742bd3a9 = create_deck(aliases, undefined, 1);

  while(true) {
    if(function_94b00c0fad72704b(4, undefined, 5, undefined, undefined, "turbine_rooftop")) {
      level function_fc0eb6b81c66c661(0.5, var_7696854b742bd3a9 deck_draw(), 0.7, 2);
      return;
    }

    wait 0.5;
  }
}

function function_714a3a97028fea45() {
  if(flag("flag_power_plant_entered")) {
    return;
  }

  level endon("flag_power_plant_entered");
  thread function_fe32e2cdf2853bed();
  level flag_wait("flag_obj_all_helis_killed");
  level flag_wait("obj_enter_plant_vo_given");
  level.var_3863a1c73dc4cd3c = gettime();

  while(true) {
    wait 0.5;

    if(!function_94b00c0fad72704b(4)) {
      continue;
    }

    if(!function_394f64ed1da6646c(35)) {
      continue;
    }

    if(!function_94b00c0fad72704b(4, 1, 5, undefined, 2, ["exterior", "long_dst_plant"])) {
      continue;
    }

    if(level.var_2745498dd7dc0a6d == "exterior") {
      if(percent_chance(70)) {
        level function_c9a09b3ba9c68f8d(2, level.var_a5472c547a946012 deck_draw(), 0.5, 5);
        level.var_3863a1c73dc4cd3c = gettime();
      } else {
        level function_c9a09b3ba9c68f8d(2, level.var_efc57afdf578f887 deck_draw(), 0.3, 5);
        level.var_3863a1c73dc4cd3c = gettime();
      }
    }

    if(level.var_2745498dd7dc0a6d == "long_dst_plant") {
      if(percent_chance(70)) {
        level function_c9a09b3ba9c68f8d(2, level.var_a5472c547a946012 deck_draw(), 0.5, 5);
        level.var_3863a1c73dc4cd3c = gettime();
        continue;
      }

      level function_c9a09b3ba9c68f8d(2, level.var_efc57afdf578f887 deck_draw(), 0.3, 5);
      level.var_3863a1c73dc4cd3c = gettime();
    }
  }
}

function function_fe32e2cdf2853bed() {
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_epne_lasw_findanentrypointtoth"];
  aliases[aliases.size] = [level, "dx_cp_chem_epne_ghos_weneedtopickupthepac"];
  aliases[aliases.size] = [level, "dx_cp_chem_epne_lasw_pickupthepace06dontl"];
  aliases[aliases.size] = [level, "dx_cp_chem_epne_lasw_06locateanentrypoint"];
  aliases[aliases.size] = [level, "dx_cp_chem_chnn_ghos_clockstickingcaptain"];
  aliases[aliases.size] = [level, "dx_cp_chem_chnn_ghos_konniwontwaitforusca"];
  aliases[aliases.size] = [level, "dx_cp_chem_epnl_lasw_allbravomovetothecen"];
  aliases[aliases.size] = [level, "dx_cp_chem_epnl_lasw_allbravokonnihasgain"];
  aliases[aliases.size] = [level, "dx_cp_chem_epge_lasw_06konnismadeentrytot"];
  aliases[aliases.size] = [level, "dx_cp_chem_epge_lasw_06thereactoriscompro"];
  aliases[aliases.size] = [level, "dx_cp_chem_epnl_lasw_watchertobravolocate"];
  aliases[aliases.size] = [level, "dx_cp_chem_epnl_ghos_konnismobilizingatth"];
  aliases[aliases.size] = [level, "dx_cp_chem_epge_ghos_konnisalreadyinsidec"];
  level.var_a5472c547a946012 = create_deck(aliases, undefined, 1);
}

function function_584686b5e68303b6() {
  if(flag("flag_power_plant_entered")) {
    return;
  }

  level endon("flag_power_plant_entered");
  level flag_wait("flag_obj_all_helis_killed");
  level flag_wait("obj_enter_plant_vo_given");
  vol = function_f159c10d5cf8f0b4("DOME", "script_noteworthy")[0];
  vol function_85aedb842bdb548b();
  vol function_847531f882fe30d0(1);
  vol function_bab704273dd54bf8(3000);
  aliases = ["dx_cp_chem_epdd_ghos_captainidontthinkyou", "dx_cp_chem_epdd_lasw_bravo06imnotseeingan"];
  var_692b4d3f8324640e = create_deck(aliases);

  while(true) {
    wait 0.5;

    if(!function_94b00c0fad72704b([4, 0, 1], 1, 5, undefined, undefined)) {
      continue;
    }

    vol waittill("DOME", var_e5b495906761a6cc);

    if(function_94b00c0fad72704b(4, undefined, 5, undefined, undefined, "crane_top")) {
      level function_fc0eb6b81c66c661(0.5, var_692b4d3f8324640e deck_draw(), 0.5, 2);
    }

    if(function_94b00c0fad72704b([0, 1], 1, 3)) {
      aliases = [level.player, "dx_cp_chem_chsa_pric_interrogativewatcher", level, 0.4, "dx_cp_chem_chsa_lasw_affirmativesixexactl", level.player, 0.3, "dx_cp_chem_chsa_pric_betheshavingahotdrin", level, 0.4, "dx_cp_chem_chsa_lasw_letsgetmakarovaseatn", level.player, 0.4, "dx_cp_chem_chsa_pric_iintendto"];
      level.player function_c9a09b3ba9c68f8d(0.5, aliases, 0.3, 2);
    }

    return;
  }
}

function function_fe6769318b6e12f2() {
  level endon("game_ended");
  level endon("flag_reactor_airlock_passed");
  level flag_wait("flag_obj_all_helis_killed");
  level flag_wait("obj_enter_plant_vo_given");

  if(level.checkpoint == "obj_enterReactor_complete") {
    return;
  }

  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_epin_pric_visualonanairlock", level, "dx_cp_chem_epin_lasw_copy06thatsyourentry"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_rair_pric_foundtheentrance", level, "dx_cp_chem_epin_lasw_copy06thatsyourentry"];
  var_3426d5b45649c274 = create_deck(aliases, undefined, 1);
  vol = function_f159c10d5cf8f0b4("recon_airlock_entrance", "script_noteworthy")[0];
  vol function_85aedb842bdb548b();
  vol function_847531f882fe30d0(1);
  vol function_bab704273dd54bf8(800);

  while(true) {
    wait 0.5;

    if(!function_94b00c0fad72704b(4, undefined, 5)) {
      continue;
    }

    vol waittill("recon_airlock_entrance", var_e5b495906761a6cc);

    if(!function_94b00c0fad72704b(4, undefined, 5)) {
      continue;
    }

    if(!level.player function_28f3273faec1d365()) {
      level.player function_c9a09b3ba9c68f8d(0.5, var_3426d5b45649c274 deck_draw(), 0.9, 2);
    }

    return;
  }
}

function function_e4d64449ae7942c9() {
  level endon("game_ended");
  level endon("flag_reactor_airlock_passed");
  level flag_wait("flag_obj_all_helis_killed");
  level flag_wait("obj_enter_plant_vo_given");

  if(!flag("init_decks")) {
    aliases = [];
    aliases[aliases.size] = [level.player, "dx_cp_chem_epin_pric_movinginterior", level, 0.4, "dx_cp_chem_epin_lasw_copy06entrytothereac"];
    aliases[aliases.size] = [level.player, "dx_cp_chem_epin_pric_movinginternal", level, 0.4, "dx_cp_chem_epin_lasw_copy06entrytothereac"];
    var_adb7cc7e5ab4e2bb = create_deck(aliases, undefined, 1);
    aliases = [];
    aliases[aliases.size] = [level.player, "dx_cp_chem_epin_pric_searchingitsadamnmaz", level, 0.4, "dx_cp_chem_epin_lasw_keepsearchingtheturb"];
    aliases[aliases.size] = [level.player, "dx_cp_chem_epin_pric_stillmovingthroughth", level, 0.4, "dx_cp_chem_epin_lasw_eyesopenforanairlock"];
    aliases[aliases.size] = [level.player, "dx_cp_chem_epin_pric_stilllookingmorethan", level, 0.4, "dx_cp_chem_epin_lasw_copy06eyesopenforana"];
    aliases[aliases.size] = [level.player, "dx_cp_chem_epin_pric_wherethefuckisit", level, 0.4, "dx_cp_chem_epin_lasw_06yourecloseturbineb"];
    aliases[aliases.size] = [level.player, "dx_cp_chem_epin_pric_thefuckistheentry", level.player, 0.4, "dx_cp_chem_epin_pric_bloodylabyrinth"];
    var_6376d30d3dcd709 = create_deck(aliases, undefined, 1);
    flag_set("init_decks");
  }

  function_d307f2590e3f9841(4, undefined, 1, undefined, undefined, "turbines");
  level.player say_sequence(var_adb7cc7e5ab4e2bb deck_draw(), 0.9, 2);

  while(true) {
    wait 0.5;

    if(!function_94b00c0fad72704b(4, undefined, 45, undefined, undefined, "turbines")) {
      continue;
    }

    if(flag("flag_reactor_airlock_passed")) {
      return;
    }

    level.player function_c9a09b3ba9c68f8d(0.3, var_6376d30d3dcd709 deck_draw(), 0.8, 3);
  }
}

function function_d0ec4b3121a50d6a() {
  level endon("game_ended");
  DOME = function_1c4d592029f2b0d3("vo_vol_dome");
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_chnn_pric_notseeingawayintothe"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_chnn_pric_cantgettothepowerpla"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_chnn_pric_cantaccessthepowerpl"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_chnn_pric_noaccesstothepowerpl"];
  var_5507ad0499d10f93 = create_deck(aliases, undefined, 1);
  aliases = [];
  aliases[aliases.size] = [level, 0.4, "dx_cp_chem_chnn_lasw_copycheckelsewhereca"];
  aliases[aliases.size] = [level, 0.4, "dx_cp_chem_chnn_lasw_konniwontwaitforusca"];
  var_ccb5b6ad2388ca65 = create_deck(aliases, undefined, 1);

  while(true) {
    if(function_94b00c0fad72704b(5)) {
      return;
    }

    wait 0.25;

    if(!function_94b00c0fad72704b(4, 1, undefined, undefined, undefined, "plant_dome")) {
      continue;
    }

    if(!function_1088ef0247841cc9(15)) {
      continue;
    }

    level.player function_c9a09b3ba9c68f8d(0.3, [var_5507ad0499d10f93 deck_draw(), var_ccb5b6ad2388ca65 deck_draw()], 0.7, 3);
  }
}

function function_a8d471dd6e4a3f77() {
  if(flag("flag_player_near_heli_objective")) {
    return true;
  }

  return false;
}

function function_27fe9c2561fe01a6() {
  level.player endon("death");
  function_cd85611542ee2f28();

  while(true) {
    level.player waittill("munitions_used", var_2c89f65e3870e2b6);

    if(!function_94b00c0fad72704b([0, 1, 2, 4])) {
      continue;
    }

    switch (var_2c89f65e3870e2b6) {
      case #"hash_634b246c3da5c56f":
        level thread function_e09196f444ff3525();
        break;
      case #"hash_2f437058d5eef2ac":
        level thread function_d11c9d1867a446e();
        break;
      case #"hash_eca3b9673d38fd59":
        level thread function_13e9f1f2d9fbaaa7();
        break;
      case #"hash_8c766d6477287bb6":
        level thread function_f3a1362748a0f178();
        break;
      case #"hash_74e2f521aa352a6a":
        level thread function_9c98f7610321b97c();
        break;
      case #"hash_bf2f9adbd2b41d5":
        level thread function_505d65754cd95dd3();
        break;
      case #"hash_b161e185f1b8e117":
        level thread function_6c28e59fa53da6a9();
        break;
      case #"hash_9e36e3bd3a9dd00d":
        break;
      case #"hash_b571a6187bf67f9e":
        level thread function_296d6fff205d6850();
        break;
    }

    wait 5;
  }
}

function function_cd85611542ee2f28() {
  level.var_7cc07d79930c61de = [];
  aliases = ["dx_cp_chem_ksre_lasw_uavsactivated", "dx_cp_chem_ksre_lasw_activateduav", "dx_cp_chem_ksre_lasw_uavonline"];
  level.var_7cc07d79930c61de["uav_deploy_com"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_ksre_lasw_activatinguav", "dx_cp_chem_ksre_lasw_uavsystemsactive"];
  level.var_7cc07d79930c61de["uav_deploy_noncom"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_ksre_lasw_beadviseduavisoffsta", "dx_cp_chem_ksre_lasw_bravo6uavsoffline"];
  level.var_7cc07d79930c61de["uav_expired"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_sendingmortarcoordin", 0.3, level, "dx_cp_chem_ksre_lasw_coordinatesconfirmed"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_requestingmortarteam", 0.3, level, "dx_cp_chem_ksre_lasw_mortarteamdispatched"];
  level.var_7cc07d79930c61de["mortar_used_heli_obj_com"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_watcherimsendingmort", 0.3, level, "dx_cp_chem_ksre_lasw_copystandbyforartill"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_requestingmortarstri", 0.3, level, "dx_cp_chem_ksre_lasw_solidcopymortarstrik"];
  level.var_7cc07d79930c61de["mortar_used_heli_obj_noncom"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_requestingmortars", 0.3, level, "dx_cp_chem_ksre_lasw_beadvisedjohnyoureda"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_mortarsincoming", 0.3, level, "dx_cp_chem_ksre_ghos_priceyoureintheblast"];
  level.var_7cc07d79930c61de["mortar_used_danger_close_com"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_mortarstrikeincoming", 0.3, level, "dx_cp_chem_ksre_lasw_moveoutoftheblastzon"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_mortarsinbound", 0.3, level, "dx_cp_chem_ksre_ghos_youredangerclosecapt"];
  level.var_7cc07d79930c61de["mortar_used_danger_close_noncom"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_bravotowatcherneedam", 0.3, level, "dx_cp_chem_ksre_lasw_copycallingmortarsta"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_watcherineedmortarsu", 0.3, level, "dx_cp_chem_ksre_lasw_copycleartheareasupp"];
  level.var_7cc07d79930c61de["mortar_used_general_com"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_bravo6requestingamor", 0.3, level, "dx_cp_chem_ksre_lasw_copystrikemortarread"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_bravo6requestingamor", 0.3, level, "dx_cp_chem_ksre_lasw_copyacquiredsendings"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_watchercoordinatesma", 0.3, level, "dx_cp_chem_ksre_lasw_copystrikemortarread"];
  level.var_7cc07d79930c61de["mortar_used_general_noncom"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_ksre_pric_launchingcruisemissi", "dx_cp_chem_ksre_pric_cruisemissileout"];
  level.var_7cc07d79930c61de["cruise_missile_deploy_com"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_ksre_pric_sendingcruisemissile", "dx_cp_chem_ksre_pric_targetissetfiringcru"];
  level.var_7cc07d79930c61de["cruise_missile_deploy_noncom"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_ksre_lasw_toocloseforcomfortjo", "dx_cp_chem_ksre_lasw_barelymissedwatchyou"];
  level.var_7cc07d79930c61de["cruise_missile_hit_danger_close"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_ksre_lasw_directhit", "dx_cp_chem_ksre_lasw_goodimpact"];
  level.var_7cc07d79930c61de["cruise_missile_hit_attack_heli"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_ksre_lasw_directhit", "dx_cp_chem_ksre_lasw_goodimpact"];
  level.var_7cc07d79930c61de["cruise_missile_hit_backup_heli"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_ksre_lasw_goodeffect", "dx_cp_chem_ksre_lasw_directhit", "dx_cp_chem_ksre_lasw_goodimpact"];
  level.var_7cc07d79930c61de["cruise_missile_hit_general"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_ksre_lasw_shotfoulnoimpact", "dx_cp_chem_ksre_lasw_noimpact"];
  level.var_7cc07d79930c61de["cruise_missile_hit_miss"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_markedtheheloforairs", 0.3, level, "dx_cp_chem_ksre_lasw_checkprepforfire"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_sendingairstrikecoor", 0.3, level, "dx_cp_chem_ksre_lasw_copybraceforimpact"];
  level.var_7cc07d79930c61de["airstrike_heli_obj_com"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_konnihelomarkedforpr", 0.3, level, "dx_cp_chem_ksre_lasw_copyyourmarkairstrik"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_watchersendingheloco", 0.3, level, "dx_cp_chem_ksre_lasw_confirmedhelomarkeds"];
  level.var_7cc07d79930c61de["airstrike_heli_obj_noncom"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_watchercallingforair", 0.3, level, "dx_cp_chem_ksre_lasw_copyairstrikestandby"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_watchermarkingtarget", 0.3, level, "dx_cp_chem_ksre_lasw_copyyourmark"];
  level.var_7cc07d79930c61de["airstrike_jltv_com"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_targetmarkedforairst", 0.3, level, "dx_cp_chem_ksre_lasw_copytargetacquired"];
  level.var_7cc07d79930c61de["airstrike_jltv_noncom"] = create_deck(aliases, 1, 1);
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_airstrikeinboundhot", 0.3, level, "dx_cp_chem_ksre_lasw_getoutoftheresix"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_airstrikecomingdange", 0.3, level, "dx_cp_chem_ksre_lasw_sixgettosafety"];
  level.var_7cc07d79930c61de["airstrike_danger_close_com"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_requestingimmediatea", 0.3, level, "dx_cp_chem_ksre_lasw_copybeadvisedyouared"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_callforfireonmycoord", 0.3, level, "dx_cp_chem_ksre_lasw_markconfirmedyoureda"];
  level.var_7cc07d79930c61de["airstrike_danger_close_noncom"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_theyvegotreinforceme", 0.3, level, "dx_cp_chem_ksre_lasw_copyairinboundforfir"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_callforfireonenemyre", 0.3, level, "dx_cp_chem_ksre_lasw_sendingfirestandbyfo"];
  level.var_7cc07d79930c61de["airstrike_backup_heli_com"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_needfireonthatenemyh", 0.3, level, "dx_cp_chem_ksre_lasw_copyfireairstrikeinb"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_markedprecisionairst", 0.3, level, "dx_cp_chem_ksre_lasw_rogercominginhotthei"];
  level.var_7cc07d79930c61de["airstrike_backup_heli_noncom"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_watcherrequestingfir", 0.3, level, "dx_cp_chem_ksre_lasw_copyyourmarksendingf"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_sixtowatchercallforf", 0.3, level, "dx_cp_chem_ksre_lasw_copyyourcallfireinbo"];
  level.var_7cc07d79930c61de["airstrike_general_com"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_bravo6towatchertarge", 0.3, level, "dx_cp_chem_ksre_lasw_copymarkacquiredairi"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_targetmarkedforfireh", 0.3, level, "dx_cp_chem_ksre_lasw_solidbravofireisinbo"];
  level.var_7cc07d79930c61de["airstrike_general_noncom"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_ksre_lasw_goodeffectontarget", "dx_cp_chem_ksre_lasw_goodhit", "dx_cp_chem_ksre_lasw_goodeffect_01", "dx_cp_chem_ksre_lasw_niceshot", "dx_cp_chem_ksre_lasw_thatlldoit", "dx_cp_chem_ksre_lasw_targetdown"];
  level.var_7cc07d79930c61de["airstrike_hit_general"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_ksre_lasw_multiplekonniakiasix", "dx_cp_chem_ksre_lasw_centercutgoodkill", "dx_cp_chem_ksre_lasw_goodeffectmultipleta"];
  level.var_7cc07d79930c61de["airstrike_hit_enemy_group"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_ksre_lasw_goodhitenemyhelodown", "dx_cp_chem_ksre_lasw_solidimpactonthehelo", "dx_cp_chem_ksre_lasw_impacthelodown"];
  level.var_7cc07d79930c61de["airstrike_hit_backup_heli"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_ksre_pric_shotoffnegativeimpac", "dx_cp_chem_ksre_pric_missnoimpact", "dx_cp_chem_ksre_pric_negativeimpactontarg"];
  level.var_7cc07d79930c61de["airstrike_hit_miss"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_ksre_pric_deployedsentry", "dx_cp_chem_ksre_pric_sentrydeployed"];
  level.var_7cc07d79930c61de["sentry_used_com"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_ksre_pric_deployingsentry", "dx_cp_chem_ksre_pric_placingsentry", "dx_cp_chem_ksre_pric_sentryset"];
  level.var_7cc07d79930c61de["sentry_used_noncom"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_locationmarkedforstr", 0.3, level, "dx_cp_chem_ksre_lasw_copyvtolinbound"];
  level.var_7cc07d79930c61de["vtol_used_general_com"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_markingstrikelocatio", 0.3, level, "dx_cp_chem_ksre_lasw_acquiredvtolinbound"];
  level.var_7cc07d79930c61de["vtol_used_general_noncom"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_helositemarked", 0.3, level, "dx_cp_chem_ksre_lasw_affirmsendingvtolnow"];
  level.var_7cc07d79930c61de["vtol_used_heli_obj_com"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_helositemarkedforvto", 0.3, level, "dx_cp_chem_ksre_lasw_targetacquiredvtolin"];
  level.var_7cc07d79930c61de["vtol_used_heli_obj_noncom"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_requestingvtolonmypo", 0.3, level, "dx_cp_chem_ksre_lasw_vtolinbounddangerclo"];
  level.var_7cc07d79930c61de["vtol_used_danger_close_com"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_callingvtolfireonmyp", 0.3, level, "dx_cp_chem_ksre_lasw_copyvtolinbounddange"];
  level.var_7cc07d79930c61de["vtol_used_danger_close_noncom"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_ksre_pilo_striker3approachingt", "dx_cp_chem_ksre_pilo_striker3clearedhoton"];
  level.var_7cc07d79930c61de["vtol_arrival"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_ksre_pilo_targetvisualstriker3", "dx_cp_chem_ksre_pilo_striker3shotsinbound"];
  level.var_7cc07d79930c61de["vtol_arrival_danger_close"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_needvtolonmyposition"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_callingvtolonmyposit", 0.5, level, "dx_cp_chem_ksre_pilo_striker3copiesretarg"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_markingvtolonmyposit"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_getvtolonmyposition"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_markingvtolonmyposit_01", 0.5, level, "dx_cp_chem_ksre_pilo_goodcopystriker3reta"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_requestingvtolonmypo_01"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_vtolcallforfireonmyp"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_movevtoltomyposition"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_requestingvtolonmypo_02"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_pushvtoltomyposition"];
  level.var_7cc07d79930c61de["vtol_update_pos"] = create_deck(aliases, 1);
  aliases = ["dx_cp_chem_ksre_pilo_striker3takingeffect", "dx_cp_chem_ksre_pilo_striker3takingincomi"];
  level.var_7cc07d79930c61de["vtol_damaged"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_ksre_pilo_striker3takingdamage", "dx_cp_chem_ksre_pilo_striker3bugginout"];
  level.var_7cc07d79930c61de["vtol_near_death"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_ksre_pilo_beadvisedstriker3isb", "dx_cp_chem_ksre_pilo_strikerisbingofuelli"];
  level.var_7cc07d79930c61de["vtol_low_fuel"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_ksre_pilo_striker3isrtbgoodluc", "dx_cp_chem_ksre_pilo_striker3isbingomovin"];
  level.var_7cc07d79930c61de["vtol_leaving"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_ksre_pilo_goodhitsmultiplehost"];
  level.var_7cc07d79930c61de["vtol_killing_guys"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_kius_pric_sendingoutarecondron", "dx_cp_chem_kius_pric_deployingrecondrone", "dx_cp_chem_kius_pric_gotarecondroneup"];
  level.var_7cc07d79930c61de["recon_used_noncom"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_kius_pric_tagging", "dx_cp_chem_kius_pric_taggingtargets", "dx_cp_chem_kius_pric_targetstagged", "dx_cp_chem_kius_pric_markingtargets", "dx_cp_chem_kius_pric_targetmarked", "dx_cp_chem_kius_pric_taggedone", "dx_cp_chem_kius_pric_markedone", "dx_cp_chem_kius_pric_tagged", "dx_cp_chem_kius_pric_marked"];
  level.var_7cc07d79930c61de["recon_player_tagging"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_kius_lasw_dronespickingupmorek", "dx_cp_chem_kius_lasw_dronesstilltaggingho", "dx_cp_chem_kius_ghos_dronesfindingmoreene"];
  level.var_7cc07d79930c61de["recon_auto_tagging_com"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_kius_lasw_recondronesstillfind", "dx_cp_chem_kius_lasw_recondronesstillupat", "dx_cp_chem_kius_lasw_bravo6recondronespic"];
  level.var_7cc07d79930c61de["recon_auto_tagging_noncom"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_kius_ghos_yourreconsspottedthe", "dx_cp_chem_kius_ghos_bravo6konnispottedth", "dx_cp_chem_kius_lasw_beadvisedkonniseesth", "dx_cp_chem_kius_lasw_enemyeyesonthatrecon"];
  level.var_7cc07d79930c61de["recon_spotted"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_ksre_lasw_sixrecondronesofflin", "dx_cp_chem_ksre_lasw_yourrecondronesoffli"];
  level.var_7cc07d79930c61de["recon_timeout"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_kius_lasw_recondronesdown", "dx_cp_chem_kius_lasw_theytookouttherecond", "dx_cp_chem_kius_lasw_ourrecondronesout"];
  level.var_7cc07d79930c61de["recon_destroyed"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_bravotowatchersendin", 0.3, level, "dx_cp_chem_ksre_lasw_copycoordinatesbombe"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_watcherbombercoordin", 0.3, level, "dx_cp_chem_ksre_lasw_checktargetacquiredb"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_sendingbombercoordin_01", 0.3, level, "dx_cp_chem_ksre_lasw_copycoordinatesbombe"];
  level.var_7cc07d79930c61de["stealth_bomber_used_com"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_requestingbombersend", 0.3, level, "dx_cp_chem_ksre_lasw_copybombruninbound"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_watchersendingbomber", 0.3, level, "dx_cp_chem_ksre_lasw_copythatyourecleared"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_callforbombruncoordi", 0.3, level, "dx_cp_chem_ksre_lasw_copygoodlockairisinb"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_sendingbombercoordin", 0.3, level, "dx_cp_chem_ksre_lasw_confirmedbomberdeplo"];
  level.var_7cc07d79930c61de["stealth_bomber_used_noncom"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_ksre_pric_sendingabombdrone", "dx_cp_chem_ksre_pric_bombdronedeployed", "dx_cp_chem_ksre_pric_deployingbombdrone"];
  level.var_7cc07d79930c61de["bomb_drone_used_com"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_ksre_pric_bombdronesdeployed", "dx_cp_chem_ksre_pric_usingbombdrone", "dx_cp_chem_ksre_pric_deployingbombdrone_01"];
  level.var_7cc07d79930c61de["bomb_drone_used_noncom"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_enemybirdmarkedwitha", 0.3, level, "dx_cp_chem_ksre_ghos_thatlldownit"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_deployingabombdroneo", 0.3, level, "dx_cp_chem_ksre_ghos_itlldroplikeastone"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_sentthebirdabombdron", 0.3, level, "dx_cp_chem_ksre_lasw_thatllbeallshewrote"];
  level.var_7cc07d79930c61de["bomb_drone_used_chopper_present_com"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_deployedabombdrone", 0.3, level, "dx_cp_chem_ksre_lasw_thatllbeallshewrote"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_sendingbombdroneatth", 0.3, level, "dx_cp_chem_ksre_ghos_cantflyouttathatone"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_deployingbombdroneat", 0.3, level, "dx_cp_chem_ksre_ghos_thatllmakeafierymess"];
  level.var_7cc07d79930c61de["bomb_drone_used_chopper_present_noncom"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_ksre_lasw_goodkill"];
  aliases[aliases.size] = [level, "dx_cp_chem_ksre_lasw_directhit"];
  aliases[aliases.size] = [level, "dx_cp_chem_ksre_lasw_goodimpact"];
  level.var_7cc07d79930c61de["bomb_drone_hit_general"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_ksre_lasw_multiplehostilesdown"];
  aliases[aliases.size] = [level, "dx_cp_chem_ksre_lasw_directkonnisquadsdow"];
  level.var_7cc07d79930c61de["bomb_drone_hit_enemy_group"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level, "dx_cp_chem_ksre_lasw_vehicledisabled"];
  aliases[aliases.size] = [level, "dx_cp_chem_ksre_lasw_jltvsdown"];
  level.var_7cc07d79930c61de["bomb_drone_hit_jltv"] = create_deck(aliases, 1, 1);
  aliases = [];
  level.var_7cc07d79930c61de["bomb_drone_hit_heli_obj"] = create_deck(aliases, 1, 1);
  aliases = [];
  level.var_7cc07d79930c61de["bomb_drone_hit_attack_heli"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_noeffectfromthedrone"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_foulnodronehit"];
  level.var_7cc07d79930c61de["bomb_drone_hit_miss"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_ksre_pric_samturretsetup", "dx_cp_chem_ksre_pric_samturretplaced", "dx_cp_chem_ksre_pric_samturretdeployed"];
  level.var_7cc07d79930c61de["sam_deployed_com"] = create_deck(aliases, 1, 1);
  aliases = ["dx_cp_chem_ksre_pric_settingthesamturret", "dx_cp_chem_ksre_pric_placingsamturret", "dx_cp_chem_ksre_pric_deployingsamturret"];
  level.var_7cc07d79930c61de["sam_deployed_noncom"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_samturretsactive", 0.3, level, "dx_cp_chem_ksre_ghos_itllneedaclearshoton"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_samturretsset", 0.3, level, "dx_cp_chem_ksre_ghos_shouldknockthatheloo"];
  level.var_7cc07d79930c61de["sam_deployed_chopper_present_com"] = create_deck(aliases, 1, 1);
  aliases = [];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_deployingsam", 0.3, level, "dx_cp_chem_ksre_lasw_shouldcutthatkonnihe"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_ksre_pric_plantingasam", 0.3, level, "dx_cp_chem_ksre_lasw_assaultheloshouldbea"];
  level.var_7cc07d79930c61de["sam_deployed_chopper_present_noncom"] = create_deck(aliases, 1, 1);
}

function function_e09196f444ff3525() {
  vo_alias = "uav_deploy";
  vo_alias += flag("player_in_combat") ? "_com" : "_noncom";
  level.player function_fc0eb6b81c66c661(1, level.var_7cc07d79930c61de[vo_alias] deck_draw(), 0.3, 5);
  wait 100;

  if(!function_94b00c0fad72704b([0, 1, 2, 4])) {
    return;
  }

  level.player function_fc0eb6b81c66c661(2, level.var_7cc07d79930c61de["uav_expired"] deck_draw(), 0.3, 10);
}

function function_d11c9d1867a446e() {
  marker = level.player.marker;
  strike_type = function_4e2492f851753d90("mortar", marker.origin);

  if(strike_type == "jltv" || strike_type == "enemy_group" || strike_type == "backup_heli" || strike_type == "attack_heli") {
    strike_type = "general";
  }

  vo_alias = "mortar_used_" + strike_type;
  vo_alias += flag("player_in_combat") ? "_com" : "_noncom";

  if(function_df523eb13cceb5d1(marker.origin)) {
    function_87d4c34bf8d7378b();
    return;
  }

  level.player function_c9a09b3ba9c68f8d(1, level.var_7cc07d79930c61de[vo_alias] deck_draw(), 0.3, 3);
}

function function_13e9f1f2d9fbaaa7() {
  vo_alias = "cruise_missile_deploy";
  vo_alias += flag("player_in_combat") ? "_com" : "_noncom";
  level.player function_fc0eb6b81c66c661(0.3, level.var_7cc07d79930c61de[vo_alias] deck_draw(), 0.3, 3);
  missile = function_70458a799cdafd70("cruise_predator");
  var_76bdcace464e027f = undefined;

  while(isalive(missile)) {
    var_76bdcace464e027f = missile.origin;
    var_311fd3cd291162eb = getaiarrayinradius(var_76bdcace464e027f, 500, "axis");

    if(isDefined(level.attack_heli)) {
      level.var_c3de397e1c1a91f2 = level.attack_heli.origin;
    }

    wait 0.1;
  }

  strike_type = function_4e2492f851753d90("cruise_missile", var_76bdcace464e027f, var_311fd3cd291162eb);

  if(strike_type == "jltv" || strike_type == "enemy_group" || strike_type == "backup_heli" || strike_type == "attack_heli" || strike_type == "heli_obj") {
    strike_type = "general";
  }

  vo_alias = "cruise_missile_hit_" + strike_type;

  if(!function_94b00c0fad72704b([0, 1, 2, 4])) {
    return;
  }

  if(function_df523eb13cceb5d1(var_76bdcace464e027f)) {
    function_87d4c34bf8d7378b();
    return;
  }

  level function_fc0eb6b81c66c661(1, level.var_7cc07d79930c61de[vo_alias] deck_draw(), 0.3, 5);
}

function function_f3a1362748a0f178() {
  strike = array_get_first_item(level.activeairstrikes);
  var_24f84966db0a76fa = strike.origin;
  strike_type = function_4e2492f851753d90("airstrike", var_24f84966db0a76fa);
  vo_alias = "airstrike_" + strike_type;
  vo_alias += flag("player_in_combat") ? "_com" : "_noncom";
  level.player function_c9a09b3ba9c68f8d(0.6, level.var_7cc07d79930c61de[vo_alias] deck_draw(), 0.3, 3);
  level thread function_782be07687532f1a();
}

function function_782be07687532f1a() {
  while(!isDefined(level.var_e4d9fc637e9f7d6b)) {
    waitframe();
  }

  foreach(airstrike in level.activeairstrikes) {
    var_7865ff67fa930327 = airstrike;
  }

  var_bca6e3f140f1bfbc = var_7865ff67fa930327.origin;
  var_eba706f0cafa7b35 = level.var_9df79069dfd8549b;
  streakinfo = level.var_e4d9fc637e9f7d6b;

  while(level.var_e4d9fc637e9f7d6b.shots_fired < 40) {
    waitframe();
  }

  heli_destroyed = is_equal(var_eba706f0cafa7b35, level.var_9df79069dfd8549b) ? 0 : 1;

  if(heli_destroyed) {
    return;
  }

  if(streakinfo.kills > 2) {
    strike_type = "enemy_group";
  } else if(streakinfo.kills > 0) {
    strike_type = "general";
  } else {
    strike_type = "miss";
  }

  vo_alias = "airstrike_hit_" + strike_type;
  wait 0.5;

  if(!function_94b00c0fad72704b([0, 1, 2, 4])) {
    return;
  }

  if(function_df523eb13cceb5d1(var_bca6e3f140f1bfbc)) {
    function_87d4c34bf8d7378b();
    return;
  }

  level.player function_c9a09b3ba9c68f8d(1, level.var_7cc07d79930c61de[vo_alias] deck_draw(), 0.3, 3);
}

function function_df523eb13cceb5d1(org) {
  if(flag("flag_reactor_warning_played")) {
    return 0;
  }

  if(isDefined(level.attack_heli)) {
    return 0;
  }

  reactor_exterior_trig = function_1c4d592029f2b0d3("reactor_exterior_trig");
  return reactor_exterior_trig istouchingpoint(org);
}

function function_87d4c34bf8d7378b() {
  flag_set("flag_reactor_warning_played");
  sequence = [level, "dx_cp_chem_flre_lasw_watchthereactorbravo", 0.3, level.player, "dx_cp_chem_flre_pric_goodadvicelaswell"];
  level.player function_c9a09b3ba9c68f8d(1, sequence, 0.3, 3, undefined, 2);
}

function function_9c98f7610321b97c() {
  vo_alias = "sentry_used";
  vo_alias += flag("player_in_combat") ? "_com" : "_noncom";
  level.player function_fc0eb6b81c66c661(0.6, level.var_7cc07d79930c61de[vo_alias] deck_draw(), 0.3, 5);
}

function function_505d65754cd95dd3() {
  hover_jet = function_70458a799cdafd70("hover_jet");
  var_24f84966db0a76fa = hover_jet.returngoal;
  strike_type = function_6208dbd0dd4f0022(var_24f84966db0a76fa);
  vo_alias = "vtol_used_" + strike_type;
  vo_alias += flag("player_in_combat") ? "_com" : "_noncom";
  level.player function_c9a09b3ba9c68f8d(0.6, level.var_7cc07d79930c61de[vo_alias] deck_draw(), 0.3, 3);
  level thread function_f15ce3219bf5b2f1(hover_jet);
  level thread function_90fd4466a893495e(hover_jet);
  level thread function_a6ea421b6991b473(hover_jet);
  level thread function_56493a29c594ddc0(hover_jet);
  wait 2;
  vo_alias = "vtol_arrival";

  if(distance(level.player.origin, var_24f84966db0a76fa) < 500) {
    vo_alias += "_danger_close";
  }

  level function_fc0eb6b81c66c661(0.6, level.var_7cc07d79930c61de[vo_alias] deck_draw(), 0.3, 5);
}

function function_56493a29c594ddc0(hover_jet) {
  hover_jet endon("death");
  var_65125353841f5aee = 0;

  while(true) {
    wait 8;
    total_kills = hover_jet.streakinfo.kills;
    var_99d08dfaf02b4f64 = total_kills - var_65125353841f5aee;

    if(var_99d08dfaf02b4f64 <= 2) {
      var_65125353841f5aee = total_kills;
      continue;
    }

    if(!function_94b00c0fad72704b([0, 1, 2, 4])) {
      continue;
    }

    level function_fc0eb6b81c66c661(0.6, level.var_7cc07d79930c61de["vtol_killing_guys"] deck_draw(), 0.3, 5);
    break;
  }
}

function function_f15ce3219bf5b2f1(hover_jet) {
  hover_jet endon("death");
  var_c5941ea4deca8787 = hover_jet.maxhealth * 0.5;
  var_751d236797ba2285 = hover_jet.maxhealth * 0.05;

  while(true) {
    if(hover_jet.currenthealth < var_c5941ea4deca8787) {
      break;
    }

    wait 0.25;
  }

  if(!function_94b00c0fad72704b([0, 1, 2, 4])) {
    return;
  }

  level function_fc0eb6b81c66c661(0.6, level.var_7cc07d79930c61de["vtol_damaged"] deck_draw(), 0.3, 5);

  while(true) {
    if(hover_jet.currenthealth < var_751d236797ba2285) {
      break;
    }

    wait 0.25;
  }

  if(!function_94b00c0fad72704b([0, 1, 2, 4])) {
    return;
  }

  level function_fc0eb6b81c66c661(0.6, level.var_7cc07d79930c61de["vtol_near_death"] deck_draw(), 0.3, 5);
}

function function_90fd4466a893495e(hover_jet) {
  hover_jet endon("death");

  while(!isDefined(hover_jet.useobj)) {
    wait 0.25;
  }

  while(true) {
    hover_jet.useobj waittill("trigger", player);

    if(!function_94b00c0fad72704b([0, 1, 2, 4])) {
      return;
    }

    level function_c9a09b3ba9c68f8d(1, level.var_7cc07d79930c61de["vtol_update_pos"] deck_draw(), 0.3, 3);
    wait 15;
  }
}

function function_a6ea421b6991b473(hover_jet) {
  hover_jet endon("death");
  wait 45;

  if(!function_94b00c0fad72704b([0, 1, 2, 4])) {
    return;
  }

  level.player function_c9a09b3ba9c68f8d(1, level.var_7cc07d79930c61de["vtol_low_fuel"] deck_draw(), 0.3, 5);
  hover_jet waittill("leaving");

  if(!function_94b00c0fad72704b([0, 1, 2, 4])) {
    return;
  }

  level.player function_c9a09b3ba9c68f8d(1, level.var_7cc07d79930c61de["vtol_leaving"] deck_draw(), 0.3, 6);
}

function function_f754b2e07106fd83() {
  level.player endon("death");

  while(true) {
    level.player waittill("droneStart");

    if(!function_94b00c0fad72704b([0, 1, 2, 4])) {
      continue;
    }

    if(!flag("player_in_combat")) {
      level.player function_fc0eb6b81c66c661(0.6, level.var_7cc07d79930c61de["recon_used_noncom"] deck_draw(), 0.3, 3);
    }

    recon_drone = function_70458a799cdafd70("radar_drone_recon");
    level thread function_5305e6320d79c835(recon_drone);
    level thread function_35371ce53ad6213(recon_drone);
    level thread function_7609843a8b4b685d(recon_drone);
    level thread function_6baa13dfef2a786b(recon_drone);
  }
}

function function_5305e6320d79c835(recon_drone) {
  recon_drone endon("death");
  recon_drone endon("switch_modes");
  level.player endon("death");
  var_1bd1f1267f6d95f = randomintrange(2, 3);
  var_51cee34b6b29329f = 0;

  while(true) {
    level.player waittill("marked_target");
    var_51cee34b6b29329f++;

    if(var_51cee34b6b29329f >= var_1bd1f1267f6d95f) {
      if(!function_94b00c0fad72704b([0, 1, 2, 4])) {
        return;
      }

      level.player function_fc0eb6b81c66c661(0.6, level.var_7cc07d79930c61de["recon_player_tagging"] deck_draw(), 0.3, 3);
      return;
    }
  }
}

function function_35371ce53ad6213(recon_drone) {
  recon_drone endon("death");
  recon_drone waittill("switch_modes");

  while(true) {
    recon_drone waittill("marked_target");
    vo_alias = "recon_auto_tagging";
    vo_alias += flag("player_in_combat") ? "_com" : "_noncom";
    level function_fc0eb6b81c66c661(0.6, level.var_7cc07d79930c61de[vo_alias] deck_draw(), 0.3, 3);
    wait 15;
  }
}

function function_7609843a8b4b685d(recon_drone) {
  recon_drone waittill("explode");
  vo_alias = "recon_timeout";

  if(recon_drone.currenthealth > 0) {
    vo_alias = "recon_destroyed";
  }

  if(!function_94b00c0fad72704b([0, 1, 2, 4])) {
    return;
  }

  level.player function_fc0eb6b81c66c661(1, level.var_7cc07d79930c61de[vo_alias] deck_draw(), 0.3, 3);
}

function function_6baa13dfef2a786b(recon_drone) {
  recon_drone endon("death");

  if(flag("stealth_spotted")) {
    return;
  }

  flag_wait("stealth_spotted");
  wait 0.5;
  all_enemies = function_f1868d2eb5549576();
  var_4b1e213fa6ed9fd7 = 0;

  foreach(guy in all_enemies) {
    if(!isDefined(guy) || !isalive(guy)) {
      continue;
    }

    if(is_equal(guy.enemy, recon_drone)) {
      var_4b1e213fa6ed9fd7 = 1;
      break;
    }
  }

  if(!function_94b00c0fad72704b([0, 1, 2, 4])) {
    return;
  }

  level.var_cc09b483eec76e95 = gettime();
  level.player function_fc0eb6b81c66c661(1, level.var_7cc07d79930c61de["recon_spotted"] deck_draw(), 0.3, 3);
}

function function_6c28e59fa53da6a9() {
  vo_alias = "stealth_bomber_used";
  vo_alias += flag("player_in_combat") ? "_com" : "_noncom";
  level.player function_c9a09b3ba9c68f8d(0.6, level.var_7cc07d79930c61de[vo_alias] deck_draw(), 0.3, 3);
}

function function_2bffdb16381e779f() {
  while(true) {
    level.player waittill("assault_drone_deployed");

    if(!function_94b00c0fad72704b([0, 1, 2, 4])) {
      continue;
    }

    vo_alias = "bomb_drone_used";

    if(isDefined(level.attack_heli)) {
      vo_alias += "_chopper_present";
    }

    vo_alias += flag("player_in_combat") ? "_com" : "_noncom";
    level.player thread function_c9a09b3ba9c68f8d(0.6, level.var_7cc07d79930c61de[vo_alias] deck_draw(), 0.3, 3);
    assault_drone = function_70458a799cdafd70("assault_drone");
    thread function_554b7e68ba002117(assault_drone);
    var_1739386de81e3009 = undefined;
    var_849c8556cd72d410 = [];
    level.var_1a4bc17973e89ce8 = [];

    while(isalive(assault_drone)) {
      var_1739386de81e3009 = assault_drone.origin;
      nearby_ai = getaiarrayinradius(var_1739386de81e3009, 800, "axis");
      var_c5a8e46024d29cd3 = array_exclude(nearby_ai, var_849c8556cd72d410);
      array_thread(var_c5a8e46024d29cd3, &function_8f006abdecf8a4a7);
      var_849c8556cd72d410 = array_combine(var_849c8556cd72d410, var_c5a8e46024d29cd3);

      if(isDefined(level.attack_heli)) {
        level.var_c3de397e1c1a91f2 = level.attack_heli.origin;
      }

      wait 0.25;
    }

    level thread notify_delay("kill_bomb_drone_trackers", 1);
    wait 0.1;

    if(flag("flag_bomb_drone_early_exit")) {
      flag_clear("flag_bomb_drone_early_exit");
      continue;
    }

    strike_type = function_4e2492f851753d90("assault_drone", var_1739386de81e3009, level.var_1a4bc17973e89ce8);

    if(is_equal(strike_type, "attack_heli") || is_equal(strike_type, "heli_obj")) {
      continue;
    }

    vo_alias = "bomb_drone_hit_" + strike_type;

    if(!function_94b00c0fad72704b([0, 1, 2, 4])) {
      continue;
    }

    if(function_df523eb13cceb5d1(var_1739386de81e3009)) {
      function_87d4c34bf8d7378b();
      continue;
    }

    level function_c9a09b3ba9c68f8d(0.6, level.var_7cc07d79930c61de[vo_alias] deck_draw(), 0.3, 3);
  }
}

function function_554b7e68ba002117(assault_drone) {
  level endon("kill_bomb_drone_trackers");
  assault_drone waittill("killstreakExit");
  flag_set("flag_bomb_drone_early_exit");
}

function function_8f006abdecf8a4a7() {
  level endon("game_ended");
  level endon("kill_bomb_drone_trackers");
  self waittill("death");
  level.var_1a4bc17973e89ce8[level.var_1a4bc17973e89ce8.size] = self;
}

function function_70458a799cdafd70(vehicle_name) {
  while(!isDefined(level.vehicle.instances[vehicle_name]) || level.vehicle.instances[vehicle_name].size == 0) {
    wait 0.1;
  }

  foreach(vehicle in level.vehicle.instances[vehicle_name]) {
    if(isDefined(vehicle)) {
      return vehicle;
    }
  }
}

function function_296d6fff205d6850() {
  vo_alias = "sam_deployed";

  if(isDefined(level.attack_heli)) {
    vo_alias += "_chopper_present";
  }

  vo_alias += flag("player_in_combat") ? "_com" : "_noncom";
  level.player function_c9a09b3ba9c68f8d(0.6, level.var_7cc07d79930c61de[vo_alias] deck_draw(), 0.3, 3);
}

function function_6208dbd0dd4f0022(loc) {
  var_c4afa5940ac6f43a = "general";

  if(function_5bf73cda3f08c009(loc)) {
    var_c4afa5940ac6f43a = "heli_obj";
  } else if(function_1bff28a32ce93a88(loc)) {
    var_c4afa5940ac6f43a = "attack_heli";
  } else if(function_ff2f863ca92fb528(loc)) {
    var_c4afa5940ac6f43a = "danger_close";
  }

  return var_c4afa5940ac6f43a;
}

function function_4e2492f851753d90(killstreak_type, loc, var_311fd3cd291162eb) {
  var_b97164b1c9c58997 = [];

  switch (killstreak_type) {
    case #"hash_9e36e3bd3a9dd00d":
      var_b97164b1c9c58997 = ["attack_heli", "heli_obj", "jltv", "enemy_group", "miss"];
      break;
    case #"hash_ffc06812dd13691d":
      var_b97164b1c9c58997 = ["danger_close", "jltv", "backup_heli"];
      break;
    case #"hash_3c18ef21854dddc":
      var_b97164b1c9c58997 = ["heli_obj", "danger_close"];
      break;
    case #"hash_eca3b9673d38fd59":
      var_b97164b1c9c58997 = ["miss", "danger_close", "attack_heli", "backup_heli", "heli_obj"];
      break;
  }

  var_c4afa5940ac6f43a = "general";

  if(array_contains(var_b97164b1c9c58997, "heli_obj") && function_5bf73cda3f08c009(loc)) {
    var_c4afa5940ac6f43a = "heli_obj";
  } else if(array_contains(var_b97164b1c9c58997, "attack_heli") && function_1bff28a32ce93a88(loc)) {
    var_c4afa5940ac6f43a = "attack_heli";
  } else if(array_contains(var_b97164b1c9c58997, "backup_heli") && function_4c7314e06ba5836e(loc)) {
    var_c4afa5940ac6f43a = "backup_heli";
  } else if(array_contains(var_b97164b1c9c58997, "jltv") && function_81000198eb5c49dd(loc)) {
    var_c4afa5940ac6f43a = "jltv";
  } else if(array_contains(var_b97164b1c9c58997, "enemy_group") && (function_3a0c006ab5c4c6be(loc) || isDefined(var_311fd3cd291162eb) && var_311fd3cd291162eb.size > 1)) {
    var_c4afa5940ac6f43a = "enemy_group";
  } else if(array_contains(var_b97164b1c9c58997, "miss") && !function_f0f195c88a03c505(loc) && isDefined(var_311fd3cd291162eb) && var_311fd3cd291162eb.size == 0) {
    var_c4afa5940ac6f43a = "miss";
  } else if(array_contains(var_b97164b1c9c58997, "danger_close") && function_ff2f863ca92fb528(loc)) {
    var_c4afa5940ac6f43a = "danger_close";
  }

  return var_c4afa5940ac6f43a;
}

function function_5bf73cda3f08c009(loc) {
  var_35f9331c8292838d = function_399c5377091d2b15(loc);
  var_bc91a741e32d9498 = 900;
  return function_b2b8382a326374c1(loc, var_35f9331c8292838d, var_bc91a741e32d9498);
}

function function_1bff28a32ce93a88(loc) {
  if(!isDefined(level.var_c3de397e1c1a91f2)) {
    return 0;
  }

  var_4016ef6171ee0e04 = 600;
  return function_b2b8382a326374c1(loc, level.var_c3de397e1c1a91f2, var_4016ef6171ee0e04);
}

function function_4c7314e06ba5836e(loc) {
  if(!isDefined(level.var_d32fa90e4929570d)) {
    return 0;
  }

  level.var_d32fa90e4929570d = array_removeundefined(level.var_d32fa90e4929570d);

  if(level.var_d32fa90e4929570d.size == 0) {
    return 0;
  }

  var_35f9331c8292838d = getclosest(loc, level.var_d32fa90e4929570d);
  var_8055439a76834c92 = 500;
  return function_b2b8382a326374c1(loc, var_35f9331c8292838d.origin, var_8055439a76834c92);
}

function function_81000198eb5c49dd(loc) {
  if(!isDefined(level.var_66a1156521ee6dea)) {
    return 0;
  }

  level.var_66a1156521ee6dea = array_removeundefined(level.var_66a1156521ee6dea);

  if(level.var_66a1156521ee6dea.size == 0) {
    return 0;
  }

  var_1424ab4d53e59b01 = getclosest(loc, level.var_66a1156521ee6dea);
  var_7e783daa7521868f = 500;
  return function_b2b8382a326374c1(loc, var_1424ab4d53e59b01.origin, var_7e783daa7521868f);
}

function function_ff2f863ca92fb528(loc) {
  var_918aa16b94851ab4 = 500;
  return function_b2b8382a326374c1(loc, level.player.origin, var_918aa16b94851ab4);
}

function function_3a0c006ab5c4c6be(loc) {
  var_57bdc7a8160233da = 500;
  var_52f2a80cd22c97d1 = 3;
  enemies = getaiarrayinradius(loc, var_57bdc7a8160233da, "axis");
  return enemies.size >= var_52f2a80cd22c97d1;
}

function function_f0f195c88a03c505(loc) {
  var_f8847f2a13b16771 = 300;
  enemies = getaiarrayinradius(loc, var_f8847f2a13b16771, "axis");
  return enemies.size > 0;
}

function function_b2b8382a326374c1(org1, org2, comp_dist) {
  dist = distance(org1, org2);

  if(dist < comp_dist) {
    return true;
  }

  return false;
}

function function_70386f0dbf01d6f4(combat, noncombat) {
  return function_1445c12552b674d4() ? combat : noncombat;
}

function function_cd70fbc5ff85bc7d(var_b3d9068a7f08a7d7, var_10ce425f218389f8) {
  return function_1445c12552b674d4() ? var_b3d9068a7f08a7d7 deck_draw() : var_10ce425f218389f8 deck_draw();
}

function function_2f0b07d52498f339() {
  if(flag("flag_reactor_room_entered")) {
    return;
  }

  level endon("flag_reactor_room_entered");
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_aitt_lasw_yourecompromised";
  aliases[aliases.size] = "dx_cp_chem_aitt_lasw_theyseeyou";
  aliases[aliases.size] = "dx_cp_chem_aitt_lasw_youreintheirsightssi";
  aliases[aliases.size] = "dx_cp_chem_aitt_lasw_yourespottedjohn";
  aliases[aliases.size] = "dx_cp_chem_aitt_ghos_konnisspottedyou";
  aliases[aliases.size] = "dx_cp_chem_aitt_lasw_johnkonnisspottedyou";
  level.vo.stealth_spotted = create_deck(aliases, undefined, 1);
  aliases = [];
  aliases[aliases.size] = ["dx_cp_chem_aitt_lasw_youreclearcaptain", level, 0.6, "dx_cp_chem_aist_ghos_beadvisedkonnisregro"];
  aliases[aliases.size] = ["dx_cp_chem_aitt_lasw_youreintheclear"];
  aliases[aliases.size] = ["dx_cp_chem_aitt_lasw_noimmediatethreatsyo"];
  aliases[aliases.size] = "dx_cp_chem_aitt_lasw_areasclearpricenomov";
  aliases[aliases.size] = [level.player, "dx_cp_chem_aitt_pric_watcheramiclear", level, 0.4, "dx_cp_chem_aitt_lasw_affirmative"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_aitt_pric_amicleartomove", level, 0.4, "dx_cp_chem_aitt_lasw_affirmativenoactivit"];
  aliases[aliases.size] = [level.player, "dx_cp_chem_aitt_pric_ineedeyeskategimmeas", level, 0.4, "dx_cp_chem_aitt_lasw_nothreatscaptain"];
  level.vo.stealth_hidden = create_deck(aliases, undefined, 1);
  aliases = [];
  aliases[aliases.size] = "dx_cp_chem_aitt_lasw_theyrehuntingyousix";
  aliases[aliases.size] = "dx_cp_chem_aitt_lasw_carefultheyrelooking";
  aliases[aliases.size] = "dx_cp_chem_aitt_lasw_theyresearchingstayl";
  aliases[aliases.size] = "dx_cp_chem_aitt_lasw_stayquietcaptainthey";
  level.vo.var_70c8de0ec71d48cd = create_deck(aliases, undefined, 1);
  var_7b08121aa6393804 = 0;

  for(;;) {
    function_d307f2590e3f9841([3, 1, 0, 4], undefined, undefined, undefined, undefined, undefined, "stealth_spotted");

    if(!function_d2b3639a2dfd8631(2)) {} else if(function_420eabbbd2a0303d()) {
      lines = level.vo.stealth_spotted deck_draw();
      result = level function_c9a09b3ba9c68f8d([ &function_d2b3639a2dfd8631, 1], lines, 0.8, 5);
      jumpiffalse(isDefined(result) && !result && !flag("stealth_spotted")) LOC_00000284;
    } else {
      LOC_00000284: while(flag("stealth_spotted")) {
        flag_waitopen("stealth_spotted");
        wait 3;
      }

      if(function_94b00c0fad72704b([3, 1, 0, 4], undefined, 5, 900)) {
        if(time_has_passed(level.last_kill_vo, 5) && time_has_passed(level.var_37d4ce8c2aa043ce, 15)) {
          lines = level.vo.stealth_hidden deck_draw();
          level function_c9a09b3ba9c68f8d([ &function_88b43677e2d36760, 2], lines, 0.8, 10);
          level.var_37d4ce8c2aa043ce = gettime();
          wait 10;
        }
      }

      if(!istrue(var_7b08121aa6393804) && function_94b00c0fad72704b([3, 1, 0, 4], undefined, undefined, 900)) {
        wait 10;
        lines = level.vo.var_70c8de0ec71d48cd deck_draw();
        var_7b08121aa6393804 = level function_c9a09b3ba9c68f8d([ &function_88b43677e2d36760, 1], lines, 0.8, 5);
        var_7b08121aa6393804 = 1;

        iprintlnbold("<dev string:x2aa>");

        wait 15;
      }

      flag_waitopen("stealth_spotted");
    }

    waitframe();
  }
}

function function_420eabbbd2a0303d() {
  if(isDefined(level.last_kill_vo) && !time_has_passed(level.last_kill_vo, 2)) {
    return false;
  }

  if(isDefined(level.var_cc09b483eec76e95) && !time_has_passed(level.var_cc09b483eec76e95, 10)) {
    return false;
  }

  if(!time_has_passed(level.player.var_e175e10a9ce88d03, 5)) {
    return false;
  }

  return true;
}

function function_88b43677e2d36760(delay) {
  wait delay;
  return function_eac0cd99c9c6d8ee() == "hidden";
}

function function_d2b3639a2dfd8631(delay) {
  wait delay;
  return function_eac0cd99c9c6d8ee() == "spotted";
}

function function_de2b75ec1f0ced2b() {}

function function_c2a86f682bf1ab71() {
  level.objectives_table = "cp/cp_jup_chemical_objectives.csv";
  level.objectivesmatrixtable = "cp/cp_jup_chemical_objectives_matrix.csv";
  level.objectiveregistration = &function_77765e5dd4c9db54;
  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

function function_77765e5dd4c9db54() {
  level endon("game_ended");
  flag_wait("level_ready_for_script");

  if(getdvarint(@ "hash_a4bce2e4bbe58448", 0) >= 1) {
    scripts\cp\cp_objectives::function_b46922280aa2802c("obj_reconArea", "Examine the Radioactive Site", "primary", "Chemical", undefined, undefined, undefined, undefined, 3);
    scripts\cp\cp_objectives::function_b46922280aa2802c("obj_enterReactor", "Find the Reactor Room", "primary", "Chemical", undefined, undefined, undefined, undefined, 1);
    scripts\cp\cp_objectives::function_b46922280aa2802c("obj_chemicals", "Disrupt the Konni airlift", "primary", "Chemical", undefined, undefined, undefined, undefined, 1);
    scripts\cp\cp_objectives::function_b46922280aa2802c("obj_escape", "Survive", "primary", "Chemical", undefined, undefined, undefined, undefined, 1);
  }

  thread registerobjective("obj_reconArea", undefined, &function_16b78e4d137ed198);
  thread registerobjective("obj_enterReactor", undefined, &function_13159dc58fd2a38c);
  thread registerobjective("obj_chemicals", undefined, &function_dea83d4dcc138efb);
  thread registerobjective("obj_escape", undefined, &function_647924edc2b5209b);
  scripts\cp\cp_checkpoint::function_d37e0c86fbcf710b("obj_reconArea", "obj_reconArea_complete", &function_5a40970a06b9b41e);
  scripts\cp\cp_checkpoint::function_d37e0c86fbcf710b("obj_enterReactor", "obj_enterReactor_complete", &function_37c816f8a71704c2);
  namespace_9d6ed0911e2ddf09::reserve_objectiveid([0, 1, 2, 3, 4]);
}

function obj_flow() {
  level thread function_c6f71cb8ac28f79e();
  level thread obj_chemicals();
  level thread obj_escape();
  level thread function_c5f1c920bda0c382();
  level thread circle_waterpump();
}

function function_16b78e4d137ed198(objectivestruct, var_5dcdfd3a4eff9961) {
  level thread function_bdfb627dddf62692(objectivestruct, var_5dcdfd3a4eff9961);
}

function function_5a40970a06b9b41e() {
  if(istrue(level.var_1369e1e96a31be5e)) {
    return;
  }

  if(level.checkpoint != "obj_reconArea_complete") {
    return;
  }

  utility::flag_set("flag_obj_all_helis_killed");
  level notify("all_helis_killed");
  level thread function_26e3032a96ab06eb();
  level thread function_3b653fc3568d4150();
  level thread function_f1b101a8413b3c69();
  level thread function_e92aa26a36ca25fb();
  level thread function_9df0d68419bf4e66();
  thread function_bc8cd86342f9a544();
  level.var_f8c5ab19e120757d = 1;
  level flag_wait("flag_reactor_airlock_passed");
  function_446a0ab3bcf9e922();
  function_17006546f61dd733();
  function_cce1ca1325cccbe4();
}

function function_13159dc58fd2a38c(objectivestruct, var_5dcdfd3a4eff9961) {
  level thread function_dd0367751dfd91e7(objectivestruct, var_5dcdfd3a4eff9961);
}

function function_37c816f8a71704c2() {
  if(istrue(level.var_1369e1e96a31be5e)) {
    return;
  }

  if(level.checkpoint != "obj_enterReactor_complete") {
    return;
  }

  thread namespace_11fae4a66a43bd3f::function_2292dd2ddbf9a14e();
  utility::flag_set("flag_obj_all_helis_killed");
  level notify("all_helis_killed");
  level flag_set("flag_power_plant_entered");
  level flag_wait("flag_reactor_airlock_passed");
  level.var_f588d5e1542dfb14 notify("flag_reactor_entered");
  level.var_f8c5ab19e120757d = 1;
  function_446a0ab3bcf9e922();
  function_17006546f61dd733();
  function_cce1ca1325cccbe4();
}

function function_dea83d4dcc138efb(objectivestruct, var_5dcdfd3a4eff9961) {
  thread namespace_11fae4a66a43bd3f::function_588af84fad23df23("cp_jup_chemical_sfx_reactor");
  level flag_wait("flag_reactor_airlock_passed");
  waitframe();
  function_bb5cab9eba6beb39();

  while(!isDefined(level.var_b6dc558c136879dc)) {
    waitframe();
  }

  objectiveent = level.var_b6dc558c136879dc;
  objectiveloc = objectiveent.origin;
  objindex = namespace_1170726b2799ea65::function_f60f3ac2fb2776f7(objectivestruct, "icon_waypoint_objective_general", "icon_medium", objectiveloc, "current", undefined, undefined, undefined, 1, 1);
  objective_onentity(objindex, objectiveent);
  objective_setzoffset(objindex, 50);
  waitframe();
  level flag_wait("flag_obj_chemicals_completed");
  namespace_1170726b2799ea65::function_448adabb169120d7(objectivestruct);
}

function function_647924edc2b5209b(objectivestruct, var_5dcdfd3a4eff9961) {
  level flag_wait("flag_marker_on_exit_ascender");
  objectiveloc = function_7a18da6e48b71c35("exfil_interact").origin + (0, 0, 10);
  objindex = namespace_1170726b2799ea65::function_f60f3ac2fb2776f7(objectivestruct, "icon_waypoint_objective_general", "icon_medium", objectiveloc, "current", undefined, undefined, undefined, 1, 1);
  waitframe();
  level flag_wait("flag_exit_interacted");
  namespace_1170726b2799ea65::function_448adabb169120d7(objectivestruct);
}

function function_c6f71cb8ac28f79e() {
  level endon("game_ended");
  level.player endon("death");
  level thread function_23fcb4dea4bf9e75();
  level flag_wait("flag_obj_reconArea_start");

  if(level.checkpoint != "obj_enterReactor_complete") {
    objstruct = level.objectivestabledata["obj_reconArea"];
    initializeobjective(objstruct, "obj_reconArea", "primary");
    level thread startobjective(objstruct, "obj_reconArea", "primary");
    utility::objective_update("obj_reconArea", undefined, undefined, undefined, undefined, 0);
    level thread function_d2d5329aa836f9a5();
    flag_wait("flag_obj_all_helis_killed");
    completeobjective(objstruct, "obj_reconArea", "primary");
  }

  if(!level.checkpoint_reached) {
    thread function_3806da7a792f85bc("obj_reconArea_complete");
  }

  level thread function_7ed8fe8535327e4();
  function_bc8cd86342f9a544();
}

function function_23fcb4dea4bf9e75() {
  function_665d474ff040b446(["flag_heli_damaged_any_1", "flag_heli_damaged_any_2", "flag_heli_damaged_any_3"]);
  flag_set("flag_obj_reconArea_start");
}

function function_bc8cd86342f9a544() {
  if(flag("flag_powerplant_flow_start")) {
    return;
  }

  level flag_set("flag_powerplant_flow_start");

  if(level.checkpoint == "obj_enterReactor_complete") {
    level.var_9f966ce33c2acf74["obj_enterReactor"]["obj_enterReactor_complete"].isvalid = 1;
    thread function_37c816f8a71704c2();
  }

  objstruct = level.objectivestabledata["obj_enterReactor"];
  initializeobjective(objstruct, "obj_enterReactor", "primary");
  level thread startobjective(objstruct, "obj_enterReactor", "primary");
  level flag_wait("flag_reactor_airlock_passed");
  level.var_f588d5e1542dfb14 notify("flag_reactor_entered");
  level flag_wait("flag_reactor_room_entered");
  completeobjective(objstruct, "obj_enterReactor", "primary");
}

function function_3806da7a792f85bc(checkpoint) {
  level endon("game_ended");
  level.player endon("death");
  level endon("reactor_door_entered");

  while(true) {
    while(!function_d35d9c0a5b4e48fa()) {
      waitframe();
    }

    wait 1;

    if(function_d35d9c0a5b4e48fa()) {
      break;
    }
  }

  scripts\cp\cp_checkpoint::checkpoint_set(checkpoint);
  var_aadfe6e88e01f5f1 = getEnt("player_checkpoint_spawn_exclusion", "targetname");
  var_4401252c81fda384 = getEnt("player_checkpoint_spawn_exclusion_dos", "targetname");

  if(level.player istouching(var_aadfe6e88e01f5f1) || level.player istouching(var_4401252c81fda384)) {
    function_cae43eb8554a11a(checkpoint);
  } else {
    scripts\cp\cp_checkpoint::function_5b0a03741aa420d7();
  }

  if(flag("flag_attack_heli_destroyed")) {
    level.player function_a9652366b0728328(0, 1);
    return;
  }

  level.player function_a9652366b0728328(1, 1);
}

function function_d35d9c0a5b4e48fa() {
  return (level.player isonground() || isDefined(level.player.vehicle)) && !scripts\cp\cp_outofbounds::isoob(level.player);
}

function function_cae43eb8554a11a(checkpoint) {
  spawn_array = getStructArray("checkpoint_start", "script_noteworthy");
  var_bf0dfaab453893d0 = sortbydistance(spawn_array, level.player.origin)[0];

  if(isDefined(var_bf0dfaab453893d0)) {
    level.player namespace_1170726b2799ea65::function_5de16de5f3a1776f(level.script, checkpoint, int(scripts\cp\cp_gameskill::get_gameskill()), level.player isnightvisionon(), var_bf0dfaab453893d0.origin, var_bf0dfaab453893d0.angles);
    return;
  }

  scripts\cp\cp_checkpoint::function_5b0a03741aa420d7();
}

function function_feafb69376e58f77() {
  flag_wait("checkpoint_data_retrieved");
  flag_wait("player_spawned_with_loadout");
  var_eae6aff771c7ceea = getStructArray("chem_obj_heli", "targetname");
  flag_wait("scriptables_ready");
  var_95a0ec945e1ee1fc = function_7a18da6e48b71c35("smoke_vfx_obj1_cs");
  level.var_7d19c63b5e6972e1 = spawn_model("tag_origin", var_95a0ec945e1ee1fc.origin + (0, 0, 0), var_95a0ec945e1ee1fc.angles);
  playFXOnTag(level._effect["vfx_chemical_smk_signal"], level.var_7d19c63b5e6972e1, "tag_origin");
  level.var_7d19c63b5e6972e1 playLoopSound("jup_chemical_helicopter_flare_lp");
  var_7b97d75e3a70565f = function_7a18da6e48b71c35("smoke_vfx_obj2_cs");
  level.var_7d19c33b5e696c48 = spawn_model("tag_origin", var_7b97d75e3a70565f.origin + (0, 0, 0), var_7b97d75e3a70565f.angles);
  playFXOnTag(level._effect["vfx_chemical_smk_signal"], level.var_7d19c33b5e696c48, "tag_origin");
  level.var_7d19c33b5e696c48 playLoopSound("jup_chemical_helicopter_flare_lp");
  var_45f584f6892fd996 = function_7a18da6e48b71c35("smoke_vfx_obj3_cs");
  level.var_7d19c43b5e696e7b = spawn_model("tag_origin", var_45f584f6892fd996.origin + (0, 0, 0), var_45f584f6892fd996.angles);
  playFXOnTag(level._effect["vfx_chemical_smk_signal"], level.var_7d19c43b5e696e7b, "tag_origin");
  level.var_7d19c43b5e696e7b playLoopSound("jup_chemical_helicopter_flare_lp");
  namespace_548a10c405703106::function_61483c01c23ba872("chem_obj_heli");
  namespace_548a10c405703106::function_606322b129b94140(&function_970bb5e5e2c1c98b);
  flag_set("flag_obj_helis_setup");
}

function function_970bb5e5e2c1c98b(heli_str) {
  if(!isDefined(level.var_10aad158c29f7d5f)) {
    level.var_10aad158c29f7d5f = [];
  }

  if(!isDefined(level.var_9df79069dfd8549b)) {
    level.var_9df79069dfd8549b = 0;
  }

  if(istrue(level.checkpoint_reached)) {
    heli_str thread function_a5ffb42ef740284d();
    return;
  }

  if(heli_str.obj_id == "1") {
    while(!isDefined(level.var_61a1cf9a2aa1422a)) {
      waitframe();
    }

    level.var_61a1cf9a2aa1422a notify("heli_containment_dead");
    flag_set("flag_obj_containment_heli_killed");
    stopFXOnTag(level._effect["vfx_chemical_smk_signal"], level.var_7d19c63b5e6972e1, "tag_origin");
    level.var_7d19c63b5e6972e1 stoploopsound("jup_chemical_helicopter_flare_lp");
  }

  if(heli_str.obj_id == "2") {
    while(!isDefined(level.var_bc6d6cb38eacfadf)) {
      waitframe();
    }

    level.var_bc6d6cb38eacfadf notify("heli_spray_dead");
    flag_set("flag_obj_spray_heli_killed");
    stopFXOnTag(level._effect["vfx_chemical_smk_signal"], level.var_7d19c33b5e696c48, "tag_origin");
    level.var_7d19c33b5e696c48 stoploopsound("jup_chemical_helicopter_flare_lp");
  }

  if(heli_str.obj_id == "3") {
    while(!isDefined(level.var_892668e51678935a)) {
      waitframe();
    }

    level.var_892668e51678935a notify("heli_parking_dead");
    flag_set("flag_obj_parking_heli_killed");
    stopFXOnTag(level._effect["vfx_chemical_smk_signal"], level.var_7d19c43b5e696e7b, "tag_origin");
    level.var_7d19c43b5e696e7b stoploopsound("jup_chemical_helicopter_flare_lp");
  }

  heli_str thread function_a5ffb42ef740284d();
  level.var_9df79069dfd8549b++;
  level.var_10aad158c29f7d5f = array_add_safe(level.var_10aad158c29f7d5f, int(heli_str.obj_id));
  level notify("heli_killed", heli_str.obj_id);
  flag_set("any_heli_killed");
  flag_set("flag_heli_killed_" + heli_str.obj_id);
  flag_set("flag_" + level.var_9df79069dfd8549b + "_helis_destroyed");
  level.global_stealth_broken = 1;
  flag_set("flag_player_movement_reset");

  if(isDefined(level.var_5f4f92a8e2b137e7)) {
    level.var_5f4f92a8e2b137e7 = 1;
  }
}

function function_a5ffb42ef740284d() {
  self endon("death");
  destroyed_model = self.mdl_dst;
  var_55a8317faef6cb03 = "veh_jup_mil_ru_heli_transport_rotor_chunk_a_dst";
  var_1eb91b8c9aa7efca = "veh_jup_mil_ru_heli_transport_rotor_chunk_a2_dst";
  var_2ee17286ea0a5682 = "tag_attach_rotor_chunk_a_dst";
  var_67dafc9c39ced5c7 = "tag_attach_rotor_chunk_a2_dst";
  var_d7973763b9c7e68d = spawn("script_model", destroyed_model gettagorigin(var_2ee17286ea0a5682));
  var_d7973763b9c7e68d setModel(var_55a8317faef6cb03);
  var_d7973763b9c7e68d childthread function_28de00cce235b1be(1, destroyed_model, var_2ee17286ea0a5682, 25, 35);
  var_d7a9ded31a3c4688 = spawn("script_model", destroyed_model gettagorigin(var_67dafc9c39ced5c7));
  var_d7a9ded31a3c4688 setModel(var_1eb91b8c9aa7efca);
  var_d7a9ded31a3c4688 childthread function_28de00cce235b1be(-1, destroyed_model, var_67dafc9c39ced5c7, 30, 40);
}

function function_28de00cce235b1be(direction, destroyed_model, joint, duration, start_speed) {
  current_speed = start_speed;
  var_59fd5fee0814120 = duration / start_speed;
  step = 0.05;
  d = 0;

  while(d < duration) {
    current_speed = start_speed * (duration - d) / duration;
    self.origin = destroyed_model gettagorigin(joint) + anglesToForward(destroyed_model gettagangles(joint));
    self addyaw(current_speed * direction);

    if(current_speed <= 0) {
      return;
    }

    wait step;
    d += step;
  }
}

function function_d2d5329aa836f9a5() {
  while(level.var_9df79069dfd8549b < level.var_7a155fea3b7b30dc) {
    level waittill("heli_killed");
    utility::objective_update("obj_reconArea", undefined, undefined, undefined, undefined, level.var_9df79069dfd8549b);
  }

  utility::flag_set("flag_obj_all_helis_killed");
  level notify("all_helis_killed");
  thread namespace_11fae4a66a43bd3f::function_588af84fad23df23("cp_jup_chemical_sfx_reactor");
}

function obj_chemicals() {
  level endon("game_ended");
  level.player endon("death");
  level flag_wait("flag_obj_chemicals_start");
  thread namespace_11fae4a66a43bd3f::function_588af84fad23df23("cp_jup_chemical_sfx_reactor");
  objstruct = level.objectivestabledata["obj_chemicals"];
  initializeobjective(objstruct, "obj_chemicals", "primary");
  startobjective(objstruct, "obj_chemicals", "primary");
  level flag_wait("flag_obj_chemicals_completed");
  completeobjective(objstruct, "obj_chemicals", "primary");
}

function obj_escape() {
  level endon("game_ended");
  level.player endon("death");
  level flag_wait("flag_obj_escape_start");
  thread namespace_11fae4a66a43bd3f::function_588af84fad23df23("cp_jup_chemical_sfx_exfil");
  objstruct = level.objectivestabledata["obj_escape"];
  initializeobjective(objstruct, "obj_escape", "primary");
  startobjective(objstruct, "obj_escape", "primary");
  level flag_wait("flag_obj_escape_completed");
  completeobjective(objstruct, "obj_escape", "primary");
}

function function_d15b187afaab6caf(objectivestruct, var_5dcdfd3a4eff9961) {
  level endon("game_ended");
  level.player endon("death");
  circleradius = 1000;
  circle_a = function_7a18da6e48b71c35("circle_a");
  circle_b = function_7a18da6e48b71c35("circle_b");
  circle_c = function_7a18da6e48b71c35("circle_c");
  createquestcircle(circle_a, circle_a.origin, circleradius);
  createquestcircle(circle_b, circle_b.origin, circleradius);
  createquestcircle(circle_c, circle_c.origin, circleradius);

  for(i = 0; i < 3; i++) {
    level waittill("heli_killed");

    if(array_contains(level.var_10aad158c29f7d5f, 1)) {
      circle_a function_af5604ce591768e1();
    }

    if(array_contains(level.var_10aad158c29f7d5f, 3)) {
      circle_b function_af5604ce591768e1();
    }

    if(array_contains(level.var_10aad158c29f7d5f, 2)) {
      circle_c function_af5604ce591768e1();
    }
  }
}

function function_bdfb627dddf62692(objectivestruct, var_5dcdfd3a4eff9961) {
  if(flag("flag_obj_all_helis_killed")) {
    return;
  }

  level.var_61a1cf9a2aa1422a = function_7a18da6e48b71c35("circle_obj_containment");
  level.var_bc6d6cb38eacfadf = function_7a18da6e48b71c35("circle_obj_spray");
  level.var_892668e51678935a = function_7a18da6e48b71c35("circle_obj_parking");
  var_de317e15e1855ee0 = 500;
  var_14e8dcc1229cc908 = 1600;

  if(!isDefined(level.var_61a1cf9a2aa1422a) || !isDefined(level.var_bc6d6cb38eacfadf) || !isDefined(level.var_892668e51678935a)) {
    return;
  }

  level.var_61a1cf9a2aa1422a thread function_dc3c295fcb6d7c77(0, "heli_containment_dead", var_de317e15e1855ee0, var_14e8dcc1229cc908, undefined, undefined, undefined, undefined, undefined, undefined, &"CP_JUP_CHEMICAL/DESTROYHELI");
  level.var_bc6d6cb38eacfadf thread function_dc3c295fcb6d7c77(1, "heli_spray_dead", var_de317e15e1855ee0, var_14e8dcc1229cc908, undefined, undefined, undefined, undefined, undefined, undefined, &"CP_JUP_CHEMICAL/DESTROYHELI");
  level.var_892668e51678935a thread function_dc3c295fcb6d7c77(2, "heli_parking_dead", var_de317e15e1855ee0, var_14e8dcc1229cc908, undefined, undefined, undefined, undefined, undefined, undefined, &"CP_JUP_CHEMICAL/DESTROYHELI");
}

function function_ad178423e92bbca2(objectivestruct, var_5dcdfd3a4eff9961) {
  level endon("game_ended");
  level.player endon("death");
  flag_wait("flag_obj_enterPowerPlant_given");
  wait 3;
  level.var_b3f66d5bf240f1bc = function_7a18da6e48b71c35("circle_enter_plant_a");
  level.var_b3f66d5bf240f1bc thread function_dc3c295fcb6d7c77(3, "flag_power_plant_entered", 2000, 1, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 0);
  flag_set("flag_circle_plant_setup");
}

function function_dd0367751dfd91e7(objectivestruct, var_5dcdfd3a4eff9961) {
  if(istrue(level.var_7f77135028cc742f)) {
    return;
  }

  var_c081a31bdaab7e50 = function_7a18da6e48b71c35("reactor_turbine_door_interact");
  var_570c9b8cbd531fcb = function_7a18da6e48b71c35("reactor_parking_door_interact");
  var_b383af4df01327f1 = function_7a18da6e48b71c35("reactor_rear_door_interact");
  level.var_c68bd17b13bfbde6 = [var_c081a31bdaab7e50, var_570c9b8cbd531fcb, var_b383af4df01327f1];
  level.var_f8092806abaac077 = getStructArray("airlock_entrance", "targetname");
  var_553a874ab3441c1 = sortbydistance(level.var_c68bd17b13bfbde6, level.player.origin)[0];
  level.var_f588d5e1542dfb14 = spawn("script_origin", var_553a874ab3441c1.origin);
  level.var_f588d5e1542dfb14.script_noteworthy = var_c081a31bdaab7e50.script_noteworthy;
  level.var_f588d5e1542dfb14 thread function_dc3c295fcb6d7c77(4, "flag_reactor_entered", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  level.var_7f77135028cc742f = 1;
  level.var_f588d5e1542dfb14 thread function_e56920ddc6631190();
}

function function_e56920ddc6631190() {
  level endon("game_ended");
  level.player endon("death");
  level endon("flag_reactor_airlock_passed");
  level endon("flag_reactor_entered");
  var_d907ce4c2f19476b = getEntArray("vol_obj_reactor_doors", "targetname");

  while(true) {
    wait 0.25;
    obj_locs = level.var_f8092806abaac077;
    var_d5e545a23a2e5686 = (0, 0, 0);

    foreach(vol in var_d907ce4c2f19476b) {
      if(level.player istouching(vol)) {
        obj_locs = level.var_c68bd17b13bfbde6;
        var_d5e545a23a2e5686 = (0, 0, 10);
      }
    }

    obj_locs = sortbydistance(obj_locs, level.player.origin);
    var_1c77ba6374f2dbe5 = obj_locs[0];

    if(is_equal(var_1c77ba6374f2dbe5.origin, self.origin)) {
      continue;
    }

    objective_position(self.var_191d2524aa36a7e, var_1c77ba6374f2dbe5.origin + var_d5e545a23a2e5686);
    self.origin = var_1c77ba6374f2dbe5.origin;
  }
}

function function_c5f1c920bda0c382() {
  level endon("game_ended");
  level.player endon("death");
  vols = function_f159c10d5cf8f0b4("recon_poi_konnicamp", "script_noteworthy");
  var_488e1669c0e7a982 = 0;

  foreach(vol in vols) {
    vol namespace_8c7f8f6b3076a74a::function_85aedb842bdb548b();
    vol namespace_8c7f8f6b3076a74a::function_c83d1e8771ec8f57("recon_poi_konnicamp_seen");
    vol namespace_8c7f8f6b3076a74a::function_64c508c5eab90d48(0);
    vol namespace_8c7f8f6b3076a74a::function_bc16e47a5d8d241a(1600);
    vol namespace_8c7f8f6b3076a74a::function_13ffcc0bd41e3ed3(1);
    vol namespace_8c7f8f6b3076a74a::function_9ab6c382d227266("flag_vo_recon_disabled");

    if(vol namespace_8c7f8f6b3076a74a::function_23425e6521e47280()) {
      var_488e1669c0e7a982 = 1;
    }
  }
}

function circle_waterpump() {
  level endon("game_ended");
  level.player endon("death");
  circle_struct = function_7a18da6e48b71c35("circle_waterpump");
  circleradius = 900;
  vols = function_f159c10d5cf8f0b4("recon_poi_pipeworks", "script_noteworthy");
  var_488e1669c0e7a982 = 0;

  foreach(vol in vols) {
    vol namespace_8c7f8f6b3076a74a::function_85aedb842bdb548b();
    vol namespace_8c7f8f6b3076a74a::function_c83d1e8771ec8f57("recon_poi_pipeworks_seen");
    vol namespace_8c7f8f6b3076a74a::function_64c508c5eab90d48(0);
    vol namespace_8c7f8f6b3076a74a::function_bc16e47a5d8d241a(1400);
    vol namespace_8c7f8f6b3076a74a::function_13ffcc0bd41e3ed3(1);

    if(vol namespace_8c7f8f6b3076a74a::function_23425e6521e47280()) {
      var_488e1669c0e7a982 = 1;
    }
  }
}

function function_bfa5f9f7a30e6fb1(objectivestruct, circle_struct, circleradius) {
  if(distance(level.player.origin, circle_struct.origin) > circleradius) {
    iconoffset = (0, 0, 500);
    searchindex = namespace_1170726b2799ea65::function_f60f3ac2fb2776f7(circle_struct, "hud_icon_minimap_search_area", "icon_small", circle_struct.origin + iconoffset, "current", "Konni Equipment");

    while(!flag("circle_waterpump_completed") && distance(level.player.origin, circle_struct.origin) > circleradius) {
      waitframe();
    }

    scripts\cp\cp_objectives::freeworldidbyobjid(searchindex);
  }
}

function function_98912339dc6732a0() {
  level.checkpoint = "";
  level.checkpoint_reached = 0;

  while(!isDefined(level.player)) {
    waitframe();
  }

  scripts\cp\cp_checkpoint::function_5ace495feba111d3();
}

function function_9fdd4ad49aa8eb0a() {
  while(true) {
    level waittill("heli_killed");

    if(level.var_9df79069dfd8549b == 3) {
      break;
    }
  }

  var_810a1136733c1d76 = [];
  var_810a1136733c1d76[0] = level.var_1496650f878c4850[0].var_71efe19bc16fd96d;
  var_810a1136733c1d76[1] = level.var_1496650f878c4850[1].var_71efe19bc16fd96d;
  var_810a1136733c1d76[2] = level.var_1496650f878c4850[2].var_71efe19bc16fd96d;

  foreach(weap in var_810a1136733c1d76) {
    if(!function_f8c581fe8836f54b(weap)) {
      return;
    }
  }

  if(var_810a1136733c1d76[0] == var_810a1136733c1d76[1] || var_810a1136733c1d76[0] == var_810a1136733c1d76[2] || var_810a1136733c1d76[1] == var_810a1136733c1d76[2]) {
    iprintlnbold("<dev string:x2b8>");

    return;
  }

  iprintlnbold("<dev string:x2cb>");

  level.player function_6a369480dbaf1090("jup_sp_jackofallweapons");
}

function function_f8c581fe8836f54b(weap) {
  var_ec13ee6ba3d6cb34 = ["toma_proj_mp", "toma_proj_jup_mp", "cruise_proj_mp", "artillery_mp", "hover_jet_bomb_mp", "auto_drone_proj_mp", "assault_drone_mp"];

  foreach(var_fe22887ebcedad84 in var_ec13ee6ba3d6cb34) {
    if(is_equal(var_fe22887ebcedad84, weap)) {
      return true;
    }
  }

  return false;
}

function function_c7b23489dccac22a() {
  if(istrue(level.player.pers["pauseMenu_restart"])) {
    return false;
  }

  var_e274235250d8ba5e = function_69fa4a2561ada985("full_airdrop_vo_said");
  return istrue(var_e274235250d8ba5e);
}

function function_ac995123da286501() {
  if(istrue(level.player.pers["pauseMenu_restart"])) {
    return false;
  }

  var_e274235250d8ba5e = function_69fa4a2561ada985("explosives_vo_said");
  return istrue(var_e274235250d8ba5e);
}

function function_8047cf77708b61c0() {
  flag_wait("checkpoint_data_retrieved");

  if(is_equal(level.checkpoint, "")) {
    flag_set("flag_first_playthrough");
  }
}

function function_f7c06ebe6b588ac6() {
  self endon("death");

  while(!isDefined(self.riders) || is_equal(self.riders.size, 0)) {
    wait 1;
  }

  gunner = function_cde7b4002c7a79eb();
  gunner endon("death");
  gunner endon("stop_shooting");
  turret = self.mgturret[0];
  turret startfiring();
  turret self_func("SetAISpread", 2);
  turret setmode("manual");
  gunner linktoblendtotag(turret, "tag_gunner", 0);
  mercy = 0;
  var_e787b215e9fd1517 = 2;
  fire_rate = weaponfiretime(turret.objweapon);

  while(true) {
    if(isDefined(gunner.enemy)) {
      turret settargetentity(gunner.enemy);
      turret waittill("turret_on_target");
      burst = randomintrange(12, 18);
      shots = 0;
      minshots = randomintrange(7, 12);

      for(i = 0; i < burst; i++) {
        shots++;
        turret shootturret();
        wait fire_rate;
        target = turret getturrettarget(0);

        if(isDefined(target) && isPlayer(target) && mercy < var_e787b215e9fd1517 && target.health < 60) {
          mercy++;
          wait 3;
        }

        if(shots > minshots) {
          if(isDefined(target) && issentient(target) && !isalive(target)) {
            break;
          }
        }
      }
    } else {
      turret cleartargetentity();
    }

    wait 2 + randomfloat(1);
  }
}

function setup_map_specific_devgui() {
  function_6e7290c8ee4f558b("<dev string:x2e0>");
  function_a9a864379a098ad6("<dev string:x2eb>", "<dev string:x30c>", &function_b65304b599deaab4);
  function_a9a864379a098ad6("<dev string:x31d>", "<dev string:x33f>", &function_5df0f7ced0eca668);
  function_a9a864379a098ad6("<dev string:x357>", "<dev string:x37b>", &function_e53582095e9393b9);
  function_a9a864379a098ad6("<dev string:x38f>", "<dev string:x3a1>", &function_63e33dca3525cdde);
  function_a9a864379a098ad6("<dev string:x3bf>", "<dev string:x3d7>", &function_f082b3b7779ac93c);
  function_b2159fbbd7ac094e("<dev string:x3ef>", @ "hash_42417cffcfb34e5");
  function_a9a864379a098ad6("<dev string:x405>", "<dev string:x41b>", &function_ff890fac704b4f86);
  function_a9a864379a098ad6("<dev string:x431>", "<dev string:x44a>", &function_a4396525946ca95d);
  function_a9a864379a098ad6("<dev string:x469>", "<dev string:x482>", &function_2ff75714711897c9);
  function_a9a864379a098ad6("<dev string:x4a1>", "<dev string:x4b9>", &function_7201ad81c53a9843);
  function_a9a864379a098ad6("<dev string:x4d7>", "<dev string:x4f1>", &function_dd74b8831a132e28);
  function_a9a864379a098ad6("<dev string:x512>", "<dev string:x52c>", &function_5eb44008507a4414);
  function_a9a864379a098ad6("<dev string:x54d>", "<dev string:x566>", &function_3c0d529e27471c8c);
  function_a9a864379a098ad6("<dev string:x586>", "<dev string:x5a5>", &function_7037012f03c9990b);
  function_a9a864379a098ad6("<dev string:x5c2>", "<dev string:x5da>", &function_4f7162e5da0f5108);
  function_fe953f000498048f();
}

function function_b65304b599deaab4() {
  var_168cd8307a3f8807 = function_606f53b43c800acd(level.player.origin);
  flag_set("<dev string:x5f9>" + var_168cd8307a3f8807);
}

function function_5df0f7ced0eca668() {
  var_168cd8307a3f8807 = function_606f53b43c800acd(level.player.origin);
  flag_set("<dev string:x611>" + var_168cd8307a3f8807);
}

function function_e53582095e9393b9() {
  var_168cd8307a3f8807 = function_606f53b43c800acd(level.player.origin);
  flag_set("<dev string:x629>" + var_168cd8307a3f8807);
}

function function_a4396525946ca95d() {
  function_4f8fe005b1fcebf6(1);
}

function function_2ff75714711897c9() {
  function_4f8fe005b1fcebf6(3);
}

function function_7201ad81c53a9843() {
  function_4f8fe005b1fcebf6(2);
}

function function_4f8fe005b1fcebf6(var_168cd8307a3f8807) {
  foreach(heli in level.var_1496650f878c4850) {
    if(is_equal(heli.obj_id, "<dev string:x644>" + var_168cd8307a3f8807)) {
      objweapon = makeweapon("<dev string:x645>");
      heli.mdl_pristine dodamage(1, level.player.origin, level.player, undefined, "<dev string:x656>", objweapon);
    }
  }
}

function function_dd74b8831a132e28() {
  function_3bf7589ff185a8eb("<dev string:x665>");
}

function function_5eb44008507a4414() {
  function_3bf7589ff185a8eb("<dev string:x671>");
}

function function_3c0d529e27471c8c() {
  function_3bf7589ff185a8eb("<dev string:x67d>");
}

function function_7037012f03c9990b() {
  function_3bf7589ff185a8eb("<dev string:x688>");
}

function function_4f7162e5da0f5108() {
  function_3bf7589ff185a8eb("<dev string:x699>");
}

function function_3bf7589ff185a8eb(var_254007cad3698917) {
  if(is_equal(getdvarint(@ "hash_c0553ad124ada559", 0), 3) && is_equal(getDvar(@ "hash_2f88a9cf88dc1632", "<dev string:x644>"), var_254007cad3698917)) {
    adddebugcommand("<dev string:x6a8>");
  } else {
    adddebugcommand("<dev string:x6c4>");
  }

  if(!is_equal(getDvar(@ "hash_2f88a9cf88dc1632", "<dev string:x644>"), var_254007cad3698917)) {
    adddebugcommand("<dev string:x6e0>" + var_254007cad3698917);
  }
}

function function_f082b3b7779ac93c() {
  if(is_equal(getdvarint(@ "hash_629bc1186fe4d3bc", 0), 1)) {
    adddebugcommand("<dev string:x6ff>");
    return;
  }

  adddebugcommand("<dev string:x71e>");
}

function function_63e33dca3525cdde() {
  flag_set("<dev string:x287>");
}

function function_ff890fac704b4f86() {
  if(is_equal(getdvarint(@ "hash_62ee4f35a8ab19e5", 0), 1)) {
    adddebugcommand("<dev string:x73d>");
    adddebugcommand("<dev string:x75b>");
    adddebugcommand("<dev string:x788>");
    adddebugcommand("<dev string:x7b3>");
    return;
  }

  adddebugcommand("<dev string:x7df>");
  adddebugcommand("<dev string:x7fd>");
  adddebugcommand("<dev string:x82a>");
  adddebugcommand("<dev string:x855>");
}

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

# /