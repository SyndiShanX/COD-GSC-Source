/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3a1fff407627c77b.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_b_ob_activities_mrp_challenges_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_b_ob_activities_mrp_challenges_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_b_ob_activities_mrp_challenges_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_b_ob_activities_mrp_challenges_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_b_ob_activities_mrp_challenges_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_b_ob_activities_mrp_challenges_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_mrp_challenges_cs";
  s.trigger_offset = "0,0,20";
  s.trigger_size = "330,410,40";
  fe[[f]](s, us, cf, (-1917.47, 32985, 1799.53), (39.6, 325.7, -0), "cspf_0_auto54962018229757466");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_mrp_challenges_cs";
  fe[[f]](s, us, cf, (-1921.61, 32989.6, 1889.37), (0, 74.1, 0), "mrp_challenge", "cspf_0_auto54962018229757466", "mrp_nuclear_precision_challenge");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_mrp_challenges_cs";
  s.trigger_offset = "0,0,20";
  s.trigger_size = "330,410,40";
  fe[[f]](s, us, cf, (-2465.27, 32984.8, 1822.89), (41, 145.7, -180), "cspf_0_auto54962018229757466");
  s = s();
  s.cs_flag = "mp_jup_st_b_ob_activities_mrp_challenges_cs";
  s.trigger_offset = "0,0,20";
  s.trigger_size = "330,410,40";
  fe[[f]](s, us, cf, (-1385.47, 32997, 1813.53), (81.1, 145.7, -92.5), "cspf_0_auto54962018229757466");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_b_ob_activities_mrp_challenges_cs");
}