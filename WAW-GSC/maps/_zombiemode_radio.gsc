/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_zombiemode_radio.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;
#include maps\_zombiemode_utility;

init() {
  level._effect["broken_radio_spark"] = LoadFx("env/electrical/fx_elec_short_oneshot");

  radios = getEntArray("kzmb", "targetname");

  if(!isDefined(radios) || !radios.size) {
    return;
  }

  array_thread(radios, ::zombie_radio_play);
}

zombie_radio_play() {
  self transmittargetname();

  self setCanDamage(true);

  while(1) {
    self waittill("damage");

    println("changing radio stations");

    SetClientSysState("levelNotify", "kzmb_next_song");

    wait(1.0);
  }
}