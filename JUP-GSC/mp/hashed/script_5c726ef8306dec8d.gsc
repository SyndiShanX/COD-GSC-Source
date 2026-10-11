/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5c726ef8306dec8d.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_g_ob_activities_merc_stronghold_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_g_ob_activities_merc_stronghold_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_g_ob_activities_merc_stronghold_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_g_ob_activities_merc_stronghold_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_g_ob_activities_merc_stronghold_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_g_ob_activities_merc_stronghold_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_g_ob_activities_merc_stronghold_cs");
}

function function_fd69cf02ba4d90a2() {
  activityinfostruct = spawnStruct();
  activityinfostruct.name = "REV_OB_MERC_STRONGHOLD";
  activityinfostruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  activityinfostruct.mainfunction = &main;
  activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  activityinfostruct.metadatafunction = &function_6da2952367672ac0;
  return activityinfostruct;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  }

  switch (instancename) {
    case #"hash_5489c5163ff10d45":
      function_4919da09da576578(fe, us, cf);
      break;
    case #"hash_c2b9705f74277bf8":
      function_c248943faec3fc6f(fe, us, cf);
      break;
    case #"hash_b1580e1228deb338":
      function_6ed5aa715dc3fa7(fe, us, cf);
      break;
    case #"hash_43f53a2fa5e49ef3":
      function_dba70f46e85537be(fe, us, cf);
      break;
    case #"hash_3c6c84e43ed31a78":
      function_85384d83998f1207(fe, us, cf);
      break;
    case #"hash_dbe2f417de250d7c":
      function_da94ad8e55c8ed6d(fe, us, cf);
      break;
    case #"hash_dbdc8717de1fe4b7":
      function_da8c228e55bfd00e(fe, us, cf);
      break;
    case #"hash_e0ef520aa5470fa2":
      function_9129030ccfb51cb7(fe, us, cf);
      break;
  }
}

function function_4919da09da576578(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "MERC_STRONGHOLD_G_STATION_HOUSE_01_main", "MERC_STRONGHOLD_STATION_HOUSE_01", undefined, undefined, undefined, (-28029.9, -14935, 1975), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  s.name = "script_struct_safe";
  s.script_parameters = "auto_floor_2_saferoom";
  fe[[f]](s, us, cf, (-298.69, -195.14, -242.5), (0, 343.84, 0), undefined, "MERC_STRONGHOLD_STATION_HOUSE_01", "s_safe_spawn", undefined, undefined, (-28029.9, -14935, 1975), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  s.name = "Reinforcements";
  s.script_parameters = "merc_stronghold_g_station_house_01_reinforcements";
  fe[[f]](s, us, cf, (-578.38, -1666.36, -441.54), (0, 71.4, 0), undefined, "MERC_STRONGHOLD_STATION_HOUSE_01", "s_safe_reinforce", undefined, undefined, (-28029.9, -14935, 1975), (0, 0, 0));
}

function function_c248943faec3fc6f(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  s.name = "reinforcement_point";
  s.script_parameters = "merc_stronghold_g_car_dealership_01_reinforcements";
  fe[[f]](s, us, cf, (-1436.44, -200.46, -7.1), (0, 0, 0), undefined, "MERC_STRONGHOLD_CAR_DEALERSHIP_01", "s_safe_reinforce", undefined, undefined, (-10087, -11620, 1715), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "MERC_STRONGHOLD_G_CAR_DEALERSHIP_01_main", "MERC_STRONGHOLD_CAR_DEALERSHIP_01", undefined, undefined, undefined, (-10087, -11620, 1715), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  s.name = "script_struct_safe";
  s.script_parameters = "auto_floor_2_saferoom";
  fe[[f]](s, us, cf, (-576.77, -534.83, 168), (0, 45.2, 0), undefined, "MERC_STRONGHOLD_CAR_DEALERSHIP_01", "s_safe_spawn", undefined, undefined, (-10087, -11620, 1715), (0, 0, 0));
}

function function_6ed5aa715dc3fa7(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  s.name = "reinforcement_point";
  s.script_parameters = "merc_stronghold_g_restaurant_02_reinforcements";
  fe[[f]](s, us, cf, (-7030.89, -17390.6, 1704.97), (0, 0, 0), undefined, "MERC_STRONGHOLD_RESTAURANT_02", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (-7713, -18279, 1725.5), (0, 0, 0), "MERC_STRONGHOLD_G_RESTAURANT_02_main", "MERC_STRONGHOLD_RESTAURANT_02", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  s.name = "script_struct_safe";
  s.script_parameters = "auto_floor_2_saferoom";
  fe[[f]](s, us, cf, (-6908, -18024, 1864.25), (0, 232.2, 0), undefined, "MERC_STRONGHOLD_RESTAURANT_02", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_dba70f46e85537be(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "MERC_STRONGHOLD_G_UNIVERSITY_BUILDING_01_main", "MERC_STRONGHOLD_UNIVERSITY_BUILDING_01", undefined, undefined, undefined, (-13274.2, -39796.9, 2389.5), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  s.name = "script_struct_safe";
  s.script_parameters = "auto_floor_2_saferoom";
  fe[[f]](s, us, cf, (301.15, -337.94, 216), (0, 20, 0), undefined, "MERC_STRONGHOLD_UNIVERSITY_BUILDING_01", "s_safe_spawn", undefined, undefined, (-13274.2, -39796.9, 2389.5), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  s.name = "Reinforcements";
  s.script_parameters = "merc_stronghold_g_university_building_01_reinforcements";
  fe[[f]](s, us, cf, (1316.84, 584.71, -96.53), (0, 0, 0), undefined, "MERC_STRONGHOLD_UNIVERSITY_BUILDING_01", "s_safe_reinforce", undefined, undefined, (-13274.2, -39796.9, 2389.5), (0, 0, 0));
}

function function_85384d83998f1207(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "MERC_STRONGHOLD_G_CLINIC_01_main", "MERC_STRONGHOLD_G_CLINIC_01", undefined, undefined, undefined, (-15438.4, -42514, 2853.5), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  s.name = "script_struct_safe";
  s.script_parameters = "auto_floor_3_saferoom";
  fe[[f]](s, us, cf, (258.97, 50.28, 304), (0, 20, 0), undefined, "MERC_STRONGHOLD_G_CLINIC_01", "s_safe_spawn", undefined, undefined, (-15438.4, -42514, 2853.5), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  s.name = "reinforcement_point";
  s.script_parameters = "merc_stronghold_g_clinic_01_reinforcements";
  fe[[f]](s, us, cf, (91.93, -37.52, 440), (0, 0, 0), undefined, "MERC_STRONGHOLD_G_CLINIC_01", "s_safe_reinforce", undefined, undefined, (-15438.4, -42514, 2853.5), (0, 0, 0));
}

function function_da94ad8e55c8ed6d(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (0, 0, 18.75), (0, 0, 0), "MERC_STRONGHOLD_G_APARTMENT_21_main", "MERC_STRONGHOLD_APARTMENT_21", undefined, undefined, undefined, (-1890.83, -19628.6, 1691.21), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  s.name = "script_struct_safe";
  s.script_parameters = "auto_floor_2_saferoom";
  fe[[f]](s, us, cf, (-404.38, -5.48, 162.76), (0, 320.11, 0), undefined, "MERC_STRONGHOLD_APARTMENT_21", "s_safe_spawn", undefined, undefined, (-1890.83, -19628.6, 1691.21), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  s.name = "reinforcement_point";
  s.script_parameters = "merc_stronghold_g_apartment_21_reinforcements";
  fe[[f]](s, us, cf, (436.4, 683.56, 26.39), (0, 0, 0), undefined, "MERC_STRONGHOLD_APARTMENT_21", "s_safe_reinforce", undefined, undefined, (-1890.83, -19628.6, 1691.21), (0, 0, 0));
}

function function_da8c228e55bfd00e(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "MERC_STRONGHOLD_G_APARTMENT_02_main", "MERC_STRONGHOLD_G_APARTMENT_02", undefined, undefined, undefined, (-6168.51, -12951, 1838.48), (0, 330, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  s.name = "script_struct_safe";
  s.script_parameters = "auto_floor_2_saferoom";
  fe[[f]](s, us, cf, (132.66, 165.19, 162.43), (0, 255, 0), undefined, "MERC_STRONGHOLD_G_APARTMENT_02", "s_safe_spawn", undefined, undefined, (-6168.51, -12951, 1838.48), (0, 330, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  s.name = "reinforcement_point";
  s.script_parameters = "merc_stronghold_g_apartment_02_reinforcements";
  fe[[f]](s, us, cf, (77.92, -132.57, 450.18), (0, 0, 0), undefined, "MERC_STRONGHOLD_G_APARTMENT_02", "s_safe_reinforce", undefined, undefined, (-6168.51, -12951, 1838.48), (0, 330, 0));
}

function function_9129030ccfb51cb7(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), "MERC_STRONGHOLD_APARTMENT_18_main", "MERC_STRONGHOLD_APARTMENT_18", undefined, undefined, undefined, (-18547.6, -30902.3, 1855.75), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  s.name = "script_struct_safe";
  s.script_parameters = "auto_floor_3_saferoom";
  fe[[f]](s, us, cf, (-183.8, -230.82, 336), (0, 255, 0), undefined, "MERC_STRONGHOLD_APARTMENT_18", "s_safe_spawn", undefined, undefined, (-18547.6, -30902.3, 1855.75), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  s.name = "reinforcement_point";
  s.script_parameters = "merc_stronghold_apartment_18_reinforcements";
  fe[[f]](s, us, cf, (241.85, 71.44, 504), (0, 0, 0), undefined, "MERC_STRONGHOLD_APARTMENT_18", "s_safe_reinforce", undefined, undefined, (-18547.6, -30902.3, 1855.75), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (-66.5, -168.75, 119);
  instancestruct.scriptstructoriginoffset = (-28029.9, -14935, 1975);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(53.5, 190.5, -420), (-362, -1062.5, -405.5)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [750, 250];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(2, -259, -432.03)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1300];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(-65.11, -177, -442.23)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [1200];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(-30, -355, -432.03)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1600];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(0, -128, -436.03)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.locationorigin = [(35.5, -95.5, -404.03)];
  instancestruct.locationoriginoffset = [(-28029.9, -14935, 1975)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_G_STATION_HOUSE_01"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (-37.75, 36.75, 538);
  instancestruct.scriptstructoriginoffset = (-10087, -11620, 1715);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(0, 0, 0)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1600];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(0, 0, 0)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(-96, 64, 0)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1400];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(23.07, 30.51, 0)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [1300];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(-625.39, -441.98, -16.85), (823.36, 531.27, -16.85)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [200, 200];
  instancestruct.locationorigin = [(0, 0, 0)];
  instancestruct.locationoriginoffset = [(-10087, -11620, 1715)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_G_CAR_DEALERSHIP_01"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (-7661.25, -18335.5, 2145);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(-7713, -18279, 1725.5)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1500];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(-7713, -18279, 1725.5)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [1200];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(-7713, -18279, 1725.5)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1200];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(-7624, -18339, 1725.5)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [1000];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(-7713, -18279, 1725.5)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.locationorigin = [(-7713, -18279, 1725.5)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_G_RESTAURANT_02"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (99.75, -36.5, 538);
  instancestruct.scriptstructoriginoffset = (-13274.2, -39796.9, 2389.5);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(330, 10, 0)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1300];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(330, 10, 0)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1200];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(209.09, 3.69, 0)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [1000];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(0, 0, 0)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(-130.84, -620.3, -16.85)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [250];
  instancestruct.locationorigin = [(0, 0, 0)];
  instancestruct.locationoriginoffset = [(-13274.2, -39796.9, 2389.5)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_G_UNIVERSITY_BUILDING_01"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (0, 0, 593);
  instancestruct.scriptstructoriginoffset = (-15438.4, -42514, 2853.5);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(0, 0, 0)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1200];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(0, 0, 0)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [900];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(0, 0, 0)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [900];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(0, 0, 0)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(-375.17, -266.75, -16.85), (543.83, 40.75, -16.85)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [400, 100];
  instancestruct.locationorigin = [(0, 0, 0)];
  instancestruct.locationoriginoffset = [(-15438.4, -42514, 2853.5)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_G_CLINIC_01"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (0, 0, 464);
  instancestruct.scriptstructoriginoffset = (-1890.83, -19628.6, 1691.21);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(0, 0, 18.75)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1200];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(0, 0, 18.75)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [900];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(0, 0, 18.75)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [700];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(0, 0, 0)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(5.67, 13.86, -16.85)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [550];
  instancestruct.locationorigin = [(0, 0, 18.75)];
  instancestruct.locationoriginoffset = [(-1890.83, -19628.6, 1691.21)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_G_APARTMENT_21"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (76.5, -15.75, 586);
  instancestruct.scriptstructoriginoffset = (-6168.51, -12951, 1838.48);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(32, 0, 0)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [800];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(32, 0, 0)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [500];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(68.17, -67.82, 0)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [400];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(0, 0, 0)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(179.5, -60, -16.85)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [350];
  instancestruct.locationorigin = [(0, 0, 0)];
  instancestruct.locationoriginoffset = [(-6168.51, -12951, 1838.48)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 330, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_G_APARTMENT_02"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_g_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (24.5, -52, 648);
  instancestruct.scriptstructoriginoffset = (-18547.6, -30902.3, 1855.75);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(0, 0, 0)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1200];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(-32, -64, 0)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [900];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(33.21, -80.33, 0)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [700];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(0, 0, 0)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(-358.26, -134.58, 35.25), (463.74, 85.42, 9.5), (87.99, -137.33, 507.75)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [200, 100, 50];
  instancestruct.locationorigin = [(0, 0, 0)];
  instancestruct.locationoriginoffset = [(-18547.6, -30902.3, 1855.75)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_APARTMENT_18"] = instancestruct;
  return activityinstances;
}