/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2475.gsc
*************************************************/

init() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "init")]]();
  }

  level._effect["airstrike_tracer"] = loadfx("vfx/iw8_mp/killstreak/vfx_a10_tracer_sep.vfx");
  level._effect["airstrike_death"] = loadfx("vfx/s4/killstreaks/vfx_airstrike_death_exp_medium.vfx");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "airstrike_params")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "airstrike_params")]]();
  }

  _id_7EBB();
  _id_7EBD();
}

#using_animtree("script_model");

_id_7EBB() {
  level._id_CC34["precision_airstrike"] = #animtree;
  level._id_CC31["precision_airstrike"]["airstrike_flyby"] = % s4_mp_killstreak_strafingrun;
  level._id_CC32["precision_airstrike"]["airstrike_flyby"] = "s4_mp_killstreak_strafingrun";
  level._id_CC34["multi_airstrike"] = #animtree;
  level._id_CC31["multi_airstrike"]["airstrike_flyby"] = % mp_alfa10_flyin;
  level._id_CC32["multi_airstrike"]["airstrike_flyby"] = "mp_alfa10_flyin";
  level._id_CC34["fuel_airstrike"] = #animtree;
  level._id_CC31["fuel_airstrike"]["airstrike_flyby"] = % mp_alfa10_flyin;
  level._id_CC32["fuel_airstrike"]["airstrike_flyby"] = "mp_alfa10_flyin";
  level._id_CC34["toma_strike"] = #animtree;
  level._id_CC31["toma_strike"]["airstrike_flyby"] = % mp_alfa10_flyin;
  level._id_CC32["toma_strike"]["airstrike_flyby"] = "mp_alfa10_flyin";
}

_id_7EBD() {
  game["dialog"]["airspace_crowded"] = "mp_glob_kill_bchr_tafu";
  game["dialog"]["airstrike_good_hit"] = "mp_glob_kill_bchr_tghc";
  game["dialog"]["airstrike_bad_hit"] = "mp_glob_kill_bchr_tgmc";
}

_id_10D89(var_0) {
  var_1 = getdvarint("#x312079e189fd419ce", 2);

  if(istrue(level._id_13DD)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    }

    _id_0A8D::_id_9137("airspace_crowded");
    return 0;
  }

  if(var_0.streakname == "multi_airstrike") {
    var_2 = 1;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "startMapSelectSequence")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "startMapSelectSequence")]](0, 1, var_2);
    }
  } else if(var_0.streakname == "fuel_airstrike") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "startMapSelectSequence")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "startMapSelectSequence")]]();
    }
  }

  return 1;
}

_id_10DDF(var_0, var_1) {
  var_2 = getdvarint("#x312079e189fd419ce", 2);

  if(istrue(var_1)) {
    thread _id_13DC(var_0);

    if(var_0.streakname == "precision_airstrike") {
      if(var_2 == 1) {
        self _meth_8203();
      } else if(var_2 == 2) {
        thread _id_13D6(var_0, level._id_13E3[var_0.streakname]._id_10CCF);
      }
    }
  }
}

_id_13DC(var_0) {
  self endon("disconnect");
  self notifyonplayercommand("cancel_deploy", "+actionslot 3");
  self notifyonplayercommand("cancel_deploy", "+actionslot 4");
  self notifyonplayercommand("cancel_deploy", "+actionslot 5");
  self notifyonplayercommand("cancel_deploy", "+actionslot 6");
  var_1 = scripts\engine\utility::_id_10897("cancel_deploy", "weapon_switch_started");

  if(!isDefined(var_1)) {
    return;
  }
  var_0 notify("killstreak_finished_with_deploy_weapon");
}

_id_10D80(var_0, var_1, var_2) {
  if(!isDefined(var_0._id_EEF2)) {
    var_3 = _id_13C3(self);

    if(!isDefined(var_3)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/INVALID_POINT");
      }

      return "continue";
    }
  }

  if(_id_078D::_id_85B3()) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/CANNOT_BE_USED");
    }

    return "continue";
  }

  return "success";
}

_id_F769(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::_id_4056(var_0, self);
  return _id_F76A(var_1);
}

_id_F76A(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(getdvarint("#x34febe04c90622307", 1) == 0 && var_0.streakname == "precision_airstrike") {
    scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/UNAVAILABLE");
    return 0;
  }

  if(getdvarint("#x3af530b39046c07e3", 1) == 0 && var_0.streakname == "toma_strike") {
    scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/UNAVAILABLE");
    return 0;
  }

  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      return 0;
    }
  }

  var_1 = undefined;
  var_2 = level._id_13E3[var_0.streakname]._id_47EE;

  switch (var_0.streakname) {
    case "precision_airstrike":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
        var_3 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();

        if(var_3 == "br" && isDefined(self._id_8E53)) {
          var_0._id_EEF2 = self._id_8E53;
          self._id_8E53 = undefined;
        }
      }

      if(isDefined(var_0._id_EEF2)) {
        var_4 = _id_10D80(var_0, undefined, undefined);
        var_1 = var_4 == "success";
      } else
        var_1 = _id_09B9::_id_EA03(var_0, var_2, "weapon_fired", ::_id_10D89, ::_id_10DDF, ::_id_10D80);

      break;
    case "toma_strike":
      var_1 = _id_09B9::_id_EA01(var_0, makeweapon("s4_ks_gesture_generic_mp"));
      break;
    case "multi_airstrike":
    case "fuel_airstrike":
      var_1 = _id_09B9::_id_EA04(var_0, var_2, 1, ::_id_10D89, ::_id_10DDF);
      break;
  }

  if(!istrue(var_1)) {
    return 0;
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      return 0;
    }
  }

  var_5 = _id_D050(var_0);

  if(!istrue(var_5)) {
    return 0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "munitionUsed")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "munitionUsed")]]();
  }

  var_6 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var_0.streakname);
    var_6 = 2.0;
  }

  thread scripts\cp_mp\utility\killstreak_utility::_id_B86F("use_" + var_0.streakname, 1, var_6);
  return 1;
}

_id_D050(var_0) {
  var_1 = (0, 0, 0);
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = spawn("script_origin", self.origin);
  var_6 = "used_" + var_0.streakname;

  if(var_0.streakname == "precision_airstrike") {
    if(isDefined(var_0._id_EEF2)) {
      var_1 = var_0._id_EEF2;
    } else {
      var_1 = _id_13C3(self, 1);
    }
  } else if(var_0.streakname == "toma_strike") {
    if(isDefined(var_0._id_EEF2)) {
      var_1 = var_0._id_EEF2;
    } else {
      var_1 = getsmarttargetmaplocation(self);
    }
  } else if(var_0.streakname == "multi_airstrike") {
    var_7 = 3;
    var_4 = 1;
    scripts\common\utility::_id_1593(0);
    self _meth_867F("mp_killstreak_overlay");
    var_2 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "getSelectMapPoint")) {
      var_2 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "getSelectMapPoint")]](var_0, var_7, 1);
    }

    scripts\common\utility::_id_1593(1);
  } else if(var_0.streakname == "fuel_airstrike") {
    var_7 = 1;
    scripts\common\utility::_id_1593(0);
    self _meth_867F("mp_killstreak_overlay");
    var_2 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "getSelectMapPoint")) {
      var_2 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "getSelectMapPoint")]](var_0, var_7);
    }

    scripts\common\utility::_id_1593(1);
  }

  if(isDefined(var_2)) {
    if(istrue(level._id_13DD)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
      }

      _id_0A8D::_id_9137("airspace_crowded");
      return 0;
    }

    thread _id_5B1A(var_2, var_4, var_1, var_3, var_0);
    self _meth_8680("mp_killstreak_overlay");
  } else if(!isDefined(var_2) && (var_0.streakname == "multi_airstrike" || var_0.streakname == "fuel_airstrike")) {
    if(isDefined(var_5)) {
      var_5 stoploopsound("");
      var_5 delete();
    }

    self _meth_8680("mp_killstreak_overlay");
    return 0;
  } else if(var_0.streakname == "precision_airstrike" || var_0.streakname == "toma_strike") {
    if(istrue(level._id_13DD)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
      }

      _id_0A8D::_id_9137("airspace_crowded");
      return 0;
    }

    thread _id_5B1E(var_1, var_3, var_0);
  }

  if(isDefined(var_5)) {
    var_5 stoploopsound("");
    var_5 delete();
  }

  var_0 notify("killstreak_finished_with_deploy_weapon");
  self notify("successful_fire");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "teamPlayerCardSplash")]](var_6, self);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "logKillstreakEvent")]](var_0.streakname, var_1);
  }

  if(level.gametype == "br") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "dangerNotifyPlayersInRange")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "dangerNotifyPlayersInRange")]](var_1, 800, var_0.streakname);
    }
  }

  return 1;
}

getsmarttargetmaplocation(var_0) {
  var_1 = [];
  var_2 = scripts\mp\utility\game::_id_6BE2(var_0.team)[0];
  var_3 = 0;
  var_4 = 0;
  var_5 = 0;
  var_6 = 0;

  foreach(var_8 in level.players) {
    if(var_8 == var_0) {
      continue;
    }
    if(var_8 scripts\mp\utility\perk::_hasperk("specialty_noplayertarget")) {
      continue;
    }
    if(var_8.team == var_2) {
      var_1[var_1.size] = var_8;
      var_3 = var_3 + var_8.origin[0];
      var_4 = var_4 + var_8.origin[1];
    }
  }

  if(var_1.size > 0) {
    var_5 = var_3 / var_1.size;
    var_6 = var_4 / var_1.size;
    var_10 = (var_5, var_6, level._id_9AAC[2]);
  } else
    var_10 = level._id_9AAC;

  return var_10;
}

_id_5B1A(var_0, var_1, var_2, var_3, var_4) {
  self endon("disconnect");
  level endon("game_ended");
  var_5 = level._id_CC31[var_4.streakname]["airstrike_flyby"];
  var_6 = 14;
  var_7 = scripts\engine\utility::_id_65F1(var_5, "attack");
  thread _id_13D8(var_7, var_7 * 2, var_4);

  foreach(var_11, var_9 in var_0) {
    var_2 = var_9._id_96CF;
    var_10 = self.angles[1];

    if(istrue(var_1)) {
      var_10 = var_9.angles;
    }

    _id_5B11(var_2, var_10, var_3, var_4, var_5);

    if(var_0.size > 1 && var_11 < var_0.size - 1) {
      wait(randomfloatrange(0.8, 1.0));
    }
  }

  thread _id_13D7(var_4);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_6);

  if(isDefined(level._id_8DD3)) {
    level thread[[level._id_8DD3]](var_4);
  }

  _id_0A2D::_id_F2DA(self, undefined);
  self notify("airstrike_finished");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - " + var_4.streakname, self);
  }

  scripts\cp_mp\utility\killstreak_utility::_id_C14A(var_4);
  self._id_13DE = undefined;
}

_id_5B1E(var_0, var_1, var_2) {
  self endon("disconnect");
  level endon("game_ended");
  var_3 = 14;
  var_4 = 6.5;
  var_5 = var_2.streakname == "toma_strike";

  if(var_5) {
    var_3 = var_3 * 3 + 45;
    var_4 = var_4 * 3 + 45;
  }

  thread _id_13D8(var_4, var_4 * 2, var_2);
  var_6 = 1;

  if(var_5) {
    var_6 = 3;
  }

  for(var_7 = 0; var_7 < var_6; var_7++) {
    _id_5B11(var_0, undefined, var_1, var_2);

    if(var_5) {
      wait 15;
    }
  }

  thread _id_13D7(var_2);

  if(!var_5) {
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_3);
  }

  if(isDefined(level._id_8DD3)) {
    level thread[[level._id_8DD3]](var_2);
  }

  _id_0A2D::_id_F2DA(self, undefined);
  self notify("airstrike_finished");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "printGameAction")) {
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "printGameAction")]]("killstreak ended - " + var_2.streakname, self);
  }

  scripts\cp_mp\utility\killstreak_utility::_id_C14A(var_2);
  self._id_13DE = undefined;
}

_id_5B11(var_0, var_1, var_2, var_3) {
  self notify("used");
  self notify("airstrike_used");
  level thread _id_4C38(var_0, var_1, self, self.pers["team"], var_2, var_3);
}

_id_4C38(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_0A2D::_id_F2DA(var_2, 1);
  thread _id_10A89();
  _id_2FD6(var_2, var_0, var_1, var_4, var_5);
}

_id_10A89() {
  self endon("airstrike_finished");
  level endon("game_ended");
  self notify("watching_airstike_owner");
  self endon("watching_airstike_owner");
  scripts\engine\utility::waittill_any_2("disconnect", "joined_team");

  if(istrue(level._id_13DD)) {
    _id_0A2D::_id_F2DA(self, undefined);
  }
}

_id_2FD6(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;
  var_6 = scripts\cp_mp\utility\killstreak_utility::_id_6ADB();
  var_7 = 24000;
  var_8 = 6500;
  var_9 = level._id_13E3[var_4.streakname]._id_B18D;
  var_5 = 1500;
  var_10 = scripts\cp_mp\utility\game_utility::_id_6B18();

  if(isDefined(var_10) && var_10 == "locale_6") {
    var_9 = var_9 + 500;
  }

  if(level.mapname == "mp_br_mechanics" || level.mapname == "mp_donetsk") {
    var_9 = var_9 + 2500;
  }

  if(isDefined(level.airstrikeheightoffset)) {
    var_9 = var_9 + level.airstrikeheightoffset;
  }

  var_5 = _id_6A21(var_9);
  var_12 = undefined;
  var_13 = undefined;

  if(isDefined(var_2)) {
    var_12 = (0, var_2, 0);
  } else {
    var_12 = _id_2FD8(var_0, var_1, var_9);
    var_13 = 1;
  }

  var_14 = _id_6A4E(var_1, var_12, var_7, var_6, var_9, var_8, var_5, var_4.streakname, var_13);

  if(var_4.streakname == "precision_airstrike") {
    var_9 = var_9 + randomintrange(200, 300);
    level thread _id_4E65(var_1, var_14["startPoint"], var_14["endPoint"], var_9, var_3, var_4, var_0);
  } else if(var_4.streakname == "toma_strike") {
    var_9 = var_9 + randomintrange(200, 300);
    var_1 = getsmarttargetmaplocation(var_0);
    var_15 = getsmarttargetflightpath(var_0, var_1, var_12, var_7, var_6, var_9, var_8, var_5, var_4.streakname, var_13);
    level thread _id_4E65(var_1, var_15["startPoint"], var_15["endPoint"], var_9, var_3, var_4, var_0);
  } else
    level thread _id_4E65(var_1, var_14["startPoint"], var_14["endPoint"], var_9, var_3, var_4, var_0);
}

getsmarttargetflightpath(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = [];
  var_11 = 8;
  var_12 = 360 / var_11;

  for(var_13 = 0; var_13 < var_11 / 2; var_13++) {
    var_14 = (0, var_13 * var_12, 0);
    var_10[var_13] = _id_6A4E(var_1, var_2, var_3, var_4, var_5, var_6, var_7);
  }

  var_15 = var_10[0];
  var_16 = 250000;
  var_17 = 0;
  var_18 = 0;
  var_19 = [];
  var_20 = scripts\mp\utility\game::_id_6BE2(var_0.team)[0];

  foreach(var_22 in level.players) {
    if(var_22 == var_0) {
      continue;
    }
    if(var_22.team == var_20) {
      var_19[var_19.size] = var_22;
    }
  }

  for(var_13 = 0; var_13 < var_10.size; var_13++) {
    var_24 = var_10[var_13];
    var_25 = 0;

    foreach(var_27 in var_19) {
      if(var_27 scripts\mp\utility\perk::_hasperk("specialty_noplayertarget")) {
        continue;
      }
      var_28 = _func_01A4(var_24["startPoint"], var_24["endPoint"], var_27.origin);

      if(distance2dsquared(var_27.origin, var_28) <= var_16) {
        var_25 = var_25 + 1;
      }
    }

    var_28 = _func_01A4(var_24["startPoint"], var_24["endPoint"], var_0.origin);

    if(distance2dsquared(var_0.origin, var_28) <= var_16) {
      var_25 = var_25 - 2;
    }

    if(var_25 > var_17) {
      var_17 = var_25;
      var_18 = var_13;
    }
  }

  return var_10[var_18];
}

_id_2FD8(var_0, var_1, var_2) {
  var_3 = anglesToForward(var_0 getplayerangles());
  var_4 = scripts\engine\trace::_id_3EF6(1);
  var_5 = scripts\engine\trace::ray_trace(var_1 - var_3 * 30, var_1 + var_3 * 1000, undefined, var_4);
  var_1 = var_5["position"] + var_5["normal"] * 20;
  var_6 = var_1;
  var_7 = var_2 * 3;
  var_8 = anglesToForward(var_0.angles);
  var_9 = anglestoright(var_0.angles);
  var_10 = 0;
  var_11 = [var_6 + var_8 * 100, var_6 - var_8 * 100, var_6 + var_9 * 100, var_6 - var_9 * 100, var_6 + (var_8 + var_9) * 100, var_6 + (var_8 - var_9) * 100, var_6 + (var_9 - var_8) * 100, var_6 + (-1 * var_8 - var_9) * 100];
  var_12 = vectornormalize(var_11[0] - var_6);
  var_13 = 0;

  foreach(var_15 in var_11) {
    var_16 = vectornormalize(var_15 - var_6);
    var_17 = var_6 + (0, 0, var_7) - var_16 * 25000;
    var_18 = [var_6, var_6 - var_16 * 512, var_6 - var_16 * 256, var_6 + var_16 * 256, var_6 + var_16 * 512];
    var_19 = 0;

    foreach(var_21 in var_18) {
      var_22 = scripts\engine\trace::ray_trace_passed(var_17, var_21, undefined, var_4);

      if(!istrue(var_22)) {
        wait 0.05;
        break;
      }

      var_19++;
      wait 0.05;
    }

    if(var_19 > var_13) {
      var_12 = var_16;
      var_13 = var_19;

      if(var_19 >= 3) {
        break;
      }
    }
  }

  return var_12;
}

_id_4E65(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = level._id_13E3[var_5.streakname];
  var_8 = 14;
  var_9 = 6.5;
  var_10 = var_0 + (0, 0, var_3);
  var_11 = vectortoangles(var_2 - var_1);

  if(var_5.streakname == "precision_airstrike") {
    var_10 = var_10 - anglesToForward(var_11) * 11000 / 2.0;
  } else {
    var_10 = var_10 - anglesToForward(var_11) * 50000 / 2.0;
  }

  var_12 = var_7.modelbase;

  if(scripts\cp_mp\utility\player_utility::_id_6C67(var_6) && isDefined(var_7._id_9FD1)) {
    var_12 = var_7._id_9FD1;
  }

  var_13 = spawn("script_model", var_10);
  var_13 setModel(var_12);
  var_13.angles = var_11;
  var_13._id_5CF2 = anglesToForward(var_11);
  var_13._id_5CF3 = var_3;
  var_13.owner = var_6;
  var_13.team = var_6.team;
  var_13._id_936C = var_5._id_936C;
  var_13.streakinfo = var_5;
  var_13 setotherent(var_6);
  var_13 _meth_856D();
  var_13 _meth_85AF();
  var_13 _meth_856C();
  level notify("airstrike_plane_spawned", var_13.angles);

  if(var_5.streakname == "precision_airstrike") {
    var_13._id_F81F = spawn("script_model", var_13 gettagorigin("tag_turret"));
    var_13._id_F81F setModel("plane_wm_dalpha_turret_front");
    var_13._id_F81F.angles = var_13 gettagangles("TAG_TURRET");
    var_13._id_F81F linkto(var_13, "tag_turret");
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    var_13[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](var_5.streakname, "Killstreak_Air", var_6, 0, 1, 100);
  }

  var_14 = undefined;

  switch (var_5.streakname) {
    case "precision_airstrike":
      var_14 = "v_ui_icon_hud_minimap_killstreak06";
      break;
    case "toma_strike":
      var_14 = "v_ui_icon_hud_minimap_killstreak01";
      break;
  }

  if(isDefined(var_14) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "createObjective")) {
    var_13._id_9F26 = var_13[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "createObjective")]](var_14, var_13.team, undefined, 1, 1);
  }

  var_15 = var_9 - 0.75;
  var_16 = var_9;
  var_17 = 8.596;

  if(var_5.streakname == "fuel_airstrike") {
    var_15 = var_9 + 1;
  }

  var_13._id_873F = 1;
  var_13 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "monitorDamage")]](100, "hitequip", ::_id_7481, ::_id_7480, 1);
  level thread _id_13CC(var_13, var_1, anglesToForward(var_11), var_16, var_17, var_8, var_5);
  var_13._id_2D35 = spawn("script_model", var_13.origin);
  var_13._id_2D35 setModel("ks_airstrike_target_mp");
  var_13._id_2D35 setentityowner(var_6);
  var_13._id_2D35.weapon_name = "s4_strafing_run_mp";
  var_13._id_2D35.streakinfo = var_5;
  var_13._id_2D35.angles = var_13.angles;
  var_13._id_2D35 dontinterpolate();
  var_13._id_18AF = var_5.streakname;
  var_13 _id_06C6::_id_D47B();
  var_13._id_CBD0 = spawn("script_model", var_10);
  var_13._id_CBD0.angles = var_13.angles;
  var_13._id_CBD0 setModel("tag_origin");

  if(var_5.streakname == "precision_airstrike" || var_5.streakname == "multi_airstrike") {
    level thread _id_2FDC(var_13, var_15, var_8, var_0, var_6);
    thread _id_084C::_id_13C9(var_13, var_10, var_13._id_5CF2, 11000, 14, var_5.streakname);
  } else if(var_5.streakname == "fuel_airstrike")
    level thread _id_2FD9(var_13, var_15, var_8, var_0, var_6);
  else if(var_5.streakname == "toma_strike") {
    level thread _id_2FD7(var_13, var_15, var_8, var_0, var_6, var_5);
    thread _id_084C::_id_13C9(var_13, var_10, var_13._id_5CF2, 50000, 14, var_5.streakname);
  }

  var_19 = var_10 + var_13._id_5CF2 * 50000;

  if(var_5.streakname == "precision_airstrike") {
    var_13._id_CBD0 _id_06C6::_id_1845(var_13, "airstrike_flyby");
  }

  if(var_5.streakname == "toma_strike") {
    var_13 moveto(var_19, 14);
    var_13 thread bombingrunroll();
    wait 14;
  }

  if(isDefined(var_13._id_9F26)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](var_13._id_9F26);
    }
  }

  var_13 notify("delete");

  if(isDefined(var_13._id_F899)) {
    var_13._id_F899 delete();
  }

  if(isDefined(var_13._id_2D35)) {
    var_13._id_2D35 delete();

    if(isDefined(var_13._id_2D35.killcament)) {
      var_13._id_2D35.killcament delete();
    }
  }

  if(isDefined(var_13._id_CBD0)) {
    var_13._id_CBD0 delete();
  }

  if(isDefined(var_13)) {
    var_13 delete();
  }
}

_id_7480(var_0) {
  return var_0.damage;
}

_id_7481(var_0) {
  var_1 = var_0.attacker;
  _id_4860();
}

_id_4860() {
  var_0 = anglesToForward(self.angles);
  playFX(level._effect["airstrike_death"], self.origin, var_0);
  self notify("aud_plane_destruct_sequence");
  thread _id_4786(0);
}

_id_4786(var_0) {
  self notify("death");
  self._id_87FB = 1;
  wait(var_0);

  if(isDefined(self._id_9F26)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self._id_9F26);
    }
  }

  self delete();
}

bombingrunroll() {
  self endon("death");
  level endon("game_ended");
  var_0 = 1;
  var_1 = randomfloatrange(1.0, 1.5);
  var_2 = randomintrange(5, 10);
  self rotateroll(var_2 * var_0, var_1);
  wait(var_1);

  for(;;) {
    var_0 = var_0 * -1;
    self rotateroll(var_2 * var_0 * 2, var_1 * 2);
    wait(var_1 * 2);
  }
}

_id_13CE(var_0, var_1, var_2) {
  var_0 endon("death");
  level endon("game_ended");

  if(var_2.streakname == "fuel_airstrike") {
    return;
  }
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);
  var_0 setscriptablepartstate("fire", "on", 0);
  var_0 waittill("fire_finished");
  var_0 setscriptablepartstate("fire", "off", 0);
}

_id_13CC(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 endon("death");
  level endon("game_ended");
  var_0 thread _id_13C0(0.05);
  var_7 = spawn("script_model", var_1 + var_2 * 2000);
  var_7 setModel("ks_airstrike_mp");
  var_7 dontinterpolate();
  var_7 thread _id_13CA();
  var_7 thread _id_13CB();
  var_7 thread _id_13CD(var_4);
  var_7 thread _id_13C4(var_5);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_3);
  var_7 thread _id_13C7(var_0);
  var_0 setscriptablepartstate("flyby", "on", 0);
}

_id_13CA() {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);
  self setscriptablepartstate("approach", "on", 0);
}

_id_13CB() {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(6.397);
  self setscriptablepartstate("flyby", "on", 0);
}

_id_13CD(var_0) {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self setscriptablepartstate("flyout", "on", 0);
}

_id_13C4(var_0) {
  self endon("death");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self notify("stop_update_fx_movement");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(10);
  self delete();
}

_id_13C7(var_0) {
  self endon("death");
  self endon("stop_update_fx_movement");
  level endon("game_ended");

  while(isDefined(var_0)) {
    self.origin = var_0.origin;
    wait 0.05;
  }
}

_id_13D8(var_0, var_1, var_2) {
  self endon("disconnect");
  childthread _id_13DA(var_1, var_2);
  childthread _id_13D9(var_2);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self waittill("finished_wait_killstreak_kills_" + var_2.streakname);

  if(isDefined(self._id_13DE)) {
    if(self._id_13DE >= 1) {
      _id_0A8D::_id_9137("airstrike_good_hit");
    } else {
      _id_0A8D::_id_9137("airstrike_bad_hit");
    }
  }
}

_id_13DA(var_0, var_1) {
  self endon("finished_wait_killstreak_kills_" + var_1.streakname);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self notify("finished_wait_killstreak_kills_" + var_1.streakname);
}

_id_13D9(var_0) {
  self endon("finished_wait_killstreak_kills_" + var_0.streakname);
  self._id_13DE = 0;

  for(;;) {
    self waittill("update_rapid_kill_buffered", var_1, var_2);

    if(isDefined(var_2) && var_2 == "s4_strafing_run_mp") {
      self._id_13DE++;
    }
  }
}

_id_F0E1(var_0) {
  var_0 endon("death");

  for(;;) {
    wait 0.05;
  }
}

_id_2FD7(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("death");
  var_6 = var_0._id_5CF2;
  var_7 = var_3 + (0, 0, var_0._id_5CF3 + 750);
  var_8 = var_7 - var_6 * 15000;
  var_9 = var_7 - var_6 * 500;
  var_10 = var_7;
  var_11 = spawn("script_model", var_8);
  var_11 thread _id_13C5(var_1 - 3, var_9, var_10);
  var_0._id_2D35.killcament = var_11;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);

  if(!isDefined(var_4)) {
    return;
  }
  var_12 = undefined;

  for(var_13 = 0; var_13 < 12; var_13++) {
    var_14 = var_0.origin - (0, 0, 15);
    var_15 = spawnStruct();
    var_16 = (0, 0, 0);

    if(var_13 % 2 == 0) {
      var_16 = anglestoright(var_0.angles) * randomintrange(0, 56);
    } else {
      var_16 = anglestoleft(var_0.angles) * randomintrange(0, 56);
    }

    var_15._id_E06F = var_14 + var_16;
    var_15._id_0200 = var_3 + var_6 * 5 + var_16;

    if(!isDefined(var_12)) {
      var_12 = vectornormalize(var_15._id_0200 - var_15._id_E06F) * 500 + anglesToForward(var_0.angles) * 256;
    }

    var_15._id_82B5 = var_12;
    var_4 thread _id_09BC::_id_F313(var_15, var_5, var_0);
    var_17 = randomintrange(1, 4);
    wait(0.05 * var_17);
  }
}

_id_2FDC(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");
  var_5 = var_0._id_5CF2;
  var_6 = var_3 + (0, 0, var_0._id_5CF3 + 750);
  var_7 = var_6 - var_5 * 15000;
  var_8 = var_6 - var_5 * 500;
  var_9 = var_6;
  var_10 = spawn("script_model", var_7);
  var_10 thread _id_13C5(var_1 - 3, var_8, var_9);
  var_0._id_2D35.killcament = var_10;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);

  if(!isDefined(var_4)) {
    return;
  }
  var_11 = 5;
  var_12 = (0, 0, 0);
  var_13 = var_12;
  var_0._id_2D35 setscriptablepartstate("bullet_impact", "on", 0);
  var_14 = 0;
  var_15 = 0;
  var_16 = [var_3 - var_5 * 896, var_3 - var_5 * 768, var_3 - var_5 * 640, var_3 - var_5 * 512, var_3 - var_5 * 384, var_3 - var_5 * 256, var_3 - var_5 * 128, var_3, var_3 + var_5 * 128, var_3 + var_5 * 256, var_3 + var_5 * 512, var_3 + var_5 * 640];
  var_11 = var_16.size;

  foreach(var_18 in var_16) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "addSpawnDangerZone")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "addSpawnDangerZone")]](var_18, 512, 512, var_4.team, 5, var_4, 1);
    }
  }

  thread _id_084C::_id_E9F9(var_0, var_11);
  var_24 = var_3[2] + var_0._id_5CF3 * 3;

  for(var_25 = 0; var_25 < var_11; var_25++) {
    if(!isDefined(var_4)) {
      break;
    }

    var_26 = -50;
    var_27 = 150;

    while(var_14 < var_15 + 2) {
      var_28 = rotatevector(var_5, (0, 90, 0));
      var_28 = var_28 * 50;
      var_29 = var_16[var_25] + scripts\engine\utility::ter_op(var_14 % 2 == 0, var_28, -1 * var_28);
      var_30 = scripts\engine\utility::ter_op(var_14 % 2 == 0, "TAG_MUZZLE_FX_1", "TAG_MUZZLE_FX_2");
      var_31 = var_0._id_F81F gettagorigin(var_30) * (1, 1, 0) + (0, 0, var_24) + var_5 * 1000;
      var_33 = vectornormalize(var_29 - var_31);
      var_34 = var_29 + var_33 * 30000;
      var_35 = scripts\engine\trace::ray_trace(var_31, var_34, undefined, scripts\engine\trace::_id_3EE5(0, 1, 0, 1, 0, 1, 0));
      var_36 = var_35["position"];
      var_37 = var_35["normal"];
      var_38 = var_36 + var_37 * 10;
      var_39 = vectornormalize(var_36 - var_0._id_F81F gettagorigin(var_30) + (0, 0, 64));
      var_40 = _func_025B(var_39, (0, 0, 1));
      var_41 = _func_025B(var_40, var_39);
      var_0 thread _id_2FDB(scripts\engine\utility::getfx("airstrike_tracer"), var_38, var_39, var_41);
      var_0._id_2D35 thread _id_A222(var_14 + 1, var_38);
      var_13 = var_36;
      var_14++;
      var_0._id_2D35.streakinfo._id_DA63++;
      var_26 = var_26 + 20;
      var_27 = var_27 + 40;
      var_24 = var_24 - 200;

      if(var_24 < var_0._id_5CF3) {
        var_24 = var_0._id_5CF3;
      }

      wait 0.05;
    }

    var_15 = var_14;
  }

  var_0 notify("fire_finished");
  var_0._id_2D35 setscriptablepartstate("bullet_impact", "off", 0);
}

_id_2FDA(var_0, var_1, var_2, var_3) {
  var_3 = var_3 * (0, 1, 0);
  var_4 = anglesToForward(var_3);
  var_5 = anglestoright(var_3);
  var_6 = randomintrange(var_0, var_1);
  var_7 = randomint(80) - 40;
  var_8 = var_4 * cos(var_7) * var_6;
  return var_2 + var_8 + var_5 * sin(var_7) * var_6;
}

_id_2FDB(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4 = 0;
  var_5 = 1;

  while(var_4 < var_5) {
    playFX(var_0, var_1, var_2, var_3);
    var_4++;
    wait 0.05;
  }
}

_id_A222(var_0, var_1) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.18);
  self.origin = var_1;
  self setscriptablepartstate("explode" + var_0, "active", 0);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);
  self setscriptablepartstate("explode" + var_0, "neutral", 0);
}

_id_2FD9(var_0, var_1, var_2, var_3, var_4) {
  var_0 endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1);

  if(!isDefined(var_4)) {
    return;
  }
  var_5 = var_0._id_5CF2;
  var_6 = [var_3 - var_5 * 1200, var_3 - var_5 * 600, var_3, var_3 + var_5 * 600, var_3 + var_5 * 1200];

  foreach(var_8 in var_6) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("airstrike", "addSpawnDangerZone")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("airstrike", "addSpawnDangerZone")]](var_8, 650, 650, var_4.team, var_2, var_4, 1);
    }
  }

  foreach(var_8 in var_6) {
    var_12 = var_8 + (0, 0, 2500);
    var_13 = var_8 - (0, 0, 10000);
    var_14 = scripts\engine\trace::ray_trace(var_12, var_13, undefined, scripts\engine\trace::_id_3EE5(0, 1, 0, 1, 0, 1, 0));
    var_15 = var_14["position"];
    var_16 = var_14["normal"];
    var_17 = var_15 + var_16 * 10;
    var_18 = spawn("script_model", var_17 + (0, 0, 400));
    var_18 setModel("ks_fuelstrike_mp");
    var_18 setscriptablepartstate("release", "on", 0);
    var_19 = spawn("script_model", var_17);
    var_19 setModel("ks_fuelstrike_mp");
    var_19 setscriptablepartstate("ignite", "on", 0);
    var_19 setentityowner(var_4);
    level thread _id_46AB(var_18, var_19);
    wait 0.25;
  }
}

_id_46AB(var_0, var_1) {
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(10);

  if(isDefined(var_0)) {
    var_0 delete();
  }

  if(isDefined(var_1)) {
    var_1 delete();
  }
}

_id_6A4E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = undefined;

  if(istrue(var_8)) {
    var_9 = var_1;
  } else {
    var_9 = anglesToForward(var_1);
  }

  var_10 = var_0 + var_9 * (-1 * var_2);

  if(isDefined(var_3)) {
    var_10 = var_10 * (1, 1, 0);
  }

  var_10 = var_10 + (0, 0, var_4);
  var_11 = var_0 + var_9 * var_2;

  if(isDefined(var_3)) {
    var_11 = var_11 * (1, 1, 0);
  }

  var_11 = var_11 + (0, 0, var_4);
  var_12 = length(var_10 - var_11);
  var_13 = var_12 / var_5;
  var_12 = abs(var_12 / 2 + var_6);
  var_14 = var_12 / var_5;
  var_15["startPoint"] = var_10;
  var_15["endPoint"] = var_11;
  var_15["bombTime"] = var_14;
  var_15["flyTime"] = var_13;
  var_15["directionAngles"] = var_9;
  return var_15;
}

_id_6A21(var_0) {
  var_1 = 850;
  var_2 = 1500;
  var_3 = var_1 / var_0;
  var_4 = var_3 * var_2;
  return var_4;
}

_id_13C3(var_0, var_1) {
  var_2 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicleclip"];
  var_3 = physics_createcontents(var_2);
  var_4 = var_0 getvieworigin();
  var_5 = var_4 + anglesToForward(var_0 getplayerangles()) * 50000;
  var_6 = var_0 scripts\cp_mp\utility\killstreak_utility::_id_B702();
  var_7 = scripts\engine\trace::ray_trace(var_4, var_5, var_6, var_3);
  var_8 = var_7["position"];

  if(var_7["hittype"] == "hittype_none") {
    var_8 = undefined;
  }

  return var_8;
}

_id_13D6(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("deploy_cancelled");
  self endon("deploy_fired");
  var_2 = spawn("script_model", self.origin);
  var_2 setModel("ks_airstrike_marker_mp");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "requestObjectiveID")) {
    var_2._id_A908 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "requestObjectiveID")]](99);
  }

  var_2 setotherent(self);
  var_2 dontinterpolate();
  var_2 hide();
  var_3 = "icon_waypoint_airstrike";

  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  var_2 _id_13D0(var_2._id_A908, var_3, self, 50);
  var_2 thread _id_13DB(self);
  var_2 thread _id_13D4(self);
  var_2 thread _id_13D5(self);
  var_2._id_FCB9 = 0;
  scripts\common\utility::_id_153E(0);

  for(;;) {
    if(_id_078D::_id_85B3() && istrue(var_2._id_FCB9)) {
      scripts\common\utility::_id_153E(0);
      var_2 hide();
      var_2 setscriptablepartstate("marker_scope", "off", 0);
      self notify("stop_update_marker");
      var_2._id_FCB9 = 0;
    }

    var_4 = self playerads();

    if(var_4 == 1 && !istrue(var_2._id_FCB9)) {
      if(!_id_078D::_id_85B3()) {
        scripts\common\utility::_id_153E(1);
        var_2 show();
        var_2 setscriptablepartstate("marker_scope", "on", 0);
        var_2 thread _id_13D3(self);
        var_2._id_FCB9 = 1;
      }
    } else if(var_4 < 1 && istrue(var_2._id_FCB9)) {
      scripts\common\utility::_id_153E(0);
      var_2 hide();
      var_2 setscriptablepartstate("marker_scope", "off", 0);
      self notify("stop_update_marker");
      var_2._id_FCB9 = 0;
    }

    waitframe();
  }
}

_id_13D0(var_0, var_1, var_2, var_3) {
  _func_015D(var_0, var_1);
  _func_018C(var_0);
  _func_0185(var_0, var_2);
  _func_0160(var_0, self);
  _func_0161(var_0, var_3);
  _func_0172(var_0, 0);
  _func_0173(var_0, 0);
  _func_017A(var_0, 1);

  if(level.teambased) {
    _func_0182(var_0, var_2.team);
  } else {
    _func_0181(var_0, var_2);
  }

  _func_016B(var_0, "done");
}

_id_13D3(var_0) {
  self endon("death");
  var_0 endon("deploy_cancelled");
  var_0 endon("deploy_fired");
  var_0 endon("stop_update_marker");
  var_0 endon("death_or_disconnect");
  var_1 = 0;
  var_0 setclientomnvar("ui_spotter_scope_danger", 0);

  for(;;) {
    var_2 = _id_13C3(var_0);
    var_3 = -1;
    var_4 = -1;
    var_5 = -1;

    if(isDefined(var_2)) {
      self.origin = var_2;
      var_3 = int(self.origin[0]);
      var_4 = int(self.origin[1]);
      var_5 = int(self.origin[2]);
    }

    var_0 setclientomnvar("ui_ac130_coord3_posx", var_3);
    var_0 setclientomnvar("ui_ac130_coord3_posy", var_4);
    var_0 setclientomnvar("ui_ac130_coord3_posz", var_5);

    if(isDefined(var_2)) {
      if(!istrue(var_1) && distance2dsquared(var_0.origin, var_2) <= 1638400) {
        var_0 setclientomnvar("ui_spotter_scope_danger", 1);
        var_1 = 1;
      } else if(istrue(var_1) && distance2dsquared(var_0.origin, var_2) > 1638400) {
        var_0 setclientomnvar("ui_spotter_scope_danger", 0);
        var_1 = 0;
      }
    }

    waitframe();
  }
}

_id_13DB(var_0) {
  self endon("death");
  level endon("game_ended");
  var_0 waittill("death_or_disconnect");
  _id_13CF();
}

_id_13D4(var_0) {
  var_0 endon("death_or_disconnect");
  self endon("death");
  level endon("game_ended");
  var_1 = var_0 scripts\engine\utility::_id_10897("cancel_fire", "successful_fire");

  if(isDefined(var_1) && var_1 == "successful_fire") {
    var_0 notify("deploy_fired");
    self setscriptablepartstate("marker_scope", "off", 0);
    var_2 = anglesToForward(var_0 getplayerangles());
    var_3 = var_0 getEye();
    var_4 = vectornormalize(self.origin - var_3);
    var_5 = self.origin + var_4 * 20;
    var_6 = scripts\engine\trace::ray_trace(var_3, var_5, var_0);
    var_7 = var_6["normal"];
    level waittill("airstrike_plane_spawned", var_8);
    self.angles = var_8;
    self.angles = _func_0316(var_7, self.angles);
    self setscriptablepartstate("marker_placed", "on", 0);
    _func_016B(self._id_A908, "current");
    thread _id_13CF(7);
  } else {
    var_0 notify("deploy_cancelled");
    var_0 notify("cancel_all_killstreak_deployments");

    if(!var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isPlayerADS")]]()) {
      var_0 scripts\common\utility::_id_153E(1);
    }

    _id_13CF();
  }
}

_id_13D5(var_0) {
  var_0 endon("death_or_disconnect");
  self endon("death");
  level endon("game_ended");
  var_1 = var_0 getcurrentweapon();

  for(;;) {
    if(var_0 getcurrentweapon() != var_1) {
      break;
    }

    waitframe();
  }

  var_0 notify("cancel_fire");
}

_id_13CF(var_0) {
  if(isDefined(var_0)) {
    self endon("death");
    level endon("game_ended");
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  }

  if(isDefined(self._id_A908)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "returnObjectiveID")]](self._id_A908);
    }
  }

  self delete();
}

_id_13C0(var_0) {
  self endon("death");
  level endon("game_ended");
  wait(var_0);
  self setscriptablepartstate("bodyfx", "on", 0);
}

_id_13C5(var_0, var_1, var_2) {
  self endon("death");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  self moveto(var_1, 4);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.95);
  self moveto(var_2, 5);
}

_id_13D7(var_0) {
  self endon("airstrike_finished");
  self endon("disconnect");
  level waittill("game_ended");
  scripts\cp_mp\utility\killstreak_utility::_id_C14A(var_0);
}