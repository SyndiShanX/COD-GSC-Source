/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_analytics.gsc
***********************************************/

initlevelvars() {
  start_game_type("ddl/mp/cp_matchdata.ddl", "ddl/mp/zombieclientmatchdata.ddl", "cp/cp_analytics.csv");
  level.transactionid = 0;
  level.analyticsendgame = ::zombieendgameanalytics;
  level.revive_success_analytics_func = ::revive_success_analytics_func;
}

dlog_analytics_init() {
  setdvarifuninitialized("enable_analytics_log", 1);
  level.analyticslog = spawnStruct();
  level.analyticslog.nextplayerid = 0;
  level.analyticslog.nextobjectid = 0;
  level.analyticslog.nextdeathid = 0;

  if(!analyticsactive()) {
    return;
  }
  _id_14609B809484646E::_id_8ECE37593311858A(::watchforconnectedplayers);

  if(analyticslogenabled()) {
    thread logmatchtags();
    thread logallplayerposthink();
    thread logevent_minimapcorners();
  }
}

init_weapon_and_player_analytics(player) {
  player endon("disconnect");

  while(!isDefined(player.pers))
    wait 1;

  player _id_87D1AFFA098EA2E4();
  player.timewithitem = [];
  player.killswithitem = [];
  player.itemtype = " ";
  player.timeitemlasted = [];

  if(!isDefined(level.brutefirstspawn))
    level.brutefirstspawn = 0;

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

  if(!isDefined(player.totalxpearned))
    player.totalxpearned = 0;

  if(!isDefined(player.score_earned))
    player.score_earned = 0;

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

  if(!isDefined(player.exitingafterlifearcade))
    player.exitingafterlifearcade = 0;

  player.meleekill = 0;
  player.kung_fu_vo = 0;

  if(!isDefined(player.trapkills))
    player.trapkills = [];

  _id_470CAFD5FFFDFB72 = ["trap_gator", "trap_dragon", "trap_gravitron", "trap_danceparty", "trap_rocket", "trap_spin"];

  foreach(trap in _id_470CAFD5FFFDFB72) {
    if(!isDefined(player.trapkills[trap]))
      player.trapkills[trap] = 0;
  }

  _id_977604D2F5B29FEC = player.getweaponslist;

  if(isDefined(_id_977604D2F5B29FEC)) {
    foreach(weapon in _id_977604D2F5B29FEC) {
      player.weapon_name_log = scripts\cp\utility::getbaseweaponname(weapon);

      if(!isDefined(player.aggregateweaponkills[player.weapon_name_log]))
        player.aggregateweaponkills[player.weapon_name_log] = 0;
    }
  }
}

revive_success_analytics_func(reviver) {
  log_event("revived_another_player", 1, [reviver.clientid], [reviver.clientid], [reviver.clientid]);
}

zombieendgameanalytics() {
  _id_470CAFD5FFFDFB72 = ["trap_gator", "trap_dragon", "trap_gravitron", "trap_danceparty", "trap_rocket", "trap_spin"];

  foreach(_id_0432A6B6AADCC1EF, player in level.players) {
    log_weapons_data(_id_0432A6B6AADCC1EF, player);
    log_headshots_data(_id_0432A6B6AADCC1EF, player);
  }
}

log_headshots_data(_id_0432A6B6AADCC1EF, player) {
  foreach(weapon_name, value in player.headshots) {
    if(weapon_name == "none" || weapon_name == "" || value == 0 || !scripts\engine\utility::array_contains(level.loadout_weapons, weapon_name)) {
      continue;
    }
    setclientmatchdata("player", _id_0432A6B6AADCC1EF, "headShots", scripts\cp\utility::getbaseweaponname(weapon_name), value);
    _id_9220EA464F2E03EB = player getplayerdata("cp", "headShots", scripts\cp\utility::getbaseweaponname(weapon_name));
    player setplayerdata("cp", "headShots", scripts\cp\utility::getbaseweaponname(weapon_name), _id_9220EA464F2E03EB + value);
  }

  setclientmatchdata("player", _id_0432A6B6AADCC1EF, "total_headshots", player.total_match_headshots);
}

log_card_data(_id_0432A6B6AADCC1EF, player) {
  if(!isDefined(player.consumables)) {
    return;
  }
  if(level.gametype != "zombies") {
    return;
  }
  foreach(_id_AF08257DBFE4C318, _id_ECE36839AE7F9507 in player.consumables) {
    _id_455F02D4512D534D = player getplayerdata("cp", "cards_used", _id_AF08257DBFE4C318);
    player setplayerdata("cp", "cards_used", _id_AF08257DBFE4C318, _id_455F02D4512D534D + _id_ECE36839AE7F9507.times_used);
  }
}

log_explosive_kills(_id_0432A6B6AADCC1EF, player) {
  if(!isDefined(player.explosive_kills)) {
    return;
  }
  _id_4E7DBB435B55A691 = player getplayerdata("cp", "explosive_kills");
  player setplayerdata("cp", "explosive_kills", _id_4E7DBB435B55A691 + player.explosive_kills);
}

log_weapons_data(_id_0432A6B6AADCC1EF, player) {
  _id_B9291C64CA45F162 = 0;
  _id_2E882FB3D40AB2B5 = 0;
  _id_159D315CFAD2DD2A = "";

  foreach(weapon_name, value in player.aggregateweaponkills) {
    if(weapon_name == "none" || weapon_name == "" || value == 0 || !scripts\engine\utility::array_contains(level.loadout_weapons, weapon_name)) {
      continue;
    }
    setclientmatchdata("player", _id_0432A6B6AADCC1EF, "killsPerWeapon", scripts\cp\utility::getbaseweaponname(weapon_name), value);
    _id_C838A7EC91887939 = player getplayerdata("cp", "killsPerWeapon", scripts\cp\utility::getbaseweaponname(weapon_name));
    player setplayerdata("cp", "killsPerWeapon", scripts\cp\utility::getbaseweaponname(weapon_name), _id_C838A7EC91887939 + value);

    if(player.aggregateweaponkills[weapon_name] > 0 && _id_B9291C64CA45F162 == 0) {
      _id_2E882FB3D40AB2B5 = player.aggregateweaponkills[weapon_name];
      _id_B9291C64CA45F162 = 1;
      _id_159D315CFAD2DD2A = scripts\cp\utility::getbaseweaponname(weapon_name);
    }

    if(player.aggregateweaponkills[weapon_name] > _id_2E882FB3D40AB2B5) {
      _id_2E882FB3D40AB2B5 = player.aggregateweaponkills[weapon_name];
      _id_159D315CFAD2DD2A = scripts\cp\utility::getbaseweaponname(weapon_name);
    }
  }
}

start_game_type(_id_FC271415B7B836FE, _id_D17D417BB04FCEB4, _id_ADE4259AADA39885) {
  init(_id_ADE4259AADA39885);
  init_matchdata(_id_FC271415B7B836FE, _id_D17D417BB04FCEB4);
}

init_matchdata(_id_FC271415B7B836FE, _id_D17D417BB04FCEB4) {
  setclientmatchdatadef(_id_D17D417BB04FCEB4);

  if(getdvarint("online_matchdata_enabled") != 0) {
    setmatchdatadef(_id_FC271415B7B836FE);
    setmatchdata("commonMatchData", "map", level.script);
    setmatchdata("commonMatchData", "gametype", getDvar("ui_gametype"));
    setmatchdata("commonMatchData", "build_version", getbuildversion());
    setmatchdata("commonMatchData", "build_number", getbuildnumber());
    setmatchdata("commonMatchData", "utc_start_time_s", getsystemtime());
    setmatchdata("commonMatchData", "is_private_match", getdvarint("xblive_privatematch"));
    setmatchdata("commonMatchData", "is_ranked_match", 1);
  }

  level thread wait_set_initial_player_count();
}

init(_id_ADE4259AADA39885) {
  cp_matchdata = spawnStruct();
  single_value_stats = [];
  cp_matchdata.single_value_stats = single_value_stats;
  challenge_results = [];
  cp_matchdata.challenge_results = challenge_results;
  level.cp_matchdata = cp_matchdata;
  init_analytics(_id_ADE4259AADA39885);
  level.player_count = 0;
  level.player_count_left = 0;
}

wait_set_initial_player_count() {
  level endon("gameEnded");
  level waittill("prematch_done");
  setmatchdata("commonMatchData", "player_count_start", validate_byte(level.players.size));
}

on_player_connect() {
  player_init();
  set_player_count();
  set_split_screen();
  set_join_in_progress();

  if(!isDefined(level.player_count))
    level.player_count = 1;
  else
    level.player_count = level.player_count + 1;
}

initsegmentstats() {
  level endon("game_ended");
  level thread recordplayersegmentdata();

  for(;;) {
    level waittill("connected", player);
    createplayersegmentstats(player);
  }
}

recordplayersegmentdata() {
  level endon("game_ended");
  scripts\cp\utility::gameflagwait("prematch_done");
  wait 4;

  for(;;) {
    wait 1;

    foreach(player in level.players)
    player thread updateplayersegmentdata();
  }
}

createplayersegmentstats(player) {
  player.segments = [];
  player.segments["distanceTotal"] = 0;
  player.segments["movingTotal"] = 0;
  player.segments["movementUpdateCount"] = 0;
  player.savedsegmentposition = player.origin;
  player.positionptm = player.origin;
}

updateplayersegmentdata() {
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
    _id_03738EA25E5A0F93 = distance2d(self.positionptm, self.origin);
    self.positionptm = self.origin;

    if(_id_03738EA25E5A0F93 > 16)
      self.segments["movingTotal"]++;
  }
}

on_player_disconnect(_id_401C3A2E68AAB0FD) {
  set_custom_stats();
  level.player_count_left = level.player_count_left + 1;
}

player_init() {
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

set_player_count() {
  if(!isDefined(level.max_concurrent_player_count))
    level.max_concurrent_player_count = 0;

  if(level.players.size >= level.max_concurrent_player_count)
    level.max_concurrent_player_count = level.players.size + 1;
}

set_split_screen() {}

set_join_in_progress() {}

prematch_over() {
  if(scripts\engine\utility::flag_exist("introscreen_over") && scripts\engine\utility::flag("introscreen_over"))
    return 1;

  return 0;
}

update_challenges_status(challenge_name, result) {
  if(level.cp_matchdata.challenge_results.size > 25) {
    return;
  }
  _id_33A56A47C1CAB7F1 = spawnStruct();
  _id_33A56A47C1CAB7F1.challenge_name = challenge_name;
  _id_33A56A47C1CAB7F1.result = result;
  level.cp_matchdata.challenge_results[level.cp_matchdata.challenge_results.size] = _id_33A56A47C1CAB7F1;
}

inc_downed_counts() {
  inc_laststand_record("timesDowned");
}

inc_revived_counts() {
  inc_laststand_record("timesRevived");
}

inc_bleedout_counts() {
  inc_laststand_record("timesBledOut");
}

inc_laststand_record(_id_9CB21A4889016087) {
  if(!isDefined(self.cp_matchdata.laststand_record[_id_9CB21A4889016087][level.wave_num]))
    self.cp_matchdata.laststand_record[_id_9CB21A4889016087][level.wave_num] = 0;

  self.cp_matchdata.laststand_record[_id_9CB21A4889016087][level.wave_num]++;
}

update_spending_type(_id_D5CEA5C370608022, _id_E42F7EB456B932F2) {
  switch (_id_E42F7EB456B932F2) {
    case "weapon":
      self.cp_matchdata.single_value_stats["cashSpentOnWeapon"].value = self.cp_matchdata.single_value_stats["cashSpentOnWeapon"].value + _id_D5CEA5C370608022;
      break;
    case "ability":
      self.cp_matchdata.single_value_stats["cashSpentOnAbility"].value = self.cp_matchdata.single_value_stats["cashSpentOnAbility"].value + _id_D5CEA5C370608022;
      break;
    case "trap":
      self.cp_matchdata.single_value_stats["cashSpentOnTrap"].value = self.cp_matchdata.single_value_stats["cashSpentOnTrap"].value + _id_D5CEA5C370608022;
      break;
    default:
      break;
  }
}

endgame(_id_BEBA97D4D0A18C9C, _id_2C2BCE30DE469AE1) {
  set_game_data(_id_BEBA97D4D0A18C9C, _id_2C2BCE30DE469AE1);
  write_global_clientmatchdata();

  foreach(_id_0432A6B6AADCC1EF, player in level.players) {
    scripts\cp\cp_persistence::increment_player_career_total_waves(player);
    scripts\cp\cp_persistence::increment_player_career_total_score(player);
    player set_player_data(_id_2C2BCE30DE469AE1);
    player set_player_game_data();
    player write_clientmatchdata_for_player(player, _id_0432A6B6AADCC1EF);
  }

  if(isDefined(level.analyticsendgame))
    [[level.analyticsendgame]]();

  if(getdvarint("online_matchdata_enabled") != 0)
    sendmatchdata();

  sendclientmatchdata();
}

set_player_data(_id_2C2BCE30DE469AE1) {
  _id_4BA0C4BD49496E78 = self getplayerdata("cp", "coopCareerStats", "totalGameplayTime");
  _id_19FD2738F64F68AB = self getplayerdata("cp", "coopCareerStats", "gamesPlayed");

  if(!isDefined(_id_4BA0C4BD49496E78))
    _id_4BA0C4BD49496E78 = 0;

  if(!isDefined(_id_19FD2738F64F68AB))
    _id_19FD2738F64F68AB = 0;

  _id_4BA0C4BD49496E78 = _id_4BA0C4BD49496E78 + _id_2C2BCE30DE469AE1 / 1000;
  _id_19FD2738F64F68AB = _id_19FD2738F64F68AB + 1;
  self setplayerdata("cp", "coopCareerStats", "totalGameplayTime", int(_id_4BA0C4BD49496E78));
  self setplayerdata("cp", "coopCareerStats", "gamesPlayed", int(_id_19FD2738F64F68AB));
}

set_game_data(_id_BEBA97D4D0A18C9C, _id_2C2BCE30DE469AE1) {
  _id_495308C746AAC9C9 = "challengesCompleted";
  cp_matchdata = level.cp_matchdata;

  foreach(_id_DE9258F8129E7481, _id_41C1393A51C5D39A in cp_matchdata.single_value_stats)
  value = validate_value(_id_41C1393A51C5D39A.value, _id_41C1393A51C5D39A.value_type);

  foreach(index, _id_33A56A47C1CAB7F1 in cp_matchdata.challenge_results) {}

  setmatchdata("commonMatchData", "player_count_end", level.players.size);
  setmatchdata("commonMatchData", "utc_end_time_s", getsystemtime());
  setmatchdata("commonMatchData", "player_count", validate_byte(level.player_count));
  setmatchdata("commonMatchData", "player_count_left", validate_byte(level.player_count_left));
}

set_player_game_data() {
  copy_from_playerdata();
  set_laststand_stats();
  set_single_value_stats();
  set_custom_stats();
}

get_player_matchdata(key, _id_FC8AFB765C52482B) {
  if(isDefined(level.matchdata["player"][self.clientid]) && isDefined(level.matchdata["player"][self.clientid][key]))
    return level.matchdata["player"][self.clientid][key];

  return _id_FC8AFB765C52482B;
}

set_custom_stats() {
  _id_4BA0C4BD49496E78 = self getplayerdata("cp", "coopCareerStats", "totalGameplayTime");
  _id_19FD2738F64F68AB = self getplayerdata("cp", "coopCareerStats", "gamesPlayed");
  _id_00AE17C5A8B1BC1B = self getplayerdata("cp", "progression", "playerLevel", "rank");
  _id_C52868E86C820DE4 = self getplayerdata("cp", "progression", "playerLevel", "prestige");
}

copy_from_playerdata() {}

set_laststand_stats() {}

set_single_value_stats() {}

validate_value(value, _id_2872B03564CEC89A) {
  switch (_id_2872B03564CEC89A) {
    case "byte":
      return validate_byte(value);
    case "short":
      return validate_short(value);
    case "int":
      return validate_int(value);
    default:
  }
}

validate_byte(value) {
  return int(min(value, 127));
}

validate_short(value) {
  return int(min(value, 32767));
}

validate_int(value) {
  return int(min(value, 2147483647));
}

get_single_value_struct(_id_545BB155962F1671, value_type) {
  _id_41C1393A51C5D39A = spawnStruct();
  _id_41C1393A51C5D39A.value = _id_545BB155962F1671;
  _id_41C1393A51C5D39A.value_type = value_type;
  return _id_41C1393A51C5D39A;
}

init_analytics(_id_ADE4259AADA39885) {
  _id_27D6FC765DB2FF56 = 0;
  _id_11F6E8336FFF0C54 = 1;
  _id_F0837D977499367C = 2;
  _id_FA39A68C06AF79E5 = 1;
  _id_44A02B844046E62E = 2;
  _id_7D5AE35FC129722F = 3;
  _id_1250C14634E12168 = 4;
  _id_5DD78B3E67539236 = 5;
  _id_D675B910EAA5D365 = 6;
  _id_BD34919C89C9A587 = 1;
  _id_0C6E216027D6F67A = 100;
  _id_DDC9474813519601 = 101;
  _id_39E94EDDE1FD5EE2 = 300;
  level.blackbox_data_type = [];
  level.matchdata_struct = [];
  level.matchdata_data_type = [];
  level.matchdata = [];
  level.clientmatchdata_struct = [];
  level.clientmatchdata_data_type = [];
  level.clientmatchdata = [];

  for(_id_AC0E594AC96AA3A8 = _id_DDC9474813519601; _id_AC0E594AC96AA3A8 <= _id_39E94EDDE1FD5EE2; _id_AC0E594AC96AA3A8++) {
    _id_1EA234EEB937340E = tablelookup(_id_ADE4259AADA39885, _id_27D6FC765DB2FF56, _id_AC0E594AC96AA3A8, _id_FA39A68C06AF79E5);

    if(_id_1EA234EEB937340E == "") {
      continue;
    }
    blackbox_data_type = tablelookup(_id_ADE4259AADA39885, _id_27D6FC765DB2FF56, _id_AC0E594AC96AA3A8, _id_44A02B844046E62E);

    if(blackbox_data_type != "")
      level.blackbox_data_type[_id_1EA234EEB937340E] = blackbox_data_type;

    matchdata_data_type = tablelookup(_id_ADE4259AADA39885, _id_27D6FC765DB2FF56, _id_AC0E594AC96AA3A8, _id_7D5AE35FC129722F);

    if(matchdata_data_type != "")
      level.matchdata_data_type[_id_1EA234EEB937340E] = matchdata_data_type;

    is_matchdata_struct = tablelookup(_id_ADE4259AADA39885, _id_27D6FC765DB2FF56, _id_AC0E594AC96AA3A8, _id_1250C14634E12168);

    if(is_matchdata_struct != "") {
      level.matchdata_struct[_id_1EA234EEB937340E] = [];
      level.matchdata[_id_1EA234EEB937340E] = [];
    }

    clientmatchdata_data_type = tablelookup(_id_ADE4259AADA39885, _id_27D6FC765DB2FF56, _id_AC0E594AC96AA3A8, _id_5DD78B3E67539236);

    if(clientmatchdata_data_type != "")
      level.clientmatchdata_data_type[_id_1EA234EEB937340E] = clientmatchdata_data_type;

    is_clientmatchdata_struct = tablelookup(_id_ADE4259AADA39885, _id_27D6FC765DB2FF56, _id_AC0E594AC96AA3A8, _id_D675B910EAA5D365);

    if(is_clientmatchdata_struct != "") {
      level.clientmatchdata_struct[_id_1EA234EEB937340E] = [];
      level.clientmatchdata[_id_1EA234EEB937340E] = [];
    }
  }

  level.analytics_event = [];

  for(_id_AC0E594AC96AA3A8 = _id_BD34919C89C9A587; _id_AC0E594AC96AA3A8 <= _id_0C6E216027D6F67A; _id_AC0E594AC96AA3A8++) {
    _id_A17F1CA975C71991 = tablelookup(_id_ADE4259AADA39885, _id_27D6FC765DB2FF56, _id_AC0E594AC96AA3A8, _id_11F6E8336FFF0C54);

    if(_id_A17F1CA975C71991 == "") {
      break;
    }

    _id_848DCCA64A818A01 = tablelookup(_id_ADE4259AADA39885, _id_27D6FC765DB2FF56, _id_AC0E594AC96AA3A8, _id_F0837D977499367C);
    level.analytics_event[_id_A17F1CA975C71991] = _id_848DCCA64A818A01;
    _id_032B571D0F07E43B = strtok(_id_848DCCA64A818A01, " ");

    foreach(data in _id_032B571D0F07E43B) {
      if(isDefined(level.matchdata_struct[data]))
        level.matchdata_struct[data][_id_A17F1CA975C71991] = 0;

      if(isDefined(level.clientmatchdata_struct[data]) && isDefined(level.clientmatchdata_data_type[_id_A17F1CA975C71991]))
        level.clientmatchdata_struct[data][_id_A17F1CA975C71991] = 0;
    }
  }
}

log_event(_id_BFFEE57E43BA8941, _id_31585DC3EE9242DC, _id_A4784FDA62821EA9, _id_492753C65F46C8F0, _id_8BD7FFFF59D706A9) {
  _id_032B571D0F07E43B = get_data_to_update(_id_BFFEE57E43BA8941);
  log_clientmatchdata(_id_BFFEE57E43BA8941, _id_032B571D0F07E43B, _id_31585DC3EE9242DC, _id_8BD7FFFF59D706A9);
}

log_clientmatchdata(_id_BFFEE57E43BA8941, _id_032B571D0F07E43B, _id_31585DC3EE9242DC, _id_8BD7FFFF59D706A9) {
  if(!isDefined(_id_8BD7FFFF59D706A9)) {
    return;
  }
  _id_669DC59993040270 = 0;

  if(is_clientmatchdata_data(_id_BFFEE57E43BA8941)) {
    foreach(_id_848DCCA64A818A01 in _id_032B571D0F07E43B) {
      if(is_clientmatchdata_struct(_id_848DCCA64A818A01)) {
        _id_E8C1C016B74F5143 = _id_8BD7FFFF59D706A9[_id_669DC59993040270];

        if(!isDefined(level.clientmatchdata[_id_848DCCA64A818A01][_id_E8C1C016B74F5143]))
          level.clientmatchdata[_id_848DCCA64A818A01][_id_E8C1C016B74F5143] = level.clientmatchdata_struct[_id_848DCCA64A818A01];

        level.clientmatchdata[_id_848DCCA64A818A01][_id_E8C1C016B74F5143][_id_BFFEE57E43BA8941] = level.clientmatchdata[_id_848DCCA64A818A01][_id_E8C1C016B74F5143][_id_BFFEE57E43BA8941] + _id_31585DC3EE9242DC;
        _id_669DC59993040270++;
      }
    }
  }
}

get_bb_string(_id_032B571D0F07E43B) {
  result = "";

  foreach(index, _id_848DCCA64A818A01 in _id_032B571D0F07E43B) {
    result = result + (_id_848DCCA64A818A01 + " " + level.blackbox_data_type[_id_848DCCA64A818A01]);

    if(index != _id_032B571D0F07E43B.size - 1)
      result = result + " ";
  }

  return result;
}

get_data_to_update(_id_BFFEE57E43BA8941) {
  _id_032B571D0F07E43B = level.analytics_event[_id_BFFEE57E43BA8941];
  return strtok(_id_032B571D0F07E43B, " ");
}

log_matchdata(_id_BFFEE57E43BA8941, _id_032B571D0F07E43B, _id_31585DC3EE9242DC, _id_492753C65F46C8F0) {
  _id_84B743F5C1698EB1 = 0;

  foreach(_id_848DCCA64A818A01 in _id_032B571D0F07E43B) {
    if(is_matchdata_struct(_id_848DCCA64A818A01)) {
      _id_967BFC156D27C086 = _id_492753C65F46C8F0[_id_84B743F5C1698EB1];

      if(!isDefined(level.matchdata[_id_848DCCA64A818A01][_id_967BFC156D27C086]))
        level.matchdata[_id_848DCCA64A818A01][_id_967BFC156D27C086] = level.matchdata_struct[_id_848DCCA64A818A01];

      level.matchdata[_id_848DCCA64A818A01][_id_967BFC156D27C086][_id_BFFEE57E43BA8941] = level.matchdata[_id_848DCCA64A818A01][_id_967BFC156D27C086][_id_BFFEE57E43BA8941] + _id_31585DC3EE9242DC;
      _id_84B743F5C1698EB1++;
    }
  }
}

is_matchdata_struct(_id_848DCCA64A818A01) {
  return isDefined(level.matchdata_struct[_id_848DCCA64A818A01]);
}

is_clientmatchdata_struct(_id_848DCCA64A818A01) {
  return isDefined(level.clientmatchdata_struct[_id_848DCCA64A818A01]);
}

is_clientmatchdata_data(_id_848DCCA64A818A01) {
  return isDefined(level.clientmatchdata_data_type[_id_848DCCA64A818A01]);
}

write_global_clientmatchdata() {
  setclientmatchdata("waves_survived", level.wave_num);
  setclientmatchdata("time_survived", level.time_survived);

  if(isDefined(level.eogscoringtotalpoints))
    setclientmatchdata("team_score", level.eogscoringtotalpoints);

  if(isDefined(level.starsearned))
    setclientmatchdata("stars_earned", level.starsearned);

  setclientmatchdata("scoreboardPlayerCount", level.players.size);
  setclientmatchdata("map", level.script);

  if(isDefined(level.write_global_clientmatchdata_func))
    [[level.write_global_clientmatchdata_func]]();
}

write_clientmatchdata_for_player(player, _id_0432A6B6AADCC1EF) {
  setclientmatchdata("player", _id_0432A6B6AADCC1EF, "username", player.name);
  _id_DB24F499F4608B0D = player getplayerdata("cp", "alienSession", "kills");
  _id_9C571F8C5058B16E = player getplayerdata("cp", "alienSession", "downed");
  _id_708B0E4925A97D80 = player getplayerdata("cp", "alienSession", "revives");
  _id_764597D44585989B = player getxuidhigh();
  _id_AF2717B4BD968867 = player getxuidlow();

  if(!scripts\cp\utility::is_specops_gametype()) {
    if(scripts\cp\utility::matchmakinggame())
      setclientmatchdata("player", _id_0432A6B6AADCC1EF, "rank", player _id_187A04151C40FB72::getrank());
    else
      setclientmatchdata("player", _id_0432A6B6AADCC1EF, "rank", player scripts\cp\cp_persistence::get_player_rank());
  }

  if(!isDefined(player.player_character_index)) {
    return;
  }
  setclientmatchdata("player", _id_0432A6B6AADCC1EF, "characterIndex", player.player_character_index);
  _id_CD668D6D59FEAF21 = level.clientmatchdata["player"][player.clientid];

  if(isDefined(_id_CD668D6D59FEAF21)) {
    foreach(data, _id_294170EE2FBB2943 in _id_CD668D6D59FEAF21)
    setclientmatchdata("player", _id_0432A6B6AADCC1EF, data, int(_id_294170EE2FBB2943));
  }

  if(isDefined(level.endgame_write_clientmatchdata_for_player_func))
    [[level.endgame_write_clientmatchdata_for_player_func]](player, _id_0432A6B6AADCC1EF);
}

analyticsactive() {
  if(analyticsspawnlogenabled())
    return 1;

  if(analyticslogenabled())
    return 1;

  return 0;
}

analyticslogenabled() {
  return getdvarint("enable_analytics_log");
}

getuniqueobjectid() {
  id = level.analyticslog.nextobjectid;
  level.analyticslog.nextobjectid++;
  return id;
}

cacheplayeraction(_id_AA9E39088CE26EEE) {
  if(!isDefined(self.analyticslog.cachedactions))
    self.analyticslog.cachedactions = 0;

  self.analyticslog.cachedactions = self.analyticslog.cachedactions | _id_AA9E39088CE26EEE;
}

watchforconnectedplayers() {
  if(!analyticsactive()) {
    return;
  }
  logevent_playerconnected();
  thread watchforbasicplayerevents();
  thread watchforplayermovementevents();
  thread watchforusermessageevents();
}

watchforbasicplayerevents() {
  self endon("disconnect");

  if(!analyticslogenabled()) {
    return;
  }
  for(;;) {
    _id_ADBD34525F139FC9 = scripts\engine\utility::waittill_any_return_no_endon_death_5("adjustedStance", "jumped", "weapon_fired", "reload_start", "spawned_player");

    if(_id_ADBD34525F139FC9 == "adjustedStance") {
      checkstancestatus();
      continue;
    }

    if(_id_ADBD34525F139FC9 == "jumped") {
      cacheplayeraction(4);
      continue;
    }

    if(_id_ADBD34525F139FC9 == "weapon_fired") {
      cacheplayeraction(8);
      continue;
    }

    if(_id_ADBD34525F139FC9 == "reload_start") {
      cacheplayeraction(16);
      continue;
    }

    if(_id_ADBD34525F139FC9 == "spawned_player")
      thread logevent_playerspawn();
  }
}

watchforplayermovementevents() {
  self endon("disconnect");

  if(!analyticslogenabled()) {
    return;
  }
  for(;;) {
    _id_ADBD34525F139FC9 = scripts\engine\utility::waittill_any_return_no_endon_death_3("doubleJumpBegin", "doubleJumpEnd", "sprint_slide_begin");

    if(_id_ADBD34525F139FC9 == "doubleJumpBegin") {
      cacheplayeraction(64);
      continue;
    }

    if(_id_ADBD34525F139FC9 == "doubleJumpEnd") {
      cacheplayeraction(128);
      continue;
    }

    if(_id_ADBD34525F139FC9 == "sprint_slide_begin")
      cacheplayeraction(256);
  }
}

watchforusermessageevents() {
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
    _id_EA3E3B2121E6713A = scripts\engine\utility::waittill_any_return_2("log_user_event_end", "log_user_event_generic_event");

    if(isDefined(_id_EA3E3B2121E6713A) && _id_EA3E3B2121E6713A == "log_user_event_generic_event")
      logevent_message(self.name, self.origin, "Generic User Event");
  }
}

checkstancestatus() {
  stance = self getstance();

  if(stance == "prone")
    cacheplayeraction(1);
  else if(stance == "crouch")
    cacheplayeraction(2);
}

logallplayerposthink() {
  if(!analyticslogenabled()) {
    return;
  }
  for(;;) {
    _id_071DF66B50009254 = gettime();
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

    wait(max(0.05, 1.5 - (gettime() - _id_071DF66B50009254) / 1000));
  }
}

recordbreadcrumbdata() {
  level endon("game_ended");

  if(getDvar("online_breadcrumbing_enabled") == "0") {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    _id_2FE6A798E49F4DE6 = getdvarfloat("online_br_breadcrumbing_frequency", 4.0);
  else
    _id_2FE6A798E49F4DE6 = getdvarfloat("online_mp_breadcrumbing_frequency", 2.0);

  scripts\mp\flags::gameflagwait("prematch_done");

  for(;;) {
    foreach(player in level.players) {
      if(!isDefined(player)) {
        continue;
      }
      _id_DE1E71241AAE57ED = scripts\cp\utility\player::isreallyalive(player) && !isai(player);
      _id_D4CE6B875D4F5CF8 = isDefined(player.pers["telemetry"]) && isDefined(player.pers["telemetry"].life) && isDefined(player.pers["telemetry"].life._id_6F9BBED303902680) && _id_4A6760982B403BAD::_id_0892570944F6B6A2(player);
      _id_7B3A43A2C9353902 = isDefined(player.team) && player.team != "spectator" && player.sessionstate == "playing" && player.sessionstate != "dead";

      if(_id_DE1E71241AAE57ED && _id_D4CE6B875D4F5CF8 && _id_7B3A43A2C9353902) {
        isads = player scripts\cp\utility::isplayerads();
        _id_0A086AAA8477D2C6 = _id_4A6760982B403BAD::_id_1B15450E092933CF(gettime());
        player recordbreadcrumbdataforplayer(_id_0A086AAA8477D2C6, player.pers["telemetry"].life._id_6F9BBED303902680, isads);
      }
    }

    wait(_id_2FE6A798E49F4DE6);
  }
}

getpathactionvalue() {
  actions = scripts\engine\utility::ter_op(isDefined(self.analyticslog.cachedactions), self.analyticslog.cachedactions, 0);

  if(self iswallrunning())
    actions = actions | 32;

  return actions;
}

clearpathactionvalue() {
  self.analyticslog.cachedactions = 0;
  checkstancestatus();
}

buildkilldeathactionvalue() {
  _id_818060D4E74DDBA0 = 0;
  stance = self getstance();

  if(stance == "prone")
    _id_818060D4E74DDBA0 = _id_818060D4E74DDBA0 | 1;
  else if(stance == "crouch")
    _id_818060D4E74DDBA0 = _id_818060D4E74DDBA0 | 2;

  if(self isjumping())
    _id_818060D4E74DDBA0 = _id_818060D4E74DDBA0 | 4;

  if(isDefined(self.lastshotfiredtime) && gettime() - self.lastshotfiredtime < 500)
    _id_818060D4E74DDBA0 = _id_818060D4E74DDBA0 | 8;

  if(self isreloading())
    _id_818060D4E74DDBA0 = _id_818060D4E74DDBA0 | 16;

  return _id_818060D4E74DDBA0;
}

buildloadoutstring() {
  _id_63AC6FB2EAA0E5D2 = "equipmentPrimary =" + self.equipment["primary"] + ";" + "equipmentSecondary =" + self.equipment["secondary"] + ";" + "weaponPrimary=" + self.primaryweaponobj.basename + ";" + "weaponSecondary=" + self.secondaryweaponobj.basename + ";";
  return _id_63AC6FB2EAA0E5D2;
}

buildspawnpointstatestring(spawnpoint) {
  _id_3068716C250A5E58 = "";

  if(isDefined(spawnpoint.lastbucket)) {
    if(isDefined(spawnpoint.lastbucket["allies"]))
      _id_3068716C250A5E58 = _id_3068716C250A5E58 + ("alliesBucket=" + spawnpoint.lastbucket["allies"] + ";");

    if(isDefined(spawnpoint.lastbucket["axis"]))
      _id_3068716C250A5E58 = _id_3068716C250A5E58 + ("axisBucket=" + spawnpoint.lastbucket["axis"] + ";");
  }

  return _id_3068716C250A5E58;
}

logevent_path() {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  _id_53F4B69AE494195A = anglesToForward(self getplayerangles());
  dlog_recordevent("gamecp_path", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", _id_53F4B69AE494195A[0], "gun_orienty", _id_53F4B69AE494195A[1], "gun_orientz", _id_53F4B69AE494195A[2], "action", getpathactionvalue(), "health", getsantizedhealth()]);
  clearpathactionvalue();
}

logevent_playerspawn() {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  _id_C6C41B96B7C2EF2A = isDefined(self.lastspawnpoint) && isDefined(self.lastspawnpoint.buddyspawn) && self.lastspawnpoint.buddyspawn;
  _id_20AF753DED3657E1 = anglesToForward(self.angles);
  dlog_recordevent("gamecp_spawn_in", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "orientx", _id_20AF753DED3657E1[0], "orienty", _id_20AF753DED3657E1[1], "orientz", _id_20AF753DED3657E1[2], "loadout", buildloadoutstring(), "type", scripts\engine\utility::ter_op(_id_C6C41B96B7C2EF2A, "Buddy", "Normal"), "team", self.team]);
}

logevent_playerconnected() {
  if(!analyticsactive()) {
    return;
  }
  if(!isDefined(self.analyticslog))
    self.analyticslog = spawnStruct();

  self.analyticslog.playerid = level.analyticslog.nextplayerid;
  level.analyticslog.nextplayerid++;

  if(!analyticslogenabled()) {
    return;
  }
  super = undefined;

  if(isDefined(self.changedarchetypeinfo))
    super = self.changedarchetypeinfo.super;
  else
    super = self getplayerdata(level.loadoutsgroup, "squadMembers", "archetypeSuper");

  xuid = self getxuid();
  dlog_recordevent("gamecp_player_connect", ["playerid", self.analyticslog.playerid, "player_name", self.name, "player_xuid", xuid, "player_super_name", super]);
}

logevent_playerdeath(attacker, meansofdeath, weaponname) {
  if(!shouldplayerlogevents(self) || !isPlayer(self)) {
    return;
  }
  _id_53F4B69AE494195A = anglesToForward(self getplayerangles());
  _id_77295BBD7B1B8155 = -1;
  _id_798130B7F1830880 = 0;
  _id_798131B7F1830AB3 = 0;
  _id_798132B7F1830CE6 = 0;
  _id_40CFB0F1536D4858 = 0;
  _id_40CFB1F1536D4A8B = 0;
  _id_40CFB2F1536D4CBE = 0;
  attackerteam = "s";
  _id_02B835290A32BC05 = 0;

  if(isDefined(attacker) && isPlayer(attacker)) {
    _id_77295BBD7B1B8155 = attacker.analyticslog.playerid;

    if(isDefined(attacker.team)) {
      if(attacker.team == "axis")
        attackerteam = "a";
      else
        attackerteam = "l";
    }

    if(isDefined(attacker.origin)) {
      _id_798130B7F1830880 = attacker.origin[0];
      _id_798131B7F1830AB3 = attacker.origin[1];
      _id_798132B7F1830CE6 = attacker.origin[2];
    }

    if(isDefined(attacker.lifeid))
      _id_02B835290A32BC05 = attacker.lifeid;

    _id_0FDE6939445AAE30 = anglesToForward(attacker getplayerangles());

    if(isDefined(_id_0FDE6939445AAE30)) {
      _id_40CFB0F1536D4858 = _id_0FDE6939445AAE30[0];
      _id_40CFB1F1536D4A8B = _id_0FDE6939445AAE30[1];
      _id_40CFB2F1536D4CBE = _id_0FDE6939445AAE30[2];
    }
  }

  _id_79F00192DD16D2AC = level.analyticslog.nextdeathid;
  level.analyticslog.nextdeathid++;
  weaponname = scripts\engine\utility::ter_op(isDefined(weaponname), weaponname, "None");
  victimteam = "s";

  if(self.team == "axis")
    victimteam = "a";
  else
    victimteam = "l";

  dlog_recordevent("134death", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", _id_53F4B69AE494195A[0], "gun_orienty", _id_53F4B69AE494195A[1], "gun_orientz", _id_53F4B69AE494195A[2], "weapon", weaponname, "mean_of_death", scripts\engine\utility::ter_op(isDefined(meansofdeath), meansofdeath, "None"), "attackerid", _id_77295BBD7B1B8155, "action", buildkilldeathactionvalue(), "server_death_id", _id_79F00192DD16D2AC, "victim_life_index", self.lifeid, "attacker_life_index", _id_02B835290A32BC05, "victim_team", victimteam, "attacker_team", attackerteam, "attacker_pos_x", _id_798130B7F1830880, "attacker_pos_y", _id_798131B7F1830AB3, "attacker_pos_z", _id_798132B7F1830CE6, "attacker_gun_orientx", _id_40CFB0F1536D4858, "attacker_gun_orienty", _id_40CFB1F1536D4A8B, "attacker_gun_orientz", _id_40CFB2F1536D4CBE, "victim_weapon", self.primaryweapon]);

  if(isDefined(meansofdeath) && isexplosivedamagemod(meansofdeath))
    logevent_explosion(scripts\engine\utility::ter_op(isDefined(weaponname), weaponname, "generic"), self.origin, attacker, 1.0);

  if(isDefined(self.attackers)) {
    foreach(_id_2C5B6AA194FE1165 in self.attackers) {
      if(isDefined(_id_2C5B6AA194FE1165) && isPlayer(_id_2C5B6AA194FE1165) && _id_2C5B6AA194FE1165 != attacker)
        logevent_assist(_id_2C5B6AA194FE1165.analyticslog.playerid, _id_79F00192DD16D2AC, weaponname);
    }
  }
}

logevent_playerkill(victim, meansofdeath, weaponname) {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  _id_53F4B69AE494195A = anglesToForward(self getplayerangles());
  dlog_recordevent("gamecp_kill", ["playerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "gun_orientx", _id_53F4B69AE494195A[0], "gun_orienty", _id_53F4B69AE494195A[1], "gun_orientz", _id_53F4B69AE494195A[2], "weapon", scripts\engine\utility::ter_op(isDefined(weaponname), weaponname, "None"), "mean_of_kill", scripts\engine\utility::ter_op(isDefined(meansofdeath), meansofdeath, "None"), "victimid", scripts\engine\utility::ter_op(isDefined(victim) && isPlayer(victim), victim.analyticslog.playerid, "-1"), "action", buildkilldeathactionvalue(), "attacker_health", getsantizedhealth(), "victim_pixel_count", 0]);
}

logevent_explosion(type, center, _id_E83217ED09C27313, duration, direction) {
  if(!analyticslogenabled()) {
    return;
  }
  if(!isDefined(direction))
    direction = (1, 0, 0);

  dlog_recordevent("gamecp_explosion", ["playerid", _id_E83217ED09C27313.analyticslog.playerid, "x", center[0], "y", center[1], "z", center[2], "orientx", direction[0], "orienty", direction[1], "orientz", direction[2], "duration", duration, "type", type]);
}

logevent_frontlineupdate(startpos, endpos, _id_C43D9EC2E9A839C6, _id_FABE25D5659F05A9, _id_E036BEB70DA584EC) {
  if(!analyticslogenabled()) {
    return;
  }
  dlog_recordevent("gamecp_front_line", ["startx", startpos[0], "starty", startpos[1], "endx", endpos[0], "endy", endpos[1], "axis_centerx", _id_FABE25D5659F05A9[0], "axis_centery", _id_FABE25D5659F05A9[1], "allies_centerx", _id_C43D9EC2E9A839C6[0], "allies_centery", _id_C43D9EC2E9A839C6[1], "state", _id_E036BEB70DA584EC]);
}

logevent_gameobject(type, uniqueid, pos, ownerid, state) {
  if(!analyticslogenabled()) {
    return;
  }
  dlog_recordevent("gamecp_object", ["uniqueid", uniqueid, "x", pos[0], "y", pos[1], "z", pos[2], "ownerid", ownerid, "type", type, "state", state]);
}

logevent_message(ownerid, pos, message) {
  if(!analyticslogenabled()) {
    return;
  }
  dlog_recordevent("gamecp_message", ["ownerid", ownerid, "x", pos[0], "y", pos[1], "z", pos[2], "message", message]);
}

logevent_tag(message) {
  if(!analyticslogenabled()) {
    return;
  }
  bbprint("gamecp_matchtags", "message %s", message);
}

logevent_powerused(_id_DC34121B4BB07FB9, state) {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  _id_20AF753DED3657E1 = anglesToForward(self.angles);
  dlog_recordevent("gamecp_power", ["ownerid", self.analyticslog.playerid, "x", self.origin[0], "y", self.origin[1], "z", self.origin[2], "orientx", _id_20AF753DED3657E1[0], "orienty", _id_20AF753DED3657E1[1], "orientz", _id_20AF753DED3657E1[2], "type", _id_DC34121B4BB07FB9, "state", state]);
}

logevent_scoreupdate() {
  if(!shouldplayerlogevents(self)) {
    return;
  }
  _id_20AF753DED3657E1 = anglesToForward(self.angles);
  dlog_recordevent("gamecp_scoreboard", ["ownerid", self.analyticslog.playerid, "score", self.score]);
}

logevent_minimapcorners() {
  if(!analyticslogenabled()) {
    return;
  }
  _id_7BA521E5CC4CB125 = getEntArray("minimap_corner", "targetname");

  if(!isDefined(_id_7BA521E5CC4CB125) || _id_7BA521E5CC4CB125.size != 2) {
    return;
  }
  dlog_recordevent("gamecp_map", ["cornera_x", _id_7BA521E5CC4CB125[0].origin[0], "cornera_y", _id_7BA521E5CC4CB125[0].origin[1], "cornerb_x", _id_7BA521E5CC4CB125[1].origin[0], "cornerb_y", _id_7BA521E5CC4CB125[1].origin[1], "north", getnorthyaw()]);
}

logevent_assist(playerid, _id_79F00192DD16D2AC, weapon) {
  if(!analyticslogenabled()) {
    return;
  }
  dlog_recordevent("gamecp_assists", ["playerid", playerid, "server_death_id", _id_79F00192DD16D2AC, "weapon", weapon]);
}

getsantizedhealth() {
  return int(clamp(self.health, 0, 100000));
}

shouldplayerlogevents(player) {
  if(!analyticslogenabled())
    return 0;

  if(!isPlayer(player) || !isDefined(player.team) || player.team == "spectator" || player.sessionstate != "playing" && player.sessionstate != "dead")
    return 0;

  return 1;
}

logmatchtags() {
  _id_57191FDAEA1096DC = getDvar("scr_analytics_tag", "");

  if(_id_57191FDAEA1096DC != "")
    logevent_tag(_id_57191FDAEA1096DC);

  if(scripts\cp\utility::matchmakinggame())
    logevent_tag("OnlineMatch");
  else if(getdvarint("xblive_privatematch"))
    logevent_tag("PrivateMatch");
  else if(!getdvarint("onlinegame"))
    logevent_tag("OfflineMatch");
}

logevent_superended(_id_8F272B9312A01FC6, _id_0CD15FD5F49695B8, _id_9B9DBC948C253172, _id_464BC67340E2E2E9) {
  if(!analyticslogenabled()) {
    return;
  }
  _id_6698924DFF3AA2FC = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid))
    _id_6698924DFF3AA2FC = self.analyticslog.playerid;

  dlog_recordevent("analytics_mp_supers", ["super_name", _id_8F272B9312A01FC6, "time_to_use", _id_0CD15FD5F49695B8, "num_hits", _id_9B9DBC948C253172, "num_kills", _id_464BC67340E2E2E9, "player_id", _id_6698924DFF3AA2FC]);
}

logevent_superearned(_id_A119B718BF250DDE) {
  if(!analyticslogenabled()) {
    return;
  }
  _id_6698924DFF3AA2FC = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid))
    _id_6698924DFF3AA2FC = self.analyticslog.playerid;

  dlog_recordevent("analytics_mp_super_earned", ["match_time", _id_A119B718BF250DDE, "player_id", _id_6698924DFF3AA2FC]);
}

logevent_awardgained(_id_80919F898FFFB17E) {
  if(!analyticslogenabled()) {
    return;
  }
  dlog_recordevent("analytics_mp_awards", ["award_message", _id_80919F898FFFB17E]);
}

logevent_giveplayerxp(_id_814960839FF2DC12, _id_8FF4765EAC369993, _id_24134E683F793784, source) {
  if(!analyticslogenabled()) {
    return;
  }
  _id_6698924DFF3AA2FC = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid))
    _id_6698924DFF3AA2FC = self.analyticslog.playerid;

  dlog_recordevent("analytics_mp_player_xp", ["current_prestige", _id_814960839FF2DC12, "current_level", _id_8FF4765EAC369993, "xp_gained", _id_24134E683F793784, "xp_source", source, "player_id", _id_6698924DFF3AA2FC]);
}

logevent_givecpweaponxp(objweapon, _id_814960839FF2DC12, _id_8FF4765EAC369993, _id_24134E683F793784, source) {
  if(!analyticslogenabled()) {
    return;
  }
  _id_6698924DFF3AA2FC = -1;

  if(isDefined(self.analyticslog) && isDefined(self.analyticslog.playerid))
    _id_6698924DFF3AA2FC = self.analyticslog.playerid;

  weapon_name = getcompleteweaponname(objweapon);
  dlog_recordevent("analytics_mp_weapon_xp", ["weapon", weapon_name, "current_prestige", _id_814960839FF2DC12, "current_level", _id_8FF4765EAC369993, "xp_gained", _id_24134E683F793784, "xp_source", source, "player_id", _id_6698924DFF3AA2FC]);
}

logevent_sendplayerindexdata() {
  if(!analyticslogenabled()) {
    return;
  }
  _id_D6228DADA168A8A6 = [];
  _id_07866D1BB4718AC7 = [];
  _id_D12A341B40354143 = 0;

  for(_id_D12A341B40354143 = 0; _id_D12A341B40354143 < 12; _id_D12A341B40354143++) {
    _id_D6228DADA168A8A6[_id_D12A341B40354143] = 0;
    _id_07866D1BB4718AC7[_id_D12A341B40354143] = "";
  }

  _id_D12A341B40354143 = 0;

  foreach(player in level.players) {
    if(!isai(player)) {
      _id_D6228DADA168A8A6[_id_D12A341B40354143] = player.analyticslog.playerid;
      _id_07866D1BB4718AC7[_id_D12A341B40354143] = player getxuid();
    }

    _id_D12A341B40354143 = _id_D12A341B40354143 + 1;
  }

  dlog_recordevent("analytics_match_player_index_init", ["player1_index", _id_D6228DADA168A8A6[0], "player1_xuid", _id_07866D1BB4718AC7[0], "player2_index", _id_D6228DADA168A8A6[1], "player2_xuid", _id_07866D1BB4718AC7[1], "player3_index", _id_D6228DADA168A8A6[2], "player3_xuid", _id_07866D1BB4718AC7[2], "player4_index", _id_D6228DADA168A8A6[3], "player4_xuid", _id_07866D1BB4718AC7[3], "player5_index", _id_D6228DADA168A8A6[4], "player5_xuid", _id_07866D1BB4718AC7[4], "player6_index", _id_D6228DADA168A8A6[5], "player6_xuid", _id_07866D1BB4718AC7[5], "player7_index", _id_D6228DADA168A8A6[6], "player7_xuid", _id_07866D1BB4718AC7[6], "player8_index", _id_D6228DADA168A8A6[7], "player8_xuid", _id_07866D1BB4718AC7[7], "player9_index", _id_D6228DADA168A8A6[8], "player9_xuid", _id_07866D1BB4718AC7[8], "player10_index", _id_D6228DADA168A8A6[9], "player10_xuid", _id_07866D1BB4718AC7[9], "player11_index", _id_D6228DADA168A8A6[10], "player11_xuid", _id_07866D1BB4718AC7[10], "player12_index", _id_D6228DADA168A8A6[11], "player12_xuid", _id_07866D1BB4718AC7[11]]);
}

analyticsspawnlogenabled() {
  return getdvarint("enable_analytics_spawn_log");
}

logevent_xpearned(player, _id_5746D9F038B58234, weaponname, _id_CC603E175ABFEF2D, source) {
  if(!isPlayer(player)) {
    return;
  }
  if(_func_D03495FE6418377B(source))
    source = _func_0F28FD66285FA2C9(source);

  _id_238978CE0BF4DDB7 = player _id_032900C5A73179B4();
  _id_38A956B2D0941D07 = level.active_objectives_string;
  player dlog_recordplayerevent("dlog_event_cpdata_plr_xp_earned", ["levelname", level.script, "player_xp_earned", _id_5746D9F038B58234, "weapon", weaponname, "weapon_xp_earned", _id_CC603E175ABFEF2D, "xp_source", source, "player_kit", player _id_5E5507D57BBBB709::_id_CAB56589FD214C7E(), "current_beat", _id_238978CE0BF4DDB7, "active_objective", _id_38A956B2D0941D07]);
}

logevent_munitionused(player, _id_5A8F1ACCEC64DC4A) {
  if(!isPlayer(player)) {
    return;
  }
  _id_238978CE0BF4DDB7 = player _id_032900C5A73179B4();
  [_id_CDEFFC78F53D38AE, _id_CDEB7878F538208B, _id_CDF8E878F5472B60] = player _id_72D38B83FC04EE8E();
  _id_38A956B2D0941D07 = level.active_objectives_string;
  player dlog_recordplayerevent("dlog_event_cpdata_plr_munition_used", ["levelname", level.script, "playername", player.name, "x1", _id_CDEFFC78F53D38AE, "y1", _id_CDEB7878F538208B, "z1", _id_CDF8E878F5472B60, "munition", _id_5A8F1ACCEC64DC4A, "player_kit", player _id_5E5507D57BBBB709::_id_CAB56589FD214C7E(), "current_beat", _id_238978CE0BF4DDB7, "active_objective", _id_38A956B2D0941D07]);
}

logevent_superused(player, _id_8F272B9312A01FC6) {
  if(!isPlayer(player)) {
    return;
  }
  _id_0D4C90180F6E4B32 = level.script;
  _id_81A6DCF8641471F7 = player.name;
  [_id_CDEFFC78F53D38AE, _id_CDEB7878F538208B, _id_CDF8E878F5472B60] = player _id_72D38B83FC04EE8E();
  _id_38A956B2D0941D07 = level.active_objectives_string;
  _id_FA619D8864890F1B = player _id_5E5507D57BBBB709::_id_CAB56589FD214C7E();
  _id_238978CE0BF4DDB7 = player _id_032900C5A73179B4();
  player dlog_recordplayerevent("dlog_event_cpdata_plr_super_used", ["levelname", _id_0D4C90180F6E4B32, "playername", _id_81A6DCF8641471F7, "x1", _id_CDEFFC78F53D38AE, "y1", _id_CDEB7878F538208B, "z1", _id_CDF8E878F5472B60, "player_kit", _id_FA619D8864890F1B, "super", _id_8F272B9312A01FC6, "current_beat", _id_238978CE0BF4DDB7, "active_objective", _id_38A956B2D0941D07]);
}

logevent_kidnapevent(player, _id_856629B6525C0882) {
  if(!isPlayer(player)) {
    return;
  }
  player dlog_recordplayerevent("dlog_event_cpdata_plr_kidnapper", ["levelname", level.script, "version", _id_856629B6525C0882, "times_kidnapped", player.times_kidnapped, "active_objective", level.active_objectives_string, "player_kit", player _id_5E5507D57BBBB709::_id_CAB56589FD214C7E()]);
}

logevent_spawnviateamrevive(player) {
  if(!isPlayer(player)) {
    return;
  }
  _id_238978CE0BF4DDB7 = player _id_032900C5A73179B4();
  player dlog_recordplayerevent("dlog_event_cpdata_plr_spawn_via_teamrevive", ["levelname", level.script, "last_stand_id", get_last_stand_id(player), "current_beat", _id_238978CE0BF4DDB7, "sharedaccount_uid", player _id_512417BDDBE63792(), "player_kit", player _id_5E5507D57BBBB709::_id_CAB56589FD214C7E()]);
}

logevent_spawnviaautorevive(player) {
  if(!isPlayer(player)) {
    return;
  }
  _id_238978CE0BF4DDB7 = player _id_032900C5A73179B4();
  [_id_CDEFFC78F53D38AE, _id_CDEB7878F538208B, _id_CDF8E878F5472B60] = player _id_72D38B83FC04EE8E();
  _id_38A956B2D0941D07 = level.active_objectives_string;
  player dlog_recordplayerevent("dlog_event_cpdata_plr_spawn_via_autorevive", ["levelname", level.script, "last_stand_id", get_last_stand_id(player), "revivee", player.name, "x1", _id_CDEFFC78F53D38AE, "y1", _id_CDEB7878F538208B, "z1", _id_CDF8E878F5472B60, "player_kit", player _id_5E5507D57BBBB709::_id_CAB56589FD214C7E(), "sharedaccount_uid", player _id_512417BDDBE63792(), "current_beat", _id_238978CE0BF4DDB7, "active_objective", _id_38A956B2D0941D07]);
}

logevent_spawnviaplayer(player, reviver) {
  if(!isPlayer(player)) {
    return;
  }
  _id_238978CE0BF4DDB7 = player _id_032900C5A73179B4();
  [_id_CDEFFC78F53D38AE, _id_CDEB7878F538208B, _id_CDF8E878F5472B60] = player _id_72D38B83FC04EE8E();
  _id_38A956B2D0941D07 = level.active_objectives_string;
  player dlog_recordplayerevent("dlog_event_cpdata_plr_spawn_via_player", ["levelname", level.script, "last_stand_id", get_last_stand_id(player), "revivee", player.name, "reviver", reviver.name, "x1", _id_CDEFFC78F53D38AE, "y1", _id_CDEB7878F538208B, "z1", _id_CDF8E878F5472B60, "player_kit", player _id_5E5507D57BBBB709::_id_CAB56589FD214C7E(), "sharedaccount_uid", player _id_512417BDDBE63792(), "current_beat", _id_238978CE0BF4DDB7, "active_objective", _id_38A956B2D0941D07]);
}

logevent_kill(eattacker, enemy, sweapon) {
  if(!isPlayer(eattacker)) {
    return;
  }
  _id_C1C7D2DD795C6B89 = scripts\engine\utility::ter_op(isPlayer(enemy), enemy.name, enemy.agent_type);
  _id_C3AAD4B99D152F24 = scripts\engine\utility::ter_op(isPlayer(eattacker), eattacker.name, eattacker.agent_type);
  _id_238978CE0BF4DDB7 = eattacker _id_032900C5A73179B4(eattacker, enemy, sweapon);
  [_id_CDEFFC78F53D38AE, _id_CDEB7878F538208B, _id_CDF8E878F5472B60] = eattacker _id_72D38B83FC04EE8E();
  [_id_CDEFFB78F53D367B, _id_CDEB7978F53822BE, _id_CDF8EB78F54731F9] = enemy _id_72D38B83FC04EE8E();
  _id_38A956B2D0941D07 = level.active_objectives_string;
  eattacker dlog_recordplayerevent("dlog_event_cpdata_plr_combat", ["levelname", level.script, "stat_type", "Killed", "attacker", _id_C3AAD4B99D152F24, "x1", _id_CDEFFC78F53D38AE, "y1", _id_CDEB7878F538208B, "z1", _id_CDF8E878F5472B60, "enemy", _id_C1C7D2DD795C6B89, "x2", _id_CDEFFB78F53D367B, "y2", _id_CDEB7978F53822BE, "z2", _id_CDF8EB78F54731F9, "weapon", sweapon.basename, "player_kit", eattacker _id_5E5507D57BBBB709::_id_CAB56589FD214C7E(), "sharedaccount_uid", eattacker _id_512417BDDBE63792(), "current_beat", _id_238978CE0BF4DDB7, "active_objective", _id_38A956B2D0941D07]);
}

_id_032900C5A73179B4(eattacker, enemy, sweapon) {
  _id_B7BC529921E4AD54 = "";

  if(isDefined(level._id_F42102B6DE7CE00D))
    _id_B7BC529921E4AD54 = self[[level._id_F42102B6DE7CE00D]](eattacker, enemy, sweapon);
  else {
    _id_3C269C416D082FF1 = scripts\cp\utility::_id_6721512A3AFF2E3B();

    if(isDefined(_id_3C269C416D082FF1))
      _id_B7BC529921E4AD54 = _id_3C269C416D082FF1;
  }

  return _id_B7BC529921E4AD54;
}

_id_87D1AFFA098EA2E4() {
  if(getdvarint("dvar_E6D511D33E0FE486")) {
    _id_BCA06D97FAE92128 = _id_512417BDDBE63792();
    _id_B200F33418465746(_id_BCA06D97FAE92128 + 1);
  }
}

_id_512417BDDBE63792() {
  return self getplayerdata("cp", "sharedAccountID");
}

_id_B200F33418465746(value) {
  return self setplayerdata("cp", "sharedAccountID", value);
}

logevent_downed(player, enemy) {
  if(!isPlayer(player)) {
    return;
  }
  update_last_stand_id(player);

  if(isagent(enemy)) {
    if(isDefined(enemy.agent_type))
      _id_742C9CA4175A2518 = enemy.agent_type;
    else
      _id_742C9CA4175A2518 = "undefined agent_type";
  } else
    _id_742C9CA4175A2518 = player.name;

  _id_81A6DCF8641471F7 = player.name;
  _id_238978CE0BF4DDB7 = player _id_032900C5A73179B4();
  _id_841E07BE2EDA74B2 = player _id_512417BDDBE63792();
  _id_FA619D8864890F1B = player _id_5E5507D57BBBB709::_id_CAB56589FD214C7E();
  [_id_CDEFFC78F53D38AE, _id_CDEB7878F538208B, _id_CDF8E878F5472B60] = player _id_72D38B83FC04EE8E();
  _id_F3615C347ADC7D7A = get_last_stand_id(player);
  _id_38A956B2D0941D07 = level.active_objectives_string;
  player dlog_recordplayerevent("dlog_event_cpdata_plr_downed", ["levelname", level.script, "playername", _id_81A6DCF8641471F7, "enemy", _id_742C9CA4175A2518, "last_stand_id", _id_F3615C347ADC7D7A, "x1", _id_CDEFFC78F53D38AE, "y1", _id_CDEB7878F538208B, "z1", _id_CDF8E878F5472B60, "player_kit", _id_FA619D8864890F1B, "sharedaccount_uid", _id_841E07BE2EDA74B2, "current_beat", _id_238978CE0BF4DDB7, "active_objective", _id_38A956B2D0941D07]);
}

_id_72D38B83FC04EE8E() {
  x = scripts\engine\math::round_float(self.origin[0], 2);
  y = scripts\engine\math::round_float(self.origin[1], 2);
  z = scripts\engine\math::round_float(self.origin[2], 2);
  return [x, y, z];
}

update_last_stand_id(player) {
  if(!isDefined(player.laststandid))
    player.laststandid = 0;
  else
    player.laststandid++;

  return player.laststandid;
}

get_last_stand_id(player) {
  return player.laststandid;
}

_id_54204F27964FDDCF(player, _id_348E01A03A06D124, _id_0AC71726B8DD320A) {
  _id_238978CE0BF4DDB7 = _id_032900C5A73179B4();
  _id_81A6DCF8641471F7 = player.name;
  _id_841E07BE2EDA74B2 = player _id_512417BDDBE63792();
  _id_FA619D8864890F1B = player _id_5E5507D57BBBB709::_id_CAB56589FD214C7E();
  _id_38A956B2D0941D07 = level.active_objectives_string;
  [_id_CDEFFC78F53D38AE, _id_CDEB7878F538208B, _id_CDF8E878F5472B60] = player _id_72D38B83FC04EE8E();
  dlog_recordevent("dlog_event_cpdata_shop_purchase", ["levelname", level.script, "playername", _id_81A6DCF8641471F7, "x1", _id_CDEFFC78F53D38AE, "y1", _id_CDEB7878F538208B, "z1", _id_CDF8E878F5472B60, "purchased_item", _id_348E01A03A06D124, "purchase_cost", _id_0AC71726B8DD320A, "active_objective", _id_38A956B2D0941D07, "player_kit", _id_FA619D8864890F1B, "current_beat", _id_238978CE0BF4DDB7, "sharedaccount_uid", _id_841E07BE2EDA74B2]);
}

_id_BFE1744EF18F30F9(_id_9F1A28D4CBE0A89E) {
  description = "Trigger Hit";

  if(isDefined(_id_9F1A28D4CBE0A89E))
    description = _id_9F1A28D4CBE0A89E;

  _id_238978CE0BF4DDB7 = _id_032900C5A73179B4();
  _id_38A956B2D0941D07 = level.active_objectives_string;
  dlog_recordevent("dlog_event_cpdata_trigger_hit", ["levelname", level.script, "time_stamp", gettime(), "description", description, "current_beat", _id_238978CE0BF4DDB7, "active_objective", _id_38A956B2D0941D07]);
}

_id_0AE955CCDEF747B0(_id_38A956B2D0941D07, _id_1F7013B2C9380FA5, _id_6065911857870EAC) {
  if(!isDefined(_id_38A956B2D0941D07)) {
    return;
  }
  level._id_30871F40B5BCC61C[_id_38A956B2D0941D07] = 1;
  description = "Started";

  if(isDefined(_id_6065911857870EAC))
    description = _id_6065911857870EAC;

  _id_238978CE0BF4DDB7 = _id_032900C5A73179B4();
  dlog_recordevent("dlog_event_cpdata_level_progression", ["levelname", level.script, "time_stamp", gettime(), "description", description, "current_beat", _id_238978CE0BF4DDB7, "active_objective", _id_38A956B2D0941D07]);

  if(istrue(_id_1F7013B2C9380FA5)) {
    return;
  }
  level thread _id_467F0FDFDD155A45::_id_A8A9D2FB0FEAF8EB(_id_38A956B2D0941D07);
}

_id_B6283AC45A607764(_id_256D0E44EE22C83C, _id_6065911857870EAC) {
  if(!isDefined(level._id_30871F40B5BCC61C[_id_256D0E44EE22C83C])) {
    return;
  }
  level._id_30871F40B5BCC61C[_id_256D0E44EE22C83C] = undefined;
  status = "Completed";

  if(isDefined(_id_6065911857870EAC))
    status = _id_6065911857870EAC;

  _id_238978CE0BF4DDB7 = _id_032900C5A73179B4();
  dlog_recordevent("dlog_event_cpdata_level_progression", ["levelname", level.script, "time_stamp", gettime(), "description", status, "current_beat", _id_238978CE0BF4DDB7, "active_objective", _id_256D0E44EE22C83C]);
  _id_467F0FDFDD155A45::_id_1D10F2E8A8DE2799(_id_256D0E44EE22C83C);
}