/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_9b5cabd1a0468a9.gsc
************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_a_ob_activities_vault_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_a_ob_activities_vault_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_a_ob_activities_vault_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_a_ob_activities_vault_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_a_ob_activities_vault_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_a_ob_activities_vault_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-15732.5, 34963, 1249), (0, 0, 0), "cspf_1_auto11416545504232948897", "cspf_1_auto17550075986697948241", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_vault_cs";
  s.name = "path_end";
  fe[[f]](s, us, cf, (-30098, 16890.5, 1033), (354.53, 359.74, 2.71), "cspf_1_auto12584696661483141968", "vault_knight_a_to_d_counter", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_vault_cs";
  s.name = "path_start";
  fe[[f]](s, us, cf, (-13020.2, 34968.7, 1248), (0, 0, 0), "vault_knight_b_to_a_counter", "cspf_1_auto11416545504232948897", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-17910, 34930, 1249), (0, 0, 0), "cspf_1_auto17550075986697948241", "cspf_1_auto2011698813784188210", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-19200, 34881, 1253), (0, 0, 0), "cspf_1_auto2011698813784188210", "cspf_1_auto14366364086111002897", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-21594.5, 34682.5, 1273.5), (0, 0, 0), "cspf_1_auto14366364086111002897", "cspf_1_auto4376952071984017789", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-22759.5, 34326.5, 1304.83), (1.56, 359.98, -0.83), "cspf_1_auto4376952071984017789", "cspf_1_auto791757786154864967", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-23599, 33779, 1339.11), (1.37, 359.96, -1.55), "cspf_1_auto791757786154864967", "cspf_1_auto2551315987015101406", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-24433.5, 32814.5, 1386.62), (0.78, 359.98, -1.46), "cspf_1_auto2551315987015101406", "cspf_1_auto17695350161212571081", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-24902.5, 31863.5, 1400.5), (0, 0, 0), "cspf_1_auto17695350161212571081", "cspf_1_auto13396306838637136096", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-25037, 30385.5, 1394), (0, 0, 0), "cspf_1_auto13396306838637136096", "cspf_1_auto486529853674827809", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-24956, 29231.5, 1417), (0, 0, 0), "cspf_1_auto486529853674827809", "cspf_1_auto16577597273396313911", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-24952, 27904, 1454), (0, 0, 0), "cspf_1_auto16577597273396313911", "cspf_1_auto9050160069654054731", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-25362.5, 26500.5, 1440.5), (0, 0, 0), "cspf_1_auto9050160069654054731", "cspf_1_auto12339339623817174854", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-26959, 24267.5, 1344), (0, 0, 0), "cspf_1_auto12339339623817174854", "cspf_1_auto11674892209309896251", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-29317, 20226, 1258), (0, 0, 0), "cspf_1_auto11674892209309896251", "cspf_1_auto6230014143735085006", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-29843, 18845, 1182), (0, 0, 0), "cspf_1_auto6230014143735085006", "cspf_1_auto12584696661483141968", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-928, 719.5, 2), (0, 0, 0), "cspf_2_auto15217549985945817316", undefined, undefined, undefined, undefined, (-14611.5, 34779.4, 1272.5), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (640, 723.5, 2), (0, 0, 0), "cspf_2_auto15217549985945817316", undefined, undefined, undefined, undefined, (-14611.5, 34779.4, 1272.5), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_a_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (0, 633.5, 0), (0, 0, 0), "vault_bishop_encounter", "cspf_2_auto15217549985945817316", undefined, undefined, undefined, (-14611.5, 34779.4, 1272.5), (0, 0, 0), 256);
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_a_ob_activities_vault_cs");
}