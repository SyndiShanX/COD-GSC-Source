/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\_zombies_rank.gsc
*****************************************************/

init() {
  level._id_AB42 = [];
  level._id_AB36 = int(tablelookup("mp/cp_rankTable.csv", 0, "maxrank", 1));
  level.zmmaxrankfinalprestige = int(tablelookup("mp/cp_rankTable.csv", 0, "maxrankfinalprestige", 1));
  level.zmmaxprestige = int(tablelookup("mp/cp_rankTable.csv", 0, "maxprestige", 1));
  level._id_AB37 = 0;
  level.zmmaxrankxpfinalprestige = 0;
  level.zmxpscale = getzmxpscale();

  for(var_0 = 0; var_0 <= level.zmmaxrankfinalprestige; var_0++) {
    level._id_AB42[var_0][2] = _id_0547::_id_9470(tablelookup("mp/cp_rankTable.csv", 0, var_0, 2));
    level._id_AB42[var_0][3] = _id_0547::_id_9470(tablelookup("mp/cp_rankTable.csv", 0, var_0, 3));
    level._id_AB42[var_0][7] = _id_0547::_id_9470(tablelookup("mp/cp_rankTable.csv", 0, var_0, 7));
    level._id_AB42[var_0][13] = _id_0547::_id_9470(tablelookup("mp/cp_rankTable.csv", 0, var_0, 13));
    level._id_AB42[var_0][18] = tablelookup("mp/cp_rankTable.csv", 0, var_0, 18);
    level._id_AB42[var_0][19] = int(tablelookup("mp/cp_rankTable.csv", 0, var_0, 19));
  }

  level._id_AB37 = _id_AB2D(level._id_AB36);
  level.zmmaxrankxpfinalprestige = _id_AB2D(level.zmmaxrankfinalprestige);
  level._id_AB2A = [];

  if(_tableexists("mp/zombie_xp_event_table.csv")) {
    var_1 = _tablegetrowcount("mp/zombie_xp_event_table.csv");

    for(var_2 = 0; var_2 < var_1; var_2++) {
      var_3 = _id_0547::_id_9470(_tablelookupbyrow("mp/zombie_xp_event_table.csv", var_2, 2));

      if(isDefined(var_3)) {
        var_4 = _tablelookupbyrow("mp/zombie_xp_event_table.csv", var_2, 0);
        var_5 = _tablelookupbyrow("mp/zombie_xp_event_table.csv", var_2, 1);
        var_6 = _tablelookupbyrow("mp/zombie_xp_event_table.csv", var_2, 2);
        level._id_AB2A[var_4]["xp"] = var_3;
        level._id_AB2A[var_4]["splash"] = var_5;
        level._id_AB2A[var_4]["type"] = var_6;
      }
    }
  }

  level.zmxpupdatetimer = getzmxpupdatetimer();
  level.zmstatsupdatetimer = getzmstatsupdatetimer();
  level.zmshotgunmaxlevel = 0;
  level.zmshotgunmaxlevelxp = 0;

  if(_tableexists("mp/zm_shotgun_rankTable.csv")) {
    var_7 = tablelookup("mp/zm_shotgun_rankTable.csv", 0, "maxrank", 1);
    level.zmshotgunmaxlevel = int(var_7);
    var_8 = 0;
    var_9 = 0;
    var_10 = 0;
    var_11 = 0;
    var_12 = 0;
    var_13 = 0;

    for(var_14 = 0; var_8 <= level.zmshotgunmaxlevel; var_8++) {
      level.zmshotgunranktable[var_8][2] = _id_0547::_id_9470(tablelookup("mp/zm_shotgun_rankTable.csv", 0, var_8, 2));
      level.zmshotgunranktable[var_8][20] = _id_0547::_id_9470(tablelookup("mp/zm_shotgun_rankTable.csv", 0, var_8, 20));
      var_15 = int(tablelookup("mp/zm_shotgun_rankTable.csv", 0, var_8, 21));
      var_16 = int(tablelookup("mp/zm_shotgun_rankTable.csv", 0, var_8, 22));
      var_17 = int(tablelookup("mp/zm_shotgun_rankTable.csv", 0, var_8, 23));
      var_18 = int(tablelookup("mp/zm_shotgun_rankTable.csv", 0, var_8, 24));
      var_19 = int(tablelookup("mp/zm_shotgun_rankTable.csv", 0, var_8, 25));
      var_20 = int(tablelookup("mp/zm_shotgun_rankTable.csv", 0, var_8, 26));
      level.zmshotgunranktable[var_8][21] = max(var_9, var_15);
      level.zmshotgunranktable[var_8][22] = max(var_10, var_16);
      level.zmshotgunranktable[var_8][23] = max(var_11, var_17);
      level.zmshotgunranktable[var_8][24] = max(var_12, var_18);
      level.zmshotgunranktable[var_8][25] = max(var_13, var_19);
      level.zmshotgunranktable[var_8][26] = max(var_14, var_20);
      var_9 = level.zmshotgunranktable[var_8][21];
      var_10 = level.zmshotgunranktable[var_8][22];
      var_11 = level.zmshotgunranktable[var_8][23];
      var_12 = level.zmshotgunranktable[var_8][24];
      var_13 = level.zmshotgunranktable[var_8][25];
      var_14 = level.zmshotgunranktable[var_8][26];
    }

    var_21 = tablelookup("mp/zm_shotgun_rankTable.csv", 0, level.zmshotgunmaxlevel, 2);
    level.zmshotgunmaxlevelxp = int(var_21);
  }
}

getzmxpupdatetimer() {
  var_0 = getdvarfloat("5914", 1);
  return var_0;
}

getzmstatsupdatetimer() {
  var_0 = getdvarfloat("5913", 60);
  return var_0;
}

_id_536F() {
  self._id_7EFF = 0;
  self._id_7F06 = 0;
  self._id_7EFE = 0;
  self._id_7F09 = 0;
  self._id_7F10 = 0;
  self._id_7F07 = 0;
  self._id_7F04 = 0;
  self._id_7F0B = 0;
  self._id_7F0D = 0;
  self._id_7F08 = 0;
}

_id_7B39() {
  var_0 = _id_0547::_id_4745(self, "totalGames");
  setmatchdata("players", self.clientid, "start_zm_games_played", var_0);
  setmatchdata("players", self.clientid, "start_total_xp", self._id_AB46["totalXP"]);
  setmatchdata("players", self.clientid, "start_rank", self._id_AB46["rank"]);
  var_1 = _id_0547::_id_4745(self, "totalHeadshots");
  var_2 = _id_0547::_id_4745(self, "totalKills");
  var_3 = _id_0547::_id_4745(self, "totalRevives");
  var_4 = _id_0547::_id_4745(self, "totalMoneyEarned");
  var_5 = _id_0547::_id_4745(self, "totalRounds");
  setmatchdata("players", self.clientid, "start_lifetime_headshots", var_1);
  setmatchdata("players", self.clientid, "start_lifetime_kills", var_2);
  setmatchdata("players", self.clientid, "start_lifetime_revives", var_3);
  setmatchdata("players", self.clientid, "start_lifetime_score", var_4);
  setmatchdata("players", self.clientid, "start_lifetime_waves", var_5);
}

_id_5370() {
  self._id_A9BA = [];
  self._id_A9BB = 0;
  self._id_76D8 = "";
  self._id_76D9 = -1;
  self.notifiedlootservice = 0;
  self._id_AB46 = [];
  self._id_AB46["prestigeLevel"] = _id_0547::_id_4745(self, "prestigeLevel");
  self._id_AB46["maxRankXP"] = common_scripts\utility::_id_98E7(self._id_AB46["prestigeLevel"] == level.zmmaxprestige, level.zmmaxrankxpfinalprestige, level._id_AB37);
  self._id_AB46["maxRank"] = common_scripts\utility::_id_98E7(self._id_AB46["prestigeLevel"] == level.zmmaxprestige, level.zmmaxrankfinalprestige, level._id_AB36);
  self._id_AB46["totalXP"] = _id_0547::_id_4745(self, "totalXP");
  self._id_AB46["rank"] = _id_AB2C(self._id_AB46["totalXP"]);
  self._id_AB46["nextXPGoal"] = _id_AB2D(self._id_AB46["rank"]);
  self._id_AB46["xp"] = self._id_AB46["totalXP"];
  self._id_AB46["pendingXP"] = 0;
  self._id_AB46["shotgunXP"] = _id_0547::_id_4745(self, "totalShotgunXP");
  self._id_AB46["preShotgunXP"] = self._id_AB46["shotgunXP"];
  self._id_AB46["maxShotgunXP"] = level.zmshotgunmaxlevelxp;
  self._id_AB46["shotgunLevel"] = zmgetshotgunlevelbyxp(self._id_AB46["shotgunXP"]);
  self._id_AB46["totalRounds"] = _id_0547::_id_4745(self, "totalRounds");
  self._id_AB46["totalKills"] = _id_0547::_id_4745(self, "totalKills");
  self._id_AB46["totalRevives"] = _id_0547::_id_4745(self, "totalRevives");
  self._id_AB46["totalMoneyEarned"] = _id_0547::_id_4745(self, "totalMoneyEarned");
  self._id_AB46["totalMoneySpent"] = _id_0547::_id_4745(self, "totalMoneySpent");
  self._id_AB46["totalMagicBox"] = _id_0547::_id_4745(self, "totalMagicBox");
  self._id_AB46["totalTraps"] = _id_0547::_id_4745(self, "totalTraps");
  self._id_AB46["totalHeadshots"] = _id_0547::_id_4745(self, "totalHeadshots");
  self._id_AB46["totalMeleeKills"] = _id_0547::_id_4745(self, "totalMeleeKills");
  self._id_AB46["totalTimePlayed"] = _id_0547::_id_4745(self, "totalTimePlayed");
  thread zombieplayerxpupdatethink();
  thread zombieplayerstatsupdatethink();
  self.prevmapname = self getplayerdata(common_scripts\utility::_id_46A8(), "zmShatteredRecord", "prevMapName");
  self.prevmapendtime = self getplayerdata(common_scripts\utility::_id_46A8(), "zmShatteredRecord", "prevMapEndTime");
  self.prevwinstatus = self getplayerdata(common_scripts\utility::_id_46A8(), "zmShatteredRecord", "prevWinStatus");
  self.ismapinsequence = self getplayerdata(common_scripts\utility::_id_46A8(), "zmShatteredRecord", "isMapInSequence");
  self.iseeinsequence = self getplayerdata(common_scripts\utility::_id_46A8(), "zmShatteredRecord", "isEEInSequence");
  self.isredskullinsequence = self getplayerdata(common_scripts\utility::_id_46A8(), "zmShatteredRecord", "isRedSkullInSequence");
  self setplayerdata(common_scripts\utility::_id_46A8(), "zmShatteredRecord", "prevMapName", maps\mp\_utility::_id_4571());
  self setplayerdata(common_scripts\utility::_id_46A8(), "zmShatteredRecord", "prevWinStatus", 0);
  self setplayerdata(common_scripts\utility::_id_46A8(), "zmShatteredRecord", "isMapInSequence", 0);
  self setplayerdata(common_scripts\utility::_id_46A8(), "zmShatteredRecord", "isEEInSequence", 0);
  self setplayerdata(common_scripts\utility::_id_46A8(), "zmShatteredRecord", "isRedSkullInSequence", 0);
  self setplayerdata(common_scripts\utility::_id_46A8(), "getBossAttachmentLastMatch", 0);
}

zombieplayerxpupdatethink() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    if(!common_scripts\utility::_id_562E(self.notifiedlootservice) && self._id_AB46["pendingXP"] > 0) {
      self.notifiedlootservice = 1;
      _lootservicevalidateplaytime(self._id_01D6);
    }

    zombieupdateplayerxp(self._id_AB46["pendingXP"]);
    self._id_AB46["pendingXP"] = 0;
    level common_scripts\utility::waittill_notify_or_timeout("round complete", level.zmxpupdatetimer);
  }
}

zombieupdateplayerxp(var_0, var_1) {
  var_2 = level.zmxpscale;

  if(self _meth_86B4(0) > 1) {
    var_2 = max(var_2, getdvarint("party_zmXPScale"));
  }

  var_3 = int(var_0 * var_2);

  if(!isDefined(level.zm_shotgun_xp_mod)) {
    level.zm_shotgun_xp_mod = getdvarfloat("spv_zm_shotgun_xp_mod", 1.0);
  }

  if(maps\mp\_utility::iszombiegameshattermode()) {
    var_4 = level.zm_shotgun_xp_mod;
    var_3 = int(var_3 * var_4);
  }

  var_5 = self._id_AB46["xp"] + var_3;

  if(self._id_AB46["maxRankXP"] < var_5) {
    var_5 = self._id_AB46["maxRankXP"];
  }

  var_6 = var_5 - self._id_AB46["xp"];

  if(var_6 > 0) {
    self._id_AB46["xp"] = self._id_AB46["xp"] + var_6;
    _id_0547::_id_8A6C(self, "totalXP", self._id_AB46["xp"], 0);

    if(self._id_AB46["xp"] >= self._id_AB46["nextXPGoal"]) {
      _id_AC39(var_1);
    }
  }

  if(maps\mp\_utility::iszombiegameshattermode()) {
    var_7 = self._id_AB46["shotgunXP"] + var_3;

    if(self._id_AB46["maxShotgunXP"] < var_7) {
      var_7 = self._id_AB46["maxShotgunXP"];
    }

    var_8 = var_7 - self._id_AB46["shotgunXP"];

    if(var_8 > 0) {
      self._id_AB46["shotgunXP"] = self._id_AB46["shotgunXP"] + var_8;
      _id_0547::_id_8A6C(self, "totalShotgunXP", self._id_AB46["shotgunXP"], 0);

      if(self._id_AB46["shotgunLevel"] < level.zmshotgunmaxlevel) {
        if(self._id_AB46["shotgunXP"] >= zmgetshotgunlevelxprequirement(self._id_AB46["shotgunLevel"] + 1)) {
          zombieplayershotgunlvlup(var_1);
        }
      }
    }
  }
}

zombieplayerstatsupdatethink() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    level common_scripts\utility::waittill_notify_or_timeout("round complete", level.zmstatsupdatetimer);
    zombiewritestats();
  }
}

zombiewritestats() {
  var_0 = self;
  _id_0547::_id_8A6C(var_0, "totalRounds", self._id_AB46["totalRounds"] + level._id_A980, 0);
  _id_0547::_id_8A6C(var_0, "totalKills", self._id_AB46["totalKills"] + var_0._id_00E3, 0);
  _id_0547::_id_8A6C(var_0, "totalRevives", self._id_AB46["totalRevives"] + var_0._id_0021, 0);
  _id_0547::_id_8A6C(var_0, "totalMoneyEarned", self._id_AB46["totalMoneyEarned"] + var_0._id_62D7, 0);
  _id_0547::_id_8A6C(var_0, "totalMoneySpent", self._id_AB46["totalMoneySpent"] + (var_0._id_62D7 - var_0._id_62D6), 0);
  _id_0547::_id_8A6C(var_0, "totalMagicBox", self._id_AB46["totalMagicBox"] + var_0._id_5F7C, 0);
  _id_0547::_id_8A6C(var_0, "totalTraps", self._id_AB46["totalTraps"] + var_0._id_9CFF, 0);
  _id_0547::_id_8A6C(var_0, "totalHeadshots", self._id_AB46["totalHeadshots"] + var_0._id_4BF7, 0);
  _id_0547::_id_8A6C(var_0, "totalMeleeKills", self._id_AB46["totalMeleeKills"] + var_0._id_60EC, 0);
  _id_0547::_id_8A6C(var_0, "totalTimePlayed", self._id_AB46["totalTimePlayed"] + var_0._id_9A06["total"], 0);
  _id_0547::_id_8A6C(var_0, "highestRound", level._id_A980, 2);
  _id_0547::_id_8A6C(var_0, "mostKillsGame", var_0._id_00E3, 2);
  _id_0547::_id_8A6C(var_0, "mostRevives", var_0._id_0021, 2);
  _id_0547::_id_8A6C(var_0, "mostMoneyEarned", var_0._id_62D7, 2);
  _id_0547::_id_8A6C(var_0, "mostMoneySpent", var_0._id_62D7 - var_0._id_62D6, 2);
  _id_0547::_id_8A6C(var_0, "mostMagicBox", var_0._id_5F7C, 2);
  _id_0547::_id_8A6C(var_0, "mostTraps", var_0._id_9CFF, 2);
  _id_0547::_id_8A6C(var_0, "mostHeadshotsGame", var_0._id_4BF7, 2);
  _id_0547::_id_8A6C(var_0, "mostMeleeKills", var_0._id_60EC, 2);
  _id_0547::_id_8A6C(var_0, "mostTimePlayed", var_0._id_9A06["total"], 2);
  _id_0547::_id_8A6C(var_0, "mostXP", var_0._id_AB46["xp"] - var_0._id_AB46["totalXP"], 2);
}

_id_AC23(var_0) {
  if(!isDefined(level._id_AB2A[var_0])) {
    return;
  }
  if(!level.onlinegame && !getdvarint("zm_enable_lan_xp", 0)) {
    return;
  }
  if(isDefined(level.eventxpoverride)) {
    var_1 = level.eventxpoverride;
  } else {
    var_1 = level._id_AB2A[var_0]["xp"];
  }

  if(isDefined(var_1)) {
    self._id_AB46["pendingXP"] = self._id_AB46["pendingXP"] + var_1;
  }
}

_id_AC39(var_0) {
  if(self._id_AB46["rank"] == self._id_AB46["maxRank"]) {
    return;
  }
  var_1 = zmgetranklevel(self._id_AB46["rank"]);
  var_2 = _id_AB2C(self._id_AB46["xp"]);
  var_3 = zmgetranklevel(var_2);
  self._id_AB46["rank"] = var_2;
  self setrank(var_2);

  if(var_1 == 1) {
    var_4 = var_1;
  } else {
    var_4 = var_1 + 1;
  }

  for(var_5 = var_4; var_5 <= var_3; var_5++) {
    _id_0468::_id_0A25(var_5, "zm");
  }

  if(self._id_AB46["prestigeLevel"] == level.zmmaxprestige && var_3 == level._id_AB36 + 1 + 1) {
    _id_0468::_id_0A2A("zombie", 11);
  }

  if(self._id_AB46["prestigeLevel"] == level.zmmaxprestige) {
    if(var_2 == 199) {
      _id_0468::_id_0A2B("master_prestige_200");
    } else if(var_2 == 499) {
      _id_0468::_id_0A2B("master_prestige_500");
    } else if(var_2 == 999) {
      _id_0468::_id_0A2B("master_prestige_1000");
    }
  }

  if(!common_scripts\utility::_id_562E(var_0)) {
    thread maps\mp\gametypes\_hud_message::_id_7A6C(level._id_AB42[var_2][18], var_2 + 1, self._id_AB46["prestigeLevel"]);

    if(level.onlinegame) {
      if(level._id_AB42[var_2][19] != 0) {
        if(level._id_AB42[var_2][19] == 1) {
          thread maps\mp\gametypes\_hud_message::_id_9102("zm_reward_supply");
        } else if(level._id_AB42[var_2][19] == 2) {
          thread maps\mp\gametypes\_hud_message::_id_9102("zm_reward_supply_rare");
        }
      }
    }
  }

  self._id_AB46["nextXPGoal"] = _id_AB2D(var_2);
}

zombieplayershotgunlvlup(var_0) {
  if(self._id_AB46["shotgunLevel"] == level.zmshotgunmaxlevel) {
    return;
  }
  self._id_AB46["shotgunLevel"] = zmgetshotgunlevelbyxp(self._id_AB46["shotgunXP"]);
  self notify("shotgun_level_up");
  maps\mp\zombies\_zombies_progression::apply_zm_shotgun_level_perks();
}

_id_AB2C(var_0) {
  if(var_0 >= self._id_AB46["maxRankXP"]) {
    return self._id_AB46["maxRank"];
  }

  for(var_1 = 0; var_1 <= self._id_AB46["maxRank"]; var_1++) {
    if(var_0 < _id_AB2D(var_1)) {
      return var_1;
    }
  }

  var_1--;
  return var_1;
}

zmgetshotgunlevelbyxp(var_0) {
  if(var_0 >= self._id_AB46["maxShotgunXP"]) {
    return level.zmshotgunmaxlevel;
  }

  for(var_1 = 0; var_1 <= level.zmshotgunmaxlevel; var_1++) {
    if(var_0 < zmgetshotgunlevelxprequirement(var_1)) {
      var_2 = var_1 - 1;

      if(var_2 <= 0) {
        return 0;
      } else {
        return var_2;
      }
    }
  }

  var_1--;
  return var_1;
}

zmgetshotgunlevelxprequirement(var_0) {
  zmvalidatexpvaluedefinedshotgun(var_0, 2);
  return level.zmshotgunranktable[var_0][2];
}

zmvalidatexpvaluedefinedshotgun(var_0, var_1) {}

_id_AB2E(var_0) {
  _id_AB48(var_0, 2);
  return level._id_AB42[var_0][2];
}

_id_AB2D(var_0) {
  _id_AB48(var_0, 7);
  return level._id_AB42[var_0][7];
}

_id_AB2F(var_0) {
  _id_AB48(var_0, 3);
  return level._id_AB42[var_0][3];
}

zmgetranklevel(var_0) {
  return level._id_AB42[var_0][13];
}

_id_AB48(var_0, var_1) {}

getzmxpscale() {
  var_0 = getdvarint("5916", 1);
  var_1 = getdvarint("5915", 1);
  var_2 = _func_3B9("zm");
  var_3 = max(var_0, var_1);
  var_3 = max(var_3, var_2);

  if(var_3 > 2) {
    var_3 = 2;
  }

  if(var_3 > 4 || var_3 < 0) {
    exitlevel(0);
  }

  return var_3;
}