/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_523e733991571416.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_hydro_ob_contracts_outlast_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_hydro_ob_contracts_outlast_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_hydro_ob_contracts_outlast_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_hydro_ob_contracts_outlast_cs");

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

  s cs_setup_arrays(us, "mp_jup_hydro_ob_contracts_outlast_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_hydro_ob_contracts_outlast_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_hydro_ob_contracts_outlast_cs");
}

function function_fd69cf02ba4d90a2() {
  var_d13c18af4084bdfd = spawnStruct();
  var_d13c18af4084bdfd.name = "REV_OB_OUTLAST";
  var_d13c18af4084bdfd.scriptbundle = "jup_ob_activitydefinition_outlast";
  var_d13c18af4084bdfd.mainfunction = &main;
  var_d13c18af4084bdfd.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  var_d13c18af4084bdfd.var_ad1dcd56d202e9ac = &function_6da2952367672ac0;
  return var_d13c18af4084bdfd;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_hydro_ob_contracts_outlast_cs";
  }

  switch (instancename) {
    case #"hash_c787230e6ac3d1be":
      function_d67eebfdbbaf66b9(fe, us, cf);
      break;
  }
}

function function_d67eebfdbbaf66b9(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (-5696.88, 14961.2, 348.83), (0, 42.31, 0), "zombie_spawn_wave_3", "s_outlast_hydro", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-5124.98, 13998.7, 344), (0, 314.86, 0), "s_outlast_hydro_reward", "s_outlast_hydro", "s_outlast_hydro_reward", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-4900.12, 14046, 344), (0, 45, 0), "pnd", "s_outlast_hydro", "pnd", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (-5706.09, 14998.8, 349.58), (0, 192.31, 0), "zombie_spawn_wave_2", "s_outlast_hydro", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (-4633.99, 14842.3, 345.04), (0, 222.31, 0), "zombie_spawn_wave_2", "s_outlast_hydro", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-5652.98, 14501.5, 392), (0, 0, 0), "activity_nexus_instance_joiner", "s_outlast_hydro", "OUTLAST_HYDRO", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (-4654.62, 14863.6, 345.04), (0, 192.31, 0), "zombie_spawn_wave_1", "s_outlast_hydro", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-5618.06, 14469.1, 352), (0, 91.3, 0), "s_outlast_hydro", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (-4675.1, 13902.5, 344), (0, 192.31, 0), "zombie_spawn_wave_2", "s_outlast_hydro", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (-5593.98, 13870.4, 344), (0, 327.31, 0), "zombie_spawn_wave_3", "s_outlast_hydro", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (-5673.74, 14985.7, 352), (0, 297.31, 0), "zombie_spawn_wave_1", "s_outlast_hydro", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (-5636.8, 13909.4, 344), (0, 238.31, 0), "zombie_spawn_wave_1", "s_outlast_hydro", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (-4695.63, 13886.9, 344), (0, 58.31, 0), "zombie_spawn_wave_1", "s_outlast_hydro", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (-5616.79, 13886.1, 344), (0, 42.31, 0), "zombie_spawn_wave_2", "s_outlast_hydro", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (-4706.63, 13865.3, 344), (0, 250.71, 0), "zombie_spawn_wave_3", "s_outlast_hydro", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (333, 494, 285);
  s.var_74e936bbadd15418 = (470, 467, 32);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (-5108.69, 14463.4, 344), (0, 45, 0), "outlast_noent_entrance_trigger", "s_outlast_hydro", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (-4610.24, 14817.9, 345.04), (0, 177.31, 0), "zombie_spawn_wave_3", "s_outlast_hydro", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_hydro_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (-5106.25, 14322.3, 369), (0, 165, 0), "outlast_space", "s_outlast_hydro", "outlast_space", undefined, undefined, (0, 0, 0), (0, 0, 0), 1000);
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_outlast";
  instancestruct.cf = "mp_jup_hydro_ob_contracts_outlast_cs";
  instancestruct.scriptstructorigin = (-5096.49, 14029, 344);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-5102.69, 14324.3, 369)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1];
  activityinstances["OUTLAST_HYDRO"] = instancestruct;
  return activityinstances;
}