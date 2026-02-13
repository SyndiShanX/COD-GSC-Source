/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2670.gsc
*************************************************/

_id_10DBA() {
  _id_0AA3::_id_C28D(::_id_AB7B);
}

_id_AB7B() {
  thread _id_10C2C();
}

_id_19F3() {
  var_0 = self._id_0133;

  if(isDefined(var_0) && var_0.basename != "none") {
    _id_7007(var_0);
  }
}

_id_10C2C() {
  self endon("death_or_disconnect");

  for(;;) {
    _id_19F3();
    scripts\engine\utility::_id_108C5("weapon_change", "giveLoadout");
  }
}

_id_7007(var_0) {
  _id_3968();
  var_1 = _id_07ED::_id_6C17(var_0.basename, var_0._id_04CC);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      _id_6FCC(var_3);
    }
  }

  self notify("weapon_passives_given");
}

_id_6FCC(var_0) {
  scripts\mp\utility\perk::_id_6FC2(var_0);
  self._id_10DB9[self._id_10DB9.size] = var_0;
}

_id_3968() {
  if(isDefined(self._id_10DB9)) {
    foreach(var_1 in self._id_10DB9) {
      scripts\mp\utility\perk::removeperk(var_1);
    }
  }

  self._id_10DB9 = [];
}

_id_5F00() {
  self._id_10DB9 = [];
}

_id_4635(var_0) {
  if(!isDefined(self._id_AEAF)) {
    self._id_AEAF = [];
  }

  if(!isDefined(self._id_AEAF[var_0])) {
    self._id_AEAF[var_0] = 0.0;
  }
}

_id_6C19(var_0) {
  _id_4635(var_0);
  return self._id_AEAF[var_0];
}

_id_D642(var_0, var_1) {
  _id_4635(var_0);
  self._id_AEAF[var_0] = var_1;
}

_id_EFA8(var_0, var_1) {
  if(level.teambased) {
    return var_0.team == var_1.team;
  }

  return var_0 == var_1;
}

_id_FD8D(var_0, var_1) {}

_id_FD8B(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {}

_id_96A5(var_0) {}

_id_FD8C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {}

_id_F0DE(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "";
  }

  var_2 = 0;
  var_3 = _id_07FD::_id_6C15(var_0);
  var_4 = "";

  if(isDefined(var_3)) {
    var_4 = var_3 + var_1;
    var_2 = scripts\mp\hud_message::_id_F0DB(var_4);
  }

  if(var_2) {
    return;
  }
  return;
}

_id_3533(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = "";
  }

  var_2 = _id_07FD::_id_6C15(var_0);

  if(isDefined(var_2)) {
    if(_func_010C(var_1, "_camo")) {
      var_3 = scripts\mp\utility\script::_id_EA63(var_1, "_camo");
      var_1 = var_3;
    }

    scripts\mp\hud_message::_id_DCC6(var_2 + var_1);
  }
}

_id_6C14(var_0, var_1) {
  if(!isDefined(var_0._id_AEA6)) {
    return 0;
  }

  if(!isDefined(var_0._id_AEA6[var_1])) {
    return 0;
  }

  if(var_0._id_AEA6[var_1]) {
    return 1;
  }

  return 0;
}

_id_D641(var_0, var_1, var_2) {
  if(!isDefined(var_0._id_AEA6)) {
    var_0._id_AEA6 = [];
  }

  var_0._id_AEA6[var_1] = var_2;
}

_id_3967(var_0, var_1) {
  if(!isDefined(var_0._id_AEA6)) {
    var_0._id_AEA6 = [];
  }

  var_0._id_AEA6[var_1] = undefined;
}

_id_D6EA(var_0, var_1, var_2, var_3) {
  if(!isDefined(self._id_E507)) {
    self._id_E507 = [];
  }

  if(!isDefined(self._id_E507[var_0])) {
    var_4 = spawnStruct();
    var_4._id_7C8C = var_0;
    var_4._id_E505 = var_1;
    var_4._id_E504 = var_2;
    var_4._id_4511 = var_3;
    self._id_E507[var_0] = var_4;
  }
}

_id_6D7B(var_0) {
  if(!isDefined(self._id_E507)) {
    return undefined;
  }

  if(!isDefined(self._id_E507[var_0])) {
    return undefined;
  }

  var_1 = self._id_E507[var_0];
  return var_1;
}

_id_6D7A(var_0) {
  var_1 = _id_6D7B(var_0);

  if(!isDefined(var_1)) {
    return 0;
  }

  return var_1._id_E504;
}

_id_1139(var_0, var_1) {}