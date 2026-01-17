/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_sumpf_amb.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\music_shared;
#using scripts\shared\util_shared;
#namespace zm_sumpf_amb;

function main() {
  thread play_meteor_loop();
  level thread function_d19cb2f8();
}

function play_meteor_loop() {
  meteor = audio::playloopat("amb_meteor_loop", (11264, -1920, -592));
}

function start_lights() {
  level waittill("start_lights");
  wait(2);
  array::thread_all(struct::get_array("electrical_circuit", "targetname"), &circuit_sound);
  playSound(0, "zmb_turn_on", (0, 0, 0));
  wait(3);
  array::thread_all(struct::get_array("electrical_surge", "targetname"), &light_sound);
  array::thread_all(struct::get_array("low_buzz", "targetname"), &buzz_sound);
  playertrack = audio::playloopat("player_ambience", (0, 0, 0));
}

function light_sound() {
  wait(randomfloatrange(1, 4));
  playSound(0, "evt_electrical_surge", self.origin);
  playFX(0, level._effect["electric_short_oneshot"], self.origin);
  wait(randomfloatrange(1, 2));
  e1 = audio::playloopat("light", self.origin);
  self run_sparks_loop();
}

function run_sparks_loop() {
  while(true) {
    wait(randomfloatrange(4, 15));
    if(randomfloatrange(0, 1) < 0.5) {
      playFX(0, level._effect["electric_short_oneshot"], self.origin);
      playSound(0, "evt_electrical_surge", self.origin);
    }
    wait(randomintrange(1, 4));
  }
}

function circuit_sound() {
  wait(1);
  playSound(0, "circuit", self.origin);
}

function buzz_sound() {
  lowbuzz = audio::playloopat("low_arc", self.origin);
}

function function_c9207335() {
  wait(3);
  level thread function_d667714e();
  var_13a52dfe = getEntArray(0, "sndMusicTrig", "targetname");
  array::thread_all(var_13a52dfe, &function_60a32834);
}

function function_60a32834() {
  while(true) {
    self waittill("trigger", trigplayer);
    if(trigplayer islocalplayer()) {
      level notify("hash_51d7bc7c", self.script_sound);
      while(isDefined(trigplayer) && trigplayer istouching(self)) {
        wait(0.016);
      }
    } else {
      wait(0.016);
    }
  }
}

function function_d667714e() {
  level.var_b6342abd = "mus_sumpf_underscore_default";
  level.var_6d9d81aa = "mus_sumpf_underscore_default";
  level.var_eb526c90 = spawn(0, (0, 0, 0), "script_origin");
  level.var_9433cf5a = level.var_eb526c90 playLoopSound(level.var_b6342abd, 2);
  while(true) {
    level waittill("hash_51d7bc7c", location);
    level.var_6d9d81aa = "mus_sumpf_underscore_" + location;
    if(level.var_6d9d81aa != level.var_b6342abd) {
      level thread function_b234849(level.var_6d9d81aa);
      level.var_b6342abd = level.var_6d9d81aa;
    }
  }
}

function function_b234849(var_6d9d81aa) {
  level endon("hash_51d7bc7c");
  level.var_eb526c90 stopallloopsounds(2);
  wait(1);
  level.var_9433cf5a = level.var_eb526c90 playLoopSound(var_6d9d81aa, 2);
}

function function_d19cb2f8() {
  loopers = struct::get_array("exterior_goal", "targetname");
  if(isDefined(loopers) && loopers.size > 0) {
    delay = 0;
    if(getdvarint("") > 0) {
      println(("" + loopers.size) + "");
    }
    for(i = 0; i < loopers.size; i++) {
      loopers[i] thread soundloopthink();
      delay = delay + 1;
      if((delay % 20) == 0) {
        wait(0.016);
      }
    }
  } else {
    println("");
    if(getdvarint("") > 0) {}
  }
}

function soundloopthink() {
  if(!isDefined(self.origin)) {
    return;
  }
  if(!isDefined(self.script_sound)) {
    self.script_sound = "zmb_spawn_walla";
  }
  notifyname = "";
  assert(isDefined(notifyname));
  if(isDefined(self.script_string)) {
    notifyname = self.script_string;
  }
  assert(isDefined(notifyname));
  started = 1;
  if(isDefined(self.script_int)) {
    started = self.script_int != 0;
  }
  if(started) {
    soundloopemitter(self.script_sound, self.origin);
  }
  if(notifyname != "") {
    for(;;) {
      level waittill(notifyname);
      if(started) {
        soundstoploopemitter(self.script_sound, self.origin);
      } else {
        soundloopemitter(self.script_sound, self.origin);
      }
      started = !started;
    }
  }
}