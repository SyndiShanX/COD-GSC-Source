/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\so_rts_mp_drone.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_scene;
#include maps\_vehicle;
#include maps\so_rts_mp_drone_fx;
#include maps\_so_rts_main;
#include maps\_load;
#include maps\_compass;
#include maps\so_rts_mp_drone_s1;

main() {
  maps\so_rts_mp_drone_fx::main();
  level.era = "twentytwenty";
  level.rts_def_table = "sp/so_rts/mp_drone_rts.csv";
  maps\_so_rts_main::preload();
  level.compass_map_name = "compass_map_mp_drone";
  level.supportsvomitingdeaths = 1;
  drone_level_precache();
  maps\_load::main();
  maps\_compass::setupminimap(level.compass_map_name);
  screen_fade_out(0);
  objective_clearall();
  maps\_so_rts_main::postload();
  drone_level_setup();
  maps\_so_rts_main::main();
}

drone_setstart() {
  ent = getent("rts_player_start", "targetname");
  assert(isDefined(ent), "Player starting location must be defined.");
  self.origin = ent.origin;
  self setplayerangles(ent.angles);
}

drone_level_setup() {
  level.onspawnplayer = ::drone_setstart;

  switch (getdvarint(#"_id_911E7496")) {
    case 0:
    case 1:
      level.custom_mission_complete = maps\so_rts_mp_drone_s1::drone_mission_complete_s1;
      level thread maps\so_rts_mp_drone_s1::drone_level_scenario_one();
      break;
    case 2:
      break;
    case 3:
      break;
    default:

      assertmsg("Unhandled war scenario specified");

      break;
  }
}

drone_level_precache() {
  setheliheightpatchenabled("mp_mode_heli_height_lock", 0);
  level.onspawnplayer = ::drone_setstart;

  switch (getdvarint(#"_id_911E7496")) {
    case 0:
    case 1:
      level thread maps\so_rts_mp_drone_s1::precache();
      break;
    case 2:
      break;
    case 3:
      break;
    default:

      assertmsg("Unhandled war scenario specified");

      break;
  }
}