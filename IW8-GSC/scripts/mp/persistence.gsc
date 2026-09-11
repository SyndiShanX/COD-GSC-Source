/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\persistence.gsc
***********************************************/

function init() {
  level.persistentdatainfo = [];
  thread updatebufferedstats();
  thread ref_13fc7();
  thread uploadglobalstatcounters();
  thread writekdhistorystats();
}

function initbufferedstats() {
  self.bufferedstats = [];
  self.squadmemberbufferedstats = [];
  self.bufferedchildstats = [];
  self.bufferedchildstats["round"] = [];
  self.bufferedchildstats["round"]["timePlayed"] = self getplayerdata("common", "round", "timePlayed");

  if(scripts\mp\utility\game::onlinestatsenabled()) {
    self.bufferedstats["totalShots"] = self getplayerdata("mp", "totalShots");
    self.bufferedstats["accuracy"] = self getplayerdata("mp", "accuracy");
    self.bufferedstats["misses"] = self getplayerdata("mp", "misses");
    self.bufferedstats["hits"] = self getplayerdata("mp", "hits");
    self.bufferedchildstats["xpMultiplierTimePlayed"] = [];
    self.bufferedchildstats["xpMultiplierTimePlayed"][0] = self getplayerdata("mp", "xpMultiplierTimePlayed", 0);
    self.bufferedchildstats["xpMultiplierTimePlayed"][1] = self getplayerdata("mp", "xpMultiplierTimePlayed", 1);
    self.bufferedchildstats["xpMultiplierTimePlayed"][2] = self getplayerdata("mp", "xpMultiplierTimePlayed", 2);
    self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"] = [];
    self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0] = self getplayerdata("mp", "xpMaxMultiplierTimePlayed", 0);
    self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1] = self getplayerdata("mp", "xpMaxMultiplierTimePlayed", 1);
    self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2] = self getplayerdata("mp", "xpMaxMultiplierTimePlayed", 2);
    self.bufferedchildstats["challengeXPMultiplierTimePlayed"] = [];
    self.bufferedchildstats["challengeXPMultiplierTimePlayed"][0] = self getplayerdata("mp", "challengeXPMultiplierTimePlayed", 0);
    self.bufferedchildstatsmax["challengeXPMaxMultiplierTimePlayed"] = [];
    self.bufferedchildstatsmax["challengeXPMaxMultiplierTimePlayed"][0] = self getplayerdata("mp", "challengeXPMaxMultiplierTimePlayed", 0);
    self.bufferedchildstats["weaponXPMultiplierTimePlayed"] = [];
    self.bufferedchildstats["weaponXPMultiplierTimePlayed"][0] = self getplayerdata("mp", "weaponXPMultiplierTimePlayed", 0);
    self.bufferedchildstatsmax["weaponXPMaxMultiplierTimePlayed"] = [];
    self.bufferedchildstatsmax["weaponXPMaxMultiplierTimePlayed"][0] = self getplayerdata("mp", "weaponXPMaxMultiplierTimePlayed", 0);
    self.bufferedstats["prestigeDoubleWeaponXp"] = self getplayerdata("mp", "prestigeDoubleWeaponXp");
    self.bufferedstats["prestigeDoubleWeaponXpTimePlayed"] = self getplayerdata("mp", "prestigeDoubleWeaponXpTimePlayed");
    self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"] = self getplayerdata("mp", "prestigeDoubleWeaponXpMaxTimePlayed");
    initbestscorestatstable();
    return;
  }
}

function initbestscorestatstable() {
  var_0 = "mp/bestscorestatsTable.csv";
  self.bestscorestats = [];
  self.bufferedbestscorestats = [];

  for(var_1 = 0;; var_1++) {
    var_2 = tablelookupbyrow(var_0, var_1, 0);

    if(var_2 == "") {
      break;
    }

    self.bestscorestats[var_2] = self getplayerdata("mp", "bestScores", var_2);
  }
}

function statgetchild(var_0, var_1) {
  if(var_0 == "round") {
    return self getplayerdata("common", var_0, var_1);
  }

  return self getplayerdata("mp", var_0, var_1);
}

function statsetchild(var_0, var_1, var_2, var_3) {
  if(isagent(self)) {
    return;
  }

  if(istrue(game["practiceRound"])) {
    return;
  }

  if(isDefined(var_3) || !scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }

  if(var_0 == "round") {
    self setplayerdata("common", var_0, var_1, var_2);
    setbestscore(var_1, var_2);
    return;
  }

  self setplayerdata("mp", var_0, var_1, var_2);
}

function stataddchild(var_0, var_1, var_2) {
  if(!scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }

  var_3 = self getplayerdata("mp", var_0, var_1);
  self setplayerdata("mp", var_0, var_1, var_3 + var_2);
}

function statgetchildbuffered(var_0, var_1, var_2) {
  if(!scripts\mp\utility\game::onlinestatsenabled() && !istrue(var_2)) {
    return 0;
  }

  return self.bufferedchildstats[var_0][var_1];
}

function statsetchildbuffered(var_0, var_1, var_2, var_3) {
  if(!scripts\mp\utility\game::onlinestatsenabled() && !istrue(var_3)) {
    return;
  }

  self.bufferedchildstats[var_0][var_1] = var_2;
}

function stataddchildbuffered(var_0, var_1, var_2, var_3) {
  if(!scripts\mp\utility\game::onlinestatsenabled() && !istrue(var_3)) {
    return;
  }

  var_4 = statgetchildbuffered(var_0, var_1, var_3);
  statsetchildbuffered(var_0, var_1, var_4 + var_2, var_3);
}

function stataddchildbufferedwithmax(var_0, var_1, var_2, var_3) {
  if(!scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }

  var_4 = statgetchildbuffered(var_0, var_1) + var_2;

  if(var_4 > var_3) {
    var_4 = var_3;
  }

  if(var_4 < statgetchildbuffered(var_0, var_1)) {
    var_4 = var_3;
  }

  statsetchildbuffered(var_0, var_1, var_4);
}

function updatebufferedstats() {
  wait 0.15;
  var_0 = 0;

  while(!level.gameended) {
    scripts\mp\hostmigration::waittillhostmigrationdone();
    var_0++;

    if(var_0 >= level.players.size) {
      var_0 = 0;
    }

    if(isDefined(level.players[var_0])) {
      writebufferedstats(level.players[var_0]);
      updateweaponbufferedstats(level.players[var_0]);
    }

    wait 2;
  }
}

function ref_13fc7() {
  level endon("game_cleanup");
  level waittill("game_ended");

  foreach(var_1 in level.players) {
    writebufferedstats(var_1);
    updateweaponbufferedstats(var_1);
  }

  level.disableweaponstats = 1;
}

function setbestscore(var_0, var_1) {
  var_2 = scripts\mp\utility\game::onlinestatsenabled();

  if(!var_2) {
    return;
  }

  if(isDefined(self.bestscorestats[var_0]) && var_1 > self.bestscorestats[var_0]) {
    self.bestscorestats[var_0] = var_1;
    self.bufferedbestscorestats[var_0] = var_1;
    return;
  }
}

function writebestscores() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1) && var_1 scripts\mp\utility\game::onlinestatsenabled()) {
      foreach(var_3 in var_1.bufferedbestscorestats) {
        var_1 setplayerdata("mp", "bestScores", var_4, var_3);
      }
    }
  }
}

function writebufferedstats() {
  var_0 = scripts\mp\utility\game::onlinestatsenabled();

  if(var_0) {
    foreach(var_3, var_2 in self.bufferedstats) {
      self setplayerdata("mp", var_3, var_2);
    }

    if(!isai(self)) {
      foreach(var_3, var_2 in self.squadmemberbufferedstats) {
        self setplayerdata(level.loadoutsgroup, "squadMembers", var_3, var_2);
      }
    }
  }

  foreach(var_2 in self.bufferedchildstats) {
    foreach(var_8, var_7 in var_2) {
      if(var_3 == "round") {
        self setplayerdata("common", var_3, var_8, var_7);
        setbestscore(var_8, var_7);
        continue;
      }

      if(var_0) {
        self setplayerdata("mp", var_3, var_8, var_7);
      }
    }
  }
}

function writekdhistorystats() {
  if(!scripts\mp\utility\game::matchmakinggame()) {
    return;
  }

  level waittill("game_ended");
  wait 0.1;

  if(scripts\mp\utility\game::waslastround() || !scripts\mp\utility\game::isroundbased() && scripts\mp\utility\game::hittimelimit()) {
    foreach(var_1 in level.players) {
      var_2 = 0;

      if(isDefined(var_1.pers["shotsFired"]) && var_1.pers["shotsFired"] > 0) {
        var_3 = var_1.pers["shotsFired"];
        var_4 = 0;

        if(isDefined(var_1.pers["shotsHit"])) {
          var_4 = var_1.pers["shotsHit"];
        }

        var_2 = int(100 * var_4 / var_3);
      }

      incrementrankedreservedhistory(var_1, var_1.kills, var_1.deaths, var_1.pers["headshots"], var_2, var_1.pers["damage"]);
    }

    return;
  }
}

function incrementrankedreservedhistory(var_0, var_1, var_2, var_3, var_4) {
  if(!scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }

  for(var_5 = 0; var_5 < 4; var_5++) {
    var_6 = self getplayerdata("mp", "kdHistoryK", var_5 + 1);
    self setplayerdata("mp", "kdHistoryK", var_5, var_6);
    var_6 = self getplayerdata("mp", "kdHistoryD", var_5 + 1);
    self setplayerdata("mp", "kdHistoryD", var_5, var_6);
    var_6 = self getplayerdata("mp", "headshotHistory", var_5 + 1);
    self setplayerdata("mp", "headshotHistory", var_5, var_6);
    var_6 = self getplayerdata("mp", "accuracyHistory", var_5 + 1);
    self setplayerdata("mp", "accuracyHistory", var_5, var_6);
    var_6 = self getplayerdata("mp", "damageHistory", var_5 + 1);
    self setplayerdata("mp", "damageHistory", var_5, var_6);
  }

  self setplayerdata("mp", "kdHistoryK", 4, int(clamp(var_0, 0, 255)));
  self setplayerdata("mp", "kdHistoryD", 4, int(clamp(var_1, 0, 255)));
  self setplayerdata("mp", "headshotHistory", 4, int(clamp(var_2, 0, 255)));
  self setplayerdata("mp", "accuracyHistory", 4, int(var_3));
  self setplayerdata("mp", "damageHistory", 4, var_4);
}

function incrementweaponstat(var_0, var_1, var_2) {
  if(scripts\mp\utility\weapon::iskillstreakweapon(var_0)) {
    return;
  }

  if(istrue(level.disableweaponstats)) {
    return;
  }

  if(scripts\mp\utility\game::onlinestatsenabled()) {
    var_3 = self getplayerdata("mp", "playerStats", "weaponStats", var_0, var_1);
    self setplayerdata("mp", "playerStats", "weaponStats", var_0, var_1, var_3 + var_2);
    return;
  }
}

function incrementattachmentstat(var_0, var_1, var_2, var_3) {
  if(istrue(level.disableweaponstats)) {
    return;
  }

  if(!scripts\mp\utility\weapon::attachmentlogsstats(var_0, var_3)) {
    return;
  }

  if(scripts\mp\utility\game::onlinestatsenabled()) {
    var_4 = self getplayerdata("mp", "playerStats", "attachmentsStats", var_0, var_1);
    self setplayerdata("mp", "playerStats", "attachmentsStats", var_0, var_1, var_4 + var_2);
    return;
  }
}

function updateweaponbufferedstats(var_0) {
  if(!isDefined(self.trackingweapon)) {
    return;
  }

  if(nullweapon(self.trackingweapon)) {
    return;
  }

  if(scripts\mp\utility\weapon::issuperweapon(self.trackingweapon)) {
    if(!istrue(scripts\mp\supers::shouldtracksuperweaponstats(self.trackingweapon))) {
      return;
    }
  }

  if(scripts\mp\utility\weapon::iskillstreakweapon(self.trackingweapon) || scripts\mp\utility\weapon::isenvironmentweapon(self.trackingweapon) || scripts\mp\utility\weapon::isbombsiteweapon(self.trackingweapon)) {
    return;
  }

  var_1 = self.trackingweapon;
  var_2 = undefined;

  if(var_1.isalternate) {
    var_3 = scripts\mp\utility\weapon::attachmentmap_tobase(var_1.underbarrel);

    if(var_3 == "shotgun" || var_3 == "gl" || var_3 == "glsmoke" || var_3 == "glgas" || var_3 == "glconc" || var_3 == "glflash" || var_3 == "glincendiary" || var_3 == "glsemtex" || var_3 == "glsnap") {
      var_2 = var_3;
      perslog_attachmentstats(var_2, var_1);
      persclear_stats();
      return;
    }
  }

  if(!isDefined(var_2)) {
    var_4 = var_1.basename;

    if(getsubstr(var_4, 0, 4) == "iw8_" || getsubstr(var_4, 0, 3) == "s4_") {
      var_2 = scripts\mp\utility\weapon::getweaponrootname(var_1);
    }
  }

  if(!scripts\mp\utility\weapon::iscacprimaryweapon(var_2) && !scripts\mp\utility\weapon::iscacsecondaryweapon(var_2)) {
    return;
  }

  var_5 = getweaponvariantindex(var_1);
  persincrement_weaponstats(var_2, var_5);

  if(!isDefined(level.get_audio_approved_length_extender_for_non_english_vo)) {
    level.get_audio_approved_length_extender_for_non_english_vo = scripts\mp\utility\game::getgametype() == "br" && getdvarint("scr_track_picked_up_weapon_stats", 1) == 1;
  }

  if(!scripts\mp\utility\weapon::ispickedupweapon(var_1) || istrue(level.get_audio_approved_length_extender_for_non_english_vo)) {
    perslog_weaponstats(var_2, var_5, var_0);
  }

  var_6 = getweaponattachments(var_1);

  foreach(var_3 in var_6) {
    var_8 = scripts\mp\utility\weapon::attachmentmap_tobase(var_3);

    if(!scripts\mp\utility\weapon::attachmentlogsstats(var_8, var_1)) {
      continue;
    }

    switch (var_8) {
      case "shotgun":
      case "glsnap":
      case "glsemtex":
      case "glincendiary":
      case "glflash":
      case "glconc":
      case "glgas":
      case "glsmoke":
      case "gl":
        continue;
    }

    perslog_attachmentstats(var_8, var_1);
  }

  persclear_stats();
}

function persclear_stats() {
  self.trackingweapon = isundefinedweapon();
  self.trackingweaponshots = 0;
  self.trackingweaponkills = 0;
  self.trackingweaponhits = 0;
  self.trackingweaponheadshots = 0;
  self.trackingweapondeaths = 0;
}

function persincrement_weaponstats(var_0, var_1) {
  if(self.trackingweaponshots > 0) {
    incrementweaponstat(var_0, "shots", self.trackingweaponshots);
  }

  if(self.trackingweaponkills > 0) {
    incrementweaponstat(var_0, "kills", self.trackingweaponkills);
  }

  if(self.trackingweaponhits > 0) {
    incrementweaponstat(var_0, "hits", self.trackingweaponhits);
  }

  if(self.trackingweaponheadshots > 0) {
    incrementweaponstat(var_0, "headShots", self.trackingweaponheadshots);
  }

  if(self.trackingweapondeaths > 0) {
    incrementweaponstat(var_0, "deaths", self.trackingweapondeaths);
    return;
  }
}

function perslog_weaponstats(var_0, var_1, var_2) {
  if(self.trackingweaponshots > 0) {
    scripts\common\utility::ref_13e0a(level.ref_11b31, var_0, "shots", self.trackingweaponshots, var_1, var_2);
  }

  if(self.trackingweaponkills > 0) {
    scripts\common\utility::ref_13e0a(level.ref_11b31, var_0, "kills", self.trackingweaponkills, var_1, var_2);
  }

  if(self.trackingweaponhits > 0) {
    scripts\common\utility::ref_13e0a(level.ref_11b31, var_0, "hits", self.trackingweaponhits, var_1, var_2);
  }

  if(self.trackingweaponheadshots > 0) {
    scripts\common\utility::ref_13e0a(level.ref_11b31, var_0, "headshots", self.trackingweaponheadshots, var_1, var_2);
  }

  if(self.trackingweapondeaths > 0) {
    scripts\common\utility::ref_13e0a(level.ref_11b31, var_0, "deaths", self.trackingweapondeaths, var_1, var_2);
    return;
  }
}

function perslog_attachmentstats(var_0, var_1) {
  if(!scripts\mp\utility\weapon::attachmentlogsstats(var_0, var_1)) {
    return;
  }

  if(self.trackingweaponshots > 0 && var_0 != "tactical") {
    incrementattachmentstat(var_0, "shots", self.trackingweaponshots, var_1);
    scripts\common\utility::ref_13e0a(level.ref_11b25, var_0, "shots", self.trackingweaponshots, var_1);
  }

  if(self.trackingweaponkills > 0 && var_0 != "tactical") {
    incrementattachmentstat(var_0, "kills", self.trackingweaponkills, var_1);
    scripts\common\utility::ref_13e0a(level.ref_11b25, var_0, "kills", self.trackingweaponkills, var_1);
  }

  if(self.trackingweaponhits > 0 && var_0 != "tactical") {
    incrementattachmentstat(var_0, "hits", self.trackingweaponhits, var_1);
    scripts\common\utility::ref_13e0a(level.ref_11b25, var_0, "hits", self.trackingweaponhits, var_1);
  }

  if(self.trackingweaponheadshots > 0 && var_0 != "tactical") {
    incrementattachmentstat(var_0, "headShots", self.trackingweaponheadshots, var_1);
    scripts\common\utility::ref_13e0a(level.ref_11b25, var_0, "headShots", self.trackingweaponheadshots, var_1);
  }

  if(self.trackingweapondeaths > 0) {
    incrementattachmentstat(var_0, "deaths", self.trackingweapondeaths, var_1);
    scripts\common\utility::ref_13e0a(level.ref_11b25, var_0, "deaths", self.trackingweapondeaths, var_1);
    return;
  }
}

function uploadglobalstatcounters() {
  level waittill("game_ended");

  if(!scripts\mp\utility\game::matchmakinggame()) {
    return;
  }

  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;

  foreach(var_7 in level.players) {
    var_5 += var_7.timeplayed["total"];
  }

  getentitylessscriptablearray("dlog_event_global_minutes", ["increment", int(var_5 / 60)]);

  if(scripts\mp\utility\game::isroundbased() && !scripts\mp\utility\game::waslastround()) {
    return;
  }

  waitframe();

  foreach(var_7 in level.players) {
    var_0 += var_7.kills;
    var_1 += var_7.deaths;
    var_2 += var_7.assists;
    var_3 += var_7 scripts\mp\utility\stats::getpersstat("headshots");
    var_4 += var_7 scripts\mp\utility\stats::getpersstat("suicides");
  }

  getentitylessscriptablearray("dlog_event_global_kills", ["increment", var_0]);
  getentitylessscriptablearray("dlog_event_global_deaths", ["increment", var_1]);
  getentitylessscriptablearray("dlog_event_global_headshots", ["increment", var_3]);
  getentitylessscriptablearray("dlog_event_global_suicides", ["increment", var_4]);
  getentitylessscriptablearray("dlog_event_global_games", ["increment", 1]);

  if(!isDefined(level.assists_disabled)) {
    getentitylessscriptablearray("dlog_event_global_assists", ["increment", var_2]);
    return;
  }
}

function touchedmovingplatform() {
  if(!scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }

  for(var_0 = 4; var_0 > 0; var_0--) {
    var_1 = self getplayerdata("mp", "use_ping_history", var_0 - 1);
    self setplayerdata("mp", "use_ping_history", var_0, var_1);
    var_1 = self getplayerdata("mp", "use_ping_ack_history", var_0 - 1);
    self setplayerdata("mp", "use_ping_ack_history", var_0, var_1);
    var_1 = self getplayerdata("mp", "use_ping_enemy_history", var_0 - 1);
    self setplayerdata("mp", "use_ping_enemy_history", var_0, var_1);
    var_1 = self getplayerdata("mp", "use_buy_back_history", var_0 - 1);
    self setplayerdata("mp", "use_buy_back_history", var_0, var_1);
    var_1 = self getplayerdata("mp", "use_revive_history", var_0 - 1);
    self setplayerdata("mp", "use_revive_history", var_0, var_1);
    var_1 = self getplayerdata("mp", "use_quest_complete_history", var_0 - 1);
    self setplayerdata("mp", "use_quest_complete_history", var_0, var_1);
  }

  self setplayerdata("mp", "use_ping_history", 0, 0);
  self setplayerdata("mp", "use_ping_ack_history", 0, 0);
  self setplayerdata("mp", "use_ping_enemy_history", 0, 0);
  self setplayerdata("mp", "use_buy_back_history", 0, 0);
  self setplayerdata("mp", "use_revive_history", 0, 0);
  self setplayerdata("mp", "use_quest_complete_history", 0, 0);
}