/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_685207987fef2bdc.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_fort_ob_activities_aether_nest_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_fort_ob_activities_aether_nest_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_fort_ob_activities_aether_nest_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_fort_ob_activities_aether_nest_cs");

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

  s cs_setup_arrays(us, "mp_jup_fort_ob_activities_aether_nest_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_fort_ob_activities_aether_nest_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_fort_ob_activities_aether_nest_cs";
  s.ai_faction = "any";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (18774, -53132, 826), (0, 0, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_activities_aether_nest_cs";
  s.ai_faction = "any";
  s.animation = "ai_jup_crawler_abom_two_drop_01_idle";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "custom";
  s.var_2b2ae43751de4aa7 = "nest_crawler_spawnpoint";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (18681, -53124, 824), (0, 180, 0), undefined, undefined, "ai_encounter_spawnpoint");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_fort_ob_activities_aether_nest_cs");
}

function function_fd69cf02ba4d90a2() {
  var_d13c18af4084bdfd = spawnStruct();
  var_d13c18af4084bdfd.name = "REV_OB_AETHERNEST";
  var_d13c18af4084bdfd.scriptbundle = "jup_activitydef_aethernest";
  var_d13c18af4084bdfd.mainfunction = &main;
  var_d13c18af4084bdfd.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  var_d13c18af4084bdfd.var_ad1dcd56d202e9ac = &function_6da2952367672ac0;
  return var_d13c18af4084bdfd;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_fort_ob_activities_aether_nest_cs";
  }

  switch (instancename) {
    case #"hash_1a028a892e15c991":
      function_8778ecf34778152(fe, us, cf);
      break;
  }
}

function function_8778ecf34778152(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_fort_ob_activities_aether_nest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (19103, -53437, 719), (90, 195.46, 15.46), "s_cyst_spawn", "AETHERNEST_FORT_GAS_CISTERN", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_activities_aether_nest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (19104, -53888, 715), (88.4, 180, 0), "s_cyst_spawn", "AETHERNEST_FORT_GAS_CISTERN", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_activities_aether_nest_cs";
  s.groupid = "ceiling_spawners";
  fe[[f]](s, us, cf, (18724.5, -53130.3, 856), (360, 230.94, 0), "ceiling_spawner", "AETHERNEST_FORT_GAS_CISTERN", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_activities_aether_nest_cs";
  fe[[f]](s, us, cf, (18593.4, -53630.7, 634), (0, 286.45, 0), "AETHERNEST_FORT_GAS_CISTERN", "AETHERNEST_FORT", "850.00", undefined, undefined, (0, 0, 0), (0, 0, 0), 850);
  s = s();
  s.cs_flag = "mp_jup_fort_ob_activities_aether_nest_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (529, 463, 92);
  s.var_74e936bbadd15418 = (511, 834, 32);
  s.groupid = "triggers";
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (18583, -53446, 657), (0, 0, 0), "aethernest_interior_trigger", "AETHERNEST_FORT_GAS_CISTERN", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_activities_aether_nest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (18815, -53758, 751), (78.9, 332.97, 148.42), "s_cyst_spawn", "AETHERNEST_FORT_GAS_CISTERN", "7", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_activities_aether_nest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (18398, -53745, 806), (64, 180, 168.3), "s_cyst_spawn", "AETHERNEST_FORT_GAS_CISTERN", "5", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_activities_aether_nest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (18129, -53964, 728), (90, 294.42, -65.58), "s_cyst_spawn", "AETHERNEST_FORT_GAS_CISTERN", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_activities_aether_nest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (18939, -54270, 790), (90, 278.09, -171.91), "s_cyst_spawn", "AETHERNEST_FORT_GAS_CISTERN", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_activities_aether_nest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (18127, -53613, 734), (86.3, 180, -180), "s_cyst_spawn", "AETHERNEST_FORT_GAS_CISTERN", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_activities_aether_nest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (18269, -52993, 710), (271.5, 93.6, -0), "s_cyst_spawn", "AETHERNEST_FORT_GAS_CISTERN", "6", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_activities_aether_nest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (18878, -53254, 702), (360, 270, -96.24), "s_cyst_spawn", "AETHERNEST_FORT_GAS_CISTERN", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_activities_aether_nest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (19059, -53177, 741), (89.1, 180, 0), "s_cyst_spawn", "AETHERNEST_FORT_GAS_CISTERN", "3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_activities_aether_nest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (18306, -53765, 690), (90, 194.75, 14.75), "s_cyst_spawn", "AETHERNEST_FORT_GAS_CISTERN", "1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_activities_aether_nest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (19104, -54083, 693), (80.2, 180, 0), "s_cyst_spawn", "AETHERNEST_FORT_GAS_CISTERN", "4", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_activities_aether_nest_cs";
  s.groupid = "cyst_spawnpoints";
  fe[[f]](s, us, cf, (18080, -53315, 728), (88.5, 360, -0), "s_cyst_spawn", "AETHERNEST_FORT_GAS_CISTERN", "2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_activities_aether_nest_cs";
  s.name = "loot_cache_spawn";
  fe[[f]](s, us, cf, (18706, -53461, 638), (0, 270, 0), "s_loot_cache_spawn", "AETHERNEST_FORT_GAS_CISTERN", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_aethernest";
  instancestruct.cf = "mp_jup_fort_ob_activities_aether_nest_cs";
  instancestruct.scriptstructorigin = (18594, -53631, 617);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(18619, -53566, 638)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1100];
  activityinstances["AETHERNEST_FORT_GAS_CISTERN"] = instancestruct;
  return activityinstances;
}