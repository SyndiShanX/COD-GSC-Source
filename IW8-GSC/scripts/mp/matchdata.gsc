/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\matchdata.gsc
***********************************************/

function init() {
  if(getdvarint("TLRPKRKMS") != 0 && !isDefined(game["gamestarted"])) {
    setmatchdatadef("ddl/mp/matchdata.ddl");
    setmatchdata("commonMatchData", "map", level.script);

    if(level.hardcoremode) {
      var_0 = scripts\mp\utility\game::getgametype() + " hc";
      setmatchdata("commonMatchData", "gametype", var_0);
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
  var_0 = scripts\mp\utility\game::getgametype();
  var_1 = "";

  if(var_0 == "br") {
    var_1 = level.disable_super_in_turret.name;
  }

  if(level.hardcoremode) {
    var_0 += " hc";
  }

  var_2 = getdvarint("dlog_is_playtest");
  var_3 = getDvar("MQQPLSSSLQ");
  var_4 = function_042d();
  getentitylessscriptablearray("dlog_event_server_match_start", ["map", level.script, "game_type", var_0, "is_playtest", var_2, "experiment_name", var_3, "dedi_server_guid", isdismembermentenabled(), "sub_game_type", var_1, "playlist_name", var_4]);

  if(var_0 == "br") {
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

function gettimefrommatchstart(var_0) {
  var_1 = var_0;

  if(isDefined(level.starttimefrommatchstart)) {
    var_1 -= level.starttimefrommatchstart;

    if(var_1 < 0) {
      var_1 = 0;
    }
  } else {
    var_1 = 0;
  }

  return var_1;
}

function logkillstreakevent(var_0, var_1) {}

function loggameevent(var_0, var_1) {
  var_2 = undefined;
  var_3 = -1;

  if(isvalidclient(self) && scripts\mp\utility\entity::isgameparticipant(self)) {
    var_2 = self;

    if(isDefined(self.matchdatalifeindex)) {
      var_3 = self.matchdatalifeindex;
    }
  }

  var_4 = getmatchdata("gameEventCount");
  var_5 = var_4 + 1;
  setmatchdata("gameEventCount", var_5);
  var_6 = gettimefrommatchstart(gettime());
  getentitylessscriptablearray("dlog_event_game_event", ["event_player", var_2, "event_name", var_0, "time_from_match_start_ms", var_6, "player_life_index", var_3, "pos_x", var_1[0], "pos_y", var_1[1], "pos_z", var_1[2]]);
}

function logattackerkillevent(var_0, var_1) {}

function logvictimkillevent(var_0, var_1) {}

function logmultikill(var_0, var_1) {}

function logplayerlife() {
  if(!isvalidclient(self)) {
    return -1;
  }

  var_0 = 0;
  var_1 = (0, 0, 0);
  var_2 = 0;

  if(isDefined(self.spawntime)) {
    var_0 = self.spawntime;
  }

  if(isDefined(self.spawnpos)) {
    var_1 = self.spawnpos;
  }

  if(isDefined(self.wasti)) {
    var_2 = self.wasti;
  }

  var_3 = gettimefrommatchstart(var_0);
  var_4 = game["life_count"];
  game["life_count"]++;
  self dlog_recordplayerevent("dlog_event_life_spawn", ["spawn_time_from_match_start_ms", var_3, "life_index", var_4, "spawn_pos_x", var_1[0], "spawn_pos_y", var_1[1], "spawn_pos_z", var_1[2], "team", self.team, "is_host", self ishost(), "was_tactical_insertion", var_2]);
  thread monitorweaponfire();
  return var_4;
}

function monitorweaponfire() {
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("begin_firing");
    thread ref_11d21();
    var_0 = self.lastdroppableweaponobj;
    var_0 = scripts\mp\utility\weapon::mapweapon(var_0);
    var_1 = createheadicon(var_0);
    thread scripts\mp\gamelogic::threadedsetweaponstatbyname(var_1, 1, "trigger_pulls");
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
  var_0 = self playermounttype();

  if(isDefined(var_0)) {
    switch (var_0) {
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

function logplayerdeath(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(!isvalidclient(self)) {
    return;
  }

  if(var_4 == "agent_mp") {
    var_8 = [];
  } else {
    var_8 = scripts\mp\utility\weapon::getweaponattachmentsbasenames(var_5);
    var_8 = scripts\mp\utility\weapon::attachmentsfilterforstats(var_8, var_5);
  }

  var_9 = gettimefrommatchstart(gettime());
  var_10 = 0;

  if(isDefined(self.spawntime)) {
    var_10 = self.spawntime;
  }

  var_11 = gettimefrommatchstart(var_10);
  var_12 = -1;
  var_13 = -1;
  var_14 = [];
  jumpiffalse(isvalidclient(var_2)) LOC_000003b1;
  var_15 = getweaponbasename(var_5);
  var_16 = scripts\mp\utility\weapon::safe_to_authenticate(var_8);
  var_17 = var_2;
  var_18 = var_2 scripts\mp\utility\weapon::ispickedupweapon(var_5);
  var_19 = var_2 isalternatemode(var_5);

  if(scripts\mp\utility\weapon::iscacprimaryorsecondary(var_5)) {
    var_20 = var_2 playerads();
    goto LOC_000000b4;
  }

  var_20 = 0;
  var_21 = 0.4226;
  var_22 = scripts\engine\utility::within_fov(self.origin, self.angles, var_3.origin, var_21);
  var_23 = scripts\engine\utility::within_fov(var_3.origin, var_3.angles, self.origin, var_21);
  var_24 = ref_11d78(var_3);
  var_25 = var_3.origin;
  var_26 = var_3.angles;

  if(isDefined(var_3.matchdatalifeindex)) {
    var_13 = var_3.matchdatalifeindex;
  }

  if(isDefined(var_3.loadoutindex)) {
    var_14 = var_3.loadoutindex;
  }

  var_27 = getplayerbuffs(var_3);

  if(istrue(var_27[0])) {
    var_15 = "UAV_ACTIVE";
  }

  if(istrue(var_27[1])) {
    var_15 = "DEADSILENCE_ACTIVE";
  }

  if(istrue(var_27[2])) {
    var_15 = "HAS_STOPPING_POWER";
  }

  var_28 = getplayerdebuffs(var_3);

  if(istrue(var_28[0])) {
    var_15 = "CUAV_ACTIVE";
  }

  if(istrue(var_28[1])) {
    var_15 = "IS_MARKED";
  }

  if(istrue(var_28[2])) {
    var_15 = "IS_FLASHED";
  }

  if(istrue(var_28[3])) {
    var_15 = "IS_STUNNED";
  }

  if(istrue(var_28[4])) {
    var_15 = "IN_GAS";
  }

  if(istrue(var_28[5])) {
    var_15 = "IN_BURNING";
  }

  if(istrue(var_28[6])) {
    var_15 = "IS_SNAPSHOTTED";
  }

  if(istrue(var_28[7])) {
    var_15 = "IN_SMOKE";
  }

  if(istrue(var_28[8])) {
    var_15 = "IS_EMPED";
  }

  if(istrue(var_28[9])) {
    var_15 = "IN_WHITE_PHOSPHOROUS";
  }

  if(var_3 isnightvisionon()) {
    var_15 = "NVG_ENABLED";
  }

  if(isDefined(var_3.modifiers)) {
    if(istrue(var_3.modifiers["headshot"])) {
      var_15 = "HEADSHOT";
    }

    if(istrue(var_3.modifiers["avenger"])) {
      var_15 = "AVENGER";
    }

    if(istrue(var_3.modifiers["defender"])) {
      var_15 = "DEFENDER";
    }

    if(istrue(var_3.modifiers["posthumous"])) {
      var_15 = "POSTHUMOUS";
    }

    if(istrue(var_3.modifiers["revenge"])) {
      var_15 = "REVENGE";
    }

    if(istrue(var_3.modifiers["buzzkill"])) {
      var_15 = "BUZZKILL";
    }

    if(istrue(var_3.modifiers["firstblood"])) {
      var_15 = "FIRSTBLOOD";
    }

    if(istrue(var_3.modifiers["comeback"])) {
      var_15 = "COMEBACK";
    }

    if(istrue(var_3.modifiers["longshot"])) {
      var_15 = "LONGSHOT";
    }

    if(istrue(var_3.modifiers["pointblank"])) {
      var_15 = "POINTBLANK";
    }

    if(istrue(var_3.modifiers["assistedsuicide"])) {
      var_15 = "ASSISTED_SUICIDE";
    }
  }

  if(scripts\mp\utility\weapon::iskillstreakweapon(var_16)) {
    var_15 = "KILLSTREAK";
  }

  goto LOC_00000416;
}

function getplayerbuffs() {
  var_0 = [];
  GscBinSkip0(0x2e, 0, scripts\cp_mp\utility\killstreak_utility::teamhasuav(self.team));
}

function getplayerdebuffs() {
  var_0 = gettime();
  var_1 = [];
  GscBinSkip0(0x2e, 0, scripts\cp_mp\utility\killstreak_utility::enemyhascuav(self.team));
}

function ref_119cc(var_0) {
  if(isDefined(var_0)) {
    var_1 = var_0;
  } else {
    var_1 = "";
  }

  if(level.teambased) {
    var_2 = int(scripts\mp\rank::getteamrankxpmultiplier(self.team));
  } else {
    var_2 = 0;
  }

  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;

  if(scripts\mp\utility\game::onlinestatsenabled()) {
    if(isDefined(self.pers["summary"]["xp"])) {
      var_3 = self.pers["summary"]["xp"];
    }

    if(isDefined(self.pers["summary"]["score"])) {
      var_4 = self.pers["summary"]["score"];
    }

    if(isDefined(self.pers["summary"]["challenge"])) {
      var_5 = self.pers["summary"]["challenge"];
    }

    if(isDefined(self.pers["summary"]["match"])) {
      var_6 = self.pers["summary"]["match"];
    }

    if(isDefined(self.pers["summary"]["medal"])) {
      var_7 = self.pers["summary"]["medal"];
    }

    if(isDefined(self.pers["summary"]["bonusXp"])) {
      var_8 = self.pers["summary"]["bonusXp"];
    }

    if(isDefined(self.pers["summary"]["misc"])) {
      var_9 = self.pers["summary"]["misc"];
    }
  }

  var_10 = scripts\mp\rank::getrankxp();
  var_11 = scripts\mp\rank::getrankforxp(var_10);

  if(scripts\mp\utility\game::rankingenabled() && self hasplayerdata()) {
    var_12 = self getplayerdata("common", "mpProgression", "playerLevel", "xp");
    var_13 = self getplayerdata("mp", "playerStats", "combatStats", "kills");
    var_14 = self getplayerdata("mp", "playerStats", "combatStats", "deaths");
    var_15 = self getplayerdata("mp", "playerStats", "matchStats", "wins");
    var_16 = self getplayerdata("mp", "playerStats", "matchStats", "losses");
    var_17 = self getplayerdata("mp", "playerStats", "combatStats", "hits");
    var_18 = self getplayerdata("mp", "playerStats", "combatStats", "misses");
    var_19 = self getplayerdata("mp", "playerStats", "combatStats", "wallbangs");
    var_20 = self getplayerdata("mp", "playerStats", "combatStats", "nearMisses");
    var_21 = self getplayerdata("mp", "playerStats", "matchStats", "gamesPlayed");
    var_22 = self getplayerdata("mp", "playerStats", "matchStats", "timePlayedTotal");
    var_23 = self getplayerdata("mp", "playerStats", "matchStats", "score");
    var_24 = self getplayerdata(level.loadoutsgroup, "squadMembers", "season_rank");
    var_25 = self getplayerdata(level.loadoutsgroup, "squadMembers", "season_rank");
  } else {
    var_12 = 0;
    var_13 = 0;
    var_14 = 0;
    var_15 = 0;
    var_16 = 0;
    var_17 = 0;
    var_18 = 0;
    var_19 = 0;
    var_20 = 0;
    var_21 = 0;
    var_22 = 0;
    var_23 = 0;
    var_24 = 0;
    var_25 = 0;
  }

  var_26 = -1;
  var_27 = 0;
  var_28 = 0;

  if(isDefined(var_14)) {
    if(scripts\mp\utility\game::isroundbased()) {
      var_26 = game["roundsPlayed"];
    }

    if(level.teambased) {
      if(isDefined(self.team)) {
        if(self.team == "allies") {
          var_27 = getteamscore("allies");
          var_28 = getteamscore("axis");
        } else if(self.team == "axis") {
          var_27 = getteamscore("axis");
          var_28 = getteamscore("allies");
        }
      }
    }
  }

  jumpiffalse(isDefined(self.segments) && self.segments["movementUpdateCount"] >= 30) LOC_000003e6;
  var_29 = self.segments["movingTotal"] / self.segments["movementUpdateCount"] / 5 * 100;
  var_30 = self.segments["distanceTotal"] / self.segments["movementUpdateCount"];
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

  var_0 = scripts\mp\utility\game::getgametype();
  var_1 = scripts\mp\utility\stats::getpersstat("kills");
  var_2 = scripts\mp\utility\stats::getpersstat("deaths");
  var_3 = scripts\mp\utility\stats::getpersstat("headshots");
  var_4 = scripts\mp\utility\stats::getpersstat("assists");
  var_5 = scripts\mp\utility\stats::getpersstat("suicides");
  var_6 = scripts\mp\utility\stats::getpersstat("score");
  var_7 = scripts\mp\rank::getrankxp();
  var_8 = scripts\mp\rank::getrankforxp(var_7);
  var_9 = scripts\mp\utility\stats::getpersstat("utc_connect_time_s");
  var_10 = getsystemtime() - var_9;
  self getcurrentusereloadconfig(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_8, var_10);
}

function logplayerdata(var_0) {
  if(!isvalidclient(self)) {
    return;
  }

  var_1 = self getplayerdata(level.loadoutsgroup, "squadMembers", "player_xp");
  ref_119cc(var_0);
  initdialog();

  if(!isai(self) && !scripts\mp\utility\game::rankingenabled()) {
    var_2 = scripts\mp\rank::initcpammoarmorcrate(self);
    scripts\mp\rank::initcprooftopcrate(self.initdismembermentlist, var_2);
  }

  self sendclientnetworktelemetry();
  self radiusdamagestepped();
  var_3 = 0;
  var_4 = 0;

  foreach(var_6 in self.pers["matchdataWeaponStats"]) {
    var_7 = 0;
    var_8 = 0;
    var_9 = 0;
    var_10 = 0;
    var_11 = 0;
    var_12 = 0;
    var_13 = 0;
    var_14 = 0;
    var_15 = 0;

    if(scripts\mp\utility\game::getgametype() != "br") {
      if(isenumvaluevalid("common", "LoadoutWeapon", var_6.weapon)) {
        var_7 = self getplayerdata(level.loadoutsgroup, "squadMembers", "weapon_xp", var_6.weapon);
      }
    }

    foreach(var_18, var_17 in var_6.stats) {
      if(var_18 == "deaths") {
        var_9 += var_17;
      }

      if(var_18 == "headshots") {
        var_10 += var_17;
      }

      if(var_18 == "hits") {
        var_11 += var_17;
        var_4 += var_17;
      }

      if(var_18 == "kills") {
        var_12 += var_17;
      }

      if(var_18 == "shots") {
        var_13 += var_17;
        var_3 += var_17;
      }

      if(var_18 == "xp_earned") {
        var_8 += var_17;
      }

      if(var_18 == "damage") {
        var_14 += var_17;
      }

      if(var_18 == "friendly_fire_damage") {
        var_15 += var_17;
      }
    }

    if(scripts\mp\utility\game::getgametype() != "br") {
      self dlog_recordplayerevent("dlog_event_player_weapon_stats", ["weapon", var_6.weapon, "variant_id", var_6.variantid, "loadout_index", var_6.loadoutindex, "starting_weapon_xp", var_7, "xp_earned", var_8, "deaths", var_9, "headshots", var_10, "hits", var_11, "kills", var_12, "shots", var_13, "damage", var_14, "friendly_fire_damage", var_15]);
      continue;
    }

    var_19 = isDefined(var_6.iscustomweapon);
    var_20 = 0;
    var_21 = 0;
    var_22 = 0;

    if(isDefined(var_6.stats["time_used_s"])) {
      var_22 = var_6.stats["time_used_s"];
    }

    self dlog_recordplayerevent("dlog_event_player_weapon_stats_br", ["weapon", var_6.weapon, "variant_id", var_6.variantid, "from_loadout", var_19, "died", var_20, "time_used_s", var_22, "longest_hit_distance", var_21, "deaths", var_9, "headshots", var_10, "hits", var_11, "kills", var_12, "shots", var_13, "damage", var_14, "attachment_0", var_6.attachments[0], "attachment_1", var_6.attachments[1], "attachment_2", var_6.attachments[2], "attachment_3", var_6.attachments[3], "attachment_4", var_6.attachments[4], "sticker_0", var_6.ref_138a8[0], "sticker_1", var_6.ref_138a8[1], "sticker_2", var_6.ref_138a8[2], "sticker_3", var_6.ref_138a8[3], "reticle", var_6.reticle, "cosmetic_attachment", var_6.impactfunc_carbon, "camo", var_6.camo, "match_time_created_s", var_6.pickuptime]);
  }
}

function logscoreevent(var_0) {
  if(scripts\mp\utility\entity::isgameparticipant(self) == 0) {
    return;
  }

  if(!isvalidclient(self)) {
    return;
  }

  if(isbot(self) || initmaxspeedforpathlengthtable(self) || isai(self)) {
    return;
  }

  var_1 = gettimefrommatchstart(gettime());
  self dlog_recordplayerevent("dlog_event_player_score_event", ["time_ms_from_match_start", var_1, "score_event", var_0]);
}

function ref_13154(var_0) {
  if(getdvarint("OMKTLMMNPT") == 1) {
    var_0 setplayerdata("common", "round", "gameModeModifier", "tactical");
    return;
  }

  if(getdvarint("MSQTTNSTNO") == 1) {
    var_0 setplayerdata("common", "round", "gameModeModifier", "hardcore");
    return;
  }

  var_0 setplayerdata("common", "round", "gameModeModifier", "normal");
}

function endofgamesummarylogger() {
  level waittill("game_ended", var_0);

  foreach(var_2 in level.players) {
    wait 0.05;

    if(!isDefined(var_2)) {
      continue;
    }

    if(isDefined(var_2.weaponsused)) {
      doublebubblesort(var_2);
      var_3 = 0;

      if(var_2.weaponsused.size > 3) {
        for(var_4 = var_2.weaponsused.size - 1; var_4 > var_2.weaponsused.size - 3; var_4--) {
          var_2 setplayerdata("common", "round", "weaponsUsed", var_3, var_2.weaponsused[var_4]);
          var_2 setplayerdata("common", "round", "weaponXpEarned", var_3, var_2.weaponxpearned[var_4]);
          var_3++;
        }
      } else {
        for(var_4 = var_2.weaponsused.size - 1; var_4 >= 0; var_4--) {
          var_2 setplayerdata("common", "round", "weaponsUsed", var_3, var_2.weaponsused[var_4]);
          var_2 setplayerdata("common", "round", "weaponXpEarned", var_3, var_2.weaponxpearned[var_4]);
          var_3++;
        }
      }
    } else {
      var_2 setplayerdata("common", "round", "weaponsUsed", 0, "none");
      var_2 setplayerdata("common", "round", "weaponsUsed", 1, "none");
      var_2 setplayerdata("common", "round", "weaponsUsed", 2, "none");
      var_2 setplayerdata("common", "round", "weaponXpEarned", 0, 0);
      var_2 setplayerdata("common", "round", "weaponXpEarned", 1, 0);
      var_2 setplayerdata("common", "round", "weaponXpEarned", 2, 0);
    }

    if(isDefined(var_2.challengescompleted)) {
      var_2 setplayerdata("common", "round", "challengeNumCompleted", var_2.challengescompleted.size);
    } else {
      var_2 setplayerdata("common", "round", "challengeNumCompleted", 0);
    }

    for(var_4 = 0; var_4 < 20; var_4++) {
      if(isDefined(var_2.challengescompleted) && isDefined(var_2.challengescompleted[var_4]) && var_2.challengescompleted[var_4] != "ch_prestige" && !issubstr(var_2.challengescompleted[var_4], "_daily") && !issubstr(var_2.challengescompleted[var_4], "_weekly")) {
        var_2 setplayerdata("common", "round", "challengesCompleted", var_4, var_2.challengescompleted[var_4]);
        continue;
      }

      var_2 setplayerdata("common", "round", "challengesCompleted", var_4, "ch_none");
    }

    var_5 = tolower(getDvar("mapname"));
    var_2 setplayerdata("common", "round", "gameMode", scripts\mp\utility\game::getgametype());
    var_2 setplayerdata("common", "round", "map", var_5);
    ref_13154(var_2);
  }
}

function ref_12aa9() {
  if(scripts\mp\utility\game::matchmakinggame()) {
    var_0 = tolower(getDvar("mapname"));
    var_1 = getdvarint("NLTOPSKPQM");

    foreach(var_3 in level.players) {
      for(var_4 = 31; var_4 > 0; var_4--) {
        var_5 = var_3 getplayerdata("mp", "mapsPlayed", var_4 - 1);
        var_3 setplayerdata("mp", "mapsPlayed", var_4, var_5);
      }

      var_3 setplayerdata("mp", "mapsPlayed", 0, var_0);

      for(var_4 = 4; var_4 > 0; var_4--) {
        var_6 = var_3 getplayerdata("mp", "playlistIdsPlayed", var_4 - 1);
        var_3 setplayerdata("mp", "playlistIdsPlayed", var_4, var_6);
      }

      var_3 setplayerdata("mp", "playlistIdsPlayed", 0, var_1);
    }

    return;
  }
}

function doublebubblesort() {
  var_0 = self.weaponxpearned;
  var_1 = self.weaponxpearned.size;

  for(var_2 = var_1 - 1; var_2 > 0; var_2--) {
    for(var_3 = 1; var_3 <= var_2; var_3++) {
      if(var_0[var_3 - 1] < var_0[var_3]) {
        var_4 = self.weaponsused[var_3];
        self.weaponsused[var_3] = self.weaponsused[var_3 - 1];
        self.weaponsused[var_3 - 1] = var_4;
        var_5 = self.weaponxpearned[var_3];
        self.weaponxpearned[var_3] = self.weaponxpearned[var_3 - 1];
        self.weaponxpearned[var_3 - 1] = var_5;
        var_0 = self.weaponxpearned;
      }
    }
  }
}

function isvalidclient(var_0) {
  if(istrue(game["isLaunchChunk"])) {
    return false;
  }

  if(!isDefined(var_0)) {
    return false;
  } else if(isagent(var_0)) {
    return false;
  } else if(!isPlayer(var_0)) {
    return false;
  }

  return true;
}

function canlogclient(var_0) {
  if(isvalidclient(var_0)) {
    return (var_0.clientid < level.maxlogclients);
  }

  return 0;
}

function canloglife(var_0) {
  return var_0 < level.maxlives;
}

function logweaponstat(var_0, var_1, var_2, var_3, var_4) {
  if(scripts\mp\utility\weapon::iskillstreakweapon(var_0) || scripts\mp\utility\weapon::isvehicleweapon(var_0)) {
    return;
  }

  if(scripts\mp\utility\game::getgametype() == "br" && !istrue(level.get_alive_nonspecating_players)) {
    return;
  }

  var_5 = var_0;

  if(scripts\mp\utility\game::getgametype() != "br") {
    if(isDefined(self.loadoutindex)) {
      var_5 = var_5 + "+loadoutIndex" + self.loadoutindex;
    } else {
      return;
    }
  } else if(isDefined(self.pers["matchdataWeaponStats"][var_5]) && isDefined(var_4)) {
    if(!getjuggmazebutton(var_4, var_5)) {
      var_6 = 1;

      for(var_7 = var_5 + "_" + var_6;; var_7 = var_5 + "_" + var_6) {
        if(!isDefined(self.pers["matchdataWeaponStats"][var_7]) || getjuggmazebutton(var_4, var_7)) {
          break;
        }

        var_6++;
      }

      var_5 = var_7;
    }
  }

  if(!isDefined(self.pers["matchdataWeaponStats"][var_5])) {
    self.pers["matchdataWeaponStats"][var_5] = spawnStruct();
    self.pers["matchdataWeaponStats"][var_5].stats = [];
    self.pers["matchdataWeaponStats"][var_5].weapon = var_0;
    self.pers["matchdataWeaponStats"][var_5].loadoutindex = self.loadoutindex;

    if(isDefined(var_3)) {
      self.pers["matchdataWeaponStats"][var_5].variantid = var_3;
    } else {
      self.pers["matchdataWeaponStats"][var_5].variantid = -1;
    }

    if(scripts\mp\utility\game::getgametype() == "br" && isDefined(var_4)) {
      var_8 = scripts\engine\utility::ter_op(isDefined(var_4.camo), var_4.camo, "none");
      var_9 = scripts\engine\utility::ter_op(isDefined(var_4.visual), var_4.visual, "none");
      var_10 = scripts\engine\utility::ter_op(isDefined(var_4.reticle), var_4.reticle, "none");
      self.pers["matchdataWeaponStats"][var_5].iscustomweapon = isDefined(var_4.customweaponname);
      self.pers["matchdataWeaponStats"][var_5].camo = var_8;
      self.pers["matchdataWeaponStats"][var_5].impactfunc_carbon = var_9;
      self.pers["matchdataWeaponStats"][var_5].reticle = var_10;
      self.pers["matchdataWeaponStats"][var_5].pickuptime = scripts\cp_mp\utility\game_utility::gettimesincegamestart();
      var_11 = scripts\mp\utility\weapon::getweaponattachmentsbasenames(var_4);
      var_12 = [];

      for(var_13 = 0; var_13 < 5; var_13++) {
        var_12 = "none";
      }

      var_14 = 0;

      foreach(var_16 in var_11) {
        if(scripts\mp\utility\weapon::attachmentlogsstats(var_16, var_4)) {
          var_12 = var_16;
          var_14++;
        }
      }

      self.pers["matchdataWeaponStats"][var_5].attachments = var_12;
      var_18 = [];
      GscBinSkip0(0x2e, var_18.size, var_4.stickerslot0);
    }
  }

  if(!isDefined(self.pers["matchdataWeaponStats"][var_18].stats[var_14])) {
    self.pers["matchdataWeaponStats"][var_18].stats[var_14] = var_15;
    return;
  }

  self.pers["matchdataWeaponStats"][var_18].stats[var_14] = self.pers["matchdataWeaponStats"][var_18].stats[var_14] + var_15;
}

function getjuggmazebutton(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(isDefined(var_0.camo), var_0.camo, "none");

  if(var_2 != self.pers["matchdataWeaponStats"][var_1].camo) {
    return false;
  }

  var_3 = scripts\engine\utility::ter_op(isDefined(var_0.visual), var_0.visual, "none");

  if(var_3 != self.pers["matchdataWeaponStats"][var_1].impactfunc_carbon) {
    return false;
  }

  var_4 = scripts\engine\utility::ter_op(isDefined(var_0.reticle), var_0.reticle, "none");

  if(var_4 != self.pers["matchdataWeaponStats"][var_1].reticle) {
    return false;
  }

  var_5 = scripts\mp\utility\weapon::getweaponattachmentsbasenames(var_0);

  if(var_5.size != self.pers["matchdataWeaponStats"][var_1].attachments.size) {
    return false;
  }

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    if(var_5[var_6] != self.pers["matchdataWeaponStats"][var_1].attachments[var_6]) {
      return false;
    }
  }

  var_7 = [];
  GscBinSkip0(0x2e, var_7.size, var_0.stickerslot0);
}

function logattachmentstat(var_0, var_1, var_2, var_3) {
  if(!level.matchdataattachmentstatsenabled) {
    return;
  }
}

function buildweaponrootlist() {
  var_0 = [];
  var_1 = 149;

  for(var_2 = 0; var_2 <= var_1; var_2++) {
    var_3 = tablelookup("mp/statstable.csv", 0, var_2, 4);
    var_4 = tablelookup("mp/statstable.csv", 0, var_2, 2);

    if(!issubstr(var_4, "weapon_")) {
      continue;
    }

    if(var_4 == "weapon_other") {
      continue;
    }

    var_0 = var_3;
  }

  return var_0;
}

function logchallenge(var_0, var_1) {}

function logaward(var_0) {
  if(!isvalidclient(self)) {
    return;
  }

  if(isbot(self) || initmaxspeedforpathlengthtable(self) || isai(self)) {
    return;
  }

  var_1 = gettimefrommatchstart(gettime());
  self dlog_recordplayerevent("dlog_event_player_award", ["time_ms_from_match_start", var_1, "award", var_0]);
}