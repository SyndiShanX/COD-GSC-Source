/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_9ceb376db23527.gsc
***********************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_g_ob_activities_mrp_challenges_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_g_ob_activities_mrp_challenges_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_g_ob_activities_mrp_challenges_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_g_ob_activities_mrp_challenges_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_g_ob_activities_mrp_challenges_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_g_ob_activities_mrp_challenges_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_mrp_challenges_cs";
  fe[[f]](s, us, cf, (-19872.8, -25571.4, 1738), (0, 2.4, 0), "mrp_challenge", "cspf_0_auto5673550340626558106", "mrp_cardio_challenge");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_mrp_challenges_cs";
  s.trigger_offset = "0,0,1825";
  s.trigger_size = "203,597,3650";
  fe[[f]](s, us, cf, (-19763, -25668.4, 1738), (0, 5.49, 0), "cspf_0_auto5673550340626558106", "cspf_0_auto6622278634214651929");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_mrp_challenges_cs";
  s.trigger_offset = "0,0,40";
  s.trigger_size = "186,349,80";
  fe[[f]](s, us, cf, (-19763, -25668.4, 1738), (0, 5.49, 0), "cspf_0_auto6622278634214651929", "cspf_0_auto5938372635079691450");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_mrp_challenges_cs";
  s.trigger_offset = "0,0,40";
  s.trigger_size = "186,238,80";
  fe[[f]](s, us, cf, (-19726.1, -25342.3, 5274), (0, 5.49, 0), "cspf_0_auto12309318834711002773", "cspf_0_auto7393297584210093051");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_mrp_challenges_cs";
  fe[[f]](s, us, cf, (-19733.7, -25299.9, 5274), (0, 5.49, 0), "cspf_0_auto7393297584210093051");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_mrp_challenges_cs";
  s.trigger_offset = "0,0,40";
  s.trigger_size = "186,349,80";
  fe[[f]](s, us, cf, (-19763, -25669.4, 4541), (0, 5.49, 0), "cspf_0_auto6025198360520748741", "cspf_0_auto12309318834711002773");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_mrp_challenges_cs";
  s.trigger_offset = "0,0,40";
  s.trigger_size = "186,349,80";
  fe[[f]](s, us, cf, (-19762, -25670.4, 3724), (0, 5.49, 0), "cspf_0_auto4182073917970948136", "cspf_0_auto6025198360520748741");
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_mrp_challenges_cs";
  s.trigger_offset = "0,0,40";
  s.trigger_size = "186,349,80";
  fe[[f]](s, us, cf, (-19761, -25671.4, 2736), (0, 5.49, 0), "cspf_0_auto5938372635079691450", "cspf_0_auto4182073917970948136");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_g_ob_activities_mrp_challenges_cs");
}