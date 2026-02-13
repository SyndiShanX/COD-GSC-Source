/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1771.gsc
*************************************************/

_id_70E1(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self;
  }

  var_0 endon("death");

  if(isDefined(var_0._id_75B8)) {
    return;
  } else {
    var_0._id_75B8 = 1;
  }

  var_0 scripts\engine\utility::_id_0393();
  var_0 notify("start_vehiclepath");

  if(var_0 _id_06E9::_id_8897()) {
    var_0 notify("start_dynamicpath");
  } else {
    var_0 _meth_83DC();
  }
}

_id_0DBD(var_0, var_1, var_2) {
  if(_id_06E9::_id_8897()) {
    _id_1022D(var_0, var_1, var_2);
  } else {
    _id_1022E(var_0);
  }
}

_id_F5E9(var_0) {
  if(isDefined(var_0._id_CD49)) {
    scripts\engine\utility::_id_5C1B(var_0._id_CD49);
  }

  if(isDefined(var_0._id_CD46)) {
    scripts\engine\utility::_id_5C04(var_0._id_CD46);
  }

  if(isDefined(var_0._id_CE28)) {
    var_0._id_0397 = var_0._id_CE28;
    var_0._id_CE28 = undefined;
  }

  if(isDefined(var_0._id_0397)) {
    var_1 = var_0._id_CD34;

    if(isDefined(var_1)) {
      level scripts\engine\utility::delaythread(var_1, scripts\engine\utility::_id_57BA, var_0._id_0397);
    } else {
      level scripts\engine\utility::_id_57BA(var_0._id_0397);
    }
  }

  if(isDefined(var_0._id_CD49)) {
    scripts\engine\utility::_id_5C1B(var_0._id_CD49);
  }

  if(isDefined(var_0._id_CD30)) {
    scripts\engine\utility::_id_5474(var_0._id_CD30);
  }

  if(isDefined(var_0._id_CD2F)) {
    scripts\engine\utility::_id_5470(var_0._id_CD2F);
  }

  if(isDefined(var_0._id_CD46)) {
    scripts\engine\utility::_id_5C04(var_0._id_CD46);
  }

  if(isDefined(var_0._id_039B)) {
    if(var_0._id_039B == "deleteme") {
      _id_06E9::_id_10085();
      _id_4742();
      self delete();
      return;
    } else if(var_0._id_039B == "engineoff")
      self _meth_843A();
    else {
      self notify(var_0._id_039B);
      self notify("noteworthy", var_0._id_039B);
    }
  }

  if(isDefined(var_0._id_CCBB)) {
    self._id_CCBB = var_0._id_CCBB;
  }

  var_0 _id_06E9::_id_73FB(self, 1);
  var_0 _id_06E9::_id_73FA(self, 1);
}

_id_4742() {
  if(isDefined(self._id_C835)) {
    foreach(var_1 in self._id_C835) {
      if(isDefined(var_1._id_992D)) {
        var_1 _id_06C5::_id_E8B9();
      }

      if(!scripts\common\utility::issp() && isai(var_1)) {
        var_1 _meth_81FA();
        continue;
      }

      var_1 delete();
    }
  }
}

_id_8900(var_0) {
  if(!isDefined(var_0.target)) {
    return 1;
  }

  if(!isDefined(_func_00E5(var_0.target, "targetname")) && !isDefined(_id_06E9::_id_681C(var_0.target))) {
    return 1;
  }

  return 0;
}

_id_10259(var_0, var_1) {
  if(isDefined(var_1._id_CEA5)) {
    return 1;
  }

  if(var_0 != ::_id_A564) {
    return 0;
  }

  if(!_id_8900(var_1)) {
    return 0;
  }

  if(istrue(self._id_4DB8)) {
    return 0;
  }

  if(self._id_04DE == "empty" || self._id_04DE == "empty_heli") {
    return 0;
  }

  return !(isDefined(self._id_CEAE) && self._id_CEAE);
}

_id_AD6E(var_0) {}

_id_10249() {
  if(!_id_06E9::_id_8897()) {
    self _meth_829C(35);
    return;
  }

  var_0 = undefined;

  if(isDefined(self._id_41D8.target)) {
    var_0 = _id_06E9::_id_681C(self._id_41D8.target);
  }

  if(!isDefined(var_0)) {
    return;
  }
  _id_0DBD(var_0);
}

_id_6645(var_0) {
  var_1 = _id_06E9::_id_64B8;

  if(_id_06E9::_id_8897() && isDefined(var_0.target)) {
    if(isDefined(_id_06E9::_id_64B6(var_0.target))) {
      var_1 = _id_06E9::_id_64B6;
    }

    if(isDefined(_id_06E9::_id_64B7(var_0.target))) {
      var_1 = _id_06E9::_id_64B7;
    }
  } else if(!scripts\common\utility::issp() && isDefined(var_0.target)) {
    if(isDefined(_id_06E9::_id_64B7(var_0.target))) {
      var_1 = _id_06E9::_id_64B7;
    }
  }

  return var_1;
}

_id_EA7C(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = var_0;
  }

  wait 0.05;

  if(isDefined(var_1.speed) && var_1.speed >= 0) {
    self _meth_8440(var_0.origin, int(var_1.speed));

    while(distancesquared(self.origin, var_0.origin) > var_2) {
      wait 0.1;

      if(scripts\common\utility::iscp()) {
        self _meth_8438(var_1.speed, 15, 15);
      }
    }
  } else if(isDefined(var_1.speed) && var_1.speed < 0)
    self _meth_8438(0, 15, 15);
}

_id_A564(var_0, var_1, var_2) {
  if(isDefined(self._id_F94F)) {
    var_3 = "node_flag_triggered" + self._id_F94F;
  } else {
    var_3 = "node_flag_triggered";
  }

  _id_A579(var_3, var_0, var_2);

  if(self._id_1D83 == var_0) {
    self notify("node_wait_terminated");
    waittillframeend;
    return;
  }

  var_0 scripts\engine\utility::_id_547A(var_3);
  var_0 scripts\engine\utility::_id_5470(var_3, 1);
  var_0 notify("processed_node" + var_3);
}

_id_A579(var_0, var_1, var_2) {
  for(var_3 = 0; isDefined(var_1) && var_3 < 3; var_1 = [[var_2]](var_1.target)) {
    var_3++;
    thread _id_A55A(var_0, var_1);

    if(!isDefined(var_1.target)) {
      return;
    }
  }
}

_id_A55A(var_0, var_1) {
  if(var_1 scripts\engine\utility::_id_5472(var_0)) {
    return;
  }
  var_1 scripts\engine\utility::_id_5473(var_0);
  thread _id_A55B(var_1, var_0);
  var_1 endon("processed_node" + var_0);
  self endon("death");
  self endon("newpath");
  self endon("node_wait_terminated");
  var_1 waittillmatch("trigger", self);
  var_1 scripts\engine\utility::_id_5474(var_0);
}

_id_A55B(var_0, var_1) {
  var_0 endon("processed_node" + var_1);
  scripts\engine\utility::waittill_any_3("death", "newpath", "node_wait_terminated");
  var_0 scripts\engine\utility::_id_5470(var_1, 1);
}

_id_1022E(var_0) {
  self notify("newpath");

  if(isDefined(var_0)) {
    self._id_1D83 = var_0;
  }

  var_1 = self._id_1D83;
  self._id_41D8 = self._id_1D83;

  if(!isDefined(var_1)) {
    return;
  }
  self endon("newpath");
  self endon("death");
  var_2 = var_1;
  var_3 = undefined;
  var_4 = var_1;
  var_5 = _id_6645(var_1);
  var_6 = 40000;

  while(isDefined(var_4)) {
    if(!_func_02DE(var_4)) {
      _id_A564(var_4, var_3, var_5);
    } else {
      _id_EA7C(var_4, var_3, var_6);
    }

    if(!isDefined(self)) {
      return;
    }
    _id_F5E9(var_4);
    self._id_41D8 = var_4;

    if(!isDefined(self)) {
      return;
    }
    if(isDefined(var_4._id_CE7D)) {
      self._id_CE7D = var_4._id_CE7D;
    }

    if(isDefined(var_4._id_CE97)) {
      self notify("turning", var_4._id_CE97);
    }

    if(isDefined(var_4._id_CCF4)) {
      if(var_4._id_CCF4 == 0) {
        thread _id_06E9::_id_43FB();
      } else {
        thread _id_06E9::_id_43FC();
      }
    }

    if(isDefined(var_4._id_CEC1)) {
      _id_06E9::_id_10257(var_4._id_CEC1);
    }

    if(_id_10259(::_id_A564, var_4)) {
      thread _id_F973(var_4);
    }

    if(isDefined(var_4._id_CE92)) {
      self._id_04DB = var_4._id_CE92;

      if(self._id_04DB == "forward") {
        _id_06E9::_id_10257(1);
      } else {
        _id_06E9::_id_10257(0);
      }
    }

    if(isDefined(var_4._id_CCC9)) {
      self._id_04CE = var_4._id_CCC9;
    }

    if(isDefined(var_4._id_CE19)) {
      self._id_04D6 = var_4._id_CE19;
    }

    if(isDefined(var_4._id_CE57)) {
      var_7 = undefined;

      if(isDefined(var_4._id_CC89)) {
        var_7 = var_4._id_CC89;
      }

      var_8 = undefined;

      if(isDefined(var_4._id_CCF6)) {
        var_8 = var_4._id_CCF6;
      }

      self vehicle_setspeed(var_4._id_CE57, var_7, var_8);
    }

    if(isDefined(var_4._id_CD31) && !scripts\engine\utility::_id_546E(var_4._id_CD31)) {
      if(isDefined(var_4._id_CCF6)) {
        var_8 = var_4._id_CCF6;
      } else if(isDefined(var_4.target)) {
        var_9 = [[var_5]](var_4.target);
        var_10 = distance(var_4.origin, var_9.origin) * 0.0568182;
        var_11 = self _meth_842E();
        var_8 = _func_0219(var_11) / (2 * var_10);
      } else
        var_8 = 20;

      self vehicle_setspeed(0, var_8, var_8);
      childthread _id_1015A();
      scripts\engine\utility::_id_5476(var_4._id_CD31);

      if(!isDefined(self)) {
        return;
      }
      var_7 = 60;

      if(isDefined(var_4._id_CC89)) {
        var_7 = var_4._id_CC89;
      }

      self notify("resumed_path");
      self _meth_829C(var_7);
    }

    if(isDefined(var_4._id_0393)) {
      var_8 = 20;

      if(isDefined(var_4._id_CCF6)) {
        var_8 = var_4._id_CCF6;
      }

      self vehicle_setspeed(0, var_8);
      childthread _id_1015A();

      if(isDefined(var_4.target)) {
        childthread _id_AD6E([[var_5]](var_4.target));
      }

      var_4 scripts\engine\utility::_id_0393();
      self notify("delay_passed");
      var_7 = 60;

      if(isDefined(var_4._id_CC89)) {
        var_7 = var_4._id_CC89;
      }

      self notify("resumed_path");
      self _meth_829C(var_7);
    }

    if(isDefined(var_4._id_CD4B)) {
      var_12 = 0;

      if(!scripts\engine\utility::_id_5C00(var_4._id_CD4B) || isDefined(var_4._id_CCFF)) {
        var_12 = 1;
        var_7 = 5;
        var_8 = 20;

        if(isDefined(var_4._id_CC89)) {
          var_7 = var_4._id_CC89;
        }

        if(isDefined(var_4._id_CCF6)) {
          var_8 = var_4._id_CCF6;
        }

        _id_0DBF("script_flag_wait_" + var_4._id_CD4B, var_7, var_8);
        childthread _id_1015A();

        if(isDefined(var_4.target)) {
          childthread _id_AD6E([[var_5]](var_4.target));
        }
      }

      scripts\engine\utility::_id_5C24(var_4._id_CD4B);

      if(!isDefined(self)) {
        return;
      }
      if(isDefined(var_4._id_CCFF)) {
        wait(var_4._id_CCFF);

        if(!isDefined(self)) {
          return;
        }
      }

      var_7 = 10;

      if(isDefined(var_4._id_CC89)) {
        var_7 = var_4._id_CC89;
      }

      if(var_12) {
        self notify("resumed_path");
        _id_0DBE("script_flag_wait_" + var_4._id_CD4B);
      }

      self notify("delay_passed");
    }

    if(isDefined(self._id_D281)) {
      self._id_D281 = undefined;
      self _meth_807E();
    }

    if(isDefined(var_4._id_CEAC)) {
      thread _id_06EA::_id_949F(var_4._id_CEAC);
    }

    if(isDefined(var_4._id_CEAD)) {
      thread _id_06EA::_id_94A3(var_4._id_CEAD);
    }

    if(isDefined(var_4._id_CD53)) {
      thread scripts\engine\utility::_id_CD61("forcecolor_riders", var_4._id_CD53);
    }

    var_3 = var_4;

    if(!isDefined(var_4.target)) {
      break;
    }

    var_4 = [[var_5]](var_4.target);

    if(!isDefined(var_4)) {
      var_4 = var_3;
      break;
    }
  }

  self notify("reached_dynamic_path_end");

  if(isDefined(self._id_CEAE)) {
    _id_06E9::_id_10085();
    _id_4742();
    self notify("delete");
    self delete();
  }
}

_id_1015A() {
  self endon("resumed_path");

  while(_id_06E9::_id_1011C()) {
    waitframe();
  }

  self _meth_83B0(0);
  self waittill("reached_wait_speed");
  self notify("stopped_path");
}

_id_102E0() {
  while(!_id_06E9::_id_1011C()) {
    waitframe();
  }
}

_id_1082(var_0, var_1) {
  return (var_0[0], var_0[1], var_0[2] + var_1);
}

_id_1022D(var_0, var_1, var_2) {
  self notify("newpath");
  self endon("newpath");
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  if(isDefined(var_0)) {
    self._id_1D83 = var_0;
  }

  var_3 = self._id_1D83;
  self._id_41D8 = self._id_1D83;

  if(!isDefined(var_3)) {
    return;
  }
  var_4 = var_3;

  if(var_1) {
    self waittill("start_dynamicpath");
  }

  if(isDefined(var_2)) {
    var_5 = spawnStruct();
    var_5.origin = _id_1082(self.origin, var_2);
    _id_775D(var_5, undefined);
  }

  var_6 = undefined;
  var_7 = var_3;
  var_8 = _id_6645(var_3);

  while(isDefined(var_7)) {
    if(isDefined(var_7._id_0399)) {
      _id_06E9::_id_D280(var_7);
    }

    if(isDefined(var_7._id_CD9A)) {
      var_9 = 0;

      if(isDefined(var_7.target)) {
        var_9 = isDefined([[var_8]](var_7.target));
      }

      thread _id_06E9::_id_1012E(var_7._id_CEA5, var_9);
    }

    _id_775D(var_7, var_6, var_2);

    if(!isDefined(self)) {
      return;
    }
    self._id_41D8 = var_7;
    var_7 notify("trigger", self);

    if(isDefined(var_7._id_CD81)) {
      self _meth_83BC(var_7._id_CD81);

      if(var_7._id_CD81 == "faster") {
        self setmaxpitchroll(25, 50);
      }
    }

    _id_F5E9(var_7);

    if(!isDefined(self)) {
      return;
    }
    if(isDefined(var_7._id_CE7D)) {
      self._id_CE7D = var_7._id_CE7D;
    }

    if(_id_10259(::_id_775D, var_7)) {
      thread _id_F973(var_7);
    }

    if(self _meth_8434()) {
      if(isDefined(var_7._id_CE19)) {
        self._id_04D6 = var_7._id_CE19;
      }
    }

    if(isDefined(var_7._id_CD4B)) {
      scripts\engine\utility::_id_5C24(var_7._id_CD4B);

      if(isDefined(var_7._id_CCFF)) {
        wait(var_7._id_CCFF);
      }

      self notify("delay_passed");
    }

    if(isDefined(self._id_D281)) {
      self._id_D281 = undefined;
      self _meth_807E();
    }

    if(isDefined(var_7._id_CEAC)) {
      thread _id_06EA::_id_949F(var_7._id_CEAC);
    }

    if(isDefined(var_7._id_CEAD)) {
      thread _id_06EA::_id_94A3(var_7._id_CEAD);
    }

    if(isDefined(var_7._id_CD53)) {
      thread scripts\engine\utility::_id_CD61("forcecolor_riders", var_7._id_CD53);
    }

    var_6 = var_7;

    if(!isDefined(var_7.target)) {
      break;
    }

    var_7 = [[var_8]](var_7.target);

    if(!isDefined(var_7)) {
      var_7 = var_6;
      break;
    }
  }

  self notify("reached_dynamic_path_end");

  if(isDefined(self._id_CEAE)) {
    _id_4742();
    self delete();
  }
}

_id_775D(var_0, var_1, var_2) {
  self endon("newpath");

  if(isDefined(var_0._id_CEA5) || isDefined(var_0._id_CD9A)) {
    var_3 = 0;

    if(isDefined(var_0._id_CD9A)) {
      scripts\engine\utility::_id_5474("landed");

      if(isDefined(self._id_F970)) {
        var_3 = self._id_F970;
      }
    } else if(isDefined(var_0._id_CEA5) && isDefined(self._id_F96E))
      var_3 = self._id_F96E;
    else if(isDefined(var_0._id_CEA5) && isDefined(self._id_F96F)) {
      var_4 = scripts\common\utility::groundpos(var_0.origin);
      var_3 = var_0.origin[2] - var_4[2];

      if(var_3 >= self._id_F96F) {
        var_3 = self._id_F96F;
      } else if(isDefined(self._id_F96D) && var_3 < self._id_F96D) {
        var_3 = self._id_F96D;
      }
    }

    var_0._id_0359 = 2;

    if(isDefined(var_0._id_71A9)) {
      var_0.origin = var_0._id_71A9 + (0, 0, var_3);
    } else {
      var_5 = scripts\common\utility::groundpos(var_0.origin) + (0, 0, var_3);

      if(var_5[2] > var_0.origin[2] - 2000) {
        var_0.origin = scripts\common\utility::groundpos(var_0.origin) + (0, 0, var_3);
      }
    }

    self sethoverparams(0, 0, 0);
  }

  if(isDefined(var_1)) {
    var_6 = var_1._id_CC8F;
    var_7 = var_1.speed;
    var_8 = var_1._id_CC89;
    var_9 = var_1._id_CCF6;
  } else {
    var_6 = undefined;
    var_7 = undefined;
    var_8 = undefined;
    var_9 = undefined;
  }

  var_10 = isDefined(var_0._id_CE6F) && var_0._id_CE6F;
  var_11 = isDefined(var_0._id_CEA5);
  var_12 = isDefined(var_0._id_CD4B) && !scripts\engine\utility::_id_5C00(var_0._id_CD4B);
  var_13 = !isDefined(var_0.target);
  var_14 = isDefined(var_0._id_0393);

  if(isDefined(var_0.angles)) {
    var_15 = var_0.angles[1];
  } else {
    var_15 = 0;
  }

  if(self.health <= 0) {
    return;
  }
  var_16 = var_0.origin;

  if(isDefined(var_2)) {
    var_16 = _id_1082(var_16, var_2);
  }

  if(isDefined(self._id_77BE)) {
    var_16 = (var_16[0], var_16[1], self._id_77BE);
  }

  self _meth_8433(var_16, var_7, var_8, var_9, var_0._id_CD77, var_0._id_CC9C, var_15, var_6, var_14, var_10, var_11, var_12, var_13);

  if(isDefined(var_0._id_0359)) {
    self setneargoalnotifydist(var_0._id_0359);
    scripts\engine\utility::waittill_any_2("near_goal", "goal");
  } else
    self waittill("goal");

  _id_F5E9(var_0);

  if(isDefined(var_0._id_CD42)) {
    if(!isDefined(level._id_7785)) {}

    thread[[level._id_7785]](var_0);
  }

  var_0 scripts\engine\utility::_id_0393();

  if(isDefined(self._id_AEC9)) {
    scripts\engine\utility::_id_4794(var_0);
  }

  self notify("continuepath");
}

_id_664A() {
  var_0 = scripts\engine\utility::getstructarray(self.target, "targetname");

  if(var_0.size == 1) {
    return var_0[0];
  }

  var_1 = [];

  foreach(var_3 in var_0) {
    if(!isDefined(var_3._id_CD03)) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1[0];
}

_id_6BCF(var_0) {
  var_1 = undefined;
  var_2 = self._id_04DE;

  if(isDefined(self._id_10295)) {
    if(istrue(self._id_10295._id_4DA2)) {
      return;
    }
  }

  if(isDefined(self.target)) {
    var_1 = _func_00E5(self.target, "targetname");

    if(!isDefined(var_1)) {
      var_3 = getEntArray(self.target, "targetname");

      foreach(var_5 in var_3) {
        if(var_5._id_00EC == "script_origin") {
          var_1 = var_5;
          break;
        }
      }
    }

    if(!isDefined(var_1)) {
      if(scripts\common\utility::iscp()) {
        var_1 = _id_664A();
      } else {
        var_1 = scripts\engine\utility::getstruct(self.target, "targetname");
      }
    }
  }

  if(!isDefined(var_1)) {
    if(_id_06E9::_id_8897()) {
      self vehicle_setspeed(60, 20, 10);
    }

    return;
  }

  self._id_1D83 = var_1;

  if(!_id_06E9::_id_8897() && !_func_02DE(var_1)) {
    self.origin = var_1.origin;

    if(!isDefined(var_0)) {
      self _meth_8020(var_1);
    }
  } else if(isDefined(self.speed))
    self _meth_8438(self.speed, 20);
  else if(isDefined(var_1.speed)) {
    var_7 = 20;
    var_8 = 10;

    if(isDefined(var_1._id_CC89)) {
      var_7 = var_1._id_CC89;
    }

    if(isDefined(var_1._id_CCF6)) {
      var_7 = var_1._id_CCF6;
    }

    var_9 = float(var_1.speed);
    self _meth_8438(var_9, var_7, var_8);
  } else
    self vehicle_setspeed(60, 20, 10);

  thread _id_0DBD(undefined, _id_06E9::_id_8897());
}

_id_0DBE(var_0) {
  var_1 = self._id_102A2[var_0];
  self._id_102A2[var_0] = undefined;

  if(self._id_102A2.size) {
    return;
  }
  self _meth_829C(var_1);
}

_id_0DBF(var_0, var_1, var_2) {
  if(!isDefined(self._id_102A2)) {
    self._id_102A2 = [];
  }

  if(isDefined(var_1) && isDefined(var_2)) {
    self vehicle_setspeed(0, var_1, var_2);
  } else if(isDefined(var_1)) {
    self vehicle_setspeed(0, var_1);
  } else {
    self vehicle_setspeed(0);
  }

  if(isDefined(var_1)) {
    self._id_102A2[var_0] = var_1;
  } else {
    self._id_102A2[var_0] = 20;
  }
}

_vehicle_has_stop_named(var_0) {
  return isDefined(self._id_102A2) && isDefined(self._id_102A2[var_0]);
}

_id_F973(var_0) {
  self endon("death");

  if(isDefined(self._id_546E["prep_unload"]) && scripts\engine\utility::_id_546E("prep_unload")) {
    return;
  }
  if(!isDefined(var_0._id_CD4B) && !isDefined(var_0._id_0393)) {
    self notify("newpath");
  }

  var_1 = _func_00B2(var_0._id_0481, "target");

  if(isDefined(var_1) && self._id_C835.size) {
    foreach(var_3 in self._id_C835) {
      if(isai(var_3)) {
        var_3 thread scripts\engine\utility::_id_CD61("go_to_node", var_1);
      }
    }
  }

  if(_id_06E9::_id_8897()) {
    self sethoverparams(0, 0, 0);
    _id_06E9::_id_10926(var_0);
  }

  if(isDefined(var_0._id_039B)) {
    if(var_0._id_039B == "wait_for_flag") {
      scripts\engine\utility::_id_5C24(var_0._id_CD45);
    }
  }

  if(isDefined(var_0._id_CEA5)) {
    if(var_0._id_CEA5 == "1") {
      var_0._id_CEA5 = "default";
    }
  }

  _id_06E9::_id_0DC0(var_0._id_CEA5);

  if(_id_06E7::_id_C836(var_0._id_CEA5)) {
    self waittill("unloaded");
  }

  if(isDefined(var_0._id_CD4B) || isDefined(var_0._id_0393)) {
    return;
  }
  if(isDefined(self)) {
    thread _id_10249();
  }
}