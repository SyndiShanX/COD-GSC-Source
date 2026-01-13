/***********************************************
 * Decompiled by Mjkzy and Edited by SyndiShanX
 * Script: 3895.gsc
***********************************************/

func_2371() {
  if(scripts\asm\asm::func_232E("c6_mp")) {
    return;
  }
  func_0F40::func_2371();
  scripts\asm\asm::func_230B("c6_mp", "c6_start");
  scripts\asm\asm::func_2374("enter_combat", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, ["shoot_mp"], undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_idle", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("noncombat_stand_idle", lib_0F3C::func_B050, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, "noncombat_stand_idle", undefined, undefined, undefined, undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_exit", undefined, ::func_122DB, undefined);
  scripts\asm\asm::func_2375("move_walk_loop", undefined, scripts\asm\asm::func_BCE7, "walk");
  scripts\asm\asm::func_2375("exposed_idle", undefined, ::func_122E1, undefined);
  scripts\asm\asm::func_2375("exit", undefined, lib_0C38::func_FFF3, undefined);
  scripts\asm\asm::func_2375("introloop", undefined, lib_0C38::func_FFEF, undefined);
  scripts\asm\asm::func_2375("enter_combat", undefined, ::func_122D7, undefined);
  scripts\asm\asm::func_2374("c6_start", lib_0C38::func_33FF, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("introloop", undefined, lib_0C38::func_FFEF, undefined);
  scripts\asm\asm::func_2375("noncombat_stand_idle", undefined, ::func_11B94, undefined);
  scripts\asm\asm::func_2374("exposed_aimset", undefined, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2374("strafe_aimset", undefined, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2374("melee_charge_to_ready", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::func_2375("melee_attack", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("dismember", undefined, ::func_12265, undefined);
  scripts\asm\asm::func_2374("melee_attack", lib_0C35::func_D4D7, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "melee_attack", "face enemy", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_idle", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("dismember", undefined, ::func_12260, undefined);
  scripts\asm\asm::func_2374("melee_stand_to_ready", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::func_2375("melee_attack", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("dismember", undefined, ::func_12288, undefined);
  scripts\asm\asm::func_2374("melee_charge", lib_0F3C::func_B050, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::func_2375("melee_charge_to_ready", undefined, scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::func_2375("exposed_idle", undefined, scripts\asm\asm_bb::bb_meleechargeaborted, undefined);
  scripts\asm\asm::func_2375("dismember", undefined, ::func_12263, undefined);
  scripts\asm\asm::func_2374("death_generic", lib_0C34::func_CF0E, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("death_standing", lib_0C34::func_CF0E, undefined, undefined, undefined, undefined, lib_0C34::func_3F00, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("death_crouching", lib_0C34::func_CF0E, undefined, undefined, undefined, undefined, lib_0C34::func_3ECA, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("death_moving", lib_0C34::func_CF0E, undefined, undefined, undefined, undefined, lib_0C34::func_3EE2, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("death_cover", lib_0C34::func_CF0E, undefined, undefined, undefined, undefined, lib_0C34::func_3EC6, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("pain_stand", lib_0C37::func_D4EE, undefined, undefined, lib_0C37::func_4109, undefined, lib_0C37::func_3EEC, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("dismember", undefined, ::func_123D9, undefined);
  scripts\asm\asm::func_2375("exposed_idle", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("pain_run", lib_0C37::func_D4EE, undefined, undefined, lib_0C37::func_4109, undefined, lib_0C37::func_3EEB, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("dismember", undefined, ::func_123D0, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("pain_crouch", lib_0C37::func_D4EE, undefined, undefined, lib_0C37::func_4109, undefined, lib_0C37::func_3EE8, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("pain_prone", lib_0C37::func_D4EE, undefined, undefined, lib_0C37::func_4109, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("pain_cover_right", lib_0C37::func_CF04, undefined, undefined, lib_0C37::func_4109, undefined, lib_0C37::func_3EE5, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_cover", "cover_right", undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("pain_cover_stand", lib_0C37::func_CF04, undefined, undefined, lib_0C37::func_4109, undefined, lib_0C37::func_3EE7, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_cover", "cover_stand", undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("pain_cover_crouch", lib_0C37::func_CF04, undefined, undefined, lib_0C37::func_4109, undefined, lib_0C37::func_3EE6, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_cover", "cover_crouch", undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("pain_cover_left", lib_0C37::func_CF04, undefined, undefined, lib_0C37::func_4109, undefined, lib_0C37::func_3EE5, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_cover", "cover_left", undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("pain_on_back", lib_0C37::func_D4EE, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("pain_cover_left_suppress", lib_0C37::func_CF04, undefined, undefined, lib_0C37::func_4109, undefined, lib_0C37::func_3EE5, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_cover", "cover_left", undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("pain_cover_right_suppress", lib_0C37::func_CF04, undefined, undefined, lib_0C37::func_4109, undefined, lib_0C37::func_3EE5, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_cover", "cover_right", undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("exposed_reload", lib_0C38::reload, undefined, undefined, undefined, undefined, scripts\asm\shared\utility::func_3EAA, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "reload", "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_idle", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("exposed_throw_grenade", lib_0C39::func_CEC6, undefined, undefined, undefined, undefined, lib_0C39::func_3EA8, undefined, undefined, undefined, undefined, undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, "throwgrenade", "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_idle", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("exposed_weaponswitch", lib_0C38::func_CECB, undefined, undefined, undefined, undefined, scripts\asm\shared\utility::chooseanim_weaponswitch, undefined, undefined, undefined, undefined, undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_idle", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("exposed_stand_turn", lib_0C38::func_D56A, undefined, undefined, lib_0C38::func_116FF, undefined, lib_0C38::func_3F0A, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_idle", 0, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("exposed_idle", undefined, scripts\asm\asm::func_68B0, "finish early");
  scripts\asm\asm::func_2374("exposed_idle", lib_0C38::func_D46D, undefined, undefined, undefined, undefined, lib_0F3C::func_3EB3, "_aim_5", ["aim"], undefined, ["shoot_mp"], undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_throw_grenade", undefined, ::func_12125, undefined);
  scripts\asm\asm::func_2375("exposed_weaponswitch", undefined, lib_0C38::func_100A9, undefined);
  scripts\asm\asm::func_2375("exposed_stand_turn", undefined, lib_0C38::func_BEA0, undefined);
  scripts\asm\asm::func_2375("melee_stand_to_ready", undefined, scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::func_2375("exposed_crouch_exit", undefined, ::func_120FD, undefined);
  scripts\asm\asm::func_2375("exposed_crouch_exit", undefined, ::func_120FE, undefined);
  scripts\asm\asm::func_2375("noncombat_stand_idle", undefined, lib_0C38::func_10088, undefined);
  scripts\asm\asm::func_2375("melee_charge", undefined, scripts\asm\asm_bb::bb_meleechargerequested, undefined);
  scripts\asm\asm::func_2375("exposed_exit", undefined, scripts\asm\asm::func_BCE7, "combat");
  scripts\asm\asm::func_2375("exposed_reload", undefined, ::func_12114, undefined);
  scripts\asm\asm::func_2375("exposed_stand_to_crouch", undefined, scripts\asm\asm_bb::func_2949, "crouch");
  scripts\asm\asm::func_2375("exposed_stand_to_prone", undefined, scripts\asm\asm_bb::func_2949, "prone");
  scripts\asm\asm::func_2374("exposed_stand_to_prone", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_prone", 0, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("exposed_prone", lib_0C38::func_D46D, undefined, undefined, undefined, undefined, lib_0F3C::func_3EAB, "_aim_5", undefined, "prone", undefined, undefined, "pain_prone", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_prone_to_stand", undefined, scripts\asm\asm_bb::func_2949, "stand");
  scripts\asm\asm::func_2375("exposed_prone_to_stand", undefined, scripts\asm\asm::func_BCE7, undefined);
  scripts\asm\asm::func_2375("exposed_prone_to_crouch", undefined, scripts\asm\asm_bb::func_2949, "crouch");
  scripts\asm\asm::func_2374("exposed_prone_to_stand", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_idle", 0, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("exposed_stand_to_crouch", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_crouch", 0, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("exposed_crouch", lib_0C38::func_D46D, undefined, undefined, undefined, undefined, lib_0F3C::func_3EAB, "_aim_5", ["aim"], "crouch", ["shoot_mp"], undefined, "pain_crouch", undefined, "death_crouching", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_crouch_to_stand", undefined, scripts\asm\asm_bb::func_2949, "stand");
  scripts\asm\asm::func_2375("exposed_crouch_to_stand", undefined, scripts\asm\asm::func_BCE7, undefined);
  scripts\asm\asm::func_2375("exposed_crouch_to_prone", undefined, scripts\asm\asm_bb::func_2949, "prone");
  scripts\asm\asm::func_2375("exposed_crouch_turn", undefined, lib_0C38::func_BEA0, undefined);
  scripts\asm\asm::func_2375("exposed_reload_crouch", undefined, ::func_120ED, undefined);
  scripts\asm\asm::func_2374("exposed_crouch_to_stand", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_idle", 0, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("exposed_prone_to_crouch", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_crouch", 0, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("exposed_crouch_to_prone", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_prone", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("exposed_crouch_turn", lib_0C38::func_D56A, undefined, undefined, undefined, undefined, lib_0C38::func_3F0A, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_crouch", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("exposed_crouch", undefined, scripts\asm\asm::func_68B0, "finish early");
  scripts\asm\asm::func_2374("exposed_reload_crouch", lib_0C38::reload, undefined, undefined, undefined, undefined, scripts\asm\shared\utility::func_3EAA, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "reload", "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_crouch", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("step_up_24", lib_0C3A::func_D566, 24, undefined, undefined, "stand_run_loop", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("iw6_jumpdown_40", lib_0C3A::func_D566, undefined, undefined, undefined, "stand_run_loop", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("step_down_24", lib_0C3A::func_D566, undefined, undefined, undefined, "stand_run_loop", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("combatrun_forward_72", lib_0F3C::func_CEA8, undefined, undefined, undefined, "stand_run_loop", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("wall_hop", lib_0C3A::func_D55D, 39.875, undefined, undefined, "stand_run_loop", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jumpdown_130", lib_0C3A::func_D566, undefined, undefined, undefined, "stand_run_loop", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jumpdown_96", lib_0C3A::func_D566, undefined, undefined, undefined, "stand_run_loop", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("double_jump_temp", lib_0C3A::func_D55E, undefined, undefined, undefined, "stand_run_loop", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("traverse_external", lib_0C3A::func_D560, undefined, undefined, undefined, "stand_run_loop", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jump_down_fast", lib_0C3A::playtraverseanim_gravity, undefined, undefined, undefined, "stand_run_loop", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("wall_over_40", lib_0C3A::func_D566, undefined, undefined, undefined, "stand_run_loop", lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("dismember", scripts\asm\shared\utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", undefined, 1);
  scripts\asm\asm::func_2375("dismember_stand_choose_prone", undefined, ::func_120AF, undefined);
  scripts\asm\asm::func_2375("dismember_stand_choose_sit", undefined, ::func_120B1, undefined);
  scripts\asm\asm::func_2374("dismember_stand_l_leg_to_prone", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crouching", undefined, undefined, undefined, undefined, "face current", undefined, undefined);
  scripts\asm\asm::func_2375("dismember_prone_idle", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("dismember_stand_r_leg_to_prone", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crouching", undefined, undefined, undefined, undefined, "face current", undefined, undefined);
  scripts\asm\asm::func_2375("dismember_prone_idle", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("dismember_prone_crawl", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, ["shoot_mp"], undefined, undefined, undefined, "death_crouching", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("dismember_prone_idle", undefined, ::func_12091, undefined);
  scripts\asm\asm::func_2375("dismember_fast_crawl", undefined, ::func_1208F, undefined);
  scripts\asm\asm::func_2374("dismember_prone_idle", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, ["shoot_mp"], undefined, undefined, undefined, "death_crouching", undefined, undefined, undefined, undefined, "face enemy", undefined, undefined);
  scripts\asm\asm::func_2375("dismember_prone_crawl", undefined, ::func_12095, undefined);
  scripts\asm\asm::func_2374("dismember_prone_sit_idle", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, ["shoot_mp"], undefined, undefined, undefined, "death_crouching", undefined, undefined, undefined, undefined, "face enemy", undefined, undefined);
  scripts\asm\asm::func_2375("dismember_prone_sit_to_prone", undefined, ::func_12099, undefined);
  scripts\asm\asm::func_2374("dismember_stand_l_leg_to_sit", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crouching", undefined, undefined, undefined, undefined, "face current", undefined, undefined);
  scripts\asm\asm::func_2375("dismember_prone_sit_idle", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("dismember_stand_r_leg_to_sit", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crouching", undefined, undefined, undefined, undefined, "face current", undefined, undefined);
  scripts\asm\asm::func_2375("dismember_prone_sit_idle", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("dismember_stand_choose_prone", scripts\asm\shared\utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", undefined, 1);
  scripts\asm\asm::func_2375("dismember_stand_r_leg_to_prone", undefined, scripts\asm\asm_bb::bb_ispartdismembered, "right_leg");
  scripts\asm\asm::func_2375("dismember_stand_l_leg_to_prone", undefined, ::func_120A3, undefined);
  scripts\asm\asm::func_2374("dismember_stand_choose_sit", scripts\asm\shared\utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", undefined, 1);
  scripts\asm\asm::func_2375("dismember_stand_r_leg_to_sit", undefined, scripts\asm\asm_bb::bb_ispartdismembered, "right_leg");
  scripts\asm\asm::func_2375("dismember_stand_l_leg_to_sit", undefined, ::func_120A9, undefined);
  scripts\asm\asm::func_2374("dismember_prone_sit_to_prone", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crouching", undefined, undefined, undefined, undefined, "face current", undefined, undefined);
  scripts\asm\asm::func_2375("dismember_prone_crawl", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("dismember_fast_crawl", lib_0C36::func_D477, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crouching", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("dismember_prone_idle", undefined, ::func_12088, undefined);
  scripts\asm\asm::func_2374("cover_right_arrival", lib_0F3A::func_CEAA, undefined, undefined, undefined, undefined, lib_0F3A::func_3E97, "Cover Right", undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2374("cover_right_exit", lib_0F3B::func_CEB5, undefined, undefined, undefined, undefined, lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2374("exposed_arrival", lib_0F3A::func_CEAA, undefined, undefined, undefined, undefined, lib_0F3A::func_3E97, "Exposed", undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2375("exposed_idle", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("dismember", undefined, ::func_120C6, undefined);
  scripts\asm\asm::func_2374("exposed_exit", lib_0F3B::func_CEB5, undefined, undefined, undefined, undefined, lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("melee_charge", undefined, scripts\asm\asm_bb::bb_meleechargerequested, undefined);
  scripts\asm\asm::func_2375("dismember", undefined, ::func_120F0, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2374("stand_run_loop", lib_0F3C::func_D4DD, undefined, undefined, undefined, undefined, lib_0F3C::func_3EB8, "run", ["(none)"], "stand", undefined, undefined, "pain_run", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("run_turn", undefined, lib_0F3B::func_FFF8, "run_turn");
  scripts\asm\asm::func_2375("cover_right_arrival", undefined, lib_0F3A::func_1008A, "Cover Right");
  scripts\asm\asm::func_2375("cover_left_arrival", undefined, lib_0F3A::func_1008A, "Cover Left");
  scripts\asm\asm::func_2375("exposed_arrival", undefined, lib_0F3A::func_1008A, ["Exposed", 1]);
  scripts\asm\asm::func_2375("cover_stand_arrival", undefined, lib_0F3A::func_1008A, "Cover Stand");
  scripts\asm\asm::func_2375("cover_crouch_arrival", undefined, lib_0F3A::func_1008A, ["Cover Crouch", 1]);
  scripts\asm\asm::func_2375("cover_left_crouch_arrival", undefined, lib_0F3A::func_1008A, "Cover Left Crouch");
  scripts\asm\asm::func_2375("cover_right_crouch_arrival", undefined, lib_0F3A::func_1008A, "Cover Right Crouch");
  scripts\asm\asm::func_2375("exposed_crouch_arrival", undefined, lib_0F3A::func_1008A, ["Exposed Crouch", 1]);
  scripts\asm\asm::func_2375("sprint_loop", undefined, ::func_1257C, undefined);
  scripts\asm\asm::func_2375("melee_charge", undefined, scripts\asm\asm_bb::bb_meleechargerequested, undefined);
  scripts\asm\asm::func_2375("melee_charge_to_ready", undefined, scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::func_2375("dismember", undefined, ::func_12555, undefined);
  scripts\asm\asm::func_2375("exposed_idle", undefined, ::func_1255D, undefined);
  scripts\asm\asm::func_2375("stand_run_strafe_loop", undefined, lib_0F3C::func_100A3, "stand");
  scripts\asm\asm::func_2375("stand_run_n_gun_loop", undefined, lib_0C36::func_10070, undefined);
  scripts\asm\asm::func_2375("stand_run_n_gun_backwards_loop", undefined, lib_0C36::func_1006F, undefined);
  scripts\asm\asm::func_2375("crouch_run_strafe_loop", undefined, lib_0F3C::func_100A3, "crouch");
  scripts\asm\asm::func_2374("run_turn", lib_0F3B::func_D514, undefined, undefined, undefined, undefined, lib_0F3B::func_3EF5, undefined, undefined, undefined, undefined, undefined, "pain_run", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2374("cover_left_arrival", lib_0F3A::func_CEAA, undefined, undefined, undefined, undefined, lib_0F3A::func_3E97, "Cover Left", undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2374("cover_left_exit", lib_0F3B::func_CEB5, undefined, undefined, undefined, undefined, lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2374("cover_crouch_exit", lib_0F3B::func_CEB5, undefined, undefined, undefined, undefined, lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2374("cover_crouch_arrival", lib_0F3A::func_CEAA, undefined, undefined, undefined, undefined, lib_0F3A::func_3E97, "Cover Crouch", undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2374("cover_stand_exit", lib_0F3B::func_CEB5, undefined, undefined, undefined, undefined, lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2374("cover_stand_arrival", lib_0F3A::func_CEAA, undefined, undefined, undefined, undefined, lib_0F3A::func_3E97, "Cover Stand", undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2374("stand_run_strafe_loop", lib_0F3B::func_D4E5, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, ["aim"], "stand", ["shoot_mp"], undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "code_move", undefined);
  scripts\asm\asm::func_2375("exposed_idle", undefined, ::func_12594, undefined);
  scripts\asm\asm::func_2375("exposed_idle", undefined, ::func_12595, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, lib_0F3C::func_FFB6, "stand");
  scripts\asm\asm::func_2375("stand_run_loop", undefined, scripts\asm\asm_bb::bb_meleechargerequested, undefined);
  scripts\asm\asm::func_2374("stand_run_n_gun_loop", lib_0C36::func_D50D, undefined, undefined, lib_0C36::func_11088, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, ["shoot_mp"], undefined, "pain_run", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("stand_run_n_gun_backwards_loop", undefined, lib_0C36::func_1006F, undefined);
  scripts\asm\asm::func_2375("run_turn", undefined, lib_0F3B::func_FFF8, "run_turn");
  scripts\asm\asm::func_2375("exposed_reload", undefined, ::func_12591, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, lib_0C36::func_1009F, undefined);
  scripts\asm\asm::func_2374("stand_run_n_gun_backwards_loop", lib_0C36::func_D50E, undefined, undefined, lib_0C36::func_11088, undefined, lib_0F3C::func_3E96, "move_back", undefined, undefined, ["shoot_mp"], undefined, "pain_run", undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "code_move", undefined);
  scripts\asm\asm::func_2375("stand_run_n_gun_loop", undefined, lib_0C36::func_10070, undefined);
  scripts\asm\asm::func_2375("run_turn", undefined, lib_0F3B::func_FFF8, "run_turn");
  scripts\asm\asm::func_2375("stand_run_loop", undefined, lib_0C36::func_1009E, undefined);
  scripts\asm\asm::func_2374("cover_left_crouch_exit", lib_0F3B::func_CEB5, undefined, undefined, undefined, undefined, lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2374("cover_right_crouch_exit", lib_0F3B::func_CEB5, undefined, undefined, undefined, undefined, lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2374("cover_left_crouch_arrival", lib_0F3A::func_CEAA, undefined, undefined, undefined, undefined, lib_0F3A::func_3E97, "Cover Left Crouch", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2374("cover_right_crouch_arrival", lib_0F3A::func_CEAA, undefined, undefined, undefined, undefined, lib_0F3A::func_3E97, "Cover Right Crouch", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2374("exposed_crouch_arrival", lib_0F3A::func_CEAA, undefined, undefined, undefined, undefined, lib_0F3A::func_3E97, "Exposed Crouch", undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2375("exposed_crouch", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("exposed_crouch_exit", lib_0F3B::func_CEB5, undefined, undefined, undefined, undefined, lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2374("sprint_loop", lib_0F3C::func_D4DD, undefined, undefined, undefined, undefined, lib_0C36::func_3EFF, undefined, undefined, undefined, undefined, undefined, "pain_run", undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, ::func_12511, undefined);
  scripts\asm\asm::func_2375("dismember", undefined, ::func_124F8, undefined);
  scripts\asm\asm::func_2374("crouch_run_strafe_loop", lib_0F3B::func_D4E5, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, ["aim"], "stand", ["shoot_mp"], undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "code_move", undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, lib_0F3C::func_FFB6, "crouch");
  scripts\asm\asm::func_2375("stand_run_loop", undefined, scripts\asm\asm_bb::bb_meleechargerequested, undefined);
  scripts\asm\asm::func_2374("move_walk_loop", lib_0F3C::func_D4DD, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("noncombat_stand_idle", undefined, ::func_122B0, undefined);
  scripts\asm\asm::func_2374("intro", lib_0C38::func_D4B2, undefined, undefined, lib_0C38::func_116EC, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("noncombat_stand_idle", undefined, scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("exit", lib_0C38::func_D4EC, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("introloop", lib_0C38::func_D4B3, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("intro", undefined, scripts\asm\asm::func_68B0, "introdone");
  scripts\asm\asm::func_2327();
}

func_122DB(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

func_122E1(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_isincombat();
}

func_122D7(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_isincombat();
}

func_11B94(var_0, var_1, var_2, var_3) {
  return 1;
}

func_12265(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_ismissingaleg();
}

func_12260(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_ismissingaleg();
}

func_12288(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_ismissingaleg();
}

func_12263(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_ismissingaleg();
}

func_123D9(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_ismissingaleg() && self.a.pose == "stand";
}

func_123D0(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_ismissingaleg() && self.a.pose == "stand";
}

func_12125(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_throwgrenaderequested();
}

func_120FD(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested() && self._blackboard.movetype == "combat" && lib_0F3C::func_138E2();
}

func_120FE(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.var_2BDF) && self._blackboard.var_2BDF && lib_0F3C::func_138E2();
}

func_12114(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_reloadrequested();
}

func_120ED(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_reloadrequested();
}

func_120AF(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::cointoss();
}

func_120B1(var_0, var_1, var_2, var_3) {
  return 1;
}

func_12091(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

func_1208F(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::func_2921();
}

func_12095(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

func_12099(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

func_120A3(var_0, var_1, var_2, var_3) {
  return 1;
}

func_120A9(var_0, var_1, var_2, var_3) {
  return 1;
}

func_12088(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

func_120C6(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_ismissingaleg();
}

func_120F0(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_ismissingaleg();
}

func_1257C(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("sprint");
}

func_12555(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_ismissingaleg();
}

func_1255D(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

func_12594(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

func_12595(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_reloadrequested();
}

func_12591(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_reloadrequested();
}

func_12511(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_movetyperequested("sprint");
}

func_124F8(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_ismissingaleg();
}

func_122B0(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}