/**************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\asm\slasher_dlc4\mp\states.gsc
**************************************************/

func_2371() {
  if(scripts\asm\asm::func_232E("slasher_dlc4")) {
    return;
  }

  scripts\asm\asm::func_230B("slasher_dlc4", "slasher_start");
  scripts\asm\asm::func_2374("slasher_start", ::scripts\asm\slasher\slasher_asm::slasherinit, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("entrance", undefined, ::scripts\asm\slasher\slasher_asm::shouldplayentranceanim, undefined);
  scripts\asm\asm::func_2375("decide_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("idle", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("check_move", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("check_actions", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("entrance", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("decide_idle", undefined, ::scripts\asm\slasher\slasher_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("check_actions", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("swipe_attack", undefined, ::scripts\asm\slasher\slasher_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("ground_pound", undefined, ::scripts\asm\slasher\slasher_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("melee_spin", undefined, ::scripts\asm\slasher\slasher_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("grenade_throw", undefined, ::scripts\asm\slasher\slasher_asm::func_100AD, undefined);
  scripts\asm\asm::func_2375("sawblade_attack", undefined, ::scripts\asm\slasher\slasher_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("ram_attack", undefined, ::scripts\asm\slasher\slasher_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("block", undefined, ::scripts\asm\slasher\slasher_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("taunt", undefined, ::scripts\asm\slasher\slasher_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("teleport", undefined, ::scripts\asm\slasher\slasher_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("summon", undefined, ::scripts\asm\slasher\slasher_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2374("swipe_attack", ::scripts\asm\slasher\slasher_asm::playmeleeattack, undefined, ::scripts\asm\slasher\slasher_asm::meleenotehandler, undefined, undefined, ::scripts\asm\slasher\slasher_asm::choosemeleeattack, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\slasher\slasher_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("ground_pound", ::scripts\asm\slasher\slasher_asm::playgroundpound, undefined, ::scripts\asm\slasher\slasher_asm::groundpoundnotehandler, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\slasher\slasher_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("melee_spin", ::scripts\asm\slasher\slasher_asm::playmeleespinattack, undefined, ::scripts\asm\slasher\slasher_asm::meleenotehandler, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\slasher\slasher_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("block_intro", ::scripts\asm\slasher\slasher_asm::playblockanim, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("block_loop", undefined, ::scripts\asm\slasher\slasher_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("grenade_throw", ::scripts\asm\slasher\slasher_asm::playgrenadethrowanim, undefined, ::scripts\asm\slasher\slasher_asm::grenadethrownotehandler, ::scripts\asm\slasher\slasher_asm::grenadethrowterminate, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\slasher\slasher_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("sawblade_shoot_transition_in", ::scripts\asm\slasher\slasher_asm::playanimandlookatenemy, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::func_2375("sawblade_shoot_idle", undefined, ::scripts\asm\slasher\slasher_asm::isanimdone, undefined);
  scripts\asm\asm::func_2375("teleport", undefined, ::scripts\asm\slasher\slasher_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2374("sawblade_attack", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("sawblade_shoot_transition_in", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("sawblade_shoot", ::scripts\asm\slasher\slasher_asm::shootsawblades, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("check_interruptables", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("aiming_turn", undefined, ::scripts\asm\slasher\slasher_asm::func_BEA0, undefined);
  scripts\asm\asm::func_2375("sawblade_shoot_transition_out", undefined, ::scripts\asm\slasher\slasher_asm::issawbladeattackdone, undefined);
  scripts\asm\asm::func_2375("sawblade_shoot_idle", undefined, ::scripts\asm\slasher\slasher_asm::shouldstopshootingsawblade, undefined);
  scripts\asm\asm::func_2374("sawblade_attack_done", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("ram_attack", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("ram_attack_start", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("ram_attack_start", ::scripts\asm\slasher\slasher_asm::playanimandlookatenemy, undefined, undefined, ::scripts\asm\slasher\slasher_asm::ram_attack_start_terminate, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::func_2375("ram_attack_loop", undefined, ::scripts\asm\slasher\slasher_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("ram_attack_loop", ::scripts\asm\slasher\slasher_asm::playramattackloop, 1, undefined, ::scripts\asm\slasher\slasher_asm::ram_attack_loop_terminate, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("ram_attack_anim", 0.05, ::scripts\asm\slasher\slasher_asm::shouldstartramanim, undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\slasher\slasher_asm::shouldabortaction, "ram_attack");
  scripts\asm\asm::func_2374("ram_attack_anim", ::scripts\asm\slasher\slasher_asm::playramattackanim, 1.5, ::scripts\asm\slasher\slasher_asm::ramattacknotehandler, ::scripts\asm\slasher\slasher_asm::ram_attack_anim_terminate, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("ram_attack_done", undefined, ::scripts\asm\slasher\slasher_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("ram_attack_done", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("action_done", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("decide_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("death_generic", ::lib_0C71::func_CF0E, undefined, undefined, undefined, undefined, ::lib_0C71::func_3F00, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2374("death_moving", ::lib_0C71::func_CF0E, undefined, undefined, undefined, undefined, ::lib_0C71::func_3EE2, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2374("check_move", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("idle_exit_walk", undefined, ::trans_check_move_to_idle_exit_walk0, undefined);
  scripts\asm\asm::func_2374("idle_exit_walk", ::scripts\asm\zombie\zombie::func_CEB7, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pass_walk_in", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("pass_walk_in", undefined, ::scripts\asm\asm::func_68B0, "finish");
  scripts\asm\asm::func_2375("teleport", undefined, ::scripts\asm\slasher\slasher_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("check_interruptables", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pass_walk_in", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("pass_walk_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("walk_loop", undefined, ::trans_pass_walk_in_to_walk_loop1, undefined);
  scripts\asm\asm::func_2374("walk_turn", ::scripts\asm\slasher\slasher_asm::slasherplaysharpturnanim, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3EF5, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("teleport", undefined, ::scripts\asm\slasher\slasher_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("check_interruptables", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("pass_walk_in", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("pass_walk_in", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("walk_loop", ::scripts\asm\zombie\zombie::func_D4E3, "walk", undefined, undefined, undefined, ::scripts\asm\zombie\zombie::func_3EE1, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("pass_walk_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pass_walk_out", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("check_actions", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("walk_stop", undefined, ::scripts\asm\slasher\slasher_asm::slashershouldstartarrival, undefined);
  scripts\asm\asm::func_2375("walk_turn", undefined, ::lib_0F3B::func_FFF8, "walk_turn");
  scripts\asm\asm::func_2375("move_done", undefined, ::trans_pass_walk_out_to_move_done3, undefined);
  scripts\asm\asm::func_2374("walk_stop", ::scripts\asm\zombie\zombie::func_CEAE, undefined, undefined, undefined, undefined, ::lib_0F3A::func_3E97, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("check_interruptables", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("pass_walk_in", undefined, ::scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2375("move_done", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("move_done", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("decide_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("choose_movetype", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("check_move", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pain_generic", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::scripts\asm\slasher\slasher_asm::func_3EE4, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("idle", undefined, ::scripts\asm\slasher\slasher_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("pain_moving", ::scripts\asm\slasher\slasher_asm::playmovingpainanim, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("walk_loop", undefined, ::scripts\asm\slasher\slasher_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("decide_idle", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("taunt", ::scripts\asm\slasher\slasher_asm::playtauntanim, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\slasher\slasher_asm::isanimdone, undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\slasher\slasher_asm::shouldabortaction, "taunt");
  scripts\asm\asm::func_2374("sawblade_shoot_transition_out", ::scripts\asm\slasher\slasher_asm::playanimandlookatenemy, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::func_2375("sawblade_attack_done", undefined, ::scripts\asm\slasher\slasher_asm::isanimdone, undefined);
  scripts\asm\asm::func_2375("teleport", undefined, ::scripts\asm\slasher\slasher_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2374("sawblade_shoot_idle", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("check_interruptables", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("aiming_turn", undefined, ::scripts\asm\slasher\slasher_asm::func_BEA0, undefined);
  scripts\asm\asm::func_2375("sawblade_shoot_transition_out", undefined, ::scripts\asm\slasher\slasher_asm::issawbladeattackdone, undefined);
  scripts\asm\asm::func_2375("sawblade_shoot", undefined, ::scripts\asm\slasher\slasher_asm::shouldshootsawblade, undefined);
  scripts\asm\asm::func_2374("teleport_in", ::scripts\asm\slasher\slasher_asm::playanimwithplaybackrate, 2, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::func_2375("teleport_out", undefined, ::scripts\asm\slasher\slasher_asm::isanimdone, undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\slasher\slasher_asm::shouldabortaction, "teleport");
  scripts\asm\asm::func_2374("summon", ::lib_0F3C::func_CEA8, undefined, ::scripts\asm\slasher\slasher_asm::summonnotehandler, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\slasher\slasher_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("check_interruptables", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("melee_spin", undefined, ::scripts\asm\slasher\slasher_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("ground_pound", undefined, ::scripts\asm\slasher\slasher_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("swipe_attack", undefined, ::scripts\asm\slasher\slasher_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("block", undefined, ::scripts\asm\slasher\slasher_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("teleport", undefined, ::scripts\asm\slasher\slasher_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2374("slasher_aimset", undefined, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2374("aiming_turn", ::scripts\asm\slasher\slasher_asm::func_D56A, undefined, undefined, undefined, undefined, ::scripts\asm\slasher\slasher_asm::func_3F0A, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("sawblade_shoot_idle", undefined, ::scripts\asm\slasher\slasher_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("block", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("block_intro", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("block_loop", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("block_outro", undefined, ::scripts\asm\slasher\slasher_asm::shouldendblock, undefined);
  scripts\asm\asm::func_2374("block_outro", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\slasher\slasher_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("teleport", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("teleport_in", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("teleport_out", ::scripts\asm\slasher\slasher_asm::playteleportout, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\slasher\slasher_asm::isanimdone, undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\slasher\slasher_asm::shouldabortaction, "teleport");
  scripts\asm\asm::func_2374("traverse_external", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("teleport_in", undefined, ::scripts\asm\slasher\slasher_asm::ontraversalteleport, undefined);
  scripts\asm\asm::func_2327();
}

trans_check_move_to_idle_exit_walk0(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

trans_pass_walk_in_to_walk_loop1(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

trans_pass_walk_out_to_move_done3(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}