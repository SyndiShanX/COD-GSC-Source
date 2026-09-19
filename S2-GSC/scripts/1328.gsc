/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1328.gsc
**************************************/

init() {
  level.doronvestmovespeedscale = 0.8;
  level._id_32A2 = 0.95;
  level._id_32A6 = 500;
  level._id_32A4 = 1.0;
  self._id_4B64 = 0;
}

_id_3662() {
  self._id_32A5 = level._id_32A6;

  if(maps\mp\_utility::_hasperk("specialty_stun_resistance"))
    self._id_32A1 = 1;
  else
    maps\mp\_utility::giveperk("specialty_stun_resistance");

  self._id_4B64 = 1;
  thread _id_63D8();
  _id_0513::_id_A13B();
}

_id_2F9E() {
  if(!isDefined(self._id_32A1) || !self._id_32A1)
    maps\mp\_utility::_id_0735("specialty_stun_resistance");

  self._id_4B64 = 0;
  _id_0513::_id_A13B();
}

_id_63D8() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self waittill("DoronVestDestroyed");
  self notify("DisabledRoleAbility");
  _id_2F9E();
}

_id_0F31(var_0) {
  if(self._id_4B64) {
    self._id_32A5 = self._id_32A5 - var_0;
    var_1 = var_0 / level._id_32A6;
    self _meth_85B9(-1 * var_1 * level._id_32A4);

    if(self._id_32A5 <= 0)
      self notify("DoronVestDestroyed");
  }
}