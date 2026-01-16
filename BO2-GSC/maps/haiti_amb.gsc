/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\haiti_amb.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_music;

vtol_hatch_wind() {
  level clientnotify("vtol_snapshot_change");
  wind_snd_ent = spawn("script_origin", (-8021, 16003, 111016));
  wind_heavy_snd_ent = spawn("script_origin", (-8021, 16003, 111016));
  alarm_snd_ent = spawn("script_origin", (-8018, 16386, 111035));
  wind_snd_ent playsound("evt_outside_wind_start");
  wait 4;
  wind_snd_ent playloopsound("evt_outside_wind_loop", 1);
  wait 10;
  wind_snd_ent stoploopsound(6);
  wind_heavy_snd_ent playsound("evt_vtol_damaged", "damaged_done");
  alarm_snd_ent playsound("evt_vtol_alarm");
  wait 6;
  wind_snd_ent delete();
  level waittill("damaged_done");
  wait 1;
  wind_heavy_snd_ent delete();
  alarm_snd_ent delete();
}