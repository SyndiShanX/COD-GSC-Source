/*******************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: vehicle_scripts\_80s_sedan1.gsc
*******************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::build_template("80s_sedan1", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_80s_sedan1_brn", "vehicle_80s_sedan1_brn_destroyed");
  maps\_vehicle::build_deathmodel("vehicle_80s_sedan1_green", "vehicle_80s_sedan1_green_destroyed");
  maps\_vehicle::build_deathmodel("vehicle_80s_sedan1_red", "vehicle_80s_sedan1_red_destroyed");
  maps\_vehicle::build_deathmodel("vehicle_80s_sedan1_silv", "vehicle_80s_sedan1_silv_destroyed");
  maps\_vehicle::build_deathmodel("vehicle_80s_sedan1_tan", "vehicle_80s_sedan1_tan_destroyed");
  maps\_vehicle::build_deathmodel("vehicle_80s_sedan1_yel", "vehicle_80s_sedan1_yel_destroyed");
  maps\_vehicle::build_destructible("vehicle_80s_sedan1_brn_destructible", "vehicle_80s_sedan1_brn");
  maps\_vehicle::build_destructible("vehicle_80s_sedan1_green_destructible", "vehicle_80s_sedan1_green");
  maps\_vehicle::build_destructible("vehicle_80s_sedan1_red_destructible", "vehicle_80s_sedan1_red");
  maps\_vehicle::build_destructible("vehicle_80s_sedan1_silv_destructible", "vehicle_80s_sedan1_silv");
  maps\_vehicle::build_destructible("vehicle_80s_sedan1_tan_destructible", "vehicle_80s_sedan1_tan");
  maps\_vehicle::build_destructible("vehicle_80s_sedan1_yel_destructible", "vehicle_80s_sedan1_yel");
  maps\_vehicle::build_drive( % technical_driving_idle_forward, % technical_driving_idle_backward, 10);
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