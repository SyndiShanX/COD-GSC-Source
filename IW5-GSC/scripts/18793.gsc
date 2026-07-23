/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\18793.gsc
**************************************/

main(var_0, var_1, var_2) {
  maps\_vehicle::_id_2AC2("zodiac_player", var_0, var_1, var_2);
  maps\_vehicle::_id_2AD2(::_id_2B1D);

  if(var_0 != "vehicle_zodiac_boat") {
    maps\_vehicle::_id_2ABE("vehicle_zodiac_viewmodel");
  } else {
    maps\_vehicle::_id_2ABE(var_0);
  }
  maps\_vehicle::_id_2ACE(999, 500, 1500);
  maps\_vehicle::_id_2AC6("allies");
  maps\_vehicle::_id_2ACA(::_id_3A9D, ::_id_3A9C);
}

_id_2B1D() {}

_id_3A9C(var_0) {
  return var_0;
}

#using_animtree("generic_human");

_id_3A9D() {
  var_0 = [];

  for(var_1 = 0; var_1 < 6; var_1++) {
    var_0[var_1] = spawnStruct();
  }
  var_0[0]._id_24F2 = "tag_body";
  var_0[1]._id_24F2 = "tag_body";
  var_0[2]._id_24F2 = "tag_body";
  var_0[3]._id_24F2 = "tag_body";
  var_0[4]._id_24F2 = "tag_body";
  var_0[5]._id_24F2 = "tag_body";
  var_0[0]._id_0F59 = % oilrig_civ_escape_1_seal_a;
  var_0[1]._id_0F59 = % oilrig_civ_escape_2_seal_a;
  var_0[2]._id_0F59 = % oilrig_civ_escape_3_a;
  var_0[3]._id_0F59 = % oilrig_civ_escape_4_a;
  var_0[4]._id_0F59 = % oilrig_civ_escape_5_a;
  var_0[5]._id_0F59 = % oilrig_civ_escape_6_a;
  var_0[0]._id_257C = % pickup_driver_climb_out;
  var_0[1]._id_257C = % pickup_driver_climb_out;
  var_0[2]._id_257C = % pickup_driver_climb_out;
  var_0[3]._id_257C = % pickup_driver_climb_out;
  var_0[4]._id_257C = % pickup_driver_climb_out;
  var_0[5]._id_257C = % pickup_driver_climb_out;
  return var_0;
}