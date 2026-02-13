/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2607.gsc
*************************************************/

init() {
  level._id_CC1E["air_superiority"] = 400;
  level._id_CC1F["air_superiority"] = 75;
  level._id_CC1D["air_superiority"] = -1;
  level._id_CC20["air_superiority"] = 6.0;
  level._id_CC1C["air_superiority"] = 8.0;
  scripts\mp\killstreaks\killstreaks::_id_C26A("air_superiority", ::_id_F769);
  level._id_8DD4["air_superiority"] = ::_id_F769;
  level._id_8DEF["s4_airstrike_bomb_mp"] = "air_superiority";
  level._id_8DEF["s4_airstrike_bomb_mp"] = "air_superiority";
  level._id_136E["allies"] = 0;
  level._id_136E["axis"] = 0;
}

_id_F769(var_0) {
  if(getdvarint("#x319b863764c0b245f", 1) == 0) {
    scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/UNAVAILABLE");
    return 0;
  }

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

  if(_id_0A2D::_id_F794(var_1, "air_superiority")) {
    self._id_13C6 = 0;
    _id_09B9::_id_EA01(var_0, makeweapon("s4_ks_gesture_generic_mp"));
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

  var_9 = 3;
  scripts\cp_mp\vehicles\vehicle_tracking::_id_3992();

  for(var_10 = 0; var_10 < var_9 && !scripts\mp\utility\game::_id_873C(); var_10++) {
    wait 4.0;
    var_11 = _id_0A2D::_id_6B2C();
    var_12 = [];

    for(var_13 = -5; var_13 < 6; var_13++) {
      var_14 = spawnStruct();
      var_14.origin = (level._id_9AAC[0] + cos(var_11 + 90) * var_13 * 700, level._id_9AAC[1] + sin(var_11 + 90) * var_13 * 700, level._id_9AAC[2]);
      var_14._id_C957 = abs((abs(var_13) - 5) / 50);
      var_12[var_12.size] = var_14;
    }

    var_15 = var_2 _id_6910(var_12, var_11);
    var_16 = scripts\cp_mp\utility\killstreak_utility::_id_4056("precision_airstrike", var_2);
    var_2 thread _id_F75A(var_16, var_15.origin);
    wait 10.0;
  }

  wait 4.0;
  level._id_32B8 = undefined;
  level._id_13BD = undefined;
  level._id_136E[scripts\mp\utility\game::_id_6BE2(var_2.team)[0]] = 0;
  level notify("carpetBombingEnded");

  if(isDefined(var_2)) {
    var_2 notify("carpetBombingEnded");
  }
}

_id_F75A(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");

  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      return 0;
    }
  }

  var_2 = undefined;
  var_3 = level._id_13E3[var_0.streakname]._id_47EE;
  var_0._id_EEF2 = var_1;
  var_4 = _id_09AB::_id_10D80(var_0, undefined, undefined);
  var_2 = var_4 == "success";

  if(!istrue(var_2)) {
    return 0;
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      return 0;
    }
  }

  var_5 = _id_09AB::_id_D050(var_0);

  if(!istrue(var_5)) {
    return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "munitionUsed")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "munitionUsed")]]();
  }

  return 1;
}

_id_1E73() {
  self endon("carpetBombingEnded");
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