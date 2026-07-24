/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3159.gsc
**************************************/

_id_2371() {
  if(scripts\asm\asm::_id_232E("shoot")) {
    return;
  }
  scripts\asm\asm::_id_230B("shoot", "shoot_start");
  scripts\asm\asm::_id_2374("shoot_idle", _id_0C56::_id_FE75, undefined, undefined, _id_0F3D::_id_CEC1, undefined, _id_0F3D::_id_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("shoot_fire", undefined, _id_0C56::_id_FFC9, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2375("sniper_shoot_idle", undefined, _id_0C56::_id_10081, undefined);
  scripts\asm\asm::_id_2374("shoot_single", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, _id_0F3D::_id_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("sniper_check", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2375("sniper_check", undefined, _id_0C56::_id_FECE, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("shoot_full", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, scripts\asm\shared\utility::_id_3E9A, "burst", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("sniper_check", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2375("sniper_check", undefined, _id_0C56::_id_FECE, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("shoot_semi", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, scripts\asm\shared\utility::_id_3E9A, "semi", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("sniper_check", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2375("sniper_check", undefined, _id_0C56::_id_FECE, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("shoot_start", _id_0C56::_id_98CC, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("pistol_shoot_idle", undefined, scripts\asm\asm_bb::bb_isweaponclass, "pistol");
  scripts\asm\asm::_id_2375("rpg_shoot", undefined, scripts\asm\asm_bb::bb_isweaponclass, "rocketlauncher");
  scripts\asm\asm::_id_2375("mg_shoot_idle", undefined, _id_0C56::_id_10078, undefined);
  scripts\asm\asm::_id_2375("crouch_shoot_idle_pass", undefined, scripts\asm\asm_bb::_id_9DA4, "crouch");
  scripts\asm\asm::_id_2375("prone_shoot_idle", undefined, scripts\asm\asm_bb::_id_9DA4, "prone");
  scripts\asm\asm::_id_2375("sniper_check", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("pistol_shoot_idle", _id_0C56::_id_FE75, undefined, undefined, _id_0F3D::_id_CEC1, undefined, _id_0F3D::_id_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("pistol_shoot_fire", 0, _id_0C56::_id_FFC9, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("pistol_shoot_single", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, _id_0F3D::_id_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("pistol_shoot_idle", 0, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2375("pistol_shoot_idle", undefined, _id_0C56::_id_FECE, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("rpg_shoot_idle", _id_0C56::_id_FE75, undefined, undefined, _id_0F3D::_id_CEC1, undefined, _id_0F3D::_id_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("rpg_shoot_updateparams", undefined, _id_0C56::_id_FFC9, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("rpg_shoot_single", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, _id_0F3D::_id_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("rpg_shoot_idle", 0, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2375("rpg_shoot_idle", undefined, _id_0C56::_id_FECE, undefined);
  scripts\asm\asm::_id_2374("rpg_shoot_crouch_idle", _id_0C56::_id_FE75, undefined, undefined, _id_0F3D::_id_CEC1, undefined, _id_0F3D::_id_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("rpg_shoot_crouch_updateparams", undefined, _id_0C56::_id_FFC9, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("rpg_shoot_crouch_single", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, _id_0F3D::_id_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("rpg_shoot_crouch_idle", 0, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2375("rpg_shoot_crouch_idle", undefined, _id_0C56::_id_FECE, undefined);
  scripts\asm\asm::_id_2374("shoot_fire", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("shoot_updateparams", undefined, _id_0C56::_id_FE89, undefined);
  scripts\asm\asm::_id_2374("rpg_shoot", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("rpg_shoot_crouch_idle", undefined, scripts\asm\asm_bb::_id_9DA4, "crouch");
  scripts\asm\asm::_id_2375("rpg_shoot_idle", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("crouch_shoot_idle", _id_0C56::_id_FE75, undefined, undefined, _id_0F3D::_id_CEC1, undefined, scripts\asm\shared\utility::chooseanimshoot, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("crouch_shoot_fire", undefined, _id_0C56::_id_FFC9, undefined);
  scripts\asm\asm::_id_2375("shoot_start", undefined, ::_id_1204C, undefined);
  scripts\asm\asm::_id_2375("crouch_sniper_shoot_idle", undefined, _id_0C56::_id_10081, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("crouch_shoot_full", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, scripts\asm\shared\utility::_id_3E9A, "burst", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("crouch_shoot_idle_pass", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2375("crouch_shoot_idle_pass", undefined, _id_0C56::_id_FECE, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("crouch_shoot_semi", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, scripts\asm\shared\utility::_id_3E9A, "semi", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("crouch_shoot_idle_pass", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2375("crouch_shoot_idle_pass", undefined, _id_0C56::_id_FECE, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("crouch_shoot_fire", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("crouch_shoot_updateparams", undefined, _id_0C56::_id_FE89, undefined);
  scripts\asm\asm::_id_2374("crouch_shoot_single", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, _id_0F3D::_id_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("crouch_shoot_idle_pass", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2375("crouch_shoot_idle_pass", undefined, _id_0C56::_id_FECE, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("prone_shoot_idle", _id_0C56::_id_FE75, undefined, undefined, _id_0F3D::_id_CEC1, undefined, _id_0F3D::_id_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("prone_shoot_fire", undefined, _id_0C56::_id_FFC9, undefined);
  scripts\asm\asm::_id_2375("shoot_start", undefined, ::_id_12413, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("prone_shoot_single", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, _id_0F3D::_id_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("prone_shoot_idle", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2375("prone_shoot_idle", undefined, _id_0C56::_id_FECE, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("prone_shoot_full", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, scripts\asm\shared\utility::_id_3E9A, "burst", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("prone_shoot_idle", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2375("prone_shoot_idle", undefined, _id_0C56::_id_FECE, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("prone_shoot_semi", _id_0C56::_id_FE61, undefined, undefined, _id_0F3D::_id_CEC0, undefined, scripts\asm\shared\utility::_id_3E9A, "semi", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("prone_shoot_idle", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2375("prone_shoot_idle", undefined, _id_0C56::_id_FECE, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("prone_shoot_fire", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("prone_shoot_updateparams", undefined, _id_0C56::_id_FE89, undefined);
  scripts\asm\asm::_id_2374("WaitForNotetrackAim", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("shoot_start", undefined, _id_0F3D::_id_FE6B, undefined);
  scripts\asm\asm::_id_2374("mg_shoot_idle", _id_0C56::_id_FE75, undefined, undefined, _id_0F3D::_id_CEC1, undefined, _id_0F3D::_id_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("shoot_start", undefined, _id_0C56::_id_C185, undefined);
  scripts\asm\asm::_id_2375("mg_shoot_fire", undefined, _id_0C56::_id_FFC9, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("mg_shoot_suppress", _id_0C56::_id_FE70, undefined, undefined, _id_0F3D::_id_CEC0, undefined, _id_0F3D::_id_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("mg_shoot_idle", undefined, scripts\asm\asm::_id_68B0, "shoot_finished");
  scripts\asm\asm::_id_2375("mg_shoot_idle", undefined, _id_0C56::_id_FECE, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2374("mg_shoot_fire", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("mg_shoot_suppress", undefined, _id_0C56::_id_FEDA, undefined);
  scripts\asm\asm::_id_2374("shoot_updateparams", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("shoot_single", 0, _id_0C56::_id_FEDC, undefined);
  scripts\asm\asm::_id_2375("shoot_full", 0, _id_0C56::_id_FED9, undefined);
  scripts\asm\asm::_id_2375("shoot_semi", 0, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("crouch_shoot_updateparams", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("crouch_shoot_single", 0, _id_0C56::_id_FEDC, undefined);
  scripts\asm\asm::_id_2375("crouch_shoot_full", 0, _id_0C56::_id_FED9, undefined);
  scripts\asm\asm::_id_2375("crouch_shoot_semi", 0, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("prone_shoot_updateparams", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("prone_shoot_single", 0, _id_0C56::_id_FEDC, undefined);
  scripts\asm\asm::_id_2375("prone_shoot_full", 0, _id_0C56::_id_FED9, undefined);
  scripts\asm\asm::_id_2375("prone_shoot_semi", 0, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("pistol_shoot_updateparams", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("pistol_shoot_single", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("sniper_check", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2375("sniper_shoot_idle", undefined, _id_0C56::_id_10081, undefined);
  scripts\asm\asm::_id_2375("shoot_idle", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("sniper_shoot_idle", _id_0C56::_id_FE76, undefined, undefined, _id_0F3D::_id_CEC1, undefined, _id_0F3D::_id_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2375("shoot_fire", undefined, _id_0C56::_id_10080, undefined);
  scripts\asm\asm::_id_2375("shoot_idle", undefined, _id_0C56::_id_10002, undefined);
  scripts\asm\asm::_id_2374("pistol_shoot_fire", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("pistol_shoot_updateparams", undefined, _id_0C56::_id_FE89, undefined);
  scripts\asm\asm::_id_2374("rpg_shoot_updateparams", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("rpg_shoot_single", undefined, _id_0C56::_id_FE89, undefined);
  scripts\asm\asm::_id_2374("rpg_shoot_crouch_updateparams", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("rpg_shoot_crouch_single", undefined, _id_0C56::_id_FE89, undefined);
  scripts\asm\asm::_id_2374("crouch_shoot_idle_pass", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2375("crouch_sniper_shoot_idle", undefined, _id_0C56::_id_10081, undefined);
  scripts\asm\asm::_id_2375("crouch_shoot_idle", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("crouch_sniper_shoot_idle", _id_0C56::_id_FE76, undefined, undefined, _id_0F3D::_id_CEC1, undefined, _id_0F3D::_id_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("crouch_shoot_idle", undefined, _id_0C56::_id_10002, undefined);
  scripts\asm\asm::_id_2375("crouch_shoot_fire", undefined, _id_0C56::_id_10080, undefined);
  scripts\asm\asm::_id_2375("shoot_start", undefined, ::_id_12053, undefined);
  scripts\asm\asm::_id_2375("WaitForNotetrackAim", undefined, _id_0F3D::_id_FE7E, undefined);
  scripts\asm\asm::_id_2327();
}

_id_1204C(var_0, var_1, var_2, var_3) {
  return self.a.pose != "crouch";
}

_id_12413(var_0, var_1, var_2, var_3) {
  return self.a.pose != "prone";
}

_id_12053(var_0, var_1, var_2, var_3) {
  return self.a.pose != "crouch";
}