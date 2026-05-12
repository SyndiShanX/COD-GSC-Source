/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_prague_aud.gsc
*********************************************/

func_00F9() {
  func_5C22();
  func_5C18();
}

func_5C22() {
  thread func_483B();
}

func_5C18() {
  lib_0380::func_6842("emt_river_close", undefined, (843, -2760, 200));
  lib_0380::func_6842("emt_river_close", undefined, (973, -1927, 200));
  lib_0380::func_6842("emt_river_close", undefined, (951, -1318, 200));
  lib_0380::func_6842("emt_river_close", undefined, (878, -675, 200));
  lib_0380::func_6842("emt_river_close", undefined, (927, -72, 200));
  lib_0380::func_6842("emt_river_close", undefined, (943, 417, 200));
  lib_0380::func_6842("emt_river_close", undefined, (1613, 1019, 200));
  lib_0380::func_6842("emt_river_close", undefined, (2042, 1431, 200));
  lib_0380::func_6842("emt_boats_rocking_01", undefined, (745, -616, 253));
  lib_0380::func_6842("emt_boats_rocking_02", undefined, (791, -1131, 253));
  lib_0380::func_6842("emt_boats_rocking_03", undefined, (847, -931, 253));
  lib_0380::func_6842("emt_metal_water_pipe", undefined, (-467, 683, 365));
  lib_0380::func_6842("emt_foliage_lp", undefined, (2707, -970, 622));
  lib_0380::func_6842("emt_branch_clatters_lp", undefined, (2707, -970, 622));
  lib_0380::func_6842("emt_branch_clatters_lp", undefined, (2659, -1422, 530));
  lib_0380::func_6842("emt_foliage_debris_base_lp", undefined, (2613, -984, 397));
  lib_0380::func_6842("emt_foliage_lp", undefined, (-782, -68, 613));
  lib_0380::func_6842("emt_branch_clatters_lp", undefined, (-782, -68, 613));
  lib_0380::func_6842("emt_foliage_debris_base_lp", undefined, (-752, -106, 397));
  lib_0380::func_6842("emt_foliage_lp", undefined, (-2182, -1463, 740));
  lib_0380::func_6842("emt_branch_clatters_lp", undefined, (-2182, -1463, 740));
  lib_0380::func_6842("emt_foliage_lp", undefined, (-296, -2274, 598));
  lib_0380::func_6842("emt_branch_clatters_lp", undefined, (-296, -2274, 598));
  lib_0380::func_6842("emt_foliage_lp", undefined, (1640, -1909, 598));
  lib_0380::func_6842("emt_branch_clatters_lp", undefined, (1640, -1909, 598));
  lib_0380::func_6842("emt_foliage_lp", undefined, (1285, -1883, 598));
  lib_0380::func_6842("emt_branch_clatters_lp", undefined, (1285, -1883, 598));
  lib_0380::func_6842("emt_foliage_debris_base_lp", undefined, (1453, -1910, 397));
  lib_0380::func_6842("emt_foliage_lp", undefined, (196, -826, 690));
  lib_0380::func_6842("emt_branch_clatters_lp", undefined, (196, -826, 690));
  lib_0380::func_6842("good_fire_wood_med", undefined, (-739, -17, 389));
  lib_0380::func_6842("good_fire_wood_med", undefined, (-309, -2228, 376));
  lib_0380::func_6842("good_fire_wood_med", undefined, (2703, -197, 465));
  lib_0380::func_6842("good_fire_metal_med", undefined, (-2705, 483, 596));
  lib_0380::func_6842("good_fire_metal_large", undefined, (2727, -679, 409));
  lib_0380::func_6842("good_fire_wood_small", undefined, (2672, -644, 409));
  lib_0380::func_6842("car_fire_mtl_stress", undefined, (2403, -700, 392));
  lib_0380::func_6842("emt_generator_lp", undefined, (-2048, -1849, 450));
  lib_0380::func_6842("emt_generator_lp", undefined, (28, -2733, 400));
  lib_0380::func_6842("emt_water_wheel_low_lp", undefined, (839, -1835, 317));
  lib_0380::func_6842("emt_water_wheel_high_lp", undefined, (839, -1835, 317));
  lib_0380::func_6842("emt_water_wheel_pops_lp", undefined, (839, -1835, 317));
}

func_483B() {
  wait(10);
  var_00 = lookupsoundlength("mp_hub_mus_1");
  var_01 = lookupsoundlength("mp_hub_mus_2");
  var_02 = lookupsoundlength("mp_hub_mus_3");
  var_03 = lookupsoundlength("mp_hub_mus_4");
  var_04 = 0;
  var_05 = 0;
  for(;;) {
    for(var_04 = randomintrange(1, 5); var_04 == var_05; var_04 = randomintrange(1, 4)) {}

    var_05 = var_04;
    var_06 = common_scripts\utility::func_9AAD(var_04);
    var_07 = "mp_hub_mus_" + var_06;
    var_08 = lib_0380::func_6842(var_07, undefined, (1852, -936, 273));
    wait(1.5);
    if(var_04 == 1) {
      wait(var_00);
    } else if(var_04 == 2) {
      wait(var_01);
    } else if(var_04 == 3) {
      wait(var_02);
    } else if(var_04 == 4) {
      wait(var_03);
    }

    wait(1);
  }
}