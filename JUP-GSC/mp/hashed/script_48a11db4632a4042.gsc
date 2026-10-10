/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_48a11db4632a4042.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_sira_ob_locked_spaces_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_sira_ob_locked_spaces_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_sira_ob_locked_spaces_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_sira_ob_locked_spaces_cs");

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

  s cs_setup_arrays(us, "mp_jup_sira_ob_locked_spaces_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_sira_ob_locked_spaces_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_139";
  fe[[f]](s, us, cf, (-42741.8, -28251.3, -745.49), (0, 0, 0), "cspf_0_auto139", undefined, "lockMe");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_147";
  fe[[f]](s, us, cf, (-44212.8, -29774.3, -1001.6), (0, 0, 0), "cspf_0_auto147", undefined, "lockMe");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_139";
  fe[[f]](s, us, cf, (-42804.8, -28280.3, -750.47), (-90, 0, 0), "cspf_0_auto139", undefined, "note");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_139";
  fe[[f]](s, us, cf, (-42916.8, -28382.3, -761.95), (0, 270, 0), "cspf_0_auto139", undefined, "notebook");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_139";
  fe[[f]](s, us, cf, (-42911.8, -28397.3, -762.36), (0, 270, 0), "cspf_0_auto139", undefined, "key");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_139";
  fe[[f]](s, us, cf, (-42870.8, -28264.3, -402.01), (0, 270, 0), "sirabarrack1_rr", "cspf_0_auto139", "lockedSpace");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_155";
  fe[[f]](s, us, cf, (-46354.8, -29174.3, -1082.61), (0, 90, 0), "cspf_0_auto155", undefined, "lockMe");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (-43552.8, -28937.3, -996.08), (0, 16.21, 0), "ob_locked_space_loot");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_147";
  fe[[f]](s, us, cf, (-44393.8, -29789.3, -1043.67), (-90, 0, 0), "cspf_0_auto147", undefined, "note");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_147";
  fe[[f]](s, us, cf, (-44432.8, -29792.3, -1048.61), (0, 0, 0), "cspf_0_auto147", undefined, "notebook");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_147";
  fe[[f]](s, us, cf, (-44391.8, -29781.3, -1043.57), (0, 0, 0), "cspf_0_auto147", undefined, "key");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_147";
  fe[[f]](s, us, cf, (-44326.8, -29785.3, -677.41), (0, 0, 0), "antiquities_office_rr", "cspf_0_auto147", "lockedSpace");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_155";
  fe[[f]](s, us, cf, (-46348.8, -29305.3, -1065.63), (-90, 0, 0), "cspf_0_auto155", undefined, "note");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_155";
  fe[[f]](s, us, cf, (-46344.8, -29324.3, -1064.31), (0, 30.3, 0), "cspf_0_auto155", undefined, "notebook");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_155";
  fe[[f]](s, us, cf, (-46339.8, -29275.3, -1068.39), (0, 0, 0), "cspf_0_auto155", undefined, "key");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (-46278.8, -29030.3, -751.98), (0, 0, 0), "munitions_storage_rr", "cspf_0_auto155", "lockedSpace");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_163";
  fe[[f]](s, us, cf, (-43198.8, -29535.3, -901.72), (0, 0, 0), "cspf_0_auto163", undefined, "lockMe");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_163";
  fe[[f]](s, us, cf, (-43203.8, -29647.3, -906.7), (0, 270, 0), "cspf_0_auto163", undefined, "ee_window_bars_02_black");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_163";
  fe[[f]](s, us, cf, (-43359.8, -29573.3, -924.24), (-90, 0, 0), "cspf_0_auto163", undefined, "note");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_163";
  fe[[f]](s, us, cf, (-43410.8, -29633.3, -932.86), (0, 0, 0), "cspf_0_auto163", undefined, "notebook");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_163";
  fe[[f]](s, us, cf, (-43347.8, -29482.3, -917.5), (0, 0, 0), "cspf_0_auto163", undefined, "key");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_163";
  fe[[f]](s, us, cf, (-43188.8, -29574.3, -550.17), (0, 0, 0), "office_quarters1_rr", "cspf_0_auto163", "lockedSpace");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_171";
  fe[[f]](s, us, cf, (-43199.8, -29902.3, -902.81), (0, 0, 0), "cspf_0_auto171", undefined, "lockMe");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_171";
  fe[[f]](s, us, cf, (-43203.8, -29775.3, -906.47), (0, 270, 0), "cspf_0_auto171", undefined, "ee_window_bars_02_black");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_171";
  fe[[f]](s, us, cf, (-43277.8, -29927.3, -913.25), (-90, 0, 0), "cspf_0_auto171", undefined, "note");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_171";
  fe[[f]](s, us, cf, (-43281.8, -29737.3, -918.49), (0, 0, 0), "cspf_0_auto171", undefined, "notebook");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_171";
  fe[[f]](s, us, cf, (-43308.8, -29924.3, -917.57), (0, 0, 0), "cspf_0_auto171", undefined, "key");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_171";
  fe[[f]](s, us, cf, (-43175.8, -29844.3, -548.72), (0, 0, 0), "office_quarters1_rr", "cspf_0_auto171", "lockedSpace");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_179";
  fe[[f]](s, us, cf, (-43520.8, -28760.3, -945.99), (0, 90, 0), "cspf_0_auto179", undefined, "lockMe");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_179";
  fe[[f]](s, us, cf, (-43432.8, -28824.3, -945.3), (-90, 0, 0), "cspf_0_auto179", undefined, "note");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_179";
  fe[[f]](s, us, cf, (-43431.8, -28787.3, -932.55), (0, 53.7, 0), "cspf_0_auto179", undefined, "notebook");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_179";
  fe[[f]](s, us, cf, (-43437.8, -28799.3, -938.24), (0, 0, 0), "cspf_0_auto179", undefined, "key");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_179";
  fe[[f]](s, us, cf, (-43465.8, -28802.3, -594.92), (0, 0, 0), "quiet_bedroom_rr", "cspf_0_auto179", "lockedSpace");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_155";
  fe[[f]](s, us, cf, (-46196.8, -29175.3, -1080.31), (0, 90, 0), "cspf_0_auto155", undefined, "lockMe");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_139";
  fe[[f]](s, us, cf, (-42740.8, -28402.3, -751.62), (0, 0, 0), "cspf_0_auto139", undefined, "lockMe_DISABLED");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_locked_space_loot";
  fe[[f]](s, us, cf, (-43393.8, -29784.3, -932.12), (0, 15.2, 0), "ob_locked_space_loot");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_locked_space_powerup";
  fe[[f]](s, us, cf, (-42941.8, -28279.3, -759.25), (0, 47.1, 0), "ob_locked_space_powerup", undefined, "full_armor");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_locked_space_key";
  fe[[f]](s, us, cf, (-44223.8, -26058.3, -816.74), (0, 314.5, -90), "ob_locked_space_key", undefined, "ob_jup_item_key_rift_run_office_quarters1");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_locked_space_loot";
  fe[[f]](s, us, cf, (-44351.8, -29933.3, -1026.74), (0, 180.51, 0), "ob_locked_space_loot");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_locked_space_powerup";
  fe[[f]](s, us, cf, (-43369.8, -29526.3, -922.4), (0, 90, 0), "ob_locked_space_powerup", undefined, "full_ammo");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_locked_space_loot";
  fe[[f]](s, us, cf, (-46153.8, -29286.3, -1079.25), (0, 176.3, 0), "ob_locked_space_loot");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_locked_space_loot";
  fe[[f]](s, us, cf, (-42977.8, -28224.3, -759.47), (359.33, 359.54, -0.57), "ob_locked_space_loot");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_locked_space_key";
  fe[[f]](s, us, cf, (-43964.8, -30579.3, -955.51), (0, 131.78, -90), "ob_locked_space_key", undefined, "ob_jup_item_key_rift_run_antiquities_office");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_locked_space_powerup";
  fe[[f]](s, us, cf, (-43473.8, -28964.3, -983.67), (0, 90, 0), "ob_locked_space_powerup", undefined, "nuke");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_locked_space_powerup";
  fe[[f]](s, us, cf, (-44383.8, -29845.3, -1039.65), (0, 90, 0), "ob_locked_space_powerup", undefined, "full_power");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_locked_space_powerup";
  fe[[f]](s, us, cf, (-46376.8, -29305.3, -1065.12), (0, 90, 0), "ob_locked_space_powerup", undefined, "insta_kill");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_locked_space_key";
  fe[[f]](s, us, cf, (-42379.8, -32199.3, -635.36), (0, 41.56, 90), "ob_locked_space_key", undefined, "ob_jup_item_key_rift_run_quiet_bedroom");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_locked_space_key";
  fe[[f]](s, us, cf, (-39445.8, -28558.3, -523.07), (0, 168.7, -90), "ob_locked_space_key", undefined, "ob_jup_item_key_rift_run_sira_barrack1");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_locked_space_key";
  fe[[f]](s, us, cf, (-52904.8, -26728.3, -1354.13), (0, 328.4, -90), "ob_locked_space_key", undefined, "ob_jup_item_key_rift_run_munitions_storage");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_locked_space_key";
  fe[[f]](s, us, cf, (-46674.8, -28761.3, -1122.56), (360, 322.8, -90), "ob_locked_space_key", undefined, "ob_jup_item_key_rift_run_munitions_storage");
  s = s();
  s.cs_flag = "mp_jup_sira_ob_locked_spaces_cs";
  s.groupid = "setup_locked_space_key";
  fe[[f]](s, us, cf, (-45544.8, -29219.3, -1114.53), (0, 344.5, -90), "ob_locked_space_key", undefined, "ob_jup_item_key_rift_run_office_quarters1");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_sira_ob_locked_spaces_cs");
}