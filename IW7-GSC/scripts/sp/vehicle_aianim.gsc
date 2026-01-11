/*****************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\vehicle_aianim.gsc
*****************************************/

func_8739(param_00, param_01) {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.var_380)) {
    return;
  }

  var_02 = self.classname;
  var_03 = level.vehicle.var_116CE.var_1A03[var_02];
  self.var_247C[self.var_247C.size] = param_00;
  var_04 = func_F554(param_00, var_03);
  if(!isDefined(var_04)) {
    return;
  }

  if(var_04 == 0) {
    param_00.var_5BD6 = 1;
  }

  var_05 = func_1F00(self, var_04);
  self.var_1307E[var_04] = 1;
  param_00.var_1321D = var_04;
  param_00.var_131F5 = 0;
  if(isDefined(var_05.delay)) {
    param_00.delay = var_05.delay;
    if(isDefined(var_05.var_510B)) {
      self.var_5107 = param_00.delay;
    }
  }

  if(isDefined(var_05.var_510B)) {
    self.var_5107 = self.var_5107 + var_05.var_510B;
    param_00.delay = self.var_5107;
  }

  param_00.var_E500 = self;
  param_00.var_C6F8 = param_00.health;
  param_00.var_131F2 = var_05.var_92CC;
  param_00.var_13240 = var_05.var_10B69;
  param_00.var_4E2A = var_05.var_E6;
  param_00.var_4E2E = var_05.var_4E5E;
  param_00.var_10B71 = 0;
  param_00.var_30 = 0;
  if(isDefined(param_00.var_4E2A) && !isDefined(param_00.var_B14F) && vehicle_allows_driver_death()) {
    if(param_00.var_1321D != 0 || vehicle_all_stop_func()) {
      param_00.var_30 = !isDefined(param_00.var_ECED) || param_00.var_ECED;
      if(isDefined(var_05.var_4E14)) {
        param_00.noragdoll = var_05.var_4E14;
      }
    }
  }

  if(param_00.classname == "script_model") {
    if(isDefined(var_05.var_E6) && param_00.var_30 && !isDefined(param_00.var_ECED) || param_00.var_ECED) {
      thread func_8730(param_00, var_05);
    }
  }

  if(!isDefined(param_00.var_131F2)) {
    param_00.var_30 = 1;
  }

  self.var_E4FB[self.var_E4FB.size] = param_00;
  if(param_00.classname != "script_model" && scripts\sp\utility::func_106ED(param_00)) {
    return;
  }

  var_06 = self gettagorigin(var_05.var_10220);
  var_07 = self gettagangles(var_05.var_10220);
  func_AD14(param_00, var_05.var_10220, var_05.var_10221, var_05.var_AD46);
  if(isai(param_00)) {
    param_00 _meth_83B9(var_06, var_07);
    param_00.a.disablelongdeath = 1;
    if(isDefined(var_05.var_2AB6) && !var_05.var_2AB6) {
      param_00 scripts\sp\utility::func_86E4();
    }

    if(func_8755(var_05)) {
      thread func_874C(param_00, var_04, param_01);
    }
  } else {
    if(isDefined(var_05.var_2AB6) && !var_05.var_2AB6) {
      func_538C(param_00, "weapon_");
    }

    param_00.origin = var_06;
    param_00.angles = var_07;
  }

  if(var_04 == 0 && isDefined(var_03[0].var_E6)) {
    thread func_5BCE(param_00);
  }

  self notify("guy_entered", param_00, var_04);
  thread func_8743(param_00, var_04);
  if(isDefined(var_05.var_E4FA)) {
    param_00[[var_05.var_E4FA]]();
    return;
  }

  if(isDefined(var_05.var_7F14)) {
    thread[[var_05.var_7F14]](param_00, var_04);
    return;
  }

  thread func_8744(param_00, var_04);
}

vehicle_all_stop_func() {
  if(!isDefined(self.var_ECEB)) {
    return 0;
  }

  return self.var_ECEB;
}

vehicle_allows_driver_death() {
  if(!isDefined(self.var_ECEC)) {
    return 1;
  }

  return self.var_ECEC;
}

func_8755(param_00) {
  if(!isDefined(param_00.mgturret)) {
    return 0;
  }

  if(!isDefined(self.var_EE5E)) {
    return 1;
  }

  return !self.var_EE5E;
}

func_88AE() {
  var_00 = self.classname;
  self.var_247C = [];
  if(!isDefined(level.vehicle.var_116CE.var_1A03) && isDefined(level.vehicle.var_116CE.var_1A03[var_00])) {
    return;
  }

  var_01 = level.vehicle.var_116CE.var_1A03[var_00].size;
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "ai_wait_go") {
    thread func_19F9();
  }

  self.var_E880 = [];
  self.var_1307E = [];
  self.var_7F1A = [];
  self.var_5107 = 0;
  var_02 = level.vehicle.var_116CE.var_1A03[var_00];
  for(var_03 = 0; var_03 < var_01; var_03++) {
    self.var_1307E[var_03] = 0;
    if(isDefined(self.var_EE5E) && self.var_EE5E && isDefined(var_02[var_03].var_2B10) && var_02[var_03].var_2B10) {
      self.var_1307E[1] = 1;
    }
  }
}

func_ADA8(param_00) {
  func_ADA7(param_00, 1);
}

func_8730(param_00, param_01) {
  waittillframeend;
  param_00 setCanDamage(1);
  param_00 endon("death");
  param_00.var_30 = 0;
  param_00.health = 10150;
  if(isDefined(param_00.var_EEC8)) {
    param_00.health = param_00.health + param_00.var_EEC8;
  }

  param_00 endon("jumping_out");
  if(isDefined(param_00.var_B14F) && param_00.var_B14F) {
    while(isDefined(param_00.var_B14F) && param_00.var_B14F) {
      wait(0.05);
    }
  }

  while(param_00.health > 10000) {
    param_00 waittill("damage");
  }

  thread func_8732(param_00, param_01);
}

func_8732(param_00, param_01) {
  var_02 = gettime() + getanimlength(param_01.var_E6) * 1000;
  var_03 = param_00.angles;
  var_04 = param_00.origin;
  param_00 = func_45EE(param_00);
  [[level.vehicle_canturrettargetpoint]]("MOD_RIFLE_BULLET", "torso_upper", var_04);
  func_538C(param_00, "weapon_");
  param_00 linkto(self);
  param_00 notsolid();
  param_00 give_attacker_kill_rewards(param_01.var_E6);
  if(isai(param_00)) {
    param_00 scripts\anim\shared::func_5D1A();
  } else {
    func_538C(param_00, "weapon_");
  }

  if(isDefined(param_01.var_4E00)) {
    param_00 unlink();
    if(isDefined(param_00.var_71C8)) {
      param_00[[param_00.var_71C8]]();
    }

    param_00 giverankxp();
    wait(param_01.var_4E00);
    param_00 delete();
  }
}

func_ADA7(param_00, param_01, param_02) {
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  scripts\sp\utility::func_65DD("unloaded");
  scripts\sp\utility::func_65DD("loaded");
  scripts\engine\utility::array_levelthread(param_00, ::func_7A35, param_01, param_02);
}

func_9CA7(param_00) {
  for(var_01 = 0; var_01 < self.var_E4FB.size; var_01++) {
    if(self.var_E4FB[var_01] == param_00) {
      return 1;
    }
  }

  return 0;
}

func_7A35(param_00, param_01, param_02) {
  if(func_9CA7(param_00)) {
    return;
  }

  if(!func_88D2()) {
    return;
  }

  func_8752(param_00, self, param_01, param_02);
}

func_88D2() {
  if(func_131EE()) {
    return 1;
  }
}

func_131EE() {
  if(level.vehicle.var_116CE.var_1A03[self.classname].size - self.var_E880.size) {
    return 1;
  }

  return 0;
}

func_8754(param_00, param_01) {
  param_01 endon("death");
  param_01 endon("stop_loading");
  var_02 = param_00 scripts\engine\utility::waittill_any_return("long_death", "death", "enteredvehicle");
  if(var_02 != "enteredvehicle" && isDefined(param_00.var_72AE)) {
    param_01.var_1307E[param_00.var_72AE] = 0;
  }

  param_01.var_E880 = scripts\engine\utility::array_remove(param_01.var_E880, param_00);
  func_13211(param_01);
}

func_13211(param_00) {
  if(isDefined(param_00.var_380) && isDefined(param_00.var_13212)) {
    if(param_00.var_E4FB.size == param_00.var_13212) {
      param_00 scripts\sp\utility::func_65E1("loaded");
      return;
    }

    return;
  }

  if(!param_00.var_E880.size && param_00.var_E4FB.size) {
    if(param_00.var_1307E[0]) {
      param_00 scripts\sp\utility::func_65E1("loaded");
      return;
    }

    param_00 thread func_1321F();
    return;
  }
}

func_1321F() {
  var_00 = self.var_E4FB;
  scripts\sp\vehicle::func_13253();
  scripts\sp\utility::func_65E3("unloaded");
  var_00 = scripts\sp\utility::func_22B9(var_00);
  thread scripts\sp\vehicle::func_1320F(var_00);
}

func_E054(param_00) {
  scripts\engine\utility::waittill_any_3("unload", "death");
  param_00 scripts\sp\utility::func_1101B();
}

func_8752(param_00, param_01, param_02, param_03) {
  param_01 endon("stop_loading");
  var_04 = 1;
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  var_05 = level.vehicle.var_116CE.var_1A03[param_01.classname];
  if(isDefined(param_01.var_E8A8)) {
    param_01 thread[[param_01.var_E8A8]](param_00);
    return;
  }

  param_01 endon("death");
  param_00 endon("death");
  param_01.var_E880[param_01.var_E880.size] = param_00;
  thread func_8754(param_00, param_01);
  var_06 = [];
  var_07 = undefined;
  var_08 = 0;
  var_09 = 0;
  for(var_0A = 0; var_0A < var_05.size; var_0A++) {
    if(isDefined(var_05[var_0A].var_7F12)) {
      var_09 = 1;
    }
  }

  if(!var_09) {
    param_00 notify("enteredvehicle");
    param_01 func_8739(param_00, var_04);
    return;
  }

  if(!isDefined(param_00.var_7A34)) {
    while(param_01 vehicle_getspeed() > 1) {
      wait(0.05);
    }
  }

  var_0B = param_01 func_7851(param_03);
  if(isDefined(param_00.var_EEC9)) {
    var_07 = param_01 func_131E5(param_00.var_EEC9);
  } else if(!param_01.var_1307E[0]) {
    var_07 = param_01 func_131E5(0);
    if(param_02) {
      param_00 thread scripts\sp\utility::func_B14F();
      thread func_E054(param_00);
    }
  } else if(var_0B.var_26A3.size) {
    var_07 = scripts\engine\utility::getclosest(param_00.origin, var_0B.var_26A3);
  } else {
    var_07 = undefined;
  }

  if(!var_0B.var_26A3.size && var_0B.var_C07E.size) {
    param_00 notify("enteredvehicle");
    param_01 func_8739(param_00, var_04);
    return;
  } else if(!isDefined(var_07)) {
    return;
  }

  var_08 = var_07.origin;
  var_0C = var_07.angles;
  param_00.var_72AE = var_07.var_1321D;
  param_01.var_1307E[var_07.var_1321D] = 1;
  param_00.var_EE2B = 1;
  param_00 notify("stop_going_to_node");
  param_00 scripts\sp\utility::func_F3BC();
  param_00 scripts\sp\utility::func_5504();
  param_00.objective_playermask_showto = 16;
  param_00 give_mp_super_weapon(var_08);
  param_00 waittill("goal");
  param_00 scripts\sp\utility::func_61DB();
  param_00 scripts\sp\utility::func_12BFA();
  param_00 notify("boarding_vehicle");
  var_0D = func_1F00(param_01, var_07.var_1321D);
  if(isDefined(var_0D.delay)) {
    param_00.delay = var_0D.delay;
    if(isDefined(var_0D.var_510B)) {
      self.var_5107 = param_00.delay;
    }
  }

  if(isDefined(var_0D.var_510B)) {
    self.var_5107 = self.var_5107 + var_0D.var_510B;
    param_00.delay = self.var_5107;
  }

  param_01 func_AD14(param_00, var_0D.var_10220, var_0D.var_10221, var_0D.var_AD46);
  param_00.var_30 = 0;
  var_0D = var_05[var_07.var_1321D];
  if(isDefined(var_07)) {
    if(isDefined(var_0D.var_131E1)) {
      if(isDefined(var_0D.var_131E6)) {
        var_0E = isDefined(param_00.var_C01A);
        if(!var_0E) {
          param_01 clearanim(var_0D.var_131E6, 0);
        }
      }

      param_01 = param_01 func_7DC5();
      param_01 thread func_F642(var_0D.var_131E1, var_0D.var_131E2);
      level thread scripts\sp\anim::func_10CBF(param_01, "vehicle_anim_flag", undefined, undefined, var_0D.var_131E1);
    }

    if(isDefined(var_0D.var_131E4)) {
      var_08 = param_01 gettagorigin(var_0D.var_131E4);
    } else {
      var_08 = param_01.origin;
    }

    if(isDefined(var_0D.var_131E3)) {
      playworldsound(var_0D.var_131E3, var_08);
    }

    var_0F = undefined;
    var_10 = undefined;
    if(isDefined(var_0D.var_7F13)) {
      var_0F = [];
      var_0F[0] = var_0D.var_7F13;
      var_10 = [];
      var_10[0] = ::func_6623;
      param_01 func_AD14(param_00, var_0D.var_10220, var_0D.var_10221, var_0D.var_AD46);
    }

    param_01 func_1FC2(param_00, var_0D.var_10220, var_0D.var_7F12, var_0F, var_10);
  }

  param_00 notify("enteredvehicle");
  param_01 func_8739(param_00, var_04);
}

func_6623() {
  self notify("enteredvehicle");
}

func_5BCE(param_00) {
  if(scripts\sp\vehicle::func_9E2C()) {
    return;
  }

  self.var_5BC8 = param_00;
  self endon("death");
  param_00 endon("jumping_out");
  param_00 waittill("death");
  if(isDefined(self.var_131F9)) {
    return;
  }

  self notify("driver dead");
  self.var_4DEF = 1;
  if(isDefined(self.var_8C2D) && self.var_8C2D) {
    self setwaitspeed(0);
    self vehicle_setspeed(0, 10);
    self waittill("reached_wait_speed");
  }

  scripts\sp\vehicle::func_13253();
}

func_872C(param_00, param_01) {
  if(isai(param_00)) {
    return param_00;
  }

  if(param_00.var_5BF2 == 1) {
    param_00 delete();
    return;
  }

  param_00 = lib_0B77::func_10869(param_00);
  var_02 = self.classname;
  var_03 = level.vehicle.var_116CE.var_1A03[var_02].size;
  var_04 = func_1F00(self, param_01);
  func_AD14(param_00, var_04.var_10220, var_04.var_10221, var_04.var_AD46);
  param_00.var_131F2 = var_04.var_92CC;
  thread func_8744(param_00, param_01);
  return param_00;
}

func_AD14(param_00, param_01, param_02, param_03) {
  if(!isDefined(param_02)) {
    param_02 = (0, 0, 0);
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  if(param_03 && !isDefined(param_00.var_ED6E)) {
    param_00 linktoblendtotag(self, param_01, 0);
    return;
  }

  param_00 linkto(self, param_01, param_02, (0, 0, 0));
}

func_1F00(param_00, param_01) {
  return level.vehicle.var_116CE.var_1A03[param_00.classname][param_01];
}

func_8731(param_00, param_01) {
  param_00 waittill("death");
  if(!isDefined(self)) {
    return;
  }

  self.var_E4FB = scripts\engine\utility::array_remove(self.var_E4FB, param_00);
  self.var_1307E[param_01] = 0;
}

func_F8AE() {
  if(!isDefined(level.vehicle.var_1A04)) {
    level.vehicle.var_1A04 = [];
  }

  if(!isDefined(level.vehicle.var_1A02)) {
    level.vehicle.var_1A02 = [];
  }

  level.vehicle.var_1A04["idle"] = ::func_8744;
  level.vehicle.var_1A04["unload"] = ::func_8766;
}

func_8743(param_00, param_01) {
  param_00.var_131F5 = 1;
  thread func_8731(param_00, param_01);
}

func_5BC9(param_00, param_01) {
  param_00 endon("newanim");
  self endon("death");
  param_00 endon("death");
  var_02 = func_1F00(self, param_01);
  for(;;) {
    if(self vehicle_getspeed() == 0) {
      param_00.var_131F2 = var_02.var_92D5;
    } else {
      param_00.var_131F2 = var_02.var_92D0;
    }

    wait(0.25);
  }
}

func_8744(param_00, param_01, param_02) {
  param_00 endon("newanim");
  if(!isDefined(param_02)) {
    self endon("death");
  }

  param_00 endon("death");
  param_00.var_131F5 = 1;
  param_00 notify("gotime");
  if(!isDefined(param_00.var_131F2)) {
    return;
  }

  var_03 = func_1F00(self, param_01);
  if(isDefined(var_03.mgturret)) {
    return;
  }

  if(isDefined(var_03.var_92D5) && isDefined(var_03.var_92D0)) {
    thread func_5BC9(param_00, param_01);
  }

  for(;;) {
    param_00 notify("idle");
    func_CDAA(param_00, var_03);
  }
}

func_CDAA(param_00, param_01) {
  if(isDefined(param_00.var_131F3)) {
    func_1FC2(param_00, param_01.var_10220, param_00.var_131F3);
    return;
  }

  if(isDefined(param_01.var_92F6)) {
    var_02 = func_DCBF(param_00, param_01.var_92F6);
    func_1FC2(param_00, param_01.var_10220, param_00.var_131F2[var_02]);
    return;
  }

  if(isDefined(param_01.var_D3E2) && isDefined(var_02.var_D0E8)) {
    func_1FC2(param_01, var_02.var_10220, var_02.var_D0E8);
    return;
  }

  if(isDefined(var_02.var_131F2)) {
    thread func_F642(var_02.var_131F2);
  }

  func_1FC2(param_01, var_02.var_10220, param_01.var_131F2);
}

func_DCBF(param_00, param_01) {
  var_02 = [];
  var_03 = 0;
  for(var_04 = 0; var_04 < param_01.size; var_04++) {
    var_03 = var_03 + param_01[var_04];
    var_02[var_04] = var_03;
  }

  var_05 = randomint(var_03);
  for(var_04 = 0; var_04 < param_01.size; var_04++) {
    if(var_05 < var_02[var_04]) {
      return var_04;
    }
  }
}

func_876A(param_00) {
  self endon("death");
  self.var_12BD0 = scripts\engine\utility::array_add(self.var_12BD0, param_00);
  param_00 scripts\engine\utility::waittill_any_3("death", "jumpedout");
  self.var_12BD0 = scripts\engine\utility::array_remove(self.var_12BD0, param_00);
  if(!self.var_12BD0.size) {
    scripts\sp\utility::func_65E1("unloaded");
    self.var_12BBC = "default";
  }
}

func_E4FC(param_00) {
  if(!self.var_E4FB.size) {
    return 0;
  }

  for(var_01 = 0; var_01 < self.var_E4FB.size; var_01++) {
    if(!isalive(self.var_E4FB[var_01]) && !isDefined(self.var_E4FB[var_01].var_9FEF)) {
      continue;
    }

    if(func_3DD9(self.var_E4FB[var_01].var_1321D, param_00)) {
      return 1;
    }
  }

  return 0;
}

func_7D2F() {
  var_00 = [];
  var_01 = [];
  var_02 = "default";
  if(isDefined(self.var_12BBC)) {
    var_02 = self.var_12BBC;
  }

  var_01 = level.vehicle.var_116CE.var_12BCF[self.classname][var_02];
  if(!isDefined(var_01)) {
    var_01 = level.vehicle.var_116CE.var_12BCF[self.classname]["default"];
  }

  foreach(var_04 in var_01) {
    var_00[var_04] = var_04;
  }

  return var_00;
}

func_3DD9(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = self.var_12BBC;
  }

  var_02 = self.classname;
  if(!isDefined(level.vehicle.var_116CE.var_12BCF[var_02])) {
    return 1;
  }

  if(!isDefined(level.vehicle.var_116CE.var_12BCF[var_02][param_01])) {
    return 1;
  }

  var_03 = level.vehicle.var_116CE.var_12BCF[var_02][param_01];
  for(var_04 = 0; var_04 < var_03.size; var_04++) {
    if(param_00 == var_03[var_04]) {
      return 1;
    }
  }

  return 0;
}

botgetscriptgoalradius(param_00, param_01, param_02) {
  self endon("unloading");
  func_1FC2(param_00, param_01, param_02);
}

botgetscriptgoalnode(param_00, param_01, param_02, param_03, param_04) {
  var_05 = self.classname;
  if(param_04) {
    thread botgetscriptgoalradius(param_01, param_02, level.vehicle.var_116CE.var_247D[var_05][param_00.var_6B9D].var_92F3);
    self waittill("unloading");
  }

  self.var_12BD0 = scripts\engine\utility::array_add(self.var_12BD0, param_01);
  thread botgetpathdist(param_01, param_02, param_03);
  if(!isDefined(self.var_4828)) {
    func_1FC2(param_01, param_02, param_03);
  }

  param_01 unlink();
  if(!isDefined(self)) {
    param_01 delete();
    return;
  }

  self.var_12BD0 = scripts\engine\utility::array_remove(self.var_12BD0, param_01);
  if(!self.var_12BD0.size) {
    self notify("unloaded");
  }

  self.var_6B9D[param_00.var_6B9D] = undefined;
  wait(10);
  param_01 delete();
}

botgetscriptgoal() {
  wait(0.05);
  while(isalive(self) && self.var_12BD0.size > 2) {
    wait(0.05);
  }

  if(!isalive(self) || isDefined(self.var_4828) && self.var_4828) {
    return;
  }

  self notify("getoutrig_disable_abort");
}

botgetpersonality() {
  self endon("end_getoutrig_abort_while_deploying");
  while(!isDefined(self.var_4828)) {
    wait(0.05);
  }

  var_00 = [];
  foreach(var_02 in self.var_E4FB) {
    if(isalive(var_02)) {
      scripts\engine\utility::array_add_safe(var_00, var_02);
    }
  }

  scripts\sp\utility::func_228A(var_00);
  self notify("crashed_while_deploying");
  var_00 = undefined;
}

botgetpathdist(param_00, param_01, param_02) {
  var_03 = getanimlength(param_02);
  var_04 = var_03 - 1;
  if(self.var_380 == "mi17") {
    var_04 = var_03 - 0.5;
  }

  var_05 = 2.5;
  self endon("getoutrig_disable_abort");
  thread botgetscriptgoal();
  thread botgetpersonality();
  scripts\engine\utility::waittill_notify_or_timeout("crashed_while_deploying", var_05);
  self notify("end_getoutrig_abort_while_deploying");
  while(!isDefined(self.var_4828)) {
    wait(0.05);
  }

  thread func_1FC2(param_00, param_01, param_02);
  waittillframeend;
  param_00 _meth_82B0(param_02, var_04 / var_03);
  var_06 = self;
  if(isDefined(self.var_C720)) {
    var_06 = self.var_C720;
  }

  for(var_07 = 0; var_07 < self.var_E4FB.size; var_07++) {
    if(!isDefined(self.var_E4FB[var_07])) {
      continue;
    }

    if(!isDefined(self.var_E4FB[var_07].var_DC19)) {
      continue;
    }

    if(self.var_E4FB[var_07].var_DC19 != 1) {
      continue;
    }

    if(!isDefined(self.var_E4FB[var_07].var_E500)) {
      continue;
    }

    self.var_E4FB[var_07].var_72C4 = 1;
    if(isalive(self.var_E4FB[var_07])) {
      thread func_1FC4(self.var_E4FB[var_07], self, var_06);
    }
  }
}

func_F642(param_00, param_01) {
  self endon("death");
  self endon("dont_clear_anim");
  if(!isDefined(param_01)) {
    param_01 = 1;
  }

  var_02 = getanimlength(param_00);
  self endon("death");
  self _meth_82EA("vehicle_anim_flag", param_00);
  wait(var_02);
  if(param_01) {
    self clearanim(param_00, 0);
  }
}

botgetfovdot(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  var_03 = self.classname;
  var_04 = func_1F00(self, param_01);
  if(isDefined(self.var_2465) && isDefined(self.var_2465[var_04.var_6B9D])) {
    var_05 = 1;
  } else {
    var_05 = 0;
  }

  if(!isDefined(var_04.var_6B9D) || isDefined(self.var_6B9D[var_04.var_6B9D]) || var_05) {
    return;
  }

  var_06 = param_00 gettagorigin(level.vehicle.var_116CE.var_247D[var_03][var_04.var_6B9D].physics_setgravitydynentscalar);
  var_07 = param_00 gettagangles(level.vehicle.var_116CE.var_247D[var_03][var_04.var_6B9D].physics_setgravitydynentscalar);
  self.var_6B9E[var_04.var_6B9D] = 1;
  var_08 = spawn("script_model", var_06);
  var_08.angles = var_07;
  var_08.origin = var_06;
  var_08 setModel(level.vehicle.var_116CE.var_247D[var_03][var_04.var_6B9D].model);
  self.var_6B9D[var_04.var_6B9D] = var_08;
  var_08 glinton(#animtree);
  var_08 linkto(param_00, level.vehicle.var_116CE.var_247D[var_03][var_04.var_6B9D].physics_setgravitydynentscalar, (0, 0, 0), (0, 0, 0));
  thread botgetscriptgoalnode(var_04, var_08, level.vehicle.var_116CE.var_247D[var_03][var_04.var_6B9D].physics_setgravitydynentscalar, level.vehicle.var_116CE.var_247D[var_03][var_04.var_6B9D].var_5D1B, param_02);
  return var_08;
}

func_3DCC(param_00) {
  if(!isDefined(self.var_10471)) {
    self.var_10471 = [];
  }

  var_01 = 0;
  if(!isDefined(self.var_10471[param_00])) {
    self.var_10471[param_00] = 1;
  } else {
    var_01 = 1;
  }

  thread func_3DCD(param_00);
  return var_01;
}

func_3DCD(param_00) {
  wait(0.05);
  if(!isDefined(self)) {
    return;
  }

  self.var_10471[param_00] = 0;
  var_01 = getarraykeys(self.var_10471);
  for(var_02 = 0; var_02 < var_01.size; var_02++) {
    if(self.var_10471[var_01[var_02]]) {
      return;
    }
  }

  self.var_10471 = undefined;
}

func_8766(param_00, param_01) {
  var_02 = 0;
  if(isDefined(param_00.var_9FEF)) {
    var_02 = 1;
  }

  var_03 = func_1F00(self, param_01);
  var_04 = self.var_380;
  if(!func_3DD9(param_01)) {
    thread func_8744(param_00, param_01);
    return;
  }

  if(!isDefined(var_03.botclearscriptgoal)) {
    thread func_8744(param_00, param_01);
    return;
  }

  thread func_876A(param_00);
  self endon("death");
  if(isai(param_00) && isalive(param_00)) {
    param_00 endon("death");
  }

  var_05 = 0;
  if(isDefined(param_00.autoboltmissileeffects)) {
    var_06 = param_00[[param_00.autoboltmissileeffects]]();
    if(isDefined(var_06) && var_06) {
      var_05 = 1;
    }
  }

  if(isDefined(param_00.var_C584)) {
    param_00.var_C584 = undefined;
    if(isDefined(param_00.autoboltmissileeffects)) {
      param_00[[param_00.autoboltmissileeffects]]();
    }
  }

  var_07 = func_7DC5();
  if(isDefined(var_03.var_131E6)) {
    var_07 thread func_F642(var_03.var_131E6, var_03.var_131E7);
    var_08 = 0;
    if(isDefined(var_03.var_131E9)) {
      var_08 = func_3DCC(var_03.var_131E9);
      var_09 = var_07 gettagorigin(var_03.var_131E9);
    } else {
      var_09 = var_08.origin;
    }

    if(isDefined(var_03.var_131E8) && !var_08) {
      playworldsound(var_03.var_131E8, var_09);
    }

    var_08 = undefined;
  }

  var_0A = 0;
  if(isDefined(var_03.botgetnearestnode)) {
    var_0A = var_0A + getanimlength(var_03.botgetnearestnode);
  }

  if(isDefined(var_03.delay)) {
    var_0A = var_0A + var_03.delay;
  }

  if(isDefined(param_00.delay)) {
    var_0A = var_0A + param_00.delay;
  }

  if(var_0A > 0) {
    thread func_8744(param_00, param_01);
    wait(var_0A);
  }

  param_00.var_4E2A = undefined;
  param_00.var_4E2E = undefined;
  param_00 notify("newanim");
  if(isDefined(var_03.var_2AB6) && !var_03.var_2AB6) {
    if(!isDefined(param_00.var_5531)) {
      param_00 scripts\sp\utility::func_86E2();
    }
  }

  if(isai(param_00)) {
    param_00 _meth_8250(1);
  }

  if(isDefined(var_03.var_2BE8)) {
    var_05 = 1;
  } else if(!isDefined(var_03.botclearscriptgoal) || !isDefined(self.var_EEFD) && isDefined(var_03.var_2B10) && var_03.var_2B10 || isDefined(self.var_EDF4) && param_01 == 0) {
    thread func_8744(param_00, param_01);
    return;
  }

  if(param_00 func_FF4D()) {
    param_00.health = param_00.var_C6F8;
  }

  param_00.var_C6F8 = undefined;
  if(isai(param_00) && isalive(param_00)) {
    param_00 endon("death");
  }

  param_00.var_30 = 0;
  if(isDefined(var_03.var_6981)) {
    var_0B = var_03.var_6981;
  } else {
    var_0B = var_04.var_10220;
  }

  if(isDefined(param_00.var_7B54)) {
    var_0C = param_00.var_7B54;
  } else if(scripts\sp\utility::func_65DB("landed") && isDefined(var_04.botgetentrancepoint)) {
    var_0C = var_04.botgetentrancepoint;
  } else if(isDefined(param_01.var_D3E2) && isDefined(var_04.var_D098)) {
    var_0C = var_04.var_D098;
  } else {
    var_0C = var_04.botclearscriptgoal;
  }

  if(!var_05) {
    thread func_8765(param_00);
    if(isDefined(var_03.var_6B9D)) {
      if(!isDefined(self.var_6B9D[var_03.var_6B9D])) {
        thread func_8744(param_00, param_01);
        var_0D = botgetfovdot(var_07, param_00.var_1321D, 0);
      }
    }

    if(isDefined(var_03.botgetscriptgoaltype)) {
      param_00 thread scripts\sp\utility::play_sound_on_tag(var_03.botgetscriptgoaltype, "J_Wrist_RI", 1);
    }

    if(isDefined(param_00.var_D3E2) && isDefined(var_03.var_D099)) {
      param_00 thread scripts\sp\utility::play_sound_on_entity(var_03.var_D099);
    }

    if(isDefined(var_03.botgetnodesonpath)) {
      param_00 thread scripts\sp\utility::play_loop_sound_on_tag(var_03.botgetnodesonpath);
    }

    if(isDefined(param_00.var_D3E2) && isDefined(var_03.var_D09B)) {
      level.player thread scripts\engine\utility::play_loop_sound_on_entity(var_03.var_D09B);
    }

    param_00 notify("newanim");
    param_00 notify("jumping_out");
    var_0E = 0;
    if(!isai(param_00) && !var_02) {
      var_0E = 1;
    }

    if(!isDefined(param_00.var_EECD) && !var_02) {
      param_00 = func_872C(param_00, param_01);
    }

    if(!isalive(param_00) && !var_02) {
      return;
    }

    if(!var_02) {
      param_00.var_DC19 = 1;
    }

    if(isDefined(var_03.var_DC19)) {
      param_00.var_DC19 = 1;
      if(isDefined(var_03.var_DC17)) {
        param_00.var_DC17 = var_03.var_DC17;
      }
    }

    if(var_0E) {
      self.var_E4FB = scripts\engine\utility::array_add(self.var_E4FB, param_00);
      thread func_8731(param_00, param_01);
      thread func_876A(param_00);
      param_00.var_E500 = self;
    }

    if(isai(param_00)) {
      param_00 endon("death");
    }

    param_00 notify("newanim");
    param_00 notify("jumping_out");
    if(isDefined(var_03.var_AD88) && var_03.var_AD88) {
      thread func_10B38(param_00);
    }

    if(isDefined(var_03.botgetimperfectenemyinfo)) {
      func_1FC2(param_00, var_0B, var_0C);
      var_0F = var_0B;
      if(isDefined(var_03.botgetmemoryevents)) {
        var_0F = var_03.botgetmemoryevents;
      }

      func_1FC2(param_00, var_0F, var_03.botgetimperfectenemyinfo);
    } else {
      var_10 = 0;
      if(isDefined(var_03.botgetdifficultysetting) && isDefined(var_03.botgetdifficulty)) {
        thread func_8767(param_00, var_0B, var_03.botclearscriptgoal, var_03.botgetdifficultysetting, var_03.botgetdifficulty);
        var_10 = 1;
      } else if(!var_02) {
        param_00.var_1EB4 = 1;
      }

      func_1FC2(param_00, var_0B, var_0C);
      if(var_10) {
        param_00 waittill("hoverunload_done");
      }
    }

    if(isDefined(param_00.var_D3E2) && isDefined(var_03.var_D09B)) {
      level.player thread scripts\engine\utility::stop_loop_sound_on_entity(var_03.var_D09B);
    }

    if(isDefined(var_03.botgetnodesonpath)) {
      param_00 thread scripts\engine\utility::stop_loop_sound_on_entity(var_03.botgetnodesonpath);
    }

    if(isDefined(param_00.var_D3E2) && isDefined(var_03.var_D09A)) {
      level.player thread scripts\sp\utility::play_sound_on_entity(var_03.var_D09A);
    }
  } else if(!isai(param_00)) {
    if(param_00.var_5BF2 == 1) {
      param_00 delete();
      return;
    }

    param_00 = lib_0B77::func_10869(param_00);
  }

  self.var_E4FB = scripts\engine\utility::array_remove(self.var_E4FB, param_00);
  self.var_1307E[param_01] = 0;
  param_00.var_E500 = undefined;
  param_00.var_5BD6 = undefined;
  if(!isalive(self) && !isDefined(var_03.var_12BC8)) {
    param_00 delete();
    return;
  }

  param_00 unlink();
  if(!isDefined(param_00.var_B14F)) {
    param_00.var_30 = 1;
  }

  if(isalive(param_00) || var_02) {
    if(isai(param_00)) {
      param_00.a.disablelongdeath = !param_00 gettargetchargepos();
    }

    param_00.var_72AE = undefined;
    param_00 notify("jumpedout");
    if(isai(param_00)) {
      if(isDefined(var_03.botgetscriptgoalyaw)) {
        param_00.var_5270 = var_03.botgetscriptgoalyaw;
        param_00 allowedstances("crouch");
        param_00 thread scripts\anim\utility::func_12E5F();
        param_00 allowedstances("stand", "crouch", "prone");
      }

      param_00 _meth_8250(0);
      if(func_8750(param_00)) {
        param_00.objective_playermask_showto = 600;
        param_00 give_mp_super_weapon(param_00.origin);
      }
    } else if(var_02) {
      param_00.var_1356F.origin = param_00.origin;
      param_00.var_1356F.angles = param_00.angles;
      if(isDefined(param_00.var_1356F.target)) {
        param_00.var_1356F scripts\sp\vehicle::func_1080B();
      } else {
        var_11 = param_00.var_1356F scripts\sp\utility::func_10808();
      }

      param_00 delete();
    }
  }

  if(isDefined(param_00.script_noteworthy) && param_00.script_noteworthy == "delete_after_unload") {
    param_00 delete();
    return;
  }

  if(isDefined(var_03.botfirstavailablegrenade) && var_03.botfirstavailablegrenade) {
    param_00 delete();
    return;
  }

  param_00 func_872E();
}

func_8767(param_00, param_01, param_02, param_03, param_04) {
  var_05 = self gettagorigin(param_01);
  var_06 = self gettagangles(param_01);
  var_07 = getstartorigin(var_05, var_06, param_02);
  var_08 = getstartangles(var_05, var_06, param_02);
  var_09 = getmovedelta(param_02, 0, 1);
  var_0A = scripts\engine\utility::spawn_tag_origin();
  var_0A.origin = var_07;
  var_0A.angles = var_08;
  var_0B = var_0A gettweakablevalue(var_09);
  var_0A thread scripts\sp\utility::func_5184("movedone");
  var_0C = var_0B;
  var_0D = scripts\sp\utility::func_864C(var_0C);
  var_0E = getstartorigin(var_05, var_06, param_04);
  var_09 = getmovedelta(param_04, 0, 1);
  var_0F = var_0E + var_09;
  var_10 = var_0E[2] - var_0F[2];
  var_11 = var_0D + (0, 0, var_10);
  param_00 scripts\sp\utility::func_F2A8(0);
  param_00 setCanDamage(0);
  param_00 endon("death");
  wait(getanimlength(param_02) - 0.1);
  param_00 unlink();
  param_00 notify("animontag_thread");
  param_00 givescorefortrophyblocks();
  var_0A.origin = param_00.origin;
  var_0A.angles = param_00.angles;
  var_0A dontinterpolate();
  param_00 dontinterpolate();
  param_00 linkto(var_0A, "tag_origin", (0, 0, 0), (0, 0, 0));
  param_00 scripts\sp\utility::func_F2A8(1);
  param_00 setCanDamage(1);
  param_00.var_12BC4 = param_03;
  if(isai(param_00)) {
    param_00 lib_0A1E::func_2307(::func_873D, ::func_873E);
  } else {
    param_00 thread func_873D();
  }

  var_12 = length((0, 0, var_11[2]) - (0, 0, var_0C[2]));
  var_13 = 350;
  var_14 = var_12 / var_13;
  var_0A moveto(var_11, var_14);
  var_0A waittill("movedone");
  param_00 unlink();
  param_00 animscripted("dropship_land", param_00.origin, param_00.angles, param_04);
  wait(getanimlength(param_04));
  param_00 notify("hoverunload_done");
  param_00 notify("anim_on_tag_done");
}

func_873D() {
  if(isai(self)) {
    if(scripts\engine\utility::actor_is3d()) {
      self orientmode("face angle 3d", self.angles);
    } else {
      self orientmode("face angle", self.angles[1]);
    }

    self clearanim(lib_0A1E::asm_getbodyknob(), 0.2);
  }

  self give_attacker_kill_rewards(self.var_12BC4, 1);
  self waittill("dropship_land");
}

func_873E() {}

func_8750(param_00) {
  if(isDefined(param_00.var_ED53)) {
    return 0;
  }

  if(param_00 scripts\sp\utility::func_8B6C()) {
    return 0;
  }

  if(isDefined(param_00.var_DB41)) {
    return 0;
  }

  if(!isDefined(param_00.target)) {
    return 1;
  }

  var_01 = getnodearray(param_00.target, "targetname");
  var_02 = scripts\engine\utility::getstructarray(param_00.target, "targetname");
  if(var_01.size > 0 || var_02.size > 0) {
    return 0;
  }

  var_03 = getent(param_00.target, "targetname");
  if(isDefined(var_03) && var_03.classname == "info_volume") {
    return 0;
  }

  return 1;
}

func_1FC2(param_00, param_01, param_02, param_03, param_04, param_05) {
  param_00 notify("animontag_thread");
  param_00 endon("animontag_thread");
  if(!isDefined(param_05)) {
    param_05 = "animontagdone";
  }

  if(isDefined(self.var_B91E)) {
    var_06 = self.var_B91E;
  } else {
    var_06 = self;
  }

  if(!isDefined(param_01)) {
    var_07 = param_00.origin;
    var_08 = param_00.angles;
  } else {
    var_07 = var_08 gettagorigin(param_03);
    var_08 = var_07 gettagangles(param_02);
  }

  if(isDefined(param_00.var_DC19) && !isDefined(param_00.var_C01B)) {
    level thread func_1FC3(param_00, self);
  }

  param_00 animscripted(param_05, var_07, var_08, param_02);
  if(isai(param_00)) {
    thread donotetracks(param_00, var_06, param_05);
  }

  if(isDefined(param_00.var_1EB4)) {
    param_00.var_1EB4 = undefined;
    var_09 = getanimlength(param_02) - 0.25;
    if(var_09 > 0) {
      wait(var_09);
    }

    if(getdvarint("ai_iw7", 0) == 1) {
      param_00 lib_0A1E::func_2386();
    }

    param_00.queuedialog = 0;
    param_00 thread func_DDFA();
  } else {
    if(isDefined(param_03)) {
      for(var_0A = 0; var_0A < param_03.size; var_0A++) {
        param_00 waittillmatch(param_03[var_0A], param_05);
        param_00 thread[[param_04[var_0A]]]();
      }
    }

    param_00 waittillmatch("end", param_05);
  }

  param_00 notify("anim_on_tag_done");
  param_00.var_DC19 = undefined;
}

func_DDFA() {
  self endon("death");
  wait(2);
  if(self.queuedialog == 0) {
    self.queuedialog = 80;
  }
}

func_1FC3(param_00, param_01) {
  if(isDefined(param_00.var_B14F) && param_00.var_B14F) {
    return;
  }

  if(!isai(param_00)) {
    param_00 setCanDamage(1);
  }

  param_00 endon("anim_on_tag_done");
  var_02 = undefined;
  var_03 = undefined;
  var_04 = param_01.health <= 0;
  for(;;) {
    if(!var_04 && !isDefined(param_01) && param_01.health > 0) {
      break;
    }

    param_00 waittill("damage", var_02, var_03);
    if(isDefined(param_00.var_72C4)) {
      break;
    }

    if(!isDefined(var_02)) {
      continue;
    }

    if(var_02 < 1) {
      continue;
    }

    if(!isDefined(var_03)) {
      continue;
    }

    if(isplayer(var_03)) {
      break;
    }
  }

  if(!isalive(param_00)) {
    return;
  }

  thread func_1FC4(param_00, param_01, var_03);
}

func_1FC4(param_00, param_01, param_02) {
  param_00.var_4E2A = undefined;
  param_00.var_4E46 = undefined;
  param_00.var_1EB2 = 1;
  if(isDefined(param_00.var_DC17)) {
    var_03 = getmovedelta(param_00.var_DC17, 0, 1);
    var_04 = physicstrace(param_00.origin + (0, 0, 16), param_00.origin - (0, 0, 10000));
    var_05 = distance(param_00.origin + (0, 0, 16), var_04);
    if(abs(var_03[2] + 16) <= abs(var_05)) {
      param_00 thread scripts\sp\utility::play_sound_on_entity("generic_death_falling");
      param_00 animscripted("fastrope_fall", param_00.origin, param_00.angles, param_00.var_DC17);
      param_00 waittillmatch("start_ragdoll", "fastrope_fall");
    }
  }

  if(!isDefined(param_00)) {
    return;
  }

  param_00.var_4E2A = undefined;
  param_00.var_4E46 = undefined;
  param_00.var_1EB2 = 1;
  param_00 notify("rope_death", param_02);
  param_00 _meth_81D0(param_02.origin, param_02);
  if(isDefined(param_00.var_EECD)) {
    param_00 notsolid();
    var_06 = getweaponmodel(param_00.var_394);
    var_07 = param_00.var_394;
    if(isDefined(var_06)) {
      param_00 detach(var_06, "tag_weapon_right");
      var_08 = param_00 gettagorigin("tag_weapon_right");
      var_09 = param_00 gettagangles("tag_weapon_right");
      level.gun = spawn("weapon_" + var_07, (0, 0, 0));
      level.gun.angles = var_09;
      level.gun.origin = var_08;
    }
  } else {
    param_00 scripts\anim\shared::func_5D1A();
  }

  if(isDefined(param_00.var_71C8)) {
    param_00[[param_00.var_71C8]]();
  }

  param_00 giverankxp();
}

donotetracks(param_00, param_01, param_02) {
  param_00 endon("newanim");
  param_01 endon("death");
  param_00 endon("death");
  param_00 scripts\anim\shared::donotetracks(param_02);
}

func_1F9D(param_00, param_01, param_02, param_03) {
  param_00 animscripted("movetospot", param_01, param_02, param_03);
  param_00 waittillmatch("end", "movetospot");
}

func_876B(param_00, param_01, param_02) {
  if(!isalive(param_00)) {
    return;
  }

  if(isDefined(self.var_C011)) {
    return;
  }

  var_03 = func_1F00(self, param_00.var_1321D);
  param_00.vehicle_build = param_01;
  if(isDefined(var_03.var_69DF)) {
    return func_872D(param_00);
  }

  if(isDefined(level.vehicle.var_116CE.var_E4F9) && isDefined(level.vehicle.var_116CE.var_E4F9[self.classname])) {
    self[[level.vehicle.var_116CE.var_E4F9[self.classname]]]();
    return;
  }

  if(isDefined(var_03.var_12BC8) && isDefined(self)) {
    if(isDefined(self.var_5970) && self.var_5970) {
      return;
    }

    thread func_8744(param_00, param_00.var_1321D, 1);
    wait(var_03.var_12BC8);
    if(isDefined(param_00) && isDefined(self)) {
      self.var_86A1 = param_00.var_1321D;
      func_1F74("unload");
    }

    return;
  }

  if(isDefined(param_00)) {
    if(isDefined(param_00.var_DC19) && param_02 != "bm21_troops") {
      return;
    }

    [[level.vehicle_canturrettargetpoint]]("MOD_RIFLE_BULLET", "torso_upper", param_00.origin);
    if(param_02 == "bm21_troops") {
      param_00.var_30 = 1;
      param_00 _meth_81D0();
      return;
    }

    param_00 delete();
  }
}

func_19F9() {
  self endon("death");
  self waittill("loaded");
  scripts\sp\vehicle_paths::setsuit(self);
}

func_F554(param_00, param_01) {
  var_02 = param_00.var_EEC9;
  if(isDefined(param_00.var_72AE)) {
    var_02 = param_00.var_72AE;
  }

  if(isDefined(var_02)) {
    return var_02;
  }

  for(var_03 = 0; var_03 < self.var_1307E.size; var_03++) {
    if(self.var_1307E[var_03]) {
      continue;
    }

    if(isDefined(param_00.var_9FEF) && !isDefined(param_01[var_03].var_9FEF)) {
      continue;
    }

    if(!isDefined(param_00.var_9FEF) && isDefined(param_01[var_03].var_9FEF)) {
      continue;
    }

    return var_03;
  }

  if(param_00.var_9FEF) {}
}

func_874C(param_00, param_01, param_02) {
  var_03 = func_1F00(self, param_01);
  var_04 = self.mgturret[var_03.mgturret];
  if(!isalive(param_00)) {
    return;
  }

  var_04 endon("death");
  param_00 endon("death");
  if(isDefined(param_02) && param_02 && isDefined(var_03.var_C939)) {
    [[var_03.var_C939]](self, param_00, param_01, var_04);
  }

  scripts\sp\vehicle_code::func_F5D8(var_04);
  var_04 setdefaultdroppitch(0);
  wait(0.1);
  param_00 endon("guy_man_turret_stop");
  level thread scripts\sp\mgturret::func_B6A7(var_04, scripts\sp\utility::func_7E72());
  var_04 setturretignoregoals(1);
  var_05 = "stand";
  if(isDefined(var_03.var_12A80)) {
    var_05 = var_03.var_12A80;
  }

  param_00 scripts\sp\utility::func_13035(var_04, var_05);
}

func_8765(param_00) {
  param_00 endon("jumpedout");
  param_00 waittill("death");
  if(isDefined(param_00)) {
    param_00 unlink();
  }
}

func_872D(param_00) {
  if(!isDefined(param_00.var_1321D)) {
    return;
  }

  var_01 = param_00.var_1321D;
  var_02 = func_1F00(self, var_01);
  if(!isDefined(var_02.var_69DF)) {
    return;
  }

  [[level.vehicle_canturrettargetpoint]]("MOD_RIFLE_BULLET", "torso_upper", param_00.origin);
  param_00.var_4E2A = var_02.var_69DF;
  var_03 = self.angles;
  var_04 = param_00.origin;
  if(isDefined(var_02.var_69E0)) {
    var_04 = var_04 + anglesToForward(var_03) * var_02.var_69E0[0];
    var_04 = var_04 + anglestoright(var_03) * var_02.var_69E0[1];
    var_04 = var_04 + anglestoup(var_03) * var_02.var_69E0[2];
  }

  param_00 = func_45EE(param_00);
  func_538C(param_00, "weapon_");
  param_00 notsolid();
  param_00.origin = var_04;
  param_00.angles = var_03;
  param_00 animscripted("deathanim", var_04, var_03, var_02.var_69DF);
  var_05 = 0.3;
  if(isDefined(var_02.var_69E1)) {
    var_05 = var_02.var_69E1;
  }

  var_06 = getanimlength(var_02.var_69DF);
  var_07 = gettime() + var_06 * 1000;
  wait(var_06 * var_05);
  var_08 = (0, 0, 1);
  var_09 = param_00.origin;
  if(getdvar("ragdoll_enable") == "0") {
    param_00 delete();
    return;
  }

  if(isai(param_00)) {
    param_00 scripts\anim\shared::func_5D1A();
  } else {
    func_538C(param_00, "weapon_");
  }

  while(!param_00 _meth_81B7() && gettime() < var_07) {
    var_09 = param_00.origin;
    wait(0.05);
    var_08 = param_00.origin - var_09;
    if(isDefined(param_00.var_71C8)) {
      param_00[[param_00.var_71C8]]();
    }

    param_00 giverankxp();
  }

  wait(0.05);
  var_08 = var_08 * 20000;
  for(var_0A = 0; var_0A < 3; var_0A++) {
    if(isDefined(param_00)) {
      var_09 = param_00.origin;
    }

    wait(0.05);
  }

  if(!param_00 _meth_81B7()) {
    param_00 delete();
  }
}

func_45EE(param_00, param_01) {
  if(!isDefined(param_01)) {
    param_01 = 0;
  }

  var_02 = spawn("script_model", param_00.origin);
  var_02.angles = param_00.angles;
  var_02 setModel(param_00.model);
  var_03 = param_00 getscoreremaining();
  for(var_04 = 0; var_04 < var_03; var_04++) {
    var_02 attach(param_00 getscoreperminute(var_04), param_00 getattachtagname(var_04));
  }

  var_02 glinton(#animtree);
  if(isDefined(param_00.team)) {
    var_02.team = param_00.team;
  }

  if(!param_01) {
    param_00 delete();
  }

  var_02 makefakeai();
  return var_02;
}

vehicle_animate(param_00, param_01) {
  self glinton(param_01);
  self give_attacker_kill_rewards(param_00);
}

func_131E5(param_00) {
  var_01 = func_1F00(self, param_00);
  return func_131E0(var_01.var_7F12, var_01.var_10220, param_00);
}

func_131E0(param_00, param_01, param_02) {
  var_03 = spawnStruct();
  var_04 = undefined;
  var_05 = undefined;
  var_06 = self gettagorigin(param_01);
  var_07 = self gettagangles(param_01);
  var_04 = getstartorigin(var_06, var_07, param_00);
  var_05 = getstartangles(var_06, var_07, param_00);
  var_03.origin = var_04;
  var_03.angles = var_05;
  var_03.var_1321D = param_02;
  return var_03;
}

func_9C8A(param_00, param_01, param_02) {
  if(!isDefined(param_02)) {
    return 1;
  }

  var_03 = param_00.classname;
  var_04 = level.vehicle.var_116CE.var_12BCF[var_03][param_02];
  foreach(var_06 in var_04) {
    if(var_06 == param_01) {
      return 1;
    }
  }

  return 0;
}

func_7851(param_00) {
  var_01 = level.vehicle.var_116CE.var_1A03[self.classname];
  var_02 = [];
  var_03 = [];
  for(var_04 = 0; var_04 < self.var_1307E.size; var_04++) {
    if(self.var_1307E[var_04]) {
      continue;
    }

    if(isDefined(var_01[var_04].var_7F12) && func_9C8A(self, var_04, param_00)) {
      var_02[var_02.size] = func_131E5(var_04);
      continue;
    }

    var_03[var_03.size] = var_04;
  }

  var_05 = spawnStruct();
  var_05.var_26A3 = var_02;
  var_05.var_C07E = var_03;
  return var_05;
}

func_7DC5() {
  if(isDefined(self.var_B91E)) {
    return self.var_B91E;
  }

  return self;
}

func_538C(param_00, param_01) {
  var_02 = param_00 getscoreremaining();
  var_03 = [];
  var_04 = [];
  var_05 = 0;
  for(var_06 = 0; var_06 < var_02; var_06++) {
    var_07 = param_00 getscoreperminute(var_06);
    var_08 = param_00 getattachtagname(var_06);
    if(issubstr(var_07, param_01)) {
      var_03[var_05] = var_07;
      var_04[var_05] = var_08;
    }
  }

  for(var_06 = 0; var_06 < var_03.size; var_06++) {
    param_00 detach(var_03[var_06], var_04[var_06]);
  }
}

func_FF4D() {
  if(!isai(self)) {
    return 0;
  }

  if(!isDefined(self.var_C6F8)) {
    return 0;
  }

  return !isDefined(self.var_B14F);
}

func_10B38(param_00) {
  self waittill("stable_for_unlink");
  if(isalive(param_00)) {
    param_00 unlink();
  }
}

func_1F74(param_00) {
  var_01 = [];
  foreach(var_03 in self.var_E4FB) {
    if(isai(var_03) && !isalive(var_03)) {
      continue;
    }

    if(isDefined(level.vehicle.var_1A02[param_00]) && ![
        [level.vehicle.var_1A02[param_00]]
      ](var_03, var_03.var_1321D)) {
      continue;
    }

    if(isDefined(level.vehicle.var_1A04[param_00])) {
      var_03 notify("newanim");
      var_03.var_DB8E = [];
      thread[[level.vehicle.var_1A04[param_00]]](var_03, var_03.var_1321D);
      var_01[var_01.size] = var_03;
      continue;
    }
  }

  return var_01;
}

func_872E() {
  self.var_131F5 = undefined;
  self.var_10B71 = undefined;
  self.var_1321D = undefined;
  self.delay = undefined;
}