/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2964.gsc
**************************************/

func_8739(var_0, var_1) {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.vehicletype)) {
    return;
  }
  var_2 = self.classname;
  var_3 = level.vehicle.var_116CE.var_1A03[var_2];
  self.var_247C[self.var_247C.size] = var_0;
  var_4 = func_F554(var_0, var_3);

  if(!isDefined(var_4)) {
    return;
  }
  if(var_4 == 0) {
    var_0.var_5BD6 = 1;
  }

  var_5 = func_1F00(self, var_4);
  self.var_1307E[var_4] = 1;
  var_0.var_1321D = var_4;
  var_0.var_131F5 = 0;

  if(isDefined(var_5.delay)) {
    var_0.delay = var_5.delay;

    if(isDefined(var_5.var_510B)) {
      self.var_5107 = var_0.delay;
    }
  }

  if(isDefined(var_5.var_510B)) {
    self.var_5107 = self.var_5107 + var_5.var_510B;
    var_0.delay = self.var_5107;
  }

  var_0.var_E500 = self;
  var_0.var_C6F8 = var_0.health;
  var_0.var_131F2 = var_5.var_92CC;
  var_0.var_13240 = var_5.var_10B69;
  var_0.var_4E2A = var_5.death;
  var_0.var_4E2E = var_5.var_4E5E;
  var_0.var_10B71 = 0;
  var_0.allowdeath = 0;

  if(isDefined(var_0.var_4E2A) && !isDefined(var_0.var_B14F) && vehicle_allows_driver_death()) {
    if(var_0.var_1321D != 0 || vehicle_all_stop_func()) {
      var_0.allowdeath = !isDefined(var_0.var_ECED) || var_0.var_ECED;

      if(isDefined(var_5.var_4E14)) {
        var_0.noragdoll = var_5.var_4E14;
      }
    }
  }

  if(var_0.classname == "script_model") {
    if(isDefined(var_5.death) && var_0.allowdeath && (!isDefined(var_0.var_ECED) || var_0.var_ECED)) {
      thread func_8730(var_0, var_5);
    }
  }

  if(!isDefined(var_0.var_131F2)) {
    var_0.allowdeath = 1;
  }

  self.var_E4FB[self.var_E4FB.size] = var_0;

  if(var_0.classname != "script_model" && scripts\sp\utility::func_106ED(var_0)) {
    return;
  }
  var_6 = self gettagorigin(var_5.var_10220);
  var_7 = self gettagangles(var_5.var_10220);
  func_AD14(var_0, var_5.var_10220, var_5.var_10221, var_5.var_AD46);

  if(isai(var_0)) {
    var_0 _meth_83B9(var_6, var_7);
    var_0.a.disablelongdeath = 1;

    if(isDefined(var_5.var_2AB6) && !var_5.var_2AB6) {
      var_0 scripts\sp\utility::func_86E4();
    }

    if(func_8755(var_5)) {
      thread func_874C(var_0, var_4, var_1);
    }
  } else {
    if(isDefined(var_5.var_2AB6) && !var_5.var_2AB6) {
      func_538C(var_0, "weapon_");
    }

    var_0.origin = var_6;
    var_0.angles = var_7;
  }

  if(var_4 == 0 && isDefined(var_3[0].death)) {
    thread func_5BCE(var_0);
  }

  self notify("guy_entered", var_0, var_4);
  thread func_8743(var_0, var_4);

  if(isDefined(var_5.var_E4FA)) {
    var_0[[var_5.var_E4FA]]();
  } else {
    if(isDefined(var_5.var_7F14)) {
      thread[[var_5.var_7F14]](var_0, var_4);
      return;
    }

    thread func_8744(var_0, var_4);
  }
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

func_8755(var_0) {
  if(!isDefined(var_0.mgturret)) {
    return 0;
  }

  if(!isDefined(self.var_EE5E)) {
    return 1;
  }

  return !self.var_EE5E;
}

func_88AE() {
  var_0 = self.classname;
  self.var_247C = [];

  if(!(isDefined(level.vehicle.var_116CE.var_1A03) && isDefined(level.vehicle.var_116CE.var_1A03[var_0]))) {
    return;
  }
  var_1 = level.vehicle.var_116CE.var_1A03[var_0].size;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "ai_wait_go") {
    thread func_19F9();
  }

  self.var_E880 = [];
  self.var_1307E = [];
  self.var_7F1A = [];
  self.var_5107 = 0;
  var_2 = level.vehicle.var_116CE.var_1A03[var_0];

  for(var_3 = 0; var_3 < var_1; var_3++) {
    self.var_1307E[var_3] = 0;

    if(isDefined(self.var_EE5E) && self.var_EE5E && isDefined(var_2[var_3].var_2B10) && var_2[var_3].var_2B10) {
      self.var_1307E[1] = 1;
    }
  }
}

func_ADA8(var_0) {
  func_ADA7(var_0, 1);
}

func_8730(var_0, var_1) {
  waittillframeend;
  var_0 setCanDamage(1);
  var_0 endon("death");
  var_0.allowdeath = 0;
  var_0.health = 10150;

  if(isDefined(var_0.var_EEC8)) {
    var_0.health = var_0.health + var_0.var_EEC8;
  }

  var_0 endon("jumping_out");

  if(isDefined(var_0.var_B14F) && var_0.var_B14F) {
    while(isDefined(var_0.var_B14F) && var_0.var_B14F) {
      wait 0.05;
    }
  }

  while(var_0.health > 10000) {
    var_0 waittill("damage");
  }

  thread func_8732(var_0, var_1);
}

func_8732(var_0, var_1) {
  var_2 = gettime() + getanimlength(var_1.death) * 1000;
  var_3 = var_0.angles;
  var_4 = var_0.origin;
  var_0 = func_45EE(var_0);
  [[level.vehicle_canturrettargetpoint]]("MOD_RIFLE_BULLET", "torso_upper", var_4);
  func_538C(var_0, "weapon_");
  var_0 linkto(self);
  var_0 notsolid();
  var_0 give_attacker_kill_rewards(var_1.death);

  if(isai(var_0)) {
    var_0 scripts\anim\shared::func_5D1A();
  } else {
    func_538C(var_0, "weapon_");
  }

  if(isDefined(var_1.var_4E00)) {
    var_0 unlink();

    if(isDefined(var_0.var_71C8)) {
      var_0[[var_0.var_71C8]]();
    }

    var_0 startragdoll();
    wait(var_1.var_4E00);
    var_0 delete();
    return;
  }
}

func_ADA7(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  scripts\sp\utility::func_65DD("unloaded");
  scripts\sp\utility::func_65DD("loaded");
  scripts\engine\utility::array_levelthread(var_0, ::func_7A35, var_1, var_2);
}

func_9CA7(var_0) {
  for(var_1 = 0; var_1 < self.var_E4FB.size; var_1++) {
    if(self.var_E4FB[var_1] == var_0) {
      return 1;
    }
  }

  return 0;
}

func_7A35(var_0, var_1, var_2) {
  if(func_9CA7(var_0)) {
    return;
  }
  if(!func_88D2()) {
    return;
  }
  func_8752(var_0, self, var_1, var_2);
}

func_88D2() {
  if(func_131EE()) {
    return 1;
  }
}

func_131EE() {
  if(level.vehicle.var_116CE.var_1A03[self.classname].size - self.var_E880.size) {
    return 1;
  } else {
    return 0;
  }
}

func_8754(var_0, var_1) {
  var_1 endon("death");
  var_1 endon("stop_loading");
  var_2 = var_0 scripts\engine\utility::waittill_any_return("long_death", "death", "enteredvehicle");

  if(var_2 != "enteredvehicle" && isDefined(var_0.var_72AE)) {
    var_1.var_1307E[var_0.var_72AE] = 0;
  }

  var_1.var_E880 = scripts\engine\utility::array_remove(var_1.var_E880, var_0);
  func_13211(var_1);
}

func_13211(var_0) {
  if(isDefined(var_0.vehicletype) && isDefined(var_0.var_13212)) {
    if(var_0.var_E4FB.size == var_0.var_13212) {
      var_0 scripts\sp\utility::func_65E1("loaded");
    }
  } else if(!var_0.var_E880.size && var_0.var_E4FB.size) {
    if(var_0.var_1307E[0]) {
      var_0 scripts\sp\utility::func_65E1("loaded");
    } else {
      var_0 thread func_1321F();
    }
  }
}

func_1321F() {
  var_0 = self.var_E4FB;
  scripts\sp\vehicle::func_13253();
  scripts\sp\utility::func_65E3("unloaded");
  var_0 = scripts\sp\utility::func_22B9(var_0);
  thread scripts\sp\vehicle::func_1320F(var_0);
}

func_E054(var_0) {
  scripts\engine\utility::waittill_any("unload", "death");
  var_0 scripts\sp\utility::func_1101B();
}

func_8752(var_0, var_1, var_2, var_3) {
  var_1 endon("stop_loading");
  var_4 = 1;

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_5 = level.vehicle.var_116CE.var_1A03[var_1.classname];

  if(isDefined(var_1.var_E8A8)) {
    var_1 thread[[var_1.var_E8A8]](var_0);
    return;
  }

  var_1 endon("death");
  var_0 endon("death");
  var_1.var_E880[var_1.var_E880.size] = var_0;
  thread func_8754(var_0, var_1);
  var_6 = [];
  var_7 = undefined;
  var_8 = 0;
  var_9 = 0;

  for(var_10 = 0; var_10 < var_5.size; var_10++) {
    if(isDefined(var_5[var_10].var_7F12)) {
      var_9 = 1;
    }
  }

  if(!var_9) {
    var_0 notify("enteredvehicle");
    var_1 func_8739(var_0, var_4);
    return;
  }

  if(!isDefined(var_0.var_7A34)) {
    while(var_1 vehicle_getspeed() > 1) {
      wait 0.05;
    }
  }

  var_11 = var_1 func_7851(var_3);

  if(isDefined(var_0.var_EEC9)) {
    var_7 = var_1 func_131E5(var_0.var_EEC9);
  } else if(!var_1.var_1307E[0]) {
    var_7 = var_1 func_131E5(0);

    if(var_2) {
      var_0 thread scripts\sp\utility::func_B14F();
      thread func_E054(var_0);
    }
  } else if(var_11.var_26A3.size)
    var_7 = scripts\engine\utility::getclosest(var_0.origin, var_11.var_26A3);
  else {
    var_7 = undefined;
  }

  if(!var_11.var_26A3.size && var_11.var_C07E.size) {
    var_0 notify("enteredvehicle");
    var_1 func_8739(var_0, var_4);
    return;
  } else if(!isDefined(var_7)) {
    return;
  }
  var_8 = var_7.origin;
  var_12 = var_7.angles;
  var_0.var_72AE = var_7.var_1321D;
  var_1.var_1307E[var_7.var_1321D] = 1;
  var_0.var_EE2B = 1;
  var_0 notify("stop_going_to_node");
  var_0 scripts\sp\utility::func_F3BC();
  var_0 scripts\sp\utility::func_5504();
  var_0.goalradius = 16;
  var_0 give_mp_super_weapon(var_8);
  var_0 waittill("goal");
  var_0 scripts\sp\utility::func_61DB();
  var_0 scripts\sp\utility::func_12BFA();
  var_0 notify("boarding_vehicle");
  var_13 = func_1F00(var_1, var_7.var_1321D);

  if(isDefined(var_13.delay)) {
    var_0.delay = var_13.delay;

    if(isDefined(var_13.var_510B)) {
      self.var_5107 = var_0.delay;
    }
  }

  if(isDefined(var_13.var_510B)) {
    self.var_5107 = self.var_5107 + var_13.var_510B;
    var_0.delay = self.var_5107;
  }

  var_1 func_AD14(var_0, var_13.var_10220, var_13.var_10221, var_13.var_AD46);
  var_0.allowdeath = 0;
  var_13 = var_5[var_7.var_1321D];

  if(isDefined(var_7)) {
    if(isDefined(var_13.var_131E1)) {
      if(isDefined(var_13.var_131E6)) {
        var_14 = isDefined(var_0.var_C01A);

        if(!var_14) {
          var_1 clearanim(var_13.var_131E6, 0);
        }
      }

      var_1 = var_1 func_7DC5();
      var_1 thread func_F642(var_13.var_131E1, var_13.var_131E2);
      level thread scripts\sp\anim::func_10CBF(var_1, "vehicle_anim_flag", undefined, undefined, var_13.var_131E1);
    }

    if(isDefined(var_13.var_131E4)) {
      var_8 = var_1 gettagorigin(var_13.var_131E4);
    } else {
      var_8 = var_1.origin;
    }

    if(isDefined(var_13.var_131E3)) {
      _playworldsound(var_13.var_131E3, var_8);
    }

    var_15 = undefined;
    var_16 = undefined;

    if(isDefined(var_13.var_7F13)) {
      var_15 = [];
      var_15[0] = var_13.var_7F13;
      var_16 = [];
      var_16[0] = ::func_6623;
      var_1 func_AD14(var_0, var_13.var_10220, var_13.var_10221, var_13.var_AD46);
    }

    var_1 func_1FC2(var_0, var_13.var_10220, var_13.var_7F12, var_15, var_16);
  }

  var_0 notify("enteredvehicle");
  var_1 func_8739(var_0, var_4);
}

func_6623() {
  self notify("enteredvehicle");
}

func_5BCE(var_0) {
  if(scripts\sp\vehicle::func_9E2C()) {
    return;
  }
  self.var_5BC8 = var_0;
  self endon("death");
  var_0 endon("jumping_out");
  var_0 waittill("death");

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

func_872C(var_0, var_1) {
  if(isai(var_0)) {
    return var_0;
  }

  if(var_0.var_5BF2 == 1) {
    var_0 delete();
  } else {
    var_0 = func_0B77::func_10869(var_0);
    var_2 = self.classname;
    var_3 = level.vehicle.var_116CE.var_1A03[var_2].size;
    var_4 = func_1F00(self, var_1);
    func_AD14(var_0, var_4.var_10220, var_4.var_10221, var_4.var_AD46);
    var_0.var_131F2 = var_4.var_92CC;
    thread func_8744(var_0, var_1);
  }
}

func_AD14(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(var_3 && !isDefined(var_0.var_ED6E)) {
    var_0 _meth_81E1(self, var_1, 0);
  } else {
    var_0 linkto(self, var_1, var_2, (0, 0, 0));
  }
}

func_1F00(var_0, var_1) {
  return level.vehicle.var_116CE.var_1A03[var_0.classname][var_1];
}

func_8731(var_0, var_1) {
  var_0 waittill("death");

  if(!isDefined(self)) {
    return;
  }
  self.var_E4FB = scripts\engine\utility::array_remove(self.var_E4FB, var_0);
  self.var_1307E[var_1] = 0;
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

func_8743(var_0, var_1) {
  var_0.var_131F5 = 1;
  thread func_8731(var_0, var_1);
}

func_5BC9(var_0, var_1) {
  var_0 endon("newanim");
  self endon("death");
  var_0 endon("death");
  var_2 = func_1F00(self, var_1);

  for(;;) {
    if(self vehicle_getspeed() == 0) {
      var_0.var_131F2 = var_2.var_92D5;
    } else {
      var_0.var_131F2 = var_2.var_92D0;
    }

    wait 0.25;
  }
}

func_8744(var_0, var_1, var_2) {
  var_0 endon("newanim");

  if(!isDefined(var_2)) {
    self endon("death");
  }

  var_0 endon("death");
  var_0.var_131F5 = 1;
  var_0 notify("gotime");

  if(!isDefined(var_0.var_131F2)) {
    return;
  }
  var_3 = func_1F00(self, var_1);

  if(isDefined(var_3.mgturret)) {
    return;
  }
  if(isDefined(var_3.var_92D5) && isDefined(var_3.var_92D0)) {
    thread func_5BC9(var_0, var_1);
  }

  for(;;) {
    var_0 notify("idle");
    func_CDAA(var_0, var_3);
  }
}

func_CDAA(var_0, var_1) {
  if(isDefined(var_0.var_131F3)) {
    func_1FC2(var_0, var_1.var_10220, var_0.var_131F3);
    return;
  }

  if(isDefined(var_1.var_92F6)) {
    var_2 = func_DCBF(var_0, var_1.var_92F6);
    func_1FC2(var_0, var_1.var_10220, var_0.var_131F2[var_2]);
    return;
  }

  if(isDefined(var_0.var_D3E2) && isDefined(var_1.var_D0E8)) {
    func_1FC2(var_0, var_1.var_10220, var_1.var_D0E8);
    return;
  }

  if(isDefined(var_1.var_131F2)) {
    thread func_F642(var_1.var_131F2);
  }

  func_1FC2(var_0, var_1.var_10220, var_0.var_131F2);
}

func_DCBF(var_0, var_1) {
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

func_876A(var_0) {
  self endon("death");
  self.var_12BD0 = scripts\engine\utility::array_add(self.var_12BD0, var_0);
  var_0 scripts\engine\utility::waittill_any("death", "jumpedout");
  self.var_12BD0 = scripts\engine\utility::array_remove(self.var_12BD0, var_0);

  if(!self.var_12BD0.size) {
    scripts\sp\utility::func_65E1("unloaded");
    self.var_12BBC = "default";
  }
}

func_E4FC(var_0) {
  if(!self.var_E4FB.size) {
    return 0;
  }

  for(var_1 = 0; var_1 < self.var_E4FB.size; var_1++) {
    if(!isalive(self.var_E4FB[var_1]) && !isDefined(self.var_E4FB[var_1].var_9FEF)) {
      continue;
    }
    if(func_3DD9(self.var_E4FB[var_1].var_1321D, var_0)) {
      return 1;
    }
  }

  return 0;
}

func_7D2F() {
  var_0 = [];
  var_1 = [];
  var_2 = "default";

  if(isDefined(self.var_12BBC)) {
    var_2 = self.var_12BBC;
  }

  var_1 = level.vehicle.var_116CE.var_12BCF[self.classname][var_2];

  if(!isDefined(var_1)) {
    var_1 = level.vehicle.var_116CE.var_12BCF[self.classname]["default"];
  }

  foreach(var_4 in var_1) {
    var_0[var_4] = var_4;
  }

  return var_0;
}

func_3DD9(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = self.var_12BBC;
  }

  var_2 = self.classname;

  if(!isDefined(level.vehicle.var_116CE.var_12BCF[var_2])) {
    return 1;
  }

  if(!isDefined(level.vehicle.var_116CE.var_12BCF[var_2][var_1])) {
    return 1;
  }

  var_3 = level.vehicle.var_116CE.var_12BCF[var_2][var_1];

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(var_0 == var_3[var_4]) {
      return 1;
    }
  }

  return 0;
}

botgetscriptgoalradius(var_0, var_1, var_2) {
  self endon("unloading");

  for(;;) {
    func_1FC2(var_0, var_1, var_2);
  }
}

botgetscriptgoalnode(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self.classname;

  if(var_4) {
    thread botgetscriptgoalradius(var_1, var_2, level.vehicle.var_116CE.var_247D[var_5][var_0.var_6B9D].var_92F3);
    self waittill("unloading");
  }

  self.var_12BD0 = scripts\engine\utility::array_add(self.var_12BD0, var_1);
  thread botgetpathdist(var_1, var_2, var_3);

  if(!isDefined(self.var_4828)) {
    func_1FC2(var_1, var_2, var_3);
  }

  var_1 unlink();

  if(!isDefined(self)) {
    var_1 delete();
    return;
  }

  self.var_12BD0 = scripts\engine\utility::array_remove(self.var_12BD0, var_1);

  if(!self.var_12BD0.size) {
    self notify("unloaded");
  }

  self.var_6B9D[var_0.var_6B9D] = undefined;
  wait 10;
  var_1 delete();
}

botgetscriptgoal() {
  wait 0.05;

  while(isalive(self) && self.var_12BD0.size > 2) {
    wait 0.05;
  }

  if(!isalive(self) || isDefined(self.var_4828) && self.var_4828) {
    return;
  }
  self notify("getoutrig_disable_abort");
}

botgetpersonality() {
  self endon("end_getoutrig_abort_while_deploying");

  while(!isDefined(self.var_4828)) {
    wait 0.05;
  }

  var_0 = [];

  foreach(var_2 in self.var_E4FB) {
    if(isalive(var_2)) {
      scripts\engine\utility::add_to_array(var_0, var_2);
    }
  }

  scripts\sp\utility::func_228A(var_0);
  self notify("crashed_while_deploying");
  var_0 = undefined;
}

botgetpathdist(var_0, var_1, var_2) {
  var_3 = getanimlength(var_2);
  var_4 = var_3 - 1.0;

  if(self.vehicletype == "mi17") {
    var_4 = var_3 - 0.5;
  }

  var_5 = 2.5;
  self endon("getoutrig_disable_abort");
  thread botgetscriptgoal();
  thread botgetpersonality();
  scripts\engine\utility::waittill_notify_or_timeout("crashed_while_deploying", var_5);
  self notify("end_getoutrig_abort_while_deploying");

  while(!isDefined(self.var_4828)) {
    wait 0.05;
  }

  thread func_1FC2(var_0, var_1, var_2);
  waittillframeend;
  var_0 _meth_82B0(var_2, var_4 / var_3);
  var_6 = self;

  if(isDefined(self.var_C720)) {
    var_6 = self.var_C720;
  }

  for(var_7 = 0; var_7 < self.var_E4FB.size; var_7++) {
    if(!isDefined(self.var_E4FB[var_7])) {
      continue;
    }
    if(!isDefined(self.var_E4FB[var_7].var_DC19)) {
      continue;
    }
    if(self.var_E4FB[var_7].var_DC19 != 1) {
      continue;
    }
    if(!isDefined(self.var_E4FB[var_7].var_E500)) {
      continue;
    }
    self.var_E4FB[var_7].var_72C4 = 1;

    if(isalive(self.var_E4FB[var_7])) {
      thread func_1FC4(self.var_E4FB[var_7], self, var_6);
    }
  }
}

func_F642(var_0, var_1) {
  self endon("death");
  self endon("dont_clear_anim");

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_2 = getanimlength(var_0);
  self endon("death");
  self _meth_82EA("vehicle_anim_flag", var_0);
  wait(var_2);

  if(var_1) {
    self clearanim(var_0, 0);
  }
}

#using_animtree("generic_human");

botgetfovdot(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 = self.classname;
  var_4 = func_1F00(self, var_1);

  if(isDefined(self.var_2465) && isDefined(self.var_2465[var_4.var_6B9D])) {
    var_5 = 1;
  } else {
    var_5 = 0;
  }

  if(!isDefined(var_4.var_6B9D) || isDefined(self.var_6B9D[var_4.var_6B9D]) || var_5) {
    return;
  }
  var_6 = var_0 gettagorigin(level.vehicle.var_116CE.var_247D[var_3][var_4.var_6B9D].tag);
  var_7 = var_0 gettagangles(level.vehicle.var_116CE.var_247D[var_3][var_4.var_6B9D].tag);
  self.var_6B9E[var_4.var_6B9D] = 1;
  var_8 = spawn("script_model", var_6);
  var_8.angles = var_7;
  var_8.origin = var_6;
  var_8 setModel(level.vehicle.var_116CE.var_247D[var_3][var_4.var_6B9D].model);
  self.var_6B9D[var_4.var_6B9D] = var_8;
  var_8 glinton(#animtree);
  var_8 linkto(var_0, level.vehicle.var_116CE.var_247D[var_3][var_4.var_6B9D].tag, (0, 0, 0), (0, 0, 0));
  thread botgetscriptgoalnode(var_4, var_8, level.vehicle.var_116CE.var_247D[var_3][var_4.var_6B9D].tag, level.vehicle.var_116CE.var_247D[var_3][var_4.var_6B9D].var_5D1B, var_2);
  return var_8;
}

func_3DCC(var_0) {
  if(!isDefined(self.var_10471)) {
    self.var_10471 = [];
  }

  var_1 = 0;

  if(!isDefined(self.var_10471[var_0])) {
    self.var_10471[var_0] = 1;
  } else {
    var_1 = 1;
  }

  thread func_3DCD(var_0);
  return var_1;
}

func_3DCD(var_0) {
  wait 0.05;

  if(!isDefined(self)) {
    return;
  }
  self.var_10471[var_0] = 0;
  var_1 = getarraykeys(self.var_10471);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(self.var_10471[var_1[var_2]]) {
      return;
    }
  }

  self.var_10471 = undefined;
}

func_8766(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_0.var_9FEF)) {
    var_2 = 1;
  }

  var_3 = func_1F00(self, var_1);
  var_4 = self.vehicletype;

  if(!func_3DD9(var_1)) {
    thread func_8744(var_0, var_1);
    return;
  }

  if(!isDefined(var_3.botclearscriptgoal)) {
    thread func_8744(var_0, var_1);
    return;
  }

  thread func_876A(var_0);
  self endon("death");

  if(isai(var_0) && isalive(var_0)) {
    var_0 endon("death");
  }

  var_5 = 0;

  if(isDefined(var_0.autoboltmissileeffects)) {
    var_6 = var_0[[var_0.autoboltmissileeffects]]();

    if(isDefined(var_6) && var_6) {
      var_5 = 1;
    }
  }

  if(isDefined(var_0.var_C584)) {
    var_0.var_C584 = undefined;

    if(isDefined(var_0.autoboltmissileeffects)) {
      var_0[[var_0.autoboltmissileeffects]]();
    }
  }

  var_7 = func_7DC5();

  if(isDefined(var_3.var_131E6)) {
    var_7 thread func_F642(var_3.var_131E6, var_3.var_131E7);
    var_8 = 0;

    if(isDefined(var_3.var_131E9)) {
      var_8 = func_3DCC(var_3.var_131E9);
      var_9 = var_7 gettagorigin(var_3.var_131E9);
    } else
      var_9 = var_7.origin;

    if(isDefined(var_3.var_131E8) && !var_8) {
      _playworldsound(var_3.var_131E8, var_9);
    }

    var_8 = undefined;
  }

  var_10 = 0;

  if(isDefined(var_3.botgetnearestnode)) {
    var_10 = var_10 + getanimlength(var_3.botgetnearestnode);
  }

  if(isDefined(var_3.delay)) {
    var_10 = var_10 + var_3.delay;
  }

  if(isDefined(var_0.delay)) {
    var_10 = var_10 + var_0.delay;
  }

  if(var_10 > 0) {
    thread func_8744(var_0, var_1);
    wait(var_10);
  }

  var_0.var_4E2A = undefined;
  var_0.var_4E2E = undefined;
  var_0 notify("newanim");

  if(isDefined(var_3.var_2AB6) && !var_3.var_2AB6) {
    if(!isDefined(var_0.var_5531)) {
      var_0 scripts\sp\utility::func_86E2();
    }
  }

  if(isai(var_0)) {
    var_0 _meth_8250(1);
  }

  if(isDefined(var_3.var_2BE8)) {
    var_5 = 1;
  } else if(!isDefined(var_3.botclearscriptgoal) || !isDefined(self.var_EEFD) && (isDefined(var_3.var_2B10) && var_3.var_2B10) || isDefined(self.var_EDF4) && var_1 == 0) {
    thread func_8744(var_0, var_1);
    return;
  }

  if(var_0 func_FF4D()) {
    var_0.health = var_0.var_C6F8;
  }

  var_0.var_C6F8 = undefined;

  if(isai(var_0) && isalive(var_0)) {
    var_0 endon("death");
  }

  var_0.allowdeath = 0;

  if(isDefined(var_3.var_6981)) {
    var_11 = var_3.var_6981;
  } else {
    var_11 = var_3.var_10220;
  }

  if(isDefined(var_0.var_7B54)) {
    var_12 = var_0.var_7B54;
  } else if(scripts\sp\utility::func_65DB("landed") && isDefined(var_3.botgetentrancepoint)) {
    var_12 = var_3.botgetentrancepoint;
  } else if(isDefined(var_0.var_D3E2) && isDefined(var_3.var_D098)) {
    var_12 = var_3.var_D098;
  } else {
    var_12 = var_3.botclearscriptgoal;
  }

  if(!var_5) {
    thread func_8765(var_0);

    if(isDefined(var_3.var_6B9D)) {
      if(!isDefined(self.var_6B9D[var_3.var_6B9D])) {
        thread func_8744(var_0, var_1);
        var_13 = botgetfovdot(var_7, var_0.var_1321D, 0);
      }
    }

    if(isDefined(var_3.botgetscriptgoaltype)) {
      var_0 thread scripts\sp\utility::play_sound_on_tag(var_3.botgetscriptgoaltype, "J_Wrist_RI", 1);
    }

    if(isDefined(var_0.var_D3E2) && isDefined(var_3.var_D099)) {
      var_0 thread scripts\sp\utility::play_sound_on_entity(var_3.var_D099);
    }

    if(isDefined(var_3.botgetnodesonpath)) {
      var_0 thread scripts\sp\utility::play_loop_sound_on_tag(var_3.botgetnodesonpath);
    }

    if(isDefined(var_0.var_D3E2) && isDefined(var_3.var_D09B)) {
      level.player thread scripts\engine\utility::play_loop_sound_on_entity(var_3.var_D09B);
    }

    var_0 notify("newanim");
    var_0 notify("jumping_out");
    var_14 = 0;

    if(!isai(var_0) && !var_2) {
      var_14 = 1;
    }

    if(!isDefined(var_0.var_EECD) && !var_2) {
      var_0 = func_872C(var_0, var_1);
    }

    if(!isalive(var_0) && !var_2) {
      return;
    }
    if(!var_2) {
      var_0.var_DC19 = 1;
    }

    if(isDefined(var_3.var_DC19)) {
      var_0.var_DC19 = 1;

      if(isDefined(var_3.var_DC17)) {
        var_0.var_DC17 = var_3.var_DC17;
      }
    }

    if(var_14) {
      self.var_E4FB = scripts\engine\utility::array_add(self.var_E4FB, var_0);
      thread func_8731(var_0, var_1);
      thread func_876A(var_0);
      var_0.var_E500 = self;
    }

    if(isai(var_0)) {
      var_0 endon("death");
    }

    var_0 notify("newanim");
    var_0 notify("jumping_out");

    if(isDefined(var_3.var_AD88) && var_3.var_AD88) {
      thread func_10B38(var_0);
    }

    if(isDefined(var_3.botgetimperfectenemyinfo)) {
      func_1FC2(var_0, var_11, var_12);
      var_15 = var_11;

      if(isDefined(var_3.botgetmemoryevents)) {
        var_15 = var_3.botgetmemoryevents;
      }

      func_1FC2(var_0, var_15, var_3.botgetimperfectenemyinfo);
    } else {
      var_16 = 0;

      if(isDefined(var_3.botgetdifficultysetting) && isDefined(var_3.botgetdifficulty)) {
        thread func_8767(var_0, var_11, var_3.botclearscriptgoal, var_3.botgetdifficultysetting, var_3.botgetdifficulty);
        var_16 = 1;
      } else if(!var_2)
        var_0.var_1EB4 = 1;

      func_1FC2(var_0, var_11, var_12);

      if(var_16) {
        var_0 waittill("hoverunload_done");
      }
    }

    if(isDefined(var_0.var_D3E2) && isDefined(var_3.var_D09B)) {
      level.player thread scripts\engine\utility::stop_loop_sound_on_entity(var_3.var_D09B);
    }

    if(isDefined(var_3.botgetnodesonpath)) {
      var_0 thread scripts\engine\utility::stop_loop_sound_on_entity(var_3.botgetnodesonpath);
    }

    if(isDefined(var_0.var_D3E2) && isDefined(var_3.var_D09A)) {
      level.player thread scripts\sp\utility::play_sound_on_entity(var_3.var_D09A);
    }
  } else if(!isai(var_0)) {
    if(var_0.var_5BF2 == 1) {
      var_0 delete();
      return;
    }

    var_0 = func_0B77::func_10869(var_0);
  }

  self.var_E4FB = scripts\engine\utility::array_remove(self.var_E4FB, var_0);
  self.var_1307E[var_1] = 0;
  var_0.var_E500 = undefined;
  var_0.var_5BD6 = undefined;

  if(!isalive(self) && !isDefined(var_3.var_12BC8)) {
    var_0 delete();
    return;
  }

  var_0 unlink();

  if(!isDefined(var_0.var_B14F)) {
    var_0.allowdeath = 1;
  }

  if(isalive(var_0) || var_2) {
    if(isai(var_0)) {
      var_0.a.disablelongdeath = !var_0 isbadguy();
    }

    var_0.var_72AE = undefined;
    var_0 notify("jumpedout");

    if(isai(var_0)) {
      if(isDefined(var_3.botgetscriptgoalyaw)) {
        var_0.var_5270 = var_3.botgetscriptgoalyaw;
        var_0 allowedstances("crouch");
        var_0 thread scripts\anim\utility::func_12E5F();
        var_0 allowedstances("stand", "crouch", "prone");
      }

      var_0 _meth_8250(0);

      if(func_8750(var_0)) {
        var_0.goalradius = 600;
        var_0 give_mp_super_weapon(var_0.origin);
      }
    } else if(var_2) {
      var_0.var_1356F.origin = var_0.origin;
      var_0.var_1356F.angles = var_0.angles;

      if(isDefined(var_0.var_1356F.target)) {
        var_0.var_1356F scripts\sp\vehicle::func_1080B();
      } else {
        var_17 = var_0.var_1356F scripts\sp\utility::func_10808();
      }

      var_0 delete();
    }
  }

  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "delete_after_unload") {
    var_0 delete();
    return;
  }

  if(isDefined(var_3.botfirstavailablegrenade) && var_3.botfirstavailablegrenade) {
    var_0 delete();
    return;
  }

  var_0 func_872E();
}

func_8767(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self gettagorigin(var_1);
  var_6 = self gettagangles(var_1);
  var_7 = _getstartorigin(var_5, var_6, var_2);
  var_8 = _getstartangles(var_5, var_6, var_2);
  var_9 = getmovedelta(var_2, 0, 1);
  var_10 = scripts\engine\utility::spawn_tag_origin();
  var_10.origin = var_7;
  var_10.angles = var_8;
  var_11 = var_10 localtoworldcoords(var_9);
  var_10 thread scripts\sp\utility::func_5184("movedone");
  var_12 = var_11;
  var_13 = scripts\sp\utility::func_864C(var_12);
  var_14 = _getstartorigin(var_5, var_6, var_4);
  var_9 = getmovedelta(var_4, 0, 1);
  var_15 = var_14 + var_9;
  var_16 = var_14[2] - var_15[2];
  var_17 = var_13 + (0, 0, var_16);
  var_0 scripts\sp\utility::func_F2A8(0);
  var_0 setCanDamage(0);
  var_0 endon("death");
  wait(getanimlength(var_2) - 0.1);
  var_0 unlink();
  var_0 notify("animontag_thread");
  var_0 givescorefortrophyblocks();
  var_10.origin = var_0.origin;
  var_10.angles = var_0.angles;
  var_10 dontinterpolate();
  var_0 dontinterpolate();
  var_0 linkto(var_10, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_0 scripts\sp\utility::func_F2A8(1);
  var_0 setCanDamage(1);
  var_0.var_12BC4 = var_3;

  if(isai(var_0)) {
    var_0 func_0A1E::func_2307(::func_873D, ::func_873E);
  } else {
    var_0 thread func_873D();
  }

  var_18 = length((0, 0, var_17[2]) - (0, 0, var_12[2]));
  var_19 = 350;
  var_20 = var_18 / var_19;
  var_10 moveto(var_17, var_20);
  var_10 waittill("movedone");
  var_0 unlink();
  var_0 animscripted("dropship_land", var_0.origin, var_0.angles, var_4);
  wait(getanimlength(var_4));
  var_0 notify("hoverunload_done");
  var_0 notify("anim_on_tag_done");
}

func_873D() {
  if(isai(self)) {
    if(scripts\engine\utility::actor_is3d()) {
      self orientmode("face angle 3d", self.angles);
    } else {
      self orientmode("face angle", self.angles[1]);
    }

    self clearanim(func_0A1E::asm_getbodyknob(), 0.2);
  }

  self give_attacker_kill_rewards(self.var_12BC4, 1);
  self waittill("dropship_land");
}

func_873E() {}

func_8750(var_0) {
  if(isDefined(var_0.var_ED53)) {
    return 0;
  }

  if(var_0 scripts\sp\utility::func_8B6C()) {
    return 0;
  }

  if(isDefined(var_0.var_DB41)) {
    return 0;
  }

  if(!isDefined(var_0.target)) {
    return 1;
  }

  var_1 = getnodearray(var_0.target, "targetname");
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

func_1FC2(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 notify("animontag_thread");
  var_0 endon("animontag_thread");

  if(!isDefined(var_5)) {
    var_5 = "animontagdone";
  }

  if(isDefined(self.var_B91E)) {
    var_6 = self.var_B91E;
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

  if(isDefined(var_0.var_DC19) && !isDefined(var_0.var_C01B)) {
    level thread func_1FC3(var_0, self);
  }

  var_0 animscripted(var_5, var_7, var_8, var_2);

  if(isai(var_0)) {
    thread donotetracks(var_0, var_6, var_5);
  }

  if(isDefined(var_0.var_1EB4)) {
    var_0.var_1EB4 = undefined;
    var_9 = getanimlength(var_2) - 0.25;

    if(var_9 > 0) {
      wait(var_9);
    }

    if(getdvarint("ai_iw7", 0) == 1) {
      var_0 func_0A1E::func_2386();
    }

    var_0.interval = 0;
    var_0 thread func_DDFA();
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
  var_0.var_DC19 = undefined;
}

func_DDFA() {
  self endon("death");
  wait 2;

  if(self.interval == 0) {
    self.interval = 80;
  }
}

func_1FC3(var_0, var_1) {
  if(isDefined(var_0.var_B14F) && var_0.var_B14F) {
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

    if(isDefined(var_0.var_72C4)) {
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
    if(isplayer(var_3)) {
      break;
    }
  }

  if(!isalive(var_0)) {
    return;
  }
  thread func_1FC4(var_0, var_1, var_3);
}

func_1FC4(var_0, var_1, var_2) {
  var_0.var_4E2A = undefined;
  var_0.var_4E46 = undefined;
  var_0.var_1EB2 = 1;

  if(isDefined(var_0.var_DC17)) {
    var_3 = getmovedelta(var_0.var_DC17, 0, 1);
    var_4 = _physicstrace(var_0.origin + (0, 0, 16), var_0.origin - (0, 0, 10000));
    var_5 = distance(var_0.origin + (0, 0, 16), var_4);

    if(abs(var_3[2] + 16) <= abs(var_5)) {
      var_0 thread scripts\sp\utility::play_sound_on_entity("generic_death_falling");
      var_0 animscripted("fastrope_fall", var_0.origin, var_0.angles, var_0.var_DC17);
      var_0 waittillmatch("fastrope_fall", "start_ragdoll");
    }
  }

  if(!isDefined(var_0)) {
    return;
  }
  var_0.var_4E2A = undefined;
  var_0.var_4E46 = undefined;
  var_0.var_1EB2 = 1;
  var_0 notify("rope_death", var_2);
  var_0 _meth_81D0(var_2.origin, var_2);

  if(isDefined(var_0.var_EECD)) {
    var_0 notsolid();
    var_6 = getweaponmodel(var_0.weapon);
    var_7 = var_0.weapon;

    if(isDefined(var_6)) {
      var_0 detach(var_6, "tag_weapon_right");
      var_8 = var_0 gettagorigin("tag_weapon_right");
      var_9 = var_0 gettagangles("tag_weapon_right");
      level.gun = spawn("weapon_" + var_7, (0, 0, 0));
      level.gun.angles = var_9;
      level.gun.origin = var_8;
    }
  } else
    var_0 scripts\anim\shared::func_5D1A();

  if(isDefined(var_0.var_71C8)) {
    var_0[[var_0.var_71C8]]();
  }

  var_0 startragdoll();
}

donotetracks(var_0, var_1, var_2) {
  var_0 endon("newanim");
  var_1 endon("death");
  var_0 endon("death");
  var_0 scripts\anim\shared::donotetracks(var_2);
}

func_1F9D(var_0, var_1, var_2, var_3) {
  var_0 animscripted("movetospot", var_1, var_2, var_3);
  var_0 waittillmatch("movetospot", "end");
}

func_876B(var_0, var_1, var_2) {
  if(!isalive(var_0)) {
    return;
  }
  if(isDefined(self.var_C011)) {
    return;
  }
  var_3 = func_1F00(self, var_0.var_1321D);
  var_0.vehicle_build = var_1;

  if(isDefined(var_3.var_69DF)) {
    return func_872D(var_0);
  }

  if(isDefined(level.vehicle.var_116CE.var_E4F9) && isDefined(level.vehicle.var_116CE.var_E4F9[self.classname])) {
    self[[level.vehicle.var_116CE.var_E4F9[self.classname]]]();
    return;
  }

  if(isDefined(var_3.var_12BC8) && isDefined(self)) {
    if(isDefined(self.var_5970) && self.var_5970) {
      return;
    }
    thread func_8744(var_0, var_0.var_1321D, 1);
    wait(var_3.var_12BC8);

    if(isDefined(var_0) && isDefined(self)) {
      self.var_86A1 = var_0.var_1321D;
      func_1F74("unload");
    }

    return;
  }

  if(isDefined(var_0)) {
    if(isDefined(var_0.var_DC19) && var_2 != "bm21_troops") {
      return;
    }
    [[level.vehicle_canturrettargetpoint]]("MOD_RIFLE_BULLET", "torso_upper", var_0.origin);

    if(var_2 == "bm21_troops") {
      var_0.allowdeath = 1;
      var_0 _meth_81D0();
      return;
    }

    var_0 delete();
  }
}

func_19F9() {
  self endon("death");
  self waittill("loaded");
  scripts\sp\vehicle_paths::setsuit(self);
}

func_F554(var_0, var_1) {
  var_2 = var_0.var_EEC9;

  if(isDefined(var_0.var_72AE)) {
    var_2 = var_0.var_72AE;
  }

  if(isDefined(var_2)) {
    return var_2;
  }

  for(var_3 = 0; var_3 < self.var_1307E.size; var_3++) {
    if(self.var_1307E[var_3]) {
      continue;
    }
    if(isDefined(var_0.var_9FEF) && !isDefined(var_1[var_3].var_9FEF)) {
      continue;
    }
    if(!isDefined(var_0.var_9FEF) && isDefined(var_1[var_3].var_9FEF)) {
      continue;
    }
    return var_3;
  }

  if(var_0.var_9FEF) {
    return;
  }
  return;
}

func_874C(var_0, var_1, var_2) {
  var_3 = func_1F00(self, var_1);
  var_4 = self.mgturret[var_3.mgturret];

  if(!isalive(var_0)) {
    return;
  }
  var_4 endon("death");
  var_0 endon("death");

  if(isDefined(var_2) && var_2 && isDefined(var_3.var_C939)) {
    [[var_3.var_C939]](self, var_0, var_1, var_4);
  }

  scripts\sp\vehicle_code::func_F5D8(var_4);
  var_4 setdefaultdroppitch(0);
  wait 0.1;
  var_0 endon("guy_man_turret_stop");
  level thread scripts\sp\mgturret::func_B6A7(var_4, scripts\sp\utility::func_7E72());
  var_4 setturretignoregoals(1);
  var_5 = "stand";

  if(isDefined(var_3.var_12A80)) {
    var_5 = var_3.var_12A80;
  }

  var_0 scripts\sp\utility::func_13035(var_4, var_5);
}

func_8765(var_0) {
  var_0 endon("jumpedout");
  var_0 waittill("death");

  if(isDefined(var_0)) {
    var_0 unlink();
  }
}

func_872D(var_0) {
  if(!isDefined(var_0.var_1321D)) {
    return;
  }
  var_1 = var_0.var_1321D;
  var_2 = func_1F00(self, var_1);

  if(!isDefined(var_2.var_69DF)) {
    return;
  }
  [[level.vehicle_canturrettargetpoint]]("MOD_RIFLE_BULLET", "torso_upper", var_0.origin);
  var_0.var_4E2A = var_2.var_69DF;
  var_3 = self.angles;
  var_4 = var_0.origin;

  if(isDefined(var_2.var_69E0)) {
    var_4 = var_4 + anglesToForward(var_3) * var_2.var_69E0[0];
    var_4 = var_4 + anglestoright(var_3) * var_2.var_69E0[1];
    var_4 = var_4 + anglestoup(var_3) * var_2.var_69E0[2];
  }

  var_0 = func_45EE(var_0);
  func_538C(var_0, "weapon_");
  var_0 notsolid();
  var_0.origin = var_4;
  var_0.angles = var_3;
  var_0 animscripted("deathanim", var_4, var_3, var_2.var_69DF);
  var_5 = 0.3;

  if(isDefined(var_2.var_69E1)) {
    var_5 = var_2.var_69E1;
  }

  var_6 = getanimlength(var_2.var_69DF);
  var_7 = gettime() + var_6 * 1000;
  wait(var_6 * var_5);
  var_8 = (0, 0, 1);
  var_9 = var_0.origin;

  if(getdvar("ragdoll_enable") == "0") {
    var_0 delete();
    return;
  }

  if(isai(var_0)) {
    var_0 scripts\anim\shared::func_5D1A();
  } else {
    func_538C(var_0, "weapon_");
  }

  while(!var_0 _meth_81B7() && gettime() < var_7) {
    var_9 = var_0.origin;
    wait 0.05;
    var_8 = var_0.origin - var_9;

    if(isDefined(var_0.var_71C8)) {
      var_0[[var_0.var_71C8]]();
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

  if(!var_0 _meth_81B7()) {
    var_0 delete();
  }
}

func_45EE(var_0, var_1) {
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

  var_2 glinton(#animtree);

  if(isDefined(var_0.team)) {
    var_2.team = var_0.team;
  }

  if(!var_1) {
    var_0 delete();
  }

  var_2 makefakeai();
  return var_2;
}

vehicle_animate(var_0, var_1) {
  self glinton(var_1);
  self give_attacker_kill_rewards(var_0);
}

func_131E5(var_0) {
  var_1 = func_1F00(self, var_0);
  return func_131E0(var_1.var_7F12, var_1.var_10220, var_0);
}

func_131E0(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_4 = undefined;
  var_5 = undefined;
  var_6 = self gettagorigin(var_1);
  var_7 = self gettagangles(var_1);
  var_4 = _getstartorigin(var_6, var_7, var_0);
  var_5 = _getstartangles(var_6, var_7, var_0);
  var_3.origin = var_4;
  var_3.angles = var_5;
  var_3.var_1321D = var_2;
  return var_3;
}

func_9C8A(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    return 1;
  }

  var_3 = var_0.classname;
  var_4 = level.vehicle.var_116CE.var_12BCF[var_3][var_2];

  foreach(var_6 in var_4) {
    if(var_6 == var_1) {
      return 1;
    }
  }

  return 0;
}

func_7851(var_0) {
  var_1 = level.vehicle.var_116CE.var_1A03[self.classname];
  var_2 = [];
  var_3 = [];

  for(var_4 = 0; var_4 < self.var_1307E.size; var_4++) {
    if(self.var_1307E[var_4]) {
      continue;
    }
    if(isDefined(var_1[var_4].var_7F12) && func_9C8A(self, var_4, var_0)) {
      var_2[var_2.size] = func_131E5(var_4);
      continue;
    }

    var_3[var_3.size] = var_4;
  }

  var_5 = spawnStruct();
  var_5.var_26A3 = var_2;
  var_5.var_C07E = var_3;
  return var_5;
}

func_7DC5() {
  if(isDefined(self.var_B91E)) {
    return self.var_B91E;
  } else {
    return self;
  }
}

func_538C(var_0, var_1) {
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

func_FF4D() {
  if(!isai(self)) {
    return 0;
  }

  if(!isDefined(self.var_C6F8)) {
    return 0;
  }

  return !isDefined(self.var_B14F);
}

func_10B38(var_0) {
  self waittill("stable_for_unlink");

  if(isalive(var_0)) {
    var_0 unlink();
  }
}

func_1F74(var_0) {
  var_1 = [];

  foreach(var_3 in self.var_E4FB) {
    if(isai(var_3) && !isalive(var_3)) {
      continue;
    }
    if(isDefined(level.vehicle.var_1A02[var_0]) && ![
        [level.vehicle.var_1A02[var_0]]
      ](var_3, var_3.var_1321D)) {
      continue;
    }
    if(isDefined(level.vehicle.var_1A04[var_0])) {
      var_3 notify("newanim");
      var_3.var_DB8E = [];
      thread[[level.vehicle.var_1A04[var_0]]](var_3, var_3.var_1321D);
      var_1[var_1.size] = var_3;
      continue;
    }
  }

  return var_1;
}

func_872E() {
  self.var_131F5 = undefined;
  self.var_10B71 = undefined;
  self.var_1321D = undefined;
  self.delay = undefined;
}