/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\_zombies_rank.gsc
*********************************************/

func_00D5() {
  level.var_AB42 = [];
  level.var_AB36 = int(tablelookup("mp/cp_rankTable.csv", 0, "maxrank", 1));
  level.zmmaxrankfinalprestige = int(tablelookup("mp/cp_rankTable.csv", 0, "maxrankfinalprestige", 1));
  level.zmmaxprestige = int(tablelookup("mp/cp_rankTable.csv", 0, "maxprestige", 1));
  level.var_AB37 = 0;
  level.zmmaxrankxpfinalprestige = 0;
  level.zmxpscale = getzmxpscale();
  for(var_00 = 0; var_00 <= level.zmmaxrankfinalprestige; var_00++) {
    level.var_AB42[var_00][2] = lib_0547::func_9470(tablelookup("mp/cp_rankTable.csv", 0, var_00, 2));
    level.var_AB42[var_00][3] = lib_0547::func_9470(tablelookup("mp/cp_rankTable.csv", 0, var_00, 3));
    level.var_AB42[var_00][7] = lib_0547::func_9470(tablelookup("mp/cp_rankTable.csv", 0, var_00, 7));
    level.var_AB42[var_00][13] = lib_0547::func_9470(tablelookup("mp/cp_rankTable.csv", 0, var_00, 13));
    level.var_AB42[var_00][18] = tablelookup("mp/cp_rankTable.csv", 0, var_00, 18);
    level.var_AB42[var_00][19] = int(tablelookup("mp/cp_rankTable.csv", 0, var_00, 19));
  }

  level.var_AB37 = func_AB2D(level.var_AB36);
  level.zmmaxrankxpfinalprestige = func_AB2D(level.zmmaxrankfinalprestige);
  level.var_AB2A = [];
  if(tableexists("mp/zombie_xp_event_table.csv")) {
    var_01 = function_027A("mp/zombie_xp_event_table.csv");
    for(var_02 = 0; var_02 < var_01; var_02++) {
      var_03 = lib_0547::func_9470(tablelookupbyrow("mp/zombie_xp_event_table.csv", var_02, 2));
      if(isDefined(var_03)) {
        var_04 = tablelookupbyrow("mp/zombie_xp_event_table.csv", var_02, 0);
        var_05 = tablelookupbyrow("mp/zombie_xp_event_table.csv", var_02, 1);
        var_06 = tablelookupbyrow("mp/zombie_xp_event_table.csv", var_02, 2);
        level.var_AB2A[var_04]["xp"] = var_03;
        level.var_AB2A[var_04]["splash"] = var_05;
        level.var_AB2A[var_04]["type"] = var_06;
      }
    }
  }

  level.zmxpupdatetimer = getzmxpupdatetimer();
  level.zmstatsupdatetimer = getzmstatsupdatetimer();
  level.zmshotgunmaxlevel = 0;
  level.zmshotgunmaxlevelxp = 0;
  if(tableexists("mp/zm_shotgun_rankTable.csv")) {
    var_07 = tablelookup("mp/zm_shotgun_rankTable.csv", 0, "maxrank", 1);
    level.zmshotgunmaxlevel = int(var_07);
    var_08 = 0;
    var_09 = 0;
    var_0A = 0;
    var_0B = 0;
    var_0C = 0;
    var_0D = 0;
    var_0E = 0;
    while(var_08 <= level.zmshotgunmaxlevel) {
      level.zmshotgunranktable[var_08][2] = lib_0547::func_9470(tablelookup("mp/zm_shotgun_rankTable.csv", 0, var_08, 2));
      level.zmshotgunranktable[var_08][20] = lib_0547::func_9470(tablelookup("mp/zm_shotgun_rankTable.csv", 0, var_08, 20));
      var_0F = int(tablelookup("mp/zm_shotgun_rankTable.csv", 0, var_08, 21));
      var_10 = int(tablelookup("mp/zm_shotgun_rankTable.csv", 0, var_08, 22));
      var_11 = int(tablelookup("mp/zm_shotgun_rankTable.csv", 0, var_08, 23));
      var_12 = int(tablelookup("mp/zm_shotgun_rankTable.csv", 0, var_08, 24));
      var_13 = int(tablelookup("mp/zm_shotgun_rankTable.csv", 0, var_08, 25));
      var_14 = int(tablelookup("mp/zm_shotgun_rankTable.csv", 0, var_08, 26));
      level.zmshotgunranktable[var_08][21] = max(var_09, var_0F);
      level.zmshotgunranktable[var_08][22] = max(var_0A, var_10);
      level.zmshotgunranktable[var_08][23] = max(var_0B, var_11);
      level.zmshotgunranktable[var_08][24] = max(var_0C, var_12);
      level.zmshotgunranktable[var_08][25] = max(var_0D, var_13);
      level.zmshotgunranktable[var_08][26] = max(var_0E, var_14);
      var_09 = level.zmshotgunranktable[var_08][21];
      var_0A = level.zmshotgunranktable[var_08][22];
      var_0B = level.zmshotgunranktable[var_08][23];
      var_0C = level.zmshotgunranktable[var_08][24];
      var_0D = level.zmshotgunranktable[var_08][25];
      var_0E = level.zmshotgunranktable[var_08][26];
      var_08++;
    }

    var_15 = tablelookup("mp/zm_shotgun_rankTable.csv", 0, level.zmshotgunmaxlevel, 2);
    level.zmshotgunmaxlevelxp = int(var_15);
  }
}

getzmxpupdatetimer() {
  var_00 = getdvarfloat("5914", 1);
  return var_00;
}

getzmstatsupdatetimer() {
  var_00 = getdvarfloat("5913", 60);
  return var_00;
}

func_536F() {
  self.var_7EFF = 0;
  self.var_7F06 = 0;
  self.var_7EFE = 0;
  self.var_7F09 = 0;
  self.var_7F10 = 0;
  self.var_7F07 = 0;
  self.var_7F04 = 0;
  self.var_7F0B = 0;
  self.var_7F0D = 0;
  self.var_7F08 = 0;
}

func_7B39() {
  var_00 = lib_0547::func_4745(self, "totalGames");
  setmatchdata("players", self.var_2418, "start_zm_games_played", var_00);
  setmatchdata("players", self.var_2418, "start_total_xp", self.var_AB46["totalXP"]);
  setmatchdata("players", self.var_2418, "start_rank", self.var_AB46["rank"]);
  var_01 = lib_0547::func_4745(self, "totalHeadshots");
  var_02 = lib_0547::func_4745(self, "totalKills");
  var_03 = lib_0547::func_4745(self, "totalRevives");
  var_04 = lib_0547::func_4745(self, "totalMoneyEarned");
  var_05 = lib_0547::func_4745(self, "totalRounds");
  setmatchdata("players", self.var_2418, "start_lifetime_headshots", var_01);
  setmatchdata("players", self.var_2418, "start_lifetime_kills", var_02);
  setmatchdata("players", self.var_2418, "start_lifetime_revives", var_03);
  setmatchdata("players", self.var_2418, "start_lifetime_score", var_04);
  setmatchdata("players", self.var_2418, "start_lifetime_waves", var_05);
}

func_5370() {
  self.var_A9BA = [];
  self.var_A9BB = 0;
  self.var_76D8 = "";
  self.var_76D9 = -1;
  self.notifiedlootservice = 0;
  self.var_AB46 = [];
  self.var_AB46["prestigeLevel"] = lib_0547::func_4745(self, "prestigeLevel");
  self.var_AB46["maxRankXP"] = common_scripts\utility::func_98E7(self.var_AB46["prestigeLevel"] == level.zmmaxprestige, level.zmmaxrankxpfinalprestige, level.var_AB37);
  self.var_AB46["maxRank"] = common_scripts\utility::func_98E7(self.var_AB46["prestigeLevel"] == level.zmmaxprestige, level.zmmaxrankfinalprestige, level.var_AB36);
  self.var_AB46["totalXP"] = lib_0547::func_4745(self, "totalXP");
  self.var_AB46["rank"] = func_AB2C(self.var_AB46["totalXP"]);
  self.var_AB46["nextXPGoal"] = func_AB2D(self.var_AB46["rank"]);
  self.var_AB46["xp"] = self.var_AB46["totalXP"];
  self.var_AB46["pendingXP"] = 0;
  self.var_AB46["shotgunXP"] = lib_0547::func_4745(self, "totalShotgunXP");
  self.var_AB46["preShotgunXP"] = self.var_AB46["shotgunXP"];
  self.var_AB46["maxShotgunXP"] = level.zmshotgunmaxlevelxp;
  self.var_AB46["shotgunLevel"] = zmgetshotgunlevelbyxp(self.var_AB46["shotgunXP"]);
  self.var_AB46["totalRounds"] = lib_0547::func_4745(self, "totalRounds");
  self.var_AB46["totalKills"] = lib_0547::func_4745(self, "totalKills");
  self.var_AB46["totalRevives"] = lib_0547::func_4745(self, "totalRevives");
  self.var_AB46["totalMoneyEarned"] = lib_0547::func_4745(self, "totalMoneyEarned");
  self.var_AB46["totalMoneySpent"] = lib_0547::func_4745(self, "totalMoneySpent");
  self.var_AB46["totalMagicBox"] = lib_0547::func_4745(self, "totalMagicBox");
  self.var_AB46["totalTraps"] = lib_0547::func_4745(self, "totalTraps");
  self.var_AB46["totalHeadshots"] = lib_0547::func_4745(self, "totalHeadshots");
  self.var_AB46["totalMeleeKills"] = lib_0547::func_4745(self, "totalMeleeKills");
  self.var_AB46["totalTimePlayed"] = lib_0547::func_4745(self, "totalTimePlayed");
  thread zombieplayerxpupdatethink();
  thread zombieplayerstatsupdatethink();
  self.prevmapname = self getrankedplayerdata(common_scripts\utility::func_46A8(), "zmShatteredRecord", "prevMapName");
  self.prevmapendtime = self getrankedplayerdata(common_scripts\utility::func_46A8(), "zmShatteredRecord", "prevMapEndTime");
  self.prevwinstatus = self getrankedplayerdata(common_scripts\utility::func_46A8(), "zmShatteredRecord", "prevWinStatus");
  self.ismapinsequence = self getrankedplayerdata(common_scripts\utility::func_46A8(), "zmShatteredRecord", "isMapInSequence");
  self.iseeinsequence = self getrankedplayerdata(common_scripts\utility::func_46A8(), "zmShatteredRecord", "isEEInSequence");
  self.isredskullinsequence = self getrankedplayerdata(common_scripts\utility::func_46A8(), "zmShatteredRecord", "isRedSkullInSequence");
  self setrankedplayerdata(common_scripts\utility::func_46A8(), "zmShatteredRecord", "prevMapName", maps\mp\_utility::func_4571());
  self setrankedplayerdata(common_scripts\utility::func_46A8(), "zmShatteredRecord", "prevWinStatus", 0);
  self setrankedplayerdata(common_scripts\utility::func_46A8(), "zmShatteredRecord", "isMapInSequence", 0);
  self setrankedplayerdata(common_scripts\utility::func_46A8(), "zmShatteredRecord", "isEEInSequence", 0);
  self setrankedplayerdata(common_scripts\utility::func_46A8(), "zmShatteredRecord", "isRedSkullInSequence", 0);
  self setrankedplayerdata(common_scripts\utility::func_46A8(), "getBossAttachmentLastMatch", 0);
}

zombieplayerxpupdatethink() {
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    if(!common_scripts\utility::func_562E(self.notifiedlootservice) && self.var_AB46["pendingXP"] > 0) {
      self.notifiedlootservice = 1;
      lootservicevalidateplaytime(self.var_01D6);
    }

    zombieupdateplayerxp(self.var_AB46["pendingXP"]);
    self.var_AB46["pendingXP"] = 0;
    level common_scripts\utility::func_A74B("round complete", level.zmxpupdatetimer);
  }
}

zombieupdateplayerxp(param_00, param_01) {
  var_02 = level.zmxpscale;
  if(self method_86B4(0) > 1) {
    var_02 = max(var_02, getdvarint("party_zmXPScale"));
  }

  var_03 = int(param_00 * var_02);
  if(!isDefined(level.zm_shotgun_xp_mod)) {
    level.zm_shotgun_xp_mod = getdvarfloat("spv_zm_shotgun_xp_mod", 1);
  }

  if(maps\mp\_utility::iszombiegameshattermode()) {
    var_04 = level.zm_shotgun_xp_mod;
    var_03 = int(var_03 * var_04);
  }

  var_05 = self.var_AB46["xp"] + var_03;
  if(self.var_AB46["maxRankXP"] < var_05) {
    var_05 = self.var_AB46["maxRankXP"];
  }

  var_06 = var_05 - self.var_AB46["xp"];
  if(var_06 > 0) {
    self.var_AB46["xp"] = self.var_AB46["xp"] + var_06;
    lib_0547::func_8A6C(self, "totalXP", self.var_AB46["xp"], 0);
    if(self.var_AB46["xp"] >= self.var_AB46["nextXPGoal"]) {
      func_AC39(param_01);
    }
  }

  if(maps\mp\_utility::iszombiegameshattermode()) {
    var_07 = self.var_AB46["shotgunXP"] + var_03;
    if(self.var_AB46["maxShotgunXP"] < var_07) {
      var_07 = self.var_AB46["maxShotgunXP"];
    }

    var_08 = var_07 - self.var_AB46["shotgunXP"];
    if(var_08 > 0) {
      self.var_AB46["shotgunXP"] = self.var_AB46["shotgunXP"] + var_08;
      lib_0547::func_8A6C(self, "totalShotgunXP", self.var_AB46["shotgunXP"], 0);
      if(self.var_AB46["shotgunLevel"] < level.zmshotgunmaxlevel) {
        if(self.var_AB46["shotgunXP"] >= zmgetshotgunlevelxprequirement(self.var_AB46["shotgunLevel"] + 1)) {
          zombieplayershotgunlvlup(param_01);
          return;
        }

        return;
      }
    }
  }
}

zombieplayerstatsupdatethink() {
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    level common_scripts\utility::func_A74B("round complete", level.zmstatsupdatetimer);
    zombiewritestats();
  }
}

zombiewritestats() {
  var_00 = self;
  lib_0547::func_8A6C(var_00, "totalRounds", self.var_AB46["totalRounds"] + level.var_A980, 0);
  lib_0547::func_8A6C(var_00, "totalKills", self.var_AB46["totalKills"] + var_00.var_00E3, 0);
  lib_0547::func_8A6C(var_00, "totalRevives", self.var_AB46["totalRevives"] + var_00.var_0021, 0);
  lib_0547::func_8A6C(var_00, "totalMoneyEarned", self.var_AB46["totalMoneyEarned"] + var_00.var_62D7, 0);
  lib_0547::func_8A6C(var_00, "totalMoneySpent", self.var_AB46["totalMoneySpent"] + var_00.var_62D7 - var_00.var_62D6, 0);
  lib_0547::func_8A6C(var_00, "totalMagicBox", self.var_AB46["totalMagicBox"] + var_00.var_5F7C, 0);
  lib_0547::func_8A6C(var_00, "totalTraps", self.var_AB46["totalTraps"] + var_00.var_9CFF, 0);
  lib_0547::func_8A6C(var_00, "totalHeadshots", self.var_AB46["totalHeadshots"] + var_00.var_4BF7, 0);
  lib_0547::func_8A6C(var_00, "totalMeleeKills", self.var_AB46["totalMeleeKills"] + var_00.var_60EC, 0);
  lib_0547::func_8A6C(var_00, "totalTimePlayed", self.var_AB46["totalTimePlayed"] + var_00.var_9A06["total"], 0);
  lib_0547::func_8A6C(var_00, "highestRound", level.var_A980, 2);
  lib_0547::func_8A6C(var_00, "mostKillsGame", var_00.var_00E3, 2);
  lib_0547::func_8A6C(var_00, "mostRevives", var_00.var_0021, 2);
  lib_0547::func_8A6C(var_00, "mostMoneyEarned", var_00.var_62D7, 2);
  lib_0547::func_8A6C(var_00, "mostMoneySpent", var_00.var_62D7 - var_00.var_62D6, 2);
  lib_0547::func_8A6C(var_00, "mostMagicBox", var_00.var_5F7C, 2);
  lib_0547::func_8A6C(var_00, "mostTraps", var_00.var_9CFF, 2);
  lib_0547::func_8A6C(var_00, "mostHeadshotsGame", var_00.var_4BF7, 2);
  lib_0547::func_8A6C(var_00, "mostMeleeKills", var_00.var_60EC, 2);
  lib_0547::func_8A6C(var_00, "mostTimePlayed", var_00.var_9A06["total"], 2);
  lib_0547::func_8A6C(var_00, "mostXP", var_00.var_AB46["xp"] - var_00.var_AB46["totalXP"], 2);
}

func_AC23(param_00) {
  if(!isDefined(level.var_AB2A[param_00])) {
    return;
  }

  if(!level.var_6B4D && !getdvarint("zm_enable_lan_xp", 0)) {
    return;
  }

  if(isDefined(level.eventxpoverride)) {
    var_01 = level.eventxpoverride;
  } else {
    var_01 = level.var_AB2A[var_01]["xp"];
  }

  if(isDefined(var_01)) {
    self.var_AB46["pendingXP"] = self.var_AB46["pendingXP"] + var_01;
  }
}

func_AC39(param_00) {
  if(self.var_AB46["rank"] == self.var_AB46["maxRank"]) {
    return;
  }

  var_01 = zmgetranklevel(self.var_AB46["rank"]);
  var_02 = func_AB2C(self.var_AB46["xp"]);
  var_03 = zmgetranklevel(var_02);
  self.var_AB46["rank"] = var_02;
  self setrank(var_02);
  if(var_01 == 1) {
    var_04 = var_01;
  } else {
    var_04 = var_02 + 1;
  }

  for(var_05 = var_04; var_05 <= var_03; var_05++) {
    lib_0468::func_0A25(var_05, "zm");
  }

  if(self.var_AB46["prestigeLevel"] == level.zmmaxprestige && var_03 == level.var_AB36 + 1 + 1) {
    lib_0468::func_0A2A("zombie", 11);
  }

  if(self.var_AB46["prestigeLevel"] == level.zmmaxprestige) {
    if(var_02 == 199) {
      lib_0468::func_0A2B("master_prestige_200");
    } else if(var_02 == 499) {
      lib_0468::func_0A2B("master_prestige_500");
    } else if(var_02 == 999) {
      lib_0468::func_0A2B("master_prestige_1000");
    }
  }

  if(!common_scripts\utility::func_562E(param_00)) {
    thread maps\mp\gametypes\_hud_message::func_7A6C(level.var_AB42[var_02][18], var_02 + 1, self.var_AB46["prestigeLevel"]);
    if(level.var_6B4D) {
      if(level.var_AB42[var_02][19] != 0) {
        if(level.var_AB42[var_02][19] == 1) {
          thread maps\mp\gametypes\_hud_message::func_9102("zm_reward_supply");
        } else if(level.var_AB42[var_02][19] == 2) {
          thread maps\mp\gametypes\_hud_message::func_9102("zm_reward_supply_rare");
        }
      }
    }
  }

  self.var_AB46["nextXPGoal"] = func_AB2D(var_02);
}

zombieplayershotgunlvlup(param_00) {
  if(self.var_AB46["shotgunLevel"] == level.zmshotgunmaxlevel) {
    return;
  }

  self.var_AB46["shotgunLevel"] = zmgetshotgunlevelbyxp(self.var_AB46["shotgunXP"]);
  self notify("shotgun_level_up");
  maps\mp\zombies\_zombies_progression::apply_zm_shotgun_level_perks();
}

func_AB2C(param_00) {
  if(param_00 >= self.var_AB46["maxRankXP"]) {
    return self.var_AB46["maxRank"];
  }

  for(var_01 = 0; var_01 <= self.var_AB46["maxRank"]; var_01++) {
    if(param_00 < func_AB2D(var_01)) {
      return var_01;
    }
  }

  var_01--;
  return var_01;
}

zmgetshotgunlevelbyxp(param_00) {
  if(param_00 >= self.var_AB46["maxShotgunXP"]) {
    return level.zmshotgunmaxlevel;
  }

  var_01 = 0;
  while(var_01 <= level.zmshotgunmaxlevel) {
    if(param_00 < zmgetshotgunlevelxprequirement(var_01)) {
      var_02 = var_01 - 1;
      if(var_02 <= 0) {
        return 0;
      } else {
        return var_02;
      }
    }

    var_02++;
  }

  var_01--;
  return var_01;
}

zmgetshotgunlevelxprequirement(param_00) {
  zmvalidatexpvaluedefinedshotgun(param_00, 2);
  return level.zmshotgunranktable[param_00][2];
}

zmvalidatexpvaluedefinedshotgun(param_00, param_01) {}

func_AB2E(param_00) {
  func_AB48(param_00, 2);
  return level.var_AB42[param_00][2];
}

func_AB2D(param_00) {
  func_AB48(param_00, 7);
  return level.var_AB42[param_00][7];
}

func_AB2F(param_00) {
  func_AB48(param_00, 3);
  return level.var_AB42[param_00][3];
}

zmgetranklevel(param_00) {
  return level.var_AB42[param_00][13];
}

func_AB48(param_00, param_01) {}

getzmxpscale() {
  var_00 = getdvarint("5916", 1);
  var_01 = getdvarint("5915", 1);
  var_02 = function_03B9("zm");
  var_03 = max(var_00, var_01);
  var_03 = max(var_03, var_02);
  if(var_03 > 2) {
    var_03 = 2;
  }

  if(var_03 > 4 || var_03 < 0) {
    exitlevel(0);
  }

  return var_03;
}