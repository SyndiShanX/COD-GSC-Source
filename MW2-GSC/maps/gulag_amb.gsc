/********************************************************
 * Decompiled by FreeTheTech101 and Edited by SyndiShanX
 * Script: maps\gulag_amb.gsc
********************************************************/

#include maps\_ambient;

main() {
  level.ambient_track["gulag_ext0"] = "ambient_gulag_ext0";
  level.ambient_track["gulag_hall_int0"] = "ambient_gulag_hall_int0";
  level.ambient_track["gulag_shower_int0"] = "ambient_gulag_shower_int0";
  level.ambient_track["gulag_exit"] = "ambient_gulag_tunnel_int0";

  thread maps\_utility::set_ambient("gulag_ext0");

  ambientDelay("gulag_hall_int0", 7, 15);
  ambientEvent("gulag_hall_int0", "elm_quake_sub_rumble", 1);

  ambientDelay("gulag_shower_int0", 7, 15);
  ambientEvent("gulag_shower_int0", "elm_quake_sub_rumble", 1);

  ambientDelay("gulag_exit", 7, 15);

  ambientEvent("gulag_exit", "elm_quake_sub_rumble", 1);
}