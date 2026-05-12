/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_shipment_s2_aud.gsc
*********************************************/

func_00F9() {
  func_7BD2();
  func_5C22();
}

func_7BD2() {
  lib_0378::func_8DC7("aud_truck_moving", ::beach_trucks);
}

func_5C22() {
  thread launch_emitters();
}

launch_emitters() {
  lib_0380::func_6842("emt_mp_hub_allies_fire_lrg_lp", undefined, (359, 6823, -318));
  lib_0380::func_6842("emt_mp_hub_allies_fire_roar_lp", undefined, (-1127, 6456, -318));
  lib_0380::func_6842("emt_mp_hub_allies_fire_lrg_lp_c", undefined, (-1468, 8631, -425));
  lib_0380::func_6842("emt_engine_tick_lp", undefined, (-651, 8369, -409));
  lib_0380::func_6842("emt_engine_tick_lp", undefined, (-1374, 8275, -369));
  lib_0380::func_6842("mp_ship_crane_engine_lp", undefined, (-2027, 6958, -342));
  lib_0380::func_6842("mp_ship_crane_engine_lp", undefined, (-2612, 8352, -319));
  lib_0380::func_6842("emt_mp_ship_flag_lp", undefined, (-1703, 7374, -255));
  lib_0380::func_6842("emt_mp_ship_flag_lp", undefined, (-205, 7239, -255));
  lib_0380::func_6842("emt_mp_ship_cloth_flag_lp", undefined, (-1716, 6809, -409));
  lib_0380::func_6842("emt_mp_ship_cloth_flag_lp", undefined, (-1720, 7047, -409));
  lib_0380::func_6842("emt_mp_ship_cloth_flag_lp", undefined, (-1738, 7446, -409));
  lib_0380::func_6842("emt_mp_ship_cloth_flag_lp", undefined, (-1732, 7807, -409));
  lib_0380::func_6842("emt_mp_ship_cloth_flag_lp", undefined, (-1631, 8028, -409));
  lib_0380::func_6842("emt_mp_ship_cloth_flag_lp", undefined, (-1197, 8018, -409));
  lib_0380::func_6842("emt_mp_ship_cloth_flag_lp", undefined, (-397, 8029, -409));
}

beach_trucks() {
  var_00 = self;
  var_01 = lib_0380::func_6846("mp_hub_allies_truck_engine_lp", undefined, var_00, 1, undefined, 1);
}