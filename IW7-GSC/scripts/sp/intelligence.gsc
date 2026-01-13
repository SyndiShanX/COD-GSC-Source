/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\sp\intelligence.gsc
*********************************************/

main() {
  precachestring(&"SCRIPT_INTELLIGENCE_OF_EIGHTEEN");
  precachestring(&"SCRIPT_RORKEFILE_PREV_FOUND");
  precachestring(&"SCRIPT_RORKEFILE_PICKUP");
  precachestring(&"SCRIPT_INTELLIGENCE_PERCENT");
  precachestring(&"SCRIPT_INTELLIGENCE_UPLOADING");
  level.var_9953 = func_48A0();
  setdvar("ui_level_cheatpoints", level.var_9953.size);
  level.var_9950 = 0;
  setdvar("ui_level_player_cheatpoints", level.var_9950);
  level.var_113C7 = func_48A1();
  func_9858();
  func_995C();
}

func_DFC0() {
  foreach(var_1 in level.var_9953) {
    if(!isDefined(var_1.var_E0E2)) {
      var_1 func_E041();
    }
  }
}

func_E041() {
  self.var_E0E2 = 1;
  self.randomintrange hide();
  self.randomintrange notsolid();
  scripts\engine\utility::trigger_off();
  level.var_9950++;
  setdvar("ui_level_player_cheatpoints", level.var_9950);
  self notify("end_trigger_thread");
}

func_9858() {
  foreach(var_1 in level.var_9953) {
    var_2 = var_1.origin;
    var_1.var_C1D5 = func_7B42(var_2);
  }
}

func_995C() {
  foreach(var_1 in level.var_9953) {
    if(var_1 func_3DAD()) {
      var_1 func_E041();
      continue;
    }

    var_1 thread func_135F5();
    var_1 thread poll_for_found();
  }
}

poll_for_found() {
  self endon("end_loop_thread");
  if(isDefined(self)) {
    if(func_3DAD()) {
      func_E041();
    }
  } else {
    return;
  }

  while(!func_3DAD()) {
    wait(0.05);
  }

  func_E041();
}

func_3DAD() {
  foreach(var_1 in level.players) {
    if(!var_1 func_8153(self.var_C1D5)) {
      return 0;
    }
  }

  return 1;
}

func_48A0() {
  var_0 = getEntArray("intelligence_item", "targetname");
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1].randomintrange = getent(var_0[var_1].target, "targetname");
    var_0[var_1].found = 0;
  }

  return var_0;
}

func_48A1() {
  var_0 = 20;
  var_1 = [];
  for(var_2 = 1; var_2 <= var_0; var_2++) {
    var_3 = tablelookup("sp\intel_items.csv", 0, var_2, 4);
    if(isDefined(var_3) && var_3 != "undefined") {
      var_4 = strtok(var_3, ",");
      for(var_5 = 0; var_5 < var_4.size; var_5++) {
        var_4[var_5] = int(var_4[var_5]);
      }

      var_1[var_2] = (var_4[0], var_4[1], var_4[2]);
      continue;
    }

    var_1[var_2] = undefined;
  }

  return var_1;
}

func_26CA() {
  func_EB60();
  updategamerprofileall();
  waittillframeend;
  func_E041();
}

func_135F5() {
  self endon("end_trigger_thread");
  if(self.classname == "trigger_use") {
    self sethintstring(&"SCRIPT_RORKEFILE_PICKUP");
    self usetriggerrequirelookat(1);
  }

  thread func_12F84();
  self waittill("hold_complete");
  self notify("end_loop_thread");
  func_9952(level.player);
  func_26CA();
}

func_12F84() {
  level.player.var_906B = 0;
  while(level.player.var_906B < 30 && isDefined(self)) {
    level.player.var_906B = 0;
    self stoploopsound("intelligence_pickup_loop");
    self waittill("trigger", var_0);
    self playLoopSound("intelligence_pickup_loop");
    setdvar("ui_securing", "intel");
    setdvar("ui_securing_progress", 0);
    thread func_D9DA();
    func_906C();
  }

  self notify("hold_complete");
  self stoploopsound("intelligence_pickup_loop");
  setdvar("ui_securing_progress", 1);
  setdvar("ui_securing", "");
}

func_906C() {
  self endon("stopped_pressing");
  while(isDefined(self) && isDefined(level.player)) {
    if(level.player usebuttonpressed() && distance(level.player.origin, self.origin) < 128 && isalive(level.player)) {
      level.player.var_906B++;
    } else {
      setdvar("ui_securing", "");
      self stoploopsound("intelligence_pickup_loop");
      self notify("stopped_pressing");
    }

    if(level.player.var_906B >= 30) {
      setdvar("ui_securing", "");
      self notify("stopped_pressing");
      self stoploopsound("intelligence_pickup_loop");
    }

    scripts\engine\utility::waitframe();
  }
}

func_D9DA() {
  self endon("stopped_pressing");
  var_0 = 30;
  var_1 = 8;
  for(var_2 = 0; var_2 < var_0; var_2++) {
    setdvar("ui_securing_progress", getdvarfloat("ui_securing_progress") + 1 / var_0);
    scripts\engine\utility::waitframe();
  }
}

func_9961(var_0, var_1) {
  self endon("stopped_pressing");
  var_2 = 30;
  var_3 = 10;
  var_4 = 0;
  for(var_5 = 0; var_5 < var_2; var_5++) {
    if(var_4 > var_3) {
      var_4 = 0;
    }

    if(var_4 < var_3 / 2) {
      var_0 settext(&"SCRIPT_INTELLIGENCE_UPLOADING");
    } else {
      var_0 settext("");
    }

    var_1.label = int(var_5 / var_2 * 100);
    var_1 settext(&"SCRIPT_INTELLIGENCE_PERCENT");
    var_4++;
    scripts\engine\utility::waitframe();
  }

  var_0 settext(&"SCRIPT_INTELLIGENCE_UPLOADING");
  var_1.label = "100";
  var_1 settext(&"SCRIPT_INTELLIGENCE_PERCENT");
}

func_EB60() {
  foreach(var_1 in level.players) {
    if(var_1 func_8153(self.var_C1D5)) {
      continue;
    }

    var_1 func_8324(self.var_C1D5);
  }

  logstring("found intel item " + self.var_C1D5);
  scripts\sp\endmission::func_12F24();
}

setplayerangles() {
  var_0 = self func_8139("cheatPoints");
  self func_8302("cheatPoints", var_0 + 1);
}

func_9952(var_0) {
  self.randomintrange hide();
  self.randomintrange notsolid();
  playworldsound("intelligence_pickup", self.randomintrange.origin);
  var_1 = 3000;
  var_2 = 700;
  var_3 = var_1 + var_2 / 1000;
  foreach(var_5 in level.players) {
    if(var_0 != var_5 && var_5 func_8153(self.var_C1D5)) {
      continue;
    }

    var_6 = var_5 scripts\sp\hud_util::func_4999("objective", 1.5);
    var_6.objective_delete = (0.7, 0.7, 0.3);
    var_6.objective_current_nomessage = 1;
    var_6 func_F99F();
    var_6.y = -50;
    var_6 setpulsefx(60, var_1, var_2);
    var_7 = 0;
    if(var_0 == var_5 && var_5 func_8153(self.var_C1D5)) {
      var_6.label = &"SCRIPT_RORKEFILE_PREV_FOUND";
    } else {
      var_6.label = &"SCRIPT_INTELLIGENCE_OF_EIGHTEEN";
      var_5 setplayerangles();
      var_7 = var_5 func_8139("cheatPoints");
      var_6 setvalue(var_7);
    }

    if(var_7 == 18) {
      var_5 scripts\sp\utility::func_D0A1("EXT_1");
    }

    var_6 scripts\engine\utility::delaycall(var_3, ::destroy);
  }
}

func_F99F() {
  self.color = (1, 1, 1);
  self.alpha = 1;
  self.x = 0;
  self.alignx = "center";
  self.aligny = "middle";
  self.horzalign = "center";
  self.vertalign = "middle";
  self.foreground = 1;
}

func_23AF() {
  var_0 = [];
  for(var_1 = 1; var_1 < 65; var_1++) {
    var_2 = tablelookup("sp\intel_items.csv", 0, var_1, 4);
    var_3 = strtok(var_2, ",");
    for(var_1 = 0; var_1 < var_3.size; var_1++) {
      var_3[var_1] = int(var_3[var_1]);
    }

    var_0[var_1] = (var_3[0], var_3[1], var_3[2]);
  }

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(!isDefined(var_0[var_1])) {
      continue;
    }

    if(var_0[var_1] == "undefined") {
      continue;
    }

    for(var_4 = 0; var_4 < var_0.size; var_4++) {
      if(!isDefined(var_0[var_4])) {} else if(var_0[var_4] == "undefined") {} else if(var_1 == var_4) {} else if(var_0[var_1] == var_0[var_4]) {}
    }
  }
}

func_7B42(var_0) {
  for(var_1 = 1; var_1 < level.var_113C7.size + 1; var_1++) {
    if(!isDefined(level.var_113C7[var_1])) {
      continue;
    }

    if(distancesquared(var_0, level.var_113C7[var_1]) < squared(75)) {
      return var_1;
    }
  }
}