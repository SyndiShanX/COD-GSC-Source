/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3e4551bf67f2308e.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_f_ob_contracts_escort;

function main(unused, us) {
  if(flag_exist("mp_jup_st_f_ob_contracts_escort")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_f_ob_contracts_escort");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_f_ob_contracts_escort");

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

  s cs_setup_arrays(us, "mp_jup_st_f_ob_contracts_escort");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_f_ob_contracts_escort");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_f_ob_contracts_escort");
}

function function_fd69cf02ba4d90a2() {
  activityinfostruct = spawnStruct();
  activityinfostruct.name = "REV_OB_ESCORT_ZOMBIES";
  activityinfostruct.mainfunction = &main;
  activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  activityinfostruct.metadatafunction = &function_6da2952367672ac0;
  return activityinfostruct;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_f_ob_contracts_escort";
  }

  switch (instancename) {
    case #"hash_79408f9e2abd042c":
      function_41d2cb6e3d7bea31(fe, us, cf);
      break;
    case #"hash_2e4c93e876192750":
      function_239018cc270bd09f(fe, us, cf);
      break;
    case #"hash_a4de0b2c7e3aff75":
      function_4f9355e70f76af36(fe, us, cf);
      break;
  }
}

function function_41d2cb6e3d7bea31(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (42712, -8700, 2968), (0, 0, 0), "ESCORT_ZOMBIES_F_FARM_TUNNEL", undefined, "escort_f_farm_tunnel", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (33200, -3798, 2473.08), (0, 0, 0), "escort_f_farm_tunnel_horde_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (29536, -4760, 2459.25), (0, 315, 0), "ESCORT_ZOMBIES_F_FARM_TUNNEL_REWARD", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (38792, -8076, 2981), (0, 0, 0), "escort_f_farm_tunnel_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (46046.5, -9886.5, 3007.5), (0, 257.83, 0), "activity_nexus_instance_joiner", undefined, "ESCORT_ZOMBIES_F_FARM_TUNNEL", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (37736, -7324, 2981.5), (0, 0, 0), "escort_f_farm_tunnel_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (39716, -6036, 3016.69), (0, 0, 0), "escort_f_farm_tunnel_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (32676, -4168, 2487.45), (0, 0, 0), "escort_f_farm_tunnel_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (33640, -3220, 2440), (0, 0, 0), "escort_f_farm_tunnel_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (34712, -5612, 2598.51), (0, 0, 0), "escort_f_farm_tunnel_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (35556, -5000, 2708.97), (0, 0, 0), "escort_f_farm_tunnel_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (29308, -5936, 2512), (0, 0, 0), "escort_f_farm_tunnel_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (29960, -3804, 2244), (0, 0, 0), "escort_f_farm_tunnel_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (28736, -5816, 2445.95), (0, 0, 0), "escort_f_farm_tunnel_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (31028, -4648, 2640.21), (0, 0, 0), "escort_f_farm_tunnel_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (39308, -7496, 2964), (0, 0, 0), "escort_f_farm_tunnel_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (40468, -8708, 2968), (0, 0, 0), "escort_f_farm_tunnel_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (38952, -8488, 2981), (0, 0, 0), "escort_f_farm_tunnel_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (38380, -6824, 2980.03), (0, 0, 0), "escort_f_farm_tunnel_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (37416, -4928, 2986), (0, 0, 0), "escort_f_farm_tunnel_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (36520, -4924, 2930.77), (0, 0, 0), "escort_f_farm_tunnel_ambush_05", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (35564, -6204, 2897.07), (0, 0, 0), "escort_f_farm_tunnel_ambush_05", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (34048, -4484, 2506.79), (0, 0, 0), "escort_f_farm_tunnel_ambush_06", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (32204, -4248, 2490), (0, 0, 0), "escort_f_farm_tunnel_ambush_07", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (32504, -2780, 2370), (0, 0, 0), "escort_f_farm_tunnel_ambush_07", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (31384, -4748, 2715.75), (0, 0, 0), "escort_f_farm_tunnel_ambush_08", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (29564, -5164, 2501.54), (0, 0, 0), "escort_f_farm_tunnel_ambush_09", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (37602, -6390, 2993.03), (0, 0, 0), "escort_f_farm_tunnel_horde_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (29292, -6076, 2517), (0, 0, 0), "escort_f_farm_tunnel_horde_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_239018cc270bd09f(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (29540, 10200, 1960), (0, 0, 0), "ESCORT_ZOMBIES_F_TOWN_RIVER", undefined, "escort_f_town_river", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (31438.5, 11122, 2110.74), (0, 0.28, 0), "activity_nexus_instance_joiner", "ESCORT_ZOMBIES_F_TOWN_RIVER", "ESCORT_ZOMBIES_F_TOWN_RIVER", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (28512, 6916, 1968.46), (0, 0, 0), "escort_f_town_town_river_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (28168, 9612, 2157.5), (0, 0, 0), "escort_f_town_town_river_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (28212, 4884, 2065.61), (0, 0, 0), "escort_f_town_town_river_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (28544, 3628, 1887), (0, 0, 0), "escort_f_town_town_river_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (30288, 3392, 2044.77), (0, 0, 0), "escort_f_town_town_river_ambush_05", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (31788, 2872, 2183.75), (0, 0, 0), "escort_f_town_town_river_ambush_06", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (32992, 1432, 2279), (0, 0, 0), "escort_f_town_town_river_ambush_07", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (31640, 580, 2138.21), (0, 0, 0), "escort_f_town_town_river_ambush_08", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (31620, -268, 2111.14), (0, 0, 0), "escort_f_town_town_river_ambush_09", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (32762.5, -1629.5, 2272), (0, 0, 0), "escort_f_town_town_river_ambush_10", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (32908, 68, 2265.99), (0, 0, 0), "escort_f_town_town_river_ambush_09", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (32836, 756, 2265.93), (0, 0, 0), "escort_f_town_town_river_ambush_08", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (29828, 4260, 2171.27), (0, 0, 0), "escort_f_town_town_river_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (28164, 8128, 1865), (0, 0, 0), "escort_f_town_river_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (29752, 6960, 2100.28), (0, 0, 0), "escort_f_town_river_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (27684, 6092, 1886.15), (0, 0, 0), "escort_f_town_river_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (29404, 4424, 2180.46), (0, 0, 0), "escort_f_town_river_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (30768, 2456, 2103), (0, 0, 0), "escort_f_town_river_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (30964, 3560, 2179.44), (0, 0, 0), "escort_f_town_river_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (31556, -736, 2247), (0, 0, 0), "escort_f_town_river_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (31443.5, -1767.5, 2248), (0, 0, 0), "escort_f_town_river_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (33586, -585, 2392), (0, 0, 0), "escort_f_town_river_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (32594.5, -2824.5, 2272), (0, 0, 0), "escort_f_town_river_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (31932, -1340, 2253.75), (0, 310, 0), "ESCORT_ZOMBIES_F_TOWN_RIVER_REWARD", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (30894, 3246, 2162.59), (0, 0, 0), "escort_f_town_river_horde_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (28050, 6350, 1942), (0, 0, 0), "escort_f_town_river_horde_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (32965, -2169.5, 2272), (0, 0, 0), "escort_f_town_river_horde_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_4f9355e70f76af36(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (40176, 12612, 3079.21), (0, 260, 0), "ESCORT_ZOMBIES_F_OIL_SPIRAL_REWARD", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (39188, 9884, 2916), (0, 0, 0), "ESCORT_ZOMBIES_F_OIL_SPIRAL", undefined, "escort_f_oil_spiral", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (38724, 13456, 3051.75), (0, 0, 0), "escort_f_oil_spiral_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (40047, 6539, 2991.27), (0, 261.85, 0), "activity_nexus_instance_joiner", "ESCORT_ZOMBIES_F_OIL_SPIRAL", "ESCORT_ZOMBIES_F_OIL_SPIRAL", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (39056, 12236, 3036), (0, 0, 0), "escort_f_oil_spiral_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (40928, 14788, 3231.75), (0, 0, 0), "escort_f_oil_spiral_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (41080, 12544, 3081.36), (0, 0, 0), "escort_f_oil_spiral_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (42236, 13704, 3173.68), (0, 0, 0), "escort_f_oil_spiral_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (42280, 12740, 3125.75), (0, 0, 0), "escort_f_oil_spiral_ambush_05", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (41288, 11312, 3121.75), (0, 0, 0), "escort_f_oil_spiral_ambush_06", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (39464, 11108, 2934.12), (0, 0, 0), "escort_f_oil_spiral_ambush_07", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (40168, 12400, 3078.52), (0, 0, 0), "escort_f_oil_spiral_ambush_08", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (39744, 12800, 3084), (0, 0, 0), "escort_f_oil_spiral_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (39144, 14188, 3088), (0, 0, 0), "escort_f_oil_spiral_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (37932, 12860, 3053.63), (0, 0, 0), "escort_f_oil_spiral_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (42744, 13812, 3185.71), (0, 0, 0), "escort_f_oil_spiral_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (42864, 12948, 3216.5), (0, 0, 0), "escort_f_oil_spiral_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (41276, 11804, 3082.72), (0, 0, 0), "escort_f_oil_spiral_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (41184, 11752, 3078.72), (0, 0, 0), "escort_f_oil_spiral_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (39720, 12728, 3085), (0, 0, 0), "escort_f_oil_spiral_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (39384, 10920, 2944.28), (0, 0, 0), "escort_f_oil_spiral_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (40888, 10928, 2998.03), (0, 0, 0), "escort_f_oil_spiral_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (42808, 12360, 3132), (0, 0, 0), "escort_f_oil_spiral_horde_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (38966, 14008, 3110), (0, 0, 0), "escort_f_oil_spiral_horde_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_escort";
  fe[[f]](s, us, cf, (40716, 12942, 3084.68), (0, 0, 0), "escort_f_oil_spiral_horde_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_escort";
  instancestruct.cf = "mp_jup_st_f_ob_contracts_escort";
  instancestruct.scriptstructorigin = (42384, -8496, 2968);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(42148, -8124, 2984.41), (29616, -5100, 2488), (38341, -6684, 2978.2), (34281, -4696, 2512.03)];
  instancestruct.locationoriginoffset = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.locationradius = [1250, 1250, 1000, 1000];
  activityinstances["ESCORT_ZOMBIES_F_FARM_TUNNEL"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_escort";
  instancestruct.cf = "mp_jup_st_f_ob_contracts_escort";
  instancestruct.scriptstructorigin = (29368, 10012, 1961.31);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(28536, 7068, 1967.31), (29008, 10108, 1907.76), (30224, 3444, 2039.5), (32585, -1562.5, 2268)];
  instancestruct.locationoriginoffset = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.locationradius = [1000, 1250, 1000, 1000];
  activityinstances["ESCORT_ZOMBIES_F_TOWN_RIVER"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_escort";
  instancestruct.cf = "mp_jup_st_f_ob_contracts_escort";
  instancestruct.scriptstructorigin = (39136, 9712, 2916);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(40544, 12348, 3074.9)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [3000];
  activityinstances["ESCORT_ZOMBIES_F_OIL_SPIRAL"] = instancestruct;
  return activityinstances;
}