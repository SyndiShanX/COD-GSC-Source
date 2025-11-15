/******************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\equipment\cloak.gsc
******************************************/

func_97C5() {
  level.var_1BBA = spawnStruct();
  func_97C6(level.var_1BBA);
  func_97C8(level.var_1BBA);
  func_97C9(level.var_1BBA);
  func_97C7(level.var_1BBA);
  func_989F();
  level.var_1BBA.var_A4E4 = 107.659;
  level.var_1BBA.var_1108C = 99.4488;
}

func_370B() {
  func_36F3();
  func_3703();
}

func_36F3() {
  iprintln("level.alienAnimData.jumpLaunchArrival_maxMoveDelta = " + func_36F6("jump_launch_arrival"));
}

func_3703() {
  iprintln("level.alienAnimData.stopSoon_NotifyDist = " + func_36F6("run_stop"));
}

func_36F6(param_00) {
  var_01 = 0;
  var_02 = self getanimentrycount(param_00);
  for(var_03 = 0; var_03 < var_02; var_03++) {
    var_04 = self getsafecircleorigin(param_00, var_03);
    var_05 = getmovedelta(var_04, 0, 1);
    var_06 = lengthsquared(var_05);
    if(var_06 > var_01) {
      var_01 = var_06;
    }
  }

  return sqrt(var_01);
}

func_97C6(param_00) {
  param_00.var_38D2 = [];
  param_00.var_38D2["alien_crawl_door"] = func_DF12("traverse_group_1", [0], 0);
  param_00.var_38D2["alien_jump_sidewall_l"] = func_DF12("traverse_group_1", [1], 0);
  param_00.var_38D2["alien_jump_sidewall_r"] = func_DF12("traverse_group_1", [2], 0);
  param_00.var_38D2["alien_leap_clear_height_54"] = func_DF12("traverse_group_1", [3], 0);
  param_00.var_38D2["alien_drone_traverse_corner_wall_crawl"] = func_DF12("traverse_group_1", [4], 0);
  param_00.var_38D2["alien_leap_clear_height_36"] = func_DF12("traverse_group_1", [5], 0);
  param_00.var_38D2["alien_leap_tree"] = func_DF12("traverse_group_1", [6], 0);
  param_00.var_38D2["alien_crawl_under_car"] = func_DF12("traverse_group_1", [7], 0);
  param_00.var_38D2["alien_crawl_on_car"] = func_DF12("traverse_group_1", [8], 0);
  param_00.var_38D2["alien_step_up_56"] = func_DF12("traverse_group_1", [9], 0);
  param_00.var_38D2["alien_step_down_56"] = func_DF12("traverse_group_1", [10], 0);
  param_00.var_38D2["alien_crawl_deadtree"] = func_DF12("traverse_group_1", [11], 0);
  param_00.var_38D2["alien_crawl_back_humvee"] = func_DF12("traverse_group_1", [12], 0);
  param_00.var_38D2["alien_crawl_car"] = func_DF12("traverse_group_1", [13], 0);
  param_00.var_38D2["alien_crawl_humvee"] = func_DF12("traverse_group_1", [14], 0);
  param_00.var_38D2["alien_crawl_sidecar"] = func_DF12("traverse_group_1", [15], 0);
  param_00.var_38D2["alien_crawl_sidehumvee"] = func_DF12("traverse_group_1", [16], 0);
  param_00.var_38D2["alien_under_fence"] = func_DF12("traverse_group_1", [17, 24], 0);
  param_00.var_38D2["alien_climb_up_spiral_tree"] = func_DF12("traverse_group_1", [18], 1);
  param_00.var_38D2["alien_climb_up_gutter_L"] = func_DF12("traverse_group_1", [19], 0);
  param_00.var_38D2["alien_climb_up_gutter_R"] = func_DF12("traverse_group_1", [20], 0);
  param_00.var_38D2["alien_climb_over_fence_112"] = func_DF12("traverse_group_1", [21, 22, 23], 0);
  param_00.var_38D2["alien_mantle_36"] = func_DF12("traverse_group_2", [0], 0, 1);
  param_00.var_38D2["alien_drone_traverse_climb_vault_8"] = func_DF12("traverse_group_2", [1], 0, 1);
  param_00.var_38D2["alien_drone_traverse_climb_over_fence"] = func_DF12("traverse_group_2", [2], 0, 1);
  param_00.var_38D2["alien_crawl_rail_vault_lodge"] = func_DF12("traverse_group_2", [3], 0, 1);
  param_00.var_38D2["alien_jump_rail_lodge"] = func_DF12("traverse_group_2", [4], 0, 0);
  param_00.var_38D2["alien_roof_to_ceiling"] = func_DF12("traverse_group_2", [5], 0, 1);
  param_00.var_38D2["alien_climb_over_fence_88"] = func_DF12("traverse_group_2", [6], 0, 1);
  param_00.var_38D2["alien_jump_down_100"] = func_DF12("traverse_group_2", [7], 0, 1);
  param_00.var_38D2["alien_jump_down_200"] = func_DF12("traverse_group_2", [8], 0, 1);
  param_00.var_38D2["alien_jump_up_70"] = func_DF12("traverse_group_2", [9], 0, 1);
  param_00.var_38D2["alien_jump_up_200"] = func_DF12("traverse_group_2", [10], 0, 1);
  param_00.var_38D2["alien_jump_down_straight"] = func_DF12("traverse_group_2", [11], 0, 1);
  param_00.var_38D2["alien_roof_to_ground"] = func_DF12("traverse_group_2", [12], 0, 1);
  param_00.var_38D2["alien_jump_up_128_rail_32"] = func_DF12("traverse_group_2", [13], 0, 0);
  param_00.var_38D2["alien_jump_up_128_rail_36"] = func_DF12("traverse_group_2", [14], 0, 0);
  param_00.var_38D2["alien_jump_up_128_rail_48"] = func_DF12("traverse_group_2", [15], 0, 0);
  param_00.var_38D2["alien_climb_up_rail_32_idle"] = func_DF12("traverse_group_2", [16], 0, 1);
  param_00.var_38D2["alien_climb_up_rail_32_run"] = func_DF12("traverse_group_2", [17], 0, 1);
  param_00.var_38D2["alien_mantle_32"] = func_DF12("traverse_group_2", [18], 0, 1);
  param_00.var_38D2["alien_mantle_48"] = func_DF12("traverse_group_2", [19], 0, 1);
  param_00.var_38D2["alien_jump_down_128_rail_32"] = func_DF12("traverse_group_2", [20], 0, 1);
  param_00.var_38D2["alien_jump_down_128_rail_36"] = func_DF12("traverse_group_2", [21], 0, 1);
  param_00.var_38D2["alien_jump_down_128_rail_48"] = func_DF12("traverse_group_2", [22], 0, 1);
  param_00.var_38D2["alien_climb_down_128_rail_36"] = func_DF12("traverse_group_2", [23], 1, 1);
  param_00.var_38D2["alien_mantle_crate_48"] = func_DF12("traverse_group_2", [24], 0, 1);
  param_00.var_38D2["alien_mantle_crate_64"] = func_DF12("traverse_group_2", [25], 0, 1);
  param_00.var_38D2["alien_jump_down_56_idle"] = func_DF12("traverse_group_2", [26], 0, 1);
  param_00.var_38D2["alien_jump_down_56_run"] = func_DF12("traverse_group_2", [27], 0, 1);
  param_00.var_38D2["alien_jump_up_56_idle"] = func_DF12("traverse_group_2", [28], 0, 1);
  param_00.var_38D2["alien_jump_up_56_run"] = func_DF12("traverse_group_2", [29], 0, 1);
  param_00.var_38D2["alien_jump_fence_88_enter_scale"] = func_DF12("traverse_group_2", [30], 0, 0);
  param_00.var_38D2["alien_jump_fence_88_exit_scale"] = func_DF12("traverse_group_2", [31], 0, 1);
  param_00.var_38D2["alien_jump_up_90_rail_32"] = func_DF12("traverse_group_3", [0], 0, 0);
  param_00.var_38D2["alien_jump_fence_high_to_low"] = func_DF12("traverse_group_3", [1], 0, 0);
  param_00.var_38D2["alien_jump_fence_low_to_high"] = func_DF12("traverse_group_3", [2], 0, 1);
  param_00.var_38D2["alien_jump_down_straight_forward_56"] = func_DF12("traverse_group_3", [3], 0, 1);
  param_00.var_38D2["alien_jump_down_straight_360_dlc"] = func_DF12("traverse_group_3", [4], 0, 1);
  param_00.var_38D2["alien_rail_32_jump_down_idle_dlc"] = func_DF12("traverse_group_3", [5], 0, 1);
  param_00.var_38D2["alien_rail_36_jump_down_idle_dlc"] = func_DF12("traverse_group_3", [6], 0, 1);
  param_00.var_38D2["alien_rail_48_jump_down_idle_dlc"] = func_DF12("traverse_group_3", [7], 0, 1);
  param_00.var_38D2["alien_climb_up"] = func_DF12("traverse_climb_up");
  param_00.var_38D2["alien_climb_down"] = func_DF12("traverse_climb_down");
  param_00.var_38D2["alien_climb_up_over_56"] = func_DF12("traverse_climb_up_over_56");
  param_00.var_38D2["alien_climb_over_56_down"] = func_DF12("traverse_climb_over_56_down");
  param_00.var_38D2["climb_up_end_jump_side_l"] = func_DF12("climb_up_end_jump_side_l");
  param_00.var_38D2["climb_up_end_jump_side_r"] = func_DF12("climb_up_end_jump_side_r");
  param_00.var_38D2["alien_climb_up_ledge_18_run"] = func_DF12("traverse_climb_up_ledge_18_run");
  param_00.var_38D2["alien_climb_up_ledge_18_idle"] = func_DF12("traverse_climb_up_ledge_18_idle");
  param_00.var_38D2["alien_wall_run"] = func_DF12("run");
}

func_97C8(param_00) {
  level.var_1BBA.var_A4E2 = 907.0294;
  level.var_1BBA.var_A4E6 = 16.8476;
  level.var_1BBA.var_A4E7 = 0.111111;
  level.var_1BBA.var_A4E5 = [];
  level.var_1BBA.var_A4E5["jump_launch_up"] = [];
  level.var_1BBA.var_A4E5["jump_launch_level"] = [];
  level.var_1BBA.var_A4E5["jump_launch_down"] = [];
  level.var_1BBA.var_A4E5["jump_launch_up"][0] = (0.338726, 0, 0.940885);
  level.var_1BBA.var_A4E5["jump_launch_up"][1] = (0.688542, 0, 0.725196);
  level.var_1BBA.var_A4E5["jump_launch_up"][2] = (0.906517, 0, 0.422169);
  level.var_1BBA.var_A4E5["jump_launch_level"][0] = (0.248516, 0, 0.968628);
  level.var_1BBA.var_A4E5["jump_launch_level"][1] = (0.579155, 0, 0.815218);
  level.var_1BBA.var_A4E5["jump_launch_level"][2] = (0.906514, 0, 0.422177);
  level.var_1BBA.var_A4E5["jump_launch_down"][0] = (0.333125, 0, 0.942883);
  level.var_1BBA.var_A4E5["jump_launch_down"][1] = (0.518112, 0, 0.855313);
  level.var_1BBA.var_A4E5["jump_launch_down"][2] = (0.892489, 0, 0.451068);
  level.var_1BBA.var_93B2 = [];
  level.var_1BBA.var_93B2["jump_launch_up"] = [];
  level.var_1BBA.var_93B2["jump_launch_level"] = [];
  level.var_1BBA.var_93B2["jump_launch_down"] = [];
  level.var_1BBA.var_93B2["jump_launch_up"]["jump_land_up"] = 0;
  level.var_1BBA.var_93B2["jump_launch_up"]["jump_land_level"] = 1;
  level.var_1BBA.var_93B2["jump_launch_up"]["jump_land_down"] = 2;
  level.var_1BBA.var_93B2["jump_launch_level"]["jump_land_up"] = 3;
  level.var_1BBA.var_93B2["jump_launch_level"]["jump_land_level"] = 4;
  level.var_1BBA.var_93B2["jump_launch_level"]["jump_land_down"] = 5;
  level.var_1BBA.var_93B2["jump_launch_down"]["jump_land_up"] = 6;
  level.var_1BBA.var_93B2["jump_launch_down"]["jump_land_level"] = 7;
  level.var_1BBA.var_93B2["jump_launch_down"]["jump_land_down"] = 8;
  level.var_1BBA.var_93B2["jump_launch_up"]["jump_land_sidewall_high"] = 9;
  level.var_1BBA.var_93B2["jump_launch_level"]["jump_land_sidewall_high"] = 9;
  level.var_1BBA.var_93B2["jump_launch_down"]["jump_land_sidewall_high"] = 9;
  level.var_1BBA.var_93B2["jump_launch_up"]["jump_land_sidewall_low"] = 9;
  level.var_1BBA.var_93B2["jump_launch_level"]["jump_land_sidewall_low"] = 9;
  level.var_1BBA.var_93B2["jump_launch_down"]["jump_land_sidewall_low"] = 9;
}

func_97C9(param_00) {
  param_00.var_C871 = [];
  var_01 = [];
  var_01["front"]["head"] = [0];
  var_01["front"]["up_chest"] = [1];
  var_01["front"]["low_chest"] = [1];
  var_01["front"]["up_body_L"] = [1];
  var_01["front"]["up_body_R"] = [2];
  var_01["front"]["low_body_L"] = [2];
  var_01["front"]["low_body_R"] = [2];
  var_01["front"]["armor"] = [0];
  var_01["front"]["soft"] = [0];
  var_01["right"]["head"] = [0];
  var_01["right"]["up_chest"] = [3];
  var_01["right"]["low_chest"] = [3];
  var_01["right"]["up_body_L"] = [3];
  var_01["right"]["up_body_R"] = [2];
  var_01["right"]["low_body_L"] = [4];
  var_01["right"]["low_body_R"] = [4];
  var_01["right"]["armor"] = [0];
  var_01["right"]["soft"] = [0];
  var_01["left"]["head"] = [0];
  var_01["left"]["up_chest"] = [1];
  var_01["left"]["low_chest"] = [1];
  var_01["left"]["up_body_L"] = [5];
  var_01["left"]["up_body_R"] = [5];
  var_01["left"]["low_body_L"] = [6];
  var_01["left"]["low_body_R"] = [6];
  var_01["left"]["armor"] = [2];
  var_01["left"]["soft"] = [2];
  var_01["back"]["head"] = [0];
  var_01["back"]["up_chest"] = [1];
  var_01["back"]["low_chest"] = [1];
  var_01["back"]["up_body_L"] = [1];
  var_01["back"]["up_body_R"] = [7];
  var_01["back"]["low_body_L"] = [7];
  var_01["back"]["low_body_R"] = [7];
  var_01["back"]["armor"] = [0];
  var_01["back"]["soft"] = [0];
  param_00.var_C871["idle"] = var_01;
  var_02 = [];
  var_02["front"]["head"] = [0];
  var_02["front"]["up_chest"] = [9];
  var_02["front"]["low_chest"] = [8];
  var_02["front"]["up_body_L"] = [8];
  var_02["front"]["up_body_R"] = [9];
  var_02["front"]["low_body_L"] = [10];
  var_02["front"]["low_body_R"] = [10];
  var_02["front"]["armor"] = [0];
  var_02["front"]["soft"] = [0];
  var_02["right"]["head"] = [7];
  var_02["right"]["up_chest"] = [7];
  var_02["right"]["low_chest"] = [11];
  var_02["right"]["up_body_L"] = [7];
  var_02["right"]["up_body_R"] = [7];
  var_02["right"]["low_body_L"] = [11];
  var_02["right"]["low_body_R"] = [11];
  var_02["right"]["armor"] = [0];
  var_02["right"]["soft"] = [0];
  var_02["left"]["head"] = [5];
  var_02["left"]["up_chest"] = [5];
  var_02["left"]["low_chest"] = [6];
  var_02["left"]["up_body_L"] = [5];
  var_02["left"]["up_body_R"] = [5];
  var_02["left"]["low_body_L"] = [6];
  var_02["left"]["low_body_R"] = [6];
  var_02["left"]["armor"] = [0];
  var_02["left"]["soft"] = [0];
  var_02["back"]["head"] = [12];
  var_02["back"]["up_chest"] = [12];
  var_02["back"]["low_chest"] = [13];
  var_02["back"]["up_body_L"] = [12];
  var_02["back"]["up_body_R"] = [12];
  var_02["back"]["low_body_L"] = [13];
  var_02["back"]["low_body_R"] = [13];
  var_02["back"]["armor"] = [0];
  var_02["back"]["soft"] = [0];
  param_00.var_C871["run"] = var_02;
  var_03 = [];
  var_03["front"]["head"] = [0];
  var_03["front"]["up_chest"] = [1];
  var_03["front"]["low_chest"] = [1];
  var_03["front"]["up_body_L"] = [2];
  var_03["front"]["up_body_R"] = [3];
  var_03["front"]["low_body_L"] = [4];
  var_03["front"]["low_body_R"] = [4];
  var_03["front"]["armor"] = [0];
  var_03["front"]["soft"] = [0];
  var_03["right"]["head"] = [7];
  var_03["right"]["up_chest"] = [7];
  var_03["right"]["low_chest"] = [8];
  var_03["right"]["up_body_L"] = [7];
  var_03["right"]["up_body_R"] = [7];
  var_03["right"]["low_body_L"] = [8];
  var_03["right"]["low_body_R"] = [8];
  var_03["right"]["armor"] = [0];
  var_03["right"]["soft"] = [0];
  var_03["left"]["head"] = [5];
  var_03["left"]["up_chest"] = [5];
  var_03["left"]["low_chest"] = [6];
  var_03["left"]["up_body_L"] = [5];
  var_03["left"]["up_body_R"] = [5];
  var_03["left"]["low_body_L"] = [6];
  var_03["left"]["low_body_R"] = [6];
  var_03["left"]["armor"] = [0];
  var_03["left"]["soft"] = [0];
  var_03["back"]["head"] = [9];
  var_03["back"]["up_chest"] = [9];
  var_03["back"]["low_chest"] = [10];
  var_03["back"]["up_body_L"] = [9];
  var_03["back"]["up_body_R"] = [9];
  var_03["back"]["low_body_L"] = [10];
  var_03["back"]["low_body_R"] = [10];
  var_03["back"]["armor"] = [0];
  var_03["back"]["soft"] = [0];
  param_00.var_C871["jump"] = var_03;
  var_04 = [];
  var_04["front"] = [0, 1];
  var_04["right"] = [2];
  var_04["left"] = [3];
  var_04["back"] = [4];
  param_00.var_C871["push_back"] = var_04;
  var_05 = [];
  var_05["front"] = [0];
  var_05["right"] = [0];
  var_05["left"] = [0];
  var_05["back"] = [0];
  param_00.var_C871["move_back"] = var_05;
  var_06 = [];
  var_06["front"] = [0, 1, 2];
  var_06["right"] = [0, 1, 2];
  var_06["left"] = [0, 1, 2];
  var_06["back"] = [0, 1, 2];
  param_00.var_C871["melee"] = var_06;
  var_07 = [];
  var_07["head"] = "head";
  var_07["neck"] = "head";
  var_07["torso_upper"] = "up_chest";
  var_07["none"] = "up_chest";
  var_07["torso_lower"] = "low_chest";
  var_07["left_arm_upper"] = "up_body_L";
  var_07["left_arm_lower"] = "up_body_L";
  var_07["left_hand"] = "up_body_L";
  var_07["right_arm_upper"] = "up_body_R";
  var_07["right_arm_lower"] = "up_body_R";
  var_07["right_hand"] = "up_body_R";
  var_07["left_leg_upper"] = "low_body_L";
  var_07["left_leg_lower"] = "low_body_L";
  var_07["left_foot"] = "low_body_L";
  var_07["right_leg_upper"] = "low_body_R";
  var_07["right_leg_lower"] = "low_body_R";
  var_07["right_foot"] = "low_body_R";
  var_07["armor"] = "armor";
  var_07["soft"] = "soft";
  param_00.var_C871["hitLoc"] = var_07;
  var_08 = [];
  var_08[0] = "back";
  var_08[1] = "back";
  var_08[2] = "right";
  var_08[3] = "right";
  var_08[4] = "front";
  var_08[5] = "left";
  var_08[6] = "left";
  var_08[7] = "back";
  var_08[8] = "back";
  param_00.var_C871["hitDirection"] = var_08;
  var_09 = [];
  var_09[0] = [0];
  var_09[1] = [1];
  var_09[2] = [2];
  var_09[3] = [3];
  var_09[4] = [4];
  var_09[5] = [5];
  var_09[6] = [6];
  var_09[7] = [7];
  var_09[8] = [8];
  var_09[9] = [9];
  var_09[10] = [10];
  param_00.var_C871["idleToImpactMap"] = var_09;
}

func_97C7(param_00) {
  param_00.var_4E2D = [];
  var_01 = [];
  var_01["front"]["head"] = [0];
  var_01["front"]["up_chest"] = [1];
  var_01["front"]["low_chest"] = [1];
  var_01["front"]["up_body_L"] = [1];
  var_01["front"]["up_body_R"] = [2];
  var_01["front"]["low_body_L"] = [2];
  var_01["front"]["low_body_R"] = [2];
  var_01["front"]["armor"] = [0];
  var_01["front"]["soft"] = [0];
  var_01["right"]["head"] = [0];
  var_01["right"]["up_chest"] = [4];
  var_01["right"]["low_chest"] = [3];
  var_01["right"]["up_body_L"] = [4];
  var_01["right"]["up_body_R"] = [4];
  var_01["right"]["low_body_L"] = [2];
  var_01["right"]["low_body_R"] = [2];
  var_01["right"]["armor"] = [0];
  var_01["right"]["soft"] = [0];
  var_01["left"]["head"] = [0];
  var_01["left"]["up_chest"] = [1];
  var_01["left"]["low_chest"] = [1];
  var_01["left"]["up_body_L"] = [1];
  var_01["left"]["up_body_R"] = [2];
  var_01["left"]["low_body_L"] = [5];
  var_01["left"]["low_body_R"] = [5];
  var_01["left"]["armor"] = [0];
  var_01["left"]["soft"] = [0];
  var_01["back"]["head"] = [0];
  var_01["back"]["up_chest"] = [1];
  var_01["back"]["low_chest"] = [1];
  var_01["back"]["up_body_L"] = [1];
  var_01["back"]["up_body_R"] = [2];
  var_01["back"]["low_body_L"] = [2];
  var_01["back"]["low_body_R"] = [2];
  var_01["back"]["armor"] = [0];
  var_01["back"]["soft"] = [0];
  param_00.var_4E2D["idle"] = var_01;
  var_02 = [];
  var_02["front"]["head"] = [0];
  var_02["front"]["up_chest"] = [1];
  var_02["front"]["low_chest"] = [3];
  var_02["front"]["up_body_L"] = [4];
  var_02["front"]["up_body_R"] = [9];
  var_02["front"]["low_body_L"] = [4];
  var_02["front"]["low_body_R"] = [3];
  var_02["front"]["armor"] = [0];
  var_02["front"]["soft"] = [0];
  var_02["right"]["head"] = [2];
  var_02["right"]["up_chest"] = [1];
  var_02["right"]["low_chest"] = [0];
  var_02["right"]["up_body_L"] = [7];
  var_02["right"]["up_body_R"] = [7];
  var_02["right"]["low_body_L"] = [3];
  var_02["right"]["low_body_R"] = [4];
  var_02["right"]["armor"] = [0];
  var_02["right"]["soft"] = [0];
  var_02["left"]["head"] = [5];
  var_02["left"]["up_chest"] = [5];
  var_02["left"]["low_chest"] = [6];
  var_02["left"]["up_body_L"] = [5];
  var_02["left"]["up_body_R"] = [5];
  var_02["left"]["low_body_L"] = [8];
  var_02["left"]["low_body_R"] = [6];
  var_02["left"]["armor"] = [0];
  var_02["left"]["soft"] = [0];
  var_02["back"]["head"] = [1];
  var_02["back"]["up_chest"] = [5];
  var_02["back"]["low_chest"] = [4];
  var_02["back"]["up_body_L"] = [3];
  var_02["back"]["up_body_R"] = [2];
  var_02["back"]["low_body_L"] = [1];
  var_02["back"]["low_body_R"] = [4];
  var_02["back"]["armor"] = [0];
  var_02["back"]["soft"] = [0];
  param_00.var_4E2D["run"] = var_02;
  var_03 = [];
  var_03["front"]["head"] = [1];
  var_03["front"]["up_chest"] = [0];
  var_03["front"]["low_chest"] = [0];
  var_03["front"]["up_body_L"] = [2];
  var_03["front"]["up_body_R"] = [3];
  var_03["front"]["low_body_L"] = [4];
  var_03["front"]["low_body_R"] = [4];
  var_03["front"]["armor"] = [1];
  var_03["front"]["soft"] = [1];
  var_03["right"]["head"] = [7];
  var_03["right"]["up_chest"] = [7];
  var_03["right"]["low_chest"] = [8];
  var_03["right"]["up_body_L"] = [7];
  var_03["right"]["up_body_R"] = [7];
  var_03["right"]["low_body_L"] = [8];
  var_03["right"]["low_body_R"] = [8];
  var_03["right"]["armor"] = [1];
  var_03["right"]["soft"] = [1];
  var_03["left"]["head"] = [5];
  var_03["left"]["up_chest"] = [5];
  var_03["left"]["low_chest"] = [6];
  var_03["left"]["up_body_L"] = [5];
  var_03["left"]["up_body_R"] = [5];
  var_03["left"]["low_body_L"] = [6];
  var_03["left"]["low_body_R"] = [6];
  var_03["left"]["armor"] = [1];
  var_03["left"]["soft"] = [1];
  var_03["back"]["head"] = [9];
  var_03["back"]["up_chest"] = [9];
  var_03["back"]["low_chest"] = [10];
  var_03["back"]["up_body_L"] = [9];
  var_03["back"]["up_body_R"] = [9];
  var_03["back"]["low_body_L"] = [10];
  var_03["back"]["low_body_R"] = [10];
  var_03["back"]["armor"] = [1];
  var_03["back"]["soft"] = [1];
  param_00.var_4E2D["jump"] = var_03;
  var_04 = [];
  var_04["head"] = "head";
  var_04["neck"] = "head";
  var_04["torso_upper"] = "up_chest";
  var_04["none"] = "up_chest";
  var_04["torso_lower"] = "low_chest";
  var_04["left_arm_upper"] = "up_body_L";
  var_04["left_arm_lower"] = "up_body_L";
  var_04["left_hand"] = "up_body_L";
  var_04["right_arm_upper"] = "up_body_R";
  var_04["right_arm_lower"] = "up_body_R";
  var_04["right_hand"] = "up_body_R";
  var_04["left_leg_upper"] = "low_body_L";
  var_04["left_leg_lower"] = "low_body_L";
  var_04["left_foot"] = "low_body_L";
  var_04["right_leg_upper"] = "low_body_R";
  var_04["right_leg_lower"] = "low_body_R";
  var_04["right_foot"] = "low_body_R";
  var_04["armor"] = "armor";
  var_04["soft"] = "soft";
  param_00.var_4E2D["hitLoc"] = var_04;
  var_05 = [];
  var_05[0] = "back";
  var_05[1] = "back";
  var_05[2] = "right";
  var_05[3] = "right";
  var_05[4] = "front";
  var_05[5] = "left";
  var_05[6] = "left";
  var_05[7] = "back";
  var_05[8] = "back";
  param_00.var_4E2D["hitDirection"] = var_05;
  var_06 = [];
  var_06["electric_shock_death"] = [0];
  var_06["traverse"] = [1];
  param_00.var_4E2D["special"] = var_06;
}

func_989F() {
  level.var_1BBA.var_1BCD[0] = 40;
  level.var_1BBA.var_1BCD[1] = 40;
  level.var_1BBA.var_1BCD[2] = 20;
}

func_DF12(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = [];
  var_06["animState"] = param_00;
  if(isDefined(param_01)) {
    var_06["animIndexArray"] = param_01;
  }

  if(isDefined(param_02)) {
    var_06["endInOriented"] = param_02;
  }

  if(isDefined(param_03)) {
    var_06["flexHeightEndAtTraverseEnd"] = param_03;
  }

  if(isDefined(param_04)) {
    var_06["traverseSound"] = param_04;
  }

  if(isDefined(param_05)) {
    var_06["traverseAnimScale"] = param_05;
  }

  return var_06;
}

func_129B5(param_00) {
  var_01 = param_00.origin - self.origin;
  return func_129B7(var_01);
}

func_129B7(param_00) {
  var_01 = _meth_81E1(anglesToForward(self.angles), param_00, anglestoup(self.angles));
  self orientmode("face angle abs", self.angles);
  if(var_01 != 4) {
    self.projectileintercept = 1;
    if(self.trajectorycanattemptaccuratejump) {
      self ghostlaunched("anim angle delta");
    } else {
      self ghostlaunched("anim deltas");
    }

    var_02 = linkto();
    scripts\mp\agents\_scriptedagents::func_CED5(var_02, var_01, "turn_in_place", "code_move");
    if(!lib_0A49::func_9C09()) {
      self.projectileintercept = 0;
    }

    return 1;
  }

  return 0;
}

linkto() {
  if(isDefined(level.var_5750)) {
    var_00 = [[level.var_5750]]();
    if(isDefined(var_00)) {
      return var_00;
    }
  }

  var_00 = undefined;
  switch (scripts\cp\cp_agent_utils::get_agent_type(self)) {
    case "gargoyle_boss":
    case "gargoyle":
      var_00 = [
        [level.var_1B6B["gargoyle"]["turn_in_place_anim_state"]]
      ]();
      break;
  }

  if(!isDefined(var_00)) {
    var_00 = "turn_in_place";
  }

  return var_00;
}

_meth_81E1(param_00, param_01, param_02) {
  var_03 = undefined;
  var_04 = undefined;
  var_05 = disableforcethirdpersonwhenfollowing(param_00, param_01, param_02);
  var_06 = var_05.var_E72A;
  var_07 = var_05.var_DA69;
  var_08 = 10;
  if(var_07 > 0) {
    var_04 = int(ceil(180 - var_06 - var_08 / 45));
  } else {
    var_04 = int(floor(180 + var_06 + var_08 / 45));
  }

  var_04 = int(clamp(var_04, 0, 8));
  return var_04;
}

disableforcethirdpersonwhenfollowing(param_00, param_01, param_02) {
  var_03 = spawnStruct();
  var_04 = vectornormalize(func_DA68(param_00, param_02));
  var_05 = vectornormalize(func_DA68(param_01, param_02));
  var_06 = vectorcross(var_05, param_02);
  var_07 = vectornormalize(func_DA68(var_06, param_02));
  var_08 = vectordot(var_04 * -1, var_07);
  var_09 = vectordot(var_05, var_04);
  var_09 = clamp(var_09, -1, 1);
  var_0A = acos(var_09);
  var_03.var_E72A = var_0A;
  var_03.var_DA69 = var_08;
  return var_03;
}

func_DA68(param_00, param_01) {
  var_02 = vectordot(param_00, param_01);
  var_03 = param_00 - param_01 * var_02;
  return var_03;
}

func_C864(param_00) {
  return level.var_1BBA.var_C871["hitLoc"][param_00];
}

func_C865(param_00) {
  var_01 = scripts\mp\agents\_scriptedagents::func_7DBD(param_00);
  return level.var_1BBA.var_C871["hitDirection"][var_01];
}

func_4E0C(param_00) {
  return level.var_1BBA.var_4E2D["hitLoc"][param_00];
}

func_4E0D(param_00) {
  var_01 = scripts\mp\agents\_scriptedagents::func_7DBD(param_00);
  return level.var_1BBA.var_4E2D["hitDirection"][var_01];
}

botnodepick(param_00, param_01, param_02) {
  var_03 = func_7E59(param_01, param_02);
  return param_00 + "_" + var_03;
}

func_7E59(param_00, param_01) {
  var_02 = scripts\cp\cp_agent_utils::get_agent_type(self);
  var_03 = level.var_1BA4[var_02].var_2552["heavy_damage_threshold"];
  if(param_00 < var_03 && !param_01) {
    return "light";
  }

  return "heavy";
}

botnodeavailable(param_00, param_01, param_02) {
  param_01 = func_C865(param_01 * -1);
  if(isDefined(param_02)) {
    param_02 = func_C864(param_02);
  }

  return botnodepickmultiple(param_00, param_01, param_02, level.var_1BBA.var_C871);
}

func_7F10(param_00) {
  var_01 = level.var_1BBA.var_C871["idleToImpactMap"][param_00];
  var_02 = randomintrange(0, var_01.size);
  return var_01[var_02];
}

func_7E62(param_00, param_01) {
  var_02 = func_7E59(param_01, 0);
  return param_00 + "_" + var_02;
}

func_7E61(param_00, param_01, param_02) {
  param_01 = func_4E0D(param_01 * -1);
  param_02 = func_4E0C(param_02);
  return botnodepickmultiple(param_00, param_01, param_02, level.var_1BBA.var_4E2D);
}

botnodepickmultiple(param_00, param_01, param_02, param_03) {
  if(isDefined(param_02)) {
    var_04 = param_03[param_00][param_01][param_02];
  } else {
    var_04 = var_04[param_01][param_02];
  }

  return var_04[randomint(var_04.size)];
}

_meth_8146(param_00) {
  var_01 = level.var_1BBA.var_4E2D["special"][param_00];
  return var_01[randomint(var_01.size)];
}

func_E26A(param_00, param_01) {
  var_02 = getent(param_00, "targetname");
  var_02 setscriptablepartstate("animpart", 0);
}

func_CED8(param_00, param_01, param_02) {
  var_03 = getent(param_00, "targetname");
  if(!isDefined(var_03)) {
    return;
  }

  if(!isDefined(param_02)) {
    param_02 = 1;
  }

  var_03 setscriptablepartstate("animpart", param_02);
  level notify("scriptable", param_00);
}

func_7F66(param_00) {
  var_01 = getanimlength(param_00);
  return min(0.2, var_01);
}

_meth_8088(param_00, param_01, param_02, param_03) {
  var_04 = getanimlength(param_00);
  var_05 = getmovedelta(param_00, 0, param_03 / var_04);
  var_06 = rotatevector(var_05, param_02);
  return param_01 + var_06;
}

func_58EA(param_00, param_01) {
  self endon("death");
  level endon("game_ended");
  self ghostexplode(self.origin, param_00, param_01);
  wait(param_01);
  self ghostlaunched("anim deltas");
}