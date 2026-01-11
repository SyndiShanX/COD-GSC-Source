/***************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\gametypes\assault_system_lifesupport.gsc
***************************************************************/

init() {
  if(!isDefined(level.var_23AB)) {
    level.var_23AB = [];
  }

  var_00 = spawnStruct();
  level.var_23AB["lifesupport"] = var_00;
}

func_FACA(param_00) {
  var_01 = getEntArray(param_00, "targetname");
  if(var_01.size == 0) {
    return;
  }

  foreach(var_03 in var_01) {
    func_AC73(var_03);
  }
}

func_AC73(param_00) {
  var_01 = undefined;
  if(isDefined(param_00.script_noteworthy)) {
    var_01 = getent(param_00.script_noteworthy, "targetname");
  }

  if(!isDefined(var_01)) {
    var_01 = spawn("script_model", param_00.origin);
    var_01 setModel("laptop_toughbook_open_on_iw6");
    var_01.angles = param_00.angles;
  }

  var_01.health = 99999;
  param_00.visuals = var_01;
  var_02 = scripts\mp\gameobjects::createuseobject("axis", param_00, [var_01], (0, 0, 64));
  var_02.label = "lifesupport_" + param_00.var_336;
  var_02.id = "use";
  var_02 func_113A7(undefined);
  if(isDefined(param_00.target)) {
    var_02.var_1157D = getent(param_00.target, "targetname");
  }

  return var_02;
}

func_113A5(param_00) {}

func_113A6(param_00, param_01, param_02) {}

func_113A7(param_00) {
  func_E27D(param_00);
  func_113AA();
  self notify("stop_trigger_monitor");
}

func_113AB() {
  scripts\mp\gameobjects::allowuse("friendly");
  scripts\mp\gameobjects::setusetime(1);
  scripts\mp\gameobjects::setwaitweaponchangeonuse(1);
  scripts\mp\gameobjects::setusetext(&"MP_BREACH_OPERATE_SYSTEM_ON_ACTION");
  scripts\mp\gameobjects::setusehinttext(&"MP_BREACH_OPERATE_LIFESUPPORT_ON");
  self.onbeginuse = ::func_113A5;
  self.onenduse = ::func_113A6;
  self.onuse = ::func_113A7;
}

func_113A2(param_00) {}

func_113A3(param_00, param_01, param_02) {}

func_113A4(param_00) {
  func_E27D(param_00);
  func_113AB();
  thread func_BA35();
}

func_113AA() {
  scripts\mp\gameobjects::allowuse("enemy");
  scripts\mp\gameobjects::setusetime(2);
  scripts\mp\gameobjects::setwaitweaponchangeonuse(1);
  scripts\mp\gameobjects::setusetext(&"MP_BREACH_OPERATE_SYSTEM_OFF_ACTION");
  scripts\mp\gameobjects::setusehinttext(&"MP_BREACH_OPERATE_LIFESUPPORT_OFF");
  self.onbeginuse = ::func_113A2;
  self.onenduse = ::func_113A3;
  self.onuse = ::func_113A4;
}

func_E27D(param_00) {
  if(isDefined(param_00)) {
    param_00 setclientomnvar("ui_securing_progress", 1);
    param_00 setclientomnvar("ui_securing", 0);
    param_00.ui_securing = undefined;
  }
}

func_BA35() {
  level endon("game_ended");
  self endon("stop_trigger_monitor");
  if(!isDefined(self.var_D41E)) {
    self.var_D41E = [];
  }

  for(;;) {
    self.var_1157D waittill("trigger", var_00);
    var_01 = var_00 getentitynumber();
    if(!isDefined(self.var_D41E[var_01])) {
      self.var_D41E[var_01] = var_00;
      if(isDefined(self.var_C5B5)) {
        [[self.var_C5B5]](self, var_00);
      }

      if(self.var_D41E.size == 1) {
        thread func_12F4E(0.1);
      }
    }
  }
}

func_12F4E(param_00) {
  level endon("game_ended");
  self endon("stop_trigger_monitor");
  for(;;) {
    foreach(var_03, var_02 in self.var_D41E) {
      if(isDefined(var_02) && scripts\mp\utility::isreallyalive(var_02) && var_02 istouching(self.var_1157D)) {
        if(isDefined(self.var_C5B8)) {
          [
            [self.var_C5B8]
          ](self, var_02);
        }

        continue;
      }

      self.var_D41E[var_03] = undefined;
      if(isDefined(var_02)) {
        if(isDefined(self.var_C5B6)) {
          [
            [self.var_C5B6]
          ](self, var_02);
        }
      }
    }

    if(self.var_D41E.size == 0) {
      return;
    } else {
      wait(param_00);
    }
  }
}