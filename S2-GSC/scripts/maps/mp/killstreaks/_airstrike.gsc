/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\killstreaks\_airstrike.gsc
******************************************************/

init() {
  level._id_80B7["airstrike"] = 400;
  level._id_80B8["airstrike"] = 75;
  level.setwhizbyprobabilities["airstrike"] = -1;
  level._id_80B9["airstrike"] = 6.0;
  level.makeglobalunusable["airstrike"] = 8.0;
  level._id_5A61["airstrike"] = ::_id_9E23;
  level._id_5A7D["airstrike_bomb_mp"] = "airstrike";
  level._id_5A7D["airstrike_bomb_axis_mp"] = "airstrike";
}

_id_9E23(var_0) {
  if(_id_0527::_id_9E35(var_0, "airstrike")) {
    self._id_0B95 = 0;
    return 1;
  }

  return 0;
}

_id_0B9A(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");

  if(isDefined(var_2))
    var_2 endon("disconnect");

  level._id_2000 = 1;

  if(isDefined(var_2))
    var_2 thread _id_6B75();

  if(maps\mp\_utility::_id_579B() && isDefined(var_3) && isDefined(level._id_79C2.setcontents) && isDefined(level._id_79C2.setcontents._id_0B9C))
    thread[[level._id_79C2.setcontents._id_0B9C]](4.0);
  else
    thread _id_11DA();

  var_6 = 0;

  if(isDefined(var_2))
    var_6 = var_2 maps\mp\_utility::_hasperk("specialty_improvedstreaks");

  var_7 = 3;

  if(var_6)
    var_7 = 4;

  if(maps\mp\_utility::_id_579B() && isDefined(var_3) && isDefined(level._id_79C2.setcontents) && isDefined(level._id_79C2.setcontents._id_0B98))
    var_7 = _round(3 * level._id_79C2.setcontents._id_0B98);

  if(isDefined(level._id_0811) && level._id_0811)
    var_7 = 1;

  for(var_8 = 0; var_8 < var_7 && !maps\mp\_utility::_id_5668(0, var_3); var_8++) {
    if(isDefined(level._id_0811) && level._id_0811)
      wait 1.0;
    else
      wait 4.0;

    var_9 = _id_0527::_id_4570();

    if(maps\mp\_utility::_id_4571() == "mp_airship")
      var_9 = var_9 - 180;

    var_10 = [];

    for(var_11 = -5; var_11 < 6; var_11++) {
      var_12 = spawnStruct();
      var_12.origin = (level._id_5FEB[0] + _cos(var_9 + 90) * var_11 * 700, level._id_5FEB[1] + _sin(var_9 + 90) * var_11 * 700, level._id_5FEB[2]);
      var_12._id_7F31 = _abs((_abs(var_11) - 5) / 50);
      var_10[var_10.size] = var_12;
    }

    if(isDefined(var_3)) {
      if(isDefined(var_5))
        var_9 = var_5;

      if(isDefined(var_4))
        thread _id_0527::_id_9302(var_0, [var_4], [var_9], var_1, var_3);
      else {
        var_13 = _id_4435(var_10, var_9, var_3);
        thread _id_0527::_id_9302(var_0, [var_13.origin], [var_9], var_1, var_3);
      }
    } else {
      var_13 = var_2 _id_4435(var_10, var_9);
      var_2 thread _id_0527::_id_9302(var_0, [var_13.origin], [var_9], var_1);
    }

    if(var_6) {
      wait 7.5;
      continue;
    }

    wait 10.0;
  }

  wait 4.0;
  level._id_2000 = undefined;
  level notify("carpetBombingEnded");

  if(isDefined(var_2))
    var_2 notify("carpetBombingEnded");
}

_id_11DA() {
  var_0 = _id_0380::_id_2889("mp_ks_air_raid_siren", undefined, level._id_5FEB + (0, 0, 200));
}

_id_4435(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(!maps\mp\_utility::isreallyalive(var_4)) {
      continue;
    }
    if(isDefined(var_2)) {
      if(level.teambased && var_4.team == var_2)
        continue;
    } else if(level.teambased && var_4.team == self.team && var_4 != self) {
      continue;
    }
    if(var_4.team == "spectator") {
      continue;
    }
    var_5 = 999999999;
    var_6 = undefined;
    var_7 = 999999999;
    var_8 = undefined;

    foreach(var_10 in var_0) {
      var_11 = _distance2d((var_10.origin[0] * _cos(var_1 + 90), var_10.origin[1] * _sin(var_1 + 90), 0), (var_4.origin[0] * _cos(var_1 + 90), var_4.origin[1] * _sin(var_1 + 90), 0));

      if(var_11 <= var_5) {
        var_7 = var_5;
        var_8 = var_6;
        var_5 = var_11;
        var_6 = var_10;
      } else if(var_11 <= var_7) {
        var_7 = var_11;
        var_8 = var_10;
      }

      if(isDefined(self) && var_4 == self && var_11 <= 1000) {
        if(maps\mp\_utility::_id_4571() != "mp_shipment_s2" && maps\mp\_utility::_id_4571() != "mp_sandbox_01") {
          if(!_bullettracepassed(var_4.origin + (0, 0, 32), var_4.origin + (0, 0, 10000), 0, var_4)) {
            var_10._id_7F31 = var_10._id_7F31 - 3.25;
            continue;
          }

          var_10._id_7F31 = var_10._id_7F31 - 6;
        }
      }
    }

    if(isDefined(self) && var_4 == self)
      continue;
    else {
      if(!_bullettracepassed(var_4.origin + (0, 0, 32), var_4.origin + (0, 0, 10000), 0, var_4)) {
        var_6._id_7F31 = var_6._id_7F31 + 0.75;
        var_8._id_7F31 = var_8._id_7F31 + 0.5;
        continue;
      }

      var_6._id_7F31 = var_6._id_7F31 + 2.5;
      var_8._id_7F31 = var_8._id_7F31 + 1.75;
    }
  }

  if(isDefined(var_2))
    var_14 = var_2;
  else
    var_14 = self.team;

  var_15 = level._id_7AD1[maps\mp\_utility::getotherteam(var_14)];

  if(!level.teambased)
    var_15 = level._id_7AD1["all"];

  foreach(var_17 in var_15) {
    if(!level.teambased && var_17["player"] == self.guid) {
      continue;
    }
    var_5 = 999999999;
    var_6 = undefined;
    var_7 = 999999999;
    var_8 = undefined;

    foreach(var_10 in var_0) {
      var_11 = _distance2d((var_10.origin[0] * _cos(var_1 + 90), var_10.origin[1] * _sin(var_1 + 90), 0), (var_17["position"][0] * _cos(var_1 + 90), var_17["position"][1] * _sin(var_1 + 90), 0));

      if(var_11 <= var_5) {
        var_7 = var_5;
        var_8 = var_6;
        var_5 = var_11;
        var_6 = var_10;
        continue;
      }

      if(var_11 <= var_7) {
        var_7 = var_11;
        var_8 = var_10;
      }
    }

    if(!_bullettracepassed(var_17["position"] + (0, 0, 32), var_17["position"] + (0, 0, 10000), 0, undefined)) {
      var_6._id_7F31 = var_6._id_7F31 + 0.075;
      var_8._id_7F31 = var_8._id_7F31 + 0.05;
      continue;
    }

    var_6._id_7F31 = var_6._id_7F31 + 0.125;
    var_8._id_7F31 = var_8._id_7F31 + 0.1;
  }

  var_21 = var_0[0];

  foreach(var_10 in var_0) {
    if(var_10._id_7F31 > var_21._id_7F31) {
      var_21 = var_10;
      continue;
    }

    if(var_10._id_7F31 == var_21._id_7F31) {
      if(common_scripts\utility::_id_24A6())
        var_21 = var_10;
    }
  }

  return var_21;
}

_id_6B75() {
  self endon("carpetBombingEnded");
  self waittill("disconnect");
  level._id_2000 = undefined;
  level._id_0B93 = undefined;
  level notify("aud_carpet_bomb_killed");
}