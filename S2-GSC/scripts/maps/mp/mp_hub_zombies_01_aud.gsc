/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_hub_zombies_01_aud.gsc
*****************************************************/

main() {
  thread watchaudiologsubmixes();
}

watchaudiologsubmixes() {
  setDvar("snd_playing_log", 0);
  var_0 = getdvarint("snd_playing_log");

  for(;;) {
    var_1 = getdvarint("snd_playing_log");

    if(var_1 != var_0) {
      if(var_1) {
        level.player clientaddsoundsubmix("zm_audio_log_mix");
      } else {
        level.player clientclearsoundsubmix("zm_audio_log_mix");
      }

      var_0 = var_1;
    }

    wait 0.5;
  }
}