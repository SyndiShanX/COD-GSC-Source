/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1f07e992c53b57ff.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_d_ob_contracts_zombie_control_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_d_ob_contracts_zombie_control_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_d_ob_contracts_zombie_control_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_d_ob_contracts_zombie_control_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_d_ob_contracts_zombie_control_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_d_ob_contracts_zombie_control_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_d_ob_contracts_zombie_control_cs");
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
    cf = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  }

  switch (instancename) {
    case #"hash_35c595675a641d93":
      function_4bf097c93228bce8(fe, us, cf);
      break;
    case #"hash_65b64c93e267c3d1":
      function_fe005182249820de(fe, us, cf);
      break;
  }
}

function function_4bf097c93228bce8(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-34437.2, 9247.55, 962), (0, 225, 0), "control_point_1", "s_zombie_control_d_tracks", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-34336.4, 10105.5, 999.75), (0, 225, 0), "control_point_15", "s_zombie_control_d_tracks", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-33424.2, 11028.5, 963.25), (0, 225, 0), "control_point_11", "s_zombie_control_d_tracks", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-33396, 9645.7, 953.25), (0, 225, 0), "control_point_2", "s_zombie_control_d_tracks", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-31906.8, 10493, 960.75), (0, 225, 0), "control_point_4", "s_zombie_control_d_tracks", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-35792.8, 10094.7, 961.5), (0, 225, 0), "control_point_5", "s_zombie_control_d_tracks", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-34430.4, 10814.9, 958), (0, 225, 0), "control_point_6", "s_zombie_control_d_tracks", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-33309.6, 8916.9, 959.5), (0, 225, 0), "control_point_7", "s_zombie_control_d_tracks", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-34808.1, 8171.2, 969.75), (0, 225, 0), "control_point_8", "s_zombie_control_d_tracks", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-31207.4, 10320.4, 1036.75), (0, 1.74, 0), "s_zombie_control_d_tracks", "s_zombie_control_d_tracks", "objective_zombie_control_d_tracks", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-31216.1, 10321, 1009.75), (0, 182.37, 0), "zombie_control_start_interact", "s_zombie_control_d_tracks", "zombie_control_start_interact", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-32477.4, 9607.4, 960.5), (0, 225, 0), "control_point_10", "s_zombie_control_d_tracks", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-31256.9, 10216.6, 978.75), (270, 0, -164.8), "c_jup_zmb_zombie_base_charred_male_corpse_pose_13", "s_zombie_control_d_tracks", "zombie_control_start_interact_soldier_b_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-31217.7, 10362.4, 941.75), (0, 3.24, 0), "c_jup_zmb_zombie_base_charred_male_corpse_pose_08", "s_zombie_control_d_tracks", "zombie_control_start_interact_soldier_a_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-31079.8, 10324.7, 985.25), (0, 158.65, 0), "s_zombie_control_d_tracks_reward", "s_zombie_control_d_tracks", "objective_reward_struct", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-31216.7, 10318.7, 975.75), (0, 1.07, 0), "zombie_control_start_interact_inhibitor_model", "s_zombie_control_d_tracks", "zombie_control_start_interact_inhibitor_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  s.name = "script_struct_nexus_activity_joiner";
  fe[[f]](s, us, cf, (-32583.9, 14173.8, 987.25), (0, 188.09, 0), "activity_nexus_instance_joiner", "s_zombie_control_d_tracks", "ZOMBIE_CONTROL_D_TRACKS", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-31909.9, 11497.2, 964.25), (0, 225, 0), "control_point_12", "s_zombie_control_d_tracks", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-33630.6, 9730.2, 2185.25), (0, 0, 0), "zombie_control_quest_circle", "s_zombie_control_d_tracks", "zombie_control_quest_circle", undefined, undefined, (0, 0, 0), (0, 0, 0), 2300);
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-32304.4, 8725.7, 964.25), (0, 225, 0), "control_point_13", "s_zombie_control_d_tracks", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-35268.8, 9642.85, 962), (0, 225, 0), "control_point_14", "s_zombie_control_d_tracks", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-31637.2, 9182.7, 956.5), (0, 225, 0), "control_point_17", "s_zombie_control_d_tracks", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_fe005182249820de(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-27304.2, 4421.05, 1033.5), (0, 225, 0), "control_point_1", "s_zombie_control_d_condos", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-27250.9, 6039.25, 1025.5), (0, 225, 0), "control_point_15", "s_zombie_control_d_condos", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-27184.3, 7122.45, 1032.75), (0, 225, 0), "control_point_11", "s_zombie_control_d_condos", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-26766.8, 5549.45, 1034.25), (0, 225, 0), "control_point_2", "s_zombie_control_d_condos", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-24511.6, 3319, 1029.5), (0, 225, 0), "control_point_4", "s_zombie_control_d_condos", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-26112.2, 2424.45, 1030.75), (0, 225, 0), "control_point_5", "s_zombie_control_d_condos", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-26554.7, 6254.65, 1030.75), (0, 225, 0), "control_point_6", "s_zombie_control_d_condos", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-26093.3, 2984.4, 1033.5), (0, 225, 0), "control_point_7", "s_zombie_control_d_condos", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-26732.7, 3464.2, 1035), (0, 225, 0), "control_point_8", "s_zombie_control_d_condos", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-25183.5, 5204.32, 1091.75), (0, 5.83, 0), "s_zombie_control_d_condos", "s_zombie_control_d_condos", "objective_zombie_control_d_condos", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-26576.2, 4802.9, 1035.75), (0, 225, 0), "control_point_10", "s_zombie_control_d_condos", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-25128.6, 5141.96, 1036.75), (270, 0, 116.5), "c_jup_zmb_zombie_base_charred_male_corpse_pose_13", "s_zombie_control_d_condos", "zombie_control_start_interact_soldier_b_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-25249.5, 5247.38, 997.75), (0, 100.72, 0), "c_jup_zmb_zombie_base_charred_male_corpse_pose_08", "s_zombie_control_d_condos", "zombie_control_start_interact_soldier_a_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-25056.6, 5217.7, 1040.25), (0, 162.74, 0), "s_zombie_control_d_condos_reward", "s_zombie_control_d_condos", "objective_reward_struct", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-25192.7, 5201.96, 1030.75), (0, 5.15, 0), "zombie_control_start_interact_inhibitor_model", "s_zombie_control_d_condos", "zombie_control_start_interact_inhibitor_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  s.name = "script_struct_nexus_activity_joiner";
  fe[[f]](s, us, cf, (-21179.7, 8374.75, 2424.75), (0, 219.03, 0), "activity_nexus_instance_joiner", "s_zombie_control_d_condos", "ZOMBIE_CONTROL_D_CONDOS", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-25242.4, 6585, 1035.75), (0, 225, 0), "control_point_12", "s_zombie_control_d_condos", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-26380.8, 4902.2, 1539), (0, 0, 0), "zombie_control_quest_circle", "s_zombie_control_d_condos", "zombie_control_quest_circle", undefined, undefined, (0, 0, 0), (0, 0, 0), 2600);
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-25481.4, 3769.45, 1034), (0, 225, 0), "control_point_13", "s_zombie_control_d_condos", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-28117.6, 4189.85, 1028.25), (0, 225, 0), "control_point_14", "s_zombie_control_d_condos", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (-25214.7, 4598.95, 1031.75), (0, 225, 0), "control_point_17", "s_zombie_control_d_condos", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydef_zombiecontrol";
  instancestruct.cf = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  instancestruct.scriptstructorigin = (-31225.1, 10325.4, 1120.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-33604.1, 9714.2, 1778.75)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2300];
  activityinstances["ZOMBIE_CONTROL_D_TRACKS"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydef_zombiecontrol";
  instancestruct.cf = "mp_jup_st_d_ob_contracts_zombie_control_cs";
  instancestruct.scriptstructorigin = (-25201.5, 5208.04, 1175.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-26354.3, 4886.2, 1132.5)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2600];
  activityinstances["ZOMBIE_CONTROL_D_CONDOS"] = instancestruct;
  return activityinstances;
}