/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\smartobjects\stealth_knock_off_30.gsc
*********************************************************/

function main() {
  scripts\smartobjects\utility::add_smartobject_type("stealth_knock_off_30", &getinfo, &canusecondition);
}

function canusecondition(var0) {
  if(!scripts\smartobjects\utility::canusesmartobject_stealth(var0)) {
    return false;
  }

  return true;
}

function getinfo() {
  var0 = scripts\smartobjects\utility::createsmartobjectinfo();
  var0.animstatename = "smartobject_knock_off_30";
  var0 scripts\smartobjects\utility::addsmartobjectanim("loop");
  var0.fnnotetrackhandle = &notetrackhandle;
  var0 scripts\smartobjects\utility::addsmartobjectintroanim("enter_loop");
  var0 scripts\smartobjects\utility::addsmartobjectoutroanim("exit_loop");
  var0 scripts\smartobjects\utility::addsmartobjectdeathanim("death");
  var0 scripts\smartobjects\utility::addsmartobjectreactanim();
  var0 scripts\smartobjects\utility::addsmartobjectpainanim();
  var0.radiussqrd = squared(400);
  var0.fninterrupt = &onenemy;
  var0.useonce = 1;
  var0.fnonuse = &onuse;
  var0.fngetprioritymultiplier = &getprioritymultiplier;
  return var0;
}

function notetrackhandle(var0) {
  if(isDefined(self.smartobjectnotetrackhandle)) {
    [[self.smartobjectnotetrackhandle]](var0);
    return;
  }
}

function onenemy() {
  if(!isDefined(self.enemy)) {
    return false;
  }

  return true;
}

function onuse(var0) {
  level notify("knock_off", var0);
}

function getprioritymultiplier(var0) {
  if(isDefined(var0.prioritymultiplier)) {
    return var0.prioritymultiplier;
  }

  return 1;
}