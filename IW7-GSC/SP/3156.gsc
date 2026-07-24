/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3156.gsc
**************************************/

_id_2371() {
  if(scripts\asm\asm::_id_232E("seeker")) {
    return;
  }
  scripts\asm\asm::_id_230B("seeker", "seeker_init");
  scripts\asm\asm::_id_2374("idle", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy or motion", undefined, undefined);
  scripts\asm\asm::_id_2375("choose_unittype", undefined, scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::_id_2375("exit", undefined, ::_id_12245, undefined);
  scripts\asm\asm::_id_2374("run_loop", _id_0C53::_id_B063, undefined, undefined, _id_0C53::_id_B064, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy or motion", "normal", undefined);
  scripts\asm\asm::_id_2375("choose_unittype", undefined, scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::_id_2375("idle", undefined, ::_id_12440, undefined);
  scripts\asm\asm::_id_2374("seeker_init", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("off_nav_mesh", undefined, _id_0C53::_id_F171, undefined);
  scripts\asm\asm::_id_2375("idle", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("Knobs", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("traverse_external", _id_0C53::_id_D561, undefined, undefined, undefined, "run_loop", _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("death_generic", _id_0C53::_id_F16E, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("exit", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face goal", undefined, undefined);
  scripts\asm\asm::_id_2375("choose_unittype", undefined, scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::_id_2375("run_loop", undefined, _id_0C53::isfactorinuse, undefined);
  scripts\asm\asm::_id_2374("slide_across_car", _id_0C53::_id_D55F, undefined, undefined, undefined, "run_loop", _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("double_jump", _id_0C53::_id_D561, undefined, undefined, undefined, "run_loop", _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("run_loop", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("double_jump_mantle", _id_0C53::_id_CF20, undefined, undefined, undefined, "run_loop", _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("run_loop", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("double_jump_vault", _id_0C53::_id_CF27, undefined, undefined, undefined, "run_loop", _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("run_loop", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("antigrav_rise", _id_0F41::_id_CEE2, 1, undefined, undefined, undefined, _id_0F41::_id_3EB1, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_antigrav_grenade", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("antigrav_float_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2375("antigrav_fall", undefined, _id_0F41::_id_2012, undefined);
  scripts\asm\asm::_id_2374("antigrav_float_idle", _id_0F41::_id_CEE0, undefined, undefined, undefined, undefined, _id_0F41::_id_3EB0, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_antigrav_grenade", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("antigrav_fall", undefined, _id_0F41::_id_2012, undefined);
  scripts\asm\asm::_id_2374("antigrav_fall", _id_0F41::_id_CEDC, undefined, undefined, undefined, undefined, _id_0F41::_id_3EAD, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_antigrav_grenade", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("antigrav_fall_complete", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("antigrav_fall_restart", _id_0F41::_id_CEDD, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_antigrav_grenade", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("antigrav_float_idle", 1, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("antigrav_getup_restart", _id_0F41::_id_CEE1, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_antigrav_grenade", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("antigrav_rise", 1, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("antigrav_fall_complete", _id_0F41::_id_CEDB, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("idle", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("melee_seeker_attack_soldier", _id_0C52::_id_D4CE, undefined, _id_0C64::_id_B590, _id_0C52::_id_D4CF, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "melee_attack", undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("melee_seeker_soldier", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("melee_seeker_attack_soldier", undefined, _id_0C52::_id_F127, 1);
  scripts\asm\asm::_id_2374("melee_seeker_attack_c6", _id_0C52::_id_D4CE, undefined, _id_0C64::_id_B590, _id_0C52::_id_D4CF, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "melee_attack", undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("melee_seeker_attack_civilian", _id_0C52::_id_D4CE, undefined, _id_0C64::_id_B590, _id_0C52::_id_D4CF, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "melee_attack", undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("choose_unittype", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("melee_seeker_soldier", undefined, _id_0C53::_id_9FBC, "soldier");
  scripts\asm\asm::_id_2375("melee_seeker_c6", undefined, _id_0C53::_id_9FBC, "c6");
  scripts\asm\asm::_id_2375("melee_seeker_player", undefined, _id_0C53::_id_9FBC, "player");
  scripts\asm\asm::_id_2375("melee_seeker_civilian", undefined, _id_0C53::_id_9FBC, "civilian");
  scripts\asm\asm::_id_2374("melee_seeker_c6", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("melee_seeker_attack_c6", undefined, _id_0C52::_id_F127, 1);
  scripts\asm\asm::_id_2374("melee_seeker_civilian", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("melee_seeker_attack_civilian", undefined, _id_0C52::_id_F127, 1);
  scripts\asm\asm::_id_2374("melee_seeker_player", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("melee_seeker_attack_player", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("melee_seeker_attack_player", _id_0C52::_id_F148, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "melee_attack", undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("melee_grab_save_or_kill", undefined, _id_0F3D::_id_B642, undefined);
  scripts\asm\asm::_id_2375("melee_grab_save_or_kill", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("melee_grab_save_or_kill", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("melee_seeker_player_win", undefined, _id_0F3D::_id_B5FC, undefined);
  scripts\asm\asm::_id_2375("melee_seeker_player_lose", undefined, ::_id_12272, undefined);
  scripts\asm\asm::_id_2374("melee_seeker_player_win", _id_0C52::_id_F149, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "melee_attack", undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("melee_seeker_player_lose", _id_0C52::_id_F147, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "melee_attack", undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("death_antigrav_grenade", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("death_antigrav_grenade_default", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("death_antigrav_grenade_default", _id_0C53::_id_F16C, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, "death", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("off_nav_mesh", _id_0C53::_id_CF23, undefined, undefined, undefined, "run_loop", _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2327();
}

_id_12245(var_0, var_1, var_2, var_3) {
  return isDefined(self.pathgoalpos);
}

_id_12440(var_0, var_1, var_2, var_3) {
  return !isDefined(self.pathgoalpos);
}

_id_12272(var_0, var_1, var_2, var_3) {
  return !_id_0F3D::_id_B5FC();
}