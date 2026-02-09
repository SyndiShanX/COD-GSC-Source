/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\360.gsc
**************************************/

_id_24E5(var_0, var_1) {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.vehicletype)) {
    return;
  }
  var_2 = self.classname;

  if(maps\_utility::_id_1E25()) {
    var_2 = self.vehicletype;
  }
  var_3 = level._id_24E6[var_2];
  var_4 = level._id_24E6[var_2].size;
  self._id_24E7[self._id_24E7.size] = var_0;
  var_5 = _id_25B9(var_0, var_4);

  if(!isDefined(var_5)) {
    return;
  }
  if(var_5 == 0) {
    var_0._id_0EEA = 1;
  }
  var_6 = _id_2534(self, var_5);
  self._id_24E8[var_5] = 1;
  var_0._id_2252 = var_5;
  var_0._id_2251 = 0;

  if(isDefined(var_6.delay)) {
    var_0.delay = var_6.delay;

    if(isDefined(var_6._id_24E9)) {
      self._id_24EA = var_0.delay;
    }
  }

  if(isDefined(var_6._id_24E9)) {
    self._id_24EA = self._id_24EA + var_6._id_24E9;
    var_0.delay = self._id_24EA;
  }

  var_0._id_0EF1 = self;
  var_0._id_24EB = var_0.health;
  var_0._id_24EC = var_6._id_0F59;
  var_0._id_24EE = var_6._id_24ED;
  var_0._id_0D50 = var_6._id_1048;
  var_0._id_0EC1 = var_6._id_24EF;
  var_0._id_2253 = 0;
  var_0.allowdeath = 0;

  if(isDefined(var_0._id_0D50) && !isDefined(var_0._id_0D04) && _id_24FA()) {
    if(var_0._id_2252 != 0 || _id_24F8()) {
      var_0.allowdeath = !isDefined(var_0._id_24F0) || var_0._id_24F0;

      if(isDefined(var_6._id_24F1)) {
        var_0._id_0EC6 = var_6._id_24F1;
      }
    }
  }

  if(var_0.classname == "script_model") {
    if(isDefined(var_6._id_1048) && var_0.allowdeath && (!isDefined(var_0._id_24F0) || var_0._id_24F0)) {
      thread _id_2504(var_0, var_6);
    }
  }

  if(!isDefined(var_0._id_24EC)) {
    var_0.allowdeath = 1;
  }
  self._id_0A39[self._id_0A39.size] = var_0;

  if(var_0.classname != "script_model" && maps\_utility::_id_13AF(var_0)) {
    return;
  }
  var_7 = self gettagorigin(var_6._id_24F2);
  var_8 = self gettagangles(var_6._id_24F2);
  _id_2532(var_0, var_2, var_6._id_24F2, var_6._id_24F3);

  if(isai(var_0)) {
    var_0 teleport(var_7, var_8);
    var_0.a._id_0D31 = 1;

    if(isDefined(var_6._id_24F4) && !var_6._id_24F4) {
      var_0 maps\_utility::_id_24F5();
    }
    if(_id_24FC(var_6)) {
      thread _id_25BA(var_0, var_5, var_1);
    }
  } else {
    if(isDefined(var_6._id_24F4) && !var_6._id_24F4) {
      _id_25C8(var_0, "weapon_");
    }
    var_0.origin = var_7;
    var_0.angles = var_8;
  }

  if(var_5 == 0 && isDefined(var_3[0]._id_1048)) {
    thread _id_252A(var_0);
  }
  self notify("guy_entered", var_0, var_5);
  thread _id_2539(var_0, var_5);

  if(maps\_utility::_id_1E25() && var_2 == "snowmobile" || !maps\_utility::_id_1E25() && var_2 == "script_vehicle_snowmobile") {
    self._id_24F6 = 0;
    var_0._id_0CB3 = 1;
  } else {
    if(var_2 == "script_vehicle_atv") {
      self._id_24F6 = 0;
      var_0._id_0CB4 = 1;
      var_0._id_10A5["combat"] = animscripts\atv::main;
      var_0._id_10A5["stop"] = animscripts\atv::main;
      return;
    }

    if(isDefined(var_6._id_24F7)) {
      thread[[var_6._id_24F7]](var_0, var_5);
      return;
    }

    thread _id_2549(var_0, var_5);
  }
}

_id_24F8() {
  if(!isDefined(self._id_24F9)) {
    return 0;
  }
  return self._id_24F9;
}

_id_24FA() {
  if(!isDefined(self._id_24FB)) {
    return 1;
  }
  return self._id_24FB;
}

_id_24FC(var_0) {
  if(!isDefined(var_0.mgturret)) {
    return 0;
  }
  if(!isDefined(self._id_24FE)) {
    return 1;
  }
  return !self._id_24FE;
}

_id_24FF() {
  var_0 = self.classname;

  if(maps\_utility::_id_1E25()) {
    var_0 = self.vehicletype;
  }
  self._id_24E7 = [];

  if(!(isDefined(level._id_24E6) && isDefined(level._id_24E6[var_0]))) {
    return;
  }
  var_1 = level._id_24E6[var_0].size;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "ai_wait_go") {
    thread _id_25B8();
  }
  self._id_2500 = [];
  self._id_24E8 = [];
  self._id_2501 = [];
  self._id_24EA = 0;
  var_2 = level._id_24E6[var_0];

  for(var_3 = 0; var_3 < var_1; var_3++) {
    self._id_24E8[var_3] = 0;

    if(isDefined(self._id_24FE) && self._id_24FE && isDefined(var_2[var_3]._id_2502) && var_2[var_3]._id_2502) {
      self._id_24E8[1] = 1;
    }
  }
}

_id_2503(var_0) {
  _id_2507(var_0, 1);
}

_id_2504(var_0, var_1) {
  waittillframeend;
  var_0 setCanDamage(1);
  var_0 endon("death");
  var_0.allowdeath = 0;
  var_0._id_2189 = 100000;
  var_0.health = 100000;
  var_0 endon("jumping_out");

  if(isDefined(var_0._id_0D04) && var_0._id_0D04) {
    while(isDefined(var_0._id_0D04) && var_0._id_0D04) {
      wait 0.05;
    }
  }

  var_0 waittill("damage");
  thread _id_2505(var_0, var_1);
}

_id_2505(var_0, var_1) {
  var_2 = gettime() + getanimlength(var_1._id_1048) * 1000;
  var_3 = var_0.angles;
  var_4 = var_0.origin;
  var_0 = _id_25C1(var_0);
  [[level._id_09B8]]("MOD_RIFLE_BULLET", "torso_upper", var_4);
  _id_25C8(var_0, "weapon_");
  var_0 linkto(self);
  var_0 notsolid();
  var_0 setanim(var_1._id_1048);

  if(isai(var_0)) {
    var_0 animscripts\shared::_id_0D73();
  } else {
    _id_25C8(var_0, "weapon_");
  }
  if(isDefined(var_1._id_2506)) {
    var_0 unlink();
    var_0 startragdoll();
    wait(var_1._id_2506);
    var_0 delete();
    return;
  }
}

_id_2507(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  if(!isDefined(var_0)) {
    var_0 = _id_2509();
  }
  maps\_utility::_id_13DE("unloaded");
  maps\_utility::_id_13DE("loaded");
  common_scripts\utility::array_levelthread(var_0, ::_id_250D, var_1, var_2);
}

_id_2508(var_0) {
  for(var_1 = 0; var_1 < self._id_0A39.size; var_1++) {
    if(self._id_0A39[var_1] == var_0) {
      return 1;
    }
  }

  return 0;
}

_id_2509() {
  var_0 = [];
  var_1 = getaiarray(self.script_team);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(!isDefined(var_3._id_250B)) {
      continue;
    }
    if(var_3._id_250B != self._id_250B) {
      continue;
    }
    var_0[var_0.size] = var_3;
  }

  return var_0;
}

_id_250C() {
  var_0 = [];
  var_1 = getEntArray("script_vehicle", "code_classname");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(!isDefined(var_3._id_250B)) {
      continue;
    }
    if(var_3._id_250B != self._id_250B) {
      continue;
    }
    var_0[var_0.size] = var_3;
  }

  return var_0[0];
}

_id_250D(var_0, var_1, var_2) {
  if(_id_2508(var_0)) {
    return;
  }
  if(!_id_250E()) {
    return;
  }
  _id_2517(var_0, self, var_1, var_2);
}

_id_250E() {
  if(_id_250F()) {
    return 1;
  }
  if(maps\_utility::_id_1E25()) {
    return;
  }
  return;
}

_id_250F() {
  if(maps\_utility::_id_1E25()) {
    if(level._id_24E6[self.vehicletype].size - self._id_2500.size) {
      return 1;
    } else {
      return 0;
    }
  } else if(level._id_24E6[self.classname].size - self._id_2500.size) {
    return 1;
  } else {
    return 0;
  }
}

_id_2510(var_0, var_1) {
  var_1 endon("death");
  var_1 endon("stop_loading");
  var_2 = var_0 common_scripts\utility::waittill_any_return("long_death", "death", "enteredvehicle");

  if(var_2 != "enteredvehicle" && isDefined(var_0._id_2511)) {
    var_1._id_24E8[var_0._id_2511] = 0;
  }
  var_1._id_2500 = common_scripts\utility::array_remove(var_1._id_2500, var_0);
  _id_2512(var_1);
}

_id_2512(var_0) {
  if(isDefined(var_0.vehicletype) && var_0.vehicletype == "littlebird") {
    if(var_0._id_0A39.size == 6) {
      var_0 maps\_utility::_id_13DC("loaded");
    }
  } else if(!var_0._id_2500.size && var_0._id_0A39.size) {
    if(var_0._id_24E8[0]) {
      var_0 maps\_utility::_id_13DC("loaded");
    } else {
      var_0 thread _id_2513();
    }
  }
}

_id_2513() {
  var_0 = self._id_0A39;
  maps\_vehicle::_id_2514();
  maps\_utility::_id_1654("unloaded");
  var_0 = maps\_utility::_id_1361(var_0);
  thread maps\_vehicle::_id_2515(var_0);
}

_id_2516(var_0) {
  common_scripts\utility::waittill_any("unload", "death");
  var_0 maps\_utility::_id_1902();
}

_id_2517(var_0, var_1, var_2, var_3) {
  var_1 endon("stop_loading");
  var_4 = 1;

  if(!isDefined(var_2)) {
    var_2 = 0;
  }
  if(maps\_utility::_id_1E25()) {
    var_5 = level._id_24E6[var_1.vehicletype];
  } else {
    var_5 = level._id_24E6[var_1.classname];
  }
  if(isDefined(var_1._id_2518)) {
    var_1 thread[[var_1._id_2518]](var_0);
    return;
  }

  var_1 endon("death");
  var_0 endon("death");
  var_1._id_2500[var_1._id_2500.size] = var_0;
  thread _id_2510(var_0, var_1);
  var_6 = [];
  var_7 = undefined;
  var_8 = 0;
  var_9 = 0;

  for(var_10 = 0; var_10 < var_5.size; var_10++) {
    if(isDefined(var_5[var_10]._id_2519)) {
      var_9 = 1;
    }
  }

  if(!var_9) {
    var_0 notify("enteredvehicle");
    var_1 _id_24E5(var_0, var_4);
    return;
  }

  if(!isDefined(var_0._id_251A)) {
    while(var_1 vehicle_getspeed() > 1) {
      wait 0.05;
    }
  }

  var_11 = var_1 _id_25C6(var_3);

  if(isDefined(var_0._id_251B)) {
    var_7 = var_1 _id_25C3(var_0._id_251B);
  } else if(!var_1._id_24E8[0]) {
    var_7 = var_1 _id_25C3(0);

    if(var_2) {
      var_0 thread maps\_utility::_id_0D04();
      thread _id_2516(var_0);
    }
  } else if(var_11._id_251C.size) {
    var_7 = maps\_utility::_id_0AE9(var_0.origin, var_11._id_251C);
  } else {
    var_7 = undefined;
  }
  if(!var_11._id_251C.size && var_11._id_251D.size) {
    var_0 notify("enteredvehicle");
    var_1 _id_24E5(var_0, var_4);
    return;
  } else if(!isDefined(var_7)) {
    return;
  }
  var_8 = var_7.origin;
  var_12 = var_7.angles;
  var_0._id_2511 = var_7._id_2252;
  var_1._id_24E8[var_7._id_2252] = 1;
  var_0._id_2005 = 1;
  var_0 notify("stop_going_to_node");
  var_0 maps\_utility::_id_251E();
  var_0 maps\_utility::_id_251F();
  var_0.goalradius = 16;
  var_0 setgoalpos(var_8);
  var_0 waittill("goal");
  var_0 maps\_utility::_id_2520();
  var_0 maps\_utility::_id_2521();
  var_0 notify("boarding_vehicle");
  var_13 = _id_2534(var_1, var_7._id_2252);

  if(isDefined(var_13.delay)) {
    var_0.delay = var_13.delay;

    if(isDefined(var_13._id_24E9)) {
      self._id_24EA = var_0.delay;
    }
  }

  if(isDefined(var_13._id_24E9)) {
    self._id_24EA = self._id_24EA + var_13._id_24E9;
    var_0.delay = self._id_24EA;
  }

  var_1 _id_2532(var_0, var_1.vehicletype, var_13._id_24F2);
  var_0.allowdeath = 0;
  var_13 = var_5[var_7._id_2252];

  if(isDefined(var_7)) {
    if(isDefined(var_13._id_2522)) {
      if(isDefined(var_13._id_2523)) {
        var_14 = isDefined(var_0._id_2524);

        if(!var_14) {
          var_1 clearanim(var_13._id_2523, 0);
        }
      }

      var_1 = var_1 _id_25C7();
      var_1 thread _id_2573(var_13._id_2522, var_13._id_2525);
      level thread maps\_anim::_id_0C61(var_1, "vehicle_anim_flag");
    }

    if(isDefined(var_13._id_2526)) {
      var_8 = var_1 gettagorigin(var_13._id_2526);
    } else {
      var_8 = var_1.origin;
    }
    if(isDefined(var_13._id_2527)) {
      thread common_scripts\utility::play_sound_in_space(var_13._id_2527, var_8);
    }
    var_15 = undefined;
    var_16 = undefined;

    if(isDefined(var_13._id_2528)) {
      var_15 = [];
      var_15[0] = var_13._id_2528;
      var_16 = [];
      var_16[0] = ::_id_2529;
      var_1 _id_2532(var_0, var_1.vehicletype, var_13._id_24F2);
    }

    var_1 _id_259E(var_0, var_13._id_24F2, var_13._id_2519, var_15, var_16);
  }

  var_0 notify("enteredvehicle");
  var_1 _id_24E5(var_0, var_4);
}

_id_2529() {
  self notify("enteredvehicle");
}

_id_252A(var_0) {
  if(maps\_vehicle::_id_21ED()) {
    return;
  }
  self._id_252B = var_0;
  self endon("death");
  var_0 waittill("death");

  if(isDefined(self._id_252C)) {
    return;
  }
  self notify("driver dead");
  self._id_252D = 1;

  if(isDefined(self._id_252E) && self._id_252E) {
    self setwaitspeed(0);
    self vehicle_setspeed(0, 10);
    self waittill("reached_wait_speed");
  }

  maps\_vehicle::_id_2514();
}

_id_252F() {
  var_0 = spawn("script_model", self.origin);
  var_0 setModel(self.model);
  var_1 = self getattachsize();

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_0 attach(self getattachmodelname(var_2));
  }
  return var_0;
}

_id_2530(var_0, var_1) {
  if(isai(var_0)) {
    return var_0;
  }
  if(var_0._id_224F == 1) {
    var_0 delete();
  } else {
    var_0 = maps\_utility::_id_2531(var_0);
    var_2 = self.classname;

    if(maps\_utility::_id_1E25()) {
      var_2 = self.vehicletype;
    }
    var_3 = level._id_24E6[var_2].size;
    var_4 = _id_2534(self, var_1);
    _id_2532(var_0, var_2, var_4._id_24F2);
    var_0._id_24EC = var_4._id_0F59;
    thread _id_2549(var_0, var_1);
  }
}

_id_2532(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3)) {
    var_3 = (0, 0, 0);
  }
  if(maps\_utility::_id_1E25() && (var_1 == "snowmobile" || var_1 == "atv") || !maps\_utility::_id_1E25() && (var_1 == "script_vehicle_snowmobile" || var_1 == "script_vehicle_atv")) {
    var_0 linktoblendtotag(self, var_2, 0);
  } else {
    var_0 maps\_utility::_id_2533(self, var_2, var_3, (0, 0, 0));
  }
}

_id_2534(var_0, var_1) {
  if(maps\_utility::_id_1E25()) {
    return level._id_24E6[var_0.vehicletype][var_1];
  } else {
    return level._id_24E6[var_0.classname][var_1];
  }
}

_id_2535(var_0, var_1) {
  var_0 waittill("death");

  if(!isDefined(self)) {
    return;
  }
  self._id_0A39 = common_scripts\utility::array_remove(self._id_0A39, var_0);
  self._id_24E8[var_1] = 0;
}

_id_2536() {
  if(!isDefined(level._id_2537)) {
    level._id_2537 = [];
  }
  if(!isDefined(level._id_2538)) {
    level._id_2538 = [];
  }
  level._id_2537["idle"] = ::_id_2549;
  level._id_2537["duck"] = ::_id_2559;
  level._id_2537["duck_once"] = ::_id_2553;
  level._id_2538["duck_once"] = ::_id_2551;
  level._id_2537["weave"] = ::_id_2557;
  level._id_2538["weave"] = ::_id_2555;
  level._id_2537["turn_right"] = ::_id_25AE;
  level._id_2538["turn_right"] = ::_id_25AC;
  level._id_2537["turn_left"] = ::_id_25B0;
  level._id_2538["turn_left"] = ::_id_25AC;
  level._id_2537["turn_hardright"] = ::_id_25B4;
  level._id_2537["turn_hardleft"] = ::_id_25B6;
  level._id_2537["turret_fire"] = ::_id_2546;
  level._id_2537["turret_turnleft"] = ::_id_2543;
  level._id_2537["turret_turnright"] = ::_id_2545;
  level._id_2537["unload"] = ::_id_257B;
  level._id_2537["pre_unload"] = ::_id_25CC;
  level._id_2538["pre_unload"] = ::_id_25CA;
  level._id_2537["idle_alert"] = ::_id_25CE;
  level._id_2538["idle_alert"] = ::_id_25D0;
  level._id_2537["idle_alert_to_casual"] = ::_id_25D1;
  level._id_2538["idle_alert_to_casual"] = ::_id_25D3;
  level._id_2537["reaction"] = ::_id_2545;
}

_id_2539(var_0, var_1) {
  var_0._id_2251 = 1;
  thread _id_2535(var_0, var_1);
}

_id_253A(var_0, var_1) {
  var_2 = _id_2534(self, var_1);
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");
  var_0._id_2253 = 1;
  var_3 = 0;

  for(;;) {
    var_4 = gettime() + 2000;

    while(gettime() < var_4 && isDefined(var_0.enemy)) {
      _id_259E(var_0, var_2._id_24F2, var_0._id_24EE, undefined, undefined, "firing");
    }
    var_5 = randomint(5) + 10;

    for(var_6 = 0; var_6 < var_5; var_6++) {
      _id_259E(var_0, var_2._id_24F2, var_2._id_253B);
    }
  }
}

_id_253C(var_0, var_1) {
  var_2 = _id_2534(self, var_1);

  if(!isDefined(var_2._id_253D)) {
    thread _id_253A(var_0, var_1);
    return;
  }

  _id_259E(var_0, var_2._id_24F2, var_2._id_253D);
  var_0._id_2253 = 0;
  thread _id_2549(var_0, var_1);
}

_id_253E(var_0, var_1) {
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");
  var_2 = _id_2534(self, var_1);

  for(;;) {
    if(self vehicle_getspeed() == 0) {
      var_0._id_24EC = var_2._id_253F;
    } else {
      var_0._id_24EC = var_2._id_2540;
    }
    wait 0.25;
  }
}

_id_2541(var_0, var_1) {
  var_2 = _id_2534(self, var_1);
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");

  if(isDefined(var_2._id_2542)) {
    _id_259E(var_0, var_2._id_24F2, var_2._id_2542);
  }
  thread _id_2549(var_0, var_1);
}

_id_2543(var_0, var_1) {
  var_2 = _id_2534(self, var_1);
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");

  for(;;) {
    _id_259E(var_0, var_2._id_24F2, var_0._id_2544);
  }
}

_id_2545(var_0, var_1) {
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");
  var_2 = _id_2534(self, var_1);

  for(;;) {
    _id_259E(var_0, var_2._id_24F2, var_0._id_2544);
  }
}

_id_2546(var_0, var_1) {
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");
  var_2 = _id_2534(self, var_1);

  if(isDefined(var_2._id_2547)) {
    maps\_vehicle::get_dummy() setanimrestart(var_2._id_2547);
  }
  if(isDefined(var_2._id_2548)) {
    if(isDefined(var_2._id_0400)) {
      _id_259E(var_0, var_2._id_0400, var_2._id_2548);
    } else {
      _id_259E(var_0, var_2._id_24F2, var_2._id_2548);
    }
  }

  thread _id_2549(var_0, var_1);
}

_id_2549(var_0, var_1, var_2) {
  var_0 endon("newanim");

  if(!isDefined(var_2)) {
    self endon("death");
  }
  var_0 endon("death");
  var_0._id_2251 = 1;
  var_0 notify("gotime");

  if(!isDefined(var_0._id_24EC)) {
    return;
  }
  var_3 = _id_2534(self, var_1);

  if(isDefined(var_3.mgturret)) {
    return;
  }
  if(isDefined(var_3._id_254A) && var_3._id_254A) {
    var_0 hide();
  }
  if(isDefined(var_3._id_253F) && isDefined(var_3._id_2540)) {
    thread _id_253E(var_0, var_1);
  }
  for(;;) {
    var_0 notify("idle");
    _id_254B(var_0, var_3);
  }
}

_id_254B(var_0, var_1) {
  if(isDefined(var_0._id_254C)) {
    _id_259E(var_0, var_1._id_24F2, var_0._id_254C);
    return;
  }

  if(isDefined(var_1._id_254D)) {
    var_2 = _id_2550(var_0, var_1._id_254D);
    _id_259E(var_0, var_1._id_24F2, var_0._id_24EC[var_2]);
    return;
  }

  if(isDefined(var_0._id_254E) && isDefined(var_1._id_254F)) {
    _id_259E(var_0, var_1._id_24F2, var_1._id_254F);
    return;
  }

  if(isDefined(var_1._id_24EC)) {
    thread _id_2573(var_1._id_24EC);
  }
  _id_259E(var_0, var_1._id_24F2, var_0._id_24EC);
}

_id_2550(var_0, var_1) {
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

_id_2551(var_0, var_1) {
  return isDefined(_id_2534(self, var_1)._id_2552);
}

_id_2553(var_0, var_1) {
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");
  var_2 = _id_2534(self, var_1);

  if(isDefined(var_2._id_2552)) {
    if(isDefined(var_2._id_2554)) {
      thread _id_2573(var_2._id_2554);
    }
    _id_259E(var_0, var_2._id_24F2, var_2._id_2552);
  }

  thread _id_2549(var_0, var_1);
}

_id_2555(var_0, var_1) {
  return isDefined(_id_2534(self, var_1)._id_2556);
}

_id_2557(var_0, var_1) {
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");
  var_2 = _id_2534(self, var_1);

  if(isDefined(var_2._id_2556)) {
    if(isDefined(var_2._id_2558)) {
      thread _id_2573(var_2._id_2558);
    }
    _id_259E(var_0, var_2._id_24F2, var_2._id_2556);
  }

  thread _id_2549(var_0, var_1);
}

_id_2559(var_0, var_1) {
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");
  var_2 = _id_2534(self, var_1);

  if(isDefined(var_2._id_255A)) {
    _id_259E(var_0, var_2._id_24F2, var_2._id_255A);
  }
  thread _id_255B(var_0, var_1);
}

_id_255B(var_0, var_1) {
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");
  var_2 = _id_2534(self, var_1);
  var_3 = _id_2550(var_0, var_2._id_255C);

  for(;;) {
    _id_259E(var_0, var_2._id_24F2, var_2._id_255D[var_3]);
  }
}

_id_255E(var_0, var_1) {
  var_2 = _id_2534(self, var_1);

  if(isDefined(var_2._id_255F) && var_0._id_255F) {
    _id_259E(var_0, var_2._id_24F2, var_2._id_2560);
    var_0._id_255F = 0;
  }

  thread _id_2549(var_0, var_1);
}

_id_2561(var_0) {
  self endon("death");
  self._id_2562 = maps\_utility::_id_0BC3(self._id_2562, var_0);
  var_0 common_scripts\utility::waittill_any("death", "jumpedout");
  self._id_2562 = common_scripts\utility::array_remove(self._id_2562, var_0);

  if(!self._id_2562.size) {
    maps\_utility::_id_13DC("unloaded");
    self._id_2563 = "default";
  }
}

_id_2564(var_0) {
  if(!self._id_0A39.size) {
    return 0;
  }
  for(var_1 = 0; var_1 < self._id_0A39.size; var_1++) {
    if(!isalive(self._id_0A39[var_1])) {
      continue;
    }
    if(_id_2567(self._id_0A39[var_1]._id_2252, var_0)) {
      return 1;
    }
  }

  return 0;
}

_id_2565() {
  var_0 = [];
  var_1 = [];
  var_2 = "default";

  if(isDefined(self._id_2563)) {
    var_2 = self._id_2563;
  }
  if(maps\_utility::_id_1E25()) {
    var_1 = level._id_2566[self.vehicletype][var_2];
  } else {
    var_1 = level._id_2566[self.classname][var_2];
  }
  if(!isDefined(var_1)) {
    if(maps\_utility::_id_1E25()) {
      var_1 = level._id_2566[self.vehicletype]["default"];
    } else {
      var_1 = level._id_2566[self.classname]["default"];
    }
  }

  foreach(var_4 in var_1) {}
  var_0[var_4] = var_4;

  return var_0;
}

_id_2567(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = self._id_2563;
  }
  var_2 = self.classname;

  if(maps\_utility::_id_1E25()) {
    var_2 = self.vehicletype;
  }
  if(!isDefined(level._id_2566[var_2])) {
    return 1;
  }
  if(!isDefined(level._id_2566[var_2][var_1])) {
    return 1;
  }
  var_3 = level._id_2566[var_2][var_1];

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(var_0 == var_3[var_4]) {
      return 1;
    }
  }

  return 0;
}

_id_2568(var_0, var_1, var_2) {
  self endon("unloading");

  for(;;) {
    _id_259E(var_0, var_1, var_2);
  }
}

_id_2569(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self.classname;

  if(maps\_utility::_id_1E25()) {
    var_5 = self.vehicletype;
  }
  if(var_4) {
    thread _id_2568(var_1, var_2, level._id_256B[var_5][var_0._id_256A]._id_2018);
    self waittill("unloading");
  }

  self._id_2562 = maps\_utility::_id_0BC3(self._id_2562, var_1);
  thread _id_256F(var_1, var_2, var_3);

  if(!isDefined(self._id_256C)) {
    _id_259E(var_1, var_2, var_3);
  }
  var_1 unlink();

  if(!isDefined(self)) {
    var_1 delete();
    return;
  }

  self._id_2562 = common_scripts\utility::array_remove(self._id_2562, var_1);

  if(!self._id_2562.size) {
    self notify("unloaded");
  }
  self._id_256A[var_0._id_256A] = undefined;
  wait 10;
  var_1 delete();
}

_id_256D() {
  wait 0.05;

  while(isalive(self) && self._id_2562.size > 2) {
    wait 0.05;
  }
  if(!isalive(self) || isDefined(self._id_256C) && self._id_256C) {
    return;
  }
  self notify("getoutrig_disable_abort");
}

_id_256E() {
  self endon("end_getoutrig_abort_while_deploying");

  while(!isDefined(self._id_256C)) {
    wait 0.05;
  }
  var_0 = [];

  foreach(var_2 in self._id_0A39) {
    if(isalive(var_2)) {
      common_scripts\utility::add_to_array(var_0, var_2);
    }
  }

  common_scripts\utility::array_levelthread(var_0, maps\_utility::_id_1E93);
  self notify("crashed_while_deploying");
  var_0 = undefined;
}

_id_256F(var_0, var_1, var_2) {
  var_3 = getanimlength(var_2);
  var_4 = var_3 - 1.0;

  if(self.vehicletype == "mi17") {
    var_4 = var_3 - 0.5;
  }
  var_5 = 2.5;
  self endon("getoutrig_disable_abort");
  thread _id_256D();
  thread _id_256E();
  common_scripts\utility::waittill_notify_or_timeout("crashed_while_deploying", var_5);
  self notify("end_getoutrig_abort_while_deploying");

  while(!isDefined(self._id_256C)) {
    wait 0.05;
  }
  thread _id_259E(var_0, var_1, var_2);
  waittillframeend;
  var_0 setanimtime(var_2, var_4 / var_3);
  var_6 = self;

  if(isDefined(self._id_2570)) {
    var_6 = self._id_2570;
  }
  for(var_7 = 0; var_7 < self._id_0A39.size; var_7++) {
    if(!isDefined(self._id_0A39[var_7])) {
      continue;
    }
    if(!isDefined(self._id_0A39[var_7]._id_2571)) {
      continue;
    }
    if(self._id_0A39[var_7]._id_2571 != 1) {
      continue;
    }
    if(!isDefined(self._id_0A39[var_7]._id_0EF1)) {
      continue;
    }
    self._id_0A39[var_7]._id_2572 = 1;

    if(isalive(self._id_0A39[var_7])) {
      thread _id_25A2(self._id_0A39[var_7], self, var_6);
    }
  }
}

_id_2573(var_0, var_1) {
  self endon("death");
  self endon("dont_clear_anim");

  if(!isDefined(var_1)) {
    var_1 = 1;
  }
  var_2 = getanimlength(var_0);
  var_3 = maps\_vehicle::get_dummy();
  var_3 endon("death");
  var_3 setflaggedanimrestart("vehicle_anim_flag", var_0);
  wait(var_2);

  if(var_1) {
    var_3 clearanim(var_0, 0);
  }
}

#using_animtree("generic_human");

_id_2574(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }
  var_3 = self.classname;

  if(maps\_utility::_id_1E25()) {
    var_3 = self.vehicletype;
  }
  var_4 = _id_2534(self, var_1);

  if(isDefined(self._id_2575) && isDefined(self._id_2575[var_4._id_256A])) {
    var_5 = 1;
  } else {
    var_5 = 0;
  }
  if(!isDefined(var_4._id_256A) || isDefined(self._id_256A[var_4._id_256A]) || var_5) {
    return;
  }
  var_6 = var_0 gettagorigin(level._id_256B[var_3][var_4._id_256A].tag);
  var_7 = var_0 gettagangles(level._id_256B[var_3][var_4._id_256A].tag);
  self._id_2576[var_4._id_256A] = 1;
  var_8 = spawn("script_model", var_6);
  var_8.angles = var_7;
  var_8.origin = var_6;
  var_8 setModel(level._id_256B[var_3][var_4._id_256A].model);
  self._id_256A[var_4._id_256A] = var_8;
  var_8 useanimtree(#animtree);
  var_8 linkto(var_0, level._id_256B[var_3][var_4._id_256A].tag, (0, 0, 0), (0, 0, 0));
  thread _id_2569(var_4, var_8, level._id_256B[var_3][var_4._id_256A].tag, level._id_256B[var_3][var_4._id_256A]._id_2577, var_2);
  return var_8;
}

_id_2578(var_0) {
  if(!isDefined(self._id_2579)) {
    self._id_2579 = [];
  }
  var_1 = 0;

  if(!isDefined(self._id_2579[var_0])) {
    self._id_2579[var_0] = 1;
  } else {
    var_1 = 1;
  }
  thread _id_257A(var_0);
  return var_1;
}

_id_257A(var_0) {
  wait 0.05;

  if(!isDefined(self)) {
    return;
  }
  self._id_2579[var_0] = 0;
  var_1 = getarraykeys(self._id_2579);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(self._id_2579[var_1[var_2]]) {
      return;
    }
  }

  self._id_2579 = undefined;
}

_id_257B(var_0, var_1) {
  var_2 = _id_2534(self, var_1);
  var_3 = self.vehicletype;

  if(!_id_2567(var_1)) {
    thread _id_2549(var_0, var_1);
    return;
  }

  if(!isDefined(var_2._id_257C)) {
    thread _id_2549(var_0, var_1);
    return;
  }

  if(isDefined(var_2._id_254A) && var_2._id_254A) {
    var_0 show();
  }
  thread _id_2561(var_0);
  self endon("death");

  if(isai(var_0) && isalive(var_0)) {
    var_0 endon("death");
  }
  if(isDefined(var_0._id_0CB3)) {
    var_0 maps\_utility::_id_257D();
    var_0._id_0CB3 = undefined;

    if(isDefined(var_0._id_0EED)) {
      var_0[[var_0._id_0EED]]();
    }
  }

  if(isDefined(var_0._id_0CB4)) {
    var_0 maps\_utility::_id_257D();
    var_0._id_0CB4 = undefined;
    var_0._id_10A5["combat"] = undefined;
    var_0._id_10A5["stop"] = undefined;

    if(isDefined(var_0._id_0EED)) {
      var_0[[var_0._id_0EED]]();
    }
  }

  if(isDefined(var_0._id_257E)) {
    var_0._id_257E = undefined;

    if(isDefined(var_0._id_0EED)) {
      var_0[[var_0._id_0EED]]();
    }
  }

  var_4 = _id_25C7();

  if(isDefined(var_2._id_2523)) {
    var_4 thread _id_2573(var_2._id_2523, var_2._id_257F);
    var_5 = 0;

    if(isDefined(var_2._id_2580)) {
      var_5 = _id_2578(var_2._id_2580);
      var_6 = var_4 gettagorigin(var_2._id_2580);
    } else {
      var_6 = var_4.origin;
    }
    if(isDefined(var_2._id_2581) && !var_5) {
      thread common_scripts\utility::play_sound_in_space(var_2._id_2581, var_6);
    }
    var_5 = undefined;
  }

  var_7 = 0;

  if(isDefined(var_2._id_2582)) {
    var_7 = var_7 + getanimlength(var_2._id_2582);
  }
  if(isDefined(var_2.delay)) {
    var_7 = var_7 + var_2.delay;
  }
  if(isDefined(var_0.delay)) {
    var_7 = var_7 + var_0.delay;
  }
  if(var_7 > 0) {
    thread _id_2549(var_0, var_1);
    wait(var_7);
  }

  var_8 = isDefined(var_2._id_2583);

  if(!var_8 && var_0._id_2253) {
    _id_253C(var_0, var_1);
  } else if(!var_8 && !var_0._id_2251 && isDefined(var_0._id_24EC)) {
    var_0 waittill("idle");
  }
  var_0._id_0D50 = undefined;
  var_0._id_0EC1 = undefined;
  var_0 notify("newanim");

  if(isDefined(var_2._id_24F4) && !var_2._id_24F4) {
    if(!isDefined(var_0._id_2584)) {
      var_0 maps\_utility::_id_257D();
    }
  }

  if(isai(var_0)) {
    var_0 pushplayer(1);
  }
  var_9 = 0;

  if(isDefined(var_2._id_2585)) {
    var_9 = 1;
  } else if(!isDefined(var_2._id_257C) || !isDefined(self._id_2586) && (isDefined(var_2._id_2502) && var_2._id_2502) || isDefined(self._id_2587) && var_1 == 0) {
    thread _id_2549(var_0, var_1);
    return;
  }

  if(var_0 _id_25C9()) {
    var_0.health = var_0._id_24EB;
  }
  var_0._id_24EB = undefined;

  if(isai(var_0) && isalive(var_0)) {
    var_0 endon("death");
  }
  var_0.allowdeath = 0;

  if(isDefined(var_2._id_2588)) {
    var_10 = var_2._id_2588;
  } else {
    var_10 = var_2._id_24F2;
  }
  if(var_8 && var_0._id_2253) {
    var_11 = var_2._id_2583;
  } else if(isDefined(var_0._id_2589)) {
    var_11 = var_0._id_2589;
  } else if(isDefined(var_0._id_254E) && isDefined(var_2._id_258A)) {
    var_11 = var_2._id_258A;
  } else {
    var_11 = var_2._id_257C;
  }
  if(!var_9) {
    thread _id_25BD(var_0);

    if(isDefined(var_2._id_256A)) {
      if(!isDefined(self._id_256A[var_2._id_256A])) {
        thread _id_2549(var_0, var_1);
        var_12 = _id_2574(var_4, var_0._id_2252, 0);
      }
    }

    if(isDefined(var_2._id_258B)) {
      var_0 thread maps\_utility::play_sound_on_tag(var_2._id_258B, "J_Wrist_RI", 1);
    }
    if(isDefined(var_0._id_254E) && isDefined(var_2._id_258C)) {
      var_0 thread maps\_utility::play_sound_on_entity(var_2._id_258C);
    }
    if(isDefined(var_2._id_258D)) {
      var_0 thread maps\_utility::_id_258E(var_2._id_258D);
    }
    if(isDefined(var_0._id_254E) && isDefined(var_2._id_258F)) {
      level.player thread common_scripts\utility::play_loop_sound_on_entity(var_2._id_258F);
    }
    var_0 notify("newanim");
    var_0 notify("jumping_out");
    var_13 = 0;

    if(!isai(var_0)) {
      var_13 = 1;
    }
    var_0 = _id_2530(var_0, var_1);

    if(!isalive(var_0)) {
      return;
    }
    var_0._id_2571 = 1;

    if(isDefined(var_2._id_2590)) {
      var_0 maps\_utility::_id_2591();
    }
    if(isDefined(var_2._id_2571)) {
      var_0._id_2571 = 1;

      if(isDefined(var_2._id_2592)) {
        var_0._id_2592 = var_2._id_2592;
      }
    }

    if(var_13) {
      self._id_0A39 = maps\_utility::_id_0BC3(self._id_0A39, var_0);
      thread _id_2535(var_0, var_1);
      thread _id_2561(var_0);
      var_0._id_0EF1 = self;
    }

    if(isai(var_0)) {
      var_0 endon("death");
    }
    var_0 notify("newanim");
    var_0 notify("jumping_out");

    if(isDefined(var_2._id_2593) && var_2._id_2593) {
      thread _id_25D4(var_0);
    }
    if(isDefined(var_2._id_2594)) {
      _id_259E(var_0, var_10, var_11);
      var_14 = var_10;

      if(isDefined(var_2._id_2595)) {
        var_14 = var_2._id_2595;
      }
      _id_259E(var_0, var_14, var_2._id_2594);
    } else {
      var_0._id_2596 = 1;
      _id_259E(var_0, var_10, var_11);
    }

    if(isDefined(var_0._id_254E) && isDefined(var_2._id_258F)) {
      level.player thread common_scripts\utility::stop_loop_sound_on_entity(var_2._id_258F);
    }
    if(isDefined(var_2._id_258D)) {
      var_0 thread common_scripts\utility::stop_loop_sound_on_entity(var_2._id_258D);
    }
    if(isDefined(var_0._id_254E) && isDefined(var_2._id_2597)) {
      level.player thread maps\_utility::play_sound_on_entity(var_2._id_2597);
    }
  } else if(!isai(var_0)) {
    if(var_0._id_224F == 1) {
      var_0 delete();
      return;
    }

    var_0 = maps\_utility::_id_2531(var_0);
  }

  self._id_0A39 = common_scripts\utility::array_remove(self._id_0A39, var_0);
  self._id_24E8[var_1] = 0;
  var_0._id_0EF1 = undefined;
  var_0._id_0EEA = undefined;

  if(!isalive(self) && !isDefined(var_2._id_2598)) {
    var_0 delete();
    return;
  }

  var_0 unlink();

  if(!isDefined(var_0._id_0D04)) {
    var_0.allowdeath = 1;
  }
  if(isalive(var_0)) {
    var_0.a._id_0D31 = !var_0 isbadguy();
    var_0._id_2511 = undefined;
    var_0 notify("jumpedout");
    var_0 maps\_utility::_id_2599();

    if(isDefined(var_2._id_259A)) {
      var_0._id_247C = var_2._id_259A;
      var_0 allowedstances("crouch");
      var_0 thread animscripts\utility::_id_247B();
      var_0 allowedstances("stand", "crouch", "prone");
    }

    var_0 pushplayer(0);

    if(_id_259C(var_0)) {
      var_0.goalradius = 600;
      var_0 setgoalpos(var_0.origin);
    }
  }

  if(isDefined(var_2._id_259B) && var_2._id_259B) {
    var_0 delete();
    return;
  }

  var_0 _id_25D8();
}

_id_259C(var_0) {
  if(isDefined(var_0._id_2195)) {
    return 0;
  }
  if(var_0 maps\_utility::_id_134F()) {
    return 0;
  }
  if(isDefined(var_0._id_259D)) {
    return 0;
  }
  if(!isDefined(var_0.target)) {
    return 1;
  }
  var_1 = getnodearray(var_0.target, "targetname");
  return !var_1.size;
}

_id_259E(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 notify("animontag_thread");
  var_0 endon("animontag_thread");

  if(!isDefined(var_5)) {
    var_5 = "animontagdone";
  }
  if(isDefined(self.modeldummy)) {
    var_6 = self.modeldummy;
  } else {
    var_6 = self;
  }
  if(!isDefined(var_1)) {
    var_7 = var_0.origin;
    var_8 = var_0.angles;
  } else {
    var_7 = var_6 gettagorigin(var_1);
    var_8 = var_6 gettagangles(var_1);
  }

  if(isDefined(var_0._id_2571) && !isDefined(var_0._id_259F)) {
    level thread _id_25A1(var_0, self);
  }
  var_0 animscripted(var_5, var_7, var_8, var_2);

  if(isai(var_0)) {
    thread _id_0C51(var_0, var_6, var_5);
  }
  if(isDefined(var_0._id_2596)) {
    var_0._id_2596 = undefined;
    var_9 = getanimlength(var_2) - 0.25;

    if(var_9 > 0) {
      wait(var_9);
    }
    var_0 stopanimscripted();
    var_0.interval = 0;
    var_0 thread _id_25A0();
  } else {
    if(isDefined(var_3)) {
      for(var_10 = 0; var_10 < var_3.size; var_10++) {
        var_0 waittillmatch(var_5, var_3[var_10]);
        var_0 thread[[var_4[var_10]]]();
      }
    }

    var_0 waittillmatch(var_5, "end");
  }

  var_0 notify("anim_on_tag_done");
  var_0._id_2571 = undefined;
}

_id_25A0() {
  self endon("death");
  wait 2;

  if(self.interval == 0) {
    self.interval = 80;
  }
}

_id_25A1(var_0, var_1) {
  if(isDefined(var_0._id_0D04) && var_0._id_0D04) {
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

    if(isDefined(var_0._id_2572)) {
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
  thread maps\_utility::_id_1E05(var_0.origin, "rifle", 300);
  thread _id_25A2(var_0, var_1, var_3);
}

_id_25A2(var_0, var_1, var_2) {
  var_0._id_0D50 = undefined;
  var_0._id_0D45 = undefined;
  var_0._id_25A3 = 1;

  if(isDefined(var_0._id_2592)) {
    var_3 = getmovedelta(var_0._id_2592, 0, 1);
    var_4 = physicstrace(var_0.origin + (0, 0, 16), var_0.origin - (0, 0, 10000));
    var_5 = distance(var_0.origin + (0, 0, 16), var_4);

    if(abs(var_3[2] + 16) <= abs(var_5)) {
      var_0 thread maps\_utility::play_sound_on_entity("generic_death_falling");
      var_0 animscripted("fastrope_fall", var_0.origin, var_0.angles, var_0._id_2592);
      var_0 waittillmatch("fastrope_fall", "start_ragdoll");
    }
  }

  if(!isDefined(var_0)) {
    return;
  }
  var_0._id_0D50 = undefined;
  var_0._id_0D45 = undefined;
  var_0._id_25A3 = 1;
  var_0 notify("rope_death", var_2);
  maps\_spawner::_id_2256(var_2);
  var_0 kill(var_2.origin, var_2);
  var_0 animscripts\shared::_id_0D73();
  var_0 startragdoll();
}

_id_0C51(var_0, var_1, var_2) {
  var_0 endon("newanim");
  var_1 endon("death");
  var_0 endon("death");
  var_0 animscripts\shared::_id_0C51(var_2);
}

_id_25A4(var_0, var_1, var_2, var_3) {
  var_0 animscripted("movetospot", var_1, var_2, var_3);
  var_0 waittillmatch("movetospot", "end");
}

_id_25A5(var_0, var_1, var_2) {
  if(!isalive(var_0)) {
    return;
  }
  if(isDefined(self._id_25A6)) {
    return;
  }
  var_3 = _id_2534(self, var_0._id_2252);
  var_0._id_25A7 = var_1;

  if(isDefined(var_3._id_25A8)) {
    return _id_25BE(var_0);
  }
  if(isDefined(var_3._id_2598) && isDefined(self)) {
    if(isDefined(self._id_25A9) && self._id_25A9) {
      return;
    }
    thread _id_2549(var_0, var_0._id_2252, 1);
    wait(var_3._id_2598);

    if(isDefined(var_0) && isDefined(self)) {
      self._id_25AA = var_0._id_2252;
      maps\_vehicle::_id_25AB("unload");
    }

    return;
  }

  if(isDefined(var_0)) {
    if(isDefined(var_0._id_2571) && var_2 != "bm21_troops") {
      return;
    }
    var_4 = var_0.origin;
    [[level._id_09B8]]("MOD_RIFLE_BULLET", "torso_upper", var_4);

    if(var_2 == "bm21_troops") {
      var_0.allowdeath = 1;
      var_0 kill();
      return;
    }

    var_0 delete();
  }
}

_id_25AC(var_0, var_1) {
  return isDefined(_id_2534(self, var_1)._id_25AD);
}

_id_25AE(var_0, var_1) {
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");
  var_2 = _id_2534(self, var_1);

  if(isDefined(var_2._id_25AF)) {
    thread _id_2573(var_2._id_25AF);
  }
  _id_259E(var_0, var_2._id_24F2, var_2._id_25AD);
  thread _id_2549(var_0, var_1);
}

_id_25B0(var_0, var_1) {
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");
  var_2 = _id_2534(self, var_1);

  if(isDefined(var_2._id_25B1)) {
    thread _id_2573(var_2._id_25B1);
  }
  _id_259E(var_0, var_2._id_24F2, var_2._id_25B2);
  thread _id_2549(var_0, var_1);
}

_id_25B3(var_0, var_1) {
  return isDefined(_id_2534(self, var_1)._id_25B2);
}

_id_25B4(var_0, var_1) {
  if(maps\_utility::_id_1E25()) {
    var_2 = level._id_24E6[self.vehicletype][var_1];
  } else {
    var_2 = level._id_24E6[self.classname][var_1];
  }
  if(isDefined(var_2._id_25B5)) {
    var_0._id_254C = var_2._id_25B5;
  }
}

_id_25B6(var_0, var_1) {
  if(maps\_utility::_id_1E25()) {
    var_2 = level._id_24E6[self.vehicletype][var_1];
  } else {
    var_2 = level._id_24E6[self.classname][var_1];
  }
  if(isDefined(var_2._id_25B7)) {
    var_0._id_254C = var_2._id_25B7;
  }
}

_id_25B8() {
  self endon("death");
  self waittill("loaded");
  maps\_vehicle::_id_1FA6(self);
}

_id_25B9(var_0, var_1) {
  var_2 = var_0._id_251B;

  if(isDefined(var_0._id_2511)) {
    var_2 = var_0._id_2511;
  }
  if(isDefined(var_2)) {
    return var_2;
  }
  for(var_3 = 0; var_3 < self._id_24E8.size; var_3++) {
    if(self._id_24E8[var_3]) {
      continue;
    }
    return var_3;
  }

  if(isDefined(var_0._id_250B)) {}
}

_id_25BA(var_0, var_1, var_2) {
  var_3 = _id_2534(self, var_1);
  var_4 = self.mgturret[var_3.mgturret];

  if(!isalive(var_0)) {
    return;
  }
  var_4 endon("death");
  var_0 endon("death");

  if(isDefined(var_2) && var_2 && isDefined(var_3._id_25BB)) {
    [[var_3._id_25BB]](self, var_0, var_1, var_4);
  }
  maps\_vehicle::_id_25BC(var_4);
  var_4 setdefaultdroppitch(0);
  wait 0.1;
  var_0 endon("guy_man_turret_stop");
  level thread maps\_mgturret::_id_229F(var_4, maps\_utility::_id_229D());
  var_4 setturretignoregoals(1);

  for(;;) {
    if(!isDefined(var_0 getturret())) {
      var_0 useturret(var_4);
    }
    wait 1;
  }
}

_id_25BD(var_0) {
  var_0 endon("jumpedout");
  var_0 waittill("death");

  if(isDefined(var_0)) {
    var_0 unlink();
  }
}

_id_25BE(var_0) {
  if(!isDefined(var_0._id_2252)) {
    return;
  }
  var_1 = var_0._id_2252;
  var_2 = _id_2534(self, var_1);

  if(!isDefined(var_2._id_25A8)) {
    return;
  }
  [[level._id_09B8]]("MOD_RIFLE_BULLET", "torso_upper", var_0.origin);
  var_0._id_0D50 = var_2._id_25A8;
  var_3 = self.angles;
  var_4 = var_0.origin;

  if(isDefined(var_2._id_25BF)) {
    var_4 = var_4 + anglesToForward(var_3) * var_2._id_25BF[0];
    var_4 = var_4 + anglestoright(var_3) * var_2._id_25BF[1];
    var_4 = var_4 + anglestoup(var_3) * var_2._id_25BF[2];
  }

  var_0 = _id_25C1(var_0);
  _id_25C8(var_0, "weapon_");
  var_0 notsolid();
  var_0.origin = var_4;
  var_0.angles = var_3;
  var_0 animscripted("deathanim", var_4, var_3, var_2._id_25A8);
  var_5 = 0.3;

  if(isDefined(var_2._id_25C0)) {
    var_5 = var_2._id_25C0;
  }
  var_6 = getanimlength(var_2._id_25A8);
  var_7 = gettime() + var_6 * 1000;
  wait(var_6 * var_5);
  var_8 = (0, 0, 1);
  var_9 = var_0.origin;

  if(getDvar("ragdoll_enable") == "0") {
    var_0 delete();
    return;
  }

  if(isai(var_0)) {
    var_0 animscripts\shared::_id_0D73();
  } else {
    _id_25C8(var_0, "weapon_");
  }
  while(!var_0 isragdoll() && gettime() < var_7) {
    var_9 = var_0.origin;
    wait 0.05;
    var_8 = var_0.origin - var_9;
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

  if(!var_0 isragdoll()) {
    var_0 delete();
  }
}

_id_25C1(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }
  var_2 = spawn("script_model", var_0.origin);
  var_2.angles = var_0.angles;
  var_2 setModel(var_0.model);
  var_3 = var_0 getattachsize();

  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_2 attach(var_0 getattachmodelname(var_4), var_0 getattachtagname(var_4));
  }
  var_2 useanimtree(#animtree);

  if(isDefined(var_0.team)) {
    var_2.team = var_0.team;
  }
  if(!var_1) {
    var_0 delete();
  }
  var_2 makefakeai();
  return var_2;
}

_id_25C2(var_0, var_1) {
  self useanimtree(var_1);
  self setanim(var_0);
}

_id_25C3(var_0) {
  var_1 = _id_2534(self, var_0);
  return _id_25C4(var_1._id_2519, var_1._id_24F2, var_0);
}

_id_25C4(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_4 = undefined;
  var_5 = undefined;
  var_6 = self gettagorigin(var_1);
  var_7 = self gettagangles(var_1);
  var_4 = getstartorigin(var_6, var_7, var_0);
  var_5 = getstartangles(var_6, var_7, var_0);
  var_3.origin = var_4;
  var_3.angles = var_5;
  var_3._id_2252 = var_2;
  return var_3;
}

_id_25C5(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    return 1;
  }
  var_3 = var_0.classname;

  if(maps\_utility::_id_1E25()) {
    var_3 = var_0.vehicletype;
  }
  var_4 = level._id_2566[var_3][var_2];

  foreach(var_6 in var_4) {
    if(var_6 == var_1) {
      return 1;
    }
  }

  return 0;
}

_id_25C6(var_0) {
  if(maps\_utility::_id_1E25()) {
    var_1 = level._id_24E6[self.vehicletype];
  } else {
    var_1 = level._id_24E6[self.classname];
  }
  var_2 = [];
  var_3 = [];

  for(var_4 = 0; var_4 < self._id_24E8.size; var_4++) {
    if(self._id_24E8[var_4]) {
      continue;
    }
    if(isDefined(var_1[var_4]._id_2519) && _id_25C5(self, var_4, var_0)) {
      var_2[var_2.size] = _id_25C3(var_4);
      continue;
    }

    var_3[var_3.size] = var_4;
  }

  var_5 = spawnStruct();
  var_5._id_251C = var_2;
  var_5._id_251D = var_3;
  return var_5;
}

_id_25C7() {
  if(isDefined(self.modeldummy)) {
    return self.modeldummy;
  } else {
    return self;
  }
}

_id_25C8(var_0, var_1) {
  var_2 = var_0 getattachsize();
  var_3 = [];
  var_4 = [];
  var_5 = 0;

  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_7 = var_0 getattachmodelname(var_6);
    var_8 = var_0 getattachtagname(var_6);

    if(issubstr(var_7, var_1)) {
      var_3[var_5] = var_7;
      var_4[var_5] = var_8;
    }
  }

  for(var_6 = 0; var_6 < var_3.size; var_6++) {
    var_0 detach(var_3[var_6], var_4[var_6]);
  }
}

_id_25C9() {
  if(!isai(self)) {
    return 0;
  }
  if(!isDefined(self._id_24EB)) {
    return 0;
  }
  return !isDefined(self._id_0D04);
}

_id_25CA(var_0, var_1) {
  return isDefined(_id_2534(self, var_1)._id_25CB);
}

_id_25CC(var_0, var_1) {
  var_2 = _id_2534(self, var_1);

  if(!isDefined(var_2._id_25CB)) {
    return;
  }
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");
  _id_259E(var_0, var_2._id_24F2, var_2._id_25CB);

  for(;;) {
    _id_259E(var_0, var_2._id_24F2, var_2._id_25CD);
  }
}

_id_25CE(var_0, var_1) {
  var_2 = _id_2534(self, var_1);

  if(!isDefined(var_2._id_25CF)) {
    return;
  }
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");

  for(;;) {
    _id_259E(var_0, var_2._id_24F2, var_2._id_25CF);
  }
}

_id_25D0(var_0, var_1) {
  return isDefined(_id_2534(self, var_1)._id_25CF);
}

_id_25D1(var_0, var_1) {
  var_2 = _id_2534(self, var_1);

  if(!isDefined(var_2._id_25CF)) {
    return;
  }
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");
  _id_259E(var_0, var_2._id_24F2, var_2._id_25D2);
  thread _id_2549(var_0, var_1);
}

_id_25D3(var_0, var_1) {
  return isDefined(_id_2534(self, var_1)._id_25D2);
}

_id_25D4(var_0) {
  self waittill("stable_for_unlink");

  if(isalive(var_0)) {
    var_0 unlink();
  }
}

_id_25D5() {}

_id_25D6(var_0) {
  var_1 = [];

  foreach(var_3 in self._id_0A39) {
    if(!isalive(var_3)) {
      continue;
    }
    if(isDefined(level._id_2538[var_0]) && ![[level._id_2538[var_0]]](var_3, var_3._id_2252)) {
      continue;
    }
    if(isDefined(level._id_2537[var_0])) {
      var_3 notify("newanim");
      var_3._id_25D7 = [];
      thread[[level._id_2537[var_0]]](var_3, var_3._id_2252);
      var_1[var_1.size] = var_3;
      continue;
    }
  }

  return var_1;
}

_id_25D8() {
  self._id_2251 = undefined;
  self._id_2253 = undefined;
  self._id_2252 = undefined;
  self.delay = undefined;
}

_id_25D9() {
  var_0 = self getcentroid();
  var_1 = self getpointinbounds(1, 0, 0);
  var_2 = distance(var_1, var_0);
  var_3 = getcorpsearray();

  foreach(var_5 in var_3) {
    if(distance(var_5.origin, var_0) < var_2) {
      var_5 delete();
    }
  }
}