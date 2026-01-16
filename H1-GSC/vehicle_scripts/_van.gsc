/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: vehicle_scripts\_van.gsc
********************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("van", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_uaz_van", "vehicle_uaz_van");
  maps\_vehicle::build_radiusdamage((0, 0, 32), 300, 200, 100, 0);
  maps\_vehicle::build_drive( % uaz_driving_idle_forward, % uaz_driving_idle_backward, 10);
  maps\_vehicle::build_deathquake(1, 1.6, 500);
  maps\_vehicle::build_treadfx();
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("axis");
  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
}

init_local() {}

set_vehicle_anims(var_0) {
  return var_0;
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for (var_1 = 0; var_1 < 2; var_1++)
    var_0[var_1] = spawnstruct();

  var_0[0].sittag = "tag_driver";
  var_0[1].sittag = "tag_passenger";
  var_0[0].idle = % uaz_driver_idle_drive;
  var_0[1].idle = % uaz_passenger_idle_drive;
  return var_0;
}