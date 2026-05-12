/*******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\dogfight_scorestreaks.gsc
*******************************************************/

init_dogfight_killstreaks() {
  level thread scorestreakdvarhostmigration();
  level.var_5A61["dogfight_flak"] = ::tryusedogfightflak;
  level.var_5A7D["killstreak_flak_gun_raids"] = "dogfight_flak";
}

scorestreakdvarhostmigration() {
  level endon("game_ended");
  setDvar("scorestreak_enabled_dogfight_flak", 1);
  for(;;) {
    level waittill("host_migration_begin");
    setDvar("scorestreak_enabled_dogfight_flak", 1);
    maps\mp\gametypes\_hostmigration::func_A782();
  }
}

tryusedogfightflak(param_00) {
  if(level.flak_in_progress) {
    self iclientprintlnbold(&"KILLSTREAKS_RAIDS_TOO_MUCH_FLAK");
    return 0;
  }

  level.flak_in_progress = 1;
  level.flak_scorestreak_id++;
  level.var_9854[maps\mp\_utility::func_45DE(self.var_01A7)] = 1;
  level thread lib_0528::func_A0E0();
  var_01 = undefined;
  var_02 = undefined;
  if(getdvarint("dogfightFlakDamageScaleEnabled", 1) || getdvarint("dogfightFlakDamageWeightEnabled", 1)) {
    var_03 = common_scripts\utility::func_46B5("dogfight_flak_zone", "targetname");
    var_01 = var_03.var_0116[2];
    var_02 = var_03.var_0116[2] + var_03.var_00BD;
  }

  thread dogfight_atmosphereflak(var_01, var_02);
  thread dogfight_flakrundamage(var_01, var_02);
  thread dogfight_flak_timer();
  return 1;
}

dogfight_flak_timer() {
  wait(getdvarfloat("dogfightFlakDuration", 15));
  level notify("flakGunsDisabled");
  destroy_remaining_agents();
  level.flak_in_progress = 0;
  level.var_9854[maps\mp\_utility::func_45DE(self.var_01A7)] = 0;
  level thread lib_0528::func_A0E0();
  clear_flak_death_flags();
}

fighter_scorestreak_watcher(param_00) {
  level endon("game_ended");
  if(isPlayer(param_00) && !isbot(param_00)) {
    param_00 notifyonplayercommand("activate_fighter_scorestreak", "+actionslot 4");
    if(!level.var_258F) {
      param_00 notifyonplayercommand("activate_fighter_scorestreak_keyboard", "+actionslot 5");
    }
  }

  for(;;) {
    var_01 = param_00 common_scripts\utility::func_A715("activate_fighter_scorestreak", "activate_fighter_scorestreak_keyboard");
    if(isDefined(var_01)) {
      if(var_01 == "activate_fighter_scorestreak" && !param_00 common_scripts\utility::func_55E0()) {
        continue;
      } else if(var_01 == "activate_fighter_scorestreak_keyboard" && param_00 common_scripts\utility::func_55E0()) {
        continue;
      }

      if(isDefined(param_00.var_5A69)) {
        param_00 maps\mp\killstreaks\_killstreaks::func_5A7A();
      }
    }

    wait 0.05;
  }
}

dogfight_flakgettimescale(param_00) {
  return 1 + 6 - param_00 / 6;
}

dogfight_flakisvalidtarget(param_00) {
  var_01 = common_scripts\utility::func_562E(param_00.occupied_player.hasdiedtoflak);
  var_02 = gettime() - param_00.occupied_player.var_5BE2 >= 3500;
  return !var_01 && var_02;
}

dogfight_flakgetzonescale(param_00, param_01) {
  var_02 = 1;
  if(self.var_0116[2] > param_01) {
    var_02 = 1;
  } else if(self.var_0116[2] < param_00) {
    var_02 = 0;
  } else {
    var_02 = self.var_0116[2] - param_00 / param_01 - param_00;
  }

  return var_02;
}

dogfight_flakselectradomtarget(param_00, param_01, param_02, param_03) {
  var_04 = undefined;
  if(getdvarint("dogfightFlakDamageWeightEnabled", 1)) {
    var_05 = randomfloat(1);
    var_06 = common_scripts\utility::func_0F92(param_00);
    foreach(var_08 in var_06) {
      if(!param_03 || dogfight_flakisvalidtarget(var_08)) {
        var_09 = var_08 dogfight_flakgetzonescale(param_01, param_02);
        if(var_05 < var_09) {
          var_04 = var_08;
          break;
        }
      }
    }
  } else {
    var_04 = common_scripts\utility::func_7A33(param_00);
  }

  return var_04;
}

dogfight_atmosphereflak(param_00, param_01) {
  level endon("flakGunsDisabled");
  level.var_3CE1 = 0;
  for(;;) {
    if(level.var_3CE1 < 30) {
      var_02 = undefined;
      var_03 = getflaktargets();
      if(var_03.size > 0) {
        var_02 = dogfight_flakselectradomtarget(var_03, param_00, param_01, 0);
      }

      if(isDefined(var_02)) {
        if(getdvarint("dogfightFlakDamageWeightEnabled", 1)) {
          var_04 = getdvarfloat("dogfightFlakAtmosphereOffsetYaw", 20);
          var_05 = getdvarfloat("dogfightFlakAtmosphereMinOffsetXY", 1300);
          var_06 = getdvarfloat("dogfightFlakAtmosphereMaxOffsetXY", 1800);
          var_07 = getdvarfloat("dogfightFlakAtmosphereMinOffsetZ", 100);
          var_08 = getdvarfloat("dogfightFlakAtmosphereMaxOffsetZ", 400);
          var_09 = dogfight_flakgetzonescale(param_00, param_01);
          var_0A = dogfight_flakgetnearfighterexplosionlocation(var_02, var_09, var_05, var_06, var_07, var_08, var_04);
        } else {
          var_0A = (randomfloatrange(-500, 500) + var_03.var_0116[0], randomfloatrange(-500, 500) + var_03.var_0116[1], randomfloatrange(-500, 500) + var_03.var_0116[2]);
        }
      } else {
        var_0B = maps\mp\gametypes\dogfight_common::get_dogfight_boundary_center(0);
        if(getdvarint("dogfightFlakDamageWeightEnabled", 1)) {
          var_0C = maps\mp\gametypes\dogfight_common::get_dogfight_boundary_height(0);
          var_0D = var_0B[2] + var_0C * 0.5;
          var_0E = var_0D - param_00;
          var_0A = (randomfloatrange(-18000, 18000) + var_0B[0], randomfloatrange(-18000, 18000) + var_0B[1], param_00 + randomfloat(1) * var_0E);
        } else {
          var_0A = (randomfloatrange(-18000, 18000) + var_0B[0], randomfloatrange(-18000, 18000) + var_0B[1], randomfloatrange(-8000, 8000) + var_0B[2]);
        }
      }

      level.var_3CE1++;
      thread dogfight_flakexplosioneffects(var_0B, 1);
      var_0F = dogfight_flakgettimescale(var_0A.size);
      wait(randomfloatrange(0.1 * var_0F, 0.3 * var_0F));
      continue;
    }

    wait 0.05;
  }
}

dogfight_flakexplosioneffects(param_00, param_01) {
  var_02 = common_scripts\utility::func_8FFC();
  var_02.var_0116 = param_00;
  var_02 method_805B();
  wait 0.05;
  playFXOnTag(common_scripts\utility::func_44F5("flak_gun_explosion"), var_02, "tag_origin");
  lib_0378::func_8D74("ks_flak_cannon_explo", param_00);
  wait(4.5);
  var_02 delete();
  if(common_scripts\utility::func_562E(param_01)) {
    level.var_3CE1--;
  }
}

dogfight_flakgetnearfighterexplosionlocation(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  var_07 = (0, 0, 1);
  var_08 = anglesToForward(param_00.var_001D);
  if(vectordot(var_08, var_07) <= 0) {
    var_08 = (var_08[0], var_08[1], 0);
  }

  var_09 = (0, randomfloatrange(-1 * param_06, param_06), 0);
  var_08 = rotatevector(var_08, var_09);
  var_0A = randomfloatrange(param_02, param_03);
  var_08 = (var_08[0] * var_0A, var_08[1] * var_0A, var_08[2] * var_0A);
  var_0B = param_04 + 1 - param_01 * param_05 - param_04;
  var_0C = (var_08[0] + param_00.var_0116[0], var_08[1] + param_00.var_0116[1], var_08[2] + var_0B + param_00.var_0116[2]);
  return var_0C;
}

dogfight_flakrundamage(param_00, param_01) {
  level endon("flakGunsDisabled");
  level endon("game_ended");
  for(;;) {
    var_02 = getflaktargets();
    var_03 = dogfight_flakselectradomtarget(var_02, param_00, param_01, 1);
    if(isDefined(var_03)) {
      var_04 = dogfight_flakgetzonescale(param_00, param_01);
      if(getdvarint("dogfightFlakDamageWeightEnabled", 1)) {
        var_05 = getdvarfloat("dogfightFlakDamageOffsetYaw", 15);
        var_06 = getdvarfloat("dogfightFlakDamageMinOffsetXY", 600);
        var_07 = getdvarfloat("dogfightFlakDamageMaxOffsetXY", 800);
        var_08 = getdvarfloat("dogfightFlakDamageMinOffsetZ", 50);
        var_09 = getdvarfloat("dogfightFlakDamageMaxOffsetZ", 75);
        var_0A = dogfight_flakgetnearfighterexplosionlocation(var_03, var_04, var_06, var_07, var_08, var_09, var_05);
      } else {
        var_0A = (randomfloatrange(-100, 100) + var_0D.var_0116[0], randomfloatrange(-100, 100) + var_0D.var_0116[1], randomfloatrange(-100, 100) + var_0D.var_0116[2]);
      }

      thread dogfight_flakexplosioneffects(var_0A, 0);
      var_0B = 0;
      if(function_01EF(var_03.occupied_player)) {
        var_0B = randomfloatrange(450, 500) * 10;
      } else {
        var_0B = randomfloatrange(75, 110) * 10;
      }

      var_0C = 1;
      if(getdvarint("dogfightFlakDamageScaleEnabled", 1)) {
        var_0C = var_04;
      }

      var_0B = var_0B * var_0C;
      var_03 dodamage(var_0B, var_0A, self, undefined, "MOD_UNKNOWN", "killstreak_flak_gun_raids");
      if(1) {
        var_03.occupied_player playrumbleonentity("artillery_rumble");
        earthquake(0.7, 0.5, var_03.var_0116, 800, var_03.occupied_player);
      }
    }

    var_0B = dogfight_flakgettimescale(var_04.size);
    wait(randomfloatrange(0.5 * var_0B, 1.5 * var_0B));
  }
}

destroy_remaining_agents() {
  var_00 = getflaktargets();
  foreach(var_02 in var_00) {
    if(function_01EF(var_02.occupied_player)) {
      var_02 dodamage(randomfloatrange(450, 500) * 10, var_02.var_0116, self, undefined, "MOD_UNKNOWN", "killstreak_flak_gun_raids");
    }
  }
}

getflaktargets() {
  var_00 = [];
  foreach(var_02 in level.pp_array) {
    if(level.var_984D) {
      if(isDefined(var_02.var_01A7) && var_02.var_01A7 == common_scripts\utility::func_416F(self.var_01A7)) {
        var_00 = common_scripts\utility::func_0F6F(var_00, var_02);
      }

      continue;
    }

    if(isDefined(var_02.occupied_player) && self != var_02.occupied_player) {
      var_00 = common_scripts\utility::func_0F6F(var_00, var_02);
    }
  }

  return var_00;
}

clear_flak_death_flags() {
  var_00 = getflaktargets();
  foreach(var_02 in var_00) {
    var_02.occupied_player.hasdiedtoflak = undefined;
  }
}