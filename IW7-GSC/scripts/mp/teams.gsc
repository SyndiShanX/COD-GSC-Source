/********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\teams.gsc
********************************/

init() {
  level.teambalance = getdvarint("scr_teambalance");
  level.maxclients = getmaxclients();
  func_F7F6();
  level.var_7371 = [];
  if(level.teambased) {
    level thread onplayerconnect();
    level thread func_12F37();
    wait(0.15);
    level thread func_12EF3();
    level thread finalizeplayertimes();
  } else {
    level thread func_C532();
    wait(0.15);
    level thread func_12E95();
  }

  if(scripts\mp\utility::matchmakinggame()) {
    level thread watchafk();
  }
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread func_C541();
    var_00 thread func_C540();
    var_00 thread onplayerspawned();
    var_00 thread func_11B01();
  }
}

func_C532() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread func_11B01();
  }
}

func_C541() {
  self endon("disconnect");
  for(;;) {
    self waittill("joined_team");
    updateteamtime();
  }
}

func_C540() {
  self endon("disconnect");
  for(;;) {
    self waittill("joined_spectators");
    self.pers["teamTime"] = undefined;
  }
}

func_11B01() {
  self endon("disconnect");
  self.timeplayed["allies"] = 0;
  self.timeplayed["axis"] = 0;
  self.timeplayed["free"] = 0;
  self.timeplayed["other"] = 0;
  self.timeplayed["total"] = 0;
  self.timeplayed["missionTeam"] = 0;
  if(!isDefined(self.pers["validKickTime"])) {
    self.pers["validKickTime"] = 0;
  }

  scripts\mp\utility::gameflagwait("prematch_done");
  while(!level.gameended) {
    wait(1);
    if(self.sessionteam == "allies") {
      self.timeplayed["allies"]++;
      self.timeplayed["total"]++;
      self.timeplayed["missionTeam"]++;
      if(scripts\mp\utility::isreallyalive(self)) {
        self.pers["validKickTime"]++;
      }

      continue;
    }

    if(self.sessionteam == "axis") {
      self.timeplayed["axis"]++;
      self.timeplayed["total"]++;
      self.timeplayed["missionTeam"]++;
      if(scripts\mp\utility::isreallyalive(self)) {
        self.pers["validKickTime"]++;
      }

      continue;
    }

    if(self.sessionteam == "none") {
      if(isDefined(self.pers["team"]) && self.pers["team"] == "allies") {
        self.timeplayed["allies"]++;
      } else if(isDefined(self.pers["team"]) && self.pers["team"] == "axis") {
        self.timeplayed["axis"]++;
      }

      self.timeplayed["total"]++;
      self.timeplayed["missionTeam"]++;
      if(scripts\mp\utility::isreallyalive(self)) {
        self.pers["validKickTime"]++;
      }

      continue;
    }

    if(self.sessionteam == "spectator") {
      self.timeplayed["other"]++;
    }
  }
}

func_12EF3() {
  level endon("game_ended");
  for(;;) {
    scripts\mp\hostmigration::waittillhostmigrationdone();
    foreach(var_01 in level.players) {
      var_01 func_12EEE();
    }

    wait(10);
  }
}

finalizeplayertimes() {
  while(!level.gameended) {
    wait(2);
  }

  foreach(var_01 in level.players) {
    var_01 func_12EEE();
    var_01 scripts\mp\persistence::writebufferedstats();
    var_01 scripts\mp\persistence::func_12F5E();
  }
}

func_12EEE() {
  if(isai(self)) {
    return;
  }

  if(!scripts\mp\utility::rankingenabled()) {
    if(self.timeplayed["allies"]) {
      scripts\mp\persistence::stataddbuffered("timePlayedAllies", self.timeplayed["allies"], 1);
      scripts\mp\persistence::stataddbuffered("timePlayedTotal", self.timeplayed["allies"], 1);
      scripts\mp\persistence::stataddchildbuffered("round", "timePlayed", self.timeplayed["allies"], 1);
    }

    if(self.timeplayed["axis"]) {
      scripts\mp\persistence::stataddbuffered("timePlayedOpfor", self.timeplayed["axis"], 1);
      scripts\mp\persistence::stataddbuffered("timePlayedTotal", self.timeplayed["axis"], 1);
      scripts\mp\persistence::stataddchildbuffered("round", "timePlayed", self.timeplayed["axis"], 1);
    }

    if(self.timeplayed["other"]) {
      scripts\mp\persistence::stataddbuffered("timePlayedOther", self.timeplayed["other"], 1);
      scripts\mp\persistence::stataddbuffered("timePlayedTotal", self.timeplayed["other"], 1);
      scripts\mp\persistence::stataddchildbuffered("round", "timePlayed", self.timeplayed["other"], 1);
    }
  } else {
    if(self.timeplayed["allies"]) {
      scripts\mp\persistence::stataddbuffered("timePlayedAllies", self.timeplayed["allies"]);
      scripts\mp\persistence::stataddbuffered("timePlayedTotal", self.timeplayed["allies"]);
      scripts\mp\persistence::stataddchildbuffered("round", "timePlayed", self.timeplayed["allies"]);
      scripts\mp\persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed", 0, self.timeplayed["allies"], self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0]);
      scripts\mp\persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed", 1, self.timeplayed["allies"], self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1]);
      scripts\mp\persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed", 2, self.timeplayed["allies"], self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2]);
      scripts\mp\persistence::stataddchildbufferedwithmax("challengeXPMultiplierTimePlayed", 0, self.timeplayed["allies"], self.bufferedchildstatsmax["challengeXPMaxMultiplierTimePlayed"][0]);
      scripts\mp\persistence::stataddchildbufferedwithmax("weaponXPMultiplierTimePlayed", 0, self.timeplayed["allies"], self.bufferedchildstatsmax["weaponXPMaxMultiplierTimePlayed"][0]);
    }

    if(self.timeplayed["axis"]) {
      scripts\mp\persistence::stataddbuffered("timePlayedOpfor", self.timeplayed["axis"]);
      scripts\mp\persistence::stataddbuffered("timePlayedTotal", self.timeplayed["axis"]);
      scripts\mp\persistence::stataddchildbuffered("round", "timePlayed", self.timeplayed["axis"]);
      scripts\mp\persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed", 0, self.timeplayed["axis"], self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0]);
      scripts\mp\persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed", 1, self.timeplayed["axis"], self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1]);
      scripts\mp\persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed", 2, self.timeplayed["axis"], self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2]);
      scripts\mp\persistence::stataddchildbufferedwithmax("challengeXPMultiplierTimePlayed", 0, self.timeplayed["axis"], self.bufferedchildstatsmax["challengeXPMaxMultiplierTimePlayed"][0]);
      scripts\mp\persistence::stataddchildbufferedwithmax("weaponXPMultiplierTimePlayed", 0, self.timeplayed["axis"], self.bufferedchildstatsmax["weaponXPMaxMultiplierTimePlayed"][0]);
    }

    if(self.timeplayed["other"]) {
      scripts\mp\persistence::stataddbuffered("timePlayedOther", self.timeplayed["other"]);
      scripts\mp\persistence::stataddbuffered("timePlayedTotal", self.timeplayed["other"]);
      scripts\mp\persistence::stataddchildbuffered("round", "timePlayed", self.timeplayed["other"]);
      scripts\mp\persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed", 0, self.timeplayed["other"], self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0]);
      scripts\mp\persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed", 1, self.timeplayed["other"], self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1]);
      scripts\mp\persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed", 2, self.timeplayed["other"], self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2]);
      scripts\mp\persistence::stataddchildbufferedwithmax("challengeXPMultiplierTimePlayed", 0, self.timeplayed["other"], self.bufferedchildstatsmax["challengeXPMaxMultiplierTimePlayed"][0]);
      scripts\mp\persistence::stataddchildbufferedwithmax("weaponXPMultiplierTimePlayed", 0, self.timeplayed["other"], self.bufferedchildstatsmax["weaponXPMaxMultiplierTimePlayed"][0]);
    }

    if(self.timeplayed["missionTeam"]) {
      if(scripts\mp\utility::rankingenabled() && isDefined(self.var_9978) && isDefined(self.var_9978.var_4C0D)) {
        var_00 = self.var_B8D4;
        var_01 = self getplayerdata("mp", "missionTeamPerformanceData", var_00, "timePlayed");
        self setplayerdata("mp", "missionTeamPerformanceData", var_00, "timePlayed", var_01 + self.timeplayed["missionTeam"]);
      }
    }
  }

  if(game["state"] == "postgame") {
    return;
  }

  self.timeplayed["allies"] = 0;
  self.timeplayed["axis"] = 0;
  self.timeplayed["other"] = 0;
  self.timeplayed["missionTeam"] = 0;
}

updateteamtime() {
  if(game["state"] != "playing") {
    return;
  }

  self.pers["teamTime"] = gettime();
}

updateteambalancedvar() {
  for(;;) {
    var_00 = getdvarint("scr_teambalance");
    if(level.teambalance != var_00) {
      level.teambalance = getdvarint("scr_teambalance");
    }

    wait(1);
  }
}

func_12F37() {
  level.teamlimit = level.maxclients / 2;
  level thread updateteambalancedvar();
  wait(0.15);
  if(level.teambalance && scripts\mp\utility::isroundbased()) {
    if(isDefined(game["BalanceTeamsNextRound"])) {
      scripts\mp\hud_message::showerrormessagetoallplayers("MP_AUTOBALANCE_NEXT_ROUND");
    }

    level waittill("restarting");
    if(isDefined(game["BalanceTeamsNextRound"])) {
      level balanceteams();
      game["BalanceTeamsNextRound"] = undefined;
      return;
    }

    if(!_meth_81A2()) {
      game["BalanceTeamsNextRound"] = 1;
      return;
    }

    return;
  }

  level endon("game_ended");
  for(;;) {
    if(level.teambalance) {
      if(!_meth_81A2()) {
        scripts\mp\hud_message::showerrormessagetoallplayers("MP_AUTOBALANCE_SECONDS", 15);
        wait(15);
        if(!_meth_81A2()) {
          level balanceteams();
        }
      }

      wait(59);
    }

    wait(1);
  }
}

_meth_81A2() {
  level.team["allies"] = 0;
  level.team["axis"] = 0;
  var_00 = level.players;
  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    if(isDefined(var_00[var_01].pers["team"]) && var_00[var_01].pers["team"] == "allies") {
      level.team["allies"]++;
      continue;
    }

    if(isDefined(var_00[var_01].pers["team"]) && var_00[var_01].pers["team"] == "axis") {
      level.team["axis"]++;
    }
  }

  if(level.team["allies"] > level.team["axis"] + level.teambalance || level.team["axis"] > level.team["allies"] + level.teambalance) {
    return 0;
  }

  return 1;
}

balanceteams() {
  iprintlnbold(game["strings"]["autobalance"]);
  var_00 = [];
  var_01 = [];
  var_02 = level.players;
  for(var_03 = 0; var_03 < var_02.size; var_03++) {
    if(!isDefined(var_02[var_03].pers["teamTime"])) {
      continue;
    }

    if(isDefined(var_02[var_03].pers["team"]) && var_02[var_03].pers["team"] == "allies") {
      var_00[var_00.size] = var_02[var_03];
      continue;
    }

    if(isDefined(var_02[var_03].pers["team"]) && var_02[var_03].pers["team"] == "axis") {
      var_01[var_01.size] = var_02[var_03];
    }
  }

  var_04 = undefined;
  while(var_00.size > var_01.size + 1 || var_01.size > var_00.size + 1) {
    if(var_00.size > var_01.size + 1) {
      for(var_05 = 0; var_05 < var_00.size; var_05++) {
        if(isDefined(var_00[var_05].dont_auto_balance)) {
          continue;
        }

        if(!isDefined(var_04)) {
          var_04 = var_00[var_05];
          continue;
        }

        if(var_00[var_05].pers["teamTime"] > var_04.pers["teamTime"]) {
          var_04 = var_00[var_05];
        }
      }

      var_04[[level.onteamselection]]("axis");
    } else if(var_01.size > var_00.size + 1) {
      for(var_05 = 0; var_05 < var_01.size; var_05++) {
        if(isDefined(var_01[var_05].dont_auto_balance)) {
          continue;
        }

        if(!isDefined(var_04)) {
          var_04 = var_01[var_05];
          continue;
        }

        if(var_01[var_05].pers["teamTime"] > var_04.pers["teamTime"]) {
          var_04 = var_01[var_05];
        }
      }

      var_04[[level.onteamselection]]("allies");
    }

    var_04 = undefined;
    var_00 = [];
    var_01 = [];
    var_02 = level.players;
    for(var_03 = 0; var_03 < var_02.size; var_03++) {
      if(isDefined(var_02[var_03].pers["team"]) && var_02[var_03].pers["team"] == "allies") {
        var_00[var_00.size] = var_02[var_03];
        continue;
      }

      if(isDefined(var_02[var_03].pers["team"]) && var_02[var_03].pers["team"] == "axis") {
        var_01[var_01.size] = var_02[var_03];
      }
    }
  }
}

func_F7F6() {
  func_F6B8();
}

func_D3D8(param_00, param_01) {}

countplayers() {
  var_00 = [];
  for(var_01 = 0; var_01 < level.teamnamelist.size; var_01++) {
    var_00[level.teamnamelist[var_01]] = 0;
  }

  for(var_01 = 0; var_01 < level.players.size; var_01++) {
    if(level.players[var_01] == self) {
      continue;
    }

    if(level.players[var_01].pers["team"] == "spectator") {
      continue;
    }

    if(isDefined(level.players[var_01].pers["team"])) {
      var_00[level.players[var_01].pers["team"]]++;
    }
  }

  return var_00;
}

func_F6B8() {
  if(!isDefined(level.var_503D)) {
    level.var_503D = [];
    level.var_503D["allies"] = "mp_warfighter_head_1_3";
    level.var_503D["axis"] = "mp_warfighter_head_1_3";
  }

  if(!isDefined(level.var_5033)) {
    level.var_5033 = [];
    level.var_5033["allies"] = "mp_warfighter_body_1_3";
    level.var_5033["axis"] = "mp_warfighter_body_1_3";
  }

  if(!isDefined(level.var_5050)) {
    level.var_5050 = [];
    level.var_5050["allies"] = "viewhands_us_rangers_urban";
    level.var_5050["axis"] = "viewhands_us_rangers_woodland";
  }

  if(!isDefined(level.dropscavengerfordeath)) {
    level.dropscavengerfordeath = [];
    level.dropscavengerfordeath["allies"] = "delta";
    level.dropscavengerfordeath["axis"] = "delta";
  }
}

setcharactermodels(param_00, param_01, param_02) {
  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
  }

  self setModel(param_00);
  self givegoproattachments(param_02);
  self attach(param_01, "", 1);
  self.headmodel = param_01;
}

func_72A5(param_00) {
  var_01 = undefined;
  var_02 = undefined;
  var_03 = [];
  switch (param_00) {
    case 1:
      var_01 = "mp_warfighter_body_1_3";
      var_02 = "mp_warfighter_head_1_3";
      break;

    case 2:
      var_01 = "mp_body_heavy_1_2";
      var_02 = "mp_head_heavy_1_2";
      break;

    case 3:
      if(level.gametype == "infect") {
        var_01 = "mp_synaptic_body_1_4";
        var_02 = "mp_synaptic_head_1_4";
      } else {
        var_01 = "mp_synaptic_body_1_1";
        var_02 = "mp_synaptic_head_1_1";
      }
      break;

    case 4:
      var_01 = "mp_ftl_body_3_1";
      var_02 = "mp_ftl_head_5_1";
      break;

    case 5:
      var_01 = "mp_stryker_body_2_1";
      var_02 = "mp_stryker_head_3_1";
      break;

    case 6:
      var_01 = "mp_ghost_body_1_3";
      var_02 = "mp_ghost_head_1_1";
      break;
  }

  self setcustomization(var_01, var_02);
  var_04 = self getcustomizationbody();
  var_05 = self getcustomizationhead();
  var_06 = self getcustomizationviewmodel();
  setcharactermodels(var_04, var_05, var_06);
}

getcustomization() {
  var_00 = undefined;
  var_01 = undefined;
  var_02 = [];
  var_03 = getplayermodelindex();
  var_04 = getplayerheadmodel();
  self.var_6A = var_03;
  self.playfxontag = var_04;
  var_00 = tablelookupbyrow("mp\cac\bodies.csv", var_03, 1);
  var_01 = tablelookupbyrow("mp\cac\heads.csv", var_04, 1);
  var_02["body"] = var_00;
  var_02["head"] = var_01;
  return var_02;
}

setmodelfromcustomization() {
  var_00 = getcustomization();
  self setcustomization(var_00["body"], var_00["head"]);
  var_01 = self getcustomizationbody();
  var_02 = self getcustomizationhead();
  var_03 = self getcustomizationviewmodel();
  setcharactermodels(var_01, var_02, var_03);
}

func_F6BE() {
  var_00 = level.var_5033[self.team];
  var_01 = level.var_503D[self.team];
  var_02 = level.var_5050[self.team];
  setcharactermodels(var_00, var_01, var_02);
}

getplayermodelindex() {
  if(level.rankedmatch) {
    return self getplayerdata("rankedloadouts", "squadMembers", "body");
  }

  return self getplayerdata("privateloadouts", "squadMembers", "body");
}

getplayerheadmodel() {
  if(level.rankedmatch) {
    return self getplayerdata("rankedloadouts", "squadMembers", "head");
  }

  return self getplayerdata("privateloadouts", "squadMembers", "head");
}

clearclienttriggeraudiozone(param_00) {
  return tablelookup("mp\cac\bodies.csv", 0, param_00, 5);
}

getplayermodelname(param_00) {
  return tablelookup("mp\cac\bodies.csv", 0, param_00, 1);
}

func_FADC() {
  if(isai(self) || level.gametype == "infect" && self.team == "allies" && isDefined(self.infected_archtype) && self.infected_archtype == "archetype_scout") {
    var_00 = scripts\mp\archetypes\archcommon::getrigindexfromarchetyperef(self.loadoutarchetype) + 1;
  } else if(isDefined(self.changedarchetypeinfo)) {
    var_00 = scripts\mp\archetypes\archcommon::getrigindexfromarchetyperef(self.changedarchetypeinfo.archetype) + 1;
  } else {
    var_00 = getdvarint("forceArchetype", 0);
  }

  if(level.gametype == "infect" && self.team == "axis") {
    var_00 = 3;
  }

  if(isplayer(self) && var_00 == 0) {
    setmodelfromcustomization();
  } else {
    func_72A5(var_00);
  }

  if(!isai(self)) {
    var_01 = getplayermodelindex();
    self.var_6A = var_01;
    var_02 = clearclienttriggeraudiozone(var_01);
  } else {
    self give_explosive_touch_on_revived("vestLight");
  }

  self.voice = level.dropscavengerfordeath[self.team];
  if(scripts\mp\utility::isanymlgmatch() && !isai(self)) {
    var_03 = getplayermodelname(getplayermodelindex());
    if(issubstr(var_03, "fullbody_sniper")) {
      thread func_72B2();
    }
  }

  if(scripts\mp\utility::isjuggernaut()) {
    if(isDefined(self.isjuggernautmaniac) && self.isjuggernautmaniac) {
      thread[[game[self.team + "_model"]["JUGGERNAUT_MANIAC"]]]();
      return;
    }

    if(isDefined(self.isjuggernautlevelcustom) && self.isjuggernautlevelcustom) {
      thread[[game[self.team + "_model"]["JUGGERNAUT_CUSTOM"]]]();
      return;
    }

    thread[[game[self.team + "_model"]["JUGGERNAUT"]]]();
    return;
  }
}

func_72B2() {
  if(self.team == "axis") {
    self setModel("mp_fullbody_heavy");
    self givegoproattachments("viewmodel_mp_warfighter_1");
  } else {
    self setModel("mp_body_infected_a");
    self givegoproattachments("viewmodel_mp_warfighter_1");
  }

  if(isDefined(self.headmodel)) {
    self detach(self.headmodel, "");
    self.headmodel = undefined;
  }

  self attach("head_mp_infected", "", 1);
  self.headmodel = "head_mp_infected";
  self give_explosive_touch_on_revived("cloth");
}

func_12E95() {
  if(!level.rankedmatch) {
    return;
  }

  var_00 = 0;
  for(;;) {
    var_00++;
    if(var_00 >= level.players.size) {
      var_00 = 0;
    }

    if(isDefined(level.players[var_00])) {
      level.players[var_00] func_12E94();
    }

    wait(1);
  }
}

func_12E94() {
  if(isai(self)) {
    return;
  }

  if(!scripts\mp\utility::rankingenabled()) {
    if(self.timeplayed["allies"]) {
      scripts\mp\persistence::stataddbuffered("timePlayedAllies", self.timeplayed["allies"], 1);
      scripts\mp\persistence::stataddbuffered("timePlayedTotal", self.timeplayed["allies"], 1);
      scripts\mp\persistence::stataddchildbuffered("round", "timePlayed", self.timeplayed["allies"], 1);
    }

    if(self.timeplayed["axis"]) {
      scripts\mp\persistence::stataddbuffered("timePlayedOpfor", self.timeplayed["axis"], 1);
      scripts\mp\persistence::stataddbuffered("timePlayedTotal", self.timeplayed["axis"], 1);
      scripts\mp\persistence::stataddchildbuffered("round", "timePlayed", self.timeplayed["axis"], 1);
    }

    if(self.timeplayed["other"]) {
      scripts\mp\persistence::stataddbuffered("timePlayedOther", self.timeplayed["other"], 1);
      scripts\mp\persistence::stataddbuffered("timePlayedTotal", self.timeplayed["other"], 1);
      scripts\mp\persistence::stataddchildbuffered("round", "timePlayed", self.timeplayed["other"], 1);
    }

    return;
  }

  if(self.timeplayed["allies"]) {
    scripts\mp\persistence::stataddbuffered("timePlayedAllies", self.timeplayed["allies"]);
    scripts\mp\persistence::stataddbuffered("timePlayedTotal", self.timeplayed["allies"]);
    scripts\mp\persistence::stataddchildbuffered("round", "timePlayed", self.timeplayed["allies"]);
    scripts\mp\persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed", 0, self.timeplayed["allies"], self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0]);
    scripts\mp\persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed", 1, self.timeplayed["allies"], self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1]);
    scripts\mp\persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed", 2, self.timeplayed["allies"], self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2]);
  }

  if(self.timeplayed["axis"]) {
    scripts\mp\persistence::stataddbuffered("timePlayedOpfor", self.timeplayed["axis"]);
    scripts\mp\persistence::stataddbuffered("timePlayedTotal", self.timeplayed["axis"]);
    scripts\mp\persistence::stataddchildbuffered("round", "timePlayed", self.timeplayed["axis"]);
    scripts\mp\persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed", 0, self.timeplayed["axis"], self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0]);
    scripts\mp\persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed", 1, self.timeplayed["axis"], self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1]);
    scripts\mp\persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed", 2, self.timeplayed["axis"], self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2]);
  }

  if(self.timeplayed["other"]) {
    scripts\mp\persistence::stataddbuffered("timePlayedOther", self.timeplayed["other"]);
    scripts\mp\persistence::stataddbuffered("timePlayedTotal", self.timeplayed["other"]);
    scripts\mp\persistence::stataddchildbuffered("round", "timePlayed", self.timeplayed["other"]);
    scripts\mp\persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed", 0, self.timeplayed["other"], self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0]);
    scripts\mp\persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed", 1, self.timeplayed["other"], self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1]);
    scripts\mp\persistence::stataddchildbufferedwithmax("xpMultiplierTimePlayed", 2, self.timeplayed["other"], self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2]);
  }

  self.timeplayed["allies"] = 0;
  self.timeplayed["axis"] = 0;
  self.timeplayed["other"] = 0;
}

watchafk() {
  var_00 = 0;
  for(;;) {
    var_00++;
    if(var_00 >= level.players.size) {
      var_00 = 0;
    }

    if(isDefined(level.players[var_00])) {
      if(isai(level.players[var_00])) {
        continue;
      }

      level.players[var_00] checkforafk();
    }

    wait(1);
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

checkforafk() {
  if(scripts\mp\utility::istrue(level.gameended)) {
    return;
  }

  if(!isDefined(self.pers["validKickTime"])) {
    self.pers["validKickTime"] = 0;
  }

  var_00 = self.pers["validKickTime"];
  var_01 = 0;
  var_02 = self.pers["kills"];
  var_03 = self.pers["assists"];
  var_04 = var_02 == 0 && var_03 == 0;
  if(isDefined(self.pers["stanceTracking"]) && var_00 > 30) {
    var_05 = self.pers["stanceTracking"]["crouch"] / var_00;
    if(var_05 > 1) {
      var_01 = 1;
    }
  }

  if(var_04 && var_00 > 60) {
    if(!isDefined(self.pers["distTrackingPassed"])) {
      if(level.gametype == "infect") {
        if(self.team == "axis") {
          var_01 = 1;
        }
      } else {
        var_01 = 1;
      }
    }
  }

  if(var_04 && var_00 > 120) {
    if(!isDefined(self.lastdamagetime) || self.lastdamagetime + -5536 < gettime()) {
      switch (level.gametype) {
        case "gun":
          if(scripts\mp\utility::istrue(level.kick_afk_check)) {
            var_01 = 1;
          }
          break;
      }
    }
  }

  if(var_01 && !isgamebattlematch()) {
    kick(self getentitynumber(), "EXE_PLAYERKICKED_INACTIVE", 1);
  }
}

getjointeampermissions(param_00) {
  var_01 = 0;
  var_02 = 0;
  var_03 = level.players;
  for(var_04 = 0; var_04 < var_03.size; var_04++) {
    var_05 = var_03[var_04];
    if(isDefined(var_05.pers["team"]) && var_05.pers["team"] == param_00) {
      var_01++;
      if(isbot(var_05)) {
        var_02++;
      }
    }
  }

  if(var_01 < level.teamlimit) {
    return 1;
  }

  if(var_02 > 0) {
    return 1;
  }

  if(!scripts\mp\utility::matchmakinggame()) {
    return 1;
  }

  if(level.gametype == "infect") {
    return 1;
  }

  bbprint("mp_exceeded_team_max_error", "player_xuid %s isHost %i", self getxuid(), self ishost());
  if(self ishost()) {
    wait(1.5);
  }

  setnojiptime(1);
  level.nojip = 1;
  kick(self getentitynumber(), "EXE_PLAYERKICKED_INVALIDTEAM");
  return 0;
}

onplayerspawned() {
  level endon("game_ended");
  self waittill("spawned_player");
}

func_BD73(param_00) {
  return tablelookupistring("mp\MTTable.csv", 0, param_00, 1);
}

func_BD72(param_00) {
  return tablelookup("mp\MTTable.csv", 0, param_00, 2);
}

func_BD71(param_00) {
  return tablelookup("mp\MTTable.csv", 0, param_00, 3);
}

isonladder(param_00) {
  return tablelookupistring("mp\factionTable.csv", 0, game[param_00], 1);
}

_meth_81B7(param_00) {
  return tablelookupistring("mp\factionTable.csv", 0, game[param_00], 2);
}

ismlgspectator(param_00) {
  return tablelookupistring("mp\factionTable.csv", 0, game[param_00], 4);
}

_meth_81A8(param_00) {
  return tablelookupistring("mp\factionTable.csv", 0, game[param_00], 3);
}

_meth_81B2(param_00) {
  return tablelookup("mp\factionTable.csv", 0, game[param_00], 5);
}

_meth_81B1(param_00) {
  return tablelookup("mp\factionTable.csv", 0, game[param_00], 6);
}

_meth_81B0(param_00) {
  return tablelookup("mp\factionTable.csv", 0, game[param_00], 17);
}

getteamvoiceprefix(param_00) {
  return tablelookup("mp\factionTable.csv", 0, game[param_00], 7);
}

getteamspawnmusic(param_00) {
  return tablelookup("mp\factionTable.csv", 0, game[param_00], 8);
}

issprinting(param_00) {
  return tablelookup("mp\factionTable.csv", 0, game[param_00], 9);
}

ismeleeing(param_00) {
  return tablelookup("mp\factionTable.csv", 0, game[param_00], 10);
}

_meth_81AA(param_00) {
  return tablelookup("mp\factionTable.csv", 0, game[param_00], 11);
}

ismantling(param_00) {
  return tablelookup("mp\factionTable.csv", 0, game[param_00], 12);
}

_meth_81AC(param_00) {
  return tablelookup("mp\factionTable.csv", 0, game[param_00], 13);
}

_meth_81A4(param_00) {
  return (scripts\mp\utility::func_1114F(tablelookup("mp\factionTable.csv", 0, game[param_00], 14)), scripts\mp\utility::func_1114F(tablelookup("mp\factionTable.csv", 0, game[param_00], 15)), scripts\mp\utility::func_1114F(tablelookup("mp\factionTable.csv", 0, game[param_00], 16)));
}

_meth_81A5(param_00) {
  return tablelookup("mp\factionTable.csv", 0, game[param_00], 18);
}

_meth_81A6(param_00) {
  return tablelookup("mp\factionTable.csv", 0, game[param_00], 19);
}