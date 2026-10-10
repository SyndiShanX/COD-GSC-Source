/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4b719cd8c8fde14c.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_h_ob_vehicles_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_h_ob_vehicles_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_h_ob_vehicles_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_h_ob_vehicles_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_h_ob_vehicles_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_h_ob_vehicles_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_motorcycle_blood_burner_physics_mp";
  fe[[f]](s, us, cf, (-1520, -18441, 1710), (0, 330.88, 0), "motorcycle_blood_burner_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_motorcycle_blood_burner_physics_mp";
  fe[[f]](s, us, cf, (-10238, -16867, 1707), (0, 296.58, 0), "motorcycle_blood_burner_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_motorcycle_blood_burner_physics_mp";
  fe[[f]](s, us, cf, (3743, -17639, 1704), (0, 201.75, 0), "motorcycle_blood_burner_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_motorcycle_blood_burner_physics_mp";
  fe[[f]](s, us, cf, (7706, -28464, 1860), (359, 171.78, 0), "motorcycle_blood_burner_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_suv_overland_2016_cage_wz_physics_mp";
  fe[[f]](s, us, cf, (1313.38, -30987, 1954.71), (1.9, 212.74, 3.6), "overland_2016_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_jltv_mg_physics_mp";
  fe[[f]](s, us, cf, (2309.22, -19750.3, 1765.71), (0, 345.5, 0), "jltv_mg_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_suv_overland_2016_cage_wz_physics_mp";
  fe[[f]](s, us, cf, (13759.6, -25983.6, 1785.34), (0, 197.5, 0), "overland_2016_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_lnd_utv_physics_mp";
  fe[[f]](s, us, cf, (12343.7, -35484.9, 2766.69), (0, 200.3, 0), "utv_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_lnd_cargo_truck_physics_mp";
  fe[[f]](s, us, cf, (-913.93, -26576.2, 1753.97), (0, 169.2, 0), "mil_cargo_truck_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_lnd_atv_physics_mp";
  fe[[f]](s, us, cf, (14902.8, -30134.3, 2423.72), (0, 90, 0), "atv_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_suv_1996_physics_mp";
  fe[[f]](s, us, cf, (-403.69, -35544.7, 1997.74), (0, 84.7, 0), "suv_1996_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_suv_1996_physics_mp";
  fe[[f]](s, us, cf, (5608.95, -18177.8, 1749.97), (0, 270, 0), "suv_1996_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_lnd_atv_physics_mp";
  fe[[f]](s, us, cf, (2527, -42044, 2908), (0, 266.3, 0), "atv_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_suv_1996_physics_mp";
  fe[[f]](s, us, cf, (7470.78, -36094.3, 2838.35), (2.69, 51.8, -0.1), "suv_1996_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_jltv_mg_physics_mp";
  fe[[f]](s, us, cf, (12371.3, -22342.8, 1757.6), (356.62, 160.24, -1.23), "jltv_mg_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_lnd_utv_physics_mp";
  fe[[f]](s, us, cf, (4893.21, -32899, 1845.62), (3.2, 66.36, -1.88), "utv_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_pickup_fullsized_2014_physics_mp";
  fe[[f]](s, us, cf, (3600.42, -28495.3, 1986.08), (359, 354.5, 0.04), "pickup_2014_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_sedan_hatchback_1985_physics_mp";
  fe[[f]](s, us, cf, (8544.34, -27374.9, 1745.05), (359.3, 91, 0), "sedan_hatchback_1985_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_suv_1996_physics_mp";
  fe[[f]](s, us, cf, (-3549.59, -42564.9, 2844.3), (0, 264.3, 0), "suv_1996_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_civ_lnd_pickup_fullsized_2014_tech_armor_physics_mp";
  fe[[f]](s, us, cf, (7074, -30882, 2543.74), (355.6, 0.01, -0.09), "techo_rebel_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_sedan_hatchback_1985_physics_mp";
  fe[[f]](s, us, cf, (-3140.02, -31960.3, 1814.74), (2, 113.6, -0.8), "sedan_hatchback_1985_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_suv_overland_2016_cage_wz_physics_mp";
  fe[[f]](s, us, cf, (11641.9, -32838.6, 2603.07), (0, 222.7, 0), "overland_2016_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_lnd_atv_physics_mp";
  fe[[f]](s, us, cf, (8281, -31711.2, 2517.89), (0, 319.6, 0), "atv_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_lnd_utv_physics_mp";
  fe[[f]](s, us, cf, (17802.1, -35699.8, 2861.98), (0, 298.2, 0), "utv_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_suv_overland_2016_cage_wz_physics_mp";
  fe[[f]](s, us, cf, (5606.26, -39713.7, 2947.21), (4.6, 139.4, -0), "overland_2016_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_lnd_atv_physics_mp";
  fe[[f]](s, us, cf, (11055.2, -27034.8, 1761.59), (0, 264.4, 0), "atv_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_lnd_atv_physics_mp";
  fe[[f]](s, us, cf, (-4315.59, -38286.9, 2326.53), (358.39, 96.58, -0.54), "atv_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_jltv_physics_mp";
  fe[[f]](s, us, cf, (1343.52, -38280.3, 2536.28), (0, 18, 0), "jltv_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_lnd_utv_physics_mp";
  fe[[f]](s, us, cf, (4984.93, -36359.9, 2466.61), (352.1, 323.82, 1.49), "utv_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_suv_overland_2016_cage_wz_physics_mp";
  fe[[f]](s, us, cf, (12799.1, -38684.3, 3026.6), (0, 122.5, 0), "overland_2016_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_rhib_physics_mp";
  fe[[f]](s, us, cf, (14759.3, -20197.2, 1426.31), (0, 94.3, 0), "rhib_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh9_rhib_physics_mp";
  fe[[f]](s, us, cf, (5238.3, -13393.2, 1403.31), (0, 97.9, 0), "rhib_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh_jup_mil_lnd_buggy_orav_physics_mp";
  fe[[f]](s, us, cf, (16024, -33648, 2714.03), (2.24, 114.02, 0.63), "jup_orav_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh_jup_mil_lnd_tank_razorback_physics_mp";
  fe[[f]](s, us, cf, (8918, -38878, 2919.88), (0.05, 28, 3.33), "jup_razorback_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh_jup_truck_tech_aa_physics_mp";
  fe[[f]](s, us, cf, (-2252, -43066, 2810.89), (359.21, 8, -0.33), "jup_truck_tech_aa_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_vehicles_cs";
  s.vehicletype = "veh_jup_pickup_1990_tech_hmg_physics_mp";
  fe[[f]](s, us, cf, (9314, -26444, 1716.3), (359.62, 360, 0.01), "jup_truck_tech_hmg_spawn");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_h_ob_vehicles_cs");
}