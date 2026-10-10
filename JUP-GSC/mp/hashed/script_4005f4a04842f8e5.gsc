/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4005f4a04842f8e5.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_c_ob_activities_merc_stronghold_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_c_ob_activities_merc_stronghold_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_c_ob_activities_merc_stronghold_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_c_ob_activities_merc_stronghold_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_c_ob_activities_merc_stronghold_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_c_ob_activities_merc_stronghold_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_c_ob_activities_merc_stronghold_cs");
}

function function_fd69cf02ba4d90a2() {
  var_d13c18af4084bdfd = spawnStruct();
  var_d13c18af4084bdfd.name = "REV_OB_MERC_STRONGHOLD";
  var_d13c18af4084bdfd.scriptbundle = "jup_activitydefinition_merc_stronghold";
  var_d13c18af4084bdfd.mainfunction = &main;
  var_d13c18af4084bdfd.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  var_d13c18af4084bdfd.var_ad1dcd56d202e9ac = &function_6da2952367672ac0;
  return var_d13c18af4084bdfd;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_c_ob_activities_merc_stronghold_cs";
  }

  switch (instancename) {
    case #"hash_66b0dc0e744e028":
      function_6e541aab8d090a15(fe, us, cf);
      break;
    case #"hash_389728a288e42d9e":
      function_5070fba3d459b57f(fe, us, cf);
      break;
    case #"hash_86c96f7554bfd527":
      function_50be2f4e50e673da(fe, us, cf);
      break;
    case #"hash_f3152ea0682f1ac1":
      function_b8da58bef8cc444(fe, us, cf);
      break;
    case #"hash_8bfc15808e50ca6e":
      function_f9857e65858ed485(fe, us, cf);
      break;
  }
}

function function_6e541aab8d090a15(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_merc_stronghold_cs";
  s.name = "ai_encounter_spwanpoint_reinforcements";
  s.script_parameters = "merc_stronghold_c_subbase_warehouse_02_reinforcements";
  fe[[f]](s, us, cf, (31872, 39592, 1047), (0, 0, 0), undefined, "MERC_STRONGHOLD_SUBBASE_WAREHOUSE_02", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (32320, 40392, 1086.25), (0, 0, 0), "MERC_STRONGHOLD_C_SUBBASE_WAREHOUSE_02_main", "MERC_STRONGHOLD_SUBBASE_WAREHOUSE_02", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_merc_stronghold_cs";
  s.script_parameters = "auto_subbase_warehouse_02_safe_room";
  fe[[f]](s, us, cf, (32132, 39840, 1184), (0, 60, 0), undefined, "MERC_STRONGHOLD_SUBBASE_WAREHOUSE_02", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_5070fba3d459b57f(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_merc_stronghold_cs";
  s.name = "ai_encounter_spawnpoint_reinforcements";
  s.script_parameters = "merc_stronghold_c_countdown_office_2s_01_reinforcements";
  fe[[f]](s, us, cf, (37191, 29214, 1768), (0, 135, 0), undefined, "MERC_STRONGHOLD_COUNTDOWN_OFFICE_2S_01", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (36336, 29344, 1792), (0, 0, 0), "MERC_STRONGHOLD_C_COUNTDOWN_OFFICE_2S_01_main", "MERC_STRONGHOLD_COUNTDOWN_OFFICE_2S_01", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_merc_stronghold_cs";
  s.script_parameters = "auto_countdown_office_2s_01_safe_room";
  fe[[f]](s, us, cf, (35860, 29384, 1938), (0, 60, 0), undefined, "MERC_STRONGHOLD_COUNTDOWN_OFFICE_2S_01", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_50be2f4e50e673da(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_merc_stronghold_cs";
  s.name = "ai_encounter_spawnpoint_reinforcements";
  s.script_parameters = "merc_stronghold_c_milbase_office_2s_02_reinforcements";
  fe[[f]](s, us, cf, (32620, 30976, 1349.52), (0, 135, 0), undefined, "MERC_STRONGHOLD_MILBASE_OFFICE_2S_02", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (32096, 30176, 1488), (0, 0, 0), "MERC_STRONGHOLD_C_MILBASE_OFFICE_2S_02_main", "MERC_STRONGHOLD_MILBASE_OFFICE_2S_02", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_merc_stronghold_cs";
  s.script_parameters = "auto_milbase_office_2s_02_safe_room";
  fe[[f]](s, us, cf, (32216, 29952, 1480), (0, 60, 0), undefined, "MERC_STRONGHOLD_MILBASE_OFFICE_2S_02", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_b8da58bef8cc444(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (24184, 33928, 1552), (0, 0, 0), "MERC_STRONGHOLD_C_MILBASE_WAREHOUSE_01_main", "MERC_STRONGHOLD_MILBASE_WAREHOUSE_01", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_merc_stronghold_cs";
  s.script_parameters = "auto_milbase_warehouse_01_safe_room";
  fe[[f]](s, us, cf, (23824, 33760, 1736), (0, 59.6, 0), undefined, "MERC_STRONGHOLD_MILBASE_WAREHOUSE_01", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_merc_stronghold_cs";
  s.name = "ai_encounter_spawnpoint_reinforcements";
  s.script_parameters = "merc_stronghold_c_milbase_warehouse_01_reinforcements";
  fe[[f]](s, us, cf, (23920, 33216, 1552), (0, 90, 0), undefined, "MERC_STRONGHOLD_MILBASE_WAREHOUSE_01", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_f9857e65858ed485(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (27752, 23928, 1432), (0, 0, 0), "MERC_STRONGHOLD_C_POLICE_STATION_01_B_main", "MERC_STRONGHOLD_POLICE_STATION_01_B", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_merc_stronghold_cs";
  s.script_parameters = "auto_floor_2_saferoom";
  fe[[f]](s, us, cf, (27864, 24064, 1596), (0, 270.09, 0), undefined, "MERC_STRONGHOLD_POLICE_STATION_01_B", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_merc_stronghold_cs";
  s.name = "ai_encounter_spawnpoint_reinforcements";
  s.script_parameters = "merc_stronghold_c_police_station_01_b_reinforcements";
  fe[[f]](s, us, cf, (28352, 23360, 1424), (0, 180, 0), undefined, "MERC_STRONGHOLD_POLICE_STATION_01_B", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_c_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (32272, 40312, 1488);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(32320, 40392, 1032)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1536];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(32320, 40392, 1000)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1280];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(32128, 40360, 1064)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [720];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(32320, 40424, 952)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2048];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(32224, 40336, 984)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [720];
  instancestruct.locationorigin = [(32320, 40392, 968)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2048];
  activityinstances["MERC_STRONGHOLD_C_SUBBASE_WAREHOUSE_02"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_c_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (36368, 29368, 2224);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(36320, 29352, 1792)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1536];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(36320, 29352, 1824)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2048];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(36320, 29352, 1856)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [720];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(36304, 29360, 1792)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1280];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(36288, 29360, 1784)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [960];
  instancestruct.locationorigin = [(36312, 29400, 1792)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_C_COUNTDOWN_OFFICE_2S_01"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_c_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (32216, 30416, 1848);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(32088, 30176, 1496)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1536];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(32104, 30200, 1496)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2048];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(32104, 30200, 1528)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [720];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(32088, 30176, 1496)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1280];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(32184, 30368, 1496)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [640];
  instancestruct.locationorigin = [(32088, 30176, 1496)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_C_MILBASE_OFFICE_2S_02"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_c_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (24280, 33760, 2072);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(24192, 33920, 1560)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1920];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(24144, 33936, 1560)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2048];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(24240, 33848, 1592)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [720];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(24192, 33920, 1560)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1536];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(24224, 33832, 1552)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [720];
  instancestruct.locationorigin = [(24192, 33920, 1560)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_C_MILBASE_WAREHOUSE_01"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_c_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (27840, 23832, 1888);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(27808, 23944, 1448)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1600];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(27736, 23976, 1440)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2048];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(27800, 23888, 1472)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [1024];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(27792, 23944, 1448)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1600];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(27808, 23832, 1472)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [960];
  instancestruct.locationorigin = [(27760, 23936, 1432)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_C_POLICE_STATION_01_B"] = instancestruct;
  return activityinstances;
}