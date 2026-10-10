/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\cp_analytics.gsc
***********************************************/

#using script_3f8889c16399185c;
#using script_4a6760982b403bad;
#using scripts\common\utility;
#using scripts\cp\cp_analytics;
#using scripts\cp\cp_gameskill;
#using scripts\cp\endgame;
#using scripts\cp\kits;
#using scripts\cp\persistence;
#using scripts\cp\utility;
#using scripts\cp\utility\connect_event_aggregator;
#using scripts\cp\utility\player;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\mp\flags;
#namespace cp_analytics;

function initlevelvars() {
  start_game_type("ddl/mp/cp_matchdata.ddl", "ddl/mp/zombieclientmatchdata.ddl", "cp/cp_analytics.csv");
  level.transactionid = 0;
  level.analyticsendgame = &zombieendgameanalytics;
  level.revive_success_analytics_func = &revive_success_analytics_func;

  value = "<dev string:x1c>";
  cmd = "<dev string:x48>" + value + "<dev string:xa7>";
  addentrytodevgui(cmd);
  value = "<dev string:xab>";
  cmd = "<dev string:xd9>" + value + "<dev string:xa7>";
  addentrytodevgui(cmd);
  cmd = "<dev string:x13c>";
  addentrytodevgui(cmd);
  cmd = "<dev string:x1b0>";
  addentrytodevgui(cmd);
  cmd = "<dev string:x21d>";
  addentrytodevgui(cmd);
  cmd = "<dev string:x284>";
  addentrytodevgui(cmd);
  cmd = "<dev string:x2fb>";
  addentrytodevgui(cmd);
  cmd = "<dev string:x376>";
  addentrytodevgui(cmd);
  cmd = "<dev string:x408>";
  addentrytodevgui(cmd);
  cmd = "<dev string:x492>";
  addentrytodevgui(cmd);
  cmd = "<dev string:x524>";
  addentrytodevgui(cmd);
  cmd = "<dev string:x599>";
  addentrytodevgui(cmd);
  cmd = "<dev string:x60c>";
  addentrytodevgui(cmd);
}

function dlog_analytics_init() {
  setdvarifuninitialized(@ "hash_c8944dc52325691f", 1);
  level.analyticslog = spawnStruct();
  level.analyticslog.nextplayerid = 0;
  level.analyticslog.nextobjectid = 0;
  level.analyticslog.nextdeathid = 0;

  if(!analyticsactive()) {
    return;
  }

  scripts\cp\utility\connect_event_aggregator::registeronconnectcallback(&watchforconnectedplayers);

  if(analyticslogenabled()) {
    thread logmatchtags();
    thread logallplayerposthink();
    thread logevent_minimapcorners();
  }
}

function init_weapon_and_player_analytics(player) {
  player endon("disconnect");

  while(!isDefined(player.pers)) {
    wait 1;
  }

  player function_87d1affa098ea2e4();
  player.timewithitem = [];
  player.killswithitem = [];
  player.itemtype = " ";
  player.timeitemlasted = [];

  if(!isDefined(level.brutefirstspawn)) {
    level.brutefirstspawn = 0;
  }

  if(level.wave_num == 0) {
    player.pers["timesPerWave"] = spawnStruct();
    player.pers["timesPerWave"].timesperwave = [];
    player.pers["timesPerWave"].timesperwave[level.wave_num + 1] = [];
    player.pers["timesPerWave"].timesperwave[level.wave_num + 1]["bowling_for_planets"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num + 1]["bowling_for_planets_afterlife"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num + 1]["coaster"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num + 1]["laughingclown"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num + 1]["laughingclown_afterlife"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num + 1]["basketball_game"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num + 1]["basketball_game_afterlife"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num + 1]["clown_tooth_game"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num + 1]["clown_tooth_game_afterlife"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num + 1]["game_race"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num + 1]["shooting_gallery"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num + 1]["shooting_gallery_afterlife"] = 0;
  }

  if(!isDefined(player.pers["timesPerWave"])) {
    player.pers["timesPerWave"] = spawnStruct();
    player.pers["timesPerWave"].timesperwave = [];
    player.pers["timesPerWave"].timesperwave[level.wave_num] = [];
    player.pers["timesPerWave"].timesperwave[level.wave_num]["bowling_for_planets"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num]["bowling_for_planets_afterlife"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num]["coaster"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num]["laughingclown"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num]["laughingclown_afterlife"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num]["basketball_game"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num]["basketball_game_afterlife"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num]["clown_tooth_game"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num]["clown_tooth_game_afterlife"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num]["game_race"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num]["shooting_gallery"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num]["shooting_gallery_afterlife"] = 0;
  } else if(!isDefined(player.pers["timesPerWave"].timesperwave[level.wave_num + 1])) {
    player.pers["timesPerWave"].timesperwave[level.wave_num + 1]["bowling_for_planets"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num + 1]["bowling_for_planets_afterlife"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num + 1]["coaster"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num + 1]["laughingclown"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num + 1]["laughingclown_afterlife"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num + 1]["basketball_game"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num + 1]["basketball_game_afterlife"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num + 1]["clown_tooth_game"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num + 1]["clown_tooth_game_afterlife"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num + 1]["game_race"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num + 1]["shooting_gallery"] = 0;
    player.pers["timesPerWave"].timesperwave[level.wave_num + 1]["shooting_gallery_afterlife"] = 0;
  }

  player.itemuses = [];
  player.itemkills = [];
  player.itemignored = " ";
  player.itemreplaced = " ";
  player.itempicked = " ";
  player.itemuses[player.itempicked] = 0;
  player.itemkills[player.itempicked] = 0;

  if(!isDefined(player.totalxpearned)) {
    player.totalxpearned = 0;
  }

  if(!isDefined(player.score_earned)) {
    player.score_earned = 0;
  }

  player.downsperweaponlog = [];
  player.killsperweaponlog = [];
  player.wavesheldwithweapon = [];
  player.shotsfiredwithweapon = [];
  player.shotsontargetwithweapon = [];
  player.headshots = [];
  player.total_match_headshots = 0;
  player.aggregateweaponkills = [];
  player.weapon_name_log = " ";
  player.accuracy_shots_fired = 0;
  player.accuracy_shots_on_target = 0;
  player.explosive_kills = 0;
  player.total_trap_kills = 0;

  if(!isDefined(player.exitingafterlifearcade)) {
    player.exitingafterlifearcade = 0;
  }

  player.meleekill = 0;
  player.kung_fu_vo = 0;

  if(!isDefined(player.trapkills)) {
    player.trapkills = [];
  }

  var_470cafd5fffdfb72 = ["trap_gator", "trap_dragon", "trap_gravitron", "trap_danceparty", "trap_rocket", "trap_spin"];

  foreach(trap in var_470cafd5fffdfb72) {
    if(!isDefined(player.trapkills[trap])) {
      player.trapkills[trap] = 0;
    }
  }

  weaplist = player.getweaponslist;

  if(isDefined(weaplist)) {
    foreach(weapon in weaplist) {
      player.weapon_name_log = scripts\cp\utility::getbaseweaponname(weapon);

      if(!isDefined(player.aggregateweaponkills[player.weapon_name_log])) {
        player.aggregateweaponkills[player.weapon_name_log] = 0;
      }
    }
  }
}

function revive_success_analytics_func(reviver) {
  scripts\cp\cp_analytics::log_event("revived_another_player", 1, [reviver.clientid], [reviver.clientid], [reviver.clientid]);
}

function zombieendgameanalytics() {
  var_470cafd5fffdfb72 = ["trap_gator", "trap_dragon", "trap_gravitron", "trap_danceparty", "trap_rocket", "trap_spin"];

  foreach(player_index, player in level.players) {
    log_weapons_data(player_index, player);
    log_headshots_data(player_index, player);
  }
}

function log_headshots_data(player_index, player) {
  foreach(weapon_name, value in player.headshots) {
    if(weapon_name == "none" || weapon_name == "" || value == 0 || !scripts\engine\utility::array_contains(level.loadout_weapons, weapon_name)) {
      continue;
    }

    setclientmatchdata("player", player_index, "headShots", scripts\cp\utility::getbaseweaponname(weapon_name), value);
    currentvalue_headshots = player getplayerdata("cp", "headShots", scripts\cp\utility::getbaseweaponname(weapon_name));
    player setplayerdata("cp", "headShots", scripts\cp\utility::getbaseweaponname(weapon_name), currentvalue_headshots + value);
  }

  setclientmatchdata("player", player_index, "total_headshots", player.total_match_headshots);
}

function log_card_data(player_index, player) {
  if(!isDefined(player.consumables)) {
    return;
  }

  if(level.gametype != "zombies") {
    return;
  }

  foreach(consumable_name, consumable_info in player.consumables) {
    var_455f02d4512d534d = player getplayerdata("cp", "cards_used", consumable_name);
    player setplayerdata("cp", "cards_used", consumable_name, var_455f02d4512d534d + consumable_info.times_used);
  }
}

function log_explosive_kills(player_index, player) {
  if(!isDefined(player.explosive_kills)) {
    return;
  }

  var_4e7dbb435b55a691 = player getplayerdata("cp", "explosive_kills");
  player setplayerdata("cp", "explosive_kills", var_4e7dbb435b55a691 + player.explosive_kills);
}

function log_weapons_data(player_index, player) {
  init_flag = 0;
  max_val = 0;
  var_159d315cfad2dd2a = "";

  foreach(weapon_name, value in player.aggregateweaponkills) {
    if(weapon_name == "none" || weapon_name == "" || value == 0 || !scripts\engine\utility::array_contains(level.loadout_weapons, weapon_name)) {
      continue;
    }

    setclientmatchdata("player", player_index, "killsPerWeapon", scripts\cp\utility::getbaseweaponname(weapon_name), value);
    currentvalue_kills = player getplayerdata("cp", "killsPerWeapon", scripts\cp\utility::getbaseweaponname(weapon_name));
    player setplayerdata("cp", "killsPerWeapon", scripts\cp\utility::getbaseweaponname(weapon_name), currentvalue_kills + value);

    if(player.aggregateweaponkills[weapon_name] > 0 && init_flag == 0) {
      max_val = player.aggregateweaponkills[weapon_name];
      init_flag = 1;
      var_159d315cfad2dd2a = scripts\cp\utility::getbaseweaponname(weapon_name);
    }

    if(player.aggregateweaponkills[weapon_name] > max_val) {
      max_val = player.aggregateweaponkills[weapon_name];
      var_159d315cfad2dd2a = scripts\cp\utility::getbaseweaponname(weapon_name);
    }
  }

  if(getdvarint(@ "hash_d4d459e25b712aa9") == 1) {
    print("<dev string:x67b>" + var_159d315cfad2dd2a + "<dev string:x68f>" + max_val);
  }
}

function start_game_type(var_fc271415b7b836fe, var_d17d417bb04fceb4, var_ade4259aada39885) {
  init(var_ade4259aada39885);
  init_matchdata(var_fc271415b7b836fe, var_d17d417bb04fceb4);
}

function init_matchdata(var_fc271415b7b836fe, var_d17d417bb04fceb4) {
  setclientmatchdatadef(var_d17d417bb04fceb4);

  if(getdvarint(@ "online_matchdata_enabled") != 0) {
    setmatchdatadef(var_fc271415b7b836fe);
    setmatchdata("commonMatchData", "map", level.script);
    setmatchdata("commonMatchData", "gametype", getDvar(@ "ui_gametype"));
    setmatchdata("commonMatchData", "build_version", getbuildversion());
    setmatchdata("commonMatchData", "build_number", getbuildnumber());
    setmatchdata("commonMatchData", "utc_start_time_s", getsystemtime());
    setmatchdata("commonMatchData", "is_private_match", getdvarint(@ "xblive_privatematch"));
    setmatchdata("commonMatchData", "is_ranked_match", 1);
  }

  level thread wait_set_initial_player_count();
}

function init(var_ade4259aada39885) {
  cp_matchdata = spawnStruct();
  single_value_stats = [];
  cp_matchdata.single_value_stats = single_value_stats;
  challenge_results = [];
  cp_matchdata.challenge_results = challenge_results;
  level.cp_matchdata = cp_matchdata;
  init_analytics(var_ade4259aada39885);
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

  if(!isDefined(level.player_count)) {
    level.player_count = 1;
    return;
  }

  level.player_count += 1;
}

function initsegmentstats() {
  level endon("game_ended");
  level thread recordplayersegmentdata();

  while(true) {
    level waittill("connected", player);
    createplayersegmentstats(player);
  }
}

function recordplayersegmentdata() {
  level endon("game_ended");
  gameflagwait("prematch_done");
  wait 4;

  while(true) {
    wait 1;

    foreach(player in level.players) {
      player thread updateplayersegmentdata();
    }
  }
}

function createplayersegmentstats(player) {
  player.segments = [];
  player.segments["distanceTotal"] = 0;
  player.segments["movingTotal"] = 0;
  player.segments["movementUpdateCount"] = 0;
  player.savedsegmentposition = player.origin;
  player.positionptm = player.origin;
}

function updateplayersegmentdata() {
  self endon("disconnect");

  if(!isDefined(self.savedsegmentposition)) {
    self.savedsegmentposition = self.origin;
    self.positionptm = self.origin;
  }

  if(isusingremote()) {
    self waittill("stopped_using_remote");
    self.savedsegmentposition = self.origin;
    self.positionptm = self.origin;
    return;
  }

  self.segments["movementUpdateCount"]++;
  self.segments["distanceTotal"] = self.segments["distanceTotal"] + distance2d(self.savedsegmentposition, self.origin);
  self.savedsegmentposition = self.origin;

  if(self.segments["movementUpdateCount"] % 5 == 0) {
    distancetraveled = distance2d(self.positionptm, self.origin);
    self.positionptm = self.origin;

    if(distancetraveled > 16) {
      self.segments["movingTotal"]++;
    }
  }
}

function on_player_disconnect(reason) {
  set_custom_stats();
  level.player_count_left += 1;
}

function player_init() {
  cp_matchdata = spawnStruct();
  single_value_stats = [];
  single_value_stats["cashSpentOnWeapon"] = get_single_value_struct(0, "int");
  single_value_stats["cashSpentOnAbility"] = get_single_value_struct(0, "int");
  single_value_stats["cashSpentOnTrap"] = get_single_value_struct(0, "int");
  cp_matchdata.single_value_stats = single_value_stats;
  laststand_record = [];
  laststand_record["timesDowned"] = [];
  laststand_record["timesRevived"] = [];
  laststand_record["timesBledOut"] = [];
  cp_matchdata.laststand_record = laststand_record;
  self.cp_matchdata = cp_matchdata;
}

function set_player_count() {
  if(!isDefined(level.max_concurrent_player_count)) {
    level.max_concurrent_player_count = 0;
  }

  if(level.players.size >= level.max_concurrent_player_count) {
    level.max_concurrent_player_count = level.players.size + 1;
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

function update_challenges_status(challenge_name, result) {
  if(level.cp_matchdata.challenge_results.size > 25) {
    return;
  }

  challenge_status = spawnStruct();
  challenge_status.challenge_name = challenge_name;
  challenge_status.result = result;
  level.cp_matchdata.challenge_results[level.cp_matchdata.challenge_results.size] = challenge_status;
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

function inc_laststand_record(field_name) {
  if(!isDefined(self.cp_matchdata.laststand_record[field_name][level.wave_num])) {
    self.cp_matchdata.laststand_record[field_name][level.wave_num] = 0;
  }

  self.cp_matchdata.laststand_record[field_name][level.wave_num]++;
}

function update_spending_type(amount_spent, spending_type) {
  switch (spending_type) {
    case #"hash_27124c6c97ccffa1":
      self.cp_matchdata.single_value_stats["cashSpentOnWeapon"].value = self.cp_matchdata.single_value_stats["cashSpentOnWeapon"].value + amount_spent;
      break;
    case #"hash_89e299c6dce6f571":
      self.cp_matchdata.single_value_stats["cashSpentOnAbility"].value = self.cp_matchdata.single_value_stats["cashSpentOnAbility"].value + amount_spent;
      break;
    case #"hash_82ea0e6e4f123b62":
      self.cp_matchdata.single_value_stats["cashSpentOnTrap"].value = self.cp_matchdata.single_value_stats["cashSpentOnTrap"].value + amount_spent;
      break;
    default:
      break;
  }
}

function endgame(end_condition, play_time) {
  set_game_data(end_condition, play_time);
  write_global_clientmatchdata();

  foreach(player in level.players) {
    scripts\cp\persistence::increment_player_career_total_waves(player);
    scripts\cp\persistence::increment_player_career_total_score(player);
    player set_player_data(play_time);
    player set_player_game_data();
    player write_clientmatchdata_for_player(player, player_index);
  }

  if(isDefined(level.analyticsendgame)) {
    [[level.analyticsendgame]]();
  }

  if(getdvarint(@ "online_matchdata_enabled") != 0) {
    sendmatchdata();
  }

  sendclientmatchdata();
}

function set_player_data(play_time) {
  totalgameplaytime = self getplayerdata("cp", "coopCareerStats", "totalGameplayTime");
  gamesplayed = self getplayerdata("cp", "coopCareerStats", "gamesPlayed");

  if(!isDefined(totalgameplaytime)) {
    totalgameplaytime = 0;
  }

  if(!isDefined(gamesplayed)) {
    gamesplayed = 0;
  }

  totalgameplaytime += play_time / 1000;
  gamesplayed += 1;
  self setplayerdata("cp", "coopCareerStats", "totalGameplayTime", int(totalgameplaytime));
  self setplayerdata("cp", "coopCareerStats", "gamesPlayed", int(gamesplayed));
}

function set_game_data(end_condition, play_time) {
  var_495308c746aac9c9 = "challengesCompleted";
  cp_matchdata = level.cp_matchdata;

  foreach(value_struct in cp_matchdata.single_value_stats) {
    value = validate_value(value_struct.value, value_struct.value_type);
  }

  foreach(challenge_status in cp_matchdata.challenge_results) {}

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

function get_player_matchdata(key, defaultvalue) {
  if(isDefined(level.matchdata["player"][self.clientid]) && isDefined(level.matchdata["player"][self.clientid][key])) {
    return level.matchdata["player"][self.clientid][key];
  }

  return defaultvalue;
}

function set_custom_stats() {
  totalgameplaytime = self getplayerdata("cp", "coopCareerStats", "totalGameplayTime");
  gamesplayed = self getplayerdata("cp", "coopCareerStats", "gamesPlayed");
  rank = self getplayerdata("cp", "progression", "playerLevel", "rank");
  prestige = self getplayerdata("cp", "progression", "playerLevel", "prestige");
}

function copy_from_playerdata() {}

function set_laststand_stats() {}

function set_single_value_stats() {}

function validate_value(value, data_type) {
  switch (data_type) {
    case #"hash_1f64c2f14ebaa7f":
      return validate_byte(value);
    case #"hash_1f528a3efce186b5":
      return validate_short(value);
    case #"hash_4730906c2f53f03e":
      return validate_int(value);
    default:
      assertmsg("Value type: " + data_type + " is not supported");
      break;
  }
}

function validate_byte(value) {
  return int(min(value, 127));
}

function validate_short(value) {
  return int(min(value, 32767));
}

function validate_int(value) {
  return int(min(value, 2147483647));
}

function get_single_value_struct(initial_value, value_type) {
  value_struct = spawnStruct();
  value_struct.value = initial_value;
  value_struct.value_type = value_type;
  return value_struct;
}

function init_analytics(var_ade4259aada39885) {
  var_27d6fc765db2ff56 = 0;
  var_11f6e8336fff0c54 = 1;
  var_f0837d977499367c = 2;
  var_fa39a68c06af79e5 = 1;
  var_44a02b844046e62e = 2;
  var_7d5ae35fc129722f = 3;
  var_1250c14634e12168 = 4;
  var_5dd78b3e67539236 = 5;
  var_d675b910eaa5d365 = 6;
  var_bd34919c89c9a587 = 1;
  var_c6e216027d6f67a = 100;
  var_ddc9474813519601 = 101;
  var_39e94edde1fd5ee2 = 300;
  level.blackbox_data_type = [];
  level.matchdata_struct = [];
  level.matchdata_data_type = [];
  level.matchdata = [];
  level.clientmatchdata_struct = [];
  level.clientmatchdata_data_type = [];
  level.clientmatchdata = [];

  for(i = var_ddc9474813519601; i <= var_39e94edde1fd5ee2; i++) {
    data_field = tablelookup(var_ade4259aada39885, var_27d6fc765db2ff56, i, var_fa39a68c06af79e5);

    if(data_field == "") {
      continue;
    }

    blackbox_data_type = tablelookup(var_ade4259aada39885, var_27d6fc765db2ff56, i, var_44a02b844046e62e);

    if(blackbox_data_type != "") {
      level.blackbox_data_type[data_field] = blackbox_data_type;
    }

    matchdata_data_type = tablelookup(var_ade4259aada39885, var_27d6fc765db2ff56, i, var_7d5ae35fc129722f);

    if(matchdata_data_type != "") {
      level.matchdata_data_type[data_field] = matchdata_data_type;
    }

    is_matchdata_struct = tablelookup(var_ade4259aada39885, var_27d6fc765db2ff56, i, var_1250c14634e12168);

    if(is_matchdata_struct != "") {
      level.matchdata_struct[data_field] = [];
      level.matchdata[data_field] = [];
    }

    clientmatchdata_data_type = tablelookup(var_ade4259aada39885, var_27d6fc765db2ff56, i, var_5dd78b3e67539236);

    if(clientmatchdata_data_type != "") {
      level.clientmatchdata_data_type[data_field] = clientmatchdata_data_type;
    }

    is_clientmatchdata_struct = tablelookup(var_ade4259aada39885, var_27d6fc765db2ff56, i, var_d675b910eaa5d365);

    if(is_clientmatchdata_struct != "") {
      level.clientmatchdata_struct[data_field] = [];
      level.clientmatchdata[data_field] = [];
    }
  }

  level.analytics_event = [];

  for(i = var_bd34919c89c9a587; i <= var_c6e216027d6f67a; i++) {
    event_id = tablelookup(var_ade4259aada39885, var_27d6fc765db2ff56, i, var_11f6e8336fff0c54);

    if(event_id == "") {
      break;
    }

    data_to_update = tablelookup(var_ade4259aada39885, var_27d6fc765db2ff56, i, var_f0837d977499367c);
    level.analytics_event[event_id] = data_to_update;
    var_32b571d0f07e43b = strtok(data_to_update, " ");

    foreach(data in var_32b571d0f07e43b) {
      if(isDefined(level.matchdata_struct[data])) {
        level.matchdata_struct[data][event_id] = 0;
      }

      if(isDefined(level.clientmatchdata_struct[data]) && isDefined(level.clientmatchdata_data_type[event_id])) {
        level.clientmatchdata_struct[data][event_id] = 0;
      }
    }
  }
}

function log_event(var_bffee57e43ba8941, increment_value, var_a4784fda62821ea9, var_492753c65f46c8f0, var_8bd7ffff59d706a9) {
  var_32b571d0f07e43b = get_data_to_update(var_bffee57e43ba8941);
  assertex(var_32b571d0f07e43b.size == var_a4784fda62821ea9.size, "<dev string:x698>");
  log_clientmatchdata(var_bffee57e43ba8941, var_32b571d0f07e43b, increment_value, var_8bd7ffff59d706a9);
}

function log_clientmatchdata(var_bffee57e43ba8941, var_32b571d0f07e43b, increment_value, var_8bd7ffff59d706a9) {
  if(!isDefined(var_8bd7ffff59d706a9)) {
    return;
  }

  var_669dc59993040270 = 0;

  if(is_clientmatchdata_data(var_bffee57e43ba8941)) {
    foreach(data_to_update in var_32b571d0f07e43b) {
      if(is_clientmatchdata_struct(data_to_update)) {
        var_e8c1c016b74f5143 = var_8bd7ffff59d706a9[var_669dc59993040270];

        if(!isDefined(level.clientmatchdata[data_to_update][var_e8c1c016b74f5143])) {
          level.clientmatchdata[data_to_update][var_e8c1c016b74f5143] = level.clientmatchdata_struct[data_to_update];
        }

        level.clientmatchdata[data_to_update][var_e8c1c016b74f5143][var_bffee57e43ba8941] += increment_value;
        var_669dc59993040270++;
      }
    }
  }
}

function get_bb_string(var_32b571d0f07e43b) {
  result = "";

  foreach(data_to_update in var_32b571d0f07e43b) {
    assertex(isDefined(level.blackbox_data_type[data_to_update]), "<dev string:x6e0>" + data_to_update + "<dev string:x6f8>");
    result += data_to_update + " " + level.blackbox_data_type[data_to_update];

    if(index != var_32b571d0f07e43b.size - 1) {
      result += " ";
    }
  }

  return result;
}

function get_data_to_update(var_bffee57e43ba8941) {
  assertex(isDefined(level.analytics_event[var_bffee57e43ba8941]), "<dev string:x71d>" + var_bffee57e43ba8941 + "<dev string:x73a>");
  var_32b571d0f07e43b = level.analytics_event[var_bffee57e43ba8941];
  return strtok(var_32b571d0f07e43b, " ");
}

function log_matchdata(var_bffee57e43ba8941, var_32b571d0f07e43b, increment_value, var_492753c65f46c8f0) {
  var_84b743f5c1698eb1 = 0;

  foreach(data_to_update in var_32b571d0f07e43b) {
    if(is_matchdata_struct(data_to_update)) {
      var_967bfc156d27c086 = var_492753c65f46c8f0[var_84b743f5c1698eb1];

      if(!isDefined(level.matchdata[data_to_update][var_967bfc156d27c086])) {
        level.matchdata[data_to_update][var_967bfc156d27c086] = level.matchdata_struct[data_to_update];
      }

      level.matchdata[data_to_update][var_967bfc156d27c086][var_bffee57e43ba8941] += increment_value;
      var_84b743f5c1698eb1++;
    }
  }
}

function is_matchdata_struct(data_to_update) {
  return isDefined(level.matchdata_struct[data_to_update]);
}

function is_clientmatchdata_struct(data_to_update) {
  return isDefined(level.clientmatchdata_struct[data_to_update]);
}

function is_clientmatchdata_data(data_to_update) {
  return isDefined(level.clientmatchdata_data_type[data_to_update]);
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
  }
}

function write_clientmatchdata_for_player(player, player_index) {
  setclientmatchdata("player", player_index, "username", player.name);
  kill_count = player getplayerdata("cp", "alienSession", "kills");
  last_stand_count = player getplayerdata("cp", "alienSession", "downed");
  revive_count = player getplayerdata("cp", "alienSession", "revives");
  xuidhigh = player getxuidhigh();
  xuidlow = player getxuidlow();

  println("<dev string:x75e>");
  println("<dev string:x775>" + player.name);
  println("<dev string:x78f>" + kill_count);
  println("<dev string:x7ab>" + last_stand_count);
  println("<dev string:x7cd>" + revive_count);
  println("<dev string:x7eb>" + xuidhigh);
  println("<dev string:x805>" + xuidlow);
  println("<dev string:x81e>" + player_index);

  if(!scripts\cp\utility::is_specops_gametype()) {
    if(scripts\cp\utility::matchmakinggame()) {
      setclientmatchdata("player", player_index, "rank", player getrank());
    } else {
      setclientmatchdata("player", player_index, "rank", player scripts\cp\persistence::get_player_rank());
    }
  }

  if(!isDefined(player.player_character_index)) {
    return;
  }

  setclientmatchdata("player", player_index, "characterIndex", player.player_character_index);
  var_cd668d6d59feaf21 = level.clientmatchdata["player"][player.clientid];

  if(isDefined(var_cd668d6d59feaf21)) {
    foreach(data_value in var_cd668d6d59feaf21) {
      setclientmatchdata("player", player_index, data, int(data_value));
    }
  }

  if(isDefined(level.endgame_write_clientmatchdata_for_player_func)) {
    [[level.endgame_write_clientmatchdata_for_player_func]](player, player_index);
  }
}

function function_b601c4de74259114(var_bffee57e43ba8941, bb_string) {
  if(getDvar(@ "hash_478f8b9d56797e26", "<dev string:x83c>") != "<dev string:x83c>") {
    println("<dev string:x83d>");
    println("<dev string:x857>" + var_bffee57e43ba8941);
    println("<dev string:x869>" + bb_string);
    println("<dev string:x87b>");
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
  return getdvarint(@ "hash_c8944dc52325691f");
}

function getuniqueobjectid() {
  id = level.analyticslog.nextobjectid;
  level.analyticslog.nextobjectid++;
  return id;
}

function cacheplayeraction(actionbit) {
  if(!isDefined(self.analyticslog.cachedactions)) {
    self.analyticslog.cachedactions = 0;
  }

  self.analyticslog.cachedactions |= actionbit;
}

function watchforconnectedplayers() {
  if(!analyticsactive()) {
    return;
  }

  logevent_playerconnected();
  thread watchforbasicplayerevents();
  thread watchforplayermovementevents();
  thread watchforusermessageevents();
}

function watchforbasicplayerevents() {
  self endon("disconnect");

  if(!analyticslogenabled()) {
    return;
  }

  while(true) {
    notifyvalue = waittill_any_return_no_endon_death_5("adjustedStance", "jumped", "weapon_fired", "reload_start", "spawned_player");

    if(notifyvalue == "adjustedStance") {
      checkstancestatus();
      continue;
    }

    if(notifyvalue == "jumped") {
      cacheplayeraction(4);
      continue;
    }

    if(notifyvalue == "weapon_fired") {
      cacheplayeraction(8);
      continue;
    }

    if(notifyvalue == "reload_start") {
      cacheplayeraction(16);
      continue;
    }

    if(notifyvalue == "spawned_player") {
      thread logevent_playerspawn();
    }
  }
}

function watchforplayermovementevents() {
  self endon("disconnect");

  if(!analyticslogenabled()) {
    return;
  }

  while(true) {
    notifyvalue = waittill_any_return_no_endon_death_3("doubleJumpBegin", "doubleJumpEnd", "sprint_slide_begin");

    if(notifyvalue == "doubleJumpBegin") {
      cacheplayeraction(64);
      continue;
    }

    if(notifyvalue == "doubleJumpEnd") {
      cacheplayeraction(128);
      continue;
    }

    if(notifyvalue == "sprint_slide_begin") {
      cacheplayeraction(256);
    }
  }
}

function watchforusermessageevents() {
  self endon("disconnect");

  if(isai(self)) {
    return;
  }

  if(getdvarint(@ "hash_ff689af941dd10a1", 0) == 0) {
    return;
  }

  self notifyonplayercommand("log_user_event_start", "+actionslot 3");
  self notifyonplayercommand("log_user_event_end", "-actionslot 3");
  self notifyonplayercommand("log_user_event_generic_event", "+gostand");

  while(true) {
    self waittill("log_user_event_start");
    notification = waittill_any_return_2("log_user_event_end", "log_user_event_generic_event");

    if(isDefined(notification) && notification == "log_user_event_generic_event") {
      logevent_message(self.name, self.origin, "Generic User Event");
    }
  }
}

function checkstancestatus() {
  stance = self getstance();

  if(stance == "prone") {
    cacheplayeraction(1);
    return;
  }

  if(stance == "crouch") {
    cacheplayeraction(2);
  }
}

function logallplayerposthink() {
  if(!analyticslogenabled()) {
    return;
  }

  while(true) {
    timestart = gettime();
    players = level.players;

    foreach(player in players) {
      if(!shouldplayerlogevents(player)) {
        continue;
      }

      if(isDefined(player) && scripts\cp\utility\player::isreallyalive(player)) {
        player logevent_path();
        player logevent_scoreupdate();
        waitframe();
      }
    }

    wait max(0.05, 1.5 - (gettime() - timestart) / 1000);
  }
}

function recordbreadcrumbdata() {
  level endon("game_ended");

  if(getDvar(@ "hash_35bfb8187f185ae7") == "0") {
    return;
  }

  if(scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    var_2fe6a798e49f4de6 = getdvarfloat(@ "hash_7c8bee10dba43fe7", 4);
  } else {
    var_2fe6a798e49f4de6 = getdvarfloat(@ "hash_246c8305339e703e", 2);
  }

  scripts\mp\flags::gameflagwait("prematch_done");

  while(true) {
    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }

      var_de1e71241aae57ed = scripts\cp\utility\player::isreallyalive(player) && !isai(player);
      var_d4ce6b875d4f5cf8 = isDefined(player.pers["telemetry"]) && isDefined(player.pers["telemetry"].life) && isDefined(player.pers["telemetry"].life.life_index) && namespace_de6e6777b0937bd7::function_892570944f6b6a2(player);
      var_7b3a43a2c9353902 = isDefined(player.team) && player.team != "spectator" && player.sessionstate == "playing" && player.sessionstate != "dead";

      if(var_de1e71241aae57ed && var_d4ce6b875d4f5cf8 && var_7b3a43a2c9353902) {
        isads = player isplayerads();
        msfrommatchstart = namespace_de6e6777b0937bd7::function_1b15450e092933cf(gettime());
        player recordbreadcrumbdataforplayer(msfrommatchstart, player.pers["telemetry"].life.life_index, isads);
      }
    }

    wait var_2fe6a798e49f4de6;
  }
}

function getpathactionvalue() {
  actions = ter_op(isDefined(self.analyticslog.cachedactions), self.analyticslog.cachedactions, 0);

  if(self iswallrunning()) {
    actions |= 32;
  }

  return actions;
}

function clearpathactionvalue() {
  self.analyticslog.cachedactions = 0;
  checkstancestatus();
}

function buildkilldeathactionvalue() {
  actionvalue = 0;
  stance = self getstance();

  if(stance == "prone") {
    actionvalue |= 1;
  } else if(stance == "crouch") {
    actionvalue |= 2;
  }

  if(self isjumping()) {
    actionvalue |= 4;
  }

  if(isDefined(self.lastshotfiredtime) && gettime() - self.lastshotfiredtime < 500) {
    actionvalue |= 8;
  }

  if(self isreloading()) {
    actionvalue |= 16;
  }

  return actionvalue;
}

function buildloadoutstring() {
  loadoutstring = "equipmentPrimary =" + self.equipment["primary"] + ";" + "equipmentSecondary =" + self.equipment["secondary"] + ";" + "weaponPrimary=" + self.primaryweaponobj.basename + ";" + "weaponSecondary=" + self.secondaryweaponobj.basename + ";";
  return loadoutstring;
}

function buildspawnpointstatestring(spawnpoint) {
  output = "";

  if(isDefined(spawnpoint.lastbucket)) {
    if(isDefined(spawnpoint.lastbucket["allies"])) {
      output += "alliesBucket=" + spawnpoint.lastbucket["allies"] + ";";
    }

    if(isDefined(spawnpoint.lastbucket["axis"])) {
      output += "axisBucket=" + spawnpoint.lastbucket["axis"] + ";";
    }
  }

  return output;
}

function logevent_path() {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  var_53f4b69ae494195a = anglesToForward(self getplayerangles());
  dlog_recordevent("gamecp_" + "path", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", var_53f4b69ae494195a[0], "gun_orienty", var_53f4b69ae494195a[1], "gun_orientz", var_53f4b69ae494195a[2], "action", getpathactionvalue(), "health", getsantizedhealth()]);
  clearpathactionvalue();
}

function logevent_playerspawn() {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  var_c6c41b96b7c2ef2a = isDefined(self.lastspawnpoint) && isDefined(self.lastspawnpoint.buddyspawn) && self.lastspawnpoint.buddyspawn;
  playerforward = anglesToForward(self.angles);
  dlog_recordevent("gamecp_" + "spawn_in", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "orientx", playerforward[0], "orienty", playerforward[1], "orientz", playerforward[2], "loadout", buildloadoutstring(), "type", ter_op(var_c6c41b96b7c2ef2a, "Buddy", "Normal"), "team", self.team]);
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

  super = undefined;

  if(isDefined(self.changedarchetypeinfo)) {
    super = self.changedarchetypeinfo.super;
  } else {
    super = self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypeSuper");
  }

  xuid = self getxuid();
  dlog_recordevent("gamecp_" + "player_connect", ["playerid", self.analyticslog.playerid, "player_name", self.name, "player_xuid", xuid, "player_super_name", super]);
}

function logevent_playerdeath(attacker, meansofdeath, weaponname) {
  if(!shouldplayerlogevents(self) || !isPlayer(self)) {
    return;
  }

  var_53f4b69ae494195a = anglesToForward(self getplayerangles());
  var_77295bbd7b1b8155 = -1;
  attackerposx = 0;
  attackerposy = 0;
  attackerposz = 0;
  var_40cfb0f1536d4858 = 0;
  var_40cfb1f1536d4a8b = 0;
  var_40cfb2f1536d4cbe = 0;
  attackerteam = "s";
  attackerlifeid = 0;

  if(isDefined(attacker) && isPlayer(attacker)) {
    var_77295bbd7b1b8155 = attacker.analyticslog.playerid;

    if(isDefined(attacker.team)) {
      if(attacker.team == "axis") {
        attackerteam = "a";
      } else {
        attackerteam = "l";
      }
    }

    if(isDefined(attacker.origin)) {
      attackerposx = attacker.origin[0];
      attackerposy = attacker.origin[1];
      attackerposz = attacker.origin[2];
    }

    if(isDefined(attacker.lifeid)) {
      attackerlifeid = attacker.lifeid;
    }

    var_fde6939445aae30 = anglesToForward(attacker getplayerangles());

    if(isDefined(var_fde6939445aae30)) {
      var_40cfb0f1536d4858 = var_fde6939445aae30[0];
      var_40cfb1f1536d4a8b = var_fde6939445aae30[1];
      var_40cfb2f1536d4cbe = var_fde6939445aae30[2];
    }
  }

  deathid = level.analyticslog.nextdeathid;
  level.analyticslog.nextdeathid++;
  weaponname = ter_op(isDefined(weaponname), weaponname, "None");
  victimteam = "s";

  if(self.team == "axis") {
    victimteam = "a";
  } else {
    victimteam = "l";
  }

  dlog_recordevent(134 + "death", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", var_53f4b69ae494195a[0], "gun_orienty", var_53f4b69ae494195a[1], "gun_orientz", var_53f4b69ae494195a[2], "weapon", weaponname, "mean_of_death", ter_op(isDefined(meansofdeath), meansofdeath, "None"), "attackerid", var_77295bbd7b1b8155, "action", buildkilldeathactionvalue(), "server_death_id", deathid, "victim_life_index", self.lifeid, "attacker_life_index", attackerlifeid, "victim_team", victimteam, "attacker_team", attackerteam, "attacker_pos_x", attackerposx, "attacker_pos_y", attackerposy, "attacker_pos_z", attackerposz, "attacker_gun_orientx", var_40cfb0f1536d4858, "attacker_gun_orienty", var_40cfb1f1536d4a8b, "attacker_gun_orientz", var_40cfb2f1536d4cbe, "victim_weapon", self.primaryweapon]);

  if(isDefined(meansofdeath) && isexplosivedamagemod(meansofdeath)) {
    logevent_explosion(ter_op(isDefined(weaponname), weaponname, "generic"), self.origin, attacker, 1);
  }

  if(isDefined(self.attackers)) {
    foreach(assister in self.attackers) {
      if(isDefined(assister) && isPlayer(assister) && assister != attacker) {
        logevent_assist(assister.analyticslog.playerid, deathid, weaponname);
      }
    }
  }
}

function logevent_playerkill(victim, meansofdeath, weaponname) {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  var_53f4b69ae494195a = anglesToForward(self getplayerangles());
  dlog_recordevent("gamecp_" + "kill", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", var_53f4b69ae494195a[0], "gun_orienty", var_53f4b69ae494195a[1], "gun_orientz", var_53f4b69ae494195a[2], "weapon", ter_op(isDefined(weaponname), weaponname, "None"), "mean_of_kill", ter_op(isDefined(meansofdeath), meansofdeath, "None"), "victimid", ter_op(isDefined(victim) && isPlayer(victim), victim.analyticslog.playerid, "-1"), "action", buildkilldeathactionvalue(), "attacker_health", getsantizedhealth(), "victim_pixel_count", 0]);
}

function logevent_explosion(type, center, var_e83217ed09c27313, duration, direction) {
  if(!analyticslogenabled()) {
    return;
  }

  if(!isDefined(direction)) {
    direction = (1, 0, 0);
  }

  dlog_recordevent("gamecp_" + "explosion", ["playerid", var_e83217ed09c27313.analyticslog.playerid, "x", center[0], "y", center[1], "z", center[2], "orientx", direction[0], "orienty", direction[1], "orientz", direction[2], "duration", duration, "type", type]);
}

function logevent_frontlineupdate(startpos, endpos, alliescenter, axiscenter, ison) {
  if(!analyticslogenabled()) {
    return;
  }

  dlog_recordevent("gamecp_" + "front_line", ["startx", startpos[0], "starty", startpos[1], "endx", endpos[0], "endy", endpos[1], "axis_centerx", axiscenter[0], "axis_centery", axiscenter[1], "allies_centerx", alliescenter[0], "allies_centery", alliescenter[1], "state", ison]);
}

function logevent_gameobject(type, uniqueid, pos, ownerid, state) {
  if(!analyticslogenabled()) {
    return;
  }

  dlog_recordevent("gamecp_" + "object", ["uniqueid", uniqueid, "x", pos[0], "y", pos[1], "z", pos[2], "ownerid", ownerid, "type", type, "state", state]);
}

function logevent_message(ownerid, pos, message) {
  if(!analyticslogenabled()) {
    return;
  }

  dlog_recordevent("gamecp_" + "message", ["ownerid", ownerid, "x", pos[0], "y", pos[1], "z", pos[2], "message", message]);
}

function logevent_tag(message) {
  if(!analyticslogenabled()) {
    return;
  }

  bbprint("gamecp_" + "matchtags", "message %s", message);
}

function logevent_powerused(powername, state) {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  playerforward = anglesToForward(self.angles);
  dlog_recordevent("gamecp_" + "power", ["ownerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "orientx", playerforward[0], "orienty", playerforward[1], "orientz", playerforward[2], "type", powername, "state", state]);
}

function logevent_scoreupdate() {
  if(!shouldplayerlogevents(self)) {
    return;
  }

  playerforward = anglesToForward(self.angles);
  dlog_recordevent("gamecp_" + "scoreboard", ["ownerid", self.analyticslog.playerid, "score", self.score]);
}

function logevent_minimapcorners() {
  if(!analyticslogenabled()) {
    return;
  }

  corners = getEntArray("minimap_corner", "targetname");

  if(!isDefined(corners) || corners.size != 2) {
    return;
  }

  dlog_recordevent("gamecp_" + "map", ["cornera_x", corners[0].origin[0], "cornera_y", corners[0].origin[1], "cornerb_x", corners[1].origin[0], "cornerb_y", corners[1].origin[1], "north", getnorthyaw()]);
}

function logevent_assist(playerid, deathid, weapon) {
  if(!analyticslogenabled()) {
    return;
  }

  dlog_recordevent("gamecp_" + "assists", ["playerid", playerid, "server_death_id", deathid, "weapon", weapon]);
}

function getsantizedhealth() {
  return int(clamp(self.health, 0, 100000));
}

function shouldplayerlogevents(player) {
  if(!analyticslogenabled()) {
    return false;
  }

  if(!isPlayer(player) || !isDefined(player.team) || player.team == "spectator" || player.sessionstate != "playing" && player.sessionstate != "dead") {
    return false;
  }

  return true;
}

function logmatchtags() {
  dvartag = getDvar(@ "scr_analytics_tag", "");

  if(dvartag != "") {
    logevent_tag(dvartag);
  }

  if(matchmakinggame()) {
    logevent_tag("OnlineMatch");
    return;
  }

  if(getdvarint(@ "xblive_privatematch")) {
    logevent_tag("PrivateMatch");
    return;
  }

  if(!getdvarint(@ "onlinegame")) {
    logevent_tag("OfflineMatch");
  }
}

function logevent_superended(super_name, time_to_use, num_hits, num_kills) {
  if(!analyticslogenabled()) {
    return;
  }

  player_id = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    player_id = self.analyticslog.playerid;
  }

  dlog_recordevent("analytics_mp_supers", ["super_name", super_name, "time_to_use", time_to_use, "num_hits", num_hits, "num_kills", num_kills, "player_id", player_id]);
}

function logevent_superearned(match_time) {
  if(!analyticslogenabled()) {
    return;
  }

  player_id = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    player_id = self.analyticslog.playerid;
  }

  dlog_recordevent("analytics_mp_super_earned", ["match_time", match_time, "player_id", player_id]);
}

function logevent_awardgained(award_message) {
  if(!analyticslogenabled()) {
    return;
  }

  dlog_recordevent("analytics_mp_awards", ["award_message", award_message]);
}

function logevent_giveplayerxp(current_prestige, current_level, xp_gained, source) {
  if(!analyticslogenabled()) {
    return;
  }

  player_id = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    player_id = self.analyticslog.playerid;
  }

  dlog_recordevent("analytics_mp_player_xp", ["current_prestige", current_prestige, "current_level", current_level, "xp_gained", xp_gained, "xp_source", source, "player_id", player_id]);
}

function logevent_givecpweaponxp(objweapon, current_prestige, current_level, xp_gained, source) {
  if(!analyticslogenabled()) {
    return;
  }

  player_id = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid)) {
    player_id = self.analyticslog.playerid;
  }

  weapon_name = getcompleteweaponname(objweapon);
  dlog_recordevent("analytics_mp_weapon_xp", ["weapon", weapon_name, "current_prestige", current_prestige, "current_level", current_level, "xp_gained", xp_gained, "xp_source", source, "player_id", player_id]);
}

function logevent_sendplayerindexdata() {
  if(!analyticslogenabled()) {
    return;
  }

  var_d6228dada168a8a6 = [];
  var_7866d1bb4718ac7 = [];
  playercount = 0;

  for(playercount = 0; playercount < 12; playercount++) {
    var_d6228dada168a8a6[playercount] = 0;
    var_7866d1bb4718ac7[playercount] = "";
  }

  playercount = 0;

  foreach(player in level.players) {
    if(!isai(player)) {
      var_d6228dada168a8a6[playercount] = player.analyticslog.playerid;
      var_7866d1bb4718ac7[playercount] = player getxuid();
    }

    playercount += 1;
  }

  dlog_recordevent("analytics_match_player_index_init", ["player1_index", var_d6228dada168a8a6[0], "player1_xuid", var_7866d1bb4718ac7[0], "player2_index", var_d6228dada168a8a6[1], "player2_xuid", var_7866d1bb4718ac7[1], "player3_index", var_d6228dada168a8a6[2], "player3_xuid", var_7866d1bb4718ac7[2], "player4_index", var_d6228dada168a8a6[3], "player4_xuid", var_7866d1bb4718ac7[3], "player5_index", var_d6228dada168a8a6[4], "player5_xuid", var_7866d1bb4718ac7[4], "player6_index", var_d6228dada168a8a6[5], "player6_xuid", var_7866d1bb4718ac7[5], "player7_index", var_d6228dada168a8a6[6], "player7_xuid", var_7866d1bb4718ac7[6], "player8_index", var_d6228dada168a8a6[7], "player8_xuid", var_7866d1bb4718ac7[7], "player9_index", var_d6228dada168a8a6[8], "player9_xuid", var_7866d1bb4718ac7[8], "player10_index", var_d6228dada168a8a6[9], "player10_xuid", var_7866d1bb4718ac7[9], "player11_index", var_d6228dada168a8a6[10], "player11_xuid", var_7866d1bb4718ac7[10], "player12_index", var_d6228dada168a8a6[11], "player12_xuid", var_7866d1bb4718ac7[11]]);
}

function analyticsspawnlogenabled() {
  return getdvarint(@ "hash_906c263c7e34d59f");
}

function logevent_xpearned(player, playerxp, weaponname, weaponxp, source) {
  if(!isPlayer(player)) {
    return;
  }

  if(isxhash(source)) {
    source = function_f28fd66285fa2c9(source);
  }

  current_beat = player function_32900c5a73179b4();
  active_objective = level.active_objectives_string;
  player dlog_recordplayerevent("dlog_event_cpdata_plr_xp_earned", ["levelname", level.script, "player_xp_earned", playerxp, "weapon", weaponname, "weapon_xp_earned", weaponxp, "xp_source", source, "player_kit", player function_4bf5c934fad2bc96(), "current_beat", current_beat, "active_objective", active_objective]);
}

function logevent_munitionused(player, var_5a8f1accec64dc4a) {
  if(!isPlayer(player)) {
    return;
  }

  current_beat = player function_32900c5a73179b4();
  [x1, y1, z1] = player function_72d38b83fc04ee8e();
  active_objective = level.active_objectives_string;
  player dlog_recordplayerevent("dlog_event_cpdata_plr_munition_used", ["levelname", level.script, "playername", player.name, "x1", x1, "y1", y1, "z1", z1, "munition", var_5a8f1accec64dc4a, "player_kit", player function_4bf5c934fad2bc96(), "current_beat", current_beat, "active_objective", active_objective]);
}

function logevent_superused(player, super_name) {
  if(!isPlayer(player)) {
    return;
  }

  levelname = level.script;
  playername = player.name;
  [x1, y1, z1] = player function_72d38b83fc04ee8e();
  active_objective = level.active_objectives_string;
  player_kit = player function_4bf5c934fad2bc96();
  current_beat = player function_32900c5a73179b4();
  player dlog_recordplayerevent("dlog_event_cpdata_plr_super_used", ["levelname", levelname, "playername", playername, "x1", x1, "y1", y1, "z1", z1, "player_kit", player_kit, "super", super_name, "current_beat", current_beat, "active_objective", active_objective]);
}

function logevent_kidnapevent(player, var_856629b6525c0882) {
  if(!isPlayer(player)) {
    return;
  }

  player dlog_recordplayerevent("dlog_event_cpdata_plr_kidnapper", ["levelname", level.script, "version", var_856629b6525c0882, "times_kidnapped", player.times_kidnapped, "active_objective", level.active_objectives_string, "player_kit", player function_4bf5c934fad2bc96()]);
}

function logevent_spawnviateamrevive(player) {
  if(!isPlayer(player)) {
    return;
  }

  current_beat = player function_32900c5a73179b4();
  player dlog_recordplayerevent("dlog_event_cpdata_plr_spawn_via_teamrevive", ["levelname", level.script, "last_stand_id", get_last_stand_id(player), "current_beat", current_beat, "sharedaccount_uid", player function_512417bddbe63792(), "player_kit", player function_4bf5c934fad2bc96()]);
}

function logevent_spawnviaautorevive(player) {
  if(!isPlayer(player)) {
    return;
  }

  current_beat = player function_32900c5a73179b4();
  [x1, y1, z1] = player function_72d38b83fc04ee8e();
  active_objective = level.active_objectives_string;
  player dlog_recordplayerevent("dlog_event_cpdata_plr_spawn_via_autorevive", ["levelname", level.script, "last_stand_id", get_last_stand_id(player), "revivee", player.name, "x1", x1, "y1", y1, "z1", z1, "player_kit", player function_4bf5c934fad2bc96(), "sharedaccount_uid", player function_512417bddbe63792(), "current_beat", current_beat, "active_objective", active_objective]);
}

function logevent_spawnviaplayer(player, reviver) {
  if(!isPlayer(player)) {
    return;
  }

  current_beat = player function_32900c5a73179b4();
  [x1, y1, z1] = player function_72d38b83fc04ee8e();
  active_objective = level.active_objectives_string;
  player dlog_recordplayerevent("dlog_event_cpdata_plr_spawn_via_player", ["levelname", level.script, "last_stand_id", get_last_stand_id(player), "revivee", player.name, "reviver", reviver.name, "x1", x1, "y1", y1, "z1", z1, "player_kit", player function_4bf5c934fad2bc96(), "sharedaccount_uid", player function_512417bddbe63792(), "current_beat", current_beat, "active_objective", active_objective]);
}

function logevent_kill(eattacker, enemy, sweapon) {
  if(!isPlayer(eattacker)) {
    return;
  }

  victim_name = ter_op(isPlayer(enemy), enemy.name, enemy.agent_type);
  attacker_name = ter_op(isPlayer(eattacker), eattacker.name, eattacker.agent_type);
  current_beat = eattacker function_32900c5a73179b4(eattacker, enemy, sweapon);
  [x1, y1, z1] = eattacker function_72d38b83fc04ee8e();
  [x2, y2, z2] = enemy function_72d38b83fc04ee8e();
  active_objective = level.active_objectives_string;
  eattacker dlog_recordplayerevent("dlog_event_cpdata_plr_combat", ["levelname", level.script, "stat_type", "Killed", "attacker", attacker_name, "x1", x1, "y1", y1, "z1", z1, "enemy", victim_name, "x2", x2, "y2", y2, "z2", z2, "weapon", sweapon.basename, "player_kit", eattacker function_4bf5c934fad2bc96(), "sharedaccount_uid", eattacker function_512417bddbe63792(), "current_beat", current_beat, "active_objective", active_objective]);
}

function function_32900c5a73179b4(eattacker, enemy, sweapon) {
  var_b7bc529921e4ad54 = "";

  if(isDefined(level.var_f42102b6de7ce00d)) {
    var_b7bc529921e4ad54 = self[[level.var_f42102b6de7ce00d]](eattacker, enemy, sweapon);
  } else {
    beat = function_6721512a3aff2e3b();

    if(isDefined(beat)) {
      var_b7bc529921e4ad54 = beat;
    }
  }

  if(isDefined(level.var_92d27fad7a27f6dc)) {
    var_b7bc529921e4ad54 = level.var_92d27fad7a27f6dc;
  }

  if(getdvarint(@ "hash_5f89724cdfffd896") && var_b7bc529921e4ad54 != "<dev string:x83c>") {
    iprintlnbold("<dev string:x895>" + var_b7bc529921e4ad54);
  }

  return var_b7bc529921e4ad54;
}

function function_87d1affa098ea2e4() {
  if(getdvarint(@ "hash_e6d511d33e0fe486")) {
    shared_id = function_512417bddbe63792();
    function_b200f33418465746(shared_id + 1);
  }
}

function function_512417bddbe63792() {
  return self getplayerdata("cp", "sharedAccountID");
}

function function_b200f33418465746(value) {
  return self setplayerdata("cp", "sharedAccountID", value);
}

function logevent_downed(player, enemy) {
  if(!isPlayer(player)) {
    return;
  }

  update_last_stand_id(player);
  enemy_type = ter_op(isagent(enemy), enemy.agent_type, player.name);
  playername = player.name;
  current_beat = player function_32900c5a73179b4();
  sharedaccount_uid = player function_512417bddbe63792();
  player_kit = function_4bf5c934fad2bc96();
  [x1, y1, z1] = player function_72d38b83fc04ee8e();
  last_stand_id = get_last_stand_id(player);
  active_objective = level.active_objectives_string;
  player dlog_recordplayerevent("dlog_event_cpdata_plr_downed", ["levelname", level.script, "playername", playername, "enemy", enemy_type, "last_stand_id", last_stand_id, "x1", x1, "y1", y1, "z1", z1, "player_kit", player_kit, "sharedaccount_uid", sharedaccount_uid, "current_beat", current_beat, "active_objective", active_objective]);
}

function function_72d38b83fc04ee8e() {
  x = math::round_float(self.origin[0], 2);
  y = math::round_float(self.origin[1], 2);
  z = math::round_float(self.origin[2], 2);
  return [x, y, z];
}

function update_last_stand_id(player) {
  if(!isDefined(player.laststandid)) {
    player.laststandid = 0;
  } else {
    player.laststandid++;
  }

  return player.laststandid;
}

function get_last_stand_id(player) {
  return player.laststandid;
}

function function_54204f27964fddcf(player, purchased_item, purchase_cost) {
  current_beat = function_32900c5a73179b4();
  playername = player.name;
  sharedaccount_uid = player function_512417bddbe63792();
  player_kit = function_4bf5c934fad2bc96();
  active_objective = level.active_objectives_string;
  [x1, y1, z1] = player function_72d38b83fc04ee8e();
  dlog_recordevent("dlog_event_cpdata_shop_purchase", ["levelname", level.script, "playername", playername, "x1", x1, "y1", y1, "z1", z1, "purchased_item", purchased_item, "purchase_cost", purchase_cost, "active_objective", active_objective, "player_kit", player_kit, "current_beat", current_beat, "sharedaccount_uid", sharedaccount_uid]);
}

function function_bfe1744ef18f30f9(description_override) {
  description = "Trigger Hit";

  if(isDefined(description_override)) {
    description = description_override;
  }

  current_beat = function_32900c5a73179b4();
  active_objective = level.active_objectives_string;
  dlog_recordevent("dlog_event_cpdata_trigger_hit", ["levelname", level.script, "time_stamp", gettime(), "description", description, "current_beat", current_beat, "active_objective", active_objective]);
}

function function_ae955ccdef747b0(active_objective, var_1f7013b2c9380fa5, status_override) {
  if(!isDefined(active_objective)) {
    return;
  }

  level.active_objectives[active_objective] = 1;
  description = "Started";

  if(isDefined(status_override)) {
    description = status_override;
  }

  current_beat = function_32900c5a73179b4();
  dlog_recordevent("dlog_event_cpdata_level_progression", ["levelname", level.script, "time_stamp", gettime(), "description", description, "current_beat", current_beat, "active_objective", active_objective]);

  if(istrue(var_1f7013b2c9380fa5)) {
    return;
  }

  level thread scripts\cp\endgame::function_a8a9d2fb0feaf8eb(active_objective);
}

function function_b6283ac45a607764(objective_string, status_override) {
  if(!isDefined(level.active_objectives[objective_string])) {
    return;
  }

  level.active_objectives[objective_string] = undefined;
  status = "Completed";

  if(isDefined(status_override)) {
    status = status_override;
  }

  current_beat = function_32900c5a73179b4();
  dlog_recordevent("dlog_event_cpdata_level_progression", ["levelname", level.script, "time_stamp", gettime(), "description", status, "current_beat", current_beat, "active_objective", objective_string]);
  scripts\cp\endgame::function_1d10f2e8a8de2799(objective_string);
}

function function_4bf5c934fad2bc96() {
  player_kit = scripts\cp\kits::function_cab56589fd214c7e();

  if(!isDefined(player_kit)) {
    player_kit = "not selected";
  }

  return player_kit;
}

function update_focus_counter() {
  if(!function_240f7f4e57340e8f()) {
    return 0;
  }

  focus = self getprogressiondata("spData", "focusCounter");
  focus++;
  self setprogressiondata("spData", "focusCounter", focus);
  function_1cb406a7e2755abd("focus_pressed", focus);
}

function function_1cb406a7e2755abd(subevent, param0, param1, param2) {
  var_5d07f1d0617b50cb = function_462f9c4688feee56();

  if(!isDefined(subevent)) {
    subevent = "none";
  }

  param0 = function_7d4e1468e4a96223(param0);
  param1 = function_7d4e1468e4a96223(param1);
  param2 = function_7d4e1468e4a96223(param2);
  self dlog_recordplayerevent("dlog_event_cp_notifications", ["cp_header", var_5d07f1d0617b50cb, "subevent", subevent, "param0", param0, "param1", param1, "param2", param2]);
}

function function_462f9c4688feee56() {
  levelname = "none";
  startpoint = "none";
  origin = (0, 0, 0);
  angles = (0, 0, 0);
  name = getDvar(@ "g_mapname");

  if(isDefined(name)) {
    levelname = name;
  }

  if(isDefined(self)) {
    vec = self getorigin();

    if(isDefined(vec)) {
      origin = vec;
    }

    vec = self getplayerangles();

    if(isDefined(vec)) {
      angles = vec;
    }
  }

  if(isDefined(level.start_point)) {
    startpoint = level.start_point;
  }

  diff = get_gameskill_as_string();

  if(!isDefined(diff)) {
    diff = "unknown";
  }

  array = ["level_name", levelname, "gametime", gettime(), "originx", origin[0], "originy", origin[1], "originz", origin[2], "angleyaw", angles[1], "anglepitch", angles[0], "startpoint", startpoint, "difficulty", diff];
  return array;
}

function function_7d4e1468e4a96223(param) {
  if(!isDefined(param)) {
    param = "null";
  } else if(isint(param) || isfloat(param)) {
    param = "" + param;
  }

  return param;
}

function get_gameskill_as_string() {
  diff = scripts\cp\cp_gameskill::get_player_gameskill();

  if(diff == 0) {
    return "Recruit";
  }

  if(diff == 1) {
    return "Regular";
  }

  if(diff == 2) {
    return "Hardened";
  }

  if(diff == 3) {
    return "Veteran";
  }

  if(diff == 4) {
    return "Realism";
  }
}