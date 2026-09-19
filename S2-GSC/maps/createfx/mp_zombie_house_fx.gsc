/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\createfx\mp_zombie_house_fx.gsc
************************************************/

#include common_scripts\utility;
#include common_scripts\_createfx;

main() {
  ent = createOneshotEffect("zmb_snow_fall_slow");
  ent set_origin_and_angles((-2628.58, 6346.91, 1085.63), (270, 0, -130));
  ent.v["fxid"] = "zmb_snow_fall_slow";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_snow_fall_slow");
  ent set_origin_and_angles((-2311.04, 5607.86, 1172.89), (270, 0, -175));
  ent.v["fxid"] = "zmb_snow_fall_slow";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_snow_fall");
  ent set_origin_and_angles((-1566.71, 5874.63, 1315.78), (270, 0, 170));
  ent.v["fxid"] = "zmb_snow_fall";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_snow_fall");
  ent set_origin_and_angles((-2005.34, 4470.51, 1200.99), (270, 0, 170));
  ent.v["fxid"] = "zmb_snow_fall";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_snow_fall");
  ent set_origin_and_angles((-1366.95, 3560.53, 1146.33), (270, 0, -178));
  ent.v["fxid"] = "zmb_snow_fall";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("vf_zombie_nest_wind");
  ent set_origin_and_angles((-3568.63, 6320.51, 1283.89), (0, 0, 0));
  ent.v["fxid"] = "vf_zombie_nest_wind";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_nest_fog_sml");
  ent set_origin_and_angles((-2374.53, 6396.85, 934.911), (270, 0, 59));
  ent.v["fxid"] = "zmb_nest_fog_sml";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_snow_gust");
  ent set_origin_and_angles((-2399.7, 6551.53, 1008.58), (271, 75.9915, 53.0076));
  ent.v["fxid"] = "zmb_snow_gust";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_snow_gust");
  ent set_origin_and_angles((-2047.82, 6240.63, 995.878), (290.616, 126.87, -18.7311));
  ent.v["fxid"] = "zmb_snow_gust";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_snow_gust");
  ent set_origin_and_angles((-1717.29, 5747.05, 1031.62), (270, 0, 91));
  ent.v["fxid"] = "zmb_snow_gust";
  ent.v["delay"] = -25.3979;

  ent = createOneshotEffect("zmb_snow_gust");
  ent set_origin_and_angles((-2042.22, 4645.9, 1011.86), (270, 0, 91));
  ent.v["fxid"] = "zmb_snow_gust";
  ent.v["delay"] = -25.3979;

  ent = createOneshotEffect("zmb_snow_gust");
  ent set_origin_and_angles((-1474.07, 3947.47, 1039.75), (270, 0, 109));
  ent.v["fxid"] = "zmb_snow_gust";
  ent.v["delay"] = -25.3979;

  ent = createOneshotEffect("zmb_snow_gust");
  ent set_origin_and_angles((-2153.67, 4017, 1109.2), (270, 0, 147));
  ent.v["fxid"] = "zmb_snow_gust";
  ent.v["delay"] = -25.3979;

  ent = createOneshotEffect("zmb_ember_cloud_freq_sml_loop");
  ent set_origin_and_angles((-3953.57, 7638.99, 1396.92), (270, 0, -55));
  ent.v["fxid"] = "zmb_ember_cloud_freq_sml_loop";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_ember_cloud_freq_sml_loop");
  ent set_origin_and_angles((-2790.31, 7782.17, 1179.51), (270, 0, -55));
  ent.v["fxid"] = "zmb_ember_cloud_freq_sml_loop";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_fire_vista_lrg");
  ent set_origin_and_angles((-2837.76, 7561.89, 1152), (270, 180, 49));
  ent.v["fxid"] = "zmb_fire_vista_lrg";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_tree_fire");
  ent set_origin_and_angles((-2639.06, 7657.98, 1261.64), (270, 0, -120));
  ent.v["fxid"] = "zmb_tree_fire";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_fire_licks_long");
  ent set_origin_and_angles((-2847.2, 7421.35, 1296), (270, 0, -17));
  ent.v["fxid"] = "zmb_fire_licks_long";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_fire_licks_long");
  ent set_origin_and_angles((-3318.02, 7471.52, 1155.59), (271, 113.994, 176.007));
  ent.v["fxid"] = "zmb_fire_licks_long";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_fire_licks_m_vf");
  ent set_origin_and_angles((-3095.9, 7554.49, 1152), (312, 0, 0));
  ent.v["fxid"] = "zmb_fire_licks_m_vf";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_dust_interior");
  ent set_origin_and_angles((-2453.43, 4783.14, 995.125), (270, 0, 0));
  ent.v["fxid"] = "zmb_dust_interior";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_dust_interior");
  ent set_origin_and_angles((-2246.56, 4748.34, 995.125), (270, 0, 0));
  ent.v["fxid"] = "zmb_dust_interior";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_dust_interior");
  ent set_origin_and_angles((-2665.77, 4862.21, 1174.13), (270, 0, 0));
  ent.v["fxid"] = "zmb_dust_interior";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_dust_interior");
  ent set_origin_and_angles((-3031.66, 4825.25, 995.125), (270, 0, 0));
  ent.v["fxid"] = "zmb_dust_interior";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_dust_interior");
  ent set_origin_and_angles((-2687.08, 4915.42, 995.125), (270, 0, 0));
  ent.v["fxid"] = "zmb_dust_interior";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_rat_flock_runaway_runner");
  ent set_origin_and_angles((-2933.77, 4810.93, 996.125), (270, 0, 80));
  ent.v["fxid"] = "zmb_rat_flock_runaway_runner";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_rat_flock_runaway_runner");
  ent set_origin_and_angles((-2934.67, 4767.74, 995.125), (270, 0, 112));
  ent.v["fxid"] = "zmb_rat_flock_runaway_runner";
  ent.v["delay"] = -23.0775;

  ent = createOneshotEffect("zmb_rat_flock_short_runner");
  ent set_origin_and_angles((-2469.85, 4606.26, 1130.7), (270, 0, 33));
  ent.v["fxid"] = "zmb_rat_flock_short_runner";
  ent.v["delay"] = -23.0775;

  ent = createOneshotEffect("zmb_rat_flock_runaway_runner");
  ent set_origin_and_angles((-2660.48, 5053.25, 995.125), (270, 0, 108));
  ent.v["fxid"] = "zmb_rat_flock_runaway_runner";
  ent.v["delay"] = -23.0775;

  ent = createOneshotEffect("zmb_fireplace_fire");
  ent set_origin_and_angles((-2775.67, 4813.97, 1023.99), (270, 0, 93));
  ent.v["fxid"] = "zmb_fireplace_fire";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_fire_lp_sm_a");
  ent set_origin_and_angles((-2771.71, 4827.79, 1020.86), (270, 0, 0));
  ent.v["fxid"] = "zmb_fire_lp_sm_a";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_smk_chimney_vf");
  ent set_origin_and_angles((-2792.4, 4817.95, 1440.53), (270, 0, -31));
  ent.v["fxid"] = "zmb_smk_chimney_vf";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_embers_wind_vortex");
  ent set_origin_and_angles((-3062.35, 7390.44, 1231.93), (270, 0, 0));
  ent.v["fxid"] = "zmb_embers_wind_vortex";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_dust_interior");
  ent set_origin_and_angles((-2268.44, 4729.77, 1170.13), (270, 0, 0));
  ent.v["fxid"] = "zmb_dust_interior";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_dust_interior");
  ent set_origin_and_angles((-2951.36, 4735.8, 1171.5), (270, 0, 0));
  ent.v["fxid"] = "zmb_dust_interior";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_snow_gust");
  ent set_origin_and_angles((-2632.66, 4448.89, 1022), (270, 0, 124));
  ent.v["fxid"] = "zmb_snow_gust";
  ent.v["delay"] = -25.3979;

  ent = createOneshotEffect("zmb_headlight_bright_01_lt_spot");
  ent set_origin_and_angles((-1870.74, 5539.6, 1034.45), (359.13, 72.0056, -0.124167));
  ent.v["fxid"] = "zmb_headlight_bright_01_lt_spot";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_headlight_bright_01_rt_spot");
  ent set_origin_and_angles((-1811.17, 5519.55, 1034.46), (359.096, 71, -0.381762));
  ent.v["fxid"] = "zmb_headlight_bright_01_rt_spot";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_training_fire_flame_drips");
  ent set_origin_and_angles((-3911.97, 6452.83, 1564.78), (270, 0, 0));
  ent.v["fxid"] = "zmb_training_fire_flame_drips";
  ent.v["delay"] = -15;

  ent = createOneshotEffect("zmb_on_fire_01");
  ent set_origin_and_angles((-4114.86, 6749.56, -1120.49), (270, 0, 0));
  ent.v["fxid"] = "zmb_on_fire_01";
  ent.v["delay"] = -15;

  ent = createLoopSound();
  ent set_origin_and_angles((-2778.91, 4813.9, 1031.13), (270, 0, 0));
  ent.v["soundalias"] = "emt_fire_crackle_lp";

  ent = createLoopSound();
  ent set_origin_and_angles((-3178.6, 7353.1, 1143.92), (270, 0, 0));
  ent.v["soundalias"] = "zmb_tree_fire_lp";

  ent = createLoopSound();
  ent set_origin_and_angles((-3120.51, 4885.22, 1188.81), (270, 0, 0));
  ent.v["soundalias"] = "zmb_window_wind_lp";

  ent = createLoopSound();
  ent set_origin_and_angles((-2835.1, 4566.44, 1187.11), (270, 0, 0));
  ent.v["soundalias"] = "zmb_window_wind_lp";

  ent = createLoopSound();
  ent set_origin_and_angles((-2626.24, 4577.92, 1191.81), (270, 0, 0));
  ent.v["soundalias"] = "zmb_window_wind_lp";

  ent = createLoopSound();
  ent set_origin_and_angles((-2298.81, 4566.24, 1197.12), (270, 0, 0));
  ent.v["soundalias"] = "zmb_window_wind_lp";

  ent = createLoopSound();
  ent set_origin_and_angles((-2307.89, 4933.81, 1193.66), (270, 0, 0));
  ent.v["soundalias"] = "zmb_window_wind_lp";

  ent = createLoopSound();
  ent set_origin_and_angles((-2095.82, 4640.98, 1064.74), (270, 0, 0));
  ent.v["soundalias"] = "zmb_window_wind_lp";

  ent = createLoopSound();
  ent set_origin_and_angles((-2448.95, 4585.52, 1061.49), (270, 0, 0));
  ent.v["soundalias"] = "zmb_window_wind_lp";

  ent = createLoopSound();
  ent set_origin_and_angles((-2883.67, 4587.65, 1063.66), (270, 0, 0));
  ent.v["soundalias"] = "zmb_window_wind_lp";

  ent = createLoopSound();
  ent set_origin_and_angles((-3130.23, 4661.13, 1059.31), (270, 0, 0));
  ent.v["soundalias"] = "zmb_window_wind_lp";

  ent = createLoopSound();
  ent set_origin_and_angles((-2880.09, 5143.36, 1061.46), (270, 0, 0));
  ent.v["soundalias"] = "zmb_window_wind_lp";

  ent = createLoopSound();
  ent set_origin_and_angles((-2514.13, 4940.9, 1060.71), (270, 0, 0));
  ent.v["soundalias"] = "zmb_window_wind_lp";

  ent = createLoopSound();
  ent set_origin_and_angles((-2110.72, 5245.69, 1029.65), (270, 0, 0));
  ent.v["soundalias"] = "zmb_emt_spotlight";

  ent = createIntervalSound();
  ent set_origin_and_angles((-2462.72, 4580, 1190.24), (270, 0, 0));
  ent.v["delay_min"] = 15;
  ent.v["delay_max"] = 30;
  ent.v["soundalias"] = "zmb_emt_window_shake";

  ent = createIntervalSound();
  ent set_origin_and_angles((-2698.08, 4581, 1204.44), (270, 0, 0));
  ent.v["delay_min"] = 15;
  ent.v["delay_max"] = 30;
  ent.v["soundalias"] = "zmb_emt_window_shake";

  ent = createIntervalSound();
  ent set_origin_and_angles((-2898.39, 4577.99, 1184.39), (270, 0, 0));
  ent.v["delay_min"] = 15;
  ent.v["delay_max"] = 30;
  ent.v["soundalias"] = "zmb_emt_window_shake";

  ent = createIntervalSound();
  ent set_origin_and_angles((-3125, 4649.6, 1185.38), (270, 0, 0));
  ent.v["delay_min"] = 15;
  ent.v["delay_max"] = 30;
  ent.v["soundalias"] = "zmb_emt_window_shake";

  ent = createIntervalSound();
  ent set_origin_and_angles((-3048.86, 4936.03, 1185.28), (270, 0, 0));
  ent.v["delay_min"] = 15;
  ent.v["delay_max"] = 30;
  ent.v["soundalias"] = "zmb_emt_window_shake";

  ent = createIntervalSound();
  ent set_origin_and_angles((-2859.11, 4937.01, 1187.51), (270, 0, 0));
  ent.v["delay_min"] = 15;
  ent.v["delay_max"] = 30;
  ent.v["soundalias"] = "zmb_emt_window_shake";

  ent = createIntervalSound();
  ent set_origin_and_angles((-3051.18, 4575, 1066.32), (270, 0, 0));
  ent.v["delay_min"] = 15;
  ent.v["delay_max"] = 30;
  ent.v["soundalias"] = "zmb_emt_window_shake";

  ent = createIntervalSound();
  ent set_origin_and_angles((-3052.56, 5128.29, 1071.94), (270, 0, 0));
  ent.v["delay_min"] = 15;
  ent.v["delay_max"] = 30;
  ent.v["soundalias"] = "zmb_emt_window_shake";

  ent = createIntervalSound();
  ent set_origin_and_angles((-2227.16, 4584.97, 1075.52), (270, 0, 0));
  ent.v["delay_min"] = 15;
  ent.v["delay_max"] = 30;
  ent.v["soundalias"] = "zmb_emt_window_shake";

  ent = createIntervalSound();
  ent set_origin_and_angles((-2649.1, 4939.5, 1192.27), (270, 0, 0));
  ent.v["delay_min"] = 15;
  ent.v["delay_max"] = 30;
  ent.v["soundalias"] = "zmb_emt_window_shake";
}