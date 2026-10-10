/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\equipment\thermite.gsc
************************************************/

#using scripts\sp\equipment\offhands;
#using scripts\sp\utility;
#namespace thermite;

function precache(offhand) {
  registeroffhandfirefunc(offhand, &function_e4f132e4caa48e7e);
}

function function_e4f132e4caa48e7e(grenade, weapon) {
  grenade endon("thermite_deleted");
  thread thermite_used(grenade);
  grenade thread notifyondelete();
}

function notifyondelete() {
  self endon("explode");

  while(isDefined(self)) {
    wait 0.05;
  }

  self notify("thermite_deleted");
}

function thermite_used(grenade, isgl) {
  if(isDefined(isgl)) {}

  grenade thread thermite_watchstuck(isgl);
}

function thermite_watchstuck(isgl) {
  self endon("death");
  stuckto = undefined;
  self waittill("missile_stuck", stuckto);
  weaponobj = scripts\sp\utility::make_weapon("thermite_sp");
  thread thermite_watchstucktoterrain();
  self setscriptablepartstate("effects", "impact", 0);
  thermite_doradiusdamage(weaponobj);
  wait 0.5;
  ticks = 1;

  while(ticks <= 10) {
    curtick = ticks + 1;

    if(mod(curtick, 2) > 0) {
      thermite_doradiusdamage(weaponobj);
    } else {
      thermite_doradiusdamage(weaponobj);
    }

    ticks = curtick;
    wait 0.5;
  }

  thread thermite_destroy();
}

function thermite_watchstucktoterrain() {
  self endon("death");
  stuckto = self getlinkedparent();

  while(isDefined(stuckto)) {
    self waittill("missile_stuck", stuckto);
  }

  self.badplace = createnavbadplacebybounds(self.origin, (125, 125, 125), (0, 0, 0));
}

function thermite_doradiusdamage(weaponobj) {
  radius = 125;
  innerdamage = 25;
  outerdamage = 10;
  meansofdeath = "MOD_FIRE";

  if(weaponobj.basename == "thermite_sp") {
    radius = 125;
    innerdamage = 30;
    outerdamage = 30;
  }

  self radiusdamage(self.origin, radius, innerdamage, outerdamage, self.owner, meansofdeath, weaponobj);
}

function thermite_destroy() {
  self setscriptablepartstate("effects", "burnEnd", 0);
  thread thermite_delete(5);
}

function thermite_delete(deletiondelay) {
  self notify("death");
  self.exploding = 1;

  if(isDefined(self.badplace)) {
    destroynavobstacle(self.badplace);
    self.badplace = undefined;
  }

  self forcehidegrenadehudwarning(1);

  if(isDefined(deletiondelay)) {
    wait deletiondelay;
  }

  self delete();
}

function mod(dividend, divisor) {
  q = int(dividend / divisor);

  if(dividend * divisor < 0) {
    q -= 1;
  }

  return dividend - q * divisor;
}