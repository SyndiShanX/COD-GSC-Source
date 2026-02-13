/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dm.gsc
*************************************************/

main() {
  _id_07DC::init();
  _id_07DC::_id_D854();
  var_0[0] = ::scripts\mp\utility\game::getgametype();
  _id_07D6::main(var_0);

  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 30);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
  }

  _id_FC7D();
  level._id_ABAD = ::_id_ABAD;
  level.onplayerconnect = ::onplayerconnect;
  level._id_6D4A = ::_id_6D4A;
  level._id_9FE8 = ::_id_ABA4;
  level._id_AB3F = ::_id_AB3F;
  level._id_AB75 = ::_id_AB75;
  level._id_4971 = 0;
  _func_01F5("ffa");

  if(istrue(level._id_191E)) {
    level._id_2DF4 = ::_id_1659;
    _func_01EA("ui_skip_loadout", 1);
    _id_D6E0();
    game["dialog"]["gametype"] = "mp_glob_sqdm_bchr_z118";
  } else
    game["dialog"]["gametype"] = "mp_glob_sqdm_bchr_z118";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "mp_glob_sqdm_bchr_z118";
  } else if(getdvarint("#x36c8f5946a1247e70")) {
    game["dialog"]["gametype"] = "mp_glob_sqdm_bchr_z118";
  }

  game["dialog"]["ffa_lead_first"] = "gamestate_lead";
  game["dialog"]["ffa_lead_second"] = "gamestate_second";
  game["dialog"]["ffa_lead_third"] = "gamestate_third";
  game["dialog"]["ffa_lead_last"] = "gamestate_last";
  game["dialog"]["offense_obj"] = "mp_glob_gene_bchr_z254";
  game["dialog"]["defense_obj"] = "";
}

_id_1659() {
  return "gamemode";
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0(1);
  setdynamicdvar("#x3ef220fe1c11508c2", getmatchrulesdata("dmData", "aonRules"));
  setdynamicdvar("#x3a8ac94b863564196", getmatchrulesdata("dmData", "scoreOnTargetPlayer"));
  setdynamicdvar("#x3cf4c90d0ad7c10db", getmatchrulesdata("dmData", "targetPlayerCycle"));
  setdynamicdvar("#x3d3c45ec302442402", getmatchrulesdata("dmData", "showTargetTime"));
  setdynamicdvar("#x382fd82ca70aa51ca", 1);
  scripts\mp\utility\game::_id_C2D0("dm", 1);
  setdynamicdvar("#x360a1a1f5467abc34", 1);
  scripts\mp\utility\game::_id_C2A9("dm", 1);
  setdynamicdvar("#x34f5a990b15ae243b", 0);
  scripts\mp\utility\game::_id_C25D("dm", 0);
}

_id_ABAD() {
  setclientnamemode("auto_change");

  foreach(var_1 in level._id_EF89) {
    scripts\mp\utility\game::_id_D61C(var_1, &"OBJECTIVES/DM");

    if(level.splitscreen) {
      scripts\mp\utility\game::_id_D61A(var_1, &"OBJECTIVES/DM");
    } else {
      scripts\mp\utility\game::_id_D61A(var_1, &"OBJECTIVES/DM_SCORE");
    }

    scripts\mp\utility\game::_id_D615(var_1, &"OBJECTIVES/DM_HINT");
  }

  _id_0817::_id_D461("FreeForAll", "Crit_Default");
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  _id_0817::_id_113A("mp_dm_spawn_start", 1);
  _id_0817::_id_1136("allies", "mp_dm_spawn");
  _id_0817::_id_1136("allies", "mp_dm_spawn_secondary", 1, 1);
  _id_0817::_id_1136("axis", "mp_dm_spawn");
  _id_0817::_id_1136("axis", "mp_dm_spawn_secondary", 1, 1);
  _id_0817::_id_C2B9("dm", "mp_dm_spawn");
  _id_0817::_id_C2B9("dm_fallback", "mp_dm_spawn_secondary");
  _id_0817::_id_0EE5();
  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
  level._id_BEF6 = 1;
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_191E = scripts\mp\utility\dvars::_id_509C("aonRules", 0, 0, 2);
  level._id_CC0F = scripts\mp\utility\dvars::_id_509C("scoreOnTargetPlayer", 0, 0, 1);
  level._id_EEF4 = scripts\mp\utility\dvars::_id_509C("targetPlayerCycle", 0, 0, 1);
  level._id_DCEE = scripts\mp\utility\dvars::_id_509C("showTargetTime", 1, 0, 6);

  switch (level._id_DCEE) {
    case 0:
      level._id_A912 = 60.0;
      break;
    case 1:
      level._id_A912 = 0.05;
      break;
    case 2:
      level._id_A912 = 1.0;
      break;
    case 3:
      level._id_A912 = 1.5;
      break;
    case 4:
      level._id_A912 = 2.0;
      break;
    case 5:
      level._id_A912 = 3.0;
      break;
    case 6:
      level._id_A912 = 4.0;
      break;
  }

  if(level._id_191E > 0) {
    level._id_25A8 = 1;
    level._id_15D8 = setDvar("#x3212d88094e4552e8", 0);
  } else
    level notify("cancel_loadweapons");
}

_id_6D4A() {
  var_0 = undefined;

  if(level._id_7EB0) {
    var_1 = _id_0817::_id_6D4E("mp_dm_spawn_start");

    if(var_1.size > 0) {
      if(!isDefined(level._id_C58A)) {}

      var_0 = _id_0817::_id_6D4D(var_1, 1);
    }

    if(!isDefined(var_0)) {
      var_1 = _id_0817::_id_6DDD(self.team);
      var_0 = _id_0818::_id_6D89(var_1);
    }
  } else
    var_0 = _id_0817::_id_6D4A(self, "none", "dm", "dm_fallback");

  return var_0;
}

_id_ABA4() {
  self setclientomnvar("ui_match_status_hint_text", 0);

  if(level._id_191E > 0) {
    thread _id_ABA1();
  }

  if(level._id_CC0F) {
    if(!isDefined(self._id_EF10)) {
      thread _id_6DB8();
      thread _id_A45D();
    }
  }

  level notify("spawned_player");
}

_id_AB3F(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\mp\gametypes\common::_id_AA89(var_0, var_1, var_2, var_3, var_4, var_5);

  if(level._id_191E > 0) {}

  var_6 = 0;

  foreach(var_8 in level.players) {
    if(isDefined(var_8._id_038F) && var_8._id_038F > var_6) {
      var_6 = var_8._id_038F;
    }
  }

  if(!level._id_4971) {
    if(var_1._id_038F >= int(level._id_CC09 * level._id_41EA - level._id_CC09 / 2)) {
      thread _id_4CF0(var_1);
    }
  }

  if(var_1._id_038F == level._id_CC09 - 2) {
    level._id_8CDC = 1;
  }

  var_10 = var_1 scripts\mp\utility\stats::_id_6C29("killChains");

  if(isDefined(var_10)) {
    var_1 scripts\mp\utility\stats::_id_D551(var_10);
  }
}

_id_AB75(var_0, var_1, var_2, var_3) {
  var_1 scripts\mp\utility\stats::_id_7DAE("gamemodeScore", var_2);
  var_4 = int(var_1 scripts\mp\utility\stats::_id_6C29("gamemodeScore"));
  var_1 scripts\mp\persistence::_id_E770("round", "gamemodeScore", var_4);

  if(var_1.pers["cur_kill_streak"] > var_1 scripts\mp\utility\stats::_id_6C29("killChains")) {
    var_1.pers["killChains"] = var_1.pers["cur_kill_streak"];
    var_1 scripts\mp\utility\stats::_id_D551(var_1.pers["cur_kill_streak"]);
  }

  if(issubstr(var_0, "super_")) {
    return 0;
  }

  if(issubstr(var_0, "kill_ss")) {
    return 0;
  }

  if(issubstr(var_0, "kill")) {
    if(level._id_CC0F) {
      if(var_3 != var_1._id_EF10) {
        return 0;
      } else {
        var_1 notify("target_eliminated");
        var_1._id_EF10 = undefined;
        var_1 thread _id_6DB8();
        var_1 thread _id_A45D();
      }
    }

    var_5 = scripts\mp\rank::getscoreinfovalue("score_increment");
    return var_5;
  } else if(var_0 == "assist_ffa")
    var_1 scripts\mp\utility\script::_id_2C9F("earned_score_buffered", var_2);

  return 0;
}

_id_4CF0(var_0) {
  var_0 _id_0A8D::_id_9137("ffa_lead_first");
  var_1 = scripts\engine\utility::_id_1BD6(level.players, ::_id_3AF6);

  if(isDefined(var_1[1])) {
    var_1[1] _id_0A8D::_id_9137("ffa_lead_second");
  }

  if(isDefined(var_1[2]) && var_1.size > 2) {
    var_1[2] _id_0A8D::_id_9137("ffa_lead_third");
  }

  if(isDefined(var_1[var_1.size - 1]) && var_1.size > 3) {
    var_1[var_1.size - 1] _id_0A8D::_id_9137("ffa_lead_last");
  }

  level._id_4971 = 1;
}

_id_3AF6(var_0, var_1) {
  return var_0._id_038F >= var_1._id_038F;
}

_id_ABA1() {
  self endon("death_or_disconnect");
  self waittill("giveLoadout");
  _id_CA21();
}

_id_D6E0() {
  level._id_191B["allies"]["loadoutPrimary"] = "s4_pi_mike1911";
  level._id_191B["allies"]["loadoutPrimaryAttachment"] = "none";
  level._id_191B["allies"]["loadoutPrimaryAttachment2"] = "none";
  level._id_191B["allies"]["loadoutPrimaryCamo"] = "none";
  level._id_191B["allies"]["loadoutPrimaryReticle"] = "none";
  level._id_191B["allies"]["loadoutSecondary"] = "none";
  level._id_191B["allies"]["loadoutSecondaryAttachment"] = "none";
  level._id_191B["allies"]["loadoutSecondaryAttachment2"] = "none";
  level._id_191B["allies"]["loadoutSecondaryCamo"] = "none";
  level._id_191B["allies"]["loadoutSecondaryReticle"] = "none";
  level._id_191B["allies"]["loadoutEquipmentPrimary"] = "equip_throwing_knife";
  level._id_191B["allies"]["loadoutEquipmentSecondary"] = "none";
  level._id_191B["allies"]["loadoutSuper"] = "none";
  level._id_191B["allies"]["loadoutStreakType"] = "assault";
  level._id_191B["allies"]["loadoutKillstreak1"] = "none";
  level._id_191B["allies"]["loadoutKillstreak2"] = "none";
  level._id_191B["allies"]["loadoutKillstreak3"] = "none";
  level._id_191B["allies"]["loadoutPerks"] = ["specialty_fastreload"];
  level._id_191B["allies"]["loadoutGesture"] = "playerData";
  level._id_191B["axis"] = level._id_191B["allies"];
}

_id_CA21() {
  _id_6F96();

  if(level._id_191E == 2) {
    self._id_965F = "archetype_assault";
  }

  if(!istrue(scripts\cp_mp\utility\game_utility::_id_89EC())) {
    _id_6D22(self._id_965F);
  }

  self._id_191C = 0;
  self._id_191D = 0;
  var_0 = self._id_9676;
  self takeallweapons();
  waittillframeend;
  self giveweapon("iw7_g18_mpr_aon_fixed");
  self giveweapon("s4_me_knife_mp");
  self _meth_8514("s4_me_knife_mp");
  self giveweapon("s4_me_knife_mp");
  self _meth_819C("iw7_g18_mpr_aon_fixed");

  if(isDefined(var_0)) {
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0);
    self _meth_8565(var_0);
    self._id_62F1 = var_0;
  }

  scripts\mp\equipment::_id_391D();
  var_1 = "primary";

  if(level._id_191E == 2) {
    scripts\mp\equipment::giveequipment("power_blinkKnife", var_1);
  } else {
    scripts\mp\equipment::giveequipment("equip_throwing_knife", var_1);
  }

  scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch("iw7_g18_mpr_aon_fixed", 1);
}

_id_6F96() {
  var_0 = ["specialty_blindeye", "specialty_gpsjammer", "specialty_falldamage", "specialty_sharp_focus", "specialty_stalker"];

  foreach(var_2 in var_0) {
    scripts\mp\utility\perk::_id_6FC2(var_2);
  }
}

_id_6D22(var_0) {
  switch (var_0) {
    case "archetype_assault":
      var_0 = "assault_mp";
      break;
    default:
      if(!isDefined(level._id_191E) || level._id_191E == 0) {}

      var_0 = "assault_mp";
      break;
  }

  scripts\mp\utility\player::_id_0CF0(var_0 + "_classic");
}

onplayerconnect(var_0) {
  if(level._id_191E > 0) {
    if(level._id_15BD) {
      level._id_15BD = 0;
    }

    var_0.pers["class"] = "gamemode";
    var_0.pers["lastClass"] = "";
    var_0.class = var_0.pers["class"];
    var_0._id_8FAF = var_0.pers["lastClass"];
    var_0.pers["gamemodeLoadout"] = level._id_191B["allies"];
    var_0 loadweaponsforplayer(["iw7_g18_mpr_aon_fixed", "iw8_knife_mp"], 1);
  }
}

_id_6DB8() {
  level endon("game_ended");
  self notify("get_target");
  self endon("get_target");

  if(!_id_07D1::_id_60BE("prematch_done")) {
    level waittill("prematch_done");
  }

  var_0 = 0;

  if(!isDefined(self._id_EE9A) || !level._id_EEF4) {
    self._id_EE9A = [];
    self._id_EEAA = 0;
    var_0 = 1;

    foreach(var_2 in level.players) {
      if(var_2 == self) {
        continue;
      } else {
        self._id_EE9A[self._id_EE9A.size] = var_2;
      }
    }
  }

  if(self._id_EE9A.size > 0) {
    if(!level._id_EEF4) {
      self._id_EEAA = randomint(self._id_EE9A.size);
    } else {
      if(!var_0) {
        self._id_EEAA++;
      }

      if(self._id_EEAA == self._id_EE9A.size) {
        self._id_EEAA = 0;
      }
    }
  }

  self._id_EF10 = self._id_EE9A[self._id_EEAA];

  if(!isDefined(self._id_EF10)) {
    waitframe();
    thread _id_6DB8();
    thread _id_A45D();
    return;
  }

  waitframe();

  if(level._id_DCEE != 0) {
    self._id_4140 = self.origin;
    self._id_A97E = (0, 0, 10);
    _id_07D6::_id_C579(1, 1);
    var_4 = self._id_A908;
    _func_0167(var_4, "MP_INGAME_ONLY/OBJ_TARGET_CAPS");
    _func_0161(var_4, 90);
    _func_015D(var_4, "hud_icon_targeted_player_cir");
    _func_0172(var_4, 1);
    _id_07F9::_id_A8A5(var_4, self);
    _func_017A(var_4, 2);
    _func_0163(var_4, self._id_4140);
    _func_016B(var_4, "current");
    _id_07F9::_id_FB93(var_4, self._id_EF10);
    _func_0181(var_4, self._id_EF10);

    if(level._id_DCEE > 1) {
      thread _id_FD53();
    }
  }

  thread _id_EF11();
}

_id_EF11() {
  level endon("game_ended");
  self waittill("target_eliminated");
  thread scripts\mp\hud_message::showsplash("target_eliminated", scripts\mp\rank::getscoreinfovalue("kill"));
  _func_016B(self._id_A908, "done");
  _id_07D6::_id_C300();
}

_id_FD53() {
  level endon("game_ended");
  self._id_EF10 endon("disconnect");
  self endon("target_eliminated");
  thread _id_FD51();
  _func_0190(self._id_A908, 1);

  if(!isDefined(level._id_A912)) {
    level._id_A912 = 3.0;
  }

  for(;;) {
    if(isDefined(self._id_EF10)) {
      _id_07F9::_id_FB97(self._id_A908, self._id_4140 + self._id_A97E);
      _func_018F(self._id_A908);
      wait(level._id_A912);
      continue;
    }

    waitframe();
  }
}

_id_FD51() {
  level endon("game_ended");
  self._id_EF10 endon("disconnect");
  self endon("target_eliminated");

  for(;;) {
    if(isDefined(self._id_EF10)) {
      self._id_4140 = self._id_EF10.origin + (0, 0, 90);
    }

    waitframe();
  }
}

_id_A45D() {
  level endon("game_ended");
  self notify("endDeathWatcher");
  self endon("endDeathWatcher");

  if(!_id_07D1::_id_60BE("prematch_done")) {
    level waittill("prematch_done");
  }

  wait 2.5;

  if(isDefined(self._id_EF10)) {
    self iprintlnbold(&"MP/DM_NEW_TARGET", self._id_EF10.name);
  }
}