/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3163.gsc
************************/

func_2371() {
  if(scripts\asm\asm::func_232E("shoot_cover_A")) {
    return;
  }

  scripts\asm\asm::func_230B("shoot_cover_A", "shoot_start_A");
  scripts\asm\asm::func_2374("shoot_idle_right_A", ::lib_0C56::func_FE75, undefined, undefined, ::lib_0F3D::func_CEC1, undefined, ::lib_0F3D::func_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("shoot_fire_right_A", undefined, ::func_124AF, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim_A", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("shoot_single_right_A", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::lib_0F3D::func_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("shoot_idle_right_A", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2375("shoot_idle_right_A", undefined, ::lib_0C56::func_FECE, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim_A", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("shoot_full_right_A", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::scripts\asm\shared_utility::func_3E9A, "burst", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("shoot_idle_right_A", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2375("shoot_idle_right_A", undefined, ::lib_0C56::func_FECE, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim_A", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("shoot_semi_right_A", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::scripts\asm\shared_utility::func_3E9A, "semi", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("shoot_idle_right_A", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2375("shoot_idle_right_A", undefined, ::lib_0C56::func_FECE, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim_A", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("shoot_start_A", ::lib_0C56::func_98CC, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("shoot_cover_right_A", undefined, ::func_124B7, undefined);
  scripts\asm\asm::func_2375("shoot_cover_left_right_A", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("shoot_fire_right_A", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("shoot_right_A_updateparams", undefined, ::lib_0C56::func_FE89, undefined);
  scripts\asm\asm::func_2374("crouch_shoot_idle_right_A", ::lib_0C56::func_FE75, undefined, undefined, ::lib_0F3D::func_CEC1, undefined, ::scripts\asm\shared_utility::chooseanimshoot, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("crouch_shoot_fire_right_A", undefined, ::func_12045, undefined);
  scripts\asm\asm::func_2375("shoot_start_A", undefined, ::func_12046, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim_A", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("crouch_shoot_full_right_A", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::scripts\asm\shared_utility::func_3E9A, "burst", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("crouch_shoot_idle_right_A", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2375("crouch_shoot_idle_right_A", undefined, ::lib_0C56::func_FECE, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim_A", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("crouch_shoot_semi_right_A", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::scripts\asm\shared_utility::func_3E9A, "semi", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("crouch_shoot_idle_right_A", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2375("crouch_shoot_idle_right_A", undefined, ::lib_0C56::func_FECE, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim_A", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("crouch_shoot_fire_right_A", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("crouch_shoot_right_A_updateparams", undefined, ::lib_0C56::func_FE89, undefined);
  scripts\asm\asm::func_2374("crouch_shoot_single_right_A", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::lib_0F3D::func_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("crouch_shoot_idle_right_A", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2375("crouch_shoot_idle_right_A", undefined, ::lib_0C56::func_FECE, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim_A", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("WaitForNotetrackAim_A", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("shoot_start_A", undefined, ::lib_0F3D::func_FE6B, undefined);
  scripts\asm\asm::func_2374("shoot_idle_left_A", ::lib_0C56::func_FE75, undefined, undefined, ::lib_0F3D::func_CEC1, undefined, ::lib_0F3D::func_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("shoot_fire_left_A", undefined, ::func_124AE, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim_A", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("shoot_single_left_A", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::lib_0F3D::func_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("shoot_idle_left_A", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2375("shoot_idle_left_A", undefined, ::lib_0C56::func_FECE, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim_A", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("shoot_full_left_A", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::scripts\asm\shared_utility::func_3E9A, "burst", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("shoot_idle_left_A", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2375("shoot_idle_left_A", undefined, ::lib_0C56::func_FECE, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim_A", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("shoot_semi_left_A", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::scripts\asm\shared_utility::func_3E9A, "semi", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("shoot_idle_left_A", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2375("shoot_idle_left_A", undefined, ::lib_0C56::func_FECE, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim_A", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("shoot_fire_left_A", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("shoot_left_A_updateparams", undefined, ::lib_0C56::func_FE89, undefined);
  scripts\asm\asm::func_2374("crouch_shoot_idle_left_A", ::lib_0C56::func_FE75, undefined, undefined, ::lib_0F3D::func_CEC1, undefined, ::scripts\asm\shared_utility::chooseanimshoot, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("crouch_shoot_fire_left_A", undefined, ::func_12044, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim_A", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("crouch_shoot_full_left_A", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::scripts\asm\shared_utility::func_3E9A, "burst", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("crouch_shoot_idle_left_A", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2375("crouch_shoot_idle_left_A", undefined, ::lib_0C56::func_FECE, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim_A", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("crouch_shoot_semi_left_A", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::scripts\asm\shared_utility::func_3E9A, "semi", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("crouch_shoot_idle_left_A", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2375("crouch_shoot_idle_left_A", undefined, ::lib_0C56::func_FECE, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim_A", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("crouch_shoot_fire_left_A", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("crouch_shoot_left_A_updateparams", undefined, ::lib_0C56::func_FE89, undefined);
  scripts\asm\asm::func_2374("crouch_shoot_single_left_A", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::lib_0F3D::func_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("crouch_shoot_idle_left_A", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2375("crouch_shoot_idle_left_A", undefined, ::lib_0C56::func_FECE, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim_A", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("shoot_cover_right_A", ::lib_0F3D::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("crouch_shoot_idle_right_A", undefined, ::func_124A0, undefined);
  scripts\asm\asm::func_2375("shoot_idle_right_A", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("shoot_cover_left_right_A", ::lib_0F3D::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("crouch_shoot_idle_left_A", undefined, ::func_1249F, undefined);
  scripts\asm\asm::func_2375("shoot_idle_left_A", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("crouch_shoot_right_A_updateparams", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("crouch_shoot_single_right_A", undefined, ::func_12052, undefined);
  scripts\asm\asm::func_2375("crouch_shoot_full_right_A", undefined, ::lib_0C56::func_FED9, undefined);
  scripts\asm\asm::func_2375("crouch_shoot_semi_right_A", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("crouch_shoot_left_A_updateparams", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("crouch_shoot_single_left_A", undefined, ::func_12051, undefined);
  scripts\asm\asm::func_2375("crouch_shoot_full_left_A", undefined, ::lib_0C56::func_FED9, undefined);
  scripts\asm\asm::func_2375("crouch_shoot_semi_left_A", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("shoot_left_A_updateparams", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("shoot_single_left_A", undefined, ::func_124B5, undefined);
  scripts\asm\asm::func_2375("shoot_full_left_A", undefined, ::lib_0C56::func_FED9, undefined);
  scripts\asm\asm::func_2375("shoot_semi_left_A", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("shoot_right_A_updateparams", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("shoot_single_right_A", undefined, ::func_124B6, undefined);
  scripts\asm\asm::func_2375("shoot_full_right_A", undefined, ::lib_0C56::func_FED9, undefined);
  scripts\asm\asm::func_2375("shoot_semi_right_A", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2327();
}

func_124AF(param_00, param_01, param_02, param_03) {
  return scripts\asm\asm_bb::func_291C();
}

func_124B7(param_00, param_01, param_02, param_03) {
  return isDefined(self.target_getindexoftarget) && self.target_getindexoftarget.type == "Cover Right";
}

func_12045(param_00, param_01, param_02, param_03) {
  return scripts\asm\asm_bb::func_291C();
}

func_12046(param_00, param_01, param_02, param_03) {
  return self.a.pose != "crouch";
}

func_124AE(param_00, param_01, param_02, param_03) {
  return scripts\asm\asm_bb::func_291C();
}

func_12044(param_00, param_01, param_02, param_03) {
  return scripts\asm\asm_bb::func_291C();
}

func_124A0(param_00, param_01, param_02, param_03) {
  return self.a.pose == "crouch";
}

func_1249F(param_00, param_01, param_02, param_03) {
  return self.a.pose == "crouch";
}

func_12052(param_00, param_01, param_02, param_03) {
  return self.var_1198.shootparams.var_FF0B == 1;
}

func_12051(param_00, param_01, param_02, param_03) {
  return self.var_1198.shootparams.var_FF0B == 1;
}

func_124B5(param_00, param_01, param_02, param_03) {
  return self.var_1198.shootparams.var_FF0B == 1;
}

func_124B6(param_00, param_01, param_02, param_03) {
  return self.var_1198.shootparams.var_FF0B == 1;
}