/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_147577981b989310.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_i_ob_vehicles_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_i_ob_vehicles_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_i_ob_vehicles_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_i_ob_vehicles_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_i_ob_vehicles_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_i_ob_vehicles_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_vehicles_cs";
  s.vehicletype = "veh9_armored_patrol_boat_physics_mp";
  fe[[f]](s, us, cf, (37428, -31480, 2944), (0, 95, 0), "patrol_boat_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_vehicles_cs";
  s.vehicletype = "veh9_motorcycle_blood_burner_physics_mp";
  fe[[f]](s, us, cf, (22387, -21144, 2881), (0, 116.3, 0), "motorcycle_blood_burner_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_air_heli_medium_physics_mp";
  fe[[f]](s, us, cf, (36631, -35107, 3466), (0, 68.11, 0), "littlebird_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_vehicles_cs";
  s.vehicletype = "veh9_jltv_physics_mp";
  fe[[f]](s, us, cf, (24802, -25694, 3160), (0, 135, 0), "jltv_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_lnd_cargo_truck_physics_mp";
  fe[[f]](s, us, cf, (29192, -25604, 3168), (0, 180, 0), "mil_cargo_truck_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_vehicles_cs";
  s.vehicletype = "veh9_armored_patrol_boat_physics_mp";
  fe[[f]](s, us, cf, (29344, -38676, 2944), (0, 20, 0), "patrol_boat_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_vehicles_cs";
  s.vehicletype = "veh9_rhib_physics_mp";
  fe[[f]](s, us, cf, (31457.2, -32406.6, 2936), (0, 317.5, 0), "rhib_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_vehicles_cs";
  s.vehicletype = "veh9_rhib_physics_mp";
  fe[[f]](s, us, cf, (37656, -29028, 2944), (0, 209.4, 0), "rhib_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_vehicles_cs";
  s.vehicletype = "veh9_suv_1996_physics_mp";
  fe[[f]](s, us, cf, (39420, -19500, 3076), (0, 200, 0), "suv_1996_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_vehicles_cs";
  s.vehicletype = "veh9_rhib_physics_mp";
  fe[[f]](s, us, cf, (34392, -23092, 2912), (0, 155, 0), "rhib_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_vehicles_cs";
  s.vehicletype = "veh9_rhib_physics_mp";
  fe[[f]](s, us, cf, (32228, -22600, 2904), (0, 105, 0), "rhib_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_lnd_atv_physics_mp";
  fe[[f]](s, us, cf, (35652, -19944, 3088), (0, 150, 0), "atv_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_lnd_utv_physics_mp";
  fe[[f]](s, us, cf, (26768, -39612, 3156), (0, 65, 0), "utv_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_vehicles_cs";
  s.vehicletype = "veh9_sedan_hatchback_1985_physics_mp";
  fe[[f]](s, us, cf, (39184, -27496, 3024), (0, 180, 0), "sedan_hatchback_1985_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_air_heli_medium_physics_mp";
  fe[[f]](s, us, cf, (21760, -30778, 3354), (0, 90, 0), "littlebird_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_vehicles_cs";
  s.vehicletype = "veh9_jltv_mg_physics_mp";
  fe[[f]](s, us, cf, (29416, -23944, 3160), (0, 185, 0), "jltv_mg_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_vehicles_cs";
  s.vehicletype = "veh9_mil_lnd_atv_physics_mp";
  fe[[f]](s, us, cf, (26964, -36844, 3013.55), (0, 40, 0), "atv_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_vehicles_cs";
  s.vehicletype = "veh9_suv_1996_physics_mp";
  fe[[f]](s, us, cf, (23508, -18772, 2928), (0, 225, 0), "suv_1996_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_vehicles_cs";
  s.vehicletype = "veh9_civ_lnd_pickup_fullsized_2014_tech_armor_physics_mp";
  fe[[f]](s, us, cf, (24142, -36682, 3338.3), (351.61, 183.79, 0.15), "techo_rebel_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_vehicles_cs";
  s.vehicletype = "veh_jup_mil_lnd_buggy_orav_physics_mp";
  fe[[f]](s, us, cf, (40458, -20282, 3049.99), (1.23, 248.12, 10.92), "jup_orav_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_vehicles_cs";
  s.vehicletype = "veh_jup_mil_lnd_tank_razorback_physics_mp";
  fe[[f]](s, us, cf, (39402, -25772, 3096.16), (4.55, 159.9, -1.31), "jup_razorback_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_vehicles_cs";
  s.vehicletype = "veh_jup_truck_tech_aa_physics_mp";
  fe[[f]](s, us, cf, (34372, -20224, 3122.11), (4.49, 44.42, 5.41), "jup_truck_tech_aa_spawn");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_vehicles_cs";
  s.vehicletype = "veh_jup_pickup_1990_tech_hmg_physics_mp";
  fe[[f]](s, us, cf, (30988, -15714, 2943.37), (0.94, 146.01, 0.91), "jup_truck_tech_hmg_spawn");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_i_ob_vehicles_cs");
}