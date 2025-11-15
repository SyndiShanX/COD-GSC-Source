/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_castle_amb.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\music_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#namespace zm_castle_amb;

function main() {
  thread function_d19cb2f8();
  thread function_163d3651();
  thread function_509ffc62();
  level thread function_bab3ea62();
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

function function_163d3651() {
  soundloopemitter("zmb_spawn_undercroft_walla", (-508, 1615, 110));
  soundloopemitter("zmb_spawn_undercroft_walla", (607, 2189, 162));
  soundloopemitter("zmb_spawn_undercroft_walla", (-1771, 1924, 235));
  soundloopemitter("zmb_spawn_undercroft_walla", (-1730, 2565, 227));
  soundloopemitter("zmb_spawn_undercroft_walla", (-828, 2911, 261));
}

function function_509ffc62() {
  soundloopemitter("amb_radio_2", (-1080, 1625, 856));
  soundloopemitter("amb_radio_beep", (-1006, 1578, 856));
  soundloopemitter("amb_radio_3", (-1365, 1332, 856));
}

function function_bab3ea62() {
  wait(3);
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
  var_b6342abd = "mus_castle_underscore_gondola";
  var_6d9d81aa = "mus_castle_underscore_gondola";
  level.var_eb526c90 = spawn(0, (0, 0, 0), "script_origin");
  level.var_9433cf5a = level.var_eb526c90 playLoopSound(var_b6342abd, 2);
  while(true) {
    level waittill("hash_51d7bc7c", location);
    var_6d9d81aa = "mus_castle_underscore_" + location;
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