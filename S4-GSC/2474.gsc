/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2474.gsc
*************************************************/

_id_138E() {
  level._id_3E86._id_0E45 = [];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop_multiple", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop_multiple", "init")]]();
  }

  _id_138F();
  level._effect["airdrop_m_death"] = loadfx("vfx/s4/killstreaks/vfx_airstrike_death_exp_medium_02.vfx");
}

#using_animtree("script_model");

_id_138F() {
  var_0 = "care_package_drop_multiple";
  var_1 = undefined;
  var_1 = "ac130";
  level._id_CC34[var_1] = #animtree;
  level._id_CC31[var_1][var_0] = % mp_eadrop_acharlie130;
  level._id_CC32[var_1][var_0] = "mp_eadrop_acharlie130";
  var_1 = "care_package_1";
  level._id_CC34[var_1] = #animtree;
  level._id_CC31[var_1][var_0] = % mp_eadrop_cpkg_01;
  level._id_CC32[var_1][var_0] = "mp_eadrop_cpkg_01";
  var_1 = "care_package_2";
  level._id_CC34[var_1] = #animtree;
  level._id_CC31[var_1][var_0] = % mp_eadrop_cpkg_02;
  level._id_CC32[var_1][var_0] = "mp_eadrop_cpkg_02";
  var_1 = "care_package_3";
  level._id_CC34[var_1] = #animtree;
  level._id_CC31[var_1][var_0] = % mp_eadrop_cpkg_03;
  level._id_CC32[var_1][var_0] = "mp_eadrop_cpkg_03";
  var_1 = "care_package_chute_1";
  level._id_CC34[var_1] = #animtree;
  level._id_CC31[var_1][var_0] = % mp_eadrop_parachute_01;
  level._id_CC32[var_1][var_0] = "mp_eadrop_parachute_01";
  var_1 = "care_package_chute_2";
  level._id_CC34[var_1] = #animtree;
  level._id_CC31[var_1][var_0] = % mp_eadrop_parachute_02;
  level._id_CC32[var_1][var_0] = "mp_eadrop_parachute_02";
  var_1 = "care_package_chute_3";
  level._id_CC34[var_1] = #animtree;
  level._id_CC31[var_1][var_0] = % mp_eadrop_parachute_03;
  level._id_CC32[var_1][var_0] = "mp_eadrop_parachute_03";
}

_id_138B(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(level._id_3E86._id_0E45.size >= 2) {
    if(isDefined(var_0) && isDefined(var_5)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/VEHICLE_REFUND_KILLSTREAK");
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "awardKillstreakFromStruct")) {
        var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "awardKillstreakFromStruct")]](var_5._id_A2B6);
      }
    }
  } else {
    var_6 = [];
    var_7 = scripts\engine\utility::ter_op(isDefined(var_0), "killstreak", "killstreak_no_owner");
    var_8 = 3;
    var_9 = undefined;

    if(isDefined(var_5.cratetype)) {
      var_7 = var_5.cratetype;
    }

    if(isDefined(var_5._id_A777)) {
      var_8 = var_5._id_A777;
    }

    if(isDefined(var_5.usephysics)) {
      var_9 = var_5.usephysics;
    }

    for(var_10 = 0; var_10 < var_8; var_10++) {
      var_11 = undefined;

      if(var_6.size > 0) {
        var_11 = scripts\cp_mp\killstreaks\airdrop::getrandomkillstreak(var_6, var_0, "airdrop_multiple");
      } else {
        var_11 = scripts\cp_mp\killstreaks\airdrop::getrandomkillstreak(undefined, var_0, "airdrop_multiple");
      }

      var_6[var_6.size] = var_11;
    }

    var_12 = _id_138C(var_2);
    var_13 = var_3 * (0, 1, 0);

    if(isDefined(var_5._id_CBD2) && isvector(var_5._id_CBD2)) {
      var_12 = var_12 + var_5._id_CBD2;
    }

    var_14 = spawn("script_model", var_12);
    var_14.angles = var_13;
    var_14 setModel("tag_origin");
    var_14.owner = var_0;
    var_14.team = var_1;
    var_14._id_7590 = isDefined(var_0);
    var_14._id_90D5 = -1;
    var_0 thread scripts\cp_mp\killstreaks\airdrop::_id_1397(var_5);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
      thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("used_airdrop_multiple", var_0);
    }

    var_15 = _id_1388(var_14);
    var_15._id_3E9B = [];
    var_15._id_3702 = [];

    for(var_10 = 0; var_10 < var_8; var_10++) {
      var_16 = undefined;

      switch (var_10) {
        case 0:
          var_16 = "care_package_1";
          break;
        case 1:
          var_16 = "care_package_2";
          break;
        case 2:
          var_16 = "care_package_3";
          break;
      }

      var_17 = scripts\cp_mp\killstreaks\airdrop::getkillstreakcratedatabystreakname(var_6[var_10], 0);
      var_18 = scripts\cp_mp\killstreaks\airdrop::_id_3FB8(var_0, var_1, var_7, var_4, var_9, 0, var_17, var_5, var_15, var_16, "care_package_drop_multiple");

      if(!isDefined(var_18)) {
        break;
      }

      var_16 = undefined;

      switch (var_10) {
        case 0:
          var_16 = "care_package_chute_1";
          break;
        case 1:
          var_16 = "care_package_chute_2";
          break;
        case 2:
          var_16 = "care_package_chute_3";
          break;
      }
    }

    if(var_15._id_3E9B.size < var_8) {
      var_15 thread _id_1393();
      return undefined;
    }

    var_15 thread scripts\cp_mp\killstreaks\airdrop::_id_10AD0(var_12, var_2);
  }
}

_id_1392(var_0) {
  self endon("death");
  _id_1394(var_0);
  thread _id_1393();
}

_id_1394(var_0) {
  var_1 = vectornormalize(anglesToForward(self.angles));
  var_2 = var_0 - var_1 * 70000 / 2.0;
  var_3 = var_0 + var_1 * 70000 / 2.0;
  self.origin = var_2;
  self moveto(var_3, 19.5);
  var_4 = 100;
  var_5 = 3589.74;
  var_6 = 0.4;
  var_7 = var_0 - var_1 * var_5 * var_6;
  var_8 = 0;

  foreach(var_10 in self._id_3E9B) {
    if(isDefined(var_10)) {
      var_10.origin = var_7 + var_1 * var_4 * var_8;
    }

    var_8++;
  }

  wait(9.75 - var_6);

  foreach(var_10 in self._id_3E9B) {
    if(isDefined(var_10)) {
      var_10 show();
      thread scripts\cp_mp\killstreaks\airdrop::_id_4C51(var_10, var_1);
    }

    wait(var_4 / var_5);
  }

  wait(9.75 + var_6);
}

_id_1393() {
  if(isDefined(self._id_0E18)) {
    self._id_0E18 thread _id_138A();
  }

  foreach(var_1 in self._id_3E9B) {
    if(isDefined(var_1)) {
      var_1 thread scripts\cp_mp\killstreaks\airdrop::_id_4843();
    }
  }

  foreach(var_4 in self._id_3702) {
    if(isDefined(var_4)) {
      var_4 thread scripts\cp_mp\killstreaks\airdrop::_id_4842();
    }
  }

  self delete();
}

_id_1388(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1.owner = var_0.owner;
  var_1.team = var_0.team;
  var_1._id_CBD0 = var_0;
  var_0._id_0E18 = var_1;

  if(scripts\mp\utility\game::isholidayenabled(2)) {
    var_1 setModel("suv_gamma503_xmas_00");
    playFXOnTag(level._effect["jeep_sparkle_trail"], var_1, "tag_fx");
    playFXOnTag(level._effect["jeep_reindeer_dogs"], var_1, "tag_dog_00");
    thread _id_084C::_id_3262(var_1);
  } else {
    var_1 setModel("plane_skilo_00");
    thread _id_084C::_id_3262(var_1);
  }

  var_1._id_873F = 1;

  if(isDefined(var_1.owner)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
      var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]]("airdrop_multiple", "Killstreak_Air", var_1.owner, 0, 0);
    }

    if(var_1.team != "neutral" && scripts\cp_mp\utility\script_utility::issharedfuncdefined("sentient", "registerSentient")) {
      var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("sentient", "registerSentient")]]("Killstreak_Air", var_1.owner);
    }
  }

  var_1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop", "monitorDamage")]](2000, "hitequip", ::_id_138A, undefined, 1);
  return var_1;
}

_id_1384() {
  self show();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airdrop_multiple", "monitorDamage")) {
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("airdrop_multiple", "monitorDamage")]](1000, "hitequip", ::_id_1386, ::_id_1385, 1);
  }
}

_id_138A(var_0) {
  var_1 = anglesToForward(self.angles);
  playFX(level._effect["airdrop_m_death"], self.origin, var_1);
  _id_1389();
}

_id_1389(var_0) {
  self notify("death");

  if(isDefined(self._id_CBD0)) {
    self._id_CBD0._id_0E18 = undefined;
  }

  _id_1391(self getentitynumber());
  self._id_CBD0 = undefined;
  self._id_18A4 = undefined;

  if(isDefined(self._id_9F26)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self._id_9F26);
    }

    self._id_9F26 = undefined;
  }

  if(isDefined(var_0) && var_0 > 0) {
    wait(var_0);
  }

  self delete();
}

_id_1385(var_0) {
  var_1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "getModifiedAntiKillstreakDamage")) {
    var_1 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "getModifiedAntiKillstreakDamage")]](var_0.attacker, var_0.objweapon, var_0._id_9CD6, var_0.damage, 1000, 2, 3, 4);
  }

  return var_1;
}

_id_1386(var_0) {
  if(isPlayer(var_0.attacker)) {
    var_1 = 0;

    if(level.teambased && var_0.attacker.team == self.team) {
      var_1 = 1;
    } else if(var_0.attacker == self.owner) {
      var_1 = 1;
    }

    if(!var_1) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
        thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]]("callout_destroyed_ac130", var_0.attacker);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "giveUnifiedPoints")) {
        var_0.attacker thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "giveUnifiedPoints")]]("kill", var_0.objweapon, 400);
      }
    }
  }

  _id_138A();
}

_id_138C(var_0) {
  var_0 = var_0 * (1, 1, 1);
  var_0 = var_0 + (0, 0, scripts\cp_mp\killstreaks\airdrop::_id_6D16() + 200);
  var_0 = var_0 + (0, 0, level._id_3E86._id_0E45.size * 300);
  return var_0;
}

_id_138D() {
  return level._id_3E86._id_0E3E + level._id_3E86._id_0E45.size * level._id_3E86._id_0E3F;
}

_id_1387(var_0) {
  var_1 = var_0 getentitynumber();
  level._id_3E86._id_0E45[var_1] = var_0;
}

_id_1391(var_0) {
  level._id_3E86._id_0E45[var_0] = undefined;
}