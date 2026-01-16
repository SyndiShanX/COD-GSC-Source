/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\systems\init.gsc
*************************************************/

#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\systems\debug;
#using scripts\shared\ai\systems\shared;
#using scripts\shared\ai\systems\weaponlist;
#using scripts\shared\gameskill_shared;
#using scripts\shared\name_shared;
#using scripts\shared\util_shared;
#using_animtree("generic");
#namespace init;

function initweapon(weapon) {
  self.weaponinfo[weapon.name] = spawnstruct();
  self.weaponinfo[weapon.name].position = "none";
  self.weaponinfo[weapon.name].hasclip = 1;
  if(isdefined(weapon.clipmodel)) {
    self.weaponinfo[weapon.name].useclip = 1;
  } else {
    self.weaponinfo[weapon.name].useclip = 0;
  }
}

function main() {
  self.a = spawnstruct();
  self.a.weaponpos = [];
  if(self.weapon == level.weaponnone) {
    self aiutility::setcurrentweapon(level.weaponnone);
  }
  self aiutility::setprimaryweapon(self.weapon);
  if(self.secondaryweapon == level.weaponnone) {
    self aiutility::setsecondaryweapon(level.weaponnone);
  }
  self aiutility::setsecondaryweapon(self.secondaryweapon);
  self aiutility::setcurrentweapon(self.primaryweapon);
  self.initial_primaryweapon = self.primaryweapon;
  self.initial_secondaryweapon = self.secondaryweapon;
  self initweapon(self.primaryweapon);
  self initweapon(self.secondaryweapon);
  self initweapon(self.sidearm);
  self.weapon_positions = array("left", "right", "chest", "back");
  for (i = 0; i < self.weapon_positions.size; i++) {
    self.a.weaponpos[self.weapon_positions[i]] = level.weaponnone;
  }
  self.lastweapon = self.weapon;
  self thread begingrenadetracking();
  self thread globalgrenadetracking();
  firstinit();
  self.a.rockets = 3;
  self.a.rocketvisible = 1;
  self.a.pose = "stand";
  self.a.prevpose = self.a.pose;
  self.a.movement = "stop";
  self.a.special = "none";
  self.a.gunhand = "none";
  shared::placeweaponon(self.primaryweapon, "right");
  if(isdefined(self.secondaryweaponclass) && self.secondaryweaponclass != "none" && self.secondaryweaponclass != "pistol") {
    shared::placeweaponon(self.secondaryweapon, "back");
  }
  self.a.combatendtime = gettime();
  self.a.nextgrenadetrytime = 0;
  self.a.isaiming = 0;
  self.rightaimlimit = 45;
  self.leftaimlimit = -45;
  self.upaimlimit = 45;
  self.downaimlimit = -45;
  self.walk = 0;
  self.sprint = 0;
  self.a.postscriptfunc = undefined;
  self.baseaccuracy = self.accuracy;
  if(!isdefined(self.script_accuracy)) {
    self.script_accuracy = 1;
  }
  if(self.team == "axis" || self.team == "team3") {
    self thread gameskill::axisaccuracycontrol();
  } else if(self.team == "allies") {
    self thread gameskill::alliesaccuracycontrol();
  }
  self.a.misstime = 0;
  self.bulletsinclip = self.weapon.clipsize;
  self.lastenemysighttime = 0;
  self.combattime = 0;
  self.suppressed = 0;
  self.suppressedtime = 0;
  if(self.team == "allies") {
    self.suppressionthreshold = 0.75;
  } else {
    self.suppressionthreshold = 0.5;
  }
  if(self.team == "allies") {
    self.randomgrenaderange = 0;
  } else {
    self.randomgrenaderange = 128;
  }
  self.reacquire_state = 0;
}

function setnameandrank() {
  self endon("death");
  self name::get();
}

function donothing() {}

function set_anim_playback_rate() {
  self.animplaybackrate = 0.9 + randomfloat(0.2);
  self.moveplaybackrate = 1;
}

function trackvelocity() {
  self endon("death");
  for (;;) {
    self.oldorigin = self.origin;
    wait(0.2);
  }
}

function checkapproachangles(transtypes) {
  idealtransangles[1] = 45;
  idealtransangles[2] = 0;
  idealtransangles[3] = -45;
  idealtransangles[4] = 90;
  idealtransangles[6] = -90;
  idealtransangles[7] = 135;
  idealtransangles[8] = 180;
  idealtransangles[9] = -135;
  wait(0.05);
  for (i = 1; i <= 9; i++) {
    for (j = 0; j < transtypes.size; j++) {
      trans = transtypes[j];
      idealadd = 0;
      if(trans == "" || trans == "") {
        idealadd = 90;
      } else if(trans == "" || trans == "") {
        idealadd = -90;
      }
      if(isdefined(anim.covertransangles[trans][i])) {
        correctangle = angleclamp180(idealtransangles[i] + idealadd);
        actualangle = angleclamp180(anim.covertransangles[trans][i]);
        if((absangleclamp180(actualangle - correctangle)) > 7) {
          println(((((((("" + trans) + "") + i) + "") + actualangle) + "") + correctangle) + "");
        }
      }
    }
  }
  for (i = 1; i <= 9; i++) {
    for (j = 0; j < transtypes.size; j++) {
      trans = transtypes[j];
      idealadd = 0;
      if(trans == "" || trans == "") {
        idealadd = 90;
      } else if(trans == "" || trans == "") {
        idealadd = -90;
      }
      if(isdefined(anim.coverexitangles[trans][i])) {
        correctangle = angleclamp180(-1 * ((idealtransangles[i] + idealadd) + 180));
        actualangle = angleclamp180(anim.coverexitangles[trans][i]);
        if((absangleclamp180(actualangle - correctangle)) > 7) {
          println(((((((("" + trans) + "") + i) + "") + actualangle) + "") + correctangle) + "");
        }
      }
    }
  }
}

function getexitsplittime(approachtype, dir) {
  return anim.coverexitsplit[approachtype][dir];
}

function gettranssplittime(approachtype, dir) {
  return anim.covertranssplit[approachtype][dir];
}

function firstinit() {
  if(isdefined(anim.notfirsttime)) {
    return;
  }
  anim.notfirsttime = 1;
  anim.grenadetimers["player_frag_grenade_sp"] = randomintrange(1000, 20000);
  anim.grenadetimers["player_flash_grenade_sp"] = randomintrange(1000, 20000);
  anim.grenadetimers["player_double_grenade"] = randomintrange(10000, 60000);
  anim.grenadetimers["AI_frag_grenade_sp"] = randomintrange(0, 20000);
  anim.grenadetimers["AI_flash_grenade_sp"] = randomintrange(0, 20000);
  anim.numgrenadesinprogresstowardsplayer = 0;
  anim.lastgrenadelandednearplayertime = -1000000;
  anim.lastfraggrenadetoplayerstart = -1000000;
  thread setnextplayergrenadetime();
  if(!isdefined(level.flag)) {
    level.flag = [];
  }
  level.painai = undefined;
  anim.covercrouchleanpitch = -55;
}

function onplayerconnect() {
  player = self;
  firstinit();
  player.invul = 0;
}

function setnextplayergrenadetime() {
  waittillframeend();
  if(isdefined(anim.playergrenaderangetime)) {
    maxtime = int(anim.playergrenaderangetime * 0.7);
    if(maxtime < 1) {
      maxtime = 1;
    }
    anim.grenadetimers["player_frag_grenade_sp"] = randomintrange(0, maxtime);
    anim.grenadetimers["player_flash_grenade_sp"] = randomintrange(0, maxtime);
  }
  if(isdefined(anim.playerdoublegrenadetime)) {
    maxtime = int(anim.playerdoublegrenadetime);
    mintime = int(maxtime / 2);
    if(maxtime <= mintime) {
      maxtime = mintime + 1;
    }
    anim.grenadetimers["player_double_grenade"] = randomintrange(mintime, maxtime);
  }
}

function addtomissiles(grenade) {
  if(!isdefined(level.missileentities)) {
    level.missileentities = [];
  }
  if(!isdefined(level.missileentities)) {
    level.missileentities = [];
  } else if(!isarray(level.missileentities)) {
    level.missileentities = array(level.missileentities);
  }
  level.missileentities[level.missileentities.size] = grenade;
  while (isdefined(grenade)) {
    wait(0.05);
  }
  arrayremovevalue(level.missileentities, grenade);
}

function globalgrenadetracking() {
  if(!isdefined(level.missileentities)) {
    level.missileentities = [];
  }
  self endon("death");
  self thread globalgrenadelaunchertracking();
  self thread globalmissiletracking();
  for (;;) {
    self waittill("grenade_fire", grenade, weapon);
    grenade.owner = self;
    grenade.weapon = weapon;
    level thread addtomissiles(grenade);
  }
}

function globalgrenadelaunchertracking() {
  self endon("death");
  for (;;) {
    self waittill("grenade_launcher_fire", grenade, weapon);
    grenade.owner = self;
    grenade.weapon = weapon;
    level thread addtomissiles(grenade);
  }
}

function globalmissiletracking() {
  self endon("death");
  for (;;) {
    self waittill("missile_fire", grenade, weapon);
    grenade.owner = self;
    grenade.weapon = weapon;
    level thread addtomissiles(grenade);
  }
}

function begingrenadetracking() {
  self endon("death");
  for (;;) {
    self waittill("grenade_fire", grenade, weapon);
    grenade thread grenade_earthquake();
  }
}

function endondeath() {
  self waittill("death");
  waittillframeend();
  self notify("end_explode");
}

function grenade_earthquake() {
  self thread endondeath();
  self endon("end_explode");
  self waittill("explode", position);
  playrumbleonposition("grenade_rumble", position);
  earthquake(0.3, 0.5, position, 400);
}

function end_script() {}