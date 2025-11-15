/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_zod_amb.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\music_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#namespace zm_zod_amb;

function main() {
  level thread function_bab3ea62();
}

function function_bab3ea62() {
  level thread function_53b9afad();
  var_29085ef = getEntArray(0, "sndMusicTrig", "targetname");
  array::thread_all(var_29085ef, & sndmusictrig);
}

function sndmusictrig() {
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

function function_53b9afad() {
  var_b6342abd = "mus_zod_underscore_default";
  var_6d9d81aa = "mus_zod_underscore_default";
  level.var_eb526c90 = spawn(0, (0, 0, 0), "script_origin");
  level.var_9433cf5a = level.var_eb526c90 playLoopSound(var_b6342abd, 2);
  while(true) {
    level waittill("hash_51d7bc7c", location);
    var_6d9d81aa = "mus_zod_underscore_" + location;
    if(var_6d9d81aa != var_b6342abd) {
      level thread function_51d7bc7c(var_6d9d81aa);
      var_b6342abd = var_6d9d81aa;
    }
  }
}

function function_51d7bc7c(var_6d9d81aa) {
  level endon("hash_51d7bc7c");
  level.var_eb526c90 stopallloopsounds(2);
  wait(1);
  level.var_9433cf5a = level.var_eb526c90 playLoopSound(var_6d9d81aa, 2);
}