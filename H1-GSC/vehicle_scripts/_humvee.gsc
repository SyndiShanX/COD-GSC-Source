/***************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: vehicle_scripts\_humvee.gsc
***************************************/

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("humvee", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_humvee_camo");
  maps\_vehicle::build_deathmodel("vehicle_humvee_camo_50cal_doors");
  maps\_vehicle::build_deathmodel("vehicle_humvee_camo_50cal_nodoors");
  maps\_vehicle::build_deathfx("fx\explosions\large_vehicle_explosion", undefined, "car_explode");
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("allies");
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
}

init_local() {}

#using_animtree("vehicles");

set_vehicle_anims(var_0) {
  var_0[0].vehicle_getoutanim = % uaz_driver_exit_into_run_door;
  var_0[1].vehicle_getoutanim = % uaz_rear_driver_exit_into_run_door;
  var_0[2].vehicle_getoutanim = % uaz_passenger_exit_into_run_door;
  var_0[3].vehicle_getoutanim = % uaz_passenger2_exit_into_run_door;
  var_0[0].vehicle_getinanim = % uaz_driver_enter_from_huntedrun_door;
  var_0[1].vehicle_getinanim = % uaz_rear_driver_enter_from_huntedrun_door;
  var_0[2].vehicle_getinanim = % uaz_passenger_enter_from_huntedrun_door;
  var_0[3].vehicle_getinanim = % uaz_passenger2_enter_from_huntedrun_door;
  return var_0;
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for (var_1 = 0; var_1 < 4; var_1++)
    var_0[var_1] = spawnstruct();

  var_0[0].sittag = "body_animate_jnt";
  var_0[1].sittag = "body_animate_jnt";
  var_0[2].sittag = "tag_passenger";
  var_0[3].sittag = "body_animate_jnt";
  var_0[0].idle = % humvee_driver_climb_idle;
  var_0[1].idle = % humvee_passenger_idle_l;
  var_0[2].idle = % humvee_passenger_idle_r;
  var_0[3].idle = % humvee_passenger_idle_r;
  var_0[0].getout = % humvee_driver_climb_out;
  var_0[1].getout = % humvee_passenger_out_l;
  var_0[2].getout = % humvee_passenger_out_r;
  var_0[3].getout = % humvee_passenger_out_r;
  var_0[0].getin = % humvee_driver_climb_in;
  var_0[1].getin = % humvee_passenger_in_l;
  var_0[2].getin = % humvee_passenger_in_r;
  var_0[3].getin = % humvee_passenger_in_r;
  return var_0;
}