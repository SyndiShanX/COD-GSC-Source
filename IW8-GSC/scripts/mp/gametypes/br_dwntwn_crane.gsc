/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_dwntwn_crane.gsc
****************************************************/

function min_x() {
  level endon("game_ended");
  min_z();
  thread min_y();
}

function min_z() {
  level.min_x = getEnt("crane_arm", "targetname");
  level.min_x.collision = getEnt("crane_collision", "targetname");
  level.min_x.spawn_maint_wave_2 = getEnt("crane_hook", "targetname");
  level.min_x.ref_123B7 = getEnt("crane_platform", "targetname");
  level.min_x.collision linkTo(level.min_x);
  level.min_x.trigger = getEnt("crane_trigger", "targetname");
  level.min_x.trigger makeusable();
  level.min_x.trigger show();
  level.min_x.trigger sethintdisplayfov(360);
  level.min_x.trigger setusefov(360);
  level.min_x.trigger sethintdisplayrange(100);
  level.min_x.trigger setuserange(100);
  var_0 = getEnt(level.min_x.spawn_maint_wave_2.target, "targetname");
  var_1 = getEnt(var_0.target, "targetname");
  level.min_x.ref_11E30 = var_0;
  level.min_x.pelletweaponvictimids = var_1;
  level.min_x.ref_11E30 linkTo(level.min_x);
  level.min_x.pelletweaponvictimids linkTo(level.min_x);
}

function min_y() {
  level endon("game_ended");
  level.min_x endon("death");
  level.min_x endon("deleted");
  level.min_x.trigger endon("deaht");

  for(;;) {
    if(isDefined(level.min_x.trigger)) {
      level.min_x.trigger.in_use = undefined;
      level.min_x.trigger makeusable();
      level.min_x.trigger setHintString(&"MP/BR_INTERACTABLES_CRANE_PROMPT");
      level.min_x.trigger waittill("trigger", var_0);
      level.min_x.trigger.in_use = 1;
      level.min_x.trigger makeunusable();
      level.min_x.trigger setHintString("");
      var_0 playlocalsound("ammo_crate_use");
    }

    wait 5;
    level.min_x.ref_123B7 movez(1808, 5, 1, 1);
    wait 7;
    level.min_x.ref_123B7 linkTo(level.min_x.spawn_maint_wave_2);
    level.min_x.spawn_maint_wave_2 moveTo(level.min_x.pelletweaponvictimids.origin, 5, 1, 1);
    wait 7;
    level.min_x.spawn_maint_wave_2 linkTo(level.min_x);
    level.min_x rotateYaw(135, 10, 1, 1);
    wait 12;

    if(isDefined(level.min_x.trigger)) {
      level.min_x.trigger.in_use = undefined;
      level.min_x.trigger makeusable();
      level.min_x.trigger setHintString(&"MP/BR_INTERACTABLES_CRANE_PROMPT");
      level.min_x.trigger waittill("trigger", var_0);
      level.min_x.trigger.in_use = 1;
      level.min_x.trigger makeunusable();
      level.min_x.trigger setHintString("");
      var_0 playlocalsound("ammo_crate_use");
    }

    wait 5;
    level.min_x rotateYaw(-135, 10, 1, 1);
    wait 12;
    level.min_x.spawn_maint_wave_2 unlink();
    level.min_x.spawn_maint_wave_2 moveTo(level.min_x.ref_11E30.origin, 5, 1, 1);
    wait 7;
    level.min_x.ref_123B7 unlink();
    level.min_x.ref_123B7 movez(-1808, 5, 1, 1);
    wait 7;
  }
}