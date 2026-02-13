/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2504.gsc
*************************************************/

_id_0CF9(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4)) {
    var_4 = [[level._id_D9E7[var_1]]](var_0, var_2);
  }

  var_5 = gettime() + var_4;

  if(var_1 != "top") {
    if(!scripts\common\utility::_id_86B6()) {
      return 0;
    }
  }

  if(isDefined(self._id_D9E3)) {
    var_6 = level._id_D9ED[self._id_D9E3];
    var_7 = level._id_D9ED[var_1];

    if(var_7 > var_6) {
      if(gettime() < self._id_D9E8) {
        return 0;
      }
    } else if(var_7 == var_6) {
      if(var_5 < self._id_D9E8) {
        return 0;
      }
    }
  }

  self._id_D9EA = var_0;
  self._id_D9E3 = var_1;
  self._id_D9E8 = var_5;
  var_8 = 0;

  if(isDefined(self.perks) && isDefined(self.perks["specialty_dauntless"])) {
    var_8 = 1;
  }

  if(isDefined(var_3)) {
    self shellshock(var_0, var_2, var_3, var_8);
  } else {
    self shellshock(var_0, var_2, undefined, var_8);
  }

  thread _id_D9C9(var_2);
}

_id_0D89(var_0) {
  self notify("_stopShellShock");

  if(!istrue(var_0)) {
    self _meth_83F5();
  }

  self._id_D9EA = undefined;
  self._id_D9E3 = undefined;
  self._id_D9E8 = undefined;
  self notify("shellshock_updateMoveSpeed");
}

_id_526B() {}

_id_4AE4() {
  _id_0D89(scripts\cp_mp\utility\player_utility::_isalive());
}

_id_D9C8(var_0, var_1, var_2, var_3, var_4) {
  playrumbleonposition("artillery_rumble", var_0);

  if(!isDefined(var_1)) {
    var_1 = 0.7;
  }

  if(!isDefined(var_2)) {
    var_2 = 0.5;
  }

  if(!isDefined(var_3)) {
    var_3 = 800;
  }

  earthquake(var_1, var_2, var_0, var_3);
  _id_D9D0(var_0, var_3, var_4);
}

_id_D9D0(var_0, var_1, var_2) {
  var_3 = scripts\common\utility::_id_B7BF(var_0, var_1);

  foreach(var_5 in var_3) {
    if(!isDefined(var_5)) {
      continue;
    }
    if(isDefined(var_2)) {
      if(_func_0107(var_2)) {
        if(scripts\engine\utility::array_contains(var_2, var_5)) {
          continue;
        }
      } else if(var_5 == var_2)
        continue;
    }

    if(var_5 scripts\cp_mp\utility\player_utility::_id_8ACE()) {
      continue;
    }
    var_5 setclientomnvar("ui_hud_shake", 1);
  }
}

_id_D9D2() {
  level._id_526B = ::_id_526B;
  level._id_4AE4 = ::_id_4AE4;
  level._id_D9ED = [];
  level._id_D9ED["top"] = 0;
  level._id_D9ED["flash"] = 1;
  level._id_D9ED["stun"] = 2;
  level._id_D9ED["gas"] = 3;
  level._id_D9ED["explosion"] = 4;
  level._id_D9ED["damage"] = 4;
  level._id_D9ED["bottom"] = 5;
  level._id_D9E7["top"] = ::_id_D9CE;
  level._id_D9E7["flash"] = ::_id_D9CB;
  level._id_D9E7["stun"] = ::_id_D9D1;
  level._id_D9E7["gas"] = ::_id_D9CC;
  level._id_D9E7["explosion"] = ::_id_D9CE;
  level._id_D9E7["damage"] = ::_id_D9CA;
  level._id_D9E7["bottom"] = ::_id_D9CF;
}

_id_D9C9(var_0) {
  self endon("disconnect");
  self endon("_stopShellShock");
  wait(var_0);
  self._id_D9EA = undefined;
  self._id_D9E3 = undefined;
  self._id_D9E8 = undefined;
  self notify("shellshock_updateMoveSpeed");
}

_id_D9CE(var_0, var_1) {
  return 250.0;
}

_id_D9CB(var_0, var_1) {
  var_2 = undefined;

  switch (var_0) {
    case "flash_grenade_mp":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "flashInterruptDelayFunc")) {
        var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "flashInterruptDelayFunc")]](var_1);
      }

      break;
    default:
  }

  return var_2;
}

_id_D9D1(var_0, var_1) {
  var_2 = undefined;

  switch (var_0) {
    case "s4_stun_gbr_n69_mp":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "concussionInterruptDelayFunc")) {
        var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "concussionInterruptDelayFunc")]](var_1);
      }

      break;
    case "mild_concussion_grenade_mp":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "concussionInterruptDelayFunc")) {
        var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "concussionInterruptDelayFunc")]](var_1);
      }

      break;
    case "weak_concussion_grenade_mp":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "concussionInterruptDelayFunc")) {
        var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "concussionInterruptDelayFunc")]](var_1);
      }

      break;
    default:
  }

  return var_2;
}

_id_D9CC(var_0, var_1) {
  var_2 = undefined;

  switch (var_0) {
    case "gas_grenade_light_mp":
    case "gas_grenade_heavy_mp":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "gasInterruptDelayFunc")) {
        var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "gasInterruptDelayFunc")]](var_1);
      }

      break;
    default:
      var_2 = _id_D9CE(var_1);
  }

  return var_2;
}

_id_D9CA(var_0, var_1) {
  var_2 = undefined;

  switch (var_0) {
    case "last_stand_mp":
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("shellshock", "lastStandInterruptDelayFunc")) {
        var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("shellshock", "lastStandInterruptDelayFunc")]](var_1);
      }

      break;
    default:
      var_2 = _id_D9CE(var_1);
  }

  return var_2;
}

_id_D9CF(var_0, var_1) {
  return 0;
}