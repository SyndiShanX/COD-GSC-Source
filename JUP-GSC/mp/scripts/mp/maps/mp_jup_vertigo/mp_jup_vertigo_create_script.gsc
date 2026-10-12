/***************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_vertigo\mp_jup_vertigo_create_script.gsc
***************************************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_vertigo_create_script;

function main(unused, us) {
  if(flag_exist("mp_jup_vertigo_create_script")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_vertigo_create_script");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_vertigo_create_script");

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

  s cs_setup_arrays(us, "mp_jup_vertigo_create_script");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_vertigo_create_script");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_vertigo_create_script";
  s.groupid = "secret_pickups";
  s.name = "secret_pickup_5";
  fe[[f]](s, us, cf, (80, -1632, 4472), (0, 0, 0), undefined, undefined, "secret_pickup");
  s = s();
  s.cs_flag = "mp_jup_vertigo_create_script";
  s.groupid = "secret_pickups";
  s.name = "secret_pickup_1";
  fe[[f]](s, us, cf, (1696, 792, 656), (0, 0, 0), undefined, undefined, "secret_pickup");
  s = s();
  s.cs_flag = "mp_jup_vertigo_create_script";
  s.name = "ending_door_pos";
  fe[[f]](s, us, cf, (0, 11424, 11688), (0, 0, 0), "ending_door_pos");
  s = s();
  s.cs_flag = "mp_jup_vertigo_create_script";
  s.name = "secret_return_door_pos";
  fe[[f]](s, us, cf, (-2, 13632, 11656), (0, 0, 0), "secret_return_door_pos");
  s = s();
  s.cs_flag = "mp_jup_vertigo_create_script";
  s.groupid = "secret_pickups";
  s.name = "secret_pickup_7";
  fe[[f]](s, us, cf, (-960, -2624, 5552), (0, 0, 0), undefined, undefined, "secret_pickup");
  s = s();
  s.cs_flag = "mp_jup_vertigo_create_script";
  s.groupid = "secret_pickups";
  s.name = "secret_pickup_6";
  fe[[f]](s, us, cf, (-65.81, -2143.9, 5808), (0, 0, 0), undefined, undefined, "secret_pickup");
  s = s();
  s.cs_flag = "mp_jup_vertigo_create_script";
  s.groupid = "secret_pickups";
  s.name = "secret_pickup_8";
  fe[[f]](s, us, cf, (-1088, -320, 6480), (0, 0, 0), undefined, undefined, "secret_pickup");
  s = s();
  s.cs_flag = "mp_jup_vertigo_create_script";
  s.groupid = "secret_pickups";
  s.name = "secret_pickup_9";
  fe[[f]](s, us, cf, (2136, -120, 6517), (0, 0, 0), undefined, undefined, "secret_pickup");
  s = s();
  s.cs_flag = "mp_jup_vertigo_create_script";
  s.groupid = "secret_pickups";
  s.name = "secret_pickup_10";
  fe[[f]](s, us, cf, (0, 160, 7280), (0, 0, 0), undefined, undefined, "secret_pickup");
  s = s();
  s.cs_flag = "mp_jup_vertigo_create_script";
  s.groupid = "secret_pickups";
  s.name = "secret_pickup_2";
  fe[[f]](s, us, cf, (-80, -1408, 1200), (0, 0, 0), undefined, undefined, "secret_pickup");
  s = s();
  s.cs_flag = "mp_jup_vertigo_create_script";
  s.groupid = "secret_pickups";
  s.name = "secret_pickup_12";
  fe[[f]](s, us, cf, (0, 5120, 8848), (0, 0, 0), undefined, undefined, "secret_pickup");
  s = s();
  s.cs_flag = "mp_jup_vertigo_create_script";
  s.groupid = "secret_pickups";
  s.name = "secret_pickup_11";
  fe[[f]](s, us, cf, (128, 224, 8176), (0, 0, 0), undefined, undefined, "secret_pickup");
  s = s();
  s.cs_flag = "mp_jup_vertigo_create_script";
  s.groupid = "secret_pickups";
  s.name = "secret_pickup_4";
  fe[[f]](s, us, cf, (96, 2432, 4144), (0, 0, 0), undefined, undefined, "secret_pickup");
  s = s();
  s.cs_flag = "mp_jup_vertigo_create_script";
  s.groupid = "secret_pickups";
  s.name = "secret_pickup_3";
  fe[[f]](s, us, cf, (4896, -1088, 2480), (0, 0, 0), undefined, undefined, "secret_pickup");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_vertigo_create_script");
}