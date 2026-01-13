/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: SP\3652.gsc
************************/

func_952C() {
  level.player scripts\sp\utility::func_65E0("using_arm_device");
  level.player scripts\sp\utility::func_65E1("using_arm_device");
}

func_169B(var_0, var_1, var_2, var_3) {
  var_4 = func_2164(var_0);
  level notify("arm_device_remove_slot_" + var_4);
  self notifyonplayercommand("action_slot_used_" + var_4, "+actionslot " + var_4);
  thread func_2167(var_4, var_1, var_2, var_3);
}

func_2167(var_0, var_1, var_2, var_3) {
  level endon("stop_arm_device");
  level endon("arm_device_remove_slot_" + var_0);
  self endon("death");
  var_4 = 0;
  for(;;) {
    var_5 = scripts\engine\utility::waittill_any_return("action_slot_used_" + var_0, var_3);
    if(isDefined(self.var_55BD) && self.var_55BD > 0) {
      continue;
    }

    if(scripts\sp\utility::func_65DB("using_arm_device") || isDefined(var_3) && var_5 == var_3) {
      if(var_4 == 1 && isDefined(var_2) || isDefined(var_3)) {
        if(isDefined(var_2)) {
          level thread[[var_2]]();
        }

        var_4 = 0;
        continue;
      }

      if(!isDefined(var_3) || var_5 != var_3) {
        level thread[[var_1]]();
        var_4 = 1;
      }
    }
  }
}

func_2163() {
  level notify("stop_arm_device");
}

func_2165() {
  scripts\sp\utility::func_65DD("using_arm_device");
}

func_2168() {
  scripts\sp\utility::func_65E1("using_arm_device");
}

func_2166(var_0) {
  var_1 = func_2164(var_0);
  level notify("arm_device_remove_slot_" + var_1);
}

func_2164(var_0) {
  var_1 = undefined;
  switch (var_0) {
    case "up":
      var_1 = 1;
      break;

    case "down":
      var_1 = 2;
      break;

    case "left":
      var_1 = 3;
      break;

    case "right":
      var_1 = 4;
      break;
  }

  return var_1;
}