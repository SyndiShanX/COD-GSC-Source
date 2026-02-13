/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2602.gsc
*************************************************/

init() {
  setdvarifuninitialized("#x32b06f8c90f44038", 0);
  level._effect["fire_bomb_fire"] = loadfx("vfx/s4/explosion/vfx_airdrop_explosion");
  level._id_CC1E["firebomb"] = 230;
  level._id_CC1F["firebomb"] = 65;
  level._id_CC1D["firebomb"] = -1;
  level._id_CC20["firebomb"] = 6.0;
  level._id_CC1C["firebomb"] = 24.0;
  level._id_8DD4["firebomb"] = ::_id_F77E;
  level._id_8DEF["firebomb_bomb_mp"] = "firebomb";
  level._id_8DEF["firebomb_bomb_axis_mp"] = "firebomb";
  level._id_8DEF["firebomb_bomb_grenadier_mp"] = "firebomb";
  level._id_8DEF["firebomb_bomb_axis_grenadier_mp"] = "firebomb";
  level._id_8DEF["firebomb_flames_mp"] = "firebomb";
  level._id_0F41 = 0;
}

_id_F77E(var_0) {
  if(isDefined(level._id_0F41) && level._id_0F41 > 0) {
    self iprintlnbold(&"KILLSTREAKS_FIREBOMB_ALREADY_ACTIVE");
    return 0;
  }

  if(isDefined(self._id_AE4F) && self._id_AE4F) {
    self iprintlnbold(&"KILLSTREAKS_DLC4_CANT_USE_STREAK_WHILE_PARATROOPING");
    return 0;
  }

  if(_id_0A2D::_id_F7A1(var_0, "firebomb")) {
    self._id_5B61 = 0;
    return 1;
  }

  return 0;
}

_id_3FCD(var_0) {
  self waittill("death");

  if(!isDefined(self) || !isDefined(self.origin)) {
    return;
  }
  var_1 = self.origin;
  var_2 = self.angles;
  var_3 = self.owner;
  var_4 = self.team;
  level._id_0F41++;
  wait 1;
  level thread _id_B836(var_1, var_0);
  level thread _id_A10E(var_1, var_2, var_3, var_4, var_0);
}

_id_B837(var_0, var_1) {
  var_2 = undefined;
  var_2 = spawnfx(level._effect["fire_bomb_fire"], var_0);
  triggerfx(var_2);
  wait 12;

  if(isDefined(var_2)) {
    var_2 delete();
  }
}

_id_B836(var_0, var_1) {
  var_2 = _id_080C::_id_A6DA("ks_firebomb_burn_loop", undefined, var_0, 2);

  if(var_1) {
    wait 16;
  } else {
    wait 12;
  }

  _id_080C::_id_A6DC(var_2, 1.5);
}

_id_A10E(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");

  if(!isDefined(var_0) || !isDefined(var_1)) {
    return;
  }
  var_5 = gettime();
  var_6 = 0;
  var_7 = anglesToForward(var_1);
  var_7 = (var_7[0], var_7[1], 0);
  var_7 = vectornormalize(var_7);

  if(var_4) {
    var_8 = 16;
  } else {
    var_8 = 12;
  }

  while(var_6 < var_8) {
    foreach(var_10 in level.players) {
      if(_func_0458(var_10)) {
        continue;
      }
      if(var_10.team != var_3 || isDefined(var_2) && var_10 == var_2 || isDefined(level._id_74C4) && level._id_74C4) {
        if(!isDefined(var_10._id_F941)) {
          if(!isDefined(var_10._id_8FD4) || var_10._id_8FD4 != gettime()) {
            if(_id_B6AB(var_10, var_0, var_7)) {
              if(_id_B6E6(var_10, var_0)) {
                var_10._id_8FD4 = gettime();
                var_10 dodamage(40, var_10.origin, var_2, undefined, "MOD_BURNED", "firebomb_flames_mp");
              }
            }
          }
        }
      }
    }

    wait 0.4;
    var_6 = (gettime() - var_5) / 1000;
  }

  level._id_0F41--;
}

_id_B6AB(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    return 0;
  }

  var_3 = var_0 _meth_8169();

  if(var_3[2] - var_1[2] > 256) {
    return 0;
  }

  var_4 = 103;
  var_5 = _id_403C(var_1, var_2, var_4);
  return _id_B9BA(var_3, var_5);
}

_id_403C(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_4 = var_1 * var_2;
  var_5 = _func_025B(var_1, (0, 0, 1)) * var_2;
  var_3._id_0DDF = var_0 + var_4 - var_5;
  var_3._id_1FF6 = var_0 + var_4 + var_5;
  var_3._id_2DF6 = var_0 - var_4 + var_5;
  var_3._id_42A5 = var_0 - var_4 - var_5;
  return var_3;
}

_id_B6E6(var_0, var_1) {
  if(var_0.origin[2] <= var_1[2]) {
    return _id_080C::_id_2D3C(var_0.origin + (0, 0, 10), (var_0.origin[0], var_0.origin[1], var_1[2] + 10), 0, var_0) && _id_080C::_id_2D3C(var_1 + (0, 0, 10), (var_0.origin[0], var_0.origin[1], var_1[2] + 10), 0, var_0);
  } else {
    return _id_080C::_id_2D3C(var_1 + (0, 0, 10), (var_1[0], var_1[1], var_0.origin[2] + 10), 0, var_0) && _id_080C::_id_2D3C(var_0.origin + (0, 0, 10), (var_1[0], var_1[1], var_0.origin[2] + 10), 0, var_0);
  }
}

_id_B9BA(var_0, var_1) {
  return _id_CB15(var_0, var_1._id_0DDF, var_1._id_1FF6, var_1._id_42A5) && _id_CB15(var_0, var_1._id_1FF6, var_1._id_2DF6, var_1._id_0DDF) && _id_CB15(var_0, var_1._id_2DF6, var_1._id_42A5, var_1._id_1FF6) && _id_CB15(var_0, var_1._id_42A5, var_1._id_0DDF, var_1._id_2DF6);
}

_id_CB15(var_0, var_1, var_2, var_3) {
  var_4 = _func_025B(var_2 - var_1, var_3 - var_1);
  var_5 = _func_025B(var_2 - var_1, var_0 - var_1);
  return vectordot(var_4, var_5) >= 0;
}