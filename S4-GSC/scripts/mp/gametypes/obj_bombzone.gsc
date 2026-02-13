/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_bombzone.gsc
*************************************************/

_id_D896(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;

  if(isDefined(level._id_413D)) {
    level._id_413D _id_07D6::_id_479D();
  }

  if(isDefined(var_0._id_AC91)) {
    var_0.origin = var_0._id_AC91;
  } else {
    var_0._id_AC91 = var_0.origin;
  }

  var_5 = getEntArray(var_0.target, "targetname");

  if(isDefined(var_0._id_A8E1)) {
    var_6 = var_0._id_A8E1;
  } else {
    var_6 = var_0._id_CD99;
  }

  if(istrue(var_2)) {
    var_7 = _id_6CED(var_6);
  } else {
    var_7 = undefined;
  }

  if(scripts\mp\utility\game::getgametype() == "dd" || scripts\mp\utility\game::getgametype() == "to_dd") {
    var_4 = var_0._id_CD99;
    var_8 = getent("dd_bombzone_clip" + var_4, "targetname");

    if(scripts\mp\utility\game::_id_82D1()) {
      if(var_4 == "_a" || var_4 == "_b") {
        var_0 delete();
        var_5[0] delete();
        var_8 delete();
        return;
      }

      var_3 = _id_07D6::_id_406E("neutral", var_0, var_5, (0, 0, 64), var_7, var_1);
      var_3 _id_07D6::_id_15DF("any");
      var_3.trigger._id_CD99 = "_a";
    } else if(var_4 == "_c") {
      var_0 delete();
      var_5[0] delete();
      var_8 delete();
      return;
    }
  } else if(scripts\mp\utility\game::getgametype() == "sd")
    setomnvar("ui_bomb_owner_team", 0);

  if(!isDefined(var_3)) {
    var_3 = _id_07D6::_id_406E(game["defenders"], var_0, var_5, (0, 0, 64), var_7, var_1);
    var_3 _id_07D6::_id_15DF("enemy");
  }

  if(isDefined(var_0._id_A8E1)) {
    var_3._id_A8E1 = var_0._id_A8E1;
  } else {
    var_3._id_A8E1 = var_3 _id_07D6::_id_6AF1();
  }

  if(isDefined(var_0._id_7C73)) {
    var_3._id_7C73 = var_0._id_7C73;
  } else {
    var_3._id_7C73 = var_3 _id_07D6::_id_6AF1();
  }

  var_3._id_7C8C = "bomb_zone";
  var_3.trigger _meth_83A1(-300);
  var_3 _id_07D6::_id_D8D2(level._id_B1DA);
  var_3 _id_07D6::_id_D8E3(0);
  var_3 _id_07D6::_id_D8D0(&"MP/HOLD_TO_PLANT_EXPLOSIVES");
  var_3.trigger setuseholdduration("duration_none");

  if(!level._id_A2F7) {
    var_3 _id_07D6::_id_D5C5(level._id_CFA2);
  }

  if(var_3._id_A8E1 == "_c") {
    var_3._id_A8E1 = "_a";
    var_3._id_7C73 = "_a";
  }

  if((scripts\mp\utility\game::getgametype() == "to_dd" || scripts\mp\utility\game::getgametype() == "cmd") && scripts\mp\utility\game::_id_82D1()) {
    var_3 _id_07D6::_id_D61B("waypoint_target");
    var_3 _id_07D6::_id_D8E0("any");
  }

  var_3._id_AA79 = ::_id_268A;
  var_3._id_AAC2 = ::_id_268F;
  var_3._id_ABCB = ::_id_2691;
  var_3._id_AA80 = ::_id_268C;

  if(scripts\mp\utility\game::isholidayenabled(2)) {
    var_3.useweapon = makeweapon("s4_bomb_remote_holiday_mp");
  } else if(scripts\mp\utility\game::isholidayenabled(3)) {
    var_3.useweapon = makeweapon("s4_bomb_remote_vday_mp");
  } else {
    var_3.useweapon = makeweapon("s4_bomb_remote_mp");
  }

  var_3._id_2663 = 0;
  var_3._id_265C = undefined;
  var_3._id_C63B = level._id_C63B;

  for(var_9 = 0; var_9 < var_5.size; var_9++) {
    if(isDefined(var_5[var_9]._id_0397)) {
      var_3._id_57CB = var_5[var_9]._id_0397;
      var_5[var_9] thread setuphuddata(var_3);
      var_5[var_9] thread _id_D886(var_3);
      break;
    }
  }

  var_3._id_2636 = getent(var_5[0].target, "targetname");
  var_3._id_2636.origin = var_3._id_2636.origin + (0, 0, -10000);
  var_3._id_2636.label = var_4;
  var_3._id_A6C9 = spawn("trigger_radius", var_3.trigger.origin, 0, 140, 100);
  return var_3;
}

_id_6CED(var_0) {
  if(var_0 == "_a") {
    var_1 = 0;
  } else {
    var_1 = 1;
  }

  return var_1;
}

_id_D886(var_0) {
  var_1 = spawn("script_origin", self.origin);
  var_1.angles = self.angles;
  var_1 rotateyaw(-45, 0.05);
  waitframe();
  var_2 = undefined;
  var_3 = self.origin + (0, 0, 45);
  var_4 = self.origin + anglesToForward(var_1.angles) * 100 + (0, 0, 128);
  var_5 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle"];
  var_6 = physics_createcontents(var_5);
  var_7 = scripts\engine\trace::ray_trace(var_3, var_4, self, var_6);
  var_2 = var_7["position"];

  if(scripts\cp_mp\utility\game_utility::_id_6B2D() == "mp_skyway" && var_0._id_A8E1 == "_b") {
    var_2 = (326, 595, 85);
  }

  self.killcament = spawn("script_model", var_2);
  self.killcament _meth_8375("explosive");
  var_0._id_8D65 = self.killcament getentitynumber();
  var_1 delete();
}

_id_15B2(var_0) {
  scripts\common\utility::_id_154E(var_0);
  scripts\mp\utility\player::_id_1543(var_0);

  if(var_0) {
    scripts\engine\utility::_id_108A7(0.8, "bomb_allow_offhands");
    scripts\common\utility::_id_1554(var_0);
    scripts\common\utility::_id_1553(var_0);
  } else {
    scripts\common\utility::_id_1554(var_0);
    scripts\common\utility::_id_1553(var_0);
  }

  scripts\common\utility::_id_1562(var_0);
}

_id_D49F(var_0) {
  if(var_0 == "_a") {
    var_1 = 1;
  } else {
    var_1 = 2;
  }

  setomnvar("ui_bomb_interacting", var_1);
}

_id_D49E(var_0) {
  if(var_0 == "_a") {
    var_1 = 3;
  } else {
    var_1 = 4;
  }

  setomnvar("ui_bomb_interacting", var_1);
}

_id_268A(var_0) {
  var_0 thread _id_15B2(0);

  if(!_id_07D6::_id_886F(var_0.pers["team"]) && self._id_2663) {
    var_0 scripts\mp\bots\bots_util::_id_A66D("defuse");
    var_0 notify("super_obj_drain");
    var_0._id_87F7 = 1;
    var_0 _id_D49E(self._id_A8E1);
    setomnvar("ui_bomb_defuser", var_0 getentitynumber());

    if(isDefined(level.player) && level.player _meth_81D3()) {
      _id_07D6::_id_D61B("waypoint_bomb_defusing");
    } else {
      _id_07D6::_id_D61B("waypoint_bomb_defend_nt", "waypoint_bomb_defusing");
    }

    _id_07F9::_id_A8C9(self._id_BF19, var_0.team);
    _id_0A8D::_id_E775("bomb_defusing", var_0.team, "status");
    scripts\mp\utility\game::_id_D5FA(2, var_0.team, var_0 getentitynumber());

    if(isDefined(level._id_CFA3)) {
      level._id_CFA3 hide();
    } else if(isDefined(level._id_436B[self._id_A8E1])) {
      level._id_436B[self._id_A8E1] hide();
    }
  } else {
    var_1 = 2;

    if(self._id_A8E1 == "_a") {
      var_1 = 1;
    }

    var_0 scripts\mp\bots\bots_util::_id_A66D("plant");
    var_0 notify("super_obj_drain");
    var_0._id_8986 = 1;
    var_0._id_2668 = self.useweapon;
    var_0 _id_D49F(self._id_A8E1);
    _id_0A8D::_id_E775("bomb_planting", var_0.team, "status");
    _id_07D6::_id_D61B("waypoint_defend", "waypoint_bomb_planting");
  }
}

_id_268F(var_0, var_1, var_2) {
  setomnvar("ui_bomb_interacting", 0);
  setomnvar("ui_bomb_defuser", -1);
  var_3 = self._id_A908;

  if(level._id_C63B) {
    setomnvar("ui_bomb_owner_team", -1);
    _id_07F9::_id_A8B4(var_3, 0);
    _id_07F9::_id_A8C4(var_3, 0);
  }

  if(!var_2) {
    if(var_1._id_87F7) {
      _id_07D6::_id_D61B("waypoint_defuse_nt", "waypoint_bomb_defend_nt");
    } else if(scripts\mp\utility\game::getgametype() == "btm") {
      _id_07D6::_id_D61B(level._id_7C79);
    } else {
      _id_07D6::_id_D61B("waypoint_defend", "waypoint_target");
    }

    if(isDefined(self._id_BF19)) {
      _id_07F9::_id_A8C8(self._id_BF19, var_1.team);
    }
  }

  if(!isDefined(var_1)) {
    return;
  }
  var_1 thread _id_15B2(1);
  var_1._id_2668 = undefined;

  if(isalive(var_1)) {
    var_1._id_87F7 = 0;
    var_1._id_8986 = 0;
  }

  if(isPlayer(var_1)) {
    var_1 setclientomnvar("ui_objective_state", 0);
    var_1._id_F90B = undefined;
  }

  if(!_id_07D6::_id_886F(var_1.pers["team"])) {
    if(isDefined(level._id_CFA3) && !var_2) {
      if(self._id_2663) {
        level._id_CFA3 show();
      }
    } else if(isDefined(level._id_436B)) {
      if(isDefined(level._id_436B[self._id_A8E1]) && !var_2) {
        level._id_436B[self._id_A8E1] show();
      }
    }
  }
}

_id_E6FD(var_0, var_1) {
  self endon("death");
  self endon("stopNpcBombSound");

  if(scripts\mp\utility\game::isanymlgmatch() || istrue(level._id_DD44) || scripts\mp\utility\perk::_hasperk("specialty_engineer")) {
    self _meth_84A8("silent_plant", "on");
    return;
  }

  for(;;) {
    self waittill("weapon_change", var_2);

    if(var_2.basename == var_0) {
      break;
    }
  }

  self playsoundtoteam(var_1, self.team, self);
  var_3 = scripts\mp\utility\game::_id_6BE2(self.team)[0];
  self playsoundtoteam(var_1, var_3);
  self waittill("weapon_change");
  self notify("stopNpcBombSound");
}

_id_268C(var_0) {}

_id_2691(var_0) {
  if(scripts\mp\utility\game::_id_82D1() && self._id_2663 == 0 || !_id_07D6::_id_886F(var_0.pers["team"])) {
    self._id_DCD9 = undefined;
    level thread _id_268B(self, var_0);
    var_0 notify("bomb_planted");
    var_1 = 2;

    if(self._id_A8E1 == "_a") {
      var_1 = 1;
    }

    scripts\mp\utility\game::_id_D5FA(0, var_0.team, var_0 getentitynumber(), var_1);
    var_0 scripts\mp\utility\stats::_id_7DAE("plants", 1);
    var_0 scripts\mp\persistence::_id_E770("round", "plants", var_0.pers["plants"]);
    var_0 _id_07BF::_id_7D94(5, 1);
    var_0 _id_0798::_id_110E();
    var_0 scripts\mp\utility\stats::_id_D550(var_0.pers["plants"]);

    if(isDefined(level._id_CF9F) && isDefined(level._id_CF9F[var_0.team])) {
      var_0 thread _id_C47B();
    }

    if(scripts\mp\utility\game::getgametype() != "cmd") {
      if(scripts\mp\utility\game::_id_82D1()) {
        _id_0A8D::_id_E775("enemy_bomb_planted", scripts\mp\utility\game::_id_6BE2(var_0.team)[0], 1);
      } else {
        _id_0A8D::_id_E775("enemy_bomb" + self._id_A8E1, scripts\mp\utility\game::_id_6BE2(var_0.team)[0], 1);
      }

      var_0 playsoundtoteam("mp_dom_flag_captured_all", scripts\mp\utility\game::_id_6BE2(var_0.team)[0]);
      _id_0A8D::_id_E775("bomb_planted", var_0.team, 1);
    }

    level thread scripts\mp\hud_util::_id_EF8D("callout_bombplanted", var_0);
    level._id_2661 = var_0;
    var_0 thread _id_0A9F::_id_7003("plant");
    var_0._id_2666 = gettime();

    if(isPlayer(var_0)) {
      var_0 _id_07BC::_id_AB57();
      var_2 = spawnStruct();
      var_2.player = var_0;
      var_2._id_56B9 = "plant";
      var_2._id_033E = var_0.origin;
      _id_06E2::_id_4C2A("callback_on_game_event", var_2);
    }
  }
}

_id_2690(var_0) {
  var_1 = 0;
  setomnvar("ui_bomb_interacting", 0);
  setomnvar("ui_victory_condition_completed", 1);

  foreach(var_3 in level._id_A8E8) {
    if(isDefined(var_3._id_A8E1) && var_3._id_A8E1 == self._id_A8E1) {
      var_0 notify("bomb_defused" + var_3._id_A8E1);
      level thread _id_2635(var_3);
      var_0 thread _id_07BC::creategametypechallenegeevent("bomb_defused");
      break;
    }
  }

  if(scripts\mp\utility\game::getgametype() != "dd") {
    _id_07D6::_id_4AD1();
    iprintln(&"MP/EXPLOSIVES_DEFUSED_BY", var_0);
  }

  _id_0A8D::_id_E775("enemy_bomb_defused", scripts\mp\utility\game::_id_6BE2(var_0.team)[0], 1);
  _id_0A8D::_id_E775("bomb_defused", var_0.team, 1);
  level thread scripts\mp\hud_util::_id_EF8D("callout_bombdefused", var_0);
  var_0 _id_07BC::_id_AAAC();
  _id_07CE::_id_2635(var_0);
}

_id_268B(var_0, var_1) {
  level endon("bombs_canceled");
  level notify("bomb_planted", var_0);
  var_2 = var_1.team;
  level._id_2635 = 0;
  var_0._id_2635 = 0;

  if(scripts\mp\utility\game::getgametype() == "dd") {
    scripts\mp\gamelogic::pausetimer();
    level._id_F23D = gettime();
  } else if(scripts\mp\utility\game::getgametype() == "to_dd" || scripts\mp\utility\game::getgametype() == "tac_ops")
    scripts\mp\gametypes\tac_ops::_id_AF74();

  level._id_2663 = 1;
  level._id_267E = level._id_267E + 1;

  if(scripts\mp\utility\game::getgametype() != "btm") {
    level._id_F21A = 1;
  }

  level._id_463F = int(gettime() + level._id_2682 * 1000);

  if(var_0._id_A8E1 == "_a") {
    level._id_19B0 = 1;
  } else {
    level._id_29EA = 1;
  }

  _id_D4A0(var_1.team);
  level._id_484A = var_0;
  level._id_484A._id_2663 = 1;

  if(!level._id_A2F7) {
    var_1 setclientomnvar("ui_carrying_bomb", 0);
    setomnvar("ui_bomb_carrier", -1);
    setgameendtime(level._id_463F);
  }

  level._id_F1DE = var_0._id_10430[0];

  if(!level._id_A2F7) {
    level._id_CFA2 _id_07D6::_id_159C("none");
    level._id_CFA2 _id_07D6::_id_D8E0("none");
    level._id_CFA2 _id_07D6::_id_D537();
    level._id_CFA3 = level._id_CFA2._id_10430[0];

    if(getdvarint("#x34c09068223bce5b8", 0) == 1) {
      level._id_CFA3 _meth_8851(1, var_2);
    }
  } else if(scripts\mp\utility\game::getgametype() == "cmd") {} else if(scripts\mp\utility\game::getgametype() == "dd" || scripts\mp\utility\game::getgametype() == "btm") {
    level._id_436B[var_0._id_A8E1] = spawn("script_model", var_1.origin);
    level._id_436B[var_0._id_A8E1].angles = var_1.angles;
    level._id_436B[var_0._id_A8E1] setModel(_id_6926());
    level._id_436B[var_0._id_A8E1] setasgametypeobjective();
  } else if(scripts\mp\utility\game::getgametype() == "to_dd") {
    var_3 = var_0.trigger.origin;
    var_4 = var_0.trigger.angles;
    var_5 = (0, 0, 0);

    if(isDefined(level._id_ED22)) {
      if(var_0._id_A8E1 == "_a") {
        var_5 = (0, 0, 50);
        var_4 = (-90, -45, 0);
      } else {
        var_5 = (0, 0, 50);
        var_4 = (-90, 90, 0);
      }
    }

    level._id_436B[var_0._id_A8E1] = spawn("script_model", var_3 + var_5);
    level._id_436B[var_0._id_A8E1].angles = var_4;
    level._id_436B[var_0._id_A8E1] setModel(_id_6926());
    level._id_436B[var_0._id_A8E1] setasgametypeobjective();
  } else {
    level._id_CFA3 = spawn("script_model", var_1.origin);
    level._id_CFA3.angles = var_1.angles;
    level._id_CFA3 setModel(_id_6926());
    level._id_CFA3 setasgametypeobjective();
  }

  if(scripts\mp\utility\game::getgametype() != "dd" && scripts\mp\utility\game::getgametype() != "to_dd" && scripts\mp\utility\game::getgametype() != "cmd" || scripts\mp\utility\game::getgametype() != "btm") {
    var_0 _id_07D6::_id_15DF("none");
    var_0 _id_07D6::_id_D8E0("none");
  }

  var_6 = [];

  if(scripts\mp\utility\game::getgametype() == "dd" || scripts\mp\utility\game::getgametype() == "to_dd" || scripts\mp\utility\game::getgametype() == "cmd" || scripts\mp\utility\game::getgametype() == "btm") {
    var_7 = var_0.trigger;
    var_7.origin = var_0._id_10430[0].origin;
    var_8 = var_0;
    var_8 _id_07D6::_id_D639(var_1.team);
  } else {
    var_7 = var_0._id_2636;
    var_7.origin = level._id_CFA3.origin;
    var_9 = game["attackers"];
    var_0 _id_07D6::_id_C300(1, 1);
    var_8 = _id_07D6::_id_406E(var_9, var_7, var_6, (0, 0, 32));
    _id_07F9::_id_A8B1(var_8._id_A908, 0);
    _id_07F9::_id_A8B2(var_8._id_A908, 0);
  }

  var_8._id_A8E1 = var_0._id_A8E1;
  var_8._id_7C73 = var_0._id_7C73;
  var_8._id_7C8C = "defuse_object";
  var_8.trigger _meth_83A1(-300);

  if(scripts\mp\utility\game::getgametype() == "cmd") {
    var_8 _id_07D6::_id_15DF("none");
  } else {
    var_8 _id_07D6::_id_15DF("enemy");
  }

  var_8 _id_07D6::_id_D8D2(level._id_4644);
  var_8 _id_07D6::_id_D8E3(0);
  var_8 _id_07D6::_id_D8D0(&"MP/HOLD_TO_DEFUSE_EXPLOSIVES");
  var_8.trigger setuseholdduration("duration_none");
  var_8 _id_07D6::_id_D8E0("any");
  _func_046E(var_8._id_A908, 0);
  _func_046F(var_8._id_A908, 0);
  var_8 _id_07D6::_id_D61B("waypoint_bomb_defend_nt", "waypoint_defuse_nt");

  if(scripts\mp\utility\game::getgametype() != "cmd") {
    var_8 thread _id_2675(var_2, "waypoint_bomb_defend", "waypoint_defuse");
  }

  if(scripts\mp\utility\game::getgametype() == "cmd" && level._id_3A10 == 2) {} else {
    var_8._id_AA79 = ::_id_268A;
    var_8._id_AAC2 = ::_id_268F;
    var_8._id_ABCB = ::_id_2690;
    var_8._id_C63B = level._id_C63B;

    if(scripts\mp\utility\game::isholidayenabled(2)) {
      var_8.useweapon = makeweapon("s4_remote_bomb_defuse_holiday_mp");
    } else if(scripts\mp\utility\game::isholidayenabled(3)) {
      var_8.useweapon = makeweapon("s4_remote_bomb_defuse_vday_mp");
    } else {
      var_8.useweapon = makeweapon("s4_remote_bomb_defuse_mp");
    }
  }

  level thread scripts\mp\hud_message::_id_FCBF(var_1.team, 22, 23);
  var_0 _id_2683(var_0._id_A8E1);
  var_0._id_10430[0] scripts\mp\gamelogic::_id_E943();
  var_8._id_2663 = 0;

  if(level.gameended) {
    return;
  } else if(scripts\mp\utility\game::getgametype() == "sd" && level._id_2635 || scripts\mp\utility\game::getgametype() == "sr" && level._id_2635) {
    var_8 _id_07D6::_id_479D();
    return;
  }

  if(scripts\mp\utility\game::getgametype() == "dd" || scripts\mp\utility\game::getgametype() == "to_dd" || scripts\mp\utility\game::getgametype() == "cmd" || scripts\mp\utility\game::getgametype() == "btm") {
    self._id_DCD9 = undefined;
    var_10 = scripts\mp\gametypes\dd::_id_265E;

    if(scripts\mp\utility\game::getgametype() == "to_dd") {
      var_10 = scripts\mp\gametypes\to_dd::_id_265E;
    } else if(scripts\mp\utility\game::getgametype() == "cmd") {
      var_10 = scripts\mp\gametypes\cmd::_id_265E;
    } else if(scripts\mp\utility\game::getgametype() == "btm") {
      var_10 = scripts\mp\gametypes\btm::_id_265E;
    }

    if(var_0._id_2635) {
      var_0 thread[[var_10]](var_1, "defused");

      if(scripts\mp\utility\game::getgametype() == "cmd") {
        var_0._id_ABCB = scripts\mp\gametypes\cmd::_id_2691;
      } else {
        var_0._id_ABCB = ::_id_2691;
      }

      if(isDefined(level._id_436B[var_0._id_A8E1])) {
        level._id_436B[var_0._id_A8E1] delete();
      }

      return;
    } else {
      level._id_265C = level._id_265C + 1;
      var_0 thread[[var_10]](var_1, "explode", var_2);
    }
  } else
    level._id_265C = level._id_265C + 1;

  if(scripts\mp\utility\game::getgametype() == "cmd") {
    level waittill("allow_bomb_explosion");
  }

  setomnvar("ui_victory_condition_completed", 1);
  level notify("bomb_exploded" + var_0._id_A8E1);
  var_1 thread scripts\mp\rank::_id_CC00("detonate");
  var_1 thread _id_07B1::_id_6FB9("mode_sd_detonate");

  if(isDefined(level._id_CFA0)) {
    level thread[[level._id_CFA0]]();
  }

  if(scripts\mp\utility\game::getgametype() == "cmd") {
    var_11 = var_0._id_4140;
  } else if(scripts\mp\utility\game::getgametype() == "dd" || scripts\mp\utility\game::getgametype() == "to_dd" || scripts\mp\utility\game::getgametype() == "btm") {
    var_11 = level._id_436B[var_0._id_A8E1].origin;
    level._id_436B[var_0._id_A8E1] delete();
  } else {
    var_11 = level._id_CFA3.origin;
    level._id_CFA3 delete();
  }

  if(isDefined(var_1)) {
    var_0._id_10430[0] radiusdamage(var_11, 512, 200, 20, var_1, "MOD_EXPLOSIVE", "bomb_site_mp");
    var_1 scripts\mp\utility\stats::_id_7DAE("destructions", 1);
    var_1 scripts\mp\persistence::_id_E770("round", "destructions", var_1.pers["destructions"]);
    var_1 thread _id_07BC::creategametypechallenegeevent("bomb_success");
  } else
    var_0._id_10430[0] radiusdamage(var_11, 512, 200, 20, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");

  var_12 = randomfloat(360);

  if(isDefined(var_0.trigger._id_5106)) {
    var_13 = var_0.trigger._id_5106;
  } else if(level.mapname == "mp_faridah") {
    var_13 = "faridah_bomb_explosion";
  } else {
    var_13 = "bomb_explosion";
  }

  var_14 = var_11 + (0, 0, 50);
  var_15 = spawnfx(level._effect[var_13], var_14, (0, 0, 1), (cos(var_12), sin(var_12), 0));
  triggerfx(var_15);
  physicsexplosionsphere(var_14, 200, 100, 3);
  playrumbleonposition("grenade_rumble", var_11);
  earthquake(0.75, 2.0, var_11, 2000);
  playsoundatpos(var_14, "explo_vehicle_main_lrg");

  if(scripts\mp\utility\game::isholidayenabled(2)) {
    playsoundatpos(var_14, "mp_codmas_srchdstry_bomb_layer");
  }

  if(scripts\mp\utility\game::getgametype() == "to_dd") {
    foreach(var_17 in level._id_A8E8) {
      if(isDefined(var_17._id_57CB)) {
        scripts\engine\utility::_id_57BA(var_17._id_57CB);
      }
    }
  } else if(isDefined(var_0._id_57CB))
    scripts\engine\utility::_id_57BA(var_0._id_57CB);

  var_8 _id_07D6::_id_4AD1();

  if(isDefined(level._id_AB42)) {
    [[level._id_AB42]]("bombzone", self._id_A8E1, var_1, game["attackers"], undefined);
  }
}

_id_2675(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = level._id_5F3A;
  var_4 = var_3 * 1000;
  var_5 = level._id_2682 * 1000;
  var_6 = var_4 / var_5;
  self._id_BF19 = _id_07F9::_id_C57D(99);

  if(self._id_BF19 != -1) {
    var_7 = "invisible";
    _id_07F9::_id_A867(self._id_BF19, var_7, self._id_4140 + self._id_A97E);
    _id_07F9::_id_A8B1(self._id_BF19, 0);
    _id_07F9::_id_A8B2(self._id_BF19, 0);
    _id_07F9::_id_A8A2(self._id_BF19);
    self._id_DCFF = 1;
  }

  _id_07D6::_id_D61B(var_1, var_2, self._id_BF19);
  self._id_2663 = 1;

  while(self._id_2663) {
    var_8 = var_6;
    _id_07F9::_id_A8B6(self._id_BF19, var_0);
    _id_07F9::_id_A8C4(self._id_BF19, 1);
    _id_07F9::_id_A8B4(self._id_BF19, var_8);
    var_6 = min(var_6 + var_4 / var_5, 1.0);
    waitframe();
  }

  _id_07F9::_id_C799(self._id_BF19);
  self._id_BF19 = -1;
}

_id_6926() {
  if(scripts\mp\utility\game::isholidayenabled(2)) {
    return "wm_equip_gen_bomb_remote_01";
  } else if(scripts\mp\utility\game::isholidayenabled(3)) {
    return "wm_equip_gen_bomb_remote_02";
  } else {
    return "wm_equip_gen_bomb_remote_00";
  }
}

_id_8245(var_0) {
  var_1 = undefined;
  var_2 = getEntArray("sd_bombcam_start", "targetname");

  foreach(var_4 in var_2) {
    if(var_4._id_CD99 == var_0._id_A8E1) {
      var_1 = var_4;
      break;
    }
  }

  var_6 = [];

  if(isDefined(var_1) && isDefined(var_1.target)) {
    var_7 = getent(var_1.target, "targetname");

    while(isDefined(var_7)) {
      var_6[var_6.size] = var_7;

      if(isDefined(var_7.target)) {
        var_7 = getent(var_7.target, "targetname");
        continue;
      }

      break;
    }
  }

  if(isDefined(var_1) && var_6.size) {
    var_8 = spawn("script_model", var_1.origin);
    var_8.origin = var_1.origin;
    var_8.angles = var_1.angles;
    var_8._id_AEC7 = var_6;
    var_8 setModel("tag_origin");
    var_8 hide();
    return var_8;
  } else
    return undefined;
}

_id_CA65() {
  level notify("objective_cam");

  foreach(var_1 in level.players) {
    if(!isai(var_1)) {
      var_1 scripts\mp\utility\player::_freezecontrols(1);
      var_1 visionsetnakedforplayer("black_bw", 0.5);
    }
  }

  wait 0.5;

  foreach(var_1 in level.players) {
    if(!isai(var_1)) {
      var_1 scripts\mp\utility\player::_id_D8D4("objective_cam");
      var_1 scripts\common\utility::_id_158D(0);
      var_1 _meth_826E(self, "tag_player", 1, 180, 180, 180, 180, 1);
      var_1 scripts\mp\utility\player::_freezecontrols(1);
      var_1 setplayerangles(self.angles);
      var_1 visionsetnakedforplayer("", 0.5);
    }
  }

  for(var_5 = 0; var_5 < self._id_AEC7.size; var_5++) {
    var_6 = 0;

    if(var_5 == 0) {
      var_6 = 5 / self._id_AEC7.size / 2;
    }

    var_7 = 0;

    if(var_5 == self._id_AEC7.size - 1) {
      var_7 = 5 / self._id_AEC7.size / 2;
    }

    self moveto(self._id_AEC7[var_5].origin, 5 / self._id_AEC7.size, var_6, var_7);
    self rotateto(self._id_AEC7[var_5].angles, 5 / self._id_AEC7.size, var_6, var_7);
    wait(5 / self._id_AEC7.size);
  }
}

_id_2683(var_0) {
  level endon("game_ended");
  level endon("bombs_canceled");
  level endon("bomb_defused" + var_0);
  var_1 = int(level._id_2682 * 1000 + gettime());
  setomnvar("ui_bomb_timer_endtime" + var_0, var_1);
  thread _id_FD64("ui_bomb_timer_endtime" + var_0, var_1, level._id_2682 * 1000, var_0);
  level thread _id_7458(var_1, var_0);
  scripts\mp\hostmigration::_id_1084E(level._id_2682);
}

_id_FD64(var_0, var_1, var_2, var_3) {
  level endon("bombs_canceled");
  level endon("bomb_defused" + var_3);
  self._id_E683 = gettime();

  while(gettime() < var_1) {
    var_4 = gettime() - self._id_E683;
    setomnvar(var_0, int(gettime() + var_2 - var_4));
    waitframe();
  }
}

_id_7458(var_0, var_1) {
  level endon("game_ended");
  level endon("bomb_defused" + var_1);
  level endon("disconnect");
  level waittill("host_migration_begin");
  setomnvar("ui_bomb_timer_endtime" + var_1, 0);
  var_2 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var_2 > 0) {
    setomnvar("ui_bomb_timer_endtime" + var_1, var_0 + var_2);
  }
}

_id_2635(var_0) {
  if(scripts\mp\utility\game::getgametype() != "dd" && scripts\mp\utility\game::getgametype() != "to_dd" && scripts\mp\utility\game::getgametype() != "cmd" && scripts\mp\utility\game::getgametype() != "btm") {
    level._id_2635 = 1;
  }

  var_0._id_2635 = 1;
  _id_D4A0();
  level notify("bomb_defused" + var_0._id_A8E1);

  if(isDefined(level._id_AB42)) {
    [[level._id_AB42]]("bombzone", self._id_A8E1, undefined, game["defenders"], undefined);
  }
}

_id_FC16(var_0) {
  if(scripts\mp\utility\game::getgametype() == "cmd") {
    return;
  }
  if(isDefined(var_0)) {
    if(var_0 == "allies") {
      setomnvar("ui_bomb_owner_team", 2);
    } else {
      setomnvar("ui_bomb_owner_team", 1);
    }
  }

  if(isDefined(level._id_19B0)) {
    if(level._id_19B0) {
      setomnvar("ui_bomb_planted_a", 1);
    } else {
      setomnvar("ui_bomb_planted_a", 0);
    }
  }

  if(isDefined(level._id_29EA)) {
    if(level._id_29EA) {
      setomnvar("ui_bomb_planted_b", 1);
    } else {
      setomnvar("ui_bomb_planted_b", 0);
    }
  }
}

_id_D4A0(var_0) {
  _id_FC16(var_0);
}

_id_2694(var_0) {
  level._id_2663 = 0;
  level._id_2635 = 0;
  level._id_265C = 0;
  var_1 = getent(var_0 + "_pickup_trig", "targetname");

  if(!isDefined(var_1)) {
    scripts\engine\utility::_id_5598("No " + var_0 + "_pickup_trig trigger found in map.");
  } else {
    var_2[0] = getent(var_0, "targetname");

    if(!isDefined(var_2[0])) {
      scripts\engine\utility::_id_5598("No " + var_0 + " script_model found in map.");
      return;
    }

    var_2[0] setModel(_id_6926());
    var_2[0] = _id_688E(var_2[0]);
    var_1 = _id_688E(var_1, 1);

    if(!level._id_A2F7) {
      level._id_CFA2 = _id_07D6::_id_3FA8(game["attackers"], var_1, var_2, (0, 0, 32), undefined, 1);
      level._id_CFA2 _id_07D6::_id_159C("friendly");
      level._id_CFA2._id_15E2 = 1;
      level._id_CFA2._id_AB4D = ::_id_AB4D;
      level._id_CFA2._id_AAB9 = ::_id_AAB9;
      level._id_CFA2._id_5BD9 = 1;
      level thread _id_267D();
      level._id_2679 = level._id_CFA2._id_10430[0].origin;
      level._id_2678 = level._id_CFA2._id_10430[0].angles;
      level._id_CFA2._id_1042D = (0, 0, 2);

      if(getdvarint("#x34c09068223bce5b8", 0) == 1) {
        level._id_CFA2._id_10430[0] _meth_8851(1, game["attackers"]);
        return;
      }

      return;
    }

    var_1 delete();
    var_2[0] delete();
  }
}

_id_688E(var_0, var_1) {
  switch (level.mapname) {
    case "mp_raid":
      if(_id_07D1::_id_60BE("infil_will_run") && game["roundsPlayed"] == 0) {
        var_2 = (-518, -959.2, 267);

        if(istrue(var_1)) {
          var_0.origin = var_2;
        } else {
          var_0.origin = var_2;
          var_0.angles = (0, 90, 0);
        }
      }

      break;
    case "mp_petrograd":
      var_2 = (263, -2500, 146);

      if(istrue(var_1)) {
        var_0.origin = var_2;
      } else {
        var_0.origin = var_2;
        var_0.angles = (0, 90, 0);
      }

      break;
    default:
      break;
  }

  return var_0;
}

_id_A226(var_0, var_1) {
  if(isDefined(level._id_CFA2)) {
    level._id_CFA2.trigger.origin = var_0;
    level._id_CFA2._id_10430[0].origin = var_0;
    level._id_CFA2._id_10430[0].angles = var_1;
    level._id_CFA2._id_10430[0] show();
    level._id_CFA2 _id_07D6::_id_159C("friendly");
    level._id_CFA2 _id_07D6::_id_D61B("waypoint_bomb");
    level._id_CFA2 _id_07D6::_id_D8E0("friendly");
    level._id_CFA2._id_15E2 = 1;
    level._id_CFA2._id_AB4D = ::_id_AB4D;
    level._id_CFA2._id_AAB9 = ::_id_AAB9;
  }
}

_id_267D() {
  level endon("game_ended");

  for(;;) {
    level waittill("bomb_pickup");

    foreach(var_1 in level._id_A8E8) {
      var_1.trigger _meth_80E0(level._id_CFA2._id_32D5);
    }

    waitframe();
  }
}

_id_AB4D(var_0, var_1, var_2) {
  var_0._id_8783 = 1;

  if(isPlayer(var_0)) {
    var_3 = spawnStruct();
    var_3.player = var_0;
    var_3._id_56B9 = "pickup";
    var_3._id_033E = var_0.origin;
    _id_06E2::_id_4C2A("callback_on_game_event", var_3);
    scripts\mp\utility\game::_id_D5FA(1, var_0.team, var_0 getentitynumber());
  }

  var_0 setclientomnvar("ui_carrying_bomb", 1);
  setomnvar("ui_bomb_carrier", var_0 getentitynumber());
  self._id_A97E = (0, 0, 75);
  _id_07D6::_id_D61B("icon_waypoint_escort_bomb", "codcaster_enemy_escort_bomb");
  _func_0162(self._id_A908, -40);

  if(isDefined(level._id_CF9F) && isDefined(level._id_CF9F[var_0.team])) {
    var_0 thread _id_19C6();
  }

  if(!level._id_2635) {
    var_0 thread scripts\mp\hud_message::showsplash("callout_bombpickup");
    scripts\mp\hud_util::_id_EF8D("callout_bombtaken", var_0, var_0.team);

    if(istrue(self._id_5BD9)) {
      var_4 = "bomb_pickup_first";
      self._id_5BD9 = 0;
    } else
      var_4 = "bomb_pickup";

    var_5 = [];
    var_5[var_5.size] = var_0;
    level thread _id_B690(var_0, var_4);
    level thread _id_EF6B(var_0.pers["team"], var_5);
    var_6 = "allies";

    if(var_0.pers["team"] == "allies") {
      var_6 = "axis";
    }

    level thread _id_0A8D::_id_E775("bomb_enemy_pickup", var_6);
  }

  if(level.codcasterenabled) {
    var_0 _meth_80CB(1);
  }

  level notify("bomb_pickup");
  level thread scripts\mp\hud_message::_id_FCBF(var_0.team, 25, undefined, var_0, 21);
}

_id_AAB9(var_0) {
  level notify("bomb_dropped");
  setomnvar("ui_bomb_carrier", -1);

  if(level.codcasterenabled) {
    if(isDefined(var_0)) {
      var_0 _meth_80CB(0);
    }
  }

  _id_07D6::_id_D61B("waypoint_bomb");

  if(isDefined(var_0)) {
    var_0._id_8783 = 0;
  }

  if(!level._id_2663) {
    setomnvar("ui_bomb_owner_team", 0);
  }

  if(!level._id_2663) {
    level thread _id_0A8D::_id_E775("bomb_lost", var_0.team);
  }

  if(!level._id_2663 && isDefined(level._id_2677) && level._id_2677 > 0) {
    thread _id_107F9(level._id_2677);
  }

  level thread scripts\mp\hud_message::_id_FCBF(var_0.team, 24);
}

_id_107F9(var_0) {
  level endon("game_ended");
  level endon("bomb_pickup");
  wait(var_0);
  scripts\mp\weapons::_id_555A(self._id_10430[0].origin, self._id_10430[0].angles);
  _id_A226(level._id_2679, level._id_2678);
}

_id_525E() {
  foreach(var_1 in level.players) {
    if(!isai(var_1)) {
      var_1 setclientomnvar("ui_carrying_bomb", var_1.pers["team"] == game["attackers"]);
    }
  }
}

_id_C68E() {
  level endon("game_ended");
  wait 5;

  if(level._id_A2F7) {
    _id_525E();
  } else {
    _id_A226(level._id_2679, level._id_2678);
  }
}

_id_11D5() {
  level._id_2663 = 0;
  level._id_2635 = 0;
  level._id_2679 = level._id_413D._id_10430[0].origin + (0, 0, 48);
  level._id_2678 = level._id_413D._id_10430[0].angles;

  if(level._id_A2F7) {
    _id_525E();
  } else {
    _id_A226(level._id_2679, level._id_2678);
  }
}

_id_19C6() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(self._id_87A7) && self._id_87A7 == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self _meth_81CE()) {
    waitframe();
  }

  while(!self isonground()) {
    waitframe();
  }

  self.pers["gamemodeLoadout"] = level._id_CF9F[self.team];
  _id_0A18::_id_E346(self.origin, self.angles);
  self._id_60C7 = self.class;
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "gamemode";
  self.class = "gamemode";
  self._id_8FAF = "gamemode";
  self notify("faux_spawn");
  self._id_60D9 = 1;
  self._id_59DF = self getstance();
  thread scripts\mp\playerlogic::_id_E337(1);
}

_id_C47B() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(self._id_87A7) && self._id_87A7 == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self _meth_81CE()) {
    waitframe();
  }

  while(!self isonground()) {
    waitframe();
  }

  self.pers["gamemodeLoadout"] = undefined;
  _id_0A18::_id_E346(self.origin, self.angles);
  self notify("faux_spawn");
  self._id_59DF = self getstance();
  thread scripts\mp\playerlogic::_id_E337(1);
}

_id_2685(var_0, var_1) {
  foreach(var_3 in level._id_A8E8) {
    if(!isDefined(var_3._id_2636.origin)) {
      continue;
    }
    var_4 = istrue(var_3._id_2663);
    var_5 = _id_4BBA(var_0.origin, var_1.origin, scripts\engine\utility::ter_op(var_4, var_3._id_2636.origin, var_3.trigger.origin));

    if(var_5) {
      if(var_1.team == game["defenders"]) {
        var_0 thread scripts\mp\rank::_id_CC00(scripts\engine\utility::ter_op(var_4, "defend", "assault"));
        var_0 thread _id_07B1::_id_6FB9(scripts\engine\utility::ter_op(var_4, "mode_x_defend", "mode_x_assault"));
        continue;
      }

      var_0 thread scripts\mp\rank::_id_CC00(scripts\engine\utility::ter_op(var_4, "assault", "defend"));
      var_0 thread _id_07B1::_id_6FB9(scripts\engine\utility::ter_op(var_4, "mode_x_assault", "mode_x_defend"));
    }
  }
}

_id_4BBA(var_0, var_1, var_2) {
  var_3 = distancesquared(var_2, var_0);
  var_4 = distancesquared(var_2, var_1);

  if(var_3 < 90000 || var_4 < 90000) {
    return 1;
  } else {
    return 0;
  }
}

_id_B690(var_0, var_1) {
  var_2 = scripts\mp\utility\game::_id_6DE6() / 1000;

  if(istrue(level._id_7E80)) {
    var_3 = 8;
  } else {
    var_3 = 5;
  }

  var_4 = var_3 - var_2;

  if(var_4 > 0) {
    wait(var_4);
  }

  if(isDefined(var_0)) {
    var_0 _id_0A8D::_id_9137(var_1);
  }
}

_id_EF6B(var_0, var_1) {
  var_2 = scripts\mp\utility\game::_id_6DE6() / 1000;

  if(istrue(level._id_7E80)) {
    var_3 = 8;
  } else {
    var_3 = 5;
  }

  var_4 = var_3 - var_2;

  if(var_4 > 0) {
    wait(var_4);
  }

  _id_0A8D::_id_9136("bomb_achieve", var_0, "bomb", var_1);
}

_id_C650() {
  self setclientomnvar("ui_carrying_bomb", 0);
}

_id_D713(var_0) {
  if(var_0 == "axis") {
    self _meth_85C4(1);
  } else if(var_0 == "allies") {
    self _meth_85C4(2);
  } else {
    self _meth_85C4(0);
  }
}

setuphuddata(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 endon("death");
  self _meth_8851(1, game["defenders"]);
  level waittill("bomb_planted");

  if(var_0._id_2663) {
    self _meth_8851(1, game["attackers"]);
  } else {
    self _meth_8851(0);
  }
}