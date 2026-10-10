/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_43ec9e90e7cc419d.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_g_ob_machines_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_g_ob_machines_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_g_ob_machines_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_g_ob_machines_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_g_ob_machines_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_g_ob_machines_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_machines_cs";
  s.content_key = "pap_spawn";
  s.name = "pap_spawn";
  s.script_modelname = "t10_zm_pap_fxanim";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-23229, -31910, 1953), (0.81, 76.69, -0.55));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-4441.37, -22778.3, 1566.04), (0, 81.76, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-15279, -22632, 1716), (0, 342.48, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-24526, -23286.9, 1698.01), (0, 347.48, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-6678, -30636, 1751), (0, 348.2, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-22836, -11485, 1504.98), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-17232.9, -36981.2, 2453.98), (0, 68.2, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_machines_cs";
  s.content_key = "pap_spawn";
  s.name = "pap_spawn";
  s.script_modelname = "t10_zm_pap_fxanim";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-11943.2, -24096, 5224), (0, 6.73, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-20417, -29054, 1832), (0, 132.2, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-20729, -15917, 1512), (0, 298.92, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.name = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-8240, -9146, 1579), (0, 224.2, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_machines_cs";
  s.content_key = "perk_machine_region_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-30092, -10698, 1545), (0, 150.4, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_machines_cs";
  s.content_key = "pap_spawn";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-14441.5, -13650.3, 1963.98), (0, 283.9, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_machines_cs";
  s.content_key = "pap_spawn";
  s.name = "pap_spawn";
  s.script_modelname = "t10_zm_pap_fxanim";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-13450.8, -19886.7, 1816), (0, 314.83, 0));
  s = s();
  s.cs_flag = "mp_jup_st_g_ob_machines_cs";
  s.content_key = "pap_spawn";
  s.name = "pap_spawn";
  s.script_modelname = "t10_zm_pap_fxanim";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (-10420, -40184, 2781.5), (0, 19.93, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_g_ob_machines_cs");
}