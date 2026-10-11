/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_54e16cf31175fff7.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_g_ob_contracts_zombie_control_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_g_ob_contracts_zombie_control_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_g_ob_contracts_zombie_control_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_g_ob_contracts_zombie_control_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_g_ob_contracts_zombie_control_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_g_ob_contracts_zombie_control_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_g_ob_contracts_zombie_control_cs");
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
    cf = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  }

  switch (instancename) {
    case #"hash_294e9c855ac31b9e":
      function_3f02c4b698147735(fe, us, cf);
      break;
    case #"hash_7a89a58311d2235":
      function_212d208b08493a24(fe, us, cf);
      break;
    case #"hash_bd749ac9a381da87":
      function_15abef189cb7c18e(fe, us, cf);
      break;
    case #"hash_f4cc722265ce1b4c":
      function_7fee1a8010f832d5(fe, us, cf);
      break;
    case #"hash_14661ddab883a246":
      function_2c0db2cbb9c88c69(fe, us, cf);
      break;
    case #"hash_13bafd29dccf1131":
      function_df8244d449587254(fe, us, cf);
      break;
  }
}

function function_3f02c4b698147735(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-27259.1, -24170.4, 1701.25), (0, 225, 0), "control_point_1", "s_zombie_control_g_shipping", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-25867.3, -21506.6, 1701.5), (0, 225, 0), "control_point_15", "s_zombie_control_g_shipping", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-26995.8, -22954.5, 1699.75), (0, 225, 0), "control_point_11", "s_zombie_control_g_shipping", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-24162.3, -25107.6, 1698.5), (0, 225, 0), "control_point_2", "s_zombie_control_g_shipping", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-24250.3, -22798.8, 1700.25), (0, 225, 0), "control_point_4", "s_zombie_control_g_shipping", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-27552.3, -22562.1, 1699.75), (0, 225, 0), "control_point_5", "s_zombie_control_g_shipping", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-26823.8, -24666.6, 1714.25), (0, 225, 0), "control_point_6", "s_zombie_control_g_shipping", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-25136.6, -24703.3, 1701.75), (0, 225, 0), "control_point_7", "s_zombie_control_g_shipping", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-25999.3, -24777.1, 1702.25), (0, 225, 0), "control_point_8", "s_zombie_control_g_shipping", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-26938.4, -21855, 1757.75), (0, 77.11, 0), "s_zombie_control_g_shipping", "s_zombie_control_g_shipping", "objective_zombie_control_g_shipping", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-24113.6, -21611.1, 1698.25), (0, 225, 0), "control_point_10", "s_zombie_control_g_shipping", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-26891.6, -21910.8, 1703.25), (270, 0, 90.7), "c_jup_zmb_zombie_base_charred_male_corpse_pose_13", "s_zombie_control_g_shipping", "zombie_control_start_interact_soldier_b_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-26985.1, -21790.1, 1664.25), (0, 349.7, 0), "c_jup_zmb_zombie_base_charred_male_corpse_pose_08", "s_zombie_control_g_shipping", "zombie_control_start_interact_soldier_a_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-26910.3, -21730.5, 1706.25), (0, 234.01, 0), "s_zombie_control_g_shipping_reward", "s_zombie_control_g_shipping", "objective_reward_struct", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-26938.8, -21863.4, 1697.25), (0, 76.43, 0), "zombie_control_start_interact_inhibitor_model", "s_zombie_control_g_shipping", "zombie_control_start_interact_inhibitor_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  s.name = "script_struct_nexus_activity_joiner";
  fe[[f]](s, us, cf, (-31561.1, -22242.3, 1304), (0, 131.37, 0), "activity_nexus_instance_joiner", "s_zombie_control_g_shipping", "ZOMBIE_CONTROL_G_SHIPPING", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-24508.6, -22167.6, 1700.5), (0, 225, 0), "control_point_12", "s_zombie_control_g_shipping", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-25944.8, -23328.3, 2358.75), (0, 0, 0), "zombie_control_quest_circle", "s_zombie_control_g_shipping", "zombie_control_quest_circle", undefined, undefined, (0, 0, 0), (0, 0, 0), 2500);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-24741.3, -23597.2, 1701.5), (0, 225, 0), "control_point_13", "s_zombie_control_g_shipping", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-27862.3, -24240.2, 1699), (0, 225, 0), "control_point_14", "s_zombie_control_g_shipping", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-27917.6, -21128.1, 1703), (0, 225, 0), "control_point_17", "s_zombie_control_g_shipping", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_212d208b08493a24(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-8306.35, -13588.5, 1706.5), (0, 225, 0), "control_point_1", "s_zombie_control_g_block", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-7690.35, -12680.8, 1828.75), (0, 225, 0), "control_point_15", "s_zombie_control_g_block", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-8374.3, -12141.5, 1679), (0, 225, 0), "control_point_11", "s_zombie_control_g_block", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-6724.3, -13574.8, 1834), (0, 225, 0), "control_point_2", "s_zombie_control_g_block", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-5769.55, -14372.8, 1697.5), (0, 225, 0), "control_point_4", "s_zombie_control_g_block", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-9133.55, -12881.3, 1712.5), (0, 225, 0), "control_point_5", "s_zombie_control_g_block", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-7788.55, -13949.3, 1713.25), (0, 225, 0), "control_point_6", "s_zombie_control_g_block", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-6562.1, -14640.3, 1707.5), (0, 225, 0), "control_point_7", "s_zombie_control_g_block", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-7348.05, -14759.8, 1711), (0, 225, 0), "control_point_8", "s_zombie_control_g_block", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-7831.08, -15114.6, 1767.75), (0, 182.37, 0), "s_zombie_control_g_block", "s_zombie_control_g_block", "objective_zombie_control_g_block", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-6535.85, -13109.6, 1825.75), (0, 225, 0), "control_point_10", "s_zombie_control_g_block", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-7838.23, -15228.9, 1715.25), (270, 0, -91), "c_jup_zmb_zombie_base_charred_male_corpse_pose_13", "s_zombie_control_g_block", "zombie_control_start_interact_soldier_b_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-7796.1, -15035.8, 1677.5), (0, 137.27, 0), "c_jup_zmb_zombie_base_charred_male_corpse_pose_08", "s_zombie_control_g_block", "zombie_control_start_interact_soldier_a_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-7958.58, -15120.3, 1719), (0, 339.28, 0), "s_zombie_control_g_block_reward", "s_zombie_control_g_block", "objective_reward_struct", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-7821.83, -15112.8, 1709.5), (0, 181.7, 0), "zombie_control_start_interact_inhibitor_model", "s_zombie_control_g_block", "zombie_control_start_interact_inhibitor_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  s.name = "script_struct_nexus_activity_joiner";
  fe[[f]](s, us, cf, (-9234.85, -19691.1, 1748), (0, 323.77, 0), "activity_nexus_instance_joiner", "s_zombie_control_g_block", "ZOMBIE_CONTROL_G_BLOCK", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-7840.1, -11402.8, 1672.5), (0, 225, 0), "control_point_12", "s_zombie_control_g_block", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-7244.85, -13287.8, 2219), (0, 0, 0), "zombie_control_quest_circle", "s_zombie_control_g_block", "zombie_control_quest_circle", undefined, undefined, (0, 0, 0), (0, 0, 0), 2300);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-7360.8, -13743.3, 1828.5), (0, 225, 0), "control_point_13", "s_zombie_control_g_block", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-8956.3, -13941.2, 1705.75), (0, 225, 0), "control_point_14", "s_zombie_control_g_block", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-5902.55, -13668.8, 1740.75), (0, 225, 0), "control_point_17", "s_zombie_control_g_block", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_15abef189cb7c18e(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-28884.1, -36721.4, 3132.25), (0, 225, 0), "control_point_1", "s_zombie_control_g_radio", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-26656.6, -33919.1, 2471.75), (0, 225, 0), "control_point_15", "s_zombie_control_g_radio", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-29308.8, -38534.5, 3219.75), (0, 225, 0), "control_point_11", "s_zombie_control_g_radio", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-25813.3, -36800.6, 2697.5), (0, 225, 0), "control_point_2", "s_zombie_control_g_radio", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-27967.8, -37091.6, 3174.25), (0, 225, 0), "control_point_6", "s_zombie_control_g_radio", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-26162.6, -38667.3, 2825.75), (0, 225, 0), "control_point_7", "s_zombie_control_g_radio", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-29251.3, -37256.1, 2938.25), (0, 225, 0), "control_point_8", "s_zombie_control_g_radio", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-27485.5, -36142.5, 3154.75), (0, 72.51, 0), "s_zombie_control_g_radio", "s_zombie_control_g_radio", "objective_zombie_control_g_radio", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-25500.6, -35297.1, 2647.25), (0, 225, 0), "control_point_10", "s_zombie_control_g_radio", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-27615.6, -36018.8, 3083.25), (270, 0, 144.7), "c_jup_zmb_zombie_base_charred_male_corpse_pose_13", "s_zombie_control_g_radio", "zombie_control_start_interact_soldier_b_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-27538.1, -36134.1, 3061.25), (0, 69.7, 0), "c_jup_zmb_zombie_base_charred_male_corpse_pose_08", "s_zombie_control_g_radio", "zombie_control_start_interact_soldier_a_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-27445.3, -36008.5, 3079.25), (0, 234.01, 0), "s_zombie_control_g_radio_reward", "s_zombie_control_g_radio", "objective_reward_struct", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-27486.5, -36150.9, 3094.25), (0, 71.83, 0), "zombie_control_start_interact_inhibitor_model", "s_zombie_control_g_radio", "zombie_control_start_interact_inhibitor_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  s.name = "script_struct_nexus_activity_joiner";
  fe[[f]](s, us, cf, (-21496.4, -30036.8, 1985.75), (0, 185.84, 0), "activity_nexus_instance_joiner", "s_zombie_control_g_radio", "ZOMBIE_CONTROL_G_RADIO", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-25920.6, -34485.6, 2487.5), (0, 225, 0), "control_point_12", "s_zombie_control_g_radio", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-27905.8, -36428.3, 2985.75), (0, 0, 0), "zombie_control_quest_circle", "s_zombie_control_g_radio", "zombie_control_quest_circle", undefined, undefined, (0, 0, 0), (0, 0, 0), 2900);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-26990.3, -35568.2, 2976.5), (0, 225, 0), "control_point_13", "s_zombie_control_g_radio", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-30361.3, -37587.2, 3217), (0, 225, 0), "control_point_14", "s_zombie_control_g_radio", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-27671.6, -38274.1, 3268), (0, 225, 0), "control_point_17", "s_zombie_control_g_radio", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_7fee1a8010f832d5(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-19609.3, -30846.9, 1876.5), (0, 225, 0), "control_point_1", "s_zombie_control_g_village", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-18460.3, -28587.6, 1837), (0, 225, 0), "control_point_15", "s_zombie_control_g_village", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-19663.8, -29756, 1922.75), (0, 225, 0), "control_point_11", "s_zombie_control_g_village", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-16117.8, -30202.1, 1848), (0, 225, 0), "control_point_2", "s_zombie_control_g_village", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-17235.3, -29496.8, 1852), (0, 225, 0), "control_point_4", "s_zombie_control_g_village", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-20039.3, -28785.8, 1832.25), (0, 225, 0), "control_point_6", "s_zombie_control_g_village", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-17833.6, -31386.3, 1854), (0, 225, 0), "control_point_7", "s_zombie_control_g_village", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-18868.6, -30088.1, 1854.25), (0, 225, 0), "control_point_8", "s_zombie_control_g_village", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-21139.8, -30612.6, 1997.75), (0, 344.81, 0), "s_zombie_control_g_village", "s_zombie_control_g_village", "objective_zombie_control_g_village", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-18408.1, -29248.1, 1846.5), (0, 225, 0), "control_point_10", "s_zombie_control_g_village", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-21117.4, -30705.4, 1942.25), (270, 0, 25.4), "c_jup_zmb_zombie_base_charred_male_corpse_pose_13", "s_zombie_control_g_village", "zombie_control_start_interact_soldier_b_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-21131, -30547, 1904.25), (0, 345.69, 0), "c_jup_zmb_zombie_base_charred_male_corpse_pose_08", "s_zombie_control_g_village", "zombie_control_start_interact_soldier_a_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-21049.5, -30647.2, 1946.5), (0, 141.72, 0), "s_zombie_control_g_village_reward", "s_zombie_control_g_village", "objective_reward_struct", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-21148.1, -30611.9, 1937.25), (0, 344.14, 0), "zombie_control_start_interact_inhibitor_model", "s_zombie_control_g_village", "zombie_control_start_interact_inhibitor_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  s.name = "script_struct_nexus_activity_joiner";
  fe[[f]](s, us, cf, (-13319.3, -34307.6, 1957.75), (0, 109.3, 0), "activity_nexus_instance_joiner", "s_zombie_control_g_village", "ZOMBIE_CONTROL_G_VILLAGE", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-16055.6, -29177.6, 1850.25), (0, 225, 0), "control_point_12", "s_zombie_control_g_village", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-18266.1, -30170.1, 1985), (0, 0, 0), "zombie_control_quest_circle", "s_zombie_control_g_village", "zombie_control_quest_circle", undefined, undefined, (0, 0, 0), (0, 0, 0), 2500);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-17470.1, -30383.4, 1854.75), (0, 225, 0), "control_point_13", "s_zombie_control_g_village", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-20377.1, -30886.9, 1922), (0, 225, 0), "control_point_14", "s_zombie_control_g_village", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-20420.6, -29496.8, 1843.25), (0, 225, 0), "control_point_17", "s_zombie_control_g_village", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_2c0db2cbb9c88c69(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-7136.6, -27819.9, 1711.25), (0, 225, 0), "control_point_1", "s_zombie_control_g_towers", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-6005.55, -24475.8, 1711.5), (0, 225, 0), "control_point_15", "s_zombie_control_g_towers", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-4431.8, -27822.8, 1709.75), (0, 225, 0), "control_point_11", "s_zombie_control_g_towers", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-4743.8, -26849.1, 1713.5), (0, 225, 0), "control_point_2", "s_zombie_control_g_towers", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-3861.3, -25681.3, 1710.25), (0, 225, 0), "control_point_4", "s_zombie_control_g_towers", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-8598.55, -25870.6, 1713.25), (0, 225, 0), "control_point_5", "s_zombie_control_g_towers", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-6755.55, -24557.1, 1705.75), (0, 225, 0), "control_point_6", "s_zombie_control_g_towers", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-5737.85, -28258.3, 1711.75), (0, 225, 0), "control_point_7", "s_zombie_control_g_towers", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-7018.05, -26998.6, 1712.25), (0, 225, 0), "control_point_8", "s_zombie_control_g_towers", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-7956.65, -26426.8, 1767.75), (0, 77.11, 0), "s_zombie_control_g_towers", "s_zombie_control_g_towers", "objective_zombie_control_g_towers", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-4637.1, -24954.3, 1707.25), (0, 225, 0), "control_point_10", "s_zombie_control_g_towers", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-8032.66, -26400.2, 1717.75), (270, 0, 62.84), "c_jup_zmb_zombie_base_charred_male_corpse_pose_13", "s_zombie_control_g_towers", "zombie_control_start_interact_soldier_b_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-7910.61, -26376.2, 1678.75), (0, 127.64, 0), "c_jup_zmb_zombie_base_charred_male_corpse_pose_08", "s_zombie_control_g_towers", "zombie_control_start_interact_soldier_a_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-8026.71, -26341.4, 1718.25), (0, 283.13, 0), "s_zombie_control_g_towers_reward", "s_zombie_control_g_towers", "objective_reward_struct", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-7962.64, -26410.4, 1711), (0, 125.55, 0), "zombie_control_start_interact_inhibitor_model", "s_zombie_control_g_towers", "zombie_control_start_interact_inhibitor_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  s.name = "script_struct_nexus_activity_joiner";
  fe[[f]](s, us, cf, (-12909.1, -26161.6, 1782), (0, 281.86, 0), "activity_nexus_instance_joiner", "s_zombie_control_g_towers", "ZOMBIE_CONTROL_G_TOWERS", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-5555.1, -25852.1, 1706.5), (0, 225, 0), "control_point_12", "s_zombie_control_g_towers", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-6236.05, -26310.8, 1843.25), (0, 0, 0), "zombie_control_quest_circle", "s_zombie_control_g_towers", "zombie_control_quest_circle", undefined, undefined, (0, 0, 0), (0, 0, 0), 2700);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-5226.05, -26940.2, 1711.5), (0, 225, 0), "control_point_13", "s_zombie_control_g_towers", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-8629.8, -27307.7, 1718.75), (0, 225, 0), "control_point_14", "s_zombie_control_g_towers", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-7981.6, -24722.1, 1713), (0, 225, 0), "control_point_17", "s_zombie_control_g_towers", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_df8244d449587254(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-12966, -22845.5, 1774), (0, 196.72, 0), "control_point_1", "s_zombie_control_g_maestro", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-10388.8, -21499.6, 1719.58), (0, 196.72, 0), "control_point_15", "s_zombie_control_g_maestro", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-11586.4, -21755.5, 1713.15), (0, 196.72, 0), "control_point_11", "s_zombie_control_g_maestro", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-8427.32, -23320.7, 1702.71), (0, 196.72, 0), "control_point_2", "s_zombie_control_g_maestro", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-9909.75, -22299.1, 1723.4), (0, 196.72, 0), "control_point_4", "s_zombie_control_g_maestro", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-11174.9, -21208, 1713.57), (0, 196.72, 0), "control_point_6", "s_zombie_control_g_maestro", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-10421.4, -24855.6, 1731.62), (0, 196.72, 0), "control_point_7", "s_zombie_control_g_maestro", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-10826, -22103.5, 1717.52), (0, 196.72, 0), "control_point_8", "s_zombie_control_g_maestro", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-11588, -21128.5, 1997.75), (0, 316.53, 0), "s_zombie_control_g_maestro", "s_zombie_control_g_maestro", "objective_zombie_control_g_maestro", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-10629.5, -22683.9, 1717.58), (0, 196.72, 0), "control_point_10", "s_zombie_control_g_maestro", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-11705.3, -20897.1, 1751.25), (273.67, 115.36, 65.78), "c_jup_zmb_zombie_base_charred_male_corpse_pose_13", "s_zombie_control_g_maestro", "zombie_control_start_interact_soldier_b_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-11760.8, -21070.6, 1719.5), (4.87, 129.62, 0), "c_jup_zmb_zombie_base_charred_male_corpse_pose_08", "s_zombie_control_g_maestro", "zombie_control_start_interact_soldier_a_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-11598.7, -21231.3, 1946.5), (0, 113.44, 0), "s_zombie_control_g_maestro_reward", "s_zombie_control_g_maestro", "objective_reward_struct", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-11708, -21013.3, 1753.99), (0, 131.9, 0), "zombie_control_start_interact_inhibitor_model", "s_zombie_control_g_maestro", "zombie_control_start_interact_inhibitor_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  s.name = "script_struct_nexus_activity_joiner";
  fe[[f]](s, us, cf, (-12490.5, -17459.8, 1755), (0, 63.38, 0), "activity_nexus_instance_joiner", "s_zombie_control_g_maestro", "ZOMBIE_CONTROL_G_MAESTRO", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-8846.88, -24233.7, 1714.56), (0, 196.72, 0), "control_point_12", "s_zombie_control_g_maestro", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-10768.3, -23183.1, 1932), (0, 331.72, 0), "zombie_control_quest_circle", "s_zombie_control_g_maestro", "zombie_control_quest_circle", undefined, undefined, (0, 0, 0), (0, 0, 0), 2500);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-9324.85, -23649.2, 1768.21), (0, 196.72, 0), "control_point_13", "s_zombie_control_g_maestro", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-12270.7, -22111.4, 1726.46), (0, 196.72, 0), "control_point_14", "s_zombie_control_g_maestro", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-11943.1, -21378.2, 1728.48), (0, 196.72, 0), "control_point_17", "s_zombie_control_g_maestro", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydef_zombiecontrol";
  instancestruct.cf = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  instancestruct.scriptstructorigin = (-26947.7, -21870.9, 1842.25);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-25918.3, -23344.3, 1952.25)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2500];
  activityinstances["ZOMBIE_CONTROL_G_SHIPPING"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydef_zombiecontrol";
  instancestruct.cf = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  instancestruct.scriptstructorigin = (-7813.29, -15119.4, 1851.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-7218.35, -13303.8, 1812.5)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2300];
  activityinstances["ZOMBIE_CONTROL_G_BLOCK"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydef_zombiecontrol";
  instancestruct.cf = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  instancestruct.scriptstructorigin = (-27496, -36157.6, 3239.25);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-27879.3, -36444.3, 3135.25)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2900];
  activityinstances["ZOMBIE_CONTROL_G_RADIO"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydef_zombiecontrol";
  instancestruct.cf = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  instancestruct.scriptstructorigin = (-21155.3, -30602.7, 2086);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-18239.6, -30186.1, 1932)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2500];
  activityinstances["ZOMBIE_CONTROL_G_VILLAGE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydef_zombiecontrol";
  instancestruct.cf = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  instancestruct.scriptstructorigin = (-7962.8, -26422, 1846);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-6242.55, -26314.3, 1816)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2700];
  activityinstances["ZOMBIE_CONTROL_G_TOWERS"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydef_zombiecontrol";
  instancestruct.cf = "mp_jup_st_g_ob_contracts_zombie_control_cs";
  instancestruct.scriptstructorigin = (-11477, -21197.7, 2086);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-10768.3, -23183.1, 1932)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2500];
  activityinstances["ZOMBIE_CONTROL_G_MAESTRO"] = instancestruct;
  return activityinstances;
}