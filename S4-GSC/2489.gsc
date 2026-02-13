/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2489.gsc
*************************************************/

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);

    if(!isDefined(var_0.pers["startedMapSelect"])) {
      var_0.pers["startedMapSelect"] = 0;
    }
  }
}

_id_316C(var_0, var_1) {
  if(!scripts\cp_mp\utility\killstreak_utility::_id_8DC7(var_0.streakname)) {
    if(isDefined(level._id_8DE2) && level._id_8DE2 > 0) {
      if(level._id_7116 - level._id_7EB0 < level._id_8DE2) {
        var_2 = level._id_8DE2 - (level._id_7116 - level._id_7EB0);

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/UNAVAILABLE_FOR_N", var_2);
        }

        return 0;
      }
    }
  }

  if(isDefined(var_1)) {
    var_3 = _id_316D(var_0, var_1);

    if(isDefined(var_3)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]](var_3);
      }

      return 0;
    }

    if(isDefined(self._id_8A19) && self._id_8A19 && var_1.basename == "s4_ks_gesture_generic_mp") {
      self playsoundtoplayer("ui_mp_splash_jammer_nodeploy", self);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("SUPER_MP/CALL_IN_JAMMED");
      }

      return 0;
    } else if(isDefined(self._id_024A) && self._id_024A && var_1.basename == "s4_ks_gesture_generic_mp" && var_0.streakname != "nuke" && var_0.streakname != "counter_spy_plane" && var_0.streakname != "toma_strike" && var_0.streakname != "glide_bomb") {
      self playsoundtoplayer("ui_mp_splash_jammer_nodeploy", self);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/CALL_IN_JAMMED_COUNTER_SPY_PLANE");
      }

      return 0;
    }
  }

  return 1;
}

_id_AAB1(var_0) {
  var_0._id_87F8 = 1;
  var_0.owner._id_87F8 = 1;

  switch (var_0.streakname) {
    case "white_phosphorus":
    case "precision_airstrike":
      self setclientomnvar("ui_binoculars", 1);
      break;
  }

  var_0.owner scripts\common\utility::_id_152F(0);
}

_id_AAB0(var_0, var_1) {
  var_0._id_87F8 = 0;
  var_0.owner._id_87F8 = 0;

  switch (var_0.streakname) {
    case "white_phosphorus":
    case "precision_airstrike":
      self setclientomnvar("ui_binoculars", 0);
      break;
  }

  var_0.owner scripts\common\utility::_id_152F(1);
}

_id_EA00() {
  self notify("cancel_all_killstreak_deployments");
}

_id_EA01(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");

  if(!_id_316C(var_0, var_1)) {
    return 0;
  }

  _id_AAB1(var_0);
  thread _id_10AF9(var_0, var_1);
  var_2 = _id_EA06(var_1);
  var_0 notify("gesture_deploy_ended");
  _id_AAB0(var_0, var_2);
  return var_2;
}

_id_10AF9(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  var_0 endon("gesture_deploy_ended");
  self waittill("cancel_all_killstreak_deployments");
  self takeweapon(var_1);
}

_id_EA04(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!_id_316C(var_0, var_1)) {
    return 0;
  }

  _id_AAB1(var_0);
  var_7 = scripts\engine\utility::ter_op(istrue(var_2), ::_id_1097E, undefined);
  var_8 = _id_EC37(var_1, var_0, var_7, var_3, var_4, var_5, var_6);

  if(!istrue(var_8)) {
    _id_AAB0(var_0, 0);
    return 0;
  }

  _id_AAB0(var_0, var_8);
  return 1;
}

_id_EA03(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  if(!_id_316C(var_0, var_1)) {
    return 0;
  }

  _id_AAB1(var_0);
  var_8 = _id_EC37(var_1, var_0, ::_id_1097E, var_3, var_4, var_6, var_7);

  if(!istrue(var_8)) {
    _id_AAB0(var_0, 0);
    return 0;
  }

  scripts\common\utility::_id_1562(0);
  var_9 = _id_10AC8(var_0, var_2, var_1, var_5);
  scripts\common\utility::_id_1562(1);
  _id_AAB0(var_0, var_9);
  return istrue(var_9);
}

_id_EA05(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("game_ended");
  self endon("disconnect");
  var_8 = "ks_remote_device_mp";

  if(isDefined(var_5)) {
    var_8 = var_5;
  }

  var_9 = makeweapon(var_8);
  var_10 = 1.6;

  if(var_8 == "ks_remote_nuke_mp") {
    var_10 = 2.133;
  } else if(var_8 == "s4_ks_remote_ball_turret_gunner_mp") {
    var_10 = 0.7;
  }

  if(!_id_316C(var_0, var_9)) {
    return 0;
  }

  _id_AAB1(var_0);
  thread _id_EA07(var_0);

  if(!istrue(var_7)) {
    scripts\cp_mp\utility\killstreak_utility::_id_E72A(var_0.streakname, 0.75);
  }

  scripts\common\utility::_id_1559(0);
  scripts\common\utility::_id_154E(0);
  scripts\common\utility::_id_158A(0);
  scripts\common\utility::_id_1554(0);
  scripts\common\utility::_id_1562(0);
  var_11 = _id_EC37(var_9, var_0, ::_id_1097E, var_1, var_2, var_3, var_4);

  if(isDefined(self) && scripts\cp_mp\utility\player_utility::_isalive()) {
    scripts\common\utility::_id_1559(1);
    scripts\common\utility::_id_154E(1);
    scripts\common\utility::_id_158A(1);
    scripts\common\utility::_id_1554(1);
    scripts\common\utility::_id_1562(1);
  }

  if(!istrue(var_11)) {
    _id_AAB0(var_0, 0);

    if(isDefined(self) && !istrue(var_7)) {
      scripts\cp_mp\utility\killstreak_utility::_id_E941(0, 1);
    }

    return 0;
  }

  var_12 = _id_10AC6(var_0, var_10, var_6, var_7);
  _id_AAB0(var_0, var_12);
  return istrue(var_12);
}

_id_EA07(var_0) {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.5);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var_0.streakname);
  }
}

_id_EA02(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  var_7 = "throwback_marker_mp";

  if(isDefined(var_1)) {
    var_7 = var_1;
  }

  var_0._id_47EE = makeweapon(var_7);
  var_8 = var_0._id_47EE;

  if(!_id_316C(var_0, var_8)) {
    return 0;
  }

  _id_AAB1(var_0);
  var_9 = _id_EC37(var_8, var_0, ::_id_1097E, var_2, var_3, var_5, var_6);

  if(!istrue(var_9)) {
    _id_AAB0(var_0, 0);
    return 0;
  }

  var_10 = _id_10AC8(var_0, "grenade_fire", var_8, var_4);
  _id_AAB0(var_0, var_10);
  return istrue(var_10);
}

_id_EC37(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  if(self hasweapon(var_0)) {
    return 0;
  }

  if(getcompleteweaponname(self getcurrentweapon()) == "s4_gw_flima35_mp") {
    self notify("switched_from_minigun");

    while(getcompleteweaponname(self getcurrentweapon()) == "s4_gw_flima35_mp") {
      waitframe();
    }
  }

  if(!isDefined(var_7)) {
    var_7 = 1;
  }

  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0, 0, 0, var_7);
  var_8 = _id_2FDD(var_1, var_3);

  if(!istrue(var_8)) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
    return 0;
  }

  thread _id_10AFA(var_1, var_0);
  thread _id_10B27(var_1, var_0);
  var_9 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0);
  var_1 notify("deploy_weapon_switch_ended");

  if(isDefined(var_4)) {
    self thread[[var_4]](var_1, var_9);
  }

  waitframe();

  if(!var_9) {
    var_2 = undefined;
  }

  if(!scripts\cp_mp\utility\player_utility::_isalive()) {
    return 0;
  }

  thread _id_387D(var_9, var_1, var_0, var_2, var_5, var_6);
  return var_9;
}

_id_2FDD(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("cancel_all_killstreak_deployments");

  if(isDefined(var_1)) {
    return self[[var_1]](var_0);
  }

  return 1;
}

_id_10AFA(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  var_0 endon("deploy_weapon_switch_ended");
  self waittill("cancel_all_killstreak_deployments");

  if(scripts\cp_mp\utility\inventory_utility::_id_8A86(var_1)) {
    scripts\cp_mp\utility\inventory_utility::_id_0E0C(var_1);
  }
}

_id_10B27(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  var_0 endon("deploy_weapon_switch_ended");
  self waittill("melee_swipe_start");

  if(scripts\cp_mp\utility\inventory_utility::_id_8A86(var_1)) {
    scripts\cp_mp\utility\inventory_utility::_id_0E0C(var_1);
  } else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1);
    thread scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self._id_8FC2);
  }
}

_id_10AC8(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("weapon_change");
  self endon("cancel_all_killstreak_deployments");

  for(;;) {
    var_4 = undefined;
    var_5 = undefined;

    switch (var_1) {
      case "weapon_fired":
        self waittill(var_1, var_4);
        break;
      case "offhand_fired":
        self waittill(var_1, var_4);
        break;
      case "grenade_fire":
        self waittill(var_1, var_5, var_4);
        break;
      default:
        self waittill(var_1);
        break;
    }

    if(var_4 == var_2) {
      if(isDefined(var_3)) {
        var_6 = [[var_3]](var_0, var_4, var_5);

        if(!isDefined(var_6)) {
          return 0;
        } else if(var_6 == "failure") {
          return 0;
        } else if(var_6 == "continue") {
          continue;
        } else if(var_6 == "success") {
          return 1;
        } else {
          return 0;
        }
      }

      return 1;
    }
  }

  return 0;
}

_id_10AC6(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  scripts\cp_mp\utility\player_utility::_id_D8D4(var_0.streakname);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "objectiveUnPinPlayer") && isDefined(self._id_B0E5)) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "objectiveUnPinPlayer")]](self._id_B0E5, self);
    self._id_C36C = 1;
  }

  scripts\cp_mp\utility\player_utility::_freezecontrols(1);
  thread _id_F945();

  if(istrue(var_2)) {
    thread _id_E73E(var_1 - 0.3);
  }

  thread _id_10C31(var_0, var_3);
  thread _id_10C30();
  var_4 = scripts\engine\utility::_id_108A9(var_1, "death", "weapon_change", "cancel_all_killstreak_deployments");
  self notify("ks_freeze_end");
  scripts\cp_mp\utility\player_utility::_freezecontrols(0);

  if(!isDefined(var_4) || var_4 != "timeout" || !self isonground() || self isonladder()) {
    var_0 notify("killstreak_finished_with_deploy_weapon");
    self notify("cancel_remote_sequence");
    return 0;
  }

  self notify("deploy_weapon_anim_successful");
  return 1;
}

_id_F945() {
  self endon("disconnect");
  self endon("ks_freeze_end");
  level waittill("round_switch");
  scripts\cp_mp\utility\player_utility::_freezecontrols(0);
}

_id_E73E(var_0) {
  self endon("disconnect");
  var_1 = scripts\engine\utility::_id_108A7(var_0, "cancel_remote_sequence");

  if(!isDefined(var_1) || var_1 == "cancel_remote_sequence") {
    return;
  }
  if(scripts\cp_mp\utility\player_utility::_isalive()) {
    level thread scripts\cp_mp\utility\game_utility::_id_58C7(self, 1, 0.3);
    var_1 = scripts\engine\utility::_id_108A7(0.7, "death");
    level thread scripts\cp_mp\utility\game_utility::_id_58C7(self, 0, 0.3);
  }
}

_id_10C31(var_0, var_1) {
  level endon("game_ended");
  self endon("disconnect");
  var_0 waittill("killstreak_finished_with_deploy_weapon");

  if(!istrue(var_1)) {
    scripts\cp_mp\utility\killstreak_utility::_id_E941(0.325);
  }

  scripts\cp_mp\utility\player_utility::_id_3990();
}

_id_10C30() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("deploy_weapon_anim_successful");
  self endon("cancel_remote_sequence");

  for(;;) {
    if(!self isonground()) {
      _id_EA00();
      break;
    }

    waitframe();
  }
}

_id_1097E(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  scripts\engine\utility::_id_10888(var_0, "killstreak_finished_with_deploy_weapon", self, "cancel_all_killstreak_deployments", self, "weapon_change");
}

_id_387D(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");

  if(isDefined(var_3)) {
    self[[var_3]](var_1);
  }

  if(self hasweapon(var_2)) {
    var_6 = scripts\cp_mp\utility\killstreak_utility::_id_89FA(var_2.basename);
    var_7 = scripts\cp_mp\utility\killstreak_utility::_id_891E(var_1.streakname);
    scripts\common\utility::_id_1554(0);
    scripts\common\utility::_id_1562(0);

    if(var_6) {
      scripts\common\utility::_id_1553(0);
      scripts\common\utility::_id_1559(0);
      scripts\cp_mp\utility\player_utility::_id_0BEE(1);
    } else if(istrue(var_7))
      scripts\common\utility::_id_1553(0);

    if(isDefined(var_4)) {
      self[[var_4]](var_1, var_0, var_2);
    } else {
      _id_6CF6(var_2);
    }

    scripts\common\utility::_id_1554(1);
    scripts\common\utility::_id_1562(1);

    if(var_6) {
      scripts\common\utility::_id_1553(1);
      scripts\common\utility::_id_1559(1);
      scripts\cp_mp\utility\player_utility::_id_0BEE(0);
    } else if(istrue(var_7))
      scripts\common\utility::_id_1553(1);
  }

  if(isDefined(var_5)) {
    self[[var_5]](var_1);
  }
}

_id_6CF6(var_0) {
  scripts\cp_mp\utility\inventory_utility::_id_6CF7(var_0);
  var_1 = self getcurrentweapon();

  if(var_1.basename == "none") {
    scripts\cp_mp\utility\inventory_utility::_id_5ED6();
  }
}

_id_316D(var_0, var_1) {
  if(self hasweapon(var_1)) {
    return "KILLSTREAKS/CANNOT_BE_USED";
  }

  if(self isonladder()) {
    return "KILLSTREAKS/CANNOT_BE_USED";
  }

  if(self _meth_81CE()) {
    return "KILLSTREAKS/CANNOT_BE_USED";
  }

  if(!scripts\common\utility::_id_8724()) {
    return "KILLSTREAKS/CANNOT_BE_USED";
  }

  if(istrue(self._id_1646)) {
    return "KILLSTREAKS/CANNOT_BE_USED";
  }

  if((scripts\cp_mp\utility\killstreak_utility::_id_8A08(var_0.streakname) || scripts\cp_mp\utility\killstreak_utility::_id_891E(var_0.streakname)) && !self isonground()) {
    return "KILLSTREAKS/CANNOT_BE_USED";
  }

  if(scripts\cp_mp\utility\player_utility::_id_8ACE()) {
    return "KILLSTREAKS/CANNOT_BE_USED";
  }

  return;
}

_id_EA06(var_0) {
  self endon("death");
  self endon("disconnect");
  self _meth_852A(var_0);

  if(!self hasweapon(var_0)) {
    self notify("giveAndFireOffhandReliableFailed", var_0);
    return 0;
  }

  var_1 = spawnStruct();
  var_1 childthread _id_EA09(self, var_0);
  var_1 childthread _id_EA08(self, var_0);
  var_1 waittill("race_start");
  waittillframeend;
  var_1 notify("race_end");

  if(istrue(var_1._id_EACB)) {
    self notify("giveAndFireOffhandReliableSucceeded", var_0);
    return 1;
  } else if(istrue(var_1._id_58E3)) {
    self notify("giveAndFireOffhandReliableFailed", var_0);
    return 0;
  }
}

_id_EA09(var_0, var_1) {
  self endon("race_end");
  var_0 waittillmatch("offhand_fired", var_1);
  self._id_EACB = 1;
  self notify("race_start");
}

_id_EA08(var_0, var_1) {
  self endon("race_end");

  while(var_0 hasweapon(var_1)) {
    waitframe();
  }

  self._id_58E3 = 1;
  self notify("race_start");
}