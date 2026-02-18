/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\annihilator.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace annihilator;

function private autoexec __init__system__() {
  system::register(#"annihilator", &__init__, undefined, undefined, #"killstreaks");
}

function __init__() {}