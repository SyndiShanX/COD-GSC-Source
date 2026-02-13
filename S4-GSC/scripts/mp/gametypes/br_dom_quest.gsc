/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_dom_quest.gsc
*************************************************/

init() {
  var_0 = scripts\mp\gametypes\br_quest_util::_id_C2A1("domination", 1);

  if(!var_0) {
    return;
  }
  scripts\mp\gametypes\br_quest_util::_id_C2BF("domination", ::_id_4D5E);
  scripts\mp\gametypes\br_quest_util::_id_C2A7("domination", ::_id_4D5B);
  scripts\mp\gametypes\br_quest_util::_id_C2A4("dom_locale");
  scripts\mp\gametypes\br_quest_util::_id_C24F("dom_locale", ::_id_4D3A);
  scripts\mp\gametypes\br_quest_util::_id_C246("dom_locale", ::_id_4D38);
  scripts\mp\gametypes\br_quest_util::_id_C2A7("dom_locale", ::_id_4D3E);
  scripts\mp\gametypes\br_quest_util::_id_C2A3("dom_locale", ::_id_4D39);
  scripts\mp\gametypes\br_quest_util::_id_C286("dom_locale", ::_id_4D3C);
  scripts\mp\gametypes\br_quest_util::_id_C28E("dom_locale", ::_id_4D3D);
  scripts\mp\gametypes\br_quest_util::_id_6C94("dom_locale")._id_A4A7 = 0;
  scripts\mp\gametypes\br_quest_util::_id_BEBA("domination", 1);
  scripts\mp\gametypes\br_quest_util::_id_C28F("domination", ::_id_4D11);
  _id_D865();
  game["dialog"]["mission_dom_accept"] = "mission_mission_dom_accept_secure";
  game["dialog"]["mission_dom_success"] = "mission_mission_dom_success";
}

_id_4D5B() {
  scripts\mp\gametypes\br_quest_util::_id_C305(self.team);
  scripts\mp\gametypes\br_quest_util::_id_F91F(self.team);
  self._id_EABF thread _id_4D2D();
}

_id_4D3E() {
  foreach(var_1 in self._id_EABE) {
    var_1 thread scripts\mp\gametypes\br_quest_util::_id_C50F();
  }

  _id_4766();
  self._id_4D1E = undefined;
}

_id_4D5E() {
  var_0 = _id_6D21(self);
  var_1 = scripts\mp\gametypes\br_quest_util::_id_5B04("domination", var_0);

  if(!isDefined(var_1)) {
    return 0;
  }

  _func_03FA(var_1.index);
  self._id_C59A = var_1;
  return 1;
}

_id_4D3A(var_0) {
  scripts\mp\gametypes\br_quest_util::_id_6C94("dom_locale")._id_A4A7++;
  var_1 = scripts\mp\gametypes\br_quest_util::_id_400D("dom_locale", "domination", "DomPoint:" + scripts\mp\gametypes\br_quest_util::_id_6C94("dom_locale")._id_A4A7);

  if(!isDefined(var_0)) {
    var_1._id_4140 = (0, 0, 0);
    var_1._id_523F = 0;
    return var_1;
  }

  var_2 = var_0.origin;

  if(!(var_0._id_03EA & 7)) {}

  var_3 = scripts\mp\gametypes\br_quest_util::_id_BEB4(var_0);
  var_4 = spawn("trigger_radius", var_2, 0, int(var_3), int(level._id_2A37));
  level._id_D530 = ::_id_4D26;
  var_5 = scripts\mp\gametypes\obj_dom::_id_D896(var_4);
  var_5._id_5C3F setModel("lm_domination_point_01");
  var_5._id_ABCB = ::_id_4D24;
  var_5._id_AA79 = ::_id_4D22;
  var_5._id_ABD4 = ::_id_4D25;
  var_5._id_AAC2 = ::_id_4D23;
  var_5._id_FE35 = ::_id_4D29;
  var_5 _id_07D6::_id_D8E0("any");
  var_5 scripts\mp\gametypes\obj_dom::_id_4D27();
  var_5._id_970A = 1;
  var_5._id_356F = 1;
  _id_07F9::_id_FB97(var_5._id_A908, var_5._id_4140 + (0, 0, 60));
  level._id_5C3B = getdvarfloat("#x36ff38044da3daa0e", 30);
  var_5 _id_07D6::_id_D8D2(level._id_5C3B);
  var_1._id_8FAC = -1;
  var_1._id_4D1E = var_5;
  var_1._id_4140 = var_5._id_4140;
  var_5._id_96C9 = var_1;
  scripts\mp\gametypes\br_quest_util::_id_1118("dom_locale", var_1);
  return var_1;
}

_id_4D38(var_0) {
  var_1 = getdvarfloat("#x38c8a88661c4c3b9d", 0.2);
  var_2 = getdvarfloat("#x339f364798f7ef7f3", 4);
  var_3 = 0;

  if(isDefined(self._id_4D1E._id_4143)) {
    var_3 = self._id_4D1E._id_4143 / self._id_4D1E._id_FEE7;
  }

  if(var_3 > var_1) {
    return 0;
  }

  if(self._id_EABE.size >= var_2) {
    return 0;
  }

  return 1;
}

_id_4D39(var_0, var_1) {
  if(!isDefined(self._id_4D1E)) {
    return;
  }
  var_2 = gettime();

  if(self._id_8FAC == var_2) {
    return;
  }
  self._id_8FAC = var_2;
  var_3 = distance2d(self._id_4140, var_0);

  if(var_3 > var_1) {
    foreach(var_5 in self._id_EABE) {
      scripts\mp\gametypes\br_quest_util::_id_4B82(var_5.team, "br_domination_quest_circle_failure");
      level thread scripts\mp\gametypes\br_public::_id_2BDE("mission_obj_circle_fail", var_5.team, 1);
      var_5._id_0372 = "circle";
    }

    scripts\mp\gametypes\br_quest_util::_id_C50F();
  }
}

_id_4D3C(var_0) {
  _id_4D20(var_0);
}

_id_4D3D(var_0) {
  if(var_0.team == self._id_EABE[0].team) {
    _id_4D28(var_0);
  }
}

_id_EDD3(var_0) {
  var_1 = scripts\mp\gametypes\br_quest_util::_id_4039("domination", self.team, var_0.index, var_0);
  var_1 scripts\mp\gametypes\br_quest_util::_id_C2C0(self.team, self);
  var_1 scripts\mp\gametypes\br_quest_util::_id_C24A(self);
  var_1.team = self.team;
  var_1._id_EC76 = var_0;
  var_2 = getdvarint("#x3bcddc959105dbe56", 240);
  var_1 scripts\mp\gametypes\br_quest_util::_id_BEBB(var_2, 4);
  var_3 = _id_6D21(var_0);
  var_4 = var_1 scripts\mp\gametypes\br_quest_util::_id_C580("dom_locale", var_3, 1);

  if(!var_4._id_523F) {
    var_1._id_0372 = "no_locale";
    var_1 scripts\mp\gametypes\br_quest_util::_id_C305(self.team);
    return;
  }

  var_4 _id_4D2C();
  scripts\mp\gametypes\br_quest_util::_id_F922("domination", self.team);
  scripts\mp\gametypes\br_quest_util::_id_1118("domination", var_1);
  scripts\mp\gametypes\br_quest_util::_id_E72C("domination", self, self.team);
  var_5 = spawnStruct();
  var_5._id_56DD = [];
  var_5._id_56DD[0] = self;
  var_5._id_B97D = scripts\mp\gametypes\br_quest_util::_id_6C98("domination", scripts\mp\gametypes\br_quest_util::_id_6CA3(self.team));
  scripts\mp\gametypes\br_quest_util::_id_4B82(self.team, "br_domination_quest_start_team", var_5);
  scripts\mp\gametypes\br_quest_util::_id_4B7A(self, "br_domination_quest_start_tablet_finder", var_5);
  scripts\mp\gametypes\br_quest_util::_id_7000(self.team, "br_mission_pickup_tablet");
  scripts\mp\gametypes\br_quest_util::_id_4B81(var_1.team, self, 6, scripts\mp\gametypes\br_quest_util::_id_6C95("domination"));
  level thread scripts\mp\gametypes\br_public::_id_2BDE("mission_dom_accept", var_1.team, 1);
}

_id_4D2C() {
  _func_018C(self._id_4D1E._id_A908);
  _func_018B(self._id_4D1E._id_A908);

  foreach(var_1 in self._id_EABE) {
    foreach(var_3 in scripts\mp\utility\teams::_id_6DCA(var_1.team, "players")) {
      if(!var_3 scripts\mp\gametypes\br_public::_id_8990()) {
        _func_0185(self._id_4D1E._id_A908, var_3);
      }
    }
  }
}

_id_4D20(var_0) {
  _func_0189(self._id_4D1E._id_A908, var_0);
}

_id_4D28(var_0) {
  _func_0185(self._id_4D1E._id_A908, var_0);
}

_id_4D2D() {
  self endon("removed");
  waittillframeend;
  _id_4D2C();
}

_id_4766() {
  foreach(var_1 in self._id_4D1E._id_10430) {
    var_1 delete();
  }

  if(isDefined(self._id_4D1E._id_5C3F)) {
    self._id_4D1E._id_5C3F delete();
  }

  if(isDefined(self._id_4D1E._id_03A9)) {
    self._id_4D1E._id_03A9 delete();
  }

  if(isDefined(self._id_4D1E.trigger)) {
    self._id_4D1E.trigger delete();
    self._id_4D1E.trigger = undefined;
  }

  self._id_4D1E thread _id_60DA();
  self._id_4D1E notify("deleted");
}

_id_60DA() {
  wait 0.1;
  _id_07D6::_id_C300();
}

_id_D865() {
  if(isDefined(level._id_2A37)) {
    return;
  }
  level._id_4ABE = 0;
  level._id_2A37 = 120;
  level._id_7C74 = "waypoint_captureneutral_br";
  level._id_7C42 = "waypoint_capture_br";
  level._id_7C4B = "waypoint_defend_br";
  level._id_7C50 = "waypoint_defending_br";
  level._id_7C48 = "waypoint_contested_br";
  level._id_7C87 = "waypoint_taking_br";
  level._id_7C6F = "waypoint_losing_br";
  level._id_7C76 = "icon_waypoint_ot";
  _id_0CE7("icon_waypoint_dom_br", "neutral", "MP_BR_INGAME/DOM_CAPTURE", 0);
  _id_0CE7("waypoint_taking_br", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", 1);
  _id_0CE7("waypoint_capture_br", "enemy", "MP_BR_INGAME/DOM_CAPTURE", 0);
  _id_0CE7("waypoint_defend_br", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", 0);
  _id_0CE7("waypoint_defending_br", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", 0);
  _id_0CE7("waypoint_blocking_br", "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", 0);
  _id_0CE7("waypoint_blocked_br", "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", 0);
  _id_0CE7("waypoint_losing_br", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", 1);
  _id_0CE7("waypoint_captureneutral_br", "neutral", "MP_BR_INGAME/DOM_CAPTURE", 0);
  _id_0CE7("waypoint_contested_br", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", 1);
  _id_0CE7("waypoint_dom_target_br", "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", 0);
  _id_0CE7("icon_waypoint_target_br", "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", 0);
  _id_0CE7("icon_waypoint_ot", "neutral", "MP_INGAME_ONLY/OBJ_OTFLAGLOC_CAPS", 0);
}

_id_0CE7(var_0, var_1, var_2, var_3) {
  level._id_10CCD[var_0] = var_1;
  level._id_10CCC[var_0] = 1;
  level._id_10CD9[var_0] = var_2;
  level._id_10CD8[var_0] = "ui_mp_br_mapmenu_icon_dom_objective";
  level._id_10CD1[var_0] = var_3;
}

_id_4D25(var_0, var_1, var_2, var_3) {
  if(var_1 < 1.0 && !level.gameended) {
    _id_B2E5(var_1, var_0);
  }

  if(var_1 > 0.05 && var_2 && !istrue(self._id_497A)) {
    self._id_497A = 1;
  }
}

_id_4D22(var_0) {
  if(!isDefined(self._id_A7F0) || !self._id_A7F0) {
    self._id_A7F0 = 1;
    level thread scripts\mp\gametypes\br_quest_util::_id_FF21(self._id_4140, "dom");
    var_1 = scripts\mp\utility\player::_id_6DC4(var_0.team);
    var_2 = scripts\mp\utility\player::_id_6C5F(self._id_4140, 7800, undefined, var_1);

    foreach(var_4 in var_2) {
      if(isDefined(var_4) && isalive(var_4)) {
        var_4 thread scripts\mp\hud_message::showsplash("br_domination_quest_alert");
      }
    }

    var_6 = scripts\mp\utility\teams::_id_6A59(var_0.team, 0);

    foreach(var_8 in var_6) {
      var_8 notify("calloutmarkerping_warzoneKillQuestIcon");
    }
  }
}

_id_4D24(var_0) {
  foreach(var_2 in self._id_96C9._id_EABE) {
    if(var_2.team == var_0.team) {
      var_3 = spawnStruct();
      var_4 = scripts\mp\gametypes\br_quest_util::_id_6CA3(var_0.team);
      var_5 = scripts\mp\gametypes\br_quest_util::_id_6C95("domination");
      var_6 = scripts\mp\gametypes\br_quest_util::_id_6C9D(scripts\mp\gametypes\br_quest_util::_id_6C9C("domination"));
      var_3._id_ADCB = scripts\mp\gametypes\br_quest_util::_id_ADCE(var_5, var_4, var_6);
      scripts\mp\gametypes\br_quest_util::_id_4B82(var_2.team, "br_domination_quest_complete", var_3);
      scripts\mp\gametypes\br_quest_util::_id_4B81(var_2.team, var_0, 8, var_5);
      level thread scripts\mp\gametypes\br_public::_id_2BDE("mission_dom_success", var_2.team, 1, 1);
      var_2._id_C810 = self._id_5C3F.origin;
      var_2._id_C805 = self._id_5C3F.angles;
      var_2._id_0372 = "success";

      if(isDefined(self._id_1D2E[var_2.team])) {
        var_7 = getarraykeys(self._id_1D2E[var_2.team]);

        foreach(var_9 in var_7) {
          var_10 = self._id_1D2E[var_2.team][var_9].player;

          if(isDefined(var_10.owner)) {
            var_10 = var_10.owner;
          }

          if(!isPlayer(var_10)) {
            continue;
          }
          var_2 scripts\mp\gametypes\br_quest_util::_id_C24A(var_10);
        }
      }

      continue;
    }

    scripts\mp\gametypes\br_quest_util::_id_4B82(var_2.team, "br_domination_quest_failure");
    level thread scripts\mp\gametypes\br_public::_id_2BDE("mission_gen_fail", var_2.team, 1);
    var_2._id_0372 = "fail";
  }

  self._id_96C9 thread scripts\mp\gametypes\br_quest_util::_id_C50F();
}

_id_4D23(var_0, var_1, var_2) {
  scripts\mp\gametypes\obj_dom::_id_4D51(var_0, var_1, var_2);
}

_id_B2E5(var_0, var_1) {
  if(!isDefined(self._id_903F)) {
    self._id_903F = gettime();
  }

  if(self._id_903F + 995 < gettime()) {
    self._id_903F = gettime();
    var_2 = "";
    var_0 = int(floor(var_0 * 10));
    var_2 = "mp_dom_capturing_tick_0" + var_0;
    self._id_10430[0] playsoundtoteam(var_2, var_1);
  }
}

_id_4D26(var_0, var_1, var_2) {
  switch (var_1) {
    case "contested":
    case "idle":
    case "off":
      return 0;
    default:
      var_1 = "using";

      if(isDefined(var_2)) {
        var_1 = var_1 + var_2;
      }

      self._id_03A9 setscriptablepartstate(var_0, var_1);

      if(var_0 == "pulse") {
        self._id_03A9 setscriptablepartstate("flag", var_1);
      }

      return 1;
  }
}

_id_4D29(var_0) {
  var_1 = var_0.team;

  foreach(var_3 in self._id_96C9._id_EABE) {
    if(var_3.team == var_1) {
      return 1;
    }
  }

  return 0;
}

_id_4D11() {
  while(self._id_EABF._id_4D1E._id_A79A[self._id_7C8C]) {
    waitframe();
  }

  scripts\mp\gametypes\br_quest_util::_id_4B82(self._id_7C8C, "br_domination_quest_timer_expired");
  level thread scripts\mp\gametypes\br_public::_id_2BDE("mission_gen_fail", self.team, 1);
}

_id_6D21(var_0) {
  var_1 = spawnStruct();
  var_1._id_CFB5 = "questPointsArray";
  var_1._id_CFAF = (var_0.origin[0], var_0.origin[1], 0);
  var_1._id_CFBA = 12000;
  var_1._id_CFBB = 0;
  var_1._id_CFB8 = 8000;
  var_1._id_CFB9 = 6000;
  var_1._id_BEBE = 7;
  var_1._id_9F41 = getdvarfloat("#x36ff38044da3daa0e", 30);
  var_1._id_CFB2 = 1;
  var_1._id_C59A = var_0._id_C59A;

  if(getDvar("#x3f59526763711edc4", "") == "dmz") {
    if(var_1._id_CFBA < level._id_BEA3) {
      var_1._id_CFBA = level._id_BEA3;
    }

    var_1._id_CFB8 = level._id_BEA3;
    var_1._id_CFB9 = level._id_BEA4;
  }

  return var_1;
}