/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\_matchdata.gsc
*********************************************/

init() {
  if(!isDefined(game["gamestarted"])) {
    var_00 = "mp/ddl/mp_matchdata.ddl";
    if(level.gametype == "zombies") {
      var_00 = "mp/ddl/zm_matchdata.ddl";
    }

    function_0127(var_00);
    level.ismatchdatadefset = 1;
    setmatchdata("match_common", "map", level.script);
    if(level.hardcoremode) {
      var_01 = level.gametype + " hc";
      setmatchdata("match_common", "gametype", var_01);
    } else {
      setmatchdata("match_common", "gametype", level.gametype);
    }

    setmatchdata("match_common", "build_version", getbuildversion());
    setmatchdata("match_common", "changelist", getbuildnumber());
    function_0129();
    game["matchIDSet"] = 1;
    if(maps\mp\_utility::func_579B()) {
      if(!common_scripts\utility::func_562E(game["switchedsides"])) {
        game["firstMatchID"] = getmatchdata("match_common", "matchID");
      } else {
        setmatchdata("match_common", "previous_match_id", game["firstMatchID"]);
      }
    }
  }

  level.var_608B = 490;
  level.var_6083 = 255;
  level.var_6087 = 64;
  level.var_608C = 24;
  level.var_609D = 24;
  level.var_60A7 = 12;
  level thread func_3F9E();
  if(getDvar("4017") != "1") {
    level thread func_7B2D();
  }
}

func_6036() {
  print("MatchStarted: Completed");
  if(getDvar("4017") == "1") {
    return;
  }

  if(getDvar("1673") == getDvar("5473")) {
    return;
  }

  if(function_0367()) {
    return;
  }

  var_00 = function_02AA();
  setmatchdata("match_common", "playlist_name", var_00);
  var_01 = function_02AB();
  setmatchdata("match_common", "localTimeStringAtMatchStart", var_01);
  var_02 = getmatchdata("match_common", "player_count");
  setmatchdata("match_common", "player_count_start", var_02);
  function_039E();
  setmatchdata("match_common", "is_esports_rules", maps\mp\_utility::func_56B1());
  if(maps\mp\_utility::func_773F()) {
    setmatchdata("match_common", "is_private_match", 1);
  }

  if(function_03AF()) {
    setmatchdata("match_common", "is_ranked_mode", 1);
  }

  if(func_4574() == 0) {
    setmatchdata("match_common", "utc_start_time", getsystemtime());
    startmatchtimer();
    if(!function_0367() && function_03BC()) {
      function_03BD();
    }
  }

  thread func_0853();
  thread func_5EAE();
}

func_0853() {
  level endon("game_ended");
  for(;;) {
    foreach(var_01 in level.players) {
      if(isbot(var_01) || function_026D(var_01)) {
        continue;
      }

      if(!isDefined(var_01.pers["pingAccumulation"]) || !isDefined(var_01.pers["minPing"]) || !isDefined(var_01.pers["maxPing"]) || !isDefined(var_01.pers["pingSampleCount"])) {
        continue;
      }

      var_02 = var_01 getcurrentping();
      var_01.pers["pingAccumulation"] = var_01.pers["pingAccumulation"] + var_02;
      var_01.pers["pingSampleCount"]++;
      if(var_01.pers["pingSampleCount"] > 5 && var_02 > 0) {
        if(var_02 > var_01.pers["maxPing"]) {
          var_01.pers["maxPing"] = var_02;
        }

        if(var_02 < var_01.pers["minPing"]) {
          var_01.pers["minPing"] = var_02;
        }
      }
    }

    wait(2);
  }
}

func_4574() {
  return getmatchdata("match_common", "utc_start_time");
}

startmatchtimer() {
  game["matchStartTime"] = gettime();
}

getmatchtimepassed() {
  var_00 = 0;
  if(isDefined(game["matchStartTime"])) {
    var_00 = gettime() - game["matchStartTime"];
  }

  return var_00;
}

func_5E99(param_00) {
  if(!func_1F55(self) || !func_1F58()) {
    return;
  }

  var_01 = getmatchdata("killstreak_available_count");
  setmatchdata("killstreak_available_count", var_01 + 1);
  var_02 = getmatchtimepassed();
  setmatchdata("killstreaks_available", var_01, "event_type", maps\mp\_utility::func_452A(param_00));
  setmatchdata("killstreaks_available", var_01, "event_time_ms", var_02);
  setmatchdata("killstreaks_available", var_01, "life_index", self.var_5CC6);
  if(function_03BC()) {
    self dlogevent("dtel_killstreak", ["killstreak", ["life_index", self.var_5CC6, "player_index", self.clientid, "event_type", param_00, "event_time_ms", var_02, "event_pos", [0, 0, 0], "deployed", 0]]);
  }
}

func_5E9A(param_00, param_01) {
  maps\mp\gametypes\_persistence::incrementscorestreakstat(param_00, "uses", 1);
  if(!func_1F55(self) || !func_1F57()) {
    return;
  }

  if(level.var_53C7) {
    if(!isDefined(self.var_80C3)) {
      self.var_80C3 = [];
    }

    if(!isDefined(self.var_80C3[param_00])) {
      self.var_80C3[param_00] = 0;
      if(self.var_80C3.size == 14) {
        maps\mp\gametypes\_missions::processchallenge("ch_scorestreaktraining_allStreaks");
      } else if(self.var_80C3.size == 5) {
        maps\mp\gametypes\_missions::processchallenge("ch_scorestreaktraining_halfStreaks");
      }
    }

    self.var_80C3[param_00]++;
    if(self.var_80C3[param_00] == 3) {
      maps\mp\gametypes\_missions::processchallenge("ch_scorestreaktraining_practiceMakesPerfect");
    }
  }

  var_02 = getmatchdata("killstreak_count");
  setmatchdata("killstreak_count", var_02 + 1);
  var_03 = getmatchtimepassed();
  setmatchdata("killstreaks", var_02, "event_type", maps\mp\_utility::func_452A(param_00));
  setmatchdata("killstreaks", var_02, "event_time_ms", var_03);
  setmatchdata("killstreaks", var_02, "event_pos", 0, int(param_01[0]));
  setmatchdata("killstreaks", var_02, "event_pos", 1, int(param_01[1]));
  setmatchdata("killstreaks", var_02, "event_pos", 2, int(param_01[2]));
  setmatchdata("killstreaks", var_02, "life_index", self.var_5CC6);
  self.var_293B = var_02;
  if(function_03BC()) {
    self dlogevent("dtel_killstreak", ["killstreak", ["life_index", self.var_5CC6, "player_index", self.clientid, "event_type", param_00, "event_time_ms", var_03, "event_pos", [int(param_01[0]), int(param_01[1]), int(param_01[2])], "deployed", 1]]);
  }

  function_00F6(param_01, "script_mp_killstreak: eventType %s, player_name %s, player %d, gameTime %d", param_00, self.name, self.clientid, gettime());
}

logkillstreakassist(param_00) {
  if(!isDefined(param_00.var_293B)) {
    return;
  }

  if(0 <= param_00.var_293B && param_00.var_293B < level.var_6087) {
    var_01 = getmatchdata("killstreaks", param_00.var_293B, "assists_total");
    setmatchdata("killstreaks", param_00.var_293B, "assists_total", var_01 + 1);
  }
}

func_5E93(param_00, param_01, param_02) {
  if(!func_1F56()) {
    return;
  }

  var_03 = -1;
  if(maps\mp\_utility::func_56FF(self)) {
    if(!func_1F55(self)) {
      return;
    } else {
      var_03 = self.var_5CC6;
      if(!isDefined(var_03)) {
        var_03 = -1;
      }
    }
  }

  if(var_03 == -1) {
    return;
  }

  var_04 = getmatchdata("match_common", "event_count");
  setmatchdata("match_common", "event_count", var_04 + 1);
  var_05 = getmatchtimepassed();
  var_06 = 0;
  if(isDefined(param_02)) {
    var_06 = param_02;
  }

  setmatchdata("events", var_04, "event_type", param_00);
  setmatchdata("events", var_04, "event_time_ms", var_05);
  setmatchdata("events", var_04, "event_pos", 0, int(param_01[0]));
  setmatchdata("events", var_04, "event_pos", 1, int(param_01[1]));
  setmatchdata("events", var_04, "event_pos", 2, int(param_01[2]));
  setmatchdata("events", var_04, "life_index", var_03);
  setmatchdata("events", var_04, "extra_data", var_06);
  if(function_03BC()) {
    self dlogevent("dtel_gameevent", ["gameevent", ["life_index", var_03, "event_type", param_00, "event_time_ms", var_05, "event_pos", [int(param_01[0]), int(param_01[1]), int(param_01[2])], "extra_data", var_06]]);
  }

  if(var_03 != -1 && isDefined(self.name) && isDefined(self.clientid)) {
    function_00F6(param_01, "script_mp_event: event_type %s, player_name %s, player %d, gameTime %d", param_00, self.name, self.clientid, gettime());
  }
}

func_5E96(param_00, param_01) {
  if(!func_1F59(param_00)) {
    return;
  }

  setmatchdata("lives", param_00, "death_modifiers", param_01, 1);
  if(function_03BC()) {
    self dlogevent("dtel_death_modifier", ["death", ["life_index", param_00, "player_index", self.clientid, "modifier", param_01]]);
  }
}

func_5E9D(param_00, param_01) {
  if(!func_1F59(param_00)) {
    return;
  }

  setmatchdata("lives", param_00, "multikill", param_01);
  if(function_03BC()) {
    self dlogevent("dtel_multikill", ["death", ["life_index", param_00, "player_index", self.clientid, "multikill", param_01]]);
  }
}

func_5EA6(param_00) {
  if(!func_1F55(self) || !func_1F59(self.var_5CC6)) {
    return;
  }

  var_01 = gettime() - level.var_5CC7[self.var_5CC6];
  self.var_9AB6 = self.var_9AB6 + var_01;
  setmatchdata("lives", self.var_5CC6, "player_index", self.clientid);
  setmatchdata("lives", self.var_5CC6, "spawn_pos", 0, int(self.var_9092[0]));
  setmatchdata("lives", self.var_5CC6, "spawn_pos", 1, int(self.var_9092[1]));
  setmatchdata("lives", self.var_5CC6, "spawn_pos", 2, int(self.var_9092[2]));
  setmatchdata("lives", self.var_5CC6, "wasTacticalInsertion", self.var_A87A);
  if(isDefined(self.var_90AC)) {
    setmatchdata("lives", self.var_5CC6, "spawn_time_ms", self.var_90AC);
  } else {
    setmatchdata("lives", self.var_5CC6, "spawn_time_ms", -1);
  }

  setmatchdata("lives", self.var_5CC6, "duration_ms", var_01);
  if(!isDefined(level.iszombiegame) && level.iszombiegame) {
    if(isDefined(self.var_2943)) {
      setmatchdata("lives", self.var_5CC6, "victim_loadout_index", self.var_2943);
    } else {
      setmatchdata("lives", self.var_5CC6, "victim_loadout_index", -1);
    }
  }

  var_02 = maps\mp\_utility::clamptoshort(self.pers["score"] - self.var_80A7);
  setmatchdata("lives", self.var_5CC6, "score_earned", var_02);
  if(isDefined(self.pers["summary"]) && isDefined(self.pers["summary"]["xp"])) {
    if(isDefined(self.var_AAD0)) {
      var_03 = maps\mp\_utility::clamptoshort(self.pers["summary"]["xp"] - self.var_AAD0);
      setmatchdata("lives", self.var_5CC6, "xp_earned", var_03);
    }
  }
}

func_5EAA(param_00, param_01) {
  if(!func_1F55(self)) {
    return;
  }

  setmatchdata("players", self.clientid, param_01, param_00);
}

func_5EA1(param_00, param_01) {
  if(!func_1F55(self) || isbot(self)) {
    return;
  }

  var_02 = getmatchdata("players", self.clientid, "awards", param_00);
  var_02 = var_02 + param_01;
  var_02 = maps\mp\_utility::func_2314(var_02);
  setmatchdata("players", self.clientid, "awards", param_00, var_02);
}

func_5E9F(param_00, param_01) {
  if(!func_1F55(self) || !func_1F55(param_01) || !func_1F59(param_00)) {
    return;
  }

  if(param_01 playerads() > 0.5) {
    setmatchdata("lives", param_00, "attacker_was_ads", 1);
  }

  var_02 = param_01 getEye();
  if(common_scripts\utility::func_AA4A(var_02, param_01.angles, self.origin, cos(getdvarfloat("cg_fov")))) {
    setmatchdata("lives", param_00, "victim_was_in_attacker_fov", 1);
  }

  var_03 = self getEye();
  if(common_scripts\utility::func_AA4A(var_03, self.angles, param_01.origin, cos(getdvarfloat("cg_fov")))) {
    setmatchdata("lives", param_00, "attacker_was_in_victim_fov", 1);
  }

  if(self playerads() > 0.5) {
    setmatchdata("lives", param_00, "victim_was_ads", 1);
  }
}

func_2E62(param_00, param_01) {
  var_02 = 6;
  var_03 = undefined;
  var_04 = undefined;
  if(param_00 == "none") {
    var_03 = "none";
    var_04 = "none";
  } else {
    var_03 = function_01D4(param_00);
    var_04 = function_01AA(param_00);
  }

  if(issubstr(param_00, "destructible")) {
    param_00 = "destructible";
  }

  var_05 = [];
  for(var_06 = 0; var_06 < var_02; var_06++) {
    var_05[var_06] = "None";
  }

  var_07 = "";
  if(isDefined(var_03) && (var_03 == "primary" || var_03 == "altmode") && var_04 == "pistol" || var_04 == "smg" || var_04 == "rifle" || var_04 == "spread" || var_04 == "mg" || var_04 == "grenade" || var_04 == "rocketlauncher" || var_04 == "sniper" || var_04 == "cone" || var_04 == "beam" || var_04 == "shield") {
    if(var_03 == "altmode") {
      if(isDefined(param_01)) {
        param_00 = param_01;
      }
    }

    var_07 = maps\mp\_utility::getbaseweaponname(param_00);
    var_08 = function_0061(param_00);
    var_06 = 0;
    foreach(var_0A in var_08) {
      if(!maps\mp\_utility::isattachment(var_0A)) {
        continue;
      }

      var_0B = maps\mp\_utility::func_1150(var_0A);
      if(var_06 < var_02) {
        var_05[var_06] = var_0B;
        var_06++;
        continue;
      }

      break;
    }
  } else {
    var_07 = maps\mp\_utility::getbaseweaponname(param_00);
  }

  if(maps\mp\_utility::func_579B() && var_07 == "m712carry_mp" || var_07 == "raid_carryflag_mp") {
    var_07 = "m712_mp";
  }

  var_0D = spawnStruct();
  var_0D.var_A9E0 = var_07;
  var_0D.var_1154 = var_05;
  var_0D.var_A9F4 = var_03;
  var_0D.var_A9BF = var_04;
  var_0D.var_A9E1 = param_00;
  return var_0D;
}

func_5EA0(param_00, param_01) {
  if(!func_1F59(param_00)) {
    return;
  }

  if(func_1F55(self)) {
    var_02 = getstanceandmotionstateforplayer(self);
    setmatchdata("lives", param_00, "victim_motionstate", var_02);
  }

  if(func_1F55(param_01)) {
    var_02 = getstanceandmotionstateforplayer(param_01);
    setmatchdata("lives", param_00, "attacker_motionstate", var_02);
  }
}

func_5EA5(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
    if(level.iszombiegame) {
      var_09 = common_scripts\utility::func_98E7(isDefined(self.name), self.name, "");
      var_0A = "";
      var_0B = "";
      if(isDefined(param_02)) {
        if(isDefined(param_02.var_A4B)) {
          var_0A = param_02.var_A4B;
        }

        if(isDefined(param_02.name)) {
          var_0B = param_02.name;
        }
      }

      var_0C = common_scripts\utility::func_98E7(isDefined(param_05), param_05, "");
      function_00F6(self.origin, "script_zombie_playerdeath: iDamage %d, sMeansOfDeath %s, sHitLoc %s, victimCurrentWeapon %s, sKillersWeapon %s, attackerName %s, victimName %s, zombie_type %s, zombies_wave %d", param_03, param_04, param_07, param_08, var_0C, var_0B, var_09, var_0A, level.var_A980);
      return;
    }

    if(!func_1F55(self) || !func_1F55(param_06) || !func_1F59(param_04)) {
      return;
    }

    if(param_05 == param_06) {
      func_5E9F(param_04, param_06);
    }

    func_5EA0(param_04, param_06);
    if(isDefined(param_05) && isDefined(param_05.var_5CC6) && param_05.var_5CC6 != -1) {
      var_0D = param_05.var_5CC6;
    } else {
      var_0D = param_07.var_5CC6;
    }

    if(!isDefined(var_0D)) {
      var_0D = -1;
    }

    var_0E = maps\mp\_utility::func_473D(var_09);
    setmatchdata("lives", param_04, "attacker_weapon_guid", var_0E.guid);
    var_0F = func_2E62(var_09, var_0A);
    if(function_012A("Weapon", var_0F.var_A9E0)) {
      setmatchdata("lives", param_04, "attacker_weapon", var_0F.var_A9E0);
    }

    if(isDefined(param_06) && param_06 method_8680()) {
      setmatchdata("lives", param_04, "attacker_weapon_altmode", 1);
    }

    if(maps\mp\_utility::iskillstreakweapon(var_0F.var_A9E1)) {
      func_5E96(param_04, "killstreak");
      if(isDefined(param_06.var_293B)) {
        var_10 = getmatchdata("killstreaks", param_06.var_293B, "kills_total");
        var_10++;
        setmatchdata("killstreaks", param_06.var_293B, "kills_total", maps\mp\_utility::clamptoshort(var_10));
        setmatchdata("lives", param_04, "attacker_killstreak_index", param_06.var_293B);
      } else {
        setmatchdata("lives", param_04, "attacker_killstreak_index", 255);
      }
    } else {
      setmatchdata("lives", param_04, "attacker_killstreak_index", 255);
    }

    var_11 = getmatchtimepassed();
    setmatchdata("lives", self.var_5CC6, "death_time_ms", var_11);
    if(!isDefined(param_06.var_3C6C)) {
      param_06.var_3C6C = var_11;
    }

    if(isDefined(self.var_3C6C)) {
      setmatchdata("lives", param_04, "first_kill_time_ms", self.var_3C6C);
    }

    var_12 = func_2E62(var_0C, undefined);
    if(var_12.var_A9F4 != "exclusive" && !function_0367()) {
      if(maps\mp\_utility::iskillstreakweapon(var_12.var_A9E0)) {
        if(isDefined(self.primaryweapon)) {
          var_13 = maps\mp\_utility::getbaseweaponname(self.primaryweapon);
          setmatchdata("lives", param_04, "victim_weapon", var_13);
        }
      } else {
        setmatchdata("lives", param_04, "victim_weapon", var_12.var_A9E0);
      }
    }

    var_14 = maps\mp\_utility::func_473D(var_0C);
    setmatchdata("lives", param_04, "victim_weapon_guid", var_14.guid);
    if(self method_8680()) {
      setmatchdata("lives", param_04, "victim_weapon_altmode", 1);
    }

    if(isDefined(self.pickedupweaponfrom) && isDefined(self.pickedupweaponfrom[var_12.var_A9E1])) {
      setmatchdata("lives", param_04, "victim_weapon_pickedup", 1);
    }

    setmatchdata("lives", param_04, "means_of_death", param_08);
    var_15 = 2;
    var_16 = 0;
    var_17 = -1;
    var_18 = 0;
    var_19 = self.var_29B9;
    var_1A = self.var_29DA;
    var_1B = self.var_90AE;
    if(var_1B < 0) {
      var_1B = gettime() - level.var_5CC7[self.var_5CC6] / 1000;
    }

    var_1C = self.var_90AD;
    var_1D = self.var_9A16;
    var_1E = self.var_9A17;
    var_1F = 0;
    if(isPlayer(param_06)) {
      setmatchdata("lives", param_04, "attacker", param_06.var_2418);
      if(var_0D == -1) {
        setmatchdata("lives", param_04, "attacker_life_index", -1);
      } else {
        setmatchdata("lives", param_04, "attacker_life_index", var_0D);
      }

      setmatchdata("lives", param_04, "attacker_pos", 0, int(param_06.origin[0]));
      setmatchdata("lives", param_04, "attacker_pos", 1, int(param_06.origin[1]));
      setmatchdata("lives", param_04, "attacker_pos", 2, int(param_06.origin[2]));
      setmatchdata("lives", param_04, "attacker_angles", 0, int(param_06.angles[0]));
      setmatchdata("lives", param_04, "attacker_angles", 1, int(param_06.angles[1]));
      setmatchdata("lives", param_04, "attacker_angles", 2, int(param_06.angles[2]));
      if(isDefined(param_06.var_2942) && param_06.var_2942 >= 0) {
        setmatchdata("lives", param_04, "attacker_minimap_callout_index", param_06.var_2942);
      } else {
        setmatchdata("lives", param_04, "attacker_minimap_callout_index", 255);
      }

      var_20 = anglesToForward((0, self.angles[1], 0));
      var_21 = self.origin - param_06.origin;
      var_21 = vectorNormalize((var_21[0], var_21[1], 0));
      var_15 = vectordot(var_20, var_21);
      var_22 = var_15 * -1;
      if(var_22 >= cos(getdvarint("cg_fov", 65))) {
        var_16 = 1;
      }

      if(param_08 == "MOD_EXPLOSIVE" || param_08 == "MOD_GRENADE" || param_08 == "MOD_GRENADE_SPLASH" || param_08 == "MOD_PROJECTILE_SPLASH" || param_08 == "MOD_PROJECTILE" || param_08 == "MOD_MELEE" || param_08 == "MOD_MELEE_ALT" || param_08 == "MOD_MELEE_DOG" || maps\mp\_utility::func_5697(param_08, var_09) || param_08 == "MOD_SUICIDE" || param_08 == "MOD_IMPACT" || param_08 == "MOD_TRIGGER_HURT" || param_08 == "MOD_FALLING" || param_08 == "MOD_CRUSH" || isDefined(level.var_5A7D) && isDefined(level.var_5A7D[var_09])) {
        var_16 = -1;
      }

      if(isDefined(self.var_1189) && isDefined(self.var_1189[param_06.guid]) && isDefined(self.var_1189[param_06.guid].var_3C67)) {
        var_17 = self.var_1189[param_06.guid].var_3C67;
      }

      var_18 = -1;
      if(isDefined(self.var_A491)) {
        var_18 = isDefined(self.var_A491[param_06.guid]) && self.var_A491[param_06.guid].var_A493 == param_06.var_5CC6;
      }

      var_1F = 180 - acos(clamp(var_15, -1, 1));
      setmatchdata("lives", param_04, "dot_of_death", var_15);
      if(isDefined(param_06.pickedupweaponfrom) && isDefined(param_06.pickedupweaponfrom[var_0F.var_A9E1])) {
        setmatchdata("lives", param_04, "attacker_weapon_pickedup", 1);
      }

      if(isDefined(param_06.var_2943)) {
        setmatchdata("lives", param_04, "attacker_loadout_index", param_06.var_2943);
      }
    } else {
      setmatchdata("lives", param_04, "attacker", 255);
      setmatchdata("lives", param_04, "attacker_life_index", -1);
      setmatchdata("lives", param_04, "attacker_pos", 0, int(self.origin[0]));
      setmatchdata("lives", param_04, "attacker_pos", 1, int(self.origin[1]));
      setmatchdata("lives", param_04, "attacker_pos", 2, int(self.origin[2]));
      setmatchdata("lives", param_04, "attacker_angles", 0, int(self.angles[0]));
      setmatchdata("lives", param_04, "attacker_angles", 1, int(self.angles[1]));
      setmatchdata("lives", param_04, "attacker_angles", 2, int(self.angles[2]));
      setmatchdata("lives", param_04, "attacker_minimap_callout_index", 255);
    }

    setmatchdata("lives", param_04, "player_index", self.clientid);
    setmatchdata("lives", param_04, "victim_pos", 0, int(self.origin[0]));
    setmatchdata("lives", param_04, "victim_pos", 1, int(self.origin[1]));
    setmatchdata("lives", param_04, "victim_pos", 2, int(self.origin[2]));
    setmatchdata("lives", param_04, "victim_angles", 0, int(self.angles[0]));
    setmatchdata("lives", param_04, "victim_angles", 1, int(self.angles[1]));
    setmatchdata("lives", param_04, "victim_angles", 2, int(self.angles[2]));
    if(isDefined(self.var_2942) && self.var_2942 >= 0) {
      setmatchdata("lives", param_04, "victim_minimap_callout_index", self.var_2942);
    } else {
      setmatchdata("lives", param_04, "victim_minimap_callout_index", 255);
    }

    var_23 = "world";
    if(isPlayer(param_06)) {
      var_23 = param_06.name;
    }

    var_24 = 1;
    var_25 = 0;
    var_26 = maps\mp\_utility::func_566A(self);
    var_27 = 0;
    if(isPlayer(param_06)) {
      var_27 = maps\mp\_utility::func_566A(param_06);
    }

    var_28 = length(self.origin - param_06.origin);
    var_29 = 0;
    var_2A = 0;
    var_2B = -1;
    var_2C = -1;
    var_2D = gettime();
    if(isPlayer(param_06)) {
      var_2A = param_06 playerads();
    }

    var_2E = param_06.var_2418;
    if(!isDefined(var_2E)) {
      var_2E = -1;
    }

    var_2F = 8.2;
    var_30 = 4;
    var_31 = 2;
    if(self.var_29A2.size > 1) {
      var_24 = 0;
    }

    if(isDefined(self.var_29A2[param_06 getentitynumber()])) {
      var_25 = self.var_29A2[param_06 getentitynumber()].var_6875;
    }

    var_32 = self.var_A9F6;
    var_33 = function_01AA(var_32);
    if(issubstr(var_0F.var_A9E0, "loot")) {
      var_29 = 1;
    }

    if(isDefined(self.var_5CC6) && isDefined(level.var_5CC7[self.var_5CC6])) {
      var_2B = var_2D - level.var_5CC7[self.var_5CC6] / 1000;
    }

    if(isDefined(level.var_5CC7[var_0D]) && isPlayer(param_06)) {
      var_2C = var_2D - level.var_5CC7[var_0D] / 1000;
    }

    var_36 = [];
    var_37 = [];
    for(var_38 = 0; var_38 < 9; var_38++) {
      if(isDefined(self.var_5DFA) && isDefined(self.var_5DFA[var_38]) && self.var_5DFA[var_38] != 0) {
        var_36[var_38] = getitemreffromguid(self.var_5DFA[var_38]);
      } else {
        var_36[var_38] = "none";
      }

      if(isDefined(param_06.var_5DFA) && isDefined(param_06.var_5DFA[var_38]) && param_06.var_5DFA[var_38] != 0) {
        var_37[var_38] = getitemreffromguid(param_06.var_5DFA[var_38]);
        continue;
      }

      var_37[var_38] = "none";
    }

    function_00F6(self.origin, "@"script_mp_playerdeath: player_name % s, life_id % d, angles % v, death_dot % f, is_killstreak % b, mod % s, gameTime % d, spawnToDeathTime % f, attackerAliveTime % f, attacker_life_id % d, perk1 % s, perk2 % s, perk3 % s, perk4 % s, perk5 % s, perk6 % s, headOnHead % d, angle % f, damagedAttacker % d, damageDealtThisLife % f, damageRecievedThisLife % f, spawnToDamageReceivedTime % f, spawnToDamageDealtTime % f, timeSpentSprintingThisLife % f, timeSpentSprintingToFirstEngagement % f, spawnVersion % f, firstDamageHeadOnHead % d ",self.name,self.var_5CC6,self.angles,var_15,maps\mp\_utility::iskillstreakweapon(var_0F.var_A9E1),param_08,var_2D,var_2B,var_2C,var_0D,var_36[0],var_36[1],var_36[2],var_36[3],var_36[4],var_36[5],var_16,var_1F,var_18,var_19,var_1A,var_1B,var_1C,var_1D,var_1E,level.var_90B4,var_17);
        function_00F6(self.origin, "@"script_mp_weaponinfo: player_name % s, life_id % d, isbot % b, attacker_name % s, attacker % d, attacker_pos % v, distance % f, ads_fraction % f, is_killstreak % b, weapon_type % s, weapon_class % s, weapon_name % s, isLoot % b, attachment0 % s, attachment1 % s, attachment2 % s, numShots % d, soleAttacker % b, gameTime % d, attachment3 % s, attachment4 % s, attachment5 % s ",self.name,self.var_5CC6,var_26,var_23,var_2E,param_06.origin,var_28,var_2A,maps\mp\_utility::iskillstreakweapon(var_0F.var_A9E1),var_0F.var_A9F4,var_0F.var_A9BF,var_0F.var_A9E0,var_29,var_0F.var_1154[0],var_0F.var_1154[1],var_0F.var_1154[2],var_25,var_24,var_2D,var_0F.var_1154[3],var_0F.var_1154[4],var_0F.var_1154[5]);
          function_00F6(self.origin, "@"script_mp_weaponinfo_ext: player_name % s, life_id % d, gametime % d, version % f, victimWeapon % s, victimWeaponClass % s, killerIsBot % b, vic_attachment0 % s, vic_attachment1 % s, vic_attachment2 % s, vic_attachment3 % s, vic_attachment4 % s, vic_attachment5 % s, mechanics_version % f ",self.name,self.var_5CC6,var_2D,var_2F,var_12.var_A9E0,var_12.var_A9BF,var_27,var_12.var_1154[0],var_12.var_1154[1],var_12.var_1154[2],var_12.var_1154[3],var_12.var_1154[4],var_12.var_1154[5],var_31);
            if(isDefined(param_06.var_5DFA) && isDefined(param_06.var_5DFA[0]) && isDefined(param_06.var_5DFA[1]) && isDefined(param_06.var_5DFA[2]) && isDefined(param_06.var_5DFA[3]) && isDefined(param_06.var_5DFA[4]) && isDefined(param_06.var_5DFA[5]) && isDefined(param_06.var_5DFA[6]) && isDefined(param_06.var_5DFA[7]) && isDefined(param_06.var_5DFA[8])) {
              function_00F6(self.origin, "@"script_mp_divisions_perks: player_name % s, life_id % d, gameTime % d, perkVersion % f, attacker_life_id % d, perk1 % s, perk2 % s, perk3 % s, perk4 % s, perk5 % s, perk6 % s, perk7 % s, perk8 % s, perk9 % s, attacker_perk1 % s, attacker_perk2 % s, attacker_perk3 % s, attacker_perk4 % s, attacker_perk5 % s, attacker_perk6 % s, attacker_perk7 % s, attacker_perk8 % s, attacker_perk9 % s ",self.name,self.var_5CC6,var_2D,var_30,var_0D,var_36[0],var_36[1],var_36[2],var_36[3],var_36[4],var_36[5],var_36[6],var_36[7],var_36[8],var_37[0],var_37[1],var_37[2],var_37[3],var_37[4],var_37[5],var_37[6],var_37[7],var_37[8]);
              }

              if(!isDefined(level.var_6026)) {
                level.var_6026 = [];
              }

              if(!isDefined(game["deathCount"])) {
                game["deathCount"] = 1;
              } else {
                game["deathCount"]++;
              }

              if(var_2B <= 3) {
                if(isDefined(self.pers["victimSpawnCount"])) {
                  self.pers["victimSpawnCount"]++;
                }

                if(isDefined(param_06) && isDefined(param_06.pers) && isDefined(param_06.pers["causedVictimSpawnCount"])) {
                  param_06.pers["causedVictimSpawnCount"]++;
                }

                if(!isDefined(game["trapSpawnDiedTooFastCount"])) {
                  game["trapSpawnDiedTooFastCount"] = 1;
                } else {
                  game["trapSpawnDiedTooFastCount"]++;
                }

                if(self.var_9070.var_9CFD == 0) {
                  if(!isDefined(game["trapSpawnByAnyMeansCount"])) {
                    game["trapSpawnByAnyMeansCount"] = 1;
                  } else {
                    game["trapSpawnByAnyMeansCount"]++;
                  }

                  if(isDefined(self.pers["badSpawnByAnyMeansCount"])) {
                    self.pers["badSpawnByAnyMeansCount"]++;
                  }

                  if(isDefined(param_06) && isDefined(param_06.pers) && isDefined(param_06.pers["causedBadSpawnByAnyMeansCount"])) {
                    param_06.pers["causedBadSpawnByAnyMeansCount"]++;
                  }

                  self.var_9070.var_9CFD = 1;
                }
              }

              if(isPlayer(param_06) && var_2C <= 3 && !var_0F.var_A9E0 == "sentry_minigun_mp") {
                if(isDefined(param_06) && isDefined(param_06.pers["victimSpawnCount"])) {
                  param_06.pers["victimSpawnCount"]++;
                }

                if(!isDefined(game["trapSpawnKilledTooFastCount"])) {
                  game["trapSpawnKilledTooFastCount"] = 1;
                } else {
                  game["trapSpawnKilledTooFastCount"]++;
                }

                if(param_06.var_9070.var_9CFD == 0) {
                  if(!isDefined(game["trapSpawnByAnyMeansCount"])) {
                    game["trapSpawnByAnyMeansCount"] = 1;
                  } else {
                    game["trapSpawnByAnyMeansCount"]++;
                  }

                  param_06.pers["badSpawnByAnyMeansCount"]++;
                  param_06.var_9070.var_9CFD = 1;
                }
              }

              if(function_03BC()) {
                var_39 = self.origin;
                if(isDefined(self.fighterspawningfunc)) {
                  var_39 = (clamp(var_39[0], -32767, 32767), clamp(var_39[1], -32767, 32767), clamp(var_39[2], -32767, 32767));
                }

                var_3A = [int(var_39[0]), int(var_39[1]), int(var_39[2])];
                var_3B = getmatchdata("lives", param_04, "attacker_life_index");
                var_3C = getmatchdata("lives", var_3B, "player_index");
                var_3D = var_3A;
                if(isPlayer(param_06)) {
                  var_3E = param_06.origin;
                  if(isDefined(param_06.fighterspawningfunc)) {
                    var_3E = (clamp(var_3E[0], -32767, 32767), clamp(var_3E[1], -32767, 32767), clamp(var_3E[2], -32767, 32767));
                  }

                  var_3D = [int(var_3E[0]), int(var_3E[1]), int(var_3E[2])];
                }

                self dlogevent("dtel_death", ["death", ["life_index", param_04, "player_index", self.clientid, "death_pos", var_3A, "death_time_ms", var_11, "victim_weapon_guid", var_14.guid, "attacker_life_index", var_3B, "attacker_player_index", var_3C, "attacker_pos", var_3D, "attacker_weapon_guid", var_0E.guid]]);
              }
            }

            func_5EA4() {
              if(!func_1F55(self)) {
                return;
              }

              setmatchdata("players", self.clientid, "score", maps\mp\_utility::getpersstat("score"));
              if(maps\mp\_utility::getpersstat("assists") > 255) {
                setmatchdata("players", self.clientid, "assists", 255);
              } else {
                setmatchdata("players", self.clientid, "assists", maps\mp\_utility::getpersstat("assists"));
              }

              if(maps\mp\_utility::getpersstat("longestStreak") > 255) {
                setmatchdata("players", self.clientid, "longest_streak", 255);
              } else {
                setmatchdata("players", self.clientid, "longest_streak", maps\mp\_utility::getpersstat("longestStreak"));
              }

              if(isDefined(self) && isDefined(self.pers) && isDefined(self.pers["validationInfractions"])) {
                if(maps\mp\_utility::getpersstat("validationInfractions") > 255) {
                  setmatchdata("players", self.clientid, "validation_infractions", 255);
                } else {
                  setmatchdata("players", self.clientid, "validation_infractions", maps\mp\_utility::getpersstat("validationInfractions"));
                }
              }

              var_00 = -1;
              var_01 = -1;
              var_02 = -1;
              var_03 = -1;
              var_04 = -1;
              if(isDefined(self.pers["spawnCount"])) {
                var_00 = self.pers["spawnCount"];
              }

              if(isDefined(self.pers["immediateActionSpawnCount"])) {
                var_01 = self.pers["immediateActionSpawnCount"];
              }

              if(isDefined(self.pers["victimSpawnCount"])) {
                var_02 = self.pers["victimSpawnCount"];
              }

              if(isDefined(self.pers["causedImmediateActionSpawnCount"])) {
                var_03 = self.pers["causedImmediateActionSpawnCount"];
              }

              if(isDefined(self.pers["causedVictimSpawnCount"])) {
                var_04 = self.pers["causedVictimSpawnCount"];
              }

              setmatchdata("players", self.clientid, "spawns", maps\mp\_utility::clamptoshort(var_00));
              setmatchdata("players", self.clientid, "immediate_action_spawns", maps\mp\_utility::clamptoshort(var_01));
              setmatchdata("players", self.clientid, "victim_spawns", maps\mp\_utility::clamptoshort(var_02));
              setmatchdata("players", self.clientid, "immediate_actions_caused", maps\mp\_utility::clamptoshort(var_03));
              setmatchdata("players", self.clientid, "victim_spawns_caused", maps\mp\_utility::clamptoshort(var_04));
              if(isDefined(level.iszombiegame) && level.iszombiegame) {
                return;
              }

              maps\mp\gametypes\_weapons::func_A196();
              maps\mp\gametypes\_divisions::updatedivisionusagestats();
              var_05 = 0;
              foreach(var_07 in self.pers["mpMatchdataWeaponStats"]) {
                if(var_05 < level.var_60A7) {
                  foreach(var_0A, var_09 in var_07) {
                    setmatchdata("players", self.clientid, "weapon_stats", var_05, var_0A, var_09);
                  }

                  var_05++;
                }
              }

              setmatchdata("players", self.clientid, "kills", maps\mp\_utility::clamptoshort(self.pers["kills"]));
              setmatchdata("players", self.clientid, "deaths", maps\mp\_utility::clamptoshort(self.pers["deaths"]));
              var_0C = self getrankedplayerdata(common_scripts\utility::getstatgamemode(), "callingCardIndex");
              var_0D = self getrankedplayerdata(common_scripts\utility::getstatgamemode(), "activeEmblemSlot");
              setmatchdata("players", self.clientid, "calling_card_index", var_0C);
              setmatchdata("players", self.clientid, "active_emblem_slot", var_0D);
            }

            func_36DB() {
              foreach(var_01 in level.players) {
                wait 0.05;
                if(!isDefined(var_01)) {
                  continue;
                }

                func_5EA7(var_01);
                if(isDefined(var_01.var_2E50) && var_01.var_2E50 && var_01 maps\mp\_utility::rankingenabled()) {
                  var_01 setrankedplayerdata(common_scripts\utility::func_46AE(), "restXPGoal", var_01.var_2E50);
                }

                if(isDefined(var_01.pers["weaponsUsed"])) {
                  var_01 func_32C6();
                  var_02 = 0;
                  if(var_01.pers["weaponsUsed"].size > 3) {
                    for(var_03 = var_01.pers["weaponsUsed"].size - 1; var_03 > var_01.pers["weaponsUsed"].size - 3; var_03--) {
                      var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "weaponsUsed", var_02, var_01.pers["weaponsUsed"][var_03]);
                      var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "weaponXpEarned", var_02, var_01.pers["weaponXpEarned"][var_03]);
                      var_02++;
                    }
                  } else {
                    for(var_03 = var_01.pers["weaponsUsed"].size - 1; var_03 >= 0; var_03--) {
                      var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "weaponsUsed", var_02, var_01.pers["weaponsUsed"][var_03]);
                      var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "weaponXpEarned", var_02, var_01.pers["weaponXpEarned"][var_03]);
                      var_02++;
                    }
                  }
                } else {
                  var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "weaponsUsed", 0, "none");
                  var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "weaponsUsed", 1, "none");
                  var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "weaponsUsed", 2, "none");
                  var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "weaponXpEarned", 0, 0);
                  var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "weaponXpEarned", 1, 0);
                  var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "weaponXpEarned", 2, 0);
                }

                var_04 = undefined;
                var_05 = 0;
                if(isDefined(game["challengeStruct"]) && isDefined(game["challengeStruct"]["challengesCompleted"]) && isDefined(game["challengeStruct"]["challengesCompleted"][var_01.guid])) {
                  var_05 = 1;
                }

                if(var_05) {
                  var_04 = game["challengeStruct"]["challengesCompleted"][var_01.guid];
                  if(var_04.size > 0) {
                    var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "challengeNumCompleted", var_04.size);
                    var_06 = maps\mp\_utility::func_2314(var_04.size);
                    setmatchdata("players", var_01.var_2418, "challenges_completed", var_06);
                  } else {
                    var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "challengeNumCompleted", 0);
                  }
                } else {
                  var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "challengeNumCompleted", 0);
                }

                for(var_03 = 0; var_03 < 20; var_03++) {
                  if(isDefined(var_04) && isDefined(var_04[var_03]) && var_04[var_03] != 8000) {
                    var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "challengesCompleted", var_03, var_04[var_03]);
                    continue;
                  }

                  var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "challengesCompleted", var_03, 0);
                }

                var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "gameMode", level.gametype);
                var_01 setrankedplayerdata(common_scripts\utility::getstatgamemode(), "round", "map", tolower(getDvar("1673")));
              }
            }

            func_32C6() {
              var_00 = self.pers["weaponXpEarned"];
              var_01 = self.pers["weaponXpEarned"].size;
              for(var_02 = var_01 - 1; var_02 > 0; var_02--) {
                for(var_03 = 1; var_03 <= var_02; var_03++) {
                  if(var_00[var_03 - 1] < var_00[var_03]) {
                    var_04 = self.pers["weaponsUsed"][var_03];
                    self.pers["weaponsUsed"][var_03] = self.pers["weaponsUsed"][var_03 - 1];
                    self.pers["weaponsUsed"][var_03 - 1] = var_04;
                    var_05 = self.pers["weaponXpEarned"][var_03];
                    self.pers["weaponXpEarned"][var_03] = self.pers["weaponXpEarned"][var_03 - 1];
                    self.pers["weaponXpEarned"][var_03 - 1] = var_05;
                    var_00 = self.pers["weaponXpEarned"];
                  }
                }
              }
            }

            func_5EA7(param_00) {
              if(!isDefined(param_00.pers["maxPing"]) || !isDefined(param_00.pers["minPing"]) || !isDefined(param_00.pers["pingAccumulation"]) || !isDefined(param_00.pers["pingSampleCount"])) {
                return;
              }

              if(param_00.pers["pingSampleCount"] > 0 && param_00.pers["maxPing"] > 0) {
                var_01 = maps\mp\_utility::clamptoshort(param_00.pers["pingAccumulation"] / param_00.pers["pingSampleCount"]);
                setmatchdata("players", param_00.var_2418, "average_ping", var_01);
                setmatchdata("players", param_00.var_2418, "max_ping", maps\mp\_utility::clamptoshort(param_00.pers["maxPing"]));
                setmatchdata("players", param_00.var_2418, "min_ping", maps\mp\_utility::clamptoshort(param_00.pers["minPing"]));
              }
            }

            func_3F9E() {
              level waittill("game_ended");
              foreach(var_01 in level.players) {
                var_01 func_5EA4();
                if(!isalive(var_01)) {
                  continue;
                }

                var_01 func_5EA6(0);
              }

              foreach(var_01 in level.players) {
                if(var_01.var_9AB6 > 0) {
                  var_04 = var_01 maps\mp\_utility::getpersstat("score") / var_01.var_9AB6 / -5536;
                  function_0228(var_01.var_1D6, var_04, var_01.team);
                }

                var_01.var_9AB6 = 0;
              }
            }

            func_1F55(param_00) {
              if(function_0367()) {
                return 0;
              }

              if(!isPlayer(param_00) || function_01EF(param_00)) {
                return 0;
              }

              return param_00.var_2418 < level.var_608C;
            }

            func_1F56() {
              return getmatchdata("match_common", "event_count") < level.var_6083;
            }

            func_1F57() {
              return getmatchdata("killstreak_count") < level.var_6087;
            }

            func_1F58() {
              return getmatchdata("killstreak_available_count") < level.var_6087;
            }

            func_1F59(param_00) {
              return isDefined(param_00) && param_00 < level.var_608B - 1;
            }

            func_5EAF(param_00, param_01, param_02, param_03) {
              if(!func_1F55(self)) {
                return;
              }

              if(maps\mp\_utility::iskillstreakweapon(param_00)) {
                return;
              }

              if(!isDefined(self.pers["mpWeaponStats"][param_00])) {
                self.pers["mpWeaponStats"][param_00] = [];
              }

              if(!isDefined(self.pers["mpWeaponStats"][param_00][param_01])) {
                self.pers["mpWeaponStats"][param_00][param_01] = 0;
              }

              var_04 = self.pers["mpWeaponStats"][param_00][param_01];
              var_04 = var_04 + param_02;
              self.pers["mpWeaponStats"][param_00][param_01] = var_04;
              if(isDefined(level.iszombiegame) && level.iszombiegame) {
                return;
              }

              var_05 = isbot(self) || function_026D(self);
              if(!var_05) {
                var_06 = maps\mp\_utility::func_473D(param_03);
                var_07 = var_06.guid;
                if(isDefined(var_07) && var_07 != 0) {
                  if(isDefined(self.var_2943) && isDefined(self.var_294A) && isDefined(self.var_294C)) {
                    if(var_07 == self.var_294A || var_07 == self.var_294C) {
                      if(param_01 == "headShots") {
                        param_01 = "headshots";
                      } else if(param_01 == "timeInUse") {
                        param_01 = "time_in_use_seconds";
                      } else if(param_01 == "hipfirekills") {
                        param_01 = "hipfire_kills";
                      } else if(param_01 == "experience") {
                        param_01 = "xp";
                      } else if(param_01 == "shots" || param_01 == "hits" || param_01 == "kills" || param_01 == "deaths") {} else {
                        return;
                      }

                      var_08 = var_07 + "_" + self.var_2943;
                      if(!isDefined(self.pers["mpMatchdataWeaponStats"][var_08])) {
                        self.pers["mpMatchdataWeaponStats"][var_08] = [];
                        self.pers["mpMatchdataWeaponStats"][var_08]["weapon_guid"] = var_07;
                        self.pers["mpMatchdataWeaponStats"][var_08]["loadout_index"] = self.var_2943;
                      }

                      if(!isDefined(self.pers["mpMatchdataWeaponStats"][var_08][param_01])) {
                        self.pers["mpMatchdataWeaponStats"][var_08][param_01] = 0;
                      }

                      self.pers["mpMatchdataWeaponStats"][var_08][param_01] = self.pers["mpMatchdataWeaponStats"][var_08][param_01] + param_02;
                      return;
                    }

                    return;
                  }
                }
              }
            }

            func_1D40() {
              var_00 = [];
              var_01 = function_027A("mp/statstable.csv");
              for(var_02 = 0; var_02 <= var_01; var_02++) {
                var_03 = tablelookupbyrow("mp/statstable.csv", var_02, 0);
                if(!issubstr(var_03, "weapon_")) {
                  continue;
                }

                if(var_03 == "weapon_other") {
                  continue;
                }

                if(tablelookupbyrow("mp/statstable.csv", var_02, 20) != "") {
                  continue;
                }

                var_04 = tablelookupbyrow("mp/statstable.csv", var_02, 2);
                if(var_04 == "") {
                  continue;
                }

                var_00[var_00.size] = var_04;
              }

              return var_00;
            }

            func_5E97() {
              if(!func_1F55(self)) {
                return;
              }

              setmatchdata("players", self.clientid, "kills_confirmed", self.pers["confirmed"]);
            }

            func_5E98() {
              if(!func_1F55(self)) {
                return;
              }

              setmatchdata("players", self.clientid, "kills_denied", self.pers["denied"]);
            }

            func_5E95() {
              if(isDefined(level.iszombiegame) && level.iszombiegame) {
                return;
              }

              if(getdvarint("2506") > 0) {
                var_00 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "experience");
                setmatchdata("players", self.clientid, "start_xp", var_00);
                setmatchdata("players", self.clientid, "start_kills", self getrankedplayerdata(common_scripts\utility::func_46AE(), "kills"));
                setmatchdata("players", self.clientid, "start_deaths", self getrankedplayerdata(common_scripts\utility::func_46AE(), "deaths"));
                setmatchdata("players", self.clientid, "start_wins", self getrankedplayerdata(common_scripts\utility::func_46AE(), "wins"));
                setmatchdata("players", self.clientid, "start_losses", self getrankedplayerdata(common_scripts\utility::func_46AE(), "losses"));
                setmatchdata("players", self.clientid, "start_hits", self getrankedplayerdata(common_scripts\utility::func_46AE(), "hits"));
                setmatchdata("players", self.clientid, "start_misses", self getrankedplayerdata(common_scripts\utility::func_46AE(), "misses"));
                setmatchdata("players", self.clientid, "start_games_played", self getrankedplayerdata(common_scripts\utility::func_46AE(), "gamesPlayed"));
                setmatchdata("players", self.clientid, "start_time_played_total", self getrankedplayerdata(common_scripts\utility::func_46AE(), "timePlayedTotal"));
                setmatchdata("players", self.clientid, "start_score", self getrankedplayerdata(common_scripts\utility::func_46AE(), "score"));
                setmatchdata("players", self.clientid, "start_unlock_points", self getrankedplayerdata(common_scripts\utility::func_46AE(), "unlockPoints"));
                setmatchdata("players", self.clientid, "start_prestige", self getrankedplayerdata(common_scripts\utility::func_46AE(), "prestige"));
                setmatchdata("players", self.clientid, "start_gdf_rating", self getrankedplayerdata(common_scripts\utility::func_46AE(), "gdfRating"));
                setmatchdata("players", self.clientid, "start_gdf_variance", self getrankedplayerdata(common_scripts\utility::func_46AE(), "gdfVariance"));
                setmatchdata("players", self.clientid, "start_sos_rating", self getrankedplayerdata(common_scripts\utility::func_46AE(), "sosRating"));
                setmatchdata("players", self.clientid, "start_sos_weight", self getrankedplayerdata(common_scripts\utility::func_46AE(), "sosWeight"));
                setmatchdata("players", self.clientid, "start_division_xp", "infantry", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "infantry", "experience"));
                setmatchdata("players", self.clientid, "start_division_xp", "airborne", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "airborne", "experience"));
                setmatchdata("players", self.clientid, "start_division_xp", "armored", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "armored", "experience"));
                setmatchdata("players", self.clientid, "start_division_xp", "mountain", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "mountain", "experience"));
                setmatchdata("players", self.clientid, "start_division_xp", "expeditionary", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "expeditionary", "experience"));
                setmatchdata("players", self.clientid, "start_division_xp", "resistance", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "resistance", "experience"));
                setmatchdata("players", self.clientid, "start_division_xp", "grenadier", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "grenadier", "experience"));
                setmatchdata("players", self.clientid, "start_division_xp", "commando", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "commando", "experience"));
                setmatchdata("players", self.clientid, "start_division_xp", "scout", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "scout", "experience"));
                setmatchdata("players", self.clientid, "start_division_xp", "artillery", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "artillery", "experience"));
                setmatchdata("players", self.clientid, "start_division_level", "infantry", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "infantry", "level"));
                setmatchdata("players", self.clientid, "start_division_level", "airborne", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "airborne", "level"));
                setmatchdata("players", self.clientid, "start_division_level", "armored", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "armored", "level"));
                setmatchdata("players", self.clientid, "start_division_level", "mountain", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "mountain", "level"));
                setmatchdata("players", self.clientid, "start_division_level", "expeditionary", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "expeditionary", "level"));
                setmatchdata("players", self.clientid, "start_division_level", "resistance", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "resistance", "level"));
                setmatchdata("players", self.clientid, "start_division_level", "grenadier", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "grenadier", "level"));
                setmatchdata("players", self.clientid, "start_division_level", "commando", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "commando", "level"));
                setmatchdata("players", self.clientid, "start_division_level", "scout", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "scout", "level"));
                setmatchdata("players", self.clientid, "start_division_level", "artillery", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "artillery", "level"));
                setmatchdata("players", self.clientid, "start_division_prestige", "infantry", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "infantry", "prestigeLevel"));
                setmatchdata("players", self.clientid, "start_division_prestige", "airborne", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "airborne", "prestigeLevel"));
                setmatchdata("players", self.clientid, "start_division_prestige", "armored", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "armored", "prestigeLevel"));
                setmatchdata("players", self.clientid, "start_division_prestige", "mountain", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "mountain", "prestigeLevel"));
                setmatchdata("players", self.clientid, "start_division_prestige", "expeditionary", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "expeditionary", "prestigeLevel"));
                setmatchdata("players", self.clientid, "start_division_prestige", "resistance", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "resistance", "prestigeLevel"));
                setmatchdata("players", self.clientid, "start_division_prestige", "grenadier", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "grenadier", "prestigeLevel"));
                setmatchdata("players", self.clientid, "start_division_prestige", "commando", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "commando", "prestigeLevel"));
                setmatchdata("players", self.clientid, "start_division_prestige", "scout", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "scout", "prestigeLevel"));
                setmatchdata("players", self.clientid, "start_division_prestige", "artillery", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "artillery", "prestigeLevel"));
                var_01 = 12;
                var_02 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_play_current_season");
                if(var_02 >= 0 && var_02 < var_01) {
                  setmatchdata("players", self.clientid, "ranked_play_current_season", var_02);
                  setmatchdata("players", self.clientid, "start_mmr_current", self getrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_play_season_data", var_02, "mmr_current"));
                }
              }
            }

            func_5E92() {
              if(isDefined(level.iszombiegame) && level.iszombiegame) {
                return;
              }

              if(getdvarint("2506") > 0) {
                var_00 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "experience");
                setmatchdata("players", self.clientid, "end_xp", var_00);
                setmatchdata("players", self.clientid, "end_kills", self getrankedplayerdata(common_scripts\utility::func_46AE(), "kills"));
                setmatchdata("players", self.clientid, "end_deaths", self getrankedplayerdata(common_scripts\utility::func_46AE(), "deaths"));
                setmatchdata("players", self.clientid, "end_wins", self getrankedplayerdata(common_scripts\utility::func_46AE(), "wins"));
                setmatchdata("players", self.clientid, "end_losses", self getrankedplayerdata(common_scripts\utility::func_46AE(), "losses"));
                setmatchdata("players", self.clientid, "end_hits", self getrankedplayerdata(common_scripts\utility::func_46AE(), "hits"));
                setmatchdata("players", self.clientid, "end_misses", self getrankedplayerdata(common_scripts\utility::func_46AE(), "misses"));
                setmatchdata("players", self.clientid, "end_games_played", self getrankedplayerdata(common_scripts\utility::func_46AE(), "gamesPlayed"));
                setmatchdata("players", self.clientid, "end_time_played_total", self getrankedplayerdata(common_scripts\utility::func_46AE(), "timePlayedTotal"));
                setmatchdata("players", self.clientid, "end_score", self getrankedplayerdata(common_scripts\utility::func_46AE(), "score"));
                setmatchdata("players", self.clientid, "end_unlock_points", self getrankedplayerdata(common_scripts\utility::func_46AE(), "unlockPoints"));
                setmatchdata("players", self.clientid, "end_prestige", self getrankedplayerdata(common_scripts\utility::func_46AE(), "prestige"));
                setmatchdata("players", self.clientid, "end_gdf_rating", self getrankedplayerdata(common_scripts\utility::func_46AE(), "gdfRating"));
                setmatchdata("players", self.clientid, "end_gdf_variance", self getrankedplayerdata(common_scripts\utility::func_46AE(), "gdfVariance"));
                setmatchdata("players", self.clientid, "end_sos_rating", self getrankedplayerdata(common_scripts\utility::func_46AE(), "sosRating"));
                setmatchdata("players", self.clientid, "end_sos_weight", self getrankedplayerdata(common_scripts\utility::func_46AE(), "sosWeight"));
                setmatchdata("players", self.clientid, "end_division_xp", "infantry", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "infantry", "experience"));
                setmatchdata("players", self.clientid, "end_division_xp", "airborne", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "airborne", "experience"));
                setmatchdata("players", self.clientid, "end_division_xp", "armored", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "armored", "experience"));
                setmatchdata("players", self.clientid, "end_division_xp", "mountain", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "mountain", "experience"));
                setmatchdata("players", self.clientid, "end_division_xp", "expeditionary", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "expeditionary", "experience"));
                setmatchdata("players", self.clientid, "end_division_xp", "resistance", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "resistance", "experience"));
                setmatchdata("players", self.clientid, "end_division_xp", "grenadier", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "grenadier", "experience"));
                setmatchdata("players", self.clientid, "end_division_xp", "commando", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "commando", "experience"));
                setmatchdata("players", self.clientid, "end_division_xp", "scout", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "scout", "experience"));
                setmatchdata("players", self.clientid, "end_division_xp", "artillery", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "artillery", "experience"));
                setmatchdata("players", self.clientid, "end_division_level", "infantry", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "infantry", "level"));
                setmatchdata("players", self.clientid, "end_division_level", "airborne", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "airborne", "level"));
                setmatchdata("players", self.clientid, "end_division_level", "armored", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "armored", "level"));
                setmatchdata("players", self.clientid, "end_division_level", "mountain", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "mountain", "level"));
                setmatchdata("players", self.clientid, "end_division_level", "expeditionary", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "expeditionary", "level"));
                setmatchdata("players", self.clientid, "end_division_level", "resistance", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "resistance", "level"));
                setmatchdata("players", self.clientid, "end_division_level", "grenadier", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "grenadier", "level"));
                setmatchdata("players", self.clientid, "end_division_level", "commando", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "commando", "level"));
                setmatchdata("players", self.clientid, "end_division_level", "scout", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "scout", "level"));
                setmatchdata("players", self.clientid, "end_division_level", "artillery", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "artillery", "level"));
                setmatchdata("players", self.clientid, "end_division_prestige", "infantry", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "infantry", "prestigeLevel"));
                setmatchdata("players", self.clientid, "end_division_prestige", "airborne", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "airborne", "prestigeLevel"));
                setmatchdata("players", self.clientid, "end_division_prestige", "armored", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "armored", "prestigeLevel"));
                setmatchdata("players", self.clientid, "end_division_prestige", "mountain", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "mountain", "prestigeLevel"));
                setmatchdata("players", self.clientid, "end_division_prestige", "expeditionary", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "expeditionary", "prestigeLevel"));
                setmatchdata("players", self.clientid, "end_division_prestige", "resistance", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "resistance", "prestigeLevel"));
                setmatchdata("players", self.clientid, "end_division_prestige", "grenadier", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "grenadier", "prestigeLevel"));
                setmatchdata("players", self.clientid, "end_division_prestige", "commando", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "commando", "prestigeLevel"));
                setmatchdata("players", self.clientid, "end_division_prestige", "scout", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "scout", "prestigeLevel"));
                setmatchdata("players", self.clientid, "end_division_prestige", "artillery", self getrankedplayerdata(common_scripts\utility::func_46AE(), "divisionStats", "artillery", "prestigeLevel"));
                var_01 = 12;
                var_02 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_play_current_season");
                if(var_02 >= 0 && var_02 < var_01) {
                  setmatchdata("players", self.clientid, "end_mmr_min", self getrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_play_season_data", var_02, "mmr_min"));
                  setmatchdata("players", self.clientid, "end_mmr_max", self getrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_play_season_data", var_02, "mmr_max"));
                  setmatchdata("players", self.clientid, "end_mmr_current", self getrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_play_season_data", var_02, "mmr_current"));
                  setmatchdata("players", self.clientid, "end_weight_current", self getrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_play_season_data", var_02, "weight_current"));
                  setmatchdata("players", self.clientid, "end_ranked_games_completed", self getrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_play_season_data", var_02, "ranked_games_completed"));
                  setmatchdata("players", self.clientid, "end_ranked_games_abandoned", self getrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_play_season_data", var_02, "ranked_games_abandoned"));
                }

                if(isDefined(self.pers["rank"])) {
                  var_03 = maps\mp\_utility::func_2314(maps\mp\gametypes\_rank::getrank());
                  setmatchdata("players", self.clientid, "end_rank", var_03);
                }
              }
            }

            func_7B2D() {
              for(;;) {
                if(getdvarint("3833") == 0) {
                  foreach(var_01 in level.players) {
                    var_02 = 0;
                    if(maps\mp\_utility::func_57A0(var_01)) {
                      var_02 = 1;
                    }

                    if(function_026D(var_01)) {
                      continue;
                    }

                    if(!isDefined(var_01.origin)) {
                      continue;
                    }

                    if(isDefined(var_01.sessionstate) && var_01.sessionstate == "spectator") {
                      continue;
                    }

                    var_03 = "disconnected?";
                    if(isDefined(var_01.name)) {
                      var_03 = var_01.name;
                    }

                    var_04 = -1;
                    if(isDefined(var_01.var_2418)) {
                      var_04 = var_01.var_2418;
                    }

                    var_05 = (-999, -999, -999);
                    if(isDefined(var_01.angles)) {
                      var_05 = var_01.angles;
                    }

                    var_06 = "undefined";
                    if(isDefined(var_01.team)) {
                      var_06 = var_01.team;
                    }

                    var_07 = gettime();
                    if(common_scripts\utility::func_562E(level.iszombiegame)) {
                      var_08 = common_scripts\utility::func_98E7(isDefined(level.var_A980), level.var_A980, 0);
                      var_09 = common_scripts\utility::func_562E(var_01.laststand);
                      var_0A = common_scripts\utility::func_98E7(isDefined(var_01.var_20D8), var_01.var_20D8, 0);
                      var_0B = ["Jefferson", "Drostan", "Marie", "Olivia", "Hunter", "Mountaineer", "Urban Survivalist", "B.A.T. Agent", "B.A.T. Elite", "Assassin"][var_0A];
                      if(!isDefined(var_0B)) {
                        var_0B = "";
                      }

                      function_00F6(var_01.origin, "script_zombie_playerpos: player %s,angles %v, game_time_ms %d,playerTeam %s,characterIndex %d, characterName %s, is_alive %b, is_last_stand %b, zombies_wave %d", var_03, var_05, var_07, var_06, var_0A, var_0B, var_02, var_09, var_08);
                      continue;
                    }

                    function_00F6(var_01.origin, "script_mp_playerpos: player_name %s, angles %v, gameTime %d, playerTeam %s, is_alive %b", var_03, var_05, var_07, var_06, var_02);
                  }
                }

                wait(0.2);
              }
            }

            func_5EAE() {
              if(level.iszombiegame) {
                return;
              }

              level endon("game_ended");
              while(isDefined(game["roundsPlayed"]) && game["roundsPlayed"] < level.var_609D) {
                var_00 = getmatchtimepassed();
                setmatchdata("rounds", game["roundsPlayed"], "start_time_ms", var_00);
                setmatchdata("rounds", game["roundsPlayed"], "is_overtime", maps\mp\_utility::func_5380());
                if(function_03BC()) {
                  level.players[0] dlogevent("dtel_round_start", ["round_start", ["time_ms", var_00, "axis_score", getteamscore("axis"), "allies_score", getteamscore("allies"), "is_overtime", maps\mp\_utility::func_5380()]]);
                }

                level waittill("round_switch", var_01);
              }
            }

            func_5E91(param_00, param_01, param_02) {
              if(level.iszombiegame) {
                return;
              }

              var_03 = getmatchtimepassed();
              if(param_00 < level.var_609D) {
                setmatchdata("rounds", param_00, "end_time_ms", var_03);
                setmatchdata("rounds", param_00, "axis_score", param_01);
                setmatchdata("rounds", param_00, "allies_score", param_02);
              }

              setmatchdata("allies_score", param_02);
              setmatchdata("axis_score", param_01);
              if(function_03BC()) {
                level.players[0] dlogevent("dtel_round_end", ["round_end", ["time_ms", var_03, "axis_score", param_01, "allies_score", param_02, "is_overtime", maps\mp\_utility::func_5380()]]);
              }
            }