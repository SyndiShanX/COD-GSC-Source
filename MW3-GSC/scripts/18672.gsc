/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\18672.gsc
**************************************/

#using_animtree("vehicles");

main(var_0, var_1, var_2) {
  maps\_vehicle::_id_2AC2("80s_hatch1", var_0, var_1, var_2);
  maps\_vehicle::_id_2AD2(::_id_2B1D);
  maps\_vehicle::_id_2AD0("vehicle_80s_hatch1_brn_destructible_mp", "vehicle_80s_hatch1_brn");
  maps\_vehicle::_id_2AD0("vehicle_80s_hatch1_green_destructible_mp", "vehicle_80s_hatch1_green");
  maps\_vehicle::_id_2AD0("vehicle_80s_hatch1_red_destructible_mp", "vehicle_80s_hatch1_red");
  maps\_vehicle::_id_2AD0("vehicle_80s_hatch1_silv_destructible_mp", "vehicle_80s_hatch1_silv");
  maps\_vehicle::_id_2AD0("vehicle_80s_hatch1_tan_destructible_mp", "vehicle_80s_hatch1_tan");
  maps\_vehicle::_id_2AD0("vehicle_80s_hatch1_yel_destructible_mp", "vehicle_80s_hatch1_yel");
  maps\_vehicle::_id_2AC1(%technical_driving_idle_forward, %technical_driving_idle_backward, 10);
  maps\_vehicle::_id_2ACE(999, 500, 1500);
  maps\_vehicle::_id_2AC6("allies");
  maps\_vehicle::_id_2ACA(::_id_3A9D, ::_id_3A9C);
}

_id_2B1D() {}

_id_3A9C(var_0) {
  return var_0;
}

_id_3A9D() {
  var_0 = [];
  return var_0;
  return var_0;
}