/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\nazi_zombie_sumpf_amb.csc
*****************************************************/

#include clientscripts\_utility;
#include clientscripts\_ambientpackage;
#include clientscripts\_music;

main() {
  /
  thread play_meteor_loop();
}

play_meteor_loop() {
  meteor = clientscripts\_audio::playloopat(0, "meteor_loop", (11264, -1920, -592));
}

add_song(song) {
  if(!isDefined(level.radio_songs))
    level.radio_songs = [];
  level.radio_songs[level.radio_songs.size] = song;
}

fade(id, time) {
  rate = 0;
  if(time != 0)
    rate = 1.0 / time;
  setSoundVolumeRate(id, rate);
  setSoundVolume(id, 0.0);
  while (SoundPlaying(id) && getSoundVolume(id) > .0001) {
    wait(.1);
  }
  stopSound(id);
}

radio_advance() {
  for (;;) {
    while (SoundPlaying(level.radio_id) || level.radio_index == 0) {
      wait(1);
    }
    level notify("kzmb_next_song");
    wait(1);
  }
}

radio_thread() {
  assert(isDefined(level.radio_id));
  assert(isDefined(level.radio_songs));
  assert(isDefined(level.radio_index));
  assert(level.radio_songs.size > 0);
  println("Starting radio at " + self.origin);
  for (;;) {
    level waittill("kzmb_next_song");
    println("client changing songs");
    playsound(0, "static", self.origin);
    if(SoundPlaying(level.radio_id)) {
      fade(level.radio_id, 1);
    } else {
      wait(.5);
    }
    level.radio_id = playsound(0, level.radio_songs[level.radio_index], self.origin);
    level.radio_index += 1;
    if(level.radio_index >= level.radio_songs.size) {
      level.radio_index = 0;
    }
    wait(1);
  }
}

radio_init() {
  level.radio_id = -1;
  level.radio_index = 0;
  add_song("wtf");
  add_song("dog_fire");
  add_song("true_crime_4");
  add_song("all_mixed_up");
  add_song("dusk");
  add_song("the_march");
  add_song("drum_no_bass");
  add_song("russian_theme");
  add_song("sand");
  add_song("stag_push");
  add_song("pby_old");
  add_song("wild_card");
  add_song("");
  radios = getentarray(0, "kzmb", "targetname");
  while (!isDefined(radios) || !radios.size) {
    wait(5);
    radios = getentarray(0, "kzmb", "targetname");
  }
  println("client found " + radios.size + " radios");
}

start_lights() {
  level waittill("start_lights");
  wait(2.0);
  array_thread(getstructarray("electrical_circuit", "targetname"), ::circuit_sound);
  playsound(0, "turn_on", (0, 0, 0));
  wait(3.0);
  array_thread(getstructarray("electrical_surge", "targetname"), ::light_sound);
  array_thread(getstructarray("low_buzz", "targetname"), ::buzz_sound);
  array_thread(getstructarray("perksacola", "targetname"), ::perks_a_cola_jingle);
  playertrack = clientscripts\_audio::playloopat(0, "players_ambience", (0, 0, 0));
}

light_sound() {
  wait(randomfloatrange(1, 4));
  playsound(0, "electrical_surge", self.origin);
  playfx(0, level._effect["electric_short_oneshot"], self.origin);
  wait(randomfloatrange(1, 2));
  e1 = clientscripts\_audio::playloopat(0, "light", self.origin);
  self run_sparks_loop();
}

run_sparks_loop() {
  while (1) {
    wait(randomfloatrange(4, 15));
    if(randomfloatrange(0, 1) < 0.5) {
      playfx(0, level._effect["electric_short_oneshot"], self.origin);
      playsound(0, "electrical_surge", self.origin);
    }
    wait(randomintrange(1, 4));
  }
}

circuit_sound() {
  wait(1);
  playsound(0, "circuit", self.origin);
}

buzz_sound() {
  lowbuzz = clientscripts\_audio::playloopat(0, "low_arc", self.origin);
}

start_jugganog_sounds() {
  level waittill("jugg_on");
  iprintlnbold("Machine_ON!!!");
  machine = getstructarray("perksacola", "targetname");
  for (i = 0; i < machine.size; i++) {
    if(machine[i].script_sound == "mx_jugger_jingle") {
      machine[i] thread perks_a_cola_jingle();
      iprintlnbold("Jugga_Run_Jingle");
    }
  }
}

start_speed_sounds() {
  level waittill("fast_reload_on");
  iprintlnbold("Machine_ON!!!");
  machine = getstructarray("perksacola", "targetname");
  for (i = 0; i < machine.size; i++) {
    if(machine[i].script_sound == "mx_speed_jingle") {
      machine[i] thread perks_a_cola_jingle();
      iprintlnbold("Speed_Run_Jingle");
    }
  }
}

start_revive_sounds() {
  level waittill("revive_on");
  iprintlnbold("Machine_ON!!!");
  machine = getstructarray("perksacola", "targetname");
  for (i = 0; i < machine.size; i++) {
    if(machine[i].script_sound == "mx_revive_jingle") {
      machine[i] thread perks_a_cola_jingle();
      iprintlnbold("Revive_Run_Jingle");
    }
  }
}

start_doubletap_sounds() {
  level waittill("doubletap_on");
  iprintlnbold("Machine_ON!!!");
  machine = getstructarray("perksacola", "targetname");
  for (i = 0; i < machine.size; i++) {
    if(machine[i].script_sound == "mx_doubletap_jingle") {
      machine[i] thread perks_a_cola_jingle();
      iprintlnbold("DT_Run_Jingle");
    }
  }
}

perks_a_cola_jingle() {
  lowhum = clientscripts\_audio::playloopat(0, "perks_machine_loop", self.origin);
  iprintlnbold("Low_HUM_IS_ON!");
  self thread play_random_broken_sounds();
  while (1) {
    wait(randomfloatrange(10, 20));
    level notify("jingle_playing");
    playsound(0, self.script_sound, self.origin);
    playfx(0, level._effect["electric_short_oneshot"], self.origin);
    playsound(0, "electrical_surge", self.origin);
    wait(30);
    self thread play_random_broken_sounds();
  }
}

play_random_broken_sounds() {
  level endon("jingle_playing");
  if(!isDefined(self.script_sound)) {
    self.script_sound = "null";
  }
  if(self.script_sound == "mx_revive_jingle") {
    while (1) {
      wait(randomfloatrange(7, 18));
      playsound(0, "broken_random_jingle", self.origin);
      playsound(0, "electrical_surge", self.origin);
    }
  } else {
    while (1) {
      wait(randomfloatrange(7, 18));
      playsound(0, "electrical_surge", self.origin);
    }
  }
}