/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\agents\agents.gsc
***********************************************/

function init() {
  if(getdvarint("online_matchdata_enabled") != 0 && !isDefined(game["gamestarted"])) {
    setmatchdata("commonMatchData", "map", level.script);

    if(level.hardcoremode) {
      var_0 = scripts\cp\utility::getgametype() + " hc";
      setmatchdata("commonMatchData", "gametype", var_0);
    } else {
      setmatchdata("commonMatchData", "gametype", scripts\cp\utility::getgametype());
    }

    setmatchdata("commonMatchData", "build_version", getbuildversion());
    setmatchdata("commonMatchData", "build_number", getbuildnumber());
    setmatchdata("commonMatchData", "is_private_match", scripts\cp\utility::privatematch());
  }

  if(getdvarint("online_matchdata_enabled") != 0) {
    level.maxlogclients = 30;
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
  thread endofgamesummarylogger();
}

function onmatchstart() {
  setmatchdata("commonMatchData", "utc_start_time_s", getsystemtime());
  setmatchdata("commonMatchData", "player_count_start", level.players.size);
  var_0 = scripts\cp\utility::getgametype();

  if(level.hardcoremode) {
    var_0 += " hc";
  }

  var_1 = function_042d();
  getentitylessscriptablearray("dlog_event_server_match_start", ["map", level.script, "game_type", var_0, "is_playtest", getdvarint("dlog_is_playtest"), "experiment_name", getDvar("experiment_name"), "playlist_name", var_1]);
  onmatchend();
}

function onroundend() {
  level.endtimeutcseconds = getsystemtime();
  setmatchdata("commonMatchData", "utc_end_time_s", level.endtimeutcseconds);
  setmatchdata("commonMatchData", "player_count_end", level.players.size);
  setmatchdata("globalPlayerXpModifier", int(scripts\cp\drone\emp_drone::getglobalrankxpmultiplier()));
  setmatchdata("globalWeaponXpModifier", int(scripts\cp\cp_weaponrank::getglobalweaponrankxpmultiplier()));
}

function getmatchstarttimeutc() {
  if(getdvarint("online_matchdata_enabled") == 0) {
    return level.starttimeutcseconds;
  }

  return getmatchdata("commonMatchData", "utc_start_time_s");
}

function getmatchendtimeutc() {
  if(getdvarint("online_matchdata_enabled") == 0) {
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

  if(isvalidclient(self) && scripts\cp\utility\entity::isgameparticipant(self)) {
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
    var_0 = scripts\cp\cp_weapon::mapweapon(var_0);
    var_1 = createheadicon(var_0);
    thread threadedsetweaponstatbyname(var_1, 1, "trigger_pulls");
  }
}

function threadedsetweaponstatbyname(var_0, var_1, var_2) {
  self endon("disconnect");
  waittillframeend();
  setweaponstat(var_0, var_1, var_2);
}

function setweaponstat(var_0, var_1, var_2) {
  if(!var_1) {
    return;
  }

  var_3 = undefined;

  if(issameweapon(var_0)) {
    var_3 = var_0;
  } else {
    var_3 = asmdevgetallstates(var_0);
  }

  if(scripts\cp\cp_weapon::ispickedupweapon(var_3)) {
    return;
  }

  var_4 = var_3.basename;
  var_5 = scripts\cp\cp_weapon::getweapongroup(var_3);
  var_6 = getweaponvariantindex(var_3);

  if(var_5 == "killstreak" || var_5 == "other" && var_4 != "trophy_mp" || var_5 == "other" && var_4 != "player_trophy_system_mp" || var_5 == "other" && var_4 != "super_trophy_mp") {
    return;
  }

  if(scripts\cp\utility::isenvironmentweapon(var_3)) {
    return;
  }

  if(var_5 == "weapon_grenade" || var_5 == "weapon_explosive" || var_4 == "trophy_mp" || var_4 == "forcepush_mp") {
    var_4 = scripts\cp\utility::strip_suffix(var_4, "_mp");
    return;
  }

  if(!isDefined(self.trackingweapon)) {
    self.trackingweapon = var_3;
  }

  if(var_3 != self.trackingweapon) {
    self.trackingweapon = var_3;
  }

  switch (var_2) {
    case "shots":
      self.trackingweaponshots++;
      break;
    case "hits":
      self.trackingweaponhits++;
      break;
    case "headShots":
      self.trackingweaponheadshots++;
      break;
    case "kills":
      self.trackingweaponkills++;
      break;
  }

  if(var_2 == "deaths") {
    var_7 = undefined;
    var_8 = scripts\cp\utility::getweaponrootname(var_3);

    if(!scripts\cp\cp_weapon::iscacprimaryweapon(var_8) && !scripts\cp\cp_weapon::iscacsecondaryweapon(var_8)) {
      return;
    }

    var_9 = scripts\cp\utility::getweaponattachmentsbasenames(var_3);

    foreach(var_11 in var_9) {}

    return;
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

function logplayerdeath(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isvalidclient(self)) {
    return;
  }

  if(var_4 == "agent_mp") {
    var_7 = [];
  } else {
    var_7 = scripts\cp\utility::getweaponattachmentsbasenames(var_5);
    var_7 = scripts\cp\cp_weapon::attachmentsfilterforstats(var_7, var_5);
  }

  var_8 = gettimefrommatchstart(gettime());
  var_9 = -1;
  var_10 = -1;
  var_11 = [];
  jumpiffalse(isvalidclient(var_2)) LOC_0000045e;
  var_12 = getweaponbasename(var_5);
  var_13 = var_2;
  var_14 = var_2 scripts\cp\cp_weapon::ispickedupweapon(var_5);
  var_15 = var_2 isalternatemode(var_5);

  if(scripts\cp\cp_weapon::iscacprimaryweapon(var_5) || scripts\cp\cp_weapon::iscacsecondaryweapon(var_5)) {
    var_16 = var_2 playerads();
    goto LOC_0000009b;
  }

  var_16 = 0;
  var_17 = 0.4226;
  var_18 = scripts\engine\utility::within_fov(self.origin, self.angles, var_3.origin, var_17);
  var_19 = scripts\engine\utility::within_fov(var_3.origin, var_3.angles, self.origin, var_17);
  var_20 = ref_11d78(var_3);
  var_21 = var_3.origin;
  var_22 = var_3.angles;

  if(isDefined(var_3.matchdatalifeindex)) {
    var_10 = var_3.matchdatalifeindex;
  }

  if(isDefined(var_3.loadoutindex)) {
    var_11 = var_3.loadoutindex;
  }

  var_23 = getplayerbuffs(var_3);

  if(istrue(var_23[0])) {
    var_12 = "UAV_ACTIVE";
  }

  if(istrue(var_23[1])) {
    var_12 = "DEADSILENCE_ACTIVE";
  }

  if(istrue(var_23[2])) {
    var_12 = "HAS_STOPPING_POWER";
  }

  var_24 = getplayerdebuffs(var_3);

  if(istrue(var_24[0])) {
    var_12 = "CUAV_ACTIVE";
  }

  if(istrue(var_24[1])) {
    var_12 = "IS_MARKED";
  }

  if(istrue(var_24[2])) {
    var_12 = "IS_FLASHED";
  }

  if(istrue(var_24[3])) {
    var_12 = "IS_STUNNED";
  }

  if(istrue(var_24[4])) {
    var_12 = "IN_GAS";
  }

  if(istrue(var_24[5])) {
    var_12 = "IN_BURNING";
  }

  if(istrue(var_24[6])) {
    var_12 = "IS_SNAPSHOTTED";
  }

  if(istrue(var_24[7])) {
    var_12 = "IN_SMOKE";
  }

  if(istrue(var_24[8])) {
    var_12 = "IS_EMPED";
  }

  if(istrue(var_24[9])) {
    var_12 = "IN_WHITE_PHOSPHOROUS";
  }

  if(var_3 isnightvisionon()) {
    var_12 = "NVG_ENABLED";
  }

  if(isDefined(var_3.modifiers)) {
    if(isDefined(var_3.modifiers["headshot"]) && istrue(var_3.modifiers["headshot"])) {
      var_12 = "HEADSHOT";
    }

    if(isDefined(var_3.modifiers["avenger"]) && istrue(var_3.modifiers["avenger"])) {
      var_12 = "AVENGER";
    }

    if(isDefined(var_3.modifiers["defender"]) && istrue(var_3.modifiers["defender"])) {
      var_12 = "DEFENDER";
    }

    if(isDefined(var_3.modifiers["posthumous"]) && istrue(var_3.modifiers["posthumous"])) {
      var_12 = "POSTHUMOUS";
    }

    if(isDefined(var_3.modifiers["revenge"]) && istrue(var_3.modifiers["revenge"])) {
      var_12 = "REVENGE";
    }

    if(isDefined(var_3.modifiers["buzzkill"]) && istrue(var_3.modifiers["buzzkill"])) {
      var_12 = "BUZZKILL";
    }

    if(isDefined(var_3.modifiers["firstblood"]) && istrue(var_3.modifiers["firstblood"])) {
      var_12 = "FIRSTBLOOD";
    }

    if(isDefined(var_3.modifiers["comeback"]) && istrue(var_3.modifiers["comeback"])) {
      var_12 = "COMEBACK";
    }

    if(isDefined(var_3.modifiers["longshot"]) && istrue(var_3.modifiers["longshot"])) {
      var_12 = "LONGSHOT";
    }

    if(isDefined(var_3.modifiers["pointblank"]) && istrue(var_3.modifiers["pointblank"])) {
      var_12 = "POINTBLANK";
    }

    if(isDefined(var_3.modifiers["assistedsuicide"]) && istrue(var_3.modifiers["assistedsuicide"])) {
      var_12 = "ASSISTED_SUICIDE";
    }
  }

  if(scripts\cp\utility::iskillstreakweapon(var_13)) {
    var_12 = "KILLSTREAK";
  }

  goto LOC_000004be;
}

function getplayerbuffs() {
  var_0 = [];
  GscBinSkip0(0x2e, 0, scripts\cp_mp\utility\killstreak_utility::teamhasuav(self.team));
}

function getplayerdebuffs() {
  var_0 = [];
  GscBinSkip0(0x2e, 0, scripts\cp_mp\utility\killstreak_utility::enemyhascuav(self.team));
}

function logplayerdata(var_0) {
  if(!isvalidclient(self)) {
    return;
  }

  scripts\cp\cp_analytics::ref_119cc(var_0);
  self sendclientnetworktelemetry();
  var_1 = 0;
  var_2 = 0;

  if(!isDefined(self.pers["matchdataWeaponStats"])) {
    return;
  }

  foreach(var_4 in self.pers["matchdataWeaponStats"]) {
    var_5 = 0;
    var_6 = 0;
    var_7 = 0;
    var_8 = 0;
    var_9 = 0;
    var_10 = 0;
    var_11 = 0;

    if(scripts\cp\utility::getgametype() != "br") {
      if(isenumvaluevalid("common", "LoadoutWeapon", var_4.weapon)) {
        var_5 = self getplayerdata("rankedloadouts", "squadMembers", "weapon_xp", var_4.weapon);
      }
    }

    foreach(var_14, var_13 in var_4.stats) {
      if(var_14 == "deaths") {
        var_7 += var_13;
      }

      if(var_14 == "headshots") {
        var_8 += var_13;
      }

      if(var_14 == "hits") {
        var_9 += var_13;
        var_2 += var_13;
      }

      if(var_14 == "kills") {
        var_10 += var_13;
      }

      if(var_14 == "shots") {
        var_11 += var_13;
        var_1 += var_13;
      }

      if(var_14 == "xp_earned") {
        var_6 += var_13;
      }
    }

    if(scripts\cp\utility::getgametype() != "br") {
      self dlog_recordplayerevent("dlog_event_player_weapon_stats", ["weapon", var_4.weapon, "variant_id", var_4.variantid, "loadout_index", var_4.loadoutindex, "starting_weapon_xp", var_5, "xp_earned", var_6, "deaths", var_7, "headshots", var_8, "hits", var_9, "kills", var_10, "shots", var_11]);
    }
  }
}

function logscoreevent(var_0) {
  if(scripts\cp\utility\entity::isgameparticipant(self) == 0) {
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

function endofgamesummarylogger() {
  level waittill("game_ended");

  foreach(var_1 in level.players) {
    wait 0.05;

    if(!isDefined(var_1)) {
      continue;
    }

    var_1 scripts\cp_mp\utility\game_utility::stopkeyearning();

    if(isDefined(var_1.weaponsused)) {
      doublebubblesort(var_1);
      var_2 = 0;

      if(var_1.weaponsused.size > 3) {
        for(var_3 = var_1.weaponsused.size - 1; var_3 > var_1.weaponsused.size - 3; var_3--) {
          var_1 setplayerdata("common", "round", "weaponsUsed", var_2, var_1.weaponsused[var_3]);
          var_1 setplayerdata("common", "round", "weaponXpEarned", var_2, var_1.weaponxpearned[var_3]);
          var_2++;
        }
      } else {
        for(var_3 = var_1.weaponsused.size - 1; var_3 >= 0; var_3--) {
          var_1 setplayerdata("common", "round", "weaponsUsed", var_2, var_1.weaponsused[var_3]);
          var_1 setplayerdata("common", "round", "weaponXpEarned", var_2, var_1.weaponxpearned[var_3]);
          var_2++;
        }
      }
    } else {
      var_1 setplayerdata("common", "round", "weaponsUsed", 0, "none");
      var_1 setplayerdata("common", "round", "weaponsUsed", 1, "none");
      var_1 setplayerdata("common", "round", "weaponsUsed", 2, "none");
      var_1 setplayerdata("common", "round", "weaponXpEarned", 0, 0);
      var_1 setplayerdata("common", "round", "weaponXpEarned", 1, 0);
      var_1 setplayerdata("common", "round", "weaponXpEarned", 2, 0);
    }

    if(isDefined(var_1.challengescompleted)) {
      var_1 setplayerdata("common", "round", "challengeNumCompleted", var_1.challengescompleted.size);
    } else {
      var_1 setplayerdata("common", "round", "challengeNumCompleted", 0);
    }

    for(var_3 = 0; var_3 < 20; var_3++) {
      if(isDefined(var_1.challengescompleted) && isDefined(var_1.challengescompleted[var_3]) && var_1.challengescompleted[var_3] != "ch_prestige" && !issubstr(var_1.challengescompleted[var_3], "_daily") && !issubstr(var_1.challengescompleted[var_3], "_weekly")) {
        var_1 setplayerdata("common", "round", "challengesCompleted", var_3, var_1.challengescompleted[var_3]);
        continue;
      }

      var_1 setplayerdata("common", "round", "challengesCompleted", var_3, "ch_none");
    }

    var_4 = tolower(getDvar("mapname"));
    var_1 setplayerdata("common", "round", "gameMode", scripts\cp\utility::getgametype());
    var_1 setplayerdata("common", "round", "map", var_4);

    if(istrue(level.matchmakingmatch)) {
      var_5 = 0;
      var_6 = 0;

      for(var_3 = 0; var_3 < 5; var_3++) {
        var_7 = var_1 getplayerdata("mp", "mapsPlayed", var_3);

        if(var_7 == "") {
          var_5 = var_3;
          var_6 = 1;
          break;
        }

        if(var_7 == var_4) {
          var_5 = var_3;
          var_6 = 0;
          break;
        }
      }

      if(var_6 == 1) {
        var_1 setplayerdata("mp", "mapsPlayed", var_5, var_4);
      } else {
        var_8 = var_5;

        for(var_3 = var_5; var_3 < 4; var_3++) {
          var_8 = var_3 + 1;
          var_7 = var_1 getplayerdata("mp", "mapsPlayed", var_3 + 1);
          var_1 setplayerdata("mp", "mapsPlayed", var_3, var_7);

          if(var_7 == "") {
            var_8 = var_3;
            break;
          }
        }

        var_1 setplayerdata("mp", "mapsPlayed", var_8, var_4);
      }
    }
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

function logweaponstat(var_0, var_1, var_2, var_3) {
  if(scripts\cp\utility::iskillstreakweapon(var_0) || scripts\cp\cp_weapon::isvehicleweapon(var_0)) {
    return;
  }

  if(scripts\cp\utility::getgametype() == "br") {
    return;
  }

  var_4 = var_0;

  if(isDefined(self.loadoutindex)) {
    var_4 = var_4 + "+loadoutIndex" + self.loadoutindex;
  } else {
    return;
  }

  if(!isDefined(self.pers["matchdataWeaponStats"][var_4])) {
    self.pers["matchdataWeaponStats"][var_4] = spawnStruct();
    self.pers["matchdataWeaponStats"][var_4].stats = [];
    self.pers["matchdataWeaponStats"][var_4].weapon = var_0;
    self.pers["matchdataWeaponStats"][var_4].loadoutindex = self.loadoutindex;

    if(isDefined(var_3)) {
      self.pers["matchdataWeaponStats"][var_4].variantid = var_3;
    } else {
      self.pers["matchdataWeaponStats"][var_4].variantid = -1;
    }
  }

  if(!isDefined(self.pers["matchdataWeaponStats"][var_4].stats[var_1])) {
    self.pers["matchdataWeaponStats"][var_4].stats[var_1] = var_2;
    return;
  }

  self.pers["matchdataWeaponStats"][var_4].stats[var_1] = self.pers["matchdataWeaponStats"][var_4].stats[var_1] + var_2;
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

function initpersstat(var_0) {
  if(!isDefined(self.pers[var_0])) {
    self.pers[var_0] = 0;
    return;
  }
}

function getpersstat(var_0) {
  return self.pers[var_0];
}

function incpersstat(var_0, var_1) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  if(isDefined(self) && isDefined(self.pers) && isDefined(self.pers[var_0])) {
    self.pers[var_0] += var_1;
    return;
  }
}

function setextrascore0(var_0) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  self.extrascore0 = var_0;
  self.pers["extrascore0"] = var_0;
}

function setextrascore1(var_0) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  self.extrascore1 = var_0;
  self.pers["extrascore1"] = var_0;
}

function setextrascore2(var_0) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  self.extrascore2 = var_0;
  self.pers["extrascore2"] = var_0;
}

function setextrascore3(var_0) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  self.extrascore3 = var_0;
  self.pers["extrascore3"] = var_0;
}

function getplayerdataloadoutgroup() {
  if(level.rankedmatch) {
    return "rankedloadouts";
  }

  return "privateloadouts";
}

function setplayerdatagroups() {
  level.loadoutsgroup = getplayerdataloadoutgroup();
}

function canrecordcombatrecordstats() {
  return level.rankedmatch && !istrue(level.ignorescoring) && scripts\cp\utility::getgametype() != "infect";
}

function getstreakrecordtype(var_0) {
  if(isenumvaluevalid("mp", "LethalScorestreakStatItems", var_0)) {
    return "lethalScorestreakStats";
  }

  if(isenumvaluevalid("mp", "SupportScorestreakStatItems", var_0)) {
    return "supportScorestreakStats";
  }

  return undefined;
}