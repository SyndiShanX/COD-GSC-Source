/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2763.gsc
***************************************/

init() {}

func_1768(var_00, var_01, var_02, var_03, var_04, var_05) {
  if(!isDefined(var_02)) {
    var_02 = 0;
  }

  if(var_04 == 0) {
    var_04 = undefined;
  }

  if(!isDefined(self.lightbarstructs) || self.lightbarstructs.size == 0) {
    var_06 = [];
    var_6[0] = spawnStruct();
    self.lightbarstructs = var_06;
  } else {
    var_07 = scripts\mp\utility\game::cleanarray(self.lightbarstructs);
    self.lightbarstructs = var_07;
    self.lightbarstructs[self.lightbarstructs.size] = spawnStruct();
  }

  self.lightbarstructs[self.lightbarstructs.size - 1].lbcolor = var_00;
  self.lightbarstructs[self.lightbarstructs.size - 1].pulsetime = var_01;
  self.lightbarstructs[self.lightbarstructs.size - 1].priority = var_02;
  self.lightbarstructs[self.lightbarstructs.size - 1].endondeath = var_03;
  self.lightbarstructs[self.lightbarstructs.size - 1].timeplacedinstack = gettime();
  self.lightbarstructs[self.lightbarstructs.size - 1].executing = 0;
  self.lightbarstructs[self.lightbarstructs.size - 1].func_636F = var_05;

  if(isDefined(var_04)) {
    self.lightbarstructs[self.lightbarstructs.size - 1].time = var_04 * 1000;
  }
  else {
    self.lightbarstructs[self.lightbarstructs.size - 1].time = undefined;
  }

  if(isDefined(var_03) && var_03) {
    thread endinactiveinstructionondeath(self.lightbarstructs[self.lightbarstructs.size - 1]);
  }

  if(isDefined(var_05)) {
    thread endinstructiononnotification(var_05, self.lightbarstructs[self.lightbarstructs.size - 1]);
  }

  thread managelightbarstack();
}

managelightbarstack() {
  self notify("manageLightBarStack");
  self endon("manageLightBarStack");
  self endon("disconnect");

  for(;;) {
    wait 0.05;

    if(self.lightbarstructs.size > 1) {
      var_00 = removetimedoutinstructions(self.lightbarstructs);
      var_01 = scripts\engine\utility::array_sort_with_func(var_00, ::is_higher_priority);
    } else
      var_01 = self.lightbarstructs;

    if(var_1.size == 0) {
      return;
    }
    self.lightbarstructs = var_01;
    var_02 = var_1[0];

    if(var_2.executing) {
      continue;
    }
    var_03 = !isDefined(self.lightbarstructs[self.lightbarstructs.size - 1].time);
    var_04 = 0;

    if(!var_03) {
      var_05 = gettime() - var_2.timeplacedinstack;
      var_04 = var_2.time - var_05;
      var_04 = var_04 / 1000;

      if(var_04 <= 0) {
        self.lightbarstructs[0] notify("removed");
        self.lightbarstructs[0] = undefined;
        cleanlbarray();
        managelightbarstack();
      }
    }

    if(var_03) {
      if(var_2.endondeath) {
        var_02 notify("executing");
        var_2.executing = 1;
        thread set_lightbar_perm_endon_death(var_2.lbcolor, var_2.pulsetime);
      } else
        thread set_lightbar_perm(var_2.lbcolor, var_2.pulsetime);

      continue;
    }

    if(var_2.endondeath) {
      var_02 notify("executing");
      var_2.executing = 1;
      thread set_lightbar_for_time_endon_death(var_2.lbcolor, var_2.pulsetime, var_04);
      continue;
    }

    thread set_lightbar_for_time(var_2.lbcolor, var_2.pulsetime, var_04);
  }
}

cleanlbarray() {
  var_00 = scripts\mp\utility\game::cleanarray(self.lightbarstructs);
  self.lightbarstructs = var_00;
}

removetimedoutinstructions(var_00) {
  var_01 = [];

  foreach(var_03 in var_00) {
    if(!isDefined(var_3.time)) {
      var_1[var_1.size] = var_03;
      continue;
    }

    var_04 = gettime() - var_3.timeplacedinstack;
    var_05 = var_3.time - var_04;
    var_05 = var_05 / 1000;

    if(var_05 > 0) {
      var_1[var_1.size] = var_03;
    }
  }

  return var_01;
}

is_higher_priority(var_00, var_01) {
  return var_0.priority > var_1.priority;
}

set_lightbar(var_00, var_01) {
  set_lightbar_pulse_time(var_01);
  set_lightbar_color(var_00);
  set_lightbar_on();
}

set_lightbar_for_time(var_00, var_01, var_02) {
  self notify("set_lightbar_for_time");
  self endon("set_lightbar_for_time");
  set_lightbar_pulse_time(var_01);
  set_lightbar_color(var_00);
  set_lightbar_on();
  wait(var_02);

  if(!isDefined(self)) {
    return;
  }
  set_lightbar_off();
  self.lightbarstructs = undefined;
  cleanlbarray();
}

set_lightbar_perm(var_00, var_01) {
  self notify("set_lightbar");
  self endon("set_lightbar");
  set_lightbar_pulse_time(var_01);
  set_lightbar_color(var_00);
  set_lightbar_on();
}

set_lightbar_endon_death(var_00, var_01) {
  set_lightbar_pulse_time(var_01);
  set_lightbar_color(var_00);
  set_lightbar_on();
  thread turn_off_light_bar_on_death();
}

set_lightbar_for_time_endon_death(var_00, var_01, var_02) {
  self notify("set_lightbar_for_time_endon_death");
  self endon("set_lightbar_for_time_endon_death");
  set_lightbar_pulse_time(var_01);
  set_lightbar_color(var_00);
  set_lightbar_on();
  thread turn_off_light_bar_on_death();
  wait(var_02);

  if(!isDefined(self)) {
    return;
  }
  set_lightbar_off();
  self.lightbarstructs[0] notify("removed");
  self.lightbarstructs[0] = undefined;
  cleanlbarray();
}

set_lightbar_perm_endon_death(var_00, var_01) {
  self notify("set_lightbar_endon_death");
  self endon("set_lightbar_endon_death");
  set_lightbar_pulse_time(var_01);
  set_lightbar_color(var_00);
  set_lightbar_on();
  thread turn_off_light_bar_on_death();
}

endinactiveinstructionondeath(var_00) {
  self notify("endInactiveInstructionOnDeath");
  self endon("endInactiveInstructionOnDeath");
  var_00 endon("executing");
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

endinstructiononnotification(var_00, var_01) {
  var_01 endon("removed");

  if(isarray(var_00)) {
    var_02 = scripts\engine\utility::waittill_any_in_array_return(var_00);
  }
  else {
    self waittill(var_00);
  }

  if(!isDefined(self)) {
    return;
  }
  for(var_03 = 0; var_03 < self.lightbarstructs.size; var_3++) {
    if(var_01 == self.lightbarstructs[var_03]) {
      if(var_1.executing) {
        set_lightbar_off();
      }

      self.lightbarstructs[var_03] = undefined;
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

set_lightbar_color(var_00) {
  self setclientomnvar("lb_color", var_00);
}

set_lightbar_on() {
  self setclientomnvar("lb_gsc_controlled", 1);
}

set_lightbar_off() {
  self setclientomnvar("lb_gsc_controlled", 0);
}

set_lightbar_pulse_time(var_00) {
  self setclientomnvar("lb_pulse_time", var_00);
}