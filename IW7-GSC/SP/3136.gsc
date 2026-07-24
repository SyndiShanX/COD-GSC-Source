/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3136.gsc
**************************************/

_id_2371() {
  if(scripts\asm\asm::_id_232E("c8")) {
    return;
  }
  _id_0C58::_id_2371();
  scripts\asm\asm::_id_230B("c8", "c8_start");
  scripts\asm\asm::_id_2373("track", _id_0C3D::_id_34EA);
  scripts\asm\asm::_id_2374("Knobs", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("c8_start", _id_0C3D::_id_3420, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", undefined, undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("AnimScripted", _id_0F3D::_id_1FCB, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("AnimScripted_complete", undefined, ::_id_11B58, undefined);
  scripts\asm\asm::_id_2374("traverse_external", _id_0C6B::_id_D560, undefined, undefined, undefined, "exposed_idle", _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("melee_charge_attack", _id_0C3D::_id_34A3, [0.42, 1], undefined, undefined, undefined, _id_0C3D::_id_3435, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "melee_attack", undefined, "zonly_physics", undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("melee_charge", _id_0C3D::_id_349D, undefined, undefined, _id_0C3D::_id_349E, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "melee_charge_state", "face motion", "normal", undefined);
  scripts\asm\asm::_id_2375("melee_charge_attack", undefined, scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::_id_2375("melee_charge_continue", undefined, _id_0C3D::_id_3423, undefined);
  scripts\asm\asm::_id_2375("exposed_arrival", undefined, scripts\asm\asm_bb::_id_2957, undefined);
  scripts\asm\asm::_id_2374("melee_attack", _id_0C3D::_id_34A3, [undefined, 1], undefined, undefined, undefined, _id_0C3D::_id_3435, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "melee_attack", undefined, "zonly_physics", undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("melee_charge_continue", _id_0C3D::_id_3496, undefined, undefined, _id_0C3D::_id_3497, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, "pain_run", undefined, "death_moving", undefined, undefined, undefined, "melee_rush_state", "face current", "zonly_physics", undefined);
  scripts\asm\asm::_id_2375("exposed_arrival", undefined, _id_0C3D::_id_34B6, undefined);
  scripts\asm\asm::_id_2375("melee_rush_attack", undefined, scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::_id_2374("melee_rush_attack", _id_0C3D::_id_34A3, [0.42, 0], undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "melee_attack", undefined, "zonly_physics", undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("powerdown_default", _id_0C3F::_id_D4FF, undefined, undefined, _id_0C3F::_id_697A, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::_id_2375("exposed_idle", 1, ::_id_12408, undefined);
  scripts\asm\asm::_id_2374("pain_stand", _id_0C3D::_id_34A7, undefined, undefined, _id_0C3D::_id_34A8, undefined, _id_0C3E::_id_3EA2, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_standing", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::_id_2375("pain_complete", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("pain_run", _id_0C3D::_id_34A7, undefined, undefined, _id_0C3D::_id_34A8, undefined, _id_0C3E::_id_3EA2, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::_id_2375("pain_complete", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2375("selfdestruct_run", undefined, _id_0A26::_id_C875, undefined);
  scripts\asm\asm::_id_2374("pain_shock", _id_0C3D::_id_34A9, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_standing", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::_id_2375("pain_shock_complete", undefined, scripts\asm\asm::_id_68B0, "stop_loop_pain");
  scripts\asm\asm::_id_2374("pain_stun_loop", _id_0C3D::_id_3493, undefined, undefined, _id_0C3D::_id_34A8, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_standing", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "pain_stun_end");
  scripts\asm\asm::_id_2374("pain_complete", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("pain_stun_loop", undefined, _id_0C3D::_id_34D7, undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("pain_shock_complete", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("antigrav_float_idle", undefined, _id_0C3D::_id_34D5, undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("dismember", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("dismember_right_arm", undefined, scripts\asm\asm_bb::bb_ispartdismembered, "right_arm");
  scripts\asm\asm::_id_2375("dismember_left_arm", undefined, scripts\asm\asm_bb::bb_ispartdismembered, "left_arm");
  scripts\asm\asm::_id_2374("dismember_right_arm", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0A26::_id_3ED1, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "dismember_done", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("selfdestruct_run", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2375("selfdestruct_run", undefined, ::_id_1209D, undefined);
  scripts\asm\asm::_id_2374("selfdestruct_run", _id_0F3D::_id_D4DD, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, ["(none)"], undefined, undefined, undefined, "pain_run", undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy or motion", "normal", undefined);
  scripts\asm\asm::_id_2375("selfdestruct_stop", undefined, _id_0A26::_id_10073, undefined);
  scripts\asm\asm::_id_2375("selfdestruct_stop", undefined, scripts\asm\asm::_id_C17F, undefined);
  scripts\asm\asm::_id_2374("dismember_left_arm", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("selfdestruct_stop", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0A26::_id_3ED1, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("selfdestruct_run", undefined, scripts\asm\asm::_id_BCE7, undefined);
  scripts\asm\asm::_id_2374("isselfdestruct", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("selfdestruct_run", undefined, scripts\asm\asm::_id_BCE7, undefined);
  scripts\asm\asm::_id_2375("selfdestruct_stop", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("death_generic", _id_0C60::_id_CF0E, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("death_standing", _id_0C60::_id_CF0E, undefined, undefined, undefined, undefined, _id_0C3E::_id_3433, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("death_moving", _id_0C60::_id_CF0E, undefined, undefined, undefined, undefined, _id_0C60::_id_3EE2, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("death_antigrav_grenade", _id_0C60::_id_CF11, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("shield_upper_aims", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("shield_lower_aims", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("shield_aim_knobs", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("torso_aims", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("gun_arm_aims", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("shield_openclose", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("exposed_stand_turn", _id_0C3D::_id_34AA, undefined, undefined, _id_0C3D::_id_34AB, undefined, _id_0C3D::_id_3437, undefined, ["aim"], undefined, ["shoot_c8"], undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::_id_2375("exposed_idle", 0, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "finish early");
  scripts\asm\asm::_id_2374("exposed_idle", _id_0C3D::_id_34A1, undefined, undefined, _id_0C3D::_id_34A2, undefined, _id_0C3D::_id_3432, "_aim_5", ["aim"], undefined, ["shoot_c8"], undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "angle deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_stand_turn", undefined, _id_0C3D::_id_3485, undefined);
  scripts\asm\asm::_id_2375("melee_attack", undefined, scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::_id_2375("isselfdestruct", undefined, ::_id_12140, undefined);
  scripts\asm\asm::_id_2375("exposed_throw_grenade", undefined, _id_0C3D::_id_3424, undefined);
  scripts\asm\asm::_id_2375("exposed_exit", undefined, scripts\asm\asm_bb::bb_meleechargerequested, undefined);
  scripts\asm\asm::_id_2375("exposed_stand_turn", undefined, _id_0C3D::_id_3484, undefined);
  scripts\asm\asm::_id_2375("exposed_shield_plant", undefined, _id_0C3D::_id_34CB, undefined);
  scripts\asm\asm::_id_2375("exposed_idle_to_move", undefined, _id_0C3D::_id_3482, undefined);
  scripts\asm\asm::_id_2374("exposed_shield_plant", _id_0C3D::_id_3498, undefined, undefined, _id_0C3D::_id_349A, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exposed_throw_grenade", _id_0C3D::_id_349B, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, "throwgrenade", undefined, "zonly_physics", undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exposed_arrival", _id_0C3D::_id_3494, undefined, undefined, _id_0C3D::_id_CEAB, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_standing", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "abort");
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exposed_exit", _id_0C3D::_id_3495, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::_id_2375("exposed_exit_complete", undefined, scripts\asm\asm::_id_68B0, "code_move");
  scripts\asm\asm::_id_2375("exposed_exit_complete", undefined, scripts\asm\asm::_id_68B0, "finish");
  scripts\asm\asm::_id_2375("exposed_exit_complete", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("stand_run_loop", _id_0F3D::_id_D4DD, undefined, undefined, undefined, undefined, scripts\asm\shared\utility::choosedemeanoranimwithoverride, "run", undefined, "stand", undefined, undefined, "pain_run", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "normal", undefined);
  scripts\asm\asm::_id_2375("exposed_arrival", undefined, scripts\asm\asm::_id_C17F, undefined);
  scripts\asm\asm::_id_2375("melee_charge", undefined, scripts\asm\asm_bb::bb_meleechargerequested, undefined);
  scripts\asm\asm::_id_2375("melee_charge_attack", undefined, scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::_id_2375("stand_walk_loop", undefined, scripts\asm\asm::_id_BCE7, "walk");
  scripts\asm\asm::_id_2375("exposed_idle", 0, ::_id_12558, undefined);
  scripts\asm\asm::_id_2374("stand_walk_loop", _id_0C3D::_id_34A5, 1.3, undefined, _id_0C3D::_id_3481, undefined, _id_0C65::_id_3F03, undefined, ["aim"], undefined, ["shoot_c8"], undefined, "pain_run", undefined, "death_moving", undefined, undefined, undefined, undefined, "face enemy or motion", "normal", undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm_bb::_id_2958, undefined);
  scripts\asm\asm::_id_2375("melee_charge", undefined, scripts\asm\asm_bb::bb_meleechargerequested, undefined);
  scripts\asm\asm::_id_2375("melee_charge_attack", undefined, scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::_id_2375("exposed_walk_arrival", undefined, _id_0C3D::_id_1008D, undefined);
  scripts\asm\asm::_id_2374("exposed_walk_arrival", _id_0C3D::_id_348F, undefined, undefined, _id_0C3D::_id_CEAB, undefined, _id_0C3D::_id_342F, undefined, ["aim"], undefined, ["shoot_c8"], undefined, "pain_stand", undefined, "death_moving", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::_id_2375("stand_walk_loop", undefined, scripts\asm\asm::_id_68B0, "abort");
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("walk_turn", _id_0C65::_id_D514, undefined, undefined, undefined, undefined, _id_0C65::_id_3EF5, undefined, ["aim"], undefined, ["shoot_c8"], undefined, "pain_run", undefined, "death_moving", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::_id_2374("exposed_walk_exit", _id_0C3D::_id_3492, 1, undefined, undefined, undefined, _id_0C3D::_id_3431, undefined, ["aim"], undefined, ["shoot_c8"], undefined, "pain_stand", undefined, "death_moving", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::_id_2375("stand_walk_loop", undefined, scripts\asm\asm::_id_68B0, "finish");
  scripts\asm\asm::_id_2375("stand_walk_loop", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2375("stand_walk_loop", undefined, scripts\asm\asm::_id_68B0, "code_move");
  scripts\asm\asm::_id_2374("exposed_idle_to_move", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("exposed_walk_exit", undefined, scripts\asm\asm::_id_BCE7, "walk");
  scripts\asm\asm::_id_2375("exposed_exit", undefined, scripts\asm\asm::_id_BCE7, "combat");
  scripts\asm\asm::_id_2374("exposed_exit_complete", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("melee_charge", undefined, scripts\asm\asm_bb::bb_meleechargerequested, undefined);
  scripts\asm\asm::_id_2375("melee_charge_continue", undefined, _id_0C3D::_id_3423, undefined);
  scripts\asm\asm::_id_2375("stand_walk_loop", undefined, scripts\asm\asm::_id_BCE7, "walk");
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_BCE7, "combat");
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("antigrav_rise", _id_0F41::_id_CEE2, undefined, undefined, undefined, undefined, _id_0F41::_id_3EB1, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_antigrav_grenade", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::_id_2375("antigrav_float_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2375("antigrav_fall", undefined, _id_0F41::_id_2012, undefined);
  scripts\asm\asm::_id_2374("antigrav_float_idle", _id_0F41::_id_CEE0, undefined, undefined, undefined, undefined, _id_0F41::_id_3EB0, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_antigrav_grenade", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::_id_2375("antigrav_fall", undefined, _id_0F41::_id_2012, undefined);
  scripts\asm\asm::_id_2374("antigrav_fall", _id_0F41::_id_CEDC, undefined, undefined, _id_0F41::_id_CEDB, undefined, _id_0F41::_id_3EAD, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_antigrav_grenade", undefined, undefined, undefined, undefined, "face current", "gravity", undefined);
  scripts\asm\asm::_id_2375("antigrav_rise", undefined, _id_0F41::_id_197C, undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("AnimScripted_complete", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_BCE7, "combat");
  scripts\asm\asm::_id_2375("stand_walk_loop", undefined, scripts\asm\asm::_id_BCE7, "walk");
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2327();
}

_id_11B58(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_isanimScripted();
}

_id_12408(var_0, var_1, var_2, var_3) {
  return !isDefined(self.bpowerdown) || !self.bpowerdown;
}

_id_1209D(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

_id_12140(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_isselfdestruct();
}

_id_12558(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}