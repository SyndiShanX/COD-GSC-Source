/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\teams.gsc
***********************************************/

function init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("teams", "createOperatorCustomization", &createoperatorcustomization);
  level.teambalance = getdvarint("scr_teambalance");
  level.maxclients = getmaxclients();
  var_0 = ["free", "axis", "allies", "team_three", "team_four", "team_five", "team_six", "team_seven", "team_eight", "team_nine", "team_ten", "team_eleven", "team_twelve", "team_thirteen", "team_fourteen", "team_fifteen", "team_sixteen", "team_seventeen", "team_eighteen", "team_nineteen", "team_twenty", "team_twenty_one", "team_twenty_two", "team_twenty_three", "team_twenty_four", "team_twenty_five", "team_twenty_six", "team_twenty_seven", "team_twenty_eight", "team_twenty_nine", "team_thirty", "team_thirty_one", "team_thirty_two", "team_thirty_three", "team_thirty_four", "team_thirty_five", "team_thirty_six", "team_thirty_seven", "team_thirty_eight", "team_thirty_nine", "team_forty", "team_forty_one", "team_forty_two", "team_forty_three", "team_forty_four", "team_forty_five", "team_forty_six", "team_forty_seven", "team_forty_eight", "team_forty_nine", "team_fifty", "team_fifty_one", "team_fifty_two", "team_fifty_three", "team_fifty_four", "team_fifty_five", "team_fifty_six", "team_fifty_seven", "team_fifty_eight", "team_fifty_nine", "team_sixty", "team_sixty_one", "team_sixty_two", "team_sixty_three", "team_sixty_four", "team_sixty_five", "team_sixty_six", "team_sixty_seven", "team_sixty_eight", "team_sixty_nine", "team_seventy", "team_seventy_one", "team_seventy_two", "team_seventy_three", "team_seventy_four", "team_seventy_five", "team_seventy_six", "team_seventy_seven", "team_seventy_eight", "team_seventy_nine", "team_eighty", "team_eighty_one", "team_eighty_two", "team_eighty_three", "team_eighty_four", "team_eighty_five", "team_eighty_six", "team_eighty_seven", "team_eighty_eight", "team_eighty_nine", "team_ninety", "team_ninety_one", "team_ninety_two", "team_ninety_three", "team_ninety_four", "team_ninety_five", "team_ninety_six", "team_ninety_seven", "team_ninety_eight", "team_ninety_nine", "team_hundred", "team_hundred_one", "team_hundred_two", "team_hundred_three", "team_hundred_four", "team_hundred_five", "team_hundred_six", "team_hundred_seven", "team_hundred_eight", "team_hundred_nine", "team_hundred_ten", "team_hundred_eleven", "team_hundred_twelve", "team_hundred_thirteen", "team_hundred_fourteen", "team_hundred_fifteen", "team_hundred_sixteen", "team_hundred_seventeen", "team_hundred_eightteen", "team_hundred_nineteen", "team_hundred_twenty", "team_hundred_twenty_one", "team_hundred_twenty_two", "team_hundred_twenty_three", "team_hundred_twenty_four", "team_hundred_twenty_five", "team_hundred_twenty_six", "team_hundred_twenty_seven", "team_hundred_twenty_eight", "team_hundred_twenty_nine", "team_hundred_thirty", "team_hundred_thirty_one", "team_hundred_thirty_two", "team_hundred_thirty_three", "team_hundred_thirty_four", "team_hundred_thirty_five", "team_hundred_thirty_six", "team_hundred_thirty_seven", "team_hundred_thirty_eight", "team_hundred_thirty_nine", "team_hundred_forty", "team_hundred_forty_one", "team_hundred_forty_two", "team_hundred_forty_three", "team_hundred_forty_four", "team_hundred_forty_five", "team_hundred_forty_six", "team_hundred_forty_seven", "team_hundred_forty_eight", "team_hundred_forty_nine", "team_hundred_fifty", "team_hundred_fifty_one", "team_hundred_fifty_two", "team_hundred_fifty_three", "team_hundred_fifty_four", "team_hundred_fifty_five", "team_hundred_fifty_six", "team_hundred_fifty_seven", "team_hundred_fifty_eight", "team_hundred_fifty_nine", "team_hundred_sixty", "team_hundred_sixty_one", "team_hundred_sixty_two", "team_hundred_sixty_three", "team_hundred_sixty_four", "team_hundred_sixty_five", "team_hundred_sixty_six", "team_hundred_sixty_seven", "team_hundred_sixty_eight", "team_hundred_sixty_nine", "team_hundred_seventy", "team_hundred_seventy_one", "team_hundred_seventy_two", "team_hundred_seventy_three", "team_hundred_seventy_four", "team_hundred_seventy_five", "team_hundred_seventy_six", "team_hundred_seventy_seven", "team_hundred_seventy_eight", "team_hundred_seventy_nine", "team_hundred_eighty", "team_hundred_eighty_one", "team_hundred_eighty_two", "team_hundred_eighty_three", "team_hundred_eighty_four", "team_hundred_eighty_five", "team_hundred_eighty_six", "team_hundred_eighty_seven", "team_hundred_eighty_eight", "team_hundred_eighty_nine", "team_hundred_ninety", "team_hundred_ninety_one", "team_hundred_ninety_two", "team_hundred_ninety_three", "team_hundred_ninety_four", "team_hundred_ninety_five", "team_hundred_ninety_six", "team_hundred_ninety_seven", "team_hundred_ninety_eight", "team_hundred_ninety_nine", "team_two_hundred", "spectator", "follower"];
  level.allteamnamelist = var_0;
  var_1 = ["axis", "allies"];
  var_2 = ["SAS", "RUSF", "USMC", "SABF"];
  var_3 = scripts\mp\utility\teams::getcustomgametypeteammax();
  var_3 = min(var_3, getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_teamcount", -1));

  if(!isDefined(level.teammaxfill)) {
    if(getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_teammaxfill", -1) != -1) {
      level.teammaxfill = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_teammaxfill", 1) > 0;
    } else {
      level.teammaxfill = var_3 == 50;
    }
  }

  level.maxteamsize = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_teamsize", 0);
  level.maxsquadsize = getdvarint("scr_" + scripts\mp\utility\game::getgametype() + "_squadsize", 4);
  var_4 = 1;
  var_5 = -1;

  if(var_3 >= 3) {
    for(var_6 = 3; var_6 < var_3 + var_4; var_6++) {
      var_1 = level.allteamnamelist[var_6];

      if(!isDefined(game[level.allteamnamelist[var_6]])) {
        game[level.allteamnamelist[var_6]] = var_2[(var_6 + var_5) % var_2.size];
      }
    }
  }

  var_7 = ref_132E6();

  if(var_7 && !scripts\engine\utility::array_contains(var_1, "team_two_hundred")) {
    level.teamnamelist = scripts\engine\utility::array_add(var_1, "team_two_hundred");
  } else {
    level.teamnamelist = var_1;
  }

  level.multiteambased = level.teamnamelist.size > 2 || scripts\mp\utility\game::getgametype() == "br" && scripts\mp\menus::ref_13733();
  level.teamdata = [];

  foreach(var_9 in var_0) {
    level.teamdata[var_9] = [];
    level.teamdata[var_9]["players"] = [];
    level.teamdata[var_9]["alivePlayers"] = [];
    level.teamdata[var_9]["teamCount"] = 0;
    level.teamdata[var_9]["aliveCount"] = 0;
    level.teamdata[var_9]["livesCount"] = 0;
    level.teamdata[var_9]["hasSpawned"] = 0;
    level.teamdata[var_9]["oneLeftTime"] = 0;
    level.teamdata[var_9]["twoLeft"] = 0;
    level.teamdata[var_9]["oneLeft"] = 0;

    if(level.multiteambased) {
      level.teamdata[var_9]["deathEvent"] = 0;
    }
  }

  foreach(var_9 in var_1) {
    scripts\mp\utility\teams::rpgafterspawnfunc(var_9);
    scripts\mp\utility\teams::getteamname(var_9);
    scripts\mp\utility\teams::getteamshortname(var_9);
    scripts\mp\utility\teams::getteamicon(var_9);
    scripts\mp\utility\teams::getteamheadicon(var_9);
    scripts\mp\utility\teams::getteamvoiceinfix(var_9);
  }

  level.teambased = var_3 > 1;

  if(scripts\mp\utility\game::unset_relic_grounded()) {}

  setDvar("ui_numteams", level.teamnamelist.size);

  if(getdvarint("scr_game_forceuav") > 1 && level.teambased) {
    level thread scripts\cp_mp\killstreaks\uav::setforceradars(undefined, 1);
  }

  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(&onjoinedteam);
  thread onplayerconnect();
  thread trackplayedtime();
  initoperatorcustomization();
  initnightvisionheadoverrides();
  wait 0.15;
  thread updateplayertimes();
  thread finalizeplayertimes();

  if(level.teambased) {
    thread updateteambalance();
  }

  if(scripts\mp\utility\game::matchmakinggame() && !dotournamentendgame() && !getdvarint("scr_disable_anti_afk", 0)) {
    thread watchafk();
  }

  if(isDefined(level.playerentersafearea)) {
    level thread[[level.playerentersafearea]]();
  }

  if(getdvarint("scr_debug_teams", 0) == 1) {
    thread istempsfxent();
    return;
  }
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0.timeplayed = [];
    var_0.timeplayed["game"] = 0;
    var_0.timeplayed["total"] = 0;
    var_0.timeplayed["missionTeam"] = 0;
    var_0.timeplayed["other"] = 0;
    var_0.timeplayed["timeDead"] = 0;
    var_0.timeplayed["gulag"] = 0;
    var_0.timeplayed["rebirthRespawn"] = 0;
  }
}

function onjoinedteam(var_0) {
  updateteamtime(var_0);
}

function onjoinedspectators(var_0) {
  if(isDefined(var_0.pers)) {
    var_0.pers["teamTime"] = undefined;
    return;
  }
}

function trackplayedtime() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");

  while(!level.gameended) {
    wait 1;

    foreach(var_1 in level.players) {
      trackplayedtimeupdate(var_1);
    }
  }
}

function trackplayedtimeupdate() {
  if(isDefined(self.timeplayed)) {
    var_0 = self.sessionteam;

    if(!isDefined(self.timeplayed["game"])) {
      self.timeplayed["game"] = 0;
    } else {
      self.timeplayed["game"]++;
    }

    if(var_0 != "spectator" && var_0 != "follower") {
      self.timeplayed["total"]++;
      self.timeplayed["missionTeam"]++;

      if(!scripts\mp\utility\player::isreallyalive(self)) {
        self.timeplayed["timeDead"]++;
        return;
      }

      return;
    }

    return;
  }
}

function updateplayertimes() {
  level endon("game_ended");

  for(;;) {
    var_0 = level.players.size;
    var_1 = 0;

    while(var_1 < var_0) {
      scripts\mp\hostmigration::waittillhostmigrationdone();

      for(var_2 = 0; var_2 < 20; var_2++) {
        var_3 = var_1 + var_2;
        var_4 = level.players[var_3];

        if(isDefined(var_4)) {
          updateplayedtime(var_4);
        }
      }

      waitframe();
      var_1 += 20;
    }

    wait 10;
  }
}

function finalizeplayertimes() {
  while(!level.gameended) {
    wait 2;
  }

  foreach(var_1 in level.players) {
    updateplayedtime(var_1);

    if(!scripts\mp\utility\game::runleanthreadmode()) {
      var_1 scripts\mp\persistence::writebufferedstats();
      var_1 scripts\mp\persistence::updateweaponbufferedstats();
    }
  }
}

function updateplayedtime() {
  if(isai(self)) {
    return;
  }

  scripts\mp\playerstats_interface::addtoplayerstatbuffered(self.timeplayed["game"], "matchStats", "timePlayedTotal");
  scripts\mp\persistence::stataddchildbuffered("round", "timePlayed", self.timeplayed["game"], 1);

  if(scripts\mp\gametypes\br_public::isplayeringulag()) {
    self.timeplayed["gulag"] = self.timeplayed["gulag"] + self.timeplayed["game"];
  } else if(scripts\mp\gametypes\br_public::isplayerwaitingrebirthrespawn()) {
    self.timeplayed["rebirthRespawn"] = self.timeplayed["rebirthRespawn"] + self.timeplayed["game"];
  }

  if(game["state"] == "postgame") {
    return;
  }

  self.timeplayed["game"] = 0;
  self.timeplayed["missionTeam"] = 0;
}

function updateteamtime() {
  if(game["state"] != "playing") {
    return;
  }

  self.pers["teamTime"] = gettime();
}

function updateteambalancedvar() {
  for(;;) {
    var_0 = getdvarint("scr_teambalance");

    if(level.teambalance != var_0) {
      level.teambalance = getdvarint("scr_teambalance");
    }

    wait 1;
  }
}

function updateteambalance() {
  thread updateteambalancedvar();
  wait 0.15;

  if(level.teambalance && scripts\mp\utility\game::isroundbased()) {
    if(isDefined(game["BalanceTeamsNextRound"])) {
      scripts\mp\hud_message::showerrormessagetoallplayers("MP/AUTOBALANCE_NEXT_ROUND");
    }

    level waittill("restarting");

    if(isDefined(game["BalanceTeamsNextRound"])) {
      balanceteams(level);
      game["BalanceTeamsNextRound"] = undefined;
      return;
    }

    if(!getteambalance()) {
      game["BalanceTeamsNextRound"] = 1;
      return;
    }

    return;
  }

  level endon("game_ended");

  for(;;) {
    if(level.teambalance) {
      if(!getteambalance()) {
        scripts\mp\hud_message::showerrormessagetoallplayers("MP/AUTOBALANCE_SECONDS", 15);
        wait 15;

        if(!getteambalance()) {
          balanceteams(level);
        }
      }

      wait 59;
    }

    wait 1;
  }
}

function getteambalance() {
  GscBinSkip1(0x45, "allies", 0);
}

function balanceteams() {
  iprintlnbold(game["strings"]["autobalance"]);
  var_0 = [];
  var_1 = [];
  var_2 = level.players;

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(!isDefined(var_2[var_3].pers["teamTime"])) {
      continue;
    }

    if(isDefined(var_2[var_3].pers["team"]) && var_2[var_3].pers["team"] == "allies") {
      var_0 = var_2[var_3];
      continue;
    }

    if(isDefined(var_2[var_3].pers["team"]) && var_2[var_3].pers["team"] == "axis") {
      var_1 = var_2[var_3];
    }
  }

  var_4 = undefined;

  while(var_0.size > var_1.size + 1 || var_1.size > var_0.size + 1) {
    if(var_0.size > var_1.size + 1) {
      for(var_5 = 0; var_5 < var_0.size; var_5++) {
        if(isDefined(var_0[var_5].dont_auto_balance)) {
          continue;
        }

        if(!isDefined(var_4)) {
          var_4 = var_0[var_5];
          continue;
        }

        if(var_0[var_5].pers["teamTime"] > var_4.pers["teamTime"]) {
          var_4 = var_0[var_5];
        }
      }

      var_4[[level.onteamselection]]("axis");
    } else if(var_1.size > var_0.size + 1) {
      for(var_5 = 0; var_5 < var_1.size; var_5++) {
        if(isDefined(var_1[var_5].dont_auto_balance)) {
          continue;
        }

        if(!isDefined(var_4)) {
          var_4 = var_1[var_5];
          continue;
        }

        if(var_1[var_5].pers["teamTime"] > var_4.pers["teamTime"]) {
          var_4 = var_1[var_5];
        }
      }

      var_4[[level.onteamselection]]("allies");
    }

    var_4 = undefined;
    var_0 = [];
    var_1 = [];
    var_2 = level.players;

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      if(isDefined(var_2[var_3].pers["team"]) && var_2[var_3].pers["team"] == "allies") {
        var_0 = var_2[var_3];
        continue;
      }

      if(isDefined(var_2[var_3].pers["team"]) && var_2[var_3].pers["team"] == "axis") {
        var_1 = var_2[var_3];
      }
    }
  }
}

function playermodelforweapon(var_0, var_1) {}

function countplayers() {
  var_0 = [];

  for(var_1 = 0; var_1 < level.teamnamelist.size; var_1++) {
    var_0 = 0;
  }

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(level.players[var_1] == self) {
      continue;
    }

    if(level.players[var_1].pers["team"] == "spectator") {
      continue;
    }

    if(level.players[var_1].pers["team"] == "follower") {
      continue;
    }

    if(isDefined(level.players[var_1].pers["team"])) {
      var_0++;
    }
  }

  return var_0;
}

function setcharactermodels(var_0, var_1, var_2) {
  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
  }

  if(!isagent(self)) {
    var_0 = self getcustomizationbody();
    var_1 = self getcustomizationhead();
    var_2 = self getcustomizationviewmodel();
  }

  self setModel(var_0);
  self setviewmodel(var_2);

  if(isDefined(var_1)) {
    self attach(var_1, "", 1);
    self.headmodel = var_1;
    return;
  }
}

function forcecustomization(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = [];

  switch (var_0) {
    case 1:
      var_1 = "mp_warfighter_body_1_3";
      var_2 = "mp_warfighter_head_1_3";
      break;
    case 2:
      var_1 = "mp_body_heavy_1_2";
      var_2 = "mp_head_heavy_1_2";
      break;
    case 3:
      if(scripts\mp\utility\game::getgametype() == "infect") {
        var_1 = "mp_synaptic_body_1_4";
        var_2 = "mp_synaptic_head_1_4";
      } else {
        var_1 = "mp_synaptic_body_1_1";
        var_2 = "mp_synaptic_head_1_1";
      }

      break;
    case 4:
      var_1 = "mp_ftl_body_3_1";
      var_2 = "mp_ftl_head_5_1";
      break;
    case 5:
      var_1 = "mp_stryker_body_2_1";
      var_2 = "mp_stryker_head_3_1";
      break;
    case 6:
      var_1 = "mp_ghost_body_1_3";
      var_2 = "mp_ghost_head_1_1";
      break;
  }

  self setcustomization(var_1, var_2);
  var_4 = self getcustomizationbody();
  var_5 = self getcustomizationhead();
  var_6 = self getcustomizationviewmodel();
  setcharactermodels(var_4, var_5, var_6);
}

function getcustomization() {
  var_0 = [];

  if(isDefined(self.operatorcustomization)) {
    GscBinSkip0(0x2e, "body", self.operatorcustomization.body);
  }

  [var_0] = getoperatorcustomization();
  var_0 = var_1[1];
  return var_0;
}

function setmodelfromcustomization() {
  var_0 = getcustomization();
  self setcustomization(var_0["body"], var_0["head"]);
  var_1 = self getcustomizationbody();
  var_2 = self getcustomizationhead();
  var_3 = self getcustomizationviewmodel();
  setcharactermodels(var_1, var_2, var_3);
}

function getplayercustomization() {
  return getoperatorcustomization();
}

function getplayerbodymodel() {
  var_0 = getoperatorcustomization();
  return var_0[0];
}

function getplayerheadmodel() {
  var_0 = getoperatorcustomization();
  return var_0[1];
}

function getplayerviewmodelfrombody(var_0) {
  var_1 = tablelookup("mp/cac/bodies.csv", 1, var_0, 3);

  if(!isDefined(var_1) || var_1 == "") {
    var_1 = "viewhands_mp_base_iw8";
  }

  return var_1;
}

function getplayerfoleytype(var_0) {
  return tablelookup("mp/cac/bodies.csv", 1, var_0, 5);
}

function getplayermodelname(var_0) {
  return tablelookup("mp/cac/bodies.csv", 0, var_0, 1);
}

function setupplayermodel() {
  var_0 = 1;

  if(istrue(var_0)) {
    var_1 = undefined;
    var_2 = undefined;

    if(!isDefined(self.operatorcustomization) || self.operatorcustomization.rebuild == 1) {
      createoperatorcustomization();
    }

    setcharactermodels(self.operatorcustomization.defaultbody, self.operatorcustomization.defaulthead, self.operatorcustomization.defaultvm);
    scripts\mp\utility\player::_setsuit(self.operatorcustomization.suit);
    scripts\cp_mp\execution::_giveexecution(self.operatorcustomization.execution);
    return;
  }

  if(isai(self)) {
    var_3 = scripts\mp\archetypes\archcommon::getrigindexfromarchetyperef(self.loadoutarchetype) + 1;
  } else if(isDefined(self.changedarchetypeinfo)) {
    var_3 = scripts\mp\archetypes\archcommon::getrigindexfromarchetyperef(self.changedarchetypeinfo.archetype) + 1;
  } else {
    var_3 = getdvarint("forceArchetype", 0);
  }

  if(scripts\mp\utility\game::getgametype() == "infect" && self.team == "axis") {
    var_3 = 3;
  }

  if(isPlayer(self) && var_3 == 0) {
    setmodelfromcustomization();
  } else {
    forcecustomization(var_3);
  }

  self.voice = "delta";

  if(scripts\mp\utility\game::isanymlgmatch() && !isai(self)) {
    var_4 = getplayerbodymodel();

    if(issubstr(var_4, "fullbody_sniper")) {
      thread forcedefaultmodel();
      return;
    }

    return;
  }
}

function setuppingspecificvars(var_0) {
  self endon("disconnect");
  self notify("handleUltraOperatorSkins");
  self endon("handleUltraOperatorSkins");
  var_1 = "ultra_operators";
  var_2 = "neutral";

  if(!self isscriptable() || !self getscriptablehaspart(var_1)) {
    return;
  }

  var_3 = tablelookup("operatorskins.csv", 0, var_0, 26);

  if(isDefined(var_3) && var_3 != "") {
    self setscriptablepartstate(var_1, var_3);
    self waittill("death");
    self setscriptablepartstate(var_1, var_2);
    return;
  }

  self setscriptablepartstate(var_1, var_2);
}

function createoperatorcustomization() {
  if(isai(self) && scripts\mp\utility\game::getgametype() != "br") {
    self.botoperatorref = undefined;
    self.botoperatorteam = undefined;
    self.botskinid = undefined;
  }

  var_0 = getoperatorcustomization();
  var_1 = var_0[0];
  var_2 = var_0[1];
  var_3 = var_0[2];

  if(!isagent(self)) {
    self setcustomization(var_1, var_2);
    var_4 = self getcustomizationbody();
    var_5 = self getcustomizationhead();
    var_6 = self getcustomizationviewmodel();
    var_7 = getplayerviewmodelfrombody(var_1);
  } else if(level.gametype == "br") {
    var_4 = "fullbody_usmc_ar_br_infil";
    var_5 = undefined;
    var_6 = "viewhands_mp_base_iw8";
    var_7 = "viewhands_mp_base_iw8";
  } else {
    var_4 = "body_opforce_london_terrorist_1_2";
    var_5 = "head_male_bc_03";
    var_6 = "viewmodel_mp_base_iw8";
    var_7 = "viewmodel_mp_base_iw8";
  }

  var_8 = lookupcurrentoperator(self.team);
  var_9 = lookupcurrentoperatorskin(self.team);

  if(scripts\mp\utility\game::getgametype() == "infect" && self.team == "axis") {
    var_8 = "kreuger_eastern";
    var_9 = 218;
  }

  var_10 = spawnStruct();
  var_10.operatorref = var_8;
  var_10.skinref = var_9;
  var_10.body = var_5;
  var_10.defaultbody = var_4;
  var_10.head = var_6;
  var_10.defaulthead = var_5;
  var_10.vm = var_7;
  var_10.defaultvm = var_6;
  var_10.gender = getoperatorgender(var_8);
  var_10.voice = getoperatorvoice(var_8, var_9);
  var_10.title = resettimeronpickup(var_8);
  var_10.clothtype = resetplayermovespeedscale(var_9);
  var_10.superfaction = getoperatorsuperfaction(var_8);
  var_10.execution = getoperatorexecution(var_8);
  var_10.oic_rewardammo = resetposition(var_8);
  var_10.oicvariantid = resetscorefeedcontrolomnvar(var_8);
  var_10.suit = var_7;
  var_10.rebuild = 0;
  var_10.spawn_carriables_from_prefabs_percentage = update_timer_for_bomb_vest_detonator_holder(var_5);

  if(scripts\mp\utility\game::getgametype() == "br") {
    var_11 = resetplayerdataforrespawningplayer(var_9);

    if(var_11 != "") {
      var_10.disabledebugdialogue = var_11;
    }

    thread setuppingspecificvars(var_9);

    if(resetsuper(var_8) == "s4") {
      self.ref_12E3A = 1;
    }
  }

  var_12 = spawnStruct();
  var_12.apc = runbrgametypefunc6("apc");
  var_12.c4_pick_up_listener = rundomplateskybeam("apc");
  var_12.check_cannot_spawn_tank = runbrgametypefunc6("atv");
  var_12.get_extra_focus_fire_multipler = runbrgametypefunc6("cargo_truck");
  var_12.vehicle_damage_endburndown = runbrgametypefunc6("jeep");
  var_12.x1opsenableelimination = runbrgametypefunc6("little_bird");
  var_12.ref_139F7 = runbrgametypefunc6("tac_rover");
  var_12.ref_13A47 = runbrgametypefunc6("tank_east");
  var_12.ref_13A48 = rundomplateskybeam("tank_east");
  var_12.ref_13A52 = runbrgametypefunc6("tank_west");
  var_12.ref_13A53 = rundomplateskybeam("tank_west");
  var_12.ref_11D4D = runbrgametypefunc6("motorcycle");
  var_12.br_is_allowed_armor_insert = runbrgametypefunc6("airplane");
  var_12.create_head_icon_for_crate = runbrgametypefunc6("bomber");
  var_12.open_jeep_carpoc = runbrgametypefunc6("open_jeep_carpoc");
  var_12.open_jeep_carpoc_turret = rundomplateskybeam("open_jeep_carpoc");
  var_12.c130airdrop_heightoverride = runcircles("apc", 4);
  var_12.check_carrier_status = runcircles("atv", 6);
  var_12.get_fake_digit_from_pool = runcircles("cargo_truck", 8);
  var_12.vehicle_damage_enginevisualclearcallback = runcircles("jeep", 10);
  var_12.x1opsendgame = runcircles("little_bird", 12);
  var_12.ref_139F8 = runcircles("tac_rover", 14);
  var_12.ref_11D5F = runcircles("motorcycle", 16);
  var_12.open_jeep_carpoc_horn = runcircles("open_jeep_carpoc", 18);
  var_12.check_for_damage_scalar_change = runcontrolledcallback("atv");
  var_12.ref_139FC = runcontrolledcallback("tac_rover");
  var_12.zombieingas = runcontrolledcallback("little_bird");
  var_12.ref_11D70 = runcontrolledcallback("motorcycle");
  var_12.br_isplayerbeforeinitialinfildeploy = runcontrolledcallback("airplane");
  var_12.createjuggdroplocation = runcontrolledcallback("bomber");

  if(istrue(game["isLaunchChunk"])) {
    if(isbot(self)) {
      if(self.team == "allies") {
        var_10.voice = "ukft1";
      } else {
        var_10.voice = "ruft1";
      }
    }
  }

  self.operatorcustomization = var_10;
  self.ref_14238 = var_12;
}

function respawntokenenabled(var_0) {
  return self getplayerdata(level.loadoutsgroup, "customizationSetup", "operators", var_0);
}

function respawntokendisabled(var_0) {
  if(getlocalestructarray()) {
    var_1 = scripts\engine\utility::ter_op(var_0 == 0, "allies", "axis");

    if(isDefined(self.pers["restrictedOperatorInfo"])) {
      var_2 = self.pers["restrictedOperatorInfo"][var_1];

      if(isDefined(var_2)) {
        return var_2.operatorref;
      }
    }

    var_3 = respawntokenenabled(var_0);

    if(update_track_operational_status(var_3)) {
      if(!isDefined(self.pers["restrictedOperatorInfo"])) {
        self.pers["restrictedOperatorInfo"] = [];
      }

      var_2 = spawnStruct();
      var_4 = getarraykeys(level.operatorcustomization[var_1]);
      var_3 = scripts\engine\utility::random(var_4);
      var_2.operatorref = var_3;
      var_5 = getarraykeys(level.operatorcustomization[var_1][var_3]);
      var_6 = scripts\engine\utility::random(var_5);
      var_2.ref_12137 = int(tablelookup("operatorskins.csv", 1, var_6, 0));
      self.pers["restrictedOperatorInfo"][var_1] = var_2;
    }
  } else {
    var_3 = respawntokenenabled(var_3);
  }

  return var_3;
}

function restart_watcher(var_0) {
  if(getlocalestructarray()) {
    if(isDefined(self.pers["restrictedOperatorInfo"])) {
      var_1 = getoperatorteambyref(var_0);
      var_2 = self.pers["restrictedOperatorInfo"][var_1];

      if(isDefined(var_2)) {
        return var_2.ref_12137;
      }
    }
  }

  return self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", var_0, "skin");
}

function getlocalestructarray() {
  if(!isDefined(level.ref_12134)) {
    level.ref_12134 = spawnStruct();
    var_0 = getDvar("scr_operator_restrict_sources");
    level.ref_12134.sources = strtok(var_0, ",");

    if(scripts\mp\utility\game::getgametype() != "br") {
      level.ref_12134.sources = ["t9", "s4"];
    }

    level.ref_12134.enabled = !!level.ref_12134.sources.size;

    if(level.ref_12134.enabled) {
      level.ref_12134.use_emp_drone_func = [];
    }
  }

  return level.ref_12134.enabled;
}

function update_track_operational_status(var_0) {
  if(!getlocalestructarray()) {
    return 0;
  }

  var_1 = level.ref_12134.use_emp_drone_func[var_0];

  if(!isDefined(var_1)) {
    var_1 = 0;
    var_2 = resetsuper(var_0);

    foreach(var_4 in level.ref_12134.sources) {
      if(var_2 == var_4) {
        var_1 = 1;
        break;
      }
    }

    level.ref_12134.use_emp_drone_func[var_0] = var_1;
  }

  return var_1;
}

function lookupotheroperator(var_0) {
  if(!isPlayer(self) && !isai(self)) {
    return "";
  }

  var_1 = scripts\engine\utility::ter_op(var_0 == "allies", 1, 0);
  var_2 = self getentitynumber();
  var_3 = "";
  var_0 = scripts\engine\utility::ter_op(var_0 == "allies", "axis", "allies");

  if(level.gametype != "br") {
    if(level.teambased && !isai(self)) {
      if(!isDefined(level.playercustomizationdata[var_2][var_0])) {
        var_4 = spawnStruct();
        var_4.operatorref = respawntokendisabled(var_1);
        level.playercustomizationdata[var_2][var_0] = var_4;
      }

      var_3 = level.playercustomizationdata[var_2][var_0].operatorref;
    }
  }

  return var_3;
}

function lookupcurrentoperator(var_0) {
  if(!isPlayer(self) && !isai(self)) {
    return "";
  }

  var_1 = scripts\engine\utility::ter_op(var_0 == "allies", 0, 1);
  var_2 = scripts\mp\utility\game::getgametype() == "br" || scripts\mp\utility\game::getgametype() == "brtdm";

  if(!level.teambased || var_2) {
    var_3 = undefined;

    if(isai(self)) {
      var_3 = self.botoperatorteam;
    } else {
      var_3 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "selectedOperatorIndex");
    }

    var_1 = var_3;

    if(!isai(self) && !isDefined(self.defaultoperatorteam)) {
      if(var_1 == 0) {
        self.defaultoperatorteam = "allies";
      } else {
        self.defaultoperatorteam = "axis";
      }
    }
  }

  if(!isDefined(level.playercustomizationdata)) {
    level.playercustomizationdata = [];
  }

  var_4 = self getentitynumber();

  if(!isDefined(level.playercustomizationdata[var_4])) {
    level.playercustomizationdata[var_4] = [];
  }

  var_5 = undefined;

  if(level.gametype == "infect" && var_0 == "axis") {
    var_6 = spawnStruct();
    var_6.operatorref = "kreuger_eastern";
    level.playercustomizationdata[var_4][var_0] = var_6;
  } else if(!isDefined(level.playercustomizationdata[var_4][var_0])) {
    var_6 = spawnStruct();

    if(isai(self)) {
      var_6.operatorref = self.botoperatorref;
    } else {
      var_6.operatorref = respawntokendisabled(var_1);
    }

    level.playercustomizationdata[var_4][var_0] = var_6;
  }

  var_5 = level.playercustomizationdata[var_4][var_0].operatorref;

  if(getdvarint("scr_forceHeadlessCustomization", 1) == 1 && !isagent(self) && self calloutmarkerping_getEnt()) {
    var_7 = getarraykeys(level.operatorcustomization);

    if(!isDefined(self.showempminimap)) {
      foreach(var_9 in var_7) {
        var_10 = getarraykeys(level.operatorcustomization[var_9]);

        if(!isDefined(level.showing_ui_record)) {
          level.showing_ui_record = [];
        }

        if(!isDefined(level.showing_ui_record[var_9]) || level.showing_ui_record[var_9] > var_10.size) {
          level.showing_ui_record[var_9] = 0;
        }

        for(var_11 = var_10[level.showing_ui_record[var_9]]; isDefined(var_11) && (var_11 == "default_western" || var_11 == "default_eastern"); var_11 = var_10[level.showing_ui_record[var_9]]) {
          level.showing_ui_record[var_9] += 1;

          if(level.showing_ui_record[var_9] > var_10.size) {
            level.showing_ui_record[var_9] = 0;
          }
        }

        level.showing_ui_record[var_9] += 1;
        level.playercustomizationdata[var_4][var_9] = spawnStruct();
        level.playercustomizationdata[var_4][var_9].operatorref = var_11;
      }

      self.showempminimap = 1;
    }

    if(isDefined(level.operatorcustomization[var_0])) {
      var_5 = level.playercustomizationdata[var_4][var_0].operatorref;
    } else {
      if(!isDefined(self.botoperatorteam)) {
        self.botoperatorteam = scripts\engine\utility::random(var_7);
      }

      if(getdvarint("scr_log_headless_customization", 0) == 1) {
        logprint("name= " + self.name);
        logprint("clientNum = " + var_4);
        logprint("botOperatorTeam = " + self.botoperatorteam);
        logprint("operatorRef = " + var_5);
      }

      if(isDefined(level.playercustomizationdata[var_4][self.botoperatorteam])) {
        var_5 = level.playercustomizationdata[var_4][self.botoperatorteam].operatorref;
      }
    }
  }

  if(isai(self) || !isDefined(var_5) || var_5 == "") {
    if(isai(self)) {
      if(isDefined(self.botoperatorref)) {
        if(isDefined(level.playercustomizationdata[var_4][var_0].operatorref)) {
          var_5 = level.playercustomizationdata[var_4][var_0].operatorref;
        } else {
          var_5 = self.botoperatorref;
        }
      } else {
        initoperatorcustomization();

        if(!isDefined(self.botoperatorteam)) {
          self.botoperatorteam = self.team;

          if(!isDefined(level.operatorcustomization[self.botoperatorteam])) {
            var_7 = getarraykeys(level.operatorcustomization);
            self.botoperatorteam = scripts\engine\utility::random(var_7);
          }
        }

        var_0 = self.botoperatorteam;
        var_3 = undefined;

        if(!isDefined(self.pers["operatorIndex"])) {
          if(getdvarint("scr_forceBotCustomization", 1) == 1) {
            var_3 = randomint(level.operatorcustomization[var_0].size);
            self.pers["operatorIndex"] = var_3;
          } else {
            var_13 = 0;

            foreach(var_16, var_15 in level.operatorcustomization[var_0]) {
              if(issubstr(var_16, "default")) {
                var_3 = var_13;
                self.pers["operatorIndex"] = var_13;
                self.botoperatorref = var_16;
                var_5 = var_16;
                break;
              }

              var_13++;
            }
          }
        } else {
          var_3 = self.pers["operatorIndex"];
        }

        if(!isDefined(self.botoperatorref)) {
          var_13 = 0;

          foreach(var_16, var_15 in level.operatorcustomization[var_0]) {
            if(var_13 == var_3) {
              self.botoperatorref = var_16;
              var_5 = var_16;
              break;
            }

            var_13++;
          }
        }
      }
    } else {
      var_5 = "wyatt_western";
    }
  }

  return var_5;
}

function lookupcurrentoperatorskin(var_0) {
  var_1 = lookupcurrentoperator(var_0);
  var_2 = undefined;
  var_3 = self getentitynumber();

  if(scripts\mp\utility\game::getgametype() == "infect" && var_0 == "axis") {
    var_4 = spawnStruct();
    var_4.operatorref = "kreuger_eastern";
    level.playercustomizationdata[var_3][var_0] = var_4;
    self.pers["operatorSkinIndex"] = 218;
    var_2 = 218;
  } else {
    if(getdvarint("scr_forceHeadlessCustomization", 1) == 1 && !isagent(self) && self calloutmarkerping_getEnt()) {
      if(!isDefined(level.playercustomizationdata[var_3][var_0].operatorskinindex)) {
        if(!isDefined(level.showing_bomb_wire_pair_to_player)) {
          thermite_doradiusdamage();
        }

        var_5 = level.showing_bomb_wire_pair_to_player[var_1]["curIndex"];
        level.playercustomizationdata[var_3][var_0].operatorskinindex = level.showing_bomb_wire_pair_to_player[var_1]["lootIDs"][var_5];
        level.showing_bomb_wire_pair_to_player[var_1]["curIndex"] = level.showing_bomb_wire_pair_to_player[var_1]["curIndex"] + 1;

        if(level.showing_bomb_wire_pair_to_player[var_1]["curIndex"] >= level.showing_bomb_wire_pair_to_player[var_1]["maxIndex"]) {
          level.showing_bomb_wire_pair_to_player[var_1]["curIndex"] = 0;
        }
      }
    } else if(!isDefined(level.playercustomizationdata[var_3][var_0].operatorskinindex)) {
      if(isai(self)) {
        if(!isDefined(self.botskinid)) {
          debug_interaction_toggle(var_1);
        }

        level.playercustomizationdata[var_3][var_0].operatorskinindex = self.botskinid;
      } else {
        level.playercustomizationdata[var_3][var_0].operatorskinindex = restart_watcher(var_1);
      }
    }

    var_2 = level.playercustomizationdata[var_3][var_0].operatorskinindex;

    if(isai(self) && (!isDefined(var_2) || var_2 == 0) || !isDefined(var_2) || var_2 == 0) {
      if(isai(self)) {
        if(isDefined(self.botskinid)) {
          var_2 = self.botskinid;
        } else {
          debug_interaction_toggle(var_1);
        }
      } else {
        var_2 = 1;
      }
    }
  }

  return var_2;
}

function debug_interaction_toggle(var_0) {
  var_1 = self.team;

  if(isDefined(self.botoperatorteam)) {
    var_1 = self.botoperatorteam;
  }

  if(!isDefined(self.pers["operatorSkinIndex"])) {
    var_2 = randomint(level.operatorcustomization[var_1][var_0].size);
    self.pers["operatorSkinIndex"] = var_2;
  } else {
    var_2 = self.pers["operatorSkinIndex"];
  }

  var_3 = 0;

  foreach(var_5 in level.operatorcustomization[var_2][var_1]) {
    if(var_3 == var_2) {
      var_6 = int(tablelookup("operatorskins.csv", 1, var_8, 0));
      self.botskinid = var_6;
      var_7 = var_6;
      break;
    }

    var_3++;
  }
}

function picklaunchchunkoperatorskin(var_0) {
  if(!isDefined(level.launchchunkskins)) {
    level.launchchunkskins = [];
    level.launchchunkskins["allies"] = 0;
    level.launchchunkskins["axis"] = 0;
  }

  if(!isDefined(self.launchchunkcustomizationindex)) {
    if(level.launchchunkskins[var_0] == 2) {
      level.launchchunkskins[var_0] = 0;
    }

    self.launchchunkcustomizationindex = level.launchchunkskins[var_0];
    level.launchchunkskins[var_0]++;
  }

  return self.launchchunkcustomizationindex;
}

function getoperatorcustomization() {
  var_0 = lookupcurrentoperator(self.team);
  var_1 = lookupcurrentoperatorskin(self.team);

  if(isDefined(level.ref_11C6A)) {
    var_2 = [[level.ref_11C6A]](self, var_0, var_1);
    var_0 = var_2[0];
    var_1 = var_2[1];
    var_2 = undefined;
  }

  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(istrue(game["isLaunchChunk"])) {
    initlaunchchunkoperatorskins();

    if(!isDefined(self.pers["defaultOperatorSkinIndex"])) {
      self.pers["defaultOperatorSkinIndex"] = picklaunchchunkoperatorskin(self.team);
    }

    var_3 = level.defaultoperatorskins[self.team]["body"][self.pers["defaultOperatorSkinIndex"]];
    var_4 = level.defaultoperatorskins[self.team]["head"][self.pers["defaultOperatorSkinIndex"]];
    var_5 = level.defaultoperatorskins[self.team]["suit"][0];
    var_6 = [];
    GscBinSkip0(0x2e, 0, var_3);
  }

  if((var_1 == "default_western" || var_1 == "default_eastern") && (var_3 == 274 || var_3 == 275)) {
    initdefaultoperatorskins();
    var_7 = level.teambased && scripts\mp\utility\game::getgametype() != "br";

    if(!isDefined(self.defaultoperatorteam) || var_7 && self.defaultoperatorteam != self.team && (self.team == "allies" || self.team == "axis")) {
      self.defaultoperatorteam = self.team;

      if(self.team != "allies" && self.team != "axis") {
        self.defaultoperatorteam = scripts\engine\utility::ter_op(scripts\engine\utility::cointoss(), "allies", "axis");
      }
    }

    if(!isDefined(self.pers["defaultOperatorSkinIndex"])) {
      self.pers["defaultOperatorSkinIndex"] = 0;
    }

    var_8 = self.defaultoperatorteam;
    var_9 = scripts\mp\utility\game::getgametype() == "br" || scripts\mp\utility\game::getgametype() == "brtdm";

    if(var_9) {
      if(var_1 == "default_western") {
        var_8 = "allies";
      } else {
        var_8 = "axis";
      }
    }

    var_10 = self.pers["defaultOperatorSkinIndex"];
    var_4 = level.defaultoperatorskins[var_8]["body"][var_10];
    var_11 = level.defaultoperatorskins[var_8]["head"][var_10];

    if(!isDefined(self.pers["defaultOperatorHeadIndex"])) {
      self.pers["defaultOperatorHeadIndex"] = randomint(var_11.size);
    }

    var_12 = self.pers["defaultOperatorHeadIndex"];

    if(var_12 >= var_11.size) {
      var_12 = 0;
    }

    var_5 = var_11[var_12];
    var_6 = "iw8_suit_mp_wyatt";
  } else {
    var_4 = tablelookup("operatorskins.csv", 0, var_3, 4);
    var_5 = tablelookup("operatorskins.csv", 0, var_3, 5);
    var_6 = tablelookup("operators.csv", 1, var_1, 19);
  }

  self.bodymodelname = var_4;
  self.backuphead = var_5;
  self.backupsuit = var_6;
  var_6 = [];
  GscBinSkip0(0x2e, 0, var_4);
}

function initlaunchchunkoperatorskins() {
  if(isDefined(level.defaultoperatorskins)) {
    return;
  }

  level.defaultoperatorskins = [];
  level.defaultoperatorskins["allies"] = [];
  level.defaultoperatorskins["allies"]["body"] = ["body_mp_western_fireteam_west_dmr_1_1_lod1", "body_mp_western_fireteam_west_ar_1_1_lod1"];
  level.defaultoperatorskins["allies"]["head"] = ["head_mp_western_fireteam_west_dmr_2_1", "head_mp_western_fireteam_west_ar_1_1"];
  level.defaultoperatorskins["allies"]["suit"] = ["iw8_suit_mp_wyatt"];
  level.defaultoperatorskins["axis"] = [];
  level.defaultoperatorskins["axis"]["body"] = ["body_mp_eastern_fireteam_east_ar_lod1", "body_mp_eastern_fireteam_east_lmg_lod1"];
  level.defaultoperatorskins["axis"]["head"] = ["head_mp_eastern_fireteam_east_ar_2", "head_mp_eastern_fireteam_east_lmg"];
  level.defaultoperatorskins["axis"]["suit"] = ["iw8_suit_mp_wyatt"];
}

function initdefaultoperatorskins() {
  if(isDefined(level.defaultoperatorskins)) {
    return;
  }

  level.defaultoperatorskins = [];
  level.defaultoperatorskins["allies"] = [];
  level.defaultoperatorskins["axis"] = [];

  switch (game["allies_outfit"]) {
    case "urban":
      level.defaultoperatorskins["allies"]["body"] = ["body_mp_western_fireteam_west_ar_1_1_lod1", "body_mp_western_fireteam_west_smg_1_1_lod1", "body_mp_western_fireteam_west_dmr_1_1_lod1", "body_mp_western_fireteam_west_lmg_1_1_lod1", "body_mp_western_fireteam_west_sg_1_1_lod1"];
      level.defaultoperatorskins["allies"]["head"][0] = ["head_mp_western_fireteam_west_ar_1_1", "head_mp_western_fireteam_west_ar_2_1"];
      level.defaultoperatorskins["allies"]["head"][1] = ["head_mp_western_fireteam_west_smg_1_1", "head_mp_western_fireteam_west_smg_2_1"];
      level.defaultoperatorskins["allies"]["head"][2] = ["head_mp_western_fireteam_west_dmr_1_1", "head_mp_western_fireteam_west_dmr_2_1"];
      level.defaultoperatorskins["allies"]["head"][3] = ["head_mp_western_fireteam_west_lmg_1_1", "head_mp_western_fireteam_west_lmg_2_1"];
      level.defaultoperatorskins["allies"]["head"][4] = ["head_mp_western_fireteam_west_sg_1_1", "head_mp_western_fireteam_west_sg_2_1"];
      break;
    case "desert":
      level.defaultoperatorskins["allies"]["body"] = ["body_mp_western_fireteam_west_ar_1_2_lod1", "body_mp_western_fireteam_west_smg_1_2_lod1", "body_mp_western_fireteam_west_dmr_1_2_lod1", "body_mp_western_fireteam_west_lmg_1_2_lod1", "body_mp_western_fireteam_west_sg_1_2_lod1"];
      level.defaultoperatorskins["allies"]["head"][0] = ["head_mp_western_fireteam_west_ar_1_2", "head_mp_western_fireteam_west_ar_2_2"];
      level.defaultoperatorskins["allies"]["head"][1] = ["head_mp_western_fireteam_west_smg_1_2", "head_mp_western_fireteam_west_smg_2_2"];
      level.defaultoperatorskins["allies"]["head"][2] = ["head_mp_western_fireteam_west_dmr_1_2", "head_mp_western_fireteam_west_dmr_2_2"];
      level.defaultoperatorskins["allies"]["head"][3] = ["head_mp_western_fireteam_west_lmg_1_2", "head_mp_western_fireteam_west_lmg_2_2"];
      level.defaultoperatorskins["allies"]["head"][4] = ["head_mp_western_fireteam_west_sg_1_2", "head_mp_western_fireteam_west_sg_2_2"];
      break;
    case "woodland":
      level.defaultoperatorskins["allies"]["body"] = ["body_mp_western_fireteam_west_ar_1_3_lod1", "body_mp_western_fireteam_west_smg_1_3_lod1", "body_mp_western_fireteam_west_dmr_1_3_lod1", "body_mp_western_fireteam_west_lmg_1_3_lod1", "body_mp_western_fireteam_west_sg_1_3_lod1"];
      level.defaultoperatorskins["allies"]["head"][0] = ["head_mp_western_fireteam_west_ar_1_3", "head_mp_western_fireteam_west_ar_2_3"];
      level.defaultoperatorskins["allies"]["head"][1] = ["head_mp_western_fireteam_west_smg_1_3", "head_mp_western_fireteam_west_smg_2_3"];
      level.defaultoperatorskins["allies"]["head"][2] = ["head_mp_western_fireteam_west_dmr_1_3", "head_mp_western_fireteam_west_dmr_2_3"];
      level.defaultoperatorskins["allies"]["head"][3] = ["head_mp_western_fireteam_west_lmg_1_3", "head_mp_western_fireteam_west_lmg_2_3"];
      level.defaultoperatorskins["allies"]["head"][4] = ["head_mp_western_fireteam_west_sg_1_3", "head_mp_western_fireteam_west_sg_2_3"];
      break;
    default:
      level.defaultoperatorskins["allies"]["body"] = ["body_mp_western_fireteam_west_ar_1_1_lod1", "body_mp_western_fireteam_west_smg_1_1_lod1", "body_mp_western_fireteam_west_dmr_1_1_lod1", "body_mp_western_fireteam_west_lmg_1_1_lod1", "body_mp_western_fireteam_west_sg_1_1_lod1"];
      level.defaultoperatorskins["allies"]["head"][0] = ["head_mp_western_fireteam_west_ar_1_1", "head_mp_western_fireteam_west_ar_2_1"];
      level.defaultoperatorskins["allies"]["head"][1] = ["head_mp_western_fireteam_west_smg_1_1", "head_mp_western_fireteam_west_smg_2_1"];
      level.defaultoperatorskins["allies"]["head"][2] = ["head_mp_western_fireteam_west_dmr_1_1", "head_mp_western_fireteam_west_dmr_2_1"];
      level.defaultoperatorskins["allies"]["head"][3] = ["head_mp_western_fireteam_west_lmg_1_1", "head_mp_western_fireteam_west_lmg_2_1"];
      level.defaultoperatorskins["allies"]["head"][4] = ["head_mp_western_fireteam_west_sg_1_1", "head_mp_western_fireteam_west_sg_2_1"];
      break;
  }

  switch (game["axis_outfit"]) {
    case "urban":
      level.defaultoperatorskins["axis"]["body"] = ["body_mp_eastern_fireteam_east_ar_lod1", "body_mp_eastern_fireteam_east_smg_lod1", "body_mp_eastern_fireteam_east_dmr_lod1", "body_mp_eastern_fireteam_east_lmg_lod1", "body_mp_eastern_fireteam_east_sg_lod1"];
      level.defaultoperatorskins["axis"]["head"][0] = ["head_mp_eastern_fireteam_east_ar_1", "head_mp_eastern_fireteam_east_ar_2", "head_mp_eastern_fireteam_east_ar_3", "head_mp_eastern_fireteam_east_ar_4"];
      level.defaultoperatorskins["axis"]["head"][1] = ["head_mp_eastern_fireteam_east_smg_1", "head_mp_eastern_fireteam_east_smg_2", "head_mp_eastern_fireteam_east_smg_3"];
      level.defaultoperatorskins["axis"]["head"][2] = ["head_mp_eastern_fireteam_east_dmr"];
      level.defaultoperatorskins["axis"]["head"][3] = ["head_mp_eastern_fireteam_east_lmg"];
      level.defaultoperatorskins["axis"]["head"][4] = ["head_mp_eastern_fireteam_east_sg"];
      break;
    case "desert":
      level.defaultoperatorskins["axis"]["body"] = ["body_mp_eastern_fireteam_east_ar_2_lod1", "body_mp_eastern_fireteam_east_smg_2_lod1", "body_mp_eastern_fireteam_east_dmr_2_lod1", "body_mp_eastern_fireteam_east_lmg_2_lod1", "body_mp_eastern_fireteam_east_sg_2_lod1"];
      level.defaultoperatorskins["axis"]["head"][0] = ["head_mp_eastern_fireteam_east_ar_1_2", "head_mp_eastern_fireteam_east_ar_2_2", "head_mp_eastern_fireteam_east_ar_3_2", "head_mp_eastern_fireteam_east_ar_4_2"];
      level.defaultoperatorskins["axis"]["head"][1] = ["head_mp_eastern_fireteam_east_smg_1_2", "head_mp_eastern_fireteam_east_smg_2_2", "head_mp_eastern_fireteam_east_smg_3_2"];
      level.defaultoperatorskins["axis"]["head"][2] = ["head_mp_eastern_fireteam_east_dmr"];
      level.defaultoperatorskins["axis"]["head"][3] = ["head_mp_eastern_fireteam_east_lmg"];
      level.defaultoperatorskins["axis"]["head"][4] = ["head_mp_eastern_fireteam_east_sg"];
      break;
    case "woodland":
      level.defaultoperatorskins["axis"]["body"] = ["body_mp_eastern_fireteam_east_ar_3_lod1", "body_mp_eastern_fireteam_east_smg_3_lod1", "body_mp_eastern_fireteam_east_dmr_3_lod1", "body_mp_eastern_fireteam_east_lmg_3_lod1", "body_mp_eastern_fireteam_east_sg_3_lod1"];
      level.defaultoperatorskins["axis"]["head"][0] = ["head_mp_eastern_fireteam_east_ar_1_3", "head_mp_eastern_fireteam_east_ar_2_3", "head_mp_eastern_fireteam_east_ar_3_3", "head_mp_eastern_fireteam_east_ar_4_3"];
      level.defaultoperatorskins["axis"]["head"][1] = ["head_mp_eastern_fireteam_east_smg_1_3", "head_mp_eastern_fireteam_east_smg_2_3", "head_mp_eastern_fireteam_east_smg_3_3"];
      level.defaultoperatorskins["axis"]["head"][2] = ["head_mp_eastern_fireteam_east_dmr"];
      level.defaultoperatorskins["axis"]["head"][3] = ["head_mp_eastern_fireteam_east_lmg"];
      level.defaultoperatorskins["axis"]["head"][4] = ["head_mp_eastern_fireteam_east_sg"];
      break;
    default:
      level.defaultoperatorskins["axis"]["body"] = ["body_mp_eastern_fireteam_east_ar_lod1", "body_mp_eastern_fireteam_east_smg_lod1", "body_mp_eastern_fireteam_east_dmr_lod1", "body_mp_eastern_fireteam_east_lmg_lod1", "body_mp_eastern_fireteam_east_sg_lod1"];
      level.defaultoperatorskins["axis"]["head"][0] = ["head_mp_eastern_fireteam_east_ar_1", "head_mp_eastern_fireteam_east_ar_2", "head_mp_eastern_fireteam_east_ar_3", "head_mp_eastern_fireteam_east_ar_4"];
      level.defaultoperatorskins["axis"]["head"][1] = ["head_mp_eastern_fireteam_east_smg_1", "head_mp_eastern_fireteam_east_smg_2", "head_mp_eastern_fireteam_east_smg_3"];
      level.defaultoperatorskins["axis"]["head"][2] = ["head_mp_eastern_fireteam_east_dmr"];
      level.defaultoperatorskins["axis"]["head"][3] = ["head_mp_eastern_fireteam_east_lmg"];
      level.defaultoperatorskins["axis"]["head"][4] = ["head_mp_eastern_fireteam_east_sg"];
      break;
  }
}

function pickdefaultoperatorskin(var_0) {
  var_1 = 0;

  if(isDefined(var_0)) {
    var_2 = scripts\mp\utility\weapon::getweapongroup(var_0);

    switch (var_2) {
      case "weapon_assault":
      case "weapon_tactical":
        var_1 = 0;
        break;
      case "weapon_smg":
        var_1 = 1;
        break;
      case "weapon_dmr":
      case "weapon_sniper":
        var_1 = 2;
        break;
      case "weapon_lmg":
        var_1 = 3;
        break;
      case "weapon_shotgun":
        var_1 = 4;
        break;
      default:
        var_1 = 1;
        break;
    }
  }

  return var_1;
}

function getglcustomization() {
  var_0 = self.primaryweapon;
  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);
  var_2 = self.loadoutequipmentprimary;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(var_2 == "equip_helmet") {
    var_5 = "_blstk";
  } else {
    var_5 = "";
  }

  switch (self.team) {
    case "allies":
      var_6 = "usmc";

      if(scripts\mp\flags::gameflag("infil_will_run") && !scripts\mp\flags::gameflag("prematch_done")) {
        var_7 = "_wind";
      } else {
        var_7 = "";
      }

      switch (var_2) {
        case "weapon_shotgun":
        case "weapon_smg":
          var_4 = "_cqc";
          var_5 = "_cqc";
          break;
        case "weapon_assault":
        case "weapon_tactical":
          var_4 = "_ar";
          var_5 = "_ar";
          break;
        case "weapon_lmg":
          var_4 = "_ar";
          var_5 = "_lmg";
          break;
        case "weapon_dmr":
        case "weapon_sniper":
          var_4 = "_cqc";
          var_5 = "_cqc";
          break;
        default:
          var_4 = "_ar";
          var_5 = "_ar";
          break;
      }

      break;
    case "axis":
      var_6 = "sa_militia";
      var_7 = "";

      switch (var_4) {
        case "weapon_shotgun":
        case "weapon_smg":
          var_6 = "_cqc";
          var_7 = "_cqc";
          break;
        case "weapon_assault":
        case "weapon_tactical":
          var_6 = "_ar";
          var_7 = "_ar";
          break;
        case "weapon_lmg":
          var_6 = "_lmg";
          var_7 = "_lmg";
          break;
        case "weapon_dmr":
        case "weapon_sniper":
          var_6 = "_ar";
          var_7 = "_ar";
          break;
        default:
          var_6 = "_ar";
          var_7 = "_ar";
          break;
      }

      break;
    default:
      var_6 = "usmc";
      var_7 = "";
      var_7 = "_ar";
      var_6 = "_ar";
      break;
  }

  var_8 = "body_" + var_6 + var_7 + var_7;
  var_9 = "head_" + var_6 + var_6 + var_7;
  self.backuphead = "head_" + var_6 + var_6;
  self.bodymodelname = "body_" + var_6 + var_7;
  var_10 = [];
  GscBinSkip0(0x2e, 0, var_8);
}

function getglcustomizationhackney() {
  var_0 = self.primaryweapon;
  var_1 = scripts\mp\utility\weapon::getweapongroup(var_0);
  var_2 = self.loadoutequipmentprimary;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(var_2 == "equip_helmet") {
    var_5 = "_blstk";
  } else {
    var_5 = "";
  }

  switch (self.team) {
    case "allies":
      var_6 = "sas_urban";

      if(scripts\mp\flags::gameflag("infil_will_run") && !scripts\mp\flags::gameflag("prematch_done")) {
        var_7 = "";
      } else {
        var_7 = "_rain";
      }

      switch (var_2) {
        case "weapon_shotgun":
        case "weapon_smg":
          var_4 = "_cqc";
          var_5 = "_mp_cqc";
          break;
        case "weapon_assault":
        case "weapon_tactical":
          var_4 = "_ar";
          var_5 = "_ar";
          break;
        case "weapon_lmg":
          var_4 = "_lmg";
          var_5 = "_lmg";
          break;
        case "weapon_dmr":
        case "weapon_sniper":
          var_4 = "_dmr";
          var_5 = "_mp_dmr";
          break;
        default:
          var_4 = "_ar";
          var_5 = "_ar";
          break;
      }

      break;
    case "axis":
      var_6 = "al_qatala";
      var_7 = "";

      switch (var_4) {
        case "weapon_shotgun":
        case "weapon_lmg":
        case "weapon_dmr":
        case "weapon_sniper":
        case "weapon_assault":
        case "weapon_smg":
        case "weapon_tactical":
          var_6 = "_1_ar";
          var_7 = "_ar";
          break;
        default:
          var_6 = "_1_ar";
          var_7 = "_ar";
          break;
      }

      break;
    default:
      var_6 = "usmc";
      var_7 = "";
      var_7 = "_ar";
      var_6 = "_ar";
      break;
  }

  var_8 = "body_" + var_6 + var_7 + var_7;
  var_9 = "head_" + var_6 + var_6 + var_7;
  self.backuphead = "head_" + var_6 + var_6;
  self.bodymodelname = "body_" + var_6 + var_7;
  var_10 = [];
  GscBinSkip0(0x2e, 0, var_8);
}

function forcedefaultmodel() {
  if(self.team == "axis") {
    self setModel("mp_fullbody_heavy");
    self setviewmodel("viewmodel_mp_base_iw8");
  } else {
    self setModel("mp_body_infected_a");
    self setviewmodel("viewmodel_mp_base_iw8");
  }

  if(isDefined(self.headmodel)) {
    self detach(self.headmodel, "");
    self.headmodel = undefined;
  }

  self attach("head_mp_infected", "", 1);
  self.headmodel = "head_mp_infected";
  self setclothtype("cloth");
}

function watchafk() {
  if(getdvarint("debug_stopAFKCheck", 0) == 1) {
    return;
  }

  scripts\mp\flags::gameflagwait("prematch_done");
  var_0 = 0;

  for(;;) {
    var_0++;

    if(var_0 >= level.players.size) {
      var_0 = 0;
    }

    if(isDefined(level.players[var_0])) {
      if(isai(level.players[var_0])) {
        waitframe();
        continue;
      }

      checkforafk(level.players[var_0]);
    }

    waitframe();
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

function checkforafk() {
  if(istrue(level.gameended) || !istrue(self.hasspawned)) {
    return;
  }

  var_0 = 0;
  var_1 = scripts\mp\persistence::statgetchildbuffered("round", "timePlayed", 0);
  var_1 = int(max(var_1 - self.timeplayed["timeDead"], 0));

  if(istrue(self.elevator_manager)) {
    return;
  }

  if(scripts\mp\utility\game::getgametype() == "br") {
    if(self.sessionstate == "spectator" || self.sessionstate == "intermission") {
      return;
    }

    if(scripts\mp\gametypes\br_public::isplayeringulag()) {
      return;
    }

    if(scripts\mp\utility\game::round_vehicle_logic() == "truckwar") {
      if(isDefined(self.vehicle) && self.vehicle.vehiclename == "cargo_truck_mg") {
        var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getseatoccupant(self.vehicle, "gunner");

        if(isDefined(var_2) && var_2 == self) {
          return;
        }
      }
    }

    if(istrue(self.txt_nag)) {
      return;
    }

    var_1 -= self.timeplayed["gulag"];
    var_1 -= self.timeplayed["rebirthRespawn"];
  }

  if(istrue(self.shoulddeleteimmediately)) {
    return;
  }

  if(!isDefined(self.timeplayedonfirstspawn)) {
    return;
  }

  var_3 = self.timeplayedonfirstspawn;
  var_4 = self.pers["kills"];
  var_5 = self.pers["assists"];
  var_6 = self.pers["downs"];
  var_7 = var_4 == 0 && var_5 == 0 && (!isDefined(var_6) || isDefined(var_6) && var_6 == 0);
  var_8 = isDefined(self.lastdamagetime) && self.lastdamagetime + 60000 > gettime();
  var_9 = var_1 - var_3;
  var_9 -= self.pers["afkResetTime"];
  var_10 = 60;

  if(scripts\mp\utility\game::getgametype() == "arena") {
    var_10 = 15;
  }

  var_11 = getdvarfloat("scr_afkDistTimeOverride", 0);

  if(scripts\mp\utility\game::getgametype() == "br" && istrue(self.display_hint_for_player_single)) {
    self.display_hint_for_player_single = undefined;
    var_10 = 30;
  } else if(var_11 > 0) {
    var_10 = var_11;
  }

  if(scripts\mp\utility\game::isroundbased() && scripts\mp\utility\game::getgametype() != "ctf") {
    var_12 = var_7 || level.gametype == "arena";

    if(level.gametype != "arena") {
      if(var_7 && var_9 > 120) {
        if(!var_8) {
          switch (level.gametype) {
            case "gun":
              if(istrue(level.kick_afk_check)) {
                var_0 = 1;
              }

              break;
          }
        }
      }
    }

    if(var_12 && !isDefined(self.pers["distTrackingPassed"]) && var_9 >= var_10) {
      if(scripts\mp\utility\game::getgametype() == "infect") {
        if(self.team == "axis") {
          var_0 = 1;
        }
      } else if(!isDefined(self.laststancechangetime) || gettime() - self.laststancechangetime > 11000) {
        var_0 = 1;
      }
    }

    if(!isDefined(self.pers["roundsAFK"])) {
      self.pers["roundsAFK"] = 0;
    }

    if(var_0 && !isgamebattlematch() && !istrue(self.binoculars_onstatemarkedexit)) {
      self.binoculars_onstatemarkedexit = 1;
      self.pers["roundsAFK"]++;

      if(scripts\mp\utility\game::getgametype() == "br" || self.pers["roundsAFK"] > 1) {
        thread vehomn_controlsarefadedoutorhidden(level);
      }
    }

    return;
  } else {
    if(var_8 && !var_9 && var_10 >= var_11) {
      if(!isDefined(self.pers["distTrackingPassed"])) {
        if(scripts\mp\utility\game::getgametype() == "infect") {
          if(self.team == "axis") {
            var_1 = 1;
          }
        } else {
          var_1 = 1;
        }
      }
    }

    if(var_8 && var_10 > 120) {
      if(!var_9) {
        switch (level.gametype) {
          case "gun":
            if(istrue(level.kick_afk_check)) {
              var_1 = 1;
            }

            break;
        }
      }
    }
  }

  if(var_1 && !isgamebattlematch()) {
    thread vehomn_controlsarefadedoutorhidden(level);
    return;
  }
}

function vehomn_controlsarefadedoutorhidden(var_0) {
  var_0 endon("disconnect");
  var_0 notify("afk_disconnection_imminent");
  wait 1;
  kick(var_0 getentitynumber(), "EXE/PLAYERKICKED_INACTIVE", 1);
}

function getjointeampermissions(var_0) {
  var_1 = 0;
  var_2 = 0;
  var_3 = level.players;

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_3[var_4];

    if(isDefined(var_5.pers["team"]) && var_5.pers["team"] == var_0) {
      var_1++;

      if(isbot(var_5)) {
        var_2++;
      }
    }
  }

  if(level.maxteamsize == 0 || var_1 < level.maxteamsize) {
    return 1;
  }

  if(scripts\mp\utility\game::getgametype() == "vip" && istrue(isagent(self))) {
    return 1;
  }

  if(var_2 > 0) {
    return 1;
  }

  if(!scripts\mp\utility\game::matchmakinggame()) {
    return 1;
  }

  if(scripts\mp\utility\game::getgametype() == "infect") {
    return 1;
  }

  if(scripts\mp\menus::brking_updateteamscore()) {
    return 1;
  }

  if(scripts\mp\utility\game::getgametype() == "br" && (getDvar("scr_br_gametype", "") == "dmz" || getDvar("scr_br_gametype", "") == "rat_race" || getDvar("scr_br_gametype", "") == "risk") || getDvar("scr_br_gametype", "") == "gold_war") {
    return 1;
  }

  getentitylessscriptablearray("mp_exceeded_team_max_error", ["player_xuid", self getxuid(), "isHost", self ishost()]);

  if(self ishost()) {
    wait 1.5;
  }

  kick(self getentitynumber(), "EXE/PLAYERKICKED_INVALIDTEAM");
  return 0;
}

function onplayerspawned() {
  if(!isDefined(self.timeplayedonfirstspawn)) {
    self.timeplayedonfirstspawn = scripts\mp\persistence::statgetchildbuffered("round", "timePlayed");
  }

  if(getdvarint("scr_team_outlines", 0) == 1 && !scripts\mp\utility\game::runleanthreadmode()) {
    if(scripts\mp\utility\game::issquadmode()) {
      thread outlinesquad_apply();
      return;
    }

    thread outlinefriendly_apply();
    return;
  }
}

function outlinefriendly_apply() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(!level.teambased) {
    return;
  }

  if(getdvarint("scr_friendly_outlines", 1) == 0) {
    return;
  }

  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    return;
  }

  if(scripts\mp\flags::gameflag("infil_will_run") && !istrue(scripts\mp\flags::gameflag("prematch_done"))) {
    level waittill("prematch_over");
  }

  var_0 = scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::isnightmap(), "outline_ally_night", "outline_ally");
  var_1 = scripts\mp\utility\outline::outlineenableforteam(self, self.team, var_0, "level_script");
  thread outlinefriendly_remove(var_1);
}

function outlinefriendly_remove(var_0) {
  level endon("game_ended");
  scripts\engine\utility::ref_143A5("death_or_disconnect", "joined_team");
  scripts\mp\utility\outline::outlinedisable(var_0, self);
}

function outlinesquad_apply() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(scripts\mp\utility\game::runleanthreadmode()) {
    return;
  }

  if(!level.teambased) {
    return;
  }

  if(getdvarint("scr_squad_outlines", 1) == 0) {
    return;
  }

  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    return;
  }

  if(scripts\mp\flags::gameflag("infil_will_run") && !istrue(scripts\mp\flags::gameflag("prematch_done"))) {
    level waittill("prematch_over");
  }

  var_0 = scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::isnightmap(), "outline_squad_night", "outline_squad");
  var_1 = scripts\mp\utility\outline::outlineenableforsquad(self, self.team, self.squadindex, var_0, "level_script");
  thread outlinesquad_remove(var_1);
}

function outlinesquad_remove(var_0) {
  level endon("game_ended");
  scripts\engine\utility::ref_143A6("death_or_disconnect", "joined_team", "joined_squad");
  scripts\mp\utility\outline::outlinedisable(var_0, self);
}

function resetsuper(var_0) {
  var_1 = scripts\engine\utility::multitablelookup(["mp/itemsourcetable.csv", "mp/itemsourcetable_ch2.csv"], 2, var_0, 3);

  if(!isDefined(var_1) || var_1 == "") {
    var_1 = "iw8";
  }

  return var_1;
}

function getoperatorexecution(var_0) {
  if(isDefined(self.executionref)) {
    self.loadoutexecution = self.executionref;
  } else {
    jumpiffalse(getdvarint("scr_forceHeadlessCustomization", 1) == 1 && !isagent(self) && self calloutmarkerping_getEnt() && level.gametype == "br") LOC_00000128;
    var_1 = getarraykeys(level.execution.table);

    if(!isDefined(self.headlessexecutionindex)) {
      if(!isDefined(level.headlessexecutionindex)) {
        var_2 = randomint(var_1.size);
        level.headlessexecutionindex = var_2;
        level.headlessexecutionsused = [];
      } else {
        for(var_3 = 0; var_3 < var_1.size; var_3++) {
          var_4 = var_1[level.headlessexecutionindex];
          var_5 = level.execution.table[var_4];

          if(isDefined(var_5) && isDefined(var_5.propweapon) && !scripts\engine\utility::array_contains(level.headlessexecutionsused, var_5.propweapon)) {
            level.headlessexecutionsused[level.headlessexecutionsused.size] = var_5.propweapon;
            break;
          }

          level.headlessexecutionindex++;

          if(level.headlessexecutionindex >= var_1.size) {
            level.headlessexecutionindex = 0;
          }
        }
      }

      self.headlessexecutionindex = level.headlessexecutionindex;
    }

    var_4 = var_1[self.headlessexecutionindex];
    self.loadoutexecution = var_4;
    goto LOC_0000018a;
  }

  return self.loadoutexecution;
}

function resetposition(var_0) {
  var_1 = 0;

  if(!isagent(self)) {
    var_1 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "operatorCustomization", var_0, "taunt");
  }

  if(var_1 == 0) {
    var_2 = tablelookup("operators.csv", 1, var_0, 23);
    self.ref_1195C = tablelookup("operatorquips.csv", 1, var_2, 6);
  } else {
    self.ref_1195C = tablelookup("operatorquips.csv", 0, var_1, 6);
  }

  return self.ref_1195C;
}

function resetscorefeedcontrolomnvar(var_0) {
  self.ref_1195D = tablelookup("mp_cp/executiontable.csv", 1, self.loadoutexecution, 19);
  return self.ref_1195D;
}

function getoperatorsuperfaction(var_0) {
  var_1 = tablelookup("operators.csv", 1, var_0, 3);
  return int(var_1);
}

function getoperatorvoice(var_0, var_1) {
  if(var_0 == "default_eastern" || var_0 == "default_western") {
    var_2 = tablelookup("operatorskins.csv", 0, var_1, 24);

    if(isDefined(var_2) && var_2 != "") {
      return var_2;
    }
  }

  var_2 = tablelookup("operators.csv", 1, var_0, 10);
  return var_2;
}

function resettimeronpickup(var_0) {
  if(isstartstr(var_0, "s4")) {
    return "s4";
  } else if(isstartstr(var_0, "t9")) {
    return "t9";
  }

  return "iw8";
}

function resetplayermovespeedscale(var_0) {
  var_1 = tablelookupbyrow("operatorskins.csv", var_0, 22);
  return var_1;
}

function getoperatorgender(var_0) {
  var_1 = scripts\engine\utility::ter_op(tablelookup("operators.csv", 1, var_0, 11) == "0", "male", "female");
  return var_1;
}

function resetplayerdataforrespawningplayer(var_0) {
  var_1 = tablelookup("operatorskins.csv", 0, var_0, 23);
  return var_1;
}

function resetunresolvedcollision(var_0) {
  var_1 = tablelookup("operators.csv", 1, var_0, 31);
  return int(var_1);
}

function update_timer_for_bomb_vest_detonator_holder(var_0) {
  var_1 = tablelookup("mp/cac/bodies.csv", 1, var_0, 24);
  return isDefined(var_1) && var_1 == "1";
}

function runbrgametypefunc6(var_0) {
  var_1 = 0;

  if(!isagent(self)) {
    var_1 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "vehicleCustomization", var_0, "camo");
  }

  var_2 = tablelookup("mp_cp/vehiclecamos.csv", 6, var_1, 4);
  return var_2;
}

function rundomplateskybeam(var_0) {
  var_1 = 0;

  if(!isagent(self)) {
    var_1 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "vehicleCustomization", var_0, "camo");
  }

  var_2 = tablelookup("mp_cp/vehiclecamos.csv", 6, var_1, 5);
  return var_2;
}

function runcircles(var_0, var_1) {
  var_2 = 0;

  if(!isagent(self)) {
    var_2 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "vehicleCustomization", var_0, "horn");
  }

  var_3 = tablelookup("mp_cp/vehiclehorns.csv", 0, var_2, var_1);
  return var_3;
}

function runcontrolledcallback(var_0) {
  var_1 = 0;

  if(!isagent(self)) {
    var_1 = self getplayerdata(level.loadoutsgroup, "customizationSetup", "vehicleCustomization", var_0, "camo");
  }

  var_2 = tablelookup("mp_cp/vehiclecamos.csv", 6, var_1, 10);
  return var_2;
}

function initnightvisionheadoverrides() {
  if(!scripts\cp_mp\utility\game_utility::isnightmap()) {
    return;
  }

  level.nvgheadoverrides = [];

  for(var_0 = 0;; var_0++) {
    var_1 = tablelookupbyrow("operatorskins.csv", var_0, 5);
    var_2 = tablelookupbyrow("operatorskins.csv", var_0, 17);
    var_3 = tablelookupbyrow("operatorskins.csv", var_0, 16);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    if(var_2 != "") {
      level.nvgheadoverrides[var_1]["up"] = var_2;
    }

    if(var_3 != "") {
      level.nvgheadoverrides[var_1]["down"] = var_3;
    }
  }

  level.nvgheadoverrides["head_mp_eastern_fireteam_east_ar_1"]["up"] = "none";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_ar_1_2"]["up"] = "none";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_ar_1_3"]["up"] = "none";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_ar_2"]["up"] = "none";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_ar_2_2"]["up"] = "none";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_ar_2_3"]["up"] = "none";
  level.nvgheadoverrides["head_mp_eastern_fireteam_east_lmg"]["up"] = "none";
}

function thermite_doradiusdamage() {
  if(isDefined(level.showing_bomb_wire_pair_to_player)) {
    return;
  }

  level.showing_bomb_wire_pair_to_player = [];
  var_0 = tablelookupgetnumrows("operatorskins.csv");

  for(var_1 = 0; var_1 < var_0; var_1++) {
    if(tablelookupbyrow("operatorskins.csv", var_1, 18) != "") {
      var_2 = tablelookupbyrow("operatorskins.csv", var_1, 2);
      var_3 = tablelookupbyrow("operatorskins.csv", var_1, 0);

      if(!isDefined(level.showing_bomb_wire_pair_to_player[var_2])) {
        level.showing_bomb_wire_pair_to_player[var_2]["lootIDs"] = [];
        level.showing_bomb_wire_pair_to_player[var_2]["curIndex"] = 0;
        level.showing_bomb_wire_pair_to_player[var_2]["maxIndex"] = 0;
      }

      level.showing_bomb_wire_pair_to_player[var_2]["lootIDs"][level.showing_bomb_wire_pair_to_player[var_2]["lootIDs"].size] = int(var_3);
      level.showing_bomb_wire_pair_to_player[var_2]["maxIndex"] = level.showing_bomb_wire_pair_to_player[var_2]["maxIndex"] + 1;
    }
  }
}

function initoperatorcustomization() {
  if(isDefined(level.operatorcustomization)) {
    return;
  }

  level.operatorcustomization = [];
  var_0 = getlocalestructarray();
  setDvar("cl_streamSync_devNoLatch", 1);

  for(var_1 = 0;; var_1++) {
    var_2 = tablelookupbyrow("operators.csv", var_1, 1);
    var_3 = getoperatorsuperfaction(var_2);
    var_4 = scripts\engine\utility::ter_op(var_3 == 0, "allies", "axis");

    if(!isDefined(var_2) || var_2 == "") {
      break;
    }

    var_5 = int(tablelookupbyrow("operators.csv", var_1, 8));
    var_6 = resetunresolvedcollision(var_2);
    var_7 = var_0 && update_track_operational_status(var_2);

    if(var_5 && var_6 && !var_7) {
      if(!isDefined(level.operatorcustomization[var_4])) {
        level.operatorcustomization[var_4] = [];
      }

      level.operatorcustomization[var_4][var_2] = [];
    }
  }

  var_8 = 0;

  for(;;) {
    var_9 = int(tablelookupbyrow("operatorskins.csv", var_8, 20));
    var_10 = tablelookupbyrow("operatorskins.csv", var_8, 1);

    if(!isDefined(var_10) || var_10 == "") {
      break;
    }

    if(var_9) {
      var_2 = tablelookupbyrow("operatorskins.csv", var_8, 2);
      var_11 = tablelookupbyrow("operatorskins.csv", var_8, 4);
      var_12 = tablelookupbyrow("operatorskins.csv", var_8, 5);
      var_4 = getoperatorteambyref(var_2);

      if(!isDefined(var_4)) {
        var_8++;
        continue;
      }

      var_13 = [];
      GscBinSkip0(0x2e, 0, var_11);
    }

    var_9++;
  }

  if(getdvarint("scr_customization_missing_skins_fixup", 1) == 1) {
    for(var_2 = 0;; var_2++) {
      var_3 = tablelookupbyrow("operators.csv", var_2, 1);
      var_4 = getoperatorsuperfaction(var_3);
      var_5 = scripts\engine\utility::ter_op(var_4 == 0, "allies", "axis");

      if(!isDefined(var_3) || var_3 == "") {
        break;
      }

      var_6 = int(tablelookupbyrow("operators.csv", var_2, 8));

      if(var_6 && isDefined(level.operatorcustomization[var_5][var_3]) && level.operatorcustomization[var_5][var_3].size == 0) {
        level.operatorcustomization[var_5][var_3] = undefined;
      }
    }

    return;
  }
}

function getoperatorteambyref(var_0) {
  foreach(var_2 in level.operatorcustomization) {
    foreach(var_4 in var_2) {
      if(var_5 == var_0) {
        return var_6;
      }
    }
  }

  return undefined;
}

function getnextoperatorindex(var_0, var_1) {
  if(!var_1) {
    var_2 = 0;

    foreach(var_4 in level.operatorcustomization[self.team]) {
      if(var_0 == var_5) {
        break;
      }

      var_2++;
    }

    var_6 = undefined;
    var_7 = var_2 + 1;

    if(var_7 == level.operatorcustomization[self.team].size) {
      var_7 = 0;
    }

    return var_7;
  }

  return randomint(level.operatorcustomization[self.team].size);
}

function getnextskinindex(var_0, var_1) {
  if(!var_1) {
    var_2 = self getentitynumber();

    if(!isDefined(level.playercustomizationdata)) {
      level.playercustomizationdata = [];
    }

    var_3 = undefined;

    if(!isDefined(level.playercustomizationdata[var_2])) {
      level.playercustomizationdata[var_2] = [];
    }

    if(!isDefined(level.playercustomizationdata[var_2][self.team])) {
      var_4 = spawnStruct();
      var_4.operatorref = var_0;

      if(isai(self)) {
        var_4.operatorskinindex = self.botskinid;
      } else {
        var_4.operatorskinindex = restart_watcher(var_0);
      }

      level.playercustomizationdata[var_2][self.team] = var_4;
    }

    var_3 = level.playercustomizationdata[var_2][self.team].operatorskinindex;
    var_5 = tablelookup("operatorskins.csv", 0, var_3, 1);
    var_6 = 0;

    foreach(var_8 in level.operatorcustomization[self.team][var_0]) {
      if(var_5 == var_9) {
        break;
      }

      var_6++;
    }

    var_10 = var_6 + 1;

    if(var_10 == level.operatorcustomization[self.team][var_0].size) {
      var_10 = 0;
    }

    return var_10;
  }

  return randomint(level.operatorcustomization[self.team][var_9].size);
}

function getplayerlookattarget() {
  var_0 = self getEye();
  var_1 = self getplayerangles();
  var_2 = anglesToForward(var_1);
  var_3 = var_0 + var_2 * 10000;
  var_4 = ["physicscontents_player"];
  var_5 = physics_createcontents(var_4);
  var_6 = scripts\engine\trace::sphere_trace(var_0, var_3, 5, self, var_5, 0);
  var_7 = var_6["entity"];

  if(isDefined(var_7) && isPlayer(var_7)) {
    return var_7;
  }

  return undefined;
}

function devmonitoroperatorcustomizationprint() {
  for(;;) {
    waitframe();
    var_0 = [];

    if(getdvarint("scr_operator_print_all", 0) != 0) {
      initoperatorcustomization();
      var_0 = level.players;
    }

    if(getdvarint("scr_operator_print_target", 0) != 0) {
      initoperatorcustomization();
      var_1 = getplayerlookattarget(level.players[0]);

      if(!isDefined(var_1)) {
        continue;
      }

      var_0 = var_1;
    }

    if(var_0.size > 0) {
      foreach(var_3 in var_0) {
        printcustomization(var_3);
      }
    }
  }
}

function printcustomization() {
  if(!scripts\mp\utility\teams::isgameplayteam(self.team)) {
    return;
  }

  var_0 = getoperatorcustomization();
}

function ref_12304() {
  var_0 = undefined;
  var_1 = 1;

  if(istrue(level.onlinegame)) {
    var_2 = self getfireteammembers();
    var_1 = var_2.size;

    if(isDefined(var_2) && var_2.size > 0) {
      foreach(var_4 in var_2) {
        if(isDefined(var_4) && scripts\mp\utility\teams::isgameplayteam(var_4.team)) {
          var_0 = var_4.team;
          self.ref_13AC9 = var_4.ref_13AC9;
          break;
        }
      }
    }
  }

  if(!isDefined(var_0)) {
    var_0 = play_reset_priming_anim(var_1);
  }

  if(!isDefined(self.ref_13AC9)) {
    self.ref_13AC9 = gettime();
  }

  thread scripts\mp\menus::setteam(var_0);
}

function play_reset_priming_anim(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  var_1 = undefined;

  foreach(var_3 in level.teamnamelist) {
    var_4 = scripts\mp\utility\teams::getteamcount(var_3);
    var_5 = level.maxteamsize - var_4;

    if(var_5 < var_0) {
      continue;
    }

    if(var_4 > 0) {
      var_6 = scripts\mp\utility\teams::getteamdata(var_3, "players");

      if(isDefined(var_6[0].ref_13AC9) && gettime() > var_6[0].ref_13AC9 + 300000) {
        continue;
      }
    }

    var_1 = var_3;
    break;
  }

  return var_1;
}

function istempsfxent() {
  var_0 = 25;

  for(;;) {
    if(isDefined(level.teamdata)) {
      var_1 = 400;
      var_2 = 200;
      var_3 = 1;
      var_4 = 0;

      foreach(var_6 in level.teamnamelist) {
        var_3 = 1;
        var_3++;

        foreach(var_8 in level.teamdata[var_6]["players"]) {
          var_9 = (1, 1, 1);

          if(istrue(var_8.squadassignedfromlobby)) {
            var_9 = (0, 1, 0);
          }

          var_3++;
        }

        var_2 += 100;
        var_4++;

        if(var_4 > 6) {
          var_4 = 0;
          var_1 += 200;
          var_2 = 200;
        }
      }
    }

    waitframe();
  }
}

function ref_132E6() {
  return getdvarint("scr_br_zombie_encounters", 0) > 0 || getdvarint("scr_br_alt_mode_fiend", 0) > 0 || scripts\mp\utility\game::deposit_from_compromised_convoy_delayed_failsafe();
}