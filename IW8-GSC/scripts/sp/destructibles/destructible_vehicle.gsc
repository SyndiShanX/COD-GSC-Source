/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\destructibles\destructible_vehicle.gsc
*************************************************************/

function destructible_vehicle_init() {
  precacheitem("car_grenade");
  thread destructible_vehicle_main();
}

function destructible_vehicle_main() {
  waitframe();
  var0 = getEntArray("scriptable", "code_classname");

  foreach(var2 in var0) {
    if(issubstr(var2.model, "veh_") || issubstr(var2.model, "veh8_")) {
      thread destructible_vehicle_thread();
    }
  }
}

function destructible_vehicle_thread() {
  self.destructible_type = "vehicle";

  for(;;) {
    self waittill("scriptableNotification", var0, var1);

    switch (var0) {
      case "flareup":
      case "onfire":
        thread burningcar_indicator();
        break;
      case "vehicle_death":
      case "anim_explosion_complete":
      case "anim_explosion":
        self notify("destroyed");

        if(isDefined(self.burningcarindicator)) {
          self.burningcarindicator delete();
        }

        self.onfire = undefined;
        return;
    }
  }
}

function burningcar_indicator() {
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