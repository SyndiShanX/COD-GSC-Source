/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_b887ac99ebc3e1f.gsc
************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_c_ob_activities_mrp_challenges_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_c_ob_activities_mrp_challenges_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_c_ob_activities_mrp_challenges_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_c_ob_activities_mrp_challenges_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_c_ob_activities_mrp_challenges_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_c_ob_activities_mrp_challenges_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_mrp_challenges_cs";
  fe[[f]](s, us, cf, (37120.1, 18675.4, 3797.5), (0, 127.71, 0), "mrp_challenge", "cspf_0_auto2080261104392544791", "mrp_hhg_challenge");
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_mrp_challenges_cs";
  fe[[f]](s, us, cf, (37179.6, 18593.2, 3858.66), (0, 0, 0), "cspf_0_auto9890371747024809325", undefined, undefined, undefined, undefined, undefined, undefined, 50);
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_mrp_challenges_cs";
  fe[[f]](s, us, cf, (37056.6, 18763.2, 3858.66), (0, 0, 0), "cspf_0_auto2080261104392544791", "cspf_0_auto9890371747024809325", undefined, undefined, undefined, undefined, undefined, 140);
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_mrp_challenges_cs";
  fe[[f]](s, us, cf, (37210.6, 18873.2, 3858.66), (0, 0, 0), "cspf_0_auto9890371747024809325", undefined, undefined, undefined, undefined, undefined, undefined, 50);
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_mrp_challenges_cs";
  fe[[f]](s, us, cf, (36939.6, 18909.2, 3870.66), (0, 0, 0), "cspf_0_auto9890371747024809325", undefined, undefined, undefined, undefined, undefined, undefined, 50);
  s = s();
  s.cs_flag = "mp_jup_st_c_ob_activities_mrp_challenges_cs";
  fe[[f]](s, us, cf, (36903.6, 18641.2, 3865.66), (0, 0, 0), "cspf_0_auto9890371747024809325", undefined, undefined, undefined, undefined, undefined, undefined, 50);
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_c_ob_activities_mrp_challenges_cs");
}