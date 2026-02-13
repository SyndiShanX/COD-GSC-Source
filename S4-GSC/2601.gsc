/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2601.gsc
*************************************************/

init() {
  level._id_CC1E["s2_airstrike"] = 400;
  level._id_CC1F["s2_airstrike"] = 75;
  level._id_CC1D["s2_airstrike"] = -1;
  level._id_CC20["s2_airstrike"] = 6.0;
  level._id_CC1C["s2_airstrike"] = 8.0;
  scripts\mp\killstreaks\killstreaks::_id_C26A("s2_airstrike", ::_id_F769);
  level._id_8DD4["s2_airstrike"] = ::_id_F769;
  level._id_8DEF["s4_airstrike_bomb_mp"] = "s2_airstrike";
  level._id_8DEF["s4_airstrike_bomb_mp"] = "s2_airstrike";
  level._id_136E["allies"] = 0;
  level._id_136E["axis"] = 0;
}

_id_F769(var_0) {
  var_1 = 0;

  if(!scripts\cp_mp\vehicles\vehicle_tracking::_id_C59B()) {
    return 0;
  }

  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
      return 0;
    }
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
      return 0;
    }
  }

  if(_id_0A2D::_id_F794(var_1, "s2_airstrike")) {
    self._id_13C6 = 0;
    return 1;
  }

  scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();
  return 0;
}

_id_13E2(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");

  if(isDefined(var_2)) {
    var_2 endon("disconnect");
  }

  level._id_32B8 = 1;

  if(isDefined(var_2)) {
    var_2 thread _id_AB63();
    var_2 thread _id_0A2D::_id_13E5();
  }

  level._id_136E[scripts\mp\utility\game::_id_6BE2(var_2.team)[0]] = 1;

  if(isDefined(level._id_0F4C)) {
    foreach(var_7 in level._id_0F4C) {
      if(istrue(var_7._id_873F)) {
        var_7 scripts\mp\utility\killstreak::_id_4C56(10000, var_2, var_2, scripts\mp\utility\game::_id_6BE2(var_2.team)[0], var_7.origin, "MOD_EXPLOSIVE", "s4_airstrike_bomb_mp");
      }
    }
  }

  if(_id_080C::_id_89D7() && isDefined(var_3) && isDefined(level._id_BF5C._id_CC1A) && isDefined(level._id_BF5C._id_CC1A._id_13E4)) {
    thread[[level._id_BF5C._id_CC1A._id_13E4]](4.0);
  } else {
    thread _id_1E73();
  }

  var_9 = 0;

  if(isDefined(var_2)) {
    var_9 = var_2 _id_080C::_hasperk("specialty_improvedstreaks");
  }

  var_10 = 3;

  if(var_9) {
    var_10 = 4;
  }

  if(_id_080C::_id_89D7() && isDefined(var_3) && isDefined(level._id_BF5C._id_CC1A) && isDefined(level._id_BF5C._id_CC1A._id_13E0)) {
    var_10 = _func_0037(3 * level._id_BF5C._id_CC1A._id_13E0);
  }

  if(isDefined(level._id_0DFC) && level._id_0DFC) {
    var_10 = 1;
  }

  scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();

  for(var_11 = 0; var_11 < var_10 && !scripts\mp\utility\game::_id_873C(); var_11++) {
    if(isDefined(level._id_0DFC) && level._id_0DFC) {
      wait 1.0;
    } else {
      wait 4.0;
    }

    var_12 = _id_0A2D::_id_6B2C();

    if(scripts\cp_mp\utility\game_utility::_id_6B2D() == "mp_airship") {
      var_12 = var_12 - 180;
    }

    var_13 = [];

    for(var_14 = -5; var_14 < 6; var_14++) {
      var_15 = spawnStruct();
      var_15.origin = (level._id_9AAC[0] + cos(var_12 + 90) * var_14 * 700, level._id_9AAC[1] + sin(var_12 + 90) * var_14 * 700, level._id_9AAC[2]);
      var_15._id_C957 = abs((abs(var_14) - 5) / 50);
      var_13[var_13.size] = var_15;
    }

    if(isDefined(var_3)) {
      if(isDefined(var_5)) {
        var_12 = var_5;
      }

      if(isDefined(var_4)) {
        thread _id_0A2D::_id_E720(var_0, [var_4], [var_12], var_1, var_3);
      } else {
        var_16 = _id_6910(var_13, var_12, var_3);
        thread _id_0A2D::_id_E720(var_0, [var_16.origin], [var_12], var_1, var_3);
      }
    } else {
      var_16 = var_2 _id_6910(var_13, var_12);
      var_2 thread _id_0A2D::_id_E720(var_0, [var_16.origin], [var_12], var_1);
    }

    if(var_9) {
      wait 7.5;
      continue;
    }

    wait 10.0;
  }

  wait 4.0;
  level._id_32B8 = undefined;
  level._id_136E[scripts\mp\utility\game::_id_6BE2(var_2.team)[0]] = 0;
  level notify("carpetBombingEnded");

  if(isDefined(var_2)) {
    var_2 notify("carpetBombingEnded");
  }
}

_id_1E73() {
  var_0 = _id_080C::_id_40F4("mp_ks_air_raid_siren", undefined, level._id_9AAC + (0, 0, 200));
}

_id_6910(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    if(!_id_080C::isreallyalive(var_4)) {
      continue;
    }
    if(isDefined(var_2)) {
      if(level.teambased && var_4.team == var_2) {
        continue;
      }
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
      var_11 = distance2d((var_10.origin[0] * cos(var_1 + 90), var_10.origin[1] * sin(var_1 + 90), 0), (var_4.origin[0] * cos(var_1 + 90), var_4.origin[1] * sin(var_1 + 90), 0));

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
        if(scripts\cp_mp\utility\game_utility::_id_6B2D() != "mp_shipment_s2" && scripts\cp_mp\utility\game_utility::_id_6B2D() != "mp_sandbox_01") {
          if(!_id_080C::_id_2D3C(var_4.origin + (0, 0, 32), var_4.origin + (0, 0, 10000), 0, var_4)) {
            var_10._id_C957 = var_10._id_C957 - 3.25;
            continue;
          }

          var_10._id_C957 = var_10._id_C957 - 6;
        }
      }
    }

    if(isDefined(self) && var_4 == self) {
      continue;
    } else {
      if(!_id_080C::_id_2D3C(var_4.origin + (0, 0, 32), var_4.origin + (0, 0, 10000), 0, var_4)) {
        var_6._id_C957 = var_6._id_C957 + 0.75;
        var_8._id_C957 = var_8._id_C957 + 0.5;
        continue;
      }

      var_6._id_C957 = var_6._id_C957 + 2.5;
      var_8._id_C957 = var_8._id_C957 + 1.75;
    }
  }

  if(isDefined(var_2)) {
    var_14 = var_2;
  } else {
    var_14 = self.team;
  }

  var_15 = level._id_C0F0[scripts\mp\utility\game::_id_6BE2(var_14)[0]];

  if(!level.teambased) {
    var_15 = level._id_C0F0["all"];
  }

  foreach(var_17 in var_15) {
    if(!level.teambased && var_17["player"] == self.guid) {
      continue;
    }
    var_5 = 999999999;
    var_6 = undefined;
    var_7 = 999999999;
    var_8 = undefined;

    foreach(var_10 in var_0) {
      var_11 = distance2d((var_10.origin[0] * cos(var_1 + 90), var_10.origin[1] * sin(var_1 + 90), 0), (var_17["position"][0] * cos(var_1 + 90), var_17["position"][1] * sin(var_1 + 90), 0));

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

    if(!_id_080C::_id_2D3C(var_17["position"] + (0, 0, 32), var_17["position"] + (0, 0, 10000), 0, undefined)) {
      var_6._id_C957 = var_6._id_C957 + 0.075;
      var_8._id_C957 = var_8._id_C957 + 0.05;
      continue;
    }

    var_6._id_C957 = var_6._id_C957 + 0.125;
    var_8._id_C957 = var_8._id_C957 + 0.1;
  }

  var_21 = var_0[0];

  foreach(var_10 in var_0) {
    if(var_10._id_C957 > var_21._id_C957) {
      var_21 = var_10;
      continue;
    }

    if(var_10._id_C957 == var_21._id_C957) {
      if(scripts\engine\utility::cointoss()) {
        var_21 = var_10;
      }
    }
  }

  return var_21;
}

_id_AB63() {
  self endon("carpetBombingEnded");
  self waittill("disconnect");
  level._id_32B8 = undefined;
  level._id_13BD = undefined;
  level notify("aud_carpet_bomb_killed");
}