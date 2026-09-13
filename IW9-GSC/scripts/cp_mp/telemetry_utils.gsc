/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\telemetry_utils.gsc
***********************************************/

_id_1C355F42FAF7F4BB() {
  _id_BED41D880242E6CD = [];
  teamhasuav = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "teamHasUAV"))
    teamhasuav = [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "teamHasUAV")]](self.team);

  _id_497A07FC95E86184 = undefined;
  _id_C50FFD3DDA50EBFC = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
    _id_497A07FC95E86184 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_quieter");
    _id_C50FFD3DDA50EBFC = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_bulletdamage");
  }

  if(istrue(teamhasuav))
    _id_BED41D880242E6CD[_id_BED41D880242E6CD.size] = "UAV_ACTIVE";

  if(istrue(_id_497A07FC95E86184))
    _id_BED41D880242E6CD[_id_BED41D880242E6CD.size] = "DEADSILENCE_ACTIVE";

  if(istrue(_id_C50FFD3DDA50EBFC))
    _id_BED41D880242E6CD[_id_BED41D880242E6CD.size] = "HAS_STOPPING_POWER";

  _id_6B7BEE46F2C6DA28 = gettime();
  enemyhascuav = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "enemyHasCUAV"))
    enemyhascuav = [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "enemyHasCUAV")]](self.team);

  ismarked = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "helper_drone_isTargetMarked"))
    ismarked = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "helper_drone_isTargetMarked")]]();

  isflashed = istrue(self.flashbanged);
  isstunned = istrue(self.concussiongrenadefx);
  _id_6FD2D9A208CEF69B = isDefined(self.gastriggerstouching) && self.gastriggerstouching.size > 0 || isDefined(self.lastgastouchtime) && self.lastgastouchtime + 5000 > _id_6B7BEE46F2C6DA28;
  _id_96A6AE39774BE3DD = isDefined(self.burninginfo) || isDefined(self.lastburntime) && self.lastburntime + 5000 > _id_6B7BEE46F2C6DA28;
  _id_DB1EE1676A83E16E = isDefined(self.lastsnapshotgrenadetime) && self.lastsnapshotgrenadetime + 5000 > _id_6B7BEE46F2C6DA28;
  _id_B3447ABBB40EBFAB = isDefined(self.lastinsmoketime) && self.lastinsmoketime + 5000 > _id_6B7BEE46F2C6DA28;
  _id_DF9D4533B4C32B50 = istrue(self.empcount);
  _id_2CA1CC391A5049B1 = istrue(self.wphealthblock);
  baseweapon = undefined;

  if(isDefined(self.lastweaponused)) {
    currentweapon = self.lastweaponused;
    baseweapon = getweaponbasename(currentweapon);
  }

  if(istrue(enemyhascuav))
    _id_BED41D880242E6CD[_id_BED41D880242E6CD.size] = "CUAV_ACTIVE";

  if(istrue(ismarked))
    _id_BED41D880242E6CD[_id_BED41D880242E6CD.size] = "IS_MARKED";

  if(istrue(isflashed))
    _id_BED41D880242E6CD[_id_BED41D880242E6CD.size] = "IS_FLASHED";

  if(istrue(isstunned))
    _id_BED41D880242E6CD[_id_BED41D880242E6CD.size] = "IS_STUNNED";

  if(istrue(_id_6FD2D9A208CEF69B))
    _id_BED41D880242E6CD[_id_BED41D880242E6CD.size] = "IN_GAS";

  if(istrue(_id_96A6AE39774BE3DD))
    _id_BED41D880242E6CD[_id_BED41D880242E6CD.size] = "IN_BURNING";

  if(istrue(_id_DB1EE1676A83E16E))
    _id_BED41D880242E6CD[_id_BED41D880242E6CD.size] = "IS_SNAPSHOTTED";

  if(istrue(_id_B3447ABBB40EBFAB))
    _id_BED41D880242E6CD[_id_BED41D880242E6CD.size] = "IN_SMOKE";

  if(istrue(_id_DF9D4533B4C32B50))
    _id_BED41D880242E6CD[_id_BED41D880242E6CD.size] = "IS_EMPED";

  if(istrue(_id_2CA1CC391A5049B1))
    _id_BED41D880242E6CD[_id_BED41D880242E6CD.size] = "IN_WHITE_PHOSPHOROUS";

  if(self isnightvisionon())
    _id_BED41D880242E6CD[_id_BED41D880242E6CD.size] = "NVG_ENABLED";

  if(isDefined(self.modifiers)) {
    if(istrue(self.modifiers["headshot"]))
      _id_BED41D880242E6CD[_id_BED41D880242E6CD.size] = "HEADSHOT";

    if(istrue(self.modifiers["avenger"]))
      _id_BED41D880242E6CD[_id_BED41D880242E6CD.size] = "AVENGER";

    if(istrue(self.modifiers["defender"]))
      _id_BED41D880242E6CD[_id_BED41D880242E6CD.size] = "DEFENDER";

    if(istrue(self.modifiers["posthumous"]))
      _id_BED41D880242E6CD[_id_BED41D880242E6CD.size] = "POSTHUMOUS";

    if(istrue(self.modifiers["revenge"]))
      _id_BED41D880242E6CD[_id_BED41D880242E6CD.size] = "REVENGE";

    if(istrue(self.modifiers["buzzkill"]))
      _id_BED41D880242E6CD[_id_BED41D880242E6CD.size] = "BUZZKILL";

    if(istrue(self.modifiers["firstblood"]))
      _id_BED41D880242E6CD[_id_BED41D880242E6CD.size] = "FIRSTBLOOD";

    if(istrue(self.modifiers["comeback"]))
      _id_BED41D880242E6CD[_id_BED41D880242E6CD.size] = "COMEBACK";

    if(istrue(self.modifiers["longshot"]))
      _id_BED41D880242E6CD[_id_BED41D880242E6CD.size] = "LONGSHOT";

    if(istrue(self.modifiers["pointblank"]))
      _id_BED41D880242E6CD[_id_BED41D880242E6CD.size] = "POINTBLANK";

    if(istrue(self.modifiers["assistedsuicide"]))
      _id_BED41D880242E6CD[_id_BED41D880242E6CD.size] = "ASSISTED_SUICIDE";

    if(isDefined(baseweapon) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "isKillstreakWeapon") && istrue([[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "isKillstreakWeapon")]](baseweapon)))
      _id_BED41D880242E6CD[_id_BED41D880242E6CD.size] = "KILLSTREAK";
  }

  return _id_BED41D880242E6CD;
}