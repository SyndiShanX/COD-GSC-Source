/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3528ab11b04f7bac.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_g_ob_vehicles_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_g_ob_vehicles_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_g_ob_vehicles_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_g_ob_vehicles_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_g_ob_vehicles_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_g_ob_vehicles_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_motorcycle_blood_burner_physics_mp";
  fe[[f]](s, us, cf, (-17475, -19785, 1650), (0, 114.51, 0), "motorcycle_blood_burner_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_motorcycle_blood_burner_physics_mp";
  fe[[f]](s, us, cf, (-16700, -8408, 1504), (0, 23.6, 0), "motorcycle_blood_burner_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_rhib_physics_mp";
  fe[[f]](s, us, cf, (-26608, -5168, 880), (0, 120, 0), "rhib_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_lnd_atv_physics_mp";
  fe[[f]](s, us, cf, (-21444, -32032, 1984), (0, 45, 0), "atv_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_lnd_cargo_truck_physics_mp";
  fe[[f]](s, us, cf, (-15584, -27104, 1776), (0, 30, 0), "mil_cargo_truck_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_jltv_mg_physics_mp";
  fe[[f]](s, us, cf, (-18872, -29800, 1936.16), (0, 60, 0), "jltv_mg_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_armored_patrol_boat_physics_mp";
  fe[[f]](s, us, cf, (-9724, -6148, 908), (0, 150, 0), "patrol_boat_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_rhib_physics_mp";
  fe[[f]](s, us, cf, (-3712, -10916, 1240), (0, 120, 0), "rhib_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_sedan_hatchback_1985_physics_mp";
  fe[[f]](s, us, cf, (-15744, -26440, 1760), (0, 30, 0), "sedan_hatchback_1985_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_air_heli_medium_physics_mp";
  fe[[f]](s, us, cf, (-14060, -14204, 2547.98), (0, 0, 0), "littlebird_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_armored_patrol_boat_physics_mp";
  fe[[f]](s, us, cf, (-35231.5, -21689.5, 908), (0, 159.96, 0), "patrol_boat_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_rhib_physics_mp";
  fe[[f]](s, us, cf, (-17008, -5240, 880), (0, 180, 0), "rhib_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_jltv_mg_physics_mp";
  fe[[f]](s, us, cf, (-20912, -13600, 1655.9), (0, 300, 0), "jltv_mg_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_jltv_mg_physics_mp";
  fe[[f]](s, us, cf, (-2540, -14140, 1811.9), (0, 300, 0), "jltv_mg_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_lnd_atv_physics_mp";
  fe[[f]](s, us, cf, (-25588.6, -39547.2, 2995.38), (355.56, 59.92, 1.05), "atv_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_lnd_atv_physics_mp";
  fe[[f]](s, us, cf, (-19136, -43208, 2944), (359.42, 75.42, -15.87), "atv_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_civ_lnd_pickup_fullsized_2014_tech_armor_physics_mp";
  fe[[f]](s, us, cf, (-25164.5, -5303, 1013.5), (0, 349.02, 0), "techo_rebel_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_lnd_cargo_truck_physics_mp";
  fe[[f]](s, us, cf, (-6944, -10020, 1548.98), (3.11, 60.69, -4.37), "mil_cargo_truck_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_sedan_hatchback_1985_physics_mp";
  fe[[f]](s, us, cf, (-17352, -24112, 1776), (0, 210, 0), "sedan_hatchback_1985_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_sedan_hatchback_1985_physics_mp";
  fe[[f]](s, us, cf, (-14048, -22696, 1784), (0, 45, 0), "sedan_hatchback_1985_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_sedan_hatchback_1985_physics_mp";
  fe[[f]](s, us, cf, (-21224, -11768, 1616), (0, 360, 0), "sedan_hatchback_1985_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_sedan_hatchback_1985_physics_mp";
  fe[[f]](s, us, cf, (-11720, -7400, 1648), (0, 360, 0), "sedan_hatchback_1985_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_sedan_hatchback_1985_physics_mp";
  fe[[f]](s, us, cf, (-1050, -15460, 1772), (0, 293, 0), "sedan_hatchback_1985_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_sedan_hatchback_1985_physics_mp";
  fe[[f]](s, us, cf, (-2336, -25704, 1752), (0, 255, 0), "sedan_hatchback_1985_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_suv_overland_2016_cage_wz_physics_mp";
  fe[[f]](s, us, cf, (-5459, -25293, 1757), (0, 82.37, 0), "overland_2016_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_suv_overland_2016_cage_wz_physics_mp";
  fe[[f]](s, us, cf, (-22633, -35449, 2757.06), (0, 66.61, 0), "overland_2016_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_suv_1996_physics_mp";
  fe[[f]](s, us, cf, (-1602, -20605, 1741.91), (0, 143.2, -4.44), "suv_1996_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_suv_1996_physics_mp";
  fe[[f]](s, us, cf, (-4898, -25474, 1753), (0, 74.71, 0), "suv_1996_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_sedan_hatchback_1985_physics_mp";
  fe[[f]](s, us, cf, (-24584, -14803, 1812), (2.08, 115.42, 0.99), "sedan_hatchback_1985_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_sedan_hatchback_1985_physics_mp";
  fe[[f]](s, us, cf, (-10162, -29047, 2151), (0, 350.1, 0), "sedan_hatchback_1985_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_suv_1996_physics_mp";
  fe[[f]](s, us, cf, (-3858, -28960, 2122), (0, 172.74, 0), "suv_1996_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_suv_1996_physics_mp";
  fe[[f]](s, us, cf, (-27490, -6616, 1761), (0, 282.38, 0), "suv_1996_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_suv_1996_physics_mp";
  fe[[f]](s, us, cf, (-19405, -22039, 2201), (0, 139.93, 0), "suv_1996_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_lnd_atv_physics_mp";
  fe[[f]](s, us, cf, (-26396, -30744, 2056), (0, 105, 0), "atv_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_air_heli_medium_physics_mp";
  fe[[f]](s, us, cf, (-20405, -16944.5, 3849.71), (0, 289.49, 0), "littlebird_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_civ_lnd_pickup_fullsized_2014_tech_armor_physics_mp";
  fe[[f]](s, us, cf, (-7416, -17268, 1752), (0, 58, 0), "techo_rebel_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh_jup_mil_lnd_buggy_orav_physics_mp";
  fe[[f]](s, us, cf, (-5816, -9560, 1421.99), (0.92, 112, 0.01), "jup_orav_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh_jup_mil_lnd_tank_razorback_physics_mp";
  fe[[f]](s, us, cf, (-11952, -7242, 1609), (0, 288, 0), "jup_razorback_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh_jup_truck_tech_aa_physics_mp";
  fe[[f]](s, us, cf, (-17872, -11844, 1713.72), (0.76, 184, 0.06), "jup_truck_tech_aa_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh_jup_pickup_1990_tech_hmg_physics_mp";
  fe[[f]](s, us, cf, (-17294, -18700, 1643.68), (0.21, 306.29, 4.93), "jup_truck_tech_hmg_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_vehicles_cs";
  s.vehicletype = "veh9_civ_lnd_pickup_fullsized_2014_tech_armor_physics_mp";
  fe[[f]](s, us, cf, (-14150, -26690, 2188), (0, 148, 0), "techo_rebel_spawn");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_g_ob_vehicles_cs");
}