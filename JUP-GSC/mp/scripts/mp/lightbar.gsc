/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\lightbar.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace lightbar;

function init() {}

function add_to_lightbar_stack(lbcolor, pulsetime, priority, endondeath, time, endonnotification) {
  if(!isDefined(priority)) {
    priority = 0;
  }

  if(time == 0) {
    time = undefined;
  }

  if(!isDefined(self.lightbarstructs) || self.lightbarstructs.size == 0) {
    lightbarstructs = [];
    lightbarstructs[0] = spawnStruct();
    self.lightbarstructs = lightbarstructs;
  } else {
    tempstructs = array_removeundefined(self.lightbarstructs);
    self.lightbarstructs = tempstructs;
    self.lightbarstructs[self.lightbarstructs.size] = spawnStruct();
  }

  self.lightbarstructs[self.lightbarstructs.size - 1].lbcolor = lbcolor;
  self.lightbarstructs[self.lightbarstructs.size - 1].pulsetime = pulsetime;
  self.lightbarstructs[self.lightbarstructs.size - 1].priority = priority;
  self.lightbarstructs[self.lightbarstructs.size - 1].endondeath = endondeath;
  self.lightbarstructs[self.lightbarstructs.size - 1].timeplacedinstack = gettime();
  self.lightbarstructs[self.lightbarstructs.size - 1].executing = 0;
  self.lightbarstructs[self.lightbarstructs.size - 1].endonnotification = endonnotification;

  if(isDefined(time)) {
    self.lightbarstructs[self.lightbarstructs.size - 1].time = time * 1000;
  } else {
    self.lightbarstructs[self.lightbarstructs.size - 1].time = undefined;
  }

  if(isDefined(endondeath) && endondeath) {
    thread endinactiveinstructionondeath(self.lightbarstructs[self.lightbarstructs.size - 1]);
  }

  if(isDefined(endonnotification)) {
    thread endinstructiononnotification(endonnotification, self.lightbarstructs[self.lightbarstructs.size - 1]);
  }

  thread managelightbarstack();
}

function managelightbarstack() {
  self notify("manageLightBarStack");
  self endon("manageLightBarStack");
  self endon("disconnect");

  for(;;) {
    wait 0.05;

    if(self.lightbarstructs.size > 1) {
      var_26f6ffd6e2ec128f = removetimedoutinstructions(self.lightbarstructs);
      var_43e4767d6281a8cd = array_sort_with_func(var_26f6ffd6e2ec128f, &is_higher_priority);
    } else {
      var_43e4767d6281a8cd = self.lightbarstructs;
    }

    if(var_43e4767d6281a8cd.size == 0) {
      return;
    }

    self.lightbarstructs = var_43e4767d6281a8cd;
    var_a50968c75b047599 = var_43e4767d6281a8cd[0];

    if(var_a50968c75b047599.executing) {
      continue;
    }

    infinitetime = !isDefined(self.lightbarstructs[self.lightbarstructs.size - 1].time);
    timeleft = 0;

    if(!infinitetime) {
      timesinceplaced = gettime() - var_a50968c75b047599.timeplacedinstack;
      timeleft = var_a50968c75b047599.time - timesinceplaced;
      timeleft /= 1000;

      if(timeleft <= 0) {
        self.lightbarstructs[0] notify("removed");
        self.lightbarstructs[0] = undefined;
        cleanlbarray();
        managelightbarstack();
      }
    }

    if(infinitetime) {
      if(var_a50968c75b047599.endondeath) {
        var_a50968c75b047599 notify("executing");
        var_a50968c75b047599.executing = 1;
        thread set_lightbar_perm_endon_death(var_a50968c75b047599.lbcolor, var_a50968c75b047599.pulsetime);
      } else {
        thread set_lightbar_perm(var_a50968c75b047599.lbcolor, var_a50968c75b047599.pulsetime);
      }

      continue;
    }

    if(var_a50968c75b047599.endondeath) {
      var_a50968c75b047599 notify("executing");
      var_a50968c75b047599.executing = 1;
      thread set_lightbar_for_time_endon_death(var_a50968c75b047599.lbcolor, var_a50968c75b047599.pulsetime, timeleft);
      continue;
    }

    thread set_lightbar_for_time(var_a50968c75b047599.lbcolor, var_a50968c75b047599.pulsetime, timeleft);
  }
}

function cleanlbarray() {
  var_9b4ba2e4466f114b = array_removeundefined(self.lightbarstructs);
  self.lightbarstructs = var_9b4ba2e4466f114b;
}

function removetimedoutinstructions(structarray) {
  temparray = [];

  foreach(instruction in structarray) {
    if(!isDefined(instruction.time)) {
      temparray[temparray.size] = instruction;
      continue;
    }

    timesinceplaced = gettime() - instruction.timeplacedinstack;
    timeleft = instruction.time - timesinceplaced;
    timeleft /= 1000;

    if(timeleft > 0) {
      temparray[temparray.size] = instruction;
    }
  }

  return temparray;
}

function is_higher_priority(a, b) {
  return a.priority > b.priority;
}

function set_lightbar(lbcolor, pulsetime) {
  set_lightbar_pulse_time(pulsetime);
  set_lightbar_color(lbcolor);
  set_lightbar_on();
}

function set_lightbar_for_time(lbcolor, pulsetime, time) {
  self notify("set_lightbar_for_time");
  self endon("set_lightbar_for_time");
  set_lightbar_pulse_time(pulsetime);
  set_lightbar_color(lbcolor);
  set_lightbar_on();
  wait time;

  if(!isDefined(self)) {
    return;
  }

  set_lightbar_off();
  self.lightbarstructs = undefined;
  cleanlbarray();
}

function set_lightbar_perm(lbcolor, pulsetime) {
  self notify("set_lightbar");
  self endon("set_lightbar");
  set_lightbar_pulse_time(pulsetime);
  set_lightbar_color(lbcolor);
  set_lightbar_on();
}

function set_lightbar_endon_death(lbcolor, pulsetime) {
  set_lightbar_pulse_time(pulsetime);
  set_lightbar_color(lbcolor);
  set_lightbar_on();
  thread turn_off_light_bar_on_death();
}

function set_lightbar_for_time_endon_death(lbcolor, pulsetime, time) {
  self notify("set_lightbar_for_time_endon_death");
  self endon("set_lightbar_for_time_endon_death");
  set_lightbar_pulse_time(pulsetime);
  set_lightbar_color(lbcolor);
  set_lightbar_on();
  thread turn_off_light_bar_on_death();
  wait time;

  if(!isDefined(self)) {
    return;
  }

  set_lightbar_off();
  self.lightbarstructs[0] notify("removed");
  self.lightbarstructs[0] = undefined;
  cleanlbarray();
}

function set_lightbar_perm_endon_death(lbcolor, pulsetime) {
  self notify("set_lightbar_endon_death");
  self endon("set_lightbar_endon_death");
  set_lightbar_pulse_time(pulsetime);
  set_lightbar_color(lbcolor);
  set_lightbar_on();
  thread turn_off_light_bar_on_death();
}

function endinactiveinstructionondeath(var_bbfd8d645f3d6f98) {
  self notify("endInactiveInstructionOnDeath");
  self endon("endInactiveInstructionOnDeath");
  var_bbfd8d645f3d6f98 endon("executing");
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

function endinstructiononnotification(endonnotification, var_bbfd8d645f3d6f98) {
  var_bbfd8d645f3d6f98 endon("removed");

  if(isarray(endonnotification)) {
    notificationreturned = waittill_any_in_array_return(endonnotification);
  } else {
    self waittill(endonnotification);
  }

  if(!isDefined(self)) {
    return;
  }

  for(i = 0; i < self.lightbarstructs.size; i++) {
    if(var_bbfd8d645f3d6f98 == self.lightbarstructs[i]) {
      if(var_bbfd8d645f3d6f98.executing) {
        set_lightbar_off();
      }

      self.lightbarstructs[i] = undefined;
      cleanlbarray();
      return;
    }
  }
}

function turn_off_light_bar_on_death() {
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

function set_lightbar_color(lbcolor) {
  self setclientomnvar("lb_color", lbcolor);
}

function set_lightbar_on() {
  self setclientomnvar("lb_gsc_controlled", 1);
}

function set_lightbar_off() {
  self setclientomnvar("lb_gsc_controlled", 0);
}

function set_lightbar_pulse_time(pulsetime) {
  self setclientomnvar("lb_pulse_time", pulsetime);
}