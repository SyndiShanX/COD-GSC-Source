/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_369ec26a4522e639.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_st_i_ob_activities_vault_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_st_i_ob_activities_vault_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_st_i_ob_activities_vault_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_st_i_ob_activities_vault_cs");

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

  s cs_setup_arrays(us, "mp_jup_st_i_ob_activities_vault_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_st_i_ob_activities_vault_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_vault_cs";
  fe[[f]](s, us, cf, (0, 0, 0), (0, 0, 0), undefined, undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_vault_cs";
  s.name = "vault_cache";
  s.script_linkname = "link_vault_panic_room";
  fe[[f]](s, us, cf, (29884.2, -30427.9, 3036), (0, 159.12, 0), "s_vault_cache", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_vault_cs";
  s.name = "vault_doors";
  s.script_linkname = "link_vault_panic_room";
  fe[[f]](s, us, cf, (29832.5, -30566.2, 3036.5), (0, 250.17, 0), "s_vault_door", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_vault_cs";
  s.name = "vault_doors";
  s.script_linkname = "link_vault_panic_room";
  fe[[f]](s, us, cf, (29810.8, -30384.8, 3038), (0, 160.66, 0), "s_vault_door", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_vault_cs";
  s.name = "vault_cache";
  s.script_linkname = "link_vault_panic_room";
  fe[[f]](s, us, cf, (29953.2, -30453.9, 3036), (0, 159.96, 0), "s_vault_cache", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_vault_cs";
  s.name = "vault_cache";
  s.script_linkname = "link_vault_panic_room";
  fe[[f]](s, us, cf, (29804.2, -30478.4, 3036), (0, 250.46, 0), "s_vault_cache", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  s = s();
  s.cs_flag = "mp_jup_st_i_ob_activities_vault_cs";
  s.script_linkto = "link_vault_panic_room";
  fe[[f]](s, us, cf, (29931.5, -30496.2, 3036), (0, 336.84, 0), "vault_panic_room_center", undefined, undefined, undefined, undefined, (0, 0, 0), (0, 0, 0));
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_st_i_ob_activities_vault_cs");
}