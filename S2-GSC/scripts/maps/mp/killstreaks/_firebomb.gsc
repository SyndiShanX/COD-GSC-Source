/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\killstreaks\_firebomb.gsc
*****************************************************/

init() {
  setdvarifuninitialized("firebomb_debug", 0);
  level._id_80B7["firebomb"] = 230;
  level._id_80B8["firebomb"] = 65;
  level._id_80B6["firebomb"] = -1;
  level._id_80B9["firebomb"] = 6.0;
  level._id_80B5["firebomb"] = 24.0;
  level._id_5A61["firebomb"] = ::_id_9E2B;
  level._id_5A7D["firebomb_bomb_mp"] = "firebomb";
  level._id_5A7D["firebomb_bomb_axis_mp"] = "firebomb";
  level._id_5A7D["firebomb_bomb_grenadier_mp"] = "firebomb";
  level._id_5A7D["firebomb_bomb_axis_grenadier_mp"] = "firebomb";
  level._id_5A7D["firebomb_flames_mp"] = "firebomb";
  level._id_08D5 = 0;
}

_id_9E2B(var_0) {
  if(isDefined(level._id_08D5) && level._id_08D5 > 0) {
    self iprintlnbold(&"KILLSTREAKS_FIREBOMB_ALREADY_ACTIVE");
    return 0;
  }

  if(isDefined(self._id_6E6B) && self._id_6E6B) {
    self iprintlnbold(&"KILLSTREAKS_DLC4_CANT_USE_STREAK_WHILE_PARATROOPING");
    return 0;
  }

  if(_id_0527::_id_9E3A(var_0, "firebomb")) {
    self._id_3BD6 = 0;
    return 1;
  }

  return 0;
}

_id_27EC(var_0) {
  self waittill("death");

  if(!isDefined(self) || !isDefined(self.origin)) {
    return;
  }
  var_1 = self.origin;
  var_2 = self.angles;
  var_3 = self._id_0117;
  var_4 = self.team;
  level._id_08D5++;
  wait 1;
  level thread _id_749A(var_1, var_0);
  level thread _id_6393(var_1, var_2, var_3, var_4, var_0);
}

_id_749B(var_0, var_1) {
  var_2 = undefined;
  var_2 = _func_14B(level._effect["fire_bomb_fire"], var_0);
  _func_14C(var_2);
  wait 12;

  if(isDefined(var_2))
    var_2 delete();
}

_id_749A(var_0, var_1) {
  var_2 = _id_0380::_id_6842("ks_firebomb_burn_loop", undefined, var_0, 2);

  if(var_1)
    wait 16;
  else
    wait 12;

  _id_0380::_id_6850(var_2, 1.5);
}

_id_6393(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");

  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  var_5 = gettime();
  var_6 = 0;
  var_7 = anglesToForward(var_1);
  var_7 = (var_7[0], var_7[1], 0);
  var_7 = vectorNormalize(var_7);

  if(var_4)
    var_8 = 16;
  else
    var_8 = 12;

  while(var_6 < var_8) {
    foreach(var_10 in level.players) {
      if(_func_279(var_10)) {
        continue;
      }
      if(var_10.team != var_3 || isDefined(var_2) && var_10 == var_2 || isDefined(level.hardcoremode) && level.hardcoremode) {
        if(!isDefined(var_10._id_A019)) {
          if(!isDefined(var_10._id_5B9A) || var_10._id_5B9A != gettime()) {
            if(_id_73E1(var_10, var_0, var_7)) {
              if(_id_740F(var_10, var_0)) {
                var_10._id_5B9A = gettime();
                var_10 _meth_8059(40, var_10.origin, var_2, undefined, "MOD_BURNED", "firebomb_flames_mp");
              }
            }
          }
        }
      }
    }

    wait 0.4;
    var_6 = (gettime() - var_5) / 1000;
  }

  level._id_08D5--;
}

_id_73E1(var_0, var_1, var_2) {
  if(!isDefined(var_1))
    return 0;

  var_3 = var_0 _meth_808F();

  if(var_3[2] - var_1[2] > 256)
    return 0;

  var_4 = 103;
  var_5 = _id_2825(var_1, var_2, var_4);
  return _id_7542(var_3, var_5);
}

_id_2825(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_4 = var_1 * var_2;
  var_5 = _func_0E9(var_1, (0, 0, 1)) * var_2;
  var_3._id_0794 = var_0 + var_4 - var_5;
  var_3._id_14C2 = var_0 + var_4 + var_5;
  var_3._id_1DEC = var_0 - var_4 + var_5;
  var_3._id_298F = var_0 - var_4 - var_5;
  return var_3;
}

_id_740F(var_0, var_1) {
  if(var_0.origin[2] <= var_1[2])
    return _func_07E(var_0.origin + (0, 0, 10), (var_0.origin[0], var_0.origin[1], var_1[2] + 10), 0, var_0) && _func_07E(var_1 + (0, 0, 10), (var_0.origin[0], var_0.origin[1], var_1[2] + 10), 0, var_0);
  else
    return _func_07E(var_1 + (0, 0, 10), (var_1[0], var_1[1], var_0.origin[2] + 10), 0, var_0) && _func_07E(var_0.origin + (0, 0, 10), (var_1[0], var_1[1], var_0.origin[2] + 10), 0, var_0);
}

_id_7542(var_0, var_1) {
  return _id_803F(var_0, var_1._id_0794, var_1._id_14C2, var_1._id_298F) && _id_803F(var_0, var_1._id_14C2, var_1._id_1DEC, var_1._id_0794) && _id_803F(var_0, var_1._id_1DEC, var_1._id_298F, var_1._id_14C2) && _id_803F(var_0, var_1._id_298F, var_1._id_0794, var_1._id_1DEC);
}

_id_803F(var_0, var_1, var_2, var_3) {
  var_4 = _func_0E9(var_2 - var_1, var_3 - var_1);
  var_5 = _func_0E9(var_2 - var_1, var_0 - var_1);
  return vectordot(var_4, var_5) >= 0;
}