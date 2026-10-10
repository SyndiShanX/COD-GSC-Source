/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_479c151825f9bd25.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_d_ob_activities_vault_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_d_ob_activities_vault_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_d_ob_activities_vault_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_d_ob_activities_vault_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_d_ob_activities_vault_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_d_ob_activities_vault_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_vault_cs";
  s.name = "path_start";
  fe[[f]](s, us, cf, (-30512, 15542, 1007.91), (0.03, 0.02, -0.06), "vault_knight_a_to_d_counter", "cspf_1_auto15862628311246858853", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-30720, 14129.5, 1004), (0, 0, 0), "cspf_1_auto15862628311246858853", "cspf_1_auto12757641588040225570", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-30912, 12367.5, 990), (0, 0, 0), "cspf_1_auto12757641588040225570", "cspf_1_auto7595551657869112932", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-30936, 11038.5, 986), (0, 0, 0), "cspf_1_auto7595551657869112932", "cspf_1_auto15658394442195874620", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-30931.5, 10256, 984), (0, 0, 0), "cspf_1_auto15658394442195874620", "cspf_1_auto12799961338495996917", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-30590.5, 9674, 975.5), (0, 0, 0), "cspf_1_auto12799961338495996917", "cspf_1_auto12890503703462127757", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-30503, 8424.5, 962), (0, 0, 0), "cspf_1_auto12890503703462127757", "cspf_1_auto17999762445241814467", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-30172, 6632.5, 956.5), (0, 0, 0), "cspf_1_auto17999762445241814467", "cspf_1_auto577800445217906243", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-30047.5, 4884.5, 976.93), (359.92, 0, -1.35), "cspf_1_auto577800445217906243", "cspf_1_auto714899078629665126", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-30147, 3867.5, 1006.5), (0, 0, 0), "cspf_1_auto714899078629665126", "cspf_1_auto7965728122153642488", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-29616.5, 686.5, 1318), (0, 0, 0), "cspf_1_auto7965728122153642488", "cspf_1_auto10883375033425325009", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-29141, -2043, 1598), (0, 0, 0), "cspf_1_auto10883375033425325009", "cspf_1_auto10211365763841436105", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (-28740, -4281.5, 1649.5), (0, 0, 0), "cspf_1_auto10211365763841436105", "cspf_1_auto14196962448980117738", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_d_ob_activities_vault_cs";
  s.name = "path_end";
  fe[[f]](s, us, cf, (-28148, -7625.27, 1557.93), (359.92, 0.12, 1.67), "cspf_1_auto14196962448980117738", "vault_knight_d_to_g_counter", undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_d_ob_activities_vault_cs");
}