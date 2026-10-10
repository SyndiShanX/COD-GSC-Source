/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_56e1c5ab32b89131.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_d_ob_interactions_turret_trap_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_d_ob_interactions_turret_trap_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_d_ob_interactions_turret_trap_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_d_ob_interactions_turret_trap_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_d_ob_interactions_turret_trap_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_d_ob_interactions_turret_trap_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_d_ob_interactions_turret_trap_cs");
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
    cf = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  }

  switch (instancename) {
    case #"hash_177cc948e00da4d1":
      function_924e7da4f6520ee2(fe, us, cf);
      break;
    case #"hash_4ea2bc597056ec6a":
      function_7227bf194ed61c93(fe, us, cf);
      break;
    case #"hash_590c4dcc82cb6e":
      function_79cc156cb0ec3605(fe, us, cf);
      break;
    case #"hash_45f1e7f4e212bd0e":
      function_91f39cf5907c54d5(fe, us, cf);
      break;
    case #"hash_45465f46f6143d6f":
      function_e433390f8558b87e(fe, us, cf);
      break;
    case #"hash_cd6e5d0cfa9fcab":
      function_1dc4a74c75d87c0c(fe, us, cf);
      break;
    case #"hash_3c10f46357f28240":
      function_f4bdc905808865f1(fe, us, cf);
      break;
    case #"hash_d0d1a479f95f8c18":
      function_172d7bf100b9011(fe, us, cf);
      break;
  }
}

function function_924e7da4f6520ee2(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-21269.2, 8472.37, 2516.25), (0, 129.99, 0), "turret_trap_spawn", "s_turret_trap_d_cliff", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-21269.3, 8470.83, 2600.75), (0, 39.99, 0), "s_turret_trap_d_cliff", undefined, "activity_turret_trap_d_cliff", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-21286.2, 8494.45, 2566.25), (0, 39.99, 0), "turret_trap_panel", "s_turret_trap_d_cliff", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_7227bf194ed61c93(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-33990, 3443, 1212.75), (0, 10.1, 0), "turret_trap_spawn", "s_turret_trap_d_dock", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-33991.3, 3443.91, 1297.25), (0, 280.1, 0), "s_turret_trap_d_dock", undefined, "activity_turret_trap_d_dock", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-33962.3, 3446.81, 1262.75), (0, 280.1, 0), "turret_trap_panel", "s_turret_trap_d_dock", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_79cc156cb0ec3605(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-33139.3, 5070.64, 1061.25), (0, 280.01, 0), "turret_trap_spawn", "s_turret_trap_d_alley", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-33138.4, 5071.93, 1145.75), (0, 190.01, 0), "s_turret_trap_d_alley", undefined, "activity_turret_trap_d_alley", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-33135.6, 5043.04, 1111.25), (0, 190.01, 0), "turret_trap_panel", "s_turret_trap_d_alley", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_91f39cf5907c54d5(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-35572.2, 8995.68, 1268.5), (0, 101.6, 0), "turret_trap_spawn", "s_turret_trap_d_rails", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-35573.1, 8994.38, 1353), (0, 11.6, 0), "s_turret_trap_d_rails", undefined, "activity_turret_trap_d_rails", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-35576.8, 9023.17, 1318.5), (0, 11.6, 0), "turret_trap_panel", "s_turret_trap_d_rails", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_e433390f8558b87e(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-27422.2, 5455.76, 1030.5), (0, 103.8, 0), "turret_trap_spawn", "s_turret_trap_d_condos", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-27423, 5454.43, 1115), (0, 13.8, 0), "s_turret_trap_d_condos", undefined, "activity_turret_trap_d_condos", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-27427.8, 5483.06, 1080.5), (0, 13.8, 0), "turret_trap_panel", "s_turret_trap_d_condos", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_1dc4a74c75d87c0c(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-35234.8, -526.19, 959.25), (0, 190.31, 0), "turret_trap_spawn", "s_turret_trap_d_jetty", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-35233.5, -527.09, 1043.75), (0, 100.31, 0), "s_turret_trap_d_jetty", undefined, "activity_turret_trap_d_jetty", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-35262.4, -530.03, 1009.25), (0, 100.31, 0), "turret_trap_panel", "s_turret_trap_d_jetty", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_f4bdc905808865f1(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-25887.8, 206.01, 1222.25), (0, 20.01, 0), "turret_trap_spawn", "s_turret_trap_d_burger", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-25889.2, 206.68, 1306.75), (0, 290.01, 0), "s_turret_trap_d_burger", undefined, "activity_turret_trap_d_burger", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-25861.2, 214.46, 1272.25), (0, 290.01, 0), "turret_trap_panel", "s_turret_trap_d_burger", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_172d7bf100b9011(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-27579.8, 15145.4, 1331.25), (0, 349.01, 0), "turret_trap_spawn", "s_turret_trap_d_cafe", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-27580.6, 15146.7, 1415.75), (0, 259.01, 0), "s_turret_trap_d_cafe", undefined, "activity_turret_trap_d_cafe", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-27552.6, 15138.9, 1381.25), (0, 259.01, 0), "turret_trap_panel", "s_turret_trap_d_cafe", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-21271.2, 8471.5, 2618.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-21274.9, 8472.98, 2648.75)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_D_CLIFF"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-33989.8, 3445.17, 1315.25);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-33986.6, 3447.63, 1345.25)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_D_DOCK"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-33137.1, 5070.44, 1163.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-33134.7, 5067.34, 1193.75)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_D_ALLEY"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-35574.4, 8995.83, 1371);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-35576.9, 8998.86, 1401)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_D_RAILS"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-27424.4, 5455.83, 1133);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-27427, 5458.76, 1163)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_D_CONDOS"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-35235, -528.39, 1061.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-35238.1, -530.81, 1091.75)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_D_JETTY"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-25887.9, 208.22, 1324.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-25885.3, 211.12, 1354.75)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_D_BURGER"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_d_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-27578.7, 15147.3, 1433.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-27575, 15148.5, 1463.75)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_D_CAFE"] = instancestruct;
  return activityinstances;
}