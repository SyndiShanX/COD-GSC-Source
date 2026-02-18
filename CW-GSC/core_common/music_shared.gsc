/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\music_shared.gsc
***********************************************/

#using scripts\core_common\callbacks_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace music;

function private autoexec __init__system__() {
  system::register(#"music", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  level.musicstate = "";
  util::registerclientsys("musicCmd");

  if(sessionmodeiscampaigngame()) {
    callback::on_spawned(&on_player_spawned);
  }
}

function setmusicstate(state, player, delay) {
  level thread function_d6f7c644(state, player, delay);
}

function function_d6f7c644(state, player, delay) {
  if(isDefined(level.musicstate)) {
    if(isDefined(delay)) {
      wait delay;
    }

    if(isDefined(player)) {
      util::setclientsysstate("musicCmd", state, player);
      return;
    } else if(level.musicstate != state) {
      util::setclientsysstate("musicCmd", state);
    }
  }

  level.musicstate = state;
}

function setmusicstatebyteam(state, str_teamname) {
  foreach(player in level.players) {
    if(isDefined(player.team) && player.team == str_teamname) {
      setmusicstate(state, player);
    }
  }
}

function on_player_spawned() {
  if(isDefined(level.musicstate)) {
    if(issubstr(level.musicstate, "_igc") || issubstr(level.musicstate, "igc_")) {
      return;
    }

    if(isDefined(self)) {}
  }
}

function function_cbeeecf() {
  if(isDefined(self)) {
    setmusicstate("none", self);
  }
}

function function_edda155f(str_alias, n_delay) {
  level thread function_2b18b6d6(#"mus_" + str_alias + "_intro", n_delay);
}

function function_2af5f0ec(str_alias, var_e08a84d6, n_delay) {
  if(isDefined(var_e08a84d6)) {
    level thread function_2b18b6d6(#"mus_" + str_alias + "_loop_" + var_e08a84d6, n_delay);
    return;
  }

  var_d49193ec = "mus_" + str_alias + "_loop_";
  n_max = 0;

  for(i = 0; i < 9; i++) {
    if(!soundexists(var_d49193ec + i)) {
      n_max = i;
    }
  }

  if(n_max > 0) {
    level thread function_2b18b6d6(#"mus_" + str_alias + "_loop_" + randomintrange(0, n_max), n_delay);
  }
}

function function_2b18b6d6(str_alias, n_delay) {
  if(isDefined(n_delay)) {
    wait n_delay;
  }

  playsoundatposition(str_alias, (0, 0, 0));
}