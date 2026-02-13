/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2002.gsc
*************************************************/

init() {
  level._effect["flashpoint_kill_s1"] = loadfx("vfx/iw8_mp/flashpoint/vfx_fp_gunfight_s1.vfx");
  level._effect["flashpoint_kill_s2"] = loadfx("vfx/iw8_mp/flashpoint/vfx_fp_gunfight_s2.vfx");
  level._effect["flashpoint_kill_s3"] = loadfx("vfx/iw8_mp/flashpoint/vfx_fp_gunfight_s3.vfx");
  level._effect["flashpoint_gunfire_s1"] = loadfx("vfx/iw8_mp/flashpoint/vfx_fp_gunfight_small_s1.vfx");
  level._effect["flashpoint_pulse_friendly"] = loadfx("vfx/iw8_mp/flashpoint/vfx_fp_pulse_friendly.vfx");
  level._effect["flashpoint_pulse_squad"] = loadfx("vfx/iw8_mp/flashpoint/vfx_fp_pulse_squad.vfx");
  level._effect["flashpoint_pulse_enemy"] = loadfx("vfx/iw8_mp/flashpoint/vfx_fp_pulse_enemy.vfx");
  var_0 = getDvar("#x3219acf410e056ee", 0);
  level._id_5CC8 = getDvar("#x3de694b069365bd0e", 0) == "1";
  level._id_7C5B = "icon_swords_friendly";
  level._id_7C5A = "icon_swords_enemy";
  level._id_7C59 = "icon_swords_contested";
  level._id_7C5C = "icon_swords_neutral";
  level._id_5CCC = spawnStruct();
  level._id_5CCC._id_5CD6 = [];
  level._id_5CD4 = getdvarint("#x3a6d3ba62d85fdb2a", 0);

  if(istrue(level._id_5CD2)) {
    level._id_5CD5 = 16777216;
  } else {
    level._id_5CD5 = 4194304;
  }

  if(0 || var_0 == "1") {
    thread _id_5CCD();
    level._id_5CD3 = 1;
  } else
    level._id_5CD3 = 0;

  thread _id_5CCE();
}

_id_5CCE() {
  for(;;) {
    if(getDvar("#x3219acf410e056ee", 0) != "0") {
      if(level._id_5CC8) {
        thread _id_5CCD();
      }

      level._id_5CD3 = 1;

      foreach(var_1 in level.players) {
        if(!isDefined(var_1._id_5CCF)) {
          _id_5CD0(var_1);
        }
      }
    } else {
      level notify("disable_flashpoint");
      level._id_5CD3 = 0;

      if(level._id_5CC8) {
        foreach(var_4 in level._id_5CCC._id_5CD6) {
          _id_5CCA(var_4);
        }
      }
    }

    wait 1;
  }
}

_id_5CCD() {
  level endon("disable_flashpoint");

  for(;;) {
    foreach(var_1 in level._id_5CCC._id_5CD6) {
      var_2 = gettime();

      if(var_2 - var_1._id_8FD1 > 12500) {
        _id_5CCA(var_1);
        continue;
      }

      if(isDefined(var_1._id_A863) && var_2 - var_1._id_8FD1 >= 7500 && !istrue(var_1._id_5321)) {
        _id_5CC7(var_1);
      }

      var_3 = getarraykeys(var_1._id_56BC);

      foreach(var_5 in var_3) {
        if(var_2 - var_5 > 12500) {
          var_1._id_56BC = scripts\engine\utility::_id_1BC6(var_1._id_56BC, var_5);
        }
      }
    }

    foreach(var_9 in level.players) {
      if(!isDefined(var_9._id_5CCF)) {
        thread _id_5CD0(var_9);
      }
    }

    wait 1;
  }
}

_id_5CC9(var_0, var_1, var_2, var_3) {
  if(!level._id_5CD3) {
    return;
  }
  var_4 = (0, 0, 0);

  if(0) {
    var_4 = (randomfloatrange(-1000, 1000), randomfloatrange(-1000, 1000), 0);
  }

  if(var_3 == "gunfire") {
    var_5 = var_0.origin + (0, 0, 32);

    if(0) {
      var_5 = var_5 + var_4;
    }

    thread _id_B918(var_5, "flashpoint_kill_s2");
  } else {
    var_5 = (0, 0, 0);

    if(level._id_5CC8) {
      var_5 = _func_025E(var_0.origin + (0, 0, 48), var_1.origin + (0, 0, 48), 0.25);
    } else {
      var_5 = var_1.origin + (0, 0, 48);
    }

    if(0) {
      var_5 = var_5 + var_4;
    }

    if(level._id_5CC8) {
      var_6 = spawn("script_model", var_5);
      var_7 = var_6 scripts\engine\utility::_id_1BD6(level._id_5CCC._id_5CD6, ::_id_E034);
      var_6 delete();

      foreach(var_9 in var_7) {
        if(distancesquared(var_9._id_4140, var_5) < level._id_5CD5) {
          _id_5CD1(var_9, var_5, var_2, var_3);
          return;
        }
      }

      if(level._id_5CCC._id_5CD6.size >= 2) {
        _id_5CC4();
      }

      _id_5CC6(var_5, var_2, var_3);
    }

    thread _id_B918(var_5, "flashpoint_kill_s2");
  }
}

_id_5CC6(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3._id_4140 = var_0;
  var_3._id_8FD1 = var_1;
  var_3.team = "";
  _id_5CC2(var_3, var_1, var_2);
  level._id_5CCC._id_5CD6[level._id_5CCC._id_5CD6.size] = var_3;
}

_id_5CC5(var_0) {
  var_0._id_A863 = _id_07D6::_id_4026(var_0._id_4140, "neutral", (0, 0, 0), undefined, "any");
  _id_07F9::_id_A8B1(var_0._id_A863._id_A908, 0);
  var_0._id_A863._id_970A = 0;
  _id_07F9::_id_FB8F(var_0._id_A863._id_A908, level._id_7C5C);
  _id_07F9::_id_FB98(var_0._id_A863._id_A908, 2);
  var_0._id_A863._id_970A = 1;
}

_id_5CD1(var_0, var_1, var_2, var_3) {
  var_0 notify("end_update");
  var_0 endon("end_update");
  level endon("disable_flashpoint");

  if(!isDefined(var_0._id_A863) && var_0._id_56BC.size >= 5) {
    _id_5CC5(var_0);
  }

  var_0._id_5321 = 0;
  var_0._id_8FD1 = gettime();

  if(isDefined(var_0._id_A863) && level._id_5CC8) {
    _id_07F9::_id_A8B7(var_0._id_A863._id_A908, 0);
  } else {
    var_0._id_4140 = _func_025E(var_0._id_4140, var_1, 0.75);
  }

  thread _id_B918(var_1, "flashpoint_kill_s2");
  _id_5CC2(var_0, var_2, var_3);
}

_id_5CC2(var_0, var_1, var_2) {
  if(!isDefined(var_0._id_56BC)) {
    var_0._id_56BC = [];
  }

  var_0._id_56BC[var_1] = var_2;

  if(var_0._id_56BC.size > 8) {
    var_3 = [];
    var_4 = 0;

    foreach(var_7, var_6 in var_0._id_56BC) {
      if(var_4 > var_0._id_56BC.size - 8) {
        var_3[var_7] = var_6;
      }

      var_4++;
    }

    var_0._id_56BC = var_3;
  }
}

_id_5CCA(var_0) {
  var_0 notify("end_update");

  if(isDefined(var_0._id_A863) && level._id_5CC8) {
    var_0._id_A863 _id_07D6::_id_D8E0("none");
    var_0._id_A863 _id_07D6::_id_C300();
    var_0._id_A863._id_1041A = "none";
    var_0._id_A863 = undefined;
  }

  level._id_5CCC._id_5CD6 = scripts\engine\utility::array_remove(level._id_5CCC._id_5CD6, var_0);
}

_id_5CC7(var_0) {
  var_0._id_5321 = 1;

  if(level._id_5CC8) {
    _id_07F9::_id_A8B7(var_0._id_A863._id_A908, 1);
  }
}

_id_5CC3(var_0) {
  var_1 = 0;
  var_2 = 0;
  var_3 = "No Change";
  var_4 = var_0.team;

  foreach(var_6 in var_0._id_56BC) {
    if(var_6 == "kill_by_axis") {
      var_1++;
      continue;
    }

    if(var_6 == "kill_by_allies") {
      var_2++;
    }
  }

  if((var_1 - 1 > var_2 || var_2 == 0) && var_0.team != "axis" && var_1 != 0) {
    if(level._id_5CC8) {
      _id_07F9::_id_FB96(var_0._id_A908, "axis");
      _id_07F9::_id_FB9B(var_0._id_A908, 0);
    }

    var_0.team = "axis";
    var_3 = "Switch To Axis Owner";
  } else if((var_2 - 1 > var_1 || var_1 == 0) && var_0.team != "allies" && var_2 != 0) {
    if(level._id_5CC8) {
      _id_07F9::_id_FB96(var_0._id_A908, "allies");
      _id_07F9::_id_FB9B(var_0._id_A908, 0);
    }

    var_0.team = "allies";
    var_3 = "Switch To Allies Owner";
  } else if(var_0.team != "neutral" && var_2 != 0 && var_1 != 0) {
    if(level._id_5CC8) {
      _id_07F9::_id_FB96(var_0._id_A908, undefined);
      _id_07F9::_id_FB9B(var_0._id_A908, 1);
    }

    var_0.team = "neutral";
    var_3 = "Switch To Contested";
  }
}

_id_E034(var_0, var_1) {
  return distancesquared(var_0._id_4140, self.origin) < distancesquared(var_1._id_4140, self.origin);
}

_id_5CC4() {
  var_0 = undefined;

  foreach(var_2 in level._id_5CCC._id_5CD6) {
    if(!isDefined(var_0)) {
      var_0 = var_2;
      continue;
    }

    if(var_2._id_8FD1 > var_0._id_8FD1) {
      var_0 = var_2;
    }
  }

  _id_5CCA(var_0);
}

_id_B918(var_0, var_1) {
  if(!isDefined(level._effect) || !isDefined(level._effect[var_1]) || level._effect[var_1] == 0) {
    return;
  }
  playFX(scripts\engine\utility::getfx(var_1), var_0);
}

_id_5CD0(var_0) {
  var_0 endon("disconnect");
  level endon("disable_flashpoint");
  var_0._id_5CCF = 1;

  for(;;) {
    var_0 waittill("begin_firing");
    wait 1.0;
    _id_5CC9(var_0, undefined, gettime(), "gunfire");
    wait 0.25;
  }
}

_id_5CCB() {
  self endon("disconnect");
  self notify("start_SpawnSelectionThink");
  self endon("start_SpawnSelectionThink");

  while(self._id_82F2) {
    foreach(var_1 in level.players) {
      if(!isalive(var_1)) {
        continue;
      }
      if(self.team != var_1.team) {
        if(istrue(level._id_E374)) {
          _func_019D(level._effect["flashpoint_pulse_enemy"], var_1, "tag_eye", self);
        }

        continue;
      }

      if(istrue(level._id_E375)) {
        if(self._id_E496 == var_1._id_E496) {
          _func_019D(level._effect["flashpoint_pulse_squad"], var_1, "tag_eye", self);
          continue;
        }

        _func_019D(level._effect["flashpoint_pulse_friendly"], var_1, "tag_eye", self);
      }
    }

    wait 1.1;
  }
}