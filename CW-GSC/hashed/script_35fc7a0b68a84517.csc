/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_35fc7a0b68a84517.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_e6fea84d;

function private autoexec __init__system__() {
  system::register(#"hash_1aecd78b7244ff81", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(util::get_game_type() === # "hash_1aecd78b7244ff81") {
    clientfield::register_clientuimodel("hudItems.onslaught.lottoloadouts_rarity", #"hud_items", [# "onslaught", #"lottoloadouts_rarity"], 1, 2, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("hudItems.onslaught.lottoloadouts_atttype", #"hud_items", [# "onslaught", #"lottoloadouts_atttype"], 1, 4, "int", undefined, 0, 0);
  }
}