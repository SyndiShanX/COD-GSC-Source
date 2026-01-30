/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_exo_shield.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\_snd_common_mp;

exo_shield_think() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self endon("joined_team");
  self endon("faux_spawn");
  self endon("exo_shield_taken");
  self notify("exo_shield_think_end");
  self endon("exo_shield_think_end");

  exo_shield_weapon = get_exo_shield_weapon();

  if(!self HasWeapon(exo_shield_weapon)) {
    return;
  }

  self BatterySetDischargeScale(exo_shield_weapon, 1.0);

  reqCharge = BatteryUsePerShot(exo_shield_weapon);
  maxCharge = self BatteryGetSize(exo_shield_weapon);

  if(self GetTacticalWeapon() == exo_shield_weapon) {
    self SetClientOmnvar("ui_exo_battery_level0", maxCharge);
    self SetClientOmnvar("exo_ability_nrg_req0", reqCharge);
    self SetClientOmnvar("exo_ability_nrg_total0", maxCharge);
  } else if(self GetLethalWeapon() == exo_shield_weapon) {
    self SetClientOmnvar("ui_exo_battery_level1", maxCharge);
    self SetClientOmnvar("exo_ability_nrg_req1", reqCharge);
    self SetClientOmnvar("exo_ability_nrg_total1", maxCharge);
  }

  self thread wait_for_player_death(exo_shield_weapon);

  for(;;) {
    self waittillmatch("grenade_pullback", exo_shield_weapon);

    self snd_message("mp_exo_shield_activate");

    self.pers["numberOfTimesShieldUsed"]++;

    self maps\mp\_exo_battery::set_exo_ability_hud_omnvar(exo_shield_weapon, "ui_exo_battery_toggle", 1);
    self.exo_shield_on = true;

    if(!IsAgent(self)) {
      self thread maps\mp\_exo_battery::update_exo_battery_hud(exo_shield_weapon);
    }

    if(self BatteryIsInUse(exo_shield_weapon) == true) {
      self waittillmatch("battery_discharge_end", exo_shield_weapon);
    }

    self snd_message("mp_exo_shield_deactivate");

    self maps\mp\_exo_battery::set_exo_ability_hud_omnvar(exo_shield_weapon, "ui_exo_battery_toggle", 0);
    self.exo_shield_on = false;
  }
}

take_exo_shield() {
  self notify("kill_battery");
  self notify("exo_shield_taken");
  self takeWeapon(get_exo_shield_weapon());
}

give_exo_shield() {
  self giveWeapon(get_exo_shield_weapon());
  self thread exo_shield_think();
}

get_exo_shield_weapon() {
  if(isDefined(level.exoShieldweapon)) {
    return level.exoShieldweapon;
  }

  level.exoShieldweapon = "exoshield_equipment_mp";
  if(isDefined(level.isHorde)) {
    level.exoShieldweapon = "exoshieldhorde_equipment_mp";
  }

  return level.exoShieldweapon;
}

wait_for_player_death(weapon_name) {
  level endon("game_ended");
  self endon("disconnect");

  self waittill_any("death", "joined_team", "faux_spawn", "exo_shield_taken");

  self maps\mp\_exo_battery::set_exo_ability_hud_omnvar(weapon_name, "ui_exo_battery_toggle", 0);
  self.exo_shield_on = false;
}