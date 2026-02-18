/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6113b02129348aec.csc
***********************************************/

#using scripts\core_common\serverfield_shared;
#using scripts\core_common\system_shared;
#namespace namespace_9b5aa273;

function private autoexec __init__system__() {
  system::register(#"hash_2b0f887705d6f3e", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  serverfield::register("can_show_hold_breath_hint", 1, 1, "int");
}