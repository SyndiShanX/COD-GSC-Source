/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1370.gsc
**************************************/

init() {
  level.zone_data = spawnStruct();
  level.zone_data._id_9054 = ["zombie_spawner", "zombie_sky_spawner"];
  level.zone_data.zones = [];
  level.zone_data._id_2914 = [];
  level.zone_data._id_290A = [];
  level.zone_data.spawnfunc = ::_id_1E4E;
  level.zone_data.spawn_points_update_requested = 0;
  level._id_1F1D = ::_id_1F66;
  level._id_4200 = ::getlocationzone;
  level._id_43F2 = ::getzoneconnectionlength;
  level._id_8C96 = undefined;
  level._id_43F4 = ::getzoneinfectedconnectionlength;
  level._id_38D1 = undefined;
  level._id_7D20 = undefined;
  level._id_38D2 = [];
  level._id_7D21 = [];
}

_id_6B3F() {
  if(!isDefined(level.zone_data)) {
    return;
  }
  foreach(var_1 in level.zone_data.zones) {
    var_2 = [];
    var_1.entities = [];
    var_1.players = [];
    var_1.zombies = [];
    var_1 _id_ACA1();

    for(var_3 = 0; var_3 < var_1.zombie_spawners.size; var_3++) {
      var_4 = var_1.zombie_spawners[var_3];

      if(_id_0547::_id_AC0F(var_4, var_1.zone_name + " spawner", undefined, var_1.zone_name)) {
        var_2[var_2.size] = var_4;
      }
    }

    var_1.zombie_spawners = var_2;
  }
}

_id_3155(var_0) {
  var_1 = isDefined(level.zone_data.zones[var_0]);
  return var_1;
}

_id_0F4F(var_0) {
  foreach(var_2 in level.zone_data.zones) {
    if(common_scripts\utility::_id_562E(var_0)) {
      if(isDefined(level.zmb_registered_quest_zones) && common_scripts\utility::_id_0F79(level.zmb_registered_quest_zones, var_2.zone_name)) {
        continue;
      }
    }

    if(!var_2.is_enabled) {
      return 0;
    }
  }

  return 1;
}

iszoneenabled(var_0) {
  return level.zone_data.zones[var_0].is_enabled;
}

_id_1F66(var_0) {
  return level.zone_data.zones[var_0]._id_5614;
}

_id_5780(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(var_1 && !iszoneenabled(var_0)) {
    return 0;
  }

  foreach(var_3 in level.players) {
    if(_id_7413(var_3, var_0, var_1)) {
      return 1;
    }
  }

  return 0;
}

updateconnectiondistances() {
  level endon("game_ended");
  level notify("updating_connection_distances");
  level endon("updating_connection_distances");
  level.zone_data.connectionmap = [];

  foreach(var_1 in level.zone_data.zones) {
    foreach(var_3 in level.zone_data.zones) {
      if(var_1.zone_name == var_3.zone_name) {
        continue;
      }
      if(isDefined(level.zone_data.connectionmap[var_1.zone_name]) && isDefined(level.zone_data.connectionmap[var_1.zone_name][var_3.zone_name])) {
        continue;
      }
      getzoneconnectionlength(var_1.zone_name, var_3.zone_name);
      waitframe();
    }
  }

  if(isDefined(level.zone_is_contaminated_func)) {
    level.zone_data.infectedconnectionmap = [];

    foreach(var_1 in level.zone_data.zones) {
      foreach(var_3 in level.zone_data.zones) {
        if(var_1.zone_name == var_3.zone_name) {
          continue;
        }
        if(isDefined(level.zone_data.infectedconnectionmap[var_1.zone_name]) && isDefined(level.zone_data.infectedconnectionmap[var_1.zone_name][var_3.zone_name])) {
          continue;
        }
        getzoneinfectedconnectionlength(var_1.zone_name, var_3.zone_name);
        waitframe();
      }
    }
  }
}

registerconnectiondistance(var_0, var_1, var_2) {
  level.zone_data.connectionmap[var_0][var_1] = var_2;
  level.zone_data.connectionmap[var_1][var_0] = var_2;
}

getzoneconnectionlength(var_0, var_1) {
  if(var_0 == var_1) {
    return 0;
  }

  if(!isDefined(level.zone_data.connectionmap)) {
    return -1;
  }

  if(isDefined(level.zone_data.connectionmap[var_0]) && isDefined(level.zone_data.connectionmap[var_0][var_1])) {
    return level.zone_data.connectionmap[var_0][var_1];
  }

  var_2[0]["zone"] = var_0;
  var_2[0]["distance"] = 0;

  while(var_2.size > 0) {
    var_3 = level.zone_data.zones[var_2[0]["zone"]];
    var_4 = var_2[0]["distance"];
    var_2 = common_scripts\utility::_id_0F9A(var_2, 0);
    var_5[var_3.zone_name] = 1;

    foreach(var_7 in var_3._id_0A01) {
      if(isDefined(var_5[var_7.zone_name])) {
        continue;
      }
      if(var_7.is_connected) {
        var_8 = var_4 + 1;

        if(var_7.zone_name == var_1) {
          registerconnectiondistance(var_0, var_1, var_8);
          return var_8;
        }

        var_9 = -1;
        var_10 = -1;

        if(var_2.size == 0) {
          var_9 = 0;
        }

        for(var_11 = 0; var_11 < var_2.size; var_11++) {
          var_12 = var_2[var_11]["distance"] >= var_8;

          if(var_12 && var_9 < 0) {
            var_9 = var_11;
          }

          if(var_2[var_11]["zone"] == var_7.zone_name) {
            if(var_12) {
              var_10 = var_11;
            }

            break;
          }
        }

        if(var_10 >= 0) {
          var_2 = common_scripts\utility::_id_0F9A(var_2, var_10);
        }

        if(var_11 == var_2.size && var_9 < 0) {
          var_9 = var_2.size;
        }

        if(var_9 >= 0) {
          var_13["zone"] = var_7.zone_name;
          var_13["distance"] = var_8;
          var_2 = common_scripts\utility::_id_0F86(var_2, var_13, var_9);
        }
      }
    }
  }

  return -1;
}

registerinfectedconnectiondistance(var_0, var_1, var_2) {
  level.zone_data.infectedconnectionmap[var_0][var_1] = var_2;
  level.zone_data.infectedconnectionmap[var_1][var_0] = var_2;
}

getzoneinfectedconnectionlength(var_0, var_1) {
  if(var_0 == var_1) {
    return 0;
  }

  if(!isDefined(level.zone_data.connectionmap)) {
    return -1;
  }

  if(isDefined(level.zone_data.infectedconnectionmap[var_0]) && isDefined(level.zone_data.infectedconnectionmap[var_0][var_1])) {
    return level.zone_data.infectedconnectionmap[var_0][var_1];
  }

  var_2[0]["zone"] = var_0;
  var_2[0]["distance"] = 0;

  while(var_2.size > 0) {
    var_3 = level.zone_data.zones[var_2[0]["zone"]];
    var_4 = var_2[0]["distance"];
    var_2 = common_scripts\utility::_id_0F9A(var_2, 0);
    var_5[var_3.zone_name] = 1;

    foreach(var_7 in var_3._id_0A01) {
      if(isDefined(var_5[var_7.zone_name])) {
        continue;
      }
      if([[level.zone_is_contaminated_func]](var_7.zone_name)) {
        continue;
      }
      if(var_7.is_connected) {
        var_8 = var_4 + 1;

        if(var_7.zone_name == var_1) {
          registerinfectedconnectiondistance(var_0, var_1, var_8);
          return var_8;
        }

        var_9 = -1;
        var_10 = -1;

        if(var_2.size == 0) {
          var_9 = 0;
        }

        for(var_11 = 0; var_11 < var_2.size; var_11++) {
          var_12 = var_2[var_11]["distance"] >= var_8;

          if(var_12 && var_9 < 0) {
            var_9 = var_11;
          }

          if(var_2[var_11]["zone"] == var_7.zone_name) {
            if(var_12) {
              var_10 = var_11;
            }

            break;
          }
        }

        if(var_10 >= 0) {
          var_2 = common_scripts\utility::_id_0F9A(var_2, var_10);
        }

        if(var_11 == var_2.size && var_9 < 0) {
          var_9 = var_2.size;
        }

        if(var_9 >= 0) {
          var_13["zone"] = var_7.zone_name;
          var_13["distance"] = var_8;
          var_2 = common_scripts\utility::_id_0F86(var_2, var_13, var_9);
        }
      }
    }
  }

  return -1;
}

_id_462D() {
  if(self.sessionstate == "spectator" || self.sessionstate == "intermission") {
    return undefined;
  }

  updatecurrentzones();
  var_0 = getarraykeys(self.currentzones);

  if(var_0.size > 0) {
    return var_0[0];
  }

  return undefined;
}

getagentzone() {
  updatecurrentzones();
  var_0 = getarraykeys(self.currentzones);

  if(var_0.size > 0) {
    return var_0[0];
  }

  return undefined;
}

getcurrentplayeroccupiedzones(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  var_1 = _id_4483(var_0);
  var_2 = [];

  foreach(var_4 in var_1) {
    var_2[var_2.size] = var_4.zone_name;
  }

  return var_2;
}

_id_4483(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  var_1 = [];
  var_2 = [];

  foreach(var_4 in level.players) {
    var_4 updatecurrentzones();

    foreach(var_7, var_6 in var_4.currentzones) {
      if(!isDefined(var_1[var_7])) {
        if(!var_0 || iszoneenabled(var_7)) {
          var_1[var_7] = 1;
          var_2[var_2.size] = level.zone_data.zones[var_7];
          continue;
        }

        var_1[var_7] = 0;
      }
    }
  }

  return var_2;
}

_id_5860(var_0) {
  var_0 updatecurrentzones();

  if(!isDefined(var_0.currentzones)) {
    return 0;
  }

  return var_0.currentzones.size > 0;
}

_id_5861(var_0) {
  var_0 updatecurrentzones();

  if(!isDefined(var_0.currentzones)) {
    return 0;
  }

  foreach(var_2 in var_0.currentzones) {
    if(iszoneenabled(var_2)) {
      return 1;
    }
  }

  return 0;
}

getzoneclosesttopoint(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = undefined;

  foreach(var_4 in level.zone_data.zones) {
    if(var_1 && !iszoneenabled(var_4.zone_name)) {
      continue;
    }
    foreach(var_6 in var_4.volumes) {
      if(_ispointinvolume(var_0, var_6)) {
        return var_4.zone_name;
      }
    }

    if(!isDefined(var_2)) {
      var_2 = var_4;
      continue;
    }

    if(distance(var_0, var_4._id_74DC) < distance(var_0, var_2._id_74DC)) {
      var_2 = var_4;
    }
  }

  return var_2.zone_name;
}

ispathnodeinanyzone(var_0) {
  foreach(var_2 in level.zone_data.zones) {
    foreach(var_4 in var_2.volumes) {
      if(_ispointinvolume(var_0.origin, var_4)) {
        return 1;
      }

      if(_ispointinvolume(var_0.origin + (0, 0, 20), var_4)) {
        return 1;
      }
    }
  }

  return 0;
}

ispathnodeinenabledzone(var_0) {
  foreach(var_2 in level.zone_data.zones) {
    if(!iszoneenabled(var_2.zone_name)) {
      continue;
    }
    foreach(var_4 in var_2.volumes) {
      if(_ispointinvolume(var_0.origin, var_4)) {
        return 1;
      }

      if(_ispointinvolume(var_0.origin + (0, 0, 20), var_4)) {
        return 1;
      }
    }
  }

  return 0;
}

ispointinanyzone(var_0, var_1) {
  var_2 = ispointinanyzonereturn(var_0, var_1);
  return isDefined(var_2);
}

ispointinanyzonereturn(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  foreach(var_3 in level.zone_data.zones) {
    if(var_1 && !iszoneenabled(var_3.zone_name)) {
      continue;
    }
    foreach(var_5 in var_3.volumes) {
      if(_ispointinvolume(var_0, var_5)) {
        return var_3.zone_name;
      }
    }
  }

  return;
}

getlocationzone(var_0) {
  if(isDefined(level.zone_data)) {
    foreach(var_2 in level.zone_data.zones) {
      foreach(var_4 in var_2.volumes) {
        if(_ispointinvolume(var_0, var_4)) {
          return var_2.zone_name;
        }

        if(_ispointinvolume(var_0 + (0, 0, 20), var_4)) {
          return var_2.zone_name;
        }
      }
    }
  }

  return undefined;
}

_id_0F14(var_0) {
  var_1 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");

  if(var_1.size == 0) {
    return 0;
  }

  var_2 = level.zone_data.zones[var_0];

  foreach(var_4 in var_1) {
    var_4 updatecurrentzones();
  }

  var_6 = var_2 zombies_in_zone_internal();
  return var_6.size > 0;
}

zombies_in_zone_internal() {
  var_0 = self;
  var_1 = [];

  foreach(var_4, var_3 in var_0.zombies) {
    if(isDefined(var_3) && isalive(var_3)) {
      var_1[var_1.size] = var_3;
    }
  }

  var_0.zombies = var_1;
  return var_1;
}

players_in_zone_internal() {
  var_0 = self;
  var_1 = [];

  foreach(var_4, var_3 in var_0.players) {
    if(isDefined(var_3) && isPlayer(var_3) && var_3.sessionstate != "spectator") {
      var_1[var_1.size] = var_3;
    }
  }

  var_0.players = var_1;
  return var_1;
}

updatecurrentzones() {
  var_0 = self;

  if(isDefined(var_0.lastzoneupdateorigin)) {
    if(var_0.origin == var_0.lastzoneupdateorigin) {
      return;
    }
  }

  var_0.lastzoneupdateorigin = var_0.origin;
  var_1 = var_0.currentzones;
  var_0.currentzones = [];
  var_2 = isPlayer(var_0) && var_0.sessionstate == "spectator";
  var_3 = _isagent(var_0) && !isalive(var_0);

  if(!var_2 && !var_3) {
    foreach(var_9, var_5 in level.zone_data.zones) {
      foreach(var_7 in var_5.volumes) {
        if(var_0 istouching(var_7)) {
          var_0.currentzones[var_9] = 1;
          break;
        }
      }
    }
  }

  if(isDefined(var_1)) {
    var_10 = getarraykeys(var_1);

    foreach(var_9 in var_10) {
      if(!isDefined(var_0.currentzones[var_9])) {
        var_0 thread onentityleftzone(var_9);
      }
    }
  } else
    var_1 = [];

  var_13 = getarraykeys(var_0.currentzones);

  foreach(var_9 in var_13) {
    if(!isDefined(var_1) || !isDefined(var_1[var_9])) {
      var_0 thread onentityfoundinzone(var_9);
    }
  }
}

onentityfoundinzone(var_0) {
  var_1 = self;
  var_2 = level.zone_data.zones[var_0];
  var_3 = var_1 getentitynumber();
  var_2.entities[var_3] = var_1;

  if(isPlayer(var_1)) {
    var_2.players[var_3] = var_1;
  }

  if(isDefined(var_1._id_000A) && var_1._id_000A != level.playerteam) {
    var_2.zombies[var_3] = var_1;
  }
}

onentityleftzone(var_0) {
  var_1 = self;
  var_2 = level.zone_data.zones[var_0];
  var_3 = var_1 getentitynumber();
  var_2.entities[var_3] = undefined;

  if(isPlayer(var_1)) {
    var_2.players[var_3] = undefined;
  }

  if(isDefined(var_1._id_000A) && var_1._id_000A != level.playerteam) {
    var_2.zombies[var_3] = undefined;
  }
}

_id_45BF(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(var_1 && !iszoneenabled(var_0)) {
    return 0;
  }

  var_2 = level.zone_data.zones[var_0];
  var_3 = 0;

  foreach(var_5 in level.players) {
    if(_id_7413(var_5, var_0, var_1)) {
      var_3++;
    }
  }

  return var_3;
}

_id_4626(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = [];

  if(var_2 && !iszoneenabled(var_0)) {
    return var_3;
  }

  var_4 = level.zone_data.zones[var_0];
  var_5 = [var_0];

  if(var_1) {
    foreach(var_7 in var_4._id_0A01) {
      if(!var_2 || iszoneenabled(var_7.zone_name)) {
        var_5[var_0.size] = var_7.zone_name;
      }
    }
  }

  foreach(var_10 in level.players) {
    foreach(var_0 in var_5) {
      if(_id_7413(var_10, var_0, var_2)) {
        var_3[var_3.size] = var_10;
      }
    }
  }

  return var_3;
}

_id_7413(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(var_0.sessionstate == "spectator") {
    return 0;
  }

  var_0 updatecurrentzones();

  if(var_2 && !iszoneenabled(var_1)) {
    return 0;
  }

  return common_scripts\utility::_id_562E(var_0.currentzones[var_1]);
}

_id_AC29(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(var_2 && !iszoneenabled(var_1)) {
    return 0;
  }

  var_0 updatecurrentzones();
  return common_scripts\utility::_id_562E(var_0.currentzones[var_1]);
}

_id_45C3(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(var_1 && !iszoneenabled(var_0)) {
    return 0;
  }

  var_2 = _id_0547::_id_408F();

  if(var_2.size == 0) {
    return 0;
  }

  var_3 = level.zone_data.zones[var_0];

  foreach(var_5 in var_2) {
    var_5 updatecurrentzones();
  }

  return var_3.zombies.size;
}

_id_530A(var_0, var_1, var_2) {
  if(isDefined(level.zone_data.zones[var_0])) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_3 = spawnStruct();
  var_3._id_0A01 = [];
  var_3._id_55CA = 0;
  var_3.is_enabled = var_1;
  var_3._id_5614 = var_1;
  var_3._id_552B = 0;
  var_3.zone_name = var_0;

  if(isDefined(var_2)) {
    var_3._id_5614 = var_2;
  }

  var_3.volumes = [];
  var_4 = getEntArray(var_0, "targetname");

  foreach(var_6 in var_4) {
    if(var_6.classname == "info_volume") {
      var_3.volumes[var_3.volumes.size] = var_6;
    }
  }

  common_scripts\utility::flag_init(var_3.zone_name);

  if(var_1) {
    common_scripts\utility::flag_set(var_3.zone_name);
  }

  level.zone_data.zones[var_0] = var_3;
  var_3._id_75FF = getpowerswitchinzone(var_0);
  var_8 = _id_4694(var_0);
  var_3.zombie_spawners = filterspawnersfromlistbytype(var_8, "zombie_spawner");

  if(!isDefined(level.zombies_spawners_zombie)) {
    level.zombies_spawners_zombie = [];
  }

  var_9 = filterspawnersfromlistbytype(var_8, "zombie_sky_spawner");
  var_3.zombie_spawners = common_scripts\utility::_id_0F73(var_3.zombie_spawners, var_9);
  var_3._id_9050 = [];

  foreach(var_11 in var_3.zombie_spawners) {
    _id_5374(var_11);

    if(isDefined(var_11.getnegotiationnextnode)) {
      var_3._id_9050[var_11.getnegotiationnextnode] = 1;
    }
  }

  level.zombies_spawners_zombie = common_scripts\utility::_id_0F73(level.zombies_spawners_zombie, var_3.zombie_spawners);

  if(_id_0547::civiliansareenabled()) {
    var_3.civilian_extracts = filterspawnersfromlistbytype(var_8, "civilian_extract");
    var_3.civilian_spawners = filterspawnersfromlistbytype(var_8, "civilian_spawner");

    if(!isDefined(level.zombies_spawners_civilians)) {
      level.zombies_spawners_civilians = [];
    }

    level.zombies_spawners_civilians = common_scripts\utility::_id_0F73(level.zombies_spawners_civilians, var_3.civilian_spawners);
  }
}

_id_5374(var_0) {
  switch (var_0._id_0165) {
    case "zombie_sky_spawner":
      var_0._id_8C95 = 1;
    case "zombie_spawner":
      if(isDefined(var_0.getnegotiationnextnode) && !common_scripts\utility::flag_exist(var_0.getnegotiationnextnode)) {
        common_scripts\utility::flag_init(var_0.getnegotiationnextnode);
      }

      break;
  }
}

getpowerswitchinzone(var_0) {
  var_1 = common_scripts\utility::getstructarray("power_switch", "targetname");

  foreach(var_3 in var_1) {
    if(isswitchinzonevolumes(var_3, level.zone_data.zones[var_0].volumes)) {
      return var_3;
    }
  }

  return undefined;
}

isswitchinzonevolumes(var_0, var_1) {
  foreach(var_3 in var_1) {
    if(_ispointinvolume(var_0.origin, var_3)) {
      return 1;
    }
  }

  return 0;
}

_id_4694(var_0) {
  var_1 = [];

  foreach(var_3 in level.zone_data._id_9054) {
    foreach(var_5 in getEntArray(var_3, "script_noteworthy")) {
      var_1[var_1.size] = var_5;
    }
  }

  var_8 = [];

  foreach(var_10 in level.zone_data.zones[var_0].volumes) {
    if(isDefined(var_10.target)) {
      var_11 = common_scripts\utility::getstructarray(var_10.target, "targetname");

      foreach(var_13 in var_11) {
        if(!common_scripts\utility::_id_0F79(var_8, var_13)) {
          var_13.zone_name = var_0;
          var_8[var_8.size] = var_13;
        }
      }
    }

    foreach(var_5 in var_1) {
      if(_ispointinvolume(var_5.origin, var_10) && !common_scripts\utility::_id_0F79(var_8, var_5)) {
        var_5.zone_name = var_0;
        var_8[var_8.size] = var_5;
      }
    }
  }

  return var_8;
}

filterspawnersfromlistbytype(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(!isDefined(var_4._id_0165)) {
      continue;
    }
    if(var_4._id_0165 != var_1) {
      continue;
    }
    var_2[var_2.size] = var_4;
  }

  return var_2;
}

_id_0993(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(level.flag[var_2])) {
    common_scripts\utility::flag_init(var_2);
  }

  makezoneadjacent(var_0, var_1, var_2, 0);
  makezoneadjacent(var_1, var_0, var_2, var_3);
}

makezoneadjacent(var_0, var_1, var_2, var_3) {
  var_4 = level.zone_data.zones[var_0];

  if(!isDefined(var_4._id_0A01[var_1])) {
    var_5 = spawnStruct();
    var_5.zone_name = var_1;
    var_5.flags[0] = var_2;
    var_5.is_connected = 0;
    var_5.oneway = var_3;
    var_4._id_0A01[var_1] = var_5;
  } else {
    var_6 = var_4._id_0A01[var_1];
    var_6.flags[var_6.flags.size] = var_2;
  }
}

getadjacentzones(var_0) {
  var_1 = [];
  var_2 = level.zone_data.zones[var_0];

  foreach(var_4 in var_2._id_0A01) {
    var_1[var_1.size] = var_4;
  }

  return var_1;
}

_id_088A(var_0) {
  if(isDefined(var_0)) {
    level.zone_data.spawnfunc = var_0;
  }

  foreach(var_2 in level.zone_data.zones) {
    foreach(var_5, var_4 in var_2._id_0A01) {
      level thread zonewaitforflags(var_2, var_5);
    }
  }

  level thread monitorspawnpointupdate();
  level thread _id_ACAC();
  level.zone_data._id_08A9 = 1;
}

monitorspawnpointupdate() {
  level endon("game_ended");
  var_0 = 1.0;

  for(;;) {
    level.zone_data.spawn_points_update_requested = 1;

    while(level.zone_data.spawn_points_update_requested) {
      waitframe();
    }

    wait(var_0);
  }
}

zonewaitforflags(var_0, var_1) {
  level endon("game_ended");

  foreach(var_3 in var_0._id_0A01[var_1].flags) {
    level thread zonewaitforspecificflag(var_0, var_3, var_1);
  }
}

zonewaitforspecificflag(var_0, var_1, var_2) {
  level endon("game_ended");
  common_scripts\utility::flag_wait(var_1);
  var_3 = level.zone_data.zones[var_2];
  var_3.is_enabled = 1;
  common_scripts\utility::flag_set(var_0.zone_name);
  var_0._id_0A01[var_2].is_connected = 1;
  level thread updateconnectiondistances();
}

getcivilianpoint(var_0, var_1) {
  var_2 = [];
  var_3 = 0;
  var_4 = getcurrentplayeroccupiedzones();

  for(var_5 = var_4.size; var_5 > 0; var_5--) {
    var_6 = var_4[var_3];
    var_7 = level.zone_data.zones[var_6];

    if(var_0) {
      var_2 = common_scripts\utility::_id_0F73(var_2, var_7.civilian_spawners);
    } else {
      var_2 = common_scripts\utility::_id_0F73(var_2, var_7.civilian_extracts);

      foreach(var_9 in var_2) {
        if(!isDefined(var_9.setlookatent)) {
          var_2 = common_scripts\utility::_id_0F93(var_2, var_9);
        }
      }
    }

    if(iszoneenabled(var_7.zone_name)) {
      foreach(var_12 in var_7._id_0A01) {
        if(!iszoneenabled(var_12.zone_name)) {
          if(!var_0) {
            continue;
          }
          if(var_12.oneway) {
            continue;
          }
        }

        if(!common_scripts\utility::_id_0F79(var_4, var_12.zone_name)) {
          var_4[var_4.size] = var_12.zone_name;
          var_5++;
        }
      }
    }

    var_3++;
  }

  var_2 = _sortbydistance(var_2, var_1);

  for(var_14 = var_2.size - 1; var_14 >= 0; var_14--) {
    if(!isDefined(var_2[var_14].hasbeenused)) {
      var_2[var_14].hasbeenused = 1;
      return var_2[var_14];
    }
  }

  var_2[var_2.size - 1].hasbeenused = 1;
  return var_2[var_2.size - 1];
}

getspawnpoint(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.zone_data)) {
    return undefined;
  }

  if(level.zone_data.spawn_points_update_requested) {
    level.zone_data.spawn_points_update_requested = 0;
    updatespawnpoints();
  }

  return [[level.zone_data.spawnfunc]](var_0, var_1, var_2, var_3);
}

updatespawnpoints() {
  foreach(var_1 in level.zone_data.zones) {
    var_1._id_552B = _id_5780(var_1.zone_name);
    var_1._id_552C = 0;
  }

  foreach(var_1 in level.zone_data.zones) {
    if(var_1._id_552B) {
      foreach(var_5 in var_1._id_0A01) {
        var_6 = level.zone_data.zones[var_5.zone_name];

        if(!var_6._id_552B) {
          var_6._id_552C = 1;
        }
      }
    }
  }

  var_9 = [];
  var_10 = [];

  foreach(var_1 in level.zone_data.zones) {
    if(var_1._id_552B || var_1._id_552C && var_1.is_enabled) {
      var_9[var_9.size] = var_1.zone_name;
    }

    if(var_1._id_552C) {
      var_10[var_10.size] = var_1.zone_name;
    }
  }

  level.zone_data._id_2914 = var_9;
  level.zone_data._id_290A = var_10;
}

_id_583C(var_0) {
  var_1 = 0;

  if(isDefined(level.players)) {
    foreach(var_3 in level.players) {
      var_4 = _func_38E(var_0, var_3.origin);

      if(var_4 < 2000) {
        var_1 = 1;
        break;
      }
    }
  }

  return var_1;
}

_id_4692() {
  var_0 = [];

  foreach(var_2 in level.zone_data._id_2914) {
    var_3 = level.zone_data.zones[var_2];

    foreach(var_5 in var_3.zombie_spawners) {
      var_0[var_0.size] = var_5;
    }
  }

  return var_0;
}

_id_4693(var_0) {
  var_1 = [];
  var_2 = level.zone_data.zones[var_0];

  foreach(var_4 in var_2.zombie_spawners) {
    var_1[var_1.size] = var_4;
  }

  return var_1;
}

_id_4691() {
  var_0 = [];

  foreach(var_2 in level.zone_data._id_290A) {
    var_3 = level.zone_data.zones[var_2];

    foreach(var_5 in var_3.zombie_spawners) {
      var_0[var_0.size] = var_5;
    }
  }

  return var_0;
}

_id_582C() {
  if(isDefined(self._id_8C95) && self._id_8C95) {
    if(isDefined(level._id_8C96)) {
      return [[level._id_8C96]]();
    } else {
      return 1;
    }
  } else
    return 1;
}

_id_1E55(var_0, var_1, var_2, var_3) {
  if(isDefined(level._id_7A5D) && isDefined(level._id_7A5D[var_0])) {
    return [[level._id_7A5D[var_0]]]();
  }

  if(level.zone_data._id_2914.size == 0) {
    return undefined;
  }

  var_4 = undefined;

  if(var_2) {
    var_5 = common_scripts\utility::array_randomize(_id_4691());
  } else if(isDefined(var_3)) {
    var_5 = common_scripts\utility::array_randomize(_id_4693(var_3));
  } else {
    var_5 = common_scripts\utility::array_randomize(_id_4692());
  }

  var_6 = [];

  foreach(var_8 in var_5) {
    if((var_8 _id_905D() || isDefined(var_3)) && var_8 spawnercanbeusedfor(var_0, var_1) && (isDefined(var_3) || (var_2 || _id_583C(var_8.origin)) && var_8 _id_582C())) {
      var_4 = var_8;
      break;
    }
  }

  if(!isDefined(var_4) && common_scripts\utility::_id_562E(level._id_7D20)) {
    var_10 = common_scripts\utility::array_randomize(level.zombies_spawners_zombie);

    foreach(var_8 in var_10) {
      if(var_8 _id_905D() && var_8 spawnercanbeusedfor(var_0, var_1)) {
        var_4 = var_8;
        break;
      }
    }
  }

  if(!isDefined(var_4)) {
    var_17 = randomint(level.zone_data._id_2914.size);
    var_18 = level.zone_data._id_2914[var_17];
    var_19 = level.zone_data.zones[var_18];

    foreach(var_8 in var_19.zombie_spawners) {
      if(var_8 spawnercanbeusedfor(var_0, var_1)) {
        var_4 = var_8;
        break;
      }
    }
  }

  return var_4;
}

_id_1E58(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    var_4 = [var_3];
  } else {
    var_4 = level.zone_data._id_2914;
  }

  var_5 = [];

  foreach(var_7 in var_4) {
    var_8 = level.zone_data.zones[var_7];
    var_5 = common_scripts\utility::_id_0F73(var_5, var_8.zombie_spawners);
  }

  var_10 = _id_0558::_id_4746(var_5, var_0, var_1);
  var_10._id_5BE2 = gettime();
  return var_10;
}

_id_1E4E(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    var_4 = [var_3];
  } else {
    var_4 = level.zone_data._id_2914;
  }

  var_9 = [];

  foreach(var_7 in var_4) {
    var_11 = level.zone_data.zones[var_7];

    foreach(var_13 in var_11.zombie_spawners) {
      if(!var_13 _id_905D()) {
        continue;
      }
      if(!var_13 spawnercanbeusedfor(var_0, var_1)) {
        continue;
      }
      if(!var_13 _id_582C()) {
        continue;
      }
      if(isDefined(var_13.setflaggedanimknoball) && common_scripts\utility::_id_562E(var_13.in_use)) {
        continue;
      }
      var_9[var_9.size] = var_13;
    }
  }

  var_16 = 2;
  var_17 = undefined;
  var_18 = undefined;
  var_19 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");

  foreach(var_21 in level.players) {
    if(!isalive(var_21) || common_scripts\utility::_id_562E(var_21.inlaststand)) {
      continue;
    }
    var_22 = 0;

    foreach(var_24 in var_19) {
      if(isDefined(var_24._id_0088) && var_24._id_0088 == var_21) {
        var_22++;
      }
    }

    if(common_scripts\utility::_id_562E(var_21.zombiesignoreme)) {
      var_22 = var_19.size;
    }

    var_22 = var_22 + _randomfloat(var_16);

    if(!isDefined(var_18) || var_22 < var_18) {
      var_18 = var_22;
      var_17 = var_21;
    }
  }

  if(!isDefined(var_17)) {
    return common_scripts\utility::random(var_9);
  }

  var_27 = 20;
  var_28 = 0.3;
  var_29 = 0.2;
  var_30 = common_scripts\utility::linear_map_clamp(level.wavecounter, 1, 10, 40, 80);
  var_31 = 10;
  var_32 = 3;
  var_33 = 2;
  var_34 = undefined;
  var_35 = undefined;

  foreach(var_37 in var_9) {
    var_5 = "";
    var_38 = 0;

    if(common_scripts\utility::_id_562E(var_37._id_8C95)) {
      var_38 = var_38 + var_32;
      var_39 = var_37._id_487C;
    } else {
      var_39 = var_37.origin;
      var_37 _id_054D::_id_A0DA();
      var_38 = var_38 + var_31 * var_37._id_AC3D.size;

      if(isDefined(var_37._id_3C5B) && _id_0547::_id_562C(var_37._id_3C5B)) {
        var_38 = var_38 + var_33 * var_37._id_3C5B._id_15CB._id_17EC;
      }
    }

    var_40 = _func_38E(var_39, var_17.origin);
    var_38 = var_38 + var_40 / var_30;
    var_38 = var_38 / common_scripts\utility::linear_map_clamp(vectordot(vectorNormalize(var_17 getvelocity()), vectorNormalize(var_39 - var_17.origin)), 0, 1, 1, 1 + var_29);
    var_38 = var_38 + _randomfloat(var_38 * var_28 + var_27);

    if(!isDefined(var_34) || var_38 < var_34) {
      var_34 = var_38;
      var_35 = var_37;
    }
  }

  return var_35;
}

spawnercanbeusedfor(var_0, var_1) {
  if(isDefined(self.setlookatent)) {
    var_2 = strtok(self.setlookatent, " ,");
    var_3 = 0;
    var_4 = 0;

    foreach(var_6 in var_2) {
      if(var_6 == var_0) {
        var_3 = 1;
      }

      if(var_6 == "exclusive") {
        var_4 = 1;
      }
    }

    if(!var_3 && (var_4 || var_1)) {
      return 0;
    }
  } else if(var_1)
    return 0;

  return 1;
}

_id_905D() {
  if(common_scripts\utility::_id_562E(self._id_3A1B)) {
    return 0;
  }

  if(common_scripts\utility::_id_562E(self.is_zombies_spawner_script_disabled)) {
    return 0;
  }

  if(common_scripts\utility::_id_562E(level._id_7D20) && !isDefined(self.getnegotiationnextnode)) {
    return 0;
  } else if(common_scripts\utility::_id_562E(level._id_38D1) && !isDefined(self.getnegotiationnextnode)) {
    var_0 = level.zone_data.zones[self.zone_name];

    foreach(var_3, var_2 in var_0._id_9050) {
      if(common_scripts\utility::flag(var_3)) {
        return 0;
      }
    }
  }

  if(isDefined(self.getnegotiationnextnode)) {
    if(!common_scripts\utility::flag(self.getnegotiationnextnode)) {
      return 0;
    }
  }

  return 1;
}

_id_8729(var_0, var_1) {
  if(common_scripts\utility::_id_562E(var_0)) {
    level._id_38D2[var_1] = 1;
  } else {
    level._id_38D2[var_1] = undefined;
  }

  if(level._id_38D2.size > 0) {
    level._id_38D1 = 1;
  } else {
    level._id_38D1 = undefined;
  }
}

_id_8712(var_0, var_1) {
  if(common_scripts\utility::_id_562E(var_0)) {
    level._id_7D21[var_1] = 1;
  } else {
    level._id_7D21[var_1] = undefined;
  }

  if(level._id_7D21.size > 0) {
    level._id_7D20 = 1;
  } else {
    level._id_7D20 = undefined;
  }
}

_id_ACA1() {
  var_0 = common_scripts\utility::getstruct(self.zone_name, "targetname");

  if(isDefined(var_0)) {
    var_1 = _func_2E1(var_0.origin);
    self._id_74DC = var_1;
    return;
  }

  foreach(var_3 in _id_050D::_id_44F9("allies")) {
    if(_id_0547::_id_5565(var_3._id_0165, self.zone_name)) {
      var_1 = _func_2E1(var_3.origin);
      self._id_74DC = var_1;
      return;
    }
  }

  foreach(var_6 in self.volumes) {
    var_7 = var_6 getpointinbounds(0, 0, 0);
    var_8 = _func_2E1(var_7);

    if(_ispointinvolume(var_8, var_6)) {
      self._id_74DC = var_8;
      return;
    }
  }
}

_id_ACB0(var_0) {
  var_1 = "mp/zombieZoneTable.csv";
  var_2 = _tablegetcolumncount(var_1);
  return tablelookup(var_1, 0, var_0, 1);
}

_id_ACAC() {
  if(common_scripts\utility::_id_562E(level._id_ACA3)) {
    return;
  }
  foreach(var_7, var_1 in level.zone_data.zones) {
    var_2 = _id_ACB0(var_7);
    var_1._id_ACAD = var_2 != "";
  }

  maps\mp\_utility::_id_6F74(::zonehudupdateplayerthread);
}

zonehudupdateplayerthread() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0._id_ACA6 = [];
  var_0 thread _id_ACAB();

  foreach(var_3, var_2 in level.zone_data.zones) {
    var_0 common_scripts\utility::ent_flag_init(var_3);
  }

  for(;;) {
    var_3 = var_0 _id_462D();

    if(!isDefined(var_3)) {} else {
      var_2 = level.zone_data.zones[var_3];

      if(_id_0547::_id_5565(var_0._id_5BB6, var_3)) {} else {
        var_5 = "unknown";

        if(isDefined(var_0._id_5BB6)) {
          var_5 = var_0._id_5BB6;
        }

        var_0 _id_ACA7("ui_zm_previous_zone_name", var_5);
        var_0 _id_ACA7("ui_zm_current_zone_name", var_3);
        var_6 = "ui_zm_player_" + var_0 getentitynumber() + "_zone_name";
        _setomnvar(var_6, var_3);
        var_0._id_5BB6 = var_3;

        if(!var_0 common_scripts\utility::ent_flag(var_3)) {
          var_0 common_scripts\utility::ent_flag_set(var_3);
        }
      }
    }

    waitframe();
  }
}

_id_ACAB() {
  var_0 = self;
  var_0 endon("disconnect");

  for(;;) {
    if(var_0._id_ACA6.size == 0) {
      var_0 waittill("ZoneHud");
    }

    var_1 = var_0._id_ACA6[0];
    var_0._id_ACA6 = common_scripts\utility::_id_0F9A(var_0._id_ACA6, 0);
    var_0[[var_1.callback]](var_1._id_2A35);
  }
}

_id_ACA8(var_0) {
  var_1 = self;
  var_1 _id_ACA2(var_0, ::_id_ACAA);
}

_id_ACA7(var_0, var_1) {
  var_2 = self;
  var_3 = spawnStruct();
  var_3._id_6A70 = var_0;
  var_3._id_6A71 = var_1;
  var_2 _id_ACA2(var_3, ::_id_ACA9);
}

_id_ACA2(var_0, var_1) {
  var_2 = self;
  var_3 = spawnStruct();
  var_3._id_2A35 = var_0;
  var_3.callback = var_1;
  var_2._id_ACA6 = common_scripts\utility::_id_0F6F(var_2._id_ACA6, var_3);
  var_2 notify("ZoneHud");
}

_id_ACAA(var_0) {
  wait(var_0);
}

_id_ACA9(var_0) {
  var_1 = self;
  var_2 = var_0._id_6A70;
  var_3 = var_0._id_6A71;
  var_1 setclientomnvar(var_2, var_3);
}