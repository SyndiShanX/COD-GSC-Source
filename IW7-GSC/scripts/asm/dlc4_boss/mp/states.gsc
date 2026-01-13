/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\asm\dlc4_boss\mp\states.gsc
***********************************************/

func_2371() {
  if(scripts\asm\asm::func_232E("dlc4_boss")) {
    return;
  }

  scripts\asm\asm::func_230B("dlc4_boss", "start_here");
  scripts\asm\asm::func_2374("start_here", ::scripts\asm\dlc4_boss\dlc4_boss_asm::asminit, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("entrance", undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::shouldplayentranceanim, undefined);
  scripts\asm\asm::func_2375("decide_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("idle", ::lib_0F3C::func_B050, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("check_actions", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("entrance_turn_around", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("move_back_exit", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("check_actions", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("move", undefined, ::scripts\asm\dlc4\dlc4_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("ground_pound", undefined, ::scripts\asm\dlc4\dlc4_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("temp_idle", undefined, ::scripts\asm\dlc4\dlc4_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("air_pound", undefined, ::scripts\asm\dlc4\dlc4_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("drop_move", undefined, ::scripts\asm\dlc4\dlc4_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("fly_over", undefined, ::scripts\asm\dlc4\dlc4_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("teleport", undefined, ::scripts\asm\dlc4\dlc4_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("death", undefined, ::scripts\asm\dlc4\dlc4_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("black_hole", undefined, ::scripts\asm\dlc4\dlc4_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("eclipse", undefined, ::scripts\asm\dlc4\dlc4_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("taunt", undefined, ::scripts\asm\dlc4\dlc4_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("fireball", undefined, ::scripts\asm\dlc4\dlc4_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("clap", undefined, ::scripts\asm\dlc4\dlc4_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("summon", undefined, ::scripts\asm\dlc4\dlc4_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("tornado", undefined, ::scripts\asm\dlc4\dlc4_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2375("throw", undefined, ::scripts\asm\dlc4\dlc4_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2374("action_done", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("decide_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("death_generic", ::lib_0C71::func_CF0E, undefined, undefined, undefined, undefined, ::lib_0C71::func_3F00, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2374("death_moving", ::lib_0C71::func_CF0E, undefined, undefined, undefined, undefined, ::lib_0C71::func_3EE2, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2374("pain_generic", ::scripts\asm\dlc4_boss\dlc4_boss_asm::playpain, undefined, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::painterminate, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pain_transfer", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("pain_moving", ::scripts\asm\dlc4_boss\dlc4_boss_asm::playmovingpain, undefined, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::painterminate, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::choosepainmovinganim, undefined, undefined, "stand", undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "code_move", undefined);
  scripts\asm\asm::func_2375("pain_transfer", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("decide_idle", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("check_interruptables", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2374("dlc4_boss_aimset", undefined, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2374("taunt", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("move", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("move_exit", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("move_exit", ::scripts\asm\dlc4_boss\dlc4_boss_asm::playmoveexit, undefined, undefined, undefined, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::choosebossmoveanim, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "code_move", undefined);
  scripts\asm\asm::func_2375("move_exit_pass", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("move_loop", ::scripts\asm\dlc4_boss\dlc4_boss_asm::loopbossmoveanim, undefined, undefined, undefined, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::choosebossmoveanim, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "code_move", undefined);
  scripts\asm\asm::func_2375("move_arrival", undefined, ::trans_move_loop_to_move_arrival0, undefined);
  scripts\asm\asm::func_2374("move_arrival", ::scripts\asm\dlc4_boss\dlc4_boss_asm::playmovearrival, undefined, undefined, undefined, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::choosebossarrivalanim, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, "move_arrival", undefined, "code_move", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("fireball", ::scripts\asm\dlc4_boss\dlc4_boss_asm::playfireball, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::fireball_note_handler, undefined, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::choosefireballanim, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("clap", ::lib_0F3C::func_CEA8, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::clap_note_handler, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("summon", ::scripts\asm\dlc4_boss\dlc4_boss_asm::playsummonanim, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::summon_note_handler, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("tornado", ::lib_0F3C::func_CEA8, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::tornado_note_handler, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("teleport_in", ::scripts\asm\dlc4_boss\dlc4_boss_asm::playanimandteleport, "desired_node", ::scripts\asm\dlc4_boss\dlc4_boss_asm::teleportendnotehandler, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("teleport_out", undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::checkteleportdone, undefined);
  scripts\asm\asm::func_2374("ground_pound_start", ::lib_0F3C::func_CEA8, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::ground_pound_start_note_handler, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("ground_pound_land", undefined, ::scripts\asm\asm::func_68B0, "teleport_finished");
  scripts\asm\asm::func_2374("ground_pound_land", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("ground_pound_pound", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("ground_pound_pound", ::lib_0F3C::func_CEA8, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::ground_pound_pound_note_handler, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("ground_pound_launch", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("ground_pound_launch", ::lib_0F3C::func_CEA8, undefined, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::groundpoundexit, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face node", "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("ground_pound", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("ground_pound_start", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("throw", ::scripts\asm\dlc4\dlc4_asm::playanimandlookatenemy, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::throw_note_handler, undefined, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::choosethrowanim, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("temp_idle", ::lib_0F3C::func_B050, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "code_move", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\dlc4\dlc4_asm::shouldabortaction, "temp_idle");
  scripts\asm\asm::func_2374("move_fireball", ::scripts\asm\dlc4_boss\dlc4_boss_asm::playstrafefireball, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::strafefireballnotehandler, undefined, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::choosestrafefireballanim, undefined, undefined, "prone", undefined, undefined, "pain_moving", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "code_move", undefined);
  scripts\asm\asm::func_2375("move_loop", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("move_exit_pass", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "code_move", 1);
  scripts\asm\asm::func_2375("move_fireball", undefined, ::trans_move_exit_pass_to_move_fireball0, undefined);
  scripts\asm\asm::func_2375("move_clap", undefined, ::trans_move_exit_pass_to_move_clap1, undefined);
  scripts\asm\asm::func_2375("move_loop", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("move_back_exit", ::scripts\asm\dlc4_boss\dlc4_boss_asm::playmoveexit, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("move_back_loop", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("move_back_loop", ::scripts\asm\dlc4_boss\dlc4_boss_asm::loopbossmoveanim, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("move_back_arrival", undefined, ::trans_move_back_loop_to_move_back_arrival0, undefined);
  scripts\asm\asm::func_2374("move_back_arrival", ::scripts\asm\dlc4_boss\dlc4_boss_asm::playmovearrival, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("decide_idle", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("entrance", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("entrance_turn_around", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("move_clap", ::scripts\asm\dlc4_boss\dlc4_boss_asm::playstrafefireball, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::clap_note_handler, undefined, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::choosestrafefireballanim, undefined, undefined, undefined, undefined, undefined, "pain_moving", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "code_move", undefined);
  scripts\asm\asm::func_2375("move_loop", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("air_pound", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("air_pound_teleport_in", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("air_pound_teleport_in", ::scripts\asm\dlc4_boss\dlc4_boss_asm::playanimandteleport, "center", ::scripts\asm\dlc4_boss\dlc4_boss_asm::teleportnotehandler, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("air_pound_rise", undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::checkteleportdone, undefined);
  scripts\asm\asm::func_2374("air_pound_attack", ::lib_0F3C::func_CEA8, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::air_pound_attack_note_handler, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("air_pound_launch", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("air_pound_launch", ::scripts\asm\dlc4_boss\dlc4_boss_asm::playanimandteleport, "desired_node", ::scripts\asm\dlc4_boss\dlc4_boss_asm::teleportnotehandler, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("air_pound_teleport_finish", undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::checkteleportdone, undefined);
  scripts\asm\asm::func_2374("ground_vul", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("ground_vul_teleport_in", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("ground_vul_teleport_in", ::scripts\asm\dlc4_boss\dlc4_boss_asm::playanimandteleport, "center", ::scripts\asm\dlc4_boss\dlc4_boss_asm::teleportnotehandler, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, "stand", undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("ground_vul_land", undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::groundvulteleportintransition, undefined);
  scripts\asm\asm::func_2374("ground_vul_idle", ::scripts\asm\dlc4_boss\dlc4_boss_asm::playgroundvulidle, undefined, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::groundvulidleterminate, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("ground_vul_hurt", undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::groundvulhurttransition, undefined);
  scripts\asm\asm::func_2375("ground_vul_launch", undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::groundvulidletransition, undefined);
  scripts\asm\asm::func_2374("ground_vul_launch", ::scripts\asm\dlc4_boss\dlc4_boss_asm::playgroundvullaunch, "desired_node", ::scripts\asm\dlc4_boss\dlc4_boss_asm::groundvullaunchnotehandler, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("ground_vul_finish", undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::checkteleportdone, undefined);
  scripts\asm\asm::func_2374("ground_vul_land", ::scripts\asm\dlc4_boss\dlc4_boss_asm::playgroundvulland, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("last_stand_start", undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::shouldgointolaststand, undefined);
  scripts\asm\asm::func_2375("ground_vul_idle", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("drop_move", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("drop_move_exit", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("drop_move_exit", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("drop_move_down", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("drop_move_down", ::scripts\asm\dlc4_boss\dlc4_boss_asm::loopdropmovedown, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("drop_move_up", undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::dropmovedowntransition, undefined);
  scripts\asm\asm::func_2374("drop_move_up", ::lib_0F3C::func_B050, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("drop_move_arrival", undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::dropmoveuptransition, undefined);
  scripts\asm\asm::func_2374("drop_move_arrival", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("air_pound_rise", ::scripts\asm\dlc4_boss\dlc4_boss_asm::air_pound_rise_play, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("air_pound_attack", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("fly_over", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("fly_over_exit", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("fly_over_exit", ::scripts\asm\dlc4_boss\dlc4_boss_asm::playflyoverexit, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("fly_over_loop", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("fly_over_loop", ::lib_0F3C::func_B050, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::flyoverloopnotehandler, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("fly_over_arrival", undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::flyoverlooptransition, undefined);
  scripts\asm\asm::func_2374("fly_over_arrival", ::lib_0F3C::func_CEA8, undefined, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::terminateflyoverarrival, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("teleport", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("teleport_in", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("teleport_out", ::lib_0F3C::func_CEA8, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::teleportnotehandler, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("air_pound_teleport_finish", ::lib_0F3C::func_CEA8, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::teleportendnotehandler, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("black_hole_start", ::lib_0F3C::func_CEA8, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::black_hole_start_note_handler, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("black_hole_loop", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("death", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("death_teleport_in", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("death_teleport_in", ::scripts\asm\dlc4_boss\dlc4_boss_asm::playanimandteleport, "center", undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("death_idle", undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::checkteleportdone, undefined);
  scripts\asm\asm::func_2374("death_idle", ::lib_0F3C::func_CEA8, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::death_ground_idle_note_handler, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("death_death", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("death_death", ::scripts\asm\dlc4_boss\dlc4_boss_asm::playanimandteleport, "desired_node", ::scripts\asm\dlc4_boss\dlc4_boss_asm::death_note_handler, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::checkteleportdone, undefined);
  scripts\asm\asm::func_2374("black_hole", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("black_hole_start", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("black_hole_end", ::lib_0F3C::func_CEA8, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::black_hole_end_note_handler, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("black_hole_loop", ::scripts\asm\dlc4_boss\dlc4_boss_asm::playblackholeloop, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("black_hole_end", undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::blackholelooptransition, undefined);
  scripts\asm\asm::func_2374("eclipse", ::lib_0F3C::func_CEA8, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::eclipse_note_handler, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "code_move", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("ground_vul_hurt", ::scripts\asm\dlc4_boss\dlc4_boss_asm::playanimandteleport, "desired_node", ::scripts\asm\dlc4_boss\dlc4_boss_asm::groundvulhurtnotehandler, undefined, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::choosegroundvulhurtanim, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("ground_vul_finish", undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::checkteleportdone, undefined);
  scripts\asm\asm::func_2374("last_stand_death", ::lib_0F3C::func_CEA8, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::death_note_handler, ::scripts\asm\dlc4_boss\dlc4_boss_asm::fightending, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("fin", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("ground_vul_finish", ::lib_0F3C::func_CEA8, undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::teleportendnotehandler, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("action_done", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("last_stand_start", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("last_stand_loop", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("last_stand_loop", ::scripts\asm\dlc4_boss\dlc4_boss_asm::playlaststandloop, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("last_stand_end", undefined, ::scripts\asm\dlc4_boss\dlc4_boss_asm::shouldplaydeath, undefined);
  scripts\asm\asm::func_2374("last_stand_end", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2375("last_stand_death", undefined, ::scripts\asm\dlc4\dlc4_asm::isanimdone, undefined);
  scripts\asm\asm::func_2374("pain_transfer", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("ground_vul", undefined, ::scripts\asm\dlc4\dlc4_asm::shoulddoaction, undefined);
  scripts\asm\asm::func_2374("fin", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "anim deltas", undefined);
  scripts\asm\asm::func_2327();
}

trans_move_loop_to_move_arrival0(var_0, var_1, var_2, var_3) {
  return self._blackboard.movereadyforarrival;
}

trans_move_exit_pass_to_move_fireball0(var_0, var_1, var_2, var_3) {
  return self._blackboard.strafeaction == "fireball";
}

trans_move_exit_pass_to_move_clap1(var_0, var_1, var_2, var_3) {
  return self._blackboard.strafeaction == "clap";
}

trans_move_back_loop_to_move_back_arrival0(var_0, var_1, var_2, var_3) {
  return self._blackboard.movereadyforarrival;
}