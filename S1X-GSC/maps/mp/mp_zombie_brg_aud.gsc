/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_brg_aud.gsc
*****************************************/

main() {
  level.customzombiemusicstates = ::customzombiemusicstates;
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
  ambientplay("amb_brg_warehouse_front");
  thread exploder_7_audio_emitters();
  thread civilian_extraction_success_stinger();
  thread civilian_extraction_fail_stinger();
}

exploder_7_audio_emitters() {
  var_0 = spawn("script_origin", (3761, -2060, 143));
  var_0 playLoopSound("water_main_spray");
  var_1 = spawn("script_origin", (3602, -2074, -23));
  var_1 playLoopSound("water_main_splash");
  var_2 = spawn("script_origin", (415, -5346, 170));
  var_2 playLoopSound("water_main_spray");
  level waittill("stop_audio_exloder_7");
  var_0 stoploopsound();
  var_2 stoploopsound();
  var_1 stoploopsound();
  waitframe();
  var_0 delete();
  var_2 delete();
  var_1 delete();
}

civilian_extraction_success_stinger() {
  for(;;) {
    level waittill("extraction_complete");
    playsoundatpos((0, 0, 0), "zmb_civ_extract_success");
  }
}

civilian_extraction_fail_stinger() {
  for(;;) {
    level waittill("extraction_failed");
    playsoundatpos((0, 0, 0), "zmb_civ_extract_fail");
  }
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

customzombiemusicstates() {
  level thread maps\mp\zombies\_zombies_music::setupmusicstate(1, "round_normal", ["zmb_mus_wave_04_lp", "zmb_mus_wave_05_lp", "zmb_mus_wave_06_lp", "zmb_mus_wave_01_lp", "zmb_mus_wave_02_lp", "zmb_mus_wave_03_lp"], 0, 1, 1, 1);
  level thread maps\mp\zombies\_zombies_music::setupmusicstate(1, "round_zombie_dog", ["zmb_mus_spec_04_lp", "zmb_mus_spec_05_lp", "zmb_mus_spec_06_lp"], 0, 1, 1, 1);
  level thread maps\mp\zombies\_zombies_music::setupmusicstate(1, "round_zombie_host", ["zmb_mus_spec_04_lp", "zmb_mus_spec_05_lp", "zmb_mus_spec_06_lp"], 0, 1, 1, 1);
  level thread maps\mp\zombies\_zombies_music::setupmusicstate(1, "round_civilian", "zmb_mus_spec_03_lp", 0, 1, 1, 1);
  level thread maps\mp\zombies\_zombies_music::setupmusicstate(1, "round_zombie_melee_goliath", ["zmb_mus_spec_01_lp", "zmb_mus_spec_02_lp"], 0, 1, 1, 1);
}