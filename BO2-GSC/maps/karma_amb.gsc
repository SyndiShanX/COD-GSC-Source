/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\karma_amb.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_music;

main() {
  level thread wait_for_bullet_fire();
  array_thread(getentarray("advertisement", "targetname"), ::advertisements);
}

wait_for_bullet_fire() {
  level waittill("club_shoot_target_down");
  level.player playsound("evt_solar_slow_bullet");
}

vtol_doors_open(brah) {
  brah playsoundontag("evt_vtol_doors_open", "tag_door_l1");
}

advertisements() {
  if(self.script_noteworthy == "solar")
    self playloopsound("vox_ads_1_01_005a_pa");

  if(self.script_noteworthy == "mall")
    self playloopsound("vox_ads_1_01_003a_pa");

  if(self.script_noteworthy == "pool")
    self playloopsound("vox_ads_1_01_006a_pa");

  self waittill("damage");
  self stoploopsound();
  self playloopsound("amb_" + self.script_noteworthy + "_damaged_ad");
}

duck_club_music() {
  flag_wait_any("spawn_creepers", "room_clear");
  clientnotify("club_music_duck");
  flag_wait_any("player_in_elevator", "escalator_open");
  clientnotify("club_music_duck_off");
}