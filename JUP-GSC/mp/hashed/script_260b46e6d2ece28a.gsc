/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_260b46e6d2ece28a.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_fort_ob_contracts_outlast_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_fort_ob_contracts_outlast_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_fort_ob_contracts_outlast_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_fort_ob_contracts_outlast_cs");

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

  s cs_setup_arrays(us, "mp_jup_fort_ob_contracts_outlast_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_fort_ob_contracts_outlast_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_fort_ob_contracts_outlast_cs");
}

function function_fd69cf02ba4d90a2() {
  activityinfostruct = spawnStruct();
  activityinfostruct.name = "REV_OB_OUTLAST";
  activityinfostruct.scriptbundle = "jup_ob_activitydefinition_outlast";
  activityinfostruct.mainfunction = &main;
  activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  activityinfostruct.metadatafunction = &function_6da2952367672ac0;
  return activityinfostruct;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_fort_ob_contracts_outlast_cs";
  }

  switch (instancename) {
    case #"hash_aa333df119afeda1":
      function_66086b9bb81f5a50(fe, us, cf);
      break;
  }
}

function function_66086b9bb81f5a50(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (17915, -55577.5, 1288), (0, 15, 0), "zombie_spawn_wave_3", "s_outlast_fort", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (18592, -55312, 1152), (0, 269.7, 0), "s_outlast_fort_reward", "s_outlast_fort", "s_outlast_fort_reward", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (18591.9, -55212, 1152), (0, 179.5, 0), "pnd", "s_outlast_fort", "pnd", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (19258.3, -54608.3, 1288), (0, 195, 0), "zombie_spawn_wave_2", "s_outlast_fort", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (16042, -57051, 698), (0, 334.79, 0), "activity_nexus_instance_joiner", "s_outlast_fort", "OUTLAST_FORT", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (19097.1, -54379.2, 1152), (0, 165, 0), "zombie_spawn_wave_1", "s_outlast_fort", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (18606.1, -55018.7, 1087), (0, 91.3, 0), "s_outlast_fort", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (18982.9, -55798.6, 1152), (0, 165, 0), "zombie_spawn_wave_2", "s_outlast_fort", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (18132.3, -54354.1, 1023.61), (0, 300, 0), "zombie_spawn_wave_3", "s_outlast_fort", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (17951.7, -54353.7, 1280), (0, 270, 0), "zombie_spawn_wave_1", "s_outlast_fort", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (19173.1, -55245.2, 1280), (0, 211, 0), "zombie_spawn_wave_1", "s_outlast_fort", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (18179.1, -55793.2, 1152), (0, 31, 0), "zombie_spawn_wave_1", "s_outlast_fort", "zombie_spawn_wave_1", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (17958.9, -54958.6, 1280), (0, 15, 0), "zombie_spawn_wave_2", "s_outlast_fort", "zombie_spawn_wave_2", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (19165, -55006.5, 1288), (0, 223.4, 0), "zombie_spawn_wave_3", "s_outlast_fort", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_outlast_cs";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.var_750c4cbbadf7cc32 = (371, 574, 285);
  s.var_74e936bbadd15418 = (524, 557, 32);
  s.height = 128;
  s.length = "128";
  s.width = "128";
  fe[[f]](s, us, cf, (18668, -55081, 1177), (0, 0, 0), "outlast_noent_entrance_trigger", "s_outlast_fort", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_outlast_cs";
  s.name = "spawn";
  fe[[f]](s, us, cf, (19212.3, -55001.1, 1105), (0, 150, 0), "zombie_spawn_wave_3", "s_outlast_fort", "zombie_spawn_wave_3", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_fort_ob_contracts_outlast_cs";
  fe[[f]](s, us, cf, (18592.8, -55103, 1270.5), (0, 165, 0), "outlast_space", "s_outlast_fort", "outlast_space", undefined, undefined, (0, 0, 0), (0, 0, 0), 1000);
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_ob_activitydefinition_outlast";
  instancestruct.cf = "mp_jup_fort_ob_contracts_outlast_cs";
  instancestruct.scriptstructorigin = (18606.6, -55023.3, 1078);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(18591.5, -55108, 1327)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [1];
  activityinstances["OUTLAST_FORT"] = instancestruct;
  return activityinstances;
}