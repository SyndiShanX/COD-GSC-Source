/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_16a7cb806f08d342.gsc
*************************************************/

#using scripts\common\create_script_utility;
#using scripts\engine\utility;
#namespace mp_jup_tower_ob_locked_spaces_cs;

function main(unused, us) {
  if(flag_exist("mp_jup_tower_ob_locked_spaces_cs")) {
    return;
  }

  if(!isDefined(us)) {
    us = function_b055d49370405173();
  }

  flag_init("mp_jup_tower_ob_locked_spaces_cs");
  s = spawnStruct();
  level thread cs_return_and_wait_for_flag(us, s, "mp_jup_tower_ob_locked_spaces_cs");

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

  s cs_setup_arrays(us, "mp_jup_tower_ob_locked_spaces_cs");
  cs_flags_init(s);
  level thread createstructs(s, us, cf);
  level thread wait_for_flags(s, "mp_jup_tower_ob_locked_spaces_cs");
}

function createstructs(fe, us, cf) {
  f = &strike_additem;
  s = s();
  s.cs_flag = "mp_jup_tower_ob_locked_spaces_cs";
  s.name = "s5rr_ee_towerBreakroom_root";
  fe[[f]](s, us, cf, (10429.6, 13400.5, 334.83), (0, 0, 0), "tower_breakroom", "lockedspace_s5rr_ee_towerBreakroom", "lockedSpace");
  s = s();
  s.cs_flag = "mp_jup_tower_ob_locked_spaces_cs";
  s.name = "s5rr_ee_towerRoof_lockNode_1";
  fe[[f]](s, us, cf, (15051.9, 20988.2, 4071), (0, 270, 0), "lockedspace_s5rr_ee_towerRoof", undefined, "lockMe");
  s = s();
  s.cs_flag = "mp_jup_tower_ob_locked_spaces_cs";
  s.name = "s5rr_ee_towerBreakroom_lockNode_2";
  fe[[f]](s, us, cf, (10423.8, 13984.8, 273), (0, 330, 0), "lockedspace_s5rr_ee_towerBreakroom", undefined, "lockMe");
  s = s();
  s.cs_flag = "mp_jup_tower_ob_locked_spaces_cs";
  s.name = "s5rr_ee_towerBreakroom_lockNode";
  fe[[f]](s, us, cf, (10250.5, 13974.1, 273), (0, 150, 0), "lockedspace_s5rr_ee_towerBreakroom", undefined, "lockMe");
  s = s();
  s.cs_flag = "mp_jup_tower_ob_locked_spaces_cs";
  s.name = "s5rr_ee_towerBreakroom_lockNode_3";
  fe[[f]](s, us, cf, (9325.8, 13453.5, 273), (0, 240, 0), "lockedspace_s5rr_ee_towerBreakroom", undefined, "lockMe");
  s = s();
  s.cs_flag = "mp_jup_tower_ob_locked_spaces_cs";
  s.name = "s5rr_ee_towerBreakroom_lockNode_4";
  fe[[f]](s, us, cf, (10550, 12827.2, 273), (0, 330, 0), "lockedspace_s5rr_ee_towerBreakroom", undefined, "lockMe");
  s = s();
  s.cs_flag = "mp_jup_tower_ob_locked_spaces_cs";
  s.name = "s5rr_ee_towerRoof_loot";
  fe[[f]](s, us, cf, (15224.2, 21249.9, 4071), (359.33, 178.49, -0.57), "ob_s5rr_locked_space_loot");
  s = s();
  s.cs_flag = "mp_jup_tower_ob_locked_spaces_cs";
  s.name = "s5rr_ee_towerBreakroom_lockNode_4";
  fe[[f]](s, us, cf, (11285.6, 12737.2, 273), (0, 240, 0), "lockedspace_s5rr_ee_towerBreakroom", undefined, "lockMe");
  s = s();
  s.cs_flag = "mp_jup_tower_ob_locked_spaces_cs";
  s.name = "s5rr_ee_towerBreakroom_lockNode_4";
  fe[[f]](s, us, cf, (11674.9, 13263.2, 273), (0, 330, 0), "lockedspace_s5rr_ee_towerBreakroom", undefined, "lockMe");
  s = s();
  s.cs_flag = "mp_jup_tower_ob_locked_spaces_cs";
  s.name = "s5rr_ee_towerRoof_root";
  fe[[f]](s, us, cf, (15102.7, 21094.2, 4366.45), (0, 0, 0), "tower_roof", "lockedspace_s5rr_ee_towerRoof", "lockedSpace");
  s = s();
  s.cs_flag = "mp_jup_tower_ob_locked_spaces_cs";
  s.name = "s5rr_ee_towerRoof_lockNode_2";
  fe[[f]](s, us, cf, (15240.1, 21374.1, 4071), (0, 0, 0), "lockedspace_s5rr_ee_towerRoof", undefined, "lockMe");
  s = s();
  s.cs_flag = "mp_jup_tower_ob_locked_spaces_cs";
  s.name = "s5rr_ee_towerRoof_loot";
  fe[[f]](s, us, cf, (14880.3, 21142.5, 4071), (359.33, 357.1, -0.57), "ob_s5rr_locked_space_loot");
  s = s();
  s.cs_flag = "mp_jup_tower_ob_locked_spaces_cs";
  s.name = "s5rr_ee_towerBreakroom_lockNode_4";
  fe[[f]](s, us, cf, (10957.5, 13676.9, 273), (0, 150, 0), "lockedspace_s5rr_ee_towerBreakroom", undefined, "lockMe");
  s = s();
  s.cs_flag = "mp_jup_tower_ob_locked_spaces_cs";
  fe[[f]](s, us, cf, (5961.93, 20738, 294.75), (359.33, 359.54, -0.57), "ob_locked_space_loot_disabled");
  fe ent_flag_set("cs_objects_created");
  function_7af6d59eef91a7dd();
}

function function_7af6d59eef91a7dd() {}

function cleanup() {
  function_71a564b3bc009618("mp_jup_tower_ob_locked_spaces_cs");
}