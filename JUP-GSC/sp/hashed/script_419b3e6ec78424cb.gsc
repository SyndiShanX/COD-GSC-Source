/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_419b3e6ec78424cb.gsc
*************************************************/

#using script_102d83a437e2b29f;
#using script_16ea1b94f0f381b3;
#using script_17ddadd79bcb1dc6;
#using script_1a7dece288bd7452;
#using script_1ac78343610e4a62;
#using script_1b5e21ec19a8960b;
#using script_2362aeeb4ee01a71;
#using script_2386704e3c08f8ca;
#using script_271f866eb2ad60a8;
#using script_28a77d87ba9d1de5;
#using script_2bd16c90e9c5c546;
#using script_3a7a33fe428d8a7;
#using script_3a8f9ace195c9da9;
#using script_3cb1beed718e7650;
#using script_3ecbe29e8a099d07;
#using script_41abe5ab9dd2b8fa;
#using script_42f868a5dda17294;
#using script_46b342a079938c68;
#using script_48324b060b129b7b;
#using script_4acc6b60b67565eb;
#using script_5209bb5e8fef3757;
#using script_5e14af011319ea03;
#using script_7db80de62748c769;
#using script_7e7eaa110dbb1c83;
#using script_e0ac9e0ec816354;
#using script_f603f40349f99c8;
#using scripts\anim\dialogue;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\create_script_utility;
#using scripts\common\exploder;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_paths;
#using scripts\cp\cp_checkpoint;
#using scripts\cp\cp_claymore;
#using scripts\cp\cp_compass;
#using scripts\cp\cp_objectives;
#using scripts\cp\cp_outofbounds;
#using scripts\cp\cp_spawning_util;
#using scripts\cp\globallogic;
#using scripts\cp\pickups;
#using scripts\cp\player\offhand_box;
#using scripts\cp\player_death;
#using scripts\cp\spawning;
#using scripts\cp\starts;
#using scripts\cp\utility;
#using scripts\cp\utility\reinforcement_util;
#using scripts\cp\utility\script;
#using scripts\cp\vehicles;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\anim_scene;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\pickups;
#using scripts\cp_mp\stealth\manager;
#using scripts\cp_mp\stealth\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\weapon;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\stealth\utility;
#namespace cp_jup_port;

function main() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0)) {
    return;
  }

  function_61411c49eaca86e2("farah_port");
  level.var_2a226e97d7ab297 = "jup_execution_first_person_farah_001";
  namespace_e4a0e44d9983503c::main();
  namespace_ffb1e1e7d1c48d29::main();
  namespace_596c598592c725a::main();
  thread namespace_3d5dc532bca51ac0::main();
  thread namespace_58460674041d36d3::main();
  scripts\cp\cp_outofbounds::function_4ff3dde013cb8715(6);

  if(level.createfx_enabled) {
    return;
  }

  if(!isDefined(level.valstruct)) {
    level.valstruct = spawnStruct();
  }

  level.var_475295e508fa1e5f = 0;
  level.var_4f1860926733eab2 = [];
  level.var_80fffd99d53ccf75 = [];
  level.var_80fffa99d53cc8dc = [];
  coop_mode_enable("sp_stealth");
  level thread function_fb457f7cdf0ac39e();
  function_78910c2dc06049ca();
  function_d525f1534752bfc7();
  function_2cfef434ce6a1c44();
  function_988743dcde6885a6();
  function_635532f54eac01c7();
  flag_init("already_showed_chyron");
  function_c4d555bf9485ac3b();
  function_c3e34853ee15f719();
  level.valstruct val::set("level", "ai_eventlist", "ranch_aieventlist");

  if(level.mapname == "cp_jup_port") {
    level.var_61a54be8038f3a95 = 1;
    level.var_41957e049a51e8bc = "stealth_ai_music_bundle_cp_jup_port";
    level.var_8e4a4897f3b80823 = 1;
  }

  callback::add("player_connect", &onplayerconnect);
  function_7c5fb8565b12cd65();
  function_cc115c9ca6e7659a("curious", 32, 0, 20, 500, 6000, 500, 6000);
  function_cc115c9ca6e7659a("scared", 400, 360, 20, 250, 1200, 250, 1200);
  function_cc115c9ca6e7659a("panicked", 400, 360, 30, 250, 1000, 250, 1000);
  function_cc115c9ca6e7659a("cower", 600, 800, 30, 250, 500, 250, 500);
  function_cc115c9ca6e7659a("flee", 1000, 600, 45, 250, 500, 250, 500);
  function_872cab03b2cac73a(0.5, 0.5, 2.5);
  level.valstruct val::set("level", "global_esc_total_combat_time", 500);
  level.valstruct val::set("level", "global_esc_percent_threshold", 0.3);
  function_cdfd74e95368bd63(15000);
  level.valstruct val::set("level", "stealth_ttlt_lkp", 20000);
  level.valstruct val::set("level", "stealth_ttlt_not_lkp", 20000);
  level.var_e908c9dbefd1f3e6 = 1;
  setglobalsoundcontext("jup_map", "port_mission", 0);
}

function function_2cfef434ce6a1c44() {
  level.custom_onspawnplayer_func = &onplayerspawned;
  level.custom_onplayerconnect_func = &onplayerconnect;
  level.var_a18b35bc1529ade3 = &function_473271d8c22b9720;
}

function onplayerconnect(params) {
  if(!function_d8603a6ab773365f()) {
    anim_org = function_7a18da6e48b71c35("jup_port_infil");
    anim_org scripts\common\scene::pre_stream(undefined, undefined, -1, "jup_port_infil");
  }
}

function onplayerspawned() {}

function function_473271d8c22b9720() {
  slot = scripts\cp_mp\pickups::function_4967838290cb31b9(1);

  if(!isDefined(slot) || !isDefined(self.equipment[slot])) {
    return;
  }

  equipmentname = array_find(level.br_pickups.br_equipname, self.equipment[slot]);

  if(isDefined(equipmentname)) {
    if(issubstr(equipmentname, "rfid")) {
      lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("brloot_offhand_jup_rfid");

      if(!scripts\cp\pickups::function_e01d9736b2d100ac(lootid, 1)) {
        scripts\cp_mp\pickups::quickdropitem(10, 1);
      }

      scripts\cp\pickups::additemtobackpackbyref("equip_rfid", undefined, 1);
    }
  }
}

function function_988743dcde6885a6() {
  scripts\cp\spawning::add_global_spawn_function("axis", &function_db242e965d84938d);
}

function function_635532f54eac01c7() {
  level.objectivesfunc = &function_c2a86f682bf1ab71;
  level thread scripts\cp\cp_objectives::objectives_init();

  if(!objective_isunlimited()) {
    namespace_9d6ed0911e2ddf09::reserve_objectiveid([4, 5, 6, 7, 8, 9]);
  }
}

function function_c4d555bf9485ac3b() {
  thread function_213275253799582f();
  thread function_fafb00a5eeaf4797();
  setup_create_script();
  level thread function_fc4803dc319a81d2();
  function_e00cc8c1c5cc38fb(1);
  scripts\cp\cp_compass::setupminimap("compass_map_cp_jup_port_floor_0");
  namespace_28097854c98546b5::function_b04f37f19c6631e0();
  level thread function_5c316fb50cbe87ee();
  level thread function_dafb3a3f4a103ccd();
  level thread function_f08e17103dfe9d24();
  setomnvar("requires_scriptmover_ladder_checks", 1);
  level thread function_2a7cebc730abe77a();
  level thread function_d3a3272b937dbd96();
  level thread function_d7398803f3fe830();
  thread function_dc2ca7e835560d4e();

  level.devgui_setup_func = &function_d8fb18a58a875db6;
  level thread setup_map_specific_devgui();
}

function function_dc2ca7e835560d4e() {
  level endon("game_ended");
  flag_wait("player_spawned_with_loadout");
  level.player endon("death");

  while(isDefined(level.player)) {
    if(level.player scripts\cp\utility::touchingbadtrigger()) {
      level.player setscriptablepartstate("burning", "active");
    } else {
      level.player setscriptablepartstate("burning", "neutral");
    }

    wait 0.2;
  }
}

function function_78910c2dc06049ca() {
  level._effect["grenade_spawner_01"] = loadfx("vfx/jup/level/cp_jup_port/vfx_jup_port_grenade_spawner_01.vfx");
  level._effect["explosion_tower"] = loadfx("vfx/jup/level/cp_jup_port/vfx_jup_port_explosion_tower.vfx");
  level._effect["explosion_ship"] = loadfx("vfx/jup/level/cp_jup_port/vfx_jup_port_explosion_ship.vfx");
  level._effect["smoke_building_damage"] = loadfx("vfx/jup/level/cp_jup_port/cp_jup_smoke_building_damage.vfx");
  level._effect["smoke_ship_damage"] = loadfx("vfx/jup/level/cp_jup_port/cp_jup_smoke_ship_damage.vfx");
  level._effect["smoke_ground_lrg_02"] = loadfx("vfx/jup/level/cp_jup_port/cp_jup_smoke_ground_lrg_02.vfx");
  level._effect["explosion_fiery"] = loadfx("vfx/jup/level/cp_jup_port/cp_jup_port_explosion_fiery.vfx");
  level._effect["fire_ground_lrg"] = loadfx("vfx/jup/level/cp_jup_port/vfx_jup_port_fire_ground_lrg.vfx");
  level._effect["vfx_flashlight_npc_perf_short"] = loadfx("vfx/jup/lighting/vfx_flashlight_npc_perf_short.vfx");
  level._effect["concussion_grenade"] = loadfx("vfx/jup/level/cp_jup_port/vfx_jup_port_concussion_grenade.vfx");
  level._effect["at_mine_exp"] = loadfx("vfx/jup/level/cp_jup_port/vfx_jup_port_at_mine_exp.vfx");
  level._effect["smoke_ground_lrg"] = loadfx("vfx/jup/level/cp_jup_port/cp_jup_smoke_ground_lrg.vfx");
  level._effect["helicopter_01_strafe"] = loadfx("vfx/jup/level/cp_jup_port/cp_jup_port_helicopter_01_strafe.vfx");
  level._effect["helicopter_02_strafe"] = loadfx("vfx/jup/level/cp_jup_port/cp_jup_port_helicopter_02_strafe.vfx");
  level._effect["vfx_jup_port_lensflare_headlight_scriptable"] = loadfx("vfx/jup/level/cp_jup_port/vfx_jup_port_lensflare_headlight_scriptable.vfx");
  level._effect["vfx_jup_port_splashes_wheel_veh"] = loadfx("vfx/jup/level/cp_jup_port/vfx_jup_port_splashes_wheel_veh.vfx");
}

function function_7c5fb8565b12cd65() {
  flag_wait("flag_dungeon_intro_complete");

  if(getdvarint(@ "hash_ad29ab4c5ad7ff4c", 1)) {
    level thread namespace_15c7ce84dd21743d::function_1949988230389477("patrol01_2", "patrol01_1", 45, 15, 10, 5, ["idle_smoke", "idle_rub_hand", "idle_drinking", "idle_stretching"]);
    level thread namespace_15c7ce84dd21743d::function_1949988230389477("patrol05_1", "patrol05_2", 5, 15, 10, 8, ["idle_smoke", "idle_rub_hand", "idle_drinking", "idle_stretching"]);
    level thread namespace_15c7ce84dd21743d::function_925cafceea813513("patrol04_2", 2, 15, 8, undefined, ["idle_smoke", "idle_rub_hand", "idle_drinking", "idle_stretching"]);
    level thread namespace_15c7ce84dd21743d::function_925cafceea813513("patrol06_1", 2, 15, 8, undefined, ["idle_focus_flashlight", "idle_radio", "idle_cellphone", "idle_tablet_inventory"]);
    level thread namespace_15c7ce84dd21743d::function_925cafceea813513("patrol07_1", 0, 5, 8, (0, -70, 0), ["idle_wreck_crouch_investigate", "idle_tablet_scanning", "idle_rub_hand", "idle_radio"]);
    level thread namespace_15c7ce84dd21743d::function_925cafceea813513("patrol08_1", 2, 15, 8, undefined, ["idle_radio", "idle_wreck_crouch_investigate", "idle_tablet_scanning", "idle_tablet_inventory"]);
    level thread namespace_15c7ce84dd21743d::function_925cafceea813513("patrol09_1", 2, 15, 8, undefined, ["idle_rub_hand", "idle_radio", "idle_cellphone"]);
  }
}

function function_213275253799582f() {
  flag_wait("level_ready_for_script");
  function_7203bd13c19d8bd3("obj_container_tracker_03");
  function_7203bd13c19d8bd3("obj_container_tracker_final");
}

function function_d7398803f3fe830() {
  level endon("game_ended");
  utility::flag_wait("flag_dungeon_intro_complete");
  var_5528b06a2cfce7f9 = 0;
  level.soundentity = spawn("script_origin", (880, -4458, 898));

  while(true) {
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
  level.vo notify("red_alert", istrue(val));

  if(istrue(val)) {
    iprintln("<dev string:x1c>");

    return;
  }

  iprintln("<dev string:x2d>");

  level notify("red_alert_end");
}

function function_f3f35f8a092179e7() {
  function_6149b301ce19988b("ai_post_2nd_container_wave", &function_631a16b9a3413704);
  function_6149b301ce19988b("ai_post_2nd_container_wave_crane", &function_341a16b14ffeee46);
}

function setup_create_script() {
  scripts\common\create_script_utility::register_create_script_arrays("cp_jup_port_create_script", "cp_jup_port_create_script", level.scripted_spawner_func.size, &namespace_37fb55a6c8d31812::main);
}

function function_fc4803dc319a81d2() {
  level thread wait_for_pre_game_period();
  level thread wait_for_strike_init_complete();
  level thread function_30160e0f4ccb9aaf();
  level thread function_4380ce742d375bba();
  level thread function_c0926f2d29510c1c();
  add_start("start", &function_877e2b6e2ca1c96a);
  add_start("harbormaster", &function_a1b8922568c3369a);
  add_start("boat", &function_f97171dcc86bb1b0);
  add_start("containers", &function_e2a5b3448e835566);
  add_start("exfil", &function_c894126e3281cbd6);
  add_start("exfil_containers", &function_c894126e3281cbd6);
  function_bb3e0c926b0667c4("start,harbormaster,boat,containers,exfil,exfil_containers");
}

function function_877e2b6e2ca1c96a() {
  utility::flag_set("setup_finished");
}

function function_a1b8922568c3369a() {
  setDvar(@ "hash_d8cccbc8f345edc4", 1);
  namespace_96731f4d002634f6::function_9250dfcc43a9ccb9();
  flag_wait("dungeon_load_finished");
  function_9ae658036ee9d914();
  thread namespace_3d5dc532bca51ac0::function_3719cd7c0273cbe8();
  thread namespace_3d5dc532bca51ac0::function_26280fbed5700639();
}

function function_f97171dcc86bb1b0() {
  setDvar(@ "hash_d8cccbc8f345edc4", 1);
  namespace_96731f4d002634f6::function_9250dfcc43a9ccb9();
  flag_wait("dungeon_load_finished");
  function_9ae658036ee9d914();
  thread namespace_3d5dc532bca51ac0::function_3719cd7c0273cbe8();
  thread namespace_3d5dc532bca51ac0::function_26280fbed5700639();
}

function function_e2a5b3448e835566() {
  setDvar(@ "hash_d8cccbc8f345edc4", 1);
  namespace_96731f4d002634f6::function_9250dfcc43a9ccb9();
  flag_wait("dungeon_load_finished");
  function_9ae658036ee9d914();
  function_55caabd486e254c5();
  thread namespace_3d5dc532bca51ac0::function_3719cd7c0273cbe8();
  thread namespace_3d5dc532bca51ac0::function_26280fbed5700639();
  flag_set("container_obj_start");
  level.player waittill("loadout_class_selected");
  slot = level.player scripts\cp_mp\pickups::function_4967838290cb31b9(1);
  level.player scripts\cp\pickups::dropequipmentinslot(slot, undefined, undefined, undefined, 1);
  level.player scripts\cp_mp\equipment::giveequipment("equip_rfid", "secondary");
}

function function_9ae658036ee9d914() {
  flag_set("container_obj_completed");
  flag_set("lootcrate_used");
  flag_set("loadout_pile_used");
  flag_set("first_gear_container_done");
  flag_set("dungeon_intro_complete");
}

function function_55caabd486e254c5() {
  flag_set("boat_obj_completed");
  flag_set("harbormaster_obj_completed");
  flag_set("flag_trackers_retrieved");
  flag_set("flag_manifest_retrieved");
}

function function_c894126e3281cbd6() {
  setDvar(@ "hash_d8cccbc8f345edc4", 1);
  namespace_96731f4d002634f6::function_9250dfcc43a9ccb9();
  flag_wait("dungeon_load_finished");
  function_9ae658036ee9d914();
  function_55caabd486e254c5();
  level.player waittill("loadout_class_selected");
  slot = level.player scripts\cp_mp\pickups::function_4967838290cb31b9(1);
  level.player scripts\cp\pickups::dropequipmentinslot(slot, undefined, undefined, undefined, 1);
  level.player scripts\cp_mp\equipment::giveequipment("equip_rfid", "secondary");
  flag_set("container_obj_start");
  wait 3;
  objstruct = level.objectivestabledata["obj_missile_container_hmo"];
  level notify("debug_beat_" + objstruct.objname + "_objective");
  flag_set("missile_container_hmo_found");
  objstruct = level.objectivestabledata["obj_missile_container_boat"];
  level notify("debug_beat_" + objstruct.objname + "_objective");
  flag_set("missile_container_boat_found");
  flag_set("container_port_done");
}

function wait_for_pre_game_period() {
  level endon("game_ended");
  flag_wait("bsp_structs_initialized");
  flag_wait("level_ready_for_script");

  while(!isDefined(level.player)) {
    waitframe();
  }

  level thread play_intro();
}

function wait_for_strike_init_complete() {
  level endon("game_ended");

  if(flag_exist("strike_init_done")) {
    flag_wait("strike_init_done");
    wait 1;
    thread function_dfeab09e12eff7e4();
    level.var_83782d6266ec4fb4 = &namespace_58460674041d36d3::function_6c22b1feac90c495;
    thread function_8e01c459332b0111();
    thread function_ad873d6b224de9df();
  }
}

function function_dfeab09e12eff7e4() {
  thread scripts\cp\player\offhand_box::offhand_box_setup();
}

function function_c2a86f682bf1ab71() {
  level.objectives_table = "cp/cp_jup_port_objectives.csv";
  level.objectivesmatrixtable = "cp/cp_jup_port_objectives_matrix.csv";
  level.objectiveregistration = &function_77765e5dd4c9db54;
  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

function function_77765e5dd4c9db54() {
  level endon("game_ended");
  flag_wait("level_ready_for_script");
  thread scripts\cp\cp_checkpoint::function_4bfef22c47a65be5("found_rfid_reader");
  thread scripts\cp\cp_checkpoint::function_4bfef22c47a65be5("found_gps_tracker");
  thread scripts\cp\cp_checkpoint::function_4bfef22c47a65be5("found_gps_and_rfid");
  flag_wait("objective_table_parsed");
  thread registerobjective("obj_gear_container", &function_b72ffe5023ab1d37, undefined, &function_216dc945d41701f6);
  thread registerobjective("obj_retrieve_trackers", &function_ed877a0ec28f7e78, undefined, &function_9a70a2e3897ac919);
  thread registerobjective("obj_get_manifest", &function_4b71dee061a99c0a, undefined, &function_a2ecdead97a15a9f);
  thread registerobjective("obj_missile_container_hmo", &function_b600c76fa2f4b7d5, &function_8d571169a6c4b409, &function_dfb2f011bbf44aa5);
  thread registerobjective("obj_missile_container_boat", &function_4b0b8e6cec2dd1a7, &function_1d9c167c9a03073b, &function_dfb2f011bbf44aa5);
  thread registerobjective("obj_missile_containers", &function_b8c6c1e2e05a57bd, undefined, undefined);
  thread registerobjective("obj_pickup_ascender", &function_243f47f9dd8f9eec, undefined, &function_7f2dd3b1b9a606d);
  scripts\cp\cp_checkpoint::function_63e1728c535014c9("found_gps_tracker", &scripts\cp\cp_checkpoint::function_5b0a03741aa420d7);
  scripts\cp\cp_checkpoint::function_63e1728c535014c9("found_rfid_reader", &scripts\cp\cp_checkpoint::function_5b0a03741aa420d7);
  scripts\cp\cp_checkpoint::function_63e1728c535014c9("found_gps_and_rfid", &scripts\cp\cp_checkpoint::function_5b0a03741aa420d7);
}

function function_ed877a0ec28f7e78(objectivestruct, var_5dcdfd3a4eff9961) {
  var_a70bf993491fe88e = function_7a18da6e48b71c35("gps_obj_circle");
  var_6f42290b0e4f545a = 150;
  objpoint = function_7a18da6e48b71c35("gps_obj");
  objpoint thread namespace_9d6ed0911e2ddf09::function_dc3c295fcb6d7c77(7, "gps_picked", var_6f42290b0e4f545a, undefined, 1, var_a70bf993491fe88e);
  objpoint namespace_8c7f8f6b3076a74a::function_847531f882fe30d0(0);
  objpoint namespace_8c7f8f6b3076a74a::function_70c1d0abf9be9b83(1);
}

function function_9a70a2e3897ac919(objectivestruct, var_5dcdfd3a4eff9961) {
  objpoint = function_7a18da6e48b71c35("gps_obj");
  objpoint notify("gps_picked");
}

function function_cd923b0f5118051c() {
  objstruct = level.objectivestabledata["obj_retrieve_trackers"];
  flag_set("boat_obj_checkpoint_reached");
  flag_set("flag_board_ship");
  flag_set("flag_enter_cabin");
  function_9ae658036ee9d914();
  function_7203bd13c19d8bd3("gps_trackers");
  function_6149b301ce19988b("ai_port_stealth_soldier_exit_ship", &function_60ad4d15cf45eb21);
  flag_set("flag_trackers_retrieved");

  if(scripts\cp\cp_checkpoint::function_cd10e09e02e4eb07("found_gps_and_rfid")) {
    level thread function_1aece41c84d663b6();
  }

  if(!function_371cf87e5f98b35d()) {
    function_fa3d2cb3590d579c("post_ship");
  }
}

function function_f26a09c79422e0a6() {
  objstruct = level.objectivestabledata["obj_get_manifest"];
  function_9ae658036ee9d914();
  flag_set("harbormaster_obj_completed");
  flag_set("flag_enter_hmo");
  objpoint = function_7a18da6e48b71c35("rfid_obj");
  objpoint notify("rfid_found");
  var_875fc427bc1f8e52 = getEnt("obj_manifest", "targetname");
  var_768c72b1f87fe34d = getEnt("rfid_prop", "targetname");
  var_875fc427bc1f8e52 hide();
  var_768c72b1f87fe34d hide();
  function_6149b301ce19988b("ai_port_stealth_soldier_wave2", &function_b3eb0cea070ea4f7);
  slot = level.player scripts\cp_mp\pickups::function_4967838290cb31b9(1);
  level.player scripts\cp\pickups::dropequipmentinslot(slot, undefined, undefined, undefined, 1);
  level.player scripts\cp_mp\equipment::giveequipment("equip_rfid", "secondary");
  flag_set("flag_manifest_retrieved");

  if(!function_b9b6a29eb16d53fb()) {
    function_fa3d2cb3590d579c("post_hm");
  }
}

function function_80db8d588b1bc8f0(var_a5314968c4bbe787, var_1f3cd7357e638ef6) {
  var_e5b495906761a6cc = function_424a7f20ead73979(self, var_a5314968c4bbe787);
  scripts\cp\cp_checkpoint::checkpoint_set(var_1f3cd7357e638ef6);
}

function function_b4e5977d53c26f49(objectivestruct, var_5dcdfd3a4eff9961) {
  veh_spawner = getStruct("convoy_01", "targetname");
  vehicle = level namespace_ba155a12c323dc5a::function_136d8a6a5c016d7e(veh_spawner, undefined, "p2p", undefined, 1);
  veh_spawner = getStruct("convoy_02", "targetname");
  vehicle2 = level namespace_ba155a12c323dc5a::function_136d8a6a5c016d7e(veh_spawner, undefined, "p2p", undefined, 1);
  wait 0.5;
  vehicle thread namespace_ba155a12c323dc5a::function_5a44f27c93a4bbff();
  vehicle2 thread namespace_ba155a12c323dc5a::function_5a44f27c93a4bbff();
  wait 4;
  veh_spawner = getStruct("exfiltruck_02", "targetname");
  var_c97601dffce9d4a5 = level namespace_ba155a12c323dc5a::function_136d8a6a5c016d7e(veh_spawner, undefined, "p2p", undefined, 1);
  wait 0.5;
  var_c97601dffce9d4a5 thread namespace_ba155a12c323dc5a::function_5a44f27c93a4bbff();
}

function function_4b71dee061a99c0a(objectivestruct, var_5dcdfd3a4eff9961) {
  objpoint = function_7a18da6e48b71c35("rfid_obj");
  objpoint thread namespace_9d6ed0911e2ddf09::function_dc3c295fcb6d7c77(6, "rfid_found", undefined, undefined, 1);
}

function function_a2ecdead97a15a9f(objectivestruct, var_5dcdfd3a4eff9961) {
  objpoint = function_7a18da6e48b71c35("rfid_obj");
  objpoint notify("rfid_found");
}

function function_b72ffe5023ab1d37(objectivestruct, var_5dcdfd3a4eff9961) {
  if(flag("container_obj_checkpoint_reached")) {
    return;
  }

  objpoint = getStruct("container_gear_location", "targetname");
  objpoint thread namespace_9d6ed0911e2ddf09::function_dc3c295fcb6d7c77(5, "gear_obj_complete", 100, 0, 1, undefined, undefined, undefined, undefined, undefined, undefined, 1);
}

function function_216dc945d41701f6(objectivestruct, var_5dcdfd3a4eff9961) {
  objpoint = function_7a18da6e48b71c35("container_gear_location");
  objpoint notify("gear_obj_complete");
}

function function_9e12c253737cd9ad() {
  function_216dc945d41701f6();
  flag_set("loadout_pile_used");
  flag_set("scan_gear_container");
  flag_set("container_obj_checkpoint_reached");
}

function function_243f47f9dd8f9eec(objectivestruct, var_5dcdfd3a4eff9961) {
  objpoint = function_7a18da6e48b71c35("ascender_pickup_marker");
  var_fc1dd9ea1f3f2a3b = objpoint.origin + (0, 0, 6);
  objpoint thread namespace_9d6ed0911e2ddf09::function_dc3c295fcb6d7c77(4, "ascender_obj_complete", 100, 0, 1, undefined, undefined, undefined, undefined, undefined, undefined, 1, 0, 0);
}

function function_7f2dd3b1b9a606d(objectivestruct, var_5dcdfd3a4eff9961) {
  objpoint = function_7a18da6e48b71c35("ascender_pickup_marker");
  objpoint notify("ascender_obj_complete");
}

function function_b8c6c1e2e05a57bd(objectivestruct, var_5dcdfd3a4eff9961) {
  thread function_f3f35f8a092179e7();
}

function function_b600c76fa2f4b7d5(objectivestruct, var_5dcdfd3a4eff9961) {
  objectivestruct thread function_64b73eb026e16c02("container_obj", "obj_container_oligarch_03", 8);
}

function function_4b0b8e6cec2dd1a7(objectivestruct, var_5dcdfd3a4eff9961) {
  objectivestruct thread function_64b73eb026e16c02("exfil_obj", "obj_final_container", 9);
}

function function_8d571169a6c4b409(objectivestruct, var_5dcdfd3a4eff9961) {
  objectivestruct thread function_7f31a6ebc9f2e12d("missile_container_hmo_found");
}

function function_1d9c167c9a03073b(objectivestruct, var_5dcdfd3a4eff9961) {
  objectivestruct thread function_7f31a6ebc9f2e12d("missile_container_boat_found");
}

function function_dfb2f011bbf44aa5(objectivestruct, var_5dcdfd3a4eff9961) {
  flag_set("container_port_searched");
}

function function_7f31a6ebc9f2e12d(var_840a1df6fda1d656) {
  objectivestruct = self;
  objectivestruct waittill("container_searched");
  flag_set(var_840a1df6fda1d656);
}

function function_64b73eb026e16c02(var_c6f00ce81aa6301a, var_cebef3df03cb596a, var_e3c52ed1616f8866) {
  level endon("game_ended");
  objectivestruct = self;
  flag_set("flag_container_found");
  objpoint = function_7a18da6e48b71c35(var_c6f00ce81aa6301a);
  objpoint thread namespace_9d6ed0911e2ddf09::function_dc3c295fcb6d7c77(var_e3c52ed1616f8866, "container_searched", 100, undefined, 1, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  var_f5363813e93bf745 = function_7a18da6e48b71c35(var_cebef3df03cb596a);
  var_e256d44437269626 = getEnt(var_f5363813e93bf745.target, "targetname");
  var_4a72aff912b4c999 = ter_op(function_9ec2f480552af944(level.player), "duration_short", "duration_none");
  var_8add2013ba5ea781 = createhintobject(var_e256d44437269626.origin, "HINT_BUTTON", undefined, &"CP_JUP_PORT/CONTAINER_LAUNCHER_INCAPACITATE", -10, var_4a72aff912b4c999, "show", 150, 360, 45, 25, undefined);
  var_8add2013ba5ea781 function_ae165af362de18a2();
  var_8add2013ba5ea781 function_dfb78b3e724ad620(0);
  var_8add2013ba5ea781 delete();

  if(!flag("missile_container_boat_found") && !flag("missile_container_hmo_found")) {
    thread namespace_58460674041d36d3::function_660435bebb8c190();
    var_e256d44437269626 function_dd9a8518ef3f14bb(var_f5363813e93bf745);
  }

  objpoint notify("container_searched");
  objectivestruct notify("container_searched");
}

function function_2c31d268382bedb0() {
  level endon("game_ended");

  while(true) {
    if(isDefined(level.player)) {
      wait 1;
      var_628421c39ea1308d = namespace_1170726b2799ea65::function_26cd112800a1c035();
      level.player namespace_9766820f5baa93fb::function_f4116328ce66a82d(var_628421c39ea1308d);
      return;
    }

    wait 0.1;
  }
}

function function_d525f1534752bfc7() {
  setDvar(@ "sm_sunsamplesizenear", 1.25);
  setDvar(@ "hash_7686fcb92ccc5edb", 4);
  setDvar(@ "r_umbraaccurateocclusionthreshold", 2048);
  setDvar(@ "hash_1dde331a8e0153d8", 8);
  setDvar(@ "hash_63eb1893f96ac98d", 8);
  setdvarifuninitialized(@ "hash_2d59deb63c029ea8", 0);
  flag_set("infil_complete");
}

function function_222bef19da9c23a4() {
  level endon("game_ended");
  level thread function_b21e26d146679276();
  level thread function_96c058a2a474ec31();
  level thread function_574bacf0402a5285();
  level thread function_2c31d268382bedb0();
  level thread function_da5332a95e48bf14();
  level thread function_62c7ea60de9485f2();
  level thread function_5294807233d17b4b();
  flag_wait("player_spawned_pre_loadout");
  flag_wait("ShipTower_Objectives_Intro");
  flag_wait("dungeon_intro_complete");
  flag_wait("first_gear_container_done");

  if(!flag("flag_manifest_retrieved") && !flag("flag_trackers_retrieved")) {
    flag_wait("vo_intro_finished");
    level delaythread(17, &function_f21e350927565786);
    level delaythread(9, &function_9d33a2df7c907fa4);
    wait 20;
  } else {
    level thread function_f21e350927565786();
    level thread function_9d33a2df7c907fa4();
  }

  flag_set("tacmap_tutorial_triggered");
  wait 1;
  level thread function_84e9b95ad30666e1();
  flag_wait_all("flag_trackers_retrieved", "flag_manifest_retrieved");
  level thread function_750423b75dfa7f0c();
  level thread function_52e4b6746e8bd8a2();
  wait 0.1;
  flag_set("container_obj_start");
}

function function_b21e26d146679276() {
  level endon("game_ended");
  var_d33b81beab8f5844 = getEnt("jltv_theatrics_sight", "targetname");

  if(!isDefined(var_d33b81beab8f5844)) {
    return;
  }

  var_d33b81beab8f5844 function_ae165af362de18a2();
  function_3b992a66c2e901bb(level.player, 0);
  function_ed9b1ddd2ec82dab(level.player, 0);
}

function function_750423b75dfa7f0c() {
  flag_wait("missile_container_boat_found");
  flag_wait("missile_container_hmo_found");
  flag_set("container_port_done");
}

function function_247c49697165ebb0() {
  function_d14fcd3a04720601("trig_cabbages");
  flag_set("flag_cabbage_go");
}

function function_98cfcc7bd2f1db6c() {
  level endon("game_ended");
  level.var_d39df167f3a996b0 = 1;
  veh_spawner = getStruct("outro_vehicle01", "targetname");
  var_829efeec586d1d1a = level namespace_ba155a12c323dc5a::function_136d8a6a5c016d7e(veh_spawner, undefined, "p2p");
  veh_spawner = getStruct("outro_vehicle02", "targetname");
  var_829efdec586d1ae7 = level namespace_ba155a12c323dc5a::function_136d8a6a5c016d7e(veh_spawner, undefined, "p2p");
  var_829efeec586d1d1a setscriptablepartstate("lights_front_cheap_bright", "on");
  var_829efdec586d1ae7 setscriptablepartstate("lights_front_cheap_bright", "on");

  if(istrue(function_28fbb3b695244b18("outro_heli01"))) {
    thread heli_reinforcements("outro_heli01", undefined, undefined, undefined, undefined, undefined, "infil_complete");
  }

  if(istrue(function_28fbb3b695244b18("outro_heli02"))) {
    thread heli_reinforcements("outro_heli02", undefined, undefined, undefined, undefined, undefined, "infil_complete");
  }

  thread function_f0dc3ba9ee6cec3d();
}

function function_fafb00a5eeaf4797() {
  level endon("game_ended");
  flag_wait("level_ready_for_script");
  truck = getEnt("escape_truck_1", "targetname");
  truck hide();
  truck = getEnt("escape_truck_2", "targetname");
  truck hide();
  truck = getEnt("escape_truck_3", "targetname");
  truck hide();
}

function function_f0dc3ba9ee6cec3d() {
  level endon("game_ended");
  level endon("infil_complete");
  level endon("flag_dungeon_exfil_complete");
  truck = getEnt("escape_truck_2", "targetname");
  container = getEnt("konni_exfil_container", "targetname");
  var_903344103f8edf9d = getEnt("konni_exfil_spreader", "targetname");
  var_4d4e0c565747e8f5 = getEnt("escape_truck_3", "targetname");
  var_4d4e0c565747e8f5 function_9a3c79d82c551ad3();
  truck show();
  var_4d4e0c565747e8f5 show();
  truck thread vehicle_crew("tag_light_lt", "iw9_mp_veh_jltv_seat_0_idle", (-25, 150, 160));
  truck thread vehicle_crew("tag_light_rt", "iw9_mp_veh_jltv_seat_1_idle", (25, 150, 160));
  var_4d4e0c565747e8f5 thread vehicle_crew("tag_light_lt", "iw9_mp_veh_jltv_seat_0_idle", (-25, 150, 160));
  var_4d4e0c565747e8f5 thread vehicle_crew("tag_light_rt", "iw9_mp_veh_jltv_seat_1_idle", (25, 150, 160));
  truck thread function_53a608059f72b98("vfx_jup_port_truck_exfil_lights");
  var_4d4e0c565747e8f5 thread function_53a608059f72b98("vfx_jup_port_truck_exfil_lights");
  var_ffeae030a70d4c64 = (container.origin[0], container.origin[1], truck.origin[2] + 100);
  var_3275b90cedf6fc37 = (var_903344103f8edf9d.origin[0], var_903344103f8edf9d.origin[1], truck.origin[2] + 440);
  target = (container.origin[0], container.origin[1], container.origin[2] - 300);
  container moveTo(target, 4.4, 3, 0);
  target = (var_903344103f8edf9d.origin[0], var_903344103f8edf9d.origin[1], var_903344103f8edf9d.origin[2] - 300);
  var_903344103f8edf9d moveTo(target, 4.4, 3, 0);
  wait 4.4;
  container moveTo(var_ffeae030a70d4c64, 3.5, 0, 3);
  var_903344103f8edf9d moveTo(var_3275b90cedf6fc37, 3.5, 0, 3);
  wait 3.75;
  var_903344103f8edf9d moveTo(var_3275b90cedf6fc37 + (0, 0, 300), 6, 3, 3);
  container linkTo(truck);
  var_4d4e0c565747e8f5 thread function_53a608059f72b98("vfx_jup_port_container_impact_dust");
  var_4d883155cfd7a9e5 = 0.6;
  var_4d883155cfd7a9e5 = getdvarfloat(@ "hash_9a13fac7183d938e", 0.6);
  wait var_4d883155cfd7a9e5;
  accel = 60;
  var_60e4ba9cd3c71ed8 = 600;
  var_51acb9b0479c8b88 = 3000;
  truck thread function_57c96c9fba6993d(accel, var_60e4ba9cd3c71ed8, var_51acb9b0479c8b88);
  var_db4f95ffc1a6c163 = 0.6;
  wait var_db4f95ffc1a6c163;
  var_4d4e0c565747e8f5 thread function_57c96c9fba6993d(accel, var_60e4ba9cd3c71ed8, var_51acb9b0479c8b88);
  truck waittill("done_accelerating");
}

function function_53a608059f72b98(vfxname) {
  level endon("game_ended");
  vehicle = self;
  var_6d2284a80b780dc = (0, 0, 0);
  offset = (0, 0, 0);

  if(false) {
    var_d6106a8cf23278f5 = spawn_tag_origin(var_6d2284a80b780dc, var_6d2284a80b780dc);
    wait 0.1;
    playFXOnTag(getfx(vfxname), var_d6106a8cf23278f5, "tag_origin");
    var_d6106a8cf23278f5 show();

    while(true) {
      if(isDefined(var_d6106a8cf23278f5)) {
        var_d6106a8cf23278f5.origin = vehicle.origin + offset;
        var_d6106a8cf23278f5.angles = vehicle.angles;

        sphere(var_d6106a8cf23278f5.origin, 10);
      } else {
        sphere(vehicle.origin, 10, (1, 0, 0));
      }

      waitframe();
    }

    return;
  }

  if(false) {
    wait 0.1;
    vehicle function_b7e9fd4b614b133(vfxname, [offset]);
    return;
  }

  if(false) {
    var_d6106a8cf23278f5 = spawn_tag_origin(var_6d2284a80b780dc, var_6d2284a80b780dc);
    wait 0.5;
    var_d6106a8cf23278f5 linkTo(vehicle, "tag_origin", offset, var_6d2284a80b780dc);
    playFXOnTag(getfx(vfxname), var_d6106a8cf23278f5, "tag_origin");
    var_d6106a8cf23278f5 show();
    return;
  }

  if(true) {
    wait 0.5;
    playFXOnTag(getfx(vfxname), vehicle, "tag_origin");
  }
}

function function_57c96c9fba6993d(accel, var_60e4ba9cd3c71ed8, distance) {
  self endon("death");
  self endon("done_colliding");
  base_time = gettime();
  var_a1be5c0260db98cd = self.origin;
  self scriptmodelplayanim("jup_port_exfil_talfa_extended_drive_forward");
  var_e4d5b9be132d47f4 = 0;
  var_e4d5b7be132d438e = 0;
  prev_time = base_time;

  while(true) {
    waitframe();
    cur_time = gettime();
    delta_t = (cur_time - prev_time) * 0.001;
    prev_time = cur_time;
    var_e4d5b9be132d47f4 += accel * delta_t;
    var_e4d5b7be132d438e += var_e4d5b9be132d47f4 * delta_t;
    self.origin = var_a1be5c0260db98cd + rotatevector((var_e4d5b7be132d438e, 0, 0), self.angles);

    if(isDefined(distance) && var_e4d5b7be132d438e > distance) {
      break;
    }

    if(isDefined(var_60e4ba9cd3c71ed8) && var_e4d5b9be132d47f4 > var_60e4ba9cd3c71ed8) {
      accel = 0;
      var_e4d5b9be132d47f4 = var_60e4ba9cd3c71ed8;
    }
  }

  self notify("done_accelerating");
}

function function_a3cb371b5cdbd137(times) {
  level endon("game_ended");
  level endon("infil_complete");
  level endon("flag_dungeon_exfil_complete");
  truck = self;
  truck scriptmodelplayanim("jup_port_exfil_talfa_extended_drive_forward");

  for(i = 0; i < truck.route.size; i++) {
    loc = truck.route[i];

    if(loc.duration < 0.25) {
      continue;
    }

    truck moveTo(loc.origin, times[i]);

    if(loc.var_3895e39af9db958d > 0) {
      truck rotateTo(loc.facing, loc.var_3895e39af9db958d);
    }

    wait times[i];
  }

  truck notify("exfil_route_ended");
}

function function_4b23613788096206() {
  level endon("game_ended");
  var_1045c3972c4b3e69 = getEnt("trig_ship_interior", "targetname");
  var_1045c3972c4b3e69 function_ae165af362de18a2();
  function_6149b301ce19988b("ai_ship_interior", &function_1f4e9000655f4504);
}

function function_d20bd5fae4e1abde(var_2a75b5a03d2a829) {
  level endon("game_ended");

  if(!istrue(var_2a75b5a03d2a829)) {
    var_e1c36ca816634061 = getEnt("trig_ai_machineshop", "targetname");
    var_e1c36ca816634061 function_ae165af362de18a2();
  }

  function_6149b301ce19988b("ai_machineshop", &function_a9c972b35c1d0532);
}

function function_24d319a6a83fd306(var_2a75b5a03d2a829) {
  level endon("game_ended");

  if(!istrue(var_2a75b5a03d2a829)) {
    var_87c16b6bb9fc1111 = getEnt("trig_ai_backroad", "targetname");
    var_87c16b6bb9fc1111 function_ae165af362de18a2();
  }

  function_6149b301ce19988b("ai_backroad", &function_f3ad327b2d1ac444);
}

function function_9d31e112d663eaf(var_2a75b5a03d2a829) {
  level endon("game_ended");

  if(!istrue(var_2a75b5a03d2a829)) {
    var_1dd087a2a1013320 = getEnt("trig_ai_shipentrance", "targetname");
    var_1dd087a2a1013320 function_ae165af362de18a2();
    function_6149b301ce19988b("ai_shipentrance", &function_7383ff22f18c51bb);
  }

  var_95ee1f8f57ca1ce4 = function_9abe9350cc74539e("ship_vehicle", &function_670dee0b0020368e, 1);
  var_95ee1f8f57ca1ce4 setscriptablepartstate("lights_front_cheap_bright", "on");
  var_95ee1f8f57ca1ce4 setscriptablepartstate("lights_back_cheap_bright", "on");
  var_95ee1f8f57ca1ce4 thread function_9e23991ff6710abf(15);
}

function function_718d9165cd66076a() {
  level endon("game_ended");
  var_3eaeb99b87f1654d = getEnt("trig_ai_utv", "targetname");
  var_3eaeb99b87f1654d function_ae165af362de18a2();
  function_6149b301ce19988b("ai_utv", &function_bd01c1f820a3dfde);
}

function function_52661d2d542b3827() {
  level endon("game_ended");
  var_1045c3972c4b3e69 = getEnt("trig_shipext_civilians", "targetname");
  var_1045c3972c4b3e69 function_ae165af362de18a2();

  for(i = 0; i < 9; i++) {
    function_eb52240866c35540("shipext_civ_test");
  }
}

function function_96c058a2a474ec31() {
  var_cb38d10f1e6836a1 = 0;

  if(function_b9b6a29eb16d53fb() || function_371cf87e5f98b35d()) {
    var_cb38d10f1e6836a1 = 1;
  } else {
    waitframe();
    weaponlist = level.player getweaponslistprimaries();
    var_cb38d10f1e6836a1 = 0;

    foreach(weapon in weaponlist) {
      if(!istrue(weapon.ismelee)) {
        var_cb38d10f1e6836a1 = 1;
        break;
      }
    }
  }

  if(var_cb38d10f1e6836a1) {
    flag_set("obj_gear_container_completed");
    flag_set("first_gear_container_done");
    flag_set("ShipTower_Objectives_Intro");
    level.player notify("first_gear_obj_complete");
    flag_wait("tacmap_tutorial_triggered");
    level thread function_c3c9f3a78b693fda();
    return;
  }

  level endon("game_ended");

  if(flag("container_obj_checkpoint_reached")) {
    return;
  }

  level endon("container_obj_checkpoint_reached");
  level thread function_64d4387de12ba6aa("entered_gear_container");
  flag_wait("vo_intro_finished");
  objstruct = level.objectivestabledata["obj_gear_container"];
  initializeobjective(objstruct, "obj_gear_container", "primary");
  startobjective(objstruct, "obj_gear_container", "primary");
  function_665d474ff040b446(["entered_gear_container", "flag_trackers_retrieved", "flag_manifest_retrieved"]);
  completeobjective(objstruct, "obj_gear_container", "primary");
  flag_set("first_gear_container_done");
  flag_wait("tacmap_tutorial_triggered");
  level thread function_c3c9f3a78b693fda();
}

function function_64d4387de12ba6aa(trigger_flag) {
  level endon("game_ended");
  level endon("first_gear_container_done");
  function_d14fcd3a04720601("ftue_container_gear");
  flag_set(trigger_flag);
}

function function_3370d044a19bff5d() {
  var_8cfa886455b88816 = getEnt("machine_container_vol", "targetname");

  if(!isDefined(var_8cfa886455b88816)) {
    return;
  }

  while(!level.player istouching(var_8cfa886455b88816)) {
    waitframe();
  }

  flag_set("containers_approached");
  level notify("containers_approached");
}

function function_5e93e50330c02761() {
  hmo_building_vol = getEnt("hmo_building_vol", "targetname");

  if(!isDefined(hmo_building_vol)) {
    return;
  }

  while(!level.player istouching(hmo_building_vol)) {
    waitframe();
  }

  flag_set("hmo_building_approached");
  level notify("hmo_building_approached");
}

function function_fb90a4164b018350() {
  ship_vol = getEnt("ship_vol", "targetname");

  if(!isDefined(ship_vol)) {
    return;
  }

  while(!level.player istouching(ship_vol)) {
    waitframe();
  }

  flag_set("ship_approached");
  level notify("ship_approached");
}

function function_d07ff6382810fa38() {
  level endon("game_ended");
  wait 3;
  function_6149b301ce19988b("ai_port_stealth_soldier_exit_ship", &function_60ad4d15cf45eb21);
  level thread function_c3c9f3a78b693fda();

  if(!function_371cf87e5f98b35d()) {
    function_fa3d2cb3590d579c("post_ship");
  }
}

function function_9d33a2df7c907fa4() {
  level endon("game_ended");

  if(function_b9b6a29eb16d53fb()) {
    return;
  }

  while(level.player istacmapactive()) {
    waitframe();
  }

  objstruct = level.objectivestabledata["obj_retrieve_trackers"];
  initializeobjective(objstruct, "obj_retrieve_trackers", "primary");
  startobjective(objstruct, "obj_retrieve_trackers", "primary");
  flag_wait("flag_trackers_retrieved");
  completeobjective(objstruct, "obj_retrieve_trackers", "primary");
}

function function_62c7ea60de9485f2() {
  if(function_b9b6a29eb16d53fb()) {
    thread function_d07ff6382810fa38();
    flag_set("flag_board_ship");
    flag_set("flag_enter_cabin");
    function_7203bd13c19d8bd3("gps_trackers");
    objpoint = function_7a18da6e48b71c35("gps_obj");
    objpoint notify("gps_picked");
    flag_set("flag_trackers_retrieved");
    return;
  }

  level endon("game_ended");
  level endon("boat_obj_flow_end_early");

  if(flag("boat_obj_checkpoint_reached")) {
    return;
  }

  thread function_4b23613788096206();
  function_d14fcd3a04720601("obj_board_ship");
  thread function_e7c8a34dd8500faf();
  flag_set("flag_board_ship");
  function_d14fcd3a04720601("exit_with_gps_trig");
  flag_set("flag_enter_cabin");
  wait 2;
  var_2298781e2b92c3a5 = getStruct("obj_gps_trackers", "targetname");

  if(isDefined(var_2298781e2b92c3a5)) {
    var_2298781e2b92c3a5.angles = (0, 0, 0);
    var_cffca1a9623f41d5 = var_2298781e2b92c3a5 create_interact(undefined, (0, 0, 0), 80, 360, &"CP_JUP_PORT/TAKE_TRACKERS");
    var_cffca1a9623f41d5 setuseholdduration(ter_op(function_9ec2f480552af944(level.player), "duration_short", "duration_none"));
    var_cffca1a9623f41d5 waittill("trigger");
    var_cffca1a9623f41d5 delete();
    level.player forceplaygestureviewmodel("ges_swipe");
    thread namespace_58460674041d36d3::function_9b215ae8b85ebec9();
    wait 0.4;
    function_7203bd13c19d8bd3("gps_trackers");

    if(function_371cf87e5f98b35d()) {
      scripts\cp\cp_checkpoint::checkpoint_set("found_gps_tracker");
      scripts\cp\cp_checkpoint::checkpoint_set("found_gps_and_rfid");
    } else {
      scripts\cp\cp_checkpoint::checkpoint_set("found_gps_tracker");
    }

    function_6149b301ce19988b("ai_port_stealth_soldier_exit_ship", &function_60ad4d15cf45eb21);
    flag_set("flag_trackers_retrieved");

    if(!flag("flag_manifest_retrieved")) {
      level thread function_c3c9f3a78b693fda();
    }

    level thread function_1aece41c84d663b6();

    if(!function_371cf87e5f98b35d()) {
      function_fa3d2cb3590d579c("post_ship");
    }
  }
}

function function_371cf87e5f98b35d() {
  return scripts\cp\cp_checkpoint::function_cd10e09e02e4eb07("found_rfid_reader") || scripts\cp\cp_checkpoint::function_cd10e09e02e4eb07("found_gps_and_rfid");
}

function function_b9b6a29eb16d53fb() {
  return scripts\cp\cp_checkpoint::function_cd10e09e02e4eb07("found_gps_tracker") || scripts\cp\cp_checkpoint::function_cd10e09e02e4eb07("found_gps_and_rfid");
}

function function_242890d92f9290fe() {
  level endon("game_ended");
  wait 3;
  function_6149b301ce19988b("ai_port_stealth_soldier_wave2", &function_b3eb0cea070ea4f7);
  level thread function_c3c9f3a78b693fda();

  if(!function_b9b6a29eb16d53fb()) {
    function_fa3d2cb3590d579c("post_hm");
  }
}

function function_f21e350927565786() {
  level endon("game_ended");

  if(function_371cf87e5f98b35d()) {
    return;
  }

  while(level.player istacmapactive()) {
    waitframe();
  }

  objstruct = level.objectivestabledata["obj_get_manifest"];
  initializeobjective(objstruct, "obj_get_manifest", "primary");
  startobjective(objstruct, "obj_get_manifest", "primary");
  flag_wait("flag_manifest_retrieved");
  completeobjective(objstruct, "obj_get_manifest", "primary");
}

function function_da5332a95e48bf14() {
  level endon("game_ended");

  if(function_371cf87e5f98b35d()) {
    thread function_242890d92f9290fe();
    var_768c72b1f87fe34d = getEnt("rfid_prop", "targetname");
    var_768c72b1f87fe34d hide();
    var_875fc427bc1f8e52 = getEnt("obj_manifest", "targetname");
    var_875fc427bc1f8e52 hide();
    flag_set("flag_manifest_retrieved");
    return;
  }

  wait 1;
  function_d14fcd3a04720601("obj_harbormaster_building");
  wait 1;
  thread function_48b318d78d9730ab();
  flag_set("flag_enter_hmo");
  function_d14fcd3a04720601("obj_find_manifest");
  wait 1;
  var_875fc427bc1f8e52 = getEnt("obj_manifest", "targetname");
  var_768c72b1f87fe34d = getEnt("rfid_prop", "targetname");
  var_cffca1a9623f41d5 = var_875fc427bc1f8e52 create_interact(undefined, (0, 0, 0), 80, 560, &"CP_JUP_PORT/TAKE_URANIUM_CORE");
  var_cffca1a9623f41d5 setuseholdduration(ter_op(function_9ec2f480552af944(level.player), "duration_short", "duration_none"));
  var_cffca1a9623f41d5 waittill("trigger");
  var_cffca1a9623f41d5 delete();
  level.player forceplaygestureviewmodel("ges_swipe");
  thread namespace_58460674041d36d3::function_9c78984eca8aba5();
  wait 0.3;
  var_875fc427bc1f8e52 hide();
  var_768c72b1f87fe34d hide();

  if(function_b9b6a29eb16d53fb()) {
    scripts\cp\cp_checkpoint::checkpoint_set("found_rfid_reader");
    scripts\cp\cp_checkpoint::checkpoint_set("found_gps_and_rfid");
  } else {
    scripts\cp\cp_checkpoint::checkpoint_set("found_rfid_reader");
  }

  function_6149b301ce19988b("ai_port_stealth_soldier_wave2", &function_b3eb0cea070ea4f7);
  flag_set("flag_manifest_retrieved");

  if(!flag("flag_trackers_retrieved")) {
    level thread function_c3c9f3a78b693fda();
  }

  if(!function_b9b6a29eb16d53fb()) {
    function_fa3d2cb3590d579c("post_hm");
  }
}

function function_48b318d78d9730ab() {
  level endon("game_ended");
  trig = getEnt("trig_riotshield", "targetname");
  trig function_ae165af362de18a2();
  flag_set("flag_third_floor");
  function_6149b301ce19988b("ai_hmo_riotshield", &function_1fc9ffd3a54f561);
}

function function_5c8f1b64260d0016(var_d5d330874963278c) {
  if(var_d5d330874963278c == "obj_missile_container_hmo") {
    if(istrue(function_28fbb3b695244b18("big_crane_heli"))) {
      thread heli_reinforcements("big_crane_heli", undefined, undefined, undefined, undefined, undefined, "heli_spawner_complete");
    }
  } else if(var_d5d330874963278c == "obj_missile_container_boat") {
    if(istrue(function_28fbb3b695244b18("wooden_containers_heli"))) {
      thread heli_reinforcements("wooden_containers_heli", undefined, undefined, undefined, undefined, undefined, "heli_spawner_complete");
    }
  }

  wait 1;
  flag_set("heli_spawner_complete");
}

function function_52e4b6746e8bd8a2() {
  level endon("game_ended");
  flag_wait("container_obj_start");
  thread function_a2b3ac4888e16cae();
  function_fa3d2cb3590d579c("containers");

  while(level.player istacmapactive()) {
    waitframe();
  }

  var_ce66ad896c57cf8c = level.objectivestabledata["obj_missile_containers"];
  initializeobjective(var_ce66ad896c57cf8c, "obj_missile_containers", "primary");
  startobjective(var_ce66ad896c57cf8c, "obj_missile_containers", "primary");
  objective_update("obj_missile_containers", undefined, undefined, undefined, undefined, 0);
  var_fac09d0e854abe11 = level.objectivestabledata["obj_missile_container_hmo"];
  initializeobjective(var_fac09d0e854abe11, "obj_missile_container_hmo", "primary");
  startobjective(var_fac09d0e854abe11, "obj_missile_container_hmo", "primary");
  var_2bd131052196d611 = level.objectivestabledata["obj_missile_container_boat"];
  initializeobjective(var_2bd131052196d611, "obj_missile_container_boat", "primary");
  startobjective(var_2bd131052196d611, "obj_missile_container_boat", "primary");
  var_ce4384db198f0f0a = flag_wait_either_return("missile_container_hmo_found", "missile_container_boat_found");
  next_flag = ter_op(var_ce4384db198f0f0a == "missile_container_hmo_found", "missile_container_boat_found", "missile_container_hmo_found");
  var_cebef3df03cb596a = ter_op(var_ce4384db198f0f0a == "missile_container_hmo_found", "obj_missile_container_hmo", "obj_missile_container_boat");
  objstruct = level.objectivestabledata[var_cebef3df03cb596a];
  completeobjective(objstruct, var_cebef3df03cb596a, "primary");
  flag_set("flag_container1");
  objective_update("obj_missile_containers", undefined, undefined, undefined, undefined, 1);
  function_5c8f1b64260d0016(var_cebef3df03cb596a);
  thread function_310c60ce62070d27();
  flag_wait(next_flag);
  var_cebef3df03cb596a = ter_op(next_flag == "missile_container_hmo_found", "obj_missile_container_hmo", "obj_missile_container_boat");
  objstruct = level.objectivestabledata[var_cebef3df03cb596a];
  completeobjective(objstruct, var_cebef3df03cb596a, "primary");
  objective_update("obj_missile_containers", undefined, undefined, undefined, undefined, 2);
  flag_set("flag_container2");
  flag_set("final_container_obj_start");
  scripts\cp\utility::function_3069b525e1c98faf("START");
  completeobjective(var_ce66ad896c57cf8c, "obj_missile_containers", "primary");
  flag_set("tracker_done");
  results = function_b30c77abba0c5b2d();
  level.playback_scene = results.anim_org;
  level.playback_scene scripts\common\scene::pre_stream(undefined, undefined, -1, "jup_port_tracker");
  function_71a51c41fcd32631();
  namespace_9766820f5baa93fb::function_cd054d9ba5a62557(0);
  function_c1cadb469d19553c();
  function_fa7c87f2585bd907(1);
}

function function_a2b3ac4888e16cae() {
  namespace_b96fa4d8ce10f926::function_ebd9a9c9789d200f();
}

function function_310c60ce62070d27() {
  namespace_b96fa4d8ce10f926::function_ebd9a9c9789d200f();
  setmusicstate("mx_port_exfil_end");
}

function function_5c316fb50cbe87ee() {
  thread function_a55c4179979af076();
  registersharedfunc("turret", "movingPlatformOnPlaced", &movingPlatformOnPlaced);
  level.var_c49fa55dcfd1d9f0 = spawnStruct();
  level.var_c49fa55dcfd1d9f0.cranes = [];
  function_6bb7a47e2eb26f3d("dock_crane", 1);
  function_6bb7a47e2eb26f3d("dock_crane2", 2);
  function_6bb7a47e2eb26f3d("dock_crane3", 3);
  var_acfd41b0b8be052e = getEntArray("crane_container", "script_noteworthy");
  var_662de88b40851b37 = getEnt("dock_crane_container_brush", "targetname");
  level.var_c49fa55dcfd1d9f0.containers = [];

  foreach(var_df1dbbf885b38501 in var_acfd41b0b8be052e) {
    container = function_3bffc7f36a37d996(var_df1dbbf885b38501, var_662de88b40851b37);

    if(isDefined(container)) {
      level.var_c49fa55dcfd1d9f0.containers[var_df1dbbf885b38501.targetname] = container;
      continue;
    }

    break;
  }

  level.var_c49fa55dcfd1d9f0.locations = [];
  var_95d45a8d992c2a90 = getStructArray("crane_target", "script_noteworthy");

  foreach(location in var_95d45a8d992c2a90) {
    level.var_c49fa55dcfd1d9f0.locations[location.targetname] = location;
  }

  thread function_25b9f4aada5f3a3e();
  function_fe819982ab65ce41();
  function_77256f0ea5bb14b();
  function_13e147241db40736("dock_crane");
  function_13e147241db40736("dock_crane2");
  function_13e147241db40736("dock_crane3");
  function_d2e1c734e27ad672("dock_crane", 1);
  function_d2e1c734e27ad672("dock_crane2", 1);
  function_d2e1c734e27ad672("dock_crane3", 1);
  flag_set("shipping_container_system_initialized");

  function_8c867b5137f48d9b();
}

function movingPlatformOnPlaced(ent, marker) {
  if(isDefined(ent.moving_platform)) {
    ent.origin = marker.location;
    ent linkTo(ent.moving_platform, "", ent.moving_platform_offset, ent.moving_platform_angles_offset);
  }
}

function function_fe819982ab65ce41() {
  level.var_c49fa55dcfd1d9f0.tasks = [];
  customspeed = (1, 1, 1);

  if(isDefined(level.var_c49fa55dcfd1d9f0.cranes["dock_crane"])) {
    function_dc9379df1e46d39b("dock_crane", "cont_07", "dest_12");
    function_dc9379df1e46d39b("dock_crane", "cont_08", "dest_09");
    function_dc9379df1e46d39b("dock_crane", "cont_09", "dest_07");
    function_dc9379df1e46d39b("dock_crane", "cont_10", "dest_10");
    function_dc9379df1e46d39b("dock_crane", "cont_11", "dest_08");
  }

  if(isDefined(level.var_c49fa55dcfd1d9f0.cranes["dock_crane2"])) {
    function_dc9379df1e46d39b("dock_crane2", "cont_13", "dest_13");
    function_dc9379df1e46d39b("dock_crane2", "cont_15", "dest_15");
    function_dc9379df1e46d39b("dock_crane2", "cont_14", "dest_14");
  }

  if(isDefined(level.var_c49fa55dcfd1d9f0.cranes["dock_crane3"])) {
    function_dc9379df1e46d39b("dock_crane3", "cont_02", "dest_02", customspeed);
    function_dc9379df1e46d39b("dock_crane3", "cont_03", "dest_03", customspeed);
    function_dc9379df1e46d39b("dock_crane3", "cont_04", "dest_04", customspeed);
    function_dc9379df1e46d39b("dock_crane3", "cont_06", "dest_06", customspeed);
  }
}

function function_dc9379df1e46d39b(var_1d65a1e531520677, var_e073308eace53999, destinationid, speedscale) {
  newtask = spawnStruct();
  newtask.var_1d65a1e531520677 = var_1d65a1e531520677;
  newtask.var_e073308eace53999 = var_e073308eace53999;
  newtask.destinationid = destinationid;
  newtask.speedscale = speedscale;
  level.var_c49fa55dcfd1d9f0.tasks[level.var_c49fa55dcfd1d9f0.tasks.size] = newtask;
}

function function_77256f0ea5bb14b() {
  if(!isDefined(level.var_c49fa55dcfd1d9f0.tasks)) {
    return;
  }

  foreach(var_14ca93c27cd35737 in level.var_c49fa55dcfd1d9f0.tasks) {
    if(isDefined(var_14ca93c27cd35737.var_1d65a1e531520677) && isDefined(level.var_c49fa55dcfd1d9f0.cranes[var_14ca93c27cd35737.var_1d65a1e531520677])) {
      if(isDefined(level.var_c49fa55dcfd1d9f0.containers[var_14ca93c27cd35737.var_e073308eace53999])) {
        if(isDefined(level.var_c49fa55dcfd1d9f0.locations[var_14ca93c27cd35737.destinationid])) {
          var_14ca93c27cd35737.targetposition = level.var_c49fa55dcfd1d9f0.locations[var_14ca93c27cd35737.destinationid].origin + rotatevector((48, -121, 0), level.var_c49fa55dcfd1d9f0.cranes[var_14ca93c27cd35737.var_1d65a1e531520677].base.angles);
          level.var_c49fa55dcfd1d9f0.cranes[var_14ca93c27cd35737.var_1d65a1e531520677].tasks[level.var_c49fa55dcfd1d9f0.cranes[var_14ca93c27cd35737.var_1d65a1e531520677].tasks.size] = var_14ca93c27cd35737;
        } else {
          iprintln("<dev string:x3b>" + var_14ca93c27cd35737.destinationid);
        }
      } else {
        iprintln("<dev string:x70>" + var_14ca93c27cd35737.var_e073308eace53999);
      }

      continue;
    }

    iprintln("<dev string:xa3>" + var_14ca93c27cd35737.var_1d65a1e531520677);
  }
}

function function_3bffc7f36a37d996(var_91ba8a5aa5eaa321, var_1b2557887d05f744) {
  var_a11c1582711f7c5a = undefined;

  if(isDefined(var_91ba8a5aa5eaa321)) {
    container = spawnStruct();
    container.base = var_91ba8a5aa5eaa321;
    collision = spawn("script_model", container.base.origin + (0, 0, 50));
    collision clonebrushmodeltoscriptmodel(var_1b2557887d05f744);
    collision.angles = var_91ba8a5aa5eaa321.angles;
    container.brush = collision;

    if(isDefined(container.base)) {
      container.brush linkTo(container.base, "tag_origin");
      var_a11c1582711f7c5a = container;
    }
  }

  return var_a11c1582711f7c5a;
}

function function_a55c4179979af076() {
  level endon("game_ended");
  var_d828e231daba809c = getEnt("cover_offladder", "targetname");
  var_d828e231daba809c hide();
  var_2464b7bc0b270540 = getEnt("cover_onladder", "targetname");
  var_3b6a5bbdf2125f35 = getEnt("cover_brushmodel", "targetname");
  flag_wait("container_obj_start");
  var_d828e231daba809c show();
  var_2464b7bc0b270540 hide();
  var_3b6a5bbdf2125f35.origin = (0, 0, -500);
}

function function_6bb7a47e2eb26f3d(var_b9eb7e4c2ca286c1, var_6eb01d718e5d21e7) {
  setdvarifuninitialized(@ "hash_218f231b9105a2a5", 160);
  setdvarifuninitialized(@ "hash_6c38894ee35707df", 75);
  setdvarifuninitialized(@ "hash_3b13f3c28684fc53", 75);
  setdvarifuninitialized(@ "hash_33a12a21f4c62bd6", 1);
  setdvarifuninitialized(@ "hash_e8f37e81fb49ce20", 1);
  setdvarifuninitialized(@ "hash_2d6249612a70444c", 1);
  setdvarifuninitialized(@ "hash_19dbbea8919dab2b", 1);
  setdvarifuninitialized(@ "hash_b5638033d14d7e4b", 1);
  setdvarifuninitialized(@ "hash_256e8ca13add5559", 1);
  var_1af108b88a0db0e3 = spawnStruct();
  var_1af108b88a0db0e3.debugname = var_b9eb7e4c2ca286c1;
  var_1af108b88a0db0e3.base = getEnt("crane_base_" + var_6eb01d718e5d21e7, "targetname");
  var_1af108b88a0db0e3.brush = getEnt("crane_base_" + var_6eb01d718e5d21e7 + "_brush", "targetname");
  var_1af108b88a0db0e3.var_6e9e44db04cefbb3 = rotatevector((0, 40, 0), var_1af108b88a0db0e3.base.angles);
  var_1af108b88a0db0e3.movespeed = 160;
  var_1af108b88a0db0e3.acceltime = 2;
  var_1af108b88a0db0e3.var_8906bcafcc3097b3 = 2;
  var_1af108b88a0db0e3.var_c75c732c12b30b89 = spawn("script_model", (0, 0, 0));
  var_1af108b88a0db0e3.var_c75c732c12b30b89 linkTo(var_1af108b88a0db0e3.base, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_1af108b88a0db0e3.var_c75c702c12b304f0 = spawn("script_model", (0, 0, 0));
  var_1af108b88a0db0e3.var_c75c702c12b304f0 linkTo(var_1af108b88a0db0e3.base, "tag_origin", (-924, 0, 0), (0, 0, 0));
  var_1af108b88a0db0e3.var_5512363bd2e0b4ca = getEntArray("crane" + var_6eb01d718e5d21e7 + "_rattle_sfx_group", "targetname");
  var_1af108b88a0db0e3.base setnodeploy(1);
  var_1af108b88a0db0e3.brush setnodeploy(1);
  function_b3a4077e08bb4275(var_1af108b88a0db0e3, var_6eb01d718e5d21e7);
  var_8df6de976b0aa46c = function_e3cbe8af73859214(var_b9eb7e4c2ca286c1);
  var_1af108b88a0db0e3.var_cf0a5829ae4a3fb8 = var_8df6de976b0aa46c.var_cf0a5829ae4a3fb8;
  var_1af108b88a0db0e3.var_33517458a1086486 = var_8df6de976b0aa46c.var_33517458a1086486;
  var_1af108b88a0db0e3.var_2624127f8494114a = var_8df6de976b0aa46c.var_2624127f8494114a;

  if(isDefined(var_1af108b88a0db0e3.base) && isDefined(var_1af108b88a0db0e3.brush)) {
    var_1af108b88a0db0e3.brush linkTo(var_1af108b88a0db0e3.base, "tag_origin");
    var_1af108b88a0db0e3.var_4e4816b43188dd92 = spawnStruct();
    var_1af108b88a0db0e3.var_4e4816b43188dd92.base = getEnt("crane_trolley_" + var_6eb01d718e5d21e7, "targetname");
    var_1af108b88a0db0e3.var_4e4816b43188dd92.brush = getEnt("crane_trolley_" + var_6eb01d718e5d21e7 + "_brush", "targetname");
    var_1af108b88a0db0e3.var_4e4816b43188dd92.var_6e9e44db04cefbb3 = rotatevector((-40, 0, 0), var_1af108b88a0db0e3.base.angles);
    var_1af108b88a0db0e3.var_4e4816b43188dd92.movespeed = 75;
    var_1af108b88a0db0e3.var_4e4816b43188dd92.acceltime = 1.5;
    var_1af108b88a0db0e3.var_4e4816b43188dd92.var_8906bcafcc3097b3 = 1.5;
    var_1af108b88a0db0e3.var_4e4816b43188dd92.base setnodeploy(1);
    var_1af108b88a0db0e3.var_4e4816b43188dd92.brush setnodeploy(1);
    var_cf89a893c872a31d = getEntArray("crane_trolley_" + var_6eb01d718e5d21e7 + "trolleytrigger", "targetname");

    foreach(triggerent in var_cf89a893c872a31d) {
      triggerent enablelinkTo();
      triggerent linkTo(var_1af108b88a0db0e3.var_4e4816b43188dd92.base, "tag_origin");
      triggerent thread function_7d45a562b65a00b0(var_1af108b88a0db0e3);
    }

    var_1af108b88a0db0e3.var_f2ac11f347d3d17 = spawnStruct();
    var_1af108b88a0db0e3.var_f2ac11f347d3d17.crane = var_1af108b88a0db0e3;
    var_1af108b88a0db0e3.var_f2ac11f347d3d17.var_cf89a893c872a31d = var_cf89a893c872a31d;

    if(isDefined(var_1af108b88a0db0e3.var_4e4816b43188dd92.base) && isDefined(var_1af108b88a0db0e3.var_4e4816b43188dd92.brush)) {
      var_1af108b88a0db0e3.var_4e4816b43188dd92.brush linkTo(var_1af108b88a0db0e3.var_4e4816b43188dd92.base, "tag_origin");
      var_1af108b88a0db0e3.var_4e4816b43188dd92.base linkTo(var_1af108b88a0db0e3.base, "tag_origin");
      var_1af108b88a0db0e3.rack = spawnStruct();
      var_1af108b88a0db0e3.rack.base = getEnt("crane_rack_" + var_6eb01d718e5d21e7, "targetname");
      var_1af108b88a0db0e3.rack.brush = getEnt("crane_rack_" + var_6eb01d718e5d21e7 + "_brush", "targetname");
      var_1af108b88a0db0e3.rack.var_6e9e44db04cefbb3 = rotatevector((0, 0, 381), var_1af108b88a0db0e3.base.angles);
      var_1af108b88a0db0e3.rack.movespeed = 75;
      var_1af108b88a0db0e3.rack.acceltime = 2;
      var_1af108b88a0db0e3.rack.var_8906bcafcc3097b3 = 2;
      var_1af108b88a0db0e3.rack.base setnodeploy(1);
      var_1af108b88a0db0e3.rack.brush setnodeploy(1);

      if(isDefined(var_1af108b88a0db0e3.rack.base)) {
        var_1af108b88a0db0e3.var_c8d662d9a01e77b0 = getEnt("crane_cable_" + var_6eb01d718e5d21e7, "targetname");
        var_1af108b88a0db0e3.var_1543e144c7016290 = getEnt("crane_cable_" + var_6eb01d718e5d21e7 + "_brush", "targetname");
        var_1af108b88a0db0e3.var_1543e144c7016290 linkTo(var_1af108b88a0db0e3.var_c8d662d9a01e77b0, "tag_origin");
        var_1af108b88a0db0e3.rack.brush linkTo(var_1af108b88a0db0e3.rack.base, "tag_origin");
        var_1af108b88a0db0e3.rack.base linkTo(var_1af108b88a0db0e3.var_4e4816b43188dd92.base, "tag_origin");
        var_1af108b88a0db0e3 thread function_a03b8306b5246018();
        var_1af108b88a0db0e3 thread function_4d344453627f42b4();
        var_ce71c0e533ffc9cd = getEntArray("crane_base_" + var_6eb01d718e5d21e7 + "_wheeltrigger", "targetname");

        foreach(triggerent in var_ce71c0e533ffc9cd) {
          triggerent enablelinkTo();
          triggerent linkTo(var_1af108b88a0db0e3.base, "tag_origin");
          triggerent thread function_3491be5eb03f1f3c(var_1af108b88a0db0e3);
          triggerent thread function_cff199526f7a7d98(var_1af108b88a0db0e3);
        }

        var_1af108b88a0db0e3.var_f2ac11f347d3d17.var_ce71c0e533ffc9cd = var_ce71c0e533ffc9cd;
        thread function_13047c84b04583fc(var_1af108b88a0db0e3, var_6eb01d718e5d21e7);
        var_1af108b88a0db0e3.tasks = [];
        var_1af108b88a0db0e3.taskindex = -1;
        level.var_c49fa55dcfd1d9f0.cranes[var_b9eb7e4c2ca286c1] = var_1af108b88a0db0e3;
        return;
      }
    }
  }

  iprintln("<dev string:xd2>" + var_b9eb7e4c2ca286c1);
}

function function_13047c84b04583fc(var_1af108b88a0db0e3, var_6eb01d718e5d21e7) {
  var_d83dd3c63aec7f92 = "vfx_dam_heli_headlight";
  flag_wait("dungeon_load_finished");
  var_1af108b88a0db0e3.rack.lights = [];
  locations = getStructArray("crane_rack_light_" + var_6eb01d718e5d21e7, "targetname");
}

function function_b3a4077e08bb4275(crane, var_6eb01d718e5d21e7) {
  crane.wheels = [];

  for(var_85f330bd4b0b4a8e = 0; var_85f330bd4b0b4a8e < 4; var_85f330bd4b0b4a8e++) {
    wheel = getEnt("crane_wheel_" + var_6eb01d718e5d21e7 + "_" + var_85f330bd4b0b4a8e + 1, "targetname");
    wheel.var_2a90003e28b66c13 = wheel.origin - crane.base.origin;
    crane.wheels[var_85f330bd4b0b4a8e] = wheel;
  }

  var_5f1effee8b594a61 = [];
  var_ce71c0e533ffc9cd = getEntArray("crane_base_" + var_6eb01d718e5d21e7 + "_wheeltrigger", "targetname");

  foreach(trigger in var_ce71c0e533ffc9cd) {
    var_5f1effee8b594a61[var_5f1effee8b594a61.size] = rotatevector(trigger.origin - crane.base.origin, crane.base.angles * -1);
  }

  var_fb5ca945b40311d8 = averagepoint(var_5f1effee8b594a61);
  var_24ff88444d350c6d = (0, 0, -20.125);
  crane.var_ee8996934a480419 = crane.base function_b7e9fd4b614b133("splashes_wheel_crane", [var_fb5ca945b40311d8], var_24ff88444d350c6d)[0];
  crane.var_f9abfa280b4dac42 = crane.base function_b7e9fd4b614b133("splashes_wheel_crane_reverse", [var_fb5ca945b40311d8], var_24ff88444d350c6d)[0];
  crane.var_ee8996934a480419 hide();
  crane.var_f9abfa280b4dac42 hide();
}

function function_d2e1c734e27ad672(var_1d65a1e531520677, repeat) {
  if(isDefined(level.var_c49fa55dcfd1d9f0.cranes[var_1d65a1e531520677])) {
    thread function_59d4e2f7b767439c(level.var_c49fa55dcfd1d9f0.cranes[var_1d65a1e531520677], repeat);
  }
}

function function_59d4e2f7b767439c(crane, repeat) {
  level endon("game_ended");
  crane endon("stop_crane");
  wait 10;

  if(isDefined(crane.tasks) && crane.tasks.size > 0) {
    crane.taskindex = 0;

    while(crane.taskindex < crane.tasks.size) {
      if(function_d0fce4d9c45fc998(crane, crane.tasks[crane.taskindex]) == 0) {
        break;
      }

      crane.taskindex++;

      if(crane.taskindex == crane.tasks.size && repeat) {
        crane.taskindex = 0;
      }
    }
  }
}

function function_87284ed2684fa43a(crane, targetposition) {
  crane endon("stop_crane");
  var_9d1dc6b2f4cac428 = crane.rack.base.origin - crane.rack.var_6e9e44db04cefbb3;
  crane.rack.base.origin = var_9d1dc6b2f4cac428;
  var_8773ed5b72ed004c = function_5848deded5403f49(crane.rack, 75, targetposition, 0);

  if(isDefined(var_8773ed5b72ed004c) && var_8773ed5b72ed004c.duration > 0) {
    function_46cd73d65e02521c(crane);
    function_580ef9eef94d18ad(crane, targetposition[2] - var_9d1dc6b2f4cac428[2], var_8773ed5b72ed004c);
    crane.rack.base unlink();
    crane.rack.base moveTo(var_8773ed5b72ed004c.targetposition, var_8773ed5b72ed004c.duration, var_8773ed5b72ed004c.acceltime, var_8773ed5b72ed004c.var_8906bcafcc3097b3);
    wait var_8773ed5b72ed004c.duration + 0.2;
    crane.rack.base linkTo(crane.var_4e4816b43188dd92.base, "tag_origin");
  }

  return var_9d1dc6b2f4cac428;
}

function function_580ef9eef94d18ad(crane, var_b4c12f2cc57431c2, var_8773ed5b72ed004c) {
  if(!isDefined(crane.var_c8d662d9a01e77b0)) {
    return;
  }

  var_b94e3943119917dd = 100;
  targetpos = (crane.var_c8d662d9a01e77b0.origin[0], crane.var_c8d662d9a01e77b0.origin[1], crane.var_c8d662d9a01e77b0.origin[2] + sign(var_b4c12f2cc57431c2) * var_b94e3943119917dd);
  crane.var_c8d662d9a01e77b0 moveTo(targetpos, var_8773ed5b72ed004c.duration, var_8773ed5b72ed004c.acceltime, var_8773ed5b72ed004c.var_8906bcafcc3097b3);
}

function function_d0a860e9bc6704c2(crane, targetposition) {
  crane endon("stop_crane");
  var_9b75563ff387e653 = function_5848deded5403f49(crane, 160, targetposition, 0.2);

  if(isDefined(var_9b75563ff387e653)) {
    var_1658a10e7ff6f2db = function_5848deded5403f49(crane.var_4e4816b43188dd92, 75, targetposition, 0);

    if(isDefined(var_1658a10e7ff6f2db)) {
      if(isDefined(crane.var_c8d662d9a01e77b0)) {
        crane.var_c8d662d9a01e77b0 linkTo(crane.rack.base, "tag_origin");
      }

      crane.var_4e4816b43188dd92.base unlink();
      duration = max(var_9b75563ff387e653.duration, var_1658a10e7ff6f2db.duration);

      if(crane.base.origin == var_9b75563ff387e653.targetposition) {
        var_a0ce3b6797088a11 = 0;
      } else {
        var_a0ce3b6797088a11 = 1;
      }

      if(duration > 0) {
        crane.base moveTo(var_9b75563ff387e653.targetposition, duration, var_9b75563ff387e653.acceltime, var_9b75563ff387e653.var_8906bcafcc3097b3);

        if(var_a0ce3b6797088a11 == 1) {
          foreach(wheel in crane.var_f2ac11f347d3d17.var_ce71c0e533ffc9cd) {
            wheel playLoopSound("sfx_port_crane_horizontal_movement");
            wheel playSound("sfx_port_crane_clangs_start");
          }

          foreach(item in crane.var_5512363bd2e0b4ca) {
            item playSound("emt_metal_panel_rattle");
          }

          crane.var_4e4816b43188dd92.base playSound("sfx_port_crane_motor_start");
          crane.var_4e4816b43188dd92.base playLoopSound("sfx_port_crane_motor_lp");
          crane.var_c75c732c12b30b89 playLoopSound("sfx_port_crane_bridge_rattles");
          crane.var_c75c702c12b304f0 playLoopSound("sfx_port_crane_bridge_rattles");
        }

        function_cd31268a889faf33(crane, var_9b75563ff387e653, duration);
        crane.var_4e4816b43188dd92.base moveTo(var_1658a10e7ff6f2db.targetposition + var_9b75563ff387e653.targetposition - crane.base.origin, duration, var_9b75563ff387e653.acceltime, var_9b75563ff387e653.var_8906bcafcc3097b3);
        var_5d7ed7eb0f6f144c = crane.base.origin - var_9b75563ff387e653.targetposition;
        var_2a78998f01ff7dcf = rotatevector(var_5d7ed7eb0f6f144c, (0, 0, 0) - crane.base.angles);
        movedistance = var_2a78998f01ff7dcf[1];

        if(movedistance > 1) {
          crane.var_ee8996934a480419 show();
        } else if(movedistance < -1) {
          crane.var_f9abfa280b4dac42 show();
        }

        crane thread function_71fdf4cea5a53f32(var_9b75563ff387e653.targetposition);
        crane thread function_725e5f1cf3870433(targetposition);
        wait duration + 0.2;
      }

      if(var_a0ce3b6797088a11 == 1) {
        foreach(wheel in crane.var_f2ac11f347d3d17.var_ce71c0e533ffc9cd) {
          wheel stoploopsound();
          wheel playSound("sfx_port_crane_horizontal_movement_stop");
          wheel playSound("sfx_port_crane_clangs_stop");
        }

        foreach(item in crane.var_5512363bd2e0b4ca) {
          item playSound("emt_metal_panel_rattle");
        }

        crane.var_c75c732c12b30b89 stoploopsound();
        crane.var_c75c702c12b304f0 stoploopsound();
        crane.var_4e4816b43188dd92.base playSound("sfx_port_crane_motor_stop");
        crane.var_4e4816b43188dd92.base stoploopsound("sfx_port_crane_motor_lp");
      }

      crane.var_4e4816b43188dd92.base linkTo(crane.base, "tag_origin");

      if(isDefined(crane.var_c8d662d9a01e77b0)) {
        crane.var_c8d662d9a01e77b0 unlink();
      }
    }
  }

  crane notify("crane_base_stopped_moving");
}

function function_71fdf4cea5a53f32(targetposition) {
  level endon("game_ended");
  self endon("crane_base_stopped_moving");

  while(true) {
    wait 0.15;
    var_5d7ed7eb0f6f144c = self.base.origin - targetposition;
    var_2a78998f01ff7dcf = rotatevector(var_5d7ed7eb0f6f144c, (0, 0, 0) - self.base.angles);
    movedistance = var_2a78998f01ff7dcf[1];

    if(abs(movedistance) >= 42.5) {
      continue;
    }

    self.var_ee8996934a480419 hide();
    self.var_f9abfa280b4dac42 hide();
    return;
  }
}

function function_725e5f1cf3870433(targetposition) {
  level endon("game_ended");
  self endon("crane_base_stopped_moving");

  while(true) {
    wait 1;
    function_b974728a21fa6d7b(self, targetposition, 25);
  }
}

function function_cd31268a889faf33(crane, var_9b75563ff387e653, duration) {
  crane endon("stop_crane");

  foreach(wheel in crane.wheels) {
    var_4d9e45c792d27e65 = wheel.origin - var_9b75563ff387e653.targetposition + wheel.var_2a90003e28b66c13;
    sign = ter_op(var_4d9e45c792d27e65[0] < 0 || var_4d9e45c792d27e65[1] > 0, 1, -1);
    var_16209941ebbefd44 = length(var_4d9e45c792d27e65) / 126.385 * 360 * sign;
    wheel moveTo(var_9b75563ff387e653.targetposition + wheel.var_2a90003e28b66c13, duration, var_9b75563ff387e653.acceltime, var_9b75563ff387e653.var_8906bcafcc3097b3);
    wheel rotateby((0, 0, var_16209941ebbefd44), duration, var_9b75563ff387e653.acceltime, var_9b75563ff387e653.var_8906bcafcc3097b3);
  }
}

function function_5848deded5403f49(var_779b5c6ac9e151a9, var_22612515996e2d87, targetposition, var_4ccffa20c73b36fd) {
  var_e6dd7fd6d6be511a = var_779b5c6ac9e151a9.base.origin;
  axisx = ter_op(var_779b5c6ac9e151a9.var_6e9e44db04cefbb3[0] != 0, targetposition[0] + var_779b5c6ac9e151a9.var_6e9e44db04cefbb3[0], var_e6dd7fd6d6be511a[0]);
  axisy = ter_op(var_779b5c6ac9e151a9.var_6e9e44db04cefbb3[1] != 0, targetposition[1] + var_779b5c6ac9e151a9.var_6e9e44db04cefbb3[1], var_e6dd7fd6d6be511a[1]);
  axisz = ter_op(var_779b5c6ac9e151a9.var_6e9e44db04cefbb3[2] != 0, targetposition[2] + var_779b5c6ac9e151a9.var_6e9e44db04cefbb3[2], var_e6dd7fd6d6be511a[2]);
  var_b5af8cc8024f53ce = (axisx, axisy, axisz);
  var_aeca4ea9387622cf = distance(var_e6dd7fd6d6be511a, targetposition);
  movementduration = var_aeca4ea9387622cf / var_22612515996e2d87;
  acceltime = var_4ccffa20c73b36fd * movementduration;
  var_8906bcafcc3097b3 = acceltime;
  var_8773ed5b72ed004c = spawnStruct();
  var_8773ed5b72ed004c.targetposition = var_b5af8cc8024f53ce;
  var_8773ed5b72ed004c.duration = movementduration;
  var_8773ed5b72ed004c.acceltime = acceltime;
  var_8773ed5b72ed004c.var_8906bcafcc3097b3 = var_8906bcafcc3097b3;
  return var_8773ed5b72ed004c;
}

function function_d0fce4d9c45fc998(crane, task) {
  crane endon("stop_crane");
  container = level.var_c49fa55dcfd1d9f0.containers[task.var_e073308eace53999];
  containerposition = container.base.origin + rotatevector((48, -121, 10), crane.base.angles);
  targetposition = task.targetposition + rotatevector((0, 0, 10), crane.base.angles);

  if(isDefined(task.var_1d65a1e531520677)) {
    var_8df6de976b0aa46c = function_e3cbe8af73859214(task.var_1d65a1e531520677);

    if(crane.var_cf0a5829ae4a3fb8 != var_8df6de976b0aa46c.var_cf0a5829ae4a3fb8) {
      crane.var_cf0a5829ae4a3fb8 = var_8df6de976b0aa46c.var_cf0a5829ae4a3fb8;
    }

    if(crane.var_33517458a1086486 != var_8df6de976b0aa46c.var_33517458a1086486) {
      crane.var_33517458a1086486 = var_8df6de976b0aa46c.var_33517458a1086486;
    }

    if(crane.var_2624127f8494114a != var_8df6de976b0aa46c.var_2624127f8494114a) {
      crane.var_2624127f8494114a = var_8df6de976b0aa46c.var_2624127f8494114a;
    }
  }

  speedscale = (crane.var_cf0a5829ae4a3fb8, crane.var_33517458a1086486, crane.var_2624127f8494114a);

  if(isDefined(task.speedscale)) {
    speedscale = task.speedscale;
  }

  function_78232e95328108b2(crane, containerposition);
  function_d0a860e9bc6704c2(crane, containerposition);
  function_b974728a21fa6d7b(crane, containerposition, 0);
  playsoundatpos(crane.rack.base.origin, "sfx_port_crane_lower_air_release");
  playsoundatpos(crane.rack.base.origin, "sfx_port_crane_warning_beep");
  crane.rack.base playLoopSound("sfx_port_crane_winch_down");
  crane.var_c8d662d9a01e77b0 playLoopSound("sfx_port_crane_winch_down_layer");
  crane.rack.base playsoundonmovingent("sfx_port_crane_winch_strains");
  var_289ef2a0cc522862 = function_87284ed2684fa43a(crane, containerposition);
  playsoundatpos(crane.rack.base.origin, "sfx_port_crane_grab");
  crane.rack.base stoploopsound();
  crane.var_c8d662d9a01e77b0 stoploopsound();
  crane.rack.base playSound("sfx_port_crane_winch_down_stop");
  container.base linkTo(crane.rack.base, "tag_origin");
  playsoundatpos(crane.rack.base.origin, "sfx_port_crane_container_vibrate");
  thread function_c5da8227720fd4be(task);
  container thread function_86c80cdb44f43097(crane, container);
  container thread function_36fcc7b9945e2c34(crane, container);
  crane.rack.base playLoopSound("sfx_port_crane_winch_up");
  crane.var_c8d662d9a01e77b0 playLoopSound("sfx_port_crane_winch_up_layer");
  crane.rack.base playsoundonmovingent("sfx_port_crane_winch_strains");
  function_87284ed2684fa43a(crane, var_289ef2a0cc522862);
  crane.rack.base stoploopsound();
  crane.var_c8d662d9a01e77b0 stoploopsound();
  crane.rack.base playSound("sfx_port_crane_winch_up_stop");
  function_7c5ae1e5754fa20d(task);
  function_78232e95328108b2(crane, targetposition);
  function_d0a860e9bc6704c2(crane, targetposition);
  function_b974728a21fa6d7b(crane, targetposition, 0);
  playsoundatpos(crane.rack.base.origin, "sfx_port_crane_lower_air_release");
  playsoundatpos(crane.rack.base.origin, "sfx_port_crane_warning_beep");
  crane.rack.base playLoopSound("sfx_port_crane_winch_down");
  crane.var_c8d662d9a01e77b0 playLoopSound("sfx_port_crane_winch_down_layer");
  crane.rack.base playsoundonmovingent("sfx_port_crane_winch_strains");
  var_289ef2a0cc522862 = function_87284ed2684fa43a(crane, targetposition);
  playsoundatpos(crane.rack.base.origin, "sfx_port_crane_container_release");
  crane.rack.base stoploopsound();
  crane.var_c8d662d9a01e77b0 stoploopsound();
  crane.rack.base playSound("sfx_port_crane_winch_up_stop");

  foreach(item in crane.var_5512363bd2e0b4ca) {
    item playSound("emt_metal_panel_rattle");
  }

  container.base unlink();
  crane.rack.base playLoopSound("sfx_port_crane_winch_up");
  crane.var_c8d662d9a01e77b0 playLoopSound("sfx_port_crane_winch_up_layer");
  crane.rack.base playsoundonmovingent("sfx_port_crane_winch_strains");
  function_87284ed2684fa43a(crane, var_289ef2a0cc522862);
  crane.rack.base stoploopsound();
  crane.var_c8d662d9a01e77b0 stoploopsound();
  crane.rack.base playSound("sfx_port_crane_winch_up_stop");
  container notify("container_placed");
  return true;
}

function function_78232e95328108b2(crane, targetposition) {
  crane endon("stop_crane");
  function_b974728a21fa6d7b(crane, targetposition, 25);
  wait 3;
}

function function_46cd73d65e02521c(crane) {
  crane endon("stop_crane");
  wait 1.5;
}

function function_b974728a21fa6d7b(crane, targetposition, var_6715ba95e552a100) {
  crane endon("stop_crane");

  if(!isDefined(crane) || !isDefined(targetposition)) {
    assertmsg("crane_create_nav_occlusion - invalid parameters");
    return;
  }

  if(!isDefined(crane.var_f2ac11f347d3d17)) {
    return;
  }

  if(!isDefined(var_6715ba95e552a100)) {
    var_6715ba95e552a100 = 0;
  }

  function_f05a92d5c4ba1970(crane);
  var_9b75563ff387e653 = function_5848deded5403f49(crane, 160, targetposition, 0.2);
  movedir = var_9b75563ff387e653.targetposition - crane.base.origin;
  var_c12bfb1a1dfbb95 = (0, 0, 0);
  var_26ce8b08954137aa = (0, 0, 0);
  var_444b265d17f5d25f = abs(movedir[0]);
  var_71b033d4cb8440e8 = abs(movedir[1]);

  if(var_444b265d17f5d25f > var_71b033d4cb8440e8) {
    dist = ter_op(var_444b265d17f5d25f > 250, 250, var_444b265d17f5d25f);
    var_c12bfb1a1dfbb95 = (dist, 0, 0);
    var_26ce8b08954137aa = (0, 1, 0);
  } else {
    dist = ter_op(var_71b033d4cb8440e8 > 250, 250, var_71b033d4cb8440e8);
    var_c12bfb1a1dfbb95 = (0, dist, 0);
    var_26ce8b08954137aa = (1, 0, 0);
  }

  movedir = vectorNormalize(movedir) * var_c12bfb1a1dfbb95;

  foreach(var_b04220a0eb2d038c in crane.var_f2ac11f347d3d17.var_ce71c0e533ffc9cd) {
    if(!isDefined(var_b04220a0eb2d038c.occluder)) {
      var_b04220a0eb2d038c.occluder = spawnStruct();
    }

    var_d677701c1ef1a5dc = var_b04220a0eb2d038c getboundshalfsize();
    var_b04220a0eb2d038c.occluder.origin = var_b04220a0eb2d038c.origin + movedir / 2;
    var_b04220a0eb2d038c.occluder.origin += vectorNormalize(movedir) * var_6715ba95e552a100 / 2;
    var_b04220a0eb2d038c.occluder.extents = var_d677701c1ef1a5dc * 2 + var_c12bfb1a1dfbb95;
    var_b04220a0eb2d038c.occluder.extents += vectorNormalize(var_c12bfb1a1dfbb95) * var_6715ba95e552a100 / 2;
    var_b04220a0eb2d038c.occluder.extents += var_26ce8b08954137aa * var_6715ba95e552a100 / 2;
    var_b04220a0eb2d038c.occluder.angles = var_b04220a0eb2d038c.angles;
    var_b04220a0eb2d038c.occluder.id = createnavobstaclebybounds(var_b04220a0eb2d038c.occluder.origin, var_b04220a0eb2d038c.occluder.extents / 2, var_b04220a0eb2d038c.occluder.angles, "bad_guys");
  }
}

function function_f05a92d5c4ba1970(crane) {
  if(!isDefined(crane.var_f2ac11f347d3d17)) {
    return;
  }

  foreach(var_b04220a0eb2d038c in crane.var_f2ac11f347d3d17.var_ce71c0e533ffc9cd) {
    if(isDefined(var_b04220a0eb2d038c.occluder) && isDefined(var_b04220a0eb2d038c.occluder.id)) {
      destroynavobstacle(var_b04220a0eb2d038c.occluder.id);
      var_b04220a0eb2d038c.occluder.id = undefined;
      var_b04220a0eb2d038c.occluder.origin = undefined;
      var_b04220a0eb2d038c.occluder.extents = undefined;
      var_b04220a0eb2d038c.occluder.angles = undefined;
    }
  }
}

function function_25b9f4aada5f3a3e() {
  level.var_e1abb873bd24367c = [];

  foreach(container in level.var_c49fa55dcfd1d9f0.containers) {
    var_f7b831fbb5210a03 = createnavobstaclebybounds(container.base.origin, (96, 261, 104) / 2, container.base.angles);
    level.var_e1abb873bd24367c[container.base.targetname] = var_f7b831fbb5210a03;
  }
}

function function_7c5ae1e5754fa20d(task) {
  container = level.var_c49fa55dcfd1d9f0.containers[task.var_e073308eace53999];
  var_28595f69b94cb104 = task.targetposition - rotatevector((48, -121, 0), level.var_c49fa55dcfd1d9f0.cranes[task.var_1d65a1e531520677].base.angles);
  var_f7b831fbb5210a03 = createnavobstaclebybounds(var_28595f69b94cb104, (96, 261, 104) / 2, container.base.angles);
  level.var_e1abb873bd24367c[task.var_e073308eace53999] = var_f7b831fbb5210a03;
}

function function_c5da8227720fd4be(task) {
  if(array_contains_key(level.var_e1abb873bd24367c, task.var_e073308eace53999)) {
    wait 2;
    destroynavobstacle(level.var_e1abb873bd24367c[task.var_e073308eace53999]);
  }
}

function function_1aece41c84d663b6() {
  level endon("game_ended");
  trigger = getEnt("exit_with_gps_trig", "targetname");
  assert(isDefined(trigger));
  trigger function_ae165af362de18a2();
  flag_set("vo_missile_container_truck");
  var_19c967da531c0731 = getEnt("escape_truck_1", "targetname");
  truck = var_19c967da531c0731 function_3d743db5ffe40ff5();
  container = var_19c967da531c0731 function_9a3c79d82c551ad3();
  level.var_f90218e659db52ec = [truck, container, var_19c967da531c0731];
  container childthread function_a7ec227d179a78a();
  var_19c967da531c0731 show();
  turn_rate = 0.5;
  var_86c320d267e05dbf = 500;
  accel_time = 4;

  if(!isDefined(truck.route)) {
    truck function_f9031efeb0ff63ee("escape_path_1", var_86c320d267e05dbf, turn_rate, accel_time);
  }

  truck childthread function_c075187fa91e017e();
  var_f295c1eaca203afe = getEnt("exit_fence_a", "targetname");
  var_f295c0eaca2038cb = getEnt("exit_fence_b", "targetname");
  var_c2067e6121b3b894 = getEnt("exit_wheels_a", "targetname");
  var_c206816121b3bf2d = getEnt("exit_wheels_b", "targetname");
  var_f295c1eaca203afe moveTo(var_f295c1eaca203afe.origin + (100, 0, 0), 1);
  var_c2067e6121b3b894 moveTo(var_c2067e6121b3b894.origin + (100, 0, 0), 1);
  var_f295c0eaca2038cb moveTo(var_f295c0eaca2038cb.origin - (100, 0, 0), 1);
  var_c206816121b3bf2d moveTo(var_c206816121b3bf2d.origin - (100, 0, 0), 1);
  thread namespace_58460674041d36d3::function_f48c143c8cecb770(truck);
  wait 20;
  var_f295c1eaca203afe moveTo(var_f295c1eaca203afe.origin - (100, 0, 0), 10, 3, 3);
  var_c2067e6121b3b894 moveTo(var_c2067e6121b3b894.origin - (100, 0, 0), 10, 3, 3);
  var_f295c0eaca2038cb moveTo(var_f295c0eaca2038cb.origin + (100, 0, 0), 10, 3, 3);
  var_c206816121b3bf2d moveTo(var_c206816121b3bf2d.origin + (100, 0, 0), 10, 3, 3);
  truck notify("done_colliding");
  truck waittill("route_ended");
  var_19c967da531c0731 unlink();
  truck delete();
  container delete();
}

function function_a7ec227d179a78a() {
  self endon("done_colliding");
  self endon("death");
  truck = self;
  truck physics_registerforcollisioncallback();

  while(true) {
    self waittill("collision", body0, body1, flag0, flag1, position, normal, impulse, ent);

    if(ent scripts\cp_mp\vehicles\vehicle::isvehicle() && !istrue(ent.isdestroyed) && !istrue(ent.isvehiclehusk)) {
      ent scripts\cp_mp\vehicles\vehicle::vehicle_explode();
    }
  }
}

function function_9a3c79d82c551ad3() {
  truck = self;
  var_1916952f44cb8dae = rotatevector((-180, 0, 100), truck.angles);
  container = spawn("script_model", truck.origin + var_1916952f44cb8dae);
  container.angles = angleclamp180(truck.angles + (0, 90, 0));
  container setModel("storage_shipping_container_40ft_colliding");
  container linkTo(truck);
  return container;
}

function function_3d743db5ffe40ff5() {
  var_19c967da531c0731 = self;
  var_f0926091fa330586 = rotatevector((-200, 0, 0), var_19c967da531c0731.angles);
  truck = var_19c967da531c0731 spawn_tag_origin(var_19c967da531c0731.origin + var_f0926091fa330586, var_19c967da531c0731.angles);
  var_19c967da531c0731 linkTo(truck, "tag_origin");
  return truck;
}

function function_c075187fa91e017e() {
  level endon("game_ended");
  truck = self;
  truck scriptmodelplayanim("jup_port_exfil_talfa_extended_drive_forward");

  foreach(loc in truck.route) {
    if(loc.duration < 0.25) {
      continue;
    }

    if(isDefined(loc.accel_time)) {
      truck moveTo(loc.var_a512b96448d21c80, loc.accel_time, loc.accel_time);
      wait loc.accel_time;
    }

    truck moveTo(loc.origin, loc.duration);

    if(loc.var_3895e39af9db958d > 0) {
      truck rotateTo(loc.facing, loc.var_3895e39af9db958d);
    }

    wait loc.duration;
  }

  self notify("route_ended");
}

function function_f9031efeb0ff63ee(var_230c82597b473804, var_86c320d267e05dbf, turn_rate, accel_time) {
  truck = self;
  truck.route = [];
  route = getStruct(var_230c82597b473804, "targetname");

  if(isDefined(route)) {
    var_f46ed9fd4394c1fa = isDefined(accel_time);
    var_862c223c63ea7699 = truck.origin;
    locs = function_4b6780152e7fc544(route, 1);

    for(idx = 0; idx < locs.size; idx++) {
      loc = locs[idx];
      loc.duration = distance2d(loc.origin, var_862c223c63ea7699) / var_86c320d267e05dbf;

      if(loc.duration < 0.25) {
        continue;
      }

      var_3d9e474e17bdec4e = loc.origin - var_862c223c63ea7699;
      var_1584a380d2a73443 = vectorNormalize(var_3d9e474e17bdec4e);
      new_right = vectorcross(var_1584a380d2a73443, (0, 0, 1));
      new_up = vectorcross(new_right, var_1584a380d2a73443);
      loc.facing = axistoangles(var_1584a380d2a73443, new_right, (0, 0, 1));
      loc.var_3895e39af9db958d = min(loc.duration, turn_rate);

      if(var_f46ed9fd4394c1fa) {
        if(loc.duration > accel_time) {
          dist = accel_time * var_86c320d267e05dbf / 2;
          loc.var_a512b96448d21c80 = var_862c223c63ea7699 + var_1584a380d2a73443 * dist;
          loc.accel_time = accel_time;
          loc.duration -= dist / var_86c320d267e05dbf;
        } else {
          iprintln("<dev string:xf0>" + var_230c82597b473804 + "<dev string:x107>");
          println("<dev string:xf0>" + var_230c82597b473804 + "<dev string:x107>");
        }

        var_f46ed9fd4394c1fa = 0;
      }

      var_862c223c63ea7699 = loc.origin;
    }

    truck.route = locs;
  }
}

function function_fb457f7cdf0ac39e() {
  while(!isDefined(level.stealth)) {
    waitframe();
  }

  level scripts\cp_mp\stealth\manager::function_7e4ce548f5795c03();
  setomnvar("ai_fulllight", 0.005);
  setomnvar("ai_nolight", 0.0013);
  hiddenranges["prone"] = 4096;
  hiddenranges["crouch"] = 6000;
  hiddenranges["stand"] = 8000;
  spottedranges["prone"] = 4096;
  spottedranges["crouch"] = 6000;
  spottedranges["stand"] = 8000;
  var_2d290a16bb162dac["prone"] = 200;
  var_2d290a16bb162dac["crouch"] = 400;
  var_2d290a16bb162dac["stand"] = 600;
  var_fe2945cff60b4639["prone"] = 200;
  var_fe2945cff60b4639["crouch"] = 600;
  var_fe2945cff60b4639["stand"] = 800;
  var_b6b642cbeff52b88["prone"] = 150;
  var_b6b642cbeff52b88["crouch"] = 350;
  var_b6b642cbeff52b88["stand"] = 600;
  hiddenranges["shadow_prone"] = 0.05;
  hiddenranges["shadow_crouch"] = 0.05;
  hiddenranges["shadow_stand"] = 0.3;
  var_d0f35fc0a5c3df79["prone"] = 250;
  var_d0f35fc0a5c3df79["crouch"] = 1000;
  var_d0f35fc0a5c3df79["stand"] = 1800;
  spottedranges["shadow_prone"] = 0.01;
  spottedranges["shadow_crouch"] = 0.02;
  spottedranges["shadow_stand"] = 0.38;
  var_8f3f480583606401["prone"] = 1.1;
  var_8f3f480583606401["crouch"] = 1.15;
  var_8f3f480583606401["stand"] = 1.2;
  scripts\stealth\utility::set_detect_ranges(hiddenranges, spottedranges, var_8f3f480583606401);
  scripts\stealth\utility::set_min_detect_range_darkness(var_b6b642cbeff52b88, var_d0f35fc0a5c3df79);
  level.stealth.override_damage_auto_range = 320;
  level.stealth.override_damage_sight_range = 1200;
  function_531194f673a06de5(0);
  function_d5823c94e8131ea6(1);
  level.valstruct val::set("level", "ai_eventlist", "jup_port_aieventlist");
  flag_set("stealth_ranges_initialized");
}

function function_4380ce742d375bba() {
  flag_wait("stealth_ranges_initialized");
  flag_wait("flag_dungeon_intro_complete");
  level.var_7a9f066f79bed633 = &function_f99d747ae629971e;
  function_6149b301ce19988b("ai_port_stealth_soldier", &function_bbdc474f04873089, undefined, undefined, undefined, undefined);
  function_6149b301ce19988b("ai_port_stealth_soldier_sprinters", &function_649859d32e754f84, undefined, undefined, undefined, undefined);
  thread function_f15ce53d05d9a062();
  veh_spawner = getStruct("parked_vehicle01", "targetname");
  var_446e827ebe3505a1 = level namespace_ba155a12c323dc5a::function_136d8a6a5c016d7e(veh_spawner, undefined, "p2p", undefined, 1);
  veh_spawner = getStruct("parked_vehicle02", "targetname");
  var_446e7f7ebe34ff08 = level namespace_ba155a12c323dc5a::function_136d8a6a5c016d7e(veh_spawner, undefined, "p2p", undefined, 1);
  veh_spawner = getStruct("parked_vehicle03", "targetname");
  var_446e807ebe35013b = level namespace_ba155a12c323dc5a::function_136d8a6a5c016d7e(veh_spawner, undefined, "p2p", undefined, 1);
  spawner = getStruct("utv_spawner", "targetname");
  vehicle = level namespace_ba155a12c323dc5a::function_136d8a6a5c016d7e(spawner, undefined, "none");
  vehicle vehicle_settopspeedforward(40);
  level.var_42121fc7776918bd = vehicle;
  var_3f3ebeca69062f0e = function_371cf87e5f98b35d() || function_b9b6a29eb16d53fb();

  if(var_3f3ebeca69062f0e == 0) {
    if(istrue(function_28fbb3b695244b18("heli_spawner_01"))) {
      thread heli_reinforcements("heli_spawner_01", undefined, undefined, undefined, undefined, undefined, "infil_complete");
    }

    if(istrue(function_28fbb3b695244b18("heli_spawner_02"))) {
      level.var_15d88c3079795174 = heli_reinforcements("heli_spawner_02", undefined, undefined, undefined, undefined, undefined, "infil_complete");
    }
  } else {
    function_6149b301ce19988b("reinforcements_heli_spawner_01", &function_a9c972b35c1d0532);
    function_6149b301ce19988b("reinforcements_heli_spawner_02", &function_a9c972b35c1d0532);
  }

  thread namespace_58460674041d36d3::function_7fc844314a043b63();
  thread function_518d3b9b6ff2ddf6();
  wait 1.5;
  thread function_4fb6c81d40937664();
  thread function_52661d2d542b3827();
  thread function_d20bd5fae4e1abde(var_3f3ebeca69062f0e);
  thread function_24d319a6a83fd306(var_3f3ebeca69062f0e);
  thread function_9d31e112d663eaf(function_b9b6a29eb16d53fb());
  thread function_718d9165cd66076a();
}

function function_a0196df25e1b3342(targetrange) {
  level endon("game_ended");
  self endon("death");
  level.var_6afba8c301f3d292 = 0;
  thread function_cc4d842a6ba462d4();
  wait 1;
  var_ae5e93d53697186d = self.riders[0];
  var_ae5e93d53697186d.ignoreme = 1;
  var_ca30e16c4a4d3956 = getStruct("jltv_aim_target_1", "targetname");
  var_ca30e06c4a4d3723 = getStruct("jltv_aim_target_2", "targetname");
  level.var_4c5b21bc59bf25b7 = 0;
  targetent = spawn_tag_origin();
  targetent.origin = var_ca30e16c4a4d3956.origin;
  var_ae5e93d53697186d asmsetstate(var_ae5e93d53697186d.asmname, "vehicle_idle_combat_shoot");
  var_ae5e93d53697186d.ignoreall = 1;
  thread function_9b31eda9cff8f87a();
  var_c6bc9a5fc6273a89 = undefined;
  var_ad27a8b62baf5289 = 0;
  var_ad27a5b62baf4bf0 = 0;
  var_dacc5331f6585635 = 0;

  while(level.var_4c5b21bc59bf25b7 >= 0 && !level.var_6afba8c301f3d292) {
    var_8ef764e1d374af88 = 0;

    if(level.var_4c5b21bc59bf25b7 == 1) {
      if(var_ad27a8b62baf5289 >= level.var_80fffd99d53ccf75.size) {
        var_c6bc9a5fc6273a89 = undefined;
      } else {
        var_c6bc9a5fc6273a89 = level.var_80fffd99d53ccf75[var_ad27a8b62baf5289];
        var_8ef764e1d374af88 = 1;
      }
    } else if(level.var_4c5b21bc59bf25b7 == 2) {
      if(var_ad27a5b62baf4bf0 >= level.var_80fffa99d53cc8dc.size) {
        var_c6bc9a5fc6273a89 = undefined;
      } else {
        var_c6bc9a5fc6273a89 = level.var_80fffa99d53cc8dc[var_ad27a5b62baf4bf0];
      }
    } else {
      var_c6bc9a5fc6273a89 = undefined;
    }

    if(isDefined(var_c6bc9a5fc6273a89)) {
      offset = vectorNormalize(var_c6bc9a5fc6273a89.origin - var_ae5e93d53697186d.origin) * 100;
      targetent.origin = var_c6bc9a5fc6273a89.origin + offset + (0, 0, 30);
      var_ae5e93d53697186d setaimangles(var_ae5e93d53697186d.origin, targetent.origin, 1, (0, 0, 0), 0, 0, 0);

      if(level.var_4c5b21bc59bf25b7 == 1) {
        var_ad27a8b62baf5289++;
      } else {
        var_ad27a5b62baf4bf0++;
      }
    } else {
      if(level.var_4c5b21bc59bf25b7 <= 1) {
        targetent.origin = var_ca30e16c4a4d3956.origin;
      } else if(level.var_4c5b21bc59bf25b7 == 2) {
        targetent.origin = var_ca30e06c4a4d3723.origin;
      }

      var_ae5e93d53697186d setaimangles(var_ae5e93d53697186d.origin, targetent.origin, 1, (0, 0, 0), 0, 0, 0);
    }

    var_9b902feb1488d155 = randomintrange(5, 9);

    for(i = 0; i < var_9b902feb1488d155; i++) {
      var_ae5e93d53697186d shoot(1, targetent, 0, 0, 0);
      wait 0.1;
    }

    if(var_8ef764e1d374af88 == 1 && isalive(var_c6bc9a5fc6273a89) && isalive(var_ae5e93d53697186d)) {
      var_c6bc9a5fc6273a89 kill(var_ae5e93d53697186d.origin, var_ae5e93d53697186d);
    }

    wait randomfloatrange(0.15, 0.65);
  }

  iprintln("<dev string:x129>");

  var_d060820f5e2c632 = function_e3b3f0128f632da5(var_ca30e16c4a4d3956.origin, 3000);

  for(i = 0; i < var_d060820f5e2c632.size; i++) {
    function_9e7521713ce877b1(var_d060820f5e2c632[i], 1);
  }

  function_3b992a66c2e901bb(level.player, 0);
  function_ed9b1ddd2ec82dab(level.player, 0);
  wait 2;
  level.player scripts\cp_mp\stealth\utility::function_378625a93d79fdc2();
  var_ae5e93d53697186d.ignoreme = 0;
  var_ae5e93d53697186d.ignoreall = 0;
  self notify("jltv_intro_complete");
}

function function_9b31eda9cff8f87a() {
  level endon("game_ended");
  self endon("death");
  self endon("jltv_intro_complete");
  wait 0.5;
  level.var_4c5b21bc59bf25b7 = 1;
  wait 4;
  level.var_4c5b21bc59bf25b7 = 2;

  iprintln("<dev string:x13f>");

  wait 4;
  level.var_4c5b21bc59bf25b7 = -1;
}

function function_cc4d842a6ba462d4() {
  level endon("game_ended");
  self endon("death");
  self endon("jltv_intro_complete");
  self waittill("jltv_stop_patrol");
  level.var_6afba8c301f3d292 = 1;
}

function function_89bff85d73f8f704(spawner_targetname) {
  scripts\cp\cp_spawning_util::register_module_init_func(spawner_targetname);
}

function function_f99d747ae629971e(group_name, func) {
  thread function_f98463d49e2f9067();
}

function function_670dee0b0020368e(group_name, func) {
  thread function_f98463d49e2f9067();

  if(isDefined(self.spawner.veh)) {
    self.spawner.veh scripts\cp_mp\vehicles\vehicle::function_f92faaaf5c5077c6([self], 1);
  }
}

function function_f98463d49e2f9067(var_4f855452f4b35b26, override_damage_sight_range) {
  var_4f855452f4b35b26 = default_to(var_4f855452f4b35b26, "jup_sandbox_dark");
  function_6afcdc96a6ce9a56(var_4f855452f4b35b26, undefined, override_damage_sight_range);
  level.agent_funcs[self.unittype]["on_damaged"] = &function_a963b0c7d5cfeea2;
  thread function_864cab28ac2178c3();
  namespace_a0852b262a68d01::function_fac67371e80874db();
  function_76e85d0aa8db406d("vfx_flashlight_npc_perf_short");

  if(isDefined(self.script_parameters)) {
    self.var_55cc71192b8f1931 = strtok(self.script_parameters, ", ");

    foreach(element in self.var_55cc71192b8f1931) {
      var_413bf7c49082995b = ["sprinter_", "sprinters", "sprinter"];

      foreach(var_10dc9b447f989286 in var_413bf7c49082995b) {
        if(string_starts_with(element, var_10dc9b447f989286)) {
          var_8cb5545a23258134 = function_2e84a570d6af300a(element, var_10dc9b447f989286);

          if(function_1fb1cb439aa1e23c(var_8cb5545a23258134)) {
            self.var_3aa342a8b045cbce = int(scripts\cp\utility\script::stringtofloat(var_8cb5545a23258134));
            break;
          }
        }
      }
    }
  }

  if(getdvarint(@ "hash_d93dae2abf31114b", 1) != 0) {
    level thread function_35f1f9881a1607a1(self);
  }

  thread function_51fffc5c3cb2c0be();
  self.var_7bd1c0edbaafb6e0 = "alert";
  function_7efd649df0968c26(self, self.var_3aa342a8b045cbce);
}

function ship_board_approach() {
  port_ship_vol = getEnt("port_ship_vol", "targetname");

  if(!isDefined(port_ship_vol)) {
    return;
  }

  while(!level.player istouching(port_ship_vol)) {
    waitframe();
  }

  flag_set("ship_board_approach");
  level notify("ship_board_approach");
}

function function_631a16b9a3413704(group_name, func) {
  thread function_f98463d49e2f9067();
}

function function_341a16b14ffeee46(group_name, func) {
  var_b8f2440e43198535 = "jup_sandbox_sniper";
  var_99f07fbd125196c6 = 8192;
  thread function_f98463d49e2f9067(var_b8f2440e43198535, var_99f07fbd125196c6);
}

function function_7383ff22f18c51bb(group_name, func) {
  thread function_f98463d49e2f9067();
}

function function_1f4e9000655f4504(group_name, func) {
  thread function_f98463d49e2f9067();
}

function function_bbdc474f04873089(group_name, func) {
  thread function_f98463d49e2f9067();
}

function function_649859d32e754f84(group_name, func) {
  thread function_f98463d49e2f9067();
}

function function_60ad4d15cf45eb21(group_name, func) {
  thread function_f98463d49e2f9067();
}

function function_5c715719c8085439(group_name, func) {
  thread function_f98463d49e2f9067();
}

function function_b3eb0cea070ea4f7(group_name, func) {
  thread function_f98463d49e2f9067();
}

function function_ec7c4200ce17c713(group_name, func) {
  thread function_f98463d49e2f9067();
}

function function_1fc9ffd3a54f561(group_name, func) {
  thread function_f98463d49e2f9067();
}

function function_151716e26f89721(group_name, func) {
  thread function_f98463d49e2f9067();
}

function function_a9c972b35c1d0532(group_name, func) {
  thread function_f98463d49e2f9067();
}

function function_f3ad327b2d1ac444(group_name, func) {
  thread function_f98463d49e2f9067();
}

function function_bd01c1f820a3dfde(group_name, func) {
  thread function_f98463d49e2f9067();
}

function function_7efd649df0968c26(agent, var_e531293848a16d8c) {
  sprint = isnumber(var_e531293848a16d8c);

  if(sprint) {
    agent.var_cbe9a7d99dac656 = "combat";
  } else {
    agent.var_cbe9a7d99dac656 = "alert";
  }

  assert(isDefined(agent.var_cbe9a7d99dac656));
  agent.var_7bd1c0edbaafb6e0 = "alert";

  if(sprint) {
    agent.var_7bd1c0edbaafb6e0 = "combat";
    agent thread function_c071dc79373d75c6(var_e531293848a16d8c);
  }

  agent thread function_2fcd1381c09ebf1();
}

function function_c071dc79373d75c6(var_e531293848a16d8c) {
  level endon("game_ended");
  self endon("death");
  self endon("port_ais_in_combat");
  self.var_3aa342a8b045cbce = var_e531293848a16d8c;
  prevnode = self.currentnode;

  while(isnumber(self.var_3aa342a8b045cbce) && self.var_3aa342a8b045cbce > 0) {
    if(!isDefined(prevnode) || length2dsquared(prevnode.origin - self.currentnode.origin) > 1) {
      prevnode = self.currentnode;

      if(!isDefined(self._blackboard.idlenode)) {
        self.var_3aa342a8b045cbce -= 1;
      }

      if(self.var_3aa342a8b045cbce > 0) {
        wait 1;
      }
    }

    waitframe();
  }

  self.var_3aa342a8b045cbce = undefined;
  self.var_cbe9a7d99dac656 = "alert";
  self.var_7bd1c0edbaafb6e0 = self.var_cbe9a7d99dac656;
}

function function_4fb6c81d40937664() {
  level endon("game_ended");
  flag_init("ai_combat_active");

  while(true) {
    wait 3;
    enemies = getaiarray("bad_guys");
    enemies = array_removedead_or_dying(enemies, 1);
    incombat = 0;

    foreach(ai in enemies) {
      if(ai.alertlevel == "combat") {
        incombat++;

        if(incombat > 2) {
          break;
        }
      }
    }

    if(incombat > 2) {
      flag_set("ai_combat_active");
      continue;
    }

    flag_clear("ai_combat_active");
  }
}

function function_2fcd1381c09ebf1() {
  level endon("game_ended");
  self endon("death");

  while(true) {
    waitframe();

    if([[self.fnisinstealthcombat]]() || [[self.fnisinstealthhunt]]() || self.var_e31ee88092e41cc8) {
      return;
    }

    if(isDefined(self._blackboard.idlenode)) {
      self.var_7bd1c0edbaafb6e0 = "patrol";
      self waittill("bseq_user_deleted");
      self.var_7bd1c0edbaafb6e0 = self.var_cbe9a7d99dac656;
    }
  }
}

function function_51fffc5c3cb2c0be() {
  level endon("port_ais_in_combat");
  self endon("death");

  while(true) {
    if(self[[self.fnisinstealthcombat]]()) {
      namespace_15c7ce84dd21743d::function_5e59fcaf5bbe49c7();
      level flag_set("port_ais_in_combat");
      self notify("port_ais_in_combat");
    }

    waitframe();
  }
}

function function_f15ce53d05d9a062() {
  thread function_7fb2a57cdb63140a(function_b9b6a29eb16d53fb());
  thread function_74d189266edf4a48(function_371cf87e5f98b35d());
  thread function_da20bac94fb1e415(function_371cf87e5f98b35d() && function_b9b6a29eb16d53fb());
}

function function_74d189266edf4a48(var_b2f2b29aeed1555d) {
  level endon("game_ended");

  if(!istrue(var_b2f2b29aeed1555d)) {
    flag_wait("flag_enter_hmo");
    wait 2;
  }

  function_6149b301ce19988b("ai_port_stealth_soldier_post_hmo_wave", &function_151716e26f89721);
  jltv = function_9abe9350cc74539e("convoy_01", &function_670dee0b0020368e, 1);
  jltv thread function_9e23991ff6710abf(15);
  wait 6;
}

function function_7fb2a57cdb63140a(var_b2f2b29aeed1555d) {
  level endon("game_ended");

  if(!istrue(var_b2f2b29aeed1555d)) {
    flag_wait("flag_board_ship");
    wait 4;
  }

  function_6149b301ce19988b("ai_port_stealth_soldier_post_ship_wave", &function_5c715719c8085439);
  jltv = function_9abe9350cc74539e("boattruck_01", &function_670dee0b0020368e, 1);
  jltv thread function_9e23991ff6710abf(15);
  wait 6;
}

function function_da20bac94fb1e415(var_b2f2b29aeed1555d) {
  level endon("game_ended");

  if(!istrue(var_b2f2b29aeed1555d)) {
    flag_wait_all("flag_trackers_retrieved", "flag_manifest_retrieved");
  }

  function_6149b301ce19988b("ai_port_stealth_soldier_post_2nd_obj_wave", &function_ec7c4200ce17c713);
  wait 4;
}

function function_eb52240866c35540(var_267b60355c1ffd77, animname, animnode) {
  setsaveddvar(@ "hash_d7f5e9fd75782a83", 1);
  function_6149b301ce19988b(var_267b60355c1ffd77, &function_5076b6c339c5d474);
}

function function_5076b6c339c5d474(group_name, func) {
  self function_a2101943e5c4fc94(5000, 0, 50);
  self function_32ebf00a50b77f9("can_see", 360, 5000, 400, 3, 0.2);
  self function_32ebf00a50b77f9("can_see_weapon", 360, 5000, 400, 3, 0.2);
  self function_32ebf00a50b77f9("stared_at", 360, 5000, 400, 3, 0.1);
  self function_32ebf00a50b77f9("aimed_at", 360, 5000, 400, 3, 0.1);
  self function_32ebf00a50b77f9("personal_space", 360, 5000, 400, 2, 0.2);
  self.pushable = 0;
  self.script_pushable = 0;
  self function_b661b022700ba72f("script", 1);
  self disableexecutionvictim();
  self function_d5cda8a759cc36bc("flee");
  set_movement_speed(40);
  self._blackboard.var_8c9a0d4c65937d48 = "cower";
  self.goalradius = 5000;
  thread function_bd6d5e7466859a44();
  thread function_e0043b10e52e2db5();
  self registerciv();
}

function function_bd6d5e7466859a44() {
  self endon("death");

  if(!isDefined(self.target)) {
    return;
  }

  params = strtok(self.target, ",");

  if(!isDefined(params[0])) {
    return;
  }

  var_da6f20045ba9ee8 = getStruct(params[0], "targetname");

  if(!array_contains(level.var_4f1860926733eab2, self)) {
    level.var_4f1860926733eab2[level.var_4f1860926733eab2.size] = self;

    if(params.size > 2) {
      if(params[2] == "jltv1") {
        var_f0b65684e40dd443 = -1;

        if(isDefined(params[3])) {
          var_f0b65684e40dd443 = int(params[3]);
        }

        if(var_f0b65684e40dd443 > level.var_80fffd99d53ccf75.size || var_f0b65684e40dd443 < 0) {
          level.var_80fffd99d53ccf75[level.var_80fffd99d53ccf75.size] = self;
        } else {
          array_insert(level.var_80fffd99d53ccf75, self, var_f0b65684e40dd443 - 1);
        }
      } else if(params[2] == "jltv2") {
        level.var_80fffa99d53cc8dc[level.var_80fffa99d53cc8dc.size] = self;
      }
    }
  }

  id = spawninteraction("cap_civ_scene_flee_and_cower01", var_da6f20045ba9ee8.origin, (0, 0, 0));
  self leaveinteraction();

  if(params.size > 1 && isDefined(params[1])) {
    delay_time = int(params[1]);
    wait delay_time;
  }

  self leaveinteraction();
  self function_76b3cfb91ef40b3b(id);
  self waittill("bt_goal");

  while(distance(self.origin, level.player.origin) < 1000) {
    wait 1;
  }

  iprintln("<dev string:x155>");

  if(isDefined(id)) {
    despawninteraction(id);
  }

  scripts\cp_mp\agents\agent_utils::despawnagent();
}

function function_e0043b10e52e2db5() {
  level endon("game_ended");

  while(true) {
    if(!isalive(self)) {
      function_2f75573839d179a3();
      break;
    }

    wait 1;
  }
}

function function_2f75573839d179a3() {
  iprintln("<dev string:x169>");

  if(!isDefined(self) || !isDefined(self.lastattacker)) {
    return;
  }

  if(self.lastattacker == level.player && isDefined(self.unittype)) {
    if(self.unittype == "civilian") {
      level thread[[level.endgame]]("axis", level.end_game_string_index["civilian_killed"]);
    }
  }
}

function camp_lighthouseSpotlight() {
  wait 30;
  level._effect["camp_lighthouseSpotlight"] = loadfx("vfx/iw9/level/intercept/vfx_intercept_lighthouse_spotlight.vfx");
  var_dbb2f3a853902b86 = getEnt("camp_lighthouseSpotlight", "targetname");
  vfxtag = var_dbb2f3a853902b86 spawn_tag_origin();
  vfxtag linkTo(var_dbb2f3a853902b86);
  playFXOnTag(level._effect["camp_lighthouseSpotlight"], vfxtag, "tag_origin");
  rotationtime = 20;

  while(true) {
    var_dbb2f3a853902b86 rotateYaw(360, rotationtime);
    wait rotationtime;
  }
}

function function_a9d21f19c08de5c3() {
  if(function_371cf87e5f98b35d() || function_b9b6a29eb16d53fb()) {
    return;
  }

  wait 1;

  for(i = 0; i < 9; i++) {
    function_eb52240866c35540("civ_test");
  }
}

function function_71349dad3d909e4c() {
  level endon("game_ended");
  var_b0fa706c8938114a = getEnt("wpn_farah", "targetname");
  var_b0fa706c8938114a setModel("tag_origin");
  strweap = "iw9_ar_akilo_mp+bar_ar_hvyshort_p04_akilo|1+mag_ar_p04_akilo|1+pgrip_aim_p04|1+rec_akilo|1+reflex03_tall|1+stock_ar_light_p04_akilo|1+loot1";
  var_730e4ed41edbd7df = spawn("weapon_" + strweap, var_b0fa706c8938114a.origin);
  var_730e4ed41edbd7df linkTo(var_b0fa706c8938114a, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_59e1a8473d0b75c6 = getEnt("wpn_alex", "targetname");
  var_59e1a8473d0b75c6 setModel("tag_origin");
  weapon_variant = function_64ccc54bdbae5cf6(11350);
  base_ref = function_1cc3fd00b6ccc3ba(11350);
  weapon_obj = level.player scripts\cp_mp\weapon::buildweapon_blueprint(base_ref, undefined, "none", weapon_variant, undefined, undefined, 1);
  var_962d7583f68be225 = getcompleteweaponname(weapon_obj);
  var_54fafbd7c3695b6b = spawn("weapon_" + var_962d7583f68be225, var_59e1a8473d0b75c6.origin);
  var_54fafbd7c3695b6b linkTo(var_59e1a8473d0b75c6, "tag_origin", (0, 0, 0), (0, 0, 0));
}

function function_c67e8871d2817b30(anim_org) {
  function_2311740fe797906a("intro_played", 1);
  level.player freezecontrols(0);
  flag_set("flag_dungeon_start_vo");
  flag_set("intro_anim_started");
  level.player notify("swap_weapon");
  level.var_b9d5a2af2d535f77 = 0;

  if(isDefined(level.port) && isDefined(level.port.var_463d69d806cb854f)) {
    level.port.var_463d69d806cb854f hide();
  }

  setsaveddvar(@ "hash_8b06c4dc6039f6b8", 0);
  flag_set("flag_dungeon_intro_complete");

  if(isDefined(anim_org)) {
    function_860a5c1214190a7c(anim_org);
  }

  if(isDefined(level.intro_heli)) {
    foreach(rider in level.intro_heli.riders) {
      if(isDefined(rider)) {
        rider scripts\cp_mp\agents\agent_utils::despawnagent();
      }
    }

    level.intro_heli delete();
  }
}

function function_d8603a6ab773365f() {
  abort = isDefined(level.start_point) && !scripts\cp\starts::is_first_start();
  abort |= !namespace_96731f4d002634f6::should_play_intro();

  abort |= getdvarint(@ "hash_d8cccbc8f345edc4", 0) || getdvarint(@ "hash_dbb53c7a147a3ed1", 0);

  return abort;
}

function play_intro() {
  level endon("scene_skipped");

  if(function_d8603a6ab773365f()) {
    showcinematicletterboxing(0, 0);
    flag_wait("dungeon_load_finished");
    level.player.var_a4f4164908559548 = 1;
    level.player waittill("loadout_class_selected");
    flag_set("flag_dungeon_intro_complete");
    flag_set("flag_dungeon_start_vo");
    level.player scripts\cp_mp\utility\game_utility::function_20cb4a5f727abe6e(0);
    delaythread(0.8, &scripts\cp_mp\utility\game_utility::fadetoblackforplayer, level.player, 0, 2);
    hidecinematicletterboxing(0, 0);
    visionsetnaked("");
    return;
  }

  flag_wait("dungeon_load_finished");
  level.player.var_a4f4164908559548 = 1;
  level.var_b9d5a2af2d535f77 = 1;
  level.player waittill("loadout_class_selected");
  level.player freezecontrols(1);
  level.player dontinterpolate();
  level.player playerhide();
  wait 2;

  if(!level.player isxb3player() && !level.player isps4player()) {
    thread function_cc514f4104398f38(&function_c67e8871d2817b30);
  }

  level.player.var_f296f7e55b9e9150 = getdvarint(@ "hash_b38fcf293d1e91a8");
  level.player utility::hidehudenable();

  if(istrue(function_28fbb3b695244b18("heli_spawner_00"))) {
    level.intro_heli = heli_reinforcements("heli_spawner_00");
  }

  utility::exploder("bldg_d_lightflare");
  thread namespace_58460674041d36d3::function_7938e0c4ea90c27c();
  flag_set("intro_anim_started");
  level thread function_60e9c159dac0447d();
  animname = "infil";
  anim_org = function_7a18da6e48b71c35("jup_port_infil");
  thread function_d9740cc1ea26eaf5();
  thread function_518d3b9b6ff2ddf6();
  anim_org function_399d052ccca9e99();
  level.player scripts\cp_mp\utility\game_utility::function_20cb4a5f727abe6e(0);
  thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.player, 0, 1);
  setsaveddvar(@ "hash_8b06c4dc6039f6b8", 1);
  anim_org thread play_notify(undefined, undefined, "jup_port_infil");
  thread function_4c047b72e92b2026();
  thread namespace_3d5dc532bca51ac0::function_97fa450d44ef3a35(anim_org);
  anim_org waittill("scene_complete");
  level.player notify("swap_weapon");
  level.var_b9d5a2af2d535f77 = 0;
  setsaveddvar(@ "hash_8b06c4dc6039f6b8", 0);
  level.var_5e84860df880bbce hide();
  anim_org scene_cleanup();
  level.player freezecontrols(0);
  function_860a5c1214190a7c(anim_org);
  level.player playershow();
  level.player scripts\cp\globallogic::userskip_stop();
  flag_set("flag_dungeon_intro_complete");
}

function function_518d3b9b6ff2ddf6() {
  if(flag("intro_jltv_spawned")) {
    return;
  }

  flag_set("intro_jltv_spawned");
  timeout = 15.8;

  while(!flag("flag_dungeon_intro_complete") && timeout > 0) {
    wait 0.1;
    timeout -= 0.1;
  }

  var_84ff13af8e463899 = function_9abe9350cc74539e("intro_vehicle01", &function_670dee0b0020368e, 1);
  var_84ff13af8e463899 thread function_9e23991ff6710abf(15);
  thread namespace_58460674041d36d3::function_eb41c0c9e1874a06(var_84ff13af8e463899);
  var_3f3ebeca69062f0e = function_371cf87e5f98b35d() || function_b9b6a29eb16d53fb();

  if(var_3f3ebeca69062f0e == 0) {
    var_84ff13af8e463899 thread function_a0196df25e1b3342(400);
    function_3b992a66c2e901bb(level.player, 1);
    function_ed9b1ddd2ec82dab(level.player, 1);
    level.player scripts\cp_mp\stealth\utility::function_1a4d7090fc81e97();
  }

  thread infil_music();
  playFXOnTag(getfx("vfx_jup_port_lensflare_headlight_scriptable"), var_84ff13af8e463899, "tag_origin_static");
  playFXOnTag(getfx("vfx_jup_port_splashes_wheel_veh"), var_84ff13af8e463899, "tag_origin_static");
  var_84ff13af8e463899 setscriptablepartstate("lights_front_cheap_bright", "on");
  var_84ff13af8e463899 setscriptablepartstate("lights_back_cheap_bright", "on");
  level.var_84ff13af8e463899 = var_84ff13af8e463899;

  if(function_371cf87e5f98b35d() || function_b9b6a29eb16d53fb()) {
    return;
  }

  wait 1;

  for(i = 0; i < 9; i++) {
    function_eb52240866c35540("civ_test");
  }
}

function infil_music() {
  setmusicstate("mx_port_infil");
  wait 20;
  namespace_b96fa4d8ce10f926::function_6ae6331457ff833d();
}

function function_399d052ccca9e99() {
  anim_org = self;
  list = anim_org scripts\common\scene::get_entities();

  foreach(ent in list) {
    if(!isPlayer(ent)) {
      ent show();
    }
  }
}

function play_notify(existingentities, shotnames, scriptbundlename, var_e59ebb4b148dcda9, var_f7ab585bff4b110) {
  if(!isDefined(var_e59ebb4b148dcda9)) {
    var_e59ebb4b148dcda9 = "scene_complete";
  }

  level.playback_scene = self;
  scripts\common\scene::play(existingentities, shotnames, scriptbundlename, var_f7ab585bff4b110);
  self notify(var_e59ebb4b148dcda9);
}

function function_1ddd0d1ad4d483f1(sceneroot) {
  var_44af2c36afc44c99 = 0;
  shots = sceneroot scripts\common\scene::function_8a37fe423de2b9db();

  foreach(shot in shots) {
    var_44af2c36afc44c99 += sceneroot scripts\common\scene::function_d9be975d8d1c9db3(shotindex);
  }

  return var_44af2c36afc44c99;
}

function function_d9740cc1ea26eaf5() {
  level endon("scene_skipped");
  var_cc92607b258004ff = getStruct("alex_battle", "targetname");
  level.port = spawnStruct();
  level.port.var_463d69d806cb854f = spawnfx(level._effect["fire_ground_lrg"], var_cc92607b258004ff.origin);
  triggerfx(level.port.var_463d69d806cb854f);
  wait 1.5;
  wait 6.5;
  flag_set("flag_dungeon_start_vo");
  wait 11;
  flag_set("flag_dungeon_intro_complete");
  level.port.var_463d69d806cb854f hide();
  function_2311740fe797906a("intro_played", 1);
}

function function_62f0d40233e81a82(anim_org) {
  flag_set("flag_dungeon_exfil_complete");
  fadeout();
}

function function_b30c77abba0c5b2d() {
  var_42e1a1d1bfab02de = function_7a18da6e48b71c35("exfil_farah_1");
  var_42e1a0d1bfab00ab = function_7a18da6e48b71c35("exfil_farah_2");
  distance1 = distance(level.player.origin, var_42e1a1d1bfab02de.origin);
  distance2 = distance(level.player.origin, var_42e1a0d1bfab00ab.origin);
  results = spawnStruct();

  if(distance1 < distance2) {
    results.anim_org = var_42e1a1d1bfab02de;
    results.var_cebef3df03cb596a = "obj_container_oligarch_03";
  } else {
    results.anim_org = var_42e1a0d1bfab00ab;
    results.var_cebef3df03cb596a = "obj_final_container";
  }

  return results;
}

function function_c1cadb469d19553c() {
  level endon("game_ended");
  thread function_47c41ca30301d5f3(&function_62f0d40233e81a82);
  function_876034df29fc1e44();
  function_cf966230e146c2b();
}

function function_876034df29fc1e44() {
  level endon("game_ended");
  level endon("outro_skipped");
  thread function_adf509f9ba7e98df();
  level.player playerhide();
  level.player.var_f296f7e55b9e9150 = getdvarint(@ "hash_b38fcf293d1e91a8");
  level.player utility::hidehudenable();
  level notify("exfil_started");
  level.player clearhudtutorialmessage();
  thread function_6faa19df793426aa();
  utility::stop_exploder("bldg_d_lightflare");
  flag_set("flag_dungeon_outro_start");
  flag_set("exfil_anim_started");
  thread namespace_58460674041d36d3::function_9119785bb20bd522();
  flag_set("flag_dungeon_exfil_start");
  function_5b13a92c82e81024(1);
  results = function_b30c77abba0c5b2d();
  var_cebef3df03cb596a = results.var_cebef3df03cb596a;
  anim_org = level.playback_scene;
  anim_org scripts\common\scene::pre_stream(undefined, undefined, 0.1, "jup_port_tracker");
  var_e59ebb4b148dcda9 = "scene_tracker_complete";
  thread namespace_3d5dc532bca51ac0::function_8ce600bd17823a90(anim_org);
  anim_org thread play_notify(undefined, undefined, "jup_port_tracker", var_e59ebb4b148dcda9);
  thread function_c381e75ae1efce39(var_cebef3df03cb596a);
  anim_org waittill(var_e59ebb4b148dcda9);
  fadeout(0);
  function_5b13a92c82e81024(1);
}

function function_cf966230e146c2b() {
  level endon("game_ended");

  if(flag("outro_skipped")) {
    return;
  }

  thread function_9b8c46e1ac8b1e8d();
  level flag_set("outro_bink_started");
  var_7848ff3f98ef4a73 = 0;
  var_8c6c2faac72ea626 = 3;
  videoname = "cp_jup_port_cine_outro";
  videoduration = 110;
  var_1bab87417f147c8f = 0;

  foreach(player in level.players) {
    player setclientomnvar("ui_cp_bink_overlay_state", var_8c6c2faac72ea626);
  }

  playcinematicforall(videoname, 1, var_1bab87417f147c8f);
  msg = level waittill_any_return_2("bink_complete", "skip_bink_input");

  if(msg == "bink_complete") {
    var_dd196a9f7e736ca4 = 0;
  } else {
    var_dd196a9f7e736ca4 = 1;
  }

  stopcinematicforall(var_dd196a9f7e736ca4);
  thread function_27964e3880c81943();

  foreach(player in level.players) {
    player setclientomnvar("ui_cp_bink_overlay_state", var_7848ff3f98ef4a73);
  }

  level.player scripts\cp\globallogic::userskip_stop();
  flag_set("flag_dungeon_exfil_complete");
}

function function_9b8c46e1ac8b1e8d() {
  level.player setsoundsubmix("cp_jup_port_exfil_bink");
}

function function_27964e3880c81943() {
  level.player clearsoundsubmix("cp_jup_port_exfil_bink");
}

function function_47c41ca30301d5f3(var_6b3bd87d12cded0f) {
  userskipped = level.player scripts\cp\globallogic::userskip_wait();

  if(!userskipped) {
    return;
  }

  while(!isDefined(level.playback_scene)) {
    waitframe();
  }

  if(!flag("outro_bink_started")) {
    level.playback_scene scripts\common\scene::stop();
  }

  if(isDefined(var_6b3bd87d12cded0f)) {
    [[var_6b3bd87d12cded0f]](level.playback_scene);
  }

  flag_set("outro_skipped");
}

function function_adf509f9ba7e98df() {
  stopmusicstate("mx_port_exfil_end");
}

function function_7ec46428e15d50b1() {
  level.player scripts\common\values::reset_all("player_rig");
  level.player stopanimScripted();
  level.player castshadows();
  level.player hidelegsandshadow();
  level.player unlink();
}

function function_cc514f4104398f38(var_6b3bd87d12cded0f) {
  userskipped = level.player scripts\cp\globallogic::userskip_wait();

  if(!userskipped) {
    return;
  }

  flag_set("scene_skipped");
  thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.player, 1);
  delaythread(0.2, &scripts\cp_mp\utility\game_utility::fadetoblackforplayer, level.player, 0);
  thread namespace_58460674041d36d3::function_2521e4438a93290c();
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
  thread function_6deed933aebc983a();
  level.var_5e84860df880bbce hide();
  thread namespace_3d5dc532bca51ac0::function_26280fbed5700639();
  thread namespace_3d5dc532bca51ac0::function_3719cd7c0273cbe8();
  hidecinematicletterboxing(2, 0);
  visionsetnaked("");
  level.player clearcinematicmotionoverride();

  if(isDefined(var_6b3bd87d12cded0f)) {
    [[var_6b3bd87d12cded0f]](level.playback_scene);
  }
}

function function_6deed933aebc983a() {
  level endon("game_ended");
  wait 1;
}

function function_c381e75ae1efce39(var_cebef3df03cb596a) {
  level endon("game_ended");
  level endon("outro_skipped");
  var_f5363813e93bf745 = function_7a18da6e48b71c35(var_cebef3df03cb596a);
  var_e256d44437269626 = getEnt(var_f5363813e93bf745.target, "targetname");
  var_e256d44437269626 show();
  var_e256d44437269626 setscriptablepartstate("light_part", "hide");
  wait 1;
  var_e256d44437269626 setscriptablepartstate("light_part", "off");
  wait 0.75;
  var_e256d44437269626 setscriptablepartstate("light_part", "on");
}

function function_6faa19df793426aa() {
  var_a23a9d12025e9230 = getlootscriptablearray();

  foreach(scriptable in var_a23a9d12025e9230) {
    if(scriptable getscriptableparthasstate(scriptable.type, "hidden")) {
      scriptable setscriptablepartstate(scriptable.type, "hidden", 1);
    }
  }
}

function vehicle_crew(var_889b0844cce57db2, animloop, var_f3521dfa77ed46c5) {
  var_7556f3e1bb0846bc = ["head_c_jup_sp_enemy_pmc_grunt_03", "head_c_jup_sp_enemy_pmc_grunt_02"];
  var_c85f573e5ea1a10a = ["body_c_jup_sp_enemy_pmc_grunt_03", "body_c_jup_sp_enemy_pmc_grunt_02"];
  var_ba9fcb4b59367a96 = self gettagorigin(var_889b0844cce57db2);
  var_ba9fcb4b59367a96 -= (0, 20, 90);
  tagangle = self gettagangles(var_889b0844cce57db2);
  actor = spawn_model(random(var_c85f573e5ea1a10a), var_ba9fcb4b59367a96, tagangle);
  actor linkTo(self);

  if(isDefined(actor.headmodel)) {
    actor detach(actor.headmodel);
  }

  actor.headmodel = spawn_model(random(var_7556f3e1bb0846bc), actor gettagorigin("j_spine4"), actor gettagangles("j_spine4"));
  actor.headmodel linkTo(actor, "j_spine4");
  actor.animname = "konni01";
  actor setanimtree();
  actor anim_loop_solo(actor, animloop);
}

function function_e1e2f5a2edeaf3f6(actor) {
  while(true) {
    sphere(actor.origin, 20, undefined, undefined, 1);

    waitframe();
  }
}

function fadein(fadeintime) {
  thread scripts\cp_mp\utility\game_utility::function_852712268d005332(level.player, 0, fadeintime);
}

function fadeout(fadeouttime) {
  thread scripts\cp_mp\utility\game_utility::function_852712268d005332(level.player, 1, fadeouttime);
}

function function_ce66ac41be824b20(sceneroot, fadeouttime) {
  totaltime = function_1ddd0d1ad4d483f1(sceneroot);

  if(totaltime >= fadeouttime) {
    wait totaltime - fadeouttime;
  } else {
    waitframe();
  }

  scripts\cp_mp\utility\game_utility::function_852712268d005332(level.player, 1, fadeouttime);
}

function function_dafb3a3f4a103ccd() {
  flag_wait("player_spawned_with_loadout");
  level.var_c91a0e8fe84fb300 = &scripts\cp\cp_claymore::function_e2b6464932ab9b06;
  claymores = scripts\cp\cp_claymore::spawn_claymore_group("test_claymores", 0, undefined, undefined, 1, undefined, 1);
}

function function_ad873d6b224de9df() {
  var_949753aaaa6edfca = getStructArray("initial_sentrygun", "targetname");
  level.var_ebc1f5321a243d72 = [];

  foreach(var_72ae510fc35f3b7d in var_949753aaaa6edfca) {
    var_72ae510fc35f3b7d.var_2108ba0559bdaaff = &namespace_3248c63599f525cf::function_5e66cae8a3e9f368;
    turret = namespace_3248c63599f525cf::setup_enemy_sentry(var_72ae510fc35f3b7d, undefined, undefined, undefined, undefined, 3000);
    level.var_ebc1f5321a243d72 = array_add(level.var_ebc1f5321a243d72, turret);
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
  level.var_5e84860df880bbce hide();
}

function function_2a7cebc730abe77a() {
  var_a2f87793f0a25c06 = getStructArray("armor_pickup", "targetname");

  foreach(var_d87fbb7f6e0e991 in var_a2f87793f0a25c06) {
    var_d87fbb7f6e0e991.angles = ter_op(isDefined(var_d87fbb7f6e0e991.angles), var_d87fbb7f6e0e991.angles, (0, 0, 0));
    dropinfo = scripts\cp\pickups::getitemdropinfo(var_d87fbb7f6e0e991.origin, var_d87fbb7f6e0e991.angles);
    armordrop = scripts\cp\pickups::spawnpickup("brloot_armor_plate", dropinfo);
  }
}

function function_c0926f2d29510c1c() {
  flag_wait("flag_dungeon_intro_complete");
  function_a02d055f9477a70c();
  level thread function_e0cb0c471c8390dd();
  level thread function_222bef19da9c23a4();
  level thread function_137fc90d1f21350c();
  namespace_53fc9ddbb516e6e1::function_9bc69c26770d9533(&namespace_1170726b2799ea65::function_a455e04c3087c72b);
}

function function_60e9c159dac0447d() {
  level endon("scene_skipped");
  flag_wait("player_spawned_with_loadout");

  if(flag("already_showed_chyron")) {
    return;
  }

  flag_set("already_showed_chyron");
  wait 11;
  level notify("show_chyrons", 0);
}

function function_5294807233d17b4b() {
  level endon("game_ended");
  level endon("player_board_ship");
  level.player endon("death");
  trigger_ascender = getEnt("trig_ascender_hint", "targetname");

  if(!isDefined(trigger_ascender)) {
    iprintln("trig_ascender_hint trigger not found");
    return;
  }

  wait 1;

  while(true) {
    trigger_ascender waittill("trigger", dude);

    if(isDefined(dude) && dude == level.player) {
      break;
    }
  }

  thread function_cf84931f815472e2();
}

function function_cf84931f815472e2() {
  level endon("game_ended");
  level.player endon("death");

  if(!function_1f067aa9b7648939()) {
    flag_set("ascender_obj_starting");
    flag_wait("ascender_obj_starting_vo_finished");
  }

  if(!function_1f067aa9b7648939()) {
    function_5aa52e5b551ac22d(&"CP_JUP_PORT/ASCENDER_PICKUP_PROMPT", 99, 255);
    objstruct = level.objectivestabledata["obj_pickup_ascender"];
    initializeobjective(objstruct, "obj_pickup_ascender", "secondary");
    startobjective(objstruct, "obj_pickup_ascender", "secondary");

    while(!flag("player_board_ship") && !function_1f067aa9b7648939()) {
      wait 0.1;
    }

    function_bd5efc673107e1fe(&"CP_JUP_PORT/ASCENDER_PICKUP_PROMPT");
    completeobjective(objstruct, "obj_pickup_ascender", "secondary");
    flag_set("ascender_picked_up");
    waitframe();
    level.player clearhudtutorialmessage();
  }

  flag_set("ascender_pickup_obj_complete");
}

function function_574bacf0402a5285() {
  level endon("game_ended");
  level endon("exfil_started");
  var_db664aef28d8c996 = getEntArray("deploy_parachute", "script_noteworthy");
  counter = 0;
  thread function_c875e9e763235edc();

  while(!function_26cd112800a1c035()) {
    wait 1;
  }

  while(counter < 3) {
    array_thread(var_db664aef28d8c996, &function_ae165af362de18a2);
    waittill_any_ents_array(var_db664aef28d8c996, "player_trigger");

    if(level.player isparachuting() || flag("parachute_used")) {
      waitframe();
      return;
    }

    level.player clearhudtutorialmessage();
    function_5aa52e5b551ac22d(&"CP_JUP_PORT/DEPLOY_PARACHUTE", 5, 0);
    counter++;
    wait 30;
  }
}

function function_c875e9e763235edc() {
  flag_wait("container_obj_start");
  trigger_off("deploy_parachute_01", "targetname");
  level waittill("obj_missile_container_boat" + "_completed");
  wait 5;
  trigger_on("deploy_parachute_01", "targetname");
}

function function_225f37ec620a7b19() {
  level endon("game_ended");

  while(true) {
    wait 1;

    if(flag("ai_combat_active")) {
      continue;
    }

    var_4ada55fa2b67e77d = level.player scripts\cp_mp\equipment::getequipmentslotammo("primary");
    var_40cdd7cb7a010cbd = level.player scripts\cp_mp\equipment::getequipmentslotammo("secondary");

    if(!isDefined(var_4ada55fa2b67e77d)) {
      var_4ada55fa2b67e77d = 0;
    }

    if(!isDefined(var_40cdd7cb7a010cbd)) {
      var_40cdd7cb7a010cbd = 0;
    }

    if(var_4ada55fa2b67e77d == 0 && var_40cdd7cb7a010cbd == 0) {
      for(i = 0; i < 7; i++) {
        currentlootid = level.player getplayerdata("cp", "dmzBackpack", i, "lootID");

        if(currentlootid == 0) {
          continue;
        }

        loottype = scripts\cp_mp\utility\loot::function_282cf83c9eeda744(currentlootid);
      }
    }
  }
}

function function_a117e8d0d4bf0839() {
  level endon("game_ended");
  flag_wait("flag_dungeon_intro_complete");
  trigger_ascender = getEnt("ascender_container_scan", "targetname");

  while(true) {
    trigger_ascender waittill("trigger", dude);

    if(isDefined(dude) && dude == level.player) {
      break;
    }
  }

  iprintln("found container");
  flag_set("ascender_container_scan");
}

function function_a02d055f9477a70c() {
  level.var_ab3fc54a7c8948bf = 0;
  level thread function_349941d5ae22bb75();
  level thread function_c3658aac31de24a5();
}

function function_349941d5ae22bb75() {
  level endon("game_ended");
  level endon("player_board_ship");

  while(true) {
    level.player waittill("ascender_device_use_success");
    level.var_ab3fc54a7c8948bf = 0;
  }
}

function function_c3658aac31de24a5() {
  level endon("game_ended");

  while(true) {
    if(level.player isparachuting()) {
      level.var_ab3fc54a7c8948bf = 1;

      if(!flag("parachute_used")) {
        flag_set("parachute_used");
      }

      if(flag("player_board_ship")) {
        return;
      }
    }

    wait 1;
  }
}

function function_e7c8a34dd8500faf() {
  while(!level.player isonground()) {
    wait 1;
  }

  flag_set("player_board_ship");
  level.player clearhudtutorialmessage();

  if(isDefined(level.var_ab3fc54a7c8948bf) && level.var_ab3fc54a7c8948bf == 0) {}
}

function function_d3a3272b937dbd96() {
  level waittill("connected", player);
  var_e2550795201ea71 = (48, 0, 48);
  var_a6f06fdfa60c762a = 105;
  var_76eaf781e6bd9a61 = 85;
  var_ae19fc842f88e2c5 = 280;
  var_5b1fc30c99c80d48 = 85;
  hint_icon = undefined;
  var_9c81a926acc98b39 = "show";
  var_976a541ebf57eb60 = getEntArray("usable_shipping_container_door", "targetname");

  if(!isDefined(var_976a541ebf57eb60) || var_976a541ebf57eb60.size <= 0) {
    println("<dev string:x177>");
    return;
  }

  var_4a72aff912b4c999 = ter_op(isDefined(player) && function_9ec2f480552af944(player), "duration_short", "duration_none");

  foreach(door in var_976a541ebf57eb60) {
    var_f01451b0c70fedc4 = door.script_noteworthy;
    door function_c2a4331f598ca13e();
    var_5e811561546e9c2d = spawn_anim_model("usable_shipping_container_door", door.origin, door.angles);
    var_5e811561546e9c2d setModel(door.model);
    var_61ef4234a82e07b9 = coordtransform(var_e2550795201ea71, var_5e811561546e9c2d.origin, var_5e811561546e9c2d.angles);
    var_68a39f47aedc4e22 = createhintobject(var_61ef4234a82e07b9, "HINT_BUTTON", hint_icon, &"CP_JUP_PORT/OLIGARCH_CONTAINER", -10, var_4a72aff912b4c999, var_9c81a926acc98b39, var_ae19fc842f88e2c5, var_5b1fc30c99c80d48, var_a6f06fdfa60c762a, var_76eaf781e6bd9a61, undefined);
    var_68a39f47aedc4e22.angles = var_5e811561546e9c2d.angles;
    var_68a39f47aedc4e22 thread function_8a74acb84c0bcb43(var_5e811561546e9c2d, var_f01451b0c70fedc4);
    var_68a39f47aedc4e22 thread function_2631c4de0c00f5a3();
  }
}

function function_8a74acb84c0bcb43(var_5e811561546e9c2d, var_f01451b0c70fedc4) {
  var_da8482243ce0e7da = 30;
  level endon("game_ended");

  if(!isDefined(var_5e811561546e9c2d)) {
    println("<dev string:x1b1>");
    return;
  }

  self hide();

  if(isDefined(var_f01451b0c70fedc4) && var_f01451b0c70fedc4 != "") {
    flag_wait(var_f01451b0c70fedc4);
  }

  self show();

  while(true) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }

    var_c9bcbfcbc3fc83f9 = spawn("script_model", (0, 0, 0));
    var_c9bcbfcbc3fc83f9 linkTo(var_5e811561546e9c2d, "tag_origin", (27, 0, 45), (0, 0, 0));
    self function_dfb78b3e724ad620(0);
    flag_set("container_opening");
    selfforward = anglesToForward(self.angles);
    playerforward = anglesToForward(player.angles);
    playerright = anglestoright(player.angles);
    angle = math::anglebetweenvectorssigned(selfforward, playerforward, playerright);
    playsoundatpos(var_5e811561546e9c2d.origin, "sfx_port_container_door_open");
    var_5e811561546e9c2d rotateTo(var_5e811561546e9c2d.angles + (0, 110, 0), 1, 0.1, 0.1);
    wait 1;
    flag_clear("container_opening");
    createnavobstaclebybounds(var_5e811561546e9c2d.origin, (74, 10, 99) / 2, var_5e811561546e9c2d.angles);
    return;
  }

  var_c9bcbfcbc3fc83f9 delete();
}

function function_13e147241db40736(var_1d65a1e531520677) {
  if(isDefined(level.var_c49fa55dcfd1d9f0.cranes[var_1d65a1e531520677])) {
    var_78d2e5bc9d7300cf = level.var_c49fa55dcfd1d9f0.cranes[var_1d65a1e531520677].tasks.size;

    for(taskindex = var_78d2e5bc9d7300cf - 1; taskindex >= 0; taskindex--) {
      originaltask = level.var_c49fa55dcfd1d9f0.cranes[var_1d65a1e531520677].tasks[taskindex];
      newtask = spawnStruct();
      newtask.var_1d65a1e531520677 = var_1d65a1e531520677;
      newtask.var_e073308eace53999 = originaltask.var_e073308eace53999;
      newtask.targetposition = level.var_c49fa55dcfd1d9f0.containers[originaltask.var_e073308eace53999].base.origin + rotatevector((48, -121, 0), level.var_c49fa55dcfd1d9f0.cranes[var_1d65a1e531520677].base.angles);
      newtask.speedscale = originaltask.speedscale;
      level.var_c49fa55dcfd1d9f0.cranes[var_1d65a1e531520677].tasks[level.var_c49fa55dcfd1d9f0.cranes[var_1d65a1e531520677].tasks.size] = newtask;
    }
  }
}

function function_c3e34853ee15f719() {
  if(getdvarint(@ "hash_d93dae2abf31114b", 1) == 0) {
    return;
  }

  function_786c10d84c135d5c("port_main");
  function_786c10d84c135d5c("port_ship");
  function_9cb60ba3067949a3("exfil_surrounding");
  function_9cb60ba3067949a3("ship_entrance_main");
  function_9cb60ba3067949a3("wood_containers");
  function_9cb60ba3067949a3("wood_containers_final");
  function_9cb60ba3067949a3("hmo_front");
  function_9cb60ba3067949a3("hmo_main");
  function_9cb60ba3067949a3("hmo_interior_hallway");
  function_9cb60ba3067949a3("ship_deck");
  function_9cb60ba3067949a3("ship_interior");

  if(getdvarint(@ "hash_de23ec010f56561a", 1) != 0) {
    function_a1aa077d5bf58e6c();
  }

  function_fa3d2cb3590d579c("initial");
  flag_init("choreographer_ready");
  flag_set("choreographer_ready");
  println("<dev string:x1e2>");
}

function function_a1aa077d5bf58e6c() {
  function_3766773616a64eac("ship_entrance_main", "initial", 3, 3, 6, 5, 1, 0, undefined, 0, 1, "count", 1);
  function_3766773616a64eac("wood_containers", "initial", 1, 3, 5, 5, 1, 0, undefined, 0, 1, "count", 1);
  function_3766773616a64eac("wood_containers_final", "initial", 0, 0, 3, 5, 1, 0, undefined, 0, 1, "count", 0);
  function_3766773616a64eac("hmo_front", "initial", 4, 3, 7, 4, 1, 0, undefined, 0, 1, "count", 2);
  function_3766773616a64eac("hmo_main", "initial", 1, 3, 5, 2, 1, 0, undefined, 0, 3, "count", 0);
  function_3766773616a64eac("hmo_interior_hallway", "initial", 8, 3, 4, 8, 1, 0, undefined, 0, 1, "count", 2);
  function_3766773616a64eac("ship_deck", "initial", 3, 2, 7, 5, 1, 0, undefined, 0, 1, "count", 0);
  function_3766773616a64eac("ship_interior", "initial", 4, 2, 3, 5, 1, 0, undefined, 0, 1, "count", 2);
  function_3766773616a64eac("ship_entrance_main", "post_ship", 3, 3, 6, 5, 1, 0, undefined, 0, 1, "count", 2);
  function_3766773616a64eac("wood_containers", "post_ship", 1, 0, 4, 5, 1, 0, undefined, 2, 4, "count", 0);
  function_3766773616a64eac("wood_containers_final", "post_ship", 0, 0, 3, 5, 0, 0, undefined, 0, 1, "count", 1);
  function_3766773616a64eac("hmo_front", "post_ship", 4, 3, 6, 5, 1, 0, undefined, 0, 1, "count", 2);
  function_3766773616a64eac("hmo_main", "post_ship", 1, 3, 5, 3, 1, 0, undefined, 0, 3, "count", 0);
  function_3766773616a64eac("hmo_interior_hallway", "post_ship", 9, 3, 4, 8, 1, 0, undefined, 0, 1, "count", 2);
  function_3766773616a64eac("ship_deck", "post_ship", 2, 2, 5, 5, 0, 0, undefined, 0, 1, "count", 2);
  function_3766773616a64eac("ship_interior", "post_ship", 2, 0, 2, 5, 0, 0, undefined, 0, 1, "count", 0);
  function_3766773616a64eac("ship_entrance_main", "post_hm", 5, 3, 5, 5, 1, 0, undefined, 0, 0, "count", 2);
  function_3766773616a64eac("wood_containers", "post_hm", 1, 0, 5, 5, 1, 0, undefined, 2, 8, "count", 0);
  function_3766773616a64eac("hmo_front", "post_hm", 4, 3, 5, 5, 1, 0, undefined, 0, 1, "count", 2);
  function_3766773616a64eac("hmo_main", "post_hm", 1, 0, 3, 2, 0, 0, undefined, 1, 2, "count", 0);
  function_3766773616a64eac("hmo_interior_hallway", "post_hm", 0, 0, 1, 1, 1, 0, undefined, 0, 2, "count", 1);
  function_3766773616a64eac("ship_deck", "post_hm", 2, 0, 5, 5, 0, 0, undefined, 0, 1, "count", 2);
  function_3766773616a64eac("ship_interior", "post_hm", 2, 0, 4, 5, 0, 0, undefined, 0, 1, "count", 0);
  function_3766773616a64eac("exfil_surrounding", "containers", 8, 4, 5, 5, 1, 0, undefined, 1, 2, "count", 1);
  function_3766773616a64eac("ship_entrance_main", "containers", 1, 1, 4, 2, 1, 0, undefined, 0, 1, "count", 0);
  function_3766773616a64eac("wood_containers", "containers", 1, 0, 2, 2, 1, 0, undefined, 0, 2, "count", 0);
  function_3766773616a64eac("wood_containers_final", "containers", 8, 5, 7, 5, 1, 0, undefined, 0, 0, "count", 3);
  function_3766773616a64eac("hmo_front", "containers", 5, 1, 2, 5, 1, 0, undefined, 1, 2, "count", 0);
  function_3766773616a64eac("hmo_main", "containers", 0, 0, 1, 5, 1, 0, undefined, 2, 3, "count", 0);
  function_3766773616a64eac("hmo_interior_hallway", "containers", 0, 0, 1, 5, 0, 0, undefined, 0, 1, "count", 1);
  function_3766773616a64eac("ship_deck", "containers", 0, 0, 5, 5, 0, 0, undefined, 0, 1, "count", 2);
  function_3766773616a64eac("ship_interior", "containers", 0, 0, 5, 5, 0, 0, undefined, 0, 1, "count", 0);
}

function function_fa3d2cb3590d579c(stage) {
  if(getdvarint(@ "hash_d93dae2abf31114b", 1) != 0) {
    function_1cdf8543ead5f85("port_main", stage);
    function_1cdf8543ead5f85("port_ship", stage);
  }
}

function function_35f1f9881a1607a1(ai) {
  flag_wait("choreographer_ready");

  if(getdvarint(@ "hash_de23ec010f56561a", 1) != 0) {
    if(isDefined(ai.script_parameters) && ai.script_parameters == "port_main") {
      function_37605fb617b75716("port_main", ai);
      return;
    }

    if(isDefined(ai.script_parameters) && ai.script_parameters == "port_ship") {
      function_37605fb617b75716("port_ship", ai);
      return;
    }

    if(isDefined(ai.var_55cc71192b8f1931)) {
      foreach(element in ai.var_55cc71192b8f1931) {
        if(element == "port_ship") {
          function_37605fb617b75716("port_ship", ai);
          continue;
        }

        if(element == "port_main") {
          function_37605fb617b75716("port_main", ai);
        }
      }
    }
  }
}

function function_f08e17103dfe9d24() {
  flag_wait("level_ready_for_script");
  level endon("game_ended");
  thread function_645c6af07b84449a();
  flag_wait("flag_dungeon_intro_complete");
  var_3f3ebeca69062f0e = function_371cf87e5f98b35d() || function_b9b6a29eb16d53fb();

  if(var_3f3ebeca69062f0e == 1) {
    thread function_5668b54809f60294();
  } else {
    thread function_18ccb55044e2441f();
    thread function_9a5ec6ad3d8eca49();
    thread function_cd270766ae38e197();
    thread function_455e070a80e45e13();
    thread function_11070a0142f62b7c();
    thread function_9c2b0e190dd68695();
  }

  thread function_3e64f4b4d7e6b65c(function_b9b6a29eb16d53fb());
}

function function_5668b54809f60294() {
  level endon("game_ended");
  utility::exploder("gastank_fire");
  utility::exploder("tower_explosion");
  var_28448cde98b265d1 = spawnfx(level._effect["explosion_fiery"], (1993.95, -1821.92, 0));
  triggerfx(var_28448cde98b265d1);
  utility::exploder("truck2_fire");
  utility::exploder("truck1_fire");
}

function function_18ccb55044e2441f() {
  wait 3.5;
  wait 0.5;
}

function function_cd270766ae38e197() {
  wait 5.5;
  utility::exploder("heli_1_downdraft");
  wait 2;
  utility::exploder("tracer_fire_01");
  wait 1;
  utility::exploder("heli_1_tracer_01");
  wait 17;
  utility::stop_exploder("heli_1_downdraft");
}

function function_9a5ec6ad3d8eca49() {
  level endon("game_ended");
  wait 28;
  utility::exploder("gastank_fire");
}

function function_455e070a80e45e13() {
  level endon("game_ended");

  while(!isDefined(level.var_15d88c3079795174)) {
    waitframe();
  }

  level.var_15d88c3079795174 endon("death");
  level.var_15d88c3079795174 thread function_30633a70084e965a();
  var_944f06f5a20e170c = utility::getStructArray("notice_tower", "targetname");
  var_944f06f5a20e170c namespace_96731f4d002634f6::waittill_player_lookat(80, 2500, 7500, undefined, undefined, 1);
  wait 17.5;
  utility::exploder("heli_2_tracer_01");
  wait 0.9;
  utility::exploder("tracer_fire_02");
  wait 1.1;
  utility::exploder("shoot_rpg_02");
  wait 0.5;
  utility::exploder("tower_explosion");
  thread namespace_58460674041d36d3::function_6cd4bd962c8131c();
  wait 6;
  utility::exploder("heli_2_downdraft");
  wait 17;
  utility::stop_exploder("heli_2_downdraft");
}

function function_30633a70084e965a() {
  level endon("game_ended");
  self waittill("death");
  utility::stop_exploder("heli_2_downdraft");
}

function function_11070a0142f62b7c() {
  level endon("game_ended");
  wait 22;
  var_28448cde98b265d1 = spawnfx(level._effect["explosion_fiery"], (1993.95, -1821.92, 0));
  triggerfx(var_28448cde98b265d1);
  thread namespace_3d5dc532bca51ac0::function_9b1750f6779fd19a();
  utility::exploder("truck2_fire");
  thread namespace_58460674041d36d3::function_afdda39e157d7331();
}

function function_9c2b0e190dd68695() {
  level endon("game_ended");
  wait 26;
  utility::exploder("truck1_fire");
  thread namespace_3d5dc532bca51ac0::function_9b174ff6779fcf67();
  thread namespace_58460674041d36d3::function_79c73e6292b5783c();
}

function function_3e64f4b4d7e6b65c(skip_fx) {
  level endon("game_ended");

  if(skip_fx) {
    var_76b033af429c50ae = utility::getStruct("ship_battle2", "targetname");
    var_8baf38bec1e78570 = spawnfx(level._effect["explosion_fiery"], var_76b033af429c50ae.origin);
    triggerfx(var_8baf38bec1e78570);
    utility::exploder("ship1_fire2");
    utility::play_loopsound_in_space("emt_idle_fire_loop", var_76b033af429c50ae.origin);
    var_b1f93452c7d91a92 = spawnfx(level._effect["explosion_ship"], (6019.06, -3957.27, 302.938), (0, 5.998, 0));
    triggerfx(var_b1f93452c7d91a92);
    utility::exploder("ship1_fire");
    return;
  }

  namespace_96731f4d002634f6::function_d14fcd3a04720601("trig_vo_ship");
  var_76b033af429c50ae = utility::getStruct("ship_battle2", "targetname");
  var_8baf38bec1e78570 = spawnfx(level._effect["explosion_fiery"], var_76b033af429c50ae.origin);
  triggerfx(var_8baf38bec1e78570);
  thread namespace_58460674041d36d3::function_6df4d24bd2419c65(var_76b033af429c50ae.origin);
  utility::exploder("ship1_fire2");
  utility::play_loopsound_in_space("emt_idle_fire_loop", var_76b033af429c50ae.origin);
  var_944f06f5a20e170c = utility::getStruct("ship_battle", "targetname");
  wait 3.5;
  var_ecc7cff98462e5eb = spawnfx(level._effect["grenade_spawner_01"], var_944f06f5a20e170c.origin);
  triggerfx(var_ecc7cff98462e5eb);
  wait 3.5;
  var_b1f93452c7d91a92 = spawnfx(level._effect["explosion_ship"], (6019.06, -3957.27, 302.938), (0, 5.998, 0));
  thread namespace_58460674041d36d3::function_b9439a9ce47a80fd((6019.06, -3957.27, 302.938));
  triggerfx(var_b1f93452c7d91a92);
  utility::exploder("ship1_fire");
  namespace_96731f4d002634f6::function_d14fcd3a04720601("obj_board_ship");
  var_ecc7cff98462e5eb hide();
}

function function_645c6af07b84449a() {
  level endon("game_ended");
}

function function_28fbb3b695244b18(heli_name) {
  var_7bf5dd6c55945c24 = 0;
  [veh_spawner] = getStructArray(heli_name, "targetname");

  if(isDefined(veh_spawner.spawngroup)) {
    spawners = getStructArray(veh_spawner.spawngroup, "targetname");
  }

  num_riders = spawners.size;

  if(num_riders < 2) {
    assertmsg("Helicopter " + heli_name + " needs to have at least 2 riders.Currently has " + num_riders + ".");
    return false;
  }

  var_a8afdb6ae61199cd = [];
  var_e6f45af63ca41aa2 = [2, 4, 8];

  for(index = 0; index < num_riders; index++) {
    spawner = spawners[index];

    if(isDefined(spawner.script_startingposition)) {
      seat = int(spawner.script_startingposition);

      if(array_contains(var_a8afdb6ae61199cd, seat)) {
        assertmsg("Helicopter " + heli_name + " has multiple riders in seat " + seat);
        return false;
      }

      var_a8afdb6ae61199cd = array_add(var_a8afdb6ae61199cd, seat);

      if(seat == 5) {
        var_7bf5dd6c55945c24 = 1;
        continue;
      }

      if(num_riders <= 4) {
        if(!istrue(array_contains(var_e6f45af63ca41aa2, seat))) {
          assertmsg("Helicopter " + heli_name + " has " + num_riders + " riders and one has a right-hand: " + seat);
          return false;
        }
      }
    }
  }

  if(!istrue(var_7bf5dd6c55945c24)) {
    assertmsg("Helicopter " + heli_name + " is missing a rope ladder seat 5.");
    return false;
  }

  return true;
}

function function_71a51c41fcd32631() {
  if(isDefined(level.var_4898102a23066ba.objectives)) {
    for(i = 0; i < 15; i++) {
      level.player namespace_96731f4d002634f6::function_a9652366b0728328(0, i);
    }
  }
}

function function_db242e965d84938d() {
  level endon("game_ended");
  self endon("death");
  var_dd9dea35aa65bc20 = -100;

  while(true) {
    if(self.origin[2] <= var_dd9dea35aa65bc20) {
      self.diequietly = 1;
      self kill();
      return;
    }

    wait 5;
  }
}