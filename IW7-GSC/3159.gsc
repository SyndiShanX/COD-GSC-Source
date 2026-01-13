/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3159.gsc
************************/

func_2371() {
  if(scripts\asm\asm::func_232E("shoot")) {
    return;
  }

  scripts\asm\asm::func_230B("shoot", "shoot_start");
  scripts\asm\asm::func_2374("shoot_idle", ::lib_0C56::func_FE75, undefined, undefined, ::lib_0F3D::func_CEC1, undefined, ::lib_0F3D::func_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("shoot_fire", undefined, ::lib_0C56::func_FFC9, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2375("sniper_shoot_idle", undefined, ::lib_0C56::func_10081, undefined);
  scripts\asm\asm::func_2374("shoot_single", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::lib_0F3D::func_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("sniper_check", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2375("sniper_check", undefined, ::lib_0C56::func_FECE, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("shoot_full", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::scripts\asm\shared_utility::func_3E9A, "burst", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("sniper_check", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2375("sniper_check", undefined, ::lib_0C56::func_FECE, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("shoot_semi", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::scripts\asm\shared_utility::func_3E9A, "semi", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("sniper_check", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2375("sniper_check", undefined, ::lib_0C56::func_FECE, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("shoot_start", ::lib_0C56::func_98CC, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("pistol_shoot_idle", undefined, ::scripts\asm\asm_bb::bb_isweaponclass, "pistol");
  scripts\asm\asm::func_2375("rpg_shoot", undefined, ::scripts\asm\asm_bb::bb_isweaponclass, "rocketlauncher");
  scripts\asm\asm::func_2375("mg_shoot_idle", undefined, ::lib_0C56::func_10078, undefined);
  scripts\asm\asm::func_2375("crouch_shoot_idle_pass", undefined, ::scripts\asm\asm_bb::func_9DA4, "crouch");
  scripts\asm\asm::func_2375("prone_shoot_idle", undefined, ::scripts\asm\asm_bb::func_9DA4, "prone");
  scripts\asm\asm::func_2375("sniper_check", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pistol_shoot_idle", ::lib_0C56::func_FE75, undefined, undefined, ::lib_0F3D::func_CEC1, undefined, ::lib_0F3D::func_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pistol_shoot_fire", 0, ::lib_0C56::func_FFC9, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("pistol_shoot_single", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::lib_0F3D::func_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("pistol_shoot_idle", 0, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2375("pistol_shoot_idle", undefined, ::lib_0C56::func_FECE, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("rpg_shoot_idle", ::lib_0C56::func_FE75, undefined, undefined, ::lib_0F3D::func_CEC1, undefined, ::lib_0F3D::func_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("rpg_shoot_updateparams", undefined, ::lib_0C56::func_FFC9, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("rpg_shoot_single", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::lib_0F3D::func_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("rpg_shoot_idle", 0, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2375("rpg_shoot_idle", undefined, ::lib_0C56::func_FECE, undefined);
  scripts\asm\asm::func_2374("rpg_shoot_crouch_idle", ::lib_0C56::func_FE75, undefined, undefined, ::lib_0F3D::func_CEC1, undefined, ::lib_0F3D::func_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("rpg_shoot_crouch_updateparams", undefined, ::lib_0C56::func_FFC9, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("rpg_shoot_crouch_single", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::lib_0F3D::func_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("rpg_shoot_crouch_idle", 0, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2375("rpg_shoot_crouch_idle", undefined, ::lib_0C56::func_FECE, undefined);
  scripts\asm\asm::func_2374("shoot_fire", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("shoot_updateparams", undefined, ::lib_0C56::func_FE89, undefined);
  scripts\asm\asm::func_2374("rpg_shoot", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("rpg_shoot_crouch_idle", undefined, ::scripts\asm\asm_bb::func_9DA4, "crouch");
  scripts\asm\asm::func_2375("rpg_shoot_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("crouch_shoot_idle", ::lib_0C56::func_FE75, undefined, undefined, ::lib_0F3D::func_CEC1, undefined, ::scripts\asm\shared_utility::chooseanimshoot, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("crouch_shoot_fire", undefined, ::lib_0C56::func_FFC9, undefined);
  scripts\asm\asm::func_2375("shoot_start", undefined, ::func_1204C, undefined);
  scripts\asm\asm::func_2375("crouch_sniper_shoot_idle", undefined, ::lib_0C56::func_10081, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("crouch_shoot_full", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::scripts\asm\shared_utility::func_3E9A, "burst", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("crouch_shoot_idle_pass", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2375("crouch_shoot_idle_pass", undefined, ::lib_0C56::func_FECE, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("crouch_shoot_semi", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::scripts\asm\shared_utility::func_3E9A, "semi", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("crouch_shoot_idle_pass", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2375("crouch_shoot_idle_pass", undefined, ::lib_0C56::func_FECE, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("crouch_shoot_fire", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("crouch_shoot_updateparams", undefined, ::lib_0C56::func_FE89, undefined);
  scripts\asm\asm::func_2374("crouch_shoot_single", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::lib_0F3D::func_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("crouch_shoot_idle_pass", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2375("crouch_shoot_idle_pass", undefined, ::lib_0C56::func_FECE, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("prone_shoot_idle", ::lib_0C56::func_FE75, undefined, undefined, ::lib_0F3D::func_CEC1, undefined, ::lib_0F3D::func_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("prone_shoot_fire", undefined, ::lib_0C56::func_FFC9, undefined);
  scripts\asm\asm::func_2375("shoot_start", undefined, ::func_12413, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("prone_shoot_single", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::lib_0F3D::func_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("prone_shoot_idle", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2375("prone_shoot_idle", undefined, ::lib_0C56::func_FECE, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("prone_shoot_full", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::scripts\asm\shared_utility::func_3E9A, "burst", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("prone_shoot_idle", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2375("prone_shoot_idle", undefined, ::lib_0C56::func_FECE, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("prone_shoot_semi", ::lib_0C56::func_FE61, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::scripts\asm\shared_utility::func_3E9A, "semi", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("prone_shoot_idle", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2375("prone_shoot_idle", undefined, ::lib_0C56::func_FECE, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("prone_shoot_fire", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("prone_shoot_updateparams", undefined, ::lib_0C56::func_FE89, undefined);
  scripts\asm\asm::func_2374("WaitForNotetrackAim", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("shoot_start", undefined, ::lib_0F3D::func_FE6B, undefined);
  scripts\asm\asm::func_2374("mg_shoot_idle", ::lib_0C56::func_FE75, undefined, undefined, ::lib_0F3D::func_CEC1, undefined, ::lib_0F3D::func_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("shoot_start", undefined, ::lib_0C56::func_C185, undefined);
  scripts\asm\asm::func_2375("mg_shoot_fire", undefined, ::lib_0C56::func_FFC9, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("mg_shoot_suppress", ::lib_0C56::func_FE70, undefined, undefined, ::lib_0F3D::func_CEC0, undefined, ::lib_0F3D::func_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("mg_shoot_idle", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2375("mg_shoot_idle", undefined, ::lib_0C56::func_FECE, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2374("mg_shoot_fire", ::lib_0F3D::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("mg_shoot_suppress", undefined, ::lib_0C56::func_FEDA, undefined);
  scripts\asm\asm::func_2374("shoot_updateparams", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("shoot_single", 0, ::lib_0C56::func_FEDC, undefined);
  scripts\asm\asm::func_2375("shoot_full", 0, ::lib_0C56::func_FED9, undefined);
  scripts\asm\asm::func_2375("shoot_semi", 0, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("crouch_shoot_updateparams", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("crouch_shoot_single", 0, ::lib_0C56::func_FEDC, undefined);
  scripts\asm\asm::func_2375("crouch_shoot_full", 0, ::lib_0C56::func_FED9, undefined);
  scripts\asm\asm::func_2375("crouch_shoot_semi", 0, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("prone_shoot_updateparams", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("prone_shoot_single", 0, ::lib_0C56::func_FEDC, undefined);
  scripts\asm\asm::func_2375("prone_shoot_full", 0, ::lib_0C56::func_FED9, undefined);
  scripts\asm\asm::func_2375("prone_shoot_semi", 0, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("pistol_shoot_updateparams", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("pistol_shoot_single", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("sniper_check", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("WaitForNotetrackAim", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2375("sniper_shoot_idle", undefined, ::lib_0C56::func_10081, undefined);
  scripts\asm\asm::func_2375("shoot_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("sniper_shoot_idle", ::lib_0C56::func_FE76, undefined, undefined, ::lib_0F3D::func_CEC1, undefined, ::lib_0F3D::func_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2375("shoot_fire", undefined, ::lib_0C56::func_10080, undefined);
  scripts\asm\asm::func_2375("shoot_idle", undefined, ::lib_0C56::func_10002, undefined);
  scripts\asm\asm::func_2374("pistol_shoot_fire", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("pistol_shoot_updateparams", undefined, ::lib_0C56::func_FE89, undefined);
  scripts\asm\asm::func_2374("rpg_shoot_updateparams", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("rpg_shoot_single", undefined, ::lib_0C56::func_FE89, undefined);
  scripts\asm\asm::func_2374("rpg_shoot_crouch_updateparams", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("rpg_shoot_crouch_single", undefined, ::lib_0C56::func_FE89, undefined);
  scripts\asm\asm::func_2374("crouch_shoot_idle_pass", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("WaitForNotetrackAim", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2375("crouch_sniper_shoot_idle", undefined, ::lib_0C56::func_10081, undefined);
  scripts\asm\asm::func_2375("crouch_shoot_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("crouch_sniper_shoot_idle", ::lib_0C56::func_FE76, undefined, undefined, ::lib_0F3D::func_CEC1, undefined, ::lib_0F3D::func_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("crouch_shoot_idle", undefined, ::lib_0C56::func_10002, undefined);
  scripts\asm\asm::func_2375("crouch_shoot_fire", undefined, ::lib_0C56::func_10080, undefined);
  scripts\asm\asm::func_2375("shoot_start", undefined, ::func_12053, undefined);
  scripts\asm\asm::func_2375("WaitForNotetrackAim", undefined, ::lib_0F3D::func_FE7E, undefined);
  scripts\asm\asm::func_2327();
}

func_1204C(var_0, var_1, var_2, var_3) {
  return self.a.pose != "crouch";
}

func_12413(var_0, var_1, var_2, var_3) {
  return self.a.pose != "prone";
}

func_12053(var_0, var_1, var_2, var_3) {
  return self.a.pose != "crouch";
}