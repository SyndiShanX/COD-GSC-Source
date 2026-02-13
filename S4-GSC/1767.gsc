/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1767.gsc
*************************************************/

_id_732A(var_0, var_1) {
  var_0 endon("death_or_disconnect");

  if(!isDefined(self) || !isalive(self)) {
    return;
  }
  if(!isDefined(self._id_04DE)) {
    return;
  }
  var_2 = _id_06E9::_id_6810();
  var_3 = level.vehicle._id_F078._id_1306[var_2];
  self._id_1D81[self._id_1D81.size] = var_0;

  if(isDefined(var_0._id_0B67._id_4206) && isDefined(var_0._id_0B67._id_36F2)) {
    var_4 = var_0._id_0B67._id_36F2._id_10238;
  } else {
    var_4 = _id_D35B(var_0, var_3);
  }

  if(!isDefined(var_4)) {
    return;
  }
  if(var_4 == 0) {
    var_0._id_4F6E = 1;
  }

  var_5 = _id_1801(self, var_4);
  self._id_FE56[var_4] = 1;
  var_0._id_10238 = var_4;
  var_0._id_100DC = 0;

  if(isDefined(var_5._id_4649)) {
    var_0._id_4649 = var_5._id_4649;

    if(isDefined(var_5._id_46CD)) {
      self._id_46C8 = var_0._id_4649;
    }
  }

  if(isDefined(var_5._id_46CD)) {
    self._id_46C8 = self._id_46C8 + var_5._id_46CD;
    var_0._id_4649 = self._id_46C8;
  }

  var_0._id_C83B = self;
  var_0._id_AC68 = var_0.health;
  var_0._id_100DA = var_5._id_7CA9;
  var_0._id_1029F = var_5._id_E588;

  if(!getdvarint("#x32923f011fc14a85b")) {
    var_0._id_43D3 = var_5._id_0153;
    var_0._id_43D9 = var_5._id_4400;
  }

  var_0._id_E58A = 0;
  var_0._id_0040 = 1;
  thread _id_7400(var_0, var_5);

  if(getdvarint("#x32923f011fc14a85b")) {
    if(isDefined(var_0._id_43D3) && !isDefined(var_0._id_992D) && _id_FFFD()) {
      if(var_0._id_10238 != 0 || _id_FFFC()) {
        var_0._id_0040 = !isDefined(var_0._id_CC93) || var_0._id_CC93;

        if(istrue(var_5._id_43C7)) {
          var_0._id_A5BA = var_5._id_43C7;
        }
      }
    }
  } else if(!isDefined(var_0._id_992D) && _id_FFFD()) {
    var_0._id_0040 = !isDefined(var_0._id_CC93) || var_0._id_CC93;

    if(istrue(var_5._id_43C7)) {
      var_0._id_A5BA = var_5._id_43C7;
    }
  }

  if(!isDefined(var_0.classname)) {
    return;
  }
  if(var_0.classname == "script_model") {
    if(isDefined(var_5._id_0153) && var_0._id_0040 && (!isDefined(var_0._id_CC93) || var_0._id_CC93)) {
      thread _id_7327(var_0, var_5);
    }
  }

  self._id_C835[self._id_C835.size] = var_0;

  if(var_0.classname != "script_model" && _id_06C5::_id_E137(var_0)) {
    return;
  }
  var_6 = self gettagorigin(var_5._id_DD6C);
  var_7 = self gettagangles(var_5._id_DD6C);

  if(!getdvarint("#x32923f011fc14a85b")) {
    _id_94F7(var_0, var_5._id_DD6C, var_5._id_DD6E, var_5._id_DD6D, var_5._id_9513);
  } else if(!var_0 _id_08DF::_id_75C2()) {
    var_8 = _id_100C0(var_4);
    var_0 _id_08DF::_id_54E8(self, 1, var_8, var_5);
  }

  if(isai(var_0)) {
    if(!getdvarint("#x32923f011fc14a85b")) {
      var_0 _meth_80F9(var_6, var_7);
    }

    if(isDefined(var_0._id_0DDF)) {
      var_0._id_0DDF._id_4AC4 = 1;
    }

    if(isDefined(var_5._id_24F5) && !var_5._id_24F5) {
      var_0 _id_06C5::_id_72A1();
    }

    if(_id_7337(var_5)) {
      thread _id_732F(var_0, var_4, var_1);
    }
  } else {
    if(isDefined(var_5._id_24F5) && !var_5._id_24F5) {
      _id_4887(var_0, "weapon_");
    }

    var_0.origin = var_6;
    var_0.angles = var_7;
  }

  if(var_4 == 0) {
    self._id_4F62 = var_0;

    if(getdvarint("#x32923f011fc14a85b") || isDefined(var_3[0]._id_0153)) {
      thread _id_4F69(var_0);
    }
  }

  self notify("guy_entered", var_0, var_4);
  var_0 notify("loaded");
  scripts\engine\utility::_id_5470("unloaded");
  thread _id_732D(var_0, var_4);

  if(isDefined(var_5._id_C834)) {
    var_0[[var_5._id_C834]]();
    return;
  }

  if(!getdvarint("#x32923f011fc14a85b")) {
    if(isDefined(var_5._id_6AB6)) {
      thread[[var_5._id_6AB6]](var_0, var_4);
    } else {
      thread _id_732E(var_0, var_4);
    }
  }
}

_id_FFFC() {
  if(!isDefined(self._id_CC91)) {
    return 0;
  }

  return self._id_CC91;
}

_id_FFFD() {
  if(!isDefined(self._id_CC92)) {
    return 1;
  }

  return self._id_CC92;
}

_id_7337(var_0) {
  if(!isDefined(var_0._id_9E6C)) {
    return 0;
  }

  if(!isDefined(self._id_CDFB)) {
    return 1;
  }

  return !self._id_CDFB;
}

_id_73E9() {
  var_0 = _id_06E9::_id_6810();
  self._id_1D81 = [];

  if(!(isDefined(level.vehicle._id_F078._id_1306) && isDefined(level.vehicle._id_F078._id_1306[var_0]))) {
    return;
  }
  var_1 = level.vehicle._id_F078._id_1306[var_0].size;

  if(isDefined(self._id_039B) && self._id_039B == "ai_wait_go") {
    thread _id_12FE();
  }

  self._id_CA62 = [];
  self._id_FE56 = [];
  self._id_6AC0 = [];
  self._id_46C8 = 0;
  var_2 = level.vehicle._id_F078._id_1306[var_0];

  for(var_3 = 0; var_3 < var_1; var_3++) {
    self._id_FE56[var_3] = 0;

    if(istrue(var_2[var_3].is_script_filled)) {
      self._id_FE56[var_3] = 1;
    }

    if(isDefined(self._id_CDFB) && self._id_CDFB && isDefined(var_2[var_3]._id_2529) && var_2[var_3]._id_2529) {
      self._id_FE56[1] = 1;
    }
  }
}

_id_95AA(var_0) {
  _id_95A9(var_0, 1);
}

_id_7327(var_0, var_1) {
  waittillframeend;
  var_0 setCanDamage(1);
  var_0 endon("death");
  var_0._id_0040 = 0;
  var_0.health = 10150;

  if(isDefined(var_0._id_CE66)) {
    var_0.health = var_0.health + var_0._id_CE66;
  }

  var_0 endon("jumping_out");

  if(isDefined(var_0._id_992D) && var_0._id_992D) {
    while(isDefined(var_0._id_992D) && var_0._id_992D) {
      wait 0.05;
    }
  }

  while(var_0.health > 10000) {
    var_0 waittill("damage");
  }

  thread _id_7329(var_0, var_1);
}

_id_7329(var_0, var_1) {
  var_2 = gettime() + _func_0079(var_1._id_0153) * 1000;
  var_3 = var_0.angles;
  var_4 = var_0.origin;
  var_0 = _id_3C79(var_0);
  _id_4887(var_0, "weapon_");
  var_0 linkto(self);
  var_0 notsolid();
  var_0 _meth_82D9(var_1._id_0153);

  if(isai(var_0)) {
    var_0 scripts\engine\utility::_id_CD61("anim_dropallaiweapons");
  } else {
    _id_4887(var_0, "weapon_");
  }

  if(isDefined(var_1._id_43B1)) {
    var_0 unlink();

    if(isDefined(var_0._id_5DB5)) {
      var_0[[var_0._id_5DB5]]();
    }

    var_0 startragdoll();
    wait(var_1._id_43B1);
    var_0 delete();
    return;
  }
}

_id_95A9(var_0, var_1, var_2) {
  self endon("death");

  if(var_0.size) {
    if(!isDefined(var_1)) {
      var_1 = 0;
    }

    scripts\engine\utility::_id_5470("unloaded");
    scripts\engine\utility::_id_5470("loaded");
    scripts\engine\utility::_id_1BB7(var_0, ::_id_650D, var_1, var_2);
    scripts\engine\utility::_id_1BE7(var_0, "loaded");
  }

  scripts\engine\utility::_id_5474("loaded");
}

_id_86A1(var_0) {
  for(var_1 = 0; var_1 < self._id_C835.size; var_1++) {
    if(self._id_C835[var_1] == var_0) {
      return 1;
    }
  }

  return 0;
}

_id_650D(var_0, var_1, var_2) {
  if(_id_86A1(var_0)) {
    return;
  }
  if(!_id_73EF()) {
    return;
  }
  _id_7333(var_0, self, var_1, var_2);
}

_id_73EF() {
  if(_id_100D4()) {
    return 1;
  }

  if(!scripts\common\utility::issp()) {
    var_0 = self._id_3804;
  } else {
    var_0 = self.class;
  }
}

_id_100D4() {
  if(level.vehicle._id_F078._id_1306[_id_06E9::_id_6810()].size - self._id_CA62.size) {
    return 1;
  } else {
    return 0;
  }
}

_id_7334(var_0, var_1) {
  var_1 endon("death");
  var_1 endon("stop_loading");
  var_2 = var_1 _id_06E9::_id_6810();
  var_3 = level.vehicle._id_F078._id_1306[var_2];

  if(getdvarint("#x32923f011fc14a85b")) {
    var_4 = var_0 scripts\engine\utility::_id_10898("long_death", "death", "enteredvehicle");

    if(var_4 != "enteredvehicle" && isDefined(var_0._id_5E8A)) {
      if(istrue(var_3[var_0._id_5E8A].is_script_filled)) {
        if(isDefined(var_0._id_0481)) {} else {}
      }

      var_1._id_FE56[var_0._id_5E8A] = 0;
    }
  } else if(!var_0 _id_08DF::_id_10801() && isDefined(var_0._id_5E8A)) {
    if(istrue(var_3[var_0._id_5E8A].is_script_filled)) {
      if(isDefined(var_0._id_0481)) {} else {}
    }

    var_1._id_FE56[var_0._id_5E8A] = 0;
  }

  var_1._id_CA62 = scripts\engine\utility::array_remove(var_1._id_CA62, var_0);
  _id_1013A(var_1);
}

_id_1013A(var_0) {
  if(isDefined(var_0._id_04DE) && isDefined(var_0._id_1013B)) {
    if(var_0._id_C835.size == var_0._id_1013B) {
      var_0 scripts\engine\utility::_id_5474("loaded");
    }
  } else if(!var_0._id_CA62.size && var_0._id_C835.size) {
    if(var_0._id_FE56[0]) {
      var_0 scripts\engine\utility::_id_5474("loaded");
    } else if(!getdvarint("#x32923f011fc14a85b")) {
      var_0 thread _id_10242();
    }
  }
}

_id_10242() {
  var_0 = self._id_C835;
  scripts\common\vehicle::_id_102D0();
  scripts\engine\utility::_id_5476("unloaded");
  var_0 = scripts\engine\utility::_id_1BCA(var_0);
  thread scripts\common\vehicle::_id_10139(var_0);
}

_id_C402(var_0, var_1, var_2) {
  scripts\engine\utility::_id_10888(self, "death", var_0, "jumpedout", var_0, "entitydeleted");

  if(var_2) {
    var_0 _id_06C5::_id_E8B9();
  }

  if(var_1) {
    var_0 scripts\engine\utility::_id_5212();
  }
}

_id_359D(var_0, var_1, var_2) {
  var_0 endon("stop_loading");
  self endon("stop_loading");

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_3 = undefined;
  var_4 = 0;
  var_5 = level.vehicle._id_F078._id_1306[self.classname];

  if(isDefined(var_0._id_CE67)) {
    if(istrue(var_5[var_0._id_CE67].is_script_filled)) {
      if(isDefined(var_0._id_0481)) {} else {}
    } else
      var_3 = _id_100C0(var_0._id_CE67, var_0.origin);
  } else if(!self._id_FE56[0]) {
    var_3 = _id_100C0(0, var_0.origin);

    if(var_2) {
      thread _id_7400(var_0, var_2);
    }
  } else if(var_1._id_1F93.size)
    var_3 = _id_100B6(var_1._id_1F93, var_0.origin);
  else {
    var_3 = undefined;
  }

  return var_3;
}

_id_7333(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0)) {
    return;
  }
  var_0 endon("stop_loading");
  var_1 endon("stop_loading");
  var_4 = 1;

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_5 = level.vehicle._id_F078._id_1306[var_1 _id_06E9::_id_6810()];

  if(isDefined(var_1._id_CA77)) {
    var_1 thread[[var_1._id_CA77]](var_0);
    return;
  }

  var_1 endon("death");
  var_0 endon("death");
  var_1._id_CA62[var_1._id_CA62.size] = var_0;
  thread _id_7334(var_0, var_1);
  var_6 = [];
  var_7 = undefined;
  var_8 = 0;
  var_9 = getdvarint("#x32923f011fc14a85b");

  for(var_10 = 0; var_10 < var_5.size; var_10++) {
    if(isDefined(var_5[var_10]._id_6AB3)) {
      var_9 = 1;
    }
  }

  if(!var_9) {
    var_0 notify("enteredvehicle");
    var_1 _id_732A(var_0, var_4);
    return;
  }

  if(!isDefined(var_0._id_650B)) {
    while(var_1 _meth_842E() > 1) {
      wait 0.05;
    }
  }

  var_11 = var_1 _id_637E(var_3);

  if(!var_11._id_1F93.size && var_11._id_A5AA.size) {
    var_0 notify("enteredvehicle");
    var_1 _id_732A(var_0, var_4);
    return;
  }

  var_7 = var_1 _id_359D(var_0, var_11, var_2);

  if(!isDefined(var_7)) {
    return;
  }
  var_8 = var_7.origin;
  var_12 = var_7.angles;
  var_0._id_5E8A = var_7._id_10238;
  var_1._id_FE56[var_7._id_10238] = 1;

  if(!getdvarint("#x32923f011fc14a85b")) {
    var_0._id_CDC5 = 1;
    var_0 notify("stop_going_to_node");
    var_0 _id_06C5::_id_D215();
    var_0 _id_06C5::_id_49D9();
    var_0._id_0201 = 64;
    var_0 _meth_8326(var_8);
    var_0 waittill("goal");
    var_0 _id_06C5::_id_51DA();
    var_0 _id_06C5::_id_F9BB();
    var_0 notify("boarding_vehicle");
  } else {
    var_0 _id_08DF::_id_C576(var_1, 0, var_7, _id_1801(var_1, var_7._id_10238));
    var_0 _id_08DF::_id_107F5();

    if(!isalive(var_0)) {
      return;
    }
  }

  _id_7335(var_0, var_1, var_7, var_4);
}

_id_7335(var_0, var_1, var_2, var_3) {
  var_4 = _id_1801(var_1, var_2._id_10238);

  if(isDefined(var_4._id_4649)) {
    var_0._id_4649 = var_4._id_4649;

    if(isDefined(var_4._id_46CD)) {
      var_1._id_46C8 = var_0._id_4649;
    }
  }

  if(isDefined(var_4._id_46CD)) {
    var_1._id_46C8 = var_1._id_46C8 + var_4._id_46CD;
    var_0._id_4649 = var_1._id_46C8;
  }

  if(!getdvarint("#x32923f011fc14a85b")) {
    var_1 _id_94F7(var_0, var_4._id_DD6C, var_4._id_DD6E, var_4._id_DD6D, var_4._id_9513);
  }

  var_0._id_0040 = 0;

  if(isDefined(var_2)) {
    if(isDefined(var_4._id_100BC)) {
      var_5 = isDefined(var_0._id_A538);

      if(!var_5 && !isagent(var_0)) {
        if(isDefined(var_4._id_100C3)) {
          var_1 _meth_8077(var_4._id_100C3, 0);
        }

        if(isDefined(var_4._id_100C5)) {
          var_1 _meth_8077(var_4._id_100C5, 0);
        }

        if(isDefined(var_4._id_100C7)) {
          var_1 _meth_8077(var_4._id_100C7, 0);
        }

        if(isDefined(var_4.vehicle_getoutanim_postanim)) {
          var_1 _meth_8077(var_4.vehicle_getoutanim_postanim, 0);
        }
      }

      var_1 = var_1 _id_68C2();
      var_6 = _id_6639(var_2._id_36ED, var_4._id_100BC);
      var_1 thread _id_D478(var_6, var_4._id_100BD, var_4.vehicle_getinanim_postanim, var_4.vehicle_getinanim_postanim_clear, var_4.vehicle_getinanim_postanim_delay);
      var_1 thread _id_06DC::_id_E617(var_1, "vehicle_anim_flag", undefined, undefined, var_4._id_100BC);
    }

    if(isDefined(var_4._id_100BF)) {
      var_7 = var_1 gettagorigin(var_4._id_100BF);
    } else {
      var_7 = var_1.origin;
    }

    if(isDefined(var_4._id_100BE)) {
      _func_01A3(var_4._id_100BE, var_7);
    }

    if(isDefined(var_4.turret_getinanim)) {
      var_8 = _id_67EC(var_1, var_2._id_10238);

      if(isDefined(var_8)) {
        var_9 = _id_6639(var_2._id_36ED, var_4.turret_getinanim);
        var_8 thread _id_D478(var_9, 0);
      }
    }

    var_10 = undefined;
    var_11 = undefined;

    if(isDefined(var_4._id_6AB4)) {
      var_10 = [];
      var_10[0] = var_4._id_6AB4;
      var_11 = [];
      var_11[0] = ::_id_54D2;
      var_1 _id_94F7(var_0, var_4._id_DD6C, var_4._id_DD6E, var_4._id_DD6D, var_4._id_9513);
    }

    if(!getdvarint("#x32923f011fc14a85b")) {
      var_1 _id_18B3(var_0, var_4._id_DD6C, var_4._id_6AB3, var_10, var_11, undefined, var_4._id_DD6E, var_4._id_DD6D);
    }
  }

  if(getdvarint("#x32923f011fc14a85b")) {
    var_12 = var_0 _id_08DF::_id_10801(1);

    if(!var_12) {
      return;
    }
  }

  var_0 notify("enteredvehicle");
  var_1 _id_732A(var_0, var_3);
}

_id_7330(var_0, var_1) {
  var_2 = var_1 _meth_87E6();
  var_3 = var_2._id_ADB4;
  var_4 = _id_66B5(var_3, var_2);
  var_5 = _id_1801(var_3, var_4);
  var_6 = spawnStruct();
  var_6._id_10238 = var_4;
  var_6._id_36ED = var_1._id_100BB;
  var_3._id_FE56[var_6._id_10238] = 1;
  var_0 _id_08DF::_id_C576(var_3, 0, var_6, var_5, 1);
  var_0 _id_08DF::_id_107F5();

  if(!isalive(var_0)) {
    var_3._id_FE56[var_6._id_10238] = 0;
    return;
  }

  _id_7335(var_0, var_3, var_6, 1);
}

_id_54D2() {
  self notify("enteredvehicle");
}

_id_4F69(var_0) {
  if(scripts\common\vehicle::_id_8896()) {
    return;
  }
  self._id_4F62 = var_0;
  self endon("death");
  var_0 endon("jumping_out");
  var_0 waittill("death");

  if(getdvarint("#x3911ee9c3ba6aadd9", 0) == 1) {
    return;
  }
  if(isDefined(self._id_10129)) {
    return;
  }
  self notify("driver dead");
  self._id_439B = 1;

  if(isDefined(self._id_75B8) && self._id_75B8) {
    self _meth_83B0(0);
    self vehicle_setspeed(0, 20, 20);
    self waittill("reached_wait_speed");
  }

  if(!istrue(self._id_4D72)) {
    scripts\common\vehicle::_id_102D0();
  }
}

_id_7324(var_0, var_1) {
  if(isai(var_0)) {
    return var_0;
  }

  if(istrue(var_0._id_4F7B)) {
    var_0 delete();
  } else {
    var_0 = scripts\engine\utility::_id_CD61("spawner_makerealai", var_0);

    if(scripts\common\utility::issp()) {
      var_2 = self.classname;
    } else {
      var_2 = self._id_3804;
    }

    var_3 = level.vehicle._id_F078._id_1306[var_2].size;
    var_4 = _id_1801(self, var_1);
    _id_94F7(var_0, var_4._id_DD6C, var_4._id_DD6E, var_4._id_DD6D, var_4._id_9513);
    var_0._id_100DA = var_4._id_7CA9;

    if(!istrue(var_0._id_4A65)) {
      thread _id_732E(var_0, var_1);
    }
  }
}

_id_94F7(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  if(!isDefined(var_3)) {
    var_3 = (0, 0, 0);
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  if(var_4 && !isDefined(var_0._id_CD21)) {
    var_0 _meth_820D(self, var_1, 0);
  } else {
    var_0 linkto(self, var_1, var_2, var_3);
  }
}

_id_1801(var_0, var_1) {
  return level.vehicle._id_F078._id_1306[var_0 _id_06E9::_id_6810()][var_1];
}

_id_7328(var_0, var_1) {
  var_0 waittill("death");

  if(!isDefined(self)) {
    return;
  }
  self._id_C835 = scripts\engine\utility::array_remove(self._id_C835, var_0);
  self._id_FE56[var_1] = 0;
}

_id_D74D() {
  if(!isDefined(level.vehicle._id_1307)) {
    level.vehicle._id_1307 = [];
  }

  if(!isDefined(level.vehicle._id_1305)) {
    level.vehicle._id_1305 = [];
  }

  level.vehicle._id_1307["idle"] = ::_id_732E;
  level.vehicle._id_1307["unload"] = ::_id_733A;
}

_id_732D(var_0, var_1) {
  var_0._id_100DC = 1;
  thread _id_7328(var_0, var_1);
}

_id_4F64(var_0, var_1) {
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");
  var_2 = _id_1801(self, var_1);

  for(;;) {
    if(self _meth_842E() == 0) {
      var_0._id_100DA = var_2._id_7CAF;
    } else {
      var_0._id_100DA = var_2._id_7CAA;
    }

    wait 0.25;
  }
}

_id_732E(var_0, var_1, var_2) {
  var_0 endon("newanim");

  if(!isDefined(var_2)) {
    self endon("death");
  }

  var_0 endon("death");
  var_0._id_100DC = 1;
  var_0 notify("gotime");

  if(!isDefined(var_0._id_100DA)) {
    return;
  }
  var_3 = _id_1801(self, var_1);

  if(isDefined(var_3._id_9E6C)) {
    return;
  }
  if(isDefined(var_3._id_7CAF) && isDefined(var_3._id_7CAA)) {
    thread _id_4F64(var_0, var_1);
  }

  for(;;) {
    var_0 notify("idle");
    _id_B292(var_0, var_3);
  }
}

_id_B292(var_0, var_1) {
  if(isDefined(var_0._id_100DB)) {
    _id_18B3(var_0, var_1._id_DD6C, var_0._id_100DB, undefined, undefined, undefined, var_1._id_DD6E, var_1._id_DD6D);
    return;
  }

  if(isDefined(var_1._id_7CCE)) {
    var_2 = _id_C012(var_0, var_1._id_7CCE);
    _id_18B3(var_0, var_1._id_DD6C, var_0._id_100DA[var_2], undefined, undefined, undefined, var_1._id_DD6E, var_1._id_DD6D);
    return;
  }

  if(isDefined(var_0._id_B73E) && isDefined(var_1._id_B4E6)) {
    _id_18B3(var_0, var_1._id_DD6C, var_1._id_B4E6, undefined, undefined, undefined, var_1._id_DD6E, var_1._id_DD6D);
    return;
  }

  if(isDefined(var_1._id_100DA)) {
    thread _id_D478(var_1._id_100DA);
  }

  _id_18B3(var_0, var_1._id_DD6C, var_0._id_100DA, undefined, undefined, undefined, var_1._id_DD6E, var_1._id_DD6D);
}

_id_C012(var_0, var_1) {
  var_2 = [];
  var_3 = 0;

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    var_3 = var_3 + var_1[var_4];
    var_2[var_4] = var_3;
  }

  var_5 = randomint(var_3);

  for(var_4 = 0; var_4 < var_1.size; var_4++) {
    if(var_5 < var_2[var_4]) {
      return var_4;
    }
  }
}

_id_733C(var_0) {
  self endon("death");
  self._id_F980 = scripts\engine\utility::array_add(self._id_F980, var_0);
  var_0 scripts\engine\utility::waittill_any_2("death", "jumpedout");
  self._id_F980 = scripts\engine\utility::array_remove(self._id_F980, var_0);

  if(!self._id_F980.size) {
    scripts\engine\utility::_id_5474("unloaded");
    self._id_F96A = "default";
    self._id_4E57 = undefined;
  }
}

_id_C836(var_0) {
  if(!self._id_C835.size) {
    return 0;
  }

  for(var_1 = 0; var_1 < self._id_C835.size; var_1++) {
    if(!isalive(self._id_C835[var_1]) && !isDefined(self._id_C835[var_1]._id_8AF5)) {
      continue;
    }
    if(_id_34D7(self._id_C835[var_1]._id_10238, var_0)) {
      return 1;
    }
  }

  return 0;
}

_id_67FC() {
  var_0 = [];
  var_1 = [];
  var_2 = "default";

  if(isDefined(self._id_F96A)) {
    var_2 = self._id_F96A;
  }

  var_1 = level.vehicle._id_F078._id_F97C[_id_06E9::_id_6810()][var_2];

  if(!isDefined(var_1)) {
    var_1 = level.vehicle._id_F078._id_F97C[_id_06E9::_id_6810()]["default"];
  }

  foreach(var_4 in var_1) {
    var_0[var_4] = var_4;
  }

  return var_0;
}

_id_34D7(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = self._id_F96A;
  }

  var_2 = _id_06E9::_id_6810();

  if(!isDefined(level.vehicle._id_F078._id_F97C[var_2])) {
    return 1;
  }

  if(!isDefined(level.vehicle._id_F078._id_F97C[var_2][var_1])) {
    return 1;
  }

  var_3 = level.vehicle._id_F078._id_F97C[var_2][var_1];

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(var_0 == var_3[var_4]) {
      return 1;
    }
  }

  return 0;
}

_id_6BF5(var_0, var_1, var_2) {
  self endon("unloading");

  for(;;) {
    _id_18B3(var_0, var_1, var_2);
  }
}

_id_6BF4(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_06E9::_id_6810();

  if(var_4) {
    thread _id_6BF5(var_1, var_2, level.vehicle._id_F078._id_1D82[var_5][var_0._id_59C0]._id_7CC8);
    self waittill("unloading");
  }

  self._id_F980 = scripts\engine\utility::array_add(self._id_F980, var_1);
  thread _id_6BF1(var_1, var_2, var_3);

  if(!_id_06E9::_id_10120()) {
    _id_18B3(var_1, var_2, var_3);
  }

  var_1 unlink();

  if(!isDefined(self)) {
    var_1 delete();
    return;
  }

  self._id_F980 = scripts\engine\utility::array_remove(self._id_F980, var_1);

  if(!self._id_F980.size) {
    self notify("unloaded");
  }

  self._id_59C0[var_0._id_59C0] = undefined;
  wait 10;
  var_1 delete();
}

_id_6BF6(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  var_5 = _id_06E9::_id_6810();
  thread scripts\engine\utility::_id_472E(var_1);
  var_6 = self gettagorigin(var_2);
  var_7 = self gettagangles(var_2);
  var_8 = level.vehicle._id_F078._id_1D82[var_5][var_0._id_59C0]._id_7CC8;
  var_9 = getstartorigin(var_6, var_7, var_8);
  var_10 = _func_00D2(var_6, var_7, var_8);
  var_10 = self.angles;
  var_11 = var_1 gettagorigin("j_rope_1", 1);
  var_12 = var_11 - self.origin;

  if(var_4) {
    var_1.origin = var_9;
    var_1.angles = var_10;
    thread scripts\engine\utility::_id_CD61("fastrope_anim", var_1, var_8, "getoutrigidle");
    scripts\engine\utility::_id_5476("unloaded");
  }

  var_6 = self gettagorigin(var_2);
  var_7 = self gettagangles(var_2);
  var_13 = self.angles - var_10;
  var_13 = (_func_000A(var_13[0]), _func_000A(var_13[1]), _func_000A(var_13[2]));
  var_14 = rotatevector(var_12, var_13) + self.origin;
  var_15 = scripts\engine\trace::ray_trace(var_14, var_14 - (0, 0, 1000), self, scripts\engine\trace::_id_3F94());
  var_16 = var_14[2] - 400;

  if(isDefined(var_15["position"])) {
    var_16 = var_15["position"][2];
  }

  var_17 = (var_6[0], var_6[1], var_16);

  if(istrue(level.vehicle._id_F078._id_1D82[var_5][var_0._id_59C0]._id_5073)) {
    var_17 = (var_14[0], var_14[1], var_16);
  }

  thread _id_6BF1(var_1, undefined, var_3, var_17);

  if(!_id_06E9::_id_10120()) {
    var_1 unlink();
    var_1.origin = var_17;
    thread scripts\engine\utility::_id_CD61("fastrope_anim", var_1, var_3, "getoutrigfall");
  }

  self._id_59C0[var_0._id_59C0] = undefined;
  wait 10;
  var_1 delete();
}

_id_6BF3() {
  wait 0.05;

  while(isalive(self) && self._id_F980.size > 2) {
    wait 0.05;
  }

  if(!isalive(self) || _id_06E9::_id_10120()) {
    return;
  }
  self notify("getoutrig_disable_abort");
}

_id_6BF2() {
  self endon("end_getoutrig_abort_while_deploying");

  while(!_id_06E9::_id_10120()) {
    wait 0.05;
  }

  var_0 = [];

  foreach(var_2 in self._id_C835) {
    if(isalive(var_2)) {
      scripts\engine\utility::_id_1B8D(var_0, var_2);
    }
  }

  scripts\engine\utility::_id_1BA4(var_0);
  self notify("crashed_while_deploying");
  var_0 = undefined;
}

_id_6BF1(var_0, var_1, var_2, var_3) {
  var_4 = _func_0079(var_2);
  var_5 = var_4 - 1.0;

  if(self._id_04DE == "mi17") {
    var_5 = var_4 - 0.5;
  }

  var_6 = 0.8;
  self endon("getoutrig_disable_abort");
  thread _id_6BF3();
  thread _id_6BF2();
  scripts\engine\utility::_id_108F5("crashed_while_deploying", var_6);
  self notify("end_getoutrig_abort_while_deploying");

  while(!isDefined(self._id_102F4)) {
    waitframe();
  }

  if(isDefined(var_0)) {
    if(!isDefined(var_1) && isDefined(var_3)) {
      var_0 unlink();
      var_0.origin = var_3;

      if(!scripts\common\utility::issp()) {
        var_7 = var_0 _id_0009::_id_1C7D("animscripted", var_2);
        var_8 = var_0 _id_0009::_id_1C6E("animscripted", var_7);
        var_9 = getstartorigin(self.origin, self.angles, var_8);
        var_10 = _func_00D2(self.origin, self.angles, var_8);
        var_0 dontinterpolate();
        var_0 _meth_80F9(var_9, var_10);
        var_0 _meth_8019("nogravity");
        var_0 _meth_85ED("animscripted", var_7);
      } else
        var_0 _meth_801B("getoutrigfall", var_0.origin, var_0.angles, var_2, undefined, undefined, 0);
    } else
      thread _id_18B3(var_0, var_1, var_2);

    waittillframeend;
    var_0 _meth_82E7(var_2, var_5 / var_4);
  }

  var_11 = self;

  if(isDefined(self._id_AC83)) {
    var_11 = self._id_AC83;
  }

  for(var_12 = 0; var_12 < self._id_C835.size; var_12++) {
    if(!isDefined(self._id_C835[var_12])) {
      continue;
    }
    if(!isDefined(self._id_C835[var_12]._id_BF4D)) {
      continue;
    }
    if(self._id_C835[var_12]._id_BF4D != 1) {
      continue;
    }
    if(!isDefined(self._id_C835[var_12]._id_C83B)) {
      continue;
    }
    self._id_C835[var_12]._id_5EA3 = 1;

    if(isalive(self._id_C835[var_12])) {
      thread _id_18B5(self._id_C835[var_12], self, var_11);
    }
  }
}

_id_D478(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  self endon("dont_clear_anim");

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_5 = _func_0079(var_0);
  self endon("death");
  _id_06C6::guy_pre_anim_func();
  thread scripts\engine\utility::_id_CD61("vehicle_door_anim", self, var_0);

  if(isDefined(var_2) && isDefined(var_4)) {
    wait(var_4);
  } else {
    wait(var_5);
  }

  if(isDefined(var_2)) {
    if(scripts\common\utility::issp()) {
      self _meth_8077(var_0, 0);
    }

    var_5 = _func_0079(var_2);
    thread scripts\engine\utility::_id_CD61("vehicle_door_anim", self, var_2);
    wait(var_5);
  }

  if(scripts\common\utility::issp()) {
    if(var_1) {
      self _meth_8077(var_0, 0);
    }

    if(istrue(var_3) && isDefined(var_2)) {
      self _meth_8077(var_2, 0);
    }
  }

  if(!var_1 && (isDefined(self._id_00EC) && self._id_00EC == "misc_turret")) {
    wait 0.2;
  }

  _id_06C6::guy_post_anim_func();
}

#using_animtree("script_model");

_id_6BEA(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = _id_06E9::_id_6810();

  if(isDefined(self._id_1D6D) && isDefined(self._id_1D6D[var_1._id_59C0])) {
    var_4 = 1;
  } else {
    var_4 = 0;
  }

  if(!isDefined(var_1._id_59C0) || isDefined(self._id_59C0[var_1._id_59C0]) || var_4) {
    return;
  }
  var_5 = var_0 gettagorigin(level.vehicle._id_F078._id_1D82[var_3][var_1._id_59C0]._id_0427);
  var_6 = var_0 gettagangles(level.vehicle._id_F078._id_1D82[var_3][var_1._id_59C0]._id_0427);
  self._id_59C1[var_1._id_59C0] = 1;
  var_7 = spawn("script_model", var_5);
  var_7.angles = var_6;
  var_7.origin = var_5;
  var_7 useanimtree(#animtree);
  var_7 setModel(level.vehicle._id_F078._id_1D82[var_3][var_1._id_59C0].model);
  self._id_59C0[var_1._id_59C0] = var_7;
  var_7 linkto(var_0, level.vehicle._id_F078._id_1D82[var_3][var_1._id_59C0]._id_0427);

  if(getdvarint("#x32923f011fc14a85b")) {
    thread _id_6BF6(var_1, var_7, level.vehicle._id_F078._id_1D82[var_3][var_1._id_59C0]._id_0427, level.vehicle._id_F078._id_1D82[var_3][var_1._id_59C0]._id_500B, var_2);
  } else {
    thread _id_6BF4(var_1, var_7, level.vehicle._id_F078._id_1D82[var_3][var_1._id_59C0]._id_0427, level.vehicle._id_F078._id_1D82[var_3][var_1._id_59C0]._id_500B, var_2);
  }

  return var_7;
}

_id_34BC(var_0) {
  if(!isDefined(self._id_E05D)) {
    self._id_E05D = [];
  }

  var_1 = 0;

  if(!isDefined(self._id_E05D[var_0])) {
    self._id_E05D[var_0] = 1;
  } else {
    var_1 = 1;
  }

  thread _id_34BD(var_0);
  return var_1;
}

_id_34BD(var_0) {
  wait 0.05;

  if(!isDefined(self)) {
    return;
  }
  self._id_E05D[var_0] = 0;
  var_1 = getarraykeys(self._id_E05D);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(self._id_E05D[var_1[var_2]]) {
      return;
    }
  }

  self._id_E05D = undefined;
}

_id_1022F(var_0, var_1, var_2, var_3, var_4) {
  var_5 = level.vehicle._id_F078._id_1306[_id_06E9::_id_6810()];
  var_6 = _id_68C2();

  if(!isDefined(var_1)) {
    var_1 = var_0._id_100C3;
  }

  if(!isDefined(var_2)) {
    var_2 = var_0._id_100C4;
  }

  if(isDefined(var_1)) {
    var_6 thread _id_D478(var_1, var_2, var_3, var_4);
    var_7 = 0;

    if(isDefined(var_0._id_100CA)) {
      var_7 = _id_34BC(var_0._id_100CA);
      var_8 = var_6 gettagorigin(var_0._id_100CA);
    } else
      var_8 = var_6.origin;

    if(isDefined(var_0._id_100C9) && !var_7) {
      _func_01A3(var_0._id_100C9, var_8);
    }

    var_7 = undefined;
  }
}

_id_100A7(var_0, var_1) {
  var_2 = _id_1801(self, var_1);

  if(isDefined(var_0._id_B73E) && isDefined(var_2._id_B49D)) {
    level.player thread scripts\engine\utility::_id_CD61("playloopsound_on_entity", var_2._id_B49D);
  }

  if(isDefined(var_2._id_6BEF)) {
    var_0 thread scripts\engine\utility::_id_CD61("playloopsound_on_entity", var_2._id_6BEF);
  }

  if(isDefined(var_0._id_B73E) && isDefined(var_2._id_B49C)) {
    level.player thread scripts\engine\utility::_id_CD61("playsound_on_entity", var_2._id_B49C);
  }
}

get_door_state_name(var_0) {
  if(_func_0107(var_0)) {
    var_1 = getfirstarraykey(var_0);
    return _func_00C1(var_0[var_1]);
  }

  return _func_00C1(var_0);
}

_id_BBC0() {
  if(isDefined(self._id_4E57)) {
    return;
  }
  self._id_4E57 = [];

  for(var_0 = 0; var_0 < level.vehicle._id_F078._id_1306[_id_06E9::_id_6810()].size; var_0++) {
    var_1 = level.vehicle._id_F078._id_1306[_id_06E9::_id_6810()][var_0];

    if(isDefined(var_1._id_100C3)) {
      var_2 = get_door_state_name(var_1._id_100C3);
      self._id_4E57[var_2] = spawnStruct();
      self._id_4E57[var_2]._id_ABED = 0;
      self._id_4E57[var_2]._id_AC33 = 0;
    }
  }
}

_id_1072C(var_0, var_1) {
  var_0 endon("jumpedout");
  var_0 endon("death");
  _id_BBC0();

  while(!istrue(var_0._id_C57E)) {
    waitframe();
  }

  if(getdvarint("#x32923f011fc14a85b")) {
    var_2 = var_0._id_0B67._id_36F2._id_36EE;
  } else {
    var_2 = "first_array_item";
  }

  if(isDefined(var_1._id_100C3)) {
    var_3 = get_door_state_name(var_1._id_100C3);

    if(!self._id_4E57[var_3]._id_ABED) {
      var_4 = _id_6639(var_2, var_1._id_100C3);
      var_5 = var_1._id_100C4;
      var_6 = var_1.vehicle_getoutanim_postanim;
      var_7 = var_1.vehicle_getoutanim_postanim_clear;

      if(isDefined(var_0._id_C57F)) {
        if(var_0._id_C57F == "combat_run" && isDefined(var_1._id_100C7)) {
          var_4 = _id_6639(var_2, var_1._id_100C7);
          var_5 = var_1._id_100C8;
        } else if(var_0._id_C57F == "combat" && isDefined(var_1._id_100C5)) {
          var_4 = _id_6639(var_2, var_1._id_100C5);
          var_5 = var_1._id_100C6;
        }
      }

      _id_1022F(var_1, var_4, var_5, var_6, var_7);
      self._id_4E57[var_3]._id_ABED = 1;
    }

    if(isDefined(var_1._id_59C0) && !isDefined(self._id_59C0[var_1._id_59C0])) {
      var_8 = _id_68C2();
      var_9 = _id_6BEA(var_8, var_1, 1);
    }
  }

  if(isDefined(var_1.turret_getoutanim)) {
    var_10 = _id_67EC(self, var_0._id_10238);

    if(isDefined(var_10)) {
      var_11 = _id_6639(var_2, var_1.turret_getoutanim);
      var_10 thread _id_D478(var_11);
    }
  }
}

_id_7336(var_0, var_1) {
  if(isDefined(var_1._id_59C0)) {
    thread _id_1072C(var_0, var_1);
    var_0 _id_08DF::_id_D8AA();
  } else {}
}

_id_733A(var_0, var_1, var_2) {
  var_3 = 0;

  if(isDefined(var_0._id_8AF5)) {
    var_3 = 1;
  }

  var_4 = _id_1801(self, var_1);
  var_5 = self._id_04DE;

  if(!istrue(var_2) && !_id_34D7(var_1)) {
    if(!getdvarint("#x32923f011fc14a85b")) {
      thread _id_732E(var_0, var_1);
    }

    return;
  }

  if(!getdvarint("#x32923f011fc14a85b") && !isDefined(var_4._id_6BE3)) {
    thread _id_732E(var_0, var_1);
    return;
  }

  thread _id_733C(var_0);
  self endon("death");

  if(isai(var_0) && isalive(var_0)) {
    var_0 endon("death");
  }

  var_6 = 0;

  if(isDefined(var_0._id_6BCB)) {
    var_7 = var_0[[var_0._id_6BCB]]();

    if(isDefined(var_7) && var_7) {
      var_6 = 1;
    }
  }

  if(isDefined(var_0._id_AB90)) {
    var_0._id_AB90 = undefined;

    if(isDefined(var_0._id_6BCB)) {
      var_0[[var_0._id_6BCB]]();
    }
  }

  if(!getdvarint("#x32923f011fc14a85b")) {
    _id_1022F(var_4);
    var_8 = 0;

    if(isDefined(var_4._id_6BED)) {
      var_8 = var_8 + _func_0079(var_4._id_6BED);
    }

    if(isDefined(var_4._id_4649)) {
      var_8 = var_8 + var_4._id_4649;
    }

    if(isDefined(var_0._id_4649)) {
      var_8 = var_8 + var_0._id_4649;
    }

    if(var_8 > 0) {
      if(!getdvarint("#x32923f011fc14a85b")) {
        thread _id_732E(var_0, var_1);
      }

      wait(var_8);
    }
  }

  if(!getdvarint("#x32923f011fc14a85b")) {
    var_0._id_43D3 = undefined;
    var_0._id_43D9 = undefined;
  }

  var_0 notify("newanim");

  if(isai(var_0)) {
    var_0 _meth_8285(1);
  }

  if(isDefined(var_4._id_25BF)) {
    var_6 = 1;
  } else if(!getdvarint("#x32923f011fc14a85b") && !isDefined(var_4._id_6BE3) || !isDefined(self._id_CEA7) && (isDefined(var_4._id_2529) && var_4._id_2529) || isDefined(self._id_CD93) && var_1 == 0) {
    thread _id_732E(var_0, var_1);
    return;
  }

  if(isDefined(var_4._id_24F5) && !var_4._id_24F5) {
    if(!isDefined(var_0._id_4A06)) {
      var_0 _id_06C5::_id_72A0();
    }
  }

  if(var_0 _id_DAA7()) {
    var_0.health = var_0._id_AC68;
  }

  var_0._id_AC68 = undefined;

  if(isai(var_0) && isalive(var_0)) {
    var_0 endon("death");
  }

  var_0._id_0040 = 0;

  if(isDefined(var_4._id_5795)) {
    var_9 = var_4._id_5795;
  } else {
    var_9 = var_4._id_DD6C;
  }

  if(isDefined(var_0._id_6625)) {
    var_10 = var_0._id_6625;
  } else if(scripts\engine\utility::_id_546E("landed") && isDefined(var_4._id_6BE8)) {
    var_10 = var_4._id_6BE8;
  } else if(isDefined(var_0._id_B73E) && isDefined(var_4._id_B49A)) {
    var_10 = var_4._id_B49A;
  } else {
    var_10 = var_4._id_6BE3;
  }

  if(!var_6) {
    if(!getdvarint("#x32923f011fc14a85b")) {
      thread _id_7339(var_0);
    }

    if(!getdvarint("#x32923f011fc14a85b") && isDefined(var_4._id_59C0)) {
      if(!isDefined(self._id_59C0[var_4._id_59C0])) {
        thread _id_732E(var_0, var_1);
        var_11 = _id_68C2();
        var_12 = _id_6BEA(var_11, var_4, 1);
      }
    }

    if(isDefined(var_4._id_6BF7)) {
      var_0 thread scripts\engine\utility::_id_CD61("playsound_on_tag", var_4._id_6BF7, "J_Wrist_RI", 1);
    }

    if(isDefined(var_0._id_B73E) && isDefined(var_4._id_B49B)) {
      var_0 thread scripts\engine\utility::_id_CD61("playsound_on_tag", var_4._id_B49B);
    }

    if(isDefined(var_4._id_6BEF)) {
      var_0 thread scripts\engine\utility::_id_CD61("playloopsound_on_tag", var_4._id_6BEF);
    }

    if(isDefined(var_0._id_B73E) && isDefined(var_4._id_B49D)) {
      level.player thread scripts\engine\utility::_id_CD61("playloopsound_on_tag", var_4._id_B49D);
    }

    var_0 notify("newanim");
    var_0 notify("jumping_out");
    var_13 = 0;

    if(!isai(var_0) && !var_3) {
      var_13 = 1;
    }

    if(!isDefined(var_0._id_CE6A) && !var_3) {
      var_0 = _id_7324(var_0, var_1);
    }

    if(!isalive(var_0) && !var_3) {
      return;
    }
    if(!var_3) {
      var_0._id_BF4D = 1;
    }

    if(isDefined(var_4._id_BF4D)) {
      var_0._id_BF4D = 1;

      if(isDefined(var_4._id_BF4A)) {
        var_0._id_BF4A = var_4._id_BF4A;
      }
    }

    if(var_13) {
      self._id_C835 = scripts\engine\utility::array_add(self._id_C835, var_0);
      thread _id_7328(var_0, var_1);
      thread _id_733C(var_0);
      var_0._id_C83B = self;
    }

    if(isai(var_0)) {
      var_0 endon("death");
    }

    var_0 notify("newanim");
    var_0 notify("jumping_out");

    if(isDefined(var_4._id_9590) && var_4._id_9590) {
      thread _id_E4ED(var_0);
    }

    if(isalive(var_0) && isai(var_0) && _id_7331(var_0)) {
      var_0._id_0201 = 600;
      var_0 _meth_8326(var_0.origin);
    }

    if(isDefined(var_4._id_6BEB)) {
      _id_18B3(var_0, var_9, var_10);
      var_14 = var_9;

      if(isDefined(var_4._id_6BEC)) {
        var_14 = var_4._id_6BEC;
      }

      _id_18B3(var_0, var_14, var_4._id_6BEB, undefined, undefined, undefined, var_4._id_DD6E, var_4._id_DD6D);
    } else {
      var_15 = 0;

      if(isDefined(var_4._id_6BE6) && isDefined(var_4._id_6BE5)) {
        thread _id_733B(var_0, var_9, var_4._id_6BE3, var_4._id_6BE6, var_4._id_6BE5);
        var_15 = 1;
      } else if(!var_3)
        var_0._id_17BA = 1;

      if(!getdvarint("#x32923f011fc14a85b")) {
        var_16 = _id_100B4(var_4._id_6BE3, var_0);
        var_10 = var_16._id_1883;
        _id_18B3(var_0, var_9, var_10, undefined, undefined, undefined, var_4._id_DD6E, var_4._id_DD6D);
      } else {
        thread _id_1072C(var_0, var_4);
        var_0 _id_08DF::_id_5798();
      }

      if(var_15) {
        var_0 waittill("hoverunload_done");
      }
    }

    if(isDefined(var_0._id_B73E) && isDefined(var_4._id_B49D)) {
      level.player thread scripts\engine\utility::_id_E8B5(var_4._id_B49D);
    }

    if(isDefined(var_4._id_6BEF)) {
      var_0 thread scripts\engine\utility::_id_E8B5(var_4._id_6BEF);
    }

    if(isDefined(var_0._id_B73E) && isDefined(var_4._id_B49C)) {
      level.player thread scripts\engine\utility::_id_CD61("playsound_on_entity", var_4._id_B49C);
    }
  } else if(!isai(var_0)) {
    if(istrue(var_0._id_4F7B)) {
      var_0 delete();
      return;
    }

    var_0 = scripts\engine\utility::_id_CD61("spawner_makerealai", var_0);
  }

  self._id_C835 = scripts\engine\utility::array_remove(self._id_C835, var_0);
  self._id_FE56[var_1] = 0;
  var_0._id_C83B = undefined;
  var_0._id_4F6E = undefined;

  if(!isalive(self) && !isDefined(var_4._id_F975)) {
    var_0 delete();
    return;
  }

  if(!getdvarint("#x32923f011fc14a85b")) {
    var_0 unlink();
  }

  if(!isDefined(var_0._id_992D)) {
    var_0._id_0040 = 1;
  }

  if(isalive(var_0) || var_3) {
    if(isai(var_0)) {
      var_0._id_0DDF._id_4AC4 = !var_0 _meth_81BA();
    }

    var_0._id_5E8A = undefined;

    if(isai(var_0)) {
      if(isDefined(var_4._id_6BF8)) {
        var_0._id_4812 = var_4._id_6BF8;
        var_0 _meth_800D("crouch");
        var_0 thread scripts\engine\utility::_id_CD61("anim_updateanimpose");
        var_0 _meth_800D("stand", "crouch", "prone");
      }

      var_0 _meth_8285(0);
    } else if(var_3) {
      var_0._id_106B8.origin = var_0.origin;
      var_0._id_106B8.angles = var_0.angles;

      if(isDefined(var_0._id_106B8.target)) {
        var_0._id_106B8 scripts\common\vehicle::_id_E239();
      } else {
        var_17 = var_0._id_106B8 scripts\common\utility::_id_E235();
      }

      var_0 delete();
    }

    if(!getdvarint("#x32923f011fc14a85b")) {
      var_0 notify("jumpedout");
    }
  }

  if(isDefined(var_0._id_039B) && var_0._id_039B == "delete_after_unload") {
    var_0 delete();
    return;
  }

  if(isDefined(var_4._id_6BE4) && var_4._id_6BE4) {
    var_0 delete();
    return;
  }

  var_0 _id_7326();
}

_id_733B(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self gettagorigin(var_1);
  var_6 = self gettagangles(var_1);
  var_7 = getstartorigin(var_5, var_6, var_2);
  var_8 = _func_00D2(var_5, var_6, var_2);
  var_9 = _func_00B0(var_2, 0, 1);
  var_10 = scripts\engine\utility::spawn_tag_origin();
  var_10.origin = var_7;
  var_10.angles = var_8;
  var_11 = var_10 _meth_8216(var_9);
  var_10 thread scripts\engine\utility::_id_4736("movedone");
  var_12 = var_11;
  var_13 = scripts\common\utility::groundpos(var_12);
  var_14 = getstartorigin(var_5, var_6, var_4);
  var_9 = _func_00B0(var_4, 0, 1);
  var_15 = var_14 + var_9;
  var_16 = var_14[2] - var_15[2];
  var_17 = var_13 + (0, 0, var_16);
  var_0._id_0040 = 0;
  var_0 setCanDamage(0);
  var_0 endon("death");
  wait(_func_0079(var_2) - 0.1);
  var_0 unlink();
  var_0 notify("animontag_thread");
  var_0 _meth_83EC();
  var_10.origin = var_0.origin;
  var_10.angles = var_0.angles;
  var_10 dontinterpolate();
  var_0 dontinterpolate();
  var_0 linkto(var_10, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_0._id_0040 = 1;
  var_0 setCanDamage(1);
  var_0._id_F971 = var_3;

  if(isai(var_0)) {
    var_0 scripts\engine\utility::_id_CD61("asm_animcustom", ::_id_732B, ::_id_732C);
  } else {
    var_0 thread _id_732B();
  }

  var_18 = length((0, 0, var_17[2]) - (0, 0, var_12[2]));
  var_19 = 350;
  var_20 = var_18 / var_19;
  var_10 moveto(var_17, var_20);
  var_10 waittill("movedone");
  var_0 unlink();
  var_0 _meth_801B("dropship_land", var_0.origin, var_0.angles, var_4);
  wait(_func_0079(var_4));
  var_0 notify("hoverunload_done");
  var_0 notify("anim_on_tag_done");
}

_id_732B() {
  if(isai(self)) {
    if(scripts\engine\utility::_id_0F78()) {
      self _meth_8251("face angle 3d", self.angles);
    } else {
      self _meth_8251("face angle", self.angles[1]);
    }

    self _meth_8019("zonly_physics", 1);
    self _meth_8077(_id_0009::_id_1C5E(), 0.2);
  }

  self _meth_82D9(self._id_F971, 1);
  self waittill("dropship_land");
}

_id_732C() {}

_id_7331(var_0) {
  if(isDefined(var_0._id_CD01)) {
    return 0;
  }

  if(istrue(var_0 scripts\engine\utility::_id_CD61("ai_has_color"))) {
    return 0;
  }

  if(isDefined(var_0._id_BE92)) {
    return 0;
  }

  if(!isDefined(var_0.target)) {
    return 1;
  }

  var_1 = _func_00B3(var_0.target, "targetname");
  var_2 = scripts\engine\utility::getstructarray(var_0.target, "targetname");

  if(var_1.size > 0 || var_2.size > 0) {
    return 0;
  }

  var_3 = getent(var_0.target, "targetname");

  if(isDefined(var_3) && var_3.classname == "info_volume") {
    return 0;
  }

  return 1;
}

_id_18B3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_0 notify("animontag_thread");
  var_0 endon("animontag_thread");

  if(!isDefined(var_6)) {
    var_6 = (0, 0, 0);
  }

  if(!isDefined(var_7)) {
    var_7 = (0, 0, 0);
  }

  if(!isDefined(var_5)) {
    var_5 = "animontagdone";
  }

  if(isDefined(self._id_9FD8)) {
    var_8 = self._id_9FD8;
  } else {
    var_8 = self;
  }

  if(!isDefined(var_1) || !scripts\engine\utility::hastag(var_8.model, var_1)) {
    var_9 = var_0.origin;
    var_10 = var_0.angles;
  } else {
    var_9 = var_8 gettagorigin(var_1);
    var_10 = var_8 gettagangles(var_1) + var_7;
    var_11 = anglestoaxis(var_10);
    var_12 = ["forward", "right", "up"];

    for(var_13 = 0; var_13 < var_11.size; var_13++) {
      var_9 = var_9 + var_11[var_12[var_13]] * var_6[var_13];
    }
  }

  if(isDefined(var_0._id_BF4D) && !isDefined(var_0._id_A539)) {
    level thread _id_18B4(var_0, self);
  }

  if(!scripts\common\utility::issp()) {
    var_0 dontinterpolate();

    if(isai(var_0)) {
      var_14 = var_0 _id_0009::_id_1C7D("animscripted", var_2);
      var_15 = var_0 _id_0009::_id_1C6E("animscripted", var_14);
      var_16 = getstartorigin(self.origin, self.angles, var_15);
      var_17 = _func_00D2(self.origin, self.angles, var_15);
      var_0 _meth_80F9(var_16, var_17);
      var_0 _meth_8019("nogravity");
      var_0 _meth_85ED("animscripted", var_14);
    }
  } else
    var_0 _meth_801B(var_5, var_9, var_10, var_2);

  if(isai(var_0)) {
    thread _id_4D62(var_0, var_8, var_5);
  }

  if(isDefined(var_0._id_17BA)) {
    var_0._id_17BA = undefined;
    var_18 = _func_0079(var_2) - 0.25;

    if(var_18 > 0) {
      wait(var_18);
    }

    if(getdvarint("#x33653c64282de1d70", 0) == 1) {
      var_0 _meth_83EC();
    }

    var_0._id_023F = 0;
    var_0 thread _id_C155();
  } else {
    if(isDefined(var_3)) {
      for(var_13 = 0; var_13 < var_3.size; var_13++) {
        var_0 waittillmatch(var_5, var_3[var_13]);
        var_0 thread[[var_4[var_13]]]();
      }
    }

    var_0 waittillmatch(var_5, "end");
  }

  var_0 notify("anim_on_tag_done");
  var_0._id_BF4D = undefined;
}

_id_C155() {
  self endon("death");
  wait 2;

  if(self._id_023F == 0) {
    self._id_023F = 80;
  }
}

_id_18B4(var_0, var_1) {
  if(isDefined(var_0._id_992D) && var_0._id_992D) {
    return;
  }
  if(!isai(var_0)) {
    var_0 setCanDamage(1);
  }

  var_0 endon("anim_on_tag_done");
  var_2 = undefined;
  var_3 = undefined;
  var_4 = var_1.health <= 0;

  for(;;) {
    if(!var_4 && !(isDefined(var_1) && var_1.health > 0)) {
      break;
    }

    var_0 waittill("damage", var_2, var_3);

    if(isDefined(var_0._id_5EA3)) {
      break;
    }

    if(!isDefined(var_2)) {
      continue;
    }
    if(var_2 < 1) {
      continue;
    }
    if(!isDefined(var_3)) {
      continue;
    }
    if(isPlayer(var_3)) {
      break;
    }
  }

  if(!isalive(var_0)) {
    return;
  }
  thread _id_18B5(var_0, var_1, var_3);
}

_id_18B5(var_0, var_1, var_2) {
  var_0._id_43D3 = undefined;
  var_0._id_43E6 = undefined;
  var_0._id_17B4 = 1;

  if(isDefined(var_0._id_BF4A)) {
    var_3 = _func_00B0(var_0._id_BF4A, 0, 1);
    var_4 = _func_0198(var_0.origin + (0, 0, 16), var_0.origin - (0, 0, 10000));
    var_5 = distance(var_0.origin + (0, 0, 16), var_4);

    if(abs(var_3[2] + 16) <= abs(var_5)) {
      var_0 thread scripts\engine\utility::_id_CD61("playsound_on_entity", "generic_death_falling");
      var_0 _meth_801B("fastrope_fall", var_0.origin, var_0.angles, var_0._id_BF4A);
      var_0 waittillmatch("fastrope_fall", "start_ragdoll");
    }
  }

  if(!isDefined(var_0)) {
    return;
  }
  var_0._id_43D3 = undefined;
  var_0._id_43E6 = undefined;
  var_0._id_17B4 = 1;
  var_0 notify("rope_death", var_2);
  var_0 _meth_81FA(var_2.origin, var_2);

  if(isDefined(var_0._id_CE6A)) {
    var_0 notsolid();
    var_6 = getweaponmodel(var_0._id_04F6);
    var_7 = var_0._id_04F6;

    if(isDefined(var_6)) {
      var_0 detach(var_6, "tag_weapon_right");
      var_8 = var_0 gettagorigin("tag_weapon_right");
      var_9 = var_0 gettagangles("tag_weapon_right");
      level._id_7290 = spawn("weapon_" + getcompleteweaponname(var_7), (0, 0, 0));
      level._id_7290.angles = var_9;
      level._id_7290.origin = var_8;
    }
  } else
    var_0 scripts\engine\utility::_id_CD61("anim_dropallaiweapons");

  if(isDefined(var_0._id_5DB5)) {
    var_0[[var_0._id_5DB5]]();
  }

  var_0 startragdoll();
}

_id_4D62(var_0, var_1, var_2) {
  var_0 endon("idle");
  var_0 endon("newanim");
  var_1 endon("death");
  var_0 endon("death");
  var_0 scripts\engine\utility::_id_CD61("anim_donotetracks", var_2);
}

_id_1880(var_0, var_1, var_2, var_3) {
  var_0 _meth_801B("movetospot", var_1, var_2, var_3);
  var_0 waittillmatch("movetospot", "end");
}

_id_733E(var_0, var_1) {
  if(!isalive(var_0)) {
    return;
  }
  if(isDefined(self._id_A52F)) {
    return;
  }
  var_2 = _id_1801(self, var_0._id_10238);

  if(isDefined(var_2._id_57D4)) {
    return _id_7325(var_0);
  }

  var_3 = _id_06E9::_id_6810();

  if(isDefined(level.vehicle._id_F078._id_C832) && isDefined(level.vehicle._id_F078._id_C832[var_3])) {
    self[[level.vehicle._id_F078._id_C832[var_3]]]();
    return;
  }

  if(isDefined(var_2._id_F975) && isDefined(self)) {
    if(isDefined(self._id_4DB7) && self._id_4DB7) {
      return;
    }
    thread _id_732E(var_0, var_0._id_10238, 1);
    wait(var_2._id_F975);

    if(isDefined(var_0) && isDefined(self)) {
      self._id_7227 = var_0._id_10238;
      _id_1877("unload");
    }

    return;
  }

  if(isDefined(var_0)) {
    if(isDefined(var_0._id_BF4D)) {
      return;
    }
    var_0 delete();
  }
}

_id_12FE() {
  self endon("death");
  self waittill("loaded");
  _id_06EB::_id_70E1(self);
}

_id_D35B(var_0, var_1) {
  var_2 = var_0._id_CE67;

  if(isDefined(var_0._id_5E8A)) {
    if(istrue(var_1[var_0._id_5E8A].is_script_filled)) {
      if(isDefined(var_0._id_0481)) {} else {}
    }

    var_2 = var_0._id_5E8A;
  }

  if(isDefined(var_2)) {
    return var_2;
  }

  for(var_3 = 0; var_3 < self._id_FE56.size; var_3++) {
    if(istrue(var_1[var_3].is_script_filled)) {
      continue;
    }
    if(self._id_FE56[var_3]) {
      continue;
    }
    if(isDefined(var_0._id_8AF5) && !isDefined(var_1[var_3]._id_8AF5)) {
      continue;
    }
    if(!isDefined(var_0._id_8AF5) && isDefined(var_1[var_3]._id_8AF5)) {
      continue;
    }
    return var_3;
  }

  if(isDefined(var_0._id_8AF5) && var_0._id_8AF5) {
    return;
  }
  return;
}

_id_732F(var_0, var_1, var_2) {
  var_3 = _id_1801(self, var_1);
  var_4 = self._id_9E6C[var_3._id_9E6C];

  if(!isalive(var_0)) {
    return;
  }
  var_4 endon("death");
  var_0 endon("death");

  if(isDefined(var_2) && var_2 && isDefined(var_3._id_AE9B)) {
    [[var_3._id_AE9B]](self, var_0, var_1, var_4);
  }

  _id_06E9::_id_D3FA(var_4);
  var_0 endon("guy_man_turret_stop");
  level thread _id_06E9::_id_102CD(var_4, scripts\common\utility::_id_69DE());
  var_4 scripts\engine\utility::_id_D07A("setturretignoregoals", 1);
  var_5 = "stand";

  if(isDefined(var_3._id_F894)) {
    var_5 = var_3._id_F894;
  }

  var_0 scripts\engine\utility::_id_CD61("use_turret", var_4, var_5);
}

_id_7339(var_0) {
  var_0 endon("jumpedout");
  var_0 waittill("death");

  if(isDefined(var_0)) {
    var_0 unlink();
  }
}

_id_7325(var_0) {
  if(!isDefined(var_0._id_10238)) {
    return;
  }
  var_1 = var_0._id_10238;
  var_2 = _id_1801(self, var_1);

  if(!isDefined(var_2._id_57D4)) {
    return;
  }
  var_0._id_43D3 = var_2._id_57D4;
  var_3 = self.angles;
  var_4 = var_0.origin;

  if(isDefined(var_2._id_57D5)) {
    var_4 = var_4 + anglesToForward(var_3) * var_2._id_57D5[0];
    var_4 = var_4 + anglestoright(var_3) * var_2._id_57D5[1];
    var_4 = var_4 + anglestoup(var_3) * var_2._id_57D5[2];
  }

  var_0 = _id_3C79(var_0);
  _id_4887(var_0, "weapon_");
  var_0 notsolid();
  var_0.origin = var_4;
  var_0.angles = var_3;
  var_0 _meth_801B("deathanim", var_4, var_3, var_2._id_57D4);
  var_5 = 0.3;

  if(isDefined(var_2._id_57D6)) {
    var_5 = var_2._id_57D6;
  }

  var_6 = _func_0079(var_2._id_57D4);
  var_7 = gettime() + var_6 * 1000;
  wait(var_6 * var_5);
  var_8 = (0, 0, 1);
  var_9 = var_0.origin;

  if(getDvar("#x3d09b29fde9b01bc7") == "0") {
    var_0 delete();
    return;
  }

  if(isai(var_0)) {
    var_0 scripts\engine\utility::_id_CD61("anim_dropallaiweapons");
  } else {
    _id_4887(var_0, "weapon_");
  }

  while(!var_0 _meth_81DF() && gettime() < var_7) {
    var_9 = var_0.origin;
    wait 0.05;
    var_8 = var_0.origin - var_9;

    if(isDefined(var_0._id_5DB5)) {
      var_0[[var_0._id_5DB5]]();
    }

    var_0 startragdoll();
  }

  wait 0.05;
  var_8 = var_8 * 20000;

  for(var_10 = 0; var_10 < 3; var_10++) {
    if(isDefined(var_0)) {
      var_9 = var_0.origin;
    }

    wait 0.05;
  }

  if(!var_0 _meth_81DF()) {
    var_0 delete();
  }
}

_id_3C79(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = spawn("script_model", var_0.origin);
  var_2.angles = var_0.angles;
  var_2 setModel(var_0.model);
  var_3 = var_0 _meth_8117();

  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_2 attach(var_0 _meth_8115(var_4), var_0 _meth_8118(var_4));
  }

  var_2 useanimtree(#animtree);

  if(isDefined(var_0.team)) {
    var_2.team = var_0.team;
  }

  if(!var_1) {
    var_0 delete();
  }

  var_2 scripts\engine\utility::_id_D07A("makefakeai");
  return var_2;
}

_id_FFFE(var_0, var_1) {
  self useanimtree(var_1);
  self _meth_82D9(var_0);
}

_id_100C0(var_0, var_1) {
  var_2 = _id_1801(self, var_0);
  return _id_100B5(var_2._id_6AB3, var_2._id_DD6C, var_0, var_2._id_31D4, var_1, var_2._id_86B9);
}

_id_100B5(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_8 = var_2;
  var_9 = undefined;
  var_10 = undefined;

  if(isDefined(var_5) && var_5) {
    var_11 = _id_67EC(self, var_2);
    var_12 = var_11 gettagorigin(var_1);
    var_13 = var_11 gettagangles(var_1);
  } else {
    var_12 = self gettagorigin(var_1);
    var_13 = self gettagangles(var_1);
  }

  if(isDefined(var_4) && getdvarint("#x32923f011fc14a85b") && !isDefined(var_0)) {
    var_14 = self._id_102EA;

    if(istrue(var_6) && _func_031B(self._id_102EB)) {
      var_14 = self._id_102EB;
    }

    var_15 = _id_0009::_id_1C59(var_14, "get_in_vehicle", var_2, 1);
    var_16 = getfirstarraykey(var_15);
    var_0 = var_15[var_16];

    if(var_15.size >= 2) {
      [var_0, var_18, var_19, var_8] = _id_106AE(var_1, var_5, var_2, var_4, var_15);
    } else {
      var_8 = var_16;
    }
  }

  if(!getdvarint("#x32923f011fc14a85b") || isDefined(var_0)) {
    var_9 = getstartorigin(var_12, var_13, var_0);
    var_10 = _func_00D2(var_12, var_13, var_0);
  } else {
    var_9 = var_12;
    var_10 = var_13;
  }

  var_7.origin = var_9;
  var_7.angles = var_10;
  var_7._id_1883 = var_0;
  var_7._id_10238 = var_2;
  var_7._id_31D4 = var_3;
  var_7._id_36ED = var_8;
  return var_7;
}

_id_100C2(var_0, var_1) {
  var_2 = _id_1801(self, var_0._id_10238);
  return _id_100B4(var_2, var_0, var_1);
}

_id_100B4(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = undefined;
  var_6 = spawnStruct();

  if(!getdvarint("#x32923f011fc14a85b")) {
    if(_func_0107(var_0._id_6BE3)) {
      var_4 = var_0._id_6BE3;
    } else {
      var_4 = [var_0._id_6BE3];
    }
  } else {
    var_7 = self._id_102EA;

    if(istrue(var_3) && _func_031B(self._id_102EB)) {
      var_7 = self._id_102EB;
    }

    var_4 = _id_0009::_id_1C59(var_7, var_2, var_1._id_10238, 1);
  }

  var_8 = getfirstarraykey(var_4);
  var_9 = var_4[var_8];

  if(var_4.size >= 2) {
    if(isPlayer(var_1)) {
      [var_9, var_11, var_12, var_5] = _id_638E(var_0._id_DD6C, var_1._id_10238, var_1.origin, var_4, undefined, undefined);
    } else {
      var_13 = var_1 _id_64C9();
      var_14 = 1;
      var_15 = var_1._id_C83B _id_67FE(var_14);
      [var_9, var_11, var_12, var_5] = _id_106AD(var_0._id_DD6C, var_0._id_86B9, var_1._id_10238, var_13, var_4, undefined, undefined, var_15);
    }
  } else
    var_5 = getfirstarraykey(var_4);

  var_6._id_36EE = var_5;
  var_6._id_36EC = var_9;
  return var_6;
}

_id_8684(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    return 1;
  }

  var_3 = var_0 _id_06E9::_id_6810();
  var_4 = level.vehicle._id_F078._id_F97C[var_3][var_2];

  foreach(var_6 in var_4) {
    if(var_6 == var_1) {
      return 1;
    }
  }

  return 0;
}

_id_637E(var_0) {
  var_1 = level.vehicle._id_F078._id_1306[_id_06E9::_id_6810()];
  var_2 = [];
  var_3 = [];

  for(var_4 = 0; var_4 < self._id_FE56.size; var_4++) {
    if(istrue(var_1[var_4].is_script_filled)) {
      continue;
    }
    if(self._id_FE56[var_4]) {
      continue;
    }
    if((getdvarint("#x32923f011fc14a85b") || isDefined(var_1[var_4]._id_6AB3)) && _id_8684(self, var_4, var_0)) {
      var_2[var_2.size] = var_4;
      continue;
    }

    var_3[var_3.size] = var_4;
  }

  var_5 = spawnStruct();
  var_5._id_1F93 = var_2;
  var_5._id_A5AA = var_3;
  return var_5;
}

_id_68C2() {
  if(isDefined(self._id_9FD8)) {
    return self._id_9FD8;
  } else {
    return self;
  }
}

_id_4887(var_0, var_1) {
  var_2 = var_0 _meth_8117();
  var_3 = [];
  var_4 = [];
  var_5 = 0;

  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_7 = var_0 _meth_8115(var_6);
    var_8 = var_0 _meth_8118(var_6);

    if(issubstr(var_7, var_1)) {
      var_3[var_5] = var_7;
      var_4[var_5] = var_8;
    }
  }

  for(var_6 = 0; var_6 < var_3.size; var_6++) {
    var_0 detach(var_3[var_6], var_4[var_6]);
  }
}

_id_DAA7() {
  if(!isai(self)) {
    return 0;
  }

  if(!isDefined(self._id_AC68)) {
    return 0;
  }

  return !isDefined(self._id_992D);
}

_id_E4ED(var_0) {
  self waittill("stable_for_unlink");

  if(isalive(var_0)) {
    var_0 unlink();
  }
}

_id_1877(var_0) {
  var_1 = [];

  foreach(var_3 in self._id_C835) {
    if(isai(var_3) && !isalive(var_3)) {
      continue;
    }
    if(isDefined(level.vehicle._id_1305[var_0]) && ![[level.vehicle._id_1305[var_0]]](var_3, var_3._id_10238)) {
      continue;
    }
    if(isDefined(level.vehicle._id_1307[var_0])) {
      var_3 notify("newanim");
      thread[[level.vehicle._id_1307[var_0]]](var_3, var_3._id_10238);
      var_1[var_1.size] = var_3;
      continue;
    }
  }

  return var_1;
}

_id_7326() {
  self._id_100DC = undefined;
  self._id_E58A = undefined;
  self._id_10238 = undefined;
  self._id_4649 = undefined;
}

_id_100B6(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    var_5 = _id_1801(self, var_4);
    var_6 = undefined;

    if(getdvarint("#x32923f011fc14a85b")) {
      var_6 = _id_0009::_id_1C59(self._id_102EA, "get_in_vehicle", var_4, 1);
    } else {
      var_6 = var_5._id_6AB3;
    }

    if(_func_0107(var_6)) {
      [var_8, var_9] = _id_106AE(var_5._id_DD6C, var_5._id_86B9, var_4, var_1, var_6, var_5._id_100BC);
      var_2[var_4] = _id_100B5(var_8, var_5._id_DD6C, var_4, var_5._id_31D4, var_1, var_5._id_86B9);
      continue;
    }

    var_2[var_4] = _id_100B5(var_6, var_5._id_DD6C, var_4, var_5._id_31D4, var_1, var_5._id_86B9);
  }

  var_11 = scripts\engine\utility::_id_6969(var_1, var_2);
  return var_11;
}

_id_638E(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!_func_0107(var_3)) {
    return [var_3, var_4, var_5];
  }

  if(isDefined(self.forced_player_dismount_direction)) {
    var_6 = var_1;

    if(self.forced_player_dismount_direction == "left") {
      var_6 = var_1 + "_left";
    } else if(self.forced_player_dismount_direction == "right") {
      var_6 = var_1 + "_right";
    }

    var_7 = var_3[var_6];
    var_8 = _id_6639(var_6, var_4);
    var_9 = _id_6639(var_6, var_5);
    return [var_7, var_8, var_9, var_6, -1.0];
  }

  var_10 = level.player getnormalizedmovement();

  if(abs(var_10[0]) < 0.2 && abs(var_10[1]) < 0.2) {
    var_11 = getfirstarraykey(var_3);
    var_12 = var_3[var_11];
    var_8 = _id_6639(var_11, var_4);
    var_13 = _id_6639(var_11, var_5);
    return [var_12, var_8, var_13, var_11, -1.0];
  } else {
    var_14 = var_10 * 100;
    var_15 = rotatevector((var_14[0], -1.0 * var_14[1], 0.0), level.player.angles);
    var_16 = self gettagorigin(var_0);
    return _id_6388(var_0, var_1, var_15 + var_16, var_3, var_4, var_5, "ANIMATION_LASTFRAME_THATS_CLOSEST_TO_TESTPOS");
  }
}

_id_638D(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_6)) {
    var_6 = "ANIMATION_LASTFRAME_THATS_CLOSEST_TO_TESTPOS";
  }

  return _id_6388(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

_id_106AD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = self;

  if(isDefined(var_1) && var_1 && isDefined(self._id_9E6C)) {
    var_8 = _id_67EC(self, var_2);
  }

  return var_8 _id_6388(var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

_id_6392(var_0, var_1, var_2, var_3, var_4, var_5) {
  return _id_6388(var_0, var_1, var_2, var_3, var_4, var_5, "ANIMATION_FIRSTFRAME_THATS_CLOSEST_TO_TESTPOS");
}

_id_106AE(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = self;

  if(isDefined(var_1) && var_1 && isDefined(self._id_9E6C)) {
    var_7 = _id_67EC(self, var_2);
  }

  return var_7 _id_6388(var_0, var_2, var_3, var_4, var_5, var_6, "ANIMATION_FIRSTFRAME_THATS_CLOSEST_TO_TESTPOS");
}

_id_106AC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = self;

  if(isDefined(var_1) && var_1 && isDefined(self._id_9E6C)) {
    var_8 = _id_67EC(self, var_2);
  }

  return var_8 _id_6388(var_0, var_2, var_3, var_4, var_5, var_6, var_7);
}

_id_6388(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = self.origin;
  var_12 = self.angles;

  if(var_0 != "TAG_ORIGIN") {
    var_11 = self gettagorigin(var_0);
    var_12 = self gettagangles(var_0);
  }

  if(!_func_0107(var_3)) {
    return [var_3, var_4, var_5];
  }

  foreach(var_17, var_14 in var_3) {
    if(isDefined(var_14)) {
      switch (var_6) {
        case "ANIMATION_FIRSTFRAME_THATS_FARTHEST_FROM_TESTPOS":
        case "ANIMATION_FIRSTFRAME_THATS_CLOSEST_TO_TESTPOS":
          var_10 = getstartorigin(var_11, var_12, var_14);
          break;
        case "ANIMATION_LASTFRAME_THATS_FARTHEST_FROM_TESTPOS":
        case "ANIMATION_LASTFRAME_THATS_CLOSEST_TO_TESTPOS":
          var_15 = _func_008E(var_12, var_14);
          var_10 = var_11 + var_15;
          break;
        default:
      }

      var_16 = distance2dsquared(var_10, var_2);

      switch (var_6) {
        case "ANIMATION_FIRSTFRAME_THATS_CLOSEST_TO_TESTPOS":
        case "ANIMATION_LASTFRAME_THATS_CLOSEST_TO_TESTPOS":
          if(!isDefined(var_7) || var_16 < var_7) {
            var_7 = var_16;
            var_8 = var_17;
            var_9 = var_10;
          }

          break;
        case "ANIMATION_LASTFRAME_THATS_FARTHEST_FROM_TESTPOS":
        case "ANIMATION_FIRSTFRAME_THATS_FARTHEST_FROM_TESTPOS":
          if(!isDefined(var_7) || var_16 > var_7) {
            var_7 = var_16;
            var_8 = var_17;
            var_9 = var_10;
          }

          break;
        default:
      }
    }
  }

  var_18 = var_3[var_8];
  var_19 = _id_6639(var_8, var_4);
  var_20 = _id_6639(var_8, var_5);
  return [var_18, var_19, var_20, var_8, var_7];
}

_id_6639(var_0, var_1) {
  var_2 = undefined;

  if(_func_0107(var_1)) {
    if(var_1.size == 0) {
      return undefined;
    }

    if(_func_0121(var_0) && var_0 == "first_array_item") {
      var_2 = var_1[getfirstarraykey(var_1)];
    } else if(isDefined(var_1[var_0])) {
      var_2 = var_1[var_0];
    } else if(isDefined(var_1[scripts\engine\utility::_id_EA52(var_0)])) {
      var_2 = var_1[scripts\engine\utility::_id_EA52(var_0)];
    } else {
      var_2 = var_1[getfirstarraykey(var_1)];
    }
  } else
    var_2 = var_1;

  return var_2;
}

_id_67ED(var_0, var_1) {
  return var_0._id_9E6C[var_1];
}

_id_67EC(var_0, var_1) {
  if(!isDefined(var_0._id_9E6C)) {
    return undefined;
  }

  if(!isDefined(level.vehicle._id_F078._id_1306[var_0.classname])) {
    return undefined;
  }

  var_2 = level.vehicle._id_F078._id_1306[var_0.classname][var_1];

  if(isDefined(var_2) && isDefined(var_2._id_9E6C)) {
    return _id_67ED(var_0, var_2._id_9E6C);
  }

  if(isDefined(level._id_10233) && isDefined(level._id_10233[var_0.classname])) {
    var_2 = level._id_10233[var_0.classname][var_1];

    if(isDefined(var_2) && isDefined(var_2._id_83B5) && var_2._id_83B5 == "turret") {
      return var_0._id_9E6C[0];
    }
  }
}

_id_66B5(var_0, var_1) {
  if(isDefined(var_0._id_9E6C)) {
    foreach(var_4, var_3 in var_0._id_9E6C) {
      if(var_3 == var_1) {
        return _id_66B6(var_0, var_4);
      }
    }
  }
}

_id_66B6(var_0, var_1) {
  if(isDefined(level.vehicle._id_F078._id_1306) && _func_0107(level.vehicle._id_F078._id_1306)) {
    var_2 = level.vehicle._id_F078._id_1306[var_0.classname];

    if(isDefined(var_2) && _func_0107(var_2)) {
      foreach(var_5, var_4 in level.vehicle._id_F078._id_1306[var_0.classname]) {
        if(isDefined(var_4._id_9E6C) && var_4._id_9E6C == var_1) {
          return var_5;
        }
      }
    }
  }

  if(isDefined(level._id_10233) && _func_0107(level._id_10233)) {
    var_6 = 0;
    var_7 = level._id_10233[var_0.classname];

    if(isDefined(var_7) && _func_0107(var_7)) {
      foreach(var_5, var_4 in level._id_10233[var_0.classname]) {
        if(isDefined(var_4._id_83B5) && var_4._id_83B5 == "turret") {
          if(var_6 == var_1) {
            return var_5;
          } else {
            var_6++;
          }
        }
      }
    }
  }
}

_id_64A5(var_0) {
  if(!isDefined(level.vehicle._id_F078._id_1306)) {
    return undefined;
  }

  if(!isDefined(level.vehicle._id_F078._id_1306[var_0])) {
    return undefined;
  }

  foreach(var_3, var_2 in level.vehicle._id_F078._id_1306[var_0]) {
    if(isDefined(var_2._id_9E6C)) {
      return var_3;
    }
  }
}

_id_633C(var_0) {
  var_1 = undefined;
  var_2 = [];

  if(_func_0107(var_0)) {
    var_1 = var_0;
  } else {
    var_1 = level.vehicle._id_F078._id_1306[var_0.classname];
  }

  foreach(var_5, var_4 in var_1) {
    if(isDefined(var_4._id_9E6C)) {
      var_2[var_2.size] = var_5;
    }
  }

  return var_2;
}

_id_680C(var_0, var_1) {
  return _id_680D(var_0, var_1, 1);
}

_id_680E(var_0, var_1) {
  return _id_680D(var_0, var_1, 0);
}

_id_680D(var_0, var_1, var_2) {
  var_3 = self.origin;
  var_4 = self.angles;
  var_5 = _id_1801(self, var_0);

  if(var_5._id_DD6C != "TAG_ORIGIN") {
    var_3 = self gettagorigin(var_5._id_DD6C);
    var_4 = self gettagangles(var_5._id_DD6C);
  }

  var_6 = _id_0009::_id_1C59(self._id_102EA, var_1, var_0, 1);
  var_7 = [];

  foreach(var_12, var_9 in var_6) {
    if(var_2) {
      var_10 = _func_008E(var_4, var_9);
      var_11 = var_3 + var_10;
    } else
      var_11 = getstartorigin(var_3, var_4, var_9);

    var_7[var_12] = var_11;
  }

  return var_7;
}

_id_64C9() {
  if(isDefined(self._id_4473)) {
    return self._id_4473;
  }

  if(scripts\common\utility::issp()) {
    return level.player.origin;
  } else {
    if(isDefined(self._id_0192) && isPlayer(self._id_0192)) {
      return self._id_0192.origin;
    }

    var_0 = self _meth_84C2();

    foreach(var_2 in var_0) {
      if(isPlayer(var_2)) {
        return var_2.origin;
      }
    }

    return level.players[0].origin;
  }
}

_id_67FE(var_0) {
  if(isDefined(var_0) && var_0) {
    return "ANIMATION_LASTFRAME_THATS_FARTHEST_FROM_TESTPOS";
  } else if(isDefined(self._id_F967)) {
    return "ANIMATION_LASTFRAME_THATS_FARTHEST_FROM_TESTPOS";
  }

  return "ANIMATION_LASTFRAME_THATS_CLOSEST_TO_TESTPOS";
}

_id_7400(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  if(_func_02DE(var_1)) {
    var_2 = var_1;
  } else {
    var_3 = var_1;
  }

  var_4 = 0;
  var_5 = 0;

  if(!istrue(self._id_0043)) {
    if(isDefined(var_2) && istrue(var_2._id_4A32)) {
      var_4 = 1;
      var_0 scripts\engine\utility::_id_4A32();
    }
  }

  if(!istrue(var_0._id_992D)) {
    if(istrue(var_3) || istrue(var_2._id_992D)) {
      var_5 = 1;
      var_0 _id_06C5::_id_992D();
    }
  }

  if(var_4 || var_5) {
    thread _id_C402(var_0, var_4, var_5);
  }
}