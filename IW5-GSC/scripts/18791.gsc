/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\18791.gsc
**************************************/

main(var_0, var_1, var_2, var_3) {
  maps\_vehicle::_id_2AC2("super_dvora", var_0, var_1, var_2);
  maps\_vehicle::_id_2AD2(::_id_2B1D);
  maps\_vehicle::_id_2ABE("vehicle_russian_super_dvora_mark2");
  maps\_vehicle::_id_2ACE(999, 500, 1500);
  maps\_vehicle::_id_2AC6("axis");

  if(isDefined(var_3)) {
    var_4 = "weapon_m2_50cal_dshkVersion";
    maps\_vehicle::_id_2A4A(var_3, "tag_turret", var_4, undefined, "auto_ai", 0.5, 20, -14);
    maps\_vehicle::_id_2A4A(var_3, "tag_turret2", var_4, undefined, "auto_ai", 0.5, 20, -14);
  }

  maps\_vehicle::_id_2ACA(::_id_3A9D, ::_id_3A9C);
}

#using_animtree("generic_human");

_id_3A9D() {
  var_0 = [];

  for(var_1 = 0; var_1 < 4; var_1++) {
    var_0[var_1] = spawnStruct();
  }
  var_0[0]._id_24F2 = "tag_guy";
  var_0[1]._id_24F2 = "tag_guy2";
  var_0[2]._id_24F2 = "tag_guy3";
  var_0[3]._id_24F2 = "tag_guy4";
  var_0[0]._id_2598 = 0.9;
  var_0[1]._id_2598 = 0.9;
  var_0[2]._id_2598 = 0.9;
  var_0[3]._id_2598 = 0.9;
  var_0[3]._id_257C = % technical_driver_climb_out;
  var_0[2]._id_257C = % technical_passenger_climb_out;
  var_0[0].mgturret = 0;
  var_0[1].mgturret = 1;
  return var_0;
}

_id_3A9C(var_0) {
  return var_0;
}

_id_2B1D() {}