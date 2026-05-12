/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_fuhrerbunker_aud.gsc
*********************************************/

func_00F9() {
  func_5C22();
}

func_5C22() {
  thread func_35E1();
  thread mp_bunker_chandelier_01();
  thread mp_bunker_chandelier_02();
  thread mp_bunker_chandelier_03();
  thread mp_bunker_chandelier_04();
  thread mp_bunker_chandelier_05();
  thread mp_bunker_chandelier_06();
  thread mp_bunker_radiostatic_01();
  thread mp_bunker_radiostatic_02();
  thread mp_bunker_radiostatic_03();
  thread mp_bunker_radiostatic_04();
  thread mp_bunker_radiostatic_05();
  thread mp_bunker_radiostatic_06();
  thread mp_bunker_phone_01();
  thread mp_bunker_phone_02();
  thread mp_bunker_fan_01();
}

func_35E1() {
  wait(0.5);
  lib_0380::func_6842("emt_bunker_fire_small", undefined, (-360, -821, 146));
  lib_0380::func_6842("emt_bunker_fire_small", undefined, (1017, -656, 149));
  lib_0380::func_6842("emt_bunker_fire_small", undefined, (140, 3995, 287));
  lib_0380::func_6842("emt_bunker_fire_small", undefined, (1196, 2715, 213));
  lib_0380::func_6842("emt_bunker_fire_small", undefined, (722, 3433, 229));
  lib_0380::func_6842("emt_bunker_fire_med", undefined, (1170, -172, 240));
  lib_0380::func_6842("emt_bunker_fire_med", undefined, (1333, 36, 286));
  lib_0380::func_6842("emt_bunker_fire_med", undefined, (648, -67, 181));
  lib_0380::func_6842("emt_bunker_fire_med", undefined, (635, 32, 298));
  lib_0380::func_6842("emt_bunker_fire_med", undefined, (1192, -129, 510));
  lib_0380::func_6842("emt_bunker_fire_med", undefined, (-1307, 1868, 292));
  lib_0380::func_6842("emt_bunker_fire_med", undefined, (-1413, 1606, 401));
  lib_0380::func_6842("emt_bunker_fire_med", undefined, (-581, 1183, 381));
  lib_0380::func_6842("emt_bunker_fire_med", undefined, (588, 3464, 294));
  lib_0380::func_6842("emt_bunker_fire_med", undefined, (497, 2432, 397));
  lib_0380::func_6842("emt_bunker_fire_med", undefined, (-76, 4087, 267));
  lib_0380::func_6842("emt_bunker_fire_med", undefined, (-265, 2979, 247));
  lib_0380::func_6842("emt_bunker_fire_large", undefined, (1316, -176, 343));
  lib_0380::func_6842("emt_bunker_fire_large", undefined, (1212, -112, 510));
  lib_0380::func_6842("emt_bunker_fire_large", undefined, (-595, 1154, 390));
  lib_0380::func_6842("emt_bunker_fire_large", undefined, (-5, 4242, 355));
  lib_0380::func_6842("emt_bunker_fire_large", undefined, (700, 3642, 318));
  lib_0380::func_6842("emt_bunker_fire_large", undefined, (1397, -1167, 575));
  lib_0380::func_6842("emt_bunker_fire_large", undefined, (1647, 3025, 588));
  lib_0380::func_6842("emt_bunker_fire_large", undefined, (-1362, 1928, 312));
  lib_0380::func_6842("emt_bunker_clock", undefined, (-1103, 154, 221));
  lib_0380::func_6842("emt_bunker_clock", undefined, (-870, 1251, 325));
  lib_0380::func_6842("emt_bunker_clock", undefined, (-875, 1376, 416));
  lib_0380::func_6842("emt_bunker_clock_grandfather", undefined, (142, 2349, 297));
  lib_0380::func_6842("emt_bunker_clock_grandfather", undefined, (609, 263, 270));
}

mp_bunker_chandelier_01() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_bunker_chandelier", undefined, (-860, -33, 310));
    wait(randomintrange(7, 10));
  }
}

mp_bunker_chandelier_02() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_bunker_chandelier", undefined, (-742, 3680, 389));
    wait(randomintrange(7, 10));
  }
}

mp_bunker_chandelier_03() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_bunker_chandelier", undefined, (-569, 3137, 520));
    wait(randomintrange(7, 10));
  }
}

mp_bunker_chandelier_04() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_bunker_chandelier", undefined, (444, 1037, 472));
    wait(randomintrange(7, 10));
  }
}

mp_bunker_chandelier_05() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_bunker_chandelier", undefined, (445, 1402, 472));
    wait(randomintrange(7, 10));
  }
}

mp_bunker_chandelier_06() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_bunker_chandelier", undefined, (1083, 326, 346));
    wait(randomintrange(7, 10));
  }
}

mp_bunker_radiostatic_01() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_bunker_radio_static", undefined, (-1232, 1076, 245));
    wait(randomintrange(7, 10));
  }
}

mp_bunker_radiostatic_02() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_bunker_radio_static", undefined, (-1232, 922, 245));
    wait(randomintrange(7, 10));
  }
}

mp_bunker_radiostatic_03() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_bunker_radio_static", undefined, (-1143, 1462, 243));
    wait(randomintrange(7, 10));
  }
}

mp_bunker_radiostatic_04() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_bunker_radio_static", undefined, (-1085, 3718, 301));
    wait(randomintrange(7, 10));
  }
}

mp_bunker_radiostatic_05() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_bunker_radio_static", undefined, (182, 3957, 268));
    wait(randomintrange(7, 10));
  }
}

mp_bunker_radiostatic_06() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_bunker_radio_static", undefined, (261, 2362, 259));
    wait(randomintrange(7, 10));
  }
}

mp_bunker_radiostatic_07() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_bunker_radio_static", undefined, (-1032, 202, 177));
    wait(randomintrange(7, 10));
  }
}

mp_bunker_phone_01() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_bunker_phone", undefined, (-1020, 3342, 259));
    wait(randomintrange(12, 25));
  }
}

mp_bunker_phone_02() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_bunker_phone", undefined, (-886, 1898, 246));
    wait(randomintrange(15, 25));
  }
}

mp_bunker_fan_01() {
  level endon("death");
  for(;;) {
    lib_0380::func_2889("emt_bunker_fan", undefined, (710, 1961, 247));
    wait(randomintrange(5, 10));
  }
}