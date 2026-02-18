/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\music_shared.csc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace music;

function private autoexec __init__system__() {
  system::register(#"music", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.activemusicstate = "";
  level.nextmusicstate = "";
  level.musicstates = [];
  util::register_system(#"musiccmd", &musiccmdhandler);
}

function musiccmdhandler(clientnum, state, oldstate) {
  if(oldstate != "death") {
    level._lastmusicstate = oldstate;
  }

  oldstate = tolower(oldstate);
  soundsetmusicstate(oldstate);
}