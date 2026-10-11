/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_42a0824e4bcb7abd.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_d_ob_contracts_weapon_stash_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_d_ob_contracts_weapon_stash_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_d_ob_contracts_weapon_stash_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_d_ob_contracts_weapon_stash_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_d_ob_contracts_weapon_stash_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_d_ob_contracts_weapon_stash_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "strip_mall_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-33259, 1632, 963), (0, 180, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "strip_mall_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-32871, 810, 963), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "strip_mall_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-32931, 1423, 962.89), (0, 270, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "strip_mall_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-32891, 1915, 963), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "strip_mall_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-32573, 1683, 959.3), (0, 90, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "strip_mall_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-33019, 494, 960.46), (0, 270, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "strip_mall_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-33269, 2086, 959.97), (0, 180, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "highrise_spawnpoints";
  s.name = "ai_encounter_spawnpoint";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-27622, -14250, 1536), (0, 180, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "highrise_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-28324, -14976, 1536), (0, 270, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "highrise_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-28215, -16098, 1568), (0, 90, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "highrise_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-28481, -15699, 1568), (0, 270, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "highrise_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-28378, -15337, 1632), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "highrise_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-28138, -15457, 1728), (0, 90, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "highrise_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-28313, -15160, 1728), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_d_ob_contracts_weapon_stash_cs");
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
    cf = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  }

  switch (instancename) {
    case #"hash_300d2a0484ae7618":
      function_befaea7a8a46a2fb(fe, us, cf);
      break;
    case #"hash_ac25eff724733a70":
      function_6b63b4c972c3a65(fe, us, cf);
      break;
  }
}

function function_befaea7a8a46a2fb(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-33626.1, -435.8, 959.58), (0, 100.23, 0), undefined, "WEAPON_STASH_D_STRIP_MALL", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-31500.4, 1404.3, 959.98), (0, 100.23, 0), undefined, "WEAPON_STASH_D_STRIP_MALL", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-33201.8, 3185.45, 959.97), (0, 100.23, 0), undefined, "WEAPON_STASH_D_STRIP_MALL", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-31987.6, 2278.66, 959.98), (0, 100.23, 0), undefined, "WEAPON_STASH_D_STRIP_MALL", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-31687.6, 297.09, 959.97), (0, 100.23, 0), undefined, "WEAPON_STASH_D_STRIP_MALL", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  s.var_e1c68d186b8918b5 = "MERC_STRONGHOLD_TEST";
  s.var_5b6c0bbb3c3e9362 = "ZOMBIE_STRONGHOLD_F_RURAL_SHOP_MD";
  fe[[f]](s, us, cf, (-32710.4, 2018.47, 963), (0, 190.23, 0), undefined, "WEAPON_STASH_D_STRIP_MALL", "weaponstash_safe", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-32945.2, 1966.48, 962.89), (0, 100.23, 0), undefined, "WEAPON_STASH_D_STRIP_MALL", "weaponstash_rift", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-34198.6, 4641.25, 1006), (270, 172.25, -65.46), "activity_nexus_instance_joiner", undefined, "WEAPON_STASH_D_STRIP_MALL", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-32841.1, -312.91, 959.97), (0, 100.23, 0), undefined, "WEAPON_STASH_D_STRIP_MALL", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-31676.1, 1625.59, 967.98), (0, 100.23, 0), undefined, "WEAPON_STASH_D_STRIP_MALL", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-33717.3, 1011.45, 920), (0, 100.23, 0), undefined, "WEAPON_STASH_D_STRIP_MALL", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
}

function function_6b63b4c972c3a65(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-26936.4, -19714.3, 1755.75), (270, 0, -160.41), "activity_nexus_instance_joiner", undefined, "WEAPON_STASH_D_HIGHRISE_03", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-27813.9, -15415.8, 1538.92), (0, 304.59, 0), undefined, "WEAPON_STASH_D_HIGHRISE_03", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-28315.4, -14570.5, 1536.08), (0, 304.59, 0), undefined, "WEAPON_STASH_D_HIGHRISE_03", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-28318.1, -16551.6, 1514.85), (0, 304.59, 0), undefined, "WEAPON_STASH_D_HIGHRISE_03", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-29218.7, -14128.9, 1576), (0, 304.59, 0), undefined, "WEAPON_STASH_D_HIGHRISE_03", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-26400.9, -14640.5, 1513.99), (0, 304.59, 0), undefined, "WEAPON_STASH_D_HIGHRISE_03", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-28831, -16259.6, 1510.06), (0, 304.59, 0), undefined, "WEAPON_STASH_D_HIGHRISE_03", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  s.var_e1c68d186b8918b5 = "MERC_STRONGHOLD_TEST";
  s.var_5b6c0bbb3c3e9362 = "ZOMBIE_STRONGHOLD_F_RURAL_SHOP_MD";
  fe[[f]](s, us, cf, (-28066.9, -14971.8, 1536), (0, 73.2, 0), undefined, "WEAPON_STASH_D_HIGHRISE_03", "weaponstash_safe", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-27889.1, -14726.3, 1536), (0, 304.59, 0), undefined, "WEAPON_STASH_D_HIGHRISE_03", "weaponstash_rift", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_weapon_stash";
  instancestruct.cf = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  instancestruct.scriptstructorigin = (-32710.4, 2018.47, 963);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-32723.5, 2023, 963)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [200];
  activityinstances["WEAPON_STASH_D_STRIP_MALL"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_weapon_stash";
  instancestruct.cf = "mp_jup_st_d_ob_contracts_weapon_stash_cs";
  instancestruct.scriptstructorigin = (-28066.9, -14971.8, 1536);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-28058.5, -14974, 1536)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [200];
  activityinstances["WEAPON_STASH_D_HIGHRISE_03"] = instancestruct;
  return activityinstances;
}