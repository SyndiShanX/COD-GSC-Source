/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3911.gsc
************************/

func_2371() {
  if(scripts\asm\asm::func_232E("zombie_grey")) {
    return;
  }

  lib_0F3F::func_2371();
  scripts\asm\asm::func_230B("zombie_grey", "c6_start");
  scripts\asm\asm::func_2374("enter_combat", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, ["shoot_grey"], undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("noncombat_stand_idle", ::lib_0F3C::func_B050, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, "noncombat_stand_idle", undefined, undefined, undefined, undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("regen_start", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F91, undefined);
  scripts\asm\asm::func_2375("being_cloned", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F8C, undefined);
  scripts\asm\asm::func_2375("teleport_to_loner", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleporttoloner, undefined);
  scripts\asm\asm::func_2375("duplicating_attack", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F8E, undefined);
  scripts\asm\asm::func_2375("teleport_attack", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportattack, undefined);
  scripts\asm\asm::func_2375("teleport_summon", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportsummon, undefined);
  scripts\asm\asm::func_2375("teleport_dash", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportdash, undefined);
  scripts\asm\asm::func_2375("exposed_exit", undefined, ::func_122DF, undefined);
  scripts\asm\asm::func_2375("move_walk_loop", undefined, ::scripts\asm\asm::func_BCE7, "walk");
  scripts\asm\asm::func_2375("exposed_idle", undefined, ::func_122E4, undefined);
  scripts\asm\asm::func_2375("enter_combat", undefined, ::func_122DA, undefined);
  scripts\asm\asm::func_2374("c6_start", ::lib_0C38::func_33FF, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("intro_spawn", undefined, ::func_11B91, undefined);
  scripts\asm\asm::func_2375("intro_vignette", undefined, ::func_11B92, undefined);
  scripts\asm\asm::func_2374("exposed_aimset", undefined, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2374("strafe_aimset", undefined, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2374("melee_charge_to_ready", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::func_2375("melee_attack", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("melee_attack", ::scripts\asm\zombie_grey\zombie_grey_asm::func_85FF, undefined, undefined, undefined, undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::func_3EDC, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, "melee_attack", "face enemy", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("melee_stand_to_ready", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::func_2375("melee_attack", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("melee_charge", ::lib_0F3C::func_B050, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", "anim deltas", undefined);
  scripts\asm\asm::func_2375("melee_charge_to_ready", undefined, ::scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::func_2375("exposed_idle", undefined, ::scripts\asm\asm_bb::bb_meleechargeaborted, undefined);
  scripts\asm\asm::func_2374("death_generic", ::lib_0C34::func_CF0E, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("death_standing", ::lib_0C34::func_CF0E, undefined, undefined, undefined, undefined, ::lib_0C34::func_3F00, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("death_crouching", ::lib_0C34::func_CF0E, undefined, undefined, undefined, undefined, ::lib_0C34::func_3ECA, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("death_moving", ::lib_0C34::func_CF0E, undefined, undefined, undefined, undefined, ::lib_0C34::func_3EE2, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("death_cover", ::lib_0C34::func_CF0E, undefined, undefined, undefined, undefined, ::lib_0C34::func_3EC6, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("pain_stand", ::lib_0C37::func_D4EE, undefined, undefined, ::lib_0C37::func_4109, undefined, ::lib_0C37::func_3EEC, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("should_regen", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("pain_run", ::lib_0C37::func_D4EE, undefined, undefined, ::lib_0C37::func_4109, undefined, ::lib_0C37::func_3EEB, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("pain_crouch", ::lib_0C37::func_D4EE, undefined, undefined, ::lib_0C37::func_4109, undefined, ::lib_0C37::func_3EE8, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("pain_prone", ::lib_0C37::func_D4EE, undefined, undefined, ::lib_0C37::func_4109, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("pain_cover_right", ::lib_0C37::func_CF04, undefined, undefined, ::lib_0C37::func_4109, undefined, ::lib_0C37::func_3EE5, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_cover", "cover_right", undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("pain_cover_stand", ::lib_0C37::func_CF04, undefined, undefined, ::lib_0C37::func_4109, undefined, ::lib_0C37::func_3EE7, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_cover", "cover_stand", undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("pain_cover_crouch", ::lib_0C37::func_CF04, undefined, undefined, ::lib_0C37::func_4109, undefined, ::lib_0C37::func_3EE6, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_cover", "cover_crouch", undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("pain_cover_left", ::lib_0C37::func_CF04, undefined, undefined, ::lib_0C37::func_4109, undefined, ::lib_0C37::func_3EE5, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_cover", "cover_left", undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("pain_on_back", ::lib_0C37::func_D4EE, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("pain_cover_left_suppress", ::lib_0C37::func_CF04, undefined, undefined, ::lib_0C37::func_4109, undefined, ::lib_0C37::func_3EE5, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_cover", "cover_left", undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("pain_cover_right_suppress", ::lib_0C37::func_CF04, undefined, undefined, ::lib_0C37::func_4109, undefined, ::lib_0C37::func_3EE5, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_cover", "cover_right", undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("exposed_reload", ::lib_0C38::openfile, undefined, undefined, undefined, undefined, ::scripts\asm\shared_utility::func_3EAA, undefined, undefined, undefined, undefined, undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, "reload", "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("regen_start", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F91, undefined);
  scripts\asm\asm::func_2375("teleport_to_loner", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleporttoloner, undefined);
  scripts\asm\asm::func_2375("duplicating_attack", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F8E, undefined);
  scripts\asm\asm::func_2375("teleport_attack", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportattack, undefined);
  scripts\asm\asm::func_2375("teleport_summon", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportsummon, undefined);
  scripts\asm\asm::func_2375("teleport_dash", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportdash, undefined);
  scripts\asm\asm::func_2375("exposed_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("exposed_throw_grenade", ::lib_0C39::func_CEC6, undefined, undefined, undefined, undefined, ::lib_0C39::func_3EA8, undefined, undefined, undefined, undefined, undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, "throwgrenade", "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("exposed_weaponswitch", ::lib_0C38::func_CECB, undefined, undefined, undefined, undefined, ::scripts\asm\shared_utility::chooseanim_weaponswitch, undefined, undefined, undefined, undefined, undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("exposed_stand_turn", ::lib_0C38::func_D56A, undefined, undefined, undefined, undefined, ::lib_0C38::func_3F0A, undefined, undefined, undefined, undefined, undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("regen_start", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F91, undefined);
  scripts\asm\asm::func_2375("teleport_to_loner", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleporttoloner, undefined);
  scripts\asm\asm::func_2375("duplicating_attack", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F8E, undefined);
  scripts\asm\asm::func_2375("teleport_attack", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportattack, undefined);
  scripts\asm\asm::func_2375("teleport_summon", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportsummon, undefined);
  scripts\asm\asm::func_2375("teleport_dash", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportdash, undefined);
  scripts\asm\asm::func_2375("exposed_idle", 0, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("exposed_idle", undefined, ::scripts\asm\asm::func_68B0, "finish early");
  scripts\asm\asm::func_2374("exposed_idle", ::lib_0C38::func_D46D, undefined, undefined, undefined, undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F6F, undefined, ["aim"], undefined, undefined, undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("start_exposed_shoot", undefined, ::func_1214B, undefined);
  scripts\asm\asm::func_2375("exposed_transitions_out", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("exposed_stand_to_prone", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_prone", 0, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("exposed_prone", ::lib_0C38::func_D46D, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3EAB, "_aim_5", undefined, "prone", undefined, undefined, "pain_prone", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_prone_to_stand", undefined, ::scripts\asm\asm_bb::func_2949, "stand");
  scripts\asm\asm::func_2375("exposed_prone_to_stand", undefined, ::scripts\asm\asm::func_BCE7, undefined);
  scripts\asm\asm::func_2375("exposed_prone_to_crouch", undefined, ::scripts\asm\asm_bb::func_2949, "crouch");
  scripts\asm\asm::func_2374("exposed_prone_to_stand", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_idle", 0, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("exposed_stand_to_crouch", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_crouch", 0, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("exposed_crouch", ::lib_0C38::func_D46D, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3EAB, "_aim_5", ["aim"], "crouch", ["shoot_grey"], undefined, "pain_crouch", undefined, "death_crouching", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_crouch_to_stand", undefined, ::scripts\asm\asm_bb::func_2949, "stand");
  scripts\asm\asm::func_2375("exposed_crouch_to_stand", undefined, ::scripts\asm\asm::func_BCE7, undefined);
  scripts\asm\asm::func_2375("exposed_crouch_to_prone", undefined, ::scripts\asm\asm_bb::func_2949, "prone");
  scripts\asm\asm::func_2375("exposed_crouch_turn", undefined, ::lib_0C38::func_BEA0, undefined);
  scripts\asm\asm::func_2375("exposed_reload_crouch", undefined, ::func_120ED, undefined);
  scripts\asm\asm::func_2374("exposed_crouch_to_stand", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_idle", 0, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("exposed_prone_to_crouch", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_crouch", 0, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("exposed_crouch_to_prone", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_prone", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("exposed_crouch_turn", ::lib_0C38::func_D56A, undefined, undefined, undefined, undefined, ::lib_0C38::func_3F0A, undefined, undefined, undefined, undefined, undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_crouch", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2375("exposed_crouch", undefined, ::scripts\asm\asm::func_68B0, "finish early");
  scripts\asm\asm::func_2374("exposed_reload_crouch", ::lib_0C38::openfile, undefined, undefined, undefined, undefined, ::scripts\asm\shared_utility::func_3EAA, undefined, undefined, undefined, undefined, undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, "reload", "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_crouch", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("exposed_shoot", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, ["aim"], undefined, ["shoot_grey"], undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("end_exposed_shoot", undefined, ::func_12158, undefined);
  scripts\asm\asm::func_2374("exposed_transitions_out", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("regen_start", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F91, undefined);
  scripts\asm\asm::func_2375("teleport_to_loner", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleporttoloner, undefined);
  scripts\asm\asm::func_2375("duplicating_attack", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F8E, undefined);
  scripts\asm\asm::func_2375("teleport_attack", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportattack, undefined);
  scripts\asm\asm::func_2375("teleport_summon", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportsummon, undefined);
  scripts\asm\asm::func_2375("teleport_dash", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportdash, undefined);
  scripts\asm\asm::func_2375("sprint_loop", undefined, ::func_12170, undefined);
  scripts\asm\asm::func_2375("exposed_throw_grenade", undefined, ::func_1216A, undefined);
  scripts\asm\asm::func_2375("exposed_weaponswitch", undefined, ::lib_0C38::func_100A9, undefined);
  scripts\asm\asm::func_2375("exposed_stand_turn", undefined, ::lib_0C38::func_BEA0, undefined);
  scripts\asm\asm::func_2375("exposed_exit", undefined, ::scripts\asm\asm::func_BCE7, "combat");
  scripts\asm\asm::func_2375("exposed_crouch_exit", undefined, ::func_12163, undefined);
  scripts\asm\asm::func_2375("exposed_crouch_exit", undefined, ::func_12164, undefined);
  scripts\asm\asm::func_2375("noncombat_stand_idle", undefined, ::func_1216D, undefined);
  scripts\asm\asm::func_2375("melee_attack", undefined, ::scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::func_2375("exposed_reload", undefined, ::func_12167, undefined);
  scripts\asm\asm::func_2375("exposed_stand_to_crouch", undefined, ::scripts\asm\asm_bb::func_2949, "crouch");
  scripts\asm\asm::func_2375("exposed_stand_to_prone", undefined, ::scripts\asm\asm_bb::func_2949, "prone");
  scripts\asm\asm::func_2374("start_exposed_shoot", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("exposed_shoot", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("end_exposed_shoot", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("exposed_shoot_out", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("exposed_shoot_out", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("exposed_reload", undefined, ::func_12157, undefined);
  scripts\asm\asm::func_2375("exposed_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("step_up_24", ::lib_0C3A::func_D566, 24, undefined, undefined, "stand_run_loop", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("iw6_jumpdown_40", ::lib_0C3A::func_D566, undefined, undefined, undefined, "stand_run_loop", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("step_down_24", ::lib_0C3A::func_D566, undefined, undefined, undefined, "stand_run_loop", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("combatrun_forward_72", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, "stand_run_loop", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("wall_hop", ::lib_0C3A::func_D55D, 39.875, undefined, undefined, "stand_run_loop", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jumpdown_130", ::lib_0C3A::func_D566, undefined, undefined, undefined, "stand_run_loop", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("jumpdown_96", ::lib_0C3A::func_D566, undefined, undefined, undefined, "stand_run_loop", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("double_jump_temp", ::lib_0C3A::func_D55E, undefined, undefined, undefined, "stand_run_loop", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("traverse_external", ::lib_0C3A::func_D560, undefined, undefined, undefined, "stand_run_loop", ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("cover_right_arrival", ::lib_0F3A::func_CEAA, undefined, undefined, undefined, undefined, ::lib_0F3A::func_3E97, "Cover Right", undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, ::scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2374("cover_right_exit", ::lib_0F3B::func_CEB5, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2374("exposed_arrival", ::lib_0F3A::func_CEAA, undefined, undefined, undefined, undefined, ::lib_0F3A::func_3E97, "Exposed", undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, ::scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2375("exposed_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("exposed_exit", ::lib_0F3B::func_CEB5, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("regen_start", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F91, undefined);
  scripts\asm\asm::func_2375("teleport_to_loner", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleporttoloner, undefined);
  scripts\asm\asm::func_2375("duplicating_attack", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F8E, undefined);
  scripts\asm\asm::func_2375("teleport_attack", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportattack, undefined);
  scripts\asm\asm::func_2375("teleport_summon", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportsummon, undefined);
  scripts\asm\asm::func_2375("teleport_dash", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportdash, undefined);
  scripts\asm\asm::func_2375("melee_attack", undefined, ::scripts\asm\asm_bb::bb_meleechargerequested, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2374("stand_run_loop", ::lib_0F3C::func_D4DD, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3EB8, "run", ["(none)"], "stand", undefined, undefined, "pain_run", undefined, "death_moving", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("regen_start", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F91, undefined);
  scripts\asm\asm::func_2375("melee_attack", undefined, ::scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::func_2375("melee_charge_to_ready", undefined, ::scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::func_2375("teleport_to_loner", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleporttoloner, undefined);
  scripts\asm\asm::func_2375("duplicating_attack", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F8E, undefined);
  scripts\asm\asm::func_2375("teleport_attack", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportattack, undefined);
  scripts\asm\asm::func_2375("teleport_summon", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportsummon, undefined);
  scripts\asm\asm::func_2375("teleport_dash", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportdash, undefined);
  scripts\asm\asm::func_2375("run_turn", undefined, ::lib_0F3B::func_FFF8, "run_turn");
  scripts\asm\asm::func_2375("cover_right_arrival", undefined, ::lib_0F3A::func_1008A, "Cover Right");
  scripts\asm\asm::func_2375("cover_left_arrival", undefined, ::lib_0F3A::func_1008A, "Cover Left");
  scripts\asm\asm::func_2375("exposed_arrival", undefined, ::lib_0F3A::func_1008A, ["Exposed", 1]);
  scripts\asm\asm::func_2375("cover_stand_arrival", undefined, ::lib_0F3A::func_1008A, "Cover Stand");
  scripts\asm\asm::func_2375("cover_crouch_arrival", undefined, ::lib_0F3A::func_1008A, ["Cover Crouch", 1]);
  scripts\asm\asm::func_2375("cover_left_crouch_arrival", undefined, ::lib_0F3A::func_1008A, "Cover Left Crouch");
  scripts\asm\asm::func_2375("cover_right_crouch_arrival", undefined, ::lib_0F3A::func_1008A, "Cover Right Crouch");
  scripts\asm\asm::func_2375("exposed_crouch_arrival", undefined, ::lib_0F3A::func_1008A, ["Exposed Crouch", 1]);
  scripts\asm\asm::func_2375("sprint_loop", undefined, ::func_12581, undefined);
  scripts\asm\asm::func_2375("exposed_idle", undefined, ::func_12560, undefined);
  scripts\asm\asm::func_2375("start_stand_run_strafe", undefined, ::lib_0F3C::func_100A3, "stand");
  scripts\asm\asm::func_2375("stand_run_n_gun_loop", undefined, ::lib_0C36::func_10070, undefined);
  scripts\asm\asm::func_2375("stand_run_n_gun_backwards_loop", undefined, ::lib_0C36::func_1006F, undefined);
  scripts\asm\asm::func_2375("crouch_run_strafe_loop", undefined, ::lib_0F3C::func_100A3, "crouch");
  scripts\asm\asm::func_2374("run_turn", ::lib_0F3B::func_D514, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3EF5, undefined, undefined, undefined, undefined, undefined, "pain_run", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("teleport_to_loner", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleporttoloner, undefined);
  scripts\asm\asm::func_2375("duplicating_attack", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F8E, undefined);
  scripts\asm\asm::func_2375("regen_start", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F91, undefined);
  scripts\asm\asm::func_2375("teleport_attack", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportattack, undefined);
  scripts\asm\asm::func_2375("teleport_summon", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportsummon, undefined);
  scripts\asm\asm::func_2375("teleport_dash", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportdash, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2374("cover_left_arrival", ::lib_0F3A::func_CEAA, undefined, undefined, undefined, undefined, ::lib_0F3A::func_3E97, "Cover Left", undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, ::scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2374("cover_left_exit", ::lib_0F3B::func_CEB5, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2374("cover_crouch_exit", ::lib_0F3B::func_CEB5, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2374("cover_crouch_arrival", ::lib_0F3A::func_CEAA, undefined, undefined, undefined, undefined, ::lib_0F3A::func_3E97, "Cover Crouch", undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, ::scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2374("cover_stand_exit", ::lib_0F3B::func_CEB5, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2374("cover_stand_arrival", ::lib_0F3A::func_CEAA, undefined, undefined, undefined, undefined, ::lib_0F3A::func_3E97, "Cover Stand", undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, ::scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2374("stand_run_strafe_loop", ::lib_0F3B::func_D4E5, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, ["aim"], "stand", ["shoot_grey"], undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("melee_attack", undefined, ::scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::func_2375("stop_stand_run_strafe", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, ::lib_0F3C::func_FFB6, "stand");
  scripts\asm\asm::func_2375("stand_run_loop", undefined, ::scripts\asm\asm_bb::bb_meleechargerequested, undefined);
  scripts\asm\asm::func_2375("teleport_to_loner", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleporttoloner, undefined);
  scripts\asm\asm::func_2375("teleport_attack", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportattack, undefined);
  scripts\asm\asm::func_2375("teleport_summon", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportsummon, undefined);
  scripts\asm\asm::func_2375("teleport_dash", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportdash, undefined);
  scripts\asm\asm::func_2374("stand_run_n_gun_loop", ::lib_0C36::func_D50D, undefined, undefined, ::lib_0C36::func_11088, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, ["shoot_grey"], undefined, "pain_run", undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_n_gun_backwards_loop", undefined, ::lib_0C36::func_1006F, undefined);
  scripts\asm\asm::func_2375("run_turn", undefined, ::lib_0F3B::func_FFF8, "run_turn");
  scripts\asm\asm::func_2375("exposed_reload", undefined, ::func_12591, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, ::lib_0C36::func_1009F, undefined);
  scripts\asm\asm::func_2374("stand_run_n_gun_backwards_loop", ::lib_0C36::func_D50E, undefined, undefined, ::lib_0C36::func_11088, undefined, ::lib_0F3C::func_3E96, "move_back", undefined, undefined, ["shoot_grey"], undefined, "pain_run", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_n_gun_loop", undefined, ::lib_0C36::func_10070, undefined);
  scripts\asm\asm::func_2375("run_turn", undefined, ::lib_0F3B::func_FFF8, "run_turn");
  scripts\asm\asm::func_2375("stand_run_loop", undefined, ::lib_0C36::func_1009E, undefined);
  scripts\asm\asm::func_2374("cover_left_crouch_exit", ::lib_0F3B::func_CEB5, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2374("cover_right_crouch_exit", ::lib_0F3B::func_CEB5, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2374("cover_left_crouch_arrival", ::lib_0F3A::func_CEAA, undefined, undefined, undefined, undefined, ::lib_0F3A::func_3E97, "Cover Left Crouch", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, ::scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2374("cover_right_crouch_arrival", ::lib_0F3A::func_CEAA, undefined, undefined, undefined, undefined, ::lib_0F3A::func_3E97, "Cover Right Crouch", undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, ::scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2374("exposed_crouch_arrival", ::lib_0F3A::func_CEAA, undefined, undefined, undefined, undefined, ::lib_0F3A::func_3E97, "Exposed Crouch", undefined, undefined, undefined, undefined, undefined, undefined, "death_moving", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, ::scripts\asm\asm::func_68B0, "abort");
  scripts\asm\asm::func_2375("exposed_crouch", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("exposed_crouch_exit", ::lib_0F3B::func_CEB5, undefined, undefined, undefined, undefined, ::lib_0F3B::func_3E9F, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, ::scripts\asm\asm::func_68B0, "code_move");
  scripts\asm\asm::func_2374("sprint_loop", ::lib_0F3C::func_D4DD, undefined, undefined, undefined, undefined, ::lib_0C36::func_3EFF, undefined, undefined, undefined, undefined, undefined, "pain_run", undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("melee_attack", undefined, ::scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, ::func_12512, undefined);
  scripts\asm\asm::func_2374("crouch_run_strafe_loop", ::lib_0F3B::func_D4E5, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, ["aim"], "stand", ["shoot_grey"], undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("stand_run_loop", undefined, ::lib_0F3C::func_FFB6, "crouch");
  scripts\asm\asm::func_2375("stand_run_loop", undefined, ::scripts\asm\asm_bb::bb_meleechargerequested, undefined);
  scripts\asm\asm::func_2374("start_stand_run_strafe", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("melee_attack", undefined, ::scripts\asm\asm_bb::bb_meleerequested, undefined);
  scripts\asm\asm::func_2375("stand_run_strafe_loop", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("move_walk_loop", ::lib_0F3C::func_D4DD, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, "pain_stand", undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("noncombat_stand_idle", undefined, ::func_122B0, undefined);
  scripts\asm\asm::func_2374("should_regen", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("regen_start", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F91, undefined);
  scripts\asm\asm::func_2375("exposed_idle", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("regen", ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F72, undefined, undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F70, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("regen_stop", undefined, ::func_12415, undefined);
  scripts\asm\asm::func_2374("shockwave", ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F76, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exposed_idle", undefined, ::scripts\asm\asm::func_68B0, "shock_wave_damage");
  scripts\asm\asm::func_2374("teleport_to_loner", ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F7A, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("noncombat_stand_idle", undefined, ::func_125D0, undefined);
  scripts\asm\asm::func_2374("duplicating_attack", ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F71, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("noncombat_stand_idle", undefined, ::func_120C1, undefined);
  scripts\asm\asm::func_2374("being_cloned", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("noncombat_stand_idle", undefined, ::func_11B90, undefined);
  scripts\asm\asm::func_2374("regen_start", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("end_regen_start", undefined, ::scripts\asm\asm::func_68B0, "early_end");
  scripts\asm\asm::func_2374("regen_stop", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("regen_pain_in", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F93, undefined);
  scripts\asm\asm::func_2375("regen_to_stand", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("regen_to_stand", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("exposed_idle", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("regen_summon", ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F75, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("regen", undefined, ::scripts\asm\asm::func_68B0, "early_end");
  scripts\asm\asm::func_2374("intro_vignette", ::scripts\asm\zombie_grey\zombie_grey_asm::func_85FE, undefined, undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::func_85F7, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("noncombat_stand_idle", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::func_8601, undefined);
  scripts\asm\asm::func_2374("stop_stand_run_strafe", ::scripts\asm\shared_utility::func_2B58, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("regen_summon", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F91, undefined);
  scripts\asm\asm::func_2375("duplicating_attack", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F8E, undefined);
  scripts\asm\asm::func_2375("exposed_idle", undefined, ::func_125C5, undefined);
  scripts\asm\asm::func_2375("exposed_reload", undefined, ::func_125C6, undefined);
  scripts\asm\asm::func_2374("teleport_attack", ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F77, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", undefined, undefined);
  scripts\asm\asm::func_2375("noncombat_stand_idle", undefined, ::func_125CD, undefined);
  scripts\asm\asm::func_2374("end_regen_start", ::lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("regen_summon", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F92, undefined);
  scripts\asm\asm::func_2375("regen", undefined, ::scripts\asm\shared_utility::func_12668, undefined);
  scripts\asm\asm::func_2374("regen_pain_in", ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F73, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("regen_pain_loop", undefined, ::scripts\asm\asm::func_68B0, "end");
  scripts\asm\asm::func_2374("regen_pain_loop", ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F74, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("shockwave", undefined, ::scripts\asm\asm::func_68B0, "early_end");
  scripts\asm\asm::func_2374("intro_spawn", ::scripts\asm\zombie_grey\zombie_grey_asm::func_85FD, undefined, undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::func_85F7, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("noncombat_stand_idle", undefined, ::scripts\asm\zombie_grey\zombie_grey_asm::func_8601, undefined);
  scripts\asm\asm::func_2374("teleport_summon", ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F79, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", undefined, undefined);
  scripts\asm\asm::func_2375("noncombat_stand_idle", undefined, ::func_125CF, undefined);
  scripts\asm\asm::func_2374("teleport_dash", ::scripts\asm\zombie_grey\zombie_grey_asm::func_13F78, undefined, undefined, undefined, undefined, ::lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face enemy", undefined, undefined);
  scripts\asm\asm::func_2375("noncombat_stand_idle", undefined, ::func_125CE, undefined);
  scripts\asm\asm::func_2327();
}

func_122DF(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested();
}

func_122E4(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_isincombat();
}

func_122DA(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_isincombat();
}

func_11B91(var_0, var_1, var_2, var_3) {
  return level.var_85EE;
}

func_11B92(var_0, var_1, var_2, var_3) {
  return !level.var_85EE;
}

func_1214B(var_0, var_1, var_2, var_3) {
  return scripts\asm\zombie_grey\zombie_grey_asm::func_8602();
}

func_120ED(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_reloadrequested();
}

func_12158(var_0, var_1, var_2, var_3) {
  return !scripts\asm\zombie_grey\zombie_grey_asm::func_8602();
}

func_12170(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("sprint");
}

func_1216A(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_throwgrenaderequested();
}

func_12163(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_moverequested() && self._blackboard.movetype == "combat" && lib_0F3C::func_138E2();
}

func_12164(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.var_2BDF) && self._blackboard.var_2BDF && lib_0F3C::func_138E2();
}

func_1216D(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_isincombat();
}

func_12167(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_reloadrequested();
}

func_12157(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_reloadrequested();
}

func_12581(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_movetyperequested("sprint");
}

func_12560(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

func_12591(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_reloadrequested();
}

func_12512(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_movetyperequested("sprint");
}

func_122B0(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

func_12415(var_0, var_1, var_2, var_3) {
  return !scripts\asm\zombie_grey\zombie_grey_asm::func_13F91();
}

func_125D0(var_0, var_1, var_2, var_3) {
  return !scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleporttoloner();
}

func_120C1(var_0, var_1, var_2, var_3) {
  return !scripts\asm\zombie_grey\zombie_grey_asm::func_13F8E();
}

func_11B90(var_0, var_1, var_2, var_3) {
  return !scripts\asm\zombie_grey\zombie_grey_asm::func_13F8C();
}

func_125C5(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_moverequested();
}

func_125C6(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_reloadrequested();
}

func_125CD(var_0, var_1, var_2, var_3) {
  return !scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportattack();
}

func_125CF(var_0, var_1, var_2, var_3) {
  return !scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportsummon();
}

func_125CE(var_0, var_1, var_2, var_3) {
  return !scripts\asm\zombie_grey\zombie_grey_asm::zombiegreyshouldteleportdash();
}