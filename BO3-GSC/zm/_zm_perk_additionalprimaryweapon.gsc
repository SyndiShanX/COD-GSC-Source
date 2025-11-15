/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_perk_additionalprimaryweapon.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_pers_upgrades;
#using scripts\zm\_zm_pers_upgrades_functions;
#using scripts\zm\_zm_pers_upgrades_system;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace zm_perk_additionalprimaryweapon;

function autoexec __init__sytem__() {
  system::register("zm_perk_additionalprimaryweapon", & __init__, undefined, undefined);
}

function __init__() {
  level.additionalprimaryweapon_limit = 3;
  enable_additional_primary_weapon_perk_for_level();
  callback::on_laststand( & on_laststand);
  level.return_additionalprimaryweapon = & return_additionalprimaryweapon;
}

function enable_additional_primary_weapon_perk_for_level() {
  zm_perks::register_perk_basic_info("specialty_additionalprimaryweapon", "additionalprimaryweapon", 4000, & "ZOMBIE_PERK_ADDITIONALPRIMARYWEAPON", getweapon("zombie_perk_bottle_additionalprimaryweapon"));
  zm_perks::register_perk_precache_func("specialty_additionalprimaryweapon", & additional_primary_weapon_precache);
  zm_perks::register_perk_clientfields("specialty_additionalprimaryweapon", & additional_primary_weapon_register_clientfield, & additional_primary_weapon_set_clientfield);
  zm_perks::register_perk_machine("specialty_additionalprimaryweapon", & additional_primary_weapon_perk_machine_setup);
  zm_perks::register_perk_threads("specialty_additionalprimaryweapon", & give_additional_primary_weapon_perk, & take_additional_primary_weapon_perk);
  zm_perks::register_perk_host_migration_params("specialty_additionalprimaryweapon", "vending_additionalprimaryweapon", "additionalprimaryweapon_light");
}

function additional_primary_weapon_precache() {
  if(isDefined(level.additional_primary_weapon_precache_override_func)) {
    [[level.additional_primary_weapon_precache_override_func]]();
    return;
  }
  level._effect["additionalprimaryweapon_light"] = "zombie/fx_perk_mule_kick_zmb";
  level.machine_assets["specialty_additionalprimaryweapon"] = spawnStruct();
  level.machine_assets["specialty_additionalprimaryweapon"].weapon = getweapon("zombie_perk_bottle_additionalprimaryweapon");
  level.machine_assets["specialty_additionalprimaryweapon"].off_model = "p7_zm_vending_three_gun";
  level.machine_assets["specialty_additionalprimaryweapon"].on_model = "p7_zm_vending_three_gun";
}

function additional_primary_weapon_register_clientfield() {
  clientfield::register("clientuimodel", "hudItems.perks.additional_primary_weapon", 1, 2, "int");
}

function additional_primary_weapon_set_clientfield(state) {
  self clientfield::set_player_uimodel("hudItems.perks.additional_primary_weapon", state);
}

function additional_primary_weapon_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision) {
  use_trigger.script_sound = "mus_perks_mulekick_jingle";
  use_trigger.script_string = "tap_perk";
  use_trigger.script_label = "mus_perks_mulekick_sting";
  use_trigger.target = "vending_additionalprimaryweapon";
  perk_machine.script_string = "tap_perk";
  perk_machine.targetname = "vending_additionalprimaryweapon";
  if(isDefined(bump_trigger)) {
    bump_trigger.script_string = "tap_perk";
  }
}

function give_additional_primary_weapon_perk() {}

function take_additional_primary_weapon_perk(b_pause, str_perk, str_result) {
  if(b_pause || str_result == str_perk) {
    self take_additionalprimaryweapon();
  }
}

function take_additionalprimaryweapon() {
  weapon_to_take = level.weaponnone;
  if(isDefined(self._retain_perks) && self._retain_perks || (isDefined(self._retain_perks_array) && (isDefined(self._retain_perks_array["specialty_additionalprimaryweapon"]) && self._retain_perks_array["specialty_additionalprimaryweapon"]))) {
    return weapon_to_take;
  }
  primary_weapons_that_can_be_taken = [];
  primaryweapons = self getweaponslistprimaries();
  for(i = 0; i < primaryweapons.size; i++) {
    if(zm_weapons::is_weapon_included(primaryweapons[i]) || zm_weapons::is_weapon_upgraded(primaryweapons[i])) {
      primary_weapons_that_can_be_taken[primary_weapons_that_can_be_taken.size] = primaryweapons[i];
    }
  }
  self.weapons_taken_by_losing_specialty_additionalprimaryweapon = [];
  pwtcbt = primary_weapons_that_can_be_taken.size;
  while(pwtcbt >= 3) {
    weapon_to_take = primary_weapons_that_can_be_taken[pwtcbt - 1];
    self.weapons_taken_by_losing_specialty_additionalprimaryweapon[weapon_to_take] = zm_weapons::get_player_weapondata(self, weapon_to_take);
    pwtcbt--;
    if(weapon_to_take == self getcurrentweapon()) {
      self switchtoweapon(primary_weapons_that_can_be_taken[0]);
    }
    self takeweapon(weapon_to_take);
  }
  return weapon_to_take;
}

function on_laststand() {
  if(self hasperk("specialty_additionalprimaryweapon")) {
    self.weapon_taken_by_losing_specialty_additionalprimaryweapon = take_additionalprimaryweapon();
  }
}

function return_additionalprimaryweapon(w_returning) {
  if(isDefined(self.weapons_taken_by_losing_specialty_additionalprimaryweapon[w_returning])) {
    self zm_weapons::weapondata_give(self.weapons_taken_by_losing_specialty_additionalprimaryweapon[w_returning]);
  } else {
    self zm_weapons::give_build_kit_weapon(w_returning);
  }
}