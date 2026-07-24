/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3160.gsc
**************************************/

_id_2371() {
  if(scripts\asm\asm::_id_232E("shoot_c8")) {
    return;
  }
  scripts\asm\asm::_id_230B("shoot_c8", "shoot_start");
  scripts\asm\asm::_id_2374("shoot_start", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("shoot_idle", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("shoot_idle", scripts\asm\shared\utility::_id_2B58, undefined, undefined, _id_0F3D::_id_CEC1, undefined, _id_0F3D::_id_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("shoot_fire_passthrough", undefined, ::_id_124B1, undefined);
  scripts\asm\asm::_id_2374("shoot_fire", _id_0C3D::_id_34D3, undefined, undefined, _id_0F3D::_id_CEC0, undefined, _id_0F3D::_id_3E96, "shoot", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("shoot_idle", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2374("shoot_beam", _id_0C3D::_id_34D0, undefined, undefined, _id_0C3D::_id_34D1, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("shoot_idle", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2374("shoot_fire_passthrough", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("shoot_beam", undefined, _id_0C3D::_id_3478, undefined);
  scripts\asm\asm::_id_2375("shoot_fire", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2327();
}

_id_124B1(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::_id_291C();
}