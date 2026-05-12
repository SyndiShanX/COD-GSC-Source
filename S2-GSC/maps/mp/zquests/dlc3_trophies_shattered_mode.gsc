/************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zquests\dlc3_trophies_shattered_mode.gsc
************************************************************/

func_00D5() {
  level thread run_shattered_trophy_event_1();
  level thread run_shattered_trophy_event_2();
  level thread run_shattered_trophy_event_7();
  level thread run_shattered_trophy_event_9();
  level thread run_shattered_trophy_event_10();
}

complete_shattered_trophy_event_1(param_00) {
  maps\mp\gametypes\zombies::func_47A8("DLC3_ZM_RIDE", param_00, 1);
}

run_shattered_trophy_event_1() {
  level thread maps\mp\zquests\zmb_secret_challenges_util::run_trophy_challenge(0, ::monitor_players_waves_survival, ::complete_shattered_trophy_event_1, 100, undefined, "DLC3_ZM_RIDE");
}

complete_shattered_trophy_event_2() {
  maps\mp\gametypes\zombies::func_47A8("DLC3_ZM_POWER", undefined, 1);
}

run_shattered_trophy_event_2() {
  while(!common_scripts\utility::func_3C83("flag_sword_assembled")) {
    wait(0.5);
  }

  common_scripts\utility::func_3C9F("flag_sword_assembled");
  complete_shattered_trophy_event_2();
}

complete_shattered_trophy_event_3() {
  if(!lib_0547::is_zm_shattered_thule_map()) {
    return;
  }

  maps\mp\gametypes\zombies::func_47A8("DLC3_ZM_CHRISTMAS", undefined, 1);
}

complete_shattered_trophy_event_4(param_00, param_01, param_02) {
  if(param_01.size - param_02.size > 25) {
    maps\mp\gametypes\zombies::func_47A8("DLC3_ZM_BABY", param_00, 0);
  }
}

complete_shattered_trophy_event_5() {
  if(!lib_0547::is_zm_shattered_dnk_map()) {
    return;
  }

  maps\mp\gametypes\zombies::func_47A8("DLC3_ZM_SEASICK", undefined, 0);
}

complete_shattered_trophy_event_6() {
  if(!lib_0547::is_zm_shattered_windmill_map()) {
    return;
  }

  maps\mp\gametypes\zombies::func_47A8("DLC3_ZM_JUSTBEGUN", undefined, 1);
}

complete_shattered_escape_event() {
  complete_shattered_trophy_event_3();
  complete_shattered_trophy_event_5();
  complete_shattered_trophy_event_6();
  complete_shattered_trophy_event_10();
}

complete_shattered_trophy_event_7() {
  if(!common_scripts\utility::func_562E(level.guardian_solo_trophy_fail)) {
    maps\mp\gametypes\zombies::func_47A8("DLC3_ZM_GOLIATH", undefined, 0);
  }
}

run_shattered_trophy_event_7() {
  level endon("game_ended");
  var_00 = 0;
  for(;;) {
    level waittill("connected", var_01);
    if(var_00 >= 1) {
      level.guardian_solo_trophy_fail = 1;
      break;
    }

    var_00++;
  }
}

complete_shattered_trophy_event_8(param_00) {
  maps\mp\gametypes\zombies::func_47A8("DLC3_ZM_LURKER", param_00, 0);
}

complete_shattered_trophy_event_9(param_00) {
  maps\mp\gametypes\zombies::func_47A8("DLC3_ZM_ELITE", param_00, 0);
}

run_shattered_trophy_event_9() {
  level thread maps\mp\zquests\zmb_secret_challenges_util::run_trophy_challenge(0, ::monitor_player_shotgun_level, ::complete_shattered_trophy_event_9, undefined, undefined, "DLC3_ZM_ELITE");
}

complete_shattered_trophy_event_10() {
  var_00 = 0;
  foreach(var_02 in level.var_744A) {
    var_00 = var_00 | common_scripts\utility::func_562E(var_02.shotgun_escape_trophy_fail);
  }

  var_04 = lib_0547::zombie_shattered_get_map_number();
  if(!var_00 && var_04 > 0) {
    var_00 = 0;
    var_05 = 1 << var_04 - 1;
    foreach(var_02 in level.var_744A) {
      var_07 = var_02 getrankedplayerdata(common_scripts\utility::func_46A8(), "zmShatteredRecord", "ETDMapInfo");
      var_07 = var_07 | var_05;
      var_02 setrankedplayerdata(common_scripts\utility::func_46A8(), "zmShatteredRecord", "ETDMapInfo", var_07);
      if(var_07 >= 7) {
        maps\mp\gametypes\zombies::func_47A8("DLC3_ZM_EXTRA", var_02, 0);
      }
    }
  }
}

run_shattered_trophy_event_10() {
  level thread maps\mp\zquests\zmb_secret_challenges_util::run_trophy_challenge(0, ::shotgun_trophy_10_initialize_player, undefined, undefined, undefined, "DLC3_ZM_EXTRA");
}

monitor_players_waves_survival(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  level endon(param_00.trophyflag);
  var_02 = 0;
  var_02 = var_01 getrankedplayerdata(common_scripts\utility::func_46A8(), "zmShatteredRecord", "rideOfCentury");
  if(var_02 < param_00.var_4800) {
    for(;;) {
      var_03 = param_00.var_4800;
      level waittill("round complete");
      var_04 = var_02 + level.objectivescompleted;
      var_01 setrankedplayerdata(common_scripts\utility::func_46A8(), "zmShatteredRecord", "rideOfCentury", var_04);
      if(var_04 >= var_03) {
        break;
      }
    }

    param_00 maps\mp\zquests\zmb_secret_challenges_util::handle_result(1, var_01);
  }
}

monitor_player_shotgun_level(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  level endon(param_00.trophyflag);
  while(!isDefined(level.zmshotgunmaxlevel)) {
    wait(0.5);
  }

  for(;;) {
    var_01 waittill("shotgun_level_up");
    if(var_01 maps\mp\zombies\_zombies_progression::get_zm_shotgun_player_level() == level.zmshotgunmaxlevel) {
      param_00 maps\mp\zquests\zmb_secret_challenges_util::handle_result(1, var_01);
      break;
    }
  }
}

shotgun_trophy_10_initialize_player(param_00) {
  self endon("disconnect");
  self.shotgun_escape_trophy_fail = 0;
  for(;;) {
    self waittill("perkmachine_activated", var_01);
    if(isDefined(var_01) && var_01.var_109 != "armor") {
      self.shotgun_escape_trophy_fail = 1;
      break;
    }
  }
}