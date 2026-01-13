/***************************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\gametypes\assault_system_lifesupport.gsc
***************************************************************/

init() {
  if(!isDefined(level.var_23AB)) {
    level.var_23AB = [];
  }

  var_0 = spawnStruct();
  level.var_23AB["lifesupport"] = var_0;
}

func_FACA(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  if(var_1.size == 0) {
    return;
  }

  foreach(var_3 in var_1) {
    func_AC73(var_3);
  }
}

func_AC73(var_0) {
  var_1 = undefined;
  if(isDefined(var_0.script_noteworthy)) {
    var_1 = getent(var_0.script_noteworthy, "targetname");
  }

  if(!isDefined(var_1)) {
    var_1 = spawn("script_model", var_0.origin);
    var_1 setModel("laptop_toughbook_open_on_iw6");
    var_1.angles = var_0.angles;
  }

  var_1.health = 99999;
  var_0.visuals = var_1;
  var_2 = scripts\mp\gameobjects::createuseobject("axis", var_0, [var_1], (0, 0, 64));
  var_2.label = "lifesupport_" + var_0.var_336;
  var_2.id = "use";
  var_2 func_113A7(undefined);
  if(isDefined(var_0.target)) {
    var_2.var_1157D = getent(var_0.target, "targetname");
  }

  return var_2;
}

func_113A5(var_0) {}

func_113A6(var_0, var_1, var_2) {}

func_113A7(var_0) {
  func_E27D(var_0);
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

func_113A2(var_0) {}

func_113A3(var_0, var_1, var_2) {}

func_113A4(var_0) {
  func_E27D(var_0);
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

func_E27D(var_0) {
  if(isDefined(var_0)) {
    var_0 setclientomnvar("ui_securing_progress", 1);
    var_0 setclientomnvar("ui_securing", 0);
    var_0.ui_securing = undefined;
  }
}

func_BA35() {
  level endon("game_ended");
  self endon("stop_trigger_monitor");
  if(!isDefined(self.var_D41E)) {
    self.var_D41E = [];
  }

  for(;;) {
    self.var_1157D waittill("trigger", var_0);
    var_1 = var_0 getentitynumber();
    if(!isDefined(self.var_D41E[var_1])) {
      self.var_D41E[var_1] = var_0;
      if(isDefined(self.var_C5B5)) {
        [[self.var_C5B5]](self, var_0);
      }

      if(self.var_D41E.size == 1) {
        thread func_12F4E(0.1);
      }
    }
  }
}

func_12F4E(var_0) {
  level endon("game_ended");
  self endon("stop_trigger_monitor");
  for(;;) {
    foreach(var_3, var_2 in self.var_D41E) {
      if(isDefined(var_2) && scripts\mp\utility::isreallyalive(var_2) && var_2 istouching(self.var_1157D)) {
        if(isDefined(self.var_C5B8)) {
          [
            [self.var_C5B8]
          ](self, var_2);
        }

        continue;
      }

      self.var_D41E[var_3] = undefined;
      if(isDefined(var_2)) {
        if(isDefined(self.var_C5B6)) {
          [
            [self.var_C5B6]
          ](self, var_2);
        }
      }
    }

    if(self.var_D41E.size == 0) {
      return;
    } else {
      wait(var_0);
    }
  }
}