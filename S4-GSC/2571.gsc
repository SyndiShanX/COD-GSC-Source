/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2571.gsc
*************************************************/

_id_AB61(var_0) {
  if(var_0._id_9CD6 == "MOD_IMPACT") {
    return 1;
  }

  var_1 = 0;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  if(var_0.attacker == var_0._id_103C2 && !istrue(var_4)) {
    var_2 = distancesquared(var_0._id_103C2.origin, var_0.point);

    if(var_2 > 65536) {
      return 0;
    } else if(var_2 <= 0) {
      var_3 = 0;
    } else {
      var_3 = _func_0218(var_2);
    }
  } else
    var_3 = distance(var_0._id_103C2.origin, var_0.point);

  if(var_0._id_103C2 scripts\mp\utility\perk::_hasperk("specialty_stun_resistance") && var_0.attacker != var_0._id_103C2) {
    var_0.attacker _id_07C4::_id_FC47("hittacresist", undefined, undefined, undefined, 1);

    if(scripts\cp_mp\utility\player_utility::_id_B78C(var_0.attacker, var_0._id_103C2)) {
      var_0._id_103C2 _id_07BC::_id_C670(var_0.attacker);
    }

    var_0._id_103C2 thread _id_19D2(var_0.attacker, 3.6);
  } else {
    var_3 = clamp(var_3, 0, 540);
    var_5 = 1 - (var_3 - 0) / 540;
    var_1 = var_1 + floor(var_5 * 65);

    if(scripts\engine\utility::_id_10E76(var_0._id_103C2.origin, var_0._id_103C2 getplayerangles(), var_0.point, 0.5)) {
      var_1 = var_1 + 35;
    }

    if(!scripts\cp_mp\utility\player_utility::_id_B78C(var_0.attacker, var_0._id_103C2)) {
      if(!istrue(var_4)) {
        if(var_0.attacker == var_0._id_103C2) {
          var_1 = var_1 + -30;
        } else {
          var_1 = var_1 + -30;
        }
      }
    }

    var_1 = max(0, var_1);
    var_6 = var_1 / 100;
    var_7 = 4.0 + 2.0 * var_6;
    var_0._id_103C2 thread _id_19D2(var_0.attacker, var_7);
    var_0.attacker _id_07C3::_id_3AC3("equip_flash");
    var_0.attacker scripts\mp\utility\stats::_id_7DAE("flashbangHits", 1);
  }
}

_id_19D2(var_0, var_1) {
  self endon("disconnect");

  if(scripts\mp\utility\player::_id_8ACE()) {
    return;
  }
  if(scripts\mp\utility\game::_id_875E() || level.gametype == "br" && var_0 scripts\mp\gametypes\br_public::_id_8990()) {
    var_1 = min(scripts\engine\utility::ter_op(level._id_ED2C <= 3, level._id_ED2C + 1.5, level._id_ED2C), var_1);
  }

  self notify("applyFlash");
  self endon("applyFlash");

  if(!istrue(self._id_5C96)) {
    self._id_5C96 = 1;
    scripts\mp\weapons::_id_D65A();
    scripts\mp\utility\player::_id_7903();
  }

  _id_09C8::_id_0CF9("flash_grenade_mp", "flash", var_1, 1);
  scripts\mp\utility\player::_id_3A20("flash", var_1);

  if(scripts\cp_mp\utility\player_utility::_id_B78C(self, var_0)) {
    var_0 _id_07BC::_id_ABB0("equip_flash");
    thread scripts\mp\gamescore::_id_F3FB(var_0, self, "flash_grenade_mp", var_1);
  }

  if(scripts\mp\utility\game::_id_875E()) {
    var_1 = max(0, var_1);
  } else {
    var_1 = max(0, var_1 - 0.5);
  }

  scripts\engine\utility::_id_108F5("death", var_1);
  thread _id_3940(!scripts\mp\utility\player::isreallyalive(self), var_0);
}

_id_3940(var_0, var_1) {
  self notify("applyFlash");

  if(istrue(self._id_5C96)) {
    if(!istrue(var_0)) {
      scripts\mp\weapons::_id_D678();
      scripts\mp\utility\player::_id_7901();
    }
  }

  self._id_5C96 = undefined;
}

_id_2EEC(var_0) {
  return max(0, var_0 - 1.5) * 1000;
}