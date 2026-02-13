/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\arena.gsc
*************************************************/

main() {
  game["isLaunchChunk"] = getdvarint("#x3f8401a3edde07938", 0) != 0;

  if(getDvar("#x376847958d67972ef") == "mp_background") {
    return;
  }
  _id_07DC::init();
  _id_07DC::_id_D854();
  var_0[0] = ::scripts\mp\utility\game::getgametype();
  var_0[1] = "dom";
  _id_07D6::main(var_0);

  if(game["isLaunchChunk"]) {
    scripts\mp\gametypes\arena_alt::main();
    return;
  }

  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2AA(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 30);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 75);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 19);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 10);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C2CE(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C2CF(scripts\mp\utility\game::getgametype(), 4);
  }

  _id_FC7D();

  if(_id_89E5()) {
    level._id_89C6 = 1;
    level._id_BC27 = 1;
    level._id_BC28 = 1;
  }

  level.teambased = 1;
  level._id_A8D4 = 1;
  level._id_AD61 = 10;
  level._id_ABC0 = ::_id_ABC0;
  level._id_ABAD = ::_id_ABAD;
  level.onplayerconnect = ::onplayerconnect;
  level._id_6D4A = ::_id_6D4A;
  level._id_AB61 = ::_id_AB61;
  level._id_AB3F = ::_id_AB3F;
  level._id_AB70 = ::_id_AB70;
  level._id_9FE8 = ::_id_ABA4;
  level._id_AAA3 = ::_id_AAA3;
  level._id_ABC3 = ::_id_ABC3;
  level._id_15BE = 0;
  level._id_C4DB = 1;

  if(!scripts\mp\utility\game::_id_8B13()) {
    level._id_DDA9 = 1;
  }

  if(!_id_8950()) {
    level._id_4A87 = 1;
    setomnvar("ui_killcam_copycat", 0);
    level._id_2DF4 = ::_id_1659;
  } else
    level._id_4A87 = undefined;

  if(scripts\cp_mp\utility\game_utility::_id_6B2D() == "mp_m_overwinter") {
    level._id_DFBF = 1;
    level._id_165E = getdvarint("#x3e9a6c67b75dd818", 0);

    if(level._id_165E) {
      level._id_BB2E = 0;
    } else {
      level._id_BB2E = 1;
    }
  }

  if(getdvarint("#x3a98a6f8b66b5a389") == 1) {
    level._id_1AFF = 1;
    level._id_E3C8 = 1;
  } else if(getdvarint("#x3588cbf8b4a6a964c") == 1) {
    level._id_1AC1 = 1;
    level._id_E3C8 = 1;
  }

  game["dialog"]["gametype"] = "gametype_arena";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x36c8f5946a1247e70")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  }

  if(_id_897F() && !isDefined(game["roundsPlayed"])) {
    game["dialog"]["offense_obj"] = "boost_arena_pickups";
    game["dialog"]["defense_obj"] = "boost_arena_pickups";
  } else if(level._id_A90F == 1 && !isDefined(game["roundsPlayed"])) {
    game["dialog"]["offense_obj"] = "boost_arena_objective";
    game["dialog"]["defense_obj"] = "boost_arena_objective";
  } else {
    game["dialog"]["offense_obj"] = "boost_arena";
    game["dialog"]["defense_obj"] = "boost_arena";
  }

  game["dialog"]["obj_indepth"] = "boost_arena_indepth";
  game["dialog"]["securing_a"] = "flag_securing";
  game["dialog"]["losing_a"] = "flag_losing";
  game["dialog"]["secured_a"] = "flag_secured";
  game["dialog"]["lost_a"] = "flag_lost";
  game["dialog"]["round_success"] = "round_win";
  game["dialog"]["round_failure"] = "round_lose";
  game["dialog"]["mission_success"] = "gamestate_win";
  game["dialog"]["mission_failure"] = "gamestate_lost";
  level._id_1511 = 0;
  level._id_1514 = 0;
  level._id_1FE6 = 0;
  level._id_1FE9 = 0;
  level._id_FE59["allies"] = 0;
  level._id_FE5B["allies"] = 0;
  level._id_FE5A["allies"] = 0;
  level._id_FE59["axis"] = 0;
  level._id_FE5B["axis"] = 0;
  level._id_FE5A["axis"] = 0;
  setomnvar("ui_arena_allies_health", 0);
  setomnvar("ui_arena_axis_health", 0);
  setomnvar("ui_arena_allies_health_max", 100);
  setomnvar("ui_arena_axis_health_max", 100);
  setomnvar("ui_arena_vs_intro_player_01", -1);
  setomnvar("ui_arena_vs_intro_player_02", -1);
  setomnvar("ui_arena_vs_intro_player_03", -1);
  setomnvar("ui_arena_vs_intro_player_04", -1);
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x311aae8eeaa331969", getmatchrulesdata("arenaData", "arenaLoadouts"));
  setdynamicdvar("#x34ac85df18773327d", getmatchrulesdata("arenaData", "loadoutChangeRound"));
  setdynamicdvar("#x3c4e331be1d6aa0b5", getmatchrulesdata("arenaData", "switchSpawns"));
  setdynamicdvar("#x3121852cc02c080b2", getmatchrulesdata("arenaData", "winCondition"));
  setdynamicdvar("#x3c40a186272337d3f", getmatchrulesdata("arenaData", "objModifier"));
  setdynamicdvar("#x343b055408bc37842", getmatchrulesdata("arenaData", "spawnFlag"));
  setdynamicdvar("#x327c3009947f8d026", getmatchrulesdata("domData", "flagCaptureTime"));
  setdynamicdvar("#x3b205c61638520afb", getmatchrulesdata("arenaData", "tacticalTimeMod"));
  setdynamicdvar("#x39288bc02b1acfc98", getmatchrulesdata("arenaData", "blastShieldMod"));
  setdynamicdvar("#x3446b40f58b8902fb", getmatchrulesdata("arenaData", "blastShieldClamp"));
  setdynamicdvar("#x3c7c011eaad5b06a7", getmatchrulesdata("arenaData", "startWeapon"));
  setdynamicdvar("#x3b80abb81116e7914", getmatchrulesdata("arenaData", "weaponTier1"));
  setdynamicdvar("#x3b80abe81116e7fad", getmatchrulesdata("arenaData", "weaponTier2"));
  setdynamicdvar("#x3b80abd81116e7d7a", getmatchrulesdata("arenaData", "weaponTier3"));
  setdynamicdvar("#x3b80ab881116e727b", getmatchrulesdata("arenaData", "weaponTier4"));
  setdynamicdvar("#x3b80ab781116e7048", getmatchrulesdata("arenaData", "weaponTier5"));
  setdynamicdvar("#x3b80aba81116e76e1", getmatchrulesdata("arenaData", "weaponTier6"));
  setdynamicdvar("#x3b80ab981116e74ae", getmatchrulesdata("arenaData", "weaponTier7"));
  setdynamicdvar("#x3b80ab481116e69af", getmatchrulesdata("arenaData", "weaponTier8"));
  setdynamicdvar("#x34e66dbb49baf223d", 0);
  scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
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

  _id_8294();
  thread _id_11A8();
  thread _id_10974();
  var_5 = 1;

  if(istrue(level._id_DFBF)) {
    if(!level._id_165E && game["roundsPlayed"] == 0 && istrue(game["practiceRound"])) {
      level._id_5856 = 30;
      game["didSnowFight"] = 1;
      level._id_1AB9 = 3;
      var_5 = 0;
    } else if(level._id_165E) {
      level._id_1AB9 = 3;
      var_5 = 0;
    }

    level._id_DFC2["vanish"] = loadfx("vfx/core/impacts/small_snowhit");
    level._id_DFC2["screen"] = loadfx("vfx/iw8/weap/_impact/snowball/vfx_imp_snowball_scrn.vfx");
    _id_DFBF();
  }

  if(var_5) {
    if(_id_89E3() || _id_89E5() || _id_89DD()) {
      thread _id_FD0A();
    } else if(_id_897F()) {
      level._id_91E0 = 0;
      _id_4636();

      if(!istrue(level._id_DFBF)) {
        _id_82BC();
        thread _id_D8C7();
      }
    } else if(_id_8887()) {
      level._id_25A8 = 1;
      thread _id_FC03(0);
    } else if(_id_8A0E()) {
      level._id_25A8 = 1;
      thread _id_FC03(1);
    }
  }

  if(!_id_8950()) {
    _id_2D03();
  }

  _id_D8C5();
  _id_D5AD();

  if(level._id_A90F == 1) {
    level _id_D868();
  }

  if(level._id_E2EA) {
    var_6 = 0;

    if(!_id_07D1::_id_60BE("prematch_done") && game["roundsPlayed"] == 0) {
      var_6 = 1;
    }

    level thread _id_E2F3(var_6);
  }

  _func_0397(scripts\mp\gamelogic::_id_6DE8(), 0);

  if(!_id_07D1::_id_60BE("prematch_done")) {
    if(game["roundsPlayed"] == 0) {
      level thread _id_ACD4();
      level thread _id_C497();
    }
  }

  if(game["roundsPlayed"] == 0) {
    level thread _id_D6AA();
  }
}

_id_10974() {
  _id_07D1::_id_60C2("prematch_done");
  level._id_AD53 = 1;
  level._id_7EB0 = 5;
}

_id_1659() {
  return "gamemode";
}

_id_11A8() {
  wait 1;
  level._id_C93E = 4.0;
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();

  if(level._id_4CE9) {
    level._id_4CE2 = ::_id_4CE2;
    level._id_4CE6 = ::_id_4CE6;
  }

  if(getdvarint("#x3d45cfb9c2d4a4b8c", 0) == 1) {
    setDvar("#x3ad6828f72533b547", 1);
    var_0 = 128;
    var_1 = getdvarint("#x3143f632acfa7d87f", 0);

    if(var_1 != 0) {
      var_0 = var_1;
    }

    setDvar("#x3665360981d1e5d17", var_0);
  }

  var_2 = 0;

  if(scripts\mp\utility\game::matchmakinggame()) {
    var_3 = getdvarint("#x3f6fe0142a3d126d1", 0);

    if(var_3) {
      var_2 = getdvarint("#x3b9d32db37c31c19f", 0);
    }
  }

  level._id_1AB9 = scripts\mp\utility\dvars::_id_509C("arenaLoadouts", 1, 1, 11);
  level._id_9661 = scripts\mp\utility\dvars::_id_509C("loadoutChangeRound", 3, 0, 5);

  if(var_2 != 0) {
    level._id_1AB9 = var_2;
    level._id_9661 = 3;
  }

  level._id_EC35 = scripts\mp\utility\dvars::_id_509C("switchSpawns", 1, 0, 1);
  level._id_10E23 = scripts\mp\utility\dvars::_id_509C("winCondition", 1, 0, 2);
  setomnvar("ui_arena_loadout_type", level._id_1AB9);
  setomnvar("ui_wincondition", level._id_10E23);
  level._id_A90F = scripts\mp\utility\dvars::_id_509C("objModifier", 0, 0, 1);
  level._id_E2EA = scripts\mp\utility\dvars::_id_509C("spawnFlag", 0, 0, 1);

  if(level._id_E2EA) {
    level._id_ABC2 = 10.0;
    level._id_4203 = 0.0;
    level._id_31B5 = 1;
  }

  level._id_ED2C = scripts\mp\utility\dvars::_id_509A("tacticalTimeMod", 2.5, 0.5, 5);
  level._id_E73D = getDvar("#x3c7c011eaad5b06a7", "none");
  level._id_1B00 = spawnStruct();
  level._id_1B01 = spawnStruct();
  level._id_1B02 = spawnStruct();
  level._id_1B03 = spawnStruct();
  level._id_1B04 = spawnStruct();
  level._id_1B05 = spawnStruct();
  level._id_1B06 = spawnStruct();
  level._id_1B07 = spawnStruct();
  level._id_1B00._id_04F6 = getDvar("#x3b80abb81116e7914", "s4_pi_mike1911");
  level._id_1B01._id_04F6 = getDvar("#x3b80abe81116e7fad", "s4_ar_stango44");
  level._id_1B02._id_04F6 = getDvar("#x3b80abd81116e7d7a", "s4_ar_stango44");
  level._id_1B03._id_04F6 = getDvar("#x3b80ab881116e727b", "s4_ar_stango44");
  level._id_1B04._id_04F6 = getDvar("#x3b80ab781116e7048", "s4_ar_stango44");
  level._id_1B05._id_04F6 = getDvar("#x3b80aba81116e76e1", "equip_frag");
  level._id_1B06._id_04F6 = getDvar("#x3b80ab981116e74ae", "equip_concussion");
  level._id_1B07._id_04F6 = getDvar("#x3b80ab481116e69af", "equip_adrenaline");

  if(_id_897F()) {
    _id_2D09();

    if(!isDefined(game["roundsPlayed"]) || isDefined(game["roundsPlayed"]) && game["roundsPlayed"] == 0) {
      level._id_E73D = _id_6CD3(level._id_E73D);
      level._id_1B00._id_04F6 = _id_6CD3(level._id_1B00._id_04F6);
      level._id_1B01._id_04F6 = _id_6CD3(level._id_1B01._id_04F6);
      level._id_1B02._id_04F6 = _id_6CD3(level._id_1B02._id_04F6);
      level._id_1B03._id_04F6 = _id_6CD3(level._id_1B03._id_04F6);
      level._id_1B04._id_04F6 = _id_6CD3(level._id_1B04._id_04F6);
      level._id_1B05._id_04F6 = _id_6CD3(level._id_1B05._id_04F6);
      level._id_1B06._id_04F6 = _id_6CD3(level._id_1B06._id_04F6);
      level._id_1B07._id_04F6 = _id_6CD3(level._id_1B07._id_04F6);
    } else if(level._id_9661 == 0 || game["roundsPlayed"] % level._id_9661 != 0) {
      level._id_E73D = game["startWeapon"];
      level._id_1B00._id_04F6 = game["arenaWeaponT1"];
      level._id_1B01._id_04F6 = game["arenaWeaponT2"];
      level._id_1B02._id_04F6 = game["arenaWeaponT3"];
      level._id_1B03._id_04F6 = game["arenaWeaponT4"];
      level._id_1B04._id_04F6 = game["arenaWeaponT5"];
      level._id_1B05._id_04F6 = game["arenaWeaponT6"];
      level._id_1B06._id_04F6 = game["arenaWeaponT7"];
      level._id_1B07._id_04F6 = game["arenaWeaponT8"];
    } else if(game["roundsPlayed"] % level._id_9661 == 0) {
      level._id_E73D = _id_6CD3(level._id_E73D);
      level._id_1B00._id_04F6 = _id_6CD3(level._id_1B00._id_04F6);
      level._id_1B01._id_04F6 = _id_6CD3(level._id_1B01._id_04F6);
      level._id_1B02._id_04F6 = _id_6CD3(level._id_1B02._id_04F6);
      level._id_1B03._id_04F6 = _id_6CD3(level._id_1B03._id_04F6);
      level._id_1B04._id_04F6 = _id_6CD3(level._id_1B04._id_04F6);
      level._id_1B05._id_04F6 = _id_6CD3(level._id_1B05._id_04F6);
      level._id_1B06._id_04F6 = _id_6CD3(level._id_1B06._id_04F6);
      level._id_1B07._id_04F6 = _id_6CD3(level._id_1B07._id_04F6);
    }

    game["startWeapon"] = level._id_E73D;
    game["arenaWeaponT1"] = level._id_1B00._id_04F6;
    game["arenaWeaponT2"] = level._id_1B01._id_04F6;
    game["arenaWeaponT3"] = level._id_1B02._id_04F6;
    game["arenaWeaponT4"] = level._id_1B03._id_04F6;
    game["arenaWeaponT5"] = level._id_1B04._id_04F6;
    game["arenaWeaponT6"] = level._id_1B05._id_04F6;
    game["arenaWeaponT7"] = level._id_1B06._id_04F6;
    game["arenaWeaponT8"] = level._id_1B07._id_04F6;
  }
}

_id_6CD3(var_0) {
  if(issubstr(var_0, "rand")) {
    if(var_0 == "random") {
      var_0 = _id_6CCF();
    } else {
      var_0 = _id_6CD4(var_0);
    }
  }

  return var_0;
}

_id_8294() {
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  var_0 = _id_0817::_id_6D4E("mp_arena_spawn_allies_start");
  var_1 = _id_0817::_id_6D4E("mp_arena_spawn_axis_start");
  var_2 = _id_0817::_id_6D4E("mp_arena_spawn");

  if(var_0.size > 0 || var_1.size > 0) {
    _id_0817::_id_113A("mp_arena_spawn_allies_start");
    _id_0817::_id_113A("mp_arena_spawn_axis_start");
    level._id_1518 = "mp_arena_spawn_allies_start";
    level._id_1FEF = "mp_arena_spawn_axis_start";
  } else {
    _id_0817::_id_113A("mp_sd_spawn_attacker");
    _id_0817::_id_113A("mp_sd_spawn_defender");
    level._id_1518 = "mp_sd_spawn_attacker";
    level._id_1FEF = "mp_sd_spawn_defender";
  }

  if(var_2.size > 0) {
    _id_0817::_id_1136("allies", "mp_arena_spawn");
    _id_0817::_id_1136("axis", "mp_arena_spawn");
    level.spawntype = "mp_arena_spawn";
  } else {
    var_2 = _id_0817::_id_6D4E("mp_tdm_spawn");

    if(var_2.size > 0) {
      _id_0817::_id_1136("allies", "mp_tdm_spawn");
      _id_0817::_id_1136("axis", "mp_tdm_spawn");
      level.spawntype = "mp_tdm_spawn";
    } else
      level._id_1660 = 1;
  }

  var_3 = _id_0817::_id_6D4E(level.spawntype);
  var_4 = _id_0817::_id_6D4E(level.spawntype);
  _id_0817::_id_C2B9("normal", var_3);
  _id_0817::_id_C2B9("fallback", var_4);
  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
  _id_0817::_id_0EE5();
}

_id_FF57(var_0) {
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = _id_0817::_id_6D4E(var_0);

  foreach(var_7 in var_5) {
    if(isDefined(var_7._id_039B)) {
      if(!var_1) {
        var_1 = var_7._id_039B == "1";
      } else {}

      if(!var_2) {
        var_2 = var_7._id_039B == "2";
      } else {}

      if(!var_3) {
        var_3 = var_7._id_039B == "3";
        level._id_75BD = 1;
      } else {}

      continue;
    }

    if(var_4 == 0) {
      var_7._id_039B = "1";
      var_4++;
      continue;
    }

    if(var_4 == 1) {
      var_7._id_039B = "2";
      var_4++;
      continue;
    }

    if(var_4 == 2) {
      var_7._id_039B = "3";
      var_4++;
      level._id_75BD = 1;
    }
  }
}

_id_6D4A() {
  _id_0817::_id_D461("Default", "Crit_Frontline");
  var_0 = undefined;
  var_1 = level._id_1FEF;
  var_2 = 0;

  if(self.pers["team"] == game["attackers"]) {
    var_1 = level._id_1518;
  }

  if(_id_0817::_id_DC06() || istrue(level._id_1660) || _func_0394()) {
    _id_0817::_id_D461("StartSpawn", "Crit_Default");
    var_3 = _id_0817::_id_6D4E(var_1);

    if(istrue(level._id_EC35) && game["roundsPlayed"] > 0) {
      var_4 = scripts\mp\utility\teams::_id_6DC9(self.pers["team"]);

      if(var_4 > 3) {
        foreach(var_6 in scripts\mp\utility\teams::_id_6DCA(self.pers["team"], "players")) {
          if(isDefined(var_6.pers["arena_spawn_pos"])) {
            var_6.pers["arena_spawn_pos"] = "0";
          }
        }

        var_2 = 1;
      }
    }

    if(istrue(level._id_EC35) && game["roundsPlayed"] > 0 && !var_2) {
      if(self.pers["arena_spawn_pos"] == "1") {
        self.pers["arena_spawn_pos"] = "2";
      } else if(scripts\mp\utility\teams::_id_6DC9(self.pers["team"], 0) == 3 && istrue(level._id_75BD) && self.pers["arena_spawn_pos"] == "2") {
        self.pers["arena_spawn_pos"] = "3";
      } else if(self.pers["arena_spawn_pos"] == "3") {
        self.pers["arena_spawn_pos"] = "1";
      } else {
        self.pers["arena_spawn_pos"] = "1";
      }

      var_0 = _id_6DAB(var_3, self.pers["arena_spawn_pos"]);
    }

    if(!isDefined(var_0)) {
      if(istrue(self._id_EC34) && isDefined(self.pers["arena_spawn_pos"])) {
        _id_389D();
        var_0 = _id_6D4D(var_3);
        self._id_EC34 = undefined;

        if(isDefined(var_0)) {
          self._id_E347 = var_0.angles;
        }
      } else {
        var_0 = _id_6D4D(var_3);

        if(isDefined(var_0)) {
          self._id_E347 = var_0.angles;
        }
      }

      if(!isDefined(var_0)) {
        var_4 = scripts\mp\utility\teams::_id_6DC9(self.pers["team"]);

        if(var_4 > 3) {
          var_8 = undefined;
          var_9 = 0;

          foreach(var_6 in scripts\mp\utility\teams::_id_6DCA(self.pers["team"], "players")) {
            if(istrue(var_6._id_2C95)) {
              var_9++;
              continue;
            }

            break;
          }

          foreach(var_6 in scripts\mp\utility\teams::_id_6DCA(self.pers["team"], "players")) {
            if(var_6 == self) {
              continue;
            }
            if(istrue(var_6._id_2C95)) {
              continue;
            }
            if(isDefined(var_6.pers["arena_spawn_pos"])) {
              if(level._id_FE59[self.pers["team"]] == 1 && level._id_FE5B[self.pers["team"]] == 1 && level._id_FE5A[self.pers["team"]] == 1) {
                level._id_FE59[self.pers["team"]] = 0;
                level._id_FE5B[self.pers["team"]] = 0;
                level._id_FE5A[self.pers["team"]] = 0;
              }

              if(var_6.pers["arena_spawn_pos"] == "1" && level._id_FE59[self.pers["team"]] == 0) {
                level._id_FE59[self.pers["team"]]++;
                var_6._id_2C95 = 1;
                var_8 = var_6;
                break;
              } else if(var_6.pers["arena_spawn_pos"] == "2" && level._id_FE5B[self.pers["team"]] == 0) {
                level._id_FE5B[self.pers["team"]]++;
                var_6._id_2C95 = 1;
                var_8 = var_6;
                break;
              } else if(var_6.pers["arena_spawn_pos"] == "3" && level._id_FE5A[self.pers["team"]] == 0) {
                level._id_FE5A[self.pers["team"]]++;
                var_6._id_2C95 = 1;
                var_8 = var_6;
                break;
              } else {
                level._id_FE59[self.pers["team"]]++;
                var_6._id_2C95 = 1;
                var_8 = var_6;
                break;
              }
            }
          }

          if(isDefined(var_8)) {
            var_0 = _id_0818::_id_5B07(var_8);

            if(isDefined(var_8._id_E347)) {
              var_0.angles = var_8._id_E347;
            }
          }
        }
      }

      if(!isDefined(var_0)) {
        var_0 = _id_0817::_id_6D4A(self, self.pers["team"], "normal", "fallback");
      }

      if(isDefined(var_0._id_039B) && var_0._id_039B != "" && istrue(level._id_EC35) && game["roundsPlayed"] == 0) {
        self.pers["arena_spawn_pos"] = var_0._id_039B;
      }
    }
  } else
    var_0 = _id_0817::_id_6D4A(self, self.pers["team"], "normal", "fallback");

  return var_0;
}

_id_389D() {
  var_0 = scripts\mp\utility\game::_id_6BE2(self.pers["team"])[0];

  if(var_0 == game["attackers"]) {
    var_1 = level._id_1518;
    var_2 = level._id_1FEF;
  } else {
    var_1 = level._id_1FEF;
    var_2 = level._id_1518;
  }

  var_3 = _id_0817::_id_6D4E(var_1);

  foreach(var_5 in var_3) {
    if(var_5._id_039B == self.pers["arena_spawn_pos"]) {
      var_5._id_D054 = 0;
    }
  }

  var_3 = _id_0817::_id_6D4E(var_2);

  foreach(var_5 in var_3) {
    foreach(var_9 in scripts\mp\utility\teams::_id_6DCA(self.pers["team"], "players")) {
      if(var_9 != self && isDefined(var_9.pers["arena_spawn_pos"]) && var_5._id_039B != var_9.pers["arena_spawn_pos"]) {
        var_5._id_D054 = 0;
      }
    }
  }
}

_id_6D4D(var_0, var_1) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_2 = undefined;
  var_0 = _id_0818::_id_34F7(var_0);

  foreach(var_4 in var_0) {
    if(!isDefined(var_4._id_D054)) {
      continue;
    }
    if(var_4._id_D054) {
      continue;
    }
    if(var_4._id_039B == "1") {
      var_2 = var_4;
      break;
    } else if(var_4._id_039B == "2") {
      var_2 = var_4;
      break;
    }

    var_2 = var_4;
  }

  if(isDefined(var_2)) {
    var_2._id_D054 = 1;
  }

  return var_2;
}

_id_6DAB(var_0, var_1) {
  if(!isDefined(var_0)) {
    return undefined;
  }

  var_2 = 0;

  foreach(var_4 in var_0) {
    if(var_4._id_039B == var_1) {
      if(istrue(var_4._id_D054)) {
        var_2 = 1;
        continue;
      }

      var_4._id_D054 = 1;
      return var_4;
    }
  }

  return undefined;
}

onplayerconnect(var_0) {
  if(istrue(level._id_15BD)) {
    level._id_15BD = 0;
  }

  var_0._id_1A9F = 0;
  var_0 scripts\mp\utility\stats::_id_D550(0);

  if(isDefined(var_0.pers["damage"])) {
    var_0 scripts\mp\utility\stats::_id_D550(var_0.pers["damage"]);
  }

  if(!_id_8950()) {
    var_0 setclientomnvar("ui_skip_loadout", 1);
    var_0.pers["class"] = "gamemode";
    var_0.pers["lastClass"] = "";
    var_0.class = var_0.pers["class"];
    var_0._id_8FAF = var_0.pers["lastClass"];

    if(_id_89E3() || _id_89E5() || _id_89DD()) {
      var_0.pers["gamemodeLoadout"] = game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]];
    } else if(_id_897F()) {
      var_0.pers["gamemodeLoadout"] = level._id_1A9B["axis"];
    }

    if(_id_8887() || _id_8A0E()) {
      var_0.pers["gamemodeLoadout"] = game["arenaRandomLoadout"][_id_6A89(var_0)];

      if(game["roundsPlayed"] == 0) {
        var_0 _id_D53E();
      }
    }
  }

  if(istrue(level._id_EC35) && !isDefined(var_0.pers["arena_spawn_pos"])) {
    var_0.pers["arena_spawn_pos"] = "0";
  }

  var_0 thread _id_AB05();

  if(!_id_8950()) {
    var_0 _id_FC85();
  }

  _id_0A8E::_id_C285(::_id_AB63);
}

_id_AB63(var_0) {
  _id_D711(1);
}

_id_AB05() {
  level endon("game_ended");

  for(;;) {
    scripts\engine\utility::waittill_any_2("joined_team", "joined_spectators");
    _id_D711();
  }
}

_id_ABA4() {
  thread _id_ABA1();
  level notify("spawned_player");
  thread _id_FCC2();
}

_id_ABA1() {
  self endon("death_or_disconnect");

  if(istrue(game["practiceRound"]) || istrue(level._id_165E)) {
    thread _id_DFC1();
  }

  thread _id_4335();

  if(!_id_8950()) {
    self waittill("giveLoadout");
    _id_CA22();
  }

  thread _id_A005();
  wait 0.1;
  self._id_7539 = 1;
  wait 0.15;

  if(!_id_07D1::_id_60BE("prematch_done") && game["roundsPlayed"] == 0) {
    if(level._id_E2EA && isDefined(level._id_9BAA) && level._id_9BAA > 5) {
      if(!self _meth_81E2() || self _meth_81E3()) {
        _id_0A8D::_id_9137("obj_indepth", "introboost");
      }
    }

    level scripts\engine\utility::waittill_any_2("prematch_done", "removeArenaOutlines");
  }

  self setclientomnvar("ui_player_notify_loadout", gettime());
}

_id_D711(var_0) {
  var_1 = getdvarint("#x3479ab28f2a947c0b", 100);
  var_2 = scripts\mp\utility\teams::_id_6DCA("allies", "teamCount");

  if(var_2) {
    level._id_1514 = scripts\mp\utility\teams::_id_6DCA("allies", "teamCount") * var_1;
    setomnvar("ui_arena_allies_health_max", level._id_1514);

    if(!istrue(var_0) && !scripts\mp\utility\player::isreallyalive(self) && scripts\mp\playerlogic::_id_9CCD()) {
      self waittill("spawned_player");
    }

    var_3 = 0;

    foreach(var_5 in scripts\mp\utility\teams::_id_6DCA("allies", "players")) {
      var_3 = var_3 + var_5.health;
    }

    level._id_1511 = var_3;

    if(level._id_1511 < 0) {
      level._id_1511 = 0;
    }

    setomnvar("ui_arena_allies_health", level._id_1511);
  } else
    setomnvar("ui_arena_allies_health", 0);

  var_7 = scripts\mp\utility\teams::_id_6DCA("axis", "teamCount");

  if(var_7) {
    level._id_1FE9 = scripts\mp\utility\teams::_id_6DCA("axis", "teamCount") * var_1;
    setomnvar("ui_arena_axis_health_max", level._id_1FE9);

    if(!istrue(var_0) && !scripts\mp\utility\player::isreallyalive(self) && scripts\mp\playerlogic::_id_9CCD()) {
      self waittill("spawned_player");
    }

    var_8 = 0;

    foreach(var_5 in scripts\mp\utility\teams::_id_6DCA("axis", "players")) {
      var_8 = var_8 + var_5.health;
    }

    level._id_1FE6 = var_8;

    if(level._id_1FE6 < 0) {
      level._id_1FE6 = 0;
    }

    setomnvar("ui_arena_axis_health", level._id_1FE6);
  } else
    setomnvar("ui_arena_axis_health", 0);
}

_id_A005() {
  var_0 = scripts\mp\utility\dvars::_id_509C("blastShieldMod", 65, 0, 100) / 100;

  if(var_0 == 0) {
    scripts\mp\utility\perk::removeperk("specialty_blastshield");
  }
}

_id_AB61(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  if(isDefined(var_1) && var_1 != var_2 && isPlayer(var_1)) {
    if(istrue(level._id_DFBF) && (var_6.basename == "snowball_mp" || var_6.basename == "pball_mp")) {
      _func_019D(level._id_DFC2["screen"], var_2, "tag_eye", var_2);
    }

    if(var_3 >= var_7) {
      var_3 = var_7;
    }

    var_1._id_1A9F = var_1._id_1A9F + var_3;
    var_1 scripts\mp\persistence::_id_E770("round", "damage", var_1.pers["damage"]);
    var_1 scripts\mp\utility\stats::_id_D550(var_1.pers["damage"]);
  }
}

_id_4335() {
  self notify("startDamageWatcher");
  self endon("startDamageWatcher");
  level endon("game_ended");
  self endon("disconnect");
  self._id_F375 = 0;

  for(;;) {
    scripts\engine\utility::_id_10885("damage", "force_regeneration", "removeAdrenaline", "healed", "healhRegenThink", "vampirism", "spawned_player");

    if(self.team == "allies") {
      var_0 = 0;

      foreach(var_2 in scripts\mp\utility\teams::_id_6DCA("allies", "players")) {
        var_0 = var_0 + var_2.health;
      }

      level._id_1511 = var_0;

      if(level._id_1511 < 0) {
        level._id_1511 = 0;
      }

      setomnvar("ui_arena_allies_health", level._id_1511);
    } else {
      var_4 = 0;

      foreach(var_2 in scripts\mp\utility\teams::_id_6DCA("axis", "players")) {
        var_4 = var_4 + var_2.health;
      }

      level._id_1FE6 = var_4;

      if(level._id_1FE6 < 0) {
        level._id_1FE6 = 0;
      }

      setomnvar("ui_arena_axis_health", level._id_1FE6);
    }

    if(istrue(self._id_87A3)) {
      var_7 = undefined;

      if(level._id_A90F == 1) {
        if(self.team == game["defenders"]) {
          level._id_1DD5._id_4143 = 50;
          level._id_1DD5._id_EF94[self.team] = 50;
          var_7 = level._id_1DD5;
        } else if(self.team == game["attackers"]) {
          level._id_461C._id_4143 = 50;
          level._id_461C._id_EF94[self.team] = 50;
          var_7 = level._id_461C;
        }

        _id_07F9::_id_A8B4(var_7._id_A908, var_7._id_4143 / var_7._id_FEE7);
      }
    }
  }
}

_id_AB3F(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\mp\gametypes\common::_id_AA89(var_0, var_1, var_2, var_3, var_4, var_5);

  if(!_id_8950()) {
    if(isbot(var_0)) {
      var_0._id_3802 = "gamemode";
    }
  }

  if(game["state"] == "postgame") {
    var_1._id_5AA1 = 1;
  }
}

_id_AB70(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!_id_8950()) {
    if(isbot(self)) {
      self._id_3802 = "gamemode";
    }
  }

  if(isDefined(var_1) && (var_4.basename == "snowball_mp" || var_4.basename == "pball_mp")) {
    var_1 thread _id_0A9F::_id_7003("snowball_kill");
  }

  thread _id_34DE();
}

_id_34DE() {
  waitframe();
  var_0 = 0;

  if(!scripts\mp\utility\teams::_id_6DCA(game["attackers"], "aliveCount")) {
    level._id_E3E2[game["attackers"]]._id_15B5 = 1;
    var_0 = 1;
  }

  if(!scripts\mp\utility\teams::_id_6DCA(game["defenders"], "aliveCount")) {
    level._id_E3E2[game["defenders"]]._id_15B5 = 1;
    var_0 = 1;
  }

  if(var_0) {
    _id_081A::_id_FD35();
  }
}

_id_ABC0() {
  if(level.gameended) {
    return;
  }
  _func_0397(scripts\mp\gamelogic::_id_6DE8(), 3);

  if(level._id_10E23 == 1) {
    _id_3527();
  } else if(level._id_10E23 == 2) {
    _id_3518();
  } else {
    _id_3518();
  }
}

_id_ABC3() {
  _func_0397(scripts\mp\gamelogic::_id_6DE8(), 1);
  level thread _id_E707();
}

_id_3527() {
  if(scripts\mp\utility\teams::_id_6DCA("allies", "aliveCount") > scripts\mp\utility\teams::_id_6DCA("axis", "aliveCount")) {
    game["dialog"]["round_success"] = "gamestate_win_health";
    game["dialog"]["round_failure"] = "gamestate_lost_health";
    thread _id_1A64("allies", game["end_reason"]["arena_time_lives_win"], game["end_reason"]["arena_time_lives_loss"]);
  } else if(scripts\mp\utility\teams::_id_6DCA("axis", "aliveCount") > scripts\mp\utility\teams::_id_6DCA("allies", "aliveCount")) {
    game["dialog"]["round_success"] = "gamestate_win_health";
    game["dialog"]["round_failure"] = "gamestate_lost_health";
    thread _id_1A64("axis", game["end_reason"]["arena_time_lives_win"], game["end_reason"]["arena_time_lives_loss"]);
  } else
    _id_3518();
}

_id_3518() {
  if(level._id_1FE6 < level._id_1511) {
    game["dialog"]["round_success"] = "gamestate_win_health";
    game["dialog"]["round_failure"] = "gamestate_lost_health";
    thread _id_1A64("allies", game["end_reason"]["arena_time_health_win"], game["end_reason"]["arena_time_health_loss"]);
  } else if(level._id_1511 < level._id_1FE6) {
    game["dialog"]["round_success"] = "gamestate_win_health";
    game["dialog"]["round_failure"] = "gamestate_lost_health";
    thread _id_1A64("axis", game["end_reason"]["arena_time_health_win"], game["end_reason"]["arena_time_health_loss"]);
  } else if(scripts\mp\utility\game::matchmakinggame()) {
    if(_func_0394()) {
      game["canScoreOnTie"] = 1;

      if(game["finalRound"] == 1) {
        game["canScoreOnTie"] = 0;

        if(!isDefined(game["roundsTied"])) {
          game["roundsTied"] = 1;
        } else {
          game["roundsTied"]++;
        }

        if(game["roundsTied"] >= 2) {
          var_0 = scripts\mp\gamelogic::_id_691F();
          thread scripts\mp\gamelogic::_id_52F7(var_0, game["end_reason"]["arena_tournament_tie_win"], game["end_reason"]["arena_tournament_tie_loss"]);
        } else
          thread _id_1A64("tie", game["end_reason"]["time_limit_reached"]);
      } else
        thread _id_1A64("tie", game["end_reason"]["cyber_tie"]);
    } else {
      if(!isDefined(game["roundsTied"])) {
        game["roundsTied"] = 1;
      } else {
        game["roundsTied"]++;
      }

      game["canScoreOnTie"] = game["roundsTied"] >= 2;

      if(game["canScoreOnTie"]) {
        thread _id_1A64("tie", game["end_reason"]["cyber_tie"]);
      } else {
        thread _id_1A64("tie", game["end_reason"]["time_limit_reached"]);
      }
    }
  } else
    thread _id_1A64("tie", game["end_reason"]["time_limit_reached"]);
}

_id_AAA3(var_0) {
  if(var_0 == game["attackers"]) {
    level thread _id_1A64(game["defenders"], game["end_reason"][tolower(game[game["attackers"]]) + "_eliminated"]);
  } else if(var_0 == game["defenders"]) {
    level thread _id_1A64(game["attackers"], game["end_reason"][tolower(game[game["defenders"]]) + "_eliminated"]);
  }
}

_id_ABC1(var_0) {}

_id_355A(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_EF89) {
    var_1[var_3] = 0;
  }

  foreach(var_6 in level.players) {
    if(!istrue(var_6._id_75B4) || var_6.team == "spectator" || var_6.team == "follower") {
      continue;
    }
    var_1[var_6.team] = var_1[var_6.team] + var_6.pers["lives"];
  }

  var_8 = 0;

  foreach(var_3 in level._id_EF89) {
    if(scripts\mp\utility\teams::_id_6DCA(var_3, "aliveCount")) {
      var_8 = 1;
      break;
    }
  }

  var_11 = 0;

  foreach(var_13 in var_1) {
    if(var_13) {
      var_11 = 1;
      break;
    }
  }

  if(!var_8 && !var_11) {
    return "tie";
  }

  foreach(var_3 in level._id_EF89) {
    if(!scripts\mp\utility\teams::_id_6DCA(var_3, "aliveCount") && !var_1[var_3]) {
      if(level._id_A2FC) {
        if(!scripts\mp\utility\teams::_id_6DCA(var_3, "deathEvent") && scripts\mp\utility\teams::_id_6DCA(var_3, "hasSpawned")) {
          scripts\mp\utility\teams::_id_D70F(var_3, "deathEvent", 1);
          return var_0;
        }
      } else
        return var_0;
    }
  }

  foreach(var_3 in level._id_EF89) {
    var_18 = scripts\mp\utility\teams::_id_6DCA(var_3, "aliveCount") == 1;

    if(var_18) {
      var_19 = 0;
      var_20 = undefined;
      var_21 = scripts\mp\utility\teams::_id_6DCA(var_3, "players");

      foreach(var_6 in var_21) {
        if(!isalive(var_6)) {
          var_19 = var_19 + var_6.pers["lives"];
        }
      }

      if(var_19 == 0) {
        if(!scripts\mp\utility\teams::_id_6DCA(var_3, "oneLeft") && gettime() > scripts\mp\utility\teams::_id_6DCA(var_3, "oneLeftTime") + 5000) {
          scripts\mp\utility\teams::_id_D70F(var_3, "oneLeftTime", gettime());
          scripts\mp\utility\teams::_id_D70F(var_3, "oneLeft", 1);

          if(var_21.size > 1) {
            return var_0;
          }
        }
      }

      continue;
    }

    scripts\mp\utility\teams::_id_D70F(var_3, "oneLeft", 0);
  }

  return var_0;
}

_id_1A64(var_0, var_1, var_2, var_3, var_4) {
  if(var_0 != "tie") {
    if(istrue(level._id_A737)) {
      return;
    }
    waittillframeend;
    var_0 = _id_355A(var_0);
  }

  if(_id_8887() || _id_8A0E()) {
    level _id_D53F(var_0);
  }

  if(var_0 != "tie") {
    game["roundsTied"] = 0;
    game["previousWinningTeam"] = var_0;

    foreach(var_6 in level._id_EF89) {
      if(var_6 == var_0) {
        game["roundWinStreak"][var_0]++;
        continue;
      }

      game["roundWinStreak"][var_6] = 0;
    }

    switch (game["roundWinStreak"][var_0]) {
      case 2:
        game["dialog"]["round_success"] = "round_win_streak_2";
        break;
      case 3:
        game["dialog"]["round_success"] = "round_win_streak_3";
        break;
      case 4:
        game["dialog"]["round_success"] = "round_win_streak_4";
        break;
      case 5:
        var_8 = scripts\mp\utility\game::_id_6CFE(var_0);
        var_9 = scripts\mp\utility\dvars::getwatcheddvar("winlimit");

        if(var_9 == 6 && var_8 != var_9 - 1) {
          game["dialog"]["round_success"] = "round_win_streak_5";
        }

        break;
      default:
        break;
    }

    if(game["finalRound"] == 1) {
      if(game["roundWinStreak"][var_0] > 3) {
        game["dialog"]["mission_success"] = "gamestate_win_comeback";
      }
    }
  } else
    game["previousWinningTeam"] = "";

  thread scripts\mp\gamelogic::_id_52F7(var_0, var_1, var_2, var_3, var_4);
}

_id_D6AA() {
  wait 1;

  foreach(var_1 in level._id_EF89) {
    game["roundWinStreak"][var_1] = 0;
  }
}

_id_CA22() {
  if(_id_89E3() || _id_89E5() || _id_89DD()) {
    if(_id_89E5() || _id_89DD()) {
      if(self.pers["gamemodeLoadout"]["loadoutSecondary"] == "none") {
        scripts\cp_mp\utility\inventory_utility::_takeweapon("s4_me_fists_mp");
      }
    }
  } else if(_id_897F()) {
    self.equipment = [];

    if(game["roundsPlayed"] == 0) {
      wait 0.1;
    } else {
      wait 0.25;
    }

    if(issubstr(level._id_E73D, "equip")) {
      scripts\mp\equipment::giveequipment(level._id_E73D, scripts\mp\equipment::_id_69D6(level._id_E73D));
    }

    if(level._id_EDBF) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon("s4_me_fists_mp");
    }
  }
}

_id_FC85() {
  self loadweaponsforplayer(level._id_96AE, 1);
}

_id_2D03() {
  level._id_96AE = [];
  level._id_EDBF = 0;

  if(_id_897F()) {
    if(level._id_E73D == "none") {
      var_0 = "s4_me_fists_mp";
      var_1 = makeweapon(var_0);
      var_0 = getcompleteweaponname(var_1);
    } else if(issubstr(level._id_E73D, "equip")) {
      var_0 = "s4_me_fists_mp";
      var_1 = makeweapon(var_0);
      var_0 = getcompleteweaponname(var_1);
    } else {
      var_2 = scripts\mp\utility\weapon::getweaponrootname(level._id_E73D);
      var_3 = [];
      var_4 = "none";
      var_5 = "none";
      var_6 = undefined;
      var_7 = undefined;
      var_8 = undefined;
      var_9 = undefined;

      if(istrue(level._id_E3C8)) {
        var_4 = game["arenaRandomLoadout"][0]["loadoutPrimaryCamo"];
        var_8 = game["arenaRandomLoadout"][0]["loadoutPrimaryCosmeticAttachment"];
        var_9[0] = game["arenaRandomLoadout"][0]["loadoutPrimarySticker"];
        var_9[1] = game["arenaRandomLoadout"][0]["loadoutPrimarySticker1"];
        var_9[2] = game["arenaRandomLoadout"][0]["loadoutPrimarySticker2"];
        var_9[3] = game["arenaRandomLoadout"][0]["loadoutPrimarySticker3"];
      }

      var_1 = scripts\mp\class::buildweapon(var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
      var_0 = getcompleteweaponname(var_1);
      level._id_EDBF = 1;
    }

    level._id_A45F = var_0;
    level._id_96AE[level._id_96AE.size] = var_1;
  } else {
    var_10 = [];
    var_11 = [];
    var_12 = game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]];
    var_13 = var_12["loadoutPrimary"];
    var_14 = var_12["loadoutSecondary"];

    if(var_13 != "none") {
      var_10[var_10.size] = _id_2D07(var_13, var_12, 1);
    }

    if(var_14 != "none") {
      var_11[var_11.size] = _id_2D0B(var_14, var_12, 1);
    }

    if(level._id_9661 != 0) {
      var_15 = game["arenaRandomLoadoutIndex"] + 1;

      if(game["arenaRandomLoadoutIndex"] == game["arenaRandomLoadout"].size - 1) {
        var_15 = 0;
      }

      var_16 = game["arenaRandomLoadout"][var_15];
      var_17 = var_16["loadoutPrimary"];
      var_18 = var_16["loadoutSecondary"];

      if(var_17 != "none") {
        var_10[var_10.size] = _id_2D07(var_17, var_16);
      }

      if(var_18 != "none") {
        var_11[var_11.size] = _id_2D0B(var_18, var_16);
      }
    }

    level._id_96AE = scripts\engine\utility::array_combine(var_10, var_11);
  }
}

_id_2D07(var_0, var_1, var_2) {
  var_3 = [];

  for(var_4 = 1; var_4 < 6; var_4++) {
    var_5 = var_4;
    var_6 = var_1["loadoutPrimaryAttachment" + var_5];

    if(var_6 != "none") {
      var_3[var_3.size] = var_6;
    }
  }

  var_7 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_8 = "none";
  var_9 = "none";
  var_10 = undefined;
  var_11 = undefined;
  var_12 = undefined;
  var_13 = undefined;

  if(istrue(level._id_E3C8) && istrue(var_2)) {
    var_8 = _id_6D64();
    game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutPrimaryCamo"] = var_8;

    if(_id_FF66(var_0)) {
      var_12 = _id_6D65();
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutPrimaryCosmeticAttachment"] = var_12;
    }

    if(_id_FF67(var_0)) {
      var_13 = _id_6D66();
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutPrimarySticker"] = var_13[0];
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutPrimarySticker1"] = var_13[1];
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutPrimarySticker2"] = var_13[2];
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutPrimarySticker3"] = var_13[3];
    }
  }

  var_14 = scripts\mp\class::buildweapon(var_7, var_3, var_8, var_9, var_10, var_11, var_12, var_13);
  var_15 = getcompleteweaponname(var_14);
  return var_15;
}

_id_2D0B(var_0, var_1, var_2) {
  var_3 = [];

  for(var_4 = 1; var_4 < 6; var_4++) {
    var_5 = var_4;
    var_6 = var_1["loadoutSecondaryAttachment" + var_5];

    if(var_6 != "none") {
      var_3[var_3.size] = var_6;
    }
  }

  var_7 = "none";
  var_8 = "none";
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = undefined;

  if(istrue(level._id_E3C8) && istrue(var_2)) {
    var_7 = _id_6D64();
    game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutSecondaryCamo"] = var_7;

    if(_id_FF66(var_0)) {
      var_11 = _id_6D65();
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutSecondaryCosmeticAttachment"] = var_11;
    }

    if(_id_FF67(var_0)) {
      var_12 = _id_6D66();
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutSecondarySticker"] = var_12[0];
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutSecondarySticker1"] = var_12[1];
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutSecondarySticker2"] = var_12[2];
      game["arenaRandomLoadout"][game["arenaRandomLoadoutIndex"]]["loadoutSecondarySticker3"] = var_12[3];
    }
  }

  var_13 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_14 = scripts\mp\class::buildweapon(var_13, var_3, var_7, var_8);
  var_15 = getcompleteweaponname(var_14);
  return var_15;
}

_id_6D64() {
  var_0 = "none";

  if(istrue(level._id_1AFF)) {
    var_1 = ["camo_06g", "camo_07i", "camo_08j", "camo_10i", "camo_10j", "camo_07i"];
    var_0 = scripts\engine\utility::random(var_1);
  } else if(istrue(level._id_1AC1)) {
    var_1 = ["camo_03j", "camo_05b", "camo_05b", "camo_09i"];
    var_0 = scripts\engine\utility::random(var_1);
  }

  return var_0;
}

_id_FF66(var_0) {
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  return 1;
}

_id_FF67(var_0) {
  return var_0 != "s4_me_knife";
}

_id_6D65() {
  var_0 = "none";

  if(istrue(level._id_1AFF)) {
    var_1 = ["cos_032", "cos_285", "cos_053", "cos_299"];
    var_0 = scripts\engine\utility::random(var_1);
  } else if(istrue(level._id_1AC1)) {
    var_1 = ["cos_291", "cos_292", "cos_293", "cos_146"];
    var_0 = scripts\engine\utility::random(var_1);
  }

  return var_0;
}

_id_6D66() {
  var_0 = [];

  if(istrue(level._id_1AFF)) {
    var_1 = ["i/sticker_211", "i/sticker_212", "i/sticker_101", "i/sticker_134"];
    var_0[var_0.size] = ::scripts\engine\utility::random(var_1);
    var_0[var_0.size] = ::scripts\engine\utility::random(var_1);
    var_0[var_0.size] = ::scripts\engine\utility::random(var_1);
    var_0[var_0.size] = ::scripts\engine\utility::random(var_1);
  } else if(istrue(level._id_1AC1)) {
    var_1 = ["i/sticker_246", "i/sticker_199", "i/sticker_202"];
    var_0[var_0.size] = ::scripts\engine\utility::random(var_1);
    var_0[var_0.size] = ::scripts\engine\utility::random(var_1);
    var_0[var_0.size] = ::scripts\engine\utility::random(var_1);
    var_0[var_0.size] = ::scripts\engine\utility::random(var_1);
  }

  return var_0;
}

_id_D8B6() {
  level._id_1B00 = _id_2D0D(level._id_1B00);
  level._id_1B01 = _id_2D0D(level._id_1B01);
  level._id_1B02 = _id_2D0D(level._id_1B02);
  level._id_1B03 = _id_2D0D(level._id_1B03);
  level._id_1B04 = _id_2D0D(level._id_1B04);
  level._id_1B05 = _id_2D0D(level._id_1B05);
  level._id_1B06 = _id_2D0D(level._id_1B06);
  level._id_1B07 = _id_2D0D(level._id_1B07);
}

_id_2D0D(var_0) {
  var_0._id_04F6 = var_0._id_04F6;

  if(!issubstr(var_0._id_04F6, "equip") && var_0._id_04F6 != "none") {
    var_1 = [];
    var_2 = "none";
    var_3 = "none";
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;
    var_7 = [];
    var_7[0] = "none";
    var_7[1] = "none";
    var_7[2] = "none";
    var_7[3] = "none";
    var_8 = scripts\mp\utility\weapon::getweaponrootname(var_0._id_04F6);
    var_2 = _id_6D64();
    var_0._id_30A9 = var_2;

    if(_id_FF66(var_0._id_04F6)) {
      var_6 = _id_6D65();
      var_0._id_3D90 = var_6;
    }

    if(_id_FF67(var_0._id_04F6)) {
      var_7 = _id_6D66();
      var_0._id_E840[0] = var_7[0];
      var_0._id_E840[1] = var_7[1];
      var_0._id_E840[2] = var_7[2];
      var_0._id_E840[3] = var_7[3];
    }

    var_0._id_10DB5 = scripts\mp\class::buildweapon(var_8, var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  }

  return var_0;
}

_id_4636() {
  var_0 = [];
  var_1 = "none";
  var_2 = "none";
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = [];
  var_6[0] = "none";
  var_6[1] = "none";
  var_6[2] = "none";
  var_6[3] = "none";

  if(isDefined(level._id_E73D) && level._id_E73D != "none" && !issubstr(level._id_E73D, "equip")) {
    var_7 = scripts\mp\utility\weapon::getweaponrootname(level._id_E73D);

    if(istrue(level._id_E3C8)) {
      var_1 = _id_6D64();
      game["arenaRandomLoadout"][0]["loadoutPrimaryCamo"] = var_1;

      if(_id_FF66(level._id_E73D)) {
        var_5 = _id_6D65();
        game["arenaRandomLoadout"][0]["loadoutPrimaryCosmeticAttachment"] = var_5;
      }

      if(_id_FF67(level._id_E73D)) {
        var_6 = _id_6D66();
        game["arenaRandomLoadout"][0]["loadoutPrimarySticker"] = var_6[0];
        game["arenaRandomLoadout"][0]["loadoutPrimarySticker1"] = var_6[1];
        game["arenaRandomLoadout"][0]["loadoutPrimarySticker2"] = var_6[2];
        game["arenaRandomLoadout"][0]["loadoutPrimarySticker3"] = var_6[3];
      }
    }
  } else
    var_7 = "none";

  level._id_1A9B["default"]["loadoutArchetype"] = "archetype_assault";
  level._id_1A9B["default"]["loadoutPrimary"] = var_7;
  level._id_1A9B["default"]["loadoutPrimaryAttachment"] = "none";
  level._id_1A9B["default"]["loadoutPrimaryAttachment2"] = "none";
  level._id_1A9B["default"]["loadoutPrimaryAttachment3"] = "none";
  level._id_1A9B["default"]["loadoutPrimaryAttachment4"] = "none";
  level._id_1A9B["default"]["loadoutPrimaryAttachment5"] = "none";
  level._id_1A9B["default"]["loadoutPrimaryCamo"] = var_1;
  level._id_1A9B["default"]["loadoutPrimaryCosmeticAttachment"] = var_5;
  level._id_1A9B["default"]["loadoutPrimaryReticle"] = var_2;
  level._id_1A9B["default"]["loadoutPrimarySticker"] = var_6[0];
  level._id_1A9B["default"]["loadoutPrimarySticker1"] = var_6[1];
  level._id_1A9B["default"]["loadoutPrimarySticker2"] = var_6[2];
  level._id_1A9B["default"]["loadoutPrimarySticker3"] = var_6[3];
  level._id_1A9B["default"]["loadoutSecondary"] = "none";
  level._id_1A9B["default"]["loadoutSecondaryAttachment"] = "none";
  level._id_1A9B["default"]["loadoutSecondaryAttachment2"] = "none";
  level._id_1A9B["default"]["loadoutSecondaryAttachment3"] = "none";
  level._id_1A9B["default"]["loadoutSecondaryAttachment4"] = "none";
  level._id_1A9B["default"]["loadoutSecondaryAttachment5"] = "none";
  level._id_1A9B["default"]["loadoutSecondaryCamo"] = "none";
  level._id_1A9B["default"]["loadoutSecondaryReticle"] = "none";
  level._id_1A9B["default"]["loadoutSecondarySticker"] = "none";
  level._id_1A9B["default"]["loadoutSecondarySticker1"] = "none";
  level._id_1A9B["default"]["loadoutSecondarySticker2"] = "none";
  level._id_1A9B["default"]["loadoutSecondarySticker3"] = "none";
  level._id_1A9B["default"]["loadoutMeleeSlot"] = "s4_me_fists_mp";
  level._id_1A9B["default"]["loadoutEquipmentPrimary"] = "none";
  level._id_1A9B["default"]["loadoutEquipmentSecondary"] = "none";
  level._id_1A9B["default"]["loadoutStreakType"] = "assault";
  level._id_1A9B["default"]["loadoutKillstreak1"] = "none";
  level._id_1A9B["default"]["loadoutKillstreak2"] = "none";
  level._id_1A9B["default"]["loadoutKillstreak3"] = "none";
  level._id_1A9B["default"]["loadoutSuper"] = "none";
  level._id_1A9B["default"]["loadoutPerks"] = ["specialty_blastshield"];
  level._id_1A9B["default"]["loadoutGesture"] = "playerData";
  level._id_1A9B["default"]["loadoutExecution"] = "playerData";
  level._id_1A9B["allies"] = level._id_1A9B["default"];
  level._id_1A9B["axis"] = level._id_1A9B["default"];
}

_id_FD0A() {
  if(_id_89E3() || _id_89E5() || _id_89DD()) {
    if(game["roundsPlayed"] == 0) {
      if(istrue(game["practiceRound"])) {
        _id_2EAB();
        game["arenaRandomLoadoutIndex"] = 0;
      } else if(!isDefined(game["practiceRound"]) || istrue(game["didSnowFight"])) {
        if(istrue(game["didSnowFight"])) {
          game["didSnowFight"] = undefined;
        }

        _id_2EAB();
        game["arenaRandomLoadoutIndex"] = 0;
      }
    } else if(level._id_9661 != 0) {
      if(game["roundsPlayed"] % level._id_9661 == 0) {
        game["arenaRandomLoadoutIndex"]++;
      }

      if(game["arenaRandomLoadoutIndex"] == game["arenaRandomLoadout"].size) {
        game["arenaRandomLoadoutIndex"] = 0;
      }
    } else
      game["arenaRandomLoadoutIndex"] = 0;
  }
}

_id_2EAB() {
  game["arenaRandomLoadout"] = [];
  var_0 = [];
  var_1 = 0;
  var_2 = "mp/classTable_arena.csv";

  if(_id_89E5()) {
    var_1 = 146;
  } else if(_id_89E1()) {
    var_1 = 0;
  } else if(_id_89E7()) {
    var_1 = 4;
  } else if(_id_89E4()) {
    var_1 = 8;
  } else if(_id_89E6()) {
    var_1 = 9;
  } else if(_id_89E8()) {
    var_1 = 10;
  } else if(_id_89E2()) {
    var_1 = 12;
  }

  while(scripts\mp\class::_id_EC68(var_2, var_1) != "") {
    var_0[var_0.size] = _id_FCAC(var_2, var_1);
    var_1++;

    if(_id_89E3()) {
      if(var_1 == 146) {
        break;
      }
    } else if(_id_89E5()) {
      if(var_1 == 0) {
        break;
      }
    } else if(_id_89E1()) {
      if(var_1 == 4) {
        break;
      }
    } else if(_id_89E7()) {
      if(var_1 == 8) {
        break;
      }
    } else if(_id_89E4()) {
      if(var_1 == 9) {
        break;
      }
    } else if(_id_89E6()) {
      if(var_1 == 10) {
        break;
      }
    } else if(_id_89E8()) {
      if(var_1 == 12) {
        break;
      }
    }
  }

  var_0 = _id_1ABC(var_0, 99);
  game["arenaRandomLoadout"] = ::scripts\engine\utility::array_randomize(var_0);
}

_id_FCAC(var_0, var_1) {
  var_2 = [];
  var_2["loadoutPrimary"] = ::scripts\mp\class::_id_EC6D(var_0, var_1, 0);

  for(var_3 = 0; var_3 < scripts\mp\class::_id_6B49(); var_3++) {
    var_4 = scripts\mp\class::_id_68E4(var_3, "primary");
    var_2[var_4] = ::scripts\mp\class::_id_EC6E(var_0, var_1, 0, var_3);
  }

  var_2["loadoutPrimaryCamo"] = ::scripts\mp\class::_id_EC6F(var_0, var_1, 0);
  var_2["loadoutPrimaryReticle"] = ::scripts\mp\class::_id_EC70(var_0, var_1, 0);
  var_2["loadoutSecondary"] = ::scripts\mp\class::_id_EC6D(var_0, var_1, 1);

  for(var_3 = 0; var_3 < scripts\mp\class::_id_6B4B(); var_3++) {
    var_4 = scripts\mp\class::_id_68E4(var_3, "secondary");
    var_2[var_4] = ::scripts\mp\class::_id_EC6E(var_0, var_1, 1, var_3);
  }

  if(istrue(level._id_E3C8)) {
    var_2["loadoutSecondaryCamo"] = ::scripts\mp\class::_id_EC6F(var_0, var_1, 1);
  } else {
    var_2["loadoutSecondaryCamo"] = ::scripts\mp\class::_id_EC6F(var_0, var_1, 1);
  }

  var_2["loadoutSecondaryReticle"] = ::scripts\mp\class::_id_EC70(var_0, var_1, 1);
  var_2["loadoutEquipmentPrimary"] = ::scripts\mp\class::_id_EC60(var_0, var_1);
  var_2["loadoutExtraEquipmentPrimary"] = ::scripts\mp\class::_id_EC63(var_0, var_1);
  var_2["loadoutEquipmentSecondary"] = ::scripts\mp\class::_id_EC61(var_0, var_1);
  var_2["loadoutExtraEquipmentSecondary"] = ::scripts\mp\class::_id_EC64(var_0, var_1);
  var_2["loadoutPerks"] = [];

  for(var_5 = 0; var_5 < 3; var_5++) {
    var_6 = scripts\mp\class::_id_EC69(var_0, var_1, var_5);

    if(var_6 != "specialty_null") {
      var_2["loadoutPerks"][var_2["loadoutPerks"].size] = var_6;
    }
  }

  var_2["loadoutGesture"] = "playerData";
  var_2["loadoutExecution"] = "playerData";
  return var_2;
}

_id_1ABC(var_0, var_1) {
  var_2 = [];
  var_3 = [];

  for(var_4 = 0; var_4 < var_1 && var_0.size > 0; var_4++) {
    var_3[var_3.size] = var_0[randomint(var_0.size)];
    var_5 = var_3[var_3.size - 1]["loadoutPrimary"];
    var_0 = _id_1ABB(var_0, var_5);
  }

  return var_3;
}

_id_1ABB(var_0, var_1) {
  var_2 = [];
  var_3 = _id_1ABA(var_1);

  foreach(var_5 in var_0) {
    var_6 = _id_1ABA(var_5["loadoutPrimary"]);

    if(var_3 != var_6) {
      var_2[var_2.size] = var_5;
    }
  }

  return var_2;
}

_id_1ABA(var_0) {
  var_1 = "none";

  if(var_0 != "none") {
    var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);

    if(var_1 == "weapon_dmr") {
      var_1 = "weapon_sniper";
    }
  }

  return var_1;
}

_id_2D09() {
  level._id_10D69 = [];
  level._id_15F3 = [];
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("mp/arenaGGWeapons.csv", var_0, 4);

    if(var_1 == "snow") {
      var_0++;
      continue;
    }

    if(var_1 == "") {
      break;
    }

    var_2 = strtok(var_1, "+");

    foreach(var_4 in var_2) {
      if(!isDefined(level._id_10D69[var_4])) {
        level._id_10D69[var_4] = [];
      }

      var_5 = [];
      var_5["weapon"] = tablelookupbyrow("mp/arenaGGWeapons.csv", var_0, 0);
      level._id_10D69[var_4][level._id_10D69[var_4].size] = var_5;
      level._id_15F3[var_5["weapon"]] = var_5["weapon"];
    }

    var_0++;
  }
}

_id_6CD4(var_0) {
  var_1 = level._id_10D69[var_0];

  if(isDefined(var_1) && var_1.size > 0) {
    if(scripts\mp\utility\game::matchmakinggame()) {
      var_2 = getdvarint("#x3f6fe0142a3d126d1", 0);

      if(var_2) {
        if(var_0 == "rand_pistol") {
          var_3 = randomintrange(0, 100);

          if(var_3 > 90) {
            return "none";
          } else if(var_3 > 60 && var_3 <= 80) {
            return "s4_pi_mike1911";
          }
        }
      }
    }

    var_4 = "";
    var_5 = undefined;
    var_6 = 0;

    for(;;) {
      var_7 = randomintrange(0, var_1.size);
      var_5 = var_1[var_7];
      var_8 = scripts\mp\utility\weapon::getweaponrootname(var_5["weapon"]);

      if(var_6 > var_1.size) {
        level._id_D067[var_8] = 1;
        var_4 = var_5["weapon"];

        for(var_9 = 0; var_9 < level._id_10D69[var_0].size; var_9++) {
          if(level._id_10D69[var_0][var_9]["weapon"] == var_4) {
            break;
          }
        }

        break;
      }

      var_6++;
    }

    return var_4;
  } else
    return "none";
}

_id_82BC() {
  level._id_2327 = [];
  level._id_2327[level._id_1B00._id_04F6] = 0;
  level._id_2327[level._id_1B01._id_04F6] = 1;
  level._id_2327[level._id_1B02._id_04F6] = 2;
  level._id_2327[level._id_1B03._id_04F6] = 3;
  level._id_2327[level._id_1B04._id_04F6] = 4;
  level._id_2327[level._id_1B05._id_04F6] = 5;
  level._id_2327[level._id_1B06._id_04F6] = 6;
  level._id_2327[level._id_1B07._id_04F6] = 0;
}

_id_D8C7() {
  var_0 = scripts\engine\utility::getstructarray("weapon_pickup", "targetname");

  if(istrue(level._id_E3C8)) {
    _id_D8B6();
  }

  foreach(var_2 in var_0) {
    if(var_2._id_CD99 == "1") {
      _id_E3A7(var_2, level._id_1B00);
      continue;
    }

    if(var_2._id_CD99 == "2") {
      _id_E3A7(var_2, level._id_1B01);
      continue;
    }

    if(var_2._id_CD99 == "3") {
      _id_E3A7(var_2, level._id_1B02);
      continue;
    }

    if(var_2._id_CD99 == "4") {
      _id_E3A7(var_2, level._id_1B03);
      continue;
    }

    if(var_2._id_CD99 == "5") {
      _id_E3A7(var_2, level._id_1B04);
      continue;
    }

    if(var_2._id_CD99 == "6") {
      _id_E3A7(var_2, level._id_1B05);
      continue;
    }

    if(var_2._id_CD99 == "7") {
      _id_E3A7(var_2, level._id_1B06);
      continue;
    }

    if(var_2._id_CD99 == "8") {
      _id_E3A7(var_2, level._id_1B07);
    }
  }
}

_id_6CCF() {
  var_0 = level._id_15F3;

  if(isDefined(var_0) && var_0.size > 0) {
    var_1 = "";
    var_2 = undefined;
    var_3 = 0;

    for(;;) {
      var_4 = scripts\engine\utility::random(var_0);

      if(!issubstr(var_4, "equip")) {
        var_5 = scripts\mp\utility\weapon::getweaponrootname(var_4);
      } else {
        var_5 = var_4;
      }

      if(var_3 > var_0.size) {
        level._id_D067[var_5] = 1;
        var_1 = var_4;

        for(var_6 = 0; var_6 < level._id_15F3.size; var_6++) {
          if(level._id_15F3[var_4] == var_1) {
            break;
          }
        }

        break;
      }

      var_3++;
    }

    return var_1;
  } else
    return "none";
}

_id_E3A7(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_3 = var_1;
  } else {
    var_3 = var_1._id_04F6;
  }

  if(var_3 == "none") {
    return;
  }
  var_4 = _id_5BFB(var_0);

  if(isDefined(var_0._id_039B) && var_0._id_039B == "wall") {} else {
    var_5 = var_0.origin + (0, 0, 16);
    var_6 = var_0.origin + (0, 0, -16);
    var_7 = scripts\engine\trace::ray_trace(var_5, var_6, undefined, scripts\engine\trace::_id_3EF6(1));

    if(var_7["fraction"] < 1.0) {
      var_4 = var_7["position"] + (0, 0, 2);
    }
  }

  var_8 = "";
  var_9 = _id_6A13(var_3);

  if(var_9 != "") {
    if(istrue(level._id_DFBF) && var_3 == "equip_snowball") {
      if(isPlayer(var_0)) {
        var_8 = "single";
      } else if(isDefined(var_0._id_039B) && var_0._id_039B == "wall") {
        var_8 = "single";
      } else if(scripts\engine\utility::cointoss()) {
        if(scripts\engine\utility::cointoss()) {
          var_8 = "pile";
        } else {
          var_8 = "single";
        }
      } else
        var_8 = "pyramid";

      if(!isPlayer(var_0) && var_0._id_CD99 == "6" && !level._id_B069) {
        if(distance(var_0.origin, (0, 0, 138)) < 10) {
          level._id_B069 = 1;
          var_3 = "equip_pball";
          var_8 = "single";
        }
      } else if(!isPlayer(var_0) && var_0._id_CD99 == "8" && !level._id_B069) {
        if(distance(var_0.origin, (0, 0, -50)) < 10) {
          if(scripts\engine\utility::cointoss()) {
            level._id_B069 = 1;
            var_3 = "equip_pball";
            var_8 = "single";
          }
        }
      }

      switch (var_8) {
        case "pile":
          var_9 = "decor_snowball_pile_01";
          var_4 = var_4 - (0, 0, 3);
          break;
        case "pyramid":
          var_9 = "decor_snowball_pyramid_01";
          var_4 = var_4 - (0, 0, 3);
          break;
        default:
          var_9 = "weapon_wm_snowball";
          break;
      }

      var_10 = spawn("script_model", var_4);
      var_10 setModel(var_9);
    } else {
      var_10 = spawn("script_model", var_4);
      var_10 setModel(var_9);
    }

    if(isDefined(var_0.angles)) {
      if(var_3 == "equip_claymore" || var_3 == "equip_at_mine" || var_3 == "equip_trophy") {
        if(isDefined(var_0._id_039B) && var_0._id_039B == "wall") {
          var_10.angles = (270, var_0.angles[1], 90);
        } else {
          var_10.angles = (0, var_0.angles[1], 0);
        }
      } else if(var_3 == "equip_c4" || var_3 == "equip_thermite" || var_3 == "equip_throwing_knife") {
        if(isDefined(var_0._id_039B) && var_0._id_039B == "wall") {
          var_10.angles = (180, var_0.angles[1], 180);
        } else {
          var_10.angles = (0, var_0.angles[1], 90);
        }
      } else {
        var_10.angles = (0, 90, 0);
        var_10.origin = var_10.origin + (0, 0, 2);
      }
    } else
      var_10.angles = (0, 0, 90);

    var_11 = 96;
    var_12 = 96;
    var_13 = var_10 _id_6A11(var_3);
    var_14 = var_10 _id_6A10(var_3);
    var_10.equipment = var_3;
    var_10 makeuseable();
    var_10 _meth_84D7("tag_origin");
    var_10 setcursorhint("HINT_BUTTON");
    var_10 _meth_84DA(var_14);
    var_10 setuseholdduration("duration_short");
    var_10 _meth_84D1(1);
    var_10 sethintstring(var_13);
    var_10 _meth_83A1(0);
    var_10 _meth_84D4(var_12);
    var_10 sethintdisplayfov(120);
    var_10 setuserange(var_11);
    var_10 setusefov(210);
    var_10 _meth_84D9("hide");
    var_10 thread _id_ACD9(var_9, var_3);

    if(istrue(level._id_DFBF)) {
      var_10 thread _id_10BFE(var_0, var_8);
      var_10._id_0481 = "dropped_weapon";
      return;
    }

    var_10 thread _id_10ADE();
    var_10._id_0481 = "dropped_equipment";
    return;
  } else {
    var_15 = undefined;
    var_15 = scripts\mp\utility\weapon::getweaponrootname(var_3);
    var_16 = [];

    if(istrue(level._id_E3C8)) {
      var_17 = var_1._id_10DB5;
    } else {
      var_17 = scripts\mp\class::buildweapon(var_15, var_16, "none", "none", -1);
    }

    var_18 = getcompleteweaponname(var_17);
    var_19 = spawn("weapon_" + var_18, var_4, 17);
    var_19 _meth_84D4(96);
    var_19 setuserange(96);
    var_19 setuseholdduration("duration_short");
    var_19 setusefov(210);
    var_19._id_0481 = "dropped_weapon";
    var_19.objweapon = var_17;

    if(isDefined(var_0._id_039B) && var_0._id_039B == "wall") {
      var_20 = anglestoright(var_0.angles);
      var_21 = vectornormalize(var_20) * 30;
      var_5 = var_0.origin + var_21 + (0, 0, 16);
      var_6 = var_0.origin + var_21 + (0, 0, -100);
      var_7 = scripts\engine\trace::ray_trace(var_5, var_6, undefined, scripts\engine\trace::_id_3EF6(1));
      var_22 = var_0.origin;

      if(var_7["fraction"] < 1.0) {
        var_22 = var_7["position"];
      }

      var_19._id_288D = var_22;
    }

    _id_9A37(var_19, var_18);

    if(isDefined(var_0.angles)) {
      var_19.angles = var_0.angles;
    } else {
      var_19.angles = (0, 0, 90);
    }

    var_19 thread _id_AD06();
    var_19 thread _id_10BCF();
  }
}

_id_5BFB(var_0) {
  if(level.mapname == "mp_m_speedball") {
    if(var_0._id_CD99 == "3" && distance(var_0.origin, (-488.2, -399.9, 54.25)) < 10) {
      var_0.origin = (-488.2, -409.9, 54.25);
    } else if(var_0._id_CD99 == "5" && distance(var_0.origin, (657.3, 644.6, 56)) < 10) {
      var_0.origin = (665.3, 644.6, 56);
    }
  }

  return var_0.origin;
}

_id_6A13(var_0) {
  switch (var_0) {
    case "equip_frag":
      return "offhand_wm_grenade_mike67";
    case "equip_semtex":
      return "offhand_wm_grenade_semtex";
    case "equip_c4":
      return "offhand_wm_c4";
    case "equip_claymore":
      return "offhand_wm_claymore_held";
    case "equip_at_mine":
      return "offhand_wm_at_mine";
    case "equip_throwing_knife":
      return "weapon_wm_me_soscar_knife_offhand_thrown";
    case "equip_molotov":
      return "offhand_wm_molotov";
    case "equip_thermite":
      return "offhand_wm_grenade_thermite";
    case "equip_flash":
      return "offhand_wm_grenade_flash";
    case "equip_snapshot_grenade":
      return "offhand_wm_grenade_snapshot_mp";
    case "equip_smoke":
      return "offhand_wm_grenade_smoke";
    case "equip_concussion":
      return "offhand_wm_grenade_concussion";
    case "equip_decoy":
      return "offhand_wm_grenade_decoy";
    case "equip_adrenaline":
      return "offhand_wm_stim";
    case "equip_snowball":
      return "weapon_wm_snowball";
    case "equip_pball":
      return "weapon_wm_snowball";
    case "equip_sticky_grenade":
      return "wm_leta_eng_sticky_n74_post";
    default:
      return "";
  }
}

_id_6A11(var_0) {
  switch (var_0) {
    case "equip_frag":
      self._id_5596 = "primary";
      return &"MP_INGAME_ONLY/PICKUP_FRAG";
    case "equip_semtex":
      self._id_5596 = "primary";
      return &"MP_INGAME_ONLY/PICKUP_SEMTEX";
    case "equip_c4":
      self._id_5596 = "primary";
      return &"MP_INGAME_ONLY/PICKUP_C4";
    case "equip_claymore":
      self._id_5596 = "primary";
      return &"MP_INGAME_ONLY/PICKUP_CLAYMORE";
    case "equip_at_mine":
      self._id_5596 = "primary";
      return &"MP_INGAME_ONLY/PICKUP_ATMINE";
    case "equip_throwing_knife":
      self._id_5596 = "primary";
      return &"MP_INGAME_ONLY/PICKUP_TKNIFE";
    case "equip_molotov":
      self._id_5596 = "primary";
      return &"MP_INGAME_ONLY/PICKUP_MOLOTOV";
    case "equip_thermite":
      self._id_5596 = "primary";
      return &"MP_INGAME_ONLY/PICKUP_THERMITE";
    case "equip_sticky_grenade":
      self._id_5596 = "primary";
      return &"MP_INGAME_ONLY/PICKUP_STICKY_GRENADE";
    case "equip_snowball":
      self._id_5596 = "primary";
      return &"MP_INGAME_ONLY/PICKUP_SNOWBALL";
    case "equip_pball":
      self._id_5596 = "secondary";
      return &"MP_INGAME_ONLY/PICKUP_PBALL";
    case "equip_flash":
      self._id_5596 = "secondary";
      return &"MP_INGAME_ONLY/PICKUP_FLASH";
    case "equip_snapshot_grenade":
      self._id_5596 = "secondary";
      return &"MP_INGAME_ONLY/PICKUP_SNAPSHOT";
    case "equip_smoke":
      self._id_5596 = "secondary";
      return &"MP_INGAME_ONLY/PICKUP_SMOKE";
    case "equip_concussion":
      self._id_5596 = "secondary";
      return &"MP_INGAME_ONLY/PICKUP_STUN";
    case "equip_decoy":
      self._id_5596 = "secondary";
      return &"MP_INGAME_ONLY/PICKUP_DECOY";
    case "equip_adrenaline":
      self._id_5596 = "secondary";
      return &"MP_INGAME_ONLY/PICKUP_STIM";
    default:
      return "";
  }
}

_id_6A10(var_0) {
  var_1 = "mp/arenaGGWeapons.csv";
  var_2 = _func_0222(var_1, 0, var_0, 3);
  return var_2;
}

_id_9A37(var_0, var_1) {
  var_2 = weaponclipsize(var_1);
  var_3 = 0;

  if(level._id_992A != 3) {
    var_4 = !level._id_992A;

    if(var_4) {
      var_2 = 0;
      var_3 = 0;
    } else
      var_3 = level._id_992A - 1;

    if(level._id_992A == 7) {
      var_3 = weaponmaxammo(var_1);
    } else {
      var_3 = var_2 * var_3;
    }
  } else
    var_3 = var_2 * 2;

  var_0 _meth_81F6(var_2, var_3);
}

_id_10ADE() {
  self endon("death");
  self waittill("trigger", var_0, var_1);
  var_2 = 0;
  var_3 = _id_3523(var_0);
  var_4 = _id_3535(var_0);
  var_5 = var_0 scripts\mp\equipment::_id_6A12(self.equipment);
  var_6 = _id_34F1(var_0);

  if(var_3) {
    if(var_4 == var_5) {
      var_2 = 1;
    }
  }

  if(var_3 && !var_2) {
    var_0 scripts\mp\equipment::incrementequipmentammo(self.equipment, 1);
  } else if(var_6 && !var_3) {
    var_0 _id_5040(var_0 scripts\mp\equipment::_id_69A4(self._id_5596));
  }

  if(!var_3) {
    var_0 scripts\mp\equipment::giveequipment(self.equipment, self._id_5596);
  }

  if(var_3 && var_2) {
    var_0 iprintlnbold(&"MP_INGAME_ONLY/EQUIPMENT_MAXED");
    thread _id_10ADE();
  } else {
    var_0 playsoundtoplayer("scavenger_pack_pickup", var_0, var_0);
    _id_3995();
    self makeunusable();
    self delete();
  }
}

_id_3535(var_0) {
  return var_0 scripts\mp\equipment::_id_6A0F(self.equipment);
}

_id_34F1(var_0) {
  var_1 = var_0 scripts\mp\equipment::_id_69A4(self._id_5596);

  if(isDefined(var_1)) {
    return var_0 scripts\mp\equipment::_id_6A0F(var_1);
  } else {
    return 0;
  }
}

_id_3523(var_0) {
  var_1 = var_0 scripts\mp\equipment::_id_69A4(self._id_5596);

  if(isDefined(var_1)) {
    return self.equipment == var_1;
  } else {
    return 0;
  }
}

_id_5040(var_0) {
  _id_E3A7(self, var_0, 1);
}

_id_10BCF() {
  self endon("death");
  self waittill("trigger", var_0, var_1);
  _id_3995();

  if(isDefined(var_1)) {
    var_1 _meth_84D4(96);
    var_1 setuserange(96);
    var_1 setuseholdduration("duration_short");
    var_1 thread _id_AD06();
    var_1 thread _id_10BCF();
  }
}

_id_FC03(var_0) {
  if(game["roundsPlayed"] == 0) {
    _id_2EA4(var_0);
    game["arenaRandomLoadoutIndex"] = 0;
  }
}

_id_2EA4(var_0) {
  game["arenaRandomLoadout"] = [];
  var_1 = [];
  var_2 = "mp/classTable_arena.csv";

  if(var_0) {
    var_3 = [14, 24, 12, 29, 1, 8, 31, 34, 10, 2];
  } else {
    var_3 = [2, 10, 34, 31, 8, 1, 29, 12, 24, 14];
  }

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_1[var_1.size] = _id_FCAC(var_2, var_3[var_4]);
  }

  game["arenaRandomLoadout"] = var_1;
}

_id_D53E() {
  var_0 = undefined;

  if(!isDefined(self.pers["team"])) {
    var_1 = "allies";
  } else {
    var_1 = scripts\mp\utility\game::_id_6BE2(self.pers["team"])[0];
  }

  foreach(var_3 in level.players) {
    if(var_3.team == var_1) {
      var_0 = var_3;
      break;
    }
  }

  if(!isDefined(var_0)) {
    var_0 = self;
  }

  var_5 = "mp/arenaGGWeapons.csv";
  self setclientomnvar("ui_arena_en_primary", -1);
  self setclientomnvar("ui_arena_en_secondary", -1);
  self setclientomnvar("ui_arena_en_lethal", -1);
  self setclientomnvar("ui_arena_en_tactical", -1);
  var_6 = int(_func_0222(var_5, 0, var_0.pers["gamemodeLoadout"]["loadoutPrimary"], 1));
  self setclientomnvar("ui_arena_en_primary", var_6);
  var_7 = int(_func_0222(var_5, 0, var_0.pers["gamemodeLoadout"]["loadoutSecondary"], 1));
  self setclientomnvar("ui_arena_en_secondary", var_7);
  var_8 = int(_func_0222(var_5, 0, var_0.pers["gamemodeLoadout"]["loadoutEquipmentPrimary"], 1));
  self setclientomnvar("ui_arena_en_lethal", var_8);
  var_9 = int(_func_0222(var_5, 0, var_0.pers["gamemodeLoadout"]["loadoutEquipmentSecondary"], 1));
  self setclientomnvar("ui_arena_en_tactical", var_9);
}

_id_6A89(var_0) {
  var_1 = 0;

  if(game["roundsPlayed"] == 0) {
    var_1 = 0;
  } else if(_id_8887()) {
    var_1 = game["roundsWon"][var_0.pers["team"]];
  } else {
    var_1 = game["roundsWon"][scripts\mp\utility\game::_id_6BE2(var_0.pers["team"])[0]];
  }

  return var_1;
}

_id_6A8A(var_0, var_1) {
  var_2 = 0;

  if(_id_8887()) {
    var_2 = game["roundsWon"][var_0.pers["team"]];

    if(isDefined(var_1) && var_1 == var_0.pers["team"]) {
      var_2 = var_2 + 1;
    }
  } else {
    var_2 = game["roundsWon"][scripts\mp\utility\game::_id_6BE2(var_0.pers["team"])[0]];

    if(isDefined(var_1) && var_1 == scripts\mp\utility\game::_id_6BE2(var_0.pers["team"])[0]) {
      var_2 = var_2 + 1;
    }
  }

  return var_2;
}

_id_D53F(var_0) {
  foreach(var_2 in level.players) {
    var_3 = undefined;

    if(!isDefined(var_2.pers["team"])) {
      var_4 = "allies";
    } else {
      var_4 = scripts\mp\utility\game::_id_6BE2(var_2.pers["team"])[0];
    }

    foreach(var_6 in level.players) {
      if(var_6.team == var_4) {
        var_3 = var_6;
        break;
      }
    }

    if(!isDefined(var_3)) {
      var_3 = var_2;
    }

    var_3.pers["gamemodeLoadout"] = game["arenaRandomLoadout"][_id_6A8A(var_3, var_0)];
    var_8 = "mp/arenaGGWeapons.csv";
    var_2 setclientomnvar("ui_arena_en_primary", -1);
    var_2 setclientomnvar("ui_arena_en_secondary", -1);
    var_2 setclientomnvar("ui_arena_en_lethal", -1);
    var_2 setclientomnvar("ui_arena_en_tactical", -1);
    var_9 = int(_func_0222(var_8, 0, var_3.pers["gamemodeLoadout"]["loadoutPrimary"], 1));
    var_2 setclientomnvar("ui_arena_en_primary", var_9);
    var_10 = int(_func_0222(var_8, 0, var_3.pers["gamemodeLoadout"]["loadoutSecondary"], 1));
    var_2 setclientomnvar("ui_arena_en_secondary", var_10);
    var_11 = int(_func_0222(var_8, 0, var_3.pers["gamemodeLoadout"]["loadoutEquipmentPrimary"], 1));
    var_2 setclientomnvar("ui_arena_en_lethal", var_11);
    var_12 = int(_func_0222(var_8, 0, var_3.pers["gamemodeLoadout"]["loadoutEquipmentSecondary"], 1));
    var_2 setclientomnvar("ui_arena_en_tactical", var_12);
  }
}

_id_E2F3(var_0) {
  var_1 = getEntArray("flag_arena", "targetname");

  if(!isDefined(var_1[0])) {
    return;
  }
  level._id_1AA6 = var_1[0];
  var_2 = var_1[0];

  if(isDefined(var_2.target)) {
    var_3[0] = getent(var_2.target, "targetname");
  } else {
    var_3[0] = spawn("script_model", var_2.origin);
    var_3[0].angles = var_2.angles;
  }

  var_2._id_A8E1 = "_a";
  var_2._id_7C73 = "_a";
  var_1 = scripts\mp\gametypes\obj_dom::_id_D896(var_2, "neutral", undefined, 1);
  var_1._id_ABCB = ::_id_1AAA;
  var_1._id_AA79 = ::_id_1AAB;
  var_1._id_AAC2 = ::_id_1AAC;
  var_1._id_ABD4 = ::_id_1AAD;
  var_1._id_AA8D = ::_id_1AA9;
  var_1._id_875C = 1;
  var_1 _id_07D6::_id_B0E7();
  var_1._id_7C8C = "domFlag";
  var_1._id_03A9 delete();
  var_1 _id_07D6::_id_D4B2("persistent");
  var_1._id_7D35 = 1;
  level._id_A8E8[var_1._id_A8E1] = var_1;
  level._id_1AA6 = var_1;

  if(istrue(var_0)) {
    wait 0.1;
    level._id_1AA6 _id_07D6::_id_C579(1, 1, undefined, 0, 0);
    level._id_1AA6._id_1041A = "any";
    level._id_1AA6 _id_07D6::_id_D61B("icon_waypoint_ot");
    level._id_1AA6 thread _id_4780();
    level thread _id_DCA9();
  } else {
    level._id_1AA6 _id_07D6::_id_C579(1, 1, undefined, 0, 0);
    level._id_1AA6 _id_4AD6();
  }
}

_id_DCA9() {
  waitframe();

  if(isDefined(level._id_1AA6) && isDefined(level._id_1AA6._id_5C3F)) {
    level._id_1AA6._id_5C3F._id_ACC9 = scripts\mp\utility\outline::_id_ACCF(level._id_1AA6._id_5C3F, "outline_nodepth_orange", "level_script");
  }

  level thread _id_C4A0();
}

_id_1AAB(var_0) {
  var_0._id_87A3 = 1;
  level._id_31B5 = 0;
  var_1 = _id_07D6::_id_6C02();

  if(var_1 == "neutral") {
    var_0 setclientomnvar("ui_objective_state", 1);
  }

  self._id_A436 = istrue(level._id_5C41) && var_1 != "neutral";
  self._id_B801 = 1;

  if(!istrue(self._id_A435)) {
    self._id_497A = 0;
  }

  var_2 = scripts\engine\utility::ter_op(istrue(level._id_5C41), level._id_5C3B * 0.5, level._id_5C3B);
  _id_07D6::_id_D8D2(var_2);

  if(istrue(level._id_322C)) {
    thread _id_07D6::_id_FE93(var_0.team);
  }

  if(var_2 > 0) {
    self._id_BC52 = scripts\mp\utility\game::_id_6BE2(var_0.team)[0];
    scripts\mp\gametypes\obj_dom::_id_FC63(var_0.team);
    _id_07D6::_id_D61B(level._id_7C87, level._id_7C6F);
  }
}

_id_1AAD(var_0, var_1, var_2, var_3) {
  var_4 = _id_07D6::_id_6C02();

  if(var_1 > 0.05 && var_2 && !self._id_497A) {
    if(var_4 == "neutral") {
      if(level._id_5C3B > 0.05) {
        _id_0A8D::_id_E775("securing_flag", var_0);
        var_5 = scripts\mp\utility\game::_id_6BE2(var_0)[0];
        _id_0A8D::_id_E775("losing_flag", var_5);
      }
    } else if(level._id_5C3B > 0.05) {
      _id_0A8D::_id_E775("securing_flag", var_0);
      _id_0A8D::_id_E775("losing_flag", var_4);
    }

    self._id_497A = 1;
  }
}

_id_1AAC(var_0, var_1, var_2) {
  level._id_31B5 = 1;
  self._id_497A = 0;

  if(var_2) {
    _id_07F9::_id_A8C4(self._id_A908, 0);
  }

  if(isPlayer(var_1)) {
    var_1._id_87A3 = 0;
    var_1 setclientomnvar("ui_objective_state", 0);
    var_1._id_F90E = undefined;
  }

  var_3 = _id_07D6::_id_6C02();

  if(var_3 == "neutral") {
    _id_07D6::_id_D61B(level._id_7C74);
    thread scripts\mp\gametypes\obj_dom::_id_FC64("idle", 0);
  } else {
    _id_07D6::_id_D61B(level._id_7C4B, level._id_7C42);
    thread scripts\mp\gametypes\obj_dom::_id_FC64(var_3, 0);
  }

  if(!var_2) {
    self._id_A435 = 0;
  }
}

_id_1AAA(var_0) {
  level._id_31B5 = 1;
  var_1 = var_0.team;
  var_2 = _id_07D6::_id_6C02();
  var_3 = scripts\mp\utility\game::_id_6BE2(var_1)[0];
  _id_07F9::_id_A8B4(self._id_A908, 0);
  _id_07F9::_id_A8C4(self._id_A908, 0);
  self._id_3235 = gettime();
  self._id_A435 = 0;
  _id_0A8D::_id_E775("lost" + self._id_A8E1, var_3);
  _id_0A8D::_id_E775("secured" + self._id_A8E1, var_1);
  thread scripts\mp\utility\print::_id_BD0C(var_1, var_3, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", var_0);
  scripts\mp\gametypes\obj_dom::_id_4D53(var_1, var_0);

  if(!self._id_A435) {
    var_4 = 3;

    if(self._id_A8E1 == "_a") {
      var_4 = 1;
    } else if(self._id_A8E1 == "_b") {
      var_4 = 2;
    }

    if(isDefined(level._id_AB42)) {
      [[level._id_AB42]]("dompoint", self._id_A8E1, var_0, var_1, var_2, self);
    }

    self._id_5BC6 = 0;
  }

  game["dialog"]["round_success"] = "gamestate_win_capture";
  game["dialog"]["round_failure"] = "gamestate_lost_capture";
  level thread _id_1A64(var_0.team, game["end_reason"]["arena_otflag_completed"], game["end_reason"]["arena_otflag_failed"]);
}

_id_1AA9() {
  _id_07D6::_id_D61B(level._id_7C48);
  _id_07F9::_id_A8B6(self._id_A908, undefined);
  thread scripts\mp\gametypes\obj_dom::_id_FC64("contested", 0);
  level thread _id_5EA5();
}

_id_5EA5() {
  level notify("start_overtime_timeout");
  level endon("start_overtime_timeout");
  level endon("game_ended");

  if(!isDefined(level._id_ACA1)) {
    level._id_ACA1 = 0;
  }

  while(level._id_ACA1 < 5000) {
    wait(level._id_5F3A);
    level._id_ACA1 = level._id_ACA1 + level._id_01E2;
  }

  level._id_31B5 = 1;
}

_id_4AD6() {
  _id_07D6::_id_15DF("none");
  _id_07D6::_id_4AD1();

  if(isDefined(self._id_03A9)) {
    self._id_03A9 delete();
  }

  self._id_5C3F hide();
}

_id_C4A0() {
  level waittill("game_ended");

  if(isDefined(level._id_1AA6) && isDefined(level._id_1AA6._id_5C3F._id_ACC9)) {
    scripts\mp\utility\outline::outlinedisable(level._id_1AA6._id_5C3F._id_ACC9, level._id_1AA6._id_5C3F);
  }
}

_id_4780() {
  level scripts\engine\utility::waittill_any_2("prematch_done", "start_mode_setup");
  _id_4AD6();
}

_id_D868() {
  if(level.mapname == "mp_shipment") {
    level._id_1DD5 = getEntArray("flag_goal_defender", "targetname");
    level._id_461C = getEntArray("flag_goal_attackers", "targetname");
  } else {
    level._id_1DD5 = getEntArray("flag_goal_attacker", "targetname");
    level._id_461C = getEntArray("flag_goal_defender", "targetname");
  }

  level._id_1DD5 = level._id_1DD5[0] _id_3FC6(game["attackers"]);
  level._id_461C = level._id_461C[0] _id_3FC6(game["defenders"]);
  level._id_A8E8["_b"] = level._id_1DD5;
  level._id_A8E8["_c"] = level._id_461C;
}

_id_3FC6(var_0) {
  if(isDefined(self.target)) {
    var_1[0] = getent(self.target, "targetname");
  } else {
    var_1[0] = spawn("script_model", self.origin);
    var_1[0].angles = self.angles;
  }

  level._id_5C3B = scripts\mp\utility\dvars::_id_509A("#x328f66aefdd04dd", 10, 0, 30);

  if(isDefined(self._id_A8E1)) {
    var_2 = self._id_A8E1;
  } else if(self._id_0481 == "flag_goal_attacker") {
    var_2 = "_b";
  } else {
    var_2 = "_c";
  }

  var_3 = undefined;
  var_4 = _id_07D6::_id_406E(var_0, self, var_1, (0, 0, 100));
  var_4.team = var_0;
  var_4._id_ADAE = var_0;
  var_4 _id_07D6::_id_D61B(level._id_7C4C, level._id_7C43);
  var_4 _id_07D6::_id_15DF("enemy");
  var_4 _id_07D6::_id_316A(1);
  var_4 _id_07D6::_id_D8D2(level._id_5C3B);
  var_4._id_ABCB = ::_id_5358;
  var_4._id_AA79 = ::_id_5359;
  var_4._id_AAC2 = ::_id_535A;
  var_4._id_AA8D = ::_id_5356;
  var_4._id_ABC7 = ::_id_5357;
  var_4._id_875C = 1;
  var_4 _id_07D6::_id_B0E7();
  var_4._id_7C8C = "domFlag";

  if(isDefined(level._id_3236)) {
    var_4 _id_07D6::_id_D4B2(_id_694D());
  }

  var_4._id_A8E1 = var_2;
  var_4._id_7C73 = var_3;
  var_4 _id_07D6::_id_D8E0("any");
  var_4._id_E86E = ::_id_535C;
  var_4._id_A6C4 = 1;
  var_4._id_37F3 = level._id_5C3B * 1000;
  var_5 = var_1[0].origin + (0, 0, 32);
  var_6 = var_1[0].origin + (0, 0, -32);
  var_7 = scripts\engine\trace::_id_3EE5(1, 1, 1, 1, 0, 1, 1);
  var_8 = [];
  var_9 = scripts\engine\trace::ray_trace(var_5, var_6, var_8, var_7);
  var_4._id_22B7 = var_9["position"];
  var_10 = vectortoangles(var_9["normal"]);
  var_4._id_22B6 = anglesToForward(var_10);
  var_11 = spawn("script_model", var_4._id_22B7);
  var_11 setModel("dom_flag_scriptable");
  var_11.angles = _func_030A(var_4._id_22B6, var_11.angles);
  var_4._id_03A9 = var_11;
  var_4._id_103BF = "";

  if(isDefined(var_4.trigger._id_0359)) {
    if(var_4.trigger._id_0359 == 160) {
      var_4._id_103BF = "_160";
    } else if(var_4.trigger._id_0359 == 90) {
      var_4._id_103BF = "_90";
    } else if(var_4.trigger._id_0359 == 315) {
      var_4._id_103BF = "_300";
    } else if(var_4.trigger._id_0359 != 120) {
      var_4._id_A5D5 = 1;
    }
  }

  var_4._id_5C3F = spawn("script_model", var_4._id_22B7);
  var_4._id_5C3F setModel("military_dom_flag_neutral");
  var_4._id_ACD6 = var_4._id_5C3F;
  return var_4;
}

_id_5359(var_0) {
  var_0._id_87A3 = 1;
  level._id_31B5 = 0;
  var_1 = _id_07D6::_id_6C02();

  if(var_1 == "neutral") {
    var_0 setclientomnvar("ui_objective_state", 1);
  }

  self._id_A436 = istrue(level._id_5C41) && var_1 != "neutral";

  if(!istrue(self._id_A435)) {
    self._id_497A = 0;
  }

  var_2 = scripts\engine\utility::ter_op(istrue(level._id_5C41), level._id_5C3B * 0.5, level._id_5C3B);
  _id_07D6::_id_D8D2(var_2);

  if(istrue(level._id_322C)) {
    thread _id_07D6::_id_FE93(var_0.team);
  }

  if(var_2 > 0) {
    self._id_BC52 = scripts\mp\utility\game::_id_6BE2(var_0.team)[0];
    scripts\mp\gametypes\obj_dom::_id_FC63(var_0.team);
    _id_07D6::_id_D61B(level._id_7C88, level._id_7C70);
  }
}

_id_535A(var_0, var_1, var_2) {
  level._id_31B5 = 1;

  if(var_2) {
    _id_07F9::_id_A8C4(self._id_A908, 0);
  }

  if(isPlayer(var_1)) {
    var_1._id_87A3 = 0;
    var_1 setclientomnvar("ui_objective_state", 0);
    var_1._id_F90E = undefined;
  }

  var_3 = _id_07D6::_id_6C02();
  _id_07D6::_id_D61B(level._id_7C4C, level._id_7C43);

  if(!var_2) {
    self._id_A435 = 0;
  }
}

_id_5358(var_0) {
  level._id_31B5 = 1;
  var_1 = var_0.team;
  var_2 = _id_07D6::_id_6C02();
  var_3 = scripts\mp\utility\game::_id_6BE2(var_1)[0];
  _id_07F9::_id_A8B4(self._id_A908, 0);
  _id_07F9::_id_A8C4(self._id_A908, 0);
  self._id_3235 = gettime();
  self._id_A435 = 0;
  thread scripts\mp\utility\print::_id_BD0C(var_1, var_3, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", var_0);
  _id_535B(var_1, var_0);

  if(!self._id_A435) {
    if(isDefined(level._id_AB42)) {
      [[level._id_AB42]]("dompoint", self._id_A8E1, var_0, var_1, var_2, self);
    }
  }

  level thread _id_1A64(var_0.team, game["end_reason"]["objective_completed"], undefined, 0, 2);
}

_id_5356() {
  _id_07D6::_id_D61B(level._id_7C49);
  _id_07F9::_id_A8B6(self._id_A908, undefined);
}

_id_5357(var_0) {
  var_1 = _id_07D6::_id_6C02();
  _id_07D6::_id_D61B(level._id_7C4C, level._id_7C43);
  self._id_BD7B = 1;
}

_id_535B(var_0, var_1) {
  _id_07D6::_id_D639(var_0);
  self notify("capture", var_1);
  self notify("assault", var_1);
  _id_07D6::_id_D61B(level._id_7C4C, level._id_7C43);
  self._id_A435 = 0;

  if(self._id_F396[var_0].size == 0) {
    self._id_F396 = self._id_AA3C;
  }

  thread _id_6F9A(self._id_F396[var_0], var_1);

  if(isDefined(level._id_9BDA)) {
    [[level._id_9BDA]](self._id_979C, undefined, self._id_9791, self._id_10430[0].origin[0], self._id_10430[0].origin[1], gettime(), scripts\engine\utility::ter_op(var_0 == "allies", 1, 2));
  }

  _id_07A9::_id_976A(self._id_176A, self._id_1769, self._id_10430[0].origin, -1, "captured_" + var_0);
}

_id_535C(var_0) {
  var_0 thread scripts\mp\rank::_id_CC00("defend");
  var_0 thread _id_07B1::_id_6FB9("mode_x_defend");
}

_id_694D() {
  var_0 = "normal";

  if(level._id_3236 == 2) {
    var_0 = "neutralize";
  } else if(level._id_3236 == 3) {
    var_0 = "persistent";
  }

  return var_0;
}

_id_6F9A(var_0, var_1) {
  level endon("game_ended");
  var_2 = var_1;

  if(isDefined(var_2.owner)) {
    var_2 = var_2.owner;
  }

  level._id_8FA1 = gettime();

  if(isPlayer(var_2)) {
    level thread scripts\mp\hud_util::_id_EF8D("callout_securedposition", var_2);
    var_3 = spawnStruct();
    var_3.player = var_2;
    var_3._id_56B9 = "capture";
    var_3._id_033E = var_2.origin;
    _id_06E2::_id_4C2A("callback_on_game_event", var_3);
  }

  var_4 = getarraykeys(var_0);

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_6 = var_0[var_4[var_5]].player;

    if(isDefined(var_6.owner)) {
      var_6 = var_6.owner;
    }

    if(!isPlayer(var_6)) {
      continue;
    }
    var_6 scripts\mp\utility\stats::_id_7DAE("captures", 1);
    var_6 scripts\mp\persistence::_id_E770("round", "captures", var_6.pers["captures"]);
    var_6 thread scripts\mp\rank::_id_CC00("capture");
    var_6 thread _id_07B1::_id_6FB9("mode_dom_secure");
    wait 0.05;
  }
}

_id_E707() {
  if(level._id_A90F == 1) {
    foreach(var_1 in level._id_A8E8) {
      if(var_1._id_A8E1 != "_a") {
        var_1 _id_476A();
      }
    }
  }

  level._id_31B5 = 1;

  if(!isDefined(level._id_1AA6._id_A908)) {
    level._id_1AA6 _id_07D6::_id_C579(1, 1, undefined, 0, 0);
  }

  level._id_1AA6 _id_07D6::_id_D61B(level._id_7C74);
  level._id_1AA6 _id_07D6::_id_5260();
  level._id_1AA6 _id_07D6::_id_15DF("enemy");
  level._id_1AA6._id_5C3F show();

  if(level._id_E2EA) {
    game["dialog"]["overtime"] = "gamestate_overtime_flagspawn";
  }

  level thread _id_DB9F();
  level._id_1AA6._id_5C3F playSound("ui_mp_flag_spawned");
  scripts\mp\utility\game::_id_D5FA(10, "free");
  level thread _id_DCA9();

  if(istrue(level._id_DFBF)) {
    foreach(var_4 in level.players) {
      if(isalive(var_4)) {
        var_5 = var_4 scripts\mp\equipment::_id_69A4("primary");

        if(isDefined(var_5) && var_5 == "equip_snowball") {
          var_4 scripts\mp\equipment::incrementequipmentammo("equip_snowball", 10);
        } else if(!isDefined(var_5)) {
          var_4 scripts\mp\equipment::giveequipment("equip_snowball", "primary");
          var_4 scripts\mp\equipment::incrementequipmentammo("equip_snowball", 10);
        }
      }
    }
  }
}

_id_DB9F() {
  wait 0.15;

  if(istrue(level._id_1AA6._id_B801)) {
    return;
  }
  foreach(var_1 in level.players) {
    if(var_1 _meth_81E2() && !var_1 _meth_81E3()) {
      continue;
    }
    var_1 _id_0A8D::_id_9137("overtime");
  }
}

_id_476A() {
  self notify("monitor_flag_control");
  _id_07D6::_id_15DF("none");
  _id_07D6::_id_D8E0("none");
  _id_07D6::_id_C300();
  self.trigger = undefined;
  self notify("deleted");
  self._id_1041A = "none";

  if(isDefined(self._id_03A9)) {
    self._id_03A9 delete();
  }

  self._id_5C3F delete();
}

_id_4CE2(var_0) {}

_id_4CE6(var_0) {
  var_0.health = var_0.maxhealth;
  var_0 notify("healed");
}

_id_ACD4() {
  level endon("prematch_done");
  level endon("removeArenaOutlines");

  for(;;) {
    level waittill("spawned_player");
    waitframe();

    foreach(var_1 in level.players) {
      var_2 = var_1 getentitynumber();

      if(!isDefined(var_1._id_ACC6)) {
        if(!isDefined(level._id_0F52)) {
          level._id_0F52 = 1;
        } else {
          level._id_0F52++;
        }
      }

      foreach(var_4 in level.players) {
        if(var_4 != var_1 && var_4.team != var_1.team) {
          if(isDefined(var_1._id_ACC6)) {
            scripts\mp\utility\outline::outlinedisable(var_1._id_ACC6, var_1);
          }

          var_1._id_ACC6 = scripts\mp\utility\outline::_id_ACD2(var_1, var_4.team, "outline_nodepth_orange", "level_script");
          break;
        }
      }
    }
  }
}

_id_C497() {
  thread _id_A6B2();
  level scripts\engine\utility::waittill_any_2("prematch_done", "removeArenaOutlines");

  foreach(var_1 in level.players) {
    var_2 = var_1 getentitynumber();

    if(isDefined(var_1._id_ACC6)) {
      level._id_0F52--;
      scripts\mp\utility\outline::outlinedisable(var_1._id_ACC6, var_1);
      var_1._id_ACC6 = undefined;
    }
  }
}

_id_A6B2() {
  level endon("prematch_done");
  level waittill("match_start_real_countdown");

  if(level._id_BBAE > 5) {
    var_0 = int(max(level._id_BBAE - 5, 5));
  } else {
    var_0 = int(max(level._id_BBAE - 2, 2));
  }

  wait(var_0);
  level notify("removeArenaOutlines");
}

_id_ACD9(var_0, var_1) {
  self endon("death");
  self endon("trigger");
  self._id_ACCD = [];
  var_2 = level._id_2327[var_1];
  var_3 = _id_6BEE(var_2, var_1);

  for(;;) {
    foreach(var_5 in level.players) {
      if(isDefined(var_5._id_7539)) {
        var_6 = distance2dsquared(self.origin, var_5.origin);
        var_7 = var_5 getentitynumber();

        if(var_6 < 490000) {
          if(!isDefined(self._id_ACCD[var_7])) {
            if(!isDefined(level._id_0F52)) {
              level._id_0F52 = 1;
            } else {
              level._id_0F52++;
            }

            self._id_ACCD[var_7] = ::scripts\mp\utility\outline::outlineenableforplayer(self, var_5, var_3, "level_script");
          }
        } else if(isDefined(self._id_ACCD[var_7])) {
          level._id_0F52--;
          scripts\mp\utility\outline::outlinedisable(self._id_ACCD[var_7], self);
          self._id_ACCD[var_7] = undefined;
        }
      }
    }

    waitframe();
  }
}

_id_AD06() {
  self endon("death");
  self endon("trigger");
  self._id_ACCD = [];
  var_0 = scripts\mp\weapons::_id_6AD0();
  var_1 = scripts\mp\utility\weapon::getweaponrootname(var_0);
  var_2 = level._id_2327[var_1 + "_mp"];
  var_3 = _id_6BEE(var_2);

  for(;;) {
    foreach(var_5 in level.players) {
      if(isDefined(var_5._id_7539)) {
        var_6 = distance2dsquared(self.origin, var_5.origin);
        var_7 = var_5 getentitynumber();

        if(var_6 < 490000) {
          if(!isDefined(self._id_ACCD[var_7])) {
            if(!isDefined(level._id_0F52)) {
              level._id_0F52 = 1;
            } else {
              level._id_0F52++;
            }

            self._id_ACCD[var_7] = ::scripts\mp\utility\outline::outlineenableforplayer(self, var_5, var_3, "level_script");
          }
        } else if(isDefined(self._id_ACCD[var_7])) {
          level._id_0F52--;
          scripts\mp\utility\outline::outlinedisable(self._id_ACCD[var_7], self);
          self._id_ACCD[var_7] = undefined;
        }
      }
    }

    waitframe();
  }
}

_id_6BEE(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  var_2 = "white";
  var_3 = int(min(var_0, 8));

  switch (var_3) {
    case 0:
      var_2 = "outline_depth_white";
      break;
    case 1:
      var_2 = "outline_depth_green";
      break;
    case 2:
      var_2 = "outline_depth_cyan";
      break;
    case 3:
      var_2 = "outline_depth_red";
      break;
    case 4:
      var_2 = "outline_depth_orange";
      break;
    case 5:
      var_2 = "outline_depth_yellow";
      break;
    case 6:
      var_2 = "outline_depth_blue";
      break;
    case 7:
      var_2 = "outline_depth_green";
      break;
    case 8:
      var_2 = "outline_depth_red";
      break;
  }

  if(istrue(level._id_DFBF) && isDefined(var_1) && var_1 == "equip_pball") {
    var_2 = "outline_depth_yellow";
  }

  return var_2;
}

_id_3995() {
  foreach(var_2, var_1 in self._id_ACCD) {
    level._id_0F52--;
    scripts\mp\utility\outline::outlinedisable(var_1, self);
    var_1 = undefined;
  }
}

_id_D085() {
  level endon("prematch_ended");
  var_0 = undefined;
  var_1 = 0;

  while(isDefined(level._id_9BAA) && level._id_9BAA > 5) {
    var_2 = scripts\mp\utility\teams::_id_6A59(self.team, 1);

    if(var_2.size > 1) {
      var_1 = 1;
      break;
    }

    waitframe();
  }

  if(var_1) {
    var_3 = self.angles;
    var_4 = 0;
    var_5 = scripts\mp\utility\teams::_id_6DCA(self.team, "players");

    foreach(var_7 in var_5) {
      if(var_7 != self) {
        var_0 = var_7;
      }
    }

    var_9 = var_0.origin - self.origin;
    var_10 = self.origin - var_0.origin;
    var_11 = anglestoright(self.angles);
    var_12 = vectordot(var_11, var_9);
    var_13 = 0;
    var_14 = 0;

    if(var_12 < 0) {
      var_15 = 85;
      var_13 = 1;
    } else {
      var_15 = -90;
      var_14 = 1;
    }

    if(isDefined(var_0)) {
      if(var_13) {
        if(!isbot(self)) {
          wait 0.5;

          if(self._id_0133.basename != "none") {
            self _meth_84AF("ges_crush_turnleft");
          }
        }
      } else if(!isbot(self)) {
        wait 0.5;

        if(self._id_0133.basename != "none") {
          self _meth_84AF("ges_crush_turnright");
        }
      }

      wait 3;
      scripts\mp\utility\player::_freezecontrols(0);
      return;
    }

    scripts\mp\utility\player::_freezecontrols(0);
    return;
  } else
    scripts\mp\utility\player::_freezecontrols(0);
}

_id_FCC2() {
  level endon("game_ended");
  self setclientomnvar("ui_match_status_hint_text", 0);
}

_id_D5AD() {
  level._id_7C43 = "waypoint_capture_endzone";
  level._id_7C4C = "waypoint_defend_endzone";
  level._id_7C49 = "waypoint_contesting_endzone";
  level._id_7C88 = "waypoint_taking_endzone";
  level._id_7C70 = "waypoint_losing_endzone";
  level._id_7C74 = "waypoint_captureneutral";
  level._id_7C42 = "waypoint_capture";
  level._id_7C4B = "waypoint_defend";
  level._id_7C48 = "waypoint_contested";
  level._id_7C87 = "waypoint_taking";
  level._id_7C6F = "waypoint_losing";
  level._id_7C50 = "waypoint_defending";
}

_id_D8C5() {
  scripts\mp\gamelogic::_id_D8E5("waypoint_taking_endzone", 0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::_id_D8E5("waypoint_losing_endzone", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::_id_D8E5("waypoint_contesting_endzone", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::_id_D8E5("waypoint_capture_endzone", 0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::_id_D8E5("waypoint_defend_endzone", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_flag", 0);
  scripts\mp\gamelogic::_id_D8E5("icon_waypoint_dom_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::_id_D8E5("waypoint_taking_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_overtime", 1);
  scripts\mp\gamelogic::_id_D8E5("waypoint_capture_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::_id_D8E5("waypoint_defend_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::_id_D8E5("waypoint_defending_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::_id_D8E5("waypoint_blocking_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::_id_D8E5("waypoint_blocked_a", 0, "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::_id_D8E5("waypoint_losing_a", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_overtime", 1);
  scripts\mp\gamelogic::_id_D8E5("waypoint_captureneutral_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::_id_D8E5("waypoint_contested_a", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_overtime", 1);
  scripts\mp\gamelogic::_id_D8E5("waypoint_dom_target_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::_id_D8E5("icon_waypoint_target_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::_id_D8E5("icon_waypoint_ot_a", 1, "neutral", "MP_INGAME_ONLY/OBJ_OTFLAGLOC_CAPS", "icon_waypoint_overtime", 0);
  scripts\mp\gamelogic::_id_D8E5("waypoint_dogtags", 1, "enemy", "", "icon_minimap_dogtag", 0);
  scripts\mp\gamelogic::_id_D8E5("waypoint_dogtags_friendly", 1, "friendly", "", "icon_minimap_dogtag", 0);
}

_id_8950() {
  return level._id_1AB9 == 1;
}

_id_89E3() {
  return level._id_1AB9 == 2;
}

_id_897F() {
  return level._id_1AB9 == 3;
}

_id_8887() {
  return level._id_1AB9 == 4;
}

_id_8A0E() {
  return level._id_1AB9 == 5;
}

_id_89E5() {
  return level._id_1AB9 == 6;
}

_id_89E1() {
  return level._id_1AB9 == 7;
}

_id_89E7() {
  return level._id_1AB9 == 8;
}

_id_89E4() {
  return level._id_1AB9 == 9;
}

_id_89E6() {
  return level._id_1AB9 == 10;
}

_id_89E8() {
  return level._id_1AB9 == 11;
}

_id_89E2() {
  return level._id_1AB9 == 12;
}

_id_89DD() {
  switch (level._id_1AB9) {
    case 11:
    case 10:
    case 9:
    case 8:
    case 7:
      return 1;
    default:
      return 0;
  }
}

_id_DFBF() {
  if(istrue(game["practiceRound"]) || istrue(level._id_165E)) {
    level._id_91E0 = 0;
    _id_4636();
  }

  _id_82BC();
  thread _id_D8B0();
}

_id_D8B0() {
  level._id_1B00._id_04F6 = "equip_snowball";

  if(!istrue(level._id_165E) && !istrue(game["practiceRound"])) {
    level._id_1B00._id_04F6 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level._id_1B00._id_04F6, "equip_snowball");
    level._id_1B01._id_04F6 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level._id_1B01._id_04F6, "equip_snowball");
    level._id_1B02._id_04F6 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level._id_1B02._id_04F6, "equip_snowball");
    level._id_1B03._id_04F6 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level._id_1B03._id_04F6, "equip_snowball");
    level._id_1B04._id_04F6 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level._id_1B04._id_04F6, "equip_snowball");
    level._id_1B05._id_04F6 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level._id_1B05._id_04F6, "equip_snowball");
    level._id_1B06._id_04F6 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level._id_1B06._id_04F6, "equip_snowball");
    level._id_1B07._id_04F6 = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), level._id_1B07._id_04F6, "equip_snowball");
  }

  level._id_B069 = 0;
  var_0 = scripts\engine\utility::getstructarray("weapon_pickup", "targetname");

  foreach(var_2 in var_0) {
    if(istrue(level._id_165E) || istrue(game["practiceRound"]) || level._id_1AB9 != 3) {
      _id_E3A7(var_2, level._id_1B00);
      continue;
    }

    if(var_2._id_CD99 == "1") {
      _id_E3A7(var_2, level._id_1B00);
      continue;
    }

    if(var_2._id_CD99 == "2") {
      _id_E3A7(var_2, level._id_1B01);
      continue;
    }

    if(var_2._id_CD99 == "3") {
      _id_E3A7(var_2, level._id_1B02);
      continue;
    }

    if(var_2._id_CD99 == "4") {
      _id_E3A7(var_2, level._id_1B03);
      continue;
    }

    if(var_2._id_CD99 == "5") {
      _id_E3A7(var_2, level._id_1B04);
      continue;
    }

    if(var_2._id_CD99 == "6") {
      _id_E3A7(var_2, level._id_1B05);
      continue;
    }

    if(var_2._id_CD99 == "7") {
      _id_E3A7(var_2, level._id_1B06);
      continue;
    }

    if(var_2._id_CD99 == "8") {
      _id_E3A7(var_2, level._id_1B07);
    }
  }
}

_id_10BFE(var_0, var_1) {
  self endon("death");
  self waittill("trigger", var_2, var_3);
  var_4 = 0;
  var_5 = _id_3523(var_2);
  var_6 = _id_3535(var_2);

  if(self.equipment == "equip_snowball") {
    var_7 = 10;
  } else {
    var_7 = 1;
  }

  var_8 = _id_34F1(var_2);
  var_9 = 1;

  switch (var_1) {
    case "pile":
      var_9 = 10;
      break;
    case "pyramid":
      var_9 = 5;
      break;
    default:
      var_9 = 1;
      break;
  }

  if(var_5) {
    if(var_6 == var_7) {
      var_4 = 1;
    }
  }

  if(var_5 && !var_4) {
    var_2 scripts\mp\equipment::incrementequipmentammo(self.equipment, var_9);
  } else if(var_8 && !var_5 && !isPlayer(var_0)) {
    var_2 _id_5040(var_2 scripts\mp\equipment::_id_69A4(self._id_5596));
  }

  if(!var_5) {
    var_2 scripts\mp\equipment::giveequipment(self.equipment, self._id_5596);

    if(self.equipment == "equip_snowball" && !var_4) {
      var_2 scripts\mp\equipment::incrementequipmentammo(self.equipment, var_9);
    }
  }

  if(var_5 && var_4) {
    var_2 iprintlnbold(&"MP_INGAME_ONLY/EQUIPMENT_MAXED");
    thread _id_10ADE();
  } else {
    var_2 playsoundtoplayer("scavenger_pack_pickup", var_2, var_2);
    playFX(level._id_DFC2["vanish"], self.origin);
    _id_3995();

    if(!isPlayer(var_0)) {
      level thread _id_1086B(var_0);
    }

    self makeunusable();
    self delete();
  }
}

_id_1086B(var_0) {
  level endon("game_ended");
  wait 15;
  playFX(level._id_DFC2["vanish"], var_0.origin);
  _id_E3A7(var_0, level._id_1B00);
}

_id_DFC1() {
  level _id_07D1::_id_60C2("prematch_done");
  wait 1;
  self allowmelee(0);
}