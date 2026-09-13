/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\circle_peek.gsc
**************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("circle_peek", ::_id_B1E60C0EC801B93B, undefined, ::_id_7023D0A9E3E7C419);
  _id_D653377138D5EFF2 = "circle_peak";
  game["dialog"]["use_circle_peek"] = _id_D653377138D5EFF2 + "_use";
  game["dialog"]["timeout_circle_peek"] = _id_D653377138D5EFF2 + "_timeout";
}

weapongivenchoppergunner(streakinfo) {
  return 1;
}

_id_36D2EB075443F6CA() {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("circle_peek", self);
  return _id_B1E60C0EC801B93B(streakinfo);
}

_id_7023D0A9E3E7C419() {
  streakinfo = scripts\cp_mp\utility\killstreak_utility::createstreakinfo("circle_peek", self);
  streakinfo.skipequippedstreakcheck = 1;
  return _id_B1E60C0EC801B93B(streakinfo, 1);
}

_id_B1E60C0EC801B93B(streakinfo, _id_1CA10FE3AE6B2083) {
  self endon("disconnect");
  level endon("game_ended");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo))
      return 0;
  }

  if(!istrue(_id_1CA10FE3AE6B2083)) {
    deployweaponobj = makeweapon("ks_gesture_generic_mp");
    _id_9B1DEB5E9D32BBE3 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(streakinfo, deployweaponobj);

    if(!istrue(_id_9B1DEB5E9D32BBE3))
      return 0;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo))
      return 0;
  }

  result = _id_F93DF988A9F72F5C(streakinfo);

  if(!istrue(result))
    return result;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](streakinfo.streakname, self.origin);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_" + streakinfo.streakname, self);

  thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("circle_peek", "use_circle_peek", 1);

  if(istrue(_id_1CA10FE3AE6B2083))
    scripts\cp_mp\utility\killstreak_utility::playkillstreakusedialog(streakinfo.streakname);

  return 1;
}

_id_F93DF988A9F72F5C(streakinfo) {
  if(!isDefined(level.teamswithcirclepeek))
    return 0;

  if(!isDefined(level.br_circle.circleindex))
    return 0;

  if(!isDefined(level.teamswithcirclepeek[self.team]))
    level.teamswithcirclepeek[self.team] = 0;

  _id_2C18D9BE706D7AD7 = level.teamswithcirclepeek[self.team] + level.br_circle.circleindex + 1;

  for(_id_AC0E594AC96AA3A8 = _id_2C18D9BE706D7AD7; _id_AC0E594AC96AA3A8 < level.circlepeeks.size; _id_AC0E594AC96AA3A8++)
    _id_64ACB6CE534155B7::questrewardcirclepeek(self.team);

  return 1;
}