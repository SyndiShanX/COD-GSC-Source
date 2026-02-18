/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_1f500d6969ae4d07.gsc
***********************************************/

#using script_35ae72be7b4fec10;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#namespace namespace_ecee8af;

function private autoexec __init__system__() {
  system::register(#"hash_1176c65c6cb322ff", undefined, &init_postload, undefined, undefined);
}

function private init_postload() {}