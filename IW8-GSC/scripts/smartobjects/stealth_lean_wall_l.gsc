/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\smartobjects\stealth_lean_wall_l.gsc
********************************************************/

function main() {
  scripts\smartobjects\utility::add_smartobject_type("stealth_lean_wall_l", &getinfo, &canusecondition);
}

function canusecondition(var0) {
  if(!scripts\smartobjects\utility::canusesmartobject_stealth(var0)) {
    return false;
  }

  if(!scripts\smartobjects\utility::canusesmartobject_nostrafenoturn(var0)) {
    return false;
  }

  return true;
}

function getinfo() {
  var0 = scripts\smartobjects\utility::createsmartobjectinfo();
  var0.animstatename = "smartobject_lean_wall_l";
  var0 scripts\smartobjects\utility::addsmartobjectanim("loop");
  var0 scripts\smartobjects\utility::addsmartobjectintroanim("enter_loop");
  var0 scripts\smartobjects\utility::addsmartobjectoutroanim("exit_loop");
  var0 scripts\smartobjects\utility::addsmartobjectreactanim();
  var0.radiussqrd = squared(400);
  var0.fninterrupt = &onenemy;
  var0.nextusetime = 60;
  return var0;
}

function onenemy() {
  if(!isDefined(self.enemy)) {
    return false;
  }

  return true;
}