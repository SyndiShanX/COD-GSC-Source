/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1be98242d2bd926e.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_fort_ob_locked_spaces_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_fort_ob_locked_spaces_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_fort_ob_locked_spaces_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_fort_ob_locked_spaces_cs");

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

  s cs_setup_arrays(us, "mp_jup_fort_ob_locked_spaces_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_fort_ob_locked_spaces_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (19615, -53644, 1065.25), (0, 0, 0), "cspf_0_auto139", undefined, "lockMe");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (18144, -55167, 1320.25), (0, 0, 0), "cspf_0_auto147", undefined, "lockMe");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (19552, -53673, 1056.5), (-90, 0, 0), "cspf_0_auto139", undefined, "note");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (19440, -53775, 1024.5), (0, 270, 0), "cspf_0_auto139", undefined, "notebook");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (19445, -53790, 1024), (0, 270, 0), "cspf_0_auto139", undefined, "key");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (19486, -53657, 1585.25), (0, 270, 0), "fortbarrack1_rr", "cspf_0_auto139", "lockedSpace");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (16002, -54567, 1070.25), (0, 90, 0), "cspf_0_auto155", undefined, "lockMe");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (22562, -55253, 1011), (0, 16.21, 0), "ob_locked_space_loot");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (17963, -55182, 1316.5), (-90, 0, 0), "cspf_0_auto147", undefined, "note");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (17924, -55185, 1316.5), (0, 0, 0), "cspf_0_auto147", undefined, "notebook");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (17965, -55174, 1317), (0, 0, 0), "cspf_0_auto147", undefined, "key");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (18030, -55178, 1891.25), (0, 0, 0), "antiquities_office_rr", "cspf_0_auto147", "lockedSpace");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (16008, -54698, 1024.5), (-90, 0, 0), "cspf_0_auto155", undefined, "note");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (16012, -54717, 1024.5), (0, 30.3, 0), "cspf_0_auto155", undefined, "notebook");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (16017, -54668, 1025), (0, 0, 0), "cspf_0_auto155", undefined, "key");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (16078, -54423, 1636.25), (0, 0, 0), "munitions_storage_rr", "cspf_0_auto155", "lockedSpace");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (19158, -54928, 1515.25), (0, 0, 0), "cspf_0_auto163", undefined, "lockMe");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (19153, -55040, 1496), (0, 270, 0), "cspf_0_auto163", undefined, "ee_window_bars_02_black");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (18997, -54966, 1473.5), (-90, 0, 0), "cspf_0_auto163", undefined, "note");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (18946, -55026, 1496.5), (0, 0, 0), "cspf_0_auto163", undefined, "notebook");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (19009, -54875, 1496), (0, 0, 0), "cspf_0_auto163", undefined, "key");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (19168, -54967, 1771.25), (0, 0, 0), "office_quarters1_rr", "cspf_0_auto163", "lockedSpace");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (19157, -55295, 1513.25), (0, 0, 0), "cspf_0_auto171", undefined, "lockMe");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (19153, -55168, 1496), (0, 270, 0), "cspf_0_auto171", undefined, "ee_window_bars_02_black");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (19079, -55320, 1504.5), (-90, 0, 0), "cspf_0_auto171", undefined, "note");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (19075, -55130, 1496.5), (0, 0, 0), "cspf_0_auto171", undefined, "notebook");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (19048, -55317, 1505), (0, 0, 0), "cspf_0_auto171", undefined, "key");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (19181, -55237, 1783.25), (0, 0, 0), "office_quarters1_rr", "cspf_0_auto171", "lockedSpace");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (22594, -55076, 1032.25), (0, 90, 0), "cspf_0_auto179", undefined, "lockMe");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (22682, -55140, 985.5), (-90, 0, 0), "cspf_0_auto179", undefined, "note");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (22683, -55103, 1022.5), (0, 53.7, 0), "cspf_0_auto179", undefined, "notebook");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (22677, -55115, 1023), (0, 0, 0), "cspf_0_auto179", undefined, "key");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (22649, -55118, 1268.25), (0, 0, 0), "quiet_bedroom_rr", "cspf_0_auto179", "lockedSpace");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (16160, -54568, 1070.25), (0, 90, 0), "cspf_0_auto155", undefined, "lockMe");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (19616, -53795, 1065.25), (0, 0, 0), "cspf_0_auto139", undefined, "lockMe_DISABLED");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (18963, -55177, 1500), (0, 15.2, 0), "ob_locked_space_loot");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (19415, -53672, 1024), (0, 47.1, 0), "ob_locked_space_powerup", undefined, "full_armor");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (18133, -51451, 907), (0, 314.5, -90), "ob_locked_space_key", undefined, "ob_jup_item_key_rift_run_office_quarters1");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (18005, -55326, 1280), (0, 180.51, 0), "ob_locked_space_loot");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (18987, -54919, 1472), (0, 0, 0), "ob_locked_space_powerup", undefined, "full_ammo");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (16203, -54679, 1024), (0, 176.3, 0), "ob_locked_space_loot");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (19379, -53617, 1051), (359.33, 359.54, -0.57), "ob_locked_space_loot");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (18392, -55972, 700), (0, 131.78, -90), "ob_locked_space_key", undefined, "ob_jup_item_key_rift_run_antiquities_office");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (22641, -55280, 984), (0, 90, 0), "ob_locked_space_powerup", undefined, "nuke");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (17973, -55238, 1280), (0, 0, 0), "ob_locked_space_powerup", undefined, "full_power");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (15980, -54698, 1024), (0, 90, 0), "ob_locked_space_powerup", undefined, "insta_kill");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (19977, -57592, 576), (0, 41.56, 90), "ob_locked_space_key", undefined, "ob_jup_item_key_rift_run_quiet_bedroom");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (22911, -53951, 742), (0, 168.7, -90), "ob_locked_space_key", undefined, "ob_jup_item_key_rift_run_fort_barrack1");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (9452, -52121, 752), (0, 328.4, -90), "ob_locked_space_key", undefined, "ob_jup_item_key_rift_run_munitions_storage");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (15682, -54154, 2048), (360, 322.8, -90), "ob_locked_space_key", undefined, "ob_jup_item_key_rift_run_munitions_storage");
  s = s();
  s.cs_flag = "mp_jup_fort_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (16812, -54612, 2048), (0, 344.5, -90), "ob_locked_space_key", undefined, "ob_jup_item_key_rift_run_office_quarters1");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_fort_ob_locked_spaces_cs");
}