/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3895.gsc
**************************************/

_id_2371() {
  if(scripts\asm\asm::_id_232E("c6_mp")) {
    return;
  }
  _id_0F40::_id_2371();
  scripts\asm\asm::_id_230B("c6_mp", "c6_start");
  scripts\asm\asm::_id_2374("enter_combat", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, ["shoot_mp"], undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("noncombat_stand_idle", _id_0F3C::_id_B050, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, "noncombat_stand_idle", undefined, undefined, undefined, undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_exit", undefined, ::_id_122DB, undefined);
  scripts\asm\asm::_id_2375("move_walk_loop", undefined, scripts\asm\asm::_id_BCE7, "walk");
  scripts\asm\asm::_id_2375("exposed_idle", undefined, ::_id_122E1, undefined);
  scripts\asm\asm::_id_2375("exit", undefined, _id_0C38::_id_FFF3, undefined);
  scripts\asm\asm::_id_2375("introloop", undefined, _id_0C38::_id_FFEF, undefined);
  scripts\asm\asm::_id_2375("enter_combat", undefined, ::_id_122D7, undefined);
  scripts\asm\asm::_id_2374("c6_start", _id_0C38::_id_33FF, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("introloop", undefined, _id_0C38::_id_FFEF, undefined);
  scripts\asm\asm::_id_2375("noncombat_stand_idle", undefined, ::_id_11B94, undefined);
  scripts\asm\asm::_id_2374("exposed_aimset", undefined, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2374("strafe_aimset", undefined, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2374("melee_charge_to_ready", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("melee_attack", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2375("dismember", undefined, ::_id_12265, undefined);
  scripts\asm\asm::_id_2374("melee_attack", _id_0C35::_id_D4D7, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "melee_attack", "face enemy", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2375("dismember", undefined, ::_id_12260, undefined);
  scripts\asm\asm::_id_2374("melee_stand_to_ready", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("melee_attack", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2375("dismember", undefined, ::_id_12288, undefined);
  scripts\asm\asm::_id_2374("melee_charge", _id_0F3C::_id_B050, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("melee_charge_to_ready", undefined, scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm_bb::bb_meleechargeaborted, undefined);
  scripts\asm\asm::_id_2375("dismember", undefined, ::_id_12263, undefined);
  scripts\asm\asm::_id_2374("death_generic", _id_0C34::_id_CF0E, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("death_standing", _id_0C34::_id_CF0E, undefined, undefined, undefined, undefined, _id_0C34::_id_3F00, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("death_crouching", _id_0C34::_id_CF0E, undefined, undefined, undefined, undefined, _id_0C34::_id_3ECA, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("death_moving", _id_0C34::_id_CF0E, undefined, undefined, undefined, undefined, _id_0C34::_id_3EE2, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("death_cover", _id_0C34::_id_CF0E, undefined, undefined, undefined, undefined, _id_0C34::_id_3EC6, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("pain_stand", _id_0C37::_id_D4EE, undefined, undefined, _id_0C37::_id_4109, undefined, _id_0C37::_id_3EEC, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("dismember", undefined, ::_id_123D9, undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("pain_run", _id_0C37::_id_D4EE, undefined, undefined, _id_0C37::_id_4109, undefined, _id_0C37::_id_3EEB, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("dismember", undefined, ::_id_123D0, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("pain_crouch", _id_0C37::_id_D4EE, undefined, undefined, _id_0C37::_id_4109, undefined, _id_0C37::_id_3EE8, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("pain_prone", _id_0C37::_id_D4EE, undefined, undefined, _id_0C37::_id_4109, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("pain_cover_right", _id_0C37::_id_CF04, undefined, undefined, _id_0C37::_id_4109, undefined, _id_0C37::_id_3EE5, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_cover", "cover_right", undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("pain_cover_stand", _id_0C37::_id_CF04, undefined, undefined, _id_0C37::_id_4109, undefined, _id_0C37::_id_3EE7, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_cover", "cover_stand", undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("pain_cover_crouch", _id_0C37::_id_CF04, undefined, undefined, _id_0C37::_id_4109, undefined, _id_0C37::_id_3EE6, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_cover", "cover_crouch", undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("pain_cover_left", _id_0C37::_id_CF04, undefined, undefined, _id_0C37::_id_4109, undefined, _id_0C37::_id_3EE5, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_cover", "cover_left", undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("pain_on_back", _id_0C37::_id_D4EE, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("pain_cover_left_suppress", _id_0C37::_id_CF04, undefined, undefined, _id_0C37::_id_4109, undefined, _id_0C37::_id_3EE5, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_cover", "cover_left", undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("pain_cover_right_suppress", _id_0C37::_id_CF04, undefined, undefined, _id_0C37::_id_4109, undefined, _id_0C37::_id_3EE5, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_cover", "cover_right", undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("exposed_reload", _id_0C38::reload, undefined, undefined, undefined, undefined, scripts\asm\shared\utility::_id_3EAA, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "reload", "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exposed_throw_grenade", _id_0C39::_id_CEC6, undefined, undefined, undefined, undefined, _id_0C39::_id_3EA8, undefined, undefined, undefined, undefined, undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, "throwgrenade", "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exposed_weaponswitch", _id_0C38::_id_CECB, undefined, undefined, undefined, undefined, scripts\asm\shared\utility::chooseanim_weaponswitch, undefined, undefined, undefined, undefined, undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exposed_stand_turn", _id_0C38::_id_D56A, undefined, undefined, _id_0C38::_id_116FF, undefined, _id_0C38::_id_3F0A, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_idle", 0, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "finish early");
  scripts\asm\asm::_id_2374("exposed_idle", _id_0C38::_id_D46D, undefined, undefined, undefined, undefined, _id_0F3C::_id_3EB3, "_aim_5", ["aim"], undefined, ["shoot_mp"], undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_throw_grenade", undefined, ::_id_12125, undefined);
  scripts\asm\asm::_id_2375("exposed_weaponswitch", undefined, _id_0C38::_id_100A9, undefined);
  scripts\asm\asm::_id_2375("exposed_stand_turn", undefined, _id_0C38::_id_BEA0, undefined);
  scripts\asm\asm::_id_2375("melee_stand_to_ready", undefined, scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::_id_2375("exposed_crouch_exit", undefined, ::_id_120FD, undefined);
  scripts\asm\asm::_id_2375("exposed_crouch_exit", undefined, ::_id_120FE, undefined);
  scripts\asm\asm::_id_2375("noncombat_stand_idle", undefined, _id_0C38::_id_10088, undefined);
  scripts\asm\asm::_id_2375("melee_charge", undefined, scripts\asm\asm_bb::bb_meleechargerequested, undefined);
  scripts\asm\asm::_id_2375("exposed_exit", undefined, scripts\asm\asm::_id_BCE7, "combat");
  scripts\asm\asm::_id_2375("exposed_reload", undefined, ::_id_12114, undefined);
  scripts\asm\asm::_id_2375("exposed_stand_to_crouch", undefined, scripts\asm\asm_bb::_id_2949, "crouch");
  scripts\asm\asm::_id_2375("exposed_stand_to_prone", undefined, scripts\asm\asm_bb::_id_2949, "prone");
  scripts\asm\asm::_id_2374("exposed_stand_to_prone", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_prone", 0, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exposed_prone", _id_0C38::_id_D46D, undefined, undefined, undefined, undefined, _id_0F3C::_id_3EAB, "_aim_5", undefined, "prone", undefined, undefined, "pain_prone", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_prone_to_stand", undefined, scripts\asm\asm_bb::_id_2949, "stand");
  scripts\asm\asm::_id_2375("exposed_prone_to_stand", undefined, scripts\asm\asm::_id_BCE7, undefined);
  scripts\asm\asm::_id_2375("exposed_prone_to_crouch", undefined, scripts\asm\asm_bb::_id_2949, "crouch");
  scripts\asm\asm::_id_2374("exposed_prone_to_stand", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_idle", 0, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exposed_stand_to_crouch", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_crouch", 0, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exposed_crouch", _id_0C38::_id_D46D, undefined, undefined, undefined, undefined, _id_0F3C::_id_3EAB, "_aim_5", ["aim"], "crouch", ["shoot_mp"], undefined, "pain_crouch", undefined, "death_crouching", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_crouch_to_stand", undefined, scripts\asm\asm_bb::_id_2949, "stand");
  scripts\asm\asm::_id_2375("exposed_crouch_to_stand", undefined, scripts\asm\asm::_id_BCE7, undefined);
  scripts\asm\asm::_id_2375("exposed_crouch_to_prone", undefined, scripts\asm\asm_bb::_id_2949, "prone");
  scripts\asm\asm::_id_2375("exposed_crouch_turn", undefined, _id_0C38::_id_BEA0, undefined);
  scripts\asm\asm::_id_2375("exposed_reload_crouch", undefined, ::_id_120ED, undefined);
  scripts\asm\asm::_id_2374("exposed_crouch_to_stand", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_idle", 0, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exposed_prone_to_crouch", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_crouch", 0, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exposed_crouch_to_prone", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_prone", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exposed_crouch_turn", _id_0C38::_id_D56A, undefined, undefined, undefined, undefined, _id_0C38::_id_3F0A, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_crouch", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2375("exposed_crouch", undefined, scripts\asm\asm::_id_68B0, "finish early");
  scripts\asm\asm::_id_2374("exposed_reload_crouch", _id_0C38::reload, undefined, undefined, undefined, undefined, scripts\asm\shared\utility::_id_3EAA, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "reload", "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_crouch", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("step_up_24", _id_0C3A::_id_D566, 24, undefined, undefined, "stand_run_loop", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("iw6_jumpdown_40", _id_0C3A::_id_D566, undefined, undefined, undefined, "stand_run_loop", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("step_down_24", _id_0C3A::_id_D566, undefined, undefined, undefined, "stand_run_loop", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("combatrun_forward_72", _id_0F3C::_id_CEA8, undefined, undefined, undefined, "stand_run_loop", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("wall_hop", _id_0C3A::_id_D55D, 39.875, undefined, undefined, "stand_run_loop", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jumpdown_130", _id_0C3A::_id_D566, undefined, undefined, undefined, "stand_run_loop", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jumpdown_96", _id_0C3A::_id_D566, undefined, undefined, undefined, "stand_run_loop", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("double_jump_temp", _id_0C3A::_id_D55E, undefined, undefined, undefined, "stand_run_loop", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("traverse_external", _id_0C3A::_id_D560, undefined, undefined, undefined, "stand_run_loop", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jump_down_fast", _id_0C3A::playtraverseanim_gravity, undefined, undefined, undefined, "stand_run_loop", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("wall_over_40", _id_0C3A::_id_D566, undefined, undefined, undefined, "stand_run_loop", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("dismember", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", undefined, 1);
  scripts\asm\asm::_id_2375("dismember_stand_choose_prone", undefined, ::_id_120AF, undefined);
  scripts\asm\asm::_id_2375("dismember_stand_choose_sit", undefined, ::_id_120B1, undefined);
  scripts\asm\asm::_id_2374("dismember_stand_l_leg_to_prone", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crouching", undefined, undefined, undefined, undefined, "face current", undefined, undefined);
  scripts\asm\asm::_id_2375("dismember_prone_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("dismember_stand_r_leg_to_prone", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crouching", undefined, undefined, undefined, undefined, "face current", undefined, undefined);
  scripts\asm\asm::_id_2375("dismember_prone_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("dismember_prone_crawl", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, ["shoot_mp"], undefined, undefined, undefined, "death_crouching", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::_id_2375("dismember_prone_idle", undefined, ::_id_12091, undefined);
  scripts\asm\asm::_id_2375("dismember_fast_crawl", undefined, ::_id_1208F, undefined);
  scripts\asm\asm::_id_2374("dismember_prone_idle", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, ["shoot_mp"], undefined, undefined, undefined, "death_crouching", undefined, undefined, undefined, undefined, "face enemy", undefined, undefined);
  scripts\asm\asm::_id_2375("dismember_prone_crawl", undefined, ::_id_12095, undefined);
  scripts\asm\asm::_id_2374("dismember_prone_sit_idle", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, ["shoot_mp"], undefined, undefined, undefined, "death_crouching", undefined, undefined, undefined, undefined, "face enemy", undefined, undefined);
  scripts\asm\asm::_id_2375("dismember_prone_sit_to_prone", undefined, ::_id_12099, undefined);
  scripts\asm\asm::_id_2374("dismember_stand_l_leg_to_sit", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crouching", undefined, undefined, undefined, undefined, "face current", undefined, undefined);
  scripts\asm\asm::_id_2375("dismember_prone_sit_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("dismember_stand_r_leg_to_sit", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crouching", undefined, undefined, undefined, undefined, "face current", undefined, undefined);
  scripts\asm\asm::_id_2375("dismember_prone_sit_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("dismember_stand_choose_prone", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", undefined, 1);
  scripts\asm\asm::_id_2375("dismember_stand_r_leg_to_prone", undefined, scripts\asm\asm_bb::bb_ispartdismembered, "right_leg");
  scripts\asm\asm::_id_2375("dismember_stand_l_leg_to_prone", undefined, ::_id_120A3, undefined);
  scripts\asm\asm::_id_2374("dismember_stand_choose_sit", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", undefined, 1);
  scripts\asm\asm::_id_2375("dismember_stand_r_leg_to_sit", undefined, scripts\asm\asm_bb::bb_ispartdismembered, "right_leg");
  scripts\asm\asm::_id_2375("dismember_stand_l_leg_to_sit", undefined, ::_id_120A9, undefined);
  scripts\asm\asm::_id_2374("dismember_prone_sit_to_prone", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crouching", undefined, undefined, undefined, undefined, "face current", undefined, undefined);
  scripts\asm\asm::_id_2375("dismember_prone_crawl", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("dismember_fast_crawl", _id_0C36::_id_D477, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_crouching", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("dismember_prone_idle", undefined, ::_id_12088, undefined);
  scripts\asm\asm::_id_2374("cover_right_arrival", _id_0F3A::_id_CEAA, undefined, undefined, undefined, undefined, _id_0F3A::_id_3E97, "Cover Right", undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "abort");
  scripts\asm\asm::_id_2374("cover_right_exit", _id_0F3B::_id_CEB5, undefined, undefined, undefined, undefined, _id_0F3B::_id_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "code_move");
  scripts\asm\asm::_id_2374("exposed_arrival", _id_0F3A::_id_CEAA, undefined, undefined, undefined, undefined, _id_0F3A::_id_3E97, "Exposed", undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "abort");
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2375("dismember", undefined, ::_id_120C6, undefined);
  scripts\asm\asm::_id_2374("exposed_exit", _id_0F3B::_id_CEB5, undefined, undefined, undefined, undefined, _id_0F3B::_id_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("melee_charge", undefined, scripts\asm\asm_bb::bb_meleechargerequested, undefined);
  scripts\asm\asm::_id_2375("dismember", undefined, ::_id_120F0, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "code_move");
  scripts\asm\asm::_id_2374("stand_run_loop", _id_0F3C::_id_D4DD, undefined, undefined, undefined, undefined, _id_0F3C::_id_3EB8, "run", ["(none)"], "stand", undefined, undefined, "pain_run", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::_id_2375("run_turn", undefined, _id_0F3B::_id_FFF8, "run_turn");
  scripts\asm\asm::_id_2375("cover_right_arrival", undefined, _id_0F3A::_id_1008A, "Cover Right");
  scripts\asm\asm::_id_2375("cover_left_arrival", undefined, _id_0F3A::_id_1008A, "Cover Left");
  scripts\asm\asm::_id_2375("exposed_arrival", undefined, _id_0F3A::_id_1008A, ["Exposed", 1]);
  scripts\asm\asm::_id_2375("cover_stand_arrival", undefined, _id_0F3A::_id_1008A, "Cover Stand");
  scripts\asm\asm::_id_2375("cover_crouch_arrival", undefined, _id_0F3A::_id_1008A, ["Cover Crouch", 1]);
  scripts\asm\asm::_id_2375("cover_left_crouch_arrival", undefined, _id_0F3A::_id_1008A, "Cover Left Crouch");
  scripts\asm\asm::_id_2375("cover_right_crouch_arrival", undefined, _id_0F3A::_id_1008A, "Cover Right Crouch");
  scripts\asm\asm::_id_2375("exposed_crouch_arrival", undefined, _id_0F3A::_id_1008A, ["Exposed Crouch", 1]);
  scripts\asm\asm::_id_2375("sprint_loop", undefined, ::_id_1257C, undefined);
  scripts\asm\asm::_id_2375("melee_charge", undefined, scripts\asm\asm_bb::bb_meleechargerequested, undefined);
  scripts\asm\asm::_id_2375("melee_charge_to_ready", undefined, scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::_id_2375("dismember", undefined, ::_id_12555, undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, ::_id_1255D, undefined);
  scripts\asm\asm::_id_2375("stand_run_strafe_loop", undefined, _id_0F3C::_id_100A3, "stand");
  scripts\asm\asm::_id_2375("stand_run_n_gun_loop", undefined, _id_0C36::_id_10070, undefined);
  scripts\asm\asm::_id_2375("stand_run_n_gun_backwards_loop", undefined, _id_0C36::_id_1006F, undefined);
  scripts\asm\asm::_id_2375("crouch_run_strafe_loop", undefined, _id_0F3C::_id_100A3, "crouch");
  scripts\asm\asm::_id_2374("run_turn", _id_0F3B::_id_D514, undefined, undefined, undefined, undefined, _id_0F3B::_id_3EF5, undefined, undefined, undefined, undefined, undefined, "pain_run", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "code_move");
  scripts\asm\asm::_id_2374("cover_left_arrival", _id_0F3A::_id_CEAA, undefined, undefined, undefined, undefined, _id_0F3A::_id_3E97, "Cover Left", undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "abort");
  scripts\asm\asm::_id_2374("cover_left_exit", _id_0F3B::_id_CEB5, undefined, undefined, undefined, undefined, _id_0F3B::_id_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "code_move");
  scripts\asm\asm::_id_2374("cover_crouch_exit", _id_0F3B::_id_CEB5, undefined, undefined, undefined, undefined, _id_0F3B::_id_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "code_move");
  scripts\asm\asm::_id_2374("cover_crouch_arrival", _id_0F3A::_id_CEAA, undefined, undefined, undefined, undefined, _id_0F3A::_id_3E97, "Cover Crouch", undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "abort");
  scripts\asm\asm::_id_2374("cover_stand_exit", _id_0F3B::_id_CEB5, undefined, undefined, undefined, undefined, _id_0F3B::_id_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "code_move");
  scripts\asm\asm::_id_2374("cover_stand_arrival", _id_0F3A::_id_CEAA, undefined, undefined, undefined, undefined, _id_0F3A::_id_3E97, "Cover Stand", undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "abort");
  scripts\asm\asm::_id_2374("stand_run_strafe_loop", _id_0F3B::_id_D4E5, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, ["aim"], "stand", ["shoot_mp"], undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "code_move", undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, ::_id_12594, undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, ::_id_12595, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, _id_0F3C::_id_FFB6, "stand");
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm_bb::bb_meleechargerequested, undefined);
  scripts\asm\asm::_id_2374("stand_run_n_gun_loop", _id_0C36::_id_D50D, undefined, undefined, _id_0C36::_id_11088, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, ["shoot_mp"], undefined, "pain_run", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::_id_2375("stand_run_n_gun_backwards_loop", undefined, _id_0C36::_id_1006F, undefined);
  scripts\asm\asm::_id_2375("run_turn", undefined, _id_0F3B::_id_FFF8, "run_turn");
  scripts\asm\asm::_id_2375("exposed_reload", undefined, ::_id_12591, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, _id_0C36::_id_1009F, undefined);
  scripts\asm\asm::_id_2374("stand_run_n_gun_backwards_loop", _id_0C36::_id_D50E, undefined, undefined, _id_0C36::_id_11088, undefined, _id_0F3C::_id_3E96, "move_back", undefined, undefined, ["shoot_mp"], undefined, "pain_run", undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "code_move", undefined);
  scripts\asm\asm::_id_2375("stand_run_n_gun_loop", undefined, _id_0C36::_id_10070, undefined);
  scripts\asm\asm::_id_2375("run_turn", undefined, _id_0F3B::_id_FFF8, "run_turn");
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, _id_0C36::_id_1009E, undefined);
  scripts\asm\asm::_id_2374("cover_left_crouch_exit", _id_0F3B::_id_CEB5, undefined, undefined, undefined, undefined, _id_0F3B::_id_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "code_move");
  scripts\asm\asm::_id_2374("cover_right_crouch_exit", _id_0F3B::_id_CEB5, undefined, undefined, undefined, undefined, _id_0F3B::_id_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "code_move");
  scripts\asm\asm::_id_2374("cover_left_crouch_arrival", _id_0F3A::_id_CEAA, undefined, undefined, undefined, undefined, _id_0F3A::_id_3E97, "Cover Left Crouch", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "abort");
  scripts\asm\asm::_id_2374("cover_right_crouch_arrival", _id_0F3A::_id_CEAA, undefined, undefined, undefined, undefined, _id_0F3A::_id_3E97, "Cover Right Crouch", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "abort");
  scripts\asm\asm::_id_2374("exposed_crouch_arrival", _id_0F3A::_id_CEAA, undefined, undefined, undefined, undefined, _id_0F3A::_id_3E97, "Exposed Crouch", undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "abort");
  scripts\asm\asm::_id_2375("exposed_crouch", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exposed_crouch_exit", _id_0F3B::_id_CEB5, undefined, undefined, undefined, undefined, _id_0F3B::_id_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "code_move");
  scripts\asm\asm::_id_2374("sprint_loop", _id_0F3C::_id_D4DD, undefined, undefined, undefined, undefined, _id_0C36::_id_3EFF, undefined, undefined, undefined, undefined, undefined, "pain_run", undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, ::_id_12511, undefined);
  scripts\asm\asm::_id_2375("dismember", undefined, ::_id_124F8, undefined);
  scripts\asm\asm::_id_2374("crouch_run_strafe_loop", _id_0F3B::_id_D4E5, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, ["aim"], "stand", ["shoot_mp"], undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "code_move", undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, _id_0F3C::_id_FFB6, "crouch");
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm_bb::bb_meleechargerequested, undefined);
  scripts\asm\asm::_id_2374("move_walk_loop", _id_0F3C::_id_D4DD, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::_id_2375("noncombat_stand_idle", undefined, ::_id_122B0, undefined);
  scripts\asm\asm::_id_2374("intro", _id_0C38::_id_D4B2, undefined, undefined, _id_0C38::_id_116EC, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("noncombat_stand_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exit", _id_0C38::_id_D4EC, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("introloop", _id_0C38::_id_D4B3, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("intro", undefined, scripts\asm\asm::_id_68B0, "introdone");
  scripts\asm\asm::_id_2327();
}

_id_122DB(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

_id_122E1(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_isincombat();
}

_id_122D7(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_isincombat();
}

_id_11B94(var_0, var_1, var_2, var_3) {
  return 1;
}

_id_12265(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_ismissingaleg();
}

_id_12260(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_ismissingaleg();
}

_id_12288(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_ismissingaleg();
}

_id_12263(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_ismissingaleg();
}

_id_123D9(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_ismissingaleg() && self.a.pose == "stand";
}

_id_123D0(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_ismissingaleg() && self.a.pose == "stand";
}

_id_12125(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_throwgrenaderequested();
}

_id_120FD(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested() && self._blackboard.movetype == "combat" && _id_0F3C::_id_138E2();
}

_id_120FE(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard._id_2BDF) && self._blackboard._id_2BDF && _id_0F3C::_id_138E2();
}

_id_12114(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_reloadrequested();
}

_id_120ED(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_reloadrequested();
}

_id_120AF(var_0, var_1, var_2, var_3) {
  return scripts\engine\utility::cointoss();
}

_id_120B1(var_0, var_1, var_2, var_3) {
  return 1;
}

_id_12091(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

_id_1208F(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::_id_2921();
}

_id_12095(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

_id_12099(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

_id_120A3(var_0, var_1, var_2, var_3) {
  return 1;
}

_id_120A9(var_0, var_1, var_2, var_3) {
  return 1;
}

_id_12088(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

_id_120C6(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_ismissingaleg();
}

_id_120F0(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_ismissingaleg();
}

_id_1257C(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("sprint");
}

_id_12555(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_ismissingaleg();
}

_id_1255D(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

_id_12594(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

_id_12595(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_reloadrequested();
}

_id_12591(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_reloadrequested();
}

_id_12511(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_movetyperequested("sprint");
}

_id_124F8(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_ismissingaleg();
}

_id_122B0(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}