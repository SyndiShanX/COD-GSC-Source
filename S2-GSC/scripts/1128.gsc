/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1128.gsc
**************************************/

_id_0A23(var_0, var_1, var_2, var_3) {
  if(!maps\mp\_utility::rankingenabled() || _func_367())
    return 0;

  var_4 = [];

  if(!isDefined(var_3))
    var_3 = [];

  var_5 = 0;

  if(isDefined(self._id_5B93) && gettime() - self._id_5B93 < 2000) {
    var_4[var_4.size] = 5;
    var_4[var_4.size] = 1;
  }

  if(var_0 common_scripts\utility::_id_56F4() || var_0 common_scripts\utility::_id_56B5() || var_0 common_scripts\utility::_id_56F2() || var_0 common_scripts\utility::_id_5701()) {
    var_4[var_4.size] = 8;
    var_4[var_4.size] = 1;
    var_5 = 1;
  }

  if(var_2 == "MOD_HEAD_SHOT") {
    var_4[var_4.size] = 6;
    var_4[var_4.size] = 1;
  }

  var_6 = var_0 getstance();

  if(var_6 == "crouch")
    var_3[var_3.size] = "enemyCrouched";
  else if(var_6 == "prone")
    var_3[var_3.size] = "enemyProne";

  var_7 = self getstance();

  if(var_7 == "crouch")
    var_3[var_3.size] = "playerCrouched";
  else if(var_7 == "prone")
    var_3[var_3.size] = "playerProne";

  switch (maps\mp\_utility::getweaponclass(var_1)) {
    case "weapon_assault":
      var_4[var_4.size] = 1;
      var_4[var_4.size] = 1;
      break;
    case "weapon_smg":
      var_4[var_4.size] = 1;
      var_4[var_4.size] = 2;
      break;
    case "weapon_heavy":
      var_4[var_4.size] = 1;
      var_4[var_4.size] = 3;
      break;
    case "weapon_shotgun":
      var_4[var_4.size] = 1;
      var_4[var_4.size] = 4;
      break;
    case "weapon_sniper":
      var_4[var_4.size] = 1;
      var_4[var_4.size] = 5;
      break;
    case "weapon_pistol":
      var_4[var_4.size] = 1;
      var_4[var_4.size] = 6;
      break;
    case "weapon_projectile":
      var_4[var_4.size] = 1;
      var_4[var_4.size] = 7;
      break;
    case "weapon_grenade":
      var_4[var_4.size] = 1;
      var_4[var_4.size] = 8;

      if(isDefined(self.stuckenemy) && self.stuckenemy > 0) {
        var_3[var_3.size] = "stuck";
        self.stuckenemy--;

        if(self.stuckenemy < 0)
          self.stuckenemy = 0;
      }

      var_8 = self getoffhandsecondaryclass();

      if(!var_5 && isDefined(var_8) && var_8 == var_1) {
        var_4[var_4.size] = 8;
        var_4[var_4.size] = 1;
      }

      if(var_1 == "throwingknife_mp")
        var_3[var_3.size] = "throwingKnifeKill";

      break;
    case "killstreak":
      var_4[var_4.size] = 1;
      var_4[var_4.size] = 11;
      break;
    case "weapon_other":
      if(issubstr(var_1, "shovel")) {
        var_4[var_4.size] = 1;
        var_4[var_4.size] = 10;
      }

      if(issubstr(var_1, "riotshield")) {
        var_4[var_4.size] = 1;
        var_4[var_4.size] = 15;
      }

      break;
    case "other":
      if(issubstr(var_1, "turret_mg42")) {
        var_4[var_4.size] = 1;
        var_4[var_4.size] = 12;
      } else if(_id_047A::_id_43D6(var_1) == "raids_tank_turret_kill") {
        var_4[var_4.size] = 1;
        var_4[var_4.size] = 13;
      } else if(issubstr(var_1, "relic")) {
        var_4[var_4.size] = 1;
        var_4[var_4.size] = 14;
      }

      break;
  }

  var_4 = checkgamemode(var_4, 2);
  var_4 = checkspecialmodes(var_4);

  if(maps\mp\_utility::areexperimentalbasictrainingsenabled()) {
    if(hasthrowbacktrainingequipped())
      var_3[var_3.size] = "throwbackEquipped";
  }

  if(maps\mp\_utility::_hasperk("specialty_class_wanderlust"))
    var_3[var_3.size] = "wanderlustEquipped";

  var_9 = 0;
  var_10 = _id_04CB::_id_4499("kill", self, var_0, var_1, var_2);

  if(issubstr(var_10, "division")) {
    if(issubstr(var_10, "infantry")) {
      var_9 = var_9 | 2;
      var_3[var_3.size] = "divisionSkillKill";
    } else if(issubstr(var_10, "airborne")) {
      var_9 = var_9 | 4;
      var_3[var_3.size] = "divisionSkillKill";
    } else if(issubstr(var_10, "armored")) {
      var_9 = var_9 | 8;
      var_3[var_3.size] = "divisionSkillKill";
    } else if(issubstr(var_10, "mountain")) {
      var_9 = var_9 | 16;
      var_3[var_3.size] = "divisionSkillKill";
    } else if(issubstr(var_10, "cavalry")) {
      var_9 = var_9 | 32;
      var_3[var_3.size] = "divisionSkillKill";
    } else if(issubstr(var_10, "resistance")) {
      var_9 = var_9 | 2048;
      var_3[var_3.size] = "divisionSkillKill";
    }
  }

  if(isDefined(self._id_0079)) {
    switch (self._id_0079) {
      case 0:
        var_9 = var_9 | 64;

        if(maps\mp\_utility::getweaponclass(var_1) != "weapon_assault")
          var_3[var_3.size] = "infantry_no_rifle";

        break;
      case 1:
        var_9 = var_9 | 128;

        if(maps\mp\_utility::getweaponclass(var_1) != "weapon_smg")
          var_3[var_3.size] = "airborne_no_smg";

        break;
      case 2:
        var_9 = var_9 | 256;

        if(maps\mp\_utility::getweaponclass(var_1) != "weapon_heavy")
          var_3[var_3.size] = "armored_no_lmg";

        break;
      case 3:
        var_9 = var_9 | 512;

        if(maps\mp\_utility::getweaponclass(var_1) != "weapon_sniper")
          var_3[var_3.size] = "mountain_no_sniper";

        break;
      case 4:
        var_9 = var_9 | 1024;

        if(maps\mp\_utility::getweaponclass(var_1) != "weapon_shotgun")
          var_3[var_3.size] = "expeditionary_no_shotgun";

        break;
      case 6:
        var_9 = var_9 | 4096;

        if(maps\mp\_utility::getweaponclass(var_1) != "weapon_pistol")
          var_3[var_3.size] = "resistance_no_pistol";

        break;
      case 7:
        var_9 = var_9 | 16384;

        if(maps\mp\_utility::getweaponclass(var_1) != "weapon_assault")
          var_3[var_3.size] = "grenadier_no_rifle";

        break;
      case 8:
        var_9 = var_9 | 65536;

        if(maps\mp\_utility::getweaponclass(var_1) != "weapon_smg")
          var_3[var_3.size] = "commando_no_smg";

        break;
      case 9:
        var_9 = var_9 | 262144;

        if(maps\mp\_utility::getweaponclass(var_1) != "weapon_sniper")
          var_3[var_3.size] = "scout_no_sniper";

        break;
      case 10:
        var_9 = var_9 | 1048576;

        if(maps\mp\_utility::getweaponclass(var_1) != "weapon_assault")
          var_3[var_3.size] = "artillery_no_rifle";

        break;
    }
  }

  var_4[var_4.size] = 130;
  var_4[var_4.size] = var_9;

  if(isDefined(var_0._id_0079)) {
    switch (var_0._id_0079) {
      case 7:
        var_3[var_3.size] = "killed_cavalry";
        break;
    }
  }

  if(isDefined(var_2) && maps\mp\_utility::_id_5697(var_2, var_1)) {
    var_4[var_4.size] = 3;
    var_4[var_4.size] = 1;
  } else if(isDefined(var_2) && maps\mp\_utility::isexplosivedamage(var_2)) {
    var_4[var_4.size] = 3;
    var_4[var_4.size] = 3;
  } else if(isDefined(var_0._id_5033) && var_0._id_5033 &level.idflags_penetration) {
    var_4[var_4.size] = 3;
    var_4[var_4.size] = 4;
  } else if(isDefined(var_2) && var_2 == "MOD_MELEE") {
    var_4[var_4.size] = 3;
    var_4[var_4.size] = 2;
  }

  if(isDefined(self.lastweaponswaptime) && gettime() - self.lastweaponswaptime < 5000)
    var_3[var_3.size] = "switchWeaponKill";

  var_11 = _tolower(getDvar("1673"));

  if(var_11 == "mp_canon_farm" || var_11 == "mp_forest_01" || var_11 == "mp_carentan_s2_winter" || var_11 == "mp_raid_bulge")
    var_3[var_3.size] = "winter_map_kill";

  if(self.team != var_0.team && isDefined(var_0._id_2013))
    var_3[var_3.size] = "flag_carrier_kill";

  if(level.gametype == "hp" && isDefined(level._id_AC7C._id_9D5E) && self istouching(level._id_AC7C._id_9D5E))
    var_3[var_3.size] = "kill_on_hp";

  if(level.gametype == "relic" && isDefined(self.relicpasskill)) {
    var_3[var_3.size] = "skulduggery";
    self.relicpasskill = undefined;
  }

  if(level.gametype == "infect") {
    if(self.team == "axis")
      var_3[var_3.size] = "survivor_killed";
    else if(self.team == "allies")
      var_3[var_3.size] = "infected_killed";
  }

  if(!maps\mp\_utility::iskillstreakweapon(var_1) && maps\mp\_utility::_id_5695(var_2) && !maps\mp\_utility::isdogfightgametype()) {
    if(isDefined(self._id_3BE0))
      var_12 = self._id_3BE0;
    else
      var_12 = self playerads();

    if(var_12 >= 0.2)
      var_3[var_3.size] = "adsKill";
    else
      var_3[var_3.size] = "hipfireKill";
  }

  if(isDefined(var_3) && var_3.size > 0) {
    var_13 = 0;
    var_14 = 0;

    foreach(var_16 in var_3) {
      if(var_16 == "flag_carrier_kill") {
        var_14 = var_14 | 2;
        continue;
      }

      if(var_16 == "kill_on_hp") {
        var_13 = var_13 | 4;
        continue;
      }

      if(var_16 == "longshot") {
        var_13 = var_13 | 8;
        continue;
      }

      if(var_16 == "kingslayer") {
        var_14 = var_14 | 4;
        continue;
      }

      if(var_16 == "enemyCrouched") {
        var_14 = var_14 | 8;
        continue;
      }

      if(var_16 == "enemyProne") {
        var_14 = var_14 | 16;
        continue;
      }

      if(var_16 == "playerCrouched") {
        var_13 = var_13 | 8192;
        continue;
      }

      if(var_16 == "playerProne") {
        var_13 = var_13 | 16384;
        continue;
      }

      if(var_16 == "throwback") {
        var_13 = var_13 | 2;
        continue;
      }

      if(var_16 == "payback") {
        var_13 = var_13 | 16;
        continue;
      }

      if(var_16 == "backfire") {
        var_13 = var_13 | 32;
        continue;
      }

      if(var_16 == "stuck") {
        var_13 = var_13 | 64;
        continue;
      }

      if(var_16 == "infantry_no_rifle") {
        var_13 = var_13 | 128;
        continue;
      }

      if(var_16 == "airborne_no_smg") {
        var_13 = var_13 | 256;
        continue;
      }

      if(var_16 == "armored_no_lmg") {
        var_13 = var_13 | 512;
        continue;
      }

      if(var_16 == "mountain_no_sniper") {
        var_13 = var_13 | 1024;
        continue;
      }

      if(var_16 == "expeditionary_no_shotgun") {
        var_13 = var_13 | 2048;
        continue;
      }

      if(var_16 == "resistance_no_pistol") {
        var_13 = var_13 | 32768;
        continue;
      }

      if(var_16 == "grenadier_no_rifle") {
        var_13 = var_13 | 65536;
        continue;
      }

      if(var_16 == "commando_no_smg") {
        var_13 = var_13 | 131072;
        continue;
      }

      if(var_16 == "scout_no_sniper") {
        var_13 = var_13 | 262144;
        continue;
      }

      if(var_16 == "artillery_no_rifle") {
        var_13 = var_13 | 524288;
        continue;
      }

      if(var_16 == "winter_map_kill") {
        var_13 = var_13 | 4096;
        continue;
      }

      if(var_16 == "throwbackEquipped") {
        var_13 = var_13 | 1048576;
        continue;
      }

      if(var_16 == "divisionSkillKill") {
        var_13 = var_13 | 2097152;
        continue;
      }

      if(var_16 == "switchWeaponKill") {
        var_13 = var_13 | 4194304;
        continue;
      }

      if(var_16 == "throwingKnifeKill") {
        var_13 = var_13 | 8388608;
        continue;
      }

      if(var_16 == "adsKill") {
        var_13 = var_13 | 16777216;
        continue;
      }

      if(var_16 == "hipfireKill") {
        var_13 = var_13 | 33554432;
        continue;
      }

      if(var_16 == "skulduggery") {
        var_14 = var_14 | 32;
        continue;
      }

      if(var_16 == "survivor_killed") {
        var_14 = var_14 | 64;
        continue;
      }

      if(var_16 == "infected_killed") {
        var_14 = var_14 | 128;
        continue;
      }

      if(var_16 == "killed_cavalry") {
        var_14 = var_14 | 256;
        continue;
      }

      if(var_16 == "wanderlustEquipped") {
        var_13 = var_13 | 67108864;
        continue;
      }

      if(var_16 == "dediMelee") {
        var_13 = var_13 | 134217728;
        continue;
      }
    }

    if(var_13 > 0) {
      var_4[var_4.size] = 128;
      var_4[var_4.size] = var_13;
    }

    if(var_14 > 0) {
      var_4[var_4.size] = 129;
      var_4[var_4.size] = var_14;
    }
  }

  if(var_4.size > 0)
    self _meth_8697(1, var_4);
}

_id_0A24(var_0, var_1) {
  if(!maps\mp\_utility::rankingenabled() || _func_367())
    return 0;

  var_2 = [];

  switch (maps\mp\_utility::getweaponclass(var_0)) {
    case "weapon_grenade":
      var_2[var_2.size] = 1;
      var_2[var_2.size] = 1;

      if(isDefined(var_1) && var_1 != "doublekill" && maps\mp\_utility::_id_579B())
        _id_0A22("warTripleNade");

      break;
    case "weapon_pistol":
      var_2[var_2.size] = 1;
      var_2[var_2.size] = 2;
      break;
    case "weapon_shotgun":
      var_2[var_2.size] = 1;
      var_2[var_2.size] = 3;
      break;
    case "weapon_assault":
      var_2[var_2.size] = 1;
      var_2[var_2.size] = 4;
      break;
    case "weapon_smg":
      var_2[var_2.size] = 1;
      var_2[var_2.size] = 5;
      break;
    case "weapon_heavy":
      var_2[var_2.size] = 1;
      var_2[var_2.size] = 6;
      break;
    case "weapon_sniper":
      var_2[var_2.size] = 1;
      var_2[var_2.size] = 7;
      break;
  }

  var_2[var_2.size] = 2;
  var_2[var_2.size] = 1;
  var_2 = checkgamemode(var_2, 3);
  var_2 = checkspecialmodes(var_2);

  if(level.gametype == "dom" && isDefined(self._id_9AC5)) {
    foreach(var_4 in self._id_9AC5) {
      var_5 = 0;

      foreach(var_7 in level._id_3CC5) {
        if(var_4 == var_7) {
          var_5 = 1;
          break;
        }
      }

      if(!var_5) {
        continue;
      }
      _id_0A22("multikillOnDomPt");
      break;
    }
  }

  if(var_2.size > 0)
    self _meth_8697(2, var_2);
}

_id_0A22(var_0) {
  if(!maps\mp\_utility::rankingenabled() || _func_367())
    return 0;

  var_1 = [];

  switch (var_0) {
    case "tdm25kills":
      var_1[var_1.size] = 1;
      var_1[var_1.size] = 1;
      break;
    case "domCap":
      var_1[var_1.size] = 3;
      var_1[var_1.size] = 1;
      break;
    case "domCap6":
      var_1[var_1.size] = 3;
      var_1[var_1.size] = 3;
      break;
    case "multikillOnDomPt":
      var_1[var_1.size] = 3;
      var_1[var_1.size] = 2;
      break;
    case "enemyTag":
      var_1[var_1.size] = 2;
      var_1[var_1.size] = 1;
      break;
    case "friendlyTag":
      var_1[var_1.size] = 2;
      var_1[var_1.size] = 2;
      break;
    case "warConstruct":
      var_1[var_1.size] = 4;
      var_1[var_1.size] = 1;
      break;
    case "warKills45":
      var_1[var_1.size] = 4;
      var_1[var_1.size] = 2;
      break;
    case "warTripleNade":
      var_1[var_1.size] = 4;
      var_1[var_1.size] = 3;
      break;
    case "ctfCapFlag":
      var_1[var_1.size] = 5;
      var_1[var_1.size] = 1;
      break;
    case "3KillsFlagCarrier":
      var_1[var_1.size] = 5;
      var_1[var_1.size] = 2;
      break;
    case "touchdown":
      var_1[var_1.size] = 6;
      var_1[var_1.size] = 1;
      break;
    case "sdKiller":
      var_1[var_1.size] = 7;
      var_1[var_1.size] = 1;
      break;
    case "sdPlant":
      var_1[var_1.size] = 7;
      var_1[var_1.size] = 2;
      break;
    case "5KillsOnHp":
      var_1[var_1.size] = 8;
      var_1[var_1.size] = 1;
      break;
    case "demoBombPlanted":
      var_1[var_1.size] = 9;
      var_1[var_1.size] = 1;
      break;
    case "demoBombDefused":
      var_1[var_1.size] = 9;
      var_1[var_1.size] = 2;
      break;
    case "propRoundSurvivor":
      var_1[var_1.size] = 10;
      var_1[var_1.size] = 1;
      break;
    case "propChangelessSurvivor":
      var_1[var_1.size] = 10;
      var_1[var_1.size] = 2;
      break;
    case "lepKill":
      var_1[var_1.size] = 11;
      var_1[var_1.size] = 1;
      break;
    case "hailMary":
      var_1[var_1.size] = 11;
      var_1[var_1.size] = 2;
      break;
    case "soulCap":
      var_1[var_1.size] = 13;
      var_1[var_1.size] = 1;
      break;
    case "hordepoint1Min":
      var_1[var_1.size] = 14;
      var_1[var_1.size] = 1;
      break;
    case "shieldDeflect5":
      var_1[var_1.size] = 11;
      var_1[var_1.size] = 3;
      break;
  }

  var_2 = 0;

  if(isDefined(self._id_0079)) {
    switch (self._id_0079) {
      case 0:
        var_2 = var_2 | 64;
        break;
      case 1:
        var_2 = var_2 | 128;
        break;
      case 2:
        var_2 = var_2 | 256;
        break;
      case 3:
        var_2 = var_2 | 512;
        break;
      case 4:
        var_2 = var_2 | 1024;
        break;
      case 6:
        var_2 = var_2 | 4096;
        break;
      case 7:
        var_2 = var_2 | 16384;
        break;
      case 8:
        var_2 = var_2 | 65536;
        break;
      case 9:
        var_2 = var_2 | 262144;
        break;
      case 10:
        var_2 = var_2 | 1048576;
        break;
    }

    var_1[var_1.size] = 130;
    var_1[var_1.size] = var_2;
  }

  if(var_1.size > 0)
    self _meth_8697(3, var_1);
}

_id_0A28(var_0) {
  if(!maps\mp\_utility::rankingenabled() || _func_367())
    return 0;

  var_1 = [];

  switch (var_0) {
    case "kill":
      var_1[var_1.size] = 1;
      var_1[var_1.size] = 1;
      break;
    case "scorestreak3":
      var_1[var_1.size] = 2;
      var_1[var_1.size] = 1;
      break;
    case "destroy":
      var_1[var_1.size] = 2;
      var_1[var_1.size] = 3;
      break;
    case "scorestreakUsed":
      var_1[var_1.size] = 2;
      var_1[var_1.size] = 2;
      break;
    case "sharepackage":
      var_1[var_1.size] = 2;
      var_1[var_1.size] = 4;
      break;
    case "packageUsed":
      var_1[var_1.size] = 2;
      var_1[var_1.size] = 5;
      break;
    case "packageCapped":
      var_1[var_1.size] = 2;
      var_1[var_1.size] = 7;
      break;
    case "throwbackStreakEarned":
      if(hasthrowbacktrainingequipped()) {
        var_1[var_1.size] = 2;
        var_1[var_1.size] = 6;
      }

      break;
  }

  var_2 = 0;

  if(isDefined(self._id_0079)) {
    switch (self._id_0079) {
      case 0:
        var_2 = var_2 | 64;
        break;
      case 1:
        var_2 = var_2 | 128;
        break;
      case 2:
        var_2 = var_2 | 256;
        break;
      case 3:
        var_2 = var_2 | 512;
        break;
      case 4:
        var_2 = var_2 | 1024;
        break;
      case 6:
        var_2 = var_2 | 4096;
        break;
      case 7:
        var_2 = var_2 | 16384;
        break;
      case 8:
        var_2 = var_2 | 65536;
        break;
      case 9:
        var_2 = var_2 | 262144;
        break;
      case 10:
        var_2 = var_2 | 1048576;
        break;
    }

    var_1[var_1.size] = 130;
    var_1[var_1.size] = var_2;
  }

  var_1 = checkgamemode(var_1, 3);
  var_1 = checkspecialmodes(var_1);

  if(var_1.size > 0)
    self _meth_8697(4, var_1);
}

_id_0A1E(var_0, var_1, var_2, var_3) {
  if(!maps\mp\_utility::rankingenabled() || _func_367())
    return 0;

  var_4 = [];
  var_4[var_4.size] = 1;
  var_4[var_4.size] = 1;
  var_4 = checkgamemode(var_4, 2);
  var_4 = checkspecialmodes(var_4);

  if(var_2 == "conf" || var_2 == "dom" || var_2 == "hp" || var_2 == "raid" || var_2 == "ctf" || var_2 == "sd" || var_2 == "ball") {
    var_4[var_4.size] = 10;
    var_4[var_4.size] = 1;
  }

  if(var_1 <= 0)
    var_1 = 1;

  var_5 = var_0 / var_1;
  var_4[var_4.size] = 4;
  var_4[var_4.size] = int(var_5);
  var_4[var_4.size] = 3;

  if(isPlayer(var_3)) {
    var_6 = _id_04D2::_id_450B(3);
    var_7 = 2;

    if(level.players.size > 5) {
      foreach(var_9 in var_6) {
        if(self.clientid == var_9.clientid)
          var_7 = 1;
      }
    } else if(var_3 == self)
      var_7 = 1;
  } else if(isDefined(var_3)) {
    if(isDefined(self.team) && var_3 == self.team)
      var_7 = 1;
    else if(var_3 == "tie" || var_3 == "overtime")
      var_7 = 3;
    else
      var_7 = 2;
  } else
    var_7 = 2;

  var_4[var_4.size] = var_7;
  var_4[var_4.size] = 8;
  var_4[var_4.size] = self.pers["score"];

  if(self getentitynumber() == level._id_74CA) {
    var_4[var_4.size] = 5;
    var_4[var_4.size] = 1;
  }

  var_11 = 1;

  foreach(var_13 in level.players) {
    if(self.score < var_13.score)
      var_11++;
  }

  var_4[var_4.size] = 6;
  var_4[var_4.size] = var_11;
  var_4[var_4.size] = 7;

  if(_func_3AF()) {
    var_15 = _func_3B5();
    var_16 = self getplayerdata(common_scripts\utility::_id_46AE(), "ranked_play_season_data", var_15, "ranked_games_total");
    var_17 = !self getplayerdata(common_scripts\utility::_id_46AE(), "ranked_play_season_data", var_15, "mmr_was_adjusted");

    if(!var_17 || var_16 >= getdvarint("4697", 10))
      var_4[var_4.size] = 3;
    else
      var_4[var_4.size] = 2;
  } else
    var_4[var_4.size] = 1;

  if(var_4.size > 0)
    self _meth_8697(5, var_4);
}

_id_0A21(var_0) {
  self _meth_8697(6, [1, 1, 2, var_0]);
}

_id_0A1C(var_0, var_1, var_2) {
  var_3 = [];

  switch (var_0) {
    case "win":
      var_3[var_3.size] = 1;
      var_3[var_3.size] = 1;
      break;
    case "lose":
      var_3[var_3.size] = 1;
      var_3[var_3.size] = 2;
      break;
    case "tie":
      var_3[var_3.size] = 1;
      var_3[var_3.size] = 3;
      break;
  }

  if(isDefined(var_2) && var_2) {
    var_3[var_3.size] = 2;
    var_3[var_3.size] = 1;
  }

  if(var_3.size > 0) {
    if(isDefined(var_1))
      self _meth_8697(7, var_3, var_1);
    else
      self _meth_8697(7, var_3);
  }
}

_id_0A20(var_0) {
  var_1 = [];

  switch (var_0) {
    case "completedSequence":
      var_1[var_1.size] = 1;
      var_1[var_1.size] = 1;
      break;
    case "grenadeTire":
      var_1[var_1.size] = 2;
      var_1[var_1.size] = 1;
      break;
    case "targetHit":
      var_1[var_1.size] = 2;
      var_1[var_1.size] = 2;
      break;
  }

  if(var_1.size > 0)
    self _meth_8697(8, var_1);
}

_id_0A26(var_0, var_1) {
  var_2 = [];
  var_2[var_2.size] = 1;

  switch (var_0) {
    case "win":
      var_2[var_2.size] = 1;
      break;
    case "lose":
      var_2[var_2.size] = 2;
      break;
    case "tie":
      var_2[var_2.size] = 3;
      break;
  }

  if(var_2.size > 0) {
    if(isDefined(var_1))
      self _meth_8697(9, var_2, var_1);
    else
      self _meth_8697(9, var_2);
  }
}

_id_0A27(var_0) {
  var_1 = [];

  switch (var_0) {
    case "passBall":
      var_1[var_1.size] = 2;
      var_1[var_1.size] = 1;
      break;
    case "timerTagWin":
      var_1[var_1.size] = 3;
      var_1[var_1.size] = 1;
      break;
    case "timerTagLose":
      var_1[var_1.size] = 3;
      var_1[var_1.size] = 2;
      break;
  }

  if(var_1.size > 0)
    self _meth_8697(10, var_1);
}

_id_0A2A(var_0, var_1, var_2) {
  var_3 = [];

  switch (var_0) {
    case "theater":
      var_3[var_3.size] = 1;
      var_3[var_3.size] = 1;
      break;
    case "general":
      var_3[var_3.size] = 2;
      var_3[var_3.size] = var_1;
      break;
    case "division_prestige":
      var_3[var_3.size] = 3;
      var_3[var_3.size] = var_1;
      var_3[var_3.size] = 1;

      switch (var_2) {
        case "infantry":
          var_3[var_3.size] = 1;
          break;
        case "airborne":
          var_3[var_3.size] = 2;
          break;
        case "armored":
          var_3[var_3.size] = 3;
          break;
        case "mountain":
          var_3[var_3.size] = 4;
          break;
        case "expeditionary":
          var_3[var_3.size] = 5;
          break;
        case "resistance":
          var_3[var_3.size] = 11;
          break;
        case "grenadier":
          var_3[var_3.size] = 13;
          break;
        case "commando":
          var_3[var_3.size] = 15;
          break;
        case "scout":
          var_3[var_3.size] = 17;
          break;
        case "artillery":
          var_3[var_3.size] = 19;
          break;
      }

      break;
    case "zombie":
      var_3[var_3.size] = 5;
      var_3[var_3.size] = var_1;
      break;
    case "streakTraining":
      var_3[var_3.size] = 6;
      var_3[var_3.size] = 1;
      break;
  }

  if(var_3.size > 0)
    self _meth_8697(11, var_3);
}

_id_0A29(var_0, var_1, var_2) {
  var_3 = [];

  switch (var_0) {
    case "openSD":
      var_3[var_3.size] = 1;
      var_3[var_3.size] = 1;
      var_3[var_3.size] = 2;
      var_3[var_3.size] = var_1;
      break;
    case "watchSD":
      var_3[var_3.size] = 1;
      var_3[var_3.size] = 2;
      var_3[var_3.size] = 3;
      var_3[var_3.size] = var_2;
      break;
  }

  if(var_3.size > 0)
    self _meth_8697(12, var_3);
}

_id_0A1F() {
  self _meth_8697(13, [1, 1]);
}

_id_0A25(var_0, var_1) {
  if(var_1 == "mp")
    self _meth_8697(14, [2, 1, 1, var_0]);
  else if(var_1 == "zm")
    self _meth_8697(14, [2, 2, 1, var_0]);
}

ae_sendmasterprestigerankevent(var_0, var_1) {
  if(var_1 == "mp")
    self _meth_8697(14, [2, 1, 1, var_0, 3, 1]);
  else if(var_1 == "zm")
    return;
}

_id_0A1D(var_0, var_1) {
  var_2 = [];
  var_2[var_2.size] = 1;

  switch (var_0) {
    case "infantry":
      var_2[var_2.size] = 6;
      break;
    case "airborne":
      var_2[var_2.size] = 7;
      break;
    case "armored":
      var_2[var_2.size] = 8;
      break;
    case "mountain":
      var_2[var_2.size] = 9;
      break;
    case "expeditionary":
      var_2[var_2.size] = 10;
      break;
    case "resistance":
      var_2[var_2.size] = 12;
      break;
    case "grenadier":
      var_2[var_2.size] = 14;
      break;
    case "commando":
      var_2[var_2.size] = 16;
      break;
    case "scout":
      var_2[var_2.size] = 18;
      break;
    case "artillery":
      var_2[var_2.size] = 20;
      break;
  }

  var_2[var_2.size] = 2;
  var_2[var_2.size] = var_1;

  if(var_2.size > 0)
    self _meth_8697(15, var_2);
}

_id_0A2B(var_0, var_1) {
  var_2 = [];

  switch (var_0) {
    case "killBoss":
      var_2[var_2.size] = 1;
      var_2[var_2.size] = 1;
      break;
    case "raven_set":
      var_2[var_2.size] = 3;
      var_2[var_2.size] = 2;
      break;
    case "treasure_set":
      var_2[var_2.size] = 3;
      var_2[var_2.size] = 1;
      break;
    case "assassin_set":
      var_2[var_2.size] = 3;
      var_2[var_2.size] = 3;
      break;
    case "survivalist_set":
      var_2[var_2.size] = 3;
      var_2[var_2.size] = 4;
      break;
    case "mountain_man_set":
      var_2[var_2.size] = 3;
      var_2[var_2.size] = 5;
      break;
    case "bat_elite_set":
      var_2[var_2.size] = 3;
      var_2[var_2.size] = 6;
      break;
    case "wicht_set":
      var_2[var_2.size] = 3;
      var_2[var_2.size] = 29;
      break;
    case "master_prestige_200":
      var_2[var_2.size] = 3;
      var_2[var_2.size] = 30;
      break;
    case "master_prestige_500":
      var_2[var_2.size] = 3;
      var_2[var_2.size] = 32;
      break;
    case "master_prestige_1000":
      var_2[var_2.size] = 3;
      var_2[var_2.size] = 33;
      break;
  }

  if(isDefined(var_1)) {
    var_2[var_2.size] = 4;
    var_2[var_2.size] = var_1;
  }

  if(var_2.size > 0)
    self _meth_8697(16, var_2);
}

ae_sendrankedplayrankupevent(var_0) {
  var_1 = self getplayerdata(common_scripts\utility::_id_46AE(), "ranked_play_current_season");
  var_2 = self getplayerdata(common_scripts\utility::_id_46AE(), "ranked_play_season_data", var_1, "rewarded", var_0 - 1);

  if(!isDefined(var_2) || var_2 == 0) {
    self _meth_8697(31, [1, var_1 + 1, 2, var_0]);
    self setplayerdata(common_scripts\utility::_id_46AE(), "ranked_play_season_data", var_1, "rewarded", var_0 - 1, 1);
  }
}

ae_sendassistevent(var_0) {
  if(!maps\mp\_utility::rankingenabled() || _func_367())
    return 0;

  var_1 = [];
  var_2 = 0;

  if(isDefined(self._id_0079)) {
    switch (self._id_0079) {
      case 0:
        var_2 = var_2 | 64;
        break;
      case 1:
        var_2 = var_2 | 128;
        break;
      case 2:
        var_2 = var_2 | 256;
        break;
      case 3:
        var_2 = var_2 | 512;
        break;
      case 4:
        var_2 = var_2 | 1024;
        break;
      case 6:
        var_2 = var_2 | 4096;
        break;
      case 7:
        var_2 = var_2 | 16384;
        break;
      case 8:
        var_2 = var_2 | 65536;
        break;
      case 9:
        var_2 = var_2 | 262144;
        break;
      case 10:
        var_2 = var_2 | 1048576;
        break;
    }

    var_1[var_1.size] = 130;
    var_1[var_1.size] = var_2;
  }

  if(isDefined(var_0) && var_0 == "assist_riot_shield") {
    var_1[var_1.size] = 1;
    var_1[var_1.size] = 2;
  } else {
    var_1[var_1.size] = 1;
    var_1[var_1.size] = 1;
  }

  self _meth_8697(32, var_1);
}

ae_sendzombiekillevent(var_0, var_1) {
  if(!maps\mp\_utility::rankingenabled() || _func_367())
    return 0;

  var_2 = [];
  var_3 = [];
  var_3 = checkgamemode(var_3, 2);

  if(isDefined(var_1) && maps\mp\_utility::_id_5697(var_1, var_0)) {
    var_3[var_3.size] = 3;
    var_3[var_3.size] = 1;
  }

  if(level.gametype == "undead" && isDefined(level._id_AC7C._id_9D5E) && self istouching(level._id_AC7C._id_9D5E))
    var_2[var_2.size] = "kill_on_hp";

  if(isDefined(var_2) && var_2.size > 0) {
    var_4 = 0;

    foreach(var_6 in var_2) {
      if(var_6 == "kill_on_hp") {
        var_4 = var_4 | 4;
        continue;
      }
    }

    if(var_4 > 0) {
      var_3[var_3.size] = 128;
      var_3[var_3.size] = var_4;
    }
  }

  if(var_3.size > 0)
    self _meth_8697(40, var_3);
}

ae_sendzmskinunlockevent(var_0) {
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_1, var_0);

    if(var_1 == "unlock_zombie_skin") {
      var_2 = [];

      switch (var_0) {
        case 0:
          var_2[var_2.size] = 1;
          var_2[var_2.size] = 1;
          break;
        case 1:
          var_2[var_2.size] = 1;
          var_2[var_2.size] = 2;
          break;
        case 2:
          var_2[var_2.size] = 1;
          var_2[var_2.size] = 3;
          break;
        case 3:
          var_2[var_2.size] = 1;
          var_2[var_2.size] = 4;
          break;
        case 4:
          var_2[var_2.size] = 1;
          var_2[var_2.size] = 5;
          break;
        case 5:
          var_2[var_2.size] = 1;
          var_2[var_2.size] = 6;
          break;
        case 6:
          var_2[var_2.size] = 1;
          var_2[var_2.size] = 7;
          break;
        case 7:
          var_2[var_2.size] = 1;
          var_2[var_2.size] = 8;
          break;
        case 8:
          var_2[var_2.size] = 1;
          var_2[var_2.size] = 9;
          break;
        case 9:
          var_2[var_2.size] = 1;
          var_2[var_2.size] = 10;
          break;
        case 10:
          var_2[var_2.size] = 1;
          var_2[var_2.size] = 11;
          break;
        case 11:
          var_2[var_2.size] = 1;
          var_2[var_2.size] = 12;
          break;
        case 12:
          var_2[var_2.size] = 1;
          var_2[var_2.size] = 13;
          break;
        case 13:
          var_2[var_2.size] = 1;
          var_2[var_2.size] = 14;
          break;
        case 14:
          var_2[var_2.size] = 1;
          var_2[var_2.size] = 15;
          break;
        case 15:
          var_2[var_2.size] = 1;
          var_2[var_2.size] = 16;
          break;
      }

      if(var_2.size > 0)
        self _meth_8697(45, var_2);
    }
  }
}

_id_0A1A(var_0, var_1, var_2, var_3, var_4) {
  if(!var_1 maps\mp\_utility::rankingenabled() || _func_367())
    return 0;

  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_1.settext))
    var_1 thread _id_A93F();

  if(!isDefined(var_1.pers["deflects"]))
    var_1 thread watchshielddeflect();

  switch (var_0) {
    case "killstreak10":
      var_1 _id_0A28("kill");
      break;
    case "starting_flag":
    case "opening_move":
    case "capture":
      var_1 _id_0A22("domCap");

      if(isDefined(var_1.pers["domCaps"]))
        var_1.pers["domCaps"]++;
      else
        var_1.pers["domCaps"] = 1;

      if(var_1.pers["domCaps"] == 6)
        var_1 _id_0A22("domCap6");

      break;
    case "flag_capture":
      var_1 _id_0A22("ctfCapFlag");
      break;
    case "touchdown":
      if(!isDefined(self.touchdowns))
        self.touchdowns = 0;

      self.touchdowns++;

      if(self.touchdowns == 2)
        var_1 _id_0A22("touchdown");

      break;
    case "kill_confirmed":
      var_1 _id_0A22("enemyTag");
      break;
    case "kill_denied_retrieved":
    case "kill_denied":
      var_1 _id_0A22("friendlyTag");
      break;
    case "multikill":
    case "eightkill":
    case "sevenkill":
    case "sixkill":
    case "fivekill":
    case "fourkill":
    case "triplekill":
    case "doublekill":
      var_1 _id_0A24(var_2, var_0);
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
      var_1 _id_0A28("destroy");
      break;
    case "raids_construct":
      var_1 _id_0A22("warConstruct");
      break;
    case "sharepackage":
      var_1 _id_0A28("sharepackage");
      break;
    case "shield_dmg_taken":
      var_1.pers["deflects"]++;

      if(var_1.pers["deflects"] == 5) {
        var_1 _id_0A22("shieldDeflect5");
        var_1 notify("stopWatchingShieldDeflect");
      }
    default:
      if(issubstr(var_0, "_earned")) {
        var_1.settext++;

        if(var_1.settext == 3) {
          var_1 _id_0A28("scorestreak3");
          var_1 notify("stopWatchingScorestreaks");
        }

        if(maps\mp\_utility::areexperimentalbasictrainingsenabled())
          var_1 _id_0A28("throwbackStreakEarned");
      }

      break;
  }
}

checkgamemode(var_0, var_1) {
  switch (level.gametype) {
    case "war":
      var_0[var_0.size] = var_1;
      var_0[var_0.size] = 1;
      break;
    case "conf":
      var_0[var_0.size] = var_1;
      var_0[var_0.size] = 4;
      break;
    case "dom":
      var_0[var_0.size] = var_1;
      var_0[var_0.size] = 2;
      break;
    case "hp":
      var_0[var_0.size] = var_1;
      var_0[var_0.size] = 3;
      break;
    case "raid":
      var_0[var_0.size] = var_1;
      var_0[var_0.size] = 5;
      break;
    case "dm":
      var_0[var_0.size] = var_1;
      var_0[var_0.size] = 6;
      break;
    case "ctf":
      var_0[var_0.size] = var_1;
      var_0[var_0.size] = 7;
      break;
    case "sd":
      var_0[var_0.size] = var_1;
      var_0[var_0.size] = 8;
      break;
    case "ball":
      var_0[var_0.size] = var_1;
      var_0[var_0.size] = 9;
      break;
    case "gun":
      var_0[var_0.size] = var_1;
      var_0[var_0.size] = 10;
      break;
    case "demo":
      var_0[var_0.size] = var_1;
      var_0[var_0.size] = 11;
      break;
    case "prop":
      var_0[var_0.size] = var_1;
      var_0[var_0.size] = 12;
      break;
    case "infect":
      var_0[var_0.size] = var_1;
      var_0[var_0.size] = 13;
      break;
    case "relic":
      var_0[var_0.size] = var_1;
      var_0[var_0.size] = 14;
      break;
    case "undead":
      var_0[var_0.size] = var_1;
      var_0[var_0.size] = 15;
      break;
  }

  return var_0;
}

checkspecialmodes(var_0) {
  if(isDefined(level.hardcoremode) && level.hardcoremode == 1) {
    if(getdvarint("spv_ground_war_active", 0) == 1) {
      var_0[var_0.size] = 9;
      var_0[var_0.size] = 6;
    } else {
      var_0[var_0.size] = 9;
      var_0[var_0.size] = 1;
    }
  } else if(maps\mp\_utility::areexperimentalbasictrainingsenabled()) {
    var_0[var_0.size] = 9;
    var_0[var_0.size] = 4;
  } else if(getdvarint("leprechauns_enabled", 0) == 1) {
    var_0[var_0.size] = 9;
    var_0[var_0.size] = 3;
  } else if(getdvarint("spv_ground_war_active", 0) == 1) {
    var_0[var_0.size] = 9;
    var_0[var_0.size] = 5;
  } else if(getdvarint("scr_oneShot", 0) == 1) {
    var_0[var_0.size] = 9;
    var_0[var_0.size] = 2;
  } else if(level.gametype == "undead" || level.gametype == "relic" || level.gametype == "infect") {
    var_0[var_0.size] = 9;
    var_0[var_0.size] = 7;
  }

  return var_0;
}

_id_0A1B() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "ae_completeddaily") {
      thread maps\mp\gametypes\_missions::processchallenge("ch_hq_daily", 1);
      continue;
    }

    if(var_0 == "ae_completedweekly")
      thread maps\mp\gametypes\_missions::processchallenge("ch_hq_weekly", 1);
  }
}

_id_A93F() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("stopWatchingScorestreaks");

  for(;;) {
    self.settext = 0;
    self waittill("death");
  }
}

watchshielddeflect() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("stopWatchingShieldDeflect");

  for(;;) {
    self.pers["deflects"] = 0;
    self waittill("death");
  }
}

_id_5DD2() {
  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 != "hub_onboarding") {
      continue;
    }
    if(var_1 == -1) {}

    switch (var_1) {
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

_id_2565() {}