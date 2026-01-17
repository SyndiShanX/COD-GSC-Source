/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_castle_tram.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\audio_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_filter;
#namespace zm_castle_tram;

function autoexec __init__sytem__() {
  system::register("zm_castle_tram", &__init__, undefined, undefined);
}

function __init__() {
  level._effect["tram_fuse_destroy"] = "dlc1/castle/fx_glow_115_fuse_burst_castle";
  level._effect["tram_fuse_fx"] = "dlc1/castle/fx_glow_115_fuse_castle";
  clientfield::register("scriptmover", "tram_fuse_destroy", 1, 1, "counter", &tram_fuse_destroy, 0, 0);
  clientfield::register("scriptmover", "tram_fuse_fx", 1, 1, "counter", &function_1383302a, 0, 0);
  clientfield::register("scriptmover", "cleanup_dynents", 1, 1, "counter", &function_8a2bbd06, 0, 0);
  clientfield::register("world", "snd_tram", 5000, 2, "int", &snd_tram, 0, 0);
  thread function_58a73de9();
  thread function_60283937();
}

function function_b84c3341(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self thread function_19082f83();
  }
}

function function_19082f83() {
  self endon("entityshutdown");
  self function_2d89f1a7(7.5, 0.5);
  self function_2d89f1a7(2.5, 0.25);
  self function_2d89f1a7(1.5, 0.1);
}

function function_2d89f1a7(var_e2026f3a, n_blink_rate) {
  self endon("entityshutdown");
  n_counter = 0;
  n_timer = 0;
  while(n_timer < var_e2026f3a) {
    if(n_counter % 2) {
      self show();
    } else {
      self hide();
    }
    wait(n_blink_rate);
    n_timer = n_timer + n_blink_rate;
    n_counter++;
  }
}

function function_1383302a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.tram_fuse_fx = playFXOnTag(localclientnum, level._effect["tram_fuse_fx"], self, "j_fuse_main");
}

function tram_fuse_destroy(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.tram_fuse_fx)) {
    deletefx(localclientnum, self.tram_fuse_fx, 1);
    self.tram_fuse_fx = undefined;
  }
  playFXOnTag(localclientnum, level._effect["tram_fuse_destroy"], self, "j_fuse_main");
}

function snd_tram(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(newval == 1) {
      playSound(0, "evt_tram_motor_start", (342, 979, 135));
      foreach(location in level.var_4ea0a9e6) {
        audio::playloopat("evt_tram_pulley_large_loop", location);
      }
      foreach(location in level.var_a49222f2) {
        audio::playloopat("evt_tram_pulley_small_loop", location);
      }
    }
    if(newval == 2) {
      playSound(0, "evt_tram_motor_stop", (342, 979, 135));
      foreach(location in level.var_4ea0a9e6) {
        audio::stoploopat("evt_tram_pulley_large_loop", location);
      }
      foreach(location in level.var_a49222f2) {
        audio::stoploopat("evt_tram_pulley_small_loop", location);
      }
    }
  }
}

function function_58a73de9() {
  level.var_4ea0a9e6 = array((159, 999, 265), (276, 1186, 264), (511, 1077, 264));
  level.var_a49222f2 = array((273, 431, 242), (603, 499, 238));
}

function function_60283937() {
  while(true) {
    level waittill("hash_dc18b3bb", duration);
    if(duration == "long") {
      playSound(0, "evt_tram_motor_long", (342, 979, 135));
    } else {
      playSound(0, "evt_tram_motor_short", (342, 979, 135));
    }
  }
}

function function_8a2bbd06(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  cleanupspawneddynents();
}