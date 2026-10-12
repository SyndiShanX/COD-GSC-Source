/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\destructibles\destructible_vehicle.gsc
*************************************************************/



#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\utility;
#namespace destructible_vehicle;

function destructible_vehicle_init() {
  precacheitem("car_grenade");
  thread destructible_vehicle_main();
}

function destructible_vehicle_main() {
  waitframe();
  scriptables = getEntArray("scriptable", "code_classname");

  foreach(scriptable in scriptables) {
    if(issubstr(scriptable.model, "veh_") || issubstr(scriptable.model, "veh8_") || issubstr(scriptable.model, "veh9_")) {
      scriptable thread destructible_vehicle_thread();
    }
  }
}

function destructible_vehicle_thread() {
  self.destructible_type = "vehicle";

  while(true) {
    self waittill("scriptableNotification", note, param);

    switch (note) {
      case #"hash_e5776eac05aaee34":
      case #"hash_f292a20224944002":
        thread burningcar_indicator();
        break;
      case #"hash_3b9cb3e6d5ebb052":
      case #"hash_65f8b242ffc4f6e8":
      case #"hash_ac44ea5d34937252":
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