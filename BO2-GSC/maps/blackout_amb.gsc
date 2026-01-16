/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\blackout_amb.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_music;

main() {
  level thread ocean_sound_emitters();
  array_thread(getentarray("display", "targetname"), ::displays);
}

sndmaskoff(elduderino) {
  level clientnotify("sndMaskOff");
}

sndf38snapshot(hisdudeness) {
  level clientnotify("sndF38Snapshot_on");
  player_f38 = getent("F35", "targetname");
  sound_ent = spawn("script_origin", player_f38.origin);
  sound_ent linkto(player_f38, "tag_canopy");
  sound_ent playloopsound("veh_f38_steady", 4);
  level waittill("f35_rewind_start");
  sound_ent stoploopsound(0.1);
  sound_ent delete();
  level clientnotify("sndF38Snapshot_off");
}

force_start_alarm_sounds() {
  level clientnotify("alarm_start");
  level clientnotify("argument_done");
}

ocean_sound_emitters() {
  level waittill("ocean_emitter_start");
  ocean_ent_1 = spawn("script_origin", (-707, -2196, -327));
  ocean_ent_2 = spawn("script_origin", (4030, -2196, -327));
  ocean_ent_1 playloopsound("amb_waves_l", 1);
  ocean_ent_2 playloopsound("amb_waves_r", 1);
}

displays() {
  self playloopsound("amb_" + self.script_noteworthy + "_display");
  self waittill("damage");
  self stoploopsound();
}