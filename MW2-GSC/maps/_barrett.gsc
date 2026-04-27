/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\_barrett.gsc
********************************************************/

#include maps\_hud_util;
#include maps\_utility;
#include maps\_debug;
#include animscripts\utility;
#include common_scripts\utility;
#include maps\_anim;
#using_animtree("script_model");
barrett_init() {
  precacheshellshock("barrett");

  add_hint_string("barrett", &"WEAPON_PRESS_FORWARDS_OR_BACKWARDS", ::should_break_zoom_hint);

  flag_init("player_is_on_turret");
  flag_init("player_on_barret");
  flag_init("player_used_zoom");
  flag_init("can_use_turret");
  flag_init("player_gets_off_turret");

  level._effect["bullet_geo"] = loadfx("smoke/smoke_geotrail_barret");
  thread exchange_trace_converter();
  thread exchange_barrett_trigger();

  wait(0.05);

  level.barrett_exists = true;
}

exchange_barrett_trigger() {
  barrett_trigger = getent("barrett_trigger", "targetname");

  barrett_trigger sethintstring(&"WEAPON_BARRETT_USE");
  turret = getent("turret2", "targetname");

  targ = getent(turret.target, "targetname");
  turret makeUnusable();
  turret hide();
  turret.origin = targ.origin;

  while(1) {
    barrett_trigger waittill("trigger");
    level.player.original_org = level.player.origin;

    level.player setplayerangles((turret.angles[0], turret.angles[1], level.player.angles[2]));

    turret useby(level.player);

    setsaveddvar("ui_hideMap", "1");
    setsaveddvar("compass", 0);
    SetSavedDvar("ammoCounterHide", "1");
    SetSavedDvar("hud_showStance", 0);

    level.player_can_fire_turret_time = gettime() + 1000;
    setsaveddvar("sv_znear", "100");

    setsaveddvar("sm_sunShadowCenter", getent(turret.target, "targetname").origin);
    flag_set("player_is_on_turret");
    level.player disableWeapons();
    if(level.script == "dcburning") {
      level.player SetActionSlot(1, "");
      level.player NightVisionForceOff();
    }

    thread player_learns_to_zoom();
    if(!flag("player_used_zoom")) {
      level.player thread display_hint("barrett");
    }

    level.level_specific_dof = true;

    player_org = level.player.origin + (0, 0, 60);

    for(;;) {
      if(!isDefined(turret getturretowner())) {
        break;
      }
      wait(0.05);
    }

    setsaveddvar("compass", 1);
    SetSavedDvar("ammoCounterHide", "0");
    setsaveddvar("ui_hideMap", "0");
    SetSavedDvar("hud_showStance", 1);

    setsaveddvar("sv_znear", "0");
    setsaveddvar("sm_sunShadowCenter", (0, 0, 0));
    flag_clear("player_is_on_turret");
    level.player enableWeapons();
    if(level.script == "dcburning") {
      level.player SetActionSlot(1, "nightvision");
    }

    level.level_specific_dof = false;

    setblur(0, 0.05);

    level.player setorigin(level.player.original_org + (0, 0, 10));
  }
}

exchange_trace_converter() {
  firetime = -5000;

  for(;;) {
    flag_wait("player_is_on_turret");
    wait_for_buffer_time_to_pass(firetime, 1.0);

    if(!level.player attackButtonPressed()) {
      wait(0.05);
      continue;
    }

    thread exchange_player_fires();
    firetime = gettime();

    while(level.player attackButtonPressed()) {
      wait(0.05);
    }
  }
}

exchange_player_fires() {
  if(gettime() < level.player_can_fire_turret_time) {
    return;
  }

  level.player shellshock("barrett", 1.3);
}

should_break_zoom_hint() {
  assert(isPlayer(self));

  if(!flag("player_is_on_turret"))
    return true;

  return flag("player_used_zoom");
}

player_learns_to_zoom() {
  flag_clear("player_used_zoom");
  movement = level.player GetNormalizedMovement();

  while(true) {
    wait(0.05);
    movement = level.player GetNormalizedMovement();
    if(movement[0] > 0.2) {
      break;
    }
  }
  wait(6);
  flag_set("player_used_zoom");
}