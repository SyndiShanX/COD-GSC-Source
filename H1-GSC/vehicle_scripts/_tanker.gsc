/***************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: vehicle_scripts\_tanker.gsc
***************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("tanker", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathfx("fx\explosions\large_vehicle_explosion", undefined, "explo_metal_rand");
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_drive( % tanker_truck_driving_idle_forward, % tanker_truck_driving_idle_backward, 10);
  maps\_vehicle::build_team("allies");
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
}

init_local() {}

set_vehicle_anims(var_0) {
  return var_0;
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for (var_1 = 0; var_1 < 1; var_1++)
    var_0[var_1] = spawnstruct();

  var_0[0].sittag = "tag_driver";
  var_0[0].idle = % luxurysedan_driver_idle;
  return var_0;
}