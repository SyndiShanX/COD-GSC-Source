/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\prisoner\prisoner_dropship_code.gsc
***************************************************************/

_id_5EBC(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self notify("dropship_new_behavior");
  self notify("newpath");
  self endon("dropship_new_behavior");
  self clearlookatent();

  if(!isDefined(self._id_3F7B)) {
    self._id_3F7B = scripts\engine\utility::spawn_tag_origin();
  }

  self._id_3F7B linkTo(var_0, "tag_origin", (0, 0, 0), (0, 0, 0));
  _id_1241(var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

_id_5EBD(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  self notify("dropship_new_behavior");
  self notify("newpath");
  self endon("dropship_new_behavior");
  self clearlookatent();

  if(!isDefined(self._id_3F7B)) {
    self._id_3F7B = scripts\engine\utility::spawn_tag_origin();
  }

  var_8 = scripts\engine\utility::getStruct(var_0, "targetname");
  self._id_3F7B.origin = var_8.origin;
  _id_1241(var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

_id_5E9E(var_0, var_1, var_2) {
  self notify("new_lookat");

  if(!isDefined(self._id_7333)) {
    self._id_7333 = spawn("script_origin", self.origin);
  }

  if(!isDefined(self._id_272D)) {
    self._id_272D = spawn("script_origin", self.origin);
  }

  if(!isDefined(self._id_101B5)) {
    self._id_101B5 = spawn("script_origin", self.origin);
  }

  self._id_101B7 = var_1;
  self._id_101B6 = var_2;

  if(issubstr(var_0.classname, "temp")) {
    self._id_101B5 linkTo(var_0, var_0.model, (0, 0, 0), (0, 0, 0));
  } else {
    self._id_101B5 linkTo(var_0, "tag_origin", (0, 0, 0), (0, 0, 0));
  }

  thread _id_122F();
}

_id_122F() {
  self endon("new_lookat");
  self endon("stop_lookat");
  self endon("death");
  self setlookatent(self._id_7333);

  for(;;) {
    var_0 = vectorNormalize(self._id_101B5.origin - self.origin);
    var_1 = vectortoangles(var_0);
    var_2 = anglestoright(var_1);
    var_3 = var_2;

    if(isDefined(self._id_101B6) && self._id_101B6) {
      var_3 = anglesToForward(var_1) * -1;
    } else if(self._id_101B7 == 0) {
      var_3 = var_3 * -1.0;
    }

    var_4 = self.origin + var_3 * 1000;
    self._id_7333.origin = var_4;
    wait 0.05;
  }
}

_id_5EBE(var_0, var_1, var_2, var_3, var_4, var_5) {
  self notify("dropship_new_behavior");
  self notify("newpath");
  self endon("dropship_new_behavior");
  self._id_723D = var_1;
  self._id_7238 = _id_122C(var_0);
  self._id_7243 = var_2;
  self._id_7241 = var_3;

  if(isDefined(var_4)) {
    self._id_7244 = var_4;
  } else {
    self._id_7244 = 1;
  }

  if(isDefined(var_5)) {
    self._id_7242 = var_5;
  } else {
    self._id_7242 = 60;
  }

  self._id_7240 = 1;
  self setmaxpitchroll(0, 0);
  childthread _id_122B();
  childthread _id_122A();
}

_id_5DB6(var_0) {
  self notify("dropship_new_behavior");
  self endon("dropship_new_behavior");

  if(isDefined(var_0) && var_0 == 1) {
    var_1 = -1.0;
  } else {
    var_1 = 1.0;
  }

  var_2 = self.origin + anglestoright(self.angles) * var_1 * 4000.0 + anglesToForward(self.angles) * -500.0;
  var_3 = self.origin + anglestoright(self.angles) * var_1 * -100.0 + anglesToForward(self.angles) * 50.0;
  _id_0BBF::_id_F37E(self.angles[1]);
  self vehicle_setspeed(40, 40, 40);
  self setmaxpitchroll(40, 40);
  self setneargoalnotifydist(50);
  self setvehgoalpos(var_2, 0);
  wait 0.6;
  self setmaxpitchroll(5, 3);
  self setvehgoalpos(var_3, 0);
  wait 0.45;
  self vehicle_setspeed(10, 10, 10);
  wait 2.0;
  self vehicle_setspeed(0, 20, 10);
  self notify("dropship_finished_dodge");
}

_id_5EA0(var_0) {
  self notify("new_lookat");

  if(!isDefined(self._id_7333)) {
    self._id_7333 = spawn("script_origin", self.origin);
  }

  self._id_7333 unlink();
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  self._id_7333.origin = var_1.origin;
  self setlookatent(self._id_7333);
}

_id_5E9F(var_0, var_1, var_2) {
  self notify("new_lookat");

  if(!isDefined(self._id_7333)) {
    self._id_7333 = spawn("script_origin", self.origin);
  }

  if(!isDefined(self._id_272D)) {
    self._id_272D = spawn("script_origin", self.origin);
  }

  if(!isDefined(self._id_101B5)) {
    self._id_101B5 = spawn("script_origin", self.origin);
  }

  self._id_101B7 = var_1;
  self._id_101B6 = var_2;
  self._id_101B5 unlink();
  var_3 = scripts\engine\utility::getStruct(var_0, "targetname");
  self._id_101B5.origin = var_3.origin;
  thread _id_122F();
}

_id_5DC8(var_0) {
  if(var_0 == 1) {
    scripts\sp\vehicle::_id_8441();
    self.health = 10000000;
  } else {
    scripts\sp\vehicle::_id_8440();
    self.health = 100;
  }
}

_id_5E72(var_0, var_1, var_2, var_3) {
  return scripts\sp\maps\prisoner\prisoner_util::_id_106B5(var_0._id_10871, var_1, undefined, var_2, var_0);
}

_id_1241(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self._id_3F7A = var_0;
  self._id_3F81 = var_1;
  self._id_3F7E = var_2;
  self._id_3F80 = var_3;

  if(isDefined(var_5)) {
    self._id_3F7F = var_5;
  }

  var_7 = 785 / self._id_3F7E;
  self._id_3F7D = floor(clamp(6.28318 / var_7, 8, 64));

  if(isDefined(var_6)) {
    self._id_4B2D = _id_1219(var_6);
  } else {
    self._id_4B2D = _id_1219(3);
  }

  _id_121D();
  self setmaxpitchroll(0, 0);
  childthread _id_1220();

  if(isDefined(var_4) && var_4 == 1) {
    childthread _id_121F();
  }

  _id_5E9E(self._id_3F7B, !var_0);
}

_id_1220() {
  for(;;) {
    self setneargoalnotifydist(1000.0);
    _id_121B();
    self._id_4B2D = self._id_4B2D + 1;

    if(self._id_4B2D >= self._id_3F7D) {
      self._id_4B2D = 0;
    }
  }
}

_id_121B(var_0) {
  self endon("dropship_near_goal");
  thread _id_1235();

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  self._id_3F75 = spawnStruct();

  if(!var_0) {
    self._id_3F75 = scripts\engine\utility::spawn_tag_origin();
    self._id_3F75.origin = _id_121A(self._id_4B2D);
    self._id_3F75 linkTo(self);
    self setvehgoalpos(self._id_3F75.origin);
  }

  for(;;) {
    if(var_0) {
      self._id_3F75.origin = _id_121A(self._id_4B2D);
    }

    if(var_0) {
      self setvehgoalpos(self._id_3F75.origin);
    }

    wait 0.1;
  }
}

_id_121A(var_0) {
  var_1 = 360 / self._id_3F7D;

  if(self._id_3F7A) {
    var_1 = var_1 * -1.0;
  }

  var_2 = (0, var_1 * var_0, 0);
  var_3 = anglesToForward(var_2);
  self._id_3F7C = self._id_3F7B.origin;
  var_4 = self._id_3F7C + var_3 * self._id_3F7E;
  var_4 = _id_121C(var_4);
  return var_4;
}

_id_1218() {
  var_0 = [];

  for(var_1 = 0; var_1 < self._id_3F7D; var_1++) {
    var_0[var_1] = _id_121A(var_1);
  }

  return var_0;
}

_id_1219(var_0) {
  var_1 = _id_1218();
  var_2 = distancesquared(var_1[0], self.origin);
  var_3 = var_1[0];
  var_4 = 0;

  foreach(var_8, var_6 in var_1) {
    var_7 = distancesquared(var_6, self.origin);

    if(var_7 < var_2) {
      var_3 = var_6;
      var_4 = var_8;
      var_2 = var_7;
    }
  }

  var_9 = undefined;

  if(isDefined(var_0)) {
    var_4 = var_4 + var_0;

    if(var_4 > self._id_3F7D) {
      var_4 = var_4 - self._id_3F7D;
    }

    var_9 = var_4;
  } else
    var_9 = var_4;

  return var_9;
}

_id_121C(var_0) {
  return (var_0[0], var_0[1], var_0[2] + self._id_3F81);
}

_id_121F() {
  var_0 = 0;

  for(;;) {
    if(var_0 == 0 && level.player playerads() >= 0.5) {
      var_0 = 1;
      _id_121E();
    } else if(var_0 == 1 && level.player playerads() < 0.5) {
      var_0 = 0;
      _id_121D();
    }

    wait 0.1;
  }
}

_id_122C(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "targetname");
  var_2 = [];
  var_3 = var_1[0];
  var_2 = scripts\engine\utility::array_add(var_2, var_3);

  while(isDefined(var_3.target)) {
    var_4 = scripts\engine\utility::getStruct(var_3.target, "targetname");

    if(isDefined(var_4)) {
      var_2 = scripts\engine\utility::array_add(var_2, var_4);
      var_3 = var_4;
      continue;
    }

    break;
  }

  return var_2;
}

_id_122B() {
  self._id_723F = self._id_723D.origin;
  scripts\engine\utility::waitframe();
  self._id_723E = self._id_723D.origin;

  for(;;) {
    var_0 = _id_1229();
    var_1 = _id_1226(var_0);
    var_2 = var_1 * 0.2;

    if(var_1 <= 0.0) {
      self vehicle_setspeed(var_1);
    } else {
      self vehicle_setspeed(var_1, var_2, var_2);
    }

    if(var_1 > 0.0) {
      self setvehgoalpos(var_0);
    }

    wait 0.1;
  }
}

_id_1226(var_0) {
  if(self._id_7244 == 1) {
    var_1 = self._id_723D.veh_speed;
  } else {
    var_1 = self._id_7242;
  }

  if(self._id_7244) {
    var_2 = distance2dsquared(self.origin, var_0) - 16000000;

    if(var_2 < 0.0) {
      var_1 = var_1 * 0.9;
    } else if(var_2 < 640000) {} else if(var_2 < 2250000) {
      var_1 = var_1 * 1.5;
    } else if(var_2 < 9000000) {
      var_1 = var_1 * 2.0;
    } else {
      var_1 = var_1 * 2.5;
    }
  }

  return var_1;
}

_id_122A(var_0) {
  if(!isDefined(self._id_7333)) {
    self._id_7333 = spawn("script_origin", self.origin);
  }

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  wait(var_0);
  self setlookatent(self._id_7333);

  for(;;) {
    var_1 = self.origin + self._id_723A * 1000;
    self._id_7333.origin = var_1;
    wait 0.1;
  }
}

_id_1229() {
  self._id_7239 = _id_1228();
  self._id_723B = vectorNormalize(scripts\engine\utility::flat_origin(self._id_7239 - self._id_723D.origin));

  if(distance2dsquared(self.origin, self._id_7239) < distance2dsquared(self.origin, self._id_723D.origin)) {
    self._id_723B = self._id_723B * -1.0;
  }

  self._id_723A = anglestoright(vectortoangles(self._id_723B));
  self._id_723C = self._id_723B * -1.0;
  var_0 = vectorNormalize(scripts\engine\utility::flat_origin(self._id_723E - self._id_723F));

  if(vectordot(self._id_723A, var_0) < 0) {
    self._id_723A = self._id_723A * -1.0;
    self._id_723C = self._id_723C * -1.0;
  }

  var_1 = self._id_7239 + (0, 0, 1) * self._id_7243 + self._id_723C * self._id_7241 + self._id_723A * self._id_7240 * 4000;

  if(distance2dsquared(var_1, self.origin) <= 1000000) {
    self._id_7240++;
    var_1 = var_1 + self._id_723A * self._id_7240 * 4000;
  }

  return var_1;
}

_id_1228() {
  var_0 = _id_122D(self._id_7238, self._id_723D.origin);
  return var_0;
}

_id_1227() {
  for(;;) {
    if(!isDefined(self._id_7238)) {
      break;
    }

    foreach(var_1 in self._id_7238) {
      var_2 = var_1.origin;
      thread scripts\engine\utility::draw_line_for_time(var_2 - (0, 0, 16), var_2 + (0, 0, 16), 1, 0, 0, 0.2);
      thread scripts\engine\utility::draw_line_for_time(var_2 - (0, 16, 0), var_2 + (0, 16, 0), 1, 0, 0, 0.2);
      thread scripts\engine\utility::draw_line_for_time(var_2 - (16, 0, 0), var_2 + (16, 0, 0), 1, 0, 0, 0.2);
    }

    wait 0.2;
  }
}

_id_122D(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size - 1; var_3++) {
    var_2[var_2.size] = pointonsegmentnearesttopoint(var_0[var_3].origin, var_0[var_3 + 1].origin, var_1);
  }

  var_4 = distancesquared(var_2[0], var_1);
  var_5 = var_2[0];

  foreach(var_7 in var_2) {
    var_8 = distancesquared(var_7, var_1);

    if(var_8 < var_4) {
      var_5 = var_7;
      var_4 = var_8;
    }
  }

  return var_5;
}

_id_121D() {
  var_0 = self._id_3F80 * 0.75;
  self vehicle_setspeed(self._id_3F80, var_0);
  self setyawspeed(90.0, 25.0, 15.0, 0.2);
}

_id_121E() {
  var_0 = self._id_3F7F;
  var_1 = var_0 * 0.75;
  self vehicle_setspeed(var_0, var_1);
  self setyawspeed(90.0, 25.0, 15.0, 0.2);
}

_id_1235() {
  self notify("stop__dropship_notify_near_goal");
  self endon("stop__dropship_notify_near_goal");
  scripts\engine\utility::waittill_either("near_goal", "goal");
  self notify("dropship_near_goal");
}