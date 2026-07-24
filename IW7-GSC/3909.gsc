/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3909.gsc
**************************************/

_id_2371() {
  if(scripts\asm\asm::_id_232E("zombie_brute")) {
    return;
  }
  scripts\asm\asm::_id_230B("zombie_brute", "zombiestart");
  scripts\asm\asm::_id_2374("zombiestart", scripts\asm\zombie\zombie::_id_13F9A, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("choose_idle", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2375("brute_intro", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("idle", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", undefined, undefined);
  scripts\asm\asm::_id_2375("laser_attack", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_FFF1, undefined);
  scripts\asm\asm::_id_2375("helmet_place", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_10063, undefined);
  scripts\asm\asm::_id_2375("helmet_remove", undefined, scripts\asm\zombie_brute\zombie_brute_asm::shouldreloadwhilemoving, undefined);
  scripts\asm\asm::_id_2375("melee", undefined, ::_id_12253, undefined);
  scripts\asm\asm::_id_2375("choose_idle_exit", undefined, ::_id_1223F, undefined);
  scripts\asm\asm::_id_2375("idle_combat", undefined, ::_id_1224F, undefined);
  scripts\asm\asm::_id_2374("choose_idle", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("helmet_remove", undefined, scripts\asm\zombie_brute\zombie_brute_asm::shouldreloadwhilemoving, undefined);
  scripts\asm\asm::_id_2375("helmet_place", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_10063, undefined);
  scripts\asm\asm::_id_2375("choose_idle_exit", undefined, ::_id_11BB9, undefined);
  scripts\asm\asm::_id_2375("idle_combat", undefined, ::_id_11BBE, undefined);
  scripts\asm\asm::_id_2375("idle", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("idle_combat", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, "face goal", undefined, undefined);
  scripts\asm\asm::_id_2375("throw_zombie_piece", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_100AC, undefined);
  scripts\asm\asm::_id_2375("grab_zombie_piece", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_1001D, undefined);
  scripts\asm\asm::_id_2375("laser_attack", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_FFF1, undefined);
  scripts\asm\asm::_id_2375("helmet_remove", undefined, scripts\asm\zombie_brute\zombie_brute_asm::shouldreloadwhilemoving, undefined);
  scripts\asm\asm::_id_2375("helmet_place", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_10063, undefined);
  scripts\asm\asm::_id_2375("melee", undefined, ::_id_12210, undefined);
  scripts\asm\asm::_id_2375("choose_idle_exit", undefined, ::_id_12207, undefined);
  scripts\asm\asm::_id_2374("grab_zombie_piece", scripts\asm\zombie_brute\zombie_brute_asm::_id_D48D, undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_8485, scripts\asm\zombie_brute\zombie_brute_asm::_id_116EB, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("idle_combat", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_1FB4, undefined);
  scripts\asm\asm::_id_2374("throw_zombie_piece", scripts\asm\zombie_brute\zombie_brute_asm::_id_D54C, undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_11809, scripts\asm\zombie_brute\zombie_brute_asm::_id_116EF, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("idle_combat", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("throw_zombie_piece_while_moving", scripts\asm\zombie_brute\zombie_brute_asm::_id_D54C, undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_11809, scripts\asm\zombie_brute\zombie_brute_asm::_id_116EF, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("run_loop", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_1FB4, undefined);
  scripts\asm\asm::_id_2375("sprint_loop", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_1FB4, undefined);
  scripts\asm\asm::_id_2374("grab_zombie_piece_while_moving", scripts\asm\zombie_brute\zombie_brute_asm::_id_D48E, undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_8485, scripts\asm\zombie_brute\zombie_brute_asm::_id_116EB, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("run_loop", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_1FB4, undefined);
  scripts\asm\asm::_id_2374("laser_attack", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("laser_attack_prep", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2375("idle_combat", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_9E70, undefined);
  scripts\asm\asm::_id_2374("aimset_laser", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("laser_attack_idle", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("idle_combat", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_9E70, undefined);
  scripts\asm\asm::_id_2375("laser_attack_shoot", undefined, scripts\asm\zombie_brute\zombie_brute_asm::canseethroughfoliage, undefined);
  scripts\asm\asm::_id_2374("laser_attack_shoot", scripts\asm\zombie_brute\zombie_brute_asm::_id_58E5, undefined, undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_116F8, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("idle_combat", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_9E70, undefined);
  scripts\asm\asm::_id_2375("laser_attack_idle", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_100A0, undefined);
  scripts\asm\asm::_id_2374("laser_attack_prep", scripts\asm\zombie_brute\zombie_brute_asm::_id_D4BB, undefined, undefined, scripts\asm\zombie_brute\zombie_brute_asm::terminatelaserattackprep, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("laser_attack_decide", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_1FB4, undefined);
  scripts\asm\asm::_id_2374("laser_attack_decide", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("laser_attack_shoot", undefined, scripts\asm\zombie_brute\zombie_brute_asm::canseethroughfoliage, undefined);
  scripts\asm\asm::_id_2375("laser_attack_idle", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("helmet_remove", scripts\asm\zombie_brute\zombie_brute_asm::_id_D499, undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_8E15, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("choose_movetype", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_1FB4, undefined);
  scripts\asm\asm::_id_2375("choose_movetype", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("helmet_place", scripts\asm\zombie_brute\zombie_brute_asm::_id_D498, undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_8E15, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("choose_idle", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_1FB4, undefined);
  scripts\asm\asm::_id_2375("choose_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("attack_stand_2_hit", scripts\asm\zombie\melee::_id_CC64, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("melee_done", 0, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("attack_walk", scripts\asm\zombie\melee::_id_D4DC, undefined, undefined, undefined, undefined, scripts\asm\zombie\melee::_id_3EB9, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("melee_done", 0, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("attack_run", scripts\asm\zombie\melee::_id_D4DC, undefined, undefined, undefined, undefined, scripts\asm\zombie\melee::_id_3EB9, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("melee_done", 0, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("attack_sprint", scripts\asm\zombie\melee::_id_D4DC, undefined, undefined, undefined, undefined, scripts\asm\zombie\melee::_id_3EB9, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("melee_done", 0, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("melee", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("attack_slam", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_10055, undefined);
  scripts\asm\asm::_id_2375("melee_move", undefined, ::_id_122A2, undefined);
  scripts\asm\asm::_id_2375("choose_num_melee_hits", undefined, ::_id_1229E, undefined);
  scripts\asm\asm::_id_2374("melee_move", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("attack_run_2_hit", undefined, ::_id_1227B, undefined);
  scripts\asm\asm::_id_2375("attack_walk", undefined, ::_id_12283, undefined);
  scripts\asm\asm::_id_2375("attack_run", undefined, ::_id_12276, undefined);
  scripts\asm\asm::_id_2375("attack_sprint", undefined, ::_id_1227D, undefined);
  scripts\asm\asm::_id_2374("melee_done", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("choose_idle", undefined, scripts\asm\zombie\zombie::_id_13F9B, undefined);
  scripts\asm\asm::_id_2374("choose_num_melee_hits", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("attack_stand_2_hit", undefined, ::_id_11BEF, undefined);
  scripts\asm\asm::_id_2375("attack_stand", undefined, ::_id_11BEE, undefined);
  scripts\asm\asm::_id_2374("attack_stand", scripts\asm\zombie\melee::_id_D539, undefined, undefined, undefined, undefined, scripts\asm\zombie\melee::_id_3EB9, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("melee_done", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("attack_run_2_hit", scripts\asm\zombie\melee::_id_CC64, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("melee_done", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("attack_slam", scripts\asm\zombie_brute\zombie_brute_asm::_id_D51C, undefined, undefined, undefined, undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_3EFA, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("melee_done", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("attack_swipe", scripts\asm\zombie_brute\zombie_brute_asm::_id_D51C, undefined, undefined, undefined, undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_3EFA, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("melee_done", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("choose_movetype", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("sprint_loop", undefined, ::_id_11BE1, undefined);
  scripts\asm\asm::_id_2375("run_loop", undefined, ::_id_11BDA, undefined);
  scripts\asm\asm::_id_2374("run_loop", scripts\asm\zombie\zombie::_id_D4E3, undefined, undefined, undefined, undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_3EC1, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::_id_2375("enter_duck_move", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_1003B, undefined);
  scripts\asm\asm::_id_2375("to_take_helmet_off", undefined, scripts\asm\zombie_brute\zombie_brute_asm::shouldreloadwhilemoving, undefined);
  scripts\asm\asm::_id_2375("choose_movetype", undefined, ::_id_12437, undefined);
  scripts\asm\asm::_id_2375("run_stop", undefined, scripts\asm\zombie\zombie::_id_10092, undefined);
  scripts\asm\asm::_id_2375("to_melee", undefined, ::_id_1245A, undefined);
  scripts\asm\asm::_id_2375("run_turn", undefined, _id_0F3B::_id_FFF8, "run_turn");
  scripts\asm\asm::_id_2375("choose_idle_exit", undefined, ::_id_1242F, undefined);
  scripts\asm\asm::_id_2375("attack_slam", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_FFE2, undefined);
  scripts\asm\asm::_id_2375("move_done", undefined, ::_id_12448, undefined);
  scripts\asm\asm::_id_2375("throw_zombie_piece_while_moving", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_100AC, undefined);
  scripts\asm\asm::_id_2375("grab_zombie_piece_while_moving", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_1001D, undefined);
  scripts\asm\asm::_id_2375("laser_attack", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_FFF1, undefined);
  scripts\asm\asm::_id_2374("sprint_loop", scripts\asm\zombie\zombie::_id_D4E3, undefined, undefined, undefined, undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_3EC1, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::_id_2375("enter_duck_move", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_1003B, undefined);
  scripts\asm\asm::_id_2375("throw_zombie_piece_while_moving", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_100AC, undefined);
  scripts\asm\asm::_id_2375("laser_attack", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_FFF1, undefined);
  scripts\asm\asm::_id_2375("choose_movetype", undefined, ::_id_124F6, undefined);
  scripts\asm\asm::_id_2375("to_put_helmet_on", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_10063, undefined);
  scripts\asm\asm::_id_2375("sprint_stop", undefined, scripts\asm\zombie\zombie::_id_10092, undefined);
  scripts\asm\asm::_id_2375("sprint_turn", undefined, _id_0F3B::_id_FFF8, "sprint_turn");
  scripts\asm\asm::_id_2375("move_done", undefined, ::_id_1250A, undefined);
  scripts\asm\asm::_id_2375("to_melee", undefined, ::_id_12530, undefined);
  scripts\asm\asm::_id_2375("attack_slam", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_FFE2, undefined);
  scripts\asm\asm::_id_2374("run_stop", scripts\asm\zombie\zombie::_id_CEAE, undefined, undefined, undefined, undefined, _id_0F3A::_id_3E97, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("to_take_helmet_off", undefined, scripts\asm\zombie_brute\zombie_brute_asm::shouldreloadwhilemoving, undefined);
  scripts\asm\asm::_id_2375("run_loop", undefined, scripts\asm\asm::_id_68B0, "abort");
  scripts\asm\asm::_id_2375("move_done", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2375("to_melee", undefined, ::_id_1246B, undefined);
  scripts\asm\asm::_id_2374("sprint_stop", scripts\asm\zombie\zombie::_id_CEAE, undefined, undefined, undefined, undefined, _id_0F3A::_id_3E97, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("to_put_helmet_on", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_10063, undefined);
  scripts\asm\asm::_id_2375("sprint_loop", undefined, scripts\asm\asm::_id_68B0, "abort");
  scripts\asm\asm::_id_2375("move_done", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2375("to_melee", undefined, ::_id_1253D, undefined);
  scripts\asm\asm::_id_2374("move_done", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("choose_idle", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("run_turn", scripts\asm\zombie\zombie::_id_D515, undefined, undefined, undefined, undefined, _id_0F3B::_id_3EF5, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("to_take_helmet_off", undefined, scripts\asm\zombie_brute\zombie_brute_asm::shouldreloadwhilemoving, undefined);
  scripts\asm\asm::_id_2375("to_melee", undefined, ::_id_12480, undefined);
  scripts\asm\asm::_id_2375("run_loop", undefined, scripts\asm\asm::_id_68B0, "code_move");
  scripts\asm\asm::_id_2375("run_loop", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("sprint_turn", scripts\asm\zombie\zombie::_id_D538, undefined, undefined, undefined, undefined, _id_0F3B::_id_3EF5, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("to_put_helmet_on", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_10063, undefined);
  scripts\asm\asm::_id_2375("to_melee", undefined, ::_id_1254F, undefined);
  scripts\asm\asm::_id_2375("sprint_loop", undefined, scripts\asm\asm::_id_68B0, "code_move");
  scripts\asm\asm::_id_2375("sprint_loop", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("choose_idle_exit", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("idle_exit_sprint", undefined, ::_id_11BA9, undefined);
  scripts\asm\asm::_id_2375("idle_exit_run", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("idle_exit_run", scripts\asm\zombie\zombie::_id_CEB7, undefined, undefined, undefined, undefined, _id_0F3B::_id_3E9F, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("run_loop", undefined, scripts\asm\asm::_id_68B0, "code_move");
  scripts\asm\asm::_id_2375("run_loop", undefined, scripts\asm\asm::_id_68B0, "finish");
  scripts\asm\asm::_id_2374("idle_exit_sprint", scripts\asm\zombie\zombie::_id_CEB7, undefined, undefined, undefined, undefined, _id_0F3B::_id_3E9F, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("sprint_loop", undefined, scripts\asm\asm::_id_68B0, "code_move");
  scripts\asm\asm::_id_2375("sprint_loop", undefined, scripts\asm\asm::_id_68B0, "finish");
  scripts\asm\asm::_id_2374("to_melee", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("melee", undefined, ::_id_125D1, undefined);
  scripts\asm\asm::_id_2374("to_put_helmet_on", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("helmet_place", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_10063, undefined);
  scripts\asm\asm::_id_2374("to_take_helmet_off", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("helmet_remove", undefined, scripts\asm\zombie_brute\zombie_brute_asm::shouldreloadwhilemoving, undefined);
  scripts\asm\asm::_id_2374("duck_move", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_3EC2, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::_id_2375("to_exit_duck_move", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("enter_duck_move", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_3EC2, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("should_keep_crouched", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exit_duck_move", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_3EC2, undefined, undefined, undefined, undefined, undefined, "brute_pain", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("move_done", undefined, scripts\asm\zombie\zombie::_id_9EAB, undefined);
  scripts\asm\asm::_id_2375("to_take_helmet_off", undefined, scripts\asm\zombie_brute\zombie_brute_asm::shouldreloadwhilemoving, undefined);
  scripts\asm\asm::_id_2375("to_put_helmet_on", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_10063, undefined);
  scripts\asm\asm::_id_2375("to_melee", undefined, scripts\asm\zombie\melee::_id_138E4, undefined);
  scripts\asm\asm::_id_2375("anim_ended", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("to_exit_duck_move", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("duck_move", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_1003B, undefined);
  scripts\asm\asm::_id_2375("exit_duck_move", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("should_keep_crouched", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("duck_move", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_1003B, undefined);
  scripts\asm\asm::_id_2375("exit_duck_move", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("to_run", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("run_stop", undefined, scripts\asm\zombie\zombie::_id_10092, undefined);
  scripts\asm\asm::_id_2375("run_turn", undefined, _id_0F3B::_id_FFF8, "run_turn");
  scripts\asm\asm::_id_2375("run_loop", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("to_sprint", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("sprint_stop", undefined, scripts\asm\zombie\zombie::_id_10092, undefined);
  scripts\asm\asm::_id_2375("sprint_loop", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2375("sprint_turn", undefined, _id_0F3B::_id_FFF8, "sprint_turn");
  scripts\asm\asm::_id_2374("anim_ended", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("to_run", undefined, scripts\asm\zombie\zombie::_id_BE99, undefined);
  scripts\asm\asm::_id_2375("to_sprint", undefined, scripts\asm\zombie\zombie::_id_BE9A, undefined);
  scripts\asm\asm::_id_2374("brute_intro", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("choose_idle", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("death_generic", _id_0C71::_id_CF0E, undefined, undefined, undefined, undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_3EC0, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2374("death_moving", _id_0C71::_id_CF0E, undefined, undefined, undefined, undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_3EC0, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2374("death_crawling", _id_0C71::_id_CF0E, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2374("brute_pain", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("croc_chomp_enter", undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_FFEB, undefined);
  scripts\asm\asm::_id_2375("choose_movetype", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("croc_chomp_exit", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_3EC9, "croc_chomp_exit", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("choose_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("croc_chomp_enter", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, scripts\asm\zombie_brute\zombie_brute_asm::_id_3EC9, "croc_chomp_enter", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("croc_chomp_exit", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("croc_chomp_loop", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("wall_over_40", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "wall_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("traverse_external", scripts\asm\zombie\zombie::_id_D563, undefined, undefined, undefined, "choose_movetype", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jumpdown_130", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_down_slow", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_down_40", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jumpdown_80", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_across_100", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "jumpacross", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_across_196", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_down_fast", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie_brute\zombie_brute_asm::_id_3EC3, "jump_down_fast", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("step_over_40", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("window_over_36", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("step_up_40", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("nonboost_jump_up_120", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("boost_jump_up", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_across_100_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "jumpacross", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("wall_over_40_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "wall_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_down_slow_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_down_40_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("step_over_40_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("window_over_36_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("step_up_40_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("nonboost_jump_up_120_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("boost_jump_up_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_across_196_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_up_40", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jumpup_120", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_across", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_down", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_across_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_up_40_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jumpup_120_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_down_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("mantle_40_over_extended", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("mantle_40_over_extended_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_down_128_out_50", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "jump_down_128_out_50", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_down_128_out_50_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "jump_down_128_out_50", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_down_56_out_50", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "jump_down_56_out_50", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_down_56_out_50_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "jump_down_56_out_50", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_up_56", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "jump_up_56", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_up_56_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "jump_up_56", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_down_128", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "jump_down_128", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_down_128_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "jump_down_128", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_down_56", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "jump_down_56", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_down_56_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "jump_down_56", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_up_128", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie_brute\zombie_brute_asm::_id_3EC3, "jump_up_128", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_up_128_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie_brute\zombie_brute_asm::_id_3EC3, "jump_up_128", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_up_128_over_40", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "jump_up_128_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_up_56_over_40", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "jump_up_56_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_over_30_out_30_down_48", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "jump_over_30_out_30_down_48", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_over_30_out_30_down_48_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "jump_over_30_out_30_down_48", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_up_128_over_40_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "jump_up_128_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_up_56_over_40_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "jump_up_56_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("over_40_down_128", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "over_40_down_128", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("over_40_down_56", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "over_40_down_56", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("over_40_down_128_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "over_40_down_128", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("over_40_down_56_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "over_40_down_56", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_down_384", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "jump_down_384", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_down_384_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "jump_down_384", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("window_over_40", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "window_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("window_over_40_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "window_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("window_over_40_extended", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "window_over_40_extended", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("window_over_40_extended_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "window_over_extended_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("window_over_40_left", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "window_over_40_left", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("window_over_40_left_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "window_over_40_left", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("window_over_40_left_extended", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "window_over_40_left_extended", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("window_over_40_left_extended_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "window_over_40_left_extended", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("window_over_40_right", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "window_over_40_right", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("window_over_40_right_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "window_over_40_right", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("window_over_40_right_extended", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "window_over_40_right_extended", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("window_over_40_right_extended_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "window_over_40_right_extended", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_up_128_over_40_out_30", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "jump_up_128_over_40_out_30", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_up_128_over_40_out_30_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::_id_3F08, "jump_up_128_over_40_out_30", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_down_fast_norestart", scripts\asm\zombie\zombie::_id_D567, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie_brute\zombie_brute_asm::_id_3EC3, "jump_down_fast", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2327();
}

_id_12253(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::_id_138E4();
}

_id_1223F(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

_id_1224F(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_isincombat();
}

_id_11BB9(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

_id_11BBE(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_isincombat();
}

_id_12210(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::_id_138E4();
}

_id_12207(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

_id_122A2(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::_id_138E1();
}

_id_1229E(var_0, var_1, var_2, var_3) {
  return 1;
}

_id_1227B(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::shouldplayarenaintro();
}

_id_12283(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("walk");
}

_id_12276(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("run");
}

_id_1227D(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("sprint");
}

_id_11BEF(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::shouldplayarenaintro();
}

_id_11BEE(var_0, var_1, var_2, var_3) {
  return 1;
}

_id_11BE1(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::_id_BE9A();
}

_id_11BDA(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("run");
}

_id_12437(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::_id_BCCD();
}

_id_1245A(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::_id_138E4();
}

_id_1242F(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::_id_A013();
}

_id_12448(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

_id_124F6(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::_id_BCCD();
}

_id_1250A(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

_id_12530(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::_id_138E4();
}

_id_1246B(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::_id_138E4();
}

_id_1253D(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::_id_138E4();
}

_id_12480(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::_id_138E4();
}

_id_1254F(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::_id_138E4();
}

_id_11BA9(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::_id_BE9A();
}

_id_125D1(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::_id_138E4();
}