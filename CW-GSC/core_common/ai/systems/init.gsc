/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\init.gsc
***********************************************/

#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\shared;
#namespace init;

function initweapon(weapon) {
  self.weaponinfo[weapon.name] = spawnStruct();
  self.weaponinfo[weapon.name].position = "none";
  self.weaponinfo[weapon.name].hasclip = 1;

  if(isDefined(weapon.clipmodel)) {
    self.weaponinfo[weapon.name].useclip = 1;
    return;
  }

  self.weaponinfo[weapon.name].useclip = 0;
}

function main() {
  self.a = spawnStruct();
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

  for(i = 0; i < self.weapon_positions.size; i++) {
    self.a.weaponpos[self.weapon_positions[i]] = level.weaponnone;
  }

  self.lastweapon = self.weapon;
  self.a.rockets = 3;
  self.a.rocketvisible = 1;
  self.a.pose = "stand";
  self.a.prevpose = self.a.pose;
  self.a.movement = "stop";
  self.a.special = "none";
  self.a.gunhand = "none";
  shared::placeweaponon(self.primaryweapon, "right");

  if(isDefined(self.secondaryweaponclass) && self.secondaryweaponclass != "none" && self.secondaryweaponclass != "pistol") {
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

  if(!isDefined(self.script_accuracy)) {
    self.script_accuracy = 1;
  }

  self.a.misstime = 0;

  if(isactor(self)) {
    self.bulletsinclip = self.weapon.clipsize;
  } else {
    self.ai.bulletsinclip = self.weapon.clipsize;
  }

  self.lastenemysighttime = 0;
  self.combattime = 0;
  self.var_4a68f84b = 0.75;
  self.randomgrenaderange = 128;
  self.reacquire_state = 0;
}

function addtomissiles(grenade) {
  if(!isDefined(level.missileentities)) {
    level.missileentities = [];
  }

  if(!isDefined(level.missileentities)) {
    level.missileentities = [];
  } else if(!isarray(level.missileentities)) {
    level.missileentities = array(level.missileentities);
  }

  level.missileentities[level.missileentities.size] = grenade;

  if(isDefined(grenade)) {
    grenade waittill(#"death");
  }

  arrayremovevalue(level.missileentities, grenade);
}

function event_handler[grenade_fire] function_960adbea(eventstruct) {
  grenade = eventstruct.projectile;
  weapon = eventstruct.weapon;

  if(isDefined(grenade)) {
    grenade.owner = self;
    grenade.weapon = weapon;
    level thread addtomissiles(grenade);
  }
}

function event_handler[grenade_launcher_fire] function_c6ddaa47(eventstruct) {
  eventstruct.projectile.owner = self;
  eventstruct.projectile.weapon = eventstruct.weapon;
  level thread addtomissiles(eventstruct.projectile);
}

function event_handler[missile_fire] function_596d3a28(eventstruct) {
  eventstruct.projectile.owner = self;
  eventstruct.projectile.weapon = eventstruct.weapon;
  level thread addtomissiles(eventstruct.projectile);
}

function end_script() {}