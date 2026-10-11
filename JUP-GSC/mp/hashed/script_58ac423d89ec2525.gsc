/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_58ac423d89ec2525.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_i_ob_interactions_turret_trap_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_i_ob_interactions_turret_trap_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_i_ob_interactions_turret_trap_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_i_ob_interactions_turret_trap_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_i_ob_interactions_turret_trap_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_i_ob_interactions_turret_trap_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_i_ob_interactions_turret_trap_cs");
}

function function_fd69cf02ba4d90a2() {
  activityinfostruct = spawnStruct();
  activityinfostruct.name = "REV_OB_TURRET_TRAP";
  activityinfostruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  activityinfostruct.mainfunction = &main;
  activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  activityinfostruct.metadatafunction = &function_6da2952367672ac0;
  return activityinfostruct;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_i_ob_interactions_turret_trap_cs";
  }

  switch (instancename) {
    case #"hash_6f5f6be9661cb56d":
      function_1aba12ff87195e6(fe, us, cf);
      break;
    case #"hash_21a26137aa2cdfa0":
      function_fad1499a466f7c7d(fe, us, cf);
      break;
    case #"hash_938f3333f9ff5334":
      function_da0fa9fa62d4d731(fe, us, cf);
      break;
    case #"hash_cf8ba8788437b54":
      function_10f7f9f913d563e5(fe, us, cf);
      break;
    case #"hash_d270f7ba021e492b":
      function_add186995eeb41dc(fe, us, cf);
      break;
    case #"hash_3e5bd0cbcad38fe":
      function_5940525263df523(fe, us, cf);
      break;
  }
}

function function_1aba12ff87195e6(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (27652.4, -30413.6, 3563.25), (0, 249.7, 0), "turret_trap_spawn", "s_turret_trap_i_mansion", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (27653.8, -30412.8, 3647.75), (0, 159.7, 0), "s_turret_trap_i_mansion", undefined, "activity_turret_trap_i_mansion", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (27641.7, -30439.2, 3613.25), (0, 159.7, 0), "turret_trap_panel", "s_turret_trap_i_mansion", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_fad1499a466f7c7d(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (25265.6, -37452.2, 3318.25), (0, 29.63, 0), "turret_trap_spawn", "s_turret_trap_i_yard", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (25264.1, -37452, 3402.75), (0, 299.63, 0), "s_turret_trap_i_yard", "s_turret_trap_i_yard", "activity_turret_trap_i_yard", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (25290.4, -37439.5, 3368.25), (0, 299.63, 0), "turret_trap_panel", "s_turret_trap_i_yard", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_da0fa9fa62d4d731(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (27996.8, -26718, 3114.5), (0, 101.14, 0), "turret_trap_spawn", "s_turret_trap_i_guesthouse", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (27996.1, -26719.3, 3199), (0, 11.14, 0), "s_turret_trap_i_guesthouse", "s_turret_trap_i_guesthouse", "activity_turret_trap_i_guesthouse", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (27992.6, -26690.5, 3164.5), (0, 11.14, 0), "turret_trap_panel", "s_turret_trap_i_guesthouse", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_10f7f9f913d563e5(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (39177.1, -20403.1, 3039.75), (0, 292.01, 0), "turret_trap_spawn", "s_turret_trap_i_farm", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (39177.5, -20401.7, 3124.25), (0, 202.01, 0), "s_turret_trap_i_farm", undefined, "activity_turret_trap_i_farm", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (39186.4, -20429.3, 3089.75), (0, 202.01, 0), "turret_trap_panel", "s_turret_trap_i_farm", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_add186995eeb41dc(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (25794.9, -31939.7, 3635.25), (0, 250.43, 0), "turret_trap_spawn", "s_turret_trap_i_courtyard", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (25796.3, -31938.9, 3719.75), (0, 160.43, 0), "s_turret_trap_i_courtyard", undefined, "activity_turret_trap_i_courtyard", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (25784.6, -31965.5, 3685.25), (0, 160.43, 0), "turret_trap_panel", "s_turret_trap_i_courtyard", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_5940525263df523(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (41829.2, -25459.5, 3629.5), (0, 180.19, 0), "turret_trap_spawn", "s_turret_trap_i_roof", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (41830.4, -25460.5, 3714), (0, 90.19, 0), "s_turret_trap_i_roof", undefined, "activity_turret_trap_i_roof", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (41801.5, -25458.4, 3679.5), (0, 90.19, 0), "turret_trap_panel", "s_turret_trap_i_roof", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_i_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (27654.2, -30414.9, 3665.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(27654.8, -30418.8, 3695.75)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_I_MANSION"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_i_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (25265.2, -37450.1, 3420.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(25267.2, -37446.7, 3450.75)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_I_YARD"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_i_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (27994.7, -26717.7, 3217);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(27992.1, -26714.7, 3247)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_I_GUESTHOUSE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_i_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (39179.2, -20402.9, 3142.25);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(39182.3, -20405.4, 3172.25)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_I_FARM"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_i_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (25796.8, -31941, 3737.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(25797.4, -31944.9, 3767.75)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_I_COURTYARD"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_i_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (41828.6, -25461.6, 3732);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(41825.1, -25463.5, 3762)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_I_ROOF"] = instancestruct;
  return activityinstances;
}