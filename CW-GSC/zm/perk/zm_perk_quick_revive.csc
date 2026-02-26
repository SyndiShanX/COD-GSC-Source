/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_quick_revive.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\zm_perks;
#namespace zm_perk_quick_revive;

function private autoexec __init__system__() {
  system::register(#"zm_perk_quick_revive", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  enable_quick_revive_perk_for_level();
}

function enable_quick_revive_perk_for_level() {
  zm_perks::register_perk_clientfields(#"talent_quickrevive", &quick_revive_client_field_func, &quick_revive_callback_func);
  zm_perks::register_perk_effects(#"talent_quickrevive", "revive_light");
  zm_perks::register_perk_init_thread(#"talent_quickrevive", &init_quick_revive);
  zm_perks::function_f3c80d73("zombie_perk_bottle_revive");
}

function init_quick_revive() {
  if(is_true(level.enable_magic)) {
    level._effect[#"revive_light"] = "zombie/fx_perk_quickrevive_ndu";
  }
}

function quick_revive_client_field_func() {}

function quick_revive_callback_func() {}