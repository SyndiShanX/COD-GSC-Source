/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1762.gsc
*************************************************/

_id_1029(var_0, var_1) {
  if(!isDefined(level._id_F01B)) {
    level._id_F01B = [];
  }

  if(!isDefined(level._id_F01B[var_0])) {
    level._id_F01B[var_0] = [];
  }

  level._id_F01B[var_0][level._id_F01B[var_0].size] = var_1;
}

is_telemetry_callback_registered(var_0) {
  if(!isDefined(level._id_F01B)) {
    return 0;
  }

  if(!isDefined(level._id_F01B[var_0])) {
    return 0;
  }

  return 1;
}

_id_4C2A(var_0, var_1) {
  if(!is_telemetry_callback_registered(var_0)) {
    return;
  }
  if(isDefined(var_1)) {
    for(var_2 = 0; var_2 < level._id_F01B[var_0].size; var_2++) {
      thread[[level._id_F01B[var_0][var_2]]](var_1);
    }
  } else {
    for(var_2 = 0; var_2 < level._id_F01B[var_0].size; var_2++) {
      thread[[level._id_F01B[var_0][var_2]]]();
    }
  }
}

get_time_from_match_start(var_0) {
  var_1 = var_0;

  if(isDefined(level._id_E72F)) {
    var_1 = var_1 - level._id_E72F;

    if(var_1 < 0) {
      var_1 = 0;
    }
  } else
    var_1 = 0;

  return var_1;
}

get_death_modifiers() {
  var_0 = [];
  var_1 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "teamHasUAV")) {
    var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "teamHasUAV")]](self.team);
  }

  var_2 = undefined;
  var_3 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
    var_2 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_quieter");
    var_3 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_bulletdamage");
  }

  if(istrue(var_1)) {
    var_0[var_0.size] = "UAV_ACTIVE";
  }

  if(istrue(var_2)) {
    var_0[var_0.size] = "DEADSILENCE_ACTIVE";
  }

  if(istrue(var_3)) {
    var_0[var_0.size] = "HAS_STOPPING_POWER";
  }

  var_4 = gettime();
  var_5 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "enemyHasCUAV")) {
    var_5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "enemyHasCUAV")]](self.team);
  }

  var_6 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "helper_drone_isTargetMarked")) {
    var_6 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "helper_drone_isTargetMarked")]]();
  }

  var_7 = istrue(self._id_5C96);
  var_8 = istrue(self._id_3B5C);
  var_9 = isDefined(self._id_61DD) && self._id_61DD.size > 0 || isDefined(self._id_8FDB) && self._id_8FDB + 5000 > var_4;
  var_10 = isDefined(self._id_2D8D) || isDefined(self._id_8F9E) && self._id_8F9E + 5000 > var_4;
  var_11 = isDefined(self._id_9049) && self._id_9049 + 5000 > var_4;
  var_12 = isDefined(self._id_8FF7) && self._id_8FF7 + 5000 > var_4;
  var_13 = istrue(self._id_5191);
  var_14 = istrue(self._id_10FA0);
  var_15 = undefined;

  if(isDefined(self._id_90CE)) {
    var_16 = self._id_90CE;
    var_15 = getweaponbasename(var_16);
  }

  if(istrue(var_5)) {
    var_0[var_0.size] = "CUAV_ACTIVE";
  }

  if(istrue(var_6)) {
    var_0[var_0.size] = "IS_MARKED";
  }

  if(istrue(var_7)) {
    var_0[var_0.size] = "IS_FLASHED";
  }

  if(istrue(var_8)) {
    var_0[var_0.size] = "IS_STUNNED";
  }

  if(istrue(var_9)) {
    var_0[var_0.size] = "IN_GAS";
  }

  if(istrue(var_10)) {
    var_0[var_0.size] = "IN_BURNING";
  }

  if(istrue(var_11)) {
    var_0[var_0.size] = "IS_SNAPSHOTTED";
  }

  if(istrue(var_12)) {
    var_0[var_0.size] = "IN_SMOKE";
  }

  if(istrue(var_13)) {
    var_0[var_0.size] = "IS_EMPED";
  }

  if(istrue(var_14)) {
    var_0[var_0.size] = "IN_WHITE_PHOSPHOROUS";
  }

  if(self _meth_8632()) {
    var_0[var_0.size] = "NVG_ENABLED";
  }

  if(isDefined(self._id_9FFB)) {
    if(istrue(self._id_9FFB["headshot"])) {
      var_0[var_0.size] = "HEADSHOT";
    }

    if(istrue(self._id_9FFB["avenger"])) {
      var_0[var_0.size] = "AVENGER";
    }

    if(istrue(self._id_9FFB["defender"])) {
      var_0[var_0.size] = "DEFENDER";
    }

    if(istrue(self._id_9FFB["posthumous"])) {
      var_0[var_0.size] = "POSTHUMOUS";
    }

    if(istrue(self._id_9FFB["revenge"])) {
      var_0[var_0.size] = "REVENGE";
    }

    if(istrue(self._id_9FFB["buzzkill"])) {
      var_0[var_0.size] = "BUZZKILL";
    }

    if(istrue(self._id_9FFB["firstblood"])) {
      var_0[var_0.size] = "FIRSTBLOOD";
    }

    if(istrue(self._id_9FFB["comeback"])) {
      var_0[var_0.size] = "COMEBACK";
    }

    if(istrue(self._id_9FFB["longshot"])) {
      var_0[var_0.size] = "LONGSHOT";
    }

    if(istrue(self._id_9FFB["pointblank"])) {
      var_0[var_0.size] = "POINTBLANK";
    }

    if(istrue(self._id_9FFB["assistedsuicide"])) {
      var_0[var_0.size] = "ASSISTED_SUICIDE";
    }

    if(isDefined(var_15) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "isKillstreakWeapon") && istrue([[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "isKillstreakWeapon")]](var_15))) {
      var_0[var_0.size] = "KILLSTREAK";
    }
  }

  return var_0;
}

mount_string_to_dlog_enum() {
  var_0 = self _meth_8270();

  if(isDefined(var_0)) {
    switch (var_0) {
      case "mount_left":
        return "MOUNT_LEFT";
      case "mount_right":
        return "MOUNT_RIGHT";
      case "mount_top":
        return "MOUNT_TOP";
    }
  }

  return "MOUNT_NONE";
}

is_valid_client(var_0) {
  if(istrue(game["isLaunchChunk"])) {
    return 0;
  }

  if(!isDefined(var_0)) {
    return 0;
  } else if(isagent(var_0)) {
    return 0;
  } else if(!isPlayer(var_0)) {
    return 0;
  }

  return 1;
}