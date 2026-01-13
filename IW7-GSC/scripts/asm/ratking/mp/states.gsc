/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\asm\ratking\mp\states.gsc
*********************************************/

func_2371() {
  if(scripts\asm\asm::func_232E("ratking")) {
    return;
  }

  scripts\asm\asm::func_230B("ratking", "ratking_start");
  scripts\asm\asm::func_2374("ratking_start", scripts\asm\ratking\ratking_asm::ratkinginit, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("enter_world", undefined, scripts\asm\ratking\ratking_asm::shouldplayentranceanim, undefined);
  scripts\asm\asm::func_2375("decide_idle", undefined, scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("idle", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, scripts\asm\ratking\ratking_asm::choosestaffornostaffanim, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("check_move", undefined, scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("check_actions", undefined, scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("enter_world", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("decide_idle", undefined, scripts\asm\ratking\ratking_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("check_actions", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("check_staff_and_shield", undefined, scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("leave_world", undefined, scripts\asm\ratking\ratking_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("staff_stomp", undefined, scripts\asm\ratking\ratking_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("shield_throw", undefined, scripts\asm\ratking\ratking_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("block", undefined, scripts\asm\ratking\ratking_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("teleport", undefined, scripts\asm\ratking\ratking_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("summon", undefined, scripts\asm\ratking\ratking_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("melee_attack", undefined, scripts\asm\ratking\ratking_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("staff_projectile", undefined, scripts\asm\ratking\ratking_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("shield_throw_at_spot", undefined, scripts\asm\ratking\ratking_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2374("staff_stomp", scripts\asm\ratking\ratking_asm::dostaffstomp, undefined, scripts\asm\ratking\ratking_asm::staffstompnotehandler, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, scripts\asm\ratking\ratking_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("block_intro", scripts\asm\ratking\ratking_asm::playblockanim, undefined, undefined, undefined, undefined, scripts\asm\ratking\ratking_asm::choosestaffornostaffanim, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("block_loop", undefined, scripts\asm\ratking\ratking_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("shield_throw", scripts\asm\ratking\ratking_asm::doshieldthrow, undefined, scripts\asm\ratking\ratking_asm::shieldthrownotehandler, scripts\asm\ratking\ratking_asm::clearlooktarget, undefined, scripts\asm\ratking\ratking_asm::choosestaffornostaffanim, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, scripts\asm\ratking\ratking_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("action_done", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("decide_idle", undefined, scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("death_generic", lib_0C71::func_CF0E, undefined, undefined, undefined, undefined, lib_0C71::func_3F00, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2374("death_moving", lib_0C71::func_CF0E, undefined, undefined, undefined, undefined, lib_0C71::func_3EE2, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2374("check_move", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("pass_walk_in", undefined, ::trans_check_move_to_pass_walk_in0, undefined);
  scripts\asm\asm::func_2375("pass_run_in", undefined, ::trans_check_move_to_pass_run_in1, undefined);
  scripts\asm\asm::func_2374("pass_walk_in", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("pass_walk_out", undefined, scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("check_staff_and_shield", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("walk_start", undefined, ::trans_pass_walk_in_to_walk_start2, undefined);
  scripts\asm\asm::func_2374("walk_turn", lib_0F3B::func_D514, undefined, scripts\asm\ratking\ratking_asm::ratkingturnnotehandler, undefined, undefined, lib_0F3B::func_3EF5, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("teleport", undefined, scripts\asm\ratking\ratking_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("check_interruptables", undefined, scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("walk_loop", undefined, scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("walk_loop", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("walk_loop", scripts\asm\zombie\zombie::func_D4E3, "walk", undefined, undefined, undefined, scripts\asm\zombie\zombie::func_3EE1, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pass_walk_out", undefined, scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pass_walk_out", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("walk_stop", undefined, scripts\asm\zombie\zombie::func_10092, undefined);
  scripts\asm\asm::func_2375("check_actions", undefined, scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("check_interruptables", undefined, scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("walk_turn", undefined, lib_0F3B::func_FFF8, "walk_turn");
  scripts\asm\asm::func_2375("move_done", undefined, ::trans_pass_walk_out_to_move_done4, undefined);
  scripts\asm\asm::func_2374("move_done", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("decide_idle", undefined, scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("choose_movetype", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("check_move", undefined, scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("walk_stop", scripts\asm\zombie\zombie::func_D4E3, "walk", undefined, undefined, undefined, scripts\asm\zombie\zombie::func_3EE1, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("move_done", undefined, scripts\asm\ratking\ratking_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("pass_run_in", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("pass_run_out", undefined, scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("check_staff_and_shield", undefined, scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("run_start", undefined, ::trans_pass_run_in_to_run_start2, undefined);
  scripts\asm\asm::func_2374("run_turn", lib_0F3B::func_D514, undefined, scripts\asm\ratking\ratking_asm::ratkingturnnotehandler, undefined, undefined, lib_0F3B::func_3EF5, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("check_interruptables", undefined, scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("run_loop", undefined, scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("run_loop", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("run_loop", scripts\asm\zombie\zombie::func_D4E3, "run", undefined, undefined, undefined, scripts\asm\zombie\zombie::func_3EE1, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pass_run_out", undefined, scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("run_stop", scripts\asm\zombie\zombie::func_D4E3, "run", undefined, undefined, undefined, scripts\asm\zombie\zombie::func_3EE1, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("move_done", undefined, scripts\asm\ratking\ratking_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("pass_run_out", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("run_stop", undefined, scripts\asm\zombie\zombie::func_10092, undefined);
  scripts\asm\asm::func_2375("check_interruptables", undefined, scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("check_actions", undefined, scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("run_turn", undefined, lib_0F3B::func_FFF8, "run_turn");
  scripts\asm\asm::func_2374("run_start", scripts\asm\zombie\zombie::func_CEB7, undefined, undefined, undefined, undefined, scripts\asm\ratking\ratking_asm::ratking_chooseanim_exit, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("run_loop", undefined, scripts\asm\ratking\ratking_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("walk_start", scripts\asm\zombie\zombie::func_CEB7, undefined, undefined, undefined, undefined, scripts\asm\ratking\ratking_asm::ratking_chooseanim_exit, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("walk_loop", undefined, scripts\asm\ratking\ratking_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("pain_generic", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, scripts\asm\ratking\ratking_asm::func_3EE4, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("idle", undefined, scripts\asm\ratking\ratking_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("pain_moving", scripts\asm\ratking\ratking_asm::playmovingpainanim, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("walk_loop", undefined, scripts\asm\ratking\ratking_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("decide_idle", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("platform_idle", undefined, ::trans_decide_idle_to_platform_idle0, undefined);
  scripts\asm\asm::func_2375("idle", undefined, scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("teleport_in", scripts\asm\ratking\ratking_asm::playteleportin, 2, undefined, undefined, undefined, scripts\asm\ratking\ratking_asm::choosestaffornostaffanim, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::func_2375("teleport_out", undefined, scripts\asm\ratking\ratking_asm::isanimdone, undefined);
  scripts\asm\asm::func_2375("action_done", undefined, scripts\asm\ratking\ratking_asm::shouldabortaction, "teleport");
  scripts\asm\asm::func_2374("summon", lib_0F3C::func_CEA8, undefined, scripts\asm\ratking\ratking_asm::summonnotehandler, undefined, undefined, scripts\asm\ratking\ratking_asm::choosestaffornostaffanim, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, scripts\asm\ratking\ratking_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("check_interruptables", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("staff_stomp", undefined, scripts\asm\ratking\ratking_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("block", undefined, scripts\asm\ratking\ratking_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("teleport", undefined, scripts\asm\ratking\ratking_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("melee_attack", undefined, scripts\asm\ratking\ratking_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("check_staff_and_shield", undefined, scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("block", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("block_intro", undefined, scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("block_loop", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, scripts\asm\ratking\ratking_asm::choosestaffornostaffanim, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("block_outro", undefined, scripts\asm\ratking\ratking_asm::shouldendblock, undefined);
  scripts\asm\asm::func_2374("block_outro", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, scripts\asm\ratking\ratking_asm::choosestaffornostaffanim, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, scripts\asm\ratking\ratking_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("teleport", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("teleport_in", undefined, scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("teleport_out", scripts\asm\ratking\ratking_asm::playteleportout, undefined, undefined, scripts\asm\ratking\ratking_asm::terminate_teleportout, undefined, scripts\asm\ratking\ratking_asm::choosestaffornostaffanim, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, scripts\asm\ratking\ratking_asm::isanimdone, undefined);
  scripts\asm\asm::func_2375("action_done", undefined, scripts\asm\ratking\ratking_asm::shouldabortaction, "teleport");
  scripts\asm\asm::func_2375("check_interruptables", undefined, scripts\asm\ratking\ratking_asm::shouldconsiderabortingteleport, undefined);
  scripts\asm\asm::func_2374("traverse_external", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("teleport_in", undefined, scripts\asm\ratking\ratking_asm::ontraversalteleport, undefined);
  scripts\asm\asm::func_2374("leave_world", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, scripts\asm\ratking\ratking_asm::choosestaffornostaffanim, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2374("melee_attack", scripts\asm\ratking\ratking_asm::playmeleeattack, undefined, scripts\asm\ratking\ratking_asm::meleenotehandler, undefined, undefined, scripts\asm\ratking\ratking_asm::choosestaffornostaffanim, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, scripts\asm\ratking\ratking_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("staff_projectile", scripts\asm\ratking\ratking_asm::dostaffprojectile, undefined, scripts\asm\ratking\ratking_asm::staffprojectilenotehandler, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, scripts\asm\ratking\ratking_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("shield_throw_at_spot", scripts\asm\ratking\ratking_asm::doshieldthrowatspot, undefined, scripts\asm\ratking\ratking_asm::shieldthrowatspotnotehandler, scripts\asm\ratking\ratking_asm::clearlooktarget, undefined, scripts\asm\ratking\ratking_asm::choosestaffornostaffanim, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, scripts\asm\ratking\ratking_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("platform_idle", scripts\asm\ratking\ratking_asm::playplatformidle, undefined, undefined, undefined, undefined, scripts\asm\ratking\ratking_asm::choosestaffornostaffanim, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim angle delta", undefined);
  scripts\asm\asm::func_2375("decide_idle", undefined, ::trans_platform_idle_to_decide_idle0, undefined);
  scripts\asm\asm::func_2375("check_actions", undefined, scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("aimset_shield_throw", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("shield_lost_and_found", scripts\asm\ratking\ratking_asm::playshieldlostandfound, undefined, undefined, undefined, undefined, scripts\asm\ratking\ratking_asm::chooseshieldornoshieldanim, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim angle delta", undefined);
  scripts\asm\asm::func_2375("decide_idle", undefined, scripts\asm\ratking\ratking_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("staff_lost_and_found", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, scripts\asm\ratking\ratking_asm::choosestaffornostaffanim, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim angle delta", undefined);
  scripts\asm\asm::func_2375("decide_idle", undefined, scripts\asm\ratking\ratking_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("check_staff_and_shield", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("shield_lost_and_found", undefined, scripts\asm\ratking\ratking_asm::lostorfoundshield, undefined);
  scripts\asm\asm::func_2375("staff_lost_and_found", undefined, scripts\asm\ratking\ratking_asm::lostorfoundstaff, undefined);
  scripts\asm\asm::func_2327();
}

trans_check_move_to_pass_walk_in0(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("walk");
}

trans_check_move_to_pass_run_in1(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("run");
}

trans_pass_walk_in_to_walk_start2(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

trans_pass_walk_out_to_move_done4(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

trans_pass_run_in_to_run_start2(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

trans_decide_idle_to_platform_idle0(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::istrue(self.isonplatform);
}

trans_platform_idle_to_decide_idle0(var_0, var_1, var_2, var_3) {
  return !scripts\engine\utility::istrue(self.isonplatform);
}