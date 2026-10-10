/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_651e8638cd2683a7.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_a_ob_contracts_sabotage_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_a_ob_contracts_sabotage_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_a_ob_contracts_sabotage_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_a_ob_contracts_sabotage_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_a_ob_contracts_sabotage_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_a_ob_contracts_sabotage_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_a_ob_contracts_sabotage_cs");
}

function function_fd69cf02ba4d90a2() {
  var_d13c18af4084bdfd = spawnStruct();
  var_d13c18af4084bdfd.name = "REV_OB_SABOTAGE";
  var_d13c18af4084bdfd.scriptbundle = "jup_activitydef_sabotage";
  var_d13c18af4084bdfd.mainfunction = &main;
  var_d13c18af4084bdfd.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  var_d13c18af4084bdfd.var_ad1dcd56d202e9ac = &function_6da2952367672ac0;
  return var_d13c18af4084bdfd;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_a_ob_contracts_sabotage_cs";
  }

  switch (instancename) {
    case #"hash_758f71cd187b666b":
      function_d25ffd60a49dd5c6(fe, us, cf);
      break;
    case #"hash_963a32c8ef65a8b3":
      function_bb60d0f31701bd7c(fe, us, cf);
      break;
    case #"hash_a525851ad3d37f01":
      function_8d22113129e56c14(fe, us, cf);
      break;
  }
}

function function_d25ffd60a49dd5c6(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_sabotage_cs";
  fe[[f]](s, us, cf, (-21298.5, 29151, 2196.63), (1.11, 30.99, 0.12), "activity_nexus_instance_joiner", undefined, "SABOTAGE_A_MILITARY_BASE", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_bb60d0f31701bd7c(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_sabotage_cs";
  fe[[f]](s, us, cf, (-31500.5, 30099, 1412.5), (0, 293.72, 0), "activity_nexus_instance_joiner", undefined, "SABOTAGE_A_RESORT", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_8d22113129e56c14(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_contracts_sabotage_cs";
  fe[[f]](s, us, cf, (-26581.5, 42802.5, 1918.5), (0, 338.2, 0), "activity_nexus_instance_joiner", undefined, "SABOTAGE_A_NORTH", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_sabotage";
  instancestruct.cf = "mp_jup_st_a_ob_contracts_sabotage_cs";
  instancestruct.scriptstructorigin = (-22075.5, 20779.5, 1723.97);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(-22075.5, 20779.5, 1723.97)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [2800];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(-22074.5, 20776, 1723.84)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [4000];
  instancestruct.locationorigin = [(-22067.5, 20769.5, 1723.79)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2800];
  activityinstances["SABOTAGE_A_MILITARY_BASE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_sabotage";
  instancestruct.cf = "mp_jup_st_a_ob_contracts_sabotage_cs";
  instancestruct.scriptstructorigin = (-33917, 34318, 1372.21);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(-33934, 34321.5, 1372)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [2500];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(-33932.5, 34318.5, 1377)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [4000];
  instancestruct.locationorigin = [(-33917, 34318, 1372.21)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2500];
  activityinstances["SABOTAGE_A_RESORT"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_sabotage";
  instancestruct.cf = "mp_jup_st_a_ob_contracts_sabotage_cs";
  instancestruct.scriptstructorigin = (-32534, 42080.5, 1488);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(-32529, 42094, 1488)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [3000];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(-32535, 42089, 1488)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [4000];
  instancestruct.locationorigin = [(-32535.5, 42088.5, 1488)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [3000];
  activityinstances["SABOTAGE_A_NORTH"] = instancestruct;
  return activityinstances;
}