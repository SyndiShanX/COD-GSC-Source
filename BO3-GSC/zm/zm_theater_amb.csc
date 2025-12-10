/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_theater_amb.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\music_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace zm_theater_amb;

function autoexec __init__sytem__() {
  system::register("zm_theater_amb", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("toplayer", "player_dust_mote", 21000, 1, "int", &function_9a4cfd8d, 0, 0);
}

function main() {
  thread power_on_all();
  level thread function_c9207335();
}

function power_on_all() {
  wait(0.016);
  if(!level clientfield::get("zombie_power_on")) {
    level waittill("zpo");
  }
  level thread telepad_loop();
  level thread teleport_2d();
  level thread teleport_2d_nopad();
  level thread teleport_beam_fx_2d();
  level thread teleport_specialroom_start();
  level thread teleport_specialroom_go();
  level thread function_24ac75e();
}

function telepad_loop() {
  telepad = struct::get_array("telepad", "targetname");
  array::thread_all(telepad, &teleportation_audio);
}

function teleportation_audio() {
  teleport_delay = 2;
  while(true) {
    level waittill("tpa");
    if(isDefined(self.script_sound)) {
      playSound(0, ("evt_" + self.script_sound) + "_warmup", self.origin);
      wait(teleport_delay);
      playSound(0, ("evt_" + self.script_sound) + "_cooldown", self.origin);
    }
  }
}

function teleport_2d() {
  while(true) {
    level waittill("t2d");
    playSound(0, "evt_teleport_2d_fnt", (0, 0, 0));
    playSound(0, "evt_teleport_2d_rear", (0, 0, 0));
  }
}

function teleport_2d_nopad() {
  while(true) {
    level waittill("t2dn");
    playSound(0, "evt_pad_warmup_2d", (0, 0, 0));
    wait(1.3);
    playSound(0, "evt_teleport_2d_fnt", (0, 0, 0));
    playSound(0, "evt_teleport_2d_rear", (0, 0, 0));
  }
}

function teleport_beam_fx_2d() {
  while(true) {
    level waittill("t2bfx");
    playSound(0, "evt_beam_fx_2d", (0, 0, 0));
  }
}

function teleport_specialroom_start() {
  while(true) {
    level waittill("tss");
    playSound(0, "evt_pad_warmup_2d", (0, 0, 0));
  }
}

function teleport_specialroom_go() {
  while(true) {
    level waittill("tsg");
    playSound(0, "evt_teleport_2d_fnt", (0, 0, 0));
    playSound(0, "evt_teleport_2d_rear", (0, 0, 0));
  }
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
  level.var_b6342abd = "mus_theater_underscore_default";
  level.var_6d9d81aa = "mus_theater_underscore_default";
  level.var_eb526c90 = spawn(0, (0, 0, 0), "script_origin");
  level.var_9433cf5a = level.var_eb526c90 playLoopSound(level.var_b6342abd, 2);
  while(true) {
    level waittill("hash_51d7bc7c", location);
    level.var_6d9d81aa = "mus_theater_underscore_" + location;
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

function function_24ac75e() {
  audio::playloopat("amb_kino_movie", (-1, 1185, 474));
}

function function_9a4cfd8d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    self.var_5fb5b46e = playfxoncamera(localclientnum, level._effect["player_dust_motes"]);
  } else if(isDefined(self.var_5fb5b46e)) {
    killfx(localclientnum, self.var_5fb5b46e);
    self.var_5fb5b46e = undefined;
  }
}