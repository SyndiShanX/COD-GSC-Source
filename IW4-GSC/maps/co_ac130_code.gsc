/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\co_ac130_code.gsc
********************************************************/

#include maps\_utility;

precacheLevelStuff() {
  precachestring(&"AC130_HINT_CYCLE_WEAPONS");

  precachestring(&"AC130_DO_NOT_ENGAGE");

  precachestring(&"AC130_CHURCH_DAMAGED");

  precachestring(&"AC130_ESCAPEVEHICLE_DESTROYED");

  precachestring(&"AC130_HUD_TOP_BAR");

  precachestring(&"AC130_HUD_LEFT_BLOCK");

  precachestring(&"AC130_HUD_RIGHT_BLOCK");

  precachestring(&"AC130_HUD_BOTTOM_BLOCK");

  precachestring(&"AC130_HUD_THERMAL_WHOT");

  precachestring(&"AC130_HUD_THERMAL_BHOT");

  precachestring(&"AC130_HUD_WEAPON_105MM");

  precachestring(&"AC130_HUD_WEAPON_40MM");

  precachestring(&"AC130_HUD_WEAPON_25MM");

  precachestring(&"AC130_HUD_AGL");

  precachestring(&"AC130_DEBUG_FRIENDLY_COUNT");

  precachestring(&"AC130_FRIENDLIES_DEAD");

  precachestring(&"AC130_FRIENDLY_FIRE");

  precachestring(&"AC130_FRIENDLY_FIRE_HELICOPTER");

  precachestring(&"AC130_CIVILIAN_FIRE");

  precachestring(&"AC130_CIVILIAN_FIRE_VEHICLE");

  precachestring(&"AC130_OBJECTIVE_SUPPORT_FRIENDLIES");

  precachestring(&"AC130_INTROSCREEN_LINE_1");

  precachestring(&"AC130_INTROSCREEN_LINE_2");

  precachestring(&"AC130_INTROSCREEN_LINE_3");

  precachestring(&"AC130_INTROSCREEN_LINE_4");

  precachestring(&"AC130_INTROSCREEN_LINE_5");

  precachestring(&"SCRIPT_PLATFORM_AC130_HINT_ZOOM_AND_FIRE");

  precachestring(&"SCRIPT_PLATFORM_AC130_HINT_TOGGLE_THERMAL");

  precachestring(&"CO_AC130_OBJECTIVE_COOP_AC130_GUNNER");

  precachestring(&"CO_AC130_OBJECTIVE_COOP_GROUND_PLAYER");

  precacheShader("popmenu_bg");

  precacheModel("tag_laser");
}

vehicleScripts() {
  maps\_mi17::main("vehicle_mi17_woodland_fly_cheap");
}

laser_targeting_device(player) {
  player endon("remove_laser_targeting_device");

  player.lastUsedWeapon = undefined;
  player.laserForceOn = false;
  player setWeaponHudIconOverride("actionslot4", "dpad_laser_designator");

  player notifyOnPlayerCommand("use_laser", "+actionslot 4");
  player notifyOnPlayerCommand("fired_laser", "+attack");

  for(;;) {
    player waittill("use_laser");

    player ent_flag_set("player_used_laser");

    if(player.laserForceOn) {
      player notify("cancel_laser");
      player laserForceOff();

      player.laserForceOn = false;
    } else {
      player laserForceOn();

      player.laserForceOn = true;
    }

    wait 0.05;
  }
}

update_laser() {
  self endon("laser_off");
  while(1) {
    self.fake_laser.origin = self getEye();
    self.fake_laser.angles = self getplayerangles();
    wait 0.05;
  }
}

giveBackWeapon() {
  if((isDefined(self.lastUsedWeapon)) && (self HasWeapon(self.lastUsedWeapon))) {
    self switchToWeapon(self.lastUsedWeapon);
  } else {
    weaponList = self GetWeaponsListPrimaries();
    if(isDefined(weaponList[0])) {
      self switchToWeapon(weaponList[0]);
    }
  }
}