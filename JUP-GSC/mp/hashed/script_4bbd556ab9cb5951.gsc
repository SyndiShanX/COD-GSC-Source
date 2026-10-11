/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4bbd556ab9cb5951.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_i_ob_contracts_weapon_stash_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_i_ob_contracts_weapon_stash_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_i_ob_contracts_weapon_stash_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_i_ob_contracts_weapon_stash_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_i_ob_contracts_weapon_stash_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_i_ob_contracts_weapon_stash_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "autobody_spawnpoitns";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (22530, -21149, 2881.86), (0, 180, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "stables_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (41455.5, -23986, 3136), (0, 90, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "stables_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (40725, -23421, 3136), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "stables_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (41340, -23567, 3136), (0, 90, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "stables_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (40459, -23065, 3136), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "stables_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (40491.5, -23301, 3136), (0, 180, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "stables_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (41643.5, -23260.5, 3133), (0, 90, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "stables_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (41098.5, -22612.5, 3136), (0, 180, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "autobody_spawnpoitns";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (22799.5, -21618, 2886), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "autobody_spawnpoitns";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (22679.5, -20697, 2886), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "autobody_spawnpoitns";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (23091.5, -20420.5, 2882), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "autobody_spawnpoitns";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (23352.5, -21167.5, 2881.91), (0, 14.87, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "autobody_spawnpoitns";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (22984, -21773.5, 2882), (0, 290.8, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "autobody_spawnpoitns";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (22561.5, -21583.5, 2881.5), (0, 90, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "autobody_spawnpoitns";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (22763, -20526, 2882), (0, 197.55, 0), undefined, undefined, "ai_encounter_spawnpoint");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_i_ob_contracts_weapon_stash_cs");
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
    cf = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  }

  switch (instancename) {
    case #"hash_56b83552f20e80d4":
      function_206c0256c360c795(fe, us, cf);
      break;
    case #"hash_7df2a63098f5baab":
      function_439718c694ce84f4(fe, us, cf);
      break;
  }
}

function function_206c0256c360c795(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (40328.6, -24052.1, 3126.54), (0, 122.21, 0), undefined, "WEAPON_STASH_I_STABLES", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (42675.1, -23897.1, 3136), (0, 122.21, 0), undefined, "WEAPON_STASH_I_STABLES", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (42808.9, -22326.4, 3135.25), (0, 122.21, 0), undefined, "WEAPON_STASH_I_STABLES", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (40932.9, -21281.2, 3124.63), (0, 122.21, 0), undefined, "WEAPON_STASH_I_STABLES", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (39378.9, -22759.8, 3127.43), (0, 122.21, 0), undefined, "WEAPON_STASH_I_STABLES", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  s.var_e1c68d186b8918b5 = "MERC_STRONGHOLD_TEST";
  s.var_5b6c0bbb3c3e9362 = "ZOMBIE_STRONGHOLD_F_RURAL_SHOP_MD";
  fe[[f]](s, us, cf, (41250.8, -22737.8, 3136), (0, 209.57, 0), undefined, "WEAPON_STASH_I_STABLES", "weaponstash_safe", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (41005.6, -22891.8, 3136), (0, 122.21, 0), undefined, "WEAPON_STASH_I_STABLES", "weaponstash_rift", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (38860.5, -21495.2, 3077.5), (270, 107.77, 170.65), "activity_nexus_instance_joiner", undefined, "WEAPON_STASH_I_STABLES", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_439718c694ce84f4(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (24535.7, -20308.3, 3014.5), (0, 17.85, 0), undefined, "WEAPON_STASH_I_AUTOBODY", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (22682.3, -19918.7, 2881.86), (0, 17.85, 0), undefined, "WEAPON_STASH_I_AUTOBODY", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (21375.3, -22110.1, 2881.65), (0, 17.85, 0), undefined, "WEAPON_STASH_I_AUTOBODY", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (23746.7, -21964.8, 2994.24), (0, 17.85, 0), undefined, "WEAPON_STASH_I_AUTOBODY", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (21545, -20272.3, 2881.86), (0, 17.85, 0), undefined, "WEAPON_STASH_I_AUTOBODY", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  s.var_e1c68d186b8918b5 = "MERC_STRONGHOLD_TEST";
  s.var_5b6c0bbb3c3e9362 = "ZOMBIE_STRONGHOLD_F_RURAL_SHOP_MD";
  fe[[f]](s, us, cf, (23145.7, -21401, 2886), (0, 107.85, 0), undefined, "WEAPON_STASH_I_AUTOBODY", "weaponstash_safe", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (23219.4, -21146.8, 2886), (0, 107.85, 0), undefined, "WEAPON_STASH_I_AUTOBODY", "weaponstash_rift", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (18929, -23506.5, 2787.38), (270, 0, -75.31), "activity_nexus_instance_joiner", undefined, "WEAPON_STASH_I_AUTOBODY", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_weapon_stash";
  instancestruct.cf = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  instancestruct.scriptstructorigin = (41147.3, -22689.4, 3152);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(41247, -22735, 3136)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [200];
  activityinstances["WEAPON_STASH_I_STABLES"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_weapon_stash";
  instancestruct.cf = "mp_jup_st_i_ob_contracts_weapon_stash_cs";
  instancestruct.scriptstructorigin = (23256.1, -21361.2, 2902);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(23138, -21386, 2886)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [200];
  activityinstances["WEAPON_STASH_I_AUTOBODY"] = instancestruct;
  return activityinstances;
}