/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_bandolier.gsc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\zm_common\trials\zm_trial_reset_loadout;
#include scripts\zm_common\zm_perks;

#namespace zm_perk_bandolier;

autoexec __init__system__() {
  system::register(#"zm_perk_bandolier", &__init__, undefined, undefined);
}

__init__() {
  function_27473e44();
}

function_27473e44() {
  zm_perks::register_perk_basic_info(#"specialty_extraammo", #"perk_bandolier", 3000, #"zombie/perk_bandolier", getweapon("zombie_perk_bottle_bandolier"), getweapon("zombie_perk_totem_bandolier"), #"zmperksbandolier");
  zm_perks::register_perk_precache_func(#"specialty_extraammo", &perk_precache);
  zm_perks::register_perk_clientfields(#"specialty_extraammo", &perk_register_clientfield, &perk_set_clientfield);
  zm_perks::register_perk_machine(#"specialty_extraammo", &perk_machine_setup);
  zm_perks::register_perk_host_migration_params(#"specialty_extraammo", "vending_bandolier", "sleight_light");
  zm_perks::register_perk_threads(#"specialty_extraammo", &give_perk, &take_perk);
}

perk_precache() {
  if(isDefined(level.var_51552992)) {
    [[level.var_51552992]]();
    return;
  }

  level.machine_assets[#"specialty_extraammo"] = spawnStruct();
  level.machine_assets[#"specialty_extraammo"].weapon = getweapon("zombie_perk_bottle_bandolier");
  level.machine_assets[#"specialty_extraammo"].off_model = "p7_zm_vending_sleight";
  level.machine_assets[#"specialty_extraammo"].on_model = "p7_zm_vending_sleight";
}

perk_register_clientfield() {}

perk_set_clientfield(state) {}

perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision) {
  use_trigger.script_sound = "mus_perks_speed_jingle";
  use_trigger.script_string = "bandolier_perk";
  use_trigger.script_label = "mus_perks_speed_sting";
  use_trigger.target = "vending_bandolier";
  perk_machine.script_string = "bandolier_perk";
  perk_machine.targetname = "vending_bandolier";

  if(isDefined(bump_trigger)) {
    bump_trigger.script_string = "bandolier_perk";
  }
}

give_perk() {
  self set_ammo();
}

take_perk(b_pause, str_perk, str_result, n_slot) {
  self set_ammo(0);
}

set_ammo(b_max_ammo = 1) {
  a_weapons = self getweaponslistprimaries();

  foreach(weapon in a_weapons) {
    if(weaponhasattachment(weapon, "uber") && weapon.statname == #"smg_capacity_t8") {
      continue;
    }

    if(weapon !== self.laststandpistol) {
      if(b_max_ammo) {
        var_67f27715 = weapon.maxammo - weapon.startammo;
        var_45193587 = self getweaponammostock(weapon);

        if(zm_trial_reset_loadout::is_active(1)) {
          var_88f48290 = 0;
        } else {
          var_88f48290 = var_45193587 + var_67f27715;
        }

        self setweaponammostock(weapon, var_88f48290);
        continue;
      }

      if(self getweaponammostock(weapon) > weapon.startammo) {
        self setweaponammostock(weapon, weapon.startammo);
      }
    }
  }
}