/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_factory_amb.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\music_shared;
#namespace zm_factory_amb;

function main() {
  thread start_lights();
  thread teleport_pad_init(0);
  thread teleport_pad_init(1);
  thread teleport_pad_init(2);
  thread teleport_2d();
  thread pa_init(0);
  thread pa_init(1);
  thread pa_init(2);
  thread pa_single_init();
  thread homepad_loop();
  thread power_audio_2d();
  thread linkall_2d();
  thread crazy_power();
  thread flip_sparks();
  thread play_added_ambience();
  thread play_flux_whispers();
  thread play_backwards_children();
}

function start_lights() {
  level waittill("pl1");
  array::thread_all(struct::get_array("dyn_light", "targetname"), &light_sound);
  array::thread_all(struct::get_array("switch_progress", "targetname"), &switch_progress_sound);
  array::thread_all(struct::get_array("dyn_generator", "targetname"), &generator_sound);
  array::thread_all(struct::get_array("dyn_breakers", "targetname"), &breakers_sound);
}

function light_sound() {
  if(isDefined(self)) {
    playSound(0, "evt_light_start", self.origin);
    e1 = audio::playloopat("amb_light_buzz", self.origin);
  }
}

function generator_sound() {
  if(isDefined(self)) {
    wait(3);
    playSound(0, "evt_switch_progress", self.origin);
    playSound(0, "evt_gen_start", self.origin);
    g1 = audio::playloopat("evt_gen_loop", self.origin);
  }
}

function breakers_sound() {
  if(isDefined(self)) {
    playSound(0, "evt_break_start", self.origin);
    b1 = audio::playloopat("evt_break_loop", self.origin);
  }
}

function switch_progress_sound() {
  if(isDefined(self.script_noteworthy)) {
    if(self.script_noteworthy == "1") {
      time = 0.5;
    } else {
      if(self.script_noteworthy == "2") {
        time = 1;
      } else {
        if(self.script_noteworthy == "3") {
          time = 1.5;
        } else {
          if(self.script_noteworthy == "4") {
            time = 2;
          } else {
            if(self.script_noteworthy == "5") {
              time = 2.5;
            } else {
              time = 0;
            }
          }
        }
      }
    }
    wait(time);
    playSound(0, "evt_switch_progress", self.origin);
  }
}

function homepad_loop() {
  level waittill("pap1");
  homepad = struct::get("homepad_power_looper", "targetname");
  home_breaker = struct::get("homepad_breaker", "targetname");
  if(isDefined(homepad)) {
    audio::playloopat("amb_homepad_power_loop", homepad.origin);
  }
  if(isDefined(home_breaker)) {
    audio::playloopat("amb_break_arc", home_breaker.origin);
  }
}

function teleport_pad_init(pad) {
  telepad = struct::get_array("telepad_" + pad, "targetname");
  telepad_loop = struct::get_array(("telepad_" + pad) + "_looper", "targetname");
  homepad = struct::get_array("homepad", "targetname");
  level waittill("tp" + pad);
  array::thread_all(telepad_loop, &telepad_loop);
  array::thread_all(telepad, &teleportation_audio, pad);
  array::thread_all(homepad, &teleportation_audio, pad);
}

function telepad_loop() {
  audio::playloopat("amb_power_loop", self.origin);
}

function teleportation_audio(pad) {
  teleport_delay = 2;
  while(true) {
    level waittill("tpw" + pad);
    if(isDefined(self.script_sound)) {
      if(self.targetname == ("telepad_" + pad)) {
        playSound(0, self.script_sound + "_warmup", self.origin);
        wait(2);
        playSound(0, self.script_sound + "_cooldown", self.origin);
      }
      if(self.targetname == "homepad") {
        wait(2);
        playSound(0, self.script_sound + "_warmup", self.origin);
        playSound(0, self.script_sound + "_cooldown", self.origin);
      }
    }
  }
}

function pa_init(pad) {
  pa_sys = struct::get_array("pa_system", "targetname");
}

function pa_single_init() {
  pa_sys = struct::get_array("pa_system", "targetname");
}

function pa_countdown(pad) {
  level endon("scd" + pad);
  while(true) {
    level waittill("pac" + pad);
    playSound(0, "evt_pa_buzz", self.origin);
    self thread pa_play_dialog("vox_pa_audio_link_start");
    for(count = 30; count > 0; count--) {
      play = count == 20 || count == 15 || count <= 10;
      if(play) {
        playSound(0, "vox_pa_audio_link_" + count, self.origin);
      }
      playSound(0, "evt_clock_tick_1sec", (0, 0, 0));
      waitrealtime(1);
    }
    playSound(0, "evt_pa_buzz", self.origin);
    wait(1.2);
    self thread pa_play_dialog("vox_pa_audio_link_fail");
  }
  wait(1);
}

function pa_countdown_success(pad) {
  level waittill("scd" + pad);
  playSound(0, "evt_pa_buzz", self.origin);
  wait(1.2);
  self pa_play_dialog("vox_pa_audio_act_pad_" + pad);
}

function pa_teleport(pad) {
  while(true) {
    level waittill("tpc" + pad);
    wait(1);
    playSound(0, "evt_pa_buzz", self.origin);
    wait(1.2);
    self pa_play_dialog("vox_pa_teleport_finish");
  }
}

function pa_electric_trap(location) {
  while(true) {
    level waittill(location);
    playSound(0, "evt_pa_buzz", self.origin);
    wait(1.2);
    self thread pa_play_dialog("vox_pa_trap_inuse_" + location);
    waitrealtime(48.5);
    playSound(0, "evt_pa_buzz", self.origin);
    wait(1.2);
    self thread pa_play_dialog("vox_pa_trap_active_" + location);
  }
}

function pa_play_dialog(alias) {
  if(!isDefined(self.pa_is_speaking)) {
    self.pa_is_speaking = 0;
  }
  if(self.pa_is_speaking != 1) {
    self.pa_is_speaking = 1;
    self.pa_id = playSound(0, alias, self.origin);
    while(soundplaying(self.pa_id)) {
      wait(0.01);
    }
    self.pa_is_speaking = 0;
  }
}

function teleport_2d() {
  while(true) {
    level waittill("t2d");
    playSound(0, "evt_teleport_2d_fnt", (0, 0, 0));
    playSound(0, "evt_teleport_2d_rear", (0, 0, 0));
  }
}

function power_audio_2d() {
  level waittill("pl1");
  playSound(0, "evt_power_up_2d", (0, 0, 0));
}

function linkall_2d() {
  level waittill("pap1");
  playSound(0, "evt_linkall_2d", (0, 0, 0));
}

function pa_level_start() {}

function pa_power_on() {
  level waittill("pl1");
  playSound(0, "evt_pa_buzz", self.origin);
  wait(1.2);
  self pa_play_dialog("vox_pa_power_on");
}

function crazy_power() {
  level waittill("pl1");
  playSound(0, "evt_crazy_power_left", (-510, 394, 102));
  playSound(0, "evt_crazy_power_right", (554, -1696, 156));
}

function flip_sparks() {
  level waittill("pl1");
  playSound(0, "evt_flip_sparks_left", (511, -1771, 116));
  playSound(0, "evt_flip_sparks_right", (550, -1771, 116));
}

function play_added_ambience() {
  audio::playloopat("amb_snow_transitions", (-181, -455, 6));
  audio::playloopat("amb_snow_transitions", (1315, -1428, 227));
  audio::playloopat("amb_snow_transitions", (-1365, -1597, 295));
  audio::playloopat("amb_extreme_fire_dist", (1892, -2563, 1613));
  audio::playloopat("amb_extreme_fire_dist", (1441, -1622, 1603));
  audio::playloopat("amb_extreme_fire_dist", (-1561, 410, 1559));
  audio::playloopat("amb_extreme_fire_dist", (844, 2038, 915));
  audio::playloopat("amb_small_fire", (779, -2249, 326));
  audio::playloopat("amb_small_fire", (-2, -1417, 124));
  audio::playloopat("amb_small_fire", (1878, 911, 189));
}

function play_flux_whispers() {
  while(true) {
    playSound(0, "amb_creepy_whispers", (-339, 271, 207));
    playSound(0, "amb_creepy_whispers", (234, 110, 310));
    playSound(0, "amb_creepy_whispers", (-17, -564, 255));
    playSound(0, "amb_creepy_whispers", (743, -1859, 210));
    playSound(0, "amb_creepy_whispers", (790, -748, 181));
    wait(randomintrange(1, 4));
  }
}

function play_backwards_children() {
  while(true) {
    wait(60);
    playSound(0, "amb_creepy_children", (-2637, -2403, 413));
  }
}