/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_vl_selfiebooth.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\agents\_agent_utility;
#include maps\mp\agents\_scriptedAgents;
#include maps\mp\_vl_camera;
#include maps\mp\_vl_base;
#using_animtree("multiplayer_vlobby");

init_selfieBooth() {
  player_pos = GetEnt("selfie_player_pos", "targetname");
  if(!isDefined(player_pos)) {
    return;
  }

  camera_target = GetEnt(player_pos.target, "targetname");
  camera_pos = GetEnt(camera_target.target, "targetname");

  level.selfieBooth = spawnStruct();
  level.selfieBooth.player_pos = player_pos;
  level.selfieBooth.camera_pos = camera_pos;

  SetDevDvarIfUninitialized("scr_vlobby_force_selfie", 0);

  SetDvarIfUninitialized("scr_vlobby_selfie_correction_y", 32.0);
  SetDvarIfUninitialized("scr_vlobby_selfie_collision_z", 10.0);

  level thread run_selfieBooth();
}

run_selfieBooth() {
  while(!isDefined(level.player)) {
    waitframe();
  }

  Assert(level.player IsHost());

  level.player SpawnSelfieAvatar();

  wait 5;

  while(1) {
    waitframe();
    if(IsSystemLink() || !IsOnlineGame() || GetDvarInt("practiceroundgame")) {
      continue;
    }

    if(!should_take_selfie()) {
      continue;
    }

    take_selfie();
  }
}

SpawnSelfieAvatar() {
  while(!isDefined(level.player.spawned_avatar) || !isDefined(level.player.spawned_avatar.costume)) {
    waitframe();
  }

  clone_origin = level.selfieBooth.player_pos.origin;

  Z = GetDvarFloat("scr_vlobby_selfie_collision_z", 0.0);
  Y = GetDvarFloat("scr_vlobby_selfie_correction_y", 0.0);

  clone_footPos = (0, Y, Z);

  clone_origin += clone_footPos;

  clone_angles = level.selfieBooth.player_pos.angles;

  clone = getFreeAgent("selfie_clone");
  clone.isActive = true;
  clone SpawnAgent(clone_origin, clone_angles, undefined, undefined, undefined, undefined, true);
  xuid = level.player getxuid();
  setEntPlayerXuidForEmblem(clone, xuid);

  clone EnableAnimState(true);
  clone SetAnimClass("vlobby_animclass");
  clone SetAnimState("lobby_idle", "selfie_01", 1.0);

  clone SetCostumeModels(level.player.spawned_avatar.costume);

  clone LinkTo(level.selfieBooth.player_pos);

  level.selfieBooth.clone = clone;
  self.selfie_clone = clone;
}

should_take_selfie() {
  if(!isDefined(level.player)) {
    return false;
  }

  if(!isDefined(level.player.spawned_avatar) || !isDefined(level.player.spawned_avatar.costume)) {
    return false;
  }

  if(!level.player selfieAccessSelfieCustomAssetsAreStreamed()) {
    return false;
  }

  if(GetDvarInt("scr_vlobby_force_selfie", 0)) {
    SetDevDvar("scr_vlobby_force_selfie", 0);
    return true;
  }

  if(level.player selfieAccessSelfieValidFlagInPlayerDef()) {
    return false;
  }

  return true;
}

take_selfie() {
  if(!isDefined(level.selfieBooth.clone)) {
    return;
  }

  if(!isDefined(level.player)) {
    return;
  }

  if(!isDefined(level.player.spawned_avatar)) {
    return;
  }

  if(!isDefined(level.player.spawned_avatar.costume)) {
    return;
  }

  clone_origin = level.selfieBooth.clone.origin;

  clone_eyePos = level.selfieBooth.clone getEye();

  level.selfieBooth.clone SetCostumeModels(level.player.spawned_avatar.costume);

  waitframe();

  if(!level.player SelfieRequestUpdate(level.selfieBooth.camera_pos.origin, clone_origin, clone_eyePos[2] - clone_origin[2], 0, 0)) {
    return;
  }

  while(isDefined(level.player) && !level.player SelfieScreenshotTaken()) {
    waitframe();
  }
}