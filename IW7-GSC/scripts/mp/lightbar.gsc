/***********************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\lightbar.gsc
***********************************/

init() {}

func_1768(param_00, param_01, param_02, param_03, param_04, param_05) {
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(param_04 == 0) {
    param_04 = undefined;
  }

  if(!isDefined(self.lightbarstructs) || self.lightbarstructs.size == 0) {
    var_06 = [];
    var_06[0] = spawnStruct();
    self.lightbarstructs = var_06;
  } else {
    var_07 = scripts\mp\utility::cleanarray(self.lightbarstructs);
    self.lightbarstructs = var_07;
    self.lightbarstructs[self.lightbarstructs.size] = spawnStruct();
  }

  self.lightbarstructs[self.lightbarstructs.size - 1].lbcolor = param_00;
  self.lightbarstructs[self.lightbarstructs.size - 1].pulsetime = param_01;
  self.lightbarstructs[self.lightbarstructs.size - 1].priority = param_02;
  self.lightbarstructs[self.lightbarstructs.size - 1].endondeath = param_03;
  self.lightbarstructs[self.lightbarstructs.size - 1].timeplacedinstack = gettime();
  self.lightbarstructs[self.lightbarstructs.size - 1].executing = 0;
  self.lightbarstructs[self.lightbarstructs.size - 1].var_636F = param_05;
  if(isDefined(param_04)) {
    self.lightbarstructs[self.lightbarstructs.size - 1].time = param_04 * 1000;
  } else {
    self.lightbarstructs[self.lightbarstructs.size - 1].time = undefined;
  }

  if(isDefined(param_03) && param_03) {
    thread endinactiveinstructionondeath(self.lightbarstructs[self.lightbarstructs.size - 1]);
  }

  if(isDefined(param_05)) {
    thread endinstructiononnotification(param_05, self.lightbarstructs[self.lightbarstructs.size - 1]);
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
      var_00 = removetimedoutinstructions(self.lightbarstructs);
      var_01 = scripts\engine\utility::array_sort_with_func(var_00, ::is_higher_priority);
    } else {
      var_01 = self.lightbarstructs;
    }

    if(var_01.size == 0) {
      return;
    }

    self.lightbarstructs = var_01;
    var_02 = var_01[0];
    if(var_02.executing) {
      continue;
    }

    var_03 = !isDefined(self.lightbarstructs[self.lightbarstructs.size - 1].time);
    var_04 = 0;
    if(!var_03) {
      var_05 = gettime() - var_02.timeplacedinstack;
      var_04 = var_02.time - var_05;
      var_04 = var_04 / 1000;
      if(var_04 <= 0) {
        self.lightbarstructs[0] notify("removed");
        self.lightbarstructs[0] = undefined;
        cleanlbarray();
        managelightbarstack();
      }
    }

    if(var_03) {
      if(var_02.endondeath) {
        var_02 notify("executing");
        var_02.executing = 1;
        thread set_lightbar_perm_endon_death(var_02.lbcolor, var_02.pulsetime);
      } else {
        thread set_lightbar_perm(var_02.lbcolor, var_02.pulsetime);
      }

      continue;
    }

    if(var_02.endondeath) {
      var_02 notify("executing");
      var_02.executing = 1;
      thread set_lightbar_for_time_endon_death(var_02.lbcolor, var_02.pulsetime, var_04);
      continue;
    }

    thread set_lightbar_for_time(var_02.lbcolor, var_02.pulsetime, var_04);
  }
}

cleanlbarray() {
  var_00 = scripts\mp\utility::cleanarray(self.lightbarstructs);
  self.lightbarstructs = var_00;
}

removetimedoutinstructions(param_00) {
  var_01 = [];
  foreach(var_03 in param_00) {
    if(!isDefined(var_03.time)) {
      var_01[var_01.size] = var_03;
      continue;
    }

    var_04 = gettime() - var_03.timeplacedinstack;
    var_05 = var_03.time - var_04;
    var_05 = var_05 / 1000;
    if(var_05 > 0) {
      var_01[var_01.size] = var_03;
    }
  }

  return var_01;
}

is_higher_priority(param_00, param_01) {
  return param_00.priority > param_01.priority;
}

set_lightbar(param_00, param_01) {
  set_lightbar_pulse_time(param_01);
  set_lightbar_color(param_00);
  set_lightbar_on();
}

set_lightbar_for_time(param_00, param_01, param_02) {
  self notify("set_lightbar_for_time");
  self endon("set_lightbar_for_time");
  set_lightbar_pulse_time(param_01);
  set_lightbar_color(param_00);
  set_lightbar_on();
  wait(param_02);
  if(!isDefined(self)) {
    return;
  }

  set_lightbar_off();
  self.lightbarstructs = undefined;
  cleanlbarray();
}

set_lightbar_perm(param_00, param_01) {
  self notify("set_lightbar");
  self endon("set_lightbar");
  set_lightbar_pulse_time(param_01);
  set_lightbar_color(param_00);
  set_lightbar_on();
}

set_lightbar_endon_death(param_00, param_01) {
  set_lightbar_pulse_time(param_01);
  set_lightbar_color(param_00);
  set_lightbar_on();
  thread turn_off_light_bar_on_death();
}

set_lightbar_for_time_endon_death(param_00, param_01, param_02) {
  self notify("set_lightbar_for_time_endon_death");
  self endon("set_lightbar_for_time_endon_death");
  set_lightbar_pulse_time(param_01);
  set_lightbar_color(param_00);
  set_lightbar_on();
  thread turn_off_light_bar_on_death();
  wait(param_02);
  if(!isDefined(self)) {
    return;
  }

  set_lightbar_off();
  self.lightbarstructs[0] notify("removed");
  self.lightbarstructs[0] = undefined;
  cleanlbarray();
}

set_lightbar_perm_endon_death(param_00, param_01) {
  self notify("set_lightbar_endon_death");
  self endon("set_lightbar_endon_death");
  set_lightbar_pulse_time(param_01);
  set_lightbar_color(param_00);
  set_lightbar_on();
  thread turn_off_light_bar_on_death();
}

endinactiveinstructionondeath(param_00) {
  self notify("endInactiveInstructionOnDeath");
  self endon("endInactiveInstructionOnDeath");
  param_00 endon("executing");
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

endinstructiononnotification(param_00, param_01) {
  param_01 endon("removed");
  if(isarray(param_00)) {
    var_02 = scripts\engine\utility::waittill_any_in_array_return(param_00);
  } else {
    self waittill(param_00);
  }

  if(!isDefined(self)) {
    return;
  }

  for(var_03 = 0; var_03 < self.lightbarstructs.size; var_03++) {
    if(param_01 == self.lightbarstructs[var_03]) {
      if(param_01.executing) {
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

set_lightbar_color(param_00) {
  self setclientomnvar("lb_color", param_00);
}

set_lightbar_on() {
  self setclientomnvar("lb_gsc_controlled", 1);
}

set_lightbar_off() {
  self setclientomnvar("lb_gsc_controlled", 0);
}

set_lightbar_pulse_time(param_00) {
  self setclientomnvar("lb_pulse_time", param_00);
}