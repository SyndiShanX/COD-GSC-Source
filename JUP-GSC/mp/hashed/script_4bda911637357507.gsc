/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4bda911637357507.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_a_ob_contracts_escort_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_a_ob_contracts_escort_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_a_ob_contracts_escort_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_a_ob_contracts_escort_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_a_ob_contracts_escort_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_a_ob_contracts_escort_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_a_ob_contracts_escort_cs");
}

function function_fd69cf02ba4d90a2() {
  activityinfostruct = spawnStruct();
  activityinfostruct.name = "REV_OB_ESCORT_ZOMBIES";
  activityinfostruct.mainfunction = &main;
  activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  activityinfostruct.metadatafunction = &function_6da2952367672ac0;
  return activityinfostruct;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_a_ob_contracts_escort_cs";
  }

  switch (instancename) {
    case #"hash_4f06561c1081f600":
      function_bbbff3c138eaf533(fe, us, cf);
      break;
    case #"hash_72d21f7bb9f8e219":
      function_30217896c8a151b8(fe, us, cf);
      break;
    case #"hash_5b5bdcf94368ef6c":
      function_afe4d7ffe2d8a957(fe, us, cf);
      break;
  }
}

function function_bbbff3c138eaf533(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-27362, 30400, 1386), (0, 0, 0), "escort_a_burgertown_parking_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-25870, 27720, 1442), (0, 0, 0), "ESCORT_ZOMBIES_A_BURGERTOWN_PARKING", undefined, "escort_a_burgertown_parking", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-26074, 30481, 1439.16), (0, 181.59, 0), "activity_nexus_instance_joiner", "ESCORT_ZOMBIES_A_BURGERTOWN_PARKING", "ESCORT_ZOMBIES_A_BURGERTOWN_PARKING", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-27710, 29238, 1376), (0, 0, 0), "escort_a_burgertown_parking_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-28204, 29958, 1450), (0, 0, 0), "escort_a_burgertown_parking_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-28570, 28196, 1386.12), (0, 0, 0), "escort_a_burgertown_parking_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-29446, 28674, 1386), (0, 0, 0), "escort_a_burgertown_parking_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-26972, 26472, 1409.55), (0, 0, 0), "escort_a_burgertown_parking_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-27926, 26146, 1356.8), (0, 0, 0), "escort_a_burgertown_parking_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-28082, 25200, 1282.2), (0, 0, 0), "escort_a_burgertown_parking_ambush_05", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-29370, 26124, 1386), (0, 0, 0), "escort_a_burgertown_parking_ambush_05", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-29194, 25136, 1298.1), (0, 0, 0), "escort_a_burgertown_parking_ambush_06", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-30818, 24060, 1290), (0, 0, 0), "escort_a_burgertown_parking_ambush_07", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-30618, 23422, 1288), (0, 0, 0), "escort_a_burgertown_parking_ambush_08", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-29322, 24316, 1286), (0, 0, 0), "escort_a_burgertown_parking_ambush_08", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-29418, 22874, 1369), (0, 0, 0), "escort_a_burgertown_parking_ambush_09", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-27904, 27658, 1374), (0, 0, 0), "escort_a_burgertown_parking_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-29636, 28864, 1376), (0, 0, 0), "escort_a_burgertown_parking_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-28316, 29756, 1450), (0, 0, 0), "escort_a_burgertown_parking_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-28146, 24578, 1289), (0, 0, 0), "escort_a_burgertown_parking_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-28836, 26520, 1386), (0, 0, 0), "escort_a_burgertown_parking_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-30334, 25662, 1386), (0, 0, 0), "escort_a_burgertown_parking_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-31492, 23212, 1289), (0, 0, 0), "escort_a_burgertown_parking_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-30134, 24120, 1282), (0, 0, 0), "escort_a_burgertown_parking_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-31124, 22050, 1289), (0, 0, 0), "escort_a_burgertown_parking_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-28950, 23984, 1369), (0, 0, 0), "escort_a_burgertown_parking_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-29288, 24766, 1289), (0, 0, 0), "escort_a_burgertown_parking_horde_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-29414, 28546, 1386), (0, 0, 0), "escort_a_burgertown_parking_horde_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-29560, 22408, 1369), (0, 0, 0), "escort_a_burgertown_parking_horde_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-29836, 23082, 1280), (0, 158, 0), "ESCORT_ZOMBIES_A_BURGERTOWN_PARKING_REWARD", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_30217896c8a151b8(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-34910, 35636, 1380), (0, 0, 0), "ESCORT_ZOMBIES_A_CONSTRUCTION_RESORT", undefined, "escort_a_construction_resort", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-32178, 30120, 1376), (0, 56, 0), "ESCORT_ZOMBIES_A_CONSTRUCTION_RESORT_REWARD", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-32148, 36057, 1413.79), (0, 270, 0), "activity_nexus_instance_joiner", "ESCORT_ZOMBIES_A_CONSTRUCTION_RESORT", "ESCORT_ZOMBIES_A_CONSTRUCTION_RESORT", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-32986, 34670, 1372), (0, 0, 0), "escort_a_construction_resort_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-32882, 35972, 1372), (0, 0, 0), "escort_a_construction_resort_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-32042, 34890, 1371.29), (0, 0, 0), "escort_a_construction_resort_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-33094, 33582, 1432), (0, 0, 0), "escort_a_construction_resort_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-34142, 33060, 1471.84), (0, 0, 0), "escort_a_construction_resort_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-31884, 31826, 1408.86), (0, 0, 0), "escort_a_construction_resort_ambush_05", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-32568, 31368, 1388.99), (0, 0, 0), "escort_a_construction_resort_ambush_05", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-32046, 30688, 1376), (0, 0, 0), "escort_a_construction_resort_ambush_06", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-30992, 31188, 1408.52), (0, 0, 0), "escort_a_construction_resort_ambush_06", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-31526, 29792, 1376), (0, 0, 0), "escort_a_construction_resort_ambush_07", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-33208, 35376, 1386), (0, 0, 0), "escort_a_construction_resort_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-31894, 34260, 1396), (0, 0, 0), "escort_a_construction_resort_horde_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-32418, 32496, 1542), (0, 0, 0), "escort_a_construction_resort_horde_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-32952, 29862, 1136), (0, 0, 0), "escort_a_construction_resort_horde_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-33622, 34210, 1386), (0, 0, 0), "escort_a_construction_resort_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-32134, 35434, 1386), (0, 0, 0), "escort_a_construction_resort_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-31254, 34350, 1376.12), (0, 0, 0), "escort_a_construction_resort_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-34190, 33024, 1472.98), (0, 0, 0), "escort_a_construction_resort_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-32634, 33546, 1432), (0, 0, 0), "escort_a_construction_resort_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-32304, 31534, 1405.04), (0, 0, 0), "escort_a_construction_resort_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-31072, 29476, 1388), (0, 0, 0), "escort_a_construction_resort_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-30642, 31252, 1440), (0, 0, 0), "escort_a_construction_resort_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_afe4d7ffe2d8a957(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-31964, 37518, 1444), (0, 0, 0), "ESCORT_ZOMBIES_A_BLOCKS_NORTH", undefined, "escort_a_blocks_north", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-32707, 42326.5, 1530), (0, 158.91, 0), "activity_nexus_instance_joiner", "ESCORT_ZOMBIES_A_BLOCKS_NORTH", "ESCORT_ZOMBIES_A_BLOCKS_NORTH", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-25988, 41218, 1746), (0, 246, 0), "ESCORT_ZOMBIES_A_BLOCKS_NORTH_REWARD", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-32148, 39202, 1485.16), (0, 0, 0), "escort_a_blocks_north_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-31092, 39148, 1538), (0, 0, 0), "escort_a_blocks_north_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-30522, 39520, 1527.91), (0, 0, 0), "escort_a_blocks_north_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-31352, 40456, 1514.75), (0, 0, 0), "escort_a_blocks_north_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-30982, 41312, 1475.69), (0, 0, 0), "escort_a_blocks_north_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-30360, 41160, 1687), (0, 0, 0), "escort_a_blocks_north_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-29216, 40930, 1549.91), (0, 0, 0), "escort_a_blocks_north_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-28940, 41432, 1548.12), (0, 0, 0), "escort_a_blocks_north_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-28248, 42206, 1560), (0, 0, 0), "escort_a_blocks_north_ambush_05", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-28192, 40858, 1596), (0, 0, 0), "escort_a_blocks_north_ambush_05", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-27464, 40678, 1554.36), (0, 0, 0), "escort_a_blocks_north_ambush_06", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-26366, 41676, 1754), (0, 0, 0), "escort_a_blocks_north_ambush_07", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-31672, 40742, 1500), (0, 0, 0), "escort_a_blocks_north_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-30268, 39202, 1538), (0, 0, 0), "escort_a_blocks_north_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-30166, 40492, 1489.71), (0, 0, 0), "escort_a_blocks_north_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-28612, 41102, 1549.91), (0, 0, 0), "escort_a_blocks_north_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-28900, 40326, 1547.57), (0, 0, 0), "escort_a_blocks_north_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-30112, 41948, 1558), (0, 0, 0), "escort_a_blocks_north_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-25892, 42374, 1882), (0, 0, 0), "escort_a_blocks_north_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-26564, 40646, 1690), (0, 0, 0), "escort_a_blocks_north_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-25552, 40764, 1754), (0, 0, 0), "escort_a_blocks_north_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-30206, 41942, 1549.79), (0, 0, 0), "escort_a_blocks_north_horde_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-30108, 39372, 1536), (0, 0, 0), "escort_a_blocks_north_horde_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-25626, 41220, 1746), (0, 0, 0), "escort_a_blocks_north_horde_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-25120, 41366, 1754), (0, 0, 0), "escort_a_blocks_north_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_escort";
  instancestruct.cf = "mp_jup_st_a_ob_contracts_escort_cs";
  instancestruct.scriptstructorigin = (-25806, 27890, 1509.34);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-28510, 28714, 1440), (-25984, 27624, 1442), (-29120, 25370, 1438), (-30100, 23110, 1436)];
  instancestruct.locationoriginoffset = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.locationradius = [1000, 1000, 1000, 1000];
  activityinstances["ESCORT_ZOMBIES_A_BURGERTOWN_PARKING"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_escort";
  instancestruct.cf = "mp_jup_st_a_ob_contracts_escort_cs";
  instancestruct.scriptstructorigin = (-34866, 35722, 1380);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-35022, 35620, 1380), (-32620, 34882, 1372), (-33364, 33454, 1311.29), (-31948, 30656, 1376)];
  instancestruct.locationoriginoffset = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.locationradius = [1000, 1000, 750, 1000];
  activityinstances["ESCORT_ZOMBIES_A_CONSTRUCTION_RESORT"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_escort";
  instancestruct.cf = "mp_jup_st_a_ob_contracts_escort_cs";
  instancestruct.scriptstructorigin = (-32486, 37424, 1452);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-30988, 39720, 1527.91), (-31970, 37372, 1444), (-29188, 41600, 1556), (-26244, 41376, 1746)];
  instancestruct.locationoriginoffset = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.locationradius = [1000, 1000, 1000, 1000];
  activityinstances["ESCORT_ZOMBIES_A_BLOCKS_NORTH"] = instancestruct;
  return activityinstances;
}