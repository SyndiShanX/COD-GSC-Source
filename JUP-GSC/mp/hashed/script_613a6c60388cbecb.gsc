/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_613a6c60388cbecb.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_f_ob_contracts_zombie_control_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_f_ob_contracts_zombie_control_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_f_ob_contracts_zombie_control_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_f_ob_contracts_zombie_control_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_f_ob_contracts_zombie_control_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_f_ob_contracts_zombie_control_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_f_ob_contracts_zombie_control_cs");
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
    cf = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  }

  switch (instancename) {
    case #"hash_2a71ff9d8e2b53c0":
      function_5a6cd0c89a3ec85b(fe, us, cf);
      break;
    case #"hash_1b830c9f9d01d37b":
      function_1a9ccddfc3eec62c(fe, us, cf);
      break;
  }
}

function function_5a6cd0c89a3ec85b(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (39869.5, -1841, 2970), (0, 225, 0), "control_point_15", "s_zombie_control_f_greenhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (37897, 1588.5, 2977.5), (0, 225, 0), "control_point_11", "s_zombie_control_f_greenhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (37733.5, 889, 2978.5), (0, 225, 0), "control_point_1", "s_zombie_control_f_greenhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (38888.5, -43.75, 2969), (0, 225, 0), "control_point_2", "s_zombie_control_f_greenhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (38248, 1192.5, 2980.5), (0, 225, 0), "control_point_3", "s_zombie_control_f_greenhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (37824, -2279.25, 2968.5), (0, 225, 0), "control_point_4", "s_zombie_control_f_greenhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (38327.5, -2005, 2971.5), (0, 225, 0), "control_point_5", "s_zombie_control_f_greenhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (38423, -1158, 2971.5), (0, 225, 0), "control_point_6", "s_zombie_control_f_greenhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (39121.5, 1407.5, 2970.5), (0, 225, 0), "control_point_7", "s_zombie_control_f_greenhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (40018, -475, 2973.5), (0, 225, 0), "control_point_8", "s_zombie_control_f_greenhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (37734.5, -622, 2973), (0, 225, 0), "control_point_9", "s_zombie_control_f_greenhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (38047.7, 438.3, 3030.5), (0, 180.22, 0), "s_zombie_control_f_greenhouse", "s_zombie_control_f_greenhouse", "objective_zombie_control_f_greenhouse", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (39217.8, -2918.5, 2962.75), (0, 225, 0), "control_point_10", "s_zombie_control_f_greenhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (37820.2, 456.21, 2979.5), (270, 0, -76.4), "c_jup_zmb_zombie_base_charred_male_corpse_pose_13", "s_zombie_control_f_greenhouse", "zombie_control_start_interact_soldier_b_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (38056.9, 536.59, 2941.5), (0, 185.51, 0), "c_jup_zmb_zombie_base_charred_male_corpse_pose_08", "s_zombie_control_f_greenhouse", "zombie_control_start_interact_soldier_a_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (37888.3, 445.03, 2981.5), (0, 350.82, 0), "s_zombie_control_f_greenhouse_reward", "s_zombie_control_f_greenhouse", "objective_reward_struct", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (38057, 439.74, 2969.5), (0, 179.54, 0), "zombie_control_start_interact_inhibitor_model", "s_zombie_control_f_greenhouse", "zombie_control_start_interact_inhibitor_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (38790.8, 5967.75, 2946.75), (0, 350.45, 0), "activity_nexus_instance_joiner", "s_zombie_control_f_greenhouse", "ZOMBIE_CONTROL_F_GREENHOUSE", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (38688.5, 1147, 2982.5), (0, 225, 0), "control_point_12", "s_zombie_control_f_greenhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (38930.5, -435, 3459), (0, 0, 0), "zombie_control_quest_circle", "s_zombie_control_f_greenhouse", "zombie_control_quest_circle", undefined, undefined, (0, 0, 0), (0, 0, 0), 2550);
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (38325.5, 376.25, 2975.25), (0, 225, 0), "control_point_13", "s_zombie_control_f_greenhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (40093.2, 568, 3010.25), (0, 225, 0), "control_point_14", "s_zombie_control_f_greenhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (38707.5, 1948, 2980), (0, 225, 0), "control_point_17", "s_zombie_control_f_greenhouse", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_1a9ccddfc3eec62c(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (34143.8, -13041.5, 2936), (0, 225, 0), "control_point_15", "s_zombie_control_f_mall", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (32428.2, -11223, 2933), (0, 225, 0), "control_point_11", "s_zombie_control_f_mall", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (35112, -13051.5, 2931), (0, 225, 0), "control_point_1", "s_zombie_control_f_mall", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (33573, -11888, 2933.5), (0, 225, 0), "control_point_2", "s_zombie_control_f_mall", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (33065.5, -11064, 2937), (0, 225, 0), "control_point_3", "s_zombie_control_f_mall", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (32664.8, -12080.8, 2936), (0, 225, 0), "control_point_4", "s_zombie_control_f_mall", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (33076, -13463.2, 2933.5), (0, 225, 0), "control_point_5", "s_zombie_control_f_mall", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (33192.5, -12934, 2928), (0, 225, 0), "control_point_6", "s_zombie_control_f_mall", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (34149.5, -10814, 2931.25), (0, 225, 0), "control_point_7", "s_zombie_control_f_mall", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (33575.5, -13297.5, 2931.5), (0, 225, 0), "control_point_8", "s_zombie_control_f_mall", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (33076.8, -10094.8, 2929.5), (0, 225, 0), "control_point_9", "s_zombie_control_f_mall", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (33502.4, -12388.5, 2996.5), (0, 193.91, 0), "s_zombie_control_f_mall", "s_zombie_control_f_mall", "objective_zombie_control_f_mall", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (34058.2, -13876, 2931.5), (0, 225, 0), "control_point_10", "s_zombie_control_f_mall", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (33426.4, -12464.6, 2941.5), (270, 0, 112.2), "c_jup_zmb_zombie_base_charred_male_corpse_pose_13", "s_zombie_control_f_mall", "zombie_control_start_interact_soldier_b_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (33525.1, -12444.2, 2903.5), (0, 201.51, 0), "c_jup_zmb_zombie_base_charred_male_corpse_pose_08", "s_zombie_control_f_mall", "zombie_control_start_interact_soldier_a_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (33408.8, -12438.5, 2944.5), (0, 350.82, 0), "s_zombie_control_f_mall_reward", "s_zombie_control_f_mall", "objective_reward_struct", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (33511.1, -12384.9, 2935.5), (0, 193.24, 0), "zombie_control_start_interact_inhibitor_model", "s_zombie_control_f_mall", "zombie_control_start_interact_inhibitor_model", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (38340.5, -8017.25, 3058), (0, 178.66, 0), "activity_nexus_instance_joiner", "s_zombie_control_f_mall", "ZOMBIE_CONTROL_F_MALL", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (33970, -11326.5, 2939), (0, 225, 0), "control_point_12", "s_zombie_control_f_mall", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (33485.5, -12262, 3437.25), (0, 0, 0), "zombie_control_quest_circle", "s_zombie_control_f_mall", "zombie_control_quest_circle", undefined, undefined, (0, 0, 0), (0, 0, 0), 2500);
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (34391.5, -11661.5, 2933.5), (0, 225, 0), "control_point_13", "s_zombie_control_f_mall", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (34542.2, -12249.5, 2936), (0, 225, 0), "control_point_14", "s_zombie_control_f_mall", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  fe[[f]](s, us, cf, (33482.8, -10728.8, 2921), (0, 225, 0), "control_point_17", "s_zombie_control_f_mall", "control_spawn_point", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydef_zombiecontrol";
  instancestruct.cf = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  instancestruct.scriptstructorigin = (38065.3, 432.77, 3114.5);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(38957, -451, 3052.5)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2550];
  activityinstances["ZOMBIE_CONTROL_F_GREENHOUSE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydef_zombiecontrol";
  instancestruct.cf = "mp_jup_st_f_ob_contracts_zombie_control_cs";
  instancestruct.scriptstructorigin = (33520.8, -12389.7, 3080.5);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(33512, -12278, 3030.75)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2500];
  activityinstances["ZOMBIE_CONTROL_F_MALL"] = instancestruct;
  return activityinstances;
}