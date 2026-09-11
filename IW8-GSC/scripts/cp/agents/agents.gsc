/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\agents\agents.gsc
***********************************************/

function init() {
  if(getdvarint("TLRPKRKMS") != 0 && !isDefined(game["gamestarted"])) {
    setmatchdata("commonMatchData", "map", level.script);

    if(level.hardcoremode) {
      var0 = scripts\cp\utility::getgametype() + " hc";
      setmatchdata("commonMatchData", "gametype", var0);
    } else {
      setmatchdata("commonMatchData", "gametype", scripts\cp\utility::getgametype());
    }

    setmatchdata("commonMatchData", "build_version", getbuildversion());
    setmatchdata("commonMatchData", "build_number", getbuildnumber());
    setmatchdata("commonMatchData", "is_private_match", scripts\cp\utility::privatematch());
  }

  if(getdvarint("TLRPKRKMS") != 0) {
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
  var0 = scripts\cp\utility::getgametype();

  if(level.hardcoremode) {
    var0 += " hc";
  }

  var1 = function_042d();
  getentitylessscriptablearray("dlog_event_server_match_start", ["map", level.script, "game_type", var0, "is_playtest", getdvarint("dlog_is_playtest"), "MQQPLSSSLQ", getDvar("MQQPLSSSLQ"), "NOQRRQMOON", var1]);
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

  if(isvalidclient(self) && scripts\cp\utility\entity::isgameparticipant(self)) {
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
    var0 = scripts\cp\cp_weapon::mapweapon(var0);
    var1 = createheadicon(var0);
    thread threadedsetweaponstatbyname(var1, 1, "trigger_pulls");
  }
}

function threadedsetweaponstatbyname(var0, var1, var2) {
  self endon("disconnect");
  waittillframeend();
  setweaponstat(var0, var1, var2);
}

function setweaponstat(var0, var1, var2) {
  if(!var1) {
    return;
  }

  var3 = undefined;

  if(issameweapon(var0)) {
    var3 = var0;
  } else {
    var3 = asmdevgetallstates(var0);
  }

  if(scripts\cp\cp_weapon::ispickedupweapon(var3)) {
    return;
  }

  var4 = var3.basename;
  var5 = scripts\cp\cp_weapon::getweapongroup(var3);
  var6 = getweaponvariantindex(var3);

  if(var5 == "killstreak" || var5 == "other" && var4 != "trophy_mp" || var5 == "other" && var4 != "player_trophy_system_mp" || var5 == "other" && var4 != "super_trophy_mp") {
    return;
  }

  if(scripts\cp\utility::isenvironmentweapon(var3)) {
    return;
  }

  if(var5 == "weapon_grenade" || var5 == "weapon_explosive" || var4 == "trophy_mp" || var4 == "forcepush_mp") {
    var4 = scripts\cp\utility::strip_suffix(var4, "_mp");
    return;
  }

  if(!isDefined(self.trackingweapon)) {
    self.trackingweapon = var3;
  }

  if(var3 != self.trackingweapon) {
    self.trackingweapon = var3;
  }

  switch (var2) {
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

  if(var2 == "deaths") {
    var7 = undefined;
    var8 = scripts\cp\utility::getweaponrootname(var3);

    if(!scripts\cp\cp_weapon::iscacprimaryweapon(var8) && !scripts\cp\cp_weapon::iscacsecondaryweapon(var8)) {
      return;
    }

    var9 = scripts\cp\utility::getweaponattachmentsbasenames(var3);

    foreach(var11 in var9) {}

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

function logplayerdeath(var0, var1, var2, var3, var4, var5, var6) {
  if(!isvalidclient(self)) {
    return;
  }

  if(var4 == "agent_mp") {
    var7 = [];
  } else {
    var7 = scripts\cp\utility::getweaponattachmentsbasenames(var5);
    var7 = scripts\cp\cp_weapon::attachmentsfilterforstats(var7, var5);
  }

  var8 = gettimefrommatchstart(gettime());
  var9 = -1;
  var10 = -1;
  var11 = [];
  jumpiffalse(isvalidclient(var2)) LOC_0000045e;
  var12 = getweaponbasename(var5);
  var13 = var2;
  var14 = var2 scripts\cp\cp_weapon::ispickedupweapon(var5);
  var15 = var2 isalternatemode(var5);

  if(scripts\cp\cp_weapon::iscacprimaryweapon(var5) || scripts\cp\cp_weapon::iscacsecondaryweapon(var5)) {
    var16 = var2 playerads();
    goto LOC_0000009b;
  }

  var16 = 0;
  var17 = 0.4226;
  var18 = scripts\engine\utility::within_fov(self.origin, self.angles, var3.origin, var17);
  var19 = scripts\engine\utility::within_fov(var3.origin, var3.angles, self.origin, var17);
  var20 = ref_11d78(var3);
  var21 = var3.origin;
  var22 = var3.angles;

  if(isDefined(var3.matchdatalifeindex)) {
    var10 = var3.matchdatalifeindex;
  }

  if(isDefined(var3.loadoutindex)) {
    var11 = var3.loadoutindex;
  }

  var23 = getplayerbuffs(var3);

  if(istrue(var23[0])) {
    var12 = "UAV_ACTIVE";
  }

  if(istrue(var23[1])) {
    var12 = "DEADSILENCE_ACTIVE";
  }

  if(istrue(var23[2])) {
    var12 = "HAS_STOPPING_POWER";
  }

  var24 = getplayerdebuffs(var3);

  if(istrue(var24[0])) {
    var12 = "CUAV_ACTIVE";
  }

  if(istrue(var24[1])) {
    var12 = "IS_MARKED";
  }

  if(istrue(var24[2])) {
    var12 = "IS_FLASHED";
  }

  if(istrue(var24[3])) {
    var12 = "IS_STUNNED";
  }

  if(istrue(var24[4])) {
    var12 = "IN_GAS";
  }

  if(istrue(var24[5])) {
    var12 = "IN_BURNING";
  }

  if(istrue(var24[6])) {
    var12 = "IS_SNAPSHOTTED";
  }

  if(istrue(var24[7])) {
    var12 = "IN_SMOKE";
  }

  if(istrue(var24[8])) {
    var12 = "IS_EMPED";
  }

  if(istrue(var24[9])) {
    var12 = "IN_WHITE_PHOSPHOROUS";
  }

  if(var3 isnightvisionon()) {
    var12 = "NVG_ENABLED";
  }

  if(isDefined(var3.modifiers)) {
    if(isDefined(var3.modifiers["headshot"]) && istrue(var3.modifiers["headshot"])) {
      var12 = "HEADSHOT";
    }

    if(isDefined(var3.modifiers["avenger"]) && istrue(var3.modifiers["avenger"])) {
      var12 = "AVENGER";
    }

    if(isDefined(var3.modifiers["defender"]) && istrue(var3.modifiers["defender"])) {
      var12 = "DEFENDER";
    }

    if(isDefined(var3.modifiers["posthumous"]) && istrue(var3.modifiers["posthumous"])) {
      var12 = "POSTHUMOUS";
    }

    if(isDefined(var3.modifiers["revenge"]) && istrue(var3.modifiers["revenge"])) {
      var12 = "REVENGE";
    }

    if(isDefined(var3.modifiers["buzzkill"]) && istrue(var3.modifiers["buzzkill"])) {
      var12 = "BUZZKILL";
    }

    if(isDefined(var3.modifiers["firstblood"]) && istrue(var3.modifiers["firstblood"])) {
      var12 = "FIRSTBLOOD";
    }

    if(isDefined(var3.modifiers["comeback"]) && istrue(var3.modifiers["comeback"])) {
      var12 = "COMEBACK";
    }

    if(isDefined(var3.modifiers["longshot"]) && istrue(var3.modifiers["longshot"])) {
      var12 = "LONGSHOT";
    }

    if(isDefined(var3.modifiers["pointblank"]) && istrue(var3.modifiers["pointblank"])) {
      var12 = "POINTBLANK";
    }

    if(isDefined(var3.modifiers["assistedsuicide"]) && istrue(var3.modifiers["assistedsuicide"])) {
      var12 = "ASSISTED_SUICIDE";
    }
  }

  if(scripts\cp\utility::iskillstreakweapon(var13)) {
    var12 = "KILLSTREAK";
  }

  goto LOC_000004be;
}

function getplayerbuffs() {
  var0 = [];
  GscBinSkip0(0x2e, 0, scripts\cp_mp\utility\killstreak_utility::teamhasuav(self.team));
}

function getplayerdebuffs() {
  var0 = [];
  GscBinSkip0(0x2e, 0, scripts\cp_mp\utility\killstreak_utility::enemyhascuav(self.team));
}

function logplayerdata(var0) {
  if(!isvalidclient(self)) {
    return;
  }

  scripts\cp\cp_analytics::ref_119cc(var0);
  self sendclientnetworktelemetry();
  var1 = 0;
  var2 = 0;

  if(!isDefined(self.pers["matchdataWeaponStats"])) {
    return;
  }

  foreach(var4 in self.pers["matchdataWeaponStats"]) {
    var5 = 0;
    var6 = 0;
    var7 = 0;
    var8 = 0;
    var9 = 0;
    var10 = 0;
    var11 = 0;

    if(scripts\cp\utility::getgametype() != "br") {
      if(isenumvaluevalid("common", "LoadoutWeapon", var4.weapon)) {
        var5 = self getplayerdata("rankedloadouts", "squadMembers", "weapon_xp", var4.weapon);
      }
    }

    foreach(var14, var13 in var4.stats) {
      if(var14 == "deaths") {
        var7 += var13;
      }

      if(var14 == "headshots") {
        var8 += var13;
      }

      if(var14 == "hits") {
        var9 += var13;
        var2 += var13;
      }

      if(var14 == "kills") {
        var10 += var13;
      }

      if(var14 == "shots") {
        var11 += var13;
        var1 += var13;
      }

      if(var14 == "xp_earned") {
        var6 += var13;
      }
    }

    if(scripts\cp\utility::getgametype() != "br") {
      self dlog_recordplayerevent("dlog_event_player_weapon_stats", ["weapon", var4.weapon, "variant_id", var4.variantid, "loadout_index", var4.loadoutindex, "starting_weapon_xp", var5, "xp_earned", var6, "deaths", var7, "headshots", var8, "hits", var9, "kills", var10, "shots", var11]);
    }
  }
}

function logscoreevent(var0) {
  if(scripts\cp\utility\entity::isgameparticipant(self) == 0) {
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

function endofgamesummarylogger() {
  level waittill("game_ended");

  foreach(var1 in level.players) {
    wait 0.05;

    if(!isDefined(var1)) {
      continue;
    }

    var1 scripts\cp_mp\utility\game_utility::stopkeyearning();

    if(isDefined(var1.weaponsused)) {
      doublebubblesort(var1);
      var2 = 0;

      if(var1.weaponsused.size > 3) {
        for(var3 = var1.weaponsused.size - 1; var3 > var1.weaponsused.size - 3; var3--) {
          var1 setplayerdata("common", "round", "weaponsUsed", var2, var1.weaponsused[var3]);
          var1 setplayerdata("common", "round", "weaponXpEarned", var2, var1.weaponxpearned[var3]);
          var2++;
        }
      } else {
        for(var3 = var1.weaponsused.size - 1; var3 >= 0; var3--) {
          var1 setplayerdata("common", "round", "weaponsUsed", var2, var1.weaponsused[var3]);
          var1 setplayerdata("common", "round", "weaponXpEarned", var2, var1.weaponxpearned[var3]);
          var2++;
        }
      }
    } else {
      var1 setplayerdata("common", "round", "weaponsUsed", 0, "none");
      var1 setplayerdata("common", "round", "weaponsUsed", 1, "none");
      var1 setplayerdata("common", "round", "weaponsUsed", 2, "none");
      var1 setplayerdata("common", "round", "weaponXpEarned", 0, 0);
      var1 setplayerdata("common", "round", "weaponXpEarned", 1, 0);
      var1 setplayerdata("common", "round", "weaponXpEarned", 2, 0);
    }

    if(isDefined(var1.challengescompleted)) {
      var1 setplayerdata("common", "round", "challengeNumCompleted", var1.challengescompleted.size);
    } else {
      var1 setplayerdata("common", "round", "challengeNumCompleted", 0);
    }

    for(var3 = 0; var3 < 20; var3++) {
      if(isDefined(var1.challengescompleted) && isDefined(var1.challengescompleted[var3]) && var1.challengescompleted[var3] != "ch_prestige" && !issubstr(var1.challengescompleted[var3], "_daily") && !issubstr(var1.challengescompleted[var3], "_weekly")) {
        var1 setplayerdata("common", "round", "challengesCompleted", var3, var1.challengescompleted[var3]);
        continue;
      }

      var1 setplayerdata("common", "round", "challengesCompleted", var3, "ch_none");
    }

    var4 = tolower(getDvar("mapname"));
    var1 setplayerdata("common", "round", "gameMode", scripts\cp\utility::getgametype());
    var1 setplayerdata("common", "round", "map", var4);

    if(istrue(level.matchmakingmatch)) {
      var5 = 0;
      var6 = 0;

      for(var3 = 0; var3 < 5; var3++) {
        var7 = var1 getplayerdata("mp", "mapsPlayed", var3);

        if(var7 == "") {
          var5 = var3;
          var6 = 1;
          break;
        }

        if(var7 == var4) {
          var5 = var3;
          var6 = 0;
          break;
        }
      }

      if(var6 == 1) {
        var1 setplayerdata("mp", "mapsPlayed", var5, var4);
      } else {
        var8 = var5;

        for(var3 = var5; var3 < 4; var3++) {
          var8 = var3 + 1;
          var7 = var1 getplayerdata("mp", "mapsPlayed", var3 + 1);
          var1 setplayerdata("mp", "mapsPlayed", var3, var7);

          if(var7 == "") {
            var8 = var3;
            break;
          }
        }

        var1 setplayerdata("mp", "mapsPlayed", var8, var4);
      }
    }
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

function logweaponstat(var0, var1, var2, var3) {
  if(scripts\cp\utility::iskillstreakweapon(var0) || scripts\cp\cp_weapon::isvehicleweapon(var0)) {
    return;
  }

  if(scripts\cp\utility::getgametype() == "br") {
    return;
  }

  var4 = var0;

  if(isDefined(self.loadoutindex)) {
    var4 = var4 + "+loadoutIndex" + self.loadoutindex;
  } else {
    return;
  }

  if(!isDefined(self.pers["matchdataWeaponStats"][var4])) {
    self.pers["matchdataWeaponStats"][var4] = spawnStruct();
    self.pers["matchdataWeaponStats"][var4].stats = [];
    self.pers["matchdataWeaponStats"][var4].weapon = var0;
    self.pers["matchdataWeaponStats"][var4].loadoutindex = self.loadoutindex;

    if(isDefined(var3)) {
      self.pers["matchdataWeaponStats"][var4].variantid = var3;
    } else {
      self.pers["matchdataWeaponStats"][var4].variantid = -1;
    }
  }

  if(!isDefined(self.pers["matchdataWeaponStats"][var4].stats[var1])) {
    self.pers["matchdataWeaponStats"][var4].stats[var1] = var2;
    return;
  }

  self.pers["matchdataWeaponStats"][var4].stats[var1] = self.pers["matchdataWeaponStats"][var4].stats[var1] + var2;
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

function initpersstat(var0) {
  if(!isDefined(self.pers[var0])) {
    self.pers[var0] = 0;
    return;
  }
}

function getpersstat(var0) {
  return self.pers[var0];
}

function incpersstat(var0, var1) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  if(isDefined(self) && isDefined(self.pers) && isDefined(self.pers[var0])) {
    self.pers[var0] += var1;
    return;
  }
}

function setextrascore0(var0) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  self.extrascore0 = var0;
  self.pers["extrascore0"] = var0;
}

function setextrascore1(var0) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  self.extrascore1 = var0;
  self.pers["extrascore1"] = var0;
}

function setextrascore2(var0) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  self.extrascore2 = var0;
  self.pers["extrascore2"] = var0;
}

function setextrascore3(var0) {
  if(istrue(game["practiceRound"])) {
    return;
  }

  self.extrascore3 = var0;
  self.pers["extrascore3"] = var0;
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

function getstreakrecordtype(var0) {
  if(isenumvaluevalid("mp", "LethalScorestreakStatItems", var0)) {
    return "lethalScorestreakStats";
  }

  if(isenumvaluevalid("mp", "SupportScorestreakStatItems", var0)) {
    return "supportScorestreakStats";
  }

  return undefined;
}