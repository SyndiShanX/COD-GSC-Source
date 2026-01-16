/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_genesis_sound.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\beam_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace zm_genesis_sound;

function autoexec __init__sytem__() {
  system::register("zm_genesis_sound", & __init__, undefined, undefined);
}

function __init__() {
  level thread function_bab3ea62();
  level thread function_849aa028();
  level thread play_generator();
  level thread function_37010187();
}

function function_bab3ea62() {
  wait(3);
  level thread function_53b9afad();
  level thread function_c959aa5f();
  var_29085ef = getentarray(0, "sndMusicTrig", "targetname");
  array::thread_all(var_29085ef, & sndmusictrig);
}

function sndmusictrig() {
  while (true) {
    self waittill("trigger", trigplayer);
    if(trigplayer islocalplayer()) {
      if(self.script_sound == "pavlov") {
        level notify("hash_51d7bc7c", level.var_98f2b64e);
      } else {
        level notify("hash_51d7bc7c", self.script_sound);
      }
      while (isdefined(trigplayer) && trigplayer istouching(self)) {
        wait(0.016);
      }
    } else {
      wait(0.016);
    }
  }
}

function function_53b9afad() {
  level.var_b6342abd = "mus_genesis_underscore_default";
  level.var_6d9d81aa = "mus_genesis_underscore_default";
  level.var_eb526c90 = spawn(0, (0, 0, 0), "script_origin");
  level.var_9433cf5a = level.var_eb526c90 playloopsound(level.var_b6342abd, 2);
  while (true) {
    level waittill("hash_51d7bc7c", location);
    level.var_6d9d81aa = "mus_genesis_underscore_" + location;
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
  level.var_9433cf5a = level.var_eb526c90 playloopsound(var_6d9d81aa, 2);
}

function function_c959aa5f() {
  level waittill("zesn");
  level notify("stpthm");
  if(isdefined(level.var_eb526c90)) {
    level.var_eb526c90 stopallloopsounds(2);
  }
}

function function_849aa028() {
  level.var_6191a71d = undefined;
  level.var_232ff65c = 0;
  level.var_f860f73b = 1;
  level thread function_899d68c0();
  var_29085ef = getentarray(0, "sndMusicTrig", "targetname");
  array::thread_all(var_29085ef, & function_ad9a8fa6);
}

function function_ad9a8fa6() {
  level endon("musThemeTriggered" + self.script_sound);
  while (true) {
    self waittill("trigger", trigplayer);
    if(self.script_sound == "default" && (!(isdefined(level.var_232ff65c) && level.var_232ff65c))) {
      continue;
    }
    if(isdefined(level.var_6191a71d)) {
      continue;
    }
    if(!(isdefined(level.var_f860f73b) && level.var_f860f73b)) {
      continue;
    }
    if(trigplayer islocalplayer()) {
      level thread function_1401492e(trigplayer, self.script_sound);
      level.var_232ff65c = 1;
      level notify("musThemeTriggered" + self.script_sound);
      return;
    }
  }
}

function function_1401492e(trigplayer, location) {
  level endon("stpthm");
  alias = "mus_genesis_entrytheme_" + location;
  level.var_6191a71d = playsound(0, alias, (0, 0, 0));
  wait(90);
  level.var_6191a71d = undefined;
}

function function_899d68c0() {
  while (true) {
    level waittill("stpthm");
    if(isdefined(level.var_6191a71d)) {
      stopsound(level.var_6191a71d);
      level.var_6191a71d = undefined;
    }
    level.var_f860f73b = 0;
    level waittill("strtthm");
    level.var_f860f73b = 1;
  }
}

function play_generator() {
  audio::playloopat("amb_gen_arc_loop", (5014, -1169, 429));
}

function function_37010187() {
  while (true) {
    wait(randomintrange(2, 6));
    playsound(0, "amb_comp_sweets", (4737, -1043, 424));
  }
}