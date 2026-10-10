/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_517154e1b41110b5.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_f_ob_contracts_outlast_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_f_ob_contracts_outlast_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_f_ob_contracts_outlast_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_f_ob_contracts_outlast_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_f_ob_contracts_outlast_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_f_ob_contracts_outlast_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_f_ob_contracts_outlast_cs");
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
    cf = "mp_jup_st_f_ob_contracts_outlast_cs";
  }

  switch (instancename) {
    case #"hash_f14cf7b81a0baf85":
      function_e1e18f51c8408c8(fe, us, cf);
      break;
  }
}

function function_e1e18f51c8408c8(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (41963, -4990, 2994), (0, 247.1, 0), "ava_tablet", "s_outlast_f_shipment", "ava_tablet", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (42288.3, -4586.04, 2992.5), (0, 220.97, 0), "s_outlast_f_shipment_reward", "s_outlast_f_shipment", "s_outlast_f_shipment_reward", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (42183, -4587.58, 2991.5), (0, 91.81, 0), "pnd", "s_outlast_f_shipment", "pnd", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (42451.8, -6335, 2983.5), (0, 265, 0), "zombie_spawn_wave_1", "s_outlast_f_shipment", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (42185.5, -4586.44, 3047), (0, 1.81, 0), "s_outlast_f_shipment", "s_outlast_f_shipment", "objective_outlast_f_shipment", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (43532, -4063, 2985), (0, 142.8, 0), "zombie_spawn_wave_3", "s_outlast_f_shipment", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (41192, -3674.5, 2968), (0, 135, 0), "zombie_spawn_wave_3", "s_outlast_f_shipment", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (42084.5, -3623, 2987.5), (0, 265, 0), "zombie_spawn_wave_2", "s_outlast_f_shipment", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (40460.8, -4636.5, 2968), (0, 342.6, 0), "zombie_spawn_wave_2", "s_outlast_f_shipment", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (43441, -5098.75, 2982.5), (0, 209, 0), "zombie_spawn_wave_1", "s_outlast_f_shipment", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (39026, 1786.25, 3030.25), (0, 310.38, 0), "activity_nexus_instance_joiner", "s_outlast_f_shipment", "OUTLAST_F_SHIPMENT", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (40843, -6073.75, 2979.5), (0, 135, 0), "zombie_spawn_wave_3", "s_outlast_f_shipment", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (1041.5, 945.75, 296.25);
  s.var_74e936bbadd15418 = (657.75, -18.75, 32);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (42454.6, -4906.2, 3016.5), (0, 90.19, 0), "outlast_noent_entrance_trigger", "s_outlast_f_shipment", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_f_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (42034, -4879.75, 2990.5), (0, 135, 0), "outlast_space", "s_outlast_f_shipment", "outlast_space", undefined, undefined, (0, 0, 0), (0, 0, 0), 1600);
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_outlast";
  instancestruct.cf = "mp_jup_st_f_ob_contracts_outlast_cs";
  instancestruct.scriptstructorigin = (42180.9, -4586.94, 3038);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(42046.2, -4736.5, 3010.5)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1500];
  activityinstances["OUTLAST_F_SHIPMENT"] = instancestruct;
  return activityinstances;
}