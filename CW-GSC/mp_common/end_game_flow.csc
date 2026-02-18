/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\end_game_flow.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace end_game_flow;

function private autoexec __init__system__() {
  system::register(#"end_game_flow", &preinit, undefined, undefined, undefined);
}

function private preinit() {}