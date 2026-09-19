/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1333.gsc
**************************************/

init() {
  level.steelbibmovespeedscale = 0.75;
  level._id_9394 = 75;
  level._id_9392 = 1.0;
  self._id_4B9A = 0;
}

_id_3662() {
  self._id_9393 = level._id_9394;
  self._id_4B9A = 1;
  thread _id_63D8();
  _id_0513::_id_A13B();
}

_id_2F9E() {
  self._id_4B9A = 0;
  _id_0513::_id_A13B();
}

_id_63D8() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  self waittill("SteelBibDestroyed");
  self notify("DisabledRoleAbility");
  _id_2F9E();
}

_id_0F31(var_0) {
  if(self._id_4B9A) {
    self._id_9393 = self._id_9393 - var_0;
    var_1 = var_0 / level._id_9394;
    self _meth_85B9(-1 * var_1 * level._id_9392);

    if(self._id_9393 <= 0)
      self notify("SteelBibDestroyed");
  }
}