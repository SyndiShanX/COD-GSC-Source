/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3147.gsc
*********************************************/

func_2371() {
  if(scripts\asm\asm::func_232E("corner_cover_lean_shoot")) {
    return;
  }

  scripts\asm\asm::func_230B("corner_cover_lean_shoot", "shoot_start");
  scripts\asm\asm::func_2374("cover_left_shoot_single", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::lib_0F3D::func_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("cover_left_lean_idle", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2374("cover_left_lean_fire", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("cover_left_lean_shoot_updateparams", undefined, ::lib_0C56::func_FE89, undefined);
  scripts\asm\asm::func_2374("cover_left_lean_idle", ::lib_0C56::func_FE75, undefined, undefined, ::lib_0F3D::func_CEC1, undefined, ::lib_0F3D::func_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("cover_left_lean_fire", undefined, ::func_11D85, undefined);
  scripts\asm\asm::func_2374("cover_left_shoot_full", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::scripts\asm\shared_utility::func_3E9A, "burst", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("cover_left_lean_idle", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2374("cover_left_shoot_semi", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::scripts\asm\shared_utility::func_3E9A, "semi", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("cover_left_lean_idle", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2374("cover_right_lean_idle", ::lib_0C56::func_FE75, undefined, undefined, ::lib_0F3D::func_CEC1, undefined, ::lib_0F3D::func_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("cover_right_lean_fire", undefined, ::func_11ED3, undefined);
  scripts\asm\asm::func_2374("cover_right_shoot_full", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::scripts\asm\shared_utility::func_3E9A, "burst", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("cover_right_lean_idle", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2374("cover_right_shoot_semi", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::scripts\asm\shared_utility::func_3E9A, "semi", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("cover_right_lean_idle", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2374("cover_right_lean_fire", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("cover_right_lean_shoot_updateparams", undefined, ::lib_0C56::func_FE89, undefined);
  scripts\asm\asm::func_2374("cover_right_shoot_single", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::lib_0F3D::func_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("cover_right_lean_idle", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2374("shoot_start", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("cover_left_lean_shoot", undefined, ::func_124B8, undefined);
  scripts\asm\asm::func_2375("cover_right_lean_shoot", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("cover_left_lean_shoot", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("cover_left_crouch_lean_idle", undefined, ::func_11D87, undefined);
  scripts\asm\asm::func_2375("cover_left_lean_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("cover_left_crouch_lean_fire", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("cover_left_crouch_shoot_updateparams", undefined, ::lib_0C56::func_FE89, undefined);
  scripts\asm\asm::func_2374("cover_left_crouch_lean_idle", ::lib_0C56::func_FE75, undefined, undefined, ::lib_0F3D::func_CEC1, undefined, ::lib_0F3D::func_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("cover_left_crouch_lean_fire", undefined, ::func_11CFC, undefined);
  scripts\asm\asm::func_2374("cover_left_crouch_shoot_full", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::scripts\asm\shared_utility::func_3E9A, "burst", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("cover_left_crouch_lean_idle", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2374("cover_left_crouch_shoot_semi", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::scripts\asm\shared_utility::func_3E9A, "semi", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("cover_left_crouch_lean_idle", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2374("cover_left_crouch_shoot_single", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::lib_0F3D::func_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("cover_left_crouch_lean_idle", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2374("cover_right_lean_shoot", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("cover_right_crouch_lean_idle", undefined, ::func_11ED5, undefined);
  scripts\asm\asm::func_2375("cover_right_lean_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("cover_right_crouch_lean_idle", ::lib_0C56::func_FE75, undefined, undefined, ::lib_0F3D::func_CEC1, undefined, ::lib_0F3D::func_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("cover_right_crouch_lean_fire", undefined, ::func_11E2D, undefined);
  scripts\asm\asm::func_2374("cover_right_crouch_shoot_full", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::scripts\asm\shared_utility::func_3E9A, "burst", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("cover_right_crouch_lean_idle", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2374("cover_right_crouch_shoot_semi", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::scripts\asm\shared_utility::func_3E9A, "semi", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("cover_right_crouch_lean_idle", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2374("cover_right_crouch_shoot_single", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::lib_0F3D::func_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("cover_right_crouch_lean_idle", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2374("cover_right_crouch_lean_fire", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("cover_right_crouch_shoot_updateparams", undefined, ::lib_0C56::func_FE89, undefined);
  scripts\asm\asm::func_2374("cover_left_lean_shoot_updateparams", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("cover_left_shoot_single", undefined, ::func_11D8B, undefined);
  scripts\asm\asm::func_2375("cover_left_shoot_full", undefined, ::func_11D89, undefined);
  scripts\asm\asm::func_2375("cover_left_shoot_semi", undefined, ::func_11D8A, undefined);
  scripts\asm\asm::func_2374("cover_right_lean_shoot_updateparams", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("cover_right_shoot_single", undefined, ::func_11ED9, undefined);
  scripts\asm\asm::func_2375("cover_right_shoot_full", undefined, ::func_11ED7, undefined);
  scripts\asm\asm::func_2375("cover_right_shoot_semi", undefined, ::func_11ED8, undefined);
  scripts\asm\asm::func_2374("cover_right_crouch_shoot_updateparams", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("cover_right_crouch_shoot_single", undefined, ::func_11E3E, undefined);
  scripts\asm\asm::func_2375("cover_right_crouch_shoot_full", undefined, ::func_11E3C, undefined);
  scripts\asm\asm::func_2375("cover_right_crouch_shoot_semi", undefined, ::func_11E3D, undefined);
  scripts\asm\asm::func_2374("cover_left_crouch_shoot_updateparams", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("cover_left_crouch_shoot_single", undefined, ::func_11D0C, undefined);
  scripts\asm\asm::func_2375("cover_left_crouch_shoot_full", undefined, ::func_11D0A, undefined);
  scripts\asm\asm::func_2375("cover_left_crouch_shoot_semi", undefined, ::func_11D0B, undefined);
  scripts\asm\asm::func_2327();
}

func_11D85(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::func_291C();
}

func_11ED3(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::func_291C();
}

func_124B8(var_0, var_1, var_2, var_3) {
  return isDefined(self.target_getindexoftarget) && self.target_getindexoftarget.type == "Cover Left";
}

func_11D87(var_0, var_1, var_2, var_3) {
  return self.a.pose == "crouch";
}

func_11CFC(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::func_291C();
}

func_11ED5(var_0, var_1, var_2, var_3) {
  return self.a.pose == "crouch";
}

func_11E2D(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::func_291C();
}

func_11D8B(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams.var_FF0B == 1;
}

func_11D89(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams.var_1119D == "full" || self._blackboard.shootparams.var_1119D == "burst";
}

func_11D8A(var_0, var_1, var_2, var_3) {
  return 1;
}

func_11ED9(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams.var_FF0B == 1;
}

func_11ED7(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams.var_1119D == "fire" || self._blackboard.shootparams.var_1119D == "burst";
}

func_11ED8(var_0, var_1, var_2, var_3) {
  return 1;
}

func_11E3E(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams.var_FF0B == 1;
}

func_11E3C(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams.var_1119D == "full" || self._blackboard.shootparams.var_1119D == "burst";
}

func_11E3D(var_0, var_1, var_2, var_3) {
  return 1;
}

func_11D0C(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams.var_FF0B == 1;
}

func_11D0A(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams.var_1119D == "full" || self._blackboard.shootparams.var_1119D == "burst";
}

func_11D0B(var_0, var_1, var_2, var_3) {
  return 1;
}