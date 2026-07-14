/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\values.gsc
**************************************/

#using script_16ea1b94f0f381b3;
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\string;
#using scripts\common\system;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\engine\utility;
#namespace val;

function private autoexec __init__system__() {
  system::register(#"val", undefined, &pre_main, undefined);
}

function pre_main() {
  if(isDefined(level.values_pre_main)) {
    return;
  }

  level.values_pre_main = 1;
  register("breath_system", 1, 0, "$self", &set_breath_system, "$value");
  register("damage", 1, 0, "$self", &function_980d507a19a6bda4, "$value");
  register("death", 1, 0, "$self", &function_fe5fe7cd67808fa1, "$value");
  register("damageshield", 0, 1, "$self", &function_51af51b23ad15aae, "$value");
  register("deathShieldThreshold", -1, -1, "$self", &function_c24a1bd2d82db73d, "$value");
  register("trigger_hurt_damage", 1, 0, "$self", &function_d570a4005ac0b537, "$value");
  register("interacts_with_oob_triggers", 1, 0);
  register("ignoresuppression", 0, 1, "$self", &function_eb87a62cdf0480f5, "$value");
  register("whizby", 1, 0);
  register("ignoreme", 0, 1, "$self", &function_95066ad96cccfad0, "$value");
  register("ignoreall", 0, 1, "$self", &function_c120622a6e09fe01, "$value");
  register("take_weapons", 0, 1, "$self", &set_takeweapons, "$value");
  register("weapon", 1, 0, "$self", &function_20dc6a278a598f22, "$value");
  register("weapon_switch", 1, 0, "$self", &function_fad3d2efb21d3796, "$value");
  register("weapon_switch_clip", 1, 0, "$self", &function_69663cfde5a760c0, "$value");
  register("script_weapon_switch", 0, 1);
  register("reload", 1, 0, "$self", &function_774a7b576d576eac, "$value");
  register("reload_speed", 1, 1, "$self", &function_a72eede1b3cfd014, "$value");
  register("weapon_pickup", 1, 0, "$self", &function_e208c91eb84ed565, "$value");
  register("fire", 1, 0, "$self", &function_14a1b35a268ca4b9, "$value");
  register("weapon_motion_ik", 1, 0, "$self", &function_d7a1169db9553b28, "$value");
  register("autoreload", 1, 0, "$self", &function_1fd9d609b5af3807, "$value");
  register("weapon_first_raise_anims", 1, 0, "$self", &function_f61e0e9b7270852f, "$value");
  register("weapon_inspect", 1, 0, "$self", &function_ae04fcfb3e401f12, "$value");
  register("offhand_weapons", 1, 0, "$self", &function_a1162f2424489dd0, "$value");
  register("force_enable_offhand_sprays", 0, 0, "$self", &set_force_enable_offhand_sprays, "$value");
  register("toggle_remote_revive", 0, 1, "$self", &set_remote_revive, "$value");
  register("toggle_remote_self_revive", 0, 1, "$self", &function_ac426ec234868b04, "$value");
  register("ignore_afk", 0, 1, "$self", &function_19b569afca12ffd7, "$value");
  register("dont_evolve", 0, 1, "$self", &set_dont_evolve, "$value");

  if(!isDefined(level.ismp) || level.ismp == 0) {
    link("offhand_weapons", "offhand_shield_weapons");
  }

  register("offhand_primary_weapons", 1, 0, "$self", &function_62d014caf91572e2, "$value");
  register("offhand_secondary_weapons", 1, 0, "$self", &function_36cea73c3b5fd96e, "$value");
  link("offhand_secondary_weapons", "offhand_shield_weapons");
  register("offhand_shield_weapons", 1, 0, "$self", &function_20012a3279532ca5, "$value");
  register("offhand_throwback", 1, 0, "$self", &function_37a151011f0964e7, "$value");
  register("allow_offhand_special", 1, 0, "$self", &set_allow_offhand_special, "$value");
  register("allow_aim_assist", 1, 0, "$self", &set_allow_aim_assist, "$value");
  register("usability", 1, 0, "$self", &function_d997fb9e4213c391, "$value");
  register("disallow_loot_but_auto_loot", 0, 1, "$self", &disallow_loot_but_auto_loot, "$value");
  register("disallow_usability_but_loot", 0, 1, "$self", &disallow_usability_but_loot, "$value");
  register("freezecontrols", 0, 1, "$self", &function_ef500d3d9308db93, "$value");
  register("freezecontrols_allowlook", 0, 1, "$self", &function_d9233b319f90661, "$value");
  register("hide", 0, 1, "$self", &set_hide, "$value");
  register("non_deletable", 0, 1, "$self", &set_non_deletable, "$value");
  register("health_regen", 1, 0, "$self", &set_health_regen, "$value");
  register("allow_health_regen_delay", 1, 0, "$self", &set_allow_health_regen_delay, "$value");
  register("ignore_health_regen_delay", 0, 1, "$self", &set_ignore_health_regen_delay, "$value");
  register("allow_last_stand", 0, 0);
  register("stealth_social_reveal", 0, 1, "$self", &function_2005a18622e4bc7c, "$value");
  register("show_hud", 1, 0, "$self", &function_fb7abaa719858b69, "$value");
  register("show_weapon_hud", 1, 0, "$self", &function_ebf3d4d401322e8, "$value");
  register("show_dpad_hud", 1, 0, "$self", &function_c5e5bd6fb67422ed, "$value");
  register("show_targetmarker", 1, 0, "$self", &function_3bebe3c7d4a7d93d, "$value");
  register("allow_jump", 1, 0, "$self", &set_allowjump, "$value");
  register("allow_double_jump", 1, 0, "$self", &set_allowdoublejump, "$value");
  register("crouch", 1, 0, "$self", &set_allowcrouch, "$value");
  register("prone", 1, 0, "$self", &set_allowprone, "$value");
  register("stance_change", 1, 0, "$self", &function_1ae65704940e4424, "$value");
  register("melee", 1, 0, "$self", &set_allowmelee, "$value");
  register("lean", 1, 0, "$self", &set_allowlean, "$value");
  register("allow_melee_victim", 1, 0, "$self", &allow_melee_victim, "$value");
  register("mantle", 1, 0, "$self", &set_allowmantle, "$value");
  register("ledgehang", 1, 0, "$self", &function_5e9e3b2f69f6f529, "$value");
  register("mount_top", 1, 0, "$self", &set_allowmounttop, "$value");
  register("mount_side", 1, 0, "$self", &set_allowmountside, "$value");
  register("sprint", 1, 0, "$self", &set_allowsprint, "$value");
  register("jog", 1, 0, "$self", &set_allowjog, "$value");
  register("ads", 1, 0, "$self", &set_allowads, "$value");
  register("stand", 1, 0, "$self", &set_allowstand, "$value");
  register("allow_movement", 1, 0, "$self", &set_allowmovement, "$value");
  register("ladder", 1, 0, "$self", &set_allowladder, "$value");
  register("swimming", 1, 0, "$self", &function_a8117c7579bc7929, "$value");
  register("swimming_underwater", 1, 0, "$self", &function_7ab726a64720c8a4, "$value");
  register("swimming_sprint", 1, 0, "$self", &function_48acf32c9c54465c, "$value");
  register("swimming_jump", 1, 0, "$self", &function_115021318817a3e4, "$value");
  register("base_jumping", 1, 0, "$self", &function_a4ce58974995b16f, "$value");
  register("dtp", 1, 0, "$self", &function_1c864094a7f7b03c, "$value");
  register("desired_speed", 0, 0, "$self", &set_desiredspeed, "$value");
  register("goalradius", 2048, 2048, "$self", &function_cc381b7879a5f0d6, "$value");
  register("push_player", 0, 1, "$self", &set_pushplayer, "$value");
  register("skip_death", 0, 1, "$self", &set_skip_death, "$value");
  register("skip_scene_death", 0, 1, "$self", &set_skip_scene_death, "$value");
  register("supers", 1, 0, "$self", &function_877815b778be0789, "$value");
  register("super_pickup", 1, 1, "$self", &function_f9218624505e928d, "$value");
  register("super_switching", 1, 0, "$self", &function_68e3a3ac765536e7, "$value");
  register("wallrun", 1, 0, "$self", &function_19abbc82717ff6e, "$value");
  register("doublejump", 1, 0, "$self", &function_11ec4cf4a1f78d50, "$value");
  register("slide", 1, 0, "$self", &function_394d0e1971506f5a, "$value");
  register("execution_attack", 1, 0, "$self", &function_29d0c9f9c06a0716, "$value");
  register("execution_victim", 1, 0, "$self", &function_d8c73090e01eec0a, "$value");
  register("heavy_melee_execution_victim", 1, 0, "$self", &function_c024a5143db30f53, "$value");
  register("vehicle_use", 1, 0, "$self", &function_457b17f56ea93057, "$value");
  register("vehicle_lean_out", 1, 0, "$self", &function_2eaa66d57872ea23, "$value");
  register("vehicle_seat_switch", 1, 0, "$self", &function_8897b3febd975b3e, "$value");
  register("vehicle_exit", 1, 0);
  register("vehicle_predictive_ragdoll", 1, 0, "$self", &function_5724d3c9e7701db1, "$value");
  register("nvg", 1, 0, "$self", &function_bb0d10ecbfbeaeb9, "$value");
  register("supersprint", 1, 0, "$self", &function_797fbc5fdce1604, "$value");
  register("shellshock", 1, 0, "$self", &function_288bef4a53a454c1, "$value");
  register("cinematic_motion", 1, 0, "$self", &function_afc959ebf3565f45, "$value");
  register("armor", 1, 0, "$self", &function_ab098c39abd0a60, "$value");
  register("door_frozen", 0, 1, "$self", &set_door_frozen, "$value");
  register("interactions", 1, 0, "$self", &function_36d470fc6707078c, "$value");
  register("action_slot_weapon", 1, 0, "$self", &function_48bbce421e2098f9, "$value");
  register("disallow_body_carry", 0, 1, "$self", &set_disallow_body_carry, "$value");
  register("disallow_body_shield", 0, 1, "$self", &set_disallow_body_shield, "$value");
  register("no_bullet_miss_fx", 0, 1, "$self", &function_f01949d7ffcf11f7, "$value");
  register("allow_wall_jump", 1, 1, "$self", &function_df742befdf77ed04, "$value");
  register("allow_active_roll", 1, 1, "$self", &function_21ceb22acb454b71, "$value");
  register("allow_free_fire", 0, 0, "$self", &function_38e816a25d06e176, "$value");
  register("move_speed_scale", 1, 1, "$self", &set_movespeedscale, "$value");
  register("move_speed_scale_mult", 1, 1, "$self", &set_movespeedscalemult, "$value");
  link("move_speed_scale", "move_speed_scale_mult", undefined, 1);
  register("equipment_primary", 1, 0, "$self", &function_2e13ccfdf6cd4702, "$value");
  register("equipment_secondary", 1, 0, "$self", &function_b2dbe5926fba028e, "$value");
  register("overlord_locked_priority", 0, 0, "$self", &set_overlord_locked_priority, "$value");
  register("backpack_inventory", 1, 0, "$self", &function_795d7b6d27c07c84, "$value");
  register("tacmap_scoreboard", 1, 0, "$self", &function_bfe2fb4299424726, "$value");
  register("demeanor", "", "", "$self", &set_demeanor, "$value");
  register("pain", 1, 0, "$self", &function_69c3c2915908991, "$value");
  register("special_pain", 1, 0, "$self", &function_fd5ee72fff1d88d1, "$value");
  register("infinite_ammo", 0, 1, "$self", &set_infinite_ammo, "$value");
  register("kill_on_damage", 0, 0, "$self", &set_kill_on_damage, "$value");
  register("reduce_damage_effects", 0, 0, "$self", &set_reduce_damage_effects, "$value");
  register("collide_with_ai_allies", 1, 0, "$self", &set_collide_with_ai_allies, "$value");
  register("script_pushable_by_ai", 1, 0, "$self", &function_a7120a590add6c5a, "$value");
  register("script_pushable", 1, 0, "$self", &function_1afc684096493969, "$value");
  register("hide_operator_backpack", 0, 1, "$self", &set_hide_operator_backpack, "$value");
  register("show_operator_pet", 1, 0, "$self", &set_show_operator_pet, "$value");
  register("allow_give_point", 1, 1, "$self", &set_allow_give_point, "$value");
  register("allow_give_super_point", 1, 1, "$self", &set_allow_give_super_point, "$value");
  register("pause_zombie_spawning", 0, 0, "$self", &set_pause_zombie_spawning, "$value");
  register("show_healthbar", 1, 1, "$self", &set_show_healthbar, "$value");
  register("force_show_healthbar_distance", 0, 300, "$self", &function_9f3b98d1081b9f, "$value");
  register("play_ambient_vo", 1, 1, "$self", &function_a36d1e1879f4a10d, "$value");
  register("allow_vo", 1, 1, "$self", &set_allow_vo, "$value");
  register("toggle_eye_glow", 1, 1, "$self", &function_54063e236477cf2a, "$value");
  register("allow_unreachable_attack", 1, 1, "$self", &set_allow_unreachable_attack, "$value");
  register("trial_logic_activate", 1, 1, "$self", &set_trial_logic_activate, "$value");
  register("task_logic_activate", 1, 1, "$self", &set_task_logic_activate, "$value");
  register("allow_combat_attractors", 1, 1, "$self", &set_allow_combat_attractors, "$value");
  register("slide_boost", 1, 1);
  register("ignore_playable_area_check", 0, 1);
  register("show_perks", 1, 1, "$self", &set_show_perks, "$value");
  register("show_perk_decay", 1, 1, "$self", &function_bfbaa9ffafdb11b2, "$value");
  register("allow_reload_without_reserve_ammo", 0, 0, "$self", &function_284901af56e908eb, "$value");
  register("attackeraccuracy", 1, 1, "$self", &function_2204daa2cfda7e2c, "$value");
  register("ascender_use", 1, 0);
  register("crate_use", 1, 0);
  register("cough_gesture", 1, 0);
  register("ladder_placement", 1, 0);
  register("killstreaks", 1, 0, "$self", &function_a887952f6b595ba4, ["killstreaks", "$value"]);
  register("remote_killstreaks", 1, 0, "$self", &function_a887952f6b595ba4, ["remote_killstreaks", "$value"]);
  register("one_hit_melee_victim", 1, 0);
  register("flashed", 1, 0);
  register("stunned", 1, 0);
  register("stick_kill", 1, 0);
  register("unresolved_collisions", 1, 0);
  register("third_person_toggle", 1, 0);
  register("wounded_movement", 1, 0, "$self", &set_wounded_movement, "$value");
  register("disallow_knockdown", 0, 1, "$self", &set_disallow_knockdown, "$value");
  register("disallow_stun", 0, 1, "$self", &set_disallow_stun, "$value");
  register("postpone_stun", 0, 1, "$self", &set_postpone_stun, "$value");
  register("postpone_vortex_pull", 0, 1, "$self", &set_postpone_vortex_pull, "$value");
  register("disallow_slow", 0, 1, "$self", &set_disallow_slow, "$value");
  register("ignore_ai_collision", 0, 1, "$self", &set_ignore_ai_collision, "$value");
  register("ammomod_immune", 0, 1, "$self", &set_ammomod_immune, "$value");
  register("allow_dismember", 1, 0, "$self", &function_8c020e6b3e6f4762, "$value");
  register("allow_secondary_attack_damage", 1, 0, "$self", &function_d7aa041f31d7e32f, "$value");
  register("ignore_cleanup", 0, 0, "$self", &function_ef6599a498d90267, "$value");
  register("cleanup_dist_override", undefined, undefined, "$self", &function_ed3094fbf0019db1, "$value");
  register("round_spawning_ignore_player", 0, 0, "$self", &function_19b7ea3ee49651d7, "$value");
  register("cinematics_participant", 0, 1, "$self", &set_participating_cinematics, "$value");
  register("overlord_speaker", "", "", "$self", &set_overlord_speaker, "$value");
  register("ai_corpse_sync", 0, 1, "$self", &function_2e0d6f33b91fc4f0, "$value");
  register("show_stealth_indicator", 1, 1, "$self", &function_79903c045c3972d, "$value");
  register("show_ui_objectives", 0, 1, "$self", &set_show_ui_objectives, "$value");
  register("show_ui_out_of_bounds", 0, 1, "$self", &function_25f833b05462dfd6, "$value");
  register("cast_shadow", 1, 0, "$self", &function_61ad072a9fc2be42, "$value");
  register("allow_grab", 1, 0);
  register("allow_brot", 1, 1);
  register("allow_melee_me", 1, 1, "$self", &set_allow_melee_me, "$value");
  register("look_behavior", "", "", "$self", &set_look_behavior, "$value");
  register("allow_compass_messaging", 1, 0, "$self", &function_a887952f6b595ba4, ["allow_compass_messaging", "$value"]);
  register("ai_lightweight", 0, 1, "$self", &set_ai_lightweight, "$value");
  register("lerp_fov_scale", [1, 0.25], [0, 0.25], "$self", &set_lerp_fov_scale, "$value");
  register("allow_scripted_bgb_use", 1, 0, "$self", &set_allow_scripted_bgb_use, "$value");
  register("allow_revive_teammate", 1, 0);
  register("damage_knockback", 1, 1);
  group_register("allow_hud_in_cinematic_sequence", ["show_hud", "show_hud_names", "cg_drawcrosshair"]);
  register("allow_emote", 1, 0);
  register("bypass_saving_throws", 0, 0);

  foreach(val in ["allow_equipment_wheel", "allow_spy_cam", "allow_interactive_map", "allow_lockpick", "allow_keypad_puzzle", "allow_frequency_puzzle", "allow_cipher_puzzle", "allow_skill_select", "allow_reward_select", "allow_connection_puzzle"]) {
    register(val, 1, 0, "$self", &function_a887952f6b595ba4, [val, "$value"]);
  }

  register("ks_dont_forget", 0, 0, "$self", &set_ks_dont_forget, "$value");
  register("ai_eventlist", "", "", undefined, &set_ai_eventlist, "$value");
  register("stealth_ttlt_lkp", 8000, 8000, "$self", &function_13a57d8fbb96819b, "$value");
  register("stealth_ttlt_not_lkp", 3000, 3000, "$self", &function_458fa5173d52d835, "$value");
  register("default_time_to_drop_threat_sight", 10000, 10000, "$self", &function_73bc50501f1e58b1, "$value");
  register("global_esc_total_combat_time", -1, -1, "$self", &function_19800d31ca9a012e, "$value");
  register("global_esc_percent_threshold", 0.8, 0.8, "$self", &function_e3ffb01ce831f16a, "$value");
  register("vehicle_disallow_lockon", 0, 1, "$self", &set_vehicle_disallow_lockon, "$value");
  register("disallow_toggle_third_person", 0, 1, "$self", &function_1f0012a3819729d3, "$value");
  register("ignore_triggers", 0, 1, "$self", &set_ignore_triggers, "$value");
  register("hide_stowed_weapon", 0, 1, "$self", &set_hide_stowed_weapon, "$value");
  register("allow_battlechatter_vo", 1, 1, "$self", &set_allow_battlechatter_vo, "$value");
  register("fire_time_scale", -1, 100, "$self", &function_2d21d242ff0f9794, "$value");
  namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb(#"hash_228e40841793f3bb", &function_9f44c474895e8804);

  level thread debug_values();
  validate("<dev string:x24>", "<dev string:x2e>", &function_7f502e3446daf922);
  validate("<dev string:x37>", "<dev string:x2e>", &function_f38faee63109c0a7);
  validate("<dev string:x40>", "<dev string:x2e>", &function_bba57c2f7dfb0704);
}

function register(str_name, default_value, default_set_value, call_on, func, args) {
  assert(isstring(str_name));

  if(!isDefined(level.values_ref)) {
    level.values_ref = [];
  }

  if(isDefined(level.values_ref[str_name])) {
    assertmsg("<dev string:x50>" + str_name + "<dev string:x5b>");
    return;
  }

  if(isDefined(args)) {
    if(!isarray(args)) {
      args = [args];
    }

    if(args.size == 1 && args[0] == "$value") {
      args = undefined;
    }
  }

  level.values_ref[str_name] = {
    #var_f329cf6970ab34d0: [], #a_args: args, #default_set_value: default_set_value, #default_value: default_value, #func: func, #call_on: call_on == "$self" ? undefined : call_on, #str_name: str_name
  };
}

function unregister(str_name) {
  if(isDefined(level.values_ref)) {
    level.values_ref[str_name] = undefined;
  }
}

function group_register(group_name, value_names) {
  if(!isDefined(level.value_groups)) {
    level.value_groups = [];
  }

  level.value_groups[group_name] = value_names;
}

function group_set(group_name, value) {
  assert(isDefined(level.value_groups[group_name]), "<dev string:x74>" + group_name + "<dev string:xa4>");
  str_id = "_group_" + group_name;
  set_array(str_id, level.value_groups[group_name], value);
}

function group_reset(group_name) {
  str_id = "_group_" + group_name;
  reset_all(str_id);
}

function default_func(str_name, call_on, value, args) {
  if(isDefined(level.values_ref[str_name])) {
    if(isDefined(args) && !isarray(args)) {
      args = [args];
    }

    if(!isDefined(args)) {
      args = [];
    }

    s_value = level.values_ref[str_name];
    s_value.default_call_on = call_on;
    s_value.default_value = value;
    s_value.default_args = args;
  }
}

function link(str_name, var_6e3c291fc53ccd34, func, type = 0) {
  if(isDefined(level.values_ref[str_name])) {
    s_value = level.values_ref[str_name];
    s_value.links[var_6e3c291fc53ccd34] = {
      #type: type, #func: func ?? &simple_link, #name: var_6e3c291fc53ccd34
    };
  }
}

function private simple_link(b_value) {
  return b_value;
}

function function_402f339f6d4125e5(str_name, handler) {
  if(isDefined(level.values_ref[str_name])) {
    level.values_ref[str_name].var_f329cf6970ab34d0[level.values_ref[str_name].var_f329cf6970ab34d0.size] = handler;
  }
}

function function_ec802d0a95cd1144(str_name, handler) {
  if(isDefined(level.values_ref[str_name])) {
    level.values_ref[str_name].var_f329cf6970ab34d0 = arrayremove(level.values_ref[str_name].var_f329cf6970ab34d0, handler);
  }
}

function set(str_id, str_name, value) {
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(level.values_ref[str_name])) {
    if(!isDefined(value)) {
      value = level.values_ref[str_name].default_set_value;
    }

    push_value(str_id, str_name, value);
    set_value(str_name, value);
    links = level.values_ref[str_name].links;

    if(isarray(links)) {
      foreach(s_link in links) {
        switch (s_link.type) {
          case 0:
            set(str_id, s_link.name, [[s_link.func]](value));
            break;
          case 1:
            set(str_id, s_link.name, [[s_link.func]](get(s_link.name)));
            break;
        }
      }
    }
  }
}

function set_array(str_id, str_name_array, value) {
  foreach(str_name in str_name_array) {
    set(str_id, str_name, value);
  }
}

function reset_array(str_id, str_name_array) {
  foreach(str_name in str_name_array) {
    reset(str_id, str_name);
  }
}

function function_47773ece45ebba10(str_name, var_dfccd81e6793f145) {
  if(isDefined(level.values_ref[str_name])) {
    if(isDefined(self.values) && isDefined(self.values[str_name])) {
      if(self.values[str_name].size) {
        saved_vals = self.values[str_name];

        foreach(str_id, val in self.values[str_name]) {
          foreach(ignore_id in var_dfccd81e6793f145) {
            if(str_id == ignore_id) {
              saved_vals[str_id] = undefined;
            }
          }
        }

        if(saved_vals.size) {
          return saved_vals[getlastarraykey(saved_vals)];
        }
      }
    }

    return get_default(str_name);
  }
}

function function_fa30759d39b632a9(str_name, str_id) {
  if(isDefined(level.values_ref[str_name])) {
    valuestates = self.values[str_name];

    if(isDefined(valuestates) && valuestates.size) {
      return valuestates[str_id];
    }
  }
}

function get(str_name) {
  if(isDefined(level.values_ref[str_name])) {
    valuestates = self.values[str_name];

    if(isDefined(valuestates) && valuestates.size) {
      return valuestates[getlastarraykey(valuestates)];
    }

    return get_default(str_name);
  }
}

function set_radiant(str_name, value) {
  set("radiant", str_name, value);
}

function set_for_time(n_time, str_id, str_name, value) {
  self endon("death");
  set(str_id, str_name, value);
  wait n_time;
  reset(str_id, str_name);
}

function reset(str_id, str_name) {
  remove_value(str_id, str_name);
  reset_internal(str_id, str_name);
}

function private reset_internal(str_id, str_name) {
  valuestates = self.values[str_name];
  lastkey = undefined;

  if(isDefined(valuestates)) {
    lastkey = getlastarraykey(valuestates);

    if(isDefined(lastkey)) {
      value = valuestates[lastkey];
      set_value(str_name, value);
    }
  }

  if(!isDefined(lastkey)) {
    set_default(str_name);
  }

  if(isarray(level.values_ref[str_name].links)) {
    foreach(s_link in level.values_ref[str_name].links) {
      reset(str_id, s_link.name);
    }
  }
}

function reset_all(str_id) {
  if(!(isDefined(self) && isDefined(self.values))) {
    return;
  }

  foreach(str_name, valuestates in self.values) {
    lastkey = getlastarraykey(valuestates);

    if(isDefined(self.values[str_name])) {
      self.values[str_name][str_id] = undefined;
    }

    if(lastkey === str_id) {
      reset_internal(str_id, str_name);
    }
  }
}

function reset_radiant(str_name) {
  reset("radiant", str_name);
}

function nuke(str_name) {
  if(isDefined(self.values)) {
    self.values[str_name] = undefined;
  }

  set_default(str_name);
}

function nuke_all() {
  if(!isDefined(self.values)) {
    return;
  }

  str_name_list = [];

  foreach(str_name, value in self.values) {
    str_name_list[str_name_list.size] = str_name;
  }

  foreach(str_name in str_name_list) {
    nuke(str_name);
  }
}

function log_value(str_name) {
  self_log = isent(self) ? "Entity " + self getentitynumber() : "self";

  if(!isDefined(self.values)) {
    logstring("[LOG_VALUE] " + self_log + " does not contain any values");
    return;
  }

  if(!isDefined(str_name)) {
    logstring("[LOG_VALUE] " + self_log + " contains the following values:");

    foreach(name, value_array in self.values) {
      if(value_array.size > 0) {
        log_value(name);
      }
    }

    return;
  }

  logstring("[LOG_VALUE] Logging IDs and Value for type:" + str_name);

  foreach(key, value in self.values[str_name]) {
    if(isDefined(key) && isDefined(value)) {
      logstring("[LOG_VALUE] ID: " + key + " -- Value: " + value);
    }
  }
}

function private push_value(str_id, str_name, value) {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.values)) {
    self.values = [];
  }

  if(!isDefined(self.values[str_name])) {
    self.values[str_name] = [];
  }

  self.values[str_name][str_id] = value;
}

function private remove_value(str_id, str_name) {
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.values[str_name])) {
    self.values[str_name][str_id] = undefined;

    if(!self.values[str_name].size) {
      self.values[str_name] = undefined;

      if(!self.values.size) {
        self.values = undefined;
      }
    }
  }
}

function private set_value(str_name, value) {
  if(isPlayer(self)) {
    self endon("disconnect");
  }

  s_value = level.values_ref[str_name];

  if(isDefined(s_value.func)) {
    call_on = s_value.call_on ?? self;

    if(isDefined(s_value.a_args)) {
      utility::single_func_argarray(call_on, s_value.func, replace_values(s_value.a_args, value));
    } else {
      call_on[[s_value.func]](value);
    }
  }

  foreach(handler in level.values_ref[str_name].var_f329cf6970ab34d0) {
    [[handler]](value);
  }
}

function private get_default(str_name) {
  default_value = undefined;
  s_value = level.values_ref[str_name];

  if(isDefined(s_value.default_value)) {
    if(isfunction(s_value.default_value)) {
      call_on = s_value.default_call_on == "$self" ? self : s_value.default_call_on;
      default_value = utility::single_func_argarray(call_on, s_value.default_value, replace_values(s_value.default_args));
    } else {
      default_value = s_value.default_value;
    }
  }

  return default_value;
}

function private set_default(str_name) {
  default_value = get_default(str_name);

  if(isDefined(default_value)) {
    set_value(str_name, default_value);
  }
}

function private function_de40350986e56615(array, str_value, replacement) {
  array = arraycopy(array);

  foreach(i, val in array) {
    if(isstring(val) && val == str_value) {
      array[i] = replacement;
    }
  }

  return array;
}

function private replace_values(a_args, value) {
  if(isDefined(a_args)) {
    a_args = function_de40350986e56615(a_args, "$self", self);
    a_args = function_de40350986e56615(a_args, "$value", value);
  }

  return a_args;
}

function private function_9f44c474895e8804(params) {
  str_name = params[0];

  foreach(player in level.players) {
    player log_value(str_name);
  }

  ai_array = getaiarray();

  foreach(ai in ai_array) {
    logstring("[LOG_VALUE] Logging AI (" + ai getentitynumber() + ") of aitype: " + ai.agent_type);
    ai log_value(str_name);
  }
}

function private function_980d507a19a6bda4(b_value = 0) {
  if(isPlayer(self)) {
    if(utility::issp()) {
      if(b_value) {
        self disableinvulnerability();
      } else {
        self enableinvulnerability();
      }
    } else if(level.var_c998633bab11f3f8) {
      self.takedamage = b_value;
    } else {
      iprintln("<dev string:xa9>");
    }

    return;
  }

  self setCanDamage(b_value);
}

function private function_d570a4005ac0b537(b_value = 0) {
  if(b_value) {
    self.var_dbe8744e6b0a0409 = undefined;
    return;
  }

  self.var_dbe8744e6b0a0409 = 1;
}

function private function_7f502e3446daf922() {
  if(isPlayer(self)) {
    return !self isinvulnerable();
  }

  return self getcandamage();
}

function function_fe5fe7cd67808fa1(b_value = 0) {
  if(isDefined(self.deathshieldfunc)) {
    self[[self.deathshieldfunc]](!b_value);
  }

  if(isagent(self)) {
    self.var_62591663e6a187ce = b_value;
  }

  self.allowdeath = b_value;
}

function private function_f38faee63109c0a7() {
  return self.allowdeath;
}

function private function_51af51b23ad15aae(b_value = 1) {
  self.damageshield = b_value;
}

function private function_bba57c2f7dfb0704() {
  return self.damageshield;
}

function private function_c24a1bd2d82db73d(b_value = undefined) {
  self.deathshieldthreshold = isnumber(b_value) && b_value >= 0 ? b_value : undefined;
}

function private function_5ebabb94fa03eaa7() {
  return self islookcontrolsfrozen();
}

function function_eb87a62cdf0480f5(b_value = 0) {
  self.ignoresuppression = b_value;
}

function private set_takeweapons_thread(b_value) {
  self notify("set_takeweapons_thread");
  self endon("set_takeweapons_thread");
  self endon("death_or_disconnect");
  wait level.framedurationseconds * 3;

  if(b_value) {
    if(!isDefined(self.val_takeweapons)) {
      self.val_takeweapons = {
        #current: self getcurrentweapon(), #weapons: self getweaponslistall()
      };
    }

    self takeallweapons();
    return;
  }

  if(isDefined(self.val_takeweapons)) {
    weaponselect = self.val_takeweapons.current;
    fallbackprimary = undefined;

    foreach(weapon in self.val_takeweapons.weapons) {
      self giveweapon(weapon);

      if(!isDefined(fallbackprimary) && weapon.type == "bullet") {
        fallbackprimary = weapon;
      }
    }

    if(isDefined(fallbackprimary) && weaponselect.basename == "none") {
      weaponselect = fallbackprimary;
    }

    self switchtoweaponimmediate(weaponselect);
    self.val_takeweapons = undefined;
  }
}

function private set_takeweapons(b_value = 1) {
  if(isPlayer(self)) {
    thread set_takeweapons_thread(b_value);
    return;
  }

  if(b_value) {
    ai::gun_remove();

    if(isDefined(anim.var_5458eb88a5c60307)) {
      self[[anim.var_5458eb88a5c60307]]();
    }

    return;
  }

  ai::gun_recall();

  if(isDefined(anim.var_a539877b0796cf31)) {
    self[[anim.var_a539877b0796cf31]]();
  }
}

function private function_20dc6a278a598f22(value = 0) {
  if(value != 1) {
    self disableweapons(isnumber(value) && value == -1 ? 1 : 0);

    if(isDefined(level.allow_weapon_mp)) {
      self[[level.allow_weapon_mp]](0);
    }

    return;
  }

  self enableweapons();

  if(isDefined(level.allow_weapon_mp)) {
    self[[level.allow_weapon_mp]](1);
  }
}

function private function_fad3d2efb21d3796(b_value = 0) {
  if(b_value) {
    self enableweaponswitch();
    return;
  }

  self disableweaponswitch();
}

function private function_69663cfde5a760c0(b_value = 0) {
  if(b_value) {
    self disableemptyclipweaponswitch(0);
    return;
  }

  self disableemptyclipweaponswitch(1);
}

function private function_14a1b35a268ca4b9(b_value = 0) {
  if(b_value) {
    self allowfire(1);
    return;
  }

  self allowfire(0);
}

function private function_d7a1169db9553b28(b_value = 0) {
  assert(isPlayer(self));
  assert(utility::issp());
  setsaveddvar(@ "hash_4f25696e26f5208b", !b_value);
}

function private function_774a7b576d576eac(b_value = 0) {
  if(b_value != 1) {
    self allowreload(0);

    if(b_value != -1) {
      self cancelreload();
      telemetrydata = {
        #reloadcanceltime: getsystemtimeinmicroseconds(), #cancelreason: "ENTER_VEHICLE", #player: self
      };
      telemetry_utils::function_af2d366f9522f76f("callback_on_reload_cancel", telemetrydata);
    }

    return;
  }

  self allowreload(1);
}

function function_a72eede1b3cfd014(value = 1) {
  assert(isPlayer(self));
  assert(utility::issp());
  scale = 1;
  valuestates = self.values["reload_speed"];

  if(isDefined(valuestates) && valuestates.size) {
    foreach(value in valuestates) {
      scale *= float(value);
    }
  }

  setsaveddvar(@ "perk_weapreloadmultiplier", scale);

  if(scale != 1) {
    self setperk("specialty_fastreload", 1);
    return;
  }

  self unsetperk("specialty_fastreload", 1);
}

function private function_e208c91eb84ed565(b_value = 0) {
  if(b_value) {
    self enableweaponpickup();
    return;
  }

  self disableweaponpickup();
}

function private function_1fd9d609b5af3807(b_value = 0) {
  if(b_value) {
    self enableautoreload();
    return;
  }

  self disableautoreload();
}

function private function_a1162f2424489dd0(b_value = 0) {
  if(b_value) {
    self enableoffhandweapons();
    return;
  }

  self disableoffhandweapons();
}

function private function_62d014caf91572e2(b_value = 0) {
  if(b_value) {
    self enableoffhandprimaryweapons();
    return;
  }

  self disableoffhandprimaryweapons();
}

function private function_36cea73c3b5fd96e(b_value = 0) {
  if(b_value) {
    self enableoffhandsecondaryweapons();
    return;
  }

  self disableoffhandsecondaryweapons();
}

function private function_20012a3279532ca5(b_value = 0) {
  self allowoffhandshieldweapons(b_value);
}

function private function_37a151011f0964e7(b_value = 1) {
  if(b_value) {
    self enableoffhandthrowback();
    return;
  }

  self disableoffhandthrowback();
}

function private set_allow_offhand_special(b_value) {
  assertmsg("<dev string:x120>");
}

function private set_force_enable_offhand_sprays(b_value = 0) {
  self function_9d8fefb12cdb497c(b_value);
}

function private set_allow_aim_assist(b_value = 0) {
  self setaimassistdisabled(!b_value);
}

function private function_d997fb9e4213c391(b_value = 0) {
  if(b_value) {
    self enableusability();
  } else {
    self disableusability();
  }

  self notify("usability", b_value);
}

function private disallow_loot_but_auto_loot(b_value = 1) {
  if(b_value) {
    self function_604255f312e3443e();
    return;
  }

  self function_5326242d9dc65aed();
}

function private disallow_usability_but_loot(b_value = 1) {
  if(b_value) {
    self function_b57dcb79e0b62bb5();
    return;
  }

  self function_a2dc8e29134063ac();
}

function private set_dont_evolve(b_value = 1) {
  if(b_value) {
    self.dont_evolve = 1;
    return;
  }

  self.dont_evolve = undefined;
}

function set_remote_revive(b_value = 1) {
  if(b_value) {
    self.var_73fc3c02a3004c94 = 1;
    self.usingremoterevive = 1;
    return;
  }

  self.var_73fc3c02a3004c94 = undefined;
  self.usingremoterevive = undefined;
}

function function_ac426ec234868b04(b_value = 1) {
  if(b_value) {
    self.var_885f2644ce3eb19e = 1;
    return;
  }

  self.var_885f2644ce3eb19e = undefined;
}

function function_19b569afca12ffd7(b_value = 1) {
  if(b_value) {
    self.ignoreafkcheck = b_value;
    return;
  }

  self.ignoreafkcheck = undefined;
}

function function_95066ad96cccfad0(b_value = 1) {
  self.ignoreme = b_value;
}

function function_c120622a6e09fe01(b_value = 1) {
  self.ignoreall = b_value;
}

function private function_9e8e7f16449b4fe3(b_value = 1) {
  assert(isPlayer(self));

  if(b_value) {
    self.nohitmarkers = undefined;
    return;
  }

  self.nohitmarkers = 1;
}

function private set_hide(value = 1) {
  if(!isPlayer(self) && isarray(value)) {
    self hide();

    foreach(player in value) {
      if(!isPlayer(player)) {
        continue;
      }

      self showtoplayer(player);
    }

    return;
  }

  if(value) {
    var_f097c55b7de07a4d = value == 2;

    if(isPlayer(self)) {
      self playerhide(var_f097c55b7de07a4d);
    } else if(isagent(self)) {
      self invisiblenotsolid(var_f097c55b7de07a4d);
    } else {
      self hide(var_f097c55b7de07a4d);
    }

    return;
  }

  if(isPlayer(self)) {
    self playershow();
    return;
  }

  if(isagent(self)) {
    self visiblesolid();
    return;
  }

  self show();
}

function private set_non_deletable(b_value = 1) {
  self setnondeletable(b_value);
}

function private set_health_regen(b_value = 1) {
  if(b_value) {
    self.disable_health_regen = undefined;
    return;
  }

  self.disable_health_regen = 1;
}

function private set_allow_health_regen_delay(b_value = 0) {
  if(b_value) {
    self.disable_health_regen_delay = undefined;
    return;
  }

  self.disable_health_regen_delay = 1;
}

function private set_ignore_health_regen_delay(b_value = 1) {
  if(b_value) {
    self.ignore_health_regen_delay = 1;
    return;
  }

  self.ignore_health_regen_delay = 0;
}

function private function_cc381b7879a5f0d6(val) {
  if(isDefined(val)) {
    self.goalradius = val;
    return;
  }

  if(isDefined(self.radius)) {
    self.goalradius = float(self.radius);
    return;
  }

  if(isDefined(self.spawner.radius)) {
    self.goalradius = float(self.spawner.radius);
    return;
  }

  self.goalradius = 2048;
}

function private set_skip_death(b_value = 1) {
  self.skipdeath = b_value ? 1 : 0;
}

function private set_skip_scene_death(b_value = 1) {
  self.skipscenedeath = b_value ? 1 : undefined;
}

function private set_breath_system(b_allow) {
  self enableplayerbreathsystem(b_allow);
}

function private function_ef500d3d9308db93(b_freeze) {
  self freezecontrols(b_freeze);
}

function private function_d9233b319f90661(b_freeze) {
  self freezelookcontrols(b_freeze);
}

function private function_2005a18622e4bc7c(b_value = 1) {
  if(!utility::ent_flag_exist("stealth_social_reveal")) {
    utility::ent_flag_init("stealth_social_reveal");
  }

  if(b_value) {
    utility::ent_flag_set("stealth_social_reveal");
    return;
  }

  utility::ent_flag_clear("stealth_social_reveal");
}

function private function_fb7abaa719858b69(b_value) {
  if(b_value) {
    b_value = 0;
  } else {
    b_value = 1;
  }

  self setclientomnvar("ui_hide_hud", b_value);
}

function private function_ebf3d4d401322e8(b_value) {
  if(b_value) {
    b_value = 0;
  } else {
    b_value = 1;
  }

  self setclientomnvar("ui_hide_weapon_info", b_value);
}

function private function_c5e5bd6fb67422ed(b_value) {
  if(b_value) {
    b_value = 0;
  } else {
    b_value = 1;
  }

  self setclientomnvar("ui_hide_dpad_hud", b_value);
}

function private function_3bebe3c7d4a7d93d(b_value = 1) {
  self.var_c0f4dea5ee8c15f0 = b_value;
}

function private allow_melee_victim(b_value = 1) {
  self.canbemeleed = b_value ? 1 : 0;
}

function private set_allowjump(b_value = 1) {
  self allowjump(b_value);
}

function private set_allowdoublejump(b_value = 1) {
  self allowdoublejump(b_value);
}

function private set_allowcrouch(b_value = 1) {
  self allowcrouch(b_value);
}

function private set_allowprone(b_value = 1) {
  self.var_b64b12f21408f6b3 = b_value;
  self allowprone(b_value);
}

function private function_1ae65704940e4424(b_value = 1) {
  if(b_value) {
    self allowstand(1);
    self allowcrouch(1);
    self allowprone(1);
    return;
  }

  current = self getstance();

  foreach(stance in arrayremove(["stand", "crouch", "prone"], current)) {
    switch (stance) {
      case #"hash_c6775c88e38f7803":
        self allowstand(0);
        break;
      case #"hash_3fed0cbd303639eb":
        self allowcrouch(0);
        break;
      case #"hash_d91940431ed7c605":
        self allowprone(0);
        break;
    }
  }
}

function private set_allowmelee(b_value = 1) {
  self allowmelee(b_value);
}

function private set_allowlean(b_value = 0) {
  self allowlean(b_value);
}

function private set_allowmantle(b_value = 1) {
  self allowmantle(b_value);
}

function private function_5e9e3b2f69f6f529(b_value = 1) {
  self allowledgehang(b_value);
}

function private set_allowmounttop(b_value = 0) {
  self allowmounttop(b_value);
}

function private set_allowmountside(b_value = 0) {
  self allowmountside(b_value);
}

function private set_allowsprint(b_value = 1) {
  self allowsprint(b_value);
}

function private set_allowjog(b_value = 1) {
  self allowjog(b_value);
}

function private set_allowstand(b_value = 1) {
  self allowstand(b_value);
}

function private set_allowmovement(b_value = 1) {
  self allowmovement(b_value);
}

function private set_allowladder(b_value = 1) {
  self allowladder(b_value);
}

function private function_df742befdf77ed04(b_value = 1) {
  self allowwalljump(b_value);
}

function private function_21ceb22acb454b71(b_value = 1) {
  self function_a6d285c122d6432a(b_value);
}

function private function_38e816a25d06e176(b_value = 0) {
  if(b_value) {
    if(!self hasperk("specialty_freefire")) {
      self setperk("specialty_freefire", 1);
    }

    return;
  }

  if(self hasperk("specialty_freefire")) {
    self unsetperk("specialty_freefire", 1);
  }
}

function private function_a8117c7579bc7929(b_value = 1) {
  self allowswimming(b_value);
}

function private function_7ab726a64720c8a4(b_value = 1) {
  self allowswimmingunderwater(b_value);
}

function private function_48acf32c9c54465c(b_value = 1) {
  self function_5e3d4215e59b4473(b_value);
}

function private function_115021318817a3e4(b_value = 1) {
  self function_6af484c18f98020b(b_value);
}

function private function_a4ce58974995b16f(b_value = 1) {
  self skydive_setbasejumpingstatus(b_value);
}

function private function_1c864094a7f7b03c(b_value = 1) {
  self allowdive(b_value);
}

function private set_movespeedscale(val = 1) {
  if(isai(self)) {
    asm::asm_setmoveplaybackrate(val);
    return;
  }

  if(isPlayer(self)) {
    self setmovespeedscale(val);
  }
}

function private set_movespeedscalemult(val) {
  scale = get("move_speed_scale");
  valuestates = self.values["move_speed_scale_mult"];

  if(isDefined(valuestates) && valuestates.size) {
    foreach(value in valuestates) {
      scale *= float(value);
    }
  }

  set_movespeedscale(scale);
}

function private set_desiredspeed(val = 0) {
  if(!isai(self)) {
    assertmsg("<dev string:x14d>");
    return;
  }

  if(val > 0) {
    self aisetdesiredspeed(val);
    return;
  }

  self aiclearscriptdesiredspeed(val);
}

function private set_pushplayer(b_value = 1) {
  self pushplayer(b_value);
}

function private function_877815b778be0789(b_value = 0) {
  if(b_value) {
    self enableoffhandspecialweapons();
    return;
  }

  self disableoffhandspecialweapons();
}

function private function_f9218624505e928d(b_value = 0) {
  self function_4d8e8ea22028572(!b_value);
}

function private function_68e3a3ac765536e7(b_value = 1) {
  if(b_value) {
    utility::ent_flag_set("super_switching");
  } else {
    utility::ent_flag_clear("super_switching");
  }

  self setclientomnvar("ui_super_switching_allowed", b_value);
}

function private set_hide_operator_backpack(b_value = 0) {
  if(b_value) {
    if(self tagexists("TAG_STOWED_BACKPACK_HIDE")) {
      if(self.operatorcustomization.body != "body_mp_gus_iw9_1_1") {
        self hidepart("TAG_STOWED_BACKPACK_HIDE");
      }
    }

    return;
  }

  if(self tagexists("TAG_STOWED_BACKPACK_HIDE")) {
    self showpart("TAG_STOWED_BACKPACK_HIDE");
  }
}

function private set_show_operator_pet(b_value = 0) {
  self function_768e7142f48e0374(!b_value, self);
}

function private function_19abbc82717ff6e(b_value = 0) {
  self allowwallrun(b_value);
}

function private function_11ec4cf4a1f78d50(b_value = 0) {
  if(b_value) {
    self energy_setenergy(0, self.doublejumpenergy);
    self energy_setrestorerate(0, self.doublejumpenergyrestorerate);
    self.doublejumpenergy = undefined;
    self.doublejumpenergyrestorerate = undefined;
    self allowdoublejump(1);
    return;
  }

  self.doublejumpenergy = self energy_getenergy(0);
  self.doublejumpenergyrestorerate = self energy_getrestorerate(0);
  self energy_setenergy(0, 0);
  self energy_setrestorerate(0, 0);
  self allowdoublejump(0);
}

function private function_394d0e1971506f5a(b_value = 0) {
  self allowslide(b_value);
}

function private function_29d0c9f9c06a0716(b_value = 0) {
  if(b_value) {
    self[[level.enableexecutionattackfunc]]();
    return;
  }

  self[[level.disableexecutionattackfunc]]();
}

function private function_d8c73090e01eec0a(b_value = 0) {
  if(!isDefined(level.enableexecutionvictimfunc)) {
    return;
  }

  if(b_value) {
    self[[level.enableexecutionvictimfunc]]();
    return;
  }

  self[[level.disableexecutionvictimfunc]]();
}

function private function_c024a5143db30f53(b_value = 0) {
  if(!isDefined(level.var_b25384e76c9c75c8)) {
    return;
  }

  if(b_value) {
    self builtin[[level.var_b25384e76c9c75c8]]();
    return;
  }

  self builtin[[level.var_a12d26bb8ce6fde1]]();
}

function private function_457b17f56ea93057(b_value = 0) {
  vehicle_allowplayeruse(self, b_value);
}

function private function_2eaa66d57872ea23(b_value = 0) {
  self function_b100a7701a3ca96f(b_value);
}

function private function_8897b3febd975b3e(b_value = 0) {
  self.var_9b6d5e24d8eed7c4 = b_value ? undefined : 1;
}

function private function_5724d3c9e7701db1(b_value = 0) {
  self allowvehiclepredictiveragdoll(b_value);
}

function private function_bb0d10ecbfbeaeb9(b_value = 0) {
  nvgslot = 2;

  if(b_value) {
    if(!isai(self)) {
      self setactionslot(nvgslot, "nightvision");
    }

    return;
  }

  if(!isai(self)) {
    self setactionslot(nvgslot, "");
  }
}

function private function_797fbc5fdce1604(b_value = 0) {
  self allowsupersprint(b_value);
}

function private function_288bef4a53a454c1(b_value = 0) {
  if(b_value) {
    if(isDefined(level.enableshellshockfunc)) {
      self[[level.enableshellshockfunc]]();
    }

    return;
  }

  if(isDefined(level.disableshellshockfunc)) {
    self[[level.disableshellshockfunc]]();
  }
}

function private function_afc959ebf3565f45(b_value = 0) {
  if(isinfrontend()) {
    return;
  }

  if(b_value) {
    if(self.var_bc911f2808c4ce06) {
      self.var_bc911f2808c4ce06 = undefined;

      if(isDefined(self.cinematicmotionoverride)) {
        self setcinematicmotionoverride(self.cinematicmotionoverride);
      } else {
        self clearcinematicmotionoverride();
      }
    }

    return;
  }

  self setcinematicmotionoverride("disabled");
  self.var_bc911f2808c4ce06 = 1;
}

function private function_ab098c39abd0a60(b_value = 0) {
  if(isDefined(self.armor.toggleuifunc)) {
    self[[self.armor.toggleuifunc]](b_value);
  }

  if(isbot(self) && isDefined(self._blackboard)) {
    self._blackboard.var_50edfe96f927ca5 = b_value;
  }
}

function private function_82e13e9ae938b8e9(ref) {
  if(isDefined(ref) && !isDefined(level.equipment.table[ref])) {
    assertmsg("<dev string:x182>" + ref + "<dev string:x1d8>");
  }

  return level.equipment.table[ref];
}

function private function_e67eeb83d8502ab2(slot) {
  if(!isDefined(self.equipment)) {
    return undefined;
  }

  return self.equipment[slot];
}

function private disableslotinternal(slot) {
  if(slot == "primary") {
    self clearoffhandprimary();
    return;
  }

  if(slot == "secondary") {
    self clearoffhandsecondary();
    return;
  }

  if(slot == "super") {
    self clearoffhandspecial();
  }
}

function private enableslotinternal(slot) {
  ref = function_e67eeb83d8502ab2(slot);
  equipmentlist = self getweaponslistoffhands();
  weapon = undefined;

  if(!isDefined(ref)) {
    return;
  }

  found = 0;

  foreach(equip in equipmentlist) {
    equipref = undefined;

    foreach(tableinfo in level.equipment.table) {
      if(tableinfo.objweapon.basename == equip.basename) {
        equipref = tableinfo.ref;
        break;
      }
    }

    if(equipref == ref) {
      if(!isDefined(equip.basename)) {
        return;
      }

      found = 1;
      attachments = equip.attachments ?? [];
      variantid = equip.variantid;

      if(variantid > 0) {
        weapon = makeweapon(equip.basename, attachments, undefined, undefined, variantid);
        svariantid = equip.basename + "|" + variantid;
        variantattachments = level.equipmentblueprints[svariantid] ?? [];

        foreach(attachment, variant in variantattachments) {
          weapon = weapon withattachment(attachment, variant);
        }
      } else if(attachments.size > 0) {
        defaultattachments = getweapondefaultattachments(equip.basename);
        weapon = makeweapon(equip.basename, defaultattachments);
        weapon = weapon withattachments(attachments);
      } else {
        tableinfo = function_82e13e9ae938b8e9(ref);
        weapon = tableinfo.objweapon;
      }

      break;
    }
  }

  tableinfo = function_82e13e9ae938b8e9(ref);

  if(!found) {
    weapon = tableinfo.objweapon;
  }

  if(isDefined(weapon) && self hasweapon(weapon)) {
    if(isDefined(weapon) && !tableinfo.ispassive) {
      if(slot == "primary") {
        self assignweaponoffhandprimary(weapon);
        return;
      }

      if(slot == "secondary") {
        self assignweaponoffhandsecondary(weapon);
        return;
      }

      if(slot == "super") {
        self assignweaponoffhandspecial(weapon);
      }
    }
  }
}

function private function_2e13ccfdf6cd4702(b_value = 0) {
  if(utility::issp()) {
    function_62d014caf91572e2(b_value);
    return;
  }

  if(b_value) {
    enableslotinternal("primary");
    return;
  }

  disableslotinternal("primary");
}

function private function_b2dbe5926fba028e(b_value = 0) {
  if(utility::issp()) {
    function_36cea73c3b5fd96e(b_value);
    return;
  }

  if(b_value) {
    enableslotinternal("secondary");
    return;
  }

  disableslotinternal("secondary");
}

function private function_f61e0e9b7270852f(b_value = 0) {
  setsaveddvar(@ "bg_disableweaponfirstraiseanims", !b_value);
}

function private function_ae04fcfb3e401f12(b_value = 0) {
  if(b_value) {
    self function_7d73d6786e51ae1f();
    return;
  }

  self function_60e112d2e106b00a();
}

function private set_door_frozen(b_value = 1) {
  self scriptabledoorfreeze(b_value);
}

function private function_36d470fc6707078c(b_value = 0) {
  if(b_value) {
    self.interactions_disabled = undefined;
    return;
  }

  self.interactions_disabled = 1;
}

function private function_795d7b6d27c07c84(b_value) {}

function private function_bfe2fb4299424726(b_value) {}

function private function_962996b296b33a29(b_value = 0) {
  if(b_value) {
    utility::flag_clear("weapon_scanning_off");
    return;
  }

  utility::flag_set("weapon_scanning_off");
}

function private function_48bbce421e2098f9(b_value = 0) {
  if(b_value && isDefined(self.actionslotweapon)) {
    self setactionslot(1, "weapon", self.actionslotweapon);
    return;
  }

  self setactionslot(1, "");
}

function private set_disallow_body_carry(b_value = 0) {
  if(b_value) {
    utility::ent_flag_set("disallow_body_carry");
    return;
  }

  utility::ent_flag_clear("disallow_body_carry");
}

function private set_disallow_body_shield(b_value = 0) {
  if(b_value) {
    utility::ent_flag_set("disallow_body_shield");
    return;
  }

  utility::ent_flag_clear("disallow_body_shield");
}

function private set_demeanor(str_value) {
  if(isai(self)) {
    if(!isDefined(str_value) || str_value == "") {
      utility::clear_demeanor_override();
    } else {
      utility::demeanor_override(str_value);
    }

    return;
  }

  if(isPlayer(self) && isDefined(level.var_d904ea5b8076658c) && str_value != "") {
    self[[level.var_d904ea5b8076658c]](str_value);
  }
}

function private function_69c3c2915908991(b_value) {
  if(isai(self)) {
    self.allowpain = b_value;
  }
}

function private function_fd5ee72fff1d88d1(b_value) {
  if(isai(self)) {
    self.allowspecialpain = b_value;
  }
}

function private set_infinite_ammo(b_value = 1) {
  if(!isPlayer(self) && !isagent(self)) {
    assertmsg("<dev string:x1dd>");
  }

  self setinfiniteammo(b_value);
}

function private set_overlord_locked_priority(val) {
  if(isDefined(level.setoverlordlockedpriority)) {
    self[[level.setoverlordlockedpriority]](val);
  }
}

function private set_kill_on_damage(b_value) {
  if(isai(self)) {
    self.killondamage = istrue(b_value);
  }
}

function private set_reduce_damage_effects(b_value) {
  if(!isPlayer(self) || isbot(self) || issimulationplayer(self)) {
    return;
  }

  self.reduceddamageeffects = b_value;
}

function private set_collide_with_ai_allies(b_value) {
  if(isai(self)) {
    self.collide_with_ai_allies = istrue(b_value);
  }
}

function private function_a7120a590add6c5a(b_value) {
  if(isai(self)) {
    self.script_pushable_by_ai = istrue(b_value);
  }
}

function private function_1afc684096493969(b_value) {
  if(isai(self)) {
    self.script_pushable = istrue(b_value);
  }
}

function private set_allow_give_super_point(b_value) {
  if(isPlayer(self) || isai(self)) {
    if(b_value) {
      self.var_2364be08b6facb67 = 0;
      return;
    }

    self.var_2364be08b6facb67 = 1;
  }
}

function private set_allow_give_point(b_value = 1) {
  if(isPlayer(self) || isai(self)) {
    self.var_97027ab26a161eef = !b_value;
  }
}

function private set_pause_zombie_spawning(b_value) {
  self.b_value_pause_zombie_spawning = istrue(b_value);
}

function function_b8033e083072d1d6(str_id, value) {
  if(value) {
    set(str_id, "fire", !value);
    set(str_id, "offhand_weapons", !value);
    set(str_id, "allow_movement", !value);
    set(str_id, "allow_jump", !value);
    set(str_id, "melee", !value);
    set(str_id, "sprint", !value);
    set(str_id, "prone", !value);
    return;
  }

  reset(str_id, "fire");
  reset(str_id, "offhand_weapons");
  reset(str_id, "allow_movement");
  reset(str_id, "allow_jump");
  reset(str_id, "melee");
  reset(str_id, "sprint");
  reset(str_id, "prone");
}

function function_ea6a6a9e43fc8c3f(str_id, value) {
  if(value) {
    set(str_id, "offhand_weapons", !value);
    set(str_id, "allow_movement", !value);
    set(str_id, "allow_jump", !value);
    set(str_id, "melee", !value);
    set(str_id, "sprint", !value);
    return;
  }

  reset(str_id, "offhand_weapons");
  reset(str_id, "allow_movement");
  reset(str_id, "allow_jump");
  reset(str_id, "melee");
  reset(str_id, "sprint");
}

function private set_allowads(b_value = 1) {
  self allowads(b_value);
}

function private function_a887952f6b595ba4(s_notify, b_value) {
  self notify(s_notify, b_value);
}

function private set_disallow_knockdown(b_value) {
  if(isai(self)) {
    self.disallow_knockdown = b_value;
  }
}

function private set_disallow_stun(b_value) {
  if(isai(self)) {
    self.disallow_stun = b_value;
  }
}

function private set_postpone_stun(b_value) {
  if(isai(self)) {
    self.postpone_stun = b_value;
  }
}

function private set_postpone_vortex_pull(b_value) {
  if(isai(self)) {
    self.postpone_vortex_pull = b_value;
  }
}

function private set_disallow_slow(b_value) {
  if(isai(self)) {
    self.disallow_slow = b_value;
  }
}

function private set_ignore_ai_collision(b_value) {
  if(isai(self)) {
    self enableavoidance(!b_value);
    self.collide_with_ai = !b_value;
  }
}

function private set_ammomod_immune(b_value) {
  if(isai(self)) {
    self.var_eb92c31552620100 = b_value;
  }
}

function private function_79903c045c3972d(b_value) {
  self.show_stealth_indicators = b_value;
}

function private set_show_ui_objectives(b_value) {
  if(b_value) {
    self setclientomnvar("ui_show_objectives", 1);
    return;
  }

  self setclientomnvar("ui_show_objectives", 0);
}

function private function_25f833b05462dfd6(b_value) {
  self setclientomnvar("ui_out_of_bounds_countdown", b_value);
  self notify("show_ui_out_of_bounds", b_value > 0);
}

function private function_61ad072a9fc2be42(b_value) {
  if(b_value) {
    self castshadows();
    return;
  }

  self dontcastshadows();
}

function private set_show_healthbar(b_value = 0) {
  self.showhealthbar = b_value;
}

function private function_9f3b98d1081b9f(dist = 0) {
  self.var_10906dc66b1c7aaf = dist;
}

function private function_a36d1e1879f4a10d(b_value = 1) {
  if(b_value) {
    utility::ent_flag_set("play_ambient_vo");
    return;
  }

  utility::ent_flag_clear("play_ambient_vo");
}

function private set_allow_vo(b_value = 1) {
  if(b_value) {
    utility::ent_flag_set("allow_vo");
    return;
  }

  utility::ent_flag_clear("allow_vo");
}

function private function_54063e236477cf2a(b_turn_on = 1) {
  if(!isalive(self)) {
    return;
  }

  if(!utility::ent_flag_exist("toggle_eye_glow")) {
    utility::ent_flag_init("toggle_eye_glow");
  }

  if(b_turn_on) {
    utility::ent_flag_set("toggle_eye_glow");
  } else {
    utility::ent_flag_clear("toggle_eye_glow");
  }

  if(isDefined(self.fn_toggle_eye_glow)) {
    self[[self.fn_toggle_eye_glow]]();
  }
}

function private set_allow_unreachable_attack(b_value = 1) {
  self._blackboard.var_252b33de40638a50 = b_value;
}

function private set_trial_logic_activate(b_value = 1) {
  if(b_value) {
    utility::ent_flag_set("trial_logic_activate");
    return;
  }

  utility::ent_flag_clear("trial_logic_activate");
}

function private set_task_logic_activate(b_value = 1) {
  if(b_value) {
    utility::ent_flag_set("task_logic_activate");
    return;
  }

  utility::ent_flag_clear("task_logic_activate");
}

function private set_allow_combat_attractors(b_value = 1) {
  if(b_value) {
    self.var_840153567385cc6b = undefined;
    return;
  }

  self.var_840153567385cc6b = 1;
}

function private function_2204daa2cfda7e2c(b_value) {
  self.attackeraccuracy = b_value;
}

function private function_8c020e6b3e6f4762(b_value) {
  if(!utility::ent_flag_exist("allow_dismember")) {
    utility::ent_flag_init("allow_dismember");
  }

  if(b_value) {
    utility::ent_flag_set("allow_dismember");
    return;
  }

  utility::ent_flag_clear("allow_dismember");
}

function private function_d7aa041f31d7e32f(b_value) {
  if(b_value) {
    utility::ent_flag_set("allow_secondary_attack_damage");
    return;
  }

  utility::ent_flag_clear("allow_secondary_attack_damage");
}

function private function_ef6599a498d90267(b_value) {
  self.b_ignore_cleanup = b_value;
}

function private function_ed3094fbf0019db1(overridedist) {
  self.var_52cc30b67469d423 = squared(overridedist);
}

function private function_19b7ea3ee49651d7(b_value) {
  self.var_5cbeb35a4d5900e9 = b_value;
}

function private set_participating_cinematics(b_value) {
  b_value = istrue(b_value);
  prev = self function_e7d19d7e4403c48();
  self function_589df9c1869fcee4(b_value);

  if(prev != b_value) {
    if(b_value) {
      self notify("set_participating_cinematics_true");
      return;
    }

    self notify("set_participating_cinematics_false");
  }
}

function private set_overlord_speaker(var_85f9b34a2668217c) {
  if(!isDefined(var_85f9b34a2668217c) || var_85f9b34a2668217c == "") {
    if(isDefined(level.var_8b4ae0e9bea5384c)) {
      self[[level.var_8b4ae0e9bea5384c]]();
    }

    return;
  }

  if(isDefined(level.var_e0b31e63f5a29e85)) {
    self[[level.var_e0b31e63f5a29e85]](var_85f9b34a2668217c);
  }
}

function private function_2e0d6f33b91fc4f0(b_value) {
  setsaveddvar(@ "ai_corpsesynch", istrue(b_value));
}

function private set_vehicle_disallow_lockon(var_8dff5af844911c6) {
  if(vehicle::is_vehicle()) {
    self.disablelockon = var_8dff5af844911c6;
  }
}

function private function_1f0012a3819729d3(b_value) {
  if(isPlayer(self)) {
    self.disable_third_person_toggle = b_value;
  }
}

function set_ks_dont_forget(value = 0) {
  self.ksdontforget = value;
}

function set_ai_eventlist(eventlist) {
  if(eventlist == "") {
    function_117415769484a82c();
    return;
  }

  function_f750be7c4e3a297b(eventlist);
}

function function_13a57d8fbb96819b(val) {
  stealthsettimetolosetargetatlkp(val);
}

function function_458fa5173d52d835(val) {
  stealthsettimetolosetargetnotatlkp(val);
}

function function_73bc50501f1e58b1(val) {
  stealthsetdefaulttimetodropthreatsight(val);
}

function function_19800d31ca9a012e(val) {
  setglobalescalationtotalcombattime(val);
}

function function_e3ffb01ce831f16a(val) {
  setglobalescalationcombatpercentagethreshold(val);
}

function private set_wounded_movement(val) {
  if(isDefined(level.var_2464e8c70801e60f)) {
    self[[level.var_2464e8c70801e60f]](val);
  }
}

function private set_allow_melee_me(b_value = 0) {
  if(issentient(self)) {
    self.dontmeleeme = !b_value;
  }
}

function private set_ignore_triggers(b_value = 1) {
  self.ignoretriggers = b_value ? 1 : 0;
}

function private set_look_behavior(value = "ai_default") {
  if(isai(self)) {
    self function_10006c8216ad87fd("focus_behaviors", "look_state", value);
  }
}

function private set_ai_lightweight(b_value = 1) {
  if(!isai(self)) {
    return;
  }

  self function_97a9712d0b90aae9(b_value);
}

function private set_lerp_fov_scale(arraytargettime) {
  if(!isPlayer(self)) {
    return;
  }

  defval = [1, 0.25];

  if(!isDefined(arraytargettime)) {
    arraytargettime = defval;
  }

  if(!isarray(arraytargettime)) {
    arraytargettime = [arraytargettime];
  }

  self lerpfovscalefactor(arraytargettime[0] ?? defval[0], arraytargettime[1] ?? defval[1]);
}

function private set_allow_scripted_bgb_use(b_value = 0) {
  if(b_value) {
    self.var_eeb6ebe322e71cd1 = undefined;
    return;
  }

  self.var_eeb6ebe322e71cd1 = 1;
}

function private set_hide_stowed_weapon(b_value) {
  if(b_value) {
    self setstowedweaponvisibility(0);
    return;
  }

  self setstowedweaponvisibility(1);
}

function private set_allow_battlechatter_vo(b_value = 1) {
  if(b_value) {
    if(isPlayer(self)) {
      self.bcdisabled = undefined;
    } else {
      self.battlechatterallowed = 1;
    }

    return;
  }

  if(isPlayer(self)) {
    self.bcdisabled = 1;
    return;
  }

  self.battlechatterallowed = undefined;
}

function private function_f01949d7ffcf11f7(b_value = 1) {
  if(issentient(self)) {
    self.var_9f4e3f5817d5c92b = istrue(b_value);
  }
}

function private set_show_perks(b_value = 1) {
  if(hasomnvar("ui_visibility_perks")) {
    self setclientomnvar("ui_visibility_perks", b_value);
  }
}

function private function_bfbaa9ffafdb11b2(b_value = 1) {
  if(hasomnvar("ui_perk_decay_active")) {
    self setclientomnvar("ui_perk_decay_active", b_value);
  }
}

function private function_284901af56e908eb(b_value = 0) {
  self function_81e34c49e8541eb4(b_value);
}

function private function_2d21d242ff0f9794(val) {
  if(val < 0) {
    self setfiretimescaleoff();
    return;
  }

  self setfiretimescaleon(val);
}

function private validate(str_name, call_on, func) {
  if(!isDefined(level.values_ref[str_name])) {
    assertmsg("<dev string:x50>" + str_name + "<dev string:x21f>");
    return;
  }

  s_value = level.values_ref[str_name];
  s_value.b_validate = 1;
  s_value.func_validate = func;
  s_value.validate_call_on = call_on;
}

function private validate_value(str_name, value, b_assert) {
  if(!isDefined(b_assert)) {
    b_assert = 0;
  }

  s_value = level.values_ref[str_name];
  current_value = undefined;

  if(isDefined(s_value.func_validate)) {
    call_on = s_value.validate_call_on == "<dev string:x2e>" ? self : s_value.validate_call_on;

    if(isDefined(s_value.validate_args)) {
      current_value = utility::single_func_argarray(call_on, s_value.func_validate, replace_values(s_value.validate_args));
    } else {
      current_value = utility::single_func_argarray(call_on, s_value.func_validate, []);
    }
  } else {
    current_value = 0;
  }

  b_match = current_value == value;

  if(b_assert) {
    assert(b_match, "<dev string:x234>" + str_name + "<dev string:x24a>" + current_value + "<dev string:x254>" + value + "<dev string:x269>");
  }

  return b_match;
}

function private debug_values() {
  if(getdvarint(@ "nodebug", 0) >= 1) {
    return;
  }

  setdvarifuninitialized(@ "scr_debug_values", 0);
  waitframe();
  scr_debug_values = 0;
  scr_debug_values_next = -1;

  while(true) {
    if(gettime() > scr_debug_values_next) {
      scr_debug_values = getdvarint(@ "scr_debug_values");
      scr_debug_values_next = gettime() + 1000;
    }

    if(!scr_debug_values) {
      waitframe();
      continue;
    }

    str_debug_values_entity = string::to_string(getDvar(@ "scr_debug_values_entity", "<dev string:x26f>"));

    if(str_debug_values_entity == "<dev string:x26f>" || str_debug_values_entity == "<dev string:x273>" || str_debug_values_entity == "<dev string:x279>") {
      hud_ent = level.host ?? level.player ?? level.players[0];
      str_label = "<dev string:x281>";
    } else {
      str_value = str_debug_values_entity;
      str_key = "<dev string:x290>";

      if(issubstr(str_value, "<dev string:x29e>")) {
        a_toks = strtok(str_value, "<dev string:x29e>");
        str_value = a_toks[0];
        str_key = a_toks[1];
      }

      hud_ent = getEnt(str_value, str_key, 1);
      str_label = str_value + "<dev string:x29e>" + str_key;
    }

    printtoscreen2d(200, 100, str_label, (1, 1, 1), 2);
    a_all_ents = getEntArray();

    foreach(ent in a_all_ents) {
      if(isDefined(ent.values)) {
        i = 1;

        foreach(str_name, a_value in ent.values) {
          key = getlastarraykey(a_value);

          if(!isDefined(key)) {
            continue;
          }

          top_value = a_value[key];

          if(isDefined(top_value)) {
            b_valid = 1;

            if(level.values_ref[str_name].b_validate) {
              b_assert = getdvarint(@ "scr_debug_values", 0) > 1;
              b_valid = ent validate_value(str_name, top_value, b_assert);
            }

            ent display_value(i, str_name, key, top_value, isDefined(hud_ent) && b_valid, hud_ent == ent);
            i++;
          }
        }
      }
    }

    waitframe();
  }
}

function private display_value(index, str_name, str_id, value, b_valid, on_hud) {
  if(!isDefined(on_hud)) {
    on_hud = 0;
  }

  if(isxhash(str_id)) {
    str_id = getxhashsourcename(str_id);
  }

  str_value = "<dev string:x26f>";

  if(string::to_string(str_name) != "<dev string:x26f>") {
    str_value = string::rjust(str_name, 20);

    if(isarray(value)) {
      str_value += "<dev string:x2a3>";

      foreach(item in value) {
        str_value += "<dev string:x2ab>" + item + "<dev string:x2ab>";
      }

      str_value += "<dev string:x2b0>";
    } else if(isDefined(value)) {
      str_value += "<dev string:x2b5>" + value;
    }

    str_value += "<dev string:x2bc>" + string::ljust(string(str_id) + "<dev string:x2c2>", 30);
  }

  color = b_valid ? (1, 1, 1) : (1, 0, 0);

  if(on_hud) {
    printtoscreen2d(200, 100 + index * 25, str_value, color, 2);
  }

  print3d(self.origin - (0, 0, index * 8), str_value, color, 1, 0.3, 1);
}

# /