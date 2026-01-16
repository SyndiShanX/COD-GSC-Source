/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\frontend_amb.gsc
**************************************/

#include maps\_music;
#include maps\_utility;
#include common_scripts\utility;

main() {
  level.unlockablemusic = [];
  level setup_unlockable_music_tracks();
}

setup_unlockable_music_tracks() {
  add_music_track("MUS_SHADOWS", & "MUS_SHADOWS_INFO", 0);
  add_music_track("MUS_CHECKIN", & "MUS_CHECKIN_INFO", 0);
  add_music_track("MUS_SURVEILLANCE_BEATS", & "MUS_SURVEILLANCE_BEATS_INFO", 0);
  add_music_track("MUS_UP_RIVER", & "MUS_UP_RIVER_INFO", 0);
  add_music_track("MUS_ZMB_COMINGHOME", & "MUS_ZMB_COMINGHOME_INFO", 1);
  add_music_track("MUS_ZMB_115", & "MUS_ZMB_115_INFO", 2);
  add_music_track("MUS_ZMB_ABRACADAVRE", & "MUS_ZMB_ABRACADAVRE_INFO", 3);
  add_music_track("MUS_ZMB_PAREIDOLIA", & "MUS_ZMB_PAREIDOLIA_INFO", 4);
}

add_music_track(alias, name, unlocked) {
  m = spawnstruct();
  m.alias = alias;
  m.name = name;
  m.unlocked = unlocked;
  level.unlockablemusic = add_to_array(level.unlockablemusic, m);
}