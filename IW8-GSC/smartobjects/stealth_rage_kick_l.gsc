/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: smartobjects\stealth_rage_kick_l.gsc
************************************************/

main() {
  scripts\smartobjects\utility::add_smartobject_type("stealth_rage_kick_l", ::getinfo, ::canusecondition);
}

canusecondition(var_0) {
  if(!scripts\smartobjects\utility::canusesmartobject_stealth(var_0))
    return 0;

  if(!scripts\smartobjects\utility::canusesmartobject_nostrafenoturn(var_0))
    return 0;

  return 1;
}

getinfo() {
  var_0 = scripts\smartobjects\utility::createsmartobjectinfo();
  var_0.animstatename = "smartobject_rage_kick_l";
  var_0 scripts\smartobjects\utility::addsmartobjectanim("loop");
  var_0 scripts\smartobjects\utility::addsmartobjectintroanim("enter_loop");
  var_0 scripts\smartobjects\utility::addsmartobjectoutroanim("exit_loop");
  var_0 scripts\smartobjects\utility::addsmartobjectreactanim();
  var_0.radiussqrd = squared(400);
  var_0.fnnotetrackhandle = ::notetrackhandle;
  var_0.fninterrupt = ::onenemy;
  var_0.nextusetime = 60;
  var_0.fngetprioritymultiplier = ::getprioritymultiplier;
  return var_0;
}

notetrackhandle(var_0) {
  if(isDefined(self.smartobjectnotetrackhandle))
    [[self.smartobjectnotetrackhandle]](var_0);
}

onenemy() {
  if(!isDefined(self.enemy))
    return 0;

  return 1;
}

getprioritymultiplier(var_0) {
  if(isDefined(var_0.prioritymultiplier))
    return var_0.prioritymultiplier;

  return 1;
}