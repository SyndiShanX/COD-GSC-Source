/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3909.gsc
************************/

func_2371() {
  if(scripts\asm\asm::func_232E("zombie_brute")) {
    return;
  }

  scripts\asm\asm::func_230B("zombie_brute", "zombiestart");
  scripts\asm\asm::func_2374("zombiestart", ::scripts\asm\zombie\zombie::func_13F9A, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("choose_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("brute_intro", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("idle", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", undefined, undefined);
  scripts\asm\asm::func_2375("laser_attack", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_FFF1, undefined);
  scripts\asm\asm::func_2375("helmet_place", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_10063, undefined);
  scripts\asm\asm::func_2375("helmet_remove", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::shouldreloadwhilemoving, undefined);
  scripts\asm\asm::func_2375("melee", undefined, ::func_12253, undefined);
  scripts\asm\asm::func_2375("choose_idle_exit", undefined, ::func_1223F, undefined);
  scripts\asm\asm::func_2375("idle_combat", undefined, ::func_1224F, undefined);
  scripts\asm\asm::func_2374("choose_idle", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("helmet_remove", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::shouldreloadwhilemoving, undefined);
  scripts\asm\asm::func_2375("helmet_place", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_10063, undefined);
  scripts\asm\asm::func_2375("choose_idle_exit", undefined, ::func_11BB9, undefined);
  scripts\asm\asm::func_2375("idle_combat", undefined, ::func_11BBE, undefined);
  scripts\asm\asm::func_2375("idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("idle_combat", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, "face goal", undefined, undefined);
  scripts\asm\asm::func_2375("throw_zombie_piece", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_100AC, undefined);
  scripts\asm\asm::func_2375("grab_zombie_piece", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_1001D, undefined);
  scripts\asm\asm::func_2375("laser_attack", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_FFF1, undefined);
  scripts\asm\asm::func_2375("helmet_remove", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::shouldreloadwhilemoving, undefined);
  scripts\asm\asm::func_2375("helmet_place", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_10063, undefined);
  scripts\asm\asm::func_2375("melee", undefined, ::func_12210, undefined);
  scripts\asm\asm::func_2375("choose_idle_exit", undefined, ::func_12207, undefined);
  scripts\asm\asm::func_2374("grab_zombie_piece", ::scripts\asm\zombie_brute\zombie_brute_asm::func_D48D, undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::_meth_8485, ::scripts\asm\zombie_brute\zombie_brute_asm::func_116EB, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("idle_combat", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_1FB4, undefined);
  scripts\asm\asm::func_2374("throw_zombie_piece", ::scripts\asm\zombie_brute\zombie_brute_asm::func_D54C, undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_11809, ::scripts\asm\zombie_brute\zombie_brute_asm::func_116EF, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::func_2375("idle_combat", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("throw_zombie_piece_while_moving", ::scripts\asm\zombie_brute\zombie_brute_asm::func_D54C, undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_11809, ::scripts\asm\zombie_brute\zombie_brute_asm::func_116EF, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::func_2375("run_loop", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_1FB4, undefined);
  scripts\asm\asm::func_2375("sprint_loop", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_1FB4, undefined);
  scripts\asm\asm::func_2374("grab_zombie_piece_while_moving", ::scripts\asm\zombie_brute\zombie_brute_asm::func_D48E, undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::_meth_8485, ::scripts\asm\zombie_brute\zombie_brute_asm::func_116EB, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("run_loop", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_1FB4, undefined);
  scripts\asm\asm::func_2374("laser_attack", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("laser_attack_prep", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("idle_combat", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_9E70, undefined);
  scripts\asm\asm::func_2374("aimset_laser", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("laser_attack_idle", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("idle_combat", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_9E70, undefined);
  scripts\asm\asm::func_2375("laser_attack_shoot", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::canseethroughfoliage, undefined);
  scripts\asm\asm::func_2374("laser_attack_shoot", ::scripts\asm\zombie_brute\zombie_brute_asm::func_58E5, undefined, undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_116F8, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("idle_combat", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_9E70, undefined);
  scripts\asm\asm::func_2375("laser_attack_idle", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_100A0, undefined);
  scripts\asm\asm::func_2374("laser_attack_prep", ::scripts\asm\zombie_brute\zombie_brute_asm::func_D4BB, undefined, undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::terminatelaserattackprep, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::func_2375("laser_attack_decide", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_1FB4, undefined);
  scripts\asm\asm::func_2374("laser_attack_decide", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("laser_attack_shoot", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::canseethroughfoliage, undefined);
  scripts\asm\asm::func_2375("laser_attack_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("helmet_remove", ::scripts\asm\zombie_brute\zombie_brute_asm::func_D499, undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_8E15, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_1FB4, undefined);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("helmet_place", ::scripts\asm\zombie_brute\zombie_brute_asm::func_D498, undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_8E15, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("choose_idle", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_1FB4, undefined);
  scripts\asm\asm::func_2375("choose_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("attack_stand_2_hit", ::scripts\asm\zombie\melee::func_CC64, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("melee_done", 0, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("attack_walk", ::scripts\asm\zombie\melee::func_D4DC, undefined, undefined, undefined, undefined, ::scripts\asm\zombie\melee::func_3EB9, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("melee_done", 0, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("attack_run", ::scripts\asm\zombie\melee::func_D4DC, undefined, undefined, undefined, undefined, ::scripts\asm\zombie\melee::func_3EB9, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("melee_done", 0, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("attack_sprint", ::scripts\asm\zombie\melee::func_D4DC, undefined, undefined, undefined, undefined, ::scripts\asm\zombie\melee::func_3EB9, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("melee_done", 0, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("melee", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("attack_slam", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_10055, undefined);
  scripts\asm\asm::func_2375("melee_move", undefined, ::func_122A2, undefined);
  scripts\asm\asm::func_2375("choose_num_melee_hits", undefined, ::func_1229E, undefined);
  scripts\asm\asm::func_2374("melee_move", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("attack_run_2_hit", undefined, ::func_1227B, undefined);
  scripts\asm\asm::func_2375("attack_walk", undefined, ::func_12283, undefined);
  scripts\asm\asm::func_2375("attack_run", undefined, ::func_12276, undefined);
  scripts\asm\asm::func_2375("attack_sprint", undefined, ::func_1227D, undefined);
  scripts\asm\asm::func_2374("melee_done", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("choose_idle", undefined, ::scripts\asm\zombie\zombie::func_13F9B, undefined);
  scripts\asm\asm::func_2374("choose_num_melee_hits", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("attack_stand_2_hit", undefined, ::func_11BEF, undefined);
  scripts\asm\asm::func_2375("attack_stand", undefined, ::func_11BEE, undefined);
  scripts\asm\asm::func_2374("attack_stand", ::scripts\asm\zombie\melee::func_D539, undefined, undefined, undefined, undefined, ::scripts\asm\zombie\melee::func_3EB9, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("melee_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("attack_run_2_hit", ::scripts\asm\zombie\melee::func_CC64, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("melee_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("attack_slam", ::scripts\asm\zombie_brute\zombie_brute_asm::func_D51C, undefined, undefined, undefined, undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_3EFA, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("melee_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("attack_swipe", ::scripts\asm\zombie_brute\zombie_brute_asm::func_D51C, undefined, undefined, undefined, undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_3EFA, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("melee_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("choose_movetype", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("sprint_loop", undefined, ::func_11BE1, undefined);
  scripts\asm\asm::func_2375("run_loop", undefined, ::func_11BDA, undefined);
  scripts\asm\asm::func_2374("run_loop", ::scripts\asm\zombie\zombie::func_D4E3, undefined, undefined, undefined, undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_3EC1, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("enter_duck_move", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_1003B, undefined);
  scripts\asm\asm::func_2375("to_take_helmet_off", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::shouldreloadwhilemoving, undefined);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::func_12437, undefined);
  scripts\asm\asm::func_2375("run_stop", undefined, ::scripts\asm\zombie\zombie::func_10092, undefined);
  scripts\asm\asm::func_2375("to_melee", undefined, ::func_1245A, undefined);
  scripts\asm\asm::func_2375("run_turn", undefined, ::lib_0F3B::func_FFF8, "run_turn");
  scripts\asm\asm::func_2375("choose_idle_exit", undefined, ::func_1242F, undefined);
  scripts\asm\asm::func_2375("attack_slam", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_FFE2, undefined);
  scripts\asm\asm::func_2375("move_done", undefined, ::func_12448, undefined);
  scripts\asm\asm::func_2375("throw_zombie_piece_while_moving", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_100AC, undefined);
  scripts\asm\asm::func_2375("grab_zombie_piece_while_moving", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_1001D, undefined);
  scripts\asm\asm::func_2375("laser_attack", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_FFF1, undefined);
  scripts\asm\asm::func_2374("sprint_loop", ::scripts\asm\zombie\zombie::func_D4E3, undefined, undefined, undefined, undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_3EC1, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("enter_duck_move", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_1003B, undefined);
  scripts\asm\asm::func_2375("throw_zombie_piece_while_moving", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_100AC, undefined);
  scripts\asm\asm::func_2375("laser_attack", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_FFF1, undefined);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::func_124F6, undefined);
  scripts\asm\asm::func_2375("to_put_helmet_on", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_10063, undefined);
  scripts\asm\asm::func_2375("sprint_stop", undefined, ::scripts\asm\zombie\zombie::func_10092, undefined);
  scripts\asm\asm::func_2375("sprint_turn", undefined, ::lib_0F3B::func_FFF8, "sprint_turn");
  scripts\asm\asm::func_2375("move_done", undefined, ::func_1250A, undefined);
  scripts\asm\asm::func_2375("to_melee", undefined, ::func_12530, undefined);
  scripts\asm\asm::func_2375("attack_slam", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_FFE2, undefined);
  scripts\asm\asm::func_2374("run_stop", ::scripts\asm\zombie\zombie::func_CEAE, undefined, undefined, undefined, undefined, ::lib_0F3A::func_3E97, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("to_take_helmet_off", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::shouldreloadwhilemoving, undefined);
  scripts\asm\asm::func_2375("run_loop", undefined, ::scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2375("move_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("to_melee", undefined, ::func_1246B, undefined);
  scripts\asm\asm::func_2374("sprint_stop", ::scripts\asm\zombie\zombie::func_CEAE, undefined, undefined, undefined, undefined, ::lib_0F3A::func_3E97, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("to_put_helmet_on", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_10063, undefined);
  scripts\asm\asm::func_2375("sprint_loop", undefined, ::scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2375("move_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("to_melee", undefined, ::func_1253D, undefined);
  scripts\asm\asm::func_2374("move_done", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("choose_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("run_turn", ::scripts\asm\zombie\zombie::func_D515, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3EF5, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("to_take_helmet_off", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::shouldreloadwhilemoving, undefined);
  scripts\asm\asm::func_2375("to_melee", undefined, ::func_12480, undefined);
  scripts\asm\asm::func_2375("run_loop", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("run_loop", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("sprint_turn", ::scripts\asm\zombie\zombie::func_D538, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3EF5, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("to_put_helmet_on", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_10063, undefined);
  scripts\asm\asm::func_2375("to_melee", undefined, ::func_1254F, undefined);
  scripts\asm\asm::func_2375("sprint_loop", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("sprint_loop", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("choose_idle_exit", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("idle_exit_sprint", undefined, ::func_11BA9, undefined);
  scripts\asm\asm::func_2375("idle_exit_run", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("idle_exit_run", ::scripts\asm\zombie\zombie::func_CEB7, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("run_loop", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("run_loop", undefined, ::scripts\asm\asm::func_68B0, "finish");
  scripts\asm\asm::func_2374("idle_exit_sprint", ::scripts\asm\zombie\zombie::func_CEB7, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("sprint_loop", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("sprint_loop", undefined, ::scripts\asm\asm::func_68B0, "finish");
  scripts\asm\asm::func_2374("to_melee", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("melee", undefined, ::func_125D1, undefined);
  scripts\asm\asm::func_2374("to_put_helmet_on", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("helmet_place", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_10063, undefined);
  scripts\asm\asm::func_2374("to_take_helmet_off", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("helmet_remove", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::shouldreloadwhilemoving, undefined);
  scripts\asm\asm::func_2374("duck_move", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_3EC2, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("to_exit_duck_move", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("enter_duck_move", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_3EC2, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("should_keep_crouched", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("exit_duck_move", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_3EC2, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("move_done", undefined, ::scripts\asm\zombie\zombie::func_9EAB, undefined);
  scripts\asm\asm::func_2375("to_take_helmet_off", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::shouldreloadwhilemoving, undefined);
  scripts\asm\asm::func_2375("to_put_helmet_on", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_10063, undefined);
  scripts\asm\asm::func_2375("to_melee", undefined, ::scripts\asm\zombie\melee::func_138E4, undefined);
  scripts\asm\asm::func_2375("anim_ended", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("to_exit_duck_move", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("duck_move", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_1003B, undefined);
  scripts\asm\asm::func_2375("exit_duck_move", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("should_keep_crouched", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("duck_move", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_1003B, undefined);
  scripts\asm\asm::func_2375("exit_duck_move", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("to_run", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("run_stop", undefined, ::scripts\asm\zombie\zombie::func_10092, undefined);
  scripts\asm\asm::func_2375("run_turn", undefined, ::lib_0F3B::func_FFF8, "run_turn");
  scripts\asm\asm::func_2375("run_loop", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("to_sprint", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("sprint_stop", undefined, ::scripts\asm\zombie\zombie::func_10092, undefined);
  scripts\asm\asm::func_2375("sprint_loop", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("sprint_turn", undefined, ::lib_0F3B::func_FFF8, "sprint_turn");
  scripts\asm\asm::func_2374("anim_ended", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("to_run", undefined, ::scripts\asm\zombie\zombie::func_BE99, undefined);
  scripts\asm\asm::func_2375("to_sprint", undefined, ::scripts\asm\zombie\zombie::func_BE9A, undefined);
  scripts\asm\asm::func_2374("brute_intro", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("choose_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("death_generic", ::lib_0C71::func_CF0E, undefined, undefined, undefined, undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_3EC0, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2374("death_moving", ::lib_0C71::func_CF0E, undefined, undefined, undefined, undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_3EC0, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2374("death_crawling", ::lib_0C71::func_CF0E, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2374("brute_pain", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("croc_chomp_enter", undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_FFEB, undefined);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("croc_chomp_exit", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_3EC9, "croc_chomp_exit", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("choose_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("croc_chomp_enter", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::scripts\asm\zombie_brute\zombie_brute_asm::func_3EC9, "croc_chomp_enter", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("croc_chomp_exit", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("croc_chomp_loop", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("wall_over_40", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "wall_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("traverse_external", ::scripts\asm\zombie\zombie::func_D563, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jumpdown_130", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_down_slow", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_down_40", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jumpdown_80", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_across_100", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jumpacross", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_across_196", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_down_fast", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie_brute\zombie_brute_asm::func_3EC3, "jump_down_fast", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("step_over_40", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("window_over_36", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("step_up_40", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("nonboost_jump_up_120", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("boost_jump_up", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_across_100_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jumpacross", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("wall_over_40_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "wall_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_down_slow_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_down_40_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("step_over_40_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("window_over_36_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("step_up_40_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("nonboost_jump_up_120_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("boost_jump_up_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_across_196_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_up_40", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jumpup_120", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_across", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_down", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_across_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_up_40_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jumpup_120_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_down_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("mantle_40_over_extended", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("mantle_40_over_extended_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_down_128_out_50", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_down_128_out_50", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_down_128_out_50_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_down_128_out_50", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_down_56_out_50", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_down_56_out_50", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_down_56_out_50_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_down_56_out_50", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_up_56", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_up_56", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_up_56_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_up_56", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_down_128", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_down_128", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_down_128_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_down_128", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_down_56", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_down_56", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_down_56_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_down_56", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_up_128", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie_brute\zombie_brute_asm::func_3EC3, "jump_up_128", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_up_128_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie_brute\zombie_brute_asm::func_3EC3, "jump_up_128", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_up_128_over_40", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_up_128_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_up_56_over_40", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_up_56_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_over_30_out_30_down_48", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_over_30_out_30_down_48", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_over_30_out_30_down_48_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_over_30_out_30_down_48", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_up_128_over_40_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_up_128_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_up_56_over_40_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_up_56_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("over_40_down_128", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "over_40_down_128", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("over_40_down_56", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "over_40_down_56", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("over_40_down_128_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "over_40_down_128", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("over_40_down_56_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "over_40_down_56", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_down_384", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_down_384", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_down_384_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_down_384", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("window_over_40", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "window_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("window_over_40_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "window_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("window_over_40_extended", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "window_over_40_extended", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("window_over_40_extended_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "window_over_extended_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("window_over_40_left", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "window_over_40_left", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("window_over_40_left_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "window_over_40_left", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("window_over_40_left_extended", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "window_over_40_left_extended", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("window_over_40_left_extended_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "window_over_40_left_extended", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("window_over_40_right", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "window_over_40_right", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("window_over_40_right_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "window_over_40_right", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("window_over_40_right_extended", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "window_over_40_right_extended", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("window_over_40_right_extended_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "window_over_40_right_extended", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_up_128_over_40_out_30", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_up_128_over_40_out_30", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_up_128_over_40_out_30_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie\zombie::func_3F08, "jump_up_128_over_40_out_30", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_down_fast_norestart", ::scripts\asm\zombie\zombie::func_D567, undefined, undefined, undefined, "choose_movetype", ::scripts\asm\zombie_brute\zombie_brute_asm::func_3EC3, "jump_down_fast", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2327();
}

func_12253(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

func_1223F(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

func_1224F(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_isincombat();
}

func_11BB9(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

func_11BBE(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_isincombat();
}

func_12210(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

func_12207(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

func_122A2(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E1();
}

func_1229E(var_0, var_1, var_2, var_3) {
  return 1;
}

func_1227B(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::shouldplayarenaintro();
}

func_12283(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("walk");
}

func_12276(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("run");
}

func_1227D(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("sprint");
}

func_11BEF(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::shouldplayarenaintro();
}

func_11BEE(var_0, var_1, var_2, var_3) {
  return 1;
}

func_11BE1(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_BE9A();
}

func_11BDA(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("run");
}

func_12437(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_BCCD();
}

func_1245A(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

func_1242F(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_A013();
}

func_12448(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

func_124F6(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_BCCD();
}

func_1250A(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

func_12530(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

func_1246B(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

func_1253D(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

func_12480(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

func_1254F(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

func_11BA9(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_BE9A();
}

func_125D1(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}