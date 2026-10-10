/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_712b2709e2e169ea.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_sira_ob_circle_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_sira_ob_circle_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_sira_ob_circle_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_sira_ob_circle_cs");

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

  s cs_setup_arrays(us, "mp_jup_sira_ob_circle_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_sira_ob_circle_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_sira_ob_circle_cs";
  s.name = "script_struct_ob_circle_start";
  fe[[f]](s, us, cf, (-34283.9, -20776, 280.46), (0, 0, 0), "ob_circle_start", undefined, undefined, undefined, undefined, undefined, undefined, 14000);
  s = s();
  s.cs_flag = "mp_jup_sira_ob_circle_cs";
  s.name = "script_struct_infil_rift_gate";
  fe[[f]](s, us, cf, (-41379.2, -18042.1, 277.99), (0, 198.56, 0), "ob_infil_rift_gate");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_circle_cs";
  s.name = "script_struct_exit_portal_warehouse";
  fe[[f]](s, us, cf, (-43834.6, -22248.5, 264), (0, 79.23, 0), "exit_portal");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_circle_cs";
  s.name = "script_struct_exit_portal_hills";
  fe[[f]](s, us, cf, (-28587.8, -12630.6, 1351.75), (0, 323.54, 0), "exit_portal");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_circle_cs";
  s.name = "script_struct_exit_portal_docks";
  fe[[f]](s, us, cf, (-38937.8, -29687.7, -85.71), (0, 199.88, 0), "exit_portal");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_circle_cs";
  s.name = "script_struct_exit_portal_police_station";
  fe[[f]](s, us, cf, (-23665.8, -24173.5, 256), (0, 359.45, 0), "exit_portal");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_sira_ob_circle_cs");
}