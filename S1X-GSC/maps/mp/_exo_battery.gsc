/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_exo_battery.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

update_exo_battery_hud(weapon_name) {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("kill_battery");

  if(!IsPlayer(self)) {
    return;
  }

  while(self get_exo_ability_hud_omnvar_value(weapon_name, "ui_exo_battery_toggle") == 1) {
    battery_energy = self BatteryGetCharge(weapon_name);

    self maps\mp\_exo_battery::set_exo_ability_hud_omnvar(weapon_name, "ui_exo_battery_level", battery_energy);

    wait(0.05);
  }
}

set_exo_ability_hud_omnvar(weapon_name, omnvar_name, omnvar_value) {
  if(self GetTacticalWeapon() == weapon_name) {
    self SetClientOmnvar(omnvar_name + "0", omnvar_value);

    if(omnvar_name == "ui_exo_battery_toggle") {
      if(omnvar_value == 1) {
        self SetClientOmnvar("ui_exo_battery_iconA", weapon_name);
      }
    }
  } else if(self GetLethalWeapon() == weapon_name) {
    self SetClientOmnvar(omnvar_name + "1", omnvar_value);

    if(omnvar_name == "ui_exo_battery_toggle") {
      if(omnvar_value == 1) {
        self SetClientOmnvar("ui_exo_battery_iconB", weapon_name);
      }
    }
  } else {
    self SetClientOmnvar("ui_exo_battery_iconA", "reset");
    self SetClientOmnvar("ui_exo_battery_iconB", "reset");
    self SetClientOmnvar("ui_exo_battery_toggle0", 0);
    self SetClientOmnvar("ui_exo_battery_toggle1", 0);
  }
}

get_exo_ability_hud_omnvar_value(weapon_name, omnvar_name) {
  Assert(is_exo_ability_weapon(weapon_name));

  if(self GetTacticalWeapon() == weapon_name) {
    return self GetClientOmnvar(omnvar_name + "0");
  } else if(self GetLethalWeapon() == weapon_name) {
    return self GetClientOmnvar(omnvar_name + "1");
  }
  return -1;
}

play_insufficient_tactical_energy_sfx() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");
  self endon("joined_team");
  self endon("kill_battery");

  self NotifyOnPlayerCommandRemove("tried_left_exo_ability", "+smoke");

  wait(0.05);

  self NotifyOnPlayerCommand("tried_left_exo_ability", "+smoke");

  while(true) {
    self waittill("tried_left_exo_ability");

    weapon_name = self GetTacticalWeapon();

    if(is_exo_ability_weapon(weapon_name)) {
      if(self BatteryGetCharge(weapon_name) < BatteryReqToUse(weapon_name)) {
        self PlayLocalSound("mp_exo_bat_empty");
      }
    }
  }
}

play_insufficient_lethal_energy_sfx() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("death");
  self endon("faux_spawn");
  self endon("joined_team");
  self endon("kill_battery");

  self NotifyOnPlayerCommandRemove("tried_right_exo_ability", "+frag");

  wait(0.05);

  self NotifyOnPlayerCommand("tried_right_exo_ability", "+frag");

  while(true) {
    self waittill("tried_right_exo_ability");

    weapon_name = self GetLethalWeapon();

    if(is_exo_ability_weapon(weapon_name)) {
      if(self BatteryGetCharge(weapon_name) < BatteryReqToUse(weapon_name)) {
        self PlayLocalSound("mp_exo_bat_empty");
      }
    }
  }
}