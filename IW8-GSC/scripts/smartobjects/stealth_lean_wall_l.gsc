/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\smartobjects\stealth_lean_wall_l.gsc
********************************************************/

function main() {
  scripts\smartobjects\utility::add_smartobject_type("stealth_lean_wall_l", &getinfo, &canusecondition);
}

function canusecondition(var_0) {
  if(!scripts\smartobjects\utility::canusesmartobject_stealth(var_0)) {
    return false;
  }

  if(!scripts\smartobjects\utility::canusesmartobject_nostrafenoturn(var_0)) {
    return false;
  }

  return true;
}

function getinfo() {
  var_0 = scripts\smartobjects\utility::createsmartobjectinfo();
  var_0.animstatename = "smartobject_lean_wall_l";
  var_0 scripts\smartobjects\utility::addsmartobjectanim("loop");
  var_0 scripts\smartobjects\utility::addsmartobjectintroanim("enter_loop");
  var_0 scripts\smartobjects\utility::addsmartobjectoutroanim("exit_loop");
  var_0 scripts\smartobjects\utility::addsmartobjectreactanim();
  var_0.radiussqrd = squared(400);
  var_0.fninterrupt = &onenemy;
  var_0.nextusetime = 60;
  return var_0;
}

function onenemy() {
  if(!isDefined(self.enemy)) {
    return false;
  }

  return true;
}