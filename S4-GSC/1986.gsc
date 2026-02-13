/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1986.gsc
*************************************************/

_id_3FD1() {
  level._id_6028 = scripts\engine\utility::_id_10699;
  level._id_6029 = ::_id_6029;
  level._id_6023 = _id_06D6::_id_9838;
  level._id_6024 = _id_06D6::_id_AAD2;
  level._id_601B = _id_06D6::_id_3F3A;
  level._id_6034 = _id_06CE::_id_C6DA;
  level._id_602A = _id_06CE::_id_BD4F;
  level._id_6026 = ::_id_6026;
  level._id_A294 = 1;
  level._id_2F59 = scripts\engine\utility::_id_10699;
  level._id_2F4A = scripts\engine\utility::_id_10699;
  level._id_2F4B = scripts\engine\utility::_id_10699;
  level._id_2F4D = scripts\engine\utility::_id_10699;
  level._id_2F4C = scripts\engine\utility::_id_10699;
  level._id_2F4F = scripts\engine\utility::_id_10699;
  level._id_2F50 = scripts\engine\utility::_id_10699;
  level._id_2F4B = ::_id_2F37;
  level._id_2F51 = scripts\engine\utility::_id_10699;
  thread _id_C19A();
  thread _id_C199();
  thread _id_06CE::_id_601D();
  _id_06CE::_id_3FD6();
  level waittill("eternity");
}

_id_6029(var_0) {
  return level.player.origin;
}

_id_2F37() {
  self waittill("begin");

  if(!isDefined(level.player)) {
    var_0 = getEntArray("mp_global_intermission", "classname");
    self spawn(var_0[0].origin, var_0[0].angles);
    scripts\mp\utility\player::_id_FD26("playing", "");
    self.maxhealth = 10000000;
    self.health = 10000000;
    level.player = self;
    thread _id_06CE::_id_3FE5();
  } else
    kick(self getentitynumber());
}

_id_6026() {
  var_0 = level._id_0BA7._id_B5E1 / 190;
  level.player setmovespeedscale(var_0);
  setDvar("#x364b5ba414a36852d", level._id_0BA7._id_B5E1);
}

_id_C19A() {}

_id_C199() {}