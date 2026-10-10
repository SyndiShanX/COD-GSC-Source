/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_54eb8697bbb476bb.gsc
*************************************************/

#using script_102d83a437e2b29f;
#using script_1451962dd14cc05b;
#using script_16ea1b94f0f381b3;
#using script_181a761dd7020a2a;
#using script_2362aeeb4ee01a71;
#using script_2386704e3c08f8ca;
#using script_25899a6e5c5f4ba9;
#using script_2bd16c90e9c5c546;
#using script_2c641bf019220dfc;
#using script_2e89e63ab163e7c2;
#using script_39a07ba83a01c235;
#using script_3a8f9ace195c9da9;
#using script_3ae866a6dd08daf9;
#using script_3cb1beed718e7650;
#using script_42f868a5dda17294;
#using script_46b342a079938c68;
#using script_48324b060b129b7b;
#using script_627fb23addb6d516;
#using script_6e2cd47141f9745b;
#using script_7508a8d2b5b9aa8b;
#using script_7e7eaa110dbb1c83;
#using script_fa45ab9e9a20eb8;
#using scripts\anim\dialogue;
#using scripts\anim\shared;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\scene;
#using scripts\common\swim_common;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp\coop_stealth;
#using scripts\cp\cp_checkpoint;
#using scripts\cp\cp_compass;
#using scripts\cp\cp_create_script_utility;
#using scripts\cp\cp_objectives;
#using scripts\cp\cp_outofbounds;
#using scripts\cp\cp_spawning_util;
#using scripts\cp\globallogic;
#using scripts\cp\munitions;
#using scripts\cp\pickups;
#using scripts\cp\player\offhand_box;
#using scripts\cp\spawning;
#using scripts\cp\starts;
#using scripts\cp\utility;
#using scripts\cp\utility\player;
#using scripts\cp\utility\reinforcement_util;
#using scripts\cp\weapon;
#using scripts\cp_mp\anim_scene;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\scriptable_door_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\weapon;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\stealth\manager;
#using scripts\stealth\utility;
#namespace cp_jup_resort;

function main() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0)) {
    return;
  }

  namespace_783f6c37cdf1fdac::main();
  namespace_6f23258730d18482::main();
  namespace_9aee6cba55e1ac28::main();
  thread namespace_4233a486fa2720a3::main();

  if(level.createfx_enabled) {
    return;
  }

  if(!isDefined(level.valstruct)) {
    level.valstruct = spawnStruct();
  }

  function_cdfd74e95368bd63(12000);
  level.valstruct val::set("level", "stealth_ttlt_lkp", 18000);
  level.valstruct val::set("level", "stealth_ttlt_not_lkp", 12000);
  coop_mode_enable();
  function_d525f1534752bfc7();
  function_2cfef434ce6a1c44();
  function_279964c2c969dda3();
  function_635532f54eac01c7();
  function_c4d555bf9485ac3b();
  function_c3e34853ee15f719();
  thread function_7c5fb8565b12cd65();
  function_3341019cb3804861();
  thread function_e9cc4f619333907b();
  thread function_2b818914b5b73308();
  thread function_37bde1feed06c832();
  function_61411c49eaca86e2("soap");
  scripts\cp\cp_outofbounds::function_4ff3dde013cb8715(5);
  level thread scripts\cp\utility\player::function_1c0f3b6933eb1c87();

  if(level.mapname == "cp_jup_resort") {
    level.var_61a54be8038f3a95 = 1;
    level.var_41957e049a51e8bc = "stealth_ai_music_bundle_cp_jup_resort";
    level.var_8e4a4897f3b80823 = 1;
  }

  if(getdvarint(@ "hash_2e4907ccd20a8761", 0)) {}

  coop_mode_enable("sp_stealth");
  precachemodel("body_civ_party_female_4_2");
  precachemodel("head_c_jup_sp_hero_farah_convoy");
  precachemodel("jup_electronics_server_console_screen_resort_01");
  var_429ce57b09f6dcb3 = getEnt("bunker_term_static", "targetname");
  var_429ce57b09f6dcb3 setModel("jup_electronics_server_console_screen_resort_01");
  function_648f1ab654c8fa70();
  setglobalsoundcontext("jup_map", "resort_mission", 0);
}

function function_ca2961a9315b3334() {
  wait 0.85;
  setDvar(@ "hash_d3ee5a6578fe61de", 0);
  playcinematicforall("cp_jup_resort_hack", 1, 0, 512);
  triggervol = getEnt("obj_trigger_comms_quest_circle", "targetname");
  triggervol function_ae165af362de18a2();
  stopcinematicforall();
}

function function_648f1ab654c8fa70() {
  flag_wait("flag_dungeon_intro_complete");
  var_2846bd53c1343616 = getentarrayinradius(undefined, undefined, level.player.origin, 1000);

  foreach(ent in var_2846bd53c1343616) {
    if(is_equal(ent.classname, "weapon_iw9_me_fists_mp")) {
      ent delayentdelete(0);
    }
  }
}

function function_e646f91f9331f431(agent, requestid, data) {
  if(agent.unittype == "civilian") {
    return;
  }

  agent scripts\cp\spawning::function_8029849997321123();
}

function function_2cfef434ce6a1c44() {
  level.custom_onspawnplayer_func = &onplayerspawned;
  level.custom_onplayerconnect_func = &onplayerconnect;
}

function function_3341019cb3804861() {
  scripts\engine\scriptable::scriptable_addnotifycallback("car_alarm_triggered", &car_alarm_triggered);
}

function onplayerconnect(player) {}

function onplayerspawned() {
  level thread function_ffc7dd3a5adfd5cf();
}

function function_279964c2c969dda3() {}

function function_635532f54eac01c7() {
  level.objectivesfunc = &function_c2a86f682bf1ab71;
  level thread scripts\cp\cp_objectives::objectives_init();
}

function function_c4d555bf9485ac3b() {
  level.var_5966c39cb60075f1 = &function_da58f5fca036ffaa;
  setup_create_script();
  thread function_dc042011cd0bf02a("default");
  level.var_c2c08e4c277e253e = 1;
  function_e00cc8c1c5cc38fb(1);
  namespace_84c374d417dc82cf::load_laser_fx();
  namespace_84c374d417dc82cf::initsentrysettings();
  level thread init_laser_traps();
  level thread function_a404165a0eb21d0c();
  level thread function_fc4803dc319a81d2();
  scripts\cp\cp_compass::setupminimap("compass_map_cp_jup_resort_floor_0");
  namespace_71cde0400ec8fdfd::function_b04f37f19c6631e0();
  level thread scripts\cp\cp_objectives::run_debug_start_objective();

  level.devgui_setup_func = &function_d8fb18a58a875db6;
  level thread setup_map_specific_devgui();

  thread nvg_player();
  thread function_d7398803f3fe830();
}

function function_7c5fb8565b12cd65() {
  flag_wait("flag_dungeon_intro_complete");

  if(getdvarint(@ "hash_ad29ab4c5ad7ff4c", 1)) {
    level thread namespace_15c7ce84dd21743d::function_1949988230389477("patrolbehavior_1", "patrolbehavior_2", 10, 20, 10, 5, ["idle_smoke", "idle_rub_hand", "idle_drinking", "idle_stretching"], 1);
    level thread namespace_15c7ce84dd21743d::function_925cafceea813513("patrolinteraction_1", 5, 45, 8, undefined, ["idle_tying_shoe"]);
  }
}

function function_e9cc4f619333907b() {
  flag_wait("flag_dungeon_intro_complete");
  thread function_a4fc30e535ab3011();
  thread function_ead8c04c2845b98e();
  thread function_c8e272d6f4290ddf();
  thread function_e6ff6cfa83afc505();
  thread function_40138af0c81cb590();
}

function nvg_player() {
  scripts\cp\utility\player::overridevisionsetnightforlevel("nvg_base_color_outline_jup");
}

function function_d7398803f3fe830() {
  level endon("game_ended");
  utility::flag_wait("flag_dungeon_intro_complete");
  var_5528b06a2cfce7f9 = 0;
  level.soundentity = spawn("script_origin", (271.355, 5124.94, 1169.85));

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
  if(istrue(val)) {
    iprintln("<dev string:x1c>");

    level.var_b75676042dcc92c1 = 1;
    thread function_fe662b4f5891e15e();
    flag_set("red_alert");
    return;
  }

  iprintln("<dev string:x2d>");

  level.var_b75676042dcc92c1 = 0;
  level notify("red_alert_end");
  flag_clear("red_alert");
}

function function_2b818914b5b73308() {
  level endon("obj_hack_terminal_completed");
  flag_wait("player_spawned_with_loadout");
  var_e9cd2df52d50f357 = 10;
  level.var_b75676042dcc92c1 = 0;
  var_7a5ec2330ce0cdb4 = getEnt("obj_trigger_partyside", "targetname");

  while(true) {
    waitframe();

    if(level.var_b75676042dcc92c1 == 1) {
      if(level.player istouching(var_7a5ec2330ce0cdb4)) {
        var_a3fa2fc4979d858b = function_dddde674816d38d3("heli_spawner_1");
        wait var_e9cd2df52d50f357;
        var_a3fa30c4979d87be = function_dddde674816d38d3("heli_spawner_2");
        return;
      }
    }

    wait 1;
  }
}

function function_dddde674816d38d3(heli_name) {
  heli = scripts\cp\utility\reinforcement_util::heli_reinforcements(heli_name, undefined, undefined, undefined, undefined, undefined);
  thread namespace_6edc30873082da43::function_684319b18c66ff02();
  heli thread function_d44003e42a2f3144();

  if(!isDefined(level.activekillstreaks)) {
    level.activekillstreaks = [];
  }

  heli.streakname = "chopper_gunner";
  level.activekillstreaks = array_add(level.activekillstreaks, heli);
  return heli;
}

function function_d44003e42a2f3144() {
  level endon("game_ended");
  waittill_any_2("reached_dynamic_path_end", "death");
  level.activekillstreaks = array_remove(level.activekillstreaks, self);

  if(isDefined(self) && isalive(self)) {
    self delete();
  }
}

function function_da58f5fca036ffaa() {
  self visionsetthermalforplayer("flir_2_color_gradient");
  scripts\cp\munitions::check_for_empty_munitions();
  scripts\cp\munitions::assign_highest_full_slot_to_active();
  self.munition_splash_supress = undefined;
  self.var_7269deeba689cd65 = 1;
  self.var_a8440da4d5f5a9ad = 1;
  flag_set("player_spawned_with_loadout", 1);
}

function setup_create_script() {
  scripts\cp\cp_create_script_utility::init_create_script_for_level();
  scripts\cp\cp_create_script_utility::register_create_script_arrays("cp_jup_resort_create_script", "cp_jup_resort_create_script", level.scripted_spawner_func.size, &namespace_dbbf86472fb63a::main);
}

function function_fc4803dc319a81d2() {
  level thread wait_for_pre_game_period();
  level thread wait_for_strike_init_complete();
  level thread function_222bef19da9c23a4();
  level thread function_2c31d268382bedb0();
  level thread function_137fc90d1f21350c();
  namespace_53fc9ddbb516e6e1::function_9bc69c26770d9533(&namespace_1170726b2799ea65::function_a455e04c3087c72b);
  add_start("start", &function_877e2b6e2ca1c96a);
  add_start("vip", &function_a49d3c7f34855fdd);
  add_start("guardhouse", &function_b41e71caeb52e385);
  add_start("bunker", &function_cd390f8aeec4cc6f);
  add_start("bridge", &function_45b2b04eeb919ac3);
  add_start("exfil", &function_c894126e3281cbd6);
  function_bb3e0c926b0667c4("start,vip,guardhouse,bunker,bridge,exfil");
}

function function_877e2b6e2ca1c96a() {
  utility::flag_set("setup_finished");
}

function function_c894126e3281cbd6() {
  namespace_96731f4d002634f6::function_9250dfcc43a9ccb9();
  flag_set("obj_laptop2_completed");
  flag_set("obj_laptop3_completed");
  flag_set("obj_laptops_all_completed");
  flag_set("obj_hack_terminal_completed");
  flag_set("flag_parking_area");
  flag_set("obj_enter_house_completed");
  flag_set("mansion_cleared");

  printtoscreen2d(500, 900, "<dev string:x3b>", (1, 0, 1), 8, 360);

  thread function_1364d4e78e9acc35("door_comms");
  thread namespace_9aee6cba55e1ac28::function_26280fbed5700639();
}

function function_a49d3c7f34855fdd() {
  namespace_96731f4d002634f6::function_9250dfcc43a9ccb9();
  thread namespace_9aee6cba55e1ac28::function_26280fbed5700639();
}

function function_b41e71caeb52e385() {
  namespace_96731f4d002634f6::function_9250dfcc43a9ccb9();
  thread namespace_9aee6cba55e1ac28::function_26280fbed5700639();
}

function function_cd390f8aeec4cc6f() {
  flag_set("obj_laptop2_completed");
  flag_set("obj_laptop3_completed");
  flag_set("obj_laptops_all_completed");
  thread function_1364d4e78e9acc35("door_comms");
  namespace_96731f4d002634f6::function_9250dfcc43a9ccb9();
  thread namespace_9aee6cba55e1ac28::function_26280fbed5700639();
}

function function_45b2b04eeb919ac3() {
  flag_set("obj_laptop2_completed");
  flag_set("obj_laptop3_completed");
  flag_set("obj_laptops_all_completed");
  namespace_96731f4d002634f6::function_9250dfcc43a9ccb9();
  thread function_1364d4e78e9acc35("door_comms");
  flag_set("obj_hack_terminal_completed");
  flag_set("flag_parking_area");
  thread namespace_9aee6cba55e1ac28::function_26280fbed5700639();
}

function function_2cfac9e8e73aca0() {
  level endon("game_ended");
  level endon("obj_laptop3_completed");
  trigger = getEnt("obj_trigger_comms_quest_circle", "targetname");
  trigger function_ae165af362de18a2();
  level flag_set("flag_visit_bunker");
}

function function_c24e3dd524df528a() {
  level endon("game_ended");
  level endon("obj_laptop3_completed");
  trigger = getEnt("trig_obj_laptop3", "targetname");
  trigger function_ae165af362de18a2();
  level flag_set(self.script_noteworthy, "entered_room");
  waitframe();
  objpoint = getStruct("obj_interact_bar", "targetname");
  objective_setlocation(self.var_191d2524aa36a7e, 0, objpoint.origin);
}

function function_2a0fd836564c6552() {
  level endon("game_ended");
  level endon(self.script_noteworthy);
  level endon("obj_laptop3_completed");
  vols = function_f159c10d5cf8f0b4("recon_poi_hydraulics", "script_noteworthy");

  foreach(vol in vols) {
    vol namespace_8c7f8f6b3076a74a::function_85aedb842bdb548b();
    vol namespace_8c7f8f6b3076a74a::function_c83d1e8771ec8f57("recon_poi_hydraulics_seen");
    vol namespace_8c7f8f6b3076a74a::function_64c508c5eab90d48(0);
    vol namespace_8c7f8f6b3076a74a::function_bc16e47a5d8d241a(200);
    vol namespace_8c7f8f6b3076a74a::function_13ffcc0bd41e3ed3(1);
    vol namespace_8c7f8f6b3076a74a::function_9ab6c382d227266(self.script_noteworthy);
  }

  level waittill("recon_poi_hydraulics_seen");

  if(scripts\cp_mp\utility\game_utility::function_acaa75ca8754452e()) {
    scripts\cp_mp\utility\game_utility::function_6e148c8da2e4db13((-276, 6766, 0));
    scripts\cp_mp\utility\game_utility::function_4584ad1c0e2c58ec(200);
  }
}

function function_cd6ae205181722d() {
  var_c27a5ee9ae0d2ac0 = getEnt("bunker_button_off", "targetname");
  thread function_72e8d34ec1e16ae6();
  var_a7d96d83111decd2 = var_c27a5ee9ae0d2ac0 create_interact(undefined, (0, 0, 6), 45, undefined, &"CP_JUP_RESORT/OPEN_DOOR");
  var_a7d96d83111decd2 setuseholdduration("duration_short");
  var_a7d96d83111decd2 waittill("trigger");
  flag_set("bunker_door_open");
  thread function_284fd0269fa7a4a9();
  weapobj = makeweapon("iw8_ges_plyr_loot_pickup");
  level.player scripts\cp\pickups::function_630bb1e4fdf27c6c(weapobj);
  var_a7d96d83111decd2 delete();
  wait 0.35;
  thread function_1364d4e78e9acc35("door_comms");
  thread function_c6fe73ba0e48a76c();
  function_6149b301ce19988b("ai_spawn_bunker", &function_549e7b2d3d61cdd4);
  flag_set("obj_laptop3_completed");
}

function function_284fd0269fa7a4a9() {
  level.player play_sound_on_entity("jup_oli_foley_bunker_open_01");
}

function function_c6fe73ba0e48a76c() {
  level play_sound_in_space("jup_oli_door_bunker_open", (266, 5769, 583));
}

function init_laser_traps() {
  flag_wait("player_spawned_with_loadout");
  var_8bdd1937dc080cca = getStructArray("laser_sentry_defuse", "script_noteworthy");
  namespace_84c374d417dc82cf::function_4855a66011f5974b(var_8bdd1937dc080cca);
}

function function_a404165a0eb21d0c() {
  var_3c62acd3887668c3 = getStruct("obj_interact_suite", "targetname");
  locked_prompt = spawn("script_model", var_3c62acd3887668c3.origin);
  locked_prompt setModel("tag_origin");
  locked_prompt makeusable();
  locked_prompt setHintString(&"CP_JUP_RESORT/DOOR_LOCKED");
  locked_prompt setCursorHint("HINT_BUTTON");
  locked_prompt sethintdisplayrange(200);
  locked_prompt sethintdisplayfov(90);
  locked_prompt setuserange(60);
  locked_prompt setusefov(180);
  locked_prompt sethintonobstruction("hide");
  locked_prompt setuseholdduration("duration_short");
  level.var_92df06b8e01dfab7 = locked_prompt;
  level endon("obj_hack_door_completed");

  while(true) {
    locked_prompt waittill("trigger");
    playsoundatpos(locked_prompt.origin, "jup_oli_door_final_locked");
    wait 0.3;
  }
}

function function_c3e34853ee15f719() {
  if(getdvarint(@ "hash_c60811eed079817d", 1) == 0) {
    return;
  }

  level.var_f3a9806dc2594db6 = [];
  level.var_f3a9806dc2594db6["beach"] = getEnt("beach_main", "targetname", 1);
  level.var_f3a9806dc2594db6["central"] = getEnt("central_main", "targetname", 1);
  level.var_f3a9806dc2594db6["mansion"] = getEnt("mansion_main", "targetname", 1);
  level.var_f3a9806dc2594db6["cabana"] = getEnt("cabana_main", "targetname", 1);
  level.var_f3a9806dc2594db6["parking"] = getEnt("parking_main", "targetname", 1);
  level.var_175778d03d41b865 = [];
  level.var_175778d03d41b865[0] = "beach";
  level.var_175778d03d41b865[1] = "central";
  level.var_175778d03d41b865[2] = "cabana";
  level.var_175778d03d41b865[3] = "parking";
  level.var_175778d03d41b865[4] = "mansion";
  function_786c10d84c135d5c("beach");
  function_786c10d84c135d5c("central");
  function_786c10d84c135d5c("cabana");
  function_786c10d84c135d5c("parking");
  function_786c10d84c135d5c("mansion");
  function_9cb60ba3067949a3("beach_dock_right");
  function_9cb60ba3067949a3("beach_dock_left");
  function_9cb60ba3067949a3("beach");
  function_9cb60ba3067949a3("central_path_lower");
  function_9cb60ba3067949a3("central_path_mid");
  function_9cb60ba3067949a3("central_west_upper");
  function_9cb60ba3067949a3("central_west_lower");
  function_9cb60ba3067949a3("central_patio_lower");
  function_9cb60ba3067949a3("central_patio_upper");
  function_9cb60ba3067949a3("central_ne_path");
  function_9cb60ba3067949a3("central_courtyard");
  function_9cb60ba3067949a3("central_path_east");
  function_9cb60ba3067949a3("mansion_main");
  function_9cb60ba3067949a3("parking_main");
  function_9cb60ba3067949a3("parking_south");
  function_9cb60ba3067949a3("parking_mid");
  function_9cb60ba3067949a3("parking_north");
  function_9cb60ba3067949a3("cabana_main");
  function_9cb60ba3067949a3("cabana_building");
  function_9cb60ba3067949a3("cabana_cliff");
  function_9cb60ba3067949a3("cabana_dock");

  if(getdvarint(@ "hash_6f9757bedb9cd08", 1) != 0) {
    function_a1aa077d5bf58e6c();
  }

  function_4ed7c79a134e41b0("default");
  flag_init("choreographer_ready");
  flag_set("choreographer_ready");
  println("<dev string:x71>");
}

function function_4ed7c79a134e41b0(stage) {
  foreach(instance in level.var_175778d03d41b865) {
    function_1cdf8543ead5f85(instance, stage);
  }
}

function function_a1aa077d5bf58e6c() {}

function function_d93d63b293881b1f(ai) {
  flag_wait("choreographer_ready");

  if(isDefined(ai.script_parameters)) {
    if(array_contains(level.var_175778d03d41b865, ai.script_parameters)) {
      function_37605fb617b75716(ai.script_parameters, ai);
    }
  }
}

function wait_for_pre_game_period() {
  level endon("game_ended");
  flag_wait("bsp_structs_initialized");
  flag_wait("level_ready_for_script");
  thread function_ab74995647ea4c();
  level.var_c2c08e4c277e253e = 1;
  level ai_death_monitor(&namespace_6edc30873082da43::function_a5d488e99073e6c7);
  level.var_7a9f066f79bed633 = &function_f99d747ae629971e;
  thread function_71a017d209e7078e(&function_b7e95fc3bfdd9d74, &function_f98463d49e2f9067);
  thread function_de5ae0c94d33b9c8();
}

function function_37bde1feed06c832() {
  level endon("game_ended");
  flag_wait("flag_dungeon_intro_complete");
  var_4af483b1190bd3e3 = getEntArray("achievement_car", "script_noteworthy");

  while(true) {
    waitframe();

    foreach(car in var_4af483b1190bd3e3) {
      partstate = car getscriptablepartstate("body", 1);

      if(isDefined(partstate) && partstate == "dead") {
        var_4af483b1190bd3e3 = array_remove(var_4af483b1190bd3e3, car);
      }
    }

    if(var_4af483b1190bd3e3.size == 0) {
      level.player function_6a369480dbaf1090("jup_sp_enjoythelittlethings");
      return;
    }

    wait 1;
  }
}

function function_c67e8871d2817b30(anim_org) {
  flag_set("intro_anim_started");

  if(isDefined(level.port) && isDefined(level.port.var_463d69d806cb854f)) {
    level.port.var_463d69d806cb854f hide();
  }

  setsaveddvar(@ "hash_8b06c4dc6039f6b8", 0);
  flag_set("flag_dungeon_intro_complete");

  if(isDefined(anim_org)) {
    function_860a5c1214190a7c(anim_org);
    thread function_c0df239566181bdd();
  }
}

function fadein(fadeintime) {
  thread scripts\cp_mp\utility\game_utility::function_852712268d005332(level.player, 0, fadeintime);
}

function fadeout(fadeouttime) {
  thread scripts\cp_mp\utility\game_utility::function_852712268d005332(level.player, 1, fadeouttime);
}

function play_intro() {
  level endon("scene_skipped");
  fadeout(0);
  flag_wait("dungeon_load_finished");
  level.player waittill("loadout_class_selected");
  abort = isDefined(level.start_point) && !scripts\cp\starts::is_first_start();
  abort = abort || getdvarint(@ "hash_f58e871d41f25c7e", 0) || getdvarint(@ "hash_dbb53c7a147a3ed1", 0);

  if(!namespace_96731f4d002634f6::should_play_intro() || abort) {
    wait 1;
    level.player scripts\cp_mp\utility\game_utility::function_20cb4a5f727abe6e(0);
    flag_set("flag_dungeon_intro_complete");
    level.player scripts\cp\globallogic::userskip_stop();
    level.player function_3671ec427c125cb(0);
    fadein(0);
    thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.player, 0, 1);
    return;
  }

  anim_org = function_7a18da6e48b71c35("infil_animnode");
  anim_org scripts\common\scene::pre_stream(undefined, undefined, -1, "jup_resort_infil");
  anim_ents = anim_org scripts\common\scene::get_entities();

  foreach(anim_ent in anim_ents) {
    if(isDefined(anim_ent.animname) && (anim_ent.animname == "soap_1_head" || anim_ent.animname == "soap_1_body")) {
      anim_ent hide();
      anim_ent thread function_6613999d9eb52f61();
    }
  }

  level.player scripts\common\swim_common::function_9368fff2b3156346(1);
  level.player.var_f296f7e55b9e9150 = getdvarint(@ "hash_b38fcf293d1e91a8");
  thread function_cc514f4104398f38(&function_c67e8871d2817b30);
  function_a88c360e19062b00(1);
  level.player allowfire(0);
  level.player playerhide();
  flag_set("intro_anim_started");
  thread infil_music();
  level.player scripts\cp_mp\utility\game_utility::function_20cb4a5f727abe6e(0);
  thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(level.player, 0, 1);
  fadein(0);
  level.player function_f484b2c51e0d6f5e(0);
  thread namespace_9aee6cba55e1ac28::function_fe37660adcbfb21d(anim_org);
  level.playback_scene = anim_org;
  level thread function_f75be718055ec2b3();
  anim_org scripts\common\scene::play(undefined, ["shot_010", "shot_020", "shot_030"], "jup_resort_infil");
  level notify("show_soap");
  anim_org scripts\common\scene::play(undefined, "shot_040", "jup_resort_infil");
  level.player function_f484b2c51e0d6f5e(1);
  anim_org scene_cleanup();
  function_860a5c1214190a7c(anim_org);
  level.player playershow();
  flag_set("flag_dungeon_intro_complete");
  level.player allowfire(1);
  level.player scripts\common\swim_common::function_9368fff2b3156346(0);
  level.player scripts\cp\globallogic::userskip_stop();
}

function function_6613999d9eb52f61() {
  level endon("game_ended");
  level endon("scene_skipped");
  level waittill("show_soap");
  self show();
}

function infil_music() {
  setmusicstate("mx_resort_infil");
}

function function_4864d91745d2b954() {
  while(true) {
    wait 2;
    aiarray = getaiarray();

    foreach(ai in aiarray) {
      ai dodamage(500, ai.origin);
    }
  }
}

function function_c1cadb469d19553c() {
  level thread function_d55c95fb15a2e7cd();
  flag_set("flag_dungeon_outro_start");
  thread function_47c41ca30301d5f3(&function_62f0d40233e81a82);
  function_876034df29fc1e44();
  function_cf966230e146c2b();
}

function function_62f0d40233e81a82(anim_org) {
  fadeout();
}

function function_47c41ca30301d5f3(var_6b3bd87d12cded0f) {
  level endon("game_ended");
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

function function_9fbf5bd16ac765c6(anim_org) {
  clearmusicstate();
  fadeout(0);
}

function function_876034df29fc1e44() {
  level endon("game_ended");
  level endon("outro_skipped");
  thread namespace_4233a486fa2720a3::function_83c5d872891aa8fc();
  thread namespace_4233a486fa2720a3::function_568d4e33eecc8859();

  if(level.player isnightvisionon()) {
    level.player nightvisionviewoff(1);
  }

  level.player allowfire(0);
  level.player playerhide();
  function_a88c360e19062b00(1);
  level.player hidehudenable();
  thread function_8615a6b7cd263577();
  thread function_a47326c0544f6fb9();
  function_5b13a92c82e81024(1);
  anim_org = function_7a18da6e48b71c35("resort_milena_exfil");
  thread namespace_9aee6cba55e1ac28::function_70a130c71a4c929b(anim_org);
  level.playback_scene = anim_org;
  anim_org scripts\common\scene::play(undefined, "shot_010", "jup_resort_torture");
  function_9fbf5bd16ac765c6(anim_org);
}

function function_cf966230e146c2b() {
  level endon("game_ended");

  if(flag("outro_skipped")) {
    return;
  }

  level flag_set("outro_bink_started");
  thread function_823770f0afe5ac27();
  var_7848ff3f98ef4a73 = 0;
  var_8c6c2faac72ea626 = 3;
  videoname = "cp_jup_resort_cine_outro";
  videoduration = 182;
  var_1bab87417f147c8f = 0;

  foreach(player in level.players) {
    player setclientomnvar("ui_cp_bink_overlay_state", var_8c6c2faac72ea626);
  }

  playcinematicforall(videoname, 1, var_1bab87417f147c8f);
  msg = level waittill_any_return_2("bink_complete", "skip_bink_input");
  thread namespace_4233a486fa2720a3::function_522d661934355f5b();

  if(msg == "bink_complete") {
    var_dd196a9f7e736ca4 = 0;
  } else {
    var_dd196a9f7e736ca4 = 1;
  }

  stopcinematicforall(var_dd196a9f7e736ca4);

  foreach(player in level.players) {
    player setclientomnvar("ui_cp_bink_overlay_state", var_7848ff3f98ef4a73);
  }

  level.player scripts\cp\globallogic::userskip_stop();
}

function function_823770f0afe5ac27() {
  wait 5;
  fadeout(5);
  level.player setclientomnvar("ui_hide_hud", 1);
}

function function_d55c95fb15a2e7cd() {
  level endon("game_ended");
  level endon("outro_skipped");
  flag_wait("lgt_cine_exfil_laptop");
  setDvar(@ "hash_d3ee5a6578fe61de", "0");
  setDvar(@ "hash_b9ff37d084074df3", "1");
}

function function_a47326c0544f6fb9() {
  level endon("game_ended");
  var_ec2c9a40a880fc9 = getEnt("wpn_soap", "targetname");
  var_ec2c9a40a880fc9 setModel("tag_origin");
  var_41cbd6953e2ea48e = ["ammo_556n", "bar_ar_lgtshort_p01_mike4", "iw9_rec_mike4", "mag_ar_p01", "pgrip_p01", "reflex08_tall", "selectsemi_mike4", "stock_ar_tactical_p01_mike4"];
  var_9bdbdd105c427cc8 = scripts\cp_mp\weapon::buildweapon("iw9_ar_mike4_mp", var_41cbd6953e2ea48e);
  var_8377250f419b34c9 = getcompleteweaponname(var_9bdbdd105c427cc8);
  var_bd015cffb9f9c354 = spawn("weapon_" + var_8377250f419b34c9, var_ec2c9a40a880fc9.origin);
  var_bd015cffb9f9c354 linkTo(var_ec2c9a40a880fc9, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_a0f9aa345937f90d = getEnt("wpn_ghost", "targetname");
  var_a0f9aa345937f90d setModel("tag_origin");
  var_121fa5b5b26418a2 = scripts\cp\weapon::make_weapon_special("iw9_ar_mcbravo_v1_cp");
  var_c337325338c8c185 = getcompleteweaponname(var_121fa5b5b26418a2);
  var_4ba1f7c550bed8a8 = spawn("weapon_" + var_c337325338c8c185, var_a0f9aa345937f90d.origin);
  var_4ba1f7c550bed8a8 linkTo(var_a0f9aa345937f90d, "tag_origin", (0, 0, 0), (0, 0, 0));
}

function function_8615a6b7cd263577() {
  stopmusicstate("mx_resort_exfil_end");
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
  delaythread(0.1, &scripts\cp_mp\utility\game_utility::fadetoblackforplayer, level.player, 0);
  level.player stopsounds();
  level.player stopxcam();

  if(isDefined(level.playback_scene)) {
    level.playback_scene scripts\common\scene::stop();
    level.playback_scene scene_cleanup();
  }

  function_7ec46428e15d50b1();

  if(isDefined(level.player.hidehudenabled) && level.player.hidehudenabled > 0) {
    level.player utility::hidehuddisable();
  }

  level.player scripts\common\values::reset_all("scene_shot");
  level.player scripts\common\values::reset_all("player_rig");
  level.player playershow();
  level.player function_f484b2c51e0d6f5e(1);
  level.player allowfire(1);
  level.player scripts\common\swim_common::function_9368fff2b3156346(0);
  level.player function_3671ec427c125cb(0);
  function_26280fbed5700639();
  hidecinematicletterboxing(2, 0);
  visionsetnaked("", 30);
  level.player clearcinematicmotionoverride();

  if(isDefined(var_6b3bd87d12cded0f)) {
    [[var_6b3bd87d12cded0f]](level.playback_scene);
  }
}

function function_71a017d209e7078e(var_7de0ed2111f0adc7, var_bd977d7be720602c) {
  level endon("game_ended");
  flag_wait("level_ready_for_script");
  function_8bcc57ecc1d97b99(var_7de0ed2111f0adc7, var_bd977d7be720602c);
  function_6149b301ce19988b("ai_initialspawn", &function_414c8b007be6ffbe);
  function_6149b301ce19988b("ai_initialspawn_main", &function_1161ecf48b5e1a4a);
  function_6149b301ce19988b("ai_initialspawn_beach", &function_f767f3004323b8a);
  function_6149b301ce19988b("ai_initialspawn_midline", &function_bec8e85f4a14315b);
  function_6149b301ce19988b("ai_initialspawn_upper", &function_d5c4b61b1a73ccf3);
  function_6149b301ce19988b("ai_initialspawn_patio", &function_5ef0dc9b042588f4);
  function_6149b301ce19988b("ai_initialspawn_mansion", &function_2724a589a8407028);
  function_6149b301ce19988b("ai_initialspawn_sec_station_north", &function_4f6fbde2daa70985);
  function_6149b301ce19988b("ai_initialspawn_mansion_mover", &function_c8440bc694580b96);
  function_6149b301ce19988b("ai_initialspawn_intro_mover", &function_4ae85c01d8db421b);
  function_6149b301ce19988b("ai_initialspawn_patio_mover", &function_380b96fc6b2bfdca);
  function_6149b301ce19988b("ai_initialspawn_sitting_mover", &function_90a9870f3f553705);
  function_6149b301ce19988b("ai_initialspawn_cy_mover_01", &function_7a11a7ed7f58261b);
  function_6149b301ce19988b("ai_initialspawn_cy_mover_02", &function_b88d0718aba21878);
  level thread function_4fb6c81d40937664();
  wait 2;
}

function function_b7e95fc3bfdd9d74() {}

function function_c4a385b66fb3b13d() {
  return flag("Player_detected");
}

function function_4bd2db162f84009f() {}

function function_309128dd0ebc94ff() {}

function function_1706e2acbccd2aef() {}

function function_dc8ff8cee447e9a7() {}

function wait_for_strike_init_complete() {
  level endon("game_ended");

  if(flag_exist("strike_init_done")) {
    flag_wait("strike_init_done");
    thread function_dfeab09e12eff7e4();
  }

  level function_93844e6c6121aa58();
}

function function_93844e6c6121aa58() {
  function_faca97a1295e60a6();
}

function function_dfeab09e12eff7e4() {
  thread scripts\cp\player\offhand_box::offhand_box_setup();
}

function function_faca97a1295e60a6() {
  spawners = getStructArray("boat_spawner", "targetname");

  foreach(spawner in spawners) {
    assert(isDefined(spawner));
    vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh_jup_rhib", spawner);

    if(isDefined(vehicle)) {
      waitframe();
      vehicle function_481c2a63f2ba3332(0);
      waittillframeend();
      vehicle function_481c2a63f2ba3332(-1, 100);
    }
  }
}

function function_c2a86f682bf1ab71() {
  level.objectives_table = "cp/cp_jup_resort_objectives.csv";
  level.objectivesmatrixtable = "cp/cp_jup_resort_objectives_matrix.csv";
  level.objectiveregistration = &function_77765e5dd4c9db54;
  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

function function_77765e5dd4c9db54() {
  level endon("game_ended");
  flag_wait("level_ready_for_script");
  thread registerobjective("obj_laptop2", undefined, &function_dead0eda004642cc);
  thread registerobjective("obj_laptop3", undefined, &function_dfc2600585c6989b);
  thread registerobjective("obj_hack_terminal", undefined, &function_485dd5516b206eac, &function_a8eb46de7955d747);
  thread registerobjective("obj_enter_house", undefined, &function_dc374842526efc23);
  thread registerobjective("obj_hack_door", undefined, &function_49e50566759b128);
  scripts\cp\cp_checkpoint::function_d37e0c86fbcf710b(["obj_laptop2", "obj_laptop3", "obj_hack_terminal"], "terminal_checkpoint", &function_b8534d152defcba8);
  scripts\cp\cp_checkpoint::function_63e1728c535014c9("terminal_checkpoint", &scripts\cp\cp_checkpoint::function_5b0a03741aa420d7);
}

function function_b8534d152defcba8() {
  flag_set("flag_dungeon_intro_complete");
  flag_set("obj_laptop2_completed");
  flag_set("obj_laptop3_completed");
  flag_set("obj_laptops_all_completed");
  flag_set("obj_hack_terminal_completed");
  flag_set("flag_parking_area");
  thread function_1364d4e78e9acc35("door_comms");
}

function function_2c31d268382bedb0() {
  level endon("game_ended");

  while(true) {
    if(isDefined(level.player)) {
      wait 1;
      level.player skydive_setbasejumpingstatus(1);
      level.player skydive_setdeploymentstatus(1);
      return;
    }

    wait 0.1;
  }
}

function private function_c5d1a289b0fc3dfb() {
  level endon("game_ended");
  wait 1;
  flag_set("vip_located");
}

function function_dead0eda004642cc(objectivestruct, var_5dcdfd3a4eff9961) {
  if(flag("obj_laptop2_completed")) {
    return;
  }

  level thread function_cd6ae205181722d();
  level thread function_c5d1a289b0fc3dfb();
  vip_spawn = function_6149b301ce19988b("ai_VIP", &function_3f3f8dac28cf5a20);
  var_14f18124b88f78f0 = function_6149b301ce19988b("ai_VIP_group", &function_3f3f8dac28cf5a20);

  while(vip_spawn.ai_spawned.size < 1 || var_14f18124b88f78f0.ai_spawned.size < 2) {
    wait 0.1;
  }

  spawnedvip = vip_spawn.ai_spawned[0];
  level.vip = spawnedvip;
  thread function_e917763f4ddb760e(spawnedvip);
  assertex(isDefined(spawnedvip), "obj_laptop2: VIP was not found or spawned");
  flag_wait("vip_located");
  wait randomintrange(3, 5);
  alt_circle = spawnStruct();
  alt_circle.radius = 600;
  randomradius = alt_circle.radius * 0.8;
  alt_circle.origin = spawnedvip.origin + randomonunitsphere() * randomradius;
  alt_circle.script_noteworthy = "vip_spotted";
  alt_circle thread namespace_9d6ed0911e2ddf09::function_dc3c295fcb6d7c77(1, "fob_key_acquired", undefined, undefined, 1, undefined, undefined, undefined, undefined, undefined, undefined, 0);
  spawnedvip namespace_8c7f8f6b3076a74a::function_85aedb842bdb548b();
  spawnedvip namespace_8c7f8f6b3076a74a::function_c1cc6dcce270f411(1);
  spawnedvip namespace_8c7f8f6b3076a74a::function_75bf86ba2237d4a2(2500);
  spawnedvip namespace_8c7f8f6b3076a74a::function_c83d1e8771ec8f57("vip_spotted");
  spawnedvip namespace_8c7f8f6b3076a74a::function_64c508c5eab90d48(0);
  spawnedvip namespace_8c7f8f6b3076a74a::function_bc16e47a5d8d241a(200);
  spawnedvip namespace_8c7f8f6b3076a74a::function_9ab6c382d227266("obj_VIP_dead");
  circleupdatetime = 5;

  while(isalive(spawnedvip)) {
    ret = waittill_any_ents_or_timeout_return(circleupdatetime, spawnedvip, "death", spawnedvip, "vip_spotted");

    if(ret == "death") {
      flag_set("vip_spotted", "vip_dead");
      break;
    }

    if(ret == "vip_spotted") {
      waitframe();
      objective_onentity(alt_circle.var_191d2524aa36a7e, spawnedvip);
      objective_setzoffset(alt_circle.var_191d2524aa36a7e, 80);
      continue;
    }

    if(distance2dsquared(spawnedvip.origin, alt_circle.mapcircle.origin) > alt_circle.radius * alt_circle.radius) {
      if(!flag("vip_spotted")) {
        circlecenter = spawnedvip.origin + randomonunitsphere() * randomradius;
        alt_circle scripts\cp_mp\utility\game_utility::function_6e148c8da2e4db13(circlecenter);
        objective_setlocation(alt_circle.var_191d2524aa36a7e, 0, circlecenter);
      }
    }
  }

  waitframe();
  flag_set("obj_VIP_dead");
  objective_setzoffset(alt_circle.var_191d2524aa36a7e, 0);
  objective_setlabel(alt_circle.var_191d2524aa36a7e, &"CP_JUP_RESORT/OBJ2_LABEL");
  objective_setlocation(alt_circle.var_191d2524aa36a7e, 0, spawnedvip.origin + (0, 0, 40));
  var_4ae80cdbe47484a0 = getclosestpointonnavmesh(spawnedvip.origin, spawnedvip);
  var_ce57295eaf5d616f = spawn("script_model", var_4ae80cdbe47484a0 + (0, 0, 0.5));
  var_ce57295eaf5d616f setModel("electronics_usb_dongle_01");
  var_ce57295eaf5d616f rotatepitch(0, 0.1);
  var_17844a9f5f55734d = var_ce57295eaf5d616f create_interact(undefined, (0, 0, 15), 160, undefined, &"CP_JUP_RESORT/TAKE_KEY_FOB");
  var_17844a9f5f55734d setuseholdduration("duration_short");
  var_17844a9f5f55734d sethintonobstruction("hide");
  var_17844a9f5f55734d waittill("trigger");
  level.player forceplaygestureviewmodel("ges_swipe");
  var_17844a9f5f55734d delete();
  var_ce57295eaf5d616f delete();
  alt_circle notify("fob_key_acquired");
  flag_set("obj_laptop2_completed");
}

function function_e917763f4ddb760e(spawnedvip) {
  level endon("game_ended");
  doors = scripts\cp_mp\utility\scriptable_door_utility::scriptable_door_get_in_radius((-134.058, 3815.94, 366.5), 500, 500);

  foreach(door in doors) {
    door thread scriptable_door_freeze_open(0);
  }

  wait 30;
  spawnedvip thread function_61e9e25b6013a862();
  spawnedvip.dontdropweapon = 1;
  spawnedvip.dropweapon = 0;
}

function function_61e9e25b6013a862() {
  self setoverridearchetype("weapon", "guard_02", 1);
  scripts\anim\shared::placeweaponon(self.sidearm, "thigh");
}

function function_dfc2600585c6989b(objectivestruct, var_5dcdfd3a4eff9961) {
  if(flag("obj_laptop3_completed")) {
    return;
  }

  objpoint = getStruct("bunker_door_obj_marker", "targetname");
  objectivestruct.origin = objpoint.origin;
  objectivestruct.radius = objpoint.radius;
  objectivestruct.script_noteworthy = objpoint.script_noteworthy;
  objectivestruct thread namespace_9d6ed0911e2ddf09::function_dc3c295fcb6d7c77(2, "obj_laptop3_completed", undefined, undefined, 1);
  objectivestruct namespace_8c7f8f6b3076a74a::function_847531f882fe30d0(0);
  thread function_2cfac9e8e73aca0();
  flag_wait_any("flag_visit_bunker", "obj_laptop3_completed");

  if(!flag("obj_laptop3_completed")) {
    objpoint = getStruct("obj_interact_bar", "targetname");

    if(objectivestruct scripts\cp_mp\utility\game_utility::function_acaa75ca8754452e()) {
      objectivestruct scripts\cp_mp\utility\game_utility::function_6e148c8da2e4db13(objpoint.origin);
      objectivestruct scripts\cp_mp\utility\game_utility::function_4584ad1c0e2c58ec(objpoint.radius);
    } else {
      objective_setlocation(objectivestruct.var_191d2524aa36a7e, 0, objpoint.origin);
    }

    objectivestruct thread function_2a0fd836564c6552();
    objectivestruct thread function_c24e3dd524df528a();
  }
}

function function_485dd5516b206eac(objectivestruct, var_5dcdfd3a4eff9961) {
  if(flag("obj_hack_terminal_completed")) {
    return;
  }

  objpoint = getStruct("bunker_door_marker", "targetname");
  objpoint thread namespace_9d6ed0911e2ddf09::function_dc3c295fcb6d7c77(5, "obj_hack_terminal_completed", undefined, undefined, 1, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  objpoint namespace_8c7f8f6b3076a74a::function_847531f882fe30d0(0);
  function_d14fcd3a04720601("obj_trigger_comms");
  var_b423b6ade01b2811 = getStruct("obj_interact_usb", "targetname");
  objective_setlocation(objpoint.var_191d2524aa36a7e, 0, var_b423b6ade01b2811.origin);
  objective_setlabel(objpoint.var_191d2524aa36a7e, &"CP_JUP_RESORT/TERMINAL");
  var_3e8a2b767980bb71 = getStruct("obj_interact_usb", "targetname");
  var_cffca1a9623f41d5 = var_3e8a2b767980bb71 create_interact(undefined, (0, 0, 0), 40, undefined, &"CP_JUP_RESORT/HACK_SERVER");
  var_cffca1a9623f41d5 setuseholdduration("duration_short");
  var_cffca1a9623f41d5 waittill("trigger");
  level.player forceplaygestureviewmodel("ges_swipe");
  level.var_f5b78f8c0b85f34f = spawn("script_origin", var_b423b6ade01b2811.origin);
  level.var_f5b78f8c0b85f34f playsoundonentity("jup_oli_usb_foley_unlock");
  var_cffca1a9623f41d5 delete();
  thread function_ca2961a9315b3334();
  objpoint notify("obj_hack_terminal_completed");
  flag_set("obj_hack_terminal_completed");
}

function function_a8eb46de7955d747(objectivestruct, var_5dcdfd3a4eff9961) {
  if(!flag("terminal_checkpoint_completed")) {
    scripts\cp\cp_checkpoint::checkpoint_set("terminal_checkpoint");
  }

  function_6149b301ce19988b("ai_postbunkerspawn_mansion", &function_c38fd2e368e2d565);
  wait 2;
  wait 10;
  flag_set("flag_parking_area");
  thread function_4296d3404275d818();
}

function function_4296d3404275d818() {
  namespace_b96fa4d8ce10f926::function_ebd9a9c9789d200f();
  wait 6;
  setmusicstate("mx_resort_bunker");
}

function function_dc374842526efc23(objectivestruct, var_5dcdfd3a4eff9961) {
  if(flag("obj_enter_house_completed")) {
    flag_set("mansion_cleared");
    flag_set("vo_mansion_door_unlock");
    return;
  }

  level thread function_aaf3fa7642b6a2e2();
  alt_circle = getStruct("mansion_objective", "targetname");
  alt_circle thread namespace_9d6ed0911e2ddf09::function_dc3c295fcb6d7c77(6, "obj_enter_house_completed", undefined, undefined, 1, undefined, undefined, undefined, undefined, undefined, undefined, 0);
  alt_circle namespace_8c7f8f6b3076a74a::function_847531f882fe30d0(0);

  if(!isDefined(level.var_9cbfa5c9dba98046) || level.var_9cbfa5c9dba98046 <= 0) {
    flag_set("mansion_cleared");
  }

  flag_wait("mansion_cleared");
  alt_circle notify("obj_enter_house_completed");
  flag_set("obj_enter_house_completed");
}

function function_49e50566759b128(objectivestruct, var_5dcdfd3a4eff9961) {
  thread namespace_92dad0b6b79ce1::function_18871f933340b91b();
  level notify("end_drone_encounter");
  wait 1.5;
  flag_wait("vo_mansion_door_unlock");
  var_3c62acd3887668c3 = getStruct("obj_interact_suite", "targetname");
  var_3c62acd3887668c3 thread namespace_9d6ed0911e2ddf09::function_dc3c295fcb6d7c77(7, "obj_hack_door_completed", undefined, undefined, 1, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  level.var_92df06b8e01dfab7 delete();
  var_cffca1a9623f41d5 = var_3c62acd3887668c3 create_interact(undefined, (0, 0, 0), 45, undefined, &"CP_JUP_RESORT/OPEN_SAFEROOM");
  var_cffca1a9623f41d5 setuseholdduration("duration_short");
  var_cffca1a9623f41d5 setusefov(30);
  var_cffca1a9623f41d5 sethintdisplayfov(30);
  var_cffca1a9623f41d5 waittill("trigger");
  var_cffca1a9623f41d5 delete();
  thread function_1364d4e78e9acc35("door_suite");
  var_3c62acd3887668c3 notify("obj_hack_door_completed");
  flag_set("obj_hack_door_completed");
}

function function_a4fc30e535ab3011() {
  thread function_4e257994365fa73f("intro_mover_second_path_01", "trigger_multiple_intro_mover");
  thread function_4e257994365fa73f("intro_mover_second_path_02", "trigger_multiple_intro_mover");
  thread function_4e257994365fa73f("intro_mover_second_path_03", "trigger_multiple_intro_mover");
  thread function_4e257994365fa73f("intro_mover_second_path_04", "trigger_multiple_intro_mover");
}

function function_ead8c04c2845b98e() {
  thread function_4e257994365fa73f("patio_mover_second_path", "trigger_radius_patio_mover");
}

function function_c8e272d6f4290ddf() {
  thread function_4e257994365fa73f("sitting_mover_second_path_01", "trigger_radius_sitting_mover");
  thread function_4e257994365fa73f("sitting_mover_second_path_02", "trigger_radius_sitting_mover");
}

function function_e6ff6cfa83afc505() {
  thread function_4e257994365fa73f("cy_mover_01_second_path_01", "trigger_multiple_cy_mover_01");
  thread function_4e257994365fa73f("cy_mover_01_second_path_02", "trigger_multiple_cy_mover_01");
}

function function_40138af0c81cb590() {
  thread function_4e257994365fa73f("cy_mover_02_second_path", "trigger_radius_cy_mover_02");
}

function function_a5e6f7add71ad68c() {
  flag_wait("bunker_door_open");
  thread flag_set("ai_bunker_mover_path_01");
  thread flag_set("ai_bunker_mover_path_02");
  flag_wait("ai_bunker_mover_path_01");
  temp_dialogue("bunker mover 01 active");
  flag_wait("ai_bunker_mover_path_02");
  temp_dialogue("bunker mover 02 active");
}

function function_aaf3fa7642b6a2e2() {
  flag_wait("flag_parking_area");
  thread function_fe662b4f5891e15e();
  function_9abe9350cc74539e("parking_arrive_2", 20, &function_670dee0b0020368e);
  wait 2;
  function_9abe9350cc74539e("parking_arrive_1", 20, &function_670dee0b0020368e);
  wait 1;
  function_6149b301ce19988b("ai_parking_start", &function_5b8a63cfe55d3670);
  flag_wait("ai_combat_active");
  namespace_15c7ce84dd21743d::function_5e59fcaf5bbe49c7();
}

function function_dc042011cd0bf02a(type) {
  level notify("level_setting_stealth_ranges");
  level endon("level_setting_stealth_ranges");

  while(!isDefined(level.stealth)) {
    waitframe();
  }

  if(!flag_exist("stealth_ranges_initialized")) {
    function_fb457f7cdf0ac39e();
  }

  switch (type) {
    case #"hash_7038dec66d8275be":
      level.event_distances["spotted"]["bottle_impact"] = 800;
      level.event_distances["hidden"]["bottle_impact"] = 800;
      break;
    case #"hash_334c896e25dc8345":
      level.event_distances["spotted"]["explosion"] = 200;
      level.event_distances["hidden"]["explosion"] = 200;
      level.event_distances["spotted"]["grenade_ping"] = 200;
      level.event_distances["hidden"]["grenade_ping"] = 200;
      level.event_distances["spotted"]["gunshot"] = 200;
      level.event_distances["hidden"]["gunshot"] = 200;
      level.event_distances["spotted"]["bottle_impact"] = 800;
      level.event_distances["hidden"]["bottle_impact"] = 800;
      scripts\stealth\manager::set_custom_distances(level.event_distances);
      break;
    default:
      assertmsg("set_stealth_ranges( type ) - invalid type specified");
      break;
  }
}

function function_fb457f7cdf0ac39e() {
  hiddenranges["prone"] = 750;
  hiddenranges["crouch"] = 900;
  hiddenranges["stand"] = 1200;
  spottedranges["prone"] = 900;
  spottedranges["crouch"] = 1000;
  spottedranges["stand"] = 1500;
  hiddenranges["shadow_prone"] = 0.05;
  hiddenranges["shadow_crouch"] = 0.05;
  hiddenranges["shadow_stand"] = 0.3;
  spottedranges["shadow_prone"] = 0.01;
  spottedranges["shadow_crouch"] = 0.02;
  spottedranges["shadow_stand"] = 0.38;
  var_8f3f480583606401["prone"] = 1.1;
  var_8f3f480583606401["crouch"] = 1.15;
  var_8f3f480583606401["stand"] = 1.2;
  scripts\stealth\utility::set_detect_ranges(hiddenranges, spottedranges, var_8f3f480583606401);
  var_b6b642cbeff52b88["prone"] = 150;
  var_b6b642cbeff52b88["crouch"] = 350;
  var_b6b642cbeff52b88["stand"] = 200;
  var_d0f35fc0a5c3df79["prone"] = 250;
  var_d0f35fc0a5c3df79["crouch"] = 1000;
  var_d0f35fc0a5c3df79["stand"] = 1800;
  scripts\stealth\utility::set_min_detect_range_darkness(var_b6b642cbeff52b88, var_d0f35fc0a5c3df79);
  var_fac370d058479827["prone"] = 0;
  var_fac370d058479827["crouch"] = 0;
  var_fac370d058479827["stand"] = 0;
  var_fb574b7959625bf0["prone"] = 0;
  var_fb574b7959625bf0["crouch"] = 0;
  var_fb574b7959625bf0["stand"] = 0;
  scripts\stealth\utility::function_f3883fe06a11269(var_fac370d058479827, var_fb574b7959625bf0);
  function_531194f673a06de5(1);
  function_d5823c94e8131ea6(1);
  level.valstruct val::set("level", "ai_eventlist", "jup_resort_aieventlist");
  flag_set("stealth_ranges_initialized");
}

function function_f98463d49e2f9067(var_4f855452f4b35b26, override_damage_sight_range) {
  var_4f855452f4b35b26 = default_to(var_4f855452f4b35b26, "jup_sandbox_dark");
  function_6afcdc96a6ce9a56(var_4f855452f4b35b26, undefined, override_damage_sight_range);
  namespace_a0852b262a68d01::function_fac67371e80874db();
  function_82a45e8aef44ce3f(&function_a99a065bb118eed8);
  level thread function_d93d63b293881b1f(self);
  self.var_98add129a7ecb962 = 0;
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

function function_414c8b007be6ffbe(group_name, func) {
  thread function_f98463d49e2f9067();
}

function function_1161ecf48b5e1a4a(group_name, func) {
  thread function_f98463d49e2f9067();
}

function function_f767f3004323b8a(group_name, func) {
  thread function_f98463d49e2f9067();
}

function function_bec8e85f4a14315b(group_name, func) {
  thread function_f98463d49e2f9067();
}

function function_d5c4b61b1a73ccf3(group_name, func) {
  thread function_f98463d49e2f9067();
}

function function_5ef0dc9b042588f4(group_name, func) {
  thread function_f98463d49e2f9067();
}

function function_4f6fbde2daa70985(group_name, func) {
  thread function_f98463d49e2f9067();
}

function function_2724a589a8407028(group_name, func) {
  thread function_f98463d49e2f9067();
  level.var_9cbfa5c9dba98046 = default_to(level.var_9cbfa5c9dba98046, 0);
  flag_set("mansion_ai_spawned");
  level.var_9cbfa5c9dba98046++;
  thread function_13a00d848acd4866();
}

function function_c38fd2e368e2d565(group_name, func) {
  thread function_f98463d49e2f9067();
  level.var_9cbfa5c9dba98046 = default_to(level.var_9cbfa5c9dba98046, 0);
  flag_set("mansion_ai_spawned");
  flag_set("final_mansion_ai_spawned");
  level.var_9cbfa5c9dba98046++;
  thread function_13a00d848acd4866();
}

function function_13a00d848acd4866() {
  self waittill("death");
  level.var_9cbfa5c9dba98046 -= 1;

  if(flag("final_mansion_ai_spawned") && level.var_9cbfa5c9dba98046 <= 0) {
    flag_set("mansion_cleared");
  }
}

function function_549e7b2d3d61cdd4(group_name, func) {
  thread function_f98463d49e2f9067();
}

function function_c8440bc694580b96(group_name, func) {
  thread function_f98463d49e2f9067();
  thread function_60dc5c690ccc2a2c(&function_c89faf236aaf59dc);
}

function function_4ae85c01d8db421b(group_name, func) {
  thread function_f98463d49e2f9067();
  self.var_11bb3b9a5482848c = &function_ab4aa528604a3a65;
  thread function_60dc5c690ccc2a2c(&function_c89faf236aaf59dc);
}

function function_380b96fc6b2bfdca(group_name, func) {
  thread function_f98463d49e2f9067();
  thread function_60dc5c690ccc2a2c(&function_c89faf236aaf59dc);
}

function function_90a9870f3f553705(group_name, func) {
  thread function_f98463d49e2f9067();
  thread function_60dc5c690ccc2a2c(&function_c89faf236aaf59dc);
}

function function_7a11a7ed7f58261b(group_name, func) {
  thread function_f98463d49e2f9067();
  thread function_60dc5c690ccc2a2c(&function_c89faf236aaf59dc);
}

function function_b88d0718aba21878(group_name, func) {
  thread function_f98463d49e2f9067();
  thread function_60dc5c690ccc2a2c(&function_c89faf236aaf59dc);
}

function function_3f3f8dac28cf5a20(group_name, func) {
  thread function_f98463d49e2f9067();
}

function function_148495c7632d7914(group_name, func) {
  thread function_f98463d49e2f9067();
}

function function_5b8a63cfe55d3670(group_name, func) {
  thread function_f98463d49e2f9067();
}

function function_72e8d34ec1e16ae6() {
  var_75f54d205f93170b = getEnt("bunker_button_off", "targetname");
  button_on = getEnt("bunker_button_on", "targetname");
  button_on hide();
  flag_wait("bunker_door_open");
  button_on show();
  var_75f54d205f93170b hide();
}

function function_a99a065bb118eed8() {
  thread function_6e91939ff8132810(self.enemy_group);
  return false;
}

function function_d525f1534752bfc7() {
  setDvar(@ "sm_sunsamplesizenear", 1.25);
  setDvar(@ "hash_7686fcb92ccc5edb", 4);
  setDvar(@ "r_umbraaccurateocclusionthreshold", 2048);
  setDvar(@ "hash_1dde331a8e0153d8", 8);
  setDvar(@ "hash_63eb1893f96ac98d", 8);
  flag_set("infil_complete");
}

function function_f75be718055ec2b3() {
  level endon("scene_skipped");
  wait 24.5;
  level notify("show_chyrons");
}

function function_222bef19da9c23a4() {
  level endon("game_ended");
  flag_wait("dungeon_load_finished");
  level thread play_intro();
  flag_wait("flag_dungeon_intro_complete");
  thread namespace_4233a486fa2720a3::function_43a408ee2ba42d1a();
  thread function_bbbe8a635002a8aa();
  thread function_26ff93ecdca5aed3();
  function_7f95d1ca737bd1e1("obj_laptop2", 0.5);
  function_7f95d1ca737bd1e1("obj_laptop3", 0.5);
  flag_set("obj_laptops_all_completed");
  function_7f95d1ca737bd1e1("obj_hack_terminal", 2.5);
  function_7f95d1ca737bd1e1("obj_enter_house", 1.5);
  function_7f95d1ca737bd1e1("obj_hack_door", 1.5);
  wait 0.25;
  namespace_9766820f5baa93fb::function_cd054d9ba5a62557(0);
  function_c1cadb469d19553c();
  function_fa7c87f2585bd907(1);
}

function function_bbbe8a635002a8aa() {
  wait 10;
  namespace_b96fa4d8ce10f926::function_6ae6331457ff833d();
}

function function_26ff93ecdca5aed3() {
  level endon("game_ended");
  var_47bc47f1f354f84e = getEnt("obj_trigger_house", "targetname");
  var_47bc47f1f354f84e namespace_59351a8acd36b6f7::function_393cdd52ca5dd62f();
  anim_org = function_7a18da6e48b71c35("resort_milena_exfil");
  anim_org scripts\common\scene::pre_stream(undefined, "shot_010", -1, "jup_resort_torture");
  level.player setclientomnvar("ui_hide_hud", 0);
  var_a731d8d7bcac5ca3 = getStruct("resort_milena_exfil_igc", "targetname");
  anim_ents = anim_org scripts\common\scene::get_entities();

  foreach(anim_ent in anim_ents) {
    if(isDefined(anim_ent.targetname) && anim_ent.targetname == "milena_door") {
      continue;
    }

    anim_ent.origin = var_a731d8d7bcac5ca3.origin;
  }
}

function function_55a6bd29dc0b31e4() {
  level endon("game_ended");
  wait 1;
  flag_wait("Player_in_detected");
  objstruct = level.objectivestabledata["obj_kill_enemies"];
  initializeobjective(objstruct, "obj_kill_enemies", "secondary");
  startobjective(objstruct, "obj_kill_enemies", "secondary");
  function_be5b0ca6e6af0094();
  completeobjective(objstruct, "obj_kill_enemies", "secondary");
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

        if(incombat > 3) {
          break;
        }
      }
    }

    if(incombat > 3) {
      flag_set("ai_combat_active");
      continue;
    }

    flag_clear("ai_combat_active");
  }
}

function car_alarm_triggered(instance, note, param, var_535d9c3fdddab5a9) {
  radius = 1000;
  enemiesnearby = getaiarrayinradius(self.origin, radius, "axis");

  foreach(e in enemiesnearby) {
    if(!isDefined(e.stealth)) {
      continue;
    }

    if(e scripts\stealth\utility::function_6a86dd83c01f8faa()) {
      continue;
    }

    if(istrue(e.ignoreall)) {
      continue;
    }

    e aieventlistenerevent("investigate", self, self.origin);
  }
}

function setup_map_specific_devgui() {
  function_cab08c75e0639ea0();
  thread function_fe7190fff126ce();
}

function function_fe7190fff126ce() {
  while(true) {
    cmdline = getDvar(@ "hash_b41d06ce44629d22", "<dev string:x8f>");

    if(cmdline != "<dev string:x8f>") {
      args = strtok(cmdline, "<dev string:x90>");

      switch (args[0]) {
        case #"hash_289aea6c1f0ef491":
          if(args.size > 1 && args[1] == "<dev string:x96>") {
            level.player scripts\cp\utility::showminimap();
            break;
          }

          level.player scripts\cp\utility::hideminimap(1);
          break;
        case #"hash_fa18b9f6bd576aff":
          idx = 0;

          if(args.size > 1) {
            idx = int(args[1]);
            setDvar(@ "ai_debugentindex", idx);
          }

          setDvar(@ "hash_2ecb315411595807", 1);
          setDvar(@ "ai_showpaths", 1);
          setDvar(@ "hash_88d8ab419125d09", 0);
          break;
        case #"hash_35d2e318f376a5f5":
          flag_set("<dev string:xb1>");
          break;
        case #"hash_58235f15856f6160":
          function_4864d91745d2b954();
          break;
        case #"hash_da38429cc03cf6c4":
          var_8c7cb31a334adfc0 = function_87ce7c6cba6c393();
          iprintln("<dev string:xcf>" + var_8c7cb31a334adfc0.size + "<dev string:xd7>");
          break;
      }

      setDvar(@ "hash_b41d06ce44629d22", "<dev string:x8f>");
    }

    wait 0.1;
  }
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

function function_cab08c75e0639ea0(player, name, num) {
  cmd = "<dev string:xe2>";
  addentrytodevgui(cmd);
  cmd = "<dev string:x12b>";
  addentrytodevgui(cmd);
  cmd = "<dev string:x179>";
  addentrytodevgui(cmd);
}

# /