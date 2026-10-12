/***********************************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_launchfacility\mp_jup_launchfacility_zone2_create_script.gsc
***********************************************************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_launchfacility_zone2_create_script;

function main(unused, us) {
  if(flag_exist("mp_jup_launchfacility_zone2_create_script")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_launchfacility_zone2_create_script");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_launchfacility_zone2_create_script");

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

  s cs_setup_arrays(us, "mp_jup_launchfacility_zone2_create_script");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_launchfacility_zone2_create_script");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_launchfacility_zone2_create_script";
  fe[[f]](s, us, cf, (39808, 29936, 1536), (0, 360, 0), undefined, undefined, "missile_zone_2");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_zone2_create_script";
  fe[[f]](s, us, cf, (39808, 29936, 1520), (0, 0, 0), undefined, undefined, "base_alarm");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_zone2_create_script";
  fe[[f]](s, us, cf, (38864, 29920, 1536), (0, 360, 0), undefined, undefined, "missile_zone_1");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_zone2_create_script";
  fe[[f]](s, us, cf, (37181.6, 32322.4, 1520.57), (0, 59.3, 0), undefined, undefined, "crashed_vehicles");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_zone2_create_script";
  fe[[f]](s, us, cf, (34079.9, 33458.6, 1821.5), (0, 187.93, 0), "cspf_0_auto451874531873408525");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_zone2_create_script";
  fe[[f]](s, us, cf, (34273.4, 33493.4, 1821.5), (0, 211.05, 0), undefined, "cspf_0_auto451874531873408525", "rpg_agent_spawn_point_0");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_zone2_create_script";
  fe[[f]](s, us, cf, (34197, 31734.4, 1697.25), (0.66, 111.1, 1.26), "cspf_0_auto16012719886976266809");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_zone2_create_script";
  fe[[f]](s, us, cf, (34114.9, 31397.9, 1830.5), (0, 70, 0), undefined, "cspf_0_auto16012719886976266809", "rpg_agent_spawn_point_1");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_zone2_create_script";
  fe[[f]](s, us, cf, (32487.6, 33874.4, 1712.57), (0, 133.6, 0), undefined, undefined, "crashed_vehicles");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_zone2_create_script";
  fe[[f]](s, us, cf, (36010.9, 33829.9, 1880.55), (359.51, 230.01, 1.05), "cspf_0_auto4205781765389370770");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_zone2_create_script";
  s.script_label = "_c";
  fe[[f]](s, us, cf, (34827.5, 31850.9, 1833.75), (0.88, 123.83, -1.93), undefined, "cspf_0_auto17591106268562018707", "MGpoint");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_zone2_create_script";
  fe[[f]](s, us, cf, (36100.2, 34009.9, 1854), (0, 234, 0), undefined, "cspf_0_auto4205781765389370770", "rpg_agent_spawn_point_2");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_zone2_create_script";
  fe[[f]](s, us, cf, (35364.9, 31711.7, 1842.25), (0, 0, 0), "cspf_0_auto17591106268562018707");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_zone2_create_script";
  fe[[f]](s, us, cf, (33551.7, 34570.6, 1869), (0, 212.34, 0), undefined, "cspf_0_auto12317601916262675052", "MGpoint");
  s = s();
  s.cs_flag = "mp_jup_launchfacility_zone2_create_script";
  fe[[f]](s, us, cf, (33764.6, 34775.2, 1888.75), (0, 0, 0), "cspf_0_auto12317601916262675052");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_launchfacility_zone2_create_script");
}