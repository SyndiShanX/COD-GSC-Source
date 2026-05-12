/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_tank_graveyard_2_aud.gsc
***********************************************/

func_00F9() {
  func_5C22();
}

func_5C22() {
  thread func_35E1();
  thread mp_tank_rudder_01();
  thread mp_tank_coins_01();
  thread mp_tank_coins_02();
  thread mp_tank_coins_03();
  thread mp_tank_coins_04();
  thread mp_tank_coins_05();
  thread mp_tank_coins_06();
  thread mp_tank_coins_07();
  thread mp_tank_coins_08();
  thread mp_tank_coins_09();
  thread mp_tank_coins_10();
  thread mp_tank_coins_11();
  thread mp_tank_coins_12();
  thread mp_tank_coins_13();
  thread mp_tank_coins_14();
  thread mp_tank_coins_15();
  thread mp_tank_coins_16();
  thread mp_tank_coins_17();
  thread mp_tank_coins_18();
  thread mp_tank_coins_19();
  thread mp_tank_coins_20();
  thread mp_tank_coins_21();
  thread mp_tank_coins_22();
  thread mp_tank_coins_23();
}

func_35E1() {
  wait(0.5);
  lib_0380::func_6842("emt_tank_fire_wd_lrg", undefined, (-1007, 1662, 191));
  lib_0380::func_6842("emt_tank_fire_wd_lrg", undefined, (-1459, 1765, 193));
  lib_0380::func_6842("emt_tank_fire_wd_lrg", undefined, (3006, -1617, 372));
  lib_0380::func_6842("emt_tank_fire_wd_lrg", undefined, (665, 1385, 178));
  lib_0380::func_6842("emt_tank_fire_wd_lrg", undefined, (2254, 399, 624));
  lib_0380::func_6842("emt_tank_fire_wd_lrg", undefined, (-837, -494, 136));
  lib_0380::func_6842("emt_tank_fire_wd_med", undefined, (-991, 1577, 191));
  lib_0380::func_6842("emt_tank_fire_wd_med", undefined, (-652, 1752, 146));
  lib_0380::func_6842("emt_tank_fire_wd_med", undefined, (-868, -512, 128));
  lib_0380::func_6842("emt_tank_fire_wd_med", undefined, (1358, 669, 80));
  lib_0380::func_6842("emt_tank_fire_wd_med", undefined, (701, 700, 247));
  lib_0380::func_6842("emt_tank_fire_wd_med", undefined, (662, 1378, 187));
  lib_0380::func_6842("emt_tank_fire_wd_sml", undefined, (1651, -1436, 96));
  lib_0380::func_6842("emt_tank_fire_wd_sml", undefined, (1906, -82, 149));
  lib_0380::func_6842("emt_tank_fire_mtl_lrg", undefined, (-169, 1671, 168));
  lib_0380::func_6842("emt_tank_fire_mtl_lrg", undefined, (1480, -1611, 132));
  lib_0380::func_6842("emt_tank_fire_mtl_med", undefined, (-283, 1673, 78));
  lib_0380::func_6842("emt_tank_fire_mtl_med", undefined, (-1424, -675, 319));
  lib_0380::func_6842("emt_tank_fire_mtl_med", undefined, (-1200, -718, 183));
  lib_0380::func_6842("emt_tank_fire_mtl_med", undefined, (-995, -1575, 113));
  lib_0380::func_6842("emt_tank_fire_mtl_sml", undefined, (1529, -1621, 132));
  lib_0380::func_6842("emt_tank_fire_mtl_sml", undefined, (-122, -943, 90));
  lib_0380::func_6842("emt_tank_fire_mtl_sml", undefined, (49, 887, 78));
}

mp_tank_rudder_01() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_tank_plane_rudder", undefined, (72, -1031, 169));
    wait(randomintrange(7, 10));
  }
}

mp_tank_coins_01() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_tank_coins", undefined, (-1267, 1506, 128));
    wait(randomintrange(8, 12));
  }
}

mp_tank_coins_02() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_tank_coins", undefined, (-1110, 1522, 128));
    wait(randomintrange(8, 12));
  }
}

mp_tank_coins_03() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_tank_coins", undefined, (-679, 1488, 188));
    wait(randomintrange(8, 12));
  }
}

mp_tank_coins_04() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_tank_coins", undefined, (-893, 1170, 188));
    wait(randomintrange(8, 12));
  }
}

mp_tank_coins_05() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_tank_coins", undefined, (-719, 1101, 155));
    wait(randomintrange(8, 12));
  }
}

mp_tank_coins_06() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_tank_coins", undefined, (1125, 358, 66));
    wait(randomintrange(8, 12));
  }
}

mp_tank_coins_07() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_tank_coins", undefined, (1039, 300, 103));
    wait(randomintrange(8, 12));
  }
}

mp_tank_coins_08() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_tank_coins", undefined, (589, 108, 16));
    wait(randomintrange(8, 12));
  }
}

mp_tank_coins_09() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_tank_coins", undefined, (330, -179, -22));
    wait(randomintrange(8, 12));
  }
}

mp_tank_coins_10() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_tank_coins", undefined, (-25, -317, -14));
    wait(randomintrange(8, 12));
  }
}

mp_tank_coins_11() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_tank_coins", undefined, (53, 409, 76));
    wait(randomintrange(8, 12));
  }
}

mp_tank_coins_12() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_tank_coins", undefined, (-72, 345, 37));
    wait(randomintrange(8, 12));
  }
}

mp_tank_coins_13() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_tank_coins", undefined, (-42, 239, -15));
    wait(randomintrange(8, 12));
  }
}

mp_tank_coins_14() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_tank_coins", undefined, (21, 113, 20));
    wait(randomintrange(8, 12));
  }
}

mp_tank_coins_15() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_tank_coins", undefined, (-519, -120, 20));
    wait(randomintrange(8, 12));
  }
}

mp_tank_coins_16() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_tank_coins", undefined, (-1651, 119, 124));
    wait(randomintrange(8, 12));
  }
}

mp_tank_coins_17() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_tank_coins", undefined, (-928, -1226, 120));
    wait(randomintrange(8, 12));
  }
}

mp_tank_coins_23() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_tank_coins", undefined, (-190, -1120, 223));
    wait(randomintrange(8, 12));
  }
}

mp_tank_coins_18() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_tank_coins", undefined, (360, -844, 81));
    wait(randomintrange(8, 12));
  }
}

mp_tank_coins_19() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_tank_coins", undefined, (1428, -772, 17));
    wait(randomintrange(8, 12));
  }
}

mp_tank_coins_20() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_tank_coins", undefined, (1682, -1041, 46));
    wait(randomintrange(8, 12));
  }
}

mp_tank_coins_21() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_tank_coins", undefined, (-1811, -759, 124));
    wait(randomintrange(8, 12));
  }
}

mp_tank_coins_22() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_tank_coins", undefined, (-1596, -1089, 120));
    wait(randomintrange(8, 12));
  }
}