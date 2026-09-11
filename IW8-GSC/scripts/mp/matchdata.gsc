/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\matchdata.gsc
***********************************************/

function init() {
  if(getdvarint("TLRPKRKMS") != 0 && !isDefined(game["gamestarted"])) {
    setmatchdatadef("ddl/mp/matchdata.ddl");
    setmatchdata("commonMatchData", "map", level.script);

    if(level.hardcoremode) {
      var0 = scripts\mp\utility\game::getgametype() + " hc";
      setmatchdata("commonMatchData", "gametype", var0);
    } else {
      setmatchdata("commonMatchData", "gametype", scripts\mp\utility\game::getgametype());
    }

    setmatchdata("commonMatchData", "build_version", getbuildversion());
    setmatchdata("commonMatchData", "build_number", getbuildnumber());
    setmatchdata("commonMatchData", "is_private_match", scripts\mp\utility\game::privatematch());
    setmatchdata("firstOvertimeRoundIndex", -1);

    if(scripts\mp\utility\game::ismlgmatch()) {
      setmatchdata("codESportsRules", 1);
    }
  }

  if(getdvarint("TLRPKRKMS") != 0) {
    if(level.gametype == "br") {
      level.maxlogclients = 200;
    } else {
      level.maxlogclients = 30;
    }
  } else {
    level.maxlogclients = 0;
  }

  level.maxlives = 475;
  level.maxnamelength = 26;
  level.maxgameevents = 250;
  level.maxkillstreaks = 64;
  level.maxkillstreaksavailable = 64;
  level.maxnumchallengesperplayer = 10;
  level.maxnumawardsperplayer = 10;
  level.maxsupersavailable = 50;
  level.maxsupersactivated = 50;
  level.maxsupersexpired = 50;
  level.matchdataattachmentstatsenabled = 0;
  level.get_alive_nonspecating_players = scripts\mp\utility\game::getgametype() == "br" && getdvarint("scr_log_br_weapon_stats", 0) == 1;
  level.ref_11b33 = &onmatchstart;
  level.ref_11b34 = &onroundend;
  level.ref_11b2a = &logkillstreakevent;
  level.ref_11b29 = &loggameevent;
  level.ref_11b26 = &logattackerkillevent;
  level.ref_11b30 = &logvictimkillevent;
  level.ref_11b2b = &logmultikill;
  level.ref_11b2e = &logplayerlife;
  level.ref_11b2d = &logplayerdeath;
  level.ref_11b2c = &logplayerdata;
  level.ref_11b2f = &logscoreevent;
  level.ref_11b35 = &ref_12aa9;
  level.ref_11b31 = &logweaponstat;
  level.ref_11b25 = &logattachmentstat;
  level.ref_11b23 = &buildweaponrootlist;
  level.ref_11b28 = &logchallenge;
  level.ref_11b27 = &logaward;
  thread endofgamesummarylogger();
}

function onmatchstart() {
  setmatchdata("commonMatchData", "utc_start_time_s", getsystemtime());
  setmatchdata("commonMatchData", "player_count_start", level.players.size);
  var0 = scripts\mp\utility\game::getgametype();
  var1 = "";

  if(var0 == "br") {
    var1 = level.disable_super_in_turret.name;
  }

  if(level.hardcoremode) {
    var0 += " hc";
  }

  var2 = getdvarint("dlog_is_playtest");
  var3 = getDvar("MQQPLSSSLQ");
  var4 = function_042d();
  getentitylessscriptablearray("dlog_event_server_match_start", ["map", level.script, "game_type", var0, "is_playtest", var2, "experiment_name", var3, "dedi_server_guid", isdismembermentenabled(), "sub_game_type", var1, "playlist_name", var4]);

  if(var0 == "br") {
    scripts\common\utility::ref_13e0a(level.ref_11b22);
  }

  onmatchend();
}

function onroundend() {
  level.endtimeutcseconds = getsystemtime();
  setmatchdata("commonMatchData", "utc_end_time_s", level.endtimeutcseconds);
  setmatchdata("commonMatchData", "player_count_end", level.players.size);
  setmatchdata("globalPlayerXpModifier", int(scripts\mp\rank::getglobalrankxpmultiplier()));
  setmatchdata("globalWeaponXpModifier", int(scripts\mp\weaponrank::getglobalweaponrankxpmultiplier()));
}

function getmatchstarttimeutc() {
  if(getdvarint("TLRPKRKMS") == 0) {
    return level.starttimeutcseconds;
  }

  return getmatchdata("commonMatchData", "utc_start_time_s");
}

function getmatchendtimeutc() {
  if(getdvarint("TLRPKRKMS") == 0) {
    return level.endtimeutcseconds;
  }

  return getmatchdata("commonMatchData", "utc_end_time_s");
}

function gettimefrommatchstart(var0) {
  var1 = var0;

  if(isDefined(level.starttimefrommatchstart)) {
    var1 -= level.starttimefrommatchstart;

    if(var1 < 0) {
      var1 = 0;
    }
  } else {
    var1 = 0;
  }

  return var1;
}

function logkillstreakevent(var0, var1) {}

function loggameevent(var0, var1) {
  var2 = undefined;
  var3 = -1;

  if(isvalidclient(self) && scripts\mp\utility\entity::isgameparticipant(self)) {
    var2 = self;

    if(isDefined(self.matchdatalifeindex)) {
      var3 = self.matchdatalifeindex;
    }
  }

  var4 = getmatchdata("gameEventCount");
  var5 = var4 + 1;
  setmatchdata("gameEventCount", var5);
  var6 = gettimefrommatchstart(gettime());
  getentitylessscriptablearray("dlog_event_game_event", ["event_player", var2, "event_name", var0, "time_from_match_start_ms", var6, "player_life_index", var3, "pos_x", var1[0], "pos_y", var1[1], "pos_z", var1[2]]);
}

function logattackerkillevent(var0, var1) {}

function logvictimkillevent(var0, var1) {}

function logmultikill(var0, var1) {}

function logplayerlife() {
  if(!isvalidclient(self)) {
    return -1;
  }

  var0 = 0;
  var1 = (0, 0, 0);
  var2 = 0;

  if(isDefined(self.spawntime)) {
    var0 = self.spawntime;
  }

  if(isDefined(self.spawnpos)) {
    var1 = self.spawnpos;
  }

  if(isDefined(self.wasti)) {
    var2 = self.wasti;
  }

  var3 = gettimefrommatchstart(var0);
  var4 = game["life_count"];
  game["life_count"]++;
  self dlog_recordplayerevent("dlog_event_life_spawn", ["spawn_time_from_match_start_ms", var3, "life_index", var4, "spawn_pos_x", var1[0], "spawn_pos_y", var1[1], "spawn_pos_z", var1[2], "team", self.team, "is_host", self ishost(), "was_tactical_insertion", var2]);
  thread monitorweaponfire();
  return var4;
}

function monitorweaponfire() {
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("begin_firing");
    thread ref_11d21();
    var0 = self.lastdroppableweaponobj;
    var0 = scripts\mp\utility\weapon::mapweapon(var0);
    var1 = createheadicon(var0);
    thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var1, 1, "trigger_pulls");
  }
}

function ref_11d21() {
  self endon("disconnect");
  self.watch_for_players_touching_ground = gettime();
  self notify("monitorWeaponFireTime");
  self endon("monitorWeaponFireTime");
  scripts\engine\utility::waittill_either("end_firing", "death");
  self.watch_for_players_regrouping_to_plane = gettime();
}

function ref_11d78() {
  var0 = self playermounttype();

  if(isDefined(var0)) {
    switch (var0) {
      case "mount_left":
        return "MOUNT_LEFT";
      case "mount_right":
        return "MOUNT_RIGHT";
      case "mount_top":
        return "MOUNT_TOP";
    }
  }

  return "MOUNT_NONE";
}

function logplayerdeath(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(!isvalidclient(self)) {
    return;
  }

  if(var4 == "agent_mp") {
    var8 = [];
  } else {
    var8 = scripts\mp\utility\weapon::getweaponattachmentsbasenames(var5);
    var8 = scripts\mp\utility\weapon::attachmentsfilterforstats(var8, var5);
  }

  var9 = gettimefrommatchstart(gettime());
  var10 = 0;

  if(isDefined(self.spawntime)) {
    var10 = self.spawntime;
  }

  var11 = gettimefrommatchstart(var10);
  var12 = -1;
  var13 = -1;
  var14 = [];
  jumpiffalse(isvalidclient(var2)) LOC_000003b1;
  var15 = getweaponbasename(var5);
  var16 = scripts\mp\utility\weapon::safe_to_authenticate(var8);
  var17 = var2;
  var18 = var2 scripts\mp\utility\weapon::ispickedupweapon(var5);
  var19 = var2 isalternatemode(var5);

  if(scripts\mp\utility\weapon::iscacprimaryorsecondary(var5)) {
    var20 = var2 playerads();
    goto LOC_000000b4;
  }

  var20 = 0;
  var21 = 0.4226;
  var22 = scripts\engine\utility::within_fov(self.origin, self.angles, var3.origin, var21);
  var23 = scripts\engine\utility::within_fov(var3.origin, var3.angles, self.origin, var21);
  var24 = ref_11d78(var3);
  var25 = var3.origin;
  var26 = var3.angles;

  if(isDefined(var3.matchdatalifeindex)) {
    var13 = var3.matchdatalifeindex;
  }

  if(isDefined(var3.loadoutindex)) {
    var14 = var3.loadoutindex;
  }

  var27 = getplayerbuffs(var3);

  if(istrue(var27[0])) {
    var15 = "UAV_ACTIVE";
  }

  if(istrue(var27[1])) {
    var15 = "DEADSILENCE_ACTIVE";
  }

  if(istrue(var27[2])) {
    var15 = "HAS_STOPPING_POWER";
  }

  var28 = getplayerdebuffs(var3);

  if(istrue(var28[0])) {
    var15 = "CUAV_ACTIVE";
  }

  if(istrue(var28[1])) {
    var15 = "IS_MARKED";
  }

  if(istrue(var28[2])) {
    var15 = "IS_FLASHED";
  }

  if(istrue(var28[3])) {
    var15 = "IS_STUNNED";
  }

  if(istrue(var28[4])) {
    var15 = "IN_GAS";
  }

  if(istrue(var28[5])) {
    var15 = "IN_BURNING";
  }

  if(istrue(var28[6])) {
    var15 = "IS_SNAPSHOTTED";
  }

  if(istrue(var28[7])) {
    var15 = "IN_SMOKE";
  }

  if(istrue(var28[8])) {
    var15 = "IS_EMPED";
  }

  if(istrue(var28[9])) {
    var15 = "IN_WHITE_PHOSPHOROUS";
  }

  if(var3 isnightvisionon()) {
    var15 = "NVG_ENABLED";
  }

  if(isDefined(var3.modifiers)) {
    if(istrue(var3.modifiers["headshot"])) {
      var15 = "HEADSHOT";
    }

    if(istrue(var3.modifiers["avenger"])) {
      var15 = "AVENGER";
    }

    if(istrue(var3.modifiers["defender"])) {
      var15 = "DEFENDER";
    }

    if(istrue(var3.modifiers["posthumous"])) {
      var15 = "POSTHUMOUS";
    }

    if(istrue(var3.modifiers["revenge"])) {
      var15 = "REVENGE";
    }

    if(istrue(var3.modifiers["buzzkill"])) {
      var15 = "BUZZKILL";
    }

    if(istrue(var3.modifiers["firstblood"])) {
      var15 = "FIRSTBLOOD";
    }

    if(istrue(var3.modifiers["comeback"])) {
      var15 = "COMEBACK";
    }

    if(istrue(var3.modifiers["longshot"])) {
      var15 = "LONGSHOT";
    }

    if(istrue(var3.modifiers["pointblank"])) {
      var15 = "POINTBLANK";
    }

    if(istrue(var3.modifiers["assistedsuicide"])) {
      var15 = "ASSISTED_SUICIDE";
    }
  }

  if(scripts\mp\utility\weapon::iskillstreakweapon(var16)) {
    var15 = "KILLSTREAK";
  }

  goto LOC_00000416;
}

function getplayerbuffs() {
  var0 = [];
  GscBinSkip0(0x2e, 0, scripts\cp_mp\utility\killstreak_utility::teamhasuav(self.team));
}

function getplayerdebuffs() {
  var0 = gettime();
  var1 = [];
  GscBinSkip0(0x2e, 0, scripts\cp_mp\utility\killstreak_utility::enemyhascuav(self.team));
}

function ref_119cc(var0) {
  if(isDefined(var0)) {
    var1 = var0;
  } else {
    var1 = "";
  }

  if(level.teambased) {
    var2 = int(scripts\mp\rank::getteamrankxpmultiplier(self.team));
  } else {
    var2 = 0;
  }

  var3 = 0;
  var4 = 0;
  var5 = 0;
  var6 = 0;
  var7 = 0;
  var8 = 0;
  var9 = 0;

  if(scripts\mp\utility\game::onlinestatsenabled()) {
    if(isDefined(self.pers["summary"]["xp"])) {
      var3 = self.pers["summary"]["xp"];
    }

    if(isDefined(self.pers["summary"]["score"])) {
      var4 = self.pers["summary"]["score"];
    }

    if(isDefined(self.pers["summary"]["challenge"])) {
      var5 = self.pers["summary"]["challenge"];
    }

    if(isDefined(self.pers["summary"]["match"])) {
      var6 = self.pers["summary"]["match"];
    }

    if(isDefined(self.pers["summary"]["medal"])) {
      var7 = self.pers["summary"]["medal"];
    }

    if(isDefined(self.pers["summary"]["bonusXp"])) {
      var8 = self.pers["summary"]["bonusXp"];
    }

    if(isDefined(self.pers["summary"]["misc"])) {
      var9 = self.pers["summary"]["misc"];
    }
  }

  var10 = scripts\mp\rank::getrankxp();
  var11 = scripts\mp\rank::getrankforxp(var10);

  if(scripts\mp\utility\game::rankingenabled() && self hasplayerdata()) {
    var12 = self getplayerdata("common", "mpProgression", "playerLevel", "xp");
    var13 = self getplayerdata("mp", "playerStats", "combatStats", "kills");
    var14 = self getplayerdata("mp", "playerStats", "combatStats", "deaths");
    var15 = self getplayerdata("mp", "playerStats", "matchStats", "wins");
    var16 = self getplayerdata("mp", "playerStats", "matchStats", "losses");
    var17 = self getplayerdata("mp", "playerStats", "combatStats", "hits");
    var18 = self getplayerdata("mp", "playerStats", "combatStats", "misses");
    var19 = self getplayerdata("mp", "playerStats", "combatStats", "wallbangs");
    var20 = self getplayerdata("mp", "playerStats", "combatStats", "nearMisses");
    var21 = self getplayerdata("mp", "playerStats", "matchStats", "gamesPlayed");
    var22 = self getplayerdata("mp", "playerStats", "matchStats", "timePlayedTotal");
    var23 = self getplayerdata("mp", "playerStats", "matchStats", "score");
    var24 = self getplayerdata(level.loadoutsgroup, "squadMembers", "season_rank");
    var25 = self getplayerdata(level.loadoutsgroup, "squadMembers", "season_rank");
  } else {
    var12 = 0;
    var13 = 0;
    var14 = 0;
    var15 = 0;
    var16 = 0;
    var17 = 0;
    var18 = 0;
    var19 = 0;
    var20 = 0;
    var21 = 0;
    var22 = 0;
    var23 = 0;
    var24 = 0;
    var25 = 0;
  }

  var26 = -1;
  var27 = 0;
  var28 = 0;

  if(isDefined(var14)) {
    if(scripts\mp\utility\game::isroundbased()) {
      var26 = game["roundsPlayed"];
    }

    if(level.teambased) {
      if(isDefined(self.team)) {
        if(self.team == "allies") {
          var27 = getteamscore("allies");
          var28 = getteamscore("axis");
        } else if(self.team == "axis") {
          var27 = getteamscore("axis");
          var28 = getteamscore("allies");
        }
      }
    }
  }

  jumpiffalse(isDefined(self.segments) && self.segments["movementUpdateCount"] >= 30) LOC_000003e6;
  var29 = self.segments["movingTotal"] / self.segments["movementUpdateCount"] / 5 * 100;
  var30 = self.segments["distanceTotal"] / self.segments["movementUpdateCount"];
  goto LOC_000003f6;
}

function initdialog() {
  if(!scripts\mp\utility\game::onlinestatsenabled()) {
    return;
  }

  if(!scripts\mp\utility\game::rankingenabled()) {
    return;
  }

  if(!self hasplayerdata()) {
    return;
  }

  var0 = scripts\mp\utility\game::getgametype();
  var1 = scripts\mp\utility\stats::getpersstat("kills");
  var2 = scripts\mp\utility\stats::getpersstat("deaths");
  var3 = scripts\mp\utility\stats::getpersstat("headshots");
  var4 = scripts\mp\utility\stats::getpersstat("assists");
  var5 = scripts\mp\utility\stats::getpersstat("suicides");
  var6 = scripts\mp\utility\stats::getpersstat("score");
  var7 = scripts\mp\rank::getrankxp();
  var8 = scripts\mp\rank::getrankforxp(var7);
  var9 = scripts\mp\utility\stats::getpersstat("utc_connect_time_s");
  var10 = getsystemtime() - var9;
  self getcurrentusereloadconfig(var0, var1, var2, var3, var4, var5, var6, var8, var10);
}

function logplayerdata(var0) {
  if(!isvalidclient(self)) {
    return;
  }

  var1 = self getplayerdata(level.loadoutsgroup, "squadMembers", "player_xp");
  ref_119cc(var0);
  initdialog();

  if(!isai(self) && !scripts\mp\utility\game::rankingenabled()) {
    var2 = scripts\mp\rank::initcpammoarmorcrate(self);
    scripts\mp\rank::initcprooftopcrate(self.initdismembermentlist, var2);
  }

  self sendclientnetworktelemetry();
  self radiusdamagestepped();
  var3 = 0;
  var4 = 0;

  foreach(var6 in self.pers["matchdataWeaponStats"]) {
    var7 = 0;
    var8 = 0;
    var9 = 0;
    var10 = 0;
    var11 = 0;
    var12 = 0;
    var13 = 0;
    var14 = 0;
    var15 = 0;

    if(scripts\mp\utility\game::getgametype() != "br") {
      if(isenumvaluevalid("common", "LoadoutWeapon", var6.weapon)) {
        var7 = self getplayerdata(level.loadoutsgroup, "squadMembers", "weapon_xp", var6.weapon);
      }
    }

    foreach(var18, var17 in var6.stats) {
      if(var18 == "deaths") {
        var9 += var17;
      }

      if(var18 == "headshots") {
        var10 += var17;
      }

      if(var18 == "hits") {
        var11 += var17;
        var4 += var17;
      }

      if(var18 == "kills") {
        var12 += var17;
      }

      if(var18 == "shots") {
        var13 += var17;
        var3 += var17;
      }

      if(var18 == "xp_earned") {
        var8 += var17;
      }

      if(var18 == "damage") {
        var14 += var17;
      }

      if(var18 == "friendly_fire_damage") {
        var15 += var17;
      }
    }

    if(scripts\mp\utility\game::getgametype() != "br") {
      self dlog_recordplayerevent("dlog_event_player_weapon_stats", ["weapon", var6.weapon, "variant_id", var6.variantid, "loadout_index", var6.loadoutindex, "starting_weapon_xp", var7, "xp_earned", var8, "deaths", var9, "headshots", var10, "hits", var11, "kills", var12, "shots", var13, "damage", var14, "friendly_fire_damage", var15]);
      continue;
    }

    var19 = isDefined(var6.iscustomweapon);
    var20 = 0;
    var21 = 0;
    var22 = 0;

    if(isDefined(var6.stats["time_used_s"])) {
      var22 = var6.stats["time_used_s"];
    }

    self dlog_recordplayerevent("dlog_event_player_weapon_stats_br", ["weapon", var6.weapon, "variant_id", var6.variantid, "from_loadout", var19, "died", var20, "time_used_s", var22, "longest_hit_distance", var21, "deaths", var9, "headshots", var10, "hits", var11, "kills", var12, "shots", var13, "damage", var14, "attachment_0", var6.attachments[0], "attachment_1", var6.attachments[1], "attachment_2", var6.attachments[2], "attachment_3", var6.attachments[3], "attachment_4", var6.attachments[4], "sticker_0", var6.ref_138a8[0], "sticker_1", var6.ref_138a8[1], "sticker_2", var6.ref_138a8[2], "sticker_3", var6.ref_138a8[3], "reticle", var6.reticle, "cosmetic_attachment", var6.impactfunc_carbon, "camo", var6.camo, "match_time_created_s", var6.pickuptime]);
  }
}

function logscoreevent(var0) {
  if(scripts\mp\utility\entity::isgameparticipant(self) == 0) {
    return;
  }

  if(!isvalidclient(self)) {
    return;
  }

  if(isbot(self) || initmaxspeedforpathlengthtable(self) || isai(self)) {
    return;
  }

  var1 = gettimefrommatchstart(gettime());
  self dlog_recordplayerevent("dlog_event_player_score_event", ["time_ms_from_match_start", var1, "score_event", var0]);
}

function ref_13154(var0) {
  if(getdvarint("OMKTLMMNPT") == 1) {
    var0 setplayerdata("common", "round", "gameModeModifier", "tactical");
    return;
  }

  if(getdvarint("MSQTTNSTNO") == 1) {
    var0 setplayerdata("common", "round", "gameModeModifier", "hardcore");
    return;
  }

  var0 setplayerdata("common", "round", "gameModeModifier", "normal");
}

function endofgamesummarylogger() {
  level waittill("game_ended", var0);

  foreach(var2 in level.players) {
    wait 0.05;

    if(!isDefined(var2)) {
      continue;
    }

    if(isDefined(var2.weaponsused)) {
      doublebubblesort(var2);
      var3 = 0;

      if(var2.weaponsused.size > 3) {
        for(var4 = var2.weaponsused.size - 1; var4 > var2.weaponsused.size - 3; var4--) {
          var2 setplayerdata("common", "round", "weaponsUsed", var3, var2.weaponsused[var4]);
          var2 setplayerdata("common", "round", "weaponXpEarned", var3, var2.weaponxpearned[var4]);
          var3++;
        }
      } else {
        for(var4 = var2.weaponsused.size - 1; var4 >= 0; var4--) {
          var2 setplayerdata("common", "round", "weaponsUsed", var3, var2.weaponsused[var4]);
          var2 setplayerdata("common", "round", "weaponXpEarned", var3, var2.weaponxpearned[var4]);
          var3++;
        }
      }
    } else {
      var2 setplayerdata("common", "round", "weaponsUsed", 0, "none");
      var2 setplayerdata("common", "round", "weaponsUsed", 1, "none");
      var2 setplayerdata("common", "round", "weaponsUsed", 2, "none");
      var2 setplayerdata("common", "round", "weaponXpEarned", 0, 0);
      var2 setplayerdata("common", "round", "weaponXpEarned", 1, 0);
      var2 setplayerdata("common", "round", "weaponXpEarned", 2, 0);
    }

    if(isDefined(var2.challengescompleted)) {
      var2 setplayerdata("common", "round", "challengeNumCompleted", var2.challengescompleted.size);
    } else {
      var2 setplayerdata("common", "round", "challengeNumCompleted", 0);
    }

    for(var4 = 0; var4 < 20; var4++) {
      if(isDefined(var2.challengescompleted) && isDefined(var2.challengescompleted[var4]) && var2.challengescompleted[var4] != "ch_prestige" && !issubstr(var2.challengescompleted[var4], "_daily") && !issubstr(var2.challengescompleted[var4], "_weekly")) {
        var2 setplayerdata("common", "round", "challengesCompleted", var4, var2.challengescompleted[var4]);
        continue;
      }

      var2 setplayerdata("common", "round", "challengesCompleted", var4, "ch_none");
    }

    var5 = tolower(getDvar("mapname"));
    var2 setplayerdata("common", "round", "gameMode", scripts\mp\utility\game::getgametype());
    var2 setplayerdata("common", "round", "map", var5);
    ref_13154(var2);
  }
}

function ref_12aa9() {
  if(scripts\mp\utility\game::matchmakinggame()) {
    var0 = tolower(getDvar("mapname"));
    var1 = getdvarint("NLTOPSKPQM");

    foreach(var3 in level.players) {
      for(var4 = 31; var4 > 0; var4--) {
        var5 = var3 getplayerdata("mp", "mapsPlayed", var4 - 1);
        var3 setplayerdata("mp", "mapsPlayed", var4, var5);
      }

      var3 setplayerdata("mp", "mapsPlayed", 0, var0);

      for(var4 = 4; var4 > 0; var4--) {
        var6 = var3 getplayerdata("mp", "playlistIdsPlayed", var4 - 1);
        var3 setplayerdata("mp", "playlistIdsPlayed", var4, var6);
      }

      var3 setplayerdata("mp", "playlistIdsPlayed", 0, var1);
    }

    return;
  }
}

function doublebubblesort() {
  var0 = self.weaponxpearned;
  var1 = self.weaponxpearned.size;

  for(var2 = var1 - 1; var2 > 0; var2--) {
    for(var3 = 1; var3 <= var2; var3++) {
      if(var0[var3 - 1] < var0[var3]) {
        var4 = self.weaponsused[var3];
        self.weaponsused[var3] = self.weaponsused[var3 - 1];
        self.weaponsused[var3 - 1] = var4;
        var5 = self.weaponxpearned[var3];
        self.weaponxpearned[var3] = self.weaponxpearned[var3 - 1];
        self.weaponxpearned[var3 - 1] = var5;
        var0 = self.weaponxpearned;
      }
    }
  }
}

function isvalidclient(var0) {
  if(istrue(game["isLaunchChunk"])) {
    return false;
  }

  if(!isDefined(var0)) {
    return false;
  } else if(isagent(var0)) {
    return false;
  } else if(!isPlayer(var0)) {
    return false;
  }

  return true;
}

function canlogclient(var0) {
  if(isvalidclient(var0)) {
    return (var0.clientid < level.maxlogclients);
  }

  return 0;
}

function canloglife(var0) {
  return var0 < level.maxlives;
}

function logweaponstat(var0, var1, var2, var3, var4) {
  if(scripts\mp\utility\weapon::iskillstreakweapon(var0) || scripts\mp\utility\weapon::isvehicleweapon(var0)) {
    return;
  }

  if(scripts\mp\utility\game::getgametype() == "br" && !istrue(level.get_alive_nonspecating_players)) {
    return;
  }

  var5 = var0;

  if(scripts\mp\utility\game::getgametype() != "br") {
    if(isDefined(self.loadoutindex)) {
      var5 = var5 + "+loadoutIndex" + self.loadoutindex;
    } else {
      return;
    }
  } else if(isDefined(self.pers["matchdataWeaponStats"][var5]) && isDefined(var4)) {
    if(!getjuggmazebutton(var4, var5)) {
      var6 = 1;

      for(var7 = var5 + "_" + var6;; var7 = var5 + "_" + var6) {
        if(!isDefined(self.pers["matchdataWeaponStats"][var7]) || getjuggmazebutton(var4, var7)) {
          break;
        }

        var6++;
      }

      var5 = var7;
    }
  }

  if(!isDefined(self.pers["matchdataWeaponStats"][var5])) {
    self.pers["matchdataWeaponStats"][var5] = spawnStruct();
    self.pers["matchdataWeaponStats"][var5].stats = [];
    self.pers["matchdataWeaponStats"][var5].weapon = var0;
    self.pers["matchdataWeaponStats"][var5].loadoutindex = self.loadoutindex;

    if(isDefined(var3)) {
      self.pers["matchdataWeaponStats"][var5].variantid = var3;
    } else {
      self.pers["matchdataWeaponStats"][var5].variantid = -1;
    }

    if(scripts\mp\utility\game::getgametype() == "br" && isDefined(var4)) {
      var8 = scripts\engine\utility::ter_op(isDefined(var4.camo), var4.camo, "none");
      var9 = scripts\engine\utility::ter_op(isDefined(var4.visual), var4.visual, "none");
      var10 = scripts\engine\utility::ter_op(isDefined(var4.reticle), var4.reticle, "none");
      self.pers["matchdataWeaponStats"][var5].iscustomweapon = isDefined(var4.customweaponname);
      self.pers["matchdataWeaponStats"][var5].camo = var8;
      self.pers["matchdataWeaponStats"][var5].impactfunc_carbon = var9;
      self.pers["matchdataWeaponStats"][var5].reticle = var10;
      self.pers["matchdataWeaponStats"][var5].pickuptime = scripts\cp_mp\utility\game_utility::gettimesincegamestart();
      var11 = scripts\mp\utility\weapon::getweaponattachmentsbasenames(var4);
      var12 = [];

      for(var13 = 0; var13 < 5; var13++) {
        var12 = "none";
      }

      var14 = 0;

      foreach(var16 in var11) {
        if(scripts\mp\utility\weapon::attachmentlogsstats(var16, var4)) {
          var12 = var16;
          var14++;
        }
      }

      self.pers["matchdataWeaponStats"][var5].attachments = var12;
      var18 = [];
      GscBinSkip0(0x2e, var18.size, var4.stickerslot0);
    }
  }

  if(!isDefined(self.pers["matchdataWeaponStats"][var18].stats[var14])) {
    self.pers["matchdataWeaponStats"][var18].stats[var14] = var15;
    return;
  }

  self.pers["matchdataWeaponStats"][var18].stats[var14] = self.pers["matchdataWeaponStats"][var18].stats[var14] + var15;
}

function getjuggmazebutton(var0, var1) {
  var2 = scripts\engine\utility::ter_op(isDefined(var0.camo), var0.camo, "none");

  if(var2 != self.pers["matchdataWeaponStats"][var1].camo) {
    return false;
  }

  var3 = scripts\engine\utility::ter_op(isDefined(var0.visual), var0.visual, "none");

  if(var3 != self.pers["matchdataWeaponStats"][var1].impactfunc_carbon) {
    return false;
  }

  var4 = scripts\engine\utility::ter_op(isDefined(var0.reticle), var0.reticle, "none");

  if(var4 != self.pers["matchdataWeaponStats"][var1].reticle) {
    return false;
  }

  var5 = scripts\mp\utility\weapon::getweaponattachmentsbasenames(var0);

  if(var5.size != self.pers["matchdataWeaponStats"][var1].attachments.size) {
    return false;
  }

  for(var6 = 0; var6 < var5.size; var6++) {
    if(var5[var6] != self.pers["matchdataWeaponStats"][var1].attachments[var6]) {
      return false;
    }
  }

  var7 = [];
  GscBinSkip0(0x2e, var7.size, var0.stickerslot0);
}

function logattachmentstat(var0, var1, var2, var3) {
  if(!level.matchdataattachmentstatsenabled) {
    return;
  }
}

function buildweaponrootlist() {
  var0 = [];
  var1 = 149;

  for(var2 = 0; var2 <= var1; var2++) {
    var3 = tablelookup("mp/statstable.csv", 0, var2, 4);
    var4 = tablelookup("mp/statstable.csv", 0, var2, 2);

    if(!issubstr(var4, "weapon_")) {
      continue;
    }

    if(var4 == "weapon_other") {
      continue;
    }

    var0 = var3;
  }

  return var0;
}

function logchallenge(var0, var1) {}

function logaward(var0) {
  if(!isvalidclient(self)) {
    return;
  }

  if(isbot(self) || initmaxspeedforpathlengthtable(self) || isai(self)) {
    return;
  }

  var1 = gettimefrommatchstart(gettime());
  self dlog_recordplayerevent("dlog_event_player_award", ["time_ms_from_match_start", var1, "award", var0]);
}