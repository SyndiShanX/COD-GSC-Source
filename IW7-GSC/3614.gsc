/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3614.gsc
************************/

func_5374() {
  precacheitem("car_grenade");
  thread func_5375();
}

func_5375() {
  scripts\engine\utility::waitframe();
  var_0 = getEntArray("scriptable", "code_classname");
  foreach(var_2 in var_0) {
    if(issubstr(var_2.model, "veh_")) {
      var_2 thread func_5376();
    }
  }
}

func_5376() {
  self.var_ED = "vehicle";
  for(;;) {
    self waittill("scriptableNotification", var_0, var_1);
    switch (var_0) {
      case "onfire":
      case "flareup":
        thread func_329E();
        break;

      case "vehicle_death":
        self notify("destroyed");
        if(isDefined(self.var_329F)) {
          self.var_329F delete();
        }
        self.var_C528 = undefined;
        break;
    }
  }
}

func_329E() {
  if(isDefined(self.var_329F)) {
    return;
  }

  self endon("destroyed");
  self.var_C528 = 1;
  wait(0.2);
  self.var_329F = magicgrenade("car_grenade", self.origin + (0, 0, 10), self.origin, 9999, 0);
  self.var_329F.var_C182 = 1;
  self.var_329F makeunusable();
}