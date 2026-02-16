/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1769.gsc
*************************************************/

_id_100E3() {
  scripts\engine\utility::_id_5097("#x32923f011fc14a85b", 1);
  scripts\engine\utility::_id_5097("#x31f9ba2c1834330ea");
  setdvarifuninitialized("#x31c94c076faaeaed5", "-1");

  if(!isDefined(level.vehicle)) {
    level.vehicle = spawnStruct();
  }

  level.vehicle._id_F078 = spawnStruct();
  level.vehicle._id_7777 = getEntArray("helicopter_crash_location", "targetname");
  level.vehicle._id_7777 = scripts\engine\utility::array_combine(level.vehicle._id_7777, scripts\engine\utility::_id_6D9B("helicopter_crash_location", "targetname"));
  level.vehicle._id_F078.team = [];
  level.vehicle._id_F078._id_43F3 = [];
  level.vehicle._id_F078._id_43CF = [];
  level.vehicle._id_F078._id_4F5E = [];
  level.vehicle._id_F078._id_4F61 = [];
  level.vehicle._id_F078._id_C992 = [];
  level.vehicle._id_F078._id_997E = [];
  level.vehicle._id_F078._id_9E6C = [];
  level.vehicle._id_F078._id_43B2 = [];
  level.vehicle._id_F078._id_EBC9 = [];
  level.vehicle._id_F078._id_F97C = [];
  level.vehicle._id_F078._id_1306 = [];
  level.vehicle._id_F078._id_8E9B = [];
  level.vehicle._id_F078._id_572F = [];
  level.vehicle._id_F078._id_545C = [];
  level.vehicle._id_F078._id_DA15 = [];
  level.vehicle._id_F078._id_78CC = [];
  level.vehicle._id_F078._id_4871 = [];
  level.vehicle._id_F078._id_7150 = [];
  level.vehicle._id_F078._id_2D2B = [];
  level.vehicle._id_F078._id_43C4 = [];
  level.vehicle._id_F078._id_43AC = [];
  level.vehicle._id_F078._id_7CAA = [];
  level.vehicle._id_F078._id_7788 = [];
  level.vehicle._id_F078._id_13B5 = [];
  level.vehicle._id_F078._id_DD5E = [];
  level.vehicle._id_F078._id_43D4 = [];
  level.vehicle._id_F078._id_10082 = [];
  level.vehicle._id_F078._id_1024D = [];
  level.vehicle._id_F078._id_43C9 = [];
  level.vehicle._id_F078.model = [];
  level.vehicle._id_F078._id_BF17 = [];
  level.vehicle._id_F078._id_42DB = [];
  level.vehicle._id_F078.mainturret_jolt = [];
  level.vehicle._id_F078.mainturret_quake = [];
  level.vehicle._id_F078.mainturret_rumble = [];
}

_id_8897() {
  if(isDefined(self._id_8895)) {
    return 1;
  }

  if(!isDefined(self._id_04DE)) {
    return 0;
  }

  return isDefined(level.vehicle._id_F078._id_7788[self._id_04DE]);
}

_id_8741() {
  return isDefined(level.vehicle._id_F078._id_13B5[self._id_04DE]);
}

_id_10255() {
  if(!scripts\engine\utility::_id_0FE2("vehicle_vars", ::_id_10255)) {
    return;
  }
  scripts\engine\utility::_id_80CB();
  _id_100E3();
  _id_06E7::_id_D74D();
}

_id_10239() {
  var_0 = [];
  level._id_A40A = [];

  if(!isDefined(level._id_10313)) {
    level._id_10313 = [];
  }

  var_1 = getEntArray("script_vehicle", "code_classname");

  foreach(var_3 in var_1) {
    var_3._id_04DE = tolower(var_3._id_04DE);

    if(var_3._id_04DE == "empty" || var_3._id_04DE == "empty_heli") {
      continue;
    }
    var_0[var_0.size] = var_3;
    _id_1023A(var_3.classname, var_3);
  }

  if(level._id_A40A.size > 0) {
    var_5 = "";

    foreach(var_14, var_7 in level._id_A40A) {
      foreach(var_9 in var_7) {
        foreach(var_11 in var_9._id_C0CA) {}
      }
    }

    level waittill("never");
  }

  return var_0;
}

_id_1023A(var_0, var_1) {
  if(isDefined(level._id_10313[var_1._id_04DE]) && isDefined(level._id_10313[var_1._id_04DE][var_1.classname])) {
    return;
  }
  if(var_1.classname == "script_vehicle") {
    return;
  }
  var_2 = [];

  if(isDefined(level._id_A40A[var_0])) {
    var_2 = level._id_A40A[var_0];
  }

  var_3 = spawnStruct();
  var_3._id_B9FE = var_1.origin;
  var_3._id_C0CA = [];

  if(!isDefined(level._id_10313[var_1._id_04DE])) {
    var_3._id_C0CA[var_3._id_C0CA.size] = "vehicletype \"" + var_1._id_04DE + "\" is not setup properly. Maybe you just need to re-package? Or you have a Radiant copy/paste issue where you have the wrong vehicletype set?";
  } else if(!isDefined(level._id_10313[var_1._id_04DE][var_1.classname])) {
    var_3._id_C0CA[var_3._id_C0CA.size] = "classname \"" + var_1.classname + "\"is not setup properly. Maybe you just need to re-package? Or the vehicle's Quaked is not setup properly";
  }

  var_2[var_2.size] = var_3;
  level._id_A40A[var_0] = var_2;
}

_id_10256() {
  var_0 = _id_0C10();

  foreach(var_2 in var_0) {
    var_2 thread _id_10297();
  }
}

_id_10297() {
  self endon("entitydeleted");

  if(isDefined(self._id_CCF2)) {
    thread scripts\engine\utility::_id_CD61("vehicle_spawner_deathflag");
  }

  self._id_011A = 1;
  self._id_E143 = [];

  for(;;) {
    self waittill("spawned", var_0);
    self._id_011A--;

    if(!isDefined(var_0)) {
      continue;
    }
    var_0._id_E142 = self._id_E143;
    var_0._id_03E9 = self;
    var_0 thread scripts\engine\utility::_id_CD61("run_spawn_functions");
  }
}

_id_102CB(var_0) {
  var_0 waittill("trigger");

  foreach(var_2 in _func_0263()) {
    if(scripts\engine\utility::is_equal(var_2._id_CD95, var_0._id_CD95)) {
      var_2 delete();
    }
  }
}

_id_10292(var_0) {
  var_1 = [];
  var_2 = scripts\engine\utility::_id_5472("no_riders_until_unload") && scripts\engine\utility::_id_546E("no_riders_until_unload");

  foreach(var_4 in var_0) {
    var_4._id_011A = 1;
    var_5 = 0;

    if(isDefined(var_4._id_CD21)) {
      var_5 = 1;
      var_6 = scripts\engine\utility::_id_CD61("dronespawn_bodyonly", var_4);
      var_6 scripts\engine\utility::_id_CD61("drone_give_soul");
    } else if(isDefined(var_4._id_CD38) || isDefined(var_4._id_CCC3)) {
      var_5 = 1;
      var_6 = scripts\engine\utility::_id_CD61("bodyonlyspawn", var_4);
      var_6 scripts\engine\utility::_id_CD61("fakeactor_give_soul");
    } else
      var_6 = var_4 scripts\engine\utility::_id_CD61("spawn_ai", var_2);

    if(!var_5 && !isalive(var_6)) {
      continue;
    }
    var_1 = scripts\engine\utility::array_add(var_1, var_6);
  }

  var_8 = _id_10246(var_1);
  return var_8;
}

_id_10246(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!_id_12E0(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_12E0(var_0) {
  if(isalive(var_0)) {
    return 1;
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  if(!isDefined(var_0.classname)) {
    return 0;
  }

  return var_0.classname == "script_model";
}

_id_E1DB() {
  if(scripts\engine\utility::_id_5472("no_riders_until_unload") && !scripts\engine\utility::_id_546E("no_riders_until_unload")) {
    self notify("spawnedRiders");
    return [];
  }

  var_0 = _id_681A();

  if(!var_0.size) {
    self notify("spawnedRiders");
    return [];
  }

  var_1 = _id_E151(var_0);
  self notify("spawnedRiders", var_1);
  return var_1;
}

_id_E151(var_0) {
  var_1 = _id_10292(var_0);
  var_1 = _id_E023(var_1);

  foreach(var_3 in var_1) {
    thread _id_06E7::_id_732A(var_3);
  }

  thread _id_D27F(var_1);
  return var_1;
}

_id_D27F(var_0) {
  scripts\engine\utility::_id_1BE7(var_0, "loaded", 1);
  _id_06E7::_id_1013A(self);
}

_id_E233(var_0) {
  if(!isDefined(var_0)) {
    return _id_E1DB();
  }

  var_1 = _id_681A();

  if(!var_1.size) {
    return [];
  }

  var_2 = [];
  var_3 = _id_6810();

  if(isDefined(level.vehicle._id_F078._id_F97C[var_3]) && isDefined(level.vehicle._id_F078._id_F97C[var_3][var_0])) {
    var_4 = level.vehicle._id_F078._id_F97C[var_3][var_0];

    for(var_5 = 0; var_5 < var_4.size; var_5++) {
      if(isDefined(var_1[var_5])) {
        var_1[var_5]._id_CE67 = var_4[var_5];
      }
    }

    var_1 = _id_E023(var_1);

    foreach(var_7 in var_4) {
      foreach(var_9 in var_1) {
        if(var_9._id_CE67 == var_7) {
          var_2[var_2.size] = var_9;
        }
      }
    }

    var_12 = _id_10292(var_2);

    foreach(var_14 in var_12) {
      thread _id_06E7::_id_732A(var_14);
    }

    self notify("spawnedRiders", var_12);
    return var_12;
  } else
    return _id_E1DB();
}

_id_E023(var_0) {
  var_1 = [];
  var_2 = [];

  foreach(var_4 in var_0) {
    if(isDefined(var_4._id_CE67)) {
      var_1[var_1.size] = var_4;
      continue;
    }

    var_2[var_2.size] = var_4;
  }

  return scripts\engine\utility::array_combine(var_1, var_2);
}

_id_C45A() {
  waitframe();
  self._id_10294 = undefined;
}

_id_100E0(var_0) {
  var_1 = var_0 _id_6810();

  if(isDefined(level.vehicle._id_F078._id_78CC[var_1])) {
    foreach(var_3 in level.vehicle._id_F078._id_78CC[var_1]) {
      var_0 hidepart(var_3);
    }
  }

  if(var_0._id_04DE == "empty" || var_0._id_04DE == "empty_heli") {
    var_0 thread _id_06EB::_id_6BCF();
    return;
  }

  var_0 scripts\engine\utility::_id_D13A();
  var_5 = var_0._id_04DE;
  var_0 _id_10253();
  var_0 _id_10254();

  if(!isDefined(level._id_10313[var_0._id_04DE][var_1])) {}

  var_0 thread[[level._id_10313[var_0._id_04DE][var_1]]]();
  var_0 thread _id_10237();
  var_0 thread _id_10232();
  var_0 thread _id_100A0();

  if(!isDefined(var_0._id_CCB9)) {
    var_0._id_CCB9 = 0;
  }

  if(isDefined(level.vehicle._id_4F2E)) {
    if(level.vehicle._id_4F2E) {
      var_0 _meth_8407();
    }
  }

  var_0 scripts\engine\utility::_id_5473("unloaded");
  var_0 scripts\engine\utility::_id_5473("loaded");
  var_0 scripts\engine\utility::_id_5473("landed");
  var_0._id_C835 = [];
  var_0._id_F980 = [];
  var_0._id_F96A = "default";
  var_0._id_59C0 = [];

  if(isDefined(level.vehicle._id_F078._id_1D82) && isDefined(level.vehicle._id_F078._id_1D82[var_1])) {
    var_6 = level.vehicle._id_F078._id_1D82[var_1];
    var_7 = getarraykeys(var_6);

    foreach(var_9 in var_7) {
      var_0._id_59C0[var_9] = undefined;
      var_0._id_59C1[var_9] = 0;
    }
  }

  if(isDefined(var_0._id_CEAD)) {
    var_0 thread _id_06EA::_id_94A3(var_0._id_CEAD);
  }

  if(isDefined(var_0._id_CD78)) {
    var_0._id_7095 = 1;
  }

  var_0 thread _id_1007F();
  var_0 thread _id_06E7::_id_73E9();

  if(isDefined(var_0._id_CD5F)) {
    var_0 _meth_83A5(var_0._id_CD5F, &"");
  }

  var_0 thread _id_100D3();

  if(isDefined(var_0._id_CD1F)) {
    var_0._id_4DB8 = 1;
  }

  var_0 thread _id_1024E();

  if(!var_0 _meth_8434()) {
    var_0 thread scripts\engine\utility::_id_CD61("vehicle_treads");
  }

  var_0 thread _id_7CAC();
  var_0 thread _id_1876();

  if(isDefined(var_0._id_CCF2)) {
    var_0 thread scripts\engine\utility::_id_CD61("vehicle_deathflag");
  }

  var_0 thread _id_9983();
  var_0 thread _id_9E66();
  var_0 _id_F883();
  var_0 _id_73FB(self, 0);
  var_0 thread _id_E2B6();

  if(isDefined(level.vehicle._id_E0F0)) {
    level thread[[level.vehicle._id_E0F0]](var_0);
  }

  if(isDefined(var_0._id_CE7D)) {
    var_0 _meth_83A6(var_0._id_CE7D);
  }

  if(!istrue(self._id_4D9D)) {
    if(var_0 scripts\common\vehicle::_id_8896()) {
      var_0 thread _id_FFF6();
    } else {
      var_0 thread _id_FFF7();
    }
  }

  var_0 thread scripts\engine\utility::_id_CD61("vehicle_player_init");
  var_0 thread scripts\engine\utility::_id_CD61("player_enter_think");
  var_0 thread _id_06EB::_id_6BCF();

  if(isDefined(level._id_7D3A)) {
    var_11 = level._id_7D3A;
  } else {
    var_11 = 0;
  }

  if(scripts\common\utility::issp() && var_0 _id_100D6() && !var_11) {
    var_0 thread _id_136D();
  }

  if(var_0 _meth_8434()) {
    var_0._id_04D6 = "constrained";

    if(isDefined(var_0._id_CE19)) {
      var_0._id_04D6 = var_0._id_CE19;
    }
  }

  var_0 _id_E1DB();
  var_0 thread _id_1008B();
  var_0 thread _id_10212();
}

_id_6810() {
  if(isDefined(self._id_3804)) {
    return self._id_3804;
  }

  return self.classname;
}

#using_animtree("vehicles");

_id_10085() {
  self notify("stop_looping_death_fx");
  self notify("death_finished");
  _id_10244();
  _id_10245();
  _func_02AD("veh_" + self getentitynumber());

  if(isDefined(self._id_C9A2)) {
    self._id_C9A2 delete();
  }

  if(isDefined(self._id_9E6C)) {
    scripts\engine\utility::_id_1BA4(self._id_9E6C);
  }

  if(isDefined(self._id_997E)) {
    self._id_997E delete();
  }

  if(istrue(level.vehicle._id_F078._id_7500[self.model])) {
    self _meth_8088();
  }

  var_0 = _id_6810();

  if(isDefined(level.vehicle._id_F078._id_C992[var_0])) {
    if(isDefined(self.rumble_override)) {
      self _meth_83F4(self.rumble_override);
    } else {
      self _meth_83F4(level.vehicle._id_F078._id_C992[var_0]._id_C992);
    }
  }

  if(!scripts\common\utility::issp()) {
    return;
  }
  self useanimtree(#animtree);

  if(isDefined(level.vehicle._id_F078._id_4F5E[self.model])) {
    self _meth_8077(level.vehicle._id_F078._id_4F5E[self.model], 0);
  }

  if(isDefined(level.vehicle._id_F078._id_4F61[self.model])) {
    self _meth_8077(level.vehicle._id_F078._id_4F61[self.model], 0);
  }
}

_id_1008B() {
  self endon("entitydeleted");
  self endon("nodeath_thread");
  thread _id_7792();
  self waittill("death", var_0, var_1, var_2, var_3);

  if(isDefined(self.burningdownindicator)) {
    self.burningdownindicator delete();
  }

  _id_10086(var_0, var_1, var_2);
  _id_10231(var_0, var_1, var_3);
  thread _id_1012C();
  _id_10252();

  if(_id_1011F()) {
    self notify("vehicle_deathComplete", self.origin, self.angles);
  } else {
    _id_10085();
    self notify("vehicle_deathComplete", self.origin, self.angles);

    if(istrue(self._id_10263)) {
      if(scripts\common\utility::iscp()) {
        wait 0.1;
      }

      self delete();
      return;
    }

    self _meth_8101();
    _func_02B3(self);
  }
}

_id_10086(var_0, var_1, var_2) {
  if(isDefined(self._id_4236)) {
    self thread[[self._id_4236]]();
  }

  if(isDefined(level.vehicle._id_F078._id_43CF[self._id_04DE])) {
    thread[[level.vehicle._id_F078._id_43CF[self._id_04DE]]]();
  }

  var_3 = isDefined(var_0) && isDefined(var_1) && isDefined(var_2);

  if(var_3) {
    var_4 = getcompleteweaponname(var_2);
    var_0 scripts\engine\utility::_id_CD61("register_kill", self, var_1, var_4);
  }
}

_id_10120() {
  return istrue(self._id_102F4);
}

_id_1012C() {
  if(istrue(self._id_B0D7) && !istrue(self._id_F97D)) {
    self waittill("flavor_done");
  }

  foreach(var_1 in self._id_C835) {
    if(!isalive(var_1)) {
      continue;
    }
    if(!isDefined(var_1._id_C83B)) {
      continue;
    }
    if(isDefined(var_1._id_992D)) {
      var_1 _id_06C5::_id_E8B9();
    }

    if(isDefined(var_1._id_0B67) && isDefined(var_1._id_0B67._id_36F1) && istrue(var_1._id_0B67._id_36F1._id_43C2)) {
      var_2 = 100.0;
      var_3 = self _meth_8431();
      var_1._id_4C08 = 1;
      var_1._id_BF52 = "torso_lower";
      var_1._id_BF53 = (var_1.origin - self.origin) * var_2 + var_3;
    }

    if(scripts\common\utility::iscp() && isDefined(self._id_42BB)) {
      if(isDefined(self._id_42BB.attacker) && isPlayer(self._id_42BB.attacker)) {
        var_1 dodamage(self.maxhealth, self._id_42BB.attacker.origin, self._id_42BB.attacker, self._id_42BB.attacker);
      } else {
        var_1 _meth_81FA();
      }

      continue;
    }

    var_1 _meth_81FA();
  }
}

_id_1024B(var_0) {
  if(isDefined(self._id_10238) && self._id_10238 != 0) {
    return;
  }
  self.health = 1;
  var_0 endon("death");
  self._id_0087 = 0.15;
  self waittill("death");
  var_0 notify("driver_died");
  var_0 _id_1012C();
}

_id_10001() {
  self endon("death");
  self endon("enable_spline_path");
  waittillframeend;
  self._id_C835 = scripts\engine\utility::_id_1BCA(self._id_C835);

  if(self._id_C835.size) {
    scripts\engine\utility::_id_1BE2(self._id_C835, ::_id_1024B, self);
    scripts\engine\utility::_id_108C5("veh_collision", "driver_died");
    _id_1012C();
    wait 0.25;
  }

  self notify("script_crash_vehicle");
  self _meth_8444();
}

_id_0DBC(var_0, var_1) {
  self endon("death");
  self notify("newpath");

  if(!isDefined(var_0)) {
    var_0 = 2;
  }

  self setneargoalnotifydist(var_0);
  self sethoverparams(0, 0, 0);
  self _meth_807D();
  self _meth_838A(scripts\engine\utility::_id_5CD9(self.angles)[1]);

  if(isDefined(self._id_F970)) {
    _id_0CF6(scripts\common\utility::groundpos(self.origin) + (0, 0, self._id_F970), 1);
  } else {
    _id_0CF6(scripts\common\utility::groundpos(self.origin), 1);
  }

  self waittill("goal");
}

_id_1012E(var_0, var_1) {
  self endon("death");
  var_2 = _id_6810();

  if(!isDefined(level.vehicle._id_F078._id_8E9B[var_2])) {
    return;
  }
  var_3 = level.vehicle._id_F078._id_8E9B[var_2];

  foreach(var_5 in var_3) {
    self _meth_82D9(var_5._id_026C, 1, 0.2, 1);
  }

  if(!var_1) {
    return;
  }
  if(isDefined(var_0)) {
    self waittill("unloaded");
  } else {
    self waittill("continuepath");
  }

  foreach(var_5 in var_3) {
    self _meth_8077(var_5._id_026C, 0);
    self _meth_82D9(var_5._id_EDCC, 1, 0.2, 1);
  }
}

_id_1012F(var_0, var_1) {
  return _id_0DBC(var_0, var_1);
}

_id_E238(var_0) {
  var_1 = scripts\common\utility::_id_E235();

  if(isDefined(var_0)) {
    var_1 vehicle_setspeed(var_0);
  }

  var_1 thread _id_10001();
  var_1 endon("death");
  var_1._id_4DB8 = 1;
  var_1 _id_06EB::_id_70E1(var_1);
  var_1 _id_9165();
}

_id_9165() {
  self endon("script_crash_vehicle");
  scripts\engine\utility::_id_108C5("enable_spline_path", "reached_end_node");
  var_0 = _id_65C1(self.origin);

  if(isDefined(level._id_4F5A)) {
    var_0 thread[[level._id_4F5A]](self);
  }
}

_id_65C1(var_0) {
  var_0 = (var_0[0], var_0[1], 0);
  var_1 = scripts\engine\utility::_id_6369(var_0, level._id_DFD1);
  var_2 = [];

  for(var_3 = 0; var_3 < 3; var_3++) {
    var_2[var_3] = var_1[var_3];
  }

  foreach(var_5 in level._id_DFD1) {
    foreach(var_7 in var_2) {
      if(var_7 == var_5) {
        return var_7;
      }
    }
  }
}

_id_10926(var_0) {
  var_1 = 12;
  var_2 = 400;
  var_3 = gettime() + var_2;

  while(isDefined(self)) {
    if(abs(self.angles[0]) > var_1 || abs(self.angles[2]) > var_1) {
      var_3 = gettime() + var_2;
    }

    if(gettime() > var_3) {
      break;
    }

    wait 0.05;
  }
}

_id_0DC0(var_0) {
  var_1 = undefined;
  var_2 = 0;

  if(isDefined(var_0)) {
    if(isint(var_0)) {
      var_2 = var_0;
    } else {
      var_1 = var_0;
    }
  }

  self endon("death");

  if(isDefined(var_1)) {
    self._id_F96A = var_1;
  }

  if(scripts\engine\utility::_id_5472("no_riders_until_unload")) {
    scripts\engine\utility::_id_5474("no_riders_until_unload");
    var_3 = _id_E233(self._id_F96A);

    foreach(var_5 in var_3) {
      _id_06C5::_id_E137(var_5);
    }

    waittillframeend;
  }

  self notify("unloading");
  var_3 = [];
  var_7 = level.vehicle._id_F078._id_F97C[_id_6810()];

  if(isDefined(var_7)) {
    var_8 = _id_06E7::_id_67FC();

    if(istrue(self._id_1033A)) {
      for(var_9 = 0; var_9 < level.vehicle._id_F078._id_1306[_id_6810()].size; var_9++) {
        var_10 = level.vehicle._id_F078._id_1306[_id_6810()][var_9];

        if(istrue(var_10._id_D8AA)) {
          var_11 = 0;

          foreach(var_13 in self._id_C835) {
            if(istrue(var_2) || isDefined(var_8[var_13._id_10238]) && var_13._id_10238 != var_9) {
              var_14 = _id_06E7::_id_1801(self, var_13._id_10238);

              if(var_14._id_59C0 == var_10._id_59C0) {
                var_11 = 1;
                break;
              }
            }
          }

          if(var_11) {
            foreach(var_13 in self._id_C835) {
              if(var_13._id_10238 == var_9) {
                _id_06E7::_id_7336(var_13, var_10);
                break;
              }
            }
          }
        }
      }
    }

    foreach(var_13 in self._id_C835) {
      if(isalive(var_13) && (istrue(var_2) || isDefined(var_8[var_13._id_10238]))) {
        if(isDefined(level.vehicle._id_1305["unload"]) && ![[level.vehicle._id_1305["unload"]]](var_13, var_13._id_10238)) {
          continue;
        }
        var_10 = _id_06E7::_id_1801(self, var_13._id_10238);

        if(isDefined(var_10) && istrue(var_10._id_4C16)) {
          continue;
        }
        if(isDefined(level.vehicle._id_1307["unload"])) {
          if(!istrue(var_10._id_D8AA)) {
            var_13 notify("newanim");
            thread[[level.vehicle._id_1307["unload"]]](var_13, var_13._id_10238, var_2);
            var_13 notify("unload");

            if(isDefined(var_10._id_9E6C)) {
              var_13 _id_06C5::_id_E8EC();
            }

            var_3 = scripts\engine\utility::array_add(var_3, var_13);
          }
        }
      }
    }
  }

  return var_3;
}

_id_0CF6(var_0, var_1) {
  if(self.health <= 0) {
    return;
  }
  if(isDefined(self._id_AC93)) {
    var_0 = var_0 + (0, 0, self._id_AC93);
  }

  self setvehgoalpos(var_0, var_1);
}

_id_1012A() {
  self notify("kill_badplace_forever");
}

_id_10121() {
  return isDefined(self._id_0160);
}

_id_0C43(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    var_2 = self _meth_8131();
    var_2 = vectornormalize(var_2);
    var_0 = vectornormalize(var_0);
    var_3 = _func_025E(var_2, var_0, var_1);
    return var_3;
  } else
    return undefined;
}

_id_10231(var_0, var_1, var_2) {
  if(_id_10121()) {
    return;
  }
  level notify("vehicle_explosion", self.origin);
  self notify("explode", self.origin);
  thread _id_10087();
  thread _id_1008C();
  thread _id_1008A();
  thread _id_10089(var_2);
  thread _id_1008D(var_0, var_1);
}

_id_1008D(var_0, var_1) {
  var_2 = _id_6810();

  if(_id_1025B(var_0, var_1, var_2)) {
    self._id_10263 = 1;
    self._id_BB8C = 3;
    var_3 = level.vehicle._id_F078._id_1024D[var_2];
  } else if(istrue(self._id_B0D7)) {
    self._id_10263 = 1;
    self._id_BB8C = 4;
    var_3 = level.vehicle._id_F078._id_1024D[var_2];
  } else
    var_3 = level.vehicle._id_F078._id_10082[var_2];

  if(isDefined(var_3)) {
    foreach(var_5 in var_3) {
      thread _id_8D27(self.model, var_5, self._id_04DE, var_0);
    }
  }
}

_id_10087() {
  var_0 = level.vehicle._id_F078._id_43B2[_id_6810()];

  if(isDefined(var_0)) {
    earthquake(var_0._id_CB76, var_0._id_5090, self.origin, var_0._id_0359);
  }
}

_id_1008C() {
  if(scripts\common\vehicle::_id_8896()) {
    return;
  }
  var_0 = _id_6810();

  if(!isDefined(level.vehicle._id_F078._id_43C9) || !isDefined(level.vehicle._id_F078._id_43C9[var_0])) {
    return;
  }
  var_1 = level.vehicle._id_F078._id_43C9[var_0]._id_0299;
  var_2 = level.vehicle._id_F078._id_43C9[var_0]._id_02B1;
  self radiusdamage(self.origin + level.vehicle._id_F078._id_43C9[var_0]._id_A97D, level.vehicle._id_F078._id_43C9[var_0]._id_C01B, var_1, var_2, self);
}

_id_1008A() {
  _id_06EA::_id_94A0("all", self.model, _id_6810());
}

_id_10089(var_0) {
  if(scripts\common\vehicle::_id_8896()) {
    return;
  }
  if(!scripts\common\utility::issp() && self _meth_8104()) {
    return;
  }
  self _meth_81F7(var_0, 3.0);
}

_id_1025B(var_0, var_1, var_2) {
  if(!_id_100D7(var_2)) {
    return 0;
  }

  if(istrue(self._id_100AD)) {
    return 1;
  }

  if(scripts\engine\utility::is_equal(var_1, "MOD_PROJECTILE")) {
    return 1;
  }

  if(scripts\engine\utility::is_equal(var_1, "MOD_PROJECTILE_SPLASH")) {
    return 1;
  }

  if(scripts\engine\utility::is_equal(var_1, "MOD_GRENADE")) {
    return 1;
  }

  return 0;
}

_id_100D7(var_0) {
  return isDefined(level.vehicle._id_F078._id_1024D[var_0]);
}

_id_8D27(var_0, var_1, var_2, var_3) {
  if(isDefined(self._id_B0D7)) {
    self waittill("flavor_done");
  }

  if(isDefined(self._id_A567)) {
    return;
  }
  if(!isDefined(var_3)) {
    return;
  }
  if(isDefined(var_1._id_107E9)) {
    if(var_1._id_107E9 >= 0) {
      wait(var_1._id_107E9);
    } else {
      self waittill("death_finished");
    }
  }

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_1._id_A6B5)) {
    self notify(var_1._id_A6B5);
  }

  var_4 = vectornormalize(self.origin - var_3.origin);

  if(isDefined(var_1._id_D082)) {
    scripts\engine\utility::_id_46A5(var_1._id_D082, ::delete);
  }

  if(isDefined(var_1._id_5106)) {
    if(var_1._id_2499) {
      if(isDefined(var_1._id_0427)) {
        if(isDefined(var_1._id_E793) && var_1._id_E793 == 1) {
          thread _id_981F(var_1._id_5106, var_1._id_4649, var_1._id_0427);
        } else {
          thread _id_B883(var_1._id_5106, var_1._id_4649, var_1._id_0427);
        }
      } else {
        var_5 = self.origin + (0, 0, 100) - self.origin;
        playFX(var_1._id_5106, self.origin, var_5);
      }
    } else if(isDefined(var_1._id_0427)) {
      var_5 = _id_0C43(var_4, var_1._id_1DD3);

      if(isDefined(var_5)) {
        var_6 = _id_43EB();
        playFX(var_1._id_5106, var_6 gettagorigin(var_1._id_0427), var_5);

        if(isDefined(var_1._id_C3A2)) {
          var_6 scripts\engine\utility::_id_46A5(var_1._id_C3A2, ::delete);
        }
      } else {
        var_6 = _id_43EB();
        playFXOnTag(var_1._id_5106, var_6, var_1._id_0427);
        thread _id_E89F(var_1._id_5106, var_6, var_1._id_0427);

        if(isDefined(var_1._id_C3A2)) {
          _id_43EB() scripts\engine\utility::_id_46A5(var_1._id_C3A2, ::delete);
        }
      }
    } else {
      var_5 = _id_0C43(var_4, var_1._id_1DD3);

      if(isDefined(var_5)) {
        playFX(var_1._id_5106, self.origin, var_5);
      } else {
        var_5 = self.origin + (0, 0, 100) - self.origin;
        playFX(var_1._id_5106, self.origin, var_5);
      }
    }
  }

  if(isDefined(var_1._id_E050)) {
    if(var_1._id_2C58) {
      thread _id_43B6(var_1._id_E050);
    } else {
      scripts\engine\utility::_id_B2DA(var_1._id_E050);
    }
  }
}

_id_E89F(var_0, var_1, var_2) {
  var_1 waittill("stop_all_death_fx");
  stopFXOnTag(var_0, var_1, var_2);
}

_id_981F(var_0, var_1, var_2) {
  self endon("stop_looping_death_fx");

  while(isDefined(self)) {
    playFXOnTag(var_0, _id_43EB(), var_2);
    wait(var_1);
  }
}

_id_43B6(var_0) {
  thread scripts\engine\utility::_id_CD61("playloopsound_on_tag", var_0, undefined, 0, 1);
  scripts\engine\utility::waittill_any_2("fire_extinguish", "stop_crash_loop_sound");

  if(!isDefined(self)) {
    return;
  }
  self notify("stop sound" + var_0);
}

_id_43EB() {
  if(isDefined(self._id_43B8) && self._id_43B8) {
    return self;
  }

  if(!isDefined(self._id_43EB)) {
    var_0 = spawn("script_model", (0, 0, 0));
    var_0 setModel(self.model);
    var_0.origin = self.origin;
    var_0.angles = self.angles;
    var_0 notsolid();
    var_0 hide();
    var_0 linkto(self);
    var_0._id_43B7 = 1;
    self._id_43EB = var_0;
  } else
    self._id_43EB setModel(self.model);

  return self._id_43EB;
}

_id_B883(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", self.origin);
  self endon("fire_extinguish");
  thread _id_B884(var_2, var_3);

  for(;;) {
    playFX(var_0, var_3.origin, var_3._id_FDAE);
    wait(var_1);
  }
}

_id_B884(var_0, var_1) {
  var_1.angles = self gettagangles(var_0);
  var_1.origin = self gettagorigin(var_0);
  var_1._id_5F0E = anglesToForward(var_1.angles);
  var_1._id_FDAE = anglestoup(var_1.angles);

  while(isDefined(self) && self._id_00EC == "script_vehicle" && self _meth_842E() > 0) {
    var_1.angles = self gettagangles(var_0);
    var_1.origin = self gettagorigin(var_0);
    var_1._id_5F0E = anglesToForward(var_1.angles);
    var_1._id_FDAE = anglestoup(var_1.angles);
    wait 0.05;
  }
}

_id_0C10(var_0, var_1) {
  var_2 = [];

  if(isDefined(var_0) && isDefined(var_1)) {
    var_3 = 1;
    var_4 = getEntArray(var_0, var_1);
  } else {
    var_3 = 0;
    var_4 = getEntArray("script_vehicle", "code_classname");
  }

  foreach(var_6 in var_4) {
    if(var_3 && var_6._id_00EC != "script_vehicle") {
      continue;
    }
    if(_func_011E(var_6)) {
      var_2[var_2.size] = var_6;
    }
  }

  return var_2;
}

_id_FBD0(var_0) {
  if(var_0._id_FBDD == gettime()) {
    return var_0._id_E830;
  }

  var_0._id_FBDD = gettime();

  if(var_0._id_E831) {
    var_1 = clamp(0 - var_0.angles[2], 0 - var_0._id_E833, var_0._id_E833) / var_0._id_E833;

    if(isDefined(var_0._id_9148) && var_0._id_9148) {
      var_2 = var_0 _meth_842F();
      var_2 = var_2 * -1.0;
      var_1 = var_1 + var_2;

      if(var_1 != 0) {
        var_3 = 1.0 / abs(var_1);

        if(var_3 < 1) {
          var_1 = var_1 * var_3;
        }
      }
    }

    var_4 = var_1 - var_0._id_E830;

    if(var_4 != 0) {
      var_5 = var_0._id_E832 / abs(var_4);

      if(var_5 < 1) {
        var_4 = var_4 * var_5;
      }

      var_0._id_E830 = var_0._id_E830 + var_4;
    }
  } else
    var_0._id_E830 = 0;

  return var_0._id_E830;
}

_id_64B7(var_0) {
  return scripts\engine\utility::getstruct(var_0, "targetname");
}

_id_64B6(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  if(isDefined(var_1) && var_1.size > 0) {
    return var_1[randomint(var_1.size)];
  }

  return undefined;
}

_id_64B8(var_0) {
  return _func_00E5(var_0, "targetname");
}

_id_D280(var_0) {
  var_1 = getent(var_0._id_0399, "script_linkname");

  if(!isDefined(var_1)) {
    return;
  }
  self setlookatent(var_1);
  self._id_D281 = 1;
}

_id_42C2() {
  level._id_1B4D = 0;
  self._id_4B79 = 0;
  thread _id_42C4();

  while(isDefined(self)) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(!isPlayer(var_1)) {
      continue;
    }
    if(isDefined(self._id_751C)) {
      continue;
    }
    var_4 = tolower(var_4);

    switch (var_4) {
      case "bullet":
      case "mod_rifle_bullet":
      case "mod_pistol_bullet":
        if(!level._id_1B4D) {
          if(isDefined(level._id_F1CC) && level._id_F1CC > 0) {
            break;
          }

          level._id_1B4D = 1;
          self._id_4B79 = 1;
          var_1 scripts\engine\utility::_id_CD61("display_hint", "invulerable_bullets");
          wait 4;
          level._id_1B4D = 0;

          if(isDefined(self)) {
            self._id_4B79 = 0;
          }

          break;
        }
    }
  }
}

_id_42C3() {
  level._id_1B4D = 0;
  self._id_4B79 = 0;
  thread _id_42C4();

  while(isDefined(self)) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(!isPlayer(var_1)) {
      continue;
    }
    if(isDefined(self._id_751C)) {
      continue;
    }
    var_4 = tolower(var_4);

    switch (var_4) {
      case "mod_grenade_splash":
      case "mod_grenade":
      case "bullet":
      case "mod_rifle_bullet":
      case "mod_pistol_bullet":
        if(!level._id_1B4D) {
          if(isDefined(level._id_F1CC) && level._id_F1CC > 0) {
            break;
          }

          level._id_1B4D = 1;
          self._id_4B79 = 1;

          if(var_4 == "mod_grenade" || var_4 == "mod_grenade_splash") {
            var_1 scripts\engine\utility::_id_CD61("display_hint", "invulerable_frags", 5);
          } else {
            var_1 scripts\engine\utility::_id_CD61("display_hint", "invulerable_bullets", 5);
          }

          wait 4;
          level._id_1B4D = 0;

          if(isDefined(self)) {
            self._id_4B79 = 0;
          }

          break;
        }
    }
  }
}

_id_42C4() {
  self waittill("death");

  if(self._id_4B79) {
    level._id_1B4D = 0;
  }
}

_id_136D(var_0) {
  self endon("death");
  self endon("death_finished");
  self notify("stop_kicking_up_dust");
  self endon("stop_kicking_up_dust");
  var_1 = 2000;

  if(isDefined(level._id_F4FE)) {
    var_1 = level._id_F4FE;
  }

  var_2 = 80 / var_1;
  var_3 = 0.5;

  if(_id_8741()) {
    var_3 = 0.15;
  }

  var_4 = self;

  if(isDefined(var_0)) {
    var_4 = var_0;
  }

  var_5 = 3;
  var_6 = scripts\engine\trace::_id_3EF6(1);

  for(;;) {
    wait(var_3);

    if(1) {
      if(isDefined(self._id_4A69) && self._id_4A69) {
        continue;
      }
      if(isDefined(self._id_F4FE)) {
        var_1 = self._id_F4FE;
      }

      var_7 = anglestoup(var_4.angles) * -1;
      var_8 = undefined;
      var_5++;

      if(var_5 > 3) {
        var_5 = 3;
        var_8 = scripts\engine\trace::ray_trace(var_4.origin, var_4.origin + var_7 * var_1, var_4, var_6, 1);
      }

      if(var_8["fraction"] == 1 || var_8["fraction"] < var_2) {
        continue;
      }
      var_9 = distance(var_4.origin, var_8["position"]);
      var_10 = _id_682F(self, var_8, var_7, var_9);

      if(!isDefined(var_10)) {
        continue;
      }
      var_3 = (var_9 - 350) / (var_1 - 350) * 0.1 + 0.05;
      var_3 = max(var_3, 0.05);

      if(!isDefined(var_8)) {
        continue;
      }
      if(!isDefined(var_8["position"])) {
        continue;
      }
      var_11 = var_8["position"];
      var_12 = var_8["normal"];
      var_9 = vectordot(var_11 - var_4.origin, var_12);
      var_13 = var_4.origin + (0, 0, var_9);
      var_14 = var_11 - var_13;

      if(isDefined(self._id_F4FF)) {
        var_14 = var_11 - level.player.origin;
      }

      if(vectordot(var_8["normal"], (0, 0, 1)) == -1) {
        continue;
      }
      if(length(var_14) < 1) {
        var_14 = var_4.angles + (0, 180, 0);
      }

      playFX(var_10, var_11, var_12, var_14);
    }
  }
}

_id_682F(var_0, var_1, var_2, var_3) {
  var_4 = var_1["surfacetype"];
  var_5 = undefined;
  var_6 = vectordot((0, 0, -1), var_2);

  if(var_6 >= 0.97) {
    var_5 = undefined;
  } else if(var_6 >= 0.92) {
    var_5 = "_bank";
  } else {
    var_5 = "_bank_lg";
  }

  return _id_682E(var_0 _id_6810(), var_4, var_5);
}

_id_682E(var_0, var_1, var_2) {
  if(isDefined(var_2) && isDefined(level.vehicle._id_F078._id_EBC9[var_0])) {
    var_3 = var_1 + var_2;

    if(!isDefined(level.vehicle._id_F078._id_EBC9[var_0][var_3]) && var_1 != "default") {
      return _id_682E(var_0, "default", var_2);
    } else {
      return level.vehicle._id_F078._id_EBC9[var_0][var_3];
    }
  }

  return _id_6813(var_0, var_1);
}

_id_6813(var_0, var_1) {
  if(isDefined(level.vehicle._id_F078._id_EBC9[var_0])) {
    if(!isDefined(level.vehicle._id_F078._id_EBC9[var_0][var_1]) && var_1 != "default") {
      return _id_6813(var_0, "default");
    } else {
      return level.vehicle._id_F078._id_EBC9[var_0][var_1];
    }
  }

  return undefined;
}

_id_A537() {
  return _id_8897() || _id_8741();
}

_id_100D6() {
  if(!_id_8897() && !_id_8741()) {
    return 0;
  }

  return 1;
}

_id_7571() {
  if(!isDefined(self._id_04DE)) {
    return 0;
  }

  if(self._id_04DE == "cobra") {
    return 1;
  }

  if(self._id_04DE == "cobra_player") {
    return 1;
  }

  if(self._id_04DE == "viper") {
    return 1;
  }

  return 0;
}

_id_FFF5() {
  self waittill("death");
  _id_10244();
  _id_10245();
}

_id_FFF7() {
  self endon("death");
  thread _id_FFF5();
  var_0 = self _meth_8434();
  var_1 = 25.0;

  for(;;) {
    _id_10157();
    var_2 = self.origin;

    while(_id_1011C() && (!var_0 || self _meth_8726())) {
      wait 0.1;

      if(_func_0135(self.origin - var_2) > var_1) {
        _id_10244();
        _id_10157();
        var_2 = self.origin;
      }
    }

    _id_10244();
    _id_10158();

    while(!_id_1011C() || var_0 && !self _meth_8726()) {
      wait 0.1;
    }

    _id_10245();
  }
}

_id_1011C() {
  if(!scripts\common\utility::issp() && self _meth_8104()) {
    return 1;
  }

  if(self _meth_8434()) {
    return self _meth_842E() < 0.01;
  }

  return self _meth_842E() == 0;
}

_id_FFF6() {
  self endon("death");

  for(;;) {
    _id_10157();

    while(self _meth_842E() == 0 && (!isDefined(self._id_CD0F) || istrue(self._id_CD0F))) {
      wait 0.1;
    }

    _id_10244();

    while(self _meth_842E() != 0 || isDefined(self._id_CD0F) && !istrue(self._id_CD0F)) {
      wait 0.1;
    }
  }
}

_id_10158() {
  if(isDefined(self._id_CCBB) && !istrue(self._id_CCBB)) {
    return;
  }
  _func_02AC(self._id_F94F + "vehicle_badplace", -1, self, "allies", "axis");
}

_id_10245() {
  _func_02AD(self._id_F94F + "vehicle_badplace");
}

_id_10157() {
  if(isDefined(self._id_CD0F) && !istrue(self._id_CD0F)) {
    return;
  }
  self._id_A3E7 = _func_02B3(self);
}

_id_10244() {
  if(isDefined(self._id_A3E7)) {
    _func_02B1(self._id_A3E7);
    self._id_A3E7 = undefined;
  }
}

_id_10095() {
  self._id_CCBB = 0;
  _id_10245();
}

_id_100A6() {
  self._id_CCBB = undefined;

  if(!_id_1011C()) {
    _id_10158();
  }
}

_id_10094() {
  self._id_CD0F = 0;
  _id_10244();
}

_id_100A5() {
  self._id_CD0F = undefined;

  if(_id_1011C()) {
    _id_10157();
  }
}

_id_10000() {
  _id_10158();
}

_id_10243() {
  _id_10245();
}

_id_4B14() {
  self endon("death");
  self._id_AEE5 = 0;
  var_0 = 0;

  if(isDefined(self._id_CD0F) && !self._id_CD0F) {
    var_0 = 1;
  }

  if(var_0) {
    self._id_4D9D = 1;
    return;
  }

  wait(randomfloat(1));

  while(isDefined(self)) {
    if(self _meth_842E() < 1) {
      if(!isDefined(self._id_4D9D)) {
        self _meth_80B5();
        self._id_AEE5 = 1;
      } else {}

      self notify("speed_zero_path_disconnect");

      while(self _meth_842E() < 1) {
        if(isDefined(self._id_4D9D) && self._id_4D9D) {
          break;
        }

        wait 0.05;
      }
    }

    self _meth_8093();
    self._id_AEE5 = 0;
    wait 1;
  }
}

_id_9983() {
  var_0 = _id_6810();

  if(!isDefined(level.vehicle._id_F078._id_997E[var_0])) {
    return;
  }
  var_1 = level.vehicle._id_F078._id_997E[var_0];

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = "";

  if(isDefined(self._id_CEA2)) {
    var_2 = self._id_CEA2;
  }

  self._id_997E = _id_F885(var_1);
  thread _id_9980();
  _id_73FA(self, 0);
}

_id_9980() {
  self endon("death");
  var_0 = _id_6810();
  var_1 = undefined;

  if(isDefined(level.vehicle._id_F078.mainturret_jolt) && isDefined(level.vehicle._id_F078.mainturret_jolt[var_0])) {
    var_1 = level.vehicle._id_F078.mainturret_jolt[var_0];
  }

  var_2 = undefined;

  if(isDefined(level.vehicle._id_F078.mainturret_quake) && isDefined(level.vehicle._id_F078.mainturret_quake[var_0])) {
    var_2 = level.vehicle._id_F078.mainturret_quake[var_0];
  }

  var_3 = undefined;

  if(isDefined(level.vehicle._id_F078.mainturret_rumble) && isDefined(level.vehicle._id_F078.mainturret_rumble[var_0])) {
    var_3 = level.vehicle._id_F078.mainturret_rumble[var_0];
  }

  for(;;) {
    self._id_997E waittill("turret_fire");

    if(!istrue(self.no_main_turret_fire_jolt)) {
      mainturret_fire_effect_jolt(var_1);
    }

    if(!istrue(self.no_main_turret_fire_quake)) {
      mainturret_fire_effect_quake(var_2);
    }

    if(!istrue(self.no_main_turret_fire_rumble)) {
      mainturret_fire_effect_rumble(var_3);
    }

    if(isDefined(self._id_997E.on_fire_callback)) {
      self thread[[self._id_997E.on_fire_callback]]();
    }
  }
}

mainturret_fire_effect_jolt(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  if(isDefined(self._id_997E.fire_jolt_tag)) {
    var_1 = self._id_997E.fire_jolt_tag;
  } else if(isDefined(var_0) && isDefined(var_0._id_0427)) {
    var_1 = var_0._id_0427;
  }

  if(!isDefined(var_1) || isDefined(var_1) && !self._id_997E tagexists(var_1)) {
    return;
  }
  if(isDefined(self._id_997E._id_5B3E)) {
    var_2 = self._id_997E._id_5B3E;
  } else if(isDefined(var_0) && isDefined(var_0._id_023B)) {
    var_2 = var_0._id_023B;
  }

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = self._id_997E gettagorigin(var_1);
  self _meth_81F7(var_3, var_2);
}

mainturret_fire_effect_quake(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  if(isDefined(self._id_997E.fire_quake_tag)) {
    var_1 = self._id_997E.fire_quake_tag;
  } else if(isDefined(var_0) && isDefined(var_0._id_0427)) {
    var_1 = var_0._id_0427;
  }

  if(!isDefined(var_1) || isDefined(var_1) && !self._id_997E tagexists(var_1)) {
    return;
  }
  if(isDefined(self._id_997E._id_5B4C)) {
    var_2 = self._id_997E._id_5B4C;
  } else if(isDefined(var_0) && isDefined(var_0._id_023B)) {
    var_2 = var_0._id_023B;
  }

  if(isDefined(self._id_997E._id_5B4B)) {
    var_4 = self._id_997E._id_5B4B;
  } else if(isDefined(var_0) && isDefined(var_0._id_5090)) {
    var_4 = var_0._id_5090;
  }

  if(isDefined(self._id_997E._id_5B4D)) {
    var_3 = self._id_997E._id_5B4D;
  } else if(isDefined(var_0) && isDefined(var_0._id_0359)) {
    var_3 = var_0._id_0359;
  }

  var_5 = self._id_997E gettagorigin(var_1);
  earthquake(var_2, var_4, var_5, var_3);
}

mainturret_fire_effect_rumble(var_0) {
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = 0;
  var_7 = self.origin;

  if(isDefined(self._id_997E.fire_rumble_tag)) {
    var_1 = self._id_997E.fire_rumble_tag;
  } else if(isDefined(var_0) && isDefined(var_0._id_0427)) {
    var_1 = var_0._id_0427;
  }

  if(isDefined(self._id_997E.fire_rumble_near_dist)) {
    var_3 = self._id_997E.fire_rumble_near_dist;
  } else if(isDefined(var_0) && isDefined(var_0.near_dist)) {
    var_3 = var_0.near_dist;
  }

  if(isDefined(self._id_997E.fire_rumble_far_dist)) {
    var_2 = self._id_997E.fire_rumble_far_dist;
  } else if(isDefined(var_0) && isDefined(var_0._id_5973)) {
    var_2 = var_0._id_5973;
  }

  if(!isDefined(var_2) && !isDefined(var_3)) {
    return;
  }
  if(isDefined(self._id_997E.fire_rumble_near_rumble)) {
    var_4 = self._id_997E.fire_rumble_near_rumble;
  } else if(isDefined(var_0) && isDefined(var_0.near_rumble)) {
    var_4 = var_0.near_rumble;
  }

  if(isDefined(var_2)) {
    if(isDefined(self._id_997E.fire_rumble_far_rumble)) {
      var_5 = self._id_997E.fire_rumble_far_rumble;
    } else if(isDefined(var_0) && isDefined(var_0.far_rumble)) {
      var_5 = var_0.far_rumble;
    }
  }

  if(isDefined(self._id_997E.fire_rumble_use_vehicle_for_tag)) {
    var_6 = self._id_997E.fire_rumble_use_vehicle_for_tag;
  } else if(isDefined(var_0) && isDefined(var_0.use_vehicle_for_tag)) {
    var_6 = var_0.use_vehicle_for_tag;
  }

  if(isDefined(var_1)) {
    if(var_6 && self tagexists(var_1)) {
      var_7 = self gettagorigin(var_1);
    } else if(self._id_997E tagexists(var_1)) {
      var_7 = self._id_997E gettagorigin(var_1);
    }
  }

  var_8 = distance2dsquared(level.player.origin, var_7);

  if(isDefined(var_3) && isDefined(var_2)) {
    var_9 = _func_0219(var_2);
    var_10 = _func_0219(var_3);

    if(var_8 < var_10) {
      level.player playrumbleonentity(var_4);
      return;
    }

    if(var_8 < var_9) {
      level.player playrumbleonentity(var_5);
      return;
    }

    return;
  } else {
    var_10 = _func_0219(var_3);

    if(var_8 < var_10) {
      level.player playrumbleonentity(var_4);
    }
  }
}

_id_9E66() {
  var_0 = _id_6810();

  if(isDefined(self._id_CDFB) && self._id_CDFB > 0) {
    return;
  }
  if(!isDefined(level.vehicle._id_F078._id_9E6C[var_0])) {
    return;
  }
  var_1 = level.vehicle._id_F078._id_9E6C[var_0];

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = "";

  if(isDefined(self._id_CEA2)) {
    var_2 = self._id_CEA2;
  }

  foreach(var_5, var_4 in var_1) {
    if(isDefined(var_4._id_C18B) && !issubstr(var_2, var_4._id_C18B)) {
      continue;
    }
    self._id_9E6C[var_5] = _id_F885(var_4);
  }
}

_id_F883() {
  var_0 = scripts\engine\utility::_id_636C(self._id_CD9D);
  var_1 = scripts\engine\utility::_id_636C(self._id_CE36);
  var_2 = scripts\engine\utility::_id_636C(self._id_CE87);
  var_3 = scripts\engine\utility::_id_636C(self._id_CCC8);
  var_4 = scripts\engine\utility::_id_636C(self._id_CE25);
  var_5 = scripts\engine\utility::_id_636C(self._id_CEC4);
  var_6 = scripts\engine\utility::_id_636C(self._id_CE21);
  var_7 = scripts\engine\utility::_id_636C(self._id_CCD3);
  var_8 = scripts\engine\utility::_id_636C(self._id_CCD1);
  var_9 = scripts\engine\utility::_id_636C(self._id_CCCF);
  var_10 = scripts\engine\utility::_id_636C(self._id_CCFE);
  var_11 = scripts\engine\utility::_id_636C(self._id_CCFC);
  var_12 = [];

  if(isDefined(self._id_997E)) {
    var_12 = [self._id_997E];
  }

  if(isDefined(self._id_9E6C)) {
    var_12 = scripts\engine\utility::array_combine(var_12, self._id_9E6C);
  }

  foreach(var_17, var_14 in var_12) {
    var_15 = undefined;
    var_16 = undefined;

    if(isDefined(var_0) && isDefined(var_0[var_17])) {
      var_14 _meth_8331(float(var_0[var_17]));
    }

    if(isDefined(var_1) && isDefined(var_1[var_17])) {
      var_14 _meth_8372(float(var_1[var_17]));
    }

    if(isDefined(var_2) && isDefined(var_2[var_17])) {
      var_14 _meth_8395(float(var_2[var_17]));
    }

    if(isDefined(var_3) && isDefined(var_3[var_17])) {
      var_14 _meth_82F0(float(var_3[var_17]));
    }

    if(isDefined(var_4) && isDefined(var_4[var_17])) {
      var_14 _meth_8368(float(var_4[var_17]));
    }

    if(isDefined(var_5) && isDefined(var_5[var_17])) {
      var_14 _meth_8302(float(var_5[var_17]), "yaw");
      var_15 = var_14 _meth_8810("yaw");
    }

    if(isDefined(var_6) && isDefined(var_6[var_17])) {
      var_14 _meth_8302(float(var_6[var_17]), "pitch");
      var_16 = var_14 _meth_8810("pitch");
    }

    if(isDefined(var_7) && isDefined(var_7[var_17])) {
      var_14._id_CCD2 = float(var_7[var_17]);
    }

    if(isDefined(var_8) && isDefined(var_8[var_17])) {
      var_14._id_CCD0 = float(var_8[var_17]);
    }

    if(isDefined(var_9) && isDefined(var_9[var_17])) {
      var_14._id_CCCE = float(var_9[var_17]);
    }

    if(isDefined(var_10) && isDefined(var_10[var_17])) {
      var_14._id_CCFD = float(var_10[var_17]);
    }

    if(isDefined(var_11) && isDefined(var_11[var_17])) {
      var_14._id_CCFB = float(var_11[var_17]);
    }
  }

  thread scripts\engine\utility::_id_CD61("turretInit_KVP_from_vehicle");
}

_id_F885(var_0) {
  var_1 = 0;

  if(isDefined(self._id_CDB7)) {
    var_1 = self._id_CDB7;
  }

  var_2 = 0;

  if(isDefined(self._id_CDB8)) {
    var_2 = self._id_CDB8;
  }

  var_3 = spawnturret("misc_turret", (0, 0, 0), var_0._id_7E9E);
  var_4 = (0, 0, 0);

  if(isDefined(var_0._id_A981)) {
    var_4 = var_0._id_A981;
  }

  var_5 = self;

  if(isDefined(var_0._id_9982)) {
    if(!isDefined(self._id_997E)) {}

    var_5 = self._id_997E;
  }

  var_3 linkto(var_5, var_0._id_0427, var_4, (-1 * var_2, -1 * var_1, 0));
  var_3 setModel(var_0.model);
  var_3.angles = self.angles;
  var_3._id_8AF6 = 1;
  var_3._id_ADB4 = self;
  var_3.weaponinfo = var_0._id_7E9E;
  var_3._id_CE7D = self._id_CE7D;
  var_3 makeuseable();
  _id_D3FA(var_3);
  level thread _id_102CD(var_3, scripts\common\utility::_id_69DE());

  if(isDefined(self._id_CD43)) {
    var_3._id_CD43 = self._id_CD43;
  }

  if(isDefined(var_0._id_4763)) {
    var_3._id_4763 = var_0._id_4763;
  }

  if(isDefined(var_0._id_45AD)) {
    var_3 setdefaultdroppitch(var_0._id_45AD);
  }

  if(isDefined(var_0._id_C18B)) {
    var_3._id_C18B = var_0._id_C18B;
  }

  if(isDefined(var_0._id_45BA)) {
    var_3 _id_F866(var_0._id_45BA);
    var_3 setmode(var_0._id_45BA);
  } else
    var_3 setmode("auto_nonai");

  if(isDefined(var_0.on_fire_callback)) {
    var_3.on_fire_callback = var_0.on_fire_callback;
  }

  var_3 thread _id_06E3::_id_F879();
  return var_3;
}

_id_10212() {
  self endon("death_finished");
  self waittill("entitydeleted");

  if(isDefined(self._id_9E6C)) {
    scripts\engine\utility::_id_1BA4(self._id_9E6C);
  }

  if(isDefined(self._id_997E)) {
    self._id_997E delete();
  }
}

_id_102CD(var_0, var_1) {}

_id_F866(var_0) {
  self._id_45BA = var_0;
}

_id_D3FA(var_0) {
  switch (self._id_CE7D) {
    case "friendly":
    case "allies":
      var_0 _meth_83A0("allies");
      break;
    case "enemy":
    case "axis":
      var_0 _meth_83A0("axis");
      break;
    case "team3":
      var_0 _meth_83A0("team3");
      break;
    default:
      break;
  }
}

_id_1876() {
  if(!scripts\common\utility::issp()) {
    return;
  }
  self endon("suspend_drive_anims");

  if(!isDefined(self._id_1035C)) {
    self._id_1035C = 1;
  }

  var_0 = self.model;
  var_1 = -1;
  var_2 = undefined;

  if(!isDefined(level.vehicle._id_F078._id_4F5E[var_0])) {
    return;
  }
  self useanimtree(#animtree);

  if(!isDefined(level.vehicle._id_F078._id_4F61[var_0])) {
    level.vehicle._id_F078._id_4F61[var_0] = level.vehicle._id_F078._id_4F5E[var_0];
  }

  self endon("death");
  var_3 = level.vehicle._id_F078._id_4F60[var_0];
  var_4 = 1.0;

  if(isDefined(level.vehicle._id_F078._id_4F5F) && isDefined(level.vehicle._id_F078._id_4F5F[var_0])) {
    var_4 = level.vehicle._id_F078._id_4F5F[var_0];
  }

  var_5 = self._id_1035C;
  var_6 = level.vehicle._id_F078._id_4F5E[var_0];

  for(;;) {
    if(!var_3) {
      if(isDefined(self._id_EBE0)) {
        wait 0.05;
        continue;
      }

      self _meth_82D9(level.vehicle._id_F078._id_4F5E[var_0], 1, 0.2, var_4);
      return;
    }

    var_7 = self _meth_842E();

    if(var_5 != self._id_1035C) {
      var_8 = 0;

      if(self._id_1035C) {
        var_6 = level.vehicle._id_F078._id_4F5E[var_0];
        var_8 = 1 - _id_65EE(level.vehicle._id_F078._id_4F61[var_0]);
        self _meth_8077(level.vehicle._id_F078._id_4F61[var_0], 0);
      } else {
        var_6 = level.vehicle._id_F078._id_4F61[var_0];
        var_8 = 1 - _id_65EE(level.vehicle._id_F078._id_4F5E[var_0]);
        self _meth_8077(level.vehicle._id_F078._id_4F5E[var_0], 0);
      }

      var_2 = 0.01;

      if(var_2 >= 1 || var_2 == 0) {
        var_2 = 0.01;
      }

      var_5 = self._id_1035C;
    }

    var_9 = var_7 / var_3;

    if(var_9 != var_1) {
      self _meth_82D9(var_6, 1, 0.05, var_9);
      var_1 = var_9;
    }

    if(isDefined(var_2)) {
      self _meth_82E7(var_6, var_2);
      var_2 = undefined;
    }

    wait 0.05;
  }
}

_id_D83A(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(_func_011E(var_3)) {
      continue;
    } else {
      var_1[var_1.size] = var_3;
    }
  }

  foreach(var_6 in var_1) {
    thread _id_100E0(var_6);
  }
}

_id_10253() {
  var_0 = _id_6810();

  if(isDefined(self._id_CE66)) {
    self.health = self._id_CE66;
  } else {
    if(level.vehicle._id_F078._id_9365[var_0] == -1) {
      return;
    }
    if(isDefined(level.vehicle._id_F078._id_936A[var_0]) && isDefined(level.vehicle._id_F078._id_9369[var_0])) {
      self.health = randomint(level.vehicle._id_F078._id_9369[var_0] - level.vehicle._id_F078._id_936A[var_0]) + level.vehicle._id_F078._id_936A[var_0];
    } else {
      self.health = level.vehicle._id_F078._id_9365[var_0];
    }
  }
}

_id_65EE(var_0) {
  var_1 = self _meth_8111(var_0);
  var_2 = _func_0079(var_0);

  if(var_1 == 0) {
    return 0;
  }

  return self _meth_8111(var_0) / _func_0079(var_0);
}

_id_EBDF() {
  self notify("suspend_drive_anims");
  self _meth_8077(level.vehicle._id_F078._id_4F5E[self.model], 0);
  self _meth_8077(level.vehicle._id_F078._id_4F61[self.model], 0);
}

_id_7CAC() {
  if(!isDefined(level.vehicle._id_F078._id_7CAA[self.model])) {
    return;
  }
  self useanimtree(#animtree);

  foreach(var_1 in level.vehicle._id_F078._id_7CAA[self.model]) {
    self _meth_82D9(var_1);
  }
}

_id_1024E() {
  self endon("kill_rumble_forever");
  var_0 = _id_6810();
  var_1 = level.vehicle._id_F078._id_C992[var_0];

  if(!isDefined(var_1)) {
    return;
  }
  var_2 = var_1._id_0359 * 2;
  var_3 = -1 * var_1._id_0359;
  var_4 = spawn("trigger_radius", self.origin + (0, 0, var_3), 0, var_1._id_0359, var_2);
  var_4 _meth_80DB();
  var_4 linkto(self);
  self._id_C9A2 = var_4;
  self endon("death");

  if(!isDefined(self._id_C9A1)) {
    self._id_C9A1 = 1;
  }

  if(isDefined(self.rumble_scale_override)) {
    self._id_C99F = self.rumble_scale_override;
  } else if(isDefined(var_1._id_CB76)) {
    self._id_C99F = var_1._id_CB76;
  } else {
    self._id_C99F = 0.15;
  }

  if(isDefined(self.rumble_duration_override)) {
    self._id_C994 = self.rumble_duration_override;
  } else if(isDefined(var_1._id_5090)) {
    self._id_C994 = var_1._id_5090;
  } else {
    self._id_C994 = 4.5;
  }

  if(isDefined(self.rumble_radius_override)) {
    self._id_C99A = self.rumble_radius_override;
  } else if(isDefined(var_1._id_0359)) {
    self._id_C99A = var_1._id_0359;
  } else {
    self._id_C99A = 600;
  }

  if(isDefined(self.rumble_basetime_override)) {
    self._id_C993 = self.rumble_basetime_override;
  } else if(isDefined(var_1._id_232C)) {
    self._id_C993 = var_1._id_232C;
  } else {
    self._id_C993 = 1;
  }

  if(isDefined(self.rumble_randomadditionaltime_override)) {
    self._id_C99E = self.rumble_randomadditionaltime_override;
  } else if(isDefined(var_1._id_BFF3)) {
    self._id_C99E = var_1._id_BFF3;
  } else {
    self._id_C99E = 1;
  }

  var_4._id_0359 = self._id_C99A;

  for(;;) {
    var_4 waittill("trigger");

    if(_id_1011C() && !isDefined(self._id_5EBC) || !self._id_C9A1) {
      wait 0.1;
      continue;
    }

    var_5 = var_1._id_C992;

    if(isDefined(self.rumble_override)) {
      var_5 = self.rumble_override;
    }

    self _meth_8278(var_5);

    if(isDefined(self._id_04DE)) {
      var_6 = self._id_04DE + "_rumble_sfx";

      if(_func_0205(var_6)) {
        level.player playSound(var_6);
      }
    }

    if(isDefined(self.rumble_scale_override) && self._id_C99F != self.rumble_scale_override) {
      self._id_C99F = self.rumble_scale_override;
    }

    if(isDefined(self.rumble_duration_override) && self._id_C994 != self.rumble_duration_override) {
      self._id_C994 = self.rumble_duration_override;
    }

    if(isDefined(self.rumble_radius_override) && self._id_C99A != self.rumble_radius_override) {
      self._id_C99A = self.rumble_radius_override;
      var_4._id_0359 = self._id_C99A;
    }

    if(isDefined(self.rumble_basetime_override) && self._id_C993 != self.rumble_basetime_override) {
      self._id_C993 = self.rumble_basetime_override;
    }

    if(isDefined(self.rumble_randomadditionaltime_override) && self._id_C99E != self.rumble_randomadditionaltime_override) {
      self._id_C99E = self.rumble_randomadditionaltime_override;
    }

    while(level.player istouching(var_4) && self._id_C9A1 && (!_id_1011C() || isDefined(self._id_5EBC))) {
      earthquake(self._id_C99F, self._id_C994, self.origin, self._id_C99A);
      wait(self._id_C993 + randomfloat(self._id_C99E));
    }

    self _meth_83F4(var_5);
  }
}

_id_10254() {
  var_0 = _id_6810();

  if(!isDefined(self._id_CE7D) && isDefined(level.vehicle._id_F078.team[var_0])) {
    self._id_CE7D = level.vehicle._id_F078.team[var_0];
  }
}

_id_100D3() {
  self endon("death");
  var_0 = self._id_04DE;

  if(!scripts\engine\utility::_id_5472("unloaded")) {
    scripts\engine\utility::_id_5473("unloaded");
  }
}

_id_681C(var_0) {
  var_1 = _func_00E5(var_0, "targetname");

  if(!isDefined(var_1)) {
    var_1 = getent(var_0, "targetname");
  } else if(_id_8897()) {}

  if(!isDefined(var_1)) {
    var_1 = scripts\engine\utility::getstruct(var_0, "targetname");
  }

  return var_1;
}

_id_1007F() {
  self endon("death");
  self._id_42C0 = [];
  self._id_74E5 = 0;
  var_0 = _id_6810();

  if(isDefined(level.vehicle._id_F078._id_2D2B[var_0]) && !isDefined(self._id_CCCC)) {
    self._id_CCCC = level.vehicle._id_F078._id_2D2B[var_0];
  }

  if(isDefined(level.vehicle._id_F078._id_7150[var_0]) && !isDefined(self._id_CD7A)) {
    self._id_CD7A = level.vehicle._id_F078._id_2D2B[var_0];
  }

  if(scripts\common\utility::issp() && self _meth_86EE() && isDefined(level.vehicle._id_F078._id_42DB[var_0])) {
    self._id_74E5 = 1;
    self._id_1031E = level.vehicle._id_F078._id_42DB[var_0]._id_10155;

    if(!isDefined(level.vehicle._id_102F6[self._id_1031E])) {
      if(scripts\engine\utility::_id_602B("veh_damage_get_level_data")) {
        var_1 = scripts\engine\utility::_id_CD61("veh_damage_get_level_data", self._id_1031E, 1);
        level scripts\engine\utility::_id_CD61("veh_damage_register_default_destroy_callback", self._id_1031E);
        level scripts\engine\utility::_id_CD61("veh_damage_register_threshold", self._id_1031E, "light", level.vehicle._id_F078._id_42DB[var_0]._id_9446);
        level scripts\engine\utility::_id_CD61("veh_damage_register_threshold", self._id_1031E, "medium", level.vehicle._id_F078._id_42DB[var_0]._id_9D03);
        level scripts\engine\utility::_id_CD61("veh_damage_register_threshold", self._id_1031E, "heavy", level.vehicle._id_F078._id_42DB[var_0]._id_765B, level.vehicle._id_F078._id_42DB[var_0]._id_2D78);
        level scripts\engine\utility::_id_CD61("veh_damage_register_default_states", self._id_1031E, scripts\common\vehicle::_id_100B0());
      }
    }
  }

  self._id_763A = 20000;
  self.health = self.health + self._id_763A;
  var_2 = self.health;

  while(self.health > 0) {
    self waittill("damage", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);

    if(istrue(self._id_4230)) {
      return;
    }
    foreach(var_14 in self._id_42C0) {
      thread[[var_14]](var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
    }

    if(isDefined(var_4)) {
      var_4 scripts\engine\utility::_id_CD61("register_shot_hit");

      if(scripts\engine\utility::_id_602B("vehicle_damage_modifier")) {
        var_16 = undefined;

        if(isDefined(level._id_5D4A)) {
          var_16 = [[level._id_5D4A]](var_4, self, var_3, var_12, var_7, undefined, var_6, var_5, var_8, var_10, var_9, var_11);
        }

        if(isDefined(var_16)) {
          self._id_42BB = var_16;
        } else {
          self._id_42BB = undefined;
        }

        var_17 = scripts\engine\utility::_id_CD61("vehicle_damage_modifier", var_16);

        if(isDefined(var_17)) {
          var_3 = var_17;
        }
      }
    }

    if(_id_10258(var_4, var_7) || _id_0C3A()) {
      if(isDefined(self._id_C1BB) && !istrue(self._id_C1BB)) {
        var_2 = self.health;
      } else {
        self.health = var_2;
      }
    } else {
      if(scripts\common\utility::issp() && isDefined(var_7)) {
        var_18 = 0;

        if(var_7 == "MOD_GRENADE_SPLASH" || var_7 == "MOD_PROJECTILE_SPLASH") {
          var_18 = var_3 * 12;
        } else if(var_7 == "MOD_GRENADE" || var_7 == "MOD_PROJECTILE") {
          var_18 = var_3 * 5;
        }

        if(var_18) {
          self.health = self.health - int(var_18);
        }
      }

      var_2 = self.health;

      if(scripts\common\utility::issp() && istrue(self._id_74E5) && isDefined(level._id_5D4A) && !istrue(self._id_4D74)) {
        var_16 = [[level._id_5D4A]](var_4, self, var_3, var_12, var_7, undefined, var_6, var_5, var_8, var_10, var_9, var_11);
        var_19 = scripts\engine\utility::_id_CD61("veh_damage_should_skip_burndown", var_16);
        thread scripts\engine\utility::_id_CD61("veh_damage_update_state", var_16, var_19, 1);
      }
    }

    if(self.health <= self._id_763A) {
      self notify("death", var_4, var_7, var_12, var_6);
    }
  }
}

_id_1011E(var_0) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(isDefined(var_0._id_763A) && var_0.health < var_0._id_763A) {
    return 0;
  }

  if(var_0.health <= 0) {
    return 0;
  }

  return 1;
}

_id_717A(var_0) {
  if(!isDefined(self._id_CD7A)) {
    return 0;
  }

  var_0 = tolower(var_0);

  if(!isDefined(var_0) || !issubstr(var_0, "grenade")) {
    return 0;
  }

  if(self._id_CD7A) {
    return 1;
  } else {
    return 0;
  }
}

_id_2D38(var_0) {
  if(!isDefined(self._id_CCCC)) {
    return 0;
  }

  var_0 = tolower(var_0);

  if(!isDefined(var_0) || !issubstr(var_0, "bullet") || issubstr(var_0, "explosive")) {
    return 0;
  }

  if(self._id_CCCC) {
    return 1;
  } else {
    return 0;
  }
}

_id_57DF(var_0) {
  if(!isDefined(self._id_CD35)) {
    return 0;
  }

  var_0 = tolower(var_0);

  if(!isDefined(var_0) || !issubstr(var_0, "explosive")) {
    return 0;
  }

  if(self._id_CD35) {
    return 1;
  } else {
    return 0;
  }
}

_id_10258(var_0, var_1) {
  return !isDefined(var_0) && self._id_CE7D != "neutral" || _id_1DD1(var_0) || _id_1DD2(var_0) || _id_8612(var_0) || _id_2D38(var_1) || _id_57DF(var_1) || _id_717A(var_1) || var_1 == "MOD_MELEE";
}

_id_0C3A() {
  return istrue(self._id_7095);
}

_id_8612(var_0) {
  if(!isDefined(self._id_CC8D)) {
    return 0;
  }

  if(isDefined(var_0) && isai(var_0) && self._id_CC8D == 1) {
    return 1;
  } else {
    return 0;
  }
}

_id_1DD2(var_0) {
  if(isDefined(self._id_CE7D) && self._id_CE7D == "allies" && isDefined(var_0) && isPlayer(var_0)) {
    return 1;
  } else if(isai(var_0) && scripts\engine\utility::is_equal(var_0.team, self._id_CE7D)) {
    return 1;
  } else {
    return 0;
  }
}

_id_1DD1(var_0) {
  if(isDefined(var_0) && isDefined(var_0._id_CE7D) && isDefined(self._id_CE7D) && var_0._id_CE7D == self._id_CE7D) {
    return 1;
  }

  return 0;
}

_id_10257(var_0) {
  self._id_1035C = scripts\engine\utility::ter_op(var_0 <= 0, 0, 1);
}

_id_10237() {
  self endon("entitydeleted");
  self endon("death");

  if(!isDefined(level.vehicle._id_F078._id_572F[self.model])) {
    return;
  }
  for(;;) {
    playFXOnTag(level.vehicle._id_F078._id_572F[self.model], self, "tag_engine_exhaust");
    waitframe();
  }
}

_id_10232() {
  var_0 = level.vehicle._id_F078._id_545C[self.classname];

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = 0.25;
  var_2 = undefined;
  var_3 = undefined;

  for(;;) {
    if(!_id_1011E(self)) {
      return;
    }
    var_4 = var_0._id_5106;
    var_3 = var_0._id_510B;
    var_5 = self _meth_842E() / self _meth_864D();

    if(isDefined(self._id_5461)) {
      var_5 = var_5 * self._id_5461;
    }

    if(isDefined(var_0._id_9C16) && var_5 >= var_0._id_9C17) {
      var_4 = var_0._id_9C16;
    } else if(isDefined(var_0._id_9CD9) && var_5 >= var_0._id_9CDA) {
      var_4 = var_0._id_9CD9;
    } else if(isDefined(var_0._id_9E9B) && var_5 >= var_0._id_9E9C) {
      var_4 = var_0._id_9E9B;
    }

    if(!isDefined(var_2) || var_2 != var_4) {
      if(isDefined(var_2)) {
        stopFXOnTag(var_2, self, var_3);
        waitframe();

        if(!_id_1011E(self)) {
          return;
        }
      }

      playFXOnTag(var_4, self, var_3);
      var_2 = var_4;
    }

    wait(var_1);
  }
}

_id_100A0() {
  var_0 = level.vehicle._id_F078._id_BF17[self.classname];

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;

  for(;;) {
    if(!_id_1011E(self)) {
      return;
    }
    var_4 = self _meth_8188();

    if(isDefined(var_4) && isPlayer(var_4)) {
      var_5 = self _meth_842E() / self _meth_864D();

      if(isDefined(var_0._id_9C16) && var_5 >= var_0._id_9C17) {
        if(var_1 != var_0._id_9C16) {
          var_1 = var_0._id_9C16;
          var_2 = (var_1 - getdvarfloat("#x31f9ba2c1834330ea")) / 5;
          var_3 = 0;
        }
      } else if(isDefined(var_0._id_9CD9) && var_5 >= var_0._id_9CDA) {
        if(var_1 != var_0._id_9CD9) {
          var_1 = var_0._id_9CD9;
          var_2 = (var_1 - getdvarfloat("#x31f9ba2c1834330ea")) / 5;
          var_3 = 0;
        }
      } else if(isDefined(var_0._id_9E9B) && var_5 >= var_0._id_9E9C) {
        if(var_1 != var_0._id_9E9B) {
          var_1 = var_0._id_9E9B;
          var_2 = (var_1 - getdvarfloat("#x31f9ba2c1834330ea")) / 5;
          var_3 = 0;
        }
      } else if(var_5 < var_0._id_9E9C) {
        if(var_1 != 0.0) {
          var_1 = 0.0;
          var_2 = (var_1 - getdvarfloat("#x31f9ba2c1834330ea")) / 5;
          var_3 = 0;
        }
      }
    } else if(var_1 != 0.0) {
      var_1 = 0.0;
      var_2 = (var_1 - getdvarfloat("#x31f9ba2c1834330ea")) / 5;
      var_3 = 0;
    }

    if(var_3 < 5) {
      var_6 = getdvarfloat("#x31f9ba2c1834330ea");
      setsaveddvar("#x31f9ba2c1834330ea", var_6 + var_2);
      var_3++;
    }

    waitframe();
  }
}

_id_1022B() {
  self._id_1D83 = undefined;
  self notify("newpath");

  if(_id_8897()) {
    self _meth_8329(scripts\engine\utility::_id_5CD9(self.angles)[1]);
    self setvehgoalpos(self.origin + (0, 0, 4), 1);
  }
}

_id_43FC() {
  if(self.health > 0) {
    self._id_C8C9 = 1;
  }
}

_id_43FB() {
  self._id_C8C9 = undefined;
  self notify("deathrolloff");
}

_id_0C58() {
  if(!isDefined(self._id_997E)) {
    return;
  }
  _id_0D9B(self._id_997E);
}

_id_0C59() {
  if(!isDefined(self._id_997E)) {
    return;
  }
  _id_0D9C(self._id_997E);
}

_id_0C57() {
  if(!isDefined(self._id_997E)) {
    return;
  }
  _id_0D9A(self._id_997E);
}

_id_73FA(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  var_2 = self;

  if(isDefined(var_2._id_CE9E)) {
    if(var_2._id_CE9E == 0) {
      var_0 thread _id_0C58();
    } else if(var_2._id_CE9E == 1) {
      var_0 thread _id_0C59();
    } else if(var_2._id_CE9E == 2) {
      var_0 thread _id_0C57();
    }
  }
}

_id_73FB(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  var_2 = self;

  if(isDefined(var_2._id_CE9F)) {
    if(var_2._id_CE9F == 0) {
      var_0 _id_0C62();
    } else if(var_2._id_CE9F == 1) {
      var_0 _id_0C63();
    } else if(var_2._id_CE9F == 2) {
      var_0 _id_0C61();
    }
  }

  var_3 = scripts\engine\utility::_id_636C(var_2._id_CEA1);
  var_3 = scripts\engine\utility::_id_1BD1(var_3, 1);

  if(!isDefined(var_3) || var_3.size == 0) {
    return;
  }
  var_4 = [];
  var_5 = [];
  var_6 = [];

  foreach(var_9, var_8 in var_3) {
    if(var_8 == 2) {
      var_6[var_6.size] = var_9;
      continue;
    }

    if(var_8 == 1) {
      var_4[var_4.size] = var_9;
      continue;
    }

    if(var_8 == 0) {
      var_5[var_5.size] = var_9;
    }
  }

  if(isDefined(var_5) && var_5.size > 0) {
    var_0 thread _id_0C62(var_5);
  }

  if(isDefined(var_4) && var_4.size > 0) {
    var_0 thread _id_0C63(var_4);
  }

  if(isDefined(var_6) && var_6.size > 0) {
    var_0 thread _id_0C61(var_6);
  }
}

_id_0C62(var_0) {
  if(_id_8897() && _id_7571()) {
    if(isDefined(level._id_36E8)) {
      self thread[[level._id_36E9]]();
      return;
    }
  }

  if(!isDefined(self._id_9E6C)) {
    return;
  }
  foreach(var_3, var_2 in self._id_9E6C) {
    if(isDefined(var_0) && !scripts\engine\utility::array_contains(var_0, var_3)) {
      continue;
    }
    _id_0D9B(var_2);
  }
}

_id_0C63(var_0) {
  if(_id_8897() && _id_7571()) {
    self thread[[level._id_36EA]]();
    return;
  }

  if(!isDefined(self._id_9E6C)) {
    return;
  }
  foreach(var_2 in self._id_9E6C) {
    var_2 show();
    _id_0D9C(var_2);
  }
}

_id_0C61(var_0) {
  if(!isDefined(self._id_9E6C)) {
    return;
  }
  foreach(var_3, var_2 in self._id_9E6C) {
    if(isDefined(var_0) && !scripts\engine\utility::array_contains(var_0, var_3)) {
      continue;
    }
    _id_0D9A(var_2);
  }
}

_id_0D9B(var_0) {
  if(isDefined(var_0._id_CD43)) {
    var_0._id_CD43 = 0;
  }

  var_0 notify("kill_burst_fire_do_shoot_nonstop");
  var_0 setmode("manual");
}

_id_0D9C(var_0) {
  if(isDefined(var_0._id_CD43)) {
    var_0._id_CD43 = 1;
  }

  if(isDefined(var_0._id_45BA)) {
    if(var_0._id_45BA != "sentry") {
      if(var_0._id_45BA == "manual") {
        var_0 setmode("auto_nonai");
      } else {
        var_0 setmode(var_0._id_45BA);
      }
    }
  } else
    var_0 setmode("auto_nonai");

  var_0 notify("kill_burst_fire_do_shoot_nonstop");
  _id_D3FA(var_0);
}

_id_0D9A(var_0) {
  if(isDefined(var_0._id_CD43)) {
    var_0._id_CD43 = 0;
  }

  var_0 setmode("manual");
  var_0 thread _id_06E3::_id_2D9B(undefined, 1);
}

_id_681A() {
  var_0 = [];

  if(isDefined(self.target)) {
    var_1 = scripts\engine\utility::_id_A5DA("getspawnerarray", self.target);

    if(!isDefined(var_1)) {
      var_1 = scripts\engine\utility::getStructArray(self.target, "targetname");
    }

    if(!isDefined(var_1)) {
      var_1 = [];
    }

    foreach(var_3 in var_1) {
      if(_func_02DE(var_3)) {
        if(!isDefined(var_3._id_CD03)) {
          continue;
        }
      } else {
        if(!issubstr(var_3._id_00EC, "actor") && !issubstr(var_3._id_00EC, "vehicle")) {
          continue;
        }
        if(issubstr(var_3._id_00EC, "actor")) {
          if(!_func_011E(var_3)) {
            continue;
          } else if(issubstr(var_3._id_00EC, "vehicle")) {
            if(!(var_3._id_03EA & 2)) {
              continue;
            }
          }
        }
      }

      if(isDefined(var_3._id_4D78)) {
        continue;
      }
      var_0[var_0.size] = var_3;
    }
  }

  return var_0;
}

_id_1027B(var_0) {
  if(isDefined(var_0._id_CD00)) {
    var_0 endon("death");
    wait(var_0._id_CD00);
  }

  if(!scripts\common\utility::issp()) {
    var_1 = _id_10286(var_0);
  } else {
    var_1 = var_0 _meth_842B();
  }

  if(!isDefined(var_0._id_E2A3)) {
    var_0._id_E2A3 = 0;
  }

  var_0._id_E2A3++;
  var_0._id_10294 = var_1;
  var_0._id_8F5F = var_1;
  var_0 thread _id_C45A();
  var_1._id_10295 = var_0;
  thread _id_100E0(var_1);
  var_0 notify("spawned", var_1);
  return var_1;
}

_id_10286(var_0) {
  var_1 = "temp_vehicle_targetname";

  if(isDefined(var_0._id_0481)) {
    var_1 = var_0._id_0481;
  }

  if(!isDefined(var_0._id_3804)) {
    var_2 = var_0.classname;
  } else {
    var_2 = var_0._id_3804;
  }

  var_3 = _func_0216(level.vehicle._id_F078.model[var_2], var_1, var_0._id_04DE, var_0.origin, var_0.angles);
  var_3._id_04DE = var_0._id_04DE;
  var_3._id_3804 = var_2;

  if(isDefined(var_0.target)) {
    var_3.target = var_0.target;
  }

  return var_3;
}

_id_D8DA(var_0, var_1) {
  return _id_0CF6(var_0, var_1);
}

_id_10132(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 512;
  }

  var_1 = self.origin + (0, 0, var_0);
  self setneargoalnotifydist(10);
  _id_D8DA(var_1, 1);
  self waittill("goal");
}

_id_1025E(var_0) {
  if(!_id_100D5(var_0)) {
    return 0;
  }

  if(istrue(self._id_10261)) {
    return 0;
  }

  return 1;
}

_id_100D5(var_0) {
  return isDefined(level.vehicle._id_F078._id_43D4[var_0 _id_6810()]);
}

_id_100B8(var_0, var_1) {
  var_2 = level.vehicle._id_F078._id_43D4[var_0 _id_6810()];

  if(isDefined(var_1)) {
    var_3 = var_0 _meth_8174(0.5, 0.5, 0.5);
    var_4 = var_1 - var_3;
    var_5 = [];
    var_5["forward"] = anglesToForward(var_0.angles);
    var_5["right"] = anglestoright(var_0.angles);
    var_5["backward"] = var_5["forward"] * -1;
    var_5["left"] = var_5["right"] * -1;
    var_6 = undefined;
    var_7 = -999999;
    var_8 = ["forward", "right", "backward", "left"];

    foreach(var_10 in var_8) {
      var_11 = var_5[var_10];
      var_12 = scripts\engine\math::_id_CB75(var_11, var_4);

      if(!isDefined(var_6) || var_12 > var_7) {
        var_6 = var_10;
        var_7 = var_12;
      }
    }

    return var_2[var_6];
  } else
    return scripts\engine\utility::random(var_2);
}

_id_10230(var_0) {
  self _meth_843A();
  scripts\engine\utility::_id_D07A("vehicle_orientto", self.origin, self.angles, 0, 0);
  self useanimtree(#animtree);
  self _meth_801B("vehicle_playDeathAnimation", self.origin, self.angles, var_0);
  self setneargoalnotifydist(30);

  if(scripts\common\vehicle::_id_8896()) {
    self setvehgoalpos(self.origin, 1);
    self _meth_8329(self.angles[1]);
  }
}

_id_10251(var_0) {
  self._id_102F4 = var_0;
}

_id_1009F(var_0, var_1) {
  if(istrue(self._id_10262)) {
    return;
  }
  _id_10251(1);

  if(self _meth_8434()) {
    self _meth_8444();

    if(!istrue(self._id_4D9D)) {
      self _meth_80B5();
    }

    while(!_id_1011F() && isDefined(self) && !_id_1011C()) {
      waitframe();
    }
  } else if(_id_8897()) {
    thread _id_100D8(var_0, var_1);
    self waittill("vehicle_crashDone");
  }

  _id_10251(0);
}

_id_100D8(var_0, var_1) {
  if(isDefined(var_0) && isPlayer(var_0)) {
    self._id_AC83 = var_0;
  }

  if(!isDefined(self)) {
    return;
  }
  _id_4884();
  thread _id_7779(var_0, var_1);
}

_id_7779(var_0, var_1) {
  self endon("in_air_explosion");

  if(isDefined(self._id_AF94)) {
    var_2 = self._id_AF94;
  } else {
    var_3 = _id_6800();
    var_2 = scripts\engine\utility::_id_6969(self.origin, var_3);
  }

  var_2._id_37F0 = 1;
  self notify("newpath");
  self notify("deathspin");
  var_4 = 0;
  var_5 = 0;

  if(isDefined(var_2._id_CE18) && var_2._id_CE18 == "direct") {
    var_5 = 1;
  }

  if(isDefined(self._id_768E)) {
    var_5 = 0;
    var_4 = self._id_768E;
  }

  if(var_5) {
    var_6 = 40;
    self vehicle_setspeed(var_6, 15, 10);
    self setneargoalnotifydist(var_2._id_0359);
    self setvehgoalpos(var_2.origin, 0);
    thread _id_7775(var_2.origin, var_6);
    scripts\engine\utility::waittill_any_2("goal", "near_goal");
    _id_777A(var_2);
  } else {
    var_7 = (var_2.origin[0], var_2.origin[1], self.origin[2] + var_4);

    if(isDefined(self._id_768F)) {
      var_7 = self.origin + self._id_768F * self _meth_8431();
      var_7 = (var_7[0], var_7[1], var_7[2] + var_4);
    }

    var_6 = 20;

    if(isDefined(self._id_3E63)) {
      var_6 = self._id_3E63;
    }

    self vehicle_setspeed(var_6, 10, 10);
    self setneargoalnotifydist(350);
    self setvehgoalpos(var_7, 1);
    thread _id_7775(var_7, 40);
    var_8 = "blank";

    while(var_8 != "death") {
      var_8 = scripts\engine\utility::waittill_any_3("goal", "near_goal", "death");

      if(!isDefined(var_8) && !isDefined(self)) {
        var_2._id_37F0 = undefined;
        self notify("vehicle_crashDone");
        return;
      } else
        var_8 = "death";
    }

    self setvehgoalpos(var_2.origin, 0);
    self waittill("goal");
    _id_777A(var_2);
  }

  var_2._id_37F0 = undefined;
  self notify("stop_crash_loop_sound");
  self notify("vehicle_crashDone");
}

_id_777A(var_0) {
  self endon("death");
  self endon("entitydeleted");

  while(isDefined(var_0.target)) {
    var_0 = scripts\engine\utility::getstruct(var_0.target, "targetname");
    var_1 = 56;

    if(isDefined(var_0._id_0359)) {
      var_1 = var_0._id_0359;
    }

    self setneargoalnotifydist(var_1);
    self setvehgoalpos(var_0.origin, 0);
    scripts\engine\utility::waittill_any_2("goal", "near_goal");
  }
}

_id_7775(var_0, var_1) {
  self endon("vehicle_crashDone");
  self _meth_807E();

  if(_func_0205("hind_helicopter_dying_loop")) {
    self playLoopSound("hind_helicopter_dying_loop");
  }

  var_2 = 0;

  if(isDefined(self._id_BB8C)) {
    var_2 = self._id_BB8C;

    if(self._id_BB8C < 0) {
      var_3 = [1, 2, 2];
      var_4 = 5;
      var_5 = randomint(var_4);
      var_6 = 0;

      foreach(var_9, var_8 in var_3) {
        var_6 = var_6 + var_8;

        if(var_5 < var_6) {
          var_2 = var_9;
          break;
        }
      }
    }
  }

  switch (var_2) {
    case 1:
      thread _id_7780();
      break;
    case 2:
      thread _id_7771(var_0, var_1);
      break;
    case 3:
      thread _id_7786();
      break;
    case 4:
      thread _id_778A();
      break;
    case 0:
    default:
      thread _id_777D();
      break;
  }
}

_id_7786() {
  var_0 = _id_6810();

  if(isDefined(level.vehicle._id_F078._id_1024D[var_0])) {
    var_1 = level.vehicle._id_F078._id_1024D[var_0];
    var_2 = var_1[1];

    if(isDefined(var_2._id_107E9)) {
      wait(var_2._id_107E9);
    }

    waitframe();
  }

  self notify("vehicle_crashDone");
  self notify("in_air_explosion");
}

_id_778A() {
  thread _id_777D();
  scripts\engine\utility::_id_108F5("goal", 3);
  self notify("flavor_done");
  thread _id_7786();
}

_id_7792() {
  if(!scripts\common\vehicle::_id_8896()) {
    return;
  }
  self endon("vehicle_crashDone");
  self waittill("unloading");
  self._id_F97D = 1;
  self waittill("unloaded");
  self._id_F97D = 0;
}

_id_7771(var_0, var_1) {
  self endon("vehicle_crashDone");
  self _meth_807E();
  self setmaxpitchroll(randomintrange(20, 90), randomintrange(5, 90));
  self setyawspeed(400, 100, 100);
  var_2 = 90 * randomintrange(-2, 3);

  for(;;) {
    var_3 = var_0 - self.origin;
    var_4 = _func_0261(var_3);
    var_4 = var_4 + var_2;
    self _meth_838A(var_4);
    wait 0.1;
  }
}

_id_7780() {
  self endon("vehicle_crashDone");
  self _meth_807E();
  self setyawspeed(400, 100, 100);
  var_0 = randomint(2);

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    var_1 = randomintrange(20, 120);

    if(var_0) {
      self _meth_838A(self.angles[1] + var_1);
    } else {
      self _meth_838A(self.angles[1] - var_1);
    }

    var_0 = 1 - var_0;
    var_2 = randomfloatrange(0.5, 1.0);
    wait(var_2);
  }
}

_id_777D() {
  self endon("vehicle_crashDone");
  self _meth_807E();
  self setmaxpitchroll(60, 90);
  self setyawspeed(700, 200, 200);

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    var_0 = randomintrange(140, 170);
    self _meth_838A(self.angles[1] + var_0);
    wait 0.5;
  }
}

_id_6800() {
  var_0 = [];
  level.vehicle._id_7777 = scripts\engine\utility::_id_1BD1(level.vehicle._id_7777);

  foreach(var_2 in level.vehicle._id_7777) {
    if(isDefined(var_2._id_37F0)) {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

_id_1011F() {
  return isDefined(self) && _id_6810() == "script_vehicle_corpse";
}

_id_4884() {
  if(!isDefined(self._id_59C0)) {
    return;
  }
  if(!self._id_59C0.size) {
    return;
  }
  var_0 = getarraykeys(self._id_59C0);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(self._id_59C0[var_0[var_1]])) {
      self._id_59C0[var_0[var_1]] unlink();
    }
  }
}

_id_10252() {
  if(!isDefined(level.vehicle._id_F078._id_43F3[self.model])) {
    return;
  }
  if(istrue(self._id_10263)) {
    return;
  }
  if(isDefined(self._id_1002B)) {
    self setModel(self._id_1002B);
  } else {
    self setModel(level.vehicle._id_F078._id_43F3[self.model]);
  }
}

_id_E2B6() {
  self endon("death");
  var_0 = 0;
  var_1 = 0;
  var_2 = 0;
  var_3 = self.origin[2] - 10.0;
  var_4 = self.angles[1];

  if(!isDefined(self._id_9E6C) || self._id_9E6C.size == 0) {
    return;
  }
  if(!isDefined(self)) {
    return;
  }
  for(;;) {
    var_1 = !isDefined(self._id_CD0E) || !self._id_CD0E;
    waittillframeend;

    if(!var_1) {
      if(var_1 != var_2 && var_0) {
        _id_E2B4();
        var_0 = 0;
      }

      var_3 = self.origin[2];
      var_4 = self.angles[1];
      var_2 = var_1;
      waitframe();
      continue;
    }

    var_5 = _id_E2B7(var_3, var_4);

    if(var_5 && var_0) {
      _id_E2B4();
      var_0 = 0;
    } else if(!var_5 && !var_0) {
      _id_E2B5();
      var_0 = 1;
    }

    var_3 = self.origin[2];
    var_4 = self.angles[1];
    var_2 = var_1;
    wait 0.5;
  }
}

_id_E2B7(var_0, var_1) {
  return abs(var_1 - self.angles[1]) > 1.0 || abs(var_0 - self.origin[2]) > 0.05 || self _meth_842E() > 0.01;
}

_id_E2B5() {
  foreach(var_2, var_1 in self._id_9E6C) {
    if(isDefined(level._id_5D4D)) {
      [[level._id_5D4D]](self._id_9E6C[var_2]);
    }
  }
}

_id_E2B4() {
  foreach(var_2, var_1 in self._id_9E6C) {
    if(isDefined(level._id_5D4F)) {
      [[level._id_5D4F]](self._id_9E6C[var_2]);
    }
  }
}