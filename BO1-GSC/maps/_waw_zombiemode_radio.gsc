/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_waw_zombiemode_radio.gsc
******************************************/

#include maps\_utility;
#include common_scripts\utility;

init() {
  level._ZOMBIE_RADIO_CLIENTFLAG = 14;
  level._effect["broken_radio_spark"] = LoadFx("env/electrical/fx_elec_short_oneshot");
  name = "kzmb";
  key = "targetname";
  if(isDefined(level.kzmb_name)) {
    name = level.kzmb_name;
  }
  if(isDefined(level.kzmb_key)) {
    key = level.kzmb_key;
  }
  radios = getEntArray(name, key);
  if(!isDefined(radios) || !radios.size) {
    println("no radios");
    return;
  }
  println("Found radios: " + radios.size);
  array_thread(radios, ::zombie_radio_play);
  level thread stop_the_radio();
}

zombie_radio_play() {
  self setCanDamage(true);
  if(!isDefined(level.music_override)) {
    level.music_override = false;
  }
  while(1) {
    self waittill("damage");
    println("changing radio stations");
    if(level.music_override != true) {
      self SetClientFlag(level._ZOMBIE_RADIO_CLIENTFLAG);
      wait_network_frame();
      self ClearClientFlag(level._ZOMBIE_RADIO_CLIENTFLAG);
      wait(4);
    }
  }
}

stop_the_radio() {
  if(!isDefined(level.music_override)) {
    level.music_override = false;
  }
  while(1) {
    if(level.music_override == false) {
      wait(0.5);
    } else {
      level clientNotify("ktr");
      while(level.music_override == true) {
        wait(0.5);
      }
      level clientNotify("rrd");
    }
    wait(0.5);
  }
}