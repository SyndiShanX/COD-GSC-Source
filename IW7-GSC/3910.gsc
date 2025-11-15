/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3910.gsc
************************/

func_2371() {
  if(scripts\asm\asm::func_232E("zombie_ghost")) {
    return;
  }

  scripts\asm\asm::func_230B("zombie_ghost", "zombiestart");
  scripts\asm\asm::func_2374("zombiestart", ::scripts\asm\zombie\zombie::func_13F9A, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("choose_state", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("choose_state", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("entangled", undefined, ::func_11BF0, undefined);
  scripts\asm\asm::func_2375("melee", undefined, ::func_11BF2, undefined);
  scripts\asm\asm::func_2375("fly", undefined, ::func_11BF1, undefined);
  scripts\asm\asm::func_2375("idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("idle", ::scripts\asm\zombie_ghost\zombie_ghost_asm::func_13F6C, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("entangled", undefined, ::func_12242, undefined);
  scripts\asm\asm::func_2375("melee", undefined, ::func_12251, undefined);
  scripts\asm\asm::func_2375("fly", undefined, ::func_12247, undefined);
  scripts\asm\asm::func_2374("fly", ::scripts\asm\zombie_ghost\zombie_ghost_asm::func_13F6A, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("entangled", undefined, ::func_12173, undefined);
  scripts\asm\asm::func_2375("melee", undefined, ::func_12179, undefined);
  scripts\asm\asm::func_2375("fly_turn", undefined, ::func_12175, undefined);
  scripts\asm\asm::func_2375("idle", undefined, ::func_12177, undefined);
  scripts\asm\asm::func_2374("melee", ::scripts\asm\zombie_ghost\zombie_ghost_asm::func_13F6D, undefined, ::scripts\asm\zombie_ghost\zombie_ghost_asm::func_13F63, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("entangled", undefined, ::func_122A0, undefined);
  scripts\asm\asm::func_2375("fly", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("fly_turn", ::scripts\asm\zombie_ghost\zombie_ghost_asm::func_13F6B, undefined, undefined, undefined, undefined, ::scripts\asm\zombie_ghost\zombie_ghost_asm::func_13F61, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("entangled", undefined, ::func_1217B, undefined);
  scripts\asm\asm::func_2375("fly", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("entangled", ::lib_0F3C::func_B050, undefined, undefined, ::scripts\asm\zombie_ghost\zombie_ghost_asm::func_13F6E, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("launched", undefined, ::func_120C5, undefined);
  scripts\asm\asm::func_2375("choose_state", undefined, ::func_120C3, undefined);
  scripts\asm\asm::func_2374("launched", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2327();
}

func_11BF0(param_00, param_01, param_02, param_03) {
  return scripts\asm\zombie_ghost\zombie_ghost_asm::func_13F67();
}

func_11BF2(param_00, param_01, param_02, param_03) {
  return scripts\asm\zombie_ghost\zombie_ghost_asm::func_13F66();
}

func_11BF1(param_00, param_01, param_02, param_03) {
  return scripts\asm\zombie_ghost\zombie_ghost_asm::func_13F64();
}

func_12242(param_00, param_01, param_02, param_03) {
  return scripts\asm\zombie_ghost\zombie_ghost_asm::func_13F67();
}

func_12251(param_00, param_01, param_02, param_03) {
  return scripts\asm\zombie_ghost\zombie_ghost_asm::func_13F66();
}

func_12247(param_00, param_01, param_02, param_03) {
  return scripts\asm\zombie_ghost\zombie_ghost_asm::func_13F64();
}

func_12173(param_00, param_01, param_02, param_03) {
  return scripts\asm\zombie_ghost\zombie_ghost_asm::func_13F67();
}

func_12179(param_00, param_01, param_02, param_03) {
  return scripts\asm\zombie_ghost\zombie_ghost_asm::func_13F66();
}

func_12175(param_00, param_01, param_02, param_03) {
  return scripts\asm\zombie_ghost\zombie_ghost_asm::func_13F65();
}

func_12177(param_00, param_01, param_02, param_03) {
  return !scripts\asm\zombie_ghost\zombie_ghost_asm::func_13F64();
}

func_122A0(param_00, param_01, param_02, param_03) {
  return scripts\asm\zombie_ghost\zombie_ghost_asm::func_13F67();
}

func_1217B(param_00, param_01, param_02, param_03) {
  return scripts\asm\zombie_ghost\zombie_ghost_asm::func_13F67();
}

func_120C5(param_00, param_01, param_02, param_03) {
  return scripts\asm\zombie_ghost\zombie_ghost_asm::func_13F68();
}

func_120C3(param_00, param_01, param_02, param_03) {
  return !scripts\asm\zombie_ghost\zombie_ghost_asm::func_13F67();
}