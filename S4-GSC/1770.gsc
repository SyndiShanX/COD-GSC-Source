/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1770.gsc
*************************************************/

_id_94A3(var_0, var_1) {
  var_2 = strtok(var_0, " ");
  scripts\engine\utility::_id_1BB7(var_2, ::_id_94A5, var_1);
}

_id_7217(var_0, var_1, var_2) {
  if(!isDefined(level.vehicle._id_F078._id_10134)) {
    level.vehicle._id_F078._id_10134 = [];
  }

  if(!isDefined(level.vehicle._id_F078._id_10134[var_0])) {
    level.vehicle._id_F078._id_10134[var_0] = [];
  }

  if(!isDefined(level.vehicle._id_F078._id_10134[var_0][var_2])) {
    level.vehicle._id_F078._id_10134[var_0][var_2] = [];
  }

  foreach(var_4 in level.vehicle._id_F078._id_10134[var_0][var_2]) {
    if(var_1 == var_4) {
      return;
    }
  }

  level.vehicle._id_F078._id_10134[var_0][var_2][level.vehicle._id_F078._id_10134[var_0][var_2].size] = var_1;
}

_id_949C() {
  level notify("new_lights_delayfxforframe");
  level endon("new_lights_delayfxforframe");

  if(!isDefined(level._id_6087)) {
    level._id_6087 = 0;
  }

  level._id_6087 = level._id_6087 + randomfloatrange(0.2, 0.4);

  if(level._id_6087 > 2) {
    level._id_6087 = 0;
  }

  wait 0.05;
  level._id_6087 = undefined;
}

_id_94A0(var_0, var_1, var_2) {
  self notify("lights_off");

  if(isDefined(var_2)) {
    var_1 = var_2;
  } else if(!isDefined(var_1)) {
    var_1 = self.classname;
  }

  if(!isDefined(var_0)) {
    var_0 = "all";
  }

  if(!isDefined(self._id_949B)) {
    return;
  }
  if(!isDefined(level.vehicle._id_F078._id_10134[var_1][var_0])) {
    return;
  }
  var_3 = level.vehicle._id_F078._id_10134[var_1][var_0];
  var_4 = 0;
  var_5 = 2;

  if(isDefined(self._id_9C83)) {
    var_5 = self._id_9C83;
  }

  self._id_94A1 = 1;

  foreach(var_7 in var_3) {
    self._id_949B[var_7] = -1;
  }

  foreach(var_7 in var_3) {
    var_10 = level.vehicle._id_F078._id_10133[var_1][var_7];

    if(isDefined(var_10._id_F847)) {
      if(self._id_9E6C[var_10._id_F847] tagexists(var_10._id_0427)) {
        stopFXOnTag(var_10._id_5106, self._id_9E6C[var_10._id_F847], var_10._id_0427);
      }
    } else if(self tagexists(var_10._id_0427))
      stopFXOnTag(var_10._id_5106, self, var_10._id_0427);

    var_4++;

    if(var_4 >= var_5) {
      var_4 = 0;
      wait 0.05;
    }

    if(!isDefined(self)) {
      return;
    }
    self._id_949B[var_7] = undefined;
  }

  self._id_94A1 = undefined;
}

_id_94A5(var_0, var_1) {
  level._id_9008 = gettime();
  self endon("lights_off");
  self endon("death");

  if(!isDefined(var_0)) {
    var_0 = "all";
  }

  if(!isDefined(var_1)) {
    var_1 = self.classname;
  }

  if(!isDefined(level.vehicle._id_F078._id_10134)) {
    return;
  }
  if(!isDefined(level.vehicle._id_F078._id_10134[var_1]) || !isDefined(level.vehicle._id_F078._id_10134[var_1][var_0])) {
    return;
  }
  thread _id_949C();

  if(!isDefined(self._id_949B)) {
    self._id_949B = [];
  }

  var_2 = level.vehicle._id_F078._id_10134[var_1][var_0];
  var_3 = 0;
  var_4 = [];

  foreach(var_6 in var_2) {
    if(isDefined(self._id_949B[var_6]) && self._id_949B[var_6] == 1) {
      continue;
    }
    var_7 = level.vehicle._id_F078._id_10133[var_1][var_6];

    if(isDefined(var_7._id_4649)) {
      var_8 = var_7._id_4649;
    } else {
      var_8 = 0;
    }

    for(var_8 = var_8 + level._id_6087; isDefined(var_4["" + var_8]); var_8 = var_8 + 0.05) {}

    var_4["" + var_8] = 1;

    if(isDefined(var_7._id_F847)) {
      childthread _id_DD59(self._id_9E6C[var_7._id_F847], var_8, var_7);
    } else {
      childthread _id_DD59(self, var_8, var_7);
    }

    self._id_949B[var_6] = 1;

    if(!isDefined(self)) {
      break;
    }
  }

  level._id_6087 = 0;
}

_id_DD59(var_0, var_1, var_2) {
  var_0 endon("death");
  wait(var_1);

  for(;;) {
    if(istrue(self._id_94A1)) {
      waitframe();
      continue;
    }

    break;
  }

  playFXOnTag(var_2._id_5106, self, var_2._id_0427);
}

_id_949F(var_0, var_1, var_2) {
  var_3 = strtok(var_0, " ", var_1);
  scripts\engine\utility::_id_1BB7(var_3, ::_id_94A0, var_1, var_2);
}

_id_F998() {
  if(!isDefined(self._id_752A)) {
    return;
  }
  while(isDefined(self._id_949B) && self._id_949B.size) {
    wait 0.05;
  }
}

_id_D2AF(var_0, var_1) {
  self._id_7604 = var_0;
  var_0 linkto(self, self._id_760D, self._id_7607, self._id_7606);
  var_0 _meth_8338(1);
  var_0 _meth_833B(500);
  var_0 _meth_8340("forceshadowon");

  if(isDefined(var_1)) {
    if(isDefined(var_1._id_023B)) {
      var_0 _meth_8338(var_1._id_023B);
    }

    if(isDefined(var_1._id_0359)) {
      var_0 _meth_833B(var_1._id_0359);
    }

    if(isDefined(var_1.outer_fov) || isDefined(var_1.inner_fov)) {
      var_0 _meth_8337(var_1.outer_fov, var_1.inner_fov);
    }

    if(isDefined(var_1.shadow_bias)) {
      var_0 _meth_833C(var_1.shadow_bias);
    }

    if(isDefined(var_1.shadow_near_plane_bias)) {
      var_0 _meth_833D(var_1.shadow_near_plane_bias);
    }
  }

  if(isDefined(self._id_4571)) {
    if(isDefined(self._id_7605)) {
      playFXOnTag(self._id_4571, self, self._id_7605);
    }

    if(isDefined(self._id_7608)) {
      playFXOnTag(self._id_4571, self, self._id_7608);
    }
  }
}

toggle_optimized_headlight_ent(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_2 = self._id_7604 _meth_8146();

    if(var_2 != 0) {
      var_0 = 0;
    } else {
      var_0 = 1;
    }
  }

  if(var_0) {
    self._id_7604 _meth_8338(1);
    playFXOnTag(self._id_4571, self, self._id_7605);
    playFXOnTag(self._id_4571, self, self._id_7608);
  } else {
    self._id_7604 _meth_8338(0);
    _func_012F(self._id_4571, self, self._id_7605);
    _func_012F(self._id_4571, self, self._id_7608);
  }
}

_id_D2B0(var_0) {
  var_0 linkto(self, self._id_ED7C, self._id_ED7B, self._id_ED7A);
  var_0 _meth_8334((1, 0, 0));
  var_0 _meth_8338(0);
  var_0 _meth_833B(150);
  var_0 _meth_8337(120, 110);
  var_0 _meth_8335(0.1);

  if(isDefined(self._id_4594)) {
    return;
  }
}

_id_D240(var_0) {
  self endon("death");

  if(self._id_7609 == self._id_760A || isDefined(self.health) && self.health <= 0) {
    self._id_7609 = self._id_760B;
    self._id_7604 _meth_8338(0);
    self._id_7604 _meth_8340("forceshadowoff");
  } else if(self._id_7609 == self._id_760C) {
    self._id_7609 = self._id_760A;

    if(isDefined(self._id_7608) && var_0 == self._id_7608) {
      self._id_7604 linkto(self, self._id_7605, (0, 0, 0), (20, 0, 0));
    } else if(isDefined(self._id_7605) && var_0 == self._id_7605) {
      self._id_7604 linkto(self, self._id_7608, (0, 0, 0), (20, 0, 0));
    }

    self._id_7604 _meth_8338(0.1);
  }

  if(isDefined(self.health) && self.health > 0 && isDefined(self._id_4571)) {
    if(var_0 == self._id_7608) {
      _func_012F(self._id_4571, self, self._id_7608);
    } else {
      _func_012F(self._id_4571, self, self._id_7605);
    }
  }
}