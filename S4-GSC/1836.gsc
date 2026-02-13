/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1836.gsc
*************************************************/

_id_7F91() {
  _id_C214();
}

_id_C214() {
  if(scripts\cp\utility::_id_89AE()) {
    setomnvar("zm_ui_is_solo", 1);
  } else {
    setomnvar("zm_ui_is_solo", 0);
  }
}

_id_C1E1(var_0, var_1) {
  if(!isDefined(level._id_5531)) {
    level._id_5531 = [];
  }

  var_2 = spawnStruct();
  var_2._id_9909 = var_1;
  level._id_5531[var_0] = var_2;
}

_id_C1DF(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = spawnStruct();
  var_8 = [[var_1]](var_8);
  var_8._id_C5F0 = var_2;
  var_8._id_C5D8 = var_3;
  var_8._id_2ED1 = var_4;
  var_8._id_9909 = var_5;
  var_8._id_529E = var_6;

  if(isDefined(var_7)) {
    var_8._id_B4FC = var_7;
  }

  level._id_5279[var_0] = var_8;
}

_id_74ED(var_0) {
  return _id_7511(level._id_5531, var_0);
}

_id_7511(var_0, var_1) {
  if(_id_86AB()) {
    return 0;
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  return isDefined(var_0[var_1]);
}

_id_86AB() {
  if(isDefined(level._id_8A18)) {
    return [[level._id_8A18]]();
  }

  return 0;
}

_id_8064() {
  if(_id_86AB()) {
    return;
  }
  self._id_5278 = [];
  self._id_529D = [];
  _id_3B3A(self);
  _id_C5D6(self);
  _id_C5B1();
}

_id_3B3A(var_0) {
  foreach(var_3, var_2 in level._id_5279) {
    if(isDefined(var_2._id_B4FC)) {
      [[var_2._id_B4FC]](var_0);
    }
  }
}

_id_C5D6(var_0) {
  foreach(var_3, var_2 in level._id_5279) {
    if(isDefined(var_2._id_C5D8)) {
      [[var_2._id_C5D8]](var_0);
    }
  }
}

_id_C5B1() {
  foreach(var_2, var_1 in level._id_5531) {
    self._id_529D[var_2] = 0;
  }
}

_id_C5B0() {
  foreach(var_2, var_1 in level._id_5279) {
    if(isDefined(var_1._id_C5F0)) {
      [[var_1._id_C5F0]](var_1);
    }
  }

  _id_C5DB();
}

_id_C5DB() {
  foreach(var_1 in level.players) {
    _id_C5D6(var_1);
    _id_C5D5(var_1);
  }
}

_id_2ED6(var_0) {
  if(_id_86AB()) {
    return;
  }
  if(isDefined(level._id_5301)) {
    [[level._id_5301]](var_0);
  }

  foreach(var_2 in level.players) {
    _id_2ED9(var_2);
  }
}

_id_2ED9(var_0) {
  var_1 = 1;
  var_2 = 0;

  foreach(var_6, var_4 in level._id_5531) {
    var_5 = var_0._id_529D[var_6];
    var_1++;
    var_2 = var_2 + var_5;
  }
}

_id_2ECB(var_0, var_1) {
  _id_2ED0(var_0, var_1);
  _id_DC34();
}

_id_2ED0(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    _id_2ED5(var_4, var_1, var_2);
  }
}

_id_2ED5(var_0, var_1, var_2) {
  var_3 = 1;
  var_4 = 0;

  foreach(var_6 in var_1) {
    var_7 = level._id_5279[var_6];
    var_8 = [[var_7._id_2ED1]](var_0, var_7);
    var_8 = var_8 * level._id_42A1;
    var_8 = int(var_8);
    var_0._id_529D[var_7._id_529E] = var_0._id_529D[var_7._id_529E] + var_8;
    _id_D283(var_0, var_3, var_7._id_9909, var_8);
    var_4 = var_4 + var_8;
    var_3++;
  }

  if(isDefined(level._id_26A8)) {
    var_10 = [[level._id_26A8]](var_0, var_4);
    var_4 = var_4 + var_10._id_0050;
    _id_D283(var_0, var_3, var_10._id_F914, var_10._id_0050);
    var_3++;
  }

  _id_D283(var_0, var_3, 6, var_4);
  var_3++;

  if(isDefined(level._id_BA46)) {
    [[level._id_BA46]](var_0, var_4, var_3);
  }
}

_id_C936(var_0, var_1) {
  var_2 = var_0 / var_1;
  var_2 = _func_0037(var_2);
  return int(var_2 * var_1);
}

_id_FBB4(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    var_4 _id_FBA7(var_0, var_1, var_2);
  }
}

_id_FBA7(var_0, var_1, var_2) {
  if(!_id_74EA(var_0)) {
    return;
  }
  if(!isPlayer(self)) {
    return;
  }
  self._id_5278 = _id_FB61(self._id_5278, var_1, var_2);
}

_id_FB61(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_0[var_1] = var_0[var_1] + var_2;
  return var_0;
}

_id_67BA(var_0, var_1) {
  return var_0._id_EF43[var_1];
}

_id_74EA(var_0) {
  return _id_7511(level._id_5279, var_0);
}

_id_666F(var_0, var_1) {
  return var_0._id_5278[var_1];
}

_id_2EDB(var_0, var_1, var_2) {
  var_3 = clamp(var_1 - var_0, 0, var_1);
  return int(var_3 / var_1 * var_2);
}

_id_FBD9(var_0, var_1, var_2) {
  if(!_id_74EA(var_0)) {
    return;
  }
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  level._id_5279[var_0]._id_EF43[var_1] = level._id_5279[var_0]._id_EF43[var_1] + var_2;
}

_id_253D(var_0) {
  return var_0;
}

_id_67C3() {
  return scripts\engine\utility::ter_op(isDefined(level._id_EF55), level._id_EF55, "team");
}

_id_C5D5(var_0) {
  var_1 = 8;

  for(var_2 = 1; var_2 <= var_1; var_2++) {
    var_3 = "ui_alien_encounter_title_row_" + var_2;
    var_4 = "ui_alien_encounter_score_row_" + var_2;
    var_0 setclientomnvar(var_3, 0);
    var_0 setclientomnvar(var_4, 0);
  }
}

_id_D284(var_0, var_1, var_2, var_3) {
  var_4 = "zm_ui_eog_title_row_" + var_1;
  var_5 = "zm_ui_eog_title_row_" + var_1;
  var_0 setclientomnvar(var_4, var_2);
  var_0 setclientomnvar(var_5, var_3);
}

_id_DC34() {
  level endon("game_ended ");
  setomnvar("zm_ui_show_encounter_score", 1);
  wait 1.0;
  setomnvar("zm_ui_show_encounter_score", 0);
}

_id_D283(var_0, var_1, var_2, var_3) {
  var_4 = "ui_alien_encounter_title_row_" + var_1;
  var_5 = "ui_alien_encounter_score_row_" + var_1;
}

_id_BD5D(var_0, var_1, var_2) {
  if(isDefined(level._id_1D2C)) {
    return;
  }
  _id_BD5E(var_0, var_1, var_2);
}

_id_BD5E(var_0, var_1, var_2) {
  self endon("disconnect");
  var_0 endon("disconnect");

  if(isDefined(var_1) && var_1.basename == "white_phosphorus_proj_mp") {
    return;
  }
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(var_0._id_8921)) {
    var_4 = var_0._id_1DDE;
    var_3 = 1;
  }

  if(isDefined(var_0._id_9B35)) {
    var_5 = var_0._id_9B35;
  }

  wait 0.05;
  _id_0960::_id_1096C();
  var_6 = self.pers["team"];

  if(!scripts\cp\utility::_id_8878(var_6)) {
    return;
  }
  if(isPlayer(var_0) && isDefined(var_0.pers)) {
    if(var_6 == var_0.pers["team"] && level.teambased) {
      return;
    }
  }

  thread _id_0752::_id_7003("assist", var_1);

  if(level.teambased) {
    var_7 = scripts\common\utility::_id_B7BF(self.origin, 300);

    foreach(var_9 in var_7) {
      if(self.team != var_9.team || self == var_9) {
        continue;
      }
      if(!scripts\cp\utility\player::isreallyalive(var_9)) {
        continue;
      }
      self._id_9FFB["buddy_kill"] = 1;
      break;
    }
  }

  if(scripts\cp\utility::_hasperk("specialty_hardline") && isDefined(self._id_74C6)) {
    if(self._id_74C6["assists"] == 1) {
      if(!scripts\cp\utility::_id_88F6(var_1) && !scripts\cp\utility::_id_8A7D(var_1)) {
        thread _id_0752::_id_6FF6("assist_hardline", var_1, 1);
      }
    }

    self notify("assist_hardline");
  }

  if(self.pers["assists"] < 998) {
    _id_0740::_id_7DAE("assists", 1);
    self._id_006F = _id_0740::_id_6C29("assists");
  }

  _id_0960::_id_2C9F("assist_buffered", self._id_9FFB);
}