/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\war.gsc
*************************************************/

main() {
  if(getDvar("#x376847958d67972ef") == "mp_background") {
    return;
  }
  _id_07DC::init();
  _id_07DC::_id_D854();
  var_0[0] = ::scripts\mp\utility\game::getgametype();
  _id_07D6::main(var_0);

  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2AA(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 75);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
  }

  _id_FC7D();
  level.teambased = 1;
  level._id_ABAD = ::_id_ABAD;
  level._id_6D4A = ::_id_6D4A;
  level._id_AB3F = ::_id_AB3F;
  level._id_9FE8 = ::_id_ABA4;

  if(getdvarint("#x3863de265c7325250", 0) != 0) {
    level._id_AB70 = ::_id_AB03;
  }

  game["dialog"]["gametype"] = "mp_glob_tmdm_bchr_in01";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "mp_glob_tmdm_bchr_in02";
  }

  game["dialog"]["boost"] = "mp_glob_gene_bchr_z254";
  game["dialog"]["offense_obj"] = "mp_glob_gene_bchr_z254";
  game["dialog"]["defense_obj"] = "mp_glob_gene_bchr_z254";
  game["dialog"]["mission_success"] = "mp_glob_tmdm_bchr_tdmw";
  game["dialog"]["mission_failure"] = "mp_glob_tmdm_bchr_tdml";
  level._id_F0E4 = getdvarint("#x3596b515a9c3f3361", 0);
  level._id_EF37 = getdvarfloat("#x36a596b1c1bcf8e1b", 1000);
  level._id_EF38 = getdvarfloat("#x34f014b3c223afd46", 2048);
  level._id_EF36 = getdvarfloat("#x3f6617402ac195a50", 4092);

  if(istrue(level._id_F0E4)) {
    _id_0797::_id_8251();
  }

  if(scripts\mp\utility\game::matchmakinggame()) {
    level._id_DB63 = ::_id_DB63;
  }
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3d6ccba87107eb70a", 0);
  scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
  setdynamicdvar("#x33f7f987edc36b03a", 0);
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
    scripts\mp\utility\game::_id_D61C(var_3, &"OBJECTIVES/WAR");

    if(level.splitscreen) {
      scripts\mp\utility\game::_id_D61A(var_3, &"OBJECTIVES/WAR");
    } else {
      scripts\mp\utility\game::_id_D61A(var_3, &"OBJECTIVES/WAR_SCORE");
    }

    scripts\mp\utility\game::_id_D615(var_3, &"OBJECTIVES/WAR_HINT");
  }

  if(isDefined(level._id_8295)) {
    [[level._id_8295]]();
  } else {
    _id_8294();
  }

  scripts\mp\gametypes\bradley_spawner::_id_82A8();

  if(getdvarint("#x3863de265c7325250", 0) != 0) {
    thread _id_A117();
  }
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
}

_id_8294() {
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);

  if(isDefined(scripts\cp_mp\utility\game_utility::_id_6B18())) {
    _id_0817::_id_D461("BigTDM", "Crit_Frontline");
  } else {
    _id_0817::_id_D461("Default", "Crit_Frontline");
  }

  _id_0817::_id_113A("mp_tdm_spawn_allies_start");
  _id_0817::_id_113A("mp_tdm_spawn_axis_start");
  _id_0817::_id_1136(game["attackers"], "mp_tdm_spawn_allies_start");
  _id_0817::_id_1136(game["defenders"], "mp_tdm_spawn_axis_start");
  var_0 = _id_0817::_id_6D4E("mp_tdm_spawn_allies_start");
  var_1 = _id_0817::_id_6D4E("mp_tdm_spawn_axis_start");
  _id_0817::_id_C2B9("start_attackers", var_0);
  _id_0817::_id_C2B9("start_defenders", var_1);
  _id_0817::_id_1136("allies", "mp_tdm_spawn");
  _id_0817::_id_1136("axis", "mp_tdm_spawn");
  _id_0817::_id_1136("allies", "mp_tdm_spawn_secondary", 1, 1);
  _id_0817::_id_1136("axis", "mp_tdm_spawn_secondary", 1, 1);
  var_2 = _id_0817::_id_6D4E("mp_tdm_spawn");
  var_3 = _id_0817::_id_6D4E("mp_tdm_spawn_secondary");
  _id_0817::_id_C2B9("normal", var_2);
  _id_0817::_id_C2B9("fallback", var_3);

  if(istrue(level._id_F0E4)) {
    var_4 = getdvarfloat("#x3ab5edb4c02a50335", randomfloatrange(-4096, 4096));
    var_5 = getdvarfloat("#x3ab5eda4c02a50102", randomfloatrange(-4096, 4096));
    var_6 = getdvarfloat("#x3ab5ed94c02a4fecf", randomfloatrange(0, 512));
    level._id_9AAC = (var_4, var_5, var_6);
    _id_EF35();
  } else {
    level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
    setmapcenter(level._id_9AAC);
  }

  _id_0817::_id_0EE5();
}

_id_6D4A() {
  var_0 = self.pers["team"];
  var_1 = undefined;

  if(istrue(level._id_F0E4)) {
    var_2 = level._id_EF39._id_1783 * randomfloatrange(level._id_EF38 * -1.0, level._id_EF38);
    var_3 = undefined;

    if(var_0 == "axis") {
      var_3 = level._id_EF39._id_1773 * level._id_EF36 * -1.0;
    } else {
      var_3 = level._id_EF39._id_1773 * level._id_EF36;
    }

    var_1 = spawnStruct();
    var_1.origin = level._id_9AAC + var_2 + var_3 + (0, 0, level._id_EF37);
    var_1.angles = (0, 0, 0);
    var_1.index = 1;
  } else if(_id_0817::_id_DC06()) {
    if(var_0 == game["attackers"]) {
      var_1 = _id_0817::_id_6D4A(self, var_0, "start_attackers", undefined);
    } else {
      var_1 = _id_0817::_id_6D4A(self, var_0, "start_defenders", undefined);
    }
  } else {
    var_4 = 0;
    var_5 = getdvarint("#x377d48b16c892f6ce", 2);

    if(getdvarint("#x3cadcf09684449174", 0) > 0) {
      var_6 = 0;

      switch (scripts\cp_mp\utility\game_utility::_id_6B2D()) {
        case "mp_shipment_s4":
        case "mp_dome2":
        case "mp_whitehouse_2":
          var_6 = 0;
          break;
        default:
          var_6 = 1;
          break;
      }

      if(var_6) {
        var_7 = _func_00DB(var_0);
        var_8 = scripts\mp\utility\game::_id_6BE2(var_0)[0];
        var_9 = _func_00DB(var_8);
        var_10 = getdvarint("#x359b93584175c2191", 20);
        var_11 = getdvarfloat("#x38dac4a0e2cc0dbf7", 0.75);

        if(var_9 > var_7 && var_9 >= var_10 && var_7 / var_9 < var_11) {
          var_4 = 1;
          setDvar("#x377d48b16c892f6ce", getdvarint("#x32505d2d44bde070e", 4));
        }
      }
    }

    var_1 = _id_0817::_id_6D4A(self, var_0, "normal", "fallback");

    if(var_4) {
      setDvar("#x377d48b16c892f6ce", var_5);
    }
  }

  return var_1;
}

_id_ABA4() {
  self setclientomnvar("ui_match_status_hint_text", 0);

  if(getdvarint("#x3e138924b10a94dfa") != 0) {
    thread scripts\mp\teams::_id_ACDA();
  }

  if(!istrue(level._id_F0E4)) {
    return;
  }
  self setplayerangles(vectortoangles(level._id_9AAC - self.origin));
}

_id_AB3F(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\mp\gametypes\common::_id_AA89(var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_ABC0() {
  var_0 = scripts\mp\gamescore::_id_6AA0();

  if(game["status"] == "overtime") {
    var_0 = "forfeit";
  } else if("tie") {
    var_0 = "overtime";
  }

  thread scripts\mp\gamelogic::_id_52F7(var_0, game["end_reason"]["time_limit_reached"]);
}

_id_EF35() {
  thread scripts\mp\utility\debug::_id_4F48(level._id_9AAC, 128, 100, (0, 1, 0));

  if(!isDefined(level._id_EF39)) {
    waitframe();
  }

  var_0 = level._id_EF39._id_1773 * level._id_EF36;
  var_1 = level._id_EF39._id_1783 * level._id_EF38;
  thread scripts\mp\utility\debug::_id_4F43(level._id_9AAC, level._id_9AAC + var_0, 1000, (1, 0, 0));
  thread scripts\mp\utility\debug::_id_4F43(level._id_9AAC, level._id_9AAC - var_0, 1000, (1, 0, 0));
  thread scripts\mp\utility\debug::_id_4F43(level._id_9AAC + var_0, level._id_9AAC + var_0 + var_1, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::_id_4F43(level._id_9AAC + var_0, level._id_9AAC + var_0 - var_1, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::_id_4F43(level._id_9AAC - var_0, level._id_9AAC - var_0 + var_1, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::_id_4F43(level._id_9AAC - var_0, level._id_9AAC - var_0 - var_1, 1000, (0, 0, 1));
}

_id_A117() {
  level endon("game_ended");
  level._id_ACCD = [];
  level._id_7AB6 = 0;
  var_0 = 0;
  _id_07D1::_id_60C2("prematch_done");

  for(;;) {
    foreach(var_2 in level.players) {
      if(!isDefined(var_2._id_7AB8)) {
        var_2._id_7AB7 = 0;
        var_2._id_7AB8 = var_2.origin;
        var_2._id_0E13 = var_2.origin;
      }

      var_2._id_7AB7 = var_2._id_7AB7 + distancesquared(var_2._id_7AB8, var_2.origin);
      var_2._id_7AB8 = var_2.origin;
    }

    var_0 = var_0 + level._id_5F3A;

    if(var_0 > 3.0) {
      if(level._id_7AB6 >= 2) {
        level._id_7AB6 = 0;

        foreach(var_2 in level.players) {
          if(!isDefined(var_2._id_0E13)) {
            var_2._id_0E13 = var_2.origin;
          }

          var_2._id_5E74 = distancesquared(var_2._id_0E13, var_2.origin) < 4225;
          var_2._id_0E13 = var_2.origin;
        }
      }

      foreach(var_2 in level.players) {
        var_7 = var_2 getentitynumber();
        var_8 = var_2.pers["team"];

        if(var_8 == "allies") {
          var_9 = "axis";
        } else {
          var_9 = "allies";
        }

        if(isalive(var_2) && (istrue(var_2._id_5E74) || var_2._id_7AB7 < 4225 && !istrue(var_2._id_7AB9))) {
          var_2._id_5E74 = 0;

          if(!isDefined(level._id_ACCD[var_7])) {
            level._id_ACCD[var_7] = var_2;
            var_2._id_ACE8 = scripts\mp\utility\outline::_id_ACD2(var_2, var_8, "outline_nodepth_orange", "level_script");
            var_2._id_ACE7 = scripts\mp\utility\outline::_id_ACD2(var_2, var_9, "outline_nodepth_red", "level_script");
            var_2 scripts\mp\utility\outline::_id_0C2E("outlinefill_nodepth_orange", 0);
          }
        } else {
          if(isalive(var_2)) {
            var_2._id_7AB9 = 0;
          }

          var_2._id_5E74 = 0;

          if(isDefined(level._id_ACCD[var_7])) {
            scripts\mp\utility\outline::outlinedisable(var_2._id_ACE8, var_2);
            scripts\mp\utility\outline::outlinedisable(var_2._id_ACE7, var_2);
            var_2 scripts\mp\utility\outline::_id_0C2D();
            var_2._id_ACE8 = undefined;
            var_2._id_ACE7 = undefined;
            level._id_ACCD[var_7] = undefined;
          }
        }

        var_2._id_7AB7 = 0;
      }

      var_0 = 0;
    }

    level._id_7AB6++;
    waitframe();
  }
}

_id_AB03(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = self getentitynumber();

  if(isDefined(level._id_ACCD[var_10])) {
    scripts\mp\utility\outline::outlinedisable(self._id_ACE8, self);
    scripts\mp\utility\outline::outlinedisable(self._id_ACE7, self);
    self._id_ACE8 = undefined;
    self._id_ACE7 = undefined;
    level._id_ACCD[var_10] = undefined;
  }

  self._id_7AB9 = 1;
}

_id_DB63() {
  var_0 = int(game["teamScores"]["axis"]);
  var_1 = int(game["teamScores"]["allies"]);
  var_2 = var_0 - var_1;
  return var_2 < 10;
}