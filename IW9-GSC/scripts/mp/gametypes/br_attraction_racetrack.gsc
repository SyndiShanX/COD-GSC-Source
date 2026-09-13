/************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_attraction_racetrack.gsc
************************************************************/

init() {
  info = spawnStruct();
  level.brattractions["rt"] = info;
  info.nexttrackindex = 0;
  info.tracks = [];
  info.races = [];
  info.sounds = [];
  info.sounds["countdown_3"] = "breach_warning_beep_01";
  info.sounds["countdown_2"] = "breach_warning_beep_03";
  info.sounds["countdown_1"] = "breach_warning_beep_05";
  info.sounds["countdown_0"] = "veh_horn_large_long_01";
  info.sounds["checkpoint"] = "weap_cluster_target_beep";
  info.track_settings = [];
  settings = init_track_settings("default");
  settings.values["laps"] = 1;
  settings.values["icon"] = "ui_mp_br_mapmenu_icon_poi_sb_race_vehicle";
  settings.values["scriptable"] = "br_attraction_rt";
  settings.values["checkpoint_radius"] = 128;
  settings.values["checkpoint_depth"] = 50;
  settings.values["start_radius"] = 128;
  settings.values["start_depth"] = 250;
  settings.values["stop_speed"] = 3.0;
  settings.values["out_of_vehicle_time"] = 5.0;
  settings.values["out_of_bounds_dist"] = 1000;
  settings.values["out_of_bounds_time"] = 5.0;
  settings.values["icon_trigger_z_offset"] = -50.0;
  settings.values["vehicle_required"] = 1;
  settings.values["quest_type"] = "attraction_racetrack";
  settings.values["checkpoint_go"] = loadfx("vfx/iw8_br/gameplay/race/vfx_br_racetrack_checkpoint_current.vfx");
  settings.values["checkpoint_stop"] = loadfx("vfx/iw8_br/gameplay/race/vfx_br_racetrack_start.vfx");
  settings.values["checkpoint_next"] = loadfx("vfx/iw8_br/gameplay/race/vfx_br_racetrack_checkpoint_next.vfx");
  settings.values["checkpoint_finish"] = loadfx("vfx/iw8_br/gameplay/race/vfx_br_racetrack_finish.vfx");
  settings.values["rewards"] = [];
  settings.values["reward"][0] = "attraction_racetrack_0_star";
  settings.values["reward"][1] = "attraction_racetrack_1_star";
  settings.values["reward"][2] = "attraction_racetrack_2_star";
  settings.values["reward"][3] = "attraction_racetrack_3_star";
  settings.values["reward_splash"] = [];
  settings.values["reward_splash"][0] = "br_attraction_racetrack_0_star";
  settings.values["reward_splash"][1] = "br_attraction_racetrack_1_star";
  settings.values["reward_splash"][2] = "br_attraction_racetrack_2_star";
  settings.values["reward_splash"][3] = "br_attraction_racetrack_3_star";
  settings.values["reward_average_mph"] = [];
  settings.values["reward_average_mph"][0] = 0;
  settings.values["reward_average_mph"][1] = 0;
  settings.values["reward_average_mph"][2] = 30;
  settings.values["reward_average_mph"][3] = 35;
  settings.values["debug_color"] = (1, 1, 0);
  settings.values["launch_start_seconds"] = 0;
  settings.values["launch_start_offet"] = (0, 0, 0);
  settings.values["teleport_to_start"] = 0;
  settings.values["teleport_to_start_offset"] = (-1000, 0, 50);
  settings.values["teleport_to_start_velocity"] = (600, 0, 300);
  settings.values["use_track_origin_for_start_area"] = 0;
  settings.values["safe_area"] = getdvarint("dvar_3C227920D2746253", 0);
  _id_1925F7A4C45F0652 = init_track_settings("default_loop", "default");
  _id_1925F7A4C45F0652.values["laps"] = 3;
  _id_CE5765235480C61C = init_track_settings("default_heli", "default");
  _id_CE5765235480C61C.values["icon"] = "ui_mp_br_mapmenu_icon_poi_sb_race_helo";
  _id_CE5765235480C61C.values["scriptable"] = "br_attraction_rt_h";
  _id_CE5765235480C61C.values["stop_speed"] = 6.0;
  _id_CE5765235480C61C.values["icon_trigger_z_offset"] = -300.0;
  _id_CE5765235480C61C.values["quest_type"] = "attraction_racetrack_heli";
  _id_CE5765235480C61C.values["reward_average_mph"][0] = 0;
  _id_CE5765235480C61C.values["reward_average_mph"][1] = 0;
  _id_CE5765235480C61C.values["reward_average_mph"][2] = 40;
  _id_CE5765235480C61C.values["reward_average_mph"][3] = 50;
  _id_CE5765235480C61C.values["debug_color"] = (1, 0.5, 0);
  _id_FA2A58009686B112 = init_track_settings("default_loop_heli", "default_heli");
  _id_FA2A58009686B112.values["laps"] = 3;
  _id_E50CCB3BC5891581 = init_track_settings("default_player", "default");
  _id_E50CCB3BC5891581.values["vehicle_required"] = 0;
  _id_E50CCB3BC5891581.values["reward_average_mph"][0] = 0;
  _id_E50CCB3BC5891581.values["reward_average_mph"][1] = 0;
  _id_E50CCB3BC5891581.values["reward_average_mph"][2] = 8;
  _id_E50CCB3BC5891581.values["reward_average_mph"][3] = 10;
  _id_E50CCB3BC5891581.values["debug_color"] = (0.5, 0, 0.5);
  _id_A295BF0DD6849B85 = init_track_settings("parachute", "default_player");
  _id_A295BF0DD6849B85.values["icon"] = "ui_mp_br_mapmenu_icon_poi_sb_race_parachute";
  _id_A295BF0DD6849B85.values["scriptable"] = "br_attraction_rt_p";
  _id_A295BF0DD6849B85.values["quest_type"] = "attraction_racetrack_parachute";
  _id_A295BF0DD6849B85.values["checkpoint_radius"] = 150;
  _id_A295BF0DD6849B85.values["checkpoint_depth"] = 100;
  _id_A295BF0DD6849B85.values["checkpoint_go"] = loadfx("vfx/_requests/br_gameplay/vfx_br_racetrack_checkpoint_go.vfx");
  _id_A295BF0DD6849B85.values["checkpoint_stop"] = loadfx("vfx/_requests/br_gameplay/vfx_br_racetrack_checkpoint_stop.vfx");
  _id_A295BF0DD6849B85.values["checkpoint_next"] = loadfx("vfx/_requests/br_gameplay/vfx_br_racetrack_checkpoint_next.vfx");
  _id_A295BF0DD6849B85.values["reward_average_mph"][0] = 0;
  _id_A295BF0DD6849B85.values["reward_average_mph"][1] = 0;
  _id_A295BF0DD6849B85.values["reward_average_mph"][2] = 30;
  _id_A295BF0DD6849B85.values["reward_average_mph"][3] = 40;
  _id_9D00076D15DB1A96 = init_track_settings("parachute_offset", "parachute");
  _id_9D00076D15DB1A96.values["start_area"] = loadfx("vfx/_requests/br_gameplay/vfx_br_racetrack_checkpoint_go.vfx");
  _id_9D00076D15DB1A96.values["use_track_origin_for_start_area"] = 1;
  _id_8915A9B81698FF46 = init_track_settings("parachute_launch", "parachute_offset");
  _id_8915A9B81698FF46.values["launch_start_seconds"] = 5;
  _id_A1212068A74B990E = init_track_settings("parachute_teleport", "parachute_offset");
  _id_A1212068A74B990E.values["teleport_to_start"] = 1;
  _id_B9802CBCFFC651C4 = init_track_settings("parkour", "default_player");
  _id_B9802CBCFFC651C4.values["checkpoint_radius"] = 100;
  _id_3ACF1C0EBAF602F2::registerquestcategorytablevalues("attraction_racetrack");
  _id_3ACF1C0EBAF602F2::registerquestcategorytablevalues("attraction_racetrack_heli");
  _id_3ACF1C0EBAF602F2::registerquestcategorytablevalues("attraction_racetrack_parachute");
  init_map_data();
  thread init_tracks();
}

init_map_data() {
  switch (level.mapname) {
    case "mp_br_mechanics":
      init_structs_mp_br_mechanics();
      break;
    case "mp_donetsk":
    case "mp_donetsk2":
    case "mp_don3":
      init_structs_mp_don3();
      break;
    default:
      break;
  }
}

init_structs_mp_br_mechanics() {
  s = add_struct("attraction_racetrack", "straight_track_0", "straight_track");
  s struct_set_fields((-9272, -10232, 72), (0, 180, 0), "default");
  s = add_struct(s.target, "straight_track_1", "start");
  s struct_set_fields((-9656, -10232, 8), (0, 90, 0));
  s = add_struct(s.target);
  s struct_set_fields((-9656, -1848, 8), (0, 90, 0));
  s = add_struct("attraction_racetrack", "heli_track_0", "heli_track");
  s struct_set_fields((-1255.81, -2211.91, 1538.12), (0, 141.402, 0), "default_heli");
  s = add_struct(s.target, "heli_track_1", "start");
  s struct_set_fields((-2178.48, -1277.21, 1525.36), (0, 132.129, 0));
  s = add_struct(s.target, "heli_track_2");
  s struct_set_fields((-3418.77, 434.357, 1536.27), (0, 130.892, 0));
  s = add_struct(s.target, "heli_track_3");
  s struct_set_fields((-6122.78, 1224.86, 1535.8), (0, 198.626, 0));
  s = add_struct(s.target, "heli_track_4");
  s struct_set_fields((-5787.4, -173.091, 1537.42), (0, 317.732, 0));
  s = add_struct(s.target, "heli_track_5");
  s struct_set_fields((-4327.2, -1013.86, 1530.28), (0, 336.641, 0));
  s = add_struct(s.target, "heli_track_6");
  s struct_set_fields((-2902.22, -1779.94, 1536.53), (0, 334.658, 0));
  s = add_struct(s.target);
  s struct_set_fields((-1576.78, -2630.84, 1537.08), (0, 334.533, 0));
  s = add_struct("attraction_racetrack", "parachute_0", "parachute_track");
  s struct_set_fields((-37.2243, 3073.44, 2316.13), (0, -147.293, 0), "parachute");
  s = add_struct(s.target, "parachute_1", "start");
  s struct_set_fields((-37.2243, 3073.44, 2316.13), (48.461, -147.293, 0));
  s = add_struct(s.target, "parachute_2");
  s struct_set_fields((-469.178, 2527.17, 1977.93), (25.759, -127.961, 0));
  s = add_struct(s.target, "parachute_3");
  s struct_set_fields((-889.904, 1941.16, 1786.5), (28.9004, -127.327, 0));
  s = add_struct(s.target, "parachute_4");
  s struct_set_fields((-1327.1, 1326.09, 1589.18), (29.8412, -127.17, 0));
  s = add_struct(s.target, "parachute_5");
  s struct_set_fields((-1755.28, 746.239, 1400.7), (29.8525, -127.171, 0));
  s = add_struct(s.target, "parachute_6");
  s struct_set_fields((-2212.62, 160.249, 1206.32), (30.4746, -127.121, 0));
  s = add_struct(s.target, "parachute_7");
  s struct_set_fields((-2678.11, -419.317, 1011.95), (32.4123, -126.959, 0));
  s = add_struct(s.target, "parachute_8");
  s struct_set_fields((-3133.39, -1006.88, 817.574), (33.9916, -125.714, 0));
  s = add_struct(s.target, "parachute_9");
  s struct_set_fields((-3554.38, -1605.71, 626.147), (37.5615, -124.924, 0));
  s = add_struct(s.target);
  s struct_set_fields((-3964.68, -2238.81, 468.9), (20.5615, -124.924, 0));
  root = add_struct("attraction_racetrack", "fall_0", "fall");
  root struct_set_fields((6221, 8807, 0), (0, 0, 0), "parachute_teleport");
  s = add_struct(root.target, "fall_1", "start");
  s struct_set_fields((4938.11, 2536.09, 11423.8), (0, -101.003, 0));
  s = add_struct(s.target, "fall_2");
  s struct_set_fields((5008.09, 1942.54, 10939.1), (0, -101.997, 0));
  s = add_struct(s.target, "fall_3");
  s struct_set_fields((5186.29, 1232.79, 10747.6), (0, -98.1666, 0));
  s = add_struct(s.target, "fall_4");
  s struct_set_fields((5369.42, 513.604, 10553.3), (0, -122.033, 0));
  s = add_struct(s.target, "fall_5");
  s struct_set_fields((5346.53, -237.591, 10355.9), (0, -134.569, 0));
  s = add_struct(s.target, "fall_6");
  s struct_set_fields((5165.08, -922.597, 10170.4), (0, -146.095, 0));
  s = add_struct(s.target, "fall_7");
  s struct_set_fields((4811.56, -1586.32, 9973.09), (0, -171.729, 0));
  s = add_struct(s.target, "fall_8");
  s struct_set_fields((4298.77, -2105.97, 9781.66), (0, 178.848, 0));
  s = add_struct(s.target, "fall_9");
  s struct_set_fields((3689.95, -2489.92, 9593.17), (0, 173.71, 0));
  s = add_struct(s.target, "fall_10");
  s struct_set_fields((2996.89, -2761.18, 9397.16), (0, 169.399, 0));
  s = add_struct(s.target, "fall_11");
  s struct_set_fields((2274.69, -2871.28, 9118.13), (0, 168.412, 0));
  s = add_struct(s.target, "fall_12");
  s struct_set_fields((1575.78, -2946.96, 8775.51), (0, 160.293, 0));
  s = add_struct(s.target, "fall_13");
  s struct_set_fields((898.672, -2969.42, 8406.34), (0, 156.567, 0));
  s = add_struct(s.target, "fall_14");
  s struct_set_fields((169.231, -2949.85, 7963.68), (0, 154.399, 0));
  s = add_struct(s.target, "fall_15");
  s struct_set_fields((-409.541, -2920.51, 7563.72), (0, 148.412, 0));
  s = add_struct(s.target, "fall_16");
  s struct_set_fields((-1036.18, -2857.36, 7081.19), (0, 146.203, 0));
  s = add_struct(s.target, "fall_17");
  s struct_set_fields((-1622.58, -2771.29, 6592.77), (0, 146.203, 0));
  s = add_struct(s.target, "fall_18");
  s struct_set_fields((-2327.12, -2663.67, 6333.59), (0, 145.7, 0));
  s = add_struct(s.target, "fall_19");
  s struct_set_fields((-3052.84, -2574.26, 6138.98), (0, 142.134, 0));
  s = add_struct(s.target, "fall_20");
  s struct_set_fields((-3774.04, -2450.2, 5947.55), (0, 125.989, 0));
  s = add_struct(s.target, "fall_21");
  s struct_set_fields((-4483.29, -2197.09, 5750.24), (0, 107.795, 0));
  s = add_struct(s.target, "fall_22");
  s struct_set_fields((-5070.82, -1802.13, 5564.71), (0, 98.8261, 0));
  s = add_struct(s.target, "fall_23");
  s struct_set_fields((-5564.47, -1264.57, 5373.29), (0, 77.1676, 0));
  s = add_struct(s.target, "fall_24");
  s struct_set_fields((-5872.97, -604.144, 5181.87), (0, 62.7075, 0));
  s = add_struct(s.target, "fall_25");
  s struct_set_fields((-5987.73, 139.253, 4984.56), (0, 40.1422, 0));
  s = add_struct(s.target, "fall_26");
  s struct_set_fields((-5840.79, 862.931, 4790.2), (0, 16.9284, 0));
  s = add_struct(s.target, "fall_27");
  s struct_set_fields((-5435.82, 1466.86, 4598.78), (0, 6.3331, 0));
  s = add_struct(s.target, "fall_28");
  s struct_set_fields((-4845.65, 1874.65, 4410.3), (0, 5.1301, 0));
  s = add_struct(s.target, "fall_29");
  s struct_set_fields((-4123.65, 2046.59, 4166.19), (0, -4.26872, 0));
  s = add_struct(s.target, "fall_30");
  s struct_set_fields((-3399.07, 2110.94, 3829.56), (0, -8.32372, 0));
  s = add_struct(s.target, "fall_31");
  s struct_set_fields((-2719.41, 2141, 3460.16), (0, -8.88368, 0));
  s = add_struct(s.target, "fall_32");
  s struct_set_fields((-2014.81, 2147.61, 3037.81), (0, -13.4718, 0));
  s = add_struct(s.target, "fall_33");
  s struct_set_fields((-1410.26, 2133.81, 2636.03), (0, -14.449, 0));
  s = add_struct(s.target, "fall_34");
  s struct_set_fields((-780.761, 2110.83, 2168.98), (0, -14.449, 0));
  s = add_struct(s.target, "fall_35");
  s struct_set_fields((-196.354, 2089.38, 1685.22), (0, -14.449, 0));
  s = add_struct(s.target, "fall_36");
  s struct_set_fields((518.243, 2065.13, 1411.27), (0, -5.61044, 0));
  s = add_struct(s.target, "fall_37");
  s struct_set_fields((1243.45, 2104.36, 1216.59), (0, -5.60151, 0));
  s = add_struct(s.target, "fall_38");
  s struct_set_fields((1993.44, 2186.27, 1019.27), (0, -12.7897, 0));
  s = add_struct(s.target, "fall_39");
  s struct_set_fields((2691.08, 2090.89, 833.732), (0, -21.2083, 0));
  s = add_struct(s.target, "fall_40");
  s struct_set_fields((3362.52, 1747.23, 636.414), (0, -21.8548, 0));
  s = add_struct(s.target, "fall_41");
  s struct_set_fields((4026.48, 1467.85, 447.932), (0, -19.6318, 0));
  s = add_struct(s.target, "fall_42");
  s struct_set_fields((4688.44, 1155.77, 256.504), (0, -26.6462, 0));
  s = add_struct(s.target, "fall_43");
  s struct_set_fields((5316.35, 779.752, 65.0767), (0, -32.3303, 0));
  s = add_struct(s.target);
  s struct_set_fields((5956.91, 391.48, 8.125), (0, 149.86, 0));
}

init_structs_mp_don3() {
  s = add_struct("attraction_racetrack", "dirt_track_1", "dirt_track");
  s struct_set_fields((2282, 8522, -300), (0, -100, 0));
  s = add_struct(s.target, "dirt_track_2", "start");
  s struct_set_fields((2282, 8522, -358), (0, -100, 0));
  s = add_struct(s.target, "dirt_track_3");
  s struct_set_fields((1897, 7503, -298), (0, -162, 0));
  s = add_struct(s.target, "dirt_track_4");
  s struct_set_fields((628, 7677, -263), (0, 104, 0));
  s = add_struct(s.target, "dirt_track_5");
  s struct_set_fields((974, 8947, -370), (0, 43, 0));
  s = add_struct(s.target, "dirt_track_6");
  s struct_set_fields((1936, 9920, -350), (0, 71, 0));
  s = add_struct(s.target, "dirt_track_7");
  s struct_set_fields((2427, 11271, -305), (0, 115, 0));
  s = add_struct(s.target, "dirt_track_8");
  s struct_set_fields((1646, 11824, -314), (0, -143, 0));
  s = add_struct(s.target, "dirt_track_9");
  s struct_set_fields((1080, 11049, -328), (0, -63, 0));
  s = add_struct(s.target, "dirt_track_1");
  s struct_set_fields((1659, 10092, -222), (0, -49, 0));
  s = add_struct("attraction_racetrack", "road_track_1", "road_track");
  s struct_set_fields((-35189, -25817, -150), (0, -179, 0));
  s = add_struct(s.target, "road_track_2", "start");
  s struct_set_fields((-35189, -25817, -202), (0, -179, 0));
  s = add_struct(s.target, "road_track_3");
  s struct_set_fields((-36019, -26228, -207), (0, -105, 0));
  s = add_struct(s.target, "road_track_4");
  s struct_set_fields((-35873, -26800, -271), (0, -27, 0));
  s = add_struct(s.target, "road_track_5");
  s struct_set_fields((-35146, -26585, -255), (0, 32, 0));
  s = add_struct(s.target, "road_track_6");
  s struct_set_fields((-34321, -26460, -232), (0, -65, 0));
  s = add_struct(s.target, "road_track_7");
  s struct_set_fields((-34432, -27197, -338), (0, -131, 0));
  s = add_struct(s.target, "road_track_8");
  s struct_set_fields((-35124, -28055, -325), (0, -131, 0));
  s = add_struct(s.target, "road_track_9");
  s struct_set_fields((-35096, -28558, -335), (0, -26, 0));
  s = add_struct(s.target, "road_track_10");
  s struct_set_fields((-34460, -28502, -347), (0, 22, 0));
  s = add_struct(s.target, "road_track_11");
  s struct_set_fields((-33633, -28058, -364), (0, 59, 0));
  s = add_struct(s.target, "road_track_12");
  s struct_set_fields((-33500, -27140, -351), (0, 110, 0));
  s = add_struct(s.target, "road_track_1");
  s struct_set_fields((-33984, -26074, -215), (0, 140, 0));
  s = add_struct("attraction_racetrack", "uphill_dirt_0", "uphill_dirt");
  s struct_set_fields((-4454.8, -12041.1, -351.647), (0, 48.1276, 0));
  s = add_struct(s.target, "uphill_dirt_1", "start");
  s struct_set_fields((-4052.9, -11311.2, -282.524), (0, 72.6117, 0));
  s = add_struct(s.target, "uphill_dirt_2");
  s struct_set_fields((-3865.13, -10344.9, -133.489), (0, 88.638, 0));
  s = add_struct(s.target, "uphill_dirt_3");
  s struct_set_fields((-3870.31, -9926.52, -75.8408), (0, 43.2208, 0));
  s = add_struct(s.target, "uphill_dirt_4");
  s struct_set_fields((-3339.44, -9525.36, 14.3617), (0, -27.4863, 0));
  s = add_struct(s.target, "uphill_dirt_5");
  s struct_set_fields((-2767.59, -9986.72, 64.3101), (0, -72.9221, 0));
  s = add_struct(s.target, "uphill_dirt_6");
  s struct_set_fields((-2575.03, -11112.6, 35.5608), (0, -104.188, 0));
  s = add_struct(s.target, "uphill_dirt_7");
  s struct_set_fields((-2799.25, -11966.3, 67.1033), (0, -108.498, 0));
  s = add_struct(s.target, "uphill_dirt_8");
  s struct_set_fields((-2959.9, -12741.7, 132.72), (0, -84.0948, 0));
  s = add_struct(s.target, "uphill_dirt_9");
  s struct_set_fields((-2849.84, -13250.2, 190.297), (0, -42.8435, 0));
  s = add_struct(s.target, "uphill_dirt_10");
  s struct_set_fields((-2270.82, -13302.2, 231.409), (0, 55.3769, 0));
  s = add_struct(s.target, "uphill_dirt_11");
  s struct_set_fields((-1905.72, -12350.7, 240.66), (0, 76.391, 0));
  s = add_struct(s.target, "uphill_dirt_12");
  s struct_set_fields((-1877.16, -11198.9, 295.32), (0, 91.0341, 0));
  s = add_struct(s.target, "uphill_dirt_13");
  s struct_set_fields((-1867.53, -10436.2, 384.207), (0, 53.1185, 0));
  s = add_struct(s.target, "uphill_dirt_14");
  s struct_set_fields((-1662.04, -10165.4, 427.518), (0, 15.0923, 0));
  s = add_struct(s.target, "uphill_dirt_15");
  s struct_set_fields((-1082.6, -10387.1, 493.172), (0, -68.4153, 0));
  s = add_struct(s.target, "uphill_dirt_16");
  s struct_set_fields((-976.138, -10931.4, 538.159), (0, -92.6662, 0));
  s = add_struct(s.target, "uphill_dirt_17");
  s struct_set_fields((-929.977, -11893.4, 616.467), (0, -89.8582, 0));
  s = add_struct(s.target, "uphill_dirt_18");
  s struct_set_fields((-824.219, -12612.6, 660.346), (0, -43.9617, 0));
  s = add_struct(s.target);
  s struct_set_fields((-69.4329, -12879.3, 650.479), (0, -5.55755, 0));
  s = add_struct("attraction_racetrack", "heli_docks_0", "heli_docks");
  s struct_set_fields((30631.1, -27312.3, 544.316), (0, 42.723, 0), "default_heli");
  s = add_struct(s.target, "heli_docks_1", "start");
  s struct_set_fields((31551.7, -25531.3, 431.433), (0, 37.6003, 0));
  s = add_struct(s.target, "heli_docks_2");
  s struct_set_fields((32766.9, -25307.2, 357.02), (0, -55.7985, 0));
  s = add_struct(s.target, "heli_docks_3");
  s struct_set_fields((33706.7, -25452.4, 317.005), (0, 38.2907, 0));
  s = add_struct(s.target, "heli_docks_4");
  s struct_set_fields((34036.6, -24353.4, 318.321), (0, 129.829, 0));
  s = add_struct(s.target, "heli_docks_5");
  s struct_set_fields((33777.3, -23324.6, 296.691), (0, 35.6732, 0));
  s = add_struct(s.target, "heli_docks_6");
  s struct_set_fields((34874.1, -23111.1, 288.313), (0, -51.0362, 0));
  s = add_struct(s.target, "heli_docks_7");
  s struct_set_fields((35938.8, -23071.7, 255.575), (0, 60.7619, 0));
  s = add_struct(s.target, "heli_docks_8");
  s struct_set_fields((35990.5, -21770.4, 338.241), (0, 104.201, 0));
  s = add_struct(s.target, "heli_docks_9");
  s struct_set_fields((35406.6, -20636.1, 297.357), (0, 80.4244, 0));
  s = add_struct(s.target, "heli_docks_10");
  s struct_set_fields((36056, -19467.3, 373.526), (0, 28.0346, 0));
  s = add_struct(s.target, "heli_docks_11");
  s struct_set_fields((37017.6, -18484.2, 361.559), (0, 90.6327, 0));
  s = add_struct(s.target, "heli_docks_12");
  s struct_set_fields((36236.5, -17508.8, 303.393), (0, 157.25, 0));
  s = add_struct(s.target);
  s struct_set_fields((35436, -16490.5, 323.557), (0, 92.051, 0));
  s = add_struct("attraction_racetrack", "heli_downtown_0", "heli_downtown");
  s struct_set_fields((17798.1, -26014.5, 857.089), (0, 46.4944, 0), "default_heli");
  s = add_struct(s.target, "heli_downtown_1", "start");
  s struct_set_fields((20268.6, -23499.6, 651.079), (0, 58.1386, 0));
  s = add_struct(s.target, "heli_downtown_2");
  s struct_set_fields((20996.4, -21826.4, 925.314), (0, 89.8682, 0));
  s = add_struct(s.target, "heli_downtown_3");
  s struct_set_fields((20463.5, -19722.4, 954.762), (0, 66.8182, 0));
  s = add_struct(s.target, "heli_downtown_4");
  s struct_set_fields((21179.6, -17956.4, 106.486), (0, 48.9976, 0));
  s = add_struct(s.target, "heli_downtown_5");
  s struct_set_fields((22772.3, -16442.1, 58.0422), (0, 70.2274, 0));
  s = add_struct(s.target, "heli_downtown_6");
  s struct_set_fields((22878.8, -14666.7, 404.65), (0, 78.988, 0));
  s = add_struct(s.target, "heli_downtown_7");
  s struct_set_fields((23302.2, -12103.1, 786.722), (0, 95.3662, 0));
  s = add_struct(s.target, "heli_downtown_8");
  s struct_set_fields((23229.2, -9531.39, 700.331), (0, 122.259, 0));
  s = add_struct(s.target, "heli_downtown_9");
  s struct_set_fields((21951.4, -8710.33, 595.926), (0, 155.669, 0));
  s = add_struct(s.target, "heli_downtown_10");
  s struct_set_fields((19965, -7548.74, 696.756), (0, 155.75, 0));
  s = add_struct(s.target, "heli_downtown_11");
  s struct_set_fields((17876.3, -6683.39, 979.536), (0, 155.75, 0));
  s = add_struct(s.target, "heli_downtown_12");
  s struct_set_fields((16069.3, -6144.31, 1288.92), (0, 119.353, 0));
  s = add_struct(s.target, "heli_downtown_13");
  s struct_set_fields((14917.1, -4301.08, 1457.46), (0, 99.6488, 0));
  s = add_struct(s.target);
  s struct_set_fields((14191.7, -1655.18, 1162.99), (0, 99.6488, 0));
  s = add_struct("attraction_racetrack", "coastal_highway_0", "coastal_highway");
  s struct_set_fields((-29226.8, -36388.1, 165.642), (0, -101.354, 0));
  s = add_struct(s.target, "coastal_highway_1", "start");
  s struct_set_fields((-29226.8, -36388.1, 165.642), (0, -96.0734, 0));
  s = add_struct(s.target, "coastal_highway_2");
  s struct_set_fields((-28857.9, -38096.6, 34.1278), (0, -51.0187, 0));
  s = add_struct(s.target, "coastal_highway_3");
  s struct_set_fields((-26593.1, -39500.7, 132.676), (0, -15.6259, 0));
  s = add_struct(s.target, "coastal_highway_4");
  s struct_set_fields((-24171.8, -40195.9, 593.391), (0, -17.8266, 0));
  s = add_struct(s.target, "coastal_highway_5");
  s struct_set_fields((-21828.5, -41091.5, 746.504), (0, -40.7774, 0));
  s = add_struct(s.target, "coastal_highway_6");
  s struct_set_fields((-20096.3, -42567.8, 422.232), (0, -28.0408, 0));
  s = add_struct(s.target, "coastal_highway_7");
  s struct_set_fields((-17611.8, -43478.2, 350.621), (0, -6.34824, 0));
  s = add_struct(s.target, "coastal_highway_8");
  s struct_set_fields((-14652.9, -43452.2, 338.377), (0, 5.10091, 0));
  s = add_struct(s.target, "coastal_highway_9");
  s struct_set_fields((-12348.2, -42904.1, 303.415), (0, 33.2737, 0));
  s = add_struct(s.target, "coastal_highway_10");
  s struct_set_fields((-10070.7, -41409.7, 62.687), (0, 26.9912, 0));
  s = add_struct(s.target, "coastal_highway_11");
  s struct_set_fields((-6414.67, -41455.3, 190.125), (0, -16.9006, 0));
  s = add_struct(s.target, "coastal_highway_12");
  s struct_set_fields((-3399.88, -41825.2, 367.647), (0, 12.0316, 0));
  s = add_struct(s.target, "coastal_highway_13");
  s struct_set_fields((-1057.21, -40667.5, 331.77), (0, 48.3813, 0));
  s = add_struct(s.target, "coastal_highway_14");
  s struct_set_fields((943.523, -38551.1, 189.994), (0, 38.0607, 0));
  s = add_struct(s.target, "coastal_highway_15");
  s struct_set_fields((5126.79, -36145.4, -220.989), (0, 22.9111, 0));
  s = add_struct(s.target, "coastal_highway_16");
  s struct_set_fields((7473.94, -35108.2, -416.556), (0, 31.9838, 0));
  s = add_struct(s.target, "coastal_highway_17");
  s struct_set_fields((9018.81, -33973.3, -452.779), (0, 48.2474, 0));
  s = add_struct(s.target, "coastal_highway_18");
  s struct_set_fields((10318.3, -34228.9, -467.71), (0, 60.6908, 0));
  s = add_struct(s.target);
  s struct_set_fields((10814.1, -32577.5, -468.683), (0, 78.442, 0));
  s = add_struct("attraction_racetrack", "promenade_run_01_0", "promenade_run_01");
  s struct_set_fields((-25007.3, -30145.2, -62.8176), (0, 31.4219, 0));
  s = add_struct(s.target, "promenade_run_01_1", "start");
  s struct_set_fields((-24879.1, -30047, -114.891), (0, 25.7355, 0));
  s = add_struct(s.target, "promenade_run_01_2");
  s struct_set_fields((-23546.1, -29114.1, -122.883), (0, 39.1003, 0));
  s = add_struct(s.target, "promenade_run_01_3");
  s struct_set_fields((-22172, -28099, -127.84), (0, 35.7275, 0));
  s = add_struct(s.target, "promenade_run_01_4");
  s struct_set_fields((-21139.5, -27434.7, -147.177), (0, 32.3042, 0));
  s = add_struct(s.target, "promenade_run_01_5");
  s struct_set_fields((-19665.4, -26520.4, -171.466), (0, 31.6731, 0));
  s = add_struct(s.target, "promenade_run_01_6");
  s struct_set_fields((-18361.7, -25716.3, -216.071), (0, 31.6735, 0));
  s = add_struct(s.target, "promenade_run_01_7");
  s struct_set_fields((-17245, -25162.6, -257.978), (0, 23.1678, 0));
  s = add_struct(s.target, "promenade_run_01_8");
  s struct_set_fields((-15829.4, -24535.1, -280.775), (0, 24.2468, 0));
  s = add_struct(s.target, "promenade_run_01_9");
  s struct_set_fields((-13938.9, -23566.7, -283.985), (0, 29.284, 0));
  s = add_struct(s.target, "promenade_run_01_10");
  s struct_set_fields((-11934.4, -22371.9, -340.712), (0, 32.437, 0));
  s = add_struct(s.target, "promenade_run_01_11");
  s struct_set_fields((-10046.3, -21792.4, -284.082), (0, 359.719, 0));
  s = add_struct(s.target, "promenade_run_01_12");
  s struct_set_fields((-8434.62, -21709.7, -290.493), (0, 1.9463, 0));
  s = add_struct(s.target, "promenade_run_01_13");
  s struct_set_fields((-6276.03, -21600.6, -290.897), (0, 356.407, 0));
  s = add_struct(s.target, "promenade_run_01_14");
  s struct_set_fields((-4840.39, -22090.8, -291.827), (0, 339.537, 0));
  s = add_struct(s.target, "promenade_run_01_15");
  s struct_set_fields((-2939.13, -22435.5, -288.984), (0, 346.789, 0));
  s = add_struct(s.target, "promenade_run_01_16");
  s struct_set_fields((-1090.32, -23171.9, -295.983), (0, 347.301, 0));
  s = add_struct(s.target, "promenade_run_01_17");
  s struct_set_fields((528.719, -23243.8, -290.924), (0, 1.86763, 0));
  s = add_struct(s.target, "promenade_run_01_18");
  s struct_set_fields((2561.34, -22916.7, -294.275), (0, 8.17223, 0));
  s = add_struct(s.target, "promenade_run_01_19");
  s struct_set_fields((3574.26, -22989.5, -287.944), (0, 348.701, 0));
  s = add_struct(s.target, "promenade_run_01_20");
  s struct_set_fields((4135.16, -22961.6, -288.092), (0, 22.6866, 0));
  s = add_struct(s.target, "promenade_run_01_21");
  s struct_set_fields((5070.4, -22570.2, -291.527), (0, 16.4588, 0));
  s = add_struct(s.target, "promenade_run_01_22");
  s struct_set_fields((6961.49, -21761.4, -291.841), (0, 4.77025, 0));
  s = add_struct(s.target, "promenade_run_01_23");
  s struct_set_fields((8596.59, -21913.5, -295.881), (0, 6.44528, 0));
  s = add_struct(s.target, "promenade_run_01_24");
  s struct_set_fields((9832.32, -22064, -296.157), (0, 356.24, 0));
  s = add_struct(s.target, "promenade_run_01_25");
  s struct_set_fields((11182.6, -22017.8, -212.133), (0, 359.738, 0));
  s = add_struct(s.target);
  s struct_set_fields((13252.2, -22000.2, -195.272), (0, 359.764, 0));
  s = add_struct("attraction_racetrack", "river_run_01_0", "river_run_01");
  s struct_set_fields((11995.1, -34312.7, -1200), (0, 77.557, 0), "default_heli");
  s = add_struct(s.target, "river_run_01_1", "start");
  s struct_set_fields((12004.4, -34351.5, -886.745), (0, 78.2187, 0));
  s = add_struct(s.target, "river_run_01_2");
  s struct_set_fields((12394, -32190, -205.794), (0, 78.3663, 0));
  s = add_struct(s.target, "river_run_01_3");
  s struct_set_fields((13281.9, -27822.1, -277.291), (0, 80.5996, 0));
  s = add_struct(s.target, "river_run_01_4");
  s struct_set_fields((14030.4, -21942.6, -488.119), (0, 98.9227, 0));
  s = add_struct(s.target, "river_run_01_5");
  s struct_set_fields((13721.9, -19620.4, -625.459), (0, 102.194, 0));
  s = add_struct(s.target, "river_run_01_6");
  s struct_set_fields((13787.4, -16983.8, -444.546), (0, 82.5528, 0));
  s = add_struct(s.target, "river_run_01_7");
  s struct_set_fields((14071.1, -12105.2, -497.452), (0, 83.6489, 0));
  s = add_struct(s.target, "river_run_01_8");
  s struct_set_fields((13725, -7944.75, -516.614), (0, 98.0605, 0));
  s = add_struct(s.target, "river_run_01_9");
  s struct_set_fields((12428.8, -374.614, -469.604), (0, 102.122, 0));
  s = add_struct(s.target, "river_run_01_10");
  s struct_set_fields((10675, 4933, 156), (0, 92.708, 0));
  s = add_struct(s.target, "river_run_01_11");
  s struct_set_fields((10055.7, 6332.54, -362.871), (0, 107.665, 0));
  s = add_struct(s.target, "river_run_01_12");
  s struct_set_fields((8244.4, 8889.58, -334.883), (0, 111.898, 0));
  s = add_struct(s.target, "river_run_01_13");
  s struct_set_fields((8240.29, 10994.8, 188.638), (0, 101.035, 0));
  s = add_struct(s.target, "river_run_01_14");
  s struct_set_fields((6631.77, 17226.1, -2.67198), (0, 129.544, 0));
  s = add_struct(s.target, "river_run_01_15");
  s struct_set_fields((4480.25, 21179.9, -183.634), (0, 123.169, 0));
  s = add_struct(s.target, "river_run_01_16");
  s struct_set_fields((1314.55, 25332.6, -282.273), (0, 129.449, 0));
  s = add_struct(s.target, "river_run_01_17");
  s struct_set_fields((-2689.08, 27566.7, -252.28), (0, 155.625, 0));
  s = add_struct(s.target, "river_run_01_18");
  s struct_set_fields((-7579.13, 29964.5, -100.648), (0, 157.057, 0));
  s = add_struct(s.target, "river_run_01_19");
  s struct_set_fields((-10676.1, 31967.2, -171.45), (0, 139.828, 0));
  s = add_struct(s.target, "river_run_01_20");
  s struct_set_fields((-13604.6, 34525.1, 44.1242), (0, 135.483, 0));
  s = add_struct(s.target, "river_run_01_21");
  s struct_set_fields((-16216, 37260.6, -23.8372), (0, 137.119, 0));
  s = add_struct(s.target, "river_run_01_22");
  s struct_set_fields((-18824, 41714.4, -302.625), (0, 101.683, 0));
  s = add_struct(s.target, "river_run_01_23");
  s struct_set_fields((-20359.8, 44833.2, 1000), (0, 111.973, 0));
  s = add_struct(s.target);
  s struct_set_fields((-22646.1, 48457.7, 3568.45), (0, 123.876, 0));
  s = add_struct("attraction_racetrack", "river_heli_1_0", "river_heli_1");
  s struct_set_fields((45277.7, 37015.5, -465.432), (0, -120.789, 0), "default_heli");
  s = add_struct(s.target, "river_heli_1_1", "start");
  s struct_set_fields((46217.9, 39129.5, -526.781), (0, 247.843, 0));
  s = add_struct(s.target, "river_heli_1_2");
  s struct_set_fields((45439, 37304.3, -357.643), (0, 236.633, 0));
  s = add_struct(s.target, "river_heli_1_3");
  s struct_set_fields((44437.6, 35382.5, -405.26), (0, 261.456, 0));
  s = add_struct(s.target, "river_heli_1_4");
  s struct_set_fields((44432.1, 31830.8, -421.1), (0, 251.02, 0));
  s = add_struct(s.target, "river_heli_1_5");
  s struct_set_fields((43318.1, 29546, -367.038), (0, 263.726, 0));
  s = add_struct(s.target, "river_heli_1_6");
  s struct_set_fields((42930.2, 27563.3, -319.779), (0, 262.509, 0));
  s = add_struct(s.target, "river_heli_1_7");
  s struct_set_fields((42380.3, 25431.1, -311.644), (0, 263.534, 0));
  s = add_struct(s.target, "river_heli_1_8");
  s struct_set_fields((42498.8, 23183.1, 156.358), (0, 266.995, 0));
  s = add_struct(s.target, "river_heli_1_9");
  s struct_set_fields((42273.6, 20194.2, -172.049), (0, 262.514, 0));
  s = add_struct(s.target, "river_heli_1_10");
  s struct_set_fields((42799.9, 16940, -486.454), (0, 278.457, 0));
  s = add_struct(s.target, "river_heli_1_11");
  s struct_set_fields((42559.9, 14854, -380.37), (0, 257.795, 0));
  s = add_struct(s.target, "river_heli_1_12");
  s struct_set_fields((42389.7, 12152.1, -419.334), (0, 264.566, 0));
  s = add_struct(s.target, "river_heli_1_13");
  s struct_set_fields((42775.5, 7215.19, -425.199), (0, 272.402, 0));
  s = add_struct(s.target, "river_heli_1_14");
  s struct_set_fields((42766.2, 3877.76, -326.015), (0, 258.183, 0));
  s = add_struct(s.target, "river_heli_1_15");
  s struct_set_fields((41663.1, 358.884, -300.156), (0, 240.632, 0));
  s = add_struct(s.target, "river_heli_1_16");
  s struct_set_fields((39239.5, -2053.17, -254.255), (0, 210.322, 0));
  s = add_struct(s.target, "river_heli_1_17");
  s struct_set_fields((36518.5, -4334.15, -370.94), (0, 227.294, 0));
  s = add_struct(s.target, "river_heli_1_18");
  s struct_set_fields((34584.8, -6386.75, -396.755), (0, 229.013, 0));
  s = add_struct(s.target, "river_heli_1_19");
  s struct_set_fields((34419.6, -8247.17, 89.6135), (0, 246.644, 0));
  s = add_struct(s.target, "river_heli_1_20");
  s struct_set_fields((34150.3, -10144.2, -606.727), (0, 259.529, 0));
  s = add_struct(s.target, "river_heli_1_21");
  s struct_set_fields((34209.5, -11349.5, -499.648), (0, 274.501, 0));
  s = add_struct(s.target, "river_heli_1_22");
  s struct_set_fields((34157.5, -15421.6, -590.942), (0, 265.793, 0));
  s = add_struct(s.target, "river_heli_1_23");
  s struct_set_fields((34071.5, -19079, -398.572), (0, 269.83, 0));
  s = add_struct(s.target, "river_heli_1_24");
  s struct_set_fields((33243.9, -21808.4, -435.775), (0, 229.344, 0));
  s = add_struct(s.target, "river_heli_1_25");
  s struct_set_fields((31003.4, -23615.7, -464.561), (0, 227.088, 0));
  s = add_struct(s.target, "river_heli_1_26");
  s struct_set_fields((28552.9, -26342.1, -140.413), (0, 256.046, 0));
  s = add_struct(s.target, "river_heli_1_27");
  s struct_set_fields((28442.2, -28786.2, -333.179), (0, -88.95, 0));
  s = add_struct(s.target);
  s struct_set_fields((28532.6, -30514.7, -1029.93), (0, -97.9852, 0));
  s = add_struct("attraction_racetrack", "atc_parachute_run_0", "atc_parachute_run");
  s struct_set_fields((-22483.8, 26918, 1176.13), (0, -89.798, 0), "parachute");
  s = add_struct(s.target, "atc_parachute_run_1", "start");
  s struct_set_fields((-22483.8, 26918, 1176.13), (1.60811, -89.798, 0));
  s = add_struct(s.target, "atc_parachute_run_2");
  s struct_set_fields((-22547.6, 26245.5, 792.678), (5.50656, -112.575, 0));
  s = add_struct(s.target, "atc_parachute_run_3");
  s struct_set_fields((-22715.2, 25434.8, 568.85), (8.55731, -154.861, 0));
  s = add_struct(s.target, "atc_parachute_run_4");
  s struct_set_fields((-23185.7, 24902.8, 380.368), (9.09393, 162.846, 0));
  s = add_struct(s.target, "atc_parachute_run_5");
  s struct_set_fields((-23912.8, 24766, 183.05), (9.10629, 145.543, 0));
  s = add_struct(s.target, "atc_parachute_run_6");
  s struct_set_fields((-24599.1, 25005.9, -8.37703), (8.9875, 129.456, 0));
  s = add_struct(s.target, "atc_parachute_run_7");
  s struct_set_fields((-25151.6, 25512.1, -205.695), (9.75964, 110.635, 0));
  s = add_struct(s.target, "atc_parachute_run_8");
  s struct_set_fields((-25478.3, 26199.9, -405.957), (9.78711, 92.0656, 0));
  s = add_struct(s.target);
  s struct_set_fields((-25535.6, 26971.2, -609.165), (6.75658, 86.0221, 0));
  s = add_struct("attraction_racetrack", "gulag_glide_01_0", "gulag_glide_01");
  s struct_set_fields((50350.3, -36481, 2912.88), (0, 117.186, 0), "parachute");
  s = add_struct(s.target, "gulag_glide_01_1", "start");
  s struct_set_fields((50350.3, -36481, 2912.88), (8.74548, 117.186, 0));
  s = add_struct(s.target, "gulag_glide_01_2");
  s struct_set_fields((49903.6, -35665.5, 2513.88), (6.3611, 124.572, 0));
  s = add_struct(s.target, "gulag_glide_01_3");
  s struct_set_fields((49231.4, -35068.7, 2278.28), (4.74851, 126.532, 0));
  s = add_struct(s.target, "gulag_glide_01_4");
  s struct_set_fields((48599.2, -34599.4, 2102.76), (3.58567, 127.407, 0));
  s = add_struct(s.target, "gulag_glide_01_5");
  s struct_set_fields((48011.5, -34191, 1823.34), (2.84684, 127.876, 0));
  s = add_struct(s.target, "gulag_glide_01_6");
  s struct_set_fields((47449, -33689.3, 1585.6), (-2.23607, 134.447, 0));
  s = add_struct(s.target, "gulag_glide_01_7");
  s struct_set_fields((46916.4, -33138.9, 1386.12), (-5.27413, 139.015, 0));
  s = add_struct(s.target, "gulag_glide_01_8");
  s struct_set_fields((46343.9, -32667.8, 1191.75), (-9.0452, 148.72, 0));
  s = add_struct(s.target, "gulag_glide_01_9");
  s struct_set_fields((45661.8, -32381.2, 997.382), (-7.11057, 155.791, 0));
  s = add_struct(s.target, "gulag_glide_01_10");
  s struct_set_fields((44942.3, -32246.8, 805.955), (-7.08276, 158.482, 0));
  s = add_struct(s.target, "gulag_glide_01_11");
  s struct_set_fields((44243.4, -31998.9, 611.583), (-7.07933, 158.594, 0));
  s = add_struct(s.target, "gulag_glide_01_12");
  s struct_set_fields((43574.5, -31674.5, 417.21), (-7.07933, 158.594, 0));
  s = add_struct(s.target, "gulag_glide_01_13");
  s struct_set_fields((42890.5, -31356.2, 219.893), (-7.07864, 158.634, 0));
  s = add_struct(s.target, "gulag_glide_01_14");
  s struct_set_fields((42184.1, -31127.4, 25.5205), (-7.10233, 160.658, 0));
  s = add_struct(s.target, "gulag_glide_01_15");
  s struct_set_fields((41479.8, -31060.8, -160.017), (-7.41064, 166.819, 0));
  s = add_struct(s.target);
  s struct_set_fields((40559.4, -31135, -401.51), (-7.93867, 175.2, 0));
  s = add_struct("attraction_racetrack", "mountain_track_1_0", "mountain_track_1");
  s struct_set_fields((-2724.12, 49133.9, 1843.98), (0, -86.5825, 0), "default");
  s = add_struct(s.target, "mountain_track_1_1", "start");
  s struct_set_fields((-2649.48, 49054.2, 1718.21), (0, 273.185, 0));
  s = add_struct(s.target, "mountain_track_1_2");
  s struct_set_fields((-2654.3, 48034, 1854.05), (0, 265.072, 0));
  s = add_struct(s.target, "mountain_track_1_3");
  s struct_set_fields((-2778.83, 46951, 1945.21), (0, 247.477, 0));
  s = add_struct(s.target, "mountain_track_1_4");
  s struct_set_fields((-3780.44, 45790.2, 2231), (0, 212.123, 0));
  s = add_struct(s.target, "mountain_track_1_5");
  s struct_set_fields((-4294.31, 45324.5, 2375.49), (0, 266.341, 0));
  s = add_struct(s.target, "mountain_track_1_6");
  s struct_set_fields((-4204.06, 44130.4, 2265.63), (0, 279.306, 0));
  s = add_struct(s.target, "mountain_track_1_7");
  s struct_set_fields((-3468.04, 43029, 2278.85), (0, 309.932, 0));
  s = add_struct(s.target, "mountain_track_1_8");
  s struct_set_fields((-2490.32, 41674.8, 2492.85), (0, 303.019, 0));
  s = add_struct(s.target, "mountain_track_1_9");
  s struct_set_fields((-1720.68, 41006.3, 2669.42), (0, 336.193, 0));
  s = add_struct(s.target, "mountain_track_1_10");
  s struct_set_fields((-958.595, 40107.7, 2741.67), (0, 327.947, 0));
  s = add_struct(s.target, "mountain_track_1_11");
  s struct_set_fields((-17.4407, 39364.3, 2702.3), (0, 314.243, 0));
  s = add_struct(s.target, "mountain_track_1_12");
  s struct_set_fields((367.618, 39056.5, 2581.61), (0, 331.086, 0));
  s = add_struct(s.target, "mountain_track_1_13");
  s struct_set_fields((1323.94, 39147.4, 2415.27), (0, 27.6778, 0));
  s = add_struct(s.target, "mountain_track_1_14");
  s struct_set_fields((2022.63, 39946.6, 2276.08), (0, 53.6908, 0));
  s = add_struct(s.target, "mountain_track_1_15");
  s struct_set_fields((2719.96, 40068.4, 2146.95), (0, 287.583, 0));
  s = add_struct(s.target, "mountain_track_1_16");
  s struct_set_fields((2805.01, 39254.4, 1971.35), (0, 267.835, 0));
  s = add_struct(s.target, "mountain_track_1_17");
  s struct_set_fields((2357.3, 38117.5, 2071.18), (0, 229.85, 0));
  s = add_struct(s.target, "mountain_track_1_18");
  s struct_set_fields((883.228, 37931.2, 2056.12), (0, 169.072, 0));
  s = add_struct(s.target, "mountain_track_1_19");
  s struct_set_fields((303.189, 37454.6, 1937.73), (0, 306.892, 0));
  s = add_struct(s.target, "mountain_track_1_20");
  s struct_set_fields((1834.46, 37121.2, 1985.35), (0, 353.189, 0));
  s = add_struct(s.target, "mountain_track_1_21");
  s struct_set_fields((1763.24, 36435.9, 2003.59), (0, 218.18, 0));
  s = add_struct(s.target, "mountain_track_1_22");
  s struct_set_fields((1015.62, 36617.8, 1896.92), (0, 150.144, 0));
  s = add_struct(s.target, "mountain_track_1_23");
  s struct_set_fields((494.614, 36287.1, 1681.99), (0, 277.29, 0));
  s = add_struct(s.target, "mountain_track_1_24");
  s struct_set_fields((755.282, 35456.8, 1579.55), (0, 316.769, 0));
  s = add_struct(s.target, "mountain_track_1_25");
  s struct_set_fields((1736.81, 34824.6, 1323.69), (0, 337.987, 0));
  s = add_struct(s.target, "mountain_track_1_26");
  s struct_set_fields((2686.17, 34257.4, 1021.11), (0, 310.578, 0));
  s = add_struct(s.target, "mountain_track_1_27");
  s struct_set_fields((1646.4, 33360.1, 666.204), (0, 214.379, 0));
  s = add_struct(s.target, "mountain_track_1_28");
  s struct_set_fields((1719.39, 32218.2, 294.569), (0, 314.028, 0));
  s = add_struct(s.target, "mountain_track_1_29");
  s struct_set_fields((3639.06, 31321.3, 252.056), (0, 341.071, 0));
  s = add_struct(s.target, "mountain_track_1_30");
  s struct_set_fields((4601.85, 30882.2, 357.633), (0, 334.504, 0));
  s = add_struct(s.target, "mountain_track_1_31");
  s struct_set_fields((6083.37, 30763.1, 533.283), (0, 309.256, 0));
  s = add_struct(s.target, "mountain_track_1_32");
  s struct_set_fields((7192.68, 29779.3, 1005.19), (0, 337.319, 0));
  s = add_struct(s.target, "mountain_track_1_33");
  s struct_set_fields((8145.17, 30572.4, 1340.03), (0, 82.4312, 0));
  s = add_struct(s.target, "mountain_track_1_34");
  s struct_set_fields((8186.12, 31521.3, 1577.37), (0, 133.028, 0));
  s = add_struct(s.target, "mountain_track_1_35");
  s struct_set_fields((7926.41, 32928.1, 1771.32), (0, 98.077, 0));
  s = add_struct(s.target, "mountain_track_1_36");
  s struct_set_fields((7507.58, 33810.4, 1853.41), (0, 137.455, 0));
  s = add_struct(s.target, "mountain_track_1_37");
  s struct_set_fields((7143.45, 34890.2, 1747.24), (0, 91.2613, 0));
  s = add_struct(s.target, "mountain_track_1_38");
  s struct_set_fields((7066.88, 36291.7, 1500.8), (0, 90.7638, 0));
  s = add_struct(s.target, "mountain_track_1_39");
  s struct_set_fields((6960.4, 37008, 1440.27), (0, 106.425, 0));
  s = add_struct(s.target, "mountain_track_1_40");
  s struct_set_fields((6077.66, 38198.6, 1115.9), (0, 117.312, 0));
  s = add_struct(s.target);
  s struct_set_fields((5303.74, 39372, 1116.03), (0, 71.8124, 0));
  s = add_struct("attraction_racetrack", "tv_station_parachute_0", "tv_station_parachute");
  s struct_set_fields((14668, 15277.5, 1873.31), (0, -89.2678, 0), "parachute");
  s = add_struct(s.target, "tv_station_parachute_1", "start");
  s struct_set_fields((14668, 15277.5, 1873.31), (12.2461, -89.2678, 0));
  s = add_struct(s.target, "tv_station_parachute_2");
  s struct_set_fields((14699.2, 14633.8, 1475.46), (16.4573, -89.1607, 0));
  s = add_struct(s.target, "tv_station_parachute_3");
  s struct_set_fields((14780, 13797, 1242.79), (16.9331, -90.6699, 0));
  s = add_struct(s.target, "tv_station_parachute_4");
  s struct_set_fields((14870.5, 12991.9, 1030.75), (17.1185, -91.1516, 0));
  s = add_struct(s.target, "tv_station_parachute_5");
  s struct_set_fields((14761.7, 12248.4, 833.43), (17.8069, -107.09, 0));
  s = add_struct(s.target, "tv_station_parachute_6");
  s struct_set_fields((14435.6, 11507.6, 621.388), (18.3298, -115.917, 0));
  s = add_struct(s.target, "tv_station_parachute_7");
  s struct_set_fields((13957.4, 10784.7, 394.62), (18.3205, -115.712, 0));
  s = add_struct(s.target, "tv_station_parachute_8");
  s struct_set_fields((13496.7, 9939.96, 141.347), (18.2652, -109.655, 0));
  s = add_struct(s.target, "tv_station_parachute_9");
  s struct_set_fields((13507.6, 9183.22, -58.9157), (18.0651, -86.6791, 0));
  s = add_struct(s.target, "tv_station_parachute_10");
  s struct_set_fields((13864.6, 8538.22, -253.288), (16.7374, -62.8858, 0));
  s = add_struct(s.target);
  s struct_set_fields((14171.1, 8140, -336.451), (0, -46.0214, 0));
  s = add_struct("attraction_racetrack", "downtown_parachute_1_0", "downtown_parachute_1");
  s struct_set_fields((16499.5, -5402.92, 1866.19), (0, -42.5521, 0), "parachute");
  s = add_struct(s.target, "downtown_parachute_1_1", "start");
  s struct_set_fields((16499.5, -5402.92, 1866.19), (16.8445, -42.5521, 0));
  s = add_struct(s.target, "downtown_parachute_1_2");
  s struct_set_fields((17054.4, -5887.82, 1570.82), (16.8445, -42.5521, 0));
  s = add_struct(s.target, "downtown_parachute_1_3");
  s struct_set_fields((17602.8, -6356.03, 1373.5), (16.8445, -42.5521, 0));
  s = add_struct(s.target, "downtown_parachute_1_4");
  s struct_set_fields((18160, -6847.97, 1179.12), (16.5856, -53.4121, 0));
  s = add_struct(s.target, "downtown_parachute_1_5");
  s struct_set_fields((18706.5, -7399.84, 975.918), (17.263, -69.4607, 0));
  s = add_struct(s.target, "downtown_parachute_1_6");
  s struct_set_fields((19158.7, -8123.06, 752.095), (16.7665, -83.8254, 0));
  s = add_struct(s.target, "downtown_parachute_1_7");
  s struct_set_fields((19436.1, -8836.44, 551.833), (16.7312, -83.8738, 0));
  s = add_struct(s.target, "downtown_parachute_1_8");
  s struct_set_fields((19529.4, -9578.63, 354.516), (13.7686, -126.261, 0));
  s = add_struct(s.target, "downtown_parachute_1_9");
  s struct_set_fields((19280.4, -10274.5, 160.143), (13.2269, -130.439, 0));
  s = add_struct(s.target, "downtown_parachute_1_10");
  s struct_set_fields((18800.3, -10881.4, -43.0645), (10.2818, -133.575, 0));
  s = add_struct(s.target, "downtown_parachute_1_11");
  s struct_set_fields((18314.7, -11382, -225.657), (10.2815, -133.574, 0));
  s = add_struct(s.target);
  s struct_set_fields((17806.3, -11930.8, -279.468), (2.01085, -138.975, 0));
  s = add_struct("attraction_racetrack", "lumber_prison_0", "lumber_prison");
  s struct_set_fields((58753.7, 2202.63, 24.8555), (0, -107.512, 0), "default");
  s = add_struct(s.target, "lumber_prison_1", "start");
  s struct_set_fields((58071.1, 743.05, 38.73), (0, -116.527, 0));
  s = add_struct(s.target, "lumber_prison_2");
  s struct_set_fields((56738.9, -1236.08, 30.7725), (0, -120.638, 0));
  s = add_struct(s.target, "lumber_prison_3");
  s struct_set_fields((55505.4, -2712.91, -319.956), (0, -123.009, 0));
  s = add_struct(s.target, "lumber_prison_4");
  s struct_set_fields((54326, -4385.79, -775.152), (0, -106.531, 0));
  s = add_struct(s.target, "lumber_prison_5");
  s struct_set_fields((53931.4, -6102.01, -812.773), (0, -102.943, 0));
  s = add_struct(s.target, "lumber_prison_6");
  s struct_set_fields((52998.4, -6183.97, -802.957), (0, -123.799, 0));
  s = add_struct(s.target, "lumber_prison_7");
  s struct_set_fields((52528.6, -7360.5, -766.357), (0, -77.8444, 0));
  s = add_struct(s.target, "lumber_prison_8");
  s struct_set_fields((52865.9, -8664.67, -730.729), (0, 89.4245, 0));
  s = add_struct(s.target, "lumber_prison_9");
  s struct_set_fields((53738.5, -8929.6, -749.819), (0, -19.5814, 0));
  s = add_struct(s.target, "lumber_prison_10");
  s struct_set_fields((54643.3, -9755.44, -729.468), (0, -49.2898, 0));
  s = add_struct(s.target, "lumber_prison_11");
  s struct_set_fields((54855.8, -10453.2, -709.516), (0, -76.8247, 0));
  s = add_struct(s.target, "lumber_prison_12");
  s struct_set_fields((54768.2, -11923.4, -707.317), (0, -96.0285, 0));
  s = add_struct(s.target, "lumber_prison_13");
  s struct_set_fields((54615.7, -13526.7, -559.911), (0, -99.1915, 0));
  s = add_struct(s.target, "lumber_prison_14");
  s struct_set_fields((54506.2, -14301.2, -510.083), (0, -22.2047, 0));
  s = add_struct(s.target, "lumber_prison_15");
  s struct_set_fields((55651, -14225.5, -546.652), (0, 174.359, 0));
  s = add_struct(s.target, "lumber_prison_16");
  s struct_set_fields((56817.9, -14625.3, -435.056), (0, -99.4665, 0));
  s = add_struct(s.target, "lumber_prison_17");
  s struct_set_fields((56846.5, -16952, -426.621), (0, -90.0499, 0));
  s = add_struct(s.target, "lumber_prison_18");
  s struct_set_fields((56805.2, -18664.1, -417.14), (0, -142.745, 0));
  s = add_struct(s.target, "lumber_prison_19");
  s struct_set_fields((56657.3, -19503.3, -340.779), (0, -121.295, 0));
  s = add_struct(s.target, "lumber_prison_20");
  s struct_set_fields((55804.8, -20488.7, -366.262), (0, -121.113, 0));
  s = add_struct(s.target, "lumber_prison_21");
  s struct_set_fields((54886.7, -21772.9, -379.961), (0, 66.7394, 0));
  s = add_struct(s.target, "lumber_prison_22");
  s struct_set_fields((55475.9, -24201.3, -271.562), (0, -80.0259, 0));
  s = add_struct(s.target, "lumber_prison_23");
  s struct_set_fields((55118.9, -25697.9, -53.7674), (0, -162.467, 0));
  s = add_struct(s.target, "lumber_prison_24");
  s struct_set_fields((54330.5, -26107.5, 18.4929), (0, -111.228, 0));
  s = add_struct(s.target, "lumber_prison_25");
  s struct_set_fields((54002.1, -27469.8, 160.735), (0, -114.251, 0));
  s = add_struct(s.target, "lumber_prison_26");
  s struct_set_fields((52429.5, -28347.5, 227.717), (0, -140.796, 0));
  s = add_struct(s.target, "lumber_prison_27");
  s struct_set_fields((51610.6, -29519.4, 420.438), (0, -106.982, 0));
  s = add_struct(s.target, "lumber_prison_28");
  s struct_set_fields((50955.1, -31342.2, 880.445), (0, -95.0771, 0));
  s = add_struct(s.target, "lumber_prison_29");
  s struct_set_fields((50969.7, -33258.2, 1239.3), (0, -89.2795, 0));
  s = add_struct(s.target, "lumber_prison_30");
  s struct_set_fields((51062.2, -34847.2, 1344.2), (0, -89.1421, 0));
  s = add_struct(s.target, "lumber_prison_31");
  s struct_set_fields((51075, -36562, 1344.16), (0, -89.0027, 0));
  s = add_struct(s.target);
  s struct_set_fields((51062.6, -38714.4, 1340.92), (0, -97.7166, 0));
  s = add_struct("attraction_racetrack", "port_crane_heli_1_0", "port_crane_heli_1");
  s struct_set_fields((36160.4, -16299.6, -458.097), (0, -91.812, 0), "default_heli");
  s = add_struct(s.target, "port_crane_heli_1_1", "start");
  s struct_set_fields((36147.2, -16263.1, -363.1), (0.422337, 268.514, -1.99109));
  s = add_struct(s.target, "port_crane_heli_1_2");
  s struct_set_fields((36291, -18078, -363.472), (0.12314, 268.714, -2.46018));
  s = add_struct(s.target, "port_crane_heli_1_3");
  s struct_set_fields((36038.8, -20275.2, -296.624), (355.426, 268.5, -1.98652));
  s = add_struct(s.target, "port_crane_heli_1_4");
  s struct_set_fields((35459.2, -22451, -269.129), (0.372097, 226.891, -3.12304));
  s = add_struct(s.target, "port_crane_heli_1_5");
  s struct_set_fields((34603.2, -23717.8, -296.816), (6.30215, 227.102, -1.15972));
  s = add_struct(s.target, "port_crane_heli_1_6");
  s struct_set_fields((33152.2, -24771.2, -270.002), (0.0594956, 223.019, -2.64621));
  s = add_struct(s.target, "port_crane_heli_1_7");
  s struct_set_fields((32230.6, -26110, -302.265), (353.917, 223.841, 1.12121));
  s = add_struct(s.target, "port_crane_heli_1_8");
  s struct_set_fields((30616.2, -28668.5, 48.0325), (343.703, 249.771, 0.482141));
  s = add_struct(s.target, "port_crane_heli_1_9");
  s struct_set_fields((29959, -32314.8, -296.557), (355.488, 263.852, 3.30579));
  s = add_struct(s.target, "port_crane_heli_1_10");
  s struct_set_fields((29806.3, -33497.9, -95.2916), (357.199, 265.108, 1.96188));
  s = add_struct(s.target, "port_crane_heli_1_11");
  s struct_set_fields((30120, -34473.9, -305.69), (4.76768, 264.351, -1.19089));
  s = add_struct(s.target);
  s struct_set_fields((29996.2, -36169.8, -305.968), (358.817, 264.264, -2.31078));
  s = add_struct("attraction_racetrack", "dam_para_high_0", "dam_para_high");
  s struct_set_fields((-19019.1, 50957.8, 2695.63), (0, -68.2997, 0), "parachute_teleport");
  s = add_struct(s.target, "dam_para_high_1", "start");
  s struct_set_fields((-17250.7, 44222.3, 18500.2), (0.111012, -47.4682, 0));
  s = add_struct(s.target, "dam_para_high_2");
  s struct_set_fields((-16115.4, 43043.3, 18104), (21.2588, -46.8152, 0));
  s = add_struct(s.target, "dam_para_high_3");
  s struct_set_fields((-15090.6, 42076, 17800.7), (21.2588, -46.8152, 0));
  s = add_struct(s.target, "dam_para_high_4");
  s struct_set_fields((-14164.6, 41180.8, 17345), (21.2588, -46.8152, 0));
  s = add_struct(s.target, "dam_para_high_5");
  s struct_set_fields((-13121.4, 40152.2, 16923.4), (17.4087, -39.6669, 0));
  s = add_struct(s.target, "dam_para_high_6");
  s struct_set_fields((-12001.3, 39174.3, 16528.7), (17.5948, 1.4128, 0));
  s = add_struct(s.target, "dam_para_high_7");
  s struct_set_fields((-10597.7, 38832, 16148.8), (22.7124, 17.6523, 0));
  s = add_struct(s.target, "dam_para_high_8");
  s struct_set_fields((-9097.77, 38961.6, 15754.2), (24.2862, 16.4741, 0));
  s = add_struct(s.target, "dam_para_high_9");
  s struct_set_fields((-7692.93, 39330.3, 15374.3), (42.1984, 9.53411, 0));
  s = add_struct(s.target, "dam_para_high_10");
  s struct_set_fields((-6283.77, 39550.2, 14744.7), (59.8521, -5.04202, 0));
  s = add_struct(s.target, "dam_para_high_11");
  s struct_set_fields((-4957.43, 39618, 13701.9), (76.4645, -2.98861, 0));
  s = add_struct(s.target, "dam_para_high_12");
  s struct_set_fields((-3949.19, 39622.8, 12625.9), (74.4705, -5.36955, 0));
  s = add_struct(s.target, "dam_para_high_13");
  s struct_set_fields((-2943.84, 39563.5, 11353.4), (74.4705, -5.36955, 0));
  s = add_struct(s.target, "dam_para_high_14");
  s struct_set_fields((-1543.51, 39452.3, 10832.5), (27.2645, -4.41305, 0));
  s = add_struct(s.target, "dam_para_high_15");
  s struct_set_fields((-114.77, 39389.1, 10458.5), (25.9946, -4.32688, 0));
  s = add_struct(s.target, "dam_para_high_16");
  s struct_set_fields((1333.43, 39182.4, 10072.7), (23.5587, -45.4165, 0));
  s = add_struct(s.target, "dam_para_high_17");
  s struct_set_fields((2402.04, 38134.8, 9672.21), (28.9684, -86.6273, 0));
  s = add_struct(s.target, "dam_para_high_18");
  s struct_set_fields((2826.8, 36775.3, 9298.19), (22.7011, -87.2618, 0));
  s = add_struct(s.target, "dam_para_high_19");
  s struct_set_fields((2839.64, 35269.1, 8903.57), (19.044, -77.0696, 0));
  s = add_struct(s.target, "dam_para_high_20");
  s struct_set_fields((2803.36, 33742.1, 8368.43), (23.7465, -76.8079, 0));
  s = add_struct(s.target, "dam_para_high_21");
  s struct_set_fields((2844.56, 32312.3, 7653.69), (40.2576, -74.4119, 0));
  s = add_struct(s.target, "dam_para_high_22");
  s struct_set_fields((2874.56, 30977.2, 6757.22), (40.3482, -74.5458, 0));
  s = add_struct(s.target, "dam_para_high_23");
  s struct_set_fields((2958.13, 29442.7, 5473.43), (40.3482, -74.5458, 0));
  s = add_struct(s.target, "dam_para_high_24");
  s struct_set_fields((3089.03, 28215.1, 4279.18), (40.6074, -73.4578, 0));
  s = add_struct(s.target, "dam_para_high_25");
  s struct_set_fields((3236.82, 27167.3, 3157.31), (41.5897, -70.7909, 0));
  s = add_struct(s.target, "dam_para_high_26");
  s struct_set_fields((3426.25, 26054.6, 2140.32), (35.2029, -70.7387, 0));
  s = add_struct(s.target, "dam_para_high_27");
  s struct_set_fields((3699.61, 24627.8, 1720.77), (39.5957, -67.2735, 0));
  s = add_struct(s.target, "dam_para_high_28");
  s struct_set_fields((4129.4, 23229.3, 1337.91), (33.6239, -65.5971, 0));
  s = add_struct(s.target, "dam_para_high_29");
  s struct_set_fields((4662.11, 21865.4, 955.058), (31.8039, -64.9005, 0));
  s = add_struct(s.target, "dam_para_high_30");
  s struct_set_fields((5159.98, 20500.6, 575.148), (27.3359, -64.3834, 0));
  s = add_struct(s.target, "dam_para_high_31");
  s struct_set_fields((5694.7, 19150.2, 194.314), (27.2813, -64.37, 0));
  s = add_struct(s.target, "dam_para_high_32");
  s struct_set_fields((6214.37, 17955.5, -553.811), (13.9271, -63.0578, 0));
  s = add_struct(s.target);
  s struct_set_fields((6693.58, 17163, -639.875), (0, -75.6008, 0));
}

add_struct(targetname, target, script_noteworthy) {
  struct = spawnStruct();
  struct.targetname = targetname;
  struct.target = target;
  struct.script_noteworthy = script_noteworthy;
  scripts\engine\utility::_id_1F6C1A9B7564DC61(struct);
  return struct;
}

struct_set_fields(origin, angles, script_parameters) {
  self.origin = origin;
  self.angles = angles;
  self.script_parameters = script_parameters;
}

init_track_settings(name, parent) {
  settings = spawnStruct();
  settings.parent = parent;
  settings.values = [];
  level.brattractions["rt"].track_settings[name] = settings;
  return settings;
}

init_tracks() {
  _id_CDD53D78F51F6B97 = level.brattractions["rt"];
  tracks = scripts\engine\utility::getStructArray("attraction_racetrack", "targetname");

  foreach(track in tracks)
  init_track(track);
}

init_track(track) {
  _id_CDD53D78F51F6B97 = level.brattractions["rt"];

  if(!isDefined(track.index) || track.index < 0)
    track.index = get_next_track_index();

  if(!isDefined(track.angles))
    track.angles = (0, 0, 0);

  _id_18176E8F61BB2E83 = getdvarint("dvar_DF918A09D0908AA4", 0);

  if(_id_18176E8F61BB2E83 & 1 << track.index) {
    return;
  }
  _id_CDD53D78F51F6B97.tracks[track.index] = track;
  track.record = spawnStruct();

  if(!isDefined(track.name)) {
    track.name = track.script_noteworthy;

    if(!isDefined(track.name))
      track.name = "race_track" + track.index;
  }

  init_track_point(track);

  if(!isDefined(track.settings_group))
    apply_track_settings(track, track.script_parameters);

  caclulate_track_distance(track);
  _id_7336E692EC5A2F65 = get_track_setting(track, "use_track_origin_for_start_area");

  if(_id_7336E692EC5A2F65)
    track.start_loc = track;
  else
    track.start_loc = track.points[0];

  track.start_trigger = spawn("trigger_rotatable_radius", track.start_loc.origin, 0, get_track_setting(track, "start_radius"), get_track_setting(track, "start_depth"));

  if(_id_7336E692EC5A2F65)
    track.start_trigger.angles = track.start_loc.angles;
  else
    track.start_trigger.angles = track.start_loc.angles + (-90, 0, 0);

  track.locindex = get_track_location_index(track);
  track.startimes = get_track_star_times(track);
  icontrigger = _id_6731BE38C3B94FF7::createattractionicontrigger("race", track.locindex, track.start_loc.origin, 128, get_track_setting(track, "icon"), 2000, ::icon_trigger_enter, ::icon_trigger_exit, get_track_setting(track, "scriptable"));
  icontrigger.origin = icontrigger.origin + (0, 0, get_track_setting(track, "icon_trigger_z_offset"));

  if(isDefined(icontrigger.scriptable)) {
    icontrigger.scriptable.participantplunder = 1;
    icontrigger.scriptable.participantxp = 1;
    icontrigger.scriptable.participantweaponxp = 1;
  }

  track.icontrigger = icontrigger;
  icontrigger.track = track;
}

get_track_star_times(track) {
  if(!track.locindex)
    return undefined;

  startimes = [];
  startimes[0] = undefined;
  startimes[1] = get_track_star_time_from_col(track, 6);
  startimes[2] = get_track_star_time_from_col(track, 7);
  startimes[3] = get_track_star_time_from_col(track, 8);
  return startimes;
}

get_track_star_time_from_col(track, col) {
  time = tablelookup("mp/brattractions_race_locations.csv", 1, track.name, col);

  if(isDefined(time) && time == "")
    return undefined;

  return float(time);
}

get_track_location_index(track) {
  locindex = tablelookup("mp/brattractions_race_locations.csv", 1, track.name, 0);

  if(!isDefined(locindex) || locindex == "")
    locindex = 0;
  else
    locindex = int(locindex);

  return locindex;
}

get_next_track_index() {
  index = level.brattractions["rt"].nexttrackindex;
  level.brattractions["rt"].nexttrackindex++;
  return index;
}

delete_track(track) {
  track notify("track_delete");
  _id_6731BE38C3B94FF7::shutdownattractionicontrigger(track.icontrigger);
  track.start_trigger delete();
  level.brattractions["rt"].tracks[track.index] = undefined;
}

get_track_setting(track, _id_9C97919E51B42E2B) {
  _id_CDD53D78F51F6B97 = level.brattractions["rt"];
  value = undefined;
  settings_group = track.settings_group;

  for(;;) {
    _id_8C958BDE9A9F8547 = _id_CDD53D78F51F6B97.track_settings[settings_group].values[_id_9C97919E51B42E2B];

    if(isDefined(_id_8C958BDE9A9F8547)) {
      value = _id_8C958BDE9A9F8547;
      break;
    }

    settings_group = _id_CDD53D78F51F6B97.track_settings[settings_group].parent;

    if(!isDefined(settings_group)) {
      break;
    }
  }

  return value;
}

apply_track_settings(track, settings_group) {
  if(!isDefined(settings_group) || !isDefined(level.brattractions["rt"].track_settings[settings_group])) {
    if(track.loop)
      settings_group = "default_loop";
    else
      settings_group = "default";
  }

  track.settings_group = settings_group;
}

init_track_point(track) {
  if(isDefined(track.points)) {
    return;
  }
  track.loop = 0;
  track.points = [];
  targets = scripts\engine\utility::getStructArray(track.target, "targetname");

  foreach(target in targets) {
    type = target.script_noteworthy;

    if(!isDefined(type)) {
      continue;
    }
    switch (type) {
      case "start":
        add_track_points(track, target);
        break;
      default:
        break;
    }
  }
}

caclulate_track_distance(track) {
  track.dist_miles = 0.0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < track.points.size - 1; _id_AC0E594AC96AA3A8++)
    track.dist_miles = track.dist_miles + distance(track.points[_id_AC0E594AC96AA3A8].origin, track.points[_id_AC0E594AC96AA3A8 + 1].origin);

  if(track.loop)
    track.dist_miles = track.dist_miles + distance(track.points[track.points.size - 1].origin, track.points[0].origin);

  track.dist_miles = track.dist_miles * get_track_setting(track, "laps");
  track.dist_miles = track.dist_miles / 63360;
}

add_track_points(track, start) {
  point = start;

  for(;;) {
    if(!isDefined(point)) {
      break;
    }

    track.points[track.points.size] = point;

    if(!isDefined(point.target)) {
      break;
    }

    point = scripts\engine\utility::getStruct(point.target, "targetname");

    if(point == start) {
      track.loop = 1;
      break;
    }
  }
}

icon_trigger_enter(player, trigger) {
  track = trigger.track;
  level thread create_race(track, player);
}

icon_trigger_exit(player, trigger) {
  track = trigger.track;
  track notify("exit_icon_trigger_" + player getentitynumber());
}

create_race(track, player) {
  race = spawnStruct();
  race.player = player;
  race.track = track;
  race.times = [];

  if(istrue(level.brgametype.useserverhud)) {
    race.hud_racetrack_info = player _id_6731BE38C3B94FF7::createhudstring(0);
    race.hud_racetrack_timer = player _id_6731BE38C3B94FF7::createhudtimer(1);
  }

  thread delete_on_exit_icon_trigger_pre_race(race);
  thread delete_on_death_or_dissconnect(race);
  thread delete_on_track_delete(race);
  race.lap = -1;
  start_origin = track.points[0].origin;
  race.checkpoint_trigger = spawn("trigger_rotatable_radius", start_origin, 0, get_track_setting(track, "checkpoint_radius"), get_track_setting(track, "checkpoint_depth"));
  start_area_fx(race);
  checkpoint_fx_set(race, "checkpoint_stop");
  checkpoint_next_fx_set(race, "checkpoint_next");
  race_set_checkpoint(race, 0);
  race endon("race_delete");
  pre_race(race);
  race(race);
  post_race(race);
  delete_race(race);
}

start_area_fx(race) {
  _id_082787F7776408C5 = get_track_setting(race.track, "start_area");

  if(!isDefined(_id_082787F7776408C5)) {
    return;
  }
  race.start_area_fx = spawnfxforclient(_id_082787F7776408C5, race.track.start_loc.origin, race.player, anglestoup(race.track.start_loc.angles));
  race.start_area_fx setfxkilldefondelete();
  triggerfx(race.start_area_fx);
}

start_area_fx_end(race) {
  if(isDefined(race.start_area_fx))
    race.start_area_fx delete();
}

checkpoint_fx_set(race, _id_06DD4A74B5CEA5FB) {
  if(isDefined(race.checkpoint_fx) && race.checkpoint_fx.name == _id_06DD4A74B5CEA5FB) {
    return;
  }
  if(isDefined(race.checkpoint_fx)) {
    origin = race.checkpoint_fx.origin;
    angles = race.checkpoint_fx.angles;
    race.checkpoint_fx delete();
  } else {
    origin = race.track.points[0].origin;
    angles = race.track.points[0].angles;
  }

  _id_082787F7776408C5 = get_track_setting(race.track, _id_06DD4A74B5CEA5FB);
  race.checkpoint_fx = spawnfxforclient(_id_082787F7776408C5, origin, race.player, anglesToForward(angles));
  race.checkpoint_fx setfxkilldefondelete();
  race.checkpoint_fx.name = _id_06DD4A74B5CEA5FB;
}

checkpoint_fx_play(race) {
  triggerfx(race.checkpoint_fx);
}

checkpoint_next_fx_set(race, _id_06DD4A74B5CEA5FB) {
  if(isDefined(race.checkpoint_next_fx) && race.checkpoint_next_fx.name == _id_06DD4A74B5CEA5FB) {
    return;
  }
  if(isDefined(race.checkpoint_next_fx)) {
    origin = race.checkpoint_next_fx.origin;
    angles = race.checkpoint_next_fx.angles;
    race.checkpoint_next_fx delete();
  } else {
    origin = race.track.points[1].origin;
    angles = race.track.points[1].angles;
  }

  _id_082787F7776408C5 = get_track_setting(race.track, _id_06DD4A74B5CEA5FB);
  race.checkpoint_next_fx = spawnfxforclient(_id_082787F7776408C5, origin, race.player, anglesToForward(angles));
  race.checkpoint_next_fx setfxkilldefondelete();
  race.checkpoint_next_fx.name = _id_06DD4A74B5CEA5FB;
}

checkpoint_next_fx_play(race) {
  triggerfx(race.checkpoint_next_fx);
}

checkpoint_objective(race) {
  race.checkpoint_objective_id = scripts\mp\objidpoolmanager::requestobjectiveid(1);

  if(race.checkpoint_objective_id != -1) {
    current = race_get_current_checkpoint(race);
    origin = race.track.points[current].origin + (0, 0, 128);
    scripts\mp\objidpoolmanager::objective_add_objective(race.checkpoint_objective_id, "current", origin, "icon_waypoint_koth");
    scripts\mp\objidpoolmanager::update_objective_setbackground(race.checkpoint_objective_id, 0);
    objective_removeallfrommask(race.checkpoint_objective_id);
    objective_showtoplayersinmask(race.checkpoint_objective_id);
    objective_setplayintro(race.checkpoint_objective_id, 0);
    objective_addclienttomask(race.checkpoint_objective_id, race.player);
    objective_sethideelevation(race.checkpoint_objective_id, 1);
  }
}

pre_race_needs_vehicle(race) {
  if(race_requires_vehicle(race))
    return !race_is_player_driving_vehicle(race);
  else
    return 0;
}

pre_race(race) {
  _id_D72464ACAE98EC62 = 0;
  _id_EFF7E3FD1A1DF469 = 3;
  hudstate = "none";
  _id_C8D776E41ECC6881 = "none";

  if(race_requires_vehicle(race))
    race.race_ent = race.player.vehicle;
  else
    race.race_ent = race.player;

  _id_D431663F5BC9D2AC = get_track_setting(race.track, "stop_speed");

  for(;;) {
    if(!pre_race_needs_vehicle(race)) {
      if(race_requires_vehicle(race))
        race.race_ent = race.player.vehicle;
      else
        race.race_ent = race.player;

      if(race.race_ent istouching(race.track.start_trigger)) {
        if(!race.race_ent istouching(race.checkpoint_trigger)) {
          if(race_requires_vehicle(race))
            current_speed = race.race_ent vehicle_getspeed();
          else
            current_speed = length(race.player getvelocity());

          if(current_speed < _id_D431663F5BC9D2AC) {
            if(_id_C8D776E41ECC6881 != "countdown") {
              _id_C8D776E41ECC6881 = "countdown";
              _id_D72464ACAE98EC62 = gettime() + _id_EFF7E3FD1A1DF469 * 1000;
            }

            time_remaining = _id_D72464ACAE98EC62 - gettime();

            for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 <= 3; _id_AC0E594AC96AA3A8++) {
              if(time_remaining <= _id_AC0E594AC96AA3A8 * 1000) {
                if(time_remaining + level.frameduration > _id_AC0E594AC96AA3A8 * 1000)
                  race.player playlocalsound(level.brattractions["rt"].sounds["countdown_" + _id_AC0E594AC96AA3A8]);

                break;
              }
            }

            if(time_remaining <= 0)
              _id_C8D776E41ECC6881 = "go";
          } else
            _id_C8D776E41ECC6881 = "stop";
        } else
          _id_C8D776E41ECC6881 = "backup";
      } else
        _id_C8D776E41ECC6881 = "get_to_start";
    } else
      _id_C8D776E41ECC6881 = "needs_vehicle";

    if(hudstate != _id_C8D776E41ECC6881) {
      race notify("race_state_change");

      if(istrue(level.brgametype.useserverhud))
        race.hud_racetrack_timer.alpha = 0;

      switch (_id_C8D776E41ECC6881) {
        case "needs_vehicle":
          if(istrue(level.brgametype.useserverhud))
            race.hud_racetrack_info.label = &"MP_BR_INGAME/ATTRACT_RT_FIND_VEHICLE";

          race.player _id_6731BE38C3B94FF7::playersetattractionstateindex(0);
          thread race_ui_show_record(race);
          break;
        case "get_to_start":
          if(istrue(level.brgametype.useserverhud))
            race.hud_racetrack_info.label = &"MP_BR_INGAME/ATTRACT_RT_GET_TO_START";

          race.player _id_6731BE38C3B94FF7::playersetattractionstateindex(1);
          race.player _id_6731BE38C3B94FF7::playersetattractionextradata(0);
          race.player _id_6731BE38C3B94FF7::playersetattractiontime(0);
          thread race_ui_show_record(race);
          break;
        case "backup":
          if(istrue(level.brgametype.useserverhud))
            race.hud_racetrack_info.label = &"MP_BR_INGAME/ATTRACT_RT_TOO_CLOSE";

          race.player _id_6731BE38C3B94FF7::playersetattractionstateindex(3);
          thread race_ui_show_record(race);
          break;
        case "stop":
          if(istrue(level.brgametype.useserverhud))
            race.hud_racetrack_info.label = &"MP_BR_INGAME/ATTRACT_RT_STOP";

          race.player _id_6731BE38C3B94FF7::playersetattractionstateindex(2);
          thread race_ui_show_record(race);
          break;
        case "countdown":
          if(istrue(level.brgametype.useserverhud))
            race.hud_racetrack_info.label = &"MP_BR_INGAME/ATTRACT_RT_COUNTDOWN";

          thread race_countdown_update(race, _id_EFF7E3FD1A1DF469);
          race_ui_show_record_end(race);

          if(istrue(level.brgametype.useserverhud)) {
            race.hud_racetrack_timer.alpha = 1.0;
            race.hud_racetrack_timer.label = "";
            race.hud_racetrack_timer settenthstimer(_id_EFF7E3FD1A1DF469);
          }

          break;
        case "go":
          _id_6B9D01283E745C25 = get_track_setting(race.track, "teleport_to_start");

          if(_id_6B9D01283E745C25) {
            _id_984863BA729A2641 = track_get_teleport_target(race.track);
            race.player setOrigin(_id_984863BA729A2641);
            race.player setplayerangles(race.track.points[0].angles);
            vel = track_get_teleport_velocity(race.track);
            race.player setvelocity(vel);
          } else {
            _id_2A21FCAE30F2C84E = get_track_setting(race.track, "launch_start_seconds");

            if(_id_2A21FCAE30F2C84E > 0) {
              race.player setOrigin(race.player.origin + (0, 0, 20));
              vel = track_get_launch_velocity(race.track, race.player.origin, _id_2A21FCAE30F2C84E);
              race.player setvelocity(vel);
            }
          }

          start_area_fx_end(race);
          checkpoint_fx_set(race, "checkpoint_go");
          checkpoint_fx_play(race);

          if(istrue(level.brgametype.useserverhud))
            race.hud_racetrack_info.label = &"MP_BR_INGAME/ATTRACT_RT_GO";

          race.player _id_6731BE38C3B94FF7::playersetattractionstateindex(5);
          thread race_timer_update(race);
          race_ui_show_record_end(race);

          if(istrue(level.brgametype.useserverhud)) {
            race.hud_racetrack_timer.alpha = 1.0;
            race.hud_racetrack_timer.label = "";
            race.hud_racetrack_timer settenthstimerup(0);
          }

          return;
        default:
          break;
      }

      hudstate = _id_C8D776E41ECC6881;
    }

    waitframe();
  }
}

track_get_teleport_target(track) {
  _id_10932ABAE4BE7BDB = track.points[0];
  _id_08D6E41C46AE5AE4 = get_track_setting(track, "teleport_to_start_offset");
  _id_08D6E41C46AE5AE4 = rotatevector(_id_08D6E41C46AE5AE4, _id_10932ABAE4BE7BDB.angles);
  return _id_10932ABAE4BE7BDB.origin + _id_08D6E41C46AE5AE4;
}

track_get_teleport_velocity(track) {
  _id_10932ABAE4BE7BDB = track.points[0];
  velocity = get_track_setting(track, "teleport_to_start_velocity");
  velocity = rotatevector(velocity, _id_10932ABAE4BE7BDB.angles);
  return velocity;
}

track_get_launch_target(track) {
  _id_10932ABAE4BE7BDB = track.points[0];
  _id_08D6E41C46AE5AE4 = get_track_setting(track, "launch_start_offet");
  _id_08D6E41C46AE5AE4 = rotatevector(_id_08D6E41C46AE5AE4, _id_10932ABAE4BE7BDB.angles);
  return _id_10932ABAE4BE7BDB.origin + _id_08D6E41C46AE5AE4;
}

track_get_launch_velocity(track, start, time) {
  target = track_get_launch_target(track);
  vel = trajectorycalculateinitialvelocity(start, target, (0, 0, -800), time);
  return vel;
}

race_countdown_update(race, _id_EFF7E3FD1A1DF469) {
  race endon("race_state_change");
  race.player endon("death_or_disconnect");
  race.player _id_6731BE38C3B94FF7::playersetattractionstateindex(4);
  endtime = gettime() + _id_EFF7E3FD1A1DF469 * 1000;

  while(gettime() < endtime) {
    remainingtime = endtime - gettime();
    race.player _id_6731BE38C3B94FF7::playersetattractiontime(remainingtime);
    waitframe();
  }
}

race_timer_update(race) {
  race endon("post_race");
  race endon("race_delete");
  race endon("race_state_change");
  race.player endon("death_or_disconnect");
  start = gettime();

  for(;;) {
    _id_8266A3DC2B6CB1AF = gettime() - start;
    race.player _id_6731BE38C3B94FF7::playersetattractiontime(_id_8266A3DC2B6CB1AF);
    waitframe();
  }
}

race_ui_show_record(race) {
  if(!isDefined(race.track.record.times)) {
    return;
  }
  if(istrue(race.showing_ui_record)) {
    if(istrue(level.brgametype.useserverhud))
      race.hud_racetrack_timer.alpha = 1.0;

    return;
  }

  race endon("race_delete");
  race endon("race_ui_show_record_end");
  race.showing_ui_record = 1;
  race.player _id_6731BE38C3B94FF7::playersetattractionstateindex(17);
  _id_4B9799AE70B95B1C = int(race.track.record.times[race.track.record.times.size - 1]);
  race.player _id_6731BE38C3B94FF7::playersetattractionbesttime(_id_4B9799AE70B95B1C);
  race.player _id_6731BE38C3B94FF7::playersetattractionbestplayer(race.track.record.player);

  if(istrue(level.brgametype.useserverhud)) {
    for(;;) {
      race.hud_racetrack_timer.alpha = 1.0;
      _id_4B9799AE70B95B1C = race.track.record.times[race.track.record.times.size - 1];
      race.hud_racetrack_timer.label = &"MP_BR_INGAME/ATTRACT_RT_CURRENT_RECORD";
      race.hud_racetrack_timer settenthstimerstatic(_id_4B9799AE70B95B1C / 1000);
      wait 2;

      if(isDefined(race.track.record.player)) {
        race.hud_racetrack_timer.label = &"MP_BR_INGAME/ATTRACT_RT_CURRENT_RECORD_HOLDER";
        race.hud_racetrack_timer setplayernamestring(race.track.record.player);
        wait 2;
      }
    }
  }
}

race_ui_show_record_end(race) {
  race.showing_ui_record = 0;
  race notify("race_ui_show_record_end");
}

race(race) {
  race notify("race_active");
  race.critical_messages = [];
  _id_6731BE38C3B94FF7::playersetignoreattractions(race.player, 1);
  checkpoint_objective(race);
  thread race_set_player_safe(race);
  thread race_monitor_oob(race);
  thread race_update_stars(race);

  if(race_requires_vehicle(race)) {
    thread race_monitor_vehicle(race);
    thread race_monitor_out_of_vehicle(race);
  }

  race.start_time = gettime();

  for(;;) {
    race_wait_for_current_checkpoint(race);
    race.player playlocalsound(level.brattractions["rt"].sounds["checkpoint"]);
    race.times[race.times.size] = gettime() - race.start_time;
    finish = race_set_next_checkpoint(race);

    if(finish) {
      break;
    }

    thread race_ui_checkpoint(race);
  }
}

race_update_stars(race) {
  race endon("race_delete");
  race endon("post_race");
  prev_time = 0.0;

  for(_id_9FADE146C7EFC102 = 3; _id_9FADE146C7EFC102 >= 2; _id_9FADE146C7EFC102--) {
    race.player _id_6731BE38C3B94FF7::playersetattractionextradata(_id_9FADE146C7EFC102);
    _id_F5DFB2F6A1955B77 = track_get_reward_time(race.track, _id_9FADE146C7EFC102) - prev_time;
    wait(_id_F5DFB2F6A1955B77);
    prev_time = _id_F5DFB2F6A1955B77;
  }

  race.player _id_6731BE38C3B94FF7::playersetattractionextradata(1);
}

race_set_player_safe(race) {
  if(!get_track_setting(race.track, "safe_area")) {
    return;
  }
  race.player _id_2772CFD929B90043::playerentersafearea();
  race waittill("race_delete");

  if(isDefined(race.player))
    race.player _id_2772CFD929B90043::playerexitsafearea();
}

race_monitor_vehicle(race) {
  race endon("race_delete");
  race endon("post_race");
  race.race_ent waittill("death");
  delete_race(race);
}

race_is_player_driving_vehicle(race) {
  if(!race.player scripts\cp_mp\utility\player_utility::isinvehicle())
    return 0;

  return scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_occupantisvehicledriver(race.player);
}

race_monitor_out_of_vehicle(race) {
  race endon("race_delete");
  race endon("post_race");
  _id_6E4BE7381F0CBDD0 = 0;

  for(;;) {
    _id_BDFBC2E0FD3EF58A = !race_is_player_driving_vehicle(race);

    if(!_id_BDFBC2E0FD3EF58A)
      _id_BDFBC2E0FD3EF58A = race.race_ent != race.player.vehicle;

    if(_id_6E4BE7381F0CBDD0 != _id_BDFBC2E0FD3EF58A) {
      if(_id_BDFBC2E0FD3EF58A)
        race_ui_add_critical_message(race, "oov");
      else
        race_ui_remove_critical_message(race, "oov");

      _id_6E4BE7381F0CBDD0 = _id_BDFBC2E0FD3EF58A;
    }

    wait 0.05;
  }
}

race_monitor_oob(race) {
  race endon("race_delete");
  race endon("post_race");
  _id_2A21FCAE30F2C84E = get_track_setting(race.track, "launch_start_seconds");

  if(_id_2A21FCAE30F2C84E > 0)
    wait(_id_2A21FCAE30F2C84E + 1);

  _id_0110AC52BA86E301 = 0;

  for(;;) {
    current = race_get_current_checkpoint(race);

    if(current)
      previous = current - 1;
    else if(race.track.loop)
      previous = race.track.points.size - 1;
    else {
      previous = 0;
      current = 1;
    }

    start = race.track.points[previous].origin;
    end = race.track.points[current].origin;
    dist = dist_to_line_seg(race.race_ent.origin, start, end);
    _id_C2D4A285B08DF7E7 = dist > get_track_setting(race.track, "out_of_bounds_dist");

    if(_id_0110AC52BA86E301 != _id_C2D4A285B08DF7E7) {
      if(_id_C2D4A285B08DF7E7)
        race_ui_add_critical_message(race, "oob");
      else
        race_ui_remove_critical_message(race, "oob");

      _id_0110AC52BA86E301 = _id_C2D4A285B08DF7E7;
    }

    wait 0.05;
  }
}

race_ui_add_critical_message(race, type) {
  str = "";
  endtime = 0;

  switch (type) {
    case "oob":
      str = &"MP_BR_INGAME/ATTRACT_RT_OOB";
      endtime = gettime() + get_track_setting(race.track, "out_of_bounds_time") * 1000;
      break;
    case "oov":
      str = &"MP_BR_INGAME/ATTRACT_RT_OOV";
      endtime = gettime() + get_track_setting(race.track, "out_of_vehicle_time") * 1000;
      break;
    default:
      break;
  }

  message = race.critical_messages[type];

  if(!isDefined(message)) {
    message = spawnStruct();
    race.critical_messages[type] = message;
  }

  message.str = str;
  message.type = type;
  message.endtime = endtime;
  race_ui_critical_message_update(race);
}

race_ui_remove_critical_message(race, type) {
  race.critical_messages[type] = undefined;
  race_ui_critical_message_update(race);
}

race_ui_critical_message_update(race) {
  race notify("race_ui_critical_message_timer_end");

  if(race.critical_messages.size) {
    _id_683BFC29FC75937A = undefined;

    foreach(msg in race.critical_messages) {
      if(!isDefined(_id_683BFC29FC75937A)) {
        _id_683BFC29FC75937A = msg;
        continue;
      }

      if(msg.endtime < _id_683BFC29FC75937A.endtime)
        _id_683BFC29FC75937A = msg;
    }

    time_remaining = (_id_683BFC29FC75937A.endtime - gettime()) / 1000;

    if(istrue(level.brgametype.useserverhud)) {
      race.hud_racetrack_info.alpha = 1.0;
      race.hud_racetrack_info.label = _id_683BFC29FC75937A.str;
      race.hud_racetrack_info settenthstimer(time_remaining);
    }

    thread race_ui_critical_message_timer(race, time_remaining, _id_683BFC29FC75937A);
  } else
    race_ui_lap(race);
}

race_ui_critical_message_timer(race, timeremaining, message) {
  race endon("race_delete");
  race endon("post_race");
  race endon("race_ui_critical_message_timer_end");

  switch (message.type) {
    case "oob":
      race.player _id_6731BE38C3B94FF7::playersetattractionstateindex(12);
      break;
    case "oov":
      race.player _id_6731BE38C3B94FF7::playersetattractionstateindex(13);
      break;
    default:
      break;
  }

  endtime = int(gettime() + timeremaining * 1000);

  while(gettime() <= endtime) {
    remainingtime = endtime - gettime();
    race.player _id_6731BE38C3B94FF7::playersetattractionbesttime(remainingtime);
    waitframe();
  }

  delete_race(race);
}

race_ui_checkpoint(race) {
  race notify("race_ui_checkpoint");
  race endon("race_ui_checkpoint");
  race endon("post_race");
  race endon("race_delete");

  if(race.critical_messages.size) {
    return;
  }
  if(isDefined(race.track.record.times)) {
    if(istrue(level.brgametype.useserverhud))
      race.hud_racetrack_info.alpha = 1.0;

    index = race.times.size - 1;
    _id_3777ECE6A73EADA5 = race.times[index] - race.track.record.times[index];

    if(_id_3777ECE6A73EADA5 <= 0) {
      if(istrue(level.brgametype.useserverhud))
        race.hud_racetrack_info.label = &"MP_BR_INGAME/ATTRACT_RT_SPLIT_NEG";

      race.player _id_6731BE38C3B94FF7::playersetattractionstateindex(10);
    } else {
      if(istrue(level.brgametype.useserverhud))
        race.hud_racetrack_info.label = &"MP_BR_INGAME/ATTRACT_RT_SPLIT_POS";

      race.player _id_6731BE38C3B94FF7::playersetattractionstateindex(11);
    }

    _id_E8A61EF4EDC64087 = int(abs(_id_3777ECE6A73EADA5));
    race.player _id_6731BE38C3B94FF7::playersetattractionbesttime(_id_E8A61EF4EDC64087);

    if(istrue(level.brgametype.useserverhud)) {
      _id_3777ECE6A73EADA5 = max(1, abs(_id_3777ECE6A73EADA5));
      race.hud_racetrack_info settenthstimerstatic(_id_3777ECE6A73EADA5 / 1000);
    }

    wait 1.0;
  }

  race_ui_lap(race);
}

race_ui_lap(race) {
  if(race.critical_messages.size) {
    return;
  }
  if(race.track.loop) {
    lap = race.lap + 1;

    if(istrue(level.brgametype.useserverhud)) {
      race.hud_racetrack_info.label = &"MP_BR_INGAME/ATTRACT_RT_LAP_OF_3";
      race.hud_racetrack_info setvalue(lap);
    }

    state = 7;

    if(lap == 2)
      state = 8;
    else if(lap == 3)
      state = 9;

    race.player _id_6731BE38C3B94FF7::playersetattractionstateindex(state);
  } else {
    if(istrue(level.brgametype.useserverhud))
      race.hud_racetrack_info.alpha = 0;

    race.player _id_6731BE38C3B94FF7::playersetattractionstateindex(6);
  }
}

post_race(race) {
  race notify("post_race");
  _id_4B9799AE70B95B1C = undefined;

  if(isDefined(race.track.record.times))
    _id_4B9799AE70B95B1C = race.track.record.times[race.track.record.times.size - 1];

  end_time = race.times[race.times.size - 1];

  if(istrue(level.brgametype.useserverhud))
    race.hud_racetrack_info.alpha = 1.0;

  if(!isDefined(_id_4B9799AE70B95B1C) || end_time <= _id_4B9799AE70B95B1C) {
    _id_8973F7D500A9B0BB = race.track.record.player;

    if(isDefined(_id_4B9799AE70B95B1C)) {
      if(istrue(level.brgametype.useserverhud))
        race.hud_racetrack_info.label = &"MP_BR_INGAME/ATTRACT_RT_FINISH_NEW_RECORD_SPLIT";

      race.player _id_6731BE38C3B94FF7::playersetattractionstateindex(15);
      _id_3777ECE6A73EADA5 = _id_4B9799AE70B95B1C - end_time;
      _id_3777ECE6A73EADA5 = max(1, _id_3777ECE6A73EADA5);

      if(istrue(level.brgametype.useserverhud))
        race.hud_racetrack_info settenthstimerstatic(_id_3777ECE6A73EADA5 / 1000);

      _id_E8A61EF4EDC64087 = int(abs(_id_3777ECE6A73EADA5));
      race.player _id_6731BE38C3B94FF7::playersetattractionbesttime(_id_E8A61EF4EDC64087);
      race.player _id_6731BE38C3B94FF7::playersetattractionbestplayer(race.player);

      if(isDefined(race.track.record.player) && race.track.record.player != race.player)
        race.track.record.player _id_2772CFD929B90043::sandboxprintlinebold(&"MP_BR_INGAME/ATTRACT_RT_RECORD_BEAT", race.player);
    } else {
      if(istrue(level.brgametype.useserverhud)) {
        race.hud_racetrack_info.label = &"MP_BR_INGAME/ATTRACT_RT_FINISH_NEW_RECORD";
        race.hud_racetrack_info settext("");
      }

      race.player _id_6731BE38C3B94FF7::playersetattractionstateindex(14);
    }

    race.track.record.player = race.player;
    race.track.record.times = race.times;
  } else {
    if(istrue(level.brgametype.useserverhud))
      race.hud_racetrack_info.label = &"MP_BR_INGAME/ATTRACT_RT_FINISH_SPLIT";

    race.player _id_6731BE38C3B94FF7::playersetattractionstateindex(16);
    _id_3777ECE6A73EADA5 = end_time - _id_4B9799AE70B95B1C;
    _id_3777ECE6A73EADA5 = max(1, _id_3777ECE6A73EADA5);

    if(istrue(level.brgametype.useserverhud))
      race.hud_racetrack_info settenthstimerstatic(_id_3777ECE6A73EADA5 / 1000);

    _id_E8A61EF4EDC64087 = int(abs(_id_3777ECE6A73EADA5));
    race.player _id_6731BE38C3B94FF7::playersetattractionbesttime(_id_E8A61EF4EDC64087);
    race.player _id_6731BE38C3B94FF7::playersetattractionbestplayer(race.player);
  }

  if(istrue(level.brgametype.useserverhud)) {
    race.hud_racetrack_timer.alpha = 1;
    race.hud_racetrack_timer settenthstimerstatic(end_time / 1000);
  }

  _id_9FADE146C7EFC102 = race_calculate_stars(race, end_time);
  giverewards(race.track, race.player, _id_9FADE146C7EFC102);
  race.player _id_6731BE38C3B94FF7::playersetattractionextradata(_id_9FADE146C7EFC102);
  wait 3;
}

track_get_reward_time(track, _id_9FADE146C7EFC102) {
  if(isDefined(track.startimes))
    return track.startimes[_id_9FADE146C7EFC102];

  _id_EB467922878A05C7 = get_track_setting(track, "reward_average_mph");

  if(_id_EB467922878A05C7[_id_9FADE146C7EFC102])
    hours = track.dist_miles / _id_EB467922878A05C7[_id_9FADE146C7EFC102];
  else
    return undefined;

  _id_CC748B6D457627FE = hours * 60 * 60;
  _id_CC748B6D457627FE = ceil(_id_CC748B6D457627FE * 10) / 10;
  return _id_CC748B6D457627FE;
}

track_get_reward_time_string(track, _id_9FADE146C7EFC102) {
  value = track_get_reward_time(track, _id_9FADE146C7EFC102);

  if(isDefined(value))
    return "" + value + " s";
  else
    return "any";
}

race_calculate_stars(race, _id_BDC35ABB6749F2F9) {
  _id_9FADE146C7EFC102 = 0;
  _id_80C3DA24117C14FA = _id_BDC35ABB6749F2F9 / 1000;

  for(_id_AC0E594AC96AA3A8 = 3; _id_AC0E594AC96AA3A8 > 0; _id_AC0E594AC96AA3A8--) {
    _id_F5DFB2F6A1955B77 = track_get_reward_time(race.track, _id_AC0E594AC96AA3A8);

    if(!isDefined(_id_F5DFB2F6A1955B77) || _id_80C3DA24117C14FA <= _id_F5DFB2F6A1955B77) {
      _id_9FADE146C7EFC102 = _id_AC0E594AC96AA3A8;
      break;
    }
  }

  return _id_9FADE146C7EFC102;
}

race_get_current_checkpoint(race) {
  return race.current_checkpoint;
}

race_get_next_checkpoint(race) {
  current = race_get_current_checkpoint(race);
  next = current + 1;
  _id_1E3893DD7D5C47AC = race.lap;

  if(race.track.loop) {
    if(!current)
      _id_1E3893DD7D5C47AC++;

    if(_id_1E3893DD7D5C47AC == get_track_setting(race.track, "laps"))
      return -1;

    if(next >= race.track.points.size)
      return 0;
    else
      return next;
  } else if(next < race.track.points.size)
    return next;
  else
    return -1;
}

race_set_next_checkpoint(race) {
  current = race_get_current_checkpoint(race);
  next = race_get_next_checkpoint(race);

  if(next < 0)
    return 1;

  if(race.track.loop) {
    if(!current)
      race.lap++;
  }

  race_set_checkpoint(race, next);
  return 0;
}

race_set_checkpoint(race, _id_A82E422A1E194DA8) {
  race.current_checkpoint = _id_A82E422A1E194DA8;
  checkpoint = race.track.points[_id_A82E422A1E194DA8];

  if(isDefined(race.checkpoint_objective_id) && race.checkpoint_objective_id != -1) {
    objective_origin = checkpoint.origin + (0, 0, 128);
    objective_position(race.checkpoint_objective_id, objective_origin);
  }

  if(isDefined(race.checkpoint_trigger)) {
    race.checkpoint_trigger.origin = checkpoint.origin;
    race.checkpoint_trigger.angles = checkpoint.angles + (90, 0, 0);
  }

  _id_902AE1A7ABBBEC60 = race_get_next_checkpoint(race);

  if(isDefined(race.checkpoint_fx)) {
    race.checkpoint_fx.origin = checkpoint.origin;
    race.checkpoint_fx.angles = checkpoint.angles;

    if(_id_902AE1A7ABBBEC60 < 0)
      checkpoint_fx_set(race, "checkpoint_finish");

    checkpoint_fx_play(race);
  }

  if(isDefined(race.checkpoint_next_fx)) {
    if(_id_902AE1A7ABBBEC60 >= 0) {
      _id_D768E5C381FB68F3 = race.track.points[_id_902AE1A7ABBBEC60];
      race.checkpoint_next_fx.origin = _id_D768E5C381FB68F3.origin;
      race.checkpoint_next_fx.angles = _id_D768E5C381FB68F3.angles;
      checkpoint_next_fx_play(race);
    } else
      race.checkpoint_next_fx delete();
  }
}

race_wait_for_current_checkpoint(race) {
  race endon("race_delete");

  for(;;) {
    race.checkpoint_trigger waittill("trigger", race_ent);

    if(race_ent == race.race_ent) {
      break;
    }
  }
}

delete_on_exit_icon_trigger_pre_race(race) {
  race endon("race_delete");
  race endon("race_active");
  race.track waittill("exit_icon_trigger_" + race.player getentitynumber());
  delete_race(race);
}

delete_on_death_or_dissconnect(race) {
  race endon("race_delete");
  race.player waittill("death_or_disconnect");
  delete_race(race);
}

delete_on_track_delete(race) {
  race endon("race_delete");
  race.track waittill("track_delete");
  delete_race(race);
}

delete_race(race) {
  if(isDefined(race.hud_racetrack_info))
    race.hud_racetrack_info destroy();

  if(isDefined(race.hud_racetrack_timer))
    race.hud_racetrack_timer destroy();

  if(isDefined(race.checkpoint_trigger))
    race.checkpoint_trigger delete();

  if(isDefined(race.checkpoint_fx))
    race.checkpoint_fx delete();

  if(isDefined(race.checkpoint_next_fx))
    race.checkpoint_next_fx delete();

  start_area_fx_end(race);
  scripts\mp\objidpoolmanager::returnobjectiveid(race.checkpoint_objective_id);

  if(isDefined(race.player))
    _id_6731BE38C3B94FF7::playersetignoreattractions(race.player, 0);

  race notify("race_delete");
}

race_requires_vehicle(race) {
  return get_track_setting(race.track, "vehicle_required");
}

giverewards(track, player, _id_9FADE146C7EFC102) {
  rewards = get_track_setting(track, "reward");
  _id_F6448388A69584FD = rewards[_id_9FADE146C7EFC102];
  _id_83E496BB1363F7AA = get_track_setting(track, "reward_splash");
  splashname = _id_83E496BB1363F7AA[_id_9FADE146C7EFC102];
  questtype = get_track_setting(track, "quest_type");
  params = spawnStruct();
  missionid = _id_3ACF1C0EBAF602F2::getquesttableindex(questtype);
  rewardtier = _id_3ACF1C0EBAF602F2::getquestrewardtier(player.team);
  _id_11D65784F0B6AFA2 = _id_3ACF1C0EBAF602F2::getquestrewardgroupindex(_id_F6448388A69584FD);
  params.packedbits = _id_3ACF1C0EBAF602F2::packsplashparambits(missionid, rewardtier, _id_11D65784F0B6AFA2);
  _id_3ACF1C0EBAF602F2::displaysplashtoplayers([player], splashname, params);
  rewardorigin = player.origin;
  rewardangles = player.angles;
  results = _id_3ACF1C0EBAF602F2::givequestrewardgroup(_id_F6448388A69584FD, player.team, rewardorigin, rewardangles, track.icontrigger.scriptable, [player]);
}

project(v, _id_AC0E454AC96A77AC) {
  scale = vectordot(v, _id_AC0E454AC96A77AC) / lengthsquared(_id_AC0E454AC96A77AC);
  return [_id_AC0E454AC96A77AC * scale, scale];
}

project_to_line(point, start, stop) {
  point = point - start;
  [point, scale] = project(point, stop - start);
  point = point + start;
  return [point, scale];
}

dist_to_line(point, start, stop) {
  [_id_A23E9279F1BF4ACA, scale] = project(point, start, stop);
  return distance(_id_A23E9279F1BF4ACA, point);
}

project_to_line_seg(point, start, stop) {
  [point, scale] = project_to_line(point, start, stop);

  if(scale < 0.0)
    point = start;
  else if(scale > 1.0)
    point = stop;

  return [point, scale];
}

dist_to_line_seg(point, start, stop) {
  [_id_A23E9279F1BF4ACA, scale] = project_to_line_seg(point, start, stop);
  return distance(_id_A23E9279F1BF4ACA, point);
}