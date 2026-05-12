/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_egypt_02_aud.gsc
*********************************************/

func_00F9() {
  func_5C22();
}

func_5C22() {
  thread func_35E1();
}

func_35E1() {
  wait(0.5);
  lib_0380::func_6842("wreckage_fire_metal_med", undefined, (-1492, 949, 357));
  lib_0380::func_6842("wreckage_fire_metal_large", undefined, (294, 2787, 259));
  lib_0380::func_6842("wreckage_fire_metal_large", undefined, (-1307, -2471, 314));
  lib_0380::func_6842("wreckage_fire_metal_large", undefined, (-1682, -1483, 314));
  lib_0380::func_6842("mp_egypt_fire_good_sml_lp", undefined, (583, 2545, 185));
  lib_0380::func_6842("mp_egypt_fire_good_sml_lp", undefined, (516, 2165, 171));
  lib_0380::func_6842("mp_egypt_tree_bark_fire", undefined, (1599, 650, 88));
  lib_0380::func_6842("mp_egypt_fire_good_med_lp", undefined, (1207, -2490, 62));
  lib_0380::func_6842("mp_egypt_fire_good_med_lp", undefined, (-1206, -2514, 288));
  lib_0380::func_6842("mp_egypt_fire_good_sml_lp", undefined, (-471, 15, 266));
  lib_0380::func_6842("mp_egypt_fire_good_sml_lp", undefined, (-355, -139, 266));
  lib_0380::func_6842("mp_egypt_fire_good_sml_lp", undefined, (-473, -294, 266));
  lib_0380::func_6842("mp_egypt_fire_good_sml_lp", undefined, (-525, -405, 282));
  lib_0380::func_6842("mp_egypt_fire_good_sml_lp", undefined, (-686, 29, 282));
  lib_0380::func_6842("mp_egypt_fire_good_sml_lp", undefined, (-687, -319, 282));
  lib_0380::func_6842("mp_egypt_fire_good_sml_lp", undefined, (-741, -184, 282));
  lib_0380::func_6842("mp_egypt_fire_good_sml_lp", undefined, (-740, -104, 282));
  lib_0380::func_6842("mp_egypt_fire_good_sml_lp", undefined, (-894, -319, 282));
  lib_0380::func_6842("mp_egypt_fire_good_sml_lp", undefined, (-895, 29, 282));
  lib_0380::func_6842("mp_egypt_fire_good_sml_lp", undefined, (-1042, -183, 282));
  lib_0380::func_6842("mp_egypt_fire_good_sml_lp", undefined, (-1042, -101, 282));
  lib_0380::func_6842("mp_egypt_fire_good_sml_lp", undefined, (-1041, 154, 282));
  lib_0380::func_6842("emt_mp_egypt_combat_gas_generator_lp", undefined, (-203, 2263, 207));
  lib_0380::func_6842("emt_mp_egypt_combat_gas_generator_lp", undefined, (-715, -357, 393));
  lib_0380::func_6842("emt_mp_egypt_combat_gas_generator_lp", undefined, (351, 830, 201));
  lib_0380::func_6842("emt_mp_egypt_combat_gas_generator_lp", undefined, (1430, -1333, 115));
  lib_0380::func_6842("emt_mp_egypt_combat_gas_generator_lp", undefined, (-479, -2529, 262));
  lib_0380::func_6842("mp_egypt_panzer_tank_tread_lp", undefined, (903, 2654, 234));
  thread fire_metal_stress_handlers();
}

fire_metal_stress_handlers() {
  thread tank_on_fire();
  thread truck_on_fire_next_to_scaffolding();
}

tank_on_fire() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("mp_egypt_fire_mtl_stress", undefined, (294, 2787, 259));
    wait(randomintrange(7, 12));
  }
}

truck_on_fire_next_to_scaffolding() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("mp_egypt_fire_mtl_stress", undefined, (-1307, -2471, 314));
    wait(randomintrange(7, 12));
  }
}