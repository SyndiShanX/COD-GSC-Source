/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\co_hunted.gsc
********************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_ac130;
#include maps\co_ac130_code;
#include maps\_hud_util;
#include maps\_specialops;

CONST_specop_difficulty = 50;
CONST_laser_hint_timeout = 25;

main() {
  default_start(::start_ac130);
  set_default_start("ac130");
  add_start("ac130", ::start_ac130, "[ac130] -> default gameplay");
  add_start("so", ::start_specop, "[so] -> spec op gameplay");

  level.default_goalradius = 2048;
  level.default_goalheight = 512;

  setDvarIfUninitialized("no_respawn", "1");
  setDvarIfUninitialized("do_saves", "0");

  battlechatter_off("allies");
  battlechatter_off("axis");

  precacheLevelStuff();
  vehicleScripts();

  if(level.console) {
    level.hint_text_size = 1.6;
  } else {
    level.hint_text_size = 1.2;
  }

  precacheShader("waypoint_targetneutral");
  precacheShader("waypoint_checkpoint_neutral_a");
  precacheShader("waypoint_checkpoint_neutral_b");
  precacheShader("waypoint_checkpoint_neutral_c");
  precacheShader("waypoint_checkpoint_neutral_d");
  precacheShader("waypoint_checkpoint_neutral_e");

  precachestring(&"CO_HUNTED_TIME_TILL_CHECKPOINT_A");

  precachestring(&"CO_HUNTED_TIME_TILL_CHECKPOINT_B");

  precachestring(&"CO_HUNTED_TIME_TILL_CHECKPOINT_C");

  precachestring(&"CO_HUNTED_TIME_TILL_CHECKPOINT_D");

  precachestring(&"CO_HUNTED_CO_HUNTED_SPECOP_TIMER");

  precachestring(&"CO_HUNTED_TIME_TILL_EXPLOSION");

  precachestring(&"CO_HUNTED_TIMER_EXPIRED");

  precachestring(&"CO_HUNTED_EXPIRED_SPECOP");

  precachestring(&"CO_HUNTED_OBJ_CROSS_BRIDGE");

  precachestring(&"CO_HUNTED_OBJ_REACH_BARN");

  precachestring(&"CO_HUNTED_MISSED_CHECKPOINT_A");

  precachestring(&"CO_HUNTED_MISSED_CHECKPOINT_B");

  precachestring(&"CO_HUNTED_MISSED_CHECKPOINT_C");

  precachestring(&"CO_HUNTED_MISSED_CHECKPOINT_D");

  precachestring(&"AC130_HINT_CYCLE_WEAPONS");

  precachestring(&"CO_HUNTED_HINT_LASER");

  maps\_truck::main("vehicle_pickup_roobars");
  level.weaponClipModels = [];
  level.weaponClipModels[0] = "weapon_ak47_clip";
  level.weaponClipModels[1] = "weapon_m16_clip";

  maps\co_hunted_fx::main();
  maps\co_hunted_precache::main();
  maps\_load::main();
  maps\_compass::setupMiniMap("compass_map_hunted");

  add_hint_string("ac130_changed_weapons", &"AC130_HINT_CYCLE_WEAPONS", ::ShouldBreakAC130HintPrint);

  add_hint_string("laser_hint", &"CO_HUNTED_HINT_LASER", ::ShouldBreakLaserHintPrint);
}

gameplay_logic(gametype) {
  if(!isDefined(gametype)) {
    gametype = "default";
  }

  flag_init("timer_expired");

  if(gametype != "specop") {
    level.alphaTeam = getEntArray("alpha", "targetname");
    level.bravoTeam = getEntArray("bravo", "targetname");

    array_thread(level.alphaTeam, ::set_thermal_LOD);
    array_thread(level.bravoTeam, ::set_thermal_LOD);
  } else {
    level.challenge_start_time = gettime();
    thread fade_challenge_in();

    array_call(GetSpawnerTeamArray("allies"), ::delete);
    array_call(GetAIArray("allies"), ::delete);
  }

  enemies = getspawnerteamarray("axis");
  array_thread(enemies, ::add_spawn_function, ::set_thermal_LOD);
  array_thread(enemies, ::add_spawn_function, ::kill_after_time, 60);

  if(is_coop()) {
    maps\co_ac130_anim::main();
    maps\co_ac130_snd::main();

    level.ac130_flood_respawn = true;
    maps\_nightvision::main(level.players);
    maps\_ac130::init();

    if(gametype != "specop") {
      array_thread(level.alphaTeam, ::add_beacon_effect);
      array_thread(level.bravoTeam, ::add_beacon_effect);
    }

    if(level.player == level.ac130gunner) {
      level.ground_player = level.player2;
    } else {
      level.ground_player = level.player;
    }

    level.ground_player thread add_beacon_effect();

    level.ground_player thread hint_timeout();
    level.ground_player ent_flag_init("player_used_laser");
    level.ground_player thread laser_targeting_device();
    level.ground_player thread display_hint("laser_hint");

    level.ground_player set_vision_set_player("hunted", 0);

    move_ac130 = getEntArray("move_ac130", "targetname");
    array_thread(move_ac130, ::move_ac130_think);

    level.ac130gunner laserForceOn();

    thread ac130_change_weapon_hint();

    wait 0.1;
    flag_clear("coop_revive");
    flag_set("clear_to_engage");
  } else {
    level.ground_player = level.player;
    maps\_nightvision::main();
    level.player set_vision_set_player("hunted", 0);
  }

  battlechatter_on("allies");
  battlechatter_on("axis");

  saveGame("levelstart", &"AUTOSAVE_LEVELSTART", "whatever", true);

  level.timed = true;

  if(gametype != "specop") {
    array_thread(level.alphaTeam, ::magic_bullet_shield);
  }

  thread open_all_doors();
  thread enemy_monitor();

  if(level.timed) {
    thread timer_start();
  }

  thread objective(gametype);
  thread checkpoint_system(gametype);

  delete_vehicle_nodes = getEntArray("delete_vehicle", "script_noteworthy");
  array_thread(delete_vehicle_nodes, ::delete_vehicle_think);

  thread move_enemies_to_closest_goal_radius(gametype);
}
start_ac130() {
  thread gameplay_logic("default");
}

start_specop() {
  thread gameplay_logic("specop");
}

move_enemies_to_closest_goal_radius(gametype) {
  level endon("specop_challenge_completed");

  goals = getEntArray("enemy_goal_radius", "targetname");
  level.current_goal = getclosest(level.ground_player.origin, goals);

  level.hunter_enemies = [];
  spawners = getspawnerarray();
  array_thread(spawners, ::add_spawn_function, ::create_hunter_enemy);

  if(gametype == "specop") {
    move_deadlier_hunters_to_new_goal(level.current_goal);
  } else {
    move_hunters_to_new_goal(level.current_goal);
  }

  while(1) {
    closest_goal = getclosest(level.ground_player.origin, goals);

    if(level.current_goal != closest_goal) {
      level.current_goal = closest_goal;

      if(gametype == "specop") {
        move_deadlier_hunters_to_new_goal(closest_goal);
      } else {
        move_hunters_to_new_goal(closest_goal);
      }
    }
    wait 1;
  }
}

create_hunter_enemy() {
  if(self.team != "axis") {
    return;
  }
  level.hunter_enemies[self.unique_id] = self;
  self setgoalpos(level.current_goal.origin);

  self waittill("death");

  level.hunter_enemies[self.unique_id] = undefined;
}

move_hunters_to_new_goal(closest_goal) {
  waittillframeend;

  foreach(enemy in level.hunter_enemies) {
    enemy setgoalpos(closest_goal.origin);
  }
}

move_deadlier_hunters_to_new_goal(closest_goal) {
  waittillframeend;

  if(RandomInt(100) < CONST_specop_difficulty) {
    enemy setgoalpos(closest_goal.origin);
  } else {
    enemy setgoalentity(level.ground_player);
  }
}
}

ShouldBreakAC130HintPrint() {
  return flag("player_changed_weapons");
}

hint_timeout() {
  self.hint_timeout = CONST_laser_hint_timeout;
  while(self.hint_timeout > -1) {
    self.hint_timeout--;
    wait 1;
  }
}

ShouldBreakLaserHintPrint() {
  if(!isDefined(level.ground_player)) {
    return false;
  } else if(isDefined(level.ground_player.hint_timeout) && level.ground_player.hint_timeout <= 0) {
    return true;
  } else {
    return level.ground_player ent_flag("player_used_laser");
  }
}

ac130_change_weapon_hint() {
  wait 12;
  if(!flag("player_changed_weapons")) {
    level.ac130gunner thread display_hint("ac130_changed_weapons");
  }
}

hintPrint_coop(string) {
  hint = hint_create(string, true, 0.8);
  wait 5;
  hint hint_delete();
}

delete_vehicle_think() {
  while(true) {
    self waittill("trigger", vehicle);
    vehicle delete();
  }
}

checkpoint_system(gametype) {
  if(gametype == "default") {
    checkpoint_logic(60, "checkpoint_a", "waypoint_checkpoint_neutral_a", &"CO_HUNTED_TIME_TILL_CHECKPOINT_A", &"CO_HUNTED_MISSED_CHECKPOINT_A");

    checkpoint_logic(80, "checkpoint_b", "waypoint_checkpoint_neutral_b", &"CO_HUNTED_TIME_TILL_CHECKPOINT_B", &"CO_HUNTED_MISSED_CHECKPOINT_B");

    checkpoint_logic(110, "checkpoint_c", "waypoint_checkpoint_neutral_c", &"CO_HUNTED_TIME_TILL_CHECKPOINT_C", &"CO_HUNTED_MISSED_CHECKPOINT_C");

    checkpoint_logic(60, "checkpoint_d", "waypoint_checkpoint_neutral_d", &"CO_HUNTED_TIME_TILL_CHECKPOINT_D", &"CO_HUNTED_MISSED_CHECKPOINT_D");

    escape = getent("escape_obj", "targetname");
    escape thread threeD_objective_hint("waypoint_targetneutral");
  } else {
    specop_obj = getent("checkpoint_b", "targetname");
    specop_obj thread threeD_objective_hint("waypoint_targetneutral");
  }
}

checkpoint_logic(time, flag_name, shader, timer_string, timer_expired_string) {
  checkpoint_origin = getent(flag_name, "targetname");
  checkpoint_origin thread threeD_objective_hint(shader, "kill_3d_checkpoint_icon");

  if(level.timed) {
    thread checkpoint_timer_logic(time, timer_string, timer_expired_string);
  }
  thread waittill_checkpoint_hit(flag_name);

  level waittill_either("checkpoint_timer_expired", flag_name);

  level notify("kill_3d_checkpoint_icon");
  wait 1;
  return;
}

waittill_checkpoint_hit(flag_name) {
  level endon("checkpoint_timer_expired");

  flag_wait(flag_name);

  if(isDefined(level.checkpoint_timer)) {
    level.checkpoint_timer destroy();
  }
  level notify("kill_checkpoint_timer");
}

checkpoint_timer_logic(iSeconds, sLabel, timer_expired_string) {
  level endon("kill_checkpoint_timer");

  level.hudTimerIndex = 20;
  level.checkpoint_timer = maps\_hud_util::get_countdown_hud(-250, 120);

  level.checkpoint_timer.label = sLabel;
  level.checkpoint_timer settenthstimer(iSeconds);

  wait(iSeconds);

  thread hint(timer_expired_string, 4);
  level notify("checkpoint_timer_expired");
  level.checkpoint_timer destroy();
}

move_ac130_think() {
  self waittill("trigger");

  point = (getent(self.target, "targetname")).origin;

  thread movePlaneToPoint(point);
}

open_all_doors() {
  door = getent("farmer_front_door", "targetname");
  door rotateyaw(95, 0.7, 0.5, 0.2);
  door connectpaths();

  gate = getent("creek_gate", "targetname");
  gate hunted_style_door_open("door_gate_chainlink_slow_open");
}

enemy_monitor() {
  level.enemy_force = [];
  level.enemy_force[0] = spawnStruct();
  level.enemy_force[0].name = "farmers_house_spawners";
  level.enemy_force[0].type = "spawners";

  level.enemy_force[1] = spawnStruct();
  level.enemy_force[1].name = "lone_barn_spawners";
  level.enemy_force[1].type = "spawners";

  level.enemy_force[2] = spawnStruct();
  level.enemy_force[2].name = "down_road_spawners";
  level.enemy_force[2].type = "spawners";

  level.enemy_force[3] = spawnStruct();
  level.enemy_force[3].name = "first_field_heli_drop";
  level.enemy_force[3].type = "multi_use_vehicle";

  level.enemy_force[4] = spawnStruct();
  level.enemy_force[4].name = "second_field_heli_drop";
  level.enemy_force[4].type = "multi_use_vehicle";

  level.enemy_force[5] = spawnStruct();
  level.enemy_force[5].name = "pickup_rightside_bridge";
  level.enemy_force[5].type = "one_use_vehicle";
  level.enemy_force[5].drove = false;

  level.enemy_force[6] = spawnStruct();
  level.enemy_force[6].name = "pickup_leftside_starting_bridge";
  level.enemy_force[6].type = "one_use_vehicle";
  level.enemy_force[6].drove = false;

  level.enemy_force[7] = spawnStruct();
  level.enemy_force[7].name = "farmers_house_spawners";
  level.enemy_force[7].type = "spawners";

  level.enemy_force = array_randomize(level.enemy_force);
  level.selection = 0;

  thread enemy_monitor_loop();

  flag_wait("leaving_creek");

  level.enemy_force = [];
  level.enemy_force[0] = spawnStruct();
  level.enemy_force[0].name = "back_left_side_spawners";
  level.enemy_force[0].type = "spawners";

  level.enemy_force[1] = spawnStruct();
  level.enemy_force[1].name = "front_left_side_spawners";
  level.enemy_force[1].type = "spawners";

  level.enemy_force[2] = spawnStruct();
  level.enemy_force[2].name = "cellar_house_spawners";
  level.enemy_force[2].type = "spawners";

  level.enemy_force[3] = spawnStruct();
  level.enemy_force[3].name = "pickup_leftside_fields";
  level.enemy_force[3].type = "one_use_vehicle";
  level.enemy_force[3].drove = false;

  level.enemy_force[4] = spawnStruct();
  level.enemy_force[4].name = "cellar_field_heli_drop";
  level.enemy_force[4].type = "multi_use_vehicle";

  level.enemy_force[5] = spawnStruct();
  level.enemy_force[5].name = "cellar_house_spawners";
  level.enemy_force[5].type = "spawners";

  level.enemy_force = array_randomize(level.enemy_force);
  level.selection = 0;

  flag_wait("at_cellar");

  level.enemy_force = [];
  level.enemy_force[0] = spawnStruct();
  level.enemy_force[0].name = "work_shop_spawners";
  level.enemy_force[0].type = "spawners";

  level.enemy_force[1] = spawnStruct();
  level.enemy_force[1].name = "garage_spawners";
  level.enemy_force[1].type = "spawners";

  level.enemy_force[2] = spawnStruct();
  level.enemy_force[2].name = "shed_spawners";
  level.enemy_force[2].type = "spawners";

  level.enemy_force[3] = spawnStruct();
  level.enemy_force[3].name = "over_creek_heli_drop";
  level.enemy_force[3].type = "multi_use_vehicle";

  level.enemy_force[4] = spawnStruct();
  level.enemy_force[4].name = "work_shop_spawners";
  level.enemy_force[4].type = "spawners";

  level.enemy_force[5] = spawnStruct();
  level.enemy_force[5].name = "garage_spawners";
  level.enemy_force[5].type = "spawners";

  level.enemy_force[6] = spawnStruct();
  level.enemy_force[6].name = "work_shop_spawners";
  level.enemy_force[6].type = "spawners";

  level.enemy_force = array_randomize(level.enemy_force);
  level.selection = 0;

  spawn_enemy_group();
  spawn_enemy_group();

  flag_wait("exit_work_shops");

  level.enemy_force = [];
  level.enemy_force[0] = spawnStruct();
  level.enemy_force[0].name = "pickup_leftside_greenhouses";
  level.enemy_force[0].type = "one_use_vehicle";
  level.enemy_force[0].drove = false;

  level.enemy_force[1] = spawnStruct();
  level.enemy_force[1].name = "windmill_field_heli_drop";
  level.enemy_force[1].type = "multi_use_vehicle";

  level.enemy_force[2] = spawnStruct();
  level.enemy_force[2].name = "white_fence_heli_drop";
  level.enemy_force[2].type = "multi_use_vehicle";

  level.enemy_force[3] = spawnStruct();
  level.enemy_force[3].name = "barn_spawners";
  level.enemy_force[3].type = "spawners";

  level.enemy_force[4] = spawnStruct();
  level.enemy_force[4].name = "pickup_leftside_bridge";
  level.enemy_force[4].type = "one_use_vehicle";
  level.enemy_force[4].drove = false;

  level.enemy_force[5] = spawnStruct();
  level.enemy_force[5].name = "pickup_from_barn";
  level.enemy_force[5].type = "one_use_vehicle";
  level.enemy_force[5].drove = false;

  level.enemy_force = array_randomize(level.enemy_force);
  level.selection = 0;

  spawn_enemy_group();
  spawn_enemy_group();

  flag_wait("mid_wind_mill_field");

  level.enemy_force = [];
  level.enemy_force[0] = spawnStruct();
  level.enemy_force[0].name = "green_house_heli_drop";
  level.enemy_force[0].type = "one_use_vehicle";
  level.enemy_force[0].drove = false;

  level.enemy_force[1] = spawnStruct();
  level.enemy_force[1].name = "silo_spawners";
  level.enemy_force[1].type = "spawners";

  level.enemy_force[2] = spawnStruct();
  level.enemy_force[2].name = "barn_spawners";
  level.enemy_force[2].type = "spawners";

  level.enemy_force[3] = spawnStruct();
  level.enemy_force[3].name = "gas_station_spawners";
  level.enemy_force[3].type = "spawners";

  level.enemy_force[4] = spawnStruct();
  level.enemy_force[4].name = "silo_spawners";
  level.enemy_force[4].type = "spawners";

  level.enemy_force[5] = spawnStruct();
  level.enemy_force[5].name = "barn_spawners";
  level.enemy_force[5].type = "spawners";

  level.enemy_force[6] = spawnStruct();
  level.enemy_force[6].name = "gas_station_spawners";
  level.enemy_force[6].type = "spawners";

  level.enemy_force = array_randomize(level.enemy_force);
  level.selection = 0;

  spawn_enemy_group();
  spawn_enemy_group();
}

spawn_enemy_group() {
  if(level.selection >= level.enemy_force.size) {
    if(getDvar("no_respawn") == "1") {
      return;
    } else {
      level.selection = 0;
    }
  }
  s_name = level.enemy_force[level.selection].name;
  s_number = level.selection;
  level.selection++;

  if(level.enemy_force[s_number].type == "one_use_vehicle") {
    if(level.enemy_force[s_number].drove) {
      return;
    }
    vehicle = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(s_name);
    level.enemy_force[s_number].drove = true;
    return;
  }

  if(level.enemy_force[s_number].type == "multi_use_vehicle") {
    vehicle = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(s_name);
    return;
  }

  enemy_spawners = getEntArray(s_name, "targetname");
  for(i = 0; i < enemy_spawners.size; i++) {
    guy = enemy_spawners[i] spawn_ai();
  }

  wait 1;
}

enemy_monitor_loop() {
  while(true) {
    enemies = getaiarray("axis");
    total = enemies.size;
    roaming = total;

    for(i = 0; i < enemies.size; i++) {
      if(isDefined(enemies[i].script_noteworthy)) {
        if(enemies[i].script_noteworthy == "defender") {
          roaming--;
        }
      }
      println("roaming/total: " + roaming + "/" + total);
    }
    if(roaming < 13) {
      spawn_enemy_group();
    }
    wait 1;
  }
}

timer_start(gametype) {
  dialogue_line = undefined;
  iSeconds = undefined;
  switch (level.gameSkill) {
    case 0:
      iSeconds = 260;
      break;
    case 1:
      iSeconds = 200;
      break;
    case 2:
      iSeconds = 140;
      break;
    case 3:
      iSeconds = 110;
      break;
  }
  assert(isDefined(iSeconds));

  level thread bridge_timer_logic(iSeconds, &"CO_HUNTED_SPECOP_TIMER");
}

bridge_timer_logic(iSeconds, sLabel, bUseTick) {
  if(!isDefined(bUseTick)) {
    bUseTick = false;
  }

  killTimer();
  level endon("kill_timer");

  level.hudTimerIndex = 20;
  level.timer = maps\_hud_util::get_countdown_hud(-250, 100);
  level.timer SetPulseFX(30, 900000, 700);
  level.timer.label = sLabel;
  level.timer settenthstimer(iSeconds);
  level.start_time = gettime();

  if(bUseTick == true) {
    thread timer_tick();
  }
  wait(iSeconds);

  flag_set("timer_expired");
  level.timer destroy();

  level thread mission_failed_out_of_time(&"CO_HUNTED_EXPIRED_SPECOP");
}

mission_failed_out_of_time(deadquote) {
  level.player endon("death");
  level endon("kill_timer");

  level notify("mission failed");
  level.player freezeControls(true);

  musicstop(1);
  setDvar("ui_deadquote", deadquote);

  wait 3;

  maps\_utility::missionFailedWrapper();
  level notify("kill_timer");
}

player_death_effect() {
  player = level.player;
  playFX(level._effect["player_death_explosion"], player.origin);

  earthquake(1, 1, level.player.origin, 100);
}

objective(gametype) {
  if(gametype == "default") {
    escape = getent("escape_obj", "targetname");

    objective_add(1, "active", &"CO_HUNTED_OBJ_CROSS_BRIDGE", escape.origin);
    objective_current(1);
    flag_wait("escaped");
    objective_state(1, "done");

    nextmission();
  }

  if(gametype == "specop") {
    specop_barn = getent("checkpoint_b", "targetname");

    objective_add(1, "active", &"CO_HUNTED_OBJ_REACH_BARN", specop_barn.origin);
    objective_current(1);
    flag_wait("checkpoint_b");
    objective_state(1, "done");

    level notify("specop_challenge_completed");
    array_call(GetAIArray(), ::delete);
    killTimer();
  }
}

threeD_objective_hint(shader, destroyer_msg) {
  self.icon = NewHudElem();

  self.icon SetShader(shader, 1, 1);
  self.icon.alpha = .5;
  self.icon.color = (1, 1, 1);

  origin = self getOrigin();
  self.icon.x = origin[0];
  self.icon.y = origin[1];
  self.icon.z = origin[2];
  self.icon SetWayPoint(false, true);

  if(isDefined(destroyer_msg)) {
    level waittill(destroyer_msg);

    self.icon destroy();
  }
}

timer_tick() {
  level endon("stop_timer_tick");
  level endon("kill_timer");
  while(true) {
    wait(1);
    level.player thread play_sound_on_entity("countdown_beep");
    level notify("timer_tick");
  }
}

killTimer() {
  level notify("kill_timer");
  if(isDefined(level.timer)) {
    level.timer destroy();
  }
}

kill_after_time(time) {
  wait(time);
  if(isalive(self)) {
    self kill();
  }
}

set_thermal_LOD() {
  self ThermalDrawEnable();
}

draw_ground_player_facing() {
  color = (1, 1, 1);

  while(1) {
    forward = anglesToForward(level.ground_player.angles);
    forwardfar = vector_multiply(forward, 200);
    forwardclose = vector_multiply(forward, 100);
    start = forwardclose + level.ground_player.origin;
    end = forwardfar + level.ground_player.origin;
    draw_arrow_ac130(start, end, color);
    wait .05;
  }
}

draw_arrow_ac130(start, end, color) {
  pts = [];
  angles = vectortoangles(start - end);
  right = anglestoright(angles);
  forward = anglesToForward(angles);

  dist = distance(start, end);
  arrow = [];
  range = 0.5;
  arrow[0] = start;
  arrow[1] = start + vector_multiply(right, dist * (range)) + vector_multiply(forward, dist * -0.2);
  arrow[2] = end;
  arrow[3] = start + vector_multiply(right, dist * (-1 * range)) + vector_multiply(forward, dist * -0.2);

  line(arrow[0], arrow[2], color, 1.0);
  line(arrow[2], arrow[1], color, 1.0);
  line(arrow[2], arrow[3], color, 1.0);
}