/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_200cff160a7ac991.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_f_ob_contracts_weapon_stash_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_f_ob_contracts_weapon_stash_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_f_ob_contracts_weapon_stash_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_f_ob_contracts_weapon_stash_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_f_ob_contracts_weapon_stash_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_f_ob_contracts_weapon_stash_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "rural_shop_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (34626, 221, 2381), (0, 180, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "rural_shop_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (34421, 474, 2392), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "rural_shop_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (34467, 994, 2392), (0, 270, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "rural_shop_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (34870, 568, 2391.73), (0, 90, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "rural_shop_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (34837, 908, 2535.73), (0, 270, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "rural_shop_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (34896, 595, 2536), (0, 90, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "rural_shop_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (34699, 320, 2536), (0, 180, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "house_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (39742, 13074, 3080), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "house_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (39512, 12802, 3080), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "house_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (39630, 12969, 3224), (0, 309.1, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "house_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (39888, 12974, 3216), (0, 322.5, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "house_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (39464, 12708, 3080), (0, 270, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "house_spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (39475, 12901, 3080), (0, 90, 0), undefined, undefined, "ai_encounter_spawnpoint");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_f_ob_contracts_weapon_stash_cs");
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
    cf = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  }

  switch (instancename) {
    case #"hash_3b8e93072e02df62":
      function_eadab020211fcaaf(fe, us, cf);
      break;
    case #"hash_daf68c83386ce216":
      function_634dfc74af530dd1(fe, us, cf);
      break;
  }
}

function function_eadab020211fcaaf(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (34348, -1181.75, 2384.47), (4.59, 143.59, 0.88), undefined, "WEAPON_STASH_F_RURAL_SHOP_MD", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (31756.2, 6064.75, 2278.47), (270, 60.3, 2.59), "activity_nexus_instance_joiner", undefined, "WEAPON_STASH_F_RURAL_SHOP_MD", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (35305.2, 2424.75, 2509.19), (0, 207.9, 0), undefined, "WEAPON_STASH_F_RURAL_SHOP_MD", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (33430, -168.01, 2263.46), (1.79, 159.93, 4.88), undefined, "WEAPON_STASH_F_RURAL_SHOP_MD", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (33616, 2133, 2318.69), (357.1, 118.25, -10.19), undefined, "WEAPON_STASH_F_RURAL_SHOP_MD", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (35078.8, -1518.75, 2396.8), (4.53, 301.38, 23.69), undefined, "WEAPON_STASH_F_RURAL_SHOP_MD", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (34585, 2146.75, 2395.97), (0, 207.9, 0), undefined, "WEAPON_STASH_F_RURAL_SHOP_MD", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  s.var_e1c68d186b8918b5 = "MERC_STRONGHOLD_TEST";
  s.var_5b6c0bbb3c3e9362 = "ZOMBIE_STRONGHOLD_F_RURAL_SHOP_MD";
  fe[[f]](s, us, cf, (34493, 692, 2535.73), (0, 270, 0), undefined, "WEAPON_STASH_F_RURAL_SHOP_MD", "weaponstash_safe", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (34702.7, 659.39, 2535.73), (0, 0, 0), undefined, "WEAPON_STASH_F_RURAL_SHOP_MD", "weaponstash_rift", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_634dfc74af530dd1(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (40448.6, 13764.5, 3084), (0, 0, 0), undefined, "WEAPON_STASH_F_RURAL_HOUSE_MD", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (39016.6, 11576.2, 3039.08), (0, 0, 0), undefined, "WEAPON_STASH_F_RURAL_HOUSE_MD", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (39648.6, 13879.2, 3092.6), (0, 0, 0), undefined, "WEAPON_STASH_F_RURAL_HOUSE_MD", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (38709.1, 13927.5, 3057.97), (0, 0, 0), undefined, "WEAPON_STASH_F_RURAL_HOUSE_MD", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (41124.4, 12487.2, 3076.36), (0, 162.91, 0), undefined, "WEAPON_STASH_F_RURAL_HOUSE_MD", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  s.var_e1c68d186b8918b5 = "MERC_STRONGHOLD_TEST";
  s.var_5b6c0bbb3c3e9362 = "ZOMBIE_STRONGHOLD_F_RURAL_SHOP_MD";
  fe[[f]](s, us, cf, (39512.6, 12848.2, 3224), (0, 321.71, 0), undefined, "WEAPON_STASH_F_RURAL_HOUSE_MD", "weaponstash_safe", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (35190.2, 8653.5, 2233.75), (270, 98.15, -68.09), "activity_nexus_instance_joiner", undefined, "WEAPON_STASH_F_RURAL_HOUSE_MD", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (39714.3, 12713.1, 3224), (0, 0, 0), undefined, "WEAPON_STASH_F_RURAL_HOUSE_MD", "weaponstash_rift", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (40394.1, 11335, 3039.08), (0, 0, 0), undefined, "WEAPON_STASH_F_RURAL_HOUSE_MD", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_weapon_stash";
  instancestruct.cf = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  instancestruct.scriptstructorigin = (34493, 692, 2535.73);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(34468, 651, 2549.73)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [200];
  activityinstances["WEAPON_STASH_F_RURAL_SHOP_MD"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_weapon_stash";
  instancestruct.cf = "mp_jup_st_f_ob_contracts_weapon_stash_cs";
  instancestruct.scriptstructorigin = (39555, 12795.5, 3239.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(39527, 12858, 3224)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [200];
  activityinstances["WEAPON_STASH_F_RURAL_HOUSE_MD"] = instancestruct;
  return activityinstances;
}