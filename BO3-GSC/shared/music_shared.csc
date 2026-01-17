/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\music_shared.csc
*************************************************/

#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace music;

function autoexec __init__sytem__() {
  system::register("music", &__init__, undefined, undefined);
}

function __init__() {
  level.activemusicstate = "";
  level.nextmusicstate = "";
  level.musicstates = [];
  util::register_system("musicCmd", &musiccmdhandler);
}

function musiccmdhandler(clientnum, state, oldstate) {
  if(state != "death") {
    level._lastmusicstate = state;
  }
  state = tolower(state);
  soundsetmusicstate(state);
}