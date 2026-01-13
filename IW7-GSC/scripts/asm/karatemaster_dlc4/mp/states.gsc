/*******************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\asm\karatemaster_dlc4\mp\states.gsc
*******************************************************/

func_2371() {
  if(scripts\asm\asm::func_232E("karatemaster_dlc4")) {
    return;
  }

  scripts\asm\asm::func_230B("karatemaster_dlc4", "karatemaster_start");
  scripts\asm\asm::func_2374("karatemaster_start", ::scripts\asm\karatemaster\karatemaster_asm::karatemasterinit, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("entrance", undefined, ::scripts\asm\karatemaster\karatemaster_asm::shouldplayentranceanim, undefined);
  scripts\asm\asm::func_2375("decide_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("idle", ::lib_0F3C::func_B050, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::trans_idle_to_choose_movetype0, undefined);
  scripts\asm\asm::func_2375("check_actions", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("entrance", ::scripts\asm\karatemaster\karatemaster_asm::playspawnin, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("decide_idle", undefined, ::scripts\asm\karatemaster\karatemaster_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("check_actions", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("teleport_in", undefined, ::scripts\asm\karatemaster\karatemaster_asm::teleportrequested, undefined);
  scripts\asm\asm::func_2375("check_melee", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("stand_melee", ::scripts\asm\karatemaster\karatemaster_asm::playanim_melee, undefined, ::scripts\asm\karatemaster\karatemaster_asm::meleenotehandler, ::scripts\asm\karatemaster\karatemaster_asm::terminate_melee, undefined, ::scripts\asm\karatemaster\karatemaster_asm::choosestandmeleeanim, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, "melee_anim", undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\karatemaster\karatemaster_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("action_done", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("decide_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("choose_movetype", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("idle_exit_sprint", undefined, ::trans_choose_movetype_to_idle_exit_sprint0, undefined);
  scripts\asm\asm::func_2375("idle_exit_walk", undefined, ::trans_choose_movetype_to_idle_exit_walk1, undefined);
  scripts\asm\asm::func_2375("idle_exit_run", undefined, ::trans_choose_movetype_to_idle_exit_run2, undefined);
  scripts\asm\asm::func_2375("idle_exit_slow_walk", undefined, ::trans_choose_movetype_to_idle_exit_slow_walk3, undefined);
  scripts\asm\asm::func_2374("idle_exit_walk", ::scripts\asm\zombie\zombie::func_CEB7, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pass_walk_in", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("pass_walk_in", undefined, ::scripts\asm\asm::func_68B0, "finish");
  scripts\asm\asm::func_2374("pass_walk_in", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("pass_walk_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("walk_loop", undefined, ::trans_pass_walk_in_to_walk_loop1, undefined);
  scripts\asm\asm::func_2374("walk_turn", ::lib_0F3B::func_D514, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3EF5, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pass_walk_in", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("pass_walk_in", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("walk_loop", ::scripts\asm\zombie\zombie::func_D4E3, "walk", undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EE1, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pass_walk_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pass_walk_out", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("check_actions", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("check_melee", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("walk_stop", undefined, ::scripts\asm\zombie\zombie::func_10092, undefined);
  scripts\asm\asm::func_2375("walk_turn", undefined, ::lib_0F3B::func_FFF8, "walk_turn");
  scripts\asm\asm::func_2375("move_done", undefined, ::trans_pass_walk_out_to_move_done4, undefined);
  scripts\asm\asm::func_2374("walk_stop", ::scripts\asm\zombie\zombie::func_CEAE, undefined, undefined, undefined, undefined, ::lib_0F3A::func_3E97, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pass_walk_in", undefined, ::scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2375("move_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("move_done", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("decide_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("run_turn", ::lib_0F3B::func_D514, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3EF5, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pass_run_in", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("pass_run_in", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("run_loop", ::scripts\asm\zombie\zombie::func_D4E3, "run", undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EE1, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pass_run_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("run_stop", ::scripts\asm\zombie\zombie::func_CEAE, undefined, undefined, undefined, undefined, ::lib_0F3A::func_3E97, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("move_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("pass_run_in", undefined, ::scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2374("idle_exit_run", ::scripts\asm\zombie\zombie::func_CEB7, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pass_run_in", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("pass_run_in", undefined, ::scripts\asm\asm::func_68B0, "finished");
  scripts\asm\asm::func_2374("pass_run_in", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("pass_run_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("run_loop", undefined, ::trans_pass_run_in_to_run_loop1, undefined);
  scripts\asm\asm::func_2374("pass_run_out", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("run_turn", undefined, ::lib_0F3B::func_FFF8, "run_turn");
  scripts\asm\asm::func_2375("run_stop", undefined, ::scripts\asm\zombie\zombie::func_10092, undefined);
  scripts\asm\asm::func_2375("move_done", undefined, ::trans_pass_run_out_to_move_done2, undefined);
  scripts\asm\asm::func_2375("check_melee", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("check_actions", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("sprint_turn", ::lib_0F3B::func_D514, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3EF5, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pass_sprint_in", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("pass_sprint_in", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("sprint_loop", ::scripts\asm\zombie\zombie::func_D4E3, "sprint", undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EE1, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pass_sprint_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("sprint_stop", ::scripts\asm\zombie\zombie::func_CEAE, undefined, undefined, undefined, undefined, ::lib_0F3A::func_3E97, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("move_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("pass_sprint_in", undefined, ::scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2374("idle_exit_sprint", ::scripts\asm\zombie\zombie::func_CEB7, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pass_sprint_in", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("pass_sprint_in", undefined, ::scripts\asm\asm::func_68B0, "finished");
  scripts\asm\asm::func_2374("pass_sprint_in", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("pass_sprint_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("sprint_loop", undefined, ::trans_pass_sprint_in_to_sprint_loop1, undefined);
  scripts\asm\asm::func_2374("pass_sprint_out", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("move_done", undefined, ::trans_pass_sprint_out_to_move_done0, undefined);
  scripts\asm\asm::func_2375("sprint_stop", undefined, ::scripts\asm\zombie\zombie::func_10092, undefined);
  scripts\asm\asm::func_2375("sprint_turn", undefined, ::lib_0F3B::func_FFF8, "sprint_turn");
  scripts\asm\asm::func_2375("check_actions", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("check_melee", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("slow_walk_stop", ::scripts\asm\zombie\zombie::func_CEAE, undefined, undefined, undefined, undefined, ::lib_0F3A::func_3E97, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pass_slow_walk_in", undefined, ::scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2374("pass_slow_walk_in", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("pass_slow_walk_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("slow_walk_loop", undefined, ::trans_pass_slow_walk_in_to_slow_walk_loop1, undefined);
  scripts\asm\asm::func_2374("slow_walk_loop", ::scripts\asm\zombie\zombie::func_D4E3, "sprint", undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EE1, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pass_slow_walk_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("slow_walk_turn", ::lib_0F3B::func_D514, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3EF5, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pass_slow_walk_in", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("pass_slow_walk_in", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("pass_slow_walk_out", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("slow_walk_stop", undefined, ::scripts\asm\zombie\zombie::func_10092, undefined);
  scripts\asm\asm::func_2375("slow_walk_turn", undefined, ::lib_0F3B::func_FFF8, "slow_walk_turn");
  scripts\asm\asm::func_2375("check_melee", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("move_done", undefined, ::trans_pass_slow_walk_out_to_move_done3, undefined);
  scripts\asm\asm::func_2374("idle_exit_slow_walk", ::scripts\asm\zombie\zombie::func_CEB7, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pass_slow_walk_in", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("pass_slow_walk_in", undefined, ::scripts\asm\asm::func_68B0, "finished");
  scripts\asm\asm::func_2374("pain_generic", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::scripts\asm\karatemaster\karatemaster_asm::func_3EE4, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("idle", undefined, ::scripts\asm\karatemaster\karatemaster_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("pain_moving", ::scripts\asm\karatemaster\karatemaster_asm::playmovingpainanim, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("walk_loop", undefined, ::scripts\asm\karatemaster\karatemaster_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("decide_idle", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("jump_up_128_over_40", ::scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_up_128_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("over_40_down_128", ::scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "over_40_down_128", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_up_128", ::scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_up_128", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("traverse_external", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("teleport_in", undefined, ::scripts\asm\karatemaster\karatemaster_asm::ontraversalteleport, undefined);
  scripts\asm\asm::func_2374("teleport_in", ::scripts\asm\karatemaster\karatemaster_asm::playanim_teleportin, undefined, ::scripts\asm\karatemaster\karatemaster_asm::teleportnotehandler, ::scripts\asm\karatemaster\karatemaster_asm::terminate_teleport, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("teleport_out", undefined, ::scripts\asm\karatemaster\karatemaster_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("walk_melee", ::scripts\asm\karatemaster\karatemaster_asm::playanim_melee, undefined, ::scripts\asm\karatemaster\karatemaster_asm::meleenotehandler, ::scripts\asm\karatemaster\karatemaster_asm::terminate_melee, undefined, ::scripts\asm\karatemaster\karatemaster_asm::choosemovingmeleeanim, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, "melee_anim", undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("pass_walk_in", undefined, ::scripts\asm\karatemaster\karatemaster_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("run_melee", ::scripts\asm\karatemaster\karatemaster_asm::playanim_melee, undefined, ::scripts\asm\karatemaster\karatemaster_asm::meleenotehandler, ::scripts\asm\karatemaster\karatemaster_asm::terminate_melee, undefined, ::scripts\asm\karatemaster\karatemaster_asm::choosemovingmeleeanim, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, "melee_anim", undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("pass_run_in", undefined, ::scripts\asm\karatemaster\karatemaster_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("sprint_melee", ::scripts\asm\karatemaster\karatemaster_asm::playanim_melee, undefined, ::scripts\asm\karatemaster\karatemaster_asm::meleenotehandler, ::scripts\asm\karatemaster\karatemaster_asm::terminate_melee, undefined, ::scripts\asm\karatemaster\karatemaster_asm::choosemovingmeleeanim, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, "melee_anim", undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("pass_sprint_in", undefined, ::scripts\asm\karatemaster\karatemaster_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("slow_walk_melee", ::scripts\asm\karatemaster\karatemaster_asm::playanim_melee, undefined, ::scripts\asm\karatemaster\karatemaster_asm::meleenotehandler, ::scripts\asm\karatemaster\karatemaster_asm::terminate_melee, undefined, ::scripts\asm\karatemaster\karatemaster_asm::choosemovingmeleeanim, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, "melee_anim", undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("pass_slow_walk_in", undefined, ::scripts\asm\karatemaster\karatemaster_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("check_melee", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("stand_melee", undefined, ::scripts\asm\karatemaster\karatemaster_asm::shoulddomelee, undefined);
  scripts\asm\asm::func_2375("sprint_melee", undefined, ::scripts\asm\karatemaster\karatemaster_asm::shoulddomelee, undefined);
  scripts\asm\asm::func_2375("run_melee", undefined, ::scripts\asm\karatemaster\karatemaster_asm::shoulddomelee, undefined);
  scripts\asm\asm::func_2375("walk_melee", undefined, ::scripts\asm\karatemaster\karatemaster_asm::shoulddomelee, undefined);
  scripts\asm\asm::func_2375("slow_walk_melee", undefined, ::scripts\asm\karatemaster\karatemaster_asm::shoulddomelee, undefined);
  scripts\asm\asm::func_2374("teleport_out", ::scripts\asm\karatemaster\karatemaster_asm::playanim_teleportout, undefined, ::scripts\asm\karatemaster\karatemaster_asm::teleportnotehandler, ::scripts\asm\karatemaster\karatemaster_asm::terminate_teleport, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "teleport_anim", "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\karatemaster\karatemaster_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("death_normal", ::lib_0C71::func_CF0E, undefined, undefined, undefined, undefined, ::scripts\asm\zombie_dlc4\zombie_dlc4::choosestandingdeathanim_dlc, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2374("death_moving_normal", ::lib_0C71::func_CF0E, undefined, undefined, undefined, undefined, ::lib_0C71::func_3F00, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2374("death_generic", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("death_normal", undefined, ::trans_death_generic_to_death_normal0, undefined);
  scripts\asm\asm::func_2375("death_kungfu", undefined, ::trans_death_generic_to_death_kungfu1, undefined);
  scripts\asm\asm::func_2375("death_normal", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("death_moving", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("death_moving_normal", undefined, ::trans_death_moving_to_death_moving_normal0, undefined);
  scripts\asm\asm::func_2375("death_kungfu", undefined, ::trans_death_moving_to_death_kungfu1, undefined);
  scripts\asm\asm::func_2375("death_moving_normal", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("death_kungfu", ::lib_0C71::func_CF0E, undefined, undefined, undefined, undefined, ::lib_0C71::func_3F00, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2327();
}

trans_idle_to_choose_movetype0(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

trans_choose_movetype_to_idle_exit_sprint0(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_BE9A();
}

trans_choose_movetype_to_idle_exit_walk1(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("walk");
}

trans_choose_movetype_to_idle_exit_run2(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("run");
}

trans_choose_movetype_to_idle_exit_slow_walk3(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("slow_walk");
}

trans_pass_walk_in_to_walk_loop1(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

trans_pass_walk_out_to_move_done4(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

trans_pass_run_in_to_run_loop1(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

trans_pass_run_out_to_move_done2(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

trans_pass_sprint_in_to_sprint_loop1(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

trans_pass_sprint_out_to_move_done0(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

trans_pass_slow_walk_in_to_slow_walk_loop1(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

trans_pass_slow_walk_out_to_move_done3(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

trans_death_generic_to_death_normal0(var_0, var_1, var_2, var_3) {
  return self.agent_type == "skater";
}

trans_death_generic_to_death_kungfu1(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::istrue(self.kung_fu_punched);
}

trans_death_moving_to_death_moving_normal0(var_0, var_1, var_2, var_3) {
  return self.agent_type == "skater";
}

trans_death_moving_to_death_kungfu1(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::istrue(self.kung_fu_punched);
}