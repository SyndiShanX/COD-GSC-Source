/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: weapons\mp\hacker_tool.gsc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\weapons\hacker_tool;
#namespace hacker_tool;

function private autoexec __init__system__() {
  system::register(#"hacker_tool", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared();
}