/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\persistence.gsc
***********************************************/

#using script_4a6760982b403bad;
#using scripts\common\utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\hostmigration;
#using scripts\mp\supers;
#using scripts\mp\utility\game;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\weapon;
#namespace persistence;

function init() {
  level.persistentdatainfo = [];
  level thread updatebufferedstats();
  level thread updatebufferedstatsatgameend();
  level thread uploadglobalstatcounters();
  level thread writekdhistorystats();
}

function initbufferedstats() {
  println("<dev string:x1c>" + self.name);
  self.bufferedstats = [];
  self.squadmemberbufferedstats = [];

  if(onlinestatsenabled()) {
    self.bufferedstats["totalShots"] = self getplayerdata(level.var_5d69837cf4db0407, "totalShots");
    self.bufferedstats["accuracy"] = self getplayerdata(level.var_5d69837cf4db0407, "accuracy");
    self.bufferedstats["misses"] = self getplayerdata(level.var_5d69837cf4db0407, "misses");
    self.bufferedstats["hits"] = self getplayerdata(level.var_5d69837cf4db0407, "hits");
  }

  self.bufferedstats["timePlayedAllies"] = self getplayerdata(level.var_5d69837cf4db0407, "timePlayedAllies");
  self.bufferedstats["timePlayedOpfor"] = self getplayerdata(level.var_5d69837cf4db0407, "timePlayedOpfor");
  self.bufferedstats["timePlayedOther"] = self getplayerdata(level.var_5d69837cf4db0407, "timePlayedOther");
  self.bufferedstats["timePlayedTotal"] = self getplayerdata(level.var_5d69837cf4db0407, "timePlayedTotal");

  println("<dev string:x38>" + self.bufferedstats["<dev string:x4d>"]);
  println("<dev string:x61>" + self.bufferedstats["<dev string:x75>"]);
  println("<dev string:x88>" + self.bufferedstats["<dev string:x9c>"]);
  println("<dev string:xaf>" + self.bufferedstats["<dev string:xc3>"]);

  self.bufferedchildstats = [];
  self.bufferedchildstats["round"] = [];
  self.bufferedchildstats["round"]["timePlayed"] = self getplayerdata("common", "round", "timePlayed");

  if(onlinestatsenabled()) {
    self.bufferedchildstats["xpMultiplierTimePlayed"] = [];
    self.bufferedchildstats["xpMultiplierTimePlayed"][0] = self getplayerdata(level.var_5d69837cf4db0407, "xpMultiplierTimePlayed", 0);
    self.bufferedchildstats["xpMultiplierTimePlayed"][1] = self getplayerdata(level.var_5d69837cf4db0407, "xpMultiplierTimePlayed", 1);
    self.bufferedchildstats["xpMultiplierTimePlayed"][2] = self getplayerdata(level.var_5d69837cf4db0407, "xpMultiplierTimePlayed", 2);
    self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"] = [];
    self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][0] = self getplayerdata(level.var_5d69837cf4db0407, "xpMaxMultiplierTimePlayed", 0);
    self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][1] = self getplayerdata(level.var_5d69837cf4db0407, "xpMaxMultiplierTimePlayed", 1);
    self.bufferedchildstatsmax["xpMaxMultiplierTimePlayed"][2] = self getplayerdata(level.var_5d69837cf4db0407, "xpMaxMultiplierTimePlayed", 2);
    self.bufferedchildstats["challengeXPMultiplierTimePlayed"] = [];
    self.bufferedchildstats["challengeXPMultiplierTimePlayed"][0] = self getplayerdata(level.var_5d69837cf4db0407, "challengeXPMultiplierTimePlayed", 0);
    self.bufferedchildstatsmax["challengeXPMaxMultiplierTimePlayed"] = [];
    self.bufferedchildstatsmax["challengeXPMaxMultiplierTimePlayed"][0] = self getplayerdata(level.var_5d69837cf4db0407, "challengeXPMaxMultiplierTimePlayed", 0);
    self.bufferedchildstats["weaponXPMultiplierTimePlayed"] = [];
    self.bufferedchildstats["weaponXPMultiplierTimePlayed"][0] = self getplayerdata(level.var_5d69837cf4db0407, "weaponXPMultiplierTimePlayed", 0);
    self.bufferedchildstatsmax["weaponXPMaxMultiplierTimePlayed"] = [];
    self.bufferedchildstatsmax["weaponXPMaxMultiplierTimePlayed"][0] = self getplayerdata(level.var_5d69837cf4db0407, "weaponXPMaxMultiplierTimePlayed", 0);
    self.bufferedstats["prestigeDoubleWeaponXp"] = self getplayerdata(level.var_5d69837cf4db0407, "prestigeDoubleWeaponXp");
    self.bufferedstats["prestigeDoubleWeaponXpTimePlayed"] = self getplayerdata(level.var_5d69837cf4db0407, "prestigeDoubleWeaponXpTimePlayed");
    self.bufferedstatsmax["prestigeDoubleWeaponXpMaxTimePlayed"] = self getplayerdata(level.var_5d69837cf4db0407, "prestigeDoubleWeaponXpMaxTimePlayed");
  }

  initbestscorestatstable();
}

function initbestscorestatstable() {
  table = "mp/bestscorestatsTable.csv";
  self.bestscorestats = [];
  self.bufferedbestscorestats = [];

  for(row = 0; true; row++) {
    statname = tablelookupbyrow(table, row, 0);

    if(statname == "") {
      break;
    }

    self.bestscorestats[statname] = self getplayerdata(level.var_5d69837cf4db0407, "bestScores", statname);
  }
}

function statgetchild(parent, child) {
  if(parent == "round") {
    return self getplayerdata("common", parent, child);
  }

  return self getplayerdata(level.var_5d69837cf4db0407, parent, child);
}

function statsetchild(parent, child, value, ignorekdrstats) {
  if(isagent(self)) {
    return;
  }

  if(istrue(game["practiceRound"])) {
    return;
  }

  if(isDefined(ignorekdrstats) || !onlinestatsenabled()) {
    return;
  }

  if(parent == "round") {
    self setplayerdata("common", parent, child, value);
    setbestscore(child, value);
    return;
  }

  self setplayerdata(level.var_5d69837cf4db0407, parent, child, value);
}

function stataddchild(parent, child, value) {
  if(!onlinestatsenabled()) {
    return;
  }

  assert(isDefined(self.bufferedchildstats[parent][child]));
  curvalue = self getplayerdata(level.var_5d69837cf4db0407, parent, child);
  self setplayerdata(level.var_5d69837cf4db0407, parent, child, curvalue + value);
}

function statgetchildbuffered(parent, child, force) {
  if(!onlinestatsenabled() && !istrue(force)) {
    return 0;
  }

  assert(isDefined(self.bufferedchildstats[parent][child]));
  return self.bufferedchildstats[parent][child];
}

function statsetchildbuffered(parent, child, value, force) {
  if(!onlinestatsenabled() && !istrue(force)) {
    return;
  }

  assert(isDefined(self.bufferedchildstats[parent][child]));
  self.bufferedchildstats[parent][child] = value;
}

function stataddchildbuffered(parent, child, value, force) {
  if(!onlinestatsenabled() && !istrue(force)) {
    return;
  }

  assert(isDefined(self.bufferedchildstats[parent][child]));
  curvalue = statgetchildbuffered(parent, child, force);
  statsetchildbuffered(parent, child, curvalue + value, force);
}

function stataddchildbufferedwithmax(parent, child, value, max) {
  if(!onlinestatsenabled()) {
    return;
  }

  assert(isDefined(self.bufferedchildstats[parent][child]));
  newvalue = statgetchildbuffered(parent, child) + value;

  if(newvalue > max) {
    newvalue = max;
  }

  if(newvalue < statgetchildbuffered(parent, child)) {
    newvalue = max;
  }

  statsetchildbuffered(parent, child, newvalue);
}

function updatebufferedstats() {
  wait 0.15;
  nexttoupdate = 0;

  while(!level.gameended) {
    scripts\mp\hostmigration::waittillhostmigrationdone();
    nexttoupdate++;

    if(nexttoupdate >= level.players.size) {
      nexttoupdate = 0;
    }

    if(isDefined(level.players[nexttoupdate])) {
      level.players[nexttoupdate] writebufferedstats();
      level.players[nexttoupdate] updateweaponbufferedstats();
    }

    wait 2;
  }
}

function updatebufferedstatsatgameend() {
  level endon("game_cleanup");
  level waittill("game_ended");

  foreach(player in level.players) {
    player writebufferedstats();
    player updateweaponbufferedstats();
  }

  level.disableweaponstats = 1;
}

function setbestscore(statname, newvalue) {
  rankingenabled = onlinestatsenabled();

  if(!rankingenabled) {
    return;
  }

  if(isDefined(self.bestscorestats[statname]) && newvalue > self.bestscorestats[statname]) {
    self.bestscorestats[statname] = newvalue;
    self.bufferedbestscorestats[statname] = newvalue;
  }
}

function writebestscores() {
  foreach(player in level.players) {
    if(isDefined(player) && player onlinestatsenabled()) {
      foreach(statname, statval in player.bufferedbestscorestats) {
        player setplayerdata(level.var_5d69837cf4db0407, "bestScores", statname, statval);
      }
    }
  }
}

function writebufferedstats() {
  rankingenabled = onlinestatsenabled();

  if(rankingenabled) {
    foreach(statname, statval in self.bufferedstats) {
      self setplayerdata(level.var_5d69837cf4db0407, statname, statval);
    }

    if(!isai(self)) {
      foreach(statname, statval in self.squadmemberbufferedstats) {
        self setplayerdata(level.loadoutsgroup, "squadMembers", statname, statval);
      }
    }
  }

  foreach(statname, statval in self.bufferedchildstats) {
    foreach(childstatname, var_74224fe98d0679d2 in statval) {
      if(statname == "round") {
        self setplayerdata("common", statname, childstatname, var_74224fe98d0679d2);
        setbestscore(childstatname, var_74224fe98d0679d2);
        continue;
      }

      if(rankingenabled) {
        self setplayerdata(level.var_5d69837cf4db0407, statname, childstatname, var_74224fe98d0679d2);
      }
    }
  }
}

function writekdhistorystats() {
  if(!matchmakinggame()) {
    return;
  }

  level waittill("game_ended");
  wait 0.1;

  if(waslastround() || !isroundbased() && hittimelimit()) {
    foreach(player in level.players) {
      accuracy = 0;

      if(isDefined(player.pers["shotsFired"]) && player.pers["shotsFired"] > 0) {
        totalshots = player.pers["shotsFired"];
        hits = 0;

        if(isDefined(player.pers["shotsHit"])) {
          hits = player.pers["shotsHit"];
        }

        accuracy = int(100 * hits / totalshots);
      }

      player incrementrankedreservedhistory(player.kills, player.deaths, player.pers["headshots"], accuracy, player.pers["damage"]);
    }
  }
}

function incrementrankedreservedhistory(kills, deaths, headshots, accuracy, damage) {
  if(!onlinestatsenabled()) {
    return;
  }

  for(i = 0; i < 4; i++) {
    prev = self getplayerdata(level.var_5d69837cf4db0407, "kdHistoryK", i + 1);
    self setplayerdata(level.var_5d69837cf4db0407, "kdHistoryK", i, prev);
    prev = self getplayerdata(level.var_5d69837cf4db0407, "kdHistoryD", i + 1);
    self setplayerdata(level.var_5d69837cf4db0407, "kdHistoryD", i, prev);
    prev = self getplayerdata(level.var_5d69837cf4db0407, "headshotHistory", i + 1);
    self setplayerdata(level.var_5d69837cf4db0407, "headshotHistory", i, prev);
    prev = self getplayerdata(level.var_5d69837cf4db0407, "accuracyHistory", i + 1);
    self setplayerdata(level.var_5d69837cf4db0407, "accuracyHistory", i, prev);
    prev = self getplayerdata(level.var_5d69837cf4db0407, "damageHistory", i + 1);
    self setplayerdata(level.var_5d69837cf4db0407, "damageHistory", i, prev);
  }

  self setplayerdata(level.var_5d69837cf4db0407, "kdHistoryK", 4, int(clamp(kills, 0, 255)));
  self setplayerdata(level.var_5d69837cf4db0407, "kdHistoryD", 4, int(clamp(deaths, 0, 255)));
  self setplayerdata(level.var_5d69837cf4db0407, "headshotHistory", 4, int(clamp(headshots, 0, 255)));
  self setplayerdata(level.var_5d69837cf4db0407, "accuracyHistory", 4, int(accuracy));
  self setplayerdata(level.var_5d69837cf4db0407, "damageHistory", 4, damage);
}

function incrementweaponstat(weaponname, stat, incvalue) {
  if(iskillstreakweapon(weaponname)) {
    return;
  }

  if(istrue(level.disableweaponstats)) {
    return;
  }

  if(weaponname == "jup_la_humangun") {
    return;
  }

  if(onlinestatsenabled()) {
    oldval = self getplayerdata(level.var_5d69837cf4db0407, "playerStats", "weaponStats", weaponname, stat);
    self setplayerdata(level.var_5d69837cf4db0407, "playerStats", "weaponStats", weaponname, stat, oldval + incvalue);

    if(stat == "kills") {
      foreach(scope in ["lifetimeStats", "seasonalStats"]) {
        oldval = 0;

        if(self hasplayerdata(level.var_5d69837cf4db0407, "playerStats", scope, function_f6bad1d33ad22078(), "weaponStats", weaponname, "kills")) {
          oldval = self getplayerdata(level.var_5d69837cf4db0407, "playerStats", scope, function_f6bad1d33ad22078(), "weaponStats", weaponname, "kills");
        }

        self setplayerdata(level.var_5d69837cf4db0407, "playerStats", scope, function_f6bad1d33ad22078(), "weaponStats", weaponname, "kills", oldval + incvalue);
      }
    }
  }
}

function incrementattachmentstat(attachmentname, stat, incvalue, weapon) {
  if(istrue(level.disableweaponstats)) {
    return;
  }

  if(!attachmentlogsstats(attachmentname, weapon)) {
    return;
  }

  if(onlinestatsenabled()) {}
}

function updateweaponbufferedstats() {
  if(!isDefined(self.trackingweapon)) {
    return;
  }

  if(isnullweapon(self.trackingweapon)) {
    return;
  }

  if(scripts\mp\utility\weapon::issuperweapon(self.trackingweapon)) {
    if(!istrue(scripts\mp\supers::shouldtracksuperweaponstats(self.trackingweapon))) {
      return;
    }
  }

  if(iskillstreakweapon(self.trackingweapon) || isenvironmentweapon(self.trackingweapon) || isbombsiteweapon(self.trackingweapon)) {
    return;
  }

  weapon = self.trackingweapon;
  weapstat = undefined;

  if(weapon.isalternate) {
    basetype = function_7c612ac92ba98dcb(weapon, weapon.underbarrel);

    if(basetype == "altfire") {
      weapstat = weapon.underbarrel;
      perslog_attachmentstats(weapstat, weapon);
      persclear_stats();
      return;
    }
  }

  if(!isDefined(weapstat)) {
    weapstat = getweaponrootname(weapon);
  }

  assertex(isDefined(weapstat), "<dev string:xd6>");

  if(!iscacprimaryweapon(weapstat) && !iscacsecondaryweapon(weapstat)) {
    return;
  }

  variantid = getweaponvariantindex(weapon);
  persincrement_weaponstats(weapstat, variantid);
  fullweaponname = getcompleteweaponname(weapon);
  perslog_weaponstats(weapstat, fullweaponname, variantid);
  attachments = getweaponattachments(weapon);

  foreach(attachname in attachments) {
    if(!attachmentlogsstats(attachname, weapon)) {
      continue;
    }

    basetype = function_7c612ac92ba98dcb(weapon, attachname);

    if(basetype == "altfire") {
      continue;
    }

    perslog_attachmentstats(attachname, weapon);
  }

  persclear_stats();
}

function persclear_stats() {
  self.trackingweapon = nullweapon();
  self.trackingweaponshots = 0;
  self.trackingweaponkills = 0;
  self.var_e16d751a51153a7b = 0;
  self.var_2bf7b072e416002a = 0;
  self.var_1fe884779e5f4dbe = 0;
  self.trackingweaponhits = 0;
  self.var_a00eddcf879bdbc3 = 0;
  self.var_ca6e0d389c0ca0a7 = 0;
  self.trackingweaponheadshots = 0;
  self.var_9a2fd6f8771f2e58 = 0;
  self.var_5fac5778fe3fdc1c = 0;
  self.trackingweapondeaths = 0;
  self.var_f00517aa8f668932 = 0;
  self.var_14cec2ba65099256 = 0;
  self.var_883957b1c1ef6745 = 0;
  self.var_7b522bf6f7aeca98 = 0;
  self.var_bf617879def40524 = 0;
}

function persincrement_weaponstats(weaponname, variantid) {
  if(isDefined(self.trackingweaponshots) && self.trackingweaponshots > 0) {
    incrementweaponstat(weaponname, "shots", self.trackingweaponshots);
  }

  if(isDefined(self.trackingweaponkills) && self.trackingweaponkills > 0) {
    incrementweaponstat(weaponname, "kills", self.trackingweaponkills);
  }

  if(isDefined(self.trackingweaponhits) && self.trackingweaponhits > 0) {
    incrementweaponstat(weaponname, "hits", self.trackingweaponhits);
  }

  if(isDefined(self.trackingweaponheadshots) && self.trackingweaponheadshots > 0) {
    incrementweaponstat(weaponname, "headShots", self.trackingweaponheadshots);
  }

  if(isDefined(self.trackingweapondeaths) && self.trackingweapondeaths > 0) {
    incrementweaponstat(weaponname, "deaths", self.trackingweapondeaths);
  }
}

function perslog_weaponstats(weaponname, fullweaponname, variantid) {
  var_7e2c53b0bcf117d9 = spawnStruct();

  if(default_to(self.trackingweaponshots, 0) > 0) {
    var_7e2c53b0bcf117d9.weaponname = weaponname;
    var_7e2c53b0bcf117d9.fullweaponname = fullweaponname;
    var_7e2c53b0bcf117d9.statname = "shots";
    var_7e2c53b0bcf117d9.incvalue = self.trackingweaponshots;
    var_7e2c53b0bcf117d9.variantid = variantid;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_update_weapon_stats", var_7e2c53b0bcf117d9);
  }

  if(default_to(self.trackingweaponkills, 0) > 0) {
    var_7e2c53b0bcf117d9.weaponname = weaponname;
    var_7e2c53b0bcf117d9.fullweaponname = fullweaponname;
    var_7e2c53b0bcf117d9.statname = "kills";
    var_7e2c53b0bcf117d9.incvalue = self.trackingweaponkills;
    var_7e2c53b0bcf117d9.variantid = variantid;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_update_weapon_stats", var_7e2c53b0bcf117d9);
  }

  if(default_to(self.var_e16d751a51153a7b, 0) > 0) {
    var_7e2c53b0bcf117d9.weaponname = weaponname;
    var_7e2c53b0bcf117d9.fullweaponname = fullweaponname;
    var_7e2c53b0bcf117d9.statname = "ads_kills";
    var_7e2c53b0bcf117d9.incvalue = self.var_e16d751a51153a7b;
    var_7e2c53b0bcf117d9.variantid = variantid;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_update_weapon_stats", var_7e2c53b0bcf117d9);
  }

  if(default_to(self.var_2bf7b072e416002a, 0) > 0) {
    var_7e2c53b0bcf117d9.weaponname = weaponname;
    var_7e2c53b0bcf117d9.fullweaponname = fullweaponname;
    var_7e2c53b0bcf117d9.statname = "ai_ads_kills";
    var_7e2c53b0bcf117d9.incvalue = self.var_2bf7b072e416002a;
    var_7e2c53b0bcf117d9.variantid = variantid;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_update_weapon_stats", var_7e2c53b0bcf117d9);
  }

  if(default_to(self.var_1fe884779e5f4dbe, 0) > 0) {
    var_7e2c53b0bcf117d9.weaponname = weaponname;
    var_7e2c53b0bcf117d9.fullweaponname = fullweaponname;
    var_7e2c53b0bcf117d9.statname = "player_ads_kills";
    var_7e2c53b0bcf117d9.incvalue = self.var_1fe884779e5f4dbe;
    var_7e2c53b0bcf117d9.variantid = variantid;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_update_weapon_stats", var_7e2c53b0bcf117d9);
  }

  if(default_to(self.trackingweaponhits, 0) > 0) {
    var_7e2c53b0bcf117d9.weaponname = weaponname;
    var_7e2c53b0bcf117d9.fullweaponname = fullweaponname;
    var_7e2c53b0bcf117d9.statname = "hits";
    var_7e2c53b0bcf117d9.incvalue = self.trackingweaponhits;
    var_7e2c53b0bcf117d9.variantid = variantid;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_update_weapon_stats", var_7e2c53b0bcf117d9);
  }

  if(default_to(self.var_a00eddcf879bdbc3, 0) > 0) {
    var_7e2c53b0bcf117d9.weaponname = weaponname;
    var_7e2c53b0bcf117d9.fullweaponname = fullweaponname;
    var_7e2c53b0bcf117d9.statname = "ai_hits";
    var_7e2c53b0bcf117d9.incvalue = self.var_a00eddcf879bdbc3;
    var_7e2c53b0bcf117d9.variantid = variantid;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_update_weapon_stats", var_7e2c53b0bcf117d9);
  }

  if(default_to(self.var_ca6e0d389c0ca0a7, 0) > 0) {
    var_7e2c53b0bcf117d9.weaponname = weaponname;
    var_7e2c53b0bcf117d9.fullweaponname = fullweaponname;
    var_7e2c53b0bcf117d9.statname = "player_hits";
    var_7e2c53b0bcf117d9.incvalue = self.var_ca6e0d389c0ca0a7;
    var_7e2c53b0bcf117d9.variantid = variantid;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_update_weapon_stats", var_7e2c53b0bcf117d9);
  }

  if(default_to(self.trackingweaponheadshots, 0) > 0) {
    var_7e2c53b0bcf117d9.weaponname = weaponname;
    var_7e2c53b0bcf117d9.fullweaponname = fullweaponname;
    var_7e2c53b0bcf117d9.statname = "headshots";
    var_7e2c53b0bcf117d9.incvalue = self.trackingweaponheadshots;
    var_7e2c53b0bcf117d9.variantid = variantid;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_update_weapon_stats", var_7e2c53b0bcf117d9);
  }

  if(default_to(self.var_9a2fd6f8771f2e58, 0) > 0) {
    var_7e2c53b0bcf117d9.weaponname = weaponname;
    var_7e2c53b0bcf117d9.fullweaponname = fullweaponname;
    var_7e2c53b0bcf117d9.statname = "ai_headshots";
    var_7e2c53b0bcf117d9.incvalue = self.var_9a2fd6f8771f2e58;
    var_7e2c53b0bcf117d9.variantid = variantid;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_update_weapon_stats", var_7e2c53b0bcf117d9);
  }

  if(default_to(self.var_5fac5778fe3fdc1c, 0) > 0) {
    var_7e2c53b0bcf117d9.weaponname = weaponname;
    var_7e2c53b0bcf117d9.fullweaponname = fullweaponname;
    var_7e2c53b0bcf117d9.statname = "player_headshots";
    var_7e2c53b0bcf117d9.incvalue = self.var_5fac5778fe3fdc1c;
    var_7e2c53b0bcf117d9.variantid = variantid;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_update_weapon_stats", var_7e2c53b0bcf117d9);
  }

  if(default_to(self.trackingweapondeaths, 0) > 0) {
    var_7e2c53b0bcf117d9.weaponname = weaponname;
    var_7e2c53b0bcf117d9.fullweaponname = fullweaponname;
    var_7e2c53b0bcf117d9.statname = "deaths";
    var_7e2c53b0bcf117d9.incvalue = self.trackingweapondeaths;
    var_7e2c53b0bcf117d9.variantid = variantid;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_update_weapon_stats", var_7e2c53b0bcf117d9);
  }

  if(default_to(self.var_f00517aa8f668932, 0) > 0) {
    var_7e2c53b0bcf117d9.weaponname = weaponname;
    var_7e2c53b0bcf117d9.fullweaponname = fullweaponname;
    var_7e2c53b0bcf117d9.statname = "ai_deaths";
    var_7e2c53b0bcf117d9.incvalue = self.var_f00517aa8f668932;
    var_7e2c53b0bcf117d9.variantid = variantid;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_update_weapon_stats", var_7e2c53b0bcf117d9);
  }

  if(default_to(self.var_14cec2ba65099256, 0) > 0) {
    var_7e2c53b0bcf117d9.weaponname = weaponname;
    var_7e2c53b0bcf117d9.fullweaponname = fullweaponname;
    var_7e2c53b0bcf117d9.statname = "player_deaths";
    var_7e2c53b0bcf117d9.incvalue = self.var_14cec2ba65099256;
    var_7e2c53b0bcf117d9.variantid = variantid;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_update_weapon_stats", var_7e2c53b0bcf117d9);
  }

  if(default_to(self.var_883957b1c1ef6745, 0) > 0) {
    var_7e2c53b0bcf117d9.weaponname = weaponname;
    var_7e2c53b0bcf117d9.fullweaponname = fullweaponname;
    var_7e2c53b0bcf117d9.statname = "damage";
    var_7e2c53b0bcf117d9.incvalue = self.var_883957b1c1ef6745;
    var_7e2c53b0bcf117d9.variantid = variantid;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_update_weapon_stats", var_7e2c53b0bcf117d9);
  }

  if(default_to(self.var_7b522bf6f7aeca98, 0) > 0) {
    var_7e2c53b0bcf117d9.weaponname = weaponname;
    var_7e2c53b0bcf117d9.fullweaponname = fullweaponname;
    var_7e2c53b0bcf117d9.statname = "ai_damage";
    var_7e2c53b0bcf117d9.incvalue = self.var_7b522bf6f7aeca98;
    var_7e2c53b0bcf117d9.variantid = variantid;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_update_weapon_stats", var_7e2c53b0bcf117d9);
  }

  if(default_to(self.var_bf617879def40524, 0) > 0) {
    var_7e2c53b0bcf117d9.weaponname = weaponname;
    var_7e2c53b0bcf117d9.fullweaponname = fullweaponname;
    var_7e2c53b0bcf117d9.statname = "player_damage";
    var_7e2c53b0bcf117d9.incvalue = self.var_bf617879def40524;
    var_7e2c53b0bcf117d9.variantid = variantid;
    namespace_de6e6777b0937bd7::function_80820d6d364c1836("callback_update_weapon_stats", var_7e2c53b0bcf117d9);
  }
}

function perslog_attachmentstats(attachname, weapon) {
  if(!attachmentlogsstats(attachname, weapon)) {
    return;
  }

  if(self.trackingweaponshots > 0 && attachname != "tactical") {
    incrementattachmentstat(attachname, "shots", self.trackingweaponshots, weapon);
    utility::trycall(level.matchdata_logattachmentstat, attachname, "shots", self.trackingweaponshots, weapon);
  }

  if(self.trackingweaponkills > 0 && attachname != "tactical") {
    incrementattachmentstat(attachname, "kills", self.trackingweaponkills, weapon);
    utility::trycall(level.matchdata_logattachmentstat, attachname, "kills", self.trackingweaponkills, weapon);
  }

  if(self.var_e16d751a51153a7b > 0 && attachname != "tactical") {
    utility::trycall(level.matchdata_logattachmentstat, attachname, "ads_kills", self.var_e16d751a51153a7b, weapon);
  }

  if(self.trackingweaponhits > 0 && attachname != "tactical") {
    incrementattachmentstat(attachname, "hits", self.trackingweaponhits, weapon);
    utility::trycall(level.matchdata_logattachmentstat, attachname, "hits", self.trackingweaponhits, weapon);
  }

  if(self.trackingweaponheadshots > 0 && attachname != "tactical") {
    incrementattachmentstat(attachname, "headShots", self.trackingweaponheadshots, weapon);
    utility::trycall(level.matchdata_logattachmentstat, attachname, "headShots", self.trackingweaponheadshots, weapon);
  }

  if(self.trackingweapondeaths > 0) {
    incrementattachmentstat(attachname, "deaths", self.trackingweapondeaths, weapon);
    utility::trycall(level.matchdata_logattachmentstat, attachname, "deaths", self.trackingweapondeaths, weapon);
  }
}

function uploadglobalstatcounters() {
  level waittill("game_ended");

  if(!matchmakinggame()) {
    return;
  }

  totalkills = 0;
  totaldeaths = 0;
  var_74ba9cc277cbe543 = 0;
  totalheadshots = 0;
  totalsuicides = 0;
  totaltimeplayed = 0;

  foreach(player in level.players) {
    totaltimeplayed += player.timeplayed["total"];
  }

  dlog_recordevent("dlog_event_global_minutes", ["increment", int(totaltimeplayed / 60)]);

  if(isroundbased() && !waslastround()) {
    return;
  }

  waitframe();

  foreach(player in level.players) {
    totalkills += player.kills;
    totaldeaths += player.deaths;
    var_74ba9cc277cbe543 += player.assists;
    totalheadshots += player scripts\mp\utility\stats::getpersstat("headshots");
    totalsuicides += player scripts\mp\utility\stats::getpersstat("suicides");
  }

  dlog_recordevent("dlog_event_global_kills", ["increment", totalkills]);
  dlog_recordevent("dlog_event_global_deaths", ["increment", totaldeaths]);
  dlog_recordevent("dlog_event_global_headshots", ["increment", totalheadshots]);
  dlog_recordevent("dlog_event_global_suicides", ["increment", totalsuicides]);
  dlog_recordevent("dlog_event_global_games", ["increment", 1]);

  if(!isDefined(level.assists_disabled)) {
    dlog_recordevent("dlog_event_global_assists", ["increment", var_74ba9cc277cbe543]);
  }
}