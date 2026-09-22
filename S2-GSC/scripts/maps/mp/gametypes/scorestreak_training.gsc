/**************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\scorestreak_training.gsc
**************************************************************/

main() {
  setdvarifuninitialized("previousScorestreakSelected", 0);
  level.settargetent = 8;
  level.setshader = 4;
  _id_04D4::init();
  maps\mp\gametypes\_callbacksetup::setupcallbacks();
  _id_04D4::setupcallbacks();

  if(_isusingmatchrulesdata()) {
    level._id_5300 = ::_id_5300;
    [[level._id_5300]]();
    level thread maps\mp\_utility::_id_7C13();
  } else {
    maps\mp\_utility::registerroundswitchdvar(level.gametype, 0, 0, 9);
    maps\mp\_utility::registertimelimitdvar(level.gametype, 0);
    maps\mp\_utility::registerscorelimitdvar(level.gametype, 0);
    maps\mp\_utility::registerroundlimitdvar(level.gametype, 0);
    maps\mp\_utility::registerwinlimitdvar(level.gametype, 0);
    maps\mp\_utility::registernumlivesdvar(level.gametype, 0);
    maps\mp\_utility::registerhalftimedvar(level.gametype, 0);
    _setdynamicdvar("scr_game_allowkillcam", 0);
    level._id_6031 = 0;
    level._id_6035 = 0;
  }

  setDvar("scr_scorestreak_training_timelimit", 0);
  setDvar("scr_scorestreak_training_scorelimit", 0);
  setDvar("scr_game_matchstarttime", 1);
  setDvar("scr_scorestreak_training_numlives", 0);
  setDvar("scr_game_allowkillcam", 0);
  setDvar("scr_game_spectatetype", 0);
  setDvar("scr_player_forcerespawn", 1);
  setDvar("scr_game_killstreakdelay", 0);
  setDvar("scr_player_maxhealth", 100);
  setDvar("scr_player_healthregentime", 5);
  setDvar("scr_game_roundstarttime", 1);
  setDvar("1689", 0);
  setDvar("scr_scorestreak_training_playerrespawndelay", 0);
  setDvar("scr_scorestreak_training_waverespawndelay", 0);
  setDvar("scr_game_radarMode", 0);
  setDvar("scr_game_forceuav", 0);
  setDvar("isMLGMatch", 0);
  setDvar("scr_team_fftype", 0);
  setDvar("scr_game_onlyheadshots", 0);
  setDvar("2043", 0);
  level._id_4867 = 0;
  _id_872E();
  maps\mp\_utility::_id_873B(1);
  _setnojiptime(1);
  _func_246(1);
  level.disableforfeit = 1;
  level._id_1B3E = 1;
  level._id_4696 = ::_id_4696;
  level._id_6BA7 = ::_id_6B81;
  level._id_6BAF = ::_id_6BAF;
  level._id_6B5C = ::_id_6B5C;
  level._id_6B7F = ::_id_6B7F;
  level._id_1DEA = ::clearalltextafterhudelem;
  game["switchedsides"] = 0;

  if(level._id_6031 || level._id_6035) {
    level._id_62AD = maps\mp\gametypes\_damage::_id_3FC8;
  }

  game["dialog"]["gametype"] = "streak_intro";
  thread deleteunusedentities();
  level thread init_score_training_mix();
}

init_score_training_mix() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 thread apply_score_training_mix();
  }
}

apply_score_training_mix() {
  self endon("disconnect");
  var_0 = self;

  for(;;) {
    self waittill("spawned_player");
    var_0 clientaddsoundsubmix("score_training_mix", 1.0);
  }
}

_id_5300() {
  maps\mp\_utility::_id_8653(1);
  _setdynamicdvar("scr_scorestreak_training_roundswitch", 0);
  maps\mp\_utility::registerroundswitchdvar("scorestreak_training", 0, 0, 9);
  _setdynamicdvar("scr_scorestreak_training_roundlimit", 0);
  maps\mp\_utility::registerroundlimitdvar("scorestreak_training", 0);
  _setdynamicdvar("scr_scorestreak_training_winlimit", 0);
  maps\mp\_utility::registerwinlimitdvar("scorestreak_training", 0);
  _setdynamicdvar("scr_scorestreak_training_halftime", 0);
  maps\mp\_utility::registerhalftimedvar("scorestreak_training", 0);
  _setdynamicdvar("scr_scorestreak_training_timelimit", 0);
  maps\mp\_utility::registertimelimitdvar("scorestreak_training", 0);
}

_id_6BAF() {
  _setclientnamemode("auto_change");
  maps\mp\_utility::setobjectivetext("allies", &"OBJECTIVES_SCORESTREAK_TRAINING");
  maps\mp\_utility::setobjectivetext("axis", &"OBJECTIVES_SCORESTREAK_TRAINING");

  if(level.splitscreen) {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_SCORESTREAK_TRAINING");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_SCORESTREAK_TRAINING");
  } else {
    maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_SCORESTREAK_TRAINING_SCORE");
    maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_SCORESTREAK_TRAINING_SCORE");
  }

  maps\mp\_utility::setobjectivehinttext("allies", &"OBJECTIVES_SCORESTREAK_TRAINING_HINT");
  maps\mp\_utility::setobjectivehinttext("axis", &"OBJECTIVES_SCORESTREAK_TRAINING_HINT");
  _id_050D::_id_10E4();
  var_0[0] = "scorestreak_training";
  _id_04D1::main(var_0);
  level thread onplayerconnect();
  level._id_7691 = 0;
  level._id_7692 = 0;
  level._id_5A70 = 0;
  level._id_17EF = 1;
  level._id_7895 = 1;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(level.rankedmatch) {
      var_0 _id_7D57();
    }
  }
}

_id_6B5C(var_0, var_1, var_2) {
  self setclientomnvar("ui_show_scorestreak_training_hud", 0);
  var_3 = 0;

  foreach(var_5 in level.players) {
    if(isDefined(var_5.score) && var_5.score > var_3) {
      var_3 = var_5.score;
    }
  }

  if(game["state"] == "postgame" && var_1.score >= var_3) {
    var_1._id_3B4B = 1;
  }
}

_id_6B7F(var_0, var_1, var_2, var_3, var_4) {
  if(_id_57BB(var_0, 1)) {
    return 1;
  }

  return 0;
}

_id_57BB(var_0, var_1) {
  return _id_57BC(var_0, var_1) || _id_57BA(var_0, var_1);
}

_id_57BC(var_0, var_1) {
  switch (var_0) {
    case "attack_dogs_kill":
    case "airdrop_kill":
    case "missile_strike_kill":
    case "mortar_strike_kill":
    case "flamethrower_kill":
    case "plane_gunner_kill":
    case "airstrike_kill":
    case "firebomb_kill":
    case "fritzx_kill":
    case "fighter_strike_kill":
      if(isDefined(var_1) && var_1) {
        maps\mp\gametypes\_missions::processchallenge("ch_scorestreaktraining_kills");
      }

      return 1;
    default:
      return 0;
  }
}

_id_57BA(var_0, var_1) {
  switch (var_0) {
    case "fritzx_destroyed":
    case "attack_dogs_destroyed":
    case "advanced_uav_destroyed":
    case "assist_killstreak_destroyed":
    case "plane_gunner_destroyed":
    case "emergency_carepackage_plane_destroyed":
    case "carepackage_plane_destroyed":
    case "fighter_strike_destroyed":
    case "fire_bombing_run_destroyed":
    case "airstrike_destroyed":
    case "counter_uav_destroyed":
    case "uav_destroyed":
      if(isDefined(var_1) && var_1) {
        maps\mp\gametypes\_missions::processchallenge("ch_scorestreaktraining_flakMaster");
        self.pers["scorestreaksDowned"]++;
        maps\mp\_utility::_id_867C(self.pers["scorestreaksDowned"]);
      }

      return 1;
    default:
      return 0;
  }
}

_id_872E() {
  level.makeunusable = maps\mp\gametypes\_class::_id_44B4();
  level.makeunusable["loadoutDivision"] = 1;
  level.makeunusable["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::_id_473C(16859136, 0);
  level.makeunusable["loadoutSecondaryWeaponStruct"] = maps\mp\_utility::_id_473C(17002496, 0);

  for(var_0 = 0; var_0 < 9; var_0++) {
    level.makeunusable["loadoutPerksGUID"][var_0] = 0;
  }

  level._id_80B1 = maps\mp\gametypes\_class::_id_44B4();
  level._id_80B1["loadoutDivision"] = 1;
  level._id_80B1["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::_id_473C(16875520, 0);
  level._id_80B1["loadoutSecondaryWeaponStruct"] = maps\mp\_utility::_id_473C(16859136, 0);
  level.makeusable = maps\mp\gametypes\_class::_id_44B4();
  level.makeusable["loadoutDivision"] = 0;
  level.makeusable["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::_id_473C(16879616, 0);
  level.makeusable["loadoutSecondaryWeaponStruct"] = maps\mp\_utility::_id_473C(16957440, 0);
}

_id_6B81() {
  thread _id_47A9();

  if(isbot(self) && self.team == "axis" && (!isDefined(level.settimer) || !level.settimer)) {
    level thread _id_638D(self);
    level.settimer = 1;
  }

  if(isPlayer(self) && !isbot(self) && !_isagent(self)) {
    if(self _meth_85C0()) {
      self _meth_85BF(0);
    }

    self setdemigod(1);
    waitframe();
    thread _id_A93E();
  } else
    clearalltextafterhudelem();
}

clearalltextafterhudelem() {
  var_0 = isPlayer(self) && !isbot(self) && !_isagent(self);
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "";

  if(var_0) {
    self.pers["gamemodeLoadout"] = level.makeunusable;
  } else if(self.team == "allies") {
    self.pers["gamemodeLoadout"] = level._id_80B1;
  } else {
    self.pers["gamemodeLoadout"] = level.makeusable;
  }

  self.class = self.pers["class"];
  self.lastclass = self.pers["lastClass"];
  maps\mp\gametypes\_class::_id_4790(self.team, self.class);

  if(var_0) {
    thread _id_47A9();
    self._id_00CE = 1;
    maps\mp\_utility::giveperk("specialty_eagleeyes");
  }
}

_id_7D57() {
  _id_7D56("ch_scorestreaktraining_kills");
  _id_7D56("ch_scorestreaktraining_allStreaks");
  _id_7D56("ch_scorestreaktraining_halfStreaks");
  _id_7D56("ch_scorestreaktraining_practiceMakesPerfect");
  _id_7D56("ch_scorestreaktraining_multikill");
  _id_7D56("ch_scorestreaktraining_flakMaster");
}

_id_7D56(var_0) {
  maps\mp\gametypes\_hud_util::_id_209F(var_0, 1);
  maps\mp\gametypes\_hud_util::_id_209E(var_0, 0);
}

_id_47A9() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self notify("unlimitedAmmoEnabled");
  self endon("unlimitedAmmoEnabled");

  for(;;) {
    var_0 = self getcurrentweapon();

    if(var_0 != "none" && !maps\mp\_utility::iskillstreakweapon(var_0)) {
      var_1 = self getfractionmaxammo(var_0);

      if(var_1 < 0.2) {
        self givemaxammo(var_0);
      }
    }

    var_2 = self getoffhandsecondaryclass();

    if(var_2 != "none" && !maps\mp\_utility::iskillstreakweapon(var_2)) {
      var_1 = self getfractionmaxammo(var_2);

      if(var_1 < 0.4) {
        self givemaxammo(var_2);
      }
    }

    var_3 = self getlethalweapon();

    if(var_3 != "none" && !maps\mp\_utility::iskillstreakweapon(var_3)) {
      var_1 = self getfractionmaxammo(var_3);

      if(var_1 < 0.4) {
        self givemaxammo(var_3);
      }
    }

    wait 1;
  }
}

_id_A93E() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self setclientomnvar("ui_show_scorestreak_training_hud", 1);

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 != "scorestreak_training_selection" || var_1 == -1) {
      continue;
    }
    self notify("cancel_stowed_ammo");
    maps\mp\_utility::_id_940B(0);
    thread _id_051E::_id_2400();
    self setclientomnvar("ks_icon0", 0);
    var_2 = maps\mp\_utility::_id_4544(var_1);
    thread maps\mp\gametypes\_hud_message::killstreaksplashnotify(var_2, _id_051E::_id_46B4(var_2), undefined, 0);
    thread _id_051E::_id_478D(var_2, 0, 0, self);
    _id_0468::_id_0A2A("streakTraining");
  }
}

_id_244D() {
  self setclientomnvar("ui_show_scorestreak_training_hud", 0);
}

_id_4696(var_0) {
  var_1 = self;

  if(!isDefined(var_1)) {
    for(var_2 = 0; var_2 < level.players.size; var_2++) {
      if(var_2 == var_0) {
        var_1 = level.players[var_2];
        break;
      }
    }
  }

  if(isPlayer(var_1) && !isbot(var_1) && !_isagent(var_1) && level._id_53C6) {
    return _id_6FBD(var_1);
  }

  return level._id_908F[var_1.team][randomint(level._id_908F[var_1.team].size)];
}

_id_6FBD(var_0) {
  if(!isDefined(level.cleartargetent)) {
    level.cleartargetent = common_scripts\utility::_id_44BE("scorestreak_training_player_spawn", "targetname");
  }

  var_1 = level.cleartargetent[randomint(level.cleartargetent.size)];
  return var_1;
}

_id_638D(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  wait 5.0;

  for(;;) {
    if(!level._id_9854[var_0.team]) {
      var_1 = "";
      var_2 = randomint(100);

      if(var_2 > 60) {
        var_0 thread _id_051B::_id_A20C("counter_uav");
        var_1 = "counter_uav";
      } else {
        level thread _id_0525::_id_5C30(var_0, var_0.team, "uav");
        var_1 = "uav";
      }

      wait 10.0;
      continue;
    }

    waitframe();
  }
}

deleteunusedentities() {
  level endon("game_ended");
  var_0 = [];
  var_1 = getEntArray("jerry_can_spawn", "targetname");
  var_0 = common_scripts\utility::_id_0F73(var_0, var_1);
  var_1 = getEntArray("reactive_swing_target", "targetname");
  var_0 = common_scripts\utility::_id_0F73(var_0, var_1);
  var_1 = getEntArray("reactive_reset_target", "targetname");
  var_0 = common_scripts\utility::_id_0F73(var_0, var_1);
  var_1 = getEntArray("flip_target", "targetname");
  var_0 = common_scripts\utility::_id_0F73(var_0, var_1);
  var_1 = getEntArray("flip_target_reset", "targetname");
  var_0 = common_scripts\utility::_id_0F73(var_0, var_1);
  var_1 = getEntArray("popup_target", "targetname");
  var_0 = common_scripts\utility::_id_0F73(var_0, var_1);
  var_1 = getEntArray("plate_sequence", "targetname");
  var_0 = common_scripts\utility::_id_0F73(var_0, var_1);
  var_1 = getEntArray("reactive_explosive_target", "targetname");
  var_0 = common_scripts\utility::_id_0F73(var_0, var_1);
  var_1 = getEntArray("interactive_chair_trigger", "targetname");
  var_0 = common_scripts\utility::_id_0F73(var_0, var_1);

  foreach(var_3 in var_0) {
    var_3 delete();
    waitframe();
  }
}