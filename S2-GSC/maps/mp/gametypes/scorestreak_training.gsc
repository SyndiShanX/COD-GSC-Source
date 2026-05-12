/******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\scorestreak_training.gsc
******************************************************/

func_00F9() {
  setdvarifuninitialized("previousScorestreakSelected", 0);
  level.var_80C0 = 8;
  level.var_80BF = 4;
  maps\mp\gametypes\_globallogic::func_00D5();
  lib_01DD::func_8A0C();
  maps\mp\gametypes\_globallogic::func_8A0C();
  if(isusingmatchrulesdata()) {
    level.var_5300 = ::func_5300;
    [[level.var_5300]]();
    level thread maps\mp\_utility::func_7C13();
  } else {
    maps\mp\_utility::func_7BF8(level.var_3FDC, 0, 0, 9);
    maps\mp\_utility::func_7BFA(level.var_3FDC, 0);
    maps\mp\_utility::func_7BF9(level.var_3FDC, 0);
    maps\mp\_utility::func_7BF7(level.var_3FDC, 0);
    maps\mp\_utility::func_7C04(level.var_3FDC, 0);
    maps\mp\_utility::func_7BF1(level.var_3FDC, 0);
    maps\mp\_utility::func_7BE5(level.var_3FDC, 0);
    setdynamicdvar("scr_game_allowkillcam", 0);
    level.var_6031 = 0;
    level.var_6035 = 0;
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
  level.var_4867 = 0;
  func_872E();
  maps\mp\_utility::func_873B(1);
  setnojiptime(1);
  setnojipscore(1);
  level.var_2F85 = 1;
  level.var_1B3E = 1;
  level.var_4696 = ::func_4696;
  level.var_6BA7 = ::func_6B81;
  level.var_6BAF = ::func_6BAF;
  level.var_6B5C = ::func_6B5C;
  level.var_6B7F = ::func_6B7F;
  level.var_1DEA = ::func_80BE;
  game["switchedsides"] = 0;
  if(level.var_6031 || level.var_6035) {
    level.var_62AD = ::maps\mp\gametypes\_damage::func_3FC8;
  }

  game["dialog"]["gametype"] = "streak_intro";
  thread deleteunusedentities();
  level thread init_score_training_mix();
}

init_score_training_mix() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread apply_score_training_mix();
  }
}

apply_score_training_mix() {
  self endon("disconnect");
  var_00 = self;
  for(;;) {
    self waittill("spawned_player");
    var_00 method_8626("score_training_mix", 1);
  }
}

func_5300() {
  maps\mp\_utility::func_8653(1);
  setdynamicdvar("scr_scorestreak_training_roundswitch", 0);
  maps\mp\_utility::func_7BF8("scorestreak_training", 0, 0, 9);
  setdynamicdvar("scr_scorestreak_training_roundlimit", 0);
  maps\mp\_utility::func_7BF7("scorestreak_training", 0);
  setdynamicdvar("scr_scorestreak_training_winlimit", 0);
  maps\mp\_utility::func_7C04("scorestreak_training", 0);
  setdynamicdvar("scr_scorestreak_training_halftime", 0);
  maps\mp\_utility::func_7BE5("scorestreak_training", 0);
  setdynamicdvar("scr_scorestreak_training_timelimit", 0);
  maps\mp\_utility::func_7BFA("scorestreak_training", 0);
}

func_6BAF() {
  setclientnamemode("auto_change");
  maps\mp\_utility::func_86DC("allies", &"OBJECTIVES_SCORESTREAK_TRAINING");
  maps\mp\_utility::func_86DC("axis", &"OBJECTIVES_SCORESTREAK_TRAINING");
  if(level.var_910F) {
    maps\mp\_utility::func_86DB("allies", &"OBJECTIVES_SCORESTREAK_TRAINING");
    maps\mp\_utility::func_86DB("axis", &"OBJECTIVES_SCORESTREAK_TRAINING");
  } else {
    maps\mp\_utility::func_86DB("allies", &"OBJECTIVES_SCORESTREAK_TRAINING_SCORE");
    maps\mp\_utility::func_86DB("axis", &"OBJECTIVES_SCORESTREAK_TRAINING_SCORE");
  }

  maps\mp\_utility::func_86D8("allies", &"OBJECTIVES_SCORESTREAK_TRAINING_HINT");
  maps\mp\_utility::func_86D8("axis", &"OBJECTIVES_SCORESTREAK_TRAINING_HINT");
  lib_050D::func_10E4();
  var_00[0] = "scorestreak_training";
  maps\mp\gametypes\_gameobjects::func_00F9(var_00);
  level thread func_6B6C();
  level.var_7691 = 0;
  level.var_7692 = 0;
  level.var_5A70 = 0;
  level.var_17EF = 1;
  level.var_7895 = 1;
}

func_6B6C() {
  for(;;) {
    level waittill("connected", var_00);
    if(level.var_7A67) {
      var_00 func_7D57();
    }
  }
}

func_6B5C(param_00, param_01, param_02) {
  self setclientomnvar("ui_show_scorestreak_training_hud", 0);
  var_03 = 0;
  foreach(var_05 in level.var_744A) {
    if(isDefined(var_05.var_015C) && var_05.var_015C > var_03) {
      var_03 = var_05.var_015C;
    }
  }

  if(game["state"] == "postgame" && param_01.var_015C >= var_03) {
    param_01.var_3B4B = 1;
  }
}

func_6B7F(param_00, param_01, param_02, param_03, param_04) {
  if(func_57BB(param_00, 1)) {
    return 1;
  }

  return 0;
}

func_57BB(param_00, param_01) {
  return func_57BC(param_00, param_01) || func_57BA(param_00, param_01);
}

func_57BC(param_00, param_01) {
  switch (param_00) {
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
      if(isDefined(param_01) && param_01) {
        maps\mp\gametypes\_missions::func_7750("ch_scorestreaktraining_kills");
      }
      return 1;

    default:
      return 0;
  }
}

func_57BA(param_00, param_01) {
  switch (param_00) {
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
      if(isDefined(param_01) && param_01) {
        maps\mp\gametypes\_missions::func_7750("ch_scorestreaktraining_flakMaster");
        self.var_012C["scorestreaksDowned"]++;
        maps\mp\_utility::func_867C(self.var_012C["scorestreaksDowned"]);
      }
      return 1;

    default:
      return 0;
  }
}

func_872E() {
  level.var_80B3 = maps\mp\gametypes\_class::func_44B4();
  level.var_80B3["loadoutDivision"] = 1;
  level.var_80B3["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::func_473C(16859136, 0);
  level.var_80B3["loadoutSecondaryWeaponStruct"] = maps\mp\_utility::func_473C(17002496, 0);
  for(var_00 = 0; var_00 < 9; var_00++) {
    level.var_80B3["loadoutPerksGUID"][var_00] = 0;
  }

  level.var_80B1 = maps\mp\gametypes\_class::func_44B4();
  level.var_80B1["loadoutDivision"] = 1;
  level.var_80B1["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::func_473C(16875520, 0);
  level.var_80B1["loadoutSecondaryWeaponStruct"] = maps\mp\_utility::func_473C(16859136, 0);
  level.var_80B2 = maps\mp\gametypes\_class::func_44B4();
  level.var_80B2["loadoutDivision"] = 0;
  level.var_80B2["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::func_473C(16879616, 0);
  level.var_80B2["loadoutSecondaryWeaponStruct"] = maps\mp\_utility::func_473C(16957440, 0);
}

func_6B81() {
  thread func_47A9();
  if(isbot(self) && self.var_01A7 == "axis" && !isDefined(level.var_80C2) || !level.var_80C2) {
    level thread func_638D(self);
    level.var_80C2 = 1;
  }

  if(isPlayer(self) && !isbot(self) && !function_01EF(self)) {
    if(self method_85C0()) {
      self method_85BF(0);
    }

    self setdemigod(1);
    wait 0.05;
    thread func_A93E();
    return;
  }

  func_80BE();
}

func_80BE() {
  var_00 = isPlayer(self) && !isbot(self) && !function_01EF(self);
  self.var_012C["class"] = "gamemode";
  self.var_012C["lastClass"] = "";
  if(var_00) {
    self.var_012C["gamemodeLoadout"] = level.var_80B3;
  } else if(self.var_01A7 == "allies") {
    self.var_012C["gamemodeLoadout"] = level.var_80B1;
  } else {
    self.var_012C["gamemodeLoadout"] = level.var_80B2;
  }

  self.var_2319 = self.var_012C["class"];
  self.var_5B84 = self.var_012C["lastClass"];
  maps\mp\gametypes\_class::func_4790(self.var_01A7, self.var_2319);
  if(var_00) {
    thread func_47A9();
    self.var_00CE = 1;
    maps\mp\_utility::func_47A2("specialty_eagleeyes");
  }
}

func_7D57() {
  func_7D56("ch_scorestreaktraining_kills");
  func_7D56("ch_scorestreaktraining_allStreaks");
  func_7D56("ch_scorestreaktraining_halfStreaks");
  func_7D56("ch_scorestreaktraining_practiceMakesPerfect");
  func_7D56("ch_scorestreaktraining_multikill");
  func_7D56("ch_scorestreaktraining_flakMaster");
}

func_7D56(param_00) {
  maps\mp\gametypes\_hud_util::func_209F(param_00, 1);
  maps\mp\gametypes\_hud_util::func_209E(param_00, 0);
}

func_47A9() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self notify("unlimitedAmmoEnabled");
  self endon("unlimitedAmmoEnabled");
  for(;;) {
    var_00 = self getcurrentweapon();
    if(var_00 != "none" && !maps\mp\_utility::func_5740(var_00)) {
      var_01 = self getfractionmaxammo(var_00);
      if(var_01 < 0.2) {
        self givemaxammo(var_00);
      }
    }

    var_02 = self method_831F();
    if(var_02 != "none" && !maps\mp\_utility::func_5740(var_02)) {
      var_01 = self getfractionmaxammo(var_02);
      if(var_01 < 0.4) {
        self givemaxammo(var_02);
      }
    }

    var_03 = self method_834A();
    if(var_03 != "none" && !maps\mp\_utility::func_5740(var_03)) {
      var_01 = self getfractionmaxammo(var_03);
      if(var_01 < 0.4) {
        self givemaxammo(var_03);
      }
    }

    wait(1);
  }
}

func_A93E() {
  self endon("disconnect");
  level endon("game_ended");
  self endon("death");
  self setclientomnvar("ui_show_scorestreak_training_hud", 1);
  for(;;) {
    self waittill("luinotifyserver", var_00, var_01);
    if(var_00 != "scorestreak_training_selection" || var_01 == -1) {
      continue;
    }

    self notify("cancel_stowed_ammo");
    maps\mp\_utility::func_940B(0);
    thread maps\mp\killstreaks\_killstreaks::func_2400();
    self setclientomnvar("ks_icon0", 0);
    var_02 = maps\mp\_utility::func_4544(var_01);
    thread maps\mp\gametypes\_hud_message::func_5A78(var_02, maps\mp\killstreaks\_killstreaks::func_46B4(var_02), undefined, 0);
    thread maps\mp\killstreaks\_killstreaks::func_478D(var_02, 0, 0, self);
    lib_0468::func_0A2A("streakTraining");
  }
}

func_244D() {
  self setclientomnvar("ui_show_scorestreak_training_hud", 0);
}

func_4696(param_00) {
  var_01 = self;
  if(!isDefined(var_01)) {
    for(var_02 = 0; var_02 < level.var_744A.size; var_02++) {
      if(var_02 == param_00) {
        var_01 = level.var_744A[var_02];
        break;
      }
    }
  }

  if(isPlayer(var_01) && !isbot(var_01) && !function_01EF(var_01) && level.var_53C6) {
    return func_6FBD(var_01);
  }

  return level.var_908F[var_01.var_01A7][randomint(level.var_908F[var_01.var_01A7].size)];
}

func_6FBD(param_00) {
  if(!isDefined(level.var_80C1)) {
    level.var_80C1 = common_scripts\utility::func_44BE("scorestreak_training_player_spawn", "targetname");
  }

  var_01 = level.var_80C1[randomint(level.var_80C1.size)];
  return var_01;
}

func_638D(param_00) {
  level endon("game_ended");
  param_00 endon("disconnect");
  wait(5);
  for(;;) {
    if(!level.var_9854[param_00.var_01A7]) {
      var_01 = "";
      var_02 = randomint(100);
      if(var_02 > 60) {
        param_00 thread maps\mp\killstreaks\_flak_gun::func_A20C("counter_uav");
        var_01 = "counter_uav";
      } else {
        level thread maps\mp\killstreaks\_uav::func_5C30(param_00, param_00.var_01A7, "uav");
        var_01 = "uav";
      }

      wait(10);
      continue;
    }

    wait 0.05;
  }
}

deleteunusedentities() {
  level endon("game_ended");
  var_00 = [];
  var_01 = getEntArray("jerry_can_spawn", "targetname");
  var_00 = common_scripts\utility::func_0F73(var_00, var_01);
  var_01 = getEntArray("reactive_swing_target", "targetname");
  var_00 = common_scripts\utility::func_0F73(var_00, var_01);
  var_01 = getEntArray("reactive_reset_target", "targetname");
  var_00 = common_scripts\utility::func_0F73(var_00, var_01);
  var_01 = getEntArray("flip_target", "targetname");
  var_00 = common_scripts\utility::func_0F73(var_00, var_01);
  var_01 = getEntArray("flip_target_reset", "targetname");
  var_00 = common_scripts\utility::func_0F73(var_00, var_01);
  var_01 = getEntArray("popup_target", "targetname");
  var_00 = common_scripts\utility::func_0F73(var_00, var_01);
  var_01 = getEntArray("plate_sequence", "targetname");
  var_00 = common_scripts\utility::func_0F73(var_00, var_01);
  var_01 = getEntArray("reactive_explosive_target", "targetname");
  var_00 = common_scripts\utility::func_0F73(var_00, var_01);
  var_01 = getEntArray("interactive_chair_trigger", "targetname");
  var_00 = common_scripts\utility::func_0F73(var_00, var_01);
  foreach(var_03 in var_00) {
    var_03 delete();
    wait 0.05;
  }
}