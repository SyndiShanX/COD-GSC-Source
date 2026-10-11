/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5726498e64230c25.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_g_ob_contracts_weapon_stash_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_g_ob_contracts_weapon_stash_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_g_ob_contracts_weapon_stash_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_g_ob_contracts_weapon_stash_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_g_ob_contracts_weapon_stash_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_g_ob_contracts_weapon_stash_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "museum_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-17232.5, -42160, 2819.67), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "museum_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-17597.5, -41709.5, 2821.5), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "museum_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-16980.5, -41851.5, 2821.5), (0, 180, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "museum_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-17458.5, -41121, 2820.5), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "museum_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-17675, -41809, 2820.5), (0, 270, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "museum_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-16667, -41526.5, 2820.5), (0, 90, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "museum_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-17440, -41432, 2821.5), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "govt_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-18894, -14580, 1705.06), (0, 270, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "govt_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-18987.5, -13990.5, 1715.64), (0, 302.57, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "govt_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-18757, -14059, 1715.41), (0, 270, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "govt_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-18785, -13578, 1705), (0, 180, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "govt_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-19107, -13827.5, 1705.18), (0, 90, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "govt_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-18634.5, -14943.5, 1705), (0, 180, 0), undefined, undefined, "ai_encounter_spawnpoint");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_g_ob_contracts_weapon_stash_cs");
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
    cf = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  }

  switch (instancename) {
    case #"hash_436bdd58b4ec548":
      function_f55afbb80806ad7d(fe, us, cf);
      break;
    case #"hash_7fe27529fb636a40":
      function_71f1fe8f857f559d(fe, us, cf);
      break;
  }
}

function function_f55afbb80806ad7d(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-17803.8, -40948.4, 2816.24), (0, 341.09, 0), undefined, "WEAPON_STASH_G_MUSEUM_01", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-15201, -40171.5, 2818.16), (0, 341.09, 0), undefined, "WEAPON_STASH_G_MUSEUM_01", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-16239.4, -40362, 2814.22), (0, 341.09, 0), undefined, "WEAPON_STASH_G_MUSEUM_01", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-17771.2, -41680.4, 3212.03), (0, 341.09, 0), undefined, "WEAPON_STASH_G_MUSEUM_01", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-16289, -42663.6, 2819.99), (0, 341.09, 0), undefined, "WEAPON_STASH_G_MUSEUM_01", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-16943.3, -42844.9, 2819.99), (0, 341.09, 0), undefined, "WEAPON_STASH_G_MUSEUM_01", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  s.var_e1c68d186b8918b5 = "MERC_STRONGHOLD_TEST";
  s.var_5b6c0bbb3c3e9362 = "ZOMBIE_STRONGHOLD_F_RURAL_SHOP_MD";
  fe[[f]](s, us, cf, (-17107.9, -41793.1, 2821.5), (0, 110.09, 0), undefined, "WEAPON_STASH_G_MUSEUM_01", "weaponstash_safe", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-17229.1, -41753.4, 2821.5), (0, 188.07, 0), undefined, "WEAPON_STASH_G_MUSEUM_01", "weaponstash_rift", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-19838.2, -40144.6, 2752.75), (270, 71, 20.64), "activity_nexus_instance_joiner", undefined, "WEAPON_STASH_G_MUSEUM_01", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_71f1fe8f857f559d(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-19823.2, -12771.8, 1704.96), (0, 38.78, 0), undefined, "WEAPON_STASH_G_BOMBED_GOVT", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-18141.9, -12832.8, 1709.87), (0, 38.78, 0), undefined, "WEAPON_STASH_G_BOMBED_GOVT", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-18939.8, -15621, 1612.33), (0, 38.78, 0), undefined, "WEAPON_STASH_G_BOMBED_GOVT", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-18159.8, -15765, 1688.5), (0, 38.78, 0), undefined, "WEAPON_STASH_G_BOMBED_GOVT", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-18101.2, -13558.7, 1714.49), (0, 38.78, 0), undefined, "WEAPON_STASH_G_BOMBED_GOVT", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-19759.8, -14245.1, 1588.34), (0, 38.78, 0), undefined, "WEAPON_STASH_G_BOMBED_GOVT", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  s.var_e1c68d186b8918b5 = "MERC_STRONGHOLD_TEST";
  s.var_5b6c0bbb3c3e9362 = "ZOMBIE_STRONGHOLD_F_RURAL_SHOP_MD";
  fe[[f]](s, us, cf, (-18715.6, -14532.5, 1714), (0, 128.78, 0), undefined, "WEAPON_STASH_G_BOMBED_GOVT", "weaponstash_safe", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-18899.7, -14232.7, 1715.5), (0, 345.22, 0), undefined, "WEAPON_STASH_G_BOMBED_GOVT", "weaponstash_rift", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-18240.7, -18887.5, 1686.5), (270, 0, -117.11), "activity_nexus_instance_joiner", undefined, "WEAPON_STASH_G_BOMBED_GOVT", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_weapon_stash";
  instancestruct.cf = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  instancestruct.scriptstructorigin = (-17113.4, -41797.2, 2821.5);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-17098, -41760, 2822)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [200];
  activityinstances["WEAPON_STASH_G_MUSEUM_01"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_weapon_stash";
  instancestruct.cf = "mp_jup_st_g_ob_contracts_weapon_stash_cs";
  instancestruct.scriptstructorigin = (-18767.2, -14270, 1732.25);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-18735, -14525, 1715)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [200];
  activityinstances["WEAPON_STASH_G_BOMBED_GOVT"] = instancestruct;
  return activityinstances;
}