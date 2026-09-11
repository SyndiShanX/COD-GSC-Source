/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_ai_spawn_anim_skits.gsc
*************************************************/

function init_spawn_anim_skits() {
  ai_door_spawn_anims();
  door_script_model_anims();
  grenade_model_anims();
}

#using_animtree("");

function ai_door_spawn_anims() {
  level.scr_animtree["ai_spawn_door_soldier"] = #animtree;
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_smoke_A"] = $sdr_com_inter_rdoor_smoke_a;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_smoke_A"] = "sdr_com_inter_rdoor_smoke_A";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_flash_A"] = % sdr_com_inter_rdoor_flash_a;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_flash_A"] = "sdr_com_inter_rdoor_flash_A";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_smoke_A"] = % sdr_com_inter_ldoor_smoke_a;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_smoke_A"] = "sdr_com_inter_ldoor_smoke_A";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_flash_A"] = % sdr_com_inter_ldoor_flash_a;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_flash_A"] = "sdr_com_inter_ldoor_flash_A";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_shoulder_ex_run_C"] = % sdr_com_inter_rdoor_wall_shoulder_ex_run_c;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_shoulder_ex_run_C"] = "sdr_com_inter_rdoor_wall_shoulder_ex_run_C";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_shoulder_ex_run_B"] = % sdr_com_inter_rdoor_wall_shoulder_ex_run_b;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_shoulder_ex_run_B"] = "sdr_com_inter_rdoor_wall_shoulder_ex_run_B";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_shoulder_ex_run_A"] = % sdr_com_inter_rdoor_wall_shoulder_ex_run_a;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_shoulder_ex_run_A"] = "sdr_com_inter_rdoor_wall_shoulder_ex_run_A";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_shoulder_ex_run_C"] = % sdr_com_inter_ldoor_shoulder_ex_run_c;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_shoulder_ex_run_C"] = "sdr_com_inter_ldoor_shoulder_ex_run_C";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_shoulder_ex_run_B"] = % sdr_com_inter_ldoor_shoulder_ex_run_b;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_shoulder_ex_run_B"] = "sdr_com_inter_ldoor_shoulder_ex_run_B";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_shoulder_ex_run_A"] = % sdr_com_inter_ldoor_shoulder_ex_run_a;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_shoulder_ex_run_A"] = "sdr_com_inter_ldoor_shoulder_ex_run_A";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_shoulder_ex_run_C"] = % sdr_com_inter_ldoor_wall_shoulder_ex_run_c;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_shoulder_ex_run_C"] = "sdr_com_inter_ldoor_wall_shoulder_ex_run_C";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_shoulder_ex_run_B"] = % sdr_com_inter_ldoor_wall_shoulder_ex_run_b;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_shoulder_ex_run_B"] = "sdr_com_inter_ldoor_wall_shoulder_ex_run_B";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_shoulder_ex_run_A"] = % sdr_com_inter_ldoor_wall_shoulder_ex_run_a;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_shoulder_ex_run_A"] = "sdr_com_inter_ldoor_wall_shoulder_ex_run_A";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_tac_ex_cqb_C"] = % sdr_com_inter_rdoor_tac_ex_cqb_c;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_tac_ex_cqb_C"] = "sdr_com_inter_rdoor_tac_ex_cqb_C";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_tac_ex_cqb_B"] = % sdr_com_inter_rdoor_tac_ex_cqb_b;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_tac_ex_cqb_B"] = "sdr_com_inter_rdoor_tac_ex_cqb_B";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_tac_ex_cqb_A"] = % sdr_com_inter_rdoor_tac_ex_cqb_a;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_tac_ex_cqb_A"] = "sdr_com_inter_rdoor_tac_ex_cqb_A";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_tac_ex_cqb_C"] = % sdr_com_inter_rdoor_wall_tac_ex_cqb_c;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_tac_ex_cqb_C"] = "sdr_com_inter_rdoor_wall_tac_ex_cqb_C";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_tac_ex_cqb_B"] = % sdr_com_inter_rdoor_wall_tac_ex_cqb_b;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_tac_ex_cqb_B"] = "sdr_com_inter_rdoor_wall_tac_ex_cqb_B";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_tac_ex_cqb_A"] = % sdr_com_inter_rdoor_wall_tac_ex_cqb_a;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_tac_ex_cqb_A"] = "sdr_com_inter_rdoor_wall_tac_ex_cqb_A";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_tac_ex_cqb_C"] = % sdr_com_inter_ldoor_tac_ex_cqb_c;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_tac_ex_cqb_C"] = "sdr_com_inter_ldoor_tac_ex_cqb_C";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_tac_ex_cqb_B"] = % sdr_com_inter_ldoor_tac_ex_cqb_b;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_tac_ex_cqb_B"] = "sdr_com_inter_ldoor_tac_ex_cqb_B";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_tac_ex_cqb_A"] = % sdr_com_inter_ldoor_tac_ex_cqb_a;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_tac_ex_cqb_A"] = "sdr_com_inter_ldoor_tac_ex_cqb_A";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_tac_ex_cqb_C"] = % sdr_com_inter_ldoor_wall_tac_ex_cqb_c;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_tac_ex_cqb_C"] = "sdr_com_inter_ldoor_wall_tac_ex_cqb_C";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_tac_ex_cqb_B"] = % sdr_com_inter_ldoor_wall_tac_ex_cqb_b;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_tac_ex_cqb_B"] = "sdr_com_inter_ldoor_wall_tac_ex_cqb_B";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_tac_ex_cqb_A"] = % sdr_com_inter_ldoor_wall_tac_ex_cqb_a;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_tac_ex_cqb_A"] = "sdr_com_inter_ldoor_wall_tac_ex_cqb_A";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_kick_ex_cqb_C"] = % sdr_com_inter_rdoor_wall_kick_ex_cqb_c;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_kick_ex_cqb_C"] = "sdr_com_inter_rdoor_wall_kick_ex_cqb_C";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_kick_ex_cqb_B"] = % sdr_com_inter_rdoor_wall_kick_ex_cqb_b;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_kick_ex_cqb_B"] = "sdr_com_inter_rdoor_wall_kick_ex_cqb_B";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_kick_ex_cqb_A"] = % sdr_com_inter_rdoor_wall_kick_ex_cqb_a;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_kick_ex_cqb_A"] = "sdr_com_inter_rdoor_wall_kick_ex_cqb_A";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_kick_ex_run_C"] = % sdr_com_inter_rdoor_wall_kick_ex_run_c;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_kick_ex_run_C"] = "sdr_com_inter_rdoor_wall_kick_ex_run_C";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_kick_ex_run_B"] = % sdr_com_inter_rdoor_wall_kick_ex_run_b;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_kick_ex_run_B"] = "sdr_com_inter_rdoor_wall_kick_ex_run_B";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_kick_ex_run_A"] = % sdr_com_inter_rdoor_wall_kick_ex_run_a;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_wall_kick_ex_run_A"] = "sdr_com_inter_rdoor_wall_kick_ex_run_A";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_kick_ex_cqb_C"] = % sdr_com_inter_ldoor_wall_kick_ex_cqb_c;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_kick_ex_cqb_C"] = "sdr_com_inter_ldoor_wall_kick_ex_cqb_C";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_kick_ex_cqb_B"] = % sdr_com_inter_ldoor_wall_kick_ex_cqb_b;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_kick_ex_cqb_B"] = "sdr_com_inter_ldoor_wall_kick_ex_cqb_B";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_kick_ex_cqb_A"] = % sdr_com_inter_ldoor_wall_kick_ex_cqb_a;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_kick_ex_cqb_A"] = "sdr_com_inter_ldoor_wall_kick_ex_cqb_A";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_kick_ex_run_C"] = % sdr_com_inter_ldoor_wall_kick_ex_run_c;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_kick_ex_run_C"] = "sdr_com_inter_ldoor_wall_kick_ex_run_C";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_kick_ex_run_B"] = % sdr_com_inter_ldoor_wall_kick_ex_run_b;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_kick_ex_run_B"] = "sdr_com_inter_ldoor_wall_kick_ex_run_B";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_kick_ex_run_A"] = % sdr_com_inter_ldoor_wall_kick_ex_run_a;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_wall_kick_ex_run_A"] = "sdr_com_inter_ldoor_wall_kick_ex_run_A";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_dbldoor_kick_ex_cqb_C"] = % sdr_com_inter_dbldoor_kick_ex_cqb_c;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_dbldoor_kick_ex_cqb_C"] = "sdr_com_inter_dbldoor_kick_ex_cqb_C";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_dbldoor_kick_ex_cqb_B"] = % sdr_com_inter_dbldoor_kick_ex_cqb_b;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_dbldoor_kick_ex_cqb_B"] = "sdr_com_inter_dbldoor_kick_ex_cqb_B";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_dbldoor_kick_ex_cqb_A"] = % sdr_com_inter_dbldoor_kick_ex_cqb_a;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_dbldoor_kick_ex_cqb_A"] = "sdr_com_inter_dbldoor_kick_ex_cqb_A";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_dbldoor_kick_ex_run_C"] = % sdr_com_inter_dbldoor_kick_ex_run_c;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_dbldoor_kick_ex_run_C"] = "sdr_com_inter_dbldoor_kick_ex_run_C";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_dbldoor_kick_ex_run_B"] = % sdr_com_inter_dbldoor_kick_ex_run_b;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_dbldoor_kick_ex_run_B"] = "sdr_com_inter_dbldoor_kick_ex_run_B";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_dbldoor_kick_ex_run_A"] = % sdr_com_inter_dbldoor_kick_ex_run_a;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_dbldoor_kick_ex_run_A"] = "sdr_com_inter_dbldoor_kick_ex_run_A";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_kick_ex_cqb_C"] = % sdr_com_inter_ldoor_kick_ex_cqb_c;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_kick_ex_cqb_C"] = "sdr_com_inter_ldoor_kick_ex_cqb_C";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_kick_ex_cqb_B"] = % sdr_com_inter_ldoor_kick_ex_cqb_b;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_kick_ex_cqb_B"] = "sdr_com_inter_ldoor_kick_ex_cqb_B";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_kick_ex_cqb_A"] = % sdr_com_inter_ldoor_kick_ex_cqb_a;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_kick_ex_cqb_A"] = "sdr_com_inter_ldoor_kick_ex_cqb_A";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_kick_ex_run_C"] = % sdr_com_inter_ldoor_kick_ex_run_c;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_kick_ex_run_C"] = "sdr_com_inter_ldoor_kick_ex_run_C";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_kick_ex_run_B"] = % sdr_com_inter_ldoor_kick_ex_run_b;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_kick_ex_run_B"] = "sdr_com_inter_ldoor_kick_ex_run_B";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_kick_ex_run_A_alt"] = % sdr_com_inter_ldoor_kick_ex_run_a_alt;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_kick_ex_run_A_alt"] = "sdr_com_inter_ldoor_kick_ex_run_A_alt";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_kick_ex_run_A"] = % sdr_com_inter_ldoor_kick_ex_run_a;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_kick_ex_run_A"] = "sdr_com_inter_ldoor_kick_ex_run_A";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_90_pull_ex_idle_A"] = % sdr_com_inter_ldoor_90_pull_ex_idle_a;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_90_pull_ex_idle_A"] = "sdr_com_inter_ldoor_90_pull_ex_idle_A";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_90_pull_ex_idle_B"] = % sdr_com_inter_ldoor_90_pull_ex_idle_b;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_90_pull_ex_idle_B"] = "sdr_com_inter_ldoor_90_pull_ex_idle_B";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_90_pull_ex_idle_C"] = % sdr_com_inter_ldoor_90_pull_ex_idle_c;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_ldoor_90_pull_ex_idle_C"] = "sdr_com_inter_ldoor_90_pull_ex_idle_C";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_90_pull_ex_idle_A"] = % sdr_com_inter_rdoor_90_pull_ex_idle_a;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_90_pull_ex_idle_A"] = "sdr_com_inter_rdoor_90_pull_ex_idle_A";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_90_pull_ex_idle_B"] = % sdr_com_inter_rdoor_90_pull_ex_idle_b;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_90_pull_ex_idle_B"] = "sdr_com_inter_rdoor_90_pull_ex_idle_B";
  level.scr_anim["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_90_pull_ex_idle_C"] = % sdr_com_inter_rdoor_90_pull_ex_idle_c;
  level.scr_animname["ai_spawn_door_soldier"]["sdr_com_inter_rdoor_90_pull_ex_idle_C"] = "sdr_com_inter_rdoor_90_pull_ex_idle_C";
}

function door_script_model_anims() {
  level.scr_animtree["ai_spawn_door"] = #animtree;
  level.scr_anim["ai_spawn_door"]["sdr_com_inter_rdoor_smoke_door"] = $sdr_com_inter_rdoor_smoke_door;
  level.scr_animname["ai_spawn_door"]["sdr_com_inter_rdoor_smoke_door"] = "sdr_com_inter_rdoor_smoke_door";
  level.scr_anim["ai_spawn_door"]["sdr_com_inter_rdoor_flash_door"] = % sdr_com_inter_rdoor_flash_door;
  level.scr_animname["ai_spawn_door"]["sdr_com_inter_rdoor_flash_door"] = "sdr_com_inter_rdoor_flash_door";
  level.scr_anim["ai_spawn_door"]["sdr_com_inter_ldoor_flash_door"] = % sdr_com_inter_ldoor_flash_door;
  level.scr_animname["ai_spawn_door"]["sdr_com_inter_ldoor_flash_door"] = "sdr_com_inter_ldoor_flash_door";
  level.scr_anim["ai_spawn_door"]["sdr_com_inter_ldoor_smoke_door"] = % sdr_com_inter_ldoor_smoke_door;
  level.scr_animname["ai_spawn_door"]["sdr_com_inter_ldoor_smoke_door"] = "sdr_com_inter_ldoor_smoke_door";
  level.scr_anim["ai_spawn_door"]["sdr_com_inter_rdoor_tac_ex_cqb_door"] = % sdr_com_inter_rdoor_tac_ex_cqb_door;
  level.scr_animname["ai_spawn_door"]["sdr_com_inter_rdoor_tac_ex_cqb_door"] = "sdr_com_inter_rdoor_tac_ex_cqb_door";
  level.scr_anim["ai_spawn_door"]["sdr_com_inter_ldoor_tac_ex_cqb_door"] = % sdr_com_inter_ldoor_tac_ex_cqb_door;
  level.scr_animname["ai_spawn_door"]["sdr_com_inter_ldoor_tac_ex_cqb_door"] = "sdr_com_inter_ldoor_tac_ex_cqb_door";
  level.scr_anim["ai_spawn_door"]["sdr_com_inter_ldoor_shoulder_ex_run_door"] = % sdr_com_inter_ldoor_shoulder_ex_run_door;
  level.scr_animname["ai_spawn_door"]["sdr_com_inter_ldoor_shoulder_ex_run_door"] = "sdr_com_inter_ldoor_shoulder_ex_run_door";
  level.scr_anim["ai_spawn_door"]["sdr_com_inter_rdoor_wall_shoulder_ex_run_door"] = % sdr_com_inter_rdoor_wall_shoulder_ex_run_door;
  level.scr_animname["ai_spawn_door"]["sdr_com_inter_rdoor_wall_shoulder_ex_run_door"] = "sdr_com_inter_rdoor_wall_shoulder_ex_run_door";
  level.scr_anim["ai_spawn_door"]["sdr_com_inter_ldoor_wall_shoulder_ex_run_door"] = % sdr_com_inter_ldoor_wall_shoulder_ex_run_door;
  level.scr_animname["ai_spawn_door"]["sdr_com_inter_ldoor_wall_shoulder_ex_run_door"] = "sdr_com_inter_ldoor_wall_shoulder_ex_run_door";
  level.scr_anim["ai_spawn_door"]["sdr_com_inter_rdoor_wall_tac_ex_cqb_door"] = % sdr_com_inter_rdoor_wall_tac_ex_cqb_door;
  level.scr_animname["ai_spawn_door"]["sdr_com_inter_rdoor_wall_tac_ex_cqb_door"] = "sdr_com_inter_rdoor_wall_tac_ex_cqb_door";
  level.scr_anim["ai_spawn_door"]["sdr_com_inter_ldoor_wall_tac_ex_cqb_door"] = % sdr_com_inter_ldoor_wall_tac_ex_cqb_door;
  level.scr_animname["ai_spawn_door"]["sdr_com_inter_ldoor_wall_tac_ex_cqb_door"] = "sdr_com_inter_ldoor_wall_tac_ex_cqb_door";
  level.scr_anim["ai_spawn_door"]["sdr_com_inter_rdoor_wall_kick_ex_cqb_door"] = % sdr_com_inter_rdoor_wall_kick_ex_cqb_door;
  level.scr_animname["ai_spawn_door"]["sdr_com_inter_rdoor_wall_kick_ex_cqb_door"] = "sdr_com_inter_rdoor_wall_kick_ex_cqb_door";
  level.scr_anim["ai_spawn_door"]["sdr_com_inter_rdoor_wall_kick_ex_run_door"] = % sdr_com_inter_rdoor_wall_kick_ex_run_door;
  level.scr_animname["ai_spawn_door"]["sdr_com_inter_rdoor_wall_kick_ex_run_door"] = "sdr_com_inter_rdoor_wall_kick_ex_run_door";
  level.scr_anim["ai_spawn_door"]["sdr_com_inter_ldoor_wall_kick_ex_cqb_door"] = % sdr_com_inter_ldoor_wall_kick_ex_cqb_door;
  level.scr_animname["ai_spawn_door"]["sdr_com_inter_ldoor_wall_kick_ex_cqb_door"] = "sdr_com_inter_ldoor_wall_kick_ex_cqb_door";
  level.scr_anim["ai_spawn_door"]["sdr_com_inter_ldoor_wall_kick_ex_run_door"] = % sdr_com_inter_ldoor_wall_kick_ex_run_door;
  level.scr_animname["ai_spawn_door"]["sdr_com_inter_ldoor_wall_kick_ex_run_door"] = "sdr_com_inter_ldoor_wall_kick_ex_run_door";
  level.scr_anim["ai_spawn_door"]["sdr_com_inter_dbldoor_kick_ex_cqb_doorr"] = % sdr_com_inter_dbldoor_kick_ex_cqb_doorr;
  level.scr_animname["ai_spawn_door"]["sdr_com_inter_dbldoor_kick_ex_cqb_doorr"] = "sdr_com_inter_dbldoor_kick_ex_cqb_doorr";
  level.scr_anim["ai_spawn_door"]["sdr_com_inter_dbldoor_kick_ex_cqb_doorl"] = % sdr_com_inter_dbldoor_kick_ex_cqb_doorl;
  level.scr_animname["ai_spawn_door"]["sdr_com_inter_dbldoor_kick_ex_cqb_doorl"] = "sdr_com_inter_dbldoor_kick_ex_cqb_doorl";
  level.scr_anim["ai_spawn_door"]["sdr_com_inter_dbldoor_kick_ex_run_doorr"] = % sdr_com_inter_dbldoor_kick_ex_run_doorr;
  level.scr_animname["ai_spawn_door"]["sdr_com_inter_dbldoor_kick_ex_run_doorr"] = "sdr_com_inter_dbldoor_kick_ex_run_doorr";
  level.scr_anim["ai_spawn_door"]["sdr_com_inter_dbldoor_kick_ex_run_doorl"] = % sdr_com_inter_dbldoor_kick_ex_run_doorl;
  level.scr_animname["ai_spawn_door"]["sdr_com_inter_dbldoor_kick_ex_run_doorl"] = "sdr_com_inter_dbldoor_kick_ex_run_doorl";
  level.scr_anim["ai_spawn_door"]["sdr_com_inter_ldoor_kick_ex_cqb_door"] = % sdr_com_inter_ldoor_kick_ex_cqb_door;
  level.scr_animname["ai_spawn_door"]["sdr_com_inter_ldoor_kick_ex_cqb_door"] = "sdr_com_inter_ldoor_kick_ex_cqb_door";
  level.scr_anim["ai_spawn_door"]["sdr_com_inter_ldoor_kick_ex_run_door"] = % sdr_com_inter_ldoor_kick_ex_run_door;
  level.scr_animname["ai_spawn_door"]["sdr_com_inter_ldoor_kick_ex_run_door"] = "sdr_com_inter_ldoor_kick_ex_run_door";
  level.scr_anim["ai_spawn_door"]["sdr_com_inter_ldoor_90_pull_ex_idle_door"] = % sdr_com_inter_ldoor_90_pull_ex_idle_door;
  level.scr_animname["ai_spawn_door"]["sdr_com_inter_ldoor_90_pull_ex_idle_door"] = "sdr_com_inter_ldoor_90_pull_ex_idle_door";
  level.scr_anim["ai_spawn_door"]["sdr_com_inter_rdoor_90_pull_ex_idle_door"] = % sdr_com_inter_rdoor_90_pull_ex_idle_door;
  level.scr_animname["ai_spawn_door"]["sdr_com_inter_rdoor_90_pull_ex_idle_door"] = "sdr_com_inter_rdoor_90_pull_ex_idle_door";
}

function grenade_model_anims() {
  level.scr_animtree["ai_spawn_door_grenade"] = #animtree;
  level.scr_anim["ai_spawn_door_grenade"]["sdr_com_inter_rdoor_flash_grenade"] = % sdr_com_inter_rdoor_flash_grenade;
  level.scr_animname["ai_spawn_door_grenade"]["sdr_com_inter_rdoor_flash_grenade"] = "sdr_com_inter_rdoor_flash_grenade";
  level.scr_anim["ai_spawn_door_grenade"]["sdr_com_inter_rdoor_flash_grenade"] = % sdr_com_inter_ldoor_flash_grenade;
  level.scr_animname["ai_spawn_door_grenade"]["sdr_com_inter_rdoor_flash_grenade"] = "sdr_com_inter_ldoor_flash_grenade";
  level.scr_anim["ai_spawn_door_grenade"]["sdr_com_inter_ldoor_smoke_grenade"] = % sdr_com_inter_ldoor_smoke_grenade;
  level.scr_animname["ai_spawn_door_grenade"]["sdr_com_inter_ldoor_smoke_grenade"] = "sdr_com_inter_ldoor_smoke_grenade";
  level.scr_anim["ai_spawn_door_grenade"]["sdr_com_inter_ldoor_smoke_grenade"] = % sdr_com_inter_rdoor_smoke_grenade;
  level.scr_animname["ai_spawn_door_grenade"]["sdr_com_inter_ldoor_smoke_grenade"] = "sdr_com_inter_rdoor_smoke_grenade";
}

function should_use_door_spawn_anim(var0) {
  if(istrue(var0.use_spawn_anim)) {
    return 1;
  }

  if(isDefined(var0.script_linkto)) {
    var0.use_spawn_anim = 1;
    return 1;
  }

  return 0;
}

function is_double_door(var0) {
  if(!isDefined(var0)) {
    return false;
  }

  if(isDefined(var0.script_linkto)) {
    var1 = scripts\engine\utility::getStructArray(var0.script_linkto, "script_linkname");

    if(var1.size < 1) {
      var1 = getEntArray(var0.script_linkto, "script_linkname");
    }

    return (var1.size >= 2);
  }

  return false;
}

function is_left_door(var0, var1) {
  return var0 scripts\engine\math::is_point_on_right(var1);
}

function is_right_door(var0, var1) {
  return !var0 scripts\engine\math::is_point_on_right(var1);
}

function get_double_door_mid_point(var0) {
  if(isDefined(var0.script_linkto)) {
    var1 = scripts\engine\utility::getStructArray(var0.script_linkto, "script_linkname");

    if(var1.size < 1) {
      var1 = getEntArray(var0.script_linkto, "script_linkname");
    }

    if(var1.size >= 2) {
      return scripts\engine\math::get_mid_point(var1[0].origin, var1[1].origin);
    }

    return;
  }

  return undefined;
}

function get_spawn_anim(var0, var1, var2) {
  var3 = level.spawn_door_anims;

  if(is_double_door(var1)) {
    var3 = level.spawn_dbldoor_anims;
  } else if(isDefined(var0) && is_left_door(var0, var1.origin)) {
    var3 = level.spawn_ldoor_anims;
  } else if(isDefined(var0) && is_right_door(var0, var1.origin)) {
    var3 = level.spawn_rdoor_anims;
  }

  return scripts\engine\utility::random(var3);
}