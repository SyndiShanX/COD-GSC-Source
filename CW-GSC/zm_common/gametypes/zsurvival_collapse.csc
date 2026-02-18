/******************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\gametypes\zsurvival_collapse.csc
******************************************************/

#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace zsurvival_collapse;

function private autoexec __init__system__() {
  system::register(#"zsurvival_collapse", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(is_true(getgametypesetting(#"hash_1e1a5ebefe2772ba"))) {
    level.var_53bc31ad = 1;
  }
}