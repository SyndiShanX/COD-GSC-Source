/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_9879b843ce23541.gsc
************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_c_ob_contracts_outlast_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_c_ob_contracts_outlast_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_c_ob_contracts_outlast_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_c_ob_contracts_outlast_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_c_ob_contracts_outlast_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_c_ob_contracts_outlast_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_c_ob_contracts_outlast_cs");
}

function function_fd69cf02ba4d90a2() {
  var_d13c18af4084bdfd = spawnStruct();
  var_d13c18af4084bdfd.name = "REV_OB_OUTLAST";
  var_d13c18af4084bdfd.scriptbundle = "jup_ob_activitydefinition_outlast";
  var_d13c18af4084bdfd.mainfunction = &main;
  var_d13c18af4084bdfd.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  var_d13c18af4084bdfd.var_ad1dcd56d202e9ac = &function_6da2952367672ac0;
  return var_d13c18af4084bdfd;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_c_ob_contracts_outlast_cs";
  }

  switch (instancename) {
    case #"hash_be319c631d0f7c35":
      function_1488ab214a370dfc(fe, us, cf);
      break;
    case #"hash_adc900025b117076":
      function_facd10c8ca3914e1(fe, us, cf);
      break;
    case #"hash_98aa29e8232bd239":
      function_7c52b3d4d456946a(fe, us, cf);
      break;
  }
}

function function_1488ab214a370dfc(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (30728, 40930.5, 1187.5), (0, 135, 0), "zombie_spawn_wave_3", "s_outlast_c_dock", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (32188.5, 40428.5, 936), (0, 327.4, 0), "s_outlast_c_dock_reward", "s_outlast_c_dock", "s_outlast_c_dock_reward", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (32423.5, 40634.1, 935.5), (0, 329.5, 0), "pnd", "s_outlast_c_dock", "pnd", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (30303.5, 40278, 1000.5), (0, 135, 0), "zombie_spawn_wave_2", "s_outlast_c_dock", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (27851.2, 34598.5, 1234.75), (0, 131.22, 0), "activity_nexus_instance_joiner", "s_outlast_c_dock", "OUTLAST_C_DOCK", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (32634.5, 42696, 919), (0, 135, 0), "zombie_spawn_wave_1", "s_outlast_c_dock", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (32137.8, 40324.8, 991), (0, 61.3, 0), "s_outlast_c_dock", "s_outlast_c_dock", "objective_outlast_c_dock", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (31796.5, 38473, 1042), (0, 135, 0), "zombie_spawn_wave_2", "s_outlast_c_dock", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (31248, 38494.5, 1045.5), (0, 135, 0), "zombie_spawn_wave_3", "s_outlast_c_dock", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (31276.5, 41641, 931.5), (0, 135, 0), "zombie_spawn_wave_1", "s_outlast_c_dock", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (-108, 97, 219);
  s.var_74e936bbadd15418 = (520, 322, 32);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (31707.5, 40663, 952), (0, 59.9, 0), "outlast_noent_entrance_trigger", "s_outlast_c_dock", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (32643, 40358, 938), (0, 165.1, 0), "ava_tablet", "s_outlast_c_dock", "ava_tablet", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (32225, 40284.5, 991.5), (0, 135, 0), "outlast_space", "s_outlast_c_dock", "outlast_space", undefined, undefined, (0, 0, 0), (0, 0, 0), 1200);
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (416, 354, 400);
  s.var_74e936bbadd15418 = (520, 322, 32);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (32278.5, 40332, 952), (0, 59.9, 0), "outlast_noent_entrance_trigger", "s_outlast_c_dock", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_facd10c8ca3914e1(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (38234.8, 20463.8, 3329.5), (0, 135, 0), "zombie_spawn_wave_3", "s_outlast_c_monestary", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (35289.5, 17275, 3139.5), (0, 135, 0), "zombie_spawn_wave_2", "s_outlast_c_monestary", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (37226.5, 18883.5, 3344), (0, 327.4, 0), "s_outlast_c_monestary_reward", "s_outlast_c_monestary", "s_outlast_c_monestary_reward", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (37436.5, 19032.1, 3381.5), (0, 126.8, 0), "pnd", "s_outlast_c_monestary", "pnd", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (34453.2, 17967.2, 3067.5), (0, 135, 0), "zombie_spawn_wave_2", "s_outlast_c_monestary", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (33382, 20369, 2501.25), (0, 118.2, -0), "activity_nexus_instance_joiner", "s_outlast_c_monestary", "OUTLAST_C_MONESTARY", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (38498.5, 17074, 3567), (0, 135, 0), "zombie_spawn_wave_1", "s_outlast_c_monestary", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (37437.9, 19034.4, 3437), (0, 36.8, 0), "s_outlast_c_monestary", undefined, "objective_outlast_c_monestary", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (543, 71, 104);
  s.var_74e936bbadd15418 = (459, 105, 32);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (36801, 19111, 3364), (0, 37.38, 0), "outlast_noent_entrance_trigger", "s_outlast_c_monestary", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (571, 313, 181);
  s.var_74e936bbadd15418 = (555, 347, 32);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (37045, 18771, 3364), (0, 37.38, 0), "outlast_noent_entrance_trigger", "s_outlast_c_monestary", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (119, 82, 105);
  s.var_74e936bbadd15418 = (133, 105, 32);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (37652, 18698, 3364), (0, 37.38, 0), "outlast_noent_entrance_trigger", "s_outlast_c_monestary", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (37184, 18714, 3344), (0, 159.2, 0), "ava_tablet", "s_outlast_c_monestary", "ava_tablet", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (37046, 18724.5, 3388.5), (0, 135, 0), "outlast_space", "s_outlast_c_monestary", "outlast_space", undefined, undefined, (0, 0, 0), (0, 0, 0), 1200);
}

function function_7c52b3d4d456946a(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (22149.5, 28231.5, 1616.5), (0, 135, 0), "zombie_spawn_wave_3", "s_outlast_c_chemist", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (23893.5, 27787, 1357), (0, 269.71, 0), "s_outlast_c_chemist_reward", "s_outlast_c_chemist", "s_outlast_c_chemist_reward", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (23613.5, 27735.1, 1357), (0, 359.57, 0), "pnd", "s_outlast_c_chemist", "pnd", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (21584.5, 27873, 1348.81), (0, 285.53, 0), "zombie_spawn_wave_2", "s_outlast_c_chemist", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (29352.5, 23224, 1464.5), (0, 58.39, 0), "activity_nexus_instance_joiner", "s_outlast_c_chemist", "OUTLAST_C_CHEMIST", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (23784, 29302, 1348), (0, 208.58, 0), "zombie_spawn_wave_1", "s_outlast_c_chemist", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (23559.3, 27625.8, 1420), (0, 61.3, 0), "s_outlast_c_chemist", undefined, "objective_outlast_c_chemist", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (23218, 25774, 1357), (0, 135, 0), "zombie_spawn_wave_2", "s_outlast_c_chemist", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (22967.5, 25997.5, 1350.19), (0, 135, 0), "zombie_spawn_wave_3", "s_outlast_c_chemist", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (22867, 28929, 1358), (0, 271.42, 0), "zombie_spawn_wave_1", "s_outlast_c_chemist", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (24060.5, 27802.5, 1361), (0, 217.9, 0), "ava_tablet", "s_outlast_c_chemist", "ava_tablet", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (23646.5, 27585.5, 1420.5), (0, 135, 0), "outlast_space", "s_outlast_c_chemist", "outlast_space", undefined, undefined, (0, 0, 0), (0, 0, 0), 1200);
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (938, 594, 314);
  s.var_74e936bbadd15418 = (968, 674, 32);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (23700, 27633, 1381), (0, 359.85, 0), "outlast_noent_entrance_trigger", "s_outlast_c_chemist", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_outlast";
  instancestruct.cf = "mp_jup_st_c_ob_contracts_outlast_cs";
  instancestruct.scriptstructorigin = (32135.9, 40320.6, 982);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(32313.5, 40174.5, 994)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1500];
  activityinstances["OUTLAST_C_DOCK"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_outlast";
  instancestruct.cf = "mp_jup_st_c_ob_contracts_outlast_cs";
  instancestruct.scriptstructorigin = (37434.4, 19031.4, 3428);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(38210.5, 19821.5, 3506)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1500];
  activityinstances["OUTLAST_C_MONESTARY"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_outlast";
  instancestruct.cf = "mp_jup_st_c_ob_contracts_outlast_cs";
  instancestruct.scriptstructorigin = (23557.4, 27621.6, 1411);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(23735, 27475.5, 1423)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1500];
  activityinstances["OUTLAST_C_CHEMIST"] = instancestruct;
  return activityinstances;
}