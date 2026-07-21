/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: smartobjects\stealth_look_under_30.gsc
**************************************************/

main() {
  scripts\smartobjects\utility::add_smartobject_type("stealth_look_under_30", ::getinfo, ::canusecondition);
}

canusecondition(var_0) {
  if(!scripts\smartobjects\utility::canusesmartobject_stealth(var_0))
    return 0;

  return 1;
}

getinfo() {
  var_0 = scripts\smartobjects\utility::createsmartobjectinfo();
  var_0.animstatename = "smartobject_look_under_30";
  var_0 scripts\smartobjects\utility::addsmartobjectanim("loop");
  var_0 scripts\smartobjects\utility::addsmartobjectintroanim("enter_loop");
  var_0 scripts\smartobjects\utility::addsmartobjectoutroanim("exit_loop");
  var_0 scripts\smartobjects\utility::addsmartobjectdeathanim("death");
  var_0 scripts\smartobjects\utility::addsmartobjectreactanim();
  var_0 scripts\smartobjects\utility::addsmartobjectpainanim();
  var_0.radiussqrd = squared(400);
  var_0.fninterrupt = ::onenemy;
  var_0.nextusetime = 60;
  return var_0;
}

onenemy() {
  if(!isDefined(self.enemy))
    return 0;

  return 1;
}