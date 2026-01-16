/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\angola_2_amb.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_music;

main() {
  setsaveddvar("vehicle_sounds_cutoff", 30000);
}

heli_alarm() {
  while(true) {
    level waittill("hel_alrm_on");
    temp_ent = spawn("script_origin", level.player.origin);
    temp_ent playloopsound("veh_heli_alarm", 1);
    level waittill("hel_alrm_off");
    temp_ent stoploopsound(0.5);
    wait 0.75;
    temp_ent delete();
  }
}

sndboatramsnapshoton(guy) {
  level clientnotify("boatram_on");
}

sndboatramsnapshotoff(guy) {
  level clientnotify("boatram_off");
}

sndfindwoodssnapshot(guy) {
  clientnotify("woods_snp_on");
  level waittill("sndDeactivateSnapshot");
  clientnotify("woods_snp_off");
}

sndfindwoodsroom(guy) {
  clientnotify("woods_room_on");
  level waittill("sndDeactivateRoom");
  clientnotify("woods_room_off");
}