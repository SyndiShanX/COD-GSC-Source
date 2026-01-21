/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\mp\equipment\cloak.gsc
*********************************************/

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

func_36F6(var_0) {
  var_1 = 0;
  var_2 = self getanimentrycount(var_0);
  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = self getsafecircleorigin(var_0, var_3);
    var_5 = getmovedelta(var_4, 0, 1);
    var_6 = lengthsquared(var_5);
    if(var_6 > var_1) {
      var_1 = var_6;
    }
  }

  return sqrt(var_1);
}

func_97C6(var_0) {
  var_0.var_38D2 = [];
  var_0.var_38D2["alien_crawl_door"] = func_DF12("traverse_group_1", [0], 0);
  var_0.var_38D2["alien_jump_sidewall_l"] = func_DF12("traverse_group_1", [1], 0);
  var_0.var_38D2["alien_jump_sidewall_r"] = func_DF12("traverse_group_1", [2], 0);
  var_0.var_38D2["alien_leap_clear_height_54"] = func_DF12("traverse_group_1", [3], 0);
  var_0.var_38D2["alien_drone_traverse_corner_wall_crawl"] = func_DF12("traverse_group_1", [4], 0);
  var_0.var_38D2["alien_leap_clear_height_36"] = func_DF12("traverse_group_1", [5], 0);
  var_0.var_38D2["alien_leap_tree"] = func_DF12("traverse_group_1", [6], 0);
  var_0.var_38D2["alien_crawl_under_car"] = func_DF12("traverse_group_1", [7], 0);
  var_0.var_38D2["alien_crawl_on_car"] = func_DF12("traverse_group_1", [8], 0);
  var_0.var_38D2["alien_step_up_56"] = func_DF12("traverse_group_1", [9], 0);
  var_0.var_38D2["alien_step_down_56"] = func_DF12("traverse_group_1", [10], 0);
  var_0.var_38D2["alien_crawl_deadtree"] = func_DF12("traverse_group_1", [11], 0);
  var_0.var_38D2["alien_crawl_back_humvee"] = func_DF12("traverse_group_1", [12], 0);
  var_0.var_38D2["alien_crawl_car"] = func_DF12("traverse_group_1", [13], 0);
  var_0.var_38D2["alien_crawl_humvee"] = func_DF12("traverse_group_1", [14], 0);
  var_0.var_38D2["alien_crawl_sidecar"] = func_DF12("traverse_group_1", [15], 0);
  var_0.var_38D2["alien_crawl_sidehumvee"] = func_DF12("traverse_group_1", [16], 0);
  var_0.var_38D2["alien_under_fence"] = func_DF12("traverse_group_1", [17, 24], 0);
  var_0.var_38D2["alien_climb_up_spiral_tree"] = func_DF12("traverse_group_1", [18], 1);
  var_0.var_38D2["alien_climb_up_gutter_L"] = func_DF12("traverse_group_1", [19], 0);
  var_0.var_38D2["alien_climb_up_gutter_R"] = func_DF12("traverse_group_1", [20], 0);
  var_0.var_38D2["alien_climb_over_fence_112"] = func_DF12("traverse_group_1", [21, 22, 23], 0);
  var_0.var_38D2["alien_mantle_36"] = func_DF12("traverse_group_2", [0], 0, 1);
  var_0.var_38D2["alien_drone_traverse_climb_vault_8"] = func_DF12("traverse_group_2", [1], 0, 1);
  var_0.var_38D2["alien_drone_traverse_climb_over_fence"] = func_DF12("traverse_group_2", [2], 0, 1);
  var_0.var_38D2["alien_crawl_rail_vault_lodge"] = func_DF12("traverse_group_2", [3], 0, 1);
  var_0.var_38D2["alien_jump_rail_lodge"] = func_DF12("traverse_group_2", [4], 0, 0);
  var_0.var_38D2["alien_roof_to_ceiling"] = func_DF12("traverse_group_2", [5], 0, 1);
  var_0.var_38D2["alien_climb_over_fence_88"] = func_DF12("traverse_group_2", [6], 0, 1);
  var_0.var_38D2["alien_jump_down_100"] = func_DF12("traverse_group_2", [7], 0, 1);
  var_0.var_38D2["alien_jump_down_200"] = func_DF12("traverse_group_2", [8], 0, 1);
  var_0.var_38D2["alien_jump_up_70"] = func_DF12("traverse_group_2", [9], 0, 1);
  var_0.var_38D2["alien_jump_up_200"] = func_DF12("traverse_group_2", [10], 0, 1);
  var_0.var_38D2["alien_jump_down_straight"] = func_DF12("traverse_group_2", [11], 0, 1);
  var_0.var_38D2["alien_roof_to_ground"] = func_DF12("traverse_group_2", [12], 0, 1);
  var_0.var_38D2["alien_jump_up_128_rail_32"] = func_DF12("traverse_group_2", [13], 0, 0);
  var_0.var_38D2["alien_jump_up_128_rail_36"] = func_DF12("traverse_group_2", [14], 0, 0);
  var_0.var_38D2["alien_jump_up_128_rail_48"] = func_DF12("traverse_group_2", [15], 0, 0);
  var_0.var_38D2["alien_climb_up_rail_32_idle"] = func_DF12("traverse_group_2", [16], 0, 1);
  var_0.var_38D2["alien_climb_up_rail_32_run"] = func_DF12("traverse_group_2", [17], 0, 1);
  var_0.var_38D2["alien_mantle_32"] = func_DF12("traverse_group_2", [18], 0, 1);
  var_0.var_38D2["alien_mantle_48"] = func_DF12("traverse_group_2", [19], 0, 1);
  var_0.var_38D2["alien_jump_down_128_rail_32"] = func_DF12("traverse_group_2", [20], 0, 1);
  var_0.var_38D2["alien_jump_down_128_rail_36"] = func_DF12("traverse_group_2", [21], 0, 1);
  var_0.var_38D2["alien_jump_down_128_rail_48"] = func_DF12("traverse_group_2", [22], 0, 1);
  var_0.var_38D2["alien_climb_down_128_rail_36"] = func_DF12("traverse_group_2", [23], 1, 1);
  var_0.var_38D2["alien_mantle_crate_48"] = func_DF12("traverse_group_2", [24], 0, 1);
  var_0.var_38D2["alien_mantle_crate_64"] = func_DF12("traverse_group_2", [25], 0, 1);
  var_0.var_38D2["alien_jump_down_56_idle"] = func_DF12("traverse_group_2", [26], 0, 1);
  var_0.var_38D2["alien_jump_down_56_run"] = func_DF12("traverse_group_2", [27], 0, 1);
  var_0.var_38D2["alien_jump_up_56_idle"] = func_DF12("traverse_group_2", [28], 0, 1);
  var_0.var_38D2["alien_jump_up_56_run"] = func_DF12("traverse_group_2", [29], 0, 1);
  var_0.var_38D2["alien_jump_fence_88_enter_scale"] = func_DF12("traverse_group_2", [30], 0, 0);
  var_0.var_38D2["alien_jump_fence_88_exit_scale"] = func_DF12("traverse_group_2", [31], 0, 1);
  var_0.var_38D2["alien_jump_up_90_rail_32"] = func_DF12("traverse_group_3", [0], 0, 0);
  var_0.var_38D2["alien_jump_fence_high_to_low"] = func_DF12("traverse_group_3", [1], 0, 0);
  var_0.var_38D2["alien_jump_fence_low_to_high"] = func_DF12("traverse_group_3", [2], 0, 1);
  var_0.var_38D2["alien_jump_down_straight_forward_56"] = func_DF12("traverse_group_3", [3], 0, 1);
  var_0.var_38D2["alien_jump_down_straight_360_dlc"] = func_DF12("traverse_group_3", [4], 0, 1);
  var_0.var_38D2["alien_rail_32_jump_down_idle_dlc"] = func_DF12("traverse_group_3", [5], 0, 1);
  var_0.var_38D2["alien_rail_36_jump_down_idle_dlc"] = func_DF12("traverse_group_3", [6], 0, 1);
  var_0.var_38D2["alien_rail_48_jump_down_idle_dlc"] = func_DF12("traverse_group_3", [7], 0, 1);
  var_0.var_38D2["alien_climb_up"] = func_DF12("traverse_climb_up");
  var_0.var_38D2["alien_climb_down"] = func_DF12("traverse_climb_down");
  var_0.var_38D2["alien_climb_up_over_56"] = func_DF12("traverse_climb_up_over_56");
  var_0.var_38D2["alien_climb_over_56_down"] = func_DF12("traverse_climb_over_56_down");
  var_0.var_38D2["climb_up_end_jump_side_l"] = func_DF12("climb_up_end_jump_side_l");
  var_0.var_38D2["climb_up_end_jump_side_r"] = func_DF12("climb_up_end_jump_side_r");
  var_0.var_38D2["alien_climb_up_ledge_18_run"] = func_DF12("traverse_climb_up_ledge_18_run");
  var_0.var_38D2["alien_climb_up_ledge_18_idle"] = func_DF12("traverse_climb_up_ledge_18_idle");
  var_0.var_38D2["alien_wall_run"] = func_DF12("run");
}

func_97C8(var_0) {
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

func_97C9(var_0) {
  var_0.var_C871 = [];
  var_1 = [];
  var_1["front"]["head"] = [0];
  var_1["front"]["up_chest"] = [1];
  var_1["front"]["low_chest"] = [1];
  var_1["front"]["up_body_L"] = [1];
  var_1["front"]["up_body_R"] = [2];
  var_1["front"]["low_body_L"] = [2];
  var_1["front"]["low_body_R"] = [2];
  var_1["front"]["armor"] = [0];
  var_1["front"]["soft"] = [0];
  var_1["right"]["head"] = [0];
  var_1["right"]["up_chest"] = [3];
  var_1["right"]["low_chest"] = [3];
  var_1["right"]["up_body_L"] = [3];
  var_1["right"]["up_body_R"] = [2];
  var_1["right"]["low_body_L"] = [4];
  var_1["right"]["low_body_R"] = [4];
  var_1["right"]["armor"] = [0];
  var_1["right"]["soft"] = [0];
  var_1["left"]["head"] = [0];
  var_1["left"]["up_chest"] = [1];
  var_1["left"]["low_chest"] = [1];
  var_1["left"]["up_body_L"] = [5];
  var_1["left"]["up_body_R"] = [5];
  var_1["left"]["low_body_L"] = [6];
  var_1["left"]["low_body_R"] = [6];
  var_1["left"]["armor"] = [2];
  var_1["left"]["soft"] = [2];
  var_1["back"]["head"] = [0];
  var_1["back"]["up_chest"] = [1];
  var_1["back"]["low_chest"] = [1];
  var_1["back"]["up_body_L"] = [1];
  var_1["back"]["up_body_R"] = [7];
  var_1["back"]["low_body_L"] = [7];
  var_1["back"]["low_body_R"] = [7];
  var_1["back"]["armor"] = [0];
  var_1["back"]["soft"] = [0];
  var_0.var_C871["idle"] = var_1;
  var_2 = [];
  var_2["front"]["head"] = [0];
  var_2["front"]["up_chest"] = [9];
  var_2["front"]["low_chest"] = [8];
  var_2["front"]["up_body_L"] = [8];
  var_2["front"]["up_body_R"] = [9];
  var_2["front"]["low_body_L"] = [10];
  var_2["front"]["low_body_R"] = [10];
  var_2["front"]["armor"] = [0];
  var_2["front"]["soft"] = [0];
  var_2["right"]["head"] = [7];
  var_2["right"]["up_chest"] = [7];
  var_2["right"]["low_chest"] = [11];
  var_2["right"]["up_body_L"] = [7];
  var_2["right"]["up_body_R"] = [7];
  var_2["right"]["low_body_L"] = [11];
  var_2["right"]["low_body_R"] = [11];
  var_2["right"]["armor"] = [0];
  var_2["right"]["soft"] = [0];
  var_2["left"]["head"] = [5];
  var_2["left"]["up_chest"] = [5];
  var_2["left"]["low_chest"] = [6];
  var_2["left"]["up_body_L"] = [5];
  var_2["left"]["up_body_R"] = [5];
  var_2["left"]["low_body_L"] = [6];
  var_2["left"]["low_body_R"] = [6];
  var_2["left"]["armor"] = [0];
  var_2["left"]["soft"] = [0];
  var_2["back"]["head"] = [12];
  var_2["back"]["up_chest"] = [12];
  var_2["back"]["low_chest"] = [13];
  var_2["back"]["up_body_L"] = [12];
  var_2["back"]["up_body_R"] = [12];
  var_2["back"]["low_body_L"] = [13];
  var_2["back"]["low_body_R"] = [13];
  var_2["back"]["armor"] = [0];
  var_2["back"]["soft"] = [0];
  var_0.var_C871["run"] = var_2;
  var_3 = [];
  var_3["front"]["head"] = [0];
  var_3["front"]["up_chest"] = [1];
  var_3["front"]["low_chest"] = [1];
  var_3["front"]["up_body_L"] = [2];
  var_3["front"]["up_body_R"] = [3];
  var_3["front"]["low_body_L"] = [4];
  var_3["front"]["low_body_R"] = [4];
  var_3["front"]["armor"] = [0];
  var_3["front"]["soft"] = [0];
  var_3["right"]["head"] = [7];
  var_3["right"]["up_chest"] = [7];
  var_3["right"]["low_chest"] = [8];
  var_3["right"]["up_body_L"] = [7];
  var_3["right"]["up_body_R"] = [7];
  var_3["right"]["low_body_L"] = [8];
  var_3["right"]["low_body_R"] = [8];
  var_3["right"]["armor"] = [0];
  var_3["right"]["soft"] = [0];
  var_3["left"]["head"] = [5];
  var_3["left"]["up_chest"] = [5];
  var_3["left"]["low_chest"] = [6];
  var_3["left"]["up_body_L"] = [5];
  var_3["left"]["up_body_R"] = [5];
  var_3["left"]["low_body_L"] = [6];
  var_3["left"]["low_body_R"] = [6];
  var_3["left"]["armor"] = [0];
  var_3["left"]["soft"] = [0];
  var_3["back"]["head"] = [9];
  var_3["back"]["up_chest"] = [9];
  var_3["back"]["low_chest"] = [10];
  var_3["back"]["up_body_L"] = [9];
  var_3["back"]["up_body_R"] = [9];
  var_3["back"]["low_body_L"] = [10];
  var_3["back"]["low_body_R"] = [10];
  var_3["back"]["armor"] = [0];
  var_3["back"]["soft"] = [0];
  var_0.var_C871["jump"] = var_3;
  var_4 = [];
  var_4["front"] = [0, 1];
  var_4["right"] = [2];
  var_4["left"] = [3];
  var_4["back"] = [4];
  var_0.var_C871["push_back"] = var_4;
  var_5 = [];
  var_5["front"] = [0];
  var_5["right"] = [0];
  var_5["left"] = [0];
  var_5["back"] = [0];
  var_0.var_C871["move_back"] = var_5;
  var_6 = [];
  var_6["front"] = [0, 1, 2];
  var_6["right"] = [0, 1, 2];
  var_6["left"] = [0, 1, 2];
  var_6["back"] = [0, 1, 2];
  var_0.var_C871["melee"] = var_6;
  var_7 = [];
  var_7["head"] = "head";
  var_7["neck"] = "head";
  var_7["torso_upper"] = "up_chest";
  var_7["none"] = "up_chest";
  var_7["torso_lower"] = "low_chest";
  var_7["left_arm_upper"] = "up_body_L";
  var_7["left_arm_lower"] = "up_body_L";
  var_7["left_hand"] = "up_body_L";
  var_7["right_arm_upper"] = "up_body_R";
  var_7["right_arm_lower"] = "up_body_R";
  var_7["right_hand"] = "up_body_R";
  var_7["left_leg_upper"] = "low_body_L";
  var_7["left_leg_lower"] = "low_body_L";
  var_7["left_foot"] = "low_body_L";
  var_7["right_leg_upper"] = "low_body_R";
  var_7["right_leg_lower"] = "low_body_R";
  var_7["right_foot"] = "low_body_R";
  var_7["armor"] = "armor";
  var_7["soft"] = "soft";
  var_0.var_C871["hitLoc"] = var_7;
  var_8 = [];
  var_8[0] = "back";
  var_8[1] = "back";
  var_8[2] = "right";
  var_8[3] = "right";
  var_8[4] = "front";
  var_8[5] = "left";
  var_8[6] = "left";
  var_8[7] = "back";
  var_8[8] = "back";
  var_0.var_C871["hitDirection"] = var_8;
  var_9 = [];
  var_9[0] = [0];
  var_9[1] = [1];
  var_9[2] = [2];
  var_9[3] = [3];
  var_9[4] = [4];
  var_9[5] = [5];
  var_9[6] = [6];
  var_9[7] = [7];
  var_9[8] = [8];
  var_9[9] = [9];
  var_9[10] = [10];
  var_0.var_C871["idleToImpactMap"] = var_9;
}

func_97C7(var_0) {
  var_0.var_4E2D = [];
  var_1 = [];
  var_1["front"]["head"] = [0];
  var_1["front"]["up_chest"] = [1];
  var_1["front"]["low_chest"] = [1];
  var_1["front"]["up_body_L"] = [1];
  var_1["front"]["up_body_R"] = [2];
  var_1["front"]["low_body_L"] = [2];
  var_1["front"]["low_body_R"] = [2];
  var_1["front"]["armor"] = [0];
  var_1["front"]["soft"] = [0];
  var_1["right"]["head"] = [0];
  var_1["right"]["up_chest"] = [4];
  var_1["right"]["low_chest"] = [3];
  var_1["right"]["up_body_L"] = [4];
  var_1["right"]["up_body_R"] = [4];
  var_1["right"]["low_body_L"] = [2];
  var_1["right"]["low_body_R"] = [2];
  var_1["right"]["armor"] = [0];
  var_1["right"]["soft"] = [0];
  var_1["left"]["head"] = [0];
  var_1["left"]["up_chest"] = [1];
  var_1["left"]["low_chest"] = [1];
  var_1["left"]["up_body_L"] = [1];
  var_1["left"]["up_body_R"] = [2];
  var_1["left"]["low_body_L"] = [5];
  var_1["left"]["low_body_R"] = [5];
  var_1["left"]["armor"] = [0];
  var_1["left"]["soft"] = [0];
  var_1["back"]["head"] = [0];
  var_1["back"]["up_chest"] = [1];
  var_1["back"]["low_chest"] = [1];
  var_1["back"]["up_body_L"] = [1];
  var_1["back"]["up_body_R"] = [2];
  var_1["back"]["low_body_L"] = [2];
  var_1["back"]["low_body_R"] = [2];
  var_1["back"]["armor"] = [0];
  var_1["back"]["soft"] = [0];
  var_0.var_4E2D["idle"] = var_1;
  var_2 = [];
  var_2["front"]["head"] = [0];
  var_2["front"]["up_chest"] = [1];
  var_2["front"]["low_chest"] = [3];
  var_2["front"]["up_body_L"] = [4];
  var_2["front"]["up_body_R"] = [9];
  var_2["front"]["low_body_L"] = [4];
  var_2["front"]["low_body_R"] = [3];
  var_2["front"]["armor"] = [0];
  var_2["front"]["soft"] = [0];
  var_2["right"]["head"] = [2];
  var_2["right"]["up_chest"] = [1];
  var_2["right"]["low_chest"] = [0];
  var_2["right"]["up_body_L"] = [7];
  var_2["right"]["up_body_R"] = [7];
  var_2["right"]["low_body_L"] = [3];
  var_2["right"]["low_body_R"] = [4];
  var_2["right"]["armor"] = [0];
  var_2["right"]["soft"] = [0];
  var_2["left"]["head"] = [5];
  var_2["left"]["up_chest"] = [5];
  var_2["left"]["low_chest"] = [6];
  var_2["left"]["up_body_L"] = [5];
  var_2["left"]["up_body_R"] = [5];
  var_2["left"]["low_body_L"] = [8];
  var_2["left"]["low_body_R"] = [6];
  var_2["left"]["armor"] = [0];
  var_2["left"]["soft"] = [0];
  var_2["back"]["head"] = [1];
  var_2["back"]["up_chest"] = [5];
  var_2["back"]["low_chest"] = [4];
  var_2["back"]["up_body_L"] = [3];
  var_2["back"]["up_body_R"] = [2];
  var_2["back"]["low_body_L"] = [1];
  var_2["back"]["low_body_R"] = [4];
  var_2["back"]["armor"] = [0];
  var_2["back"]["soft"] = [0];
  var_0.var_4E2D["run"] = var_2;
  var_3 = [];
  var_3["front"]["head"] = [1];
  var_3["front"]["up_chest"] = [0];
  var_3["front"]["low_chest"] = [0];
  var_3["front"]["up_body_L"] = [2];
  var_3["front"]["up_body_R"] = [3];
  var_3["front"]["low_body_L"] = [4];
  var_3["front"]["low_body_R"] = [4];
  var_3["front"]["armor"] = [1];
  var_3["front"]["soft"] = [1];
  var_3["right"]["head"] = [7];
  var_3["right"]["up_chest"] = [7];
  var_3["right"]["low_chest"] = [8];
  var_3["right"]["up_body_L"] = [7];
  var_3["right"]["up_body_R"] = [7];
  var_3["right"]["low_body_L"] = [8];
  var_3["right"]["low_body_R"] = [8];
  var_3["right"]["armor"] = [1];
  var_3["right"]["soft"] = [1];
  var_3["left"]["head"] = [5];
  var_3["left"]["up_chest"] = [5];
  var_3["left"]["low_chest"] = [6];
  var_3["left"]["up_body_L"] = [5];
  var_3["left"]["up_body_R"] = [5];
  var_3["left"]["low_body_L"] = [6];
  var_3["left"]["low_body_R"] = [6];
  var_3["left"]["armor"] = [1];
  var_3["left"]["soft"] = [1];
  var_3["back"]["head"] = [9];
  var_3["back"]["up_chest"] = [9];
  var_3["back"]["low_chest"] = [10];
  var_3["back"]["up_body_L"] = [9];
  var_3["back"]["up_body_R"] = [9];
  var_3["back"]["low_body_L"] = [10];
  var_3["back"]["low_body_R"] = [10];
  var_3["back"]["armor"] = [1];
  var_3["back"]["soft"] = [1];
  var_0.var_4E2D["jump"] = var_3;
  var_4 = [];
  var_4["head"] = "head";
  var_4["neck"] = "head";
  var_4["torso_upper"] = "up_chest";
  var_4["none"] = "up_chest";
  var_4["torso_lower"] = "low_chest";
  var_4["left_arm_upper"] = "up_body_L";
  var_4["left_arm_lower"] = "up_body_L";
  var_4["left_hand"] = "up_body_L";
  var_4["right_arm_upper"] = "up_body_R";
  var_4["right_arm_lower"] = "up_body_R";
  var_4["right_hand"] = "up_body_R";
  var_4["left_leg_upper"] = "low_body_L";
  var_4["left_leg_lower"] = "low_body_L";
  var_4["left_foot"] = "low_body_L";
  var_4["right_leg_upper"] = "low_body_R";
  var_4["right_leg_lower"] = "low_body_R";
  var_4["right_foot"] = "low_body_R";
  var_4["armor"] = "armor";
  var_4["soft"] = "soft";
  var_0.var_4E2D["hitLoc"] = var_4;
  var_5 = [];
  var_5[0] = "back";
  var_5[1] = "back";
  var_5[2] = "right";
  var_5[3] = "right";
  var_5[4] = "front";
  var_5[5] = "left";
  var_5[6] = "left";
  var_5[7] = "back";
  var_5[8] = "back";
  var_0.var_4E2D["hitDirection"] = var_5;
  var_6 = [];
  var_6["electric_shock_death"] = [0];
  var_6["traverse"] = [1];
  var_0.var_4E2D["special"] = var_6;
}

func_989F() {
  level.var_1BBA.var_1BCD[0] = 40;
  level.var_1BBA.var_1BCD[1] = 40;
  level.var_1BBA.var_1BCD[2] = 20;
}

func_DF12(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];
  var_6["animState"] = var_0;
  if(isDefined(var_1)) {
    var_6["animIndexArray"] = var_1;
  }

  if(isDefined(var_2)) {
    var_6["endInOriented"] = var_2;
  }

  if(isDefined(var_3)) {
    var_6["flexHeightEndAtTraverseEnd"] = var_3;
  }

  if(isDefined(var_4)) {
    var_6["traverseSound"] = var_4;
  }

  if(isDefined(var_5)) {
    var_6["traverseAnimScale"] = var_5;
  }

  return var_6;
}

func_129B5(var_0) {
  var_1 = var_0.origin - self.origin;
  return func_129B7(var_1);
}

func_129B7(var_0) {
  var_1 = func_81E1(anglesToForward(self.angles), var_0, anglestoup(self.angles));
  self orientmode("face angle abs", self.angles);
  if(var_1 != 4) {
    self.projectileintercept = 1;
    if(self.trajectorycanattemptaccuratejump) {
      self ghostlaunched("anim angle delta");
    } else {
      self ghostlaunched("anim deltas");
    }

    var_2 = linkto();
    scripts\mp\agents\_scriptedagents::func_CED5(var_2, var_1, "turn_in_place", "code_move");
    if(!lib_0A49::func_9C09()) {
      self.projectileintercept = 0;
    }

    return 1;
  }

  return 0;
}

linkto() {
  if(isDefined(level.var_5750)) {
    var_0 = [[level.var_5750]]();
    if(isDefined(var_0)) {
      return var_0;
    }
  }

  var_0 = undefined;
  switch (scripts\cp\cp_agent_utils::get_agent_type(self)) {
    case "gargoyle_boss":
    case "gargoyle":
      var_0 = [[level.var_1B6B["gargoyle"]["turn_in_place_anim_state"]]]();
      break;
  }

  if(!isDefined(var_0)) {
    var_0 = "turn_in_place";
  }

  return var_0;
}

func_81E1(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;
  var_5 = disableforcethirdpersonwhenfollowing(var_0, var_1, var_2);
  var_6 = var_5.var_E72A;
  var_7 = var_5.var_DA69;
  var_8 = 10;
  if(var_7 > 0) {
    var_4 = int(ceil(180 - var_6 - var_8 / 45));
  } else {
    var_4 = int(floor(180 + var_6 + var_8 / 45));
  }

  var_4 = int(clamp(var_4, 0, 8));
  return var_4;
}

disableforcethirdpersonwhenfollowing(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_4 = vectornormalize(func_DA68(var_0, var_2));
  var_5 = vectornormalize(func_DA68(var_1, var_2));
  var_6 = vectorcross(var_5, var_2);
  var_7 = vectornormalize(func_DA68(var_6, var_2));
  var_8 = vectordot(var_4 * -1, var_7);
  var_9 = vectordot(var_5, var_4);
  var_9 = clamp(var_9, -1, 1);
  var_10 = acos(var_9);
  var_3.var_E72A = var_10;
  var_3.var_DA69 = var_8;
  return var_3;
}

func_DA68(var_0, var_1) {
  var_2 = vectordot(var_0, var_1);
  var_3 = var_0 - var_1 * var_2;
  return var_3;
}

func_C864(var_0) {
  return level.var_1BBA.var_C871["hitLoc"][var_0];
}

func_C865(var_0) {
  var_1 = scripts\mp\agents\_scriptedagents::func_7DBD(var_0);
  return level.var_1BBA.var_C871["hitDirection"][var_1];
}

func_4E0C(var_0) {
  return level.var_1BBA.var_4E2D["hitLoc"][var_0];
}

func_4E0D(var_0) {
  var_1 = scripts\mp\agents\_scriptedagents::func_7DBD(var_0);
  return level.var_1BBA.var_4E2D["hitDirection"][var_1];
}

botnodepick(var_0, var_1, var_2) {
  var_3 = func_7E59(var_1, var_2);
  return var_0 + "_" + var_3;
}

func_7E59(var_0, var_1) {
  var_2 = scripts\cp\cp_agent_utils::get_agent_type(self);
  var_3 = level.var_1BA4[var_2].var_2552["heavy_damage_threshold"];
  if(var_0 < var_3 && !var_1) {
    return "light";
  }

  return "heavy";
}

botnodeavailable(var_0, var_1, var_2) {
  var_1 = func_C865(var_1 * -1);
  if(isDefined(var_2)) {
    var_2 = func_C864(var_2);
  }

  return botnodepickmultiple(var_0, var_1, var_2, level.var_1BBA.var_C871);
}

func_7F10(var_0) {
  var_1 = level.var_1BBA.var_C871["idleToImpactMap"][var_0];
  var_2 = randomintrange(0, var_1.size);
  return var_1[var_2];
}

func_7E62(var_0, var_1) {
  var_2 = func_7E59(var_1, 0);
  return var_0 + "_" + var_2;
}

func_7E61(var_0, var_1, var_2) {
  var_1 = func_4E0D(var_1 * -1);
  var_2 = func_4E0C(var_2);
  return botnodepickmultiple(var_0, var_1, var_2, level.var_1BBA.var_4E2D);
}

botnodepickmultiple(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2)) {
    var_4 = var_3[var_0][var_1][var_2];
  } else {
    var_4 = var_4[var_1][var_2];
  }

  return var_4[randomint(var_4.size)];
}

func_8146(var_0) {
  var_1 = level.var_1BBA.var_4E2D["special"][var_0];
  return var_1[randomint(var_1.size)];
}

func_E26A(var_0, var_1) {
  var_2 = getent(var_0, "targetname");
  var_2 setscriptablepartstate("animpart", 0);
}

func_CED8(var_0, var_1, var_2) {
  var_3 = getent(var_0, "targetname");
  if(!isDefined(var_3)) {
    return;
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_3 setscriptablepartstate("animpart", var_2);
  level notify("scriptable", var_0);
}

func_7F66(var_0) {
  var_1 = getanimlength(var_0);
  return min(0.2, var_1);
}

func_8088(var_0, var_1, var_2, var_3) {
  var_4 = getanimlength(var_0);
  var_5 = getmovedelta(var_0, 0, var_3 / var_4);
  var_6 = rotatevector(var_5, var_2);
  return var_1 + var_6;
}

func_58EA(var_0, var_1) {
  self endon("death");
  level endon("game_ended");
  self ghostexplode(self.origin, var_0, var_1);
  wait(var_1);
  self ghostlaunched("anim deltas");
}