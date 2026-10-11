/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_667c4ce876dfa4a9.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_a_ob_activities_merc_stronghold_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_a_ob_activities_merc_stronghold_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_a_ob_activities_merc_stronghold_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_a_ob_activities_merc_stronghold_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_a_ob_activities_merc_stronghold_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_a_ob_activities_merc_stronghold_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_a_ob_activities_merc_stronghold_cs");
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
    cf = "mp_jup_st_a_ob_activities_merc_stronghold_cs";
  }

  switch (instancename) {
    case #"hash_ccc1209e1c9d8e76":
      function_c5967eb0ab661a81(fe, us, cf);
      break;
    case #"hash_5e7e8405f9c48391":
      function_42ef57df9e29b166(fe, us, cf);
      break;
    case #"hash_4a2a2b7602614224":
      function_91e6ecd1a9477d47(fe, us, cf);
      break;
    case #"hash_c627baa21d508ad9":
      function_6316ebd56a7444ac(fe, us, cf);
      break;
  }
}

function function_c5967eb0ab661a81(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_stronghold_cs";
  s.name = "spawn_heli_reinforcements";
  s.script_parameters = "merc_stronghold_a_apartment_abandoned_md_02_reinforcements";
  fe[[f]](s, us, cf, (-23135.8, 39551.1, 2086.37), (0, 0, 0), undefined, "MERC_STRONGHOLD_APARTMENT_ABANDONED_MD_02", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (-23552.3, 39123.5, 2099.88), (0, 0, 0), "MERC_STRONGHOLD_A_APARTMENT_ABANDONED_MD_02_main", "MERC_STRONGHOLD_APARTMENT_ABANDONED_MD_02", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_stronghold_cs";
  s.script_parameters = "auto_floor_2";
  fe[[f]](s, us, cf, (-23666.1, 39166.1, 2236), (0, 136, 0), undefined, "MERC_STRONGHOLD_APARTMENT_ABANDONED_MD_02", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_42ef57df9e29b166(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_stronghold_cs";
  s.name = "spawn_heli_reinforcements";
  s.script_parameters = "merc_stronghold_a_store_abandoned_lg_02_reinforcements";
  fe[[f]](s, us, cf, (-23372.2, 18540.6, 1514.94), (0, 0, 0), undefined, "MERC_STRONGHOLD_STORE_ABANDONED_LG_02", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (-22881.5, 17646.5, 1520), (0, 0, 0), "MERC_STRONGHOLD_A_STORE_ABANDONED_LG_02_main", "MERC_STRONGHOLD_STORE_ABANDONED_LG_02", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_stronghold_cs";
  s.script_parameters = "auto_floor_2";
  fe[[f]](s, us, cf, (-22988.6, 17830.2, 1656), (0, 270, 0), undefined, "MERC_STRONGHOLD_STORE_ABANDONED_LG_02", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_91e6ecd1a9477d47(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_stronghold_cs";
  s.name = "spawn_heli_reinforcements";
  s.script_parameters = "merc_stronghold_a_store_abandoned_md_01_reinforcements";
  fe[[f]](s, us, cf, (-31639.2, 24198.1, 1272), (0, 0, 0), undefined, "MERC_STRONGHOLD_STORE_ABANDONED_MD_01", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (-32008.4, 23572.1, 1292), (0, 0, 0), "MERC_STRONGHOLD_A_STORE_ABANDONED_MD_01_main", "MERC_STRONGHOLD_STORE_ABANDONED_MD_01", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_stronghold_cs";
  s.script_parameters = "auto_floor_2_saferoom";
  fe[[f]](s, us, cf, (-31861.8, 23727.9, 1418), (0, 186, 0), undefined, "MERC_STRONGHOLD_STORE_ABANDONED_MD_01", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6316ebd56a7444ac(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_stronghold_cs";
  s.name = "spawn_heli_reinforcements";
  s.script_parameters = "merc_stronghold_a_apartment_24_reinforcements";
  fe[[f]](s, us, cf, (-28665.2, 43607.9, 1680), (0, 0, 0), undefined, "MERC_STRONGHOLD_APARTMENT_24", "s_safe_reinforce", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_stronghold_cs";
  fe[[f]](s, us, cf, (-28659.3, 42291.8, 1558), (0, 0, 0), "MERC_STRONGHOLD_A_APARTMENT_24_main", "MERC_STRONGHOLD_APARTMENT_24", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_merc_stronghold_cs";
  s.script_parameters = "auto_floor_2";
  fe[[f]](s, us, cf, (-28716.9, 41994.1, 1694), (0, 64, 0), undefined, "MERC_STRONGHOLD_APARTMENT_24", "s_safe_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_a_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (-23552.3, 39123.5, 2636);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(-23552.3, 39123.5, 2099.88)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1700];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(-23552.3, 39123.5, 2099.88)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(-23552.3, 39123.5, 2099.88)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [800];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(-23552.3, 39123.5, 2099.88)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [600];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(-23552.3, 39123.5, 2099.88)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1200];
  instancestruct.locationorigin = [(-23552.3, 39123.5, 2099.88)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1700];
  activityinstances["MERC_STRONGHOLD_A_APARTMENT_ABANDONED_MD_02"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_a_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (-22881.5, 17646.5, 2056);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(-22881.5, 17646.5, 1520)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1700];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(-22881.5, 17646.5, 1520)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(-22881.5, 17646.5, 1520)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [500];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(-22881.5, 17646.5, 1520)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [500];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(-22881.5, 17646.5, 1520)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1200];
  instancestruct.locationorigin = [(-22881.5, 17646.5, 1520)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1700];
  activityinstances["MERC_STRONGHOLD_A_STORE_ABANDONED_LG_02"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_a_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (-32009.1, 23571.8, 1682);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(-32009.1, 23571.8, 1292)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [1500];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(-32009.1, 23571.8, 1292)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(-32009.1, 23571.8, 1292)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [600];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(-32009.1, 23571.8, 1292)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1000];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(-32009.1, 23571.8, 1292)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [400];
  instancestruct.locationorigin = [(-32009.1, 23571.8, 1292)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1500];
  activityinstances["MERC_STRONGHOLD_A_STORE_ABANDONED_MD_01"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_merc_stronghold";
  instancestruct.cf = "mp_jup_st_a_ob_activities_merc_stronghold_cs";
  instancestruct.scriptstructorigin = (-28659.3, 42291.8, 2230);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(-28659.3, 42291.8, 1558)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationorigin = [(-28659.3, 42291.8, 1558)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_approach"].locationradius = [2000];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationorigin = [(-28659.3, 42291.8, 1558)];
  instancestruct.var_5b156d1fa702b37f["handler_comms_nokey"].locationradius = [610];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationorigin = [(-28659.3, 42291.8, 1558)];
  instancestruct.var_5b156d1fa702b37f["ai_exclusion_radius"].locationradius = [1000];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(-28659.3, 42291.8, 1558)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [1500];
  instancestruct.locationorigin = [(-28659.3, 42291.8, 1558)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2000];
  activityinstances["MERC_STRONGHOLD_A_APARTMENT_24"] = instancestruct;
  return activityinstances;
}