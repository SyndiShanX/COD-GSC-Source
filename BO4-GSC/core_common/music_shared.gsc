/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\music_shared.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace music;

autoexec __init__system__() {
  system::register(#"music", &__init__, undefined, undefined);
}

__init__() {
  level.musicstate = "";
  util::registerclientsys("musicCmd");

  if(sessionmodeiscampaigngame()) {
    callback::on_spawned(&on_player_spawned);
  }

  if(sessionmodeiswarzonegame()) {
    callback::on_connect(&function_cbeeecf);
  }
}

setmusicstate(state, player) {
  if(isDefined(level.musicstate)) {
    if(isDefined(player)) {
      util::setclientsysstate("musicCmd", state, player);
      return;
    } else if(level.musicstate != state) {
      util::setclientsysstate("musicCmd", state);
    }
  }

  level.musicstate = state;
}

setmusicstatebyteam(state, str_teamname) {
  foreach(player in level.players) {
    if(isDefined(player.team) && player.team == str_teamname) {
      setmusicstate(state, player);
    }
  }
}

on_player_spawned() {
  if(isDefined(level.musicstate)) {
    if(issubstr(level.musicstate, "_igc") || issubstr(level.musicstate, "igc_")) {
      return;
    }

    if(isDefined(self)) {}
  }
}

function_cbeeecf() {
  if(isDefined(self)) {
    setmusicstate("none", self);
  }
}