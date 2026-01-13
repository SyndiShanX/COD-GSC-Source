/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\persistence.gsc
*********************************************/

init() {
  level.persistentdatainfo = [];
  level thread func_12E6A();
  level thread func_12F85();
  level thread func_13E05();
}

initbufferedstats() {
  self.bufferedstats = [];
  self.squadmemberbufferedstats = [];
  if(scripts\mp\utility::rankingenabled()) {
    self.bufferedstats["totalShots"] = self getplayerdata("mp", "totalShots");
    self.bufferedstats["accuracy"] = self getplayerdata("mp", "accuracy");
    self.bufferedstats["misses"] = self getplayerdata("mp", "misses");
    self.bufferedstats["hits"] = self getplayerdata("mp", "hits");
  }

  self.bufferedstats["timePlayedAllies"] = self getplayerdata("mp", "timePlayedAllies");
  self.bufferedstats["timePlayedOpfor"] = self getplayerdata("mp", "timePlayedOpfor");
  self.bufferedstats["timePlayedOther"] = self getplayerdata("mp", "timePlayedOther");
  self.bufferedstats["timePlayedTotal"] = self getplayerdata("mp", "timePlayedTotal");
  self.bufferedchildstats = [];
  self.bufferedchildstats["round"] = [];
  self.bufferedchildstats["round"]["timePlayed"] = self getplayerdata("common", "round", "timePlayed");
  if(scripts\mp\utility::rankingenabled()) {
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

    self.bestscorestats[var_2] = self getplayerdata("mp", "bestScores", var_2);
    var_1++;
  }
}

statget(var_0) {
  return self getplayerdata("mp", var_0);
}

func_10E54(var_0, var_1) {
  if(!scripts\mp\utility::rankingenabled()) {
    return;
  }

  self setplayerdata("mp", var_0, var_1);
}

statadd(var_0, var_1, var_2) {
  if(!scripts\mp\utility::rankingenabled()) {
    return;
  }

  if(isDefined(var_2)) {
    var_3 = self getplayerdata("mp", var_0, var_2);
    self setplayerdata("mp", var_0, var_2, var_1 + var_3);
    return;
  }

  var_4 = self getplayerdata("mp", var_0) + var_1;
  self setplayerdata("mp", var_0, var_4);
}

statgetchild(var_0, var_1) {
  if(var_0 == "round") {
    return self getplayerdata("common", var_0, var_1);
  }

  return self getplayerdata("mp", var_0, var_1);
}

statsetchild(var_0, var_1, var_2, var_3) {
  if(isagent(self)) {
    return;
  }

  if(isDefined(var_3) || !scripts\mp\utility::rankingenabled()) {
    return;
  }

  if(var_0 == "round") {
    self setplayerdata("common", var_0, var_1, var_2);
    setbestscore(var_1, var_2);
    return;
  }

  self setplayerdata("mp", var_0, var_1, var_2);
}

stataddchild(var_0, var_1, var_2) {
  if(!scripts\mp\utility::rankingenabled()) {
    return;
  }

  var_3 = self getplayerdata("mp", var_0, var_1);
  self setplayerdata("mp", var_0, var_1, var_3 + var_2);
}

statgetchildbuffered(var_0, var_1, var_2) {
  if(!scripts\mp\utility::rankingenabled() && !scripts\mp\utility::istrue(var_2)) {
    return 0;
  }

  return self.bufferedchildstats[var_0][var_1];
}

statsetchildbuffered(var_0, var_1, var_2, var_3) {
  if(!scripts\mp\utility::rankingenabled() && !scripts\mp\utility::istrue(var_3)) {
    return;
  }

  self.bufferedchildstats[var_0][var_1] = var_2;
}

stataddchildbuffered(var_0, var_1, var_2, var_3) {
  if(!scripts\mp\utility::rankingenabled() && !scripts\mp\utility::istrue(var_3)) {
    return;
  }

  var_4 = statgetchildbuffered(var_0, var_1, var_3);
  statsetchildbuffered(var_0, var_1, var_4 + var_2, var_3);
}

stataddbufferedwithmax(var_0, var_1, var_2) {
  if(!scripts\mp\utility::rankingenabled()) {
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
  if(!scripts\mp\utility::rankingenabled()) {
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
  if(!scripts\mp\utility::rankingenabled() && !scripts\mp\utility::istrue(var_1)) {
    return 0;
  }

  return self.bufferedstats[var_0];
}

func_10E37(var_0) {
  if(!scripts\mp\utility::rankingenabled()) {
    return 0;
  }

  return self.squadmemberbufferedstats[var_0];
}

func_10E55(var_0, var_1, var_2) {
  if(!scripts\mp\utility::rankingenabled() && !scripts\mp\utility::istrue(var_2)) {
    return;
  }

  self.bufferedstats[var_0] = var_1;
}

func_10E58(var_0, var_1) {
  if(!scripts\mp\utility::rankingenabled()) {
    return;
  }

  self.squadmemberbufferedstats[var_0] = var_1;
}

stataddbuffered(var_0, var_1, var_2) {
  if(!scripts\mp\utility::rankingenabled() && !scripts\mp\utility::istrue(var_2)) {
    return;
  }

  var_3 = statgetbuffered(var_0, var_2);
  func_10E55(var_0, var_3 + var_1, var_2);
}

func_10E18(var_0, var_1) {
  if(!scripts\mp\utility::rankingenabled()) {
    return;
  }

  var_2 = func_10E37(var_0);
  func_10E58(var_0, var_2 + var_1);
}

func_12E6A() {
  wait(0.15);
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

    wait(2);
  }

  foreach(var_2 in level.players) {
    var_2 writebufferedstats();
    var_2 func_12F5E();
  }
}

setbestscore(var_0, var_1) {
  var_2 = scripts\mp\utility::rankingenabled();
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
    if(isDefined(var_1) && var_1 scripts\mp\utility::rankingenabled()) {
      foreach(var_4, var_3 in var_1.bufferedbestscorestats) {
        var_1 setplayerdata("mp", "bestScores", var_4, var_3);
      }
    }
  }
}

writebufferedstats() {
  var_0 = scripts\mp\utility::rankingenabled();
  if(var_0) {
    foreach(var_3, var_2 in self.bufferedstats) {
      self setplayerdata("mp", var_3, var_2);
    }

    if(!isai(self)) {
      foreach(var_3, var_2 in self.squadmemberbufferedstats) {
        self setplayerdata("rankedloadouts", "squadMembers", var_3, var_2);
      }
    }
  }

  foreach(var_3, var_2 in self.bufferedchildstats) {
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

func_13E05() {
  if(!scripts\mp\utility::matchmakinggame()) {
    return;
  }

  level waittill("game_ended");
  wait(0.1);
  if(scripts\mp\utility::waslastround() || !scripts\mp\utility::isroundbased() && scripts\mp\utility::hittimelimit()) {
    foreach(var_1 in level.players) {
      var_1 func_93FB(var_1.setculldist, var_1.var_E9);
    }
  }
}

func_93FB(var_0, var_1) {
  if(!scripts\mp\utility::rankingenabled()) {
    return;
  }

  for(var_2 = 0; var_2 < 4; var_2++) {
    var_3 = self getplayerdata("mp", "kdHistoryK", var_2 + 1);
    self setplayerdata("mp", "kdHistoryK", var_2, var_3);
    var_3 = self getplayerdata("mp", "kdHistoryD", var_2 + 1);
    self setplayerdata("mp", "kdHistoryD", var_2, var_3);
  }

  self setplayerdata("mp", "kdHistoryK", 4, int(clamp(var_0, 0, 255)));
  self setplayerdata("mp", "kdHistoryD", 4, int(clamp(var_1, 0, 255)));
}

func_93FC(var_0, var_1, var_2) {
  if(scripts\mp\utility::iskillstreakweapon(var_0)) {
    return;
  }

  if(isDefined(level.var_561D)) {
    return;
  }

  if(scripts\mp\utility::rankingenabled()) {
    var_3 = self getplayerdata("mp", "weaponStats", var_0, var_1);
    self setplayerdata("mp", "weaponStats", var_0, var_1, var_3 + var_2);
  }
}

func_93F9(var_0, var_1, var_2) {
  if(isDefined(level.var_561D)) {
    return;
  }

  if(!scripts\mp\utility::func_2490(var_0)) {
    return;
  }

  if(scripts\mp\utility::rankingenabled()) {
    var_3 = self getplayerdata("mp", "attachmentsStats", var_0, var_1);
    self setplayerdata("mp", "attachmentsStats", var_0, var_1, var_3 + var_2);
  }
}

func_12F5E() {
  if(!isDefined(self.trackingweapon)) {
    return;
  }

  if(self.trackingweapon == "" || self.trackingweapon == "none") {
    return;
  }

  if(scripts\mp\utility::iskillstreakweapon(self.trackingweapon) || scripts\mp\utility::isenvironmentweapon(self.trackingweapon) || scripts\mp\utility::isbombsiteweapon(self.trackingweapon)) {
    return;
  }

  var_0 = self.trackingweapon;
  var_1 = undefined;
  var_2 = getsubstr(var_0, 0, 4);
  if(var_2 == "alt_") {
    var_3 = scripts\mp\utility::getweaponattachmentsbasenames(var_0);
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

  if(!scripts\mp\utility::iscacprimaryweapon(var_1) && !scripts\mp\utility::iscacsecondaryweapon(var_1)) {
    return;
  }

  var_8 = getweaponvariantindex(var_0);
  func_CA73(var_1, var_8);
  var_3 = getweaponattachments(var_0);
  foreach(var_5 in var_3) {
    var_0A = scripts\mp\utility::attachmentmap_tobase(var_5);
    if(!scripts\mp\utility::func_2490(var_0A)) {
      continue;
    }

    switch (var_0A) {
      case "gl":
      case "shotgun":
        break;
    }

    func_CA72(var_0A);
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
  if(!scripts\mp\utility::func_2490(var_0)) {
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
  if(!scripts\mp\utility::matchmakinggame()) {
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
  if(scripts\mp\utility::isroundbased() && !scripts\mp\utility::waslastround()) {
    return;
  }

  wait(0.05);
  foreach(var_7 in level.players) {
    var_0 = var_0 + var_7.setculldist;
    var_1 = var_1 + var_7.var_E9;
    var_2 = var_2 + var_7.var_4D;
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