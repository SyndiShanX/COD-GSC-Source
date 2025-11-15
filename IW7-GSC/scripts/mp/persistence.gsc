/**************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\persistence.gsc
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
  var_00 = "mp\bestscorestatsTable.csv";
  self.bestscorestats = [];
  self.bufferedbestscorestats = [];
  var_01 = 0;
  for(;;) {
    var_02 = tablelookupbyrow(var_00, var_01, 0);
    if(var_02 == "") {
      break;
    }

    self.bestscorestats[var_02] = self getplayerdata("mp", "bestScores", var_02);
    var_01++;
  }
}

statget(param_00) {
  return self getplayerdata("mp", param_00);
}

func_10E54(param_00, param_01) {
  if(!scripts\mp\utility::rankingenabled()) {
    return;
  }

  self setplayerdata("mp", param_00, param_01);
}

statadd(param_00, param_01, param_02) {
  if(!scripts\mp\utility::rankingenabled()) {
    return;
  }

  if(isDefined(param_02)) {
    var_03 = self getplayerdata("mp", param_00, param_02);
    self setplayerdata("mp", param_00, param_02, param_01 + var_03);
    return;
  }

  var_04 = self getplayerdata("mp", param_00) + param_01;
  self setplayerdata("mp", param_00, var_04);
}

statgetchild(param_00, param_01) {
  if(param_00 == "round") {
    return self getplayerdata("common", param_00, param_01);
  }

  return self getplayerdata("mp", param_00, param_01);
}

statsetchild(param_00, param_01, param_02, param_03) {
  if(isagent(self)) {
    return;
  }

  if(isDefined(param_03) || !scripts\mp\utility::rankingenabled()) {
    return;
  }

  if(param_00 == "round") {
    self setplayerdata("common", param_00, param_01, param_02);
    setbestscore(param_01, param_02);
    return;
  }

  self setplayerdata("mp", param_00, param_01, param_02);
}

stataddchild(param_00, param_01, param_02) {
  if(!scripts\mp\utility::rankingenabled()) {
    return;
  }

  var_03 = self getplayerdata("mp", param_00, param_01);
  self setplayerdata("mp", param_00, param_01, var_03 + param_02);
}

statgetchildbuffered(param_00, param_01, param_02) {
  if(!scripts\mp\utility::rankingenabled() && !scripts\mp\utility::istrue(param_02)) {
    return 0;
  }

  return self.bufferedchildstats[param_00][param_01];
}

statsetchildbuffered(param_00, param_01, param_02, param_03) {
  if(!scripts\mp\utility::rankingenabled() && !scripts\mp\utility::istrue(param_03)) {
    return;
  }

  self.bufferedchildstats[param_00][param_01] = param_02;
}

stataddchildbuffered(param_00, param_01, param_02, param_03) {
  if(!scripts\mp\utility::rankingenabled() && !scripts\mp\utility::istrue(param_03)) {
    return;
  }

  var_04 = statgetchildbuffered(param_00, param_01, param_03);
  statsetchildbuffered(param_00, param_01, var_04 + param_02, param_03);
}

stataddbufferedwithmax(param_00, param_01, param_02) {
  if(!scripts\mp\utility::rankingenabled()) {
    return;
  }

  var_03 = statgetbuffered(param_00) + param_01;
  if(var_03 > param_02) {
    var_03 = param_02;
  }

  if(var_03 < statgetbuffered(param_00)) {
    var_03 = param_02;
  }

  func_10E55(param_00, var_03);
}

stataddchildbufferedwithmax(param_00, param_01, param_02, param_03) {
  if(!scripts\mp\utility::rankingenabled()) {
    return;
  }

  var_04 = statgetchildbuffered(param_00, param_01) + param_02;
  if(var_04 > param_03) {
    var_04 = param_03;
  }

  if(var_04 < statgetchildbuffered(param_00, param_01)) {
    var_04 = param_03;
  }

  statsetchildbuffered(param_00, param_01, var_04);
}

statgetbuffered(param_00, param_01) {
  if(!scripts\mp\utility::rankingenabled() && !scripts\mp\utility::istrue(param_01)) {
    return 0;
  }

  return self.bufferedstats[param_00];
}

func_10E37(param_00) {
  if(!scripts\mp\utility::rankingenabled()) {
    return 0;
  }

  return self.squadmemberbufferedstats[param_00];
}

func_10E55(param_00, param_01, param_02) {
  if(!scripts\mp\utility::rankingenabled() && !scripts\mp\utility::istrue(param_02)) {
    return;
  }

  self.bufferedstats[param_00] = param_01;
}

func_10E58(param_00, param_01) {
  if(!scripts\mp\utility::rankingenabled()) {
    return;
  }

  self.squadmemberbufferedstats[param_00] = param_01;
}

stataddbuffered(param_00, param_01, param_02) {
  if(!scripts\mp\utility::rankingenabled() && !scripts\mp\utility::istrue(param_02)) {
    return;
  }

  var_03 = statgetbuffered(param_00, param_02);
  func_10E55(param_00, var_03 + param_01, param_02);
}

func_10E18(param_00, param_01) {
  if(!scripts\mp\utility::rankingenabled()) {
    return;
  }

  var_02 = func_10E37(param_00);
  func_10E58(param_00, var_02 + param_01);
}

func_12E6A() {
  wait(0.15);
  var_00 = 0;
  while(!level.gameended) {
    scripts\mp\hostmigration::waittillhostmigrationdone();
    var_00++;
    if(var_00 >= level.players.size) {
      var_00 = 0;
    }

    if(isDefined(level.players[var_00])) {
      level.players[var_00] writebufferedstats();
      level.players[var_00] func_12F5E();
    }

    wait(2);
  }

  foreach(var_02 in level.players) {
    var_02 writebufferedstats();
    var_02 func_12F5E();
  }
}

setbestscore(param_00, param_01) {
  var_02 = scripts\mp\utility::rankingenabled();
  if(!var_02) {
    return;
  }

  if(isDefined(self.bestscorestats[param_00]) && param_01 > self.bestscorestats[param_00]) {
    self.bestscorestats[param_00] = param_01;
    self.bufferedbestscorestats[param_00] = param_01;
  }
}

writebestscores() {
  foreach(var_01 in level.players) {
    if(isDefined(var_01) && var_01 scripts\mp\utility::rankingenabled()) {
      foreach(var_04, var_03 in var_01.bufferedbestscorestats) {
        var_01 setplayerdata("mp", "bestScores", var_04, var_03);
      }
    }
  }
}

writebufferedstats() {
  var_00 = scripts\mp\utility::rankingenabled();
  if(var_00) {
    foreach(var_03, var_02 in self.bufferedstats) {
      self setplayerdata("mp", var_03, var_02);
    }

    if(!isai(self)) {
      foreach(var_03, var_02 in self.squadmemberbufferedstats) {
        self setplayerdata("rankedloadouts", "squadMembers", var_03, var_02);
      }
    }
  }

  foreach(var_03, var_02 in self.bufferedchildstats) {
    foreach(var_08, var_07 in var_02) {
      if(var_03 == "round") {
        self setplayerdata("common", var_03, var_08, var_07);
        setbestscore(var_08, var_07);
        continue;
      }

      if(var_00) {
        self setplayerdata("mp", var_03, var_08, var_07);
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
    foreach(var_01 in level.players) {
      var_01 func_93FB(var_01.setculldist, var_01.var_E9);
    }
  }
}

func_93FB(param_00, param_01) {
  if(!scripts\mp\utility::rankingenabled()) {
    return;
  }

  for(var_02 = 0; var_02 < 4; var_02++) {
    var_03 = self getplayerdata("mp", "kdHistoryK", var_02 + 1);
    self setplayerdata("mp", "kdHistoryK", var_02, var_03);
    var_03 = self getplayerdata("mp", "kdHistoryD", var_02 + 1);
    self setplayerdata("mp", "kdHistoryD", var_02, var_03);
  }

  self setplayerdata("mp", "kdHistoryK", 4, int(clamp(param_00, 0, 255)));
  self setplayerdata("mp", "kdHistoryD", 4, int(clamp(param_01, 0, 255)));
}

func_93FC(param_00, param_01, param_02) {
  if(scripts\mp\utility::iskillstreakweapon(param_00)) {
    return;
  }

  if(isDefined(level.var_561D)) {
    return;
  }

  if(scripts\mp\utility::rankingenabled()) {
    var_03 = self getplayerdata("mp", "weaponStats", param_00, param_01);
    self setplayerdata("mp", "weaponStats", param_00, param_01, var_03 + param_02);
  }
}

func_93F9(param_00, param_01, param_02) {
  if(isDefined(level.var_561D)) {
    return;
  }

  if(!scripts\mp\utility::func_2490(param_00)) {
    return;
  }

  if(scripts\mp\utility::rankingenabled()) {
    var_03 = self getplayerdata("mp", "attachmentsStats", param_00, param_01);
    self setplayerdata("mp", "attachmentsStats", param_00, param_01, var_03 + param_02);
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

  var_00 = self.trackingweapon;
  var_01 = undefined;
  var_02 = getsubstr(var_00, 0, 4);
  if(var_02 == "alt_") {
    var_03 = scripts\mp\utility::getweaponattachmentsbasenames(var_00);
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
      var_01 = var_07[0] + "_" + var_07[1];
    }
  }

  if(var_01 == "gl" || var_01 == "shotgun" || var_01 == "missglprox" || var_01 == "stickglprox" || var_01 == "shotgunglprox" || var_01 == "shotgunglr") {
    func_CA72(var_01);
    persclear_stats();
    return;
  }

  if(!scripts\mp\utility::iscacprimaryweapon(var_01) && !scripts\mp\utility::iscacsecondaryweapon(var_01)) {
    return;
  }

  var_08 = getweaponvariantindex(var_00);
  func_CA73(var_01, var_08);
  var_03 = getweaponattachments(var_00);
  foreach(var_05 in var_03) {
    var_0A = scripts\mp\utility::attachmentmap_tobase(var_05);
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

func_CA73(param_00, param_01) {
  if(self.trackingweaponshots > 0) {
    func_93FC(param_00, "shots", self.trackingweaponshots);
    scripts\mp\matchdata::func_AFDC(param_00, "shots", self.trackingweaponshots, param_01);
  }

  if(self.trackingweaponkills > 0) {
    func_93FC(param_00, "kills", self.trackingweaponkills);
    scripts\mp\matchdata::func_AFDC(param_00, "kills", self.trackingweaponkills, param_01);
  }

  if(self.trackingweaponhits > 0) {
    func_93FC(param_00, "hits", self.trackingweaponhits);
    scripts\mp\matchdata::func_AFDC(param_00, "hits", self.trackingweaponhits, param_01);
  }

  if(self.trackingweaponheadshots > 0) {
    func_93FC(param_00, "headShots", self.trackingweaponheadshots);
    scripts\mp\matchdata::func_AFDC(param_00, "headShots", self.trackingweaponheadshots, param_01);
  }

  if(self.trackingweapondeaths > 0) {
    func_93FC(param_00, "deaths", self.trackingweapondeaths);
    scripts\mp\matchdata::func_AFDC(param_00, "deaths", self.trackingweapondeaths, param_01);
  }
}

func_CA72(param_00) {
  if(!scripts\mp\utility::func_2490(param_00)) {
    return;
  }

  if(self.trackingweaponshots > 0 && param_00 != "tactical") {
    func_93F9(param_00, "shots", self.trackingweaponshots);
    scripts\mp\matchdata::func_AF94(param_00, "shots", self.trackingweaponshots);
  }

  if(self.trackingweaponkills > 0 && param_00 != "tactical") {
    func_93F9(param_00, "kills", self.trackingweaponkills);
    scripts\mp\matchdata::func_AF94(param_00, "kills", self.trackingweaponkills);
  }

  if(self.trackingweaponhits > 0 && param_00 != "tactical") {
    func_93F9(param_00, "hits", self.trackingweaponhits);
    scripts\mp\matchdata::func_AF94(param_00, "hits", self.trackingweaponhits);
  }

  if(self.trackingweaponheadshots > 0 && param_00 != "tactical") {
    func_93F9(param_00, "headShots", self.trackingweaponheadshots);
    scripts\mp\matchdata::func_AF94(param_00, "headShots", self.trackingweaponheadshots);
  }

  if(self.trackingweapondeaths > 0) {
    func_93F9(param_00, "deaths", self.trackingweapondeaths);
    scripts\mp\matchdata::func_AF94(param_00, "deaths", self.trackingweapondeaths);
  }
}

func_12F85() {
  level waittill("game_ended");
  if(!scripts\mp\utility::matchmakinggame()) {
    return;
  }

  var_00 = 0;
  var_01 = 0;
  var_02 = 0;
  var_03 = 0;
  var_04 = 0;
  var_05 = 0;
  foreach(var_07 in level.players) {
    var_05 = var_05 + var_07.timeplayed["total"];
  }

  incrementcounter("global_minutes", int(var_05 / 60));
  if(scripts\mp\utility::isroundbased() && !scripts\mp\utility::waslastround()) {
    return;
  }

  wait(0.05);
  foreach(var_07 in level.players) {
    var_00 = var_00 + var_07.setculldist;
    var_01 = var_01 + var_07.var_E9;
    var_02 = var_02 + var_07.var_4D;
    var_03 = var_03 + var_07.headshots;
    var_04 = var_04 + var_07.suicides;
  }

  incrementcounter("global_headshots", var_03);
  incrementcounter("global_suicides", var_04);
  incrementcounter("global_games", 1);
  if(!isDefined(level.assists_disabled)) {
    incrementcounter("global_assists", var_02);
  }
}