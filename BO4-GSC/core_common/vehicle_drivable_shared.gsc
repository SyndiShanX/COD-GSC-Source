/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\vehicle_drivable_shared.gsc
***************************************************/

#include scripts\core_common\vehicle_shared;

#namespace vehicle;

event_handler[level_init] main(eventstruct) {
  add_main_callback("air_vehicle1", &air_vehicle1_initialize);
}

weapon_switch_watcher(driver) {
  self endon(#"death");
  driver endon(#"death");
  self endon(#"exit_vehicle");

  while(true) {
    if(driver weaponswitchbuttonpressed()) {
      while(driver weaponswitchbuttonpressed()) {
        waitframe(1);
      }

      current_weapon = self seatgetweapon(0);

      if(current_weapon == self.first_weapon) {
        self setweapon(self.second_weapon);
      } else {
        self setweapon(self.first_weapon);
      }
    }

    waitframe(1);
  }
}

air_vehicle1_initialize() {
  self.first_weapon = self seatgetweapon(0);
  self.second_weapon = self seatgetweapon(1);

  while(true) {
    waitresult = self waittill(#"enter_vehicle");
    self thread weapon_switch_watcher(waitresult.player);
  }
}