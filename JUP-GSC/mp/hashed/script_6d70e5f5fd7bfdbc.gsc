/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6d70e5f5fd7bfdbc.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_e_ob_contracts_vehicle_drive_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_e_ob_contracts_vehicle_drive_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_e_ob_contracts_vehicle_drive_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_e_ob_contracts_vehicle_drive_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_e_ob_contracts_vehicle_drive_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_e_ob_contracts_vehicle_drive_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
  s.script_unload = "default";
  s.spawngroup = "heli_test_guys";
  fe[[f]](s, us, cf, (3561.8, -7955.3, 4985.76), (0, 35, 0), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (17256.5, 5741.99, 1786.98), (0, 341.65, -0.74), "dmz_vehicledrive_end", undefined, "VEHICLE_DRIVE_TRAIN", undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
  s.script_unload = "default";
  s.spawngroup = "heli_test_guys";
  fe[[f]](s, us, cf, (16995.9, -12554, 5824.73), (0, 80, 0), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
  s.script_unload = "default";
  s.spawngroup = "heli_test_guys";
  fe[[f]](s, us, cf, (17728.9, -533.8, 5167.14), (0, 125, 0), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
  s.script_unload = "default";
  s.spawngroup = "heli_test_guys";
  fe[[f]](s, us, cf, (25352.7, 2963.7, 6492.55), (0, 170, 0), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
  s.script_unload = "default";
  s.spawngroup = "heli_test_guys";
  fe[[f]](s, us, cf, (20650.1, 7885.7, 5503.6), (0, 230, 0), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
  s.script_unload = "default";
  s.spawngroup = "heli_test_guys";
  fe[[f]](s, us, cf, (13799.8, 6505.3, 5707.82), (0, 275, 0), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
  s.script_unload = "default";
  s.spawngroup = "heli_test_guys";
  fe[[f]](s, us, cf, (9406.6, 218.1, 4532.85), (0, 320, 0), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
  s.script_unload = "default";
  s.spawngroup = "heli_test_guys";
  fe[[f]](s, us, cf, (23336.9, -7897, 5731.74), (0, 350, 0), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  fe[[f]](s, us, cf, (15982.3, -9576.55, 1829.11), (359.14, 79.85, -0.08), "dmz_vehicledrive_end", undefined, "VEHICLE_DRIVE_TRAIN", undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  fe[[f]](s, us, cf, (6324, 6045, 1443), (0, 287.8, 0), "dmz_vehicledrive_end", undefined, "VEHICLE_DRIVE_TRAIN", undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  fe[[f]](s, us, cf, (22313, -2949.01, 2326.01), (5.12, 339.68, 6.3), "dmz_vehicledrive_end", undefined, "VEHICLE_DRIVE_TRAIN", undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
  s.script_unload = "default";
  s.spawngroup = "heli_test_guys";
  fe[[f]](s, us, cf, (12668.9, -8438, 5824.73), (0, 80, 0), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
  s.script_unload = "default";
  s.spawngroup = "heli_test_guys";
  fe[[f]](s, us, cf, (10199.8, 12137.3, 5707.82), (0, 275, 0), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
  s.script_unload = "default";
  s.spawngroup = "heli_test_guys";
  fe[[f]](s, us, cf, (2687.8, 9606.3, 5707.82), (0, 275, 0), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
  s.script_unload = "default";
  s.spawngroup = "heli_test_guys";
  fe[[f]](s, us, cf, (554.8, 2176.3, 5707.82), (0, 275, 0), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
  s.script_unload = "default";
  s.spawngroup = "heli_test_guys";
  fe[[f]](s, us, cf, (-6680.2, -5447.7, 5707.82), (0, 275, 0), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
  s.script_unload = "default";
  s.spawngroup = "heli_test_guys";
  fe[[f]](s, us, cf, (-7391.2, 5277.3, 5707.82), (0, 275, 0), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
  s.script_unload = "default";
  s.spawngroup = "heli_test_guys";
  fe[[f]](s, us, cf, (-15790.2, -149.7, 5707.82), (0, 275, 0), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
  s.script_unload = "default";
  s.spawngroup = "heli_test_guys";
  fe[[f]](s, us, cf, (-14756.2, 11544.3, 5707.82), (0, 275, 0), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  s.classname_mp = "script_vehicle_iw8_lbravo_carrier";
  s.script_unload = "default";
  s.spawngroup = "heli_test_guys";
  fe[[f]](s, us, cf, (-4483.2, 12577.3, 5707.82), (0, 275, 0), undefined, undefined, "heli_reinforceNode", undefined, undefined, undefined, undefined, undefined, 45);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  fe[[f]](s, us, cf, (4734.29, -6499.56, 2383.99), (0, 69.6, 0), "dmz_vehicledrive_end", undefined, "VEHICLE_DRIVE_TRAIN", undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  fe[[f]](s, us, cf, (-4727.68, -6140.53, 1419.47), (358.46, 332.91, -0.3), "dmz_vehicledrive_end", undefined, "VEHICLE_DRIVE_TRAIN", undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (21564, 4526.99, 1885.91), (0, 341.65, -0.74), "dmz_vehicledrive_end", undefined, "VEHICLE_DRIVE_TRAIN", undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (15435.2, -189.76, 1652), (0, 341.65, -0.74), "dmz_vehicledrive_end", undefined, "VEHICLE_DRIVE_TRAIN", undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (11564, -10602.8, 1739.89), (0, 341.65, -0.74), "dmz_vehicledrive_end", undefined, "VEHICLE_DRIVE_TRAIN", undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (11479, -1338.05, 1735.75), (0, 341.65, 0), "dmz_vehicledrive_end", undefined, "VEHICLE_DRIVE_TRAIN", undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (1690.25, -8021.51, 1844.5), (0, 341.65, -0.74), "dmz_vehicledrive_end", undefined, "VEHICLE_DRIVE_TRAIN", undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-4807, -6083.26, 1421), (0, 341.65, -0.74), "dmz_vehicledrive_end", undefined, "VEHICLE_DRIVE_TRAIN", undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-14446.5, 1644.24, 1054), (0, 341.65, -0.74), "dmz_vehicledrive_end", undefined, "VEHICLE_DRIVE_TRAIN", undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-17264.8, 5272.49, 1268.67), (0, 341.65, -0.74), "dmz_vehicledrive_end", undefined, "VEHICLE_DRIVE_TRAIN", undefined, undefined, undefined, undefined, 200);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (-12038.3, 11264.5, 1273.96), (0, 341.65, -0.74), "dmz_vehicledrive_end", undefined, "VEHICLE_DRIVE_TRAIN", undefined, undefined, undefined, undefined, 200);
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_e_ob_contracts_vehicle_drive_cs");
}

function function_fd69cf02ba4d90a2() {
  activityinfostruct = spawnStruct();
  activityinfostruct.name = "REV_OB_VEHICLE_DRIVE";
  activityinfostruct.scriptbundle = "jup_activitydefinition_vehicle_drive";
  activityinfostruct.mainfunction = &main;
  activityinfostruct.var_6e7eb28b2997b5b4 = &function_82613e20fba2deb9;
  activityinfostruct.metadatafunction = &function_6da2952367672ac0;
  return activityinfostruct;
}

function function_82613e20fba2deb9(instancename, fe, us, cf) {
  if(!isDefined(cf)) {
    cf = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  }

  switch (instancename) {
    case #"hash_ad1e37e22cd10e16":
      function_5082914ecf5d5e29(fe, us, cf);
      break;
    case #"hash_122b36d20a28b6a8":
      function_375b058ae1566a13(fe, us, cf);
      break;
  }
}

function function_5082914ecf5d5e29(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (4740, 4488, 1504), (0, 315, 0), "dmz_vehicledrive_start", "VEHICLE_DRIVE_E_GARAGE_GASSTATION_NORTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 15000);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  fe[[f]](s, us, cf, (5073.75, 4286.5, 1443), (0, 315, 0), "vehicledrive_horde", "VEHICLE_DRIVE_E_GARAGE_GASSTATION_NORTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  fe[[f]](s, us, cf, (4751.5, 4654.5, 1448), (0, 270, 0), "vehicledrive_guard", "VEHICLE_DRIVE_E_GARAGE_GASSTATION_NORTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  fe[[f]](s, us, cf, (-320, 3891, 1858.75), (270, 0, -28.93), "activity_nexus_instance_joiner", undefined, "VEHICLE_DRIVE_E_GARAGE_GASSTATION_NORTH", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_375b058ae1566a13(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  s.name = "script_struct";
  fe[[f]](s, us, cf, (15216, -11152, 1890), (0, 67, 0), "dmz_vehicledrive_start", "VEHICLE_DRIVE_E_GARAGE_GASSTATION_SOUTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0), 15000);
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  fe[[f]](s, us, cf, (15259.5, -11252.5, 1832), (0, 90, 0), "vehicledrive_guard", "VEHICLE_DRIVE_E_GARAGE_GASSTATION_SOUTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  fe[[f]](s, us, cf, (15414, -10941.8, 1832), (0, 90, 0), "vehicledrive_horde", "VEHICLE_DRIVE_E_GARAGE_GASSTATION_SOUTH", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  fe[[f]](s, us, cf, (14162.8, -7595, 1632.25), (270, 0, -119.73), "activity_nexus_instance_joiner", undefined, "VEHICLE_DRIVE_E_GARAGE_GASSTATION_SOUTH", undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_vehicle_drive";
  instancestruct.cf = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  instancestruct.scriptstructorigin = (4740, 4488, 1464);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(4723, 4648.75, 1446)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [350];
  activityinstances["VEHICLE_DRIVE_E_GARAGE_GASSTATION_NORTH"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydefinition_vehicle_drive";
  instancestruct.cf = "mp_jup_st_e_ob_contracts_vehicle_drive_cs";
  instancestruct.scriptstructorigin = (15216, -11148, 1848);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(15236, -11319.5, 1831)];
  instancestruct.locationoriginoffset = [(0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0)];
  instancestruct.locationradius = [350];
  activityinstances["VEHICLE_DRIVE_E_GARAGE_GASSTATION_SOUTH"] = instancestruct;
  return activityinstances;
}