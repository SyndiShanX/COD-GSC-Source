/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\common\vehicle_lights.gsc
************************************************/

#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\engine\utility;
#namespace vehicle_lights;

function lights_on(group, classname) {
  groups = strtok(group, " ");
  array_levelthread(groups, &lights_on_internal, classname);
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

  foreach(var_547909af7f4f97d4 in level.vehicle.templates.vehicle_lights_group[model][group]) {
    if(name == var_547909af7f4f97d4) {
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
    model = default_to(self.classname_mp, self.classname);
  }

  if(!isDefined(group)) {
    group = "all";
  }

  if(!isDefined(self.lights)) {
    return;
  }

  if(!isDefined(level.vehicle.templates.vehicle_lights_group[model][group])) {
    println("<dev string:x1c>" + self.vehicletype);
    println("<dev string:x2d>" + self.classname);
    println("<dev string:x3c>" + group);

    assertmsg("<dev string:x4d>");
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

    if(istrue(template.isscriptable)) {
      utility::function_3677f2be30fdd581(template.part, "off");
    } else if(hastag(self.model, template.tag)) {
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
    model = default_to(self.classname_mp, self.classname);
  }

  if(!isDefined(level.vehicle.templates.vehicle_lights_group)) {
    return;
  }

  if(!isDefined(level.vehicle.templates.vehicle_lights_group[model]) || !isDefined(level.vehicle.templates.vehicle_lights_group[model][group])) {
    return;
  }

  thread lights_delayfxforframe();

  if(!isDefined(self.lights)) {
    self.lights = [];
  }

  lights = level.vehicle.templates.vehicle_lights_group[model][group];
  count = 0;
  delayoffsetter = [];

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

    while(isDefined(delayoffsetter["" + delay])) {
      delay += 0.05;
    }

    delayoffsetter["" + delay] = 1;

    if(istrue(template.isscriptable)) {
      if(scripts\common\vehicle::function_9b915d163f6d1d5a(template.part)) {
        if(group == "brakelights") {
          delaythread(delay, &function_3677f2be30fdd581, template.part, "brake");
        } else if(group == "daylights") {
          delaythread(delay, &function_3677f2be30fdd581, template.part, "day");
        } else {
          delaythread(delay, &function_3677f2be30fdd581, template.part, "on");
        }
      }
    } else {
      childthread noself_delaycall_proc(&playfxontag, delay, template.effect, self, template.tag);
    }

    self.lights[light] = 1;

    if(!isDefined(self)) {
      break;
    }
  }

  level.fxdelay = 0;
}

function lights_off(group, model, classname) {
  groups = strtok(group, " ", model);
  array_levelthread(groups, &lights_off_internal, model, classname);
}