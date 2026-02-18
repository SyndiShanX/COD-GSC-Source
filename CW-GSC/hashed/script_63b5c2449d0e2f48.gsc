/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_63b5c2449d0e2f48.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_audio;
#namespace namespace_99d0d95e;

function init() {
  level.var_a353323e = &function_cb5a4b1a;
  level.var_ae2fe3bd = &function_613a7ccc;
  level.var_da00670e = &function_da00670e;
  level thread function_878fd065();
  level thread function_3e83eb5e();
  level thread function_8e50d09b();
  level thread function_acd83a15();
  level thread function_3c734339();
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

function function_878fd065() {
  var_5d1883b2 = spawn("script_origin", (-6006, 18086, 1905));
  var_5d1883b2 playLoopSound(#"hash_26cc6394ce6f97c7");
  wait 1;
  var_c40f5b72 = spawn("script_origin", (3145, 15829, 1497));
  var_c40f5b72 playLoopSound(#"hash_1aebb2a9c94effb3");

  while(level.round_number < 3) {
    wait 3;
  }

  level notify(#"hash_52d91a17b5ce6a13");
  var_5d1883b2 stoploopsound(1);
  var_c40f5b72 stoploopsound(1);
}

function function_3e83eb5e() {
  level endon(#"hash_52d91a17b5ce6a13");

  while(true) {
    wait 15;
    playsoundatposition(#"hash_18465a9117b3208f", (-6006, 18086, 1905));
  }
}

function function_8e50d09b() {
  while(true) {
    wait 65;
    playsoundatposition(#"hash_62c19eac25ff3f3c", (-6006, 18086, 1905));
  }
}

function function_acd83a15() {
  level endon(#"game_over");

  while(true) {
    waitresult = level waittill(#"musroundend", #"hash_350a3e373494a400");

    if(waitresult._notify === "musRoundEnd") {
      foreach(player in getplayers()) {
        player clientfield::set_to_player("" + # "music_underscore", 2);
      }

      continue;
    }

    if(function_e840d5a5()) {
      foreach(player in getplayers()) {
        player clientfield::set_to_player("" + # "music_underscore", 3);
      }
    }
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

    foreach(player in getplayers()) {
      player clientfield::set_to_player("" + # "music_underscore", 2);
    }

    return;
  }

  level.musicsystemoverride = 0;

  foreach(player in getplayers()) {
    player clientfield::set_to_player("" + # "music_underscore", 3);
  }
}

function function_da00670e() {
  foreach(player in getplayers()) {
    player clientfield::set_to_player("" + # "music_underscore", 2);
  }

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

  if(function_e840d5a5()) {
    foreach(player in getplayers()) {
      player clientfield::set_to_player("" + # "music_underscore", 3);
    }
  }
}