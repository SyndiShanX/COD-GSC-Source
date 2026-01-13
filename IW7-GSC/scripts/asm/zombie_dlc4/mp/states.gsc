/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\asm\zombie_dlc4\mp\states.gsc
*************************************************/

func_2371() {
  if(scripts\asm\asm::func_232E("zombie_dlc4")) {
    return;
  }

  scripts\asm\asm::func_230B("zombie_dlc4", "zombiestart");
  scripts\asm\asm::func_2374("zombiestart", scripts\asm\zombie\zombie::func_13F9A, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("choose_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("idle", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("suicide_bomber_checks", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("traverse_window", undefined, ::scripts\asm\zombie\zombie::func_BE94, undefined);
  scripts\asm\asm::func_2375("play_melee_anim", undefined, ::scripts\asm\zombie\zombie::func_BE95, undefined);
  scripts\asm\asm::func_2375("moveto_window_done", undefined, ::scripts\asm\zombie\zombie::func_DD1E, undefined);
  scripts\asm\asm::func_2375("zapper_sequence", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2375("waiting", undefined, ::scripts\asm\zombie\zombie::func_9FF5, undefined);
  scripts\asm\asm::func_2375("disco_fever", undefined, ::scripts\asm\zombie_dlc4\zombie_dlc4::hasdiscofever, undefined);
  scripts\asm\asm::func_2375("melee", undefined, ::trans_idle_to_melee7, undefined);
  scripts\asm\asm::func_2375("boombox", undefined, ::scripts\asm\zombie\zombie::func_6BC6, undefined);
  scripts\asm\asm::func_2375("choose_idle_exit", undefined, ::trans_idle_to_choose_idle_exit9, undefined);
  scripts\asm\asm::func_2375("frozen_idle", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2374("choose_idle", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("zapper_sequence", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2375("boombox", undefined, ::scripts\asm\zombie\zombie::func_6BC6, undefined);
  scripts\asm\asm::func_2375("play_spawn_fx", undefined, ::func_11BCA, undefined);
  scripts\asm\asm::func_2375("play_vignette_anim", undefined, ::func_11BCE, undefined);
  scripts\asm\asm::func_2375("choose_idle_exit", undefined, ::func_11BBB, undefined);
  scripts\asm\asm::func_2375("idle_crawl", undefined, ::func_11BC6, undefined);
  scripts\asm\asm::func_2375("idle_combat", undefined, ::func_11BC1, undefined);
  scripts\asm\asm::func_2375("idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("idle_combat", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face goal", "anim deltas", undefined);
  scripts\asm\asm::func_2375("suicide_bomber_checks", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("boombox", undefined, ::scripts\asm\zombie\zombie::func_6BC6, undefined);
  scripts\asm\asm::func_2375("traverse_window", undefined, ::scripts\asm\zombie\zombie::func_BE94, undefined);
  scripts\asm\asm::func_2375("play_melee_anim", undefined, ::scripts\asm\zombie\zombie::func_BE95, undefined);
  scripts\asm\asm::func_2375("moveto_window_done", undefined, ::scripts\asm\zombie\zombie::func_DD1E, undefined);
  scripts\asm\asm::func_2375("choose_idle", undefined, ::func_12203, undefined);
  scripts\asm\asm::func_2375("choose_idle", undefined, ::func_12204, undefined);
  scripts\asm\asm::func_2375("waiting", undefined, ::scripts\asm\zombie\zombie::func_9FF5, undefined);
  scripts\asm\asm::func_2375("choose_idle_exit", undefined, ::func_12208, undefined);
  scripts\asm\asm::func_2375("melee", undefined, ::func_12212, undefined);
  scripts\asm\asm::func_2375("frozen_idle", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2375("disco_fever", undefined, ::scripts\asm\zombie_dlc4\zombie_dlc4::hasdiscofever, undefined);
  scripts\asm\asm::func_2374("idle_crawl", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("suicide_bomber_checks", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("boombox", undefined, ::scripts\asm\zombie\zombie::func_6BC6, undefined);
  scripts\asm\asm::func_2375("traverse_window", undefined, ::scripts\asm\zombie\zombie::func_BE94, undefined);
  scripts\asm\asm::func_2375("moveto_window_done", undefined, ::scripts\asm\zombie\zombie::func_DD1E, undefined);
  scripts\asm\asm::func_2375("waiting", undefined, ::scripts\asm\zombie\zombie::func_9FF5, undefined);
  scripts\asm\asm::func_2375("idle_exit_crawl", undefined, ::func_1221D, undefined);
  scripts\asm\asm::func_2375("melee", undefined, ::func_12222, undefined);
  scripts\asm\asm::func_2375("frozen_idle", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2374("frozen_idle", scripts\asm\zombie\zombie::func_7389, undefined, undefined, ::scripts\asm\zombie\zombie::func_631D, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("choose_idle", undefined, ::scripts\asm\zombie\zombie::func_3E18, undefined);
  scripts\asm\asm::func_2374("play_vignette_anim", scripts\asm\zombie\zombie::func_D571, undefined, undefined, ::scripts\asm\zombie\zombie::func_11702, undefined, ::scripts\asm\zombie\zombie::func_3EFC, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("zapper_sequence", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::scripts\asm\zombie\zombie::func_1003A, undefined);
  scripts\asm\asm::func_2375("choose_idle", undefined, ::func_12405, undefined);
  scripts\asm\asm::func_2374("boombox", scripts\asm\zombie\zombie::func_CEF3, undefined, undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EBE, undefined, ["(none)"], undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("choose_idle", undefined, ::scripts\asm\zombie\zombie::isdoublejumpanimdone, undefined);
  scripts\asm\asm::func_2375("boombox_turn", undefined, ::scripts\asm\zombie\zombie::func_BE8D, undefined);
  scripts\asm\asm::func_2375("frozen_idle", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2374("boombox_turn", scripts\asm\zombie\zombie::func_CEF3, undefined, undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EBE, undefined, ["(none)"], undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("boombox", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("dismember", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("zapper_sequence", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2375("high_damage", undefined, ::func_120B5, undefined);
  scripts\asm\asm::func_2375("normal_damage", undefined, ::func_120B9, undefined);
  scripts\asm\asm::func_2374("right_arm", lib_0C72::func_CF1B, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("dismemberment_transition_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("dismember_interrupt", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("right_arm_highdamage", lib_0C72::func_CF1B, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("dismemberment_transition_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("dismember_interrupt", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("right_arm_walk", lib_0C72::func_CF1B, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("dismemberment_transition_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("dismember_interrupt", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("right_arm_run", lib_0C72::func_CF1B, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("dismemberment_transition_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("dismember_interrupt", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("right_arm_walk_highdamage", lib_0C72::func_CF1B, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("dismemberment_transition_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("right_arm_run_highdamage", lib_0C72::func_CF1B, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("dismemberment_transition_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("dismember_interrupt", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("left_arm", lib_0C72::func_CF1B, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("dismemberment_transition_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("dismember_interrupt", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("left_arm_highdamage", lib_0C72::func_CF1B, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("dismemberment_transition_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("dismember_interrupt", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("left_arm_walk", lib_0C72::func_CF1B, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("dismemberment_transition_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("dismember_interrupt", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("left_arm_run", lib_0C72::func_CF1B, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("dismemberment_transition_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("dismember_interrupt", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("left_arm_walk_highdamage", lib_0C72::func_CF1B, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("dismemberment_transition_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("dismember_interrupt", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("left_arm_run_highdamage", lib_0C72::func_CF1B, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("dismemberment_transition_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("dismember_interrupt", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("left_leg", lib_0C72::func_CF1B, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("dismemberment_transition_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("left_leg_run", lib_0C72::func_CF1B, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("dismemberment_transition_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("left_leg_walk_highdamage", lib_0C72::func_CF1B, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("dismemberment_transition_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("left_leg_highdamage", lib_0C72::func_CF1B, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("dismemberment_transition_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("left_leg_walk", lib_0C72::func_CF1B, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("dismemberment_transition_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("right_leg", lib_0C72::func_CF1B, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("dismemberment_transition_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("right_leg_highdamage", lib_0C72::func_CF1B, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("dismemberment_transition_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("right_leg_walk", lib_0C72::func_CF1B, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("dismemberment_transition_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("right_leg_run", lib_0C72::func_CF1B, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("dismemberment_transition_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("right_leg_walk_highdamage", lib_0C72::func_CF1B, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("dismemberment_transition_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("right_leg_run_highdamage", lib_0C72::func_CF1B, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("dismemberment_transition_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("high_damage", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("both_legs_highdamage", undefined, ::func_121B4, undefined);
  scripts\asm\asm::func_2375("right_arm_walk_highdamage", undefined, ::func_121EA, undefined);
  scripts\asm\asm::func_2375("right_arm_walk_highdamage", undefined, ::func_121EB, undefined);
  scripts\asm\asm::func_2375("right_arm_run_highdamage", undefined, ::func_121E3, undefined);
  scripts\asm\asm::func_2375("right_arm_run_highdamage", undefined, ::func_121E4, undefined);
  scripts\asm\asm::func_2375("right_leg_walk_highdamage", undefined, ::func_121FE, undefined);
  scripts\asm\asm::func_2375("right_leg_walk_highdamage", undefined, ::func_121FF, undefined);
  scripts\asm\asm::func_2375("right_leg_run_highdamage", undefined, ::func_121F6, undefined);
  scripts\asm\asm::func_2375("right_leg_run_highdamage", undefined, ::func_121F7, undefined);
  scripts\asm\asm::func_2375("left_leg_run_highdamage", undefined, ::func_121D0, undefined);
  scripts\asm\asm::func_2375("left_leg_run_highdamage", undefined, ::func_121D1, undefined);
  scripts\asm\asm::func_2375("left_leg_walk_highdamage", undefined, ::func_121D8, undefined);
  scripts\asm\asm::func_2375("left_leg_walk_highdamage", undefined, ::func_121D9, undefined);
  scripts\asm\asm::func_2375("left_arm_run_highdamage", undefined, ::func_121BE, undefined);
  scripts\asm\asm::func_2375("left_arm_run_highdamage", undefined, ::func_121BF, undefined);
  scripts\asm\asm::func_2375("left_arm_walk_highdamage", undefined, ::func_121C4, undefined);
  scripts\asm\asm::func_2375("left_arm_walk_highdamage", undefined, ::func_121C5, undefined);
  scripts\asm\asm::func_2375("right_arm_highdamage", undefined, ::func_121DE, undefined);
  scripts\asm\asm::func_2375("right_leg_highdamage", undefined, ::func_121F0, undefined);
  scripts\asm\asm::func_2375("left_leg_highdamage", undefined, ::func_121CA, undefined);
  scripts\asm\asm::func_2375("left_arm_highdamage", undefined, ::func_121B9, undefined);
  scripts\asm\asm::func_2374("left_leg_run_highdamage", lib_0C72::func_CF1B, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("dismemberment_transition_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("normal_damage", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("both_legs", undefined, ::func_122F3, undefined);
  scripts\asm\asm::func_2375("right_arm_walk", undefined, ::func_12329, undefined);
  scripts\asm\asm::func_2375("right_arm_walk", undefined, ::func_1232A, undefined);
  scripts\asm\asm::func_2375("right_arm_run", undefined, ::func_12322, undefined);
  scripts\asm\asm::func_2375("right_arm_run", undefined, ::func_12323, undefined);
  scripts\asm\asm::func_2375("right_leg_walk", undefined, ::func_1233D, undefined);
  scripts\asm\asm::func_2375("right_leg_walk", undefined, ::func_1233E, undefined);
  scripts\asm\asm::func_2375("right_leg_run", undefined, ::func_12335, undefined);
  scripts\asm\asm::func_2375("right_leg_run", undefined, ::func_12336, undefined);
  scripts\asm\asm::func_2375("left_arm_walk", undefined, ::func_12303, undefined);
  scripts\asm\asm::func_2375("left_arm_walk", undefined, ::func_12304, undefined);
  scripts\asm\asm::func_2375("left_arm_run", undefined, ::func_122FD, undefined);
  scripts\asm\asm::func_2375("left_arm_run", undefined, ::func_122FE, undefined);
  scripts\asm\asm::func_2375("left_leg_walk", undefined, ::func_12317, undefined);
  scripts\asm\asm::func_2375("left_leg_walk", undefined, ::func_12318, undefined);
  scripts\asm\asm::func_2375("left_leg_run", undefined, ::func_1230F, undefined);
  scripts\asm\asm::func_2375("left_leg_run", undefined, ::func_12310, undefined);
  scripts\asm\asm::func_2375("right_leg", undefined, ::func_1232F, undefined);
  scripts\asm\asm::func_2375("right_arm", undefined, ::func_1231D, undefined);
  scripts\asm\asm::func_2375("left_leg", undefined, ::func_12309, undefined);
  scripts\asm\asm::func_2375("left_arm", undefined, ::func_122F8, undefined);
  scripts\asm\asm::func_2374("both_legs_highdamage", lib_0C72::func_CF1B, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("dismemberment_transition_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("both_legs", lib_0C72::func_CF1B, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("dismemberment_transition_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("dismemberment_transition_done", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("choose_idle", 0, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("dismember_interrupt", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("melee", undefined, ::func_1208A, undefined);
  scripts\asm\asm::func_2374("pain_stand", scripts\asm\zombie\zombie::func_D4F5, undefined, undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EF1, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("pain_stand_freeze_check", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("choose_idle", 0, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("pain_interrupt", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pain_stand_lower", scripts\asm\zombie\zombie::func_D4F5, undefined, undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EF1, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("pain_stand_freeze_check", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("choose_idle", 0, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("pain_interrupt", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pain_stand_head", scripts\asm\zombie\zombie::func_D4F5, undefined, undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EF1, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("pain_stand_freeze_check", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("choose_idle", 0, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("frozen_idle", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2375("pain_interrupt", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pain_walk", scripts\asm\zombie\zombie::func_D4F5, undefined, undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EF1, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pain_walk_freeze_check", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("pain_interrupt", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pain_walk_lower", scripts\asm\zombie\zombie::func_D4F5, undefined, undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EF1, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pain_walk_freeze_check", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("pain_interrupt", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pain_run", scripts\asm\zombie\zombie::func_D4F5, undefined, undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EF1, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pain_run_freeze_check", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("pain_interrupt", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pain_run_lower", scripts\asm\zombie\zombie::func_D4F5, undefined, undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EF1, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pain_run_freeze_check", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("pain_interrupt", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pain_sprint", scripts\asm\zombie\zombie::func_D4F5, undefined, undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EF1, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pain_sprint_freeze_check", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("pain_interrupt", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pain_sprint_lower", scripts\asm\zombie\zombie::func_D4F5, undefined, undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EF1, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pain_sprint_freeze_check", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("pain_interrupt", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pain_knockback_front", scripts\asm\zombie\zombie::func_D4F5, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("choose_idle", 0, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("pain_knockback_left", scripts\asm\zombie\zombie::func_D4F5, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("choose_idle", 0, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("pain_knockback_right", scripts\asm\zombie\zombie::func_D4F5, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("choose_idle", 0, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("pain_knockback_back", scripts\asm\zombie\zombie::func_D4F5, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("choose_idle", 0, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("pain_generic", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("pain_to_zapper_sequence", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2375("pain_crawl", undefined, ::func_12379, undefined);
  scripts\asm\asm::func_2375("pain_stand_head", undefined, ::func_12385, undefined);
  scripts\asm\asm::func_2375("pain_stand_lower", undefined, ::func_1238B, undefined);
  scripts\asm\asm::func_2375("pain_stand", undefined, ::func_1237F, undefined);
  scripts\asm\asm::func_2374("pain_moving", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("pain_to_zapper_sequence", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2375("pain_crawl", undefined, ::func_123B7, undefined);
  scripts\asm\asm::func_2375("pain_moving_nostop", undefined, ::func_123BD, undefined);
  scripts\asm\asm::func_2375("pain_stand_head", undefined, ::func_123C9, undefined);
  scripts\asm\asm::func_2375("pain_stand", undefined, ::func_123C3, undefined);
  scripts\asm\asm::func_2374("pain_moving_nostop", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("pain_sprint_lower", undefined, ::func_123A4, undefined);
  scripts\asm\asm::func_2375("pain_sprint", undefined, ::func_1239E, undefined);
  scripts\asm\asm::func_2375("pain_run_lower", undefined, ::func_12399, undefined);
  scripts\asm\asm::func_2375("pain_run", undefined, ::func_12392, undefined);
  scripts\asm\asm::func_2375("pain_walk", undefined, ::func_123AA, undefined);
  scripts\asm\asm::func_2375("pain_walk", undefined, ::func_123AB, undefined);
  scripts\asm\asm::func_2374("pain_crawl", scripts\asm\zombie\zombie::func_D4F5, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("pain_crawl_freeze_check", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pain_interrupt", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("pain_to_zapper_sequence", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2375("melee", undefined, ::scripts\asm\zombie\zombie::func_1002F, undefined);
  scripts\asm\asm::func_2374("pain_moving_shamble", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("pain_to_zapper_sequence", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2375("pain_crawl", undefined, ::func_123B4, undefined);
  scripts\asm\asm::func_2375("pain_stand", undefined, ::func_123B5, undefined);
  scripts\asm\asm::func_2375("pain_shamble_left", 0.1, ::scripts\asm\zombie\zombie::func_9DB2, undefined);
  scripts\asm\asm::func_2375("pain_shamble_right", 0.1, ::scripts\asm\zombie\zombie::func_9DB3, undefined);
  scripts\asm\asm::func_2375("pain_shamble_head", 0.1, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pain_shamble_head", scripts\asm\zombie\zombie::func_D4F3, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("pain_interrupt", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pain_shamble_left", scripts\asm\zombie\zombie::func_D4F3, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("pain_interrupt", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pain_shamble_right", scripts\asm\zombie\zombie::func_D4F3, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("pain_interrupt", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pain_moving_walk", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("pain_to_zapper_sequence", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2375("pain_crawl", undefined, ::func_123CE, undefined);
  scripts\asm\asm::func_2375("pain_stand", undefined, ::func_123CF, undefined);
  scripts\asm\asm::func_2375("pain_walk_left", 0.1, ::scripts\asm\zombie\zombie::func_9DB2, undefined);
  scripts\asm\asm::func_2375("pain_walk_right", 0.1, ::scripts\asm\zombie\zombie::func_9DB3, undefined);
  scripts\asm\asm::func_2375("pain_walk_head", 0.1, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pain_walk_head", scripts\asm\zombie\zombie::func_D4F3, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("pain_interrupt", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pain_walk_left", scripts\asm\zombie\zombie::func_D4F3, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("pain_interrupt", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pain_walk_right", scripts\asm\zombie\zombie::func_D4F3, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("pain_interrupt", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pain_to_zapper_sequence", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", 1);
  scripts\asm\asm::func_2375("zapper_sequence", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2374("pain_stand_freeze_check", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("frozen_idle", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2374("pain_walk_freeze_check", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("frozen_walk", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2374("pain_run_freeze_check", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("frozen_run", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2374("pain_sprint_freeze_check", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("frozen_sprint", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2374("pain_crawl_freeze_check", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("frozen_crawl", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2374("death_normal", lib_0C71::func_CF0E, undefined, undefined, undefined, undefined, ::scripts\asm\zombie_dlc4\zombie_dlc4::choosestandingdeathanim_dlc, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2374("death_moving_normal", lib_0C71::func_CF0E, undefined, undefined, undefined, undefined, ::scripts\asm\zombie_dlc4\zombie_dlc4::choosemovingdeathanim_dlc, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2374("death_crawling", lib_0C71::func_CF0E, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2374("death_generic", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("death_normal", undefined, ::trans_death_generic_to_death_normal0, undefined);
  scripts\asm\asm::func_2375("death_kungfu", undefined, ::trans_death_generic_to_death_kungfu1, undefined);
  scripts\asm\asm::func_2375("death_normal", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("death_kungfu", lib_0C71::func_CF0E, undefined, undefined, undefined, undefined, ::scripts\asm\zombie_dlc4\zombie_dlc4::choosestandingdeathanim_dlc, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2374("death_moving", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("death_moving_normal", undefined, ::trans_death_moving_to_death_moving_normal0, undefined);
  scripts\asm\asm::func_2375("death_kungfu", undefined, ::trans_death_moving_to_death_kungfu1, undefined);
  scripts\asm\asm::func_2375("death_moving_normal", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("wall_over_40", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "wall_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_jump_up_40", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("traverse_external", scripts\asm\zombie\zombie::func_D563, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jumpdown_130", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_down_slow", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_jumpup_120", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_down_40", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jumpdown_80", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_across_100", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "jumpacross", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_across_196", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_down_fast", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("step_over_40", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("window_over_36", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("step_up_40", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("nonboost_jump_up_120", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("boost_jump_up", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_jump_across", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_jump_down", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_wall_over_40", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "wall_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_jump_down_slow", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_jump_down_40", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_jump_across_100", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "jumpacross", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_jump_across_196", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_jump_down_fast", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_step_over_40", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_window_over_36", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_step_up_40", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_nonboost_jump_up_120", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_boost_jump_up", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_up_40", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jumpup_120", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_across", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_down", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("mantle_40_over_extended", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "mantle_40_over_extended", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_down_128_out_50", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "jump_down_128_out_50", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_down_56_out_50", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "jump_down_56_out_50", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_up_56", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "jump_up_56", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_down_128", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "jump_down_128", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_down_56", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "jump_down_56", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_up_128", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "jump_up_128", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_up_128_over_40", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "jump_up_128_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_up_56_over_40", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "jump_up_56_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_over_30_out_30_down_48", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "jump_over_30_out_30_down_48", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_jump_over_30_out_30_down_48", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "jump_over_30_out_30_down_48", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_jump_down_56_out_50", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "jump_down_56_out_50", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_mantle_40_over_extended", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_jump_down_128_out_50", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "jump_down_128_out_50", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_jump_up_56", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "jump_up_56", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_jump_up_128", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "jump_up_128", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_jump_down_128", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "jump_down_128", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_jump_down_56", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "jump_down_56", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_jump_up_128_over_40", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "jump_up_128_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_jump_up_56_over_40", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "jump_up_56_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("over_40_down_128", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "over_40_down_128", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("over_40_down_56", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "over_40_down_56", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_over_40_down_128", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "over_40_down_128", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_over_40_down_56", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "over_40_down_56", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_down_384", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "jump_down_384", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_jump_down_384", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "jump_down_384", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("window_over_40", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "window_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("window_over_40_extended", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "window_over_40_extended", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("window_over_40_left", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "window_over_40_left", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("window_over_40_left_extended", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "window_over_40_left_extended", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("window_over_40_right", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "window_over_40_right", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("window_over_40_right_extended", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "window_over_40_right_extended", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_window_over_40", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "window_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_window_over_40_extended", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "window_over_40_extended", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_window_over_40_left", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "window_over_40_left", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_window_over_40_left_extended", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "window_over_40_left_extended", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_window_over_40_right", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "window_over_40_right", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_window_over_40_right_extended", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "window_over_40_right_extended", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_up_128_over_40_out_30", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "jump_up_128_over_40_out_30", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_jump_up_128_over_40_out_30", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "jump_up_128_over_40_out_30", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("wall_over_40_flex", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "wall_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_wall_over_40_flex", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "wall_over_40", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("zipline", scripts\asm\zombie_dlc4\zipline_traversal::playtraversezipline, undefined, undefined, ::scripts\asm\zombie_dlc4\zipline_traversal::terminateziplineintro, undefined, ::scripts\asm\zombie_dlc4\zipline_traversal::chooseanimzipline, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("zipline_loop", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("zipline_loop", scripts\asm\zombie_dlc4\zipline_traversal::playtraverseziplineloop, undefined, undefined, ::scripts\asm\zombie_dlc4\zipline_traversal::terminateziplineloop, undefined, ::scripts\asm\zombie_dlc4\zipline_traversal::chooseanimzipline, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("zipline_drop", undefined, ::scripts\asm\asm::func_68B0, "loop_finished");
  scripts\asm\asm::func_2374("zipline_drop", scripts\asm\zombie_dlc4\zipline_traversal::playtraverseziplinedrop, undefined, undefined, ::scripts\asm\zombie_dlc4\zipline_traversal::terminatezipline, "choose_movetype", scripts\asm\zombie_dlc4\zipline_traversal::chooseanimzipline, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("over_88", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "over_88", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("crawling_over_88", scripts\asm\zombie_dlc4\zombie_dlc4::playtraverseanimz_dlc, undefined, undefined, undefined, "choose_movetype", scripts\asm\zombie\zombie::func_3F08, "over_88", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("attack_stand_2_hit", scripts\asm\zombie\melee::func_CC64, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("melee_done", 0, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("frozen_attack_stand", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2374("attack_walk", scripts\asm\zombie\melee::func_D4DC, undefined, undefined, undefined, undefined, ::scripts\asm\zombie\melee::func_3EB9, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("melee_done", 0, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("frozen_walk", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2374("attack_run", scripts\asm\zombie\melee::func_D4DC, undefined, undefined, undefined, undefined, ::scripts\asm\zombie\melee::func_3EB9, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("melee_done", 0, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("frozen_run", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2374("attack_sprint", scripts\asm\zombie\melee::func_D4DC, undefined, undefined, undefined, undefined, ::scripts\asm\zombie\melee::func_3EB9, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("melee_done", 0, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("frozen_sprint", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2374("attack_lunge_boost", scripts\asm\zombie\melee::func_D4C8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("melee_done", 0, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("attack_lunge_boost_norestart", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("melee", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("attack_lunge_boost_crawling", undefined, ::func_12294, undefined);
  scripts\asm\asm::func_2375("attack_crawling", undefined, ::func_1228A, undefined);
  scripts\asm\asm::func_2375("attack_lunge_boost", undefined, ::func_1228F, undefined);
  scripts\asm\asm::func_2375("melee_move", undefined, ::func_122A3, undefined);
  scripts\asm\asm::func_2375("choose_num_melee_hits", undefined, ::func_1229F, undefined);
  scripts\asm\asm::func_2374("melee_move", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("attack_run_2_hit", undefined, ::func_1227B, undefined);
  scripts\asm\asm::func_2375("attack_walk", undefined, ::func_12283, undefined);
  scripts\asm\asm::func_2375("attack_run", undefined, ::func_12276, undefined);
  scripts\asm\asm::func_2375("attack_sprint", undefined, ::func_1227D, undefined);
  scripts\asm\asm::func_2374("melee_done", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("choose_idle", undefined, ::scripts\asm\zombie\zombie::func_13F9B, undefined);
  scripts\asm\asm::func_2374("attack_crawling", scripts\asm\zombie\melee::func_D539, undefined, undefined, undefined, undefined, ::scripts\asm\zombie\melee::func_3EB9, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("melee_done", 0, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("frozen_attack_crawling", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2374("attack_lunge_boost_crawling", scripts\asm\zombie\melee::func_D4C8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("melee_done", 0, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("attack_lunge_boost_crawling_norestart", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("frozen_attack_crawling", scripts\asm\zombie\zombie::func_7389, undefined, undefined, ::scripts\asm\zombie\zombie::func_631D, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("melee_done", 0, ::func_1217D, undefined);
  scripts\asm\asm::func_2374("frozen_attack_stand", scripts\asm\zombie\zombie::func_7389, undefined, undefined, ::scripts\asm\zombie\zombie::func_631D, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("melee_done", 0, ::func_12181, undefined);
  scripts\asm\asm::func_2374("suicide_bomber_checks", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("attack_suicide_bomb", undefined, ::func_125CB, undefined);
  scripts\asm\asm::func_2375("transform_to_suicide_bomber", undefined, ::func_125CC, undefined);
  scripts\asm\asm::func_2374("attack_suicide_bomb", scripts\asm\zombie\melee::func_D543, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("choose_num_melee_hits", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("attack_stand_2_hit", undefined, ::func_11BEF, undefined);
  scripts\asm\asm::func_2375("attack_stand", undefined, ::func_11BEE, undefined);
  scripts\asm\asm::func_2374("attack_stand", scripts\asm\zombie\melee::func_D539, undefined, undefined, undefined, undefined, ::scripts\asm\zombie\melee::func_3EB9, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("melee_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("frozen_attack_stand", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2374("attack_run_2_hit", scripts\asm\zombie\melee::func_CC64, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("melee_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("choose_movetype", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("choose_crawl_type", undefined, ::func_11BD0, undefined);
  scripts\asm\asm::func_2375("pass_sprint_in", undefined, ::func_11BD8, undefined);
  scripts\asm\asm::func_2375("pass_walk_in", undefined, ::func_11BD9, undefined);
  scripts\asm\asm::func_2375("pass_run_in", undefined, ::func_11BD6, undefined);
  scripts\asm\asm::func_2375("pass_slow_walk_in", undefined, ::func_11BD7, undefined);
  scripts\asm\asm::func_2374("walk_loop", scripts\asm\zombie\zombie::func_D4E3, "walk", undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EE1, undefined, undefined, undefined, undefined, undefined, "pain_moving_walk", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pass_walk_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("run_loop", scripts\asm\zombie\zombie::func_D4E3, "run", undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EE1, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pass_run_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("sprint_loop", scripts\asm\zombie\zombie::func_D4E3, "sprint", undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EE1, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pass_sprint_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("idle_exit_walk", scripts\asm\zombie\zombie::func_CEB7, undefined, undefined, undefined, undefined, lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pass_walk_in", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("pass_walk_in", undefined, ::scripts\asm\asm::func_68B0, "finish");
  scripts\asm\asm::func_2375("frozen_walk", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2374("walk_stop", scripts\asm\zombie\zombie::func_CEAE, undefined, undefined, undefined, undefined, lib_0F3A::func_3E97, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("to_suicide_bomb", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("pass_walk_in", undefined, ::scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2375("move_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("to_melee", undefined, ::func_12616, undefined);
  scripts\asm\asm::func_2374("run_stop", scripts\asm\zombie\zombie::func_CEAE, undefined, undefined, undefined, undefined, lib_0F3A::func_3E97, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("to_suicide_bomb", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("pass_run_in", undefined, ::scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2375("move_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("to_melee", undefined, ::func_1246B, undefined);
  scripts\asm\asm::func_2374("sprint_stop", scripts\asm\zombie\zombie::func_CEAE, undefined, undefined, undefined, undefined, lib_0F3A::func_3E97, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("to_suicide_bomb", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("pass_sprint_in", undefined, ::scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2375("move_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("to_melee", undefined, ::func_1253D, undefined);
  scripts\asm\asm::func_2374("move_done", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("choose_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("walk_turn", scripts\asm\zombie\zombie::func_D515, undefined, undefined, undefined, undefined, lib_0F3B::func_3EF5, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("to_suicide_bomb", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("frozen_walk", undefined, ::scripts\asm\zombie\zombie::func_3E12, "walk_loop");
  scripts\asm\asm::func_2375("choose_idle_exit", undefined, ::func_12619, undefined);
  scripts\asm\asm::func_2375("to_melee", undefined, ::func_1262E, undefined);
  scripts\asm\asm::func_2375("pass_walk_in", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("pass_walk_in", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("run_turn", scripts\asm\zombie\zombie::func_D515, undefined, undefined, undefined, undefined, lib_0F3B::func_3EF5, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("frozen_run", undefined, ::scripts\asm\zombie\zombie::func_3E12, "run_loop");
  scripts\asm\asm::func_2375("to_suicide_bomb", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("to_melee", undefined, ::func_12481, undefined);
  scripts\asm\asm::func_2375("pass_run_in", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("pass_run_in", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("sprint_turn", scripts\asm\zombie\zombie::func_D538, undefined, undefined, undefined, undefined, lib_0F3B::func_3EF5, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("frozen_sprint", undefined, ::scripts\asm\zombie\zombie::func_3E12, "sprint_loop");
  scripts\asm\asm::func_2375("to_suicide_bomb", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("to_melee", undefined, ::func_12550, undefined);
  scripts\asm\asm::func_2375("pass_sprint_in", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("pass_sprint_in", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("choose_idle_exit", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("idle_exit_crawl", undefined, ::func_11B9B, undefined);
  scripts\asm\asm::func_2375("idle_exit_sprint", undefined, ::func_11BAA, undefined);
  scripts\asm\asm::func_2375("idle_exit_walk", undefined, ::func_11BAF, undefined);
  scripts\asm\asm::func_2375("idle_exit_run", undefined, ::func_11BA1, undefined);
  scripts\asm\asm::func_2375("idle_exit_slow_walk", undefined, ::func_11BA7, undefined);
  scripts\asm\asm::func_2374("idle_exit_run", scripts\asm\zombie\zombie::func_CEB7, undefined, undefined, undefined, undefined, lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("frozen_run", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2375("pass_run_in", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("pass_run_in", undefined, ::scripts\asm\asm::func_68B0, "finish");
  scripts\asm\asm::func_2374("idle_exit_sprint", scripts\asm\zombie\zombie::func_CEB7, undefined, undefined, undefined, undefined, lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("frozen_sprint", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2375("pass_sprint_in", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("pass_sprint_in", undefined, ::scripts\asm\asm::func_68B0, "finish");
  scripts\asm\asm::func_2374("slow_walk_crawl_loop", scripts\asm\zombie\zombie::func_D4E3, "slow_walk", undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("zapper_sequence", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2375("to_melee", undefined, ::trans_slow_walk_crawl_loop_to_to_melee1, undefined);
  scripts\asm\asm::func_2375("to_suicide_bomb", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("slow_walk_crawl_turn", undefined, lib_0F3B::func_FFF8, "crawl_turn");
  scripts\asm\asm::func_2375("crawl_stop", undefined, ::scripts\asm\zombie\zombie::func_10092, undefined);
  scripts\asm\asm::func_2375("move_done", undefined, ::trans_slow_walk_crawl_loop_to_move_done5, undefined);
  scripts\asm\asm::func_2375("frozen_crawl", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2374("slow_walk_crawl_turn", scripts\asm\zombie\zombie::func_D515, undefined, undefined, undefined, undefined, lib_0F3B::func_3EF5, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("zapper_sequence", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2375("to_melee", undefined, ::trans_slow_walk_crawl_turn_to_to_melee1, undefined);
  scripts\asm\asm::func_2375("to_suicide_bomb", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("slow_walk_crawl_loop", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("slow_walk_crawl_loop", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("frozen_crawl", undefined, ::scripts\asm\zombie\zombie::func_3E12, "slow_walk_crawl_loop");
  scripts\asm\asm::func_2374("crawl_stop", scripts\asm\zombie\zombie::func_CEAE, undefined, undefined, undefined, undefined, lib_0F3A::func_3E97, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("zapper_sequence", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2375("to_melee", undefined, ::trans_crawl_stop_to_to_melee1, undefined);
  scripts\asm\asm::func_2375("to_suicide_bomb", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("slow_walk_crawl_loop", undefined, ::scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2375("move_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("walk_crawl_loop", undefined, ::scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2375("run_crawl_loop", undefined, ::scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2375("sprint_crawl_loop", undefined, ::scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2374("idle_exit_crawl", lib_0F3B::func_CEB5, undefined, undefined, undefined, undefined, lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("choose_crawl_type", undefined, ::scripts\asm\asm::func_68B0, "finish");
  scripts\asm\asm::func_2375("choose_crawl_type", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("frozen_crawl", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2374("frozen_sprint", scripts\asm\zombie\zombie::func_7389, undefined, undefined, ::scripts\asm\zombie\zombie::func_631D, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pass_sprint_in", undefined, ::scripts\asm\zombie\zombie::func_3E18, undefined);
  scripts\asm\asm::func_2374("frozen_run", scripts\asm\zombie\zombie::func_7389, undefined, undefined, ::scripts\asm\zombie\zombie::func_631D, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pass_run_in", undefined, ::scripts\asm\zombie\zombie::func_3E18, undefined);
  scripts\asm\asm::func_2374("frozen_walk", scripts\asm\zombie\zombie::func_7389, undefined, undefined, ::scripts\asm\zombie\zombie::func_631D, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pass_walk_in", undefined, ::scripts\asm\zombie\zombie::func_3E18, undefined);
  scripts\asm\asm::func_2374("frozen_crawl", scripts\asm\zombie\zombie::func_7389, undefined, undefined, ::scripts\asm\zombie\zombie::func_631D, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("slow_walk_crawl_loop", undefined, ::scripts\asm\zombie\zombie::func_3E18, undefined);
  scripts\asm\asm::func_2374("slow_walk_turn", scripts\asm\zombie\zombie::func_D515, undefined, undefined, undefined, undefined, lib_0F3B::func_3EF5, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("frozen_slow_walk", undefined, ::scripts\asm\zombie\zombie::func_3E12, "slow_walk_loop");
  scripts\asm\asm::func_2375("move_to_zapper_anims", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2375("to_suicide_bomb", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("to_melee", undefined, ::func_124EE, undefined);
  scripts\asm\asm::func_2375("pass_slow_walk_in", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("pass_slow_walk_in", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("choose_idle_exit", undefined, ::func_124E6, undefined);
  scripts\asm\asm::func_2374("slow_walk_loop", scripts\asm\zombie\zombie::func_D4E3, "slow_walk", undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EE1, undefined, undefined, undefined, undefined, undefined, "pain_moving_shamble", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pass_slow_walk_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("slow_walk_stop", scripts\asm\zombie\zombie::func_CEAE, undefined, undefined, undefined, undefined, lib_0F3A::func_3E97, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("move_to_zapper_anims", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2375("to_suicide_bomb", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("pass_slow_walk_in", undefined, ::scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2375("move_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("to_melee", undefined, ::func_124E2, undefined);
  scripts\asm\asm::func_2374("idle_exit_slow_walk", scripts\asm\zombie\zombie::func_CEB7, undefined, undefined, undefined, undefined, lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pass_slow_walk_in", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("pass_slow_walk_in", undefined, ::scripts\asm\asm::func_68B0, "finish");
  scripts\asm\asm::func_2375("frozen_slow_walk", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2374("frozen_slow_walk", scripts\asm\zombie\zombie::func_7389, undefined, undefined, ::scripts\asm\zombie\zombie::func_631D, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pass_slow_walk_in", undefined, ::scripts\asm\zombie\zombie::func_3E18, undefined);
  scripts\asm\asm::func_2374("choose_crawl_type", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("slow_walk_crawl_loop", undefined, ::func_11B98, undefined);
  scripts\asm\asm::func_2375("walk_crawl_loop", undefined, ::func_11B9A, undefined);
  scripts\asm\asm::func_2375("run_crawl_loop", undefined, ::func_11B97, undefined);
  scripts\asm\asm::func_2375("sprint_crawl_loop", undefined, ::func_11B99, undefined);
  scripts\asm\asm::func_2374("run_crawl_loop", scripts\asm\zombie\zombie::func_D4E3, "run", undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("frozen_crawl", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2375("moveto_window_done", undefined, ::scripts\asm\zombie\zombie::func_DD1E, undefined);
  scripts\asm\asm::func_2375("zapper_sequence", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2375("to_melee", undefined, ::trans_run_crawl_loop_to_to_melee3, undefined);
  scripts\asm\asm::func_2375("to_suicide_bomb", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("crawl_stop", undefined, ::scripts\asm\zombie\zombie::func_10092, undefined);
  scripts\asm\asm::func_2375("run_crawl_turn", undefined, lib_0F3B::func_FFF8, undefined);
  scripts\asm\asm::func_2375("move_done", undefined, ::trans_run_crawl_loop_to_move_done7, undefined);
  scripts\asm\asm::func_2374("walk_crawl_loop", scripts\asm\zombie\zombie::func_D4E3, "walk", undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("moveto_window_done", undefined, ::scripts\asm\zombie\zombie::func_DD1E, undefined);
  scripts\asm\asm::func_2375("zapper_sequence", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2375("to_melee", undefined, ::trans_walk_crawl_loop_to_to_melee2, undefined);
  scripts\asm\asm::func_2375("to_suicide_bomb", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("crawl_stop", undefined, ::scripts\asm\zombie\zombie::func_10092, undefined);
  scripts\asm\asm::func_2375("walk_crawl_turn", undefined, lib_0F3B::func_FFF8, undefined);
  scripts\asm\asm::func_2375("move_done", undefined, ::trans_walk_crawl_loop_to_move_done6, undefined);
  scripts\asm\asm::func_2375("frozen_crawl", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2374("sprint_crawl_loop", scripts\asm\zombie\zombie::func_D4E3, "sprint", undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("moveto_window_done", undefined, ::scripts\asm\zombie\zombie::func_DD1E, undefined);
  scripts\asm\asm::func_2375("zapper_sequence", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2375("to_melee", undefined, ::trans_sprint_crawl_loop_to_to_melee2, undefined);
  scripts\asm\asm::func_2375("to_suicide_bomb", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("move_done", undefined, ::trans_sprint_crawl_loop_to_move_done4, undefined);
  scripts\asm\asm::func_2375("crawl_stop", undefined, ::scripts\asm\zombie\zombie::func_10092, undefined);
  scripts\asm\asm::func_2375("sprint_crawl_turn", undefined, lib_0F3B::func_FFF8, undefined);
  scripts\asm\asm::func_2375("frozen_crawl", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2374("walk_crawl_turn", scripts\asm\zombie\zombie::func_D515, undefined, undefined, undefined, undefined, lib_0F3B::func_3EF5, "crawl_turn", undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("zapper_sequence", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2375("to_suicide_bomb", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("walk_crawl_loop", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("walk_crawl_loop", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("frozen_crawl", undefined, ::scripts\asm\zombie\zombie::func_3E12, "walk_crawl_loop");
  scripts\asm\asm::func_2374("run_crawl_turn", scripts\asm\zombie\zombie::func_D515, undefined, undefined, undefined, undefined, lib_0F3B::func_3EF5, "crawl_turn", undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("zapper_sequence", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2375("to_suicide_bomb", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("run_crawl_loop", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("run_crawl_loop", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("frozen_crawl", undefined, ::scripts\asm\zombie\zombie::func_3E12, "run_crawl_loop");
  scripts\asm\asm::func_2374("sprint_crawl_turn", scripts\asm\zombie\zombie::func_D515, undefined, undefined, undefined, undefined, lib_0F3B::func_3EF5, "crawl_turn", undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("zapper_sequence", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2375("to_suicide_bomb", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("sprint_crawl_loop", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("sprint_crawl_loop", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("frozen_crawl", undefined, ::scripts\asm\zombie\zombie::func_3E12, "sprint_crawl_loop");
  scripts\asm\asm::func_2374("to_melee", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("melee", undefined, ::func_125D1, undefined);
  scripts\asm\asm::func_2374("to_suicide_bomb", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("suicide_bomber_checks", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("move_to_zapper_anims", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("zapper_sequence", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2374("pass_slow_walk_out", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("move_to_zapper_anims", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2375("moveto_window_done", undefined, ::scripts\asm\zombie\zombie::func_DD1E, undefined);
  scripts\asm\asm::func_2375("play_melee_anim", undefined, ::scripts\asm\zombie\zombie::func_BE95, undefined);
  scripts\asm\asm::func_2375("disco_fever", undefined, ::scripts\asm\zombie_dlc4\zombie_dlc4::hasdiscofever, undefined);
  scripts\asm\asm::func_2375("move_done", undefined, ::trans_pass_slow_walk_out_to_move_done4, undefined);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::trans_pass_slow_walk_out_to_choose_movetype5, undefined);
  scripts\asm\asm::func_2375("to_suicide_bomb", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("to_melee", undefined, ::trans_pass_slow_walk_out_to_to_melee7, undefined);
  scripts\asm\asm::func_2375("slow_walk_turn", undefined, lib_0F3B::func_FFF8, "slow_walk_turn");
  scripts\asm\asm::func_2375("slow_walk_stop", undefined, ::scripts\asm\zombie\zombie::func_10092, undefined);
  scripts\asm\asm::func_2375("frozen_slow_walk", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2374("pass_slow_walk_in", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("slow_walk_loop_clown", undefined, ::scripts\asm\zombie\zombie::func_9D8C, undefined);
  scripts\asm\asm::func_2375("slow_walk_loop_cop", undefined, ::scripts\asm\zombie\zombie::iscorempgametype, undefined);
  scripts\asm\asm::func_2375("slow_walk_loop", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("slow_walk_loop_cop", scripts\asm\zombie\zombie::func_D4E3, "slow_walk", undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EE1, "cop", undefined, undefined, undefined, undefined, "pain_moving_shamble", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pass_slow_walk_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("slow_walk_loop_clown", scripts\asm\zombie\zombie::func_D4E3, "slow_walk", undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EE1, "clown", undefined, undefined, undefined, undefined, "pain_moving_shamble", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pass_slow_walk_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pass_walk_in", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("walk_loop_clown", undefined, ::scripts\asm\zombie\zombie::func_9D8C, undefined);
  scripts\asm\asm::func_2375("walk_loop_cop", undefined, ::scripts\asm\zombie\zombie::iscorempgametype, undefined);
  scripts\asm\asm::func_2375("walk_loop", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pass_walk_out", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("move_to_zapper_anims", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2375("moveto_window_done", undefined, ::scripts\asm\zombie\zombie::func_DD1E, undefined);
  scripts\asm\asm::func_2375("disco_fever", undefined, ::scripts\asm\zombie_dlc4\zombie_dlc4::hasdiscofever, undefined);
  scripts\asm\asm::func_2375("frozen_walk", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::trans_pass_walk_out_to_choose_movetype4, undefined);
  scripts\asm\asm::func_2375("to_suicide_bomb", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("to_melee", undefined, ::trans_pass_walk_out_to_to_melee6, undefined);
  scripts\asm\asm::func_2375("walk_stop", undefined, ::scripts\asm\zombie\zombie::func_10092, undefined);
  scripts\asm\asm::func_2375("walk_turn", undefined, ::scripts\asm\zombie_dlc4\zombie_dlc4::shoulddosharpturn_dlc, "walk_turn");
  scripts\asm\asm::func_2375("move_done", undefined, ::trans_pass_walk_out_to_move_done9, undefined);
  scripts\asm\asm::func_2374("walk_loop_clown", scripts\asm\zombie\zombie::func_D4E3, "walk", undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EE1, "clown", undefined, undefined, undefined, undefined, "pain_moving_walk", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pass_walk_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("walk_loop_cop", scripts\asm\zombie\zombie::func_D4E3, "walk", undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EE1, "cop", undefined, undefined, undefined, undefined, "pain_moving_walk", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pass_walk_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("run_loop_clown", scripts\asm\zombie\zombie::func_D4E3, "run", undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EE1, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pass_run_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("run_loop_cop", scripts\asm\zombie\zombie::func_D4E3, "run", undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EE1, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pass_run_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pass_run_in", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("run_loop_clown", undefined, ::scripts\asm\zombie\zombie::func_9D8C, undefined);
  scripts\asm\asm::func_2375("run_loop_cop", undefined, ::scripts\asm\zombie\zombie::iscorempgametype, undefined);
  scripts\asm\asm::func_2375("run_loop", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pass_run_out", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("move_to_zapper_anims", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2375("moveto_window_done", undefined, ::scripts\asm\zombie\zombie::func_DD1E, undefined);
  scripts\asm\asm::func_2375("disco_fever", undefined, ::scripts\asm\zombie_dlc4\zombie_dlc4::hasdiscofever, undefined);
  scripts\asm\asm::func_2375("frozen_run", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2375("to_suicide_bomb", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::trans_pass_run_out_to_choose_movetype5, undefined);
  scripts\asm\asm::func_2375("choose_idle_exit", undefined, ::trans_pass_run_out_to_choose_idle_exit6, undefined);
  scripts\asm\asm::func_2375("to_melee", undefined, ::trans_pass_run_out_to_to_melee7, undefined);
  scripts\asm\asm::func_2375("run_stop", undefined, ::scripts\asm\zombie\zombie::func_10092, undefined);
  scripts\asm\asm::func_2375("run_turn", undefined, ::scripts\asm\zombie_dlc4\zombie_dlc4::shoulddosharpturn_dlc, "run_turn");
  scripts\asm\asm::func_2375("move_done", undefined, ::trans_pass_run_out_to_move_done10, undefined);
  scripts\asm\asm::func_2374("pass_sprint_in", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("sprint_loop_clown", undefined, ::scripts\asm\zombie\zombie::func_9D8C, undefined);
  scripts\asm\asm::func_2375("sprint_loop_cop", undefined, ::scripts\asm\zombie\zombie::iscorempgametype, undefined);
  scripts\asm\asm::func_2375("sprint_loop", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pass_sprint_out", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("move_to_zapper_anims", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2375("moveto_window_done", undefined, ::scripts\asm\zombie\zombie::func_DD1E, undefined);
  scripts\asm\asm::func_2375("disco_fever", undefined, ::scripts\asm\zombie_dlc4\zombie_dlc4::hasdiscofever, undefined);
  scripts\asm\asm::func_2375("frozen_sprint", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2375("to_suicide_bomb", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("to_melee", undefined, ::trans_pass_sprint_out_to_to_melee5, undefined);
  scripts\asm\asm::func_2375("sprint_stop", undefined, ::scripts\asm\zombie\zombie::func_10092, undefined);
  scripts\asm\asm::func_2375("sprint_turn", undefined, ::scripts\asm\zombie_dlc4\zombie_dlc4::shoulddosharpturn_dlc, "sprint_turn");
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::trans_pass_sprint_out_to_choose_movetype8, undefined);
  scripts\asm\asm::func_2375("move_done", undefined, ::trans_pass_sprint_out_to_move_done9, undefined);
  scripts\asm\asm::func_2374("sprint_loop_cop", scripts\asm\zombie\zombie::func_D4E3, "sprint", undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EE1, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pass_sprint_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("sprint_loop_clown", scripts\asm\zombie\zombie::func_D4E3, "sprint", undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EE1, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pass_sprint_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("idle_exit_skater", scripts\asm\zombie\zombie::func_CEB7, undefined, undefined, undefined, undefined, lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("skater_idle_exit_done", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("skater_idle_exit_done", undefined, ::scripts\asm\asm::func_68B0, "finish");
  scripts\asm\asm::func_2374("skater_idle_exit_done", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("traverse_window", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("traverse_window_init", undefined, ::scripts\asm\zombie\zombie::func_98DC, undefined);
  scripts\asm\asm::func_2375("moveto_window", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("window_attack_player", scripts\asm\zombie\zombie::func_CEE3, undefined, ::scripts\asm\zombie\zombie::func_252C, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EBA, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("traverse_window_to_zapper_sequence", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2375("window_attack_freeze", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2375("traverse_window_decision", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("destroy_window", scripts\asm\zombie\zombie::func_CF19, undefined, ::scripts\asm\zombie\zombie::func_532D, ::scripts\asm\zombie\zombie::func_116E8, undefined, ::scripts\asm\zombie\zombie::func_3ECF, undefined, undefined, "stand", undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("traverse_window_decision", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("traverse_window_to_zapper_sequence", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2375("window_attack_freeze", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2374("enter_window", scripts\asm\zombie\zombie::func_662E, undefined, undefined, ::scripts\asm\zombie\zombie::func_11706, "choose_movetype", scripts\asm\zombie\zombie::func_3ED7, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("traverse_window_to_zapper_sequence", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2375("traverse_window_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("traverse_window_done", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("enter_window_freeze", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2374("traverse_window_init", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2374("traverse_window_decision", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("window_attack_player", undefined, ::scripts\asm\zombie\zombie::func_FFC0, undefined);
  scripts\asm\asm::func_2375("destroy_window", undefined, ::scripts\asm\zombie\zombie::func_BE93, undefined);
  scripts\asm\asm::func_2375("use_custom_traversal", undefined, ::scripts\asm\zombie\zombie::func_1305A, undefined);
  scripts\asm\asm::func_2375("pass_check_running", undefined, ::scripts\asm\zombie\zombie::func_10007, undefined);
  scripts\asm\asm::func_2375("pass_check_walking", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("moveto_window", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("choose_idle_exit", undefined, ::scripts\asm\zombie\zombie::func_5AEE, undefined);
  scripts\asm\asm::func_2374("moveto_window_done", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("traverse_window_decision", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("use_custom_traversal", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("traverse_window_to_zapper_sequence", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("zapper_sequence", undefined, ::scripts\asm\zombie\zombie::func_1005E, undefined);
  scripts\asm\asm::func_2374("enter_window_running", scripts\asm\zombie\zombie::func_662E, undefined, undefined, ::scripts\asm\zombie\zombie::func_11706, "choose_movetype", scripts\asm\zombie\zombie::func_3ED7, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("traverse_window_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("traverse_window_done", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("enter_window_running_freeze", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2374("enter_window_crawl_running", scripts\asm\zombie\zombie::func_662E, undefined, undefined, ::scripts\asm\zombie\zombie::func_11706, "choose_movetype", scripts\asm\zombie\zombie::func_3ED7, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("traverse_window_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("traverse_window_done", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("enter_window_crawl_running_freeze", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2374("pass_check_running", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("enter_window_crawl_running", undefined, ::func_123E1, undefined);
  scripts\asm\asm::func_2375("enter_window_running", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pass_check_walking", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("enter_window_crawling", undefined, ::func_123E2, undefined);
  scripts\asm\asm::func_2375("enter_window", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("enter_window_crawling", scripts\asm\zombie\zombie::func_662E, undefined, undefined, ::scripts\asm\zombie\zombie::func_11706, "choose_movetype", scripts\asm\zombie\zombie::func_3ED7, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("traverse_window_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("traverse_window_done", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("enter_window_crawling_freeze", undefined, ::scripts\asm\zombie\zombie::func_3E12, undefined);
  scripts\asm\asm::func_2374("traverse_window_done", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("choose_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("window_attack_freeze", scripts\asm\zombie\zombie::func_7389, undefined, undefined, ::scripts\asm\zombie\zombie::func_631D, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("traverse_window_decision", undefined, ::scripts\asm\zombie\zombie::func_3E18, undefined);
  scripts\asm\asm::func_2374("enter_window_crawl_running_freeze", scripts\asm\zombie\zombie::func_7389, undefined, undefined, ::scripts\asm\zombie\zombie::func_631D, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("enter_window_crawl_running", undefined, ::scripts\asm\zombie\zombie::func_3E18, undefined);
  scripts\asm\asm::func_2374("enter_window_freeze", scripts\asm\zombie\zombie::func_7389, undefined, undefined, ::scripts\asm\zombie\zombie::func_631D, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("enter_window", undefined, ::scripts\asm\zombie\zombie::func_3E18, undefined);
  scripts\asm\asm::func_2374("enter_window_running_freeze", scripts\asm\zombie\zombie::func_7389, undefined, undefined, ::scripts\asm\zombie\zombie::func_631D, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("enter_window_running", undefined, ::scripts\asm\zombie\zombie::func_3E18, undefined);
  scripts\asm\asm::func_2374("enter_window_crawling_freeze", scripts\asm\zombie\zombie::func_7389, undefined, undefined, ::scripts\asm\zombie\zombie::func_631D, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("enter_window_crawling", undefined, ::scripts\asm\zombie\zombie::func_3E18, undefined);
  scripts\asm\asm::func_2374("play_melee_anim", scripts\asm\zombie\zombie::func_D4DB, undefined, undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EE0, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("choose_idle", undefined, ::func_12402, undefined);
  scripts\asm\asm::func_2375("play_melee_anim", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("transform_to_suicide_bomber", scripts\asm\zombie\melee::func_D553, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("choose_movetype", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("play_spawn_fx", scripts\asm\zombie\zombie::func_D532, undefined, undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EFB, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("play_vignette_anim", undefined, ::func_12403, undefined);
  scripts\asm\asm::func_2374("zapper_sequence", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", 1);
  scripts\asm\asm::func_2375("facemelter_launch", undefined, ::scripts\asm\zombie\zombie::func_10046, undefined);
  scripts\asm\asm::func_2375("dischord_spin", undefined, ::scripts\asm\zombie\zombie::shouldplaybalconydeath, undefined);
  scripts\asm\asm::func_2375("headcutter_death_style", undefined, ::scripts\asm\zombie\zombie::func_10049, undefined);
  scripts\asm\asm::func_2375("shredder_death", undefined, ::scripts\asm\zombie\zombie::func_10053, undefined);
  scripts\asm\asm::func_2374("facemelter_loop", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("facemelter_launch", lib_0F3C::func_CEA8, undefined, undefined, ::scripts\asm\zombie\zombie::func_6A79, undefined, ::scripts\asm\zombie\zombie::choosefacemelteranim, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("facemelter_loop", 0.01, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("dischord_spin", lib_0F3C::func_CEA8, undefined, undefined, ::scripts\asm\zombie\zombie::func_5626, undefined, ::scripts\asm\zombie\zombie::choosedischordanim, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("dischord_spin_loop", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("headcutter_death", lib_0F3C::func_CEA8, undefined, undefined, ::scripts\asm\zombie\zombie::func_6A79, undefined, ::scripts\asm\zombie\zombie::chooseheadcutteranim, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2374("shredder_death", lib_0F3C::func_CEA8, undefined, undefined, ::scripts\asm\zombie\zombie::func_6A79, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2374("dischord_spin_loop", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EFE, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("headcutter_death_prone", lib_0F3C::func_CEA8, undefined, undefined, ::scripts\asm\zombie\zombie::func_6A79, undefined, ::scripts\asm\zombie\zombie::chooseheadcutteranim, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crawling", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2374("headcutter_death_style", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("headcutter_death_prone", undefined, ::trans_headcutter_death_style_to_headcutter_death_prone0, undefined);
  scripts\asm\asm::func_2375("headcutter_death", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("waiting", lib_0F3C::func_B050, undefined, undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3F0B, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("choose_idle", undefined, ::scripts\asm\zombie\zombie::isdowned, undefined);
  scripts\asm\asm::func_2374("balloon_grab_left", lib_0F3C::func_CEA8, undefined, ::scripts\asm\zombie_dlc4\zombie_dlc4::balloongrabnotehandler, undefined, undefined, ::scripts\asm\zombie_dlc4\zombie_dlc4::chooseballoongrabanim, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("balloon_float", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("balloon_float", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::scripts\asm\zombie_dlc4\zombie_dlc4::chooseballoonfloatanim, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2374("balloon_grab_right", lib_0F3C::func_CEA8, undefined, ::scripts\asm\zombie_dlc4\zombie_dlc4::balloongrabnotehandler, undefined, undefined, ::scripts\asm\zombie_dlc4\zombie_dlc4::chooseballoongrabanim, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("balloon_float", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("balloon_grab", scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("balloon_grab_left", undefined, ::scripts\asm\zombie_dlc4\zombie_dlc4::shouldballoongrableft, undefined);
  scripts\asm\asm::func_2375("balloon_grab_right", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("piranha_trap", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2374("disco_fever", scripts\asm\zombie\zombie::func_CEF3, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, ["(none)"], undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("choose_idle", undefined, ::scripts\asm\zombie_dlc4\zombie_dlc4::isdiscofeverdone, undefined);
  scripts\asm\asm::func_2327();
}

trans_idle_to_melee7(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

trans_idle_to_choose_idle_exit9(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

func_11BCA(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_BE96();
}

func_11BCE(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_BE97();
}

func_11BBB(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

func_11BC6(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_BE92();
}

func_11BC1(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_isincombat();
}

func_12203(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_isincombat();
}

func_12204(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_BE92();
}

func_12208(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

func_12212(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

func_1221D(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

func_12222(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

func_12405(var_0, var_1, var_2, var_3) {
  return self.hasplayedvignetteanim;
}

func_120B5(var_0, var_1, var_2, var_3) {
  return !scripts\asm\zombie_dlc4\zombie_dlc4::isdismembermentdisabled() && lib_0C72::func_9E2E();
}

func_120B9(var_0, var_1, var_2, var_3) {
  return !scripts\asm\zombie_dlc4\zombie_dlc4::isdismembermentdisabled();
}

func_121B4(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B6();
}

func_121EA(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B9() && lib_0C72::func_9EDD("walk");
}

func_121EB(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B9() && lib_0C72::func_9EDD("slow_walk");
}

func_121E3(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B9() && lib_0C72::func_9EDD("run");
}

func_121E4(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B9() && lib_0C72::func_9EDD("sprint");
}

func_121FE(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54BA() && lib_0C72::func_9EDD("walk");
}

func_121FF(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54BA() && lib_0C72::func_9EDD("slow_walk");
}

func_121F6(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54BA() && lib_0C72::func_9EDD("run");
}

func_121F7(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54BA() && lib_0C72::func_9EDD("sprint");
}

func_121D0(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B8() && lib_0C72::func_9EDD("run");
}

func_121D1(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B8() && lib_0C72::func_9EDD("sprint");
}

func_121D8(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B8() && lib_0C72::func_9EDD("walk");
}

func_121D9(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B8() && lib_0C72::func_9EDD("slow_walk");
}

func_121BE(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B7() && lib_0C72::func_9EDD("run");
}

func_121BF(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B7() && lib_0C72::func_9EDD("sprint");
}

func_121C4(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B7() && lib_0C72::func_9EDD("walk");
}

func_121C5(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B7() && lib_0C72::func_9EDD("slow_walk");
}

func_121DE(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B9();
}

func_121F0(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54BA();
}

func_121CA(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B8();
}

func_121B9(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B8();
}

func_122F3(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B6();
}

func_12329(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B9() && lib_0C72::func_9EDD("walk");
}

func_1232A(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B9() && lib_0C72::func_9EDD("slow_walk");
}

func_12322(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B9() && lib_0C72::func_9EDD("run");
}

func_12323(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B9() && lib_0C72::func_9EDD("sprint");
}

func_1233D(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54BA() && lib_0C72::func_9EDD("walk");
}

func_1233E(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54BA() && lib_0C72::func_9EDD("slow_walk");
}

func_12335(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54BA() && lib_0C72::func_9EDD("run");
}

func_12336(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54BA() && lib_0C72::func_9EDD("sprint");
}

func_12303(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B7() && lib_0C72::func_9EDD("walk");
}

func_12304(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B7() && lib_0C72::func_9EDD("slow_walk");
}

func_122FD(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B7() && lib_0C72::func_9EDD("run");
}

func_122FE(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B7() && lib_0C72::func_9EDD("sprint");
}

func_12317(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B8() && lib_0C72::func_9EDD("walk");
}

func_12318(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B8() && lib_0C72::func_9EDD("slow_walk");
}

func_1230F(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B8() && lib_0C72::func_9EDD("run");
}

func_12310(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B8() && lib_0C72::func_9EDD("sprint");
}

func_1232F(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54BA();
}

func_1231D(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B9();
}

func_12309(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B8();
}

func_122F8(var_0, var_1, var_2, var_3) {
  return lib_0C72::func_54B7();
}

func_1208A(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

func_12379(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_BE92();
}

func_12385(var_0, var_1, var_2, var_3) {
  return self.var_DD == "head";
}

func_1238B(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_9E89(self.var_DD);
}

func_1237F(var_0, var_1, var_2, var_3) {
  return 1;
}

func_123B7(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_BE92();
}

func_123BD(var_0, var_1, var_2, var_3) {
  return !scripts\asm\zombie\zombie::func_10057(self.var_E1, self.var_E2, self.var_DE, self.var_DD);
}

func_123C9(var_0, var_1, var_2, var_3) {
  return self.var_DD == "head";
}

func_123C3(var_0, var_1, var_2, var_3) {
  return 1;
}

func_123A4(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_9E89(self.var_DD) && scripts\asm\asm_bb::bb_movetyperequested("sprint");
}

func_1239E(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("sprint");
}

func_12399(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_9E89(self.var_DD) && scripts\asm\asm_bb::bb_movetyperequested("run");
}

func_12392(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("run");
}

func_123AA(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_9E89(self.var_DD) && scripts\asm\asm_bb::bb_movetyperequested("walk");
}

func_123AB(var_0, var_1, var_2, var_3) {
  return 1;
}

func_123B4(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_BE92();
}

func_123B5(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_10057(self.var_E1, self.var_E2, self.var_DE, self.var_DD);
}

func_123CE(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_BE92();
}

func_123CF(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_10057(self.var_E1, self.var_E2, self.var_DE, self.var_DD);
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

func_12294(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_BE92() && scripts\asm\zombie\melee::func_138E0();
}

func_1228A(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_BE92();
}

func_1228F(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E0();
}

func_122A3(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E1();
}

func_1229F(var_0, var_1, var_2, var_3) {
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

func_1217D(var_0, var_1, var_2, var_3) {
  return !isDefined(self.isfrozen) || !self.isfrozen;
}

func_12181(var_0, var_1, var_2, var_3) {
  return !isDefined(self.isfrozen) || !self.isfrozen;
}

func_125CB(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E5();
}

func_125CC(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E6();
}

func_11BEF(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::shouldplayarenaintro();
}

func_11BEE(var_0, var_1, var_2, var_3) {
  return 1;
}

func_11BD0(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_BE92();
}

func_11BD8(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_BE9A();
}

func_11BD9(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("walk");
}

func_11BD6(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("run");
}

func_11BD7(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("slow_walk");
}

func_12616(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

func_1246B(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

func_1253D(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

func_12619(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_A013();
}

func_1262E(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

func_12481(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

func_12550(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

func_11B9B(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_BE92();
}

func_11BAA(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_BE9A();
}

func_11BAF(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("walk");
}

func_11BA1(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("run");
}

func_11BA7(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("slow_walk");
}

trans_slow_walk_crawl_loop_to_to_melee1(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

trans_slow_walk_crawl_loop_to_move_done5(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

trans_slow_walk_crawl_turn_to_to_melee1(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

trans_crawl_stop_to_to_melee1(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

func_124EE(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

func_124E6(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_A013();
}

func_124E2(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

func_11B98(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("slow_walk");
}

func_11B9A(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("walk");
}

func_11B97(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("run");
}

func_11B99(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("sprint");
}

trans_run_crawl_loop_to_to_melee3(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

trans_run_crawl_loop_to_move_done7(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

trans_walk_crawl_loop_to_to_melee2(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

trans_walk_crawl_loop_to_move_done6(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

trans_sprint_crawl_loop_to_to_melee2(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

trans_sprint_crawl_loop_to_move_done4(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

func_125D1(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

trans_pass_slow_walk_out_to_move_done4(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

trans_pass_slow_walk_out_to_choose_movetype5(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_BCCD();
}

trans_pass_slow_walk_out_to_to_melee7(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

trans_pass_walk_out_to_choose_movetype4(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_BCCD();
}

trans_pass_walk_out_to_to_melee6(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

trans_pass_walk_out_to_move_done9(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

trans_pass_run_out_to_choose_movetype5(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_BCCD();
}

trans_pass_run_out_to_choose_idle_exit6(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_A013();
}

trans_pass_run_out_to_to_melee7(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

trans_pass_run_out_to_move_done10(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

trans_pass_sprint_out_to_to_melee5(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\melee::func_138E4();
}

trans_pass_sprint_out_to_choose_movetype8(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_BCCD();
}

trans_pass_sprint_out_to_move_done9(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

func_123E1(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_BE92();
}

func_123E2(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_BE92();
}

func_12402(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie\zombie::func_1009C();
}

func_12403(var_0, var_1, var_2, var_3) {
  return self.var_8C12;
}

trans_headcutter_death_style_to_headcutter_death_prone0(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::istrue(self.dismember_crawl);
}