/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_79246b6319aaf0dd.gsc
*************************************************/

#using scripts\common\anim;
#using scripts\engine\utility;
#namespace namespace_aa51f46c4e9f6395;

function main() {
  anim_precache();
  player();
  humans();
  vehicle();
}

function anim_precache() {
  precachemodel("veh9_mil_air_heli_palfa");
}

#using_animtree("player");

function player() {
  var_7907568326d674ab = "player_rig";
  level.scr_animtree[var_7907568326d674ab] = #animtree;
  level.scr_model[var_7907568326d674ab] = "vm_c_jup_sp_hero_ghost_urban";
  level.scr_anim[var_7907568326d674ab]["infil"] = % jup_dam_infil_vm;
}

#using_animtree("generic_human");

function humans() {
  thirdpersonplayer = "3rd_person_player";
  level.scr_animtree[thirdpersonplayer] = #animtree;
  level.scr_model[thirdpersonplayer] = "body_c_jup_sp_hero_ghost_urban";
  level.scr_anim[thirdpersonplayer]["infil"] = % jup_dam_infil_player;
  addnotetrack_notify(thirdpersonplayer, "lgt_sss_lerp", "lgt_sss_lerp", "infil");
  executioner_0 = "executioner_0";
  level.scr_animtree[executioner_0] = #animtree;
  level.scr_anim[executioner_0]["EXECUTION_ANIMATION"] = % wnd_0120_awk_roundup_execute_enemy4_jup;
  executioner_1 = "executioner_1";
  level.scr_animtree[executioner_1] = #animtree;
  level.scr_anim[executioner_1]["EXECUTION_ANIMATION"] = % wnd_0120_awk_roundup_execute_enemy6_jup;
  executioner_2 = "executioner_2";
  level.scr_animtree[executioner_2] = #animtree;
  level.scr_anim[executioner_2]["EXECUTION_ANIMATION"] = % wnd_0120_awk_roundup_execute_enemy7_jup;
  execution_victim_0 = "execution_victim_0";
  level.scr_animtree[execution_victim_0] = #animtree;
  level.scr_anim[execution_victim_0]["EXECUTION_ANIMATION"] = % wnd_0120_awk_roundup_execute_victim1_jup;
  execution_victim_1 = "execution_victim_1";
  level.scr_animtree[execution_victim_1] = #animtree;
  level.scr_anim[execution_victim_1]["EXECUTION_ANIMATION"] = % wnd_0120_awk_roundup_execute_victim2_jup;
  execution_victim_2 = "execution_victim_2";
  level.scr_animtree[execution_victim_2] = #animtree;
  level.scr_anim[execution_victim_2]["EXECUTION_ANIMATION"] = % wnd_0120_awk_roundup_execute_victim5_jup;
  executioner_0 = "executioner_0";
  level.scr_animtree[executioner_0] = #animtree;
  level.scr_anim[executioner_0]["EXECUTION_POST_IDLE_ANIMATION"][0] = % wnd_0120_awk_roundup_execute_idle_enemy4_jup;
  executioner_1 = "executioner_1";
  level.scr_animtree[executioner_1] = #animtree;
  level.scr_anim[executioner_1]["EXECUTION_POST_IDLE_ANIMATION"][0] = % wnd_0120_awk_roundup_execute_idle_enemy6_jup;
  executioner_2 = "executioner_2";
  level.scr_animtree[executioner_2] = #animtree;
  level.scr_anim[executioner_2]["EXECUTION_POST_IDLE_ANIMATION"][0] = % wnd_0120_awk_roundup_execute_idle_enemy7_jup;
}

#using_animtree("vehicles");

function vehicle() {
  level.scr_animtree["heli"] = #animtree;
  level.scr_model["heli"] = "veh9_mil_air_heli_palfa_doors_open_mtx_vehphys_mp";
  level.scr_anim["heli"]["exfil_enter"] = % jup_dam_exfil_helicopter_enter_01;
  level.scr_anim["heli"]["exfil_loop"][0] = % jup_dam_exfil_helicopter_loop_01;
  level.scr_anim["heli"]["exfil_exit"] = % jup_dam_exfil_helicopter_exit_01;
}

function mp_vehicles() {}