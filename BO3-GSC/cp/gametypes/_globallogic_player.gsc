/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\gametypes\_globallogic_player.gsc
*************************************************/

#using scripts\cp\_bb;
#using scripts\cp\_challenges;
#using scripts\cp\_flashgrenades;
#using scripts\cp\_gamerep;
#using scripts\cp\_hazard;
#using scripts\cp\_laststand;
#using scripts\cp\_scoreevents;
#using scripts\cp\_skipto;
#using scripts\cp\_util;
#using scripts\cp\cybercom\_cybercom;
#using scripts\cp\cybercom\_cybercom_tactical_rig;
#using scripts\cp\cybercom\_cybercom_tactical_rig_emergencyreserve;
#using scripts\cp\cybercom\_cybercom_util;
#using scripts\cp\gametypes\_battlechatter;
#using scripts\cp\gametypes\_globallogic;
#using scripts\cp\gametypes\_globallogic_score;
#using scripts\cp\gametypes\_globallogic_spawn;
#using scripts\cp\gametypes\_globallogic_ui;
#using scripts\cp\gametypes\_globallogic_utils;
#using scripts\cp\gametypes\_globallogic_vehicle;
#using scripts\cp\gametypes\_killcam;
#using scripts\cp\gametypes\_loadout;
#using scripts\cp\gametypes\_player_cam;
#using scripts\cp\gametypes\_save;
#using scripts\cp\gametypes\_spawning;
#using scripts\cp\gametypes\_spawnlogic;
#using scripts\cp\gametypes\_spectating;
#using scripts\cp\gametypes\_weapon_utils;
#using scripts\cp\gametypes\_weapons;
#using scripts\cp\teams\_teams;
#using scripts\shared\_burnplayer;
#using scripts\shared\abilities\_ability_power;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\damagefeedback_shared;
#using scripts\shared\demo_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\gameskill_shared;
#using scripts\shared\hostmigration_shared;
#using scripts\shared\hud_message_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\math_shared;
#using scripts\shared\medals_shared;
#using scripts\shared\persistence_shared;
#using scripts\shared\rank_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\tweakables_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\weapons\_weapon_utils;
#using scripts\shared\weapons\_weapons;
#using scripts\shared\weapons_shared;
#namespace globallogic_player;

function freezeplayerforroundend() {
  self util::clearlowermessage();
  self closeingamemenu();
  self util::freeze_player_controls(1);
}

function init_player_flags() {
  if(isDefined(level.str_player_start_flag) && !self flag::exists(level.str_player_start_flag)) {
    self flag::init(level.str_player_start_flag);
  }
  self flag::init("initial_streamer_ready");
}

function function_be51e5e1(player, result) {
  lpselfnum = player getentitynumber();
  lpxuid = player getxuid(1);
  bbprint("global_leave", "name %s client %s xuid %s", player.name, lpselfnum, lpxuid);
  resultstr = result;
  if(isDefined(player.team) && result == player.team) {
    resultstr = "win";
  } else if(result == "allies" || result == "axis") {
    resultstr = "lose";
  }
  timeplayed = game["timepassed"] / 1000;
  recordcomscoreevent("end_match", "match_id", getdemofileid(), "game_variant", "cp", "game_mode", level.gametype, "game_playlist", "N/A", "private_match", sessionmodeisprivate(), "game_map", getdvarstring("mapname"), "player_xuid", player getxuid(1), "player_ip", player getipaddress(), "match_kills", player.kills, "match_deaths", player.deaths, "match_score", player.score, "match_streak", player.pers["best_kill_streak"], "match_captures", player.pers["captures"], "match_defends", player.pers["defends"], "match_headshots", player.pers["headshots"], "match_longshots", player.pers["longshots"], "prestige_max", player.pers["plevel"], "level_max", player.pers["rank"], "match_result", resultstr, "season_pass_owned", player hasseasonpass(0), "match_hits", player.shotshit, "player_gender", player getplayergendertype(currentsessionmode()));
}

function function_b0d17fc2(mapname, var_66db3636, var_26b0fd19) {
  var_38fbfebf = self getdstat("PlayerStatsByMap", mapname, var_66db3636);
  if(isDefined(var_38fbfebf)) {
    self recordcareerstatformap(var_26b0fd19, mapname, var_38fbfebf);
  }
}

function function_3b38bcc7(mapname, var_66db3636, var_26b0fd19) {
  var_c1be5d83 = self getdstat("PlayerStatsByMap", mapname, var_66db3636);
  if(isDefined(var_c1be5d83)) {
    self recordcareerflagformap(var_26b0fd19, mapname, var_c1be5d83);
  }
}

function function_6c559425() {
  if(!sessionmodeisonlinegame()) {
    return;
  }
  var_5c75060b = skipto::function_23eda99c();
  foreach(mapname in var_5c75060b) {
    var_2b7a9536 = skipto::function_97bb1111(mapname);
    self function_3b38bcc7(mapname, "hasBeenCompleted", "completed");
    self function_3b38bcc7(var_2b7a9536, "hasBeenCompleted", "completed");
    self function_b0d17fc2(mapname, "firstTimeCompletedUTC", "firstTimeCompleted");
    self function_b0d17fc2(var_2b7a9536, "firstTimeCompletedUTC", "firstTimeCompleted");
    self function_b0d17fc2(mapname, "lastCompletedUTC", "lastTimeCompleted");
    self function_b0d17fc2(var_2b7a9536, "lastCompletedUTC", "lastTimeCompleted");
    self function_b0d17fc2(mapname, "numCompletions", "numberTimesCompleted");
    self function_b0d17fc2(var_2b7a9536, "numCompletions", "numberTimesCompleted");
    self function_3b38bcc7(mapname, "allAccoladesComplete", "allAccoladesComplete");
    self function_3b38bcc7(var_2b7a9536, "allAccoladesComplete", "allAccoladesComplete");
  }
}

function function_b18d61a5() {
  if(!sessionmodeisonlinegame()) {
    return;
  }
  self function_6c559425();
  var_b0af8b0a = self getdstat("PlayerStatsList", "CAREER_TOTAL_TIME_PAUSED", "statValue");
  self recordcareerstat("duration_total_paused_seconds", var_b0af8b0a);
  var_add23082 = self getdstat("PlayerStatsList", "CAREER_TOTAL_PLAY_TIME", "statValue");
  self recordcareerstat("duration_total_seconds", var_add23082);
  var_25ebea36 = self getdstat("PlayerStatsList", "KILLS", "statValue");
  self recordcareerstat("kills_Total", var_25ebea36);
  var_184f557a = self getdstat("PlayerStatsList", "DEATHS", "statValue");
  self recordcareerstat("deaths_Total", var_184f557a);
  var_ff16b041 = self getdstat("deadOpsArcade", "totalGamesPlayed");
  self recordcareerstat("deadOps_Total", var_ff16b041);
}

function callback_playerconnect() {
  init_player_flags();
  thread notifyconnecting();
  self.statusicon = "hud_status_connecting";
  self waittill("begin");
  if(isDefined(level.reset_clientdvars)) {
    self[[level.reset_clientdvars]]();
  }
  waittillframeend();
  self.statusicon = "";
  self.guid = self getguid();
  checkpointclear();
  savegame::checkpoint_save();
  self function_33d9b2e3();
  self thread function_dc541b6d();
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
  self.movementtracking = spawnStruct();
  self thread util::trackwallrunningdistance();
  self thread util::tracksprintdistance();
  self thread util::trackdoublejumpdistance();
  lpselfnum = self getentitynumber();
  lpguid = self getguid();
  logprint(((((("J;" + lpguid) + ";") + lpselfnum) + ";") + self.name) + "\n");
  lpxuid = self getxuid(1);
  bbprint("global_joins", "name %s client %s xuid %s", self.name, lpselfnum, lpxuid);
  if(!sessionmodeiszombiesgame()) {
    self util::show_hud(1);
    self setclientuivisibilityflag("weapon_hud_visible", 1);
  }
  if(level.forceradar == 1) {
    self.pers["hasRadar"] = 1;
    self.hasspyplane = 1;
    level.activeuavs[self getentitynumber()] = 1;
  }
  if(level.forceradar == 2) {
    self setclientuivisibilityflag("g_compassShowEnemies", level.forceradar);
  } else {
    self setclientuivisibilityflag("g_compassShowEnemies", 0);
  }
  self setclientplayersprinttime(level.playersprinttime);
  self setclientnumlives(level.numlives);
  self.lives = level.numlives;
  self.infinite_solo_revives = 0;
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
    self globallogic_score::initpersstat("incaps");
    self.incaps = self globallogic_score::getpersstat("incaps");
    self globallogic_score::initpersstat("chickens", 0);
    self.chickens = self globallogic_score::getpersstat("chickens");
    self globallogic_score::initpersstat("revives");
    self.revives = self globallogic_score::getpersstat("revives");
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
    self globallogic_score::initpersstat("destructions", 0);
    self.destructions = self globallogic_score::getpersstat("destructions");
    self globallogic_score::initpersstat("disables", 0);
    self.disables = self globallogic_score::getpersstat("disables");
    self globallogic_score::initpersstat("escorts", 0);
    self.escorts = self globallogic_score::getpersstat("escorts");
    self globallogic_score::initpersstat("carries", 0);
    self.carries = self globallogic_score::getpersstat("carries");
    self globallogic_score::initpersstat("throws", 0);
    self.destructions = self globallogic_score::getpersstat("throws");
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
    self globallogic_score::initpersstat("sessionbans", 0);
    self.sessionbans = self globallogic_score::getpersstat("sessionbans");
    self globallogic_score::initpersstat("gametypeban", 0);
    self globallogic_score::initpersstat("time_played_total", 0);
    self globallogic_score::initpersstat("time_played_alive", 0);
    self globallogic_score::initpersstat("teamkills", 0);
    self globallogic_score::initpersstat("teamkills_nostats", 0);
    self.teamkillpunish = 0;
    if(level.minimumallowedteamkills >= 0 && self.pers["teamkills_nostats"] > level.minimumallowedteamkills) {
      self thread reduceteamkillsovertime();
    }
  }
  self.killedplayerscurrent = [];
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
  self.leaderdialogqueue = [];
  self.leaderdialogactive = 0;
  self.leaderdialoggroups = [];
  self.currentleaderdialoggroup = "";
  self.currentleaderdialog = "";
  self.currentleaderdialogtime = 0;
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
  self.lastkilltime = 0;
  self.cur_death_streak = 0;
  self disabledeathstreak();
  self.death_streak = 0;
  self.kill_streak = 0;
  self.gametype_kill_streak = 0;
  self.spawnqueueindex = -1;
  self.deathtime = 0;
  if(level.onlinegame) {
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
  self.connectedtime = gettime();
  self.meleekills = 0;
  self.wasaliveatmatchstart = 0;
  self.grenadesused = 0;
  level.players[level.players.size] = self;
  if(level.splitscreen) {
    setDvar("splitscreen_playerNum", level.players.size);
  }
  if(game["state"] == "postgame") {
    self.pers["needteam"] = 1;
    self.pers["team"] = "spectator";
    self.team = "spectator";
    self.sessionteam = "spectator";
    self util::show_hud(0);
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
  if(!isDefined(self.pers["winstreakAlreadyCleared"])) {
    self globallogic_score::backupandclearwinstreaks();
    self.pers["winstreakAlreadyCleared"] = 1;
  }
  if(self istestclient()) {
    self.pers["isBot"] = 1;
  }
  if(level.rankedmatch || level.leaguematch) {
    self persistence::set_after_action_report_stat("demoFileID", "0");
  }
  level endon("game_ended");
  if(isDefined(level.hostmigrationtimer)) {
    self thread hostmigration::hostmigrationtimerthink();
  }
  if(level.oldschool) {
    self.pers["class"] = undefined;
    self.curclass = self.pers["class"];
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
      if(globallogic_utils::isvalidclass(self.pers["class"])) {
        self thread[[level.spawnclient]]();
      } else {
        self globallogic_ui::showmainmenuforteam();
      }
      self thread spectating::set_permissions();
    }
  }
  if(self.sessionteam != "spectator") {
    self[[level.onspawnplayer]](1);
  }
  profilelog_endtiming(4, (("gs=" + game["state"]) + " zom=") + sessionmodeiszombiesgame());
  globallogic::updateteamstatus();
  self function_b18d61a5();
  var_e04e8527 = self getdstat("zmCampaignData", "unlocked");
  recordplayerstats(self, "cpzmUnlocked", var_e04e8527);
}

function function_33d9b2e3() {
  incaps = self getdstat("PlayerStatsList", "INCAPS", "statValue");
  revives = self getdstat("PlayerStatsList", "REVIVES", "statValue");
  self setnoncheckpointdata("INCAPS", incaps);
  self setnoncheckpointdata("REVIVES", revives);
}

function function_dc541b6d() {
  self endon("disconnect");
  if(!isDefined(getrootmapname())) {
    return;
  }
  while(true) {
    level waittill("save_restore");
    var_7fc849de = self getnoncheckpointdata("INCAPS");
    if(isDefined(var_7fc849de)) {
      assert(var_7fc849de >= self getdstat("", "", ""));
      assert(var_7fc849de >= self getdstat("", getrootmapname(), "", ""));
      self setdstat("PlayerStatsList", "INCAPS", "statValue", var_7fc849de);
      self.incaps = var_7fc849de - self getdstat("PlayerStatsByMap", getrootmapname(), "currentStats", "INCAPS");
      self.pers["incaps"] = self.incaps;
    }
    var_be0f9382 = self getnoncheckpointdata("REVIVES");
    if(isDefined(var_be0f9382)) {
      assert(var_be0f9382 >= self getdstat("", "", ""));
      assert(var_be0f9382 >= self getdstat("", getrootmapname(), "", ""));
      self setdstat("PlayerStatsList", "REVIVES", "statValue", var_be0f9382);
      self.revives = var_be0f9382 - self getdstat("PlayerStatsByMap", getrootmapname(), "currentStats", "REVIVES");
      assert(self.revives >= 0);
      self.pers["revives"] = self.revives;
    }
    var_e8695a49 = self getnoncheckpointdata("lives");
    if(isDefined(var_e8695a49)) {
      self.lives = var_e8695a49;
      self clearnoncheckpointdata("lives");
    }
    self luinotifyevent(&"offsite_comms_complete");
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
      self freezecontrols(0);
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
    gamelength = globallogic::getgamelength();
    self globallogic::bbplayermatchend(gamelength, "MP_PLAYER_DISCONNECT", 0);
  }
  checkpointclear();
  savegame::checkpoint_save();
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
  logprint(((((("Q;" + lpguid) + ";") + lpselfnum) + ";") + self.name) + "\n");
  self gamerep::gamerepplayerdisconnected();
  for(entry = 0; entry < level.players.size; entry++) {
    if(isDefined(level.players[entry].pers["killed_players"][self.name])) {
      level.players[entry].pers["killed_players"][self.name] = undefined;
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
  function_be51e5e1(self, "disconnected");
  if(level.gameended) {
    self globallogic::removedisconnectedplayerfromplacement();
  }
  globallogic::updateteamstatus();
  profilelog_endtiming(5, (("gs=" + game["state"]) + " zom=") + sessionmodeiszombiesgame());
  self clearallnoncheckpointdata();
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

function figureoutattacker(eattacker) {
  if(isDefined(eattacker)) {
    if(isai(eattacker) && isDefined(eattacker.script_owner)) {
      team = self.team;
      if(isai(self) && isDefined(self.team)) {
        team = self.team;
      }
      if(eattacker.script_owner.team != team) {
        eattacker = eattacker.script_owner;
      }
    }
    if(eattacker.classname == "script_vehicle" && isDefined(eattacker.owner) && !issentient(eattacker)) {
      eattacker = eattacker.owner;
    } else if(eattacker.classname == "auto_turret" && isDefined(eattacker.owner)) {
      eattacker = eattacker.owner;
    }
    if(isDefined(eattacker.remote_owner)) {
      eattacker = eattacker.remote_owner;
    }
  }
  return eattacker;
}

function figureoutweapon(weapon, einflictor) {
  if(weapon == level.weaponnone && isDefined(einflictor)) {
    if(isDefined(einflictor.targetname) && einflictor.targetname == "explodable_barrel") {
      weapon = getweapon("explodable_barrel");
    } else if(isDefined(einflictor.destructible_type) && issubstr(einflictor.destructible_type, "vehicle_")) {
      weapon = getweapon("destructible_car");
    }
  }
  return weapon;
}

function figureoutfriendlyfire(victim) {
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

function callback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal) {
  profilelog_begintiming(6, "ship");
  if(game["state"] == "postgame") {
    return;
  }
  if(self.sessionteam == "spectator") {
    return;
  }
  if(isDefined(self.candocombat) && !self.candocombat) {
    return;
  }
  if(self.scene_takedamage === 0) {
    return;
  }
  if(isDefined(self.b_game_start_invulnerability) && self.b_game_start_invulnerability) {
    return;
  }
  if(isDefined(self.b_teleport_invulnerability) && self.b_teleport_invulnerability) {
    return;
  }
  if(isDefined(eattacker) && isPlayer(eattacker) && isDefined(eattacker.candocombat) && !eattacker.candocombat) {
    return;
  }
  if(isDefined(level.hostmigrationtimer)) {
    return;
  }
  if(smeansofdeath === "MOD_TRIGGER_HURT" && isDefined(einflictor) && isstring(einflictor.script_hazard)) {
    if(einflictor.script_hazard != "none" && einflictor.script_hazard != "false") {
      hazard::do_damage(einflictor.script_hazard, idamage, einflictor, self.var_8dcb3948);
      return;
    }
  }
  if(self laststand::player_is_in_laststand()) {
    self notify("laststand_damage", idamage);
    return;
  }
  weaponname = weapon.name;
  if(weaponname == "ai_tank_drone_gun" || weaponname == "ai_tank_drone_rocket" && !level.hardcoremode) {
    if(isDefined(eattacker) && eattacker == self) {
      if(isDefined(einflictor) && isDefined(einflictor.from_ai)) {
        return;
      }
    }
    if(isDefined(eattacker) && isDefined(eattacker.owner) && eattacker.owner == self) {
      return;
    }
  }
  if(weapon.isemp) {
    if(self hasperk("specialty_immuneemp")) {
      return;
    }
    self notify("emp_grenaded", eattacker);
  }
  if(isDefined(self.overrideplayerdamage)) {
    overrideplayerdamage = self.overrideplayerdamage;
  } else if(isDefined(level.overrideplayerdamage)) {
    overrideplayerdamage = level.overrideplayerdamage;
  }
  if(isDefined(overrideplayerdamage)) {
    modifieddamage = self[[overrideplayerdamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
    if(isDefined(modifieddamage)) {
      if(modifieddamage <= 0) {
        return;
      }
      idamage = modifieddamage;
    }
  }
  assert(isDefined(idamage), "");
  self callback::callback("hash_ab5ecf6c");
  if(isDefined(eattacker)) {
    idamage = loadout::cac_modified_damage(self, eattacker, idamage, smeansofdeath, weapon, einflictor, shitloc);
    if(isDefined(modifieddamage)) {
      if(modifieddamage <= 0) {
        return;
      }
      idamage = modifieddamage;
    }
  }
  idamage = custom_gamemodes_modified_damage(self, eattacker, idamage, smeansofdeath, weapon, einflictor, shitloc);
  idamage = int(idamage);
  self.idflags = idflags;
  self.idflagstime = gettime();
  eattacker = figureoutattacker(eattacker);
  idamage = cybercom::cybercom_getadjusteddamage(self, eattacker, einflictor, idamage, weapon, shitloc, smeansofdeath);
  if(smeansofdeath != "MOD_FALLING") {
    idamage = gameskill::adjust_damage_for_player_health(self, eattacker, einflictor, idamage, weapon, shitloc, smeansofdeath);
  }
  idamage = gameskill::adjust_melee_damage(self, eattacker, einflictor, idamage, weapon, shitloc, smeansofdeath);
  idamage = cybercom::function_5ad6b98d(eattacker, self, idamage);
  idamage = int(idamage);
  pixbeginevent("PlayerDamage flags/tweaks");
  if(!isDefined(vdir)) {
    idflags = idflags | 4;
  }
  friendly = 0;
  if(self.health != self.maxhealth) {
    self notify("snd_pain_player", smeansofdeath);
  }
  if(isDefined(einflictor) && isDefined(einflictor.script_noteworthy)) {
    if(einflictor.script_noteworthy == "ragdoll_now") {
      smeansofdeath = "MOD_FALLING";
    }
    if(isDefined(level.overrideweaponfunc)) {
      weapon = [[level.overrideweaponfunc]](weapon, einflictor.script_noteworthy);
    }
  }
  if(globallogic_utils::isheadshot(weapon, shitloc, smeansofdeath, einflictor) && isPlayer(eattacker)) {
    smeansofdeath = "MOD_HEAD_SHOT";
  }
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
    if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET") {
      return;
    }
    if(smeansofdeath == "MOD_HEAD_SHOT") {
      idamage = 150;
    }
  }
  if(self player_is_occupant_invulnerable(smeansofdeath)) {
    return;
  }
  if(isDefined(eattacker) && isPlayer(eattacker) && self.team != eattacker.team) {
    self.lastattackweapon = weapon;
  }
  weapon = figureoutweapon(weapon, einflictor);
  pixendevent();
  if(isDefined(eattacker) && isai(eattacker)) {
    if(self.team == eattacker.team && smeansofdeath == "MOD_MELEE") {
      return;
    }
  }
  attackerishittingteammate = isPlayer(eattacker) && self util::isenemyplayer(eattacker) == 0;
  if(shitloc == "riotshield") {
    if(attackerishittingteammate && level.friendlyfire == 0) {
      return;
    }
    if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" && !attackerishittingteammate) {
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
          thread scoreevents::processscoreevent(score_event, self);
        }
      }
    }
    if(idflags & 32) {
      shitloc = "none";
      if(!idflags & 64) {
        idamage = idamage * 0;
      }
    } else {
      if(idflags & 128) {
        if(isDefined(einflictor) && isDefined(einflictor.stucktoplayer) && einflictor.stucktoplayer == self) {
          idamage = 101;
        }
        shitloc = "none";
      } else {
        return;
      }
    }
  }
  if(!idflags & 2048) {
    if(isDefined(einflictor) && (smeansofdeath == "MOD_GAS" || loadout::isexplosivedamage(smeansofdeath))) {
      if(einflictor.classname == "grenade" || weaponname == "tabun_gas" && (self.lastspawntime + 3500) > gettime() && distancesquared(einflictor.origin, self.lastspawnpoint.origin) < 62500) {
        return;
      }
      if(self isplayerimmunetokillstreak(eattacker, weapon)) {
        return;
      }
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
      isfrag = weaponname == "frag_grenade";
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
        if(weapon.isstun) {
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
      if(weapon.name == "hatchet" && isDefined(einflictor)) {
        self.explosiveinfo["projectile_bounced"] = isDefined(einflictor.bounced);
      }
    }
    if(isPlayer(eattacker)) {
      eattacker.pers["participation"]++;
    }
    prevhealthratio = self.health / self.maxhealth;
    if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE_SPLASH") {
      if(idamage >= self.health && eattacker != self && self.team != eattacker.team) {
        var_535d0dae = self gameskill::player_eligible_for_death_invulnerability();
        if(var_535d0dae) {
          self setnormalhealth(2 / self.maxhealth);
          idamage = 1;
        }
      }
    }
    if(weapon.parentweaponname === "riotshield" && self != eattacker && self.team != eattacker.team) {
      earthquake(0.25, 0.1, self.origin, 16, self);
    }
    if(level.teambased && issentient(eattacker) && self != eattacker && self.team == eattacker.team) {
      pixmarker("BEGIN: PlayerDamage player");
      if(level.friendlyfire == 0) {
        if(weapon.forcedamageshellshockandrumble) {
          self damageshellshockandrumble(eattacker, einflictor, weapon, smeansofdeath, idamage);
        }
        return;
      }
      if(level.friendlyfire == 1) {
        if(idamage < 1) {
          idamage = 1;
        }
        if(level.friendlyfiredelay && level.friendlyfiredelaytime >= (((gettime() - level.starttime) - level.discardtime) / 1000)) {
          eattacker.lastdamagewasfromenemy = 0;
          eattacker.friendlydamage = 1;
          eattacker finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
          eattacker.friendlydamage = undefined;
        } else {
          self.lastdamagewasfromenemy = 0;
          self finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
        }
      } else {
        if(level.friendlyfire == 2 && isalive(eattacker)) {
          idamage = int(idamage * 0.5);
          if(idamage < 1) {
            idamage = 1;
          }
          eattacker.lastdamagewasfromenemy = 0;
          eattacker.friendlydamage = 1;
          eattacker finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
          eattacker.friendlydamage = undefined;
        } else if(level.friendlyfire == 3 && isalive(eattacker)) {
          idamage = int(idamage * 0.5);
          if(idamage < 1) {
            idamage = 1;
          }
          self.lastdamagewasfromenemy = 0;
          eattacker.lastdamagewasfromenemy = 0;
          self finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
          eattacker.friendlydamage = 1;
          eattacker finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
          eattacker.friendlydamage = undefined;
        }
      }
      friendly = 1;
      pixmarker("END: PlayerDamage player");
    } else {
      if(idamage < 1) {
        idamage = 1;
      }
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
      self finishplayerdamagewrapper(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
    }
    if(isDefined(eattacker) && isPlayer(eattacker) && eattacker != self) {
      if(damagefeedback::dodamagefeedback(weapon, einflictor, idamage, smeansofdeath)) {
        if(idamage > 0) {
          if(self.health > 0) {
            perkfeedback = doperkfeedback(self, weapon, smeansofdeath, einflictor);
          }
          eattacker thread damagefeedback::update(smeansofdeath, einflictor, perkfeedback);
        }
      }
    }
    if(sessionmodeiscampaignzombiesgame() && isDefined(level.var_652674d2)) {
      self[[level.var_652674d2]](weapon, eattacker, idamage, smeansofdeath);
    }
    self.hasdonecombat = 1;
  }
  pixbeginevent("PlayerDamage log");
  if(getdvarint("")) {
    if(isDefined(eattacker.clientid)) {
      println(((((((((("" + self getentitynumber()) + "") + self.health) + "") + eattacker.clientid) + "") + isPlayer(einflictor) + "") + idamage) + "") + shitloc);
    } else {
      println((((((((("" + self getentitynumber()) + "") + self.health) + "") + eattacker getentitynumber() + "") + isPlayer(einflictor) + "") + idamage) + "") + shitloc);
    }
  }
  if(self.sessionstate != "dead") {
    lpselfnum = self getentitynumber();
    lpselfname = self.name;
    lpselfteam = self.team;
    lpselfguid = self getguid();
    lpattackerteam = "";
    var_f23089ea = self laststand::player_is_in_laststand();
    if(isPlayer(eattacker)) {
      lpattacknum = eattacker getentitynumber();
      lpattackguid = eattacker getguid();
      lpattackname = eattacker.name;
      lpattackerteam = eattacker.team;
    } else {
      var_90a0048 = "world";
      lpattackerteam = "world";
      lpattacknum = -1;
      lpattackguid = "";
      lpattackname = "";
    }
    bb::logdamage(eattacker, self, weapon, idamage, smeansofdeath, shitloc, 0, var_f23089ea);
    logprint(((((((((((((((((((((((("D;" + lpselfguid) + ";") + lpselfnum) + ";") + lpselfteam) + ";") + lpselfname) + ";") + lpattackguid) + ";") + lpattacknum) + ";") + lpattackerteam) + ";") + lpattackname) + ";") + weapon.name) + ";") + idamage) + ";") + smeansofdeath) + ";") + shitloc) + "\n");
  }
  pixendevent();
  profilelog_endtiming(6, (("gs=" + game["state"]) + " zom=") + sessionmodeiszombiesgame());
}

function player_is_occupant_invulnerable(smeansofdeath) {
  if(self isremotecontrolling()) {
    return 0;
  }
  if(!isDefined(level.vehicle_drivers_are_invulnerable)) {
    level.vehicle_drivers_are_invulnerable = 0;
  }
  invulnerable = level.vehicle_drivers_are_invulnerable && self vehicle::player_is_driver();
  return invulnerable;
}

function resetattackerlist() {
  self.attackers = [];
  self.attackerdata = [];
  self.attackerdamage = [];
  self.firsttimedamaged = 0;
}

function doperkfeedback(player, weapon, smeansofdeath, einflictor) {
  perkfeedback = undefined;
  hastacticalmask = loadout::hastacticalmask(player);
  hasflakjacket = player hasperk("specialty_flakjacket");
  isexplosivedamage = loadout::isexplosivedamage(smeansofdeath);
  isflashorstundamage = weapon_utils::isflashorstundamage(weapon, smeansofdeath);
  if(isflashorstundamage && hastacticalmask) {
    perkfeedback = "tacticalMask";
  } else if(isexplosivedamage && hasflakjacket && !weapon.ignoresflakjacket && !isaikillstreakdamage(weapon, einflictor)) {
    perkfeedback = "flakjacket";
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
  self damageshellshockandrumble(eattacker, einflictor, weapon, smeansofdeath, idamage);
  self ability_power::power_loss_event_took_damage(eattacker, einflictor, weapon, smeansofdeath, idamage);
  self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
  pixendevent();
}

function allowedassistweapon(weapon) {
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
}

function playerkilled_weaponstats(attacker, weapon, smeansofdeath, wasinlaststand, lastweaponbeforedroppingintolaststand, inflictor) {
  if(isPlayer(attacker) && attacker != self && (!level.teambased || (level.teambased && self.team != attacker.team))) {
    self addweaponstat(weapon, "deaths", 1);
    if(wasinlaststand && isDefined(lastweaponbeforedroppingintolaststand)) {
      victim_weapon = lastweaponbeforedroppingintolaststand;
    } else {
      victim_weapon = self.lastdroppableweapon;
    }
    if(isDefined(victim_weapon)) {
      self addweaponstat(victim_weapon, "deathsDuringUse", 1);
    }
    if(smeansofdeath != "MOD_FALLING") {
      if(weapon.name == "explosive_bolt" && isDefined(inflictor) && isDefined(inflictor.ownerweaponatlaunch) && inflictor.owneradsatlaunch) {
        attacker addweaponstat(inflictor.ownerweaponatlaunch, "kills", 1, attacker.class_num, 0, 1);
      } else {
        attacker addweaponstat(weapon, "kills", 1, attacker.class_num);
      }
    }
    if(smeansofdeath == "MOD_HEAD_SHOT") {
      attacker addweaponstat(weapon, "headshots", 1);
    }
    if(smeansofdeath == "MOD_PROJECTILE") {
      attacker addweaponstat(weapon, "direct_hit_kills", 1);
    }
  }
}

function playerkilled_obituary(attacker, einflictor, weapon, smeansofdeath) {
  if(!isPlayer(attacker) || self util::isenemyplayer(attacker) == 0) {
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
  if(level.teambased && isDefined(attacker.pers) && self.team == attacker.team && smeansofdeath == "MOD_GRENADE" && level.friendlyfire == 0) {
    obituary(self, self, weapon, smeansofdeath);
    demo::bookmark("kill", gettime(), self, self, 0, einflictor);
  } else {
    obituary(self, attacker, weapon, smeansofdeath);
    demo::bookmark("kill", gettime(), self, attacker, 0, einflictor);
  }
}

function playerkilled_suicide(einflictor, attacker, smeansofdeath, weapon, shitloc) {
  awardassists = 0;
  if(isDefined(self.switching_teams)) {
    if(!level.teambased && (isDefined(level.teams[self.leaving_team]) && isDefined(level.teams[self.joining_team]) && level.teams[self.leaving_team] != level.teams[self.joining_team])) {
      playercounts = self teams::count_players();
      playercounts[self.leaving_team]--;
      playercounts[self.joining_team]++;
      if((playercounts[self.joining_team] - playercounts[self.leaving_team]) > 1) {
        thread scoreevents::processscoreevent("suicide", self);
        self thread rank::giverankxp("suicide");
        self globallogic_score::incpersstat("suicides", 1);
        self.suicides = self globallogic_score::getpersstat("suicides");
      }
    }
  } else {
    thread scoreevents::processscoreevent("suicide", self);
    self globallogic_score::incpersstat("suicides", 1);
    self.suicides = self globallogic_score::getpersstat("suicides");
    if(smeansofdeath == "MOD_SUICIDE" && shitloc == "none" && self.throwinggrenade) {
      self.lastgrenadesuicidetime = gettime();
    }
    if(level.maxsuicidesbeforekick > 0 && level.maxsuicidesbeforekick <= self.suicides) {
      self notify("teamkillkicked");
      self suicidekick();
    }
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
  thread scoreevents::processscoreevent("team_kill", attacker);
  self.teamkilled = 1;
  if(!ignoreteamkills(weapon, smeansofdeath)) {
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
        attacker teamkillkick();
      }
      attacker thread reduceteamkillsovertime();
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
  if(isDefined(self.lastattackedshieldplayer) && isDefined(self.lastattackedshieldtime) && self.lastattackedshieldplayer != attacker) {
    if((gettime() - self.lastattackedshieldtime) < 4000) {
      self.lastattackedshieldplayer thread globallogic_score::processshieldassist(self);
    }
  }
  pixendevent();
}

function playerkilled_kill(einflictor, attacker, smeansofdeath, weapon, shitloc) {
  globallogic_score::inctotalkills(attacker.team);
  attacker thread globallogic_score::givekillstats(smeansofdeath, weapon, self);
  if(isalive(attacker)) {
    pixbeginevent("killstreak");
    if(!isDefined(einflictor) || !isDefined(einflictor.requireddeathcount) || attacker.deathcount == einflictor.requireddeathcount) {
      attacker.pers["cur_total_kill_streak"]++;
      attacker setplayercurrentstreak(attacker.pers["cur_total_kill_streak"]);
      if(isDefined(level.killstreaks)) {
        attacker.pers["cur_kill_streak"]++;
        if(attacker.pers["cur_kill_streak"] >= 2) {
          if(attacker.pers["cur_kill_streak"] == 10) {
            attacker challenges::killstreakten();
          }
          if(attacker.pers["cur_kill_streak"] <= 30) {
            scoreevents::processscoreevent("killstreak_" + attacker.pers["cur_kill_streak"], attacker, self, weapon);
          } else {
            scoreevents::processscoreevent("killstreak_more_than_30", attacker, self, weapon);
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
  if(smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_MELEE_ASSASSINATE" && level.gametype == "gun") {} else {
    scoreevents::processscoreevent("kill", attacker, self, weapon);
  }
  if(smeansofdeath == "MOD_HEAD_SHOT") {
    scoreevents::processscoreevent("headshot", attacker, self, weapon);
  } else if(smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_MELEE_ASSASSINATE") {
    if(weapon.isriotshield) {
      scoreevents::processscoreevent("melee_kill_with_riot_shield", attacker, self, weapon);
      if(isDefined(attacker.class_num)) {
        primaryweaponnum = attacker getloadoutitem(attacker.class_num, "primary");
        secondaryweaponnum = attacker getloadoutitem(attacker.class_num, "secondary");
        if(primaryweaponnum && level.tbl_weaponids[primaryweaponnum]["reference"] == "riotshield" && !secondaryweaponnum || (secondaryweaponnum && level.tbl_weaponids[secondaryweaponnum]["reference"] == "riotshield" && !primaryweaponnum)) {
          attacker addweaponstat(weapon, "NoLethalKills", 1);
        }
      }
    } else {
      scoreevents::processscoreevent("melee_kill", attacker, self, weapon);
    }
  }
  attacker thread globallogic_score::trackattackerkill(self.name, self.pers["rank"], self.pers["rankxp"], self.pers["prestige"], self getxuid());
  attackername = attacker.name;
  self thread globallogic_score::trackattackeedeath(attackername, attacker.pers["rank"], attacker.pers["rankxp"], attacker.pers["prestige"], attacker getxuid());
  self thread medals::setlastkilledby(attacker);
  attacker thread globallogic_score::inckillstreaktracker(weapon);
  if(level.teambased && attacker.team != "spectator") {
    globallogic_score::giveteamscore("kill", attacker.team, attacker, self);
  }
  scoresub = level.deathpointloss;
  if(scoresub != 0) {
    globallogic_score::_setplayerscore(self, globallogic_score::_getplayerscore(self) - scoresub);
  }
  level thread playkillbattlechatter(attacker, weapon, self);
}

function callback_playerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  profilelog_begintiming(7, "ship");
  self endon("spawned");
  self notify("killed_player");
  self callback::callback("hash_bc435202");
  self flagsys::clear("loadout_given");
  if(self.sessionteam == "spectator") {
    return;
  }
  if(game["state"] == "postgame") {
    return;
  }
  self needsrevive(0);
  if(isDefined(self.burning) && self.burning == 1) {
    self setburn(0);
  }
  self.suicide = 0;
  self.teamkilled = 0;
  self.meleeattackers = undefined;
  if(isDefined(level.takelivesondeath) && level.takelivesondeath == 1) {
    if(self.pers["lives"]) {
      self.pers["lives"]--;
      if(self.pers["lives"] == 0) {
        level notify("player_eliminated");
        self notify("player_eliminated");
      }
    }
  }
  weapon = updateweapon(einflictor, weapon);
  pixbeginevent("PlayerKilled pre constants");
  wasinlaststand = 0;
  deathtimeoffset = 0;
  lastweaponbeforedroppingintolaststand = undefined;
  attackerstance = undefined;
  self.laststandthislife = undefined;
  self.vattackerorigin = undefined;
  if(isDefined(self.uselaststandparams)) {
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
      deathtimeoffset = (gettime() - self.laststandparams.laststandstarttime) / 1000;
      if(isDefined(self.previousprimary)) {
        wasinlaststand = 1;
        lastweaponbeforedroppingintolaststand = self.previousprimary;
      }
    }
    self.laststandparams = undefined;
  }
  bestplayer = undefined;
  bestplayermeansofdeath = undefined;
  obituarymeansofdeath = undefined;
  bestplayerweapon = undefined;
  obituaryweapon = weapon;
  assistedsuicide = 0;
  if(!isDefined(attacker) || attacker.classname == "trigger_hurt" || attacker.classname == "worldspawn" || (isDefined(attacker.ismagicbullet) && attacker.ismagicbullet == 1) || attacker == self && isDefined(self.attackers)) {
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
  if(isPlayer(attacker)) {
    attacker.damagedplayers[self.clientid] = undefined;
  }
  self.deathtime = gettime();
  attacker = updateattacker(attacker, weapon);
  einflictor = updateinflictor(einflictor);
  smeansofdeath = self playerkilled_updatemeansofdeath(attacker, einflictor, weapon, smeansofdeath, shitloc);
  if(!isDefined(obituarymeansofdeath)) {
    obituarymeansofdeath = smeansofdeath;
  }
  if(isDefined(self.hasriotshieldequipped) && self.hasriotshieldequipped == 1) {
    self detachshieldmodel(level.carriedshieldmodel, "tag_weapon_left");
    self.hasriotshield = 0;
    self.hasriotshieldequipped = 0;
  }
  self thread updateglobalbotkilledcounter();
  self playerkilled_weaponstats(attacker, weapon, smeansofdeath, wasinlaststand, lastweaponbeforedroppingintolaststand, einflictor);
  self playerkilled_obituary(attacker, einflictor, obituaryweapon, obituarymeansofdeath);
  spawnlogic::death_occured(self, attacker);
  self.sessionstate = "dead";
  self.statusicon = "hud_status_dead";
  self.pers["weapon"] = undefined;
  self.killedplayerscurrent = [];
  self.deathcount++;
  println((("" + self.clientid) + "") + self.deathcount);
  self playerkilled_killstreaks(attacker, weapon);
  lpselfnum = self getentitynumber();
  lpselfname = self.name;
  lpattackguid = "";
  lpattackname = "";
  lpselfteam = self.team;
  lpselfguid = self getguid();
  lpattackteam = "";
  lpattacknum = -1;
  awardassists = 0;
  wasteamkill = 0;
  wassuicide = 0;
  pixendevent();
  scoreevents::processscoreevent("death", self, self, weapon);
  self.pers["resetMomentumOnSpawn"] = 1;
  if(isPlayer(attacker)) {
    lpattackguid = attacker getguid();
    lpattackname = attacker.name;
    lpattackteam = attacker.team;
    if(attacker == self || assistedsuicide == 1) {
      wassuicide = 1;
      awardassists = self playerkilled_suicide(einflictor, attacker, smeansofdeath, weapon, shitloc);
    } else {
      pixbeginevent("PlayerKilled attacker");
      lpattacknum = attacker getentitynumber();
      if(level.teambased && self.team == attacker.team && smeansofdeath == "MOD_GRENADE" && level.friendlyfire == 0) {} else {
        if(level.teambased && self.team == attacker.team) {
          wasteamkill = 1;
          self playerkilled_teamkill(einflictor, attacker, smeansofdeath, weapon, shitloc);
        } else {
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
      lpattacknum = -1;
      lpattackguid = "";
      lpattackname = "";
      lpattackteam = "world";
      thread scoreevents::processscoreevent("suicide", self);
      self globallogic_score::incpersstat("suicides", 1);
      self.suicides = self globallogic_score::getpersstat("suicides");
      self.suicide = 1;
      awardassists = 1;
      if(level.maxsuicidesbeforekick > 0 && level.maxsuicidesbeforekick <= self.suicides) {
        self notify("teamkillkicked");
        self suicidekick();
      }
    } else {
      lpattacknum = -1;
      lpattackguid = "";
      lpattackname = "";
      lpattackteam = "world";
      wassuicide = 1;
      if(isDefined(einflictor) && isDefined(einflictor.killcament)) {
        lpattacknum = self getentitynumber();
        wassuicide = 0;
      }
      if(isDefined(attacker) && isDefined(attacker.team) && isDefined(level.teams[attacker.team])) {
        if(attacker.team != self.team) {
          if(level.teambased) {
            globallogic_score::giveteamscore("kill", attacker.team, attacker, self);
          }
          wassuicide = 0;
        }
      }
      awardassists = 1;
    }
  }
  if(!level.ingraceperiod) {
    if(smeansofdeath != "MOD_GRENADE" && smeansofdeath != "MOD_GRENADE_SPLASH" && smeansofdeath != "MOD_EXPLOSIVE" && smeansofdeath != "MOD_EXPLOSIVE_SPLASH" && smeansofdeath != "MOD_PROJECTILE_SPLASH") {
      self weapons::drop_scavenger_for_death(attacker);
    }
    if(!wasteamkill && !wassuicide) {
      self weapons::drop_for_death(attacker, weapon, smeansofdeath);
    }
  }
  if(sessionmodeiszombiesgame()) {
    awardassists = 0;
  }
  if(awardassists) {
    self playerkilled_awardassists(einflictor, attacker, weapon, lpattackteam);
  }
  pixbeginevent("PlayerKilled post constants");
  self.lastattacker = attacker;
  self.lastdeathpos = self.origin;
  if(isDefined(attacker) && isPlayer(attacker) && attacker != self && (!level.teambased || attacker.team != self.team)) {
    self thread challenges::playerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, shitloc, attackerstance);
  } else {
    self notify("playerkilledchallengesprocessed");
  }
  if(isDefined(self.attackers)) {
    self.attackers = [];
  }
  bb::logdamage(attacker, self, weapon, idamage, smeansofdeath, shitloc, 1, !wasinlaststand);
  logprint(((((((((((((((((((((((("K;" + lpselfguid) + ";") + lpselfnum) + ";") + lpselfteam) + ";") + lpselfname) + ";") + lpattackguid) + ";") + lpattacknum) + ";") + lpattackteam) + ";") + lpattackname) + ";") + weapon.name) + ";") + idamage) + ";") + smeansofdeath) + ";") + shitloc) + "\n");
  attackerstring = "none";
  if(isPlayer(attacker)) {
    attackerstring = ((attacker getxuid() + "(") + lpattackname) + ")";
  }
  println((((((((((((("" + smeansofdeath) + "") + weapon.name) + "") + attackerstring) + "") + idamage) + "") + shitloc) + "") + int(self.origin[0]) + "") + int(self.origin[1]) + "") + int(self.origin[2]));
  globallogic::updateteamstatus();
  self weapons::detach_carry_object_model();
  died_in_vehicle = 0;
  if(isDefined(self.diedonvehicle)) {
    died_in_vehicle = self.diedonvehicle;
  }
  hit_by_train = 0;
  if(isDefined(attacker) && isDefined(attacker.targetname) && attacker.targetname == "train") {
    hit_by_train = 1;
  }
  pixendevent();
  pixbeginevent("PlayerKilled body and gibbing");
  if(!died_in_vehicle && !hit_by_train && (!(isDefined(level.var_d59daf8) && level.var_d59daf8) || level.players.size > 1)) {
    vattackerorigin = undefined;
    if(isDefined(attacker)) {
      vattackerorigin = attacker.origin;
    }
    ragdoll_now = 0;
    if(isDefined(self.usingvehicle) && self.usingvehicle && isDefined(self.vehicleposition) && self.vehicleposition == 1) {
      ragdoll_now = 1;
    }
    deathfromabove = 0;
    if(!attacker isonground() && smeansofdeath == "MOD_MELEE_ASSASSINATE") {
      deathfromabove = 1;
    }
    body = self cloneplayer(deathanimduration, weapon, attacker);
    if(isDefined(body)) {
      self createdeadbody(idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, ragdoll_now, body, deathfromabove);
    }
  }
  pixendevent();
  thread globallogic_spawn::spawnqueuedclient(self.team, attacker);
  self.switching_teams = undefined;
  self.joining_team = undefined;
  self.leaving_team = undefined;
  if(lpattacknum < 0) {
    if(isDefined(self.var_afe5253c)) {
      if(self.var_afe5253c.var_a21e8eb8 >= 0 && self.var_afe5253c.attackernum == self getentitynumber()) {
        lpattacknum = self.var_afe5253c.var_a21e8eb8;
      } else {
        if(self.var_afe5253c.attackernum >= 0) {
          lpattacknum = self.var_afe5253c.attackernum;
        } else if(self.var_afe5253c.var_a21e8eb8 >= 0) {
          lpattacknum = self.var_afe5253c.var_a21e8eb8;
        }
      }
    } else {
      if(isDefined(einflictor) && attacker == self) {
        lpattacknum = einflictor getentitynumber();
      } else {
        if(isDefined(attacker)) {
          lpattacknum = attacker getentitynumber();
        } else if(isDefined(einflictor)) {
          lpattacknum = einflictor getentitynumber();
        }
      }
    }
  }
  self.var_ebd83169 = 1;
  self.var_1b7a74aa = lpattacknum;
  self.var_ca78829f = attacker;
  self.killcamweapon = weapon;
  self.var_8c0347ee = deathtimeoffset;
  self.var_2b1ad8b = psoffsettime;
  if(lpattacknum < 0 || lpattacknum === self getentitynumber() || lpattacknum > 1023) {
    self.var_ebd83169 = 0;
  }
  self thread[[level.onplayerkilled]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
  for(icb = 0; icb < level.onplayerkilledextraunthreadedcbs.size; icb++) {
    self[[level.onplayerkilledextraunthreadedcbs[icb]]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
  }
  self.wantsafespawn = 0;
  perks = [];
  killstreaks = globallogic::getkillstreaks(attacker);
  if(!isDefined(self.killstreak_waitamount)) {
    self thread[[level.spawnplayerprediction]]();
  }
  profilelog_endtiming(7, (("gs=" + game["state"]) + " zom=") + sessionmodeiszombiesgame());
  if(!(isDefined(level.var_d59daf8) && level.var_d59daf8) || level.players.size > 1) {
    wait(0.25);
  } else {
    if(isDefined(body)) {
      codesetclientfield(body, "hide_body", 1);
    }
    self.pers["incaps"]++;
    self.incaps = self.pers["incaps"];
    self addplayerstat("INCAPS", 1);
    var_e7ce5f85 = self getdstat("PlayerStatsList", "INCAPS", "statValue");
    self setnoncheckpointdata("INCAPS", var_e7ce5f85);
    namespace_5f11fb0b::function_8e835895(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
    self util::waittill_any_timeout(5, "cp_deathcam_ended");
  }
  defaultplayerdeathwatchtime = 4;
  if(sessionmodeiscampaigngame() && level.players.size > 1) {
    if(getdvarint("enable_new_death_cam", 1)) {
      defaultplayerdeathwatchtime = getdvarfloat("defaultPlayerDeathWatchTime", 2.5);
    }
  }
  if(smeansofdeath == "MOD_MELEE_ASSASSINATE" || 0 > weapon.deathcamtime) {
    defaultplayerdeathwatchtime = (deathanimduration * 0.001) + 0.5;
  } else if(0 < weapon.deathcamtime) {
    defaultplayerdeathwatchtime = weapon.deathcamtime;
  }
  if(isDefined(level.overrideplayerdeathwatchtimer)) {
    defaultplayerdeathwatchtime = [[level.overrideplayerdeathwatchtimer]](defaultplayerdeathwatchtime);
  }
  self notify("death_delay_finished");
  if(isDefined(level.var_3a9f9a38) && level.var_3a9f9a38 && (isDefined(self.var_acfedf1c) && self.var_acfedf1c)) {
    killcamentitystarttime = 0;
    self killcam::killcam(self getentitynumber(), self getentitynumber(), attacker, lpattacknum, killcamentitystarttime, weapon, self.deathtime, deathtimeoffset, psoffsettime, 1, undefined, perks, killstreaks, self, body);
  }
  if(isDefined(self.var_e8880dea) && self.var_e8880dea) {
    self util::waittill_any_timeout(5, "camera_sequence_completed");
    self.var_e8880dea = undefined;
    return;
  }
  self.respawntimerstarttime = gettime();
  if(game["state"] != "playing") {
    self.sessionstate = "dead";
    self.spectatorclient = -1;
    self.archivetime = 0;
    self.psoffsettime = 0;
    return;
  }
  waittillkillstreakdone();
  userespawntime = 1;
  if(isDefined(level.hostmigrationtimer)) {
    userespawntime = 0;
  }
  hostmigration::waittillhostmigrationcountdown();
  if(isDefined(level.var_ad1a71f5)) {
    return;
  }
  if(globallogic_utils::isvalidclass(self.curclass)) {
    timepassed = undefined;
    if(isDefined(self.respawntimerstarttime) && userespawntime) {
      timepassed = (gettime() - self.respawntimerstarttime) / 1000;
    }
    self thread[[level.spawnclient]](timepassed);
    self.respawntimerstarttime = undefined;
  }
}

function updateglobalbotkilledcounter() {
  if(isDefined(self.pers["isBot"])) {
    level.globallarryskilled++;
  }
}

function waittillkillstreakdone() {
  if(isDefined(self.killstreak_waitamount)) {
    starttime = gettime();
    waittime = self.killstreak_waitamount * 1000;
    while(gettime() < (starttime + waittime) && isDefined(self.killstreak_waitamount)) {
      wait(0.1);
    }
    wait(2);
    self.killstreak_waitamount = undefined;
  }
}

function suicidekick() {
  self globallogic_score::incpersstat("sessionbans", 1);
  self endon("disconnect");
  waittillframeend();
  globallogic::gamehistoryplayerkicked();
  ban(self getentitynumber());
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

function ignoreteamkills(weapon, smeansofdeath) {
  if(smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_MELEE_ASSASSINATE") {
    return false;
  }
  if(weapon.ignoreteamkills) {
    return true;
  }
  return false;
}

function callback_playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, delayoverride) {
  if(self hascybercomrig("cybercom_emergencyreserve") && cybercom_tacrig_emergencyreserve::validdeathtypesforemergencyreserve(smeansofdeath)) {
    self cybercom_tacrig::turn_rig_ability_on("cybercom_emergencyreserve");
  }
  laststand::playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, delayoverride);
}

function damageshellshockandrumble(eattacker, einflictor, weapon, smeansofdeath, idamage) {
  self thread weapons::on_damage(eattacker, einflictor, weapon, smeansofdeath, idamage);
  self playrumbleonentity("damage_heavy");
}

function createdeadbody(idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, ragdoll_jib, body, deathfromabove) {
  if(smeansofdeath == "MOD_HIT_BY_OBJECT" && self getstance() == "prone") {
    self.body = body;
    return;
  }
  if(isDefined(level.ragdoll_override) && self[[level.ragdoll_override]](idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, ragdoll_jib, body)) {
    return;
  }
  if(ragdoll_jib || self isonladder() || self ismantling() || smeansofdeath == "MOD_CRUSH" || smeansofdeath == "MOD_HIT_BY_OBJECT") {
    body startragdoll();
  }
  if(!self isonground()) {
    if(getdvarint("scr_disable_air_death_ragdoll") == 0) {
      body startragdoll();
    }
  }
  if(smeansofdeath == "MOD_MELEE_ASSASSINATE" && isDefined(deathfromabove) && deathfromabove) {
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
    callback::callback("hash_fefe13f5");
  }
}

function delaystartragdoll(ent, shitloc, vdir, weapon, einflictor, smeansofdeath) {
  if(isDefined(ent)) {
    deathanim = ent getcorpseanim();
    if(animhasnotetrack(deathanim, "ignore_ragdoll")) {
      return;
    }
  }
  if(level.oldschool) {
    if(!isDefined(vdir)) {
      vdir = (0, 0, 0);
    }
    explosionpos = ent.origin + (0, 0, globallogic_utils::gethitlocheight(shitloc));
    explosionpos = explosionpos - (vdir * 20);
    explosionradius = 40;
    explosionforce = 0.75;
    if(smeansofdeath == "MOD_IMPACT" || smeansofdeath == "MOD_EXPLOSIVE" || issubstr(smeansofdeath, "MOD_GRENADE") || issubstr(smeansofdeath, "MOD_PROJECTILE") || shitloc == "head" || shitloc == "helmet") {
      explosionforce = 2.5;
    }
    ent startragdoll(1);
    wait(0.05);
    if(!isDefined(ent)) {
      return;
    }
    physicsexplosionsphere(explosionpos, explosionradius, explosionradius / 2, explosionforce);
    return;
  }
  wait(0.2);
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
  wait(waittime);
  if(isDefined(ent)) {
    ent startragdoll(1);
  }
}

function trackattackerdamage(eattacker, idamage, smeansofdeath, weapon) {
  if(!isDefined(eattacker)) {
    return;
  }
  if(!isPlayer(eattacker)) {
    return;
  }
  assert(isarray(self.attackerdata));
  if(self.attackerdata.size == 0) {
    self.firsttimedamaged = gettime();
  }
  if(self.attackerdata.size == 0 || !isDefined(self.attackerdata[eattacker.clientid])) {
    self.attackerdamage[eattacker.clientid] = spawnStruct();
    self.attackerdamage[eattacker.clientid].damage = idamage;
    self.attackerdamage[eattacker.clientid].meansofdeath = smeansofdeath;
    self.attackerdamage[eattacker.clientid].weapon = weapon;
    self.attackerdamage[eattacker.clientid].time = gettime();
    self.attackers[self.attackers.size] = eattacker;
    self.attackerdata[eattacker.clientid] = 0;
    assert(self.attackerdata.size);
  } else {
    self.attackerdamage[eattacker.clientid].damage = self.attackerdamage[eattacker.clientid].damage + idamage;
    self.attackerdamage[eattacker.clientid].meansofdeath = smeansofdeath;
    self.attackerdamage[eattacker.clientid].weapon = weapon;
    if(!isDefined(self.attackerdamage[eattacker.clientid].time)) {
      self.attackerdamage[eattacker.clientid].time = gettime();
    }
  }
  assert(self.attackerdata.size);
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
  if(globallogic_utils::isheadshot(weapon, shitloc, smeansofdeath, einflictor) && isPlayer(attacker)) {
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
  if(isDefined(attacker) && isDefined(weapon) && weapon.name == "planemortar") {
    if(!isDefined(attacker.planemortarbda)) {
      attacker.planemortarbda = 0;
    }
    attacker.planemortarbda++;
  }
  if(isDefined(attacker) && isDefined(weapon) && (weapon.name == "straferun_rockets" || weapon.name == "straferun_gun")) {
    if(isDefined(attacker.straferunbda)) {
      attacker.straferunbda++;
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

function playkillbattlechatter(attacker, weapon, victim) {}

function function_ece4ca01() {
  if(self == level) {
    foreach(player in level.players) {
      player function_ece4ca01();
    }
  } else if(isPlayer(self)) {
    a_w_weapons = self getweaponslist();
    foreach(weapon in a_w_weapons) {
      if(isDefined(weapon.isheroweapon) && weapon.isheroweapon) {
        var_c44df3d1 = self savegame::get_player_data(savegame::get_mission_name() + "hero_weapon", undefined);
        if(!isDefined(var_c44df3d1)) {
          var_c44df3d1 = "";
        }
        if(!issubstr(var_c44df3d1, weapon.name + ",")) {
          var_c44df3d1 = (var_c44df3d1 + weapon.name) + ",";
          self savegame::set_player_data(savegame::get_mission_name() + "hero_weapon", var_c44df3d1);
        }
      }
    }
  }
}

function private function_7a152f99(statname) {
  var_9792a8bf = self getdstat("PlayerStatsByMap", getrootmapname(), "currentStats", statname);
  var_56aa772d = self getdstat("PlayerStatsList", statname, "statValue");
  return var_56aa772d - var_9792a8bf;
}

function function_a5ac6877() {
  if(isDefined(getrootmapname())) {
    if(sessionmodeiscampaignzombiesgame() && !ismapsublevel() && (!(isDefined(self.var_bf1a9bd5) && self.var_bf1a9bd5))) {
      next_map = getrootmapname();
      if(isDefined(next_map)) {
        foreach(player in level.players) {
          player function_4cef9872(next_map);
        }
      }
      uploadstats();
      self.var_bf1a9bd5 = 1;
    }
    self.pers["score"] = self function_7a152f99("score");
    self.pers["kills"] = self function_7a152f99("kills");
    self.pers["incaps"] = self function_7a152f99("incaps");
    self.pers["assists"] = self function_7a152f99("assists");
    self.pers["revives"] = self function_7a152f99("revives");
    self.kills = self.pers["kills"];
    self.score = self.pers["score"];
    self.assists = self.pers["assists"];
    self.incaps = self.pers["incaps"];
    self.revives = self.pers["revives"];
  }
}

function function_7bdf5497() {
  self.kills = 0;
  self.score = 0;
  self.assists = 0;
  self.incaps = 0;
  self.revives = 0;
}

function function_4cef9872(var_5df3645b) {
  if(!isDefined(var_5df3645b)) {
    return;
  }
  for(i = 1; i < 58; i++) {
    var_b47d78c4 = self getcurrentgunrank(i);
    if(!isDefined(var_b47d78c4)) {
      var_b47d78c4 = 0;
    }
    self setdstat("currentWeaponLevels", i, var_b47d78c4);
  }
  var_72c4032 = self getdstat("PlayerStatsList", "RANKXP", "statValue");
  self setdstat("currentRankXP", var_72c4032);
  var_b4728b19 = [];
  array::add(var_b4728b19, "KILLS");
  array::add(var_b4728b19, "SCORE");
  array::add(var_b4728b19, "ASSISTS");
  array::add(var_b4728b19, "INCAPS");
  array::add(var_b4728b19, "REVIVES");
  foreach(stat in var_b4728b19) {
    statvalue = self getdstat("PlayerStatsList", stat, "statValue");
    self setdstat("PlayerStatsByMap", var_5df3645b, "currentStats", stat, statvalue);
  }
  for(i = 0; i < 6; i++) {
    var_b53e21eb = self getdstat("PlayerStatsByMap", var_5df3645b, "completedDifficulties", i);
    self setdstat("PlayerStatsByMap", var_5df3645b, "previousCompletedDifficulties", i, var_b53e21eb);
    var_16925818 = self getdstat("PlayerStatsBymap", var_5df3645b, "receivedXPForDifficulty", i);
    self setdstat("PlayerStatsByMap", var_5df3645b, "previousReceivedXPForDifficulty", i, var_16925818);
  }
  for(i = 0; i < 20; i++) {
    var_8514318e = self getdstat("PlayerCPDecorations", i);
    self setdstat("currentPlayerCPDecorations", i, var_8514318e);
  }
  uploadstats(self);
}

function recordactiveplayersendgamematchrecordstats() {
  foreach(player in level.players) {
    recordplayermatchend(player);
    recordplayerstats(player, "presentAtEnd", 1);
  }
}