/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_market_garden_aud.gsc
*********************************************/

func_00F9() {
  func_5C22();
}

func_5C22() {
  thread func_35E1();
  thread mp_market_garden_radio_static_1();
  thread mp_market_garden_radio_static_2();
  thread mp_market_garden_toilet_1();
  thread mp_market_garden_toilet_2();
  thread mp_market_garden_elevator();
}

func_35E1() {
  wait(0.5);
  lib_0380::func_6842("emt_mp_house_fire_crackle_lrg_lp", undefined, (-1656, 158, 577));
  lib_0380::func_6842("emt_mp_house_fire_crackle_lrg_lp", undefined, (-951, -1322, 623));
  lib_0380::func_6842("emt_mp_house_fire_crackle_lrg_lp", undefined, (930, -1851, 543));
  lib_0380::func_6842("emt_mp_house_fire_crackle_lrg_lp", undefined, (-240, -462, 693));
  lib_0380::func_6842("emt_mp_house_fire_crackle_lrg_lp", undefined, (-663, 700, 610));
  lib_0380::func_6842("emt_mp_house_fire_crackle_lrg_lp", undefined, (1304, 522, 654));
  lib_0380::func_6842("emt_mp_house_fire_crackle_lrg_lp", undefined, (1955, -1214, 677));
  lib_0380::func_6842("emt_mp_house_fire_crackle_lrg_lp", undefined, (1240, -2070, 567));
  lib_0380::func_6842("emt_mp_house_fire_brush", undefined, (-516, -1200, 547));
  lib_0380::func_6842("emt_mp_house_fire_brush", undefined, (140, -1658, 544));
  lib_0380::func_6842("emt_mp_house_fire_brush", undefined, (697, -2193, 531));
  lib_0380::func_6842("emt_mp_house_fire_brush", undefined, (146, -2112, 531));
  lib_0380::func_6842("emt_mp_house_debris_fire_lp", undefined, (1156, -685, 864));
  lib_0380::func_6842("emt_mp_house_debris_fire_lp", undefined, (407, -1630, 740));
  lib_0380::func_6842("emt_mp_house_debris_fire_lp", undefined, (1421, -1436, 650));
  lib_0380::func_6842("emt_mp_house_electric_light", undefined, (1504, -1347, 703));
  lib_0380::func_6842("emt_mp_house_electric_light", undefined, (1500, -25, 699));
  lib_0380::func_6842("emt_mp_house_clock_grandfather", undefined, (1328, -472, 669));
  lib_0380::func_6842("emt_mp_market_garden_fountain", undefined, (2097, -663, 636));
  lib_0380::func_6842("emt_mp_market_garden_lake", undefined, (-514, -2007, 531));
  lib_0380::func_6842("emt_mp_market_garden_lake", undefined, (253, -2372, 531));
  lib_0380::func_6842("emt_mp_market_garden_lake", undefined, (974, -2348, 505));
  lib_0380::func_6842("emt_mp_market_garden_lake", undefined, (1438, -2004, 488));
  lib_0380::func_6842("emt_mp_market_garden_lake", undefined, (2012, -1960, 494));
  lib_0380::func_6842("emt_mp_market_garden_lake", undefined, (-631, -1885, 504));
  lib_0380::func_6842("emt_mp_market_garden_lake", undefined, (-1208, -1639, 494));
  lib_0380::func_6842("emt_mp_market_garden_lake", undefined, (-2224, -334, 507));
  lib_0380::func_6842("emt_mp_market_garden_rain", undefined, (-835, 10, 732));
  lib_0380::func_6842("emt_mp_market_garden_rain", undefined, (157, -644, 769));
  lib_0380::func_6842("emt_mp_market_garden_rain", undefined, (135, -1000, 771));
  lib_0380::func_6842("emt_mp_market_garden_rain", undefined, (385, -1752, 808));
  lib_0380::func_6842("emt_mp_market_garden_sink", undefined, (-14, -298, 669));
  lib_0380::func_6842("emt_mp_market_garden_sink", undefined, (896, -184, 669));
}

mp_market_garden_radio_static_1() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_mp_house_radio_static", undefined, (1176, -1201, 666));
    wait(randomintrange(7, 10));
  }
}

mp_market_garden_radio_static_2() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_mp_house_radio_static", undefined, (1136, -618, 657));
    wait(randomintrange(7, 10));
  }
}

mp_market_garden_toilet_1() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_mp_market_garden_toilet", undefined, (642, -197, 669));
    wait(randomintrange(10, 300));
  }
}

mp_market_garden_toilet_2() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_mp_market_garden_toilet", undefined, (653, -347, 669));
    wait(randomintrange(250, 700));
  }
}

mp_market_garden_elevator() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_mp_market_garden_elevator", undefined, (867, -868, 668));
    wait(randomintrange(10, 25));
  }
}