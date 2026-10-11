/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_36c8f8a003727b9b.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_e_ob_contracts_zombie_control_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_e_ob_contracts_zombie_control_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_e_ob_contracts_zombie_control_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_e_ob_contracts_zombie_control_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_e_ob_contracts_zombie_control_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_e_ob_contracts_zombie_control_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_e_ob_contracts_zombie_control_cs");
}

function function_fd69cf02ba4d90a2() {
  activityinfostruct = spawnStruct();
  activityinfostruct.name = "REV_OB_ZOMBIE_CONTROL";
  activityinfostruct.scriptbundle = "jup_ob_activitydef_zombiecontrol";
  activityinfostruct.mainfunction = &main;
  activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  activityinfostruct.metadatafunction = &function_6da2952367672ac0;
  return activityinfostruct;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  }

  switch (instancename) {
    case #"hash_6725a312ef928641":
      function_cf905676797ff106(fe, us, cf);
      break;
    case #"hash_3a3ffe9f79b15802":
      function_242b030cf2baeb9(fe, us, cf);
      break;
    case #"hash_54deffd35db94bf9":
      function_c6bb7783200400dc(fe, us, cf);
      break;
    case #"hash_d51febd047c7d03":
      function_5383fbc0cd4b0434(fe, us, cf);
      break;
  }
}

function function_cf905676797ff106(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-3658.92, 2492.85, 2012), (0, 147.03, 0), "control_point_15", "s_zombie_control_e_west", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-2329.04, 4959.16, 2012.16), (0, 147.03, 0), "control_point_11", "s_zombie_control_e_west", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-2204.1, 1139.49, 2008), (0, 147.03, 0), "control_point_1", "s_zombie_control_e_west", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-2028.01, 3392.67, 2012), (0, 147.03, 0), "control_point_2", "s_zombie_control_e_west", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-1786.84, 4048.17, 2008), (0, 147.03, 0), "control_point_3", "s_zombie_control_e_west", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-3899.5, 1889.27, 2012), (0, 147.03, 0), "control_point_4", "s_zombie_control_e_west", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-2757.08, 2545.56, 2014.44), (0, 147.03, 0), "control_point_5", "s_zombie_control_e_west", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-2799.23, 4848.95, 2014), (0, 147.03, 0), "control_point_6", "s_zombie_control_e_west", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-1035.66, 2974.55, 2008), (0, 147.03, 0), "control_point_7", "s_zombie_control_e_west", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-1388.32, 2680.73, 2014), (0, 147.03, 0), "control_point_8", "s_zombie_control_e_west", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-3061.13, 3632.09, 2012), (0, 147.03, 0), "control_point_9", "s_zombie_control_e_west", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-2345.56, 2825.98, 2056), (0, 328, 0), "s_zombie_control_e_west", "s_zombie_control_e_west", "objective_zombie_control_e_west", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-4251.55, 2418.79, 2008), (0, 147.03, 0), "control_point_10", "s_zombie_control_e_west", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-3153.5, 2109.5, 2017), (270, 68.84, 167.55), "c_jup_zmb_zombie_base_charred_male_corpse_pose_13", "s_zombie_control_e_west", "zombie_control_start_interact_soldier_b_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-3295, 2184.5, 1981.25), (358.52, 274.53, -1.13), "c_jup_zmb_zombie_base_charred_male_corpse_pose_08", "s_zombie_control_e_west", "zombie_control_start_interact_soldier_a_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-2330.7, 2832.9, 2051), (0, 272.85, 0), "s_zombie_control_e_west_reward", "s_zombie_control_e_west", "objective_reward_struct", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-3231.75, 2186, 2013), (0, 270.18, 0), "zombie_control_start_interact_inhibitor_model", "s_zombie_control_e_west", "zombie_control_start_interact_inhibitor_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-5542.25, -1511.25, 1754), (0, 324.14, 0), "activity_nexus_instance_joiner", "s_zombie_control_e_west", "ZOMBIE_CONTROL_E_WEST", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-1344.44, 4820.47, 2009.21), (0, 147.03, 0), "control_point_12", "s_zombie_control_e_west", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-2491.6, 2991.7, 2575.75), (0, 282.03, 0), "zombie_control_quest_circle", "s_zombie_control_e_west", "zombie_control_quest_circle", undefined, undefined, (0, 0, 0), (0, 0, 0), 2100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-1672.81, 1843.03, 2008), (0, 147.03, 0), "control_point_13", "s_zombie_control_e_west", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-3001.89, 1712.18, 2012), (0, 147.03, 0), "control_point_14", "s_zombie_control_e_west", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-949.12, 3614.29, 2008), (0, 147.03, 0), "control_point_17", "s_zombie_control_e_west", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_242b030cf2baeb9(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (21519.5, -1638.25, 2154), (0, 225, 0), "control_point_15", "s_zombie_control_e_backstreet", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (21330.5, 231.5, 2151), (0, 225, 0), "control_point_11", "s_zombie_control_e_backstreet", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (20684, -739.5, 2149.5), (0, 225, 0), "control_point_1", "s_zombie_control_e_backstreet", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (20884.5, -299, 2151.5), (0, 225, 0), "control_point_2", "s_zombie_control_e_backstreet", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (20765.5, 481, 2155), (0, 225, 0), "control_point_3", "s_zombie_control_e_backstreet", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (21491.2, -952.5, 2150.17), (0, 225.01, 0), "control_point_5", "s_zombie_control_e_backstreet", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (19994.8, -2418.75, 1992), (0, 225, 0), "control_point_6", "s_zombie_control_e_backstreet", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (20476.8, -1906, 2151), (0, 225, 0), "control_point_8", "s_zombie_control_e_backstreet", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (20673.8, -1178.25, 2151), (0, 225, 0), "control_point_9", "s_zombie_control_e_backstreet", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (22072.4, -1090.53, 2209), (0, 174.16, 0), "s_zombie_control_e_backstreet", undefined, "objective_zombie_control_e_backstreet", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (21029.5, -2029, 2153), (0, 225, 0), "control_point_10", "s_zombie_control_e_backstreet", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (21953.2, -1050.51, 2153), (270, 0, -66.2), "c_jup_zmb_zombie_base_charred_male_corpse_pose_13", "s_zombie_control_e_backstreet", "zombie_control_start_interact_soldier_b_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (22051.2, -999.09, 2114), (0, 260.55, 0), "c_jup_zmb_zombie_base_charred_male_corpse_pose_08", "s_zombie_control_e_backstreet", "zombie_control_start_interact_soldier_a_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (21934.1, -1077, 2158), (0, 122.43, 0), "s_zombie_control_e_backstreet_reward", "s_zombie_control_e_backstreet", "objective_reward_struct", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (22081.8, -1090.09, 2148), (0, 173.48, 0), "zombie_control_start_interact_inhibitor_model", "s_zombie_control_e_backstreet", "zombie_control_start_interact_inhibitor_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (20029, -5654.75, 1883), (0, 164.54, 0), "activity_nexus_instance_joiner", "s_zombie_control_e_backstreet", "ZOMBIE_CONTROL_E_BACKSTREET", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (20368, -120.75, 2156), (0, 225, 0), "control_point_12", "s_zombie_control_e_backstreet", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (21216.5, -874, 2835.5), (0, 0, 0), "zombie_control_quest_circle", "s_zombie_control_e_backstreet", "zombie_control_quest_circle", undefined, undefined, (0, 0, 0), (0, 0, 0), 2000);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (21255.8, -213.25, 2151.5), (0, 225, 0), "control_point_13", "s_zombie_control_e_backstreet", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (21879, -668.75, 2152.5), (0, 225, 0), "control_point_14", "s_zombie_control_e_backstreet", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (21283.5, 1056.5, 2157), (0, 225, 0), "control_point_17", "s_zombie_control_e_backstreet", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_c6bb7783200400dc(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (4037.5, 8408.5, 1445.75), (0, 225, 0), "control_point_15", "s_zombie_control_e_bathhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (3175.75, 10212.2, 1442.75), (0, 225, 0), "control_point_11", "s_zombie_control_e_bathhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (6268, 8832, 1440.75), (0, 225, 0), "control_point_1", "s_zombie_control_e_bathhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (3626.25, 5883, 1623.25), (0, 225, 0), "control_point_2", "s_zombie_control_e_bathhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (2254.25, 10430.5, 1446.75), (0, 225, 0), "control_point_3", "s_zombie_control_e_bathhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (5359.75, 8002.75, 1445.75), (0, 225, 0), "control_point_4", "s_zombie_control_e_bathhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (4418.5, 9649, 1443.25), (0, 225, 0), "control_point_5", "s_zombie_control_e_bathhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (2379.25, 9002.75, 1442.5), (0, 225, 0), "control_point_6", "s_zombie_control_e_bathhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (4767.5, 11225, 1441.75), (0, 225, 0), "control_point_7", "s_zombie_control_e_bathhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (1843.25, 8534, 1628.75), (0, 225, 0), "control_point_8", "s_zombie_control_e_bathhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (3361, 8911.25, 1442), (0, 225, 0), "control_point_9", "s_zombie_control_e_bathhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (5489.03, 6668.34, 1504.75), (0, 315.52, 0), "s_zombie_control_e_bathhouse", "s_zombie_control_e_bathhouse", "objective_zombie_control_e_bathhouse", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (4439.75, 7088, 1441.25), (0, 225, 0), "control_point_10", "s_zombie_control_e_bathhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (5551.11, 6655.23, 1448.75), (270, 0, -112.87), "c_jup_zmb_zombie_base_charred_male_corpse_pose_13", "s_zombie_control_e_bathhouse", "zombie_control_start_interact_soldier_b_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (5437.74, 6631.09, 1411), (0, 319.21, 0), "c_jup_zmb_zombie_base_charred_male_corpse_pose_08", "s_zombie_control_e_bathhouse", "zombie_control_start_interact_soldier_a_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (4537.55, 10203.8, 1455.5), (0, 350.82, 0), "s_zombie_control_e_bathhouse_reward", "s_zombie_control_e_bathhouse", "objective_reward_struct", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (5481.4, 6673.86, 1443.75), (0, 314.85, 0), "zombie_control_start_interact_inhibitor_model", "s_zombie_control_e_bathhouse", "zombie_control_start_interact_inhibitor_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (7694.25, 1314.25, 1658), (0, 83.82, 0), "activity_nexus_instance_joiner", "s_zombie_control_e_bathhouse", "ZOMBIE_CONTROL_E_BATHHOUSE", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (3759.75, 10648.5, 1448.75), (0, 225, 0), "control_point_12", "s_zombie_control_e_bathhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (3852.25, 8603.5, 1534.75), (0, 0, 0), "zombie_control_quest_circle", "s_zombie_control_e_bathhouse", "zombie_control_quest_circle", undefined, undefined, (0, 0, 0), (0, 0, 0), 2900);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (5494.25, 10313, 1443.25), (0, 225, 0), "control_point_13", "s_zombie_control_e_bathhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (5534, 8886.5, 1445.75), (0, 225, 0), "control_point_14", "s_zombie_control_e_bathhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (4380.5, 6475.25, 1444), (0, 225, 0), "control_point_17", "s_zombie_control_e_bathhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_5383fbc0cd4b0434(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (13472.8, 345.47, 1767.73), (0, 216.94, 0), "control_point_15", "s_zombie_control_e_east", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (11217.2, 2143.27, 1793.57), (0, 216.94, 0), "control_point_11", "s_zombie_control_e_east", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (14933.3, 1067.12, 1758.11), (0, 216.94, 0), "control_point_1", "s_zombie_control_e_east", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (12932, 1933.68, 1627), (0, 216.94, 0), "control_point_2", "s_zombie_control_e_east", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (12573.8, 3219.56, 1952), (0, 216.94, 0), "control_point_3", "s_zombie_control_e_east", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (13646.9, -267.69, 1629.49), (0, 216.94, 0), "control_point_4", "s_zombie_control_e_east", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (13168.3, 1205.15, 1626), (0, 216.94, 0), "control_point_5", "s_zombie_control_e_east", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (11533.2, 1571.28, 1752), (0, 216.94, 0), "control_point_6", "s_zombie_control_e_east", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (13611.1, 2794.68, 1736.08), (0, 216.94, 0), "control_point_7", "s_zombie_control_e_east", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (13709.8, 2044.5, 1659), (0, 216.94, 0), "control_point_8", "s_zombie_control_e_east", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (12224.4, 1062.58, 1627.28), (0, 216.94, 0), "control_point_9", "s_zombie_control_e_east", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (13300.8, 1513.42, 1685.5), (0, 37.91, 0), "s_zombie_control_e_east", "s_zombie_control_e_east", "objective_zombie_control_e_east", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (12897.4, -570.26, 1716.01), (0, 216.94, 0), "control_point_10", "s_zombie_control_e_east", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (13264.2, 2527, 1672.75), (270, 130.99, -142.36), "c_jup_zmb_zombie_base_charred_male_corpse_pose_13", "s_zombie_control_e_east", "zombie_control_start_interact_soldier_b_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (13246.8, 2395, 1633), (359.98, 36.3, -1.87), "c_jup_zmb_zombie_base_charred_male_corpse_pose_08", "s_zombie_control_e_east", "zombie_control_start_interact_soldier_a_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (13299.4, 1529.75, 1633.5), (0, 342.76, 0), "s_zombie_control_e_east_reward", "s_zombie_control_e_east", "objective_reward_struct", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (13214.5, 2448.5, 1661.5), (0, 33.01, 0), "zombie_control_start_interact_inhibitor_model", "s_zombie_control_e_east", "zombie_control_start_interact_inhibitor_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (15265.5, 4964.75, 2262.25), (0, 166.86, 0), "activity_nexus_instance_joiner", "s_zombie_control_e_east", "ZOMBIE_CONTROL_E_EAST", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (11908.2, 2956.53, 1952), (0, 216.94, 0), "control_point_12", "s_zombie_control_e_east", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (13095, 1433.17, 2305.25), (0, 351.94, 0), "zombie_control_quest_circle", "s_zombie_control_e_east", "zombie_control_quest_circle", undefined, undefined, (0, 0, 0), (0, 0, 0), 2100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (14455, 1807.7, 1741.11), (0, 216.94, 0), "control_point_13", "s_zombie_control_e_east", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (13959.4, 324.62, 1690.39), (0, 216.94, 0), "control_point_14", "s_zombie_control_e_east", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (13003.4, 3462.26, 1928.07), (0, 216.94, 0), "control_point_17", "s_zombie_control_e_east", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydef_zombiecontrol";
  instancestruct.cf = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  instancestruct.scriptstructorigin = (-2357.5, 2840.03, 2040);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-2501.73, 2962.44, 2099.25)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2100];
  activityinstances["ZOMBIE_CONTROL_E_WEST"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydef_zombiecontrol";
  instancestruct.cf = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  instancestruct.scriptstructorigin = (22089.3, -1097.88, 2293);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(21298, -991, 2429)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2100];
  activityinstances["ZOMBIE_CONTROL_E_BACKSTREET"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydef_zombiecontrol";
  instancestruct.cf = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  instancestruct.scriptstructorigin = (5480.41, 6684.64, 1575.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(3877.75, 8587.5, 1598)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2900];
  activityinstances["ZOMBIE_CONTROL_E_BATHHOUSE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydef_zombiecontrol";
  instancestruct.cf = "mp_jup_st_e_ob_contracts_zombie_control_cs";
  instancestruct.scriptstructorigin = (13283.5, 1507.03, 1769.5);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(13119, 1413.61, 1898.75)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2100];
  activityinstances["ZOMBIE_CONTROL_E_EAST"] = instancestruct;
  return activityinstances;
}