/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6f4bc85b3e5ba0cb.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_d_ob_contracts_escort_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_d_ob_contracts_escort_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_d_ob_contracts_escort_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_d_ob_contracts_escort_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_d_ob_contracts_escort_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_d_ob_contracts_escort_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_d_ob_contracts_escort_cs");
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
    cf = "mp_jup_st_d_ob_contracts_escort_cs";
  }

  switch (instancename) {
    case #"hash_82c92e59ac052f5f":
      function_74a4aa5837c174b2(fe, us, cf);
      break;
    case #"hash_991ac33090f405dd":
      function_107e94ede7e629a8(fe, us, cf);
      break;
  }
}

function function_74a4aa5837c174b2(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-32968, 1754, 972), (0, 0, 0), "escort_d_warehouse_fishing_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-31490, 3044.5, 1012.5), (0, 281.72, 0), "activity_nexus_instance_joiner", "ESCORT_ZOMBIES_D_WAREHOUSE_FISHING", "ESCORT_ZOMBIES_D_WAREHOUSE_FISHING", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-32108, 232, 960), (0, 0, 0), "ESCORT_ZOMBIES_D_WAREHOUSE_FISHING", undefined, "escort_d_warehouse_fishing", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-33410, 7696, 972), (0, 292, 0), "ESCORT_ZOMBIES_D_WAREHOUSE_FISHING_REWARD", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-32082, 2562, 972), (0, 0, 0), "escort_d_warehouse_fishing_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-33448, 2978, 972), (0, 0, 0), "escort_d_warehouse_fishing_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-34550, 4144, 972), (0, 0, 0), "escort_d_warehouse_fishing_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-35314, 4836, 920), (0, 0, 0), "escort_d_warehouse_fishing_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-34398, 5228, 958.98), (0, 0, 0), "escort_d_warehouse_fishing_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-33206, 5732, 959.98), (0, 0, 0), "escort_d_warehouse_fishing_ambush_05", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-32818, 6936, 959.98), (0, 0, 0), "escort_d_warehouse_fishing_ambush_06", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-33744, 7704, 959.98), (0, 0, 0), "escort_d_warehouse_fishing_ambush_06", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-32432, 7526, 959.98), (0, 0, 0), "escort_d_warehouse_fishing_ambush_07", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-32998, 1780, 968), (0, 0, 0), "escort_d_warehouse_fishing_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-33866, 3570, 968), (0, 0, 0), "escort_d_warehouse_fishing_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-33036, 3210, 968), (0, 0, 0), "escort_d_warehouse_fishing_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-35386, 5394, 920), (0, 0, 0), "escort_d_warehouse_fishing_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-33752, 4744, 959.98), (0, 0, 0), "escort_d_warehouse_fishing_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-33890, 5714, 968), (0, 0, 0), "escort_d_warehouse_fishing_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-32290, 6944, 968), (0, 0, 0), "escort_d_warehouse_fishing_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-33772, 8364, 968), (0, 0, 0), "escort_d_warehouse_fishing_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-32514, 8044, 976), (0, 0, 0), "escort_d_warehouse_fishing_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-34692, 6144, 959.98), (0, 0, 0), "escort_d_warehouse_fishing_horde_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-34478, 3052, 972), (0, 0, 0), "escort_d_warehouse_fishing_horde_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-32184, 7340, 959.98), (0, 0, 0), "escort_d_warehouse_fishing_horde_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_107e94ede7e629a8(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-27442, 9428, 1166), (0, 0, 0), "escort_d_pool_apartments_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-27594, 12664, 1160), (0, 0, 0), "ESCORT_ZOMBIES_D_POOL_APARTMENTS", undefined, "escort_d_pool_apartments", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-27968, 15117, 1208.61), (0, 83.21, 0), "activity_nexus_instance_joiner", "ESCORT_ZOMBIES_D_POOL_APARTMENTS", "ESCORT_ZOMBIES_D_POOL_APARTMENTS", undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-26622, 4106, 1032), (0, 212, 0), "ESCORT_ZOMBIES_D_POOL_APARTMENTS_REWARD", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-25774, 9770, 1166), (0, 0, 0), "escort_d_pool_apartments_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-26744, 8816, 1166), (0, 0, 0), "escort_d_pool_apartments_neutralize_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-28366, 8346, 1041.38), (0, 0, 0), "escort_d_pool_apartments_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-26206, 6984, 1032.93), (0, 0, 0), "escort_d_pool_apartments_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-28488, 7176, 1029.98), (0, 0, 0), "escort_d_pool_apartments_neutralize_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-26314, 4596, 1029.98), (0, 0, 0), "escort_d_pool_apartments_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-26056, 3598, 1029.98), (0, 0, 0), "escort_d_pool_apartments_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-26054, 3596, 1029.98), (0, 0, 0), "escort_d_pool_apartments_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-27500, 3412, 1029.98), (0, 0, 0), "escort_d_pool_apartments_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-27946, 5076, 1057.98), (0, 0, 0), "escort_d_pool_apartments_neutralize_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-26936, 6332, 1031.16), (0, 0, 0), "escort_d_pool_apartments_horde_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-26384, 9068, 1150), (0, 0, 0), "escort_d_pool_apartments_horde_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-26390, 3306, 1150), (0, 0, 0), "escort_d_pool_apartments_horde_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-27638, 10962, 1150.99), (0, 0, 0), "escort_d_pool_apartments_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-26422, 11424, 1182), (0, 0, 0), "escort_d_pool_apartments_ambush_01", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-26004, 9890, 1150.8), (0, 0, 0), "escort_d_pool_apartments_ambush_02", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-26588, 8400, 1112.29), (0, 0, 0), "escort_d_pool_apartments_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-27782, 8714, 1143.99), (0, 0, 0), "escort_d_pool_apartments_ambush_03", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-26848, 7410, 1022.22), (0, 0, 0), "escort_d_pool_apartments_ambush_04", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-28434, 7302, 1029.98), (0, 0, 0), "escort_d_pool_apartments_ambush_05", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-27654, 6568, 1048), (0, 0, 0), "escort_d_pool_apartments_ambush_05", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-27784, 4676, 1029.48), (0, 0, 0), "escort_d_pool_apartments_ambush_06", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-26578, 4814, 1032.17), (0, 0, 0), "escort_d_pool_apartments_ambush_06", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_contracts_escort_cs";
  fe[[f]](s, us, cf, (-26978, 3550, 1030.95), (0, 0, 0), "escort_d_pool_apartments_ambush_07", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
}

function function_6da2952367672ac0() {
  activityinstances = [];
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_escort";
  instancestruct.cf = "mp_jup_st_d_ob_contracts_escort_cs";
  instancestruct.scriptstructorigin = (-32218, 176, 960);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-33042, 7526, 960), (-34726, 5396, 970), (-33622, 2546, 960), (-32200, 486, 960.11)];
  instancestruct.locationoriginoffset = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.locationradius = [1000, 1000, 1000, 750];
  activityinstances["ESCORT_ZOMBIES_D_WAREHOUSE_FISHING"] = instancestruct;
  instancestruct = spawnStruct();
  instancestruct.scriptbundle = "jup_activitydef_escort";
  instancestruct.cf = "mp_jup_st_d_ob_contracts_escort_cs";
  instancestruct.scriptstructorigin = (-27652, 12800, 1160);
  instancestruct.scriptstructoriginoffset = (0, 0, 0);
  instancestruct.locationorigin = [(-27656, 12466, 1160), (-26438, 9838, 1150), (-27632, 7324, 1028), (-26852, 3784, 1032)];
  instancestruct.locationoriginoffset = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.var_45283ef87b6e04b6 = [(0, 0, 0), (0, 0, 0), (0, 0, 0), (0, 0, 0)];
  instancestruct.locationradius = [1000, 1000, 1000, 1000];
  activityinstances["ESCORT_ZOMBIES_D_POOL_APARTMENTS"] = instancestruct;
  return activityinstances;
}