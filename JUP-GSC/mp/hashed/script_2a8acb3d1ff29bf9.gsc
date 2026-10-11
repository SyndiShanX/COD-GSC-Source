/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2a8acb3d1ff29bf9.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_g_ob_interactions_turret_trap_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_g_ob_interactions_turret_trap_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_g_ob_interactions_turret_trap_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_g_ob_interactions_turret_trap_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_g_ob_interactions_turret_trap_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_g_ob_interactions_turret_trap_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_g_ob_interactions_turret_trap_cs");
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
    cf = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  }

  switch (instancename) {
    case #"hash_3ac992cae6753414":
      function_3d95ea1a8c15bae9(fe, us, cf);
      break;
    case #"hash_c4f6004500356a8e":
      function_d586b7cd019f2755(fe, us, cf);
      break;
    case #"hash_9e5340af6c017477":
      function_3aadced07e035f72(fe, us, cf);
      break;
    case #"hash_3325d1af62fd73c7":
      function_79d21a3cf17e6586(fe, us, cf);
      break;
    case #"hash_dc5cc906ebe799b5":
      function_35300ee6b85392c(fe, us, cf);
      break;
    case #"hash_a5b4d507101126b1":
      function_d591e8e446ddcd6c(fe, us, cf);
      break;
    case #"hash_3751a2e74d81079e":
      function_6d9239bc9ef12233(fe, us, cf);
      break;
    case #"hash_d0dca39437db8d2a":
      function_10074f5e4610c967(fe, us, cf);
      break;
  }
}

function function_3d95ea1a8c15bae9(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-25330.5, -25483.5, 2027.5), (0, 166.1, 0), "turret_trap_spawn", "s_turret_trap_g_shipment", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-25329.5, -25484.6, 2112), (0, 76.1, 0), "s_turret_trap_g_shipment", undefined, "activity_turret_trap_g_shipment", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-25357.1, -25475.6, 2077.5), (0, 76.1, 0), "turret_trap_panel", "s_turret_trap_g_shipment", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_d586b7cd019f2755(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-25354, -9924.5, 1671.5), (0, 89.6, 0), "turret_trap_spawn", "s_turret_trap_g_field", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-25354.8, -9925.72, 1756), (0, 359.6, 0), "s_turret_trap_g_field", undefined, "activity_turret_trap_g_field", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-25352.5, -9896.79, 1721.5), (0, 359.6, 0), "turret_trap_panel", "s_turret_trap_g_field", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_3aadced07e035f72(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-8017.75, -12885, 1991.5), (0, 225.24, 0), "turret_trap_spawn", "s_turret_trap_g_playground", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-8016.32, -12884.7, 2076), (0, 135.24, 0), "s_turret_trap_g_playground", undefined, "activity_turret_trap_g_playground", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-8038.2, -12903.8, 2041.5), (0, 135.24, 0), "turret_trap_panel", "s_turret_trap_g_playground", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_79d21a3cf17e6586(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-9785.93, -14376.3, 1905.25), (0, 135.24, 0), "turret_trap_spawn", "s_turret_trap_g_cafe", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-9785.63, -14377.8, 1989.75), (0, 45.24, 0), "s_turret_trap_g_cafe", undefined, "activity_turret_trap_g_cafe", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-9804.73, -14355.9, 1955.25), (0, 45.24, 0), "turret_trap_panel", "s_turret_trap_g_cafe", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_35300ee6b85392c(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-9333.27, -9562.61, 2305.75), (0, 331.52, 0), "turret_trap_spawn", "s_turret_trap_g_dealership", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-9333.97, -9561.29, 2390.25), (0, 241.52, 0), "s_turret_trap_g_dealership", undefined, "activity_turret_trap_g_dealership", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-9309.52, -9576.96, 2355.75), (0, 241.52, 0), "turret_trap_panel", "s_turret_trap_g_dealership", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_d591e8e446ddcd6c(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-2611.56, -23274, 2215), (0, 176.93, 0), "turret_trap_spawn", "s_turret_trap_g_overpass", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-2610.35, -23274.9, 2299.5), (0, 86.93, 0), "s_turret_trap_g_overpass", undefined, "activity_turret_trap_g_overpass", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-2639.17, -23271.3, 2265), (0, 86.93, 0), "turret_trap_panel", "s_turret_trap_g_overpass", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6d9239bc9ef12233(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-5345.03, -15521.4, 2335.25), (0, 224.49, 0), "turret_trap_spawn", "s_turret_trap_g_neighborhood", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-5343.56, -15521.1, 2419.75), (0, 134.49, 0), "s_turret_trap_g_neighborhood", undefined, "activity_turret_trap_g_neighborhood", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-5365.7, -15539.9, 2385.25), (0, 134.49, 0), "turret_trap_panel", "s_turret_trap_g_neighborhood", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_10074f5e4610c967(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-20592.9, -37079, 2708.5), (0, 340.33, 0), "turret_trap_spawn", "s_turret_trap_g_museum", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-20593.8, -37077.8, 2793), (0, 250.33, 0), "s_turret_trap_g_museum", undefined, "activity_turret_trap_g_museum", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (-20567.2, -37089.5, 2758.5), (0, 250.33, 0), "turret_trap_panel", "s_turret_trap_g_museum", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-25331.5, -25485.1, 2130);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-25335.4, -25486.2, 2160)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_G_SHIPMENT"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-25355.8, -9923.9, 1774);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-25357.8, -9920.37, 1804)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_G_FIELD"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-8016.88, -12886.7, 2094);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-8017.92, -12890.6, 2124)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_G_PLAYGROUND"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-9787.63, -14377.2, 2007.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-9791.53, -14376.2, 2037.75)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_G_CAFE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-9331.9, -9561.31, 2408.25);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-9327.85, -9561.23, 2438.25)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_G_DEALERSHIP"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-2612.23, -23275.8, 2317.5);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-2615.86, -23277.6, 2347.5)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_G_OVERPASS"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-5344.19, -15523.1, 2437.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-5345.3, -15527, 2467.75)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_G_NEIGHBORHOOD"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_g_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (-20591.7, -37077.5, 2811);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-20587.7, -37076.8, 2841)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_G_MUSEUM"] = instancestruct;
  return activityinstances;
}