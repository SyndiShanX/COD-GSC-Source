/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3144.gsc
************************/

func_2371() {
  if(scripts\asm\asm::func_232E("C12")) {
    return;
  }

  lib_0C59::func_2371();
  lib_0C5A::func_2371();
  scripts\asm\asm::func_230B("C12", "start");
  scripts\asm\asm::func_2373("track", ::lib_0C41::func_3627);
  scripts\asm\asm::func_2374("start", ::lib_0C42::func_35A6, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("combat_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("combat_idle", ::lib_0C45::func_35DE, undefined, undefined, ::lib_0C45::func_35DF, undefined, ::lib_0F3D::func_3E96, undefined, ["aim"], undefined, ["shoot_c12_left", "shoot_c12_right"], undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2375("melee_grab", undefined, ::scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::func_2375("stand_turn", undefined, ::lib_0C45::func_BEA0, undefined);
  scripts\asm\asm::func_2375("move_requested", undefined, ::func_11BF4, undefined);
  scripts\asm\asm::func_2374("Knobs", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("stand_turn", ::lib_0C45::func_CEC3, undefined, undefined, undefined, undefined, ::lib_0C45::func_3EA7, undefined, ["aim"], undefined, ["shoot_c12_left", "shoot_c12_right"], undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("combat_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("aimset_left", ::lib_0F3D::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("aimset_minigun", ::lib_0F3D::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("aim_body", ::lib_0F3D::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("aimset_right", ::lib_0F3D::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("aim_parent_knob", ::lib_0F3D::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("custom_exit", ::lib_0C65::func_CEB5, undefined, undefined, undefined, undefined, ::lib_0C65::func_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("run", undefined, ::func_1206F, undefined);
  scripts\asm\asm::func_2374("custom_arrival", ::lib_0C5D::func_CEAA, undefined, undefined, undefined, undefined, ::lib_0C5D::func_3E97, "Custom", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("custom_idle", undefined, ::lib_0C5F::func_10097, undefined);
  scripts\asm\asm::func_2375("run", undefined, ::func_1205A, undefined);
  scripts\asm\asm::func_2374("AnimScripted", ::lib_0F3D::func_1FCB, undefined, undefined, ::lib_0F3D::func_1FCC, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("custom_exit", undefined, ::func_11B5C, undefined);
  scripts\asm\asm::func_2375("run", undefined, ::lib_0F3D::func_10033, [1, "combat"]);
  scripts\asm\asm::func_2375("walk", undefined, ::lib_0F3D::func_10033, [1, "casual"]);
  scripts\asm\asm::func_2375("custom_idle", undefined, ::func_11B63, undefined);
  scripts\asm\asm::func_2375("combat_idle", undefined, ::func_11B59, undefined);
  scripts\asm\asm::func_2374("custom_idle", ::lib_0F3D::func_B050, undefined, undefined, undefined, undefined, ::lib_0C5F::func_3E9C, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("custom_exit", undefined, ::lib_0C5F::func_FFDE, undefined);
  scripts\asm\asm::func_2374("pain_generic", ::lib_0C46::func_D4EE, undefined, undefined, ::lib_0C46::func_4109, undefined, ::lib_0C46::func_3EE4, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2375("combat_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("pain_emp_enter_left", ::lib_0C46::func_D542, undefined, undefined, ::lib_0C46::func_411A, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pain_emp_stun_left", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("pain_emp_stun_left", ::lib_0C46::func_CF37, undefined, undefined, ::lib_0C46::func_411A, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pain_emp_recover_left", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("pain_emp_recover_left", ::lib_0C46::func_D542, undefined, undefined, ::lib_0C46::func_411A, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("combat_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("pain_emp_left", ::lib_0F3D::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("pain_emp_enter_left_leg_l", undefined, ::scripts\asm\asm_bb::bb_ispartdismembered, "left_leg");
  scripts\asm\asm::func_2375("pain_emp_enter_left_leg_r", undefined, ::scripts\asm\asm_bb::bb_ispartdismembered, "right_leg");
  scripts\asm\asm::func_2375("pain_emp_enter_left", undefined, ::func_12376, undefined);
  scripts\asm\asm::func_2374("pain_emp_enter_left_leg_l", ::lib_0C46::func_D542, undefined, undefined, ::lib_0C46::func_411A, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pain_emp_stun_left_leg_l", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("pain_emp_stun_left_leg_l", ::lib_0C46::func_CF37, undefined, undefined, ::lib_0C46::func_411A, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pain_emp_recover_left_leg_l", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("pain_emp_recover_left_leg_l", ::lib_0C46::func_D542, undefined, undefined, ::lib_0C46::func_411A, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("dismember_leg_l_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("pain_emp_enter_left_leg_r", ::lib_0C46::func_D542, undefined, undefined, ::lib_0C46::func_411A, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pain_emp_stun_left_leg_r", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("pain_emp_stun_left_leg_r", ::lib_0C46::func_CF37, undefined, undefined, ::lib_0C46::func_411A, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pain_emp_recover_left_leg_r", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("pain_emp_recover_left_leg_r", ::lib_0C46::func_D542, undefined, undefined, ::lib_0C46::func_411A, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("dismember_leg_r_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("pain_emp_enter_right", ::lib_0C46::func_D542, undefined, undefined, ::lib_0C46::func_411A, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pain_emp_stun_right", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("combat_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("pain_emp_stun_right", ::lib_0C46::func_CF37, undefined, undefined, ::lib_0C46::func_411A, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pain_emp_recover_right", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("pain_emp_recover_right", ::lib_0C46::func_D542, undefined, undefined, ::lib_0C46::func_411A, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("combat_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("pain_emp_right", ::lib_0F3D::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("pain_emp_enter_right_leg_l", undefined, ::scripts\asm\asm_bb::bb_ispartdismembered, "left_leg");
  scripts\asm\asm::func_2375("pain_emp_enter_right_leg_r", undefined, ::scripts\asm\asm_bb::bb_ispartdismembered, "right_leg");
  scripts\asm\asm::func_2375("pain_emp_enter_right", undefined, ::func_12377, undefined);
  scripts\asm\asm::func_2374("pain_emp_enter_right_leg_l", ::lib_0C46::func_D542, undefined, undefined, ::lib_0C46::func_411A, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pain_emp_stun_right_leg_l", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("pain_emp_stun_right_leg_l", ::lib_0C46::func_CF37, undefined, undefined, ::lib_0C46::func_411A, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pain_emp_recover_right_leg_l", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("pain_emp_recover_right_leg_l", ::lib_0C46::func_D542, undefined, undefined, ::lib_0C46::func_411A, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("dismember_leg_l_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("pain_emp_enter_right_leg_r", ::lib_0C46::func_D542, undefined, undefined, ::lib_0C46::func_411A, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pain_emp_stun_right_leg_r", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("pain_emp_stun_right_leg_r", ::lib_0C46::func_CF37, undefined, undefined, ::lib_0C46::func_411A, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pain_emp_recover_right_leg_r", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("pain_emp_recover_right_leg_r", ::lib_0C46::func_D542, undefined, undefined, ::lib_0C46::func_411A, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("dismember_leg_r_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("run_turn", ::lib_0C65::func_D514, undefined, undefined, undefined, undefined, ::lib_0C65::func_3EF5, undefined, ["aim"], undefined, ["shoot_c12_left", "shoot_c12_right"], undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("run", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("run", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("melee_grab", 0.5, ::scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::func_2374("run", ::lib_0F3D::func_D4DD, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, ["aim"], undefined, ["shoot_c12_left", "shoot_c12_right"], undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "normal", undefined);
  scripts\asm\asm::func_2375("exposed_arrival", undefined, ::lib_0C45::func_100BE, 1);
  scripts\asm\asm::func_2375("combat_idle", undefined, ::func_1246C, undefined);
  scripts\asm\asm::func_2375("melee_grab", 0.5, ::scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::func_2375("run_turn", undefined, ::lib_0C65::func_FFF8, ["run_turn", 1]);
  scripts\asm\asm::func_2375("exposed_arrival", undefined, ::lib_0C45::func_1008C, "Exposed");
  scripts\asm\asm::func_2374("walk", ::lib_0F3D::func_D4DD, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, ["aim"], undefined, ["shoot_c12_left", "shoot_c12_right"], undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "normal", undefined);
  scripts\asm\asm::func_2375("walk_arrival", undefined, ::lib_0C45::func_1008C, undefined);
  scripts\asm\asm::func_2375("walk_arrival", undefined, ::lib_0C45::func_100BE, undefined);
  scripts\asm\asm::func_2375("combat_idle", undefined, ::func_12617, undefined);
  scripts\asm\asm::func_2375("melee_grab", 0.5, ::scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::func_2374("exposed_arrival", ::lib_0C45::func_CEAD, undefined, undefined, ::lib_0C45::func_CEAB, undefined, ::lib_0C45::func_3E99, undefined, ["aim"], undefined, ["shoot_c12_left", "shoot_c12_right"], undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, "zonly_physics", undefined);
  scripts\asm\asm::func_2375("exposed_arrival_complete", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("exposed_exit", ::lib_0C65::func_CEB5, undefined, undefined, undefined, undefined, ::lib_0C45::func_3524, undefined, ["aim"], undefined, ["shoot_c12_left", "shoot_c12_right"], undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2375("run", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("run", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("walk_arrival", ::lib_0C45::func_CEAD, undefined, undefined, ::lib_0C45::func_CEAB, undefined, ::lib_0C45::func_3E99, undefined, ["aim"], undefined, ["shoot_c12_left", "shoot_c12_right"], undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2375("walk_backward_exit", undefined, ::lib_0C45::func_100BE, undefined);
  scripts\asm\asm::func_2375("combat_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("walk_exit", ::lib_0C65::func_CEB5, undefined, undefined, undefined, undefined, ::lib_0C65::func_3E9F, undefined, ["aim"], undefined, ["shoot_c12_left", "shoot_c12_right"], undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2375("walk", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("walk", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("move_requested", ::lib_0F3D::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("walk_backward_exit", undefined, ::lib_0C45::func_100BE, undefined);
  scripts\asm\asm::func_2375("walk_exit", undefined, ::lib_0C45::func_10048, undefined);
  scripts\asm\asm::func_2375("exposed_exit", undefined, ::lib_0C45::func_10047, undefined);
  scripts\asm\asm::func_2375("stand_turn", undefined, ::lib_0C45::func_BEA1, undefined);
  scripts\asm\asm::func_2375("walk", undefined, ::scripts\asm\shared_utility::func_BD25, "walk");
  scripts\asm\asm::func_2375("walk", undefined, ::scripts\asm\shared_utility::func_BD25, "casual");
  scripts\asm\asm::func_2375("run", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("walk_backward", ::lib_0C45::func_CEBB, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, ["aim"], undefined, ["shoot_c12_left", "shoot_c12_right"], undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "normal", undefined);
  scripts\asm\asm::func_2375("combat_idle", undefined, ::func_125DA, undefined);
  scripts\asm\asm::func_2375("walk_backward_arrival", undefined, ::lib_0C45::func_100A2, undefined);
  scripts\asm\asm::func_2375("walk_backward_arrival", undefined, ::lib_0C45::func_1008B, undefined);
  scripts\asm\asm::func_2374("walk_backward_exit", ::lib_0C45::func_CEB6, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, ["aim"], undefined, ["shoot_c12_left", "shoot_c12_right"], undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2375("walk_backward", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2375("walk_backward", 0, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("combat_idle", undefined, ::func_125D7, undefined);
  scripts\asm\asm::func_2374("walk_backward_arrival", ::lib_0C45::func_CEAC, undefined, undefined, ::lib_0C45::func_CEAB, undefined, ::lib_0C45::func_3E98, undefined, ["aim"], undefined, ["shoot_c12_left", "shoot_c12_right"], undefined, "pain_generic", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2375("combat_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("exposed_arrival_complete", ::lib_0F3D::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("walk_backward_exit", undefined, ::lib_0C45::func_100BE, 0);
  scripts\asm\asm::func_2375("combat_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("rodeo_left", ::lib_0F3D::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("rodeo_right", ::lib_0F3D::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("melee_throw", ::lib_0C44::func_35C3, undefined, ::lib_0C44::func_35C1, ::lib_0C44::func_35C4, undefined, ::lib_0C44::func_3584, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("combat_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("melee_grab", ::lib_0C44::func_35BF, undefined, ::lib_0C44::func_35C1, ::lib_0C44::func_35C0, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("melee_grab_complete", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("melee_grab_complete", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("melee_throw", undefined, ::lib_0C44::func_3616, undefined);
  scripts\asm\asm::func_2375("combat_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("death_generic", ::lib_0C46::func_35D7, undefined, undefined, undefined, undefined, ::lib_0C46::func_3527, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("death_dismember_legs", ::lib_0C46::func_35D7, undefined, undefined, undefined, undefined, ::lib_0C46::func_3527, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("dismember", ::lib_0F3D::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("dismember_destruct_leg_r", undefined, ::scripts\asm\asm_bb::bb_werepartsdismemberedinorder, ["right_leg", "left_leg"]);
  scripts\asm\asm::func_2375("dismember_destruct_leg_l", undefined, ::scripts\asm\asm_bb::bb_werepartsdismemberedinorder, ["left_leg", "right_leg"]);
  scripts\asm\asm::func_2375("dismember_leg_r", undefined, ::scripts\asm\asm_bb::func_298F, "right_leg");
  scripts\asm\asm::func_2375("dismember_leg_l", undefined, ::scripts\asm\asm_bb::func_298F, "left_leg");
  scripts\asm\asm::func_2375("dismember_leg_l_arm_enter_l", undefined, ::scripts\asm\asm_bb::bb_werepartsdismemberedinorder, ["left_leg", "left_arm"]);
  scripts\asm\asm::func_2375("dismember_leg_l_arm_enter_r", undefined, ::scripts\asm\asm_bb::bb_werepartsdismemberedinorder, ["left_leg", "right_arm"]);
  scripts\asm\asm::func_2375("dismember_leg_l_arm_enter_r", undefined, ::scripts\asm\asm_bb::bb_werepartsdismemberedinorder, ["left_leg", "head"]);
  scripts\asm\asm::func_2375("dismember_leg_r_arm_enter_l", undefined, ::scripts\asm\asm_bb::bb_werepartsdismemberedinorder, ["right_leg", "left_arm"]);
  scripts\asm\asm::func_2375("dismember_leg_r_arm_enter_r", undefined, ::scripts\asm\asm_bb::bb_werepartsdismemberedinorder, ["right_leg", "right_arm"]);
  scripts\asm\asm::func_2375("dismember_leg_r_arm_enter_r", undefined, ::scripts\asm\asm_bb::bb_werepartsdismemberedinorder, ["right_leg", "head"]);
  scripts\asm\asm::func_2375("dismember_arm_enter_l", undefined, ::scripts\asm\asm_bb::func_298F, "left_arm");
  scripts\asm\asm::func_2375("dismember_arm_enter_r", undefined, ::scripts\asm\asm_bb::func_298F, "right_arm");
  scripts\asm\asm::func_2375("dismember_head", undefined, ::scripts\asm\asm_bb::bb_ispartdismembered, "head");
  scripts\asm\asm::func_2374("dismember_arm_enter_l", ::lib_0C46::func_D542, undefined, undefined, ::lib_0C46::func_411A, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2375("dismember_arm_stun_l", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("dismember_arm_enter_r", ::lib_0C46::func_D542, undefined, undefined, ::lib_0C46::func_411A, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2375("dismember_arm_stun_r", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("dismember_leg_l", ::lib_0F3D::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2375("dismember_leg_l_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("dismember_leg_r", ::lib_0F3D::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2375("dismember_leg_r_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("dismember_head", ::lib_0F3D::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2375("combat_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("dismember_leg_l_idle", ::lib_0C45::func_35DE, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, ["aim"], undefined, ["shoot_c12_left", "shoot_c12_right"], undefined, undefined, undefined, "death_dismember_legs", "left", undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2374("dismember_leg_r_idle", ::lib_0C45::func_35DE, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, ["aim"], undefined, ["shoot_c12_left", "shoot_c12_right"], undefined, undefined, undefined, "death_dismember_legs", "right", undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2374("dismember_destruct_leg_r", ::lib_0F3D::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2374("dismember_destruct_leg_l", ::lib_0F3D::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2374("dismember_leg_l_arm_enter_l", ::lib_0F3D::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2375("dismember_leg_l_arm_stun_l", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("dismember_leg_l_arm_enter_r", ::lib_0F3D::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2375("dismember_leg_l_arm_stun_r", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("dismember_leg_r_arm_enter_l", ::lib_0F3D::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2375("dismember_leg_r_arm_stun_l", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("dismember_leg_r_arm_enter_r", ::lib_0F3D::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2375("dismember_leg_r_arm_stun_r", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("dismember_arm_stun_r", ::lib_0C46::func_CF1C, undefined, undefined, ::lib_0C46::func_411A, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2375("dismember_arm_recover_r", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("dismember_arm_recover_r", ::lib_0C46::func_D542, undefined, undefined, ::lib_0C46::func_411A, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2375("combat_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("dismember_arm_stun_l", ::lib_0C46::func_CF1C, undefined, undefined, ::lib_0C46::func_411A, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2375("dismember_arm_recover_l", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("dismember_arm_recover_l", ::lib_0C46::func_D542, undefined, undefined, ::lib_0C46::func_411A, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2375("combat_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("dismember_leg_r_arm_stun_r", ::lib_0C46::func_CF1C, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2375("dismember_leg_r_arm_recover_r", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("dismember_leg_r_arm_recover_r", ::lib_0F3D::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2375("dismember_leg_r_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("dismember_leg_r_arm_stun_l", ::lib_0C46::func_CF1C, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2375("dismember_leg_r_arm_recover_l", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("dismember_leg_r_arm_recover_l", ::lib_0F3D::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2375("dismember_leg_r_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("dismember_leg_l_arm_stun_r", ::lib_0C46::func_CF1C, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2375("dismember_leg_l_arm_recover_r", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("dismember_leg_l_arm_recover_r", ::lib_0F3D::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2375("dismember_leg_l_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("dismember_leg_l_arm_stun_l", ::lib_0C46::func_CF1C, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2375("dismember_leg_l_arm_recover_l", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("dismember_leg_l_arm_recover_l", ::lib_0F3D::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::func_2375("dismember_leg_l_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2327();
}

func_11BF4(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

func_1206F(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm::func_232B(var_1, "end") && self._blackboard.movetype == "combat";
}

func_1205A(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm::func_232B(var_1, "abort") && self._blackboard.movetype == "combat";
}

func_11B5C(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_isanimscripted() && isDefined(self.asm.var_4C86.var_697F);
}

func_11B63(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_isanimscripted() && isDefined(self.asm.var_4C86.var_92FA);
}

func_11B59(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_isanimscripted();
}

func_12376(var_0, var_1, var_2, var_3) {
  return 1;
}

func_12377(var_0, var_1, var_2, var_3) {
  return 1;
}

func_1246C(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

func_12617(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

func_125DA(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

func_125D7(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}