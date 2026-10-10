/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_35658e6ec63e0a84.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_d_ob_vehicles_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_d_ob_vehicles_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_d_ob_vehicles_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_d_ob_vehicles_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_d_ob_vehicles_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_d_ob_vehicles_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_vehicles_cs";
  s.vehicletype = "veh9_sedan_hatchback_1985_physics_mp";
  fe[[f]](s, us, cf, (-26063.7, 10323.5, 1182.99), (0.01, 176.24, -0), "sedan_hatchback_1985_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_vehicles_cs";
  s.vehicletype = "veh9_motorcycle_blood_burner_physics_mp";
  fe[[f]](s, us, cf, (-16540, 11135, 1275), (0, 356, 0), "motorcycle_blood_burner_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_vehicles_cs";
  s.vehicletype = "veh9_motorcycle_blood_burner_physics_mp";
  fe[[f]](s, us, cf, (-23872, 215, 1005), (0, 180, 0), "motorcycle_blood_burner_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_lnd_atv_physics_mp";
  fe[[f]](s, us, cf, (-31340.5, 7052.5, 988), (0, 0, 0), "atv_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_vehicles_cs";
  s.vehicletype = "veh9_armored_patrol_boat_physics_mp";
  fe[[f]](s, us, cf, (-36391, 3095.5, 896), (0, 100, 0), "patrol_boat_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_lnd_cargo_truck_physics_mp";
  fe[[f]](s, us, cf, (-31824.2, 10920.1, 1008), (0, 300, 0), "mil_cargo_truck_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_lnd_atv_physics_mp";
  fe[[f]](s, us, cf, (-23000.5, 6995.14, 1541.77), (0, 0, 0), "atv_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_vehicles_cs";
  s.vehicletype = "veh9_rhib_physics_mp";
  fe[[f]](s, us, cf, (-34723.3, -200.58, 896), (0, 102, 0), "rhib_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_vehicles_cs";
  s.vehicletype = "veh9_rhib_physics_mp";
  fe[[f]](s, us, cf, (-34241.4, 7860.7, 896), (0, 192, 0), "rhib_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_lnd_cargo_truck_physics_mp";
  fe[[f]](s, us, cf, (-30817, 3020.65, 1011.98), (360, 102, -0), "mil_cargo_truck_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_vehicles_cs";
  s.vehicletype = "veh9_sedan_hatchback_1985_physics_mp";
  fe[[f]](s, us, cf, (-25448.2, -1588.62, 1044.99), (0, 157.6, -0), "sedan_hatchback_1985_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_vehicles_cs";
  s.vehicletype = "veh9_rhib_physics_mp";
  fe[[f]](s, us, cf, (-34073.4, 12804.7, 892), (0, 216, 0), "rhib_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_vehicles_cs";
  s.vehicletype = "veh9_armored_patrol_boat_physics_mp";
  fe[[f]](s, us, cf, (-18467, -3795.5, 896), (0, 280, 0), "patrol_boat_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_lnd_atv_physics_mp";
  fe[[f]](s, us, cf, (-32633.5, 14444.5, 988), (0, 0, 0), "atv_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_lnd_cargo_truck_physics_mp";
  fe[[f]](s, us, cf, (-22774, -1804.65, 1055.98), (0, 263.87, -0), "mil_cargo_truck_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_vehicles_cs";
  s.vehicletype = "veh9_suv_1996_physics_mp";
  fe[[f]](s, us, cf, (-31792.1, 13991.1, 1010.97), (358, 355, 0), "suv_1996_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_vehicles_cs";
  s.vehicletype = "veh9_suv_1996_physics_mp";
  fe[[f]](s, us, cf, (-26414, 11237.3, 1189.99), (360, 249, 0), "suv_1996_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_vehicles_cs";
  s.vehicletype = "veh9_sedan_hatchback_1985_physics_mp";
  fe[[f]](s, us, cf, (-28158, 7534.21, 1061.98), (359.98, 289.6, 0.01), "sedan_hatchback_1985_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_vehicles_cs";
  s.vehicletype = "veh9_civ_lnd_pickup_fullsized_2014_tech_armor_physics_mp";
  fe[[f]](s, us, cf, (-28698, 17084, 1207.96), (3.63, 262.23, 3.68), "techo_rebel_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_lnd_utv_physics_mp";
  fe[[f]](s, us, cf, (-27152, 18146, 1586.03), (0.11, 216, 0.07), "utv_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_vehicles_cs";
  s.vehicletype = "veh_jup_mil_lnd_buggy_orav_physics_mp";
  fe[[f]](s, us, cf, (-29550, 15488, 1098.61), (4.74, 292.43, 5.94), "jup_orav_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_vehicles_cs";
  s.vehicletype = "veh_jup_truck_tech_aa_physics_mp";
  fe[[f]](s, us, cf, (-29958, 8310, 965.49), (2.16, 291.93, -1.86), "jup_truck_tech_aa_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_vehicles_cs";
  s.vehicletype = "veh_jup_pickup_1990_tech_hmg_physics_mp";
  fe[[f]](s, us, cf, (-23964, 2894, 1106.97), (357.55, 290.36, -0.7), "jup_truck_tech_hmg_spawn");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_d_ob_vehicles_cs");
}