/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1abaac48721dbd19.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_h_ob_interactions_turret_trap_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_h_ob_interactions_turret_trap_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_h_ob_interactions_turret_trap_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_h_ob_interactions_turret_trap_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_h_ob_interactions_turret_trap_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_h_ob_interactions_turret_trap_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_h_ob_interactions_turret_trap_cs");
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
    cf = "mp_jup_st_h_ob_interactions_turret_trap_cs";
  }

  switch (instancename) {
    case #"hash_9bc0d38baeb09747":
      function_6f4a092fc8c4debc(fe, us, cf);
      break;
    case #"hash_5ffddcf98d734a08":
      function_73e3af8c9d5cc295(fe, us, cf);
      break;
    case #"hash_2365e5b926ff46c4":
      function_99ddad165b63dd75(fe, us, cf);
      break;
    case #"hash_12cb50edac6ca859":
      function_5655990ff489ce72(fe, us, cf);
      break;
    case #"hash_80ebcfa10b223bcd":
      function_1806eccbc2af5d90(fe, us, cf);
      break;
    case #"hash_adf33c108a862d1c":
      function_252aa5ae24682173(fe, us, cf);
      break;
    case #"hash_e61bb2382abeb1ae":
      function_b83e2f85b998ca01(fe, us, cf);
      break;
  }
}

function function_6f4a092fc8c4debc(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (16582.5, -35180.6, 3113.25), (0, 241.5, 0), "turret_trap_spawn", "s_turret_trap_h_outskirts", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (16583.9, -35180, 3197.75), (0, 151.5, 0), "s_turret_trap_h_outskirts", undefined, "activity_turret_trap_h_outskirts", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (16568.2, -35204.5, 3163.25), (0, 151.5, 0), "turret_trap_panel", "s_turret_trap_h_outskirts", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_73e3af8c9d5cc295(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (11177.6, -34530.9, 2878.5), (0, 17.51, 0), "turret_trap_spawn", "s_turret_trap_h_construction", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (11176.2, -34530.4, 2963), (0, 287.51, 0), "s_turret_trap_h_construction", undefined, "activity_turret_trap_h_construction", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (11204.5, -34523.6, 2928.5), (0, 287.51, 0), "turret_trap_panel", "s_turret_trap_h_construction", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_99ddad165b63dd75(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (5256.85, -41805.2, 2945.5), (0, 212.06, 0), "turret_trap_spawn", "s_turret_trap_h_roadside", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (5258.36, -41805.4, 3030), (0, 122.06, 0), "s_turret_trap_h_roadside", undefined, "activity_turret_trap_h_roadside", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (5232.62, -41818.9, 2995.5), (0, 122.06, 0), "turret_trap_panel", "s_turret_trap_h_roadside", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_5655990ff489ce72(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (9920.85, -19288.9, 1708.5), (0, 212.34, 0), "turret_trap_spawn", "s_turret_trap_h_hotel", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (9922.33, -19289, 1793), (0, 122.34, 0), "s_turret_trap_h_hotel", undefined, "activity_turret_trap_h_hotel", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (9896.7, -19302.7, 1758.5), (0, 122.34, 0), "turret_trap_panel", "s_turret_trap_h_hotel", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_1806eccbc2af5d90(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (14891.3, -23025.9, 1994.5), (0, 180.03, 0), "turret_trap_spawn", "s_turret_trap_h_market", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (14892.5, -23026.8, 2079), (0, 90.03, 0), "s_turret_trap_h_market", undefined, "activity_turret_trap_h_market", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (14863.5, -23024.6, 2044.5), (0, 90.03, 0), "turret_trap_panel", "s_turret_trap_h_market", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_252aa5ae24682173(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (2876.13, -34823.8, 2135), (0, 285.05, 0), "turret_trap_spawn", "s_turret_trap_h_gym", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (2876.67, -34822.4, 2219.5), (0, 195.05, 0), "s_turret_trap_h_gym", undefined, "activity_turret_trap_h_gym", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (2882.14, -34851, 2185), (0, 195.05, 0), "turret_trap_panel", "s_turret_trap_h_gym", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_b83e2f85b998ca01(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (6951.43, -23610.2, 1866.25), (0, 80.66, 0), "turret_trap_spawn", "s_turret_trap_h_theater", "turret_trap_spawn", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (6950.36, -23611.3, 1950.75), (0, 350.66, 0), "s_turret_trap_h_theater", undefined, "activity_turret_trap_h_theater", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_h_ob_interactions_turret_trap_cs";
  fe[[f]](s, us, cf, (6957.19, -23583, 1916.25), (0, 350.66, 0), "turret_trap_panel", "s_turret_trap_h_theater", "turret_trap_panel", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_h_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (16583.9, -35182.1, 3215.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(16584, -35186.1, 3245.75)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_H_OUTSKIRTS"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_h_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (11177.7, -34528.9, 2981);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(11180.3, -34525.9, 3011)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_H_CONSTRUCTION"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_h_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (5257.27, -41807.2, 3048);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(5255.44, -41810.7, 3078)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_H_ROADSIDE"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_h_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (9921.26, -19290.8, 1811);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(9919.49, -19294.3, 1841)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_H_HOTEL"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_h_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (14890.7, -23027.7, 2097);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(14887.3, -23029.7, 2127)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_H_MARKET"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_h_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (2878.08, -34824, 2237.5);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(2880.89, -34826.8, 2267.5)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_H_GYM"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_turret_trap";
  instancestruct.cf = "mp_jup_st_h_ob_interactions_turret_trap_cs";
  instancestruct.scriptstructorigin = (6949.73, -23609.2, 1968.75);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(6948.33, -23605.5, 1998.75)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [100];
  activityinstances["TURRET_TRAP_H_THEATER"] = instancestruct;
  return activityinstances;
}