/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4be5c1bb1c2ac04b.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_b_ob_contracts_zombie_control_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_b_ob_contracts_zombie_control_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_b_ob_contracts_zombie_control_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_b_ob_contracts_zombie_control_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_b_ob_contracts_zombie_control_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_b_ob_contracts_zombie_control_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_b_ob_contracts_zombie_control_cs");
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
    cf = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  }

  switch (instancename) {
    case #"hash_a9b68dd3fa9bcfe5":
      function_ed9113c03966f330(fe, us, cf);
      break;
    case #"hash_d1e484287db9ab20":
      function_5c15a1ff3ea8db03(fe, us, cf);
      break;
  }
}

function function_ed9113c03966f330(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (3121.75, 21762, 949), (0, 225, 0), "control_point_11", "s_zombie_control_b_nuclear", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (3055, 20772.5, 963.5), (0, 225, 0), "control_point_1", "s_zombie_control_b_nuclear", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (4983, 20613.5, 930.5), (0, 225, 0), "control_point_2", "s_zombie_control_b_nuclear", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (3606, 21666.5, 901.5), (0, 225, 0), "control_point_3", "s_zombie_control_b_nuclear", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (3677, 19530.5, 953.5), (0, 225, 0), "control_point_4", "s_zombie_control_b_nuclear", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (4972.75, 19226.8, 956.5), (0, 225, 0), "control_point_5", "s_zombie_control_b_nuclear", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (4361.75, 19586.5, 953.75), (0, 225, 0), "control_point_6", "s_zombie_control_b_nuclear", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (4646, 21605.5, 901.5), (0, 225, 0), "control_point_7", "s_zombie_control_b_nuclear", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (4480, 20342.5, 929.5), (0, 225, 0), "control_point_8", "s_zombie_control_b_nuclear", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (2864, 19722.5, 997.5), (0, 225, 0), "control_point_9", "s_zombie_control_b_nuclear", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (4648.17, 21044.9, 958.75), (0, 147.71, 0), "s_zombie_control_b_nuclear", "s_zombie_control_b_nuclear", "objective_zombie_control_b_nuclear", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (5562.5, 19976, 1002.25), (0, 225, 0), "control_point_10", "s_zombie_control_b_nuclear", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (4517.19, 21067.8, 902.75), (270, 0, 167.4), "c_jup_zmb_zombie_base_charred_male_corpse_pose_08", "s_zombie_control_b_nuclear", "zombie_control_start_interact_soldier_b_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (4683.31, 20984.9, 864.75), (0, 244.8, 0), "c_jup_zmb_zombie_base_charred_male_corpse_pose_08", "s_zombie_control_b_nuclear", "zombie_control_start_interact_soldier_a_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (4535.65, 21111.4, 906.5), (0, 76.27, 0), "s_zombie_control_test_reward", "s_zombie_control_b_nuclear", "objective_reward_struct", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (4656.81, 21041.1, 897.75), (0, 147.04, 0), "zombie_control_start_interact_inhibitor_model", "s_zombie_control_b_nuclear", "zombie_control_start_interact_inhibitor_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (8646.25, 21827.2, 1048), (0, 345.34, 0), "activity_nexus_instance_joiner", "s_zombie_control_b_nuclear", "ZOMBIE_CONTROL_B_NUCLEAR", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (3973, 21934.5, 896.5), (0, 225, 0), "control_point_12", "s_zombie_control_b_nuclear", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (4267.5, 20243, 1660), (0, 0, 0), "zombie_control_quest_circle", "s_zombie_control_b_nuclear", "zombie_control_quest_circle", undefined, undefined, (0, 0, 0), (0, 0, 0), 2100);
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (3739, 20406.5, 928.5), (0, 225, 0), "control_point_13", "s_zombie_control_b_nuclear", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (5295, 21283.5, 950.5), (0, 225, 0), "control_point_14", "s_zombie_control_b_nuclear", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_5c15a1ff3ea8db03(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-9219.75, 36837, 1329.25), (0, 225, 0), "control_point_11", "s_zombie_control_b_construction", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-8472.5, 36980.5, 1341.75), (0, 225, 0), "control_point_1", "s_zombie_control_b_construction", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-7463.75, 36889.8, 1345.75), (0, 225, 0), "control_point_2", "s_zombie_control_b_construction", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-7904, 36993.5, 1363.5), (0, 225, 0), "control_point_3", "s_zombie_control_b_construction", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-8000, 35449.5, 1249.5), (0, 225, 0), "control_point_4", "s_zombie_control_b_construction", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-6046, 36281.5, 1345.5), (0, 225, 0), "control_point_5", "s_zombie_control_b_construction", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-7404, 35305.5, 1244.5), (0, 225, 0), "control_point_6", "s_zombie_control_b_construction", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-6213.5, 37669.5, 1361.75), (0, 225, 0), "control_point_7", "s_zombie_control_b_construction", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-7469, 36195, 1329.5), (0, 225, 0), "control_point_8", "s_zombie_control_b_construction", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-8648.25, 35838, 1281.5), (0, 225, 0), "control_point_9", "s_zombie_control_b_construction", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-8619.29, 36225.3, 1442.5), (0, 0.57, 0), "s_zombie_control_b_construction", "s_zombie_control_b_construction", "objective_zombie_control_b_construction", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-8614.34, 36226, 1417.5), (0, 0.57, 0), "zombie_control_start_interact", "s_zombie_control_b_construction", "zombie_control_start_interact", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-6291, 35587.5, 1297.5), (0, 225, 0), "control_point_10", "s_zombie_control_b_construction", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-8491.31, 36196.1, 1388), (270, 0, 54.9), "c_jup_zmb_zombie_base_charred_male_corpse_pose_13", "s_zombie_control_b_construction", "zombie_control_start_interact_soldier_b_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-8634.8, 36314.5, 1343.5), (356.5, 96.75, -7.01), "c_jup_zmb_zombie_base_charred_male_corpse_pose_08", "s_zombie_control_b_construction", "zombie_control_start_interact_soldier_a_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-8466.1, 36224.4, 1394.5), (0, 76.27, 0), "s_zombie_control_test_reward", "s_zombie_control_b_construction", "objective_reward_struct", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-8628.59, 36223.7, 1381.5), (0, 359.9, 0), "zombie_control_start_interact_inhibitor_model", "s_zombie_control_b_construction", "zombie_control_start_interact_inhibitor_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-346.25, 34363.8, 1236), (0, 353.66, 0), "activity_nexus_instance_joiner", "s_zombie_control_b_construction", "ZOMBIE_CONTROL_B_CONSTRUCTION", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-7486.5, 37318.8, 1352.25), (0, 225, 0), "control_point_12", "s_zombie_control_b_construction", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-7471.5, 36401, 2070), (0, 0, 0), "zombie_control_quest_circle", "s_zombie_control_b_construction", "zombie_control_quest_circle", undefined, undefined, (0, 0, 0), (0, 0, 0), 2000);
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-9476.25, 35928.8, 1277.25), (0, 225, 0), "control_point_13", "s_zombie_control_b_construction", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-6640.75, 37054.2, 1343.5), (0, 225, 0), "control_point_14", "s_zombie_control_b_construction", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydef_zombiecontrol";
  instancestruct.cf = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  instancestruct.scriptstructorigin = (4660.12, 21030.7, 1042.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(4091.75, 20388.2, 1253.5)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2100];
  activityinstances["ZOMBIE_CONTROL_B_NUCLEAR"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydef_zombiecontrol";
  instancestruct.cf = "mp_jup_st_b_ob_contracts_zombie_control_cs";
  instancestruct.scriptstructorigin = (-8637.02, 36230.7, 1526.5);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-7634.5, 36338, 1663.5)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2100];
  activityinstances["ZOMBIE_CONTROL_B_CONSTRUCTION"] = instancestruct;
  return activityinstances;
}