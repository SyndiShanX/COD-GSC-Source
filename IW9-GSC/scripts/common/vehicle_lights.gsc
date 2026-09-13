/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\vehicle_lights.gsc
***********************************************/

lights_on(group, classname) {
  groups = strtok(group, " ");
  scripts\engine\utility::array_levelthread(groups, ::lights_on_internal, classname);
}

group_light(model, name, group) {
  if(!isDefined(level.vehicle.templates.vehicle_lights_group))
    level.vehicle.templates.vehicle_lights_group = [];

  if(!isDefined(level.vehicle.templates.vehicle_lights_group[model]))
    level.vehicle.templates.vehicle_lights_group[model] = [];

  if(!isDefined(level.vehicle.templates.vehicle_lights_group[model][group]))
    level.vehicle.templates.vehicle_lights_group[model][group] = [];

  foreach(_id_547909AF7F4F97D4 in level.vehicle.templates.vehicle_lights_group[model][group]) {
    if(name == _id_547909AF7F4F97D4)
      return;
  }

  level.vehicle.templates.vehicle_lights_group[model][group][level.vehicle.templates.vehicle_lights_group[model][group].size] = name;
}

lights_delayfxforframe() {
  level notify("new_lights_delayfxforframe");
  level endon("new_lights_delayfxforframe");

  if(!isDefined(level.fxdelay))
    level.fxdelay = 0;

  level.fxdelay = level.fxdelay + randomfloatrange(0.2, 0.4);

  if(level.fxdelay > 2)
    level.fxdelay = 0;

  wait 0.05;
  level.fxdelay = undefined;
}

lights_off_internal(group, model, classname) {
  self notify("lights_off");

  if(isDefined(classname))
    model = classname;
  else if(!isDefined(model))
    model = scripts\engine\utility::_id_53C4C53197386572(self.classname_mp, self.classname);

  if(!isDefined(group))
    group = "all";

  if(!isDefined(self.lights)) {
    return;
  }
  if(!isDefined(level.vehicle.templates.vehicle_lights_group[model][group])) {
    return;
  }
  lights = level.vehicle.templates.vehicle_lights_group[model][group];
  count = 0;
  maxlightstopsperframe = 2;

  if(isDefined(self.maxlightstopsperframe))
    maxlightstopsperframe = self.maxlightstopsperframe;

  foreach(light in lights) {
    _id_C24636EF1987E477 = level.vehicle.templates.vehicle_lights[model][light];

    if(istrue(_id_C24636EF1987E477.isscriptable))
      scripts\common\utility::_id_3677F2BE30FDD581(_id_C24636EF1987E477.part, "off");
    else if(scripts\engine\utility::hastag(self.model, _id_C24636EF1987E477.tag)) {
      stopFXOnTag(_id_C24636EF1987E477.effect, self, _id_C24636EF1987E477.tag);
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

lights_on_internal(group, model) {
  level.lastlighttime = gettime();
  self endon("lights_off");
  self endon("death");

  if(!isDefined(group))
    group = "all";

  if(!isDefined(model))
    model = scripts\engine\utility::_id_53C4C53197386572(self.classname_mp, self.classname);

  if(!isDefined(level.vehicle.templates.vehicle_lights_group)) {
    return;
  }
  if(!isDefined(level.vehicle.templates.vehicle_lights_group[model]) || !isDefined(level.vehicle.templates.vehicle_lights_group[model][group])) {
    return;
  }
  thread lights_delayfxforframe();

  if(!isDefined(self.lights))
    self.lights = [];

  lights = level.vehicle.templates.vehicle_lights_group[model][group];
  count = 0;
  _id_CCBC0E3634B40C2A = [];

  foreach(light in lights) {
    if(isDefined(self.lights[light])) {
      continue;
    }
    _id_C24636EF1987E477 = level.vehicle.templates.vehicle_lights[model][light];

    if(isDefined(_id_C24636EF1987E477.delay))
      delay = _id_C24636EF1987E477.delay;
    else
      delay = 0;

    for(delay = delay + level.fxdelay; isDefined(_id_CCBC0E3634B40C2A["" + delay]); delay = delay + 0.05) {}

    _id_CCBC0E3634B40C2A["" + delay] = 1;

    if(istrue(_id_C24636EF1987E477.isscriptable)) {
      if(scripts\common\vehicle::_id_9B915D163F6D1D5A(_id_C24636EF1987E477.part)) {
        if(group == "brakelights")
          scripts\engine\utility::delaythread(delay, scripts\common\utility::_id_3677F2BE30FDD581, _id_C24636EF1987E477.part, "brake");
        else if(group == "daylights")
          scripts\engine\utility::delaythread(delay, scripts\common\utility::_id_3677F2BE30FDD581, _id_C24636EF1987E477.part, "day");
        else
          scripts\engine\utility::delaythread(delay, scripts\common\utility::_id_3677F2BE30FDD581, _id_C24636EF1987E477.part, "on");
      }
    } else
      childthread scripts\engine\utility::noself_delaycall_proc(::playfxontag, delay, _id_C24636EF1987E477.effect, self, _id_C24636EF1987E477.tag);

    self.lights[light] = 1;

    if(!isDefined(self)) {
      break;
    }
  }

  level.fxdelay = 0;
}

lights_off(group, model, classname) {
  groups = strtok(group, " ", model);
  scripts\engine\utility::array_levelthread(groups, ::lights_off_internal, model, classname);
}