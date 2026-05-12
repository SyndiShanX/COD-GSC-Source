/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_hub_zombies_01_aud.gsc
*********************************************/

func_00F9() {
  thread watchaudiologsubmixes();
}

watchaudiologsubmixes() {
  setDvar("snd_playing_log", 0);
  var_00 = getdvarint("snd_playing_log");
  for(;;) {
    var_01 = getdvarint("snd_playing_log");
    if(var_01 != var_00) {
      if(var_01) {
        level.var_721C method_8626("zm_audio_log_mix");
      } else {
        level.var_721C method_8627("zm_audio_log_mix");
      }

      var_00 = var_01;
    }

    wait(0.5);
  }
}