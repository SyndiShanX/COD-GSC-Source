/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\destructibles\destructible_vehicle.gsc
*****************************************************/

destructible_vehicle_init() {
  precacheitem("car_grenade");
  thread destructible_vehicle_main();
}

destructible_vehicle_main() {
  waitframe();
  var_0 = getEntArray("scriptable", "code_classname");

  foreach(var_2 in var_0) {
    if(issubstr(var_2.model, "veh_") || issubstr(var_2.model, "veh8_"))
      var_2 thread destructible_vehicle_thread();
  }
}

destructible_vehicle_thread() {
  self.destructible_type = "vehicle";

  for(;;) {
    self waittill("scriptableNotification", var_0, var_1);

    switch (var_0) {
      case "flareup":
      case "onfire":
        thread burningcar_indicator();
        break;
      case "vehicle_death":
      case "anim_explosion_complete":
      case "anim_explosion":
        self notify("destroyed");

        if(isDefined(self.burningcarindicator))
          self.burningcarindicator delete();

        self.onfire = undefined;
        return;
    }
  }
}

burningcar_indicator() {
  if(isDefined(self.burningcarindicator)) {
    return;
  }
  self endon("destroyed");
  self.onfire = 1;
  wait 0.2;
  self.burningcarindicator = magicgrenade("car_grenade", self.origin + (0, 0, 10), self.origin, 9999, 0);
  self.burningcarindicator.targetname = "offhand_car_grenade";
  self.burningcarindicator makeunusable();
}