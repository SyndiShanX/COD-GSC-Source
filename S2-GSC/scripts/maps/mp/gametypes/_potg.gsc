/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\_potg.gsc
***********************************************/

_id_4632() {
  return _func_36A() + _func_36B() + _func_369();
}

_id_578D() {
  if(getdvarint("2653", 0) == 0)
    return 0;
  else
    return 1;
}

_id_2392() {
  if(!isDefined(self) || !isPlayer(self)) {
    return;
  }
  var_0 = _func_36B() * 1000;

  for(var_1 = 0; var_1 < 40; var_1++) {
    if(maps\mp\_utility::_id_44FA() - self._id_75F8[var_1]._id_3FD7 > var_0 && self._id_75F8[var_1]._id_8CA6 != 0) {
      self._id_75F8[var_1]._id_3FD7 = 0;
      self._id_75F8[var_1]._id_AA00 = 0;
      self._id_75F8[var_1]._id_8CA6 = 0;
      self._id_75F8[var_1]._id_1EB5 = undefined;
      self._id_75F8[var_1].victimnum = undefined;
      self._id_75F8[var_1]._id_01D0 = "none";
    }
  }
}

_id_772C() {
  var_0 = 0;

  if(!_func_36C()) {
    return;
  }
  for(var_1 = 0; var_1 < 40; var_1++) {
    if(self._id_75F8[var_1]._id_8CA6 == 1 && self._id_75F8[var_1]._id_AA00 > 0)
      var_0 = var_0 + self._id_75F8[var_1]._id_AA00;
  }
}

_id_772D() {
  if(!_func_36C()) {
    return;
  }
  for(var_0 = 0; var_0 < 40; var_0++) {
    if(level._id_74CB[var_0]._id_8CA6 == 1 && level._id_74CB[var_0]._id_AA00 > 0) {}
  }
}

_id_942E(var_0) {
  if(!isDefined(level._id_74CB)) {
    level._id_74CB = [];

    for(var_1 = 0; var_1 < 40; var_1++) {
      level._id_74CB[var_1] = spawnStruct();
      level._id_74CB[var_1]._id_3FD7 = 0;
      level._id_74CB[var_1]._id_AA00 = 0;
      level._id_74CB[var_1]._id_8CA6 = 0;
      level._id_74CB[var_1]._id_1EB5 = undefined;
      level._id_74CB[var_1].victimnum = undefined;
      level._id_74CB[var_1]._id_01D0 = "none";
      level._id_74CB[var_1]._id_A490 = undefined;
    }
  }

  if(isDefined(level._id_74CB)) {
    for(var_1 = 0; var_1 < 40; var_1++) {
      if(self._id_75F8[var_1]._id_8CA6 == 1) {
        level._id_74CB[var_1]._id_AA00 = self._id_75F8[var_1]._id_AA00;
        level._id_74CB[var_1]._id_1458 = self._id_75F8[var_1]._id_1458;
        level._id_74CB[var_1]._id_8CA6 = 1;
        level._id_74CB[var_1]._id_3FD7 = self._id_75F8[var_1]._id_3FD7;
        level._id_74CB[var_1]._id_1EB5 = self._id_75F8[var_1]._id_1EB5;
        level._id_74CB[var_1].victimnum = self._id_75F8[var_1].victimnum;
        level._id_74CB[var_1]._id_01D0 = self._id_75F8[var_1]._id_01D0;
        level._id_74CB[var_1]._id_A490 = self._id_75F8[var_1]._id_A490;
        continue;
      }

      level._id_74CB[var_1]._id_8CA6 = 0;
    }
  }

  level._id_74CC = var_0;
}

_id_A155(var_0) {
  if(isDefined(level._id_74CC)) {
    if(level._id_74CC < var_0) {
      _id_942E(var_0);
      _func_3B6();
      _id_04CE::_id_7B3B(self, _func_369());
      _id_772D();
    }
  } else {
    _id_942E(var_0);
    _func_3B6();
    _id_04CE::_id_7B3B(self, _func_369());
    _id_772D();
  }
}

_id_4633() {
  var_0 = 0;
  var_1 = _func_36B() * 1000;

  for(var_2 = 0; var_2 < 40; var_2++) {
    if(self._id_75F8[var_2]._id_8CA6 != 0 && maps\mp\_utility::_id_44FA() - self._id_75F8[var_2]._id_3FD7 <= var_1)
      var_0 = var_0 + self._id_75F8[var_2]._id_AA00;
  }

  return var_0;
}

_id_09EE(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(self._id_75F8)) {
    _id_2392();

    for(var_5 = 0; var_5 < 40; var_5++) {
      if(self._id_75F8[var_5]._id_8CA6 == 0) {
        self._id_75F8[var_5]._id_3FD7 = maps\mp\_utility::_id_44FA();
        self._id_75F8[var_5]._id_AA00 = var_1;
        self._id_75F8[var_5]._id_1458 = var_0;
        self._id_75F8[var_5]._id_8CA6 = 1;
        self._id_75F8[var_5]._id_1EB5 = var_3;
        self._id_75F8[var_5].victimnum = var_4;

        if(!isDefined(var_2))
          var_2 = "none";

        self._id_75F8[var_5]._id_01D0 = var_2;
        break;
      }
    }
  }

  _id_772C();
  var_6 = _id_4633();
  _id_A155(var_6);
}

_id_4631(var_0) {
  if(!isDefined(var_0) || var_0 == "")
    return 0;

  var_1 = tablelookup("mp/xp_event_table.csv", 0, var_0, 21);

  if(!isDefined(var_1) || var_1 == "")
    var_1 = 0;

  return int(var_1);
}

_id_4AE2(var_0, var_1, var_2, var_3) {
  if(!_id_578D()) {
    return;
  }
  if(!isDefined(var_3)) {
    return;
  }
  var_4 = _id_4631(var_0);

  if(var_4 <= 0)
    var_4 = 0;

  if(!isDefined(self._id_75F8)) {
    self._id_75F8 = [];

    for(var_5 = 0; var_5 < 40; var_5++) {
      self._id_75F8[var_5] = spawnStruct();
      self._id_75F8[var_5]._id_3FD7 = 0;
      self._id_75F8[var_5]._id_AA00 = 0;
      self._id_75F8[var_5]._id_8CA6 = 0;
      self._id_75F8[var_5]._id_1EB5 = undefined;
      self._id_75F8[var_5].victimnum = undefined;
      self._id_75F8[var_5]._id_01D0 = "none";
    }
  }

  if(isDefined(self._id_75F8)) {
    _id_2392();

    for(var_5 = 0; var_5 < 40; var_5++) {
      if(self._id_75F8[var_5]._id_8CA6 == 0) {
        self._id_75F8[var_5]._id_3FD7 = maps\mp\_utility::_id_44FA();
        self._id_75F8[var_5]._id_AA00 = var_4;
        self._id_75F8[var_5]._id_1458 = var_0;
        self._id_75F8[var_5]._id_8CA6 = 1;

        if(isDefined(var_2))
          self._id_75F8[var_5]._id_A490 = var_2;

        if(!isDefined(self._id_75F8[var_5]._id_1EB5) && isDefined(var_2) && isDefined(var_1)) {
          var_6 = var_2 maps\mp\gametypes\_damage::_id_452F(self, var_3, var_1);

          if(isDefined(var_6)) {
            self._id_75F8[var_5]._id_1EB5 = var_6 getentitynumber();
            self._id_75F8[var_5].victimnum = var_2 getentitynumber();
          } else
            self._id_75F8[var_5]._id_1EB5 = self getentitynumber();
        } else
          self._id_75F8[var_5]._id_1EB5 = self getentitynumber();

        if(!isDefined(var_1))
          var_1 = "none";

        self._id_75F8[var_5]._id_01D0 = var_1;

        if(_id_047A::iskillevent(self._id_75F8[var_5]._id_1458) && self._id_75F8[getlastkillplay(var_5)]._id_01D0 != var_1)
          _id_09EE("POTG_weapon_Swap", _id_4631("POTG_weapon_Swap"), "none", undefined, undefined);

        break;
      }
    }
  }

  var_7 = _id_4633();
  _id_A155(var_7);

  if(var_7 > 0)
    _id_772C();
}

getlastkillplay(var_0) {
  var_1 = 0;
  var_2 = var_0;

  for(var_3 = 0; var_3 < 40; var_3++) {
    if(self._id_75F8[var_3]._id_8CA6 == 1 && _id_047A::iskillevent(self._id_75F8[var_3]._id_1458) && var_3 != var_0) {
      if(self._id_75F8[var_3]._id_3FD7 > var_1 && self._id_75F8[var_3]._id_3FD7 < self._id_75F8[var_0]._id_3FD7)
        var_2 = var_3;
    }
  }

  return var_2;
}

_id_2407(var_0) {
  level endon("cancel_previous_delayed_recording");
  var_1 = var_0 getentitynumber();
  var_0 waittill("disconnect");

  if(level._id_74CA == var_1) {
    level._id_74CA = -1;
    level.playofthegameentity = undefined;
    level._id_74CC = undefined;
    level._id_74CB = undefined;
  }
}