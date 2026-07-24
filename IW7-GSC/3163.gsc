/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3163.gsc
**************************************/

_id_2371() {
  if(scripts\asm\asm::_id_232E("shoot_cover_A")) {
    return;
  }
  scripts\asm\asm::_id_230B("shoot_cover_A", "shoot_start_A");
  scripts\asm\asm::_id_2374("shoot_idle_right_A", _id_0C56::_id_FE75, undefined, undefined, _id_0F3D::_id_CEC1, undefined, _id_0F3D::_id_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("shoot_fire_right_A", undefined, ::_id_124AF, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim_A", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("shoot_single_right_A", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, _id_0F3D::_id_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("shoot_idle_right_A", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2375("shoot_idle_right_A", undefined, _id_0C56::_id_FECE, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim_A", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("shoot_full_right_A", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, scripts\asm\shared\utility::_id_3E9A, "burst", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("shoot_idle_right_A", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2375("shoot_idle_right_A", undefined, _id_0C56::_id_FECE, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim_A", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("shoot_semi_right_A", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, scripts\asm\shared\utility::_id_3E9A, "semi", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("shoot_idle_right_A", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2375("shoot_idle_right_A", undefined, _id_0C56::_id_FECE, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim_A", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("shoot_start_A", _id_0C56::_id_98CC, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("shoot_cover_right_A", undefined, ::_id_124B7, undefined);
  scripts\asm\asm::_id_2375("shoot_cover_left_right_A", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("shoot_fire_right_A", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("shoot_right_A_updateparams", undefined, _id_0C56::_id_FE89, undefined);
  scripts\asm\asm::_id_2374("crouch_shoot_idle_right_A", _id_0C56::_id_FE75, undefined, undefined, _id_0F3D::_id_CEC1, undefined, scripts\asm\shared\utility::chooseanimshoot, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("crouch_shoot_fire_right_A", undefined, ::_id_12045, undefined);
  scripts\asm\asm::_id_2375("shoot_start_A", undefined, ::_id_12046, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim_A", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("crouch_shoot_full_right_A", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, scripts\asm\shared\utility::_id_3E9A, "burst", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("crouch_shoot_idle_right_A", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2375("crouch_shoot_idle_right_A", undefined, _id_0C56::_id_FECE, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim_A", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("crouch_shoot_semi_right_A", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, scripts\asm\shared\utility::_id_3E9A, "semi", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("crouch_shoot_idle_right_A", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2375("crouch_shoot_idle_right_A", undefined, _id_0C56::_id_FECE, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim_A", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("crouch_shoot_fire_right_A", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("crouch_shoot_right_A_updateparams", undefined, _id_0C56::_id_FE89, undefined);
  scripts\asm\asm::_id_2374("crouch_shoot_single_right_A", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, _id_0F3D::_id_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("crouch_shoot_idle_right_A", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2375("crouch_shoot_idle_right_A", undefined, _id_0C56::_id_FECE, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim_A", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("WaitForNotetrackAim_A", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("shoot_start_A", undefined, _id_0F3D::_id_FE6B, undefined);
  scripts\asm\asm::_id_2374("shoot_idle_left_A", _id_0C56::_id_FE75, undefined, undefined, _id_0F3D::_id_CEC1, undefined, _id_0F3D::_id_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("shoot_fire_left_A", undefined, ::_id_124AE, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim_A", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("shoot_single_left_A", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, _id_0F3D::_id_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("shoot_idle_left_A", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2375("shoot_idle_left_A", undefined, _id_0C56::_id_FECE, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim_A", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("shoot_full_left_A", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, scripts\asm\shared\utility::_id_3E9A, "burst", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("shoot_idle_left_A", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2375("shoot_idle_left_A", undefined, _id_0C56::_id_FECE, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim_A", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("shoot_semi_left_A", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, scripts\asm\shared\utility::_id_3E9A, "semi", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("shoot_idle_left_A", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2375("shoot_idle_left_A", undefined, _id_0C56::_id_FECE, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim_A", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("shoot_fire_left_A", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("shoot_left_A_updateparams", undefined, _id_0C56::_id_FE89, undefined);
  scripts\asm\asm::_id_2374("crouch_shoot_idle_left_A", _id_0C56::_id_FE75, undefined, undefined, _id_0F3D::_id_CEC1, undefined, scripts\asm\shared\utility::chooseanimshoot, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("crouch_shoot_fire_left_A", undefined, ::_id_12044, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim_A", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("crouch_shoot_full_left_A", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, scripts\asm\shared\utility::_id_3E9A, "burst", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("crouch_shoot_idle_left_A", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2375("crouch_shoot_idle_left_A", undefined, _id_0C56::_id_FECE, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim_A", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("crouch_shoot_semi_left_A", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, scripts\asm\shared\utility::_id_3E9A, "semi", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("crouch_shoot_idle_left_A", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2375("crouch_shoot_idle_left_A", undefined, _id_0C56::_id_FECE, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim_A", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("crouch_shoot_fire_left_A", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("crouch_shoot_left_A_updateparams", undefined, _id_0C56::_id_FE89, undefined);
  scripts\asm\asm::_id_2374("crouch_shoot_single_left_A", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, _id_0F3D::_id_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("crouch_shoot_idle_left_A", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2375("crouch_shoot_idle_left_A", undefined, _id_0C56::_id_FECE, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim_A", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("shoot_cover_right_A", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("crouch_shoot_idle_right_A", undefined, ::_id_124A0, undefined);
  scripts\asm\asm::_id_2375("shoot_idle_right_A", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("shoot_cover_left_right_A", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("crouch_shoot_idle_left_A", undefined, ::_id_1249F, undefined);
  scripts\asm\asm::_id_2375("shoot_idle_left_A", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("crouch_shoot_right_A_updateparams", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("crouch_shoot_single_right_A", undefined, ::_id_12052, undefined);
  scripts\asm\asm::_id_2375("crouch_shoot_full_right_A", undefined, _id_0C56::_id_FED9, undefined);
  scripts\asm\asm::_id_2375("crouch_shoot_semi_right_A", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("crouch_shoot_left_A_updateparams", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("crouch_shoot_single_left_A", undefined, ::_id_12051, undefined);
  scripts\asm\asm::_id_2375("crouch_shoot_full_left_A", undefined, _id_0C56::_id_FED9, undefined);
  scripts\asm\asm::_id_2375("crouch_shoot_semi_left_A", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("shoot_left_A_updateparams", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("shoot_single_left_A", undefined, ::_id_124B5, undefined);
  scripts\asm\asm::_id_2375("shoot_full_left_A", undefined, _id_0C56::_id_FED9, undefined);
  scripts\asm\asm::_id_2375("shoot_semi_left_A", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("shoot_right_A_updateparams", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("shoot_single_right_A", undefined, ::_id_124B6, undefined);
  scripts\asm\asm::_id_2375("shoot_full_right_A", undefined, _id_0C56::_id_FED9, undefined);
  scripts\asm\asm::_id_2375("shoot_semi_right_A", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2327();
}

_id_124AF(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::_id_291C();
}

_id_124B7(var_0, var_1, var_2, var_3) {
  return isDefined(self.node) && self.node.type == "Cover Right";
}

_id_12045(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::_id_291C();
}

_id_12046(var_0, var_1, var_2, var_3) {
  return self.a.pose != "crouch";
}

_id_124AE(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::_id_291C();
}

_id_12044(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::_id_291C();
}

_id_124A0(var_0, var_1, var_2, var_3) {
  return self.a.pose == "crouch";
}

_id_1249F(var_0, var_1, var_2, var_3) {
  return self.a.pose == "crouch";
}

_id_12052(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams._id_FF0B == 1;
}

_id_12051(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams._id_FF0B == 1;
}

_id_124B5(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams._id_FF0B == 1;
}

_id_124B6(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams._id_FF0B == 1;
}