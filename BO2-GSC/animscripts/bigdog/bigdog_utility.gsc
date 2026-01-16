/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\bigdog\bigdog_utility.gsc
*************************************************/

#include animscripts\anims;
#include common_scripts\utility;
#include animscripts\debug;
#using_animtree("bigdog");

initanimtree(animscript) {
  self clearanim( % body, 0.3);
  self setanim( % body, 1, 0);
  assert(isDefined(animscript), "Animscript not specified in initAnimTree");
  self.a.prevscript = self.a.script;
  self.a.script = animscript;
  self.a.script_suffix = undefined;
  self animscripts\anims::clearanimcache();
}

initialize(animscript) {
  if(isDefined(self.a.script) && !self animscripts\debug::debugshouldclearstate())
    self animscripts\debug::debugpopstate(self.a.script);
  else
    self animscripts\debug::debugclearstate();

  self animscripts\debug::debugpushstate(animscript);

  self.a.scriptstarttime = gettime();
  initanimtree(animscript);
}

fire_grenade_at_target(target) {
  scriptedenemy = self.scriptenemy;
  self setentitytarget(target);
  self.grenadeammo = 1;
  self waittill("grenade_fire");
  self.grenadeammo = 0;

  if(isDefined(scriptedenemy))
    self setentitytarget(target);
  else
    self clearentitytarget();
}

setactivegrenadetimer(throwingat) {
  if(isplayer(throwingat))
    self.activegrenadetimer = "player_frag_grenade_sp";
  else
    self.activegrenadetimer = "AI_frag_grenade_sp";

  if(!isDefined(anim.grenadetimers[self.activegrenadetimer]))
    anim.grenadetimers[self.activegrenadetimer] = randomintrange(1000, 20000);
}

animsuffix() {
  animsuffix = "";

  if(isDefined(self.missinglegs["FR"]) && isDefined(self.missinglegs["FL"]) && isDefined(self.missinglegs["RL"]) && isDefined(self.missinglegs["RR"]))
    animsuffix = "_all_legs";
  else if(isDefined(self.missinglegs["FR"]) && isDefined(self.missinglegs["FL"]))
    animsuffix = "_frontlegs";
  else if(isDefined(self.missinglegs["FR"]) && isDefined(self.missinglegs["RL"]))
    animsuffix = "_fr_rl";
  else if(isDefined(self.missinglegs["FL"]) && isDefined(self.missinglegs["RR"]))
    animsuffix = "_fl_rr";
  else if(isDefined(self.missinglegs["RR"]) && isDefined(self.missinglegs["RL"]))
    animsuffix = "_rearlegs";
  else if(isDefined(self.missinglegs["FL"]) && isDefined(self.missinglegs["RL"]))
    animsuffix = "_leftlegs";
  else if(isDefined(self.missinglegs["FR"]) && isDefined(self.missinglegs["RR"]))
    animsuffix = "_rightlegs";
  else if(isDefined(self.missinglegs["FR"]))
    animsuffix = "_frontright";
  else if(isDefined(self.missinglegs["FL"]))
    animsuffix = "_frontleft";
  else if(isDefined(self.missinglegs["RR"]))
    animsuffix = "_rearright";
  else if(isDefined(self.missinglegs["RL"]))
    animsuffix = "_rearleft";

  return animsuffix;
}

wasdamagedbyempgrenade(weapon, meansofdeath) {
  return issubstr(weapon, "emp_grenade") && meansofdeath != "MOD_IMPACT";
}

bigdog_isemped() {
  return isDefined(self.a.empedendtime) && gettime() <= self.a.empedendtime;
}

wasdamagedbychargedsnipershot() {
  weaponchargeable = isDefined(self.damageweapon) && ischargedshotsniperrifle(self.damageweapon);
  weaponischarged = weaponchargeable && isDefined(self.attacker) && isDefined(self.attacker.chargeshotlevel) && self.attacker.chargeshotlevel >= 2;

  if(weaponchargeable && weaponischarged)
    return true;

  return false;
}

wasdamagedbyfullychargedsnipershot() {
  weaponchargeable = isDefined(self.damageweapon) && ischargedshotsniperrifle(self.damageweapon);
  weaponischarged = weaponchargeable && isDefined(self.attacker) && isDefined(self.attacker.chargeshotlevel) && self.attacker.chargeshotlevel >= 3;

  if(weaponchargeable && weaponischarged)
    return true;

  return false;
}

ischargedshotsniperrifle(weapon) {
  return weaponischargeshot(weapon) && weaponissniperweapon(weapon);
}

wasdamagedbysnipershot() {
  return isDefined(self.damageweapon) && weaponissniperweapon(self.damageweapon);
}