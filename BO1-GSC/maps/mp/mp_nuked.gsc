/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_nuked.gsc
**************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

main() {
  maps\mp\mp_nuked_fx::main();
  precachemodel("collision_wall_128x128x10");
  move_spawn_point("mp_dom_spawn", (791, 449, -20), (779, 445, -20));
  maps\mp\_load::main();
  maps\mp\mp_nuked_amb::main();
  maps\mp\_compass::setupMiniMap("compass_map_mp_nuked");
  level.onSpawnIntermission = ::nuked_intermission;
  maps\mp\gametypes\_teamset_urbanspecops::level_init();
  setdvar("compassmaxrange", "2100");
  game["strings"]["war_callsign_a"] = &"MPUI_CALLSIGN_MAPNAME_A";
  game["strings"]["war_callsign_b"] = &"MPUI_CALLSIGN_MAPNAME_B";
  game["strings"]["war_callsign_c"] = &"MPUI_CALLSIGN_MAPNAME_C";
  game["strings"]["war_callsign_d"] = &"MPUI_CALLSIGN_MAPNAME_D";
  game["strings"]["war_callsign_e"] = &"MPUI_CALLSIGN_MAPNAME_E";
  game["strings_menu"]["war_callsign_a"] = "@MPUI_CALLSIGN_MAPNAME_A";
  game["strings_menu"]["war_callsign_b"] = "@MPUI_CALLSIGN_MAPNAME_B";
  game["strings_menu"]["war_callsign_c"] = "@MPUI_CALLSIGN_MAPNAME_C";
  game["strings_menu"]["war_callsign_d"] = "@MPUI_CALLSIGN_MAPNAME_D";
  game["strings_menu"]["war_callsign_e"] = "@MPUI_CALLSIGN_MAPNAME_E";
  maps\mp\gametypes\_spawning::level_use_unified_spawning(true);
  SetDvar("scr_spawn_enemy_influencer_radius", 1600);
  SetDvar("scr_spawn_dead_friend_influencer_radius", 1300);
  SetDvar("scr_spawn_dead_friend_influencer_timeout_seconds", 8);
  SetDvar("scr_spawn_dead_friend_influencer_count", 7);
  spawncollision("collision_wall_128x128x10", "collider", (769.2, 329.3, 143), (0, 290.6, 0));
  spawncollision("collision_wall_128x128x10", "collider", (769.2, 329.3, 271), (0, 290.6, 0));
  level.const_fx_exploder_end_game_glass_shatter = 5001;
  level.disableOutroVisionSet = true;
  level thread nuked_mannequin_init();
  nuked_doomsday_clock_init();
  level thread maps\mp\mp_nuked_platform::main();
  level thread nuked_population_sign_think();
  level thread nuked_bomb_drop_think();
}
move_spawn_point(targetname, start_point, new_point) {
  spawn_points = getEntArray(targetname, "classname");
  for(i = 0; i < spawn_points.size; i++) {
    if(distancesquared(spawn_points[i].origin, start_point) < 1) {
      spawn_points[i].origin = new_point;
      return;
    }
  }
}
nuked_mannequin_init() {
  keep_count = 28;
  level.mannequin_count = 0;
  destructibles = getEntArray("destructible", "targetname");
  mannequins = nuked_mannequin_filter(destructibles);
  if(mannequins.size <= 0) {
    return;
  }
  remove_count = mannequins.size - keep_count;
  remove_count = clamp(remove_count, 0, remove_count);
  mannequins = array_randomize(mannequins);
  for(i = 0; i < remove_count; i++) {
    assert(isDefined(mannequins[i].target));
    collision = GetEnt(mannequins[i].target, "targetname");
    assert(isDefined(collision));
    collision delete();
    mannequins[i] delete();
    level.mannequin_count--;
  }
  level waittill("prematch_over");
  level.mannequin_time = GetTime();
}
nuked_mannequin_filter(destructibles) {
  mannequins = [];
  for(i = 0; i < destructibles.size; i++) {
    destructible = destructibles[i];
    if(IsSubStr(destructible.destructibledef, "male")) {
      mannequins[mannequins.size] = destructible;
      level.mannequin_count++;
    }
  }
  return mannequins;
}
nuked_intermission() {
  maps\mp\gametypes\_globallogic_defaults::default_onSpawnIntermission();
  if(wasLastRound()) {
    level notify("bomb_drop");
  }
}
nuked_bomb_drop_think() {
  cameraStart = GetStruct("endgame_camera_start", "targetname");
  cameraEnd = GetStruct(cameraStart.target, "targetname");
  bomb = GetEnt("nuked_bomb", "targetname");
  for(;;) {
    camera = spawn("script_model", cameraStart.origin);
    camera.angles = cameraStart.angles;
    camera setModel("tag_origin");
    level waittill("bomb_drop");
    for(i = 0; i < get_players().size; i++) {
      player = get_players()[i];
      player CameraSetPosition(camera);
      player CameraSetLookAt();
      player CameraActivate(true);
    }
    cam_move_time = set_dvar_float_if_unset("scr_cam_move_time", "2.5");
    bomb_explode_delay = set_dvar_float_if_unset("scr_bomb_explode_delay", "1.5");
    glass_break_delay = set_dvar_float_if_unset("scr_glass_break_delay", "0.5");
    camera MoveTo(cameraEnd.origin, cam_move_time, 0, 0);
    camera RotateTo(cameraEnd.angles, cam_move_time, 0, 0);
    bomb playSound("amb_end_nuke");
    dest = (bomb.origin[0], bomb.origin[1], bomb.origin[2] - 3700);
    time = set_dvar_float_if_unset("scr_bomb_time", "1.5");
    accel_time = set_dvar_float_if_unset("scr_bomb_accel_time", ".75");
    bomb MoveTo(dest, time, accel_time, 0);
    wait(bomb_explode_delay);
    playFX(level._effect["fx_mp_nuked_nuclear_explosion"], bomb.origin);
    wait(glass_break_delay);
    level thread waitForGlassBreak();
    cameraForward = anglesToForward(cameraEnd.angles);
    explodePoint = cameraEnd.origin + 20 * cameraForward;
    physicsExplosionSphere(explodePoint, 128, 128, 1);
    RadiusDamage(explodePoint, 128, 128, 128);
    camera thread vibrate();
  }
}
vibrate() {
  self endon("death");
  pitchVibrateAmplitude = 1;
  vibrateAmplitude = 2;
  vibrateTime = 0.05;
  originalAngles = self.angles;
  angles0 = (originalAngles[0], originalAngles[1], originalAngles[2] - vibrateAmplitude);
  angles1 = (originalAngles[0], originalAngles[1], originalAngles[2] + vibrateAmplitude);
  for(;;) {
    angles0 = (originalAngles[0] - pitchVibrateAmplitude, originalAngles[1], originalAngles[2] - vibrateAmplitude);
    angles1 = (originalAngles[0] + pitchVibrateAmplitude, originalAngles[1], originalAngles[2] + vibrateAmplitude);
    self RotateTo(angles0, vibrateTime);
    self waittill("rotatedone");
    self RotateTo(angles1, vibrateTime);
    self waittill("rotatedone");
    if(vibrateAmplitude > 0)
      vibrateAmplitude -= 0.25;
    pitchVibrateAmplitude = 0 - pitchVibrateAmplitude;
    pitchVibrateAmplitude *= 0.66;
  }
}
waitForGlassBreak() {
  level endon("bomb_reset");
  level waittill("glass_smash", origin);
  exploder(level.const_fx_exploder_end_game_glass_shatter);
}
nuked_population_sign_think() {
  tens_model = GetEnt("counter_tens", "targetname");
  ones_model = GetEnt("counter_ones", "targetname");
  step = (360 / 10);
  ones = 0;
  tens = 0;
  tens_model RotateRoll(step, 0.05);
  ones_model RotateRoll(step, 0.05);
  for(;;) {
    wait(1);
    for(;;) {
      num_players = get_players().size;
      dial = ones + (tens * 10);
      if(num_players < dial) {
        ones--;
        time = set_dvar_float_if_unset("scr_dial_rotate_time", "0.5");
        if(ones < 0) {
          ones = 9;
          tens_model RotateRoll(0 - step, time);
          tens--;
        }
        ones_model RotateRoll(0 - step, time);
        ones_model waittill("rotatedone");
      } else if(num_players > dial) {
        ones++;
        time = set_dvar_float_if_unset("scr_dial_rotate_time", "0.5");
        if(ones > 9) {
          ones = 0;
          tens_model RotateRoll(step, time);
          tens++;
        }
        ones_model RotateRoll(step, time);
        ones_model waittill("rotatedone");
      } else {
        break;
      }
    }
  }
}
nuked_doomsday_clock_init() {
  min_hand_model = GetEnt("clock_min_hand", "targetname");
  sec_hand_model = GetEnt("clock_sec_hand", "targetname");
  start_angle = 318;
  min_hand_model RotatePitch(start_angle, 0.05);
  min_hand_model waittill("rotatedone");
  if(level.timelimit > 0) {
    min_hand_model RotatePitch(360 - start_angle, level.timelimit * 60);
    sec_hand_model RotatePitch(360 * level.timelimit, level.timelimit * 60);
  } else {
    sec_hand_model thread nuked_doomsday_clock_seconds_think();
  }
}
nuked_doomsday_clock_seconds_think() {
  for(;;) {
    self RotatePitch(360, 60);
    self waittill("rotatedone");
  }
}

