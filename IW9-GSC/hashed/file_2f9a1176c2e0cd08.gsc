/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2f9a1176c2e0cd08.gsc
***********************************************/

main(model, type, classname) {
  scripts\common\vehicle_build::build_template("atv", model, type, classname);
  scripts\common\vehicle_build::build_localinit(::init_local);
  scripts\common\vehicle_build::build_life(1000);
  scripts\common\vehicle_build::build_aianims(::setanims, ::set_vehicle_anims, "techo");
  scripts\common\vehicle_build::build_unload_groups(::unload_groups);
  scripts\common\vehicle_build::_id_98128821320ABA35(model, "veh8_mil_lnd_atango_physics", "veh9_atango_new_physics_sp");
}

#using_animtree("vehicles");

init_local() {
  if(scripts\common\utility::issp())
    self useanimtree(#animtree);

  self.script_badplace = 1;
  self.vehicleanimalias = "techo";
}

set_vehicle_anims(_id_E4B7E99A96C8829F) {
  _id_E4B7E99A96C8829F[0].vehicle_getinanim = % reb_com_veh8_techo_fl_door_close;
  _id_E4B7E99A96C8829F[1].vehicle_getinanim = % reb_com_veh8_techo_fr_door_close;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim = % vh_techo_driver_exit_patrol;
  _id_E4B7E99A96C8829F[1].vehicle_getoutanim = % vh_techo_pass_exit_patrol;
  return _id_E4B7E99A96C8829F;
}

setanims() {
  _id_E4B7E99A96C8829F = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 2; _id_AC0E594AC96AA3A8++)
    _id_E4B7E99A96C8829F[_id_AC0E594AC96AA3A8] = spawnStruct();

  _id_E4B7E99A96C8829F[0].bhasgunwhileriding = 0;
  _id_E4B7E99A96C8829F[0].sittag = "TAG_DRIVER";
  _id_E4B7E99A96C8829F[1].sittag = "TAG_PASSENGER";
  _id_E4B7E99A96C8829F[0].death_no_ragdoll = 0;
  _id_E4B7E99A96C8829F[1].death_no_ragdoll = 0;
  _id_E4B7E99A96C8829F[0].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[1].canshootinvehicle = 0;
  return _id_E4B7E99A96C8829F;
}

unload_groups() {
  unload_groups = [];
  unload_groups["driver"] = [0];
  unload_groups["all"] = [0, 1];
  unload_groups["passengers"] = [1];
  unload_groups["default"] = unload_groups["all"];
  return unload_groups;
}