/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\vehicle_lights.gsc
***********************************************/

function lights_on(var0, var1) {
  var2 = strtok(var0, " ");
  scripts\engine\utility::array_levelthread(var2, &lights_on_internal, var1);
}

function group_light(var0, var1, var2) {
  if(!isDefined(level.vehicle.templates.vehicle_lights_group)) {
    level.vehicle.templates.vehicle_lights_group = [];
  }

  if(!isDefined(level.vehicle.templates.vehicle_lights_group[var0])) {
    level.vehicle.templates.vehicle_lights_group[var0] = [];
  }

  if(!isDefined(level.vehicle.templates.vehicle_lights_group[var0][var2])) {
    level.vehicle.templates.vehicle_lights_group[var0][var2] = [];
  }

  foreach(var4 in level.vehicle.templates.vehicle_lights_group[var0][var2]) {
    if(var1 == var4) {
      return;
    }
  }

  level.vehicle.templates.vehicle_lights_group[var0][var2][level.vehicle.templates.vehicle_lights_group[var0][var2].size] = var1;
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

function lights_off_internal(var0, var1, var2) {
  self notify("lights_off");

  if(isDefined(var2)) {
    var1 = var2;
  } else if(!isDefined(var1)) {
    var1 = self.classname;
  }

  if(!isDefined(var0)) {
    var0 = "all";
  }

  if(!isDefined(self.lights)) {
    return;
  }

  if(!isDefined(level.vehicle.templates.vehicle_lights_group[var1][var0])) {
    return;
  }

  var3 = level.vehicle.templates.vehicle_lights_group[var1][var0];
  var4 = 0;
  var5 = 2;

  if(isDefined(self.maxlightstopsperframe)) {
    var5 = self.maxlightstopsperframe;
  }

  foreach(var7 in var3) {
    var8 = level.vehicle.templates.vehicle_lights[var1][var7];

    if(scripts\engine\utility::hastag(self.model, var8.tag)) {
      stopFXOnTag(var8.effect, self, var8.tag);
    }

    var4++;

    if(var4 >= var5) {
      var4 = 0;
      wait 0.05;
    }

    if(!isDefined(self)) {
      return;
    }

    self.lights[var7] = undefined;
  }
}

function lights_on_internal(var0, var1) {
  level.lastlighttime = gettime();
  self endon("lights_off");

  if(!isDefined(var0)) {
    var0 = "all";
  }

  if(!isDefined(var1)) {
    var1 = self.classname;
  }

  if(!isDefined(level.vehicle.templates.vehicle_lights_group)) {
    return;
  }

  if(!isDefined(level.vehicle.templates.vehicle_lights_group[var1]) || !isDefined(level.vehicle.templates.vehicle_lights_group[var1][var0])) {
    return;
  }

  thread lights_delayfxforframe();

  if(!isDefined(self.lights)) {
    self.lights = [];
  }

  var2 = level.vehicle.templates.vehicle_lights_group[var1][var0];
  var3 = 0;
  var4 = [];

  foreach(var6 in var2) {
    if(isDefined(self.lights[var6])) {
      continue;
    }

    var7 = level.vehicle.templates.vehicle_lights[var1][var6];

    if(isDefined(var7.delay)) {
      var8 = var7.delay;
    } else {
      var8 = 0;
    }

    var8 += level.fxdelay;

    while(isDefined(var4["" + var8])) {
      var8 += 0.05;
    }

    var4 = 1;
    self endon("death");
    childthread scripts\engine\utility::noself_delaycall_proc(&playfxontag, var8, var7.effect, self, var7.tag);
    self.lights[var6] = 1;

    if(!isDefined(self)) {
      break;
    }
  }

  level.fxdelay = 0;
}

function lights_off(var0, var1, var2) {
  var3 = strtok(var0, " ", var1);
  scripts\engine\utility::array_levelthread(var3, &lights_off_internal, var1, var2);
}

function unmatched_death_rig_light_waits_for_lights_off() {
  if(!isDefined(self.has_unmatching_deathmodel_rig)) {
    return;
  }

  while(isDefined(self.lights) && self.lights.size) {
    wait 0.05;
  }
}