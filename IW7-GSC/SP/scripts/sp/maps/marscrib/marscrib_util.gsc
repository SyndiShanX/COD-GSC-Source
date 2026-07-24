/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\marscrib\marscrib_util.gsc
******************************************************/

_id_107BE(var_0) {
  if(!isDefined(level._id_EA2C))
    level._id_EA2C = _id_107D5("salter", "Salter", "salter", "iw7_m4", 1);

  if(isDefined(var_0))
    level._id_EA2C _id_B399(var_0);

  return level._id_EA2C;
}

_id_10710(var_0) {
  if(!isDefined(level._id_76FB))
    level._id_76FB = _id_107D5("gator", "Gator", "gator", "iw7_erad", 1);

  if(isDefined(var_0))
    level._id_76FB _id_B399(var_0);

  return level._id_76FB;
}

_id_106D9(var_0) {
  if(!isDefined(level._id_6754))
    level._id_6754 = _id_107D5("ethan", "Ethan", "ethan", "iw7_sdfar");

  if(isDefined(var_0))
    level._id_6754 _id_B399(var_0);

  return level._id_6754;
}

_id_10722(var_0) {
  if(!isDefined(level._id_8604))
    level._id_8604 = _id_107D5("griff", "Griff", "griff", "iw7_devastator", 1);

  if(isDefined(var_0))
    level._id_8604 _id_B399(var_0);

  return level._id_8604;
}

_id_107DC(var_0) {
  if(!isDefined(level._id_10214))
    level._id_10214 = _id_107D5("sipes", "Sipes", "sipes", "iw7_m4", 1);

  if(isDefined(var_0))
    level._id_10214 _id_B399(var_0);

  return level._id_10214;
}

_id_1065E(var_0) {
  if(!isDefined(level._id_30F6))
    level._id_30F6 = _id_107D5("brooks_new", "Brooks", "brooks", "iw7_erad", 1);

  if(isDefined(var_0))
    level._id_30F6 _id_B399(var_0);

  return level._id_30F6;
}

_id_106AE(var_0) {
  if(!isDefined(level._id_5D2E))
    level._id_5D2E = _id_107D5("dropoff", "Drop Officer", "dropoff", "iw7_devastator", 1);

  if(isDefined(var_0))
    level._id_5D2E _id_B399(var_0);

  return level._id_5D2E;
}

_id_10750(var_0) {
  if(!isDefined(level._id_A6F4))
    level._id_A6F4 = _id_107D5("kloos", "Kloos", "kloos", "iw7_sdfar", 1);

  if(isDefined(var_0))
    level._id_A6F4 _id_B399(var_0);

  return level._id_A6F4;
}

_id_1068C(var_0) {
  if(!isDefined(level._id_444D))
    level._id_444D = _id_107D5("commo", "Comms Officer", "commo", "iw7_m4", 1);

  if(isDefined(var_0))
    level._id_444D _id_B399(var_0);

  return level._id_444D;
}

_id_10652(var_0) {
  if(!isDefined(level._id_2BFF))
    level._id_2BFF = _id_107D5("boats", "Boats", "boats", "iw7_devastator", 1);

  if(isDefined(var_0))
    level._id_2BFF _id_B399(var_0);

  return level._id_2BFF;
}

_id_10653(var_0) {
  if(!isDefined(level._id_2C23))
    level._id_2C23 = _id_107D5("boggs", "Boggs", "boggs", "iw7_m4", 1);

  if(isDefined(var_0))
    level._id_2C23 _id_B399(var_0);

  return level._id_2C23;
}

_id_107BD(var_0) {
  if(!isDefined(level._id_EA29))
    level._id_EA29 = _id_107D5("sahora", "Sahora", "sahora", "iw7_m4", 1);

  if(isDefined(var_0))
    level._id_EA29 _id_B399(var_0);

  return level._id_EA29;
}

_id_10766(var_0) {
  if(!isDefined(level._id_B4F1))
    level._id_B4F1 = _id_107D5("mccallum", "MaCallum", "mccallum", "iw7_m4", 1);

  if(isDefined(var_0))
    level._id_B4F1 _id_B399(var_0);

  return level._id_B4F1;
}

_id_107D5(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\engine\utility::get_target_ent(var_0);
  var_5.count = 1;
  var_6 = var_5 scripts\sp\utility::_id_10619(1);
  var_6.name = var_1;
  var_6._id_EDB8 = var_1;
  var_6._id_1FBB = var_2;
  var_6 scripts\sp\utility::_id_F3B5("r");
  var_6 scripts\sp\utility::_id_F2DA(0);
  var_6 _meth_839E();

  if(isDefined(var_3))
    var_6 scripts\sp\utility::_id_72EC(var_3, "primary");

  if(isDefined(var_4) && var_4)
    var_6._id_2FC2 = playFXOnTag(scripts\engine\utility::getfx("breath_fog"), var_6, "J_Lip_Top");

  var_6._id_BFED = 1;
  var_6._id_72C7 = 1;
  var_6 thread scripts\sp\utility::_id_5131();

  if(!isDefined(level._id_1684))
    level._id_1684 = [];

  level._id_1684[var_1] = var_6;
  return var_6;
}

_id_4046(var_0) {
  self endon("death");

  if(isDefined(self.name))
    level._id_1684 = scripts\sp\utility::_id_22B2(level._id_1684, self.name);

  _id_1101C();
  scripts\sp\utility::anim_stopanimScripted();

  if(isDefined(self._id_C6EA))
    self._id_C6EA notify("stop_loop");

  if(isDefined(self._id_5D6C) && isDefined(self._id_5D6C._id_4D94) && isDefined(self._id_5D6C._id_4D94.allies))
    self._id_5D6C._id_4D94.allies = scripts\engine\utility::array_remove(self._id_5D6C._id_4D94.allies, self);

  if(isDefined(var_0) && var_0)
    self _meth_81D0();
  else
    self delete();
}

_id_1101C() {
  if(isDefined(self._id_B14F) && self._id_B14F)
    scripts\sp\utility::_id_1101B();
}

_id_B399(var_0) {
  if(isnode(var_0)) {
    scripts\sp\utility::_id_1160F(var_0);
    return;
  } else if(isent(var_0)) {
    scripts\sp\utility::_id_11624(var_0);
    self setgoalpos(self.origin);
    return;
  }

  var_1 = undefined;
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");

  if(isDefined(var_1)) {
    self _meth_80F1(var_1.origin, var_1.angles);
    self setgoalpos(self.origin);
    return;
  }

  var_1 = getnode(var_0, "targetname");

  if(isDefined(var_1)) {
    scripts\sp\utility::_id_1160F(var_1);
    self setgoalpos(self.origin);
    return;
  }

  var_1 = getEnt(var_0, "targetname");

  if(isDefined(var_1)) {
    scripts\sp\utility::_id_11624(var_1);
    self setgoalpos(self.origin);
  }
}

_id_D21E() {
  var_0 = getEntArray("player_kill", "targetname");
  var_1 = getEntArray("kill_player", "targetname");

  foreach(var_3 in var_0) {
    if(isDefined(var_3))
      var_3 thread _id_12FD();
  }

  foreach(var_3 in var_1) {
    if(isDefined(var_3))
      var_3 thread _id_12FD();
  }
}

_id_12FD() {
  level.player endon("death");
  self waittill("trigger");
  level.player _meth_80A1();
  level.player _meth_81D0();
}