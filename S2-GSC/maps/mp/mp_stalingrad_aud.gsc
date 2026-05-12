/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_stalingrad_aud.gsc
*********************************************/

func_00F9() {
  func_5C22();
}

func_5C22() {
  thread func_35E1();
}

func_35E1() {
  wait(0.5);
  lib_0380::func_6842("wreckage_fire_metal_large", undefined, (-657, 1958, 188));
  lib_0380::func_6842("mp_stalingrad_fire_good_sml_lp", undefined, (-131, 1202, 289));
  lib_0380::func_6842("mp_stalingrad_fire_good_med_lp", undefined, (1249, 1495, 134));
  lib_0380::func_6842("mp_stalingrad_fire_good_sml_lp", undefined, (709, 467, 60));
  lib_0380::func_6842("wreckage_fire_metal_med", undefined, (142, -39, 129));
  lib_0380::func_6842("wreckage_fire_metal_large", undefined, (-534, -689, 129));
  lib_0380::func_6842("wreckage_fire_metal_med", undefined, (-1121, -1035, -12));
  lib_0380::func_6842("wreckage_fire_metal_large", undefined, (-1097, -1307, 78));
  lib_0380::func_6842("mp_stalingrad_tree_bark_fire", undefined, (-341, -1235, 78));
  lib_0380::func_6842("mp_stalingrad_fire_good_sml_lp", undefined, (1224, -653, 178));
  lib_0380::func_6842("mp_stalingrad_tree_bark_fire", undefined, (541, -1794, 170));
  lib_0380::func_6842("wreckage_fire_metal_large", undefined, (144, -2018, 120));
  lib_0380::func_6842("mp_stalingrad_fire_good_med_lp", undefined, (217, -2302, 120));
  lib_0380::func_6842("wreckage_fire_metal_med", undefined, (-423, -2004, 84));
  lib_0380::func_6842("mp_stalingrad_water_ground_drip_lp", undefined, (140, 2033, 147));
  lib_0380::func_6842("mp_stalingrad_drips_cement_splatty_lp", undefined, (139, 1942, 138));
  lib_0380::func_6842("mp_stalingrad_wtr_dry_concrete_drip_lp", undefined, (-250, 1794, 137));
  lib_0380::func_6842("mp_stalingrad_drips_cement_splatty_lp", undefined, (780, 1639, 136));
  lib_0380::func_6842("mp_stalingrad_water_ground_drip_lp", undefined, (784, 1356, 158));
  lib_0380::func_6842("mp_stalingrad_drips_cement_splatty_lp", undefined, (1176, 1318, 16));
  lib_0380::func_6842("mp_stalingrad_wtr_dry_concrete_drip_lp", undefined, (-296, 1527, 137));
  lib_0380::func_6842("mp_stalingrad_wtr_dry_concrete_drip_lp", undefined, (73, -144, 1));
  lib_0380::func_6842("mp_stalingrad_water_ground_drip_lp", undefined, (98, 122, 12));
  lib_0380::func_6842("mp_stalingrad_drips_cement_splatty_lp", undefined, (-1184, -1178, -125));
  lib_0380::func_6842("mp_stalingrad_drips_cement_splatty_lp", undefined, (-1014, -209, -140));
  lib_0380::func_6842("mp_stalingrad_water_ground_drip_lp", undefined, (-871, -245, -140));
  lib_0380::func_6842("mp_stalingrad_drips_cement_splatty_lp", undefined, (-925, 454, -140));
  thread fire_metal_stress_handlers();
}

fire_metal_stress_handlers() {
  thread warehouse_cannister();
  thread truck_on_fire_next_to_scaffolding();
  thread destroyed_truck_by_sewer_entrance();
  thread snowed_in_truck_by_wood_beam();
  thread warehouse_tank_rubble();
}

warehouse_cannister() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("mp_stalingrad_fire_mtl_stress", undefined, (-657, 1958, 188));
    wait(randomintrange(7, 12));
  }
}

truck_on_fire_next_to_scaffolding() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("mp_stalingrad_fire_mtl_stress", undefined, (-534, -689, 129));
    wait(randomintrange(7, 12));
  }
}

destroyed_truck_by_sewer_entrance() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("mp_stalingrad_fire_mtl_stress", undefined, (-1097, -1307, 78));
    wait(randomintrange(7, 12));
  }
}

snowed_in_truck_by_wood_beam() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("mp_stalingrad_fire_mtl_stress", undefined, (-341, -1235, 78));
    wait(randomintrange(7, 12));
  }
}

warehouse_tank_rubble() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("mp_stalingrad_fire_mtl_stress", undefined, (144, -2018, 120));
    wait(randomintrange(7, 12));
  }
}