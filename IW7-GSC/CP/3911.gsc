/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3911.gsc
**************************************/

_id_2371() {
  if(scripts\asm\asm::_id_232E("zombie_grey")) {
    return;
  }
  _id_0F3F::_id_2371();
  scripts\asm\asm::_id_230B("zombie_grey", "c6_start");
  scripts\asm\asm::_id_2374("enter_combat", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, ["shoot_grey"], undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("noncombat_stand_idle", _id_0F3C::_id_B050, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, "noncombat_stand_idle", undefined, undefined, undefined, undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("regen_start", undefined, scripts\asm\zombie_grey\zombie_grey_asm::_id_13F91, undefined);
  scripts\asm\asm::_id_2375("being_cloned", undefined, scripts\asm\zombie_grey\zombie_grey_asm::_id_13F8C, undefined);
  scripts\asm\asm::_id_2375("teleport_to_loner", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleporttoloner, undefined);
  scripts\asm\asm::_id_2375("duplicating_attack", undefined, scripts\asm\zombie_grey\zombie_grey_asm::_id_13F8E, undefined);
  scripts\asm\asm::_id_2375("teleport_attack", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportattack, undefined);
  scripts\asm\asm::_id_2375("teleport_summon", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportsummon, undefined);
  scripts\asm\asm::_id_2375("teleport_dash", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportdash, undefined);
  scripts\asm\asm::_id_2375("exposed_exit", undefined, ::_id_122DF, undefined);
  scripts\asm\asm::_id_2375("move_walk_loop", undefined, scripts\asm\asm::_id_BCE7, "walk");
  scripts\asm\asm::_id_2375("exposed_idle", undefined, ::_id_122E4, undefined);
  scripts\asm\asm::_id_2375("enter_combat", undefined, ::_id_122DA, undefined);
  scripts\asm\asm::_id_2374("c6_start", _id_0C38::_id_33FF, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("intro_spawn", undefined, ::_id_11B91, undefined);
  scripts\asm\asm::_id_2375("intro_vignette", undefined, ::_id_11B92, undefined);
  scripts\asm\asm::_id_2374("exposed_aimset", undefined, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2374("strafe_aimset", undefined, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2374("melee_charge_to_ready", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("melee_attack", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("melee_attack", scripts\asm\zombie_grey\zombie_grey_asm::_id_85FF, undefined, undefined, undefined, undefined, scripts\asm\zombie_grey\zombie_grey_asm::_id_3EDC, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "melee_attack", "face enemy", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("melee_stand_to_ready", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("melee_attack", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("melee_charge", _id_0F3C::_id_B050, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("melee_charge_to_ready", undefined, scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm_bb::bb_meleechargeaborted, undefined);
  scripts\asm\asm::_id_2374("death_generic", _id_0C34::_id_CF0E, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("death_standing", _id_0C34::_id_CF0E, undefined, undefined, undefined, undefined, _id_0C34::_id_3F00, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("death_crouching", _id_0C34::_id_CF0E, undefined, undefined, undefined, undefined, _id_0C34::_id_3ECA, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("death_moving", _id_0C34::_id_CF0E, undefined, undefined, undefined, undefined, _id_0C34::_id_3EE2, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("death_cover", _id_0C34::_id_CF0E, undefined, undefined, undefined, undefined, _id_0C34::_id_3EC6, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("pain_stand", _id_0C37::_id_D4EE, undefined, undefined, _id_0C37::_id_4109, undefined, _id_0C37::_id_3EEC, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("should_regen", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("pain_run", _id_0C37::_id_D4EE, undefined, undefined, _id_0C37::_id_4109, undefined, _id_0C37::_id_3EEB, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("pain_crouch", _id_0C37::_id_D4EE, undefined, undefined, _id_0C37::_id_4109, undefined, _id_0C37::_id_3EE8, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("pain_prone", _id_0C37::_id_D4EE, undefined, undefined, _id_0C37::_id_4109, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("pain_cover_right", _id_0C37::_id_CF04, undefined, undefined, _id_0C37::_id_4109, undefined, _id_0C37::_id_3EE5, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_cover", "cover_right", undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("pain_cover_stand", _id_0C37::_id_CF04, undefined, undefined, _id_0C37::_id_4109, undefined, _id_0C37::_id_3EE7, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_cover", "cover_stand", undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("pain_cover_crouch", _id_0C37::_id_CF04, undefined, undefined, _id_0C37::_id_4109, undefined, _id_0C37::_id_3EE6, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_cover", "cover_crouch", undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("pain_cover_left", _id_0C37::_id_CF04, undefined, undefined, _id_0C37::_id_4109, undefined, _id_0C37::_id_3EE5, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_cover", "cover_left", undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("pain_on_back", _id_0C37::_id_D4EE, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("pain_cover_left_suppress", _id_0C37::_id_CF04, undefined, undefined, _id_0C37::_id_4109, undefined, _id_0C37::_id_3EE5, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_cover", "cover_left", undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("pain_cover_right_suppress", _id_0C37::_id_CF04, undefined, undefined, _id_0C37::_id_4109, undefined, _id_0C37::_id_3EE5, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_cover", "cover_right", undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("exposed_reload", _id_0C38::reload, undefined, undefined, undefined, undefined, scripts\asm\shared\utility::_id_3EAA, undefined, undefined, undefined, undefined, undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, "reload", "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("regen_start", undefined, scripts\asm\zombie_grey\zombie_grey_asm::_id_13F91, undefined);
  scripts\asm\asm::_id_2375("teleport_to_loner", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleporttoloner, undefined);
  scripts\asm\asm::_id_2375("duplicating_attack", undefined, scripts\asm\zombie_grey\zombie_grey_asm::_id_13F8E, undefined);
  scripts\asm\asm::_id_2375("teleport_attack", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportattack, undefined);
  scripts\asm\asm::_id_2375("teleport_summon", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportsummon, undefined);
  scripts\asm\asm::_id_2375("teleport_dash", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportdash, undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exposed_throw_grenade", _id_0C39::_id_CEC6, undefined, undefined, undefined, undefined, _id_0C39::_id_3EA8, undefined, undefined, undefined, undefined, undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, "throwgrenade", "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exposed_weaponswitch", _id_0C38::_id_CECB, undefined, undefined, undefined, undefined, scripts\asm\shared\utility::chooseanim_weaponswitch, undefined, undefined, undefined, undefined, undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exposed_stand_turn", _id_0C38::_id_D56A, undefined, undefined, undefined, undefined, _id_0C38::_id_3F0A, undefined, undefined, undefined, undefined, undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("regen_start", undefined, scripts\asm\zombie_grey\zombie_grey_asm::_id_13F91, undefined);
  scripts\asm\asm::_id_2375("teleport_to_loner", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleporttoloner, undefined);
  scripts\asm\asm::_id_2375("duplicating_attack", undefined, scripts\asm\zombie_grey\zombie_grey_asm::_id_13F8E, undefined);
  scripts\asm\asm::_id_2375("teleport_attack", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportattack, undefined);
  scripts\asm\asm::_id_2375("teleport_summon", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportsummon, undefined);
  scripts\asm\asm::_id_2375("teleport_dash", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportdash, undefined);
  scripts\asm\asm::_id_2375("exposed_idle", 0, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "finish early");
  scripts\asm\asm::_id_2374("exposed_idle", _id_0C38::_id_D46D, undefined, undefined, undefined, undefined, scripts\asm\zombie_grey\zombie_grey_asm::_id_13F6F, undefined, ["aim"], undefined, undefined, undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("start_exposed_shoot", undefined, ::_id_1214B, undefined);
  scripts\asm\asm::_id_2375("exposed_transitions_out", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("exposed_stand_to_prone", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_prone", 0, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exposed_prone", _id_0C38::_id_D46D, undefined, undefined, undefined, undefined, _id_0F3C::_id_3EAB, "_aim_5", undefined, "prone", undefined, undefined, "pain_prone", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_prone_to_stand", undefined, scripts\asm\asm_bb::_id_2949, "stand");
  scripts\asm\asm::_id_2375("exposed_prone_to_stand", undefined, scripts\asm\asm::_id_BCE7, undefined);
  scripts\asm\asm::_id_2375("exposed_prone_to_crouch", undefined, scripts\asm\asm_bb::_id_2949, "crouch");
  scripts\asm\asm::_id_2374("exposed_prone_to_stand", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_idle", 0, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exposed_stand_to_crouch", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_crouch", 0, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exposed_crouch", _id_0C38::_id_D46D, undefined, undefined, undefined, undefined, _id_0F3C::_id_3EAB, "_aim_5", ["aim"], "crouch", ["shoot_grey"], undefined, "pain_crouch", undefined, "death_crouching", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_crouch_to_stand", undefined, scripts\asm\asm_bb::_id_2949, "stand");
  scripts\asm\asm::_id_2375("exposed_crouch_to_stand", undefined, scripts\asm\asm::_id_BCE7, undefined);
  scripts\asm\asm::_id_2375("exposed_crouch_to_prone", undefined, scripts\asm\asm_bb::_id_2949, "prone");
  scripts\asm\asm::_id_2375("exposed_crouch_turn", undefined, _id_0C38::_id_BEA0, undefined);
  scripts\asm\asm::_id_2375("exposed_reload_crouch", undefined, ::_id_120ED, undefined);
  scripts\asm\asm::_id_2374("exposed_crouch_to_stand", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_idle", 0, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exposed_prone_to_crouch", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_crouch", 0, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exposed_crouch_to_prone", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_prone", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exposed_crouch_turn", _id_0C38::_id_D56A, undefined, undefined, undefined, undefined, _id_0C38::_id_3F0A, undefined, undefined, undefined, undefined, undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_crouch", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2375("exposed_crouch", undefined, scripts\asm\asm::_id_68B0, "finish early");
  scripts\asm\asm::_id_2374("exposed_reload_crouch", _id_0C38::reload, undefined, undefined, undefined, undefined, scripts\asm\shared\utility::_id_3EAA, undefined, undefined, undefined, undefined, undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, "reload", "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_crouch", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exposed_shoot", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, ["aim"], undefined, ["shoot_grey"], undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("end_exposed_shoot", undefined, ::_id_12158, undefined);
  scripts\asm\asm::_id_2374("exposed_transitions_out", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("regen_start", undefined, scripts\asm\zombie_grey\zombie_grey_asm::_id_13F91, undefined);
  scripts\asm\asm::_id_2375("teleport_to_loner", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleporttoloner, undefined);
  scripts\asm\asm::_id_2375("duplicating_attack", undefined, scripts\asm\zombie_grey\zombie_grey_asm::_id_13F8E, undefined);
  scripts\asm\asm::_id_2375("teleport_attack", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportattack, undefined);
  scripts\asm\asm::_id_2375("teleport_summon", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportsummon, undefined);
  scripts\asm\asm::_id_2375("teleport_dash", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportdash, undefined);
  scripts\asm\asm::_id_2375("sprint_loop", undefined, ::_id_12170, undefined);
  scripts\asm\asm::_id_2375("exposed_throw_grenade", undefined, ::_id_1216A, undefined);
  scripts\asm\asm::_id_2375("exposed_weaponswitch", undefined, _id_0C38::_id_100A9, undefined);
  scripts\asm\asm::_id_2375("exposed_stand_turn", undefined, _id_0C38::_id_BEA0, undefined);
  scripts\asm\asm::_id_2375("exposed_exit", undefined, scripts\asm\asm::_id_BCE7, "combat");
  scripts\asm\asm::_id_2375("exposed_crouch_exit", undefined, ::_id_12163, undefined);
  scripts\asm\asm::_id_2375("exposed_crouch_exit", undefined, ::_id_12164, undefined);
  scripts\asm\asm::_id_2375("noncombat_stand_idle", undefined, ::_id_1216D, undefined);
  scripts\asm\asm::_id_2375("melee_attack", undefined, scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::_id_2375("exposed_reload", undefined, ::_id_12167, undefined);
  scripts\asm\asm::_id_2375("exposed_stand_to_crouch", undefined, scripts\asm\asm_bb::_id_2949, "crouch");
  scripts\asm\asm::_id_2375("exposed_stand_to_prone", undefined, scripts\asm\asm_bb::_id_2949, "prone");
  scripts\asm\asm::_id_2374("start_exposed_shoot", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("exposed_shoot", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("end_exposed_shoot", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("exposed_shoot_out", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exposed_shoot_out", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("exposed_reload", undefined, ::_id_12157, undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("step_up_24", _id_0C3A::_id_D566, 24, undefined, undefined, "stand_run_loop", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("iw6_jumpdown_40", _id_0C3A::_id_D566, undefined, undefined, undefined, "stand_run_loop", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("step_down_24", _id_0C3A::_id_D566, undefined, undefined, undefined, "stand_run_loop", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("combatrun_forward_72", _id_0F3C::_id_CEA8, undefined, undefined, undefined, "stand_run_loop", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("wall_hop", _id_0C3A::_id_D55D, 39.875, undefined, undefined, "stand_run_loop", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jumpdown_130", _id_0C3A::_id_D566, undefined, undefined, undefined, "stand_run_loop", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("jumpdown_96", _id_0C3A::_id_D566, undefined, undefined, undefined, "stand_run_loop", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("double_jump_temp", _id_0C3A::_id_D55E, undefined, undefined, undefined, "stand_run_loop", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("traverse_external", _id_0C3A::_id_D560, undefined, undefined, undefined, "stand_run_loop", _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2374("cover_right_arrival", _id_0F3A::_id_CEAA, undefined, undefined, undefined, undefined, _id_0F3A::_id_3E97, "Cover Right", undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "abort");
  scripts\asm\asm::_id_2374("cover_right_exit", _id_0F3B::_id_CEB5, undefined, undefined, undefined, undefined, _id_0F3B::_id_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "code_move");
  scripts\asm\asm::_id_2374("exposed_arrival", _id_0F3A::_id_CEAA, undefined, undefined, undefined, undefined, _id_0F3A::_id_3E97, "Exposed", undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "abort");
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exposed_exit", _id_0F3B::_id_CEB5, undefined, undefined, undefined, undefined, _id_0F3B::_id_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("regen_start", undefined, scripts\asm\zombie_grey\zombie_grey_asm::_id_13F91, undefined);
  scripts\asm\asm::_id_2375("teleport_to_loner", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleporttoloner, undefined);
  scripts\asm\asm::_id_2375("duplicating_attack", undefined, scripts\asm\zombie_grey\zombie_grey_asm::_id_13F8E, undefined);
  scripts\asm\asm::_id_2375("teleport_attack", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportattack, undefined);
  scripts\asm\asm::_id_2375("teleport_summon", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportsummon, undefined);
  scripts\asm\asm::_id_2375("teleport_dash", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportdash, undefined);
  scripts\asm\asm::_id_2375("melee_attack", undefined, scripts\asm\asm_bb::bb_meleechargerequested, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "code_move");
  scripts\asm\asm::_id_2374("stand_run_loop", _id_0F3C::_id_D4DD, undefined, undefined, undefined, undefined, _id_0F3C::_id_3EB8, "run", ["(none)"], "stand", undefined, undefined, "pain_run", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::_id_2375("regen_start", undefined, scripts\asm\zombie_grey\zombie_grey_asm::_id_13F91, undefined);
  scripts\asm\asm::_id_2375("melee_attack", undefined, scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::_id_2375("melee_charge_to_ready", undefined, scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::_id_2375("teleport_to_loner", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleporttoloner, undefined);
  scripts\asm\asm::_id_2375("duplicating_attack", undefined, scripts\asm\zombie_grey\zombie_grey_asm::_id_13F8E, undefined);
  scripts\asm\asm::_id_2375("teleport_attack", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportattack, undefined);
  scripts\asm\asm::_id_2375("teleport_summon", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportsummon, undefined);
  scripts\asm\asm::_id_2375("teleport_dash", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportdash, undefined);
  scripts\asm\asm::_id_2375("run_turn", undefined, _id_0F3B::_id_FFF8, "run_turn");
  scripts\asm\asm::_id_2375("cover_right_arrival", undefined, _id_0F3A::_id_1008A, "Cover Right");
  scripts\asm\asm::_id_2375("cover_left_arrival", undefined, _id_0F3A::_id_1008A, "Cover Left");
  scripts\asm\asm::_id_2375("exposed_arrival", undefined, _id_0F3A::_id_1008A, ["Exposed", 1]);
  scripts\asm\asm::_id_2375("cover_stand_arrival", undefined, _id_0F3A::_id_1008A, "Cover Stand");
  scripts\asm\asm::_id_2375("cover_crouch_arrival", undefined, _id_0F3A::_id_1008A, ["Cover Crouch", 1]);
  scripts\asm\asm::_id_2375("cover_left_crouch_arrival", undefined, _id_0F3A::_id_1008A, "Cover Left Crouch");
  scripts\asm\asm::_id_2375("cover_right_crouch_arrival", undefined, _id_0F3A::_id_1008A, "Cover Right Crouch");
  scripts\asm\asm::_id_2375("exposed_crouch_arrival", undefined, _id_0F3A::_id_1008A, ["Exposed Crouch", 1]);
  scripts\asm\asm::_id_2375("sprint_loop", undefined, ::_id_12581, undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, ::_id_12560, undefined);
  scripts\asm\asm::_id_2375("start_stand_run_strafe", undefined, _id_0F3C::_id_100A3, "stand");
  scripts\asm\asm::_id_2375("stand_run_n_gun_loop", undefined, _id_0C36::_id_10070, undefined);
  scripts\asm\asm::_id_2375("stand_run_n_gun_backwards_loop", undefined, _id_0C36::_id_1006F, undefined);
  scripts\asm\asm::_id_2375("crouch_run_strafe_loop", undefined, _id_0F3C::_id_100A3, "crouch");
  scripts\asm\asm::_id_2374("run_turn", _id_0F3B::_id_D514, undefined, undefined, undefined, undefined, _id_0F3B::_id_3EF5, undefined, undefined, undefined, undefined, undefined, "pain_run", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("teleport_to_loner", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleporttoloner, undefined);
  scripts\asm\asm::_id_2375("duplicating_attack", undefined, scripts\asm\zombie_grey\zombie_grey_asm::_id_13F8E, undefined);
  scripts\asm\asm::_id_2375("regen_start", undefined, scripts\asm\zombie_grey\zombie_grey_asm::_id_13F91, undefined);
  scripts\asm\asm::_id_2375("teleport_attack", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportattack, undefined);
  scripts\asm\asm::_id_2375("teleport_summon", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportsummon, undefined);
  scripts\asm\asm::_id_2375("teleport_dash", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportdash, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "code_move");
  scripts\asm\asm::_id_2374("cover_left_arrival", _id_0F3A::_id_CEAA, undefined, undefined, undefined, undefined, _id_0F3A::_id_3E97, "Cover Left", undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "abort");
  scripts\asm\asm::_id_2374("cover_left_exit", _id_0F3B::_id_CEB5, undefined, undefined, undefined, undefined, _id_0F3B::_id_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "code_move");
  scripts\asm\asm::_id_2374("cover_crouch_exit", _id_0F3B::_id_CEB5, undefined, undefined, undefined, undefined, _id_0F3B::_id_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "code_move");
  scripts\asm\asm::_id_2374("cover_crouch_arrival", _id_0F3A::_id_CEAA, undefined, undefined, undefined, undefined, _id_0F3A::_id_3E97, "Cover Crouch", undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "abort");
  scripts\asm\asm::_id_2374("cover_stand_exit", _id_0F3B::_id_CEB5, undefined, undefined, undefined, undefined, _id_0F3B::_id_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "code_move");
  scripts\asm\asm::_id_2374("cover_stand_arrival", _id_0F3A::_id_CEAA, undefined, undefined, undefined, undefined, _id_0F3A::_id_3E97, "Cover Stand", undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "abort");
  scripts\asm\asm::_id_2374("stand_run_strafe_loop", _id_0F3B::_id_D4E5, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, ["aim"], "stand", ["shoot_grey"], undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stop_stand_run_strafe", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2375("stop_stand_run_strafe", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2375("stop_stand_run_strafe", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2375("teleport_to_loner", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleporttoloner, undefined);
  scripts\asm\asm::_id_2375("stop_stand_run_strafe", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2375("teleport_attack", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportattack, undefined);
  scripts\asm\asm::_id_2375("teleport_summon", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportsummon, undefined);
  scripts\asm\asm::_id_2375("teleport_dash", undefined, scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportdash, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, _id_0F3C::_id_FFB6, "stand");
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm_bb::bb_meleechargerequested, undefined);
  scripts\asm\asm::_id_2374("stand_run_n_gun_loop", _id_0C36::_id_D50D, undefined, undefined, _id_0C36::_id_11088, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, ["shoot_grey"], undefined, "pain_run", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_n_gun_backwards_loop", undefined, _id_0C36::_id_1006F, undefined);
  scripts\asm\asm::_id_2375("run_turn", undefined, _id_0F3B::_id_FFF8, "run_turn");
  scripts\asm\asm::_id_2375("exposed_reload", undefined, ::_id_12591, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, _id_0C36::_id_1009F, undefined);
  scripts\asm\asm::_id_2374("stand_run_n_gun_backwards_loop", _id_0C36::_id_D50E, undefined, undefined, _id_0C36::_id_11088, undefined, _id_0F3C::_id_3E96, "move_back", undefined, undefined, ["shoot_grey"], undefined, "pain_run", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_n_gun_loop", undefined, _id_0C36::_id_10070, undefined);
  scripts\asm\asm::_id_2375("run_turn", undefined, _id_0F3B::_id_FFF8, "run_turn");
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, _id_0C36::_id_1009E, undefined);
  scripts\asm\asm::_id_2374("cover_left_crouch_exit", _id_0F3B::_id_CEB5, undefined, undefined, undefined, undefined, _id_0F3B::_id_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "code_move");
  scripts\asm\asm::_id_2374("cover_right_crouch_exit", _id_0F3B::_id_CEB5, undefined, undefined, undefined, undefined, _id_0F3B::_id_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "code_move");
  scripts\asm\asm::_id_2374("cover_left_crouch_arrival", _id_0F3A::_id_CEAA, undefined, undefined, undefined, undefined, _id_0F3A::_id_3E97, "Cover Left Crouch", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "abort");
  scripts\asm\asm::_id_2374("cover_right_crouch_arrival", _id_0F3A::_id_CEAA, undefined, undefined, undefined, undefined, _id_0F3A::_id_3E97, "Cover Right Crouch", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "abort");
  scripts\asm\asm::_id_2374("exposed_crouch_arrival", _id_0F3A::_id_CEAA, undefined, undefined, undefined, undefined, _id_0F3A::_id_3E97, "Exposed Crouch", undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "abort");
  scripts\asm\asm::_id_2375("exposed_crouch", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("exposed_crouch_exit", _id_0F3B::_id_CEB5, undefined, undefined, undefined, undefined, _id_0F3B::_id_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm::_id_68B0, "code_move");
  scripts\asm\asm::_id_2374("sprint_loop", _id_0F3C::_id_D4DD, undefined, undefined, undefined, undefined, _id_0C36::_id_3EFF, undefined, undefined, undefined, undefined, undefined, "pain_run", undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::_id_2375("melee_attack", undefined, scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, ::_id_12512, undefined);
  scripts\asm\asm::_id_2374("crouch_run_strafe_loop", _id_0F3B::_id_D4E5, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, ["aim"], "stand", ["shoot_grey"], undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, _id_0F3C::_id_FFB6, "crouch");
  scripts\asm\asm::_id_2375("stand_run_loop", undefined, scripts\asm\asm_bb::bb_meleechargerequested, undefined);
  scripts\asm\asm::_id_2374("start_stand_run_strafe", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("stand_run_strafe_loop", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("move_walk_loop", _id_0F3C::_id_D4DD, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::_id_2375("noncombat_stand_idle", undefined, ::_id_122B0, undefined);
  scripts\asm\asm::_id_2374("should_regen", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("regen_start", undefined, scripts\asm\zombie_grey\zombie_grey_asm::_id_13F91, undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("regen", scripts\asm\zombie_grey\zombie_grey_asm::_id_13F72, undefined, undefined, scripts\asm\zombie_grey\zombie_grey_asm::_id_13F70, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("regen_stop", undefined, ::_id_12415, undefined);
  scripts\asm\asm::_id_2374("shockwave", scripts\asm\zombie_grey\zombie_grey_asm::_id_13F76, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "shock_wave_damage");
  scripts\asm\asm::_id_2374("teleport_to_loner", scripts\asm\zombie_grey\zombie_grey_asm::_id_13F7A, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("noncombat_stand_idle", undefined, ::_id_125D0, undefined);
  scripts\asm\asm::_id_2374("duplicating_attack", scripts\asm\zombie_grey\zombie_grey_asm::_id_13F71, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("noncombat_stand_idle", undefined, ::_id_120C1, undefined);
  scripts\asm\asm::_id_2374("being_cloned", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::_id_2375("noncombat_stand_idle", undefined, ::_id_11B90, undefined);
  scripts\asm\asm::_id_2374("regen_start", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("end_regen_start", undefined, scripts\asm\asm::_id_68B0, "early_end");
  scripts\asm\asm::_id_2374("regen_stop", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("regen_pain_in", undefined, scripts\asm\zombie_grey\zombie_grey_asm::_id_13F93, undefined);
  scripts\asm\asm::_id_2375("regen_to_stand", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("regen_to_stand", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("regen_summon", scripts\asm\zombie_grey\zombie_grey_asm::_id_13F75, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("regen", undefined, scripts\asm\asm::_id_68B0, "early_end");
  scripts\asm\asm::_id_2374("intro_vignette", scripts\asm\zombie_grey\zombie_grey_asm::_id_85FE, undefined, undefined, scripts\asm\zombie_grey\zombie_grey_asm::_id_85F7, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("noncombat_stand_idle", undefined, scripts\asm\zombie_grey\zombie_grey_asm::_id_8601, undefined);
  scripts\asm\asm::_id_2374("stop_stand_run_strafe", scripts\asm\shared\utility::_id_2B58, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("regen_summon", undefined, scripts\asm\zombie_grey\zombie_grey_asm::_id_13F91, undefined);
  scripts\asm\asm::_id_2375("duplicating_attack", undefined, scripts\asm\zombie_grey\zombie_grey_asm::_id_13F8E, undefined);
  scripts\asm\asm::_id_2375("exposed_idle", undefined, ::_id_125C5, undefined);
  scripts\asm\asm::_id_2375("exposed_reload", undefined, ::_id_125C6, undefined);
  scripts\asm\asm::_id_2374("teleport_attack", scripts\asm\zombie_grey\zombie_grey_asm::_id_13F77, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", undefined, undefined);
  scripts\asm\asm::_id_2375("noncombat_stand_idle", undefined, ::_id_125CD, undefined);
  scripts\asm\asm::_id_2374("end_regen_start", _id_0F3C::_id_CEA8, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::_id_2375("regen_summon", undefined, scripts\asm\zombie_grey\zombie_grey_asm::_id_13F92, undefined);
  scripts\asm\asm::_id_2375("regen", undefined, scripts\asm\shared\utility::_id_12668, undefined);
  scripts\asm\asm::_id_2374("regen_pain_in", scripts\asm\zombie_grey\zombie_grey_asm::_id_13F73, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("regen_pain_loop", undefined, scripts\asm\asm::_id_68B0, "end");
  scripts\asm\asm::_id_2374("regen_pain_loop", scripts\asm\zombie_grey\zombie_grey_asm::_id_13F74, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("shockwave", undefined, scripts\asm\asm::_id_68B0, "early_end");
  scripts\asm\asm::_id_2374("intro_spawn", scripts\asm\zombie_grey\zombie_grey_asm::_id_85FD, undefined, undefined, scripts\asm\zombie_grey\zombie_grey_asm::_id_85F7, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::_id_2375("noncombat_stand_idle", undefined, scripts\asm\zombie_grey\zombie_grey_asm::_id_8601, undefined);
  scripts\asm\asm::_id_2374("teleport_summon", scripts\asm\zombie_grey\zombie_grey_asm::_id_13F79, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", undefined, undefined);
  scripts\asm\asm::_id_2375("noncombat_stand_idle", undefined, ::_id_125CF, undefined);
  scripts\asm\asm::_id_2374("teleport_dash", scripts\asm\zombie_grey\zombie_grey_asm::_id_13F78, undefined, undefined, undefined, undefined, _id_0F3C::_id_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", undefined, undefined);
  scripts\asm\asm::_id_2375("noncombat_stand_idle", undefined, ::_id_125CE, undefined);
  scripts\asm\asm::_id_2327();
}

_id_122DF(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

_id_122E4(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_isincombat();
}

_id_122DA(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_isincombat();
}

_id_11B91(var_0, var_1, var_2, var_3) {
  return level._id_85EE;
}

_id_11B92(var_0, var_1, var_2, var_3) {
  return !level._id_85EE;
}

_id_1214B(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie_grey\zombie_grey_asm::_id_8602();
}

_id_120ED(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_reloadrequested();
}

_id_12158(var_0, var_1, var_2, var_3) {
  return !scripts\asm\zombie_grey\zombie_grey_asm::_id_8602();
}

_id_12170(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("sprint");
}

_id_1216A(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_throwgrenaderequested();
}

_id_12163(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested() && self._blackboard.movetype == "combat" && _id_0F3C::_id_138E2();
}

_id_12164(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard._id_2BDF) && self._blackboard._id_2BDF && _id_0F3C::_id_138E2();
}

_id_1216D(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_isincombat();
}

_id_12167(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_reloadrequested();
}

_id_12157(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_reloadrequested();
}

_id_12581(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("sprint");
}

_id_12560(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

_id_12591(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_reloadrequested();
}

_id_12512(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_movetyperequested("sprint");
}

_id_122B0(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

_id_12415(var_0, var_1, var_2, var_3) {
  return !scripts\asm\zombie_grey\zombie_grey_asm::_id_13F91();
}

_id_125D0(var_0, var_1, var_2, var_3) {
  return !scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleporttoloner();
}

_id_120C1(var_0, var_1, var_2, var_3) {
  return !scripts\asm\zombie_grey\zombie_grey_asm::_id_13F8E();
}

_id_11B90(var_0, var_1, var_2, var_3) {
  return !scripts\asm\zombie_grey\zombie_grey_asm::_id_13F8C();
}

_id_125C5(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

_id_125C6(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_reloadrequested();
}

_id_125CD(var_0, var_1, var_2, var_3) {
  return !scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportattack();
}

_id_125CF(var_0, var_1, var_2, var_3) {
  return !scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportsummon();
}

_id_125CE(var_0, var_1, var_2, var_3) {
  return !scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportdash();
}