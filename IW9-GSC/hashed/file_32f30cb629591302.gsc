/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_32f30cb629591302.gsc
***********************************************/

main() {
  scripts\cp_mp\vehicles\vehicle::_id_C0B3DDC9A6BDCC46("tac_rover", ::tac_rover_init);
}

tac_rover_init() {
  if(!scripts\cp_mp\vehicles\vehicle::_id_9697379150687859("tac_rover")) {
    return;
  }
  scripts\engine\utility::create_func_ref("set_vehicle_anims_tromeo", ::set_vehicle_anims_tromeo);
  scripts\cp_mp\vehicles\vehicle::_id_08497E7E46B5E397("tac_rover");
}

#using_animtree("mp_vehicles_always_loaded");

set_vehicle_anims_tromeo(_id_E4B7E99A96C8829F) {
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim = % vh_tromeo_front_exit_patrol;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_clear = 0;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_combat = % vh_tromeo_front_exit_combat_idle;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_combat_clear = 0;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_combat_run = % vh_tromeo_front_exit_combat_run;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_combat_run_clear = 0;
  _id_E4B7E99A96C8829F[2].vehicle_getoutanim = % reb_com_veh8_techo_br_door_open;
  _id_E4B7E99A96C8829F[2].vehicle_getoutanim_clear = 0;
  _id_E4B7E99A96C8829F[3].vehicle_getoutanim = % reb_com_veh8_techo_bl_door_open;
  _id_E4B7E99A96C8829F[3].vehicle_getoutanim_clear = 0;
  _id_E4B7E99A96C8829F[0].vehicle_getinanim = % reb_com_veh8_techo_fl_door_close;
  _id_E4B7E99A96C8829F[0].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[1].vehicle_getinanim = % reb_com_veh8_techo_fr_door_close;
  _id_E4B7E99A96C8829F[1].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[2].vehicle_getinanim = % reb_com_veh8_techo_br_door_close;
  _id_E4B7E99A96C8829F[2].vehicle_getinanim_clear = 0;
  _id_E4B7E99A96C8829F[3].vehicle_getinanim = % reb_com_veh8_techo_bl_door_close;
  _id_E4B7E99A96C8829F[3].vehicle_getinanim_clear = 0;
  return _id_E4B7E99A96C8829F;
}