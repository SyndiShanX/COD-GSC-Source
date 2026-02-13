/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2549.gsc
*************************************************/

_id_C337() {
  while(!isDefined(level._id_2915)) {
    wait 0.05;
  }

  if(isDefined(level._id_27FD)) {
    return;
  }
  level._id_282C["heli_pilot"] = (0, 0, 350);
  level._id_282C["heli_sniper"] = (0, 0, 228);
  level._id_282B["isUsing"]["odin_assault"] = ::scripts\mp\utility\player::_id_8ACE;
  level._id_282B["isUsing"]["odin_support"] = ::scripts\mp\utility\player::_id_8ACE;
  level._id_282B["isUsing"]["heli_pilot"] = ::scripts\mp\utility\player::_id_8ACE;
  level._id_282B["isUsing"]["switchblade_cluster"] = ::scripts\mp\utility\player::_id_8ACE;
  level._id_282B["isUsing"]["vanguard"] = ::_id_8AD8;
  level._id_282B["waittill_initial_goal"]["heli_pilot"] = ::_id_7707;
  level._id_282B["waittill_initial_goal"]["heli_sniper"] = ::_id_7728;
  level._id_282B["control_aiming"]["heli_pilot"] = ::_id_7701;
  level._id_282B["control_aiming"]["heli_sniper"] = ::scripts\engine\utility::_id_51C7;
  level._id_282B["control_aiming"]["vanguard"] = ::_id_FFB7;
  level._id_282B["control_other"]["heli_pilot"] = ::_id_7704;
  level._id_282B["heli_pick_node"]["heli_pilot"] = ::_id_7705;
  level._id_282B["heli_pick_node"]["heli_sniper"] = ::_id_7727;
  level._id_282B["heli_pick_node"]["vanguard"] = ::_id_FFBD;
  level._id_282B["heli_node_get_origin"]["heli_pilot"] = ::_id_76C6;
  level._id_282B["heli_node_get_origin"]["heli_sniper"] = ::_id_76C6;
  level._id_282B["heli_node_get_origin"]["vanguard"] = ::_id_FFB8;
  level._id_282B["odin_perform_action"]["odin_assault"] = ::_id_A92D;
  level._id_282B["odin_perform_action"]["odin_support"] = ::_id_A93C;
  level._id_282B["odin_get_target"]["odin_assault"] = ::_id_A92C;
  level._id_282B["odin_get_target"]["odin_support"] = ::_id_A93B;
  var_0 = scripts\engine\utility::getstructarray("so_chopper_boss_path_struct", "script_noteworthy");
  level._id_27F0 = [];

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_0398)) {
      level._id_27F0 = scripts\engine\utility::array_add(level._id_27F0, var_2);
    }
  }

  level._id_27F1 = scripts\mp\utility\killstreak::_id_6A99();

  foreach(var_5 in level._id_27F0) {
    var_5._id_FFBC = var_5.origin;
    var_6 = var_5.origin + (0, 0, 50);
    var_5._id_FF30 = 1;

    if(var_6[2] <= var_5.origin[2] - 1000) {
      var_5._id_FF30 = 0;
    }

    var_6 = var_6 - (0, 0, 50);
    var_5._id_FFBC = var_6;
  }

  var_8 = -99999999;

  foreach(var_5 in level._id_27F0) {
    var_8 = max(var_8, var_5.origin[2]);
  }

  level._id_2914 = var_8 - level._id_2852 + 100;
  level._id_7703 = getdvarfloat("#x33d0ed93f9c04634f");

  while(!isDefined(level._id_A933) || !isDefined(level._id_A934)) {
    wait 0.05;
  }

  level._id_A92E = (level._id_A933 + level._id_A934) / 2;
  level._id_AD19 = [];

  if(isDefined(level._id_F03A)) {
    var_11 = [[level._id_F03A]]();
  } else {
    var_11 = [];

    for(var_12 = 0; var_12 < level._id_110E1; var_12++) {
      var_11[var_11.size] = var_12;
    }
  }

  foreach(var_14 in var_11) {
    if(_func_002A(var_14) < 0.25) {
      level._id_AD19 = scripts\engine\utility::array_add(level._id_AD19, var_14);
    }
  }

  level._id_2871["recruit"] = 1.0;
  level._id_2871["regular"] = 0.7;
  level._id_2871["hardened"] = 0.4;
  level._id_2871["veteran"] = 0.05;
  level._id_27FD = 1;
}

_id_2821(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3)) {
    return 0;
  }

  var_5 = 1;
  var_6 = 1;
  var_7 = undefined;

  if(isDefined(self._id_A54D)) {
    var_8 = self _meth_803D();
    var_9 = distancesquared(self.origin, self._id_A54D.origin);

    if(var_9 < _func_0219(var_8)) {
      var_5 = 0;
      var_6 = 0;
    } else if(var_9 < _func_0219(200))
      var_5 = 0;
  }

  var_10 = var_0.streakname == "vanguard" && _id_8608();

  if(var_10 || var_5) {
    var_11 = _func_00B4(self.origin, 500, 0, 512);

    if(isDefined(var_11) && var_11.size > 0) {
      if(isDefined(var_4) && var_4) {
        var_12 = var_11;
        var_11 = [];

        foreach(var_14 in var_12) {
          if(_func_0157(var_14)) {
            var_15 = _func_00A6(var_14);
            var_16 = 0;

            foreach(var_18 in var_15) {
              if(_func_0157(var_18)) {
                var_16++;
              }
            }

            if(var_16 / var_15.size > 0.5) {
              var_11 = scripts\engine\utility::array_add(var_11, var_14);
            }
          }
        }
      }

      if(var_10) {
        var_21 = self _meth_804B(var_11, "node_exposed");

        foreach(var_14 in var_21) {
          if(scripts\engine\trace::_bullet_trace_passed(var_14.origin + (0, 0, 30), var_14.origin + (0, 0, 400), 0, self)) {
            var_7 = var_14;
            break;
          }

          wait 0.05;
        }
      } else if(var_11.size > 0)
        var_7 = self _meth_8049(var_11, min(3, var_11.size), "node_hide");

      if(!isDefined(var_7)) {
        return 0;
      }

      self _meth_8059(var_7, "tactical");
    }
  }

  if(var_6) {
    var_24 = scripts\mp\bots\bots_util::_id_291C();

    if(var_24 != "goal") {
      _id_F704(var_7);
      return 1;
    }
  }

  if(isDefined(var_2) && !self[[var_2]]()) {
    _id_F704(var_7);
    return 0;
  }

  if(!scripts\mp\bots\bots_util::_id_26FC()) {
    _id_F704(var_7);
    return 1;
  }

  if(!isDefined(var_7)) {
    if(self getstance() == "prone") {
      self _meth_805B("prone");
    } else if(self getstance() == "crouch") {
      self _meth_805B("crouch");
    }
  } else if(self _meth_8030("strategyLevel") > 0) {
    if(randomint(100) > 50) {
      self _meth_805B("prone");
    } else {
      self _meth_805B("crouch");
    }
  }

  _id_09F4::_id_28F0(var_0, var_1, var_0._id_04F6);
  self._id_10020 = undefined;
  self thread[[var_3]]();
  thread _id_2783();
  thread _id_2785(var_7);
  self waittill("control_func_done");
  return 1;
}

_id_2783() {
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  self waittill("spawned_player");
  self notify("control_func_done");
}

_id_2785(var_0) {
  self endon("disconnect");
  self waittill("control_func_done");
  _id_F704(var_0);
  self _meth_805B("none");
  self _meth_805A(0, 0);
  self _meth_8054("disable_movement", 0);
  self _meth_8054("disable_rotation", 0);
  self._id_10020 = undefined;
}

_id_F704(var_0) {
  if(isDefined(var_0) && self _meth_8042() && isDefined(self _meth_803C()) && self _meth_803C() == var_0) {
    self _meth_802B();
  }
}

_id_2784(var_0) {
  var_0 waittill("death");
  self notify("control_func_done");
}

_id_291E(var_0) {
  var_1 = gettime();

  while(!self[[level._id_282B["isUsing"][var_0]]]()) {
    wait 0.05;

    if(gettime() - var_1 > 5000) {
      return 0;
    }
  }

  return 1;
}

_id_2746() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  childthread _id_73F0();
  var_0 = _id_291E("switchblade_cluster");

  if(!var_0) {
    self notify("control_func_done");
  }

  thread _id_EC30();
  var_1 = _id_5ABD(self);
  wait 0.1;
  self._id_AA34 = self._id_02A0;
  self._id_02A0 = 256000000;
  thread _id_10A2C();
  var_2 = undefined;
  var_3 = 0;
  var_4 = 0;
  var_5 = [];
  var_6 = undefined;
  var_7 = 0;
  var_8 = 0;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = 0;
  var_12 = _id_8608();

  while(self[[level._id_282B["isUsing"]["switchblade_cluster"]]]() && isDefined(var_1)) {
    foreach(var_14 in level._id_C8B8) {
      if(isDefined(var_14) && var_14.owner == self && var_14.weapon_name == "switch_blade_child_mp") {
        var_15 = 1;

        foreach(var_17 in var_5) {
          if(var_17._id_037A == var_14) {
            var_15 = 0;
          }
        }

        if(var_15) {
          var_19 = spawnStruct();
          var_19._id_037A = var_14;
          var_19.target = var_6;
          var_6 = undefined;
          var_5 = scripts\engine\utility::array_add(var_5, var_19);
        }
      }
    }

    for(var_21 = 0; var_21 < var_5.size; var_21++) {
      var_17 = var_5[var_21];

      if(isDefined(var_17) && isDefined(var_17._id_037A) && !scripts\engine\utility::array_contains(level._id_C8B8, var_17._id_037A)) {
        var_5[var_21] = var_5[var_5.size - 1];
        var_5[var_5.size - 1] = undefined;
        var_21--;
      }
    }

    if(var_11) {
      wait 0.05;
      continue;
    }

    var_22 = undefined;

    if(isDefined(var_10)) {
      var_22 = var_10;

      if(!isalive(var_10) || !self _meth_8028(var_22)) {
        if(!isalive(var_10)) {
          var_11 = 1;
        }

        wait 0.05;
        continue;
      }
    }

    var_23 = [];

    if(!isDefined(var_22)) {
      var_24 = _id_281A(0);
      var_25 = [];

      foreach(var_17 in var_5) {
        if(isDefined(var_17.target)) {
          var_25 = scripts\engine\utility::array_add(var_25, var_17.target);
        }
      }

      var_24 = scripts\engine\utility::_id_1BBF(var_24, var_25);

      foreach(var_29 in var_24) {
        if(var_29 scripts\mp\utility\perk::_hasperk("specialty_noplayertarget")) {
          continue;
        }
        if(self _meth_8028(var_29) || var_12 && scripts\engine\utility::_id_10E76(self getEye(), var_1.angles, var_29.origin, self _meth_8032())) {
          if(!_id_270A() && distancesquared(var_29.origin, self.origin) < 40000) {
            continue;
          }
          var_23 = scripts\engine\utility::array_add(var_23, var_29);

          if(!isDefined(var_22)) {
            var_22 = var_29;
            continue;
          }

          var_30 = vectornormalize(var_22.origin - var_1.origin);
          var_31 = vectornormalize(var_29.origin - var_1.origin);
          var_32 = anglesToForward(var_1.angles);
          var_33 = vectordot(var_30, var_32);
          var_34 = vectordot(var_31, var_32);

          if(var_34 > var_33) {
            var_22 = var_29;
          }
        }
      }
    }

    if(isDefined(var_22)) {
      var_2 = undefined;
      var_36 = var_1.origin[2] - var_22.origin[2];
      var_37 = self _meth_802F();

      if(var_37 == "recruit") {
        var_9 = var_22.origin;
      } else if(var_36 < 5000) {
        var_9 = var_22.origin;
      } else if(length(var_22 _meth_8131()) < 25) {
        var_9 = var_22.origin;
      } else if(gettime() - var_8 > 500) {
        var_8 = gettime();
        var_38 = 3.0;

        if(var_37 == "regular") {
          var_38 = 1.0;
        }

        var_9 = _func_00C7(var_22, var_38);
      }

      var_39 = _id_9F60(var_1, var_9);
      var_40 = _id_9F61(var_1, var_9);

      if(var_40 < 30) {
        var_41 = 0.0;
      } else if(var_40 < 100) {
        var_41 = 0.15;
      } else if(var_40 < 200) {
        var_41 = 0.3;
      } else if(var_40 < 400) {
        var_41 = 0.6;
      } else {
        var_41 = 1.0;
      }

      if(var_7) {
        var_41 = min(var_41 * 3, 1.0);
      }

      if(var_41 > 0) {
        self _meth_805A(var_39[1], 0.05, var_41, 1, 1);
      } else if(gettime() > var_4) {
        if(var_3 < 2) {
          self _meth_804E("attack");
          var_3++;
          var_4 = gettime() + 200;

          if(var_37 == "regular" && var_3 == 2 || var_37 == "hardened" || var_37 == "veteran") {
            var_42 = var_3 == 1 && var_23.size == 1;

            if(!var_42) {
              var_6 = var_22;
              var_4 = var_4 + 800;
            }
          }
        } else if(!var_7 && (var_36 < 5000 || var_37 == "recruit")) {
          var_7 = 1;
          self _meth_804E("attack");

          if(var_37 == "recruit") {
            var_10 = var_22;
          }
        }
      }
    } else {
      if(!isDefined(var_2)) {
        var_2 = scripts\engine\utility::random(level._id_AD19);
      }

      var_43 = _func_00F6(var_2).origin;

      if(_id_9F61(var_1, var_43) < 200) {
        var_2 = scripts\engine\utility::random(level._id_AD19);
        var_43 = _func_00F6(var_2).origin;
      }

      var_39 = _id_9F60(var_1, var_43);
      self _meth_805A(var_39[1], 0.05, 0.75, 1, 1);
    }

    wait 0.05;
  }

  self notify("control_func_done");
}

_id_9F60(var_0, var_1) {
  var_2 = _id_9F5F(var_0, var_1[2]);
  var_3 = vectornormalize(var_1 - var_2);
  return vectortoangles(var_3);
}

_id_9F61(var_0, var_1) {
  var_2 = _id_9F5F(var_0, var_1[2]);
  return distance(var_2, var_1);
}

_id_73F0() {
  self _meth_8054("disable_rotation", 1);
  self _meth_8054("disable_movement", 1);
  _id_5ABD(self);
  self _meth_8054("disable_rotation", 0);
  self _meth_8054("disable_movement", 0);
}

_id_EC30() {
  self endon("disconnect");
  self _meth_8051(2.5);
  self waittill("control_func_done");
  self _meth_8051(1.0);
}

_id_9F5F(var_0, var_1) {
  var_2 = anglesToForward(var_0.angles);
  var_3 = (var_1 - var_0.origin[2]) / var_2[2];
  var_4 = var_0.origin + var_2 * var_3;
  return var_4;
}

_id_10A2C() {
  self endon("disconnect");
  self waittill("control_func_done");
  self._id_02A0 = self._id_AA34;
}

_id_5ABD(var_0) {
  for(;;) {
    foreach(var_2 in level._id_C8B8) {
      if(isDefined(var_2) && var_2.owner == var_0) {
        return var_2;
      }
    }

    wait 0.05;
  }
}

_id_FFB6() {
  if(!_id_09F4::_id_11DF()) {
    return 0;
  }

  if(_id_09F4::_id_88EC("vanguard")) {
    return 0;
  }

  return 1;
}

_id_2827(var_0, var_1, var_2, var_3) {
  _id_2821(var_0, var_1, var_2, var_3, 1);
}

_id_8AD8() {
  return scripts\mp\utility\player::_id_8ACE() && self._id_FF18 == "vanguard" && isDefined(self._id_C344);
}

_id_2747() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  var_0 = _id_291E("vanguard");

  if(!var_0) {
    self notify("control_func_done");
  }

  self._id_10020 = self._id_C344;
  childthread _id_2784(self._id_10020);
  self._id_10020 endon("death");
  wait 0.5;
  var_1 = 0;
  var_2 = !self._id_10020 _id_FFB9();
  var_3 = undefined;
  var_4 = 0;
  var_5 = _id_8608();

  while(var_2 && !var_5) {
    var_6 = _func_00B5(self._id_10020.origin, 1024, 64, 512, "path");

    if(isDefined(var_3)) {
      var_6 = scripts\engine\utility::array_remove(var_6, var_3);
    }

    foreach(var_8 in var_6) {
      if(_id_A55E(var_8)) {
        var_3 = var_8;
        break;
      }

      wait 0.05;
      var_1 = var_1 + 0.05;
    }

    if(var_1 < 1.0) {
      wait(1.0 - var_1);
    }

    if(!isDefined(var_3)) {
      self _meth_804E("use", 4.0);
      wait 4.0;
    }

    var_10 = scripts\mp\bots\bots_util::_id_289B("GetNodesOnPathVanguard", scripts\mp\bots\bots_util::_id_601E, self._id_10020.origin, var_3.origin);

    if(!isDefined(var_10)) {
      if(var_4 == 0) {
        var_4++;
        wait 0.05;
        continue;
      } else {
        self _meth_804E("use", 4.0);
        wait 4.0;
      }
    }

    for(var_11 = 0; var_11 < var_10.size; var_11++) {
      var_12 = var_10[var_11];

      if(var_11 == 0 && distancesquared(self.origin, var_12.origin) < 1600) {
        continue;
      }
      var_13 = 32;

      if(var_11 == var_10.size - 1) {
        var_13 = 16;
      }

      var_14 = self._id_10020.origin;
      var_15 = gettime() + 2500;

      while(distance2dsquared(var_12.origin, self._id_10020.origin) > var_13 * var_13) {
        if(self._id_10020 _id_FFB9()) {
          var_11 = var_10.size;
          break;
        }

        if(gettime() > var_15) {
          var_15 = gettime() + 2500;
          var_16 = distancesquared(self._id_10020.origin, var_14);

          if(var_16 < 1.0) {
            var_11++;
            break;
          }

          var_14 = self._id_10020.origin;
        }

        var_17 = vectornormalize(var_12.origin - self._id_10020.origin);
        self _meth_805A(vectortoangles(var_17)[1], 0.2);
        self _meth_8045(var_12.origin, 0.2, "script_forced");
        var_18 = var_12.origin[2] + 64;
        var_19 = var_18 - self._id_10020.origin[2];

        if(var_19 > 10) {
          self _meth_804E("lethal");
        } else if(var_19 < -10) {
          self _meth_804E("tactical");
        }

        wait 0.05;
      }
    }

    var_2 = 0;

    if(!self._id_10020 _id_FFB9()) {
      var_2 = 1;
    }
  }

  self _meth_805A(0, 0);
  self _meth_8045(undefined);
  self childthread[[level._id_282B["control_aiming"]["vanguard"]]]();
  var_21 = self._id_10020.origin[2];
  var_22 = undefined;
  var_23 = gettime() + 2000;
  var_24 = [];
  var_24[0] = (1, 0, 0);
  var_24[1] = (-1, 0, 0);
  var_24[2] = (0, 1, 0);
  var_24[3] = (0, -1, 0);
  var_24[4] = (1, 1, 0);
  var_24[5] = (1, -1, 0);
  var_24[6] = (-1, 1, 0);
  var_24[7] = (-1, -1, 0);
  var_25 = _id_5ABB(self._id_10020.origin, "vanguard");

  while(var_25._id_FFBC[2] - self._id_10020.origin[2] > 20) {
    if(gettime() > var_23) {
      var_23 = gettime() + 2000;

      if(isDefined(var_22)) {
        var_22 = undefined;
      } else {
        var_19 = self._id_10020.origin[2] - var_21;

        if(var_19 < 20 && !var_5) {
          var_26 = scripts\engine\utility::array_randomize(var_24);

          foreach(var_28 in var_26) {
            if(_id_BA01(self._id_10020.origin + var_28 * 64)) {
              if(!scripts\engine\trace::_bullet_trace_passed(self._id_10020.origin, self._id_10020.origin + var_28 * 64, 0, self._id_10020)) {
                wait 0.05;
                continue;
              }

              var_22 = var_28;
              break;
            }

            wait 0.05;
          }
        }
      }

      var_21 = self._id_10020.origin[2];
    }

    if(isDefined(var_22)) {
      self _meth_805A(vectortoangles(var_22)[1], 0.05);

      if(scripts\engine\utility::cointoss()) {
        self _meth_804E("tactical");
      }
    } else
      self _meth_804E("lethal");

    wait 0.05;
  }

  wait 1.0;
  wait 1.0;
  self _meth_8054("disable_movement", 0);
  _id_2740("vanguard", 0);
  self notify("control_func_done");
}

_id_B9FF(var_0) {
  var_1 = _func_0080(var_0);

  if(isDefined(var_1)) {
    return _id_A55E(var_1);
  }

  return 0;
}

_id_A55E(var_0) {
  if(_func_0157(var_0)) {
    return _id_BA01(var_0.origin);
  }

  return 0;
}

_id_BA01(var_0) {
  var_1 = var_0;
  var_2 = var_0 + (0, 0, level._id_2914);

  if(var_2[2] <= var_1[2]) {
    return 0;
  }

  var_3 = scripts\engine\trace::_bullet_trace_passed(var_1, var_2, 0, undefined);
  return var_3;
}

_id_FFB9() {
  var_0 = _func_0080(self.origin);

  if(isDefined(var_0) && !_func_0157(var_0)) {
    return 0;
  }

  wait 0.05;

  if(!_id_BA01(self.origin + (18, 0, 25))) {
    return 0;
  }

  wait 0.05;

  if(!_id_BA01(self.origin + (-18, 0, 25))) {
    return 0;
  }

  wait 0.05;

  if(!_id_BA01(self.origin + (0, 18, 25))) {
    return 0;
  }

  wait 0.05;

  if(!_id_BA01(self.origin + (0, -18, 25))) {
    return 0;
  }

  return 1;
}

_id_FFB7() {
  self notify("vanguard_control_aiming");
  self endon("vanguard_control_aiming");
  var_0 = undefined;
  var_1 = 0;
  var_2 = gettime();
  var_3 = 0;
  var_4 = undefined;
  var_5 = 0;

  while(self[[level._id_282B["isUsing"]["vanguard"]]]()) {
    var_6 = undefined;
    var_7 = self getEye();
    var_8 = self getplayerangles();
    var_9 = self _meth_8032();

    if(isalive(self._id_0192) && self _meth_8028(self._id_0192)) {
      var_10 = 1;
      var_6 = self._id_0192;
      var_5 = 0;
    } else if(var_5 < 10.0) {
      foreach(var_12 in level.characters) {
        if(var_12 == self || !isalive(var_12)) {
          continue;
        }
        if(var_12 scripts\mp\utility\perk::_hasperk("specialty_noplayertarget")) {
          continue;
        }
        if(!isDefined(var_12.team)) {
          continue;
        }
        if(!level.teambased || self.team != var_12.team) {
          if(scripts\engine\utility::_id_10E76(var_7, var_8, var_12.origin, var_9)) {
            var_5 = var_5 + 0.05;

            if(isDefined(var_6)) {
              var_13 = distancesquared(self._id_10020.origin, var_6.origin);
              var_14 = distancesquared(self._id_10020.origin, var_12.origin);

              if(var_14 < var_13) {
                var_6 = var_12;
              }

              continue;
            }

            var_6 = var_12;
          }
        }
      }
    }

    if(isDefined(var_6)) {
      if((isai(var_6) || isPlayer(var_6)) && length(var_6 _meth_8131()) < 25) {
        var_0 = var_6.origin;
      } else if(gettime() - var_3 < 500) {
        if(var_4 != var_6) {
          var_0 = var_6.origin;
        }
      } else if(gettime() - var_3 > 500) {
        var_3 = gettime();
        var_0 = _func_00C7(var_6, 3.0);
        var_4 = var_6;
      }

      var_16 = 165;

      if(gettime() - var_2 > 10000) {
        var_16 = 200;
      }

      if(distancesquared(self._id_10020._id_1DCB.origin, var_0) < level._id_FFBA * level._id_FFBA) {
        if(_id_270A() || distancesquared(self._id_10020._id_1DCB.origin, self.origin) > level._id_FFBA * level._id_FFBA) {
          var_2 = gettime();
          self _meth_804E("attack");
        }
      }
    } else if(gettime() > var_1) {
      var_1 = gettime() + randomintrange(1000, 2000);
      var_0 = _id_66DB();
      self._id_A46D = gettime();
    }

    if(length(var_0) == 0) {
      var_0 = (0, 0, 10);
    }

    self _meth_8045(var_0, 0.2, "script_forced");
    wait 0.05;
  }
}

_id_FFBD(var_0) {
  var_0._id_2919[self._id_5501]++;
  var_1 = [[level._id_282B["heli_node_get_origin"]["vanguard"]]](var_0);
  var_2 = _id_2913(var_0);
  var_3 = var_2;
  var_2 = [];

  foreach(var_5 in var_3) {
    if(var_5._id_FF30) {
      if(var_0.origin[2] != var_0._id_FFBC[2] || var_5.origin[2] != var_5._id_FFBC[2]) {
        var_6 = [[level._id_282B["heli_node_get_origin"]["vanguard"]]](var_5);
        var_7 = _func_019A(var_1, var_6);

        if(distancesquared(var_7, var_6) < 1) {
          var_2 = scripts\engine\utility::array_add(var_2, var_5);
        }

        wait 0.05;
        continue;
      }

      var_2 = scripts\engine\utility::array_add(var_2, var_5);
    }
  }

  if(var_2.size == 0 && var_3.size > 0) {
    foreach(var_5 in var_3) {
      var_5._id_2919[self._id_5501]++;
    }
  }

  return _id_76FE(var_2, "vanguard");
}

_id_2913(var_0) {
  var_1 = 99;
  var_2 = [];

  foreach(var_4 in var_0._id_A421) {
    if(isDefined(var_4._id_0398) && var_4._id_FF30) {
      var_5 = var_4._id_2919[self._id_5501];

      if(var_5 < var_1) {
        var_2 = [];
        var_2[0] = var_4;
        var_1 = var_5;
      } else if(var_5 == var_1)
        var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_FFB8(var_0) {
  return var_0._id_FFBC;
}

_id_AC7B(var_0) {
  var_1 = 1;
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2.origin = var_0;
  var_2 delete();
  return var_1;
}

_id_7725() {
  if(!_id_09F4::_id_11DF()) {
    return 0;
  }

  return 1;
}

_id_7728() {
  self._id_10020 waittill("near_goal");
}

_id_2742() {
  thread _id_7726();
  _id_273F("heli_sniper");
}

_id_7726() {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  self _meth_802B();
}

_id_7727(var_0) {
  var_0._id_2919[self._id_5501]++;
  var_1 = _id_27EF(var_0);
  return _id_76FE(var_1, "heli_sniper");
}

_id_7700() {
  if(!_id_09F4::_id_11DF()) {
    return 0;
  }

  if(_id_0A49::_id_56CE(self.team)) {
    return 0;
  }

  return 1;
}

_id_7707() {
  self._id_10020 waittill("goal_reached");
}

_id_2741() {
  _id_273F("heli_pilot");
}

_id_7705(var_0) {
  var_0._id_2919[self._id_5501]++;
  var_1 = _id_27EF(var_0);
  var_2 = scripts\engine\utility::random(var_1);
  return var_2;
}

_id_7704() {
  self notify("heli_pilot_monitor_flares");
  self endon("heli_pilot_monitor_flares");
  var_0 = [];

  while(self[[level._id_282B["isUsing"]["heli_pilot"]]]()) {
    self._id_10020 waittill("targeted_by_incoming_missile", var_1);

    if(!_id_0A44::_id_5C73(self._id_10020)) {
      break;
    }

    var_2 = 1;

    foreach(var_4 in var_1) {
      if(isDefined(var_4) && !scripts\engine\utility::array_contains(var_0, var_4)) {
        var_2 = 0;
      }
    }

    if(!var_2) {
      var_6 = clamp(0.34 * self _meth_8030("strategyLevel"), 0.0, 1.0);

      if(randomfloat(1.0) < var_6) {
        self notify("manual_flare_popped");
      }

      var_0 = scripts\engine\utility::array_combine(var_0, var_1);
      var_0 = scripts\engine\utility::_id_1BD1(var_0);
      wait 3.0;
    }
  }
}

_id_7701() {
  self notify("heli_pilot_control_heli_aiming");
  self endon("heli_pilot_control_heli_aiming");
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = 0;
  var_4 = 0;
  var_5 = undefined;
  var_6 = (self _meth_8030("minInaccuracy") + self _meth_8030("maxInaccuracy")) / 2;
  var_7 = 0;

  while(self[[level._id_282B["isUsing"]["heli_pilot"]]]()) {
    var_8 = 0;
    var_9 = 0;

    if(isDefined(var_1) && var_1.health <= 0 && gettime() - var_1._id_441F < 2000) {
      var_8 = 1;
      var_9 = 1;
    } else if(isalive(self._id_0192) && (self _meth_8028(self._id_0192) || gettime() - self _meth_8205(self._id_0192) <= 300)) {
      var_8 = 1;
      var_1 = self._id_0192;
      var_0 = self._id_0192.origin;

      if(self _meth_8028(self._id_0192)) {
        var_7 = 0;
        var_9 = 1;
        var_10 = gettime();
      } else {
        var_7 = var_7 + 0.05;

        if(var_7 > 5.0) {
          var_8 = 0;
        }
      }
    }

    if(var_8) {
      var_2 = var_0 - (0, 0, 50);

      if(var_9 && (_id_270A() || distancesquared(var_2, self.origin) > level._id_7703 * level._id_7703)) {
        self _meth_804E("attack");
      }

      if(gettime() > var_4 + 500) {
        var_11 = randomfloatrange(-1 * var_6 / 2, var_6 / 2);
        var_12 = randomfloatrange(-1 * var_6 / 2, var_6 / 2);
        var_13 = randomfloatrange(-1 * var_6 / 2, var_6 / 2);
        var_5 = (150 * var_11, 150 * var_12, 150 * var_13);
        var_4 = gettime();
      }

      var_2 = var_2 + var_5;
      var_14 = self._id_10020 gettagorigin("tag_player");
      var_15 = vectornormalize(var_2 - var_14);
      var_16 = anglesToForward(self getplayerangles());
      var_17 = vectordot(var_15, var_16);

      if(var_17 > 0.5) {
        self _meth_804E("ads", 0.1);
      }
    } else if(gettime() > var_3) {
      var_3 = gettime() + randomintrange(1000, 2000);
      var_2 = _id_66DB();
      self._id_A46D = gettime();
    }

    var_18 = var_2 - self._id_10020.origin;
    var_19 = length(var_18);
    var_20 = vectortoangles(var_18);
    var_21 = _func_000A(self._id_10020.angles[0]);
    var_22 = _func_000A(var_20[0]);
    var_23 = int(var_21 - var_22) % 360;

    if(var_23 > 180) {
      var_23 = 360 - var_23;
    } else if(var_23 < -180) {
      var_23 = -360 + var_23;
    }

    if(var_23 > 15) {
      var_22 = var_21 - 15;
    } else if(var_23 < -15) {
      var_22 = var_21 + 15;
    }

    var_20 = (var_22, var_20[1], var_20[2]);
    var_18 = anglesToForward(var_20);
    var_2 = self._id_10020.origin + var_18 * var_19;

    if(length(var_2) == 0) {
      var_2 = (0, 0, 10);
    }

    self _meth_8045(var_2, 0.2, "script_forced");
    wait 0.05;
  }
}

_id_2744() {
  _id_2743("odin_assault");
}

_id_A92D() {
  if(_id_2876()) {
    return 1;
  }

  if(_id_2874()) {
    return 1;
  }

  if(_id_2872()) {
    return 1;
  }

  return 0;
}

_id_A92C() {
  return _id_2867();
}

_id_2867() {
  var_0 = undefined;

  if(isDefined(self._id_8F37) && gettime() - self._id_8F38 < 5000) {
    var_0 = self._id_8F37;
  }

  return _id_2868("enemy", 1, var_0);
}

_id_2874() {
  var_0 = _id_2870();

  if(var_0 == "large") {
    self notify("large_rod_action");
    return 1;
  }

  if(var_0 == "small") {
    self notify("small_rod_action");
    return 1;
  }

  return 0;
}

_id_2870() {
  var_0 = gettime() >= self._id_A92A._id_A931;
  var_1 = gettime() >= self._id_A92A._id_A939;

  if(var_0 || var_1) {
    var_2 = _id_286C("enemy", 0);
    var_3 = [];
    var_4 = distancesquared(self.origin, self._id_A92A._id_EEAD.origin);

    for(var_5 = 0; var_5 < var_2.size; var_5++) {
      var_6 = _id_286B(var_2[var_5]);
      var_3[var_5] = distancesquared(self._id_A92A._id_EEAD.origin, var_6);
    }

    if(var_0) {
      if(!_id_270A() && var_4 < level._id_A930 * level._id_A930) {
        return "none";
      }

      for(var_5 = 0; var_5 < var_2.size; var_5++) {
        if(var_3[var_5] < _func_0219(level._id_A930)) {
          self._id_8F37 = var_2[var_5];
          self._id_8F38 = gettime();
          return "large";
        }
      }
    }

    if(var_1) {
      if(!_id_270A() && var_4 < level._id_A938 * level._id_A938) {
        return "none";
      }

      for(var_5 = 0; var_5 < var_2.size; var_5++) {
        if(var_3[var_5] < _func_0219(level._id_A938)) {
          if(isDefined(self._id_8F37) && self._id_8F37 == var_2[var_5] && gettime() - self._id_8F38 < 5000) {
            continue;
          }
          return "small";
        }
      }
    }
  }

  return "none";
}

_id_2745() {
  _id_2743("odin_support");
}

_id_A93C() {
  if(_id_2876()) {
    return 1;
  }

  if(_id_2872()) {
    return 1;
  }

  if(_id_2875()) {
    return 1;
  }

  if(_id_2873()) {
    return 1;
  }

  return 0;
}

_id_2873() {
  if(_id_286F()) {
    self notify("marking_action");
    return 1;
  }

  return 0;
}

_id_286F() {
  if(gettime() < self._id_A92A._id_A935) {
    return 0;
  }

  var_0 = _id_286C("enemy", 0);
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = _id_286B(var_0[var_2]);
    var_1[var_2] = distancesquared(self._id_A92A._id_EEAD.origin, var_3);

    if(var_1[var_2] < _func_0219(level._id_A92E / 2)) {
      return 1;
    }
  }

  return 0;
}

_id_2875() {
  if(_id_286E()) {
    self notify("smoke_action");
    return 1;
  }

  return 0;
}

_id_286E() {
  if(gettime() < self._id_A92A._id_A93A) {
    return 0;
  }

  var_0 = _id_2869();

  foreach(var_2 in var_0) {
    if(distancesquared(var_2, self._id_A92A._id_EEAD.origin) < 2500) {
      return 1;
    }
  }

  var_4 = undefined;

  if(isDefined(self._id_A92A._id_EEAD._id_A3F8)) {
    var_4 = _func_00B8(self._id_A92A._id_EEAD._id_A3F8);
  }

  if(!isDefined(var_4)) {
    return 0;
  }

  var_5 = _id_281D(1);
  var_6 = var_5[var_4].size;

  if(var_6 >= 2) {
    return 1;
  }

  return 0;
}

_id_2869() {
  var_0 = [];

  if(gettime() < self._id_A92A._id_A93A) {
    return var_0;
  }

  foreach(var_2 in level._id_326E) {
    if(scripts\mp\bots\bots::_id_3E79(var_2)) {
      var_3[0] = self;
      var_4 = scripts\engine\utility::_id_6369(var_2.origin, level.players, var_3);

      if(var_4.size > 0 && var_4[0].team == self.team) {
        var_0 = scripts\engine\utility::array_add(var_0, var_2.origin);
      }
    }
  }

  var_6 = _id_286C("ally", 0);

  foreach(var_8 in var_6) {
    if(isai(var_8) && var_8 scripts\mp\bots\bots_util::_id_2801()) {
      var_0 = scripts\engine\utility::array_add(var_0, var_8.origin);
    }
  }

  return var_0;
}

_id_A93B() {
  var_0 = _id_2869();

  if(var_0.size > 0) {
    return var_0[0];
  }

  return _id_2868("enemy", 1);
}

_id_A0D9() {
  for(;;) {
    self._id_A92A._id_EEAD._id_A3F8 = _func_0080(self._id_A92A._id_EEAD.origin);

    if(scripts\mp\bots\bots_util::_id_2891(self._id_A92A._id_EEAD.origin, 200)) {
      self._id_A92A._id_EEAD._id_A3FB = self._id_A92A._id_EEAD.origin;
    } else {
      self._id_A92A._id_EEAD._id_A3FB = undefined;
    }

    wait 0.25;
  }
}

_id_2743(var_0) {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  var_1 = _id_291E(var_0);

  if(!var_1) {
    self notify("control_func_done");
  }

  self._id_10020 = self._id_A92A;
  childthread _id_2784(self._id_A92A);
  self._id_A92A endon("death");
  wait 1.4;
  self _meth_8051(0.7);
  thread _id_2786();
  self._id_A936 = [];
  self._id_A937 = [];
  self._id_A932 = 0;
  var_2 = undefined;
  var_3 = 0;
  var_4 = undefined;
  childthread _id_A0D9();
  var_5 = self._id_A92A._id_EEAD.origin;
  var_6 = gettime();

  while(self[[level._id_282B["isUsing"][var_0]]]()) {
    var_7 = self[[level._id_282B["odin_perform_action"][var_0]]]();

    if(gettime() > var_6 + 2000) {
      var_6 = gettime();
      var_8 = distance(var_5, self._id_A92A._id_EEAD.origin);
      var_5 = self._id_A92A._id_EEAD.origin;

      if(var_8 < 100) {
        var_4 = undefined;
        var_2 = undefined;
      }
    }

    if(gettime() > var_3 || !isDefined(var_4)) {
      var_9 = level._id_2871[self _meth_802F()];
      var_3 = gettime() + var_9 * 1000;
      var_10 = self[[level._id_282B["odin_get_target"][var_0]]]();

      if(isDefined(var_10)) {
        var_2 = undefined;

        if(isPlayer(var_10)) {
          var_4 = _id_286B(var_10);
        } else {
          var_4 = var_10;
        }
      } else {
        if(!isDefined(var_2)) {
          var_2 = scripts\engine\utility::random(level._id_AD19);
        }

        var_11 = _func_00F6(var_2).origin;

        if(distance2dsquared(self._id_A92A._id_EEAD.origin, var_11) < 10000) {
          var_2 = scripts\engine\utility::random(level._id_AD19);
          var_11 = _func_00F6(var_2).origin;
          var_6 = gettime();
        }

        var_4 = var_11;
      }
    }

    var_12 = var_4 - self._id_A92A._id_EEAD.origin;

    if(_func_0135(var_12) > 100) {
      var_13 = vectortoangles(var_12);
      self _meth_805A(var_13[1], 0.05);
      self _meth_8045(var_4, 0.1, "script_forced");
    } else
      var_6 = gettime();

    wait 0.05;
  }

  self notify("control_func_done");
}

_id_2786(var_0) {
  self endon("disconnect");
  self waittill("control_func_done");
  self._id_A936 = undefined;
  self._id_A937 = undefined;
  self._id_A932 = undefined;
  self _meth_8051(1.0);
}

_id_286B(var_0) {
  if(level.teambased && self.team == var_0.team) {
    return var_0.origin;
  } else {
    if(length(var_0 _meth_8131()) < 25) {
      return var_0.origin;
    }

    var_1 = var_0 getentitynumber();

    if(!isDefined(self._id_A937[var_1])) {
      self._id_A937[var_1] = 0;
    }

    var_2 = gettime();
    var_3 = var_2 - self._id_A937[var_1];

    if(var_3 <= 400) {
      var_4 = vectornormalize(var_0 _meth_8131());
      var_5 = vectornormalize(self._id_A936[var_1] - var_0.origin);

      if(vectordot(var_4, var_5) < -0.5) {
        return var_0.origin;
      }
    }

    if(var_3 > 400) {
      if(var_2 == self._id_A932) {
        if(var_3 > 1000) {
          return var_0.origin;
        }
      } else {
        self._id_A936[var_1] = _func_00C7(var_0, 1.5);
        self._id_A937[var_1] = var_2;
        self._id_A932 = var_2;
      }
    }

    return self._id_A936[var_1];
  }
}

_id_2868(var_0, var_1, var_2) {
  var_3 = _id_286C(var_0, var_1);

  if(isDefined(var_2)) {
    var_3 = scripts\engine\utility::array_remove(var_3, var_2);
  }

  if(var_3.size > 0) {
    var_4 = scripts\engine\utility::_id_6369(self._id_A92A._id_EEAD.origin, var_3);
    return var_4[0];
  }

  return undefined;
}

_id_2876() {
  if(gettime() >= self._id_A92A._id_A92F) {
    if(!isDefined(self._id_A92A._id_EEAD._id_A3F8)) {
      return 0;
    }
  }

  return 0;
}

_id_2866() {
  return _id_2868("ally", 0);
}

_id_2872() {
  if(_id_286D()) {
    self notify("airdrop_action");
    self notify("juggernaut_action");
    return 1;
  }

  return 0;
}

_id_286D() {
  if(gettime() < self._id_A92A._id_A92B) {
    return 0;
  }

  if(!isDefined(self._id_A92A._id_EEAD._id_A3F8)) {
    return 0;
  }

  if(_id_286A() > 2) {
    return 0;
  }

  if(!isDefined(self._id_A92A._id_EEAD._id_A3FB)) {
    return 0;
  }

  var_0 = _func_00B8(self._id_A92A._id_EEAD._id_A3F8);

  if(!isDefined(var_0)) {
    return 0;
  }

  var_1 = _id_281C(1);
  var_2 = var_1[var_0].size;
  var_3 = _id_281D(1);
  var_4 = var_3[var_0].size;

  if(var_2 == 0) {
    return 0;
  }

  if(var_4 == 0) {
    var_5 = 0;
    var_6 = _id_286C("enemy", 1);

    foreach(var_8 in var_6) {
      if(distancesquared(var_8.origin, self._id_A92A._id_EEAD.origin) < 14400) {
        var_5 = 1;
      }
    }

    if(!var_5) {
      return 1;
    }
  }

  if(var_2 - var_4 >= 2) {
    var_10 = scripts\engine\utility::_id_6369(self._id_A92A._id_EEAD.origin, var_1[var_0]);
    var_11 = scripts\engine\utility::_id_6369(self._id_A92A._id_EEAD.origin, var_3[var_0]);
    var_12 = distance(self._id_A92A._id_EEAD.origin, var_10[0].origin);
    var_13 = distance(self._id_A92A._id_EEAD.origin, var_11[0].origin);

    if(var_12 + 120 < var_13) {
      return 1;
    }
  }

  return 0;
}

_id_286A() {
  var_0 = 0;

  foreach(var_2 in level._id_326E) {
    if(isDefined(var_2) && scripts\mp\bots\bots::_id_3E79(var_2)) {
      var_0++;
    }
  }

  return var_0;
}

_id_286C(var_0, var_1, var_2) {
  var_3 = _id_281B(self.team, var_0, var_1);
  var_4 = self _meth_8032();
  var_5 = [];

  foreach(var_7 in var_3) {
    var_8 = 0;
    var_9 = var_4;

    if(var_0 == "enemy") {
      var_9 = var_9 * 0.9;
    }

    if(scripts\engine\utility::_id_10E76(self._id_10020.origin, self getplayerangles(), var_7.origin, var_9)) {
      if(!var_8 || self _meth_8028(var_7)) {
        var_5 = scripts\engine\utility::array_add(var_5, var_7);
      }
    }
  }

  return var_5;
}

_id_8608() {
  return level.script == "mp_sovereign";
}

_id_270A() {
  return isDefined(self._id_59E0) && self._id_59E0;
}

_id_76FE(var_0, var_1) {
  var_2 = undefined;
  var_3 = 0;

  foreach(var_5 in var_0) {
    var_6 = distancesquared(level._id_284C, [[level._id_282B["heli_node_get_origin"][var_1]]](var_5));

    if(var_6 > var_3) {
      var_3 = var_6;
      var_2 = var_5;
    }
  }

  if(isDefined(var_2)) {
    return var_2;
  } else {
    return scripts\engine\utility::random(var_0);
  }
}

_id_76C6(var_0) {
  return var_0.origin;
}

_id_5ABB(var_0, var_1) {
  var_2 = undefined;
  var_3 = 99999999;

  foreach(var_5 in level._id_27F0) {
    var_6 = distance2dsquared(var_0, [[level._id_282B["heli_node_get_origin"][var_1]]](var_5));

    if(var_6 < var_3) {
      var_2 = var_5;
      var_3 = var_6;
    }
  }

  return var_2;
}

_id_281C(var_0) {
  var_1 = _id_2819(var_0);
  var_2 = [];

  for(var_3 = 0; var_3 < level._id_110E1; var_3++) {
    var_2[var_3] = [];
  }

  foreach(var_5 in var_1) {
    var_6 = var_5 _meth_815E();
    var_7 = _func_00B8(var_6);

    if(isDefined(var_7)) {
      var_2[var_7] = ::scripts\engine\utility::array_add(var_2[var_7], var_5);
    }
  }

  return var_2;
}

_id_281D(var_0) {
  var_1 = _id_281A(var_0);
  var_2 = [];

  for(var_3 = 0; var_3 < level._id_110E1; var_3++) {
    var_2[var_3] = [];
  }

  foreach(var_5 in var_1) {
    var_6 = var_5 _meth_815E();
    var_7 = _func_00B8(var_6);
    var_2[var_7] = ::scripts\engine\utility::array_add(var_2[var_7], var_5);
  }

  return var_2;
}

_id_281A(var_0) {
  return _id_281B(self.team, "enemy", var_0);
}

_id_2819(var_0) {
  return _id_281B(self.team, "ally", var_0);
}

_id_281B(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = level._id_AE7C;

  if(isDefined(var_2) && var_2) {
    var_4 = level.players;
  }

  foreach(var_6 in var_4) {
    if(var_6 == self || !isalive(var_6)) {
      continue;
    }
    var_7 = 0;

    if(var_1 == "ally") {
      var_7 = level.teambased && var_0 == var_6.team;
    } else if(var_1 == "enemy") {
      var_7 = !level.teambased || var_0 != var_6.team;
    }

    if(var_7) {
      var_8 = var_6 _meth_815E();

      if(isDefined(var_8) && _func_0157(var_8)) {
        var_3 = scripts\engine\utility::array_add(var_3, var_6);
      }
    }
  }

  var_3 = scripts\engine\utility::array_remove(var_3, self);
  return var_3;
}

_id_27EF(var_0) {
  var_1 = 99;
  var_2 = [];

  foreach(var_4 in var_0._id_A421) {
    if(isDefined(var_4._id_0398)) {
      var_5 = var_4._id_2919[self._id_5501];

      if(var_5 < var_1) {
        var_2 = [];
        var_2[0] = var_4;
        var_1 = var_5;
      } else if(var_5 == var_1)
        var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_273F(var_0) {
  self endon("spawned_player");
  self endon("disconnect");
  self endon("control_func_done");
  level endon("game_ended");
  var_1 = _id_291E(var_0);

  if(!var_1) {
    self notify("control_func_done");
  }

  foreach(var_3 in level._id_9593) {
    if(var_3.owner == self) {
      self._id_10020 = var_3;
    }
  }

  childthread _id_2784(self._id_10020);
  self._id_10020 endon("death");

  if(isDefined(level._id_282B["control_other"][var_0])) {
    self childthread[[level._id_282B["control_other"][var_0]]]();
  }

  self[[level._id_282B["waittill_initial_goal"][var_0]]]();
  self childthread[[level._id_282B["control_aiming"][var_0]]]();
  _id_2740(var_0, 1);
  self notify("control_func_done");
}

_id_27C0(var_0) {
  if(var_0) {
    return _func_0219(100);
  } else {
    return _func_0219(30);
  }
}

_id_27C1(var_0) {
  if(var_0) {
    return _func_0219(300);
  } else {
    return _func_0219(90);
  }
}

_id_2740(var_0, var_1) {
  foreach(var_3 in level._id_27F0) {
    var_3._id_2919[self._id_5501] = 0;
  }

  var_5 = _id_5ABB(self._id_10020.origin, var_0);
  var_6 = undefined;
  self._id_A46D = 0;
  var_7 = "needs_new_goal";
  var_8 = undefined;
  var_9 = self._id_10020.origin;
  var_10 = 3.0;
  var_11 = 0.05;

  while(self[[level._id_282B["isUsing"][var_0]]]()) {
    if(gettime() > self._id_A46D && var_7 == "needs_new_goal") {
      var_12 = var_5;
      var_5 = [[level._id_282B["heli_pick_node"][var_0]]](var_5);
      var_6 = undefined;

      if(isDefined(var_5)) {
        var_13 = [[level._id_282B["heli_node_get_origin"][var_0]]](var_5);

        if(var_1) {
          var_14 = var_5.origin + (scripts\mp\utility\killstreak::_id_6A98() + level._id_27F1);
          var_15 = var_5.origin + (scripts\mp\utility\killstreak::_id_6A98() - level._id_27F1);
          var_16 = scripts\engine\trace::_bullet_trace(var_14, var_15, 0, undefined, 0, 0, 1);
          var_6 = var_16["position"] - scripts\mp\utility\killstreak::_id_6A98() + level._id_282C[var_0];
        } else
          var_6 = var_13;
      }

      if(isDefined(var_6)) {
        self _meth_8054("disable_movement", 0);
        var_7 = "waiting_till_goal";
        var_10 = 3.0;
        var_9 = self._id_10020.origin;
      } else {
        var_5 = var_12;
        self._id_A46D = gettime() + 2000;
      }
    } else if(var_7 == "waiting_till_goal") {
      if(!var_1) {
        var_17 = var_6[2] - self._id_10020.origin[2];

        if(var_17 > 10) {
          self _meth_804E("lethal");
        } else if(var_17 < -10) {
          self _meth_804E("tactical");
        }
      }

      var_18 = var_6 - self._id_10020.origin;

      if(var_1) {
        var_8 = _func_0134(var_18);
      } else {
        var_8 = _func_0135(var_18);
      }

      if(var_8 < _id_27C0(var_1)) {
        self _meth_805A(0, 0);
        self _meth_8054("disable_movement", 1);

        if(self _meth_802F() == "recruit") {
          self._id_A46D = gettime() + randomintrange(5000, 7000);
        } else {
          self._id_A46D = gettime() + randomintrange(3000, 5000);
        }

        var_7 = "needs_new_goal";
      } else {
        var_18 = var_6 - self._id_10020.origin;
        var_19 = vectortoangles(var_18);
        var_20 = scripts\engine\utility::ter_op(var_8 < _id_27C1(var_1), 0.5, 1.0);
        self _meth_805A(var_19[1], var_11, var_20);
        var_10 = var_10 - var_11;

        if(var_10 <= 0.0) {
          if(distancesquared(self._id_10020.origin, var_9) < 225) {
            var_5._id_2919[self._id_5501]++;
            var_7 = "needs_new_goal";
          }

          var_9 = self._id_10020.origin;
          var_10 = 3.0;
        }
      }
    }

    wait(var_11);
  }
}

_id_66DB() {
  var_0 = [];

  foreach(var_2 in level._id_AD19) {
    var_3 = _func_0029(var_2, self.team, "enemy_predict");

    if(var_3 > 0) {
      var_0 = scripts\engine\utility::array_add(var_0, var_2);
    }
  }

  var_5 = undefined;

  if(var_0.size > 0) {
    var_6 = scripts\engine\utility::random(var_0);
    var_7 = scripts\engine\utility::random(_func_00F7(var_6));
    var_5 = var_7.origin;
  } else {
    var_8 = undefined;
    var_9 = undefined;

    if(isDefined(level._id_F039)) {
      var_8 = [[level._id_F039]]();
    } else {
      var_9 = _func_03F2();
    }

    var_10 = 0;

    while(var_10 < 10) {
      var_10++;
      var_11 = undefined;

      if(isDefined(var_8)) {
        var_11 = scripts\engine\utility::random(var_8);
      } else {
        var_11 = _func_03E0(randomint(var_9));
      }

      if(isDefined(var_11)) {
        var_5 = var_11.origin;

        if(_func_0157(var_11) && distance2dsquared(var_11.origin, self._id_10020.origin) > 62500) {
          break;
        }
      }
    }
  }

  return var_5;
}