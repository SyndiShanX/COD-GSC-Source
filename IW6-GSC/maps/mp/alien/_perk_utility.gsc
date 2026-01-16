/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_perk_utility.gsc
*******************************************/

#include maps\mp\alien\_perkfunctions;

init_each_perk() {
  self.perk_data = [];

  self.perk_data["health"] = init_perk_health();
  self.perk_data["damagemod"] = init_perk_bullet_damage();
  self.perk_data["medic"] = init_perk_medic();
  self.perk_data["rigger"] = init_perk_rigger();
  self.perk_data["pistol"] = init_perk_pistol();
  self.perk_data["none"] = init_perk_none();
}

perk_GetMeleeScalar() {
  return self.perk_data["health"].melee_scalar;
}
perk_GetMaxHealth() {
  return self.perk_data["health"].max_health;
}

perk_GetBulletDamageScalar() {
  return self.perk_data["damagemod"].bullet_damage_scalar;
}

perk_GetReviveTimeScalar() {
  return self.perk_data["medic"].revive_time_scalar;
}
perk_GetGasDamageScalar() {
  return self.perk_data["medic"].gas_damage_scalar;
}
perk_GetMoveSpeedScalar() {
  return self.perk_data["medic"].move_speed_scalar;
}
perk_GetReviveDamageScalar() {
  return self.perk_data["medic"].revive_damage_scalar;
}

perk_GetDrillHealthScalar() {
  return self.perk_data["rigger"].drill_health_scalar;
}
perk_GetDrillTimeScalar() {
  return self.perk_data["rigger"].drill_time_scalar;
}
perk_GetTrapCostScalar() {
  return self.perk_data["rigger"].trap_cost_scalar;
}
perk_GetTrapDamageScalar() {
  return self.perk_data["rigger"].trap_damage_scalar;
}
perk_GetTrapDurationScalar() {
  return self.perk_data["rigger"].trap_duration_scalar;
}
perk_GetCurrencyScalePerHive() {
  return self.perk_data["rigger"].currency_scale_per_hive;
}
perk_GetExplosiveDamageScalar() {
  return self.perk_data["rigger"].explosive_damage_scalar;
}
perk_GetRepairDamageScalar() {
  return self.perk_data["rigger"].repair_damage_scalar;
}

perk_GetPistolRegen() {
  return self.perk_data["pistol"].pistol_regen;
}
perk_GetPistolOverkill() {
  return self.perk_data["pistol"].pistol_overkill;
}

has_perk(perk_name, perk_level_list) {
  AssertEx(is_valid_perk(perk_name), perk_name + " is not a valid perk.");

  selected_perk_0 = maps\mp\alien\_persistence::get_selected_perk_0();
  perk_0_level = maps\mp\alien\_persistence::get_perk_0_level();

  selected_perk_1 = maps\mp\alien\_persistence::get_selected_perk_1();
  perk_1_level = maps\mp\alien\_persistence::get_perk_1_level();

  selected_perk_0_secondary = "perk_none";
  if(self maps\mp\alien\_persistence::is_upgrade_enabled("multi_class")) {
    selected_perk_0_secondary = maps\mp\alien\_persistence::get_selected_perk_0_secondary();
  }

  if(!isDefined(perk_level_list)) {
    return (perk_name == selected_perk_0 || perk_name == selected_perk_1 || perk_name == selected_perk_0_secondary);
  } else {
    is_selected_perk_0_at_level = (perk_name == selected_perk_0 && common_scripts\utility::array_contains(perk_level_list, perk_0_level));
    is_selected_perk_1_at_level = (perk_name == selected_perk_1 && common_scripts\utility::array_contains(perk_level_list, perk_1_level));
    is_selected_perk_0_secondary_at_level = (perk_name == selected_perk_0_secondary && common_scripts\utility::array_contains(perk_level_list, perk_0_level));
    return (is_selected_perk_0_at_level || is_selected_perk_1_at_level || is_selected_perk_0_secondary_at_level);
  }
}

is_valid_perk(perk_name) {
  perk_0_list = GetArrayKeys(level.alien_perks["perk_0"]);

  if(common_scripts\utility::array_contains(perk_0_list, perk_name))
    return true;

  perk_1_list = GetArrayKeys(level.alien_perks["perk_1"]);
  return common_scripts\utility::array_contains(perk_1_list, perk_name);
}