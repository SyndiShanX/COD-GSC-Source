/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_63cfd4b254834f61.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace namespace_5d18774f;

function private autoexec __init__system__() {
  system::register(#"blood", &preload, undefined, undefined, undefined);
}

function preload() {
  if(sessionmodeiscampaigngame()) {
    clientfield::register("world", "" + # "hash_7dc38a630ed68eb3", 1, 1, "int");
  }
}