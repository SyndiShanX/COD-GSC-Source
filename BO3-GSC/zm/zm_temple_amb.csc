/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_temple_amb.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\music_shared;
#using scripts\shared\util_shared;
#namespace zm_temple_amb;

function main() {
  level thread function_a96d8fc7();
  level thread function_28416c1e();
  level thread function_b11e8fe8();
  level thread wait_for_game_end();
  level thread snd_start_autofx_audio();
  level thread function_d19cb2f8();
  clientfield::register("scriptmover", "meteor_shrink", 21000, 1, "counter", &meteor_shrink, 0, 0);
}

function function_28416c1e() {
  level waittill("drb");
  level notify("hash_91064368");
}

function function_a96d8fc7() {
  level.var_15e33496 = undefined;
}

function function_418a175a(var_ef677c68) {
  playSound(0, "evt_sq_gen_transition", (0, 0, 0));
  setsoundcontext("aquifer_cockpit", "active");
  audio::playloopat("evt_sq_gen_bg", (0, 0, 0));
}

function function_e3a6a660(bnewent, binitialsnap, bwasdemojump) {
  if(!bnewent && !binitialsnap && !bwasdemojump) {
    playSound(0, "evt_sq_gen_transition", (0, 0, 0));
  }
  setsoundcontext("aquifer_cockpit", "");
  audio::stoploopat("evt_sq_gen_bg", (0, 0, 0));
}

function function_b11e8fe8() {
  level thread function_e2433f87(0);
  level thread function_e2433f87(1);
}

function function_e2433f87(num) {
  while(true) {
    level waittill("ge" + num);
    level notify("evt_geyser_blast_" + num);
    wait(14.5);
    level notify("evt_geyser_blast_" + num);
  }
}

function meteor_shrink(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  audio::snd_set_snapshot("zmb_temple_egg");
  level thread function_762642a6();
}

function function_762642a6() {
  wait(5.5);
  if(isDefined(level.var_15e33496)) {
    audio::snd_set_snapshot("zmb_temple_sq");
  } else {
    audio::snd_set_snapshot("default");
  }
}

function wait_for_game_end() {
  level waittill("zesn");
  audio::snd_set_snapshot("zmb_temple_egg");
}

function snd_start_autofx_audio() {
  audio::snd_play_auto_fx("fx_ztem_torch", "amb_fire_medium");
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
  level.var_b6342abd = "mus_temple_underscore_default";
  level.var_6d9d81aa = "mus_temple_underscore_default";
  level.var_eb526c90 = spawn(0, (0, 0, 0), "script_origin");
  level.var_9433cf5a = level.var_eb526c90 playLoopSound(level.var_b6342abd, 2);
  while(true) {
    level waittill("hash_51d7bc7c", location);
    level.var_6d9d81aa = "mus_temple_underscore_" + location;
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