/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42942.gsc
**************************************/

init() {
  level.carepackagedrone = spawnStruct();
  level.carepackagedrone.health = 999999;
  level.carepackagedrone.maxhealth = 200;
  level.carepackagedrone.fxid_explode = loadfx("vfx/explosion/tracking_drone_explosion");
  level.carepackagedrone.sound_explode = "veh_tracking_drone_explode";
  level.carepackagedrone.releasestring = &"KILLSTREAKS_DRONE_CAREPACKAGE_RELEASE";
  level.carepackagedrones = [];
}

setupcarepackagedrone(var_0, var_1) {
  var_0 common_scripts\utility::make_entity_sentient_mp(self.team);
  var_0 makevehiclenotcollidewithplayers(1);
  var_0 addtocarepackagedronelist();
  var_0 thread removefromcarepackagedronelistondeath();
  var_0.health = level.carepackagedrone.health;
  var_0.maxhealth = level.carepackagedrone.maxhealth;
  var_0.damagetaken = 0;
  var_0.speed = 15;
  var_0.followspeed = 15;
  var_0.owner = self;
  var_0.team = self.team;
  var_0 vehicle_setspeed(var_0.speed, 10, 10);
  var_0 setyawspeed(120, 90);
  var_0 setneargoalnotifydist(64);
  var_0 sethoverparams(4, 5, 5);
  var_0.fx_tag0 = "tag_body";

  if(var_1) {
    var_0.usableent = spawn("script_model", var_0.origin + (0, 0, 1));
    var_0.usableent setModel("tag_origin");
    var_0.usableent.owner = self;
    var_0.usableent maps\mp\_utility::makegloballyusablebytype("killstreakRemote", level.carepackagedrone.releasestring, self);
  }

  var_2 = 45;
  var_3 = 45;
  var_0 setmaxpitchroll(var_2, var_3);
  var_4 = 10000;
  var_5 = 150;
  var_0.attractor = missile_createattractorent(var_0, var_4, var_5);
  var_0.stunned = 0;
  var_0 thread carepackagedrone_watchdeath();
  var_0 thread carepackagedrone_watchownerloss();
  var_0 thread carepackagedrone_watchroundend();
}

carepackagedrone_deleteonactivate() {
  self endon("death");
  var_0 = self.owner;
  self.usableent waittill("trigger");
  carepackagedrone_delete();
}

carepackagedrone_watchdeath() {
  level endon("game_ended");
  self endon("gone");
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  carepackagedrone_leave();
}

carepackagedrone_watchownerloss() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner common_scripts\utility::waittill_any("disconnect", "joined_team", "joined_spectators");
  self notify("owner_gone");
  thread carepackagedrone_leave();
}

carepackagedrone_watchroundend() {
  level endon("game_ended");
  self endon("death");
  self endon("leaving");
  self.owner endon("disconnect");
  self endon("owner_gone");
  level common_scripts\utility::waittill_any("round_end_finished", "game_ended");
  thread carepackagedrone_leave();
}

carepackagedrone_leave() {
  self endon("death");
  self notify("leaving");
  carepackagedrone_explode();
}

carepackagedrone_explode() {
  if(isDefined(level.carepackagedrone.fxid_explode)) {
    playFX(level.carepackagedrone.fxid_explode, self.origin);
  }

  if(isDefined(level.carepackagedrone.sound_explode)) {
    self playSound(level.carepackagedrone.sound_explode);
  }

  if(isDefined(self.usableent)) {
    self.usableent maps\mp\_utility::makegloballyunusablebytype();
    self.usableent delete();
  }

  self notify("explode");
  carepackagedrone_remove();
}

carepackagedrone_delete() {
  if(isDefined(self.usableent)) {
    self.usableent maps\mp\_utility::makegloballyunusablebytype();
    self.usableent delete();
  }

  self notify("explode");
  carepackagedrone_remove();
}

carepackagedrone_remove() {
  maps\mp\_utility::decrementfauxvehiclecount();
  self delete();
}

addtocarepackagedronelist() {
  level.carepackagedrones[level.carepackagedrones.size] = self;
}

removefromcarepackagedronelistondeath() {
  var_0 = self getentitynumber();
  self waittill("death");
  level.carepackagedrones = common_scripts\utility::array_remove(level.carepackagedrones, self);
}