/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7dc8e85b881c90f9.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_b_ob_activities_vault_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_b_ob_activities_vault_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_b_ob_activities_vault_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_b_ob_activities_vault_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_b_ob_activities_vault_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_b_ob_activities_vault_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_vault_cs";
  s.name = "path_start";
  fe[[f]](s, us, cf, (15030.8, 34642.5, 1406.83), (357.91, 0.05, -0.94), "vault_knight_c_to_b_counter", "cspf_1_auto6775039428439010161", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (14501.5, 34827, 1350.39), (351.87, 0.33, -2.33), "cspf_1_auto6775039428439010161", "cspf_1_auto4832080562102694363", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (12582.5, 34928.5, 1185), (0, 0, 0), "cspf_1_auto4832080562102694363", "cspf_1_auto1438609479070685220", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (10258, 34964, 1192.91), (0.37, 0, 0.02), "cspf_1_auto1438609479070685220", "cspf_1_auto7155096618032332697", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (7218.5, 35103, 1217.29), (0.76, 0, 0.03), "cspf_1_auto7155096618032332697", "cspf_1_auto14580958076642539894", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (5029, 35123, 1243.5), (0, 0, 0), "cspf_1_auto14580958076642539894", "cspf_1_auto15890174923215630954", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (3196.5, 35075.5, 1250), (0, 0, 0), "cspf_1_auto15890174923215630954", "cspf_1_auto5136532038176521415", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (1379, 34998, 1238.5), (0, 0, 0), "cspf_1_auto5136532038176521415", "cspf_1_auto5301447140255407794", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-1507, 34699.5, 1159.5), (0, 0, 0), "cspf_1_auto5301447140255407794", "cspf_1_auto3305655531341767771", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-3231.5, 34816, 1132), (0, 0, 0), "cspf_1_auto3305655531341767771", "cspf_1_auto13496588993889520544", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-5558.5, 34578.5, 1130), (0, 0, 0), "cspf_1_auto13496588993889520544", "cspf_1_auto17412459006666726369", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-7604, 34384, 1144.5), (0, 0, 0), "cspf_1_auto17412459006666726369", "cspf_1_auto13190890004967950206", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-9821, 34563.5, 1194.22), (1.59, 0, 0.09), "cspf_1_auto13190890004967950206", "cspf_1_auto10632195913800756568", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-10893, 34851.5, 1224.57), (1.59, 0, 0.05), "cspf_1_auto10632195913800756568", "cspf_1_auto12683508742826438301", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_vault_cs";
  s.name = "path_end";
  fe[[f]](s, us, cf, (-12011.3, 34975.1, 1239.66), (356.74, 359.9, 0.94), "cspf_1_auto12683508742826438301", "vault_knight_b_to_a_counter", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_b_ob_activities_vault_cs");
}