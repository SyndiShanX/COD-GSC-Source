/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6c9426c759bc1ce5.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_b_ob_interactions_turret_trap_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_b_ob_interactions_turret_trap_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_b_ob_interactions_turret_trap_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_b_ob_interactions_turret_trap_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_b_ob_interactions_turret_trap_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_b_ob_interactions_turret_trap_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_b_ob_interactions_turret_trap_cs");
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
    cf = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  }

  switch (instancename) {
    case #"hash_331140ec792ff9db":
      function_c716028982307e70(fe, us, cf);
      break;
    case #"hash_e40f7d722c6a1dce":
      function_80eac622d256897(fe, us, cf);
      break;
    case #"hash_38d72ff95a7115c4":
      function_734fa9d832cc5333(fe, us, cf);
      break;
    case #"hash_40ffdf90275d6aa7":
      function_cc54d915abd58e1a(fe, us, cf);
      break;
    case #"hash_c97d4a896630fc4c":
      function_c1d76875aa3d8f8b(fe, us, cf);
      break;
    case #"hash_a2abded400a6829b":
      function_55479ea676c245f0(fe, us, cf);
      break;
    case #"hash_406727feb405d97e":
      function_da8b41144f54b523(fe, us, cf);
      break;
    case #"hash_2430c8abe2a2ca99":
      function_2d7ae63e5d93b214(fe, us, cf);
      break;
    case #"hash_19acd0fcfa68920b":
      function_b16257830a8a9fd0(fe, us, cf);
      break;
  }
}

function function_c716028982307e70(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (11846, 33809, 1225.5), (0, 0, 0), "turret_trap_spawn", "s_turret_trap_b_xroad", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (11844.9, 33810.1, 1310), (0, 270, 0), "s_turret_trap_b_xroad", undefined, "activity_turret_trap_b_xroad", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (11873.9, 33807.9, 1275.5), (0, 270, 0), "turret_trap_panel", "s_turret_trap_b_xroad", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_80eac622d256897(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-7278.5, 32744, 1461.25), (0, 84.98, 0), "turret_trap_spawn", "s_turret_trap_b_bridge", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-7279.69, 32743, 1545.75), (0, 354.98, 0), "s_turret_trap_b_bridge", undefined, "activity_turret_trap_b_bridge", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-7274.96, 32771.7, 1511.25), (0, 354.98, 0), "turret_trap_panel", "s_turret_trap_b_bridge", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_734fa9d832cc5333(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-9146.72, 26692.7, 1198), (0, 109.25, 0), "turret_trap_spawn", "s_turret_trap_b_scrap", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-9147.45, 26691.3, 1282.5), (0, 19.25, 0), "s_turret_trap_b_scrap", undefined, "activity_turret_trap_b_scrap", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-9154.95, 26719.4, 1248), (0, 19.25, 0), "turret_trap_panel", "s_turret_trap_b_scrap", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_cc54d915abd58e1a(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (9872.73, 22343.2, 1006.5), (0, 70.38, 0), "turret_trap_spawn", "s_turret_trap_b_tracks", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (9871.32, 22342.5, 1091), (0, 340.38, 0), "s_turret_trap_b_tracks", undefined, "activity_turret_trap_b_tracks", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (9883.13, 22369.1, 1056.5), (0, 340.38, 0), "turret_trap_panel", "s_turret_trap_b_tracks", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_c1d76875aa3d8f8b(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (7326.8, 26680, 1280.5), (0, 343.51, 0), "turret_trap_spawn", "s_turret_trap_b_tower", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (7326.06, 26681.4, 1365), (0, 253.51, 0), "s_turret_trap_b_tower", undefined, "activity_turret_trap_b_tower", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (7353.24, 26671, 1330.5), (0, 253.51, 0), "turret_trap_panel", "s_turret_trap_b_tower", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_55479ea676c245f0(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-7886.2, 24122.1, 1164.75), (0, 58.66, 0), "turret_trap_spawn", "s_turret_trap_b_sewer", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-7887.77, 24121.8, 1249.25), (0, 328.66, 0), "s_turret_trap_b_sewer", undefined, "activity_turret_trap_b_sewer", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-7870.79, 24145.4, 1214.75), (0, 328.66, 0), "turret_trap_panel", "s_turret_trap_b_sewer", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_da8b41144f54b523(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-8225.97, 37331.5, 1772.25), (0, 357.88, 0), "turret_trap_spawn", "s_turret_trap_b_construction", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-8227.03, 37332.7, 1856.75), (0, 267.88, 0), "s_turret_trap_b_construction", undefined, "activity_turret_trap_b_construction", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-8198.13, 37329.4, 1822.25), (0, 267.88, 0), "turret_trap_panel", "s_turret_trap_b_construction", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_2d7ae63e5d93b214(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (7004.15, 38300.1, 1632.08), (0.15, 269.48, 4), "turret_trap_spawn", "s_turret_trap_b_roof", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (6999.43, 38301, 1716.46), (4, 179.47, -0.15), "s_turret_trap_b_roof", undefined, "activity_turret_trap_b_roof", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (6999.35, 38272.1, 1681.81), (4, 179.47, -0.15), "turret_trap_panel", "s_turret_trap_b_roof", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_b16257830a8a9fd0(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (3602.6, 28259.8, 1172), (0, 344.85, 0), "turret_trap_spawn", "s_turret_trap_b_nuclear", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (3601.87, 28261.2, 1256.5), (0, 254.85, 0), "s_turret_trap_b_nuclear", undefined, "activity_turret_trap_b_nuclear", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (3629.29, 28251.5, 1222), (0, 254.85, 0), "turret_trap_panel", "s_turret_trap_b_nuclear", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (11846.7, 33811.1, 1328);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(11850.1, 33813, 1358)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_B_XROAD"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-7280.53, 32744.9, 1563.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-7274.42, 32744.7, 1593.75)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_B_BRIDGE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-9148.99, 26692.7, 1300.5);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-9143.34, 26695, 1330.5)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_B_SCRAP"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (9870.99, 22344.6, 1109);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(9876.87, 22343, 1139)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_B_TRACKS"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (7328.07, 26681.8, 1383);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(7326.72, 26675.8, 1413)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_B_TOWER"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-7887.67, 24123.8, 1267.25);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-7882.27, 24120.9, 1297.25)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_B_SEWER"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-8225.18, 37333.6, 1874.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-8225.07, 37327.5, 1904.75)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_B_CONSTRUCTION"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (6999.12, 38299.1, 1734.48);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(6990.95, 38298.8, 1763.98)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_B_ROOF"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_b_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (3603.89, 28261.6, 1274.5);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(3602.59, 28255.7, 1304.5)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_B_NUCLEAR"] = instancestruct;
  return activityinstances;
}