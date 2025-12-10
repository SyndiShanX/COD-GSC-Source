/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\oilrocks_apache_tutorial.gsc
*********************************************/

catchup_function() {
  common_scripts\utility::flag_set("FLAG_apache_tut_fly_dialogue_finished");
  thread maps\oilrocks_proximity_spawned_vehicles::main();
  thread maps\oilrocks_proximity_spawned_ai::main();
  thread maps\_utility::music_play("mus_oilrocks_intro");
}

start() {
  level.player setclienttriggeraudiozone("oilrocks_heli_gunner", 0.1);
  level.player.participation = 1000;
  var_0 = maps\oilrocks_code::spawn_apache_player("apache_tutorial_fly");
  maps\oilrocks_apache_code::spawn_blackhawk_ally("struct_blackhawk_ally_fly_in");
  maps\oilrocks_apache_code::spawn_apache_allies("struct_apache_ally_fly_in_0");
  setsaveddvar("vehHelicopterMaxPitch", 6.0);
  setsaveddvar("vehHelicopterPitchOffset", var_0.heli.pitch_offset_air);
}

main() {
  thread maps\_utility::music_play("mus_oilrocks_intro");
  thread maps\oilrocks_apache_vo::apache_mission_vo_think(maps\oilrocks_apache_vo::apache_mission_vo_tutorial);
  thread maps\oilrocks_apache_hints::apache_hints_tutorial();
  common_scripts\utility::flag_wait("introscreen_complete");
  level notify("start_opening_birds");
  thread apache_tutorial_fly_reactive_foliage();
  thread apache_tutorial_fly_allies();
  thread apache_tutorial_fly_move_until_input();
  thread apache_tutorial_fly_player_pitch_think();
  thread maps\oilrocks_proximity_spawned_vehicles::main();
  thread maps\oilrocks_proximity_spawned_ai::main();
  objectives();
}

objectives() {
  var_0 = maps\_utility::obj("tutorial");
  objective_add(var_0, "active", &"OILROCKS_OBJ_TUTORIAL");
  objective_current(var_0);
  common_scripts\utility::flag_wait("FLAG_apache_tut_fly_finished");
  maps\_utility::objective_complete(var_0);
}

apache_tutorial_fly_reactive_foliage() {
  setsaveddvar("r_reactiveMotionHelicopterLimit", 4);
  setsaveddvar("r_reactiveMotionHelicopterRadius", 1200);
  setsaveddvar("r_reactiveMotionHelicopterStrength", 30);
  common_scripts\utility::flag_wait("FLAG_apache_tut_fly_finished");
  wait 10;
  setsaveddvar("r_reactiveMotionHelicopterLimit", 1);
}

apache_tutorial_fly_player_pitch_think() {
  var_0 = maps\oilrocks_apache_code::get_apache_player();
  var_1 = var_0.heli.owner;
  var_1 endon("death");
  common_scripts\utility::flag_wait("FLAG_apache_tut_fly_half");
  thread maps\_utility::lerp_saveddvar("vehHelicopterMaxPitch", var_0.heli.pitch_max, 6.0);
}

apache_tutorial_fly_allies() {
  var_0 = common_scripts\utility::array_combine(maps\oilrocks_apache_code::get_apache_allies(), [maps\oilrocks_apache_code::get_blackhawk_ally()]);

  foreach(var_2 in var_0) {
    var_3 = undefined;

    if(issubstr(var_2.targetname, "apache"))
      var_3 = common_scripts\utility::getstruct("apache_ally_fly_in_path_0" + var_2 maps\oilrocks_apache_code::get_apache_ally_id(), "targetname");
    else
      var_3 = common_scripts\utility::getstruct("blackhaw_fly_in_path", "targetname");

    var_2 thread maps\oilrocks_code::chopper_boss_path_override(var_3);
  }

  common_scripts\utility::array_call(var_0, ::vehicle_setspeedimmediate, 90, 90);
  wait 0.1;
  common_scripts\utility::array_call(var_0, ::vehicle_setspeed, 90, 35, 35);
  common_scripts\utility::flag_wait("FLAG_apache_tut_fly_stop_auto_pilot");
  common_scripts\utility::array_call(var_0, ::vehicle_setspeed, 90, 35, 35);
  thread apache_tutorial_fly_allies_govern_speed(var_0);
}

apache_tutorial_fly_allies_govern_speed(var_0) {
  level endon("FLAG_apache_tut_fly_finished");
  thread apache_tutorial_fly_allies_govern_speed_stop(var_0, "FLAG_apache_tut_fly_finished");
  var_1 = maps\oilrocks_apache_code::get_apache_player();
  var_2 = squared(8400);
  var_3 = squared(4800);
  var_4 = squared(1800);
  var_5 = var_3 - var_4;
  var_6 = 0.25;
  var_7 = undefined;

  for(;;) {
    var_8 = undefined;

    foreach(var_10 in var_0) {
      if(!isDefined(var_8)) {
        var_8 = distance2dsquared(var_1.origin, var_10.origin);
        continue;
      }

      var_11 = distance2dsquared(var_1.origin, var_10.origin);

      if(var_11 < var_8)
        var_8 = var_11;
    }

    var_13 = undefined;

    if(var_8 >= var_2)
      var_13 = 0;
    else {
      var_14 = clamp(var_8, var_4, var_3);
      var_15 = 1 - (var_14 - var_4) / var_5;
      var_13 = 40 + 80 * var_15;
    }

    if(!isDefined(var_7) || abs(var_13 - var_7) / max(var_7, 0.001) > 0.1) {
      common_scripts\utility::array_call(var_0, ::vehicle_setspeed, var_13, 35, 35);
      var_7 = var_13;
    }

    wait(var_6);
  }
}

apache_tutorial_fly_allies_govern_speed_stop(var_0, var_1) {
  common_scripts\utility::flag_wait(var_1);
  common_scripts\utility::array_call(var_0, ::resumespeed, 35);
}

apache_tutorial_fly_move_until_input(var_0) {
  var_0 = maps\oilrocks_apache_code::get_apache_player();
  var_1 = var_0.heli.owner;
  var_1 endon("death");
  var_1 notifyonplayercommand("LISTEN_heli_movement_input", "+toggleads_throw");
  var_1 notifyonplayercommand("LISTEN_heli_movement_input", "+speed_throw");
  var_1 notifyonplayercommand("LISTEN_heli_movement_input", "+speed");
  var_1 notifyonplayercommand("LISTEN_heli_movement_input", "+ads_akimbo_accessible");
  var_1 notifyonplayercommand("LISTEN_heli_movement_input", "-toggleads_throw");
  var_1 notifyonplayercommand("LISTEN_heli_movement_input", "-speed_throw");
  var_1 notifyonplayercommand("LISTEN_heli_movement_input", "-speed");
  var_1 notifyonplayercommand("LISTEN_heli_movement_input", "-ads_akimbo_accessible");
  var_1 notifyonplayercommand("LISTEN_heli_movement_input", "+smoke");
  var_1 notifyonplayercommand("LISTEN_heli_movement_input", "-smoke");
  thread apache_owner_notify_on_input_camera(var_0, "LISTEN_heli_movement_input");
  thread apache_owner_notify_on_input_move(var_0, "LISTEN_heli_movement_input");
  thread apache_move_until_notify(var_0, 90, "LISTEN_heli_movement_input", "FLAG_apache_tut_fly_stop_auto_pilot");
  var_1 waittill("LISTEN_heli_movement_input");
  common_scripts\utility::flag_set("FLAG_apache_tut_fly_stop_control_hint");
  common_scripts\utility::flag_set("FLAG_apache_tut_fly_stop_auto_pilot");
}

apache_move_until_notify(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3))
    level endon(var_3);

  var_4 = var_0.heli.owner;

  if(isDefined(var_2))
    var_4 endon(var_2);

  var_4 endon("death");

  for(;;) {
    var_0 vehicle_setspeedimmediate(var_1, var_1, var_1 * 0.05);
    wait 0.05;
  }
}

apache_owner_notify_on_input_camera(var_0, var_1) {
  var_2 = var_0.heli.owner;
  var_2 endon(var_1);

  for(;;) {
    var_3 = var_2 getnormalizedcameramovement();

    if(max(abs(var_3[0]), abs(var_3[1])) > 0.2) {
      break;
    }

    wait 0.05;
  }

  var_2 notify(var_1);
}

apache_owner_notify_on_input_move(var_0, var_1) {
  var_2 = var_0.heli.owner;
  var_2 endon(var_1);

  for(;;) {
    var_3 = var_2 getnormalizedmovement();

    if(max(abs(var_3[0]), abs(var_3[1])) > 0.2) {
      break;
    }

    wait 0.05;
  }

  var_2 notify(var_1);
}