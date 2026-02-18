/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_tungsten_audio.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_audio;
#namespace zm_tungsten_audio;

function init() {
  level.var_a353323e = &function_cb5a4b1a;
  level.var_ae2fe3bd = &function_613a7ccc;
  level.var_da00670e = &function_da00670e;
  level thread function_acd83a15();
  util::registerclientsys("tritonCmd");
}

function function_cb5a4b1a() {
  foreach(player in getplayers()) {
    player clientfield::set_to_player("" + # "music_underscore", 2);
  }

  music::setmusicstate("common_exfil");
}

function function_613a7ccc(b_success = 0) {
  if(b_success) {
    music::setmusicstate("common_exfil_success");
    return;
  }

  music::setmusicstate("common_exfil_fail");
}

function function_acd83a15() {
  level endon(#"game_over");

  while(true) {
    waitresult = level waittill(#"musroundend", #"hash_350a3e373494a400");

    if(waitresult._notify === "musRoundEnd") {
      level thread function_e2901362();
      continue;
    }

    level thread function_26113358();
  }
}

function function_e840d5a5() {
  if(is_true(level.musicsystemoverride)) {
    return false;
  }

  if(!isDefined(level.musicsystem)) {
    return true;
  }

  if(!isDefined(level.musicsystem.currentplaytype)) {
    return true;
  }

  if(level.musicsystem.currentplaytype >= 4) {
    return false;
  }

  return true;
}

function function_3c734339() {
  level endon(#"game_over");
  level flag::wait_till("start_zombie_round_logic");

  foreach(player in getplayers()) {
    player clientfield::set_to_player("" + # "music_underscore", 0);
  }
}

function function_8f85d169(var_dbd74b22 = 1) {
  if(var_dbd74b22) {
    level thread zm_audio::sndmusicsystem_stopandflush();
    level.musicsystemoverride = 1;
    level thread function_e2901362();
    return;
  }

  level.musicsystemoverride = 0;
  level thread function_26113358();
}

function function_da00670e() {
  level thread function_e2901362();
  wait 1;
  level thread function_d0f24e17();
}

function function_d0f24e17() {
  level endon(#"game_over");

  if(!isDefined(level.musicsystem)) {
    return;
  }

  if(is_true(level.musicsystemoverride)) {
    return;
  }

  while(level.musicsystem.currentplaytype === 4) {
    wait 1;
  }

  level thread function_26113358();
}

function function_2c40648c(b_active = 1) {
  if(b_active) {
    level thread function_26113358();
    return;
  }

  level thread function_e2901362();
}

function function_26113358() {
  if(function_e840d5a5()) {
    foreach(player in getplayers()) {
      player clientfield::set_to_player("" + # "music_underscore", 3);
    }
  }
}

function function_e2901362() {
  foreach(player in getplayers()) {
    player clientfield::set_to_player("" + # "music_underscore", 2);
  }
}