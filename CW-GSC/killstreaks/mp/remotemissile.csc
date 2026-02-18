/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\mp\remotemissile.csc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\killstreaks\remotemissile_shared;
#namespace remotemissile;

function private autoexec __init__system__() {
  system::register(#"remotemissile", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  init_shared();
}