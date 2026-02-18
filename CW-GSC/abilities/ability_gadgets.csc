/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: abilities\ability_gadgets.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace ability_gadgets;

function private autoexec __init__system__() {
  system::register(#"ability_gadgets", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register_clientuimodel("huditems.abilityHoldToActivate", #"hud_items", #"abilityholdtoactivate", 1, 2, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("huditems.abilityDelayProgress", #"hud_items", #"abilitydelayprogress", 1, 5, "float", undefined, 0, 0);
}