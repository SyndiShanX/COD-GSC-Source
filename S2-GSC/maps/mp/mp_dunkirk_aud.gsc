/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_dunkirk_aud.gsc
*********************************************/

func_00F9() {
  func_5C22();
}

func_5C22() {
  thread func_35E1();
}

func_35E1() {
  wait(0.5);
  lib_0380::func_6842("mp_dun_water_ground_drip_lp", undefined, (-2242, -681, 14));
  lib_0380::func_6842("mp_dun_water_ground_drip_lp", undefined, (-7, -905, 64));
  lib_0380::func_6842("mp_dun_water_ground_drip_lp", undefined, (1499, -1213, 60));
  lib_0380::func_6842("mp_dun_drips_cement_splatty_lp", undefined, (-2425, -443, 5));
  lib_0380::func_6842("mp_dun_drips_cement_splatty_lp", undefined, (-1079, -473, 12));
  lib_0380::func_6842("mp_dun_drips_cement_splatty_lp", undefined, (294, -459, 16));
  lib_0380::func_6842("mp_dun_drips_cement_splatty_lp", undefined, (1756, -474, 44));
  lib_0380::func_6842("mp_dun_wtr_dry_concrete_drip_lp", undefined, (-1744, -507, 143));
  lib_0380::func_6842("mp_dun_wtr_dry_concrete_drip_lp", undefined, (286, 114, 157));
  lib_0380::func_6842("mp_dun_wtr_dry_sml_drip_lp", undefined, (-284, -261, 179));
  lib_0380::func_6842("mp_dun_metal_roof_rain_lp", undefined, (1863, -1209, 340));
  lib_0380::func_6842("mp_dun_metal_roof_rain_lp", undefined, (1596, -1832, 268));
  lib_0380::func_6842("mp_dun_metal_roof_rain_lp", undefined, (-1549, -1010, 339));
  lib_0380::func_6842("mp_dun_rain_barrel_lp", undefined, (-2480, -777, 58));
  lib_0380::func_6842("mp_dun_rain_barrel_lp", undefined, (-1288, -465, 61));
  lib_0380::func_6842("mp_dun_rain_barrel_lp", undefined, (-1906, -617, 58));
  lib_0380::func_6842("mp_dun_rain_barrel_lp", undefined, (-1058, -810, 58));
  lib_0380::func_6842("mp_dun_rain_barrel_lp", undefined, (598, -686, 58));
  lib_0380::func_6842("mp_dun_rain_barrel_lp", undefined, (1002, -806, 58));
  lib_0380::func_6842("mp_dun_rain_barrel_lp", undefined, (-302, -2047, -74));
  lib_0380::func_6842("mp_dun_rain_wood_bridge_lp", undefined, (-1777, -1184, 77));
  lib_0380::func_6842("mp_dun_rain_wood_bridge_lp", undefined, (-1767, -1536, 35));
  lib_0380::func_6842("mp_dun_rain_wood_bridge_lp", undefined, (-1772, -1836, 5));
  lib_0380::func_6842("mp_dun_rain_wood_bridge_lp", undefined, (8, -1557, 96));
  lib_0380::func_6842("mp_dun_rain_wood_bridge_lp", undefined, (1382, -1817, 13));
  lib_0380::func_6842("mp_dun_wtr_dry_concrete_drip_lp", undefined, (2459, -387, 24));
  lib_0380::func_6842("mp_dun_wtr_dry_concrete_drip_lp", undefined, (953, -494, 16));
  lib_0380::func_6842("mp_dun_wtr_dry_concrete_drip_lp", undefined, (-998, -85, 43));
  lib_0380::func_6842("mp_dun_wtr_dry_concrete_drip_lp", undefined, (-2706, -375, 1));
  thread ocean_wave_handlers();
  lib_0380::func_6842("wreckage_fire_metal_large", undefined, (2666, -500, 58));
  lib_0380::func_6842("wreckage_fire_metal_med", undefined, (1302, -2171, -88));
  lib_0380::func_6842("wreckage_fire_metal_med", undefined, (1926, 474, 130));
  lib_0380::func_6842("wreckage_fire_metal_large", undefined, (-1295, 421, 63));
  lib_0380::func_6842("wreckage_fire_metal_med", undefined, (-1456, 407, 63));
  lib_0380::func_6842("wreckage_fire_wood_med", undefined, (-1107, 355, 134));
  lib_0380::func_6842("wreckage_fire_metal_med", undefined, (-2363, -2224, -91));
  lib_0380::func_6842("wreckage_fire_metal_large", undefined, (-2999, -670, 62));
  thread fire_metal_textures();
}

ocean_wave_handlers() {
  thread pier_side_ocean_waves();
  thread ferry_building_side_ocean_waves();
}

pier_side_ocean_waves() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("mp_dun_dist_ocean_waves", undefined, (-1854, -4034, -60), 2);
    wait(randomintrange(10, 18));
  }
}

ferry_building_side_ocean_waves() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("mp_dun_dist_ocean_waves", undefined, (874, -4085, -116), 2);
    wait(randomintrange(10, 18));
  }
}

fire_metal_textures() {
  thread burning_truck_outside_post_office();
  thread burning_airplane_on_the_beach();
  thread burning_tank_outside_wood_shed();
  thread burning_tank_between_fashion_shop_and_apt();
  thread burning_car_on_beach();
  thread burning_pile_of_truck_outside_fashion_shop();
}

burning_truck_outside_post_office() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("mp_dun_fire_mtl_stress", undefined, (2666, -500, 58));
    wait(randomintrange(7, 12));
  }
}

burning_airplane_on_the_beach() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("mp_dun_fire_mtl_stress", undefined, (1302, -2171, -88));
    wait(randomintrange(7, 12));
  }
}

burning_tank_outside_wood_shed() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("mp_dun_fire_mtl_stress", undefined, (1885, 472, 128));
    wait(randomintrange(17, 22));
  }
}

burning_tank_between_fashion_shop_and_apt() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("mp_dun_fire_mtl_stress", undefined, (-1362, 396, 104));
    wait(randomintrange(7, 12));
  }
}

burning_car_on_beach() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("mp_dun_fire_mtl_stress", undefined, (-2363, -2224, -91));
    wait(randomintrange(7, 12));
  }
}

burning_pile_of_truck_outside_fashion_shop() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("mp_dun_fire_mtl_stress", undefined, (-2999, -670, 62));
    wait(randomintrange(7, 12));
  }
}