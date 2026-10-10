/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_140b2a257b323303.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_hydro_ob_features_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_hydro_ob_features_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_hydro_ob_features_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_hydro_ob_features_cs");

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

  s cs_setup_arrays(us, "mp_jup_hydro_ob_features_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_hydro_ob_features_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_features_cs";
  fe[[f]](s, us, cf, (-7815.41, 15820, 2057.04), (353.13, 258.87, 75), "ob_floater", undefined, "veh9_ind_lnd_talfa_flatbed_static_ob_rift_run", undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_features_cs";
  fe[[f]](s, us, cf, (-7225.77, 14312.7, 2313.04), (0.77, 271.81, -99.59), "ob_floater", undefined, "veh9_ind_lnd_talfa_flatbed_static_ob_rift_run", undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_features_cs";
  fe[[f]](s, us, cf, (-12390, 10097.8, 846), (0, 0, 0), "ob_floater", undefined, "me_rock_large_01_brown_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_features_cs";
  fe[[f]](s, us, cf, (-7969.6, 15356.2, 2118.27), (0, 51.32, 0), "ob_floater", undefined, "veh9_civ_lnd_suv_overland_2016_crash_ob_rift_run", undefined, undefined, undefined, undefined, 150);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_features_cs";
  s.content_key = "perk_machine_choice_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-6690.15, 13946, 2002.83), (326.35, 158.52, -5.15));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_features_cs";
  fe[[f]](s, us, cf, (-6794.06, 13991.3, 2035.12), (34.78, 340.8, -172.92), "ob_floater", undefined, "veh9_civ_lnd_van_palfa_ambulance_ru_static_ob_rift_run", undefined, undefined, undefined, undefined, 150);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_features_cs";
  fe[[f]](s, us, cf, (-1293.35, 7387.5, 1623.91), (354.94, 309.08, -6.31), "ob_floater", undefined, "jup_machinery_ranch_airplane_debris_tail_01_ob_rift_run", undefined, undefined, undefined, undefined, 500);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_features_cs";
  fe[[f]](s, us, cf, (-2753.46, 5790.72, 1909.05), (348.15, 72.71, 167.97), "ob_floater", undefined, "jup_urz_machinery_ranch_airplane_crashed_01_ob_rift_run", undefined, undefined, undefined, undefined, 300);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_features_cs";
  fe[[f]](s, us, cf, (-1747.29, 6590.53, 1564.02), (284.16, 65.36, -86.68), "ob_floater", undefined, "jup_urz_machinery_ranch_airplane_debris_fuselage_01_ob_rift_run", undefined, undefined, undefined, undefined, 333);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_features_cs";
  s.script_label = "280";
  fe[[f]](s, us, cf, (-12810, 9716.34, 703.25), (9.89, 53.71, -8.88), "ob_floater", undefined, "veh9_ind_lnd_excavator_ob_rift_run", undefined, undefined, undefined, undefined, 280);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_features_cs";
  fe[[f]](s, us, cf, (-2056.16, 6106.37, 1576.92), (346.63, 314.25, 2.15), "ob_floater", undefined, "jup_urz_machinery_ranch_airplane_debris_fuselage_01_ob_rift_run", undefined, undefined, undefined, undefined, 333);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_features_cs";
  fe[[f]](s, us, cf, (-12211.5, 10092.3, 965.75), (0, 267.17, -165.17), "ob_floater", undefined, "me_rock_large_01_brown_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_features_cs";
  fe[[f]](s, us, cf, (-12340, 10211.7, 973), (13.12, 0, 0), "ob_floater", undefined, "me_rock_large_01_brown_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_features_cs";
  fe[[f]](s, us, cf, (-12383.8, 10017.8, 1045.75), (77.92, 231.63, 161.46), "ob_floater", undefined, "me_rock_large_01_brown_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_features_cs";
  fe[[f]](s, us, cf, (-7320.57, 14817.1, 2281.43), (31.69, 112.11, -169.09), "ob_floater", undefined, "veh9_ind_lnd_talfa_flatbed_static_ob_rift_run", undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_features_cs";
  fe[[f]](s, us, cf, (-7701.97, 15270.6, 2016.52), (272.18, 321.02, 89.77), "ob_floater", undefined, "veh8_mil_sea_zoscar_static_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_features_cs";
  fe[[f]](s, us, cf, (-7591.21, 15080.8, 2026.02), (272.18, 321.02, -20.51), "ob_floater", undefined, "veh8_mil_sea_zoscar_static_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_features_cs";
  fe[[f]](s, us, cf, (-7392.7, 15094.3, 2040.52), (272.18, 321.02, 121.28), "ob_floater", undefined, "veh8_mil_sea_zoscar_static_ob_rift_run");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_features_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-12351.5, 10225.6, 1045.15), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_features_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-1013.27, 7623.18, 1769.65), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_features_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-8018.12, 15295.1, 2160.62), (0, 5.44, 0));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_features_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-6741.05, 13944.8, 2045.38), (0, 22.85, 0));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_features_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-12664, 10101.8, 1155.9), (0, 313.62, 0));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_features_cs";
  s.content_key = "essence_large_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-1734.02, 6698.18, 1677.9), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_features_cs";
  fe[[f]](s, us, cf, (-12778.3, 10058.7, 1144.25), (339.69, 205.06, -12.37), "ob_floater", undefined, "veh9_ind_lnd_talfa_flatbed_static_ob_rift_run", undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_features_cs";
  s.content_key = "pap_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-2082.11, 6023.87, 1704.81), (353.37, 55.49, 7.67));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_hydro_ob_features_cs");
}