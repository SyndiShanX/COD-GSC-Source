/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_73b3b10793e9dd5.gsc
************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_e_ob_interactions_turret_trap_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_e_ob_interactions_turret_trap_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_e_ob_interactions_turret_trap_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_e_ob_interactions_turret_trap_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_e_ob_interactions_turret_trap_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_e_ob_interactions_turret_trap_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_e_ob_interactions_turret_trap_cs");
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
    cf = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  }

  switch (instancename) {
    case #"hash_385af1b395ba07e9":
      function_1f46dbddddccf9f8(fe, us, cf);
      break;
    case #"hash_dcc040af905fea7d":
      function_8943c44702ab2176(fe, us, cf);
      break;
    case #"hash_8f928d9dc336469f":
      function_108549ab362aa5f0(fe, us, cf);
      break;
    case #"hash_40412f8eb0339624":
      function_c747f97477f41ee1(fe, us, cf);
      break;
    case #"hash_d9b27d5ed4350517":
      function_470306b2fdd37c68(fe, us, cf);
      break;
    case #"hash_44c346b780de4d2b":
      function_1eb29a0346bd86fc(fe, us, cf);
      break;
    case #"hash_2b746e4e324e4552":
      function_8dda821e43c14f31(fe, us, cf);
      break;
    case #"hash_d0c7767f4f5d1edf":
      function_afc26b03e9b6051a(fe, us, cf);
      break;
    case #"hash_1ac4dd13d60d790b":
      function_a109348f9728db12(fe, us, cf);
      break;
    case #"hash_1a7efc83ca9ccec7":
      function_6a021df6efbd2498(fe, us, cf);
      break;
    case #"hash_605b9f71df09f383":
      function_87c9af9f34c5cc40(fe, us, cf);
      break;
  }
}

function function_1f46dbddddccf9f8(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (1726.11, -6322, 2007.5), (0, 135.3, 0), "turret_trap_spawn", "s_turret_trap_e_bridge", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (1726.18, -6323.55, 2092), (0, 45.3, 0), "s_turret_trap_e_bridge", undefined, "activity_turret_trap_e_bridge", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (1707.11, -6301.6, 2057.5), (0, 45.3, 0), "turret_trap_panel", "s_turret_trap_e_bridge", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_8943c44702ab2176(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (19749.1, -5796, 1851.5), (0, 242.3, 0), "turret_trap_spawn", "s_turret_trap_e_alley", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (19750.6, -5795.48, 1936), (0, 152.3, 0), "s_turret_trap_e_alley", undefined, "activity_turret_trap_e_alley", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (19735.2, -5820.13, 1901.5), (0, 152.3, 0), "turret_trap_panel", "s_turret_trap_e_alley", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_108549ab362aa5f0(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (6721.1, -4980, 2391.5), (0, 135.7, 0), "turret_trap_spawn", "s_turret_trap_e_courtyard", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (6721.17, -4981.59, 2476), (0, 45.7, 0), "s_turret_trap_e_courtyard", undefined, "activity_turret_trap_e_courtyard", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (6701.95, -4959.79, 2441.5), (0, 45.7, 0), "turret_trap_panel", "s_turret_trap_e_courtyard", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_c747f97477f41ee1(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-707.78, 2521.62, 2236.5), (0, 269.5, 0), "turret_trap_spawn", "s_turret_trap_e_park", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-706.68, 2522.77, 2321), (0, 179.5, 0), "s_turret_trap_e_park", undefined, "activity_turret_trap_e_park", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-709.11, 2493.81, 2286.5), (0, 179.5, 0), "turret_trap_panel", "s_turret_trap_e_park", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_470306b2fdd37c68(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-3214.83, -3987.41, 2191.5), (0, 195.1, 0), "turret_trap_spawn", "s_turret_trap_e_dense", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-3213.42, -3988.16, 2276), (0, 105.1, 0), "s_turret_trap_e_dense", undefined, "activity_turret_trap_e_dense", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-3241.97, -3993.6, 2241.5), (0, 105.1, 0), "turret_trap_panel", "s_turret_trap_e_dense", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_1eb29a0346bd86fc(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (3737.58, 8551.32, 1443.5), (0, 314.2, 0), "turret_trap_spawn", "s_turret_trap_e_bathhouse", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (3737.55, 8552.91, 1528), (0, 224.2, 0), "s_turret_trap_e_bathhouse", undefined, "activity_turret_trap_e_bathhouse", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (3756.19, 8530.62, 1493.5), (0, 224.2, 0), "turret_trap_panel", "s_turret_trap_e_bathhouse", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_8dda821e43c14f31(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (1509.25, 1395.87, 2286.5), (0, 223.7, 0), "turret_trap_spawn", "s_turret_trap_e_crossroad", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (1510.84, 1395.88, 2371), (0, 133.7, 0), "s_turret_trap_e_crossroad", undefined, "activity_turret_trap_e_crossroad", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (1488.39, 1377.43, 2336.5), (0, 133.7, 0), "turret_trap_panel", "s_turret_trap_e_crossroad", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_afc26b03e9b6051a(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (6830.57, 269.19, 2285.5), (0, 225.4, 0), "turret_trap_spawn", "s_turret_trap_e_overpass", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (6832.16, 269.25, 2370), (0, 135.4, 0), "s_turret_trap_e_overpass", undefined, "activity_turret_trap_e_overpass", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (6810.27, 250.14, 2335.5), (0, 135.4, 0), "turret_trap_panel", "s_turret_trap_e_overpass", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_a109348f9728db12(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-10489, 1169.67, 1442.5), (0, 340.5, 0), "turret_trap_spawn", "s_turret_trap_e_dock", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-10489.8, 1171.08, 1527), (0, 250.5, 0), "s_turret_trap_e_dock", undefined, "activity_turret_trap_e_dock", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-10463.2, 1159.35, 1492.5), (0, 250.5, 0), "turret_trap_panel", "s_turret_trap_e_dock", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6a021df6efbd2498(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (22906.5, -144.65, 2667.5), (0, 172.9, 0), "turret_trap_spawn", "s_turret_trap_e_tin", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (22907.6, -145.87, 2752), (0, 82.9, 0), "s_turret_trap_e_tin", undefined, "activity_turret_trap_e_tin", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (22879.1, -140.13, 2717.5), (0, 82.9, 0), "turret_trap_panel", "s_turret_trap_e_tin", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_87c9af9f34c5cc40(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-12822.9, 4059.03, 1261.5), (0, 70.4, 0), "turret_trap_spawn", "s_turret_trap_e_container", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-12824.3, 4058.23, 1346), (0, 340.4, 0), "s_turret_trap_e_container", undefined, "activity_turret_trap_e_container", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-12812.6, 4084.8, 1311.5), (0, 340.4, 0), "turret_trap_panel", "s_turret_trap_e_container", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (1724.1, -6323, 2110);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(1720.31, -6321.95, 2140)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_E_BRIDGE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (19750.7, -5797.63, 1954);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(19750.8, -5801.56, 1984)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_E_ALLEY"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (6719.08, -4981.07, 2494);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(6715.28, -4980.04, 2524)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_E_COURTYARD"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-705.61, 2520.9, 2339);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-703.72, 2517.45, 2369)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_E_PARK"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-3214.94, -3989.69, 2294);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-3217.75, -3992.44, 2324)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_E_DENSE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (3739.63, 8552.34, 1546);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(3743.39, 8551.21, 1576)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_E_BATHHOUSE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (1510.25, 1393.81, 2389);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(1509.09, 1390.05, 2419)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_E_CROSSROAD"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (6831.63, 267.16, 2388);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(6830.58, 263.37, 2418)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_E_OVERPASS"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-10487.7, 1171.48, 1545);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-10483.8, 1172.15, 1575)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_E_DOCK"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (22905.6, -146.73, 2770);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(22901.9, -148.2, 2800)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_E_TIN"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_e_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-12824.7, 4060.32, 1364);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-12825.4, 4064.23, 1394)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_E_CONTAINER"] = instancestruct;
  return activityinstances;
}