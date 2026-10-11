/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_169cba9946c78953.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_d_ob_contracts_sabotage_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_d_ob_contracts_sabotage_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_d_ob_contracts_sabotage_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_d_ob_contracts_sabotage_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_d_ob_contracts_sabotage_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_d_ob_contracts_sabotage_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_d_ob_contracts_sabotage_cs");
}

function function_fd69cf02ba4d90a2() {
  activityinfostruct = spawnStruct();
  activityinfostruct.name = "REV_OB_SABOTAGE";
  activityinfostruct.scriptbundle = "jup_activitydef_sabotage";
  activityinfostruct.mainfunction = &main;
  activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  activityinfostruct.metadatafunction = &function_6da2952367672ac0;
  return activityinfostruct;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_d_ob_contracts_sabotage_cs";
  }

  switch (instancename) {
    case #"hash_ccf39aed69edf3b":
      function_c15786fb91c6d20e(fe, us, cf);
      break;
    case #"hash_7c5384ff56f8bde9":
      function_7e577467d8362206(fe, us, cf);
      break;
    case #"hash_b2076960536255df":
      function_e1f88b9e057ebee2(fe, us, cf);
      break;
  }
}

function function_c15786fb91c6d20e(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_sabotage_cs";
  fe[[f]](s, us, cf, (-34312, 6480, 1005.5), (0, 228.67, 0), "activity_nexus_instance_joiner", undefined, "SABOTAGE_D_RAIL_CARS", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_7e577467d8362206(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_sabotage_cs";
  fe[[f]](s, us, cf, (-19550.5, 9116.5, 2022.46), (360, 219.35, -0), "activity_nexus_instance_joiner", undefined, "SABOTAGE_D_EAST_HILLS", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_e1f88b9e057ebee2(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_sabotage_cs";
  fe[[f]](s, us, cf, (-35584, 9173.75, 997), (0, 219.02, 0), "activity_nexus_instance_joiner", undefined, "SABOTAGE_D_SOUTH_DOCKS", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_sabotage";
  instancestruct.cf = "mp_jup_st_d_ob_contracts_sabotage_cs";
  instancestruct.scriptstructorigin = (-34138, 9804, 1000);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(-34158.5, 9802.5, 1000)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [4000];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(-34175.5, 9814, 1000)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [2800];
  instancestruct.locationorigin = [(-34157, 9815.5, 1000)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2800];
  activityinstances["SABOTAGE_D_RAIL_CARS"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_sabotage";
  instancestruct.cf = "mp_jup_st_d_ob_contracts_sabotage_cs";
  instancestruct.scriptstructorigin = (-20817.5, 4299, 1352.5);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(-20815.5, 4292.5, 1350)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [2800];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(-20839, 4290, 1351)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [5000];
  instancestruct.locationorigin = [(-20837.5, 4281.5, 1348.3)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [2800];
  activityinstances["SABOTAGE_D_EAST_HILLS"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_sabotage";
  instancestruct.cf = "mp_jup_st_d_ob_contracts_sabotage_cs";
  instancestruct.scriptstructorigin = (-32150.5, 3441.5, 960);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.var_5b156d1fa702b37f = [];
  instancestruct.var_5b156d1fa702b37f["join_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationorigin = [(-32165, 3442.5, 960)];
  instancestruct.var_5b156d1fa702b37f["join_radius"].locationradius = [3200];
  instancestruct.var_5b156d1fa702b37f["participation_radius"] = spawnStruct();
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationorigin = [(-32158, 3453, 960)];
  instancestruct.var_5b156d1fa702b37f["participation_radius"].locationradius = [5000];
  instancestruct.locationorigin = [(-32170, 3442.5, 960)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [3200];
  activityinstances["SABOTAGE_D_SOUTH_DOCKS"] = instancestruct;
  return activityinstances;
}