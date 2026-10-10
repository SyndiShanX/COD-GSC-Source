/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_65d738fd8a2862a5.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_c_ob_activities_vault_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_c_ob_activities_vault_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_c_ob_activities_vault_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_c_ob_activities_vault_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_c_ob_activities_vault_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_c_ob_activities_vault_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_vault_cs";
  s.name = "cache";
  fe[[f]](s, us, cf, (11.44, -191.97, 0), (0, 29.63, 0), "s_vault_cache", undefined, undefined, undefined, "link_vault_pawn", (39921, 39983, 960), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_vault_cs";
  s.name = "cache";
  fe[[f]](s, us, cf, (-103.01, -103.14, 0), (0, 300.14, 0), "s_vault_cache", undefined, undefined, undefined, "link_vault_pawn", (39921, 39983, 960), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_vault_cs";
  s.name = "cache";
  fe[[f]](s, us, cf, (-143.54, -36.41, 0), (0, 298.89, 0), "s_vault_cache", undefined, undefined, undefined, "link_vault_pawn", (39921, 39983, 960), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_vault_cs";
  s.name = "phone";
  fe[[f]](s, us, cf, (136, -126, 19), (0, 347.9, 0), "s_vault_pawn_phone", undefined, undefined, undefined, "link_vault_pawn", (39921, 39983, 960), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_vault_cs";
  s.name = "encounter_struct";
  fe[[f]](s, us, cf, (132, -314, 0), (0, 180, 0), "s_vault_pawn_encounter", undefined, undefined, undefined, "link_vault_pawn", (39921, 39983, 960), (0, 0, 0), 600);
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_vault_cs";
  s.is_cs_model = 1;
  s.model = "gns_equipment_satellite_dish_01_med";
  s.name = "satellite_model";
  fe[[f]](s, us, cf, (142, -113, 147.92), (7.68, 332.67, -11.78), "s_vault_model", undefined, "gns_equipment_satellite_dish_01_med", undefined, "link_vault_pawn", (39921, 39983, 960), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_vault_cs";
  s.is_cs_model = 1;
  s.model = "electronics_headphones_02";
  s.name = "headphones_model";
  fe[[f]](s, us, cf, (146.86, -120.82, 18), (0, 268.2, 0), "s_vault_model", undefined, "electronics_headphones_02", undefined, "link_vault_pawn", (39921, 39983, 960), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_vault_cs";
  s.is_cs_model = 1;
  s.model = "electronics_monitor_hanging_vintage_set_on";
  s.name = "monitor_model";
  fe[[f]](s, us, cf, (144.4, -123.94, 0), (0, 146.1, 0), "s_vault_model", undefined, "electronics_monitor_hanging_vintage_set_on", undefined, "link_vault_pawn", (39921, 39983, 960), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_vault_cs";
  s.is_cs_model = 1;
  s.model = "parts_shoes_tactical_ribbed";
  s.name = "shoes_model";
  fe[[f]](s, us, cf, (141.63, -100.87, -0), (0, 347.1, 0), "s_vault_model", undefined, "parts_shoes_tactical_ribbed", undefined, "link_vault_pawn", (39921, 39983, 960), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_vault_cs";
  s.name = "center_struct";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 180, 0), "s_vault_pawn_center", undefined, undefined, "link_vault_pawn", undefined, (39921, 39983, 960), (0, 0, 0), 600);
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_vault_cs";
  s.name = "path_start";
  fe[[f]](s, us, cf, (22910.3, 7030.5, 1699.01), (0.02, 359.98, 0.05), "vault_knight_e_to_c", "cspf_2_auto5752764160341377049", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (21146.5, 11712.5, 1626), (0, 0, 0), "cspf_2_auto17098409031089682975", "cspf_2_auto17787372625829735672", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (20434, 13617, 1592), (0, 0, 0), "cspf_2_auto17787372625829735672", "cspf_2_auto8746982738485083934", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (19749.5, 15845.5, 1559.37), (346.69, 358.88, 4.83), "cspf_2_auto8746982738485083934", "cspf_2_auto2499840944230275261", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_vault_cs";
  s.name = "path_end";
  fe[[f]](s, us, cf, (19348.5, 32118, 1411.48), (358.39, 0.24, 0.74), "cspf_2_auto8226209264346473502", "vault_knight_c_to_b_counter", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (19768.5, 18080.5, 1676), (0, 0, 0), "cspf_2_auto2499840944230275261", "cspf_2_auto4742149760870035939", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (20014.5, 21421, 1683.02), (358.14, 359.99, 0.24), "cspf_2_auto4742149760870035939", "cspf_2_auto1717595424516849828", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (20186, 23929, 1649.5), (0, 0, 0), "cspf_2_auto1717595424516849828", "cspf_2_auto381294349491541468", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (20199, 26231, 1573), (0, 0, 0), "cspf_2_auto381294349491541468", "cspf_2_auto16222049546108289492", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (20201, 28705, 1513.5), (0, 0, 0), "cspf_2_auto16222049546108289492", "cspf_2_auto695859418032746699", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (20088, 30804, 1458.5), (0, 0, 0), "cspf_2_auto695859418032746699", "cspf_2_auto5783665048357291985", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (19874, 31682, 1430.5), (0, 0, 0), "cspf_2_auto5783665048357291985", "cspf_2_auto8226209264346473502", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (22274, 8996, 1669.5), (0, 0, 0), "cspf_2_auto5752764160341377049", "cspf_2_auto9144759283061984184", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (21673, 10503.5, 1645), (0, 0, 0), "cspf_2_auto9144759283061984184", "cspf_2_auto17098409031089682975", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_c_ob_activities_vault_cs");
}