/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1e7b64dac79bb7ed.gsc
***********************************************/

main() {
  scripts\cp_mp\vehicles\vehicle::_id_C0B3DDC9A6BDCC46("veh9_mkilo23", ::_id_E9B7AA9D5A22E309);
}

_id_E9B7AA9D5A22E309() {
  if(!scripts\cp_mp\vehicles\vehicle::_id_9697379150687859("veh9_mkilo23")) {
    return;
  }
  scripts\engine\utility::create_func_ref("set_vehicle_anims_mkilo", ::set_vehicle_anims_mkilo);
  scripts\cp_mp\vehicles\vehicle::_id_08497E7E46B5E397("veh9_mkilo23");
}

#using_animtree("mp_vehicles_always_loaded");

set_vehicle_anims_mkilo(_id_E4B7E99A96C8829F) {
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim = % vh_mkilo_driver_exit_patrol;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_clear = 0;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_combat = % vh_mkilo_driver_exit_combat_idle;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_combat_clear = 0;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_combat_run = % vh_mkilo_driver_exit_combat_run;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_combat_run_clear = 0;
  _id_E4B7E99A96C8829F[1].vehicle_getoutanim = % vh_mkilo_pass_exit_patrol;
  _id_E4B7E99A96C8829F[1].vehicle_getoutanim_clear = 0;
  _id_E4B7E99A96C8829F[1].vehicle_getoutanim_combat = % vh_mkilo_pass_exit_combat_idle;
  _id_E4B7E99A96C8829F[1].vehicle_getoutanim_combat_clear = 0;
  _id_E4B7E99A96C8829F[1].vehicle_getoutanim_combat_run = % vh_mkilo_pass_exit_combat_run;
  _id_E4B7E99A96C8829F[1].vehicle_getoutanim_combat_run_clear = 0;
  return _id_E4B7E99A96C8829F;
}