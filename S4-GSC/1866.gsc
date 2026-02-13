/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1866.gsc
*************************************************/

_id_ACBC() {
  self endon("disconnect");
  level endon("game_ended");
  wait 2;

  for(;;) {
    _id_8B29();
    wait 0.05;
  }
}

_id_ACBB() {
  level._id_ACBE = [];
}

_id_8B29() {
  self endon("refresh_outline");

  foreach(var_4, var_1 in level._id_ACBE) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(!isDefined(var_1._id_3D91)) {
      continue;
    }
    var_2 = 1;
    var_3 = distancesquared(self.origin, var_1.origin) < 1000000;

    if(var_3 && !scripts\cp\utility::_id_85F4() && !scripts\cp\utility::_id_7521()) {
      _id_520F(var_1, self, _id_64FC(var_1, var_2), "high");
    } else if(var_3 && (scripts\cp\utility::_id_85F4() || scripts\cp\utility::_id_7521())) {
      _id_520F(var_1, self, "outline_depth_orange", "high");
    } else {
      _id_4A2F(var_1, self);
    }

    if(var_4 & 0) {
      wait 0.05;
    }
  }
}

_id_64FC(var_0, var_1) {
  var_2 = var_0._id_3D91;

  if(isDefined(level._id_752E)) {
    if(isDefined(var_0._id_EA6A._id_04F6) && self[[level._id_752E]](var_0._id_EA6A._id_04F6)) {
      if(isDefined(level._id_683F)) {
        var_3 = self[[level._id_683F]](var_0._id_EA6A._id_04F6);

        if(var_3 > 1) {
          var_2 = 4500;
        } else {
          var_2 = var_0._id_3D91 * 0.5;
        }
      } else
        var_2 = var_0._id_3D91 * 0.5;
    }
  }

  if(_id_074E::_id_B4C5(var_2) || istrue(var_0._id_523F)) {
    return "outline_depth_cyan";
  } else {
    return "outline_depth_red";
  }
}

_id_B731() {
  self endon("disconnect");

  for(;;) {
    foreach(var_1 in level.players) {
      if(self == var_1) {
        continue;
      }
      if(_id_DAC3(var_1)) {
        _id_520F(var_1, self, _id_64FB(var_1), "high");
        continue;
      }

      _id_4A2F(var_1, self);
    }

    wait 0.2;
  }
}

_id_DAC3(var_0) {
  if(self._id_A536) {
    return 0;
  }

  if(!isalive(var_0) || !isDefined(var_0.maxhealth) || !var_0.maxhealth || var_0._id_A521) {
    return 0;
  }

  var_1 = distancesquared(self.origin, var_0.origin) > 2250000;

  if(var_1) {
    return 1;
  }

  var_2 = !scripts\engine\trace::_bullet_trace_passed(self getEye(), var_0 getEye(), 0, self);
  return var_2;
}

_id_64FB(var_0) {
  var_1 = var_0.health / 100;

  if(var_1 <= 0.33 || _id_073B::_id_B4EF(var_0)) {
    return "outline_nodepth_red";
  } else if(var_1 <= 0.66) {
    return "outline_nodepth_orange";
  } else if(var_1 <= 1.0) {
    return "outline_nodepth_cyan";
  } else {
    return "outline_nodepth_white";
  }
}

_id_5210(var_0, var_1, var_2, var_3) {
  var_0 _meth_81B2(var_1, var_2);
}

_id_520F(var_0, var_1, var_2, var_3) {
  var_0 _meth_81B1(var_1, var_2);
}

_id_4A30(var_0, var_1) {
  var_0 _meth_81AF(var_1);
}

_id_4A2F(var_0, var_1) {
  var_0 _meth_81AE(var_1);
}

_id_4A2E(var_0) {
  var_0 _meth_81AD();
}

_id_520E(var_0, var_1) {
  var_0 _meth_81B0(var_1);
}

_id_D2B5(var_0) {
  level endon("game_ended");
  level endon("outline_disabled");

  if(!isDefined(var_0)) {
    var_0 = "outline_nodepth_orange";
  }

  for(;;) {
    var_1 = scripts\engine\utility::array_combine(level.agentarray, level._id_FFF9);

    for(var_2 = 0; var_2 < var_1.size; var_2++) {
      var_3 = var_1[var_2];

      if(!isDefined(var_3)) {
        continue;
      }
      if(isagent(var_3) && !isalive(var_3)) {
        continue;
      }
      if(isDefined(var_3._id_42EE)) {
        continue;
      }
      if(isDefined(var_3._id_9B32)) {
        continue;
      }
      if(isDefined(var_3.team) && var_3.team == "allies") {
        _id_5210(var_3, level.players, "outline_nodepth_green", "high");
        continue;
      }

      _id_5210(var_3, level.players, var_0, "high");
    }

    wait 0.5;
  }
}

_id_D2B6(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("outline_disabled");

  if(!isDefined(var_0)) {
    var_0 = 4;
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  for(;;) {
    foreach(var_4 in _id_06FE::_id_6322()) {
      if(isDefined(var_4._id_42EE)) {
        continue;
      }
      if(isDefined(var_4._id_9B32)) {
        continue;
      }
      if(isDefined(var_4._id_5A06)) {
        _id_520F(var_4, self, var_0, 1, var_2, "high");
        continue;
      }

      _id_520F(var_4, self, var_0, var_1, var_2, "high");
    }

    wait 0.5;
  }
}

_id_F9C3() {
  foreach(var_1 in _id_06FE::_id_6884("allies")) {
    if(isDefined(var_1._id_42EE)) {
      continue;
    }
    if(isDefined(var_1._id_9B32)) {
      continue;
    }
    _id_4A30(var_1, level.players);
    level notify("outline_disabled");
  }
}

_id_F9C4() {
  foreach(var_1 in _id_06FE::_id_6884("allies")) {
    if(isDefined(var_1._id_42EE)) {
      continue;
    }
    if(isDefined(var_1._id_9B32)) {
      continue;
    }
    _id_4A2F(var_1, self);
    self notify("outline_disabled");
  }
}

_id_CB3A() {
  var_0 = ["#x3fa08eff177bce1f2", "#x3fa08f0f177bce425", "#x37f5385a7721003c6", "#x3a640d72a622b53be", "#x3f4882363aaeeb795", "#x36710626bef3b9312", "#x3bf1cef26c4100ba3", "#x3e3d49f424f03c1a1", "#x3e3d49e424f03bf6e", "#x3e3d49d424f03bd3b", "#x3e3d49c424f03bb08", "#x3e3d4a3424f03ca6d", "#x3e3d4a2424f03c83a", "#x3e3d4a1424f03c607"];

  if(!isDefined(level._id_7B8E)) {
    level._id_7B8E = [];
  }

  foreach(var_2 in var_0) {
    level._id_7B8E[var_2] = getDvar(var_2);
  }
}

_id_C6FC() {
  var_0 = ["#x3fa08eff177bce1f2", "#x3fa08f0f177bce425", "#x37f5385a7721003c6", "#x3a640d72a622b53be", "#x3f4882363aaeeb795", "#x36710626bef3b9312", "#x3bf1cef26c4100ba3", "#x3e3d49f424f03c1a1", "#x3e3d49e424f03bf6e", "#x3e3d49d424f03bd3b", "#x3e3d49c424f03bb08", "#x3e3d4a3424f03ca6d", "#x3e3d4a2424f03c83a", "#x3e3d4a1424f03c607"];

  if(!isDefined(level._id_7B8E)) {
    return;
  }
  foreach(var_2 in var_0) {
    setDvar(var_2, level._id_7B8E[var_2]);
  }
}

_id_7B7E(var_0, var_1) {
  _id_7B7F(var_1, var_0);
}

_id_7B7B(var_0) {
  _id_7B7C(var_0);
}

_id_7B77() {
  if(!isDefined(level._id_5D95)) {
    level._id_5D95 = ::_id_7B7A;
  }

  level._id_7B8B = [];
  _id_7B6F("default", 0, level._id_5D95);
  setsaveddvar("#x38952ebc6e081f789", 1);
  var_0 = [[level._id_5D95]]();

  for(var_1 = 0; var_1 < 8; var_1++) {
    var_2 = _func_0483("#x319f1162cadd6a0eb", scripts\engine\utility::_id_EA52(var_1));
    setsaveddvar(var_2, var_0[var_2]);
  }
}

_id_7B7F(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "default";
  }

  if(!isDefined(level._id_7B8B)) {
    _id_7B77();
  }

  if(_id_7B83(var_0, self)) {
    _id_7B86(var_0, self, var_1);
  } else {
    var_2 = level._id_7B8B[var_0]._id_54EC.size;
    level._id_7B8B[var_0]._id_54EC[var_2] = _id_7B78(self, var_1);
    thread _id_7B7D(var_0);
  }

  if(!isDefined(level._id_7B8B[var_0]._id_AE59)) {
    if(!isDefined(level._id_7B8C)) {
      _id_7B6D(var_0);
    }

    var_3 = level._id_7B8B[level._id_7B8C]._id_BD27;
    var_4 = level._id_7B8B[var_0]._id_BD27;

    if(level._id_7B8C != var_0 && var_3 < var_4) {
      _id_7B6D(var_0);
      return;
    }

    if(level._id_7B8C == var_0) {
      _id_0BD5(self, var_1, var_0);
      return;
    }

    return;
  } else {
    var_5 = level._id_7B8B[var_0]._id_AE59;

    if(!isDefined(level._id_7B8C)) {
      _id_7B6D(var_5);
    }

    var_3 = level._id_7B8B[level._id_7B8C]._id_BD27;
    var_6 = level._id_7B8B[var_5]._id_BD27;

    if(level._id_7B8C != var_5 && var_3 < var_6) {
      _id_7B6D(var_5);
    } else if(level._id_7B8C == var_5) {
      _id_0BD5(self, var_1, var_5);
    }
  }
}

_id_7B7C(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "default";
  }

  if(!isDefined(level._id_7B8B)) {
    return;
  }
  if(isDefined(self)) {
    self notify(var_0 + "hudoutline_disable");
  }

  var_1 = undefined;

  foreach(var_4, var_3 in level._id_7B8B[var_0]._id_54EC) {
    if(!isDefined(var_3._id_5469)) {
      level._id_7B8B[var_0]._id_54EC[var_4] = undefined;
      continue;
    }

    if(var_3._id_5469 == self) {
      var_1 = var_4;
      level._id_7B8B[var_0]._id_54EC[var_1] = undefined;
      break;
    }
  }

  var_5 = [];

  foreach(var_4, var_7 in level._id_7B8B[var_0]._id_54EC) {
    if(!isDefined(var_7)) {
      continue;
    }
    var_5[var_5.size] = var_7;
  }

  level._id_7B8B[var_0]._id_54EC = var_5;

  if(!isDefined(level._id_7B8C)) {
    return;
  }
  if(level._id_7B8C == var_0) {
    if(isDefined(var_1)) {
      _id_0BC0(self, var_0);
    }

    if(level._id_7B8B[var_0]._id_54EC.size == 0) {
      var_8 = 0;

      if(isDefined(level._id_7B8B[var_0]._id_3578) && level._id_7B8B[var_0]._id_3578.size > 0) {
        foreach(var_10 in level._id_7B8B[var_0]._id_3578) {
          if(level._id_7B8B[var_10]._id_54EC.size > 0) {
            var_8 = 1;
            break;
          }
        }
      }

      if(!var_8) {
        _id_7B6C();
      }
    }
  } else if(isDefined(level._id_7B8B[var_0]._id_AE59) && level._id_7B8C == level._id_7B8B[var_0]._id_AE59) {
    var_12 = level._id_7B8B[var_0]._id_AE59;

    if(isDefined(var_1)) {
      _id_0BC0(self, var_12);
    }

    if(level._id_7B8B[var_0]._id_54EC.size == 0) {
      _id_7B6C();
    }
  }
}

_id_7B6C() {
  var_0 = undefined;
  var_1 = undefined;

  if(isDefined(level._id_7B8D) && level._id_7B8D.size > 0) {
    foreach(var_3 in level._id_7B8D) {
      if(!isDefined(var_0) || level._id_7B8B[var_3]._id_BD27 > var_0) {
        var_0 = level._id_7B8B[var_3]._id_BD27;
        var_1 = var_3;
      }
    }
  } else {
    foreach(var_3 in level._id_7B8B) {
      if(isDefined(var_3._id_AE59)) {
        continue;
      }
      if(!isDefined(var_3._id_3578) || var_3._id_3578.size == 0) {
        if(var_3._id_54EC.size == 0) {
          continue;
        }
      } else {
        var_6 = 0;

        if(var_3._id_54EC.size > 0) {
          var_6 = 1;
        }

        foreach(var_8 in var_3._id_3578) {
          if(level._id_7B8B[var_8]._id_54EC.size > 0) {
            var_6 = 1;
          }
        }

        if(!var_6) {
          continue;
        }
      }

      if(!isDefined(var_0) || var_3._id_BD27 > var_0) {
        var_0 = var_3._id_BD27;
        var_1 = var_3._id_33F0;
      }
    }
  }

  if(isDefined(var_1)) {
    _id_7B6D(var_1);
  } else {
    level._id_7B8C = undefined;
  }
}

_id_7B78(var_0, var_1) {
  var_2 = spawnStruct();
  var_2._id_5469 = var_0;
  var_2._id_7B8A = var_1;
  return var_2;
}

_id_7B86(var_0, var_1, var_2) {
  foreach(var_4 in level._id_7B8B[var_0]._id_54EC) {
    if(var_4._id_5469 == var_1) {
      var_4._id_7B8A = var_2;
    }
  }
}

_id_7B6D(var_0) {
  if(isDefined(level._id_7B8C) && level._id_7B8C != var_0) {
    _id_7B79(level._id_7B8C);

    if(isDefined(level._id_7B8B[level._id_7B8C]._id_3578) && level._id_7B8B[level._id_7B8C]._id_3578.size > 0) {
      foreach(var_2 in level._id_7B8B[level._id_7B8C]._id_3578) {
        _id_7B79(var_2);
      }
    }
  }

  level._id_7B8C = var_0;
  thread _id_7B85(var_0);
  _id_0BD4(var_0);
}

_id_0BD4(var_0) {
  var_1 = _id_0BFA(var_0);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    foreach(var_4 in level._id_7B8B[var_1[var_2]]._id_54EC) {
      var_5 = var_4._id_5469;
      var_5 _meth_81B0(var_4._id_7B8A);
    }
  }
}

_id_0BD5(var_0, var_1, var_2) {
  if(!isDefined(level._id_7B8B[var_2]._id_3578) || level._id_7B8B[var_2]._id_3578.size == 0) {
    var_0 _meth_81B0(var_1);
  } else {
    var_3 = _id_0BFA(var_2, 1);
    var_4 = 0;

    for(var_5 = 0; var_5 < var_3.size; var_5++) {
      foreach(var_7 in level._id_7B8B[var_3[var_5]]._id_54EC) {
        if(var_7._id_5469 == var_0) {
          var_0 _meth_81B0(var_7._id_7B8A);
          var_4 = 1;
          break;
        }
      }

      if(var_4) {
        break;
      }
    }
  }
}

_id_0BC0(var_0, var_1) {
  if(!isDefined(level._id_7B8B[var_1]._id_3578) || level._id_7B8B[var_1]._id_3578.size == 0) {
    self _meth_81AD();
  } else {
    var_2 = _id_0BFA(var_1, 1);
    var_3 = 0;

    for(var_4 = 0; var_4 < var_2.size; var_4++) {
      foreach(var_6 in level._id_7B8B[var_2[var_4]]._id_54EC) {
        if(var_6._id_5469 == var_0) {
          var_0 _meth_81B0(var_6._id_7B8A);
          var_3 = 1;
          break;
        }
      }

      if(var_3) {
        break;
      }
    }

    if(!var_3) {
      self _meth_81AD();
    }
  }
}

_id_7B85(var_0) {
  level notify("hudoutline_new_channel_settings");
  level endon("hudoutline_new_channel_settings");
  wait 0.05;
  var_1 = [[level._id_5D95]]();
  var_2 = [[level._id_7B8B[var_0]._id_D72A]]();

  foreach(var_5, var_4 in var_1) {
    if(isDefined(var_2[var_5])) {
      setsaveddvar(var_5, var_2[var_5]);
      continue;
    }

    setsaveddvar(var_5, var_4);
  }

  if(isDefined(level._id_7B8B[var_0]._id_983E)) {
    _id_B1F6(var_0, level._id_7B8B[var_0]._id_983E);
  }
}

_id_7B79(var_0) {
  foreach(var_2 in level._id_7B8B[var_0]._id_54EC) {
    var_3 = var_2._id_5469;
    var_3 _meth_81AD();
  }
}

_id_7B6F(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = level._id_5D95;
  }

  if(!isDefined(level._id_7B8B)) {
    _id_7B77();
  }

  if(!isDefined(level._id_7B8B[var_0])) {
    level._id_7B8B[var_0] = spawnStruct();
    level._id_7B8B[var_0]._id_33F0 = var_0;
    level._id_7B8B[var_0]._id_BD27 = var_1;
    level._id_7B8B[var_0]._id_D72A = var_2;
    level._id_7B8B[var_0]._id_54EC = [];
  }
}

_id_7B71(var_0, var_1, var_2) {
  if(!isDefined(level._id_7B8B[var_0])) {
    level._id_7B8B[var_0] = spawnStruct();
    level._id_7B8B[var_0]._id_33F0 = var_0;
    level._id_7B8B[var_0]._id_BD27 = var_1;
    level._id_7B8B[var_0]._id_54EC = [];
    level._id_7B8B[var_0]._id_AE59 = var_2;
  }

  if(!isDefined(level._id_7B8B[var_2]._id_3578)) {
    level._id_7B8B[var_2]._id_3578 = [];
  }

  level._id_7B8B[var_2]._id_3578[level._id_7B8B[var_2]._id_3578.size] = var_0;
}

_id_7B84(var_0, var_1) {
  level._id_7B8B[var_0]._id_D72A = var_1;

  if(isDefined(level._id_7B8C) && level._id_7B8C == var_0) {
    thread _id_7B85(var_0);
  }
}

_id_7B83(var_0, var_1) {
  foreach(var_3 in level._id_7B8B[var_0]._id_54EC) {
    if(var_3._id_5469 == var_1) {
      return 1;
    }
  }

  return 0;
}

_id_7B82(var_0, var_1) {
  if(!isDefined(level._id_7B8D)) {
    level._id_7B8D = [];
  }

  if(var_1) {
    foreach(var_3 in level._id_7B8D) {
      if(var_3 == var_0) {
        return;
      }
    }

    level._id_7B8D[level._id_7B8D.size] = var_0;
    _id_7B6C();
  } else {
    var_5 = [];

    foreach(var_3 in level._id_7B8D) {
      if(var_3 != var_0) {
        var_5[var_5.size] = var_3;
      }
    }

    level._id_7B8D = var_5;
    _id_7B6C();
  }
}

_id_7B7D(var_0, var_1) {
  if(isDefined(var_1)) {
    self endon("endonMsg");
  }

  self endon(var_0 + "hudoutline_disable");
  scripts\engine\utility::waittill_any_2("death", "entitydeleted");
  thread _id_7B7C(var_0);
}

_id_B1F6(var_0, var_1) {
  if(!isDefined(level._id_7B8C) || level._id_7B8C != var_0) {
    return;
  }
  level notify("hudoutline_new_anim_on_channel_" + var_0);
  level endon("hudoutline_new_channel_settings");
  level endon("hudoutline_new_anim_on_channel_" + var_0);
  level[[var_1]]();
  thread _id_7B85(var_0);
}

_id_B1F7(var_0, var_1) {
  level._id_7B8B[var_0]._id_983E = var_1;

  if(!isDefined(level._id_7B8C) || level._id_7B8C != var_0) {
    return;
  }
  _id_B1F6(var_0, var_1);
}

_id_7B7A() {
  var_0 = [];

  if(isDefined(level.player._id_1A2E)) {
    var_1 = _func_0133(level.player.origin - level.player._id_1A2E.origin);
    var_2 = clamp(var_1 / 1000, 1, 2);
    var_0["#x37f5385a7721003c6"] = var_2;
  } else
    var_0["#x37f5385a7721003c6"] = 1;

  var_0["#x3fa08eff177bce1f2"] = "0.9 0.9 0.9 0.5";
  var_0["#x3fa08f0f177bce425"] = "0.3 0.3 0.3 0.5";
  var_0["#x3a640d72a622b53be"] = "1 1 1 1";
  var_0["#x3f4882363aaeeb795"] = "1 1 1 0.45";
  var_0["#x36710626bef3b9312"] = ".7 .7 .7 0.25";
  var_0["#x3bf1cef26c4100ba3"] = 1;
  var_0["#x3e3d49f424f03c1a1"] = "0.000 0.000 0.000 0.000";
  var_0["#x3e3d49e424f03bf6e"] = "0.882 0.882 0.882 1.000";
  var_0["#x3e3d49d424f03bd3b"] = "0.945 0.384 0.247 1.000";
  var_0["#x3e3d49c424f03bb08"] = "0.431 0.745 0.235 1.000";
  var_0["#x3e3d4a3424f03ca6d"] = "0.157 0.784 0.784 1.000";
  var_0["#x3e3d4a2424f03c83a"] = "0.886 0.600 0.000 1.000";
  var_0["#x3e3d4a1424f03c607"] = "0.000 0.000 0.000 1.000";
  var_0["#x3e3d4a0424f03c3d4"] = "1.000 0.300 0.300 1.000";
  return var_0;
}

_id_0BFA(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = [];
  var_2[0] = var_0;

  if(isDefined(level._id_7B8B[var_0]._id_3578) && level._id_7B8B[var_0]._id_3578.size > 0) {
    foreach(var_4 in level._id_7B8B[var_0]._id_3578) {
      if(level._id_7B8B[var_4]._id_54EC.size > 0) {
        for(var_5 = 0; var_5 < var_2.size; var_5++) {
          if(!var_1) {
            if(level._id_7B8B[var_2[var_5]]._id_BD27 >= level._id_7B8B[var_4]._id_BD27) {
              var_2 = _id_ACB1(var_2, var_4, var_5);
              break;
            } else if(var_5 + 1 == var_2.size) {
              var_2[var_5 + 1] = var_4;
              break;
            }
          } else if(level._id_7B8B[var_2[var_5]]._id_BD27 < level._id_7B8B[var_4]._id_BD27) {
            var_2 = _id_ACB1(var_2, var_4, var_5);
            break;
          } else if(var_5 + 1 == var_2.size) {
            var_2[var_5 + 1] = var_4;
            break;
          }
        }
      }
    }
  }

  return var_2;
}

_id_ACB1(var_0, var_1, var_2) {
  if(var_2 == var_0.size) {
    var_3 = var_0;
    var_3[var_3.size] = var_1;
    return var_3;
  }

  var_3 = [];
  var_4 = 0;

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    if(var_5 == var_2) {
      var_3[var_5] = var_1;
      var_4 = 1;
    }

    var_3[var_5 + var_4] = var_0[var_5];
  }

  return var_3;
}