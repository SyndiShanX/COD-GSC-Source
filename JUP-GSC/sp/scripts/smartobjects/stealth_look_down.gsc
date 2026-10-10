/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\smartobjects\stealth_look_down.gsc
*********************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\smartobjects\utility;
#namespace stealth_look_down;

function main() {
  add_smartobject_type("stealth_look_down", &getinfo, &canusecondition);
}

function canusecondition(object) {
  if(!canusesmartobject_stealth(object)) {
    return false;
  }

  return true;
}

function getinfo() {
  struct = createsmartobjectinfo();
  struct.animstatename = "smartobject_look_down";
  struct addsmartobjectintroanim("enter_loop");
  struct addsmartobjectanim("loop");
  struct addsmartobjectoutroanim("exit_loop");
  struct addsmartobjectdeathanim("death");
  struct addsmartobjectreactanim();
  struct addsmartobjectpainanim();
  struct.radiussqrd = squared(400);
  struct.fninterrupt = &onenemy;
  struct.nextusetime = 60;
  return struct;
}

function onenemy() {
  if(!isDefined(self.enemy)) {
    return false;
  }

  return true;
}