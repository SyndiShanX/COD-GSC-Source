/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_627452def335a90b.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_g_ob_ambient_biomes_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_g_ob_ambient_biomes_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_g_ob_ambient_biomes_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_g_ob_ambient_biomes_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_g_ob_ambient_biomes_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_g_ob_ambient_biomes_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-8012.12, -9271.25, 1563.15), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1200);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-10593.1, -14786.3, 1706.2), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-9135.74, -16670.7, 1702.2), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-7674.85, -18076.7, 1714.15), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-5950.35, -19237.7, 1710.1), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-4278.32, -19940.9, 1706.05), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-2305.69, -19994.6, 1690.39), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-16283.3, -14823.9, 1701.29), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 3200);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-13841.3, -18295.6, 1702.13), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 3200);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-22511.5, -13543.4, 1501.29), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1800);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-21315.3, -16073.9, 1982.27), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1800);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-20214.5, -18136.1, 1631.28), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1800);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-18822.1, -20008.4, 1715.63), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1800);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-16598.9, -22551.6, 1737.18), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1800);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-4228.66, -22016.3, 1705.41), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 3000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-5301.06, -26039, 1749.36), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 3500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-7149.13, -29672.8, 1714.38), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 3500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-8208.12, -31909.6, 1984.29), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 3500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-11407.1, -24093.9, 1708.24), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 3000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-28301.9, -14968.7, 1898.22), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-25744.2, -19231.7, 1660.22), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-25790.6, -21605.2, 1694.22), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-25983.4, -24005.7, 2026.22), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-25958.1, -26001.8, 1692.22), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-24337.8, -26435.2, 2016.22), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-20983.3, -25046, 1827.05), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-22675.8, -21956.2, 1698.71), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-19338.2, -29823, 1887.54), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1800);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-17590.2, -28971, 2172.54), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1800);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-14780.2, -29052.3, 1839.77), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1800);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-14117.6, -31149.8, 2075.11), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1800);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-16800.8, -30862, 2136.91), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1800);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-21379.6, -30261.3, 1930.9), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-23417.3, -32081.3, 2197.3), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-23418.4, -36350.9, 2722.05), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-19812.2, -34650.9, 2598.07), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-21128, -38139.5, 2810.12), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-23123, -40152.3, 2715.1), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-20953.7, -40904.3, 2715.91), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-16284, -36811.4, 2447.87), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-16305.7, -42022.4, 2819.87), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-11608.7, -40596.4, 2504.65), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-8805.61, -39349.3, 2285.62), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-13527.7, -35418.3, 2272.59), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-10749.8, -36540.5, 1907.56), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-8326.52, -36218.6, 1915.53), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-12742, -37703.3, 2206.5), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-30561.7, -11722, 1534.29), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-29796, -10120, 1678), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-25542.5, -6762.28, 1502.27), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1200);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-24048.5, -9760.84, 1503.25), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2200);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-17875.1, -9577.36, 1648.23), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 2200);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-13370.8, -8983.98, 1708.13), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-13828.2, -10641.5, 1864.03), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 1500);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-10505.2, -11185.5, 1676.31), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 3000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-7004.38, -13982.5, 1823.49), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 3000);
  s = s();
  s.name = "dense";
  fe[[f]](s, us, cf, (-3505.2, -17339, 1821.46), (0, 0, 0), "ai_biome_struct", undefined, "dense", undefined, undefined, undefined, undefined, 3000);
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}