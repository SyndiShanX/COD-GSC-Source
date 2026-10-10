/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_440e51fd2ad69540.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_hydro_ob_contracts_weapon_stash_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_hydro_ob_contracts_weapon_stash_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_hydro_ob_contracts_weapon_stash_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_hydro_ob_contracts_weapon_stash_cs");

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

  s cs_setup_arrays(us, "mp_jup_hydro_ob_contracts_weapon_stash_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_hydro_ob_contracts_weapon_stash_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-1853.58, 8574.61, 546), (0, 104.4, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-1854.53, 8245.96, 821.04), (0, 194.4, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-1228.58, 8809.61, 844.55), (0, 104.4, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-1039.58, 8693.61, 851.92), (0, 14.4, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-1130.52, 8265.28, 848), (0, 284.4, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-1371.37, 8021.81, 848), (0, 284.4, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-1575.07, 7935.24, 848), (0, 284.4, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-1430.58, 8252.61, 845.34), (0, 104.4, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-1561.58, 8196.61, 848), (0, 104.4, 0), undefined, undefined, "ai_encounter_spawnpoint");
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_weapon_stash_cs";
  s.ai_faction = "zombie";
  s.groupid = "spawnpoints";
  s.var_e5decd57d2e1579 = "3000";
  s.script_stealthgroup = "-1";
  s.spawn_filter = "none";
  s.wave_indexes = "-1";
  s.var_90a30a42ca3830f1 = "none";
  fe[[f]](s, us, cf, (-1353.58, 8571.61, 840.25), (0, 104.4, 0), undefined, undefined, "ai_encounter_spawnpoint");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_hydro_ob_contracts_weapon_stash_cs");
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
    cf = "mp_jup_hydro_ob_contracts_weapon_stash_cs";
  }

  switch (instancename) {
    case #"hash_d0fafeb5b1167a66":
      function_509efc065f50587(fe, us, cf);
      break;
  }
}

function function_509efc065f50587(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-614.71, 7709.9, 912), (0, 0, 0), undefined, "WEAPON_STASH_HYDRO", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-2608.15, 7312.56, 576.38), (0, 0, 0), undefined, "WEAPON_STASH_HYDRO", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-859.91, 6554.5, 723.61), (0, 0, 0), undefined, "WEAPON_STASH_HYDRO", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-1050.11, 6149.23, 664.8), (0, 0, 0), undefined, "WEAPON_STASH_HYDRO", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-2144.73, 6175.58, 587.02), (0, 0, 0), undefined, "WEAPON_STASH_HYDRO", "weaponstash_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-1509.41, 6636.35, 752), (0, 121, 0), undefined, "WEAPON_STASH_HYDRO", "weaponstash_safe", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-1451.07, 6778.77, 752), (0, 0, 0), undefined, "WEAPON_STASH_HYDRO", "weaponstash_rift", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_weapon_stash_cs";
  fe[[f]](s, us, cf, (-3982.5, 6982.57, 984), (270, 0, 152.89), "activity_nexus_instance_joiner", undefined, "WEAPON_STASH_HYDRO", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_weapon_stash";
  instancestruct.cf = "mp_jup_hydro_ob_contracts_weapon_stash_cs";
  instancestruct.scriptstructorigin = (-1488.72, 6670.53, 752);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-1511.93, 6646.66, 752)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [200];
  activityinstances["WEAPON_STASH_HYDRO"] = instancestruct;
  return activityinstances;
}