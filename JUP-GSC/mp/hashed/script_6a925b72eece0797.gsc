/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6a925b72eece0797.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_f_ob_contracts_sabotage_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_f_ob_contracts_sabotage_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_f_ob_contracts_sabotage_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_f_ob_contracts_sabotage_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_f_ob_contracts_sabotage_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_f_ob_contracts_sabotage_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_f_ob_contracts_sabotage_cs");
}

function function_fd69cf02ba4d90a2() {
  var_d13c18af4084bdfd = spawnStruct();
  var_d13c18af4084bdfd.name = "REV_OB_SABOTAGE";
  var_d13c18af4084bdfd.mainfunction = &main;
  var_d13c18af4084bdfd.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  var_d13c18af4084bdfd.var_ad1dcd56d202e9ac = &function_6da2952367672ac0;
  return var_d13c18af4084bdfd;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_f_ob_contracts_sabotage_cs";
  }

  switch (instancename) {
    case #"hash_8d70c8d760b6b3db":
      function_940943f879d1904a(fe, us, cf);
      break;
    case #"hash_6919a3480a5d2ae8":
      function_a7cc86d583a3a9ed(fe, us, cf);
      break;
    case #"hash_7c81c1302cc530d0":
      function_1dcb8dfab5207759(fe, us, cf);
      break;
  }
}

function function_940943f879d1904a(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_sabotage_cs";
  fe[[f]](s, us, cf, (44231.5, -10550, 2888.94), (356.77, 94.1, 1.79), "activity_nexus_instance_joiner", undefined, "SABOTAGE_F_FARM_EAST", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_a7cc86d583a3a9ed(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_sabotage_cs";
  fe[[f]](s, us, cf, (34181.5, 6804, 2344.25), (0, 295.36, 0), "activity_nexus_instance_joiner", undefined, "SABOTAGE_F_ABANDONED_VILLAGE", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_1dcb8dfab5207759(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_sabotage_cs";
  fe[[f]](s, us, cf, (31076, -5750.5, 2989.1), (356.35, 24.41, -1.52), "activity_nexus_instance_joiner", undefined, "SABOTAGE_F_MARKETPLACE", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_sabotage";
  instancestruct.cf = "mp_jup_st_f_ob_contracts_sabotage_cs";
  instancestruct.scriptstructorigin = (44705, -1964.5, 3068.26);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(44709, -1964.5, 3067.8)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [3000];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(44717, -1962.5, 3066.84)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [5000];
  instancestruct.locationorigin = [(44709, -1980, 3068.19)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [3000];
  activityinstances["SABOTAGE_F_FARM_EAST"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_sabotage";
  instancestruct.cf = "mp_jup_st_f_ob_contracts_sabotage_cs";
  instancestruct.scriptstructorigin = (40520, 12202, 3074);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(40512, 12204, 3074)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [3000];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(40530, 12204, 3074)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [5000];
  instancestruct.locationorigin = [(40534, 12196, 3074)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [3000];
  activityinstances["SABOTAGE_F_ABANDONED_VILLAGE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_sabotage";
  instancestruct.cf = "mp_jup_st_f_ob_contracts_sabotage_cs";
  instancestruct.scriptstructorigin = (33627.5, -12058, 2936.5);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(33627.5, -12058, 2936.5)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [3500];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(33627.5, -12058, 2936.5)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [5000];
  instancestruct.locationorigin = [(33627.5, -12058, 2936.5)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [3000];
  activityinstances["SABOTAGE_F_MARKETPLACE"] = instancestruct;
  return activityinstances;
}