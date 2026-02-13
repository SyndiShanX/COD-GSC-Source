/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\tdef.gsc
*************************************************/

main() {
  if(getDvar("#x376847958d67972ef") == "mp_background") {
    return;
  }
  _id_07DC::init();
  _id_07DC::_id_D854();

  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2AA(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 10);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 7500);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
    setdynamicdvar("#x349de528e0287e8c1", 1);
    setdynamicdvar("#x3200fc09aa3c64445", 60);
    level._id_9BED = 1;
    level._id_9BEB = 0;
    level._id_9BF0 = 0;
  }

  level._id_32D6 = 100;
  level._id_CB2A = 1;
  _id_FC7D();
  level.teambased = 1;
  level._id_ABAD = ::_id_ABAD;
  level.onplayerconnect = ::onplayerconnect;
  level._id_6D4A = ::_id_6D4A;
  level._id_AB70 = ::_id_AB70;
  level._id_AB8C = ::_id_6CEF;
  level._id_21B0 = 1;
  level._id_2156 = [];
  level._id_21B2 = [];
  level._id_2193 = [];
  level._id_CC05 = 0;
  level._id_21AF = 0;

  if(level._id_9BEB || level._id_9BF0) {
    level._id_A00B = _id_07C3::_id_60D1;
  }

  game["dialog"]["gametype"] = "team_defender";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["strings"]["overtime_hint"] = &"MP/FIRST_BLOOD";
  game["dialog"]["drone_reset"] = "defender_obj_respawned";
  game["dialog"]["ally_own_drone"] = "tdef_ally_own_drone";
  game["dialog"]["enemy_own_drone"] = "tdef_enemy_own_drone";
  game["dialog"]["ally_throw_score"] = "ally_throw_score";
  game["dialog"]["ally_carry_score"] = "ally_carry_score";
  game["dialog"]["enemy_throw_score"] = "enemy_throw_score";
  game["dialog"]["enemy_carry_score"] = "enemy_carry_score";
  game["dialog"]["pass_complete"] = "friendly_pass";
  game["dialog"]["pass_intercepted"] = "tdef_pass_intercepted";
  game["dialog"]["ally_drop_drone"] = "tdef_ally_drop_drone";
  game["dialog"]["enemy_drop_drone"] = "tdef_enemy_drop_drone";
  game["dialog"]["drone_reset_soon"] = "team_defender_reset";
  game["bomb_dropped_sound"] = "mp_war_objective_lost";
  game["bomb_recovered_sound"] = "mp_war_objective_taken";
  game["dialog"]["offense_obj"] = "capture_obj";
  game["dialog"]["defense_obj"] = "capture_obj";
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3cb2bf57c53698a15", getmatchrulesdata("tdefData", "scoringTime"));
  setdynamicdvar("#x3256fbc036e24b617", getmatchrulesdata("tdefData", "scorePerTick"));
  setdynamicdvar("#x399ccb8f5d486f945", getmatchrulesdata("tdefData", "carrierBonusTime"));
  setdynamicdvar("#x34d460ae0e8f5d30e", getmatchrulesdata("tdefData", "carrierBonusScore"));
  setdynamicdvar("#x31f33e9c09bfd9987", getmatchrulesdata("tdefData", "delayPlayer"));
  setdynamicdvar("#x36d19a21d8d406e3d", getmatchrulesdata("tdefData", "spawnDelay"));
  setdynamicdvar("#x314bff575972c5a45", getmatchrulesdata("tdefData", "ballActivationDelay"));
  setdynamicdvar("#x349de528e0287e8c1", getmatchrulesdata("ballCommonData", "possessionResetCondition"));
  setdynamicdvar("#x3200fc09aa3c64445", getmatchrulesdata("ballCommonData", "possessionResetTime"));
  setdynamicdvar("#x33c61955b9da03c6", getmatchrulesdata("ballCommonData", "explodeOnExpire"));
  setdynamicdvar("#x3bfd550b1a86a594a", getmatchrulesdata("ballCommonData", "armorMod"));
  setdynamicdvar("#x3ed99284e6ec565fe", getmatchrulesdata("carryData", "showEnemyCarrier"));
  setdynamicdvar("#x35ed65a4a0a0f62d1", getmatchrulesdata("carryData", "idleResetTime"));
  setdynamicdvar("#x39dafa6b121a6f2a3", 0);
  scripts\mp\utility\game::_id_C25D("tdef", 0);
  setdynamicdvar("#x3ab3a490aa023cb5d", 0);
}

_id_ABAD() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  foreach(var_3 in level._id_EF89) {
    scripts\mp\utility\game::_id_D61C(var_3, &"OBJECTIVES/TDEF");

    if(level.splitscreen) {
      scripts\mp\utility\game::_id_D61A(var_3, &"OBJECTIVES/TDEF");
    } else {
      scripts\mp\utility\game::_id_D61A(var_3, &"OBJECTIVES/TDEF_SCORE");
    }

    scripts\mp\utility\game::_id_D615(var_3, &"OBJECTIVES/TDEF_ATTACKER_HINT");
  }

  _id_3FD1();
  scripts\mp\gametypes\obj_ball::_id_211A();
  scripts\mp\gametypes\obj_ball::_id_2131();
  scripts\mp\gametypes\obj_ball::_id_2117();
  scripts\mp\gametypes\obj_ball::_id_2155(0);
  _id_8294();
  var_5[0] = ::scripts\mp\utility\game::getgametype();
  var_5[1] = "tdm";
  var_5[2] = "ball";
  _id_07D6::main(var_5);
  _id_EF32();

  if(level._id_BA10 != 0) {
    scripts\mp\gametypes\obj_ball::_id_8145();
  }
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_CC26 = scripts\mp\utility\dvars::_id_509A("scoringTime", 1, 1, 10);
  level._id_CC12 = scripts\mp\utility\dvars::_id_509C("scorePerTick", 1, 1, 25);
  level._id_32D8 = scripts\mp\utility\dvars::_id_509A("carrierBonusTime", 4, 0, 10);
  level._id_32D7 = scripts\mp\utility\dvars::_id_509C("carrierBonusScore", 25, 0, 250);
  level._id_46D3 = scripts\mp\utility\dvars::_id_509C("delayPlayer", 1, 0, 1);
  level._id_E295 = scripts\mp\utility\dvars::_id_509A("spawnDelay", 2.5, 0, 30);
  level._id_2191 = scripts\mp\utility\dvars::_id_509A("ballActivationDelay", 10, 0, 30);
  level._id_BA10 = scripts\mp\utility\dvars::_id_509C("possessionResetCondition", 0, 0, 2);
  level._id_BA11 = scripts\mp\utility\dvars::_id_509A("possessionResetTime", 0, 0, 150);
  level._id_57B9 = scripts\mp\utility\dvars::_id_509C("explodeOnExpire", 0, 0, 1);
  level._id_7CD0 = scripts\mp\utility\dvars::_id_509A("idleResetTime", 15, 0, 60);
  level._id_1B59 = scripts\mp\utility\dvars::_id_509A("armorMod", 1, 0, 2);
  level._id_DCA0 = scripts\mp\utility\dvars::_id_509C("showEnemyCarrier", 5, 0, 6);
  level._id_32D6 = int(level._id_32D6 * level._id_1B59);
}

_id_8294() {
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  _id_0817::_id_D461("TDef", "Crit_Frontline");
  _id_0817::_id_113A("mp_ball_spawn_allies_start");
  _id_0817::_id_113A("mp_ball_spawn_axis_start");
  _id_0817::_id_1136("allies", "mp_tdm_spawn");
  _id_0817::_id_1136("allies", "mp_tdm_spawn_secondary", 1, 1);
  _id_0817::_id_1136("axis", "mp_tdm_spawn");
  _id_0817::_id_1136("axis", "mp_tdm_spawn_secondary", 1, 1);
  _id_0817::_id_C2B9("normal", "mp_tdm_spawn");
  _id_0817::_id_C2B9("fallback", "mp_tdm_spawn_secondary");
  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);

  foreach(var_1 in level._id_E34D) {
    _id_2EFB(var_1);
  }

  _id_0817::_id_0EE5();
}

_id_2EFB(var_0) {
  var_0._id_4BB8 = undefined;
  var_1 = _func_00C4(var_0.origin, level._id_2156[0]._id_71A7, 1000);

  if(var_1 < 0) {
    var_1 = scripts\engine\utility::_id_4B8C(var_0.origin, level._id_2156[0]._id_71A7);
  } else {
    var_1 = var_1 * var_1;
  }

  var_0._id_4BB8 = var_1;
}

_id_6D4A() {
  var_0 = self.pers["team"];

  if(game["switchedsides"]) {
    var_0 = scripts\mp\utility\game::_id_6BE2(var_0)[0];
  }

  if(_id_0817::_id_DC06()) {
    var_1 = _id_0817::_id_6D4E("mp_ball_spawn_" + var_0 + "_start");
    var_2 = _id_0817::_id_6D4D(var_1);
  } else {
    var_3 = [];
    var_3["ballPosition"] = level._id_21B2[0]._id_10430[0].origin;

    if(isDefined(level._id_21B2[0]._id_32D5)) {
      var_3["activeCarrierPosition"] = level._id_21B2[0]._id_32D5.origin;
    } else {
      var_3["activeCarrierPosition"] = var_3["ballPosition"];
    }

    var_3["avoidBallDeadZoneDistSq"] = 1000000;
    var_2 = _id_0817::_id_6D4A(self, var_0, "normal", "fallback", undefined, var_3);
  }

  return var_2;
}

_id_3FD1() {}

_id_EF32() {
  level._id_7C57 = "waypoint_blitz_defend_round";
  level._id_7C56 = "waypoint_blitz_defend_round";
  level._id_7C6C = "waypoint_capture_kill_round";
  level._id_7C6B = "waypoint_capture_kill_round";
  level._id_7C47 = "waypoint_capture_take";
  level._id_7C46 = "waypoint_capture_take";
  level._id_210A = level._id_21B2[0];
}

_id_AB70(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = self;
  var_11 = var_1.origin;
  var_12 = 0;

  if(isDefined(var_0)) {
    var_11 = var_0.origin;
    var_12 = var_0 == var_1;
  }

  if(isDefined(self._id_32EC) && isDefined(self._id_32EC._id_AEB4) && isDefined(self._id_32EC._id_AEB3)) {
    scripts\mp\utility\outline::outlinedisable(self._id_32EC._id_AEB4, self._id_32EC._id_AEB3);
    self._id_32EC._id_AEB4 = undefined;
    self._id_32EC._id_AEB3 = undefined;
  }

  if(isDefined(self._id_32EC) && isDefined(self._id_32EC._id_B730) && isDefined(self._id_32EC._id_B72F)) {
    scripts\mp\utility\outline::outlinedisable(self._id_32EC._id_B730, self._id_32EC._id_B72F);
    self._id_32EC._id_B730 = undefined;
    self._id_32EC._id_B72F = undefined;
  }

  if(isDefined(level._id_210A._id_32D5)) {
    if(isDefined(var_1) && isPlayer(var_1) && var_1.pers["team"] != var_10.pers["team"]) {
      if(isDefined(var_1._id_2110) && var_12) {} else if(isDefined(var_10._id_2110))
        scripts\mp\gametypes\obj_ball::_id_FD66("neutral", 1, 0);

      if(var_1.pers["team"] == level._id_210A._id_ADAE && var_1 != level._id_210A._id_32D5) {
        var_13 = distancesquared(level._id_210A._id_32D5.origin, var_11);

        if(var_13 < 90000) {
          var_1 thread _id_07B1::_id_6FB9("mode_x_defend");
          var_1 scripts\mp\utility\stats::_id_7DAE("defends", 1);
          var_1 scripts\mp\persistence::_id_E770("round", "defends", var_1.pers["defends"]);
          var_1 scripts\mp\utility\stats::_id_D551(var_1.pers["defends"]);
        }
      }
    }
  }
}

_id_1FC4(var_0) {
  level endon("game_ended");
  level._id_210A endon("dropped");
  level._id_210A endon("reset");
  level notify("awardCapturePointsRunning");
  level endon("awardCapturePointsRunning");

  if(level._id_32D7 > 0) {
    level._id_210A._id_32D5 thread _id_32DA();
  }

  var_1 = level._id_CC26;
  var_2 = level._id_CC12;

  while(!level.gameended) {
    wait(var_1);
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(!level.gameended) {
      scripts\mp\gamescore::_id_7001(var_0, var_2, 0);
      level._id_210A._id_32D5 scripts\mp\utility\stats::_id_7DAE("objTime", 1);
      level._id_210A._id_32D5 scripts\mp\persistence::_id_E770("round", "objTime", level._id_210A._id_32D5.pers["objTime"]);
      level._id_210A._id_32D5 scripts\mp\utility\stats::_id_D550(level._id_210A._id_32D5.pers["objTime"]);
      level._id_210A._id_32D5 scripts\mp\gamescore::_id_6FCF("tdef_hold_obj", 10);
    }
  }
}

_id_32DA() {
  level endon("game_ended");
  self endon("death");
  level._id_210A endon("dropped");
  level._id_210A endon("reset");

  for(;;) {
    wait(level._id_32D8);
    thread _id_0A9F::_id_7003("ball_carry", undefined, level._id_32D7);
  }
}

_id_10B0D() {
  self endon("dropped_flag");
  self endon("disconnect");
  level waittill("game_ended");

  if(isDefined(self)) {
    if(isDefined(self._id_EF33)) {
      var_0 = int(gettime() - self._id_EF33);

      if(var_0 / 100 / 60 < 1) {
        var_1 = 0;
      } else {
        var_1 = int(var_0 / 100 / 60);
      }

      scripts\mp\utility\stats::_id_7DAE("destructions", var_1);
      scripts\mp\persistence::_id_E770("round", "destructions", self.pers["destructions"]);
    }
  }
}

_id_6CEF() {
  var_0 = level._id_210A _id_07D6::_id_6C02();

  if(isDefined(var_0)) {
    if(self.pers["team"] == var_0) {
      if(!level._id_E295) {
        return undefined;
      }

      if(level._id_46D3) {
        return level._id_E295;
      }
    }
  }
}

onplayerconnect(var_0) {
  var_0._id_0B62 = [];
  thread onplayerspawned(var_0);
}

onplayerspawned(var_0) {
  for(;;) {
    var_0 waittill("spawned");
    level._id_2193[0] scripts\mp\gametypes\obj_ball::_id_DC88(var_0);
    var_0 scripts\mp\utility\stats::_id_D550(0);

    if(isDefined(var_0.pers["objTime"])) {
      var_0 scripts\mp\utility\stats::_id_D550(var_0.pers["objTime"]);
    }

    var_0 scripts\mp\utility\stats::_id_D551(0);

    if(isDefined(var_0.pers["defends"])) {
      var_0 scripts\mp\utility\stats::_id_D551(var_0.pers["defends"]);
    }
  }
}

_id_6D23() {
  if(istrue(self._id_EF34)) {
    if(scripts\mp\utility\perk::_hasperk("specialty_afterburner")) {
      self _meth_8486(0, scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 600, 2000));
      self _meth_8482(0, scripts\engine\utility::ter_op(scripts\mp\utility\game::isanymlgmatch(), 750, 650));
    } else {
      self _meth_8486(0, 400);
      self _meth_8482(0, 900);
    }

    self._id_EF34 = 0;
  } else {
    if(scripts\mp\utility\perk::_hasperk("specialty_afterburner")) {
      self _meth_8486(0, 250);
      self _meth_8482(0, 1350);
    } else {
      self _meth_8486(0, 200);
      self _meth_8482(0, 1800);
    }

    self._id_EF34 = 1;
  }
}