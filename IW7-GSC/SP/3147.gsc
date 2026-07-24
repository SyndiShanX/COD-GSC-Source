/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3147.gsc
**************************************/

_id_2371() {
  if(scripts\asm\asm::_id_232E("corner_cover_lean_shoot")) {
    return;
  }
  scripts\asm\asm::_id_230B("corner_cover_lean_shoot", "shoot_start");
  scripts\asm\asm::_id_2374("cover_left_shoot_single", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, _id_0F3D::_id_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("cover_left_lean_idle", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2374("cover_left_lean_fire", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("cover_left_lean_shoot_updateparams", undefined, _id_0C56::_id_FE89, undefined);
  scripts\asm\asm::_id_2374("cover_left_lean_idle", _id_0C56::_id_FE75, undefined, undefined, _id_0F3D::_id_CEC1, undefined, _id_0F3D::_id_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("cover_left_lean_fire", undefined, ::_id_11D85, undefined);
  scripts\asm\asm::_id_2374("cover_left_shoot_full", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, scripts\asm\shared\utility::_id_3E9A, "burst", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("cover_left_lean_idle", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2374("cover_left_shoot_semi", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, scripts\asm\shared\utility::_id_3E9A, "semi", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("cover_left_lean_idle", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2374("cover_right_lean_idle", _id_0C56::_id_FE75, undefined, undefined, _id_0F3D::_id_CEC1, undefined, _id_0F3D::_id_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("cover_right_lean_fire", undefined, ::_id_11ED3, undefined);
  scripts\asm\asm::_id_2374("cover_right_shoot_full", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, scripts\asm\shared\utility::_id_3E9A, "burst", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("cover_right_lean_idle", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2374("cover_right_shoot_semi", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, scripts\asm\shared\utility::_id_3E9A, "semi", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("cover_right_lean_idle", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2374("cover_right_lean_fire", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("cover_right_lean_shoot_updateparams", undefined, _id_0C56::_id_FE89, undefined);
  scripts\asm\asm::_id_2374("cover_right_shoot_single", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, _id_0F3D::_id_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("cover_right_lean_idle", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2374("shoot_start", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("cover_left_lean_shoot", undefined, ::_id_124B8, undefined);
  scripts\asm\asm::_id_2375("cover_right_lean_shoot", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("cover_left_lean_shoot", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("cover_left_crouch_lean_idle", undefined, ::_id_11D87, undefined);
  scripts\asm\asm::_id_2375("cover_left_lean_idle", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("cover_left_crouch_lean_fire", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("cover_left_crouch_shoot_updateparams", undefined, _id_0C56::_id_FE89, undefined);
  scripts\asm\asm::_id_2374("cover_left_crouch_lean_idle", _id_0C56::_id_FE75, undefined, undefined, _id_0F3D::_id_CEC1, undefined, _id_0F3D::_id_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("cover_left_crouch_lean_fire", undefined, ::_id_11CFC, undefined);
  scripts\asm\asm::_id_2374("cover_left_crouch_shoot_full", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, scripts\asm\shared\utility::_id_3E9A, "burst", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("cover_left_crouch_lean_idle", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2374("cover_left_crouch_shoot_semi", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, scripts\asm\shared\utility::_id_3E9A, "semi", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("cover_left_crouch_lean_idle", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2374("cover_left_crouch_shoot_single", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, _id_0F3D::_id_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("cover_left_crouch_lean_idle", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2374("cover_right_lean_shoot", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("cover_right_crouch_lean_idle", undefined, ::_id_11ED5, undefined);
  scripts\asm\asm::_id_2375("cover_right_lean_idle", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("cover_right_crouch_lean_idle", _id_0C56::_id_FE75, undefined, undefined, _id_0F3D::_id_CEC1, undefined, _id_0F3D::_id_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("cover_right_crouch_lean_fire", undefined, ::_id_11E2D, undefined);
  scripts\asm\asm::_id_2374("cover_right_crouch_shoot_full", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, scripts\asm\shared\utility::_id_3E9A, "burst", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("cover_right_crouch_lean_idle", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2374("cover_right_crouch_shoot_semi", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, scripts\asm\shared\utility::_id_3E9A, "semi", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("cover_right_crouch_lean_idle", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2374("cover_right_crouch_shoot_single", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, _id_0F3D::_id_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("cover_right_crouch_lean_idle", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2374("cover_right_crouch_lean_fire", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("cover_right_crouch_shoot_updateparams", undefined, _id_0C56::_id_FE89, undefined);
  scripts\asm\asm::_id_2374("cover_left_lean_shoot_updateparams", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("cover_left_shoot_single", undefined, ::_id_11D8B, undefined);
  scripts\asm\asm::_id_2375("cover_left_shoot_full", undefined, ::_id_11D89, undefined);
  scripts\asm\asm::_id_2375("cover_left_shoot_semi", undefined, ::_id_11D8A, undefined);
  scripts\asm\asm::_id_2374("cover_right_lean_shoot_updateparams", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("cover_right_shoot_single", undefined, ::_id_11ED9, undefined);
  scripts\asm\asm::_id_2375("cover_right_shoot_full", undefined, ::_id_11ED7, undefined);
  scripts\asm\asm::_id_2375("cover_right_shoot_semi", undefined, ::_id_11ED8, undefined);
  scripts\asm\asm::_id_2374("cover_right_crouch_shoot_updateparams", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("cover_right_crouch_shoot_single", undefined, ::_id_11E3E, undefined);
  scripts\asm\asm::_id_2375("cover_right_crouch_shoot_full", undefined, ::_id_11E3C, undefined);
  scripts\asm\asm::_id_2375("cover_right_crouch_shoot_semi", undefined, ::_id_11E3D, undefined);
  scripts\asm\asm::_id_2374("cover_left_crouch_shoot_updateparams", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("cover_left_crouch_shoot_single", undefined, ::_id_11D0C, undefined);
  scripts\asm\asm::_id_2375("cover_left_crouch_shoot_full", undefined, ::_id_11D0A, undefined);
  scripts\asm\asm::_id_2375("cover_left_crouch_shoot_semi", undefined, ::_id_11D0B, undefined);
  scripts\asm\asm::_id_2327();
}

_id_11D85(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::_id_291C();
}

_id_11ED3(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::_id_291C();
}

_id_124B8(var_0, var_1, var_2, var_3) {
  return isDefined(self.node) && self.node.type == "Cover Left";
}

_id_11D87(var_0, var_1, var_2, var_3) {
  return self.a.pose == "crouch";
}

_id_11CFC(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::_id_291C();
}

_id_11ED5(var_0, var_1, var_2, var_3) {
  return self.a.pose == "crouch";
}

_id_11E2D(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::_id_291C();
}

_id_11D8B(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams._id_FF0B == 1;
}

_id_11D89(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams._id_1119D == "full" || self._blackboard.shootparams._id_1119D == "burst";
}

_id_11D8A(var_0, var_1, var_2, var_3) {
  return 1;
}

_id_11ED9(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams._id_FF0B == 1;
}

_id_11ED7(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams._id_1119D == "fire" || self._blackboard.shootparams._id_1119D == "burst";
}

_id_11ED8(var_0, var_1, var_2, var_3) {
  return 1;
}

_id_11E3E(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams._id_FF0B == 1;
}

_id_11E3C(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams._id_1119D == "full" || self._blackboard.shootparams._id_1119D == "burst";
}

_id_11E3D(var_0, var_1, var_2, var_3) {
  return 1;
}

_id_11D0C(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams._id_FF0B == 1;
}

_id_11D0A(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams._id_1119D == "full" || self._blackboard.shootparams._id_1119D == "burst";
}

_id_11D0B(var_0, var_1, var_2, var_3) {
  return 1;
}