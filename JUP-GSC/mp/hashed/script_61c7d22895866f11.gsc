/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_61c7d22895866f11.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_b_ob_contracts_weapon_stash_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_b_ob_contracts_weapon_stash_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_b_ob_contracts_weapon_stash_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_b_ob_contracts_weapon_stash_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_b_ob_contracts_weapon_stash_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_b_ob_contracts_weapon_stash_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "thermal_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-4142, 38136, 1320), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "thermal_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-4480, 37921, 1320), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "thermal_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-4541, 37347, 1320), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "thermal_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-4435, 37573, 1320), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "thermal_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-3395, 37245, 1326), (0, 180, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "thermal_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-2774, 37922, 1320), (0, 270, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "thermal_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-3121, 37808, 1544), (0, 180, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "thermal_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-4387, 37961, 1544), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "warehouse_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (10626, 32626, 1200), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "warehouse_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (10267, 32948, 1199.99), (0, 180, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "warehouse_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (10196, 33223, 1200), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "warehouse_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (10467, 33395, 1200), (0, 270, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "warehouse_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (10897, 32773, 1209), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "warehouse_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (10376, 33476, 1200), (0, 180, 0), undefined, undefined, "ai_encounter_spawnpoint");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_b_ob_contracts_weapon_stash_cs");
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
    cf = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  }

  switch (instancename) {
    case #"hash_54d122654fd09c98":
      function_a3b690964f6750b1(fe, us, cf);
      break;
    case #"hash_cee75d6728a96c07":
      function_391435c42faa1044(fe, us, cf);
      break;
  }
}

function function_a3b690964f6750b1(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-5032, 37082.5, 1334.92), (0, 0, 0), undefined, "WEAPON_STASH_B_THERMAL_PLANT", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-2437, 37546, 1544), (0, 0, 0), undefined, "WEAPON_STASH_B_THERMAL_PLANT", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-1997.5, 37201.5, 1318), (0, 0, 0), undefined, "WEAPON_STASH_B_THERMAL_PLANT", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-4044, 39066, 1347.42), (0, 0, 0), undefined, "WEAPON_STASH_B_THERMAL_PLANT", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  s.var_e1c68d186b8918b5 = "MERC_STRONGHOLD_TEST";
  s.var_5b6c0bbb3c3e9362 = "ZOMBIE_STRONGHOLD_F_RURAL_SHOP_MD";
  fe[[f]](s, us, cf, (-3365.2, 37380.8, 1320), (0, 94.15, 0), undefined, "WEAPON_STASH_B_THERMAL_PLANT", "weaponstash_safe", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-3357.96, 37775.3, 1320), (0, 0, 0), undefined, "WEAPON_STASH_B_THERMAL_PLANT", "weaponstash_rift", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-2604.5, 36652.5, 1320), (0, 0, 0), undefined, "WEAPON_STASH_B_THERMAL_PLANT", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-600.55, 35925.8, 1357.55), (270, 0, 27.34), "activity_nexus_instance_joiner", undefined, "WEAPON_STASH_B_THERMAL_PLANT", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-4206.5, 37198.5, 1544), (0, 0, 0), undefined, "WEAPON_STASH_B_THERMAL_PLANT", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
}

function function_391435c42faa1044(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (9919.3, 33788.4, 1199.96), (0, 121.63, 0), undefined, "WEAPON_STASH_B_WAREHOUSE_SM", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (11186.2, 32398.6, 1081.47), (0, 121.63, 0), undefined, "WEAPON_STASH_B_WAREHOUSE_SM", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (10924, 31425.4, 1197.39), (0, 121.63, 0), undefined, "WEAPON_STASH_B_WAREHOUSE_SM", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (9442.7, 34025.6, 1199.96), (0, 121.63, 0), undefined, "WEAPON_STASH_B_WAREHOUSE_SM", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (9998.1, 31863.4, 1212.26), (0, 121.63, 0), undefined, "WEAPON_STASH_B_WAREHOUSE_SM", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  s.var_e1c68d186b8918b5 = "MERC_STRONGHOLD_TEST";
  s.var_5b6c0bbb3c3e9362 = "ZOMBIE_STRONGHOLD_F_RURAL_SHOP_MD";
  fe[[f]](s, us, cf, (10700.3, 33077.1, 1200), (0, 211.63, 0), undefined, "WEAPON_STASH_B_WAREHOUSE_SM", "weaponstash_safe", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (10462.3, 33154.1, 1200), (0, 121.63, 0), undefined, "WEAPON_STASH_B_WAREHOUSE_SM", "weaponstash_rift", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (7340.75, 31764.8, 1256.5), (270, 91.91, -71.81), "activity_nexus_instance_joiner", undefined, "WEAPON_STASH_B_WAREHOUSE_SM", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_weapon_stash";
  instancestruct.cf = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  instancestruct.scriptstructorigin = (-3365.2, 37380.8, 1320);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-3364, 37414, 1320)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [200];
  activityinstances["WEAPON_STASH_B_THERMAL_PLANT"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_weapon_stash";
  instancestruct.cf = "mp_jup_st_b_ob_contracts_weapon_stash_cs";
  instancestruct.scriptstructorigin = (10572, 33074, 1216);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(10699.5, 33076.5, 1200)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [200];
  activityinstances["WEAPON_STASH_B_WAREHOUSE_SM"] = instancestruct;
  return activityinstances;
}