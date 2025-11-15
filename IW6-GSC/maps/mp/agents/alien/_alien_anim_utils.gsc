/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\alien\_alien_anim_utils.gsc
******************************************************/

#include maps\mp\agents\_scriptedAgents;

initAlienAnims() {
  level.alienAnimData = spawnStruct();

  initAlienCannedTraverses(level.alienAnimData);

  initAlienJumpTraverses(level.alienAnimData);

  initAlienPain(level.alienAnimData);

  initAlienDeath(level.alienAnimData);

  initMoveBackAnims();

  level.alienAnimData.jumpLaunchArrival_maxMoveDelta = 107.659;
  level.alienAnimData.stopSoon_NotifyDist = 99.4488;
}

calculateAnimData() {
  calculate_jumpLaunchArrivalMaxMoveDelta();
  calculate_stopSoonNotifyDist();
}

calculate_jumpLaunchArrivalMaxMoveDelta() {
  iprintln("level.alienAnimData.jumpLaunchArrival_maxMoveDelta = " + calculate_maxMoveDeltaInAnimState("jump_launch_arrival"));
}

calculate_stopSoonNotifyDist() {
  iprintln("level.alienAnimData.stopSoon_NotifyDist = " + calculate_maxMoveDeltaInAnimState("run_stop"));
}

calculate_maxMoveDeltaInAnimState(animState) {
  maxMoveDeltaSq = 0;
  animCount = self GetAnimEntryCount(animState);

  for(i = 0; i < animCount; i++) {
    animEntry = self GetAnimEntry(animState, i);
    moveDelta = GetMoveDelta(animEntry, 0, 1);

    deltaDistSq = LengthSquared(moveDelta);
    if(deltaDistSq > maxMoveDeltaSq)
      maxMoveDeltaSq = deltaDistSq;
  }

  return sqrt(maxMoveDeltaSq);
}

initAlienCannedTraverses(alienAnimData) {
  alienAnimData.cannedTraverseAnims = [];

  alienAnimData.cannedTraverseAnims["alien_crawl_door"] = registerTraverseData("traverse_group_1", [0], false);
  alienAnimData.cannedTraverseAnims["alien_jump_sidewall_l"] = registerTraverseData("traverse_group_1", [1], false);
  alienAnimData.cannedTraverseAnims["alien_jump_sidewall_r"] = registerTraverseData("traverse_group_1", [2], false);
  alienAnimData.cannedTraverseAnims["alien_leap_clear_height_54"] = registerTraverseData("traverse_group_1", [3], false);
  alienAnimData.cannedTraverseAnims["alien_drone_traverse_corner_wall_crawl"] = registerTraverseData("traverse_group_1", [4], false);
  alienAnimData.cannedTraverseAnims["alien_leap_clear_height_36"] = registerTraverseData("traverse_group_1", [5], false);
  alienAnimData.cannedTraverseAnims["alien_leap_tree"] = registerTraverseData("traverse_group_1", [6], false);
  alienAnimData.cannedTraverseAnims["alien_crawl_under_car"] = registerTraverseData("traverse_group_1", [7], false);
  alienAnimData.cannedTraverseAnims["alien_crawl_on_car"] = registerTraverseData("traverse_group_1", [8], false);
  alienAnimData.cannedTraverseAnims["alien_step_up_56"] = registerTraverseData("traverse_group_1", [9], false);
  alienAnimData.cannedTraverseAnims["alien_step_down_56"] = registerTraverseData("traverse_group_1", [10], false);
  alienAnimData.cannedTraverseAnims["alien_crawl_deadtree"] = registerTraverseData("traverse_group_1", [11], false);
  alienAnimData.cannedTraverseAnims["alien_crawl_back_humvee"] = registerTraverseData("traverse_group_1", [12], false);
  alienAnimData.cannedTraverseAnims["alien_crawl_car"] = registerTraverseData("traverse_group_1", [13], false);
  alienAnimData.cannedTraverseAnims["alien_crawl_humvee"] = registerTraverseData("traverse_group_1", [14], false);
  alienAnimData.cannedTraverseAnims["alien_crawl_sidecar"] = registerTraverseData("traverse_group_1", [15], false);
  alienAnimData.cannedTraverseAnims["alien_crawl_sidehumvee"] = registerTraverseData("traverse_group_1", [16], false);
  alienAnimData.cannedTraverseAnims["alien_under_fence"] = registerTraverseData("traverse_group_1", [17, 24], false);
  alienAnimData.cannedTraverseAnims["alien_climb_up_spiral_tree"] = registerTraverseData("traverse_group_1", [18], true);
  alienAnimData.cannedTraverseAnims["alien_climb_up_gutter_L"] = registerTraverseData("traverse_group_1", [19], false);
  alienAnimData.cannedTraverseAnims["alien_climb_up_gutter_R"] = registerTraverseData("traverse_group_1", [20], false);
  alienAnimData.cannedTraverseAnims["alien_climb_over_fence_112"] = registerTraverseData("traverse_group_1", [21, 22, 23], false);

  alienAnimData.cannedTraverseAnims["alien_mantle_36"] = registerTraverseData("traverse_group_2", [0], false, true);
  alienAnimData.cannedTraverseAnims["alien_drone_traverse_climb_vault_8"] = registerTraverseData("traverse_group_2", [1], false, true);
  alienAnimData.cannedTraverseAnims["alien_drone_traverse_climb_over_fence"] = registerTraverseData("traverse_group_2", [2], false, true);
  alienAnimData.cannedTraverseAnims["alien_crawl_rail_vault_lodge"] = registerTraverseData("traverse_group_2", [3], false, true);
  alienAnimData.cannedTraverseAnims["alien_jump_rail_lodge"] = registerTraverseData("traverse_group_2", [4], false, false);
  alienAnimData.cannedTraverseAnims["alien_roof_to_ceiling"] = registerTraverseData("traverse_group_2", [5], false, true);
  alienAnimData.cannedTraverseAnims["alien_climb_over_fence_88"] = registerTraverseData("traverse_group_2", [6], false, true);
  alienAnimData.cannedTraverseAnims["alien_jump_down_100"] = registerTraverseData("traverse_group_2", [7], false, true);
  alienAnimData.cannedTraverseAnims["alien_jump_down_200"] = registerTraverseData("traverse_group_2", [8], false, true);
  alienAnimData.cannedTraverseAnims["alien_jump_up_70"] = registerTraverseData("traverse_group_2", [9], false, true);
  alienAnimData.cannedTraverseAnims["alien_jump_up_200"] = registerTraverseData("traverse_group_2", [10], false, true);
  alienAnimData.cannedTraverseAnims["alien_jump_down_straight"] = registerTraverseData("traverse_group_2", [11], false, true);
  alienAnimData.cannedTraverseAnims["alien_roof_to_ground"] = registerTraverseData("traverse_group_2", [12], false, true);
  alienAnimData.cannedTraverseAnims["alien_jump_up_128_rail_32"] = registerTraverseData("traverse_group_2", [13], false, false);
  alienAnimData.cannedTraverseAnims["alien_jump_up_128_rail_36"] = registerTraverseData("traverse_group_2", [14], false, false);
  alienAnimData.cannedTraverseAnims["alien_jump_up_128_rail_48"] = registerTraverseData("traverse_group_2", [15], false, false);
  alienAnimData.cannedTraverseAnims["alien_climb_up_rail_32_idle"] = registerTraverseData("traverse_group_2", [16], false, true);
  alienAnimData.cannedTraverseAnims["alien_climb_up_rail_32_run"] = registerTraverseData("traverse_group_2", [17], false, true);
  alienAnimData.cannedTraverseAnims["alien_mantle_32"] = registerTraverseData("traverse_group_2", [18], false, true);
  alienAnimData.cannedTraverseAnims["alien_mantle_48"] = registerTraverseData("traverse_group_2", [19], false, true);
  alienAnimData.cannedTraverseAnims["alien_jump_down_128_rail_32"] = registerTraverseData("traverse_group_2", [20], false, true);
  alienAnimData.cannedTraverseAnims["alien_jump_down_128_rail_36"] = registerTraverseData("traverse_group_2", [21], false, true);
  alienAnimData.cannedTraverseAnims["alien_jump_down_128_rail_48"] = registerTraverseData("traverse_group_2", [22], false, true);
  alienAnimData.cannedTraverseAnims["alien_climb_down_128_rail_36"] = registerTraverseData("traverse_group_2", [23], true, true);
  alienAnimData.cannedTraverseAnims["alien_mantle_crate_48"] = registerTraverseData("traverse_group_2", [24], false, true);
  alienAnimData.cannedTraverseAnims["alien_mantle_crate_64"] = registerTraverseData("traverse_group_2", [25], false, true);
  alienAnimData.cannedTraverseAnims["alien_jump_down_56_idle"] = registerTraverseData("traverse_group_2", [26], false, true);
  alienAnimData.cannedTraverseAnims["alien_jump_down_56_run"] = registerTraverseData("traverse_group_2", [27], false, true);
  alienAnimData.cannedTraverseAnims["alien_jump_up_56_idle"] = registerTraverseData("traverse_group_2", [28], false, true);
  alienAnimData.cannedTraverseAnims["alien_jump_up_56_run"] = registerTraverseData("traverse_group_2", [29], false, true);
  alienAnimData.cannedTraverseAnims["alien_jump_fence_88_enter_scale"] = registerTraverseData("traverse_group_2", [30], false, false);
  alienAnimData.cannedTraverseAnims["alien_jump_fence_88_exit_scale"] = registerTraverseData("traverse_group_2", [31], false, true);

  alienAnimData.cannedTraverseAnims["alien_jump_up_90_rail_32"] = registerTraverseData("traverse_group_3", [0], false, false);
  alienAnimData.cannedTraverseAnims["alien_jump_fence_high_to_low"] = registerTraverseData("traverse_group_3", [1], false, false);
  alienAnimData.cannedTraverseAnims["alien_jump_fence_low_to_high"] = registerTraverseData("traverse_group_3", [2], false, true);
  alienAnimData.cannedTraverseAnims["alien_jump_down_straight_forward_56"] = registerTraverseData("traverse_group_3", [3], false, true);
  alienAnimData.cannedTraverseAnims["alien_jump_down_straight_360_dlc"] = registerTraverseData("traverse_group_3", [4], false, true);
  alienAnimData.cannedTraverseAnims["alien_rail_32_jump_down_idle_dlc"] = registerTraverseData("traverse_group_3", [5], false, true);
  alienAnimData.cannedTraverseAnims["alien_rail_36_jump_down_idle_dlc"] = registerTraverseData("traverse_group_3", [6], false, true);
  alienAnimData.cannedTraverseAnims["alien_rail_48_jump_down_idle_dlc"] = registerTraverseData("traverse_group_3", [7], false, true);

  alienAnimData.cannedTraverseAnims["alien_climb_up"] = registerTraverseData("traverse_climb_up");
  alienAnimData.cannedTraverseAnims["alien_climb_down"] = registerTraverseData("traverse_climb_down");
  alienAnimData.cannedTraverseAnims["alien_climb_up_over_56"] = registerTraverseData("traverse_climb_up_over_56");
  alienAnimData.cannedTraverseAnims["alien_climb_over_56_down"] = registerTraverseData("traverse_climb_over_56_down");
  alienAnimData.cannedTraverseAnims["climb_up_end_jump_side_l"] = registerTraverseData("climb_up_end_jump_side_l");
  alienAnimData.cannedTraverseAnims["climb_up_end_jump_side_r"] = registerTraverseData("climb_up_end_jump_side_r");
  alienAnimData.cannedTraverseAnims["alien_climb_up_ledge_18_run"] = registerTraverseData("traverse_climb_up_ledge_18_run");
  alienAnimData.cannedTraverseAnims["alien_climb_up_ledge_18_idle"] = registerTraverseData("traverse_climb_up_ledge_18_idle");

  alienAnimData.cannedTraverseAnims["alien_wall_run"] = registerTraverseData("run");
}

initAlienJumpTraverses(alienAnimData) {
  level.alienAnimData.jumpGravity = 20.0 / 0.02205;

  level.alienAnimData.jumpLaunchGroundDelta = 16.8476;
  level.alienAnimData.jumpLaunchInAirAnimLength = 0.111111;

  level.alienAnimData.jumpLaunchDirection = [];
  level.alienAnimData.jumpLaunchDirection["jump_launch_up"] = [];
  level.alienAnimData.jumpLaunchDirection["jump_launch_level"] = [];
  level.alienAnimData.jumpLaunchDirection["jump_launch_down"] = [];

  level.alienAnimData.jumpLaunchDirection["jump_launch_up"][0] = (0.338726, 0, 0.940885);
  level.alienAnimData.jumpLaunchDirection["jump_launch_up"][1] = (0.688542, 0, 0.725196);
  level.alienAnimData.jumpLaunchDirection["jump_launch_up"][2] = (0.906517, 0, 0.422169);

  level.alienAnimData.jumpLaunchDirection["jump_launch_level"][0] = (0.248516, 0, 0.968628);
  level.alienAnimData.jumpLaunchDirection["jump_launch_level"][1] = (0.579155, 0, 0.815218);
  level.alienAnimData.jumpLaunchDirection["jump_launch_level"][2] = (0.906514, 0, 0.422177);

  level.alienAnimData.jumpLaunchDirection["jump_launch_down"][0] = (0.333125, 0, 0.942883);
  level.alienAnimData.jumpLaunchDirection["jump_launch_down"][1] = (0.518112, 0, 0.855313);
  level.alienAnimData.jumpLaunchDirection["jump_launch_down"][2] = (0.892489, 0, 0.451068);

  level.alienAnimData.inAirAnimEntry = [];
  level.alienAnimData.inAirAnimEntry["jump_launch_up"] = [];
  level.alienAnimData.inAirAnimEntry["jump_launch_level"] = [];
  level.alienAnimData.inAirAnimEntry["jump_launch_down"] = [];

  level.alienAnimData.inAirAnimEntry["jump_launch_up"]["jump_land_up"] = 0;
  level.alienAnimData.inAirAnimEntry["jump_launch_up"]["jump_land_level"] = 1;
  level.alienAnimData.inAirAnimEntry["jump_launch_up"]["jump_land_down"] = 2;
  level.alienAnimData.inAirAnimEntry["jump_launch_level"]["jump_land_up"] = 3;
  level.alienAnimData.inAirAnimEntry["jump_launch_level"]["jump_land_level"] = 4;
  level.alienAnimData.inAirAnimEntry["jump_launch_level"]["jump_land_down"] = 5;
  level.alienAnimData.inAirAnimEntry["jump_launch_down"]["jump_land_up"] = 6;
  level.alienAnimData.inAirAnimEntry["jump_launch_down"]["jump_land_level"] = 7;
  level.alienAnimData.inAirAnimEntry["jump_launch_down"]["jump_land_down"] = 8;
  level.alienAnimData.inAirAnimEntry["jump_launch_up"]["jump_land_sidewall_high"] = 9;
  level.alienAnimData.inAirAnimEntry["jump_launch_level"]["jump_land_sidewall_high"] = 9;
  level.alienAnimData.inAirAnimEntry["jump_launch_down"]["jump_land_sidewall_high"] = 9;
  level.alienAnimData.inAirAnimEntry["jump_launch_up"]["jump_land_sidewall_low"] = 9;
  level.alienAnimData.inAirAnimEntry["jump_launch_level"]["jump_land_sidewall_low"] = 9;
  level.alienAnimData.inAirAnimEntry["jump_launch_down"]["jump_land_sidewall_low"] = 9;
}

initAlienPain(alienAnimData) {
  alienAnimData.painAnims = [];

  idlePainAnims = [];
  idlePainAnims["front"]["head"] = [0];
  idlePainAnims["front"]["up_chest"] = [1];
  idlePainAnims["front"]["low_chest"] = [1];
  idlePainAnims["front"]["up_body_L"] = [1];
  idlePainAnims["front"]["up_body_R"] = [2];
  idlePainAnims["front"]["low_body_L"] = [2];
  idlePainAnims["front"]["low_body_R"] = [2];
  idlePainAnims["front"]["armor"] = [0];
  idlePainAnims["front"]["soft"] = [0];
  idlePainAnims["right"]["head"] = [0];
  idlePainAnims["right"]["up_chest"] = [3];
  idlePainAnims["right"]["low_chest"] = [3];
  idlePainAnims["right"]["up_body_L"] = [3];
  idlePainAnims["right"]["up_body_R"] = [2];
  idlePainAnims["right"]["low_body_L"] = [4];
  idlePainAnims["right"]["low_body_R"] = [4];
  idlePainAnims["right"]["armor"] = [0];
  idlePainAnims["right"]["soft"] = [0];
  idlePainAnims["left"]["head"] = [0];
  idlePainAnims["left"]["up_chest"] = [1];
  idlePainAnims["left"]["low_chest"] = [1];
  idlePainAnims["left"]["up_body_L"] = [5];
  idlePainAnims["left"]["up_body_R"] = [5];
  idlePainAnims["left"]["low_body_L"] = [6];
  idlePainAnims["left"]["low_body_R"] = [6];
  idlePainAnims["left"]["armor"] = [2];
  idlePainAnims["left"]["soft"] = [2];
  idlePainAnims["back"]["head"] = [0];
  idlePainAnims["back"]["up_chest"] = [1];
  idlePainAnims["back"]["low_chest"] = [1];
  idlePainAnims["back"]["up_body_L"] = [1];
  idlePainAnims["back"]["up_body_R"] = [7];
  idlePainAnims["back"]["low_body_L"] = [7];
  idlePainAnims["back"]["low_body_R"] = [7];
  idlePainAnims["back"]["armor"] = [0];
  idlePainAnims["back"]["soft"] = [0];
  alienAnimData.painAnims["idle"] = idlePainAnims;

  runPainAnims = [];
  runPainAnims["front"]["head"] = [0];
  runPainAnims["front"]["up_chest"] = [9];
  runPainAnims["front"]["low_chest"] = [8];
  runPainAnims["front"]["up_body_L"] = [8];
  runPainAnims["front"]["up_body_R"] = [9];
  runPainAnims["front"]["low_body_L"] = [10];
  runPainAnims["front"]["low_body_R"] = [10];
  runPainAnims["front"]["armor"] = [0];
  runPainAnims["front"]["soft"] = [0];
  runPainAnims["right"]["head"] = [7];
  runPainAnims["right"]["up_chest"] = [7];
  runPainAnims["right"]["low_chest"] = [11];
  runPainAnims["right"]["up_body_L"] = [7];
  runPainAnims["right"]["up_body_R"] = [7];
  runPainAnims["right"]["low_body_L"] = [11];
  runPainAnims["right"]["low_body_R"] = [11];
  runPainAnims["right"]["armor"] = [0];
  runPainAnims["right"]["soft"] = [0];
  runPainAnims["left"]["head"] = [5];
  runPainAnims["left"]["up_chest"] = [5];
  runPainAnims["left"]["low_chest"] = [6];
  runPainAnims["left"]["up_body_L"] = [5];
  runPainAnims["left"]["up_body_R"] = [5];
  runPainAnims["left"]["low_body_L"] = [6];
  runPainAnims["left"]["low_body_R"] = [6];
  runPainAnims["left"]["armor"] = [0];
  runPainAnims["left"]["soft"] = [0];
  runPainAnims["back"]["head"] = [12];
  runPainAnims["back"]["up_chest"] = [12];
  runPainAnims["back"]["low_chest"] = [13];
  runPainAnims["back"]["up_body_L"] = [12];
  runPainAnims["back"]["up_body_R"] = [12];
  runPainAnims["back"]["low_body_L"] = [13];
  runPainAnims["back"]["low_body_R"] = [13];
  runPainAnims["back"]["armor"] = [0];
  runPainAnims["back"]["soft"] = [0];
  alienAnimData.painAnims["run"] = runPainAnims;

  jumpPainAnims = [];
  jumpPainAnims["front"]["head"] = [0];
  jumpPainAnims["front"]["up_chest"] = [1];
  jumpPainAnims["front"]["low_chest"] = [1];
  jumpPainAnims["front"]["up_body_L"] = [2];
  jumpPainAnims["front"]["up_body_R"] = [3];
  jumpPainAnims["front"]["low_body_L"] = [4];
  jumpPainAnims["front"]["low_body_R"] = [4];
  jumpPainAnims["front"]["armor"] = [0];
  jumpPainAnims["front"]["soft"] = [0];
  jumpPainAnims["right"]["head"] = [7];
  jumpPainAnims["right"]["up_chest"] = [7];
  jumpPainAnims["right"]["low_chest"] = [8];
  jumpPainAnims["right"]["up_body_L"] = [7];
  jumpPainAnims["right"]["up_body_R"] = [7];
  jumpPainAnims["right"]["low_body_L"] = [8];
  jumpPainAnims["right"]["low_body_R"] = [8];
  jumpPainAnims["right"]["armor"] = [0];
  jumpPainAnims["right"]["soft"] = [0];
  jumpPainAnims["left"]["head"] = [5];
  jumpPainAnims["left"]["up_chest"] = [5];
  jumpPainAnims["left"]["low_chest"] = [6];
  jumpPainAnims["left"]["up_body_L"] = [5];
  jumpPainAnims["left"]["up_body_R"] = [5];
  jumpPainAnims["left"]["low_body_L"] = [6];
  jumpPainAnims["left"]["low_body_R"] = [6];
  jumpPainAnims["left"]["armor"] = [0];
  jumpPainAnims["left"]["soft"] = [0];
  jumpPainAnims["back"]["head"] = [9];
  jumpPainAnims["back"]["up_chest"] = [9];
  jumpPainAnims["back"]["low_chest"] = [10];
  jumpPainAnims["back"]["up_body_L"] = [9];
  jumpPainAnims["back"]["up_body_R"] = [9];
  jumpPainAnims["back"]["low_body_L"] = [10];
  jumpPainAnims["back"]["low_body_R"] = [10];
  jumpPainAnims["back"]["armor"] = [0];
  jumpPainAnims["back"]["soft"] = [0];
  alienAnimData.painAnims["jump"] = jumpPainAnims;

  pushbackPainAnims = [];
  pushbackPainAnims["front"] = [0, 1];
  pushbackPainAnims["right"] = [2];
  pushbackPainAnims["left"] = [3];
  pushbackPainAnims["back"] = [4];
  alienAnimData.painAnims["push_back"] = pushbackPainAnims;

  movebackPainAnims = [];
  movebackPainAnims["front"] = [0];
  movebackPainAnims["right"] = [0];
  movebackPainAnims["left"] = [0];
  movebackPainAnims["back"] = [0];
  alienAnimData.painAnims["move_back"] = movebackPainAnims;

  meleePainAnims = [];
  meleePainAnims["front"] = [0, 1, 2];
  meleePainAnims["right"] = [0, 1, 2];
  meleePainAnims["left"] = [0, 1, 2];
  meleePainAnims["back"] = [0, 1, 2];
  alienAnimData.painAnims["melee"] = meleePainAnims;

  combinedHitLoc = [];
  combinedHitLoc["head"] = "head";
  combinedHitLoc["neck"] = "head";
  combinedHitLoc["torso_upper"] = "up_chest";
  combinedHitLoc["none"] = "up_chest";
  combinedHitLoc["torso_lower"] = "low_chest";
  combinedHitLoc["left_arm_upper"] = "up_body_L";
  combinedHitLoc["left_arm_lower"] = "up_body_L";
  combinedHitLoc["left_hand"] = "up_body_L";
  combinedHitLoc["right_arm_upper"] = "up_body_R";
  combinedHitLoc["right_arm_lower"] = "up_body_R";
  combinedHitLoc["right_hand"] = "up_body_R";
  combinedHitLoc["left_leg_upper"] = "low_body_L";
  combinedHitLoc["left_leg_lower"] = "low_body_L";
  combinedHitLoc["left_foot"] = "low_body_L";
  combinedHitLoc["right_leg_upper"] = "low_body_R";
  combinedHitLoc["right_leg_lower"] = "low_body_R";
  combinedHitLoc["right_foot"] = "low_body_R";
  combinedHitLoc["armor"] = "armor";
  combinedHitLoc["soft"] = "soft";
  alienAnimData.painAnims["hitLoc"] = combinedHitLoc;

  hitDirection = [];
  hitDirection[0] = "back";
  hitDirection[1] = "back";
  hitDirection[2] = "right";
  hitDirection[3] = "right";
  hitDirection[4] = "front";
  hitDirection[5] = "left";
  hitDirection[6] = "left";
  hitDirection[7] = "back";
  hitDirection[8] = "back";
  alienAnimData.painAnims["hitDirection"] = hitDirection;

  jumpPainIdleToImpactMap = [];

  jumpPainIdleToImpactMap[0] = [0];
  jumpPainIdleToImpactMap[1] = [1];
  jumpPainIdleToImpactMap[2] = [2];
  jumpPainIdleToImpactMap[3] = [3];
  jumpPainIdleToImpactMap[4] = [4];
  jumpPainIdleToImpactMap[5] = [5];
  jumpPainIdleToImpactMap[6] = [6];
  jumpPainIdleToImpactMap[7] = [7];
  jumpPainIdleToImpactMap[8] = [8];
  jumpPainIdleToImpactMap[9] = [9];
  jumpPainIdleToImpactMap[10] = [10];
  alienAnimData.painAnims["idleToImpactMap"] = jumpPainIdleToImpactMap;
}

initAlienDeath(alienAnimData) {
  alienAnimData.deathAnims = [];

  idleDeathAnims = [];
  idleDeathAnims["front"]["head"] = [0];
  idleDeathAnims["front"]["up_chest"] = [1];
  idleDeathAnims["front"]["low_chest"] = [1];
  idleDeathAnims["front"]["up_body_L"] = [1];
  idleDeathAnims["front"]["up_body_R"] = [2];
  idleDeathAnims["front"]["low_body_L"] = [2];
  idleDeathAnims["front"]["low_body_R"] = [2];
  idleDeathAnims["front"]["armor"] = [0];
  idleDeathAnims["front"]["soft"] = [0];
  idleDeathAnims["right"]["head"] = [0];
  idleDeathAnims["right"]["up_chest"] = [4];
  idleDeathAnims["right"]["low_chest"] = [3];
  idleDeathAnims["right"]["up_body_L"] = [4];
  idleDeathAnims["right"]["up_body_R"] = [4];
  idleDeathAnims["right"]["low_body_L"] = [2];
  idleDeathAnims["right"]["low_body_R"] = [2];
  idleDeathAnims["right"]["armor"] = [0];
  idleDeathAnims["right"]["soft"] = [0];
  idleDeathAnims["left"]["head"] = [0];
  idleDeathAnims["left"]["up_chest"] = [1];
  idleDeathAnims["left"]["low_chest"] = [1];
  idleDeathAnims["left"]["up_body_L"] = [1];
  idleDeathAnims["left"]["up_body_R"] = [2];
  idleDeathAnims["left"]["low_body_L"] = [5];
  idleDeathAnims["left"]["low_body_R"] = [5];
  idleDeathAnims["left"]["armor"] = [0];
  idleDeathAnims["left"]["soft"] = [0];
  idleDeathAnims["back"]["head"] = [0];
  idleDeathAnims["back"]["up_chest"] = [1];
  idleDeathAnims["back"]["low_chest"] = [1];
  idleDeathAnims["back"]["up_body_L"] = [1];
  idleDeathAnims["back"]["up_body_R"] = [2];
  idleDeathAnims["back"]["low_body_L"] = [2];
  idleDeathAnims["back"]["low_body_R"] = [2];
  idleDeathAnims["back"]["armor"] = [0];
  idleDeathAnims["back"]["soft"] = [0];
  alienAnimData.deathAnims["idle"] = idleDeathAnims;

  runDeathAnims = [];
  runDeathAnims["front"]["head"] = [0];
  runDeathAnims["front"]["up_chest"] = [1];
  runDeathAnims["front"]["low_chest"] = [3];
  runDeathAnims["front"]["up_body_L"] = [4];
  runDeathAnims["front"]["up_body_R"] = [9];
  runDeathAnims["front"]["low_body_L"] = [4];
  runDeathAnims["front"]["low_body_R"] = [3];
  runDeathAnims["front"]["armor"] = [0];
  runDeathAnims["front"]["soft"] = [0];
  runDeathAnims["right"]["head"] = [2];
  runDeathAnims["right"]["up_chest"] = [1];
  runDeathAnims["right"]["low_chest"] = [0];
  runDeathAnims["right"]["up_body_L"] = [7];
  runDeathAnims["right"]["up_body_R"] = [7];
  runDeathAnims["right"]["low_body_L"] = [3];
  runDeathAnims["right"]["low_body_R"] = [4];
  runDeathAnims["right"]["armor"] = [0];
  runDeathAnims["right"]["soft"] = [0];
  runDeathAnims["left"]["head"] = [5];
  runDeathAnims["left"]["up_chest"] = [5];
  runDeathAnims["left"]["low_chest"] = [6];
  runDeathAnims["left"]["up_body_L"] = [5];
  runDeathAnims["left"]["up_body_R"] = [5];
  runDeathAnims["left"]["low_body_L"] = [8];
  runDeathAnims["left"]["low_body_R"] = [6];
  runDeathAnims["left"]["armor"] = [0];
  runDeathAnims["left"]["soft"] = [0];
  runDeathAnims["back"]["head"] = [1];
  runDeathAnims["back"]["up_chest"] = [5];
  runDeathAnims["back"]["low_chest"] = [4];
  runDeathAnims["back"]["up_body_L"] = [3];
  runDeathAnims["back"]["up_body_R"] = [2];
  runDeathAnims["back"]["low_body_L"] = [1];
  runDeathAnims["back"]["low_body_R"] = [4];
  runDeathAnims["back"]["armor"] = [0];
  runDeathAnims["back"]["soft"] = [0];
  alienAnimData.deathAnims["run"] = runDeathAnims;

  jumpDeathAnims = [];
  jumpDeathAnims["front"]["head"] = [1];
  jumpDeathAnims["front"]["up_chest"] = [0];
  jumpDeathAnims["front"]["low_chest"] = [0];
  jumpDeathAnims["front"]["up_body_L"] = [2];
  jumpDeathAnims["front"]["up_body_R"] = [3];
  jumpDeathAnims["front"]["low_body_L"] = [4];
  jumpDeathAnims["front"]["low_body_R"] = [4];
  jumpDeathAnims["front"]["armor"] = [1];
  jumpDeathAnims["front"]["soft"] = [1];
  jumpDeathAnims["right"]["head"] = [7];
  jumpDeathAnims["right"]["up_chest"] = [7];
  jumpDeathAnims["right"]["low_chest"] = [8];
  jumpDeathAnims["right"]["up_body_L"] = [7];
  jumpDeathAnims["right"]["up_body_R"] = [7];
  jumpDeathAnims["right"]["low_body_L"] = [8];
  jumpDeathAnims["right"]["low_body_R"] = [8];
  jumpDeathAnims["right"]["armor"] = [1];
  jumpDeathAnims["right"]["soft"] = [1];
  jumpDeathAnims["left"]["head"] = [5];
  jumpDeathAnims["left"]["up_chest"] = [5];
  jumpDeathAnims["left"]["low_chest"] = [6];
  jumpDeathAnims["left"]["up_body_L"] = [5];
  jumpDeathAnims["left"]["up_body_R"] = [5];
  jumpDeathAnims["left"]["low_body_L"] = [6];
  jumpDeathAnims["left"]["low_body_R"] = [6];
  jumpDeathAnims["left"]["armor"] = [1];
  jumpDeathAnims["left"]["soft"] = [1];
  jumpDeathAnims["back"]["head"] = [9];
  jumpDeathAnims["back"]["up_chest"] = [9];
  jumpDeathAnims["back"]["low_chest"] = [10];
  jumpDeathAnims["back"]["up_body_L"] = [9];
  jumpDeathAnims["back"]["up_body_R"] = [9];
  jumpDeathAnims["back"]["low_body_L"] = [10];
  jumpDeathAnims["back"]["low_body_R"] = [10];
  jumpDeathAnims["back"]["armor"] = [1];
  jumpDeathAnims["back"]["soft"] = [1];
  alienAnimData.deathAnims["jump"] = jumpDeathAnims;

  combinedHitLoc = [];
  combinedHitLoc["head"] = "head";
  combinedHitLoc["neck"] = "head";
  combinedHitLoc["torso_upper"] = "up_chest";
  combinedHitLoc["none"] = "up_chest";
  combinedHitLoc["torso_lower"] = "low_chest";
  combinedHitLoc["left_arm_upper"] = "up_body_L";
  combinedHitLoc["left_arm_lower"] = "up_body_L";
  combinedHitLoc["left_hand"] = "up_body_L";
  combinedHitLoc["right_arm_upper"] = "up_body_R";
  combinedHitLoc["right_arm_lower"] = "up_body_R";
  combinedHitLoc["right_hand"] = "up_body_R";
  combinedHitLoc["left_leg_upper"] = "low_body_L";
  combinedHitLoc["left_leg_lower"] = "low_body_L";
  combinedHitLoc["left_foot"] = "low_body_L";
  combinedHitLoc["right_leg_upper"] = "low_body_R";
  combinedHitLoc["right_leg_lower"] = "low_body_R";
  combinedHitLoc["right_foot"] = "low_body_R";
  combinedHitLoc["armor"] = "armor";
  combinedHitLoc["soft"] = "soft";
  alienAnimData.deathAnims["hitLoc"] = combinedHitLoc;

  hitDirection = [];
  hitDirection[0] = "back";
  hitDirection[1] = "back";
  hitDirection[2] = "right";
  hitDirection[3] = "right";
  hitDirection[4] = "front";
  hitDirection[5] = "left";
  hitDirection[6] = "left";
  hitDirection[7] = "back";
  hitDirection[8] = "back";
  alienAnimData.deathAnims["hitDirection"] = hitDirection;

  specialDeathAnims = [];
  specialDeathAnims["electric_shock_death"] = [0];
  specialDeathAnims["traverse"] = [1];
  alienAnimData.deathAnims["special"] = specialDeathAnims;
}

initMoveBackAnims() {
  level.alienAnimData.alienMoveBackAnimChance[0] = 40;
  level.alienAnimData.alienMoveBackAnimChance[1] = 40;
  level.alienAnimData.alienMoveBackAnimChance[2] = 20;
}

registerTraverseData(animState, animIndexArray, endInOriented, flexHeightEndAtTraverseEnd, traverseSound, traverseAnimScale) {
  assertEx(isDefined(animState));

  traverseData = [];
  traverseData["animState"] = animState;

  if(isDefined(animIndexArray))
    traverseData["animIndexArray"] = animIndexArray;

  if(isDefined(endInOriented))
    traverseData["endInOriented"] = endInOriented;

  if(isDefined(flexHeightEndAtTraverseEnd))
    traverseData["flexHeightEndAtTraverseEnd"] = flexHeightEndAtTraverseEnd;

  if(isDefined(traverseSound))
    traverseData["traverseSound"] = traverseSound;

  if(isDefined(traverseAnimScale))
    traverseData["traverseAnimScale"] = traverseAnimScale;

  return traverseData;
}

turnTowardsEntity(entity) {
  targetVector = entity.origin - self.origin;
  return turnTowardsVector(targetVector);
}

turnTowardsVector(targetVector) {
  turnIndex = getTurnInPlaceIndex(anglesToForward(self.angles), targetVector, AnglesToUp(self.angles));
  self ScrAgentSetOrientMode("face angle abs", self.angles);
  if(turnIndex != 4) {
    self.stateLocked = true;
    if(self.oriented)
      self ScrAgentSetAnimMode("anim angle delta");
    else
      self ScrAgentSetAnimMode("anim deltas");
    animState = getTurnInPlaceAnimState();
    self PlayAnimNUntilNotetrack(animState, turnIndex, "turn_in_place", "code_move");

    if(!self maps\mp\alien\_utility::is_idle_state_locked())
      self.stateLocked = false;

    return true;
  }
  return false;
}

getTurnInPlaceAnimState() {
  if(isDefined(level.dlc_alien_turn_in_place_anim_state_override_func)) {
    animState = [[level.dlc_alien_turn_in_place_anim_state_override_func]]();
    if(isDefined(animState))
      return animState;
  }

  return "turn_in_place";
}

getTurnInPlaceIndex(inVector, outVector, surfaceNormal) {
  turnAnim = undefined;
  index = undefined;

  projData = getProjectionData(inVector, outVector, surfaceNormal);
  rotatedYaw = projData.rotatedYaw;
  projInToOutRight = projData.projInToOutRight;

  threshold = 10;

  if(projInToOutRight > 0) {
    index = int(ceil((180 - rotatedYaw - threshold) / 45));
  } else {
    index = int(floor((180 + rotatedYaw + threshold) / 45));
  }
  index = int(clamp(index, 0, 8));
  return index;
}

getProjectionData(inVector, outVector, surfaceNormal) {
  projectionData = spawnStruct();

  inVectorNoNormal = vectorNormalize(projectVectorToPlane(inVector, surfaceNormal));
  outVectorNoNormal = vectorNormalize(projectVectorToPlane(outVector, surfaceNormal));

  outVectorRight = VectorCross(outVectorNoNormal, surfaceNormal);
  outVectorRightNoNormal = VectorNormalize(projectVectorToPlane(outVectorRight, surfaceNormal));
  projInToOutRight = VectorDot(inVectorNoNormal * -1, outVectorRightNoNormal);

  ratio = vectorDot(outVectorNoNormal, inVectorNoNormal);

  ratio = clamp(ratio, -1, 1);

  rotatedYaw = Acos(ratio);

  projectionData.rotatedYaw = rotatedYaw;
  projectionData.projInToOutRight = projInToOutRight;

  return projectionData;
}

projectVectorToPlane(vector, planeUp) {
  dotResult = VectorDot(vector, planeUp);
  projVector = vector - (planeUp * dotResult);
  return projVector;
}

pain_getCombinedHitLoc(hitLoc) {
  return (level.alienAnimData.painAnims["hitLoc"][hitLoc]);
}

pain_getIncomingDirection(direction) {
  directionIndex = maps\mp\agents\_scriptedagents::GetAngleIndexFromSelfYaw(direction);
  return (level.alienAnimData.painAnims["hitDirection"][directionIndex]);
}

death_getCombinedHitLoc(hitLoc) {
  return (level.alienAnimData.deathAnims["hitLoc"][hitLoc]);
}

death_getIncomingDirection(direction) {
  directionIndex = maps\mp\agents\_scriptedagents::GetAngleIndexFromSelfYaw(direction);
  return (level.alienAnimData.deathAnims["hitDirection"][directionIndex]);
}

getPainAnimState(state, iDamage, is_stun) {
  secondaryState = getDamageDegree(iDamage, is_stun);
  return (state + "_" + secondaryState);
}

getDamageDegree(iDamage, is_stun) {
  alienType = self maps\mp\alien\_utility::get_alien_type();
  damageThreshold = level.alien_types[alienType].attributes["heavy_damage_threshold"];

  if(iDamage < damageThreshold && !is_stun)
    return "light";
  else
    return "heavy";
}

getPainAnimIndex(state, damageDirection, hitLoc) {
  damageDirection = pain_getIncomingDirection(damageDirection * -1);

  if(isDefined(hitLoc))
    hitLoc = pain_getCombinedHitLoc(hitLoc);

  return getPainDeathAnimIndex_Internal(state, damageDirection, hitLoc, level.alienAnimData.painAnims);
}

GetImpactPainAnimIndex(jump_pain_index) {
  available_impact = level.alienAnimData.painAnims["idleToImpactMap"][jump_pain_index];
  random_impact_index = randomIntRange(0, available_impact.size);
  return available_impact[random_impact_index];
}

getDeathAnimState(state, iDamage) {
  secondaryState = getDamageDegree(iDamage, false);
  return (state + "_" + secondaryState);
}

getDeathAnimIndex(state, damageDirection, hitLoc) {
  damageDirection = death_getIncomingDirection(damageDirection * -1);
  hitLoc = death_getCombinedHitLoc(hitLoc);
  return getPainDeathAnimIndex_Internal(state, damageDirection, hitLoc, level.alienAnimData.deathAnims);
}

getPainDeathAnimIndex_Internal(state, damageDirection, hitLoc, animArray) {
  if(isDefined(hitLoc))
    availableIndexList = animArray[state][damageDirection][hitLoc];
  else
    availableIndexList = animArray[state][damageDirection];

  return (availableIndexList[randomInt(availableIndexList.size)]);
}

getSpecialDeathAnimIndex(state) {
  availableIndexList = level.alienAnimData.deathAnims["special"][state];
  return (availableIndexList[randomInt(availableIndexList.size)]);
}

resetScriptable(scriptableName, endPos) {
  scriptable_obj = GetEnt(scriptableName, "targetname");
  AssertEx(isDefined(scriptable_obj), "Unable to find a scriptable object with targetname: " + scriptableName + " at location " + endPos);
  scriptable_obj SetScriptablePartState(0, 0);
}

playAnimOnScriptable(scriptableName, endPos, scriptableState) {
  scriptable_obj = GetEnt(scriptableName, "targetname");
  AssertEx(isDefined(scriptable_obj), "Unable to find a scriptable object with targetname: " + scriptableName + " at location " + endPos);

  if(!isDefined(scriptableState))
    scriptableState = 1;

  scriptable_obj SetScriptablePartState(0, scriptableState);

  level notify("scriptable", scriptableName);
}

getLerpTime(startAnim) {
  startAnimLength = GetAnimLength(startAnim);
  return min(0.2, startAnimLength);
}

getPosInSpaceAtAnimTime(anime, start_pos, start_angles, time) {
  animLength = GetAnimLength(anime);
  animDelta = GetMoveDelta(anime, 0, time / animLength);
  offsetFromStart = RotateVector(animDelta, start_angles);

  return (start_pos + offsetFromStart);
}

doLerp(lerp_target_pos, lerp_time) {
  self endon("death");
  level endon("game_ended");

  self ScrAgentDoAnimLerp(self.origin, lerp_target_pos, lerp_time);
  wait lerp_time;
  self ScrAgentSetAnimMode("anim deltas");
}