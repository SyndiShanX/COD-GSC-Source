/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\perk\zm_perk_sleight_of_hand.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\zm_common\zm_perks;
#namespace zm_perk_sleight_of_hand;

function private autoexec __init__system__() {
  system::register(#"zm_perk_sleight_of_hand", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  function_a8fdd433();
}

function function_a8fdd433() {
  zm_perks::register_perk_clientfields(#"talent_speedcola", &function_38dda839, &function_3bdb96bc);
  zm_perks::register_perk_effects(#"talent_speedcola", "sleight_light");
  zm_perks::register_perk_init_thread(#"talent_speedcola", &function_7d2154f5);
  zm_perks::function_f3c80d73("zombie_perk_bottle_sleight");
}

function function_7d2154f5() {
  if(is_true(level.enable_magic)) {
    level._effect[# "sleight_light"] = "zombie/fx_perk_speedcola_ndu";
  }
}

function function_38dda839() {}

function function_3bdb96bc() {}