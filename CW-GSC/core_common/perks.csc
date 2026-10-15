/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\perks.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;

#namespace perks;

function private autoexec __init__system__() {
  system::register(#"perks_shared", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register_clientuimodel("hudItems.ammoCooldowns.equipment.tactical", #"hud_items", [#"ammocooldowns", #"equipment", #"tactical"], 1, 5, "float", undefined, 0, 0);
  clientfield::register_clientuimodel("hudItems.ammoCooldowns.equipment.lethal", #"hud_items", [#"ammocooldowns", #"equipment", #"lethal"], 1, 5, "float", undefined, 0, 0);
}