/**********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\asm\pamgrier\mp\states.gsc
**********************************************/

func_2371() {
  if(scripts\asm\asm::func_232E("pamgrier")) {
    return;
  }

  scripts\asm\asm::func_230B("pamgrier", "pamgrier_start");
  scripts\asm\asm::func_2374("pamgrier_start", ::scripts\asm\pamgrier\pamgrier_asm::pamgrierinit, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("entrance", undefined, ::scripts\asm\pamgrier\pamgrier_asm::shouldplayentranceanim, undefined);
  scripts\asm\asm::func_2375("decide_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("idle", ::lib_0F3C::func_B050, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("check_move", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("idle_turn", undefined, ::scripts\asm\pamgrier\pamgrier_asm::func_BEA0, undefined);
  scripts\asm\asm::func_2375("check_actions", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("chill_idle", undefined, ::scripts\asm\pamgrier\pamgrier_asm::ispamchillin, undefined);
  scripts\asm\asm::func_2374("entrance", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("decide_idle", undefined, ::scripts\asm\pamgrier\pamgrier_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("check_actions", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("revive_player", undefined, ::scripts\asm\pamgrier\pamgrier_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("melee_attack", undefined, ::scripts\asm\pamgrier\pamgrier_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("teleport", undefined, ::scripts\asm\pamgrier\pamgrier_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2374("melee_attack", ::scripts\asm\pamgrier\pamgrier_asm::playmeleeattack, undefined, ::scripts\asm\pamgrier\pamgrier_asm::meleenotehandler, undefined, undefined, ::scripts\asm\pamgrier\pamgrier_asm::choosemeleeattack, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\pamgrier\pamgrier_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("action_done", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("decide_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("death_generic", ::lib_0C71::func_CF0E, undefined, undefined, undefined, undefined, ::lib_0C71::func_3F00, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2374("death_moving", ::lib_0C71::func_CF0E, undefined, undefined, undefined, undefined, ::lib_0C71::func_3EE2, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2374("check_move", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("check_idle_exit", undefined, ::trans_check_move_to_check_idle_exit0, undefined);
  scripts\asm\asm::func_2374("idle_exit_walk", ::scripts\asm\zombie\zombie::func_CEB7, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pass_walk_in", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("pass_walk_in", undefined, ::scripts\asm\asm::func_68B0, "finish");
  scripts\asm\asm::func_2375("check_interruptables", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pass_walk_in", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("pass_walk_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("walk_loop", undefined, ::trans_pass_walk_in_to_walk_loop1, undefined);
  scripts\asm\asm::func_2374("walk_turn", ::lib_0F3B::func_D514, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3EF5, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("check_interruptables", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("pass_walk_in", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("pass_walk_in", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("walk_loop", ::scripts\asm\zombie\zombie::func_D4E3, "walk", undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EE1, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pass_walk_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pass_walk_out", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::trans_pass_walk_out_to_choose_movetype0, undefined);
  scripts\asm\asm::func_2375("check_actions", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("walk_stop", undefined, ::scripts\asm\zombie\zombie::func_10092, undefined);
  scripts\asm\asm::func_2375("walk_turn", undefined, ::lib_0F3B::func_FFF8, "walk_turn");
  scripts\asm\asm::func_2375("move_done", undefined, ::trans_pass_walk_out_to_move_done4, undefined);
  scripts\asm\asm::func_2374("walk_stop", ::scripts\asm\zombie\zombie::func_CEAE, undefined, undefined, undefined, undefined, ::lib_0F3A::func_3E97, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("check_interruptables", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("pass_walk_in", undefined, ::scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2375("move_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("move_done", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("decide_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("choose_movetype", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("pass_walk_in", undefined, ::trans_choose_movetype_to_pass_walk_in0, undefined);
  scripts\asm\asm::func_2375("pass_run_in", undefined, ::trans_choose_movetype_to_pass_run_in1, undefined);
  scripts\asm\asm::func_2375("pass_sprint_in", undefined, ::trans_choose_movetype_to_pass_sprint_in2, undefined);
  scripts\asm\asm::func_2374("idle_exit_sprint", ::scripts\asm\zombie\zombie::func_CEB7, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("idle_exit_run", ::scripts\asm\zombie\zombie::func_CEB7, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pass_run_in", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("pass_run_in", undefined, ::scripts\asm\asm::func_68B0, "finish");
  scripts\asm\asm::func_2374("check_idle_exit", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("idle_exit_walk", undefined, ::trans_check_idle_exit_to_idle_exit_walk0, undefined);
  scripts\asm\asm::func_2375("idle_exit_run", undefined, ::trans_check_idle_exit_to_idle_exit_run1, undefined);
  scripts\asm\asm::func_2375("idle_exit_sprint", undefined, ::trans_check_idle_exit_to_idle_exit_sprint2, undefined);
  scripts\asm\asm::func_2374("pass_run_in", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("pass_run_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("run_loop", undefined, ::trans_pass_run_in_to_run_loop1, undefined);
  scripts\asm\asm::func_2374("run_turn", ::lib_0F3B::func_D514, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3EF5, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pass_run_in", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("pass_run_in", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("run_loop", ::scripts\asm\zombie\zombie::func_D4E3, "walk", undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EE1, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pass_run_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("run_stop", ::scripts\asm\zombie\zombie::func_CEAE, undefined, undefined, undefined, undefined, ::lib_0F3A::func_3E97, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pass_run_in", undefined, ::scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2374("pass_run_out", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::trans_pass_run_out_to_choose_movetype0, undefined);
  scripts\asm\asm::func_2375("run_stop", undefined, ::scripts\asm\zombie\zombie::func_10092, undefined);
  scripts\asm\asm::func_2375("run_turn", undefined, ::lib_0F3B::func_FFF8, "run_turn");
  scripts\asm\asm::func_2375("move_done", undefined, ::trans_pass_run_out_to_move_done3, undefined);
  scripts\asm\asm::func_2374("pass_sprint_in", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("pass_sprint_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("sprint_loop", undefined, ::trans_pass_sprint_in_to_sprint_loop1, undefined);
  scripts\asm\asm::func_2374("sprint_loop", ::scripts\asm\zombie\zombie::func_D4E3, "walk", undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EE1, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pass_sprint_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("sprint_stop", ::scripts\asm\zombie\zombie::func_CEAE, undefined, undefined, undefined, undefined, ::lib_0F3A::func_3E97, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pass_sprint_in", undefined, ::scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2374("pass_sprint_out", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::trans_pass_sprint_out_to_choose_movetype0, undefined);
  scripts\asm\asm::func_2375("sprint_stop", undefined, ::scripts\asm\zombie\zombie::func_10092, undefined);
  scripts\asm\asm::func_2375("sprint_turn", undefined, ::lib_0F3B::func_FFF8, "run_turn");
  scripts\asm\asm::func_2375("move_done", undefined, ::trans_pass_sprint_out_to_move_done3, undefined);
  scripts\asm\asm::func_2374("sprint_turn", ::lib_0F3B::func_D514, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3EF5, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pass_sprint_in", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("pass_sprint_in", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("pain_generic", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::scripts\asm\pamgrier\pamgrier_asm::func_3EE4, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("idle", undefined, ::scripts\asm\pamgrier\pamgrier_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("pain_moving", ::scripts\asm\pamgrier\pamgrier_asm::playmovingpainanim, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("walk_loop", undefined, ::scripts\asm\pamgrier\pamgrier_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("decide_idle", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("chill_idle", undefined, ::scripts\asm\pamgrier\pamgrier_asm::ispamchillin, undefined);
  scripts\asm\asm::func_2375("idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("check_interruptables", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("melee_attack", undefined, ::scripts\asm\pamgrier\pamgrier_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2374("jump_across_196", ::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_up_128_over_40", ::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_up_128_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_up_56_over_40", ::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_up_56_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_over_30_out_30_down_48", ::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_over_30_out_30_down_48", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("over_40_down_128", ::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "over_40_down_128", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("over_40_down_56", ::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "over_40_down_56", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_up_128_over_40_out_30", ::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_up_128_over_40_out_30", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_across_196_norestart", ::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_up_128_over_40_norestart", ::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_up_128_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_up_56_over_40_norestart", ::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_up_56_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_over_30_out_30_down_48_norestart", ::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_over_30_out_30_down_48", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("over_40_down_128_norestart", ::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "over_40_down_128", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("over_40_down_56_norestart", ::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "over_40_down_56", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_up_128_over_40_out_30_norestart", ::scripts\asm\zombie_dlc2\zombie_dlc2::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_up_128_over_40_out_30", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("traverse_external", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2374("chill_idle", ::scripts\asm\pamgrier\pamgrier_asm::playchillinanim, undefined, undefined, undefined, undefined, ::scripts\asm\pamgrier\pamgrier_asm::choosechillinidle, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("decide_idle", undefined, ::scripts\asm\pamgrier\pamgrier_asm::ispamdonechillin, undefined);
  scripts\asm\asm::func_2375("check_actions", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("chill_passive_transition", undefined, ::scripts\asm\pamgrier\pamgrier_asm::needschilltransition, undefined);
  scripts\asm\asm::func_2375("chill_twitch", undefined, ::scripts\asm\pamgrier\pamgrier_asm::shouldplaychilltwitch, undefined);
  scripts\asm\asm::func_2374("teleport", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("idle_turn", undefined, ::scripts\asm\pamgrier\pamgrier_asm::func_BEA0, undefined);
  scripts\asm\asm::func_2375("teleport_in", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("teleport_in", ::scripts\asm\pamgrier\pamgrier_asm::playteleportin, undefined, undefined, undefined, undefined, ::scripts\asm\pamgrier\pamgrier_asm::chooseteleportinanim, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("teleport_out", undefined, ::scripts\asm\pamgrier\pamgrier_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("teleport_out", ::scripts\asm\pamgrier\pamgrier_asm::playteleportout, undefined, ::scripts\asm\pamgrier\pamgrier_asm::meleenotehandler, undefined, undefined, ::scripts\asm\pamgrier\pamgrier_asm::chooseteleportoutanim, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("teleport_done", undefined, ::scripts\asm\pamgrier\pamgrier_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("revive_player_loop", ::scripts\asm\pamgrier\pamgrier_asm::playreviveanim, undefined, undefined, undefined, undefined, ::scripts\asm\pamgrier\pamgrier_asm::choosereviveanim, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("revive_player_outro", undefined, ::scripts\asm\pamgrier\pamgrier_asm::isrevivedone, undefined);
  scripts\asm\asm::func_2374("teleport_done", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("revive_player_loop", undefined, ::trans_teleport_done_to_revive_player_loop0, undefined);
  scripts\asm\asm::func_2375("chill_idle", undefined, ::scripts\asm\pamgrier\pamgrier_asm::ispamchillin, undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("revive_player", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("revive_player_intro", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("revive_player_intro", ::scripts\asm\pamgrier\pamgrier_asm::playreviveanim, undefined, undefined, undefined, undefined, ::scripts\asm\pamgrier\pamgrier_asm::choosereviveanim, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("revive_player_loop", undefined, ::scripts\asm\pamgrier\pamgrier_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("revive_player_outro", ::scripts\asm\pamgrier\pamgrier_asm::playreviveanim, undefined, undefined, undefined, undefined, ::scripts\asm\pamgrier\pamgrier_asm::choosereviveanim, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\pamgrier\pamgrier_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("idle_turn", ::scripts\asm\pamgrier\pamgrier_asm::func_D56A, undefined, undefined, undefined, undefined, ::scripts\asm\pamgrier\pamgrier_asm::func_3F0A, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("idle_turn_done", undefined, ::scripts\asm\pamgrier\pamgrier_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("idle_turn_done", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("teleport_in", undefined, ::scripts\asm\pamgrier\pamgrier_asm::shoulddoaction, "teleport");
  scripts\asm\asm::func_2374("chill_passive_transition", ::scripts\asm\pamgrier\pamgrier_asm::playchillpassivetransition, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("chill_idle", undefined, ::scripts\asm\pamgrier\pamgrier_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("chill_twitch", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::scripts\asm\pamgrier\pamgrier_asm::choosechillinidle, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("chill_idle", undefined, ::scripts\asm\pamgrier\pamgrier_asm::isanimdone, undefined);
  scripts\asm\asm::func_2375("check_actions", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2327();
}

trans_check_move_to_check_idle_exit0(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

trans_pass_walk_in_to_walk_loop1(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

trans_pass_walk_out_to_choose_movetype0(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_BCCD();
}

trans_pass_walk_out_to_move_done4(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

trans_choose_movetype_to_pass_walk_in0(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("walk");
}

trans_choose_movetype_to_pass_run_in1(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("run");
}

trans_choose_movetype_to_pass_sprint_in2(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("sprint");
}

trans_check_idle_exit_to_idle_exit_walk0(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("walk");
}

trans_check_idle_exit_to_idle_exit_run1(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("run");
}

trans_check_idle_exit_to_idle_exit_sprint2(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("sprint");
}

trans_pass_run_in_to_run_loop1(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

trans_pass_run_out_to_choose_movetype0(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_BCCD();
}

trans_pass_run_out_to_move_done3(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

trans_pass_sprint_in_to_sprint_loop1(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

trans_pass_sprint_out_to_choose_movetype0(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_BCCD();
}

trans_pass_sprint_out_to_move_done3(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

trans_teleport_done_to_revive_player_loop0(var_0, var_1, var_2, var_3) {
  return isDefined(self.teleporttype) && self.teleporttype == "revive_player";
}