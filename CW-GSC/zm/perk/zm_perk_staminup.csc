/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_staminup.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\zm_perks;
#namespace zm_perk_staminup;

function private autoexec __init__system__() {
  system::register(#"zm_perk_staminup", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  enable_staminup_perk_for_level();
}

function enable_staminup_perk_for_level() {
  zm_perks::register_perk_clientfields(#"talent_staminup", &staminup_client_field_func, &staminup_callback_func);
  zm_perks::register_perk_effects(#"talent_staminup", "marathon_light");
  zm_perks::register_perk_init_thread(#"talent_staminup", &init_staminup);
  zm_perks::function_f3c80d73("zombie_perk_bottle_marathon");
}

function init_staminup() {
  if(is_true(level.enable_magic)) {
    level._effect[# "marathon_light"] = "zombie/fx_perk_staminup_ndu";
  }
}

function staminup_client_field_func() {}

function staminup_callback_func() {}