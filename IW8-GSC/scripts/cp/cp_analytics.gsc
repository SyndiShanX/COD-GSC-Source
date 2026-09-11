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

function init_weapon_and_player_analytics(var0) {
  var0 endon("disconnect");

  while(!isDefined(var0.pers)) {
    wait 1;
  }

  var0.timewithitem = [];
  var0.killswithitem = [];
  var0.itemtype = " ";
  var0.timeitemlasted = [];

  if(!isDefined(level.brutefirstspawn)) {
    level.brutefirstspawn = 0;
  }

  if(level.wave_num == 0) {
    var0.pers["timesPerWave"] = spawnStruct();
    var0.pers["timesPerWave"].timesperwave = [];
    var0.pers["timesPerWave"].timesperwave[level.wave_num + 1] = [];
    var0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["bowling_for_planets"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["bowling_for_planets_afterlife"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["coaster"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["laughingclown"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["laughingclown_afterlife"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["basketball_game"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["basketball_game_afterlife"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["clown_tooth_game"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["clown_tooth_game_afterlife"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["game_race"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["shooting_gallery"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["shooting_gallery_afterlife"] = 0;
  }

  if(!isDefined(var0.pers["timesPerWave"])) {
    var0.pers["timesPerWave"] = spawnStruct();
    var0.pers["timesPerWave"].timesperwave = [];
    var0.pers["timesPerWave"].timesperwave[level.wave_num] = [];
    var0.pers["timesPerWave"].timesperwave[level.wave_num]["bowling_for_planets"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num]["bowling_for_planets_afterlife"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num]["coaster"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num]["laughingclown"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num]["laughingclown_afterlife"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num]["basketball_game"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num]["basketball_game_afterlife"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num]["clown_tooth_game"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num]["clown_tooth_game_afterlife"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num]["game_race"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num]["shooting_gallery"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num]["shooting_gallery_afterlife"] = 0;
  } else if(!isDefined(var0.pers["timesPerWave"].timesperwave[level.wave_num + 1])) {
    var0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["bowling_for_planets"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["bowling_for_planets_afterlife"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["coaster"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["laughingclown"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["laughingclown_afterlife"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["basketball_game"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["basketball_game_afterlife"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["clown_tooth_game"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["clown_tooth_game_afterlife"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["game_race"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["shooting_gallery"] = 0;
    var0.pers["timesPerWave"].timesperwave[level.wave_num + 1]["shooting_gallery_afterlife"] = 0;
  }

  var0.itemuses = [];
  var0.itemkills = [];
  var0.itemignored = " ";
  var0.itemreplaced = " ";
  var0.itempicked = " ";
  var0.itemuses[var0.itempicked] = 0;
  var0.itemkills[var0.itempicked] = 0;

  if(!isDefined(var0.totalxpearned)) {
    var0.totalxpearned = 0;
  }

  if(!isDefined(var0.score_earned)) {
    var0.score_earned = 0;
  }

  var0.downsperweaponlog = [];
  var0.killsperweaponlog = [];
  var0.wavesheldwithweapon = [];
  var0.shotsfiredwithweapon = [];
  var0.shotsontargetwithweapon = [];
  var0.headshots = [];
  var0.total_match_headshots = 0;
  var0.aggregateweaponkills = [];
  var0.weapon_name_log = " ";
  var0.accuracy_shots_fired = 0;
  var0.accuracy_shots_on_target = 0;
  var0.explosive_kills = 0;
  var0.total_trap_kills = 0;

  if(!isDefined(var0.exitingafterlifearcade)) {
    var0.exitingafterlifearcade = 0;
  }

  var0.meleekill = 0;
  var0.kung_fu_vo = 0;

  if(!isDefined(var0.trapkills)) {
    var0.trapkills = [];
  }

  var1 = ["trap_gator", "trap_dragon", "trap_gravitron", "trap_danceparty", "trap_rocket", "trap_spin"];

  foreach(var3 in var1) {
    if(!isDefined(var0.trapkills[var3])) {
      var0.trapkills[var3] = 0;
    }
  }

  var5 = var0.getweaponslist;

  if(isDefined(var5)) {
    foreach(var7 in var5) {
      var0.weapon_name_log = scripts\cp\utility::getbaseweaponname(var7);

      if(!isDefined(var0.aggregateweaponkills[var0.weapon_name_log])) {
        var0.aggregateweaponkills[var0.weapon_name_log] = 0;
      }
    }

    return;
  }
}

function revive_success_analytics_func(var0) {
  log_event("revived_another_player", 1, [var0.clientid], [var0.clientid], [var0.clientid]);
}

function zombieendgameanalytics() {
  var0 = ["trap_gator", "trap_dragon", "trap_gravitron", "trap_danceparty", "trap_rocket", "trap_spin"];

  foreach(var2 in level.players) {
    log_weapons_data(var3, var2);
    log_headshots_data(var3, var2);
  }
}

function log_headshots_data(var0, var1) {
  foreach(var5, var3 in var1.headshots) {
    if(var5 == "none" || var5 == "" || var3 == 0 || !scripts\engine\utility::array_contains(level.loadout_weapons, var5)) {
      continue;
    }

    setclientmatchdata("player", var0, "headShots", scripts\cp\utility::getbaseweaponname(var5), var3);
    var4 = var1 getplayerdata("cp", "headShots", scripts\cp\utility::getbaseweaponname(var5));
    var1 setplayerdata("cp", "headShots", scripts\cp\utility::getbaseweaponname(var5), var4 + var3);
  }

  setclientmatchdata("player", var0, "total_headshots", var1.total_match_headshots);
}

function log_card_data(var0, var1) {
  if(!isDefined(var1.consumables)) {
    return;
  }

  if(level.gametype != "zombies") {
    return;
  }

  foreach(var3 in var1.consumables) {
    var4 = var1 getplayerdata("cp", "cards_used", var5);
    var1 setplayerdata("cp", "cards_used", var5, var4 + var3.times_used);
  }
}

function log_explosive_kills(var0, var1) {
  if(!isDefined(var1.explosive_kills)) {
    return;
  }

  var2 = var1 getplayerdata("cp", "explosive_kills");
  var1 setplayerdata("cp", "explosive_kills", var2 + var1.explosive_kills);
}

function log_weapons_data(var0, var1) {
  var2 = 0;
  var3 = 0;
  var4 = "";

  foreach(var8, var6 in var1.aggregateweaponkills) {
    if(var8 == "none" || var8 == "" || var6 == 0 || !scripts\engine\utility::array_contains(level.loadout_weapons, var8)) {
      continue;
    }

    setclientmatchdata("player", var0, "killsPerWeapon", scripts\cp\utility::getbaseweaponname(var8), var6);
    var7 = var1 getplayerdata("cp", "killsPerWeapon", scripts\cp\utility::getbaseweaponname(var8));
    var1 setplayerdata("cp", "killsPerWeapon", scripts\cp\utility::getbaseweaponname(var8), var7 + var6);

    if(var1.aggregateweaponkills[var8] > 0 && var2 == 0) {
      var3 = var1.aggregateweaponkills[var8];
      var2 = 1;
      var4 = scripts\cp\utility::getbaseweaponname(var8);
    }

    if(var1.aggregateweaponkills[var8] > var3) {
      var3 = var1.aggregateweaponkills[var8];
      var4 = scripts\cp\utility::getbaseweaponname(var8);
    }
  }

  if(var3 > 0) {
    setclientmatchdata("player", var0, "DeadliestWeapon", var4);
    setclientmatchdata("player", var0, "DeadliestWeaponKills", var3);
  }

  var9 = var1 getplayerdata("cp", "DeadliestWeaponName");
  var7 = var1 getplayerdata("cp", "DeadliestWeaponKills", var9);

  if(var7 < var3) {
    if(var3 > 0) {
      var10 = var1 getplayerdata("cp", "killsPerWeapon", var4);

      if(!isDefined(var1.aggregateweaponkills[var4])) {
        var1 setplayerdata("cp", "DeadliestWeaponKills", var4, var10);
      } else {
        var1 setplayerdata("cp", "DeadliestWeaponKills", var4, var10);
      }

      var1 setplayerdata("cp", "DeadliestWeaponName", var4);
      return;
    }

    return;
  }

  var11 = var2 getplayerdata("cp", "killsPerWeapon", var10);

  if(!isDefined(var2.aggregateweaponkills[var10])) {
    var2 setplayerdata("cp", "DeadliestWeaponKills", var10, var11);
  } else {
    var2 setplayerdata("cp", "DeadliestWeaponKills", var10, var2.aggregateweaponkills[var10] + var11);
  }

  var2 setplayerdata("cp", "DeadliestWeaponName", var10);
}

function start_game_type(var0, var1, var2) {
  init(var2);
  init_matchdata(var0, var1);
}

function init_matchdata(var0, var1) {
  setclientmatchdatadef(var1);

  if(getdvarint("TLRPKRKMS") != 0) {
    setmatchdatadef(var0);
    setmatchdata("commonMatchData", "map", level.script);
    setmatchdata("commonMatchData", "gametype", getDvar("MOLPOSLOMO"));
    setmatchdata("commonMatchData", "build_version", getbuildversion());
    setmatchdata("commonMatchData", "build_number", getbuildnumber());
    setmatchdata("commonMatchData", "utc_start_time_s", getsystemtime());
    setmatchdata("commonMatchData", "is_private_match", getdvarint("LSTLQTSSRM"));
    setmatchdata("commonMatchData", "is_ranked_match", 1);
  }

  thread wait_set_initial_player_count();
}

function init(var0) {
  var1 = spawnStruct();
  var2 = [];
  var1.single_value_stats = var2;
  var3 = [];
  var1.challenge_results = var3;
  level.cp_matchdata = var1;
  init_analytics(var0);
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
  var0 = isbot(self) || initmaxspeedforpathlengthtable(self) || isai(self);

  if(scripts\cp\utility::rankingenabled()) {
    var1 = self getplayerdata("common", "mpProgression", "playerLevel", "xp");
    var2 = self getplayerdata("mp", "playerStats", "combatStats", "kills");
    var3 = self getplayerdata("mp", "playerStats", "combatStats", "deaths");
    var4 = self getplayerdata("mp", "playerStats", "matchStats", "wins");
    var5 = self getplayerdata("mp", "playerStats", "matchStats", "losses");
    var6 = self getplayerdata("mp", "playerStats", "combatStats", "hits");
    var7 = self getplayerdata("mp", "playerStats", "combatStats", "misses");
    var8 = self getplayerdata("mp", "playerStats", "matchStats", "gamesPlayed");
    var9 = self getplayerdata("mp", "playerStats", "matchStats", "timePlayedTotal");
    var10 = self getplayerdata("mp", "playerStats", "matchStats", "score");
    var11 = self getplayerdata("common", "mpProgression", "playerLevel", "prestige");
  } else {
    var1 = 0;
    var2 = 0;
    var3 = 0;
    var4 = 0;
    var5 = 0;
    var6 = 0;
    var7 = 0;
    var8 = 0;
    var9 = 0;
    var10 = 0;
    var11 = 0;
  }

  var12 = self updatelastcovertime();
  GscBinSkip1(0x45, 0, "");
}

function ref_119cc(var0) {
  var1 = "";

  if(isDefined(var0) && isstring(var0)) {
    var1 = var0;
  } else {
    switch (var0) {
      case 1:
        var1 = "win";
        break;
      case 2:
        var1 = "fail";
        break;
      case 3:
        var1 = "kia";
        break;
      case 4:
        var1 = "host ended";
        break;
      default:
        var1 = "kia";
        break;
    }
  }

  if(level.teambased) {
    var2 = int(scripts\cp\drone\emp_drone::getteamrankxpmultiplier(self.team));
  } else {
    var2 = 0;
  }

  var3 = 0;
  var4 = 0;
  var5 = 0;
  var6 = 0;
  var7 = 0;
  var8 = 0;
  var9 = 0;

  if(scripts\cp\utility::onlinestatsenabled() && !scripts\cp\utility::tryingtoleave()) {
    if(isDefined(self.pers["summary"]["xp"])) {
      var3 = self.pers["summary"]["xp"];
    }

    if(isDefined(self.pers["summary"]["score"])) {
      var4 = self.pers["summary"]["score"];
    }

    if(isDefined(self.pers["summary"]["challenge"])) {
      var5 = self.pers["summary"]["challenge"];
    }

    if(isDefined(self.pers["summary"]["match"])) {
      var6 = self.pers["summary"]["match"];
    }

    if(isDefined(self.pers["summary"]["medal"])) {
      var7 = self.pers["summary"]["medal"];
    }

    if(isDefined(self.pers["summary"]["bonusXp"])) {
      var8 = self.pers["summary"]["bonusXp"];
    }

    if(isDefined(self.pers["summary"]["misc"])) {
      var9 = self.pers["summary"]["misc"];
    }
  }

  jumpiffalse(scripts\cp\utility::tryingtoleave()) LOC_000001eb;
  var10 = -1;
  goto LOC_000001fd;
}

function initsegmentstats() {
  level endon("game_ended");
  thread recordplayersegmentdata();

  for(;;) {
    level waittill("connected", var0);
    createplayersegmentstats(var0);
  }
}

function recordplayersegmentdata() {
  level endon("game_ended");
  scripts\cp\utility::gameflagwait("prematch_done");
  wait 4;

  for(;;) {
    wait 1;

    foreach(var1 in level.players) {
      thread updateplayersegmentdata();
    }
  }
}

function createplayersegmentstats(var0) {
  var0.segments = [];
  var0.segments["distanceTotal"] = 0;
  var0.segments["movingTotal"] = 0;
  var0.segments["movementUpdateCount"] = 0;
  var0.savedsegmentposition = var0.origin;
  var0.positionptm = var0.origin;
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
    var0 = distance2d(self.positionptm, self.origin);
    self.positionptm = self.origin;

    if(var0 > 16) {
      self.segments["movingTotal"]++;
      return;
    }

    return;
  }
}

function on_player_disconnect(var0) {
  set_custom_stats();
  level.player_count_left += 1;
  ref_119cc(var0);
}

function player_init() {
  var0 = spawnStruct();
  var1 = [];
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

function update_challenges_status(var0, var1) {
  if(level.cp_matchdata.challenge_results.size > 25) {
    return;
  }

  var2 = spawnStruct();
  var2.challenge_name = var0;
  var2.result = var1;
  level.cp_matchdata.challenge_results[level.cp_matchdata.challenge_results.size] = var2;
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

function inc_laststand_record(var0) {
  if(!isDefined(self.cp_matchdata.laststand_record[var0][level.wave_num])) {
    self.cp_matchdata.laststand_record[var0][level.wave_num] = 0;
  }

  self.cp_matchdata.laststand_record[var0][level.wave_num]++;
}

function update_spending_type(var0, var1) {
  switch (var1) {
    case "weapon":
      self.cp_matchdata.single_value_stats["cashSpentOnWeapon"].value = self.cp_matchdata.single_value_stats["cashSpentOnWeapon"].value + var0;
      break;
    case "ability":
      self.cp_matchdata.single_value_stats["cashSpentOnAbility"].value = self.cp_matchdata.single_value_stats["cashSpentOnAbility"].value + var0;
      break;
    case "trap":
      self.cp_matchdata.single_value_stats["cashSpentOnTrap"].value = self.cp_matchdata.single_value_stats["cashSpentOnTrap"].value + var0;
      break;
    default:
      break;
  }
}

function endgame(var0, var1) {
  set_game_data(var0, var1);
  write_global_clientmatchdata();

  foreach(var3 in level.players) {
    scripts\cp\cp_persistence::increment_player_career_total_waves(var3);
    scripts\cp\cp_persistence::increment_player_career_total_score(var3);
    set_player_data(var3, var1);
    set_player_game_data(var3);
    write_clientmatchdata_for_player(var3, var3, var4);
  }

  if(isDefined(level.analyticsendgame)) {
    [[level.analyticsendgame]]();
  }

  if(getdvarint("TLRPKRKMS") != 0) {
    sendmatchdata();
  }

  sendclientmatchdata();
}

function set_player_data(var0) {
  var1 = self getplayerdata("cp", "coopCareerStats", "totalGameplayTime");
  var2 = self getplayerdata("cp", "coopCareerStats", "gamesPlayed");

  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  var1 += var0 / 1000;
  var2 += 1;
  self setplayerdata("cp", "coopCareerStats", "totalGameplayTime", int(var1));
  self setplayerdata("cp", "coopCareerStats", "gamesPlayed", int(var2));
}

function set_game_data(var0, var1) {
  var2 = "challengesCompleted";
  var3 = level.cp_matchdata;

  foreach(var5 in var3.single_value_stats) {
    var6 = validate_value(var5.value, var5.value_type);
  }

  foreach(var9 in var3.challenge_results) {}

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

function get_player_matchdata(var0, var1) {
  if(isDefined(level.matchdata["player"][self.clientid]) && isDefined(level.matchdata["player"][self.clientid][var0])) {
    return level.matchdata["player"][self.clientid][var0];
  }

  return var1;
}

function set_custom_stats() {
  var0 = self getplayerdata("cp", "coopCareerStats", "totalGameplayTime");
  var1 = self getplayerdata("cp", "coopCareerStats", "gamesPlayed");
  var2 = self getplayerdata("cp", "progression", "playerLevel", "rank");
  var3 = self getplayerdata("cp", "progression", "playerLevel", "prestige");
}

function copy_from_playerdata() {}

function set_laststand_stats() {}

function set_single_value_stats() {}

function validate_value(var0, var1) {
  switch (var1) {
    case "byte":
      return validate_byte(var0);
    case "short":
      return validate_short(var0);
    case "int":
      return validate_int(var0);
    default:
      break;
  }
}

function validate_byte(var0) {
  return int(min(var0, 127));
}

function validate_short(var0) {
  return int(min(var0, 32767));
}

function validate_int(var0) {
  return int(min(var0, 2147483647));
}

function get_single_value_struct(var0, var1) {
  var2 = spawnStruct();
  var2.value = var0;
  var2.value_type = var1;
  return var2;
}

function init_analytics(var0) {
  var1 = 0;
  var2 = 1;
  var3 = 2;
  var4 = 1;
  var5 = 2;
  var6 = 3;
  var7 = 4;
  var8 = 5;
  var9 = 6;
  var10 = 1;
  var11 = 100;
  var12 = 101;
  var13 = 300;
  level.blackbox_data_type = [];
  level.matchdata_struct = [];
  level.matchdata_data_type = [];
  level.matchdata = [];
  level.clientmatchdata_struct = [];
  level.clientmatchdata_data_type = [];
  level.clientmatchdata = [];

  for(var14 = var12; var14 <= var13; var14++) {
    var15 = tablelookup(var0, var1, var14, var4);

    if(var15 == "") {
      continue;
    }

    var16 = tablelookup(var0, var1, var14, var5);

    if(var16 != "") {
      level.blackbox_data_type[var15] = var16;
    }

    var17 = tablelookup(var0, var1, var14, var6);

    if(var17 != "") {
      level.matchdata_data_type[var15] = var17;
    }

    var18 = tablelookup(var0, var1, var14, var7);

    if(var18 != "") {
      level.matchdata_struct[var15] = [];
      level.matchdata[var15] = [];
    }

    var19 = tablelookup(var0, var1, var14, var8);

    if(var19 != "") {
      level.clientmatchdata_data_type[var15] = var19;
    }

    var20 = tablelookup(var0, var1, var14, var9);

    if(var20 != "") {
      level.clientmatchdata_struct[var15] = [];
      level.clientmatchdata[var15] = [];
    }
  }

  level.analytics_event = [];

  for(var14 = var10; var14 <= var11; var14++) {
    var21 = tablelookup(var0, var1, var14, var2);

    if(var21 == "") {
      break;
    }

    var22 = tablelookup(var0, var1, var14, var3);
    level.analytics_event[var21] = var22;
    var23 = strtok(var22, " ");

    foreach(var25 in var23) {
      if(isDefined(level.matchdata_struct[var25])) {
        level.matchdata_struct[var25][var21] = 0;
      }

      if(isDefined(level.clientmatchdata_struct[var25]) && isDefined(level.clientmatchdata_data_type[var21])) {
        level.clientmatchdata_struct[var25][var21] = 0;
      }
    }
  }
}

function log_event(var0, var1, var2, var3, var4) {
  var5 = get_data_to_update(var0);
  log_clientmatchdata(var0, var5, var1, var4);
}

function log_clientmatchdata(var0, var1, var2, var3) {
  if(!isDefined(var3)) {
    return;
  }

  var4 = 0;

  if(is_clientmatchdata_data(var0)) {
    foreach(var6 in var1) {
      if(is_clientmatchdata_struct(var6)) {
        var7 = var3[var4];

        if(!isDefined(level.clientmatchdata[var6][var7])) {
          level.clientmatchdata[var6][var7] = level.clientmatchdata_struct[var6];
        }

        level.clientmatchdata[var6][var7][var0] += var2;
        var4++;
      }
    }

    return;
  }
}

function get_bb_string(var0) {
  var1 = "";

  foreach(var3 in var0) {
    var1 += var3 + " " + level.blackbox_data_type[var3];

    if(var4 != var0.size - 1) {
      var1 += " ";
    }
  }

  return var1;
}

function get_data_to_update(var0) {
  var1 = level.analytics_event[var0];
  return strtok(var1, " ");
}

function log_matchdata(var0, var1, var2, var3) {
  var4 = 0;

  foreach(var6 in var1) {
    if(is_matchdata_struct(var6)) {
      var7 = var3[var4];

      if(!isDefined(level.matchdata[var6][var7])) {
        level.matchdata[var6][var7] = level.matchdata_struct[var6];
      }

      level.matchdata[var6][var7][var0] += var2;
      var4++;
    }
  }
}

function is_matchdata_struct(var0) {
  return isDefined(level.matchdata_struct[var0]);
}

function is_clientmatchdata_struct(var0) {
  return isDefined(level.clientmatchdata_struct[var0]);
}

function is_clientmatchdata_data(var0) {
  return isDefined(level.clientmatchdata_data_type[var0]);
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

function write_clientmatchdata_for_player(var0, var1) {
  setclientmatchdata("player", var1, "username", var0.name);
  var2 = var0 getplayerdata("cp", "alienSession", "kills");
  var3 = var0 getplayerdata("cp", "alienSession", "downed");
  var4 = var0 getplayerdata("cp", "alienSession", "revives");
  var5 = var0 getxuidhigh();
  var6 = var0 getxuidlow();

  if(!scripts\cp\utility::tryingtoleave()) {
    if(scripts\cp\utility::matchmakinggame()) {
      setclientmatchdata("player", var1, "rank", var0 scripts\cp\drone\emp_drone::getrank());
    } else {
      setclientmatchdata("player", var1, "rank", var0 scripts\cp\cp_persistence::get_player_rank());
    }
  }

  if(!isDefined(var0.player_character_index)) {
    return;
  }

  setclientmatchdata("player", var1, "characterIndex", var0.player_character_index);
  var7 = level.clientmatchdata["player"][var0.clientid];

  if(isDefined(var7)) {
    foreach(var9 in var7) {
      setclientmatchdata("player", var1, var10, int(var9));
    }
  }

  if(isDefined(level.endgame_write_clientmatchdata_for_player_func)) {
    [[level.endgame_write_clientmatchdata_for_player_func]](var0, var1);
    return;
  }
}

function lootchopper_getattackerdata() {
  setdvarifuninitialized("OLMQKSKMRS", 0);
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
  return getdvarint("OLMQKSKMRS") == 1;
}

function getuniqueobjectid() {
  var0 = level.analyticslog.nextobjectid;
  level.analyticslog.nextobjectid++;
  return var0;
}

function cacheplayeraction(var0) {
  if(!isDefined(self.analyticslog.cachedactions)) {
    self.analyticslog.cachedactions = 0;
  }

  self.analyticslog.cachedactions |= var0;
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
    var0 = scripts\engine\utility::ref_143ad("log_user_event_end", "log_user_event_generic_event");

    if(isDefined(var0) && var0 == "log_user_event_generic_event") {
      self iprintlnbold("Event Logged");
      logevent_message(self.name, self.origin, "Generic User Event");
    }
  }
}

function checkstancestatus() {
  var0 = self getstance();

  if(var0 == "prone") {
    cacheplayeraction(1);
    return;
  }

  if(var0 == "crouch") {
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

  if(getDvar("OLKQSLNLPM") == "0") {
    return;
  }

  if(isDefined(scripts\cp\utility::getgametype()) && scripts\cp\utility::getgametype() == "br") {
    var0 = getdvarfloat("MQPMTNTSLO", 4);
  } else {
    var0 = getdvarfloat("NSMKNLRLON", 2);
  }

  scripts\mp\flags::gameflagwait("prematch_done");

  for(;;) {
    foreach(var2 in level.players) {
      if(!isDefined(var2)) {
        continue;
      }

      var3 = scripts\cp\utility\player::isreallyalive(var2) && !isai(var2);
      var4 = isDefined(var2.matchdatalifeindex) && scripts\cp\agents\agents::canlogclient(var2);
      var5 = isDefined(var2.team) && var2.team != "spectator" && var2.sessionstate == "playing" && var2.sessionstate != "dead";

      if(var3 && var4 && var5) {
        var6 = var2 scripts\cp\utility::isplayerads();
        var7 = scripts\cp\agents\agents::gettimefrommatchstart(gettime());
        var2 recordbreadcrumbdataforplayer(var7, var2.matchdatalifeindex, var6);
      }
    }

    wait var0;
  }
}

function getpathactionvalue() {
  var0 = scripts\engine\utility::ter_op(isDefined(self.analyticslog.cachedactions), self.analyticslog.cachedactions, 0);

  if(self iswallrunning()) {
    var0 |= 32;
  }

  return var0;
}

function clearpathactionvalue() {
  self.analyticslog.cachedactions = 0;
  checkstancestatus();
}

function buildkilldeathactionvalue() {
  var0 = 0;
  var1 = self getstance();

  if(var1 == "prone") {
    var0 |= 1;
  } else if(var1 == "crouch") {
    var0 |= 2;
  }

  if(self isjumping()) {
    var0 |= 4;
  }

  if(isDefined(self.lastshotfiredtime) && gettime() - self.lastshotfiredtime < 500) {
    var0 |= 8;
  }

  if(self isreloading()) {
    var0 |= 16;
  }

  return var0;
}

function buildloadoutstring() {
  var0 = "archetype =" + self.loadoutarchetype + ";" + "powerPrimary=" + self.loadoutequipmentprimary + ";" + "powerSecondary=" + self.loadoutequipmentsecondary + ";" + "weaponPrimary =" + self.primaryweapon + ";" + "weaponSecondary =" + self.secondaryweapon + ";";
  return var0;
}

function buildspawnpointstatestring(var0) {
  var1 = "";

  if(isDefined(var0.lastbucket)) {
    if(isDefined(var0.lastbucket["allies"])) {
      var1 += "alliesBucket=" + var0.lastbucket["allies"] + ";";
    }

    if(isDefined(var0.lastbucket["axis"])) {
      var1 += "axisBucket=" + var0.lastbucket["axis"] + ";";
    }
  }

  return var1;
}

function logevent_path() {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  var0 = anglesToForward(self getplayerangles());
  getentitylessscriptablearray("gamecp_path", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", var0[0], "gun_orienty", var0[1], "gun_orientz", var0[2], "action", getpathactionvalue(), "health", getsantizedhealth()]);
  clearpathactionvalue();
}

function logevent_playerspawn() {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  var0 = isDefined(self.lastspawnpoint) && isDefined(self.lastspawnpoint.buddyspawn) && self.lastspawnpoint.buddyspawn;
  var1 = anglesToForward(self.angles);
  getentitylessscriptablearray("gamecp_spawn_in", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "orientx", var1[0], "orienty", var1[1], "orientz", var1[2], "loadout", buildloadoutstring(), "type", scripts\engine\utility::ter_op(var0, "Buddy", "Normal"), "team", self.team]);
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

  var0 = undefined;

  if(isDefined(self.changedarchetypeinfo)) {
    var0 = self.changedarchetypeinfo.super;
  } else {
    var0 = self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypeSuper");
  }

  var1 = self getxuid();
  getentitylessscriptablearray("gamecp_player_connect", ["playerid", self.analyticslog.playerid, "player_name", self.name, "player_xuid", var1, "player_super_name", var0]);
}

function logevent_playerdeath(var0, var1, var2) {
  if(!shouldplayerlogevents(self) || !isPlayer(self)) {
    return;
  }

  var3 = anglesToForward(self getplayerangles());
  var4 = -1;
  var5 = 0;
  var6 = 0;
  var7 = 0;
  var8 = 0;
  var9 = 0;
  var10 = 0;
  var11 = "s";
  var12 = 0;

  if(isDefined(var0) && isPlayer(var0)) {
    var4 = var0.analyticslog.playerid;

    if(isDefined(var0.team)) {
      if(var0.team == "axis") {
        var11 = "a";
      } else {
        var11 = "l";
      }
    }

    if(isDefined(var0.origin)) {
      var5 = var0.origin[0];
      var6 = var0.origin[1];
      var7 = var0.origin[2];
    }

    if(isDefined(var0.lifeid)) {
      var12 = var0.lifeid;
    }

    var13 = anglesToForward(var0 getplayerangles());

    if(isDefined(var13)) {
      var8 = var13[0];
      var9 = var13[1];
      var10 = var13[2];
    }
  }

  var14 = level.analyticslog.nextdeathid;
  level.analyticslog.nextdeathid++;
  var2 = scripts\engine\utility::ter_op(isDefined(var2), var2, "None");
  var15 = "s";

  if(self.team == "axis") {
    var15 = "a";
  } else {
    var15 = "l";
  }

  getentitylessscriptablearray("134death", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", var3[0], "gun_orienty", var3[1], "gun_orientz", var3[2], "weapon", var2, "mean_of_death", scripts\engine\utility::ter_op(isDefined(var1), var1, "None"), "attackerid", var4, "action", buildkilldeathactionvalue(), "server_death_id", var14, "victim_life_index", self.lifeid, "attacker_life_index", var12, "victim_team", var15, "attacker_team", var11, "attacker_pos_x", var5, "attacker_pos_y", var6, "attacker_pos_z", var7, "attacker_gun_orientx", var8, "attacker_gun_orienty", var9, "attacker_gun_orientz", var10, "victim_weapon", self.primaryweapon]);

  if(isDefined(var1) && isexplosivedamagemod(var1)) {
    logevent_explosion(scripts\engine\utility::ter_op(isDefined(var2), var2, "generic"), self.origin, var0, 1);
  }

  if(isDefined(self.attackers)) {
    foreach(var17 in self.attackers) {
      if(isDefined(var17) && isPlayer(var17) && var17 != var0) {
        logevent_assist(var17.analyticslog.playerid, var14, var2);
      }
    }

    return;
  }
}

function logevent_playerkill(var0, var1, var2) {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  var3 = anglesToForward(self getplayerangles());
  getentitylessscriptablearray("gamecp_kill", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", var3[0], "gun_orienty", var3[1], "gun_orientz", var3[2], "weapon", scripts\engine\utility::ter_op(isDefined(var2), var2, "None"), "mean_of_kill", scripts\engine\utility::ter_op(isDefined(var1), var1, "None"), "victimid", scripts\engine\utility::ter_op(isDefined(var0) && isPlayer(var0), var0.analyticslog.playerid, "-1"), "action", buildkilldeathactionvalue(), "attacker_health", getsantizedhealth(), "victim_pixel_count", 0]);
}

function logevent_explosion(var0, var1, var2, var3, var4) {
  if(!analyticslogenabled()) {
    return;
  }

  if(!isDefined(var4)) {
    var4 = (1, 0, 0);
  }

  getentitylessscriptablearray("gamecp_explosion", ["playerid", var2.analyticslog.playerid, "x", var1[0], "y", var1[1], "z", var1[2], "orientx", var4[0], "orienty", var4[1], "orientz", var4[2], "duration", var3, "type", var0]);
}

function logevent_frontlineupdate(var0, var1, var2, var3, var4) {
  if(!analyticslogenabled()) {
    return;
  }

  getentitylessscriptablearray("gamecp_front_line", ["startx", var0[0], "starty", var0[1], "endx", var1[0], "endy", var1[1], "axis_centerx", var3[0], "axis_centery", var3[1], "allies_centerx", var2[0], "allies_centery", var2[1], "state", var4]);
}

function logevent_gameobject(var0, var1, var2, var3, var4) {
  if(!analyticslogenabled()) {
    return;
  }

  getentitylessscriptablearray("gamecp_object", ["uniqueid", var1, "x", var2[0], "y", var2[1], "z", var2[2], "ownerid", var3, "type", var0, "state", var4]);
}

function logevent_message(var0, var1, var2) {
  if(!analyticslogenabled()) {
    return;
  }

  getentitylessscriptablearray("gamecp_message", ["ownerid", var0, "x", var1[0], "y", var1[1], "z", var1[2], "message", var2]);
}

function logevent_tag(var0) {
  if(!analyticslogenabled()) {
    return;
  }

  bbprint("gamecp_matchtags", "message %s", var0);
}

function logevent_powerused(var0, var1) {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  var2 = anglesToForward(self.angles);
  getentitylessscriptablearray("gamecp_power", ["ownerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "orientx", var2[0], "orienty", var2[1], "orientz", var2[2], "type", var0, "state", var1]);
}

function logevent_scoreupdate() {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  var0 = anglesToForward(self.angles);
  getentitylessscriptablearray("gamecp_scoreboard", ["ownerid", self.analyticslog.playerid, "score", self.score]);
}

function logevent_minimapcorners() {
  if(!analyticslogenabled()) {
    return;
  }

  var0 = getEntArray("minimap_corner", "targetname");

  if(!isDefined(var0) || var0.size != 2) {
    return;
  }

  getentitylessscriptablearray("gamecp_map", ["cornera_x", var0[0].origin[0], "cornera_y", var0[0].origin[1], "cornerb_x", var0[1].origin[0], "cornerb_y", var0[1].origin[1], "north", getnorthyaw()]);
}

function logevent_assist(var0, var1, var2) {
  if(!analyticslogenabled()) {
    return;
  }

  getentitylessscriptablearray("gamecp_assists", ["playerid", var0, "server_death_id", var1, "weapon", var2]);
}

function getsantizedhealth() {
  return int(clamp(self.health, 0, 100000));
}

function shouldplayerlogevents(var0) {
  if(!analyticslogenabled()) {
    return false;
  }

  if(!isDefined(var0.team) || var0.team == "spectator" || var0.sessionstate != "playing" && var0.sessionstate != "dead") {
    return false;
  }

  return true;
}

function logmatchtags() {
  var0 = getDvar("scr_analytics_tag", "");

  if(var0 != "") {
    logevent_tag(var0);
  }

  if(scripts\cp\utility::matchmakinggame()) {
    logevent_tag("OnlineMatch");
    return;
  }

  if(getdvarint("LSTLQTSSRM")) {
    logevent_tag("PrivateMatch");
    return;
  }

  if(!getdvarint("LTSNLQNRKO")) {
    logevent_tag("OfflineMatch");
    return;
  }
}

function logevent_superended(var0, var1, var2, var3) {
  if(!analyticslogenabled()) {
    return;
  }

  var4 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var4 = self.analyticslog.playerid;
  }

  getentitylessscriptablearray("analytics_mp_supers", ["super_name", var0, "time_to_use", var1, "num_hits", var2, "num_kills", var3, "player_id", var4]);
}

function logevent_superearned(var0) {
  if(!analyticslogenabled()) {
    return;
  }

  var1 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var1 = self.analyticslog.playerid;
  }

  getentitylessscriptablearray("analytics_mp_super_earned", ["match_time", var0, "player_id", var1]);
}

function logevent_awardgained(var0) {
  if(!analyticslogenabled()) {
    return;
  }

  getentitylessscriptablearray("analytics_mp_awards", ["award_message", var0]);
}

function logevent_giveplayerxp(var0, var1, var2, var3) {
  if(!analyticslogenabled()) {
    return;
  }

  var4 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var4 = self.analyticslog.playerid;
  }

  getentitylessscriptablearray("analytics_mp_player_xp", ["current_prestige", var0, "current_level", var1, "xp_gained", var2, "xp_source", var3, "player_id", var4]);
}

function ref_119b3(var0, var1, var2, var3, var4) {
  if(!analyticslogenabled()) {
    return;
  }

  var5 = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    var5 = self.analyticslog.playerid;
  }

  var6 = createheadicon(var0);
  getentitylessscriptablearray("analytics_mp_weapon_xp", ["weapon", var6, "current_prestige", var1, "current_level", var2, "xp_gained", var3, "xp_source", var4, "player_id", var5]);
}

function logevent_sendplayerindexdata() {
  if(!analyticslogenabled()) {
    return;
  }

  var0 = [];
  var1 = [];
  var2 = 0;

  for(var2 = 0; var2 < 12; var2++) {
    var0 = 0;
    var1 = "";
  }

  var2 = 0;

  foreach(var4 in level.players) {
    if(!isai(var4)) {
      var0 = var4.analyticslog.playerid;
      var1 = var4 getxuid();
    }

    var2 += 1;
  }

  getentitylessscriptablearray("analytics_match_player_index_init", ["player1_index", var0[0], "player1_xuid", var1[0], "player2_index", var0[1], "player2_xuid", var1[1], "player3_index", var0[2], "player3_xuid", var1[2], "player4_index", var0[3], "player4_xuid", var1[3], "player5_index", var0[4], "player5_xuid", var1[4], "player6_index", var0[5], "player6_xuid", var1[5], "player7_index", var0[6], "player7_xuid", var1[6], "player8_index", var0[7], "player8_xuid", var1[7], "player9_index", var0[8], "player9_xuid", var1[8], "player10_index", var0[9], "player10_xuid", var1[9], "player11_index", var0[10], "player11_xuid", var1[10], "player12_index", var0[11], "player12_xuid", var1[11]]);
}

function analyticsspawnlogenabled() {
  return getdvarint("NTOSMKNMSM") != 0;
}

function ref_119b9() {
  var0 = "";

  if(scripts\cp\utility::tryingtoleave()) {
    switch (level.script) {
      case "cp_so_highway":
        var0 = "OPERATION SAFEGUARD";
        break;
      case "cp_so_embassy":
        var0 = "OPERATION DISINFORM";
        break;
      case "cp_so_aniyah":
        var0 = "OPERATION DOOR KICK";
        break;
      case "cp_so_estate":
        var0 = "OPERATION PITCH BLACK";
        break;
      case "cp_so_finale":
        var0 = "OPERATION GROUNDED";
        break;
      case "cp_so_safehouse":
        var0 = "OPERATION BOMB SQUAD";
        break;
      default:
        var0 = "Classic Special Ops";
        break;
    }
  } else if(scripts\cp\utility::turn_off_sniper_laser()) {
    switch (level.script) {
      case "cp_sv_crash":
        var0 = "Survival in Crash";
        break;
      case "cp_sv_cave_pm":
        var0 = "Survival in Azhir Cave";
        break;
      case "cp_sv_petrograd":
        var0 = "Survival in Petrograd";
        break;
      case "cp_sv_speed":
        var0 = "Survival in Shoot House";
        break;
      case "cp_sv_raid":
        var0 = "Survival in Grazna Raid";
        break;
      case "cp_sv_aniyah":
        var0 = "Survival in Aniyah Palace";
        break;
      case "cp_piccadilly":
        var0 = "Survival in Piccadilly";
        break;
      case "cp_sv_bigstore":
        var0 = "Survival in Emporium";
        break;
      case "cp_sv_vacant":
        var0 = "Survival in Vacant";
        break;
      case "cp_sv_backlot":
        var0 = "Survival in Backlot";
        break;
      case "cp_sv_village2":
        var0 = "Survival in Village";
        break;
      default:
        var0 = "Survival";
        break;
    }
  } else {
    switch (level.script) {
      case "cp_landlord_2":
        var0 = "Operation Kuvalda";
        break;
      case "cp_landlord":
        var0 = "Operation Headhunter";
        break;
      case "cp_arms_dealer":
        var0 = "Operation Paladin";
        break;
      case "cp_armsdealer_2":
        var0 = "Operation Crosswind";
        break;
      case "cp_dwn_twn_2":
        var0 = "Operation ";
        break;
      case "cp_smuggler":
        var0 = "Operation Harbinger";
        break;
      case "cp_smuggler_2":
        var0 = "Operation Brimstone";
        break;
      case "cp_scaletest":
        var0 = "Operation Test ";
        break;
      case "cp_raid_complex":
        var0 = "Raid";
        break;
      case "cp_dntsk_raid":
        var0 = "Raid";
        break;
      default:
        var0 = "Operations";
        break;
    }
  }

  var1 = function_042d();
  getentitylessscriptablearray("dlog_event_coop_server_match_start", ["levelname", level.script, "gametype", scripts\cp\utility::getgametype(), "time_stamp", getsystemtime(), "active_objective", var0, "playlist_name", var1]);
}

function ref_119b8(var0) {
  var1 = "";

  if(isint(var0)) {
    var1 = "";

    switch (var0) {
      case 1:
        var1 = "win";
        break;
      case 2:
        var1 = "fail";
        break;
      case 3:
        var1 = "kia";
        break;
      case 4:
        var1 = "host ended";
        break;
    }
  }

  var2 = "";

  if(isDefined(level.completedobjectives) && isarray(level.completedobjectives) && level.completedobjectives.size > 0) {
    var2 = level.completedobjectives[level.completedobjectives.size - 1].objname;
  }

  if(var1 != "") {
    if(scripts\cp\utility::turn_off_sniper_laser()) {
      var1 = "KIA";
    }

    getentitylessscriptablearray("dlog_event_coop_server_match_end", ["levelname", level.script, "gametype", scripts\cp\utility::getgametype(), "time_stamp", getsystemtime(), "active_objective", level.active_objectives_string, "last_completed_objective", var2, "result", var1]);
    return;
  }

  getentitylessscriptablearray("dlog_event_coop_server_match_end", ["levelname", level.script, "gametype", scripts\cp\utility::getgametype(), "time_stamp", getsystemtime(), "active_objective", level.active_objectives_string, "last_completed_objective", var2, "result", var0]);
}

function ref_119bf(var0, var1, var2, var3, var4) {
  if(!isPlayer(var0)) {
    return;
  }

  var0 dlog_recordplayerevent("dlog_event_cpdata_plr_xp_earned", ["player_xp_earned", var1, "weapon", var2, "weapon_xp_earned", var3, "xp_source", var4, "levelname", level.script, "active_objective", level.active_objectives_string]);
}

function ref_119b6(var0, var1) {
  if(!isPlayer(var0)) {
    return;
  }

  var0 dlog_recordplayerevent("dlog_event_cpdata_plr_munition_used", ["levelname", level.script, "playername", var0.name, "x1", var0.origin[0], "y1", var0.origin[1], "z1", var0.origin[2], "munition", var1, "active_objective", level.active_objectives_string]);
}

function ref_119be(var0, var1) {
  if(!isPlayer(var0)) {
    return;
  }

  var0 dlog_recordplayerevent("dlog_event_cpdata_plr_super_used", ["levelname", level.script, "playername", var0.name, "x1", var0.origin[0], "y1", var0.origin[1], "z1", var0.origin[2], "super", var1, "active_objective", level.active_objectives_string]);
}

function ref_119b4(var0, var1) {
  if(!isPlayer(var0)) {
    return;
  }

  var0 dlog_recordplayerevent("dlog_event_cpdata_plr_kidnapper", ["levelname", level.script, "version", var1, "times_kidnapped", var0.times_kidnapped, "active_objective", level.active_objectives_string]);
}

function ref_119bd(var0) {
  if(!isPlayer(var0)) {
    return;
  }

  var0 dlog_recordplayerevent("dlog_event_cpdata_plr_spawn_via_teamrevive", ["levelname", level.script, "last_stand_id", punishwavechaseplayers(var0), "active_objective", level.active_objectives_string]);
}

function ref_119bb(var0) {
  if(!isPlayer(var0)) {
    return;
  }

  var0 dlog_recordplayerevent("dlog_event_cpdata_plr_spawn_via_autorevive", ["levelname", level.script, "last_stand_id", punishwavechaseplayers(var0), "active_objective", level.active_objectives_string]);
}

function ref_119bc(var0, var1) {
  if(!isPlayer(var0)) {
    return;
  }

  var0 dlog_recordplayerevent("dlog_event_cpdata_plr_spawn_via_player", ["reviver", var1, "levelname", level.script, "last_stand_id", punishwavechaseplayers(var0), "x1", var0.origin[0], "y1", var0.origin[1], "z1", var0.origin[2], "active_objective", level.active_objectives_string]);
}

function ref_119b5(var0, var1, var2) {
  if(!isPlayer(var0)) {
    return;
  }

  var3 = scripts\engine\utility::ter_op(isPlayer(var1), var1.name, var1.agent_type);
  var0 dlog_recordplayerevent("dlog_event_cpdata_plr_combat", ["levelname", level.script, "x1", var0.origin[0], "y1", var0.origin[1], "z1", var0.origin[2], "stat_type", "Killed", "enemy", var3, "x2", var1.origin[0], "y2", var1.origin[1], "z2", var1.origin[2], "active_objective", level.active_objectives_string, "weapon", var2.basename]);
}

function ref_119b2(var0, var1) {
  if(!isPlayer(var0)) {
    return;
  }

  ref_13f9c(var0);
  var2 = scripts\engine\utility::ter_op(isagent(var1), var1.agent_type, var0.name);
  var0 dlog_recordplayerevent("dlog_event_cpdata_plr_downed", ["levelname", level.script, "enemy", var2, "last_stand_id", punishwavechaseplayers(var0), "x1", var0.origin[0], "y1", var0.origin[1], "z1", var0.origin[2], "active_objective", level.active_objectives_string]);
}

function ref_13f9c(var0) {
  if(!isDefined(var0.watch_for_helis_killed)) {
    var0.watch_for_helis_killed = 0;
  } else {
    var0.watch_for_helis_killed++;
  }

  return var0.watch_for_helis_killed;
}

function punishwavechaseplayers(var0) {
  return var0.watch_for_helis_killed;
}