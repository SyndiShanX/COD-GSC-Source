/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_vl_firingrange.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\agents\_agent_utility;
#include maps\mp\agents\_scriptedAgents;
#include maps\mp\_vl_camera;
#include maps\mp\_vl_base;
#include maps\mp\_audio;

init_firingrange() {
  firingrange = spawnStruct();

  firingrange.fr_start = getent("firingrange_start", "targetname");
  firingrange.AllTargetsArray = firing_range_setup_targets();
  firingrange.AllEnvArray = firing_range_setup_env();
  firingrange.TransitionMeshes = [];
  firingrange.TransitionMeshesRev = [];
  firingrange.AllTriggerArray = firing_range_setup_triggers();
  firingrange.AllTargetMin = firing_range_setup_min_range();
  firingrange.AllTargetMax = firing_range_setup_max_range();
  firingrange.AllBoothDisplays = firing_range_setup_booth_displays();
  firingrange.AllTargetLogicArray = firing_range_setup_target_logic();
  firingrange.AllFloorPannels = firing_range_setup_floor_panels();
  firingrange.AllVFX_Struct = firing_range_setup_env_VFX();
  firingrange.All3dUiScreens = firing_range_setup_3dui_screens();
  firingrange.audio_buzzer_struct = getstruct("audio_buzzer_org", "targetname");
  firingrange.SoundEnts = [];
  firingrange.last_target = undefined;
  firingrange.target_move_dist = 32;
  firingrange.target_units_per_second = 256;
  firingrange.PressedUp = false;
  firingrange.PressedDown = false;
  firingrange.RoundNumber = undefined;
  firingrange.MinPoint = undefined;
  firingrange.MinPointModPos = undefined;
  firingrange.MaxPoint = undefined;
  firingrange.ButtonTimerTotal = 0.55;
  firingrange.ButtonTimer = 0;
  firingrange.GraceDisance = 24;
  firingrange.DamageDone = 0;
  firingrange.RangeInMeters = 0;
  firingrange.ShotsFired = 0;
  firingrange.ShotsHit = 0;
  firingrange.Percent = 0;
  firingrange.ShouldUpDateLuaDisplay = 0;
  firingrange.Round_target_unit_per_second = 176;
  firingrange.Time = 0;
  firingrange.GroupDevider = 5;
  firingrange.RoundActive = false;
  firingrange.IsShuttingDown = false;
  firingrange.VFXTargetSpawn = LoadFX("vfx/props/holo_target_red_spawn_in");
  firingrange.VFXTargetSpawnOut = LoadFX("vfx/props/holo_target_red_spawn_out");
  firingrange.VFXHoloEdge = LoadFX("vfx/beam/firing_range_edge_glow");

  array_thread(firingrange.AllTriggerArray, ::trigger_setup);

  level.target_center_off = (1.3, 0, 25);
  level.target_radius = 12;
  level.hit_off = 18;

  level.firingrange = firingrange;
}

firing_range_setup_floor_panels() {
  panels = getEntArray("holo_emitter_floor", "targetname");
  foreach(panel in panels) {
    panel.og_position = panel.origin;
    panel.up_position = panel.origin + (0, 0, 4);
  }
  return panels;
}

firing_range_setup_3dui_screens() {
  ui3d_screens = getEntArray("display_3dui_mesh", "targetname");
  foreach(mesh in ui3d_screens) {
    mesh hide();
  }
  return ui3d_screens;
}

firing_range_setup_min_range() {
  TargetTrackMinArray = getstructarray("target_track_min", "targetname");
  return TargetTrackMinArray;
}

firing_range_setup_max_range() {
  TargetTrackMaxArray = getstructarray("target_track_max", "targetname");
  return TargetTrackMaxArray;
}

firing_range_setup_booth_displays() {
  BoothDisplays01 = getstructarray("booth_display_01", "targetname");
  BoothDisplays02 = getstructarray("booth_display_02", "targetname");
  BoothDisplays03 = getstructarray("booth_display_03", "targetname");
  BoothDisplays04 = getstructarray("booth_display_04", "targetname");
  BoothDisplays05 = getstructarray("booth_display_05", "targetname");
  BoothDisplays06 = getstructarray("booth_display_06", "targetname");

  BoothDisplaysArray = [BoothDisplays01, BoothDisplays02, BoothDisplays03, BoothDisplays04, BoothDisplays05, BoothDisplays06];

  return BoothDisplaysArray;
}

trigger_setup() {
  trigger = self;
  trigger thread common_scripts\_dynamic_world::triggerTouchThink(::player_enter_round_trigger, ::player_leave_round_trigger);
}

player_enter_round_trigger(trigger) {
  level endon("shutdown_hologram");

  while(level.firingrange.IsShuttingDown == true) {
    wait(0.1);
  }

  player = self;
  if(!isDefined(trigger.script_index)) {
    return;
  }

  RoundNumber = int(trigger.script_index);
  level.firingrange.RoundNumber = RoundNumber;

  if(!isDefined(level.firingrange.AllEnvArray[RoundNumber])) {
    return;
  }

  player thread StartRound(RoundNumber);
}

player_leave_round_trigger(trigger) {
  player = self;
  if(!isDefined(trigger.script_index)) {
    return;
  }

  RoundNumber = int(trigger.script_index);
  level.firingrange.RoundNumber = RoundNumber;

  if(!isDefined(level.firingrange.AllEnvArray[RoundNumber])) {
    return;
  }

  thread ShutDownRound(RoundNumber, player);
}

snd_play_linked_firingrange(alias_name, ent, _cleanup_time, _fadeout_time) {
  snd_ent = spawn("script_origin", ent.origin);
  snd_ent LinkToSynchronizedParent(ent);
  snd_ent thread sndx_play_linked_internal(alias_name, ent, _cleanup_time, _fadeout_time);
  if(!isDefined(level.firingrange.SoundEnts)) {
    level.firingrange.SoundEnts = [];
  } else {
    level.firingrange.SoundEnts = add_to_array(level.firingrange.SoundEnts, snd_ent);
  }

  return snd_ent;
}

TargetSpreadShooting(RoundNumber) {
  level endon("shutdown_hologram");
  player = self;

  target = level.firingrange.AllTargetsArray[RoundNumber][0][0];
  target.alive = true;
  thread snd_play_in_space("mp_shooting_range_panels_bell", level.firingrange.audio_buzzer_struct.origin);
  target SpawnTarget();

  target show();
  target solid();
  target setCanDamage(true);

  target.health = 9999;
  target.maxhealth = 9999;

  target ThermalDrawEnable();

  foreach(point in level.firingrange.AllTargetMin) {
    if(point.script_index == level.firingrange.RoundNumber) {
      level.firingrange.MinPoint = point;
      break;
    }
  }
  foreach(point in level.firingrange.AllTargetMax) {
    if(point.script_index == level.firingrange.RoundNumber) {
      level.firingrange.MaxPoint = point;
      break;
    }
  }
  if(!isDefined(level.firingrange.MinPoint) || !isDefined(level.firingrange.MaxPoint)) {
    thread ShutDownRound(RoundNumber, player);
    return;
  }

  level.firingrange.MinPointModPos = level.firingrange.MinPoint.origin + (anglesToForward(level.firingrange.MinPoint.angles) * -64);

  target thread MonitorDamage(player);
  target thread MonitorDistance(player, target, level.firingrange.MinPoint);
  thread MonitorShotsFired(player);
  thread MonitorHitPercent(player);
  thread DisplayBoothHolo(player, RoundNumber);

  player thread NotifyTracker(target);
}
MonitorDistance(player, target1, target2) {
  player endon("disconnect");
  level endon("shutdown_hologram");
  self endon("death");

  Meter2Inch = 0.0254;

  while(true) {
    if(!isDefined(target1) || !isDefined(target2)) {
      level.firingrange.RangeInMeters = 0;
      player SetClientOmnvar("ui_vlobby_round_distance", level.firingrange.RangeInMeters);
    } else {
      Distance2Min = Distance2D(target1.origin, target2.origin);
      meters = int(roundDecimalPlaces(Meter2Inch * Distance2Min, 0));
      if(meters != level.firingrange.RangeInMeters) {
        if(meters > 100) {
          meters = 100;
        } else if(meters < 0) {
          meters = 0;
        }
        level.firingrange.RangeInMeters = meters;

        player SetClientOmnvar("ui_vlobby_round_distance", level.firingrange.RangeInMeters);
      }
    }
    wait(0.05);
  }
}

NotifyTracker(target) {
  self endon("disconnect");
  level endon("shutdown_hologram");

  self notifyOnPlayerCommand("toggled_up_pressed", "+actionslot 1");
  self notifyOnPlayerCommand("toggled_up_released", "-actionslot 1");

  self notifyOnPlayerCommand("toggled_down_pressed", "+actionslot 2");
  self notifyOnPlayerCommand("toggled_down_released", "-actionslot 2");

  self thread MonitorUpPressed(target);
  self thread MonitorUpReleased(target);

  self thread MonitorDownPressed(target);
  self thread MonitorDownReleased(target);

  thread MoveStopper(target, self);
}

MonitorUpPressed(target) {
  self endon("disconnect");
  level endon("shutdown_hologram");

  while(true) {
    self waittill("toggled_up_pressed");

    level.firingrange.ButtonTimer = level.firingrange.ButtonTimerTotal;

    if(level.firingrange.PressedUp == false) {
      level.firingrange.PressedUp = true;
      level.firingrange.PressedDown = false;

      thread MoveLogic(level.firingrange.MaxPoint.origin, target, self);
    }
  }
}

MonitorUpReleased(target) {
  self endon("disconnect");
  level endon("shutdown_hologram");

  while(true) {
    self waittill("toggled_up_released");

    GoalDist = Distance2D(level.firingrange.MaxPoint.origin, target.origin);
    if(GoalDist <= 1) {
      target moveto(target.origin, 0.05);
    } else {
      GoalPos = target.origin + (anglesToForward(level.firingrange.AllTargetMax[0].angles) * level.firingrange.GraceDisance * -1);
      GoalDist = Distance2D(GoalPos, target.origin);
      MoveTime = GoalDist / level.firingrange.target_units_per_second;
      if(MoveTime < 0.05) {
        MoveTime = 0.05;
      }
      level.firingrange.ButtonTimer = MoveTime + 0.05;
      thread MoveLogic(GoalPos, target, self);
    }

    target waittill("movedone");
    level.firingrange.PressedUp = false;
  }
}

MonitorDownPressed(target) {
  self endon("disconnect");
  level endon("shutdown_hologram");

  while(true) {
    self waittill("toggled_down_pressed");

    level.firingrange.ButtonTimer = level.firingrange.ButtonTimerTotal;

    if(level.firingrange.PressedDown == false) {
      level.firingrange.PressedDown = true;
      level.firingrange.PressedUp = false;

      thread MoveLogic(level.firingrange.MinPointModPos, target, self);
    }
  }
}

MonitorDownReleased(target) {
  self endon("disconnect");
  level endon("shutdown_hologram");

  while(true) {
    self waittill("toggled_down_released");

    GoalDist = Distance2D(level.firingrange.MinPointModPos, target.origin);
    if(GoalDist <= 1) {
      target moveto(target.origin, 0.05);
    } else {
      GoalPos = target.origin + (anglesToForward(level.firingrange.AllTargetMax[0].angles) * (level.firingrange.GraceDisance));
      GoalDist = Distance2D(GoalPos, target.origin);
      MoveTime = GoalDist / level.firingrange.target_units_per_second;
      if(MoveTime < 0.05) {
        MoveTime = 0.05;
      }
      level.firingrange.ButtonTimer = MoveTime + 0.05;
      thread MoveLogic(GoalPos, target, self);
    }
    target waittill("movedone");
    level.firingrange.PressedDown = false;
  }
}

MoveLogic(GoalPos, target, player) {
  GoalDist = Distance2D(GoalPos, target.origin);

  if(GoalDist <= 1) {
    target notify("movedone");
    return;
  } else {
    MoveTime = GoalDist / level.firingrange.target_units_per_second;
    if(MoveTime < 0.05) {
      MoveTime = 0.05;
    }

    target moveto(GoalPos, MoveTime);
  }
}

MoveStopper(target, player) {
  player endon("disconnect");

  level endon("shutdown_hologram");

  while(true) {
    wait(0.05);
    {
      if(level.firingrange.PressedDown == true || level.firingrange.PressedUp == true) {
        if(level.firingrange.ButtonTimer > 0) {
          level.firingrange.ButtonTimer = level.firingrange.ButtonTimer - 0.05;
        } else {
          target moveto(target.origin, 0.05);
          level.firingrange.PressedDown = false;
          level.firingrange.PressedUp = false;
        }
      }
    }
  }
}

MonitorDamage(player) {
  player endon("disconnect");
  level endon("shutdown_hologram");

  damage = undefined;
  attacker = player;
  direction_vec = undefined;
  point = undefined;
  type = undefined;
  modelName = undefined;
  tagName = undefined;
  partName = undefined;
  dflags = undefined;

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelName, tagName, partName, dflags, weapon_name);

    if(level.firingrange.RoundNumber == 7) {
      self.health = self.maxhealth;
    }

    tag_body = self GetTagOrigin("tag_chest");
    thread snd_play_in_space("mp_shooting_range_red_hit", tag_body);

    modifier = GetModifier(weapon_name, partName, player);
    damage = roundDecimalPlaces(float(damage) * modifier, 0);
    damage = int(damage);
    if(damage > 999) {
      damage = 999;
    }
    if(damage < 0) {
      damage = 0;
    }
    level.firingrange.DamageDone = damage;
    currentShotHits = level.firingrange.ShotsHit + 1;
    if(currentShotHits > 9999) {
      level.firingrange.ShotsHit = 0;
    } else if(currentShotHits < 0) {
      level.firingrange.ShotsHit = 0;
    } else {
      level.firingrange.ShotsHit = currentShotHits;
    }
    level.firingrange.ShouldUpDateLuaDisplay = true;
  }
}

GetModifier(weapon, partName, player) {
  hit_loc = "none";
  modifier = 1;

  WeapStringArray = StrTok(weapon, "_");
  WeaponString = WeapStringArray[0] + "_" + WeapStringArray[1];

  if(weapon != "specialty_null" && weapon != "none" && weapon != "iw5_combatknife_mp") {
    if(maps\mp\gametypes\_class::isValidPrimary(WeaponString) || maps\mp\gametypes\_class::isValidSecondary(WeaponString, false)) {
      if(partName == "tag_head") {
        hit_loc = "head";
      } else if(partName == "tag_chest") {
        hit_loc = "torso_upper";
      } else if(partName == "tag_arms") {
        hit_loc = "right_arm_upper";
      } else if(partName == "tag_legs") {
        hit_loc = "torso_lower";
      } else {
        hit_loc = "none";
      }

      modifier = player GetWeaponDamageLocationMultiplier(WeaponString + "_mp", hit_loc);
      return modifier;
    } else {
      return modifier;
    }
  } else {
    return modifier;
  }
}

MonitorShotsFired(player) {
  player endon("disconnect");
  level endon("shutdown_hologram");

  while(true) {
    player waittill_any("weapon_fired", "grenade_fire");

    ShotsFired = level.firingrange.ShotsFired + 1;
    if(ShotsFired > 9999) {
      level.firingrange.ShotsFired = 0;
      level.firingrange.ShotsHit = 0;
      level.firingrange.Percent = 0;

      player SetClientOmnvar("ui_vlobby_round_hits", level.firingrange.ShotsHit);
      player SetClientOmnvar("ui_vlobby_round_fired", level.firingrange.ShotsFired);
      player SetClientOmnvar("ui_vlobby_round_accuracy", level.firingrange.Percent);
    } else if(ShotsFired < 0) {
      level.firingrange.ShotsFired = 0;
      level.firingrange.ShotsHit = 0;
      level.firingrange.Percent = 0;

      player SetClientOmnvar("ui_vlobby_round_hits", level.firingrange.ShotsHit);
      player SetClientOmnvar("ui_vlobby_round_fired", level.firingrange.ShotsFired);
      player SetClientOmnvar("ui_vlobby_round_accuracy", level.firingrange.Percent);
    } else {
      level.firingrange.ShouldUpDateLuaDisplay = true;
      level.firingrange.ShotsFired = ShotsFired;
    }
  }
}

MonitorHitPercent(player) {
  player endon("disconnect");
  level endon("shutdown_hologram");

  while(true) {
    if(level.firingrange.ShotsFired > 0) {
      percent = (level.firingrange.ShotsHit / level.firingrange.ShotsFired) * 100;
      percent = roundDecimalPlaces(percent, 0);

      if(percent != level.firingrange.Percent) {
        if(percent > 999) {
          percent = 999;
        } else if(percent < 0) {
          percent = 0;
        }
        level.firingrange.Percent = int(percent);
        level.firingrange.ShouldUpDateLuaDisplay = true;
      }
    }
    wait(0.05);
  }
}

DisplayBoothHolo(player, RoundNumber) {
  player endon("disconnect");
  level endon("shutdown_hologram");

  display = FindDisplay(level.firingrange.All3dUiScreens, RoundNumber);
  if(isDefined(display)) {
    display show();
  }

  while(true) {
    if(level.firingrange.ShouldUpDateLuaDisplay == true) {
      player SetClientOmnvar("ui_vlobby_round_damage", level.firingrange.DamageDone);
      player SetClientOmnvar("ui_vlobby_round_hits", level.firingrange.ShotsHit);
      player SetClientOmnvar("ui_vlobby_round_fired", level.firingrange.ShotsFired);
      player SetClientOmnvar("ui_vlobby_round_accuracy", level.firingrange.Percent);

      level.firingrange.ShouldUpDateLuaDisplay = false;
    }

    wait(0.2);
  }
}

FindDisplay(array, RoundNumber) {
  foreach(display in array) {
    if(isDefined(display.script_index) && display.script_index == RoundNumber) {
      return display;
    }
  }
}

StartRound(RoundNumber) {
  level endon("shutdown_hologram");

  level notify("start_round");

  level.firingrange.DamageDone = 0;
  level.firingrange.RangeInMeters = 0;
  level.firingrange.Time = 0;
  level.firingrange.RoundActive = true;
  level.firingrange.ShouldUpDateLuaDisplay = true;

  self SetClientOmnvar("ui_vlobby_round_distance", level.firingrange.RangeInMeters);
  self SetClientOmnvar("ui_vlobby_round_damage", level.firingrange.DamageDone);
  self SetClientOmnvar("ui_vlobby_round_hits", level.firingrange.ShotsHit);
  self SetClientOmnvar("ui_vlobby_round_fired", level.firingrange.ShotsFired);
  self SetClientOmnvar("ui_vlobby_round_accuracy", level.firingrange.Percent);

  foreach(wave in level.firingrange.AllTargetsArray[RoundNumber]) {
    foreach(target in wave) {
      target.origin = target.original_position;
      target.angles = target.original_orientation;
    }
  }

  foreach(panel in level.firingrange.AllFloorPannels) {
    panel thread MoveFloorPanelUp();
  }
  thread snd_play_linked_firingrange("mp_shooting_range_panels_up", self);

  thread lerp_spot_intensity("lt_shootingrange_bounce", .25, 0.01);
  if(level.nextgen) {
    thread lerp_spot_intensity_array("lt_shootingrange", .25, 0.01);
    thread lerp_spot_intensity("lt_hologram_blue", .25, 3000);
  } else {
    thread lerp_spot_intensity("lt_hologram_blue", .25, 60000);
  }

  wait(0.5);
  i = 0;
  foreach(struct in level.firingrange.AllVFX_Struct[RoundNumber]) {
    if(level.nextgen) {
      thread Particlespawn(level.firingrange.VFXHoloEdge, struct.origin, struct.angles, undefined, true);
    } else {
      if(i % 2 == 0) {
        thread Particlespawn(level.firingrange.VFXHoloEdge, struct.origin, struct.angles, undefined, true);
      }
    }
    i++;
  }

  if(level.nextgen) {
    ShowTransition(RoundNumber);
    wait(0.1);
    FlickerTransMeshes(level.firingrange.TransitionMeshes);
    wait(0.1);
    FlickerTransMeshes(level.firingrange.TransitionMeshes);
    wait(0.1);
    ShowTransitionRev(level.firingrange.TransitionMeshes);
    HideTransitionMeshes();
    wait(0.4);

    ShowRoundMeshMesh(RoundNumber);
    wait(0.1);

    DeleteTransRevMeshes();
  } else {
    SavedNames = ShowTransition_CG(RoundNumber);
    wait(0.1);
    FlickerTransMeshes(level.firingrange.AllEnvArray[RoundNumber]);
    FlickerTransMeshes(level.firingrange.AllEnvArray[RoundNumber]);
    wait(0.1);
    FlickerTransMeshes(level.firingrange.AllEnvArray[RoundNumber]);
    wait(0.1);

    HideTransitionMeshes_CG(RoundNumber, SavedNames);
    wait(0.1);
    ShowRoundMeshMesh(RoundNumber);
  }
  thread snd_play_linked_firingrange("mp_shooting_range_appear", self);

  if(RoundNumber == 7) {
    self SetClientOmnvar("ui_vlobby_round_state", 3);
    self thread TargetSpreadShooting(RoundNumber);
  } else {
    self SetClientOmnvar("ui_vlobby_round_state", 1);
    self thread activate_targets(RoundNumber);
  }
}
ShowRoundMeshMesh(RoundNumber) {
  level endon("shutdown_hologram");

  GroupSize = roundDecimalPlaces(level.firingrange.AllEnvArray[RoundNumber].size / level.firingrange.GroupDevider, 0, "up");
  ShowCount = 0;
  foreach(part in level.firingrange.AllEnvArray[RoundNumber]) {
    part Show();
    part Solid();
  }
}

ShowTransitionRev(group) {
  level endon("shutdown_hologram");

  level.firingrange.TransitionMeshesRev = [];

  foreach(part in group) {
    if(isDefined(part) && !IsRemovedEntity(part) && isDefined(part.classname) && part.classname == "script_model") {
      if(isDefined(part.model) && IsSubStr(part.model, "_trans")) {
        modelname_rev = part.model + "_rev";
        scanline_model = spawn("script_model", part.origin);

        level.firingrange.TransitionMeshesRev[level.firingrange.TransitionMeshesRev.size] = scanline_model;
        if(isDefined(part.angles)) {
          scanline_model.angles = part.angles;
        } else {
          scanline_model.angles = (0, 0, 0);
        }
        scanline_model setModel(modelname_rev);
        scanline_model NotSolid();
      }
    }
  }
}
ShowTransition(RoundNumber) {
  level endon("shutdown_hologram");

  level.firingrange.TransitionMeshes = [];

  foreach(part in level.firingrange.AllEnvArray[RoundNumber]) {
    if(isDefined(part.classname) && part.classname == "script_model") {
      if(isDefined(part.model) && IsSubStr(part.model, "rec_holo_range")) {
        modelname_trans = part.model + "_trans";

        trans_model = spawn("script_model", part.origin);

        level.firingrange.TransitionMeshes[level.firingrange.TransitionMeshes.size] = trans_model;

        if(isDefined(part.angles)) {
          trans_model.angles = part.angles;
        } else {
          trans_model.angles = (0, 0, 0);
        }
        trans_model setModel(modelname_trans);

        trans_model NotSolid();
      }
    }
  }
}

FlickerTransMeshes(group) {
  level endon("shutdown_hologram");

  if(isDefined(group) && IsArray(group)) {
    HideModels(group);
    wait(0.05);
    ShowModels(group);
    wait(0.05);
  }
}

ShowModels(group) {
  level endon("shutdown_hologram");

  foreach(thing in group) {
    if(isDefined(thing) && !IsRemovedEntity(thing)) {
      thing show();
      thing NotSolid();
    }
  }
}

HideModels(group) {
  level endon("shutdown_hologram");
  foreach(thing in group) {
    if(isDefined(thing) && !IsRemovedEntity(thing)) {
      thing hide();
      thing NotSolid();
    }
  }
}

HideTransitionMeshes() {
  if(IsArray(level.firingrange.TransitionMeshes)) {
    level.firingrange.TransitionMeshes = array_remove_duplicates(level.firingrange.TransitionMeshes);
    foreach(mesh in level.firingrange.TransitionMeshes) {
      if(isDefined(mesh) && !IsRemovedEntity(mesh)) {
        mesh hide();
        mesh notsolid();
      }
    }
  }
}

DeleteTransRevMeshes() {
  if(IsArray(level.firingrange.TransitionMeshesRev)) {
    level.firingrange.TransitionMeshesRev = array_remove_duplicates(level.firingrange.TransitionMeshesRev);
    foreach(mesh in level.firingrange.TransitionMeshesRev) {
      if(isDefined(mesh) && !IsRemovedEntity(mesh)) {
        mesh delete();
      }
    }
  }
  level.firingrange.TransitionMeshesRev = [];
}

RemoveTransitionMeshes() {
  if(IsArray(level.firingrange.TransitionMeshes)) {
    CurrentTransitionMeshes = array_remove_duplicates(level.firingrange.TransitionMeshes);

    FlickerTransMeshes(CurrentTransitionMeshes);
    FlickerTransMeshes(CurrentTransitionMeshes);
    wait(0.1);
    FlickerTransMeshes(CurrentTransitionMeshes);
    wait(0.1);
    FlickerTransMeshes(CurrentTransitionMeshes);

    foreach(mesh in CurrentTransitionMeshes) {
      if(isDefined(mesh) && !IsRemovedEntity(mesh)) {
        mesh delete();
      }
    }
  }
}

RemoveRevnMeshes() {
  if(IsArray(level.firingrange.ScanlineMeshes)) {
    level.firingrange.ScanlineMeshes = array_remove_duplicates(level.firingrange.ScanlineMeshes);
    foreach(mesh in level.firingrange.ScanlineMeshes) {
      if(isDefined(mesh) && !IsRemovedEntity(mesh)) {
        mesh delete();
      }
    }
  }
}

MoveFloorPanelUp() {
  level endon("shutdown_hologram");

  delay_time = RandomFloatRange(0.0, 1);
  wait(delay_time);
  self setModel("rec_holo_emitter_floor_on");
  self MoveTo(self.up_position, 0.25, 0.1, 0.1);
}

MoveFloorPanelDown() {
  level endon("start_round");

  self setModel("rec_holo_emitter_floor_off");

  delay_time = RandomFloatRange(0.0, 1);
  wait(delay_time);
  self MoveTo(self.og_position, 0.25, 0.1, 0.1);
}

ShutDownRound(RoundNumber, player) {
  level notify("shutdown_hologram");

  level.firingrange.IsShuttingDown = true;

  player SetClientOmnvar("ui_vlobby_round_state", 0);
  player SetClientOmnvar("ui_vlobby_round_timer", 0);
  player SetClientOmnvar("ui_vlobby_round_damage", 0);
  player SetClientOmnvar("ui_vlobby_round_distance", 0);
  player SetClientOmnvar("ui_vlobby_round_hits", 0);
  player SetClientOmnvar("ui_vlobby_round_fired", 0);
  player SetClientOmnvar("ui_vlobby_round_accuracy", 0);

  player thread GrenadeCleanup(true);

  thread RemoveTransitionMeshes();
  thread DeleteTransRevMeshes();
  thread snd_play_linked_firingrange("mp_shooting_range_disappear", player);

  foreach(panel in level.firingrange.AllFloorPannels) {
    panel thread MoveFloorPanelDown();
  }
  thread snd_play_linked_firingrange("mp_shooting_range_panels_up", player);

  foreach(part in level.firingrange.AllEnvArray[RoundNumber]) {
    part hide();
    part NotSolid();
  }

  if(level.nextgen) {
    thread lerp_spot_intensity_array("lt_shootingrange", .25, 6000);
  }
  thread lerp_spot_intensity("lt_shootingrange_bounce", .25, 3000);
  thread lerp_spot_intensity("lt_hologram_blue", .25, 0.01);

  foreach(wave in level.firingrange.AllTargetsArray[RoundNumber]) {
    foreach(target in wave) {
      if(target.alive == true) {
        ParticleSpawnOrigin = target.origin;
        ParticleSpawnAngles = target.angles;
        thread Particlespawn(level.firingrange.VFXTargetSpawnOut, ParticleSpawnOrigin, ParticleSpawnAngles, 3);
      }

      target DontInterpolate();
      target.aimassist_target disableAimAssist();

      target.origin = target.original_position;
      target.angles = target.original_orientation;

      target.aimassist_target hide();
      target.aimassist_target NotSolid();
      target hide();
      target NotSolid();
      target ThermalDrawDisable();
      target.alive = false;
    }
  }

  foreach(display in level.firingrange.All3dUiScreens) {
    display hide();
  }

  level.firingrange.MinPoint = undefined;
  level.firingrange.MaxPoint = undefined;
  level.firingrange.MinPointModPos = undefined;
  level.firingrange.PressedDown = false;
  level.firingrange.PressedUp = false;
  level.firingrange.DamageDone = 0;
  level.firingrange.RangeInMeters = 0;
  level.firingrange.ShotsFired = 0;
  level.firingrange.ShotsHit = 0;
  level.firingrange.Percent = 0;
  level.firingrange.RoundActive = false;
  level.firingrange.ShouldUpDateLuaDisplay = true;

  player SetClientOmnvar("ui_vlobby_round_distance", level.firingrange.RangeInMeters);
  player SetClientOmnvar("ui_vlobby_round_damage", level.firingrange.DamageDone);
  player SetClientOmnvar("ui_vlobby_round_hits", level.firingrange.ShotsHit);
  player SetClientOmnvar("ui_vlobby_round_fired", level.firingrange.ShotsFired);
  player SetClientOmnvar("ui_vlobby_round_accuracy", level.firingrange.Percent);

  level.firingrange.IsShuttingDown = false;
}

SpawnTarget() {
  level endon("shutdown_hologram");

  ParticleSpawnOrigin = self.origin;
  ParticleSpawnAngles = self.angles;
  thread Particlespawn(level.firingrange.VFXTargetSpawn, ParticleSpawnOrigin, ParticleSpawnAngles, 3);
  thread snd_play_linked_firingrange("mp_shooting_range_red_appear", self);

  wait(0.05);

  self Show();
  self Solid();
  self ThermalDrawEnable();
}

ScaleSoundsOnExit() {
  level notify("ScaleSoundsOnExit");
  level endon("ScaleSoundsOnExit");

  if(isDefined(level.in_firingrange)) {
    while(true) {
      wait(0.05);
      if(level.in_firingrange == 1 || GetDvarInt("virtualLobbyInFiringRange", 0) == 1) {
        continue;
      } else {
        level.firingrange.SoundEnts = array_remove_duplicates(level.firingrange.SoundEnts);
        foreach(sound in level.firingrange.SoundEnts) {
          sound ScaleVolume(0, 0.5);
        }
      }
    }
  }
}

enter_firingrange(player) {
  level.in_firingrange = true;
  print("FIRINGRANGE: Entering firing range with class lobby" + (player.currentSelectedClass + 1));

  thread wait_start_firingrange(0.4, player);
}

wait_start_firingrange(seconds, player) {
  player endon("enter_lobby");

  wait(seconds);

  player SetClientOmnvar("ui_vlobby_round_state", 0);
  player SetClientOmnvar("ui_vlobby_round_timer", 0);
  player SetClientOmnvar("ui_vlobby_round_damage", 0);
  player SetClientOmnvar("ui_vlobby_round_distance", 0);
  player SetClientOmnvar("ui_vlobby_round_hits", 0);
  player SetClientOmnvar("ui_vlobby_round_fired", 0);
  player SetClientOmnvar("ui_vlobby_round_accuracy", 0);

  player unlink();
  player CameraUnlink();
  ground_origin = GetGroundPosition(level.firingrange.fr_start.origin, 20, 512, 120);
  player DontInterpolate();
  player setOrigin(ground_origin);
  player setPlayerAngles(level.firingrange.fr_start.angles);
  player SetClientDVar("cg_fovscale", "1.0");

  level.firingrange.IsShuttingDown = false;
  print("FIRINGRANGE: Entering firing range2 with class lobby" + (player.currentSelectedClass + 1));
  virtual_lobby_set_class(0, "lobby" + (player.currentSelectedClass + 1), true, true);

  player ChargeBattery(player.loadoutoffhand);
  player ChargeBattery(player.loadoutequipment);

  updateSessionState("playing");

  player SetClientTriggerVisionSet("mp_virtual_lobby_fr", 0);
  player LightSetForPlayer("mp_vl_firingrange");

  player thread enable_player_controls();

  level.firingrange.SoundEnts = [];
  player thread ScaleSoundsOnExit();

  if(!player _hasPerk("specialty_wildcard_dualtacticals") && maps\mp\gametypes\_class::isValidEquipment(player.loadoutequipment, false) && !IsBadEquipment(player.loadoutequipment)) {
    player thread monitor_grenade_count(player.loadoutequipment, false);
  }

  if(player _hasPerk("specialty_wildcard_duallethals") && maps\mp\gametypes\_class::isValidEquipment(player.loadoutoffhand, false) && !IsBadEquipment(player.loadoutoffhand)) {
    player thread monitor_grenade_count(player.loadoutoffhand, true);
  }

  if(player.primaryWeapon != "specialty_null" && player.primaryWeapon != "none" && player.primaryWeapon != "iw5_combatknife_mp" && !IsSubStr(player.primaryWeapon, "em1") && !IsSubStr(player.primaryWeapon, "epm3") && !IsSubStr(player.primaryWeapon, "dlcgun1_mp") && !IsSubStr(player.primaryWeapon, "dlcgun1loot")) {
    player thread monitor_weapon_ammo_count(player.primaryWeapon);
    if(IsSubStr(player.primaryWeapon, "_gl")) {
      player thread monitor_weapon_ammo_count("alt_" + player.primaryWeapon);
    }
  }
  if(player.secondaryWeapon != "specialty_null" && player.secondaryWeapon != "none" && player.secondaryWeapon != "iw5_combatknife_mp" && !IsSubStr(player.secondaryWeapon, "em1") && !IsSubStr(player.secondaryWeapon, "epm3") && !IsSubStr(player.primaryWeapon, "dlcgun1_mp") && !IsSubStr(player.primaryWeapon, "dlcgun1loot")) {
    player thread monitor_weapon_ammo_count(player.secondaryWeapon);
    if(IsSubStr(player.secondaryWeapon, "_gl")) {
      player thread monitor_weapon_ammo_count("alt_" + player.secondaryWeapon);
    }
  }
}

ChargeBattery(offhand) {
  ShortOffHand = maps\mp\_utility::strip_suffix(offhand, "_lefthand");
  if(ShortOffHand != "none" && ShortOffHand != "specialty_null" && maps\mp\gametypes\_class::isValidOffhand(ShortOffHand, false)) {
    self BatteryFullRecharge(ShortOffHand);
    self BatterySetDischargeScale(ShortOffHand, 1);
  }
}

IsBadEquipment(equipment) {
  switch (equipment) {
    case "none":
    case "specialty_null":
    case "exoknife_mp":
    case "exoknife_mp_lefthand":

      return true;
    default:
      return false;
  }
}

GivePlayerConrolDelayed() {
  self endon("enter_lobby");

  wait(2);

  val = GetDvarInt("virtualLobbyInFiringRange", 0);
  if((val == 1) && level.in_firingrange == true) {
    self AllowFire(true);
  }
}

activate_targets(RoundNumber) {
  level endon("shutdown_hologram");

  player = self;
  level.firingrange.last_target = undefined;

  thread MonitorTime(player);
  thread MonitorShotsFired(player);
  thread MonitorHitPercent(player);

  foreach(wave in level.firingrange.AllTargetsArray[RoundNumber]) {
    foreach(enemy in wave) {
      enemy thread MonitorDamage(player);
    }
  }
  thread DisplayBoothHolo(player, RoundNumber);

  NumWaves = level.firingrange.AllTargetsArray[RoundNumber].size;
  WaveGroups = level.firingrange.AllTargetsArray[RoundNumber];

  for(i = 0; i < NumWaves; i++) {
    thread StartWave(WaveGroups[i], player);

    level waittill("wave_done");
    wait(0.05);
  }

  level notify("round_done");
  thread snd_play_in_space("mp_shooting_range_panels_bell", level.firingrange.audio_buzzer_struct.origin);
  level.firingrange.RoundActive = false;

  player SetClientOmnvar("ui_vlobby_round_state", 2);
}

MonitorTime(player) {
  level endon("shutdown_hologram");
  level endon("round_done");

  StartTimePassed = getTimePassed();

  while(true) {
    CurrentTimePassed = getTimePassed();
    TimeMiliSeconds = CurrentTimePassed - StartTimePassed;
    Time = roundDecimalPlaces((TimeMiliSeconds / 1000), 1);

    if(Time > 9999.9) {
      level.firingrange.Time = 0;
      player SetClientOmnvar("ui_vlobby_round_timer", level.firingrange.Time);
      player SetClientOmnvar("ui_vlobby_round_state", 0);
      thread ShutDownRound(level.firingrange.RoundNumber, player);

      return;
    } else if(Time < 0) {
      level.firingrange.Time = 0;
      player SetClientOmnvar("ui_vlobby_round_timer", level.firingrange.Time);
      player SetClientOmnvar("ui_vlobby_round_state", 0);
      thread ShutDownRound(level.firingrange.RoundNumber, player);

      return;
    } else {
      level.firingrange.Time = Time;
      player SetClientOmnvar("ui_vlobby_round_timer", level.firingrange.Time);
    }

    wait(0.05);
  }
}

StartWave(WaveGroup, player) {
  level endon("shutdown_hologram");

  GroupDeathCount = 0;

  thread snd_play_in_space("mp_shooting_range_panels_bell", level.firingrange.audio_buzzer_struct.origin);
  foreach(target in WaveGroup) {
    target thread target_lifetime(player);
  }

  while(true) {
    level waittill("target_died");

    GroupDeathCount++;

    if(GroupDeathCount == WaveGroup.size) {
      level notify("wave_done");
      return;
    }
  }
}

target_lifetime(player) {
  level endon("shutdown_hologram");

  self.original_position = self.origin;
  self.original_orientation = self.angles;
  self.alive = true;

  self SpawnTarget();

  self thread target_handler(player);
  self thread target_logic();
  self thread target_handle_death();
  self thread target_handle_stop();
}

Particlespawn(Particle, ParticleOrigin, ParticleAngles, Time, IsKilled) {
  if(!isDefined(ParticleOrigin)) {
    ParticleOrigin = (0, 0, 0);
  }
  if(!isDefined(ParticleAngles)) {
    ParticleAngles = (0, 0, 0);
  }

  SpawnedFX = SpawnFx(Particle, ParticleOrigin, anglesToForward(ParticleAngles), AnglesToUp(ParticleAngles));
  if(isDefined(IsKilled)) {
    setfxkillondelete(SpawnedFX, IsKilled);
  }
  TriggerFX(SpawnedFX);

  if(isDefined(Time)) {
    wait(Time);
    if(isDefined(SpawnedFX) && !IsRemovedEntity(SpawnedFX)) {
      SpawnedFX delete();
    }
  } else {
    level waittill("shutdown_hologram");
    if(isDefined(SpawnedFX) && !IsRemovedEntity(SpawnedFX)) {
      SpawnedFX delete();
    }
  }
}

target_logic() {
  level endon("shutdown_hologram");
  self endon("death");

  if(isDefined(self.script_parameters)) {
    logic = self.script_parameters;

    self MoveTargetToDest();

    switch (logic) {
      case "stand":

        break;
      case "cover":
        self thread PopInPopOut();
        break;
      case "move":
        self thread MoveBackForth();
        break;
    }
  }
}

MoveTargetToDest() {
  level endon("shutdown_hologram");
  self endon("death");

  if(!isDefined(level.firingrange.RoundNumber)) {
    return;
  }
  RoundNumber = level.firingrange.RoundNumber;
  closest_ent = getClosest(self.origin, level.firingrange.AllTargetLogicArray[RoundNumber]);

  self.current_ent = closest_ent;
  self.last_ent = self.current_ent;

  while(true) {
    if(isDefined(self)) {
      dist = distance(self.current_ent.origin, self.origin);
      time = dist / level.firingrange.Round_target_unit_per_second;

      if(isDefined(self.current_ent.script_noteworthy) && self.current_ent.script_noteworthy == "jump") {
        self moveto(self.current_ent.origin, time * 0.5, 0, 0.1);
      } else if(isDefined(self.last_ent.script_noteworthy) && self.last_ent.script_noteworthy == "jump") {
        self moveto(self.current_ent.origin, time * 0.5, 0.1, 0);
      } else {
        self moveto(self.current_ent.origin, time);
      }

      self waittill("movedone");

      if(isDefined(self.current_ent.target)) {
        next_ent = getent(self.current_ent.target, "targetname");
        self.last_ent = self.current_ent;
        self.current_ent = next_ent;
      } else {
        return;
      }
    } else {
      return;
    }
  }
}

PopInPopOut() {
  level endon("shutdown_hologram");
  self endon("death");

  ExposedTime = 4;
  HideTime = 1;

  exposed_loc = self.current_ent.origin;
  cover_loc = self.last_ent.origin;

  if(self.current_ent == self.last_ent) {
    cover_loc = self.original_position;
  }

  wait(ExposedTime);

  while(true) {
    if(isDefined(self)) {
      dist = distance(cover_loc, exposed_loc);
      time = dist / level.firingrange.Round_target_unit_per_second;
      self moveto(cover_loc, time);

      self waittill("movedone");

      wait(HideTime);

      dist = distance(cover_loc, exposed_loc);
      time = dist / level.firingrange.Round_target_unit_per_second;
      self moveto(exposed_loc, time);

      self waittill("movedone");

      wait(ExposedTime);
    }
  }
}

MoveBackForth() {
  level endon("shutdown_hologram");
  self endon("death");

  jump_ent = undefined;
  jump_ent_loc = undefined;

  if(isDefined(self.last_ent.script_noteworthy) && self.last_ent.script_noteworthy == "jump") {
    jump_ent = self.last_ent;
    jump_ent_loc = jump_ent.origin;
    self.last_ent = getent(jump_ent.targetname, "target");
  }

  end_loc = self.current_ent.origin;
  start_loc = self.last_ent.origin;

  if(self.current_ent == self.last_ent) {
    start_loc = self.original_position;
  }

  while(true) {
    if(isDefined(self)) {
      if(isDefined(jump_ent_loc)) {
        wait(2);
        dist = distance(jump_ent_loc, end_loc);
        time = dist / level.firingrange.Round_target_unit_per_second;

        self moveto(jump_ent_loc, time * .5, 0, 0.1);
        self waittill("movedone");

        dist = distance(jump_ent_loc, start_loc);
        time = dist / level.firingrange.Round_target_unit_per_second;

        self moveto(start_loc, time * .5, 0.1, 0);
        self waittill("movedone");

        wait(2);

        dist = distance(jump_ent_loc, start_loc);
        time = dist / level.firingrange.Round_target_unit_per_second;

        self moveto(jump_ent_loc, time * .5, 0, 0.1);
        self waittill("movedone");

        dist = distance(jump_ent_loc, end_loc);
        time = dist / level.firingrange.Round_target_unit_per_second;

        self moveto(end_loc, time * .5, 0.1, 0);
        self waittill("movedone");
      } else {
        dist = distance(start_loc, end_loc);
        time = dist / level.firingrange.Round_target_unit_per_second;

        self moveto(start_loc, time);

        self waittill("movedone");

        dist = distance(end_loc, start_loc);
        time = dist / level.firingrange.Round_target_unit_per_second;
        self moveto(end_loc, time);

        self waittill("movedone");
      }
    }
  }
}

score_handler() {
  level endon("shutdown_hologram");
  while(true) {
    newhits = [];
    for(i = 0; i < self.hits.size; i++) {
      self.hits[i].time = self.hits[i].time - 1;
      if(self.hits[i].time > 0) {
        newhits[newhits.size] = self.hits[i];
      }
    }
    self.hits = newhits;
    foreach(hit in self.hits) {
      print3d(hit.origin, "hit: " + hit.dist, (1, 1, 1), 1, 2, 1);
    }
    wait 0.05;
  }
}

target_handler(player) {
  level endon("shutdown_hologram");

  self.hits = [];

  self.aimassist_target.health = 9999;
  self.aimassist_target.maxhealth = 9999;
  self.maxhealth = 9999;
  self.health = self.maxhealth;
  self.fakehealth = 100;
  self setCanDamage(true);
  self.aimassist_target Show();
  self.aimassist_target Solid();
  self.aimassist_target EnableAimAssist();

  while(self.health > 0) {
    damage = undefined;
    attacker = undefined;
    direction_vec = undefined;
    point = undefined;
    type = undefined;
    modelName = undefined;
    tagName = undefined;
    partName = undefined;
    dflags = undefined;

    self waittill("damage", damage, attacker, direction_vec, point, type, modelName, tagName, partName, dflags, weapon_name);

    modifier = GetModifier(weapon_name, partName, player);

    tag_head = self GetTagOrigin("tag_head");
    tag_body = self GetTagOrigin("tag_chest");

    self.health = self.maxhealth;

    health = self.fakehealth;
    health = float(health) - (Float(damage) * modifier);
    health = roundDecimalPlaces(health, 0);
    self.fakehealth = int(health);

    if(self.fakehealth <= 0) {
      thread TargetPlayDeath(tag_body);
      self.health = 0;

      if(isDefined(attacker)) {
        if(isDefined(partName)) {
          if(partName == "tag_head") {
            attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback("killshot_headshot");
          } else if(partName == "tag_chest") {
            attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback("mp_hit_kill");
          }
        }
      }
      self notify("death");
    } else if(isDefined(attacker)) {
      if(isDefined(partName) && partName == "tag_head") {
        attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback("headshot");
      } else {
        attacker maps\mp\gametypes\_damagefeedback::updateDamageFeedback("standard");
      }
    }
  }
}

TargetPlayDeath(vec) {
  playFX(level._effect["recovery_scoring_target_shutter_enemy"], vec);
}

deactivate_targets() {
  level notify("shutdown_hologram");
}

firing_range_setup_triggers() {
  RoundTriggers = getEntArray("firing_range_round_trigger", "targetname");

  return RoundTriggers;
}

firing_range_setup_target_logic() {
  LogicEntArray = getEntArray("target_logic_point", "targetname");

  LogicEntGroupArray = [];

  foreach(ent in LogicEntArray) {
    if(isDefined(ent.script_index)) {
      RoundNumber = int(ent.script_index);
      if(!IsArray(LogicEntGroupArray[RoundNumber])) {
        RoundGroup = [ent];
        LogicEntGroupArray[RoundNumber] = RoundGroup;
      } else {
        LogicEntGroupArray[RoundNumber] = add_to_array(LogicEntGroupArray[RoundNumber], ent);
      }
    }
  }
  return LogicEntGroupArray;
}

firing_range_setup_env() {
  EnvGeoArray = getEntArray("round_environment", "targetname");

  EnvRoundGroupArray = [];

  foreach(part in EnvGeoArray) {
    part Hide();
    part NotSolid();

    RoundNumber = undefined;

    if(isDefined(part.script_index)) {
      RoundNumber = int(part.script_index);
    }

    if(isDefined(RoundNumber)) {
      if(!IsArray(EnvRoundGroupArray[RoundNumber])) {
        RoundGroup = [part];
        EnvRoundGroupArray[RoundNumber] = RoundGroup;
      } else {
        EnvRoundGroupArray[RoundNumber] = add_to_array(EnvRoundGroupArray[RoundNumber], part);
      }
    }
  }

  return EnvRoundGroupArray;
}

firing_range_setup_env_VFX() {
  EnvVFX_Array = getstructarray("round_environment", "targetname");

  EnvVFX_GroupArray = [];

  foreach(struct in EnvVFX_Array) {
    RoundNumber = undefined;

    if(isDefined(struct.script_index)) {
      RoundNumber = int(struct.script_index);
    }

    if(isDefined(RoundNumber)) {
      if(!IsArray(EnvVFX_GroupArray[RoundNumber])) {
        RoundGroup = [struct];
        EnvVFX_GroupArray[RoundNumber] = RoundGroup;
      } else {
        EnvVFX_GroupArray[RoundNumber] = add_to_array(EnvVFX_GroupArray[RoundNumber], struct);
      }
    }
  }

  return EnvVFX_GroupArray;
}

firing_range_setup_targets() {
  enemy_targets = getEntArray("target_enemy", "targetname");

  enemy_target_arrays = [];

  foreach(object in enemy_targets) {
    object.alive = false;
    object.pers["team"] = "axis";
    object.team = "axis";
    object.origin_ent = GetEnt(object.target, "targetname");
    object.aimassist_target = GetEnt(object.origin_ent.target, "targetname");
    object.aimassist_target LinkToSynchronizedParent(object);
    object.aimassist_target.pers["team"] = "axis";
    object.aimassist_target.team = "axis";

    object.original_position = object.origin;
    object.original_orientation = object.angles;

    object.aimassist_target hide();
    object.aimassist_target NotSolid();
    object Hide();
    object NotSolid();

    if(isDefined(object.script_index)) {
      RoundNumber = int(object.script_index);
      if(!IsArray(enemy_target_arrays[RoundNumber])) {
        RoundGroup = [];
        enemy_target_arrays[RoundNumber] = RoundGroup;
      }

      if(isDefined(object.script_group)) {
        WaveNumber = int(object.script_group);
        if(!IsArray(enemy_target_arrays[RoundNumber][WaveNumber])) {
          WaveGroup = [object];
          enemy_target_arrays[RoundNumber][WaveNumber] = WaveGroup;
        } else {
          enemy_target_arrays[RoundNumber][WaveNumber] = add_to_array(enemy_target_arrays[RoundNumber][WaveNumber], object);
        }
      }
    }
  }
  return enemy_target_arrays;
}

target_handle_death() {
  level endon("shutdown_hologram");
  self waittill("death");

  level notify("target_died");

  self target_reset();
}

target_handle_stop() {
  self endon("death");
  level waittill("shutdown_hologram");

  self target_reset();
}

target_reset() {
  self setCanDamage(false);
  self Hide();
  self NotSolid();
  self.alive = false;

  if(isDefined(self.aimassist_target)) {
    self.aimassist_target disableAimAssist();
  }
}

lerp_spot_intensity(targetname, time, endintensity) {
  ent = GetEnt(targetName, "targetname");
  if(!isDefined(ent)) {
    return;
  }

  if(level.currentgen && (isDefined(ent) == 0)) {
    return;
  }

  startintensity = ent GetLightIntensity();
  ent.endintensity = endintensity;

  t = 0;

  while(t < time) {
    new_intensity = startintensity + (endintensity - startintensity) * (t / time);
    t += 0.05;
    ent setLightIntensity(new_intensity);
    wait 0.05;
  }
  ent setLightIntensity(endintensity);
}

lerp_spot_intensity_array(targetname, time, endintensity) {
  ents = getEntArray(targetName, "targetname");
  foreach(ent in ents) {
    startintensity = ent GetLightIntensity();
    ent.endintensity = endintensity;

    t = 0;

    while(t < time) {
      new_intensity = startintensity + (endintensity - startintensity) * (t / time);
      t += 0.05;
      ent setLightIntensity(new_intensity);
      wait 0.05;
    }
    ent setLightIntensity(endintensity);
  }
}

monitor_weapon_ammo_count(weapon) {
  self endon("enter_lobby");
  while(level.in_firingrange == 1) {
    ammo = self GetFractionMaxAmmo(weapon);
    if(ammo <= 0.25) {
      self GiveMaxAmmo(weapon);
      continue;
    }
    wait(0.5);
  }
}

RiotShieldCleanup() {
  if(isDefined(self.riotshieldEntity)) {
    self.riotshieldEntity thread maps\mp\_riotshield::damageThenDestroyRiotshield();
  }
}

GrenadeCleanup(IsEndOfRound) {
  if(isDefined(level.grenades) && IsArray(level.grenades)) {
    foreach(grenade in level.grenades) {
      if(isDefined(grenade) && !IsRemovedEntity(grenade)) {
        if(!isDefined(self) || !isDefined(grenade.owner) || IsRemovedEntity(grenade.owner)) {
          if(!isDefined(grenade.weaponname)) {
            continue;
          } else if(maps\mp\_utility::strip_suffix(grenade.weaponname, "_lefthand") == "explosive_drone_mp") {
            grenade thread maps\mp\_explosive_drone::explosiveGrenadeDeath();
          } else {
            grenade notify("death");
            grenade thread DelayDelete();
          }
        } else if(grenade.owner == self) {
          if(!isDefined(grenade.weaponname)) {
            continue;
          } else if(maps\mp\_utility::strip_suffix(grenade.weaponname, "_lefthand") == "explosive_drone_mp") {
            grenade thread maps\mp\_explosive_drone::explosiveGrenadeDeath();
          } else if(maps\mp\_utility::strip_suffix(grenade.weaponname, "_lefthand") == "exoknife_mp") {
            if(isDefined(IsEndOfRound) && IsEndOfRound == true) {
              val = GetDvarInt("virtualLobbyInFiringRange", 0);
              if(val == 1 && level.in_firingrange == 1) {
                grenade maps\mp\_exoknife::exo_knife_restock();
              }
            } else {
              grenade notify("death");
              grenade thread DelayDelete();
            }
          } else {
            grenade notify("death");
            grenade thread DelayDelete();
          }
        }
      }
    }
  }
  self thread DroneCleanup();
}

DroneCleanup() {
  if(isDefined(level.trackingDrones) && IsArray(level.trackingDrones)) {
    foreach(drone in level.trackingDrones) {
      if(isDefined(drone) && !IsRemovedEntity(drone)) {
        if(!isDefined(self) || !isDefined(drone.owner) || IsRemovedEntity(drone.owner)) {
          drone thread maps\mp\_tracking_drone::trackingDroneExplode();
        } else if(drone.owner == self) {
          drone thread maps\mp\_tracking_drone::trackingDroneExplode();
        }
      }
    }
  }
}

DelayDelete() {
  wait(0.05);
  if(isDefined(self) && !IsRemovedEntity(self)) {
    self delete();
  }
}
monitor_grenade_count(weapon, isOffhand) {
  self endon("enter_lobby");

  isVarGrenade = false;
  weapon_short = maps\mp\_utility::strip_suffix(weapon, "_lefthand");
  if(weapon_short == "smoke_grenade_var_mp" || weapon_short == "stun_grenade_var_mp" || weapon_short == "emp_grenade_var_mp" || weapon_short == "paint_grenade_var_mp") {
    isVarGrenade = true;
  }

  if(weapon_short == "explosive_drone_mp") {
    self thread EnforceExplosiveDroneLimit();
  }

  while(level.in_firingrange == 1) {
    if(isVarGrenade == true) {
      wait(1.5);
      if(!isOffhand) {
        ammo_paint = self GetAmmoCount("paint_grenade_var_mp");
        ammo_smoke = self GetAmmoCount("smoke_grenade_var_mp");
        ammo_emp = self GetAmmoCount("emp_grenade_var_mp");
        ammo_stun = self GetAmmoCount("stun_grenade_var_mp");

        if(ammo_paint == 0 && ammo_smoke == 0 && ammo_emp == 0 && ammo_stun == 0) {
          self GiveStartAmmo("paint_grenade_var_mp");
          self GiveStartAmmo("smoke_grenade_var_mp");
          self GiveStartAmmo("emp_grenade_var_mp");
          self GiveStartAmmo("stun_grenade_var_mp");
        }
      } else {
        ammo_paint_left = self GetAmmoCount("paint_grenade_var_mp_lefthand");
        ammo_smoke_left = self GetAmmoCount("smoke_grenade_var_mp_lefthand");
        ammo_emp_left = self GetAmmoCount("emp_grenade_var_mp_lefthand");
        ammo_stun_left = self GetAmmoCount("stun_grenade_var_mp_lefthand");

        if(ammo_paint_left == 0 && ammo_smoke_left == 0 && ammo_emp_left == 0 && ammo_stun_left == 0) {
          self GiveStartAmmo("paint_grenade_var_mp_lefthand");
          self GiveStartAmmo("smoke_grenade_var_mp_lefthand");
          self GiveStartAmmo("emp_grenade_var_mp_lefthand");
          self GiveStartAmmo("stun_grenade_var_mp_lefthand");
        }
      }

      continue;
    } else {
      wait(1.5);

      ammo = self GetAmmoCount(weapon);

      if(ammo == 0) {
        self maps\mp\gametypes\_class::giveOffhand(weapon);
        continue;
      }
    }
    wait(0.5);
  }
}

EnforceExplosiveDroneLimit() {
  self endon("enter_lobby");

  while(true) {
    self waittill("grenade_fire", grenade, weapname);

    shortWeaponName = maps\mp\_utility::strip_suffix(weapname, "_lefthand");

    if(shortWeaponName == "explosive_drone_mp") {
      if(isDefined(level.grenades) && IsArray(level.grenades)) {
        foreach(grenade in level.grenades) {
          if(isDefined(grenade) && !IsRemovedEntity(grenade) && isDefined(self) && isDefined(grenade.owner) && isDefined(grenade.weaponname)) {
            if(maps\mp\_utility::strip_suffix(grenade.weaponname, "_lefthand") == "explosive_drone_mp" && grenade.owner == self) {
              if(isDefined(grenade.explosiveDrone)) {
                grenade.explosiveDrone thread maps\mp\_explosive_drone::explosiveHeadDeath();
              } else {
                grenade thread maps\mp\_explosive_drone::explosiveGrenadeDeath();
              }
            }
          }
        }
      }
    }
  }
}

ShowTransition_CG(RoundNumber) {
  level endon("shutdown_hologram");

  i = 0;
  savedTransitionModelNames = [];
  foreach(part in level.firingrange.AllEnvArray[RoundNumber]) {
    if(isDefined(part.classname) && part.classname == "script_model") {
      if(isDefined(part.model) && IsSubStr(part.model, "rec_holo_range")) {
        savedTransitionModelNames[i] = part.model;

        if(!IsSubStr(part.model, "trans")) {
          modelname_trans = part.model + "_trans";
          part setModel(modelname_trans);
        }

        part Show();
      } else {
        savedTransitionModelNames[i] = undefined;
      }
    }
    i++;
  }
  return savedTransitionModelNames;
}

HideTransitionMeshes_CG(RoundNumber, SavedNames) {
  i = 0;
  foreach(part in level.firingrange.AllEnvArray[RoundNumber]) {
    if(isDefined(part.classname) && part.classname == "script_model") {
      if(isDefined(part.model) && IsSubStr(part.model, "rec_holo_range")) {
        if(IsString(SavedNames[i])) {
          part Hide();
          part setModel(SavedNames[i]);
        }
      }
    }
    i++;
  }
}