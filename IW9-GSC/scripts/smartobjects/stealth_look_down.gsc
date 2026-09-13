/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\smartobjects\stealth_look_down.gsc
******************************************************/

main() {
  scripts\smartobjects\utility::add_smartobject_type("stealth_look_down", ::getinfo, ::canusecondition);
}

canusecondition(object) {
  if(!scripts\smartobjects\utility::canusesmartobject_stealth(object))
    return 0;

  return 1;
}

getinfo() {
  struct = scripts\smartobjects\utility::createsmartobjectinfo();
  struct.animstatename = "smartobject_look_down";
  struct scripts\smartobjects\utility::addsmartobjectintroanim("enter_loop");
  struct scripts\smartobjects\utility::addsmartobjectanim("loop");
  struct scripts\smartobjects\utility::addsmartobjectoutroanim("exit_loop");
  struct scripts\smartobjects\utility::addsmartobjectdeathanim("death");
  struct scripts\smartobjects\utility::addsmartobjectreactanim();
  struct scripts\smartobjects\utility::addsmartobjectpainanim();
  struct.radiussqrd = squared(400);
  struct.fninterrupt = ::onenemy;
  struct.nextusetime = 60;
  return struct;
}

onenemy() {
  if(!isDefined(self.enemy))
    return 0;

  return 1;
}