/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7245d37edd0c3aa9.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_e_ob_activities_vault_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_e_ob_activities_vault_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_e_ob_activities_vault_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_e_ob_activities_vault_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_e_ob_activities_vault_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_e_ob_activities_vault_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_vault_cs";
  s.name = "path_start";
  fe[[f]](s, us, cf, (16311.2, -14630, 1763.73), (359.74, 359.98, 3.58), "vault_knight_h_to_e", "cspf_1_auto12863920606590200308", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (16876.4, -13860.7, 1817.86), (356.85, 359.76, 4.39), "cspf_1_auto12863920606590200308", "cspf_1_auto14792048618948934096", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (17958.8, -12598.2, 1982.88), (354.18, 359.6, 1.97), "cspf_1_auto14792048618948934096", "cspf_1_auto11562797294366793753", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (19901.5, -10932, 2247), (0, 0, 0), "cspf_1_auto11562797294366793753", "cspf_1_auto11226499082398162640", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (21315, -9665, 2315.5), (0, 0, 0), "cspf_1_auto11226499082398162640", "cspf_1_auto2046250831505061030", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (22044, -8721.5, 2340.5), (0, 0, 0), "cspf_1_auto2046250831505061030", "cspf_1_auto16591689280830328282", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (22376, -7301, 2286.4), (1.08, 14.65, -2.15), "cspf_1_auto16591689280830328282", "cspf_1_auto13444928282141365870", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (22521.5, -4275.5, 2265.35), (359.99, 359.99, 0.57), "cspf_1_auto13444928282141365870", "cspf_1_auto10090011006340246510", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (22602, -3051, 2316.87), (358.06, 3.17, 6.11), "cspf_1_auto10090011006340246510", "cspf_1_auto2591318711285131651", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (23006.5, -2008, 2473.5), (0, 0, 0), "cspf_1_auto2591318711285131651", "cspf_1_auto850801322037270294", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (23856.5, -545.5, 2570.5), (0, 0, 0), "cspf_1_auto850801322037270294", "cspf_1_auto5388857600414938283", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (24344, 683, 2522.32), (0.1, 0.12, -4.87), "cspf_1_auto5388857600414938283", "cspf_1_auto504637185068327093", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (24474, 1940.5, 2318), (0, 0, 0), "cspf_1_auto504637185068327093", "cspf_1_auto14782672875650249217", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (23774.5, 3883, 1828), (0, 0, 0), "cspf_1_auto14782672875650249217", "cspf_1_auto11147697887952476680", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_vault_cs";
  s.name = "path_end";
  fe[[f]](s, us, cf, (23268.8, 5333.75, 1734.37), (359.7, 0.01, -1.34), "cspf_1_auto11147697887952476680", "vault_knight_e_to_c", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_e_ob_activities_vault_cs");
}