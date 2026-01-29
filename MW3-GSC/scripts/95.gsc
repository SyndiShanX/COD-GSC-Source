/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\95.gsc
**************************************/

_id_1E92() {
  if(isDefined(level._id_28F2) && level._id_28F2) {
    return;
  }
  level._id_28F3 = 10;
  _id_28F5();
  _id_28F7();
  _id_2A4C();
  _id_2A4E();
  _id_2900();
  common_scripts\utility::array_thread(getEntArray("truckjunk", "targetname"), ::_id_2974);
  common_scripts\utility::array_thread(getEntArray("truckjunk", "script_noteworthy"), ::_id_2974);
  common_scripts\utility::array_thread(common_scripts\utility::getstructarray("truckjunk", "targetname"), ::_id_2974);
  common_scripts\utility::array_thread(common_scripts\utility::getstructarray("truckjunk", "script_noteworthy"), ::_id_2974);
  _id_2A21();
  _id_2A29();
  var_0 = _id_2A05();
  _id_2A2B(var_0);
  common_scripts\utility::array_levelthread(level._id_28F4, ::_id_2906, var_0);
  common_scripts\utility::array_thread(common_scripts\utility::getstructarray("gag_stage_littlebird_unload", "script_noteworthy"), ::_id_2B06);
  common_scripts\utility::array_thread(common_scripts\utility::getstructarray("gag_stage_littlebird_load", "script_noteworthy"), ::_id_2B07);
  level._id_28F4 = undefined;
  _id_28F9();
  maps\_utility::add_hint_string("invulerable_frags", &"SCRIPT_INVULERABLE_FRAGS", undefined);
  maps\_utility::add_hint_string("invulerable_bullets", &"SCRIPT_INVULERABLE_BULLETS", undefined);
}

_id_28F5() {
  level._id_28F6 = [];
  level._id_28F6["blackhawk"] = 1;
  level._id_28F6["blackhawk_minigun"] = 1;
  level._id_28F6["apache"] = 1;
  level._id_28F6["seaknight"] = 1;
  level._id_28F6["seaknight_airlift"] = 1;
  level._id_28F6["hind"] = 1;
  level._id_28F6["ny_harbor_hind"] = 1;
  level._id_28F6["ny_harbor_blackhawk"] = 1;
  level._id_28F6["mi17"] = 1;
  level._id_28F6["mi17_noai"] = 1;
  level._id_28F6["cobra"] = 1;
  level._id_28F6["cobra_player"] = 1;
  level._id_28F6["viper"] = 1;
  level._id_28F6["littlebird_player"] = 1;
  level._id_28F6["littlebird"] = 1;
  level._id_28F6["mi28"] = 1;
  level._id_28F6["pavelow"] = 1;
  level._id_28F6["pavelow_noai"] = 1;
  level._id_28F6["harrier"] = 1;
  level._id_28F6["lynx"] = 1;
  level._id_28F6["blackhawk_so"] = 1;
  level._id_28F6["blackhawk_minigun_so"] = 1;
  level._id_28F6["blackhawk_minigun_so_ac130"] = 1;
  level._id_28F6["cobra_so"] = 1;
  level._id_28F6["mi17_so"] = 1;
  level._id_28F6["mi17_so_takes_damage"] = 1;
  level._id_28F6["littlebird_so"] = 1;
}

_id_28F7() {
  level._id_28F8 = [];
  level._id_28F8["mig29"] = 1;
  level._id_28F8["b2"] = 1;
  level._id_28F8["a10_warthog"] = 1;
  level._id_28F8["osprey"] = 1;
}

_id_28F9() {
  level._id_21EB = 0;
  var_0 = getEntArray("script_vehicle", "code_classname");

  if(var_0.size > 0) {
    level._id_21EB = 1;
  }
}

_id_28FA(var_0) {
  var_1 = [];

  if(isDefined(var_0.script_linkto)) {
    var_2 = strtok(var_0.script_linkto, " ");

    foreach(var_4 in var_2) {}
    var_1[var_4] = 1;

    var_2 = undefined;
  }

  return var_1;
}

_id_28FB(var_0) {
  var_1 = [];

  if(isDefined(var_0._id_28FC)) {
    return level._id_28FD[var_0._id_28FC];

  }
  return var_1;
}

_id_28FE(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0._id_28FF)) {
    var_2 = 1;

  }
  return var_2;
}

_id_2900() {
  var_0 = _id_26A4();

  foreach(var_2 in var_0) {}
  var_2 thread _id_2901();
}

_id_2901() {
  if(isDefined(self._id_1EB4)) {
    var_0 = self._id_1EB4;

    if(!isDefined(level._id_2902[var_0])) {
      level._id_2902[var_0] = [];

    }
    level._id_2902[var_0][level._id_2902[var_0].size] = self;
  }

  if(isDefined(self._id_2116)) {
    thread maps\_spawner::_id_211A();

  }
  thread _id_2903();
  self.count = 1;
  self._id_214D = [];

  for(;;) {
    var_1 = undefined;
    self waittill("spawned", var_1);
    self.count--;

    if(!isDefined(var_1)) {
      continue;
    }
    var_1._id_1E97 = self._id_214D;
    var_1.spawner = self;
    var_1 thread maps\_spawner::_id_2152();
  }
}

_id_2903() {
  if(!isDefined(self._id_2904)) {
    return;
  }
  if(!isDefined(self.script_linkto)) {
    return;
  }
  var_0 = getEntArray(self.script_linkto, "script_linkname");

  if(var_0.size == 0) {
    return;
  }
  var_1 = var_0[0].targetname;
  var_0 = getEntArray(var_1, "targetname");
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(var_4.classname == "script_origin") {
      var_2 = var_4;

    }
    var_4 hide();
  }

  foreach(var_4 in var_0) {
    if(var_4 != var_2) {
      var_4 linkto(var_2);
    }
  }

  self waittill("spawned", var_8);

  foreach(var_4 in var_0) {
    var_4 show();

    if(var_4 != var_2) {
      var_4 linkto(var_8);
    }
  }

  var_8 waittill("death");

  foreach(var_4 in var_0) {}
  var_4 delete();
}

_id_2905() {
  if(!isDefined(self.classname)) {
    return 0;

  }
  if(self.classname == "trigger_multiple") {
    return 1;

  }
  if(self.classname == "trigger_radius") {
    return 1;

  }
  if(self.classname == "trigger_lookat") {
    return 1;

  }
  return self.classname == "trigger_disk";
}

_id_2906(var_0, var_1) {
  var_2 = var_0 _id_2905();
  var_0._id_2907 = undefined;

  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "trigger_multiple") {
    var_2 = 0;

  }
  var_3 = _id_28FB(var_0);
  var_4 = isDefined(var_0._id_28FF);
  var_5 = isDefined(var_0._id_2908) && (_id_2A25(var_0) || _id_2A2A(var_0));
  var_6 = isDefined(var_0._id_2909) && !(_id_2A25(var_0) || _id_2A2A(var_0));
  var_7 = 1;
  var_1 = undefined;

  while(var_7) {
    var_0 waittill("trigger", var_8);

    if(isDefined(var_0._id_290A)) {
      if(!isDefined(var_8._id_290A)) {
        continue;
      }
      if(var_8._id_290A != var_0._id_290A) {
        continue;
      }
    }

    if(isDefined(var_0.enabled) && !var_0.enabled) {
      var_0 waittill("enable");

    }
    if(isDefined(var_0._id_2057)) {
      if(isDefined(var_8._id_290B)) {
        var_8._id_290B[var_0._id_2057] = 1;

      }
      var_8 notify("vehicle_flag_arrived", var_0._id_2057);
      common_scripts\utility::flag_set(var_0._id_2057);
    }

    if(isDefined(var_0._id_2059)) {
      if(isDefined(var_8._id_290B)) {
        var_8._id_290B[var_0._id_2059] = 0;

      }
      common_scripts\utility::flag_clear(var_0._id_2059);
    }

    if(var_5) {
      var_8 thread _id_2912(var_0);
    } else if(var_6 && isDefined(var_8)) {
      var_8 thread _id_2917(var_0);

    }
    var_0 maps\_utility::script_delay();

    if(var_2) {
      var_7 = 0;

    }
    if(isDefined(var_0._id_290C)) {
      if(!isDefined(level._id_290D[var_0._id_290C])) {
        level._id_290D[var_0._id_290C] = [];

      }
      common_scripts\utility::array_levelthread(level._id_290D[var_0._id_290C], maps\_utility::_id_1E93);
    }

    if(var_4) {
      _id_2971(var_0._id_28FF);

    }
    if(var_3.size > 0 && var_2) {
      common_scripts\utility::array_levelthread(var_3, ::_id_296D);

    }
    if(isDefined(var_0._id_290E)) {
      if(!isDefined(level._id_290F[var_0._id_290E])) {
        return;
      }
      common_scripts\utility::array_levelthread(level._id_290F[var_0._id_290E], ::_id_1FA6);
    }
  }
}

_id_2910(var_0) {
  var_1 = undefined;

  foreach(var_3 in level._id_2911[var_0._id_2908]) {
    if(var_3 != var_0) {
      if(!_id_2939(var_3)) {
        var_1 = var_3;
      }
    }
  }

  return var_1;
}

_id_2912(var_0) {
  var_1 = _id_2910(var_0);

  if(isDefined(var_1)) {
    thread _id_26A1(var_1);
  }
}

_id_2913(var_0) {
  return (isDefined(self._id_252D) || self.health < self._id_163B || var_0._id_2914 == "forced") && (!isDefined(var_0._id_2915) || var_0._id_2914 == "plane");
}

_id_2916(var_0) {
  return isDefined(var_0._id_2915) && var_0._id_2915;
}

_id_2917(var_0) {
  var_1 = getvehiclenode(var_0.target, "targetname");
  var_2 = _id_2910(var_1);

  if(!isDefined(var_2)) {
    return;
  }
  if(var_0._id_2909 && !isDefined(var_2._id_2918)) {
    return;
  }
  if(isDefined(var_2._id_2914)) {
    if(!_id_2913(var_2)) {
      return;
    }
    self notify("crashpath", var_2);
    var_2._id_2915 = 1;
    self notify("newpath");
    _id_291D(var_0, var_2);
    return;
  } else {
    if(_id_2916(var_2)) {
      return;
    }
    if(isDefined(var_2._id_2918)) {
      if(!isDefined(self._id_2918)) {
        return;
      }
      if(var_2._id_2918 != self._id_2918) {
        return;
      }
    }

    self notify("newpath");
    _id_291D(var_1, var_2);
    thread _id_291E(var_2);

    if(!_id_2939(var_1) && !(isDefined(var_0._id_2919) && var_0._id_2919)) {
      var_0._id_2909 = 1;

    }
    self._id_291A = var_2;
    thread _id_26A1();

    if(self isphysveh() && isDefined(var_1._id_291B)) {
      thread _id_291C(var_1);

    }
    return;
  }
}

_id_291C(var_0) {
  self endon("death");
  var_0 waittillmatch("trigger", self);
  self.veh_transmission = var_0._id_291B;

  if(self.veh_transmission == "forward") {
    _id_2AA7();
  } else {
    _id_2AA8();
  }
}

_id_291D(var_0, var_1) {
  self setswitchnode(var_0, var_1);
}

_id_291E(var_0) {
  self endon("death");
  self._id_291F = var_0;
  var_0 waittillmatch("trigger", self);
  self._id_291F = undefined;
}

_id_2920(var_0, var_1) {
  if(isDefined(var_0.script_linkname)) {
    level._id_2921 = _id_2A24(level._id_2921, var_0.script_linkname, var_0);

  }
  if(isDefined(var_0._id_290E)) {
    level._id_290F = _id_2A24(level._id_290F, var_0._id_290E, var_0);

  }
  if(isDefined(var_0._id_290C)) {
    level._id_290D = _id_2A24(level._id_290D, var_0._id_290C, var_0);
  }
}

_id_2922(var_0) {
  var_1 = [];
  var_2 = maps\_utility::_id_133C("no_riders_until_unload");

  foreach(var_4 in var_0) {
    var_4.count = 1;
    var_5 = 0;

    if(isDefined(var_4._id_212C)) {
      var_5 = 1;
      var_6 = maps\_utility::_id_26E2(var_4);
      var_6 maps\_drone::_id_1FFE();
    } else {
      var_7 = isDefined(var_4._id_212E) && common_scripts\utility::flag("_stealth_enabled") && !common_scripts\utility::flag("_stealth_spotted");

      if(isDefined(var_4._id_212F) || var_2) {
        var_6 = var_4 stalingradspawn(var_7);
      } else {
        var_6 = var_4 dospawn(var_7);
      }
    }

    if(!var_5 && !isalive(var_6)) {
      continue;
    }
    var_1[var_1.size] = var_6;
  }

  var_1 = _id_2923(var_1);
  return var_1;
}

_id_2923(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(!_id_2924(var_3)) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_2924(var_0) {
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

_id_2925() {
  var_0 = [];

  if(isDefined(self.target)) {
    var_1 = getEntArray(self.target, "targetname");

    foreach(var_3 in var_1) {
      if(!issubstr(var_3.code_classname, "actor")) {
        continue;
      }
      if(!(var_3.spawnflags & 1)) {
        continue;
      }
      if(isDefined(var_3._id_1FA2)) {
        continue;
      }
      var_0[var_0.size] = var_3;
    }
  }

  if(!isDefined(self._id_250B)) {
    return var_0;

  }
  if(isDefined(level._id_2926[self._id_250B])) {
    var_0 = common_scripts\utility::array_combine(var_0, level._id_2926[self._id_250B]);

  }
  return var_0;
}

_id_2927() {
  if(!isDefined(self._id_250B)) {
    return [];

  }
  if(!isDefined(level._id_2928[self._id_250B])) {
    return [];

  }
  return level._id_2928[self._id_250B];
}

_id_2929() {
  if(maps\_utility::_id_133C("no_riders_until_unload") && !maps\_utility::_id_1008("no_riders_until_unload")) {
    return [];

  }
  var_0 = _id_2925();

  if(!var_0.size) {
    return [];

  }
  var_1 = [];
  var_2 = _id_2922(var_0);
  var_2 = common_scripts\utility::array_combine(var_2, _id_2927());
  var_2 = _id_292B(var_2);

  foreach(var_4 in var_2) {}
  thread maps\_vehicle_aianim::_id_24E5(var_4);

  return var_2;
}

_id_292A(var_0) {
  if(!isDefined(var_0)) {
    return _id_2929();

  }
  var_1 = _id_2925();

  if(!var_1.size) {
    return [];

  }
  var_2 = [];
  var_3 = self.classname;

  if(maps\_utility::_id_1E25()) {
    var_3 = self.vehicletype;

  }
  if(isDefined(level._id_2566[var_3]) && isDefined(level._id_2566[var_3][var_0])) {
    var_4 = level._id_2566[var_3][var_0];

    for(var_5 = 0; var_5 < var_4.size; var_5++) {
      var_6 = var_4[var_5];
      var_2[var_2.size] = var_1[var_6];
    }

    var_7 = _id_2922(var_2);

    for(var_5 = 0; var_5 < var_4.size; var_5++) {
      var_7[var_5]._id_251B = var_4[var_5];

    }
    var_7 = common_scripts\utility::array_combine(var_7, _id_2927());
    var_7 = _id_292B(var_7);

    foreach(var_9 in var_7) {}
    thread maps\_vehicle_aianim::_id_24E5(var_9);

    return var_7;
  } else {
    return _id_2929();
  }
}

_id_292B(var_0) {
  var_1 = [];
  var_2 = [];

  foreach(var_4 in var_0) {
    if(isDefined(var_4._id_251B)) {
      var_1[var_1.size] = var_4;
      continue;
    }

    var_2[var_2.size] = var_4;
  }

  return common_scripts\utility::array_combine(var_1, var_2);
}

_id_292C(var_0) {
  if(!isDefined(self._id_292D)) {
    return;
  }
  if(isDefined(self._id_292E)) {
    self._id_292F = self._id_292E;
  } else {
    self._id_292F = "cover nodes";

  }
  if(!isDefined(self.target)) {
    return;
  }
  var_1 = getnode(self.target, "targetname");

  if(isDefined(var_1)) {
    self._id_2930 = var_1;
  }
}

_id_2931(var_0) {
  var_1 = [];
  var_2 = self._id_2932;
  var_3 = self._id_2933;
  var_4 = var_2[0];
  var_5 = 5000;
  var_6 = undefined;

  for(var_7 = 0; var_7 < var_2.size; var_7++) {
    var_8 = self gettagorigin(var_2[var_7]);
    var_9 = self gettagangles(var_2[var_7]);
    var_10 = getstartorigin(var_8, var_9, var_3[var_7]);
    var_11 = distance(var_0.origin, var_8);

    if(var_11 < var_5) {
      var_5 = var_11;
      var_4 = var_2[var_7];
      var_6 = var_7;
    }
  }

  var_9 = undefined;
  var_8 = undefined;
  thread _id_2935(var_0);

  while(!var_0._id_2934) {
    var_8 = self gettagorigin(var_2[var_6]);
    var_9 = self gettagangles(var_2[var_6]);
    var_10 = getstartorigin(var_8, var_9, var_3[var_6]);
    var_0 maps\_utility::_id_251E();
    var_0 setgoalpos(var_10);
    var_0.goalradius = 64;
    wait 0.25;
  }

  var_0 maps\_utility::_id_2521();

  if(self vehicle_getspeed() < 1) {
    var_0 linkto(self);
    var_0 animscripted("hopinend", var_8, var_9, var_3[var_6]);
    var_0 waittillmatch("hopinend", "end");
    maps\_utility::_id_2683(var_0);
  }
}

_id_2935(var_0) {
  var_0._id_2934 = 0;
  self endon("death");
  var_0 endon("death");
  var_0 waittill("goal");
  var_0._id_2934 = 1;
}

_id_2936(var_0) {
  var_1 = getvehiclenode(var_0.targetname, "target");

  if(!isDefined(var_1)) {
    return;
  }
  var_1._id_2909 = 0;
  _id_2938(var_1);
}

_id_2937() {
  var_0 = maps\_vehicle_aianim::_id_2565();

  foreach(var_3, var_2 in self._id_0A39) {
    if(!isalive(var_2)) {
      continue;
    }
    if(isDefined(var_0[var_2._id_2252])) {
      self._id_0A39[var_3] = maps\_vehicle_aianim::_id_2530(var_2, var_2._id_2252);
    }
  }
}

_id_2938(var_0) {
  if(isDefined(var_0._id_2907)) {
    return;
  }
  level._id_28F4[level._id_28F4.size] = var_0;
  var_0._id_2907 = 1;
}

_id_2939(var_0) {
  if(!isDefined(var_0.target)) {
    return 1;

  }
  if(!isDefined(getvehiclenode(var_0.target, "targetname")) && !isDefined(_id_2A87(var_0.target))) {
    return 1;

  }
  return 0;
}

_id_293A(var_0) {
  var_1 = ::_id_2AD7;

  if(_id_21ED() && isDefined(var_0.target)) {
    if(isDefined(_id_2AD4(var_0.target))) {
      var_1 = ::_id_2AD4;

    }
    if(isDefined(_id_2AD3(var_0.target))) {
      var_1 = ::_id_2AD3;
    }
  }

  return var_1;
}

_id_293B(var_0) {
  var_1 = ::_id_2AD7;

  if(_id_21ED() && isDefined(var_0.target)) {
    if(isDefined(_id_2AD4(var_0.target))) {
      var_1 = ::_id_2AD4;

    }
    if(isDefined(_id_2AD3(var_0.target))) {
      var_1 = ::_id_2AD3;
    }
  }

  var_2 = 0;
  var_3 = [];

  while(isDefined(var_0)) {
    var_3[var_2] = var_0;
    var_2++;

    if(isDefined(var_0.target)) {
      var_0 = [[var_1]](var_0.target);
      continue;
    }

    break;
  }

  return var_3;
}

_id_293C(var_0, var_1) {
  if(self._id_291A == var_0) {
    waittillframeend;
    return;
  }

  var_0 waittillmatch("trigger", self);
}

_id_26A1(var_0, var_1) {
  if(_id_21ED()) {
    _id_2951(var_0, var_1);
  } else {
    _id_293D(var_0);
  }
}

_id_293D(var_0) {
  self notify("newpath");

  if(isDefined(var_0)) {
    self._id_291A = var_0;

  }
  var_1 = self._id_291A;
  self.currentnode = self._id_291A;

  if(!isDefined(var_1)) {
    return;
  }
  self endon("newpath");
  var_2 = var_1;
  var_3 = undefined;
  var_4 = var_1;
  var_5 = _id_293A(var_1);

  while(isDefined(var_4)) {
    _id_293C(var_4, var_3);

    if(!isDefined(self)) {
      return;
    }
    self.currentnode = var_4;

    if(isDefined(var_4._id_293E) && !var_4._id_293E) {
      thread _id_296E(var_4);

    }
    if(isDefined(var_4.script_noteworthy)) {
      self notify(var_4.script_noteworthy);
      self notify("noteworthy", var_4.script_noteworthy);
    }

    waittillframeend;

    if(!isDefined(self)) {
      return;
    }
    if(isDefined(var_4.script_prefab_exploder)) {
      var_4.script_exploder = var_4.script_prefab_exploder;
      var_4.script_prefab_exploder = undefined;
    }

    if(isDefined(var_4.script_exploder)) {
      var_6 = var_4._id_1ED3;

      if(isDefined(var_6)) {
        level maps\_utility::delaythread(var_6, common_scripts\utility::exploder, var_4.script_exploder);
      } else {
        level common_scripts\utility::exploder(var_4.script_exploder);
      }
    }

    if(isDefined(var_4._id_2057)) {
      if(isDefined(self._id_290B)) {
        self._id_290B[var_4._id_2057] = 1;

      }
      self notify("vehicle_flag_arrived", var_4._id_2057);
      common_scripts\utility::flag_set(var_4._id_2057);
    }

    if(isDefined(var_4._id_2058)) {
      maps\_utility::_id_13DC(var_4._id_2058);

    }
    if(isDefined(var_4._id_293F)) {
      maps\_utility::_id_13DE(var_4._id_293F);

    }
    if(isDefined(var_4._id_2059)) {
      if(isDefined(self._id_290B)) {
        self._id_290B[var_4._id_2059] = 0;

      }
      common_scripts\utility::flag_clear(var_4._id_2059);
    }

    if(isDefined(var_4.script_noteworthy)) {
      if(var_4.script_noteworthy == "kill") {
        _id_2A11();

      }
      if(var_4.script_noteworthy == "godon") {
        _id_2A12();

      }
      if(var_4.script_noteworthy == "godoff") {
        _id_2A13();

      }
      if(var_4.script_noteworthy == "deleteme") {
        level thread maps\_utility::_id_1E93(self);
        return;
      }
    }

    if(isDefined(var_4._id_2940)) {
      self._id_2940 = var_4._id_2940;

    }
    if(isDefined(var_4._id_2941)) {
      self._id_2941 = var_4._id_2941;

    }
    if(isDefined(var_4._id_2942)) {
      self._id_2942 = var_4._id_2942;

    }
    if(isDefined(var_4.script_team)) {
      self.script_team = var_4.script_team;

    }
    if(isDefined(var_4._id_2943)) {
      self notify("turning", var_4._id_2943);

    }
    if(isDefined(var_4._id_2944)) {
      if(var_4._id_2944 == 0) {
        thread _id_2968();
      } else {
        thread _id_2966();
      }
    }

    if(isDefined(var_4._id_2945)) {
      if(isDefined(var_4._id_164F) && var_4._id_164F == "queue") {
        self._id_2946 = 1;
      }
    }

    if(isDefined(var_4._id_2947)) {
      _id_2AA9(var_4._id_2947);

    }
    if(_id_2953(::_id_293C, var_4)) {
      thread _id_2A8B(var_4);

    }
    if(isDefined(var_4._id_291B)) {
      self.veh_transmission = var_4._id_291B;

      if(self.veh_transmission == "forward") {
        _id_2AA7();
      } else {
        _id_2AA8();
      }
    }

    if(isDefined(var_4._id_2948)) {
      self.veh_brake = var_4._id_2948;

    }
    if(isDefined(var_4._id_2949)) {
      self.veh_pathtype = var_4._id_2949;

    }
    if(isDefined(var_4._id_294A)) {
      var_7 = 35;

      if(isDefined(var_4._id_294B)) {
        var_7 = var_4._id_294B;

      }
      self vehicle_setspeed(0, var_7);
      maps\_utility::_id_1654(var_4._id_294A);

      if(!isDefined(self)) {
        return;
      }
      var_8 = 60;

      if(isDefined(var_4.script_accel)) {
        var_8 = var_4.script_accel;

      }
      self resumespeed(var_8);
    }

    if(isDefined(var_4.script_delay)) {
      var_7 = 35;

      if(isDefined(var_4._id_294B)) {
        var_7 = var_4._id_294B;

      }
      self vehicle_setspeed(0, var_7);

      if(isDefined(var_4.target)) {
        thread _id_2956([[var_5]](var_4.target));

      }
      var_4 maps\_utility::script_delay();
      self notify("delay_passed");
      var_8 = 60;

      if(isDefined(var_4.script_accel)) {
        var_8 = var_4.script_accel;

      }
      self resumespeed(var_8);
    }

    if(isDefined(var_4._id_1288)) {
      if(!isDefined(self._id_290B)) {
        self._id_290B = [];

      }
      self._id_290B[var_4._id_1288] = 1;
      self notify("vehicle_flag_arrived", var_4._id_1288);
      var_9 = 0;

      if(!common_scripts\utility::flag(var_4._id_1288) || isDefined(var_4._id_1EE1)) {
        var_9 = 1;
        var_8 = 5;
        var_7 = 35;

        if(isDefined(var_4.script_accel)) {
          var_8 = var_4.script_accel;

        }
        if(isDefined(var_4._id_294B)) {
          var_7 = var_4._id_294B;

        }
        _id_29C3("script_flag_wait_" + var_4._id_1288, var_8, var_7);
        thread _id_2956([[var_5]](var_4.target));
      }

      common_scripts\utility::flag_wait(var_4._id_1288);

      if(!isDefined(self)) {
        return;
      }
      if(isDefined(var_4._id_1EE1)) {
        wait(var_4._id_1EE1);

        if(!isDefined(self)) {
          return;
        }
      }

      var_8 = 10;

      if(isDefined(var_4.script_accel)) {
        var_8 = var_4.script_accel;

      }
      if(var_9) {
        _id_2B1C("script_flag_wait_" + var_4._id_1288);

      }
      self notify("delay_passed");
    }

    if(isDefined(self._id_294C)) {
      self._id_294C = undefined;
      self clearlookatent();
    }

    if(isDefined(var_4._id_294D)) {
      thread _id_2ABA(var_4._id_294D);

    }
    if(isDefined(var_4._id_294E)) {
      thread _id_2AB3(var_4._id_294E);

    }
    if(isDefined(var_4._id_134B)) {
      thread _id_2AF4(var_4._id_134B);

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

  if(isDefined(self._id_2942)) {
    if(self._id_2942 == 1) {
      _id_2A3E();
    } else {
      _id_2A3D();
    }
  }

  if(isDefined(var_4._id_294F)) {
    thread _id_269D();

  }
  self notify("reached_dynamic_path_end");

  if(isDefined(self._id_2950)) {
    self notify("delete");
    self delete();
  }
}

_id_2951(var_0, var_1) {
  self notify("newpath");
  self endon("newpath");
  self endon("death");

  if(!isDefined(var_1)) {
    var_1 = 0;

  }
  if(isDefined(var_0)) {
    self._id_291A = var_0;

  }
  var_2 = self._id_291A;
  self.currentnode = self._id_291A;

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = var_2;

  if(var_1) {
    self waittill("start_dynamicpath");

  }
  var_4 = undefined;
  var_5 = var_2;
  var_6 = _id_293A(var_2);

  while(isDefined(var_5)) {
    if(isDefined(var_5.script_linkto)) {
      _id_2AD8(var_5);

    }
    _id_2959(var_5, var_4);

    if(!isDefined(self)) {
      return;
    }
    self.currentnode = var_5;

    if(isDefined(var_5._id_293E) && !var_5._id_293E) {
      thread _id_296E(var_5);

    }
    var_5 notify("trigger", self);

    if(isDefined(var_5._id_2952)) {
      self setyawspeedbyname(var_5._id_2952);

      if(var_5._id_2952 == "faster") {
        self setmaxpitchroll(25, 50);
      }
    }

    if(isDefined(var_5.script_noteworthy)) {
      self notify(var_5.script_noteworthy);
      self notify("noteworthy", var_5.script_noteworthy);
    }

    waittillframeend;

    if(!isDefined(self)) {
      return;
    }
    if(isDefined(var_5.script_prefab_exploder)) {
      var_5.script_exploder = var_5.script_prefab_exploder;
      var_5.script_prefab_exploder = undefined;
    }

    if(isDefined(var_5.script_exploder)) {
      var_7 = var_5._id_1ED3;

      if(isDefined(var_7)) {
        level maps\_utility::delaythread(var_7, common_scripts\utility::exploder, var_5.script_exploder);
      } else {
        level common_scripts\utility::exploder(var_5.script_exploder);
      }
    }

    if(isDefined(var_5._id_2057)) {
      if(isDefined(self._id_290B)) {
        self._id_290B[var_5._id_2057] = 1;

      }
      self notify("vehicle_flag_arrived", var_5._id_2057);
      common_scripts\utility::flag_set(var_5._id_2057);
    }

    if(isDefined(var_5._id_2058)) {
      maps\_utility::_id_13DC(var_5._id_2058);

    }
    if(isDefined(var_5._id_293F)) {
      maps\_utility::_id_13DE(var_5._id_293F);

    }
    if(isDefined(var_5._id_2059)) {
      if(isDefined(self._id_290B)) {
        self._id_290B[var_5._id_2059] = 0;

      }
      common_scripts\utility::flag_clear(var_5._id_2059);
    }

    if(isDefined(var_5.script_noteworthy)) {
      if(var_5.script_noteworthy == "kill") {
        _id_2A11();

      }
      if(var_5.script_noteworthy == "godon") {
        _id_2A12();

      }
      if(var_5.script_noteworthy == "godoff") {
        _id_2A13();

      }
      if(var_5.script_noteworthy == "deleteme") {
        level thread maps\_utility::_id_1E93(self);
        return;
      }
    }

    if(isDefined(var_5._id_2940)) {
      self._id_2940 = var_5._id_2940;

    }
    if(isDefined(var_5._id_2941)) {
      self._id_2941 = var_5._id_2941;

    }
    if(isDefined(var_5._id_2942)) {
      self._id_2942 = var_5._id_2942;

    }
    if(isDefined(var_5.script_team)) {
      self.script_team = var_5.script_team;

    }
    if(isDefined(var_5._id_2943)) {
      self notify("turning", var_5._id_2943);

    }
    if(isDefined(var_5._id_2944)) {
      if(var_5._id_2944 == 0) {
        thread _id_2968();
      } else {
        thread _id_2966();
      }
    }

    if(isDefined(var_5._id_2945)) {
      if(isDefined(var_5._id_164F) && var_5._id_164F == "queue") {
        self._id_2946 = 1;
      }
    }

    if(isDefined(var_5._id_2947)) {
      _id_2AA9(var_5._id_2947);

    }
    if(_id_2953(::_id_2959, var_5)) {
      thread _id_2A8B(var_5);

    }
    if(self isphysveh()) {
      if(isDefined(var_5._id_291B)) {
        self.veh_transmission = var_5._id_291B;

        if(self.veh_transmission == "forward") {
          _id_2AA7();
        } else {
          _id_2AA8();
        }
      }

      if(isDefined(var_5._id_2949)) {
        self.veh_pathtype = var_5._id_2949;
      }
    }

    if(isDefined(var_5._id_1288)) {
      if(!isDefined(self._id_290B)) {
        self._id_290B = [];

      }
      self._id_290B[var_5._id_1288] = 1;
      self notify("vehicle_flag_arrived", var_5._id_1288);
      common_scripts\utility::flag_wait(var_5._id_1288);

      if(isDefined(var_5._id_1EE1)) {
        wait(var_5._id_1EE1);

      }
      self notify("delay_passed");
    }

    if(isDefined(self._id_294C)) {
      self._id_294C = undefined;
      self clearlookatent();
    }

    if(isDefined(var_5._id_294D)) {
      thread _id_2ABA(var_5._id_294D);

    }
    if(isDefined(var_5._id_294E)) {
      thread _id_2AB3(var_5._id_294E);

    }
    if(isDefined(var_5._id_134B)) {
      thread _id_2AF4(var_5._id_134B);

    }
    var_4 = var_5;

    if(!isDefined(var_5.target)) {
      break;
    }

    var_5 = [[var_6]](var_5.target);

    if(!isDefined(var_5)) {
      var_5 = var_4;
      break;
    }
  }

  if(isDefined(self._id_2942)) {
    if(self._id_2942 == 1) {
      _id_2A3E();
    } else {
      _id_2A3D();
    }
  }

  if(isDefined(var_5._id_294F)) {
    thread _id_269D();

  }
  self notify("reached_dynamic_path_end");

  if(isDefined(self._id_2950)) {
    self delete();
  }
}

_id_2953(var_0, var_1) {
  if(isDefined(var_1._id_2954)) {
    return 1;

  }
  if(var_0 != ::_id_293C) {
    return 0;

  }
  if(!_id_2939(var_1)) {
    return 0;

  }
  if(isDefined(self._id_2955)) {
    return 0;

  }
  if(self.vehicletype == "empty") {
    return 0;

  }
  return !_id_2957();
}

_id_2956(var_0) {}

_id_2957() {
  if(!isDefined(self._id_2950)) {
    return 0;

  }
  return self._id_2950;
}

_id_2958(var_0) {
  if(isDefined(var_0._id_2954)) {
    return 1;

  }
  if(isDefined(var_0.script_delay)) {
    return 1;

  }
  return isDefined(var_0._id_1288) && !common_scripts\utility::flag(var_0._id_1288);
}

_id_2959(var_0, var_1) {
  self endon("newpath");

  if(isDefined(var_0._id_2954) && isDefined(self._id_295A)) {
    var_0.radius = 2;

    if(isDefined(var_0._id_295B)) {
      var_0.origin = var_0._id_295B + (0, 0, self._id_295A);
    } else {
      var_2 = maps\_utility::_id_1277(var_0.origin) + (0, 0, self._id_295A);

      if(var_2[2] > var_0.origin[2] - 2000) {
        var_0.origin = maps\_utility::_id_1277(var_0.origin) + (0, 0, self._id_295A);
      }
    }

    self sethoverparams(0, 0, 0);
  }

  if(isDefined(var_1)) {
    var_3 = var_1._id_295C;
    var_4 = var_1.speed;
    var_5 = var_1.script_accel;
    var_6 = var_1._id_294B;
  } else {
    var_3 = undefined;
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;
  }

  var_7 = isDefined(var_0._id_295D) && var_0._id_295D;
  var_8 = isDefined(var_0._id_2954);
  var_9 = isDefined(var_0._id_1288) && !common_scripts\utility::flag(var_0._id_1288);
  var_10 = !isDefined(var_0.target);
  var_11 = isDefined(var_0.script_delay);

  if(isDefined(var_0.angles)) {
    var_12 = var_0.angles[1];
  } else {
    var_12 = 0;

  }
  if(self.health <= 0) {
    return;
  }
  var_13 = var_0.origin;

  if(maps\_utility::_id_1E25()) {
    if(isDefined(self._id_295E)) {
      var_13 = var_13 + (0, 0, self._id_295E);
    }
  }

  if(isDefined(self._id_295F)) {
    var_13 = (var_13[0], var_13[1], self._id_295F);

  }
  self vehicle_helisetai(var_13, var_4, var_5, var_6, var_0._id_2961, var_0._id_2960, var_12, var_3, var_11, var_7, var_8, var_9, var_10);

  if(isDefined(var_0.radius)) {
    self setneargoalnotifydist(var_0.radius);
    common_scripts\utility::waittill_any("near_goal", "goal");
  } else {
    self waittill("goal");

  }
  if(isDefined(var_0._id_2962)) {
    thread _id_2964(var_0);

  }
  var_0 maps\_utility::script_delay();

  if(isDefined(self._id_2963)) {
    maps\_utility::_id_283A(var_0);
  }
}

_id_2964(var_0) {
  var_1 = getent(var_0.script_linkto, "script_linkname");
  var_2 = !isDefined(var_1);

  if(!isDefined(var_1)) {
    var_1 = common_scripts\utility::getstruct(var_0.script_linkto, "script_linkname");

  }
  var_3 = var_0._id_2962;

  if(var_2) {
    var_1 = var_1 common_scripts\utility::spawn_tag_origin();

  }
  switch (var_3) {
    case "zippy_burst":
      wait 1;
      maps\_helicopter_globals::fire_missile("hind_zippy", 1, var_1);
      wait 0.1;
      maps\_helicopter_globals::fire_missile("hind_zippy", 1, var_1);
      wait 0.2;
      maps\_helicopter_globals::fire_missile("hind_zippy", 1, var_1);
      wait 0.3;
      maps\_helicopter_globals::fire_missile("hind_zippy", 1, var_1);
      wait 0.3;
      maps\_helicopter_globals::fire_missile("hind_zippy", 1, var_1);
      break;
    case "apache_zippy":
      var_4 = [0.1, 0.2, 0.3];
      wait 1;
      var_1.origin = var_1.origin + (0, 0, -150);
      var_1 moveto(var_1.origin + (0, 0, 150), 0.6, 0, 0);

      foreach(var_6 in var_4) {
        if(!isDefined(self)) {
          continue;
        }
        maps\_helicopter_globals::fire_missile("apache_zippy", 1, var_1);
        wait(var_6);
      }

      break;
    case "hind_rpg":
      maps\_helicopter_globals::fire_missile("hind_rpg", 5, var_1, 0.3);
      break;
    default:
      if(self.classname == "script_vehicle_littlebird_armed" || self.classname == "script_vehicle_littlebird_md500") {
        vehicle_scripts\_attack_heli::_id_28E2(var_1, 2, 0.25);
      } else {
        maps\_helicopter_globals::fire_missile("hind_zippy", 5, var_1, 0.3);

      }
      break;
  }

  if(var_2) {
    var_1 delete();
  }
}

_id_2965(var_0, var_1, var_2) {
  self setairresistance(30);
  self vehicle_setspeed(var_1, var_2, level._id_28F3);
  _id_26A1(common_scripts\utility::getstruct(var_0, "targetname"));
}

_id_2966() {
  if(self.health > 0) {
    self._id_2967 = 1;
  }
}

_id_2968() {
  self._id_2967 = undefined;
  self notify("deathrolloff");
}

_id_2969(var_0) {
  var_1 = undefined;
  var_2 = self.vehicletype;

  if(isDefined(self._id_296A)) {
    if(isDefined(self._id_296A._id_296B) && self._id_296B) {
      return;
    }
  }

  if(isDefined(self.target)) {
    var_1 = getvehiclenode(self.target, "targetname");

    if(!isDefined(var_1)) {
      var_3 = getEntArray(self.target, "targetname");

      foreach(var_5 in var_3) {
        if(var_5.code_classname == "script_origin") {
          var_1 = var_5;
          break;
        }
      }
    }

    if(!isDefined(var_1)) {
      var_1 = common_scripts\utility::getstruct(self.target, "targetname");
    }
  }

  if(!isDefined(var_1)) {
    if(_id_21ED()) {
      self vehicle_setspeed(60, 20, level._id_28F3);

    }
    return;
  }

  self._id_291A = var_1;

  if(!_id_21ED()) {
    self.origin = var_1.origin;

    if(!isDefined(var_0)) {
      self attachpath(var_1);
    }
  } else if(isDefined(self.speed)) {
    self vehicle_setspeedimmediate(self.speed, 20);
  } else if(isDefined(var_1.speed)) {
    var_7 = 20;
    var_8 = level._id_28F3;

    if(isDefined(var_1.script_accel)) {
      var_7 = var_1.script_accel;

    }
    if(isDefined(var_1._id_294B)) {
      var_7 = var_1._id_294B;

    }
    self vehicle_setspeedimmediate(var_1.speed, var_7, var_8);
  } else {
    self vehicle_setspeed(60, 20, level._id_28F3);

  }
  thread _id_26A1(undefined, _id_21ED());
}

_id_296C(var_0) {
  var_1 = _id_2971(var_0);

  foreach(var_3 in var_1) {}
  level thread _id_1FA6(var_3);

  return var_1;
}

_id_1FA6(var_0) {
  if(!isDefined(var_0)) {
    var_0 = self;

  }
  if(isDefined(var_0._id_290E)) {
    level._id_290F[var_0._id_290E] = common_scripts\utility::array_remove(level._id_290F[var_0._id_290E], var_0);

  }
  var_0 endon("death");

  if(isDefined(var_0._id_252E)) {
    return;
  } else {
    var_0._id_252E = 1;

  }
  var_0 maps\_utility::script_delay();
  var_0 notify("start_vehiclepath");

  if(var_0 _id_21ED()) {
    var_0 notify("start_dynamicpath");
  } else {
    var_0 startpath();
  }
}

_id_296D(var_0) {
  var_0._id_293E = 1;
  var_0 notify("gate opened");
}

_id_296E(var_0) {
  self endon("death");
  self._id_296F = 1;
  self notify("wait for gate");
  _id_2A0A(0, 15, "path gate closed");
  var_0 waittill("gate opened");
  self._id_296F = 0;

  if(self.health > 0) {
    _id_2A0C("gate opened", level._id_2970);
  }
}

_id_2971(var_0) {
  var_1 = _id_2AEE(var_0);
  var_2 = [];

  foreach(var_4 in var_1) {}
  var_2[var_2.size] = _id_211F(var_4);

  return var_2;
}

_id_211F(var_0) {
  var_1 = var_0 dospawn();

  if(!isDefined(var_0._id_2972)) {
    var_0._id_2972 = 0;

  }
  var_0._id_2972++;
  var_0._id_2973 = var_1;
  var_0._id_2644 = var_1;
  var_0 thread _id_2976();
  var_1._id_296A = var_0;

  if(isDefined(var_0._id_2974)) {
    var_1._id_2974 = var_0._id_2974;

  }
  thread _id_297C(var_1);
  var_0 notify("spawned", var_1);
  return var_1;
}

_id_2975(var_0) {
  var_1 = getent(var_0, "targetname");

  if(isDefined(var_1._id_2644)) {
    return var_1._id_2644;

  }
  return undefined;
}

_id_2976() {
  wait 0.05;
  self._id_2973 = undefined;
}

_id_2977(var_0) {
  var_1 = getent(var_0, "targetname");

  if(isDefined(var_1._id_2973)) {
    return var_1._id_2973;

  }
  var_1 waittill("spawned", var_2);
  return var_2;
}

_id_2978(var_0) {
  var_1 = getEntArray(var_0, "script_noteworthy");
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(isspawner(var_4)) {
      var_2 = var_4;
      break;
    }
  }

  if(isDefined(var_2._id_2973)) {
    return var_2._id_2973;

  }
  var_2 = getent(var_0, "script_noteworthy");
  var_2 waittill("spawned", var_6);
  return var_6;
}

_id_2979(var_0) {
  var_1 = spawnStruct();
  var_1._id_297A = 0;
  var_1._id_0B5A = [];
  var_2 = [];
  var_3 = getEntArray(var_0, "script_noteworthy");

  foreach(var_5 in var_3) {
    if(isspawner(var_5)) {
      var_2[var_2.size] = var_5;
    }
  }

  common_scripts\utility::array_levelthread(var_2, ::_id_297B, var_1);
  var_1 waittill("all_vehicles_spawned");
  return var_1._id_0B5A;
}

_id_297B(var_0, var_1) {
  var_1._id_297A++;

  if(!isDefined(var_0._id_2973)) {
    var_0 waittill("spawned", var_2);
  } else {
    var_2 = var_0._id_2973;

  }
  var_1._id_297A--;
  var_1._id_0B5A[var_1._id_0B5A.size] = var_2;

  if(!var_1._id_297A) {
    var_1 notify("all_vehicles_spawned");
  }
}

_id_297C(var_0) {
  var_1 = var_0.classname;

  if(isDefined(level._id_297D[var_1])) {
    foreach(var_3 in level._id_297D[var_1]) {}
    var_0 hidepart(var_3);
  }

  if(var_0.vehicletype == "empty") {
    var_0 thread _id_2969();
    return;
  }

  if(var_0.vehicletype == "bog_mortar") {
    return;
  }
  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "playervehicle") {
    return;
  }
  var_0 maps\_utility::_id_218C();
  var_0._id_297E = 1;

  if(!isDefined(var_0.modeldummyon)) {
    var_0.modeldummyon = 0;

  }
  var_5 = var_0.vehicletype;

  if(maps\_utility::_id_1E25()) {
    var_1 = var_0.vehicletype;

  }
  var_0 _id_2A2F();
  var_0 _id_2A85();

  if(maps\_utility::_id_1E25()) {
    if(!isDefined(level._id_297F[var_0.vehicletype][var_0.model])) {}

    var_0 thread[[level._id_297F[var_0.vehicletype][var_0.model]]]();
  } else {
    if(!isDefined(level._id_297F[var_0.vehicletype][var_0.classname])) {}

    var_0 thread[[level._id_297F[var_0.vehicletype][var_0.classname]]]();
  }

  var_0 thread _id_2AAA();
  var_0 thread _id_2AAC();

  if(!isDefined(var_0._id_2980)) {
    var_0._id_2980 = 0;

  }
  if(isDefined(level._id_2981)) {
    if(level._id_2981) {
      var_0 thermaldrawenable();
    }
  }

  var_0 maps\_utility::_id_1402("unloaded");
  var_0 maps\_utility::_id_1402("loaded");
  var_0._id_0A39 = [];
  var_0._id_2562 = [];
  var_0._id_2563 = "default";
  var_0._id_256A = [];

  if(isDefined(level._id_256B) && isDefined(level._id_256B[var_1])) {
    var_6 = level._id_256B[var_1];
    var_7 = getarraykeys(var_6);

    foreach(var_9 in var_7) {
      var_0._id_256A[var_9] = undefined;
      var_0._id_2576[var_9] = 0;
    }
  }

  var_0 thread _id_2A75();

  if(isDefined(var_0._id_294E)) {
    var_0 thread _id_2AB3(var_0._id_294E);

  }
  if(isDefined(var_0._id_2982)) {
    var_0 _id_2A12();

  }
  var_0._id_215B = [];

  if(!var_0 _id_2A40() || var_0 _id_2986()) {
    var_0 thread _id_2A6D();

  }
  var_0 thread maps\_vehicle_aianim::_id_24FF();

  if(isDefined(var_0._id_0AB5)) {
    var_0 setvehiclelookattext(var_0._id_0AB5, &"");

  }
  if(!var_0 _id_2A40()) {
    var_0 thread _id_2A86();

  }
  if(isDefined(var_0._id_2983)) {
    var_0._id_2955 = 1;

  }
  if(!var_0 _id_2A40()) {
    var_0 thread _id_2A5C();

  }
  var_0 thread _id_2994();

  if(isDefined(var_0._id_2984) && var_0._id_2984) {
    var_0 thread maps\_utility::_id_2701();

  }
  var_0 thread _id_28EE();
  var_0 thread _id_2A18();
  var_0 thread _id_2A1A();

  if(isDefined(var_0._id_2116)) {
    var_0 thread maps\_spawner::_id_2118();

  }
  if(!var_0 _id_2A40()) {
    var_0 thread _id_2A33();

  }
  if(isDefined(level._id_2985)) {
    level thread[[level._id_2985]](var_0);

  }
  _id_2920(var_0);

  if(isDefined(var_0.script_team)) {
    var_0 setvehicleteam(var_0.script_team);

  }
  if(!var_0 _id_2A40()) {
    var_0 thread _id_2A09();

  }
  var_0 thread _id_2969();

  if(var_0 _id_2A42()) {
    var_0 thread _id_2A9B();

  }
  if(var_0 isphysveh()) {
    if(!isDefined(var_0._id_2949)) {} else {
      var_0.veh_pathtype = var_0._id_2949;
    }
  }

  var_0 _id_2929();
  var_0 thread _id_2990();
  var_0 _id_2AE1();
}

_id_2986() {
  return isDefined(level._id_2987) && level._id_2987;
}

_id_2988(var_0) {
  if(!isDefined(level._id_2989) || !isDefined(level._id_2989[var_0])) {
    return;
  }
  if(isDefined(self._id_298A)) {
    var_1 = self._id_298A;
  } else {
    var_1 = level._id_2989[var_0]._id_298B;

  }
  if(isDefined(self._id_298C)) {
    var_2 = self._id_298C;
  } else {
    var_2 = level._id_2989[var_0]._id_298D;

  }
  if(isDefined(level._id_2989[var_0].delay)) {
    wait(level._id_2989[var_0].delay);

  }
  if(!isDefined(self)) {
    return;
  }
  if(level._id_2989[var_0]._id_298E) {
    level.player enablehealthshield(0);

  }
  self radiusdamage(self.origin + level._id_2989[var_0].offset, level._id_2989[var_0]._id_298F, var_1, var_2, self);

  if(level._id_2989[var_0]._id_298E) {
    level.player enablehealthshield(1);
  }
}

_id_2990() {
  self endon("nodeath_thread");
  var_0 = self.vehicletype;
  var_1 = self.classname;
  var_2 = self.model;
  var_3 = self.targetname;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = 0;

  for(;;) {
    if(isDefined(self)) {
      self waittill("death", var_4, var_5, var_6);

    }
    if(!var_7) {
      var_7 = 1;

      if(isDefined(var_4) && isDefined(var_5)) {
        var_4 maps\_player_stats::_id_0A34(self, var_5, var_6);

        if(isDefined(self.damage_type)) {
          self.damage_type = undefined;
        }
      }

      if(maps\_utility::_id_0A36() && !maps\_utility::_id_12DC() && isDefined(var_4) && isplayer(var_4)) {
        if(var_4.team != self.script_team) {
          var_4 thread maps\_utility::_id_12BE("kill", 500);

        }
        if(isDefined(self._id_0A39)) {
          foreach(var_9 in self._id_0A39) {
            if(isalive(var_9) && isai(var_9)) {
              var_4 thread maps\_utility::_id_12BE("kill");
            }
          }
        }
      }

      thread _id_023D(var_4, var_5, var_6);
    }

    self notify("clear_c4");

    if(isDefined(self._id_2991)) {
      self._id_2991 delete();

    }
    if(isDefined(self.mgturret)) {
      common_scripts\utility::array_levelthread(self.mgturret, ::_id_2AA6);
      self.mgturret = undefined;
    }

    if(isDefined(self.script_team)) {
      level._id_0B5A[self.script_team] = common_scripts\utility::array_remove(level._id_0B5A[self.script_team], self);

    }
    if(isDefined(self.script_linkname)) {
      level._id_2921[self.script_linkname] = common_scripts\utility::array_remove(level._id_2921[self.script_linkname], self);

    }
    if(isDefined(self._id_290E)) {
      level._id_290F[self._id_290E] = common_scripts\utility::array_remove(level._id_290F[self._id_290E], self);

    }
    if(isDefined(self._id_290C)) {
      level._id_290D[self._id_290C] = common_scripts\utility::array_remove(level._id_290D[self._id_290C], self);

    }
    if(!isDefined(self) || _id_29D3()) {
      if(isDefined(self._id_0A39)) {
        foreach(var_9 in self._id_0A39) {
          if(isDefined(var_9)) {
            var_9 delete();
          }
        }
      }

      if(_id_29D3()) {
        self._id_0A39 = [];
        continue;
      }

      self notify("delete_destructible");
      return;
    }

    var_13 = undefined;

    if(isDefined(self._id_2992)) {
      var_13 = self._id_2992;
    } else if(isDefined(level._id_2993) && isDefined(level._id_2993[var_1])) {
      var_13 = level._id_2993;
    } else if(isDefined(level._id_2994[var_1])) {
      var_13 = level._id_2994[var_1];

    }
    if(isDefined(var_13)) {
      self stoprumble(var_13._id_1441);

    }
    if(isDefined(level._id_2995[var_0])) {
      thread[[level._id_2995[var_0]]]();

    }
    common_scripts\utility::array_levelthread(self._id_0A39, maps\_vehicle_aianim::_id_25A5, var_4, var_0);
    thread _id_2988(var_1);

    if(maps\_utility::_id_1E25()) {
      thread _id_2AE7(var_0);
    } else {
      thread _id_2AE7(var_1);

    }
    _id_2B16(_id_2B1A(var_2, var_1));
    maps\_vehicle_aianim::_id_25D9();

    if(isDefined(level._id_2996[var_1])) {
      thread _id_29D4(level._id_2996[var_1], level._id_2997[var_1]);
    } else if(isDefined(level._id_2996[var_2])) {
      thread _id_29D4(level._id_2996[var_2], level._id_2997[var_2]);

    }
    var_14 = _id_29CB(var_2, var_4, var_5);
    var_15 = self.origin;
    thread _id_29E7(var_2, var_14);

    if(self.code_classname == "script_vehicle") {
      if(maps\_utility::_id_1E25()) {
        thread _id_2AEC(var_0);
      } else {
        thread _id_2AEC(var_1);
      }
    }

    if(isDefined(self.delete_on_death)) {
      wait 0.05;

      if(!isDefined(self._id_2998) && !self isphysveh()) {
        self disconnectpaths();

      }
      _id_299C();
      wait 0.05;
      _id_29C8(var_2);
      self delete();
      continue;
    }

    if(isDefined(self._id_2999)) {
      self notify("newpath");

      if(!isDefined(self._id_2998)) {
        self disconnectpaths();

      }
      _id_2A74();
      _id_299C();
      return;
    }

    _id_29D0(var_2, var_4, var_5);

    if(!isDefined(self)) {
      return;
    }
    if(!var_14) {
      var_15 = self.origin;

    }
    if(isDefined(level._id_299A[var_1])) {
      earthquake(level._id_299A[var_1].scale, level._id_299A[var_1].duration, var_15, level._id_299A[var_1].radius);

    }
    wait 0.5;

    if(_id_29D3()) {
      continue;
    }
    if(isDefined(self)) {
      while(isDefined(self._id_299B) && isDefined(self)) {
        wait 0.05;

      }
      if(!isDefined(self)) {
        continue;
      }
      if(self isphysveh()) {
        while(isDefined(self) && self.veh_speed != 0) {
          wait 1;

        }
        if(!isDefined(self)) {
          return;
        }
        self disconnectpaths();
        self notify("kill_badplace_forever");
        self kill();
        self notify("newpath");
        self vehicle_turnengineoff();
        return;
      } else {
        _id_299C();

      }
      if(self.modeldummyon) {
        self hide();
      }
    }

    if(_id_29CF()) {
      self delete();
      continue;
    }
  }
}

_id_023D(var_0, var_1, var_2) {
  if(maps\_utility::_id_12DC() && isDefined(self) && _id_21ED() && isplayer(var_0)) {
    if(!isDefined(var_0._id_023E)) {
      var_0._id_023E = 1;
    } else {
      var_0._id_023E++;

    }
    if(var_0._id_023E == 2) {
      var_0 maps\_utility::_id_1E39("BIRDIE");

    }
    var_0 waittill("damage");
    var_0._id_023E = undefined;
  }
}

_id_299C() {
  self freevehicle();

  if(!isDefined(level._id_299D)) {
    return;
  }
  maps\_utility::delaythread(0.05, ::_id_299D);
}

_id_299D() {
  self notify("newpath");
  self.accuracy = undefined;
  self._id_24E7 = undefined;
  self._id_299E = undefined;
  self._id_299F = undefined;
  self._id_29A0 = undefined;
  self._id_29A1 = undefined;
  self.currentnode = undefined;
  self._id_215B = undefined;
  self._id_24EA = undefined;
  self._id_256A = undefined;
  self._id_2501 = undefined;
  self._id_252E = undefined;
  self._id_163B = undefined;
  self._id_29A2 = undefined;
  self._id_29A3 = undefined;
  self._id_29A4 = undefined;
  self._id_29A5 = undefined;
  self._id_29A6 = undefined;
  self._id_29A7 = undefined;
  self._id_29A8 = undefined;
  self._id_2980 = undefined;
  self._id_29A8 = undefined;
  self._id_2980 = undefined;
  self.script_bulletshield = undefined;
  self.script_disconnectpaths = undefined;
  self.script_linkname = undefined;
  self._id_29A9 = undefined;
  self.script_team = undefined;
  self._id_29AA = undefined;
  self._id_2942 = undefined;
  self._id_250B = undefined;
  self._id_28FF = undefined;
  self._id_290E = undefined;
  self._id_29AB = undefined;
  self._id_29AC = undefined;
  self._id_1E97 = undefined;
  self._id_214D = undefined;
  self._id_29AD = undefined;
  self.target = undefined;
  self._id_29AE = undefined;
  self._id_29AF = undefined;
  self._id_29AF = undefined;
  self._id_29B0 = undefined;
  self._id_29B1 = undefined;
  self._id_29B2 = undefined;
  self._id_29B3 = undefined;
  self._id_29B4 = undefined;
  self._id_291A = undefined;
  self._id_29B4 = undefined;
  self._id_29B5 = undefined;
  self._id_29B6 = undefined;
  self._id_29B7 = undefined;
  self._id_2991 = undefined;
  self._id_2500 = undefined;
  self._id_24FE = undefined;
  self._id_2189 = undefined;
  self._id_29B8 = undefined;
  self._id_29B3 = undefined;
  self._id_29B9 = undefined;
  self._id_29BA = undefined;
  self._id_29BB = undefined;
  self._id_29BC = undefined;
  self._id_29BD = undefined;
  self.unique_id = undefined;
  self._id_2563 = undefined;
  self._id_2562 = undefined;
  self._id_24E8 = undefined;
  self._id_296A = undefined;
  self._id_296F = undefined;
  self._id_29BE = undefined;
  self._id_29BF = undefined;
  self._id_29C0 = undefined;
  self._id_2168 = undefined;
  self._id_29BF = undefined;
  self._id_29C1 = undefined;
  self._id_297E = undefined;
  self._id_2955 = undefined;
  self._id_2998 = undefined;
  self._id_2982 = undefined;
  self._id_1008 = undefined;
  self._id_29C2 = undefined;
  self.export = undefined;
  self.godmode = undefined;
  self.vehicletype = undefined;
  self._id_29C3 = undefined;
  self._id_29C4 = undefined;
  self._id_29C5 = undefined;
  self._id_29C6 = undefined;
  self._id_2941 = undefined;
  self._id_29C7 = undefined;
}

#using_animtree("vehicles");

_id_29C8(var_0) {
  self notify("death_finished");

  if(!isDefined(self)) {
    return;
  }
  self useanimtree(#animtree);

  if(isDefined(level._id_29C9[var_0])) {
    self clearanim(level._id_29C9[var_0], 0);

  }
  if(isDefined(level._id_29CA[var_0])) {
    self clearanim(level._id_29CA[var_0], 0);
  }
}

_id_29CB(var_0, var_1, var_2) {
  if(isDefined(self._id_29CC) && self._id_29CC == 0) {
    return 0;

  }
  if(!isDefined(var_2)) {
    return 0;

  }
  if(!(var_2 == "MOD_PROJECTILE" || var_2 == "MOD_PROJECTILE_SPLASH")) {
    return 0;

  }
  return _id_29CD(var_0);
}

_id_29CD(var_0) {
  if(maps\_utility::_id_1E25()) {
    return isDefined(level._id_29CE["rocket_death" + self.vehicletype + var_0]) && isDefined(self._id_29CC) && self._id_29CC == 1;
  } else {
    return isDefined(level._id_29CE["rocket_death" + self.classname]) && isDefined(self._id_29CC) && self._id_29CC == 1;
  }
}

_id_29CF() {
  return isDefined(self._id_256C) && self._id_256C == 1;
}

_id_29D0(var_0, var_1, var_2) {
  var_3 = "tank";

  if(self isphysveh()) {
    var_3 = "physics";
  } else if(isDefined(self._id_2940)) {
    var_3 = self._id_2940;
  } else if(_id_21ED()) {
    var_3 = "helicopter";
  } else if(isDefined(self.currentnode) && _id_29E5(self.currentnode)) {
    var_3 = "none";

  }
  switch (var_3) {
    case "helicopter":
      thread _id_29D6(var_1, var_2);
      break;
    case "tank":
      if(!isDefined(self._id_2967)) {
        _id_2A0A(0, 25, "Dead");
      } else {
        _id_2A0A(8, 25, "Dead rolling out of path intersection");
        self waittill("deathrolloff");
        _id_2A0A(0, 25, "Dead, finished path intersection");
      }

      self notify("deadstop");

      if(!isDefined(self._id_2998)) {
        self disconnectpaths();

      }
      if(isDefined(self._id_29D1) && self._id_29D1 > 0) {
        self waittill("animsdone");

      }
      break;
    case "physics":
      self phys_crash();
      self notify("deadstop");

      if(!isDefined(self._id_2998)) {
        self disconnectpaths();

      }
      if(isDefined(self._id_29D1) && self._id_29D1 > 0) {
        self waittill("animsdone");

      }
      break;
  }

  if(isDefined(level._id_29D2[var_0]) && level._id_29D2[var_0]) {
    self clearturrettarget();

  }
  if(_id_21ED()) {
    if(isDefined(self._id_256C) && self._id_256C == 1) {
      self waittill("crash_done");
    }
  } else {
    while(!_id_29D3() && isDefined(self) && self vehicle_getspeed() > 0) {
      wait 0.1;
    }
  }

  self notify("stop_looping_death_fx");
  _id_29C8(var_0);
}

_id_29D3() {
  var_0 = 0;

  if(isDefined(self) && self.classname == "script_vehicle_corpse") {
    var_0 = 1;

  }
  return var_0;
}

_id_29D4(var_0, var_1) {
  if(isDefined(var_1) && var_1 > 0) {
    wait(var_1);

  }
  if(!isDefined(self)) {
    return;
  }
  var_2 = get_dummy();

  if(isDefined(self._id_29D5)) {
    var_2 clearanim( % root, 0);

  }
  if(isDefined(self)) {
    var_2 setModel(var_0);
  }
}

_id_29D6(var_0, var_1) {
  if(isDefined(var_0) && isplayer(var_0)) {
    self._id_2570 = var_0;

  }
  self._id_256C = 1;

  if(!isDefined(self)) {
    return;
  }
  thread _id_29DB(var_0, var_1);
}

_id_29D7(var_0) {
  var_1 = self getweaponslistall();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(issubstr(var_1[var_2], var_0)) {
      return 1;
    }
  }

  return 0;
}

_id_29D8() {
  var_0 = [];
  level._id_29D9 = common_scripts\utility::array_removeundefined(level._id_29D9);

  foreach(var_2 in level._id_29D9) {
    if(isDefined(var_2._id_2233)) {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

_id_29DA() {
  if(!isDefined(self._id_256A)) {
    return;
  }
  if(!self._id_256A.size) {
    return;
  }
  var_0 = getarraykeys(self._id_256A);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    self._id_256A[var_0[var_1]] unlink();
  }
}

_id_29DB(var_0, var_1) {
  self endon("in_air_explosion");

  if(isDefined(self._id_29DC)) {
    var_2 = self._id_29DC;
  } else {
    var_3 = _id_29D8();
    var_2 = maps\_utility::_id_0AE9(self.origin, var_3);
  }

  var_2._id_2233 = 1;
  _id_29DA();
  self notify("newpath");
  self notify("deathspin");
  var_4 = 0;
  var_5 = 0;

  if(isDefined(var_2._id_164F) && var_2._id_164F == "direct") {
    var_5 = 1;

  }
  if(isDefined(self._id_29DD)) {
    var_5 = 0;
    var_4 = self._id_29DD;
  }

  if(var_5) {
    var_6 = 60;
    self vehicle_setspeed(var_6, 15, 10);
    self setneargoalnotifydist(var_2.radius);
    self setvehgoalpos(var_2.origin, 0);
    thread _id_29DF(var_2.origin, var_6);
    common_scripts\utility::waittill_any("goal", "near_goal");
  } else {
    var_7 = (var_2.origin[0], var_2.origin[1], self.origin[2] + var_4);

    if(isDefined(self._id_29DE)) {
      var_7 = self.origin + self._id_29DE * self vehicle_getvelocity();
      var_7 = (var_7[0], var_7[1], var_7[2] + var_4);
    }

    self vehicle_setspeed(40, 10, 10);
    self setneargoalnotifydist(300);
    self setvehgoalpos(var_7, 1);
    thread _id_29DF(var_7, 40);
    var_8 = "blank";

    while(var_8 != "death") {
      var_8 = common_scripts\utility::waittill_any("goal", "near_goal", "death");

      if(!isDefined(var_8) && !isDefined(self)) {
        var_2._id_2233 = undefined;
        self notify("crash_done");
        return;
      } else {
        var_8 = "death";
      }
    }

    self setvehgoalpos(var_2.origin, 0);
    self waittill("goal");
  }

  var_2._id_2233 = undefined;
  self notify("stop_crash_loop_sound");
  self notify("crash_done");
}

_id_29DF(var_0, var_1) {
  self endon("crash_done");
  self clearlookatent();
  var_2 = 0;

  if(isDefined(self._id_29E0)) {
    var_2 = self._id_29E0;

    if(self._id_29E0 < 0) {
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
      thread _id_29E3();
      break;
    case 2:
      thread _id_29E2(var_0, var_1);
      break;
    case 3:
      thread _id_29E1();
      break;
    case 0:
    default:
      thread _id_29E4();
      break;
  }
}

_id_29E1() {
  self notify("crash_done");
  self notify("in_air_explosion");
}

_id_29E2(var_0, var_1) {
  self endon("crash_done");
  self clearlookatent();
  self setmaxpitchroll(randomintrange(20, 90), randomintrange(5, 90));
  self setyawspeed(400, 100, 100);
  var_2 = 90 * randomintrange(-2, 3);

  for(;;) {
    var_3 = var_0 - self.origin;
    var_4 = vectortoyaw(var_3);
    var_4 = var_4 + var_2;
    self settargetyaw(var_4);
    wait 0.1;
  }
}

_id_29E3() {
  self endon("crash_done");
  self clearlookatent();
  self setyawspeed(400, 100, 100);
  var_0 = randomint(2);

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    var_1 = randomintrange(20, 120);

    if(var_0) {
      self settargetyaw(self.angles[1] + var_1);
    } else {
      self settargetyaw(self.angles[1] - var_1);

    }
    var_0 = 1 - var_0;
    var_2 = randomfloatrange(0.5, 1.0);
    wait(var_2);
  }
}

_id_29E4() {
  self endon("crash_done");
  self clearlookatent();
  self setyawspeed(400, 100, 100);

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    var_0 = randomintrange(90, 120);
    self settargetyaw(self.angles[1] + var_0);
    wait 0.5;
  }
}

_id_29E5(var_0) {
  var_1 = var_0;

  while(isDefined(var_1)) {
    if(isDefined(var_1._id_2909) && var_1._id_2909 == 0) {
      var_2 = _id_2910(getvehiclenode(var_1.target, "targetname"));

      if(isDefined(var_2) && isDefined(var_2._id_2914)) {
        return 1;
      }
    }

    if(isDefined(var_1.target)) {
      var_1 = getvehiclenode(var_1.target, "targetname");
      continue;
    }

    var_1 = undefined;
  }

  return 0;
}

_id_29E6(var_0) {
  thread maps\_utility::_id_258E(var_0, undefined, 0);
  common_scripts\utility::waittill_any("fire_extinguish", "stop_crash_loop_sound");

  if(!isDefined(self)) {
    return;
  }
  self notify("stop sound" + var_0);
}

_id_29E7(var_0, var_1) {
  if(common_scripts\utility::isdestructible()) {
    return;
  }
  level notify("vehicle_explosion", self.origin);
  self notify("explode", self.origin);

  if(isDefined(self._id_29E8) && self._id_29E8) {
    return;
  }
  var_2 = self.vehicletype;
  var_3 = _id_29D3();
  var_4 = self.classname;

  if(maps\_utility::_id_1E25()) {
    var_4 = var_2 + var_0;

  }
  if(var_1) {
    var_4 = "rocket_death" + var_4;

  }
  for(var_5 = 0; var_5 < level._id_29CE[var_4].size; var_5++) {
    var_6 = level._id_29CE[var_4][var_5];
    thread _id_29EA(var_0, var_6, var_2);
  }
}

_id_29E9(var_0) {
  if(!isDefined(self._id_290B)) {
    self._id_290B = [];

  }
  while(!isDefined(self._id_290B[var_0])) {
    self waittill("vehicle_flag_arrived", var_1);

    if(var_0 == var_1) {
      return;
    }
  }
}

_id_29EA(var_0, var_1, var_2) {
  if(isDefined(var_1._id_29EB)) {
    if(var_1._id_29EB >= 0) {
      wait(var_1._id_29EB);
    } else {
      self waittill("death_finished");
    }
  }

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_1.notifystring)) {
    self notify(var_1.notifystring);

  }
  var_3 = get_dummy();

  if(isDefined(var_1._id_29ED)) {
    common_scripts\utility::delaycall(var_1._id_29ED, ::delete);

  }
  if(isDefined(var_1._id_164E)) {
    if(var_1._id_29EE && !isDefined(self.delete_on_death)) {
      if(isDefined(var_1.tag)) {
        if(isDefined(var_1._id_29EF) && var_1._id_29EF == 1) {
          thread _id_29F2(var_1._id_164E, var_1.delay, var_1.tag);
        } else {
          thread _id_2A46(var_1._id_164E, var_1.delay, var_1.tag);
        }
      } else {
        var_4 = var_3.origin + (0, 0, 100) - var_3.origin;
        playFX(var_1._id_164E, var_3.origin, var_4);
      }
    } else if(isDefined(var_1.tag)) {
      playFXOnTag(var_1._id_164E, _id_2AB9(), var_1.tag);

      if(isDefined(var_1._id_29F0)) {
        _id_2AB9() common_scripts\utility::delaycall(var_1._id_29F0, ::delete);
      }
    } else {
      var_4 = var_3.origin + (0, 0, 100) - var_3.origin;
      playFX(var_1._id_164E, var_3.origin, var_4);
    }
  }

  if(isDefined(var_1.sound) && !isDefined(self.delete_on_death)) {
    if(var_1._id_29F1) {
      thread _id_29E6(var_1.sound);
    } else {
      common_scripts\utility::play_sound_in_space(var_1.sound);
    }
  }
}

_id_29F2(var_0, var_1, var_2) {
  self endon("stop_looping_death_fx");

  while(isDefined(self)) {
    playFXOnTag(var_0, _id_2AB9(), var_2);
    wait(var_1);
  }
}

_id_29F3(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level._id_2989)) {
    level._id_2989 = [];

  }
  if(!isDefined(var_4)) {
    var_4 = 0;

  }
  if(!isDefined(var_0)) {
    var_0 = (0, 0, 0);

  }
  var_6 = spawnStruct();
  var_6.offset = var_0;
  var_6._id_298F = var_1;
  var_6._id_298B = var_2;
  var_6._id_298D = var_3;
  var_6._id_298E = var_4;
  var_6.delay = var_5;
  level._id_2989[level._id_29F4] = var_6;
}

_id_29F5(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level._id_2994)) {
    level._id_2994 = [];

  }
  var_6 = _id_29FA(var_1, var_2, var_3, var_4, var_5);
  precacherumble(var_0);
  var_6._id_1441 = var_0;
  level._id_2994[level._id_29F4] = var_6;
}

_id_29F6(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(level._id_2993)) {
    level._id_2993 = [];

  }
  var_7 = _id_29FA(var_2, var_3, var_4, var_5, var_6);
  precacherumble(var_1);
  var_7._id_1441 = var_1;
  level._id_2993[var_0] = var_7;
}

_id_29F7(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_29FA(var_1, var_2, var_3, var_4, var_5);
  var_6._id_1441 = var_0;
  self._id_2992 = var_6;
  _id_2A73();
  thread _id_2994();
}

_id_29F8(var_0, var_1, var_2) {
  var_3 = level._id_29F4;

  if(maps\_utility::_id_1E25()) {
    var_3 = level._id_29F9;

  }
  if(!isDefined(level._id_299A)) {
    level._id_299A = [];

  }
  level._id_299A[var_3] = _id_29FA(var_0, var_1, var_2);
}

_id_29FA(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.scale = var_0;
  var_5.duration = var_1;
  var_5.radius = var_2;

  if(isDefined(var_3)) {
    var_5._id_29FB = var_3;

  }
  if(isDefined(var_4)) {
    var_5._id_29FC = var_4;

  }
  return var_5;
}

_id_29FD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_5)) {
    var_5 = 0;

  }
  if(!isDefined(var_3)) {
    var_3 = 0;

  }
  if(!isDefined(var_4)) {
    var_4 = 1;

  }
  var_11 = spawnStruct();
  var_11._id_164E = common_scripts\utility::_loadfx(var_0);
  var_11.tag = var_1;
  var_11.sound = var_2;
  var_11._id_29F1 = var_5;
  var_11.delay = var_4;
  var_11._id_29EB = var_6;
  var_11._id_29EF = var_7;
  var_11.notifystring = var_8;
  var_11._id_29EE = var_3;
  var_11._id_29ED = var_9;
  var_11._id_29F0 = var_10;
  return var_11;
}

_id_29FE(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12) {
  if(!isDefined(level.script)) {
    level.script = tolower(getdvar("mapname"));

  }
  level._id_29F9 = var_1;
  level._id_29FF = var_2;
  level._id_2A00 = 1;

  if(maps\_utility::_id_1E25()) {
    var_0 = var_1 + var_2;
  } else {}

  level._id_29F4 = var_0;

  if(!isDefined(level._id_29CE)) {
    level._id_29CE = [];

  }
  if(!_id_2A03(var_0)) {
    level._id_29CE[var_0] = [];

  }
  level._id_2A01[var_0] = 1;

  if(!isDefined(level._id_29CE[var_0])) {
    level._id_29CE[var_0] = [];

  }
  level._id_29CE[var_0][level._id_29CE[var_0].size] = _id_29FD(var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
  level._id_2A00 = undefined;
}

_id_2A02(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = level._id_29F4;

  if(maps\_utility::_id_1E25()) {
    var_11 = level._id_29F9 + level._id_29FF;

  }
  if(_id_2A03(var_11)) {
    return;
  }
  if(!isDefined(level._id_29CE[var_11])) {
    level._id_29CE[var_11] = [];

  }
  level._id_29CE[var_11][level._id_29CE[var_11].size] = _id_29FD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
}

_id_2A03(var_0) {
  if(!isDefined(level._id_2A01)) {
    return 0;

  }
  if(!isDefined(level._id_2A01[var_0])) {
    return 0;

  }
  if(isDefined(level._id_2A00)) {
    return 1;

  }
  return level._id_2A01[var_0];
}

_id_2A04(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(maps\_utility::_id_1E25()) {
    var_11 = level._id_29F9;
    level._id_29F9 = "rocket_death" + var_11;
    _id_2A02(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    level._id_29F9 = var_11;
  } else {
    var_12 = level._id_29F4;
    level._id_29F4 = "rocket_death" + var_12;
    _id_2A02(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    level._id_29F4 = var_12;
  }
}

_id_2A05() {
  var_0 = [];
  var_1 = getEntArray("script_vehicle", "code_classname");
  level._id_2A06 = [];
  var_2 = [];
  var_0 = [];

  if(!isDefined(level._id_297F)) {
    level._id_297F = [];

  }
  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_1[var_3].vehicletype = tolower(var_1[var_3].vehicletype);

    if(var_1[var_3].vehicletype == "bog_mortar" || var_1[var_3].vehicletype == "empty") {
      continue;
    }
    if(isDefined(var_1[var_3].spawnflags) && var_1[var_3].spawnflags & 1) {
      var_2[var_2.size] = var_1[var_3];

    }
    var_0[var_0.size] = var_1[var_3];

    if(!isDefined(level._id_297F[var_1[var_3].vehicletype])) {
      level._id_297F[var_1[var_3].vehicletype] = [];

    }
    if(maps\_utility::_id_1E25()) {
      var_4 = "maps\\_" + var_1[var_3].vehicletype + "::main( \"" + var_1[var_3].model + "\" );";
    } else {
      var_4 = "classname: " + var_1[var_3].classname;

    }
    _id_2A07(var_4, var_1[var_3]);
  }

  if(level._id_2A06.size > 0) {
    for(var_3 = 0; var_3 < level._id_2A06.size; var_3++) {}

    level waittill("never");
  }

  return var_0;
}

_id_2A07(var_0, var_1) {
  if(maps\_utility::_id_1E25()) {
    if(isDefined(level._id_297F[var_1.vehicletype][var_1.model])) {
      return;
    }
  } else {
    if(isDefined(level._id_297F[var_1.vehicletype][var_1.classname])) {
      return;
    }
    if(var_1.classname == "script_vehicle") {
      return;
    }
  }

  var_2 = 0;

  for(var_3 = 0; var_3 < level._id_2A06.size; var_3++) {
    if(level._id_2A06[var_3] == var_0) {
      var_2 = 1;
    }
  }

  if(!var_2) {
    level._id_2A06[level._id_2A06.size] = var_0;
  }
}

_id_2A08() {
  self notify("kill_disconnect_paths_forever");
}

_id_2A09() {
  self endon("death");
  var_0 = 0;

  if(isDefined(self.script_disconnectpaths) && !self.script_disconnectpaths) {
    var_0 = 1;

  }
  if(var_0) {
    self._id_2998 = 1;
    return;
  }

  wait(randomfloat(1));

  while(isDefined(self)) {
    if(self vehicle_getspeed() < 1) {
      if(!isDefined(self._id_2998)) {
        self disconnectpaths();
      } else {}

      self notify("speed_zero_path_disconnect");

      while(self vehicle_getspeed() < 1) {
        wait 0.05;
      }
    }

    self connectpaths();
    wait 1;
  }
}

_id_2A0A(var_0, var_1, var_2) {
  if(self vehicle_getspeed() == 0 && var_0 == 0) {
    return;
  }
  self vehicle_setspeed(var_0, var_1);
}

_id_2A0B(var_0, var_1, var_2) {}

_id_2A0C(var_0, var_1) {
  self endon("death");
  var_2 = 0;
  var_3 = "resumespeed";

  if(!isDefined(self._id_2A0D)) {
    self._id_2A0D = [];

  }
  if(isDefined(self._id_296F) && self._id_296F) {
    return;
  }
  if(isDefined(self._id_2A0E)) {
    if(self._id_2A0E) {
      var_2 = self._id_2A0F;
      var_3 = "setspeed";
    }
  }

  self._id_297E = 0;

  if(var_2 == 0) {
    self._id_297E = 1;

  }
  if(var_3 == "resumespeed") {
    self resumespeed(var_1);
  } else if(var_3 == "setspeed") {
    _id_2A0A(var_2, 15, "resume setspeed from attack");

  }
  self notify("resuming speed");
}

_id_2A10(var_0) {
  self notify("newresumespeedmsag");
  self endon("newresumespeedmsag");
  self endon("death");

  while(gettime() < var_0 && isDefined(self._id_2A0D)) {
    if(self._id_2A0D.size > 6) {
      var_1 = self._id_2A0D.size - 5;
    } else {
      var_1 = 0;

    }
    for(var_2 = var_1; var_2 < self._id_2A0D.size; var_2++) {
      var_3 = var_2 * 32;

    }
    wait 0.05;
  }
}

_id_2A11() {
  if(common_scripts\utility::isdestructible()) {
    common_scripts\_destructible::force_explosion();
  } else {
    self kill();
  }
}

_id_2A12() {
  self.godmode = 1;
}

_id_2A13() {
  self.godmode = 0;
}

_id_2A14(var_0) {
  if(isDefined(self.mgturret) && self.mgturret.size) {
    for(var_1 = 0; var_1 < self.mgturret.size; var_1++) {
      self.mgturret[var_1]._id_22A5 = var_0;
    }
  }
}

_id_2A15(var_0) {
  var_1 = self getanimtime(var_0);
  var_2 = getanimlength(var_0);

  if(var_1 == 0) {
    return 0;

  }
  return self getanimtime(var_0) / getanimlength(var_0);
}

_id_2A16() {
  var_0 = getanimlength(maps\_utility::_id_1281("rotors"));

  for(;;) {
    self setanim(maps\_utility::_id_1281("rotors"), 1, 0, 1);
    wait(var_0);
  }
}

_id_2A17() {
  self notify("suspend_drive_anims");
  var_0 = self.model;
  self clearanim(level._id_29C9[var_0], 0);
  self clearanim(level._id_29CA[var_0], 0);
}

_id_2A18() {
  self useanimtree(#animtree);

  if(!isDefined(level._id_2A19[self.model])) {
    return;
  }
  foreach(var_1 in level._id_2A19[self.model]) {}
  self setanim(var_1);
}

_id_2A1A() {
  self endon("suspend_drive_anims");

  if(!isDefined(self._id_29C1)) {
    self._id_29C1 = 1;

  }
  var_0 = self.model;
  var_1 = -1;
  var_2 = undefined;
  self useanimtree(#animtree);

  if(!isDefined(level._id_29C9[var_0])) {
    return;
  }
  if(!isDefined(level._id_29CA[var_0])) {
    level._id_29CA[var_0] = level._id_29C9[var_0];

  }
  self endon("death");
  var_3 = level._id_2A1B[var_0];
  var_4 = 1.0;

  if(isDefined(level._id_2A1C) && isDefined(level._id_2A1C[var_0])) {
    var_4 = level._id_2A1C[var_0];

  }
  var_5 = self._id_29C1;
  var_6 = self;
  var_7 = level._id_29C9[var_0];

  for(;;) {
    if(isDefined(level._id_2A1D)) {
      var_6 = get_dummy();

    }
    if(!var_3) {
      if(isDefined(self._id_2A1E)) {
        wait 0.05;
        continue;
      }

      var_6 setanim(level._id_29C9[var_0], 1, 0.2, var_4);
      return;
    }

    var_8 = self vehicle_getspeed();

    if(_id_2AE0() && isDefined(self._id_2A1F)) {
      var_8 = self._id_2A1F;

    }
    if(var_5 != self._id_29C1) {
      var_9 = 0;

      if(self._id_29C1) {
        var_7 = level._id_29C9[var_0];
        var_9 = 1 - var_6 _id_2A15(level._id_29CA[var_0]);
        var_6 clearanim(level._id_29CA[var_0], 0);
      } else {
        var_7 = level._id_29CA[var_0];
        var_9 = 1 - var_6 _id_2A15(level._id_29C9[var_0]);
        var_6 clearanim(level._id_29C9[var_0], 0);
      }

      var_2 = 0.01;

      if(var_2 >= 1 || var_2 == 0) {
        var_2 = 0.01;

      }
      var_5 = self._id_29C1;
    }

    var_10 = var_8 / var_3;

    if(var_10 != var_1) {
      var_6 setanim(var_7, 1, 0.05, var_10);
      var_1 = var_10;
    }

    if(isDefined(var_2)) {
      var_6 setanimtime(var_7, var_2);
      var_2 = undefined;
    }

    wait 0.05;
  }
}

_id_2A20(var_0, var_1) {
  var_2 = [[var_1]](var_0.targetname);
  var_2._id_2909 = 0;
}

_id_2A21() {
  var_0 = getaiarray();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(var_0[var_1]._id_250B)) {
      level._id_2928 = _id_2A24(level._id_2928, var_0[var_1]._id_250B, var_0[var_1]);
      continue;
    }

    if(isDefined(var_0[var_1]._id_292D)) {
      level._id_2A22 = _id_2A24(level._id_2A22, var_0[var_1]._id_292D, var_0[var_1]);
    }
  }

  var_0 = getspawnerarray();

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isDefined(var_0[var_1]._id_250B)) {
      level._id_2926 = _id_2A24(level._id_2926, var_0[var_1]._id_250B, var_0[var_1]);

    }
    if(isDefined(var_0[var_1]._id_292D)) {
      level._id_2A23 = _id_2A24(level._id_2A23, var_0[var_1]._id_292D, var_0[var_1]);
    }
  }
}

_id_2A24(var_0, var_1, var_2) {
  if(!isDefined(var_0[var_1])) {
    var_0[var_1] = [];

  }
  var_0[var_1][var_0[var_1].size] = var_2;
  return var_0;
}

_id_2A25(var_0) {
  return isDefined(var_0.classname) && var_0.classname == "script_origin";
}

_id_2A26() {
  var_0 = 0;

  if(isDefined(self.spawnflags) && self.spawnflags & 1) {
    if(isDefined(self._id_2914)) {
      level._id_2A27[level._id_2A27.size] = self;

    }
    level._id_2A28[level._id_2A28.size] = self;
  }

  if(isDefined(self._id_2908) && isDefined(self.targetname)) {
    var_1 = undefined;

    if(isDefined(_id_2AD4(self.targetname))) {
      var_1 = ::_id_2AD6;

    }
    if(isDefined(_id_2AD3(self.targetname))) {
      var_1 = ::_id_2AD5;

    }
    if(isDefined(var_1)) {
      _id_2A20(self, var_1);
      var_0 = 1;
    } else {
      _id_2936(self);

    }
    level._id_2911 = _id_2A24(level._id_2911, self._id_2908, self);

    if(level._id_2911[self._id_2908].size > 2) {}
  }

  if(isDefined(self._id_28FC)) {
    level._id_28FD = _id_2A24(level._id_28FD, self._id_28FC, self);
    self._id_293E = 0;
  }

  if(isDefined(self._id_2057)) {
    if(!isDefined(level.flag[self._id_2057])) {
      common_scripts\utility::flag_init(self._id_2057);
    }
  }

  if(isDefined(self._id_2059)) {
    if(!isDefined(level.flag[self._id_2059])) {
      common_scripts\utility::flag_init(self._id_2059);
    }
  }

  if(isDefined(self._id_1288)) {
    if(!isDefined(level.flag[self._id_1288])) {
      common_scripts\utility::flag_init(self._id_1288);
    }
  }

  if(isDefined(self._id_28FF) || isDefined(self._id_290E) || isDefined(self._id_28FC) || isDefined(self._id_290C)) {
    var_0 = 1;

  }
  if(var_0) {
    _id_2938(self);
  }
}

_id_2A29() {
  level._id_28F4 = [];
  var_0 = [];
  var_0 = common_scripts\utility::array_combine(getallvehiclenodes(), getEntArray("script_origin", "code_classname"));
  var_0 = common_scripts\utility::array_combine(var_0, level.struct);
  var_0 = common_scripts\utility::array_combine(var_0, getEntArray("trigger_radius", "code_classname"));
  var_0 = common_scripts\utility::array_combine(var_0, getEntArray("trigger_disk", "code_classname"));
  var_0 = common_scripts\utility::array_combine(var_0, getEntArray("trigger_multiple", "code_classname"));
  var_0 = common_scripts\utility::array_combine(var_0, getEntArray("trigger_lookat", "code_classname"));
  common_scripts\utility::array_thread(var_0, ::_id_2A26);
}

_id_2A2A(var_0) {
  if(!isDefined(var_0.targetname)) {
    return 0;

  }
  return isDefined(common_scripts\utility::getstruct(var_0.targetname, "targetname"));
}

_id_2A2B(var_0) {
  var_1 = [];
  level._id_2A2C = [];

  foreach(var_3 in var_0) {
    var_3 _id_2AEF();

    if(var_3 _id_2A2E()) {
      continue;
    } else {
      var_1[var_1.size] = var_3;
    }
  }

  _id_2A2D();

  foreach(var_6 in var_1) {}
  thread _id_297C(var_6);
}

_id_2A2D() {
  if(!level._id_2A2C.size) {
    level._id_2A2C = undefined;
    return;
  }

  foreach(var_1 in level._id_2A2C) {}
}

_id_2A2E() {
  if(isDefined(self._id_28FF) && !isspawner(self)) {
    level._id_2A2C[level._id_2A2C.size] = self;
    return 1;
  }

  return isspawner(self);
}

_id_2A2F() {
  var_0 = self.classname;

  if(maps\_utility::_id_1E25()) {
    var_0 = self.vehicletype;

  }
  if(!isDefined(level._id_2A2F) || !isDefined(level._id_2A2F[var_0])) {
    wait 2;

  }
  if(isDefined(self._id_2189)) {
    self.health = self._id_2189;
  } else if(level._id_2A2F[var_0] == -1) {
    return;
  } else if(isDefined(level._id_2A30[var_0]) && isDefined(level._id_2A31[var_0])) {
    self.health = randomint(level._id_2A31[var_0] - level._id_2A30[var_0]) + level._id_2A30[var_0];
  } else {
    self.health = level._id_2A2F[var_0];

  }
  if(isDefined(level._id_2A32[self.model])) {
    self.health = 2000;
    self.destructible_type = level._id_2A32[self.model];
    common_scripts\_destructible::setup_destructibles(1);
  }
}

_id_2A33() {
  var_0 = self.classname;

  if(maps\_utility::_id_1E25()) {
    var_0 = self.vehicletype + self.model;

  }
  if(isDefined(self._id_24FE) && self._id_24FE > 0) {
    return;
  }
  if(!isDefined(level._id_2A34[var_0])) {
    return;
  }
  var_1 = 0;

  if(isDefined(self._id_2A35)) {
    var_1 = self._id_2A35;

  }
  var_2 = level._id_2A34[var_0];

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = isDefined(self.script_noteworthy) && self.script_noteworthy == "onemg";

  foreach(var_7, var_5 in var_2) {
    var_6 = spawnturret("misc_turret", (0, 0, 0), var_5._id_2A36);

    if(isDefined(var_5._id_2A37)) {
      var_6 linkto(self, var_5.tag, var_5._id_2A37, (0, -1 * var_1, 0));
    } else {
      var_6 linkto(self, var_5.tag, (0, 0, 0), (0, -1 * var_1, 0));

    }
    var_6 setModel(var_5.model);
    var_6.angles = self.angles;
    var_6._id_22AF = 1;
    var_6._id_2A38 = self;
    var_6.script_team = self.script_team;
    var_6 thread maps\_mgturret::_id_2278();
    var_6 makeunusable();
    _id_25BC(var_6);
    level thread maps\_mgturret::_id_229F(var_6, maps\_utility::_id_229D());

    if(isDefined(self._id_22A5)) {
      var_6._id_22A5 = self._id_22A5;

    }
    if(isDefined(var_5._id_2A39)) {
      var_6._id_2A39 = var_5._id_2A39;

    }
    if(isDefined(var_5.maxrange)) {
      var_6.maxrange = var_5.maxrange;

    }
    if(isDefined(var_5._id_2A3A)) {
      var_6 setdefaultdroppitch(var_5._id_2A3A);

    }
    self.mgturret[var_7] = var_6;

    if(var_3) {
      break;
    }
  }

  foreach(var_10, var_6 in self.mgturret) {
    var_9 = level._id_2A34[var_0][var_10]._id_22A7;

    if(isDefined(var_9)) {
      var_6 _id_28D8(var_9);
    }
  }

  if(!isDefined(self._id_2942)) {
    self._id_2942 = 1;

  }
  if(isDefined(self._id_2942) && self._id_2942 == 0) {
    thread _id_2A3D();
  } else {
    self._id_2942 = 1;
    thread _id_2A3E();
  }

  thread _id_2A3B();
}

_id_2A3B() {
  if(isDefined(level._id_2A3C) && level._id_2A3C) {
    return;
  }
  self endon("death");

  if(self._id_2942) {
    var_0 = 1;
  } else {
    var_0 = 0;

  }
  for(;;) {
    if(var_0 != self._id_2942) {
      var_0 = self._id_2942;

      if(self._id_2942) {
        thread _id_2A3E();
      } else {
        thread _id_2A3D();
      }
    }

    wait 0.5;
  }
}

_id_2A3D() {
  self._id_2942 = 0;

  if(_id_21ED() && _id_2A43()) {
    thread _id_2A45();
    return;
  }

  if(!isDefined(self.mgturret)) {
    return;
  }
  foreach(var_2, var_1 in self.mgturret) {
    if(isDefined(var_1._id_22A5)) {
      var_1._id_22A5 = 0;

    }
    var_1 setmode("manual");
  }
}

_id_2A3E() {
  self._id_2942 = 1;

  if(_id_21ED() && _id_2A43()) {
    thread _id_2A44();
    return;
  }

  if(!isDefined(self.mgturret)) {
    return;
  }
  foreach(var_1 in self.mgturret) {
    var_1 show();

    if(isDefined(var_1._id_22A5)) {
      var_1._id_22A5 = 1;

    }
    if(isDefined(var_1._id_22A7)) {
      if(var_1._id_22A7 != "sentry") {
        var_1 setmode(var_1._id_22A7);
      }
    } else {
      var_1 setmode("auto_nonai");

    }
    _id_25BC(var_1);
  }
}

_id_25BC(var_0) {
  switch (self.script_team) {
    case "friendly":
    case "allies":
      var_0 setturretteam("allies");
      break;
    case "enemy":
    case "axis":
      var_0 setturretteam("axis");
      break;
    case "team3":
      var_0 setturretteam("team3");
      break;
    default:
      break;
  }
}

_id_28D8(var_0) {
  self._id_22A7 = var_0;
}

_id_21ED() {
  return isDefined(level._id_28F6[self.vehicletype]);
}

_id_2A3F() {
  return isDefined(level._id_28F8[self.vehicletype]);
}

_id_2A40() {
  if(!isDefined(self._id_2A41)) {
    return 0;

  }
  if(!self._id_2A41) {
    return 0;

  }
  return 1;
}

_id_2A42() {
  if(!_id_21ED() && !_id_2A3F()) {
    return 0;

  }
  if(_id_2A40()) {
    return 0;

  }
  return 1;
}

_id_2A43() {
  if(!isDefined(self.vehicletype)) {
    return 0;

  }
  if(_id_2A40()) {
    return 0;

  }
  if(self.vehicletype == "cobra") {
    return 1;

  }
  if(self.vehicletype == "cobra_player") {
    return 1;

  }
  if(self.vehicletype == "viper") {
    return 1;

  }
  return 0;
}

_id_2A44() {
  self endon("death");
  self endon("mg_off");
  var_0 = cos(55);

  while(self.health > 0) {
    var_1 = maps\_helicopter_globals::_id_2865(16000, var_0, 1, 1);

    if(isDefined(var_1)) {
      thread maps\_helicopter_globals::_id_2867(var_1);

    }
    wait 2;
  }
}

_id_2A45() {
  self notify("mg_off");
}

_id_2A46(var_0, var_1, var_2) {
  var_3 = get_dummy();
  var_4 = spawn("script_origin", var_3.origin);
  self endon("fire_extinguish");
  thread _id_2A48(var_2, var_4);

  for(;;) {
    playFX(var_0, var_4.origin, var_4._id_2A47);
    wait(var_1);
  }
}

_id_2A48(var_0, var_1) {
  var_1.angles = self gettagangles(var_0);
  var_1.origin = self gettagorigin(var_0);
  var_1._id_2A49 = anglesToForward(var_1.angles);
  var_1._id_2A47 = anglestoup(var_1.angles);

  while(isDefined(self) && self.code_classname == "script_vehicle" && self vehicle_getspeed() > 0) {
    var_2 = get_dummy();
    var_1.angles = var_2 gettagangles(var_0);
    var_1.origin = var_2 gettagorigin(var_0);
    var_1._id_2A49 = anglesToForward(var_1.angles);
    var_1._id_2A47 = anglestoup(var_1.angles);
    wait 0.05;
  }
}

_id_2A4A(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(level._id_2A34)) {
    level._id_2A34 = [];

  }
  var_9 = level._id_29F4;

  if(maps\_utility::_id_1E25()) {
    var_9 = level._id_29F9 + level._id_29FF;

  }
  if(!isDefined(level._id_2A34[var_9])) {
    level._id_2A34[var_9] = [];

  }
  precachemodel(var_2);
  precacheturret(var_0);
  var_10 = spawnStruct();
  var_10._id_2A36 = var_0;
  var_10.tag = var_1;
  var_10.model = var_2;
  var_10.maxrange = var_3;
  var_10._id_22A7 = var_4;
  var_10._id_2A39 = var_5;
  var_10._id_2A3A = var_6;
  var_10._id_2A4B = var_7;

  if(isDefined(var_8)) {
    var_10._id_2A37 = var_8;

  }
  level._id_2A34[var_9][level._id_2A34[var_9].size] = var_10;
}

_id_2A4C() {}

_id_2A4D(var_0) {}

_id_2A4E() {
  level._id_2970 = 5;
  level._id_290D = [];
  level._id_290F = [];
  level._id_2928 = [];
  level._id_2A22 = [];
  level._id_2A4F = [];
  level._id_2926 = [];
  level._id_2A23 = [];
  level._id_28FD = [];
  level._id_2A27 = [];
  level._id_2921 = [];
  level._id_2911 = [];
  level._id_2A28 = [];
  level._id_2902 = [];

  if(!isDefined(level._id_2A50)) {
    level._id_2A50 = ::_id_2A4D;

  }
  level._id_29D9 = getEntArray("helicopter_crash_location", "targetname");
  level._id_29D9 = common_scripts\utility::array_combine(level._id_29D9, maps\_utility::_id_1BF9("helicopter_crash_location", "targetname"));
  level._id_284F = spawn("script_origin", (0, 0, 0));
  level._id_2A51 = level._id_284F;
  level._id_0B5A = [];
  level._id_0B5A["allies"] = [];
  level._id_0B5A["axis"] = [];
  level._id_0B5A["neutral"] = [];
  level._id_0B5A["team3"] = [];

  if(!isDefined(level._id_2A52)) {
    level._id_2A52 = [];

  }
  if(!isDefined(level._id_2996)) {
    level._id_2996 = [];

  }
  if(!isDefined(level._id_2995)) {
    level._id_2995 = [];

  }
  if(!isDefined(level._id_29C9)) {
    level._id_29C9 = [];

  }
  if(!isDefined(level._id_29CA)) {
    level._id_29CA = [];

  }
  if(!isDefined(level._id_2A53)) {
    level._id_2A53 = [];

  }
  if(!isDefined(level._id_2A54)) {
    level._id_2A54 = [];

  }
  if(!isDefined(level._id_2A55)) {
    level._id_2A55 = [];

  }
  if(!isDefined(level._id_2A56)) {
    level._id_2A56 = [];

  }
  if(!isDefined(level._id_2A57)) {
    level._id_2A57 = [];

  }
  if(!isDefined(level._id_2994)) {
    level._id_2994 = [];

  }
  if(!isDefined(level._id_2993)) {
    level._id_2993 = [];

  }
  if(!isDefined(level._id_2A34)) {
    level._id_2A34 = [];

  }
  if(!isDefined(level._id_2A58)) {
    level._id_2A58 = [];

  }
  if(!isDefined(level._id_299A)) {
    level._id_299A = [];

  }
  if(!isDefined(level._id_28EE)) {
    level._id_28EE = [];

  }
  if(!isDefined(level._id_2566)) {
    level._id_2566 = [];

  }
  if(!isDefined(level._id_24E6)) {
    level._id_24E6 = [];

  }
  if(!isDefined(level._id_2A59)) {
    level._id_2A59 = [];

  }
  if(!isDefined(level._id_2A5A)) {
    level._id_2A5A = [];

  }
  if(!isDefined(level._id_2A5B)) {
    level._id_2A5B = [];

  }
  if(!isDefined(level._id_2A5C)) {
    level._id_2A5C = [];

  }
  if(!isDefined(level._id_297D)) {
    level._id_297D = [];

  }
  if(!isDefined(level._id_2A5D)) {
    level._id_2A5D = [];

  }
  if(!isDefined(level._id_2A32)) {
    level._id_2A32 = [];

  }
  if(!isDefined(level._id_2A5E)) {
    level._id_2A5E = [];

  }
  if(!isDefined(level._id_2A5F)) {
    level._id_2A5F = [];

  }
  if(!isDefined(level._id_2A60)) {
    level._id_2A60 = [];

  }
  if(!isDefined(level._id_2A61)) {
    level._id_2A61 = [];

  }
  if(!isDefined(level._id_2A62)) {
    level._id_2A62 = [];

  }
  if(!isDefined(level._id_2A19)) {
    level._id_2A19 = [];

  }
  maps\_vehicle_aianim::_id_2536();
}

_id_1C07(var_0) {
  if(isDefined(var_0) && isDefined(var_0.script_team) && isDefined(self.script_team) && var_0.script_team == self.script_team) {
    return 1;
  } else {
    return 0;
  }
}

_id_2A63(var_0) {
  if(!isDefined(self._id_2A64)) {
    return 0;

  }
  if(isDefined(var_0) && isai(var_0) && self._id_2A64 == 1) {
    return 1;
  } else {
    return 0;
  }
}

_id_1C06() {
  if(isDefined(self.godmode) && self.godmode) {
    return 1;
  } else {
    return 0;
  }
}

_id_2A65(var_0) {
  if(isDefined(self.script_team) && self.script_team == "allies" && isDefined(var_0) && isplayer(var_0)) {
    return 1;
  } else if(isai(var_0) && var_0.team == self.script_team) {
    return 1;
  } else {
    return 0;
  }
}

_id_2A66() {
  return isDefined(level._id_2A5D[self.vehicletype]);
}

_id_2A67(var_0) {
  if(!isDefined(self._id_2A68)) {
    return 0;

  }
  var_0 = tolower(var_0);

  if(!isDefined(var_0) || !issubstr(var_0, "grenade")) {
    return 0;

  }
  if(self._id_2A68) {
    return 1;
  } else {
    return 0;
  }
}

_id_2A69(var_0) {
  if(!isDefined(self.script_bulletshield)) {
    return 0;

  }
  var_0 = tolower(var_0);

  if(!isDefined(var_0) || !issubstr(var_0, "bullet") || issubstr(var_0, "explosive")) {
    return 0;

  }
  if(self.script_bulletshield) {
    return 1;
  } else {
    return 0;
  }
}

_id_2A6A(var_0) {
  if(!isDefined(self._id_2A6B)) {
    return 0;

  }
  var_0 = tolower(var_0);

  if(!isDefined(var_0) || !issubstr(var_0, "explosive")) {
    return 0;

  }
  if(self._id_2A6B) {
    return 1;
  } else {
    return 0;
  }
}

_id_2A6C(var_0, var_1) {
  return !isDefined(var_0) && self.script_team != "neutral" || _id_1C07(var_0) || _id_2A65(var_0) || common_scripts\utility::isdestructible() || _id_2A63(var_0) || _id_2A69(var_1) || _id_2A6A(var_1) || _id_2A67(var_1) || var_1 == "MOD_MELEE";
}

_id_2A6D() {
  self endon("death");

  if(!isDefined(level._id_2A6E)) {
    self endon("stop_friendlyfire_shield");

  }
  var_0 = self.classname;

  if(maps\_utility::_id_1E25()) {
    var_0 = self.vehicletype;

  }
  if(isDefined(level._id_2A60[var_0]) && !isDefined(self.script_bulletshield)) {
    self.script_bulletshield = level._id_2A60[var_0];

  }
  if(isDefined(level._id_2A5F[var_0]) && !isDefined(self._id_2A68)) {
    self._id_2A68 = level._id_2A60[var_0];

  }
  if(isDefined(self._id_29A9)) {
    self._id_29A9 = 1;
    self._id_2A6F = 5000;
    self.health = 350;
  } else {
    self._id_29A9 = 0;

  }
  self._id_163B = 20000;
  self.health = self.health + self._id_163B;
  self._id_29A1 = self.health;
  var_1 = undefined;
  var_2 = undefined;

  for(var_3 = undefined; self.health > 0; var_3 = undefined) {
    self waittill("damage", var_4, var_1, var_5, var_6, var_2, var_7, var_8, var_9, var_10, var_3);

    foreach(var_12 in self._id_215B) {}
    thread[[var_12]](var_4, var_1, var_5, var_6, var_2, var_7, var_8);

    if(isDefined(var_1)) {
      var_1 maps\_player_stats::_id_0A3B();

    }
    if(_id_2A6C(var_1, var_2) || _id_1C06()) {
      self.health = self._id_29A1;
    } else if(_id_2A66()) {
      _id_2A72(var_1, var_4);
      self._id_29A1 = self.health;
    } else if(_id_2A71(var_2)) {
      self.health = self._id_29A1;
      self._id_2A6F = self._id_2A6F - var_4;
    } else {
      self._id_29A1 = self.health;

    }
    if(common_scripts\_destructible::getdamagetype(var_2) == "splash") {
      self._id_29A4 = 1;
    } else {
      self._id_29A4 = undefined;

    }
    if(self.health < self._id_163B && !isDefined(self._id_2A70)) {
      break;
    }

    var_4 = undefined;
    var_1 = undefined;
    var_5 = undefined;
    var_6 = undefined;
    var_2 = undefined;
    var_7 = undefined;
    var_8 = undefined;
    var_9 = undefined;
    var_10 = undefined;
  }

  self notify("death", var_1, var_2, var_3);
}

_id_2A71(var_0) {
  if(!self._id_29A9) {
    return 0;

  }
  if(self._id_2A6F <= 0) {
    return 0;

  }
  if(!isDefined(var_0)) {
    return 0;

  }
  if(!issubstr(var_0, "BULLET")) {
    return 0;
  } else {
    return 1;
  }
}

_id_2A72(var_0, var_1) {
  var_2 = anglesToForward(self.angles);
  var_3 = vectornormalize(var_0.origin - self.origin);

  if(vectordot(var_2, var_3) > 0.86) {
    self.health = self.health + int(var_1 * level._id_2A5D[self.vehicletype]);
  }
}

_id_2A73() {
  self notify("kill_rumble_forever");
}

_id_2994() {
  self endon("kill_rumble_forever");
  var_0 = self.classname;

  if(maps\_utility::_id_1E25()) {
    var_0 = self.vehicletype;

  }
  var_1 = undefined;

  if(isDefined(self._id_2992)) {
    var_1 = self._id_2992;
  } else if(isDefined(level._id_2993) && isDefined(level._id_2993[var_0])) {
    var_1 = level._id_2993;
  } else if(isDefined(level._id_2994[var_0])) {
    var_1 = level._id_2994[var_0];

  }
  if(!isDefined(var_1)) {
    return;
  }
  var_2 = var_1.radius * 2;
  var_3 = -1 * var_1.radius;
  var_4 = spawn("trigger_radius", self.origin + (0, 0, var_3), 0, var_1.radius, var_2);
  var_4 enablelinkto();
  var_4 linkto(self);
  self._id_2991 = var_4;
  self endon("death");

  if(!isDefined(self._id_29B7)) {
    self._id_29B7 = 1;

  }
  if(isDefined(var_1.scale)) {
    self._id_29B6 = var_1.scale;
  } else {
    self._id_29B6 = 0.15;

  }
  if(isDefined(var_1.duration)) {
    self._id_29A6 = var_1.duration;
  } else {
    self._id_29A6 = 4.5;

  }
  if(isDefined(var_1.radius)) {
    self._id_29A7 = var_1.radius;
  } else {
    self._id_29A7 = 600;

  }
  if(isDefined(var_1._id_29FB)) {
    self._id_29A5 = var_1._id_29FB;
  } else {
    self._id_29A5 = 1;

  }
  if(isDefined(var_1._id_29FC)) {
    self._id_29B5 = var_1._id_29FC;
  } else {
    self._id_29B5 = 1;

  }
  var_4.radius = self._id_29A7;

  for(;;) {
    var_4 waittill("trigger");

    if(self vehicle_getspeed() == 0 || !self._id_29B7) {
      wait 0.1;
      continue;
    }

    self playrumblelooponentity(var_1._id_1441);

    while(level.player istouching(var_4) && self._id_29B7 && self vehicle_getspeed() > 0) {
      earthquake(self._id_29B6, self._id_29A6, self.origin, self._id_29A7);
      wait(self._id_29A5 + randomfloat(self._id_29B5));
    }

    self stoprumble(var_1._id_1441);
  }
}

_id_2A74() {
  self notify("kill_badplace_forever");
}

_id_2A75() {
  if(!isDefined(self._id_2941)) {
    return;
  }
  self endon("kill_badplace_forever");

  if(!self isphysveh()) {
    self endon("death");

  }
  self endon("delete");

  if(isDefined(level._id_2A76)) {
    self thread[[level._id_2A76]]();
    return;
  }

  var_0 = isDefined(level._id_29D2[self.model]) && level._id_29D2[self.model];
  var_1 = 0.5;
  var_2 = 17;
  var_3 = 17;

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    if(!isDefined(self._id_2941) || !self._id_2941) {
      while(isDefined(self) && (!isDefined(self._id_2941) || !self._id_2941)) {
        wait 0.5;

      }
      if(!isDefined(self)) {
        return;
      }
    }

    var_4 = self vehicle_getspeed();

    if(var_4 <= 0) {
      wait(var_1);
      continue;
    }

    if(var_4 < 5) {
      var_5 = 200;
    } else if(var_4 > 5 && var_4 < 8) {
      var_5 = 350;
    } else {
      var_5 = 500;

    }
    if(isDefined(self._id_29B4)) {
      var_5 = var_5 * self._id_29B4;

    }
    if(var_0) {
      var_6 = anglesToForward(self gettagangles("tag_turret"));
    } else {
      var_6 = anglesToForward(self.angles);

    }
    badplace_arc(self.unique_id + "arc", var_1, self.origin, var_5 * 1.9, 300, var_6, var_2, var_3, "axis", "team3", "allies");
    badplace_cylinder(self.unique_id + "cyl", var_1, self.origin, 200, 300, "axis", "team3", "allies");
    wait(var_1 + 0.05);
  }
}

_id_2A77() {
  if(_id_21ED()) {
    return 1;

  }
  if(_id_2A3F()) {
    return 1;

  }
  return 0;
}

_id_28EE() {
  var_0 = self.classname;

  if(maps\_utility::_id_1E25()) {
    var_0 = self.vehicletype;

  }
  if(!isDefined(level._id_28EE[var_0])) {
    return;
  }
  if(_id_2A77()) {
    return;
  }
  if(isDefined(level._id_2A78)) {
    self thread[[level._id_2A78]]("tag_origin", "back_left", (160, 0, 0));
  } else {
    var_1[0] = "snowmobile";
    var_1[1] = "snowmobile_friendly";
    var_1[2] = "snowmobile_player";
    var_1[3] = "motorcycle";

    if(maps\_utility::is_in_array(var_1, self.vehicletype)) {
      thread _id_2A79();
      return;
    }

    thread _id_2A7A();
  }
}

_id_2A79() {
  self endon("death");
  self endon("kill_treads_forever");

  for(;;) {
    var_0 = _id_2A7C();

    if(var_0 == -1) {
      wait 0.1;
      continue;
    }

    var_1 = get_dummy();
    var_1 _id_2A7E(var_1, var_0, "tag_wheel_back_left", "back_left", 1, "tag_wheel_back_right");
  }
}

_id_2A7A() {
  self endon("death");
  self endon("kill_treads_forever");

  for(;;) {
    var_0 = _id_2A7C();

    if(var_0 == -1) {
      wait 0.1;
      continue;
    }

    var_1 = get_dummy();
    _id_2A7E(var_1, var_0, "tag_wheel_back_left", "back_left", 0);
    wait 0.05;
    _id_2A7E(var_1, var_0, "tag_wheel_back_right", "back_right", 0);
    wait 0.05;
  }
}

_id_2A7B() {
  self notify("kill_treads_forever");
}

_id_2A7C() {
  var_0 = self vehicle_getspeed();

  if(!var_0) {
    return -1;

  }
  var_0 = var_0 * 17.6;
  var_1 = 1 / var_0;
  var_1 = clamp(var_1 * 35, 0.1, 0.3);

  if(isDefined(self._id_2A7D)) {
    var_1 = var_1 * self._id_2A7D;

  }
  wait(var_1);
  return var_1;
}

_id_2A7E(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = _id_2A7F(self, var_3);

  if(var_6 == -1) {
    return;
  }
  var_7 = var_0 gettagangles(var_2);
  var_8 = anglesToForward(var_7);
  var_9 = self gettagorigin(var_2);

  if(var_4) {
    var_10 = self gettagorigin(var_5);
    var_9 = (var_9 + var_10) / 2;
  }

  playFX(var_6, var_9, anglestoup(var_7), var_8 * var_1);
}

_id_2A7F(var_0, var_1) {
  var_2 = self getwheelsurface(var_1);

  if(!isDefined(var_0.vehicletype)) {
    var_3 = -1;
    return var_3;
  }

  var_4 = var_0.classname;

  if(maps\_utility::_id_1E25()) {
    var_4 = var_0.vehicletype;

  }
  if(!isDefined(level._id_28F0[var_4])) {
    wait 1;
    return -1;
  }

  var_3 = level._id_28F0[var_4][var_2];

  if(!isDefined(var_3)) {
    var_3 = -1;

  }
  return var_3;
}

_id_2A80() {
  var_0 = self.vehicletype;

  if(isDefined(level._id_2A58[var_0]) && level._id_2A58[var_0]) {
    return 1;
  } else {
    return 0;
  }
}

_id_2A5C() {
  if(!isDefined(level._id_2A5C[self.classname])) {
    return;
  }
  if(getdvar("disable_tank_shock_minspec") == "1") {
    return;
  }
  self endon("death");

  if(!isDefined(level._id_2A81)) {
    level._id_2A81 = newhudelem();
    level._id_2A81.x = 0;
    level._id_2A81.y = 0;
    level._id_2A81 setshader("black", 640, 480);
    level._id_2A81.alignx = "left";
    level._id_2A81.aligny = "top";
    level._id_2A81.horzalign = "fullscreen";
    level._id_2A81.vertalign = "fullscreen";
    level._id_2A81.alpha = 0;
  }

  self endon("stop_vehicle_shoot_shock");

  for(;;) {
    self waittill("weapon_fired");

    if(isDefined(self._id_2A82)) {
      var_0 = self._id_2A82;
    } else {
      var_0 = 400;

    }
    if(isDefined(self._id_2A83)) {
      var_1 = self._id_2A83;
    } else {
      var_1 = 800;

    }
    var_2 = distance(self.origin, level.player.origin);

    if(var_2 > var_1) {
      continue;
    }
    level._id_2A81.alpha = 0.5;
    level._id_2A81 fadeovertime(0.2);
    level._id_2A81.alpha = 0;

    if(var_2 > var_0) {
      continue;
    }
    if(isDefined(level.player.flashendtime) && level.player.flashendtime - gettime() > 200) {
      continue;
    }
    if(isDefined(self._id_2A84) && self._id_2A84) {
      continue;
    }
    var_3 = var_2 / var_0;
    var_4 = 4 - 3 * var_3;
    level.player shellshock(level._id_2A5C[self.classname], var_4);
  }
}

_id_2A85() {
  var_0 = self.classname;

  if(maps\_utility::_id_1E25()) {
    var_0 = self.vehicletype;

  }
  if(!isDefined(self.script_team) && isDefined(level._id_2A52[var_0])) {
    self.script_team = level._id_2A52[var_0];

  }
  level._id_0B5A[self.script_team] = maps\_utility::_id_0BC3(level._id_0B5A[self.script_team], self);
}

_id_2A86() {
  self endon("death");
  var_0 = self.vehicletype;

  if(!maps\_utility::_id_133C("unloaded")) {
    maps\_utility::_id_1402("unloaded");
  }
}

_id_2A87(var_0) {
  var_1 = getvehiclenode(var_0, "targetname");

  if(!isDefined(var_1)) {
    var_1 = getent(var_0, "targetname");
  } else if(_id_21ED()) {}

  if(!isDefined(var_1)) {
    var_1 = common_scripts\utility::getstruct(var_0, "targetname");

  }
  return var_1;
}

_id_269B() {
  if(!_id_21ED()) {
    self resumespeed(35);
    return;
  }

  var_0 = undefined;

  if(isDefined(self.currentnode.target)) {
    var_0 = _id_2A87(self.currentnode.target);

  }
  if(!isDefined(var_0)) {
    return;
  }
  _id_26A1(var_0);
}

_id_2848(var_0, var_1) {
  if(self.health <= 0) {
    return;
  }
  if(isDefined(self._id_295E)) {
    var_0 = var_0 + (0, 0, self._id_295E);

  }
  self setvehgoalpos(var_0, var_1);
}

_id_269F(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 512;

  }
  var_1 = self.origin + (0, 0, var_0);
  self setneargoalnotifydist(10);
  _id_2848(var_1, 1);
  self waittill("goal");
}

_id_2A88() {
  var_0 = 12;
  var_1 = 400;
  var_2 = gettime() + var_1;

  while(isDefined(self)) {
    if(abs(self.angles[0]) > var_0) {
      var_2 = gettime() + var_1;

    }
    if(abs(self.angles[2]) > var_0) {
      var_2 = gettime() + var_1;

    }
    if(gettime() > var_2) {
      break;
    }

    wait 0.05;
  }
}

_id_2A89() {
  self endon("death");
  maps\_utility::_id_1402("prep_unload");
  maps\_utility::_id_1654("prep_unload");
  _id_2937();
  var_0 = _id_2A8A();
  var_0 _id_2B04(self);
  _id_26A1(var_0);
}

_id_2A8A() {
  var_0 = self.currentnode;

  for(;;) {
    var_1 = maps\_utility::_id_27F1(var_0.target, "targetname");

    if(isDefined(var_1._id_2954)) {
      return var_1;

    }
    var_0 = var_1;
  }
}

_id_2A8B(var_0) {
  self endon("death");

  if(isDefined(self._id_1008["prep_unload"]) && maps\_utility::_id_1008("prep_unload")) {
    return;
  }
  if(issubstr(self.classname, "snowmobile")) {
    while(self.veh_speed > 15) {
      wait 0.05;
    }
  }

  if(!isDefined(var_0._id_1288) && !isDefined(var_0.script_delay)) {
    self notify("newpath");

  }
  var_1 = getnode(var_0.targetname, "target");

  if(isDefined(var_1) && self._id_0A39.size) {
    foreach(var_3 in self._id_0A39) {
      if(isai(var_3)) {
        var_3 thread maps\_spawner::_id_21A4(var_1);
      }
    }
  }

  if(_id_21ED()) {
    self sethoverparams(0, 0, 0);
    _id_2A88();
  } else {
    self vehicle_setspeed(0, 35);

  }
  if(isDefined(var_0.script_noteworthy)) {
    if(var_0.script_noteworthy == "wait_for_flag") {
      common_scripts\utility::flag_wait(var_0._id_1692);
    }
  }

  _id_2514(var_0._id_2954);

  if(maps\_vehicle_aianim::_id_2564(var_0._id_2954)) {
    self waittill("unloaded");

  }
  if(isDefined(var_0._id_1288) || isDefined(var_0.script_delay)) {
    return;
  }
  if(isDefined(self)) {
    thread _id_269B();
  }
}

_id_2A8C(var_0) {
  var_1 = self.classname;

  if(maps\_utility::_id_1E25()) {
    var_1 = self.vehicletype + self.model;

  }
  if(!isDefined(self.mgturret)) {
    return;
  }
  if(self.mgturret.size == 0) {
    return;
  }
  foreach(var_4, var_3 in self.mgturret) {
    var_3 unlink();
    var_3 linkto(var_0, level._id_2A34[var_1][var_4].tag, (0, 0, 0), (0, 0, 0));
  }
}

_id_2699() {
  self._id_291A = undefined;
  self notify("newpath");
  self setgoalyaw(common_scripts\utility::flat_angle(self.angles)[1]);
  self setvehgoalpos(self.origin + (0, 0, 4), 1);
}

_id_2A8D() {
  self.modeldummy = spawn("script_model", self.origin);
  self.modeldummy setModel(self.model);
  self.modeldummy.origin = self.origin;
  self.modeldummy.angles = self.angles;
  self.modeldummy useanimtree(#animtree);
  self hide();
  thread _id_2A8F();
  _id_2A96(self.modeldummy);
  _id_2A8C(self.modeldummy);
  _id_2A91(self.modeldummy);
  thread _id_2A90(self.modeldummy);
  _id_2A8E(self.modeldummy);
  _id_2ADF(self.modeldummy);
  self.modeldummyon = 1;

  if(_id_2A42()) {
    self notify("stop_kicking_up_dust");
    thread _id_2A9B(self.modeldummy);
  }

  return self.modeldummy;
}

_id_2A8E(var_0) {
  var_1 = _id_2AB9();
  var_1 unlink();
  var_1 linkto(var_0);
}

_id_2A8F() {
  var_0 = self.modeldummy;
  var_0 endon("death");
  var_0 endon("stop_model_dummy_death");

  while(isDefined(self)) {
    self waittill("death");
    waittillframeend;
  }

  var_0 delete();
}

_id_2A90(var_0, var_1) {
  var_0 _id_2AB6("all", self.classname);
  wait 0.3;
  thread _id_2B18("all", self.classname);
}

_id_2A91(var_0) {
  if(!isDefined(self._id_2974)) {
    return;
  }
  foreach(var_2 in self._id_2974) {
    if(var_2 == var_0) {
      continue;
    }
    var_2 unlink();

    if(isDefined(var_2._id_2A92)) {
      var_2 linkto(var_0, var_2._id_2A92, var_2._id_2A94, var_2._id_2A93);
      continue;
    }

    var_2 linkto(var_0);
  }
}

_id_2A95() {
  if(_id_21ED()) {
    self.modeldummy.origin = self gettagorigin("tag_ground");
  } else {
    self.modeldummy.origin = self.origin;
    self.modeldummy.angles = self.angles;
  }

  self show();
  _id_2A96(self);
  _id_2A8C(self);
  thread _id_2A90(self);
  _id_2A8E(self);
  self.modeldummyon = 0;
  self.modeldummy delete();
  self.modeldummy = undefined;

  if(_id_2A42()) {
    self notify("stop_kicking_up_dust");
    thread _id_2A9B();
  }

  return self.modeldummy;
}

_id_2A96(var_0) {
  if(!isDefined(self._id_0A39)) {
    return;
  }
  var_1 = self._id_0A39;

  foreach(var_3 in var_1) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_4 = maps\_vehicle_aianim::_id_2534(self, var_3._id_2252);

    if(isDefined(var_4._id_25BB)) {
      continue;
    }
    var_3 unlink();
    var_3 linkto(var_0, var_4._id_24F2, (0, 0, 0), (0, 0, 0));

    if(isai(var_3)) {
      var_3 forceteleport(var_0 gettagorigin(var_4._id_24F2));
      continue;
    }

    var_3.origin = var_0 gettagorigin(var_4._id_24F2);
  }
}

_id_2A97(var_0) {
  var_1 = [];
  var_2 = getEntArray(var_0, "targetname");
  var_3 = [];

  foreach(var_5 in var_2) {
    if(!isDefined(var_5.code_classname) || var_5.code_classname != "script_vehicle") {
      continue;
    }
    if(isspawner(var_5)) {
      var_1[var_1.size] = _id_211F(var_5);
    }
  }

  return var_1;
}

_id_2A98(var_0) {
  var_1 = [];
  var_1 = _id_2A97(var_0);
  return var_1;
}

_id_2A99(var_0) {
  var_1 = _id_2A98(var_0);
  return var_1[0];
}

_id_2881(var_0) {
  var_1 = _id_2A98(var_0);
  thread _id_1FA6(var_1[0]);
  return var_1[0];
}

_id_2A9A(var_0) {
  var_1 = _id_2A98(var_0);

  foreach(var_3 in var_1) {}
  thread _id_1FA6(var_3);

  return var_1;
}

_id_2A9B(var_0) {
  self endon("death_finished");
  self endon("stop_kicking_up_dust");
  var_1 = 1200;

  if(isDefined(level._id_2A9C)) {
    var_1 = level._id_2A9C;

  }
  var_2 = 350;
  var_3 = 0.15;
  var_4 = 0.05;
  var_5 = 3;
  var_6 = var_5;
  var_7 = 1.0;

  if(_id_2A3F()) {
    var_7 = 0.15;

  }
  var_8 = var_7;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = self;

  if(isDefined(var_0)) {
    var_11 = var_0;

  }
  if(isDefined(level._id_2A9D)) {
    var_8 = 0.1;
    var_6 = 1;
  }

  while(isDefined(self)) {
    if(isDefined(level._id_2A9E)) {
      return 1;

    }
    if(var_8 <= 0) {
      var_8 = var_7;

    }
    wait(var_8);

    if(!isDefined(self)) {
      return;
    }
    var_6--;

    if(var_6 <= 0) {
      var_6 = var_5;
      var_9 = bulletTrace(var_11.origin, var_11.origin - (0, 0, 100000), 0, var_11);
      var_10 = distance(var_11.origin, var_9["position"]);
      var_8 = (var_10 - var_2) / (var_1 - var_2) * (var_3 - var_4) + var_4;
    }

    if(!isDefined(var_9)) {
      continue;
    }
    if(var_10 > var_1) {
      var_8 = var_7;
      continue;
    }

    if(isDefined(var_9["entity"])) {
      var_8 = var_7;
      continue;
    }

    if(!isDefined(var_9["position"])) {
      var_8 = var_7;
      continue;
    }

    if(!isDefined(var_9["surfacetype"])) {
      var_9["surfacetype"] = "dirt";

    }
    var_12 = self.classname;

    if(maps\_utility::_id_1E25()) {
      var_12 = self.vehicletype;

    }
    if(level._id_28F0[var_12][var_9["surfacetype"]] != -1) {
      playFX(level._id_28F0[var_12][var_9["surfacetype"]], var_9["position"]);
      continue;
    }
  }
}

_id_2A9F(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_6)) {
    var_6 = 1;

  }
  var_7 = _id_2A8D();
  self vehicle_setspeed(7 * var_6, 5, 5);
  var_8 = getanimlength(var_2) / var_6;
  var_9 = var_8 / 3;
  var_10 = var_8 / 3;
  var_11 = var_0.origin;
  var_12 = var_0.angles;
  var_13 = anglesToForward(var_12);
  var_14 = anglestoup(var_12);
  var_15 = anglestoright(var_12);
  var_16 = getstartorigin(var_11, var_12, var_2);
  var_17 = getstartangles(var_11, var_12, var_2);
  var_18 = anglesToForward(var_17);
  var_19 = anglestoup(var_17);
  var_20 = anglestoright(var_17);
  var_21 = anglesToForward(var_7.angles);
  var_22 = anglestoup(var_7.angles);
  var_23 = anglestoright(var_7.angles);
  var_24 = var_11 - var_16;
  var_25 = vectordot(var_24, var_18);
  var_26 = vectordot(var_24, var_19);
  var_27 = vectordot(var_24, var_20);
  var_28 = spawn("script_origin", var_7.origin);
  var_28.origin = var_28.origin + var_21 * var_25;
  var_28.origin = var_28.origin + var_22 * var_26;
  var_28.origin = var_28.origin + var_23 * var_27;
  var_24 = anglesToForward(var_12);
  var_25 = vectordot(var_24, var_18);
  var_26 = vectordot(var_24, var_19);
  var_27 = vectordot(var_24, var_20);
  var_29 = var_21 * var_25;
  var_29 = var_29 + var_22 * var_26;
  var_29 = var_29 + var_23 * var_27;
  var_28.angles = vectortoangles(var_29);

  if(isDefined(var_5)) {
    level thread common_scripts\utility::play_sound_in_space(var_5, var_11);

  }
  var_7 linkto(var_28);
  var_0 useanimtree(var_4);
  var_7 useanimtree(var_4);
  var_0 thread _id_2AA2("tag_window_left_glass_fx", level._id_28F0["tankcrush"]["window_med"], "veh_glass_break_small", 0.2);
  var_0 thread _id_2AA2("tag_window_right_glass_fx", level._id_28F0["tankcrush"]["window_med"], "veh_glass_break_small", 0.4);
  var_0 thread _id_2AA2("tag_windshield_back_glass_fx", level._id_28F0["tankcrush"]["window_large"], "veh_glass_break_large", 0.7);
  var_0 thread _id_2AA2("tag_windshield_front_glass_fx", level._id_28F0["tankcrush"]["window_large"], "veh_glass_break_large", 1.5);
  var_0 animscripted("tank_crush_anim", var_11, var_12, var_3);
  var_7 animscripted("tank_crush_anim", var_28.origin, var_28.angles, var_2);

  if(var_6 != 1) {
    var_0 setflaggedanim("tank_crush_anim", var_3, 1, 0, var_6);
    var_7 setflaggedanim("tank_crush_anim", var_2, 1, 0, var_6);
  }

  var_28 moveto(var_11, var_9, var_9 / 2, var_9 / 2);
  var_28 rotateto(var_12, var_9, var_9 / 2, var_9 / 2);
  wait(var_9);
  var_8 = var_8 - var_9;
  var_8 = var_8 - var_10;
  wait(var_8);
  var_30 = spawn("script_model", var_16);
  var_30.angles = var_17;
  var_31 = var_30 localtoworldcoords(getmovedelta(var_2, 0, 1));
  var_32 = var_17 + (0, getangledelta(var_2, 0, 1), 0);
  var_30 delete();
  var_33 = anglesToForward(var_32);
  var_34 = anglestoup(var_32);
  var_35 = anglestoright(var_32);
  var_36 = self getattachpos(var_1);
  var_21 = anglesToForward(var_36[1]);
  var_22 = anglestoup(var_36[1]);
  var_23 = anglestoright(var_36[1]);
  var_24 = var_11 - var_31;
  var_25 = vectordot(var_24, var_33);
  var_26 = vectordot(var_24, var_34);
  var_27 = vectordot(var_24, var_35);
  var_28._id_2AA0 = var_36[0];
  var_28._id_2AA0 = var_28._id_2AA0 + var_21 * var_25;
  var_28._id_2AA0 = var_28._id_2AA0 + var_22 * var_26;
  var_28._id_2AA0 = var_28._id_2AA0 + var_23 * var_27;
  var_24 = anglesToForward(var_12);
  var_25 = vectordot(var_24, var_33);
  var_26 = vectordot(var_24, var_34);
  var_27 = vectordot(var_24, var_35);
  var_29 = var_21 * var_25;
  var_29 = var_29 + var_22 * var_26;
  var_29 = var_29 + var_23 * var_27;
  var_28._id_2AA1 = vectortoangles(var_29);

  if(getdvar("debug_tankcrush") == "1") {
    thread maps\_utility::_id_2652(level.player, self.origin, 1, 0, 0, var_8 / 2);
    thread maps\_utility::_id_2652(level.player, var_31, 0, 1, 0, var_8 / 2);
    thread maps\_utility::_id_2653(level.player, var_28, 0, 0, 1, var_8 / 2);
  }

  var_28 moveto(var_28._id_2AA0, var_10, var_10 / 2, var_10 / 2);
  var_28 rotateto(var_28._id_2AA1, var_10, var_10 / 2, var_10 / 2);
  wait(var_10);
  self attachpath(var_1);
  common_scripts\utility::waitframe();
  _id_2A95();
}

_id_2AA2(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    wait(var_3);

  }
  playFXOnTag(var_1, self, var_0);

  if(isDefined(var_2)) {
    thread maps\_utility::play_sound_on_tag(var_2, var_0);
  }
}

_id_2AA3(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;

  }
  var_2 = undefined;

  foreach(var_4 in self._id_0A39) {
    if(var_4._id_2252 == var_0) {
      var_2 = var_4;
      var_2._id_224F = 1;
      var_2._id_254E = 1;
      break;
    }
  }

  thread _id_2AA5(var_0);
  var_6 = maps\_vehicle_aianim::_id_2534(self, var_0);
  var_2 notify("newanim");
  var_2 detachall();
  var_2 setModel("fastrope_arms");
  var_2 useanimtree(var_6._id_2AA4);
  thread maps\_vehicle_aianim::_id_2549(var_2, var_0);
  level.player playerlinktodelta(var_2, "tag_player", 1.0, 40, 18, 30, 30);
  var_2 hide();
  var_7 = getanimlength(var_6._id_257C);
  var_7 = var_7 - var_1;
  self waittill("unloading");
  level.player disableweapons();
  var_2 notsolid();
  wait(var_7);
  level.player unlink();
  level.player enableweapons();
}

_id_2AA5(var_0) {
  wait 0.01;
  thread maps\_vehicle_aianim::_id_2574(self, var_0);

  if(!self._id_0A39.size) {
    return;
  }
  foreach(var_2 in self._id_0A39) {}
  thread maps\_vehicle_aianim::_id_2574(self, var_2._id_2252);
}

_id_2AA6(var_0) {
  if(isDefined(self)) {
    if(isDefined(var_0._id_2A39)) {
      wait(var_0._id_2A39);
    }
  }

  if(isDefined(var_0)) {
    var_0 delete();
  }
}

_id_2AA7() {
  _id_2AA9(1);
}

_id_2AA8() {
  _id_2AA9(0);
}

_id_2AA9(var_0) {
  if(var_0 <= 0) {
    self._id_29C1 = 0;
  } else {
    self._id_29C1 = 1;
  }
}

_id_2AAA() {
  if(isDefined(level._id_2AAB)) {
    thread[[level._id_2AAB]]();
    return;
  }

  var_0 = self.model;

  if(!isDefined(level._id_2A5B[var_0])) {
    return;
  }
  self endon("death");

  for(;;) {
    self waittill("weapon_fired");
    playFXOnTag(level._id_2A5B[var_0], self, "tag_engine_exhaust");
    var_1 = self gettagorigin("tag_flash");
    var_2 = physicstrace(var_1, var_1 + (0, 0, -128));
    physicsexplosionsphere(var_2, 192, 100, 1);
  }
}

_id_2AAC() {
  self endon("death");
  var_0 = self.model;

  if(!isDefined(level._id_2A5A[var_0])) {
    return;
  }
  var_1 = 0.1;

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    if(!isalive(self)) {
      return;
    }
    playFXOnTag(level._id_2A5A[var_0], get_dummy(), "tag_engine_exhaust");
    wait(var_1);
  }
}

_id_2AAD(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level._id_2AAE)) {
    level._id_2AAE = [];

  }
  if(!isDefined(level._id_2AAF)) {
    level._id_2AAF = [];

  }
  if(isDefined(level._id_2AAF[var_4]) && !level._id_2A00) {
    return;
  }
  var_6 = spawnStruct();
  var_6.name = var_1;
  var_6.tag = var_2;
  var_6.delay = var_5;
  var_6._id_164E = common_scripts\utility::_loadfx(var_3);
  level._id_2AAE[var_0][var_1] = var_6;
  _id_2AB1(var_0, var_1, "all");

  if(isDefined(var_4)) {
    _id_2AB1(var_0, var_1, var_4);
  }
}

_id_2AB0(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.script)) {
    level.script = tolower(getdvar("mapname"));

  }
  level._id_29F4 = var_0;
  _id_2AAD(var_0, var_1, var_2, var_3, var_4, var_5);
  level._id_2A00 = 0;
  level._id_2AAF[var_4] = 1;
}

_id_2AB1(var_0, var_1, var_2) {
  if(!isDefined(level._id_2AB2)) {
    level._id_2AB2 = [];

  }
  if(!isDefined(level._id_2AB2[var_0])) {
    level._id_2AB2[var_0] = [];

  }
  if(!isDefined(level._id_2AB2[var_0][var_2])) {
    level._id_2AB2[var_0][var_2] = [];

  }
  foreach(var_4 in level._id_2AB2[var_0][var_2]) {
    if(var_1 == var_4) {
      return;
    }
  }

  level._id_2AB2[var_0][var_2][level._id_2AB2[var_0][var_2].size] = var_1;
}

_id_2AB3(var_0, var_1) {
  var_2 = strtok(var_0, " ");
  common_scripts\utility::array_levelthread(var_2, ::_id_2AB6, var_1);
}

_id_2AB4() {
  level notify("new_lights_delayfxforframe");
  level endon("new_lights_delayfxforframe");

  if(!isDefined(level._id_2AB5)) {
    level._id_2AB5 = 0;

  }
  level._id_2AB5 = level._id_2AB5 + randomfloatrange(0.2, 0.4);

  if(level._id_2AB5 > 2) {
    level._id_2AB5 = 0;

  }
  wait 0.05;
  level._id_2AB5 = undefined;
}

_id_2AB6(var_0, var_1) {
  level._id_2AB7 = gettime();

  if(!isDefined(var_0)) {
    var_0 = "all";

  }
  if(!isDefined(var_1)) {
    var_1 = self.classname;

    if(maps\_utility::_id_1E25() && level.script != "contingency" && level.script != "invasion") {
      var_1 = self.model;
    }
  }

  if(!isDefined(level._id_2AB2)) {
    return;
  }
  if(!isDefined(level._id_2AB2[var_1]) || !isDefined(level._id_2AB2[var_1][var_0])) {
    return;
  }
  thread _id_2AB4();

  if(!isDefined(self._id_2AB8)) {
    self._id_2AB8 = [];

  }
  var_2 = level._id_2AB2[var_1][var_0];
  var_3 = 0;
  var_4 = [];

  for(var_5 = 0; var_5 < var_2.size; var_5++) {
    if(isDefined(self._id_2AB8[var_2[var_5]])) {
      continue;
    }
    var_6 = level._id_2AAE[var_1][var_2[var_5]];

    if(isDefined(var_6.delay)) {
      var_7 = var_6.delay;
    } else {
      var_7 = 0;

    }
    for(var_7 = var_7 + level._id_2AB5; isDefined(var_4["" + var_7]); var_7 = var_7 + 0.05) {}

    var_4["" + var_7] = 1;
    self endon("death");
    childthread common_scripts\utility::noself_delaycall_proc(::playfxontag, var_7, var_6._id_164E, self, var_6.tag);
    self._id_2AB8[var_2[var_5]] = 1;

    if(!isDefined(self)) {
      break;
    }
  }

  level._id_2AB5 = 0;
}

_id_2AB9() {
  if(!isDefined(self._id_2AB9)) {
    var_0 = spawn("script_model", (0, 0, 0));
    var_1 = get_dummy();
    var_0 setModel(self.model);
    var_0.origin = var_1.origin;
    var_0.angles = var_1.angles;
    var_0 notsolid();
    var_0 hide();
    var_0 linkto(var_1);
    self._id_2AB9 = var_0;
  } else {
    self._id_2AB9 setModel(self.model);

  }
  return self._id_2AB9;
}

_id_2ABA(var_0, var_1, var_2) {
  var_3 = strtok(var_0, " ", var_1);
  common_scripts\utility::array_levelthread(var_3, ::_id_2ABB, var_1, var_2);
}

_id_2ABB(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_1 = var_2;
  } else if(!isDefined(var_1)) {
    if(maps\_utility::_id_1E25()) {
      var_1 = self.model;
    } else {
      var_1 = self.classname;
    }
  }

  if(!isDefined(var_0)) {
    var_0 = "all";

  }
  if(!isDefined(self._id_2AB8)) {
    return;
  }
  if(!isDefined(level._id_2AB2[var_1][var_0])) {
    return;
  }
  var_3 = level._id_2AB2[var_1][var_0];
  var_4 = 0;
  var_5 = 2;

  if(isDefined(self._id_2ABC)) {
    var_5 = self._id_2ABC;

  }
  for(var_6 = 0; var_6 < var_3.size; var_6++) {
    var_7 = level._id_2AAE[var_1][var_3[var_6]];
    stopFXOnTag(var_7._id_164E, self, var_7.tag);
    var_4++;

    if(var_4 >= var_5) {
      var_4 = 0;
      wait 0.05;
    }

    if(!isDefined(self)) {
      return;
    }
    self._id_2AB8[var_3[var_6]] = undefined;
  }
}

_id_2ABD(var_0, var_1) {
  if(!isDefined(level._id_297D)) {
    level._id_297D = [];

  }
  level._id_297D[var_0] = var_1;
}

_id_2ABE(var_0, var_1, var_2, var_3) {
  if(var_0 != level._id_29FF) {
    return;
  }
  if(!isDefined(var_1)) {
    var_1 = var_0;

  }
  precachemodel(var_0);
  precachemodel(var_1);

  if(!isDefined(var_2)) {
    var_2 = 0;

  }
  if(!isDefined(var_3) || maps\_utility::_id_1E25()) {
    level._id_2996[var_0] = var_1;
    level._id_2997[var_0] = var_2;
  } else {
    level._id_2996[var_3] = var_1;
    level._id_2997[var_3] = var_2;
  }
}

_id_2ABF(var_0) {
  precacheshader("black");
  precacheshellshock(var_0);
  level._id_2A5C[level._id_29F4] = var_0;
}

_id_2AC0(var_0) {
  if(!isDefined(level._id_2A19)) {
    level._id_2A19 = [];

  }
  if(!isDefined(level._id_2A19[level._id_29FF])) {
    level._id_2A19[level._id_29FF] = [];

  }
  level._id_2A19[level._id_29FF][level._id_2A19[level._id_29FF].size] = var_0;
}

_id_2AC1(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 10;

  }
  level._id_29C9[level._id_29FF] = var_0;

  if(isDefined(var_1)) {
    level._id_29CA[level._id_29FF] = var_1;

  }
  level._id_2A1B[level._id_29FF] = var_2;

  if(isDefined(var_3)) {
    level._id_2A1C[level._id_29FF] = var_3;
  }
}

_id_2AC2(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.script)) {
    level.script = tolower(getdvar("mapname"));

  }
  if(isDefined(var_2)) {
    var_0 = var_2;

  }
  if(maps\_utility::_id_1E25()) {
    var_3 = var_0 + var_1;
  } else {}

  precachevehicle(var_0);

  if(!isDefined(level._id_29CE)) {
    level._id_29CE = [];

  }
  if(!isDefined(level._id_29CE[var_3])) {
    level._id_29CE[var_3] = [];

  }
  level._id_2A52[var_3] = "axis";
  level._id_2A2F[var_3] = 999;
  level._id_29D2[var_1] = 0;
  level._id_2AC3[var_1] = [];
  level._id_29FF = var_1;
  level._id_29F9 = var_0;
  level._id_29F4 = var_3;
}

_id_2AC4(var_0) {
  level._id_2A5A[level._id_29FF] = common_scripts\utility::_loadfx(var_0);
}

_id_2AC5() {
  var_0 = level._id_29F4;

  if(maps\_utility::_id_1E25()) {
    var_0 = level._id_29F9;

  }
  maps\_treadfx::main(var_0);
}

_id_2AC6(var_0) {
  if(maps\_utility::_id_1E25()) {
    level._id_2A52[level._id_29F9] = var_0;
  } else {
    level._id_2A52[level._id_29F4] = var_0;
  }
}

_id_2AC7(var_0, var_1, var_2, var_3) {
  level._id_29D2[level._id_29FF] = 1;

  if(isDefined(var_0)) {
    level._id_2AC3[level._id_29FF][var_0] = 1;

  }
  if(isDefined(var_1)) {
    level._id_2AC3[level._id_29FF][var_1] = 1;

  }
  if(isDefined(var_2)) {
    level._id_2AC3[level._id_29FF][var_2] = 1;

  }
  if(isDefined(var_3)) {
    level._id_2AC3[level._id_29FF][var_3] = 1;
  }
}

_id_2AC8(var_0) {
  if(maps\_utility::_id_1E25()) {
    level._id_2A60[level._id_29F9] = var_0;
  } else {
    level._id_2A60[level._id_29F4] = var_0;
  }
}

_id_2AC9(var_0) {
  if(maps\_utility::_id_1E25()) {
    level._id_2A5F[level._id_29F9] = var_0;
  } else {
    level._id_2A5F[level._id_29F4] = var_0;
  }
}

_id_2ACA(var_0, var_1) {
  var_2 = level._id_29F4;

  if(maps\_utility::_id_1E25()) {
    var_2 = level._id_29F9;

  }
  level._id_24E6[var_2] = [[var_0]]();

  if(isDefined(var_1)) {
    level._id_24E6[var_2] = [[var_1]](level._id_24E6[var_2]);
  }
}

_id_2ACB(var_0) {
  if(maps\_utility::_id_1E25()) {
    level._id_2A5D[level._id_29F9] = var_0;
  } else {
    level._id_2A5D[level._id_29F4] = var_0;
  }
}

_id_2ACC(var_0) {
  if(maps\_utility::_id_1E25()) {
    level._id_256B[level._id_29F9] = [[var_0]]();
  } else {
    level._id_256B[level._id_29F4] = [[var_0]]();
  }
}

_id_2ACD(var_0) {
  if(maps\_utility::_id_1E25()) {
    level._id_2566[level._id_29F9] = [[var_0]]();
  } else {
    level._id_2566[level._id_29F4] = [[var_0]]();
  }
}

_id_2ACE(var_0, var_1, var_2) {
  var_3 = level._id_29F4;

  if(maps\_utility::_id_1E25()) {
    var_3 = level._id_29F9;

  }
  level._id_2A2F[var_3] = var_0;
  level._id_2A30[var_3] = var_1;
  level._id_2A31[var_3] = var_2;
}

_id_2ACF(var_0) {
  level._id_2A5B[level._id_29FF] = common_scripts\utility::_loadfx(var_0);
}

_id_2AD0(var_0, var_1) {
  if(isDefined(level._id_2AD1)) {
    return;
  }
  if(var_0 != level._id_29FF) {
    return;
  }
  var_2 = spawnStruct();
  var_2.model = var_0;
  var_2 maps\_utility::_id_1446(var_1);
  level._id_2A32[level._id_29FF] = var_1;
}

_id_2AD2(var_0) {
  if(maps\_utility::_id_1E25()) {
    level._id_297F[level._id_29F9][level._id_29FF] = var_0;
  } else {
    level._id_297F[level._id_29F9][level._id_29F4] = var_0;
  }
}

_id_2AD3(var_0) {
  return common_scripts\utility::getstruct(var_0, "targetname");
}

_id_2AD4(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  if(isDefined(var_1) && var_1.size > 0) {
    return var_1[randomint(var_1.size)];

  }
  return undefined;
}

_id_2AD5(var_0) {
  return common_scripts\utility::getstruct(var_0, "target");
}

_id_2AD6(var_0) {
  return getent(var_0, "target");
}

_id_2AD7(var_0) {
  return getvehiclenode(var_0, "targetname");
}

_id_2AD8(var_0) {
  var_1 = getent(var_0.script_linkto, "script_linkname");

  if(!isDefined(var_1) || level.script == "hunted") {
    return;
  }
  self setlookatent(var_1);
  self._id_294C = 1;
}

_id_2AD9(var_0) {
  var_1 = [];
  var_2 = getEntArray("script_vehicle", "code_classname");

  foreach(var_4 in var_2) {
    if(!isDefined(var_4._id_290C) || var_4._id_290C != var_0) {
      continue;
    }
    var_1[var_1.size] = var_4;
  }

  return var_1;
}

_id_2ADA() {
  level._id_2ADB = 0;
  self._id_2ADC = 0;
  thread _id_2ADE();

  while(isDefined(self)) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(!isplayer(var_1)) {
      continue;
    }
    if(isDefined(self._id_1C05)) {
      continue;
    }
    var_4 = tolower(var_4);

    switch (var_4) {
      case "mod_rifle_bullet":
      case "mod_pistol_bullet":
      case "bullet":
        if(!level._id_2ADB) {
          if(isDefined(level._id_1C03) && level._id_1C03 > 0) {
            break;
          }

          level._id_2ADB = 1;
          self._id_2ADC = 1;
          var_1 maps\_utility::_id_1F61("invulerable_bullets");
          wait 4;
          level._id_2ADB = 0;

          if(isDefined(self)) {
            self._id_2ADC = 0;

          }
          break;
        }
    }
  }
}

_id_2ADD() {
  level._id_2ADB = 0;
  self._id_2ADC = 0;
  thread _id_2ADE();

  while(isDefined(self)) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);

    if(!isplayer(var_1)) {
      continue;
    }
    if(isDefined(self._id_1C05)) {
      continue;
    }
    var_4 = tolower(var_4);

    switch (var_4) {
      case "mod_rifle_bullet":
      case "mod_pistol_bullet":
      case "bullet":
      case "mod_grenade_splash":
      case "mod_grenade":
        if(!level._id_2ADB) {
          if(isDefined(level._id_1C03) && level._id_1C03 > 0) {
            break;
          }

          level._id_2ADB = 1;
          self._id_2ADC = 1;

          if(var_4 == "mod_grenade" || var_4 == "mod_grenade_splash") {
            var_1 maps\_utility::_id_1F61("invulerable_frags");
          } else {
            var_1 maps\_utility::_id_1F61("invulerable_bullets");

          }
          wait 4;
          level._id_2ADB = 0;

          if(isDefined(self)) {
            self._id_2ADC = 0;

          }
          break;
        }
    }
  }
}

_id_2ADE() {
  self waittill("death");

  if(self._id_2ADC) {
    level._id_2ADB = 0;
  }
}

_id_2ADF(var_0) {
  var_1 = self getattachsize();
  var_2 = [];

  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_2[var_3] = tolower(self getattachmodelname(var_3));

  }
  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_0 attach(var_2[var_3], tolower(self getattachtagname(var_3)));
  }
}

get_dummy() {
  if(self.modeldummyon) {
    var_0 = self.modeldummy;
  } else {
    var_0 = self;

  }
  return var_0;
}

_id_2AE0() {
  return self.modeldummyon;
}

_id_2AE1() {
  if(!isDefined(self._id_2974)) {
    return;
  }
  var_0 = self._id_2974;
  self._id_2974 = [];

  foreach(var_2 in var_0) {
    if(isDefined(var_2.spawner)) {
      var_3 = common_scripts\utility::spawn_tag_origin();
      var_3.spawner = var_2.spawner;
    } else {
      var_3 = spawn("script_model", self.origin);
      var_3 setModel(var_2.model);
    }

    var_4 = "tag_body";

    if(isDefined(var_2._id_2A92)) {
      var_3._id_2A92 = var_2._id_2A92;
      var_3._id_2A94 = var_2.origin;
      var_3._id_2A93 = var_2.angles;
      var_4 = var_2._id_2A92;
    }

    if(isDefined(var_2._id_2AE2)) {
      var_2 thread _id_2AE3(var_3);

    }
    if(isDefined(var_2.script_noteworthy)) {
      var_3.script_noteworthy = var_2.script_noteworthy;

    }
    if(isDefined(var_2._id_164F)) {
      var_3._id_164F = var_2._id_164F;

    }
    var_3 linkto(self, var_4, var_2.origin, var_2.angles);

    if(isDefined(var_2.destructible_type)) {
      var_3.destructible_type = var_2.destructible_type;
      var_3 common_scripts\_destructible::setup_destructibles(1);
    }

    self._id_2974[self._id_2974.size] = var_3;
  }
}

_id_2AE3(var_0) {
  var_0 endon("death");
  var_0 setCanDamage(1);
  var_0.health = 8000;
  var_0 waittill("damage");
  var_0 hide();
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1 linkto(var_0);
  playFXOnTag(self._id_2AE2, var_1, "tag_origin");
}

_id_2974() {
  var_0 = getent(self.target, "targetname");
  var_1 = _id_2AE4(var_0);

  if(isspawner(self)) {
    var_1.spawner = self;

  }
  if(isDefined(self.targetname)) {
    var_2 = getent(self.targetname, "target");

    if(isspawner(var_2)) {
      var_1.spawner = var_2;
    }
  }

  if(isDefined(self.script_noteworthy)) {
    var_1.script_noteworthy = self.script_noteworthy;

  }
  if(isDefined(self._id_164F)) {
    var_1._id_164F = self._id_164F;

  }
  if(isDefined(self.script_fxid)) {
    var_1._id_2AE2 = common_scripts\utility::getfx(self.script_fxid);

  }
  if(!isDefined(var_0._id_2974)) {
    var_0._id_2974 = [];

  }
  if(isDefined(self._id_251B)) {
    var_1._id_251B = self._id_251B;

  }
  if(isDefined(self.destructible_type)) {
    maps\_utility::_id_1446(self.destructible_type);
    var_1.destructible_type = self.destructible_type;
  }

  var_0._id_2974[var_0._id_2974.size] = var_1;

  if(!isDefined(self.classname)) {
    return;
  }
  if(isspawner(self)) {
    return;
  }
  self delete();
}

_id_2AE4(var_0) {
  var_1 = spawnStruct();
  var_2 = "tag_body";

  if(isDefined(self._id_2A92)) {
    var_2 = self._id_2A92;
    var_1._id_2A92 = self._id_2A92;
  }

  var_1.origin = self.origin - var_0 gettagorigin(var_2);

  if(!isDefined(self.angles)) {
    var_3 = (0, 0, 0);
  } else {
    var_3 = self.angles;

  }
  var_1.angles = var_3 - var_0 gettagangles(var_2);
  var_1.model = self.model;

  if(isDefined(self.script_modelname)) {
    precachemodel(self.script_modelname);
    var_1.model = self.script_modelname;
  }

  if(isDefined(var_1.targetname)) {
    level.struct_class_names["targetname"][var_1.targetname] = undefined;

  }
  if(isDefined(var_1.target)) {
    level.struct_class_names["target"][var_1.target] = undefined;

  }
  return var_1;
}

_id_2AE5(var_0, var_1) {
  return level.player buttonpressed(var_0) && level.player buttonpressed(var_1);
}

_id_2515(var_0, var_1, var_2) {
  maps\_vehicle_aianim::_id_2507(var_0, undefined, var_2);
}

_id_2AE6(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  maps\_vehicle_aianim::_id_2507(var_3, var_1, var_2);
}

_id_2AE7(var_0) {
  if(!isDefined(level._id_2A62[var_0])) {
    return;
  }
  var_1 = level._id_2A62[var_0];

  if(isDefined(var_1.delay)) {
    wait(var_1.delay);

  }
  if(!isDefined(self)) {
    return;
  }
  badplace_cylinder("vehicle_kill_badplace", var_1.duration, self.origin, var_1.radius, var_1.height, var_1._id_2AE9, var_1._id_2AE8);
}

_id_2AEA(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level._id_2A62)) {
    level._id_2A62 = [];

  }
  var_6 = spawnStruct();
  var_6.delay = var_0;
  var_6.duration = var_1;
  var_6.height = var_2;
  var_6.radius = var_3;
  var_6._id_2AE9 = var_4;
  var_6._id_2AE8 = var_5;

  if(maps\_utility::_id_1E25()) {
    level._id_2A62[level._id_29F9] = var_6;
  } else {
    level._id_2A62[level._id_29F4] = var_6;
  }
}

_id_2AEB(var_0) {
  if(!isDefined(level._id_2A61)) {
    level._id_2A61 = [];

  }
  var_1 = spawnStruct();
  var_1.delay = var_0;

  if(maps\_utility::_id_1E25()) {
    level._id_2A61[level._id_29F9] = var_1;
  } else {
    level._id_2A61[level._id_29F4] = var_1;
  }
}

_id_2AEC(var_0) {
  if(isDefined(level._id_2A61[var_0])) {
    self._id_299B = 1;
    wait(level._id_2A61[var_0].delay);
  }

  if(!isDefined(self)) {
    return;
  }
  self joltbody(self.origin + (23, 33, 64), 3);
  wait 2;

  if(!isDefined(self)) {
    return;
  }
  self._id_299B = undefined;
}

_id_2AED(var_0) {
  self endon("death");
  level endon(var_0);

  for(;;) {
    self waittill("trigger", var_1);

    if(isalive(var_1)) {
      if(var_1.team == "allies" && !isplayer(var_1)) {
        continue;
      }
      var_1 kill((0, 0, 0));
    }
  }
}

_id_2AEE(var_0) {
  var_1 = _id_26A4();
  var_2 = [];

  foreach(var_4 in var_1) {
    if(isDefined(var_4._id_28FF) && var_4._id_28FF == var_0) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_26A4(var_0) {
  var_1 = getEntArray("script_vehicle", "code_classname");

  if(isDefined(var_0)) {
    var_2 = [];

    foreach(var_4 in var_1) {
      if(!isDefined(var_4.targetname)) {
        continue;
      }
      if(var_4.targetname == var_0) {
        var_2 = maps\_utility::_id_0BC3(var_2, var_4);
      }
    }

    var_1 = var_2;
  }

  var_6 = [];

  foreach(var_4 in var_1) {
    if(isspawner(var_4)) {
      var_6[var_6.size] = var_4;
    }
  }

  return var_6;
}

_id_2AEF() {
  if(!isDefined(self._id_164F)) {
    return;
  }
  if(self._id_164F == "gag_ride_in") {
    _id_2AF0();
  }
}

_id_2AF0() {
  var_0 = getEntArray(self.targetname, "target");
  self._id_250B = _id_2AF2();

  foreach(var_2 in var_0) {
    var_2._id_259D = 0;
    level._id_2926 = _id_2A24(level._id_2926, self._id_250B, var_2);
  }

  level._id_2AF1 = self;
}

_id_2AF2() {
  if(!isDefined(level._id_2AF3)) {
    level._id_2AF3 = 1000;
  } else {
    level._id_2AF3++;

  }
  return level._id_2AF3;
}

_id_2AF4(var_0) {
  foreach(var_2 in self._id_0A39) {
    if(isai(var_2)) {
      var_2 maps\_utility::_id_13A4(var_0);
      continue;
    }

    if(isDefined(var_2.spawner)) {
      var_2.spawner._id_134B = var_0;
      continue;
    }
  }
}

_id_2AF5(var_0, var_1) {
  var_2 = _id_292B(level._id_2926[var_0]);
  var_3 = [];

  for(var_4 = 0; var_4 < var_1; var_4++) {
    var_3[var_3.size] = var_2[var_4];

  }
  level._id_2926[var_0] = var_3;
}

_id_0EF8(var_0) {
  if(var_0._id_2AF6 != gettime()) {
    var_0._id_2AF6 = gettime();

    if(var_0._id_0EF7) {
      var_1 = clamp(0 - var_0.angles[2], 0 - var_0._id_2AF7, var_0._id_2AF7) / var_0._id_2AF7;

      if(isDefined(var_0._id_2AF8) && var_0._id_2AF8) {
        var_2 = var_0 vehicle_getsteering();
        var_2 = var_2 * -1.0;
        var_1 = var_1 + var_2;

        if(var_1 != 0) {
          var_3 = 1.0 / abs(var_1);

          if(var_3 < 1) {
            var_1 = var_1 * var_3;
          }
        }
      }

      var_4 = var_1 - var_0._id_24F6;

      if(var_4 != 0) {
        var_5 = var_0._id_2AF9 / abs(var_4);

        if(var_5 < 1) {
          var_4 = var_4 * var_5;

        }
        var_0._id_24F6 = var_0._id_24F6 + var_4;
      }
    } else {
      var_0._id_24F6 = 0;
    }
  }

  return var_0._id_24F6;
}

_id_1FA9(var_0, var_1) {
  self endon("death");
  self endon("long_death");

  if(maps\_utility::_id_0D69()) {
    return;
  }
  var_2 = [];
  var_2[0] = "snowmobile_driver";
  var_2[1] = "snowmobile_passenger";
  var_3 = [];
  var_3["snowmobile_driver"] = "tag_driver";
  var_3["snowmobile_passenger"] = "tag_passenger";
  var_4 = var_2[var_1];
  var_5 = var_3[var_4];
  var_6 = var_0 gettagorigin(var_5);
  var_7 = var_0 gettagangles(var_5);
  var_8 = undefined;
  var_9 = undefined;
  var_10 = 9999999;

  foreach(var_16, var_12 in level._id_2AFA[var_4]) {
    var_13 = maps\_utility::_id_26EC(var_16);
    var_14 = getstartorigin(var_6, var_7, var_13);
    var_15 = distance(self.origin, var_14);

    if(var_15 < var_10) {
      var_10 = var_15;
      var_9 = var_14;
      var_8 = var_16;
    }
  }

  var_9 = maps\_utility::_id_2281(var_9);
  self.goalradius = 8;
  self._id_117F = 1;
  self setgoalpos(var_9);
  self waittill("goal");
  var_0 maps\_anim::_id_11C1(self, var_8, var_5);
  var_0 thread maps\_vehicle_aianim::_id_24E5(self);
  self._id_117F = 0;
}

_id_2AFB(var_0) {
  var_0 = (var_0[0], var_0[1], 0);
  var_1 = maps\_utility::_id_0AEC(var_0, level._id_2AFC);
  var_2 = [];

  for(var_3 = 0; var_3 < 3; var_3++) {
    var_2[var_3] = var_1[var_3];

  }
  for(var_3 = 0; var_3 < level._id_2AFC.size; var_3++) {
    foreach(var_5 in var_2) {
      if(var_5 == level._id_2AFC[var_3]) {
        return var_5;
      }
    }
  }
}

_id_1F9C(var_0) {
  if(level._id_2AFD.size >= 8) {
    return;
  }
  var_1 = maps\_utility::_id_1FA3();

  if(isDefined(var_0)) {
    var_1 phys_setspeed(var_0);

  }
  var_1 thread _id_1FA5();
  var_1 endon("death");
  var_1._id_2955 = 1;
  var_1 _id_1FA6(var_1);
  var_1 _id_1FA7();
}

_id_1FA7() {
  self endon("script_crash_vehicle");
  common_scripts\utility::waittill_either("enable_spline_path", "reached_end_node");
  var_0 = _id_2AFB(self.origin);
  var_0 thread[[level._id_2A50]](self);
}

_id_1EB5(var_0) {
  var_0 waittill("trigger");

  foreach(var_2 in level._id_2902[var_0._id_1EB4]) {}
  var_2 delete();

  level._id_2902[var_0._id_1EB4] = [];
}

_id_1F9E() {
  var_0 = maps\_utility::_id_1FA3();

  if(isDefined(self._id_2AFE)) {
    if(!_id_21ED()) {
      var_0 phys_setspeed(self._id_2AFE);
    }
  }

  var_0 thread _id_1FA6(var_0);
  return var_0;
}

_id_2AFF() {
  var_0 = getEntArray("vehicle_touch_trigger", "targetname");
  var_1 = getEntArray("vehicle_use_trigger", "targetname");
  var_0 = common_scripts\utility::array_combine(var_0, var_1);
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(var_4.script_noteworthy == self.model) {
      var_2 = var_4.origin;
      break;
    }
  }

  var_6 = [];

  foreach(var_4 in var_0) {
    if(var_4.script_noteworthy != self.model) {
      continue;
    }
    if(var_4.origin != var_2) {
      continue;
    }
    var_6[var_6.size] = var_4;
  }

  self._id_2B00 = [];

  foreach(var_4 in var_6) {
    var_4.targetname = undefined;
    var_4 thread _id_2B03(self, "tag_origin");

    if(!isDefined(self._id_2B00[var_4.code_classname])) {
      self._id_2B00[var_4.code_classname] = [];

    }
    self._id_2B00[var_4.code_classname][self._id_2B00[var_4.code_classname].size] = var_4;
  }
}

_id_2B01(var_0) {
  self useanimtree(#animtree);
  _id_2B02(var_0);

  if(!isDefined(self)) {
    return;
  }
  self clearanim(var_0["idle"], 0);
  self clearanim(var_0["rot_l"], 0);
  self clearanim(var_0["rot_r"], 0);
}

_id_2B02(var_0) {
  self endon("death");

  for(;;) {
    var_1 = self.veh_speed / 18;

    if(var_1 <= 0.0001) {
      var_1 = 0.0001;

    }
    var_2 = randomfloatrange(0.3, 0.7);
    self setanim(var_0["idle"], var_1, 0, var_2);
    var_2 = randomfloatrange(0.1, 0.8);
    self setanim(var_0["rot_l"], 1, 0, var_2);
    var_2 = randomfloatrange(0.1, 0.8);
    self setanim(var_0["rot_r"], 1, 0, var_2);
    wait 0.5;
  }
}

_id_2B03(var_0, var_1) {
  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(!isDefined(var_0)) {
      break;
    }

    var_2 = var_0 gettagorigin(var_1);
    var_3 = var_0 gettagangles(var_1);
    self.origin = var_2;
    self.angles = var_3;
    wait 0.05;
  }
}

_id_2B04(var_0) {
  var_0 setdeceleration(6);
  var_0 setacceleration(4);
  var_0 settargetyaw(self.angles[1]);
  var_0 vehicle_setspeed(20, 7, 7);

  while(distance(common_scripts\utility::flat_origin(var_0.origin), common_scripts\utility::flat_origin(self.origin)) > 512) {
    wait 0.05;

  }
  var_0 endon("death");
  var_1 = "landing" + randomint(99999);
  badplace_cylinder(var_1, 30, self.origin, 200, 300, "axis", "allies", "neutral", "team3");
  var_0 thread _id_2B08(424, self);
  var_0 waittill("near_goal");
  badplace_delete(var_1);
  badplace_cylinder(var_1, 30, self.origin, 200, 300, "axis", "allies", "neutral", "team3");
  var_0 notify("groupedanimevent", "pre_unload");
  var_0 thread _id_25AB("pre_unload");
  var_0 vehicle_setspeed(20, 22, 7);
  var_0 notify("nearing_landing");

  if(isDefined(var_0._id_2B05)) {
    switch (var_0._id_2B05) {
      case "hover_then_land":
        var_0 vehicle_setspeed(10, 22, 7);
        var_0 thread _id_2B08(32, self, 64);
        var_0 waittill("near_goal");
        var_0 notify("hovering");
        wait 1;
        break;
      default:
        break;
    }
  }

  var_0 thread _id_2B08(16, self);
  var_0 waittill("near_goal");
  badplace_delete(var_1);
  maps\_utility::script_delay();
  var_0 _id_2514();
  var_0 _id_2A88();
  var_0 vehicle_setspeed(20, 8, 7);
  wait 0.2;
  var_0 notify("stable_for_unlink");
  wait 0.2;

  if(isDefined(self._id_2057)) {
    common_scripts\utility::flag_set(self._id_2057);

  }
  if(isDefined(self._id_1288)) {
    common_scripts\utility::flag_wait(self._id_1288);

  }
  var_0 notify("littlebird_liftoff");
}

_id_2B06() {
  for(;;) {
    self waittill("trigger", var_0);
    _id_2B04(var_0);
  }
}

_id_2B07() {
  for(;;) {
    self waittill("trigger", var_0);
    var_0 setdeceleration(6);
    var_0 setacceleration(4);
    var_0 settargetyaw(self.angles[1]);
    var_0 vehicle_setspeed(20, 7, 7);

    while(distance(common_scripts\utility::flat_origin(var_0.origin), common_scripts\utility::flat_origin(self.origin)) > 256) {
      wait 0.05;

    }
    var_0 endon("death");
    var_0 thread _id_2B08(220, self);
    var_0 waittill("near_goal");
    var_0 vehicle_setspeed(20, 22, 7);
    var_0 thread _id_2B08(16, self);
    var_0 waittill("near_goal");
    var_0 _id_2A88();
    var_0 notify("touch_down", self);
    var_0 vehicle_setspeed(20, 8, 7);
  }
}

_id_2B08(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 0;

  }
  self notify("newpath");

  if(!isDefined(var_0)) {
    var_0 = 2;

  }
  self setneargoalnotifydist(var_0);
  self sethoverparams(0, 0, 0);
  self cleargoalyaw();
  self settargetyaw(common_scripts\utility::flat_angle(var_1.angles)[1]);
  _id_2848(maps\_utility::_id_1277(var_1.origin) + (0, 0, var_2), 1);
  self waittill("goal");
}

_id_269D(var_0, var_1) {
  self notify("newpath");

  if(!isDefined(var_0)) {
    var_0 = 2;

  }
  self setneargoalnotifydist(var_0);
  self sethoverparams(0, 0, 0);
  self cleargoalyaw();
  self settargetyaw(common_scripts\utility::flat_angle(self.angles)[1]);
  _id_2848(maps\_utility::_id_1277(self.origin), 1);
  self waittill("goal");
}

_id_2B09(var_0) {
  var_1 = [];
  var_2 = self.classname;

  if(maps\_utility::_id_1E25()) {
    var_2 = self.vehicletype;

  }
  if(!isDefined(level._id_2566[var_2])) {
    return var_1;

  }
  var_3 = level._id_2566[var_2];

  if(!isDefined(var_0)) {
    return var_1;

  }
  foreach(var_5 in self._id_0A39) {
    foreach(var_7 in var_3[var_0]) {
      if(var_5._id_2252 == var_7) {
        var_1[var_1.size] = var_5;
      }
    }
  }

  return var_1;
}

_id_25AB(var_0) {
  return maps\_vehicle_aianim::_id_25D6(var_0);
}

_id_2514(var_0) {
  self notify("unloading");
  var_1 = [];

  if(maps\_utility::_id_133C("no_riders_until_unload")) {
    maps\_utility::_id_13DC("no_riders_until_unload");
    var_1 = _id_292A(var_0);

    foreach(var_3 in var_1) {}
    maps\_utility::_id_13AF(var_3);
  }

  if(isDefined(var_0)) {
    self._id_2563 = var_0;

  }
  foreach(var_6 in self._id_0A39) {
    if(isalive(var_6)) {
      var_6 notify("unload");
    }
  }

  var_1 = _id_25AB("unload");

  if(maps\_utility::_id_1E25()) {
    var_8 = level._id_2566[self.vehicletype];
  } else {
    var_8 = level._id_2566[self.classname];

  }
  if(isDefined(var_8)) {
    var_1 = [];
    var_9 = maps\_vehicle_aianim::_id_2565();

    foreach(var_12, var_11 in self._id_0A39) {
      if(isDefined(var_9[var_11._id_2252])) {
        var_1[var_1.size] = var_11;
      }
    }
  }

  return var_1;
}

_id_2B0A(var_0, var_1) {
  var_2 = getnodearray(var_0.target, "targetname");
  var_3 = [];

  foreach(var_5 in var_2) {
    if(var_5.script_noteworthy == "stage_" + var_1) {
      var_3[var_3.size] = var_5;
    }
  }

  return var_3;
}

_id_2B0B(var_0, var_1, var_2) {
  if(!maps\_utility::_id_133C("staged_guy_" + var_2)) {
    maps\_utility::_id_1402("staged_guy_" + var_2);
  } else {
    maps\_utility::_id_13DE("staged_guy_" + var_2);

  }
  if(!maps\_utility::_id_133C("guy2_in_" + var_2)) {
    maps\_utility::_id_1402("guy2_in_" + var_2);
  } else {
    maps\_utility::_id_13DE("guy2_in_" + var_2);

  }
  var_3 = _id_2B0A(var_0, var_2);
  var_4 = common_scripts\utility::getstruct(var_0.target, "targetname");
  var_5 = spawn("script_model", (0, 0, 0));
  var_5 setModel(self.model);

  if(isDefined(self._id_2B0C)) {
    var_5.origin = self.origin;
  } else {
    var_5.origin = maps\_utility::_id_2281(var_4.origin) + (0, 0, self._id_295E);

  }
  var_5.angles = var_4.angles;
  var_5 hide();
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;

  foreach(var_10 in var_3) {
    var_11 = undefined;

    foreach(var_13 in var_1) {
      if(isDefined(var_13._id_251B) && var_13._id_251B == var_10._id_251B) {
        var_11 = var_13;
        break;
      }
    }

    if(!isDefined(var_11)) {
      var_11 = maps\_utility::_id_0AE9(var_10.origin, var_1);

    }
    var_11._id_251B = var_10._id_251B;

    if(var_11._id_251B == 2 || var_11._id_251B == 5) {
      var_6 = var_11;
      var_11 maps\_spawner::_id_21AB(var_10);
    } else if(var_11._id_251B == 3 || var_11._id_251B == 6) {
      var_8 = var_11;
    } else if(var_11._id_251B == 4 || var_11._id_251B == 7) {
      var_7 = var_11;
      var_11 maps\_spawner::_id_21AB(var_10);
    }

    var_1 = common_scripts\utility::array_remove(var_1, var_11);
  }

  thread _id_2B0E(var_8, var_2, var_7, var_5);
  thread common_scripts\utility::delete_on_death(var_5);
}

_id_2B0D(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;

  foreach(var_6 in var_1) {
    if(var_6._id_251B == 2 || var_6._id_251B == 5) {
      var_2 = var_6;
      continue;
    }

    if(var_6._id_251B == 3 || var_6._id_251B == 6) {
      var_4 = var_6;
      continue;
    }

    if(var_6._id_251B == 4 || var_6._id_251B == 7) {
      var_3 = var_6;
    }
  }

  maps\_utility::_id_1654("staged_guy_" + var_0);
  thread _id_2AE6(var_2, undefined, var_0);
  var_2 waittill("boarding_vehicle");
  thread _id_2AE6(var_3, undefined, var_0);
  var_3 waittill("boarding_vehicle");
  maps\_utility::_id_13DC("guy2_in_" + var_0);
}

_id_2B0E(var_0, var_1, var_2, var_3) {
  var_4 = "stage_littlebird_" + var_1;
  var_5 = [];
  var_5[0] = var_0;
  var_3 maps\_anim::_id_11C4(var_5[0], var_4, "tag_detach_" + var_1);
  var_3 maps\_anim::_id_11C1(var_5[0], var_4, "tag_detach_" + var_1);
  maps\_utility::_id_13DC("staged_guy_" + var_1);
  var_0 setgoalpos(maps\_utility::_id_2281(var_0.origin));
  var_0.goalradius = 16;
  maps\_utility::_id_1654("guy2_in_" + var_1);
  thread _id_2AE6(var_0, undefined, var_1);
}

_id_2B0F(var_0) {
  foreach(var_2 in var_0) {
    if(!isalive(var_2)) {
      continue;
    }
    if(!isDefined(var_2._id_0EF1) && !isDefined(var_2._id_0EEA)) {
      continue;
    }
    if(isDefined(var_2._id_0D04)) {
      var_2 maps\_utility::_id_1902();

    }
    var_2 kill();
  }
}

_id_2B10(var_0, var_1) {
  if(level.script == "af_chase") {
    if(isDefined(self._id_2252) && self._id_2252 != 0) {
      return;
    }
  }

  self.health = 1;
  var_0 endon("death");
  self._id_20AF = 0.15;
  self waittill("death");
  var_0 notify("driver_died");
  _id_2B0F(var_1);
}

_id_1FA5() {
  self endon("death");
  self endon("enable_spline_path");
  waittillframeend;
  self._id_0A39 = maps\_utility::_id_1228(self._id_0A39);

  if(self._id_0A39.size) {
    common_scripts\utility::array_thread(self._id_0A39, ::_id_2B10, self, self._id_0A39);
    common_scripts\utility::waittill_either("veh_collision", "driver_died");
    _id_2B0F(self._id_0A39);
    wait 0.25;
  }

  self notify("script_crash_vehicle");
  self phys_crash();
}

_id_2B11() {
  self endon("death");
  self endon("stop_scanning_turret");
  var_0 = randomint(2);

  while(isDefined(self)) {
    if(common_scripts\utility::cointoss()) {
      _id_2B13(0);
      wait(randomfloatrange(2, 10));
    }

    if(var_0 == 0) {
      var_1 = randomintrange(10, 30);
      var_0 = 1;
    } else {
      var_1 = randomintrange(-30, -10);
      var_0 = 0;
    }

    _id_2B13(var_1);
    wait(randomfloatrange(2, 10));
  }
}

_id_2B12() {
  self notify("stop_scanning_turret");
}

_id_2B13(var_0) {
  self endon("death");
  var_1 = anglesToForward(self.angles + (0, var_0, 0));
  var_1 = var_1 * 10000;
  var_1 = var_1 + (0, 0, 70);
  self setturrettargetvec(var_1);
}

_id_2B14() {
  self endon("death");
  var_0 = [];
  var_1 = self._id_291A;

  if(!isDefined(self._id_291A)) {
    return var_0;

  }
  var_2 = var_1;
  var_2._id_2B15 = 0;

  while(isDefined(var_2)) {
    if(isDefined(var_2._id_2B15) && var_2._id_2B15 == 1) {
      break;
    }

    var_0 = maps\_utility::_id_0BC3(var_0, var_2);
    var_2._id_2B15 = 1;

    if(!isDefined(var_2.target)) {
      break;
    }

    if(!_id_21ED()) {
      var_2 = getvehiclenode(var_2.target, "targetname");
      continue;
    }

    var_2 = maps\_utility::_id_27F1(var_2.target, "targetname");
  }

  return var_0;
}

_id_2B16(var_0) {
  _id_2ABB("all", var_0);
}

_id_2B17(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "all";

  }
  _id_2AB3(var_0, var_1);
}

_id_2B18(var_0, var_1) {
  _id_2ABA(var_0, var_1);
}

_id_2B19(var_0) {
  if(!maps\_utility::_id_1E25()) {}

  self setyawspeedbyname(var_0);

  if(var_0 == "faster") {
    self setmaxpitchroll(25, 50);
  }
}

_id_2B1A(var_0, var_1) {
  if(maps\_utility::_id_1E25() && !isDefined(var_1)) {
    return var_0;

  }
  return var_1;
}

_id_2B1B(var_0, var_1) {
  self setswitchnode(var_0, var_1);
  self._id_291A = var_1;
  thread _id_26A1();
}

_id_29C3(var_0, var_1, var_2) {
  if(!isDefined(self._id_29C3)) {
    self._id_29C3 = [];

  }
  self vehicle_setspeed(0, var_1, var_2);
  self._id_29C3[var_0] = var_1;
}

_id_2B1C(var_0) {
  var_1 = self._id_29C3[var_0];
  self._id_29C3[var_0] = undefined;

  if(self._id_29C3.size) {
    return;
  }
  self resumespeed(var_1);
}