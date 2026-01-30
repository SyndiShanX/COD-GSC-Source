/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_lab_aud.gsc
*****************************************/

main() {
  thread setup_audio();
  thread horde_audio();
  thread onplayerconnectedaudio();
}

onplayerconnectedaudio() {
  for(;;) {
    level waittill("connected", var_0);
    var_0 clientaddsoundsubmix("master_mix");
  }
}

setup_audio() {
  wait 1;
  ambientplay("amb_zmb_lab_ext");
}

horde_audio() {
  self endon("death");
  wait 1;
  level.horde_audio_ent = spawn("script_origin", (0, 0, 0));

  for(;;) {
    level.horde_audio_ent scalevolume(0);
    level waittill("zombie_wave_started");
    wait 0.5;

    if(level.roundtype == "zombie_dog") {
      level.horde_audio_ent playLoopSound("zmb_horde_dog");
    }

    if(level.roundtype == "zombie_host") {
      level.horde_audio_ent playLoopSound("zmb_horde_host");
    } else {
      level.horde_audio_ent playLoopSound("zmb_horde_general");
    }

    level.horde_audio_ent scalevolume(1, 5);
    level waittill("zombie_wave_ended");
    level.horde_audio_ent stoploopsound();
  }
}