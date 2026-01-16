/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: vehicle_scripts\_bus.gsc
********************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("bus", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_destructible("vehicle_bus_destructable", "vehicle_bus_destructible");
  maps\_vehicle::build_drive( % bus_driving_idle_forward, % bus_driving_idle_backward, 10);
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_life(999, 500, 1500);
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