/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\18791.gsc
**************************************/

main(var_0, var_1, var_2, var_3) {
  maps\_vehicle::build_template("super_dvora", var_0, var_1, var_2);
  maps\_vehicle::build_localinit(::init_local);
  maps\_vehicle::build_deathmodel("vehicle_russian_super_dvora_mark2");
  maps\_vehicle::build_life(999, 500, 1500);
  maps\_vehicle::build_team("axis");

  if(isDefined(var_3)) {
    var_4 = "weapon_m2_50cal_dshkVersion";
    maps\_vehicle::build_turret(var_3, "tag_turret", var_4, undefined, "auto_ai", 0.5, 20, -14);
    maps\_vehicle::build_turret(var_3, "tag_turret2", var_4, undefined, "auto_ai", 0.5, 20, -14);
  }

  maps\_vehicle::build_aianims(::setanims, ::set_vehicle_anims);
}

#using_animtree("generic_human");

setanims() {
  var_0 = [];

  for(var_1 = 0; var_1 < 4; var_1++) {
    var_0[var_1] = spawnStruct();
  }
  var_0[0].sittag = "tag_guy";
  var_0[1].sittag = "tag_guy2";
  var_0[2].sittag = "tag_guy3";
  var_0[3].sittag = "tag_guy4";
  var_0[0].unload_ondeath = 0.9;
  var_0[1].unload_ondeath = 0.9;
  var_0[2].unload_ondeath = 0.9;
  var_0[3].unload_ondeath = 0.9;
  var_0[3].getout = % technical_driver_climb_out;
  var_0[2].getout = % technical_passenger_climb_out;
  var_0[0].mgturret = 0;
  var_0[1].mgturret = 1;
  return var_0;
}

set_vehicle_anims(var_0) {
  return var_0;
}

init_local() {}