/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_50d581b454b6d41d.gsc
***********************************************/

_id_FE852F92145C24A6() {
  _id_5BC86A57086A4774::_id_AC97A4F2AB8C2D53("tablet", "tryAssignTask", ::_id_08A64133F5D5F7DD);
  _id_5BC86A57086A4774::_id_AC97A4F2AB8C2D53("tablet", "checkTaskValid", ::_id_C3820063548EA9F4);
  _id_5BC86A57086A4774::_id_AC97A4F2AB8C2D53("tablet", "tryBindObjective", ::_id_F06F2A906262B65C);
  _id_5BC86A57086A4774::_id_AC97A4F2AB8C2D53("tablet", "removeObjectiveInfo", ::_id_53053EA95E1148C2);
}

_id_08A64133F5D5F7DD(_id_17953215DD7C5F9B) {
  _id_2E16D30576073B00 = level.teamdata[_id_17953215DD7C5F9B.team]["alivePlayers"][0];
  instance = _id_E92B6ECC9AB0F07A(_id_17953215DD7C5F9B.info.ref, _id_2E16D30576073B00);
  instance._id_E4CFB225AB81E7BC = _id_17953215DD7C5F9B.info;
  instance thread oncontractend(_id_17953215DD7C5F9B);
  instance thread _id_A24A232718DD45B7(_id_17953215DD7C5F9B);
  _id_3ACF1C0EBAF602F2::onquesttablethide(instance);
  _id_2E16D30576073B00 _id_3ACF1C0EBAF602F2::takequesttablet(instance);
}

_id_E92B6ECC9AB0F07A(_id_015AD24E2FBEEE5D, _id_2E16D30576073B00) {
  if(!isDefined(_id_2E16D30576073B00))
    return undefined;

  _id_173CBD75083BEBA4 = level._id_E4CFB225AB81E7BC._id_07E96A4CD28C47DF;
  _id_0441C690181A13AC = _id_173CBD75083BEBA4 * _id_173CBD75083BEBA4;
  _id_E34D653F9277D8A4 = undefined;
  players = level.teamdata[_id_2E16D30576073B00.team]["players"];
  _id_A35449152EFF0EEE = _id_3ACF1C0EBAF602F2::getlootname(_id_015AD24E2FBEEE5D);
  _id_5B0E81CF1D91E0D5 = getlootscriptablearrayinradius(_id_A35449152EFF0EEE, undefined, _id_2E16D30576073B00.origin, _id_173CBD75083BEBA4);

  foreach(tablet in _id_5B0E81CF1D91E0D5) {
    if(!isDefined(level.questinfo.activetablets["" + tablet.index]) || istrue(tablet.startdisabled)) {
      continue;
    }
    foreach(player in players) {
      _id_3C0080D63118991E = distance2dsquared(tablet.origin, player.origin);

      if(_id_3C0080D63118991E < _id_0441C690181A13AC) {
        _id_E34D653F9277D8A4 = tablet;
        _id_0441C690181A13AC = _id_3C0080D63118991E;
      }
    }
  }

  return _id_E34D653F9277D8A4;
}

oncontractend(_id_17953215DD7C5F9B) {
  level endon("game_ended");
  self waittill("questEnded", team, result);

  if(isDefined(result) && result == "success")
    _id_5BC86A57086A4774::_id_C70072A3CF2BEFDF(_id_17953215DD7C5F9B);

  self._id_E4CFB225AB81E7BC = undefined;
  _id_3ACF1C0EBAF602F2::_id_8E57889AC5DDA0BC(self);
  _id_5BC86A57086A4774::_id_9AAD50CBCB9B942E(_id_17953215DD7C5F9B, result);
}

_id_A24A232718DD45B7(_id_17953215DD7C5F9B) {
  level endon("game_ended");
  self endon("questEnded");
  _id_17953215DD7C5F9B endon("task_end");
  level waittill("quest_objective_updated_" + _id_17953215DD7C5F9B.team, locale);
  _id_17953215DD7C5F9B.locale = locale;
  players = level.teamdata[_id_17953215DD7C5F9B.team]["players"];

  foreach(player in players) {
    if(isDefined(locale.objectiveiconid) && isDefined(player._id_B8ABADD2C4D56FD8) && player._id_B8ABADD2C4D56FD8._id_17953215DD7C5F9B != _id_17953215DD7C5F9B)
      locale _id_3ACF1C0EBAF602F2::hidequestobjiconfromplayer(player);
  }
}

_id_C3820063548EA9F4(_id_BE80583079EC3E95, team) {
  _id_2E16D30576073B00 = level.teamdata[team]["players"][0];
  instance = _id_E92B6ECC9AB0F07A(_id_BE80583079EC3E95.ref, _id_2E16D30576073B00);

  if(!isDefined(instance))
    return 0;

  return 1;
}

_id_F06F2A906262B65C(_id_17953215DD7C5F9B) {
  locale = _id_17953215DD7C5F9B.locale;

  if(!isDefined(locale)) {
    return;
  }
  _id_B8ABADD2C4D56FD8 = spawnStruct();
  _id_B8ABADD2C4D56FD8.item = locale;
  _id_B8ABADD2C4D56FD8._id_17953215DD7C5F9B = _id_17953215DD7C5F9B;
  self._id_B8ABADD2C4D56FD8 = _id_B8ABADD2C4D56FD8;

  if(isDefined(locale.objectiveiconid))
    locale _id_3ACF1C0EBAF602F2::showquestobjicontoplayer(self);

  if(isDefined(locale.mapcircle))
    locale scripts\cp_mp\utility\game_utility::_id_CFD53C8F6878014F(self);
}

_id_53053EA95E1148C2() {
  locale = self._id_B8ABADD2C4D56FD8._id_17953215DD7C5F9B.locale;

  if(!isDefined(locale)) {
    return;
  }
  if(isDefined(locale.objectiveiconid))
    locale _id_3ACF1C0EBAF602F2::hidequestobjiconfromplayer(self);

  if(isDefined(locale.mapcircle))
    locale scripts\cp_mp\utility\game_utility::_id_D7D113D56EF0EF5B(self);

  self._id_B8ABADD2C4D56FD8 notify("objective_removed");
  self._id_B8ABADD2C4D56FD8 = undefined;
}