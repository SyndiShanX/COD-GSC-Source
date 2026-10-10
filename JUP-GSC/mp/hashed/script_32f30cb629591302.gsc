/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_32f30cb629591302.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_compass;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_dlog;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;
#namespace namespace_ff661296b1d7442b;

function main() {
  function_c0b3ddc9a6bdcc46("tac_rover", &tac_rover_init);
}

function private tac_rover_init() {
  if(!function_9697379150687859("tac_rover")) {
    return;
  }

  create_func_ref("set_vehicle_anims_tromeo", &set_vehicle_anims_tromeo);
  function_8497e7e46b5e397("tac_rover");
}

#using_animtree("mp_vehicles_always_loaded");

function private set_vehicle_anims_tromeo(positions) {
  positions[0].vehicle_getoutanim = % vh_tromeo_front_exit_patrol;
  positions[0].vehicle_getoutanim_clear = 0;
  positions[0].vehicle_getoutanim_combat = % vh_tromeo_front_exit_combat_idle;
  positions[0].vehicle_getoutanim_combat_clear = 0;
  positions[0].vehicle_getoutanim_combat_run = % vh_tromeo_front_exit_combat_run;
  positions[0].vehicle_getoutanim_combat_run_clear = 0;
  positions[2].vehicle_getoutanim = % reb_com_veh8_techo_br_door_open;
  positions[2].vehicle_getoutanim_clear = 0;
  positions[3].vehicle_getoutanim = % reb_com_veh8_techo_bl_door_open;
  positions[3].vehicle_getoutanim_clear = 0;
  positions[0].vehicle_getinanim = % reb_com_veh8_techo_fl_door_close;
  positions[0].vehicle_getinanim_clear = 0;
  positions[1].vehicle_getinanim = % reb_com_veh8_techo_fr_door_close;
  positions[1].vehicle_getinanim_clear = 0;
  positions[2].vehicle_getinanim = % reb_com_veh8_techo_br_door_close;
  positions[2].vehicle_getinanim_clear = 0;
  positions[3].vehicle_getinanim = % reb_com_veh8_techo_bl_door_close;
  positions[3].vehicle_getinanim_clear = 0;
  return positions;
}