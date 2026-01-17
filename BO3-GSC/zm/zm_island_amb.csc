/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_island_amb.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\music_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#namespace zm_island_amb;

function main() {
  thread function_d19cb2f8();
  thread function_d1abcaef();
  thread function_bab3ea62();
}

function function_d1abcaef() {
  audio::playloopat("zmb_meteor_site_loop", (3222, 2237, -599));
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

function function_bab3ea62() {
  wait(3);
  level.var_65d981dd = "spider_lair_active";
  level.var_2d9f200e = "takeo_battle_inactive";
  level thread function_ab8dfbdf();
  level thread function_17e798e9();
  level thread function_7a83b09a();
  level thread function_610a705b();
  level thread function_53b9afad();
  var_29085ef = getEntArray(0, "sndMusicTrig", "targetname");
  array::thread_all(var_29085ef, &sndmusictrig);
}

function sndmusictrig() {
  while(true) {
    self waittill("trigger", trigplayer);
    if(trigplayer islocalplayer()) {
      if(self.script_sound == "spider_lair") {
        level notify("hash_51d7bc7c", level.var_65d981dd);
      } else {
        if(self.script_sound == "takeo") {
          level notify("hash_51d7bc7c", level.var_2d9f200e);
        } else {
          level notify("hash_51d7bc7c", self.script_sound);
        }
      }
      while(isDefined(trigplayer) && trigplayer istouching(self)) {
        wait(0.016);
      }
    } else {
      wait(0.016);
    }
  }
}

function function_53b9afad() {
  level.var_b6342abd = "mus_island_underscore_outdoor";
  level.var_6d9d81aa = "mus_island_underscore_outdoor";
  level.var_eb526c90 = spawn(0, (0, 0, 0), "script_origin");
  level.var_9433cf5a = level.var_eb526c90 playLoopSound(level.var_b6342abd, 2);
  while(true) {
    level waittill("hash_51d7bc7c", location);
    level.var_6d9d81aa = "mus_island_underscore_" + location;
    if(level.var_6d9d81aa != level.var_b6342abd) {
      level thread function_51d7bc7c(level.var_6d9d81aa);
      level.var_b6342abd = level.var_6d9d81aa;
    }
  }
}

function function_51d7bc7c(var_6d9d81aa) {
  level endon("hash_51d7bc7c");
  level.var_eb526c90 stopallloopsounds(2);
  wait(1);
  level.var_9433cf5a = level.var_eb526c90 playLoopSound(var_6d9d81aa, 2);
}

function function_ab8dfbdf() {
  level waittill("sndlair");
  level.var_65d981dd = "spider_lair_inactive";
  if(level.var_b6342abd == "mus_island_underscore_spider_lair_active") {
    level notify("hash_51d7bc7c", level.var_65d981dd);
  }
}

function function_17e798e9() {
  level endon("sndtakeoend");
  level waittill("sndtakeo");
  level.var_2d9f200e = "takeo_battle_active";
  if(level.var_b6342abd == "mus_island_underscore_takeo_battle_inactive") {
    level notify("hash_51d7bc7c", level.var_2d9f200e);
  }
}

function function_7a83b09a() {
  level waittill("sndtakeoend");
  level.var_2d9f200e = "takeo_battle_over";
  if(level.var_b6342abd == "mus_island_underscore_takeo_battle_active") {
    level notify("hash_51d7bc7c", level.var_2d9f200e);
  }
}

function function_610a705b() {
  while(true) {
    level waittill("sndfbm");
    level notify("hash_51d7bc7c", level.var_2d9f200e);
  }
}