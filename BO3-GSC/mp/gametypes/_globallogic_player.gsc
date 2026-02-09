/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\gametypes\_globallogic_player.gsc
*************************************************/

#using scripts\mp\_armor;
#using scripts\mp\_behavior_tracker;
#using scripts\mp\_challenges;
#using scripts\mp\_contracts;
#using scripts\mp\_gamerep;
#using scripts\mp\_laststand;
#using scripts\mp\_teamops;
#using scripts\mp\_util;
#using scripts\mp\_vehicle;
#using scripts\mp\gametypes\_battlechatter;
#using scripts\mp\gametypes\_deathicons;
#using scripts\mp\gametypes\_globallogic;
#using scripts\mp\gametypes\_globallogic_audio;
#using scripts\mp\gametypes\_globallogic_score;
#using scripts\mp\gametypes\_globallogic_spawn;
#using scripts\mp\gametypes\_globallogic_ui;
#using scripts\mp\gametypes\_globallogic_utils;
#using scripts\mp\gametypes\_globallogic_vehicle;
#using scripts\mp\gametypes\_hostmigration;
#using scripts\mp\gametypes\_hud_message;
#using scripts\mp\gametypes\_killcam;
#using scripts\mp\gametypes\_loadout;
#using scripts\mp\gametypes\_spawning;
#using scripts\mp\gametypes\_spawnlogic;
#using scripts\mp\gametypes\_spectating;
#using scripts\mp\gametypes\_weapons;
#using scripts\mp\killstreaks\_killstreaks;
#using scripts\mp\teams\_teams;
#using scripts\shared\_burnplayer;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\abilities\_ability_power;
#using scripts\shared\abilities\_ability_util;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\callbacks_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\damagefeedback_shared;
#using scripts\shared\demo_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\hostmigration_shared;
#using scripts\shared\hud_message_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\killstreaks_shared;
#using scripts\shared\math_shared;
#using scripts\shared\medals_shared;
#using scripts\shared\persistence_shared;
#using scripts\shared\player_shared;
#using scripts\shared\rank_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\tweakables_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weapon_utils;
#using scripts\shared\weapons\_weapons;
#using scripts\shared\weapons_shared;
#namespace globallogic_player;

function on_joined_team() {
  if(!level.rankedmatch && !level.teambased) {
    level thread update_ffa_top_scorers();
  }
}

function freezeplayerforroundend() {
  self util::clearlowermessage();
  self closeingamemenu();
  self util::freeze_player_controls(1);
  if(!sessionmodeiszombiesgame()) {
    currentweapon = self getcurrentweapon();
    if(killstreaks::is_killstreak_weapon(currentweapon) && !currentweapon.iscarriedkillstreak) {
      self takeweapon(currentweapon);
    }
  }
}

function arraytostring(inputarray) {
  targetstring = "";
  for(i = 0; i < inputarray.size; i++) {
    targetstring = targetstring + inputarray[i];
    if(i != (inputarray.size - 1)) {
      targetstring = targetstring + ",";
    }
  }
  return targetstring;
}

function recordendgamecomscoreeventforplayer(player, result) {
  lpselfnum = player getentitynumber();
  lpxuid = player getxuid(1);
  bbprint("global_leave", "name %s client %s xuid %s", player.name, lpselfnum, lpxuid);
  weeklyacontractid = 0;
  weeklyacontracttarget = 0;
  weeklyacontractcurrent = 0;
  weeklyacontractcompleted = 0;
  weeklybcontractid = 0;
  weeklybcontracttarget = 0;
  weeklybcontractcurrent = 0;
  weeklybcontractcompleted = 0;
  dailycontractid = 0;
  dailycontracttarget = 0;
  dailycontractcurrent = 0;
  dailycontractcompleted = 0;
  specialcontractid = 0;
  specialcontracttarget = 0;
  specialcontractcurent = 0;
  specialcontractcompleted = 0;
  if(player util::is_bot()) {
    currxp = 0;
    prevxp = 0;
  } else {
    currxp = player rank::getrankxpstat();
    prevxp = player.pers["rankxp"];
    if(globallogic_score::canupdateweaponcontractstats(player)) {
      specialcontractid = 1;
      specialcontracttarget = getdvarint("weapon_contract_target_value", 100);
      specialcontractcurent = player getdstat("weaponContractData", "currentValue");
      if((isDefined(player getdstat("weaponContractData", "completeTimestamp")) ? player getdstat("weaponContractData", "completeTimestamp") : 0) != 0) {
        specialcontractcompleted = 1;
      }
    }
    if(player contracts::can_process_contracts()) {
      contractid = player contracts::get_contract_stat(0, "index");
      if(player contracts::is_contract_active(contractid)) {
        weeklyacontractid = contractid;
        weeklyacontracttarget = player.pers["contracts"][weeklyacontractid].target_value;
        weeklyacontractcurrent = player contracts::get_contract_stat(0, "progress");
        weeklyacontractcompleted = player contracts::get_contract_stat(0, "award_given");
      }
      contractid = player contracts::get_contract_stat(1, "index");
      if(player contracts::is_contract_active(contractid)) {
        weeklybcontractid = contractid;
        weeklybcontracttarget = player.pers["contracts"][weeklybcontractid].target_value;
        weeklybcontractcurrent = player contracts::get_contract_stat(1, "progress");
        weeklybcontractcompleted = player contracts::get_contract_stat(1, "award_given");
      }
      contractid = player contracts::get_contract_stat(2, "index");
      if(player contracts::is_contract_active(contractid)) {
        dailycontractid = contractid;
        dailycontracttarget = player.pers["contracts"][dailycontractid].target_value;
        dailycontractcurrent = player contracts::get_contract_stat(2, "progress");
        dailycontractcompleted = player contracts::get_contract_stat(2, "award_given");
      }
    }
  }
  if(!isDefined(prevxp)) {
    return;
  }
  resultstr = result;
  if(isDefined(player.team) && result == player.team) {
    resultstr = "win";
  } else if(result == "allies" || result == "axis") {
    resultstr = "lose";
  }
  xpearned = currxp - prevxp;
  perkstr = arraytostring(player getperks());
  primaryweaponname = "";
  primaryweaponattachstr = "";
  secondaryweaponname = "";
  secondaryweaponattachstr = "";
  grenadeprimaryname = "";
  grenadesecondaryname = "";
  if(isDefined(player.primaryloadoutweapon)) {
    primaryweaponname = player.primaryloadoutweapon.name;
    primaryweaponattachstr = arraytostring(getarraykeys(player.primaryloadoutweapon.attachments));
  }
  if(isDefined(player.secondaryloadoutweapon)) {
    secondaryweaponname = player.secondaryloadoutweapon.name;
    secondaryweaponattachstr = arraytostring(getarraykeys(player.secondaryloadoutweapon.attachments));
  }
  if(isDefined(player.grenadetypeprimary)) {
    grenadeprimaryname = player.grenadetypeprimary.name;
  }
  if(isDefined(player.grenadetypesecondary)) {
    grenadesecondaryname = player.grenadetypesecondary.name;
  }
  killstreakstr = arraytostring(player.killstreak);
  gamelength = game["timepassed"] / 1000;
  timeplayed = player globallogic::gettotaltimeplayed(gamelength);
  totalkills = 0;
  totalhits = 0;
  totaldeaths = 0;
  totalwins = 0;
  totalxp = 0;
  if(level.gametype != "fr") {
    totalkills = player getdstat("playerstatslist", "kills", "statValue");
    totalhits = player getdstat("playerstatslist", "hits", "statValue");
    totaldeaths = player getdstat("playerstatslist", "deaths", "statValue");
    totalwins = player getdstat("playerstatslist", "wins", "statValue");
    totalxp = player getdstat("playerstatslist", "rankxp", "statValue");
  }
  killcount = 0;
  hitcount = 0;
  if(level.mpcustommatch) {
    killcount = player.kills;
    hitcount = player.shotshit;
  } else {
    if(isDefined(player.startkills)) {
      killcount = totalkills - player.startkills;
    }
    if(isDefined(player.starthits)) {
      hitcount = totalhits - player.starthits;
    }
  }
  bestscore = "0";
  if(isDefined(player.pers["lastHighestScore"]) && player.score > player.pers["lastHighestScore"]) {
    bestscore = "1";
  }
  bestkills = "0";
  if(isDefined(player.pers["lastHighestKills"]) && killcount > player.pers["lastHighestKills"]) {
    bestkills = "1";
  }
  totalmatchshots = 0;
  if(isDefined(player.totalmatchshots)) {
    totalmatchshots = player.totalmatchshots;
  }
  deaths = player.deaths;
  if(deaths == 0) {
    deaths = 1;
  }
  kdratio = (player.kills * 1000) / deaths;
  bestkdratio = "0";
  if(isDefined(player.pers["lastHighestKDRatio"]) && kdratio > player.pers["lastHighestKDRatio"]) {
    bestkdratio = "1";
  }
  showcaseweapon = player getplayershowcaseweapon();
  recordcomscoreevent("end_match", "match_id", getdemofileid(), "game_variant", "mp", "game_mode", level.gametype, "private_match", sessionmodeisprivate(), "esports_flag", level.leaguematch, "ranked_play_flag", level.arenamatch, "league_team_id", player getleagueteamid(), "game_map", getdvarstring("mapname"), "player_xuid", player getxuid(1), "player_ip", player getipaddress(), "match_kills", killcount, "match_deaths", player.deaths, "match_xp", xpearned, "match_score", player.score, "match_streak", player.pers["best_kill_streak"], "match_captures", player.pers["captures"], "match_defends", player.pers["defends"], "match_headshots", player.pers["headshots"], "match_longshots", player.pers["longshots"], "match_objtime", player.pers["objtime"], "match_plants", player.pers["plants"], "match_defuses", player.pers["defuses"], "match_throws", player.pers["throws"], "match_carries", player.pers["carries"], "match_returns", player.pers["returns"], "prestige_max", player.pers["plevel"], "level_max", player.pers["rank"], "match_result", resultstr, "match_duration", timeplayed, "match_shots", totalmatchshots, "match_hits", hitcount, "player_gender", player getplayergendertype(currentsessionmode()), "specialist_kills", player.heroweaponkillcount, "specialist_used", player getmpdialogname(), "season_pass_owned", player hasseasonpass(0), "loadout_perks", perkstr, "loadout_lethal", grenadeprimaryname, "loadout_tactical", grenadesecondaryname, "loadout_scorestreaks", killstreakstr, "loadout_primary_weapon", primaryweaponname, "loadout_secondary_weapon", secondaryweaponname, "dlc_owned", player getdlcavailable(), "loadout_primary_attachments", primaryweaponattachstr, "loadout_secondary_attachments", secondaryweaponattachstr, "best_score", bestscore, "best_kills", bestkills, "best_kd", bestkdratio, "total_kills", totalkills, "total_deaths", totaldeaths, "total_wins", totalwins, "total_xp", totalxp, "daily_contract_id", dailycontractid, "daily_contract_target", dailycontracttarget, "daily_contract_current", dailycontractcurrent, "daily_contract_completed", dailycontractcompleted, "weeklyA_contract_id", weeklyacontractid, "weeklyA_contract_target", weeklyacontracttarget, "weeklyA_contract_current", weeklyacontractcurrent, "weeklyA_contract_completed", weeklyacontractcompleted, "weeklyB_contract_id", weeklybcontractid, "weeklyB_contract_target", weeklybcontracttarget, "weeklyB_contract_current", weeklybcontractcurrent, "weeklyB_contract_completed", weeklybcontractcompleted, "special_contract_id ", specialcontractid, "special_contract_target", specialcontracttarget, "special_contract_curent", specialcontractcurent, "special_contract_completed", specialcontractcompleted, "specialist_power", player.heroabilityname, "specialist_head", player getcharacterhelmetmodel(), "specialist_body", player getcharacterbodymodel(), "specialist_taunt", player getplayerselectedtauntname(0), "specialist_goodgame", player getplayerselectedgesturename(0), "specialist_threaten", player getplayerselectedgesturename(1), "specialist_boast", player getplayerselectedgesturename(2), "specialist_showcase", showcaseweapon.weapon.name);
}

function player_monitor_travel_dist() {
  self endon("death");
  self endon("disconnect");
  waittime = 1;
  minimummovedistance = 16;
  wait(4);
  prevpos = self.origin;
  positionptm = self.origin;
  while(true) {
    wait(waittime);
    if(self util::isusingremote()) {
      self waittill("stopped_using_remote");
      prevpos = self.origin;
      positionptm = self.origin;
      continue;
    }
    distance = distance(self.origin, prevpos);
    self.pers["total_distance_travelled"] = self.pers["total_distance_travelled"] + distance;
    self.pers["movement_Update_Count"]++;
    prevpos = self.origin;
    if((self.pers["movement_Update_Count"] % 5) == 0) {
      distancemoving = distance(self.origin, positionptm);
      positionptm = self.origin;
      if(distancemoving > minimummovedistance) {
        self.pers["num_speeds_when_moving_entries"]++;
        self.pers["total_speeds_when_moving"] = self.pers["total_speeds_when_moving"] + (distancemoving / waittime);
        self.pers["time_played_moving"] = self.pers["time_played_moving"] + waittime;
      }
    }
  }
}

function record_special_move_data_for_life(killer) {
  if(!isDefined(self.lastswimmingstarttime) || !isDefined(self.lastwallrunstarttime) || !isDefined(self.lastslidestarttime) || !isDefined(self.lastdoublejumpstarttime) || !isDefined(self.timespentswimminginlife) || !isDefined(self.timespentwallrunninginlife) || !isDefined(self.numberofdoublejumpsinlife) || !isDefined(self.numberofslidesinlife)) {
    println("");
    return;
  }
  if(isDefined(killer)) {
    if(!isDefined(killer.lastswimmingstarttime) || !isDefined(killer.lastwallrunstarttime) || !isDefined(killer.lastslidestarttime) || !isDefined(killer.lastdoublejumpstarttime)) {
      println("");
      return;
    }
    matchrecordlogspecialmovedataforlife(self, self.lastswimmingstarttime, self.lastwallrunstarttime, self.lastslidestarttime, self.lastdoublejumpstarttime, self.timespentswimminginlife, self.timespentwallrunninginlife, self.numberofdoublejumpsinlife, self.numberofslidesinlife, killer, killer.lastswimmingstarttime, killer.lastwallrunstarttime, killer.lastslidestarttime, killer.lastdoublejumpstarttime);
  } else {
    matchrecordlogspecialmovedataforlife(self, self.lastswimmingstarttime, self.lastwallrunstarttime, self.lastslidestarttime, self.lastdoublejumpstarttime, self.timespentswimminginlife, self.timespentwallrunninginlife, self.numberofdoublejumpsinlife, self.numberofslidesinlife);
  }
}

function player_monitor_wall_run() {
  self endon("disconnect");
  self notify("stop_player_monitor_wall_run");
  self endon("stop_player_monitor_wall_run");
  self.lastwallrunstarttime = 0;
  self.timespentwallrunninginlife = 0;
  while(true) {
    notification = self util::waittill_any_return("wallrun_begin", "death", "disconnect", "stop_player_monitor_wall_run");
    if(notification == "death") {
      break;
    }
    self.lastwallrunstarttime = gettime();
    notification = self util::waittill_any_return("wallrun_end", "death", "disconnect", "stop_player_monitor_wall_run");
    self.timespentwallrunninginlife = self.timespentwallrunninginlife + (gettime() - self.lastwallrunstarttime);
    if(notification == "death") {
      break;
    }
  }
}

function player_monitor_swimming() {
  self endon("disconnect");
  self notify("stop_player_monitor_swimming");
  self endon("stop_player_monitor_swimming");
  self.lastswimmingstarttime = 0;
  self.timespentswimminginlife = 0;
  while(true) {
    notification = self util::waittill_any_return("swimming_begin", "death", "disconnect", "stop_player_monitor_swimming");
    if(notification == "death") {
      break;
    }
    self.lastswimmingstarttime = gettime();
    notification = self util::waittill_any_return("swimming_end", "death", "disconnect", "stop_player_monitor_swimming");
    self.timespentswimminginlife = self.timespentswimminginlife + (gettime() - self.lastswimmingstarttime);
    if(notification == "death") {
      break;
    }
  }
}

function player_monitor_slide() {
  self endon("disconnect");
  self notify("stop_player_monitor_slide");
  self endon("stop_player_monitor_slide");
  self.lastslidestarttime = 0;
  self.numberofslidesinlife = 0;
  while(true) {
    notification = self util::waittill_any_return("slide_begin", "death", "disconnect", "stop_player_monitor_slide");
    if(notification == "death") {
      break;
    }
    self.lastslidestarttime = gettime();
    self.numberofslidesinlife++;
    notification = self util::waittill_any_return("slide_end", "death", "disconnect", "stop_player_monitor_slide");
    if(notification == "death") {
      break;
    }
  }
}

function player_monitor_doublejump() {
  self endon("disconnect");
  self notify("stop_player_monitor_doublejump");
  self endon("stop_player_monitor_doublejump");
  self.lastdoublejumpstarttime = 0;
  self.numberofdoublejumpsinlife = 0;
  while(true) {
    notification = self util::waittill_any_return("doublejump_begin", "death", "disconnect", "stop_player_monitor_doublejump");
    if(notification == "death") {
      break;
    }
    self.lastdoublejumpstarttime = gettime();
    self.numberofdoublejumpsinlife++;
    notification = self util::waittill_any_return("doublejump_end", "death", "disconnect", "stop_player_monitor_doublejump");
    if(notification == "death") {
      break;
    }
  }
}

function player_monitor_inactivity() {
  self endon("disconnect");
  self notify("player_monitor_inactivity");
  self endon("player_monitor_inactivity");
  wait(10);
  while(true) {
    if(isDefined(self)) {
      if(self isremotecontrolling() || self util::isusingremote()) {
        self resetinactivitytimer();
      }
    }
    wait(5);
  }
}

function callback_playerconnect() {
  thread notifyconnecting();
  self.statusicon = "hud_status_connecting";
  self waittill("begin");
  if(isDefined(level.reset_clientdvars)) {
    self[[level.reset_clientdvars]]();
  }
  waittillframeend();
  self.statusicon = "";
  self.guid = self getguid();
  self.killstreak = [];
  self.leaderdialogqueue = [];
  self.killstreakdialogqueue = [];
  profilelog_begintiming(4, "ship");
  level notify("connected", self);
  callback::callback("hash_eaffea17");
  if(self ishost()) {
    self thread globallogic::listenforgameend();
  }
  if(!level.splitscreen && !isDefined(self.pers["score"])) {
    iprintln(&"MP_CONNECTED", self);
  }
  if(!isDefined(self.pers["score"])) {
    self thread persistence::adjust_recent_stats();
    self persistence::set_after_action_report_stat("valid", 0);
    if(gamemodeismode(3) && !self ishost()) {
      self persistence::set_after_action_report_stat("wagerMatchFailed", 1);
    } else {
      self persistence::set_after_action_report_stat("wagerMatchFailed", 0);
    }
  }
  if(level.rankedmatch || level.wagermatch || level.leaguematch && !isDefined(self.pers["matchesPlayedStatsTracked"])) {
    gamemode = util::getcurrentgamemode();
    self globallogic::incrementmatchcompletionstat(gamemode, "played", "started");
    if(!isDefined(self.pers["matchesHostedStatsTracked"]) && self islocaltohost()) {
      self globallogic::incrementmatchcompletionstat(gamemode, "hosted", "started");
      self.pers["matchesHostedStatsTracked"] = 1;
    }
    self.pers["matchesPlayedStatsTracked"] = 1;
    self thread persistence::upload_stats_soon();
  }
  self gamerep::gamerepplayerconnected();
  lpselfnum = self getentitynumber();
  lpguid = self getguid();
  lpxuid = self getxuid(1);
  logprint(((((("" + lpguid) + "") + lpselfnum) + "") + self.name) + "");
  bbprint("global_joins", "name %s client %s xuid %s", self.name, lpselfnum, lpxuid);
  recordplayerstats(self, "codeClientNum", lpselfnum);
  if(!sessionmodeiszombiesgame()) {
    self setclientuivisibilityflag("hud_visible", 1);
    self setclientuivisibilityflag("weapon_hud_visible", 1);
  }
  self setclientplayersprinttime(level.playersprinttime);
  self setclientnumlives(level.numlives);
  if(level.hardcoremode) {
    self setclientdrawtalk(3);
  }
  if(sessionmodeiszombiesgame()) {
    self[[level.player_stats_init]]();
  } else {
    self globallogic_score::initpersstat("score");
    if(level.resetplayerscoreeveryround) {
      self.pers["score"] = 0;
    }
    self.score = self.pers["score"];
    self globallogic_score::initpersstat("pointstowin");
    if(level.scoreroundwinbased) {
      self.pers["pointstowin"] = 0;
    }
    self.pointstowin = self.pers["pointstowin"];
    self globallogic_score::initpersstat("momentum", 0);
    self.momentum = self globallogic_score::getpersstat("momentum");
    self globallogic_score::initpersstat("suicides");
    self.suicides = self globallogic_score::getpersstat("suicides");
    self globallogic_score::initpersstat("headshots");
    self.headshots = self globallogic_score::getpersstat("headshots");
    self globallogic_score::initpersstat("challenges");
    self.challenges = self globallogic_score::getpersstat("challenges");
    self globallogic_score::initpersstat("kills");
    self.kills = self globallogic_score::getpersstat("kills");
    self globallogic_score::initpersstat("deaths");
    self.deaths = self globallogic_score::getpersstat("deaths");
    self globallogic_score::initpersstat("assists");
    self.assists = self globallogic_score::getpersstat("assists");
    self globallogic_score::initpersstat("defends", 0);
    self.defends = self globallogic_score::getpersstat("defends");
    self globallogic_score::initpersstat("offends", 0);
    self.offends = self globallogic_score::getpersstat("offends");
    self globallogic_score::initpersstat("plants", 0);
    self.plants = self globallogic_score::getpersstat("plants");
    self globallogic_score::initpersstat("defuses", 0);
    self.defuses = self globallogic_score::getpersstat("defuses");
    self globallogic_score::initpersstat("returns", 0);
    self.returns = self globallogic_score::getpersstat("returns");
    self globallogic_score::initpersstat("captures", 0);
    self.captures = self globallogic_score::getpersstat("captures");
    self globallogic_score::initpersstat("objtime", 0);
    self.objtime = self globallogic_score::getpersstat("objtime");
    self globallogic_score::initpersstat("carries", 0);
    self.carries = self globallogic_score::getpersstat("carries");
    self globallogic_score::initpersstat("throws", 0);
    self.throws = self globallogic_score::getpersstat("throws");
    self globallogic_score::initpersstat("destructions", 0);
    self.destructions = self globallogic_score::getpersstat("destructions");
    self globallogic_score::initpersstat("disables", 0);
    self.disables = self globallogic_score::getpersstat("disables");
    self globallogic_score::initpersstat("escorts", 0);
    self.escorts = self globallogic_score::getpersstat("escorts");
    self globallogic_score::initpersstat("infects", 0);
    self.infects = self globallogic_score::getpersstat("infects");
    self globallogic_score::initpersstat("sbtimeplayed", 0);
    self.sbtimeplayed = self globallogic_score::getpersstat("sbtimeplayed");
    self globallogic_score::initpersstat("backstabs", 0);
    self.backstabs = self globallogic_score::getpersstat("backstabs");
    self globallogic_score::initpersstat("longshots", 0);
    self.longshots = self globallogic_score::getpersstat("longshots");
    self globallogic_score::initpersstat("survived", 0);
    self.survived = self globallogic_score::getpersstat("survived");
    self globallogic_score::initpersstat("stabs", 0);
    self.stabs = self globallogic_score::getpersstat("stabs");
    self globallogic_score::initpersstat("tomahawks", 0);
    self.tomahawks = self globallogic_score::getpersstat("tomahawks");
    self globallogic_score::initpersstat("humiliated", 0);
    self.humiliated = self globallogic_score::getpersstat("humiliated");
    self globallogic_score::initpersstat("x2score", 0);
    self.x2score = self globallogic_score::getpersstat("x2score");
    self globallogic_score::initpersstat("agrkills", 0);
    self.x2score = self globallogic_score::getpersstat("agrkills");
    self globallogic_score::initpersstat("hacks", 0);
    self.x2score = self globallogic_score::getpersstat("hacks");
    self globallogic_score::initpersstat("killsconfirmed", 0);
    self.killsconfirmed = self globallogic_score::getpersstat("killsconfirmed");
    self globallogic_score::initpersstat("killsdenied", 0);
    self.killsdenied = self globallogic_score::getpersstat("killsdenied");
    self globallogic_score::initpersstat("rescues", 0);
    self.rescues = self globallogic_score::getpersstat("rescues");
    self globallogic_score::initpersstat("shotsfired", 0);
    self.shotsfired = self globallogic_score::getpersstat("shotsfired");
    self globallogic_score::initpersstat("shotshit", 0);
    self.shotshit = self globallogic_score::getpersstat("shotshit");
    self globallogic_score::initpersstat("shotsmissed", 0);
    self.shotsmissed = self globallogic_score::getpersstat("shotsmissed");
    self globallogic_score::initpersstat("cleandeposits", 0);
    self.cleandeposits = self globallogic_score::getpersstat("cleandeposits");
    self globallogic_score::initpersstat("cleandenies", 0);
    self.cleandenies = self globallogic_score::getpersstat("cleandenies");
    self globallogic_score::initpersstat("victory", 0);
    self.victory = self globallogic_score::getpersstat("victory");
    self globallogic_score::initpersstat("sessionbans", 0);
    self.sessionbans = self globallogic_score::getpersstat("sessionbans");
    self globallogic_score::initpersstat("gametypeban", 0);
    self globallogic_score::initpersstat("time_played_total", 0);
    self globallogic_score::initpersstat("time_played_alive", 0);
    self globallogic_score::initpersstat("teamkills", 0);
    self globallogic_score::initpersstat("teamkills_nostats", 0);
    self globallogic_score::initpersstat("kill_distances", 0);
    self globallogic_score::initpersstat("num_kill_distance_entries", 0);
    self globallogic_score::initpersstat("time_played_moving", 0);
    self globallogic_score::initpersstat("total_speeds_when_moving", 0);
    self globallogic_score::initpersstat("num_speeds_when_moving_entries", 0);
    self globallogic_score::initpersstat("total_distance_travelled", 0);
    self globallogic_score::initpersstat("movement_Update_Count", 0);
    self.teamkillpunish = 0;
    if(level.minimumallowedteamkills >= 0 && self.pers["teamkills_nostats"] > level.minimumallowedteamkills) {
      self thread reduceteamkillsovertime();
    }
    self behaviortracker::initialize();
  }
  self.killedplayerscurrent = [];
  if(!isDefined(self.pers["totalTimePlayed"])) {
    self setentertime(gettime());
    self.pers["totalTimePlayed"] = 0;
  }
  if(!isDefined(self.pers["totalMatchBonus"])) {
    self.pers["totalMatchBonus"] = 0;
  }
  if(!isDefined(self.pers["best_kill_streak"])) {
    self.pers["killed_players"] = [];
    self.pers["killed_by"] = [];
    self.pers["nemesis_tracking"] = [];
    self.pers["artillery_kills"] = 0;
    self.pers["dog_kills"] = 0;
    self.pers["nemesis_name"] = "";
    self.pers["nemesis_rank"] = 0;
    self.pers["nemesis_rankIcon"] = 0;
    self.pers["nemesis_xp"] = 0;
    self.pers["nemesis_xuid"] = "";
    self.pers["killed_players_with_specialist"] = [];
    self.pers["best_kill_streak"] = 0;
  }
  if(!isDefined(self.pers["music"])) {
    self.pers["music"] = spawnStruct();
    self.pers["music"].spawn = 0;
    self.pers["music"].inque = 0;
    self.pers["music"].currentstate = "SILENT";
    self.pers["music"].previousstate = "SILENT";
    self.pers["music"].nextstate = "UNDERSCORE";
    self.pers["music"].returnstate = "UNDERSCORE";
  }
  if(self.team != "spectator") {
    self thread globallogic_audio::set_music_on_player("spawnPreLoop");
  }
  if(!isDefined(self.pers["cur_kill_streak"])) {
    self.pers["cur_kill_streak"] = 0;
  }
  if(!isDefined(self.pers["cur_total_kill_streak"])) {
    self.pers["cur_total_kill_streak"] = 0;
    self setplayercurrentstreak(0);
  }
  if(!isDefined(self.pers["totalKillstreakCount"])) {
    self.pers["totalKillstreakCount"] = 0;
  }
  if(!isDefined(self.pers["killstreaksEarnedThisKillstreak"])) {
    self.pers["killstreaksEarnedThisKillstreak"] = 0;
  }
  if(isDefined(level.usingscorestreaks) && level.usingscorestreaks && !isDefined(self.pers["killstreak_quantity"])) {
    self.pers["killstreak_quantity"] = [];
  }
  if(isDefined(level.usingscorestreaks) && level.usingscorestreaks && !isDefined(self.pers["held_killstreak_ammo_count"])) {
    self.pers["held_killstreak_ammo_count"] = [];
  }
  if(isDefined(level.usingscorestreaks) && level.usingscorestreaks && !isDefined(self.pers["held_killstreak_clip_count"])) {
    self.pers["held_killstreak_clip_count"] = [];
  }
  if(!isDefined(self.pers["changed_class"])) {
    self.pers["changed_class"] = 0;
  }
  if(!isDefined(self.pers["lastroundscore"])) {
    self.pers["lastroundscore"] = 0;
  }
  self.lastkilltime = 0;
  self.cur_death_streak = 0;
  self disabledeathstreak();
  self.death_streak = 0;
  self.kill_streak = 0;
  self.gametype_kill_streak = 0;
  self.spawnqueueindex = -1;
  self.deathtime = 0;
  self.alivetimes = [];
  for(index = 0; index < level.alivetimemaxcount; index++) {
    self.alivetimes[index] = 0;
  }
  self.alivetimecurrentindex = 0;
  if(level.onlinegame && (!(isDefined(level.freerun) && level.freerun))) {
    self.death_streak = self getdstat("HighestStats", "death_streak");
    self.kill_streak = self getdstat("HighestStats", "kill_streak");
    self.gametype_kill_streak = self persistence::stat_get_with_gametype("kill_streak");
  }
  self.lastgrenadesuicidetime = -1;
  self.teamkillsthisround = 0;
  if(!isDefined(level.livesdonotreset) || !level.livesdonotreset || !isDefined(self.pers["lives"])) {
    self.pers["lives"] = level.numlives;
  }
  if(!level.teambased) {
    self.pers["team"] = undefined;
  }
  self.hasspawned = 0;
  self.waitingtospawn = 0;
  self.wantsafespawn = 0;
  self.deathcount = 0;
  self.wasaliveatmatchstart = 0;
  level.players[level.players.size] = self;
  if(level.splitscreen) {
    setDvar("splitscreen_playerNum", level.players.size);
  }
  if(game["state"] == "postgame") {
    self.pers["needteam"] = 1;
    self.pers["team"] = "spectator";
    self.team = self.sessionteam;
    self setclientuivisibilityflag("hud_visible", 0);
    self[[level.spawnintermission]]();
    self closeingamemenu();
    profilelog_endtiming(4, (("gs=" + game["state"]) + " zom=") + sessionmodeiszombiesgame());
    return;
  }
  if(level.rankedmatch || level.wagermatch || level.leaguematch && !isDefined(self.pers["lossAlreadyReported"])) {
    if(level.leaguematch) {
      self recordleaguepreloser();
    }
    globallogic_score::updatelossstats(self);
    self.pers["lossAlreadyReported"] = 1;
  }
  if(level.rankedmatch || level.leaguematch && !isDefined(self.pers["lateJoin"])) {
    if(game["state"] == "playing" && !level.inprematchperiod) {
      self.pers["lateJoin"] = 1;
    } else {
      self.pers["lateJoin"] = 0;
    }
  }
  if(!isDefined(self.pers["winstreakAlreadyCleared"])) {
    self globallogic_score::backupandclearwinstreaks();
    self.pers["winstreakAlreadyCleared"] = 1;
  }
  if(self istestclient()) {
    self.pers["isBot"] = 1;
    recordplayerstats(self, "isBot", 1);
  }
  if(level.rankedmatch || level.leaguematch) {
    self persistence::set_after_action_report_stat("demoFileID", "0");
  }
  level endon("game_ended");
  if(isDefined(level.hostmigrationtimer)) {
    self thread hostmigration::hostmigrationtimerthink();
  }
  if(isDefined(self.pers["team"])) {
    self.team = self.pers["team"];
  }
  if(isDefined(self.pers["class"])) {
    self.curclass = self.pers["class"];
  }
  if(!isDefined(self.pers["team"]) || isDefined(self.pers["needteam"])) {
    self.pers["needteam"] = undefined;
    self.pers["team"] = "spectator";
    self.team = "spectator";
    self.sessionstate = "dead";
    self globallogic_ui::updateobjectivetext();
    [[level.spawnspectator]]();
    [[level.autoassign]](0);
    if(level.rankedmatch || level.leaguematch) {
      self thread globallogic_spawn::kickifdontspawn();
    }
    if(self.pers["team"] == "spectator") {
      self.sessionteam = "spectator";
      self thread spectate_player_watcher();
    }
    if(level.teambased) {
      self.sessionteam = self.pers["team"];
      if(!isalive(self)) {
        self.statusicon = "hud_status_dead";
      }
      self thread spectating::set_permissions();
    }
  } else {
    if(self.pers["team"] == "spectator") {
      self setclientscriptmainmenu(game["menu_start_menu"]);
      [[level.spawnspectator]]();
      self.sessionteam = "spectator";
      self.sessionstate = "spectator";
      self thread spectate_player_watcher();
    } else {
      self.sessionteam = self.pers["team"];
      self.sessionstate = "dead";
      self globallogic_ui::updateobjectivetext();
      [[level.spawnspectator]]();
      if(globallogic_utils::isvalidclass(self.pers["class"]) || util::isprophuntgametype()) {
        if(!globallogic_utils::isvalidclass(self.pers["class"])) {
          self.pers["class"] = level.defaultclass;
          self.curclass = level.defaultclass;
          self setclientscriptmainmenu(game["menu_start_menu"]);
        }
        self thread[[level.spawnclient]]();
      } else {
        self globallogic_ui::showmainmenuforteam();
      }
      self thread spectating::set_permissions();
    }
  }
  if(self.sessionteam != "spectator") {
    self thread spawning::onspawnplayer(1);
  }
  if(level.forceradar == 1) {
    self.pers["hasRadar"] = 1;
    self.hasspyplane = 1;
    if(level.teambased) {
      level.activeuavs[self.team]++;
    } else {
      level.activeuavs[self getentitynumber()]++;
    }
    level.activeplayeruavs[self getentitynumber()]++;
  }
  if(level.forceradar == 2) {
    self setclientuivisibilityflag("g_compassShowEnemies", level.forceradar);
  } else {
    self setclientuivisibilityflag("g_compassShowEnemies", 0);
  }
  profilelog_endtiming(4, (("gs=" + game["state"]) + " zom=") + sessionmodeiszombiesgame());
  if(isDefined(self.pers["isBot"])) {
    return;
  }
  self record_global_mp_stats_for_player_at_match_start();
  num_con = getnumconnectedplayers();
  num_exp = getnumexpectedplayers();
  println("", num_con, "", num_exp);
  if(num_con == num_exp && num_exp != 0) {
    level flag::set("all_players_connected");
    setDvar("all_players_are_connected", "1");
  }
  globallogic_score::updateweaponcontractstart(self);
}

function record_global_mp_stats_for_player_at_match_start() {
  if(isDefined(level.disablestattracking) && level.disablestattracking == 1) {
    return;
  }
  startkills = self getdstat("playerstatslist", "kills", "statValue");
  startdeaths = self getdstat("playerstatslist", "deaths", "statValue");
  startwins = self getdstat("playerstatslist", "wins", "statValue");
  startlosses = self getdstat("playerstatslist", "losses", "statValue");
  starthits = self getdstat("playerstatslist", "hits", "statValue");
  startmisses = self getdstat("playerstatslist", "misses", "statValue");
  starttimeplayedtotal = self getdstat("playerstatslist", "time_played_total", "statValue");
  startscore = self getdstat("playerstatslist", "score", "statValue");
  startprestige = self getdstat("playerstatslist", "plevel", "statValue");
  startunlockpoints = self getdstat("unlocks", 0);
  ties = self getdstat("playerstatslist", "ties", "statValue");
  startgamesplayed = (startwins + startlosses) + ties;
  self.startkills = startkills;
  self.starthits = starthits;
  self.totalmatchshots = 0;
  recordplayerstats(self, "startKills", startkills);
  recordplayerstats(self, "startDeaths", startdeaths);
  recordplayerstats(self, "startWins", startwins);
  recordplayerstats(self, "startLosses", startlosses);
  recordplayerstats(self, "startHits", starthits);
  recordplayerstats(self, "startMisses", startmisses);
  recordplayerstats(self, "startTimePlayedTotal", starttimeplayedtotal);
  recordplayerstats(self, "startScore", startscore);
  recordplayerstats(self, "startPrestige", startprestige);
  recordplayerstats(self, "startUnlockPoints", startunlockpoints);
  recordplayerstats(self, "startGamesPlayed", startgamesplayed);
  lootxpbeforematch = self getdstat("AfterActionReportStats", "lootXPBeforeMatch");
  cryptokeysbeforematch = self getdstat("AfterActionReportStats", "cryptoKeysBeforeMatch");
  recordplayerstats(self, "lootXPBeforeMatch", lootxpbeforematch);
  recordplayerstats(self, "cryptoKeysBeforeMatch", cryptokeysbeforematch);
}

function record_global_mp_stats_for_player_at_match_end() {
  if(isDefined(level.disablestattracking) && level.disablestattracking == 1) {
    return;
  }
  endkills = self getdstat("playerstatslist", "kills", "statValue");
  enddeaths = self getdstat("playerstatslist", "deaths", "statValue");
  endwins = self getdstat("playerstatslist", "wins", "statValue");
  endlosses = self getdstat("playerstatslist", "losses", "statValue");
  endhits = self getdstat("playerstatslist", "hits", "statValue");
  endmisses = self getdstat("playerstatslist", "misses", "statValue");
  endtimeplayedtotal = self getdstat("playerstatslist", "time_played_total", "statValue");
  endscore = self getdstat("playerstatslist", "score", "statValue");
  endprestige = self getdstat("playerstatslist", "plevel", "statValue");
  endunlockpoints = self getdstat("unlocks", 0);
  ties = self getdstat("playerstatslist", "ties", "statValue");
  endgamesplayed = (endwins + endlosses) + ties;
  recordplayerstats(self, "endKills", endkills);
  recordplayerstats(self, "endDeaths", enddeaths);
  recordplayerstats(self, "endWins", endwins);
  recordplayerstats(self, "endLosses", endlosses);
  recordplayerstats(self, "endHits", endhits);
  recordplayerstats(self, "endMisses", endmisses);
  recordplayerstats(self, "endTimePlayedTotal", endtimeplayedtotal);
  recordplayerstats(self, "endScore", endscore);
  recordplayerstats(self, "endPrestige", endprestige);
  recordplayerstats(self, "endUnlockPoints", endunlockpoints);
  recordplayerstats(self, "endGamesPlayed", endgamesplayed);
}

function record_misc_player_stats() {
  if(isDefined(level.disablestattracking) && level.disablestattracking == 1) {
    return;
  }
  recordplayerstats(self, "UTCEndTimeSeconds", getutc());
  if(isDefined(self.weaponpickupscount)) {
    recordplayerstats(self, "weaponPickupsCount", self.weaponpickupscount);
  }
  if(isDefined(self.killcamsskipped)) {
    recordplayerstats(self, "totalKillcamsSkipped", self.killcamsskipped);
  }
  if(isDefined(self.matchbonus)) {
    recordplayerstats(self, "matchXp", self.matchbonus);
  }
  if(isDefined(self.killsdenied)) {
    recordplayerstats(self, "killsDenied", self.killsdenied);
  }
  if(isDefined(self.killsconfirmed)) {
    recordplayerstats(self, "killsConfirmed", self.killsconfirmed);
  }
  if(self issplitscreen()) {
    recordplayerstats(self, "isSplitscreen", 1);
  }
  if(self.objtime) {
    recordplayerstats(self, "objectiveTime", self.objtime);
  }
  if(self.escorts) {
    recordplayerstats(self, "escortTime", self.escorts);
  }
}

function spectate_player_watcher() {
  self endon("disconnect");
  if(!level.splitscreen && !level.hardcoremode && getdvarint("scr_showperksonspawn") == 1 && game["state"] != "postgame" && !isDefined(self.perkhudelem)) {
    if(level.perksenabled == 1) {
      self hud::showperks();
    }
  }
  self.watchingactiveclient = 1;
  self.waitingforplayerstext = undefined;
  while(true) {
    if(self.pers["team"] != "spectator" || level.gameended) {
      self hud_message::clearshoutcasterwaitingmessage();
      if(!(isDefined(level.inprematchperiod) && level.inprematchperiod)) {
        self freezecontrols(0);
      }
      self.watchingactiveclient = 0;
      break;
    } else {
      count = 0;
      for(i = 0; i < level.players.size; i++) {
        if(level.players[i].team != "spectator") {
          count++;
          break;
        }
      }
      if(count > 0) {
        if(!self.watchingactiveclient) {
          self hud_message::clearshoutcasterwaitingmessage();
          self freezecontrols(0);
          self luinotifyevent(&"player_spawned", 0);
        }
        self.watchingactiveclient = 1;
      } else {
        if(self.watchingactiveclient) {
          [[level.onspawnspectator]]();
          self freezecontrols(1);
          self hud_message::setshoutcasterwaitingmessage();
        }
        self.watchingactiveclient = 0;
      }
      wait(0.5);
    }
  }
}

function callback_playermigrated() {
  println((("" + self.name) + "") + gettime());
  if(isDefined(self.connected) && self.connected) {
    self globallogic_ui::updateobjectivetext();
  }
  level.hostmigrationreturnedplayercount++;
  if(level.hostmigrationreturnedplayercount >= ((level.players.size * 2) / 3)) {
    println("");
    level notify("hostmigration_enoughplayers");
  }
}

function callback_playerdisconnect() {
  profilelog_begintiming(5, "ship");
  if(game["state"] != "postgame" && !level.gameended) {
    gamelength = game["timepassed"];
    self globallogic::bbplayermatchend(gamelength, "MP_PLAYER_DISCONNECT", 0);
    if(util::isroundbased()) {
      recordplayerstats(self, "playerQuitRoundNumber", game["roundsplayed"] + 1);
    }
    if(level.teambased) {
      ourteam = self.team;
      if(ourteam == "allies" || ourteam == "axis") {
        theirteam = "";
        if(ourteam == "allies") {
          theirteam = "axis";
        } else if(ourteam == "axis") {
          theirteam = "allies";
        }
        recordplayerstats(self, "playerQuitTeamScore", getteamscore(ourteam));
        recordplayerstats(self, "playerQuitOpposingTeamScore", getteamscore(theirteam));
      }
    }
    recordendgamecomscoreeventforplayer(self, "disconnect");
  }
  self behaviortracker::finalize();
  arrayremovevalue(level.players, self);
  if(level.splitscreen) {
    players = level.players;
    if(players.size <= 1) {
      level thread globallogic::forceend();
    }
    setDvar("splitscreen_playerNum", players.size);
  }
  if(isDefined(self.score) && isDefined(self.pers["team"])) {
    print((("" + self.pers[""]) + "") + self.score);
    level.dropteam = level.dropteam + 1;
  }
  [[level.onplayerdisconnect]]();
  lpselfnum = self getentitynumber();
  lpguid = self getguid();
  logprint(((((("" + lpguid) + "") + lpselfnum) + "") + self.name) + "");
  self record_global_mp_stats_for_player_at_match_end();
  self record_special_move_data_for_life(undefined);
  self record_misc_player_stats();
  self gamerep::gamerepplayerdisconnected();
  for(entry = 0; entry < level.players.size; entry++) {
    if(level.players[entry] == self) {
      while(entry < (level.players.size - 1)) {
        level.players[entry] = level.players[entry + 1];
        entry++;
      }
      level.players[entry] = undefined;
      break;
    }
  }
  for(entry = 0; entry < level.players.size; entry++) {
    if(isDefined(level.players[entry].pers["killed_players"][self.name])) {
      level.players[entry].pers["killed_players"][self.name] = undefined;
    }
    if(isDefined(level.players[entry].pers["killed_players_with_specialist"][self.name])) {
      level.players[entry].pers["killed_players_with_specialist"][self.name] = undefined;
    }
    if(isDefined(level.players[entry].killedplayerscurrent[self.name])) {
      level.players[entry].killedplayerscurrent[self.name] = undefined;
    }
    if(isDefined(level.players[entry].pers["killed_by"][self.name])) {
      level.players[entry].pers["killed_by"][self.name] = undefined;
    }
    if(isDefined(level.players[entry].pers["nemesis_tracking"][self.name])) {
      level.players[entry].pers["nemesis_tracking"][self.name] = undefined;
    }
    if(level.players[entry].pers["nemesis_name"] == self.name) {
      level.players[entry] choosenextbestnemesis();
    }
  }
  if(level.gameended) {
    self globallogic::removedisconnectedplayerfromplacement();
  }
  level thread globallogic::updateteamstatus();
  level thread globallogic::updateallalivetimes();
  profilelog_endtiming(5, (("gs=" + game["state"]) + " zom=") + sessionmodeiszombiesgame());
}

function callback_playermelee(eattacker, idamage, weapon, vorigin, vdir, boneindex, shieldhit, frombehind) {
  hit = 1;
  if(level.teambased && self.team == eattacker.team) {
    if(level.friendlyfire == 0) {
      hit = 0;
    }
  }
  self finishmeleehit(eattacker, weapon, vorigin, vdir, boneindex, shieldhit, hit, frombehind);
}

function choosenextbestnemesis() {
  nemesisarray = self.pers["nemesis_tracking"];
  nemesisarraykeys = getarraykeys(nemesisarray);
  nemesisamount = 0;
  nemesisname = "";
  if(nemesisarraykeys.size > 0) {
    for(i = 0; i < nemesisarraykeys.size; i++) {
      nemesisarraykey = nemesisarraykeys[i];
      if(nemesisarray[nemesisarraykey] > nemesisamount) {
        nemesisname = nemesisarraykey;
        nemesisamount = nemesisarray[nemesisarraykey];
      }
    }
  }
  self.pers["nemesis_name"] = nemesisname;
  if(nemesisname != "") {
    for(playerindex = 0; playerindex < level.players.size; playerindex++) {
      if(level.players[playerindex].name == nemesisname) {
        nemesisplayer = level.players[playerindex];
        self.pers["nemesis_rank"] = nemesisplayer.pers["rank"];
        self.pers["nemesis_rankIcon"] = nemesisplayer.pers["rankxp"];
        self.pers["nemesis_xp"] = nemesisplayer.pers["prestige"];
        self.pers["nemesis_xuid"] = nemesisplayer getxuid();
        break;
      }
    }
  } else {
    self.pers["nemesis_xuid"] = "";
  }
}

function custom_gamemodes_modified_damage(victim, eattacker, idamage, smeansofdeath, weapon, einflictor, shitloc) {
  if(level.onlinegame && !sessionmodeisprivate()) {
    return idamage;
  }
  if(isDefined(eattacker) && isDefined(eattacker.damagemodifier)) {
    idamage = idamage * eattacker.damagemodifier;
  }
  if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET") {
    idamage = int(idamage * level.bulletdamagescalar);
  }
  return idamage;
}

function figure_out_attacker(eattacker) {
  if(isDefined(eattacker)) {
    if(isai(eattacker) && isDefined(eattacker.script_owner)) {
      team = self.team;
      if(eattacker.script_owner.team != team) {
        eattacker = eattacker.script_owner;
      }
    }
    if(eattacker.classname == "script_vehicle" && isDefined(eattacker.owner)) {
      eattacker = eattacker.owner;
    } else {
      if(eattacker.classname == "auto_turret" && isDefined(eattacker.owner)) {
        eattacker = eattacker.owner;
      } else if(eattacker.classname == "actor_spawner_bo3_robot_grunt_assault_mp" && isDefined(eattacker.owner)) {
        eattacker = eattacker.owner;
      }
    }
  }
  return eattacker;
}

function player_damage_figure_out_weapon(weapon, einflictor) {
  if(weapon == level.weaponnone && isDefined(einflictor)) {
    if(isDefined(einflictor.targetname) && einflictor.targetname == "explodable_barrel") {
      weapon = getweapon("explodable_barrel");
    } else {
      if(isDefined(einflictor.destructible_type) && issubstr(einflictor.destructible_type, "vehicle_")) {
        weapon = getweapon("destructible_car");
      } else if(isDefined(einflictor.scriptvehicletype)) {
        veh_weapon = getweapon(einflictor.scriptvehicletype);
        if(isDefined(veh_weapon)) {
          weapon = veh_weapon;
        }
      }
    }
  }
  if(isDefined(einflictor) && isDefined(einflictor.script_noteworthy)) {
    if(isDefined(level.overrideweaponfunc)) {
      weapon = [[level.overrideweaponfunc]](weapon, einflictor.script_noteworthy);
    }
  }
  return weapon;
}

function figure_out_friendly_fire(victim) {
  if(level.hardcoremode && level.friendlyfire > 0 && isDefined(victim) && victim.is_capturing_own_supply_drop === 1) {
    return 2;
  }
  if(killstreaks::is_ricochet_protected(victim)) {
    return 2;
  }
  if(isDefined(level.figure_out_gametype_friendly_fire)) {
    return [[level.figure_out_gametype_friendly_fire]](victim);
  }
  return level.friendlyfire;
}

function isplayerimmunetokillstreak(eattacker, weapon) {
  if(level.hardcoremode) {
    return 0;
  }
  if(!isDefined(eattacker)) {
    return 0;
  }
  if(self != eattacker) {
    return 0;
  }
  return weapon.donotdamageowner;
}

function should_do_player_damage(eattacker, weapon, smeansofdeath, idflags) {
  if(game["state"] == "postgame") {
    return false;
  }
  if(self.sessionteam == "spectator") {
    return false;
  }
  if(isDefined(self.candocombat) && !self.candocombat) {
    return false;
  }
  if(isDefined(eattacker) && isPlayer(eattacker) && isDefined(eattacker.candocombat) && !eattacker.candocombat) {
    return false;
  }
  if(isDefined(level.hostmigrationtimer)) {
    return false;
  }
  if(level.onlyheadshots) {
    if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET") {
      return false;
    }
  }
  if(self vehicle::player_is_occupant_invulnerable(smeansofdeath)) {
    return false;
  }
  if(weapon.issupplydropweapon && !weapon.isgrenadeweapon && smeansofdeath != "MOD_TRIGGER_HURT") {
    return false;
  }
  if(self.scene_takedamage === 0) {
    return false;
  }
  if(idflags & 8 && self player::is_spawn_protected()) {
    return false;
  }
  return true;
}

function apply_damage_to_armor(einflictor, eattacker, idamage, smeansofdeath, weapon, shitloc, friendlyfire, ignore_round_start_friendly_fire) {
  victim = self;
  if(friendlyfire && !player_damage_does_friendly_fire_damage_victim(ignore_round_start_friendly_fire)) {
    return idamage;
  }
  if(isDefined(victim.lightarmorhp)) {
    if(weapon.ignoreslightarmor && smeansofdeath != "MOD_MELEE") {
      return idamage;
    }
    if(weapon.meleeignoreslightarmor && smeansofdeath == "MOD_MELEE") {
      return idamage;
    }
    if(isDefined(einflictor) && isDefined(einflictor.stucktoplayer) && einflictor.stucktoplayer == victim) {
      idamage = victim.health;
    } else if(smeansofdeath != "MOD_FALLING" && !weapon_utils::ismeleemod(smeansofdeath) && !globallogic_utils::isheadshot(weapon, shitloc, smeansofdeath, eattacker)) {
      victim armor::setlightarmorhp(victim.lightarmorhp - idamage);
      idamage = 0;
      if(victim.lightarmorhp <= 0) {
        idamage = abs(victim.lightarmorhp);
        armor::unsetlightarmor();
      }
    }
  }
  return idamage;
}

function make_sure_damage_is_not_zero(idamage) {
  if(idamage < 1) {
    if(self ability_util::gadget_power_armor_on() && isDefined(self.maxhealth) && self.health < self.maxhealth) {
      self.health = self.health + 1;
    }
    idamage = 1;
  }
  return int(idamage);
}

function modify_player_damage_friendlyfire(idamage) {
  friendlyfire = [[level.figure_out_friendly_fire]](self);
  if(friendlyfire == 2 || friendlyfire == 3) {
    idamage = int(idamage * 0.5);
  }
  return idamage;
}

function modify_player_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
  if(isDefined(self.overrideplayerdamage)) {
    idamage = self[[self.overrideplayerdamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
  } else if(isDefined(level.overrideplayerdamage)) {
    idamage = self[[level.overrideplayerdamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
  }
  assert(isDefined(idamage), "");
  if(isDefined(eattacker)) {
    idamage = loadout::cac_modified_damage(self, eattacker, idamage, smeansofdeath, weapon, einflictor, shitloc);
    if(isDefined(eattacker.pickup_damage_scale) && eattacker.pickup_damage_scale_time > gettime()) {
      idamage = idamage * eattacker.pickup_damage_scale;
    }
  }
  idamage = custom_gamemodes_modified_damage(self, eattacker, idamage, smeansofdeath, weapon, einflictor, shitloc);
  if(level.onplayerdamage != (&globallogic::blank)) {
    modifieddamage = [[level.onplayerdamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
    if(isDefined(modifieddamage)) {
      if(modifieddamage <= 0) {
        return;
      }
      idamage = modifieddamage;
    }
  }
  if(level.onlyheadshots) {
    if(smeansofdeath == "MOD_HEAD_SHOT") {
      idamage = 150;
    }
  }
  if(weapon.damagealwayskillsplayer) {
    idamage = self.maxhealth + 1;
  }
  if(shitloc == "riotshield") {
    if(idflags & 32) {
      if(!idflags & 64) {
        idamage = idamage * 0;
      }
    } else if(idflags & 128) {
      if(isDefined(einflictor) && isDefined(einflictor.stucktoplayer) && einflictor.stucktoplayer == self) {
        idamage = self.maxhealth + 1;
      }
    }
  }
  return int(idamage);
}

function modify_player_damage_meansofdeath(einflictor, eattacker, smeansofdeath, weapon, shitloc) {
  if(globallogic_utils::isheadshot(weapon, shitloc, smeansofdeath, einflictor) && isPlayer(eattacker) && !weapon_utils::ismeleemod(smeansofdeath)) {
    smeansofdeath = "MOD_HEAD_SHOT";
  }
  if(isDefined(einflictor) && isDefined(einflictor.script_noteworthy)) {
    if(einflictor.script_noteworthy == "ragdoll_now") {
      smeansofdeath = "MOD_FALLING";
    }
  }
  return smeansofdeath;
}

function player_damage_update_attacker(einflictor, eattacker, smeansofdeath) {
  if(isDefined(einflictor) && isPlayer(eattacker) && eattacker == einflictor) {
    if(smeansofdeath == "MOD_HEAD_SHOT" || smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET") {
      eattacker.hits++;
    }
  }
  if(isPlayer(eattacker)) {
    eattacker.pers["participation"]++;
  }
}

function player_is_spawn_protected_from_explosive(einflictor, weapon, smeansofdeath) {
  if(!self player::is_spawn_protected()) {
    return false;
  }
  if(weapon.explosionradius == 0) {
    return false;
  }
  distsqr = (isDefined(self.lastspawnpoint) ? distancesquared(einflictor.origin, self.lastspawnpoint.origin) : 0);
  if(distsqr < (250 * 250)) {
    if(smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH") {
      return true;
    }
    if(smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH") {
      return true;
    }
    if(smeansofdeath == "MOD_EXPLOSIVE") {
      return true;
    }
  }
  if(killstreaks::is_killstreak_weapon(weapon)) {
    return true;
  }
  return false;
}

function player_damage_update_explosive_info(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
  is_explosive_damage = loadout::isexplosivedamage(smeansofdeath);
  if(is_explosive_damage) {
    if(self player_is_spawn_protected_from_explosive(einflictor, weapon, smeansofdeath)) {
      return false;
    }
    if(self isplayerimmunetokillstreak(eattacker, weapon)) {
      return false;
    }
  }
  if(isDefined(einflictor) && (smeansofdeath == "MOD_GAS" || is_explosive_damage)) {
    self.explosiveinfo = [];
    self.explosiveinfo["damageTime"] = gettime();
    self.explosiveinfo["damageId"] = einflictor getentitynumber();
    self.explosiveinfo["originalOwnerKill"] = 0;
    self.explosiveinfo["bulletPenetrationKill"] = 0;
    self.explosiveinfo["chainKill"] = 0;
    self.explosiveinfo["damageExplosiveKill"] = 0;
    self.explosiveinfo["chainKill"] = 0;
    self.explosiveinfo["cookedKill"] = 0;
    self.explosiveinfo["weapon"] = weapon;
    self.explosiveinfo["originalowner"] = einflictor.originalowner;
    isfrag = weapon.rootweapon.name == "frag_grenade";
    if(isDefined(eattacker) && eattacker != self) {
      if(isDefined(eattacker) && isDefined(einflictor.owner) && (weapon.name == "satchel_charge" || weapon.name == "claymore" || weapon.name == "bouncingbetty")) {
        self.explosiveinfo["originalOwnerKill"] = einflictor.owner == self;
        self.explosiveinfo["damageExplosiveKill"] = isDefined(einflictor.wasdamaged);
        self.explosiveinfo["chainKill"] = isDefined(einflictor.waschained);
        self.explosiveinfo["wasJustPlanted"] = isDefined(einflictor.wasjustplanted);
        self.explosiveinfo["bulletPenetrationKill"] = isDefined(einflictor.wasdamagedfrombulletpenetration);
        self.explosiveinfo["cookedKill"] = 0;
      }
      if(isDefined(einflictor) && isDefined(einflictor.stucktoplayer) && weapon.projexplosiontype == "grenade") {
        self.explosiveinfo["stuckToPlayer"] = einflictor.stucktoplayer;
      }
      if(weapon.dostun) {
        self.laststunnedby = eattacker;
        self.laststunnedtime = self.idflagstime;
      }
      if(isDefined(eattacker.lastgrenadesuicidetime) && eattacker.lastgrenadesuicidetime >= (gettime() - 50) && isfrag) {
        self.explosiveinfo["suicideGrenadeKill"] = 1;
      } else {
        self.explosiveinfo["suicideGrenadeKill"] = 0;
      }
    }
    if(isfrag) {
      self.explosiveinfo["cookedKill"] = isDefined(einflictor.iscooked);
      self.explosiveinfo["throwbackKill"] = isDefined(einflictor.threwback);
    }
    if(isDefined(eattacker) && isPlayer(eattacker) && eattacker != self) {
      self globallogic_score::setinflictorstat(einflictor, eattacker, weapon);
    }
  }
  if(smeansofdeath == "MOD_IMPACT" && isDefined(eattacker) && isPlayer(eattacker) && eattacker != self) {
    if(weapon != level.weaponballisticknife) {
      self globallogic_score::setinflictorstat(einflictor, eattacker, weapon);
    }
    if(weapon.rootweapon.name == "hatchet" && isDefined(einflictor)) {
      self.explosiveinfo["projectile_bounced"] = isDefined(einflictor.bounced);
    }
  }
  return true;
}

function player_damage_is_friendly_fire_at_round_start() {
  if(level.friendlyfiredelay && level.friendlyfiredelaytime >= (((gettime() - level.starttime) - level.discardtime) / 1000)) {
    return true;
  }
  return false;
}

function player_damage_does_friendly_fire_damage_attacker(eattacker, ignore_round_start_friendly_fire) {
  if(!isalive(eattacker)) {
    return false;
  }
  friendlyfire = [[level.figure_out_friendly_fire]](self);
  if(friendlyfire == 1) {
    if(player_damage_is_friendly_fire_at_round_start() && ignore_round_start_friendly_fire == 0) {
      return true;
    }
  }
  if(friendlyfire == 2) {
    return true;
  }
  if(friendlyfire == 3) {
    return true;
  }
  return false;
}

function player_damage_does_friendly_fire_damage_victim(ignore_round_start_friendly_fire) {
  friendlyfire = [[level.figure_out_friendly_fire]](self);
  if(friendlyfire == 1) {
    if(player_damage_is_friendly_fire_at_round_start() && ignore_round_start_friendly_fire == 0) {
      return false;
    }
    return true;
  }
  if(friendlyfire == 3) {
    return true;
  }
  return false;
}

function player_damage_riotshield_hit(eattacker, idamage, smeansofdeath, weapon, attackerishittingteammate) {
  if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" && !killstreaks::is_killstreak_weapon(weapon) && !attackerishittingteammate) {
    if(self.hasriotshieldequipped) {
      if(isPlayer(eattacker)) {
        eattacker.lastattackedshieldplayer = self;
        eattacker.lastattackedshieldtime = gettime();
      }
      previous_shield_damage = self.shielddamageblocked;
      self.shielddamageblocked = self.shielddamageblocked + idamage;
      if((self.shielddamageblocked % 400) < (previous_shield_damage % 400)) {
        score_event = "shield_blocked_damage";
        if(self.shielddamageblocked > 2000) {
          score_event = "shield_blocked_damage_reduced";
        }
        if(isDefined(level.scoreinfo[score_event]["value"])) {
          self addweaponstat(level.weaponriotshield, "score_from_blocked_damage", level.scoreinfo[score_event]["value"]);
        }
        scoreevents::processscoreevent(score_event, self);
      }
    }
  }
}

function does_player_completely_avoid_damage(idflags, shitloc, weapon, friendlyfire, attackerishittingself, smeansofdeath) {
  if(idflags & 2048) {
    return true;
  }
  if(friendlyfire && level.friendlyfire == 0) {
    return true;
  }
  if(shitloc == "riotshield") {
    if(!idflags & 160) {
      return true;
    }
  }
  if(weapon.isemp && smeansofdeath == "MOD_GRENADE_SPLASH") {
    if(self hasperk("specialty_immuneemp")) {
      return true;
    }
  }
  if(isDefined(level.var_dc6b46ed) && self[[level.var_dc6b46ed]](idflags, shitloc, weapon, friendlyfire, attackerishittingself, smeansofdeath)) {
    return true;
  }
  return false;
}

function player_damage_log(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
  pixbeginevent("PlayerDamage log");
  if(getdvarint("")) {
    println(((((((((("" + self getentitynumber()) + "") + self.health) + "") + eattacker.clientid) + "") + isPlayer(einflictor) + "") + idamage) + "") + shitloc);
  }
  if(self.sessionstate != "dead") {
    lpselfnum = self getentitynumber();
    lpselfname = self.name;
    lpselfteam = self.team;
    lpselfguid = self getguid();
    lpattackerteam = "";
    lpattackerorigin = (0, 0, 0);
    if(isPlayer(eattacker)) {
      lpattacknum = eattacker getentitynumber();
      lpattackguid = eattacker getguid();
      lpattackname = eattacker.name;
      lpattackerteam = eattacker.team;
      lpattackerorigin = eattacker.origin;
      isusingheropower = 0;
      if(eattacker ability_player::is_using_any_gadget()) {
        isusingheropower = 1;
      }
      bbprint("mpattacks", "gametime %d attackerspawnid %d attackerweapon %s attackerx %d attackery %d attackerz %d victimspawnid %d victimx %d victimy %d victimz %d damage %d damagetype %s damagelocation %s death %d isusingheropower %d", gettime(), getplayerspawnid(eattacker), weapon.name, lpattackerorigin, getplayerspawnid(self), self.origin, idamage, smeansofdeath, shitloc, 0, isusingheropower);
    } else {
      lpattacknum = -1;
      lpattackguid = "";
      lpattackname = "";
      lpattackerteam = "world";
      bbprint("mpattacks", "gametime %d attackerweapon %s victimspawnid %d victimx %d victimy %d victimz %d damage %d damagetype %s damagelocation %s death %d isusingheropower %d", gettime(), weapon.name, getplayerspawnid(self), self.origin, idamage, smeansofdeath, shitloc, 0, 0);
    }
    logprint(((((((((((((((((((((((("" + lpselfguid) + "") + lpselfnum) + "") + lpselfteam) + "") + lpselfname) + "") + lpattackguid) + "") + lpattacknum) + "") + lpattackerteam) + "") + lpattackname) + "") + weapon.name) + "") + idamage) + "") + smeansofdeath) + "") + shitloc) + "");
  }
  pixendevent();
}

function should_allow_postgame_damage(smeansofdeath) {
  if(smeansofdeath == "MOD_TRIGGER_HURT" || smeansofdeath == "MOD_CRUSH") {
    return true;
  }
  return false;
}

function do_post_game_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
  if(game["state"] != "postgame") {
    return;
  }
  if(!should_allow_postgame_damage(smeansofdeath)) {
    return;
  }
  self finishplayerdamage(einflictor, eattacker, idamage, idflags, "MOD_POST_GAME", weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
}

function callback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
  profilelog_begintiming(6, "ship");
  do_post_game_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
  if(smeansofdeath == "MOD_CRUSH" && isDefined(einflictor) && einflictor.deal_no_crush_damage === 1) {
    return;
  }
  if(isDefined(einflictor) && einflictor.killstreaktype === "siegebot") {
    if(einflictor.team === "neutral") {
      return;
    }
  }
  self.idflags = idflags;
  self.idflagstime = gettime();
  if(!isPlayer(eattacker) && isDefined(eattacker) && eattacker.owner === self) {
    treat_self_damage_as_friendly_fire = eattacker.treat_owner_damage_as_friendly_fire;
  }
  ignore_round_start_friendly_fire = isDefined(einflictor) && smeansofdeath == "MOD_CRUSH" || smeansofdeath == "MOD_HIT_BY_OBJECT";
  eattacker = figure_out_attacker(eattacker);
  if(isPlayer(eattacker) && (isDefined(eattacker.laststand) && eattacker.laststand)) {
    return;
  }
  smeansofdeath = modify_player_damage_meansofdeath(einflictor, eattacker, smeansofdeath, weapon, shitloc);
  if(!self should_do_player_damage(eattacker, weapon, smeansofdeath, idflags)) {
    return;
  }
  player_damage_update_attacker(einflictor, eattacker, smeansofdeath);
  weapon = player_damage_figure_out_weapon(weapon, einflictor);
  pixbeginevent("PlayerDamage flags/tweaks");
  if(!isDefined(vdir)) {
    idflags = idflags | 4;
  }
  attackerishittingteammate = isPlayer(eattacker) && self util::isenemyplayer(eattacker) == 0;
  attackerishittingself = isPlayer(eattacker) && self == eattacker;
  friendlyfire = attackerishittingself && treat_self_damage_as_friendly_fire === 1 || (level.teambased && !attackerishittingself && attackerishittingteammate);
  pixendevent();
  idamage = modify_player_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
  if(friendlyfire) {
    idamage = modify_player_damage_friendlyfire(idamage);
  }
  if(isDefined(self.power_armor_took_damage) && self.power_armor_took_damage) {
    idflags = idflags | 1024;
  }
  if(shitloc == "riotshield") {
    player_damage_riotshield_hit(eattacker, idamage, smeansofdeath, weapon, attackerishittingteammate);
  }
  if(self does_player_completely_avoid_damage(idflags, shitloc, weapon, friendlyfire, attackerishittingself, smeansofdeath)) {
    return;
  }
  self callback::callback("hash_ab5ecf6c");
  armor = self armor::getarmor();
  idamage = apply_damage_to_armor(einflictor, eattacker, idamage, smeansofdeath, weapon, shitloc, friendlyfire, ignore_round_start_friendly_fire);
  idamage = make_sure_damage_is_not_zero(idamage);
  armor_damaged = armor != self armor::getarmor();
  if(shitloc == "riotshield") {
    shitloc = "none";
  }
  if(!player_damage_update_explosive_info(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex)) {
    return;
  }
  prevhealthratio = self.health / self.maxhealth;
  if(friendlyfire) {
    pixmarker("BEGIN: PlayerDamage player");
    if(player_damage_does_friendly_fire_damage_victim(ignore_round_start_friendly_fire)) {
      self.lastdamagewasfromenemy = 0;
      self finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
    } else if(weapon.forcedamageshellshockandrumble) {
      self damageshellshockandrumble(eattacker, einflictor, weapon, smeansofdeath, idamage);
    }
    if(player_damage_does_friendly_fire_damage_attacker(eattacker, ignore_round_start_friendly_fire)) {
      eattacker.lastdamagewasfromenemy = 0;
      eattacker.friendlydamage = 1;
      eattacker finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
      eattacker.friendlydamage = undefined;
    }
    pixmarker("END: PlayerDamage player");
  } else {
    behaviortracker::updateplayerdamage(eattacker, self, idamage);
    self.lastattackweapon = weapon;
    giveattackerandinflictorownerassist(eattacker, einflictor, idamage, smeansofdeath, weapon);
    if(isDefined(eattacker)) {
      level.lastlegitimateattacker = eattacker;
    }
    if(smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" && isDefined(einflictor) && isDefined(einflictor.iscooked)) {
      self.wascooked = gettime();
    } else {
      self.wascooked = undefined;
    }
    self.lastdamagewasfromenemy = isDefined(eattacker) && eattacker != self;
    if(self.lastdamagewasfromenemy) {
      if(isPlayer(eattacker)) {
        if(isDefined(eattacker.damagedplayers[self.clientid]) == 0) {
          eattacker.damagedplayers[self.clientid] = spawnStruct();
        }
        eattacker.damagedplayers[self.clientid].time = gettime();
        eattacker.damagedplayers[self.clientid].entity = self;
      }
    }
    if(isPlayer(eattacker) && isDefined(weapon.gadget_type) && weapon.gadget_type == 14) {
      if(isDefined(eattacker.heroweaponhits)) {
        eattacker.heroweaponhits++;
      }
    }
    self finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
  }
  if(isDefined(eattacker) && !attackerishittingself) {
    if(damagefeedback::dodamagefeedback(weapon, einflictor, idamage, smeansofdeath)) {
      if(idamage > 0 && self.health > 0) {
        perkfeedback = doperkfeedback(self, weapon, smeansofdeath, einflictor, armor_damaged);
      }
      eattacker thread damagefeedback::update(smeansofdeath, einflictor, perkfeedback, weapon, self, psoffsettime, shitloc);
    }
  }
  if(!isDefined(eattacker) || !friendlyfire || (isDefined(level.hardcoremode) && level.hardcoremode)) {
    if(isDefined(level.var_b9fd53a3)) {
      self[[level.var_b9fd53a3]](smeansofdeath);
    } else {
      self battlechatter::pain_vox(smeansofdeath);
    }
  }
  self.hasdonecombat = 1;
  if(weapon.isemp && smeansofdeath == "MOD_GRENADE_SPLASH") {
    if(!self hasperk("specialty_immuneemp")) {
      self notify("emp_grenaded", eattacker, vpoint);
    }
  }
  if(isDefined(eattacker) && eattacker != self && !friendlyfire) {
    level.usestartspawns = 0;
  }
  player_damage_log(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
  profilelog_endtiming(6, (("gs=" + game["state"]) + " zom=") + sessionmodeiszombiesgame());
}

function resetattackerlist() {
  self.attackers = [];
  self.attackerdata = [];
  self.attackerdamage = [];
  self.firsttimedamaged = 0;
}

function resetattackersthisspawnlist() {
  self.attackersthisspawn = [];
}

function doperkfeedback(player, weapon, smeansofdeath, einflictor, armor_damaged) {
  perkfeedback = undefined;
  hastacticalmask = loadout::hastacticalmask(player);
  hasflakjacket = player hasperk("specialty_flakjacket");
  isexplosivedamage = loadout::isexplosivedamage(smeansofdeath);
  isflashorstundamage = weapon_utils::isflashorstundamage(weapon, smeansofdeath);
  if(isflashorstundamage && hastacticalmask) {
    perkfeedback = "tacticalMask";
  } else {
    if(player hasperk("specialty_fireproof") && loadout::isfiredamage(weapon, smeansofdeath)) {
      perkfeedback = "flakjacket";
    } else {
      if(isexplosivedamage && hasflakjacket && !weapon.ignoresflakjacket && !isaikillstreakdamage(weapon, einflictor)) {
        perkfeedback = "flakjacket";
      } else if(armor_damaged) {
        perkfeedback = "armor";
      }
    }
  }
  return perkfeedback;
}

function isaikillstreakdamage(weapon, einflictor) {
  if(weapon.isaikillstreakdamage) {
    if(weapon.name != "ai_tank_drone_rocket" || isDefined(einflictor.firedbyai)) {
      return true;
    }
  }
  return false;
}

function finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
  pixbeginevent("finishPlayerDamageWrapper");
  if(!level.console && idflags & 8 && isPlayer(eattacker)) {
    println(((((((((("" + self getentitynumber()) + "") + self.health) + "") + eattacker.clientid) + "") + isPlayer(einflictor) + "") + idamage) + "") + shitloc);
    eattacker addplayerstat("penetration_shots", 1);
  }
  if(getdvarstring("scr_csmode") != "") {
    self shellshock("damage_mp", 0.2);
  }
  if(isDefined(level.var_9bb11de9)) {
    self[[level.var_9bb11de9]](eattacker, einflictor, weapon, smeansofdeath, idamage, vpoint);
  } else {
    self damageshellshockandrumble(eattacker, einflictor, weapon, smeansofdeath, idamage);
  }
  self ability_power::power_loss_event_took_damage(eattacker, einflictor, weapon, smeansofdeath, idamage);
  if(isPlayer(eattacker)) {
    self.lastshotby = eattacker.clientid;
  }
  if(smeansofdeath == "MOD_BURNED") {
    self burnplayer::takingburndamage(eattacker, weapon, smeansofdeath);
  }
  self.gadget_was_active_last_damage = self gadgetisactive(0);
  self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
  pixendevent();
}

function allowedassistweapon(weapon) {
  if(!killstreaks::is_killstreak_weapon(weapon)) {
    return true;
  }
  if(killstreaks::is_killstreak_weapon_assist_allowed(weapon)) {
    return true;
  }
  return false;
}

function playerkilled_killstreaks(attacker, weapon) {
  if(!isDefined(self.switching_teams)) {
    if(isPlayer(attacker) && level.teambased && attacker != self && self.team == attacker.team) {
      self.pers["cur_kill_streak"] = 0;
      self.pers["cur_total_kill_streak"] = 0;
      self.pers["totalKillstreakCount"] = 0;
      self.pers["killstreaksEarnedThisKillstreak"] = 0;
      self setplayercurrentstreak(0);
    } else {
      self globallogic_score::incpersstat("deaths", 1, 1, 1);
      self.deaths = self globallogic_score::getpersstat("deaths");
      self updatestatratio("kdratio", "kills", "deaths");
      if(self.pers["cur_kill_streak"] > self.pers["best_kill_streak"]) {
        self.pers["best_kill_streak"] = self.pers["cur_kill_streak"];
      }
      self.pers["kill_streak_before_death"] = self.pers["cur_kill_streak"];
      self.pers["cur_kill_streak"] = 0;
      self.pers["cur_total_kill_streak"] = 0;
      self.pers["totalKillstreakCount"] = 0;
      self.pers["killstreaksEarnedThisKillstreak"] = 0;
      self setplayercurrentstreak(0);
      self.cur_death_streak++;
      if(self.cur_death_streak > self.death_streak) {
        if(level.rankedmatch && !level.disablestattracking) {
          self setdstat("HighestStats", "death_streak", self.cur_death_streak);
        }
        self.death_streak = self.cur_death_streak;
      }
      if(self.cur_death_streak >= getdvarint("perk_deathStreakCountRequired")) {
        self enabledeathstreak();
      }
    }
  } else {
    self.pers["totalKillstreakCount"] = 0;
    self.pers["killstreaksEarnedThisKillstreak"] = 0;
  }
  if(!sessionmodeiszombiesgame() && killstreaks::is_killstreak_weapon(weapon)) {
    level.globalkillstreaksdeathsfrom++;
  }
}

function playerkilled_weaponstats(attacker, weapon, smeansofdeath, wasinlaststand, lastweaponbeforedroppingintolaststand, inflictor) {
  if(isPlayer(attacker) && attacker != self && (!level.teambased || (level.teambased && self.team != attacker.team))) {
    attackerweaponpickedup = 0;
    if(isDefined(attacker.pickedupweapons) && isDefined(attacker.pickedupweapons[weapon])) {
      attackerweaponpickedup = 1;
    }
    self addweaponstat(weapon, "deaths", 1, self.class_num, attackerweaponpickedup, undefined, self.primaryloadoutgunsmithvariantindex, self.secondaryloadoutgunsmithvariantindex);
    if(wasinlaststand && isDefined(lastweaponbeforedroppingintolaststand)) {
      victim_weapon = lastweaponbeforedroppingintolaststand;
    } else {
      victim_weapon = self.lastdroppableweapon;
    }
    if(isDefined(victim_weapon)) {
      victimweaponpickedup = 0;
      if(isDefined(self.pickedupweapons) && isDefined(self.pickedupweapons[victim_weapon])) {
        victimweaponpickedup = 1;
      }
      self addweaponstat(victim_weapon, "deathsDuringUse", 1, self.class_num, victimweaponpickedup, undefined, self.primaryloadoutgunsmithvariantindex, self.secondaryloadoutgunsmithvariantindex);
    }
    recordweaponstatkills = 1;
    if(attacker.isthief === 1 && isDefined(weapon) && weapon.isheroweapon === 1) {
      recordweaponstatkills = 0;
    }
    if(smeansofdeath != "MOD_FALLING" && recordweaponstatkills) {
      if(weapon.name == "explosive_bolt" && isDefined(inflictor) && isDefined(inflictor.ownerweaponatlaunch) && inflictor.owneradsatlaunch) {
        inflictorownerweaponatlaunchpickedup = 0;
        if(isDefined(attacker.pickedupweapons) && isDefined(attacker.pickedupweapons[inflictor.ownerweaponatlaunch])) {
          inflictorownerweaponatlaunchpickedup = 1;
        }
        attacker addweaponstat(inflictor.ownerweaponatlaunch, "kills", 1, attacker.class_num, inflictorownerweaponatlaunchpickedup, 1, attacker.primaryloadoutgunsmithvariantindex, attacker.secondaryloadoutgunsmithvariantindex);
      } else if(isDefined(attacker) && isDefined(attacker.class_num)) {
        attacker addweaponstat(weapon, "kills", 1, attacker.class_num, attackerweaponpickedup, undefined, attacker.primaryloadoutgunsmithvariantindex, attacker.secondaryloadoutgunsmithvariantindex);
      }
    }
    if(smeansofdeath == "MOD_HEAD_SHOT") {
      attacker addweaponstat(weapon, "headshots", 1, attacker.class_num, attackerweaponpickedup, undefined, attacker.primaryloadoutgunsmithvariantindex, attacker.secondaryloadoutgunsmithvariantindex);
    }
    if(smeansofdeath == "MOD_PROJECTILE" || (smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_IMPACT" && weapon.rootweapon.statindex == level.weaponlauncherex41.statindex)) {
      attacker addweaponstat(weapon, "direct_hit_kills", 1);
    }
    victimisroulette = self.isroulette === 1;
    if(self ability_player::gadget_checkheroabilitykill(attacker) && !victimisroulette) {
      attacker addweaponstat(attacker.heroability, "kills_while_active", 1);
    }
  }
}

function playerkilled_obituary(attacker, einflictor, weapon, smeansofdeath) {
  if(!isPlayer(attacker) || self util::isenemyplayer(attacker) == 0 || (isDefined(weapon) && killstreaks::is_killstreak_weapon(weapon))) {
    level notify("reset_obituary_count");
    level.lastobituaryplayercount = 0;
    level.lastobituaryplayer = undefined;
  } else {
    if(isDefined(level.lastobituaryplayer) && level.lastobituaryplayer == attacker) {
      level.lastobituaryplayercount++;
    } else {
      level notify("reset_obituary_count");
      level.lastobituaryplayer = attacker;
      level.lastobituaryplayercount = 1;
    }
    level thread scoreevents::decrementlastobituaryplayercountafterfade();
    if(level.lastobituaryplayercount >= 4) {
      level notify("reset_obituary_count");
      level.lastobituaryplayercount = 0;
      level.lastobituaryplayer = undefined;
      self thread scoreevents::uninterruptedobitfeedkills(attacker, weapon);
    }
  }
  if(!isPlayer(attacker) || (isDefined(weapon) && !killstreaks::is_killstreak_weapon(weapon))) {
    behaviortracker::updateplayerkilled(attacker, self);
  }
  overrideentitycamera = killstreaks::should_override_entity_camera_in_demo(attacker, weapon);
  if(isDefined(einflictor) && einflictor.archetype === "robot") {
    if(smeansofdeath == "MOD_HIT_BY_OBJECT") {
      weapon = getweapon("combat_robot_marker");
    }
    smeansofdeath = "MOD_RIFLE_BULLET";
  }
  if(level.teambased && isDefined(attacker.pers) && self.team == attacker.team && smeansofdeath == "MOD_GRENADE" && level.friendlyfire == 0) {
    obituary(self, self, weapon, smeansofdeath);
    demo::bookmark("kill", gettime(), self, self, 0, einflictor, overrideentitycamera);
  } else {
    obituary(self, attacker, weapon, smeansofdeath);
    demo::bookmark("kill", gettime(), attacker, self, 0, einflictor, overrideentitycamera);
  }
}

function playerkilled_suicide(einflictor, attacker, smeansofdeath, weapon, shitloc) {
  awardassists = 0;
  self.suicide = 0;
  if(isDefined(self.switching_teams)) {
    if(!level.teambased && (isDefined(level.teams[self.leaving_team]) && isDefined(level.teams[self.joining_team]) && level.teams[self.leaving_team] != level.teams[self.joining_team])) {
      playercounts = self teams::count_players();
      playercounts[self.leaving_team]--;
      playercounts[self.joining_team]++;
      if((playercounts[self.joining_team] - playercounts[self.leaving_team]) > 1) {
        scoreevents::processscoreevent("suicide", self);
        self thread rank::giverankxp("suicide");
        self globallogic_score::incpersstat("suicides", 1);
        self.suicides = self globallogic_score::getpersstat("suicides");
        self.suicide = 1;
      }
    }
  } else {
    scoreevents::processscoreevent("suicide", self);
    self globallogic_score::incpersstat("suicides", 1);
    self.suicides = self globallogic_score::getpersstat("suicides");
    if(smeansofdeath == "MOD_SUICIDE" && shitloc == "none" && self.throwinggrenade) {
      self.lastgrenadesuicidetime = gettime();
    }
    if(level.maxsuicidesbeforekick > 0 && level.maxsuicidesbeforekick <= self.suicides) {
      self notify("teamkillkicked");
      self suicidekick();
    }
    thread battlechatter::on_player_suicide_or_team_kill(self, "suicide");
    awardassists = 1;
    self.suicide = 1;
  }
  if(isDefined(self.friendlydamage)) {
    self iprintln(&"MP_FRIENDLY_FIRE_WILL_NOT");
    if(level.teamkillpointloss) {
      scoresub = self[[level.getteamkillscore]](einflictor, attacker, smeansofdeath, weapon);
      score = globallogic_score::_getplayerscore(attacker) - scoresub;
      if(score < 0) {
        score = 0;
      }
      globallogic_score::_setplayerscore(attacker, score);
    }
  }
  return awardassists;
}

function playerkilled_teamkill(einflictor, attacker, smeansofdeath, weapon, shitloc) {
  scoreevents::processscoreevent("team_kill", attacker);
  self.teamkilled = 1;
  if(!ignoreteamkills(weapon, smeansofdeath, einflictor)) {
    teamkill_penalty = self[[level.getteamkillpenalty]](einflictor, attacker, smeansofdeath, weapon);
    attacker globallogic_score::incpersstat("teamkills_nostats", teamkill_penalty, 0);
    attacker globallogic_score::incpersstat("teamkills", 1);
    attacker.teamkillsthisround++;
    if(level.teamkillpointloss) {
      scoresub = self[[level.getteamkillscore]](einflictor, attacker, smeansofdeath, weapon);
      score = globallogic_score::_getplayerscore(attacker) - scoresub;
      if(score < 0) {
        score = 0;
      }
      globallogic_score::_setplayerscore(attacker, score);
    }
    if(globallogic_utils::gettimepassed() < 5000) {
      teamkilldelay = 1;
    } else {
      if(attacker.pers["teamkills_nostats"] > 1 && globallogic_utils::gettimepassed() < (8000 + (attacker.pers["teamkills_nostats"] * 1000))) {
        teamkilldelay = 1;
      } else {
        teamkilldelay = attacker teamkilldelay();
      }
    }
    if(teamkilldelay > 0) {
      attacker.teamkillpunish = 1;
      attacker thread wait_and_suicide();
      if(attacker shouldteamkillkick(teamkilldelay)) {
        attacker notify("teamkillkicked");
        attacker thread teamkillkick();
      }
      attacker thread reduceteamkillsovertime();
    }
    if(isPlayer(attacker)) {
      thread battlechatter::on_player_suicide_or_team_kill(attacker, "teamkill");
    }
  }
}

function wait_and_suicide() {
  self endon("disconnect");
  self util::freeze_player_controls(1);
  wait(0.25);
  self suicide();
}

function playerkilled_awardassists(einflictor, attacker, weapon, lpattackteam) {
  pixbeginevent("PlayerKilled assists");
  if(isDefined(self.attackers)) {
    for(j = 0; j < self.attackers.size; j++) {
      player = self.attackers[j];
      if(!isDefined(player)) {
        continue;
      }
      if(player == attacker) {
        continue;
      }
      if(player.team != lpattackteam) {
        continue;
      }
      damage_done = self.attackerdamage[player.clientid].damage;
      player thread globallogic_score::processassist(self, damage_done, self.attackerdamage[player.clientid].weapon);
    }
  }
  if(level.teambased) {
    self globallogic_score::processkillstreakassists(attacker, einflictor, weapon);
  }
  if(isDefined(self.lastattackedshieldplayer) && isDefined(self.lastattackedshieldtime) && self.lastattackedshieldplayer != attacker) {
    if((gettime() - self.lastattackedshieldtime) < 4000) {
      self.lastattackedshieldplayer thread globallogic_score::processshieldassist(self);
    }
  }
  pixendevent();
}

function playerkilled_kill(einflictor, attacker, smeansofdeath, weapon, shitloc) {
  if(!isDefined(killstreaks::get_killstreak_for_weapon(weapon)) || (isDefined(level.killstreaksgivegamescore) && level.killstreaksgivegamescore)) {
    globallogic_score::inctotalkills(attacker.team);
  }
  if(getdvarint("teamOpsEnabled") == 1) {
    if(isDefined(einflictor) && (isDefined(einflictor.teamops) && einflictor.teamops)) {
      if(!isDefined(killstreaks::get_killstreak_for_weapon(weapon)) || (isDefined(level.killstreaksgivegamescore) && level.killstreaksgivegamescore)) {
        globallogic_score::giveteamscore("kill", attacker.team, undefined, self);
      }
      return;
    }
  }
  attacker thread globallogic_score::givekillstats(smeansofdeath, weapon, self);
  if(isalive(attacker)) {
    pixbeginevent("killstreak");
    if(!isDefined(einflictor) || !isDefined(einflictor.requireddeathcount) || attacker.deathcount == einflictor.requireddeathcount) {
      shouldgivekillstreak = killstreaks::should_give_killstreak(weapon);
      if(shouldgivekillstreak) {
        attacker killstreaks::add_to_killstreak_count(weapon);
      }
      attacker.pers["cur_total_kill_streak"]++;
      attacker setplayercurrentstreak(attacker.pers["cur_total_kill_streak"]);
      if(isDefined(level.killstreaks) && shouldgivekillstreak) {
        attacker.pers["cur_kill_streak"]++;
        if(attacker.pers["cur_kill_streak"] >= 2) {
          if(attacker.pers["cur_kill_streak"] == 10) {
            attacker challenges::killstreakten();
          }
          if(attacker.pers["cur_kill_streak"] <= 30) {
            scoreevents::processscoreevent("killstreak_" + attacker.pers["cur_kill_streak"], attacker, self, weapon);
            if(attacker.pers["cur_kill_streak"] == 30) {
              attacker challenges::killstreak_30_noscorestreaks();
            }
          } else {
            scoreevents::processscoreevent("killstreak_more_than_30", attacker, self, weapon);
          }
        }
        if(!isDefined(level.usingmomentum) || !level.usingmomentum) {
          if(getdvarint("teamOpsEnabled") == 0) {
            attacker thread killstreaks::give_for_streak();
          }
        }
      }
    }
    pixendevent();
  }
  if(attacker.pers["cur_kill_streak"] > attacker.kill_streak) {
    if(level.rankedmatch && !level.disablestattracking) {
      attacker setdstat("HighestStats", "kill_streak", attacker.pers["totalKillstreakCount"]);
    }
    attacker.kill_streak = attacker.pers["cur_kill_streak"];
  }
  if(attacker.pers["cur_kill_streak"] > attacker.gametype_kill_streak) {
    attacker persistence::stat_set_with_gametype("kill_streak", attacker.pers["cur_kill_streak"]);
    attacker.gametype_kill_streak = attacker.pers["cur_kill_streak"];
  }
  killstreak = killstreaks::get_killstreak_for_weapon(weapon);
  if(isDefined(killstreak)) {
    if(scoreevents::isregisteredevent(killstreak)) {
      scoreevents::processscoreevent(killstreak, attacker, self, weapon);
    }
    if(isDefined(einflictor) && (killstreak == "dart" || killstreak == "inventory_dart")) {
      einflictor notify("veh_collision");
    }
  } else {
    scoreevents::processscoreevent("kill", attacker, self, weapon);
    if(smeansofdeath == "MOD_HEAD_SHOT") {
      scoreevents::processscoreevent("headshot", attacker, self, weapon);
      attacker util::player_contract_event("headshot");
    } else if(weapon_utils::ismeleemod(smeansofdeath)) {
      scoreevents::processscoreevent("melee_kill", attacker, self, weapon);
    }
  }
  attacker thread globallogic_score::trackattackerkill(self.name, self.pers["rank"], self.pers["rankxp"], self.pers["prestige"], self getxuid(), weapon);
  attackername = attacker.name;
  self thread globallogic_score::trackattackeedeath(attackername, attacker.pers["rank"], attacker.pers["rankxp"], attacker.pers["prestige"], attacker getxuid());
  self thread medals::setlastkilledby(attacker);
  attacker thread globallogic_score::inckillstreaktracker(weapon);
  if(level.teambased && attacker.team != "spectator") {
    if(!isDefined(killstreak) || (isDefined(level.killstreaksgivegamescore) && level.killstreaksgivegamescore)) {
      globallogic_score::giveteamscore("kill", attacker.team, attacker, self);
    }
  }
  scoresub = level.deathpointloss;
  if(scoresub != 0) {
    globallogic_score::_setplayerscore(self, globallogic_score::_getplayerscore(self) - scoresub);
  }
  level thread playkillbattlechatter(attacker, weapon, self, einflictor);
}

function should_allow_postgame_death(smeansofdeath) {
  if(smeansofdeath == "MOD_POST_GAME") {
    return true;
  }
  return false;
}

function do_post_game_death(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(!should_allow_postgame_death(smeansofdeath)) {
    return;
  }
  self weapons::detach_carry_object_model();
  self.sessionstate = "dead";
  self.spectatorclient = -1;
  self.killcamentity = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  clone_weapon = weapon;
  if(weapon_utils::ismeleemod(smeansofdeath) && clone_weapon.type != "melee") {
    clone_weapon = level.weaponnone;
  }
  body = self cloneplayer(deathanimduration, clone_weapon, attacker);
  if(isDefined(body)) {
    self createdeadbody(attacker, idamage, smeansofdeath, weapon, shitloc, vdir, (0, 0, 0), deathanimduration, einflictor, body);
  }
}

function callback_playerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration, enteredresurrect = 0) {
  profilelog_begintiming(7, "ship");
  self endon("spawned");
  if(game["state"] == "postgame") {
    do_post_game_death(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
    return;
  }
  if(self.sessionteam == "spectator") {
    return;
  }
  self notify("killed_player");
  self callback::callback("hash_bc435202");
  self needsrevive(0);
  if(isDefined(self.burning) && self.burning == 1) {
    self setburn(0);
  }
  self.suicide = 0;
  self.teamkilled = 0;
  if(isDefined(level.takelivesondeath) && level.takelivesondeath == 1) {
    if(self.pers["lives"]) {
      self.pers["lives"]--;
      if(self.pers["lives"] == 0) {
        level notify("player_eliminated");
        self notify("player_eliminated");
      }
    }
    if(game[self.team + "_lives"]) {
      game[self.team + "_lives"]--;
      if((game[self.team + "_lives"]) == 0) {
        level notify("player_eliminated");
        self notify("player_eliminated");
      }
    }
  }
  self thread globallogic_audio::flush_leader_dialog_key_on_player("equipmentDestroyed");
  weapon = updateweapon(einflictor, weapon);
  pixbeginevent("PlayerKilled pre constants");
  wasinlaststand = 0;
  bledout = 0;
  deathtimeoffset = 0;
  lastweaponbeforedroppingintolaststand = undefined;
  attackerstance = undefined;
  self.laststandthislife = undefined;
  self.vattackerorigin = undefined;
  weapon_at_time_of_death = self getcurrentweapon();
  if(isDefined(self.uselaststandparams) && enteredresurrect == 0) {
    self.uselaststandparams = undefined;
    assert(isDefined(self.laststandparams));
    if(!level.teambased || (!isDefined(attacker) || !isPlayer(attacker) || attacker.team != self.team || attacker == self)) {
      einflictor = self.laststandparams.einflictor;
      attacker = self.laststandparams.attacker;
      attackerstance = self.laststandparams.attackerstance;
      idamage = self.laststandparams.idamage;
      smeansofdeath = self.laststandparams.smeansofdeath;
      weapon = self.laststandparams.sweapon;
      vdir = self.laststandparams.vdir;
      shitloc = self.laststandparams.shitloc;
      self.vattackerorigin = self.laststandparams.vattackerorigin;
      self.killcam_entity_info_cached = self.laststandparams.killcam_entity_info_cached;
      deathtimeoffset = (gettime() - self.laststandparams.laststandstarttime) / 1000;
      bledout = 1;
      if(isDefined(self.previousprimary)) {
        wasinlaststand = 1;
        lastweaponbeforedroppingintolaststand = self.previousprimary;
      }
    }
    self.laststandparams = undefined;
  }
  self stopsounds();
  bestplayer = undefined;
  bestplayermeansofdeath = undefined;
  obituarymeansofdeath = undefined;
  bestplayerweapon = undefined;
  obituaryweapon = weapon;
  assistedsuicide = 0;
  if(isDefined(level.var_7d4f8220)) {
    result = self[[level.var_7d4f8220]](attacker, smeansofdeath, weapon);
    if(isDefined(result)) {
      bestplayer = result["bestPlayer"];
      bestplayermeansofdeath = result["bestPlayerMeansOfDeath"];
      bestplayerweapon = result["bestPlayerWeapon"];
    }
  }
  if(!isDefined(attacker) || attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn" || (isDefined(attacker.ismagicbullet) && attacker.ismagicbullet == 1) || attacker == self && isDefined(self.attackers) && !self isplayerunderwater()) {
    if(!isDefined(bestplayer)) {
      for(i = 0; i < self.attackers.size; i++) {
        player = self.attackers[i];
        if(!isDefined(player)) {
          continue;
        }
        if(!isDefined(self.attackerdamage[player.clientid]) || !isDefined(self.attackerdamage[player.clientid].damage)) {
          continue;
        }
        if(player == self || (level.teambased && player.team == self.team)) {
          continue;
        }
        if((self.attackerdamage[player.clientid].lasttimedamaged + 2500) < gettime()) {
          continue;
        }
        if(!allowedassistweapon(self.attackerdamage[player.clientid].weapon)) {
          continue;
        }
        if(self.attackerdamage[player.clientid].damage > 1 && !isDefined(bestplayer)) {
          bestplayer = player;
          bestplayermeansofdeath = self.attackerdamage[player.clientid].meansofdeath;
          bestplayerweapon = self.attackerdamage[player.clientid].weapon;
          continue;
        }
        if(isDefined(bestplayer) && self.attackerdamage[player.clientid].damage > self.attackerdamage[bestplayer.clientid].damage) {
          bestplayer = player;
          bestplayermeansofdeath = self.attackerdamage[player.clientid].meansofdeath;
          bestplayerweapon = self.attackerdamage[player.clientid].weapon;
        }
      }
    }
    if(isDefined(bestplayer)) {
      scoreevents::processscoreevent("assisted_suicide", bestplayer, self, weapon);
      self recordkillmodifier("assistedsuicide");
      assistedsuicide = 1;
    }
  }
  if(isDefined(bestplayer)) {
    attacker = bestplayer;
    obituarymeansofdeath = bestplayermeansofdeath;
    obituaryweapon = bestplayerweapon;
    if(isDefined(bestplayerweapon)) {
      weapon = bestplayerweapon;
    }
  }
  if(isPlayer(attacker) && isDefined(attacker.damagedplayers)) {
    attacker.damagedplayers[self.clientid] = undefined;
  }
  if(enteredresurrect == 0) {
    globallogic::doweaponspecifickilleffects(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
  }
  self.deathtime = gettime();
  if(attacker != self && (!level.teambased || attacker.team != self.team)) {
    assert(isDefined(self.lastspawntime));
    self.alivetimes[self.alivetimecurrentindex] = self.deathtime - self.lastspawntime;
    self.alivetimecurrentindex = (self.alivetimecurrentindex + 1) % level.alivetimemaxcount;
  }
  attacker = updateattacker(attacker, weapon);
  einflictor = updateinflictor(einflictor);
  smeansofdeath = self playerkilled_updatemeansofdeath(attacker, einflictor, weapon, smeansofdeath, shitloc);
  if(!isDefined(obituarymeansofdeath)) {
    obituarymeansofdeath = smeansofdeath;
  }
  self.hasriotshield = 0;
  self.hasriotshieldequipped = 0;
  self thread updateglobalbotkilledcounter();
  self playerkilled_weaponstats(attacker, weapon, smeansofdeath, wasinlaststand, lastweaponbeforedroppingintolaststand, einflictor);
  if(bledout == 0) {
    if(getdvarint("teamOpsEnabled") == 1 && (isDefined(einflictor) && (isDefined(einflictor.teamops) && einflictor.teamops))) {
      self playerkilled_obituary(einflictor, einflictor, obituaryweapon, obituarymeansofdeath);
    } else {
      self playerkilled_obituary(attacker, einflictor, obituaryweapon, obituarymeansofdeath);
    }
  }
  if(enteredresurrect == 0) {
    self.sessionstate = "dead";
    self.statusicon = "hud_status_dead";
  }
  self.pers["weapon"] = undefined;
  self.killedplayerscurrent = [];
  self.deathcount++;
  println((("" + self.clientid) + "") + self.deathcount);
  if(bledout == 0) {
    self playerkilled_killstreaks(attacker, weapon);
  }
  lpselfnum = self getentitynumber();
  lpselfname = self.name;
  lpattackguid = "";
  lpattackname = "";
  lpselfteam = self.team;
  lpselfguid = self getguid();
  lpattackteam = "";
  lpattackorigin = (0, 0, 0);
  lpattacknum = -1;
  awardassists = 0;
  wasteamkill = 0;
  wassuicide = 0;
  pixendevent();
  scoreevents::processscoreevent("death", self, self, weapon);
  self.pers["resetMomentumOnSpawn"] = level.scoreresetondeath;
  if(isPlayer(attacker)) {
    lpattackguid = attacker getguid();
    lpattackname = attacker.name;
    lpattackteam = attacker.team;
    lpattackorigin = attacker.origin;
    if(attacker == self || assistedsuicide == 1) {
      dokillcam = 0;
      wassuicide = 1;
      awardassists = self playerkilled_suicide(einflictor, attacker, smeansofdeath, weapon, shitloc);
      if(assistedsuicide == 1) {
        attacker thread globallogic_score::givekillstats(smeansofdeath, weapon, self);
      }
    } else {
      pixbeginevent("PlayerKilled attacker");
      lpattacknum = attacker getentitynumber();
      dokillcam = 1;
      if(level.teambased && self.team == attacker.team && smeansofdeath == "MOD_GRENADE" && level.friendlyfire == 0) {} else {
        if(level.teambased && self.team == attacker.team) {
          wasteamkill = 1;
          self playerkilled_teamkill(einflictor, attacker, smeansofdeath, weapon, shitloc);
        } else if(bledout == 0) {
          self playerkilled_kill(einflictor, attacker, smeansofdeath, weapon, shitloc);
          if(level.teambased) {
            awardassists = 1;
          }
        }
      }
      pixendevent();
    }
  } else {
    if(isDefined(attacker) && (attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn")) {
      dokillcam = 0;
      lpattacknum = -1;
      lpattackguid = "";
      lpattackname = "";
      lpattackteam = "world";
      scoreevents::processscoreevent("suicide", self);
      self globallogic_score::incpersstat("suicides", 1);
      self.suicides = self globallogic_score::getpersstat("suicides");
      self.suicide = 1;
      thread battlechatter::on_player_suicide_or_team_kill(self, "suicide");
      awardassists = 1;
      if(level.maxsuicidesbeforekick > 0 && level.maxsuicidesbeforekick <= self.suicides) {
        self notify("teamkillkicked");
        self suicidekick();
      }
    } else {
      dokillcam = 0;
      lpattacknum = -1;
      lpattackguid = "";
      lpattackname = "";
      lpattackteam = "world";
      wassuicide = 1;
      if(isDefined(einflictor) && isDefined(einflictor.killcament)) {
        dokillcam = 1;
        lpattacknum = self getentitynumber();
        wassuicide = 0;
      }
      if(isDefined(attacker) && isDefined(attacker.team) && isDefined(level.teams[attacker.team])) {
        if(attacker.team != self.team) {
          if(level.teambased) {
            if(!isDefined(killstreaks::get_killstreak_for_weapon(weapon)) || (isDefined(level.killstreaksgivegamescore) && level.killstreaksgivegamescore)) {
              globallogic_score::giveteamscore("kill", attacker.team, attacker, self);
            }
          }
          wassuicide = 0;
        }
      }
      awardassists = 1;
    }
  }
  if(!level.ingraceperiod && enteredresurrect == 0) {
    if(smeansofdeath != "MOD_GRENADE" && smeansofdeath != "MOD_GRENADE_SPLASH" && smeansofdeath != "MOD_EXPLOSIVE" && smeansofdeath != "MOD_EXPLOSIVE_SPLASH" && smeansofdeath != "MOD_PROJECTILE_SPLASH" && smeansofdeath != "MOD_FALLING") {
      if(weapon.name != "incendiary_fire") {
        self weapons::drop_scavenger_for_death(attacker);
      }
    }
    if(should_drop_weapon_on_death(wasteamkill, wassuicide, weapon_at_time_of_death, smeansofdeath)) {
      self weapons::drop_for_death(attacker, weapon, smeansofdeath);
    }
  }
  if(awardassists) {
    self playerkilled_awardassists(einflictor, attacker, weapon, lpattackteam);
  }
  pixbeginevent("PlayerKilled post constants");
  self.lastattacker = attacker;
  self.lastdeathpos = self.origin;
  if(isDefined(attacker) && isPlayer(attacker) && attacker != self && (!level.teambased || attacker.team != self.team)) {
    attacker notify("killed_enemy_player", self, weapon);
    if(isDefined(attacker.gadget_thief_kill_callback)) {
      attacker[[attacker.gadget_thief_kill_callback]](self, weapon);
    }
    self thread challenges::playerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, shitloc, attackerstance, bledout);
  } else {
    self notify("playerkilledchallengesprocessed");
  }
  if(isDefined(self.attackers)) {
    self.attackers = [];
  }
  killerheropoweractive = 0;
  killer = undefined;
  killerloadoutindex = -1;
  killerwasads = 0;
  killerinvictimfov = 0;
  victiminkillerfov = 0;
  if(isPlayer(attacker)) {
    attacker.lastkilltime = gettime();
    killer = attacker;
    if(isDefined(attacker.class_num)) {
      killerloadoutindex = attacker.class_num;
    }
    killerwasads = attacker playerads() >= 1;
    killerinvictimfov = util::within_fov(self.origin, self.angles, attacker.origin, self.fovcosine);
    victiminkillerfov = util::within_fov(attacker.origin, attacker.angles, self.origin, attacker.fovcosine);
    if(attacker ability_player::is_using_any_gadget()) {
      killerheropoweractive = 1;
    }
    if(killstreaks::is_killstreak_weapon(weapon)) {
      killstreak = killstreaks::get_killstreak_for_weapon_for_stats(weapon);
      bbprint("mpattacks", "gametime %d attackerspawnid %d attackerweapon %s attackerx %d attackery %d attackerz %d victimspawnid %d victimx %d victimy %d victimz %d damage %d damagetype %s damagelocation %s death %d isusingheropower %d killstreak %s", gettime(), getplayerspawnid(attacker), weapon.name, lpattackorigin, getplayerspawnid(self), self.origin, idamage, smeansofdeath, shitloc, 1, killerheropoweractive, killstreak);
    } else {
      bbprint("mpattacks", "gametime %d attackerspawnid %d attackerweapon %s attackerx %d attackery %d attackerz %d victimspawnid %d victimx %d victimy %d victimz %d damage %d damagetype %s damagelocation %s death %d isusingheropower %d", gettime(), getplayerspawnid(attacker), weapon.name, lpattackorigin, getplayerspawnid(self), self.origin, idamage, smeansofdeath, shitloc, 1, killerheropoweractive);
    }
    attacker thread weapons::bestweapon_kill(weapon);
  } else {
    bbprint("mpattacks", "gametime %d attackerweapon %s victimspawnid %d victimx %d victimy %d victimz %d damage %d damagetype %s damagelocation %s death %d isusingheropower %d", gettime(), weapon.name, getplayerspawnid(self), self.origin, idamage, smeansofdeath, shitloc, 1, 0);
  }
  victimweapon = undefined;
  victimweaponpickedup = 0;
  victimkillstreakweaponindex = 0;
  if(isDefined(weapon_at_time_of_death)) {
    victimweapon = weapon_at_time_of_death;
    if(isDefined(self.pickedupweapons) && isDefined(self.pickedupweapons[victimweapon])) {
      victimweaponpickedup = 1;
    }
    if(killstreaks::is_killstreak_weapon(victimweapon)) {
      killstreak = killstreaks::get_killstreak_for_weapon_for_stats(victimweapon);
      if(isDefined(level.killstreaks[killstreak].menuname)) {
        victimkillstreakweaponindex = level.killstreakindices[level.killstreaks[killstreak].menuname];
      }
    }
  }
  victimwasads = self playerads() >= 1;
  victimheropoweractive = self ability_player::is_using_any_gadget();
  killerweaponpickedup = 0;
  killerkillstreakweaponindex = 0;
  killerkillstreakeventindex = 125;
  if(isDefined(weapon)) {
    if(isDefined(killer) && isDefined(killer.pickedupweapons) && isDefined(killer.pickedupweapons[weapon])) {
      killerweaponpickedup = 1;
    }
    if(killstreaks::is_killstreak_weapon(weapon)) {
      killstreak = killstreaks::get_killstreak_for_weapon_for_stats(weapon);
      if(isDefined(level.killstreaks[killstreak].menuname)) {
        killerkillstreakweaponindex = level.killstreakindices[level.killstreaks[killstreak].menuname];
        if(isDefined(killer.killstreakevents) && isDefined(killer.killstreakevents[killerkillstreakweaponindex])) {
          killerkillstreakeventindex = killer.killstreakevents[killerkillstreakweaponindex];
        } else {
          killerkillstreakeventindex = 126;
        }
      }
    }
  }
  matchrecordlogadditionaldeathinfo(self, killer, victimweapon, weapon, self.class_num, victimweaponpickedup, victimwasads, killerloadoutindex, killerweaponpickedup, killerwasads, victimheropoweractive, killerheropoweractive, victiminkillerfov, killerinvictimfov, killerkillstreakweaponindex, victimkillstreakweaponindex, killerkillstreakeventindex);
  self record_special_move_data_for_life(killer);
  self.pickedupweapons = [];
  logprint(((((((((((((((((((((((("" + lpselfguid) + "") + lpselfnum) + "") + lpselfteam) + "") + lpselfname) + "") + lpattackguid) + "") + lpattacknum) + "") + lpattackteam) + "") + lpattackname) + "") + weapon.name) + "") + idamage) + "") + smeansofdeath) + "") + shitloc) + "");
  attackerstring = "none";
  if(isPlayer(attacker)) {
    attackerstring = ((attacker getxuid() + "(") + lpattackname) + ")";
  }
  print((((((((((((("" + smeansofdeath) + "") + weapon.name) + "") + attackerstring) + "") + idamage) + "") + shitloc) + "") + int(self.origin[0]) + "") + int(self.origin[1]) + "") + int(self.origin[2]));
  if(!level.rankedmatch && !level.teambased) {
    level thread update_ffa_top_scorers();
  }
  level thread globallogic::updateteamstatus();
  level thread globallogic::updatealivetimes(self.team);
  if(isDefined(self.killcam_entity_info_cached)) {
    killcam_entity_info = self.killcam_entity_info_cached;
    self.killcam_entity_info_cached = undefined;
  } else {
    killcam_entity_info = killcam::get_killcam_entity_info(attacker, einflictor, weapon);
  }
  if(isDefined(self.killstreak_delay_killcam)) {
    dokillcam = 0;
  }
  self weapons::detach_carry_object_model();
  pixendevent();
  pixbeginevent("PlayerKilled body and gibbing");
  vattackerorigin = undefined;
  if(isDefined(attacker)) {
    vattackerorigin = attacker.origin;
  }
  if(enteredresurrect == 0) {
    clone_weapon = weapon;
    if(weapon_utils::ismeleemod(smeansofdeath) && clone_weapon.type != "melee") {
      clone_weapon = level.weaponnone;
    }
    body = self cloneplayer(deathanimduration, clone_weapon, attacker);
    if(isDefined(body)) {
      self createdeadbody(attacker, idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, body);
      if(isDefined(level.var_a58db931)) {
        self[[level.var_a58db931]](body, attacker, weapon, smeansofdeath);
      } else {
        self battlechatter::play_death_vox(body, attacker, weapon, smeansofdeath);
      }
      globallogic::doweaponspecificcorpseeffects(body, einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
    }
  }
  pixendevent();
  if(enteredresurrect) {
    thread globallogic_spawn::spawnqueuedclient(self.team, attacker);
  }
  self.switching_teams = undefined;
  self.joining_team = undefined;
  self.leaving_team = undefined;
  if(bledout == 0) {
    self thread[[level.onplayerkilled]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
  }
  if(isDefined(level.teamopsonplayerkilled)) {
    self[[level.teamopsonplayerkilled]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
  }
  for(icb = 0; icb < level.onplayerkilledextraunthreadedcbs.size; icb++) {
    self[[level.onplayerkilledextraunthreadedcbs[icb]]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
  }
  self.wantsafespawn = 0;
  perks = [];
  killstreaks = globallogic::getkillstreaks(attacker);
  if(!isDefined(self.killstreak_delay_killcam)) {
    self thread[[level.spawnplayerprediction]]();
  }
  profilelog_endtiming(7, (("gs=" + game["state"]) + " zom=") + sessionmodeiszombiesgame());
  if(wasteamkill == 0 && assistedsuicide == 0 && smeansofdeath != "MOD_SUICIDE" && (!(!isDefined(attacker) || attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn" || attacker == self || isDefined(attacker.disablefinalkillcam)))) {
    level thread killcam::record_settings(lpattacknum, self getentitynumber(), weapon, smeansofdeath, self.deathtime, deathtimeoffset, psoffsettime, killcam_entity_info, perks, killstreaks, attacker);
  }
  if(enteredresurrect) {
    return;
  }
  wait(0.25);
  weaponclass = util::getweaponclass(weapon);
  if(isDefined(weaponclass) && weaponclass == "weapon_sniper") {
    self thread battlechatter::killed_by_sniper(attacker);
  } else {
    self thread battlechatter::player_killed(attacker, killstreak);
  }
  self.cancelkillcam = 0;
  self thread killcam::cancel_on_use();
  self playerkilled_watch_death(weapon, smeansofdeath, deathanimduration);
  if(getdvarint("") != 0) {
    dokillcam = 1;
    if(lpattacknum < 0) {
      lpattacknum = self getentitynumber();
    }
  }
  if(game["state"] != "playing") {
    return;
  }
  self.respawntimerstarttime = gettime();
  keep_deathcam = 0;
  if(isDefined(self.overrideplayerdeadstatus)) {
    keep_deathcam = self[[self.overrideplayerdeadstatus]]();
  }
  if(!self.cancelkillcam && dokillcam && level.killcam && wasteamkill == 0) {
    livesleft = !(level.numlives && !self.pers["lives"]) && (!(level.numteamlives && !game[self.team + "_lives"]));
    timeuntilspawn = globallogic_spawn::timeuntilspawn(1);
    willrespawnimmediately = livesleft && timeuntilspawn <= 0 && !level.playerqueuedrespawn;
    self killcam::killcam(lpattacknum, self getentitynumber(), killcam_entity_info, weapon, smeansofdeath, self.deathtime, deathtimeoffset, psoffsettime, willrespawnimmediately, globallogic_utils::timeuntilroundend(), perks, killstreaks, attacker, keep_deathcam);
  } else if(self.cancelkillcam) {
    if(isDefined(self.killcamsskipped)) {
      self.killcamsskipped++;
    } else {
      self.killcamsskipped = 1;
    }
  }
  secondary_deathcam = 0;
  timeuntilspawn = globallogic_spawn::timeuntilspawn(1);
  shoulddoseconddeathcam = timeuntilspawn > 0;
  if(shoulddoseconddeathcam && isDefined(self.secondarydeathcamtime)) {
    secondary_deathcam = self[[self.secondarydeathcamtime]]();
  }
  if(secondary_deathcam > 0 && !self.cancelkillcam) {
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
    globallogic_utils::waitfortimeornotify(secondary_deathcam, "end_death_delay");
    self notify("death_delay_finished");
  }
  if(!self.cancelkillcam && dokillcam && level.killcam && keep_deathcam) {
    self.sessionstate = "dead";
    self.spectatorclient = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
  }
  if(game["state"] != "playing") {
    self.sessionstate = "dead";
    self.spectatorclient = -1;
    self.killcamtargetentity = -1;
    self.killcamentity = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    self.spectatekillcam = 0;
    return;
  }
  waittillkillstreakdone();
  userespawntime = 1;
  if(isDefined(level.hostmigrationtimer)) {
    userespawntime = 0;
  }
  hostmigration::waittillhostmigrationcountdown();
  if(globallogic_utils::isvalidclass(self.curclass)) {
    timepassed = undefined;
    if(isDefined(self.respawntimerstarttime) && userespawntime) {
      timepassed = (gettime() - self.respawntimerstarttime) / 1000;
    }
    self thread[[level.spawnclient]](timepassed);
    self.respawntimerstarttime = undefined;
  }
}

function update_ffa_top_scorers() {
  waittillframeend();
  if(!level.players.size || level.gameended) {
    return;
  }
  placement = [];
  foreach(player in level.players) {
    if(player.team != "spectator") {
      placement[placement.size] = player;
    }
  }
  for(i = 1; i < placement.size; i++) {
    player = placement[i];
    playerscore = player.pointstowin;
    for(j = i - 1; j >= 0 && (playerscore > placement[j].pointstowin || (playerscore == placement[j].pointstowin && player.deaths < placement[j].deaths) || (playerscore == placement[j].pointstowin && player.deaths == placement[j].deaths && player.lastkilltime > placement[j].lastkilltime)); j--) {
      placement[j + 1] = placement[j];
    }
    placement[j + 1] = player;
  }
  cleartopscorers();
  for(i = 0; i < placement.size && i < 3; i++) {
    settopscorer(i, placement[i], 0, 0, 0, 0, level.weaponnone);
  }
}

function playerkilled_watch_death(weapon, smeansofdeath, deathanimduration) {
  defaultplayerdeathwatchtime = 1.75;
  if(smeansofdeath == "MOD_MELEE_ASSASSINATE" || 0 > weapon.deathcamtime) {
    defaultplayerdeathwatchtime = (deathanimduration * 0.001) + 0.5;
  } else if(0 < weapon.deathcamtime) {
    defaultplayerdeathwatchtime = weapon.deathcamtime;
  }
  if(isDefined(level.overrideplayerdeathwatchtimer)) {
    defaultplayerdeathwatchtime = [[level.overrideplayerdeathwatchtimer]](defaultplayerdeathwatchtime);
  }
  globallogic_utils::waitfortimeornotify(defaultplayerdeathwatchtime, "end_death_delay");
  self notify("death_delay_finished");
}

function should_drop_weapon_on_death(wasteamkill, wassuicide, current_weapon, smeansofdeath) {
  if(wasteamkill) {
    return false;
  }
  if(wassuicide) {
    return false;
  }
  if(smeansofdeath == "MOD_TRIGGER_HURT" && !self isonground()) {
    return false;
  }
  if(isDefined(current_weapon) && current_weapon.isheroweapon) {
    return false;
  }
  return true;
}

function updateglobalbotkilledcounter() {
  if(isDefined(self.pers["isBot"])) {
    level.globallarryskilled++;
  }
}

function waittillkillstreakdone() {
  if(isDefined(self.killstreak_delay_killcam)) {
    while(isDefined(self.killstreak_delay_killcam)) {
      wait(0.1);
    }
    wait(2);
    self killstreaks::reset_killstreak_delay_killcam();
  }
}

function suicidekick() {
  self globallogic_score::incpersstat("sessionbans", 1);
  self endon("disconnect");
  waittillframeend();
  globallogic::gamehistoryplayerkicked();
  ban(self getentitynumber());
  globallogic_audio::leader_dialog("gamePlayerKicked");
}

function teamkillkick() {
  self globallogic_score::incpersstat("sessionbans", 1);
  self endon("disconnect");
  waittillframeend();
  playlistbanquantum = tweakables::gettweakablevalue("team", "teamkillerplaylistbanquantum");
  playlistbanpenalty = tweakables::gettweakablevalue("team", "teamkillerplaylistbanpenalty");
  if(playlistbanquantum > 0 && playlistbanpenalty > 0) {
    timeplayedtotal = self getdstat("playerstatslist", "time_played_total", "StatValue");
    minutesplayed = timeplayedtotal / 60;
    freebees = 2;
    banallowance = (int(floor(minutesplayed / playlistbanquantum))) + freebees;
    if(self.sessionbans > banallowance) {
      self setdstat("playerstatslist", "gametypeban", "StatValue", timeplayedtotal + (playlistbanpenalty * 60));
    }
  }
  globallogic::gamehistoryplayerkicked();
  ban(self getentitynumber());
  globallogic_audio::leader_dialog("gamePlayerKicked");
}

function teamkilldelay() {
  teamkills = self.pers["teamkills_nostats"];
  if(level.minimumallowedteamkills < 0 || teamkills <= level.minimumallowedteamkills) {
    return 0;
  }
  exceeded = teamkills - level.minimumallowedteamkills;
  return level.teamkillspawndelay * exceeded;
}

function shouldteamkillkick(teamkilldelay) {
  if(teamkilldelay && level.minimumallowedteamkills >= 0) {
    if(globallogic_utils::gettimepassed() >= 5000) {
      return true;
    }
    if(self.pers["teamkills_nostats"] > 1) {
      return true;
    }
  }
  return false;
}

function reduceteamkillsovertime() {
  timeperoneteamkillreduction = 20;
  reductionpersecond = 1 / timeperoneteamkillreduction;
  while(true) {
    if(isalive(self)) {
      self.pers["teamkills_nostats"] = self.pers["teamkills_nostats"] - reductionpersecond;
      if(self.pers["teamkills_nostats"] < level.minimumallowedteamkills) {
        self.pers["teamkills_nostats"] = level.minimumallowedteamkills;
        break;
      }
    }
    wait(1);
  }
}

function ignoreteamkills(weapon, smeansofdeath, einflictor) {
  if(weapon_utils::ismeleemod(smeansofdeath)) {
    return false;
  }
  if(weapon.ignoreteamkills) {
    return true;
  }
  if(isDefined(einflictor) && einflictor.ignore_team_kills === 1) {
    return true;
  }
  if(isDefined(einflictor) && isDefined(einflictor.destroyedby) && isDefined(einflictor.owner) && einflictor.destroyedby != einflictor.owner) {
    return true;
  }
  if(isDefined(einflictor) && einflictor.classname == "worldspawn") {
    return true;
  }
  return false;
}

function callback_playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  laststand::playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
}

function damageshellshockandrumble(eattacker, einflictor, weapon, smeansofdeath, idamage) {
  self thread weapons::on_damage(eattacker, einflictor, weapon, smeansofdeath, idamage);
  if(!self util::isusingremote()) {
    self playrumbleonentity("damage_heavy");
  }
}

function createdeadbody(attacker, idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, body) {
  if(smeansofdeath == "MOD_HIT_BY_OBJECT" && self getstance() == "prone") {
    self.body = body;
    if(!isDefined(self.switching_teams)) {
      thread deathicons::add(body, self, self.team, 5);
    }
    return;
  }
  ragdoll_now = 0;
  if(isDefined(self.usingvehicle) && self.usingvehicle && isDefined(self.vehicleposition) && self.vehicleposition == 1) {
    ragdoll_now = 1;
  }
  if(isDefined(level.ragdoll_override) && self[[level.ragdoll_override]](idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, ragdoll_now, body)) {
    return;
  }
  if(ragdoll_now || self isonladder() || self ismantling() || smeansofdeath == "MOD_CRUSH" || smeansofdeath == "MOD_HIT_BY_OBJECT") {
    body startragdoll();
  }
  if(!self isonground() && smeansofdeath != "MOD_FALLING") {
    if(getdvarint("scr_disable_air_death_ragdoll") == 0) {
      body startragdoll();
    }
  }
  if(smeansofdeath == "MOD_MELEE_ASSASSINATE" && !attacker isonground()) {
    body start_death_from_above_ragdoll(vdir);
  }
  if(self is_explosive_ragdoll(weapon, einflictor)) {
    body start_explosive_ragdoll(vdir, weapon);
  }
  thread delaystartragdoll(body, shitloc, vdir, weapon, einflictor, smeansofdeath);
  if(smeansofdeath == "MOD_CRUSH") {
    body globallogic_vehicle::vehiclecrush();
  }
  self.body = body;
  if(!isDefined(self.switching_teams)) {
    thread deathicons::add(body, self, self.team, 5);
  }
}

function is_explosive_ragdoll(weapon, inflictor) {
  if(!isDefined(weapon)) {
    return false;
  }
  if(weapon.name == "destructible_car" || weapon.name == "explodable_barrel") {
    return true;
  }
  if(weapon.projexplosiontype == "grenade") {
    if(isDefined(inflictor) && isDefined(inflictor.stucktoplayer)) {
      if(inflictor.stucktoplayer == self) {
        return true;
      }
    }
  }
  return false;
}

function start_explosive_ragdoll(dir, weapon) {
  if(!isDefined(self)) {
    return;
  }
  x = randomintrange(50, 100);
  y = randomintrange(50, 100);
  z = randomintrange(10, 20);
  if(isDefined(weapon) && (weapon.name == "sticky_grenade" || weapon.name == "explosive_bolt")) {
    if(isDefined(dir) && lengthsquared(dir) > 0) {
      x = dir[0] * x;
      y = dir[1] * y;
    }
  } else {
    if(math::cointoss()) {
      x = x * -1;
    }
    if(math::cointoss()) {
      y = y * -1;
    }
  }
  self startragdoll();
  self launchragdoll((x, y, z));
}

function start_death_from_above_ragdoll(dir) {
  if(!isDefined(self)) {
    return;
  }
  self startragdoll();
  self launchragdoll(vectorscale((0, 0, -1), 100));
}

function notifyconnecting() {
  waittillframeend();
  if(isDefined(self)) {
    level notify("connecting", self);
  }
  callback::callback("hash_fefe13f5");
}

function delaystartragdoll(ent, shitloc, vdir, weapon, einflictor, smeansofdeath) {
  if(isDefined(ent)) {
    deathanim = ent getcorpseanim();
    if(animhasnotetrack(deathanim, "ignore_ragdoll")) {
      return;
    }
  }
  waittillframeend();
  if(!isDefined(ent)) {
    return;
  }
  if(ent isragdoll()) {
    return;
  }
  deathanim = ent getcorpseanim();
  startfrac = 0.35;
  if(animhasnotetrack(deathanim, "start_ragdoll")) {
    times = getnotetracktimes(deathanim, "start_ragdoll");
    if(isDefined(times)) {
      startfrac = times[0];
    }
  }
  waittime = startfrac * getanimlength(deathanim);
  if(waittime > 0) {
    wait(waittime);
  }
  if(isDefined(ent)) {
    ent startragdoll();
  }
}

function trackattackerdamage(eattacker, idamage, smeansofdeath, weapon) {
  if(!isDefined(eattacker)) {
    return;
  }
  if(!isPlayer(eattacker)) {
    return;
  }
  if(self.attackerdata.size == 0) {
    self.firsttimedamaged = gettime();
  }
  if(!isDefined(self.attackerdata[eattacker.clientid])) {
    self.attackerdamage[eattacker.clientid] = spawnStruct();
    self.attackerdamage[eattacker.clientid].damage = idamage;
    self.attackerdamage[eattacker.clientid].meansofdeath = smeansofdeath;
    self.attackerdamage[eattacker.clientid].weapon = weapon;
    self.attackerdamage[eattacker.clientid].time = gettime();
    self.attackers[self.attackers.size] = eattacker;
    self.attackerdata[eattacker.clientid] = 0;
  } else {
    self.attackerdamage[eattacker.clientid].damage = self.attackerdamage[eattacker.clientid].damage + idamage;
    self.attackerdamage[eattacker.clientid].meansofdeath = smeansofdeath;
    self.attackerdamage[eattacker.clientid].weapon = weapon;
    if(!isDefined(self.attackerdamage[eattacker.clientid].time)) {
      self.attackerdamage[eattacker.clientid].time = gettime();
    }
  }
  if(isarray(self.attackersthisspawn)) {
    self.attackersthisspawn[eattacker.clientid] = eattacker;
  }
  self.attackerdamage[eattacker.clientid].lasttimedamaged = gettime();
  if(weapons::is_primary_weapon(weapon)) {
    self.attackerdata[eattacker.clientid] = 1;
  }
}

function giveattackerandinflictorownerassist(eattacker, einflictor, idamage, smeansofdeath, weapon) {
  if(!allowedassistweapon(weapon)) {
    return;
  }
  self trackattackerdamage(eattacker, idamage, smeansofdeath, weapon);
  if(!isDefined(einflictor)) {
    return;
  }
  if(!isDefined(einflictor.owner)) {
    return;
  }
  if(!isDefined(einflictor.ownergetsassist)) {
    return;
  }
  if(!einflictor.ownergetsassist) {
    return;
  }
  if(isDefined(eattacker) && eattacker == einflictor.owner) {
    return;
  }
  self trackattackerdamage(einflictor.owner, idamage, smeansofdeath, weapon);
}

function playerkilled_updatemeansofdeath(attacker, einflictor, weapon, smeansofdeath, shitloc) {
  if(globallogic_utils::isheadshot(weapon, shitloc, smeansofdeath, einflictor) && isPlayer(attacker) && !weapon_utils::ismeleemod(smeansofdeath)) {
    return "MOD_HEAD_SHOT";
  }
  switch (weapon.name) {
    case "dog_bite": {
      smeansofdeath = "MOD_PISTOL_BULLET";
      break;
    }
    case "destructible_car": {
      smeansofdeath = "MOD_EXPLOSIVE";
      break;
    }
    case "explodable_barrel": {
      smeansofdeath = "MOD_EXPLOSIVE";
      break;
    }
  }
  return smeansofdeath;
}

function updateattacker(attacker, weapon) {
  if(isai(attacker) && isDefined(attacker.script_owner)) {
    if(!level.teambased || attacker.script_owner.team != self.team) {
      attacker = attacker.script_owner;
    }
  }
  if(attacker.classname == "script_vehicle" && isDefined(attacker.owner)) {
    attacker notify("killed", self);
    attacker = attacker.owner;
  }
  if(isai(attacker)) {
    attacker notify("killed", self);
  }
  if(isDefined(self.capturinglastflag) && self.capturinglastflag == 1) {
    attacker.lastcapkiller = 1;
  }
  if(isDefined(attacker) && attacker != self && isDefined(weapon)) {
    if(weapon.name == "planemortar") {
      if(!isDefined(attacker.planemortarbda)) {
        attacker.planemortarbda = 0;
      }
      attacker.planemortarbda++;
    } else {
      if(weapon.name == "dart" || weapon.name == "dart_turret") {
        if(!isDefined(attacker.dartbda)) {
          attacker.dartbda = 0;
        }
        attacker.dartbda++;
      } else {
        if(weapon.name == "straferun_rockets" || weapon.name == "straferun_gun") {
          if(isDefined(attacker.straferunbda)) {
            attacker.straferunbda++;
          }
        } else if(weapon.name == "remote_missile_missile" || weapon.name == "remote_missile_bomblet") {
          if(!isDefined(attacker.remotemissilebda)) {
            attacker.remotemissilebda = 0;
          }
          attacker.remotemissilebda++;
        }
      }
    }
  }
  return attacker;
}

function updateinflictor(einflictor) {
  if(isDefined(einflictor) && einflictor.classname == "script_vehicle") {
    einflictor notify("killed", self);
    if(isDefined(einflictor.bda)) {
      einflictor.bda++;
    }
  }
  return einflictor;
}

function updateweapon(einflictor, weapon) {
  if(weapon == level.weaponnone && isDefined(einflictor)) {
    if(isDefined(einflictor.targetname) && einflictor.targetname == "explodable_barrel") {
      weapon = getweapon("explodable_barrel");
    } else if(isDefined(einflictor.destructible_type) && issubstr(einflictor.destructible_type, "vehicle_")) {
      weapon = getweapon("destructible_car");
    }
  }
  return weapon;
}

function playkillbattlechatter(attacker, weapon, victim, einflictor) {
  if(isPlayer(attacker)) {
    if(!killstreaks::is_killstreak_weapon(weapon)) {
      level thread battlechatter::say_kill_battle_chatter(attacker, weapon, victim, einflictor);
    }
  }
  if(isDefined(einflictor)) {
    einflictor notify("bhtn_action_notify", "attack_kill");
  }
}