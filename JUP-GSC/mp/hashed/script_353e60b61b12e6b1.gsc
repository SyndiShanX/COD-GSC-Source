/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_353e60b61b12e6b1.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_c_ob_interactions_turret_trap_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_c_ob_interactions_turret_trap_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_c_ob_interactions_turret_trap_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_c_ob_interactions_turret_trap_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_c_ob_interactions_turret_trap_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_c_ob_interactions_turret_trap_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_c_ob_interactions_turret_trap_cs");
}

function function_fd69cf02ba4d90a2() {
  var_d13c18af4084bdfd = spawnStruct();
  var_d13c18af4084bdfd.name = "REV_OB_TURRET_TRAP";
  var_d13c18af4084bdfd.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  var_d13c18af4084bdfd.mainfunction = &main;
  var_d13c18af4084bdfd.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  var_d13c18af4084bdfd.var_ad1dcd56d202e9ac = &function_6da2952367672ac0;
  return var_d13c18af4084bdfd;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_c_ob_interactions_turret_trap_cs";
  }

  switch (instancename) {
    case #"hash_88adecc946ab2ab0":
      function_c1256cbc610539e9(fe, us, cf);
      break;
    case #"hash_a7713c66c40b2d59":
      function_53a603014d4fcb68(fe, us, cf);
      break;
    case #"hash_d70217109acf5dec":
      function_de4ef1a3378fa481(fe, us, cf);
      break;
    case #"hash_7697dcbf72a23a47":
      function_a06217ab83a8e72c(fe, us, cf);
      break;
    case #"hash_a27de9772d9acf6f":
      function_5c087e1e2f11b8fa(fe, us, cf);
      break;
    case #"hash_ef15e060906886e9":
      function_ebe07ebb4cbfcf20(fe, us, cf);
      break;
    case #"hash_1855007112a17d9b":
      function_29fe2f32d51e16ea(fe, us, cf);
      break;
  }
}

function function_c1256cbc610539e9(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (42482, 30100.8, 2082.5), (0, 270, 0), "turret_trap_spawn", "s_turret_trap_c_tunnel", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (42483.1, 30101.9, 2167), (0, 180, 0), "s_turret_trap_c_tunnel", undefined, "activity_turret_trap_c_tunnel", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (42480.9, 30072.9, 2132.5), (0, 180, 0), "turret_trap_panel", "s_turret_trap_c_tunnel", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_53a603014d4fcb68(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (27735.2, 37317.1, 1175.5), (0, 179.44, 0), "turret_trap_spawn", "s_turret_trap_c_dock", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (27736.3, 37315.9, 1260), (0, 89.44, 0), "s_turret_trap_c_dock", undefined, "activity_turret_trap_c_dock", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (27707.4, 37318.4, 1225.5), (0, 89.44, 0), "turret_trap_panel", "s_turret_trap_c_dock", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_de4ef1a3378fa481(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (33097.5, 34959.8, 1309.25), (0, 60, 0), "turret_trap_spawn", "s_turret_trap_c_roof", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (33096, 34959.4, 1393.75), (0, 330, 0), "s_turret_trap_c_roof", undefined, "activity_turret_trap_c_roof", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (33112.4, 34983.4, 1359.25), (0, 330, 0), "turret_trap_panel", "s_turret_trap_c_roof", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_a06217ab83a8e72c(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (43598.7, 32896.1, 2843.5), (0, 285, 0), "turret_trap_spawn", "s_turret_trap_c_satellite", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (43599.5, 32897.4, 2928), (0, 195, 0), "s_turret_trap_c_satellite", undefined, "activity_turret_trap_c_satellite", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (43604.9, 32868.8, 2893.5), (0, 195, 0), "turret_trap_panel", "s_turret_trap_c_satellite", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_5c087e1e2f11b8fa(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (27963.6, 24546.5, 1595.5), (0, 180, 0), "turret_trap_spawn", "s_turret_trap_c_camp", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (27964.7, 24545.4, 1680), (0, 90, 0), "s_turret_trap_c_camp", undefined, "activity_turret_trap_c_camp", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (27935.7, 24547.6, 1645.5), (0, 90, 0), "turret_trap_panel", "s_turret_trap_c_camp", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_ebe07ebb4cbfcf20(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (23653.6, 21522.5, 1743.5), (0, 180, 0), "turret_trap_spawn", "s_turret_trap_c_gate", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (23654.7, 21521.4, 1828), (0, 90, 0), "s_turret_trap_c_gate", undefined, "activity_turret_trap_c_gate", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (23625.7, 21523.6, 1793.5), (0, 90, 0), "turret_trap_panel", "s_turret_trap_c_gate", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_29fe2f32d51e16ea(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (35541.9, 31200.8, 1922.5), (0, 149.9, 0), "turret_trap_spawn", "s_turret_trap_c_base", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (35542.3, 31199.3, 2007), (0, 59.9, 0), "s_turret_trap_c_base", undefined, "activity_turret_trap_c_base", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (35518.3, 31215.7, 1972.5), (0, 59.9, 0), "turret_trap_panel", "s_turret_trap_c_base", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_c_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (42484.1, 30100.1, 2185);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(42486, 30096.7, 2215)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_C_TUNNEL"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_c_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (27734.5, 37314.9, 1278);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(27731.1, 37313.1, 1308)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_C_DOCK"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_c_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (33096, 34961.5, 1411.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(33096.1, 34965.4, 1441.75)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_C_ROOF"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_c_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (43601, 32895.9, 2946);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(43603.7, 32893.1, 2976)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_C_SATELLITE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_c_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (27962.8, 24544.4, 1698);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(27959.4, 24542.5, 1728)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_C_CAMP"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_c_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (23652.8, 21520.4, 1846);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(23649.4, 21518.5, 1876)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_C_GATE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_c_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (35540.1, 31199.4, 2025);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(35536.3, 31199.4, 2055)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_C_BASE"] = instancestruct;
  return activityinstances;
}