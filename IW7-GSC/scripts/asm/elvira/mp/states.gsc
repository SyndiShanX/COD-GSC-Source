/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\elvira\mp\states.gsc
********************************************/

_id_2371() {
  if(scripts\asm\asm::_id_232E("elvira")) {
    return;
  }
  scripts\asm\shoot_dlc3\mp\states::_id_2371();
  scripts\asm\asm::_id_230B("elvira", "c6_start");
  scripts\asm\asm::_id_2374("enter_combat", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, ["shoot_dlc3"], undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("noncombat_stand_idle", _id_0F3C::_id_B050, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, "noncombat_stand_idle", undefined, undefined, undefined, undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_exit", undefined, ::_id_122DB, undefined);
  scripts\asm\asm::_id_2375("move_walk_loop", undefined, scripts\asm\asm::_id_BCE7, "walk");
  scripts\asm\asm::_id_2375("exposed_idle", undefined, ::_id_122E1, undefined);
  scripts\asm\asm::_id_2375("exit", undefined, _id_0C38::_id_FFF3, undefined);
  scripts\asm\asm::_id_2375("check_actions", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2375("enter_combat", undefined, ::_id_122D7, undefined);
  scripts\asm\asm::_id_2374("c6_start", scripts\asm\elvira\elvira_asm::elvirainit, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", 1);
  scripts\asm\asm::_id_2375("intro", undefined, _id_0C38::_id_FFEF, undefined);
  scripts\asm\asm::_id_2375("noncombat_stand_idle", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("exposed_aimset", undefined, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2374("strafe_aimset", undefined, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2374("death_generic", _id_0C34::_id_CF0E, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("death_standing", _id_0C34::_id_CF0E, undefined, undefined, undefined, undefined, _id_0C34::_id_3F00, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("death_crouching", _id_0C34::_id_CF0E, undefined, undefined, undefined, undefined, _id_0C34::_id_3ECA, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("death_moving", _id_0C34::_id_CF0E, undefined, undefined, undefined, undefined, _id_0C34::_id_3EE2, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("death_cover", _id_0C34::_id_CF0E, undefined, undefined, undefined, undefined, _id_0C34::_id_3EC6, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("pain_stand", _id_0C37::_id_D4EE, undefined, undefined, _id_0C37::_id_4109, undefined, _id_0C37::_id_3EEC, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("pain_run", _id_0C37::_id_D4EE, undefined, undefined, _id_0C37::_id_4109, undefined, _id_0C37::_id_3EEB, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
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
  scripts\asm\asm::_id_2374("exposed_idle", _id_0C38::_id_D46D, undefined, undefined, undefined, undefined, _id_0F3C::_id_3EB3, "_aim_5", ["aim"], undefined, ["shoot_dlc3"], undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_throw_grenade", undefined, ::_id_12125, undefined);
  scripts\asm\asm::_id_2375("exposed_weaponswitch", undefined, _id_0C38::_id_100A9, undefined);
  scripts\asm\asm::_id_2375("exposed_stand_turn", undefined, _id_0C38::_id_BEA0, undefined);
  scripts\asm\asm::_id_2375("exposed_crouch_exit", undefined, ::trans_exposed_idle_to_exposed_crouch_exit3, undefined);
  scripts\asm\asm::_id_2375("exposed_crouch_exit", undefined, ::_id_120FD, undefined);
  scripts\asm\asm::_id_2375("noncombat_stand_idle", undefined, _id_0C38::_id_10088, undefined);
  scripts\asm\asm::_id_2375("check_actions", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2375("exposed_exit", undefined, scripts\asm\asm::_id_BCE7, "combat");
  scripts\asm\asm::_id_2375("exposed_reload", undefined, ::_id_12113, undefined);
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
  scripts\asm\asm::_id_2374("exposed_crouch", _id_0C38::_id_D46D, undefined, undefined, undefined, undefined, _id_0F3C::_id_3EAB, "_aim_5", ["aim"], "crouch", ["shoot_dlc3"], undefined, "pain_crouch", undefined, "death_crouching", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
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
  scripts\asm\asm::_id_2374("traverse_external", scripts\asm\elvira\elvira_asm::dotraverseteleport, undefined, undefined, scripts\asm\elvira\elvira_asm::terminate_traverseexternal, "stand_run_loop", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", undefined, undefined);
  scripts\asm\asm::_id_2374("jump_down_fast", _id_0C3A::playtraverseanim_gravity, undefined, undefined, undefined, "stand_run_loop", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("wall_over_40", _id_0C3A::_id_D566, undefined, undefined, undefined, "stand_run_loop", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("cover_right_arrival", _id_0F3A::_id_CEAA, undefined, undefined, undefined, undefined, _id_0F3A::_id_3E97, "Cover Right", undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "abort");
  scripts\asm\asm::_id_2374("cover_right_exit", _id_0F3B::_id_CEB5, undefined, undefined, undefined, undefined, _id_0F3B::_id_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "code_move");
  scripts\asm\asm::_id_2374("exposed_arrival", _id_0F3A::_id_CEAA, undefined, undefined, undefined, undefined, _id_0F3A::_id_3E97, "Exposed", undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "abort");
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exposed_exit", _id_0F3B::_id_CEB5, undefined, undefined, undefined, undefined, _id_0F3B::_id_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
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
  scripts\asm\asm::_id_2375("check_actions", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, ::_id_1255B, undefined);
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
  scripts\asm\asm::_id_2374("stand_run_strafe_loop", _id_0F3B::_id_D4E5, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, ["aim"], "stand", ["shoot_dlc3"], undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "code_move", undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, ::_id_12594, undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, ::_id_12595, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, _id_0F3C::_id_FFB6, "stand");
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm_bb::bb_meleechargerequested, undefined);
  scripts\asm\asm::_id_2374("stand_run_n_gun_loop", _id_0C36::_id_D50D, undefined, undefined, _id_0C36::_id_11088, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, ["shoot_dlc3"], undefined, "pain_run", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::_id_2375("stand_run_n_gun_backwards_loop", undefined, _id_0C36::_id_1006F, undefined);
  scripts\asm\asm::_id_2375("run_turn", undefined, _id_0F3B::_id_FFF8, "run_turn");
  scripts\asm\asm::_id_2375("exposed_reload", undefined, ::_id_12591, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, _id_0C36::_id_1009F, undefined);
  scripts\asm\asm::_id_2374("stand_run_n_gun_backwards_loop", _id_0C36::_id_D50E, undefined, undefined, _id_0C36::_id_11088, undefined, _id_0F3C::_id_3E96, "move_back", undefined, undefined, ["shoot_dlc3"], undefined, "pain_run", undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "code_move", undefined);
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
  scripts\asm\asm::_id_2374("crouch_run_strafe_loop", _id_0F3B::_id_D4E5, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, ["aim"], "stand", ["shoot_dlc3"], undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "code_move", undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, _id_0F3C::_id_FFB6, "crouch");
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm_bb::bb_meleechargerequested, undefined);
  scripts\asm\asm::_id_2374("move_walk_loop", _id_0F3C::_id_D4DD, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::_id_2375("noncombat_stand_idle", undefined, ::_id_122B0, undefined);
  scripts\asm\asm::_id_2374("intro", _id_0C38::_id_D4B2, undefined, undefined, _id_0C38::_id_116EC, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("noncombat_stand_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exit", _id_0C38::_id_D4EC, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("check_actions", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("revive_player", undefined, scripts\asm\elvira\elvira_asm::shoulddoaction, undefined);
  scripts\asm\asm::_id_2375("reload", undefined, scripts\asm\elvira\elvira_asm::shoulddoaction, undefined);
  scripts\asm\asm::_id_2375("melee", undefined, scripts\asm\elvira\elvira_asm::shoulddoaction, undefined);
  scripts\asm\asm::_id_2375("cast_reveal_spell", undefined, scripts\asm\elvira\elvira_asm::shoulddoaction, undefined);
  scripts\asm\asm::_id_2375("cast_return_spell", undefined, scripts\asm\elvira\elvira_asm::shoulddoaction, undefined);
  scripts\asm\asm::_id_2375("cast_spell", undefined, scripts\asm\elvira\elvira_asm::shoulddoaction, undefined);
  scripts\asm\asm::_id_2374("revive_player", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("revive_player_intro", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("revive_player_intro", scripts\asm\elvira\elvira_asm::playreviveanim, undefined, undefined, undefined, undefined, scripts\asm\elvira\elvira_asm::choosereviveanim, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("action_done", undefined, scripts\asm\elvira\elvira_asm::isanimdone, undefined);
  scripts\asm\asm::_id_2374("action_done", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("noncombat_stand_idle", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("reload", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("exposed_reload", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("melee", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("melee_stand_to_ready", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("melee_stand_to_ready", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("melee_attack", undefined, scripts\asm\elvira\elvira_asm::isanimdone, undefined);
  scripts\asm\asm::_id_2374("melee_attack", _id_0C35::_id_D4D7, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "melee_attack", "face enemy", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("action_done", undefined, scripts\asm\elvira\elvira_asm::isanimdone, undefined);
  scripts\asm\asm::_id_2374("cast_reveal_spell", scripts\asm\elvira\elvira_asm::playrevealspellanim, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("action_done", undefined, scripts\asm\elvira\elvira_asm::isanimdone, undefined);
  scripts\asm\asm::_id_2374("cast_return_spell", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("action_done", undefined, scripts\asm\elvira\elvira_asm::isanimdone, undefined);
  scripts\asm\asm::_id_2374("cast_spell", scripts\asm\elvira\elvira_asm::playcastspellanim, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("action_done", undefined, scripts\asm\elvira\elvira_asm::isanimdone, undefined);
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

_id_12125(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_throwgrenaderequested();
}

trans_exposed_idle_to_exposed_crouch_exit3(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested() && self._blackboard.movetype == "combat" && _id_0F3C::_id_138E2();
}

_id_120FD(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard._id_2BDF) && self._blackboard._id_2BDF && _id_0F3C::_id_138E2();
}

_id_12113(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_reloadrequested();
}

_id_120ED(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_reloadrequested();
}

_id_1257C(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("sprint");
}

_id_1255B(var_0, var_1, var_2, var_3) {
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

_id_122B0(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}