/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\gametypes\dogfight_scorestreaks.gsc
***************************************************************/

init_dogfight_killstreaks() {
  level thread scorestreakdvarhostmigration();
  level._id_5A61["dogfight_flak"] = ::tryusedogfightflak;
  level._id_5A7D["killstreak_flak_gun_raids"] = "dogfight_flak";
}

scorestreakdvarhostmigration() {
  level endon("game_ended");
  setDvar("scorestreak_enabled_dogfight_flak", 1);

  for(;;) {
    level waittill("host_migration_begin");
    setDvar("scorestreak_enabled_dogfight_flak", 1);
    maps\mp\gametypes\_hostmigration::_id_A782();
  }
}

tryusedogfightflak(var_0) {
  if(level.flak_in_progress) {
    self iprintlnbold(&"KILLSTREAKS_RAIDS_TOO_MUCH_FLAK");
    return 0;
  }

  level.flak_in_progress = 1;
  level.flak_scorestreak_id++;
  level._id_9854[maps\mp\_utility::getotherteam(self.team)] = 1;
  level thread _id_0528::_id_A0E0();
  var_1 = undefined;
  var_2 = undefined;

  if(getdvarint("dogfightFlakDamageScaleEnabled", 1) || getdvarint("dogfightFlakDamageWeightEnabled", 1)) {
    var_3 = common_scripts\utility::_id_46B5("dogfight_flak_zone", "targetname");
    var_1 = var_3.origin[2];
    var_2 = var_3.origin[2] + var_3._id_00BD;
  }

  thread dogfight_atmosphereflak(var_1, var_2);
  thread dogfight_flakrundamage(var_1, var_2);
  thread dogfight_flak_timer();
  return 1;
}

dogfight_flak_timer() {
  wait(getdvarfloat("dogfightFlakDuration", 15));
  level notify("flakGunsDisabled");
  destroy_remaining_agents();
  level.flak_in_progress = 0;
  level._id_9854[maps\mp\_utility::getotherteam(self.team)] = 0;
  level thread _id_0528::_id_A0E0();
  clear_flak_death_flags();
}

fighter_scorestreak_watcher(var_0) {
  level endon("game_ended");

  if(isPlayer(var_0) && !isbot(var_0)) {
    var_0 notifyonplayercommand("activate_fighter_scorestreak", "+actionslot 4");

    if(!level._id_258F)
      var_0 notifyonplayercommand("activate_fighter_scorestreak_keyboard", "+actionslot 5");
  }

  for(;;) {
    var_1 = var_0 common_scripts\utility::waittill_any_return("activate_fighter_scorestreak", "activate_fighter_scorestreak_keyboard");

    if(isDefined(var_1)) {
      if(var_1 == "activate_fighter_scorestreak" && !var_0 common_scripts\utility::_id_55E0())
        continue;
      else if(var_1 == "activate_fighter_scorestreak_keyboard" && var_0 common_scripts\utility::_id_55E0()) {
        continue;
      }
      if(isDefined(var_0._id_5A69))
        var_0 _id_051E::_id_5A7A();
    }

    waitframe();
  }
}

dogfight_flakgettimescale(var_0) {
  return 1.0 + (6 - var_0) / 6;
}

dogfight_flakisvalidtarget(var_0) {
  var_1 = common_scripts\utility::_id_562E(var_0.occupied_player.hasdiedtoflak);
  var_2 = gettime() - var_0.occupied_player._id_5BE2 >= 3500;
  return !var_1 && var_2;
}

dogfight_flakgetzonescale(var_0, var_1) {
  var_2 = 1.0;

  if(self.origin[2] > var_1)
    var_2 = 1.0;
  else if(self.origin[2] < var_0)
    var_2 = 0.0;
  else
    var_2 = (self.origin[2] - var_0) / (var_1 - var_0);

  return var_2;
}

dogfight_flakselectradomtarget(var_0, var_1, var_2, var_3) {
  var_4 = undefined;

  if(getdvarint("dogfightFlakDamageWeightEnabled", 1)) {
    var_5 = _randomfloat(1.0);
    var_6 = common_scripts\utility::array_randomize(var_0);

    foreach(var_8 in var_6) {
      if(!var_3 || dogfight_flakisvalidtarget(var_8)) {
        var_9 = var_8 dogfight_flakgetzonescale(var_1, var_2);

        if(var_5 < var_9) {
          var_4 = var_8;
          break;
        }
      }
    }
  } else
    var_4 = common_scripts\utility::random(var_0);

  return var_4;
}

dogfight_atmosphereflak(var_0, var_1) {
  level endon("flakGunsDisabled");
  level._id_3CE1 = 0;

  for(;;) {
    if(level._id_3CE1 < 30) {
      var_2 = undefined;
      var_3 = getflaktargets();

      if(var_3.size > 0)
        var_2 = dogfight_flakselectradomtarget(var_3, var_0, var_1, 0);

      if(isDefined(var_2)) {
        if(getdvarint("dogfightFlakDamageWeightEnabled", 1)) {
          var_4 = getdvarfloat("dogfightFlakAtmosphereOffsetYaw", 20.0);
          var_5 = getdvarfloat("dogfightFlakAtmosphereMinOffsetXY", 1300);
          var_6 = getdvarfloat("dogfightFlakAtmosphereMaxOffsetXY", 1800);
          var_7 = getdvarfloat("dogfightFlakAtmosphereMinOffsetZ", 100);
          var_8 = getdvarfloat("dogfightFlakAtmosphereMaxOffsetZ", 400);
          var_9 = dogfight_flakgetzonescale(var_0, var_1);
          var_10 = dogfight_flakgetnearfighterexplosionlocation(var_2, var_9, var_5, var_6, var_7, var_8, var_4);
        } else
          var_10 = (_randomfloatrange(-500, 500) + var_2.origin[0], _randomfloatrange(-500, 500) + var_2.origin[1], _randomfloatrange(-500, 500) + var_2.origin[2]);
      } else {
        var_11 = maps\mp\gametypes\dogfight_common::get_dogfight_boundary_center(0);

        if(getdvarint("dogfightFlakDamageWeightEnabled", 1)) {
          var_12 = maps\mp\gametypes\dogfight_common::get_dogfight_boundary_height(0);
          var_13 = var_11[2] + var_12 * 0.5;
          var_14 = var_13 - var_0;
          var_10 = (_randomfloatrange(-18000, 18000) + var_11[0], _randomfloatrange(-18000, 18000) + var_11[1], var_0 + _randomfloat(1.0) * var_14);
        } else
          var_10 = (_randomfloatrange(-18000, 18000) + var_11[0], _randomfloatrange(-18000, 18000) + var_11[1], _randomfloatrange(-8000, 8000) + var_11[2]);
      }

      level._id_3CE1++;
      thread dogfight_flakexplosioneffects(var_10, 1);
      var_15 = dogfight_flakgettimescale(var_3.size);
      wait(_randomfloatrange(0.1 * var_15, 0.3 * var_15));
      continue;
    }

    waitframe();
  }
}

dogfight_flakexplosioneffects(var_0, var_1) {
  var_2 = common_scripts\utility::_id_8FFC();
  var_2.origin = var_0;
  var_2 show();
  waitframe();
  _playfxontag(common_scripts\utility::_id_44F5("flak_gun_explosion"), var_2, "tag_origin");
  _id_0378::_id_8D74("ks_flak_cannon_explo", var_0);
  wait 4.5;
  var_2 delete();

  if(common_scripts\utility::_id_562E(var_1))
    level._id_3CE1--;
}

dogfight_flakgetnearfighterexplosionlocation(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = (0, 0, 1);
  var_8 = anglesToForward(var_0.angles);

  if(vectordot(var_8, var_7) <= 0)
    var_8 = (var_8[0], var_8[1], 0);

  var_9 = (0, _randomfloatrange(-1 * var_6, var_6), 0);
  var_8 = _rotatevector(var_8, var_9);
  var_10 = _randomfloatrange(var_2, var_3);
  var_8 = (var_8[0] * var_10, var_8[1] * var_10, var_8[2] * var_10);
  var_11 = var_4 + (1.0 - var_1) * (var_5 - var_4);
  var_12 = (var_8[0] + var_0.origin[0], var_8[1] + var_0.origin[1], var_8[2] + var_11 + var_0.origin[2]);
  return var_12;
}

dogfight_flakrundamage(var_0, var_1) {
  level endon("flakGunsDisabled");
  level endon("game_ended");

  for(;;) {
    var_2 = getflaktargets();
    var_3 = dogfight_flakselectradomtarget(var_2, var_0, var_1, 1);

    if(isDefined(var_3)) {
      var_4 = dogfight_flakgetzonescale(var_0, var_1);

      if(getdvarint("dogfightFlakDamageWeightEnabled", 1)) {
        var_5 = getdvarfloat("dogfightFlakDamageOffsetYaw", 15.0);
        var_6 = getdvarfloat("dogfightFlakDamageMinOffsetXY", 600);
        var_7 = getdvarfloat("dogfightFlakDamageMaxOffsetXY", 800);
        var_8 = getdvarfloat("dogfightFlakDamageMinOffsetZ", 50);
        var_9 = getdvarfloat("dogfightFlakDamageMaxOffsetZ", 75);
        var_10 = dogfight_flakgetnearfighterexplosionlocation(var_3, var_4, var_6, var_7, var_8, var_9, var_5);
      } else
        var_10 = (_randomfloatrange(-100, 100) + var_3.origin[0], _randomfloatrange(-100, 100) + var_3.origin[1], _randomfloatrange(-100, 100) + var_3.origin[2]);

      thread dogfight_flakexplosioneffects(var_10, 0);
      var_11 = 0;

      if(_isagent(var_3.occupied_player))
        var_11 = _randomfloatrange(450, 500) * 10;
      else
        var_11 = _randomfloatrange(75, 110) * 10;

      var_12 = 1.0;

      if(getdvarint("dogfightFlakDamageScaleEnabled", 1))
        var_12 = var_4;

      var_11 = var_11 * var_12;
      var_3 dodamage(var_11, var_10, self, undefined, "MOD_UNKNOWN", "killstreak_flak_gun_raids");

      if(1) {
        var_3.occupied_player playrumbleonentity("artillery_rumble");
        _earthquake(0.7, 0.5, var_3.origin, 800, var_3.occupied_player);
      }
    }

    var_13 = dogfight_flakgettimescale(var_2.size);
    wait(_randomfloatrange(0.5 * var_13, 1.5 * var_13));
  }
}

destroy_remaining_agents() {
  var_0 = getflaktargets();

  foreach(var_2 in var_0) {
    if(_isagent(var_2.occupied_player))
      var_2 dodamage(_randomfloatrange(450, 500) * 10, var_2.origin, self, undefined, "MOD_UNKNOWN", "killstreak_flak_gun_raids");
  }
}

getflaktargets() {
  var_0 = [];

  foreach(var_2 in level.pp_array) {
    if(level.teambased) {
      if(isDefined(var_2.team) && var_2.team == common_scripts\utility::_id_416F(self.team))
        var_0 = common_scripts\utility::_id_0F6F(var_0, var_2);

      continue;
    }

    if(isDefined(var_2.occupied_player) && self != var_2.occupied_player)
      var_0 = common_scripts\utility::_id_0F6F(var_0, var_2);
  }

  return var_0;
}

clear_flak_death_flags() {
  var_0 = getflaktargets();

  foreach(var_2 in var_0)
  var_2.occupied_player.hasdiedtoflak = undefined;
}