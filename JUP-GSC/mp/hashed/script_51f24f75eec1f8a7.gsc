/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_51f24f75eec1f8a7.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_fort_ob_features_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_fort_ob_features_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_fort_ob_features_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_fort_ob_features_cs");

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

  s cs_setup_arrays(us, "mp_jup_fort_ob_features_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_fort_ob_features_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (18640, -51169, 1957), (343.64, 267.67, 4.17), "ob_floater", undefined, "jup_urz_machinery_ranch_airplane_debris_fuselage_01_ob_rift_run", undefined, undefined, undefined, undefined, 333);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (17054, -51263, 1913), (341.24, 264.99, -4.22), "ob_floater", undefined, "jup_urz_machinery_ranch_airplane_crashed_01_ob_rift_run", undefined, undefined, undefined, undefined, 300);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (21278, -51979, 2522), (347.4, 263.94, -1.54), "ob_floater", undefined, "jup_machinery_ranch_airplane_debris_tail_01_ob_rift_run", undefined, undefined, undefined, undefined, 500);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  s.content_key = "perk_machine_choice_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (20321, -49328, 511), (0, 270, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (22073, -54259, 1253), (27.77, 46.21, -23.9), "ob_floater", undefined, "veh9_ind_lnd_talfa_flatbed_static_ob_rift_run", undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  s.script_label = "280";
  fe[[f]](s, us, cf, (19872, -46855, 943), (31.73, 185.52, 153.74), "ob_floater", undefined, "veh9_ind_lnd_excavator_ob_rift_run", undefined, undefined, undefined, undefined, 280);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (19983, -48580, 884), (349.15, 151.14, 21.7), "ob_floater", undefined, "veh9_civ_lnd_van_palfa_ambulance_ru_static_ob_rift_run", undefined, undefined, undefined, undefined, 150);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  s.script_label = "280";
  fe[[f]](s, us, cf, (9874, -54272, 940), (298.93, 132.95, 145.15), "ob_floater", undefined, "veh9_ind_lnd_excavator_ob_rift_run", undefined, undefined, undefined, undefined, 280);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (19785, -57038, 932), (352.35, 94.21, -23.22), "ob_floater", undefined, "veh8_mil_sea_zoscar_static_ob_rift_run", undefined, undefined, undefined, undefined, 300);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (22041.9, -54258, 1327.09), (27.77, 46.21, -23.9), "ob_floater_powerup", undefined, "insta_kill");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (18588.6, -53787.2, 1982.12), (13.99, 238.29, -26.7), "ob_floater_powerup", undefined, "full_power");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (15079, -51243, 1140), (13.23, 145.23, 18.33), "ob_floater");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (16547, -54499, 2097), (0.39, 343.78, -17.67), "ob_floater", undefined, "veh9_civ_lnd_van_palfa_ambulance_ru_static_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (18650, -51180, 2094), (3.19, 88.62, -4), "ob_floater_powerup", undefined, "full_ammo");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (13889, -53546, 1674), (25.97, 13.29, 27.3), "ob_floater_powerup", undefined, "nuke");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (18604, -56060, 1643), (8.69, 79.53, -0.12), "ob_floater_powerup", undefined, "full_armor");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (15708, -53498, 1557), (14.95, 138.46, 24.56), "ob_floater", undefined, "veh9_civ_lnd_suv_overland_2016_crash_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (19986, -54906, 1646), (22.59, 169.56, 30.28), "ob_floater", undefined, "veh9_civ_lnd_suv_overland_2016_crash_ob_rift_run", undefined, undefined, undefined, undefined, 150);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (8874, -50554, 822), (71.01, 51.56, 35.46), "ob_floater", undefined, "veh9_ind_lnd_talfa_flatbed_static_ob_rift_run", undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  s.script_label = "280";
  fe[[f]](s, us, cf, (17267, -54712, 2027), (5.35, 350, -172.75), "ob_floater", undefined, "veh9_ind_lnd_excavator_ob_rift_run", undefined, undefined, undefined, undefined, 280);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (15384, -54430, 1534), (16.34, 353.89, -154.33), "ob_floater", undefined, "veh9_ind_lnd_talfa_flatbed_static_ob_rift_run", undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (16463, -57975, 2055), (343.64, 267.67, 10.37), "ob_floater", undefined, "jup_urz_machinery_ranch_airplane_debris_fuselage_01_ob_rift_run", undefined, undefined, undefined, undefined, 333);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (14719, -59116, 2092), (9.03, 52.14, -0.45), "ob_floater", undefined, "jup_urz_machinery_ranch_airplane_crashed_01_ob_rift_run", undefined, undefined, undefined, undefined, 300);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (18828, -59719, 2310), (10.52, 240.74, -1.41), "ob_floater", undefined, "jup_machinery_ranch_airplane_debris_tail_01_ob_rift_run", undefined, undefined, undefined, undefined, 500);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (18606, -56055, 1643), (359.88, 349.55, 171.31), "ob_floater", undefined, "me_rock_large_01_brown_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (17993, -47089, 1074), (58.2, 348.87, -177.87), "ob_floater", undefined, "me_rock_large_01_brown_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (22344.1, -50488.3, 1454.81), (14.69, 97.61, 145.11), "ob_floater", undefined, "me_rock_large_01_brown_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (12545, -50684, 1462), (0.77, 75.65, -169.32), "ob_floater", undefined, "me_rock_large_01_brown_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (23494.1, -58259.3, 1647.81), (1.13, 262.32, -51.47), "ob_floater", undefined, "me_rock_large_01_brown_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (13889, -53531, 1638), (25.97, 13.29, -152.7), "ob_floater", undefined, "veh9_civ_lnd_van_palfa_ambulance_ru_static_ob_rift_run", undefined, undefined, undefined, undefined, 150);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (11309, -48503, 408), (23.94, 343.34, -1.65), "ob_floater", undefined, "veh8_mil_sea_zoscar_static_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (12292, -56959, 556), (10.38, 53.09, 35.25), "ob_floater", undefined, "veh8_mil_sea_zoscar_static_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (24289, -52174, 767), (324.29, 143.16, -136.69), "ob_floater", undefined, "veh8_mil_sea_zoscar_static_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (16141, -54317, 2040), (11.67, 322.26, -79.24), "ob_floater", undefined, "veh9_ind_lnd_talfa_flatbed_static_ob_rift_run", undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (18591.3, -53794.8, 1983.11), (338.99, 170.71, 158.22), "ob_floater", undefined, "me_rock_large_01_brown_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (15096, -47812, 1363), (53.29, 121.69, 41.08), "ob_floater", undefined, "veh9_civ_lnd_suv_overland_2016_crash_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (18853, -47667, 637), (0, 90, 0), "mrpeeks_intro", undefined, "ESCORT_ZOMBIES_FORT");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (19029, -47667, 637), (0, 90, 0), "mrpeeks_intro", undefined, "SABOTAGE_FORT");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  fe[[f]](s, us, cf, (18941, -47667, 621), (0, 90, 0), "mrpeeks_intro", undefined, "OUTLAST_FORT", undefined, undefined, undefined, undefined, 1060);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_features_cs";
  s.content_key = "pap_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (18592, -54144, 1024), (0, 90, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_fort_ob_features_cs");
}