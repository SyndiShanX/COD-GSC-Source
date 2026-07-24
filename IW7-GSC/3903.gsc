/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3903.gsc
**************************************/

_id_2371() {
  if(scripts\asm\asm::_id_232E("shoot_grey")) {
    return;
  }
  scripts\asm\asm::_id_230B("shoot_grey", "shoot_start");
  scripts\asm\asm::_id_2374("shoot_idle", _id_0F3E::_id_FE75, undefined, undefined, _id_0F3C::_id_CEC1, undefined, _id_0F3C::_id_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("shoot_fire", undefined, ::_id_124B0, undefined);
  scripts\asm\asm::_id_2374("shoot_single", scripts\asm\zombie_grey\zombie_grey_asm::_id_FE6A, undefined, undefined, _id_0F3C::_id_CEC0, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("shoot_idle", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2374("shoot_full", scripts\asm\zombie_grey\zombie_grey_asm::_id_FE6A, undefined, undefined, _id_0F3C::_id_CEC0, undefined, scripts\asm\shared\utility::_id_3E9A, "burst", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("shoot_idle", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2374("shoot_semi", scripts\asm\zombie_grey\zombie_grey_asm::_id_FE6A, undefined, undefined, _id_0F3C::_id_CEC0, undefined, scripts\asm\shared\utility::_id_3E9A, "semi", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("shoot_idle", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2374("shoot_start", _id_0F3E::_id_98CC, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("crouch_shoot_idle", undefined, ::_id_124BA, undefined);
  scripts\asm\asm::_id_2375("shoot_idle", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("shoot_fire", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("shoot_single", undefined, ::_id_124A9, undefined);
  scripts\asm\asm::_id_2375("shoot_full", undefined, ::_id_124A1, undefined);
  scripts\asm\asm::_id_2375("shoot_semi", undefined, ::_id_124A5, undefined);
  scripts\asm\asm::_id_2374("crouch_shoot_idle", _id_0F3E::_id_FE75, undefined, undefined, _id_0F3C::_id_CEC1, undefined, scripts\asm\shared\utility::chooseanimshoot, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("crouch_shoot_fire", undefined, ::_id_12047, undefined);
  scripts\asm\asm::_id_2375("shoot_start", undefined, ::_id_1204C, undefined);
  scripts\asm\asm::_id_2374("crouch_shoot_full", _id_0F3E::_id_FE61, undefined, undefined, _id_0F3C::_id_CEC0, undefined, scripts\asm\shared\utility::_id_3E9A, "burst", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("crouch_shoot_idle", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2374("crouch_shoot_semi", _id_0F3E::_id_FE61, undefined, undefined, _id_0F3C::_id_CEC0, undefined, scripts\asm\shared\utility::_id_3E9A, "semi", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("crouch_shoot_idle", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2374("crouch_shoot_fire", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("crouch_shoot_single", undefined, ::_id_1203F, undefined);
  scripts\asm\asm::_id_2375("crouch_shoot_full", undefined, ::_id_12037, undefined);
  scripts\asm\asm::_id_2375("crouch_shoot_semi", undefined, ::_id_1203B, undefined);
  scripts\asm\asm::_id_2374("crouch_shoot_single", _id_0F3E::_id_FE61, undefined, undefined, _id_0F3C::_id_CEC0, undefined, _id_0F3C::_id_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("crouch_shoot_idle", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2327();
}

_id_124B0(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::_id_291C();
}

_id_124BA(var_0, var_1, var_2, var_3) {
  return self.a.pose == "crouch";
}

_id_124A9(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams._id_FF0B == 1;
}

_id_124A1(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams._id_1119D == "full";
}

_id_124A5(var_0, var_1, var_2, var_3) {
  return 1;
}

_id_12047(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::_id_291C();
}

_id_1204C(var_0, var_1, var_2, var_3) {
  return self.a.pose != "crouch";
}

_id_1203F(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams._id_FF0B == 1;
}

_id_12037(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams._id_1119D == "full";
}

_id_1203B(var_0, var_1, var_2, var_3) {
  return 1;
}