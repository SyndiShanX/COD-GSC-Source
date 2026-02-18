/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\demo_shared.csc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace demo;

function private autoexec __init__system__() {
  system::register(#"demo", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!isdemoplaying()) {
    return;
  }
}