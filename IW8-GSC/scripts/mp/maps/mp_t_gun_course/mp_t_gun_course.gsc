/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_t_gun_course\mp_t_gun_course.gsc
***************************************************************/

function main() {
  _start_rooftop_raid_exfil::keypad_check_levelinput();
  level.ref_13d50 = 1;
  level.music_style = "middle_east";
  var_0 = getentarrayinradius("trial_weapon", "targetname", (-610.39, 705.465, 45.9237), 1)[0];
  var_0.origin += (0, 0, 1);
  var_1 = getdvarint("bg_trial_mission_id", 0);

  if(var_1 == 104) {
    level.set_spotlight_target_loc = 0;
    var_2 = "forward";
    var_3 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (-700, 400, 24), (0, 50, 0));
  } else {
    level.set_spotlight_target_loc = 1;
    var_2 = "backward";
    var_3 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (-709, 472, 24), (0, 150, 0));
  }

  var_4 = getEntArray();

  foreach(var_6 in var_4) {
    if(isDefined(var_6.script_wtf) && var_6.script_wtf == var_2) {
      var_6 delete();
    }
  }

  scripts\mp\spawnlogic::bdiedonce([var_3]);
  scripts\mp\maps\mp_t_gun_course\mp_t_gun_course_precache::main();
  scripts\mp\maps\mp_t_gun_course\gen\mp_t_gun_course_art::main();
  scripts\mp\maps\mp_t_gun_course\mp_t_gun_course_fx::main();
  scripts\mp\maps\mp_t_gun_course\mp_t_gun_course_lighting::main();
  scripts\mp\load::main();
  level.ttlos_suppressasserts = 1;
  level.trial_infinite_reserve_ammo = 1;
  scripts\mp\compass::setupminimap("compass_map_mp_t_gun_course");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread ref_12c55();
  thread door_surprise_breach();
  thread progression_gates();
  thread target_random_models();
  var_8 = spawn("script_model", (-20, 1648, 68));
  var_8.angles = (0, 180, 0);
  var_8 setModel("building_wall_broken_corner_48x48_01_tan2");
  var_9 = spawn("script_model", (-1352, 1780.5, 160));
  var_9.angles = (0, 270, 0);
  var_9 setModel("cinderblock_wall_topper_02_128");
  var_10 = spawn("script_model", (-256, 536, 244));
  var_10.angles = (0, 270, 0);
  var_10 setModel("hardware_plywood_bare_01");
  var_11 = spawn("script_model", (-998.672, 1585, 25.4966));
  var_11.angles = (0, 184.399, -180);
  var_11 setModel("barrier_traffic_concrete_block_01_chip_away_dead");
  var_12 = spawn("script_model", (-1128, 672, 120));
  var_12.angles = (360, 345, -90);
  var_12 setModel("player128x128x8");

  if(!level.set_spotlight_target_loc) {
    var_13 = getEnt("end", "script_noteworthy");
    var_13.origin += (0, 48, 0);
    var_14 = spawn("script_model", (-499.179, 667.972, -15.5977));
    var_14.angles = (0, 303.999, -90.0001);
    var_14 setModel("player128x128x8");
    return;
  }
}

function door_surprise_breach() {
  var_0 = getEnt("door", "script_noteworthy");
  var_1 = getEnt("door_l", "script_noteworthy");
  var_2 = getEnt("door_r", "script_noteworthy");

  for(;;) {
    level waittill("course_started");

    while(!var_0.activated) {
      waitframe();
    }

    playsoundatpos(var_1.origin + (0, 0, 42), "scrpt_door_heavy_metal_single_bash");
    playsoundatpos(var_2.origin + (0, 0, 42), "scrpt_door_heavy_metal_single_bash");
    var_1 rotateYaw(-135, 0.3, 0, 0.1);
    var_2 rotateYaw(135, 0.3, 0, 0.1);
    level waittill("course_ended");
    var_1 rotateYaw(135, 1);
    var_2 rotateYaw(-135, 1);
  }
}

function progression_gates() {
  var_0 = getEnt("start_fence", "targetname");
  var_1 = getEnt("start_fence_collision", "targetname");
  var_2 = getEnt("start_fence_collision_opening", "targetname");
  var_3 = getEnt("end_fence", "targetname");
  var_4 = getEnt("end_fence_collision", "targetname");
  var_5 = getEnt("backtrack_fence", "targetname");
  var_6 = getEnt("backtrack_fence_collision_closed", "targetname");
  var_2 linkTo(var_0);

  if(level.set_spotlight_target_loc) {
    var_7 = (0, 90, 0);
    var_8 = (0, 0, 0);
    var_9 = (0, 290, 0);
    var_10 = (0, 0, 0);
    var_11 = (0, 4, 0);
    var_12 = (0, 270, 0);
    var_13 = (-1030, 484, 82);
  } else {
    var_7 = (0, 290, 0);
    var_8 = (0, 0, 0);
    var_9 = (0, 90, 0);
    var_10 = (0, 0, 0);
    var_11 = (0, 0, 0);
    var_12 = (0, 90, 0);
    var_13 = (-448, 530, 82);
  }

  level waittill("player_spawned");

  while(level.player getvelocity() == 0) {
    waitframe();
  }

  for(;;) {
    var_7 rotateTo(var_7, 2);
    scripts\engine\utility::play_sound_in_space("trial_sfx_door_chainlink_slow", var_13);
    wait 1.5;
    var_8 notsolid();
    level waittill("course_started");
    var_8 solid();
    var_9 notsolid();
    var_13 notsolid();
    var_11 notsolid();
    var_7 rotateTo(var_8, 2);
    var_10 rotateTo(var_9, 3);
    var_12 rotateTo(var_11, 1);
    level waittill("course_ended");
    var_9 solid();
    var_13 solid();
    var_12 rotateTo(var_12, 3);
    _tablethide::trial_ui_waittill_retry();
  }
}

function ref_12c55() {
  for(;;) {
    level waittill("course_ended");
    var_0 = getentitylessscriptablearrayinradius("scriptable_scriptable_door_industrial_metal_mp_01", "classname");

    foreach(var_2 in var_0) {
      var_2 vehicle_getinputvalue();
    }
  }
}

function target_random_models() {
  while(!isDefined(level.targets_thinking) || istrue(level.targets_thinking)) {
    waitframe();
  }

  var_0 = ["ee_military_shooting_range_plate_enemy_01", "ee_military_shooting_range_plate_enemy_02", "ee_military_shooting_range_plate_enemy_03", "ee_military_shooting_range_plate_enemy_04", "ee_military_shooting_range_plate_enemy_05", "ee_military_shooting_range_plate_enemy_06"];
  var_1 = ["ee_military_shooting_range_plate_civilian_01", "ee_military_shooting_range_plate_civilian_02", "ee_military_shooting_range_plate_civilian_03"];
  var_2 = ["ee_military_shooting_range_plate_bullet", "ee_military_shooting_range_plate_bullet_01", "ee_military_shooting_range_plate_bullet_02", "ee_military_shooting_range_plate_bullet_03"];
  var_3 = scripts\engine\utility::array_randomize(level.enemy_targets);
  var_4 = scripts\engine\utility::array_randomize(level.civilian_targets);

  foreach(var_6 in var_3) {
    var_6.bullet_decal = spawn("script_model", var_6.plate.origin);
    var_6.bullet_decal.angles = var_6.plate.angles;
    var_6.bullet_decal linkTo(var_6.plate);

    if(isDefined(var_6.script_parameters)) {
      var_6.plate setModel(var_6.script_parameters);
    }
  }

  foreach(var_6 in var_3) {
    var_9 = scripts\engine\utility::getclosest(var_6.origin, scripts\engine\utility::array_remove(var_3, var_6));
    var_10 = scripts\engine\utility::getclosest(var_6.origin, scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var_3, var_6), var_9));
    var_11 = scripts\engine\utility::getclosest(var_6.origin, scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var_3, var_6), var_9), var_10));
    var_12 = scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var_2, var_9.bullet_decal.model), var_10.bullet_decal.model), var_11.bullet_decal.model);

    if(!isDefined(var_6.script_parameters)) {
      var_13 = scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var_0, var_9.plate.model), var_10.plate.model), var_11.plate.model);
      var_6.plate setModel(scripts\engine\utility::random(var_13));
    }

    var_6.bullet_decal setModel(scripts\engine\utility::random(var_12));
  }

  foreach(var_16 in var_4) {
    var_9 = scripts\engine\utility::getclosest(var_16.origin, scripts\engine\utility::array_remove(var_4, var_16));
    var_10 = scripts\engine\utility::getclosest(var_16.origin, scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var_4, var_16), var_9));

    if(isDefined(var_16.script_parameters)) {
      var_16.plate setModel(var_16.script_parameters);
      continue;
    }

    var_13 = scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var_1, var_9.plate.model), var_10.plate.model);
    var_16.plate setModel(scripts\engine\utility::random(var_13));
  }
}