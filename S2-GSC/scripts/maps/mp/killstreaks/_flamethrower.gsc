/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\killstreaks\_flamethrower.gsc
*********************************************************/

init() {
  level._id_5A61["flamethrower"] = ::_id_9E2D;
  level._id_5A7D["flamethrower_mp"] = "flamethrower";
  level._id_5A7D["flamethrower_german_mp"] = "flamethrower";
  level._id_5A7D["flamethrower_grenadier_mp"] = "flamethrower";
  level._id_5A7D["flamethrower_german_grenadier_mp"] = "flamethrower";
}

_id_9E2D(var_0) {
  var_1 = _id_9E2E();
  return var_1;
}

_id_9E2E() {
  if(maps\mp\_utility::isreallyalive(self)) {
    thread _id_9569();
    _id_0485::_id_5E9A("flamethrower", self.origin);
    return 1;
  } else
    return 0;
}

_id_9569() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self._id_267E)) {
    return;
  }
  var_0 = self._id_267E[3];
  var_1 = self.team;

  if(maps\mp\_utility::_id_579B() && common_scripts\utility::_id_562E(level._id_79C1))
    var_1 = maps\mp\_utility::getotherteam(var_1);

  if(!_id_048A::_id_4B8C()) {
    if(var_1 == "allies")
      self._id_267E[3] = 478;
    else
      self._id_267E[3] = 479;

    if(!_isagent(self))
      self _meth_84C7(self._id_267E, self.team, 1);

    self waittill("weapon_change", var_2);
    self._id_267E[3] = var_0;

    if(!_isagent(self))
      self _meth_84C7(self._id_267E, self.team, 1);
  }
}