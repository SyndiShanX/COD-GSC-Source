/*****************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\player\player_reinsertion.csc
*****************************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace player_reinsertion;

function private autoexec __init__system__() {
  system::register(#"player_reinsertion", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(level.var_f2814a96 !== 0) {
    return;
  }
}