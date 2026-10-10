/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2df25a70ec0cd221.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_e_ob_contracts_weapon_stash_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_e_ob_contracts_weapon_stash_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_e_ob_contracts_weapon_stash_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_e_ob_contracts_weapon_stash_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_e_ob_contracts_weapon_stash_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_e_ob_contracts_weapon_stash_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "plaza_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (6043, -5189, 2408), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "plaza_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (5691, -5525, 2408), (0, 270, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "plaza_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (6086, -5972, 2408), (0, 180, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "plaza_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (6250, -6367, 2392), (0, 270, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "plaza_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (5434, -5920, 2392), (0, 180, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "plaza_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (5755, -5069, 2408), (0, 180, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "plaza_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (6231, -5078, 2392), (0, 90, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "checkpoint_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-16101, 10312, 1272.3), (0, 270, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "checkpoint_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-15724, 10780, 1280), (0, 90, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "checkpoint_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-15668, 10670, 1280), (0, 270, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "checkpoint_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-15739, 10227, 1280), (0, 90, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "checkpoint_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-16117, 10627, 1272.55), (0, 90, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "checkpoint_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-15279, 10102, 1272), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_e_ob_contracts_weapon_stash_cs");
}

function function_fd69cf02ba4d90a2() {
  var_d13c18af4084bdfd = spawnStruct();
  var_d13c18af4084bdfd.name = "REV_OB_WEAPON_STASH";
  var_d13c18af4084bdfd.scriptbundle = "jup_ob_activitydefinition_weapon_stash";
  var_d13c18af4084bdfd.mainfunction = &main;
  var_d13c18af4084bdfd.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  var_d13c18af4084bdfd.var_ad1dcd56d202e9ac = &function_6da2952367672ac0;
  return var_d13c18af4084bdfd;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  }

  switch (instancename) {
    case #"hash_4820f9741f475cf3":
      function_d7e8342b1d47b208(fe, us, cf);
      break;
    case #"hash_b1e8465e60a62c42":
      function_9817fba9004b6a37(fe, us, cf);
      break;
  }
}

function function_d7e8342b1d47b208(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (4439.47, -5679.56, 2392), (0, 224.86, 0), undefined, "WEAPON_STASH_E_OLD_TOWN_PLAZA", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (5629.22, -6764.56, 2417.25), (0, 224.86, 0), undefined, "WEAPON_STASH_E_OLD_TOWN_PLAZA", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (6148.14, -3566.22, 2392), (0, 224.86, 0), undefined, "WEAPON_STASH_E_OLD_TOWN_PLAZA", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (4700.61, -4662.59, 2392), (0, 224.86, 0), undefined, "WEAPON_STASH_E_OLD_TOWN_PLAZA", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (7746.29, -6093.69, 2386.45), (0, 224.86, 0), undefined, "WEAPON_STASH_E_OLD_TOWN_PLAZA", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (7328.57, -5980.33, 2392), (0, 224.86, 0), undefined, "WEAPON_STASH_E_OLD_TOWN_PLAZA", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  s.var_e1c68d186b8918b5 = "MERC_STRONGHOLD_TEST";
  s.var_5b6c0bbb3c3e9362 = "ZOMBIE_STRONGHOLD_F_RURAL_SHOP_MD";
  fe[[f]](s, us, cf, (6567.36, -5854.97, 2408), (0, 137.24, 0), undefined, "WEAPON_STASH_E_OLD_TOWN_PLAZA", "weaponstash_safe", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (6310.4, -5673.75, 2408), (0, 224.86, 0), undefined, "WEAPON_STASH_E_OLD_TOWN_PLAZA", "weaponstash_rift", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (7732.5, -3650, 2441.25), (270, 60.3, 2.59), "activity_nexus_instance_joiner", undefined, "WEAPON_STASH_E_OLD_TOWN_PLAZA", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (7353.04, -7276.19, 2392), (0, 224.86, 0), undefined, "WEAPON_STASH_E_OLD_TOWN_PLAZA", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
}

function function_9817fba9004b6a37(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-15053.7, 9560.2, 1270), (0, 240.46, 0), undefined, "WEAPON_STASH_E_CHECKPOINT_MD", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-14629.8, 10826, 1271.96), (0, 240.46, 0), undefined, "WEAPON_STASH_E_CHECKPOINT_MD", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-16214, 9565.85, 1272), (0, 240.46, 0), undefined, "WEAPON_STASH_E_CHECKPOINT_MD", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-16651.2, 9913.15, 1277.05), (0, 240.46, 0), undefined, "WEAPON_STASH_E_CHECKPOINT_MD", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-14835.1, 11687.7, 1271.96), (0, 240.46, 0), undefined, "WEAPON_STASH_E_CHECKPOINT_MD", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-15627.9, 11724.7, 1276.19), (0, 240.46, 0), undefined, "WEAPON_STASH_E_CHECKPOINT_MD", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  s.var_e1c68d186b8918b5 = "MERC_STRONGHOLD_TEST";
  s.var_5b6c0bbb3c3e9362 = "ZOMBIE_STRONGHOLD_F_RURAL_SHOP_MD";
  fe[[f]](s, us, cf, (-15912.5, 10461.7, 1280), (0, 245.58, 0), undefined, "WEAPON_STASH_E_CHECKPOINT_MD", "weaponstash_safe", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-15918.5, 10645, 1280), (0, 120.53, 0), undefined, "WEAPON_STASH_E_CHECKPOINT_MD", "weaponstash_rift", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-15687.5, 9691.25, 1307.25), (270, 171.15, -66.56), "activity_nexus_instance_joiner", undefined, "WEAPON_STASH_E_CHECKPOINT_MD", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_weapon_stash";
  instancestruct.cf = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  instancestruct.scriptstructorigin = (6567.36, -5854.97, 2408);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(6572.5, -5845.5, 2408)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [200];
  activityinstances["WEAPON_STASH_E_OLD_TOWN_PLAZA"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_weapon_stash";
  instancestruct.cf = "mp_jup_st_e_ob_contracts_weapon_stash_cs";
  instancestruct.scriptstructorigin = (-15912.5, 10461.7, 1280);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-15910.5, 10456.5, 1280)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [200];
  activityinstances["WEAPON_STASH_E_CHECKPOINT_MD"] = instancestruct;
  return activityinstances;
}