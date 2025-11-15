/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\music_shared.csc
***********************************************/

#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace music;

autoexec __init__system__() {
  system::register(#"music", &__init__, undefined, undefined);
}

__init__() {
  level.activemusicstate = "";
  level.nextmusicstate = "";
  level.musicstates = [];
  util::register_system(#"musiccmd", &musiccmdhandler);
}

musiccmdhandler(clientnum, state, oldstate) {
  if(state != "death") {
    level._lastmusicstate = state;
  }

  state = tolower(state);
  soundsetmusicstate(state);
}