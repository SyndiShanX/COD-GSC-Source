/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_727042a075af51b7.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\item_world;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_7da6f8ca;

function private autoexec __init__system__() {
  system::register(#"hash_40a4f03bb2983ee3", &preinit, undefined, undefined, undefined);
}

function private preinit() {}

function function_6ee35a0a(rarity) {
  switch (rarity) {
    case # "resource":
      return # "hash_20b3d352fb23155c";
    case # "common":
      return # "hash_1c62f1903d03705a";
    case # "rare":
      return # "hash_3e3f86ff3fc6055";
    case # "epic":
      return # "hash_6c7840c9ca34f2a3";
    case # "legendary":
      return # "hash_7f4c941a9564c78f";
    case # "ultra":
      return # "hash_3dad79ca7ca879b5";
    default:
      return # "hash_20b3d352fb23155c";
  }
}