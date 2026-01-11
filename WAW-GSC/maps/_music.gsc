/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_music.gsc
*****************************************************/

#include maps\_utility;

music_init() {
  assert(level.clientscripts);
  level.musicState = "";
  registerClientSys("musicCmd");
}

setMusicState(state) {
  if(level.musicState != state) {
    setClientSysState("musicCmd", state);
  }
  level.musicState = state;
}