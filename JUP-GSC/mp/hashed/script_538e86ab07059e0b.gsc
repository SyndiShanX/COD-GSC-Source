/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_538e86ab07059e0b.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_sira_ob_features_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_sira_ob_features_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_sira_ob_features_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_sira_ob_features_cs");

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

  s cs_setup_arrays(us, "mp_jup_sira_ob_features_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_sira_ob_features_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_fuselage_stadium";
  fe[[f]](s, us, cf, (-35408, -17553, 877), (28.3, 241.03, -29.64), "ob_floater", undefined, "jup_urz_machinery_ranch_airplane_debris_fuselage_01_ob_rift_run", undefined, undefined, undefined, undefined, 333);
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_fuselage_playground";
  fe[[f]](s, us, cf, (-32402, -26084, 1084), (26.91, 156.72, -5.22), "ob_floater", undefined, "jup_urz_machinery_ranch_airplane_debris_fuselage_01_ob_rift_run", undefined, undefined, undefined, undefined, 333);
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_truck";
  fe[[f]](s, us, cf, (-40508.8, -15428.2, 641.4), (346.02, 283.24, -0.43), "ob_floater", undefined, "veh9_mil_lnd_cargo_truck_static_ob_rift_run", undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "script_struct_mrpeeks_intro";
  fe[[f]](s, us, cf, (-40427, -21081, 393), (0.01, 109, 0), "mrpeeks_intro", undefined, "BIGBOUNTY_SIRA_COURTYARD");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_fuselage_stadium";
  fe[[f]](s, us, cf, (-34439.1, -17683.5, 961.38), (341.31, 216.88, -19.55), "ob_floater", undefined, "jup_urz_machinery_ranch_airplane_debris_fuselage_01_ob_rift_run", undefined, undefined, undefined, undefined, 333);
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.content_key = "perk_machine_choice_spawn";
  s.groupid = "debris_powerup";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-30369, -25810.4, 765), (303.85, 186.2, 37.04));
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_fuselage_stadium";
  fe[[f]](s, us, cf, (-33197.7, -17874.2, 693.82), (33.33, 79.67, 24.2), "ob_floater", undefined, "jup_urz_machinery_ranch_airplane_crashed_01_ob_rift_run", undefined, undefined, undefined, undefined, 300);
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_fuselage_stadium";
  fe[[f]](s, us, cf, (-36960, -17276, 1456), (15.99, 99.15, -4.52), "ob_floater", undefined, "jup_machinery_ranch_airplane_debris_tail_01_ob_rift_run", undefined, undefined, undefined, undefined, 500);
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_truck";
  fe[[f]](s, us, cf, (-25575.5, -22796.4, 418.81), (342.74, 11.72, 6.27), "ob_floater", undefined, "veh9_mil_lnd_cargo_truck_static_ob_rift_run", undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "script_struct_mrpeeks_intro";
  fe[[f]](s, us, cf, (-40260, -21023, 393), (360, 109, 0), "mrpeeks_intro", undefined, "SABOTAGE_SIRA");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_excavator";
  s.script_label = "280";
  fe[[f]](s, us, cf, (-31709, -14632, 789), (6.67, 167.9, 78.48), "ob_floater", undefined, "veh9_ind_lnd_excavator_ob_rift_run", undefined, undefined, undefined, undefined, 280);
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_ambulance";
  fe[[f]](s, us, cf, (-28393.2, -24225.3, 368), (9.47, 190.87, -13.91), "ob_floater", undefined, "veh9_civ_lnd_van_palfa_ambulance_ru_static_ob_rift_run", undefined, undefined, undefined, undefined, 150);
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "script_struct_mrpeeks_intro";
  fe[[f]](s, us, cf, (-40344, -21052, 376), (0.02, 109, -1.24), "mrpeeks_intro", undefined, "OUTLAST_SIRA", undefined, undefined, undefined, undefined, 1060);
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_excavator";
  s.script_label = "280";
  fe[[f]](s, us, cf, (-42264.4, -21078.4, 408.38), (346.19, 270.07, -12.52), "ob_floater", undefined, "veh9_ind_lnd_excavator_ob_rift_run", undefined, undefined, undefined, undefined, 280);
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_boat";
  fe[[f]](s, us, cf, (-26270.4, -26683.6, 180), (14.83, 147.93, -11.53), "ob_floater", undefined, "veh8_mil_sea_zoscar_static_ob_rift_run", undefined, undefined, undefined, undefined, 300);
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_powerup";
  fe[[f]](s, us, cf, (-26292.5, -26688.2, 315.18), (0, 0, 0), "ob_floater_powerup", undefined, "insta_kill");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_powerup";
  fe[[f]](s, us, cf, (-28099.1, -18259.7, 721.99), (0, 0, 0), "ob_floater_powerup", undefined, "full_power");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_powerup";
  fe[[f]](s, us, cf, (-35161.7, -20240.3, 966.58), (0, 0, 0), "ob_floater_powerup", undefined, "full_ammo");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_ambulance";
  fe[[f]](s, us, cf, (-31534.2, -17697.2, 384), (333.62, 294.96, -173.25), "ob_floater", undefined, "veh9_civ_lnd_van_palfa_ambulance_ru_static_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_powerup";
  fe[[f]](s, us, cf, (-31658.3, -14564.2, 981.67), (0, 0, 0), "ob_floater_powerup", undefined, "full_ammo");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_powerup";
  fe[[f]](s, us, cf, (-31398.1, -25381, 1684.78), (0, 0, 0), "ob_floater_powerup", undefined, "nuke");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_powerup";
  fe[[f]](s, us, cf, (-32728, -19192, 728), (359.49, 79.52, 2.7), "ob_floater_powerup", undefined, "full_armor");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_powerup";
  fe[[f]](s, us, cf, (-42201, -21353.4, 856.59), (0, 0, 0), "ob_floater_powerup", undefined, "full_armor");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_jeep";
  fe[[f]](s, us, cf, (-24196.3, -24898.4, 385), (14.8, 180.96, 0), "ob_floater", undefined, "veh9_civ_lnd_suv_overland_2016_crash_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_jeep";
  fe[[f]](s, us, cf, (-35344.7, -18791, 340.44), (13.56, 150.46, -12.86), "ob_floater", undefined, "veh9_civ_lnd_suv_overland_2016_crash_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_jeep";
  fe[[f]](s, us, cf, (-32014, -22416.9, 432.38), (13.45, 74.91, 160.87), "ob_floater", undefined, "veh9_civ_lnd_suv_overland_2016_crash_ob_rift_run", undefined, undefined, undefined, undefined, 150);
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_truck";
  fe[[f]](s, us, cf, (-38291.8, -20879.3, 441.17), (23.33, 12.48, -9.72), "ob_floater", undefined, "veh9_mil_lnd_cargo_truck_static_ob_rift_run", undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_excavator";
  s.script_label = "280";
  fe[[f]](s, us, cf, (-33642.9, -22186.3, 426.09), (356.06, 311.85, -20.61), "ob_floater", undefined, "veh9_ind_lnd_excavator_ob_rift_run", undefined, undefined, undefined, undefined, 280);
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_truck";
  fe[[f]](s, us, cf, (-25643.1, -15897, 498.86), (345.36, 187.78, -6.77), "ob_floater", undefined, "veh9_mil_lnd_cargo_truck_static_ob_rift_run", undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_fuselage_playground";
  fe[[f]](s, us, cf, (-33365, -26316, 1002), (343.64, 267.67, 10.37), "ob_floater", undefined, "jup_urz_machinery_ranch_airplane_debris_fuselage_01_ob_rift_run", undefined, undefined, undefined, undefined, 333);
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_fuselage_playground";
  fe[[f]](s, us, cf, (-34571, -25805, 980), (22.41, 270.99, -6.1), "ob_floater", undefined, "jup_urz_machinery_ranch_airplane_crashed_01_ob_rift_run", undefined, undefined, undefined, undefined, 300);
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_fuselage_playground";
  fe[[f]](s, us, cf, (-31297, -25161, 1536), (283.29, 257.45, 31.96), "ob_floater", undefined, "jup_machinery_ranch_airplane_debris_tail_01_ob_rift_run", undefined, undefined, undefined, undefined, 500);
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_rock";
  fe[[f]](s, us, cf, (-34324, -19663.3, 497.98), (359.88, 349.55, -19.89), "ob_floater", undefined, "me_rock_large_01_brown_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_rock";
  fe[[f]](s, us, cf, (-33106.1, -13958.5, 386.57), (11.98, 166.82, -1.15), "ob_floater", undefined, "me_rock_large_01_brown_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_rock";
  fe[[f]](s, us, cf, (-32733.6, -19194.6, 532.94), (4.99, 37.29, 6.04), "ob_floater", undefined, "me_rock_large_01_brown_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_rock";
  fe[[f]](s, us, cf, (-39187.7, -17086.4, 370.23), (348.22, 257.76, -10.91), "ob_floater", undefined, "me_rock_large_01_brown_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_rock";
  fe[[f]](s, us, cf, (-28106.8, -18250.3, 565.83), (1.13, 262.32, -14.07), "ob_floater", undefined, "me_rock_large_01_brown_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_ambulance";
  fe[[f]](s, us, cf, (-35253.5, -20911.5, 449), (344.83, 24.12, 15.72), "ob_floater", undefined, "veh9_civ_lnd_van_palfa_ambulance_ru_static_ob_rift_run", undefined, undefined, undefined, undefined, 150);
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_boat";
  fe[[f]](s, us, cf, (-38814.8, -29970.4, 180), (356.52, 169.16, 14.72), "ob_floater", undefined, "veh8_mil_sea_zoscar_static_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_boat";
  fe[[f]](s, us, cf, (-32921.5, -28019.1, 180), (2.08, 223.64, 14.9), "ob_floater", undefined, "veh8_mil_sea_zoscar_static_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_boat";
  fe[[f]](s, us, cf, (-29689.5, -28473.1, 180), (11.94, 243.64, 11.31), "ob_floater", undefined, "veh8_mil_sea_zoscar_static_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_truck";
  fe[[f]](s, us, cf, (-35525.5, -22776.5, 433.77), (343.65, 145.96, 7.2), "ob_floater", undefined, "veh9_mil_lnd_cargo_truck_static_ob_rift_run", undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_rock";
  fe[[f]](s, us, cf, (-30563.5, -16897.2, 478.98), (342.37, 327.14, -3.96), "ob_floater", undefined, "me_rock_large_01_brown_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_features_cs";
  s.groupid = "debris_jeep";
  fe[[f]](s, us, cf, (-35559.8, -13662.1, 367.02), (19.68, 132.08, -4.18), "ob_floater", undefined, "veh9_civ_lnd_suv_overland_2016_crash_ob_rift_run");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_sira_ob_features_cs");
}