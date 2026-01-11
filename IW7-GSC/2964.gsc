/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2964.gsc
***************************************/

func_8739(var_00, var_01) {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.vehicletype)) {
    return;
  }
  var_02 = self.classname;
  var_03 = level.vehicle.func_116CE.func_1A03[var_02];
  self.func_247C[self.func_247C.size] = var_00;
  var_04 = func_F554(var_00, var_03);

  if(!isDefined(var_04)) {
    return;
  }
  if(var_04 == 0) {
    var_0.func_5BD6 = 1;
  }

  var_05 = func_1F00(self, var_04);
  self.func_1307E[var_04] = 1;
  var_0.func_1321D = var_04;
  var_0.func_131F5 = 0;

  if(isDefined(var_5.delay)) {
    var_0.delay = var_5.delay;

    if(isDefined(var_5.func_510B)) {
      self.func_5107 = var_0.delay;
    }
  }

  if(isDefined(var_5.func_510B)) {
    self.func_5107 = self.func_5107 + var_5.func_510B;
    var_0.delay = self.func_5107;
  }

  var_0.func_E500 = self;
  var_0.func_C6F8 = var_0.health;
  var_0.func_131F2 = var_5.func_92CC;
  var_0.func_13240 = var_5.func_10B69;
  var_0.func_4E2A = var_5.death;
  var_0.func_4E2E = var_5.func_4E5E;
  var_0.func_10B71 = 0;
  var_0.allowdeath = 0;

  if(isDefined(var_0.func_4E2A) && !isDefined(var_0.func_B14F) && vehicle_allows_driver_death()) {
    if(var_0.func_1321D != 0 || vehicle_all_stop_func()) {
      var_0.allowdeath = !isDefined(var_0.func_ECED) || var_0.func_ECED;

      if(isDefined(var_5.func_4E14)) {
        var_0.noragdoll = var_5.func_4E14;
      }
    }
  }

  if(var_0.classname == "script_model") {
    if(isDefined(var_5.death) && var_0.allowdeath && (!isDefined(var_0.func_ECED) || var_0.func_ECED)) {
      thread func_8730(var_00, var_05);
    }
  }

  if(!isDefined(var_0.func_131F2)) {
    var_0.allowdeath = 1;
  }

  self.func_E4FB[self.func_E4FB.size] = var_00;

  if(var_0.classname != "script_model" && scripts\sp\utility::func_106ED(var_00)) {
    return;
  }
  var_06 = self gettagorigin(var_5.func_10220);
  var_07 = self gettagangles(var_5.func_10220);
  func_AD14(var_00, var_5.func_10220, var_5.func_10221, var_5.func_AD46);

  if(isai(var_00)) {
    var_00 _meth_83B9(var_06, var_07);
    var_0.a.disablelongdeath = 1;

    if(isDefined(var_5.func_2AB6) && !var_5.func_2AB6) {
      var_00 scripts\sp\utility::func_86E4();
    }

    if(func_8755(var_05)) {
      thread func_874C(var_00, var_04, var_01);
    }
  } else {
    if(isDefined(var_5.func_2AB6) && !var_5.func_2AB6) {
      func_538C(var_00, "weapon_");
    }

    var_0.origin = var_06;
    var_0.angles = var_07;
  }

  if(var_04 == 0 && isDefined(var_3[0].death)) {
    thread func_5BCE(var_00);
  }

  self notify("guy_entered", var_00, var_04);
  thread func_8743(var_00, var_04);

  if(isDefined(var_5.func_E4FA)) {
    var_00[[var_5.func_E4FA]]();
  }
  else {
    if(isDefined(var_5.func_7F14)) {
      thread[[var_5.func_7F14]](var_00, var_04);
      return;
    }

    thread func_8744(var_00, var_04);
  }
}

vehicle_all_stop_func() {
  if(!isDefined(self.func_ECEB)) {
    return 0;
  }

  return self.func_ECEB;
}

vehicle_allows_driver_death() {
  if(!isDefined(self.func_ECEC)) {
    return 1;
  }

  return self.func_ECEC;
}

func_8755(var_00) {
  if(!isDefined(var_0.mgturret)) {
    return 0;
  }

  if(!isDefined(self.func_EE5E)) {
    return 1;
  }

  return !self.func_EE5E;
}

func_88AE() {
  var_00 = self.classname;
  self.func_247C = [];

  if(!(isDefined(level.vehicle.func_116CE.func_1A03) && isDefined(level.vehicle.func_116CE.func_1A03[var_00]))) {
    return;
  }
  var_01 = level.vehicle.func_116CE.func_1A03[var_00].size;

  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "ai_wait_go") {
    thread func_19F9();
  }

  self.func_E880 = [];
  self.func_1307E = [];
  self.func_7F1A = [];
  self.func_5107 = 0;
  var_02 = level.vehicle.func_116CE.func_1A03[var_00];

  for(var_03 = 0; var_03 < var_01; var_3++) {
    self.func_1307E[var_03] = 0;

    if(isDefined(self.func_EE5E) && self.func_EE5E && isDefined(var_2[var_03].func_2B10) && var_2[var_03].func_2B10) {
      self.func_1307E[1] = 1;
    }
  }
}

func_ADA8(var_00) {
  func_ADA7(var_00, 1);
}

func_8730(var_00, var_01) {
  waittillframeend;
  var_00 setCanDamage(1);
  var_00 endon("death");
  var_0.allowdeath = 0;
  var_0.health = 10150;

  if(isDefined(var_0.func_EEC8)) {
    var_0.health = var_0.health + var_0.func_EEC8;
  }

  var_00 endon("jumping_out");

  if(isDefined(var_0.func_B14F) && var_0.func_B14F) {
    while(isDefined(var_0.func_B14F) && var_0.func_B14F) {
      wait 0.05;
    }
  }

  while(var_0.health > 10000) {
    var_00 waittill("damage");
  }

  thread func_8732(var_00, var_01);
}

func_8732(var_00, var_01) {
  var_02 = gettime() + getanimlength(var_1.death) * 1000;
  var_03 = var_0.angles;
  var_04 = var_0.origin;
  var_00 = func_45EE(var_00);
  [
    [level.vehicle_canturrettargetpoint]
  ]("MOD_RIFLE_BULLET", "torso_upper", var_04);
  func_538C(var_00, "weapon_");
  var_00 linkto(self);
  var_00 notsolid();
  var_00 give_attacker_kill_rewards(var_1.death);

  if(isai(var_00)) {
    var_00 scripts\anim\shared::func_5D1A();
  }
  else {
    func_538C(var_00, "weapon_");
  }

  if(isDefined(var_1.func_4E00)) {
    var_00 unlink();

    if(isDefined(var_0.func_71C8)) {
      var_00[[var_0.func_71C8]]();
    }

    var_00 startragdoll();
    wait(var_1.func_4E00);
    var_00 delete();
    return;
  }
}

func_ADA7(var_00, var_01, var_02) {
  if(!isDefined(var_01)) {
    var_01 = 0;
  }

  scripts\sp\utility::func_65DD("unloaded");
  scripts\sp\utility::func_65DD("loaded");
  scripts\engine\utility::array_levelthread(var_00, ::func_7A35, var_01, var_02);
}

func_9CA7(var_00) {
  for(var_01 = 0; var_01 < self.func_E4FB.size; var_1++) {
    if(self.func_E4FB[var_01] == var_00) {
      return 1;
    }
  }

  return 0;
}

func_7A35(var_00, var_01, var_02) {
  if(func_9CA7(var_00)) {
    return;
  }
  if(!func_88D2()) {
    return;
  }
  func_8752(var_00, self, var_01, var_02);
}

func_88D2() {
  if(func_131EE()) {
    return 1;
  }
}

func_131EE() {
  if(level.vehicle.func_116CE.func_1A03[self.classname].size - self.func_E880.size) {
    return 1;
  }
  else {
    return 0;
  }
}

func_8754(var_00, var_01) {
  var_01 endon("death");
  var_01 endon("stop_loading");
  var_02 = var_00 scripts\engine\utility::waittill_any_return("long_death", "death", "enteredvehicle");

  if(var_02 != "enteredvehicle" && isDefined(var_0.func_72AE)) {
    var_1.func_1307E[var_0.func_72AE] = 0;
  }

  var_1.func_E880 = scripts\engine\utility::array_remove(var_1.func_E880, var_00);
  func_13211(var_01);
}

func_13211(var_00) {
  if(isDefined(var_0.vehicletype) && isDefined(var_0.func_13212)) {
    if(var_0.func_E4FB.size == var_0.func_13212) {
      var_00 scripts\sp\utility::func_65E1("loaded");
    }
  } else if(!var_0.func_E880.size && var_0.func_E4FB.size) {
    if(var_0.func_1307E[0]) {
      var_00 scripts\sp\utility::func_65E1("loaded");
    }
    else {
      var_00 thread func_1321F();
    }
  }
}

func_1321F() {
  var_00 = self.func_E4FB;
  scripts\sp\vehicle::func_13253();
  scripts\sp\utility::func_65E3("unloaded");
  var_00 = scripts\sp\utility::func_22B9(var_00);
  thread scripts\sp\vehicle::func_1320F(var_00);
}

func_E054(var_00) {
  scripts\engine\utility::waittill_any("unload", "death");
  var_00 scripts\sp\utility::func_1101B();
}

func_8752(var_00, var_01, var_02, var_03) {
  var_01 endon("stop_loading");
  var_04 = 1;

  if(!isDefined(var_02)) {
    var_02 = 0;
  }

  var_05 = level.vehicle.func_116CE.func_1A03[var_1.classname];

  if(isDefined(var_1.func_E8A8)) {
    var_01 thread[[var_1.func_E8A8]](var_00);
    return;
  }

  var_01 endon("death");
  var_00 endon("death");
  var_1.func_E880[var_1.func_E880.size] = var_00;
  thread func_8754(var_00, var_01);
  var_06 = [];
  var_07 = undefined;
  var_08 = 0;
  var_09 = 0;

  for(var_10 = 0; var_10 < var_5.size; var_10++) {
    if(isDefined(var_5[var_10].func_7F12)) {
      var_09 = 1;
    }
  }

  if(!var_09) {
    var_00 notify("enteredvehicle");
    var_01 func_8739(var_00, var_04);
    return;
  }

  if(!isDefined(var_0.func_7A34)) {
    while(var_01 vehicle_getspeed() > 1) {
      wait 0.05;
    }
  }

  var_11 = var_01 func_7851(var_03);

  if(isDefined(var_0.func_EEC9)) {
    var_07 = var_01 func_131E5(var_0.func_EEC9);
  }
  else if(!var_1.func_1307E[0]) {
    var_07 = var_01 func_131E5(0);

    if(var_02) {
      var_00 thread scripts\sp\utility::func_B14F();
      thread func_E054(var_00);
    }
  } else if(var_11.func_26A3.size)
    var_07 = scripts\engine\utility::getclosest(var_0.origin, var_11.func_26A3);
  else {
    var_07 = undefined;
  }

  if(!var_11.func_26A3.size && var_11.func_C07E.size) {
    var_00 notify("enteredvehicle");
    var_01 func_8739(var_00, var_04);
    return;
  } else if(!isDefined(var_07)) {
    return;
  }
  var_08 = var_7.origin;
  var_12 = var_7.angles;
  var_0.func_72AE = var_7.func_1321D;
  var_1.func_1307E[var_7.func_1321D] = 1;
  var_0.func_EE2B = 1;
  var_00 notify("stop_going_to_node");
  var_00 scripts\sp\utility::func_F3BC();
  var_00 scripts\sp\utility::func_5504();
  var_0.goalradius = 16;
  var_00 give_mp_super_weapon(var_08);
  var_00 waittill("goal");
  var_00 scripts\sp\utility::func_61DB();
  var_00 scripts\sp\utility::func_12BFA();
  var_00 notify("boarding_vehicle");
  var_13 = func_1F00(var_01, var_7.func_1321D);

  if(isDefined(var_13.delay)) {
    var_0.delay = var_13.delay;

    if(isDefined(var_13.func_510B)) {
      self.func_5107 = var_0.delay;
    }
  }

  if(isDefined(var_13.func_510B)) {
    self.func_5107 = self.func_5107 + var_13.func_510B;
    var_0.delay = self.func_5107;
  }

  var_01 func_AD14(var_00, var_13.func_10220, var_13.func_10221, var_13.func_AD46);
  var_0.allowdeath = 0;
  var_13 = var_5[var_7.func_1321D];

  if(isDefined(var_07)) {
    if(isDefined(var_13.func_131E1)) {
      if(isDefined(var_13.func_131E6)) {
        var_14 = isDefined(var_0.func_C01A);

        if(!var_14) {
          var_01 clearanim(var_13.func_131E6, 0);
        }
      }

      var_01 = var_01 func_7DC5();
      var_01 thread func_F642(var_13.func_131E1, var_13.func_131E2);
      level thread scripts\sp\anim::func_10CBF(var_01, "vehicle_anim_flag", undefined, undefined, var_13.func_131E1);
    }

    if(isDefined(var_13.func_131E4)) {
      var_08 = var_01 gettagorigin(var_13.func_131E4);
    }
    else {
      var_08 = var_1.origin;
    }

    if(isDefined(var_13.func_131E3)) {
      _playworldsound(var_13.func_131E3, var_08);
    }

    var_15 = undefined;
    var_16 = undefined;

    if(isDefined(var_13.func_7F13)) {
      var_15 = [];
      var_15[0] = var_13.func_7F13;
      var_16 = [];
      var_16[0] = ::func_6623;
      var_01 func_AD14(var_00, var_13.func_10220, var_13.func_10221, var_13.func_AD46);
    }

    var_01 func_1FC2(var_00, var_13.func_10220, var_13.func_7F12, var_15, var_16);
  }

  var_00 notify("enteredvehicle");
  var_01 func_8739(var_00, var_04);
}

func_6623() {
  self notify("enteredvehicle");
}

func_5BCE(var_00) {
  if(scripts\sp\vehicle::func_9E2C()) {
    return;
  }
  self.func_5BC8 = var_00;
  self endon("death");
  var_00 endon("jumping_out");
  var_00 waittill("death");

  if(isDefined(self.func_131F9)) {
    return;
  }
  self notify("driver dead");
  self.func_4DEF = 1;

  if(isDefined(self.func_8C2D) && self.func_8C2D) {
    self setwaitspeed(0);
    self vehicle_setspeed(0, 10);
    self waittill("reached_wait_speed");
  }

  scripts\sp\vehicle::func_13253();
}

func_872C(var_00, var_01) {
  if(isai(var_00)) {
    return var_00;
  }

  if(var_0.func_5BF2 == 1) {
    var_00 delete();
  }
  else {
    var_00 = func_0B77::func_10869(var_00);
    var_02 = self.classname;
    var_03 = level.vehicle.func_116CE.func_1A03[var_02].size;
    var_04 = func_1F00(self, var_01);
    func_AD14(var_00, var_4.func_10220, var_4.func_10221, var_4.func_AD46);
    var_0.func_131F2 = var_4.func_92CC;
    thread func_8744(var_00, var_01);
  }
}

func_AD14(var_00, var_01, var_02, var_03) {
  if(!isDefined(var_02)) {
    var_02 = (0, 0, 0);
  }

  if(!isDefined(var_03)) {
    var_03 = 0;
  }

  if(var_03 && !isDefined(var_0.func_ED6E)) {
    var_00 _meth_81E1(self, var_01, 0);
  }
  else {
    var_00 linkto(self, var_01, var_02, (0, 0, 0));
  }
}

func_1F00(var_00, var_01) {
  return level.vehicle.func_116CE.func_1A03[var_0.classname][var_01];
}

func_8731(var_00, var_01) {
  var_00 waittill("death");

  if(!isDefined(self)) {
    return;
  }
  self.func_E4FB = scripts\engine\utility::array_remove(self.func_E4FB, var_00);
  self.func_1307E[var_01] = 0;
}

func_F8AE() {
  if(!isDefined(level.vehicle.func_1A04)) {
    level.vehicle.func_1A04 = [];
  }

  if(!isDefined(level.vehicle.func_1A02)) {
    level.vehicle.func_1A02 = [];
  }

  level.vehicle.func_1A04["idle"] = ::func_8744;
  level.vehicle.func_1A04["unload"] = ::func_8766;
}

func_8743(var_00, var_01) {
  var_0.func_131F5 = 1;
  thread func_8731(var_00, var_01);
}

func_5BC9(var_00, var_01) {
  var_00 endon("newanim");
  self endon("death");
  var_00 endon("death");
  var_02 = func_1F00(self, var_01);

  for(;;) {
    if(self vehicle_getspeed() == 0) {
      var_0.func_131F2 = var_2.func_92D5;
    }
    else {
      var_0.func_131F2 = var_2.func_92D0;
    }

    wait 0.25;
  }
}

func_8744(var_00, var_01, var_02) {
  var_00 endon("newanim");

  if(!isDefined(var_02)) {
    self endon("death");
  }

  var_00 endon("death");
  var_0.func_131F5 = 1;
  var_00 notify("gotime");

  if(!isDefined(var_0.func_131F2)) {
    return;
  }
  var_03 = func_1F00(self, var_01);

  if(isDefined(var_3.mgturret)) {
    return;
  }
  if(isDefined(var_3.func_92D5) && isDefined(var_3.func_92D0)) {
    thread func_5BC9(var_00, var_01);
  }

  for(;;) {
    var_00 notify("idle");
    func_CDAA(var_00, var_03);
  }
}

func_CDAA(var_00, var_01) {
  if(isDefined(var_0.func_131F3)) {
    func_1FC2(var_00, var_1.func_10220, var_0.func_131F3);
    return;
  }

  if(isDefined(var_1.func_92F6)) {
    var_02 = func_DCBF(var_00, var_1.func_92F6);
    func_1FC2(var_00, var_1.func_10220, var_0.func_131F2[var_02]);
    return;
  }

  if(isDefined(var_0.func_D3E2) && isDefined(var_1.func_D0E8)) {
    func_1FC2(var_00, var_1.func_10220, var_1.func_D0E8);
    return;
  }

  if(isDefined(var_1.func_131F2)) {
    thread func_F642(var_1.func_131F2);
  }

  func_1FC2(var_00, var_1.func_10220, var_0.func_131F2);
}

func_DCBF(var_00, var_01) {
  var_02 = [];
  var_03 = 0;

  for(var_04 = 0; var_04 < var_1.size; var_4++) {
    var_03 = var_03 + var_1[var_04];
    var_2[var_04] = var_03;
  }

  var_05 = randomint(var_03);

  for(var_04 = 0; var_04 < var_1.size; var_4++) {
    if(var_05 < var_2[var_04]) {
      return var_04;
    }
  }
}

func_876A(var_00) {
  self endon("death");
  self.func_12BD0 = scripts\engine\utility::array_add(self.func_12BD0, var_00);
  var_00 scripts\engine\utility::waittill_any("death", "jumpedout");
  self.func_12BD0 = scripts\engine\utility::array_remove(self.func_12BD0, var_00);

  if(!self.func_12BD0.size) {
    scripts\sp\utility::func_65E1("unloaded");
    self.func_12BBC = "default";
  }
}

func_E4FC(var_00) {
  if(!self.func_E4FB.size) {
    return 0;
  }

  for(var_01 = 0; var_01 < self.func_E4FB.size; var_1++) {
    if(!isalive(self.func_E4FB[var_01]) && !isDefined(self.func_E4FB[var_01].func_9FEF)) {
      continue;
    }
    if(func_3DD9(self.func_E4FB[var_01].func_1321D, var_00)) {
      return 1;
    }
  }

  return 0;
}

func_7D2F() {
  var_00 = [];
  var_01 = [];
  var_02 = "default";

  if(isDefined(self.func_12BBC)) {
    var_02 = self.func_12BBC;
  }

  var_01 = level.vehicle.func_116CE.func_12BCF[self.classname][var_02];

  if(!isDefined(var_01)) {
    var_01 = level.vehicle.func_116CE.func_12BCF[self.classname]["default"];
  }

  foreach(var_04 in var_01) {
  var_0[var_04] = var_04;
  }

  return var_00;
}

func_3DD9(var_00, var_01) {
  if(!isDefined(var_01)) {
    var_01 = self.func_12BBC;
  }

  var_02 = self.classname;

  if(!isDefined(level.vehicle.func_116CE.func_12BCF[var_02])) {
    return 1;
  }

  if(!isDefined(level.vehicle.func_116CE.func_12BCF[var_02][var_01])) {
    return 1;
  }

  var_03 = level.vehicle.func_116CE.func_12BCF[var_02][var_01];

  for(var_04 = 0; var_04 < var_3.size; var_4++) {
    if(var_00 == var_3[var_04]) {
      return 1;
    }
  }

  return 0;
}

botgetscriptgoalradius(var_00, var_01, var_02) {
  self endon("unloading");

  for(;;) {
    func_1FC2(var_00, var_01, var_02);
  }
}

botgetscriptgoalnode(var_00, var_01, var_02, var_03, var_04) {
  var_05 = self.classname;

  if(var_04) {
    thread botgetscriptgoalradius(var_01, var_02, level.vehicle.func_116CE.func_247D[var_05][var_0.func_6B9D].func_92F3);
    self waittill("unloading");
  }

  self.func_12BD0 = scripts\engine\utility::array_add(self.func_12BD0, var_01);
  thread botgetpathdist(var_01, var_02, var_03);

  if(!isDefined(self.func_4828)) {
    func_1FC2(var_01, var_02, var_03);
  }

  var_01 unlink();

  if(!isDefined(self)) {
    var_01 delete();
    return;
  }

  self.func_12BD0 = scripts\engine\utility::array_remove(self.func_12BD0, var_01);

  if(!self.func_12BD0.size) {
    self notify("unloaded");
  }

  self.func_6B9D[var_0.func_6B9D] = undefined;
  wait 10;
  var_01 delete();
}

botgetscriptgoal() {
  wait 0.05;

  while(isalive(self) && self.func_12BD0.size > 2) {
    wait 0.05;
  }

  if(!isalive(self) || isDefined(self.func_4828) && self.func_4828) {
    return;
  }
  self notify("getoutrig_disable_abort");
}

botgetpersonality() {
  self endon("end_getoutrig_abort_while_deploying");

  while(!isDefined(self.func_4828)) {
    wait 0.05;
  }

  var_00 = [];

  foreach(var_02 in self.func_E4FB) {
    if(isalive(var_02)) {
      scripts\engine\utility::add_to_array(var_00, var_02);
    }
  }

  scripts\sp\utility::func_228A(var_00);
  self notify("crashed_while_deploying");
  var_00 = undefined;
}

botgetpathdist(var_00, var_01, var_02) {
  var_03 = getanimlength(var_02);
  var_04 = var_03 - 1.0;

  if(self.vehicletype == "mi17") {
    var_04 = var_03 - 0.5;
  }

  var_05 = 2.5;
  self endon("getoutrig_disable_abort");
  thread botgetscriptgoal();
  thread botgetpersonality();
  scripts\engine\utility::waittill_notify_or_timeout("crashed_while_deploying", var_05);
  self notify("end_getoutrig_abort_while_deploying");

  while(!isDefined(self.func_4828)) {
    wait 0.05;
  }

  thread func_1FC2(var_00, var_01, var_02);
  waittillframeend;
  var_00 _meth_82B0(var_02, var_04 / var_03);
  var_06 = self;

  if(isDefined(self.func_C720)) {
    var_06 = self.func_C720;
  }

  for(var_07 = 0; var_07 < self.func_E4FB.size; var_7++) {
    if(!isDefined(self.func_E4FB[var_07])) {
      continue;
    }
    if(!isDefined(self.func_E4FB[var_07].func_DC19)) {
      continue;
    }
    if(self.func_E4FB[var_07].func_DC19 != 1) {
      continue;
    }
    if(!isDefined(self.func_E4FB[var_07].func_E500)) {
      continue;
    }
    self.func_E4FB[var_07].func_72C4 = 1;

    if(isalive(self.func_E4FB[var_07])) {
      thread func_1FC4(self.func_E4FB[var_07], self, var_06);
    }
  }
}

func_F642(var_00, var_01) {
  self endon("death");
  self endon("dont_clear_anim");

  if(!isDefined(var_01)) {
    var_01 = 1;
  }

  var_02 = getanimlength(var_00);
  self endon("death");
  self _meth_82EA("vehicle_anim_flag", var_00);
  wait(var_02);

  if(var_01) {
    self clearanim(var_00, 0);
  }
}

#using_animtree("generic_human");

botgetfovdot(var_00, var_01, var_02) {
  if(!isDefined(var_02)) {
    var_02 = 1;
  }

  var_03 = self.classname;
  var_04 = func_1F00(self, var_01);

  if(isDefined(self.func_2465) && isDefined(self.func_2465[var_4.func_6B9D])) {
    var_05 = 1;
  }
  else {
    var_05 = 0;
  }

  if(!isDefined(var_4.func_6B9D) || isDefined(self.func_6B9D[var_4.func_6B9D]) || var_05) {
    return;
  }
  var_06 = var_00 gettagorigin(level.vehicle.func_116CE.func_247D[var_03][var_4.func_6B9D].tag);
  var_07 = var_00 gettagangles(level.vehicle.func_116CE.func_247D[var_03][var_4.func_6B9D].tag);
  self.func_6B9E[var_4.func_6B9D] = 1;
  var_08 = spawn("script_model", var_06);
  var_8.angles = var_07;
  var_8.origin = var_06;
  var_08 setModel(level.vehicle.func_116CE.func_247D[var_03][var_4.func_6B9D].model);
  self.func_6B9D[var_4.func_6B9D] = var_08;
  var_08 glinton(#animtree);
  var_08 linkto(var_00, level.vehicle.func_116CE.func_247D[var_03][var_4.func_6B9D].tag, (0, 0, 0), (0, 0, 0));
  thread botgetscriptgoalnode(var_04, var_08, level.vehicle.func_116CE.func_247D[var_03][var_4.func_6B9D].tag, level.vehicle.func_116CE.func_247D[var_03][var_4.func_6B9D].func_5D1B, var_02);
  return var_08;
}

func_3DCC(var_00) {
  if(!isDefined(self.func_10471)) {
    self.func_10471 = [];
  }

  var_01 = 0;

  if(!isDefined(self.func_10471[var_00])) {
    self.func_10471[var_00] = 1;
  }
  else {
    var_01 = 1;
  }

  thread func_3DCD(var_00);
  return var_01;
}

func_3DCD(var_00) {
  wait 0.05;

  if(!isDefined(self)) {
    return;
  }
  self.func_10471[var_00] = 0;
  var_01 = getarraykeys(self.func_10471);

  for(var_02 = 0; var_02 < var_1.size; var_2++) {
    if(self.func_10471[var_1[var_02]]) {
      return;
    }
  }

  self.func_10471 = undefined;
}

func_8766(var_00, var_01) {
  var_02 = 0;

  if(isDefined(var_0.func_9FEF)) {
    var_02 = 1;
  }

  var_03 = func_1F00(self, var_01);
  var_04 = self.vehicletype;

  if(!func_3DD9(var_01)) {
    thread func_8744(var_00, var_01);
    return;
  }

  if(!isDefined(var_3.botclearscriptgoal)) {
    thread func_8744(var_00, var_01);
    return;
  }

  thread func_876A(var_00);
  self endon("death");

  if(isai(var_00) && isalive(var_00)) {
    var_00 endon("death");
  }

  var_05 = 0;

  if(isDefined(var_0.autoboltmissileeffects)) {
    var_06 = var_00[[var_0.autoboltmissileeffects]]();

    if(isDefined(var_06) && var_06) {
      var_05 = 1;
    }
  }

  if(isDefined(var_0.func_C584)) {
    var_0.func_C584 = undefined;

    if(isDefined(var_0.autoboltmissileeffects)) {
      var_00[[var_0.autoboltmissileeffects]]();
    }
  }

  var_07 = func_7DC5();

  if(isDefined(var_3.func_131E6)) {
    var_07 thread func_F642(var_3.func_131E6, var_3.func_131E7);
    var_08 = 0;

    if(isDefined(var_3.func_131E9)) {
      var_08 = func_3DCC(var_3.func_131E9);
      var_09 = var_07 gettagorigin(var_3.func_131E9);
    } else
      var_09 = var_7.origin;

    if(isDefined(var_3.func_131E8) && !var_08) {
      _playworldsound(var_3.func_131E8, var_09);
    }

    var_08 = undefined;
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
    thread func_8744(var_00, var_01);
    wait(var_10);
  }

  var_0.func_4E2A = undefined;
  var_0.func_4E2E = undefined;
  var_00 notify("newanim");

  if(isDefined(var_3.func_2AB6) && !var_3.func_2AB6) {
    if(!isDefined(var_0.func_5531)) {
      var_00 scripts\sp\utility::func_86E2();
    }
  }

  if(isai(var_00)) {
    var_00 _meth_8250(1);
  }

  if(isDefined(var_3.func_2BE8)) {
    var_05 = 1;
  }
  else if(!isDefined(var_3.botclearscriptgoal) || !isDefined(self.func_EEFD) && (isDefined(var_3.func_2B10) && var_3.func_2B10) || isDefined(self.func_EDF4) && var_01 == 0) {
    thread func_8744(var_00, var_01);
    return;
  }

  if(var_00 func_FF4D()) {
    var_0.health = var_0.func_C6F8;
  }

  var_0.func_C6F8 = undefined;

  if(isai(var_00) && isalive(var_00)) {
    var_00 endon("death");
  }

  var_0.allowdeath = 0;

  if(isDefined(var_3.func_6981)) {
    var_11 = var_3.func_6981;
  }
  else {
    var_11 = var_3.func_10220;
  }

  if(isDefined(var_0.func_7B54)) {
    var_12 = var_0.func_7B54;
  }
  else if(scripts\sp\utility::func_65DB("landed") && isDefined(var_3.botgetentrancepoint)) {
    var_12 = var_3.botgetentrancepoint;
  }
  else if(isDefined(var_0.func_D3E2) && isDefined(var_3.func_D098)) {
    var_12 = var_3.func_D098;
  }
  else {
    var_12 = var_3.botclearscriptgoal;
  }

  if(!var_05) {
    thread func_8765(var_00);

    if(isDefined(var_3.func_6B9D)) {
      if(!isDefined(self.func_6B9D[var_3.func_6B9D])) {
        thread func_8744(var_00, var_01);
        var_13 = botgetfovdot(var_07, var_0.func_1321D, 0);
      }
    }

    if(isDefined(var_3.botgetscriptgoaltype)) {
      var_00 thread scripts\sp\utility::play_sound_on_tag(var_3.botgetscriptgoaltype, "J_Wrist_RI", 1);
    }

    if(isDefined(var_0.func_D3E2) && isDefined(var_3.func_D099)) {
      var_00 thread scripts\sp\utility::play_sound_on_entity(var_3.func_D099);
    }

    if(isDefined(var_3.botgetnodesonpath)) {
      var_00 thread scripts\sp\utility::play_loop_sound_on_tag(var_3.botgetnodesonpath);
    }

    if(isDefined(var_0.func_D3E2) && isDefined(var_3.func_D09B)) {
      level.player thread scripts\engine\utility::play_loop_sound_on_entity(var_3.func_D09B);
    }

    var_00 notify("newanim");
    var_00 notify("jumping_out");
    var_14 = 0;

    if(!isai(var_00) && !var_02) {
      var_14 = 1;
    }

    if(!isDefined(var_0.func_EECD) && !var_02) {
      var_00 = func_872C(var_00, var_01);
    }

    if(!isalive(var_00) && !var_02) {
      return;
    }
    if(!var_02) {
      var_0.func_DC19 = 1;
    }

    if(isDefined(var_3.func_DC19)) {
      var_0.func_DC19 = 1;

      if(isDefined(var_3.func_DC17)) {
        var_0.func_DC17 = var_3.func_DC17;
      }
    }

    if(var_14) {
      self.func_E4FB = scripts\engine\utility::array_add(self.func_E4FB, var_00);
      thread func_8731(var_00, var_01);
      thread func_876A(var_00);
      var_0.func_E500 = self;
    }

    if(isai(var_00)) {
      var_00 endon("death");
    }

    var_00 notify("newanim");
    var_00 notify("jumping_out");

    if(isDefined(var_3.func_AD88) && var_3.func_AD88) {
      thread func_10B38(var_00);
    }

    if(isDefined(var_3.botgetimperfectenemyinfo)) {
      func_1FC2(var_00, var_11, var_12);
      var_15 = var_11;

      if(isDefined(var_3.botgetmemoryevents)) {
        var_15 = var_3.botgetmemoryevents;
      }

      func_1FC2(var_00, var_15, var_3.botgetimperfectenemyinfo);
    } else {
      var_16 = 0;

      if(isDefined(var_3.botgetdifficultysetting) && isDefined(var_3.botgetdifficulty)) {
        thread func_8767(var_00, var_11, var_3.botclearscriptgoal, var_3.botgetdifficultysetting, var_3.botgetdifficulty);
        var_16 = 1;
      } else if(!var_02)
        var_0.func_1EB4 = 1;

      func_1FC2(var_00, var_11, var_12);

      if(var_16) {
        var_00 waittill("hoverunload_done");
      }
    }

    if(isDefined(var_0.func_D3E2) && isDefined(var_3.func_D09B)) {
      level.player thread scripts\engine\utility::stop_loop_sound_on_entity(var_3.func_D09B);
    }

    if(isDefined(var_3.botgetnodesonpath)) {
      var_00 thread scripts\engine\utility::stop_loop_sound_on_entity(var_3.botgetnodesonpath);
    }

    if(isDefined(var_0.func_D3E2) && isDefined(var_3.func_D09A)) {
      level.player thread scripts\sp\utility::play_sound_on_entity(var_3.func_D09A);
    }
  } else if(!isai(var_00)) {
    if(var_0.func_5BF2 == 1) {
      var_00 delete();
      return;
    }

    var_00 = func_0B77::func_10869(var_00);
  }

  self.func_E4FB = scripts\engine\utility::array_remove(self.func_E4FB, var_00);
  self.func_1307E[var_01] = 0;
  var_0.func_E500 = undefined;
  var_0.func_5BD6 = undefined;

  if(!isalive(self) && !isDefined(var_3.func_12BC8)) {
    var_00 delete();
    return;
  }

  var_00 unlink();

  if(!isDefined(var_0.func_B14F)) {
    var_0.allowdeath = 1;
  }

  if(isalive(var_00) || var_02) {
    if(isai(var_00)) {
      var_0.a.disablelongdeath = !var_00 isbadguy();
    }

    var_0.func_72AE = undefined;
    var_00 notify("jumpedout");

    if(isai(var_00)) {
      if(isDefined(var_3.botgetscriptgoalyaw)) {
        var_0.func_5270 = var_3.botgetscriptgoalyaw;
        var_00 allowedstances("crouch");
        var_00 thread scripts\anim\utility::func_12E5F();
        var_00 allowedstances("stand", "crouch", "prone");
      }

      var_00 _meth_8250(0);

      if(func_8750(var_00)) {
        var_0.goalradius = 600;
        var_00 give_mp_super_weapon(var_0.origin);
      }
    } else if(var_02) {
      var_0.func_1356F.origin = var_0.origin;
      var_0.func_1356F.angles = var_0.angles;

      if(isDefined(var_0.func_1356F.target)) {
        var_0.func_1356F scripts\sp\vehicle::func_1080B();
      }
      else {
        var_17 = var_0.func_1356F scripts\sp\utility::func_10808();
      }

      var_00 delete();
    }
  }

  if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "delete_after_unload") {
    var_00 delete();
    return;
  }

  if(isDefined(var_3.botfirstavailablegrenade) && var_3.botfirstavailablegrenade) {
    var_00 delete();
    return;
  }

  var_00 func_872E();
}

func_8767(var_00, var_01, var_02, var_03, var_04) {
  var_05 = self gettagorigin(var_01);
  var_06 = self gettagangles(var_01);
  var_07 = _getstartorigin(var_05, var_06, var_02);
  var_08 = _getstartangles(var_05, var_06, var_02);
  var_09 = getmovedelta(var_02, 0, 1);
  var_10 = scripts\engine\utility::spawn_tag_origin();
  var_10.origin = var_07;
  var_10.angles = var_08;
  var_11 = var_10 localtoworldcoords(var_09);
  var_10 thread scripts\sp\utility::func_5184("movedone");
  var_12 = var_11;
  var_13 = scripts\sp\utility::func_864C(var_12);
  var_14 = _getstartorigin(var_05, var_06, var_04);
  var_09 = getmovedelta(var_04, 0, 1);
  var_15 = var_14 + var_09;
  var_16 = var_14[2] - var_15[2];
  var_17 = var_13 + (0, 0, var_16);
  var_00 scripts\sp\utility::func_F2A8(0);
  var_00 setCanDamage(0);
  var_00 endon("death");
  wait(getanimlength(var_02) - 0.1);
  var_00 unlink();
  var_00 notify("animontag_thread");
  var_00 givescorefortrophyblocks();
  var_10.origin = var_0.origin;
  var_10.angles = var_0.angles;
  var_10 dontinterpolate();
  var_00 dontinterpolate();
  var_00 linkto(var_10, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_00 scripts\sp\utility::func_F2A8(1);
  var_00 setCanDamage(1);
  var_0.func_12BC4 = var_03;

  if(isai(var_00)) {
    var_00 func_0A1E::func_2307(::func_873D, ::func_873E);
  }
  else {
    var_00 thread func_873D();
  }

  var_18 = length((0, 0, var_17[2]) - (0, 0, var_12[2]));
  var_19 = 350;
  var_20 = var_18 / var_19;
  var_10 moveto(var_17, var_20);
  var_10 waittill("movedone");
  var_00 unlink();
  var_00 animscripted("dropship_land", var_0.origin, var_0.angles, var_04);
  wait(getanimlength(var_04));
  var_00 notify("hoverunload_done");
  var_00 notify("anim_on_tag_done");
}

func_873D() {
  if(isai(self)) {
    if(scripts\engine\utility::actor_is3d()) {
      self orientmode("face angle 3d", self.angles);
    }
    else {
      self orientmode("face angle", self.angles[1]);
    }

    self clearanim(func_0A1E::asm_getbodyknob(), 0.2);
  }

  self give_attacker_kill_rewards(self.func_12BC4, 1);
  self waittill("dropship_land");
}

func_873E() {}

func_8750(var_00) {
  if(isDefined(var_0.func_ED53)) {
    return 0;
  }

  if(var_00 scripts\sp\utility::func_8B6C()) {
    return 0;
  }

  if(isDefined(var_0.func_DB41)) {
    return 0;
  }

  if(!isDefined(var_0.target)) {
    return 1;
  }

  var_01 = getnodearray(var_0.target, "targetname");
  var_02 = scripts\engine\utility::getstructarray(var_0.target, "targetname");

  if(var_1.size > 0 || var_2.size > 0) {
    return 0;
  }

  var_03 = getent(var_0.target, "targetname");

  if(isDefined(var_03) && var_3.classname == "info_volume") {
    return 0;
  }

  return 1;
}

func_1FC2(var_00, var_01, var_02, var_03, var_04, var_05) {
  var_00 notify("animontag_thread");
  var_00 endon("animontag_thread");

  if(!isDefined(var_05)) {
    var_05 = "animontagdone";
  }

  if(isDefined(self.func_B91E)) {
    var_06 = self.func_B91E;
  }
  else {
    var_06 = self;
  }

  if(!isDefined(var_01)) {
    var_07 = var_0.origin;
    var_08 = var_0.angles;
  } else {
    var_07 = var_06 gettagorigin(var_01);
    var_08 = var_06 gettagangles(var_01);
  }

  if(isDefined(var_0.func_DC19) && !isDefined(var_0.func_C01B)) {
    level thread func_1FC3(var_00, self);
  }

  var_00 animscripted(var_05, var_07, var_08, var_02);

  if(isai(var_00)) {
    thread donotetracks(var_00, var_06, var_05);
  }

  if(isDefined(var_0.func_1EB4)) {
    var_0.func_1EB4 = undefined;
    var_09 = getanimlength(var_02) - 0.25;

    if(var_09 > 0) {
      wait(var_09);
    }

    if(getdvarint("ai_iw7", 0) == 1) {
      var_00 func_0A1E::func_2386();
    }

    var_0.interval = 0;
    var_00 thread func_DDFA();
  } else {
    if(isDefined(var_03)) {
      for(var_10 = 0; var_10 < var_3.size; var_10++) {
        var_00 waittillmatch(var_05, var_3[var_10]);
        var_00 thread[[var_4[var_10]]]();
      }
    }

    var_00 waittillmatch(var_05, "end");
  }

  var_00 notify("anim_on_tag_done");
  var_0.func_DC19 = undefined;
}

func_DDFA() {
  self endon("death");
  wait 2;

  if(self.interval == 0) {
    self.interval = 80;
  }
}

func_1FC3(var_00, var_01) {
  if(isDefined(var_0.func_B14F) && var_0.func_B14F) {
    return;
  }
  if(!isai(var_00)) {
    var_00 setCanDamage(1);
  }

  var_00 endon("anim_on_tag_done");
  var_02 = undefined;
  var_03 = undefined;
  var_04 = var_1.health <= 0;

  for(;;) {
    if(!var_04 && !(isDefined(var_01) && var_1.health > 0)) {
      break;
    }
    var_00 waittill("damage", var_02, var_03);

    if(isDefined(var_0.func_72C4)) {
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

  if(!isalive(var_00)) {
    return;
  }
  thread func_1FC4(var_00, var_01, var_03);
}

func_1FC4(var_00, var_01, var_02) {
  var_0.func_4E2A = undefined;
  var_0.func_4E46 = undefined;
  var_0.func_1EB2 = 1;

  if(isDefined(var_0.func_DC17)) {
    var_03 = getmovedelta(var_0.func_DC17, 0, 1);
    var_04 = _physicstrace(var_0.origin + (0, 0, 16), var_0.origin - (0, 0, 10000));
    var_05 = distance(var_0.origin + (0, 0, 16), var_04);

    if(abs(var_3[2] + 16) <= abs(var_05)) {
      var_00 thread scripts\sp\utility::play_sound_on_entity("generic_death_falling");
      var_00 animscripted("fastrope_fall", var_0.origin, var_0.angles, var_0.func_DC17);
      var_00 waittillmatch("fastrope_fall", "start_ragdoll");
    }
  }

  if(!isDefined(var_00)) {
    return;
  }
  var_0.func_4E2A = undefined;
  var_0.func_4E46 = undefined;
  var_0.func_1EB2 = 1;
  var_00 notify("rope_death", var_02);
  var_00 _meth_81D0(var_2.origin, var_02);

  if(isDefined(var_0.func_EECD)) {
    var_00 notsolid();
    var_06 = getweaponmodel(var_0.weapon);
    var_07 = var_0.weapon;

    if(isDefined(var_06)) {
      var_00 detach(var_06, "tag_weapon_right");
      var_08 = var_00 gettagorigin("tag_weapon_right");
      var_09 = var_00 gettagangles("tag_weapon_right");
      level.gun = spawn("weapon_" + var_07, (0, 0, 0));
      level.gun.angles = var_09;
      level.gun.origin = var_08;
    }
  } else
    var_00 scripts\anim\shared::func_5D1A();

  if(isDefined(var_0.func_71C8)) {
    var_00[[var_0.func_71C8]]();
  }

  var_00 startragdoll();
}

donotetracks(var_00, var_01, var_02) {
  var_00 endon("newanim");
  var_01 endon("death");
  var_00 endon("death");
  var_00 scripts\anim\shared::donotetracks(var_02);
}

func_1F9D(var_00, var_01, var_02, var_03) {
  var_00 animscripted("movetospot", var_01, var_02, var_03);
  var_00 waittillmatch("movetospot", "end");
}

func_876B(var_00, var_01, var_02) {
  if(!isalive(var_00)) {
    return;
  }
  if(isDefined(self.func_C011)) {
    return;
  }
  var_03 = func_1F00(self, var_0.func_1321D);
  var_0.vehicle_build = var_01;

  if(isDefined(var_3.func_69DF)) {
    return func_872D(var_00);
  }

  if(isDefined(level.vehicle.func_116CE.func_E4F9) && isDefined(level.vehicle.func_116CE.func_E4F9[self.classname])) {
    self[[level.vehicle.func_116CE.func_E4F9[self.classname]]]();
    return;
  }

  if(isDefined(var_3.func_12BC8) && isDefined(self)) {
    if(isDefined(self.func_5970) && self.func_5970) {
      return;
    }
    thread func_8744(var_00, var_0.func_1321D, 1);
    wait(var_3.func_12BC8);

    if(isDefined(var_00) && isDefined(self)) {
      self.func_86A1 = var_0.func_1321D;
      func_1F74("unload");
    }

    return;
  }

  if(isDefined(var_00)) {
    if(isDefined(var_0.func_DC19) && var_02 != "bm21_troops") {
      return;
    }
    [[level.vehicle_canturrettargetpoint]]("MOD_RIFLE_BULLET", "torso_upper", var_0.origin);

    if(var_02 == "bm21_troops") {
      var_0.allowdeath = 1;
      var_00 _meth_81D0();
      return;
    }

    var_00 delete();
  }
}

func_19F9() {
  self endon("death");
  self waittill("loaded");
  scripts\sp\vehicle_paths::setsuit(self);
}

func_F554(var_00, var_01) {
  var_02 = var_0.func_EEC9;

  if(isDefined(var_0.func_72AE)) {
    var_02 = var_0.func_72AE;
  }

  if(isDefined(var_02)) {
    return var_02;
  }

  for(var_03 = 0; var_03 < self.func_1307E.size; var_3++) {
    if(self.func_1307E[var_03]) {
      continue;
    }
    if(isDefined(var_0.func_9FEF) && !isDefined(var_1[var_03].func_9FEF)) {
      continue;
    }
    if(!isDefined(var_0.func_9FEF) && isDefined(var_1[var_03].func_9FEF)) {
      continue;
    }
    return var_03;
  }

  if(var_0.func_9FEF) {
    return;
  }
  return;
}

func_874C(var_00, var_01, var_02) {
  var_03 = func_1F00(self, var_01);
  var_04 = self.mgturret[var_3.mgturret];

  if(!isalive(var_00)) {
    return;
  }
  var_04 endon("death");
  var_00 endon("death");

  if(isDefined(var_02) && var_02 && isDefined(var_3.func_C939)) {
    [[var_3.func_C939]](self, var_00, var_01, var_04);
  }

  scripts\sp\vehicle_code::func_F5D8(var_04);
  var_04 setdefaultdroppitch(0);
  wait 0.1;
  var_00 endon("guy_man_turret_stop");
  level thread scripts\sp\mgturret::func_B6A7(var_04, scripts\sp\utility::func_7E72());
  var_04 setturretignoregoals(1);
  var_05 = "stand";

  if(isDefined(var_3.func_12A80)) {
    var_05 = var_3.func_12A80;
  }

  var_00 scripts\sp\utility::func_13035(var_04, var_05);
}

func_8765(var_00) {
  var_00 endon("jumpedout");
  var_00 waittill("death");

  if(isDefined(var_00)) {
    var_00 unlink();
  }
}

func_872D(var_00) {
  if(!isDefined(var_0.func_1321D)) {
    return;
  }
  var_01 = var_0.func_1321D;
  var_02 = func_1F00(self, var_01);

  if(!isDefined(var_2.func_69DF)) {
    return;
  }
  [
    [level.vehicle_canturrettargetpoint]
  ]("MOD_RIFLE_BULLET", "torso_upper", var_0.origin);
  var_0.func_4E2A = var_2.func_69DF;
  var_03 = self.angles;
  var_04 = var_0.origin;

  if(isDefined(var_2.func_69E0)) {
    var_04 = var_04 + anglesToForward(var_03) * var_2.func_69E0[0];
    var_04 = var_04 + anglestoright(var_03) * var_2.func_69E0[1];
    var_04 = var_04 + anglestoup(var_03) * var_2.func_69E0[2];
  }

  var_00 = func_45EE(var_00);
  func_538C(var_00, "weapon_");
  var_00 notsolid();
  var_0.origin = var_04;
  var_0.angles = var_03;
  var_00 animscripted("deathanim", var_04, var_03, var_2.func_69DF);
  var_05 = 0.3;

  if(isDefined(var_2.func_69E1)) {
    var_05 = var_2.func_69E1;
  }

  var_06 = getanimlength(var_2.func_69DF);
  var_07 = gettime() + var_06 * 1000;
  wait(var_06 * var_05);
  var_08 = (0, 0, 1);
  var_09 = var_0.origin;

  if(getdvar("ragdoll_enable") == "0") {
    var_00 delete();
    return;
  }

  if(isai(var_00)) {
    var_00 scripts\anim\shared::func_5D1A();
  }
  else {
    func_538C(var_00, "weapon_");
  }

  while(!var_00 _meth_81B7() && gettime() < var_07) {
    var_09 = var_0.origin;
    wait 0.05;
    var_08 = var_0.origin - var_09;

    if(isDefined(var_0.func_71C8)) {
      var_00[[var_0.func_71C8]]();
    }

    var_00 startragdoll();
  }

  wait 0.05;
  var_08 = var_08 * 20000;

  for(var_10 = 0; var_10 < 3; var_10++) {
    if(isDefined(var_00)) {
      var_09 = var_0.origin;
    }

    wait 0.05;
  }

  if(!var_00 _meth_81B7()) {
    var_00 delete();
  }
}

func_45EE(var_00, var_01) {
  if(!isDefined(var_01)) {
    var_01 = 0;
  }

  var_02 = spawn("script_model", var_0.origin);
  var_2.angles = var_0.angles;
  var_02 setModel(var_0.model);
  var_03 = var_00 getattachsize();

  for(var_04 = 0; var_04 < var_03; var_4++) {
    var_02 attach(var_00 getattachmodelname(var_04), var_00 getattachtagname(var_04));
  }

  var_02 glinton(#animtree);

  if(isDefined(var_0.team)) {
    var_2.team = var_0.team;
  }

  if(!var_01) {
    var_00 delete();
  }

  var_02 makefakeai();
  return var_02;
}

vehicle_animate(var_00, var_01) {
  self glinton(var_01);
  self give_attacker_kill_rewards(var_00);
}

func_131E5(var_00) {
  var_01 = func_1F00(self, var_00);
  return func_131E0(var_1.func_7F12, var_1.func_10220, var_00);
}

func_131E0(var_00, var_01, var_02) {
  var_03 = spawnStruct();
  var_04 = undefined;
  var_05 = undefined;
  var_06 = self gettagorigin(var_01);
  var_07 = self gettagangles(var_01);
  var_04 = _getstartorigin(var_06, var_07, var_00);
  var_05 = _getstartangles(var_06, var_07, var_00);
  var_3.origin = var_04;
  var_3.angles = var_05;
  var_3.func_1321D = var_02;
  return var_03;
}

func_9C8A(var_00, var_01, var_02) {
  if(!isDefined(var_02)) {
    return 1;
  }

  var_03 = var_0.classname;
  var_04 = level.vehicle.func_116CE.func_12BCF[var_03][var_02];

  foreach(var_06 in var_04) {
    if(var_06 == var_01) {
      return 1;
    }
  }

  return 0;
}

func_7851(var_00) {
  var_01 = level.vehicle.func_116CE.func_1A03[self.classname];
  var_02 = [];
  var_03 = [];

  for(var_04 = 0; var_04 < self.func_1307E.size; var_4++) {
    if(self.func_1307E[var_04]) {
      continue;
    }
    if(isDefined(var_1[var_04].func_7F12) && func_9C8A(self, var_04, var_00)) {
      var_2[var_2.size] = func_131E5(var_04);
      continue;
    }

    var_3[var_3.size] = var_04;
  }

  var_05 = spawnStruct();
  var_5.func_26A3 = var_02;
  var_5.func_C07E = var_03;
  return var_05;
}

func_7DC5() {
  if(isDefined(self.func_B91E)) {
    return self.func_B91E;
  }
  else {
    return self;
  }
}

func_538C(var_00, var_01) {
  var_02 = var_00 getattachsize();
  var_03 = [];
  var_04 = [];
  var_05 = 0;

  for(var_06 = 0; var_06 < var_02; var_6++) {
    var_07 = var_00 getattachmodelname(var_06);
    var_08 = var_00 getattachtagname(var_06);

    if(issubstr(var_07, var_01)) {
      var_3[var_05] = var_07;
      var_4[var_05] = var_08;
    }
  }

  for(var_06 = 0; var_06 < var_3.size; var_6++) {
    var_00 detach(var_3[var_06], var_4[var_06]);
  }
}

func_FF4D() {
  if(!isai(self)) {
    return 0;
  }

  if(!isDefined(self.func_C6F8)) {
    return 0;
  }

  return !isDefined(self.func_B14F);
}

func_10B38(var_00) {
  self waittill("stable_for_unlink");

  if(isalive(var_00)) {
    var_00 unlink();
  }
}

func_1F74(var_00) {
  var_01 = [];

  foreach(var_03 in self.func_E4FB) {
    if(isai(var_03) && !isalive(var_03)) {
      continue;
    }
    if(isDefined(level.vehicle.func_1A02[var_00]) && ![
        [level.vehicle.func_1A02[var_00]]
      ](var_03, var_3.func_1321D)) {
      continue;
    }
    if(isDefined(level.vehicle.func_1A04[var_00])) {
      var_03 notify("newanim");
      var_3.func_DB8E = [];
      thread[[level.vehicle.func_1A04[var_00]]](var_03, var_3.func_1321D);
      var_1[var_1.size] = var_03;
      continue;
    }
  }

  return var_01;
}

func_872E() {
  self.func_131F5 = undefined;
  self.func_10B71 = undefined;
  self.func_1321D = undefined;
  self.delay = undefined;
}