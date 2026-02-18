/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_21ae4c9317d84db6.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace ray_gun;

function private autoexec __init__system__() {
  system::register(#"ray_gun", &__init__, undefined, undefined, #"killstreaks");
}

function __init__() {}