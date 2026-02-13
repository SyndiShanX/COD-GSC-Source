/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1874.gsc
*************************************************/

_id_6FF6(var_0, var_1, var_2) {
  if(isDefined(level.ignorescoring)) {
    return;
  }
  if(isDefined(var_2)) {
    var_3 = var_2;
  } else {
    var_3 = _id_0756::_id_6D0C(var_0, "score");
  }

  var_3 = _id_A012(var_0, var_3, var_1);
  _id_4B7E(var_3, var_0);
}

_id_7003(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(level.ignorescoring)) {
    return;
  }
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(level.a_disabled_score_event) && isDefined(var_0) && scripts\engine\utility::array_contains(level.a_disabled_score_event, var_0)) {
    return;
  }
  var_6 = _id_0756::_id_6D0C(var_0, "xp");

  if(isDefined(var_6) && !istrue(var_3)) {
    var_7 = 1.0;
    var_8 = self getxuid();

    if(isDefined(level.total_ekia_per_round_per_player[var_8])) {
      var_9 = level.total_ekia_per_round_per_player[var_8] / level.xp_per_round_parameter.ekialimit[level.xp_per_round_active_player_count - 1];

      if(isDefined(var_9) && var_9 > 1.0) {
        if(var_9 < 1.25) {
          var_7 = var_7 * 0.5;
        } else if(var_9 < 1.5) {
          var_7 = var_7 * 0.25;
        } else {
          var_7 = var_7 * 0.1;
        }
      }
    }

    var_10 = _id_0756::_id_6D0C(var_0, "weapon_xp");
    var_6 = var_6 * level.xp_per_round_parameter.scoreevent[level.xp_per_round_active_player_count - 1];
    var_6 = var_6 * var_7;

    if(isDefined(var_10)) {
      var_10 = var_10 * level.xp_per_round_parameter.weaponxp[level.xp_per_round_active_player_count - 1];
      var_10 = var_10 * var_7;
    }

    thread _id_0756::giverankxp(var_0, var_6, var_1, 0, var_10);
  }

  var_11 = _id_0756::_id_6D0C(var_0, "score");

  if(!isDefined(var_11)) {
    return;
  }
  if(isDefined(var_2)) {
    var_11 = var_2;
  } else {
    if(var_0 == "zombie_kia") {
      var_11 = int(var_11 * _id_0945::_id_664E("essence_value"));
      var_12 = getcompleteweaponname(var_1);
      var_13 = "kill";
      scripts\cp\telemetry_cp::logevent_essenceearned(self, var_11, var_12, var_13);
    }

    var_11 = _id_A012(var_0, var_11, var_1);
  }

  _id_074E::_id_6F28(var_11, "large", undefined, 1);
  thread _id_0756::_id_CC00(var_0, var_4);
  scripts\cp\telemetry_cp::logevent_scoreevent(self, var_0);
}

_id_6F14(var_0) {
  var_1 = _id_074E::_id_667E();
  var_0 = _id_072C::_id_C936(var_0, 5);

  if(isDefined(self._id_F37A) && isDefined(self._id_9C89)) {
    if(self._id_F37A > self._id_9C89) {
      var_0 = 0;
    } else {
      self._id_F37A = self._id_F37A + var_0;
    }
  }

  var_2 = _id_074E::_id_667D();
  var_3 = var_1 + var_0;
  var_3 = min(var_3, var_2);
  _id_074E::_id_D343(var_3);
}

_id_A012(var_0, var_1, var_2) {
  switch (var_0) {
    case "damage":
      return 0;
    default:
      break;
  }

  var_3 = 0;

  if(var_0 == "kill" && var_2 _meth_8624("gunperk_xp", 1)) {
    var_3 = var_3 + 20;
  }

  var_1 = var_1 + var_3;

  if(isDefined(level._id_A013)) {
    var_1 = [[level._id_A013]](var_1, var_0, self, var_2);
  }

  return int(var_1);
}

_id_4B7E(var_0, var_1) {
  if(getdvarint("#x389af232806b57940", 0) == 1) {
    return;
  }
  if(scripts\cp\utility::_id_871A()) {
    return;
  } else if(isDefined(self._id_F389) && isDefined(self._id_9CC2)) {
    if(self._id_F389 >= self._id_9CC2) {
      return;
    }
  }

  if(level.codcasterenabled) {
    foreach(var_3 in level.players) {
      if(var_3 _meth_81D3()) {
        var_4 = var_3 getspectatingplayer();

        if(isDefined(var_4)) {
          var_5 = var_4 getentitynumber();
          var_6 = self getentitynumber();

          if(var_5 == var_6) {
            var_3 thread _id_0756::_id_CC13(var_0);
            var_3 thread _id_0756::_id_CC00(var_1);
          }
        }
      }
    }
  }

  if(!isDefined(level._id_DDC2)) {
    var_8 = 0;

    if(scripts\cp\utility::_id_8A37()) {
      var_8 = var_1 == "kill";
    }

    thread _id_0756::_id_CC13(var_0, var_8);
  }
}

_id_894A(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(_func_0121(var_0)) {
    var_0 = makeweapon(var_0);
  }

  switch (var_0.basename) {
    case "bradley_tow_proj_mp":
    case "lighttank_tur_mp":
    case "tur_apc_rus_mp":
      return 1;
  }

  return 0;
}

_id_8868(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(_func_0121(var_0)) {
    var_0 = makeweapon(var_0);
  }

  switch (var_0.basename) {
    case "deploy_airdrop_mp":
    case "deploy_juggernaut_mp":
    case "iw8_green_beam_mp":
    case "iw8_spotter_scope_mp":
      return 1;
  }

  return 0;
}

_id_2EED(var_0, var_1) {
  var_2 = 250;
  var_3 = var_1 / 60;
  var_4 = _id_0756::getscoreinfovalue(var_0);
  var_5 = self._id_F242["total"] / var_1;

  if(scripts\cp\utility::_id_871A()) {
    var_3 = 1;
    var_5 = 1;
  }

  var_6 = _id_0756::_id_6A68();
  var_7 = int(var_2 * var_4 * var_3 * var_5 * var_6);
  return var_7;
}

_id_FCBB(var_0) {
  if(istrue(level._id_5E90)) {
    var_1 = _id_0726::_id_665F() / 1000;
    var_1 = min(var_1, 1200);
  } else
    var_1 = _id_0726::_id_665F() / 1000;

  if(level.teambased) {
    if(var_0 != "tie") {
      _func_01FF(var_0);
    }

    foreach(var_3 in level.players) {
      if(isDefined(var_3._id_3B82)) {
        continue;
      }
      if(!isDefined(var_3._id_F242) || var_3._id_F242["total"] < 1 || var_3.pers["participation"] < 1) {
        continue;
      }
      if(istrue(level._id_7AA2) && var_3 ishost()) {
        continue;
      }
      if(!istrue(var_3.pers["hasDoneAnyCombat"])) {
        continue;
      }
      if(var_0 == "tie") {
        var_4 = var_3 _id_2EED("tie", var_1);
        var_3 thread _id_6FB4("tie", var_4);
        var_3._id_9BA8 = var_4;
      } else if(isDefined(var_3.pers["team"]) && var_3.pers["team"] == var_0) {
        var_4 = var_3 _id_2EED("win", var_1);
        var_3 thread _id_6FB4("win", var_4);
        var_3._id_9BA8 = var_4;
      } else if(isDefined(var_3.pers["team"]) && var_3.pers["team"] != var_0) {
        var_4 = var_3 _id_2EED("loss", var_1);
        var_3 thread _id_6FB4("loss", var_4);
        var_3._id_9BA8 = var_4;
      }

      var_3 _id_2F02(var_1);
    }
  } else {
    var_6 = "win";
    var_7 = "loss";

    if(!isDefined(var_0)) {
      var_6 = "tie";
      var_7 = "tie";
    }

    foreach(var_3 in level.players) {
      if(isDefined(var_3._id_3B82)) {
        continue;
      }
      if(var_3._id_F242["total"] < 1 || var_3.pers["participation"] < 1) {
        continue;
      }
      if(!istrue(var_3.pers["hasDoneAnyCombat"])) {
        continue;
      }
      var_9 = 0;

      for(var_10 = 0; var_10 < min(level._id_B16C["all"].size, 3); var_10++) {
        if(level._id_B16C["all"][var_10] != var_3) {
          continue;
        }
        var_9 = 1;
      }

      if(var_9) {
        var_4 = var_3 _id_2EED(var_6, var_1);
        var_3 thread _id_6FB4("win", var_4);
        var_3._id_9BA8 = var_4;
      } else {
        var_4 = var_3 _id_2EED(var_7, var_1);
        var_3 thread _id_6FB4("loss", var_4);
        var_3._id_9BA8 = var_4;
      }

      var_3 _id_2F02(var_1);
    }
  }
}

_id_6FB4(var_0, var_1) {
  self endon("disconnect");
  level waittill("give_match_bonus");
  _id_0756::giverankxp(var_0, var_1);

  if(var_0 == "win") {
    thread _id_0709::_id_6FB9("match_complete_win");
  } else {
    thread _id_0709::_id_6FB9("match_complete");
  }
}

_id_2F02(var_0) {
  var_0 = 600;

  if(istrue(self.pers["ignoreWeaponMatchBonus"]) || !isDefined(self.pers["killsPerWeapon"])) {
    return;
  }
  var_1 = _id_0776::_id_6A63() / 60;
  var_2 = var_0 / 60;
  var_3 = int(var_1 * var_2);
  var_4 = int(50.0);
  var_5 = self._id_F242["total"] / var_0;
  var_6 = var_4 * var_5;
  var_7 = int(var_3 * var_6);
  var_7 = var_7 - int(self.pers["weaponMatchBonusKills"] * var_6);

  if(var_7 <= 0) {
    return;
  }
  var_8 = 0;

  foreach(var_10 in self.pers["killsPerWeapon"]) {
    var_8 = var_8 + (var_3 - var_10._id_8D6E);
  }

  if(var_8 <= 0) {
    return;
  }
  foreach(var_19, var_10 in self.pers["killsPerWeapon"]) {
    var_13 = (var_3 - var_10._id_8D6E) / var_8;
    var_14 = int(var_7 * var_13);
    _id_0756::incrankxp(0, var_10, var_14);

    foreach(var_18, var_16 in self.pers["matchdataWeaponStats"]) {
      if(issubstr(var_18, var_19)) {
        if(isDefined(var_16._id_E76F["kills"]) && var_10._id_8D6E > 0) {
          var_17 = var_13 * (var_16._id_E76F["kills"] / var_10._id_8D6E);
          var_14 = int(var_7 * var_17);

          if(isDefined(var_16._id_E76F["xp_earned"])) {
            var_16._id_E76F["xp_earned"] = var_16._id_E76F["xp_earned"] + var_14;
          } else {
            var_16._id_E76F["xp_earned"] = var_14;
          }
        }
      }
    }
  }
}

_id_D58D(var_0, var_1) {
  if(var_1 && !istrue(var_0._id_7555)) {}

  var_0._id_7555 = var_1;

  if(var_1 && !istrue(var_0.pers["hasDoneAnyCombat"])) {
    var_0.pers["hasDoneAnyCombat"] = 1;
  }
}

enemyscoredisable(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(isDefined(self)) {
    self._id_2042 = var_0;
  }
}

playerkillscoredisable(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(isDefined(self)) {
    self.b_player_kill_scoring_disabled = var_0;
  }
}