/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_analytics.gsc
***********************************************/

function initlevelvars() {
  start_game_type("ddl/mp/cp_matchdata.ddl", "ddl/mp/zombieclientmatchdata.ddl", "cp/cp_analytics.csv");
  level.transactionid = 0;
  level.analyticsendgame = &zombieendgameanalytics;
  level.revive_success_analytics_func = &revive_success_analytics_func;
}

function init_weapon_and_player_analytics(var_0) {
  var_0 endon("disconnect");

  while(!isDefined(var_0.pers)) {
    wait 1;
  }

  var_0.timewithitem = [];
  var_0.killswithitem = [];
  var_0.itemtype = " ";
  var_0.timeitemlasted = [];

  if(!isDefined(level.brutefirstspawn)) {
    level.brutefirstspawn = 0;
  }

  if(level.wave_num == 0) {
    var_0.pers["timesPerWave"] = spawnStruct();
    var_0.pers["timesPerWave"].timesperwave = [];
    var_0.pers["timesPerWave"].timesperwave[level.wave_num + 1] = [];
    var_0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["bowling_for_planets"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["bowling_for_planets_afterlife"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["coaster"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["laughingclown"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["laughingclown_afterlife"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["basketball_game"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["basketball_game_afterlife"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["clown_tooth_game"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["clown_tooth_game_afterlife"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["game_race"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["shooting_gallery"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["shooting_gallery_afterlife"] = 0;
  }

  if(!isDefined(var_0.pers["timesPerWave"])) {
    var_0.pers["timesPerWave"] = spawnStruct();
    var_0.pers["timesPerWave"].timesperwave = [];
    var_0.pers["timesPerWave"].timesperwave[level.wave_num] = [];
    var_0.pers["timesPerWave"].timesperwave[level.wave_num]["bowling_for_planets"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num]["bowling_for_planets_afterlife"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num]["coaster"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num]["laughingclown"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num]["laughingclown_afterlife"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num]["basketball_game"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num]["basketball_game_afterlife"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num]["clown_tooth_game"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num]["clown_tooth_game_afterlife"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num]["game_race"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num]["shooting_gallery"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num]["shooting_gallery_afterlife"] = 0;
  } else if(!isDefined(var_0.pers["timesPerWave"].timesperwave[level.wave_num + 1])) {
    var_0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["bowling_for_planets"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["bowling_for_planets_afterlife"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["coaster"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["laughingclown"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["laughingclown_afterlife"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["basketball_game"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["basketball_game_afterlife"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["clown_tooth_game"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["clown_tooth_game_afterlife"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["game_race"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["shooting_gallery"] = 0;
    var_0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["shooting_gallery_afterlife"] = 0;
  }

  var_0.itemuses = [];
  var_0.itemkills = [];
  var_0.itemignored = " ";
  var_0.itemreplaced = " ";
  var_0.itempicked = " ";
  var_0.itemuses[var_0.itempicked] = 0;
  var_0.itemkills[var_0.itempicked] = 0;

  if(!isDefined(var_0.totalxpearned)) {
    var_0.totalxpearned = 0;
  }

  if(!isDefined(var_0.score_earned)) {
    var_0.score_earned = 0;
  }

  var_0.downsperweaponlog = [];
  var_0.killsperweaponlog = [];
  var_0.wavesheldwithweapon = [];
  var_0.shotsfiredwithweapon = [];
  var_0.shotsontargetwithweapon = [];
  var_0.headshots = [];
  var_0.total_match_headshots = 0;
  var_0.aggregateweaponkills = [];
  var_0.weapon_name_log = " ";
  var_0.accuracy_shots_fired = 0;
  var_0.accuracy_shots_on_target = 0;
  var_0.explosive_kills = 0;
  var_0.total_trap_kills = 0;

  if(!isDefined(var_0.exitingafterlifearcade)) {
    var_0.exitingafterlifearcade = 0;
  }

  var_0.meleekill = 0;
  var_0.kung_fu_vo = 0;

  if(!isDefined(var_0.trapkills)) {
    var_0.trapkills = [];
  }

  var_1 = ["trap_gator", "trap_dragon", "trap_gravitron", "trap_danceparty", "trap_rocket", "trap_spin"];

  foreach(var_3 in var_1) {
    if(!isDefined(var_0.trapkills[var_3])) {
      var_0.trapkills[var_3] = 0;
    }
  }

  var_5 = var_0.getweaponslist;

  if(isDefined(var_5)) {
    foreach(var_7 in var_5) {
      var_0.weapon_name_log = scripts\cp\utility::getbaseweaponname(var_7);

      if(!isDefined(var_0.aggregateweaponkills[var_0.weapon_name_log])) {
        var_0.aggregateweaponkills[var_0.weapon_name_log] = 0;
      }
    }

    return;
  }
}

function revive_success_analytics_func(var_0) {
  log_event("revived_another_player", 1, [var_0.clientid], [var_0.clientid], [var_0.clientid]);
}

function zombieendgameanalytics() {
  var_0 = ["trap_gator", "trap_dragon", "trap_gravitron", "trap_danceparty", "trap_rocket", "trap_spin"];

  foreach(var_2 in level.players) {
    log_weapons_data(var_3, var_2);
    log_headshots_data(var_3, var_2);
  }
}

function log_headshots_data(var_0, var_1) {
  foreach(var_5, var_3 in var_1.headshots) {
    if(var_5 == "none" || var_5 == "" || var_3 == 0 || !scripts\engine\utility::array_contains(level.loadout_weapons, var_5)) {
      continue;
    }

    setclientmatchdata("player", var_0, "headShots", scripts\cp\utility::getbaseweaponname(var_5), var_3);
    var_4 = var_1 getplayerdata("cp", "headShots", scripts\cp\utility::getbaseweaponname(var_5));
    var_1 setplayerdata("cp", "headShots", scripts\cp\utility::getbaseweaponname(var_5), var_4 + var_3);
  }

  setclientmatchdata("player", var_0, "total_headshots", var_1.total_match_headshots);
}

function log_card_data(var_0, var_1) {
  if(!isDefined(var_1.consumables)) {
    return;
  }

  if(level.gametype != "zombies") {
    return;
  }

  foreach(var_3 in var_1.consumables) {
    var_4 = var_1 getplayerdata("cp", "cards_used", var_5);
    var_1 setplayerdata("cp", "cards_used", var_5, var_4 + var_3.times_used);
  }
}

function log_explosive_kills(var_0, var_1) {
  if(!isDefined(var_1.explosive_kills)) {
    return;
  }

  var_2 = var_1 getplayerdata("cp", "explosive_kills");
  var_1 setplayerdata("cp", "explosive_kills", var_2 + var_1.explosive_kills);
}

function log_weapons_data(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;
  var_4 = "";

  foreach(var_8, var_6 in var_1.aggregateweaponkills) {
    if(var_8 == "none" || var_8 == "" || var_6 == 0 || !scripts\engine\utility::array_contains(level.loadout_weapons, var_8)) {
      continue;
    }

    setclientmatchdata("player", var_0, "killsPerWeapon", scripts\cp\utility::getbaseweaponname(var_8), var_6);
    var_7 = var_1 getplayerdata("cp", "killsPerWeapon", scripts\cp\utility::getbaseweaponname(var_8));
    var_1 setplayerdata("cp", "killsPerWeapon", scripts\cp\utility::getbaseweaponname(var_8), var_7 + var_6);

    if(var_1.aggregateweaponkills[var_8] > 0 && var_2 == 0) {
      var_3 = var_1.aggregateweaponkills[var_8];
      var_2 = 1;
      var_4 = scripts\cp\utility::getbaseweaponname(var_8);
    }

    if(var_1.aggregateweaponkills[var_8] > var_3) {
      var_3 = var_1.aggregateweaponkills[var_8];
      var_4 = scripts\cp\utility::getbaseweaponname(var_8);
    }
  }

  if(var_3 > 0) {
    setclientmatchdata("player", var_0, "DeadliestWeapon", var_4);
    setclientmatchdata("player", var_0, "DeadliestWeaponKills", var_3);
  }

  var_9 = var_1 getplayerdata("cp", "DeadliestWeaponName");
  var_7 = var_1 getplayerdata("cp", "DeadliestWeaponKills", var_9);

  if(var_7 < var_3) {
    if(var_3 > 0) {
      var_10 = var_1 getplayerdata("cp", "killsPerWeapon", var_4);

      if(!isDefined(var_1.aggregateweaponkills[var_4])) {
        var_1 setplayerdata("cp", "DeadliestWeaponKills", var_4, var_10);
      } else {
        var_1 setplayerdata("cp", "DeadliestWeaponKills", var_4, var_10);
      }

      var_1 setplayerdata("cp", "DeadliestWeaponName", var_4);
      return;
    }

    return;
  }

  var_11 = var_2 getplayerdata("cp", "killsPerWeapon", var_10);

  if(!isDefined(var_2.aggregateweaponkills[var_10])) {
    var_2 setplayerdata("cp", "DeadliestWeaponKills", var_10, var_11);
  } else {
    var_2 setplayerdata("cp", "DeadliestWeaponKills", var_10, var_2.aggregateweaponkills[var_10] + var_11);
  }

  var_2 setplayerdata("cp", "DeadliestWeaponName", var_10);
}

function start_game_type(var_0, var_1, var_2) {
  init(var_2);
  init_matchdata(var_0, var_1);
}

function init_matchdata(var_0, var_1) {
  setclientmatchdatadef(var_1);

  if(getdvarint("online_matchdata_enabled") != 0) {
    setmatchdatadef(var_0);
    setmatchdata("commonMatchData", "map", level.script);
    setmatchdata("commonMatchData", "gametype", getDvar("ui_gametype"));
    setmatchdata("commonMatchData", "build_version", getbuildversion());
    setmatchdata("commonMatchData", "build_number", getbuildnumber());
    setmatchdata("commonMatchData", "utc_start_time_s", getsystemtime());
    setmatchdata("commonMatchData", "is_private_match", getdvarint("xblive_privatematch"));
    setmatchdata("commonMatchData", "is_ranked_match", 1);
  }

  thread wait_set_initial_player_count();
}

function init(var_0) {
  var_1 = spawnStruct();
  var_2 = [];
  var_1.single_value_stats = var_2;
  var_3 = [];
  var_1.challenge_results = var_3;
  level.cp_matchdata = var_1;
  init_analytics(var_0);
  level.player_count = 0;
  level.player_count_left = 0;
}

function wait_set_initial_player_count() {
  level endon("gameEnded");
  level waittill("prematch_done");
  setmatchdata("commonMatchData", "player_count_start", validate_byte(level.players.size));
}

function on_player_connect() {
  player_init();
  set_player_count();
  set_split_screen();
  set_join_in_progress();
  level.player_count += 1;
  ref_119cd();
}

function ref_119cd() {
  var_0 = isbot(self) || initmaxspeedforpathlengthtable(self) || isai(self);

  if(scripts\cp\utility::rankingenabled()) {
    var_1 = self getplayerdata("common", "mpProgression", "playerLevel", "xp");
    var_2 = self getplayerdata("mp", "playerStats", "combatStats", "kills");
    var_3 = self getplayerdata("mp", "playerStats", "combatStats", "deaths");
    var_4 = self getplayerdata("mp", "playerStats", "matchStats", "wins");
    var_5 = self getplayerdata("mp", "playerStats", "matchStats", "losses");
    var_6 = self getplayerdata("mp", "playerStats", "combatStats", "hits");
    var_7 = self getplayerdata("mp", "playerStats", "combatStats", "misses");
    var_8 = self getplayerdata("mp", "playerStats", "matchStats", "gamesPlayed");
    var_9 = self getplayerdata("mp", "playerStats", "matchStats", "timePlayedTotal");
    var_10 = self getplayerdata("mp", "playerStats", "matchStats", "score");
    var_11 = self getplayerdata("common", "mpProgression", "playerLevel", "prestige");
  } else {
    var_1 = 0;
    var_2 = 0;
    var_3 = 0;
    var_4 = 0;
    var_5 = 0;
    var_6 = 0;
    var_7 = 0;
    var_8 = 0;
    var_9 = 0;
    var_10 = 0;
    var_11 = 0;
  }

  var_12 = self updatelastcovertime();
  GscBinSkip1(0x45, 0, "");
}

function ref_119cc(var_0) {
  var_1 = "";

  if(isDefined(var_0) && isstring(var_0)) {
    var_1 = var_0;
  } else {
    switch (var_0) {
      case 1:
        var_1 = "win";
        break;
      case 2:
        var_1 = "fail";
        break;
      case 3:
        var_1 = "kia";
        break;
      case 4:
        var_1 = "host ended";
        break;
      default:
        var_1 = "kia";
        break;
    }
  }

  if(level.teambased) {
    var_2 = int(scripts\cp\drone\emp_drone::getteamrankxpmultiplier(self.team));
  } else {
    var_2 = 0;
  }

  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;

  if(scripts\cp\utility::onlinestatsenabled() && !scripts\cp\utility::tryingtoleave()) {
    if(isDefined(self.pers["summary"]["xp"])) {
      var_3 = self.pers["summary"]["xp"];
    }

    if(isDefined(self.pers["summary"]["score"])) {
      var_4 = self.pers["summary"]["score"];
    }

    if(isDefined(self.pers["summary"]["challenge"])) {
      var_5 = self.pers["summary"]["challenge"];
    }

    if(isDefined(self.pers["summary"]["match"])) {
      var_6 = self.pers["summary"]["match"];
    }

    if(isDefined(self.pers["summary"]["medal"])) {
      var_7 = self.pers["summary"]["medal"];
    }

    if(isDefined(self.pers["summary"]["bonusXp"])) {
      var_8 = self.pers["summary"]["bonusXp"];
    }

    if(isDefined(self.pers["summary"]["misc"])) {
      var_9 = self.pers["summary"]["misc"];
    }
  }

  jumpiffalse(scripts\cp\utility::tryingtoleave()) LOC_000001eb;
  var_10 = -1;
  goto LOC_000001fd;
}

function initsegmentstats() {
  level endon("game_ended");
  thread recordplayersegmentdata();

  for(;;) {
    level waittill("connected", var_0);
    createplayersegmentstats(var_0);
  }
}

function recordplayersegmentdata() {
  level endon("game_ended");
  scripts\cp\utility::gameflagwait("prematch_done");
  wait 4;

  for(;;) {
    wait 1;

    foreach(var_1 in level.players) {
      thread updateplayersegmentdata();
    }
  }
}

function createplayersegmentstats(var_0) {
  var_0.segments = [];
  var_0.segments["distanceTotal"] = 0;
  var_0.segments["movingTotal"] = 0;
  var_0.segments["movementUpdateCount"] = 0;
  var_0.savedsegmentposition = var_0.origin;
  var_0.positionptm = var_0.origin;
}

function updateplayersegmentdata() {
  self endon("disconnect");

  if(!isDefined(self.savedsegmentposition)) {
    self.savedsegmentposition = self.origin;
    self.positionptm = self.origin;
  }

  if(scripts\cp\utility::isusingremote()) {
    self waittill("stopped_using_remote");
    self.savedsegmentposition = self.origin;
    self.positionptm = self.origin;
    return;
  }

  self.segments["movementUpdateCount"]++;
  self.segments["distanceTotal"] = self.segments["distanceTotal"] + distance2d(self.savedsegmentposition, self.origin);
  self.savedsegmentposition = self.origin;

  if(self.segments["movementUpdateCount"] % 5 == 0) {
    var_0 = distance2d(self.positionptm, self.origin);
    self.positionptm = self.origin;

    if(var_0 > 16) {
      self.segments["movingTotal"]++;
      return;
    }

    return;
  }
}

function on_player_disconnect(var_0) {
  set_custom_stats();
  level.player_count_left += 1;
  ref_119cc(var_0);
}

function player_init() {
  var_0 = spawnStruct();
  var_1 = [];
  GscBinSkip0(0x2e, "cashSpentOnWeapon", get_single_value_struct(0, "int"));
}

function set_player_count() {
  if(!isDefined(level.max_concurrent_player_count)) {
    level.max_concurrent_player_count = 0;
  }

  if(level.players.size >= level.max_concurrent_player_count) {
    level.max_concurrent_player_count = level.players.size + 1;
    return;
  }
}

function set_split_screen() {}

function set_join_in_progress() {}

function prematch_over() {
  if(scripts\engine\utility::flag_exist("introscreen_over") && scripts\engine\utility::flag("introscreen_over")) {
    return true;
  }

  return false;
}

function update_challenges_status(var_0, var_1) {
  if(level.cp_matchdata.challenge_results.size > 25) {
    return;
  }

  var_2 = spawnStruct();
  var_2.challenge_name = var_0;
  var_2.result = var_1;
  level.cp_matchdata.challenge_results[level.cp_matchdata.challenge_results.size] = var_2;
}

function inc_downed_counts() {
  inc_laststand_record("timesDowned");
}

function inc_revived_counts() {
  inc_laststand_record("timesRevived");
}

function inc_bleedout_counts() {
  inc_laststand_record("timesBledOut");
}

function inc_laststand_record(var_0) {
  if(!isDefined(self.cp_matchdata.laststand_record[var_0][level.wave_num])) {
    self.cp_matchdata.laststand_record[var_0][level.wave_num] = 0;
  }

  self.cp_matchdata.laststand_record[var_0][level.wave_num]++;
}

function update_spending_type(var_0, var_1) {
  switch (var_1) {
    case "weapon":
      self.cp_matchdata.single_value_stats["cashSpentOnWeapon"].value = self.cp_matchdata.single_value_stats["cashSpentOnWeapon"].value + var_0;
      break;
    case "ability":
      self.cp_matchdata.single_value_stats["cashSpentOnAbility"].value = self.cp_matchdata.single_value_stats["cashSpentOnAbility"].value + var_0;
      break;
    case "trap":
      self.cp_matchdata.single_value_stats["cashSpentOnTrap"].value = self.cp_matchdata.single_value_stats["cashSpentOnTrap"].value + var_0;
      break;
    default:
      break;
  }
}

function endgame(var_0, var_1) {
  set_game_data(var_0, var_1);
  write_global_clientmatchdata();

  foreach(var_3 in level.players) {
    scripts\cp\cp_persistence::increment_player_career_total_waves(var_3);
    scripts\cp\cp_persistence::increment_player_career_total_score(var_3);
    set_player_data(var_3, var_1);
    set_player_game_data(var_3);
    write_clientmatchdata_for_player(var_3, var_3, var_4);
  }

  if(isDefined(level.analyticsendgame)) {
    [[level.analyticsendgame]]();
  }

  if(getdvarint("online_matchdata_enabled") != 0) {
    sendmatchdata();
  }

  sendclientmatchdata();
}

function set_player_data(var_0) {
  var_1 = self getplayerdata("cp", "coopCareerStats", "totalGameplayTime");
  var_2 = self getplayerdata("cp", "coopCareerStats", "gamesPlayed");

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_1 += var_0 / 1000;
  var_2 += 1;
  self setplayerdata("cp", "coopCareerStats", "totalGameplayTime", int(var_1));
  self setplayerdata("cp", "coopCareerStats", "gamesPlayed", int(var_2));
}

function set_game_data(var_0, var_1) {
  var_2 = "challengesCompleted";
  var_3 = level.cp_matchdata;

  foreach(var_5 in var_3.single_value_stats) {
    var_6 = validate_value(var_5.value, var_5.value_type);
  }

  foreach(var_9 in var_3.challenge_results) {}

  setmatchdata("commonMatchData", "player_count_end", level.players.size);
  setmatchdata("commonMatchData", "utc_end_time_s", getsystemtime());
  setmatchdata("commonMatchData", "player_count", validate_byte(level.player_count));
  setmatchdata("commonMatchData", "player_count_left", validate_byte(level.player_count_left));
}

function set_player_game_data() {
  copy_from_playerdata();
  set_laststand_stats();
  set_single_value_stats();
  set_custom_stats();
}

function get_player_matchdata(var_0, var_1) {
  if(isDefined(level.matchdata["player"][self.clientid]) && isDefined(level.matchdata["player"][self.clientid][var_0])) {
    return level.matchdata["player"][self.clientid][var_0];
  }

  return var_1;
}

function set_custom_stats() {
  var_0 = self getplayerdata("cp", "coopCareerStats", "totalGameplayTime");
  var_1 = self getplayerdata("cp", "coopCareerStats", "gamesPlayed");
  var_2 = self getplayerdata("cp", "progression", "playerLevel", "rank");
  var_3 = self getplayerdata("cp", "progression", "playerLevel", "prestige");
}

function copy_from_playerdata() {}

function set_laststand_stats() {}

function set_single_value_stats() {}

function validate_value(var_0, var_1) {
  switch (var_1) {
    case "byte":
      return validate_byte(var_0);
    case "short":
      return validate_short(var_0);
    case "int":
      return validate_int(var_0);
    default:
      break;
  }
}

function validate_byte(var_0) {
  return int(min(var_0, 127));
}

function validate_short(var_0) {
  return int(min(var_0, 32767));
}

function validate_int(var_0) {
  return int(min(var_0, 2147483647));
}

function get_single_value_struct(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.value = var_0;
  var_2.value_type = var_1;
  return var_2;
}

function init_analytics(var_0) {
  var_1 = 0;
  var_2 = 1;
  var_3 = 2;
  var_4 = 1;
  var_5 = 2;
  var_6 = 3;
  var_7 = 4;
  var_8 = 5;
  var_9 = 6;
  var_10 = 1;
  var_11 = 100;
  var_12 = 101;
  var_13 = 300;
  level.blackbox_data_type = [];
  level.matchdata_struct = [];
  level.matchdata_data_type = [];
  level.matchdata = [];
  level.clientmatchdata_struct = [];
  level.clientmatchdata_data_type = [];
  level.clientmatchdata = [];

  for(var_14 = var_12; var_14 <= var_13; var_14++) {
    var_15 = tablelookup(var_0, var_1, var_14, var_4);

    if(var_15 == "") {
      continue;
    }

    var_16 = tablelookup(var_0, var_1, var_14, var_5);

    if(var_16 != "") {
      level.blackbox_data_type[var_15] = var_16;
    }

    var_17 = tablelookup(var_0, var_1, var_14, var_6);

    if(var_17 != "") {
      level.matchdata_data_type[var_15] = var_17;
    }

    var_18 = tablelookup(var_0, var_1, var_14, var_7);

    if(var_18 != "") {
      level.matchdata_struct[var_15] = [];
      level.matchdata[var_15] = [];
    }

    var_19 = tablelookup(var_0, var_1, var_14, var_8);

    if(var_19 != "") {
      level.clientmatchdata_data_type[var_15] = var_19;
    }

    var_20 = tablelookup(var_0, var_1, var_14, var_9);

    if(var_20 != "") {
      level.clientmatchdata_struct[var_15] = [];
      level.clientmatchdata[var_15] = [];
    }
  }

  level.analytics_event = [];

  for(var_14 = var_10; var_14 <= var_11; var_14++) {
    var_21 = tablelookup(var_0, var_1, var_14, var_2);

    if(var_21 == "") {
      break;
    }

    var_22 = tablelookup(var_0, var_1, var_14, var_3);
    level.analytics_event[var_21] = var_22;
    var_23 = strtok(var_22, " ");

    foreach(var_25 in var_23) {
      if(isDefined(level.matchdata_struct[var_25])) {
        level.matchdata_struct[var_25][var_21] = 0;
      }

      if(isDefined(level.clientmatchdata_struct[var_25]) && isDefined(level.clientmatchdata_data_type[var_21])) {
        level.clientmatchdata_struct[var_25][var_21] = 0;
      }
    }
  }
}

function log_event(var_0, var_1, var_2, var_3, var_4) {
  var_5 = get_data_to_update(var_0);
  log_clientmatchdata(var_0, var_5, var_1, var_4);
}

function log_clientmatchdata(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    return;
  }

  var_4 = 0;

  if(is_clientmatchdata_data(var_0)) {
    foreach(var_6 in var_1) {
      if(is_clientmatchdata_struct(var_6)) {
        var_7 = var_3[var_4];

        if(!isDefined(level.clientmatchdata[var_6][var_7])) {
          level.clientmatchdata[var_6][var_7] = level.clientmatchdata_struct[var_6];
        }

        level.clientmatchdata[var_6][var_7][var_0] += var_2;
        var_4++;
      }
    }

    return;
  }
}

function get_bb_string(var_0) {
  var_1 = "";

  foreach(var_3 in var_0) {
    var_1 += var_3 + " " + level.blackbox_data_type[var_3];

    if(var_4 != var_0.size - 1) {
      var_1 += " ";
    }
  }

  return var_1;
}

function get_data_to_update(var_0) {
  var_1 = level.analytics_event[var_0];
  return strtok(var_1, " ");
}

function log_matchdata(var_0, var_1, var_2, var_3) {
  var_4 = 0;

  foreach(var_6 in var_1) {
    if(is_matchdata_struct(var_6)) {
      var_7 = var_3[var_4];

      if(!isDefined(level.matchdata[var_6][var_7])) {
        level.matchdata[var_6][var_7] = level.matchdata_struct[var_6];
      }

      level.matchdata[var_6][var_7][var_0] += var_2;
      var_4++;
    }
  }
}

function is_matchdata_struct(var_0) {
  return isDefined(level.matchdata_struct[var_0]);
}

function is_clientmatchdata_struct(var_0) {
  return isDefined(level.clientmatchdata_struct[var_0]);
}

function is_clientmatchdata_data(var_0) {
  return isDefined(level.clientmatchdata_data_type[var_0]);
}

function write_global_clientmatchdata() {
  setclientmatchdata("waves_survived", level.wave_num);
  setclientmatchdata("time_survived", level.time_survived);

  if(isDefined(level.eogscoringtotalpoints)) {
    setclientmatchdata("team_score", level.eogscoringtotalpoints);
  }

  if(isDefined(level.starsearned)) {
    setclientmatchdata("stars_earned", level.starsearned);
  }

  setclientmatchdata("scoreboardPlayerCount", level.players.size);
  setclientmatchdata("map", level.script);

  if(isDefined(level.write_global_clientmatchdata_func)) {
    [[level.write_global_clientmatchdata_func]]();
    return;
  }
}

function write_clientmatchdata_for_player(var_0, var_1) {
  setclientmatchdata("player", var_1, "username", var_0.name);
  var_2 = var_0 getplayerdata("cp", "alienSession", "kills");
  var_3 = var_0 getplayerdata("cp", "alienSession", "downed");
  var_4 = var_0 getplayerdata("cp", "alienSession", "revives");
  var_5 = var_0 getxuidhigh();
  var_6 = var_0 getxuidlow();

  if(!scripts\cp\utility::tryingtoleave()) {
    if(scripts\cp\utility::matchmakinggame()) {
      setclientmatchdata("player", var_1, "rank", var_0 scripts\cp\drone\emp_drone::getrank());
    } else {
      setclientmatchdata("player", var_1, "rank", var_0 scripts\cp\cp_persistence::get_player_rank());
    }
  }

  if(!isDefined(var_0.player_character_index)) {
    return;
  }

  setclientmatchdata("player", var_1, "characterIndex", var_0.player_character_index);
  var_7 = level.clientmatchdata["player"][var_0.clientid];

  if(isDefined(var_7)) {
    foreach(var_9 in var_7) {
      setclientmatchdata("player", var_1, var_10, int(var_9));
    }
  }

  if(isDefined(level.endgame_write_clientmatchdata_for_player_func)) {
    [[level.endgame_write_clientmatchdata_for_player_func]](var_0, var_1);
    return;
  }
}

function lootchopper_getattackerdata() {
  setdvarifuninitialized("enable_analytics_log", 0);
  level.analyticslog = spawnStruct();
  level.analyticslog.nextplayerid = 0;
  level.analyticslog.nextobjectid = 0;
  level.analyticslog.nextdeathid = 0;

  if(!analyticsactive()) {
    return;
  }
}

function analyticsactive() {
  if(analyticsspawnlogenabled()) {
    return true;
  }

  if(analyticslogenabled()) {
    return true;
  }

  return false;
}

function analyticslogenabled() {
  return getdvarint("enable_analytics_log") == 1;
}

function getuniqueobjectid() {
  var_0 = level.analyticslog.nextobjectid;
  level.analyticslog.nextobjectid++;
  return var_0;
}

function cacheplayeraction(var_0) {
  if(!isDefined(self.analyticslog.cachedactions)) {
    self.analyticslog.cachedactions = 0;
  }

  self.analyticslog.cachedactions |= var_0;
}

function watchforconnectedplayers() {
  jumpiftrue(analyticsactive()) LOC_00000009;
  return;
}

function watchforbasicplayerevents() {
  self endon("disconnect");
  jumpiftrue(analyticslogenabled()) LOC_00000010;
  return;
}

function watchforplayermovementevents() {
  self endon("disconnect");
  jumpiftrue(analyticslogenabled()) LOC_00000010;
  return;
}

function watchforusermessageevents() {
  self endon("disconnect");

  if(isai(self)) {
    return;
  }

  if(getdvarint("scr_playtest", 0) == 0) {
    return;
  }

  self notifyonplayercommand("log_user_event_start", "+actionslot 3");
  self notifyonplayercommand("log_user_event_end", "-actionslot 3");
  self notifyonplayercommand("log_user_event_generic_event", "+gostand");

  for(;;) {
    self waittill("log_user_event_start");
    var_0 = scripts\engine\utility::ref_143ad("log_user_event_end", "log_user_event_generic_event");

    if(isDefined(var_0) && var_0 == "log_user_event_generic_event") {
      self iprintlnbold("Event Logged");
      logevent_message(self.name, self.origin, "Generic User Event");
    }
  }
}

function checkstancestatus() {
  var_0 = self getstance();

  if(var_0 == "prone") {
    cacheplayeraction(1);
    return;
  }

  if(var_0 == "crouch") {
    cacheplayeraction(2);
    return;
  }
}

function logallplayerposthink() {
  jumpiftrue(analyticslogenabled()) LOC_00000009;
  return;
}

function recordbreadcrumbdata() {
  level endon("game_ended");

  if(getDvar("online_breadcrumbing_enabled") == "0") {
    return;
  }

  if(isDefined(scripts\cp\utility::getgametype()) && scripts\cp\utility::getgametype() == "br") {
    var_0 = getdvarfloat("online_br_breadcrumbing_frequency", 4);
  } else {
    var_0 = getdvarfloat("online_mp_breadcrumbing_frequency", 2);
  }

  scripts\mp\flags::gameflagwait("prematch_done");

  for(;;) {
    foreach(var_2 in level.players) {
      if(!isDefined(var_2)) {
        continue;
      }

      var_3 = scripts\cp\utility\player::isreallyalive(var_2) && !isai(var_2);
      var_4 = isDefined(var_2.matchdatalifeindex) && scripts\cp\agents\agents::canlogclient(var_2);
      var_5 = isDefined(var_2.team) && var_2.team != "spectator" && var_2.sessionstate == "playing" && var_2.sessionstate != "dead";

      if(var_3 && var_4 && var_5) {
        var_6 = var_2 scripts\cp\utility::isplayerads();
        var_7 = scripts\cp\agents\agents::gettimefrommatchstart(gettime());
        var_2 recordbreadcrumbdataforplayer(var_7, var_2.matchdatalifeindex, var_6);
      }
    }

    wait var_0;
  }
}

function getpathactionvalue() {
  var_0 = scripts\engine\utility::ter_op(isDefined(self.analyticslog.cachedactions), self.analyticslog.cachedactions, 0);

  if(self iswallrunning()) {
    var_0 |= 32;
  }

  return var_0;
}

function clearpathactionvalue() {
  self.analyticslog.cachedactions = 0;
  checkstancestatus();
}

function buildkilldeathactionvalue() {
  var_0 = 0;
  var_1 = self getstance();

  if(var_1 == "prone") {
    var_0 |= 1;
  } else if(var_1 == "crouch") {
    var_0 |= 2;
  }

  if(self isjumping()) {
    var_0 |= 4;
  }

  if(isDefined(self.lastshotfiredtime) && gettime() - self.lastshotfiredtime < 500) {
    var_0 |= 8;
  }

  if(self isreloading()) {
    var_0 |= 16;
  }

  return var_0;
}

function buildloadoutstring() {
  var_0 = "archetype =" + self.loadoutarchetype + ";" + "powerPrimary=" + self.loadoutequipmentprimary + ";" + "powerSecondary=" + self.loadoutequipmentsecondary + ";" + "weaponPrimary =" + self.primaryweapon + ";" + "weaponSecondary =" + self.secondaryweapon + ";";
  return var_0;
}

function buildspawnpointstatestring(var_0) {
  var_1 = "";

  if(isDefined(var_0.lastbucket)) {
    if(isDefined(var_0.lastbucket["allies"])) {
      var_1 += "alliesBucket=" + var_0.lastbucket["allies"] + ";";
    }

    if(isDefined(var_0.lastbucket["axis"])) {
      var_1 += "axisBucket=" + var_0.lastbucket["axis"] + ";";
    }
  }

  return var_1;
}

function logevent_path() {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  var_0 = anglesToForward(self getplayerangles());
  getentitylessscriptablearray("gamecp_path", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", var_0[0], "gun_orienty", var_0[1], "gun_orientz", var_0[2], "action", getpathactionvalue(), "health", getsantizedhealth()]);
  clearpathactionvalue();
}

function logevent_playerspawn() {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  var_0 = isDefined(self.lastspawnpoint) && isDefined(self.lastspawnpoint.buddyspawn) && self.lastspawnpoint.buddyspawn;
  var_1 = anglesToForward(self.angles);
  getentitylessscriptablearray("gamecp_spawn_in", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "orientx", var_1[0], "orienty", var_1[1], "orientz", var_1[2], "loadout", buildloadoutstring(), "type", scripts\engine\utility::ter_op(var_0, "Buddy", "Normal"), "team", self.team]);
}

function logevent_playerconnected() {
  if(!analyticsactive()) {
    return;
  }

  if(!isDefined(self.analyticslog)) {
    self.analyticslog = spawnStruct();
  }

  self.analyticslog.playerid = level.analyticslog.nextplayerid;
  level.analyticslog.nextplayerid++;

  if(!analyticslogenabled()) {
    return;
  }

  var_0 = undefined;

  if(isDefined(self.changedarchetypeinfo)) {
    var_0 = self.changedarchetypeinfo.super;
  } else {
    var_0 = self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypeSuper");
  }

  var_1 = self getxuid();
  getentitylessscriptablearray("gamecp_player_connect", ["playerid", self.analyticslog.playerid, "player_name", self.name, "player_xuid", var_1, "player_super_name", var_0]);
}

function logevent_playerdeath(var_0, var_1, var_2) {
  if(!shouldplayerlogevents(self) || !isPlayer(self)) {
    return;
  }

  var_3 = anglesToForward(self getplayerangles());
  var_4 = -1;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = 0;
  var_11 = "s";
  var_12 = 0;

  if(isDefined(var_0) && isPlayer(var_0)) {
    var_4 = var_0.analyticslog.playerid;

    if(isDefined(var_0.team)) {
      if(var_0.team == "axis") {
        var_11 = "a";
      } else {
        var_11 = "l";
      }
    }

    if(isDefined(var_0.origin)) {
      var_5 = var_0.origin[0];
      var_6 = var_0.origin[1];
      var_7 = var_0.origin[2];
    }

    if(isDefined(var_0.lifeid)) {
      var_12 = var_0.lifeid;
    }

    var_13 = anglesToForward(var_0 getplayerangles());

    if(isDefined(var_13)) {
      var_8 = var_13[0];
      var_9 = var_13[1];
      var_10 = var_13[2];
    }
  }

  var_14 = level.analyticslog.nextdeathid;
  level.analyticslog.nextdeathid++;
  var_2 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, "None");
  var_15 = "s";

  if(self.team == "axis") {
    var_15 = "a";
  } else {
    var_15 = "l";
  }

  getentitylessscriptablearray("134death", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", var_3[0], "gun_orienty", var_3[1], "gun_orientz", var_3[2], "weapon", var_2, "mean_of_death", scripts\engine\utility::ter_op(isDefined(var_1), var_1, "None"), "attackerid", var_4, "action", buildkilldeathactionvalue(), "server_death_id", var_14, "victim_life_index", self.lifeid, "attacker_life_index", var_12, "victim_team", var_15, "attacker_team", var_11, "attacker_pos_x", var_5, "attacker_pos_y", var_6, "attacker_pos_z", var_7, "attacker_gun_orientx", var_8, "attacker_gun_orienty", var_9, "attacker_gun_orientz", var_10, "victim_weapon", self.primaryweapon]);

  if(isDefined(var_1) && isexplosivedamagemod(var_1)) {
    logevent_explosion(scripts\engine\utility::ter_op(isDefined(var_2), var_2, "generic"), self.origin, var_0, 1);
  }

  if(isDefined(self.attackers)) {
    foreach(var_17 in self.attackers) {
      if(isDefined(var_17) && isPlayer(var_17) && var_17 != var_0) {
        logevent_assist(var_17.analyticslog.playerid, var_14, var_2);
      }
    }

    return;
  }
}

function logevent_playerkill(var_0, var_1, var_2) {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  var_3 = anglesToForward(self getplayerangles());
  getentitylessscriptablearray("gamecp_kill", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", var_3[0], "gun_orienty", var_3[1], "gun_orientz", var_3[2], "weapon", scripts\engine\utility::ter_op(isDefined(var_2), var_2, "None"), "mean_of_kill", scripts\engine\utility::ter_op(isDefined(var_1), var_1, "None"), "victimid", scripts\engine\utility::ter_op(isDefined(var_0) && isPlayer(var_0), var_0.analyticslog.playerid, "-1"), "action", buildkilldeathactionvalue(), "attacker_health", getsantizedhealth(), "victim_pixel_count", 0]);
}

function logevent_explosion(var_0, var_1, var_2, var_3, var_4) {
  if(!analyticslogenabled()) {
    return;
  }

  if(!isDefined(var_4)) {
    var_4 = (1, 0, 0);
  }

  getentitylessscriptablearray("gamecp_explosion", ["playerid", var_2.analyticslog.playerid, "x", var_1[0], "y", var_1[1], "z", var_1[2], "orientx", var_4[0], "orienty", var_4[1], "orientz", var_4[2], "duration", var_3, "type", var_0]);
}

function logevent_frontlineupdate(var_0, var_1, var_2, var_3, var_4) {
  if(!analyticslogenabled()) {
    return;
  }

  getentitylessscriptablearray("gamecp_front_line", ["startx", var_0[0], "starty", var_0[1], "endx", var_1[0], "endy", var_1[1], "axis_centerx", var_3[0], "axis_centery", var_3[1], "allies_centerx", var_2[0], "allies_centery", var_2[1], "state", var_4]);
}

function logevent_gameobject(var_0, var_1, var_2, var_3, var_4) {
  if(!analyticslogenabled()) {
    return;
  }

  getentitylessscriptablearray("gamecp_object", ["uniqueid", var_1, "x", var_2[0], "y", var_2[1], "z", var_2[2], "ownerid", var_3, "type", var_0, "state", var_4]);
}

function logevent_message(var_0, var_1, var_2) {
  if(!analyticslogenabled()) {
    return;
  }

  getentitylessscriptablearray("gamecp_message", ["ownerid", var_0, "x", var_1[0], "y", var_1[1], "z", var_1[2], "message", var_2]);
}

function logevent_tag(var_0) {
  if(!analyticslogenabled()) {
    return;
  }

  bbprint("gamecp_matchtags", "message %s", var_0);
}

function logevent_powerused(var_0, var_1) {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  var_2 = anglesToForward(self.angles);
  getentitylessscriptablearray("gamecp_power", ["ownerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "orientx", var_2[0], "orienty", var_2[1], "orientz", var_2[2], "type", var_0, "state", var_1]);
}

function logevent_scoreupdate() {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  var_0 = anglesToForward(self.angles);
  getentitylessscriptablearray("gamecp_scoreboard", ["ownerid", self.analyticslog.playerid, "score", self.score]);
}

function logevent_minimapcorners() {
  if(!analyticslogenabled()) {
    return;
  }

  var_0 = getEntArray("minimap_corner", "targetname");

  if(!isDefined(var_0) || var_0.size != 2) {
    return;
  }

  getentitylessscriptablearray("gamecp_map", ["cornera_x", var_0[0].origin[0], "cornera_y", var_0[0].origin[1], "cornerb_x", var_0[1].origin[0], "cornerb_y", var_0[1].origin[1], "north", getnorthyaw()]);
}

function logevent_assist(var_0, var_1, var_2) {
  if(!analyticslogenabled()) {
    return;
  }

  getentitylessscriptablearray("gamecp_assists", ["playerid", var_0, "server_death_id", var_1, "weapon", var_2]);
}

function getsantizedhealth() {
  return int(clamp(self.health, 0, 100000));
}

function shouldplayerlogevents(var_0) {
  if(!analyticslogenabled()) {
    return false;
  }

  if(!isDefined(var_0.team) || var_0.team == "spectator" || var_0.sessionstate != "playing" && var_0.sessionstate != "dead") {
    return false;
  }

  return true;
}

function logmatchtags() {
  var_0 = getDvar("scr_analytics_tag", "");

  if(var_0 != "") {
    logevent_tag(var_0);
  }

  if(scripts\cp\utility::matchmakinggame()) {
    logevent_tag("OnlineMatch");
    return;
  }

  if(getdvarint("xblive_privatematch")) {
    logevent_tag("PrivateMatch");
    return;
  }

  if(!getdvarint("onlinegame")) {
    logevent_tag("OfflineMatch");
    return;
  }
}

function logevent_superended(var_0, var_1, var_2, var_3) {
  if(!analyticslogenabled()) {
    return;
  }

  var_4 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var_4 = self.analyticslog.playerid;
  }

  getentitylessscriptablearray("analytics_mp_supers", ["super_name", var_0, "time_to_use", var_1, "num_hits", var_2, "num_kills", var_3, "player_id", var_4]);
}

function logevent_superearned(var_0) {
  if(!analyticslogenabled()) {
    return;
  }

  var_1 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var_1 = self.analyticslog.playerid;
  }

  getentitylessscriptablearray("analytics_mp_super_earned", ["match_time", var_0, "player_id", var_1]);
}

function logevent_awardgained(var_0) {
  if(!analyticslogenabled()) {
    return;
  }

  getentitylessscriptablearray("analytics_mp_awards", ["award_message", var_0]);
}

function logevent_giveplayerxp(var_0, var_1, var_2, var_3) {
  if(!analyticslogenabled()) {
    return;
  }

  var_4 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var_4 = self.analyticslog.playerid;
  }

  getentitylessscriptablearray("analytics_mp_player_xp", ["current_prestige", var_0, "current_level", var_1, "xp_gained", var_2, "xp_source", var_3, "player_id", var_4]);
}

function ref_119b3(var_0, var_1, var_2, var_3, var_4) {
  if(!analyticslogenabled()) {
    return;
  }

  var_5 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var_5 = self.analyticslog.playerid;
  }

  var_6 = createheadicon(var_0);
  getentitylessscriptablearray("analytics_mp_weapon_xp", ["weapon", var_6, "current_prestige", var_1, "current_level", var_2, "xp_gained", var_3, "xp_source", var_4, "player_id", var_5]);
}

function logevent_sendplayerindexdata() {
  if(!analyticslogenabled()) {
    return;
  }

  var_0 = [];
  var_1 = [];
  var_2 = 0;

  for(var_2 = 0; var_2 < 12; var_2++) {
    var_0 = 0;
    var_1 = "";
  }

  var_2 = 0;

  foreach(var_4 in level.players) {
    if(!isai(var_4)) {
      var_0 = var_4.analyticslog.playerid;
      var_1 = var_4 getxuid();
    }

    var_2 += 1;
  }

  getentitylessscriptablearray("analytics_match_player_index_init", ["player1_index", var_0[0], "player1_xuid", var_1[0], "player2_index", var_0[1], "player2_xuid", var_1[1], "player3_index", var_0[2], "player3_xuid", var_1[2], "player4_index", var_0[3], "player4_xuid", var_1[3], "player5_index", var_0[4], "player5_xuid", var_1[4], "player6_index", var_0[5], "player6_xuid", var_1[5], "player7_index", var_0[6], "player7_xuid", var_1[6], "player8_index", var_0[7], "player8_xuid", var_1[7], "player9_index", var_0[8], "player9_xuid", var_1[8], "player10_index", var_0[9], "player10_xuid", var_1[9], "player11_index", var_0[10], "player11_xuid", var_1[10], "player12_index", var_0[11], "player12_xuid", var_1[11]]);
}

function analyticsspawnlogenabled() {
  return getdvarint("enable_analytics_spawn_log") != 0;
}

function ref_119b9() {
  var_0 = "";

  if(scripts\cp\utility::tryingtoleave()) {
    switch (level.script) {
      case "cp_so_highway":
        var_0 = "OPERATION SAFEGUARD";
        break;
      case "cp_so_embassy":
        var_0 = "OPERATION DISINFORM";
        break;
      case "cp_so_aniyah":
        var_0 = "OPERATION DOOR KICK";
        break;
      case "cp_so_estate":
        var_0 = "OPERATION PITCH BLACK";
        break;
      case "cp_so_finale":
        var_0 = "OPERATION GROUNDED";
        break;
      case "cp_so_safehouse":
        var_0 = "OPERATION BOMB SQUAD";
        break;
      default:
        var_0 = "Classic Special Ops";
        break;
    }
  } else if(scripts\cp\utility::turn_off_sniper_laser()) {
    switch (level.script) {
      case "cp_sv_crash":
        var_0 = "Survival in Crash";
        break;
      case "cp_sv_cave_pm":
        var_0 = "Survival in Azhir Cave";
        break;
      case "cp_sv_petrograd":
        var_0 = "Survival in Petrograd";
        break;
      case "cp_sv_speed":
        var_0 = "Survival in Shoot House";
        break;
      case "cp_sv_raid":
        var_0 = "Survival in Grazna Raid";
        break;
      case "cp_sv_aniyah":
        var_0 = "Survival in Aniyah Palace";
        break;
      case "cp_piccadilly":
        var_0 = "Survival in Piccadilly";
        break;
      case "cp_sv_bigstore":
        var_0 = "Survival in Emporium";
        break;
      case "cp_sv_vacant":
        var_0 = "Survival in Vacant";
        break;
      case "cp_sv_backlot":
        var_0 = "Survival in Backlot";
        break;
      case "cp_sv_village2":
        var_0 = "Survival in Village";
        break;
      default:
        var_0 = "Survival";
        break;
    }
  } else {
    switch (level.script) {
      case "cp_landlord_2":
        var_0 = "Operation Kuvalda";
        break;
      case "cp_landlord":
        var_0 = "Operation Headhunter";
        break;
      case "cp_arms_dealer":
        var_0 = "Operation Paladin";
        break;
      case "cp_armsdealer_2":
        var_0 = "Operation Crosswind";
        break;
      case "cp_dwn_twn_2":
        var_0 = "Operation ";
        break;
      case "cp_smuggler":
        var_0 = "Operation Harbinger";
        break;
      case "cp_smuggler_2":
        var_0 = "Operation Brimstone";
        break;
      case "cp_scaletest":
        var_0 = "Operation Test ";
        break;
      case "cp_raid_complex":
        var_0 = "Raid";
        break;
      case "cp_dntsk_raid":
        var_0 = "Raid";
        break;
      default:
        var_0 = "Operations";
        break;
    }
  }

  var_1 = function_042d();
  getentitylessscriptablearray("dlog_event_coop_server_match_start", ["levelname", level.script, "gametype", scripts\cp\utility::getgametype(), "time_stamp", getsystemtime(), "active_objective", var_0, "playlist_name", var_1]);
}

function ref_119b8(var_0) {
  var_1 = "";

  if(isint(var_0)) {
    var_1 = "";

    switch (var_0) {
      case 1:
        var_1 = "win";
        break;
      case 2:
        var_1 = "fail";
        break;
      case 3:
        var_1 = "kia";
        break;
      case 4:
        var_1 = "host ended";
        break;
    }
  }

  var_2 = "";

  if(isDefined(level.completedobjectives) && isarray(level.completedobjectives) && level.completedobjectives.size > 0) {
    var_2 = level.completedobjectives[level.completedobjectives.size - 1].objname;
  }

  if(var_1 != "") {
    if(scripts\cp\utility::turn_off_sniper_laser()) {
      var_1 = "KIA";
    }

    getentitylessscriptablearray("dlog_event_coop_server_match_end", ["levelname", level.script, "gametype", scripts\cp\utility::getgametype(), "time_stamp", getsystemtime(), "active_objective", level.active_objectives_string, "last_completed_objective", var_2, "result", var_1]);
    return;
  }

  getentitylessscriptablearray("dlog_event_coop_server_match_end", ["levelname", level.script, "gametype", scripts\cp\utility::getgametype(), "time_stamp", getsystemtime(), "active_objective", level.active_objectives_string, "last_completed_objective", var_2, "result", var_0]);
}

function ref_119bf(var_0, var_1, var_2, var_3, var_4) {
  if(!isPlayer(var_0)) {
    return;
  }

  var_0 dlog_recordplayerevent("dlog_event_cpdata_plr_xp_earned", ["player_xp_earned", var_1, "weapon", var_2, "weapon_xp_earned", var_3, "xp_source", var_4, "levelname", level.script, "active_objective", level.active_objectives_string]);
}

function ref_119b6(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }

  var_0 dlog_recordplayerevent("dlog_event_cpdata_plr_munition_used", ["levelname", level.script, "playername", var_0.name, "x1", var_0.origin[0], "y1", var_0.origin[1], "z1", var_0.origin[2], "munition", var_1, "active_objective", level.active_objectives_string]);
}

function ref_119be(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }

  var_0 dlog_recordplayerevent("dlog_event_cpdata_plr_super_used", ["levelname", level.script, "playername", var_0.name, "x1", var_0.origin[0], "y1", var_0.origin[1], "z1", var_0.origin[2], "super", var_1, "active_objective", level.active_objectives_string]);
}

function ref_119b4(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }

  var_0 dlog_recordplayerevent("dlog_event_cpdata_plr_kidnapper", ["levelname", level.script, "version", var_1, "times_kidnapped", var_0.times_kidnapped, "active_objective", level.active_objectives_string]);
}

function ref_119bd(var_0) {
  if(!isPlayer(var_0)) {
    return;
  }

  var_0 dlog_recordplayerevent("dlog_event_cpdata_plr_spawn_via_teamrevive", ["levelname", level.script, "last_stand_id", punishwavechaseplayers(var_0), "active_objective", level.active_objectives_string]);
}

function ref_119bb(var_0) {
  if(!isPlayer(var_0)) {
    return;
  }

  var_0 dlog_recordplayerevent("dlog_event_cpdata_plr_spawn_via_autorevive", ["levelname", level.script, "last_stand_id", punishwavechaseplayers(var_0), "active_objective", level.active_objectives_string]);
}

function ref_119bc(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }

  var_0 dlog_recordplayerevent("dlog_event_cpdata_plr_spawn_via_player", ["reviver", var_1, "levelname", level.script, "last_stand_id", punishwavechaseplayers(var_0), "x1", var_0.origin[0], "y1", var_0.origin[1], "z1", var_0.origin[2], "active_objective", level.active_objectives_string]);
}

function ref_119b5(var_0, var_1, var_2) {
  if(!isPlayer(var_0)) {
    return;
  }

  var_3 = scripts\engine\utility::ter_op(isPlayer(var_1), var_1.name, var_1.agent_type);
  var_0 dlog_recordplayerevent("dlog_event_cpdata_plr_combat", ["levelname", level.script, "x1", var_0.origin[0], "y1", var_0.origin[1], "z1", var_0.origin[2], "stat_type", "Killed", "enemy", var_3, "x2", var_1.origin[0], "y2", var_1.origin[1], "z2", var_1.origin[2], "active_objective", level.active_objectives_string, "weapon", var_2.basename]);
}

function ref_119b2(var_0, var_1) {
  if(!isPlayer(var_0)) {
    return;
  }

  ref_13f9c(var_0);
  var_2 = scripts\engine\utility::ter_op(isagent(var_1), var_1.agent_type, var_0.name);
  var_0 dlog_recordplayerevent("dlog_event_cpdata_plr_downed", ["levelname", level.script, "enemy", var_2, "last_stand_id", punishwavechaseplayers(var_0), "x1", var_0.origin[0], "y1", var_0.origin[1], "z1", var_0.origin[2], "active_objective", level.active_objectives_string]);
}

function ref_13f9c(var_0) {
  if(!isDefined(var_0.watch_for_helis_killed)) {
    var_0.watch_for_helis_killed = 0;
  } else {
    var_0.watch_for_helis_killed++;
  }

  return var_0.watch_for_helis_killed;
}

function punishwavechaseplayers(var_0) {
  return var_0.watch_for_helis_killed;
}