/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\favela.gsc
********************************************************/

#include maps\_utility;
#include maps\_vehicle;
#include common_scripts\utility;
#include maps\_anim;
#include maps\favela_code;

PLAYER_SPRINT_SCALE = 1.4;

main() {
  array_call(getEntArray("ammo_crate_part", "targetname"), ::delete);
  array_call(getEntArray("ammo_crate_clip", "targetname"), ::delete);
  array_call(getEntArray("ammo_cache", "targetname"), ::delete);

  setDvarIfUninitialized("favela_trailer", "0");

  setsaveddvar("r_lightGridEnableTweaks", 1);
  setsaveddvar("r_lightGridIntensity", 1.5);
  setsaveddvar("r_lightGridContrast", 0);

  default_start(::startStreet);
  add_start("street", ::startStreet);
  add_start("chase", ::startChase);
  add_start("favela", ::startFavela);
  add_start("torture", ::startTortureTrailer);
  add_start("soccer", ::startSoccer);
  add_start("hilltop", ::startHilltop);
  add_start("trailer1", ::trailer_talkers_1);
  add_start("trailer2", ::trailer_talkers_2);
  add_start("trailer3", ::trailer_talkers_3);
  add_start("end", ::startEnd);

  maps\createart\favela_fog::main();
  maps\createart\favela_art::main();
  maps\createfx\favela_audio::main();
  maps\favela_precache::main();
  maps\favela_fx::main();
  maps\_drone_ai::init();
  animscripts\dog\dog_init::initDogAnimations();
  maps\_hiding_door_anims::main();
  maps\_load::set_player_viewhand_model("viewhands_player_tf141_favela");
  maps\_load::main();
  maps\favela_anim::main();
  maps\_compass::setupMiniMap("compass_map_favela");
  thread maps\favela_amb::main();

  level.ai_friendlyFireBlockDuration = getdvarfloat("ai_friendlyFireBlockDuration");

  level.advanceToEnemyInterval = 30000;
  level.advanceToEnemyGroupMax = 1;
  level.lastWallaTime = getTime();

  level.physics_drop_models[0] = "trash_container_big2";
  level.physics_drop_models[1] = "com_milk_carton";
  level.physics_drop_models[2] = "com_bottle4";
  level.physics_drop_models[3] = "trash_cup_tall3";
  level.physics_drop_models[4] = "trash_plate1";
  level.physics_drop_models[5] = "trash_can1";
  level.physics_drop_models[6] = "trash_can2";
  level.physics_drop_models[7] = "trash_can3";
  level.physics_drop_models[8] = "trash_can4";
  foreach(model in level.physics_drop_models)
  precacheModel(model);

  precacheString(&"FAVELA_OBJ_CATCH_RUNNER");
  precacheString(&"FAVELA_OBJ_REACH_TOP");
  precacheString(&"FAVELA_OBJ_CAPTURE");
  precacheString(&"FAVELA_KILLED_RUNNER");
  precacheString(&"FAVELA_RUNNER_GOT_AWAY");
  precacheString(&"FAVELA_ROJAS_KILLED");

  precacheShader("black");

  precacheItem("rpg_straight");
  precacheItem("flash_grenade");

  precacheModel("com_bike_animated");
  precacheModel("curtain_torn01_animated");
  precacheModel("machinery_car_battery");
  precacheModel("vehicle_hummer_hula_girl");

  array_spawn_function_noteworthy("delete_at_path_end", ::delete_ai_at_path_end);
  array_spawn_function_noteworthy("delete_at_path_end_no_choke", ::delete_ai_at_path_end_no_choke);
  array_spawn_function_noteworthy("seek_player", ::seek_player);
  array_spawn_function_noteworthy("dog_seek_player", ::dog_seek_player);
  array_spawn_function_noteworthy("delete_at_goal", ::delete_ai_at_goal);
  array_spawn_function_noteworthy("dont_see_player_no_choke", ::dont_see_player);
  array_spawn_function_noteworthy("ignore_and_delete_on_goal", ::ignore_and_delete_on_goal);
  array_spawn_function_noteworthy("ignore_and_delete_on_goal_nosight", ::ignore_and_delete_on_goal, true);
  array_spawn_function_noteworthy("window_smasher", ::window_smasher);
  array_spawn_function_noteworthy("ignored_until_goal", ::ignored_until_goal);
  array_spawn_function_noteworthy("desert_eagle_guy", ::desert_eagle_guy);
  array_spawn_function_noteworthy("faust", ::faust_spawn_func);
  array_spawn_function_noteworthy("civilian_driver", ::civilian_driver);

  all_axis_spawners = getspawnerteamarray("axis");
  script_parameter_spawners = [];
  foreach(spawner in all_axis_spawners) {
    if(!isDefined(spawner.script_parameters))
      continue;
    script_parameter_spawners[script_parameter_spawners.size] = spawner;
  }
  array_spawn_function(script_parameter_spawners, ::process_ai_script_parameters);
  array_spawn_function(getSpawnerTeamArray("neutral"), ::civilian_flee_walla);

  array_thread(getEntArray("play_sound", "targetname"), ::play_sound_trigger);
  array_thread(getEntArray("trigger_chance", "targetname"), ::trigger_spawn_chance);
  array_thread(getEntArray("physics_drop", "targetname"), ::physics_drop);
  array_thread(getEntArray("trigger_cleanup", "targetname"), ::trigger_cleanup);
  array_thread(getEntArray("potted_plant", "targetname"), ::potted_plant);
  array_thread(getEntArray("play_fx_trig", "targetname"), ::play_fx_trig);
  array_thread(getEntArray("retreat_trigger", "targetname"), ::retreat_trigger);
  array_thread(getEntArray("curtain_pulldown", "script_noteworthy"), ::curtain_pulldown);
  array_thread(getEntArray("curtain_pulldown_playerwait", "script_noteworthy"), ::curtain_pulldown, true);
  array_thread(getvehiclenodearray("car_screech_node", "script_noteworthy"), ::car_screech_node);
  add_global_spawn_function("axis", ::adjustAccuracy);

  flag_init("favela_gate_dialog_done");
  flag_init("car_getting_shot");
  flag_init("driver_dead");
  flag_init("player_is_ducking");
  flag_init("favela_music");
  flag_init("faust_music");
  flag_init("opening_scene_started");
  flag_init("favela_enemies_spawned");
  flag_init("start_chase");
  flag_init("block_alley");
  flag_init("favela_move_friendlies");
  flag_init("favela_civilians_fleeing");
  flag_init("allow_meat_death");
  flag_init("allow_royce_death");
  flag_init("civilians_walla");
  flag_init("torture_sequence_done");
  flag_init("van_skid");
  flag_init("makarov_alley_wounded");
  flag_init("favela_civilians_alerted");
  flag_init("favela_civilians_spawned");
  flag_init("ending_sequence_ready");
  flag_init("ending_sequence_started");
  flag_init("ending_sequence_dialog");
  flag_init("start_final_dialog");
  flag_init("visionset_chase");
  flag_init("visionset_torture");
  flag_init("soap_exits_car");

  trigger_off("favela_opening_civilians_spawn", "targetname");

  thread vision_chase();
  thread vision_torture();
  thread gag_fence_dog();
  thread gag_civilian_window_1();
  thread favela_opening_civilians();
  thread favela_music();
  thread upper_village_triggered_dialog();
  thread upper_village_music();
  thread random_favela_background_runners();
  thread faust_appearance_1();
  thread faust_appearance_2();
  thread faust_appearance_3();
  thread faust_appearance_4();
  thread street_scenes();
  thread chase();
  thread forklift_blocker();
  thread final_bend_dialog();
  thread final_staircase_dialog();
  thread ending_sequence();

  skill = getDifficulty();
  if(skill != "hard" && skill != "fu") {
    setsaveddvar("ai_accuracy_attackerCountMax", 4);
    setsaveddvar("ai_accuracy_attackerCountDecrease", 0.6);
  }
}

startStreet() {
  thread battlechatter_off("allies");
  thread battlechatter_off("axis");

  setSavedDvar("compass", 0);
  setSavedDvar("hud_showStance", 0);

  thread start_traffic_group(3.5, "traffic_car_groupA_1", "traffic_car_groupA_2");
  thread start_traffic_group(5.0, "traffic_car_groupB_1", "traffic_car_groupB_2");

  array_thread(getEntArray("street_civilian", "targetname"), ::spawn_ai, true);
  delayThread(8.0, ::bike_rider, "bike_path_1");
  delayThread(13.0, ::bike_rider, "bike_path_2");

  thread opening_scene();
  thread intro_music();
}

intro_music() {
  thread music_play("favela_intro");

  level waittill("runner_shot");

  music_stop(2.0);
}

startChase() {
  thread battlechatter_off("allies");
  thread battlechatter_off("axis");

  movePlayerToStartPoint("playerstart_chase");
  setSavedDvar("player_sprintUnlimited", "1");
  setSavedDvar("player_sprintSpeedScale", PLAYER_SPRINT_SCALE);
  flag_set("start_chase");
  flag_set("visionset_chase");
}

startTortureTrailer() {
  setDvar("favela_trailer", 1);
  thread startFavela();
}

startFavela() {
  thread battlechatter_off("allies");
  thread battlechatter_off("axis");

  thread fade_to_black_alley(0.2, 2.0, 2.5);

  level waittill("black_screen_start");

  level.player giveWeapon("fraggrenade");
  level.player setOffhandSecondaryClass("flash");
  level.player giveWeapon("flash_grenade");

  level notify("stop_monitoring_makarov_damage");

  thread delete_ai_during_blackscreen();
  array_call(getCorpseArray(), ::delete);
  if(isDefined(level.runner))
    level.runner delete();

  flag_set("visionset_torture");

  level delayThread(1.2, ::torture_sequence);

  movePlayerToStartPoint("playerstart_favela");
  activate_trigger("favela_vision", "script_noteworthy");

  flag_set("civilians_walla");
  enablePlayerWeapons(false);

  level.disable_destructible_bad_places = undefined;

  level.player setStance("stand");

  setSavedDvar("player_sprintUnlimited", "0");
  setSavedDvar("player_sprintSpeedScale", 1.5);
  assert(isDefined(level.ai_friendlyFireBlockDuration));
  setSavedDvar("ai_friendlyFireBlockDuration", level.ai_friendlyFireBlockDuration);

  flag_clear("player_near_stairs");

  flag_set("block_alley");

  level waittill("black_screen_finish");

  thread autosave_now();
  thread timed_favela_autosaves();

  favela_friendlies();

  flag_clear("give_favela_warning");
  trigger_on("favela_opening_civilians_spawn", "targetname");
  getent("favela_enter_player_clip", "targetname") delete();

  wait 0.05;

  thread modify_battlechatter_times();

  flag_wait("favela_move_friendlies");

  flag_set("favela_music");

  enablePlayerWeapons(true);

  thread add_top_of_hill_objective();
  thread favela_gate();
  thread favela_warning();
  thread favela_dialog();
  thread soccer_dialog();
  thread meat_dies();
  thread royce_dies();
}

startSoccer() {
  add_top_of_hill_objective();
  array_call(getEntArray("delete_for_start_soccer", "script_noteworthy"), ::delete);
  movePlayerToStartPoint("playerstart_soccer");
  activate_trigger("vision_shanty", "script_noteworthy");
  flag_set("civilians_walla");
}

startHilltop() {
  add_top_of_hill_objective();
  movePlayerToStartPoint("playerstart_hilltop");
  activate_trigger("favela_hill", "script_noteworthy");
  flag_set("civilians_walla");
}

trailer_talkers_1() {
  spawn_talkers("trailer_talkers_1");
  level.player set_ignoreme(true);
  movePlayerToStartPoint("trailer_talkers_1_player");
}

trailer_talkers_2() {
  spawn_talkers("trailer_talkers_2");
  level.player set_ignoreme(true);
  movePlayerToStartPoint("trailer_talkers_2_player");
}

trailer_talkers_3() {
  spawn_talkers("trailer_talkers_3");
  level.player set_ignoreme(true);
  movePlayerToStartPoint("trailer_talkers_3_player");
}

spawn_talkers(targetname) {
  spawners = getEntArray(targetname, "targetname");
  foreach(spawner in spawners) {
    guy = spawner spawn_ai(true);
    guy set_ignoreall(true);
    guy.goalradius = 16;
    guy setGoalPos(guy.origin);
    if(!isDefined(spawner.animation))
      continue;
    guy.animname = "trailer";
    guy thread anim_loop_solo(guy, spawner.animation);
  }
}

startEnd() {
  add_top_of_hill_objective();
  movePlayerToStartPoint("playerstart_end");
  activate_trigger("favela_vision", "script_noteworthy");
}

favela_gate() {
  thread favela_gate_dialog();
}

favela_gate_dialog() {
  flag_wait("torture_sequence_done");

  level.royce anim_single_solo(level.royce, "favela_ryc_letsgo");

  flag_wait("player_near_stairs");

  level.royce anim_single_solo(level.royce, "favela_ryc_watchyourbg");

  flag_set("favela_gate_dialog_done");
}

torture_sequence() {
  node = getent("torture_node", "targetname");
  door = getent("torture_door", "targetname");

  torture_enemy_spawner_targetname = "torture_enemy_spawner";
  if(getdvarint("favela_trailer") > 0)
    torture_enemy_spawner_targetname = "torture_enemy_spawner_trailer";

  guys[0] = spawn_targetname(torture_enemy_spawner_targetname);
  guys[0].animname = "torture_enemy";

  guys[1] = spawn_targetname("torture_friendly_1_spawner");
  guys[1].animname = "torture_friend1";

  guys[2] = spawn_targetname("torture_friendly_2_spawner");
  guys[2].animname = "torture_friend2";

  foreach(guy in guys) {
    guy set_ignoreme(true);
    guy set_ignoreall(true);
  }

  jumper_cables = spawn_anim_model("torture_cables", node.origin);
  guys[3] = jumper_cables;

  battery_origin = (-527, -1043.5, 725);
  battery_angles = (0, 289.5, 0);
  car_battery = spawn("script_model", battery_origin);
  car_battery.angles = battery_angles;
  car_battery setModel("machinery_car_battery");

  guys[2] thread torture_sequence_door(door);

  guys[2] setLookAtEntity(level.player);

  guys[0] thread play_sound_on_entity("scn_favela_captive_in_chair");
  garagePos = guys[0].origin;

  node anim_single(guys, "torture");

  array_call(guys, ::delete);

  flag_set("torture_sequence_done");
  flag_set("favela_move_friendlies");

  thread play_sound_in_space("scn_favela_garage_interior", garagePos);
}

torture_sequence_door(door) {
  finalDoorPos = door.origin;
  startingDoorPos = door.origin + (0, 0, 45);
  door.origin = startingDoorPos;

  flag_wait("drop_door");

  door playSound("scn_favela_garage_door");
  door moveTo(finalDoorPos, 1.3, 0.1, 0.0);
}

opening_scene() {
  thread hotel_doors();

  player_vehicle = spawn_vehicle_from_targetname_and_drive("player_vehicle");
  assert(isDefined(player_vehicle));
  player_vehicle hidepart("TAG_GLASS_FRONT_D");
  player_vehicle hidepart("TAG_BLOOD");
  player_vehicle thread car_anims();
  player_vehicle thread car_driver_anims();
  player_vehicle thread play_sound_on_entity("scn_favela_driveup");
  thread player_rides_vehicle(player_vehicle);

  van = spawn_vehicle_from_targetname_and_drive("van");
  assert(isDefined(van));
  van godon();
  van thread van_skid_sound();
  van.animname = "van";
  van SetAnimTree();

  player_vehicle Vehicle_SetSpeed(3, 5.0, 5.0);
  van Vehicle_SetSpeed(3, 5.0, 5.0);

  wait 4;

  thread opening_scene_dialog();

  player_vehicle resumeSpeed(2.5);
  van resumeSpeed(2.5);

  vehNode = getVehicleNode("van_last_node", "script_noteworthy");
  vehNode waittill("trigger");

  animNode = getent("opening_scene_node", "targetname");

  makarov_spawner = getent("makarov_spawner", "targetname");
  driver_spawner = getent("opening_driver_spawner", "targetname");
  gunner1_spawner = getent("opening_gunner1_spawner", "targetname");
  gunner2_spawner = getent("opening_gunner2_spawner", "targetname");

  wait 1;

  makarov = makarov_spawner spawn_ai(true);
  makarov.animname = "makarov";
  makarov thread magic_bullet_shield();
  makarov.ignorerandombulletdamage = true;
  makarov.grenadeawareness = 0;

  driver = driver_spawner spawn_ai(true);
  driver.animname = "driver";
  driver thread opening_death();
  driver thread blood_driver();

  gunner1 = gunner1_spawner spawn_ai(true);
  gunner1.animname = "gunner1";
  gunner1 thread opening_death();
  gunner1 thread blood_gunner1();

  gunner2 = gunner2_spawner spawn_ai(true);
  gunner2.animname = "gunner2";
  gunner2 thread opening_death();
  gunner2 thread blood_gunner2();

  guys[0] = makarov;
  guys[1] = driver;
  guys[2] = gunner1;
  guys[3] = gunner2;

  street_clip = getent("street_civilian_clip", "targetname");
  street_clip connectPaths();
  street_clip delete();

  flag_set("opening_scene_started");
  van thread van_door_sounds();
  van thread anim_single_solo(van, "door_open");
  animNode anim_single(guys, "opening_scene");

  level notify("end_scene");
  thread stop_traffic();

  animNode thread anim_loop_solo(makarov, "opening_scene_shoot", "stop_shooting");
  thread break_windshield(player_vehicle);
  makarov makarov_shoot_player(player_vehicle);
  animNode notify("stop_shooting");
  makarov anim_stopanimscripted();

  runner_first_node = getnode("runner_first_node", "targetname");
  makarov.goalradius = 32;
  makarov thread delete_ai_at_goal(true);
  makarov set_ignoreall(true);
  makarov setGoalNode(runner_first_node);

  thread delayThread(1.0, ::flag_set, "start_chase");

  player_vehicle thread play_sound_on_entity("scn_favela_npc_door_open");

  wait 2;

  thread player_exits_vehicle(player_vehicle);
  flag_set("visionset_chase");
}

player_rides_vehicle(vehicle) {
  level endon("exiting_vehicle");

  enablePlayerWeapons(false);

  MAX_ROTATE_ANG = 66;

  player_rig = spawn_anim_model("player_rig");
  player_rig.origin = vehicle getTagOrigin("tag_passenger");
  player_rig.angles = vehicle getTagAngles("tag_passenger");
  player_rig linkTo(vehicle, "tag_passenger");
  player_rig hide();

  player_rig thread player_dies_in_vehicle();

  level.player playerLinkToDelta(player_rig, "tag_player", 1.0, MAX_ROTATE_ANG, MAX_ROTATE_ANG, 45, 20);
  level.player allowProne(false);
  level.player allowCrouch(false);
  level.player allowStand(true);
  flag_clear("player_is_ducking");

  level.player endon("death");

  level.player setStance("stand");
  player_rig thread anim_first_frame_solo(player_rig, "duck_down");

  notifyOnCommand("go_crouch", "+movedown");
  notifyOnCommand("go_crouch", "+prone");
  notifyOnCommand("go_crouch", "+stance");
  notifyOnCommand("go_crouch", "lowerstance");
  notifyOnCommand("go_crouch", "togglecrouch");
  notifyOnCommand("go_crouch", "toggleprone");
  notifyOnCommand("go_crouch", "goprone");
  notifyOnCommand("go_crouch", "gocrouch");

  notifyOnCommand("go_stand", "+stance");
  notifyOnCommand("go_stand", "raisestance");
  notifyOnCommand("go_stand", "togglecrouch");
  notifyOnCommand("go_stand", "toggleprone");
  notifyOnCommand("go_stand", "+moveup");
  notifyOnCommand("go_stand", "+gostand");

  for(;;) {
    level.player waittill("go_crouch");
    flag_set("player_is_ducking");
    level.player enableInvulnerability();
    level.player lerpViewAngleClamp(0.3, 0, 0, 25, 25, 25, 0);
    player_rig anim_single_solo(player_rig, "duck_down");
    player_rig thread anim_loop_solo(player_rig, "duck_down_idle", "stop_down_idle");

    level.player waittill("go_stand");
    level.player lerpViewAngleClamp(0.3, 0, 0, MAX_ROTATE_ANG, MAX_ROTATE_ANG, 45, 20);
    player_rig notify("stop_down_idle");
    player_rig anim_single_solo(player_rig, "duck_up");
    flag_clear("player_is_ducking");
    level.player disableInvulnerability();
  }
}

player_dies_in_vehicle() {
  level endon("exiting_vehicle");

  level.player waittill("shot_next_frame");

  level.player lerpViewAngleClamp(0, 0, 0, 0, 0, 0, 0);
  self anim_single_solo(self, "die");
}

player_exits_vehicle(vehicle) {
  wait 1.2;

  level notify("exiting_vehicle");

  vehicle notify("door_open");

  exit_point = getent("player_vehicle_exit_point", "targetname");

  dummy = spawn("script_model", level.player.origin);
  dummy.angles = level.player.angles;
  dummy setModel("tag_origin");
  level.player playerLinkTo(dummy, "tag_player", 1.0, 45, 45, 45, 20);

  MOVETIME = 1.5;
  ACCEL = 0.3;
  DECEL = 0.3;
  dummy moveTo(exit_point.origin, MOVETIME, ACCEL, DECEL);
  dummy rotateTo(exit_point.angles, MOVETIME, ACCEL, DECEL);

  wait MOVETIME;

  level.player unlink();
  level.player disableInvulnerability();
  enablePlayerWeapons(true);

  level.player allowProne(true);
  level.player allowCrouch(true);
  level.player allowStand(true);
  level.player setStance("stand");

  setSavedDvar("player_sprintUnlimited", "1");
  setSavedDvar("player_sprintSpeedScale", PLAYER_SPRINT_SCALE);
}

van_skid_sound() {
  flag_wait("van_skid");
  self thread play_sound_on_entity("scn_favela_van_skid2stop");
}

van_door_sounds() {
  self thread delayThread(0.0, ::play_sound_on_entity, "scn_favela_van_door_open");
  self thread delayThread(2.3, ::play_sound_on_entity, "scn_favela_van_driverdoor_open");
  self thread delayThread(2.8, ::play_sound_on_entity, "scn_favela_van_door_close");
  self thread delayThread(4.0, ::play_sound_on_entity, "scn_favela_van_driverdoor_close");
}

opening_scene_dialog() {
  wait 2.0;

  radio_dialogue("favela_cmt_ready2move");

  radio_dialogue("favela_gst_good2go");

  radio_dialogue("favela_cmt_rogerthat");

  flag_wait("van_in_position");
  thread autosave_now_silent();

  wait 0.5;

  radio_dialogue("favela_cmt_inposition");

  wait 2.5;

  radio_dialogue("favela_cmt_insight");

  wait 0.9;

  radio_dialogue("favela_cmt_needhimalive");

  wait 0.2;

  radio_dialogue("favela_cmt_getdown");
}

chase() {
  flag_wait("start_chase");
  flag_clear("runner_gets_away");

  setSavedDvar("compass", 1);
  setSavedDvar("hud_showStance", 1);
  setSavedDvar("ai_friendlyFireBlockDuration", 0);

  thread autosave_now();

  level.disable_destructible_bad_places = true;

  level.soap = spawn_targetname("soap_spawner", true);
  level.soap set_ignoreall(true);
  level.soap.usechokepoints = false;
  level.soap.fixednode = false;
  level.soap.disableBulletWhizbyReaction = true;
  level.soap.a.disablePain = true;
  level.soap.maxsightdistsqrd = 0;
  level.soap.ignoresuppression = true;
  level.soap.animname = "mactavish";
  level.soap.pathRandomPercent = 0;
  level.soap thread magic_bullet_shield();

  chase_objective_location = getent("chase_objective_location", "targetname");
  objective_add(1, "current", &"FAVELA_OBJ_CATCH_RUNNER", chase_objective_location.origin);

  waveNode = getnode("soap_start_node", "targetname");
  waveNode anim_teleport_solo(level.soap, "run_and_wave");
  flag_set("soap_exits_car");
  waveNode anim_single_solo(level.soap, "run_and_wave");

  thread chase_dialog();
  level.soap thread control_run_speed();

  makarov = spawn_targetname("makarov_street_spawner", true);
  makarov set_ignoreall(true);
  makarov set_ignoreme(true);
  makarov.disableBulletWhizbyReaction = true;
  makarov.a.disablePain = true;
  makarov.maxsightdistsqrd = 0;
  makarov.ignoresuppression = true;
  makarov.usechokepoints = false;
  makarov.skipBloodPool = true;
  makarov thread magic_bullet_shield();
  makarov thread faust_assistant_kill_player_monitor();
  makarov thread teleport_runner_for_takedown_1();
  makarov thread teleport_runner_for_takedown_2();
  makarov thread makarov_alley_fall();
  makarov thread makarov_gets_away();
  makarov thread player_doesnt_chase();
  makarov thread makarov_check_player_distance();

  objective_onentity(1, level.soap, (0, 0, 70));
}

makarov_check_player_distance() {
  level endon("take_the_shot");
  self endon("death");
  self endon("runner_shot");

  MIN_DIST = 500;
  MAX_DIST = 2500;

  SPEED_MIN = 1.0;
  SPEED_MAX = 1.6;

  for(;;) {
    d = distance(level.player.origin, self.origin);

    if(d > MAX_DIST) {
      setDvar("ui_deadquote", "@FAVELA_RUNNER_GOT_AWAY");
      maps\_utility::missionFailedWrapper();
      return;
    }

    runSpeed = self.moveplaybackrate;
    if(d < MIN_DIST) {
      runSpeed += 0.1;
    } else {
      runSpeed -= 0.1;
    }
    self.moveplaybackrate = cap_value(runSpeed, SPEED_MIN, SPEED_MAX);

    wait 0.1;
  }
}

chase_dialog() {
  level endon("runner_shot");

  level.soap dialogue_queue("favela_cmt_driversdead");

  radio_dialogue("favela_gst_onmyway");

  flag_wait("runner_in_alley");

  radio_dialogue("favela_gst_hesfast");

  level.soap dialogue_queue("favela_cmt_nonlethal");

  flag_wait("take_the_shot");

  thread legshot_pre_stinger();

  level.soap dialogue_queue("favela_cmt_takeshot");
}

legshot_pre_stinger() {
  level endon("runner_shot");

  wait 0.75;

  thread music_stop(0.25);
  level.player thread play_sound_on_entity("favela_legshot_pre_stinger");
}

teleport_runner_for_takedown_1() {
  self endon("death");

  trig = getent("teleport_runner_1", "targetname");
  teleportLoc = getent(trig.target, "targetname");

  trig waittill("trigger");

  if(!flag("runner_in_alley")) {
    return;
  }
  self forceTeleport(teleportLoc.origin, teleportLoc.angles);
}

teleport_runner_for_takedown_2() {
  self endon("death");

  trig = getent("teleport_runner_2", "targetname");
  teleportLoc = getent(trig.target, "targetname");

  trig waittill("trigger");

  if(!flag("runner_in_alley2")) {
    return;
  }
  self forceTeleport(teleportLoc.origin, teleportLoc.angles);
}

makarov_alley_fall() {
  level endon("stop_monitoring_makarov_damage");

  self set_generic_deathanim("alley_death_fall");

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, type);

    if(!isDefined(attacker))
      continue;
    if(attacker != level.player && attacker != level.soap) {
      continue;
    }

    if(damage <= 1) {
      continue;
    }

    if(!isDefined(type))
      continue;
    if(issubstr(type, "GRENADE")) {
      self thread makarov_alley_killed(point);
      return;
    }

    if(self was_shot_in_lethal_area()) {
      self thread makarov_alley_killed(point);
      return;
    }

    self thread makarov_alley_wounded();
  }
}

was_shot_in_lethal_area() {
  assert(isDefined(self));

  if(isDefined(self.disableLethalCheck))
    return false;

  if(!isDefined(self.damagelocation))
    return true;

  switch (self.damagelocation) {
    case "none":
      if(flag("makarov_alley_wounded"))
        return false;
      return true;
    case "helmet":
    case "head":
    case "neck":
    case "torso_upper":
    case "torso_lower":
      return true;
    default:
      return false;
  }
}

makarov_alley_wounded() {
  level notify("runner_shot");

  if(flag("makarov_alley_wounded"))
    return;
  flag_set("makarov_alley_wounded");

  self thread makarov_alley_wounded_and_crawl();

  wait 1.0;

  level.soap thread anim_single_solo(level.soap, "favela_cmt_hesdown");
  wait 1.0;

  level notify("makarov_wounded_successfully");
  objective_State(1, "done");
  thread startFavela();
}

makarov_alley_wounded_and_crawl() {
  self endon("deleted");
  self endon("death");

  if(flag("runner_disable_crawl"))
    self clear_deathanim();

  self stop_magic_bullet_shield();
  level.runner = self;
  level.runner thread play_sound_in_space("scn_favela_death_crawl", level.runner.origin);
  self.noDrop = true;
  self kill();
}

makarov_alley_killed(point) {
  level notify("runner_shot");

  if(!flag("makarov_alley_wounded")) {
    self clear_deathanim();
    self stop_magic_bullet_shield();
    self kill(point, level.player);
  }

  setDvar("ui_deadquote", "@FAVELA_KILLED_RUNNER");
  maps\_utility::missionFailedWrapper();
}

makarov_gets_away() {
  self endon("runner_shot");

  self waittill("reached_path_end");

  setDvar("ui_deadquote", "@FAVELA_RUNNER_GOT_AWAY");
  maps\_utility::missionFailedWrapper();
}

player_doesnt_chase() {
  self endon("runner_shot");

  flag_wait("runner_gets_away");

  setDvar("ui_deadquote", "@FAVELA_RUNNER_GOT_AWAY");
  maps\_utility::missionFailedWrapper();
}

stop_sounds_during_black() {
  X_LINE = -50;
  ents = getEntArray();
  foreach(ent in ents) {
    if(ent.origin[0] < X_LINE) {
      continue;
    }
    if(!isDefined(ent.code_classname))
      continue;
    switch (ent.classname) {
      case "script_vehicle":
      case "script_origin":
      case "script_model":
      case "script_struct":
        ent notify("stop_car_alarm");
        ent stopSounds();
        break;
      default:
        break;
    }
  }
}

fade_to_black_alley(fadeInTime, fadeOutTime, duration) {
  setSavedDvar("compass", 0);
  setSavedDvar("hud_showStance", 0);

  stop_sounds_during_black();
  level.player playLocalSound("scn_favela_legshot_stinger");

  overlay = newHudElem();
  overlay.x = 0;
  overlay.y = 0;
  overlay setshader("black", 640, 480);
  overlay.alignX = "left";
  overlay.alignY = "top";
  overlay.horzAlign = "fullscreen";
  overlay.vertAlign = "fullscreen";

  overlay.alpha = 0;
  if(fadeInTime > 0)
    overlay fadeOverTime(fadeInTime);
  overlay.alpha = 1;

  wait fadeInTime;
  wait 0.05;

  level.player freezeControls(true);
  level notify("black_screen_start");

  wait duration;

  level.player freezeControls(false);
  level notify("black_screen_finish");

  if(fadeOutTime > 0)
    overlay fadeOverTime(fadeOutTime);
  overlay.alpha = 0;

  wait fadeOutTime;

  setSavedDvar("compass", 1);
  setSavedDvar("hud_showStance", 1);

  overlay destroy();
}

hotel_doors() {
  rotationAmount = 110;
  left = getent("hotel_door_left", "targetname");
  right = getent("hotel_door_right", "targetname");
  knobs = getEntArray("hotel_knob", "targetname");

  left rotateYaw(rotationAmount * -1, 0.05);
  right rotateYaw(rotationAmount, 0.05);
  array_call(knobs, ::hide);

  flag_wait("car_getting_shot");
  flag_wait("player_is_ducking");

  left rotateYaw(rotationAmount, 0.05);
  right rotateYaw(rotationAmount * -1, 0.05);
  array_call(knobs, ::show);
}

break_windshield(vehicle) {
  flag_wait("driver_dead");

  vehicle thread play_sound_on_tag("scn_favela_car_glass_shatter", "TAG_GLASS_FRONT_D");
  playFXOnTag(getfx("car_glass_interior"), vehicle, "TAG_GLASS_FRONT_FX");
  vehicle showpart("TAG_GLASS_FRONT_D");
  vehicle showpart("TAG_BLOOD");
  vehicle hidepart("TAG_GLASS_FRONT");

  if(!isDefined(level.hula_girl)) {
    return;
  }
  level.hula_girl unlink();
  force = 150;
  level.hula_girl physicsLaunchClient(level.hula_girl.origin + (0, 0, 5), (0, force, 0));
}

driver_shot_in_head(driver) {
  playFXOnTag(getfx("blood"), driver, "J_Head");
  playFXOnTag(getfx("blood_dashboard_splatter"), driver, "J_Head");

  wait 0.1;

  flag_set("driver_dead");
}

driver_falls_on_horn(driver) {
  alias = "scn_favela_merc_horn_loop";
  driver thread play_loop_sound_on_entity(alias, (0, 0, 20));
  wait 60;
  driver notify("stop sound" + alias);
}

blood_gunner1() {
  wait 6.6;
  playFXOnTag(getfx("blood"), self, "J_Hip_RI");
  wait 0.1;
  playFXOnTag(getfx("blood"), self, "J_SpineLower");
}

blood_gunner2() {
  wait 7.1;
  playFXOnTag(getfx("blood"), self, "J_Hip_RI");
  wait 0.2;
  playFXOnTag(getfx("blood"), self, "J_SpineLower");
  wait 1.2;
  playFXOnTag(getfx("blood"), self, "J_Head");
}

blood_driver() {
  wait 9.5;
  playFXOnTag(getfx("blood"), self, "J_Shoulder_RI");
}

makarov_shoot_player(vehicle) {
  self endon("death");

  shots = 15;
  shot_kill_start = 10;
  shot_kill_stop = 15;

  width = 29;
  height = 8;
  interval_min = 0.1;
  interval_max = 0.3;
  fireAnim = level.scr_anim[self.animname]["stand_fire"];

  center = vehicle getTagOrigin("tag_glass_front_fx");
  windowAng = vehicle getTagAngles("tag_glass_front_fx");
  right = anglesToRight(windowAng);
  up = anglesToUp(windowAng);

  farLeft = center - (right * width);
  farRight = center + (right * width);
  top = center + (up * height);
  bottom = center - (up * height);

  flag_set("car_getting_shot");

  shootPoints = [];
  for(i = 0; i < shots; i++) {
    rand_horizontal_offset = randomfloatrange(width * -1, width);
    rand_vertical_offset = randomfloatrange(height * -1, height);
    point = center;
    point += right * rand_horizontal_offset;
    point += up * rand_vertical_offset;

    shootPoints[shootPoints.size] = point;
  }

  for(i = 0; i < shots; i++) {
    self shoot(100.0, shootPoints[i]);

    fxOrigin = shootPoints[i];
    forward = vectorNormalize(fxOrigin - self getTagOrigin("tag_flash"));
    playFX(getfx("glass_exit"), fxOrigin, forward);

    if(i >= shot_kill_start && i <= shot_kill_stop) {
      if(!flag("player_is_ducking"))
        self thread kill_player();
    }

    self setAnimKnobRestart(fireAnim, 1, .2, 1.0);
    wait randomfloatrange(interval_min, interval_max);
  }

  self clearAnim(fireAnim, 0);
}

kill_player() {
  level.player notify("shot_next_frame");
  wait 0.05;
  level.player enableDeathShield(false);
  level.player enableHealthShield(false);
  level.player disableInvulnerability();
  level.player doDamage(level.player.health + 50000, level.player getEye(), self);
  wait 0.05;
  if(isalive(level.player))
    level.player kill();
  assert(!isAlive(level.player));
}

opening_death() {
  level waittill("end_scene");

  self.allowdeath = true;
  self.a.nodeath = true;
  self.noragdoll = true;
  self setContents(0);
  self kill();
}

add_top_of_hill_objective() {
  originEnt = getent("mission_objective_location", "targetname");
  objective_add(2, "current", &"FAVELA_OBJ_REACH_TOP", originEnt.origin);
}

favela_friendlies() {
  level.meat = spawn_targetname("meat_spawner", true);
  level.meat thread magic_bullet_shield();
  level.meat.animname = "meat";

  level.royce = spawn_targetname("royce_spawner", true);
  level.royce thread magic_bullet_shield();
  level.royce.animname = "royce";
}

favela_opening_civilians() {
  trigger_wait("favela_opening_civilians_spawn", "targetname");
  spawners = getEntArray("favela_opening_civilian_spawner", "targetname");

  array_thread(spawners, ::favela_opening_civilians_think);
  thread favela_civilians_scream();

  flag_set("favela_civilians_spawned");
}

favela_opening_civilians_think() {
  civilian = self spawn_ai(true);
  civilian endon("death");

  if(!isDefined(level.favelaCivilians))
    level.favelaCivilians = [];
  level.favelaCivilians[level.favelaCivilians.size] = civilian;

  wait 0.05;
  civilian.alertlevel = "noncombat";

  if(!isDefined(self.animation)) {
    civilian thread delete_ai_at_path_end();
    civilian.useChokePoints = false;
    return;
  }

  eNode = undefined;
  if(isDefined(self.script_linkto)) {
    eNode = get_linked_ent();
  } else {
    eNode = spawn("script_origin", self.origin);
    eNode.angles = self.angles;
  }
  assert(isDefined(eNode));

  animScene = self.animation;
  eNode thread anim_generic_loop(civilian, animScene, "stop_idle_anim");

  civilian waittill("combat");

  flag_set("favela_civilians_fleeing");

  wait randomfloat(1.5);

  eNode notify("stop_idle_anim");
  civilian notify("stop_idle_anim");
  civilian stopAnimScripted();

  civilian.useChokePoints = true;

  node = getnode("favela_civ_flee_node_opening", "targetname");
  civilian thread follow_path(node);
  civilian thread delete_ai_at_path_end();
}

favela_civilians_scream() {
  soundEnt = getent("favela_civilians_scream_ent", "targetname");
  soundEntEndPos = getent(soundEnt.target, "targetname");

  flag_wait("favela_civilians_fleeing");

  soundEnt playSound("scn_favela_civ_outofhere_screams");
  soundEnt moveTo(soundEntEndPos.origin, 6.0, 4.0, 2.0);
}

favela_music() {
  flag_wait("favela_music");
  level endon("favela_music");

  thread favela_music_stop();
  alias = "favela_tension";
  time = musicLength(alias);

  while(flag("favela_music")) {
    thread music_play(alias);
    wait time;
  }
}

favela_music_stop() {
  flag_waitopen("favela_music");
  music_stop(3);
}

upper_village_music() {
  flag_wait("upper_village_music");
  level endon("faust_appearance_1");

  radio_dialogue("favela_cmt_theirterritory");

  alias = "favela_uppervillage_start";
  time = musicLength(alias);

  while(!flag("faust_appearance_1")) {
    thread music_play(alias, 2.0);
    wait time;
  }
}

faust_music() {
  level endon("faust_music");

  thread faust_music_stop();

  alias = "favela_moneyrun";
  time = musicLength(alias);

  while(flag("faust_music")) {
    thread music_play(alias);
    wait time;
  }
}

faust_music_stop() {
  flag_waitopen("faust_music");
  music_stop(3);
}

random_favela_background_runners() {
  level endon("cleared_favela");
  spawners = getEntArray("random_favela_background_runner", "targetname");

  flag_wait("favela_enemies_spawned");

  for(;;) {
    spawners = array_randomize(spawners);
    foreach(spawner in spawners) {
      if(flag("cleared_favela")) {
        return;
      }
      spawner.count = 1;
      spawner thread spawn_ai(true);

      wait randomintrange(4, 8);
    }
  }
}

faust_appearance_1() {
  flag_wait("faust_appearance_1");

  thread autosave_by_name("faust_appearance_1");

  thread faust_appearance_1_dialog();

  faust = spawn_targetname("faust_spawner_1", true);
  faust thread objective_on_faust();

  thread music_stop(3.0);
  wait 3.2;
  flag_set("faust_music");
  thread faust_music();
}

objective_on_faust() {
  assert(isalive(self));

  level notify("objective_on_faust");
  level endon("objective_on_faust");

  objective_onentity(2, self, (0, 0, 70));
  objective_setpointertextoverride(2, &"FAVELA_OBJ_CAPTURE");
  setsaveddvar("objectiveFadeTooFar", 0.1);

  self waittill("death");

  originEnt = getent("mission_objective_location", "targetname");
  objective_position(2, originEnt.origin);
  setsaveddvar("objectiveFadeTooFar", 25);
}

faust_appearance_1_dialog() {
  radio_dialogue("favela_cmt_spottedfaust");

  radio_dialogue("favela_cmt_unharmed");

  wait 5.0;

  radio_dialogue("favela_cmt_cutoff");
}

faust_appearance_2() {
  flag_wait("faust_appearance_2");

  faust = spawn_targetname("faust_spawner_2", true);
  faust thread objective_on_faust();
}

faust_appearance_3() {
  flag_wait("faust_appearance_3");

  faust = spawn_targetname("faust_spawner_3", true);
  faust thread objective_on_faust();

  thread faust_appearance_3_dialog();
}

faust_appearance_3_dialog() {
  level endon("ending_sequence_dialog");

  radio_dialogue("favela_cmt_backtowards");

  if(flag("ending_sequence_dialog")) {
    return;
  }

  radio_dialogue("favela_cmt_doubleback");
}

faust_appearance_4() {
  flag_wait("faust_appearance_4");

  faust = spawn_targetname("faust_spawner_4", true);
  faust thread objective_on_faust();
}

street_scenes() {
  flag_wait("start_street_sequences_1");

  thread street_scene_civilian_180_runaway();
  thread street_scene_civilian_wounded_1();

  thread street_scene_destruction();
}

street_scene_civilian_180_runaway() {
  spawner = getent("civilian_180_runaway", "targetname");
  animNode = spawn("script_origin", spawner.origin);
  animNode.angles = spawner.angles;
  animScene = spawner.animation;
  runtoNode = getnode(spawner.target, "targetname");

  guy = spawner spawn_ai(true);
  guy endon("death");
  guy.allowdeath = true;
  animNode anim_generic(guy, animScene);

  guy.goalradius = 32;
  guy thread delete_ai_at_goal();
  guy setGoalNode(runtoNode);
}

street_scene_civilian_wounded_1() {
  wounded_spawner = getent("wounded_guy_1", "targetname");
  helper_spawner = getent("wounded_guy_helper_1", "targetname");
  woundedAnimScene = wounded_spawner.animation;
  helperAnimScene = helper_spawner.animation;
  animNode = wounded_spawner get_linked_ent();
  runtoNode = getnode(helper_spawner.target, "targetname");

  wounded = wounded_spawner spawn_ai(true);
  helper = helper_spawner spawn_ai(true);

  wounded.a.nodeath = true;

  animNode thread anim_generic_first_frame(wounded, woundedAnimScene);
  animNode thread anim_generic_first_frame(helper, helperAnimScene);

  helper endon("death");

  trigger_wait("wounded_guy_1_proximity", "targetname");

  animNode thread anim_generic(wounded, woundedAnimScene);
  animNode anim_generic(helper, helperAnimScene);

  animNode thread anim_generic_first_frame(wounded, woundedAnimScene);

  helper.goalradius = 32;
  helper thread delete_ai_at_goal();
  helper setGoalNode(runtoNode);
}

street_scene_destruction() {
  car1 = getent("force_explosion_car_1", "script_noteworthy");
  car2 = getent("force_explosion_car_2", "script_noteworthy");
  car3 = getent("force_explosion_car_3", "script_noteworthy");

  thread delayThread(0.0, ::street_scene_gunshots, car1.origin);
  car1 thread delayThread(1.8, ::destructible_force_explosion);

  thread delayThread(2.5, ::street_scene_gunshots, car2.origin);
  car2 thread delayThread(3.2, ::destructible_force_explosion);

  thread delayThread(4.0, ::street_scene_gunshots, car3.origin);
  thread delayThread(5.0, ::street_scene_gunshots, car3.origin);
  car3 thread delayThread(6.2, ::destructible_force_explosion);
}

street_scene_gunshots(org) {
  shots = randomintrange(5, 10);
  for(i = 0; i < shots; i++) {
    thread play_sound_in_space("weap_deserteagle_fire_npc", org);
    wait randomfloatrange(0.1, 0.3);
  }
}

favela_warning() {
  level.meat.goalradius = 32;
  level.royce.goalradius = 32;
  level.meat set_goal_node_targetname("meat_first_node");
  level.royce set_goal_node_targetname("royce_first_node");

  thread player_gives_favela_warning();

  flag_wait("favela_gate_dialog_done");

  flag_wait("give_favela_warning");

  animNode = getnode("favela_warning_node", "targetname");
  if(!flag("favela_civilians_alerted")) {
    level.royce anim_single_solo(level.royce, "favela_ryc_warning");
    level.meat thread anim_single_solo(level.meat, "favela_met_rogerthat");

    animNode anim_reach_solo(level.meat, "favela_warning_jump");
  }

  level.meat thread set_goal_node_targetname("favela_warning_guy_first_node");
  level.royce thread set_goal_node_targetname("favela_other_guy_first_node");

  level.meat enable_ai_color();
  level.royce enable_ai_color();

  if(!flag("favela_civilians_alerted")) {
    animNode anim_single_solo(level.meat, "favela_warning_jump");
    animNode anim_single_solo(level.meat, "favela_warning_landing");
  }

  flag_set("favela_enemies_spawned");
  thread activate_trigger("favela_spawn_trigger", "script_noteworthy", level.player);

  thread battlechatter_on("allies");
  thread battlechatter_on("axis");
}

player_gives_favela_warning() {
  flag_wait("favela_civilians_spawned");

  thread player_gives_favela_warning_weapons();
  thread player_gives_favela_warning_trigger();
}

player_gives_favela_warning_weapons() {
  level endon("favela_civilians_alerted");

  level.player waittill_any("grenade_fire", "weapon_fired");

  thread alert_favela_civilians();
}
player_gives_favela_warning_trigger() {
  level endon("favela_civilians_alerted");

  flag_wait("player_entered_favela");

  thread alert_favela_civilians();
}

alert_favela_civilians() {
  flag_set("favela_civilians_alerted");

  wait 1.5;

  foreach(civilian in level.favelaCivilians) {
    if(isDefined(civilian))
      civilian.alertlevel = "alert";
  }
}

favela_dialog() {
  flag_wait("favela_enemies_spawned");

  wait 7.0;

  radio_dialogue("favela_cmt_fullbattalion");
  radio_dialogue("favela_ryc_withyou");

  flag_wait("player_in_lower_favela_shanty");

  radio_dialogue("favela_cmt_doingok");
  radio_dialogue("favela_ryc_nosign");
  radio_dialogue("favela_cmt_keepsearching");

  wait 2.5;

  radio_dialogue("favela_ryc_moveup");

  flag_set("allow_meat_death");
}

soccer_dialog() {
  flag_wait("cleared_favela");

  radio_dialogue("favela_cmt_cuthimoff");
  radio_dialogue("favela_cmt_keepgoing");
  wait 1.0;
  radio_dialogue("favela_cmt_notime");
}

meat_dies() {
  flag_wait("allow_meat_death");
  flag_wait("player_midway_through_lower_favela");

  level.meat thread meat_dies_dialog();
  level.meat stop_magic_bullet_shield();
  wait 0.05;
  level.meat.health = 1;
  level.meat thread meat_force_death();
}

meat_force_death() {
  self endon("death");

  flag_wait("force_meat_death");

  magicBullet("dragunov", (-5427, -77, 1790), self getEye());
  wait 0.1;
  self kill();
}

meat_dies_dialog() {
  self waittill("death");

  radio_dialogue("favela_ryc_meatisdown");

  flag_set("allow_royce_death");
}

royce_dies() {
  flag_wait("force_meat_death");
  flag_wait("allow_royce_death");

  level.royce thread royce_dies_dialog();
  level.royce stop_magic_bullet_shield();
  wait 0.05;
  level.royce.health = 1;
  level.royce thread royce_force_death();
}

royce_force_death() {
  self endon("death");

  flag_wait("force_kill_royce");

  magicBullet("dragunov", (-5427, -77, 1790), self getEye());
  wait 0.1;
  self kill();
}

royce_dies_dialog() {
  self waittill("death");

  withinView = false;
  if(isDefined(self) && isDefined(self.origin))
    withinView = level.player player_looking_at(self.origin, cos(45));

  if(!withinView)
    radio_dialogue("favela_ryc_imhit");
}

upper_village_triggered_dialog() {
  level endon("faust_appearance_1");

  flag_wait("dialog_watch_rooftops");

  radio_dialogue("favela_cmt_watchrooftops");

  wait 4.0;

  radio_dialogue("favela_cmt_stilltracking");
  radio_dialogue("favela_gst_duffelbag");
  radio_dialogue("favela_cmt_intercept");

  wait 12;

  radio_dialogue("favela_cmt_yourside");
  radio_dialogue("favela_gst_pinyoudown");
  radio_dialogue("favela_cmt_lostsightagain");
  radio_dialogue("favela_gst_alleysbelow");
  radio_dialogue("favela_cmt_stayonhim");

  wait 6;

  flag_wait("dialog_faust_through_market");

  radio_dialogue("favela_gst_cuttingthru");
  radio_dialogue("favela_cmt_headforrooftops");
  wait 3.0;
  radio_dialogue("favela_gst_wayaround");

  wait 6;

  flag_wait("dialog_faust_in_sights");

  radio_dialogue("favela_gst_halfklick");
  radio_dialogue("favela_cmt_eyeopen");

  wait 8;

  radio_dialogue("favela_gst_legshot");
  radio_dialogue("favela_cmt_donotengage");
  radio_dialogue("favela_gst_rogerthat2");

  wait 12;

  radio_dialogue("favela_cmt_nowheretogo");
  radio_dialogue("favela_cmt_traphimuphere");

  wait 12;

  radio_dialogue("favela_gst_jumpedfence");
  radio_dialogue("favela_cmt_goingleft");

  wait 12;

  radio_dialogue("favela_cmt_closertoyourpart");
}

final_bend_dialog() {
  level endon("ending_sequence_dialog");
  level endon("player_approaching_final_stairs");
  level endon("stop_all_misc_dialog");

  flag_wait("player_at_final_bend");

  radio_dialogue("favela_cmt_motorcycle");

  soundEnt = getent("nohesnot_location", "targetname");
  soundEnt play_sound_in_space("favela_gst_nohesnot");

  radio_dialogue("favela_cmt_dontshoothim");

  wait 0.3;

  radio_dialogue("favela_cmt_onthemove");

  wait 4.0;

  radio_dialogue("favela_cmt_anotherfence");

  wait 4.0;

  radio_dialogue("favela_cmt_corraling");

  wait 10;

  radio_dialogue("favela_gst_whereishe");
  wait 0.2;
  radio_dialogue("favela_cmt_slidingrooftops");
  wait 0.2;
  radio_dialogue("favela_gst_anotherlegshot");
  wait 0.2;
  radio_dialogue("favela_cmt_carryhimback");
}

final_staircase_dialog() {
  flag_wait("player_approaching_final_stairs");

  if(flag("ending_sequence_dialog"))
    return;
  level endon("ending_sequence_dialog");

  radio_dialogue("favela_cmt_farright");

  radio_dialogue("favela_gst_rogerthat");
}

ending_sequence() {
  trigger_wait("ending_sequence", "targetname");

  thread ending_sequence_dialog();

  thread battlechatter_off("allies");
  thread battlechatter_off("axis");

  node = getent("ending_node", "targetname");

  soap = spawn_targetname("ending_soap_spawner", true);
  soap.animname = "mactavish";
  soap set_ignoreme(true);
  soap set_ignoreall(true);
  soap thread magic_bullet_shield();

  faust = spawn_targetname("ending_faust_spawner", true);
  faust.animname = "faust";
  faust set_ignoreme(true);
  faust set_ignoreall(true);
  faust thread magic_bullet_shield();
  faust thread faust_mission_fail();
  faust thread objective_on_faust();

  car = getent("ending_car", "targetname");
  car useanimtree(level.scr_animtree["car"]);
  car.animname = "car";

  guys[0] = soap;
  guys[1] = faust;
  guys[2] = car;
  node anim_first_frame(guys, "ending_takedown");

  flag_wait("player_in_ending_area");
  faust waittill_player_lookat(0.8, undefined, undefined, 7.0);

  SoundSetTimeScaleFactor("Music", 0);
  SoundSetTimeScaleFactor("Menu", 0);
  SoundSetTimeScaleFactor("Bulletimpact", 0);
  SoundSetTimeScaleFactor("Voice", 0);
  SoundSetTimeScaleFactor("effects2", 0);
  SoundSetTimeScaleFactor("Mission", 0);
  SoundSetTimeScaleFactor("Announcer", 0);
  SoundSetTimeScaleFactor("local", 0);
  SoundSetTimeScaleFactor("physics", 0);
  SoundSetTimeScaleFactor("ambient", 0);
  SoundSetTimeScaleFactor("auto", 0);
  SoundSetTimeScaleFactor("Shellshock", 0);

  flag_set("ending_sequence_started");

  thread ending_sequence_ghost();

  flag_clear("faust_music");
  flag_clear("favela_music");
  thread music_stop(1.0);
  level.player thread play_sound_on_entity("favela_moneyrun_endfall");

  node thread anim_single(guys, "ending_takedown");
  delayThread(13.0, ::fade_out_level);

  wait 5.2;

  assert(isDefined(level.ghost));
  level.ghost anim_single_solo(level.ghost, "favela_gst_sendchopper");
  wait 0.8;
  level.ghost anim_single_solo(level.ghost, "favela_gst_skiesareclear");
  wait 1.0;
  level.ghost thread anim_single_solo(level.ghost, "favela_gst_onourown");
  wait 4;
  nextmission();
}

fade_out_level() {
  fadeInTime = 1.0;

  setSavedDvar("compass", 0);
  setSavedDvar("hud_showStance", 0);

  overlay = newHudElem();
  overlay.x = 0;
  overlay.y = 0;
  overlay setshader("black", 640, 480);
  overlay.alignX = "left";
  overlay.alignY = "top";
  overlay.horzAlign = "fullscreen";
  overlay.vertAlign = "fullscreen";

  overlay.alpha = 0;
  overlay fadeOverTime(fadeInTime);
  overlay.alpha = 1;

  wait fadeInTime;

  level.player freezeControls(true);
  enablePlayerWeapons(false);
}

ending_sequence_ghost() {
  level.ghost = spawn_targetname("ending_ghost_spawner", true);
  level.ghost.animname = "ghost";
  level.ghost set_ignoreme(true);
  level.ghost set_ignoreall(true);
  level.ghost thread magic_bullet_shield();
}

ending_sequence_dialog() {
  flag_set("ending_sequence_dialog");

  if(!flag("ending_sequence_started")) {
    radio_dialogue("favela_gst_getaway");
  }

  flag_wait("ending_sequence_started");

  radio_dialogue("favela_cmt_nohesnot");

  flag_set("start_final_dialog");
}

ending_sequence_slowmo() {
  wait 0.15;

  if(!player_looking_at(self.origin, undefined, true)) {
    return;
  }
  slomoLerpTime_in = 0.5;
  slomoLerpTime_out = 0.65;
  slomobreachplayerspeed = 0.1;
  slomoSpeed = 0.2;
  slomoDuration = 2.0;

  level.player thread play_sound_on_entity("slomo_whoosh");

  slowmo_start();
  slowmo_setspeed_slow(slomoSpeed);
  slowmo_setlerptime_in(slomoLerpTime_in);
  slowmo_lerp_in();
  level.player SetMoveSpeedScale(slomobreachplayerspeed);

  wait slomoDuration * slomoSpeed;

  level.player thread play_sound_on_entity("slomo_whoosh");

  slowmo_setlerptime_out(slomoLerpTime_out);
  slowmo_lerp_out();
  slowmo_end();
  level.player SetMoveSpeedScale(1.0);

  wait 1;

  objective_State(2, "done");
}