/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1107d6250762b72b.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_e_ob_activities_mrp_challenges_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_e_ob_activities_mrp_challenges_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_e_ob_activities_mrp_challenges_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_e_ob_activities_mrp_challenges_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_e_ob_activities_mrp_challenges_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_e_ob_activities_mrp_challenges_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_mrp_challenges_cs";
  fe[[f]](s, us, cf, (-5572, 1172, 2208), (0, 150, 0), "cspf_0_auto15876721927107115881", "cspf_0_auto12278475722300310701");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_mrp_challenges_cs";
  fe[[f]](s, us, cf, (-5688, 1288, 2207.5), (0, 0, 0), "cspf_0_auto12278475722300310701");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_activities_mrp_challenges_cs";
  fe[[f]](s, us, cf, (-5768, 1312, 2254.5), (0, 315, 0), "mrp_respect_challenge", "cspf_0_auto15876721927107115881");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_e_ob_activities_mrp_challenges_cs");
}