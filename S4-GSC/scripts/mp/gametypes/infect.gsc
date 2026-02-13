/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\infect.gsc
*************************************************/

main() {
  _id_07DC::init();
  _id_07DC::_id_D854();
  level._id_8885 = getdvarint("#x35b3dde40d2401069", 0);
  var_0[0] = ::scripts\mp\utility\game::getgametype();

  if(istrue(level._id_8885)) {
    var_0[var_0.size] = "arm";
  }

  _id_07D6::main(var_0);

  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\dvars::_id_D633("scorelimit", 0);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
    level._id_A78B = 1;
    level._id_EBD4 = "s4_ar_stango44_mp";
  }

  _id_FC7D();
  level._id_5858 = 0;
  level._id_5859 = getdvarint("#x34ba12dcee0a59c32", 20);
  level._id_7D29 = 1;
  level._id_4971 = 0;
  thread _id_1086E();
  level.teambased = 1;
  level._id_EB9B = 0;
  level._id_4AB9 = 1;
  level._id_A543 = 1;
  level._id_ABAD = ::_id_ABAD;
  level.onplayerconnect = ::onplayerconnect;
  level._id_9FE8 = ::_id_ABA4;
  level._id_6D4A = ::_id_6D4A;
  level._id_AB70 = ::_id_AB70;
  level._id_AB3F = ::_id_AB3F;
  level._id_AAA3 = ::_id_AAA3;
  level._id_ABC0 = ::_id_ABC0;
  level._id_2DF4 = ::_id_1659;
  level._id_4A87 = 1;
  setomnvar("ui_killcam_copycat", 0);
  level._id_7E1A = getdvarint("#x323325f8c22ae38b5", 0);
  level._id_7E17 = getdvarint("#x3f6c7038218a34495", 0);
  level._id_AB25 = getdvarint("#x3bae8fc526aff4d3c", 0);

  if(level._id_8885) {
    var_1 = scripts\cp_mp\utility\game_utility::_id_6B2D();

    if(var_1 != "mp_aniyah") {
      _id_0797::_id_8251();
    }

    if(!isDefined(scripts\cp_mp\utility\game_utility::_id_6B18())) {
      switch (var_1) {
        case "mp_downtown_gw":
          setDvar("#x32a031d1e6464bda2", 6);
          break;
        case "mp_quarry2":
          setDvar("#x32a031d1e6464bda2", 5);
          break;
        case "mp_farms2":
        case "mp_farms2_gw":
          setDvar("#x32a031d1e6464bda2", 9);
          break;
        case "mp_port2_gw":
          setDvar("#x32a031d1e6464bda2", 3);
          break;
        case "mp_boneyard_gw":
          setDvar("#x32a031d1e6464bda2", 4);
          break;
        case "mp_aniyah":
          setDvar("#x32a031d1e6464bda2", 17);
          break;
        default:
          setDvar("#x32a031d1e6464bda2", 0);
      }
    }

    var_2 = 5000;

    switch (var_1) {
      case "mp_quarry2":
      case "mp_donetsk":
      case "mp_downtown_gw":
        var_2 = 5000;
        break;
      case "mp_port2_gw":
        var_2 = 4000;
        break;
      case "mp_farms2":
      case "mp_boneyard_gw":
      case "mp_farms2_gw":
        var_2 = 3000;
        break;
      default:
        var_2 = 5000;
    }

    level._id_7E22 = var_2;
    level._id_AFD8 = ::_id_AFD8;
  }

  game["dialog"]["gametype"] = "gametype_infected";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["boost"] = "boost_infected";
  game["dialog"]["offense_obj"] = "boost_infected";
  game["dialog"]["defense_obj"] = "boost_infected";
  game["dialog"]["infected_first"] = "infected_first";
  game["dialog"]["halfway_enemy_score"] = "infected_halfway_losing";
  game["dialog"]["halfway_friendly_score"] = "infected_halfway_friendly";
  game["dialog"]["infected_lastalive"] = "infected_lastalive";
}

_id_1086E() {
  self endon("game_ended");
  wait 1;

  if(isDefined(level._id_B7E2)) {
    _id_0804::_id_9A02("kdr");
  }
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3c6ec19e3b237f1cd", getmatchrulesdata("infectData", "numInitialInfected"));
  setdynamicdvar("#x3e89d649223c79cb3", getmatchrulesdata("infectData", "weaponSurvivorPrimary"));
  setdynamicdvar("#x36c2dfb917ede0dd7", getmatchrulesdata("infectData", "weaponSurvivorSecondary"));
  setdynamicdvar("#x35b4945255c6b6305", getmatchrulesdata("infectData", "lethalSurvivor"));
  setdynamicdvar("#x355f1809d34f7b4d6", getmatchrulesdata("infectData", "tacticalSurvivor"));
  setdynamicdvar("#x362b2553b95497026", getmatchrulesdata("infectData", "superSurvivor"));
  setdynamicdvar("#x33116ffd2a4cb2634", getmatchrulesdata("infectData", "superSurvivorTwo"));
  setdynamicdvar("#x3208c2fb57e753fca", getmatchrulesdata("infectData", "weaponInfectPrimary"));
  setdynamicdvar("#x372382f863cde8d36", getmatchrulesdata("infectData", "weaponInfectSecondary"));
  setdynamicdvar("#x3d57e8335badde242", getmatchrulesdata("infectData", "lethalInfect"));
  setdynamicdvar("#x3cf6edd0725242d89", getmatchrulesdata("infectData", "tacticalInfect"));
  setdynamicdvar("#x35412fbe4bf899c37", getmatchrulesdata("infectData", "weaponInitialPrimary"));
  setdynamicdvar("#x32702d81e659520d3", getmatchrulesdata("infectData", "weaponInitialSecondary"));
  setdynamicdvar("#x34961dc50af718c79", getmatchrulesdata("infectData", "superInfect"));
  setdynamicdvar("#x39e5e6794618acb3d", getmatchrulesdata("infectData", "superInfectTwo"));
  setdynamicdvar("#x3d5f2f031e7dd45d2", getmatchrulesdata("infectData", "infectExtraTimePerKill"));
  setdynamicdvar("#x3e156c6b0b72ca1aa", getmatchrulesdata("infectData", "survivorAliveScore"));
  setdynamicdvar("#x34e235602eae7bf92", getmatchrulesdata("infectData", "survivorScoreTime"));
  setdynamicdvar("#x3c7eb573afde1b0f", getmatchrulesdata("infectData", "survivorScorePerTick"));
  setdynamicdvar("#x3cb4017361d22e55", getmatchrulesdata("infectData", "infectStreakBonus"));
  setdynamicdvar("#x3fe2a7197af9f0ece", getmatchrulesdata("infectData", "enableInfectedTracker"));
  setdynamicdvar("#x3b33e778b6dfee24e", getmatchrulesdata("infectData", "enablePing"));
  setdynamicdvar("#x3a92a10ea6d74b2a6", getmatchrulesdata("infectData", "giveTKOnTISpawn"));
  setdynamicdvar("#x3ee6d1b6a4d407071", 0);
  setdynamicdvar("#x3ebcf050448a5d553", 0);
}

_id_ABAD() {
  setclientnamemode("auto_change");

  foreach(var_1 in level._id_EF89) {
    scripts\mp\utility\game::_id_D61C(var_1, &"OBJECTIVES/INFECT");

    if(level.splitscreen) {
      scripts\mp\utility\game::_id_D61A(var_1, &"OBJECTIVES/INFECT");
    } else {
      scripts\mp\utility\game::_id_D61A(var_1, &"OBJECTIVES/INFECT_SCORE");
    }

    scripts\mp\utility\game::_id_D615(var_1, &"OBJECTIVES/INFECT_HINT");
  }

  _id_8294();
  level._id_BEF6 = 1;
  level._id_25A8 = 1;
  level._id_7E08 = 0;
  level._id_7E11 = 0;
  level._id_B846 = 0;
  level._id_7E0C = 0;
  level._id_7E0B = 0;
  level._id_7E0A = 0;
  level._id_7E0D = 0;
  level._id_7E13["axis"] = 0;
  level._id_7E13["allies"] = 0;
  level._id_7E10 = [];

  if(istrue(level._id_8885)) {
    scripts\mp\gametypes\arm::_id_517D();
  }
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_A78B = scripts\mp\utility\dvars::_id_509C("numInitialInfected", 1, 1, 9);
  level._id_EBD4 = getDvar("#x3e89d649223c79cb3", "s4_ar_stango44");
  level._id_EBD8 = getDvar("#x36c2dfb917ede0dd7", "s4_pi_mike1911");
  level._id_EBD3 = getDvar("#x35b4945255c6b6305", "equip_claymore");
  level._id_EBDB = getDvar("#x355f1809d34f7b4d6", "equip_concussion");
  level._id_EBD9 = getDvar("#x362b2553b95497026", "super_tac_cover");
  level._id_EBDA = getDvar("#x33116ffd2a4cb2634", "none");
  level._id_7E1B = getDvar("#x3208c2fb57e753fca", "s4_me_knife");
  level._id_7E1D = getDvar("#x372382f863cde8d36", "s4_me_huggernaut");
  level._id_81F5 = getDvar("#x35412fbe4bf899c37", "s4_ar_stango44");
  level._id_81F6 = getDvar("#x32702d81e659520d3", "s4_pi_mike1911");
  level._id_7E19 = getDvar("#x3d57e8335badde242", "equip_throwing_knife");
  level._id_7E20 = getDvar("#x3cf6edd0725242d89", "equip_tac_insert");
  level._id_7E1E = getDvar("#x34961dc50af718c79", "super_deadsilence");
  level._id_7E1F = getDvar("#x39e5e6794618acb3d", scripts\engine\utility::ter_op(level._id_8885, "super_tac_insert", "none"));
  level._id_7E21 = scripts\mp\utility\dvars::_id_509A("infectExtraTimePerKill", 30, 0, 60);
  level._id_EBD2 = scripts\mp\utility\dvars::_id_509C("survivorAliveScore", 25, 0, 100);
  level._id_EBD7 = scripts\mp\utility\dvars::_id_509A("survivorScoreTime", 30, 0, 60);
  level._id_EBD6 = scripts\mp\utility\dvars::_id_509C("survivorScorePerTick", 50, 0, 100);
  level._id_7E23 = scripts\mp\utility\dvars::_id_509C("infectStreakBonus", 50, 0, 100);
  level._id_5256 = scripts\mp\utility\dvars::_id_509C("enableInfectedTracker", 0, 0, 1);
  level._id_5264 = scripts\mp\utility\dvars::_id_509C("enablePing", 0, 0, 1);
  level._id_7002 = scripts\mp\utility\dvars::_id_509C("giveTKOnTISpawn", 0, 0, 1);
  level._id_7E14 = getdvarint("#x323b5e9bb45b19d62", scripts\engine\utility::ter_op(level._id_8885, 150, 200));
  var_0 = scripts\cp_mp\utility\game_utility::_id_6B2D();

  if(issubstr(var_0, "mp_m_") && var_0 != "mp_m_speed") {
    level._id_EBD9 = _id_5BFE(0, 0);
    level._id_EBDA = _id_5BFE(0, 1);
    level._id_7E1E = _id_5BFE(1, 0);
    level._id_7E1F = _id_5BFE(1, 1);
  }

  if(level._id_EBD9 == level._id_EBDA) {
    level._id_EBDA = "none";
  } else if(level._id_EBD9 == "none" && level._id_EBDA != "none") {
    level._id_EBD9 = level._id_EBDA;
    level._id_EBDA = "none";
  }

  if(level._id_7E1E == level._id_7E1F) {
    level._id_7E1F = "none";
  } else if(level._id_7E1E == "none" && level._id_7E1F != "none") {
    level._id_7E1E = level._id_7E1F;
    level._id_7E1F = "none";
  }

  thread _id_2CFC();
}

_id_2CFC() {
  waitframe();

  if(level._id_AB25) {
    switch (level._id_EBD4) {
      default:
        level._id_1AB9 = 7;
        break;
    }

    scripts\mp\gametypes\arena::_id_2EAB();
    level._id_EBD4 = game["arenaRandomLoadout"][0]["loadoutPrimary"];
    level._id_EBD4 = level._id_EBD4 + "_mp";
    level._id_81F5 = game["arenaRandomLoadout"][0]["loadoutPrimary"];
    level._id_81F5 = level._id_81F5 + "_mp";
  }

  level._id_15F3 = [];
  level._id_15F3[level._id_15F3.size] = level._id_EBD4;
  level._id_15F3[level._id_15F3.size] = level._id_EBD8;
  level._id_15F3[level._id_15F3.size] = level._id_7E1B;
  level._id_15F3[level._id_15F3.size] = level._id_7E1D;
  level._id_15F3[level._id_15F3.size] = level._id_81F5;
  level._id_15F3[level._id_15F3.size] = level._id_81F6;
  level._id_EBD4 = _id_EA66(level._id_EBD4);
  level._id_EBD8 = _id_EA66(level._id_EBD8);
  level._id_7E1B = _id_EA66(level._id_7E1B);
  level._id_7E1D = _id_EA66(level._id_7E1D);
  level._id_81F5 = _id_EA66(level._id_81F5);
  level._id_81F6 = _id_EA66(level._id_81F6);

  foreach(var_1 in level._id_15F3) {
    if(var_1 != "none") {
      var_2 = scripts\mp\utility\weapon::getweaponrootname(var_1);
      var_3 = [];

      if(level._id_AB25) {
        if(var_1 == level._id_15F3[0] || var_1 == level._id_15F3[4]) {
          for(var_4 = 1; var_4 < 6; var_4++) {
            var_5 = var_4;

            if(var_4 == 1) {
              var_5 = "";
            }

            var_6 = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment" + var_5];

            if(var_6 != "none") {
              var_3[var_3.size] = var_6;
            }
          }
        }
      }

      var_7 = "none";
      var_8 = "none";
      var_9 = scripts\mp\class::buildweapon(var_2, var_3, var_7, var_8);
      var_10 = getcompleteweaponname(var_9);
    }
  }

  level thread _id_D6E1();
}

_id_EA66(var_0) {
  if(issubstr(var_0, "mpr")) {
    var_0 = scripts\mp\utility\script::_id_EA63(var_0, "_mpr");
  } else if(issubstr(var_0, "mpl")) {
    var_0 = scripts\mp\utility\script::_id_EA63(var_0, "_mpl");
  } else {
    var_0 = scripts\mp\utility\script::_id_EA63(var_0, "_mp");
  }

  return var_0;
}

_id_5BFE(var_0, var_1) {
  if(istrue(var_1)) {
    var_2 = scripts\engine\utility::ter_op(var_0, level._id_7E1F, level._id_EBDA);
  } else {
    var_2 = scripts\engine\utility::ter_op(var_0, level._id_7E1E, level._id_EBD9);
  }

  switch (var_2) {
    case "super_emp_drone":
    case "super_weapon_drop":
    case "super_recon_drone":
      var_2 = "super_ammo_drop";
      break;
    case "super_tac_insert":
      if(var_0 && level._id_7E20 == "equip_tac_insert") {
        level._id_7E20 = "none";
      } else if(level._id_EBDB == "equip_tac_insert") {
        level._id_EBDB = "none";
      }

      break;
    case "super_trophy":
      if(var_0 && level._id_7E20 == "equip_trophy") {
        level._id_7E20 = "none";
      } else if(level._id_EBDB == "equip_trophy") {
        level._id_EBDB = "none";
      }

      break;
  }

  return var_2;
}

onplayerconnect(var_0) {
  var_0._id_60CB = 1;
  var_0._id_60CF = 1;
  var_0._id_7E1C = 0;
  var_0._id_107ED = 0;

  if(!_id_07D1::_id_60BE("prematch_done") || level._id_7E0D) {
    var_0._id_107ED = 1;
  }

  var_0.pers["class"] = "gamemode";
  var_0.pers["lastClass"] = "";
  var_0.class = var_0.pers["class"];
  var_0._id_8FAF = var_0.pers["lastClass"];
  var_0 loadweaponsforplayer(level._id_15F3, 1);

  if(_id_07D1::_id_60BE("prematch_done")) {
    var_0._id_60CF = 0;

    if(isDefined(level._id_7E0C) && level._id_7E0C) {
      var_0._id_EBCF = gettime();
    }
  }

  if(isDefined(level._id_7E10[var_0.name])) {
    var_0._id_7E1C = 1;
  }

  if(isDefined(var_0._id_88C5)) {
    var_0.pers["gamemodeLoadout"] = level._id_7E0F["axis_initial"];
  } else if(var_0._id_7E1C) {
    var_0.pers["gamemodeLoadout"] = level._id_7E0F["axis"];
  } else {
    var_0.pers["gamemodeLoadout"] = level._id_7E0F["allies"];
  }

  var_0 thread _id_A147();
}

_id_6FFC() {
  level endon("game_ended");

  for(;;) {
    wait(level._id_EBD7);

    foreach(var_1 in level.players) {
      if(var_1.team == "allies") {
        var_1 thread _id_0A9F::_id_7003("survivor", undefined, level._id_EBD6);
      }
    }
  }
}

_id_8294() {
  if(scripts\cp_mp\utility\game_utility::_id_88FE()) {
    level._id_60D6 = [];
    var_0 = "mp_gw_spawn_allies_start";
    var_1 = "mp_gw_spawn_axis_start";
    level._id_60D6["allies"] = var_0;
    level._id_60D6["axis"] = var_1;
    level._id_60D5 = [];
    level._id_60D5["allies"] = "mp_tdm_spawn";
    level._id_60D5["axis"] = "mp_tdm_spawn";
    level._id_E327 = (0, 0, 0);
    level._id_E324 = (0, 0, 0);

    if(scripts\cp_mp\utility\game_utility::_id_6B2D() == "mp_aniyah") {
      _id_0817::_id_D461("GroundWarTTLOS", "Crit_Default");
    } else if(scripts\cp_mp\utility\game_utility::_id_88FE()) {
      _id_0817::_id_D461("GroundWar", "Crit_Default");
    } else {
      _id_0817::_id_D461("Default", "Crit_Default");
    }

    _id_0817::_id_113A("mp_gw_spawn_allies_start");
    _id_0817::_id_113A("mp_gw_spawn_axis_start");
    _id_0817::_id_1136(game["attackers"], "mp_gw_spawn_allies_start");
    _id_0817::_id_1136(game["defenders"], "mp_gw_spawn_axis_start");
    var_2 = _id_0817::_id_6D4E("mp_gw_spawn_allies_start");
    var_3 = _id_0817::_id_6D4E("mp_gw_spawn_axis_start");
    _id_0817::_id_C2B9("start_attackers", var_2);
    _id_0817::_id_C2B9("start_defenders", var_3);
    _id_0817::_id_1136("allies", "mp_tdm_spawn");
    _id_0817::_id_1136("axis", "mp_tdm_spawn");
    _id_0817::_id_1136("allies", "mp_tdm_spawn_secondary", 1, 1);
    _id_0817::_id_1136("axis", "mp_tdm_spawn_secondary", 1, 1);
    var_4 = _id_0817::_id_6D4E("mp_tdm_spawn");
    var_5 = _id_0817::_id_6D4E("mp_tdm_spawn_secondary");
    _id_0817::_id_C2B9("normal", var_4);
    _id_0817::_id_C2B9("fallback", var_5);
  } else {
    _id_0817::_id_D461("Default", "Crit_Default");
    level._id_E327 = (0, 0, 0);
    level._id_E324 = (0, 0, 0);
    _id_0817::_id_1136("allies", "mp_tdm_spawn");
    _id_0817::_id_1136("axis", "mp_tdm_spawn");
    _id_0817::_id_1136("allies", "mp_tdm_spawn_secondary", 1, 1);
    _id_0817::_id_1136("axis", "mp_tdm_spawn_secondary", 1, 1);
    var_4 = _id_0817::_id_6D4E("mp_tdm_spawn");
    var_5 = _id_0817::_id_6D4E("mp_tdm_spawn_secondary");
    _id_0817::_id_C2B9("normal", var_4);
    _id_0817::_id_C2B9("fallback", var_5);
    level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
    setmapcenter(level._id_9AAC);
  }

  _id_0817::_id_0EE5();
}

_id_1659() {
  return "gamemode";
}

_id_6D4A() {
  if(isPlayer(self) && self._id_60CB) {
    self._id_60CB = 0;
    self.pers["class"] = "gamemode";
    self.pers["lastClass"] = "";
    self.class = self.pers["class"];
    self._id_8FAF = self.pers["lastClass"];
    var_0 = "allies";

    if(self._id_7E1C) {
      var_0 = "axis";
    }

    _id_07F2::_id_1176(var_0, 1);
    thread _id_A104();
  }

  if(level._id_7EB0) {
    var_1 = _id_0817::_id_6D4E("mp_tdm_spawn");
    var_2 = _id_0817::_id_6D4C(var_1);
  } else
    var_2 = _id_0817::_id_6D4A(self, self.pers["team"], "normal", "fallback");

  return var_2;
}

_id_ABA4() {
  self._id_EF66 = undefined;
  self._id_7E12 = self.origin;
  self._id_7E18 = 0;
  _id_FD5D();

  if(!level._id_7E0B) {
    level._id_7E0B = 1;
    level thread _id_35FD();
  }

  if(!_id_07D1::_id_60BE("prematch_done") || level._id_7E0D) {
    self._id_107ED = 0;
  }

  if(self._id_7E1C) {
    if(!level._id_7E08) {
      level notify("infect_stopCountdown");
      level._id_7E0C = 1;
      level._id_7E08 = 1;

      foreach(var_1 in level.players) {
        if(isDefined(var_1._id_7E0E)) {
          var_1._id_7E0E = undefined;
        }
      }
    }

    foreach(var_1 in level.players) {
      if(isDefined(var_1._id_88C5)) {
        var_1 thread _id_D5BB();
      }
    }

    if(level._id_7E13["axis"] == 1) {
      self._id_88C5 = 1;
    }

    _id_82A6(1);
  }

  thread _id_ABA1();
  thread _id_FCC2();
  level notify("spawned_player");
}

_id_E3AA() {
  var_0 = self getweaponslistprimaries();
  var_1 = self getcurrentprimaryweapon();

  if(var_0.size > 1) {
    if(scripts\mp\utility\weapon::_id_88F9(var_1)) {
      foreach(var_3 in var_0) {
        if(var_3 != var_1) {
          self setspawnweapon(var_3);
        }
      }
    }
  }
}

_id_D500(var_0) {
  var_1 = 1;

  if(isDefined(self._id_88C5)) {
    if(scripts\mp\utility\game::_id_8AC8(var_0, 1)) {
      var_1 = 0;
    }
  } else if(scripts\mp\utility\game::_id_8AC8(var_0, 0))
    var_1 = 0;

  return var_1;
}

_id_ABA1() {
  self endon("death_or_disconnect");
  self waittill("giveLoadout");

  if(istrue(self._id_107ED)) {
    self._id_107ED = 0;
    wait 0.1;
    self suicide();
  }

  self._id_8F2E = self._id_7E15;
  self._id_191C = 0;
  self._id_191D = 0;

  if(self.pers["team"] == "allies") {
    if(level._id_5264) {
      scripts\mp\utility\perk::_id_6FC2("specialty_boom");
    }

    if(level._id_8885) {
      thread _id_6FFA();
    }

    _id_E3AA();

    if(level._id_7E1A && !level._id_7E17 && !isbot(self)) {
      thread _id_A7C2();
    }
  } else if(self.pers["team"] == "axis") {
    if(level._id_5264) {
      scripts\mp\utility\perk::_id_6FC2("specialty_boom");
    }

    var_0 = 1.05;
    var_1 = int(floor(level._id_7E13["axis"] / 3));
    var_1 = var_1 * 0.01;
    var_0 = max(1.0, var_0 - var_1);
    self._id_AD6C = var_0;
    thread _id_D5B8();

    if(level._id_7E20 == "equip_tac_insert" && !istrue(self._id_88C5)) {
      if(level._id_7002 || !level._id_7002 && !self._id_F1D9) {
        scripts\mp\equipment::giveequipment(level._id_7E19, "primary");
      } else {
        scripts\mp\equipment::_id_4558(level._id_7E19, 1);
      }
    }

    if(level._id_7E20 != "equip_tac_insert" || level._id_7E20 == "none") {
      scripts\mp\equipment::giveequipment(level._id_7E20, "secondary");
    } else {
      scripts\mp\utility\perk::_id_6FC2("specialty_tacticalinsertion");
    }

    _id_07E6::_id_8C15();
  }

  _id_6F97();

  if(istrue(self._id_A22C)) {
    self._id_A22C = undefined;
    thread scripts\mp\supers::_id_6FF9(350, undefined, 1);
  }

  var_2 = scripts\mp\utility\weapon::getweaponrootname(self._id_9683);

  if(var_2 != "s4_me_knife") {
    self giveweapon("s4_me_knife_mp");
    self _meth_8514("s4_me_knife_mp");

    if(self._id_9692 == "s4_me_knife") {
      scripts\cp_mp\utility\inventory_utility::_id_EDDF("s4_me_knife_mp");
      self giveweapon("s4_me_knife_mp");
    }
  }

  self._id_59DE = undefined;
}

_id_6FFA() {
  _id_07D1::_id_60C2("prematch_done");
  thread scripts\mp\supers::_id_6FF9(200, undefined, 1);
}

_id_9A1B(var_0, var_1) {
  if(var_0 != "s4_me_fists" || var_1 != "s4_me_fists") {
    if(var_0 == "none" && var_1 == "none") {
      return;
    }
    scripts\cp_mp\utility\inventory_utility::_id_EDDF("s4_me_fists_mp");
    return;
  }
}

_id_6F97() {
  if(self.pers["team"] == "allies") {
    var_0 = ["specialty_fastreload"];
  } else if(istrue(self._id_88C5)) {
    var_0 = ["specialty_longersprint", "specialty_quickdraw", "specialty_falldamage", "specialty_bulletaccuracy", "specialty_quickswap"];
  } else {
    var_0 = ["specialty_longersprint", "specialty_quickdraw", "specialty_falldamage"];
  }

  foreach(var_2 in var_0) {
    scripts\mp\utility\perk::_id_6FC2(var_2);
  }
}

_id_D5B7() {}

_id_D5B8() {
  if(isDefined(self._id_88C5)) {
    if(!isDefined(self._id_DCCA) || !self._id_DCCA) {
      thread scripts\mp\rank::_id_CC00("first_infected");
      self._id_DCCA = 1;
    }
  } else if(isDefined(self._id_33ED)) {
    self._id_33ED = undefined;

    if(isDefined(self._id_33EE)) {
      self._id_33EE = undefined;
      thread _id_0A9F::_id_7003("first_infected");
    }
  } else if(!isDefined(self._id_DCCA) || !self._id_DCCA) {
    thread scripts\mp\rank::_id_CC00("got_infected");
    self._id_DCCA = 1;
  }
}

_id_35FD() {
  level endon("game_ended");
  level endon("infect_stopCountdown");
  level endon("force_end");
  level._id_7E08 = 0;
  _id_07D1::_id_60C2("prematch_done");
  level._id_7E0D = 1;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.0);
  setomnvar("ui_match_start_text", "first_infected_in");
  var_0 = 15;

  while(var_0 > 0 && !level.gameended) {
    foreach(var_2 in level.players) {
      var_2 setclientomnvar("ui_match_start_countdown", var_0);
    }

    var_0--;
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.0);
  }

  setomnvar("ui_match_start_text", "match_resuming_in");

  foreach(var_2 in level.players) {
    var_2 setclientomnvar("ui_match_start_countdown", 0);
  }

  level._id_7E0D = 0;
  var_6 = [];

  foreach(var_8 in level.players) {
    if(scripts\mp\utility\game::matchmakinggame() && level.players.size > 1 && var_8 ishost()) {
      continue;
    }
    if(var_8.team == "spectator") {
      continue;
    }
    if(!var_8._id_75B4) {
      continue;
    }
    var_6[var_6.size] = var_8;
  }

  level._id_5BD2 = 0;

  if(var_6.size <= level._id_A78B && var_6.size > 1) {
    level._id_A78B = var_6.size - 1;
  }

  var_10 = [];

  for(var_11 = 0; var_11 < level._id_A78B; var_11++) {
    var_12 = var_6[randomint(var_6.size)];
    var_10[var_10.size] = var_12;
    var_6 = scripts\engine\utility::array_remove(var_6, var_12);
  }

  foreach(var_12 in var_10) {
    var_12 _id_D55E(1);
  }

  level._id_7E08 = 1;

  foreach(var_8 in level.players) {
    if(istrue(var_8._id_88C5)) {
      var_8 thread scripts\mp\hud_message::showsplash("first_infected");
      var_8 _id_0A8D::_id_9137("infected_first");
      continue;
    }

    var_8 thread scripts\mp\hud_message::showsplash("first_survivor");
    var_8._id_EBCF = gettime();
  }
}

_id_D55E(var_0) {
  self endon("death_or_disconnect");

  if(var_0) {
    self._id_7E0E = 1;
  }

  while(!scripts\mp\utility\player::isreallyalive(self) || scripts\mp\utility\player::_id_8ACE() || isDefined(self._id_10329)) {
    waitframe();
  }

  if(isDefined(self._id_87A7) && self._id_87A7 == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  var_1 = scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var_1)) {
    var_2 = spawnStruct();
    var_2._id_1597 = 1;
    var_2._id_5797 = "INVOLUNTARY";
    thread scripts\cp_mp\vehicles\vehicle_occupancy::_id_10182(var_1, undefined, self, var_2, 1);

    while(scripts\cp_mp\utility\player_utility::isinvehicle()) {
      waitframe();
    }
  }

  while(self _meth_81CE()) {
    waitframe();
  }

  while(!isalive(self)) {
    waitframe();
  }

  if(var_0) {
    _id_07F2::_id_1176("axis", undefined, 1);
    thread _id_A104();
    level._id_7E0C = 1;
    self._id_7E0E = undefined;
    _id_FD5D();

    if(scripts\mp\utility\player::_id_8855()) {} else {}
  }

  self._id_88C5 = 1;
  scripts\mp\utility\stats::_id_7DAE("firstInfected", 1);
  self.pers["gamemodeLoadout"] = level._id_7E0F["axis_initial"];
  _id_0A18::_id_E346(self.origin, self.angles);
  self notify("faux_spawn");
  self._id_59DF = self getstance();
  self._id_59DE = 1;
  self._id_AC3D = undefined;
  waittillframeend;
  thread scripts\mp\playerlogic::_id_E337(1);

  if(isDefined(scripts\mp\supers::getcurrentsuper()) && scripts\mp\supers::_id_69B0() == "super_deadsilence") {
    thread _id_E696();
  } else if(level._id_8885) {
    thread scripts\mp\supers::_id_6FF9(350, undefined, 1);
  }

  if(var_0) {
    level._id_7E10[self.name] = 1;
  }

  level._id_5BD2 = 1;

  if(!level._id_5BD2) {
    level thread scripts\mp\hud_util::_id_EF8D("callout_first_infected", self);
  }

  if(!level._id_7E11) {
    level._id_7E11 = 1;
  }

  thread _id_10871();
  _id_82A6(1);
}

_id_10871() {
  self endon("death_or_disconnect");
  wait 4;
  self iprintlnbold(&"SPLASHES/INFECT_ALL");
}

_id_E696() {
  thread scripts\mp\supers::_id_6FF9(4000, undefined, 1);
  thread _id_0A6C::_id_AFD9();
}

_id_D5BB(var_0, var_1) {
  level endon("game_ended");
  self endon("death");
  self._id_88C5 = undefined;
  self._id_33ED = 1;

  if(isDefined(var_0)) {
    self._id_33EE = 1;
  }

  while(!scripts\mp\utility\player::isreallyalive(self)) {
    waitframe();
  }

  if(isDefined(self._id_87A7) && self._id_87A7 == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self _meth_81CE()) {
    waitframe();
  }

  while(self _meth_81CF()) {
    waitframe();
  }

  while(!scripts\mp\utility\player::isreallyalive(self)) {
    waitframe();
  }

  self.pers["gamemodeLoadout"] = level._id_7E0F["axis"];
  _id_0A18::_id_E346(self.origin, self.angles);
  self notify("faux_spawn");
  self._id_59DF = self getstance();
  self._id_59DE = 1;

  if(isDefined(scripts\mp\supers::getcurrentsuper()) && scripts\mp\supers::getcurrentsuper()._id_88D4) {
    thread scripts\mp\supers::_id_EB50(0);
  }

  waitframe();
  thread scripts\mp\playerlogic::_id_E337(1);

  if(isDefined(scripts\mp\supers::getcurrentsuper()) && scripts\mp\supers::_id_69B0() == "super_deadsilence") {
    thread _id_E696();
  }
}

_id_AB70(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(level.gameended) {
    return;
  }
  var_10 = 0;
  var_11 = 0;
  level thread _id_DBA3();

  if(self.team == "axis") {}

  if(self.team == "allies" && isDefined(var_1)) {
    self._id_AC3D = undefined;

    if(isPlayer(var_1) && var_1 != self) {
      var_10 = 1;
    } else if(level._id_7E08 && (var_1 == self || !isPlayer(var_1))) {
      var_10 = 1;
      var_11 = 1;
    }
  }

  if(self.team == "allies" && istrue(level._id_A737)) {
    if(isDefined(level._id_A73D) && self == level._id_A73D) {
      var_10 = 0;
      var_11 = 0;
    }
  }

  if(isPlayer(var_1) && var_1.team == "allies" && var_1 != self) {
    var_1 scripts\mp\utility\stats::_id_7DAE("killsAsSurvivor", 1);
    var_1 scripts\mp\persistence::_id_E770("round", "killsAsSurvivor", var_1.pers["killsAsSurvivor"]);
  } else if(isPlayer(var_1) && var_1.team == "axis" && var_1 != self) {
    var_1 scripts\mp\utility\stats::_id_7DAE("killsAsInfected", 1);
    var_1 scripts\mp\persistence::_id_E770("round", "killsAsInfected", var_1.pers["killsAsInfected"]);

    if(isPlayer(var_1)) {
      var_1 scripts\mp\utility\stats::_id_D551(var_1.pers["killsAsInfected"]);
    }
  }

  if(var_10) {
    thread _id_46C1(var_1, var_11);

    if(var_11) {
      foreach(var_13 in level.players) {
        if(isDefined(var_13._id_88C5)) {
          var_13 thread _id_D5BB();
        }
      }
    } else if(isDefined(var_1._id_88C5)) {
      foreach(var_13 in level.players) {
        if(isDefined(var_13._id_88C5)) {
          var_13 thread _id_D5BB(1);
        }
      }
    } else if(level._id_7E23 > 0) {
      if(!isDefined(var_1._id_7E18)) {
        var_1._id_7E18 = 1;
      } else {
        var_1._id_7E18++;
      }

      var_1 thread _id_0A9F::_id_7003("infected_survivor", undefined, level._id_7E23 * var_1._id_7E18);
    } else
      var_1 thread _id_0A9F::_id_7003("infected_survivor");

    if(scripts\mp\utility\dvars::getwatcheddvar("timelimit") != 0) {
      var_17 = 1;

      if(scripts\mp\utility\game::matchmakinggame()) {
        level._id_5858++;
        var_17 = level._id_5858 <= level._id_5859;
      }

      if(var_17) {
        if(!isDefined(level._id_5856)) {
          level._id_5856 = level._id_7E21;
        } else {
          level._id_5856 = level._id_5856 + level._id_7E21;
        }
      }
    }

    _id_D702(1);
  } else {
    if(isbot(self)) {
      self._id_3802 = "gamemode";
    }

    if(isDefined(self._id_88C5)) {
      self.pers["gamemodeLoadout"] = level._id_7E0F["axis_initial"];
      self._id_7E15 = "axis_initial";
    } else {
      self.pers["gamemodeLoadout"] = level._id_7E0F[self.pers["team"]];
      self._id_7E15 = self.pers["team"];
    }
  }
}

_id_46C1(var_0, var_1) {
  wait 0.15;
  self._id_EF66 = 1;
  _id_07F2::_id_1176("axis");
  self._id_A22C = 1;
  _id_FD5D();
  level._id_7E10[self.name] = 1;
  thread _id_A104();

  if(level._id_7E13["allies"] > 1) {
    if(level._id_8885) {
      level._id_B846++;

      if(level._id_B846 > 3) {
        level._id_B846 = 1;
      }
    }

    if(level._id_B846 == 1) {
      _id_0AA2::_id_B8F1("mp_enemy_obj_captured", "allies");
      _id_0AA2::_id_B8F1("mp_war_objective_taken", "axis");
      thread scripts\mp\hud_util::_id_EF8D("callout_got_infected", self, "allies");
    }

    if(!var_1) {
      thread scripts\mp\hud_util::_id_EF8D("callout_infected", var_0, "axis");

      if(!isDefined(level._id_EBD5)) {
        level._id_EBD5 = scripts\mp\rank::getscoreinfovalue("survivor");
      } else {
        level._id_EBD5 = level._id_EBD5 + level._id_EBD2;
      }

      foreach(var_3 in level.players) {
        if(!scripts\mp\utility\player::isreallyalive(var_3) || self.sessionstate == "spectator") {
          continue;
        }
        if(var_3.team == "allies" && var_3 != self && distance(var_3._id_7E12, var_3.origin) > 32) {
          var_3 thread _id_0A9F::_id_7003("survivor", undefined, level._id_EBD5);
        }

        if(var_3.team == "axis" && var_3 != var_0 && var_3 != self) {
          var_3 thread _id_0A9F::_id_7003("assist", undefined, level._id_7E14);
        }
      }
    }
  } else if(level._id_7E13["allies"] == 1)
    _id_AAEA();
  else if(level._id_7E13["allies"] == 0) {
    _id_ABB5();
  }

  if(isbot(self)) {
    self._id_3802 = "gamemode";
  }

  if(isDefined(self._id_88C5)) {
    self.pers["gamemodeLoadout"] = level._id_7E0F["axis_initial"];
    self._id_7E15 = "axis_initial";
  } else {
    self.pers["gamemodeLoadout"] = level._id_7E0F[self.pers["team"]];
    self._id_7E15 = self.pers["team"];
  }
}

_id_AB3F(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(istrue(level.matchmakingmatch) && isDefined(var_1) && isDefined(var_0)) {
    var_6 = var_1 _meth_8133();

    if(isDefined(var_6) && var_6.size > 0) {
      foreach(var_8 in var_6) {
        if(isDefined(var_8) && var_0 == var_8) {
          var_1._id_A73E = scripts\engine\utility::ter_op(var_1._id_A73E > 0, var_1._id_A73E - 1, 0);
          break;
        }
      }
    }
  }
}

_id_AAEA() {
  _id_0AA2::_id_B8F1("mp_obj_captured");

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(var_1.team == "allies") {
      var_1 _id_0A8D::_id_9137("infected_lastalive");
      var_1 thread scripts\mp\rank::_id_CC00("final_survivor");
      var_1 scripts\mp\utility\stats::_id_7DAE("lastSurvivor", 1);

      if(scripts\mp\utility\game::matchmakinggame()) {
        var_1.maxhealth = 200;
        var_1 notify("force_regeneration");
      }

      if(!level._id_7E0A) {
        if(var_1._id_60CF && isDefined(var_1._id_7E12) && distance(var_1._id_7E12, var_1.origin) > 32) {
          var_1 thread _id_0A9F::_id_7003("final_survivor");
        }

        level._id_7E0A = 1;
      }

      thread scripts\mp\hud_util::_id_EF8D("callout_final_survivor", var_1);

      if(level._id_7E1A) {} else
        level thread _id_5AAC(var_1);

      break;
    }
  }
}

_id_5AAC(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("eliminated");
  level endon("infect_lateJoiner");
  level thread _id_5353(var_0);
  var_1 = 0;
  level.radarmode["axis"] = "normal_radar";

  foreach(var_3 in level.players) {
    if(var_3.team == "axis") {
      var_3.radarmode = "normal_radar";
    }
  }

  var_5 = _func_00E0();
  _id_09BD::_id_0CF1("axis", var_5 + 1);

  for(;;) {
    var_6 = var_0.origin;
    wait 4;

    if(var_1) {
      _func_01F6("axis", 0);
      var_1 = 0;
    }

    wait 6;

    if(distance(var_6, var_0.origin) < 200) {
      _func_01F6("axis", 1);
      var_1 = 1;

      foreach(var_3 in level.players) {
        var_3 playlocalsound("recondrone_tag");
      }
    }
  }
}

_id_5353(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("eliminated");

  for(;;) {
    if(level._id_7E13["allies"] > 1) {
      level notify("infect_lateJoiner");
      waitframe();
      _func_01F6("axis", 0);
      break;
    }

    waitframe();
  }
}

_id_A104() {
  level endon("game_ended");
  self endon("eliminated");
  self notify("infect_monitor_disconnect");
  self endon("infect_monitor_disconnect");
  var_0 = self.team;

  if(!isDefined(var_0) && isDefined(self._id_28F7)) {
    var_0 = self._id_28F7;
  }

  self waittill("disconnect");
  _id_FD5D();

  if(isDefined(self._id_7E0E) || level._id_7E0C) {
    if(level._id_7E13["axis"] && level._id_7E13["allies"]) {
      if(var_0 == "allies" && level._id_7E13["allies"] == 1) {
        _id_AAEA();
      } else if(var_0 == "axis" && level._id_7E13["axis"] == 1) {
        foreach(var_2 in level.players) {
          if(var_2 != self && var_2.team == "axis") {
            var_2 _id_D55E(0);
          }
        }
      }
    } else if(level._id_7E13["allies"] == 0) {
      if(istrue(level._id_7AA5)) {
        scripts\mp\hostmigration::waittillhostmigrationdone();
      }

      _id_ABB5();
    } else if(level._id_7E13["axis"] == 0) {
      if(level._id_7E13["allies"] == 1) {
        level thread scripts\mp\gamelogic::_id_52F7("allies", game["end_reason"][tolower(game["axis"]) + "_eliminated"]);
      } else if(level._id_7E13["allies"] > 1) {
        level._id_7E0C = 0;
        level thread _id_35FD();
      }
    }
  } else if(level._id_7E0D && level._id_7E13["allies"] == 0 && level._id_7E13["axis"] == 0) {
    level notify("infect_stopCountdown");
    level._id_7E0B = 0;

    foreach(var_5 in level.players) {
      var_5 setclientomnvar("ui_match_start_countdown", 0);
    }
  }

  self._id_88C5 = undefined;
}

_id_AAA3(var_0) {
  return;
}

_id_ABC0() {
  level thread scripts\mp\gamelogic::_id_52F7("allies", game["end_reason"]["time_limit_reached"]);
}

_id_ABB5() {
  level thread scripts\mp\gamelogic::_id_52F7("axis", game["end_reason"][tolower(game["allies"]) + "_eliminated"]);
}

_id_6DDB(var_0) {
  var_1 = 0;

  foreach(var_3 in level.players) {
    if(var_3.sessionstate == "spectator" && !var_3._id_03EB && !istrue(var_3._id_82F0)) {
      continue;
    }
    if(var_3.team == var_0) {
      var_1++;
    }
  }

  return var_1;
}

_id_FD5D() {
  level._id_7E13["allies"] = _id_6DDB("allies");
  game["teamScores"]["allies"] = level._id_7E13["allies"];
  _func_01F8("allies", level._id_7E13["allies"]);
  level._id_7E13["axis"] = _id_6DDB("axis");
  game["teamScores"]["axis"] = level._id_7E13["axis"];
  _func_01F8("axis", level._id_7E13["axis"]);
}

_id_D6E1() {
  waitframe();

  if(!isDefined(level._id_EBD4) || level._id_EBD4 == "") {
    level._id_EBD4 = "s4_ar_stango44";
  }

  if(!isDefined(level._id_EBD8) || level._id_EBD8 == "") {
    level._id_EBD8 = "s4_pi_mike1911";
  }

  if(!isDefined(level._id_7E1B) || level._id_7E1B == "") {
    level._id_7E1B = "s4_me_knife";
  }

  if(!isDefined(level._id_7E1D) || level._id_7E1D == "") {
    level._id_7E1D = "s4_me_fists_mp";
  }

  if(!isDefined(level._id_81F5) || level._id_81F5 == "") {
    level._id_81F5 = "s4_ar_stango44_mp";
  }

  if(isDefined(level._id_7E1B) && level._id_7E1B == "s4_me_knife_mp") {
    level._id_7E1B = "s4_me_knife_mp";

    if(isDefined(level._id_7E1D) && level._id_7E1D == "s4_me_knife_mp") {
      level._id_7E1D = "none";
    }
  }

  if(!isDefined(level._id_81F6) || level._id_81F6 == "") {
    level._id_81F6 = "s4_pi_mike1911";
  }

  if(!isDefined(level._id_EBD3) || level._id_EBD3 == "") {
    level._id_EBD3 = "equip_claymore";
  }

  if(!isDefined(level._id_EBDB) || level._id_EBDB == "") {
    level._id_EBDB = "equip_concussion";
  }

  if(!isDefined(level._id_7E19) || level._id_7E19 == "") {
    level._id_7E19 = "equip_throwing_knife";
  }

  if(!isDefined(level._id_7E20) || level._id_7E20 == "") {
    level._id_7E20 = "equip_tac_insert";
  }

  level._id_7E09 = [];
  level._id_7E09[level._id_7E09.size] = "archetype_assault";

  if(scripts\mp\utility\game::_id_8AC8("allies", 0)) {
    level._id_7E0F["allies"] = ::scripts\mp\utility\game::_id_6B33("allies", 0);
  } else if(level._id_AB25) {
    level._id_7E0F["allies"]["loadoutPrimary"] = level._id_EBD4;
    level._id_7E0F["allies"]["loadoutPrimaryAttachment"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment"];
    level._id_7E0F["allies"]["loadoutPrimaryAttachment2"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment2"];
    level._id_7E0F["allies"]["loadoutPrimaryAttachment3"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment3"];
    level._id_7E0F["allies"]["loadoutPrimaryAttachment4"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment4"];
    level._id_7E0F["allies"]["loadoutPrimaryAttachment5"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment5"];
    level._id_7E0F["allies"]["loadoutPrimaryCamo"] = "none";
    level._id_7E0F["allies"]["loadoutPrimaryReticle"] = "none";
    level._id_7E0F["allies"]["loadoutSecondary"] = level._id_EBD8;
    level._id_7E0F["allies"]["loadoutSecondaryAttachment"] = level._id_1DB6;
    level._id_7E0F["allies"]["loadoutSecondaryAttachment2"] = level._id_1DB7;
    level._id_7E0F["allies"]["loadoutSecondaryCamo"] = "none";
    level._id_7E0F["allies"]["loadoutSecondaryReticle"] = "none";
    level._id_7E0F["allies"]["loadoutEquipmentPrimary"] = level._id_EBD3;
    level._id_7E0F["allies"]["loadoutEquipmentSecondary"] = level._id_EBDB;
    level._id_7E0F["allies"]["loadoutSuper"] = "none";
    level._id_7E0F["allies"]["loadoutStreakType"] = "assault";
    level._id_7E0F["allies"]["loadoutKillstreak1"] = "none";
    level._id_7E0F["allies"]["loadoutKillstreak2"] = "none";
    level._id_7E0F["allies"]["loadoutKillstreak3"] = "none";
    level._id_7E0F["allies"]["loadoutUsingSpecialist"] = undefined;
    level._id_7E0F["allies"]["loadoutPerks"] = ["specialty_hardline"];
    level._id_7E0F["allies"]["loadoutExtraPerks"] = ["specialty_scavenger_plus", "specialty_warhead", "specialty_restock"];
    level._id_7E0F["allies"]["loadoutGesture"] = "playerData";
    level._id_7E0F["allies"]["loadoutFieldUpgrade1"] = level._id_EBD9;
    level._id_7E0F["allies"]["loadoutFieldUpgrade2"] = level._id_EBDA;
  } else {
    level._id_7E0F["allies"]["loadoutPrimary"] = level._id_EBD4;
    level._id_7E0F["allies"]["loadoutPrimaryAttachment"] = level._id_1DB5;
    level._id_7E0F["allies"]["loadoutPrimaryAttachment2"] = "none";
    level._id_7E0F["allies"]["loadoutPrimaryCamo"] = "none";
    level._id_7E0F["allies"]["loadoutPrimaryReticle"] = "none";
    level._id_7E0F["allies"]["loadoutSecondary"] = level._id_EBD8;
    level._id_7E0F["allies"]["loadoutSecondaryAttachment"] = level._id_1DB6;
    level._id_7E0F["allies"]["loadoutSecondaryAttachment2"] = level._id_1DB7;
    level._id_7E0F["allies"]["loadoutSecondaryCamo"] = "none";
    level._id_7E0F["allies"]["loadoutSecondaryReticle"] = "none";
    level._id_7E0F["allies"]["loadoutEquipmentPrimary"] = level._id_EBD3;
    level._id_7E0F["allies"]["loadoutEquipmentSecondary"] = level._id_EBDB;
    level._id_7E0F["allies"]["loadoutSuper"] = "none";
    level._id_7E0F["allies"]["loadoutStreakType"] = "assault";
    level._id_7E0F["allies"]["loadoutKillstreak1"] = "none";
    level._id_7E0F["allies"]["loadoutKillstreak2"] = "none";
    level._id_7E0F["allies"]["loadoutKillstreak3"] = "none";
    level._id_7E0F["allies"]["loadoutUsingSpecialist"] = undefined;
    level._id_7E0F["allies"]["loadoutPerks"] = ["specialty_hardline"];
    level._id_7E0F["allies"]["loadoutExtraPerks"] = ["specialty_scavenger_plus", "specialty_warhead", "specialty_restock"];
    level._id_7E0F["allies"]["loadoutGesture"] = "playerData";
    level._id_7E0F["allies"]["loadoutFieldUpgrade1"] = level._id_EBD9;
    level._id_7E0F["allies"]["loadoutFieldUpgrade2"] = level._id_EBDA;

    if(level._id_5264) {}
  }

  if(scripts\mp\utility\game::_id_8AC8("axis", 1)) {
    level._id_7E0F["axis_initial"] = ::scripts\mp\utility\game::_id_6B33("axis", 1);
    level._id_7E0F["axis_initial"]["loadoutStreakType"] = "assault";
    level._id_7E0F["axis_initial"]["loadoutKillstreak1"] = "none";
    level._id_7E0F["axis_initial"]["loadoutKillstreak2"] = "none";
    level._id_7E0F["axis_initial"]["loadoutKillstreak3"] = "none";
  } else if(level._id_AB25) {
    level._id_7E0F["axis_initial"]["loadoutPrimary"] = level._id_81F5;
    level._id_7E0F["axis_initial"]["loadoutPrimaryAttachment"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment"];
    level._id_7E0F["axis_initial"]["loadoutPrimaryAttachment2"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment2"];
    level._id_7E0F["axis_initial"]["loadoutPrimaryAttachment3"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment3"];
    level._id_7E0F["axis_initial"]["loadoutPrimaryAttachment4"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment4"];
    level._id_7E0F["axis_initial"]["loadoutPrimaryAttachment5"] = game["arenaRandomLoadout"][0]["loadoutPrimaryAttachment5"];
    level._id_7E0F["axis_initial"]["loadoutSecondary"] = level._id_81F6;
    level._id_7E0F["axis_initial"]["loadoutSecondaryAttachment"] = level._id_1D96;
    level._id_7E0F["axis_initial"]["loadoutSecondaryAttachment2"] = level._id_1D97;
    level._id_7E0F["axis_initial"]["loadoutSecondaryCamo"] = "none";
    level._id_7E0F["axis_initial"]["loadoutSecondaryReticle"] = "none";
    level._id_7E0F["axis_initial"]["loadoutEquipmentPrimary"] = level._id_7E19;
    level._id_7E0F["axis_initial"]["loadoutEquipmentSecondary"] = level._id_7E20;
    level._id_7E0F["axis_initial"]["loadoutSuper"] = "none";
    level._id_7E0F["axis_initial"]["loadoutStreakType"] = "assault";
    level._id_7E0F["axis_initial"]["loadoutKillstreak1"] = "none";
    level._id_7E0F["axis_initial"]["loadoutKillstreak2"] = "none";
    level._id_7E0F["axis_initial"]["loadoutKillstreak3"] = "none";
    level._id_7E0F["axis_initial"]["loadoutPerks"] = [];
    level._id_7E0F["axis_initial"]["loadoutGesture"] = "playerData";
    level._id_7E0F["axis_initial"]["loadoutFieldUpgrade1"] = level._id_7E1E;
    level._id_7E0F["axis_initial"]["loadoutFieldUpgrade2"] = level._id_7E1F;
  } else {
    level._id_7E0F["axis_initial"]["loadoutPrimary"] = level._id_81F5;
    level._id_7E0F["axis_initial"]["loadoutPrimaryAttachment"] = level._id_1D95;
    level._id_7E0F["axis_initial"]["loadoutPrimaryAttachment2"] = "none";
    level._id_7E0F["axis_initial"]["loadoutPrimaryCamo"] = "none";
    level._id_7E0F["axis_initial"]["loadoutPrimaryReticle"] = "none";
    level._id_7E0F["axis_initial"]["loadoutSecondary"] = level._id_81F6;
    level._id_7E0F["axis_initial"]["loadoutSecondaryAttachment"] = level._id_1D96;
    level._id_7E0F["axis_initial"]["loadoutSecondaryAttachment2"] = level._id_1D97;
    level._id_7E0F["axis_initial"]["loadoutSecondaryCamo"] = "none";
    level._id_7E0F["axis_initial"]["loadoutSecondaryReticle"] = "none";
    level._id_7E0F["axis_initial"]["loadoutEquipmentPrimary"] = level._id_7E19;
    level._id_7E0F["axis_initial"]["loadoutEquipmentSecondary"] = level._id_7E20;
    level._id_7E0F["axis_initial"]["loadoutSuper"] = "none";
    level._id_7E0F["axis_initial"]["loadoutStreakType"] = "assault";
    level._id_7E0F["axis_initial"]["loadoutKillstreak1"] = "none";
    level._id_7E0F["axis_initial"]["loadoutKillstreak2"] = "none";
    level._id_7E0F["axis_initial"]["loadoutKillstreak3"] = "none";
    level._id_7E0F["axis_initial"]["loadoutPerks"] = [];
    level._id_7E0F["axis_initial"]["loadoutGesture"] = "playerData";
    level._id_7E0F["axis_initial"]["loadoutFieldUpgrade1"] = level._id_7E1E;
    level._id_7E0F["axis_initial"]["loadoutFieldUpgrade2"] = level._id_7E1F;

    if(level._id_5256) {}

    if(level._id_5264) {}
  }

  if(scripts\mp\utility\game::_id_8AC8("axis", 0)) {
    level._id_7E0F["axis"] = ::scripts\mp\utility\game::_id_6B33("axis", 0);
    level._id_7E0F["axis"]["loadoutStreakType"] = "assault";
    level._id_7E0F["axis"]["loadoutKillstreak1"] = "none";
    level._id_7E0F["axis"]["loadoutKillstreak2"] = "none";
    level._id_7E0F["axis"]["loadoutKillstreak3"] = "none";
  } else {
    level._id_7E0F["axis"]["loadoutPrimary"] = level._id_7E1B;
    level._id_7E0F["axis"]["loadoutPrimaryAttachment"] = "none";
    level._id_7E0F["axis"]["loadoutPrimaryAttachment2"] = "none";
    level._id_7E0F["axis"]["loadoutPrimaryCamo"] = "none";
    level._id_7E0F["axis"]["loadoutPrimaryReticle"] = "none";
    level._id_7E0F["axis"]["loadoutSecondary"] = level._id_7E1D;
    level._id_7E0F["axis"]["loadoutSecondaryAttachment"] = "none";
    level._id_7E0F["axis"]["loadoutSecondaryAttachment2"] = "none";
    level._id_7E0F["axis"]["loadoutSecondaryCamo"] = "none";
    level._id_7E0F["axis"]["loadoutSecondaryReticle"] = "none";
    level._id_7E0F["axis"]["loadoutEquipmentPrimary"] = level._id_7E19;
    level._id_7E0F["axis"]["loadoutEquipmentSecondary"] = level._id_7E20;
    level._id_7E0F["axis"]["loadoutSuper"] = level._id_7E1E;
    level._id_7E0F["axis"]["loadoutStreakType"] = "assault";
    level._id_7E0F["axis"]["loadoutKillstreak1"] = "none";
    level._id_7E0F["axis"]["loadoutKillstreak2"] = "none";
    level._id_7E0F["axis"]["loadoutKillstreak3"] = "none";
    level._id_7E0F["axis"]["loadoutPerks"] = [];
    level._id_7E0F["axis"]["loadoutGesture"] = "playerData";
    level._id_7E0F["axis"]["loadoutFieldUpgrade1"] = level._id_7E1E;
    level._id_7E0F["axis"]["loadoutFieldUpgrade2"] = level._id_7E1F;

    if(level._id_5256) {}

    if(level._id_5264) {
      return;
    }
  }
}

_id_113E(var_0) {
  level._id_1DB5 = "none";
  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);

  if(var_1 == "weapon_shotgun") {
    level._id_1DB5 = "barrelrange";
  } else if(var_1 == "weapon_assault" || var_1 == "weapon_smg" || var_1 == "weapon_lmg" || var_1 == "weapon_pistol" || var_0 == "iw7_m1c") {
    level._id_1DB5 = "highcal";
  }
}

_id_10C5(var_0) {
  level._id_1D95 = "none";
  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);

  if(var_1 == "weapon_shotgun") {
    level._id_1D95 = "barrelrange";
  } else if(var_1 == "weapon_assault" || var_1 == "weapon_smg" || var_1 == "weapon_lmg" || var_1 == "weapon_pistol" || var_0 == "iw7_m1c") {
    level._id_1D95 = "highcal";
  }
}

_id_113F(var_0) {
  level._id_1DB6 = "none";
  level._id_1DB7 = "none";
  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);

  if(var_1 == "weapon_pistol") {
    level._id_1DB6 = "highcal";
  }

  if(scripts\mp\utility\game::matchmakinggame()) {
    if(var_0 == "iw7_g18c") {
      level._id_1DB6 = "akimbo";
      level._id_1DB7 = "highcal";
    }
  }
}

_id_10C6(var_0) {
  level._id_1D96 = "none";
  level._id_1D97 = "none";
  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);

  if(var_1 == "weapon_pistol") {
    level._id_1D96 = "highcal";
  }

  if(scripts\mp\utility\game::matchmakinggame()) {
    if(var_0 == "iw7_g18c") {
      level._id_1D96 = "akimbo";
      level._id_1D97 = "highcal";
    }
  }
}

_id_A147() {
  self endon("death_or_disconnect");
  self endon("infected");
  level endon("game_ended");

  for(;;) {
    if(!level._id_7E0C || !isDefined(self._id_EBCF) || !isalive(self)) {
      waitframe();
      continue;
    }

    _id_D702(0);
    wait 1.0;
  }
}

_id_82A6(var_0) {
  scripts\mp\utility\stats::_id_D550(0);

  if(isDefined(var_0) && var_0) {
    self notify("infected");
  }
}

_id_D702(var_0) {
  if(!isDefined(self._id_EBCF)) {
    self._id_EBCF = self._id_E393;
  }

  var_1 = int((gettime() - self._id_EBCF) / 1000);

  if(var_1 > 999) {
    var_1 = 999;
  }

  scripts\mp\utility\stats::_id_D550(var_1);

  if(isDefined(var_0) && var_0) {
    self notify("infected");
  }
}

_id_DBA3() {
  if(!level._id_4971 && _func_00DB("axis") >= int(level.players.size - level.players.size / 2)) {
    var_0 = "axis";
    _id_0A8D::_id_9136("halfway_friendly_score", var_0, "status");
    var_1 = scripts\mp\utility\teams::_id_6A01(var_0);

    foreach(var_3 in var_1) {
      _id_0A8D::_id_9136("halfway_enemy_score", var_3, "status");
    }

    level._id_4971 = 1;
  }
}

_id_FCC2() {
  level endon("game_ended");

  if(self.team == "allies") {
    self setclientomnvar("ui_match_status_hint_text", 39);
  } else {
    self setclientomnvar("ui_match_status_hint_text", 40);
  }
}

_id_A7C2() {
  self endon("death");
  self endon("spawned");
  _id_07D1::_id_60C2("prematch_done");
  var_0 = 0;
  var_1 = 0;

  for(;;) {
    if(self _meth_8632()) {
      var_0 = var_0 + level._id_5F3A;

      if(var_0 >= 1 && !var_1) {
        scripts\mp\hud_message::_id_DCA2("MP_INGAME_ONLY/LOW_BATTERY");
        var_1 = 1;
      }

      if(var_0 >= 2) {
        self _meth_8246();
        self setclientomnvar("ui_ctf_flag_carrier", 1);
        scripts\common\utility::_id_155D(0);
        _id_C110();
        scripts\common\utility::_id_155D(1);
        var_1 = 0;
        self setclientomnvar("ui_ctf_flag_carrier", 0);
        var_0 = 0;
      }
    }

    wait(level._id_5F3A);
  }
}

_id_C110() {
  var_0 = 0;

  while(var_0 < 5) {
    var_0 = var_0 + level._id_5F3A;

    if(self _meth_8632()) {
      self _meth_8246();
    }

    wait(level._id_5F3A);
  }
}

_id_AFD8() {
  if(scripts\mp\utility\perk::_hasperk("specialty_tacticalinsertion")) {
    scripts\mp\utility\perk::removeperk("specialty_tacticalinsertion");
  }

  if(!scripts\mp\utility\perk::_hasperk("specialty_tacticalinsertion")) {
    scripts\mp\utility\perk::_id_6FC2("specialty_tacticalinsertion");
  }

  scripts\mp\equipment::giveequipment(level._id_7E20, "secondary");
}