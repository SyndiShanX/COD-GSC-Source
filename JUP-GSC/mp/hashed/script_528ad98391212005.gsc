/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_528ad98391212005.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_i_ob_exfil_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_i_ob_exfil_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_i_ob_exfil_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_i_ob_exfil_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_i_ob_exfil_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_i_ob_exfil_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_exfil_cs";
  s.name = "exfil_content_destination_manor";
  s.variantname = "content_destination";
  fe[[f]](s, us, cf, (27950, -25725, 1861), (0, 0, 0), "ob_st_i_manor_exfil_destination");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_exfil_cs";
  s.content_key = "exfil_interact";
  s.variantname = "content_struct";
  fe[[f]](s, us, cf, (23668, -35635, 3408), (358.7, 108.31, 4), "exfil_content_struct_manor_west", "exfil_content_instance_manor_west");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_exfil_cs";
  s.content_script_name = "exfil";
  s.variantname = "content_instance";
  fe[[f]](s, us, cf, (24755.5, -35364.9, 3499), (0, 314.57, 0), "exfil_content_instance_manor_west", "exfil_tile_i_manor_location");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_exfil_cs";
  s.variantname = "content_location";
  fe[[f]](s, us, cf, (28203, -25913, 1715), (0, 0, 0), "exfil_tile_i_manor_location", "ob_st_i_manor_exfil_destination");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (46507.4, -35954.2, 6114), (0, 95, 0), "cspf_0_auto1525938847763494437", "cspf_0_auto87152684517921089");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (50210.8, -34804.6, 8164), (0, 185, 0), undefined, "cspf_0_auto1525938847763494437", "exfil_content_struct_manor_west");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (43771.9, -40634.8, 6964), (0, 95, 0), "cspf_0_auto87152684517921089", "cspf_0_auto13153500851605361418");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (38192.9, -40009.7, 6533), (0, 95, 0), "cspf_0_auto13153500851605361418", "cspf_0_auto3159671482355696337");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (32978.3, -41779.9, 5688), (0, 95, 0), "cspf_0_auto3159671482355696337", "cspf_0_auto9472831467943339569");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (28759.6, -40532, 4613), (0, 95, 0), "cspf_0_auto9472831467943339569", "cspf_0_auto9309664513282600956");
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_exfil_cs";
  s.script_speed = int(60);
  fe[[f]](s, us, cf, (24941.7, -37334.5, 4562), (0, 95, 0), "cspf_0_auto9309664513282600956");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_i_ob_exfil_cs");
}