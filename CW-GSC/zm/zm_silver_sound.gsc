/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_silver_sound.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\music_shared;
#using scripts\core_common\util_shared;
#namespace zm_silver_sound;

function init() {
  level.var_a353323e = &function_cb5a4b1a;
  level.var_ae2fe3bd = &function_613a7ccc;
  level.var_da00670e = &function_da00670e;
  level thread function_c1db8d1a();
  level thread function_acd83a15();
  level thread function_2cf67660();
}

function function_c1db8d1a() {
  level waittill(#"bfm");
  var_581d3017 = getent("audio_bfm", "targetname");
  playsoundatposition(#"hash_4ec7d60ade69984c", var_581d3017.origin);
  wait 1;
  playsoundatposition(#"hash_189fe24269ad58d", var_581d3017.origin);
  wait 1;
  var_581d3017 playLoopSound(#"hash_6890863e534ae68d");
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

function function_44cea26f(str_msg, n_delay = 0) {
  level thread function_30d9d43(str_msg, n_delay);
}

function function_30d9d43(str_msg, n_delay) {
  switch (n_delay) {
    case # "hash_5bad1025f0cf747e":
      level util::clientnotify("term1");
      level util::clientnotify("term2");
      break;
    case # "hash_7dbdd94b1b1e6829":
      playsoundatposition(#"hash_191f00f5f707e4ca", (1616, 741, -270));
      level util::clientnotify("term1");
      break;
    case # "hash_7dbdd64b1b1e6310":
      level util::clientnotify("term2");
      break;
    default:

      iprintlnbold("<dev string:x38>" + n_delay + "<dev string:x4a>");

      break;
  }
}

function function_2cf67660() {
  level waittill(#"snddooropening");
  playsoundatposition(#"hash_38b699d43c500e2e", (0, 0, 0));
}

function function_cb5a4b1a() {
  foreach(player in getplayers()) {
    player clientfield::set_to_player("" + # "music_underscore", 2);
  }

  music::setmusicstate("silver_exfil");
}

function function_613a7ccc(b_success = 0) {
  if(b_success) {
    music::setmusicstate("silver_exfil_success");
    return;
  }

  music::setmusicstate("silver_exfil_fail");
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