/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1bef656425d9c877.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_c_ob_escort_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_c_ob_escort_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_c_ob_escort_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_c_ob_escort_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_c_ob_escort_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_c_ob_escort_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_c_ob_escort_cs");
}

function function_fd69cf02ba4d90a2() {
  var_d13c18af4084bdfd = spawnStruct();
  var_d13c18af4084bdfd.name = "REV_OB_ESCORT_ZOMBIES";
  var_d13c18af4084bdfd.mainfunction = &main;
  var_d13c18af4084bdfd.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  var_d13c18af4084bdfd.var_ad1dcd56d202e9ac = &function_6da2952367672ac0;
  return var_d13c18af4084bdfd;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_c_ob_escort_cs";
  }

  switch (instancename) {
    case #"hash_2057659426970bdd":
      function_fcb98623bee7afca(fe, us, cf);
      break;
    case #"hash_217a3fe5ef40b5d3":
      function_5a23cd8e0e0283cc(fe, us, cf);
      break;
  }
}

function function_fcb98623bee7afca(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (36440, 25160, 1606.47), (0, 0, 0), "escort_base_comms_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (33836, 25256.5, 1544), (0, 0, 0), "ESCORT_ZOMBIES_BASE_COMMS", undefined, "escort_base_comms", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (36168, 25888, 1601.26), (0, 0, 0), "escort_base_comms_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (37968, 25936, 1819.55), (0, 0, 0), "escort_base_comms_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (37424, 26880, 1929.37), (0, 0, 0), "escort_base_comms_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (39454, 25928, 2165.33), (0, 0, 0), "escort_base_comms_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (38368, 28160, 1790), (0, 0, 0), "escort_base_comms_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (41396, 27636, 1773), (0, 0, 0), "escort_base_comms_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (42422, 28104, 2149.83), (0, 0, 0), "escort_base_comms_ambush_05", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (42624, 28912, 2170.67), (0, 0, 0), "escort_base_comms_ambush_06", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (43292, 30044, 2440.87), (0, 0, 0), "escort_base_comms_ambush_07", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (43728, 31504, 2592), (0, 0, 0), "escort_base_comms_ambush_08", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (43656, 33232, 2718), (0, 0, 0), "escort_base_comms_ambush_09", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (42696, 33176, 2588), (0, 0, 0), "escort_base_comms_ambush_09", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (43512, 34072, 2586), (0, 0, 0), "escort_base_comms_ambush_10", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (42328, 34064, 2571.59), (0, 0, 0), "escort_base_comms_ambush_10", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (41968, 34496, 2595), (0, 0, 0), "escort_base_comms_ambush_11", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (38432, 28104, 1780), (0, 0, 0), "escort_base_comms_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (39782, 26490, 1944.07), (0, 0, 0), "escort_base_comms_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (37496, 27072, 1897.18), (0, 0, 0), "escort_base_comms_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (42944, 30648, 2352.01), (0, 0, 0), "escort_base_comms_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (44192, 31688, 2586), (0, 0, 0), "escort_base_comms_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (42760, 31744, 2517.2), (0, 0, 0), "escort_base_comms_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (43472, 34448, 2646), (0, 0, 0), "escort_base_comms_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (41632, 34352, 2586), (0, 0, 0), "escort_base_comms_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (42288, 33632, 2587), (0, 0, 0), "escort_base_comms_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (42448, 34360, 2586), (0, 195, 0), "ESCORT_ZOMBIES_BASE_COMMS_REWARD", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (36850, 28083, 1806), (0, 53.23, 0), "activity_nexus_instance_joiner", "ESCORT_ZOMBIES_BASE_COMMS", "ESCORT_ZOMBIES_BASE_COMMS", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (39418, 27298, 1766.56), (0, 0, 0), "escort_c_base_comms_horde_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (43366, 32032, 2586), (0, 0, 0), "escort_c_base_comms_horde_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (42384, 35254, 2584), (0, 0, 0), "escort_c_base_comms_horde_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_5a23cd8e0e0283cc(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (33780, 34742, 1045), (0, 275, 0), "ESCORT_ZOMBIES_C_PORT_REWARD", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (23658, 32910.5, 1586.52), (0, 117.25, 0), "activity_nexus_instance_joiner", "ESCORT_ZOMBIES_C_PORT", "ESCORT_ZOMBIES_C_PORT", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (26264, 33052, 1356), (0, 0, 0), "ESCORT_ZOMBIES_C_PORT", undefined, "escort_c_port", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (28864, 32384, 1349), (0, 0, 0), "escort_c_port_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (27830, 33294, 1349), (0, 0, 0), "escort_c_port_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (28397, 31595, 1348.96), (0, 0, 0), "escort_c_port_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (29820, 32748, 1349), (0, 0, 0), "escort_c_port_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (30904, 33832, 1196.11), (0, 0, 0), "escort_c_port_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (29836, 33852, 1331.21), (0, 0, 0), "escort_c_port_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (29364, 34976, 1189), (0, 0, 0), "escort_c_port_ambush_05", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (30532, 34984, 1197), (0, 0, 0), "escort_c_port_ambush_05", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (29300, 35828, 1189), (0, 0, 0), "escort_c_port_ambush_06", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (30560, 35772, 1124.92), (0, 0, 0), "escort_c_port_ambush_06", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (30584, 37224, 1037), (0, 0, 0), "escort_c_port_ambush_07", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (31852, 36676, 1037), (0, 0, 0), "escort_c_port_ambush_08", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (31536, 36020, 1037), (0, 0, 0), "escort_c_port_ambush_08", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (32668, 36372, 1045), (0, 0, 0), "escort_c_port_ambush_09", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (32444, 35284, 1037.95), (0, 0, 0), "escort_c_port_ambush_09", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (33028, 34948, 1037), (0, 0, 0), "escort_c_port_ambush_10", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (33772, 35712, 1045), (0, 0, 0), "escort_c_port_ambush_10", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (34187, 34772, 1042), (0, 0, 0), "escort_c_port_ambush_11", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (29700, 33636, 1349), (0, 0, 0), "escort_c_port_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (28704, 33408, 1344), (0, 0, 0), "escort_c_port_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (28699, 31662, 1355.44), (0, 0, 0), "escort_c_port_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (31288, 37172, 1037), (0, 0, 0), "escort_c_port_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (29496, 37636, 993.01), (0, 0, 0), "escort_c_port_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (30596, 36228, 1037), (0, 0, 0), "escort_c_port_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (33134, 34580, 1044), (0, 0, 0), "escort_c_port_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (33860, 35948, 1045), (0, 0, 0), "escort_c_port_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (32912, 34860, 1037), (0, 0, 0), "escort_c_port_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (30878, 37758, 1042), (0, 0, 0), "escort_c_port_horde_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (29612, 33284, 1354), (0, 0, 0), "escort_c_port_horde_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (34418, 34625, 1050), (0, 0, 0), "escort_c_port_horde_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_escort_cs";
  fe[[f]](s, us, cf, (27435, 32235, 1362.37), (0, 0, 0), "escort_c_port_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_escort";
  instancestruct.cf = "mp_jup_st_c_ob_escort_cs";
  instancestruct.scriptstructorigin = (33896, 25696, 1528);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(43632, 31120, 2583.46), (42776, 34480, 2576), (38544, 27040, 1786.13), (33884.7, 25406.4, 1500.87)];
  instancestruct.locationoriginoffset = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.locationradius = [1250, 1250, 1250, 1000];
  activityinstances["ESCORT_ZOMBIES_BASE_COMMS"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_escort";
  instancestruct.cf = "mp_jup_st_c_ob_escort_cs";
  instancestruct.scriptstructorigin = (26280, 33164, 1360);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(29624, 32812, 1349), (26882, 33261, 1347.09), (30560, 37156, 1037), (34018, 35086, 1045)];
  instancestruct.locationoriginoffset = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.locationradius = [1000, 1000, 1000, 1000];
  activityinstances["ESCORT_ZOMBIES_C_PORT"] = instancestruct;
  return activityinstances;
}