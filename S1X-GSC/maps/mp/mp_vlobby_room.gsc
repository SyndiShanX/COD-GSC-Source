/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_vlobby_room.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\agents\_agent_utility;
#include maps\mp\gametypes\_damage;
#include maps\mp\agents\_scriptedAgents;
#include maps\mp\_dynamic_events;
#include maps\mp\_audio;

main() {
  PreCacheModel("archery_target_fr");
  PreCacheModel("bc_target_dummy_base");
  PreCacheModel("training_target_opfor1");
  PreCacheModel("training_target_civ1");
  PreCacheShader("ac130_overlay_pip_vignette_vlobby");
  PreCacheShader("ac130_overlay_pip_vignette_vlobby_cao");
  maps\mp\mp_vlobby_room_precache::main();
  maps\createart\mp_vlobby_room_art::main();
  maps\mp\mp_vlobby_room_fx::main();

  maps\mp\_load::main();
  maps\mp\mp_vlobby_room_lighting::main();
  maps\mp\mp_vlobby_room_aud::main();

  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.vl_dof_based_on_focus = ::vl_dof_based_on_focus;
  level.vl_handle_mode_change = ::vl_handle_mode_change;
  level.vl_lighting_setup = ::vl_lighting_setup;

  thread vl_ground_setup();
  maps\mp\_vl_base::vl_init();

  level.dof_tuner = spawnStruct();
  level.dof_tuner.FStopPerUnit = 0.25;
  level.dof_tuner.scaler = -0.3;
  level.dof_tuner.fStopBase = 3;

  thread fade_from_black();
}

fade_from_black() {
  level waittill("connected", player);

  player waittill("fade_in");

  player clientaddsoundsubmix("mp_no_foley", 1);
}

vl_ground_setup() {
  fromEnt = GetEnt("teleport_from", "targetname");
  toEnt = GetEnt("teleport_to", "targetname");

  ground_b_bsps = getEntArray("vlobby_floor_b", "targetname");
  foreach(ground_b_bsp in ground_b_bsps) {
    ground_b_bsp.origin += toent.origin - froment.origin;
  }

  ground_a_bsps = getEntArray("vlobby_floor_a", "targetname");
  foreach(ground_a_bsp in ground_a_bsps) {
    ground_a_bsp hide();
  }
}

vl_lighting_setup() {
  player = self;

  player EnablePhysicalDepthOfFieldScripting();
  if(level.nextgen) {
    player SetPhysicalDepthOfField(0.613159, 89.8318, level.camParams.DOF_Time, level.camParams.DOF_Time * 2);
  } else {
    player SetPhysicalDepthOfField(4.01284, 95.2875, level.camParams.DOF_Time, level.camParams.DOF_Time * 2);
  }
}

vl_dof_based_on_focus(Dist) {
  dof_time = level.camParams.DOF_Time;
  player = self;

  Dist2Tgt = Dist;
  player = self;
  FStopPerUnit = level.dof_tuner.FStopPerUnit;
  scaler = level.dof_tuner.scaler;
  fStopBase = level.dof_tuner.fStopBase;
  if(level.currentgen) {
    fStopBase += 2;
  }
  BaseDistance = 104;

  result = ((BaseDistance - Dist2Tgt) * FStopPerUnit);
  fStop = fStopBase + result + (result * scaler);

  if(fStop < 0.125) {
    fStop = 0.125;
  } else if(fStop > 128) {
    fStop = 128;
  }
  player SetPhysicalDepthOfField(fStop, Dist2Tgt, dof_time, dof_time * 2);
}

vl_handle_mode_change(mode, newmode, camParams) {
  player = self;

  if(mode == "cac") {
    player SetDefaultPostFX();
  } else if(mode == "cao") {}

  if(newmode == "cac") {
    player VisionSetNakedForPlayer("mp_vlobby_room_cac", 0);
    player LightSetForPlayer("mp_vl_create_a_class");
  } else if(newmode == "cao") {
    if(level.nextgen) {
      player SetPhysicalDepthOfField(1.223, 156.419, level.camParams.DOF_Time, level.camParams.DOF_Time);
    } else {
      player SetPhysicalDepthOfField(3.223, 156.419, level.camParams.DOF_Time, level.camParams.DOF_Time);
    }
  } else if(newmode == "prelobby") {
    player SetDefaultDOF();
    player SetDefaultPostFX();
  } else if(mode == "prelobby_members") {} else if(mode == "prelobby_loadout") {} else if(mode == "prelobby_loot") {} else if(newmode == "game_lobby") {
    player SetDefaultPostFX();
    player maps\mp\_vl_camera::Set_Avatar_DOF();
  } else if(mode == "startmenu") {} else if(mode == "transition") {} else if(newmode == "clanprofile") {
    player SetDefaultDOF();
    player SetDefaultPostFX();
  }

}

SetDefaultPostFX() {
  player = self;
  player VisionSetNakedForPlayer("mp_vlobby_room", 0);
  player LightSetForPlayer("mp_vlobby_room");
}
SetDefaultDOF() {
  player = self;
  if(level.nextgen) {
    player SetPhysicalDepthOfField(0.613159, 89.8318, level.camParams.DOF_Time, level.camParams.DOF_Time);
  } else {
    player SetPhysicalDepthOfField(4.01284, 95.2875, level.camParams.DOF_Time, level.camParams.DOF_Time);
  }
}