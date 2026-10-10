/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_79de05378402bed1.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_i_gas_stations;

function main(unused, us) {
  if(flag_exist("mp_jup_st_i_gas_stations")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_i_gas_stations");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_i_gas_stations");

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

  s cs_setup_arrays(us, "mp_jup_st_i_gas_stations");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_i_gas_stations");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.height = 1000;
  fe[[f]](s, us, cf, (23156, -18460, 2876), (0, 0, 0), "gas_station", undefined, "large", undefined, undefined, undefined, undefined, 600);
  s = s();
  s.height = 1000;
  fe[[f]](s, us, cf, (34868, -28644, 2912), (0, 0, 0), "gas_station_marine", undefined, undefined, undefined, undefined, undefined, undefined, 650);
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}