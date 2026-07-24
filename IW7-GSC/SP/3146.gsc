/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3146.gsc
**************************************/

_id_2371() {
  if(scripts\asm\asm::_id_232E("civilian")) {
    return;
  }
  scripts\asm\asm::_id_230B("civilian", "start");
  scripts\asm\asm::_id_2374("start", _id_0C49::_id_3FCE, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, ::_id_125C4, undefined);
  scripts\asm\asm::_id_2375("stand_idle", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("stand_idle", _id_0C49::_id_3FD4, undefined, undefined, undefined, undefined, _id_0C49::_id_3EC5, undefined, undefined, undefined, undefined, "scared", undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::_id_2375("move_passthrough_init", undefined, scripts\asm\asm::_id_BCE7, undefined);
  scripts\asm\asm::_id_2375("trans_in_combat_react", undefined, _id_0C49::_id_A00A, undefined);
  scripts\asm\asm::_id_2375("trans_direct_to_non_combat", undefined, _id_0C49::_id_FFDF, undefined);
  scripts\asm\asm::_id_2375("trans_out_combat", undefined, _id_0C49::_id_3FE1, "noncombat");
  scripts\asm\asm::_id_2374("Knobs", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("stand_run_loop", _id_0C49::_id_3FD5, undefined, undefined, _id_0C49::_id_3FD1, undefined, scripts\asm\shared\utility::choosedemeanoranimwithoverride, "move", undefined, undefined, undefined, "pain", undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "normal", undefined);
  scripts\asm\asm::_id_2375("run_turn", undefined, _id_0C65::_id_FFF8, ["run_turn", 1]);
  scripts\asm\asm::_id_2375("pass_run_should_arrive", undefined, _id_0C5D::_id_FFD4, undefined);
  scripts\asm\asm::_id_2375("trans_in_stand_idle", undefined, scripts\asm\asm::_id_C17F, undefined);
  scripts\asm\asm::_id_2374("AnimScripted", _id_0F3D::_id_1FCB, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_idle", undefined, ::_id_11B75, undefined);
  scripts\asm\asm::_id_2374("exposed_arrival", _id_0C5D::_id_CEAA, undefined, undefined, undefined, undefined, _id_0C5D::_id_3E97, undefined, undefined, undefined, undefined, "pain", undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "abort");
  scripts\asm\asm::_id_2375("trans_in_stand_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("death", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("death_generic", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("death_generic", _id_0C60::_id_CF0E, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, "death", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("run_turn", _id_0C49::_id_3FD6, undefined, undefined, _id_0C49::_id_3FD1, undefined, _id_0C65::_id_3EF5, undefined, undefined, undefined, undefined, "pain", undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "finish");
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2375("pass_run_should_arrive", undefined, _id_0C5D::_id_FFD5, undefined);
  scripts\asm\asm::_id_2374("exposed_exit", _id_0C49::_id_3FD3, 1, undefined, _id_0C49::_id_3FD1, undefined, _id_0C65::_id_3E9F, undefined, undefined, undefined, undefined, "pain", undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "finish");
  scripts\asm\asm::_id_2374("pass_run_should_arrive", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("exposed_arrival", undefined, _id_0C5D::_id_10090, ["Exposed", 1]);
  scripts\asm\asm::_id_2375("exposed_arrival", undefined, _id_0C5D::_id_10090, ["Exposed Crouch", 1]);
  scripts\asm\asm::_id_2375("exposed_arrival", undefined, _id_0C5D::_id_10090, ["Cover Stand", 1]);
  scripts\asm\asm::_id_2375("exposed_arrival", undefined, _id_0C5D::_id_10090, ["Cover Crouch", 1]);
  scripts\asm\asm::_id_2374("trans_in_stand_idle", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0C49::_id_3EC5, undefined, undefined, undefined, undefined, "pain", undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::_id_2375("stand_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2375("trans_in_combat_react", undefined, _id_0C49::_id_A00A, undefined);
  scripts\asm\asm::_id_2374("trans_out_stand_idle", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0C49::_id_3EC5, undefined, undefined, undefined, undefined, "pain", undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_idle", undefined, scripts\asm\asm::_id_C17F, undefined);
  scripts\asm\asm::_id_2375("exposed_exit", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("facial_animation", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("move_passthrough", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, ::_id_122AA, undefined);
  scripts\asm\asm::_id_2375("trans_out_stand_idle", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("melee_seeker_attack_civilian_victim", _id_0C52::_id_D4D0, undefined, _id_0C64::_id_B590, _id_0F42::_id_D4D3, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "melee_attack", undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("combat_reaction", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0C49::_id_3EC4, undefined, undefined, undefined, undefined, "pain", undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::_id_2375("trans_out_combat_react", undefined, ::_id_11BF6, undefined);
  scripts\asm\asm::_id_2375("trans_out_combat_react", undefined, _id_0C49::_id_3FE1, "noncombat");
  scripts\asm\asm::_id_2375("move_passthrough_init", undefined, scripts\asm\asm::_id_BCE7, undefined);
  scripts\asm\asm::_id_2374("trans_in_combat_react", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0C49::_id_3EC4, undefined, undefined, undefined, undefined, "pain", undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::_id_2375("combat_reaction", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("trans_out_combat_react", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0C49::_id_3EC4, undefined, undefined, undefined, undefined, "scared", undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2375("trans_in_combat_react", undefined, _id_0C49::_id_A00A, undefined);
  scripts\asm\asm::_id_2374("trans_in_non_combat", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0C49::_id_3EC5, undefined, undefined, undefined, undefined, "scared", undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::_id_2375("non_combat_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2375("trans_in_combat_react", undefined, _id_0C49::_id_A00A, undefined);
  scripts\asm\asm::_id_2374("trans_out_non_combat", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0C49::_id_3EC5, undefined, undefined, undefined, undefined, "pain", undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("trans_in_combat_react", 0.1, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("non_combat_idle", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0C49::_id_3EC5, undefined, undefined, undefined, undefined, "scared", undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "zonly_physics", undefined);
  scripts\asm\asm::_id_2375("trans_in_combat_react", 0.1, _id_0C49::_id_FFE3, undefined);
  scripts\asm\asm::_id_2375("move_passthrough_init", undefined, scripts\asm\asm::_id_BCE7, undefined);
  scripts\asm\asm::_id_2375("trans_out_non_combat", 0.1, _id_0C49::_id_A00A, undefined);
  scripts\asm\asm::_id_2375("trans_out_non_combat", 0.1, _id_0C49::_id_3FE1, "combat");
  scripts\asm\asm::_id_2374("trans_out_combat", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0C49::_id_3EC5, undefined, undefined, undefined, undefined, "scared", undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("trans_in_non_combat", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2375("trans_in_combat_react", undefined, _id_0C49::_id_A00A, undefined);
  scripts\asm\asm::_id_2374("trans_direct_to_non_combat", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0C49::_id_3EC5, undefined, undefined, undefined, undefined, "scared", undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("non_combat_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2375("trans_in_combat_react", undefined, _id_0C49::_id_A00A, undefined);
  scripts\asm\asm::_id_2374("move_passthrough_init", _id_0F3D::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3D::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("move_passthrough", undefined, _id_0C49::_id_FFD2, undefined);
  scripts\asm\asm::_id_2327();
}

_id_125C4(var_0, var_1, var_2, var_3) {
  return isDefined(self.pathgoalpos);
}

_id_11B75(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_isanimScripted();
}

_id_122AA(var_0, var_1, var_2, var_3) {
  return isDefined(self._id_55ED) && self._id_55ED;
}

_id_11BF6(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_iswhizbyrequested();
}