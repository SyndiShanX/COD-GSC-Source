/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2779.gsc
***************************************/

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
  var_00 = "mp\bestscorestatsTable.csv";
  self.bestscorestats = [];
  self.bufferedbestscorestats = [];
  var_01 = 0;

  for(;;) {
    var_02 = tablelookupbyrow(var_00, var_01, 0);

    if(var_02 == "") {
      break;
    }
    self.bestscorestats[var_02] = self getrankedplayerdata("mp", "bestScores", var_02);
    var_1++;
  }
}

statget(var_00) {
  return self getrankedplayerdata("mp", var_00);
}

func_10E54(var_00, var_01) {
  if(!scripts\mp\utility\game::rankingenabled()) {
    return;
  }
  self setrankedplayerdata("mp", var_00, var_01);
}

statadd(var_00, var_01, var_02) {
  if(!scripts\mp\utility\game::rankingenabled()) {
    return;
  }
  if(isDefined(var_02)) {
    var_03 = self getrankedplayerdata("mp", var_00, var_02);
    self setrankedplayerdata("mp", var_00, var_02, var_01 + var_03);
  } else {
    var_04 = self getrankedplayerdata("mp", var_00) + var_01;
    self setrankedplayerdata("mp", var_00, var_04);
  }
}

statgetchild(var_00, var_01) {
  if(var_00 == "round") {
    return self getrankedplayerdata("common", var_00, var_01);
  } else {
    return self getrankedplayerdata("mp", var_00, var_01);
  }
}

statsetchild(var_00, var_01, var_02, var_03) {
  if(isagent(self)) {
    return;
  }
  if(isDefined(var_03) || !scripts\mp\utility\game::rankingenabled()) {
    return;
  }
  if(var_00 == "round") {
    self setrankedplayerdata("common", var_00, var_01, var_02);
    setbestscore(var_01, var_02);
  } else
    self setrankedplayerdata("mp", var_00, var_01, var_02);
}

stataddchild(var_00, var_01, var_02) {
  if(!scripts\mp\utility\game::rankingenabled()) {
    return;
  }
  var_03 = self getrankedplayerdata("mp", var_00, var_01);
  self setrankedplayerdata("mp", var_00, var_01, var_03 + var_02);
}

statgetchildbuffered(var_00, var_01, var_02) {
  if(!scripts\mp\utility\game::rankingenabled() && !scripts\mp\utility\game::istrue(var_02)) {
    return 0;
  }

  return self.bufferedchildstats[var_00][var_01];
}

statsetchildbuffered(var_00, var_01, var_02, var_03) {
  if(!scripts\mp\utility\game::rankingenabled() && !scripts\mp\utility\game::istrue(var_03)) {
    return;
  }
  self.bufferedchildstats[var_00][var_01] = var_02;
}

stataddchildbuffered(var_00, var_01, var_02, var_03) {
  if(!scripts\mp\utility\game::rankingenabled() && !scripts\mp\utility\game::istrue(var_03)) {
    return;
  }
  var_04 = statgetchildbuffered(var_00, var_01, var_03);
  statsetchildbuffered(var_00, var_01, var_04 + var_02, var_03);
}

stataddbufferedwithmax(var_00, var_01, var_02) {
  if(!scripts\mp\utility\game::rankingenabled()) {
    return;
  }
  var_03 = statgetbuffered(var_00) + var_01;

  if(var_03 > var_02) {
    var_03 = var_02;
  }

  if(var_03 < statgetbuffered(var_00)) {
    var_03 = var_02;
  }

  func_10E55(var_00, var_03);
}

stataddchildbufferedwithmax(var_00, var_01, var_02, var_03) {
  if(!scripts\mp\utility\game::rankingenabled()) {
    return;
  }
  var_04 = statgetchildbuffered(var_00, var_01) + var_02;

  if(var_04 > var_03) {
    var_04 = var_03;
  }

  if(var_04 < statgetchildbuffered(var_00, var_01)) {
    var_04 = var_03;
  }

  statsetchildbuffered(var_00, var_01, var_04);
}

statgetbuffered(var_00, var_01) {
  if(!scripts\mp\utility\game::rankingenabled() && !scripts\mp\utility\game::istrue(var_01)) {
    return 0;
  }

  return self.bufferedstats[var_00];
}

func_10E37(var_00) {
  if(!scripts\mp\utility\game::rankingenabled()) {
    return 0;
  }

  return self.squadmemberbufferedstats[var_00];
}

func_10E55(var_00, var_01, var_02) {
  if(!scripts\mp\utility\game::rankingenabled() && !scripts\mp\utility\game::istrue(var_02)) {
    return;
  }
  self.bufferedstats[var_00] = var_01;
}

func_10E58(var_00, var_01) {
  if(!scripts\mp\utility\game::rankingenabled()) {
    return;
  }
  self.squadmemberbufferedstats[var_00] = var_01;
}

stataddbuffered(var_00, var_01, var_02) {
  if(!scripts\mp\utility\game::rankingenabled() && !scripts\mp\utility\game::istrue(var_02)) {
    return;
  }
  var_03 = statgetbuffered(var_00, var_02);
  func_10E55(var_00, var_03 + var_01, var_02);
}

func_10E18(var_00, var_01) {
  if(!scripts\mp\utility\game::rankingenabled()) {
    return;
  }
  var_02 = func_10E37(var_00);
  func_10E58(var_00, var_02 + var_01);
}

func_12E6A() {
  wait 0.15;
  var_00 = 0;

  while(!level.gameended) {
    scripts\mp\hostmigration::waittillhostmigrationdone();
    var_0++;

    if(var_00 >= level.players.size) {
      var_00 = 0;
    }

    if(isDefined(level.players[var_00])) {
      level.players[var_00] writebufferedstats();
      level.players[var_00] func_12F5E();
    }

    wait 2.0;
  }

  foreach(var_02 in level.players) {
    var_02 writebufferedstats();
    var_02 func_12F5E();
  }
}

setbestscore(var_00, var_01) {
  var_02 = scripts\mp\utility\game::rankingenabled();

  if(!var_02) {
    return;
  }
  if(isDefined(self.bestscorestats[var_00]) && var_01 > self.bestscorestats[var_00]) {
    self.bestscorestats[var_00] = var_01;
    self.bufferedbestscorestats[var_00] = var_01;
  }
}

writebestscores() {
  foreach(var_01 in level.players) {
    if(isDefined(var_01) && var_01 scripts\mp\utility\game::rankingenabled()) {
      foreach(var_04, var_03 in var_1.bufferedbestscorestats) {
        var_01 setrankedplayerdata("mp", "bestScores", var_04, var_03);
      }
    }
  }
}

writebufferedstats() {
  var_00 = scripts\mp\utility\game::rankingenabled();

  if(var_00) {
    foreach(var_03, var_02 in self.bufferedstats) {
      self setrankedplayerdata("mp", var_03, var_02);
    }

    if(!isai(self)) {
      foreach(var_03, var_02 in self.squadmemberbufferedstats) {
        self setrankedplayerdata("rankedloadouts", "squadMembers", var_03, var_02);
      }
    }
  }

  foreach(var_03, var_02 in self.bufferedchildstats) {
    foreach(var_08, var_07 in var_02) {
      if(var_03 == "round") {
        self setrankedplayerdata("common", var_03, var_08, var_07);
        setbestscore(var_08, var_07);
        continue;
      }

      if(var_00) {
        self setrankedplayerdata("mp", var_03, var_08, var_07);
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
    foreach(var_01 in level.players) {
      var_01 func_93FB(var_1.kills, var_1.deaths);
    }
  }
}

func_93FB(var_00, var_01) {
  if(!scripts\mp\utility\game::rankingenabled()) {
    return;
  }
  for(var_02 = 0; var_02 < 4; var_2++) {
    var_03 = self getrankedplayerdata("mp", "kdHistoryK", var_02 + 1);
    self setrankedplayerdata("mp", "kdHistoryK", var_02, var_03);
    var_03 = self getrankedplayerdata("mp", "kdHistoryD", var_02 + 1);
    self setrankedplayerdata("mp", "kdHistoryD", var_02, var_03);
  }

  self setrankedplayerdata("mp", "kdHistoryK", 4, int(clamp(var_00, 0, 255)));
  self setrankedplayerdata("mp", "kdHistoryD", 4, int(clamp(var_01, 0, 255)));
}

func_93FC(var_00, var_01, var_02) {
  if(scripts\mp\utility\game::iskillstreakweapon(var_00)) {
    return;
  }
  if(isDefined(level.func_561D)) {
    return;
  }
  if(scripts\mp\utility\game::rankingenabled()) {
    var_03 = self getrankedplayerdata("mp", "weaponStats", var_00, var_01);
    self setrankedplayerdata("mp", "weaponStats", var_00, var_01, var_03 + var_02);
  }
}

func_93F9(var_00, var_01, var_02) {
  if(isDefined(level.func_561D)) {
    return;
  }
  if(!scripts\mp\utility\game::func_2490(var_00)) {
    return;
  }
  if(scripts\mp\utility\game::rankingenabled()) {
    var_03 = self getrankedplayerdata("mp", "attachmentsStats", var_00, var_01);
    self setrankedplayerdata("mp", "attachmentsStats", var_00, var_01, var_03 + var_02);
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
  var_00 = self.trackingweapon;
  var_01 = undefined;
  var_02 = getsubstr(var_00, 0, 4);

  if(var_02 == "alt_") {
    var_03 = scripts\mp\utility\game::getweaponattachmentsbasenames(var_00);

    foreach(var_05 in var_03) {
      if(var_05 == "shotgun" || var_05 == "gl") {
        var_01 = var_05;
        break;
      }
    }
  }

  if(!isDefined(var_01)) {
    if(var_02 == "alt_") {
      var_00 = getsubstr(var_00, 4);
      var_02 = getsubstr(var_00, 0, 4);
    }

    if(var_02 == "iw6_" || var_02 == "iw7_") {
      var_07 = strtok(var_00, "_");
      var_01 = var_7[0] + "_" + var_7[1];
    }
  }

  if(var_01 == "gl" || var_01 == "shotgun" || var_01 == "missglprox" || var_01 == "stickglprox" || var_01 == "shotgunglprox" || var_01 == "shotgunglr") {
    func_CA72(var_01);
    persclear_stats();
    return;
  }

  if(!scripts\mp\utility\game::iscacprimaryweapon(var_01) && !scripts\mp\utility\game::iscacsecondaryweapon(var_01)) {
    return;
  }
  var_08 = getweaponvariantindex(var_00);
  func_CA73(var_01, var_08);
  var_03 = getweaponattachments(var_00);

  foreach(var_05 in var_03) {
    var_10 = scripts\mp\utility\game::attachmentmap_tobase(var_05);

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

func_CA73(var_00, var_01) {
  if(self.trackingweaponshots > 0) {
    func_93FC(var_00, "shots", self.trackingweaponshots);
    scripts\mp\matchdata::func_AFDC(var_00, "shots", self.trackingweaponshots, var_01);
  }

  if(self.trackingweaponkills > 0) {
    func_93FC(var_00, "kills", self.trackingweaponkills);
    scripts\mp\matchdata::func_AFDC(var_00, "kills", self.trackingweaponkills, var_01);
  }

  if(self.trackingweaponhits > 0) {
    func_93FC(var_00, "hits", self.trackingweaponhits);
    scripts\mp\matchdata::func_AFDC(var_00, "hits", self.trackingweaponhits, var_01);
  }

  if(self.trackingweaponheadshots > 0) {
    func_93FC(var_00, "headShots", self.trackingweaponheadshots);
    scripts\mp\matchdata::func_AFDC(var_00, "headShots", self.trackingweaponheadshots, var_01);
  }

  if(self.trackingweapondeaths > 0) {
    func_93FC(var_00, "deaths", self.trackingweapondeaths);
    scripts\mp\matchdata::func_AFDC(var_00, "deaths", self.trackingweapondeaths, var_01);
  }
}

func_CA72(var_00) {
  if(!scripts\mp\utility\game::func_2490(var_00)) {
    return;
  }
  if(self.trackingweaponshots > 0 && var_00 != "tactical") {
    func_93F9(var_00, "shots", self.trackingweaponshots);
    scripts\mp\matchdata::func_AF94(var_00, "shots", self.trackingweaponshots);
  }

  if(self.trackingweaponkills > 0 && var_00 != "tactical") {
    func_93F9(var_00, "kills", self.trackingweaponkills);
    scripts\mp\matchdata::func_AF94(var_00, "kills", self.trackingweaponkills);
  }

  if(self.trackingweaponhits > 0 && var_00 != "tactical") {
    func_93F9(var_00, "hits", self.trackingweaponhits);
    scripts\mp\matchdata::func_AF94(var_00, "hits", self.trackingweaponhits);
  }

  if(self.trackingweaponheadshots > 0 && var_00 != "tactical") {
    func_93F9(var_00, "headShots", self.trackingweaponheadshots);
    scripts\mp\matchdata::func_AF94(var_00, "headShots", self.trackingweaponheadshots);
  }

  if(self.trackingweapondeaths > 0) {
    func_93F9(var_00, "deaths", self.trackingweapondeaths);
    scripts\mp\matchdata::func_AF94(var_00, "deaths", self.trackingweapondeaths);
  }
}

func_12F85() {
  level waittill("game_ended");

  if(!scripts\mp\utility\game::matchmakinggame()) {
    return;
  }
  var_00 = 0;
  var_01 = 0;
  var_02 = 0;
  var_03 = 0;
  var_04 = 0;
  var_05 = 0;

  foreach(var_07 in level.players) {
    var_05 = var_05 + var_7.timeplayed["total"];
  }

  incrementcounter("global_minutes", int(var_05 / 60));

  if(scripts\mp\utility\game::isroundbased() && !scripts\mp\utility\game::waslastround()) {
    return;
  }
  wait 0.05;

  foreach(var_07 in level.players) {
    var_00 = var_00 + var_7.kills;
    var_01 = var_01 + var_7.deaths;
    var_02 = var_02 + var_7.assists;
    var_03 = var_03 + var_7.headshots;
    var_04 = var_04 + var_7.suicides;
  }

  incrementcounter("global_headshots", var_03);
  incrementcounter("global_suicides", var_04);
  incrementcounter("global_games", 1);

  if(!isDefined(level.assists_disabled)) {
    incrementcounter("global_assists", var_02);
  }
}