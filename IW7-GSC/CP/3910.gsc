/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3910.gsc
**************************************/

_id_2371() {
  if(scripts\asm\asm::_id_232E("zombie_ghost")) {
    return;
  }
  scripts\asm\asm::_id_230B("zombie_ghost", "zombiestart");
  scripts\asm\asm::_id_2374("zombiestart", scripts\asm\zombie\zombie::_id_13F9A, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("choose_state", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("choose_state", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("entangled", undefined, ::_id_11BF0, undefined);
  scripts\asm\asm::_id_2375("melee", undefined, ::_id_11BF2, undefined);
  scripts\asm\asm::_id_2375("fly", undefined, ::_id_11BF1, undefined);
  scripts\asm\asm::_id_2375("idle", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("idle", scripts\asm\zombie_ghost\zombie_ghost_asm::_id_13F6C, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("entangled", undefined, ::_id_12242, undefined);
  scripts\asm\asm::_id_2375("melee", undefined, ::_id_12251, undefined);
  scripts\asm\asm::_id_2375("fly", undefined, ::_id_12247, undefined);
  scripts\asm\asm::_id_2374("fly", scripts\asm\zombie_ghost\zombie_ghost_asm::_id_13F6A, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("entangled", undefined, ::_id_12173, undefined);
  scripts\asm\asm::_id_2375("melee", undefined, ::_id_12179, undefined);
  scripts\asm\asm::_id_2375("fly_turn", undefined, ::_id_12175, undefined);
  scripts\asm\asm::_id_2375("idle", undefined, ::_id_12177, undefined);
  scripts\asm\asm::_id_2374("melee", scripts\asm\zombie_ghost\zombie_ghost_asm::_id_13F6D, undefined, scripts\asm\zombie_ghost\zombie_ghost_asm::_id_13F63, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("entangled", undefined, ::_id_122A0, undefined);
  scripts\asm\asm::_id_2375("fly", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("fly_turn", scripts\asm\zombie_ghost\zombie_ghost_asm::_id_13F6B, undefined, undefined, undefined, undefined, scripts\asm\zombie_ghost\zombie_ghost_asm::_id_13F61, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("entangled", undefined, ::_id_1217B, undefined);
  scripts\asm\asm::_id_2375("fly", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("entangled", _id_0F3C::_id_B050, undefined, undefined, scripts\asm\zombie_ghost\zombie_ghost_asm::_id_13F6E, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("launched", undefined, ::_id_120C5, undefined);
  scripts\asm\asm::_id_2375("choose_state", undefined, ::_id_120C3, undefined);
  scripts\asm\asm::_id_2374("launched", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2327();
}

_id_11BF0(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie_ghost\zombie_ghost_asm::_id_13F67();
}

_id_11BF2(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie_ghost\zombie_ghost_asm::_id_13F66();
}

_id_11BF1(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie_ghost\zombie_ghost_asm::_id_13F64();
}

_id_12242(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie_ghost\zombie_ghost_asm::_id_13F67();
}

_id_12251(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie_ghost\zombie_ghost_asm::_id_13F66();
}

_id_12247(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie_ghost\zombie_ghost_asm::_id_13F64();
}

_id_12173(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie_ghost\zombie_ghost_asm::_id_13F67();
}

_id_12179(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie_ghost\zombie_ghost_asm::_id_13F66();
}

_id_12175(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie_ghost\zombie_ghost_asm::_id_13F65();
}

_id_12177(var_0, var_1, var_2, var_3) {
  return !scripts\asm\zombie_ghost\zombie_ghost_asm::_id_13F64();
}

_id_122A0(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie_ghost\zombie_ghost_asm::_id_13F67();
}

_id_1217B(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie_ghost\zombie_ghost_asm::_id_13F67();
}

_id_120C5(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie_ghost\zombie_ghost_asm::_id_13F68();
}

_id_120C3(var_0, var_1, var_2, var_3) {
  return !scripts\asm\zombie_ghost\zombie_ghost_asm::_id_13F67();
}