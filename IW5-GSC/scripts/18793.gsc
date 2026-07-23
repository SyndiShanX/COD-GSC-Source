/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\18793.gsc
**************************************/

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("zodiac_player", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);

  if(var_0 != "vehicle_zodiac_boat") {
    maps\_vehicle::build_deathmodel("vehicle_zodiac_viewmodel");
  } else {
    maps\_vehicle::build_deathmodel(var_0);
  }
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

  for(var_1 = 0; var_1 < 6; var_1++) {
    var_0[var_1] = spawnStruct();
  }
  var_0[0].sittag = "tag_body";
  var_0[1].sittag = "tag_body";
  var_0[2].sittag = "tag_body";
  var_0[3].sittag = "tag_body";
  var_0[4].sittag = "tag_body";
  var_0[5].sittag = "tag_body";
  var_0[0].idle = % oilrig_civ_escape_1_seal_a;
  var_0[1].idle = % oilrig_civ_escape_2_seal_a;
  var_0[2].idle = % oilrig_civ_escape_3_a;
  var_0[3].idle = % oilrig_civ_escape_4_a;
  var_0[4].idle = % oilrig_civ_escape_5_a;
  var_0[5].idle = % oilrig_civ_escape_6_a;
  var_0[0].getout = % pickup_driver_climb_out;
  var_0[1].getout = % pickup_driver_climb_out;
  var_0[2].getout = % pickup_driver_climb_out;
  var_0[3].getout = % pickup_driver_climb_out;
  var_0[4].getout = % pickup_driver_climb_out;
  var_0[5].getout = % pickup_driver_climb_out;
  return var_0;
}