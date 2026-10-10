/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2a73cf62256b4021.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_e_gas_stations;

function main(unused, us) {
  if(flag_exist("mp_jup_st_e_gas_stations")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_e_gas_stations");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_e_gas_stations");

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

  s cs_setup_arrays(us, "mp_jup_st_e_gas_stations");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_e_gas_stations");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_gas_stations";
  s.height = 1000;
  fe[[f]](s, us, cf, (14860, -10248, 1820), (0, 0, 0), "gas_station", undefined, "large", undefined, undefined, undefined, undefined, 600);
  s = s();
  s.cs_flag = "mp_jup_st_e_gas_stations";
  s.height = 1000;
  fe[[f]](s, us, cf, (-11612, -10268, 1692), (0, 0, 0), "gas_station", undefined, "large", undefined, undefined, undefined, undefined, 600);
  s = s();
  s.cs_flag = "mp_jup_st_e_gas_stations";
  s.height = 1000;
  fe[[f]](s, us, cf, (5792, -13248, 1368), (0, 0, 0), "gas_station_marine", undefined, undefined, undefined, undefined, undefined, undefined, 650);
  s = s();
  s.cs_flag = "mp_jup_st_e_gas_stations";
  fe[[f]](s, us, cf, (5182, 4408, 1444.5), (0, 0, 0), "gas_station", "mp_jup_bigmap_e_gas_station_1", "large");
  s = s();
  s.cs_flag = "mp_jup_st_e_gas_stations";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 1000;
  fe[[f]](s, us, cf, (4849, 3808, 1420.5), (0, 0, 0), "mp_jup_bigmap_e_gas_station_1", undefined, undefined, undefined, undefined, undefined, undefined, 400);
  s = s();
  s.cs_flag = "mp_jup_st_e_gas_stations";
  s.is_cs_trigger = 1;
  s.var_857f45e57f5d5a7a = 1;
  s.height = 1000;
  fe[[f]](s, us, cf, (5645, 4678, 1420.5), (0, 0, 0), "mp_jup_bigmap_e_gas_station_1", undefined, undefined, undefined, undefined, undefined, undefined, 600);
  s = s();
  s.cs_flag = "mp_jup_st_e_gas_stations";
  s.height = 1000;
  fe[[f]](s, us, cf, (14188, -5068, 1376), (0, 0, 0), "gas_station_marine", undefined, undefined, undefined, undefined, undefined, undefined, 650);
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_e_gas_stations");
}