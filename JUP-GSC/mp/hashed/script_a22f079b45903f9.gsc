/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_a22f079b45903f9.gsc
************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_f_ob_activities_merc_stronghold_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_f_ob_activities_merc_stronghold_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_f_ob_activities_merc_stronghold_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_f_ob_activities_merc_stronghold_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_f_ob_activities_merc_stronghold_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_f_ob_activities_merc_stronghold_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_f_ob_activities_merc_stronghold_cs");
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
    cf = "mp_jup_st_f_ob_activities_merc_stronghold_cs";
  }

  switch (instancename) {
    case #"hash_2bb6211f7849cc8b":
      function_595dfa6fe7bdd9a8(fe, us, cf);
      break;
    case #"hash_f81092ac72bc723c":
      function_ffdee32fdb845315(fe, us, cf);
      break;
    case #"hash_9106b8f4ca09cb14":
      function_beda053eee3066a7(fe, us, cf);
      break;
    case #"hash_9fcf3ed7e14722e8":
      function_502147fe51d64d45(fe, us, cf);
      break;
    case #"hash_49558694e6b36b4b":
      function_6faadfd7e3c85e22(fe, us, cf);
      break;
    case #"hash_49558994e6b37004":
      function_6faadcd7e3c85789(fe, us, cf);
      break;
    case #"hash_c6360c326f9770cc":
      function_5df0b353a8fdc00b(fe, us, cf);
      break;
  }
}

function function_595dfa6fe7bdd9a8(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (31822.5, 1914.5, 2568.25), (0, 0, 0), "MERC_STRONGHOLD_F_HOUSE_LG_01_main", "MERC_STRONGHOLD_HOUSE_LG_01", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_merc_stronghold_cs";
  s.name = "script_struct_safe";
  s.script_parameters = "auto_floor_2";
  fe[[f]](s, us, cf, (31815.2, 1938.25, 2376), (0, 180.03, 0), undefined, "MERC_STRONGHOLD_HOUSE_LG_01", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_merc_stronghold_cs";
  s.name = "ai_encounter_spawnpoint_reinforcements";
  s.script_parameters = "merc_stronghold_f_house_lg_01_reinforcements";
  fe[[f]](s, us, cf, (31937.5, 1242, 2165.5), (0, 0, 0), undefined, "MERC_STRONGHOLD_HOUSE_LG_01", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_ffdee32fdb845315(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_merc_stronghold_cs";
  s.name = "ai_encounter_spawnpoint_reinforcements";
  s.script_parameters = "merc_stronghold_f_rural_shop_md_01_reinforcements";
  fe[[f]](s, us, cf, (34286.5, -197, 2394), (0, 180.2, 0), undefined, "STRONGHOLD_RURAL_SHOP_MD_01", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_merc_stronghold_cs";
  s.name = "Main";
  fe[[f]](s, us, cf, (34584.5, 762, 2671.73), (0, 0, 0), "MERC_STRONGHOLD_F_RURAL_SHOP_MD_01_main", "STRONGHOLD_RURAL_SHOP_MD_01", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_merc_stronghold_cs";
  s.name = "script_struct_safe";
  s.script_parameters = "auto_floor_2_saferoom";
  fe[[f]](s, us, cf, (34711.7, 841.25, 2535.73), (0, 181.94, 0), undefined, "STRONGHOLD_RURAL_SHOP_MD_01", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_beda053eee3066a7(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_merc_stronghold_cs";
  s.name = "ai_encounter_spawnpoint_reinforcements";
  s.script_parameters = "merc_stronghold_f_rural_packing_building_01_reinforcements";
  fe[[f]](s, us, cf, (41297, -3180, 2979.55), (0, 300.3, 0), undefined, "MERC_STRONGHOLD_RURAL_PACKING_BUILDING_01", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (41972.5, -4695.5, 3366.03), (0, 0, 0), "MERC_STRONGHOLD_F_RURAL_PACKING_BUILDING_01_main", "MERC_STRONGHOLD_RURAL_PACKING_BUILDING_01", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_merc_stronghold_cs";
  s.name = "script_struct_safe";
  s.script_parameters = "auto_floor_2_saferoom";
  fe[[f]](s, us, cf, (42421.7, -3998.75, 3128), (0, 180.03, 0), undefined, "MERC_STRONGHOLD_RURAL_PACKING_BUILDING_01", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_502147fe51d64d45(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_merc_stronghold_cs";
  s.name = "ai_encounter_spawnpoint_reinforcements";
  s.script_parameters = "merc_stronghold_f_rural_house_md_2s_06_abandoned_reinforcements";
  fe[[f]](s, us, cf, (41818.5, 13985.5, 3242.12), (0, 207.91, 0), undefined, "MERC_STRONGHOLD_RURAL_HOUSE_MD_2S_06_ABANDONED", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_merc_stronghold_cs";
  s.name = "script_struct_safe";
  s.script_parameters = "auto_floor_2_saferoom";
  fe[[f]](s, us, cf, (41007.7, 14404.7, 3394.2), (0, 318.78, 0), undefined, "MERC_STRONGHOLD_RURAL_HOUSE_MD_2S_06_ABANDONED", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (41212, 14375.5, 3544.2), (0, 0, 0), "MERC_STRONGHOLD_F_RURAL_HOUSE_MD_2S_06_ABANDONED_main", "MERC_STRONGHOLD_RURAL_HOUSE_MD_2S_06_ABANDONED", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6faadfd7e3c85e22(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_merc_stronghold_cs";
  s.name = "ai_encounter_spawnpoint_reinforcements";
  s.script_parameters = "merc_stronghold_f_rural_house_md_2s_06_reinforcements";
  fe[[f]](s, us, cf, (27649.5, 10021.5, 1928), (0, 0, 0), undefined, "MERC_STRONGHOLD_RURAL_HOUSE_MD_2S_06", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_merc_stronghold_cs";
  s.name = "script_struct_safe";
  s.script_parameters = "auto_floor_2_saferoom";
  fe[[f]](s, us, cf, (28218.7, 10249.2, 2084), (0, 144.3, 0), undefined, "MERC_STRONGHOLD_RURAL_HOUSE_MD_2S_06", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (28408, 10328, 2232), (0, 0, 0), "MERC_STRONGHOLD_F_RURAL_HOUSE_MD_2S_06_main", "MERC_STRONGHOLD_RURAL_HOUSE_MD_2S_06", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6faadcd7e3c85789(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_merc_stronghold_cs";
  s.name = "ai_encounter_spawnpoint_reinforcements";
  s.script_parameters = "merc_stronghold_f_rural_house_md_2s_03_reinforcements";
  fe[[f]](s, us, cf, (27765, -1739.5, 2264.3), (0, 326.01, 0), undefined, "MERC_STRONGHOLD_RURAL_HOUSE_MD_2S_03", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_merc_stronghold_cs";
  s.name = "script_struct_safe";
  s.script_parameters = "auto_floor_2_saferoom";
  fe[[f]](s, us, cf, (27074.7, -1876.8, 2501.4), (0, 230, 0), undefined, "MERC_STRONGHOLD_RURAL_HOUSE_MD_2S_03", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (27036, -2103.5, 2645.4), (0, 0, 0), "MERC_STRONGHOLD_F_RURAL_HOUSE_MD_2S_03_main", "MERC_STRONGHOLD_RURAL_HOUSE_MD_2S_03", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_5df0b353a8fdc00b(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_merc_stronghold_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (24468.5, -14968, 3101), (0, 0, 0), "MERC_STRONGHOLD_F_POLICE_STATION_01_main", "STRONGHOLD_POLICE_STATION_01", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_merc_stronghold_cs";
  s.name = "script_struct_safe";
  s.script_parameters = "auto_floor_2_saferoom";
  fe[[f]](s, us, cf, (24437.2, -15181.8, 2965), (0, 90, 0), undefined, "STRONGHOLD_POLICE_STATION_01", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_activities_merc_stronghold_cs";
  s.name = "ai_encounter_spawnpoint_reinforcements";
  s.script_parameters = "merc_stronghold_f_police_station_01_reinforcements";
  fe[[f]](s, us, cf, (25144.5, -15315, 2795), (0, 102.83, 0), undefined, "STRONGHOLD_POLICE_STATION_01", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_f_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (31821.2, 1918.5, 2550);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(31798.3, 1890.25, 2285.75)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1500];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(31944, 1863, 2240)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [1000];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(31798.3, 1890.25, 2285.75)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1000];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(31916.8, 1910.75, 2285.75)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [400];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(31872, 1853, 2272)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.locationorigin = [(31798.2, 1890.25, 2285.75)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_F_HOUSE_LG_01"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_f_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (34633.2, 791, 2767.73);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(34571.3, 736.75, 2448.73)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1500];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(34833, 731, 2385.34)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [1000];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(34560.3, 737.75, 2428.73)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1000];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(34629.6, 702.25, 2454.73)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [500];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(34761, 721, 2385.45)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.locationorigin = [(34560.2, 737.75, 2516.73)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_F_RURAL_SHOP_MD_01"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_f_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (41953.2, -4698.5, 3584.45);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(42085.3, -4729.25, 2992)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1500];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(42025, -4701.5, 2992)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [1000];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(41848, -4679, 2992)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(42012.8, -4726.75, 2992)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1000];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(42019.6, -4642, 2992)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [1150];
  instancestruct.locationorigin = [(42209.7, -4528.75, 2992)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_F_RURAL_PACKING_BUILDING_01"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_f_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (41230.7, 14386, 3659.2);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(41145.8, 14308.8, 3394.2)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1200];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(41326, 14229, 3250.2)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [1000];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(41254, 14219, 3250.2)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(41310.8, 14469.8, 3301.92)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [900];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(41309.6, 14351.2, 3243.76)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [400];
  instancestruct.locationorigin = [(41142.7, 14301.8, 3250.2)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_F_RURAL_HOUSE_MD_2S_06_ABANDONED"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_f_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (28289.2, 10315.5, 2388.5);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(28402.3, 10310.8, 1956)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1200];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(28232, 10355, 1956)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [1000];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(28160, 10345, 1933.29)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(28382.3, 10235.8, 1954)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [900];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(28368.6, 10285.7, 1926.41)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [400];
  instancestruct.locationorigin = [(28399.2, 10303.8, 1940)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_F_RURAL_HOUSE_MD_2S_06"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_f_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (27071.7, -2128, 2696.9);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(27031.8, -2232.2, 2357.4)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1200];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(27027, -2190, 2357.4)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [1000];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(26955, -2200, 2357.4)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(27015.8, -2220.2, 2264.56)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [900];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(27035.5, -2155.5, 2384)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [450];
  instancestruct.locationorigin = [(26962.7, -2240.2, 2357.4)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_F_RURAL_HOUSE_MD_2S_03"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_f_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (24574.2, -14952, 3207.5);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(24444.3, -14992.2, 2795)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1500];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(24513, -14957, 2795)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [1000];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(24441, -14967, 2795)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(24444.3, -14992.2, 2795)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1000];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(24571.8, -14964.8, 2795)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [800];
  instancestruct.locationorigin = [(24444.2, -14992.2, 2795)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_F_POLICE_STATION_01"] = instancestruct;
  return activityinstances;
}