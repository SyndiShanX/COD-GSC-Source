/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_radio.csc
*************************************************/

#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#namespace zm_radio;

function autoexec __init__sytem__() {
  system::register("zm_radio", &__init__, &__main__, undefined);
}

function __init__() {}

function __main__() {}

function next_song(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  assert(isDefined(level.var_f3006fa7));
  assert(isDefined(level.var_c017e2d5));
  assert(isDefined(level.n_radio_index));
  assert(level.var_c017e2d5.size > 0);
  if(!isDefined(level.var_58522184)) {
    level.var_58522184 = 0;
  }
  if(!level.var_58522184) {
    if(newval) {
      playSound(0, "static", self.origin);
      if(soundplaying(level.var_f3006fa7)) {
        fade(level.var_f3006fa7, 1);
      } else {
        wait(0.5);
      }
      if(level.n_radio_index < level.var_c017e2d5.size) {
        println("" + level.var_c017e2d5[level.n_radio_index]);
        level.var_f3006fa7 = playSound(0, level.var_c017e2d5[level.n_radio_index], self.origin);
      } else {
        return;
      }
    }
  } else if(isDefined(level.var_f3006fa7)) {
    stopsound(level.var_f3006fa7);
  }
}

function add_song(song) {
  if(!isDefined(level.var_c017e2d5)) {
    level.var_c017e2d5 = [];
  }
  level.var_c017e2d5[level.var_c017e2d5.size] = song;
}

function function_2b7f281d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  assert(isDefined(level.n_radio_index));
  level.n_radio_index = newval;
}

function fade(n_id, n_time) {
  n_rate = 0;
  if(n_time != 0) {
    n_rate = 1 / n_time;
  }
  setsoundvolumerate(n_id, n_rate);
  setsoundvolume(n_id, 0);
  wait(n_time);
  stopsound(n_id);
}

function stop_radio_listener() {
  while(true) {
    level waittill("ktr");
    level.var_58522184 = 1;
    level thread next_song();
    level waittill("rrd");
    level.var_58522184 = 0;
    wait(0.5);
  }
}