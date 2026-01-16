/**********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\gametypes\_persistence.gsc
**********************************************/

init() {
  level.persistentdatainfo = [];
  maps\mp\gametypes\_class::init();
  maps\mp\gametypes\_missions::init();
  maps\mp\gametypes\_playercards::init();
  maps\mp\gametypes\_rank::init();

  if(getdvarint("virtualLobbyActive", 0) > 0) {
    return;
  }
  level thread updatebufferedstats();
  level thread uploadglobalstatcounters();
}

initbufferedstats() {
  self.bufferedstats = [];

  if(maps\mp\_utility::rankingenabled()) {
    self.bufferedstats["totalShots"] = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "totalShots");
    self.bufferedstats["accuracy"] = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "accuracy");
    self.bufferedstats["misses"] = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "misses");
    self.bufferedstats["hits"] = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "hits");
    self.bufferedstats["timePlayedAllies"] = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "timePlayedAllies");
    self.bufferedstats["timePlayedOpfor"] = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "timePlayedOpfor");
    self.bufferedstats["timePlayedOther"] = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "timePlayedOther");
    self.bufferedstats["timePlayedTotal"] = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "timePlayedTotal");
  }

  self.bufferedchildstats = [];
  self.bufferedchildstats["round"] = [];
  self.bufferedchildstats["round"]["timePlayed"] = self getplayerdata(common_scripts\utility::getstatsgroup_common(), "round", "timePlayed");
}

statget(var_0) {
  return self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), var_0);
}

statset(var_0, var_1) {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), var_0, var_1);
}

statadd(var_0, var_1, var_2) {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  if(isdefined(var_2)) {
    var_3 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), var_0, var_2);
    self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), var_0, var_2, var_1 + var_3);
  } else {
    var_3 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), var_0);
    self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), var_0, var_1 + var_3);
  }
}

statgetchild(var_0, var_1) {
  if(var_0 == "round")
    return self getplayerdata(common_scripts\utility::getstatsgroup_common(), var_0, var_1);
  else
    return self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), var_0, var_1);
}

statsetchild(var_0, var_1, var_2) {
  if(isagent(self)) {
    return;
  }
  if(maps\mp\_utility::invirtuallobby()) {
    return;
  }
  if(var_0 == "round")
    self setplayerdata(common_scripts\utility::getstatsgroup_common(), var_0, var_1, var_2);
  else {
    if(!maps\mp\_utility::rankingenabled()) {
      return;
    }
    self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), var_0, var_1, var_2);
  }
}

stataddchild(var_0, var_1, var_2) {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  var_3 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), var_0, var_1);
  self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), var_0, var_1, var_3 + var_2);
}

statgetchildbuffered(var_0, var_1) {
  if(!maps\mp\_utility::rankingenabled())
    return 0;

  return self.bufferedchildstats[var_0][var_1];
}

statsetchildbuffered(var_0, var_1, var_2) {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  self.bufferedchildstats[var_0][var_1] = var_2;
}

stataddchildbuffered(var_0, var_1, var_2) {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  var_3 = statgetchildbuffered(var_0, var_1);
  statsetchildbuffered(var_0, var_1, var_3 + var_2);
}

stataddbufferedwithmax(var_0, var_1, var_2) {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  var_3 = statgetbuffered(var_0) + var_1;

  if(var_3 > var_2)
    var_3 = var_2;

  if(var_3 < statgetbuffered(var_0))
    var_3 = var_2;

  statsetbuffered(var_0, var_3);
}

stataddchildbufferedwithmax(var_0, var_1, var_2, var_3) {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  var_4 = statgetchildbuffered(var_0, var_1) + var_2;

  if(var_4 > var_3)
    var_4 = var_3;

  if(var_4 < statgetchildbuffered(var_0, var_1))
    var_4 = var_3;

  statsetchildbuffered(var_0, var_1, var_4);
}

statgetbuffered(var_0) {
  if(!maps\mp\_utility::rankingenabled())
    return 0;

  return self.bufferedstats[var_0];
}

statsetbuffered(var_0, var_1) {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  self.bufferedstats[var_0] = var_1;
}

stataddbuffered(var_0, var_1) {
  if(!maps\mp\_utility::rankingenabled()) {
    return;
  }
  var_2 = statgetbuffered(var_0);
  statsetbuffered(var_0, var_2 + var_1);
}

updatebufferedstats() {
  wait 0.15;
  var_0 = 0;

  while (!level.gameended) {
    maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
    var_0++;

    if(var_0 >= level.players.size)
      var_0 = 0;

    if(isdefined(level.players[var_0])) {
      level.players[var_0] writebufferedstats();
      level.players[var_0] updateweaponbufferedstats();
    }

    wait 2.0;
  }

  foreach(var_2 in level.players) {
    var_2 writebufferedstats();
    var_2 updateweaponbufferedstats();
  }
}

writebufferedstats() {
  var_0 = maps\mp\_utility::rankingenabled();

  if(var_0) {
    foreach(var_3, var_2 in self.bufferedstats)
    self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), var_3, var_2);
  }

  foreach(var_3, var_2 in self.bufferedchildstats) {
    foreach(var_7, var_6 in var_2) {
      if(var_3 == "round") {
        self setplayerdata(common_scripts\utility::getstatsgroup_common(), var_3, var_7, var_6);
        continue;
      }

      if(var_0)
        self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), var_3, var_7, var_6);
    }
  }
}

incrementweaponstat(var_0, var_1, var_2) {
  if(maps\mp\_utility::iskillstreakweapon(var_0)) {
    return;
  }
  if(isdefined(level.disableweaponstats) && level.disableweaponstats) {
    return;
  }
  if(maps\mp\_utility::rankingenabled()) {
    var_3 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "weaponStats", var_0, var_1);
    self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "weaponStats", var_0, var_1, var_3 + var_2);
  }
}

incrementattachmentstat(var_0, var_1, var_2) {
  if(maps\mp\_utility::rankingenabled()) {
    var_3 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "attachmentsStats", var_0, var_1);
    self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "attachmentsStats", var_0, var_1, var_3 + var_2);
  }
}

incrementmeleestat(var_0) {
  if(maps\mp\_utility::rankingenabled()) {
    if(!isdefined(var_0))
      var_0 = 1;

    var_1 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "meleeKills");
    self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "meleeKills", var_1 + var_0);
  }
}

incrementdestructiblestat(var_0) {
  if(maps\mp\_utility::rankingenabled()) {
    if(!isdefined(var_0))
      var_0 = 1;

    var_1 = self getplayerdata(common_scripts\utility::getstatsgroup_ranked(), "destructibleKills");
    self setplayerdata(common_scripts\utility::getstatsgroup_ranked(), "destructibleKills", var_1 + var_0);
  }
}

doesattachkitincludebaseattachment(var_0, var_1) {
  var_2 = "mp\attachkits.csv";
  var_3 = 1;
  var_4 = 2;
  var_5 = 5;
  var_6 = tablelookuprownum(var_2, var_3, var_0);

  if(var_6 < 0)
    return 0;

  for (var_7 = var_4; var_7 <= var_5; var_7++) {
    var_8 = tablelookupbyrow(var_2, var_6, var_7);

    if(var_8 == var_1)
      return 1;

    if(var_8 == "")
      return 0;
  }

  return 0;
}

updateweaponbufferedstats() {
  if(!isdefined(self.trackingweaponname)) {
    return;
  }
  if(self.trackingweaponname == "" || self.trackingweaponname == "none") {
    return;
  }
  var_0 = self.trackingweaponname;

  if(maps\mp\_utility::iskillstreakweapon(var_0) || maps\mp\_utility::isenvironmentweapon(var_0)) {
    return;
  }
  var_1 = maps\mp\_utility::getweaponnametokens(var_0);

  if(var_1[0] == "iw5" || var_1[0] == "h1")
    var_1[0] = var_1[0] + "_" + var_1[1];

  if(var_1[0] == "alt") {
    foreach(var_3 in var_1) {
      if(var_3 == "glmwr") {
        var_1[0] = "glmwr";
        break;
      } else if(var_3 == "masterkeymwr") {
        var_1[0] = "masterkeymwr";
        break;
      } else if(getsubstr(var_3, 0, 2) == "a#") {
        var_4 = getsubstr(var_3, 2);

        if(doesattachkitincludebaseattachment(var_4, "glmwr")) {
          var_1[0] = "glmwr";
          break;
        } else if(doesattachkitincludebaseattachment(var_4, "masterkeymwr")) {
          var_1[0] = "masterkeymwr";
          break;
        }
      }
    }

    if(var_1[0] == "alt")
      var_1[0] = var_1[1] + "_" + var_1[2];
  }

  if(var_1[0] == "glmwr" || var_1[0] == "masterkeymwr") {
    if(self.trackingweaponshots > 0)
      incrementattachmentstat(var_1[0], "shots", self.trackingweaponshots);

    if(self.trackingweaponkills > 0)
      incrementattachmentstat(var_1[0], "kills", self.trackingweaponkills);

    if(self.trackingweaponhits > 0)
      incrementattachmentstat(var_1[0], "hits", self.trackingweaponhits);

    if(self.trackingweaponheadshots > 0)
      incrementattachmentstat(var_1[0], "headShots", self.trackingweaponheadshots);

    if(self.trackingweapondeaths > 0)
      incrementattachmentstat(var_1[0], "deaths", self.trackingweapondeaths);

    if(self.trackingweaponhipfirekills > 0)
      incrementattachmentstat(var_1[0], "hipfirekills", self.trackingweaponhipfirekills);

    if(self.trackingweaponusetime > 0)
      incrementattachmentstat(var_1[0], "timeInUse", self.trackingweaponusetime);

    self.trackingweaponname = "none";
    self.trackingweaponshots = 0;
    self.trackingweaponkills = 0;
    self.trackingweaponhits = 0;
    self.trackingweaponheadshots = 0;
    self.trackingweapondeaths = 0;
    self.trackingweaponhipfirekills = 0;
    self.trackingweaponusetime = 0;
    return;
  }

  if(!maps\mp\_utility::iscacprimaryweapon(var_1[0]) && !maps\mp\_utility::iscacsecondaryweapon(var_1[0]) && !maps\mp\_utility::iscacmeleeweapon(var_1[0])) {
    return;
  }
  if(self.trackingweaponshots > 0) {
    incrementweaponstat(var_1[0], "shots", self.trackingweaponshots);
    maps\mp\_matchdata::logweaponstat(var_1[0], "shots", self.trackingweaponshots);
  }

  if(self.trackingweaponkills > 0) {
    incrementweaponstat(var_1[0], "kills", self.trackingweaponkills);
    maps\mp\_matchdata::logweaponstat(var_1[0], "kills", self.trackingweaponkills);
  }

  if(self.trackingweaponhits > 0) {
    incrementweaponstat(var_1[0], "hits", self.trackingweaponhits);
    maps\mp\_matchdata::logweaponstat(var_1[0], "hits", self.trackingweaponhits);
  }

  if(self.trackingweaponheadshots > 0) {
    incrementweaponstat(var_1[0], "headShots", self.trackingweaponheadshots);
    maps\mp\_matchdata::logweaponstat(var_1[0], "headShots", self.trackingweaponheadshots);
  }

  if(self.trackingweapondeaths > 0) {
    incrementweaponstat(var_1[0], "deaths", self.trackingweapondeaths);
    maps\mp\_matchdata::logweaponstat(var_1[0], "deaths", self.trackingweapondeaths);
  }

  if(self.trackingweaponhipfirekills > 0) {
    incrementweaponstat(var_1[0], "hipfirekills", self.trackingweaponhipfirekills);
    maps\mp\_matchdata::logweaponstat(var_1[0], "hipfirekills", self.trackingweaponhipfirekills);
  }

  if(self.trackingweaponusetime > 0) {
    incrementweaponstat(var_1[0], "timeInUse", self.trackingweaponusetime);
    maps\mp\_matchdata::logweaponstat(var_1[0], "timeInUse", self.trackingweaponusetime);
  }

  var_6 = getweaponattachments(var_0);

  foreach(var_8 in var_6) {
    var_9 = maps\mp\_utility::attachmentmap_tobase(var_8);

    if(var_9 == "bloodmwr") {
      continue;
    }
    if(var_9 == "glmwr" || var_9 == "masterkeymwr") {
      continue;
    }
    if(var_9 == "glpremwr" || var_9 == "masterkeypremwr") {
      continue;
    }
    if(self.trackingweaponshots > 0) {
      if(var_9 != "tacknifemwr")
        incrementattachmentstat(var_9, "shots", self.trackingweaponshots);
    }

    if(self.trackingweaponkills > 0) {
      if(var_9 != "tacknifemwr")
        incrementattachmentstat(var_9, "kills", self.trackingweaponkills);
    }

    if(self.trackingweaponhits > 0) {
      if(var_9 != "tacknifemwr")
        incrementattachmentstat(var_9, "hits", self.trackingweaponhits);
    }

    if(self.trackingweaponheadshots > 0) {
      if(var_9 != "tacknifemwr")
        incrementattachmentstat(var_9, "headShots", self.trackingweaponheadshots);
    }

    if(self.trackingweaponhipfirekills > 0) {
      if(var_9 != "tacknifemwr")
        incrementattachmentstat(var_9, "hipfirekills", self.trackingweaponhipfirekills);
    }

    if(self.trackingweaponusetime > 0) {
      if(var_9 != "tacknifemwr")
        incrementattachmentstat(var_9, "timeInUse", self.trackingweaponusetime);
    }

    if(self.trackingweapondeaths > 0)
      incrementattachmentstat(var_9, "deaths", self.trackingweapondeaths);
  }

  self.trackingweaponname = "none";
  self.trackingweaponshots = 0;
  self.trackingweaponkills = 0;
  self.trackingweaponhits = 0;
  self.trackingweaponheadshots = 0;
  self.trackingweapondeaths = 0;
  self.trackingweaponhipfirekills = 0;
  self.trackingweaponusetime = 0;
}

uploadglobalstatcounters() {
  level waittill("game_ended");

  if(!maps\mp\_utility::matchmakinggame()) {
    return;
  }
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;

  foreach(var_7 in level.players)
  var_5 = var_5 + var_7.timeplayed["total"];

  incrementcounter("global_minutes", int(var_5 / 60));

  if(!maps\mp\_utility::waslastround()) {
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

  incrementcounter("global_kills", var_0);
  incrementcounter("global_deaths", var_1);
  incrementcounter("global_assists", var_2);
  incrementcounter("global_headshots", var_3);
  incrementcounter("global_suicides", var_4);
  incrementcounter("global_games", 1);
}