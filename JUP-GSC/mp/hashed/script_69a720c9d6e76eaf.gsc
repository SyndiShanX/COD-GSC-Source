/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_69a720c9d6e76eaf.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_e_ob_ambient_biomes_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_e_ob_ambient_biomes_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_e_ob_ambient_biomes_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_e_ob_ambient_biomes_cs");

  if(!cs_is_starttime()) {
    endcreatescript(s);
  }
}

function cs_return_and_wait_for_flag(us, s, cf) {
  level endon("game_ended");
  wait_for_cs_flag(cf);

  if(!isDefined(us)) {
    us = "pfx";
  }

  s cs_setup_arrays(us, "mp_jup_st_e_ob_ambient_biomes_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_e_ob_ambient_biomes_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-3427.11, -8422.16, 1639), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1200);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-5133.13, -1960.36, 2441), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 3000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-6125.98, -5155.14, 2289), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-1742.64, -3270.34, 1897), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-1464.72, 1831.34, 2235), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 4500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-1752, -9770, 1638), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1200);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-5588.94, 902.65, 2206.5), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (1070.58, 6032.91, 1932), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 4000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (4915.42, 6951.44, 1510.44), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (4719.28, 9672.66, 1444.44), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-3484.35, 5891.22, 1890.18), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (942.6, -5334.32, 1970.83), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (6914.46, -4149.68, 2524.08), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 4000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (7436.96, 1003.26, 1995.08), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (9284, -587.07, 2196.91), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (8851.7, 6467.75, 1442.91), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1200);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (12981.2, 502.18, 1956.91), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (12588.8, 5795.92, 2479.18), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (15139.5, 5808.33, 2176.2), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (11744.6, -4748.91, 1835.55), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (11339.2, -6663.97, 1955.29), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (11876.5, -9482.33, 2093.29), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (12133.4, -11198.9, 1746.71), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (14846.2, -10723.7, 1930.71), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (18826.6, -8190.06, 2075.63), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (15533.6, -6825.05, 1864.61), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (17169.9, -4950.61, 1998.59), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (17658.1, -2388.55, 1892.96), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (15621, -3954.54, 1615.18), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1200);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (20978.1, -4685.03, 2397.63), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (21105.7, -1217.25, 2525.05), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (20087.5, 1018.47, 2288.03), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (22362.9, 2202.81, 2548.7), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (20873, 2695.48, 2252.97), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-5673.19, 11269.2, 1194.96), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-8107.81, 9978.49, 1056.96), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-9714.7, 7338.5, 1399.64), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-12657.8, 4493.92, 1545.89), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-13715.6, 1598.97, 1055.89), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-14682.1, -859.84, 1153.91), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-13532.6, -985.33, 1055.63), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-10577.3, 1001.42, 1120.11), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-12322.1, 11559.8, 1273.61), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-14174.7, 10518.8, 1411.11), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2200);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-16004.2, 7850.9, 1271.08), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1700);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-17050.5, 5451.33, 1267.06), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}