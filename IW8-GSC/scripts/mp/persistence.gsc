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
  var0 = "mp/bestscorestatsTable.csv";
  self.bestscorestats = [];
  self.bufferedbestscorestats = [];

  for(var1 = 0;; var1++) {
    var2 = tablelookupbyrow(var0, var1, 0);

    if(var2 == "") {
      break;
    }

    self.bestscorestats[var2] = self getplayerdata("mp", "bestScores", var2);
  }
}

function statgetchild(var0, var1) {
  if(var0 == "round") {
    return self getplayerdata("common", var0, var1);
  }

  return self getplayerdata("mp", var0, var1);
}

function statsetchild(var0, var1, var2, var3) {
  if(isagent(self)) {
    return;
  }

  if(istrue(game["practiceRound"])) {
    return;
  }

  if(isDefined(var3) || !scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }

  if(var0 == "round") {
    self setplayerdata("common", var0, var1, var2);
    setbestscore(var1, var2);
    return;
  }

  self setplayerdata("mp", var0, var1, var2);
}

function stataddchild(var0, var1, var2) {
  if(!scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }

  var3 = self getplayerdata("mp", var0, var1);
  self setplayerdata("mp", var0, var1, var3 + var2);
}

function statgetchildbuffered(var0, var1, var2) {
  if(!scripts\mp\utility\game::onlinestatsenabled() && !istrue(var2)) {
    return 0;
  }

  return self.bufferedchildstats[var0][var1];
}

function statsetchildbuffered(var0, var1, var2, var3) {
  if(!scripts\mp\utility\game::onlinestatsenabled() && !istrue(var3)) {
    return;
  }

  self.bufferedchildstats[var0][var1] = var2;
}

function stataddchildbuffered(var0, var1, var2, var3) {
  if(!scripts\mp\utility\game::onlinestatsenabled() && !istrue(var3)) {
    return;
  }

  var4 = statgetchildbuffered(var0, var1, var3);
  statsetchildbuffered(var0, var1, var4 + var2, var3);
}

function stataddchildbufferedwithmax(var0, var1, var2, var3) {
  if(!scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }

  var4 = statgetchildbuffered(var0, var1) + var2;

  if(var4 > var3) {
    var4 = var3;
  }

  if(var4 < statgetchildbuffered(var0, var1)) {
    var4 = var3;
  }

  statsetchildbuffered(var0, var1, var4);
}

function updatebufferedstats() {
  wait 0.15;
  var0 = 0;

  while(!level.gameended) {
    scripts\mp\hostmigration::waittillhostmigrationdone();
    var0++;

    if(var0 >= level.players.size) {
      var0 = 0;
    }

    if(isDefined(level.players[var0])) {
      writebufferedstats(level.players[var0]);
      updateweaponbufferedstats(level.players[var0]);
    }

    wait 2;
  }
}

function ref_13fc7() {
  level endon("game_cleanup");
  level waittill("game_ended");

  foreach(var1 in level.players) {
    writebufferedstats(var1);
    updateweaponbufferedstats(var1);
  }

  level.disableweaponstats = 1;
}

function setbestscore(var0, var1) {
  var2 = scripts\mp\utility\game::onlinestatsenabled();

  if(!var2) {
    return;
  }

  if(isDefined(self.bestscorestats[var0]) && var1 > self.bestscorestats[var0]) {
    self.bestscorestats[var0] = var1;
    self.bufferedbestscorestats[var0] = var1;
    return;
  }
}

function writebestscores() {
  foreach(var1 in level.players) {
    if(isDefined(var1) && var1 scripts\mp\utility\game::onlinestatsenabled()) {
      foreach(var3 in var1.bufferedbestscorestats) {
        var1 setplayerdata("mp", "bestScores", var4, var3);
      }
    }
  }
}

function writebufferedstats() {
  var0 = scripts\mp\utility\game::onlinestatsenabled();

  if(var0) {
    foreach(var3, var2 in self.bufferedstats) {
      self setplayerdata("mp", var3, var2);
    }

    if(!isai(self)) {
      foreach(var3, var2 in self.squadmemberbufferedstats) {
        self setplayerdata(level.loadoutsgroup, "squadMembers", var3, var2);
      }
    }
  }

  foreach(var2 in self.bufferedchildstats) {
    foreach(var8, var7 in var2) {
      if(var3 == "round") {
        self setplayerdata("common", var3, var8, var7);
        setbestscore(var8, var7);
        continue;
      }

      if(var0) {
        self setplayerdata("mp", var3, var8, var7);
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
    foreach(var1 in level.players) {
      var2 = 0;

      if(isDefined(var1.pers["shotsFired"]) && var1.pers["shotsFired"] > 0) {
        var3 = var1.pers["shotsFired"];
        var4 = 0;

        if(isDefined(var1.pers["shotsHit"])) {
          var4 = var1.pers["shotsHit"];
        }

        var2 = int(100 * var4 / var3);
      }

      incrementrankedreservedhistory(var1, var1.kills, var1.deaths, var1.pers["headshots"], var2, var1.pers["damage"]);
    }

    return;
  }
}

function incrementrankedreservedhistory(var0, var1, var2, var3, var4) {
  if(!scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }

  for(var5 = 0; var5 < 4; var5++) {
    var6 = self getplayerdata("mp", "kdHistoryK", var5 + 1);
    self setplayerdata("mp", "kdHistoryK", var5, var6);
    var6 = self getplayerdata("mp", "kdHistoryD", var5 + 1);
    self setplayerdata("mp", "kdHistoryD", var5, var6);
    var6 = self getplayerdata("mp", "headshotHistory", var5 + 1);
    self setplayerdata("mp", "headshotHistory", var5, var6);
    var6 = self getplayerdata("mp", "accuracyHistory", var5 + 1);
    self setplayerdata("mp", "accuracyHistory", var5, var6);
    var6 = self getplayerdata("mp", "damageHistory", var5 + 1);
    self setplayerdata("mp", "damageHistory", var5, var6);
  }

  self setplayerdata("mp", "kdHistoryK", 4, int(clamp(var0, 0, 255)));
  self setplayerdata("mp", "kdHistoryD", 4, int(clamp(var1, 0, 255)));
  self setplayerdata("mp", "headshotHistory", 4, int(clamp(var2, 0, 255)));
  self setplayerdata("mp", "accuracyHistory", 4, int(var3));
  self setplayerdata("mp", "damageHistory", 4, var4);
}

function incrementweaponstat(var0, var1, var2) {
  if(scripts\mp\utility\weapon::iskillstreakweapon(var0)) {
    return;
  }

  if(istrue(level.disableweaponstats)) {
    return;
  }

  if(scripts\mp\utility\game::onlinestatsenabled()) {
    var3 = self getplayerdata("mp", "playerStats", "weaponStats", var0, var1);
    self setplayerdata("mp", "playerStats", "weaponStats", var0, var1, var3 + var2);
    return;
  }
}

function incrementattachmentstat(var0, var1, var2, var3) {
  if(istrue(level.disableweaponstats)) {
    return;
  }

  if(!scripts\mp\utility\weapon::attachmentlogsstats(var0, var3)) {
    return;
  }

  if(scripts\mp\utility\game::onlinestatsenabled()) {
    var4 = self getplayerdata("mp", "playerStats", "attachmentsStats", var0, var1);
    self setplayerdata("mp", "playerStats", "attachmentsStats", var0, var1, var4 + var2);
    return;
  }
}

function updateweaponbufferedstats(var0) {
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

  var1 = self.trackingweapon;
  var2 = undefined;

  if(var1.isalternate) {
    var3 = scripts\mp\utility\weapon::attachmentmap_tobase(var1.underbarrel);

    if(var3 == "shotgun" || var3 == "gl" || var3 == "glsmoke" || var3 == "glgas" || var3 == "glconc" || var3 == "glflash" || var3 == "glincendiary" || var3 == "glsemtex" || var3 == "glsnap") {
      var2 = var3;
      perslog_attachmentstats(var2, var1);
      persclear_stats();
      return;
    }
  }

  if(!isDefined(var2)) {
    var4 = var1.basename;

    if(getsubstr(var4, 0, 4) == "iw8_" || getsubstr(var4, 0, 3) == "s4_") {
      var2 = scripts\mp\utility\weapon::getweaponrootname(var1);
    }
  }

  if(!scripts\mp\utility\weapon::iscacprimaryweapon(var2) && !scripts\mp\utility\weapon::iscacsecondaryweapon(var2)) {
    return;
  }

  var5 = getweaponvariantindex(var1);
  persincrement_weaponstats(var2, var5);

  if(!isDefined(level.get_audio_approved_length_extender_for_non_english_vo)) {
    level.get_audio_approved_length_extender_for_non_english_vo = scripts\mp\utility\game::getgametype() == "br" && getdvarint("scr_track_picked_up_weapon_stats", 1) == 1;
  }

  if(!scripts\mp\utility\weapon::ispickedupweapon(var1) || istrue(level.get_audio_approved_length_extender_for_non_english_vo)) {
    perslog_weaponstats(var2, var5, var0);
  }

  var6 = getweaponattachments(var1);

  foreach(var3 in var6) {
    var8 = scripts\mp\utility\weapon::attachmentmap_tobase(var3);

    if(!scripts\mp\utility\weapon::attachmentlogsstats(var8, var1)) {
      continue;
    }

    switch (var8) {
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

    perslog_attachmentstats(var8, var1);
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

function persincrement_weaponstats(var0, var1) {
  if(self.trackingweaponshots > 0) {
    incrementweaponstat(var0, "shots", self.trackingweaponshots);
  }

  if(self.trackingweaponkills > 0) {
    incrementweaponstat(var0, "kills", self.trackingweaponkills);
  }

  if(self.trackingweaponhits > 0) {
    incrementweaponstat(var0, "hits", self.trackingweaponhits);
  }

  if(self.trackingweaponheadshots > 0) {
    incrementweaponstat(var0, "headShots", self.trackingweaponheadshots);
  }

  if(self.trackingweapondeaths > 0) {
    incrementweaponstat(var0, "deaths", self.trackingweapondeaths);
    return;
  }
}

function perslog_weaponstats(var0, var1, var2) {
  if(self.trackingweaponshots > 0) {
    scripts\common\utility::ref_13e0a(level.ref_11b31, var0, "shots", self.trackingweaponshots, var1, var2);
  }

  if(self.trackingweaponkills > 0) {
    scripts\common\utility::ref_13e0a(level.ref_11b31, var0, "kills", self.trackingweaponkills, var1, var2);
  }

  if(self.trackingweaponhits > 0) {
    scripts\common\utility::ref_13e0a(level.ref_11b31, var0, "hits", self.trackingweaponhits, var1, var2);
  }

  if(self.trackingweaponheadshots > 0) {
    scripts\common\utility::ref_13e0a(level.ref_11b31, var0, "headshots", self.trackingweaponheadshots, var1, var2);
  }

  if(self.trackingweapondeaths > 0) {
    scripts\common\utility::ref_13e0a(level.ref_11b31, var0, "deaths", self.trackingweapondeaths, var1, var2);
    return;
  }
}

function perslog_attachmentstats(var0, var1) {
  if(!scripts\mp\utility\weapon::attachmentlogsstats(var0, var1)) {
    return;
  }

  if(self.trackingweaponshots > 0 && var0 != "tactical") {
    incrementattachmentstat(var0, "shots", self.trackingweaponshots, var1);
    scripts\common\utility::ref_13e0a(level.ref_11b25, var0, "shots", self.trackingweaponshots, var1);
  }

  if(self.trackingweaponkills > 0 && var0 != "tactical") {
    incrementattachmentstat(var0, "kills", self.trackingweaponkills, var1);
    scripts\common\utility::ref_13e0a(level.ref_11b25, var0, "kills", self.trackingweaponkills, var1);
  }

  if(self.trackingweaponhits > 0 && var0 != "tactical") {
    incrementattachmentstat(var0, "hits", self.trackingweaponhits, var1);
    scripts\common\utility::ref_13e0a(level.ref_11b25, var0, "hits", self.trackingweaponhits, var1);
  }

  if(self.trackingweaponheadshots > 0 && var0 != "tactical") {
    incrementattachmentstat(var0, "headShots", self.trackingweaponheadshots, var1);
    scripts\common\utility::ref_13e0a(level.ref_11b25, var0, "headShots", self.trackingweaponheadshots, var1);
  }

  if(self.trackingweapondeaths > 0) {
    incrementattachmentstat(var0, "deaths", self.trackingweapondeaths, var1);
    scripts\common\utility::ref_13e0a(level.ref_11b25, var0, "deaths", self.trackingweapondeaths, var1);
    return;
  }
}

function uploadglobalstatcounters() {
  level waittill("game_ended");

  if(!scripts\mp\utility\game::matchmakinggame()) {
    return;
  }

  var0 = 0;
  var1 = 0;
  var2 = 0;
  var3 = 0;
  var4 = 0;
  var5 = 0;

  foreach(var7 in level.players) {
    var5 += var7.timeplayed["total"];
  }

  getentitylessscriptablearray("dlog_event_global_minutes", ["increment", int(var5 / 60)]);

  if(scripts\mp\utility\game::isroundbased() && !scripts\mp\utility\game::waslastround()) {
    return;
  }

  waitframe();

  foreach(var7 in level.players) {
    var0 += var7.kills;
    var1 += var7.deaths;
    var2 += var7.assists;
    var3 += var7 scripts\mp\utility\stats::getpersstat("headshots");
    var4 += var7 scripts\mp\utility\stats::getpersstat("suicides");
  }

  getentitylessscriptablearray("dlog_event_global_kills", ["increment", var0]);
  getentitylessscriptablearray("dlog_event_global_deaths", ["increment", var1]);
  getentitylessscriptablearray("dlog_event_global_headshots", ["increment", var3]);
  getentitylessscriptablearray("dlog_event_global_suicides", ["increment", var4]);
  getentitylessscriptablearray("dlog_event_global_games", ["increment", 1]);

  if(!isDefined(level.assists_disabled)) {
    getentitylessscriptablearray("dlog_event_global_assists", ["increment", var2]);
    return;
  }
}

function touchedmovingplatform() {
  if(!scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }

  for(var0 = 4; var0 > 0; var0--) {
    var1 = self getplayerdata("mp", "use_ping_history", var0 - 1);
    self setplayerdata("mp", "use_ping_history", var0, var1);
    var1 = self getplayerdata("mp", "use_ping_ack_history", var0 - 1);
    self setplayerdata("mp", "use_ping_ack_history", var0, var1);
    var1 = self getplayerdata("mp", "use_ping_enemy_history", var0 - 1);
    self setplayerdata("mp", "use_ping_enemy_history", var0, var1);
    var1 = self getplayerdata("mp", "use_buy_back_history", var0 - 1);
    self setplayerdata("mp", "use_buy_back_history", var0, var1);
    var1 = self getplayerdata("mp", "use_revive_history", var0 - 1);
    self setplayerdata("mp", "use_revive_history", var0, var1);
    var1 = self getplayerdata("mp", "use_quest_complete_history", var0 - 1);
    self setplayerdata("mp", "use_quest_complete_history", var0, var1);
  }

  self setplayerdata("mp", "use_ping_history", 0, 0);
  self setplayerdata("mp", "use_ping_ack_history", 0, 0);
  self setplayerdata("mp", "use_ping_enemy_history", 0, 0);
  self setplayerdata("mp", "use_buy_back_history", 0, 0);
  self setplayerdata("mp", "use_revive_history", 0, 0);
  self setplayerdata("mp", "use_quest_complete_history", 0, 0);
}