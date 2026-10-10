/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_57a810c48ebc699b.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_a_ob_contracts_zombie_control_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_a_ob_contracts_zombie_control_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_a_ob_contracts_zombie_control_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_a_ob_contracts_zombie_control_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_a_ob_contracts_zombie_control_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_a_ob_contracts_zombie_control_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_a_ob_contracts_zombie_control_cs");
}

function function_fd69cf02ba4d90a2() {
  var_d13c18af4084bdfd = spawnStruct();
  var_d13c18af4084bdfd.name = "REV_OB_ZOMBIE_CONTROL";
  var_d13c18af4084bdfd.scriptbundle = "jup_ob_activitydef_zombiecontrol";
  var_d13c18af4084bdfd.mainfunction = &main;
  var_d13c18af4084bdfd.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  var_d13c18af4084bdfd.var_ad1dcd56d202e9ac = &function_6da2952367672ac0;
  return var_d13c18af4084bdfd;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  }

  switch (instancename) {
    case #"hash_d8db8b957ec6dd70":
      function_5861d3756e3eb179(fe, us, cf);
      break;
    case #"hash_adb8e7f08f2c88ea":
      function_3a2e90154c9bf3fd(fe, us, cf);
      break;
    case #"hash_c33dc7590255e65":
      function_5478d1fb037ec7ca(fe, us, cf);
      break;
  }
}

function function_5861d3756e3eb179(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-30806.2, 25366.4, 1374.75), (0, 225, 0), "control_point_1", "s_zombie_control_a_hotel", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-30000.7, 27126.4, 1375), (0, 225, 0), "control_point_15", "s_zombie_control_a_hotel", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-31944.4, 24780.8, 1375), (0, 225, 0), "control_point_11", "s_zombie_control_a_hotel", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-31468.6, 25234.8, 1374.75), (0, 225, 0), "control_point_2", "s_zombie_control_a_hotel", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-32378.6, 26987.1, 1376.5), (0, 225, 0), "control_point_4", "s_zombie_control_a_hotel", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-30503.6, 26044.7, 1374), (0, 225, 0), "control_point_5", "s_zombie_control_a_hotel", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-31316.3, 27581.7, 1377), (0, 225, 0), "control_point_6", "s_zombie_control_a_hotel", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-33590.4, 26389, 1375.75), (0, 225, 0), "control_point_7", "s_zombie_control_a_hotel", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-28389.8, 26699.2, 1375), (0, 225, 0), "control_point_8", "s_zombie_control_a_hotel", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-28985.6, 26145.1, 1436), (0, 118.6, 0), "s_zombie_control_a_hotel", "s_zombie_control_a_hotel", "objective_zombie_control_a_hotel", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-28988.8, 26149, 1411), (0, 118.6, 0), "zombie_control_start_interact", "s_zombie_control_a_hotel", "zombie_control_start_interact", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-31613.7, 26138.9, 1374.5), (0, 225, 0), "control_point_10", "s_zombie_control_a_hotel", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-29045.5, 26182.8, 1381), (270, 201.1, -76.1), "c_jup_zmb_zombie_base_charred_male_corpse_pose_13", "s_zombie_control_a_hotel", "zombie_control_start_interact_soldier_b_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-28945.3, 26155.2, 1343), (0, 125.2, 0), "c_jup_zmb_zombie_base_charred_male_corpse_pose_08", "s_zombie_control_a_hotel", "zombie_control_start_interact_soldier_a_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-29047, 26257, 1384), (0, 275.51, 0), "s_zombie_control_a_hotel_reward", "s_zombie_control_a_hotel", "objective_reward_struct", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-28980, 26137.6, 1375.5), (0, 117.93, 0), "zombie_control_start_interact_inhibitor_model", "s_zombie_control_a_hotel", "zombie_control_start_interact_inhibitor_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-31409.4, 20762.7, 1167.75), (0, 91.84, 0), "activity_nexus_instance_joiner", "s_zombie_control_a_hotel", "ZOMBIE_CONTROL_A_HOTEL", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-28862.8, 27744.9, 1375.25), (0, 225, 0), "control_point_12", "s_zombie_control_a_hotel", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-30881.2, 26866.7, 1461.75), (0, 0, 0), "zombie_control_quest_circle", "s_zombie_control_a_hotel", "zombie_control_quest_circle", undefined, undefined, (0, 0, 0), (0, 0, 0), 3000);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-32846.4, 25631.1, 1373.5), (0, 225, 0), "control_point_13", "s_zombie_control_a_hotel", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-29545.9, 28872.8, 1375.25), (0, 225, 0), "control_point_14", "s_zombie_control_a_hotel", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-30848.3, 26680.5, 1374.75), (0, 225, 0), "control_point_17", "s_zombie_control_a_hotel", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_3a2e90154c9bf3fd(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-25842.4, 40366.1, 1687.5), (0, 225, 0), "control_point_1", "s_zombie_control_a_statue", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-24813.4, 42286.6, 2010), (0, 225, 0), "control_point_15", "s_zombie_control_a_statue", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-26994.7, 40160.3, 1559), (0, 225, 0), "control_point_11", "s_zombie_control_a_statue", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-26138.8, 39789.3, 1558.5), (0, 225, 0), "control_point_2", "s_zombie_control_a_statue", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-26459.8, 41831.6, 1752.75), (0, 225, 0), "control_point_4", "s_zombie_control_a_statue", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-25518.8, 40851.4, 1752.5), (0, 225, 0), "control_point_5", "s_zombie_control_a_statue", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-25935.6, 42849.2, 2008.5), (0, 225, 0), "control_point_6", "s_zombie_control_a_statue", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-25232.7, 42795, 2056.75), (0, 225, 0), "control_point_7", "s_zombie_control_a_statue", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-25059.3, 41275.4, 1753), (0, 225, 0), "control_point_8", "s_zombie_control_a_statue", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-26234.1, 39514.3, 1620.75), (0, 246.66, 0), "s_zombie_control_a_statue", "s_zombie_control_a_statue", "objective_zombie_control_a_statue", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-26235.2, 39509.4, 1595.75), (0, 246.66, 0), "zombie_control_start_interact", "s_zombie_control_a_statue", "zombie_control_start_interact", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-26642.4, 41330.9, 1755), (0, 225, 0), "control_point_10", "s_zombie_control_a_statue", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-26286.8, 39482.1, 1566.25), (270, 275.74, -0), "c_jup_zmb_zombie_base_charred_male_corpse_pose_13", "s_zombie_control_a_statue", "zombie_control_start_interact_soldier_b_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-26312.8, 39567, 1529.25), (0, 247.35, 0), "c_jup_zmb_zombie_base_charred_male_corpse_pose_08", "s_zombie_control_a_statue", "zombie_control_start_interact_soldier_a_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-26284.4, 39397, 1559.5), (0, 43.57, 0), "s_zombie_control_a_statue_reward", "s_zombie_control_a_statue", "objective_reward_struct", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-26231.7, 39523.4, 1560.75), (0, 245.99, 0), "zombie_control_start_interact_inhibitor_model", "s_zombie_control_a_statue", "zombie_control_start_interact_inhibitor_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-28650.4, 33025.4, 1424.25), (0, 20.52, 0), "activity_nexus_instance_joiner", "s_zombie_control_a_statue", "ZOMBIE_CONTROL_A_STATUE", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-24802.8, 41811.6, 1880.75), (0, 225, 0), "control_point_12", "s_zombie_control_a_statue", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-25607.9, 41673.4, 2026), (0, 0, 0), "zombie_control_quest_circle", "s_zombie_control_a_statue", "zombie_control_quest_circle", undefined, undefined, (0, 0, 0), (0, 0, 0), 2500);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-26748.6, 40799.6, 1694.75), (0, 225, 0), "control_point_13", "s_zombie_control_a_statue", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-25360.4, 43312.3, 2058), (0, 225, 0), "control_point_14", "s_zombie_control_a_statue", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-24374.6, 43155.8, 2008.5), (0, 225, 0), "control_point_17", "s_zombie_control_a_statue", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_5478d1fb037ec7ca(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-15495.9, 27089.6, 3063.34), (0, 294.26, 0), "control_point_1", "s_zombie_control_a_legacy", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-16750.2, 28446.3, 3047.31), (0, 294.26, 0), "control_point_15", "s_zombie_control_a_legacy", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-15272.7, 25643.8, 3063.44), (0, 294.26, 0), "control_point_11", "s_zombie_control_a_legacy", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-15093.1, 26429, 3063.44), (0, 294.26, 0), "control_point_2", "s_zombie_control_a_legacy", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-17661.8, 26400.1, 3011.95), (0, 294.26, 0), "control_point_4", "s_zombie_control_a_legacy", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-15767.6, 28265.5, 3065.11), (0, 294.26, 0), "control_point_5", "s_zombie_control_a_legacy", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-17561.5, 27274.9, 3059.42), (0, 294.26, 0), "control_point_6", "s_zombie_control_a_legacy", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-17081.8, 26122.1, 2949.99), (0, 294.26, 0), "control_point_7", "s_zombie_control_a_legacy", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-16053.6, 29824.9, 3047.41), (0, 294.26, 0), "control_point_8", "s_zombie_control_a_legacy", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-15867, 29108.5, 3109.75), (0, 187.87, 0), "s_zombie_control_a_legacy", "s_zombie_control_a_legacy", "objective_zombie_control_a_legacy", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-15852.8, 29109.6, 3084.75), (0, 187.87, 0), "zombie_control_start_interact", "s_zombie_control_a_legacy", "zombie_control_start_interact", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-16538.3, 26683.4, 3060.53), (0, 294.26, 0), "control_point_10", "s_zombie_control_a_legacy", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-15407.8, 29429.1, 3066.75), (270, 0, -165.74), "c_jup_zmb_zombie_base_charred_male_corpse_pose_13", "s_zombie_control_a_legacy", "zombie_control_start_interact_soldier_b_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-15580.5, 29358.5, 3029), (0, 99.21, 0), "c_jup_zmb_zombie_base_charred_male_corpse_pose_08", "s_zombie_control_a_legacy", "zombie_control_start_interact_soldier_a_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-15862.2, 29158.9, 3092.75), (0, 344.78, 0), "s_zombie_control_a_hotel_reward", "s_zombie_control_a_legacy", "objective_reward_struct", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-15470, 29347.6, 3061.81), (0, 95.16, 0), "zombie_control_start_interact_inhibitor_model", "s_zombie_control_a_legacy", "zombie_control_start_interact_inhibitor_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-16548.5, 34414.8, 2698.75), (0, 330.18, 0), "activity_nexus_instance_joiner", "s_zombie_control_a_legacy", "ZOMBIE_CONTROL_A_LEGACY", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-16937.7, 29863.2, 2810.01), (0, 294.26, 0), "control_point_12", "s_zombie_control_a_legacy", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-16959.6, 27626.2, 3135.5), (0, 69.26, 0), "zombie_control_quest_circle", "s_zombie_control_a_legacy", "zombie_control_quest_circle", undefined, undefined, (0, 0, 0), (0, 0, 0), 3000);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-15224.3, 29916.5, 3061.81), (0, 294.26, 0), "control_point_13", "s_zombie_control_a_legacy", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-18536.2, 29377.2, 2998.59), (0, 294.26, 0), "control_point_14", "s_zombie_control_a_legacy", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-16885.3, 27427.5, 3064.92), (0, 294.26, 0), "control_point_17", "s_zombie_control_a_legacy", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydef_zombiecontrol";
  instancestruct.cf = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  instancestruct.scriptstructorigin = (-28982, 26126.9, 1520);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-30963.7, 26992.4, 1483.75)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [3000];
  activityinstances["ZOMBIE_CONTROL_A_HOTEL"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydef_zombiecontrol";
  instancestruct.cf = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  instancestruct.scriptstructorigin = (-26222, 39528.4, 1704.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-25607.2, 41678.4, 2069.5)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2500];
  activityinstances["ZOMBIE_CONTROL_A_STATUE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydef_zombiecontrol";
  instancestruct.cf = "mp_jup_st_a_ob_contracts_zombie_control_cs";
  instancestruct.scriptstructorigin = (-15595.2, 29140.4, 3193.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-17106.3, 27593.5, 3157.5)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [3000];
  activityinstances["ZOMBIE_CONTROL_A_LEGACY"] = instancestruct;
  return activityinstances;
}