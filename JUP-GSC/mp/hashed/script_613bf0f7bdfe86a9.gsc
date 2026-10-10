/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_613bf0f7bdfe86a9.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_e_ob_activities_merc_stronghold_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_e_ob_activities_merc_stronghold_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_e_ob_activities_merc_stronghold_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_e_ob_activities_merc_stronghold_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_e_ob_activities_merc_stronghold_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_e_ob_activities_merc_stronghold_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_e_ob_activities_merc_stronghold_cs");
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
    cf = "mp_jup_st_e_ob_activities_merc_stronghold_cs";
  }

  switch (instancename) {
    case #"hash_357226ec8b17bae3":
      function_93521ccc7663989e(fe, us, cf);
      break;
    case #"hash_a02ed0d3d11f8d7d":
      function_e6554b854e0708d2(fe, us, cf);
      break;
    case #"hash_862011ebad69a0f8":
      function_d3bcc436691ca1e1(fe, us, cf);
      break;
    case #"hash_9d258182a058ec93":
      function_f40f2b413f50253a(fe, us, cf);
      break;
    case #"hash_38e9735b07767828":
      function_c7be2735fb0ee49d(fe, us, cf);
      break;
    case #"hash_a02ec8d3d11f80e5":
      function_e65553854e071a6a(fe, us, cf);
      break;
    case #"hash_a02ecfd3d11f8bea":
      function_e6554c854e070b05(fe, us, cf);
      break;
  }
}

function function_93521ccc7663989e(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (-17573.3, 4478.5, 1287.21), (0, 0, 0), "MERC_STRONGHOLD_E_OFFICE_MD_02_main", "MERC_STRONGHOLD_OFFICE_MD_02", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_stronghold_cs";
  s.script_parameters = "auto_floor_2_safe_rooms";
  fe[[f]](s, us, cf, (-17778, 4248, 1416), (0, 90, 0), undefined, "MERC_STRONGHOLD_OFFICE_MD_02", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_stronghold_cs";
  s.name = "ai_encounter_spawnpoint_reinforcements";
  s.script_parameters = "merc_stronghold_e_office_md_02_reinforcements";
  fe[[f]](s, us, cf, (-17022, 4998, 1272), (0, 0, 0), undefined, "MERC_STRONGHOLD_OFFICE_MD_02", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_e6554b854e0708d2(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (20143.1, -1888.7, 2026.41), (0, 349.84, 0), "MERC_STRONGHOLD_E_LOW_TOWN_18_main", "MERC_STRONGHOLD_LOW_TOWN_18", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_stronghold_cs";
  s.script_parameters = "auto_floor_2";
  fe[[f]](s, us, cf, (20064, -2088, 2155.94), (0, 77.39, 0), undefined, "MERC_STRONGHOLD_LOW_TOWN_18", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_stronghold_cs";
  s.name = "ai_encounter_spawnpoint_reinforcements";
  s.script_parameters = "merc_stronghold_e_low_town_18_reinforcements";
  fe[[f]](s, us, cf, (19405, -1729.5, 1986.83), (0, 13.29, 0), undefined, "MERC_STRONGHOLD_LOW_TOWN_18", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_d3bcc436691ca1e1(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (-8699.25, 6703.78, 1066.84), (0, 0, 0), "MERC_STRONGHOLD_E_WAREHOUSE_IND_02_main", "MERC_STRONGHOLD_WAREHOUSE_IND_02", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_stronghold_cs";
  s.script_parameters = "auto_warehouse_safe_room";
  fe[[f]](s, us, cf, (-8168, 7620, 1060), (0, 50.15, 0), undefined, "MERC_STRONGHOLD_WAREHOUSE_IND_02", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_stronghold_cs";
  s.name = "ai_encounter_spawnpoint_reinforcements";
  s.script_parameters = "merc_stronghold_e_warehouse_ind_02_reinforcements";
  fe[[f]](s, us, cf, (-8520.24, 7996.32, 1061), (0, 0, 0), undefined, "MERC_STRONGHOLD_WAREHOUSE_IND_02", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_f40f2b413f50253a(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (-13383.8, 12075.2, 1283.37), (0, 0, 0), "MERC_STRONGHOLD_E_OFFICE_LG_02_main", "MERC_STRONGHOLD_OFFICE_LG_02", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_stronghold_cs";
  s.script_parameters = "auto_office_large_floor_2_safe_room";
  fe[[f]](s, us, cf, (-13986, 11844, 1412), (0, 0, 0), undefined, "MERC_STRONGHOLD_OFFICE_LG_02", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_stronghold_cs";
  s.name = "ai_encounter_spawnpoint_reinforcements";
  s.script_parameters = "merc_stronghold_e_office_lg_02_reinforcements";
  fe[[f]](s, us, cf, (-13657.2, 11140.6, 1282.92), (0, 0, 0), undefined, "MERC_STRONGHOLD_OFFICE_LG_02", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_c7be2735fb0ee49d(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (20651.8, 890.54, 2056.12), (0, 343.05, 0), "MERC_STRONGHOLD_E_LOW_TOWN15_B_main", "MERC_STRONGHOLD_LOW_TOWN15_B", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_stronghold_cs";
  s.script_parameters = "auto_floor_2_safe_room";
  fe[[f]](s, us, cf, (20695, 798, 2185), (0, 79.65, 0), undefined, "MERC_STRONGHOLD_LOW_TOWN15_B", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_stronghold_cs";
  s.name = "ai_encounter_spawnpoint_reinforcements";
  s.script_parameters = "merc_stronghold_e_low_town15_b_reinforcements";
  fe[[f]](s, us, cf, (20501.2, 2170.28, 1981.68), (0, 4.83, 0), undefined, "MERC_STRONGHOLD_LOW_TOWN15_B", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0), 256);
}

function function_e65553854e071a6a(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (21823.8, -5131.96, 2552), (0, 343.05, 0), "MERC_STRONGHOLD_E_LOW_TOWN_10_main", "MERC_STRONGHOLD_LOW_TOWN_10", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_stronghold_cs";
  s.name = "script_struct_safe";
  s.script_parameters = "auto_floor_2";
  fe[[f]](s, us, cf, (21595.5, -4965.12, 2392), (0, 0, 0), undefined, "MERC_STRONGHOLD_LOW_TOWN_10", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_stronghold_cs";
  s.name = "ai_encounter_spawnpoint_reinforcements";
  s.script_parameters = "merc_stronghold_e_low_town_10_reinforcements";
  fe[[f]](s, us, cf, (22278.3, -4839.02, 2262.4), (0, 4.83, 0), undefined, "MERC_STRONGHOLD_LOW_TOWN_10", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_e6554c854e070b05(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (18192.8, -2945.96, 1816.98), (0, 343.05, 0), "MERC_STRONGHOLD_E_LOW_TOWN_19_main", "MERC_STRONGHOLD_LOW_TOWN_19", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_stronghold_cs";
  s.name = "script_struct_safe";
  s.script_parameters = "auto_floor_2_safe";
  fe[[f]](s, us, cf, (17995.5, -2785.5, 1957), (0, 249, 0), undefined, "MERC_STRONGHOLD_LOW_TOWN_19", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_merc_stronghold_cs";
  s.name = "ai_encounter_spawnpoint_reinforcements";
  s.script_parameters = "merc_stronghold_e_low_town_19_reinforcements";
  fe[[f]](s, us, cf, (18828.7, -3459.65, 1864), (0, 5.32, 0), undefined, "MERC_STRONGHOLD_LOW_TOWN_19", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_e_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (-17452, 4532, 1680);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(-17532.2, 4454.12, 1295.38)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1200];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(-17382.3, 4512.32, 1281.25)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(-17457.4, 4458.37, 1280.25)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [500];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(-17532.2, 4454.12, 1295.38)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1200];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(-17325.7, 4454.12, 1295.38)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [600];
  instancestruct.locationorigin = [(-17532.2, 4454.12, 1295.38)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_E_OFFICE_MD_02"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_e_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (20092, -1812, 2444);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(20142, -1882.97, 2034.66)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1200];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(20214.2, -1818.76, 2035.75)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(20080.8, -1851.38, 2015.41)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [400];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(20135.2, -1879.24, 2033.16)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1200];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(20080.2, -1846.32, 2019.41)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [450];
  instancestruct.locationorigin = [(20140.6, -1877.63, 2034.16)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_E_LOW_TOWN_18"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_e_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (-8412, 7108, 1488);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(-8533.68, 6818.75, 1072.5)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1600];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(-8605.68, 7196.75, 1072.5)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(-8417.68, 6900.75, 1072.5)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [1250];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(-8522.75, 6850.87, 1072.38)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1600];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(-8377.11, 6951.25, 1065.98)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [1350];
  instancestruct.locationorigin = [(-8696, 6704.12, 1070.63)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_E_WAREHOUSE_IND_02"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_e_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (-13256, 12124, 1676);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(-13334, 12113.9, 1276)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1200];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(-13244.7, 12420.4, 1250)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(-13296.7, 12132.6, 1258)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [770];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(-13334, 12113.9, 1276)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1200];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(-13233, 12113.9, 1276)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [950];
  instancestruct.locationorigin = [(-13334, 12113.9, 1276)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_E_OFFICE_LG_02"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_e_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (20816, 1224, 2452);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(20647.1, 881.25, 2064.97)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1200];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(20856.5, 1188.11, 2097)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(20871.6, 1210.23, 2056.97)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [500];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(20648.4, 888.76, 2063.37)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1200];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(20796.1, 1212.66, 2064.62)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [550];
  instancestruct.locationorigin = [(20650.1, 889.49, 2064.37)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_E_LOW_TOWN15_B"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_e_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (21820, -5140, 2680);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(21794.6, -5070.25, 2392)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1200];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(21821.5, -5099.73, 2281)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(21790.7, -5121.37, 2259.5)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [400];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(21844.9, -5075.24, 2392)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [900];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(21840.1, -5115.09, 2280)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [400];
  instancestruct.locationorigin = [(21798.1, -5081.01, 2392)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_E_LOW_TOWN_10"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_e_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (18068, -3000, 2356);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(18150.6, -3008.25, 1813.03)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1200];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(18138.8, -2983.54, 1770.98)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(18101.8, -3056.6, 1768.3)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [500];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(18130.9, -3034.24, 1813.47)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [900];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(18139.1, -3024.09, 1813.07)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [400];
  instancestruct.locationorigin = [(18112.1, -3069.01, 1812.99)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_E_LOW_TOWN_19"] = instancestruct;
  return activityinstances;
}