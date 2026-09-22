/********************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zquests\dlc3_trophies_shattered_mode.gsc
********************************************************************/

init() {
  level thread run_shattered_trophy_event_1();
  level thread run_shattered_trophy_event_2();
  level thread run_shattered_trophy_event_7();
  level thread run_shattered_trophy_event_9();
  level thread run_shattered_trophy_event_10();
}

complete_shattered_trophy_event_1(var_0) {
  maps\mp\gametypes\zombies::_id_47A8("DLC3_ZM_RIDE", var_0, 1);
}

run_shattered_trophy_event_1() {
  level thread maps\mp\zquests\zmb_secret_challenges_util::run_trophy_challenge(0, ::monitor_players_waves_survival, ::complete_shattered_trophy_event_1, 100, undefined, "DLC3_ZM_RIDE");
}

complete_shattered_trophy_event_2() {
  maps\mp\gametypes\zombies::_id_47A8("DLC3_ZM_POWER", undefined, 1);
}

run_shattered_trophy_event_2() {
  while(!common_scripts\utility::_id_3C83("flag_sword_assembled")) {
    wait 0.5;
  }

  common_scripts\utility::_id_3C9F("flag_sword_assembled");
  complete_shattered_trophy_event_2();
}

complete_shattered_trophy_event_3() {
  if(!_id_0547::is_zm_shattered_thule_map()) {
    return;
  }
  maps\mp\gametypes\zombies::_id_47A8("DLC3_ZM_CHRISTMAS", undefined, 1);
}

complete_shattered_trophy_event_4(var_0, var_1, var_2) {
  if(var_1.size - var_2.size > 25) {
    maps\mp\gametypes\zombies::_id_47A8("DLC3_ZM_BABY", var_0, 0);
  }
}

complete_shattered_trophy_event_5() {
  if(!_id_0547::is_zm_shattered_dnk_map()) {
    return;
  }
  maps\mp\gametypes\zombies::_id_47A8("DLC3_ZM_SEASICK", undefined, 0);
}

complete_shattered_trophy_event_6() {
  if(!_id_0547::is_zm_shattered_windmill_map()) {
    return;
  }
  maps\mp\gametypes\zombies::_id_47A8("DLC3_ZM_JUSTBEGUN", undefined, 1);
}

complete_shattered_escape_event() {
  complete_shattered_trophy_event_3();
  complete_shattered_trophy_event_5();
  complete_shattered_trophy_event_6();
  complete_shattered_trophy_event_10();
}

complete_shattered_trophy_event_7() {
  if(!common_scripts\utility::_id_562E(level.guardian_solo_trophy_fail)) {
    maps\mp\gametypes\zombies::_id_47A8("DLC3_ZM_GOLIATH", undefined, 0);
  }
}

run_shattered_trophy_event_7() {
  level endon("game_ended");
  var_0 = 0;

  for(;;) {
    level waittill("connected", var_1);

    if(var_0 >= 1) {
      level.guardian_solo_trophy_fail = 1;
      break;
    }

    var_0++;
  }
}

complete_shattered_trophy_event_8(var_0) {
  maps\mp\gametypes\zombies::_id_47A8("DLC3_ZM_LURKER", var_0, 0);
}

complete_shattered_trophy_event_9(var_0) {
  maps\mp\gametypes\zombies::_id_47A8("DLC3_ZM_ELITE", var_0, 0);
}

run_shattered_trophy_event_9() {
  level thread maps\mp\zquests\zmb_secret_challenges_util::run_trophy_challenge(0, ::monitor_player_shotgun_level, ::complete_shattered_trophy_event_9, undefined, undefined, "DLC3_ZM_ELITE");
}

complete_shattered_trophy_event_10() {
  var_0 = 0;

  foreach(var_2 in level.players) {
    var_0 = var_0 | common_scripts\utility::_id_562E(var_2.shotgun_escape_trophy_fail);
  }

  var_4 = _id_0547::zombie_shattered_get_map_number();

  if(!var_0 && var_4 > 0) {
    var_0 = 0;
    var_5 = 1 << var_4 - 1;

    foreach(var_2 in level.players) {
      var_7 = var_2 getplayerdata(common_scripts\utility::_id_46A8(), "zmShatteredRecord", "ETDMapInfo");
      var_7 = var_7 | var_5;
      var_2 setplayerdata(common_scripts\utility::_id_46A8(), "zmShatteredRecord", "ETDMapInfo", var_7);

      if(var_7 >= 7) {
        maps\mp\gametypes\zombies::_id_47A8("DLC3_ZM_EXTRA", var_2, 0);
      }
    }
  }
}

run_shattered_trophy_event_10() {
  level thread maps\mp\zquests\zmb_secret_challenges_util::run_trophy_challenge(0, ::shotgun_trophy_10_initialize_player, undefined, undefined, undefined, "DLC3_ZM_EXTRA");
}

monitor_players_waves_survival(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  level endon(var_0.trophyflag);
  var_2 = 0;
  var_2 = var_1 getplayerdata(common_scripts\utility::_id_46A8(), "zmShatteredRecord", "rideOfCentury");

  if(var_2 < var_0._id_4800) {
    for(;;) {
      var_3 = var_0._id_4800;
      level waittill("round complete");
      var_4 = var_2 + level.objectivescompleted;
      var_1 setplayerdata(common_scripts\utility::_id_46A8(), "zmShatteredRecord", "rideOfCentury", var_4);

      if(var_4 >= var_3) {
        break;
      }
    }

    var_0 maps\mp\zquests\zmb_secret_challenges_util::handle_result(1, var_1);
  }
}

monitor_player_shotgun_level(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  level endon(var_0.trophyflag);

  while(!isDefined(level.zmshotgunmaxlevel)) {
    wait 0.5;
  }

  for(;;) {
    var_1 waittill("shotgun_level_up");

    if(var_1 maps\mp\zombies\_zombies_progression::get_zm_shotgun_player_level() == level.zmshotgunmaxlevel) {
      var_0 maps\mp\zquests\zmb_secret_challenges_util::handle_result(1, var_1);
      break;
    }
  }
}

shotgun_trophy_10_initialize_player(var_0) {
  self endon("disconnect");
  self.shotgun_escape_trophy_fail = 0;

  for(;;) {
    self waittill("perkmachine_activated", var_1);

    if(isDefined(var_1) && var_1.name != "armor") {
      self.shotgun_escape_trophy_fail = 1;
      break;
    }
  }
}