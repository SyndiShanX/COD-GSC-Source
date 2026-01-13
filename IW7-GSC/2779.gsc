/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2779.gsc
**************************************/

init() {
  level.persistentdatainfo = [];
  level thread func_12E6A();
  level thread func_12F85();
  level thread func_13E05();
}

initbufferedstats() {
  self.bufferedstats = [];
  self.squadmemberbufferedstats = [];

  if(scripts\mp\utility\game::rankingenabled()) {
    self.bufferedstats["totalShots"] = self getrankedplayerdata("mp", "totalShots");
    self.bufferedstats["accuracy"] = self getrankedplayerdata("mp", "accuracy");
    self.bufferedstats["misses"] = self getrankedplayerdata("mp", "misses");
    self.bufferedstats["hits"] = self getrankedplayerdata("mp", "hits");
  }

  self.bufferedstats["timePlayedAllies"] = self getrankedplayerdata("mp", "timePlayedAllies");
  self.bufferedstats["timePlayedOpfor"] = self getrankedplayerdata("mp", "timePlayedOpfor");
  self.bufferedstats["timePlayedOther"] = self getrankedplayerdata("mp", "timePlayedOther");
  self.bufferedstats["timePlayedTotal"] = self getrankedplayerdata("mp", "timePlayedTotal");
  self.bufferedchildstats = [];
  self.bufferedchildstats["round"] = [];
  self.bufferedchildstats["round"]["timePlayed"] = self getrankedplayerdata("common", "round", "timePlayed");

  if(scripts\mp\utility\game::rankingenabled()) {
    self.bufferedchildstats["xpMultiplierTimePlayed"] = [];
    self.bufferedchildstats["xpMultiplierTimePlayed"][0] = self getrankedplayerdata("mp", "xpMultiplierTimePlayed", 0);
    self.bufferedchildstats["xpMultiplierTimePlayed"][1] = self getrankedplayerdata("mp", "xpMultiplierTimePlayed", 1);
    self.bufferedchildstats["xpMultiplierTimePlayed"][2] = self getrankedplayerdata("mp", "xpMultiplierTimePlayed", 2);
    self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"] = [];
    self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0] = self getrankedplayerdata("mp", "xpMaxMultiplierTimePlayed", 0);
    self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1] = self getrankedplayerdata("mp", "xpMaxMultiplierTimePlayed", 1);
    self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2] = self getrankedplayerdata("mp", "xpMaxMultiplierTimePlayed", 2);
    self.bufferedchildstats["challengeXPMultiplierTimePlayed"] = [];
    self.bufferedchildstats["challengeXPMultiplierTimePlayed"][0] = self getrankedplayerdata("mp", "challengeXPMultiplierTimePlayed", 0);
    self.bufferedchildstatsmax["challengeXPMaxMultiplierTimePlayed"] = [];
    self.bufferedchildstatsmax["challengeXPMaxMultiplierTimePlayed"][0] = self getrankedplayerdata("mp", "challengeXPMaxMultiplierTimePlayed", 0);
    self.bufferedchildstats["weaponXPMultiplierTimePlayed"] = [];
    self.bufferedchildstats["weaponXPMultiplierTimePlayed"][0] = self getrankedplayerdata("mp", "weaponXPMultiplierTimePlayed", 0);
    self.bufferedchildstatsmax["weaponXPMaxMultiplierTimePlayed"] = [];
    self.bufferedchildstatsmax["weaponXPMaxMultiplierTimePlayed"][0] = self getrankedplayerdata("mp", "weaponXPMaxMultiplierTimePlayed", 0);
    self.bufferedstats["prestigeDoubleWeaponXp"] = self getrankedplayerdata("mp", "prestigeDoubleWeaponXp");
    self.bufferedstats["prestigeDoubleWeaponXpTimePlayed"] = self getrankedplayerdata("mp", "prestigeDoubleWeaponXpTimePlayed");
    self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"] = self getrankedplayerdata("mp", "prestigeDoubleWeaponXpMaxTimePlayed");
  }

  initbestscorestatstable();
}

initbestscorestatstable() {
  var_0 = "mp\bestscorestatsTable.csv";
  self.bestscorestats = [];
  self.bufferedbestscorestats = [];
  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow(var_0, var_1, 0);

    if(var_2 == "") {
      break;
    }
    self.bestscorestats[var_2] = self getrankedplayerdata("mp", "bestScores", var_2);
    var_1++;
  }
}

statget(var_0) {
  return self getrankedplayerdata("mp", var_0);
}

func_10E54(var_0, var_1) {
  if(!scripts\mp\utility\game::rankingenabled()) {
    return;
  }
  self setrankedplayerdata("mp", var_0, var_1);
}

statadd(var_0, var_1, var_2) {
  if(!scripts\mp\utility\game::rankingenabled()) {
    return;
  }
  if(isDefined(var_2)) {
    var_3 = self getrankedplayerdata("mp", var_0, var_2);
    self setrankedplayerdata("mp", var_0, var_2, var_1 + var_3);
  } else {
    var_4 = self getrankedplayerdata("mp", var_0) + var_1;
    self setrankedplayerdata("mp", var_0, var_4);
  }
}

statgetchild(var_0, var_1) {
  if(var_0 == "round") {
    return self getrankedplayerdata("common", var_0, var_1);
  } else {
    return self getrankedplayerdata("mp", var_0, var_1);
  }
}

statsetchild(var_0, var_1, var_2, var_3) {
  if(isagent(self)) {
    return;
  }
  if(isDefined(var_3) || !scripts\mp\utility\game::rankingenabled()) {
    return;
  }
  if(var_0 == "round") {
    self setrankedplayerdata("common", var_0, var_1, var_2);
    setbestscore(var_1, var_2);
  } else
    self setrankedplayerdata("mp", var_0, var_1, var_2);
}

stataddchild(var_0, var_1, var_2) {
  if(!scripts\mp\utility\game::rankingenabled()) {
    return;
  }
  var_3 = self getrankedplayerdata("mp", var_0, var_1);
  self setrankedplayerdata("mp", var_0, var_1, var_3 + var_2);
}

statgetchildbuffered(var_0, var_1, var_2) {
  if(!scripts\mp\utility\game::rankingenabled() && !scripts\mp\utility\game::istrue(var_2)) {
    return 0;
  }

  return self.bufferedchildstats[var_0][var_1];
}

statsetchildbuffered(var_0, var_1, var_2, var_3) {
  if(!scripts\mp\utility\game::rankingenabled() && !scripts\mp\utility\game::istrue(var_3)) {
    return;
  }
  self.bufferedchildstats[var_0][var_1] = var_2;
}

stataddchildbuffered(var_0, var_1, var_2, var_3) {
  if(!scripts\mp\utility\game::rankingenabled() && !scripts\mp\utility\game::istrue(var_3)) {
    return;
  }
  var_4 = statgetchildbuffered(var_0, var_1, var_3);
  statsetchildbuffered(var_0, var_1, var_4 + var_2, var_3);
}

stataddbufferedwithmax(var_0, var_1, var_2) {
  if(!scripts\mp\utility\game::rankingenabled()) {
    return;
  }
  var_3 = statgetbuffered(var_0) + var_1;

  if(var_3 > var_2) {
    var_3 = var_2;
  }

  if(var_3 < statgetbuffered(var_0)) {
    var_3 = var_2;
  }

  func_10E55(var_0, var_3);
}

stataddchildbufferedwithmax(var_0, var_1, var_2, var_3) {
  if(!scripts\mp\utility\game::rankingenabled()) {
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

statgetbuffered(var_0, var_1) {
  if(!scripts\mp\utility\game::rankingenabled() && !scripts\mp\utility\game::istrue(var_1)) {
    return 0;
  }

  return self.bufferedstats[var_0];
}

func_10E37(var_0) {
  if(!scripts\mp\utility\game::rankingenabled()) {
    return 0;
  }

  return self.squadmemberbufferedstats[var_0];
}

func_10E55(var_0, var_1, var_2) {
  if(!scripts\mp\utility\game::rankingenabled() && !scripts\mp\utility\game::istrue(var_2)) {
    return;
  }
  self.bufferedstats[var_0] = var_1;
}

func_10E58(var_0, var_1) {
  if(!scripts\mp\utility\game::rankingenabled()) {
    return;
  }
  self.squadmemberbufferedstats[var_0] = var_1;
}

stataddbuffered(var_0, var_1, var_2) {
  if(!scripts\mp\utility\game::rankingenabled() && !scripts\mp\utility\game::istrue(var_2)) {
    return;
  }
  var_3 = statgetbuffered(var_0, var_2);
  func_10E55(var_0, var_3 + var_1, var_2);
}

func_10E18(var_0, var_1) {
  if(!scripts\mp\utility\game::rankingenabled()) {
    return;
  }
  var_2 = func_10E37(var_0);
  func_10E58(var_0, var_2 + var_1);
}

func_12E6A() {
  wait 0.15;
  var_0 = 0;

  while(!level.gameended) {
    scripts\mp\hostmigration::waittillhostmigrationdone();
    var_0++;

    if(var_0 >= level.players.size) {
      var_0 = 0;
    }

    if(isDefined(level.players[var_0])) {
      level.players[var_0] writebufferedstats();
      level.players[var_0] func_12F5E();
    }

    wait 2.0;
  }

  foreach(var_2 in level.players) {
    var_2 writebufferedstats();
    var_2 func_12F5E();
  }
}

setbestscore(var_0, var_1) {
  var_2 = scripts\mp\utility\game::rankingenabled();

  if(!var_2) {
    return;
  }
  if(isDefined(self.bestscorestats[var_0]) && var_1 > self.bestscorestats[var_0]) {
    self.bestscorestats[var_0] = var_1;
    self.bufferedbestscorestats[var_0] = var_1;
  }
}

writebestscores() {
  foreach(var_1 in level.players) {
    if(isDefined(var_1) && var_1 scripts\mp\utility\game::rankingenabled()) {
      foreach(var_4, var_3 in var_1.bufferedbestscorestats) {
        var_1 setrankedplayerdata("mp", "bestScores", var_4, var_3);
      }
    }
  }
}

writebufferedstats() {
  var_0 = scripts\mp\utility\game::rankingenabled();

  if(var_0) {
    foreach(var_3, var_2 in self.bufferedstats) {
      self setrankedplayerdata("mp", var_3, var_2);
    }

    if(!isai(self)) {
      foreach(var_3, var_2 in self.squadmemberbufferedstats) {
        self setrankedplayerdata("rankedloadouts", "squadMembers", var_3, var_2);
      }
    }
  }

  foreach(var_3, var_2 in self.bufferedchildstats) {
    foreach(var_8, var_7 in var_2) {
      if(var_3 == "round") {
        self setrankedplayerdata("common", var_3, var_8, var_7);
        setbestscore(var_8, var_7);
        continue;
      }

      if(var_0) {
        self setrankedplayerdata("mp", var_3, var_8, var_7);
      }
    }
  }
}

func_13E05() {
  if(!scripts\mp\utility\game::matchmakinggame()) {
    return;
  }
  level waittill("game_ended");
  wait 0.1;

  if(scripts\mp\utility\game::waslastround() || !scripts\mp\utility\game::isroundbased() && scripts\mp\utility\game::hittimelimit()) {
    foreach(var_1 in level.players) {
      var_1 func_93FB(var_1.kills, var_1.deaths);
    }
  }
}

func_93FB(var_0, var_1) {
  if(!scripts\mp\utility\game::rankingenabled()) {
    return;
  }
  for(var_2 = 0; var_2 < 4; var_2++) {
    var_3 = self getrankedplayerdata("mp", "kdHistoryK", var_2 + 1);
    self setrankedplayerdata("mp", "kdHistoryK", var_2, var_3);
    var_3 = self getrankedplayerdata("mp", "kdHistoryD", var_2 + 1);
    self setrankedplayerdata("mp", "kdHistoryD", var_2, var_3);
  }

  self setrankedplayerdata("mp", "kdHistoryK", 4, int(clamp(var_0, 0, 255)));
  self setrankedplayerdata("mp", "kdHistoryD", 4, int(clamp(var_1, 0, 255)));
}

func_93FC(var_0, var_1, var_2) {
  if(scripts\mp\utility\game::iskillstreakweapon(var_0)) {
    return;
  }
  if(isDefined(level.var_561D)) {
    return;
  }
  if(scripts\mp\utility\game::rankingenabled()) {
    var_3 = self getrankedplayerdata("mp", "weaponStats", var_0, var_1);
    self setrankedplayerdata("mp", "weaponStats", var_0, var_1, var_3 + var_2);
  }
}

func_93F9(var_0, var_1, var_2) {
  if(isDefined(level.var_561D)) {
    return;
  }
  if(!scripts\mp\utility\game::func_2490(var_0)) {
    return;
  }
  if(scripts\mp\utility\game::rankingenabled()) {
    var_3 = self getrankedplayerdata("mp", "attachmentsStats", var_0, var_1);
    self setrankedplayerdata("mp", "attachmentsStats", var_0, var_1, var_3 + var_2);
  }
}

func_12F5E() {
  if(!isDefined(self.trackingweapon)) {
    return;
  }
  if(self.trackingweapon == "" || self.trackingweapon == "none") {
    return;
  }
  if(scripts\mp\utility\game::iskillstreakweapon(self.trackingweapon) || scripts\mp\utility\game::isenvironmentweapon(self.trackingweapon) || scripts\mp\utility\game::isbombsiteweapon(self.trackingweapon)) {
    return;
  }
  var_0 = self.trackingweapon;
  var_1 = undefined;
  var_2 = getsubstr(var_0, 0, 4);

  if(var_2 == "alt_") {
    var_3 = scripts\mp\utility\game::getweaponattachmentsbasenames(var_0);

    foreach(var_5 in var_3) {
      if(var_5 == "shotgun" || var_5 == "gl") {
        var_1 = var_5;
        break;
      }
    }
  }

  if(!isDefined(var_1)) {
    if(var_2 == "alt_") {
      var_0 = getsubstr(var_0, 4);
      var_2 = getsubstr(var_0, 0, 4);
    }

    if(var_2 == "iw6_" || var_2 == "iw7_") {
      var_7 = strtok(var_0, "_");
      var_1 = var_7[0] + "_" + var_7[1];
    }
  }

  if(var_1 == "gl" || var_1 == "shotgun" || var_1 == "missglprox" || var_1 == "stickglprox" || var_1 == "shotgunglprox" || var_1 == "shotgunglr") {
    func_CA72(var_1);
    persclear_stats();
    return;
  }

  if(!scripts\mp\utility\game::iscacprimaryweapon(var_1) && !scripts\mp\utility\game::iscacsecondaryweapon(var_1)) {
    return;
  }
  var_8 = getweaponvariantindex(var_0);
  func_CA73(var_1, var_8);
  var_3 = getweaponattachments(var_0);

  foreach(var_5 in var_3) {
    var_10 = scripts\mp\utility\game::attachmentmap_tobase(var_5);

    if(!scripts\mp\utility\game::func_2490(var_10)) {
      continue;
    }
    switch (var_10) {
      case "gl":
      case "shotgun":
        continue;
    }

    func_CA72(var_10);
  }

  persclear_stats();
}

persclear_stats() {
  self.trackingweapon = "none";
  self.trackingweaponshots = 0;
  self.trackingweaponkills = 0;
  self.trackingweaponhits = 0;
  self.trackingweaponheadshots = 0;
  self.trackingweapondeaths = 0;
}

func_CA73(var_0, var_1) {
  if(self.trackingweaponshots > 0) {
    func_93FC(var_0, "shots", self.trackingweaponshots);
    scripts\mp\matchdata::func_AFDC(var_0, "shots", self.trackingweaponshots, var_1);
  }

  if(self.trackingweaponkills > 0) {
    func_93FC(var_0, "kills", self.trackingweaponkills);
    scripts\mp\matchdata::func_AFDC(var_0, "kills", self.trackingweaponkills, var_1);
  }

  if(self.trackingweaponhits > 0) {
    func_93FC(var_0, "hits", self.trackingweaponhits);
    scripts\mp\matchdata::func_AFDC(var_0, "hits", self.trackingweaponhits, var_1);
  }

  if(self.trackingweaponheadshots > 0) {
    func_93FC(var_0, "headShots", self.trackingweaponheadshots);
    scripts\mp\matchdata::func_AFDC(var_0, "headShots", self.trackingweaponheadshots, var_1);
  }

  if(self.trackingweapondeaths > 0) {
    func_93FC(var_0, "deaths", self.trackingweapondeaths);
    scripts\mp\matchdata::func_AFDC(var_0, "deaths", self.trackingweapondeaths, var_1);
  }
}

func_CA72(var_0) {
  if(!scripts\mp\utility\game::func_2490(var_0)) {
    return;
  }
  if(self.trackingweaponshots > 0 && var_0 != "tactical") {
    func_93F9(var_0, "shots", self.trackingweaponshots);
    scripts\mp\matchdata::func_AF94(var_0, "shots", self.trackingweaponshots);
  }

  if(self.trackingweaponkills > 0 && var_0 != "tactical") {
    func_93F9(var_0, "kills", self.trackingweaponkills);
    scripts\mp\matchdata::func_AF94(var_0, "kills", self.trackingweaponkills);
  }

  if(self.trackingweaponhits > 0 && var_0 != "tactical") {
    func_93F9(var_0, "hits", self.trackingweaponhits);
    scripts\mp\matchdata::func_AF94(var_0, "hits", self.trackingweaponhits);
  }

  if(self.trackingweaponheadshots > 0 && var_0 != "tactical") {
    func_93F9(var_0, "headShots", self.trackingweaponheadshots);
    scripts\mp\matchdata::func_AF94(var_0, "headShots", self.trackingweaponheadshots);
  }

  if(self.trackingweapondeaths > 0) {
    func_93F9(var_0, "deaths", self.trackingweapondeaths);
    scripts\mp\matchdata::func_AF94(var_0, "deaths", self.trackingweapondeaths);
  }
}

func_12F85() {
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
    var_5 = var_5 + var_7.timeplayed["total"];
  }

  incrementcounter("global_minutes", int(var_5 / 60));

  if(scripts\mp\utility\game::isroundbased() && !scripts\mp\utility\game::waslastround()) {
    return;
  }
  wait 0.05;

  foreach(var_7 in level.players) {
    var_0 = var_0 + var_7.kills;
    var_1 = var_1 + var_7.deaths;
    var_2 = var_2 + var_7.assists;
    var_3 = var_3 + var_7.headshots;
    var_4 = var_4 + var_7.suicides;
  }

  incrementcounter("global_headshots", var_3);
  incrementcounter("global_suicides", var_4);
  incrementcounter("global_games", 1);

  if(!isDefined(level.assists_disabled)) {
    incrementcounter("global_assists", var_2);
  }
}