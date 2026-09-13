/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\lightbar.gsc
***********************************************/

init() {}

add_to_lightbar_stack(lbcolor, pulsetime, priority, endondeath, time, endonnotification) {
  if(!isDefined(priority))
    priority = 0;

  if(time == 0)
    time = undefined;

  if(!isDefined(self.lightbarstructs) || self.lightbarstructs.size == 0) {
    lightbarstructs = [];
    lightbarstructs[0] = spawnStruct();
    self.lightbarstructs = lightbarstructs;
  } else {
    _id_EAD859BDE85BAB93 = scripts\engine\utility::array_removeundefined(self.lightbarstructs);
    self.lightbarstructs = _id_EAD859BDE85BAB93;
    self.lightbarstructs[self.lightbarstructs.size] = spawnStruct();
  }

  self.lightbarstructs[self.lightbarstructs.size - 1].lbcolor = lbcolor;
  self.lightbarstructs[self.lightbarstructs.size - 1].pulsetime = pulsetime;
  self.lightbarstructs[self.lightbarstructs.size - 1].priority = priority;
  self.lightbarstructs[self.lightbarstructs.size - 1].endondeath = endondeath;
  self.lightbarstructs[self.lightbarstructs.size - 1].timeplacedinstack = gettime();
  self.lightbarstructs[self.lightbarstructs.size - 1].executing = 0;
  self.lightbarstructs[self.lightbarstructs.size - 1].endonnotification = endonnotification;

  if(isDefined(time))
    self.lightbarstructs[self.lightbarstructs.size - 1].time = time * 1000;
  else
    self.lightbarstructs[self.lightbarstructs.size - 1].time = undefined;

  if(isDefined(endondeath) && endondeath)
    thread endinactiveinstructionondeath(self.lightbarstructs[self.lightbarstructs.size - 1]);

  if(isDefined(endonnotification))
    thread endinstructiononnotification(endonnotification, self.lightbarstructs[self.lightbarstructs.size - 1]);

  thread managelightbarstack();
}

managelightbarstack() {
  self notify("manageLightBarStack");
  self endon("manageLightBarStack");
  self endon("disconnect");

  for(;;) {
    wait 0.05;

    if(self.lightbarstructs.size > 1) {
      _id_26F6FFD6E2EC128F = removetimedoutinstructions(self.lightbarstructs);
      _id_43E4767D6281A8CD = scripts\engine\utility::array_sort_with_func(_id_26F6FFD6E2EC128F, ::is_higher_priority);
    } else
      _id_43E4767D6281A8CD = self.lightbarstructs;

    if(_id_43E4767D6281A8CD.size == 0) {
      return;
    }
    self.lightbarstructs = _id_43E4767D6281A8CD;
    _id_A50968C75B047599 = _id_43E4767D6281A8CD[0];

    if(_id_A50968C75B047599.executing) {
      continue;
    }
    _id_B35959950D148F08 = !isDefined(self.lightbarstructs[self.lightbarstructs.size - 1].time);
    _id_8DD9F2EB8215A139 = 0;

    if(!_id_B35959950D148F08) {
      _id_88CE9464142CF30B = gettime() - _id_A50968C75B047599.timeplacedinstack;
      _id_8DD9F2EB8215A139 = _id_A50968C75B047599.time - _id_88CE9464142CF30B;
      _id_8DD9F2EB8215A139 = _id_8DD9F2EB8215A139 / 1000;

      if(_id_8DD9F2EB8215A139 <= 0) {
        self.lightbarstructs[0] notify("removed");
        self.lightbarstructs[0] = undefined;
        cleanlbarray();
        managelightbarstack();
      }
    }

    if(_id_B35959950D148F08) {
      if(_id_A50968C75B047599.endondeath) {
        _id_A50968C75B047599 notify("executing");
        _id_A50968C75B047599.executing = 1;
        thread set_lightbar_perm_endon_death(_id_A50968C75B047599.lbcolor, _id_A50968C75B047599.pulsetime);
      } else
        thread set_lightbar_perm(_id_A50968C75B047599.lbcolor, _id_A50968C75B047599.pulsetime);

      continue;
    }

    if(_id_A50968C75B047599.endondeath) {
      _id_A50968C75B047599 notify("executing");
      _id_A50968C75B047599.executing = 1;
      thread set_lightbar_for_time_endon_death(_id_A50968C75B047599.lbcolor, _id_A50968C75B047599.pulsetime, _id_8DD9F2EB8215A139);
      continue;
    }

    thread set_lightbar_for_time(_id_A50968C75B047599.lbcolor, _id_A50968C75B047599.pulsetime, _id_8DD9F2EB8215A139);
  }
}

cleanlbarray() {
  _id_9B4BA2E4466F114B = scripts\engine\utility::array_removeundefined(self.lightbarstructs);
  self.lightbarstructs = _id_9B4BA2E4466F114B;
}

removetimedoutinstructions(_id_70DAB3207FB65169) {
  _id_50F783A5617F8940 = [];

  foreach(_id_9E9F10E08F2DB833 in _id_70DAB3207FB65169) {
    if(!isDefined(_id_9E9F10E08F2DB833.time)) {
      _id_50F783A5617F8940[_id_50F783A5617F8940.size] = _id_9E9F10E08F2DB833;
      continue;
    }

    _id_88CE9464142CF30B = gettime() - _id_9E9F10E08F2DB833.timeplacedinstack;
    _id_8DD9F2EB8215A139 = _id_9E9F10E08F2DB833.time - _id_88CE9464142CF30B;
    _id_8DD9F2EB8215A139 = _id_8DD9F2EB8215A139 / 1000;

    if(_id_8DD9F2EB8215A139 > 0)
      _id_50F783A5617F8940[_id_50F783A5617F8940.size] = _id_9E9F10E08F2DB833;
  }

  return _id_50F783A5617F8940;
}

is_higher_priority(a, b) {
  return a.priority > b.priority;
}

set_lightbar(lbcolor, pulsetime) {
  set_lightbar_pulse_time(pulsetime);
  set_lightbar_color(lbcolor);
  set_lightbar_on();
}

set_lightbar_for_time(lbcolor, pulsetime, time) {
  self notify("set_lightbar_for_time");
  self endon("set_lightbar_for_time");
  set_lightbar_pulse_time(pulsetime);
  set_lightbar_color(lbcolor);
  set_lightbar_on();
  wait(time);

  if(!isDefined(self)) {
    return;
  }
  set_lightbar_off();
  self.lightbarstructs = undefined;
  cleanlbarray();
}

set_lightbar_perm(lbcolor, pulsetime) {
  self notify("set_lightbar");
  self endon("set_lightbar");
  set_lightbar_pulse_time(pulsetime);
  set_lightbar_color(lbcolor);
  set_lightbar_on();
}

set_lightbar_endon_death(lbcolor, pulsetime) {
  set_lightbar_pulse_time(pulsetime);
  set_lightbar_color(lbcolor);
  set_lightbar_on();
  thread turn_off_light_bar_on_death();
}

set_lightbar_for_time_endon_death(lbcolor, pulsetime, time) {
  self notify("set_lightbar_for_time_endon_death");
  self endon("set_lightbar_for_time_endon_death");
  set_lightbar_pulse_time(pulsetime);
  set_lightbar_color(lbcolor);
  set_lightbar_on();
  thread turn_off_light_bar_on_death();
  wait(time);

  if(!isDefined(self)) {
    return;
  }
  set_lightbar_off();
  self.lightbarstructs[0] notify("removed");
  self.lightbarstructs[0] = undefined;
  cleanlbarray();
}

set_lightbar_perm_endon_death(lbcolor, pulsetime) {
  self notify("set_lightbar_endon_death");
  self endon("set_lightbar_endon_death");
  set_lightbar_pulse_time(pulsetime);
  set_lightbar_color(lbcolor);
  set_lightbar_on();
  thread turn_off_light_bar_on_death();
}

endinactiveinstructionondeath(_id_BBFD8D645F3D6F98) {
  self notify("endInactiveInstructionOnDeath");
  self endon("endInactiveInstructionOnDeath");
  _id_BBFD8D645F3D6F98 endon("executing");
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  if(self.lightbarstructs.size == 0) {
    return;
  }
  self.lightbarstructs[0] notify("removed");
  self.lightbarstructs[0] = undefined;
  cleanlbarray();
}

endinstructiononnotification(endonnotification, _id_BBFD8D645F3D6F98) {
  _id_BBFD8D645F3D6F98 endon("removed");

  if(isarray(endonnotification))
    _id_9431E1BDA8D7C305 = scripts\engine\utility::waittill_any_in_array_return(endonnotification);
  else
    self waittill(endonnotification);

  if(!isDefined(self)) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.lightbarstructs.size; _id_AC0E594AC96AA3A8++) {
    if(_id_BBFD8D645F3D6F98 == self.lightbarstructs[_id_AC0E594AC96AA3A8]) {
      if(_id_BBFD8D645F3D6F98.executing)
        set_lightbar_off();

      self.lightbarstructs[_id_AC0E594AC96AA3A8] = undefined;
      cleanlbarray();
      return;
    }
  }
}

turn_off_light_bar_on_death() {
  self notify("turn_Off_Light_Bar_On_Death");
  self endon("turn_Off_Light_Bar_On_Death");
  self waittill("death");

  if(!isDefined(self)) {
    return;
  }
  if(self.lightbarstructs.size == 0) {
    return;
  }
  set_lightbar_off();
  self.lightbarstructs[0] notify("removed");
  self.lightbarstructs[0] = undefined;
  cleanlbarray();
}

set_lightbar_color(lbcolor) {
  self setclientomnvar("lb_color", lbcolor);
}

set_lightbar_on() {
  self setclientomnvar("lb_gsc_controlled", 1);
}

set_lightbar_off() {
  self setclientomnvar("lb_gsc_controlled", 0);
}

set_lightbar_pulse_time(pulsetime) {
  self setclientomnvar("lb_pulse_time", pulsetime);
}