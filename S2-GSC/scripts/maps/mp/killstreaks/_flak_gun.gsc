/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\killstreaks\_flak_gun.gsc
*****************************************************/

init() {
  level._effect["flak_gun_explosion"] = loadfx("vfx/scorestreaks/ss_flak_explosion_01");
  level._id_5A61["flak_gun"] = ::_id_9E2C;
  level._id_5A7D["killstreak_flak_gun_mp"] = "flak_gun";
}

_id_9E2C(var_0) {
  return _id_9E30("flak_gun");
}

_id_9E25(var_0) {
  return _id_9E30("counter_uav");
}

_id_9E30(var_0) {
  if(level.teambased && var_0 == "counter_uav" && level._id_9850[common_scripts\utility::_id_416F(self.team)]) {
    self iprintlnbold(&"KILLSTREAKS_COUNTER_RECON_TEAM_ALREADY_HAS");
    return 0;
  }

  if(level.teambased && level._id_9854[common_scripts\utility::_id_416F(self.team)]) {
    self iprintlnbold(&"KILLSTREAKS_FLAK_GUN_TEAM_ALREADY_HAS");
    return 0;
  }

  if(!level.teambased && isDefined(level._id_3CE0) || level.teambased && level._id_9854[self.team]) {
    self iprintlnbold(&"KILLSTREAKS_FLAK_GUN_ONE_AT_A_TIME");
    return 0;
  }

  _id_0485::_id_5E9A(var_0, self.origin);
  thread _id_A20C(var_0);
  return 1;
}

_id_A20C(var_0) {
  thread _id_6B75(self.team, var_0);
  self endon("disconnect");
  self endon("joined_team");
  self endon("joined_spectators");
  thread _id_2DC2(self, var_0);
  var_1 = 0;

  if(var_0 == "flak_gun") {
    var_2 = maps\mp\_utility::_hasperk("specialty_improvedstreaks");

    if(var_2) {
      var_1 = 45;
    } else {
      var_1 = 30;
    }

    if(level.teambased) {
      level._id_9854[maps\mp\_utility::getotherteam(self.team)] = 1;
    }

    level._id_3CE0 = self;
  } else if(var_0 == "counter_uav") {
    var_1 = 30;

    if(level.teambased) {
      level._id_9850[maps\mp\_utility::getotherteam(self.team)] = 1;
    } else {
      level._id_2694 = self;
    }
  }

  level thread _id_0528::_id_A0E0();
  maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_1);
  level thread _id_4AC0(self.team, var_0);
}

_id_6B75(var_0, var_1) {
  level endon("flakGunsDisabled");
  common_scripts\utility::_id_A70A("disconnect", "joined_team", "joined_spectators");
  level thread _id_4AC0(var_0, var_1);
}

_id_4AC0(var_0, var_1) {
  level notify("flakGunsDisabled");
  level._id_3CE2 = 0;

  if(var_1 == "flak_gun") {
    if(level.teambased) {
      level._id_9854[maps\mp\_utility::getotherteam(var_0)] = 0;
    }

    level._id_3CE0 = undefined;
  } else if(var_1 == "counter_uav") {
    if(level.teambased) {
      level._id_9850[maps\mp\_utility::getotherteam(var_0)] = 0;
    } else {
      level._id_2694 = undefined;
    }
  }

  level thread _id_0528::_id_A0E0();
}

_id_2DC2(var_0, var_1) {
  level endon("flakGunsDisabled");
  level._id_3CE2 = 0;
  wait 0.6;
  thread _id_2DC1(var_0, var_1);

  if(var_1 == "flak_gun") {
    thread _id_2DC0(var_0, var_1);
  }

  wait 0.4;
  level thread _id_1129(var_0, var_1);
}

_id_2DC0(var_0, var_1) {
  level endon("flakGunsDisabled");
  var_2 = [];

  for(;;) {
    var_3 = level._id_7043;

    foreach(var_5 in var_3) {
      var_6 = 0;

      for(var_7 = 0; var_7 < var_2.size; var_7++) {
        if(var_2[var_7] == var_5) {
          var_6 = 1;
        }
      }

      if(var_6 || level.teambased && isDefined(var_5.team) && var_5.team == var_0.team || !level.teambased && isDefined(var_5._id_0117) && var_5._id_0117 == var_0) {
        continue;
      }
      if(isDefined(var_5._id_275E)) {
        var_5 = var_5._id_376E;
      }

      var_2[var_2.size] = var_5;
      thread _id_2DDA(var_0, var_5, _id_45BD(var_5._id_01C8), var_1);
      waitframe();
    }

    wait 0.1;
  }
}

_id_2DC1(var_0, var_1) {
  level endon("flakGunsDisabled");
  var_2 = [];

  for(;;) {
    var_3 = level._id_9FDA;

    if(level.teambased) {
      var_3 = level._id_9FDA[maps\mp\_utility::getotherteam(var_0.team)];
    }

    foreach(var_5 in var_3) {
      var_6 = 0;

      for(var_7 = 0; var_7 < var_2.size; var_7++) {
        if(var_2[var_7] == var_5) {
          var_6 = 1;
        }
      }

      if(var_6 || level.teambased && isDefined(var_5.team) && var_5.team == var_0.team || !level.teambased && isDefined(var_5._id_0117) && var_5._id_0117 == var_0) {
        continue;
      }
      var_2[var_2.size] = var_5;
      thread _id_2DDA(var_0, var_5, _id_45BD(var_5._id_01C8), var_1);
      waitframe();
    }

    wait 0.1;
  }
}

_id_2DDA(var_0, var_1, var_2, var_3) {
  level endon("flakGunsDisabled");
  level._id_3CE2++;
  level thread _id_3BE7(var_0, var_1, var_2, var_3);
  var_1 waittill("death");
  level._id_3CE2--;
}

_id_3BE7(var_0, var_1, var_2, var_3) {
  level endon("flakGunsDisabled");
  var_1 endon("death");
  var_4 = "MOD_EXPLOSIVE";
  var_5 = "killstreak_flak_gun_mp";
  var_6 = var_1.maxhealth / var_2;
  var_7 = var_1.origin;
  wait 0.4;

  while(var_1.health > 0 && var_1._id_006A < var_1.maxhealth) {
    var_8 = var_1.origin - var_7;
    var_7 = var_1.origin;
    var_9 = 0;

    for(var_10 = 0; var_10 < 6 && isDefined(var_1) && var_1.health > 0 && var_1._id_006A < var_1.maxhealth; var_10++) {
      var_11 = var_1.origin + var_8;
      var_11 = (_randomfloatrange(-600, 600) + var_11[0], _randomfloatrange(-600, 600) + var_11[1], _randomfloatrange(-200, 200) + var_11[2]);
      thread _id_3CDE(var_11, var_3);
      waitframe();
    }

    var_1 dodamage(var_6, var_1.origin, var_0, var_0, var_4, var_5);
    wait 0.4;
  }
}

_id_45BD(var_0) {
  switch (var_0) {
    case "plane_gunner":
      return 5;
    case "emergency_carepackage":
    case "carepackage":
    case "fighter_strike":
      return 2;
    case "firebomb":
    case "airstrike":
      return 3;
    case "advanced_uav":
    case "counter_uav":
    case "uav":
    default:
      return 1;
  }
}

_id_1129(var_0, var_1) {
  level endon("flakGunsDisabled");
  level._id_3CE1 = 0;

  for(;;) {
    if(level._id_3CE2 == 0 && level._id_3CE1 < 30) {
      var_2 = _id_0527::_id_4409();
      var_3 = (_randomfloatrange(-3000, 3000) + level._id_5FEB[0], _randomfloatrange(-3000, 3000) + level._id_5FEB[1], var_2);
      level._id_3CE1++;
      thread _id_3CDE(var_3, var_1);
      waitframe();
      continue;
    }

    waitframe();
  }
}

_id_3CDE(var_0, var_1) {
  var_2 = common_scripts\utility::_id_8FFC();
  var_2.origin = var_0;
  var_2 show();
  waitframe();
  _playFXOnTag(common_scripts\utility::_id_44F5("flak_gun_explosion"), var_2, "tag_origin");
  _id_0378::_id_8D74("ks_flak_cannon_explo", var_0);
  wait 4.5;
  var_2 delete();
  level._id_3CE1--;
}