/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6a72d858ff1942eb.csc
***********************************************/

#using scripts\core_common\armor_carrier;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace namespace_234f0efc;

function private autoexec __init__system__() {
  system::register(#"hash_296b16535a22f50f", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register_clientuimodel("hudItems.radiationVestHealth", #"hud_items", #"radiationvesthealth", 1, 5, "float", undefined, 0, 0);
}

function function_d1aaf7a4() {
  assert(isPlayer(self));
  return self clientfield::get_player_uimodel("hudItems.radiationVestHealth") == 1;
}