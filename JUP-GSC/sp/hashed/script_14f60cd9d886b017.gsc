/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_14f60cd9d886b017.gsc
*************************************************/

#using scripts\common\anim;
#using scripts\engine\utility;
#namespace namespace_38756834f4dd25e1;

function main() {
  anim_precache();
  humans();
  script_models();
}

function anim_precache() {}

#using_animtree("generic_human");

function humans() {
  var_628ee97a2bc3bc09 = "generic";
  level.scr_animtree[var_628ee97a2bc3bc09] = #animtree;
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_defuse_idle"][0] = % jup_che_defuse_idle;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_defuse_idle"][0] = "jup_che_defuse_idle";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_defuse_start"] = % jup_che_defuse_start;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_defuse_start"] = "jup_che_defuse_start";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_defuse_death"] = % jup_che_defuse_death;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_defuse_death"] = "jup_che_defuse_death";
  level.scr_animtree["pallet_enemy1"] = #animtree;
  level.scr_anim["pallet_enemy1"]["pallet_enemy_precombat"][0] = % jup_che_pallet_enemy03_idle_loop;
  level.scr_animname["pallet_enemy1"]["pallet_enemy_precombat"][0] = "jup_che_pallet_enemy03_idle_loop";
  level.scr_anim["pallet_enemy1"]["pallet_enemy_precombat_exit"] = % jup_che_pallet_enemy03_idle_out;
  level.scr_animname["pallet_enemy1"]["pallet_enemy_precombat_exit"] = "jup_che_pallet_enemy03_idle_out";
  level.scr_anim["pallet_enemy1"]["pallet_enemy_fall"] = % jup_che_pallet_enemy03_fall_v2;
  level.scr_animname["pallet_enemy1"]["pallet_enemy_fall"] = "jup_che_pallet_enemy03_fall_v2";
  level.scr_animtree["pallet_enemy2"] = #animtree;
  level.scr_anim["pallet_enemy2"]["pallet_enemy_precombat"][0] = % jup_che_pallet_enemy01_idle_loop;
  level.scr_animname["pallet_enemy2"]["pallet_enemy_precombat"][0] = "jup_che_pallet_enemy01_idle_loop";
  level.scr_anim["pallet_enemy2"]["pallet_enemy_precombat_exit"] = % jup_che_pallet_enemy01_idle_out;
  level.scr_animname["pallet_enemy2"]["pallet_enemy_precombat_exit"] = "jup_che_pallet_enemy01_idle_out";
  level.scr_anim["pallet_enemy2"]["pallet_enemy_fall"] = % jup_che_pallet_enemy01_fall_v2;
  level.scr_animname["pallet_enemy2"]["pallet_enemy_fall"] = "jup_che_pallet_enemy01_fall_v2";
  level.scr_animtree["pallet_enemy4"] = #animtree;
  level.scr_anim["pallet_enemy4"]["pallet_enemy_precombat"][0] = % jup_che_pallet_enemy02_idle_loop;
  level.scr_animname["pallet_enemy4"]["pallet_enemy_precombat"][0] = "jup_che_pallet_enemy02_idle_loop";
  level.scr_anim["pallet_enemy4"]["pallet_enemy_precombat_exit"] = % jup_che_pallet_enemy02_idle_out;
  level.scr_animname["pallet_enemy4"]["pallet_enemy_precombat_exit"] = "jup_che_pallet_enemy02_idle_out";
  level.scr_anim["pallet_enemy4"]["pallet_enemy_fall"] = % jup_che_pallet_enemy02_fall_v2;
  level.scr_animname["pallet_enemy4"]["pallet_enemy_fall"] = "jup_che_pallet_enemy02_fall_v2";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_stair_death_npc_01"] = % jup_che_stair_death_npc_01;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_stair_death_npc_01"] = "jup_che_stair_death_npc_01";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_stair_death_npc_02"] = % jup_che_stair_death_npc_02;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_stair_death_npc_02"] = "jup_che_stair_death_npc_02";
  level.scr_anim[var_628ee97a2bc3bc09]["Jup_che_run_pain_death_long_2"] = % jup_che_run_pain_death_long_2;
  level.scr_animname[var_628ee97a2bc3bc09]["Jup_che_run_pain_death_long_2"] = "Jup_che_run_pain_death_long_2";
  level.scr_anim[var_628ee97a2bc3bc09]["Jup_che_run_pain_death_long_3"] = % jup_che_run_pain_death_long_3;
  level.scr_animname[var_628ee97a2bc3bc09]["Jup_che_run_pain_death_long_3"] = "Jup_che_run_pain_death_long_3";
  level.scr_anim[var_628ee97a2bc3bc09]["Jup_che_run_pain_death_short_1"] = % jup_che_run_pain_death_short_1;
  level.scr_animname[var_628ee97a2bc3bc09]["Jup_che_run_pain_death_short_1"] = "Jup_che_run_pain_death_short_1";
  level.scr_anim[var_628ee97a2bc3bc09]["Jup_che_run_pain_death_short_2"] = % jup_che_run_pain_death_short_2;
  level.scr_animname[var_628ee97a2bc3bc09]["Jup_che_run_pain_death_short_2"] = "Jup_che_run_pain_death_short_2";
  level.scr_anim[var_628ee97a2bc3bc09]["Jup_che_run_pain_death_short_3"] = % jup_che_run_pain_death_short_3;
  level.scr_animname[var_628ee97a2bc3bc09]["Jup_che_run_pain_death_short_3"] = "Jup_che_run_pain_death_short_3";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_run_pain_death_short_4"] = % jup_che_run_pain_death_short_4;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_run_pain_death_short_4"] = "jup_che_run_pain_death_short_4";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_run_pain_death_short_5"] = % jup_che_run_pain_death_short_5;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_run_pain_death_short_5"] = "jup_che_run_pain_death_short_5";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_run_pain_death_short_6"] = % jup_che_run_pain_death_short_6;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_run_pain_death_short_6"] = "jup_che_run_pain_death_short_6";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_fallover_03"] = % jup_che_stand_pain_death_fallover_03;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_fallover_03"] = "jup_che_stand_pain_death_fallover_03";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_01"] = % jup_che_stand_pain_death_01;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_01"] = "jup_che_stand_pain_death_01";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_02"] = % jup_che_stand_pain_death_02;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_02"] = "jup_che_stand_pain_death_02";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_03"] = % jup_che_stand_pain_death_03;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_03"] = "jup_che_stand_pain_death_03";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_04"] = % jup_che_stand_pain_death_04;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_04"] = "jup_che_stand_pain_death_04";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_05"] = % jup_che_stand_pain_death_05;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_05"] = "jup_che_stand_pain_death_05";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_06"] = % jup_che_stand_pain_death_06;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_06"] = "jup_che_stand_pain_death_06";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_07"] = % jup_che_stand_pain_death_07;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_07"] = "jup_che_stand_pain_death_07";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_08"] = % jup_che_stand_pain_death_08;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_08"] = "jup_che_stand_pain_death_08";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_09"] = % jup_che_stand_pain_death_09;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_09"] = "jup_che_stand_pain_death_09";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_10"] = % jup_che_stand_pain_death_10;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_10"] = "jup_che_stand_pain_death_10";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_11"] = % jup_che_stand_pain_death_11;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_11"] = "jup_che_stand_pain_death_11";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_12"] = % jup_che_stand_pain_death_12;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_12"] = "jup_che_stand_pain_death_12";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_13"] = % jup_che_stand_pain_death_13;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_13"] = "jup_che_stand_pain_death_13";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_14"] = % jup_che_stand_pain_death_14;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_stand_pain_death_14"] = "jup_che_stand_pain_death_14";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_react_canister_fall_death_01"] = % jup_che_react_canister_fall_death_01;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_react_canister_fall_death_01"] = "jup_che_react_canister_fall_death_01";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_react_canister_fall_death_02"] = % jup_che_react_canister_fall_death_02;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_react_canister_fall_death_02"] = "jup_che_react_canister_fall_death_02";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_react_canister_fall_death_03"] = % jup_che_react_canister_fall_death_03;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_react_canister_fall_death_03"] = "jup_che_react_canister_fall_death_03";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_react_canister_fall_death_04"] = % jup_che_react_canister_fall_death_04;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_react_canister_fall_death_04"] = "jup_che_react_canister_fall_death_04";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_react_canister_fall_signal_01"] = % jup_che_react_canister_fall_signal_01;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_react_canister_fall_signal_01"] = "jup_che_react_canister_fall_signal_01";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_react_canister_fall_signal_02"] = % jup_che_react_canister_fall_signal_02;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_react_canister_fall_signal_02"] = "jup_che_react_canister_fall_signal_02";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_react_canister_fall_signal_03"] = % jup_che_react_canister_fall_signal_03;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_react_canister_fall_signal_03"] = "jup_che_react_canister_fall_signal_03";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_react_canister_fall_runaway_01"] = % jup_che_react_canister_fall_runaway_01;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_react_canister_fall_runaway_01"] = "jup_che_react_canister_fall_runaway_01";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_react_canister_fall_runaway_02"] = % jup_che_react_canister_fall_runaway_02;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_react_canister_fall_runaway_02"] = "jup_che_react_canister_fall_runaway_02";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_door_panic_death_a_in_01"] = % jup_che_door_panic_death_a_in_01;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_door_panic_death_a_in_01"] = "jup_che_door_panic_death_a_in_01";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_door_panic_death_a_in_03"] = % jup_che_door_panic_death_a_in_03;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_door_panic_death_a_in_03"] = "jup_che_door_panic_death_a_in_03";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_door_panic_death_a_loop_01"][0] = % jup_che_door_panic_death_a_loop_01;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_door_panic_death_a_loop_01"][0] = "jup_che_door_panic_death_a_loop_01";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_door_panic_death_a_loop_03"][0] = % jup_che_door_panic_death_a_loop_03;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_door_panic_death_a_loop_03"][0] = "jup_che_door_panic_death_a_loop_03";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_door_panic_death_a_out_01"] = % jup_che_door_panic_death_a_out_01;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_door_panic_death_a_out_01"] = "jup_che_door_panic_death_a_out_01";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_door_panic_death_a_out_03"] = % jup_che_door_panic_death_a_out_03;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_door_panic_death_a_out_03"] = "jup_che_door_panic_death_a_out_03";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_door_panic_death_b_in_01"] = % jup_che_door_panic_death_b_in_01;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_door_panic_death_b_in_01"] = "jup_che_door_panic_death_b_in_01";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_door_panic_death_b_in_02"] = % jup_che_door_panic_death_b_in_02;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_door_panic_death_b_in_02"] = "jup_che_door_panic_death_b_in_02";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_door_panic_death_b_in_03"] = % jup_che_door_panic_death_b_in_03;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_door_panic_death_b_in_03"] = "jup_che_door_panic_death_b_in_03";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_door_panic_death_b_loop_01"][0] = % jup_che_door_panic_death_b_loop_01;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_door_panic_death_b_loop_01"][0] = "jup_che_door_panic_death_b_loop_01";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_door_panic_death_b_loop_02"][0] = % jup_che_door_panic_death_b_loop_02;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_door_panic_death_b_loop_02"][0] = "jup_che_door_panic_death_b_loop_02";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_door_panic_death_b_loop_03"][0] = % jup_che_door_panic_death_b_loop_03;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_door_panic_death_b_loop_03"][0] = "jup_che_door_panic_death_b_loop_03";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_door_panic_death_b_out_01"] = % jup_che_door_panic_death_b_out_01;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_door_panic_death_b_out_01"] = "jup_che_door_panic_death_b_out_01";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_door_panic_death_b_out_02"] = % jup_che_door_panic_death_b_out_02;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_door_panic_death_b_out_02"] = "jup_che_door_panic_death_b_out_02";
  level.scr_anim[var_628ee97a2bc3bc09]["jup_che_door_panic_death_b_out_03"] = % jup_che_door_panic_death_b_out_03;
  level.scr_animname[var_628ee97a2bc3bc09]["jup_che_door_panic_death_b_out_03"] = "jup_che_door_panic_death_b_out_03";
}

#using_animtree("script_model");

function script_models() {
  level.scr_animtree["pallet_canister"] = #animtree;
  level.scr_model["pallet_canister"] = "jup_military_chemical_weapon_rig";
  level.scr_anim["pallet_canister"]["pallet_out"] = % jup_che_pallet_canister_out;
  level.scr_animname["pallet_canister"]["pallet_out"] = "jup_che_pallet_canister_out";
  level.scr_anim["pallet_canister"]["pallet_loop"][0] = % jup_che_pallet_canister_loop;
  level.scr_animname["pallet_canister"]["pallet_loop"][0] = "jup_che_pallet_canister_loop";
  level.scr_animtree["pallet_canister_2"] = #animtree;
  level.scr_model["pallet_canister_2"] = "jup_military_chemical_weapon_rig";
  level.scr_anim["pallet_canister_2"]["pallet_out"] = % jup_che_pallet_canister2_out;
  level.scr_animname["pallet_canister_2"]["pallet_out"] = "jup_che_pallet_canister2_out";
  level.scr_anim["pallet_canister_2"]["pallet_loop"][0] = % jup_che_pallet_canister2_loop;
  level.scr_animname["pallet_canister_2"]["pallet_loop"][0] = "jup_che_pallet_canister2_loop";
  level.scr_animtree["pallet_helicopter"] = #animtree;
  level.scr_model["pallet_helicopter"] = "veh8_mil_air_mindia8";
  level.scr_anim["pallet_helicopter"]["pallet_out"] = % jup_che_pallet_helicopter_out;
  level.scr_animname["pallet_helicopter"]["pallet_out"] = "jup_che_pallet_helicopter_out";
  level.scr_anim["pallet_helicopter"]["pallet_loop"][0] = % jup_che_pallet_helicopter_loop;
  level.scr_animname["pallet_helicopter"]["pallet_loop"][0] = "jup_che_pallet_helicopter_loop";
  level.scr_animtree["pallet_pallet"] = #animtree;
  level.scr_model["pallet_pallet"] = "jup_urz_construction_pallet_hook_rig";
  level.scr_anim["pallet_pallet"]["pallet_out"] = % jup_che_pallet_pallet_out;
  level.scr_animname["pallet_pallet"]["pallet_out"] = "jup_che_pallet_pallet_out";
  level.scr_anim["pallet_pallet"]["pallet_loop"][0] = % jup_che_pallet_pallet_loop;
  level.scr_animname["pallet_pallet"]["pallet_loop"][0] = "jup_che_pallet_pallet_loop";
  addnotetrack_notify("pallet_pallet", "pallet_141spawn", "pallet_141spawn", "pallet_out");
  addnotetrack_notify("pallet_pallet", "pallet_attack", "pallet_attack", "pallet_out");
  addnotetrack_notify("pallet_pallet", "pallet_land", "pallet_land", "pallet_out");
  addnotetrack_notify("pallet_pallet", "enemy01_fall", "enemy01_fall", "pallet_out");
  addnotetrack_notify("pallet_pallet", "enemy02_fall", "enemy02_fall", "pallet_out");
  addnotetrack_notify("pallet_pallet", "enemy03_fall", "enemy03_fall", "pallet_out");
  addnotetrack_notify("pallet_pallet", "enemy04_fall", "enemy04_fall", "pallet_out");
  addnotetrack_notify("pallet_pallet", "enemy_sync", "enemy_sync", "pallet_out");
  level.scr_animtree["reactor_rope"] = #animtree;
  level.scr_model["reactor_rope"] = "jup_chem_rope";
  level.scr_anim["reactor_rope"]["drop"] = % jup_che_exfil_part1_rope_drop_01;
}