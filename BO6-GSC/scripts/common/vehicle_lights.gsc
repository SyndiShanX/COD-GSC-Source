/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\vehicle_lights.gsc
*********************************************/

#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\engine\utility;
#namespace vehicle_lights;

function lights_on(group, classname) {
  groups = strtok(group, " ");
  utility::array_levelthread(groups, &lights_on_internal, classname);
}

function group_light(model, name, group) {
  if(!isDefined(level.vehicle.templates.vehicle_lights_group)) {
    level.vehicle.templates.vehicle_lights_group = [];
  }

  if(!isDefined(level.vehicle.templates.vehicle_lights_group[model])) {
    level.vehicle.templates.vehicle_lights_group[model] = [];
  }

  if(!isDefined(level.vehicle.templates.vehicle_lights_group[model][group])) {
    level.vehicle.templates.vehicle_lights_group[model][group] = [];
  }

  foreach(lightgroup_name in level.vehicle.templates.vehicle_lights_group[model][group]) {
    if(name == lightgroup_name) {
      return;
    }
  }

  level.vehicle.templates.vehicle_lights_group[model][group][level.vehicle.templates.vehicle_lights_group[model][group].size] = name;
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

function lights_off_internal(group, model, classname) {
  self notify("lights_off");

  if(isDefined(classname)) {
    model = classname;
  } else if(!isDefined(model)) {
    model = self.classname_mp ?? self.classname;
  }

  if(!isDefined(group)) {
    group = "all";
  }

  if(!isDefined(self.lights)) {
    return;
  }

  if(!isDefined(level.vehicle.templates.vehicle_lights_group[model][group])) {
    println("<dev string:x24>" + self.vehicletype);
    println("<dev string:x35>" + self.classname);
    println("<dev string:x44>" + group);

    assertmsg("<dev string:x55>");
    return;
  }

  lights = level.vehicle.templates.vehicle_lights_group[model][group];
  count = 0;
  maxlightstopsperframe = 2;

  if(isDefined(self.maxlightstopsperframe)) {
    maxlightstopsperframe = self.maxlightstopsperframe;
  }

  foreach(light in lights) {
    template = level.vehicle.templates.vehicle_lights[model][light];

    if(template.isscriptable) {
      utility::function_7c10ea82c1e305b8(template.part, "off");
    } else if(utility::hastag(self.model, template.tag)) {
      stopFXOnTag(template.effect, self, template.tag);
      count++;

      if(count >= maxlightstopsperframe) {
        count = 0;
        wait 0.05;
      }
    }

    if(!isDefined(self)) {
      return;
    }

    self.lights[light] = undefined;
  }
}

function lights_on_internal(group, model) {
  level.lastlighttime = gettime();
  self endon("lights_off");
  self endon("death");

  if(!isDefined(group)) {
    group = "all";
  }

  if(!isDefined(model)) {
    model = self.classname_mp ?? self.classname;
  }

  if(!isDefined(level.vehicle.templates.vehicle_lights_group)) {
    return;
  }

  if(!(isDefined(level.vehicle.templates.vehicle_lights_group[model]) && isDefined(level.vehicle.templates.vehicle_lights_group[model][group]))) {
    return;
  }

  thread lights_delayfxforframe();

  if(!isDefined(self.lights)) {
    self.lights = [];
  }

  lights = level.vehicle.templates.vehicle_lights_group[model][group];
  count = 0;
  var_6004cbf2423b4969 = [];

  foreach(light in lights) {
    if(isDefined(self.lights[light])) {
      continue;
    }

    template = level.vehicle.templates.vehicle_lights[model][light];

    if(isDefined(template.delay)) {
      delay = template.delay;
    } else {
      delay = 0;
    }

    delay += level.fxdelay;

    while(isDefined(var_6004cbf2423b4969[string(delay)])) {
      delay += 0.05;
    }

    var_6004cbf2423b4969[string(delay)] = 1;

    if(template.isscriptable) {
      if(vehicle::function_dfa3d2eee203d2d3(template.part)) {
        if(group == "brakelights") {
          utility::delaythread(delay, &utility::function_7c10ea82c1e305b8, template.part, "brake");
        } else if(group == "daylights") {
          utility::delaythread(delay, &utility::function_7c10ea82c1e305b8, template.part, "day");
        } else {
          utility::delaythread(delay, &utility::function_7c10ea82c1e305b8, template.part, "on");
        }
      }
    } else {
      childthread function_ef6384b76b1f62c6(delay, template.effect, self, template.tag);
    }

    self.lights[light] = 1;

    if(!isDefined(self)) {
      break;
    }
  }

  level.fxdelay = 0;
}

function private function_ef6384b76b1f62c6(timer, effect, entity, tag) {
  wait timer;
  playFXOnTag(effect, entity, tag);
}

function lights_off(group, model, classname) {
  groups = strtok(group, " ", model);
  utility::array_levelthread(groups, &lights_off_internal, model, classname);
}