/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_576b63061493a6a7.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_e_ob_exfil_oldtown_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_e_ob_exfil_oldtown_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_e_ob_exfil_oldtown_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_e_ob_exfil_oldtown_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_e_ob_exfil_oldtown_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_e_ob_exfil_oldtown_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_oldtown_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_oldtown_cs";
  s.variantname = "content_location";
  fe[[f]](s, us, cf, (7914, 12072, 3158), (0, 0, 0), "exfil_tile_e_oldtown_location", "ob_st_e_oldtown_exfil_destination");
  s = s();
  s.cs_flag = "mp_jup_st_e_ob_exfil_oldtown_cs";
  s.name = "exfil_content_destination_oldtown";
  s.variantname = "content_destination";
  fe[[f]](s, us, cf, (8040, 12164, 4852), (0, 0, 0), "ob_st_e_oldtown_exfil_destination");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_e_ob_exfil_oldtown_cs");
}