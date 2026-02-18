/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\rat.gsc
***********************************************/

#using scripts\core_common\rat_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\cp_common\util;
#namespace rat;

function private autoexec __init__system__() {
  system::register(#"rat", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init();
  level.rat.common.gethostplayer = &util::gethostplayer;
}