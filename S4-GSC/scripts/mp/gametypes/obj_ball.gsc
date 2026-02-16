/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\obj_ball.gsc
*************************************************/

_id_211A() {
  level._id_456E = [];
  level._id_01C4 = getEntArray("flag_primary", "targetname");

  foreach(var_1 in level._id_01C4) {
    switch (var_1._id_CD99) {
      case "_a":
        level._id_456E[game["attackers"]] = var_1.origin;
        break;
      case "_b":
        level._id_4561 = var_1.origin;
        break;
      case "_c":
        level._id_456E[game["defenders"]] = var_1.origin;
        break;
    }
  }
}

_id_2131() {
  level._id_2134 = (1000, 1000, 1000);
  level._id_2133 = (-1000, -1000, -1000);
  var_0 = _func_0075();

  if(var_0.size > 0) {
    foreach(var_2 in var_0) {
      level._id_2134 = _id_0817::_id_57A3(level._id_2134, var_2.origin);
      level._id_2133 = _id_0817::_id_57A2(level._id_2133, var_2.origin);
    }
  } else {
    level._id_2134 = level._id_E327;
    level._id_2133 = level._id_E324;
  }
}

_id_2117() {
  if(!isDefined(level._id_48DF)) {
    level._id_48DF = 0;
  }

  var_0 = _id_68F4();
  level._id_215C = _id_68F5();
  _id_354E(var_0);

  if(var_0.size > 1 && level._id_CB2A > 1) {
    for(var_1 = 0; var_1 < level._id_CB2A; var_1++) {
      var_2 = _id_68F3(var_0[var_1]);
      _id_210B(var_2);
    }
  } else {
    var_3 = [];
    var_3[0] = (0, 0, 0);
    var_3[1] = (50, 0, 0);
    var_3[2] = (-50, 0, 0);
    var_3[3] = (0, 50, 0);
    var_3[4] = (0, -50, 0);

    for(var_1 = 0; var_1 < level._id_CB2A; var_1++) {
      var_2 = _id_68F3(var_0[var_1]);
      _id_210B(var_2 + var_3[var_1]);
    }
  }

  level thread scripts\mp\utility\entity::_id_703F();
}

_id_354E(var_0) {
  if(level.mapname == "mp_divide") {
    var_0[0].origin = (-261, 235, 610);
    var_0[1].origin = (-211, 235, 610);
    var_0[2].origin = (-311, 235, 610);
    var_0[3].origin = (-311, 500, 610);
    var_0[4].origin = (-211, 500, 610);
  }
}

_id_68F4() {
  var_0 = undefined;

  if(scripts\mp\utility\game::getgametype() == "tdef") {
    var_0 = scripts\engine\utility::getStructArray("tdef_ball_start", "targetname");
  }

  if(!isDefined(var_0) || !var_0.size) {
    var_0 = scripts\engine\utility::getStructArray("ball_start", "targetname");
  }

  if(level._id_CB2A > 1) {
    var_0 = _id_E02B(var_0);
  }

  return var_0;
}

_id_68F5() {
  var_0 = undefined;

  if(scripts\mp\utility\game::getgametype() == "tdef") {
    var_0 = getEntArray("tdef_ball_pickup", "targetname");
  }

  if(!isDefined(var_0) || !var_0.size) {
    var_0 = getEntArray("ball_pickup", "targetname");
  }

  if(level._id_CB2A > 1) {
    var_0 = _id_E02B(var_0);
  }

  return var_0;
}

_id_68F3(var_0) {
  if(isDefined(var_0)) {
    var_1 = var_0.origin;
  } else if(level._id_48DF) {
    var_1 = level.players[0].origin + (0, 0, 30);
  } else {
    var_1 = level._id_4561;
  }

  return var_1;
}

_id_210B(var_0) {
  var_1 = 30;
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_3 = var_0;
  var_2 _id_211F();
  var_2.origin = var_2._id_71A7 + (0, 0, var_1);
  var_2._id_7D7E = 0;

  if(level.mapname == "mp_desert") {
    var_3 = var_2._id_71A7;
  }

  if(level.mapname == "mp_divide") {
    var_3 = var_2._id_71A7;
  }

  if(scripts\mp\utility\game::getgametype() == "tdef") {
    level._id_2193[level._id_2193.size] = _id_3F98(var_3);
  }

  level._id_2156[level._id_2156.size] = var_2;
}

_id_211F(var_0) {
  var_1 = self.origin + (0, 0, 32);
  var_2 = self.origin + (0, 0, -1000);
  var_3 = scripts\engine\trace::_id_3EE5(1, 1, 1, 1, 0, 1, 1);
  var_4 = [];
  var_5 = scripts\engine\trace::ray_trace(var_1, var_2, var_4, var_3);
  self._id_71A7 = var_5["position"];
  return var_5["fraction"] != 0 && var_5["fraction"] != 1;
}

_id_3F98(var_0) {
  var_1 = spawn("script_model", var_0);
  var_1 setModel("ctf_game_flag_base");
  var_1 setasgametypeobjective();
  var_1._id_22B7 = var_0;
  return var_1;
}

_id_DC88(var_0) {
  if(isDefined(var_0._id_0B62[0])) {
    var_0._id_0B62[0] delete();
  }

  var_1 = undefined;
  var_2 = var_0.team;
  var_3 = var_0 _meth_81D3();

  if(var_3) {
    var_2 = var_0 _meth_8154();
  } else if(var_2 == "spectator") {
    var_2 = "allies";
  }

  var_4 = _func_020D(level._effect["ball_base_glow"], self._id_22B7, var_0);
  var_4 _meth_8322();
  var_0._id_0B62[0] = var_4;
  triggerfx(var_4);
}

_id_2155(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(isDefined(var_1)) {
    var_2 = spawn("script_model", var_1);
  } else {
    var_2 = level._id_2156[level._id_21B2.size];
  }

  var_3 = spawn("script_model", var_2.origin);
  var_3 setasgametypeobjective();

  if(scripts\mp\utility\game::getgametype() == "ball" || getdvarint("#x34d88fff242424397") == 1) {
    var_3 setModel("offhand_wm_emp");
    var_3 _meth_8359(1);
    level._id_21BB = makeweapon("iw7_uplinkball_mp");
    level._id_21AD = 1000000;
  } else {
    var_3 setModel("offhand_wm_emp");
    var_3 _meth_8359(1);
    level._id_21BB = makeweapon("iw7_tdefball_mp");
    level._id_21AD = 250000;
  }

  var_4 = 32;
  var_5 = undefined;

  if(isDefined(level._id_215C) && level._id_215C.size > 0) {
    var_5 = level._id_215C[var_0];
    var_5.origin = var_3.origin;
  } else
    var_5 = spawn("trigger_radius", var_3.origin - (0, 0, var_4 / 2), 0, var_4, var_4);

  var_5 _meth_80DB();
  var_5 linkto(var_3);
  var_5._id_A51C = 1;
  var_5._id_9514 = 1;
  var_5._id_2323 = var_5.origin;
  var_5._id_A51C = 1;
  var_6 = [var_3];
  var_7 = _id_07D6::_id_3FA8("any", var_5, var_6, (0, 0, 32));
  var_7._id_A8E5 = 1;
  var_7 _id_07D6::_id_159C("any");
  var_7 _id_218D();
  var_7._id_15E2 = 0;
  var_7.carryweapon = level._id_21BB;
  var_7._id_8CC4 = 0;
  var_7._id_1042D = (0, 0, 30);
  var_7._id_3207 = ::_id_210F;
  var_7._id_AB4D = ::_id_2137;
  var_7._id_D537 = ::_id_2152;
  var_7._id_AB88 = ::_id_213A;
  var_7._id_32F7 = ::_id_213C;
  var_7._id_7D6B = 0;
  var_7._id_8FA8 = 0;
  var_7._id_AE87 = 0;
  var_7._id_C589 = 1;
  var_7._id_8FA9 = "none";
  var_7._id_2197 = level._id_21B2.size;
  var_7._id_B730 = undefined;
  var_7._id_B72F = undefined;
  var_7._id_AEB4 = undefined;
  var_7._id_AEB3 = undefined;
  var_7._id_10430[0] _meth_85AA(1);

  if(isDefined(level._id_DCA0)) {
    switch (level._id_DCA0) {
      case 0:
        var_7 _id_07D6::_id_D8E0("friendly");
        var_7._id_A90C = 0;
        var_7._id_A90B = 1;
        var_7._id_A912 = 60.0;
        break;
      case 1:
        var_7 _id_07D6::_id_D8E0("any");
        var_7._id_A90C = 0;
        var_7._id_A90B = 0;
        var_7._id_A912 = 0.05;
        break;
      case 2:
        var_7 _id_07D6::_id_D8E0("any");
        var_7._id_A90C = 0;
        var_7._id_A90B = 1;
        var_7._id_A912 = 1.0;
        break;
      case 3:
        var_7 _id_07D6::_id_D8E0("any");
        var_7._id_A90C = 0;
        var_7._id_A90B = 1;
        var_7._id_A912 = 1.5;
        break;
      case 4:
        var_7 _id_07D6::_id_D8E0("any");
        var_7._id_A90C = 0;
        var_7._id_A90B = 1;
        var_7._id_A912 = 2.0;
        break;
      case 5:
        var_7 _id_07D6::_id_D8E0("any");
        var_7._id_A90C = 0;
        var_7._id_A90B = 1;
        var_7._id_A912 = 3.0;
        break;
      case 6:
        var_7 _id_07D6::_id_D8E0("any");
        var_7._id_A90C = 0;
        var_7._id_A90B = 1;
        var_7._id_A912 = 4.0;
        break;
    }
  } else {
    var_7 _id_07D6::_id_D8E0("any");
    var_7._id_A90C = 0;
    var_7._id_A90B = 1;
    var_7._id_A912 = 3.0;
  }

  var_7 _id_210C(var_2);
  level._id_21B2[level._id_21B2.size] = var_7;

  if(scripts\mp\utility\game::getgametype() == "tdef") {
    level._id_21B2[0] thread _id_E6BA();
  }

  if(!istrue(level._id_48DF)) {
    var_7 thread _id_2121(1, 1);
  }

  var_7 thread _id_2132();
  var_8 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip"];
  var_9 = physics_createcontents(var_8);
  level._id_21AE = var_9;
  level._id_21B7 = 10;

  if(scripts\mp\utility\game::getgametype() == "tdef") {
    level._id_21B7 = 20;
  }
}

_id_210F(var_0) {
  if(isDefined(self._id_506E) && self._id_506E >= gettime()) {
    return 0;
  }

  if(isPlayer(var_0)) {
    if(!var_0 scripts\common\utility::_id_871C()) {
      return 0;
    }

    if(isDefined(var_0._id_9A66) && var_0._id_9A66) {
      return 0;
    }

    if(istrue(var_0._id_87A7)) {
      return 0;
    }

    if(!_id_FF2F(var_0)) {
      return 0;
    }

    var_1 = var_0 getcurrentweapon();

    if(isDefined(var_1)) {
      if(!_id_FF2E(var_1)) {
        return 0;
      }
    }

    var_2 = var_0._id_33EF;

    if(isDefined(var_2) && var_0 isswitchingweapon()) {
      if(!_id_FF2E(var_2)) {
        return 0;
      }
    }

    if(var_0 scripts\cp_mp\utility\inventory_utility::_id_8755()) {
      var_2 = var_0 scripts\cp_mp\utility\inventory_utility::_id_69A6();

      if(!_id_FF2E(var_2)) {
        return 0;
      }
    }

    if(var_0 scripts\mp\utility\player::_id_8ACE()) {
      return 0;
    }

    if(var_0 _id_B559()) {
      return 0;
    }
  } else
    return 0;

  return 1;
}

_id_2137(var_0, var_1) {
  var_0 notify("obj_picked_up");
  var_0 thread _id_3512();
  var_2 = 0;

  if(level._id_21B0) {
    if(_id_6F9E(var_0)) {
      var_0 thread _id_0A9F::_id_7003("ball_grab");
    }

    level._id_21AF = gettime();
    level._id_21B0 = 0;

    if(isDefined(level._id_BA10) && level._id_BA10 == 1 && istrue(level._id_BA11)) {
      var_2 = 1;
    }

    var_0 notify("ball_grab");
  }

  if(isDefined(level._id_BA10) && level._id_BA10 == 2 && istrue(level._id_BA11) && isDefined(self._id_8FA7) && self._id_8FA7 != var_0) {
    var_2 = 1;
  }

  if(scripts\mp\utility\game::getgametype() == "tdef") {
    var_0 scripts\mp\gametypes\tdef::_id_6D23();
    level thread scripts\mp\gametypes\tdef::_id_1FC4(var_0.team);

    if(!level._id_F263) {
      level scripts\mp\gamelogic::pausetimer();
    }
  }

  if(istrue(level._id_BA10)) {
    level _id_FD66(var_0.team, 0, 0, var_2);
  }

  level._id_FED4 = 0;
  level._id_3A18 = undefined;
  level._id_3A1A = undefined;
  var_3 = self._id_10430[0] _meth_8151();

  if(isDefined(var_3)) {
    self._id_10430[0] unlink();
  }

  if(!istrue(level._id_48DF)) {
    var_0 scripts\mp\utility\perk::_id_6FC2("specialty_ballcarrier");
  }

  var_0._id_2110 = self;
  var_0._id_A863 = 1;
  self._id_32D5 scripts\mp\utility\perk::_id_6FC2("specialty_sprintfire");
  self._id_32D5._id_7593 = 1;

  if(!istrue(level._id_48DF)) {
    var_0 _id_07EA::_id_D5E2(var_0, level._id_32D6);
  }

  if(!istrue(level._id_48DF)) {
    thread _id_214B(var_0.team, "mp_uplink_ball_pickedup_friendly", "mp_uplink_ball_pickedup_enemy");
  }

  var_0 scripts\common\utility::_id_158A(0);
  var_0 scripts\mp\equipment::allow_equipment(0, "obj_ball");
  self._id_10430[0] physicslaunchserver(self._id_10430[0].origin, (0, 0, 0));
  self._id_10430[0] _meth_8545();
  self._id_10430[0] scripts\mp\movers::_id_A672();
  self._id_AE87 = 0;
  self._id_10430[0] _id_E89D();
  self._id_10430[0] show();
  self._id_10430[0] hide(1);
  self._id_10430[0] linkto(var_0, "j_wrist_ri", (0, 0, 0), var_0.angles);
  self._id_10430[0] setscriptablepartstate("uplink_drone_hide", "hide", 0);
  self.trigger scripts\mp\movers::_id_E8A3();
  self._id_419D._id_7D7E = 0;
  var_4 = 0;

  if(isDefined(self._id_BD9B)) {
    var_4 = 1;
    self._id_BD9B delete();
  }

  var_5 = var_0.team;
  var_6 = scripts\mp\utility\game::_id_6BE2(var_0.team)[0];
  self._id_10430[0] setotherent(var_0);

  if(var_4) {
    if(self._id_8FA9 == var_0.team) {
      if(!istrue(level._id_48DF)) {
        _id_0A8D::_id_E775("pass_complete", var_5);
      }

      var_0._id_AEB5 = gettime();
      var_0._id_AEB2 = self._id_8FA7;
    } else {
      if(!istrue(level._id_48DF)) {
        _id_0A8D::_id_E775("pass_intercepted", var_5);
      }

      var_0 thread _id_07B1::_id_6FB9("mode_uplink_intercept");

      if(isPlayer(var_0)) {
        var_7 = spawnStruct();
        var_7.player = var_0;
        var_7._id_56B9 = "pickup_interception";
        var_7._id_033E = var_0.origin;
        _id_06E2::_id_4C2A("callback_on_game_event", var_7);
      }
    }
  } else {
    if(!istrue(level._id_48DF) && self._id_8FA9 != var_0.team) {
      _id_0A8D::_id_E775("ally_own_drone", var_5);
      _id_0A8D::_id_E775("enemy_own_drone", var_6);
    }

    if(isPlayer(var_0)) {
      var_7 = spawnStruct();
      var_7.player = var_0;
      var_7._id_56B9 = "pickup";
      var_7._id_033E = var_0.origin;
      _id_06E2::_id_4C2A("callback_on_game_event", var_7);
    }
  }

  if(!istrue(level._id_48DF)) {
    _id_2123();
  }

  self._id_8FA8 = 0;
  self._id_8FA7 = var_0;
  self._id_8FA9 = var_0.team;
  self._id_ADAE = var_0.team;
  _id_218C(self._id_ADAE);
  var_0 setweaponammoclip(level._id_21BB, 1);

  if(level.codcasterenabled) {
    var_0 _meth_80CB(1);
  }

  var_0 thread _id_B619(self);

  if(!istrue(level._id_48DF)) {
    scripts\mp\gamelogic::_id_D58D(var_0, 1);
  }

  self notify("physics_timeout");
}

_id_3512() {
  self endon("death_or_disconnect");
  self endon("drop_object");
  waitframe();

  if(isDefined(self._id_62F1) && self _meth_84B7(self._id_62F1)) {
    self _meth_8494(self._id_62F1, 0.05, 1);
  }
}

_id_48CB() {}

_id_6F9E(var_0) {
  if(scripts\mp\utility\game::getgametype() == "tdef") {
    var_1 = 15000;
  } else {
    var_1 = 10000;
  }

  var_2 = var_0 _id_FC19();

  if(var_2) {
    return 0;
  }

  if(isDefined(self._id_8FA7) && var_0.team == self._id_8FA7.team && gettime() < level._id_21AF + var_1) {
    return 0;
  }

  return 1;
}

_id_FC19() {
  if(!isDefined(self._id_29EE)) {
    self._id_A787 = 0;
    self._id_29EE = 0;
  }

  self._id_A787++;

  if(scripts\mp\utility\game::_id_6B5F() < 1) {
    return 0;
  }

  self._id_29EE = self._id_A787 / scripts\mp\utility\game::_id_6B5F();

  if(self._id_29EE < 4) {
    return 0;
  } else {
    return 1;
  }
}

_id_214B(var_0, var_1, var_2) {
  var_3 = scripts\mp\utility\game::_id_6BE2(var_0)[0];

  foreach(var_5 in level.players) {
    if(var_5.team == var_0) {
      var_5 playlocalsound(var_1);
      continue;
    }

    if(var_5.team == var_3) {
      var_5 playlocalsound(var_2);
    }
  }
}

_id_2152(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_4 = 0;
  self._id_89FF = 1;
  self._id_506E = gettime();
  self notify("dropped");
  var_5 = (0, 0, 0);
  var_6 = self._id_32D5;

  if(isDefined(var_6) && var_6.team != "spectator") {
    var_7 = var_6.origin;
    var_5 = var_6.angles;
    var_6 notify("ball_dropped");
  } else if(isDefined(var_1))
    var_7 = var_1;
  else {
    var_7 = self._id_CAE7;
  }

  var_7 = var_7 + (0, 0, 40);

  if(isDefined(self._id_BD9B)) {
    self._id_BD9B delete();
  }

  for(var_8 = 0; var_8 < self._id_10430.size; var_8++) {
    self._id_10430[var_8].origin = var_7;
    self._id_10430[var_8].angles = var_5;
    self._id_10430[var_8] show();
    var_9 = self._id_10430[var_8] _meth_8151();

    if(isDefined(var_9)) {
      self._id_10430[var_8] unlink();
    }

    self._id_10430[var_8] setscriptablepartstate("uplink_drone_hide", "show", 0);
  }

  if(istrue(var_3) || istrue(var_2)) {
    var_4 = 1;
  }

  _id_2111(var_4);

  if(!isDefined(level._id_CC05)) {
    level._id_CC05 = 0;
  }

  if(level._id_CC05 > 0) {
    self.trigger.origin = self.trigger.origin - (0, 0, 10000);
  } else {
    self.trigger.origin = var_7;
  }

  _id_211B();
  self._id_4140 = self.trigger.origin;

  if(!istrue(level._id_48DF)) {
    thread _id_2121(0);
  }

  self._id_ADAE = "any";
  _id_218D();
  _id_07D6::_id_392B();

  if(isDefined(var_6)) {
    var_6 _id_B61A();
  }

  _id_07D6::_id_FC3B();
  self._id_89FF = 0;

  if(!var_0) {
    var_10 = self._id_8FA9;
    var_11 = scripts\mp\utility\game::_id_6BE2(var_10)[0];

    if(!istrue(level._id_48DF) && !isDefined(var_1) && !istrue(var_2)) {
      _id_0A8D::_id_E775("ally_drop_drone", var_10);
      _id_0A8D::_id_E775("enemy_drop_drone", var_11);
    }

    var_12 = (0, var_5[1], 0);
    var_13 = anglesToForward(var_12);

    if(isDefined(var_1)) {
      var_14 = var_13 * 20 + (0, 0, 80);
    } else {
      var_14 = var_13 * 200 + (0, 0, 80);
    }

    _id_2144(var_14);
  }

  var_15 = spawnStruct();
  var_15._id_32EC = self;
  var_15._id_43F7 = ::_id_213B;
  self.trigger thread scripts\mp\movers::_id_7403(var_15);

  if(level._id_F263) {
    level scripts\mp\gamelogic::resumetimer();
  }

  return 1;
}

_id_2111(var_0) {
  if(isDefined(self._id_32D5)) {
    if(scripts\mp\utility\game::getgametype() == "tdef") {
      self._id_32D5 scripts\mp\gametypes\tdef::_id_6D23();
    }

    self._id_32D5._id_2195 = undefined;
    self._id_32D5._id_A5B8 = gettime() + 500;
    self._id_32D5 _id_B3F1();
    self._id_32D5 notify("cancel_update_pass_target");
    self._id_32D5._id_2110 = undefined;

    if(!istrue(level._id_48DF)) {
      self._id_32D5 scripts\mp\utility\perk::removeperk("specialty_ballcarrier");
      self._id_32D5 _id_07EA::_id_9455(self._id_32D5);
    }

    if(self._id_32D5._id_7593) {
      self._id_32D5 scripts\mp\utility\perk::removeperk("specialty_sprintfire");
    }

    self._id_32D5._id_7593 = 0;

    if(level.codcasterenabled) {
      self._id_32D5 _meth_80CB(0);
    }

    self._id_32D5 scripts\common\utility::_id_158A(1);

    if(istrue(var_0)) {
      self._id_32D5 scripts\mp\equipment::allow_equipment(1, "obj_ball");
    }

    self._id_32D5 _meth_8544(0);
    self._id_32D5._id_A863 = 0;
    self._id_10430[0] setotherent(undefined);
  }
}

_id_213A() {
  _id_210C(level._id_2156[self._id_2197]);
  _id_214E();
  var_0 = self._id_10430[0];
  var_0 scripts\mp\movers::_id_A672();
  var_1 = var_0 _meth_8151();

  if(isDefined(var_1)) {
    var_0 unlink();
  }

  self._id_10430[0] _id_E89D();
  var_0 physicslaunchserver(var_0.origin, (0, 0, 0));
  var_0 _meth_8545();
  _id_211B();

  if(isDefined(self._id_BD9B)) {
    self._id_BD9B delete();
  }

  var_2 = "none";
  var_3 = self._id_8FA9;

  if(isDefined(var_3)) {
    var_2 = scripts\mp\utility\game::_id_6BE2(var_3)[0];
  }

  self._id_8FA9 = "none";
  _id_2111(1);
  self.trigger scripts\mp\movers::_id_E8A3();
  _id_218B();

  if(scripts\mp\utility\game::getgametype() != "tdef") {
    _id_07D6::_id_D684(var_0._id_2323 + (0, 0, 4000), (0, 0, 0));
    var_0 moveto(var_0._id_2323, 3, 0, 3);
    var_0 rotatevelocity((0, 720, 0), 3, 0, 3);
  } else {
    if(!level._id_F263) {
      level scripts\mp\gamelogic::pausetimer();
    }

    var_0 hide(1);
    self._id_10430[0] setscriptablepartstate("uplink_drone_hide", "hide", 0);
    thread _id_10823(var_0);
  }

  if(!istrue(level._id_48DF)) {
    playsoundatpos(var_0._id_2323, "mp_uplink_ball_reset");
  }

  if(!self._id_8FA8 && isDefined(var_3) && isDefined(var_2)) {
    if(!istrue(level._id_48DF) && var_3 != "none" && !istrue(level.gameended)) {
      _id_0A8D::_id_E775("drone_reset", var_3);
      _id_0A8D::_id_E775("drone_reset", var_2);
    }

    if(isDefined(self._id_8FA7)) {}
  }

  self._id_ADAE = "any";

  if(scripts\mp\utility\game::getgametype() == "ball" || level._id_48DF) {
    thread _id_211D(3);
  }

  if(!istrue(level._id_48DF)) {
    thread _id_211C(var_0, 3);
  }

  var_4 = spawnStruct();
  var_4.player = self;
  var_4._id_56B9 = "obj_return";
  var_4._id_033E = var_0._id_2323;
  _id_06E2::_id_4C2A("callback_on_game_event", var_4);
}

_id_2115() {
  self._id_10430[0] notsolid();
}

_id_213C() {
  self endon("disconnect");
  thread _id_2140();
  thread _id_2154();
  thread _id_2190();
  self._id_32EC waittill("dropped");
}

_id_2140() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");

  for(;;) {
    self waittill("ball_pass", var_0);

    if(var_0 != level._id_21BB) {
      continue;
    }
    if(!isDefined(self._id_AE94)) {
      self iprintlnbold("No Pass Target");
      continue;
    }

    self._id_32EC._id_AE87 = 1;
    break;
  }

  if(isDefined(self._id_32EC)) {
    thread _id_213D();
    var_1 = self._id_AE94;
    var_2 = self._id_AE94.origin;
    wait 0.15;

    if(isDefined(self._id_AE94)) {
      var_1 = self._id_AE94;
    }

    self._id_32EC thread _id_213E(self, var_1, var_2);
  }
}

_id_2154() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");

  if(scripts\mp\utility\game::getgametype() != "tdef") {
    var_0 = getdvarfloat("#x38ab6d268fecd0724", 0);
    var_1 = getdvarfloat("#x35726e2e642669700", 825);
  } else {
    var_0 = getdvarfloat("#x33e1ff5e82da6198a", -3);
    var_1 = getdvarfloat("#x31bb05f9e92c3b0ba", 450);
  }

  for(;;) {
    self waittill("weapon_fired", var_2);

    if(var_2 != level._id_21BB) {
      continue;
    }
    self setweaponammoclip(var_2, 0);
    break;
  }

  if(isDefined(self._id_32EC)) {
    var_3 = spawnStruct();
    var_3.player = self;
    var_3._id_56B9 = "pass";
    var_3._id_033E = self.origin;
    _id_06E2::_id_4C2A("callback_on_game_event", var_3);

    if(!istrue(level._id_48DF)) {
      self playSound("mp_uplink_ball_pass");
    }

    wait 0.15;

    if(self issprintsliding()) {
      var_0 = -12;

      if(scripts\mp\utility\game::getgametype() == "tdef") {
        var_1 = var_1 + 200;
      }
    }

    var_4 = self getplayerangles();
    var_4 = var_4 + (var_0, 0, 0);
    var_4 = (clamp(var_4[0], -85, 85), var_4[1], var_4[2]);
    var_5 = anglesToForward(var_4);
    thread _id_213D();
    thread _id_2114(self._id_32EC);
    self._id_32EC _id_2118();
    self._id_32EC thread _id_2145(var_5 * var_1, self);
  }
}

_id_2190() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("drop_object");
  thread _id_EB13();
  var_0 = level._id_21BB;

  for(;;) {
    if(var_0 == self getcurrentweapon()) {
      break;
    }

    self waittill("weapon_change");
  }

  for(;;) {
    self waittill("weapon_change", var_1);

    if(isDefined(var_1) && scripts\mp\utility\weapon::_id_8A7D(var_1.basename)) {
      break;
    }
  }

  var_2 = self getplayerangles();
  var_2 = (clamp(var_2[0], -85, 85), _func_043F(var_2[1] + 20), var_2[2]);
  var_3 = anglesToForward(var_2);
  var_4 = 90;
  self._id_32EC thread _id_2145(var_3 * var_4, self, 1);
}

_id_EB13() {
  self endon("death_or_disconnect");
  self endon("drop_object");
  self endon("unsetBallCarrier");
  self waittill("super_started");
  var_0 = self._id_EB09;

  switch (var_0._id_E76B._id_C189) {
    case "super_chargemode":
      _id_211E();
      break;
    case "super_rewind":
      scripts\engine\utility::waittill_any_2("teleport_success", "rewind_success");
      _id_211E();
      break;
  }
}

_id_211E() {
  var_0 = self getplayerangles();
  var_0 = (clamp(var_0[0], -85, 85), _func_043F(var_0[1] + 20), var_0[2]);
  var_1 = anglesToForward(var_0);
  var_2 = 90;
  self._id_32EC thread _id_2145(var_1 * var_2, self, 1);
}

_id_213D() {
  self endon("death_or_disconnect");
  self._id_AE91 = 1;
  self allowmelee(0);

  while(level._id_21BB == self getcurrentweapon()) {
    waitframe();
  }

  self allowmelee(1);
  self._id_AE91 = 0;
  scripts\mp\equipment::allow_equipment(1, "obj_ball");
}

_id_2145(var_0, var_1, var_2) {
  _id_2152(1, undefined, 0, var_2);
  _id_2144(var_0, var_1);
}

_id_213E(var_0, var_1, var_2) {
  _id_2152(1);

  if(isDefined(var_1)) {
    var_2 = var_1.origin;
  }

  var_3 = var_0 _id_6C12();
  var_4 = var_0 _id_6C11();

  if(!_id_FF4F(self, var_0, var_1)) {
    var_3 = self._id_90C0;
    var_4 = self._id_90BF;
  }

  var_5 = var_4 * 30;
  var_6 = var_4 * 60;
  var_7 = var_3 + var_5;
  var_8 = var_1 _id_6DC2();
  var_9 = scripts\engine\trace::_id_E409(var_7, var_8, level._id_21B7, var_0, level._id_21AE, 0);
  var_10 = 1.0;

  if(var_9["fraction"] < 1) {
    if(var_9["hittype"] == "hittype_entity" && isDefined(var_9["entity"]) && isPlayer(var_9["entity"])) {
      var_10 = max(0.1, 0.7 * var_9["fraction"]);
    } else {
      var_10 = 0.7 * var_9["fraction"];
    }

    _id_07D6::_id_D684(var_7 + var_5 * var_10, self._id_10430[0].angles);
  } else
    _id_07D6::_id_D684(var_9["position"], self._id_10430[0].angles);

  if(isDefined(var_1)) {
    self._id_BD9B = scripts\cp_mp\utility\weapon_utility::_magicbullet(makeweapon("uplinkball_tracking_mp"), var_7 + var_6 * var_10, var_8, var_0);
    self._id_BD9B missile_settargetent(var_1, var_1 _id_6DC1());
  }

  self.trigger.origin = self.trigger.origin - (0, 0, 10000);
  var_1 thread _id_1194(self._id_BD9B);
  self._id_10430[0] linkto(self._id_BD9B);
  _id_211B();
  _id_2118();
  _id_2115();
  level._id_3A18 = self._id_10430[0];
  thread _id_2139();
  thread _id_2138();
  thread _id_2136();
  thread _id_215A();
  thread _id_2159();
  thread _id_215B(var_1);

  if(scripts\mp\utility\game::getgametype() == "ball") {
    thread scripts\mp\gametypes\ball::_id_213F();
  }
}

_id_B619(var_0) {
  self endon("disconnect");
  self endon("cancel_update_pass_target");
  _id_B61A();
  childthread _id_B52B();

  for(;;) {
    var_1 = undefined;

    if(!self isonladder()) {
      var_2 = [];

      foreach(var_4 in level.players) {
        if(!isDefined(var_4.team)) {
          continue;
        }
        if(var_4.team != self.team) {
          continue;
        }
        if(!scripts\mp\utility\player::isreallyalive(var_4)) {
          continue;
        }
        if(!var_0 _id_210F(var_4)) {
          continue;
        }
        if(_id_FF4F(var_0, self, var_4)) {
          var_2[var_2.size] = var_4;
        }
      }

      if(isDefined(var_2) && var_2.size > 0) {
        var_2 = scripts\mp\utility\script::_id_BEF7(var_2, ::_id_3AF5);
        var_6 = self getEye();

        foreach(var_4 in var_2) {
          var_8 = var_4 _id_6DC2();

          if(_func_0202(var_6, var_8, 0, self, var_4)) {
            var_1 = var_4;
            break;
          }
        }
      }
    }

    _id_B5CB(var_1);
    waitframe();
  }
}

_id_FF4F(var_0, var_1, var_2) {
  var_3 = 0.85;
  var_4 = var_1 _id_6C12();
  var_5 = var_1 _id_6C11();
  var_6 = var_2 _id_6DC2();
  var_7 = distancesquared(var_6, var_4);

  if(var_7 > level._id_21AD) {
    return 0;
  }

  var_8 = vectornormalize(var_6 - var_4);
  var_9 = vectordot(var_5, var_8);

  if(var_9 > var_3) {
    var_10 = var_5 * 30;
    var_11 = var_4 + var_10;
    var_12 = scripts\engine\trace::_id_E409(var_11, var_6, level._id_21B7, var_1, level._id_21AE, 0);

    if(isDefined(var_12["entity"]) && isPlayer(var_12["entity"]) || var_12["fraction"] > 0.8) {
      var_2._id_AE89 = var_9;
      var_0._id_90C0 = var_4;
      var_0._id_90BF = var_5;
      return 1;
    }
  }

  return 0;
}

_id_B61A() {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self._id_32EC)) {
    return;
  }
  if(isDefined(self._id_32EC._id_AEB4) && isDefined(self._id_32EC._id_AEB3)) {
    scripts\mp\utility\outline::outlinedisable(self._id_32EC._id_AEB4, self._id_32EC._id_AEB3);
    self._id_32EC._id_AEB4 = undefined;
    self._id_32EC._id_AEB3 = undefined;
  }

  if(isDefined(self._id_32EC._id_B730) && isDefined(self._id_32EC._id_B72F)) {
    scripts\mp\utility\outline::outlinedisable(self._id_32EC._id_B730, self._id_32EC._id_B72F);
    self._id_32EC._id_B730 = undefined;
    self._id_32EC._id_B72F = undefined;
  }

  if(self._id_32EC._id_89FF) {
    return;
  }
  var_0 = [];
  var_1 = [];
  var_2 = scripts\mp\utility\game::_id_6BE2(self.team)[0];
  var_3 = undefined;
  var_4 = undefined;

  foreach(var_6 in level.players) {
    if(var_6 == self) {
      continue;
    }
    if(var_6.team == self.team) {
      var_0[var_0.size] = var_6;
      continue;
    }

    if(var_6.team == var_2) {
      var_1[var_1.size] = var_6;
    }
  }

  foreach(var_6 in var_0) {
    var_9 = isDefined(self._id_AE94) && self._id_AE94 == var_6;
  }

  if(isDefined(self._id_AE94)) {
    var_3 = scripts\mp\utility\outline::outlineenableforplayer(self._id_AE94, self, "outline_depth_cyan", "level_script");
  }

  self._id_32EC._id_AEB4 = var_3;
  self._id_32EC._id_AEB3 = self._id_AE94;

  if(scripts\mp\utility\game::getgametype() == "tdef" && var_0.size > 0) {
    var_4 = scripts\mp\utility\outline::_id_ACD2(self, self.team, "outlinefill_nodepth_cyan", "level_script");
  }

  self._id_32EC._id_B730 = var_4;
  self._id_32EC._id_B72F = self;
}

_id_1194(var_0) {
  var_1 = self;
  var_0 endon("pass_end");

  while(isDefined(var_1) && isDefined(var_0)) {
    var_0 missile_settargetent(var_1, var_1 _id_6DC1());
    waitframe();
  }
}

_id_3AF5(var_0, var_1) {
  return var_0._id_AE89 >= var_1._id_AE89;
}

_id_B52B() {}

_id_B5CB(var_0) {
  var_1 = 80;
  var_2 = 0;

  if(isDefined(var_0)) {
    switch (var_0 getstance()) {
      case "crouch":
        var_1 = 60;
        break;
      case "prone":
        var_1 = 35;
        break;
    }

    if(!isDefined(self._id_AE8F) || self._id_AE8F != var_1) {
      var_2 = 1;
      self._id_AE8F = var_1;
    }
  }

  var_3 = (0, 0, var_1);

  if(isDefined(self._id_AE94) && isDefined(var_0) && self._id_AE94 == var_0) {
    if(var_2) {
      self._id_AE8E = var_0 thread _id_078F::_id_D59B(self, "waypoint_ball_pass", var_1, 0, undefined, undefined, 0.05);
    }

    return;
  }

  if(!isDefined(self._id_AE94) && !isDefined(var_0)) {
    return;
  }
  _id_B3F1();

  if(isDefined(var_0)) {
    self._id_AE8E = var_0 thread _id_078F::_id_D59B(self, "waypoint_ball_pass", var_1, 0, undefined, undefined, 0.05);
    self._id_AE94 = var_0;
    var_4 = [];

    foreach(var_6 in level.players) {
      if(var_6.team == self.team && var_6 != self && var_6 != var_0) {
        var_4[var_4.size] = var_6;
      }
    }

    self _meth_8544(1);
  }

  _id_B61A();
}

_id_B3F1() {
  if(isDefined(self._id_AE8E)) {
    self._id_AE8E destroy();
  }

  var_0 = [];

  foreach(var_2 in level.players) {
    if(var_2.team == self.team && var_2 != self) {
      var_0[var_0.size] = var_2;
    }
  }

  self._id_AE94 = undefined;
  self _meth_8544(0);
  _id_B61A();
}

_id_B559() {
  return isDefined(self._id_A5B8) && self._id_A5B8 > gettime() || isDefined(self._id_2110);
}

_id_FF2F(var_0) {
  if(!isDefined(var_0._id_EB09)) {
    return 1;
  }

  if(!isDefined(var_0._id_EB09._id_88D4) || !var_0._id_EB09._id_88D4) {
    return 1;
  }

  return 1;
}

_id_FF2E(var_0) {
  var_1 = undefined;

  if(isweapon(var_0)) {
    if(isnullweapon(var_0)) {
      return 0;
    }

    if(var_0 == level._id_21BB) {
      return 0;
    }

    var_1 = var_0.basename;
  }

  if(_func_0121(var_0)) {
    if(var_0 == "none") {
      return 0;
    }

    if(var_0 == level._id_21BB.basename) {
      return 0;
    }

    var_1 = var_0;
  }

  if(scripts\mp\utility\killstreak::_id_89FB(var_1)) {
    return 0;
  }

  if(scripts\mp\utility\weapon::_id_88F6(var_0)) {
    return 0;
  }

  return 1;
}

_id_2136() {
  self._id_10430[0] endon("pass_end");
  level waittill("host_migration_begin");

  if(isDefined(self._id_BD9B)) {
    if(!isDefined(self._id_AE94) && !isDefined(self._id_32D5) && !self._id_7D6B) {
      if(self._id_10430[0].origin != self._id_10430[0]._id_2323 + (0, 0, 4000)) {
        _id_214E();

        if(!isDefined(self._id_9026)) {
          self._id_9026 = (0, 0, 1);
        }

        _id_2144(self._id_9026 * 400);
      }
    }
  }
}

_id_215A() {
  self._id_10430[0] endon("pass_end");
  self._id_BD9B endon("projectile_impact_player");
  self._id_BD9B endon("death");
  self._id_9026 = undefined;
  var_0 = undefined;

  for(;;) {
    if(isDefined(var_0)) {
      self._id_9026 = vectornormalize(self._id_BD9B.origin - var_0);
    }

    var_0 = self._id_BD9B.origin;
    waitframe();
  }
}

_id_2159() {
  self._id_10430[0] endon("pass_end");
  self._id_BD9B endon("projectile_impact_player");
  self._id_BD9B endon("death");
  var_0 = gettime();

  for(var_1 = var_0; var_1 < var_0 + 2000; var_1 = gettime()) {
    waitframe();
  }

  self._id_BD9B delete();
}

_id_215B(var_0) {
  self._id_10430[0] endon("pass_end");
  self._id_BD9B endon("projectile_impact_player");
  self._id_BD9B endon("death");

  for(;;) {
    if(!isDefined(var_0)) {
      break;
    }

    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      break;
    }

    waitframe();
  }

  self._id_BD9B delete();
}

_id_2138() {
  self endon("reset");
  self._id_BD9B waittill("death");
  waittillframeend;
  self.trigger.origin = self._id_4140;
  var_0 = self._id_10430[0];

  if(!isDefined(self._id_32D5) && !self._id_7D6B) {
    if(var_0.origin != var_0._id_2323 + (0, 0, 4000)) {
      _id_214E();

      if(!isDefined(self._id_9026)) {
        self._id_9026 = (0, 0, 1);
      }

      _id_2144(self._id_9026 * 400);
    }
  }

  _id_214E();
  var_0 notify("pass_end");
}

_id_2139() {
  self._id_10430[0] endon("pass_end");
  self._id_BD9B waittill("projectile_impact_player", var_0);
  self.trigger.origin = self._id_10430[0].origin;
  self.trigger notify("trigger", var_0);
}

_id_2144(var_0, var_1) {
  var_2 = self._id_10430[0];
  var_2._id_AC7E = undefined;
  var_3 = var_2.origin;
  var_4 = var_2;

  if(isDefined(var_1)) {
    var_4 = var_1;
    var_3 = var_1 getEye();
    var_5 = anglestoright(var_0);
    var_3 = var_3 + (var_5[0], var_5[1], 0) * 7;

    if(var_1 issprintsliding()) {
      var_3 = var_3 + (0, 0, 10);
    }

    var_6 = var_3;
    var_7 = vectornormalize(var_0) * 80;
    var_8 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip"];
    var_9 = physics_createcontents(var_8);
    var_10 = scripts\engine\trace::_id_E409(var_6, var_6 + var_7, 38, var_1, var_9);

    if(var_10["fraction"] < 1) {
      var_11 = 0.7 * var_10["fraction"];
      _id_07D6::_id_D684(var_6 + var_7 * var_11, var_2.angles);
    } else
      _id_07D6::_id_D684(var_10["position"], var_2.angles);
  }

  self._id_10430[0] physicslaunchserver(var_2.origin, var_0);
  self._id_10430[0] thread scripts\mp\utility\entity::register_physics_collisions();
  self._id_10430[0] physics_registerforcollisioncallback();
  scripts\mp\utility\entity::_id_C208(self._id_10430[0], ::_id_212F);
  self._id_10430[0].origin = self.trigger.origin;
  self.trigger linkto(self._id_10430[0]);
  level._id_3A18 = self._id_10430[0];
  level._id_3A1B = var_4;
  level._id_3A1A = var_0;
  thread _id_2146();
  thread _id_2147(var_1);
  thread _id_2142();

  if(scripts\mp\utility\game::getgametype() == "ball") {
    thread scripts\mp\gametypes\ball::_id_2149();
  }

  thread _id_2148(var_1);
}

_id_2148(var_0) {
  var_1 = self._id_10430[0];
  var_2 = self.trigger;
  self._id_10430[0] endon("physics_finished");
  self endon("physics_timeout");
  self endon("pickup_object");
  self endon("reset");
  self endon("score_event");

  for(;;) {
    var_2 waittill("trigger", var_3);

    if(!isPlayer(var_3) && !isagent(var_3)) {
      continue;
    }
    if(isDefined(var_0) && var_0 == var_3 && var_3 _id_B559()) {
      continue;
    }
    if(self._id_506E >= gettime()) {
      continue;
    }
    if(var_1.origin == var_1._id_2323 + (0, 0, 4000)) {
      continue;
    }
    if(!_id_210F(var_3)) {
      if(var_3 _id_B559()) {
        continue;
      }
      var_3._id_A5B8 = gettime() + 500;
      thread _id_2143();
    }
  }
}

_id_2143(var_0) {
  var_1 = self._id_10430[0];
  var_2 = var_1 _meth_846E(0);
  var_3 = _func_02A1(var_2);

  if(isDefined(var_0) && var_0) {
    var_4 = length(var_3) * 0.4;
    thread _id_10C08();
  } else
    var_4 = length(var_3) / 10;

  var_5 = vectornormalize(var_3);
  var_5 = (-1, -1, -0.5) * var_5;
  var_1 physicslaunchserver(var_1.origin, (0, 0, 0));
  var_1 _meth_8545();
  var_1 physicslaunchserver(var_1.origin, var_5 * var_4);
  var_1._id_B04F = 1;
}

_id_B04D() {
  self endon("death");

  for(;;) {
    self waittill("projectile_impact", var_0, var_1, var_2, var_3);
    var_4 = level._effect["ball_physics_impact"];

    if(isDefined(var_3) && isDefined(level._effect["ball_physics_impact_" + var_3])) {
      var_4 = level._effect["ball_physics_impact_" + var_3];
    }

    if(!istrue(level._id_48DF)) {
      playFX(var_4, var_0, var_1);
    }

    wait 0.3;
  }
}

_id_212F(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = var_0 _meth_846E(0);
  var_10 = _func_02A1(var_9);
  var_11 = length(var_10);

  if(isDefined(var_0._id_B85D) || var_11 < 70) {
    return;
  }
  var_0 endon("death");
  var_0._id_B85D = 1;
  var_12 = "mp_uplink_ball_bounce";
  var_0 playSound(var_12);
  var_13 = _func_0142(var_12);
  wait 0.1;
  var_0._id_B85D = undefined;
}

_id_214F(var_0, var_1) {
  self._id_2120 = 0;

  if(istrue(level._id_57B9) && istrue(var_0)) {
    _id_48CB();
  }

  if(istrue(level._id_BA10)) {
    if(istrue(level._id_2191)) {
      level _id_FD66("neutral", 0, 1);
    } else {
      level _id_FD66("neutral", 1, 1);
    }
  }

  level._id_3A18 = undefined;
  level._id_3A1A = undefined;
  level._id_21B0 = 1;
  self._id_7D6B = 0;
  var_2 = self._id_10430[0];
  var_2 physicslaunchserver(var_2.origin, (0, 0, 0));
  var_2 _meth_8545();

  if(!istrue(level._id_48DF)) {
    playsoundatpos(var_2.origin, "mp_uplink_ball_out_of_bounds");
    playFX(scripts\engine\utility::getfx("ball_teleport"), var_2.origin);
  }

  if(isDefined(self._id_32D5)) {
    self._id_32D5 scripts\engine\utility::delaythread(0.05, ::_id_B61A);
  }

  self._id_10430[0] setscriptablepartstate("uplink_drone_hide", "show", 0);
  thread _id_07D6::_id_C797();
}

_id_213B(var_0) {
  var_0._id_32EC _id_214F(0, 1);
}

_id_211D(var_0) {
  self endon("pickup_object");
  _id_07D6::_id_159C("none");
  self._id_89FF = 1;
  wait(var_0);
  self._id_89FF = 0;
  _id_218D();
  _id_07D6::_id_159C("any");
  self notify("ball_ready");

  if(!istrue(level._id_48DF)) {
    playFX(level._effect["ball_download_end"], self._id_4140);
    thread _id_2121(0, 1);
  }

  if(scripts\mp\utility\game::getgametype() == "tdef") {
    level _id_FD66("neutral", 1, 1);
    level._id_21B2[0] thread _id_E6BA();
  }
}

_id_10823(var_0) {
  self endon("pickup_object");
  self endon("game_ended");
  _id_07D6::_id_159C("none");

  if(level._id_2191 != 0) {
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(level._id_2191);
  }

  if(level._id_F263) {
    level scripts\mp\gamelogic::resumetimer();
  }

  _id_07D6::_id_D684(var_0._id_2323, (0, 0, 0));
  self._id_10430[0] setscriptablepartstate("uplink_drone_hide", "show", 0);
  thread _id_211D(0);
  var_0 rotatevelocity((0, 720, 0), 3, 0, 3);
}

_id_E6BA() {
  self endon("death");
  self endon("reset");
  self endon("pickup_object");
  self notify("hoverAnimStart");
  self endon("hoverAnimStart");
  var_0 = self._id_10430[0].origin;
  self._id_10430[0] rotateyaw(2000, 60, 0.2, 0.2);

  for(;;) {
    self._id_10430[0] moveto(var_0 + (0, 0, 5), 1, 0.5, 0.5);
    wait 1;
    self._id_10430[0] moveto(var_0 - (0, 0, 5), 1, 0.5, 0.5);
    wait 1;
  }
}

_id_2146() {
  self endon("reset");
  self endon("pickup_object");
  var_0 = self._id_10430[0];
  var_1[0] = 200;
  var_1[1] = 200;
  var_1[2] = 1000;
  var_2[0] = 200;
  var_2[1] = 200;
  var_2[2] = 200;

  for(;;) {
    for(var_3 = 0; var_3 < 2; var_3++) {
      if(var_0.origin[var_3] > level._id_2133[var_3] + var_1[var_3]) {
        _id_214F(1, 1);
        return;
      }

      if(var_0.origin[var_3] < level._id_2134[var_3] - var_2[var_3]) {
        _id_214F(1, 1);
        return;
      }
    }

    waitframe();
  }
}

_id_2147(var_0) {
  self endon("reset");
  self endon("pickup_object");
  self endon("score_event");

  if(!isDefined(level._id_7CD0)) {
    level._id_7CD0 = 15;
  }

  var_1 = level._id_7CD0;
  var_2 = 10;
  var_3 = 3;

  if(var_1 >= var_2) {
    wait(var_3);
    var_1 = var_1 - var_3;
  }

  wait(var_1);
  self notify("physics_timeout");
  _id_214F(1, 1);
}

_id_2142() {
  self._id_10430[0] endon("physics_finished");
  self endon("physics_timeout");
  self endon("pickup_object");
  self endon("reset");
  self endon("score_event");
  thread _id_2141();

  for(;;) {
    if(self._id_10430[0] _id_F393()) {
      thread _id_2143(1);
    }

    if(!self._id_10430[0] scripts\mp\utility\entity::_id_F390()) {
      if(self._id_10430[0] scripts\mp\utility\entity::_id_F38F() || self._id_10430[0] scripts\mp\utility\entity::_id_F394()) {
        _id_214F(0, 1);
        return;
      }
    }

    waitframe();
  }
}

_id_F393() {
  if(level._id_A6CD.size > 0) {
    foreach(var_1 in level._id_A6CD) {
      if(self istouching(var_1)) {
        return 1;
      }
    }
  }

  return 0;
}

_id_10C08() {
  self._id_10430[0] endon("physics_finished");
  self endon("physics_timeout");
  self endon("pickup_object");
  self endon("reset");
  self endon("score_event");
  var_0 = gettime();
  var_1 = var_0 + 500;

  for(;;) {
    if(self._id_10430[0] _id_F393() && var_1 < var_0) {
      _id_214F(1, 1);
      return;
    }

    wait 0.05;
    var_0 = gettime();
  }
}

_id_2141() {
  self endon("pickup_object");
  self endon("reset");
  self endon("score_event");
  var_0 = self._id_10430[0];
  var_0 endon("death");
  var_0 waittill("physics_finished");

  if(scripts\mp\utility\entity::_id_F38F()) {
    _id_214F(1, 1);
    return;
  }
}

_id_2132() {
  for(;;) {
    var_0 = scripts\engine\utility::_id_10899("pickup_object", "dropped", "reset", "ball_ready");

    switch (var_0) {
      case "pickup_object":
        break;
      case "dropped":
        break;
      case "reset":
        break;
      case "ball_ready":
        break;
      default:
        break;
    }
  }
}

_id_2114(var_0) {
  self endon("death_or_disconnect");
  var_0 endon("reset");
  var_1 = spawnStruct();
  var_1 endon("timer_done");
  var_1 thread _id_F250(1.5);
  var_0 waittill("pickup_object");
  var_1 _id_F249();

  if(!isDefined(var_0._id_32D5) || var_0._id_32D5.team == self.team) {
    return;
  }
  var_0._id_32D5 endon("disconnect");
  var_1 thread _id_F250(5);
  var_0._id_32D5 waittill("death", var_2);
  var_1 _id_F249();

  if(!isDefined(var_2) || var_2 != self) {
    return;
  }
  var_1 thread _id_F250(2);
  var_0 waittill("pickup_object");
  var_1 _id_F249();

  if(isDefined(var_0._id_32D5) && var_0._id_32D5 == self) {
    thread _id_0A9F::_id_7003("ball_pass_kill");
  }
}

_id_F250(var_0) {
  self endon("cancel_timer");
  wait(var_0);
  self notify("timer_done");
}

_id_F249() {
  self notify("cancel_timer");
}

_id_218D() {
  _id_07D6::_id_D61B("waypoint_neutral_ball", "waypoint_neutral_ball");
}

_id_218C(var_0) {
  if(scripts\mp\utility\game::getgametype() == "ball") {
    var_1 = "waypoint_escort";
  } else {
    var_1 = "waypoint_defend_round";
  }

  _id_07D6::_id_D61B(var_1, "waypoint_capture_kill_round");
}

_id_218B() {
  if(scripts\mp\utility\game::getgametype() == "ball") {
    var_0 = "waypoint_ball_download";
  } else {
    var_0 = "waypoint_reset_marker";
  }

  _id_07D6::_id_D61B(var_0, var_0);
}

_id_218F() {
  _id_07D6::_id_D61B("waypoint_ball_upload", "waypoint_ball_upload");
}

_id_214E() {
  self._id_10430[0] solid();
}

_id_211B() {
  self._id_10430[0] dontinterpolate();
  self._id_2120 = 0;
}

_id_210C(var_0) {
  foreach(var_2 in self._id_10430) {
    var_2._id_2323 = var_0.origin;
  }

  self.trigger._id_2323 = var_0.origin;
  self._id_419D = var_0;
  var_0._id_7D7E = 1;
}

_id_2118() {
  if(isDefined(self.killcament)) {
    self.killcament delete();
  }

  self.killcament = spawn("script_model", self._id_10430[0].origin);
  self.killcament linkto(self._id_10430[0]);
  self.killcament notsolid();
  self.killcament _meth_8375("explosive");
}

_id_8145() {
  level._id_21B3 = level._id_BA11;
  level._id_21B4 = 1;
  level._id_21B5 = 0;

  if(isDefined(level._id_BA10) && level._id_BA10 != 0) {
    thread _id_3FF5();
  } else {}
}

_id_3FF5() {
  level endon("game_ended");
  _id_07D1::_id_60C2("prematch_done");
  _id_FD66("neutral", 1, 1);
}

_id_FD66(var_0, var_1, var_2, var_3) {
  if(!istrue(level._id_BA10)) {
    return;
  }
  var_4 = undefined;
  var_5 = 1000 * level._id_BA11;

  if(istrue(var_2)) {
    if(istrue(level._id_2191) && !istrue(level._id_21B0)) {
      var_5 = 1000 * level._id_2191;
    }
  }

  if(istrue(var_2) || istrue(var_3)) {
    level._id_21B3 = level._id_BA11;
    level._id_2196 = int(gettime() + var_5);
  } else
    level._id_2196 = int(gettime() + 1000 * level._id_21B3);

  setomnvar("ui_hardpoint_timer", level._id_2196);

  if(var_5 > 0 && (istrue(var_3) || !var_1 && level._id_21B4)) {
    level._id_210A thread _id_21B1(var_0, var_4);
  }

  if(var_1) {
    level _id_AF67();
  }
}

_id_21B1(var_0, var_1) {
  level endon("game_ended");
  level endon("reset");
  level endon("pause_ball_timer");
  level notify("ballRunTimer");
  level endon("ballRunTimer");
  level._id_21B4 = 0;
  _id_21B6(var_0, var_1);

  if(!istrue(level._id_21B0)) {
    _id_07D6::_id_159C("none");
    _id_2152(1, self.trigger.origin, 1);
    _id_214F(1, 1);
  }
}

_id_21B6(var_0, var_1) {
  level endon("game_ended");
  level endon("pause_ball_timer");
  var_2 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, int(level._id_21B3 * 1000 + gettime()));
  level _id_C72D(var_1);
  thread _id_10C19();
  level thread _id_7458(var_2);
  _id_107E2(level._id_21B3);
}

_id_107E2(var_0) {
  level endon("game_ended");
  level endon("pause_ball_timer");

  if(var_0 == 0) {
    return;
  }
  var_1 = gettime();
  var_2 = gettime() + var_0 * 1000;

  while(gettime() < var_2) {
    _id_10949((var_2 - gettime()) / 1000);

    while(isDefined(level._id_7AAE)) {
      var_2 = var_2 + 1000;
      setgameendtime(int(var_2));
      wait 1;
    }
  }

  while(isDefined(level._id_7AAE)) {
    var_2 = var_2 + 1000;
    setgameendtime(int(var_2));
    wait 1;
  }

  return gettime() - var_1;
}

_id_10949(var_0) {
  level endon("game_ended");
  level endon("pause_ball_timer");

  if(isDefined(level._id_7AAE)) {
    return;
  }
  level endon("host_migration_begin");
  wait(var_0);
}

_id_7458(var_0) {
  level endon("game_ended");
  level endon("disconnect");
  level waittill("host_migration_begin");
  setomnvar("ui_objective_timer_stopped", 1);
  var_1 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(!level._id_21B5) {
    setomnvar("ui_objective_timer_stopped", 0);
  }

  if(var_1 > 0) {
    setomnvar("ui_hardpoint_timer", level._id_2196 + var_1);
  } else {
    setomnvar("ui_hardpoint_timer", level._id_2196);
  }
}

_id_10C19() {
  level endon("game_ended");
  level notify("watchResetSoon");
  level endon("watchResetSoon");
  var_0 = 0;

  for(var_1 = undefined; level._id_21B3 > 0 && !level._id_21B4; level._id_21B3 = level._id_21B3 - var_6) {
    var_2 = gettime();

    if(!var_0 && level._id_21B3 < 10) {
      foreach(var_4 in level._id_EF89) {
        level _id_0A8D::_id_E775("drone_reset_soon", var_4);
      }

      var_0 = 1;
    }

    if(isDefined(level._id_21B2[0]._id_32D5) && level._id_21B3 < 5) {
      if(!isDefined(var_1) || var_2 > var_1 + 1000) {
        var_1 = var_2;
      }
    }

    var_6 = 0.05;
    wait(var_6);
  }

  if(level._id_21B4) {
    level notify("pause_ball_timer");
  }
}

_id_FC10(var_0) {
  var_1 = level._id_21B4 || isDefined(level._id_7AAE);

  if(!_id_07D1::_id_60BE("prematch_done")) {
    var_1 = 0;
  }

  if(!level._id_21B5 && var_1) {
    level._id_21B5 = 1;
    setomnvar("ui_objective_timer_stopped", 1);
  } else if(level._id_21B5 && !var_1) {
    level._id_21B5 = 0;
    setomnvar("ui_objective_timer_stopped", 0);
  }
}

_id_AF67() {
  level._id_21B4 = 1;
  _id_FC10();
}

_id_C72D(var_0) {
  level._id_21B4 = 0;
  _id_FC10(var_0);
}

_id_214D() {
  if(!istrue(level._id_48DF)) {
    foreach(var_1 in level._id_21B2) {
      var_1 _id_2122(self);
    }
  }
}

_id_2122(var_0) {
  if(_id_2120()) {
    self._id_10430[0] setscriptablepartstate("uplink_drone_idle", "normal", 0);
    self._id_10430[0] setscriptablepartstate("uplink_drone_tail", "normal", 0);
  }
}

_id_2121(var_0, var_1) {
  self endon("reset");
  self endon("pickup_object");

  if(istrue(var_0)) {
    wait 0.2;
  } else {
    waitframe();
  }

  if(!_id_2120()) {
    self._id_10430[0] setscriptablepartstate("uplink_drone_idle", "normal", 0);
    self._id_10430[0] setscriptablepartstate("uplink_drone_tail", "normal", 0);
    self._id_2120 = 1;
  }
}

_id_2120() {
  return isDefined(self._id_2120) && self._id_2120;
}

_id_2123() {
  if(_id_2120()) {
    self._id_10430[0] _id_E89D();
  }

  self._id_2120 = 0;
}

_id_E89D() {
  self setscriptablepartstate("uplink_drone_idle", "off", 0);
  self setscriptablepartstate("uplink_drone_tail", "off", 0);
}

_id_211C(var_0, var_1) {
  scripts\engine\utility::_id_108F5("pickup_object", var_1);
  level._id_CC05 = 0;
  level notify("goal_ready");
}

_id_A224() {
  level notify("practice");
  level endon("practice");
  level endon("game_ended");
  wait 5;

  for(;;) {
    self waittill("call_ball");

    if(!isDefined(level._id_21B2[0]._id_32D5)) {
      level._id_21B2[0]._id_10430[0] physicslaunchserver(level._id_21B2[0]._id_10430[0].origin, (0, 0, 0));
      level._id_21B2[0]._id_10430[0] _meth_8545();

      while(!isDefined(level._id_21B2[0]._id_32D5)) {
        var_0 = 40;

        switch (self getstance()) {
          case "crouch":
            var_0 = 30;
            break;
          case "prone":
            var_0 = 15;
            break;
        }

        level._id_21B2[0]._id_10430[0] moveto(self.origin + (0, 0, var_0), 0.3, 0.15, 0.1);
        wait 0.1;
      }
    }

    wait 1;
  }
}

_id_BB2D() {
  level endon("game_ended");
  self endon("disconnect");
  var_0 = 1;

  for(;;) {
    if(var_0) {
      self waittill("giveLoadout");
    } else {
      self waittill("spawned");
    }

    var_0 = 0;

    if(var_0) {
      wait 20;
    } else {
      wait 2;
    }

    thread _id_6FD4();
  }
}

_id_6FD4() {
  self notify("practiceMessage");
  self endon("practiceMessage");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(scripts\engine\utility::is_player_gamepad_enabled()) {
    self notifyonplayercommand("call_ball", "+actionslot 3");
    self iprintlnbold(&"PLATFORM/UPLINK_PRACTICE_SLOT3");
  } else {
    self notifyonplayercommand("call_ball", "+actionslot 7");
    self iprintlnbold(&"PLATFORM/UPLINK_PRACTICE_SLOT7");
  }

  level._id_21B2[0] waittill("score_event");
  wait 5;
  thread _id_6FD4();
}

_id_E02B(var_0) {
  if(!isDefined(var_0) || var_0.size == 0) {
    return undefined;
  }

  var_1 = 1;

  for(var_2 = var_0.size; var_1; var_2--) {
    var_1 = 0;

    for(var_3 = 0; var_3 < var_2 - 1; var_3++) {
      if(_id_3AF8(var_0[var_3], var_0[var_3 + 1])) {
        var_4 = var_0[var_3];
        var_0[var_3] = var_0[var_3 + 1];
        var_0[var_3 + 1] = var_4;
        var_1 = 1;
      }
    }
  }

  return var_0;
}

_id_3AF8(var_0, var_1) {
  var_2 = int(var_0._id_CD99);
  var_3 = int(var_1._id_CD99);

  if(!isDefined(var_2) && !isDefined(var_3)) {
    return 0;
  }

  if(!isDefined(var_2) && isDefined(var_3)) {
    return 1;
  }

  if(isDefined(var_2) && !isDefined(var_3)) {
    return 0;
  }

  if(var_2 > var_3) {
    return 1;
  }

  return 0;
}

_id_6C12() {
  var_0 = 0;

  switch (self getstance()) {
    case "crouch":
      var_0 = 5;
      break;
    case "prone":
      var_0 = 10;
      break;
  }

  var_1 = self _meth_8541();
  var_2 = anglestoup(var_1);
  var_3 = self getEye() + var_2 * var_0;
  return var_3;
}

_id_6C11() {
  var_0 = self getplayerangles();
  var_1 = anglesToForward(var_0);
  return var_1;
}

_id_6DC2() {
  var_0 = 10;

  switch (self getstance()) {
    case "crouch":
      var_0 = 15;
      break;
    case "prone":
      var_0 = 5;
      break;
  }

  var_1 = self _meth_8541();
  var_2 = anglestoup(var_1);
  var_3 = self gettagorigin("j_spinelower", 1, 1);
  var_4 = var_3 + var_2 * var_0;
  return var_4;
}

_id_6DC1() {
  var_0 = _id_6DC2();
  return (0, 0, var_0[2] - self.origin[2]);
}