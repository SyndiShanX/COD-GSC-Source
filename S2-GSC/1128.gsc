/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1128.gsc
*********************************************/

lib_0468::func_0A23(param_00, param_01, param_02, param_03) {
  if(!maps\mp\_utility::func_7A69() || function_0367()) {
    return 0;
  }

  var_04 = [];
  if(!isDefined(param_03)) {
    param_03 = [];
  }

  var_05 = 0;
  if(isDefined(self.var_5B93) && gettime() - self.var_5B93 < 2000) {
    var_04[var_04.size] = 5;
    var_04[var_04.size] = 1;
  }

  if(param_00 common_scripts\utility::func_56F4() || param_00 common_scripts\utility::func_56B5() || param_00 common_scripts\utility::func_56F2() || param_00 common_scripts\utility::func_5701()) {
    var_04[var_04.size] = 8;
    var_04[var_04.size] = 1;
    var_05 = 1;
  }

  if(param_02 == "MOD_HEAD_SHOT") {
    var_04[var_04.size] = 6;
    var_04[var_04.size] = 1;
  }

  var_06 = param_00 getstance();
  if(var_06 == "crouch") {
    param_03[param_03.size] = "enemyCrouched";
  } else if(var_06 == "prone") {
    param_03[param_03.size] = "enemyProne";
  }

  var_07 = self getstance();
  if(var_07 == "crouch") {
    param_03[param_03.size] = "playerCrouched";
  } else if(var_07 == "prone") {
    param_03[param_03.size] = "playerProne";
  }

  switch (maps\mp\_utility::func_472A(param_01)) {
    case "weapon_assault":
      var_04[var_04.size] = 1;
      var_04[var_04.size] = 1;
      break;

    case "weapon_smg":
      var_04[var_04.size] = 1;
      var_04[var_04.size] = 2;
      break;

    case "weapon_heavy":
      var_04[var_04.size] = 1;
      var_04[var_04.size] = 3;
      break;

    case "weapon_shotgun":
      var_04[var_04.size] = 1;
      var_04[var_04.size] = 4;
      break;

    case "weapon_sniper":
      var_04[var_04.size] = 1;
      var_04[var_04.size] = 5;
      break;

    case "weapon_pistol":
      var_04[var_04.size] = 1;
      var_04[var_04.size] = 6;
      break;

    case "weapon_projectile":
      var_04[var_04.size] = 1;
      var_04[var_04.size] = 7;
      break;

    case "weapon_grenade":
      var_04[var_04.size] = 1;
      var_04[var_04.size] = 8;
      if(isDefined(self.stuckenemy) && self.stuckenemy > 0) {
        param_03[param_03.size] = "stuck";
        self.stuckenemy--;
        if(self.stuckenemy < 0) {
          self.stuckenemy = 0;
        }
      }

      var_08 = self method_831F();
      if(!var_05 && isDefined(var_08) && var_08 == param_01) {
        var_04[var_04.size] = 8;
        var_04[var_04.size] = 1;
      }

      if(param_01 == "throwingknife_mp") {
        param_03[param_03.size] = "throwingKnifeKill";
      }
      break;

    case "killstreak":
      var_04[var_04.size] = 1;
      var_04[var_04.size] = 11;
      break;

    case "weapon_other":
      if(issubstr(param_01, "shovel")) {
        var_04[var_04.size] = 1;
        var_04[var_04.size] = 10;
      }

      if(issubstr(param_01, "riotshield")) {
        var_04[var_04.size] = 1;
        var_04[var_04.size] = 15;
      }
      break;

    case "other":
      if(issubstr(param_01, "turret_mg42")) {
        var_04[var_04.size] = 1;
        var_04[var_04.size] = 12;
      } else if(maps\mp\_events::func_43D6(param_01) == "raids_tank_turret_kill") {
        var_04[var_04.size] = 1;
        var_04[var_04.size] = 13;
      } else if(issubstr(param_01, "relic")) {
        var_04[var_04.size] = 1;
        var_04[var_04.size] = 14;
      }
      break;
  }

  var_04 = checkgamemode(var_04, 2);
  var_04 = checkspecialmodes(var_04);
  if(maps\mp\_utility::areexperimentalbasictrainingsenabled()) {
    if(hasthrowbacktrainingequipped()) {
      param_03[param_03.size] = "throwbackEquipped";
    }
  }

  if(maps\mp\_utility::func_0649("specialty_class_wanderlust")) {
    param_03[param_03.size] = "wanderlustEquipped";
  }

  var_09 = 0;
  var_0A = maps\mp\gametypes\_division_change::func_4499("kill", self, param_00, param_01, param_02);
  if(issubstr(var_0A, "division")) {
    if(issubstr(var_0A, "infantry")) {
      var_09 = var_09 | 2;
      param_03[param_03.size] = "divisionSkillKill";
    } else if(issubstr(var_0A, "airborne")) {
      var_09 = var_09 | 4;
      param_03[param_03.size] = "divisionSkillKill";
    } else if(issubstr(var_0A, "armored")) {
      var_09 = var_09 | 8;
      param_03[param_03.size] = "divisionSkillKill";
    } else if(issubstr(var_0A, "mountain")) {
      var_09 = var_09 | 16;
      param_03[param_03.size] = "divisionSkillKill";
    } else if(issubstr(var_0A, "cavalry")) {
      var_09 = var_09 | 32;
      param_03[param_03.size] = "divisionSkillKill";
    } else if(issubstr(var_0A, "resistance")) {
      var_09 = var_09 | 2048;
      param_03[param_03.size] = "divisionSkillKill";
    }
  }

  if(isDefined(self.var_0079)) {
    switch (self.var_0079) {
      case 0:
        var_09 = var_09 | 64;
        if(maps\mp\_utility::func_472A(param_01) != "weapon_assault") {
          param_03[param_03.size] = "infantry_no_rifle";
        }
        break;

      case 1:
        var_09 = var_09 | 128;
        if(maps\mp\_utility::func_472A(param_01) != "weapon_smg") {
          param_03[param_03.size] = "airborne_no_smg";
        }
        break;

      case 2:
        var_09 = var_09 | 256;
        if(maps\mp\_utility::func_472A(param_01) != "weapon_heavy") {
          param_03[param_03.size] = "armored_no_lmg";
        }
        break;

      case 3:
        var_09 = var_09 | 512;
        if(maps\mp\_utility::func_472A(param_01) != "weapon_sniper") {
          param_03[param_03.size] = "mountain_no_sniper";
        }
        break;

      case 4:
        var_09 = var_09 | 1024;
        if(maps\mp\_utility::func_472A(param_01) != "weapon_shotgun") {
          param_03[param_03.size] = "expeditionary_no_shotgun";
        }
        break;

      case 6:
        var_09 = var_09 | 4096;
        if(maps\mp\_utility::func_472A(param_01) != "weapon_pistol") {
          param_03[param_03.size] = "resistance_no_pistol";
        }
        break;

      case 7:
        var_09 = var_09 | 16384;
        if(maps\mp\_utility::func_472A(param_01) != "weapon_assault") {
          param_03[param_03.size] = "grenadier_no_rifle";
        }
        break;

      case 8:
        var_09 = var_09 | 65536;
        if(maps\mp\_utility::func_472A(param_01) != "weapon_smg") {
          param_03[param_03.size] = "commando_no_smg";
        }
        break;

      case 9:
        var_09 = var_09 | 262144;
        if(maps\mp\_utility::func_472A(param_01) != "weapon_sniper") {
          param_03[param_03.size] = "scout_no_sniper";
        }
        break;

      case 10:
        var_09 = var_09 | 1048576;
        if(maps\mp\_utility::func_472A(param_01) != "weapon_assault") {
          param_03[param_03.size] = "artillery_no_rifle";
        }
        break;
    }
  }

  var_04[var_04.size] = 130;
  var_04[var_04.size] = var_09;
  if(isDefined(param_00.var_0079)) {
    switch (param_00.var_0079) {
      case 7:
        param_03[param_03.size] = "killed_cavalry";
        break;
    }
  }

  if(isDefined(param_02) && maps\mp\_utility::func_5697(param_02, param_01)) {
    var_04[var_04.size] = 3;
    var_04[var_04.size] = 1;
  } else if(isDefined(param_02) && maps\mp\_utility::func_56E5(param_02)) {
    var_04[var_04.size] = 3;
    var_04[var_04.size] = 3;
  } else if(isDefined(param_00.var_5033) && param_00.var_5033 &level.var_503B) {
    var_04[var_04.size] = 3;
    var_04[var_04.size] = 4;
  } else if(isDefined(param_02) && param_02 == "MOD_MELEE") {
    var_04[var_04.size] = 3;
    var_04[var_04.size] = 2;
  }

  if(isDefined(self.lastweaponswaptime) && gettime() - self.lastweaponswaptime < 5000) {
    param_03[param_03.size] = "switchWeaponKill";
  }

  var_0B = tolower(getDvar("1673"));
  if(var_0B == "mp_canon_farm" || var_0B == "mp_forest_01" || var_0B == "mp_carentan_s2_winter" || var_0B == "mp_raid_bulge") {
    param_03[param_03.size] = "winter_map_kill";
  }

  if(self.var_01A7 != param_00.var_01A7 && isDefined(param_00.var_2013)) {
    param_03[param_03.size] = "flag_carrier_kill";
  }

  if(level.var_3FDC == "hp" && isDefined(level.var_AC7C.var_9D5E) && self istouching(level.var_AC7C.var_9D5E)) {
    param_03[param_03.size] = "kill_on_hp";
  }

  if(level.var_3FDC == "relic" && isDefined(self.relicpasskill)) {
    param_03[param_03.size] = "skulduggery";
    self.relicpasskill = undefined;
  }

  if(level.var_3FDC == "infect") {
    if(self.var_01A7 == "axis") {
      param_03[param_03.size] = "survivor_killed";
    } else if(self.var_01A7 == "allies") {
      param_03[param_03.size] = "infected_killed";
    }
  }

  if(!maps\mp\_utility::func_5740(param_01) && maps\mp\_utility::func_5695(param_02) && !maps\mp\_utility::isdogfightgametype()) {
    if(isDefined(self.var_3BE0)) {
      var_0C = self.var_3BE0;
    } else {
      var_0C = self playerads();
    }

    if(var_0C >= 0.2) {
      param_03[param_03.size] = "adsKill";
    } else {
      param_03[param_03.size] = "hipfireKill";
    }
  }

  if(isDefined(var_04) && var_04.size > 0) {
    var_0D = 0;
    var_0E = 0;
    foreach(var_10 in var_04) {
      if(var_10 == "flag_carrier_kill") {
        var_0E = var_0E | 2;
        continue;
      }

      if(var_10 == "kill_on_hp") {
        var_0D = var_0D | 4;
        continue;
      }

      if(var_10 == "longshot") {
        var_0D = var_0D | 8;
        continue;
      }

      if(var_10 == "kingslayer") {
        var_0E = var_0E | 4;
        continue;
      }

      if(var_10 == "enemyCrouched") {
        var_0E = var_0E | 8;
        continue;
      }

      if(var_10 == "enemyProne") {
        var_0E = var_0E | 16;
        continue;
      }

      if(var_10 == "playerCrouched") {
        var_0D = var_0D | 8192;
        continue;
      }

      if(var_10 == "playerProne") {
        var_0D = var_0D | 16384;
        continue;
      }

      if(var_10 == "throwback") {
        var_0D = var_0D | 2;
        continue;
      }

      if(var_10 == "payback") {
        var_0D = var_0D | 16;
        continue;
      }

      if(var_10 == "backfire") {
        var_0D = var_0D | 32;
        continue;
      }

      if(var_10 == "stuck") {
        var_0D = var_0D | 64;
        continue;
      }

      if(var_10 == "infantry_no_rifle") {
        var_0D = var_0D | 128;
        continue;
      }

      if(var_10 == "airborne_no_smg") {
        var_0D = var_0D | 256;
        continue;
      }

      if(var_10 == "armored_no_lmg") {
        var_0D = var_0D | 512;
        continue;
      }

      if(var_10 == "mountain_no_sniper") {
        var_0D = var_0D | 1024;
        continue;
      }

      if(var_10 == "expeditionary_no_shotgun") {
        var_0D = var_0D | 2048;
        continue;
      }

      if(var_10 == "resistance_no_pistol") {
        var_0D = var_0D | -32768;
        continue;
      }

      if(var_10 == "grenadier_no_rifle") {
        var_0D = var_0D | 65536;
        continue;
      }

      if(var_10 == "commando_no_smg") {
        var_0D = var_0D | 131072;
        continue;
      }

      if(var_10 == "scout_no_sniper") {
        var_0D = var_0D | 262144;
        continue;
      }

      if(var_10 == "artillery_no_rifle") {
        var_0D = var_0D | 524288;
        continue;
      }

      if(var_10 == "winter_map_kill") {
        var_0D = var_0D | 4096;
        continue;
      }

      if(var_10 == "throwbackEquipped") {
        var_0D = var_0D | 1048576;
        continue;
      }

      if(var_10 == "divisionSkillKill") {
        var_0D = var_0D | 2097152;
        continue;
      }

      if(var_10 == "switchWeaponKill") {
        var_0D = var_0D | 4194304;
        continue;
      }

      if(var_10 == "throwingKnifeKill") {
        var_0D = var_0D | 8388608;
        continue;
      }

      if(var_10 == "adsKill") {
        var_0D = var_0D | 16777216;
        continue;
      }

      if(var_10 == "hipfireKill") {
        var_0D = var_0D | 33554432;
        continue;
      }

      if(var_10 == "skulduggery") {
        var_0E = var_0E | 32;
        continue;
      }

      if(var_10 == "survivor_killed") {
        var_0E = var_0E | 64;
        continue;
      }

      if(var_10 == "infected_killed") {
        var_0E = var_0E | 128;
        continue;
      }

      if(var_10 == "killed_cavalry") {
        var_0E = var_0E | 256;
        continue;
      }

      if(var_10 == "wanderlustEquipped") {
        var_0D = var_0D | 67108864;
        continue;
      }

      if(var_10 == "dediMelee") {
        var_0D = var_0D | 134217728;
        continue;
      }
    }

    if(var_0D > 0) {
      var_05[var_05.size] = 128;
      var_05[var_05.size] = var_0D;
    }

    if(var_0E > 0) {
      var_05[var_05.size] = 129;
      var_05[var_05.size] = var_0E;
    }
  }

  if(var_05.size > 0) {
    self ae_reportcomplexgameevent(1, var_05);
  }
}

lib_0468::func_0A24(param_00, param_01) {
  if(!maps\mp\_utility::func_7A69() || function_0367()) {
    return 0;
  }

  var_02 = [];
  switch (maps\mp\_utility::func_472A(param_00)) {
    case "weapon_grenade":
      var_02[var_02.size] = 1;
      var_02[var_02.size] = 1;
      if(isDefined(param_01) && param_01 != "doublekill" && maps\mp\_utility::func_579B()) {
        lib_0468::func_0A22("warTripleNade");
      }
      break;

    case "weapon_pistol":
      var_02[var_02.size] = 1;
      var_02[var_02.size] = 2;
      break;

    case "weapon_shotgun":
      var_02[var_02.size] = 1;
      var_02[var_02.size] = 3;
      break;

    case "weapon_assault":
      var_02[var_02.size] = 1;
      var_02[var_02.size] = 4;
      break;

    case "weapon_smg":
      var_02[var_02.size] = 1;
      var_02[var_02.size] = 5;
      break;

    case "weapon_heavy":
      var_02[var_02.size] = 1;
      var_02[var_02.size] = 6;
      break;

    case "weapon_sniper":
      var_02[var_02.size] = 1;
      var_02[var_02.size] = 7;
      break;
  }

  var_02[var_02.size] = 2;
  var_02[var_02.size] = 1;
  var_02 = checkgamemode(var_02, 3);
  var_02 = checkspecialmodes(var_02);
  if(level.var_3FDC == "dom" && isDefined(self.var_9AC5)) {
    foreach(var_04 in self.var_9AC5) {
      var_05 = 0;
      foreach(var_07 in level.var_3CC5) {
        if(var_04 == var_07) {
          var_05 = 1;
          break;
        }
      }

      if(!var_05) {
        continue;
      }

      lib_0468::func_0A22("multikillOnDomPt");
      break;
    }
  }

  if(var_02.size > 0) {
    self ae_reportcomplexgameevent(2, var_02);
  }
}

lib_0468::func_0A22(param_00) {
  if(!maps\mp\_utility::func_7A69() || function_0367()) {
    return 0;
  }

  var_01 = [];
  switch (param_00) {
    case "tdm25kills":
      var_01[var_01.size] = 1;
      var_01[var_01.size] = 1;
      break;

    case "domCap":
      var_01[var_01.size] = 3;
      var_01[var_01.size] = 1;
      break;

    case "domCap6":
      var_01[var_01.size] = 3;
      var_01[var_01.size] = 3;
      break;

    case "multikillOnDomPt":
      var_01[var_01.size] = 3;
      var_01[var_01.size] = 2;
      break;

    case "enemyTag":
      var_01[var_01.size] = 2;
      var_01[var_01.size] = 1;
      break;

    case "friendlyTag":
      var_01[var_01.size] = 2;
      var_01[var_01.size] = 2;
      break;

    case "warConstruct":
      var_01[var_01.size] = 4;
      var_01[var_01.size] = 1;
      break;

    case "warKills45":
      var_01[var_01.size] = 4;
      var_01[var_01.size] = 2;
      break;

    case "warTripleNade":
      var_01[var_01.size] = 4;
      var_01[var_01.size] = 3;
      break;

    case "ctfCapFlag":
      var_01[var_01.size] = 5;
      var_01[var_01.size] = 1;
      break;

    case "3KillsFlagCarrier":
      var_01[var_01.size] = 5;
      var_01[var_01.size] = 2;
      break;

    case "touchdown":
      var_01[var_01.size] = 6;
      var_01[var_01.size] = 1;
      break;

    case "sdKiller":
      var_01[var_01.size] = 7;
      var_01[var_01.size] = 1;
      break;

    case "sdPlant":
      var_01[var_01.size] = 7;
      var_01[var_01.size] = 2;
      break;

    case "5KillsOnHp":
      var_01[var_01.size] = 8;
      var_01[var_01.size] = 1;
      break;

    case "demoBombPlanted":
      var_01[var_01.size] = 9;
      var_01[var_01.size] = 1;
      break;

    case "demoBombDefused":
      var_01[var_01.size] = 9;
      var_01[var_01.size] = 2;
      break;

    case "propRoundSurvivor":
      var_01[var_01.size] = 10;
      var_01[var_01.size] = 1;
      break;

    case "propChangelessSurvivor":
      var_01[var_01.size] = 10;
      var_01[var_01.size] = 2;
      break;

    case "lepKill":
      var_01[var_01.size] = 11;
      var_01[var_01.size] = 1;
      break;

    case "hailMary":
      var_01[var_01.size] = 11;
      var_01[var_01.size] = 2;
      break;

    case "soulCap":
      var_01[var_01.size] = 13;
      var_01[var_01.size] = 1;
      break;

    case "hordepoint1Min":
      var_01[var_01.size] = 14;
      var_01[var_01.size] = 1;
      break;

    case "shieldDeflect5":
      var_01[var_01.size] = 11;
      var_01[var_01.size] = 3;
      break;
  }

  var_02 = 0;
  if(isDefined(self.var_0079)) {
    switch (self.var_0079) {
      case 0:
        var_02 = var_02 | 64;
        break;

      case 1:
        var_02 = var_02 | 128;
        break;

      case 2:
        var_02 = var_02 | 256;
        break;

      case 3:
        var_02 = var_02 | 512;
        break;

      case 4:
        var_02 = var_02 | 1024;
        break;

      case 6:
        var_02 = var_02 | 4096;
        break;

      case 7:
        var_02 = var_02 | 16384;
        break;

      case 8:
        var_02 = var_02 | 65536;
        break;

      case 9:
        var_02 = var_02 | 262144;
        break;

      case 10:
        var_02 = var_02 | 1048576;
        break;
    }

    var_01[var_01.size] = 130;
    var_01[var_01.size] = var_02;
  }

  if(var_01.size > 0) {
    self ae_reportcomplexgameevent(3, var_01);
  }
}

lib_0468::func_0A28(param_00) {
  if(!maps\mp\_utility::func_7A69() || function_0367()) {
    return 0;
  }

  var_01 = [];
  switch (param_00) {
    case "kill":
      var_01[var_01.size] = 1;
      var_01[var_01.size] = 1;
      break;

    case "scorestreak3":
      var_01[var_01.size] = 2;
      var_01[var_01.size] = 1;
      break;

    case "destroy":
      var_01[var_01.size] = 2;
      var_01[var_01.size] = 3;
      break;

    case "scorestreakUsed":
      var_01[var_01.size] = 2;
      var_01[var_01.size] = 2;
      break;

    case "sharepackage":
      var_01[var_01.size] = 2;
      var_01[var_01.size] = 4;
      break;

    case "packageUsed":
      var_01[var_01.size] = 2;
      var_01[var_01.size] = 5;
      break;

    case "packageCapped":
      var_01[var_01.size] = 2;
      var_01[var_01.size] = 7;
      break;

    case "throwbackStreakEarned":
      if(hasthrowbacktrainingequipped()) {
        var_01[var_01.size] = 2;
        var_01[var_01.size] = 6;
      }
      break;
  }

  var_02 = 0;
  if(isDefined(self.var_0079)) {
    switch (self.var_0079) {
      case 0:
        var_02 = var_02 | 64;
        break;

      case 1:
        var_02 = var_02 | 128;
        break;

      case 2:
        var_02 = var_02 | 256;
        break;

      case 3:
        var_02 = var_02 | 512;
        break;

      case 4:
        var_02 = var_02 | 1024;
        break;

      case 6:
        var_02 = var_02 | 4096;
        break;

      case 7:
        var_02 = var_02 | 16384;
        break;

      case 8:
        var_02 = var_02 | 65536;
        break;

      case 9:
        var_02 = var_02 | 262144;
        break;

      case 10:
        var_02 = var_02 | 1048576;
        break;
    }

    var_01[var_01.size] = 130;
    var_01[var_01.size] = var_02;
  }

  var_01 = checkgamemode(var_01, 3);
  var_01 = checkspecialmodes(var_01);
  if(var_01.size > 0) {
    self ae_reportcomplexgameevent(4, var_01);
  }
}

lib_0468::func_0A1E(param_00, param_01, param_02, param_03) {
  if(!maps\mp\_utility::func_7A69() || function_0367()) {
    return 0;
  }

  var_04 = [];
  var_04[var_04.size] = 1;
  var_04[var_04.size] = 1;
  var_04 = checkgamemode(var_04, 2);
  var_04 = checkspecialmodes(var_04);
  if(param_02 == "conf" || param_02 == "dom" || param_02 == "hp" || param_02 == "raid" || param_02 == "ctf" || param_02 == "sd" || param_02 == "ball") {
    var_04[var_04.size] = 10;
    var_04[var_04.size] = 1;
  }

  if(param_01 <= 0) {
    param_01 = 1;
  }

  var_05 = param_00 / param_01;
  var_04[var_04.size] = 4;
  var_04[var_04.size] = int(var_05);
  var_04[var_04.size] = 3;
  if(isPlayer(param_03)) {
    var_06 = maps\mp\gametypes\_gamescore::func_450B(3);
    var_07 = 2;
    if(level.var_744A.size > 5) {
      foreach(var_09 in var_06) {
        if(self.var_2418 == var_09.var_2418) {
          var_07 = 1;
        }
      }
    } else if(param_03 == self) {
      var_07 = 1;
    }
  } else if(isDefined(var_05)) {
    if(isDefined(self.var_01A7) && var_05 == self.var_01A7) {
      var_07 = 1;
    } else if(var_05 == "tie" || var_05 == "overtime") {
      var_07 = 3;
    } else {
      var_07 = 2;
    }
  } else {
    var_07 = 2;
  }

  var_05[var_05.size] = var_06;
  var_05[var_05.size] = 8;
  var_05[var_05.size] = self.var_012C["score"];
  if(self getentitynumber() == level.var_74CA) {
    var_05[var_05.size] = 5;
    var_05[var_05.size] = 1;
  }

  var_0B = 1;
  foreach(var_0D in level.var_744A) {
    if(self.var_015C < var_0D.var_015C) {
      var_0B++;
    }
  }

  var_05[var_05.size] = 6;
  var_05[var_05.size] = var_0B;
  var_05[var_05.size] = 7;
  if(function_03AF()) {
    var_0F = function_03B5();
    var_10 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_play_season_data", var_0F, "ranked_games_total");
    var_11 = !self getrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_play_season_data", var_0F, "mmr_was_adjusted");
    if(!var_11 || var_10 >= getdvarint("4697", 10)) {
      var_05[var_05.size] = 3;
    } else {
      var_05[var_05.size] = 2;
    }
  } else {
    var_0B[var_0B.size] = 1;
  }

  if(var_0B.size > 0) {
    self ae_reportcomplexgameevent(5, var_0B);
  }
}

lib_0468::func_0A21(param_00) {
  self ae_reportcomplexgameevent(6, [1, 1, 2, param_00]);
}

lib_0468::func_0A1C(param_00, param_01, param_02) {
  var_03 = [];
  switch (param_00) {
    case "win":
      var_03[var_03.size] = 1;
      var_03[var_03.size] = 1;
      break;

    case "lose":
      var_03[var_03.size] = 1;
      var_03[var_03.size] = 2;
      break;

    case "tie":
      var_03[var_03.size] = 1;
      var_03[var_03.size] = 3;
      break;
  }

  if(isDefined(param_02) && param_02) {
    var_03[var_03.size] = 2;
    var_03[var_03.size] = 1;
  }

  if(var_03.size > 0) {
    if(isDefined(param_01)) {
      self ae_reportcomplexgameevent(7, var_03, param_01);
      return;
    }

    self ae_reportcomplexgameevent(7, var_03);
  }
}

lib_0468::func_0A20(param_00) {
  var_01 = [];
  switch (param_00) {
    case "completedSequence":
      var_01[var_01.size] = 1;
      var_01[var_01.size] = 1;
      break;

    case "grenadeTire":
      var_01[var_01.size] = 2;
      var_01[var_01.size] = 1;
      break;

    case "targetHit":
      var_01[var_01.size] = 2;
      var_01[var_01.size] = 2;
      break;
  }

  if(var_01.size > 0) {
    self ae_reportcomplexgameevent(8, var_01);
  }
}

lib_0468::func_0A26(param_00, param_01) {
  var_02 = [];
  var_02[var_02.size] = 1;
  switch (param_00) {
    case "win":
      var_02[var_02.size] = 1;
      break;

    case "lose":
      var_02[var_02.size] = 2;
      break;

    case "tie":
      var_02[var_02.size] = 3;
      break;
  }

  if(var_02.size > 0) {
    if(isDefined(param_01)) {
      self ae_reportcomplexgameevent(9, var_02, param_01);
      return;
    }

    self ae_reportcomplexgameevent(9, var_02);
  }
}

lib_0468::func_0A27(param_00) {
  var_01 = [];
  switch (param_00) {
    case "passBall":
      var_01[var_01.size] = 2;
      var_01[var_01.size] = 1;
      break;

    case "timerTagWin":
      var_01[var_01.size] = 3;
      var_01[var_01.size] = 1;
      break;

    case "timerTagLose":
      var_01[var_01.size] = 3;
      var_01[var_01.size] = 2;
      break;
  }

  if(var_01.size > 0) {
    self ae_reportcomplexgameevent(10, var_01);
  }
}

lib_0468::func_0A2A(param_00, param_01, param_02) {
  var_03 = [];
  switch (param_00) {
    case "theater":
      var_03[var_03.size] = 1;
      var_03[var_03.size] = 1;
      break;

    case "general":
      var_03[var_03.size] = 2;
      var_03[var_03.size] = param_01;
      break;

    case "division_prestige":
      var_03[var_03.size] = 3;
      var_03[var_03.size] = param_01;
      var_03[var_03.size] = 1;
      switch (param_02) {
        case "infantry":
          var_03[var_03.size] = 1;
          break;

        case "airborne":
          var_03[var_03.size] = 2;
          break;

        case "armored":
          var_03[var_03.size] = 3;
          break;

        case "mountain":
          var_03[var_03.size] = 4;
          break;

        case "expeditionary":
          var_03[var_03.size] = 5;
          break;

        case "resistance":
          var_03[var_03.size] = 11;
          break;

        case "grenadier":
          var_03[var_03.size] = 13;
          break;

        case "commando":
          var_03[var_03.size] = 15;
          break;

        case "scout":
          var_03[var_03.size] = 17;
          break;

        case "artillery":
          var_03[var_03.size] = 19;
          break;
      }
      break;

    case "zombie":
      var_03[var_03.size] = 5;
      var_03[var_03.size] = param_01;
      break;

    case "streakTraining":
      var_03[var_03.size] = 6;
      var_03[var_03.size] = 1;
      break;
  }

  if(var_03.size > 0) {
    self ae_reportcomplexgameevent(11, var_03);
  }
}

lib_0468::func_0A29(param_00, param_01, param_02) {
  var_03 = [];
  switch (param_00) {
    case "openSD":
      var_03[var_03.size] = 1;
      var_03[var_03.size] = 1;
      var_03[var_03.size] = 2;
      var_03[var_03.size] = param_01;
      break;

    case "watchSD":
      var_03[var_03.size] = 1;
      var_03[var_03.size] = 2;
      var_03[var_03.size] = 3;
      var_03[var_03.size] = param_02;
      break;
  }

  if(var_03.size > 0) {
    self ae_reportcomplexgameevent(12, var_03);
  }
}

lib_0468::func_0A1F() {
  self ae_reportcomplexgameevent(13, [1, 1]);
}

lib_0468::func_0A25(param_00, param_01) {
  if(param_01 == "mp") {
    self ae_reportcomplexgameevent(14, [2, 1, 1, param_00]);
    return;
  }

  if(param_01 == "zm") {
    self ae_reportcomplexgameevent(14, [2, 2, 1, param_00]);
  }
}

ae_sendmasterprestigerankevent(param_00, param_01) {
  if(param_01 == "mp") {
    self ae_reportcomplexgameevent(14, [2, 1, 1, param_00, 3, 1]);
    return;
  }

  if(param_01 == "zm") {
    return;
  }
}

lib_0468::func_0A1D(param_00, param_01) {
  var_02 = [];
  var_02[var_02.size] = 1;
  switch (param_00) {
    case "infantry":
      var_02[var_02.size] = 6;
      break;

    case "airborne":
      var_02[var_02.size] = 7;
      break;

    case "armored":
      var_02[var_02.size] = 8;
      break;

    case "mountain":
      var_02[var_02.size] = 9;
      break;

    case "expeditionary":
      var_02[var_02.size] = 10;
      break;

    case "resistance":
      var_02[var_02.size] = 12;
      break;

    case "grenadier":
      var_02[var_02.size] = 14;
      break;

    case "commando":
      var_02[var_02.size] = 16;
      break;

    case "scout":
      var_02[var_02.size] = 18;
      break;

    case "artillery":
      var_02[var_02.size] = 20;
      break;
  }

  var_02[var_02.size] = 2;
  var_02[var_02.size] = param_01;
  if(var_02.size > 0) {
    self ae_reportcomplexgameevent(15, var_02);
  }
}

lib_0468::func_0A2B(param_00, param_01) {
  var_02 = [];
  switch (param_00) {
    case "killBoss":
      var_02[var_02.size] = 1;
      var_02[var_02.size] = 1;
      break;

    case "raven_set":
      var_02[var_02.size] = 3;
      var_02[var_02.size] = 2;
      break;

    case "treasure_set":
      var_02[var_02.size] = 3;
      var_02[var_02.size] = 1;
      break;

    case "assassin_set":
      var_02[var_02.size] = 3;
      var_02[var_02.size] = 3;
      break;

    case "survivalist_set":
      var_02[var_02.size] = 3;
      var_02[var_02.size] = 4;
      break;

    case "mountain_man_set":
      var_02[var_02.size] = 3;
      var_02[var_02.size] = 5;
      break;

    case "bat_elite_set":
      var_02[var_02.size] = 3;
      var_02[var_02.size] = 6;
      break;

    case "wicht_set":
      var_02[var_02.size] = 3;
      var_02[var_02.size] = 29;
      break;

    case "master_prestige_200":
      var_02[var_02.size] = 3;
      var_02[var_02.size] = 30;
      break;

    case "master_prestige_500":
      var_02[var_02.size] = 3;
      var_02[var_02.size] = 32;
      break;

    case "master_prestige_1000":
      var_02[var_02.size] = 3;
      var_02[var_02.size] = 33;
      break;
  }

  if(isDefined(param_01)) {
    var_02[var_02.size] = 4;
    var_02[var_02.size] = param_01;
  }

  if(var_02.size > 0) {
    self ae_reportcomplexgameevent(16, var_02);
  }
}

ae_sendrankedplayrankupevent(param_00) {
  var_01 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_play_current_season");
  var_02 = self getrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_play_season_data", var_01, "rewarded", param_00 - 1);
  if(!isDefined(var_02) || var_02 == 0) {
    self ae_reportcomplexgameevent(31, [1, var_01 + 1, 2, param_00]);
    self setrankedplayerdata(common_scripts\utility::func_46AE(), "ranked_play_season_data", var_01, "rewarded", param_00 - 1, 1);
  }
}

ae_sendassistevent(param_00) {
  if(!maps\mp\_utility::func_7A69() || function_0367()) {
    return 0;
  }

  var_01 = [];
  var_02 = 0;
  if(isDefined(self.var_0079)) {
    switch (self.var_0079) {
      case 0:
        var_02 = var_02 | 64;
        break;

      case 1:
        var_02 = var_02 | 128;
        break;

      case 2:
        var_02 = var_02 | 256;
        break;

      case 3:
        var_02 = var_02 | 512;
        break;

      case 4:
        var_02 = var_02 | 1024;
        break;

      case 6:
        var_02 = var_02 | 4096;
        break;

      case 7:
        var_02 = var_02 | 16384;
        break;

      case 8:
        var_02 = var_02 | 65536;
        break;

      case 9:
        var_02 = var_02 | 262144;
        break;

      case 10:
        var_02 = var_02 | 1048576;
        break;
    }

    var_01[var_01.size] = 130;
    var_01[var_01.size] = var_02;
  }

  if(isDefined(param_00) && param_00 == "assist_riot_shield") {
    var_01[var_01.size] = 1;
    var_01[var_01.size] = 2;
  } else {
    var_01[var_01.size] = 1;
    var_01[var_01.size] = 1;
  }

  self ae_reportcomplexgameevent(32, var_01);
}

ae_sendzombiekillevent(param_00, param_01) {
  if(!maps\mp\_utility::func_7A69() || function_0367()) {
    return 0;
  }

  var_02 = [];
  var_03 = [];
  var_03 = checkgamemode(var_03, 2);
  if(isDefined(param_01) && maps\mp\_utility::func_5697(param_01, param_00)) {
    var_03[var_03.size] = 3;
    var_03[var_03.size] = 1;
  }

  if(level.var_3FDC == "undead" && isDefined(level.var_AC7C.var_9D5E) && self istouching(level.var_AC7C.var_9D5E)) {
    var_02[var_02.size] = "kill_on_hp";
  }

  if(isDefined(var_02) && var_02.size > 0) {
    var_04 = 0;
    foreach(var_06 in var_02) {
      if(var_06 == "kill_on_hp") {
        var_04 = var_04 | 4;
        continue;
      }
    }

    if(var_04 > 0) {
      var_03[var_03.size] = 128;
      var_03[var_03.size] = var_04;
    }
  }

  if(var_03.size > 0) {
    self ae_reportcomplexgameevent(40, var_03);
  }
}

ae_sendzmskinunlockevent(param_00) {
  self endon("disconnect");
  for(;;) {
    self waittill("luinotifyserver", var_01, param_00);
    if(var_01 == "unlock_zombie_skin") {
      var_02 = [];
      switch (param_00) {
        case 0:
          var_02[var_02.size] = 1;
          var_02[var_02.size] = 1;
          break;

        case 1:
          var_02[var_02.size] = 1;
          var_02[var_02.size] = 2;
          break;

        case 2:
          var_02[var_02.size] = 1;
          var_02[var_02.size] = 3;
          break;

        case 3:
          var_02[var_02.size] = 1;
          var_02[var_02.size] = 4;
          break;

        case 4:
          var_02[var_02.size] = 1;
          var_02[var_02.size] = 5;
          break;

        case 5:
          var_02[var_02.size] = 1;
          var_02[var_02.size] = 6;
          break;

        case 6:
          var_02[var_02.size] = 1;
          var_02[var_02.size] = 7;
          break;

        case 7:
          var_02[var_02.size] = 1;
          var_02[var_02.size] = 8;
          break;

        case 8:
          var_02[var_02.size] = 1;
          var_02[var_02.size] = 9;
          break;

        case 9:
          var_02[var_02.size] = 1;
          var_02[var_02.size] = 10;
          break;

        case 10:
          var_02[var_02.size] = 1;
          var_02[var_02.size] = 11;
          break;

        case 11:
          var_02[var_02.size] = 1;
          var_02[var_02.size] = 12;
          break;

        case 12:
          var_02[var_02.size] = 1;
          var_02[var_02.size] = 13;
          break;

        case 13:
          var_02[var_02.size] = 1;
          var_02[var_02.size] = 14;
          break;

        case 14:
          var_02[var_02.size] = 1;
          var_02[var_02.size] = 15;
          break;

        case 15:
          var_02[var_02.size] = 1;
          var_02[var_02.size] = 16;
          break;
      }

      if(var_02.size > 0) {
        self ae_reportcomplexgameevent(45, var_02);
      }
    }
  }
}

lib_0468::func_0A1A(param_00, param_01, param_02, param_03, param_04) {
  if(!param_01 maps\mp\_utility::func_7A69() || function_0367()) {
    return 0;
  }

  if(!isDefined(param_01)) {
    return;
  }

  if(!isDefined(param_01.var_80BD)) {
    param_01 thread lib_0468::func_A93F();
  }

  if(!isDefined(param_01.var_012C["deflects"])) {
    param_01 thread watchshielddeflect();
  }

  switch (param_00) {
    case "killstreak10":
      param_01 lib_0468::func_0A28("kill");
      break;

    case "starting_flag":
    case "opening_move":
    case "capture":
      param_01 lib_0468::func_0A22("domCap");
      if(isDefined(param_01.var_012C["domCaps"])) {
        param_01.var_012C["domCaps"]++;
      } else {
        param_01.var_012C["domCaps"] = 1;
      }

      if(param_01.var_012C["domCaps"] == 6) {
        param_01 lib_0468::func_0A22("domCap6");
      }
      break;

    case "flag_capture":
      param_01 lib_0468::func_0A22("ctfCapFlag");
      break;

    case "touchdown":
      if(!isDefined(self.touchdowns)) {
        self.touchdowns = 0;
      }

      self.touchdowns++;
      if(self.touchdowns == 2) {
        param_01 lib_0468::func_0A22("touchdown");
      }
      break;

    case "kill_confirmed":
      param_01 lib_0468::func_0A22("enemyTag");
      break;

    case "kill_denied_retrieved":
    case "kill_denied":
      param_01 lib_0468::func_0A22("friendlyTag");
      break;

    case "multikill":
    case "eightkill":
    case "sevenkill":
    case "sixkill":
    case "fivekill":
    case "fourkill":
    case "triplekill":
    case "doublekill":
      param_01 lib_0468::func_0A24(param_02, param_00);
      break;

    case "plane_gunner_destroyed":
    case "paratroopers_plane_destroyed":
    case "emergency_carepackage_plane_destroyed":
    case "carepackage_plane_destroyed":
    case "fighter_strike_destroyed":
    case "fire_bombing_run_destroyed":
    case "airstrike_destroyed":
    case "counter_uav_destroyed":
    case "uav_destroyed":
      param_01 lib_0468::func_0A28("destroy");
      break;

    case "raids_construct":
      param_01 lib_0468::func_0A22("warConstruct");
      break;

    case "sharepackage":
      param_01 lib_0468::func_0A28("sharepackage");
      break;

    case "shield_dmg_taken":
      param_01.var_012C["deflects"]++;
      if(param_01.var_012C["deflects"] == 5) {
        param_01 lib_0468::func_0A22("shieldDeflect5");
        param_01 notify("stopWatchingShieldDeflect");
      }

      break;

    default:
      if(issubstr(param_00, "_earned")) {
        param_01.var_80BD++;
        if(param_01.var_80BD == 3) {
          param_01 lib_0468::func_0A28("scorestreak3");
          param_01 notify("stopWatchingScorestreaks");
        }

        if(maps\mp\_utility::areexperimentalbasictrainingsenabled()) {
          param_01 lib_0468::func_0A28("throwbackStreakEarned");
        }
      }
      break;
  }
}

checkgamemode(param_00, param_01) {
  switch (level.var_3FDC) {
    case "war":
      param_00[param_00.size] = param_01;
      param_00[param_00.size] = 1;
      break;

    case "conf":
      param_00[param_00.size] = param_01;
      param_00[param_00.size] = 4;
      break;

    case "dom":
      param_00[param_00.size] = param_01;
      param_00[param_00.size] = 2;
      break;

    case "hp":
      param_00[param_00.size] = param_01;
      param_00[param_00.size] = 3;
      break;

    case "raid":
      param_00[param_00.size] = param_01;
      param_00[param_00.size] = 5;
      break;

    case "dm":
      param_00[param_00.size] = param_01;
      param_00[param_00.size] = 6;
      break;

    case "ctf":
      param_00[param_00.size] = param_01;
      param_00[param_00.size] = 7;
      break;

    case "sd":
      param_00[param_00.size] = param_01;
      param_00[param_00.size] = 8;
      break;

    case "ball":
      param_00[param_00.size] = param_01;
      param_00[param_00.size] = 9;
      break;

    case "gun":
      param_00[param_00.size] = param_01;
      param_00[param_00.size] = 10;
      break;

    case "demo":
      param_00[param_00.size] = param_01;
      param_00[param_00.size] = 11;
      break;

    case "prop":
      param_00[param_00.size] = param_01;
      param_00[param_00.size] = 12;
      break;

    case "infect":
      param_00[param_00.size] = param_01;
      param_00[param_00.size] = 13;
      break;

    case "relic":
      param_00[param_00.size] = param_01;
      param_00[param_00.size] = 14;
      break;

    case "undead":
      param_00[param_00.size] = param_01;
      param_00[param_00.size] = 15;
      break;
  }

  return param_00;
}

checkspecialmodes(param_00) {
  if(isDefined(level.var_4B17) && level.var_4B17 == 1) {
    if(getdvarint("spv_ground_war_active", 0) == 1) {
      param_00[param_00.size] = 9;
      param_00[param_00.size] = 6;
    } else {
      param_00[param_00.size] = 9;
      param_00[param_00.size] = 1;
    }
  } else if(maps\mp\_utility::areexperimentalbasictrainingsenabled()) {
    param_00[param_00.size] = 9;
    param_00[param_00.size] = 4;
  } else if(getdvarint("leprechauns_enabled", 0) == 1) {
    param_00[param_00.size] = 9;
    param_00[param_00.size] = 3;
  } else if(getdvarint("spv_ground_war_active", 0) == 1) {
    param_00[param_00.size] = 9;
    param_00[param_00.size] = 5;
  } else if(getdvarint("scr_oneShot", 0) == 1) {
    param_00[param_00.size] = 9;
    param_00[param_00.size] = 2;
  } else if(level.var_3FDC == "undead" || level.var_3FDC == "relic" || level.var_3FDC == "infect") {
    param_00[param_00.size] = 9;
    param_00[param_00.size] = 7;
  }

  return param_00;
}

lib_0468::func_0A1B() {
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    self waittill("luinotifyserver", var_00, var_01);
    if(var_00 == "ae_completeddaily") {
      thread maps\mp\gametypes\_missions::func_7750("ch_hq_daily", 1);
      continue;
    }

    if(var_00 == "ae_completedweekly") {
      thread maps\mp\gametypes\_missions::func_7750("ch_hq_weekly", 1);
    }
  }
}

lib_0468::func_A93F() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("stopWatchingScorestreaks");
  for(;;) {
    self.var_80BD = 0;
    self waittill("death");
  }
}

watchshielddeflect() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("stopWatchingShieldDeflect");
  for(;;) {
    self.var_012C["deflects"] = 0;
    self waittill("death");
  }
}

lib_0468::func_5DD2() {
  for(;;) {
    self waittill("luinotifyserver", var_00, var_01);
    if(var_00 != "hub_onboarding") {
      continue;
    }

    if(var_01 == -1) {}

    switch (var_01) {
      case 25:
        self notify("cac");
        break;

      case 26:
        self notify("completed_onboard_phase_1");
        break;

      case 27:
        break;

      case 28:
        break;

      case 29:
        break;

      case 30:
        break;

      case 31:
        break;

      case 32:
        self notify("supply");
        break;

      case 33:
        self notify("orders");
        break;

      default:
        break;
    }
  }
}

hasthrowbacktrainingequipped() {
  return maps\mp\_utility::_hasexperimentalbtperk("specialty_class_stopping_power") || maps\mp\_utility::_hasexperimentalbtperk("specialty_class_juggernaut") || maps\mp\_utility::_hasexperimentalbtperk("specialty_class_danger_close") || maps\mp\_utility::_hasexperimentalbtperk("specialty_class_one_man_army") || maps\mp\_utility::_hasexperimentalbtperk("specialty_class_commando_pro") || maps\mp\_utility::_hasexperimentalbtperk("specialty_class_last_stand") || maps\mp\_utility::_hasexperimentalbtperk("specialty_class_martyrdom");
}

lib_0468::func_2565() {}