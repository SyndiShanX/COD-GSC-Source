/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\vehicle_lights.gsc
***********************************************/

function lights_on(var_0, var_1) {
  var_2 = strtok(var_0, " ");
  scripts\engine\utility::array_levelthread(var_2, &lights_on_internal, var_1);
}

function group_light(var_0, var_1, var_2) {
  if(!isDefined(level.vehicle.templates.vehicle_lights_group)) {
    level.vehicle.templates.vehicle_lights_group = [];
  }

  if(!isDefined(level.vehicle.templates.vehicle_lights_group[var_0])) {
    level.vehicle.templates.vehicle_lights_group[var_0] = [];
  }

  if(!isDefined(level.vehicle.templates.vehicle_lights_group[var_0][var_2])) {
    level.vehicle.templates.vehicle_lights_group[var_0][var_2] = [];
  }

  foreach(var_4 in level.vehicle.templates.vehicle_lights_group[var_0][var_2]) {
    if(var_1 == var_4) {
      return;
    }
  }

  level.vehicle.templates.vehicle_lights_group[var_0][var_2][level.vehicle.templates.vehicle_lights_group[var_0][var_2].size] = var_1;
}

function lights_delayfxforframe() {
  level notify("new_lights_delayfxforframe");
  level endon("new_lights_delayfxforframe");

  if(!isDefined(level.fxdelay)) {
    level.fxdelay = 0;
  }

  level.fxdelay += randomfloatrange(0.2, 0.4);

  if(level.fxdelay > 2) {
    level.fxdelay = 0;
  }

  wait 0.05;
  level.fxdelay = undefined;
}

function lights_off_internal(var_0, var_1, var_2) {
  self notify("lights_off");

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

  if(!isDefined(level.vehicle.templates.vehicle_lights_group[var_1][var_0])) {
    return;
  }

  var_3 = level.vehicle.templates.vehicle_lights_group[var_1][var_0];
  var_4 = 0;
  var_5 = 2;

  if(isDefined(self.maxlightstopsperframe)) {
    var_5 = self.maxlightstopsperframe;
  }

  foreach(var_7 in var_3) {
    var_8 = level.vehicle.templates.vehicle_lights[var_1][var_7];

    if(scripts\engine\utility::hastag(self.model, var_8.tag)) {
      stopFXOnTag(var_8.effect, self, var_8.tag);
    }

    var_4++;

    if(var_4 >= var_5) {
      var_4 = 0;
      wait 0.05;
    }

    if(!isDefined(self)) {
      return;
    }

    self.lights[var_7] = undefined;
  }
}

function lights_on_internal(var_0, var_1) {
  level.lastlighttime = gettime();
  self endon("lights_off");

  if(!isDefined(var_0)) {
    var_0 = "all";
  }

  if(!isDefined(var_1)) {
    var_1 = self.classname;
  }

  if(!isDefined(level.vehicle.templates.vehicle_lights_group)) {
    return;
  }

  if(!isDefined(level.vehicle.templates.vehicle_lights_group[var_1]) || !isDefined(level.vehicle.templates.vehicle_lights_group[var_1][var_0])) {
    return;
  }

  thread lights_delayfxforframe();

  if(!isDefined(self.lights)) {
    self.lights = [];
  }

  var_2 = level.vehicle.templates.vehicle_lights_group[var_1][var_0];
  var_3 = 0;
  var_4 = [];

  foreach(var_6 in var_2) {
    if(isDefined(self.lights[var_6])) {
      continue;
    }

    var_7 = level.vehicle.templates.vehicle_lights[var_1][var_6];

    if(isDefined(var_7.delay)) {
      var_8 = var_7.delay;
    } else {
      var_8 = 0;
    }

    var_8 += level.fxdelay;

    while(isDefined(var_4["" + var_8])) {
      var_8 += 0.05;
    }

    var_4 = 1;
    self endon("death");
    childthread scripts\engine\utility::noself_delaycall_proc(&playfxontag, var_8, var_7.effect, self, var_7.tag);
    self.lights[var_6] = 1;

    if(!isDefined(self)) {
      break;
    }
  }

  level.fxdelay = 0;
}

function lights_off(var_0, var_1, var_2) {
  var_3 = strtok(var_0, " ", var_1);
  scripts\engine\utility::array_levelthread(var_3, &lights_off_internal, var_1, var_2);
}

function unmatched_death_rig_light_waits_for_lights_off() {
  if(!isDefined(self.has_unmatching_deathmodel_rig)) {
    return;
  }

  while(isDefined(self.lights) && self.lights.size) {
    wait 0.05;
  }
}