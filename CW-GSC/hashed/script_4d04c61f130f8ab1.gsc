/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4d04c61f130f8ab1.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_a2fc8c70;

function private autoexec __init__system__() {
  system::register(#"hash_35d5e49c19d9cf09", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(is_true(getgametypesetting(#"hash_cd096e90260a26b"))) {
    level._effect[#"orb_nuke"] = "zombie/fx9_onslaught_orb_unstable_collapse";
  }
}