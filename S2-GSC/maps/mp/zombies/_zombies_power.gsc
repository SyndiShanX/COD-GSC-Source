/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\_zombies_power.gsc
**********************************************/

func_00D5() {
  level.var_7606 = [];
  level.var_7F21 = [];
  var_00 = common_scripts\utility::func_46B7("power_switch", "targetname");
  common_scripts\utility::func_0FB2(var_00, ::func_7603);
  var_01 = getEntArray("power_show", "targetname");
  common_scripts\utility::func_0FB2(var_01, ::func_75FE);
  var_02 = getEntArray("power_hide", "targetname");
  common_scripts\utility::func_0FB2(var_02, ::func_75FA);
}

func_7603() {
  if(!isDefined(self.var_819A)) {
    func_75F9("Power switch at " + self.var_0116 + " missing use script_flag.");
    return;
  }

  common_scripts\utility::func_3C87(self.var_819A);
  self.var_8BF7 = [];
  self.var_4D07 = [];
  var_00 = getEntArray(self.var_01A2, "targetname");
  foreach(var_02 in var_00) {
    func_7601(var_02);
  }

  self.var_9835 = var_00;
  var_04 = common_scripts\utility::func_46B7(self.var_01A2, "targetname");
  foreach(var_06 in var_04) {
    func_7605(var_06);
  }

  self.target_structs = var_04;
  if(!isDefined(self.var_9D65)) {
    func_75F9("Power switch at " + self.var_0116 + " missing use trigger.");
    return;
  }

  self.var_7602 = level.var_7606.size;
  level.var_7606[level.var_7606.size] = self;
  thread func_7604();
  thread func_7600();
}

func_7601(param_00) {
  var_01 = param_00.var_0165;
  if(!isDefined(var_01)) {
    switch (param_00.var_003A) {
      case "script_model":
        var_01 = "anim_model";
        break;

      case "script_brushmodel":
        var_01 = "button";
        break;

      case "trigger_use":
      case "trigger_use_touch":
        var_01 = "trigger";
        break;

      default:
        var_01 = "undefined";
        break;
    }
  }

  switch (var_01) {
    case "trigger":
      self.var_9D65 = param_00;
      break;

    case "button":
      self.var_1DC7 = param_00;
      break;

    case "anim_model":
      self.var_6298 = param_00;
      if(isDefined(self.var_6298.var_8109)) {
        var_02 = strtok(self.var_6298.var_8109, ",");
        self.var_6298.var_75FB = var_02[0];
        self.var_6298.var_7608 = var_02[1];
        self.var_6298.var_75FC = var_02[2];
        self.var_6298.var_7607 = var_02[3];
      }
      break;

    case "show":
      self.var_8BF7[self.var_8BF7.size] = param_00;
      break;

    case "hide":
      self.var_4D07[self.var_4D07.size] = param_00;
      break;

    default:
      func_75F9("Unknown ent type \'" + var_01 + "\' on entity at " + param_00.var_0116 + ".");
      break;
  }
}

func_7605(param_00) {
  var_01 = param_00.var_0165;
  switch (var_01) {
    case "indicator_light_on_fx":
      self.var_5105 = param_00;
      break;

    case "indicator_light_off_fx":
      self.var_5104 = param_00;
      break;
  }
}

func_7604() {
  var_00 = undefined;
  var_01 = undefined;
  var_02 = undefined;
  for(;;) {
    lib_0378::func_8D74("generator_power_switch_state", "stopped");
    foreach(var_04 in self.var_8BF7) {
      var_04 method_805C();
    }

    foreach(var_04 in self.var_4D07) {
      var_04 method_805B();
    }

    self.var_9D65 setcursorhint("HINT_NOICON");
    self.var_9D65 sethintstring(&"ZOMBIES_POWER_ON");
    if(isDefined(var_00)) {
      var_00 delete();
    }

    if(isDefined(var_02)) {
      var_02 delete();
    }

    if(isDefined(self.var_5104)) {
      var_01 = lib_0547::func_8FBA(self.var_5104, self.var_5104.var_81BB);
      triggerfx(var_01, 0.5);
    }

    if(isDefined(self.var_6298.var_75FB)) {
      self.var_6298 scriptmodelplayanim(self.var_6298.var_75FB);
    }

    for(;;) {
      self.var_9D65 waittill("trigger", var_08);
      if(!isDefined(level.var_7609)) {
        break;
      }
    }

    level.var_400E[level.var_400E.size] = ["survivalist_set 2 -1", "all"];
    var_08 maps\mp\gametypes\zombies::func_47AE("power_on");
    var_08 lib_054E::func_743B();
    level.var_7F21[level.var_7F21.size] = self.var_7602;
    level notify("power_on");
    level.var_75FD = 1;
    self.var_9D65 sethintstring("");
    self notify("on");
    common_scripts\utility::func_3C8F(self.var_819A);
    lib_0378::func_8D74("generator_power_switch_state", "starting");
    if(isDefined(var_01)) {
      var_01 delete();
    }

    if(isDefined(self.var_5105)) {
      var_02 = spawn("script_model", self.var_5105.var_0116);
      var_02.var_001D = self.var_5105.var_001D;
      var_02 setModel("tag_origin");
      if(isDefined(self.var_5105.var_81C7)) {
        var_02 linkto(self.var_6298, self.var_5105.var_81C7);
      }

      var_00 = spawnlinkedfx(common_scripts\utility::func_44F5(self.var_5105.var_81BB), var_02, "tag_origin");
      triggerfx(var_00);
    }

    if(isDefined(self.var_6298.var_7608)) {
      self.var_6298 scriptmodelplayanim(self.var_6298.var_7608, "power_on");
      self.var_6298 waittillmatch("end", "power_on");
    }

    if(isDefined(self.var_6298.var_75FC)) {
      self.var_6298 scriptmodelplayanim(self.var_6298.var_75FC);
    }

    lib_0378::func_8D74("generator_power_switch_state", "running");
    foreach(var_04 in self.var_8BF7) {
      var_04 method_805B();
    }

    foreach(var_04 in self.var_4D07) {
      var_04 method_805C();
    }

    level waittill("zombie_power_penalty_start");
    self notify("off");
    common_scripts\utility::func_3C7B(self.var_819A);
    lib_0378::func_8D74("generator_power_switch_state", "stopping");
    if(isDefined(self.var_6298.var_7607)) {
      self.var_6298 scriptmodelplayanim(self.var_6298.var_7607, "power_on");
      self.var_6298 waittillmatch("end", "power_on");
    }

    foreach(var_04 in self.var_8BF7) {
      var_04 method_805C();
    }

    foreach(var_04 in self.var_4D07) {
      var_04 method_805B();
    }

    level waittill("zombie_power_penalty_end");
  }
}

func_7600() {
  if(!isDefined(self.var_1DC7)) {
    return;
  }

  var_00 = 0.4;
  var_01 = self.var_1DC7.var_0116;
  var_02 = var_01 + (0, 0, 16);
  for(;;) {
    self waittill("on");
    self.var_1DC7 moveto(var_02, var_00);
    self waittill("off");
    self.var_1DC7 moveto(var_01, var_00);
  }
}

func_75FE() {
  self endon("death");
  if(!isDefined(self.var_819A)) {
    func_75F9("Power show entity at " + self.var_0116 + " missing script_flag.");
    return;
  }

  for(;;) {
    self method_805C();
    common_scripts\utility::func_3C9F(self.var_819A);
    self method_805B();
    common_scripts\utility::func_3CA9(self.var_819A);
  }
}

func_75FA() {
  self endon("death");
  if(!isDefined(self.var_819A)) {
    func_75F9("Power hide entity at " + self.var_0116 + " missing script_flag.");
    return;
  }

  for(;;) {
    self method_805B();
    common_scripts\utility::func_3C9F(self.var_819A);
    self method_805C();
    common_scripts\utility::func_3CA9(self.var_819A);
  }
}

func_75F9(param_00) {}

power_switch_find(param_00) {
  foreach(var_02 in level.var_7606) {
    if(lib_0547::func_5565(param_00, var_02.var_819A)) {
      return var_02;
    }
  }
}