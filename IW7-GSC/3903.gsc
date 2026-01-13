/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3903.gsc
*********************************************/

func_2371() {
  if(scripts\asm\asm::func_232E("shoot_grey")) {
    return;
  }

  scripts\asm\asm::func_230B("shoot_grey", "shoot_start");
  scripts\asm\asm::func_2374("shoot_idle", ::lib_0F3E::func_FE75, undefined, undefined, ::lib_0F3C::func_CEC1, undefined, ::lib_0F3C::func_3E96, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("shoot_fire", undefined, ::func_124B0, undefined);
  scripts\asm\asm::func_2374("shoot_single", ::scripts\asm\zombie_grey\zombie_grey_asm::func_FE6A, undefined, undefined, ::lib_0F3C::func_CEC0, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("shoot_idle", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2374("shoot_full", ::scripts\asm\zombie_grey\zombie_grey_asm::func_FE6A, undefined, undefined, ::lib_0F3C::func_CEC0, undefined, ::scripts\asm\shared_utility::func_3E9A, "burst", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("shoot_idle", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2374("shoot_semi", ::scripts\asm\zombie_grey\zombie_grey_asm::func_FE6A, undefined, undefined, ::lib_0F3C::func_CEC0, undefined, ::scripts\asm\shared_utility::func_3E9A, "semi", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("shoot_idle", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2374("shoot_start", ::lib_0F3E::func_98CC, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("crouch_shoot_idle", undefined, ::func_124BA, undefined);
  scripts\asm\asm::func_2375("shoot_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("shoot_fire", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("shoot_single", undefined, ::func_124A9, undefined);
  scripts\asm\asm::func_2375("shoot_full", undefined, ::func_124A1, undefined);
  scripts\asm\asm::func_2375("shoot_semi", undefined, ::func_124A5, undefined);
  scripts\asm\asm::func_2374("crouch_shoot_idle", ::lib_0F3E::func_FE75, undefined, undefined, ::lib_0F3C::func_CEC1, undefined, ::scripts\asm\shared_utility::chooseanimshoot, "shoot_idle", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("crouch_shoot_fire", undefined, ::func_12047, undefined);
  scripts\asm\asm::func_2375("shoot_start", undefined, ::func_1204C, undefined);
  scripts\asm\asm::func_2374("crouch_shoot_full", ::lib_0F3E::func_FE61, undefined, undefined, ::lib_0F3C::func_CEC0, undefined, ::scripts\asm\shared_utility::func_3E9A, "burst", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("crouch_shoot_idle", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2374("crouch_shoot_semi", ::lib_0F3E::func_FE61, undefined, undefined, ::lib_0F3C::func_CEC0, undefined, ::scripts\asm\shared_utility::func_3E9A, "semi", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("crouch_shoot_idle", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2374("crouch_shoot_fire", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("crouch_shoot_single", undefined, ::func_1203F, undefined);
  scripts\asm\asm::func_2375("crouch_shoot_full", undefined, ::func_12037, undefined);
  scripts\asm\asm::func_2375("crouch_shoot_semi", undefined, ::func_1203B, undefined);
  scripts\asm\asm::func_2374("crouch_shoot_single", ::lib_0F3E::func_FE61, undefined, undefined, ::lib_0F3C::func_CEC0, undefined, ::lib_0F3C::func_3E96, "single", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "shoot", undefined, undefined, undefined);
  scripts\asm\asm::func_2375("crouch_shoot_idle", undefined, ::scripts\asm\asm::func_68B0, "shoot_finished");
  scripts\asm\asm::func_2327();
}

func_124B0(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::func_291C();
}

func_124BA(var_0, var_1, var_2, var_3) {
  return self.a.pose == "crouch";
}

func_124A9(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams.var_FF0B == 1;
}

func_124A1(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams.var_1119D == "full";
}

func_124A5(var_0, var_1, var_2, var_3) {
  return 1;
}

func_12047(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::func_291C();
}

func_1204C(var_0, var_1, var_2, var_3) {
  return self.a.pose != "crouch";
}

func_1203F(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams.var_FF0B == 1;
}

func_12037(var_0, var_1, var_2, var_3) {
  return self._blackboard.shootparams.var_1119D == "full";
}

func_1203B(var_0, var_1, var_2, var_3) {
  return 1;
}