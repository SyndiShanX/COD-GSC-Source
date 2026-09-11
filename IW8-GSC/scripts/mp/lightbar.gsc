/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\lightbar.gsc
***********************************************/

function init() {}

function add_to_lightbar_stack(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(var4 == 0) {
    var4 = undefined;
  }

  if(!isDefined(self.lightbarstructs) || self.lightbarstructs.size == 0) {
    var6 = [];
    GscBinSkip0(0x2e, 0, spawnStruct());
  }

  var7 = scripts\engine\utility::array_removeundefined(self.lightbarstructs);
  self.lightbarstructs = var7;
  self.lightbarstructs[self.lightbarstructs.size] = spawnStruct();
  self.lightbarstructs[self.lightbarstructs.size - 1].lbcolor = var1;
  self.lightbarstructs[self.lightbarstructs.size - 1].pulsetime = var2;
  self.lightbarstructs[self.lightbarstructs.size - 1].priority = var3;
  self.lightbarstructs[self.lightbarstructs.size - 1].endondeath = var4;
  self.lightbarstructs[self.lightbarstructs.size - 1].timeplacedinstack = gettime();
  self.lightbarstructs[self.lightbarstructs.size - 1].executing = 0;
  self.lightbarstructs[self.lightbarstructs.size - 1].endonnotification = var6;

  if(isDefined(var5)) {
    self.lightbarstructs[self.lightbarstructs.size - 1].time = var5 * 1000;
  } else {
    self.lightbarstructs[self.lightbarstructs.size - 1].time = undefined;
  }

  if(isDefined(var4) && var4) {
    thread endinactiveinstructionondeath(self.lightbarstructs[self.lightbarstructs.size - 1]);
  }

  if(isDefined(var6)) {
    thread endinstructiononnotification(var6, self.lightbarstructs[self.lightbarstructs.size - 1]);
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
      var0 = removetimedoutinstructions(self.lightbarstructs);
      var1 = scripts\engine\utility::array_sort_with_func(var0, &is_higher_priority);
    } else {
      var1 = self.lightbarstructs;
    }

    if(var1.size == 0) {
      return;
    }

    self.lightbarstructs = var1;
    var2 = var1[0];

    if(var2.executing) {
      continue;
    }

    var3 = !isDefined(self.lightbarstructs[self.lightbarstructs.size - 1].time);
    var4 = 0;

    if(!var3) {
      var5 = gettime() - var2.timeplacedinstack;
      var4 = var2.time - var5;
      var4 /= 1000;

      if(var4 <= 0) {
        self.lightbarstructs[0] notify("removed");
        self.lightbarstructs[0] = undefined;
        cleanlbarray();
        managelightbarstack();
      }
    }

    if(var3) {
      if(var2.endondeath) {
        var2 notify("executing");
        var2.executing = 1;
        thread set_lightbar_perm_endon_death(var2.lbcolor, var2.pulsetime);
      } else {
        thread set_lightbar_perm(var2.lbcolor, var2.pulsetime);
      }

      continue;
    }

    if(var2.endondeath) {
      var2 notify("executing");
      var2.executing = 1;
      thread set_lightbar_for_time_endon_death(var2.lbcolor, var2.pulsetime, var4);
      continue;
    }

    thread set_lightbar_for_time(var2.lbcolor, var2.pulsetime, var4);
  }
}

function cleanlbarray() {
  var0 = scripts\engine\utility::array_removeundefined(self.lightbarstructs);
  self.lightbarstructs = var0;
}

function removetimedoutinstructions(var0) {
  var1 = [];

  foreach(var3 in var0) {
    if(!isDefined(var3.time)) {
      var1 = var3;
      continue;
    }

    var4 = gettime() - var3.timeplacedinstack;
    var5 = var3.time - var4;
    var5 /= 1000;

    if(var5 > 0) {
      var1 = var3;
    }
  }

  return var1;
}

function is_higher_priority(var0, var1) {
  return var0.priority > var1.priority;
}

function set_lightbar(var0, var1) {
  set_lightbar_pulse_time(var1);
  set_lightbar_color(var0);
  set_lightbar_on();
}

function set_lightbar_for_time(var0, var1, var2) {
  self notify("set_lightbar_for_time");
  self endon("set_lightbar_for_time");
  set_lightbar_pulse_time(var1);
  set_lightbar_color(var0);
  set_lightbar_on();
  wait var2;

  if(!isDefined(self)) {
    return;
  }

  set_lightbar_off();
  self.lightbarstructs = undefined;
  cleanlbarray();
}

function set_lightbar_perm(var0, var1) {
  self notify("set_lightbar");
  self endon("set_lightbar");
  set_lightbar_pulse_time(var1);
  set_lightbar_color(var0);
  set_lightbar_on();
}

function set_lightbar_endon_death(var0, var1) {
  set_lightbar_pulse_time(var1);
  set_lightbar_color(var0);
  set_lightbar_on();
  thread turn_off_light_bar_on_death();
}

function set_lightbar_for_time_endon_death(var0, var1, var2) {
  self notify("set_lightbar_for_time_endon_death");
  self endon("set_lightbar_for_time_endon_death");
  set_lightbar_pulse_time(var1);
  set_lightbar_color(var0);
  set_lightbar_on();
  thread turn_off_light_bar_on_death();
  wait var2;

  if(!isDefined(self)) {
    return;
  }

  set_lightbar_off();
  self.lightbarstructs[0] notify("removed");
  self.lightbarstructs[0] = undefined;
  cleanlbarray();
}

function set_lightbar_perm_endon_death(var0, var1) {
  self notify("set_lightbar_endon_death");
  self endon("set_lightbar_endon_death");
  set_lightbar_pulse_time(var1);
  set_lightbar_color(var0);
  set_lightbar_on();
  thread turn_off_light_bar_on_death();
}

function endinactiveinstructionondeath(var0) {
  self notify("endInactiveInstructionOnDeath");
  self endon("endInactiveInstructionOnDeath");
  var0 endon("executing");
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

function endinstructiononnotification(var0, var1) {
  var1 endon("removed");

  if(isarray(var0)) {
    var2 = scripts\engine\utility::waittill_any_in_array_return(var0);
  } else {
    self waittill(var0);
  }

  if(!isDefined(self)) {
    return;
  }

  for(var3 = 0; var3 < self.lightbarstructs.size; var3++) {
    if(var1 == self.lightbarstructs[var3]) {
      if(var1.executing) {
        set_lightbar_off();
      }

      self.lightbarstructs[var3] = undefined;
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

function set_lightbar_color(var0) {
  self setclientomnvar("lb_color", var0);
}

function set_lightbar_on() {
  self setclientomnvar("lb_gsc_controlled", 1);
}

function set_lightbar_off() {
  self setclientomnvar("lb_gsc_controlled", 0);
}

function set_lightbar_pulse_time(var0) {
  self setclientomnvar("lb_pulse_time", var0);
}