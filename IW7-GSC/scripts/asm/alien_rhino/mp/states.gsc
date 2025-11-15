/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\asm\alien_rhino\mp\states.gsc
*************************************************/

func_2371() {
  if(scripts\asm\asm::func_232E("alien_rhino")) {
    return;
  }

  scripts\asm\asm::func_230B("alien_rhino", "start_here");
  scripts\asm\asm::func_2374("start_here", ::scripts\asm\alien_rhino\alien_rhino_asm::asminit, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("entrance", undefined, ::scripts\asm\alien_rhino\alien_rhino_asm::shouldplayentranceanim, undefined);
  scripts\asm\asm::func_2375("decide_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("idle", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("turn", undefined, ::scripts\asm\dlc4\dlc4_asm::shouldturn, undefined);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::trans_idle_to_choose_movetype1, undefined);
  scripts\asm\asm::func_2375("check_actions", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("entrance", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::scripts\asm\dlc4\dlc4_asm::choosespawnanim, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("decide_idle", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("check_actions", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("stand_melee", undefined, ::scripts\asm\dlc4\dlc4_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("moving_melee", undefined, ::scripts\asm\dlc4\dlc4_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("taunt", undefined, ::scripts\asm\dlc4\dlc4_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("charge", undefined, ::scripts\asm\dlc4\dlc4_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("jump", undefined, ::scripts\asm\dlc4\dlc4_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("jump_attack", undefined, ::scripts\asm\dlc4\dlc4_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2374("stand_melee", ::scripts\asm\dlc4\dlc4_asm::playmeleeattack, undefined, ::scripts\asm\alien_rhino\alien_rhino_asm::alienrhinomeleenotehandler, ::scripts\asm\dlc4\dlc4_asm::terminate_meleeattack, undefined, ::scripts\asm\dlc4\dlc4_asm::choosemeleeattack, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("action_done", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("decide_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("death_generic", ::scripts\asm\dlc4\dlc4_asm::playaliendeathanim, undefined, undefined, undefined, undefined, ::lib_0C71::func_3F00, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", undefined, undefined);
  scripts\asm\asm::func_2374("death_moving", ::scripts\asm\dlc4\dlc4_asm::playaliendeathanim, undefined, undefined, undefined, undefined, ::lib_0C71::func_3EE2, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", undefined, undefined);
  scripts\asm\asm::func_2374("check_move", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("idle_exit_sprint", undefined, ::trans_check_move_to_idle_exit_sprint0, undefined);
  scripts\asm\asm::func_2375("pass_run_in", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("idle_exit_sprint", ::scripts\asm\zombie\zombie::func_CEB7, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pass_sprint_in", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("pass_sprint_in", undefined, ::scripts\asm\asm::func_68B0, "finish");
  scripts\asm\asm::func_2375("check_move_interruptions", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pass_sprint_in", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("pass_sprint_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("sprint_loop", undefined, ::trans_pass_sprint_in_to_sprint_loop1, undefined);
  scripts\asm\asm::func_2374("sprint_turn", ::lib_0F3B::func_D514, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3EF5, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("check_move_interruptions", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("pass_sprint_in", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("pass_sprint_in", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("sprint_loop", ::scripts\asm\zombie\zombie::func_D4E3, "walk", undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EE1, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pass_sprint_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pass_sprint_out", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("sprint_stop", undefined, ::scripts\asm\dlc4\dlc4_asm::shouldstartarrivalalien, undefined);
  scripts\asm\asm::func_2375("sprint_turn", undefined, ::lib_0F3B::func_FFF8, "walk_turn");
  scripts\asm\asm::func_2375("move_done", undefined, ::trans_pass_sprint_out_to_move_done2, undefined);
  scripts\asm\asm::func_2374("sprint_stop", ::scripts\asm\dlc4\dlc4_asm::playalienarrival, undefined, undefined, ::scripts\asm\dlc4\dlc4_asm::terminate_arrival, undefined, ::lib_0F3A::func_3E97, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("check_move_interruptions", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("pass_sprint_in", undefined, ::scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2375("move_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("move_done", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("decide_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("choose_movetype", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("check_move", undefined, ::trans_choose_movetype_to_check_move0, undefined);
  scripts\asm\asm::func_2375("move_done", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pass_run_in", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("pass_run_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("idle_exit_run", undefined, ::trans_pass_run_in_to_idle_exit_run1, undefined);
  scripts\asm\asm::func_2374("run_turn", ::scripts\asm\alien_rhino\alien_rhino_asm::playsharpturnanim_rhino, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3EF5, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("check_move_interruptions", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("run_loop", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("run_loop", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("run_loop", ::scripts\asm\zombie\zombie::func_D4E3, "run", undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EE1, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pass_run_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("run_stop", ::scripts\asm\dlc4\dlc4_asm::playalienarrival, "run", undefined, ::scripts\asm\dlc4\dlc4_asm::terminate_arrival, undefined, ::scripts\asm\zombie\zombie::func_3EE1, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("check_move_interruptions", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("move_done", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("pass_run_out", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("run_stop", undefined, ::scripts\asm\dlc4\dlc4_asm::shouldstartarrivalalien, undefined);
  scripts\asm\asm::func_2375("move_done", undefined, ::trans_pass_run_out_to_move_done1, undefined);
  scripts\asm\asm::func_2375("check_actions", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("run_turn", undefined, ::lib_0F3B::func_FFF8, "run_turn");
  scripts\asm\asm::func_2374("idle_exit_run", ::scripts\asm\zombie\zombie::func_CEB7, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("run_loop", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2375("check_move_interruptions", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("check_move_interruptions", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("check_interruptables", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pain_generic", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::scripts\asm\dlc4\dlc4_asm::func_3EE4, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("idle", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("pain_moving", ::scripts\asm\dlc4\dlc4_asm::playmovingpainanim, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("pain_moving_done", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("decide_idle", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("check_actions", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("check_interruptables", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("stand_melee", undefined, ::scripts\asm\dlc4\dlc4_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("moving_melee", undefined, ::scripts\asm\dlc4\dlc4_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2374("traverse_external", ::scripts\asm\dlc4\dlc4_asm::doteleporthack, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2374("moving_melee", ::scripts\asm\dlc4\dlc4_asm::playmovingmeleeattack, undefined, ::scripts\asm\alien_rhino\alien_rhino_asm::alienrhinomeleenotehandler, ::scripts\asm\dlc4\dlc4_asm::terminate_movingmelee, undefined, ::scripts\asm\dlc4\dlc4_asm::choosemovingmeleeattack, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("moving_melee_done", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("moving_melee_done", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pain_moving_done", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::trans_pain_moving_done_to_choose_movetype0, undefined);
  scripts\asm\asm::func_2375("idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("turn", ::scripts\asm\dlc4\dlc4_asm::func_D56A, undefined, undefined, undefined, undefined, ::scripts\asm\dlc4\dlc4_asm::func_3F0A, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("idle", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("taunt", ::scripts\asm\alien_rhino\alien_rhino_asm::playtauntanim, undefined, undefined, ::scripts\asm\dlc4\dlc4_asm::terminate_movingmelee, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("charge", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("charge_intro", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("charge_loop", ::scripts\asm\alien_rhino\alien_rhino_asm::playchargeloop, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "code_move", undefined);
  scripts\asm\asm::func_2375("charge_outro", undefined, ::scripts\asm\dlc4\dlc4_asm::shouldabortaction, "charge");
  scripts\asm\asm::func_2374("charge_outro", ::scripts\asm\alien_rhino\alien_rhino_asm::playrhinochargeoutro, undefined, ::scripts\asm\alien_rhino\alien_rhino_asm::alienrhinonotehandler, ::scripts\asm\dlc4\dlc4_asm::terminate_meleeattack, undefined, ::scripts\asm\alien_rhino\alien_rhino_asm::choosechargeoutroanim, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("charge_intro", ::scripts\asm\alien_rhino\alien_rhino_asm::playchargeintro, undefined, ::scripts\asm\alien_rhino\alien_rhino_asm::alienrhinonotehandler, undefined, undefined, ::scripts\asm\alien_rhino\alien_rhino_asm::choosechargeintroanim, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("charge_intro_done", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("charge_intro_done", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\alien_rhino\alien_rhino_asm::shouldabortcharge, "charge");
  scripts\asm\asm::func_2375("charge_loop", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("jump_in_air", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_launch_down", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_launch_level", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_launch_up", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_launch_arrival", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_land_up", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_land_level", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_land_down", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("alien_jump", ::scripts\asm\dlc4\dlc4_asm::doalienjumptraversal, undefined, ::scripts\asm\dlc4\dlc4_asm::jumpnotehandler, ::scripts\asm\dlc4\dlc4_asm::terminate_jump, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_land_sidewall_high", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_land_sidewall_low", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("attack_leap_swipe", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("attack_leap_swipe_left", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("attack_leap_swipe_right", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump", ::scripts\asm\dlc4\dlc4_asm::dojump, undefined, undefined, ::scripts\asm\dlc4\dlc4_asm::terminate_movingmelee, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_moving", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\dlc4\dlc4_asm::shouldabortaction, "jump");
  scripts\asm\asm::func_2374("jump_attack", ::scripts\asm\dlc4\dlc4_asm::dojumpattack, undefined, undefined, ::scripts\asm\dlc4\dlc4_asm::terminate_movingmelee, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_moving", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\dlc4\dlc4_asm::shouldabortaction, "jump_attack");
  scripts\asm\asm::func_2327();
}

trans_idle_to_choose_movetype1(param_00, param_01, param_02, param_03) {
  return scripts\asm\asm_bb::bb_moverequested();
}

trans_check_move_to_idle_exit_sprint0(param_00, param_01, param_02, param_03) {
  return scripts\asm\asm_bb::bb_movetyperequested("sprint");
}

trans_pass_sprint_in_to_sprint_loop1(param_00, param_01, param_02, param_03) {
  return scripts\asm\asm_bb::bb_moverequested();
}

trans_pass_sprint_out_to_move_done2(param_00, param_01, param_02, param_03) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

trans_choose_movetype_to_check_move0(param_00, param_01, param_02, param_03) {
  return scripts\asm\asm_bb::bb_moverequested();
}

trans_pass_run_in_to_idle_exit_run1(param_00, param_01, param_02, param_03) {
  return scripts\asm\asm_bb::bb_moverequested();
}

trans_pass_run_out_to_move_done1(param_00, param_01, param_02, param_03) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

trans_pain_moving_done_to_choose_movetype0(param_00, param_01, param_02, param_03) {
  return scripts\asm\asm_bb::bb_moverequested();
}