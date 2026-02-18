/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\scythe.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace scythe;

function private autoexec __init__system__() {
  system::register(#"scythe", &__init__, undefined, undefined, #"killstreaks");
}

function __init__() {}