/********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_collection_quest.gsc
********************************************************/

init() {
  var_0 = scripts\mp\gametypes\br_quest_util::_id_C2A1("collection", 0);

  if(!var_0) {
    return;
  }
  level._id_CC37 = getdvarint("#x3102dc48fb2baaa17", 0) != 0;
  scripts\mp\gametypes\br_quest_util::_id_C2A7("collection", ::_id_3A31);
  scripts\mp\gametypes\br_quest_util::_id_C2A4("collect_locale");
  scripts\mp\gametypes\br_quest_util::_id_C2A5("collect_locale", ::_id_3A2E, 3);
  scripts\mp\gametypes\br_quest_util::_id_C2A5("collect_locale", ::_id_3A2F, 0.2);
  scripts\mp\gametypes\br_quest_util::_id_C2A7("collect_locale", ::_id_3A30);
  scripts\mp\gametypes\br_quest_util::_id_C24F("collect_locale", ::_id_3A2D);
  scripts\mp\gametypes\br_quest_util::_id_C246("collect_locale", ::_id_3A2A);
  scripts\mp\gametypes\br_quest_util::_id_C2A3("collect_locale", ::_id_3A2B);
  scripts\mp\gametypes\br_quest_util::_id_6C94("collect_locale")._id_A4A7 = 0;
}

_id_3A31() {
  var_0 = scripts\mp\gametypes\br_quest_util::_id_6C96("collect_locale", self.team);
  var_0 _id_791A(self);
  scripts\mp\gametypes\br_quest_util::_id_F91F(self.team);

  foreach(var_2 in scripts\mp\utility\teams::_id_6DCA(self.team, "players")) {
    _id_07F9::_id_A89E(var_0._id_A8DA, var_2);
  }

  scripts\mp\gametypes\br_quest_util::_id_C305(self.team);
}

_id_EDD3(var_0) {
  scripts\mp\gametypes\br_quest_util::_id_F922("collection", self.team);
  var_1 = scripts\mp\gametypes\br_quest_util::_id_4039("collection", self.team, var_0.index, var_0);
  var_1.team = self.team;
  var_1._id_E6E1 = _id_353A(self.origin);
  var_1 scripts\mp\gametypes\br_quest_util::_id_C2C0(self.team, self);
  var_2 = spawnStruct();
  var_2._id_CFB5 = "questPointsArray";
  var_2._id_CFAF = var_1._id_E6E1;
  var_2._id_CFBA = 10000;
  var_2._id_CFBB = 0;
  var_2._id_CFB8 = 6000;
  var_2._id_CFB9 = 4000;
  var_2._id_9F41 = 30;
  var_2._id_81F3 = self;
  var_2._id_BEBE = 7;
  var_3 = var_1 scripts\mp\gametypes\br_quest_util::_id_C580("collect_locale", var_2);
  var_1._id_F373 = 0;

  foreach(var_5 in scripts\mp\utility\teams::_id_6DCA(self.team, "players")) {
    var_5._id_3A5D = 0;
  }

  var_3 _id_FCAE();
  var_3 _id_FD7B();
  var_3 _id_DCFA(var_1);
  scripts\mp\gametypes\br_quest_util::_id_1118("collection", var_1);
  scripts\mp\gametypes\br_quest_util::_id_E72C("collection", self, self.team);
  var_7 = spawnStruct();
  var_7._id_56DD = [];
  var_7._id_56DD[0] = self;
  scripts\mp\gametypes\br_quest_util::_id_4B82(self.team, "br_scavenger_quest_start_team", var_7);
  scripts\mp\gametypes\br_quest_util::_id_4B7A(self, "br_scavenger_quest_start_tablet_finder");
}

_id_FCAE() {
  var_0 = [];

  foreach(var_2 in self._id_EABE) {
    var_3 = var_2.team;

    foreach(var_5 in scripts\mp\utility\teams::_id_6DCA(var_3, "players")) {
      if(!isDefined(var_5)) {
        continue;
      }
      var_0[var_0.size] = var_5;
    }
  }

  self._id_B711 = var_0;
}

_id_FD7B() {
  foreach(var_1 in self._id_8B33) {
    _id_FD7A(var_1);
  }
}

_id_FD7A(var_0) {
  foreach(var_2 in level.players) {
    if(scripts\engine\utility::array_contains(self._id_B711, var_2)) {
      var_0 _meth_80E0(var_2);
      var_0 showtoplayer(var_2);
      continue;
    }

    var_0 disableplayeruse(var_2);
  }
}

_id_DCFA(var_0) {
  foreach(var_2 in scripts\mp\utility\teams::_id_6DCA(var_0.team, "players")) {
    self._id_9AAD showtoplayer(var_2);
    _id_FC35(var_0, var_2);
  }
}

_id_FC34(var_0) {
  foreach(var_2 in scripts\mp\utility\teams::_id_6DCA(var_0.team, "players")) {
    _id_FC35(var_0, var_2);
  }
}

_id_FC35(var_0, var_1) {
  var_1 scripts\mp\gametypes\br_quest_util::_id_F920(var_0._id_F373);
}

_id_48A9() {
  foreach(var_1 in self._id_B711) {
    if(distance2d(var_1.origin, self._id_4140) > 0) {
      _id_07F9::_id_A89D(self._id_A8DA, var_1);
      continue;
    }

    _id_07F9::_id_A89E(self._id_A8DA, var_1);
  }
}

_id_791A(var_0) {
  foreach(var_2 in scripts\mp\utility\teams::_id_6DCA(var_0.team, "players")) {
    self._id_9AAD hidefromplayer(var_2);
    var_2 scripts\mp\gametypes\br_quest_util::_id_F91E();
  }
}

_id_5B02() {
  var_0 = self._id_4140 + scripts\engine\math::_id_BFF0() * randomintrange(0, 2900);
  var_0 = _id_353A(var_0);
  var_0 = var_0 + (0, 0, 10);

  foreach(var_2 in self._id_8B33) {
    if(distance(var_2.origin, var_0) < 100) {
      return undefined;
    }
  }

  if(level._id_CC37) {
    var_4 = self._id_B711[0] _meth_847B(self._id_4140, var_0, 0, 0);

    if(isDefined(var_4)) {
      return var_0;
      return;
    }

    return undefined;
    return;
  } else
    return var_0;
}

_id_5EC5() {
  if(isDefined(self._id_BC41) && self._id_BC41.size > 0) {
    var_0 = self._id_BC41[0];
    self._id_BC41 = scripts\engine\utility::array_remove(self._id_BC41, self._id_BC41[0]);
  } else {
    for(var_1 = 0; var_1 < 30; var_1++) {
      var_0 = _id_5B02();

      if(!isDefined(var_0)) {
        return var_0;
      }
    }
  }
}

_id_E313(var_0) {
  self._id_A78C++;
  var_1 = spawn("script_model", var_0);
  var_1 setModel("box_wooden_grenade_01");
  var_1 makeuseable();
  var_1 setcursorhint("HINT_NOICON");
  var_1 setuseholdduration("duration_short");
  var_1 sethintdisplayfov(150);
  var_1 setusefov(150);
  var_1 setuserange(150);
  var_1 sethintstring(&"MP/SCAV_PICKUP_PROMPT");
  var_1 setasgametypeobjective();
  var_1._id_96C9 = self;
  var_1 thread _id_E743();
  self._id_8B33[self._id_8B33.size] = var_1;
}

_id_E743() {
  self endon("death");
  self endon("remove_locale");

  for(;;) {
    self waittill("trigger", var_0);
    thread _id_FED6(var_0);
  }
}

_id_FED6(var_0) {
  var_1 = self._id_96C9;
  var_2 = scripts\mp\gametypes\br_quest_util::_id_6C96("collection", var_0.team);

  if(isDefined(var_2)) {
    self hide();
    self makeunusable();
    self.origin = self.origin + (0, 0, -500);
    self delete();
    var_0._id_3A5D++;
    var_2._id_F373++;
    var_1 _id_FC34(var_2);
    var_1._id_A78C = var_1._id_A78C - 1;

    if(!isDefined(var_1._id_BC41)) {
      var_1._id_BC41 = [];
    }

    var_1._id_BC41 = scripts\engine\utility::array_add(var_1._id_BC41, self.origin);
    var_1._id_8B33 = scripts\engine\utility::array_remove(var_1._id_8B33, self);

    if(var_2._id_F373 >= 10) {
      var_2 thread _id_3B19(self);
    }
  }
}

_id_3B19(var_0) {
  var_1 = scripts\mp\gametypes\br_quest_util::_id_6CA3(self.team);
  var_2 = scripts\mp\gametypes\br_quest_util::_id_6C98("collection", var_1);
  var_3 = spawnStruct();
  var_4 = scripts\mp\gametypes\br_quest_util::_id_6C95("collection");
  var_3._id_ADCB = scripts\mp\gametypes\br_quest_util::_id_ADCE(var_4, var_1);
  scripts\mp\gametypes\br_quest_util::_id_4B82(self._id_7C8C, "br_scavenger_quest_complete", var_3);
  scripts\mp\gametypes\br_quest_util::_id_6FFF(self.team, var_2);
  self._id_C810 = var_0.origin;
  self._id_C805 = var_0.angles;
  self._id_0372 = "success";
  scripts\mp\gametypes\br_quest_util::_id_C50F();
}

_id_58D5() {
  scripts\mp\gametypes\br_quest_util::_id_4B82(self._id_7C8C, "br_scavenger_quest_circle_failure");
  self._id_0372 = "fail";
  scripts\mp\gametypes\br_quest_util::_id_C50F();
}

_id_3A2A() {
  if(self._id_EABE.size < 4) {
    return 1;
  } else {
    return 0;
  }
}

_id_3A2D(var_0) {
  scripts\mp\gametypes\br_quest_util::_id_6C94("collect_locale")._id_A4A7++;
  var_1 = scripts\mp\gametypes\br_quest_util::_id_400D("collect_locale", "collection", "ColLoc:" + scripts\mp\gametypes\br_quest_util::_id_6C94("collect_locale")._id_A4A7);
  var_1._id_4140 = var_0.origin;
  var_1 _id_3A2C();
  var_1._id_8B33 = [];
  var_1._id_9AAD = _func_03EF(var_1._id_4140[0], var_1._id_4140[1], 2000);
  var_1._id_9AAD _meth_872C(1);
  var_1._id_9AAD hide();
  scripts\mp\gametypes\br_quest_util::_id_1118("collect_locale", var_1);
  return var_1;
}

_id_3A2C() {
  self._id_A8DA = _id_07F9::_id_C57D(1);

  if(self._id_A8DA != -1) {
    _id_07F9::_id_A867(self._id_A8DA, "current", (0, 0, 0), "ui_mp_br_mapmenu_icon_scavengerhunt_tablet");
    _id_07F9::_id_FB97(self._id_A8DA, self._id_4140);
    _id_07F9::_id_FB98(self._id_A8DA, 2);
    _id_07F9::_id_A89F(self._id_A8DA);
    _id_07F9::_id_A8B1(self._id_A8DA, 1);
  } else {}
}

_id_3A2E() {
  if(!isDefined(self._id_A78C)) {
    self._id_A78C = 0;
    self._id_A4A8 = 0;
  }

  if(self._id_A4A8 % 3 == 0 || self._id_A78C < 5) {
    if(self._id_A78C < 15) {
      if(isDefined(self._id_A4C5)) {
        _id_E313(self._id_A4C5);
        self._id_A4C5 = undefined;
      } else
        _id_5EC5();
    }
  }

  self._id_A4A8++;
}

_id_3A2F() {
  _id_48A9();

  if(!isDefined(self._id_A4C5)) {
    self._id_A4C5 = _id_5B02();
  }
}

_id_3A30() {
  self._id_9AAD delete();
  self._id_B711 = undefined;
  self._id_EABE = undefined;

  foreach(var_1 in self._id_8B33) {
    var_1 notify("remove_locale");
    var_1 hide();
    var_1 makeunusable();
    var_1.origin = var_1.origin + (0, 0, -500);
    var_1 delete();
  }

  _id_07F9::_id_C799(self._id_A8DA);
}

_id_3A2B(var_0, var_1) {
  if(!isDefined(self._id_8FAC)) {
    self._id_8FAC = -1;
  }

  var_2 = gettime();

  if(self._id_8FAC == var_2) {
    return;
  }
  self._id_8FAC = var_2;
  var_3 = distance2d(self._id_4140, var_0);

  if(var_3 > var_1) {
    foreach(var_5 in self._id_EABE) {
      scripts\mp\gametypes\br_quest_util::_id_6C96("collection", var_5) _id_58D5();
    }
  }
}

_id_353A(var_0) {
  if(_func_03DC()) {
    var_0 = _func_02AB(var_0);
  }

  return var_0;
}