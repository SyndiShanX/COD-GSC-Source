/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\arcadia_stryker.gsc
********************************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#include maps\_vehicle;
#include maps\arcadia;
#include maps\arcadia_code;

STRYKER_TARGET_OFFSET_VEHICLE = 30;
STRYKER_TARGET_OFFSET_HELICOPTER = -80;
STRYKER_MANUAL_AI_DURATION = 20;

setup_stryker_modes() {
  level.stryker_settings["ai"] = spawnStruct();
  level.stryker_settings["ai"].target_engage_duration = 3.0;
  level.stryker_settings["ai"].target_engage_break_time = 3.0;
  level.stryker_settings["ai"].target_min_range = 300;
  level.stryker_settings["ai"].target_max_range = 3500;
  level.stryker_settings["ai"].target_min_range_veh = 0;
  level.stryker_settings["ai"].target_max_range_veh = 300;
  level.stryker_settings["ai"].burst_count_min = 3;
  level.stryker_settings["ai"].burst_count_max = 10;
  level.stryker_settings["ai"].burst_delay_min = 8.0;
  level.stryker_settings["ai"].burst_delay_max = 15.0;
  level.stryker_settings["ai"].fire_time = 0.1;
  level.stryker_settings["ai"].getVehicles = false;

  level.stryker_settings["manual"] = spawnStruct();
  level.stryker_settings["manual"].target_engage_duration = 4.0;
  level.stryker_settings["manual"].target_engage_break_time = 0.2;
  level.stryker_settings["manual"].target_min_range = 0;
  level.stryker_settings["manual"].target_max_range = 4500;
  level.stryker_settings["manual"].target_min_range_veh = 0;
  level.stryker_settings["manual"].target_max_range_veh = 200;
  level.stryker_settings["manual"].burst_count_min = 15;
  level.stryker_settings["manual"].burst_count_max = 25;
  level.stryker_settings["manual"].burst_delay_min = 0.1;
  level.stryker_settings["manual"].burst_delay_max = 0.4;
  level.stryker_settings["manual"].fire_time = 0.1;
  level.stryker_settings["manual"].getVehicles = true;
}

stryker_setmode_ai() {
  self.turretMode = "ai";
  self.targetSearchOrigin = undefined;

  if(getDvar("arcadia_debug_stryker") == "1")
    iprintln("^2stryker - " + self.turretMode + " mode");

  self thread stryker_turret_think();
}

stryker_setmode_manual(origin) {
  self endon("death");

  assert(isDefined(origin));

  self notify("stryker_setmode_manual");
  self endon("stryker_setmode_manual");

  self.turretMode = "manual";
  self.targetSearchOrigin = origin;

  self thread stryker_turret_think();

  if(getDvar("arcadia_debug_stryker") == "1")
    iprintln("^2stryker - " + self.turretMode + " mode");

  wait STRYKER_MANUAL_AI_DURATION;

  thread stryker_suppression_complete_dialog();
  thread stryker_laser_reminder_dialog();
  thread stryker_setmode_ai();
}

stryker_turret_think() {
  assert(isDefined(self.turretMode));
  assert(isDefined(level.stryker_settings[self.turretMode]));

  self notify("stryker_turret_think");
  self endon("stryker_turret_think");
  self endon("death");

  self thread stryker_scan_stop();

  for(;;) {
    target = self stryker_get_target();

    if(!isDefined(target)) {
      self thread stryker_scan_start();
      wait level.stryker_settings[self.turretMode].target_engage_break_time;
      self stryker_scan_stop();
      continue;
    }

    self stryker_shoot_target(target);
    wait level.stryker_settings[self.turretMode].target_engage_break_time;
  }
}

stryker_scan_start() {
  self endon("death");
  self endon("stop_scanning");

  assert(!isDefined(self.scanning));
  self.scanning = true;

  if(getDvar("arcadia_debug_stryker") == "1")
    iprintln("^2stryker - scan start");

  alternate = 0;

  for(;;) {
    forward = anglesToForward(self.angles) * 1000;

    if(alternate == 0) {
      alternate = 1;
      sideOffset = randomintrange(-1500, -200);
    } else {
      alternate = 0;
      sideOffset = randomintrange(200, 1500);
    }

    right = anglesToRight(self.angles) * sideOffset;

    aimPoint = self.origin + forward + right;
    aimPoint = (aimPoint[0], aimPoint[1], self.origin[2]);

    self SetTurretTargetVec(aimPoint);
    wait randomfloatrange(2.0, 5.0);
  }
}

stryker_scan_stop() {
  if(getDvar("arcadia_debug_stryker") == "1")
    iprintln("^2stryker - scan stop");

  self clearTurretTarget();
  self.scanning = undefined;
  self notify("stop_scanning");
}

stryker_get_target() {
  SEARCH_ORIGIN = self.origin;
  if(isDefined(self.targetSearchOrigin))
    SEARCH_ORIGIN = self.targetSearchOrigin;

  SEARCH_RADIUS_MIN = level.stryker_settings[self.turretMode].target_min_range;
  SEARCH_RADIUS_MAX = level.stryker_settings[self.turretMode].target_max_range;
  SEARCH_RADIUS_MIN_VEH = level.stryker_settings[self.turretMode].target_min_range_veh;
  SEARCH_RADIUS_MAX_VEH = level.stryker_settings[self.turretMode].target_max_range_veh;
  GET_VEHICLES = level.stryker_settings[self.turretMode].getVehicles;

  eTargets = [];

  enemyTeam = common_scripts\utility::get_enemy_team(self.script_team);
  possibleTargets = [];
  vehicleTargets = [];
  destructibleTargets = [];
  sentientTargets = [];

  prof_begin("stryker_ai");

  if(GET_VEHICLES) {
    assert(isDefined(level.vehicles[enemyTeam]));
    vehicleTargets = level.vehicles[enemyTeam];
    vehicleTargets = get_array_of_closest(SEARCH_ORIGIN, vehicleTargets, undefined, undefined, SEARCH_RADIUS_MAX_VEH, SEARCH_RADIUS_MIN_VEH);

    ents = getEntArray("destructible_vehicle", "targetname");
    foreach(ent in ents) {
      if(isDefined(ent.exploded))
        continue;
      destructibleTargets[destructibleTargets.size] = ent;
    }
    ents = undefined;
    destructibleTargets = get_array_of_closest(SEARCH_ORIGIN, destructibleTargets, undefined, undefined, SEARCH_RADIUS_MAX_VEH, SEARCH_RADIUS_MIN_VEH);
  }

  sentientTargets = getaiarray(enemyTeam);
  sentientTargets = get_array_of_closest(SEARCH_ORIGIN, sentientTargets, undefined, undefined, SEARCH_RADIUS_MAX, SEARCH_RADIUS_MIN);

  possibleTargets = array_combine(possibleTargets, vehicleTargets);
  possibleTargets = array_combine(possibleTargets, destructibleTargets);
  possibleTargets = array_combine(possibleTargets, sentientTargets);

  vehicleTargets = undefined;
  destructibleTargets = undefined;
  sentientTargets = undefined;

  foreach(target in possibleTargets) {
    if(isDefined(self.threatBiasGroup) && IsSentient(target)) {
      bias = getThreatBias(target getThreatBiasGroup(), self.threatBiasGroup);
      if(bias <= -1000000)
        continue;
    }

    if(isDefined(target.ignoreme) && target.ignoreme == true) {
      continue;
    }
    if(isAI(target)) {
      if(!sightTracePassed(self getTagOrigin("tag_flash"), target getEye(), false, self))
        continue;
    }

    prof_end("stryker_ai");
    return target;
  }

  prof_end("stryker_ai");
  return undefined;
}

stryker_get_target_offset(target) {
  if(isAi(target)) {
    eye = target getEye();
    zOffset = eye[2] - target.origin[2];
    return (0, 0, zOffset);
  }

  if(isDefined(target.vehicletype)) {
    if(target isHelicopter())
      return (0, 0, STRYKER_TARGET_OFFSET_HELICOPTER);
    return (0, 0, STRYKER_TARGET_OFFSET_VEHICLE);
  }

  if(isDefined(target.destuctableinfo))
    return (0, 0, STRYKER_TARGET_OFFSET_VEHICLE);

  return (0, 0, 0);
}

stryker_shoot_target(target) {
  self notify("stryker_shoot_target");
  self endon("stryker_shoot_target");

  if(!isDefined(target)) {
    return;
  }

  targetOffset = stryker_get_target_offset(target);

  if(getDvar("arcadia_debug_stryker") == "1") {
    iprintln("^2stryker - shooting a target");
    if(self.turretMode == "ai")
      thread draw_line_for_time(self.origin + (0, 0, 100), target.origin + targetOffset, 1, 1, 0, 2.0);
    else
      thread draw_line_for_time(self.origin + (0, 0, 100), target.origin + targetOffset, 1, 0, 0, 2.0);
  }

  self setTurretTargetEnt(target, targetOffset);
  if(self.lastTarget != target)
    self waittill_notify_or_timeout("turret_rotate_stopped", 1.0);
  self.lastTarget = target;

  startTime = getTime();
  while(isDefined(target)) {
    timeElapsed = getTime() - startTime;
    if(timeElapsed >= level.stryker_settings[self.turretMode].target_engage_duration * 1000) {
      return;
    }
    self stryker_fire_shots(target, targetOffset);
    wait randomfloatrange(level.stryker_settings[self.turretMode].burst_delay_min, level.stryker_settings[self.turretMode].burst_delay_max);
  }
}

stryker_fire_shots(target, targetOffset) {
  self notify("stryker_fire_shots");
  self endon("stryker_fire_shots");

  shots = randomintrange(level.stryker_settings[self.turretMode].burst_count_min, level.stryker_settings[self.turretMode].burst_count_max);
  for(i = 0; i < shots; i++) {
    if(isDefined(target) && isDefined(targetOffset))
      self fireWeapon("tag_flash", target, targetOffset, 0.0);
    else
      self fireWeapon("tag_flash", undefined, (0, 0, 0), 0.0);
    wait level.stryker_settings[self.turretMode].fire_time;
  }
}

stryker_suppression_complete_dialog() {
  dialog = [];
  dialog[dialog.size] = "arcadia_str_targdestroyed";
  dialog[dialog.size] = "arcadia_str_areasuppressed";
  dialog[dialog.size] = "arcadia_str_tasuppressed";

  if(flag("disable_stryker_dialog")) {
    return;
  }
  thread radio_dialogue(dialog[randomint(dialog.size)]);
}

stryker_laser_reminder_dialog() {
  level endon("golf_course_mansion");
  level endon("laser_coordinates_received");

  level.stryker notify("stryker_laser_reminder_dialog");
  level.stryker endon("stryker_laser_reminder_dialog");
  level.stryker endon("death");

  for(;;) {
    wait randomintrange(30, 60);

    if(!isalive(level.stryker)) {
      return;
    }
    if(flag("disable_stryker_dialog")) {
      continue;
    }
    if(flag_exist("no_living_enemies") && flag("no_living_enemies")) {
      continue;
    }

    thread laser_hint_print();

    rand = randomint(5);
    switch (rand) {
      case 0:

        level.foley thread anim_single_queue(level.foley, "arcadia_fly_usedesignator");
        break;
      case 1:

        level.foley thread anim_single_queue(level.foley, "arcadia_fly_painttargets");
        break;
      case 2:

        thread radio_dialogue("arcadia_str_lasetarget");
        break;
      case 3:

        thread radio_dialogue("arcadia_str_standingby");
        break;
      case 4:

        thread radio_dialogue("arcadia_str_painttarget");
        break;
    }
  }
}

stryker_death_wait() {
  level endon("golf_course_mansion");

  self waittill("death");

  wait 1.5;

  level.foley thread anim_single_queue(level.foley, "arcadia_fly_lostbadgerone");
}