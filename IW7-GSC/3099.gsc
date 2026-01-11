/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3099.gsc
***************************************/

func_13CC4() {
  self.func_284B = 0;
  self.func_284C[0] = "tag_flash_left";
  self.func_284C[1] = "tag_flash_right";

  if(self.func_9B4C) {
    func_0BDC::func_19AA("spaceship_ai_energy_projectile");
  } else {
    func_0BDC::func_19AA("spaceship_ai_30mm_projectile");
  }
}

func_594D() {
  self endon("firemode changed");
  self waittill("hellfreezesover");
}

func_1A3F() {
  var_00 = func_7912();

  if(!isalive(var_00)) {
    return 0;
  }

  var_01 = anglesToForward(self.angles);
  var_02 = var_0.origin - self.origin;
  var_01 = vectornormalize(var_01);
  var_02 = vectornormalize(var_02);
  var_03 = distancesquared(self.origin, var_0.origin);
  return vectordot(var_01, var_02) > 0.9659 && var_03 < 625000000;
}

func_FE56() {
  self endon("firemode changed");

  for(;;) {
    while(!func_1A3F()) {
      wait 0.05;
    }

    while(func_1A3F()) {
      if(isDefined(self.var_1198.func_D9BA)) {
        var_00 = self[[self.var_1198.func_D9BA]](self.var_1198.func_E1AD);

        if(!isDefined(var_00) || var_00 == 1) {
          func_10208();
        }

        continue;
      }

      func_10208();
    }
  }

  self waittill("hellfreezesover");
}

func_FE73() {
  self endon("firemode changed");

  for(;;) {
    func_6D54();
    wait(randomfloatrange(0.5, 1.0));
  }
}

func_FE80() {
  self endon("firemode changed");
  func_6D54();
  func_0BDC::func_19AE("dont_shoot");
}

func_FE60() {
  self endon("firemode changed");
  func_9760();
  func_6D55();
}

func_6D54() {
  var_00 = func_7912();
  func_9561(var_00, 20000);
  var_01 = floor(self.var_1198.shootparams.time / (self.func_13C87 * 1000)) + 1;

  if(func_65F1(var_00)) {
    self.var_1198.func_6D83 = "jackal_gatling_fire_at_plr";
  } else {
    self.var_1198.func_6D83 = "jackal_gatling_fire";
  }

  if(scripts\engine\utility::flag_exist("jackal_shooting")) {
    if(!scripts\engine\utility::flag("jackal_shooting")) {
      thread scripts\sp\utility::play_loop_sound_on_tag(self.var_1198.func_6D83, "tag_spotlight", 1, 1, "jackal_gatling_release");
    }
  } else
    thread scripts\sp\utility::play_loop_sound_on_tag(self.var_1198.func_6D83, "tag_spotlight", 1, 1, "jackal_gatling_release");

  var_02 = 0;

  if(!scripts\sp\utility::func_65DF("jackal_firing")) {
    scripts\sp\utility::func_65E0("jackal_firing");
  }

  scripts\sp\utility::func_65E1("jackal_firing");

  while(var_02 < var_01) {
    func_6D2F();
    var_2++;
    wait(self.func_13C87);
  }

  scripts\sp\utility::func_65DD("jackal_firing");
  self notify("stop sound" + self.var_1198.func_6D83);
}

func_65F1(var_00) {
  if(isDefined(level.func_D127) && isDefined(var_00) && var_00 == level.func_D127) {
    return 1;
  } else {
    return 0;
  }
}

func_6D55() {
  self endon("firemode changed");
  self endon("death");

  if(func_65F1(func_7912())) {
    self.var_1198.func_6D83 = "jackal_gatling_fire_at_plr";
  } else {
    self.var_1198.func_6D83 = "jackal_gatling_fire";
  }

  var_00 = 0;

  if(scripts\engine\utility::flag_exist("jackal_shooting")) {
    if(!scripts\engine\utility::flag("jackal_shooting")) {
      thread scripts\sp\utility::play_loop_sound_on_tag(self.var_1198.func_6D83, "tag_spotlight", 1, 1, "jackal_gatling_release");
    }
  } else
    thread scripts\sp\utility::play_loop_sound_on_tag(self.var_1198.func_6D83, "tag_spotlight", 1, 1, "jackal_gatling_release");

  if(!scripts\sp\utility::func_65DF("jackal_firing")) {
    scripts\sp\utility::func_65E0("jackal_firing");
  }

  scripts\sp\utility::func_65E1("jackal_firing");

  for(;;) {
    func_6D2F();
    wait(self.func_13C87);
  }

  scripts\sp\utility::func_65DD("jackal_firing");
}

func_79CF() {
  if(isDefined(self.var_1198.shootparams) && isDefined(self.var_1198.shootparams.func_0148)) {
    var_00 = self.var_1198.shootparams.func_0148;
  } else {
    var_00 = 1.0;
  }

  return var_00;
}

func_77C8() {
  if(isDefined(self.func_154D)) {
    return self.func_154D;
  }

  return self.var_1198.accuracy;
}

func_10208() {
  func_6D54();
  wait(randomfloatrange(0.5, 1.0));
}

func_AAE2() {
  self endon("firemode changed");

  for(;;) {
    if(!isalive(self.enemy)) {
      wait 0.05;
      continue;
    }

    func_10208();
  }
}

func_36D1(var_00) {
  var_01 = scripts\sp\math::func_C097(0, 25000.0, distance(self.origin, var_0.origin));
  var_02 = func_36D2();
  var_02 = var_02 * var_01;
  var_02 = var_02 * (1 - func_77C8());
  return var_02;
}

func_36D2() {
  var_00 = vectornormalize((randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-1, 1)));
  var_01 = var_00 * (2000.0 * randomfloat(1));
  return var_01;
}

func_36D0(var_00, var_01) {
  var_02 = (1, 0, 0);
  var_03 = randomfloatrange(0, 360.0);
  var_04 = (0, 0, var_03);
  rotatevector(var_02, var_04);
  var_05 = var_02 * var_00;
  var_06 = var_1.origin - self.origin;
  var_06 = vectornormalize(var_06);
  var_07 = (0, 0, 1);

  if(vectordot(var_06, var_07) > 0.99) {
    var_07 = (-1, 0, 0);
  }

  var_08 = vectorcross(var_06, var_07);
  var_09 = _axistoangles(var_06, var_08, var_07);
  rotatevector(var_05, var_09);
  return var_05;
}

func_36D6(var_00) {
  var_01 = func_36D1(var_00);
  return var_01;
}

func_7912() {
  if(isDefined(self.var_1198.func_11577)) {
    return self.var_1198.func_11577;
  }

  if(isDefined(self.var_1198.func_E1AD)) {
    return self.var_1198.func_E1AD;
  } else if(isDefined(self.enemy)) {
    return self.enemy;
  }
}

func_9561(var_00, var_01) {
  if(isDefined(var_00)) {
    var_02 = func_36CD(var_00, var_01);
    var_03 = func_7BC8(var_00, var_02);
    self.var_1198.shootparams.func_C36B = var_03 - var_0.origin;
    self.var_1198.shootparams.func_C36C = var_02 - var_0.origin;
  } else {
    self.var_1198.shootparams.func_C36B = (0, 0, 0);
    self.var_1198.shootparams.func_C36C = (0, 0, 0);
  }

  self.var_1198.shootparams.starttime = gettime();
  self.var_1198.shootparams.time = randomintrange(500, 1500);
  self.var_1198.shootparams.func_32AF = 1;
}

func_9760() {
  self.var_1198.shootparams.func_32AF = 0;
}

func_AAE3(var_00, var_01, var_02, var_03) {
  var_04 = var_00 - var_01;
  var_05 = var_02 - var_01;
  var_06 = vectordot(vectornormalize(var_04), vectornormalize(var_05));
  var_07 = acos(clamp(var_06, 0.0, 1.0));
  var_08 = _atan(var_03 / length(var_05));

  if(var_07 < var_08) {
    return 1;
  }

  return 0;
}

func_36CD(var_00, var_01) {
  var_02 = var_0.origin;

  if(_isaircraft(var_00)) {
    var_03 = scripts\engine\utility::mph_to_ips(var_0.spaceship_vel);
    var_04 = scripts\engine\utility::mph_to_ips(self.spaceship_vel);
    var_02 = func_36CE(self.origin, var_04, var_0.origin, var_03, var_01);
  }

  return var_02;
}

func_36CE(var_00, var_01, var_02, var_03, var_04) {
  var_05 = _projectileintercept(var_00, var_01, var_04, var_02, var_03);

  if(!isDefined(var_05)) {
    var_05 = var_02;
  }

  return var_05;
}

func_7BC8(var_00, var_01) {
  var_02 = var_01 - var_0.origin;
  var_03 = length(var_02);

  if(var_03 > 96) {
    return var_0.origin + var_02 * (var_03 + var_03 * 0.5) / var_03;
  }

  var_04 = anglesToForward(var_0.angles);
  return var_0.origin + var_04 * 2048;
}

func_36D3(var_00) {
  var_01 = gettime() - self.var_1198.shootparams.starttime;
  var_02 = clamp(var_01 / self.var_1198.shootparams.time, 0.0, 1.0);
  var_03 = 0.5;

  if(isDefined(self.func_734A)) {
    var_03 = self.func_734A;
  }

  var_02 = max(var_02, var_03);
  self.var_1198.shootparams.func_0148 = var_02;
  var_04 = func_36D1(var_00);
  var_04 = var_04 * (1 - var_02);
  var_05 = vectorlerp(self.var_1198.shootparams.func_C36B, self.var_1198.shootparams.func_C36C, var_02);
  return var_05;
}

func_36D8(var_00) {
  var_01 = self.spaceship_vel;
  var_01 = scripts\engine\utility::mph_to_ips(var_01);
  var_00 = vectornormalize(var_01);
}

func_7AAC() {
  if(self.var_1198.shootparams.func_32AF) {
    var_00 = func_79CF();
  } else {
    var_00 = 1;
  }

  var_01 = func_77C8();
  return int(scripts\sp\math::func_AB6F(3.5, 6.9, var_01 * var_00));
}

func_6D2F() {
  var_00 = func_7912();

  if(isDefined(var_00)) {
    if(self.var_1198.shootparams.func_32AF) {
      var_01 = func_36D3(var_00);
    } else {
      var_01 = func_36D6(var_00);
    }

    var_02 = func_7AAC();

    if(_isaircraft(var_00)) {
      var_03 = scripts\engine\utility::mph_to_ips(var_0.spaceship_vel);
      var_04 = scripts\engine\utility::mph_to_ips(self.spaceship_vel);
      var_05 = func_36CE(self.origin, var_04, var_0.origin, var_03, 20000);
    } else
      var_05 = var_0.origin;

    var_06 = var_01 + var_05;
  } else {
    var_07 = anglesToForward(self.angles) * 25000.0;
    var_08 = func_36D2();
    var_06 = var_07 + var_08;
    var_02 = 0;
  }

  self setturrettargetvec(var_06);
  self fireweapon(self.func_284C[self.func_284B], var_00, undefined, undefined, var_02);
  self.func_284B = (self.func_284B + 1) % self.func_284C.size;
}

func_6D30(var_00, var_01) {
  var_02 = self.weapon;
  func_0BDC::func_19AA("magic_spaceship_30mm_projectile_fake");
  self fireweapon(self.func_284C[self.func_284B], var_00, var_01);
  self.func_284B = (self.func_284B + 1) % self.func_284C.size;
  func_0BDC::func_19AA(var_02);
}

func_6EAC() {
  self endon("death");
  self endon("terminate_ai_threads");
  self.func_6E9C = spawnStruct();
  self.func_6E9C.func_3C37 = 25;
  self.func_6E9C.func_3C38 = 75;
  self.func_6E9C.func_3C36 = 50;
  self.func_6E9C.func_50D1 = 0.2;
  self.func_6E9C.func_50D0 = 0.3;
  self.func_6E9C.func_50CF = 0.1;
  self.func_6E9C.func_50CE = 0.3;
  self.func_6E9C.func_12B86 = [];
  self.func_93D2 = [];
  thread func_11AA5();

  for(;;) {
    self waittill("homing_missile_incoming", var_00, var_01);
    var_02 = randomint(100);

    if(isDefined(var_01) && isDefined(level.func_D127) && var_01 == level.func_D127) {
      var_03 = func_0C1C::func_7A58();

      if(func_0BDC::func_9C06()) {
        var_04 = self.func_6E9C.func_3C38;
      } else {
        var_04 = self.func_6E9C.func_3C37;
      }

      if(scripts\engine\utility::is_true(level.func_D127.func_58B5) && var_03 <= 0.75) {
        var_04 = int(self.func_6E9C.func_3C37 * max(0.0, var_03 - 0.25));
      }

      if(var_02 > var_04) {
        wait 1;
        continue;
      }
    } else if(var_02 > self.func_6E9C.func_3C36) {
      continue;
    }
    thread func_6EA2(var_00);
    wait 0.1;
  }
}

func_11AA5() {
  self endon("death");
  self endon("terminate_ai_threads");

  for(;;) {
    self waittill("homing_missile_incoming", var_00, var_01);
    thread func_11AA4(var_00);
  }
}

func_11AA4(var_00) {
  self.func_93D2 = scripts\engine\utility::array_add(self.func_93D2, var_00);
  self notify("track_incoming_missiles");
  self endon("death");
  self endon("track_incoming_missiles");

  while(self.func_93D2.size > 0) {
    self.func_93D2 scripts\engine\utility::array_removeundefined(self.func_93D2);
    wait 0.05;
  }
}

func_6EA2(var_00) {
  var_00 endon("missile_explode");
  var_00 endon("missile_dud");
  var_00 endon("entitydeleted");
  self endon("death");
  self endon("terminate_ai_threads");

  if(func_0BDC::func_9C06()) {
    wait(randomfloatrange(self.func_6E9C.func_50CF, self.func_6E9C.func_50CE));
  } else {
    wait(randomfloatrange(self.func_6E9C.func_50D1, self.func_6E9C.func_50D0));
  }

  var_01 = 12000;
  var_02 = 100000;

  while(var_02 > var_01) {
    var_02 = distance(var_0.origin, self.origin);
    wait 0.05;
  }

  thread func_6EA0(var_00);
  wait 0.3;
  thread func_6EA0(var_00);
  wait 0.3;
  thread func_6EA0(var_00);
}

func_6EA0(var_00) {
  self endon("death");
  var_01 = scripts\engine\utility::random([-1, 1]);
  var_02 = scripts\engine\utility::spawn_tag_origin();
  var_2.origin = self.origin;
  var_2.func_C3CF = self.origin;
  var_03 = scripts\engine\utility::spawn_tag_origin();
  var_3.origin = self.origin;
  var_3.func_C3CF = self.origin;
  var_04 = scripts\engine\utility::mph_to_ips(self.spaceship_vel) * 0.05;
  var_05 = anglestoright(self.angles);
  var_06 = 150;
  var_07 = 200 * anglesToForward(self.angles);
  var_08 = 100 * anglestoup(self.angles);
  var_09 = var_04 + var_05 * var_06 + var_07 + var_08;
  var_10 = var_04 + var_05 * (-1 * var_06) + var_07 + var_08;
  var_2.angles = _axistoangles(vectornormalize(var_09), anglestoright(self.angles), anglestoup(self.angles));
  var_3.angles = _axistoangles(vectornormalize(var_10), anglestoright(self.angles), anglestoup(self.angles));
  wait 0.05;
  thread func_12D9A();

  if(!isDefined(self) || !isDefined(var_00) || self.func_6E9C.func_12B86.size >= 8) {
    var_03 delete();
    var_02 delete();
    return;
  }

  self.func_6E9C.func_12B86 = scripts\engine\utility::array_combine(self.func_6E9C.func_12B86, [var_02, var_03]);
  _playworldsound("jackal_flare_deploy_npc", self.origin);
  var_02 thread func_6EA1(var_09, self);
  var_03 thread func_6EA1(var_10, self);
}

func_12D9A() {
  self notify("just_flared");
  self endon("death");
  self endon("just_flared");

  if(!isDefined(self.bt)) {
    return;
  }
  self.var_3135.func_A533 = 1;
  wait 2;
  self.var_3135.func_A533 = 0;
}

func_6EA1(var_00, var_01) {
  self endon("death");
  self.func_1A89 = 1;
  self.active = 1;
  self.fx = scripts\engine\utility::getfx("jackal_flare_decoy");
  playFXOnTag(self.fx, self, "tag_origin");
  self playLoopSound("jackal_flare_solo_npc");
  thread func_0BDC::func_6E8C(var_01);
  var_02 = 2;
  var_03 = 0.07;

  if(level.func_241D) {
    var_04 = 3;
  } else {
    var_04 = 0;
  }

  var_05 = var_04;
  var_06 = 0;
  var_07 = 30;
  var_08 = 70;

  while(var_02 > 0) {
    self.origin = self.origin + (var_00 + (0, 0, -1 * var_06));
    self notify("pos_updated");
    var_09 = anglestoup(self.angles);
    var_10 = anglestoright(self.angles);
    var_11 = vectornormalize(self.origin - self.func_C3CF);
    self.angles = _axistoangles(var_11, var_10, var_09);
    var_00 = var_00 * (1 - var_03);
    var_05 = scripts\sp\math::func_C097(var_07, var_08, var_06);
    var_05 = scripts\sp\math::func_6A8E(var_04, 0, var_05);
    var_06 = var_06 + var_05;
    self.func_C3CF = self.origin;
    var_02 = var_02 - 0.05;
    wait 0.05;
  }

  self notify("burnt_out");
}

func_13C2B() {
  self endon("death");
  self endon("terminate_ai_threads");

  for(;;) {
    switch (self.var_1198.func_6D77) {
      case "dont_shoot":
        func_594D();
        break;
      case "shoot_at_will":
        func_FE56();
        break;
      case "shoot_now":
        func_FE73();
        break;
      case "shoot_single_burst":
        func_FE80();
        break;
      case "shoot_forever":
        func_FE60();
        break;
      case "lead_burst":
        func_AAE2();
        break;
    }
  }
}

func_DCE9(var_00, var_01, var_02) {
  return var_00 + (var_01 - var_00) * var_02;
}

func_DCE6(var_00, var_01, var_02, var_03, var_04) {
  var_05 = (clamp(var_00, var_01, var_02) - var_01) / (var_02 - var_01);
  return var_03 + (var_04 - var_03) * var_05;
}

func_3702(var_00) {
  var_01 = 0;
  var_02 = _isaircraft(var_00);
  var_03 = distance(self.origin, var_0.origin);
  var_01 = var_01 + func_DCE6(var_03, 0.0, 10000, 1.0, 0.0);
  var_03 = 0.0;

  if(isDefined(self.var_1198.func_E1AD) && self.var_1198.func_E1AD == var_00) {
    if(!var_02 || !isDefined(var_0.bt) || isDefined(var_0.var_3135.func_DB05) && var_0.var_3135.func_DB05 != self) {
      var_01 = var_01 + 1.5;
    }
  }

  if(isDefined(var_0.vehicletype)) {
    if(_isaircraft(var_00)) {
      var_04 = var_0.func_C1DB;

      if(var_0.spaceship_mode == "hover") {
        var_01 = var_01 + 1.0;
      }

      var_01 = var_01 + func_DCE6(var_04, 0, 3, 1.0, 0.0);

      if(!isDefined(var_0.enemy) || var_0.enemy != self) {
        var_01 = var_01 + 1.0;
      }
    }
  }

  return var_01;
}

func_7AC5() {
  return 5;
}

func_12E3A() {
  var_00 = 0;
  var_01 = undefined;
  self.func_C1DB = allowads();

  if(isDefined(self.ignoreall) && self.ignoreall) {
    var_01 = undefined;
    return;
  } else if(isalive(self.var_1198.func_11577))
    var_01 = self.var_1198.func_11577;
  else if(isDefined(self.var_1198.func_90EE)) {
    var_01 = self.var_1198.func_90EE;
  } else if(isDefined(self.var_1198.func_7002)) {
    var_01 = self.var_1198.func_7002;
  } else if(isDefined(self.var_1198.func_2534)) {
    var_01 = self.var_1198.func_2534;
  } else {
    var_02 = self _meth_8493() == "follow";
    var_03 = vehicle_getarray();

    if(isDefined(self.var_1198.func_2520) && self.var_1198.func_2520) {
      var_03 = scripts\engine\utility::array_combine(var_03, _getaiarray());

      if(self.team == "axis" && !scripts\engine\utility::player_is_in_jackal()) {
        var_3[var_3.size] = level.player;
      }
    }

    foreach(var_05 in var_03) {
      if(!issentient(var_05) || !isalive(var_05) || !_isaircraft(self)) {
        continue;
      }
      if(var_5.team == self.team) {
        continue;
      }
      if(isDefined(var_5.ignoreme) && var_5.ignoreme) {
        continue;
      }
      if(!isDefined(var_5.func_C1DB)) {
        var_5.func_C1DB = 0;
      }

      var_06 = var_5.func_C1DB;

      if(var_06 > 3 && isDefined(self.enemy) && self.enemy == var_05) {
        self.var_1198.func_E1AD = undefined;
        var_5.func_C1DB--;
        continue;
      }

      if(var_06 >= 3 && (isDefined(self.enemy) && self.enemy != var_05)) {
        continue;
      }
      if(var_02) {
        var_07 = vectornormalize(var_5.origin - self.origin);
        var_08 = anglesToForward(self.angles);
        var_09 = vectordot(var_07, var_08);

        if(var_09 < 0.866025) {
          continue;
        }
      }

      var_10 = func_3702(var_05);

      if(var_10 > var_00) {
        var_00 = var_10;
        var_01 = var_05;
      }
    }
  }

  var_12 = self.var_1198.func_E1AD;
  var_13 = 0;

  if(!isDefined(var_01)) {
    self _meth_846A();
    self.var_1198.func_E1AD = undefined;
    var_13 = 1;
  } else if(!isDefined(self.var_1198.func_E1AD) || var_01 != self.var_1198.func_E1AD) {
    if(!isDefined(var_1.func_C1DB)) {
      var_1.func_C1DB = 0;
    }

    var_1.func_C1DB++;
    self.func_6577 = gettime();
    var_13 = 1;
    self _meth_846A(var_01);
    self.var_1198.func_E1AD = var_01;
  }

  if(isDefined(var_12) && var_13) {
    var_12.func_C1DB--;
  }
}

func_7AF2(var_00) {
  if(var_0.spaceship_mode == "hover") {
    return 1.0;
  }

  return 0.9;
}

func_7941(var_00) {
  var_01 = distance(self.origin, var_0.origin);
  return func_DCE6(var_01, 1500.0, 25000.0, 1.0, 0.5);
}

func_7AF9(var_00) {
  var_01 = vectornormalize(self.spaceship_vel);
  var_02 = vectornormalize(var_0.spaceship_vel);
  var_03 = scripts\sp\math::func_C097(40, 360, length(var_0.spaceship_vel));
  var_04 = vectordot(var_01, var_02);
  var_05 = scripts\sp\math::func_6A8E(1, abs(var_04), var_03);
  return scripts\sp\math::func_6A8E(0.5, 1.0, var_05);
}

func_7845(var_00) {
  var_01 = var_0.func_C1DB;
  return func_DCE6(var_01, 1, level.func_A48E.func_A3AD, 1.0, level.func_A48E.func_A3AE);
}

func_7CFC(var_00) {
  var_01 = level.func_A48E.func_A3A6 * (gettime() - self.func_6577) / 1000.0;
  return min(var_01, 1.0);
}

func_12D7B() {
  var_00 = self.var_1198.func_E1AD;

  if(isalive(var_00)) {
    var_01 = isDefined(var_0.vehicletype) && _isaircraft(var_00);
    var_02 = var_01 && isDefined(var_0.owner) && isplayer(var_0.owner);
    var_03 = self.var_1198.func_2894;

    if(!var_01) {
      var_03 = var_03 * func_7941(var_00);
    } else if(var_02) {
      var_03 = var_03 * func_7941(var_00);
      var_03 = var_03 * func_7AF2(var_00);
      var_03 = var_03 * func_7AF9(var_00);
      var_03 = var_03 * func_7845(var_00);
    } else {
      var_03 = var_03 * func_7941(var_00);
      var_03 = var_03 * func_7AF2(var_00);
    }

    var_03 = var_03 * func_7CFC(var_00);
    self.var_1198.accuracy = var_03;
  } else
    self _meth_846A();
}

func_9CC7() {
  var_00 = scripts\sp\vehicle::func_9FEF();

  if(!var_00) {
    return 0;
  }

  var_01 = _isaircraft(self);
  return var_01;
}

allowads() {
  var_00 = 0;

  foreach(var_02 in level.func_A056.func_1630) {
    if(!issentient(var_02) || !isalive(var_02)) {
      continue;
    }
    if(var_2.team == self.team) {
      continue;
    }
    if(isDefined(var_2.enemy) && var_2.enemy == self) {
      var_0++;
    }
  }

  return var_00;
}

func_12E1A() {
  var_00 = vehicle_getarray();
  var_01 = 0;
  var_02 = undefined;

  foreach(var_04 in var_00) {
    if(!issentient(var_04) || !isalive(var_04)) {
      continue;
    }
    if(var_4.team == self.team) {
      continue;
    }
    if(isDefined(var_4.bt) && isDefined(var_4.var_3135.func_DB05) && var_4.var_3135.func_DB05 == self) {
      continue;
    }
    var_05 = -1;

    if(isDefined(var_4.owner) && isplayer(var_4.owner) && isDefined(var_4.func_DB07.target) && var_4.func_DB07.target == self) {
      var_05 = min((gettime() - var_4.func_DB07.starttime) / 1000 * 1.5, 2.0);
    } else if(isDefined(var_4.enemy) && var_4.enemy == self && isDefined(var_4.func_6577)) {
      var_05 = min((gettime() - var_4.func_6577) / 1000 * 1.0, 1.0);
    }

    if(var_05 > var_01) {
      var_02 = var_04;
      var_01 = var_05;
    }
  }

  if(isDefined(var_02) && var_01 > 0.5) {
    self.var_3135.func_DB05 = var_02;
    self.var_3135.func_DB06 = var_01;
  } else {
    self.var_3135.func_DB05 = undefined;
    self.var_3135.func_DB06 = 0;
  }
}

func_12899() {
  if(self.var_1198.func_9DE4) {
    return;
  }
  self notify("newEvade");
  self endon("death");
  self endon("newEvade");
  self.var_1198.func_1000D = 1;
  wait 0.2;
  self.var_1198.func_1000D = 0;
}

func_10D72() {
  if(self.var_1198.func_2CCD) {
    return;
  }
  self.var_1198.func_2CCD = 1;
  self.var_1198.func_2CD1 = gettime();
  self.var_1198.func_2CD2 = 4000;
  self.var_1198.func_BFA6 = gettime() + 4000 + randomintrange(7000, 12000);
  self.var_1198.func_2CB8 = gettime() + 10000;
  var_00 = func_0BDC::func_1996();
  self _meth_845F(var_0.speed * 1.8, var_0.func_1545 * 1.8, var_0.func_1E91 * 1.8, var_0.func_1E71 * 1.8);
}

func_11062() {
  if(self.var_1198.func_2CCD == 0) {
    return;
  }
  self.var_1198.func_2CCD = 0;
  var_00 = func_0BDC::func_1996();
  var_01 = var_0.speed;
  self _meth_845F(var_01);
}

func_12D99() {
  var_00 = gettime();

  if(self.var_1198.func_2CCD) {
    if(var_00 > self.var_1198.func_2CD1 + self.var_1198.func_2CD2) {
      func_11062();
    }
  } else {
    if(var_00 < self.var_1198.func_2CB8) {
      return;
    }
    if(self.var_1198.func_2CCF) {
      func_10D72();
      self.var_1198.func_2CCF = 0;
      return;
    }

    if(!isalive(self.var_3135.func_DB05)) {
      return;
    }
    var_01 = distancesquared(self.var_3135.func_DB05.origin, self.origin);

    if(var_01 > 144000000) {
      return;
    }
    if(var_01 < 25000000) {
      func_10D72();
      return;
    }

    if(var_00 > self.var_1198.func_BFA6) {
      func_10D72();
    }
  }
}