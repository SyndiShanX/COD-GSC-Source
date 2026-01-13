/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\2967.gsc
************************/

lights_on(var_0, var_1) {
  var_2 = strtok(var_0, " ");
  scripts\engine\utility::array_levelthread(var_2, ::func_ACCF, var_1);
}

func_8695(var_0, var_1, var_2) {
  if(!isDefined(level.vehicle.var_116CE.var_13209)) {
    level.vehicle.var_116CE.var_13209 = [];
  }

  if(!isDefined(level.vehicle.var_116CE.var_13209[var_0])) {
    level.vehicle.var_116CE.var_13209[var_0] = [];
  }

  if(!isDefined(level.vehicle.var_116CE.var_13209[var_0][var_2])) {
    level.vehicle.var_116CE.var_13209[var_0][var_2] = [];
  }

  foreach(var_4 in level.vehicle.var_116CE.var_13209[var_0][var_2]) {
    if(var_1 == var_4) {
      return;
    }
  }

  level.vehicle.var_116CE.var_13209[var_0][var_2][level.vehicle.var_116CE.var_13209[var_0][var_2].size] = var_1;
}

func_ACCA() {
  level notify("new_lights_delayfxforframe");
  level endon("new_lights_delayfxforframe");
  if(!isDefined(level.var_7624)) {
    level.var_7624 = 0;
  }

  level.var_7624 = level.var_7624 + randomfloatrange(0.2, 0.4);
  if(level.var_7624 > 2) {
    level.var_7624 = 0;
  }

  wait(0.05);
  level.var_7624 = undefined;
}

func_A5F2(var_0) {
  lights_off_internal("all", var_0);
}

lights_off_internal(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_1 = var_2;
  } else if(!isDefined(var_1)) {
    var_1 = self.classname;
  }

  if(!isDefined(var_0)) {
    var_0 = "all";
  }

  if(!isDefined(self.lights)) {
    return;
  }

  if(!isDefined(level.vehicle.var_116CE.var_13209[var_1][var_0])) {
    return;
  }

  var_3 = level.vehicle.var_116CE.var_13209[var_1][var_0];
  var_4 = 0;
  var_5 = 2;
  if(isDefined(self.var_B4AE)) {
    var_5 = self.var_B4AE;
  }

  foreach(var_7 in var_3) {
    var_8 = level.vehicle.var_116CE.var_13208[var_1][var_7];
    if(scripts\sp\utility::hastag(self.model, var_8.physics_setgravitydynentscalar)) {
      stopFXOnTag(var_8.effect, self, var_8.physics_setgravitydynentscalar);
    }

    var_4++;
    if(var_4 >= var_5) {
      var_4 = 0;
      wait(0.05);
    }

    if(!isDefined(self)) {
      return;
    }

    self.lights[var_7] = undefined;
  }
}

func_ACCF(var_0, var_1) {
  level.var_A9AE = gettime();
  if(!isDefined(var_0)) {
    var_0 = "all";
  }

  if(!isDefined(var_1)) {
    var_1 = self.classname;
  }

  if(!isDefined(level.vehicle.var_116CE.var_13209)) {
    return;
  }

  if(!isDefined(level.vehicle.var_116CE.var_13209[var_1]) || !isDefined(level.vehicle.var_116CE.var_13209[var_1][var_0])) {
    return;
  }

  thread func_ACCA();
  if(!isDefined(self.lights)) {
    self.lights = [];
  }

  var_2 = level.vehicle.var_116CE.var_13209[var_1][var_0];
  var_3 = 0;
  var_4 = [];
  foreach(var_6 in var_2) {
    if(isDefined(self.lights[var_6])) {
      continue;
    }

    var_7 = level.vehicle.var_116CE.var_13208[var_1][var_6];
    if(isDefined(var_7.delay)) {
      var_8 = var_7.delay;
    } else {
      var_8 = 0;
    }

    var_8 = var_8 + level.var_7624;
    while(isDefined(var_4["" + var_8])) {
      var_8 = var_8 + 0.05;
    }

    var_4["" + var_8] = 1;
    self endon("death");
    childthread scripts\engine\utility::noself_delaycall_proc(::playfxontag, var_8, var_7.effect, self, var_7.physics_setgravitydynentscalar);
    self.lights[var_6] = 1;
    if(!isDefined(self)) {
      break;
    }
  }

  level.var_7624 = 0;
}

lights_off(var_0, var_1, var_2) {
  var_3 = strtok(var_0, " ", var_1);
  scripts\engine\utility::array_levelthread(var_3, ::lights_off_internal, var_1, var_2);
}

func_12BE2() {
  if(!isDefined(self.var_8BB8)) {
    return;
  }

  while(isDefined(self.lights) && self.lights.size) {
    wait(0.05);
  }
}