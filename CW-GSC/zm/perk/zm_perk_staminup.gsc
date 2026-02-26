/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_staminup.gsc
***********************************************/

#using script_3751b21462a54a7d;
#using script_5f261a5d57de5f7c;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\util;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_utility;
#namespace zm_perk_staminup;

function private autoexec __init__system__() {
  system::register(#"zm_perk_staminup", &preinit, undefined, undefined, #"hash_2d064899850813e2");
}

function private preinit() {
  enable_staminup_perk_for_level();
}

function enable_staminup_perk_for_level() {
  zm_perks::register_perk_basic_info(#"talent_staminup", #"perk_staminup", 2000, #"zombie/perk_marathon", getweapon("zombie_perk_bottle_marathon"), undefined, #"zmperksstaminup");
  zm_perks::register_perk_precache_func(#"talent_staminup", &staminup_precache);
  zm_perks::register_perk_clientfields(#"talent_staminup", &staminup_register_clientfield, &staminup_set_clientfield);
  zm_perks::register_perk_machine(#"talent_staminup", &staminup_perk_machine_setup);
  zm_perks::register_perk_host_migration_params(#"talent_staminup", "vending_marathon", "marathon_light");
  zm_perks::register_perk_damage_override_func(&function_dae4e0ad);
}

function staminup_precache() {
  if(isDefined(level.var_cf57ff63)) {
    [[level.var_cf57ff63]]();
    return;
  }

  level._effect[#"marathon_light"] = "zombie/fx_perk_staminup_ndu";
  level.machine_assets[#"talent_staminup"] = spawnStruct();
  level.machine_assets[#"talent_staminup"].weapon = getweapon("zombie_perk_bottle_marathon");
  level.machine_assets[#"talent_staminup"].off_model = "p9_sur_machine_staminup_off";
  level.machine_assets[#"talent_staminup"].on_model = "p9_sur_machine_staminup";
}

function staminup_register_clientfield() {}

function staminup_set_clientfield(state) {}

function staminup_perk_machine_setup(use_trigger, perk_machine, bump_trigger, collision) {
  perk_machine.script_sound = "mus_perks_stamin_jingle";
  perk_machine.script_string = "marathon_perk";
  perk_machine.script_label = "mus_perks_stamin_sting";
  perk_machine.target = "vending_marathon";
  bump_trigger.script_string = "marathon_perk";
  bump_trigger.targetname = "vending_marathon";

  if(isDefined(collision)) {
    collision.script_string = "marathon_perk";
  }
}

function function_dae4e0ad(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
  if(psoffsettime == "MOD_FALLING") {
    if(namespace_e86ffa8::function_3623f9d1(2)) {
      return 0;
    }
  }

  return undefined;
}