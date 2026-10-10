/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1833cdd12277f198.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_g_ob_contracts_vehicle_drive_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_g_ob_contracts_vehicle_drive_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_g_ob_contracts_vehicle_drive_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_g_ob_contracts_vehicle_drive_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_g_ob_contracts_vehicle_drive_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_g_ob_contracts_vehicle_drive_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  fe[[f]](s, us, cf, (-33677, -21871, 992.8), (0, 0, 0), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  fe[[f]](s, us, cf, (-2099, -23886, 1707.95), (0, 0, 0), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  fe[[f]](s, us, cf, (-21739, -40880, 2720.99), (0, 0, 0), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  fe[[f]](s, us, cf, (-16359, -40939, 2820), (0, 0, 0), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  fe[[f]](s, us, cf, (-2120, -29584, 2176), (0, 0, 0), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  fe[[f]](s, us, cf, (-11, -14484, 1740.23), (0, 0, 0), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  fe[[f]](s, us, cf, (-34502, -31471, 2017.5), (0, 0, 0), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
  s.script_unload = "default";
  s.spawngroup = "heli_test_guys";
  fe[[f]](s, us, cf, (-18240, -8256, 4992), (0, 260, 0), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
  s.script_unload = "default";
  s.spawngroup = "heli_test_guys";
  fe[[f]](s, us, cf, (-25600, -15616, 5824), (0, 305, 0), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
  s.script_unload = "default";
  s.spawngroup = "heli_test_guys";
  fe[[f]](s, us, cf, (-16672, -25184, 5152), (0, 350, 0), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
  s.script_unload = "default";
  s.spawngroup = "heli_test_guys";
  fe[[f]](s, us, cf, (-22592, -32544, 6496), (0, 35, 0), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
  s.script_unload = "default";
  s.spawngroup = "heli_test_guys";
  fe[[f]](s, us, cf, (-12704, -34560, 5504), (0, 95, 0), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
  s.script_unload = "default";
  s.spawngroup = "heli_test_guys";
  fe[[f]](s, us, cf, (-6176, -18752, 5696), (0, 140, 0), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
  s.script_unload = "default";
  s.spawngroup = "heli_test_guys";
  fe[[f]](s, us, cf, (-7040, -10784, 4544), (0, 185, 0), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
  s.script_unload = "default";
  s.spawngroup = "heli_test_guys";
  fe[[f]](s, us, cf, (-27232, -24224, 5728), (0, 215, 0), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
  s.script_unload = "default";
  s.spawngroup = "heli_test_guys";
  fe[[f]](s, us, cf, (-16480, -16896, 5824), (0, 305, 0), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
  s.name = "script_struct";
  s.script_unload = "default";
  s.spawngroup = "heli_test_guys";
  fe[[f]](s, us, cf, (-7232, -27072, 5696), (0, 140, 0), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  fe[[f]](s, us, cf, (-7431, -27567, 1713.97), (0, 0, 0), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  fe[[f]](s, us, cf, (-8854, -16882, 1703.23), (0, 0, 0), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  fe[[f]](s, us, cf, (-14551, -10821, 1712), (0, 0, 0), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  fe[[f]](s, us, cf, (-22768, -9816, 1504.99), (0, 0, 0), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  fe[[f]](s, us, cf, (-27422, -13123, 1520.8), (0, 0, 0), "dmz_vehicledrive_end", undefined, undefined, undefined, undefined, undefined, undefined, 200);
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_g_ob_contracts_vehicle_drive_cs");
}

function function_fd69cf02ba4d90a2() {
  var_d13c18af4084bdfd = spawnStruct();
  var_d13c18af4084bdfd.name = "REV_OB_VEHICLE_DRIVE";
  var_d13c18af4084bdfd.scriptbundle = "jup_activitydefinition_vehicle_drive";
  var_d13c18af4084bdfd.mainfunction = &main;
  var_d13c18af4084bdfd.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  var_d13c18af4084bdfd.var_ad1dcd56d202e9ac = &function_6da2952367672ac0;
  return var_d13c18af4084bdfd;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  }

  switch (instancename) {
    case #"hash_777ad07b7954677c":
      function_c29d2aaf0f3c5647(fe, us, cf);
      break;
    case #"hash_9089fe1a5ffab742":
      function_c5cd614630c1c565(fe, us, cf);
      break;
  }
}

function function_c29d2aaf0f3c5647(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-10640, -10072, 1768), (359.98, 135, 0), "dmz_vehicledrive_start", "VEHICLE_DRIVE_G_GARAGE_GASSTATION_NORTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 15000);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  s.name = "script_struct_nexus_activity_joiner";
  fe[[f]](s, us, cf, (-6734, -12613, 1871.25), (270, 0, 58.02), "activity_nexus_instance_joiner", undefined, "VEHICLE_DRIVE_G_GARAGE_GASSTATION_NORTH", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  fe[[f]](s, us, cf, (-11002.5, -9858.5, 1712), (0, 90, 0), "vehicledrive_horde", "VEHICLE_DRIVE_G_GARAGE_GASSTATION_NORTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  fe[[f]](s, us, cf, (-10635, -10211, 1720), (0, 180, 0), "vehicledrive_guard", "VEHICLE_DRIVE_G_GARAGE_GASSTATION_NORTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_c5cd614630c1c565(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-10386, -29468, 1778), (359.98, 249, 0), "dmz_vehicledrive_start", "VEHICLE_DRIVE_G_GARAGE_GASSTATION_SOUTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 15000);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  fe[[f]](s, us, cf, (-10417.8, -29895.5, 1722.01), (0, 225, 0), "vehicledrive_horde", "VEHICLE_DRIVE_G_GARAGE_GASSTATION_SOUTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  fe[[f]](s, us, cf, (-10248.8, -29419.2, 1719), (0, 225, 0), "vehicledrive_guard", "VEHICLE_DRIVE_G_GARAGE_GASSTATION_SOUTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  fe[[f]](s, us, cf, (-7340.75, -32150.2, 1790.25), (270, 0, 45), "activity_nexus_instance_joiner", undefined, "VEHICLE_DRIVE_G_GARAGE_GASSTATION_SOUTH", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_vehicle_drive";
  instancestruct.cf = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  instancestruct.scriptstructorigin = (-10640, -10072, 1728);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-10645.5, -10191.5, 1711)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [350];
  activityinstances["VEHICLE_DRIVE_G_GARAGE_GASSTATION_NORTH"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_vehicle_drive";
  instancestruct.cf = "mp_jup_st_g_ob_contracts_vehicle_drive_cs";
  instancestruct.scriptstructorigin = (-10388, -29468, 1736);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-10261, -29454, 1719)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [350];
  activityinstances["VEHICLE_DRIVE_G_GARAGE_GASSTATION_SOUTH"] = instancestruct;
  return activityinstances;
}