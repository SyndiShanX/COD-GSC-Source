/****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\_teams.gsc
****************************************/

init() {
  initscoreboard();
  level.teambalance = getdvarint("scr_teambalance");
  level.maxclients = getdvarint("sv_maxclients");
  setplayermodels();
  level.freeplayers = [];

  if(level.teambased) {
    level thread onplayerconnect();
    level thread updateteambalance();
    wait 0.15;
    level thread updateplayertimes();
  } else {
    level thread onfreeplayerconnect();
    wait 0.15;
    level thread updatefreeplayertimes();
  }
}

initscoreboard() {
  if(maps\mp\_utility::invirtuallobby()) {
    return;
  }
  setdvar("g_TeamName_Allies", getteamshortname("allies"));
  setdvar("g_TeamIcon_Allies", getteamicon("allies"));
  setdvar("g_TeamIcon_MyAllies", getteamicon("allies"));
  setdvar("g_TeamIcon_EnemyAllies", getteamicon("allies"));
  var_0 = getteamcolor("allies");
  setdvar("g_ScoresColor_Allies", var_0[0] + " " + var_0[1] + " " + var_0[2]);
  setdvar("g_TeamName_Axis", getteamshortname("axis"));
  setdvar("g_TeamIcon_Axis", getteamicon("axis"));
  setdvar("g_TeamIcon_MyAxis", getteamicon("axis"));
  setdvar("g_TeamIcon_EnemyAxis", getteamicon("axis"));
  var_0 = getteamcolor("axis");
  setdvar("g_ScoresColor_Axis", var_0[0] + " " + var_0[1] + " " + var_0[2]);
  setdvar("g_ScoresColor_Spectator", ".25 .25 .25");
  setdvar("g_ScoresColor_Free", ".76 .78 .10");
  setdvar("g_teamTitleColor_MyTeam", ".6 .8 .6");
  setdvar("g_teamTitleColor_EnemyTeam", "1 .45 .5");
}

onplayerconnect() {
  for (;;) {
    level waittill("connected", var_0);
    var_0 thread onjoinedteam();
    var_0 thread onjoinedspectators();
    var_0 thread onplayerspawned();
    var_0 thread trackplayedtime();
  }
}

onfreeplayerconnect() {
  for (;;) {
    level waittill("connected", var_0);
    var_0 thread trackfreeplayedtime();
  }
}

onjoinedteam() {
  self endon("disconnect");

  for (;;) {
    self waittill("joined_team");
    updateteamtime();
  }
}

onjoinedspectators() {
  self endon("disconnect");

  for (;;) {
    self waittill("joined_spectators");
    self.pers["teamTime"] = undefined;
  }
}

updateinpartywithotherplayers() {
  if(!isai(self) && maps\mp\_utility::matchmakinggame()) {
    var_0 = inpartywithotherplayers(self.xuid);

    if(!isdefined(self.inpartywithotherplayers) || var_0 != self.inpartywithotherplayers) {

    }

    self.inpartywithotherplayers = var_0;
  }
}

trackplayedtime() {
  self endon("disconnect");
  lootservicestarttrackingplaytime(self.xuid);
  updateinpartywithotherplayers();
  self.timeplayed["allies"] = 0;
  self.timeplayed["axis"] = 0;
  self.timeplayed["other"] = 0;
  maps\mp\_utility::gameflagwait("prematch_done");

  for (;;) {
    if(game["state"] == "playing") {
      if(self.sessionteam == "allies") {
        self.timeplayed["allies"]++;
        self.timeplayed["total"]++;
      } else if(self.sessionteam == "axis") {
        self.timeplayed["axis"]++;
        self.timeplayed["total"]++;
      } else if(self.sessionteam == "spectator")
        self.timeplayed["other"]++;
    }

    if(!maps\mp\_utility::is_true(self.inpartywithotherplayers))
      updateinpartywithotherplayers();

    wait 1.0;
  }
}

updateplayertimes() {
  if(!level.rankedmatch) {
    return;
  }
  level endon("game_ended");

  for (;;) {
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();

    foreach(var_1 in level.players)
    var_1 updateplayedtime();

    wait 1.0;
  }
}

updateplayedtime() {
  if(isai(self)) {
    return;
  }
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  if(self.timeplayed["allies"]) {
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedAllies", self.timeplayed["allies"]);
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal", self.timeplayed["allies"]);
    maps\mp\gametypes\_persistence::stataddchildbuffered("round", "timePlayed", self.timeplayed["allies"]);
  }

  if(self.timeplayed["axis"]) {
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedOpfor", self.timeplayed["axis"]);
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal", self.timeplayed["axis"]);
    maps\mp\gametypes\_persistence::stataddchildbuffered("round", "timePlayed", self.timeplayed["axis"]);
  }

  if(self.timeplayed["other"]) {
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedOther", self.timeplayed["other"]);
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal", self.timeplayed["other"]);
    maps\mp\gametypes\_persistence::stataddchildbuffered("round", "timePlayed", self.timeplayed["other"]);
  }

  if(game["state"] == "postgame") {
    return;
  }
  self.timeplayed["allies"] = 0;
  self.timeplayed["axis"] = 0;
  self.timeplayed["other"] = 0;
}

updateteamtime() {
  if(game["state"] != "playing") {
    return;
  }
  self.pers["teamTime"] = gettime();
}

updateteambalancedvar() {
  for (;;) {
    var_0 = getdvarint("scr_teambalance");

    if(level.teambalance != var_0)
      level.teambalance = getdvarint("scr_teambalance");

    wait 1;
  }
}

updateteambalance() {
  level.teamlimit = level.maxclients / 2;
  level thread updateteambalancedvar();
  wait 0.15;

  if(level.teambalance && maps\mp\_utility::isroundbased()) {
    if(isdefined(game["BalanceTeamsNextRound"]))
      iprintlnbold(&"MP_AUTOBALANCE_NEXT_ROUND");

    level waittill("restarting");

    if(isdefined(game["BalanceTeamsNextRound"])) {
      level balanceteams();
      game["BalanceTeamsNextRound"] = undefined;
    } else if(!getteambalance())
      game["BalanceTeamsNextRound"] = 1;
  } else {
    level endon("game_ended");

    for (;;) {
      if(level.teambalance) {
        if(!getteambalance()) {
          iprintlnbold(&"MP_AUTOBALANCE_SECONDS", 15);
          wait 15.0;

          if(!getteambalance())
            level balanceteams();
        }

        wait 59.0;
      }

      wait 1.0;
    }
  }
}

getteambalance() {
  level.team["allies"] = 0;
  level.team["axis"] = 0;
  var_0 = level.players;

  for (var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isdefined(var_0[var_1].pers["team"]) && var_0[var_1].pers["team"] == "allies") {
      level.team["allies"]++;
      continue;
    }

    if(isdefined(var_0[var_1].pers["team"]) && var_0[var_1].pers["team"] == "axis")
      level.team["axis"]++;
  }

  if(level.team["allies"] > level.team["axis"] + level.teambalance || level.team["axis"] > level.team["allies"] + level.teambalance)
    return 0;
  else
    return 1;
}

balanceteams() {
  iprintlnbold(game["strings"]["autobalance"]);
  var_0 = [];
  var_1 = [];
  var_2 = level.players;

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
    if(!isdefined(var_2[var_3].pers["teamTime"])) {
      continue;
    }
    if(isdefined(var_2[var_3].pers["team"]) && var_2[var_3].pers["team"] == "allies") {
      var_0[var_0.size] = var_2[var_3];
      continue;
    }

    if(isdefined(var_2[var_3].pers["team"]) && var_2[var_3].pers["team"] == "axis")
      var_1[var_1.size] = var_2[var_3];
  }

  var_4 = undefined;

  while (var_0.size > var_1.size + 1 || var_1.size > var_0.size + 1) {
    if(var_0.size > var_1.size + 1) {
      for (var_5 = 0; var_5 < var_0.size; var_5++) {
        if(isdefined(var_0[var_5].dont_auto_balance)) {
          continue;
        }
        if(!isdefined(var_4)) {
          var_4 = var_0[var_5];
          continue;
        }

        if(var_0[var_5].pers["teamTime"] > var_4.pers["teamTime"])
          var_4 = var_0[var_5];
      }

      var_4[[level.onteamselection]]("axis");
    } else if(var_1.size > var_0.size + 1) {
      for (var_5 = 0; var_5 < var_1.size; var_5++) {
        if(isdefined(var_1[var_5].dont_auto_balance)) {
          continue;
        }
        if(!isdefined(var_4)) {
          var_4 = var_1[var_5];
          continue;
        }

        if(var_1[var_5].pers["teamTime"] > var_4.pers["teamTime"])
          var_4 = var_1[var_5];
      }

      var_4[[level.onteamselection]]("allies");
    }

    var_4 = undefined;
    var_0 = [];
    var_1 = [];
    var_2 = level.players;

    for (var_3 = 0; var_3 < var_2.size; var_3++) {
      if(isdefined(var_2[var_3].pers["team"]) && var_2[var_3].pers["team"] == "allies") {
        var_0[var_0.size] = var_2[var_3];
        continue;
      }

      if(isdefined(var_2[var_3].pers["team"]) && var_2[var_3].pers["team"] == "axis")
        var_1[var_1.size] = var_2[var_3];
    }
  }
}

setghilliemodels(var_0) {}

setteammodels(var_0, var_1) {}

setplayermodels() {
  if(level.multiteambased) {
    for (var_0 = 0; var_0 < level.teamnamelist.size; var_0++)
      setteammodels(level.teamnamelist[var_0], game[level.teamnamelist[var_0]]);
  } else {
    setteammodels("allies", game["allies"]);
    setteammodels("axis", game["axis"]);
  }

  setghilliemodels(getmapcustom("environment"));
}

playercostume(var_0, var_1, var_2) {
  if(isagent(self) && !getdvarint("virtualLobbyActive", 0))
    return 1;

  if(isdefined(var_0))
    var_0 = maps\mp\_utility::getbaseweaponname(var_0) + "_mp";

  self setcostumemodels(self.costume, var_0, var_1, var_2);
  self.voice = "american";
  self setclothtype("vestlight");
  return 1;
}

validcostume(var_0) {
  if(!isdefined(var_0))
    return 0;

  var_1 = validatecostume(var_0);

  for (var_2 = 0; var_2 < var_0.size; var_2++) {
    if(var_0[var_2] != var_1[var_2])
      return 0;
  }

  return 1;
}

getdefaultcostume() {
  var_0 = randomcostume();
  return var_0;
}

gethardcorecostume() {
  var_0 = 2;

  if(self.pers["team"] == "axis")
    var_0 = 1;

  var_1 = getcostumefromtable(level.hardcorecostumetablename, var_0);
  return var_1;
}

verifycostume() {
  if(!validcostume(self.costume)) {
    if(isdefined(self.sessioncostume) && validcostume(self.sessioncostume))
      self.costume = self.sessioncostume;
    else {
      self.costume = getdefaultcostume();

      if(isplayer(self))
        maps\mp\gametypes\_class::cao_setactivecostume(self.costume);

      self.sessioncostume = self.costume;
    }
  }
}

applycostume(var_0, var_1, var_2) {
  verifycostume();
  var_3 = playercostume(var_0, var_1, var_2);
  self notify("player_model_set");
}

countplayers() {
  var_0 = [];

  for (var_1 = 0; var_1 < level.teamnamelist.size; var_1++)
    var_0[level.teamnamelist[var_1]] = 0;

  for (var_1 = 0; var_1 < level.players.size; var_1++) {
    if(level.players[var_1] == self) {
      continue;
    }
    if(level.players[var_1].pers["team"] == "spectator") {
      continue;
    }
    if(isdefined(level.players[var_1].pers["team"]))
      var_0[level.players[var_1].pers["team"]]++;
  }

  return var_0;
}

trackfreeplayedtime() {
  self endon("disconnect");
  lootservicestarttrackingplaytime(self.xuid);
  updateinpartywithotherplayers();
  self.timeplayed["allies"] = 0;
  self.timeplayed["axis"] = 0;
  self.timeplayed["other"] = 0;

  for (;;) {
    if(game["state"] == "playing") {
      if(isdefined(self.pers["team"]) && self.pers["team"] == "allies" && self.sessionteam != "spectator") {
        self.timeplayed["allies"]++;
        self.timeplayed["total"]++;
      } else if(isdefined(self.pers["team"]) && self.pers["team"] == "axis" && self.sessionteam != "spectator") {
        self.timeplayed["axis"]++;
        self.timeplayed["total"]++;
      } else
        self.timeplayed["other"]++;
    }

    if(!maps\mp\_utility::is_true(self.inpartywithotherplayers))
      updateinpartywithotherplayers();

    wait 1.0;
  }
}

updatefreeplayertimes() {
  if(!level.rankedmatch) {
    return;
  }
  var_0 = 0;

  for (;;) {
    var_0++;

    if(var_0 >= level.players.size)
      var_0 = 0;

    if(isdefined(level.players[var_0]))
      level.players[var_0] updatefreeplayedtime();

    wait 1.0;
  }
}

updatefreeplayedtime() {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  if(isai(self)) {
    return;
  }
  if(self.timeplayed["allies"]) {
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedAllies", self.timeplayed["allies"]);
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal", self.timeplayed["allies"]);
    maps\mp\gametypes\_persistence::stataddchildbuffered("round", "timePlayed", self.timeplayed["allies"]);
  }

  if(self.timeplayed["axis"]) {
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedOpfor", self.timeplayed["axis"]);
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal", self.timeplayed["axis"]);
    maps\mp\gametypes\_persistence::stataddchildbuffered("round", "timePlayed", self.timeplayed["axis"]);
  }

  if(self.timeplayed["other"]) {
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedOther", self.timeplayed["other"]);
    maps\mp\gametypes\_persistence::stataddbuffered("timePlayedTotal", self.timeplayed["other"]);
    maps\mp\gametypes\_persistence::stataddchildbuffered("round", "timePlayed", self.timeplayed["other"]);
  }

  if(game["state"] == "postgame") {
    return;
  }
  self.timeplayed["allies"] = 0;
  self.timeplayed["axis"] = 0;
  self.timeplayed["other"] = 0;
}

getjointeampermissions(var_0) {
  if(maps\mp\_utility::iscoop())
    return 1;

  var_1 = 0;
  var_2 = 0;
  var_3 = level.players;

  for (var_4 = 0; var_4 < var_3.size; var_4++) {
    var_5 = var_3[var_4];

    if(isdefined(var_5.pers["team"]) && var_5.pers["team"] == var_0) {
      var_1++;

      if(isbot(var_5))
        var_2++;
    }
  }

  if(var_1 < level.teamlimit)
    return 1;
  else if(var_2 > 0)
    return 1;
  else if(level.gametype == "infect")
    return 1;
  else if(maps\mp\_utility::ishodgepodgemm())
    return 1;
  else
    return 0;
}

onplayerspawned() {
  level endon("game_ended");

  for (;;)
    self waittill("spawned_player");
}

mt_getteamname(var_0) {
  return tablelookupistring("mp\MTTable.csv", 0, var_0, 1);
}

mt_getteamicon(var_0) {
  return tablelookup("mp\MTTable.csv", 0, var_0, 2);
}

mt_getteamheadicon(var_0) {
  return tablelookup("mp\MTTable.csv", 0, var_0, 3);
}

getteamnamecol() {
  return 1;
}

getteamname(var_0) {
  return factiontableistringlookup(var_0, getteamnamecol());
}

getteamshortnamecol() {
  return 2;
}

getteamshortname(var_0) {
  return factiontableistringlookup(var_0, getteamshortnamecol());
}

getteamforfeitedstringcol() {
  return 4;
}

getteamforfeitedstring(var_0) {
  return factiontableistringlookup(var_0, getteamforfeitedstringcol());
}

getteameliminatedstringcol() {
  return 3;
}

getteameliminatedstring(var_0) {
  return factiontableistringlookup(var_0, getteameliminatedstringcol());
}

getteamiconcol() {
  return 5;
}

getteamicon(var_0) {
  return factiontablelookup(var_0, getteamiconcol());
}

getteamhudiconcol() {
  return 6;
}

getteamhudicon(var_0) {
  return factiontablelookup(var_0, getteamhudiconcol());
}

getteamheadiconcol() {
  return 17;
}

getteamheadicon(var_0) {
  return factiontablelookup(var_0, getteamheadiconcol());
}

getteamvoiceprefixcol() {
  return 7;
}

getteamvoiceprefix(var_0) {
  return factiontablelookup(var_0, getteamvoiceprefixcol());
}

getteamspawnmusiccol() {
  return 8;
}

getteamspawnmusic(var_0) {
  return factiontablelookup(var_0, getteamspawnmusiccol());
}

getteamwinmusiccol() {
  return 9;
}

getteamwinmusic(var_0) {
  return factiontablelookup(var_0, getteamwinmusiccol());
}

getteamflagmodelcol() {
  return 10;
}

getteamflagmodel(var_0) {
  return factiontablelookup(var_0, getteamflagmodelcol());
}

getteamflagcarrymodelcol() {
  return 11;
}

getteamflagcarrymodel(var_0) {
  return factiontablelookup(var_0, getteamflagcarrymodelcol());
}

getteamflagiconcol() {
  return 12;
}

getteamflagicon(var_0) {
  return factiontablelookup(var_0, getteamflagiconcol());
}

getteamflagfxcol() {
  return 13;
}

getteamflagfx(var_0) {
  return factiontablelookup(var_0, getteamflagfxcol());
}

getteamcolorredcol() {
  return 14;
}

getteamcolorgreencol() {
  return 15;
}

getteamcolorbluecol() {
  return 16;
}

getteamcolor(var_0) {
  return (maps\mp\_utility::stringtofloat(factiontablelookup(var_0, getteamcolorredcol())), maps\mp\_utility::stringtofloat(factiontablelookup(var_0, getteamcolorgreencol())), maps\mp\_utility::stringtofloat(factiontablelookup(var_0, getteamcolorbluecol())));
}

getteamcratemodelcol() {
  return 18;
}

getteamcratemodel(var_0) {
  return factiontablelookup(var_0, getteamcratemodelcol());
}

getteamdeploymodelcol() {
  return 19;
}

getteamdeploymodel(var_0) {
  return factiontablelookup(var_0, getteamdeploymodelcol());
}

setfactiontableoverride(var_0, var_1, var_2) {
  if(!isdefined(level.factiontableoverrides))
    level.factiontableoverrides = [];

  if(!isdefined(level.factiontableoverrides[var_0]))
    level.factiontableoverrides[var_0] = [];

  level.factiontableoverrides[var_0][var_1] = var_2;
}

getfactiontableoverride(var_0, var_1) {
  var_2 = game[var_0];

  if(isdefined(level.factiontableoverrides) && isdefined(level.factiontableoverrides[var_2]))
    return level.factiontableoverrides[var_2][var_1];

  return undefined;
}

factiontablelookup(var_0, var_1) {
  var_2 = getfactiontableoverride(var_0, var_1);

  if(isdefined(var_2))
    return var_2;

  return tablelookup("mp\factionTable.csv", 0, game[var_0], var_1);
}

factiontableistringlookup(var_0, var_1) {
  var_2 = getfactiontableoverride(var_0, var_1);

  if(isdefined(var_2))
    return var_2;

  return tablelookupistring("mp\factionTable.csv", 0, game[var_0], var_1);
}