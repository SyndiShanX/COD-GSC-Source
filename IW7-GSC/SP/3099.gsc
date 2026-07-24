/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3099.gsc
**************************************/

_id_13CC4() {
  self._id_284B = 0;
  self._id_284C[0] = "tag_flash_left";
  self._id_284C[1] = "tag_flash_right";

  if(self._id_9B4C) {
    _id_0BDC::_id_19AA("spaceship_ai_energy_projectile");
  } else {
    _id_0BDC::_id_19AA("spaceship_ai_30mm_projectile");
  }
}

_id_594D() {
  self endon("firemode changed");
  self waittill("hellfreezesover");
}

_id_1A3F() {
  var_0 = _id_7912();

  if(!isalive(var_0)) {
    return 0;
  }

  var_1 = anglesToForward(self.angles);
  var_2 = var_0.origin - self.origin;
  var_1 = vectorNormalize(var_1);
  var_2 = vectorNormalize(var_2);
  var_3 = distancesquared(self.origin, var_0.origin);
  return vectordot(var_1, var_2) > 0.9659 && var_3 < 625000000;
}

_id_FE56() {
  self endon("firemode changed");

  for(;;) {
    while(!_id_1A3F()) {
      wait 0.05;
    }

    while(_id_1A3F()) {
      if(isDefined(self._blackboard._id_D9BA)) {
        var_0 = self[[self._blackboard._id_D9BA]](self._blackboard._id_E1AD);

        if(!isDefined(var_0) || var_0 == 1) {
          _id_10208();
        }

        continue;
      }

      _id_10208();
    }
  }

  self waittill("hellfreezesover");
}

_id_FE73() {
  self endon("firemode changed");

  for(;;) {
    _id_6D54();
    wait(randomfloatrange(0.5, 1.0));
  }
}

_id_FE80() {
  self endon("firemode changed");
  _id_6D54();
  _id_0BDC::_id_19AE("dont_shoot");
}

_id_FE60() {
  self endon("firemode changed");
  _id_9760();
  _id_6D55();
}

_id_6D54() {
  var_0 = _id_7912();
  _id_9561(var_0, 20000);
  var_1 = floor(self._blackboard.shootparams.time / (self._id_13C87 * 1000)) + 1;

  if(_id_65F1(var_0)) {
    self._blackboard._id_6D83 = "jackal_gatling_fire_at_plr";
  } else {
    self._blackboard._id_6D83 = "jackal_gatling_fire";
  }

  if(scripts\engine\utility::flag_exist("jackal_shooting")) {
    if(!scripts\engine\utility::flag("jackal_shooting")) {
      thread scripts\sp\utility::play_loop_sound_on_tag(self._blackboard._id_6D83, "tag_spotlight", 1, 1, "jackal_gatling_release");
    }
  } else
    thread scripts\sp\utility::play_loop_sound_on_tag(self._blackboard._id_6D83, "tag_spotlight", 1, 1, "jackal_gatling_release");

  var_2 = 0;

  if(!scripts\sp\utility::_id_65DF("jackal_firing")) {
    scripts\sp\utility::_id_65E0("jackal_firing");
  }

  scripts\sp\utility::_id_65E1("jackal_firing");

  while(var_2 < var_1) {
    _id_6D2F();
    var_2++;
    wait(self._id_13C87);
  }

  scripts\sp\utility::_id_65DD("jackal_firing");
  self notify("stop sound" + self._blackboard._id_6D83);
}

_id_65F1(var_0) {
  if(isDefined(level._id_D127) && isDefined(var_0) && var_0 == level._id_D127) {
    return 1;
  } else {
    return 0;
  }
}

_id_6D55() {
  self endon("firemode changed");
  self endon("death");

  if(_id_65F1(_id_7912())) {
    self._blackboard._id_6D83 = "jackal_gatling_fire_at_plr";
  } else {
    self._blackboard._id_6D83 = "jackal_gatling_fire";
  }

  var_0 = 0;

  if(scripts\engine\utility::flag_exist("jackal_shooting")) {
    if(!scripts\engine\utility::flag("jackal_shooting")) {
      thread scripts\sp\utility::play_loop_sound_on_tag(self._blackboard._id_6D83, "tag_spotlight", 1, 1, "jackal_gatling_release");
    }
  } else
    thread scripts\sp\utility::play_loop_sound_on_tag(self._blackboard._id_6D83, "tag_spotlight", 1, 1, "jackal_gatling_release");

  if(!scripts\sp\utility::_id_65DF("jackal_firing")) {
    scripts\sp\utility::_id_65E0("jackal_firing");
  }

  scripts\sp\utility::_id_65E1("jackal_firing");

  for(;;) {
    _id_6D2F();
    wait(self._id_13C87);
  }

  scripts\sp\utility::_id_65DD("jackal_firing");
}

_id_79CF() {
  if(isDefined(self._blackboard.shootparams) && isDefined(self._blackboard.shootparams._id_0148)) {
    var_0 = self._blackboard.shootparams._id_0148;
  } else {
    var_0 = 1.0;
  }

  return var_0;
}

_id_77C8() {
  if(isDefined(self._id_154D)) {
    return self._id_154D;
  }

  return self._blackboard.accuracy;
}

_id_10208() {
  _id_6D54();
  wait(randomfloatrange(0.5, 1.0));
}

_id_AAE2() {
  self endon("firemode changed");

  for(;;) {
    if(!isalive(self.enemy)) {
      wait 0.05;
      continue;
    }

    _id_10208();
  }
}

_id_36D1(var_0) {
  var_1 = scripts\sp\math::_id_C097(0, 25000.0, distance(self.origin, var_0.origin));
  var_2 = _id_36D2();
  var_2 = var_2 * var_1;
  var_2 = var_2 * (1 - _id_77C8());
  return var_2;
}

_id_36D2() {
  var_0 = vectorNormalize((randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-1, 1)));
  var_1 = var_0 * (2000.0 * randomfloat(1));
  return var_1;
}

_id_36D0(var_0, var_1) {
  var_2 = (1, 0, 0);
  var_3 = randomfloatrange(0, 360.0);
  var_4 = (0, 0, var_3);
  rotatevector(var_2, var_4);
  var_5 = var_2 * var_0;
  var_6 = var_1.origin - self.origin;
  var_6 = vectorNormalize(var_6);
  var_7 = (0, 0, 1);

  if(vectordot(var_6, var_7) > 0.99) {
    var_7 = (-1, 0, 0);
  }

  var_8 = vectorcross(var_6, var_7);
  var_9 = axistoangles(var_6, var_8, var_7);
  rotatevector(var_5, var_9);
  return var_5;
}

_id_36D6(var_0) {
  var_1 = _id_36D1(var_0);
  return var_1;
}

_id_7912() {
  if(isDefined(self._blackboard._id_11577)) {
    return self._blackboard._id_11577;
  }

  if(isDefined(self._blackboard._id_E1AD)) {
    return self._blackboard._id_E1AD;
  } else if(isDefined(self.enemy)) {
    return self.enemy;
  }
}

_id_9561(var_0, var_1) {
  if(isDefined(var_0)) {
    var_2 = _id_36CD(var_0, var_1);
    var_3 = _id_7BC8(var_0, var_2);
    self._blackboard.shootparams._id_C36B = var_3 - var_0.origin;
    self._blackboard.shootparams._id_C36C = var_2 - var_0.origin;
  } else {
    self._blackboard.shootparams._id_C36B = (0, 0, 0);
    self._blackboard.shootparams._id_C36C = (0, 0, 0);
  }

  self._blackboard.shootparams.starttime = gettime();
  self._blackboard.shootparams.time = randomintrange(500, 1500);
  self._blackboard.shootparams._id_32AF = 1;
}

_id_9760() {
  self._blackboard.shootparams._id_32AF = 0;
}

_id_AAE3(var_0, var_1, var_2, var_3) {
  var_4 = var_0 - var_1;
  var_5 = var_2 - var_1;
  var_6 = vectordot(vectorNormalize(var_4), vectorNormalize(var_5));
  var_7 = acos(clamp(var_6, 0.0, 1.0));
  var_8 = atan(var_3 / length(var_5));

  if(var_7 < var_8) {
    return 1;
  }

  return 0;
}

_id_36CD(var_0, var_1) {
  var_2 = var_0.origin;

  if(isaircraft(var_0)) {
    var_3 = scripts\engine\utility::mph_to_ips(var_0.spaceship_vel);
    var_4 = scripts\engine\utility::mph_to_ips(self.spaceship_vel);
    var_2 = _id_36CE(self.origin, var_4, var_0.origin, var_3, var_1);
  }

  return var_2;
}

_id_36CE(var_0, var_1, var_2, var_3, var_4) {
  var_5 = projectileintercept(var_0, var_1, var_4, var_2, var_3);

  if(!isDefined(var_5)) {
    var_5 = var_2;
  }

  return var_5;
}

_id_7BC8(var_0, var_1) {
  var_2 = var_1 - var_0.origin;
  var_3 = length(var_2);

  if(var_3 > 96) {
    return var_0.origin + var_2 * (var_3 + var_3 * 0.5) / var_3;
  }

  var_4 = anglesToForward(var_0.angles);
  return var_0.origin + var_4 * 2048;
}

_id_36D3(var_0) {
  var_1 = gettime() - self._blackboard.shootparams.starttime;
  var_2 = clamp(var_1 / self._blackboard.shootparams.time, 0.0, 1.0);
  var_3 = 0.5;

  if(isDefined(self._id_734A)) {
    var_3 = self._id_734A;
  }

  var_2 = max(var_2, var_3);
  self._blackboard.shootparams._id_0148 = var_2;
  var_4 = _id_36D1(var_0);
  var_4 = var_4 * (1 - var_2);
  var_5 = vectorlerp(self._blackboard.shootparams._id_C36B, self._blackboard.shootparams._id_C36C, var_2);
  return var_5;
}

_id_36D8(var_0) {
  var_1 = self.spaceship_vel;
  var_1 = scripts\engine\utility::mph_to_ips(var_1);
  var_0 = vectorNormalize(var_1);
}

_id_7AAC() {
  if(self._blackboard.shootparams._id_32AF) {
    var_0 = _id_79CF();
  } else {
    var_0 = 1;
  }

  var_1 = _id_77C8();
  return int(scripts\sp\math::_id_AB6F(3.5, 6.9, var_1 * var_0));
}

_id_6D2F() {
  var_0 = _id_7912();

  if(isDefined(var_0)) {
    if(self._blackboard.shootparams._id_32AF) {
      var_1 = _id_36D3(var_0);
    } else {
      var_1 = _id_36D6(var_0);
    }

    var_2 = _id_7AAC();

    if(isaircraft(var_0)) {
      var_3 = scripts\engine\utility::mph_to_ips(var_0.spaceship_vel);
      var_4 = scripts\engine\utility::mph_to_ips(self.spaceship_vel);
      var_5 = _id_36CE(self.origin, var_4, var_0.origin, var_3, 20000);
    } else
      var_5 = var_0.origin;

    var_6 = var_1 + var_5;
  } else {
    var_7 = anglesToForward(self.angles) * 25000.0;
    var_8 = _id_36D2();
    var_6 = var_7 + var_8;
    var_2 = 0;
  }

  self setturrettargetvec(var_6);
  self fireweapon(self._id_284C[self._id_284B], var_0, undefined, undefined, var_2);
  self._id_284B = (self._id_284B + 1) % self._id_284C.size;
}

_id_6D30(var_0, var_1) {
  var_2 = self.weapon;
  _id_0BDC::_id_19AA("magic_spaceship_30mm_projectile_fake");
  self fireweapon(self._id_284C[self._id_284B], var_0, var_1);
  self._id_284B = (self._id_284B + 1) % self._id_284C.size;
  _id_0BDC::_id_19AA(var_2);
}

_id_6EAC() {
  self endon("death");
  self endon("terminate_ai_threads");
  self._id_6E9C = spawnStruct();
  self._id_6E9C._id_3C37 = 25;
  self._id_6E9C._id_3C38 = 75;
  self._id_6E9C._id_3C36 = 50;
  self._id_6E9C._id_50D1 = 0.2;
  self._id_6E9C._id_50D0 = 0.3;
  self._id_6E9C._id_50CF = 0.1;
  self._id_6E9C._id_50CE = 0.3;
  self._id_6E9C._id_12B86 = [];
  self._id_93D2 = [];
  thread _id_11AA5();

  for(;;) {
    self waittill("homing_missile_incoming", var_0, var_1);
    var_2 = randomint(100);

    if(isDefined(var_1) && isDefined(level._id_D127) && var_1 == level._id_D127) {
      var_3 = _id_0C1C::_id_7A58();

      if(_id_0BDC::_id_9C06()) {
        var_4 = self._id_6E9C._id_3C38;
      } else {
        var_4 = self._id_6E9C._id_3C37;
      }

      if(scripts\engine\utility::is_true(level._id_D127._id_58B5) && var_3 <= 0.75) {
        var_4 = int(self._id_6E9C._id_3C37 * max(0.0, var_3 - 0.25));
      }

      if(var_2 > var_4) {
        wait 1;
        continue;
      }
    } else if(var_2 > self._id_6E9C._id_3C36) {
      continue;
    }
    thread _id_6EA2(var_0);
    wait 0.1;
  }
}

_id_11AA5() {
  self endon("death");
  self endon("terminate_ai_threads");

  for(;;) {
    self waittill("homing_missile_incoming", var_0, var_1);
    thread _id_11AA4(var_0);
  }
}

_id_11AA4(var_0) {
  self._id_93D2 = scripts\engine\utility::array_add(self._id_93D2, var_0);
  self notify("track_incoming_missiles");
  self endon("death");
  self endon("track_incoming_missiles");

  while(self._id_93D2.size > 0) {
    self._id_93D2 scripts\engine\utility::array_removeundefined(self._id_93D2);
    wait 0.05;
  }
}

_id_6EA2(var_0) {
  var_0 endon("missile_explode");
  var_0 endon("missile_dud");
  var_0 endon("entitydeleted");
  self endon("death");
  self endon("terminate_ai_threads");

  if(_id_0BDC::_id_9C06()) {
    wait(randomfloatrange(self._id_6E9C._id_50CF, self._id_6E9C._id_50CE));
  } else {
    wait(randomfloatrange(self._id_6E9C._id_50D1, self._id_6E9C._id_50D0));
  }

  var_1 = 12000;
  var_2 = 100000;

  while(var_2 > var_1) {
    var_2 = distance(var_0.origin, self.origin);
    wait 0.05;
  }

  thread _id_6EA0(var_0);
  wait 0.3;
  thread _id_6EA0(var_0);
  wait 0.3;
  thread _id_6EA0(var_0);
}

_id_6EA0(var_0) {
  self endon("death");
  var_1 = scripts\engine\utility::random([-1, 1]);
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2.origin = self.origin;
  var_2._id_C3CF = self.origin;
  var_3 = scripts\engine\utility::spawn_tag_origin();
  var_3.origin = self.origin;
  var_3._id_C3CF = self.origin;
  var_4 = scripts\engine\utility::mph_to_ips(self.spaceship_vel) * 0.05;
  var_5 = anglestoright(self.angles);
  var_6 = 150;
  var_7 = 200 * anglesToForward(self.angles);
  var_8 = 100 * anglestoup(self.angles);
  var_9 = var_4 + var_5 * var_6 + var_7 + var_8;
  var_10 = var_4 + var_5 * (-1 * var_6) + var_7 + var_8;
  var_2.angles = axistoangles(vectorNormalize(var_9), anglestoright(self.angles), anglestoup(self.angles));
  var_3.angles = axistoangles(vectorNormalize(var_10), anglestoright(self.angles), anglestoup(self.angles));
  wait 0.05;
  thread _id_12D9A();

  if(!isDefined(self) || !isDefined(var_0) || self._id_6E9C._id_12B86.size >= 8) {
    var_3 delete();
    var_2 delete();
    return;
  }

  self._id_6E9C._id_12B86 = scripts\engine\utility::array_combine(self._id_6E9C._id_12B86, [var_2, var_3]);
  playworldsound("jackal_flare_deploy_npc", self.origin);
  var_2 thread _id_6EA1(var_9, self);
  var_3 thread _id_6EA1(var_10, self);
}

_id_12D9A() {
  self notify("just_flared");
  self endon("death");
  self endon("just_flared");

  if(!isDefined(self.bt)) {
    return;
  }
  self.bt._id_A533 = 1;
  wait 2;
  self.bt._id_A533 = 0;
}

_id_6EA1(var_0, var_1) {
  self endon("death");
  self._id_1A89 = 1;
  self.active = 1;
  self.fx = scripts\engine\utility::getfx("jackal_flare_decoy");
  playFXOnTag(self.fx, self, "tag_origin");
  self playLoopSound("jackal_flare_solo_npc");
  thread _id_0BDC::_id_6E8C(var_1);
  var_2 = 2;
  var_3 = 0.07;

  if(level._id_241D) {
    var_4 = 3;
  } else {
    var_4 = 0;
  }

  var_5 = var_4;
  var_6 = 0;
  var_7 = 30;
  var_8 = 70;

  while(var_2 > 0) {
    self.origin = self.origin + (var_0 + (0, 0, -1 * var_6));
    self notify("pos_updated");
    var_9 = anglestoup(self.angles);
    var_10 = anglestoright(self.angles);
    var_11 = vectorNormalize(self.origin - self._id_C3CF);
    self.angles = axistoangles(var_11, var_10, var_9);
    var_0 = var_0 * (1 - var_3);
    var_5 = scripts\sp\math::_id_C097(var_7, var_8, var_6);
    var_5 = scripts\sp\math::_id_6A8E(var_4, 0, var_5);
    var_6 = var_6 + var_5;
    self._id_C3CF = self.origin;
    var_2 = var_2 - 0.05;
    wait 0.05;
  }

  self notify("burnt_out");
}

_id_13C2B() {
  self endon("death");
  self endon("terminate_ai_threads");

  for(;;) {
    switch (self._blackboard._id_6D77) {
      case "dont_shoot":
        _id_594D();
        break;
      case "shoot_at_will":
        _id_FE56();
        break;
      case "shoot_now":
        _id_FE73();
        break;
      case "shoot_single_burst":
        _id_FE80();
        break;
      case "shoot_forever":
        _id_FE60();
        break;
      case "lead_burst":
        _id_AAE2();
        break;
    }
  }
}

_id_DCE9(var_0, var_1, var_2) {
  return var_0 + (var_1 - var_0) * var_2;
}

_id_DCE6(var_0, var_1, var_2, var_3, var_4) {
  var_5 = (clamp(var_0, var_1, var_2) - var_1) / (var_2 - var_1);
  return var_3 + (var_4 - var_3) * var_5;
}

_id_3702(var_0) {
  var_1 = 0;
  var_2 = isaircraft(var_0);
  var_3 = distance(self.origin, var_0.origin);
  var_1 = var_1 + _id_DCE6(var_3, 0.0, 10000, 1.0, 0.0);
  var_3 = 0.0;

  if(isDefined(self._blackboard._id_E1AD) && self._blackboard._id_E1AD == var_0) {
    if(!var_2 || !isDefined(var_0.bt) || isDefined(var_0.bt._id_DB05) && var_0.bt._id_DB05 != self) {
      var_1 = var_1 + 1.5;
    }
  }

  if(isDefined(var_0.vehicletype)) {
    if(isaircraft(var_0)) {
      var_4 = var_0._id_C1DB;

      if(var_0.spaceship_mode == "hover") {
        var_1 = var_1 + 1.0;
      }

      var_1 = var_1 + _id_DCE6(var_4, 0, 3, 1.0, 0.0);

      if(!isDefined(var_0.enemy) || var_0.enemy != self) {
        var_1 = var_1 + 1.0;
      }
    }
  }

  return var_1;
}

_id_7AC5() {
  return 5;
}

_id_12E3A() {
  var_0 = 0;
  var_1 = undefined;
  self._id_C1DB = _id_8009();

  if(isDefined(self.ignoreall) && self.ignoreall) {
    var_1 = undefined;
    return;
  } else if(isalive(self._blackboard._id_11577))
    var_1 = self._blackboard._id_11577;
  else if(isDefined(self._blackboard._id_90EE)) {
    var_1 = self._blackboard._id_90EE;
  } else if(isDefined(self._blackboard._id_7002)) {
    var_1 = self._blackboard._id_7002;
  } else if(isDefined(self._blackboard._id_2534)) {
    var_1 = self._blackboard._id_2534;
  } else {
    var_2 = self _meth_8493() == "follow";
    var_3 = vehicle_getarray();

    if(isDefined(self._blackboard._id_2520) && self._blackboard._id_2520) {
      var_3 = scripts\engine\utility::array_combine(var_3, getaiarray());

      if(self.team == "axis" && !scripts\engine\utility::player_is_in_jackal()) {
        var_3[var_3.size] = level.player;
      }
    }

    foreach(var_5 in var_3) {
      if(!issentient(var_5) || !isalive(var_5) || !isaircraft(self)) {
        continue;
      }
      if(var_5.team == self.team) {
        continue;
      }
      if(isDefined(var_5.ignoreme) && var_5.ignoreme) {
        continue;
      }
      if(!isDefined(var_5._id_C1DB)) {
        var_5._id_C1DB = 0;
      }

      var_6 = var_5._id_C1DB;

      if(var_6 > 3 && isDefined(self.enemy) && self.enemy == var_5) {
        self._blackboard._id_E1AD = undefined;
        var_5._id_C1DB--;
        continue;
      }

      if(var_6 >= 3 && (isDefined(self.enemy) && self.enemy != var_5)) {
        continue;
      }
      if(var_2) {
        var_7 = vectorNormalize(var_5.origin - self.origin);
        var_8 = anglesToForward(self.angles);
        var_9 = vectordot(var_7, var_8);

        if(var_9 < 0.866025) {
          continue;
        }
      }

      var_10 = _id_3702(var_5);

      if(var_10 > var_0) {
        var_0 = var_10;
        var_1 = var_5;
      }
    }
  }

  var_12 = self._blackboard._id_E1AD;
  var_13 = 0;

  if(!isDefined(var_1)) {
    self _meth_846A();
    self._blackboard._id_E1AD = undefined;
    var_13 = 1;
  } else if(!isDefined(self._blackboard._id_E1AD) || var_1 != self._blackboard._id_E1AD) {
    if(!isDefined(var_1._id_C1DB)) {
      var_1._id_C1DB = 0;
    }

    var_1._id_C1DB++;
    self._id_6577 = gettime();
    var_13 = 1;
    self _meth_846A(var_1);
    self._blackboard._id_E1AD = var_1;
  }

  if(isDefined(var_12) && var_13) {
    var_12._id_C1DB--;
  }
}

_id_7AF2(var_0) {
  if(var_0.spaceship_mode == "hover") {
    return 1.0;
  }

  return 0.9;
}

_id_7941(var_0) {
  var_1 = distance(self.origin, var_0.origin);
  return _id_DCE6(var_1, 1500.0, 25000.0, 1.0, 0.5);
}

_id_7AF9(var_0) {
  var_1 = vectorNormalize(self.spaceship_vel);
  var_2 = vectorNormalize(var_0.spaceship_vel);
  var_3 = scripts\sp\math::_id_C097(40, 360, length(var_0.spaceship_vel));
  var_4 = vectordot(var_1, var_2);
  var_5 = scripts\sp\math::_id_6A8E(1, abs(var_4), var_3);
  return scripts\sp\math::_id_6A8E(0.5, 1.0, var_5);
}

_id_7845(var_0) {
  var_1 = var_0._id_C1DB;
  return _id_DCE6(var_1, 1, level._id_A48E._id_A3AD, 1.0, level._id_A48E._id_A3AE);
}

_id_7CFC(var_0) {
  var_1 = level._id_A48E._id_A3A6 * (gettime() - self._id_6577) / 1000.0;
  return min(var_1, 1.0);
}

_id_12D7B() {
  var_0 = self._blackboard._id_E1AD;

  if(isalive(var_0)) {
    var_1 = isDefined(var_0.vehicletype) && isaircraft(var_0);
    var_2 = var_1 && isDefined(var_0.owner) && isPlayer(var_0.owner);
    var_3 = self._blackboard._id_2894;

    if(!var_1) {
      var_3 = var_3 * _id_7941(var_0);
    } else if(var_2) {
      var_3 = var_3 * _id_7941(var_0);
      var_3 = var_3 * _id_7AF2(var_0);
      var_3 = var_3 * _id_7AF9(var_0);
      var_3 = var_3 * _id_7845(var_0);
    } else {
      var_3 = var_3 * _id_7941(var_0);
      var_3 = var_3 * _id_7AF2(var_0);
    }

    var_3 = var_3 * _id_7CFC(var_0);
    self._blackboard.accuracy = var_3;
  } else
    self _meth_846A();
}

_id_9CC7() {
  var_0 = scripts\sp\vehicle::_id_9FEF();

  if(!var_0) {
    return 0;
  }

  var_1 = isaircraft(self);
  return var_1;
}

_id_8009() {
  var_0 = 0;

  foreach(var_2 in level._id_A056._id_1630) {
    if(!issentient(var_2) || !isalive(var_2)) {
      continue;
    }
    if(var_2.team == self.team) {
      continue;
    }
    if(isDefined(var_2.enemy) && var_2.enemy == self) {
      var_0++;
    }
  }

  return var_0;
}

_id_12E1A() {
  var_0 = vehicle_getarray();
  var_1 = 0;
  var_2 = undefined;

  foreach(var_4 in var_0) {
    if(!issentient(var_4) || !isalive(var_4)) {
      continue;
    }
    if(var_4.team == self.team) {
      continue;
    }
    if(isDefined(var_4.bt) && isDefined(var_4.bt._id_DB05) && var_4.bt._id_DB05 == self) {
      continue;
    }
    var_5 = -1;

    if(isDefined(var_4.owner) && isPlayer(var_4.owner) && isDefined(var_4._id_DB07.target) && var_4._id_DB07.target == self) {
      var_5 = min((gettime() - var_4._id_DB07.starttime) / 1000 * 1.5, 2.0);
    } else if(isDefined(var_4.enemy) && var_4.enemy == self && isDefined(var_4._id_6577)) {
      var_5 = min((gettime() - var_4._id_6577) / 1000 * 1.0, 1.0);
    }

    if(var_5 > var_1) {
      var_2 = var_4;
      var_1 = var_5;
    }
  }

  if(isDefined(var_2) && var_1 > 0.5) {
    self.bt._id_DB05 = var_2;
    self.bt._id_DB06 = var_1;
  } else {
    self.bt._id_DB05 = undefined;
    self.bt._id_DB06 = 0;
  }
}

_id_12899() {
  if(self._blackboard._id_9DE4) {
    return;
  }
  self notify("newEvade");
  self endon("death");
  self endon("newEvade");
  self._blackboard._id_1000D = 1;
  wait 0.2;
  self._blackboard._id_1000D = 0;
}

_id_10D72() {
  if(self._blackboard._id_2CCD) {
    return;
  }
  self._blackboard._id_2CCD = 1;
  self._blackboard._id_2CD1 = gettime();
  self._blackboard._id_2CD2 = 4000;
  self._blackboard._id_BFA6 = gettime() + 4000 + randomintrange(7000, 12000);
  self._blackboard._id_2CB8 = gettime() + 10000;
  var_0 = _id_0BDC::_id_1996();
  self _meth_845F(var_0.speed * 1.8, var_0._id_1545 * 1.8, var_0._id_1E91 * 1.8, var_0._id_1E71 * 1.8);
}

_id_11062() {
  if(self._blackboard._id_2CCD == 0) {
    return;
  }
  self._blackboard._id_2CCD = 0;
  var_0 = _id_0BDC::_id_1996();
  var_1 = var_0.speed;
  self _meth_845F(var_1);
}

_id_12D99() {
  var_0 = gettime();

  if(self._blackboard._id_2CCD) {
    if(var_0 > self._blackboard._id_2CD1 + self._blackboard._id_2CD2) {
      _id_11062();
    }
  } else {
    if(var_0 < self._blackboard._id_2CB8) {
      return;
    }
    if(self._blackboard._id_2CCF) {
      _id_10D72();
      self._blackboard._id_2CCF = 0;
      return;
    }

    if(!isalive(self.bt._id_DB05)) {
      return;
    }
    var_1 = distancesquared(self.bt._id_DB05.origin, self.origin);

    if(var_1 > 144000000) {
      return;
    }
    if(var_1 < 25000000) {
      _id_10D72();
      return;
    }

    if(var_0 > self._blackboard._id_BFA6) {
      _id_10D72();
    }
  }
}