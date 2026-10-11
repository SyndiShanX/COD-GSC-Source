/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2d94aeadc0e31021.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_a_ob_contracts_weapon_stash_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_a_ob_contracts_weapon_stash_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_a_ob_contracts_weapon_stash_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_a_ob_contracts_weapon_stash_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_a_ob_contracts_weapon_stash_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_a_ob_contracts_weapon_stash_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-35758, 44196, 1768), (0, 104.4, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-35828, 43941, 1766.52), (0, 194.4, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-35133, 44431, 1768), (0, 104.4, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-34944, 44315, 1768), (0, 14.4, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-35038, 43802, 1768), (0, 284.4, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-35271, 43701, 1768), (0, 284.4, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-35468, 43474, 1768), (0, 284.4, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-35335, 43874, 1908), (0, 104.4, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-35466, 43818, 1908), (0, 104.4, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-35258, 44193, 2044), (0, 104.4, 0), undefined, undefined, "ai_encounter_spawnpoint");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_a_ob_contracts_weapon_stash_cs");
}

function function_fd69cf02ba4d90a2() {
  activityinfostruct = spawnStruct();
  activityinfostruct.name = "REV_OB_WEAPON_STASH";
  activityinfostruct.scriptbundle = "jup_ob_activitydefinition_weapon_stash";
  activityinfostruct.mainfunction = &main;
  activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  activityinfostruct.metadatafunction = &function_6da2952367672ac0;
  return activityinfostruct;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_a_ob_contracts_weapon_stash_cs";
  }

  switch (instancename) {
    case #"hash_9f889ceddc025466":
      function_cfdfaf5b77cb4ae3(fe, us, cf);
      break;
    case #"hash_b84d9e6ee05b5da5":
      function_4c7f7d0622db8e90(fe, us, cf);
      break;
  }
}

function function_cfdfaf5b77cb4ae3(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-21671.8, 39272.5, 2095), (4.59, 143.59, 0.88), undefined, "WEAPON_STASH_A_APARTMENT_ABANDONED_MD_02", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-28379, 40701, 1607.25), (270, 184.56, 82.32), "activity_nexus_instance_joiner", undefined, "WEAPON_STASH_A_APARTMENT_ABANDONED_MD_02", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-24217.8, 39697.5, 1945.98), (1.79, 159.93, 4.88), undefined, "WEAPON_STASH_A_APARTMENT_ABANDONED_MD_02", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-24921.8, 40737, 1822.82), (357.1, 118.25, -10.19), undefined, "WEAPON_STASH_A_APARTMENT_ABANDONED_MD_02", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-21794.5, 37526.1, 1968.98), (4.53, 301.38, 23.69), undefined, "WEAPON_STASH_A_APARTMENT_ABANDONED_MD_02", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_weapon_stash_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-23834, 41533.2, 2096), (0, 207.9, 0), undefined, "WEAPON_STASH_A_APARTMENT_ABANDONED_MD_02", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-23850.5, 39149.5, 2236), (0, 45.12, 0), undefined, "WEAPON_STASH_A_APARTMENT_ABANDONED_MD_02", "weaponstash_safe", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-23724.1, 39200.1, 2236), (0, 0, 0), undefined, "WEAPON_STASH_A_APARTMENT_ABANDONED_MD_02", "weaponstash_rift", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_4c7f7d0622db8e90(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-35787.6, 44211, 1768), (0, 0, 0), undefined, "WEAPON_STASH_A_HOUSE_ABANDONED_LG_01", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-35494.7, 42886.1, 1765.41), (0, 0, 0), undefined, "WEAPON_STASH_A_HOUSE_ABANDONED_LG_01", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-34476.7, 44697.6, 1723.43), (0, 0, 0), undefined, "WEAPON_STASH_A_HOUSE_ABANDONED_LG_01", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-36941.3, 43493.4, 1768), (0, 0, 0), undefined, "WEAPON_STASH_A_HOUSE_ABANDONED_LG_01", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-36206.1, 42529.8, 1768.89), (0, 0, 0), undefined, "WEAPON_STASH_A_HOUSE_ABANDONED_LG_01", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_weapon_stash_cs";
  s.var_e1c68d186b8918b5 = "MERC_STRONGHOLD_TEST";
  s.var_5b6c0bbb3c3e9362 = "ZOMBIE_STRONGHOLD_F_RURAL_SHOP_MD";
  fe[[f]](s, us, cf, (-35461.6, 44011.3, 1772), (0, 18.71, 0), undefined, "WEAPON_STASH_A_HOUSE_ABANDONED_LG_01", "weaponstash_safe", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-35225, 44014.1, 1772), (0, 0, 0), undefined, "WEAPON_STASH_A_HOUSE_ABANDONED_LG_01", "weaponstash_rift", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-34239.6, 40464.8, 1543.75), (270, 0, 152.89), "activity_nexus_instance_joiner", undefined, "WEAPON_STASH_A_HOUSE_ABANDONED_LG_01", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_weapon_stash";
  instancestruct.cf = "mp_jup_st_a_ob_contracts_weapon_stash_cs";
  instancestruct.scriptstructorigin = (-23537.8, 39138.8, 2100);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-23849, 39176, 2236)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [200];
  activityinstances["WEAPON_STASH_A_APARTMENT_ABANDONED_MD_02"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_weapon_stash";
  instancestruct.cf = "mp_jup_st_a_ob_contracts_weapon_stash_cs";
  instancestruct.scriptstructorigin = (-35685.8, 43893.2, 1924);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-35476.5, 44008.5, 1764.88)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [200];
  activityinstances["WEAPON_STASH_A_HOUSE_ABANDONED_LG_01"] = instancestruct;
  return activityinstances;
}