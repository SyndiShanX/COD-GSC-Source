/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_v2_rocket_02_aud.gsc
*********************************************/

func_00F9() {
  func_7BBA();
  func_5C22();
}

func_7BBA() {
  lib_0378::func_8DC7("aud_mp_rocket_facility_truck_drive", ::mp_rocket_facility_truck_drive);
  lib_0378::func_8DC7("aud_v2_rocket_engine_fire_start", ::v2_rocket_engine_fire_start);
  lib_0378::func_8DC7("aud_v2_rocket_siren_start", ::v2_rocket_siren_start);
}

func_5C22() {
  thread func_35E1();
}

func_35E1() {
  wait(0.5);
  lib_0380::func_6842("wreckage_fire_metal_large", undefined, (1540, 1114, 357));
  lib_0380::func_6842("wreckage_fire_metal_large", undefined, (1230, 2603, 327));
  lib_0380::func_6842("wreckage_fire_metal_med", undefined, (-150, 2654, 321));
  lib_0380::func_6842("wreckage_fire_wood_med", undefined, (1607, 1409, 332));
  lib_0380::func_6842("wreckage_fire_wood_med", undefined, (1233, 1788, 303));
  thread fire_metal_textures();
  thread foliage_one_shots();
  lib_0380::func_6842("mp_rf_engine_lp", undefined, (-1712, 67, 426));
  lib_0380::func_6842("mp_rf_engine_lp", undefined, (-1409, 737, 328));
  lib_0380::func_6842("mp_rf_wind_net_lp", undefined, (-481, 2110, 400));
  lib_0380::func_6842("mp_rf_wind_net_lp", undefined, (208, 1658, 465));
  lib_0380::func_6842("mp_rf_wind_net_lp", undefined, (-210, 1562, 465));
  lib_0380::func_6842("mp_rf_wind_net_lp", undefined, (342, -487, 449));
}

fire_metal_textures() {
  thread burning_rubble_behind_warehouse_glass();
  thread burning_rocket_on_hill_slope();
  thread burning_rubble_on_hill_edge();
}

burning_rubble_behind_warehouse_glass() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("mp_rf_fire_mtl_stress", undefined, (1540, 1114, 357));
    wait(randomintrange(7, 12));
  }
}

burning_rocket_on_hill_slope() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("mp_rf_fire_mtl_stress", undefined, (1230, 2603, 327));
    wait(randomintrange(7, 12));
  }
}

burning_rubble_on_hill_edge() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("mp_rf_fire_mtl_stress", undefined, (-150, 2654, 321));
    wait(randomintrange(7, 12));
  }
}

foliage_one_shots() {
  thread tree_next_to_rocket_warehouse();
  thread tree_behind_fence_and_shed();
  thread bush_behind_fence();
}

tree_next_to_rocket_warehouse() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("mp_rf_long_foliage_gust", undefined, (-2266, 104, 564), 3);
    wait(randomintrange(10, 18));
  }
}

tree_behind_fence_and_shed() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("mp_rf_long_foliage_gust", undefined, (-1065, -938, 552), 3);
    wait(randomintrange(10, 18));
  }
}

bush_behind_fence() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("mp_rf_leafy_bushes", undefined, (-1625, -722, 412), 2);
    wait(randomintrange(8, 15));
  }
}

mp_rocket_facility_truck_drive() {
  if(isDefined(self)) {
    var_00 = self;
    lib_0380::func_6846("mp_rf_allies_truck_engine_lp_dist", undefined, var_00, 1.5, 1, 3);
  }
}

v2_rocket_engine_fire_start() {
  var_00 = (-406, 756, 421);
  lib_0380::func_2889("mp_v2_test_fire_steam", undefined, var_00);
  lib_0380::func_2889("mp_v2_test_fire", undefined, var_00);
  lib_0380::func_2889("mp_v2_test_fire_trans", undefined, var_00);
  lib_0380::func_2889("mp_v2_test_fire_blast", undefined, var_00);
  lib_0380::func_2889("mp_v2_test_fire_low", undefined, var_00);
}

v2_rocket_siren_start(param_00) {
  lib_0380::func_2889("mp_ks_air_raid_siren", undefined, param_00);
}