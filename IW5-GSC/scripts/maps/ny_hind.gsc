/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\ny_hind.gsc
**************************************/

_id_44F6() {
  if(isDefined(self._id_44F7)) {
    return;
  }
  self endon("death");
  self._id_44F7 = "none";

  for(;;) {
    self waittill("reached_dynamic_path_end");

    if(self._id_44F7 == "smooth") {
      self._id_44F9 = self._id_44F8;
    } else if(self._id_44F7 == "normal") {
      self._id_44F9 = self.currentnode;
    } else {
      self._id_44F9 = undefined;
    }
    self._id_44F7 = "none";
  }
}

_id_44FA(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_5 = 0;
  var_6 = self.origin;
  var_7 = self vehicle_getspeed() * 17.6;

  if(!isDefined(var_0)) {
    var_4 = 0;
    var_8 = var_1.origin - self.origin;
    var_5 = length(var_8);
    var_8 = vectorNormalize(var_8);
  } else {
    var_6 = var_0.origin;
    var_9 = self.origin;
    var_8 = var_1.origin - var_0.origin;
    var_5 = length(var_8);
    var_8 = vectorNormalize(var_8);
    var_10 = var_9 - var_0.origin;
    var_4 = vectordot(var_8, var_10);

    if(var_4 < 0) {
      var_4 = 0;
    }
  }

  var_11 = var_7 * var_3;
  var_4 = var_4 + var_11;
  var_12 = var_6 + var_4 * var_8;

  while(var_4 >= var_5) {
    var_4 = var_4 - var_5;

    if(!isDefined(var_2)) {
      var_12 = var_1.origin;
      var_4 = 0;
      continue;
    }

    var_13 = var_2.origin - var_1.origin;
    var_5 = length(var_13);

    if(var_4 < var_5) {
      var_13 = var_4 * vectorNormalize(var_13);
      var_12 = var_1.origin + var_13;
    } else {
      var_0 = var_1;
      var_1 = var_2;

      if(isDefined(var_2.target)) {
        var_2 = common_scripts\utility::getStruct(var_2.target, "targetname");
      } else {
        var_2 = undefined;
      }
    }
  }

  return var_12;
}

_id_44FB(var_0) {
  if(isDefined(var_0.script_prefab_exploder)) {
    var_0.script_exploder = var_0.script_prefab_exploder;
    var_0.script_prefab_exploder = undefined;
  }

  if(isDefined(var_0.script_exploder)) {
    var_1 = var_0.script_exploder_delay;

    if(isDefined(var_1)) {
      level maps\_utility::delaythread(var_1, common_scripts\utility::exploder, var_0.script_exploder);
    } else {
      level common_scripts\utility::exploder(var_0.script_exploder);
    }
  }

  if(isDefined(var_0.script_flag_set)) {
    if(isDefined(self.vehicle_flags)) {
      self.vehicle_flags[var_0.script_flag_set] = 1;
    }
    self notify("vehicle_flag_arrived", var_0.script_flag_set);
    common_scripts\utility::flag_set(var_0.script_flag_set);
  }

  if(isDefined(var_0.script_ent_flag_set)) {
    maps\_utility::ent_flag_set(var_0.script_ent_flag_set);
  }
  if(isDefined(var_0.script_ent_flag_clear)) {
    maps\_utility::ent_flag_clear(var_0.script_ent_flag_clear);
  }
  if(isDefined(var_0.script_flag_clear)) {
    if(isDefined(self.vehicle_flags)) {
      self.vehicle_flags[var_0.script_flag_clear] = 0;
    }
    common_scripts\utility::flag_clear(var_0.script_flag_clear);
  }

  if(isDefined(var_0.script_noteworthy)) {
    if(var_0.script_noteworthy == "kill") {
      maps\_vehicle::force_kill();
    }
    if(var_0.script_noteworthy == "godon") {
      maps\_vehicle::godon();
    }
    if(var_0.script_noteworthy == "godoff") {
      maps\_vehicle::godoff();
    }
    if(var_0.script_noteworthy == "deleteme") {
      level thread maps\_utility::deleteent(self);
      return;
    }
  }

  if(isDefined(var_0.script_crashtypeoverride)) {
    self.script_crashtypeoverride = var_0.script_crashtypeoverride;
  }
  if(isDefined(var_0.script_badplace)) {
    self.script_badplace = var_0.script_badplace;
  }
  if(isDefined(var_0.script_turretmg)) {
    self.script_turretmg = var_0.script_turretmg;
  }
  if(isDefined(var_0.script_team)) {
    self.script_team = var_0.script_team;
  }
  if(isDefined(var_0.script_turningdir)) {
    self notify("turning", var_0.script_turningdir);
  }
  if(isDefined(var_0.script_deathroll)) {
    if(var_0.script_deathroll == 0) {
      thread maps\_vehicle::deathrolloff();
    } else {
      thread maps\_vehicle::deathrollon();
    }
  }
}

_id_44FC(var_0) {
  self.lookahead = var_0;
}

_id_44FD(var_0, var_1, var_2) {
  if(var_0 > self.veh_speed && var_0 < var_1) {
    var_1 = var_0;
  }
  self._id_44FE = var_0;
  self._id_44FF = var_1;
  self._id_4500 = var_2;
  self vehicle_setspeed(var_0, var_1, var_2);
}

_id_4501() {
  if(isDefined(self._id_44FE)) {
    self._id_44FE = undefined;
  }
  if(isDefined(self._id_44FF)) {
    self._id_44FF = undefined;
  }
  if(isDefined(self._id_4500)) {
    self._id_4500 = undefined;
  }
}

_id_4502(var_0) {
  while(var_0 < -180) {
    var_0 = var_0 + 360;
  }
  while(var_0 > 180) {
    var_0 = var_0 - 360;
  }
  self._id_4503 = var_0;
  self settargetyaw(var_0);
}

_id_4504() {
  self._id_4503 = undefined;
  self cleartargetyaw();
}

_id_4505() {}

_id_4506(var_0, var_1, var_2) {
  self._id_4507 = var_0.targetname;

  if(_id_4508(var_0)) {
    thread _id_44F6();
    thread _id_4510(var_0, var_1, var_2);
    self._id_44F7 = "smooth";
  } else {
    thread _id_44F6();
    thread maps\_vehicle::vehicle_paths(var_0);
    self._id_44F7 = "normal";
  }
}

_id_4508(var_0) {
  if(isDefined(var_0.spawnflags) && var_0.spawnflags & 2) {
    return 1;
  }
  return 0;
}

_id_4509(var_0, var_1) {
  self._id_450A = self._id_44F8;

  if(isDefined(self._id_450B)) {
    var_2 = self._id_450B.script_airresistance;
    var_3 = self._id_450B.speed;
    var_4 = self._id_450B.script_accel;
    var_5 = self._id_450B.script_decel;
  } else {
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;
    var_5 = undefined;
  }

  if(isDefined(self._id_44FE)) {
    var_3 = self._id_44FE;
    var_4 = self._id_44FF;
    var_5 = self._id_4500;
  }

  if(isDefined(self._id_44F8.lookahead)) {
    var_6 = self._id_44F8.lookahead;
  }
  if(isDefined(self._id_44F8.radius)) {
    var_7 = self._id_44F8.radius;
  }
  var_8 = isDefined(self._id_44F8.script_stopnode) && self._id_44F8.script_stopnode;
  var_9 = isDefined(self._id_44F8.script_unload);
  var_10 = isDefined(self._id_44F8.script_flag_wait) && !common_scripts\utility::flag(self._id_44F8.script_flag_wait);
  var_11 = isDefined(self._id_44F8.script_delay);

  if(isDefined(self._id_44F8.angles)) {
    var_12 = self._id_44F8.angles[1];
  } else {
    var_12 = 0;
  }
  self vehicle_helisetai(var_0, var_3, var_4, var_5, self._id_44F8.script_goalyaw, self._id_44F8.script_anglevehicle, var_12, var_2, var_11, var_8, var_9, var_10, var_1);
  self._id_450C = var_0;
  self._id_450D = var_3;
  self._id_450E = var_4;
  self._id_450F = var_5;

  if((!isDefined(self._id_44F8.script_goalyaw) || !self._id_44F8.script_goalyaw) && isDefined(self._id_4503)) {
    self settargetyaw(self._id_4503);
  }
}

_id_4510(var_0, var_1, var_2) {
  self notify("newpath");
  self endon("newpath");
  _id_4501();
  self.lookahead = var_1;
  self._id_450B = undefined;
  self._id_44F8 = var_0;
  self._id_4511 = undefined;

  if(isDefined(self._id_44F8.target)) {
    self._id_4511 = common_scripts\utility::getStruct(self._id_44F8.target, "targetname");
  }
  while(isDefined(self._id_44F8)) {
    var_3 = self._id_44F8.origin;

    if(isDefined(self.heliheightoverride)) {
      var_3 = (var_3[0], var_3[1], self.heliheightoverride);
    }
    var_4 = length(var_3 - self.origin);
    var_5 = _id_44FA(self._id_450B, self._id_44F8, self._id_4511, self.lookahead);

    if(isDefined(self.heliheightoverride)) {
      var_5 = (var_5[0], var_5[1], self.heliheightoverride);
    }
    var_6 = self.origin - var_5;
    var_7 = vectorNormalize(var_6);
    var_8 = self.origin - var_3;

    if(!isDefined(self._id_4511)) {
      var_9 = var_2 + 10;
    } else {
      var_9 = vectordot(var_7, var_8);
    }
    if(var_4 < var_2 || var_9 < var_2) {
      _id_44FB(self._id_44F8);

      if(!isDefined(self._id_4511) && isDefined(self._id_44F8)) {
        _id_4509(self._id_44F8.origin, 1);
      }
      self._id_450B = self._id_44F8;
      self._id_44F8 = self._id_4511;
      self._id_4511 = undefined;

      if(isDefined(self._id_44F8) && isDefined(self._id_44F8.target)) {
        self._id_4511 = common_scripts\utility::getStruct(self._id_44F8.target, "targetname");
      }
      continue;
    }

    _id_4509(var_5, 0);
    wait 0.05;
  }

  _id_4523();

  if(isDefined(self._id_450B) && isDefined(self._id_450B.script_land)) {
    thread maps\_vehicle::vehicle_landvehicle();
  }
  self notify("reached_dynamic_path_end");

  if(isDefined(self._id_450B) && isDefined(self._id_450B.script_vehicle_selfremove)) {
    self delete();
  }
}

_id_4512(var_0, var_1, var_2) {}

_id_4513(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0;

  if(isDefined(var_0.target)) {
    var_5 = common_scripts\utility::getStruct(var_0.target, "targetname");

    if(!isDefined(var_5)) {
      var_5 = var_0;
    }
  }

  var_6[0] = var_0;

  while(var_5 != var_0) {
    var_6[var_6.size] = var_5;

    if(isDefined(var_5.target)) {
      var_5 = common_scripts\utility::getStruct(var_5.target, "targetname");

      if(!isDefined(var_5)) {
        break;
      }
    } else {
      break;
    }
  }

  var_7 = self.origin;

  if(!isDefined(self._id_44F7)) {
    var_8 = self vehicle_getvelocity();
  } else if(self._id_44F7 == "normal" && isDefined(self.currentnode)) {
    var_8 = self.origin - self.currentnode.origin;
  } else if(self._id_44F7 == "smooth" && isDefined(self._id_44F8)) {
    var_8 = self.origin - self._id_44F8.origin;
  } else {
    var_8 = self vehicle_getvelocity();
  }
  var_8 = vectorNormalize(var_8);
  var_9 = undefined;
  var_10 = 1000000;
  var_11 = undefined;
  var_12 = 1000000;

  foreach(var_5 in var_6) {
    var_14 = var_5.origin - var_7;
    var_15 = vectorNormalize(var_14);
    var_16 = vectordot(var_15, var_8);
    var_17 = length(var_14);

    if(var_16 > 0) {
      var_18 = (1 - var_16) * var_17;

      if(var_18 < var_10) {
        var_9 = var_5;
        var_10 = var_18;
      }
    }

    if(var_17 < var_12) {
      var_11 = var_5;
      var_12 = var_17;
    }
  }

  if(!isDefined(var_9)) {
    var_9 = var_11;
  }
  self._id_4507 = var_9.targetname;

  if(isDefined(var_3) || _id_4508(var_0) && !isDefined(var_4)) {
    thread _id_44F6();
    thread _id_4510(var_9, var_1, var_2);
    self._id_44F7 = "smooth-s";
  } else {
    thread _id_44F6();
    thread maps\_vehicle::vehicle_paths(var_9);
    self._id_44F7 = "normal-s";
  }
}

_id_4514(var_0, var_1, var_2) {
  self notify("stop_adjust");
  self endon("stop_adjust");
  self endon("death");
  var_3 = 1;
  var_4 = 0;

  if(var_2 > 0) {
    var_3 = 0.05 / var_2;
    var_4 = int(var_2 / 0.05);
  }

  var_5 = var_3 * (var_0 - self._id_4515);
  var_6 = var_3 * (var_1 - self._id_4516);

  while(var_4 > 0) {
    self._id_4515 = self._id_4515 + var_5;
    self._id_4516 = self._id_4516 + var_6;
    var_4--;
    wait 0.05;
  }

  self._id_4515 = var_0;
  self._id_4516 = var_1;
}

_id_4517(var_0) {
  self._id_4518 = var_0;
}

_id_4519(var_0, var_1, var_2, var_3) {
  self notify("newpath");
  self endon("newpath");
  var_0 endon("death");
  self endon("death");
  thread _id_44F6();
  self._id_44F7 = "follow";
  self._id_4507 = undefined;
  var_4 = 0.0;
  self._id_4515 = var_1;
  self._id_4516 = var_2;
  self._id_4518 = var_3;

  for(;;) {
    var_1 = self._id_4515;
    var_5 = var_0.origin;
    var_6 = var_0 vehicle_getvelocity();
    var_7 = self vehicle_getvelocity();
    var_8 = var_0 vehicle_getspeed();
    var_9 = vectorNormalize(var_6);
    var_10 = maps\_shg_common::vectorcross((0, 0, 1), var_9);
    var_10 = vectorNormalize(var_10);
    var_11 = maps\_shg_common::vectorcross(var_9, var_10);
    var_11 = vectorNormalize(var_11);
    var_12 = var_5 + var_1[0] * var_9 + var_1[1] * var_10 + var_1[2] * var_11;
    var_13 = var_12 - self.origin;
    var_14 = length(var_13);
    var_15 = length(self.origin - var_5);
    var_16 = length(var_1);
    var_17 = vectorNormalize(var_1);
    var_18 = vectordot(var_9, var_13);
    var_19 = var_8;

    if(var_18 > 0) {
      var_20 = 1.5 * length(var_1);
      var_21 = 1.0;

      if(var_14 > var_20) {
        var_19 = (1.0 + var_21) * var_19;
        var_22 = var_19;
        var_23 = var_19;
      } else {
        var_24 = 1.0 + var_21 * var_14 / var_20;
        var_19 = var_24 * var_19;
        var_22 = 0.75 * var_19;
        var_23 = 0.75 * var_19;
      }
    } else {
      var_20 = length(var_1);

      if(var_1[0] <= 0) {
        var_25 = 0.95;
      } else {
        var_25 = 0.75;
      }
      if(var_14 > var_20) {
        var_24 = var_25 * var_20 / var_14;
        var_19 = var_24 * var_19;
        var_22 = var_19;
        var_23 = var_19;
      } else {
        var_26 = 1.0 - var_14 / var_20;
        var_19 = (var_25 + var_26 * (1 - var_25)) * var_19;
        var_22 = 0.75 * var_19;
        var_23 = 0.75 * var_19;
      }
    }

    var_4 = 1.0;
    self vehicle_setspeed(var_19, var_22, var_23);

    if(isDefined(self._id_4518) && self._id_4518 > 0) {
      if(self._id_4518 == 1) {
        var_27 = self vehicle_getvelocity();
      } else {
        var_27 = var_0 vehicle_getvelocity();
      }
      var_28 = length(var_27);

      if(var_28 > 24) {
        var_29 = vectortoyaw(var_27);
        _id_4502(var_29 + self._id_4516);
      }
    } else {
      var_30 = vectortoyaw(var_0.origin - level.player getEye());
      _id_4502(var_30 + self._id_4516);
    }

    var_31 = var_12 + var_4 * var_6;
    self setvehgoalpos(var_31);
    wait 0.05;
  }
}

_id_451A(var_0, var_1, var_2, var_3) {
  self notify("newpath");
  self endon("newpath");
  var_0 endon("death");
  self endon("death");
  thread _id_44F6();
  self._id_44F7 = "followsm";
  self._id_4507 = undefined;
  self._id_4515 = var_1;
  self._id_4516 = var_2;
  self._id_4518 = var_3;

  for(;;) {
    var_1 = self._id_4515;
    var_4 = var_0.origin;
    var_5 = var_0 vehicle_getvelocity();
    var_6 = var_0 vehicle_getspeed();
    var_7 = vectorNormalize(var_5);
    var_8 = maps\_shg_common::vectorcross((0, 0, 1), var_7);
    var_8 = vectorNormalize(var_8);
    var_9 = maps\_shg_common::vectorcross(var_7, var_8);
    var_9 = vectorNormalize(var_9);
    var_10 = var_0._id_450C;
    var_11 = var_0._id_450D;
    var_12 = var_0._id_450E;
    var_13 = var_0._id_450F;
    var_14 = var_1[0] * var_7 + var_1[1] * var_8 + var_1[2] * var_9;
    var_15 = var_10 + var_14;
    var_16 = var_4 + var_14;
    var_17 = var_16 - self.origin;
    var_18 = length(var_17);
    var_19 = length(self.origin - var_4);
    var_20 = length(var_1);
    var_21 = vectorNormalize(var_1);
    var_22 = vectordot(var_7, var_17);
    var_23 = var_6;

    if(var_22 > 0) {
      var_24 = 1.5 * length(var_1);
      var_25 = 1.0;

      if(var_18 > var_24) {
        var_23 = (1.0 + var_25) * var_23;
        var_26 = var_23;
        var_27 = var_23;
      } else {
        var_28 = 1.0 + var_25 * var_18 / var_24;
        var_23 = var_28 * var_23;
        var_26 = 0.75 * var_23;
        var_27 = 0.75 * var_23;
      }
    } else {
      var_24 = length(var_1);

      if(var_1[0] <= 0) {
        var_29 = 0.95;
      } else {
        var_29 = 0.75;
      }
      if(var_18 > var_24) {
        var_28 = var_29 * var_24 / var_18;
        var_23 = var_28 * var_23;
        var_26 = var_23;
        var_27 = var_23;
      } else {
        var_30 = 1.0 - var_18 / var_24;
        var_23 = (var_29 + var_30 * (1 - var_29)) * var_23;
        var_26 = 0.75 * var_23;
        var_27 = 0.75 * var_23;
      }
    }

    self vehicle_setspeed(var_23, var_23, var_23);

    if(isDefined(self._id_4518) && self._id_4518 > 0) {
      if(self._id_4518 == 1) {
        var_31 = self vehicle_getvelocity();
      } else {
        var_31 = var_0 vehicle_getvelocity();
      }
      var_32 = length(var_31);

      if(var_32 > 24) {
        var_33 = vectortoyaw(var_31);
        _id_4502(var_33 + self._id_4516);
      }
    } else {
      var_34 = vectortoyaw(var_0.origin - level.player getEye());
      _id_4502(var_34 + self._id_4516);
    }

    self setvehgoalpos(var_15);
    wait 0.05;
  }
}

_id_451B(var_0, var_1) {
  var_2 = 1 - var_1;

  switch (var_0[4]) {
    case 1:
      return var_0[0] + var_1 * (var_0[3] - var_0[0]);
    case 3:
      var_3 = var_2 * var_2;
      var_4 = var_2 * var_3;
      var_5 = var_1 * var_1;
      var_6 = var_1 * var_5;
      return var_4 * var_0[0] + 3 * var_3 * var_1 * var_0[1] + 3 * var_2 * var_5 * var_0[2] + var_6 * var_0[3];
  }
}

_id_451C(var_0, var_1, var_2) {
  var_3 = var_1 - var_0;
  var_4 = length(var_3);
  var_5 = vectordot(vectorNormalize(var_3), var_2);

  if(var_5 != 0) {
    var_6 = 0.5 * var_4 / var_5;
    return var_6 * var_2;
  } else {
    var_6 = 0.5 * var_4;
    return var_6 * var_2;
  }
}

_id_451D(var_0, var_1, var_2, var_3, var_4) {
  var_5[4] = 3;
  var_5[3] = var_3.origin;

  if(isDefined(var_2)) {
    var_5[0] = var_2.origin;

    if(isDefined(var_4)) {
      var_6 = vectorNormalize(var_4.origin - var_5[0]);
      var_5[2] = var_5[3] - _id_451C(var_5[0], var_5[3], var_6);

      if(isDefined(var_1)) {
        var_6 = vectorNormalize(var_3.origin - var_1);
        var_5[1] = var_5[0] + _id_451C(var_5[0], var_5[3], var_6);
      } else {
        var_5[1] = var_5[2];
      }
    } else if(isDefined(var_1)) {
      var_6 = vectorNormalize(var_3.origin - var_1);
      var_5[1] = var_5[0] + _id_451C(var_5[0], var_5[3], var_6);
      var_5[2] = var_5[1];
    } else {
      var_5[4] = 1;
    }
  } else {
    var_5[0] = var_0;

    if(!isDefined(var_4)) {
      var_5[4] = 1;
    } else {
      var_6 = vectorNormalize(var_4.origin - var_5[0]);
      var_5[2] = var_5[3] - _id_451C(var_5[0], var_5[3], var_6);
      var_5[1] = var_5[2];
    }
  }

  return var_5;
}

_id_451E(var_0) {
  if(var_0[4] == 1) {
    var_1 = length(var_0[3] - var_0[0]);
  } else {
    var_1 = 0;
    var_2 = 0.05;
    var_3 = _id_451B(var_0, 0.0);

    for(var_4 = var_2; var_4 <= 1.0; var_4 = var_4 + var_2) {
      var_5 = _id_451B(var_0, var_4);
      var_1 = var_1 + length(var_5 - var_3);
      var_3 = var_5;
    }

    return var_1;
  }
}

_id_451F(var_0, var_1, var_2) {
  self endon("newpath");
  thread _id_44F6();
  self._id_44F7 = "bezier";
  self._id_4507 = var_0.targetname;
  self.lookahead = var_1;
  var_3 = self.origin;
  self._id_4520 = undefined;
  self._id_450B = undefined;
  self._id_44F8 = var_0;
  self._id_4511 = undefined;

  if(isDefined(self._id_44F8.target)) {
    self._id_4511 = common_scripts\utility::getStruct(self._id_44F8.target, "targetname");
  }
  while(isDefined(self._id_44F8)) {
    var_4 = _id_451D(self.origin, self._id_4520, self._id_450B, self._id_44F8, self._id_4511);

    if(isDefined(self._id_450B)) {
      var_5 = self._id_450B.script_airresistance;
      var_6 = self._id_450B.speed;
      var_7 = self._id_450B.script_accel;
      var_8 = self._id_450B.script_decel;
    } else {
      var_5 = undefined;
      var_6 = undefined;
      var_7 = undefined;
      var_8 = undefined;
    }

    if(isDefined(self._id_44F8.lookahead)) {
      var_1 = self._id_44F8.lookahead;
    }
    if(isDefined(self._id_44F8.radius)) {
      var_2 = self._id_44F8.radius;
    }
    var_9 = isDefined(self._id_44F8.script_stopnode) && self._id_44F8.script_stopnode;
    var_10 = isDefined(self._id_44F8.script_unload);
    var_11 = isDefined(self._id_44F8.script_flag_wait) && !common_scripts\utility::flag(self._id_44F8.script_flag_wait);
    var_12 = !isDefined(self._id_44F8.target);
    var_13 = isDefined(self._id_44F8.script_delay);

    if(isDefined(self._id_44F8.angles)) {
      var_14 = self._id_44F8.angles[1];
    } else {
      var_14 = 0;
    }
    var_15 = _id_451E(var_4);
    var_16 = 0;
    var_17 = var_2;
    var_18 = _id_451B(var_4, 0.0);
    var_19 = var_18;
    var_20 = 0.0;

    while(var_20 < 1.0) {
      var_16 = var_16 + length(var_19 - var_18);
      var_20 = (var_16 + var_17) / var_15;

      if(var_20 > 1.0) {
        var_20 = 1.0;
      }
      var_21 = _id_451B(var_4, var_20);
      _id_4527(var_21);
      self vehicle_helisetai(var_21, var_6, var_7, var_8, self._id_44F8.script_goalyaw, self._id_44F8.script_anglevehicle, var_14, var_5, var_13, var_9, var_10, var_11, var_12);

      if(length(self.origin - var_18) < var_2) {
        var_19 = var_18;
        var_18 = var_21;
      }

      _id_4522();
      var_20 = var_20 + 0.05;
      wait 0.05;
    }

    _id_44FB(self._id_44F8);

    if(isDefined(self._id_450B)) {
      self._id_4520 = self._id_450B.origin;
    } else {
      self._id_4520 = var_3;
    }
    self._id_450B = self._id_44F8;
    self._id_44F8 = self._id_4511;
    self._id_4511 = undefined;

    if(isDefined(self._id_44F8) && isDefined(self._id_44F8.target)) {
      self._id_4511 = common_scripts\utility::getStruct(self._id_44F8.target, "targetname");
    }
  }

  _id_4523();
}

_id_4521() {}

_id_4522() {}

_id_4523() {}

_id_4524() {}

_id_4525(var_0) {}

_id_4526(var_0) {}

_id_4527(var_0, var_1) {}

_id_4528() {}

_id_4529() {}

_id_452A(var_0, var_1) {}

_id_452B() {}

_id_452C(var_0, var_1) {}

_id_452D() {
  self endon("death");

  if(!isDefined(self.name)) {
    return;
  }
  for(;;) {
    var_0 = self.origin;
    var_1 = (0, 0, 60);

    if(isDefined(self._id_44F7)) {
      var_2 = "PT:" + self._id_44F7;

      if(isDefined(self._id_4507)) {
        var_2 = var_2 + " - " + self._id_4507;

        if(self._id_44F7 == "normal") {
          if(isDefined(self.currentnode) && isDefined(self.currentnode.target)) {
            var_2 = var_2 + " > " + self.currentnode.target;
          }
        } else if(self._id_44F7 == "smooth") {
          if(isDefined(self._id_44F8) && isDefined(self._id_44F8.target)) {
            var_2 = var_2 + " > " + self._id_44F8.target;
          }
        } else if(self._id_44F7 == "none") {
          if(isDefined(self._id_44F9) && isDefined(self._id_44F9.targetname)) {
            var_2 = var_2 + " | " + self._id_44F9.targetname;
          }
        }
      }
    }

    wait 0.05;
  }
}

_id_452E() {
  self endon("death");
  var_0 = self.health - self.healthbuffer;

  while(self.health > 0) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7);

    if(isDefined(var_1)) {
      var_8 = self.health - self.healthbuffer;
      self.debug_health_recs[self.debug_health_recs.size] = var_8;
      var_0 = var_8;
    }
  }
}

_id_4530() {
  self endon("death");
  self.debug_health_recs = [];
  self.debug_health_recs[0] = self.health - self.healthbuffer;
  thread _id_452E();
  var_0 = 0.1;

  for(;;) {
    var_1 = self.origin;
    var_2 = self.health - self.healthbuffer;
    var_3 = (0, 1, 0);

    if(var_2 < 0) {
      var_3 = (1, 1, 0);
    }
    for(var_4 = 0; var_4 < self.debug_health_recs.size; var_4++) {
      if(var_4 & 1) {
        var_3 = (1, 0, 0);
      } else {
        var_3 = (0, 0, 1);
      }
      var_5 = self.debug_health_recs[var_4];
      var_2 = var_5;
    }

    wait 0.05;
  }
}