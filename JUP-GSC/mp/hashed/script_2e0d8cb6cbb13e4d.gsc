/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2e0d8cb6cbb13e4d.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_g_ob_activities_vault_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_g_ob_activities_vault_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_g_ob_activities_vault_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_g_ob_activities_vault_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_g_ob_activities_vault_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_g_ob_activities_vault_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  s.name = "zombie encounter";
  fe[[f]](s, us, cf, (1092, 1226, -590.54), (0, 0, 0), "vault_rook_zombies_encounter", undefined, undefined, undefined, undefined, (-29527, -11423.5, 2120.5), (0, 270, 0), 500);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (439, -558, -136), (0, 0, 0), "vault_rook_mine", undefined, undefined, undefined, undefined, (-29527, -11423.5, 2120.5), (0, 270, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  s.name = "rook encounter";
  fe[[f]](s, us, cf, (70, 22, 0), (0, 61.99, 0), "vault_rook_encounter", "cspf_1_auto4969003541871034639", undefined, undefined, undefined, (-29527, -11423.5, 2120.5), (0, 270, 0), 64);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  s.name = "sentry";
  fe[[f]](s, us, cf, (-403, -274, 0), (0, 332, 0), "vault_rook_sentry", undefined, undefined, undefined, undefined, (-29527, -11423.5, 2120.5), (0, 270, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  s.name = "fallback";
  fe[[f]](s, us, cf, (-83, -175, 0), (0, 61.99, 0), "cspf_1_auto4969003541871034639", undefined, undefined, undefined, undefined, (-29527, -11423.5, 2120.5), (0, 270, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (348.5, -744, -576), (0, 0, 0), "vault_rook_mine", undefined, undefined, undefined, undefined, (-29527, -11423.5, 2120.5), (0, 270, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-131, -420, 2.5), (0, 0, 0), "vault_rook_mine", undefined, undefined, undefined, undefined, (-29527, -11423.5, 2120.5), (0, 270, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-705, 102, 0), (0, 270, 0), "vault_rook_mine", undefined, undefined, undefined, undefined, (-29527, -11423.5, 2120.5), (0, 270, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (-751, 244, -0), (0, 270, 0), "vault_rook_mine", undefined, undefined, undefined, undefined, (-29527, -11423.5, 2120.5), (0, 270, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (407.5, -722, -272), (0, 0, 0), "vault_rook_mine", undefined, undefined, undefined, undefined, (-29527, -11423.5, 2120.5), (0, 270, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (425, -738.5, 168), (0, 0, 0), "vault_rook_mine", undefined, undefined, undefined, undefined, (-29527, -11423.5, 2120.5), (0, 270, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (224, -651, 200), (0, 0, 0), "vault_rook_mine", undefined, undefined, undefined, undefined, (-29527, -11423.5, 2120.5), (0, 270, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  s.name = "mine";
  fe[[f]](s, us, cf, (495.5, -403.5, -576), (0, 0, 0), "vault_rook_mine", undefined, undefined, undefined, undefined, (-29527, -11423.5, 2120.5), (0, 270, 0), 100);
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  s.name = "trigger";
  fe[[f]](s, us, cf, (-290.5, -329.5, 46), (0, 329.5, 0), "rook_trigger_location", undefined, undefined, undefined, undefined, (-29527, -11423.5, 2120.5), (0, 270, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  s.name = "path_start";
  fe[[f]](s, us, cf, (-28025.2, -8477.25, 1543.51), (0.05, 360, 0.36), "vault_knight_d_to_g_counter", "cspf_2_auto7275612586338093793", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-27831, -10297.5, 1533.5), (0, 0, 0), "cspf_2_auto7275612586338093793", "cspf_2_auto5336982010402105970", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-27804.5, -11480.5, 1529.5), (0, 0, 0), "cspf_2_auto5336982010402105970", "cspf_2_auto8143819390916297204", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-28035.5, -12921, 1530), (0, 0, 0), "cspf_2_auto8143819390916297204", "cspf_2_auto4747036383826005355", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-28937.5, -15817, 1537.5), (0, 0, 0), "cspf_2_auto4747036383826005355", "cspf_2_auto13359310375821743627", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-29332.5, -17236, 1542.5), (0, 0, 0), "cspf_2_auto13359310375821743627", "cspf_2_auto11461756171199495746", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-29860, -18313, 1541), (0, 0, 0), "cspf_2_auto11461756171199495746", "cspf_2_auto9611311082878906021", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-30167, -20506.5, 1551), (0, 0, 0), "cspf_2_auto9611311082878906021", "cspf_2_auto13866089930051732677", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-30262, -22104, 1554.5), (0, 0, 0), "cspf_2_auto13866089930051732677", "cspf_2_auto2201786734557961659", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-29785, -24428.5, 1575), (0, 0, 0), "cspf_2_auto2201786734557961659", "cspf_2_auto18378013390876898524", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  s.name = "path_end";
  fe[[f]](s, us, cf, (-3938.23, -34423.6, 1912.26), (0.75, 357.56, -0.03), "cspf_2_auto2217449408335340859", "vault_knight_g_to_h_counter", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-29342.5, -27981, 1744.95), (357.78, 0.18, -4.59), "cspf_2_auto18378013390876898524", "cspf_2_auto1232767970787195801", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-28122.5, -29638.5, 2061.5), (0, 0, 0), "cspf_2_auto1232767970787195801", "cspf_2_auto2737506686363499556", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-25046, -30571, 1962.04), (0.4, 360, -0.21), "cspf_2_auto2737506686363499556", "cspf_2_auto640689212389146883", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-22298, -31241, 1950), (0, 0, 0), "cspf_2_auto640689212389146883", "cspf_2_auto929145294045382599", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-19931.5, -31792, 1947.5), (0, 0, 0), "cspf_2_auto929145294045382599", "cspf_2_auto98763622493331536", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-16023.5, -32743, 1948), (0, 0, 0), "cspf_2_auto98763622493331536", "cspf_2_auto5182362448367675248", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-11641, -33870, 1916), (0, 0, 0), "cspf_2_auto5182362448367675248", "cspf_2_auto17352349418286968979", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-8183.5, -34760, 1892), (0, 0, 0), "cspf_2_auto17352349418286968979", "cspf_2_auto8031416233768994869", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-5964.5, -34758.5, 1916), (0, 0, 0), "cspf_2_auto8031416233768994869", "cspf_2_auto2217449408335340859", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_g_ob_activities_vault_cs");
}