/***************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\intelligence.gsc
***************************************/

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
  foreach(var_01 in level.var_9953) {
    if(!isDefined(var_01.var_E0E2)) {
      var_01 func_E041();
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
  foreach(var_01 in level.var_9953) {
    var_02 = var_01.origin;
    var_01.var_C1D5 = func_7B42(var_02);
  }
}

func_995C() {
  foreach(var_01 in level.var_9953) {
    if(var_01 func_3DAD()) {
      var_01 func_E041();
      continue;
    }

    var_01 thread func_135F5();
    var_01 thread poll_for_found();
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
  foreach(var_01 in level.players) {
    if(!var_01 _meth_8153(self.var_C1D5)) {
      return 0;
    }
  }

  return 1;
}

func_48A0() {
  var_00 = getEntArray("intelligence_item", "targetname");
  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    var_00[var_01].randomintrange = getent(var_00[var_01].target, "targetname");
    var_00[var_01].found = 0;
  }

  return var_00;
}

func_48A1() {
  var_00 = 20;
  var_01 = [];
  for(var_02 = 1; var_02 <= var_00; var_02++) {
    var_03 = tablelookup("sp\intel_items.csv", 0, var_02, 4);
    if(isDefined(var_03) && var_03 != "undefined") {
      var_04 = strtok(var_03, ",");
      for(var_05 = 0; var_05 < var_04.size; var_05++) {
        var_04[var_05] = int(var_04[var_05]);
      }

      var_01[var_02] = (var_04[0], var_04[1], var_04[2]);
      continue;
    }

    var_01[var_02] = undefined;
  }

  return var_01;
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
    self waittill("trigger", var_00);
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
  var_00 = 30;
  var_01 = 8;
  for(var_02 = 0; var_02 < var_00; var_02++) {
    setdvar("ui_securing_progress", getdvarfloat("ui_securing_progress") + 1 / var_00);
    scripts\engine\utility::waitframe();
  }
}

func_9961(param_00, param_01) {
  self endon("stopped_pressing");
  var_02 = 30;
  var_03 = 10;
  var_04 = 0;
  for(var_05 = 0; var_05 < var_02; var_05++) {
    if(var_04 > var_03) {
      var_04 = 0;
    }

    if(var_04 < var_03 / 2) {
      param_00 settext(&"SCRIPT_INTELLIGENCE_UPLOADING");
    } else {
      param_00 settext("");
    }

    param_01.label = int(var_05 / var_02 * 100);
    param_01 settext(&"SCRIPT_INTELLIGENCE_PERCENT");
    var_04++;
    scripts\engine\utility::waitframe();
  }

  param_00 settext(&"SCRIPT_INTELLIGENCE_UPLOADING");
  param_01.label = "100";
  param_01 settext(&"SCRIPT_INTELLIGENCE_PERCENT");
}

func_EB60() {
  foreach(var_01 in level.players) {
    if(var_01 _meth_8153(self.var_C1D5)) {
      continue;
    }

    var_01 _meth_8324(self.var_C1D5);
  }

  logstring("found intel item " + self.var_C1D5);
  scripts\sp\endmission::func_12F24();
}

setplayerangles() {
  var_00 = self _meth_8139("cheatPoints");
  self _meth_8302("cheatPoints", var_00 + 1);
}

func_9952(param_00) {
  self.randomintrange hide();
  self.randomintrange notsolid();
  playworldsound("intelligence_pickup", self.randomintrange.origin);
  var_01 = 3000;
  var_02 = 700;
  var_03 = var_01 + var_02 / 1000;
  foreach(var_05 in level.players) {
    if(param_00 != var_05 && var_05 _meth_8153(self.var_C1D5)) {
      continue;
    }

    var_06 = var_05 scripts\sp\hud_util::func_4999("objective", 1.5);
    var_06.objective_delete = (0.7, 0.7, 0.3);
    var_06.objective_current_nomessage = 1;
    var_06 func_F99F();
    var_06.y = -50;
    var_06 setpulsefx(60, var_01, var_02);
    var_07 = 0;
    if(param_00 == var_05 && var_05 _meth_8153(self.var_C1D5)) {
      var_06.label = &"SCRIPT_RORKEFILE_PREV_FOUND";
    } else {
      var_06.label = &"SCRIPT_INTELLIGENCE_OF_EIGHTEEN";
      var_05 setplayerangles();
      var_07 = var_05 _meth_8139("cheatPoints");
      var_06 setvalue(var_07);
    }

    if(var_07 == 18) {
      var_05 scripts\sp\utility::func_D0A1("EXT_1");
    }

    var_06 scripts\engine\utility::delaycall(var_03, ::destroy);
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
  var_00 = [];
  for(var_01 = 1; var_01 < 65; var_01++) {
    var_02 = tablelookup("sp\intel_items.csv", 0, var_01, 4);
    var_03 = strtok(var_02, ",");
    for(var_01 = 0; var_01 < var_03.size; var_01++) {
      var_03[var_01] = int(var_03[var_01]);
    }

    var_00[var_01] = (var_03[0], var_03[1], var_03[2]);
  }

  for(var_01 = 0; var_01 < var_00.size; var_01++) {
    if(!isDefined(var_00[var_01])) {
      continue;
    }

    if(var_00[var_01] == "undefined") {
      continue;
    }

    for(var_04 = 0; var_04 < var_00.size; var_04++) {
      if(!isDefined(var_00[var_04])) {} else if(var_00[var_04] == "undefined") {} else if(var_01 == var_04) {} else if(var_00[var_01] == var_00[var_04]) {}
    }
  }
}

func_7B42(param_00) {
  for(var_01 = 1; var_01 < level.var_113C7.size + 1; var_01++) {
    if(!isDefined(level.var_113C7[var_01])) {
      continue;
    }

    if(distancesquared(param_00, level.var_113C7[var_01]) < squared(75)) {
      return var_01;
    }
  }
}