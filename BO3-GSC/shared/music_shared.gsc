/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\music_shared.gsc
*************************************************/

#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace music;

function autoexec __init__sytem__() {
  system::register("music", & __init__, undefined, undefined);
}

function __init__() {
  level.musicstate = "";
  util::registerclientsys("musicCmd");
  if(sessionmodeiscampaigngame()) {
    callback::on_spawned( & on_player_spawned);
  }
}

function setmusicstate(state, player) {
  if(isdefined(level.musicstate)) {
    if(isdefined(level.bonuszm_musicoverride) && level.bonuszm_musicoverride) {
      return;
    }
    if(isdefined(player)) {
      util::setclientsysstate("musicCmd", state, player);
      return;
    }
    if(level.musicstate != state) {
      util::setclientsysstate("musicCmd", state);
    }
  }
  level.musicstate = state;
}

function on_player_spawned() {
  if(isdefined(level.musicstate)) {
    if(issubstr(level.musicstate, "_igc") || issubstr(level.musicstate, "igc_")) {
      return;
    }
    if(isdefined(self)) {
      setmusicstate(level.musicstate, self);
    } else {
      setmusicstate(level.musicstate);
    }
  }
}