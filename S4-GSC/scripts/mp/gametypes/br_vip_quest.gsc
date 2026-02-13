/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_vip_quest.gsc
*************************************************/

init() {
  var_0 = scripts\mp\gametypes\br_quest_util::_id_C2A1("vip", 1);

  if(!var_0) {
    return;
  }
  scripts\mp\gametypes\br_quest_util::_id_C2A7("vip", ::_id_10401);
  scripts\mp\gametypes\br_quest_util::_id_C28C("vip", ::_id_103FD);
  scripts\mp\gametypes\br_quest_util::_id_C288("vip", ::_id_103FE);
  scripts\mp\gametypes\br_quest_util::_id_C286("vip", ::_id_103F7);
  scripts\mp\gametypes\br_quest_util::_id_C28E("vip", ::_id_103F8);
  scripts\mp\gametypes\br_quest_util::_id_C2A5("vip", ::_id_10400, 2);
  game["dialog"]["hvt_accept"] = "contract_hvt_accept";
  game["dialog"]["mission_hvt_accept_first_person"] = "mission_mission_hvt_accept_first_person";
  game["dialog"]["mission_hvt_success_third_person"] = "mission_mission_hvt_success_third_person";
  game["dialog"]["mission_hvt_success_first_person"] = "mission_mission_hvt_success_first_person";
  game["dialog"]["mission_hvt_failure"] = "mission_mission_hvt_failure";
  game["dialog"]["mission_hvt_eliminated"] = "mission_mission_hvt_eliminated";
  scripts\mp\gametypes\br_quest_util::_id_BEBA("vip", 1);
  scripts\mp\gametypes\br_quest_util::_id_C28F("vip", ::_id_103F9);
}

_id_EDD3(var_0) {
  var_1 = scripts\mp\gametypes\br_quest_util::_id_4039("vip", self.team, var_0.index, var_0);
  var_1 scripts\mp\gametypes\br_quest_util::_id_C2C0(self.team, self);
  scripts\mp\gametypes\br_quest_util::_id_7000(self.team, "br_mission_pickup_tablet");
  var_1.team = self.team;
  var_1._id_103EE = self;
  var_1 scripts\mp\gametypes\br_quest_util::_id_403A("ui_mp_br_mapmenu_icon_vip_objective", "active");
  var_1 _id_1040E();
  var_1 scripts\mp\gametypes\br_quest_util::_id_BEBB(getdvarint("#x3cbc4d2e77c61bf78", 300), 4);
  scripts\mp\gametypes\br_quest_util::_id_1118("vip", var_1);
  scripts\mp\gametypes\br_quest_util::_id_E72C("vip", self, self.team);
  var_2 = spawnStruct();
  var_2._id_56DD = [];
  var_2._id_56DD[0] = var_1._id_103EE;
  var_2._id_56DE = [];
  var_2._id_56DE[0] = var_1.team;
  var_2._id_B97D = scripts\mp\gametypes\br_quest_util::_id_6C98("vip", scripts\mp\gametypes\br_quest_util::_id_6CA3(self.team));
  scripts\mp\gametypes\br_quest_util::_id_4B82(var_1.team, "br_vip_quest_start_vip_team", var_2);
  scripts\mp\gametypes\br_quest_util::_id_4B7A(var_1._id_103EE, "br_vip_quest_start_tablet_finder", var_2);
  scripts\mp\gametypes\br_quest_util::_id_4B7F("br_vip_quest_vip_spawn_alert", self.origin, 5000, level._id_BEAF._id_45B2, var_2);
  level thread scripts\mp\gametypes\br_public::_id_2BDF("hvt_accept", var_1.team, var_1._id_103EE, 1, 0.5);
  level thread scripts\mp\gametypes\br_public::_id_2BDD("mission_hvt_accept_first_person", var_1._id_103EE, 1, 0.5);
}

_id_1040E() {
  self._id_5FB6 = spawnStruct();
  self._id_5FB6 scripts\mp\gametypes\br_quest_util::_id_403A("ui_mp_br_mapmenu_icon_vip_objective_friendly_p" + self._id_103EE._id_2ABC, "invisible", (0, 0, 0));
  _id_07F9::_id_A88D(self._id_5FB6._id_A8DA, self);
  _id_07F9::_id_FB9D(self._id_5FB6._id_A8DA, 75);
  _id_07F9::_id_A8B1(self._id_5FB6._id_A8DA, 0);
  _id_07F9::_id_A8B2(self._id_5FB6._id_A8DA, 0);
  _id_07F9::_id_FB93(self._id_5FB6._id_A8DA, self._id_103EE);
  _func_0188(self._id_A8DA);
  var_0 = scripts\mp\gametypes\br_quest_util::_id_E03C(level.players);

  foreach(var_2 in var_0["valid"]) {
    scripts\mp\gametypes\br_quest_util::_id_DCDC(var_2);
  }

  foreach(var_2 in var_0["invalid"]) {
    scripts\mp\gametypes\br_quest_util::_id_7914(var_2);
  }

  foreach(var_2 in scripts\mp\utility\teams::_id_6DCA(self.team, "players")) {
    if(!var_2 scripts\mp\gametypes\br_public::_id_8990()) {
      _id_1040F(var_2);
    }

    scripts\mp\gametypes\br_quest_util::_id_7914(var_2);
  }
}

_id_103FD(var_0, var_1) {
  if(var_1 scripts\mp\gametypes\br_public::_id_8990() || var_0 scripts\mp\gametypes\br_public::_id_8990()) {
    return;
  }
  _id_103FF(var_1, var_0);
}

_id_103FE(var_0) {
  _id_103FF(var_0);
}

_id_103F7(var_0) {
  _id_1040D(var_0);
}

_id_103F8(var_0) {
  if(var_0.team == self.team) {
    _id_1040F(var_0);
  }

  scripts\mp\gametypes\br_quest_util::_id_DCDC(var_0);
}

_id_103FF(var_0, var_1) {
  if(var_0.team == self.team) {
    if(var_0 == self._id_103EE) {
      _id_103F3(var_1);
    } else {
      _id_1040D(var_0);
    }
  } else
    scripts\mp\gametypes\br_quest_util::_id_7914(var_0);
}

_id_103F9() {
  _id_103EF();
}

_id_10401() {
  _id_1040C();
  scripts\mp\gametypes\br_quest_util::_id_C305(self.team);
}

_id_1040F(var_0) {
  var_0 scripts\mp\gametypes\br_quest_util::_id_F921("vip");
  var_0 scripts\mp\gametypes\br_quest_util::_id_F920(self._id_103EE getentitynumber());
  scripts\mp\gametypes\br_quest_util::_id_DCDC(var_0);

  if(self.team == var_0.team) {
    self._id_5FB6 scripts\mp\gametypes\br_quest_util::_id_DCDC(var_0);
  }
}

_id_1040D(var_0) {
  var_0 scripts\mp\gametypes\br_quest_util::_id_F91E();
  scripts\mp\gametypes\br_quest_util::_id_7914(var_0);

  if(self.team == var_0.team) {
    self._id_5FB6 scripts\mp\gametypes\br_quest_util::_id_7914(var_0);
  }
}

_id_1040C() {
  foreach(var_1 in scripts\mp\utility\teams::_id_6DCA(self.team, "players")) {
    _id_1040D(var_1);
  }

  self._id_5FB6 scripts\mp\gametypes\br_quest_util::_id_4789();
  scripts\mp\gametypes\br_quest_util::_id_4789();
}

_id_103EF() {
  var_0 = spawnStruct();
  var_1 = scripts\mp\gametypes\br_quest_util::_id_6CA3(self.team);
  var_2 = scripts\mp\gametypes\br_quest_util::_id_6C95("vip");
  var_3 = scripts\mp\gametypes\br_quest_util::_id_6C9D(scripts\mp\gametypes\br_quest_util::_id_6C9C("vip"));
  var_0._id_ADCB = scripts\mp\gametypes\br_quest_util::_id_ADCE(var_2, var_1, var_3);
  scripts\mp\gametypes\br_quest_util::_id_4B82(self.team, "br_vip_quest_complete", var_0);
  level thread scripts\mp\gametypes\br_public::_id_2BDF("mission_hvt_success_third_person", self.team, self._id_103EE, 1, 0, 0.5);
  level thread scripts\mp\gametypes\br_public::_id_2BDD("mission_hvt_success_first_person", self._id_103EE, 1, 0, 0.5);

  foreach(var_5 in scripts\mp\utility\teams::_id_6DCA(self.team, "players")) {
    if(istrue(var_5.inlaststand)) {
      var_5 _id_07E8::_id_5B1D("use_hold_revive_success", var_5);
    }

    if(!isalive(var_5)) {
      var_5 thread scripts\mp\gametypes\br_gulag::_id_B6C6(self);
    }
  }

  self._id_C80A = undefined;
  self._id_C810 = self._id_103EE.origin;
  self._id_C805 = self._id_103EE.angles;
  self._id_0372 = "success";
  thread scripts\mp\gametypes\br_quest_util::_id_C50F();
}

_id_103F3(var_0) {
  if(isDefined(var_0) && isPlayer(var_0) && var_0.team != self.team) {
    var_1 = spawnStruct();
    var_2 = scripts\mp\gametypes\br_quest_util::_id_6CA3(var_0.team);
    var_3 = scripts\mp\gametypes\br_quest_util::_id_6C95("vip");
    var_4 = scripts\mp\gametypes\br_quest_util::_id_6C9D(scripts\mp\gametypes\br_quest_util::_id_6C9C("vip", self._id_C80A, self._id_02D0));
    var_1._id_ADCB = scripts\mp\gametypes\br_quest_util::_id_ADCE(var_3, var_2, var_4);
    scripts\mp\gametypes\br_quest_util::_id_4B82(var_0.team, "br_vip_quest_you_killed_the_vip", var_1);
    level thread scripts\mp\gametypes\br_public::_id_2BDE("mission_hvt_eliminated", var_0.team, 1, 1);
    self._id_C80A = "_killer";
    scripts\mp\gametypes\br_quest_util::_id_6FDB(var_0.team, self._id_103EE.origin, self._id_103EE.angles, self._id_C812);
    level thread scripts\mp\gametypes\br_public::_id_2BDE("mission_hvt_failure", self.team, 1, 1);
    self._id_C80A = undefined;
    self._id_0372 = "fail";
  }

  scripts\mp\gametypes\br_quest_util::_id_4B82(self.team, "br_vip_quest_failure");
  self._id_C80A = undefined;
  self._id_0372 = "fail";
  scripts\mp\gametypes\br_quest_util::_id_C50F();
}

_id_10400() {
  scripts\mp\gametypes\br_quest_util::_id_A24B(self._id_103EE.origin);
}