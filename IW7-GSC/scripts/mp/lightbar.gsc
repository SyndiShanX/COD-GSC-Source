/***********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\lightbar.gsc
***********************************/

init() {}

func_1768(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(var_4 == 0) {
    var_4 = undefined;
  }

  if(!isDefined(self.lightbarstructs) || self.lightbarstructs.size == 0) {
    var_6 = [];
    var_6[0] = spawnStruct();
    self.lightbarstructs = var_6;
  } else {
    var_7 = scripts\mp\utility::cleanarray(self.lightbarstructs);
    self.lightbarstructs = var_7;
    self.lightbarstructs[self.lightbarstructs.size] = spawnStruct();
  }

  self.lightbarstructs[self.lightbarstructs.size - 1].lbcolor = var_0;
  self.lightbarstructs[self.lightbarstructs.size - 1].pulsetime = var_1;
  self.lightbarstructs[self.lightbarstructs.size - 1].priority = var_2;
  self.lightbarstructs[self.lightbarstructs.size - 1].endondeath = var_3;
  self.lightbarstructs[self.lightbarstructs.size - 1].timeplacedinstack = gettime();
  self.lightbarstructs[self.lightbarstructs.size - 1].executing = 0;
  self.lightbarstructs[self.lightbarstructs.size - 1].var_636F = var_5;
  if(isDefined(var_4)) {
    self.lightbarstructs[self.lightbarstructs.size - 1].time = var_4 * 1000;
  } else {
    self.lightbarstructs[self.lightbarstructs.size - 1].time = undefined;
  }

  if(isDefined(var_3) && var_3) {
    thread endinactiveinstructionondeath(self.lightbarstructs[self.lightbarstructs.size - 1]);
  }

  if(isDefined(var_5)) {
    thread endinstructiononnotification(var_5, self.lightbarstructs[self.lightbarstructs.size - 1]);
  }

  thread managelightbarstack();
}

managelightbarstack() {
  self notify("manageLightBarStack");
  self endon("manageLightBarStack");
  self endon("disconnect");
  for(;;) {
    wait(0.05);
    if(self.lightbarstructs.size > 1) {
      var_0 = removetimedoutinstructions(self.lightbarstructs);
      var_1 = scripts\engine\utility::array_sort_with_func(var_0, ::is_higher_priority);
    } else {
      var_1 = self.lightbarstructs;
    }

    if(var_1.size == 0) {
      return;
    }

    self.lightbarstructs = var_1;
    var_2 = var_1[0];
    if(var_2.executing) {
      continue;
    }

    var_3 = !isDefined(self.lightbarstructs[self.lightbarstructs.size - 1].time);
    var_4 = 0;
    if(!var_3) {
      var_5 = gettime() - var_2.timeplacedinstack;
      var_4 = var_2.time - var_5;
      var_4 = var_4 / 1000;
      if(var_4 <= 0) {
        self.lightbarstructs[0] notify("removed");
        self.lightbarstructs[0] = undefined;
        cleanlbarray();
        managelightbarstack();
      }
    }

    if(var_3) {
      if(var_2.endondeath) {
        var_2 notify("executing");
        var_2.executing = 1;
        thread set_lightbar_perm_endon_death(var_2.lbcolor, var_2.pulsetime);
      } else {
        thread set_lightbar_perm(var_2.lbcolor, var_2.pulsetime);
      }

      continue;
    }

    if(var_2.endondeath) {
      var_2 notify("executing");
      var_2.executing = 1;
      thread set_lightbar_for_time_endon_death(var_2.lbcolor, var_2.pulsetime, var_4);
      continue;
    }

    thread set_lightbar_for_time(var_2.lbcolor, var_2.pulsetime, var_4);
  }
}

cleanlbarray() {
  var_0 = scripts\mp\utility::cleanarray(self.lightbarstructs);
  self.lightbarstructs = var_0;
}

removetimedoutinstructions(var_0) {
  var_1 = [];
  foreach(var_3 in var_0) {
    if(!isDefined(var_3.time)) {
      var_1[var_1.size] = var_3;
      continue;
    }

    var_4 = gettime() - var_3.timeplacedinstack;
    var_5 = var_3.time - var_4;
    var_5 = var_5 / 1000;
    if(var_5 > 0) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

is_higher_priority(var_0, var_1) {
  return var_0.priority > var_1.priority;
}

set_lightbar(var_0, var_1) {
  set_lightbar_pulse_time(var_1);
  set_lightbar_color(var_0);
  set_lightbar_on();
}

set_lightbar_for_time(var_0, var_1, var_2) {
  self notify("set_lightbar_for_time");
  self endon("set_lightbar_for_time");
  set_lightbar_pulse_time(var_1);
  set_lightbar_color(var_0);
  set_lightbar_on();
  wait(var_2);
  if(!isDefined(self)) {
    return;
  }

  set_lightbar_off();
  self.lightbarstructs = undefined;
  cleanlbarray();
}

set_lightbar_perm(var_0, var_1) {
  self notify("set_lightbar");
  self endon("set_lightbar");
  set_lightbar_pulse_time(var_1);
  set_lightbar_color(var_0);
  set_lightbar_on();
}

set_lightbar_endon_death(var_0, var_1) {
  set_lightbar_pulse_time(var_1);
  set_lightbar_color(var_0);
  set_lightbar_on();
  thread turn_off_light_bar_on_death();
}

set_lightbar_for_time_endon_death(var_0, var_1, var_2) {
  self notify("set_lightbar_for_time_endon_death");
  self endon("set_lightbar_for_time_endon_death");
  set_lightbar_pulse_time(var_1);
  set_lightbar_color(var_0);
  set_lightbar_on();
  thread turn_off_light_bar_on_death();
  wait(var_2);
  if(!isDefined(self)) {
    return;
  }

  set_lightbar_off();
  self.lightbarstructs[0] notify("removed");
  self.lightbarstructs[0] = undefined;
  cleanlbarray();
}

set_lightbar_perm_endon_death(var_0, var_1) {
  self notify("set_lightbar_endon_death");
  self endon("set_lightbar_endon_death");
  set_lightbar_pulse_time(var_1);
  set_lightbar_color(var_0);
  set_lightbar_on();
  thread turn_off_light_bar_on_death();
}

endinactiveinstructionondeath(var_0) {
  self notify("endInactiveInstructionOnDeath");
  self endon("endInactiveInstructionOnDeath");
  var_0 endon("executing");
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

endinstructiononnotification(var_0, var_1) {
  var_1 endon("removed");
  if(isarray(var_0)) {
    var_2 = scripts\engine\utility::waittill_any_in_array_return(var_0);
  } else {
    self waittill(var_0);
  }

  if(!isDefined(self)) {
    return;
  }

  for(var_3 = 0; var_3 < self.lightbarstructs.size; var_3++) {
    if(var_1 == self.lightbarstructs[var_3]) {
      if(var_1.executing) {
        set_lightbar_off();
      }

      self.lightbarstructs[var_3] = undefined;
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

set_lightbar_color(var_0) {
  self setclientomnvar("lb_color", var_0);
}

set_lightbar_on() {
  self setclientomnvar("lb_gsc_controlled", 1);
}

set_lightbar_off() {
  self setclientomnvar("lb_gsc_controlled", 0);
}

set_lightbar_pulse_time(var_0) {
  self setclientomnvar("lb_pulse_time", var_0);
}