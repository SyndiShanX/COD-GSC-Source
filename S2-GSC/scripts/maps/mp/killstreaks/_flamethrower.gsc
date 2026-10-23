/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\killstreaks\_flamethrower.gsc
*********************************************************/

init() {
  level.killstreakfuncs["flamethrower"] = ::_id_9E2D;
  level.killstreakwieldweapons["flamethrower_mp"] = "flamethrower";
  level.killstreakwieldweapons["flamethrower_german_mp"] = "flamethrower";
  level.killstreakwieldweapons["flamethrower_grenadier_mp"] = "flamethrower";
  level.killstreakwieldweapons["flamethrower_german_grenadier_mp"] = "flamethrower";
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
  if(!isDefined(self.costume)) {
    return;
  }
  var_0 = self.costume[3];
  var_1 = self.team;

  if(maps\mp\_utility::_id_579B() && common_scripts\utility::_id_562E(level._id_79C1)) {
    var_1 = maps\mp\_utility::getotherteam(var_1);
  }

  if(!_id_048A::_id_4B8C()) {
    if(var_1 == "allies") {
      self.costume[3] = 478;
    } else {
      self.costume[3] = 479;
    }

    if(!_isagent(self)) {
      self set_grenadeammo(self.costume, self.team, 1);
    }

    self waittill("weapon_change", var_2);
    self.costume[3] = var_0;

    if(!_isagent(self)) {
      self set_grenadeammo(self.costume, self.team, 1);
    }
  }
}