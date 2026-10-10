/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2703bdfefbaf543d.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_c_ob_contracts_weapon_stash_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_c_ob_contracts_weapon_stash_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_c_ob_contracts_weapon_stash_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_c_ob_contracts_weapon_stash_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_c_ob_contracts_weapon_stash_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_c_ob_contracts_weapon_stash_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "barracks_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (24033, 23014, 1519), (0, 90, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "barracks_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (23814, 23271, 1519), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "barracks_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (25390, 23270, 1519), (0, 90, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "barracks_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (24976, 23104, 1519), (0, 90, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "barracks_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (24738, 23153, 1383), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (24196, 21596.8, 1349), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "barracks_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (24737, 23182, 1655), (0, 180, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "barracks_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (24343, 23127, 1655), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "barracks_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (23884, 23437, 1447), (0, 270, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "station_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (32594, 38190, 1080), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "station_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (32192, 38363, 1224), (0, 180, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "station_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (32217, 38119, 1032), (0, 270, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "station_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (32012, 38604, 1032), (0, 90, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "station_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (32182, 38820, 1032), (0, 90, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "station_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (32516, 37924, 1080), (0, 270, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "station_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (32159, 38236, 1032), (0, 90, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "station_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (32473, 38431, 1224), (0, 180, 0), undefined, undefined, "ai_encounter_spawnpoint");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_c_ob_contracts_weapon_stash_cs");
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
    cf = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  }

  switch (instancename) {
    case #"hash_88a6bcfe52f3da99":
      function_ecbab8e481fb1286(fe, us, cf);
      break;
    case #"hash_d0f58b47b6ab9541":
      function_f9c814c471f5cb9e(fe, us, cf);
      break;
  }
}

function function_ecbab8e481fb1286(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (31888.3, 37694.4, 1032), (0, 242.41, 0), undefined, "WEAPON_STASH_C_FIRE_STATION", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (32515.8, 39046.9, 928), (0, 242.41, 0), undefined, "WEAPON_STASH_C_FIRE_STATION", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (32875.2, 38742.9, 928), (0, 242.41, 0), undefined, "WEAPON_STASH_C_FIRE_STATION", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (32050.1, 39991.2, 1048), (0, 242.41, 0), undefined, "WEAPON_STASH_C_FIRE_STATION", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (33318.4, 38095.9, 886.16), (0, 242.41, 0), undefined, "WEAPON_STASH_C_FIRE_STATION", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  s.var_e1c68d186b8918b5 = "MERC_STRONGHOLD_TEST";
  s.var_5b6c0bbb3c3e9362 = "ZOMBIE_STRONGHOLD_F_RURAL_SHOP_MD";
  fe[[f]](s, us, cf, (32505.9, 38238.1, 1032), (0, 152.53, 0), undefined, "WEAPON_STASH_C_FIRE_STATION", "weaponstash_safe", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (32201.2, 38355.8, 1032), (0, 62.41, 0), undefined, "WEAPON_STASH_C_FIRE_STATION", "weaponstash_rift", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (28625.8, 34504.8, 1221), (270, 0, -70.05), "activity_nexus_instance_joiner", undefined, "WEAPON_STASH_C_FIRE_STATION", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (33006.8, 37248.6, 1032), (0, 242.41, 0), undefined, "WEAPON_STASH_C_FIRE_STATION", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (31393.8, 39572.4, 1041), (0, 242.41, 0), undefined, "WEAPON_STASH_C_FIRE_STATION", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (30864.6, 38442.1, 1032), (0, 242.41, 0), undefined, "WEAPON_STASH_C_FIRE_STATION", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
}

function function_f9c814c471f5cb9e(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (24482.2, 22556.3, 1347.24), (0, 180, 0), undefined, "WEAPON_STASH_C_MILBASE_BARRACKS", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (25161.2, 22559.3, 1345.74), (0, 180, 0), undefined, "WEAPON_STASH_C_MILBASE_BARRACKS", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (24036.9, 22566, 1348.26), (0, 180, 0), undefined, "WEAPON_STASH_C_MILBASE_BARRACKS", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (25052.9, 24353.7, 1350.2), (0, 180, 0), undefined, "WEAPON_STASH_C_MILBASE_BARRACKS", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (23764.7, 22889.8, 1359), (0, 180, 0), undefined, "WEAPON_STASH_C_MILBASE_BARRACKS", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  s.var_e1c68d186b8918b5 = "MERC_STRONGHOLD_TEST";
  s.var_5b6c0bbb3c3e9362 = "ZOMBIE_STRONGHOLD_F_RURAL_SHOP_MD";
  fe[[f]](s, us, cf, (24310.9, 23323.5, 1519), (0, 270, 0), undefined, "WEAPON_STASH_C_MILBASE_BARRACKS", "weaponstash_safe", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (24235.1, 23168.3, 1519), (0, 0, 0), undefined, "WEAPON_STASH_C_MILBASE_BARRACKS", "weaponstash_rift", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (23877.2, 20810.8, 1405.75), (270, 0, -117.11), "activity_nexus_instance_joiner", undefined, "WEAPON_STASH_C_MILBASE_BARRACKS", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (24396.7, 23614.3, 1350.2), (0, 180, 0), undefined, "WEAPON_STASH_C_MILBASE_BARRACKS", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (25300.7, 23708.3, 1354), (0, 180, 0), undefined, "WEAPON_STASH_C_MILBASE_BARRACKS", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_weapon_stash";
  instancestruct.cf = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  instancestruct.scriptstructorigin = (32505.9, 38238.1, 1032);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(32517, 38244, 1032)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [200];
  activityinstances["WEAPON_STASH_C_FIRE_STATION"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_weapon_stash";
  instancestruct.cf = "mp_jup_st_c_ob_contracts_weapon_stash_cs";
  instancestruct.scriptstructorigin = (24378.5, 23255, 1675.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(24313, 23308.5, 1519)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [200];
  activityinstances["WEAPON_STASH_C_MILBASE_BARRACKS"] = instancestruct;
  return activityinstances;
}