/***************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_t_gun_course\mp_t_gun_course.gsc
***************************************************************/

function main() {
  _start_rooftop_raid_exfil::keypad_check_levelinput();
  level.ref_13d50 = 1;
  level.music_style = "middle_east";
  var0 = getentarrayinradius("trial_weapon", "targetname", (-610.39, 705.465, 45.9237), 1)[0];
  var0.origin += (0, 0, 1);
  var1 = getdvarint("LTTRKNNKTQ", 0);

  if(var1 == 104) {
    level.set_spotlight_target_loc = 0;
    var2 = "forward";
    var3 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (-700, 400, 24), (0, 50, 0));
  } else {
    level.set_spotlight_target_loc = 1;
    var2 = "backward";
    var3 = scripts\mp\spawnlogic::init_trap_room_doors("mp_trial_spawn", (-709, 472, 24), (0, 150, 0));
  }

  var4 = getEntArray();

  foreach(var6 in var4) {
    if(isDefined(var6.script_wtf) && var6.script_wtf == var2) {
      var6 delete();
    }
  }

  scripts\mp\spawnlogic::bdiedonce([var3]);
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
  var8 = spawn("script_model", (-20, 1648, 68));
  var8.angles = (0, 180, 0);
  var8 setModel("building_wall_broken_corner_48x48_01_tan2");
  var9 = spawn("script_model", (-1352, 1780.5, 160));
  var9.angles = (0, 270, 0);
  var9 setModel("cinderblock_wall_topper_02_128");
  var10 = spawn("script_model", (-256, 536, 244));
  var10.angles = (0, 270, 0);
  var10 setModel("hardware_plywood_bare_01");
  var11 = spawn("script_model", (-998.672, 1585, 25.4966));
  var11.angles = (0, 184.399, -180);
  var11 setModel("barrier_traffic_concrete_block_01_chip_away_dead");
  var12 = spawn("script_model", (-1128, 672, 120));
  var12.angles = (360, 345, -90);
  var12 setModel("player128x128x8");

  if(!level.set_spotlight_target_loc) {
    var13 = getEnt("end", "script_noteworthy");
    var13.origin += (0, 48, 0);
    var14 = spawn("script_model", (-499.179, 667.972, -15.5977));
    var14.angles = (0, 303.999, -90.0001);
    var14 setModel("player128x128x8");
    return;
  }
}

function door_surprise_breach() {
  var0 = getEnt("door", "script_noteworthy");
  var1 = getEnt("door_l", "script_noteworthy");
  var2 = getEnt("door_r", "script_noteworthy");

  for(;;) {
    level waittill("course_started");

    while(!var0.activated) {
      waitframe();
    }

    playsoundatpos(var1.origin + (0, 0, 42), "scrpt_door_heavy_metal_single_bash");
    playsoundatpos(var2.origin + (0, 0, 42), "scrpt_door_heavy_metal_single_bash");
    var1 rotateYaw(-135, 0.3, 0, 0.1);
    var2 rotateYaw(135, 0.3, 0, 0.1);
    level waittill("course_ended");
    var1 rotateYaw(135, 1);
    var2 rotateYaw(-135, 1);
  }
}

function progression_gates() {
  var0 = getEnt("start_fence", "targetname");
  var1 = getEnt("start_fence_collision", "targetname");
  var2 = getEnt("start_fence_collision_opening", "targetname");
  var3 = getEnt("end_fence", "targetname");
  var4 = getEnt("end_fence_collision", "targetname");
  var5 = getEnt("backtrack_fence", "targetname");
  var6 = getEnt("backtrack_fence_collision_closed", "targetname");
  var2 linkTo(var0);

  if(level.set_spotlight_target_loc) {
    var7 = (0, 90, 0);
    var8 = (0, 0, 0);
    var9 = (0, 290, 0);
    var10 = (0, 0, 0);
    var11 = (0, 4, 0);
    var12 = (0, 270, 0);
    var13 = (-1030, 484, 82);
  } else {
    var7 = (0, 290, 0);
    var8 = (0, 0, 0);
    var9 = (0, 90, 0);
    var10 = (0, 0, 0);
    var11 = (0, 0, 0);
    var12 = (0, 90, 0);
    var13 = (-448, 530, 82);
  }

  level waittill("player_spawned");

  while(level.player getvelocity() == 0) {
    waitframe();
  }

  for(;;) {
    var7 rotateTo(var7, 2);
    scripts\engine\utility::play_sound_in_space("trial_sfx_door_chainlink_slow", var13);
    wait 1.5;
    var8 notsolid();
    level waittill("course_started");
    var8 solid();
    var9 notsolid();
    var13 notsolid();
    var11 notsolid();
    var7 rotateTo(var8, 2);
    var10 rotateTo(var9, 3);
    var12 rotateTo(var11, 1);
    level waittill("course_ended");
    var9 solid();
    var13 solid();
    var12 rotateTo(var12, 3);
    _tablethide::trial_ui_waittill_retry();
  }
}

function ref_12c55() {
  for(;;) {
    level waittill("course_ended");
    var0 = getentitylessscriptablearrayinradius("scriptable_scriptable_door_industrial_metal_mp_01", "classname");

    foreach(var2 in var0) {
      var2 vehicle_getinputvalue();
    }
  }
}

function target_random_models() {
  while(!isDefined(level.targets_thinking) || istrue(level.targets_thinking)) {
    waitframe();
  }

  var0 = ["ee_military_shooting_range_plate_enemy_01", "ee_military_shooting_range_plate_enemy_02", "ee_military_shooting_range_plate_enemy_03", "ee_military_shooting_range_plate_enemy_04", "ee_military_shooting_range_plate_enemy_05", "ee_military_shooting_range_plate_enemy_06"];
  var1 = ["ee_military_shooting_range_plate_civilian_01", "ee_military_shooting_range_plate_civilian_02", "ee_military_shooting_range_plate_civilian_03"];
  var2 = ["ee_military_shooting_range_plate_bullet", "ee_military_shooting_range_plate_bullet_01", "ee_military_shooting_range_plate_bullet_02", "ee_military_shooting_range_plate_bullet_03"];
  var3 = scripts\engine\utility::array_randomize(level.enemy_targets);
  var4 = scripts\engine\utility::array_randomize(level.civilian_targets);

  foreach(var6 in var3) {
    var6.bullet_decal = spawn("script_model", var6.plate.origin);
    var6.bullet_decal.angles = var6.plate.angles;
    var6.bullet_decal linkTo(var6.plate);

    if(isDefined(var6.script_parameters)) {
      var6.plate setModel(var6.script_parameters);
    }
  }

  foreach(var6 in var3) {
    var9 = scripts\engine\utility::getclosest(var6.origin, scripts\engine\utility::array_remove(var3, var6));
    var10 = scripts\engine\utility::getclosest(var6.origin, scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var3, var6), var9));
    var11 = scripts\engine\utility::getclosest(var6.origin, scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var3, var6), var9), var10));
    var12 = scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var2, var9.bullet_decal.model), var10.bullet_decal.model), var11.bullet_decal.model);

    if(!isDefined(var6.script_parameters)) {
      var13 = scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var0, var9.plate.model), var10.plate.model), var11.plate.model);
      var6.plate setModel(scripts\engine\utility::random(var13));
    }

    var6.bullet_decal setModel(scripts\engine\utility::random(var12));
  }

  foreach(var16 in var4) {
    var9 = scripts\engine\utility::getclosest(var16.origin, scripts\engine\utility::array_remove(var4, var16));
    var10 = scripts\engine\utility::getclosest(var16.origin, scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var4, var16), var9));

    if(isDefined(var16.script_parameters)) {
      var16.plate setModel(var16.script_parameters);
      continue;
    }

    var13 = scripts\engine\utility::array_remove(scripts\engine\utility::array_remove(var1, var9.plate.model), var10.plate.model);
    var16.plate setModel(scripts\engine\utility::random(var13));
  }
}