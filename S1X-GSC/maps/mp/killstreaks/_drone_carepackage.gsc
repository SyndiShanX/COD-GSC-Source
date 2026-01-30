/******************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_drone_carepackage.gsc
******************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\gametypes\_hostmigration;
#include maps\mp\_aerial_pathnodes;

init() {
  level.carepackageDrone = spawnStruct();
  level.carepackageDrone.health = 999999;
  level.carepackageDrone.maxHealth = 200;
  level.carepackageDrone.fxId_explode = LoadFX("vfx/explosion/tracking_drone_explosion");
  level.carepackageDrone.sound_explode = "veh_tracking_drone_explode";
  level.carepackageDrone.releaseString = &"KILLSTREAKS_DRONE_CAREPACKAGE_RELEASE";

  level.carepackageDrones = [];
}

setupCarepackageDrone(drone, setupRelease) {
  drone make_entity_sentient_mp(self.team);
  drone makevehiclenotcollidewithplayers(true);

  drone addToCarepackageDroneList();
  drone thread removeFromCarepackageDroneListOnDeath();

  drone.health = level.carepackageDrone.health;
  drone.maxHealth = level.carepackageDrone.maxHealth;
  drone.damageTaken = 0;

  drone.speed = 15;
  drone.followSpeed = 15;
  drone.owner = self;
  drone.team = self.team;

  drone Vehicle_SetSpeed(drone.speed, 10, 10);
  drone SetYawSpeed(120, 90);
  drone SetNearGoalNotifyDist(64);
  drone SetHoverParams(4, 5, 5);

  drone.fx_tag0 = "tag_body";

  if(setupRelease) {
    drone.usableEnt = spawn("script_model", drone.origin + (0, 0, 1));
    drone.usableEnt setModel("tag_origin");
    drone.usableEnt.owner = self;
    drone.usableEnt makeGloballyUsableByType("killstreakRemote", level.carepackageDrone.releaseString, self);
  }

  maxPitch = 45;
  maxRoll = 45;
  drone SetMaxPitchRoll(maxPitch, maxRoll);

  attract_strength = 10000;
  attract_range = 150;
  drone.attractor = Missile_CreateAttractorEnt(drone, attract_strength, attract_range);
  drone.stunned = false;

  drone thread carepackageDrone_watchDeath();
  drone thread carepackageDrone_watchOwnerLoss();
  drone thread carePackageDrone_watchRoundEnd();
}

carepackageDrone_deleteOnActivate() {
  self endon("death");

  owner = self.owner;

  self.usableEnt waittill("trigger");

  self carepackageDrone_Delete();
}

carepackageDrone_watchDeath() {
  level endon("game_ended");
  self endon("gone");

  self waittill("death");

  if(!isDefined(self)) {
    return;
  }

  carepackageDrone_leave();
}

carepackageDrone_watchOwnerLoss() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");

  self.owner waittill_any("disconnect", "joined_team", "joined_spectators");

  self notify("owner_gone");

  self thread carepackageDrone_leave();
}

carePackageDrone_watchRoundEnd() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self endon("owner_gone");

  level waittill_any("round_end_finished", "game_ended");

  self thread carepackageDrone_leave();
}

carepackageDrone_leave() {
  self endon("death");
  self notify("leaving");

  carepackageDrone_explode();
}

carepackageDrone_explode() {
  if(isDefined(level.carepackageDrone.fxId_explode)) {
    playFX(level.carepackageDrone.fxId_explode, self.origin);
  }

  if(isDefined(level.carepackageDrone.sound_explode)) {
    self playSound(level.carepackageDrone.sound_explode);
  }

  if(isDefined(self.usableEnt)) {
    self.usableEnt makeGloballyUnusableByType();
    self.usableEnt Delete();
  }

  self notify("explode");

  self carepackageDrone_remove();
}

carepackageDrone_Delete() {
  if(isDefined(self.usableEnt)) {
    self.usableEnt makeGloballyUnusableByType();
    self.usableEnt Delete();
  }

  self notify("explode");

  self carepackageDrone_remove();
}

carepackageDrone_remove() {
  decrementFauxVehicleCount();

  self Delete();
}

addToCarepackageDroneList() {
  level.carepackageDrones[level.carepackageDrones.size] = self;
}

removeFromCarepackageDroneListOnDeath() {
  entNum = self GetEntityNumber();

  self waittill("death");

  level.carepackageDrones = array_remove(level.carepackageDrones, self);
}