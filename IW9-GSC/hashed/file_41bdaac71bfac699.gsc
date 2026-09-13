/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_41bdaac71bfac699.gsc
***********************************************/

main(model, type, classname) {
  scripts\common\vehicle_build::build_template("zoscar", model, type, classname);
  scripts\common\vehicle_build::build_localinit(::init_local);
  deathmodel = "veh8_mil_sea_zoscar_cine";

  if(isendstr(model, "_physics"))
    deathmodel = deathmodel + "_physics";

  scripts\common\vehicle_build::build_deathmodel(model, deathmodel);
  scripts\common\vehicle_build::build_deathfx("vfx/iw8_mp/vehicle/vfx_pickup_mp_death_exp.vfx", undefined, "veh9_dmg_generic_explode");
  scripts\common\vehicle_build::build_deathquake(1, 1.6, 500);
  scripts\common\vehicle_build::build_radiusdamage((0, 0, 0), 500, 120, 20);
  scripts\common\vehicle_build::build_drive(undefined, undefined, 5);
  scripts\common\vehicle_build::build_treadfx(classname, "water", "vfx/iw9/level/border/vfx_border_boat_wake_01.vfx");
  scripts\common\vehicle_build::build_life(2000);
  scripts\common\vehicle_build::build_team("allies");
  scripts\common\vehicle_build::build_aianims(::setanims, ::set_vehicle_anims, "zoscar");
  scripts\common\vehicle_build::build_unload_groups(::unload_groups);
}

init_local() {
  self.script_badplace = 1;
  self.vehicleanimalias = "zoscar";

  if(scripts\common\utility::iscp())
    self.vehicleanimalias = self.vehicleanimalias + "_cp";
}

#using_animtree("generic_human");

setanims() {
  _id_E4B7E99A96C8829F = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 1; _id_AC0E594AC96AA3A8++)
    _id_E4B7E99A96C8829F[_id_AC0E594AC96AA3A8] = spawnStruct();

  _id_E4B7E99A96C8829F[0].bhasgunwhileriding = 0;
  _id_E4B7E99A96C8829F[0].sittag = "TAG_SEAT_0";
  _id_E4B7E99A96C8829F[0].canshootinvehicle = 0;
  _id_E4B7E99A96C8829F[0].getin = % sdr_mp_hindia_seat00_getin;
  _id_E4B7E99A96C8829F[0].idle_anim = "sdr_mp_veh_hindia_seat_0_idle";
  _id_E4B7E99A96C8829F[0].idle = % sdr_mp_veh_hindia_seat_0_idle;
  _id_E4B7E99A96C8829F[0].getout = % sdr_com_veh8_techo_driver_out;
  _id_E4B7E99A96C8829F[0].death = % sdr_mp_veh_hindia_seat_0_death_8;
  _id_E4B7E99A96C8829F[0].death_no_ragdoll = 1;
  _id_E4B7E99A96C8829F[0].death_impulse = 0;
  return _id_E4B7E99A96C8829F;
}

unload_groups() {
  unload_groups = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 1; _id_AC0E594AC96AA3A8++)
    unload_groups["default"][_id_AC0E594AC96AA3A8] = _id_AC0E594AC96AA3A8;

  unload_groups["passengers"] = [1, 2, 3, 4, 5, 6];
  unload_groups["backseats"] = [2, 3];
  unload_groups["entirecab"] = [0, 1, 2, 3];
  return unload_groups;
}

#using_animtree("vehicles");

set_vehicle_anims(_id_E4B7E99A96C8829F) {
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim = % vh_techo_driver_exit_patrol;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_clear = 0;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_combat = % vh_techo_driver_exit_combat_idle;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_combat_clear = 0;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_combat_run = % vh_techo_driver_exit_combat_run;
  _id_E4B7E99A96C8829F[0].vehicle_getoutanim_combat_run_clear = 0;
  _id_E4B7E99A96C8829F[0].vehicle_getinanim = % reb_com_veh8_techo_fl_door_close;
  _id_E4B7E99A96C8829F[0].vehicle_getinanim_clear = 0;
  return _id_E4B7E99A96C8829F;
}