/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_juggernaut.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\zm_perks;
#namespace zm_perk_juggernaut;

function private autoexec __init__system__() {
  system::register(#"zm_perk_juggernaut", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  zm_perks::register_perk_clientfields(#"hash_47d7a8105237c88", &function_2d2b95b0, &function_6c832af6);
  zm_perks::register_perk_effects(#"hash_47d7a8105237c88", "jugger_light");
  zm_perks::register_perk_init_thread(#"hash_47d7a8105237c88", &init_juggernaut);
  zm_perks::function_f3c80d73("zombie_perk_bottle_jugg");
}

function init_juggernaut() {
  if(is_true(level.enable_magic)) {
    level._effect[#"jugger_light"] = "zombie/fx_perk_juggernaut_ndu";
  }
}

function function_2d2b95b0() {}

function function_6c832af6() {}