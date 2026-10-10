/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_261e5663acc505ad.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_h_ob_activities_merc_stronghold_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_h_ob_activities_merc_stronghold_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_h_ob_activities_merc_stronghold_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_h_ob_activities_merc_stronghold_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_h_ob_activities_merc_stronghold_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_h_ob_activities_merc_stronghold_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_h_ob_activities_merc_stronghold_cs");
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
    cf = "mp_jup_st_h_ob_activities_merc_stronghold_cs";
  }

  switch (instancename) {
    case #"hash_271aa42f6178d796":
      function_4a07ab3dd123c2ef(fe, us, cf);
      break;
    case #"hash_27242c2f61806973":
      function_4a0c2b3dd128d246(fe, us, cf);
      break;
    case #"hash_2724392f61807dea":
      function_4a0c363dd128ea77(fe, us, cf);
      break;
    case #"hash_271aa32f6178d603":
      function_4a07ac3dd123c522(fe, us, cf);
      break;
    case #"hash_96906da26a3a09e6":
      function_c4d7c4542d5e441(fe, us, cf);
      break;
  }
}

function function_4a07ab3dd123c2ef(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_merc_stronghold_cs";
  s.script_parameters = "auto_floor_2_saferoom";
  fe[[f]](s, us, cf, (12751, -36000, 2895), (0, 220, 0), undefined, "MERC_STRONGHOLD_APARTMENT_22", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_merc_stronghold_cs";
  s.name = "spawn_heli_reinforcements";
  s.script_parameters = "merc_stronghold_h_apartment_22_reinforcements";
  fe[[f]](s, us, cf, (13021.5, -36277.6, 3035.67), (0, 0, 0), undefined, "MERC_STRONGHOLD_APARTMENT_22", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (12953, -36039, 2760), (0, 0, 0), "MERC_STRONGHOLD_H_APARTMENT_22_main", "MERC_STRONGHOLD_APARTMENT_22", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_4a0c2b3dd128d246(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_merc_stronghold_cs";
  s.script_parameters = "auto_floor_3_saferoom";
  fe[[f]](s, us, cf, (3162, -29542, 2306), (0, 86.4, 0), undefined, "MERC_STRONGHOLD_APARTMENT_18", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_merc_stronghold_cs";
  s.name = "spawn_heli_reinforcements";
  s.script_parameters = "merc_stronghold_h_apartment_18_reinforcements";
  fe[[f]](s, us, cf, (3530.66, -28973.6, 2478.85), (0, 0, 0), undefined, "MERC_STRONGHOLD_APARTMENT_18", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (3443, -29282, 1969), (0, 0, 0), "MERC_STRONGHOLD_H_APARTMENT_18_main", "MERC_STRONGHOLD_APARTMENT_18", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_4a0c363dd128ea77(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_merc_stronghold_cs";
  s.name = "script_struct";
  s.script_parameters = "auto_floor_3_saferoom";
  fe[[f]](s, us, cf, (8539, -35932, 3057.25), (0, 306.37, 0), undefined, "MERC_STRONGHOLD_APARTMENT_17", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_merc_stronghold_cs";
  s.name = "spawn_heli_reinforcements";
  s.script_parameters = "merc_stronghold_h_apartment_17_reinforcements";
  fe[[f]](s, us, cf, (8876.56, -35589.2, 2777.46), (0, 0, 0), undefined, "MERC_STRONGHOLD_APARTMENT_17", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (8329, -36147, 2773), (359.51, 79.31, -2.46), "MERC_STRONGHOLD_H_APARTMENT_17_main", "MERC_STRONGHOLD_APARTMENT_17", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_4a07ac3dd123c522(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_merc_stronghold_cs";
  s.script_parameters = "auto_floor_2_saferoom";
  fe[[f]](s, us, cf, (3804, -27266, 2009), (0, 355.7, 0), undefined, "MERC_STRONGHOLD_APARTMENT_21", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_merc_stronghold_cs";
  s.name = "spawn_heli_reinforcements";
  s.script_parameters = "merc_stronghold_h_apartment_21_reinforcements";
  fe[[f]](s, us, cf, (4028.52, -28407.6, 1964), (0, 0, 0), undefined, "MERC_STRONGHOLD_APARTMENT_21", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (4110, -27293, 2150.92), (1.87, 104.26, 1.3), "MERC_STRONGHOLD_H_APARTMENT_21_main", "MERC_STRONGHOLD_APARTMENT_21", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_c4d7c4542d5e441(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_merc_stronghold_cs";
  s.script_parameters = "auto_floor_2_saferoom";
  fe[[f]](s, us, cf, (5177, -27140.5, 2017), (0, 124.15, 0), undefined, "MERC_STRONGHOLD_APARTMENT_CONSTRUCTION_02", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_merc_stronghold_cs";
  s.name = "spawn_heli_reinforcements";
  s.script_parameters = "merc_stronghold_h_apartment_construction_02_reinforcements";
  fe[[f]](s, us, cf, (5719.13, -26234.6, 1707.81), (0, 244.2, 0), undefined, "MERC_STRONGHOLD_APARTMENT_CONSTRUCTION_02", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (5317, -27011, 1728.92), (1.87, 104.26, 1.3), "MERC_STRONGHOLD_H_APARTMENT_CONSTRUCTION_02_main", "MERC_STRONGHOLD_APARTMENT_CONSTRUCTION_02", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_h_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (12980, -36184, 3175);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(12953, -36039, 2760)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1500];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(12953, -36103, 2760)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [650];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(12953, -36039, 2760)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1200];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(12954.5, -36095.5, 2757.5)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(12947.5, -36061, 2761.5)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [610];
  instancestruct.locationorigin = [(12953, -36039, 2760)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_H_APARTMENT_22"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_h_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (3499.25, -29172.5, 2617);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(3443, -29282, 1969)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1500];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(3443, -29266, 1969)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [750];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(3443, -29282, 1969)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1200];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(3438, -29293.5, 1962.5)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(3432, -29303.5, 1953.5)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [750];
  instancestruct.locationorigin = [(3443, -29282, 1969)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_H_APARTMENT_18"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_h_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (8329, -36094.5, 3520);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(8329, -36147, 2773)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1500];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(8345, -36131, 2773)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [550];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(8329, -36147, 2773)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1200];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(8324, -36146.5, 2776.5)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(8269.5, -36136, 2767.5)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [500];
  instancestruct.locationorigin = [(8329, -36147, 2773)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_H_APARTMENT_17"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_h_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (4144.25, -27366.2, 2297);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(4106, -27303, 1878.92)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1500];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(4138, -27367, 1878.92)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [650];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(4106, -27303, 1878.92)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1200];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(4105.5, -27305, 1878)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(4108, -27304, 1879)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [610];
  instancestruct.locationorigin = [(4106, -27303, 1878.92)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1500];
  activityinstances["MERC_STRONGHOLD_H_APARTMENT_21"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_h_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (5355.75, -26870.8, 2337);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(5317, -27011, 1728.92)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1500];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(5317, -26883, 1728.92)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [450];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(5317, -27011, 1728.92)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1200];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(5313, -27010, 1730)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(5318.5, -27012, 1728.5)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [450];
  instancestruct.locationorigin = [(5317, -27011, 1728.92)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1500];
  activityinstances["MERC_STRONGHOLD_H_APARTMENT_CONSTRUCTION_02"] = instancestruct;
  return activityinstances;
}