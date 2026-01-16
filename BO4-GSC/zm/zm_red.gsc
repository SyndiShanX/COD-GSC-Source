/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_red.gsc
***********************************************/

#include script_65930a0d8e6a77c2;
#include script_6c983b627f4a3d51;
#include scripts\abilities\ability_player;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm\ai\zm_ai_gegenees;
#include scripts\zm\powerup\zm_powerup_hero_weapon_power;
#include scripts\zm\weapons\zm_weap_bowie;
#include scripts\zm\weapons\zm_weap_hand_charon;
#include scripts\zm\weapons\zm_weap_hand_gaia;
#include scripts\zm\weapons\zm_weap_hand_hemera;
#include scripts\zm\weapons\zm_weap_hand_ouranos;
#include scripts\zm\weapons\zm_weap_riotshield;
#include scripts\zm\weapons\zm_weap_thunderstorm;
#include scripts\zm\zm_red_achievement;
#include scripts\zm\zm_red_boss_battle;
#include scripts\zm\zm_red_challenges;
#include scripts\zm\zm_red_challenges_rewards;
#include scripts\zm\zm_red_fasttravel;
#include scripts\zm\zm_red_ffotd;
#include scripts\zm\zm_red_gamemodes;
#include scripts\zm\zm_red_main_quest;
#include scripts\zm\zm_red_oracle_boons;
#include scripts\zm\zm_red_pap_quest;
#include scripts\zm\zm_red_power_quest;
#include scripts\zm\zm_red_special_rounds;
#include scripts\zm\zm_red_trap_boiling_bath;
#include scripts\zm\zm_red_trials;
#include scripts\zm\zm_red_util;
#include scripts\zm\zm_red_ww_quests;
#include scripts\zm\zm_red_zones;
#include scripts\zm_common\callbacks;
#include scripts\zm_common\load;
#include scripts\zm_common\util\ai_gegenees_util;
#include scripts\zm_common\util\ai_skeleton_util;
#include scripts\zm_common\zm;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_audio_sq;
#include scripts\zm_common\zm_blockers;
#include scripts\zm_common\zm_crafting;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_devgui;
#include scripts\zm_common\zm_equipment;
#include scripts\zm_common\zm_fasttravel;
#include scripts\zm_common\zm_items;
#include scripts\zm_common\zm_laststand;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_magicbox;
#include scripts\zm_common\zm_pack_a_punch;
#include scripts\zm_common\zm_pack_a_punch_util;
#include scripts\zm_common\zm_power;
#include scripts\zm_common\zm_round_logic;
#include scripts\zm_common\zm_round_spawning;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_spawner;
#include scripts\zm_common\zm_transformation;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_ui_inventory;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_vo;
#include scripts\zm_common\zm_wallbuy;
#include scripts\zm_common\zm_weapons;
#include scripts\zm_common\zm_zonemgr;

#namespace zm_red;

autoexec opt_in() {
  level.aat_in_use = 1;
  level.bgb_in_use = 1;
  level.bgb_machine_count = 2;
  level.random_pandora_box_start = 1;
  level.zombie_round_start_delay = 0;
  level.var_3a382f82 = 0.1;
  level.var_1f1de1ef = 1;
  level.pack_a_punch_camo_index = 74;
  level.pack_a_punch_camo_index_number_variants = 5;
  init_flags();
  zm_red_pap_quest::function_90a833e2();
}

event_handler[level_init] main(eventstruct) {
  level._uses_default_wallbuy_fx = 1;
  level._uses_sticky_grenades = 1;
  level._uses_taser_knuckles = 1;
  level.var_a5689564 = &zm_red_fasttravel::function_a5689564;
  level.var_e9737821 = &zm_red_fasttravel::function_c52e8ba;
  level.var_829d6a97 = &zm_red_fasttravel::function_ae5d684b;
  level.var_a5a050c1 = 15;
  level.var_9d19ea6d = 1;
  level.var_ce0f67cf = 120;
  level.var_a38d293a = 120;
  level.var_304d38af = &zm_red_util::function_f0ed2a66;
  level.var_45b0f2f3 = &function_443f6873;
  level.var_5a2df97b = &function_fbf0e632;
  ability_player::register_gadget_possession_callbacks(6, &function_f2427bae);
  zm::init_fx();
  clientfield::register("clientuimodel", "player_lives", 16000, 2, "int");
  clientfield::register("scriptmover", "" + #"register_pegasus", 16000, 1, "counter");
  clientfield::register("scriptmover", "" + #"special_target", 16000, 1, "int");
  clientfield::register("scriptmover", "" + #"medusa_eyes", 16000, 1, "int");
  clientfield::register("actor", "" + #"hash_2856f87ecdfaf62", 16000, 1, "counter");
  clientfield::register("actor", "" + #"hash_1bdce857fd614cef", 16000, 1, "counter");
  clientfield::register("world", "" + #"postfx_play", 16000, 2, "int");
  clientfield::register("world", "" + #"hash_71f9fcfb2cd84a9c", 16000, 1, "int");
  clientfield::register("toplayer", "" + #"eye_vignette", 16000, 1, "int");
  level._effect[#"headshot"] = #"zombie/fx_bul_flesh_head_fatal_zmb";
  level._effect[#"headshot_nochunks"] = #"zombie/fx_bul_flesh_head_nochunks_zmb";
  level._effect[#"bloodspurt"] = #"zombie/fx_bul_flesh_neck_spurt_zmb";
  level._effect[#"animscript_gib_fx"] = #"zombie/fx_blood_torso_explo_zmb";
  level._effect[#"animscript_gibtrail_fx"] = #"blood/fx_blood_gib_limb_trail";
  level._effect[#"switch_sparks"] = #"electric/fx8_sparks_burst_dir_sm_orange_os";
  level.default_start_location = "zone_temple_of_apollo";
  level.default_game_mode = "zclassic";
  level.var_22fda912 = &function_9f50079d;
  level.zombiemode_offhand_weapon_give_override = &offhand_weapon_give_override;

  if(zm_custom::function_901b751c(#"zmpowerdoorstate") == 0) {
    level.var_d5bd7049 = "";
  } else {
    level.var_d5bd7049 = #"hash_3ca4508c9597fd12";
  }

  level.pack_a_punch.custom_power_think = &zm_red_pap_quest::function_9b917fd5;
  level.var_c02e63 = &function_c02e63;
  level.var_d0ab70a2 = #"gamedata/weapons/zm/zm_red_weapons.csv";
  level._allow_melee_weapon_switching = 1;
  level.zombiemode_reusing_pack_a_punch = 1;
  level.custom_spawner_entry[#"crawl"] = &zm_spawner::function_45bb11e4;
  level.move_spawn_func = &function_a5f3cb45;
  level.var_6f6cc58 = &function_6f6cc58;
  level.var_4e4950d1 = &function_4e4950d1;
  level.var_21326085 = 1;
  level._no_vending_machine_auto_collision = 1;
  level thread sndfunctions();
  zm_red_achievement::init();
  zm_red_fasttravel::init();
  zm_red_trap_boiling_bath::init();
  namespace_f2050961::init();
  zm_red_ww_quests::init();
  zm_red_pap_quest::init();
  zm_red_power_quest::init();
  zm_red_main_quest::init();
  zm_red_challenges::init();
  zm_red_util::init();
  red_boss_battle::init();
  zm_audio_sq::init();
  load::main();
  scene::add_scene_func(#"cin_zm_red_outro_temple", &function_509bbc5b, "sh290");
  scene::add_scene_func(#"cin_zm_red_outro_temple", &function_924ba3d, "sh320");
  scene::add_scene_func(#"cin_zm_red_outro_temple", &function_bff9977d, "sh330");
  scene::add_scene_func(#"cin_zm_red_outro_temple", &function_5b984671, "play");
  scene::add_scene_func(#"cin_zm_red_outro_temple", &function_ea8d45ef, "done");
  scene::add_scene_func(#"cin_zm_red_outro_temple_part2", &function_b5670bb7, "play");
  scene::add_scene_func(#"cin_zm_red_outro_temple_part2", &function_75ef7b1f, "play");
  scene::add_scene_func(#"cin_zm_red_outro_temple_part2", &function_ea8d45ef, "done");
  scene::add_scene_func(#"cin_zm_red_outro_temple_part3", &function_b648a6d9, "init");
  scene::add_scene_func(#"cin_zm_red_outro_temple_part3", &function_883a1fb8, "play");
  scene::add_scene_func(#"cin_zm_red_outro_temple_part3", &function_ea8d45ef, "done");
  level.vending_machines_powered_on_at_start = 1;
  level.var_42d80aa0 = 0;
  level.zones = [];
  level.zone_manager_init_func = &zm_red_zones::zone_init;
  level thread zm_zonemgr::manage_zones("zone_temple_of_apollo");
  level thread zm_red_zones::init();
  level thread zm_red_special_rounds::init();
  level thread zm_red_main_quest::main();
  zm_red_fasttravel::main();
  level thread function_3f6e4b5f();
  zm_blockers::function_6f01c3cf("start_open", "script_label");

  if(!getdvarint(#"hash_576506f1621c45d2", 0)) {
    level thread function_c000f08b();
  }

  level.use_powerup_volumes = 1;

  level thread function_acb5b0ec();

    level.random_pandora_box_start = 1;
  level.magic_box_zbarrier_state_func = &zm_magicbox::function_35c66b27;
  level.chest_joker_model = "p8_fxanim_zm_zod_magic_box_skull_mod";
  level.chest_joker_custom_movement = &zm_magicbox::function_f5503c41;

  t_kill_ai = getent("<dev string:x38>", "<dev string:x44>");

  if(isDefined(t_kill_ai)) {
    t_kill_ai callback::on_trigger(&function_d4ff1dd6);
  }

    if(zm_custom::function_901b751c(#"zmmysteryboxstate") == 2) {
      level flag::wait_till("magicbox_initialized");
      var_2d50e3c1 = level.chests[level.chest_index];
      level.chests = array::filter(level.chests, 0, &function_7e4ce7f8);
      level.chest_index = array::find(level.chests, var_2d50e3c1);
    }

  zm_crafting::function_d1f16587(#"zblueprint_shield_zhield_zpear", &function_4479ec95);

  if(!zm_custom::function_901b751c(#"zmequipmentisenabled")) {
    level thread zm_crafting::function_ca244624(#"zblueprint_red_strike");
  }

  level.zm_bgb_anywhere_but_here_validation_override = &function_598a6222;
  level.var_e120ae98 = &function_46159bb7;
  function_625a9bcf();
  function_8f72e6b8();
  zm_custom::function_a00576dd(&function_7722c6f0, undefined, &function_c8ce0a17, undefined);
  level.var_338bae81 = &function_338bae81;
  level.var_d99d49fd = &function_7c7c6a1;

  if(zm_utility::is_trials()) {
    level.var_a601d6a6 = &function_95db9900;
    level.var_43216bdf = &function_28073e18;
    level thread function_269f27a9();
    level thread function_ea526b81();
  }
}

private function_95db9900(weapon) {
  if(weapon === level.w_hand_charon || weapon === level.w_hand_charon_charged || weapon === level.w_hand_charon_uncharged) {
    return level.w_hand_charon;
  }

  if(weapon === level.w_hand_gaia || weapon === level.w_hand_gaia_charged || weapon === level.w_hand_gaia_uncharged) {
    return level.w_hand_gaia;
  }

  if(weapon === level.w_hand_ouranos || weapon === level.w_hand_ouranos_charged || weapon === level.w_hand_ouranos_uncharged) {
    return level.w_hand_ouranos;
  }

  if(weapon === level.w_hand_hemera || weapon === level.w_hand_hemera_charged || weapon === level.w_hand_hemera_uncharged) {
    return level.w_hand_hemera;
  }

  return weapon;
}

private function_269f27a9() {
  level.var_ab5b85bf = "bonus_points_team";
  n_players = getplayers().size;
  var_b67b53e8 = zombie_utility::get_zombie_var(#"hash_434b3261c607850" + n_players);
  var_ee327079 = zombie_utility::get_zombie_var(#"zombie_powerup_drop_max_" + n_players);
  zombie_utility::set_zombie_var(#"hash_434b3261c607850" + n_players, n_players * 5);
  zombie_utility::set_zombie_var(#"zombie_powerup_drop_max_" + n_players, n_players * 5);
  level.var_1dce56cc = n_players * 5;

  while(isDefined(level.var_ab5b85bf)) {
    waitframe(1);
  }

  if(getplayers().size == 1) {
    level.var_ab5b85bf = "bonus_points_team";
  } else {
    level.var_ab5b85bf = array::random(array("bonus_points_team", "double_points"));
  }

  zm_utility::function_fdb0368(4);
  zombie_utility::set_zombie_var(#"hash_434b3261c607850" + n_players, var_b67b53e8 + 3);
  zombie_utility::set_zombie_var(#"zombie_powerup_drop_max_" + n_players, var_ee327079 + 3);
}

private function_28073e18(b_game_ended) {
  if(level.round_number == 1) {
    level thread function_cba532f6();
  }

  if(isDefined(level.var_ac6d10d4) && level.var_ac6d10d4) {
    level thread zm_red_power_quest::function_a5b8e88f(1);
  }

  if(isDefined(level.var_8aa0830e) && level.var_8aa0830e) {
    foreach(player in getplayers()) {
      player thread function_6f63ad34();
    }
  }

  if(isDefined(level.var_c7e9961f) && level.var_c7e9961f) {
    level thread function_a47f80af();
  }
}

private function_a47f80af() {
  self notify("4ae9dc40193a4f80");
  self endon("4ae9dc40193a4f80");
  level endon(#"egg_free");
  level flag::wait_till_clear("round_reset");
  mdl_blocker = getent("pap_arena_blocker", "targetname");

  if(isDefined(mdl_blocker)) {
    mdl_blocker setinvisibletoall();
  }

  exploder::stop_exploder("Fxexp_barrier_pap");
  level waittill(#"pap_defend");
  exploder::exploder("Fxexp_barrier_pap");
}

private function_6f63ad34() {
  self endon(#"disconnect");
  level flag::wait_till_clear("round_reset");
  level thread zm_powerup_hero_weapon_power::hero_weapon_power(self);
}

function_ea526b81() {
  level flag::wait_till(#"hash_7943879f3be8ccc6");
  level.var_5b175281 = level.check_for_valid_spawn_near_team_callback;
  level.check_for_valid_spawn_near_team_callback = &function_f0bd229;

  if(!level flag::get("zm_red_fasttravel_open")) {
    level zm_utility::function_fdb0368(10, "zm_red_fasttravel_open");

    if(!level flag::get("zm_red_fasttravel_open")) {
      level flag::set("zm_red_fasttravel_open");
      level thread function_a7641284();
    }
  }

  level.check_for_valid_spawn_near_team_callback = level.var_5b175281;
  level.var_5b175281 = undefined;
}

function_a7641284() {
  if(level flag::get(#"egg_free") || level flag::get(#"pap_quest_completed")) {
    return;
  }

  level endon(#"egg_free", #"pap_quest_completed");
  var_af2013df = array(#"hash_67695ee69c57c0b2", #"hash_61de3b8fe6f6a35");
  level flag::wait_till_all(var_af2013df);

  while(true) {
    wait 1;
    var_c91c19bb = 0;

    foreach(player in getplayers()) {
      t_pap = getent("trigger_pap_defend", "targetname");

      if(isDefined(t_pap) && isalive(player) && player istouching(t_pap)) {
        var_c91c19bb = 1;
        break;
      }
    }

    if(!var_c91c19bb) {
      function_a47f80af();
    }
  }
}

function_f0bd229(player, var_feed7374) {
  var_44841a74 = struct::get_array("s_trials_dark_side_spawn_points");
  n_ent_num = player getentitynumber();
  return var_44841a74[n_ent_num];
}

function_dba42129(n_max, n_round) {
  if(n_round == 1) {
    return 0;
  }

  return n_max;
}

function_cba532f6() {
  level.check_for_valid_spawn_near_team_callback = &function_f8822ae1;
  array::wait_any(getplayers(), "round_reset_done");
  level.zombie_round_start_delay = 0;
  level.var_c54ec9bb = 1;
  level.noroundnumber = 1;
  level thread function_c000f08b();
}

private function_f8822ae1(player, var_feed7374) {
  var_b9083025 = struct::get_array("initial_spawn_points");
  n_ent_num = player getentitynumber();
  return var_b9083025[n_ent_num];
}

init_flags() {
  level flag::init(#"round_one");
  level flag::init(#"spartoi_resurrect");
  level flag::init(#"hash_6c92a415bd4bb739");
  level flag::init(#"pegasus_exited");
}

function_3f6e4b5f() {
  if(zm_custom::function_901b751c(#"zmdoorstate") == 2) {
    zm_zonemgr::enable_zone("zone_temple_to_stoa_of_the_athenians");
  }
}

function_4479ec95(e_player) {
  level.var_f9e5f55a = 1;
}

function_7e4ce7f8(s_chest) {
  if(s_chest.script_noteworthy == "serpent_pass_chest" || s_chest.script_noteworthy == "cliff_tombs_chest") {
    return 0;
  }

  return 1;
}

registermp_vehicles_agr_prespawn(s_chest) {
  if(s_chest.script_noteworthy == "serpent_pass_chest" || s_chest.script_noteworthy == "cliff_tombs_chest") {
    return 1;
  }

  return 0;
}

function_c000f08b() {
  level endon(#"end_game", #"hash_49085a6baf9c2c27");

  if(zm_custom::function_901b751c(#"zmenhancedstate") == 2 || zm_custom::function_901b751c(#"zmminibossstate") == 2 || zm_custom::function_901b751c(#"startround") > 1) {
    level thread function_12b9b9a9();
    return;
  }

  a_s_spawns = struct::get_array(#"hash_39721602c33f4cc7");

  if(getdvarint(#"zombie_cheat", 0) == 2) {
    level thread function_12b9b9a9();
    return;
  }

    level.no_powerups = 1;
  level flag::clear("spawn_zombies");
  level flag::set("pause_round_timeout");
  level flag::set("hold_round_end");
  level thread function_d7831b0f();
  level flag::wait_till("all_players_spawned");
  a_e_players = getplayers();
  n_players = a_e_players.size;
  n_spawn_limit = zm_round_logic::get_zombie_count_for_round(1, n_players);

  if(zm_utility::is_trials()) {
    level.max_zombie_func = &function_dba42129;
    level flag::clear("hold_round_end");
  }

  a_s_chosen = [];
  level.a_starting_zombies = [];

  if(n_players > 1) {
    a_s_extras = struct::get_array(#"hash_6acfe5efcae5340e");
    a_s_extras = array::randomize(a_s_extras);

    if(!isDefined(a_s_spawns)) {
      a_s_spawns = [];
    } else if(!isarray(a_s_spawns)) {
      a_s_spawns = array(a_s_spawns);
    }

    a_s_spawns[a_s_spawns.size] = a_s_extras[0];

    if(!isDefined(a_s_spawns)) {
      a_s_spawns = [];
    } else if(!isarray(a_s_spawns)) {
      a_s_spawns = array(a_s_spawns);
    }

    a_s_spawns[a_s_spawns.size] = a_s_extras[1];
  }

  a_s_remaining = arraycopy(a_s_spawns);

  foreach(e_player in a_e_players) {
    if(a_s_remaining.size > 0) {
      a_s_remaining = array::randomize(a_s_remaining);

      if(isplayer(e_player)) {
        v_player_forward = anglesToForward(e_player getplayerangles());

        foreach(s_spawn in a_s_spawns) {
          var_75d386a3 = vectornormalize(s_spawn.origin - e_player.origin);
          n_dot = vectordot(v_player_forward, var_75d386a3);

          if(n_dot >= 0.86) {
            if(!isDefined(a_s_chosen)) {
              a_s_chosen = [];
            } else if(!isarray(a_s_chosen)) {
              a_s_chosen = array(a_s_chosen);
            }

            a_s_chosen[a_s_chosen.size] = s_spawn;
            n_index = array::find(a_s_remaining, s_spawn);
            arrayremoveindex(a_s_remaining, n_index);

            if(a_s_chosen.size >= n_spawn_limit) {
              break;
            }
          }
        }
      }

      a_s_spawns = a_s_remaining;

      if(a_s_chosen.size >= n_spawn_limit) {
        break;
      }
    }

    waitframe(1);
  }

  foreach(s_chosen in a_s_chosen) {
    e_zombie = s_chosen function_9f8c0587();

    if(!isDefined(level.a_starting_zombies)) {
      level.a_starting_zombies = [];
    } else if(!isarray(level.a_starting_zombies)) {
      level.a_starting_zombies = array(level.a_starting_zombies);
    }

    level.a_starting_zombies[level.a_starting_zombies.size] = e_zombie;
  }

  a_s_extras = struct::get_array(#"hash_6acfe5efcae5340e");
  a_s_remaining = arraycombine(a_s_remaining, a_s_extras, 0, 0);

  foreach(s_spawn in a_s_remaining) {
    if(isDefined(s_spawn.target)) {
      mdl_clip = getent(s_spawn.target, "targetname");
      mdl_clip notsolid();
    }
  }

  if(isDefined(level.var_c54ec9bb) && level.var_c54ec9bb) {
    level util::delay(4, "round_reset", &function_d2085d57);
  } else {
    level thread function_d2085d57();
  }

  level waittill(#"zombie_total_set", #"hash_39eae7c03390a3a7", #"round_reset");

  if(zm_utility::is_trials()) {
    level.max_zombie_func = undefined;
  }

  level.zombie_total = 0;
  level.zombie_respawns = 0;
  level.no_powerups = undefined;
  level.a_starting_zombies = undefined;
  level.zombie_round_start_delay = undefined;
  level flag::set("spawn_zombies");
  level flag::clear("pause_round_timeout");
  level flag::clear("hold_round_end");
}

function_d2085d57() {
  level endon(#"hash_1cf28f130f16e2eb", #"hash_49085a6baf9c2c27");
  level flag::wait_till("gameplay_started");
  exploder::stop_exploder("exp_lgt_temple_gameplay_group");
  level notify(#"hash_1cf28f130f16e2eb");
}

private function_d7831b0f() {
  level endon(#"end_game", #"hash_49085a6baf9c2c27");
  level thread function_a3e22935();
  s_result = level waittill(#"end_of_round", #"hash_dc34ebe02d09532");
  level.no_powerups = undefined;
  level flag::set(#"round_one");
  level flag::set("spawn_zombies");
  level flag::clear("pause_round_timeout");
  level flag::clear("hold_round_end");

  if(!level flag::get("round_reset")) {
    level thread function_12b9b9a9();
  }
}

private function_a3e22935() {
  level endon(#"end_game", #"end_of_round", #"hash_dc34ebe02d09532");
  level waittill(#"host_migration_begin");
  level notify(#"hash_49085a6baf9c2c27");
  level waittill(#"host_migration_end");
  level thread function_c000f08b();
  wait 1;
  level notify(#"hash_39eae7c03390a3a7");
}

private function_12b9b9a9() {
  if(zm_utility::is_trials()) {
    level.check_for_valid_spawn_near_team_callback = undefined;
    level.zombie_round_start_delay = undefined;
    level.var_c54ec9bb = undefined;
    level.noroundnumber = undefined;
    level.max_zombie_func = undefined;
    level notify(#"hash_49085a6baf9c2c27");
  }

  a_s_spawns = struct::get_array(#"hash_39721602c33f4cc7");
  a_s_extras = struct::get_array(#"hash_6acfe5efcae5340e");
  a_s_spawns = arraycombine(a_s_spawns, a_s_extras, 0, 0);

  foreach(s_spawn in a_s_spawns) {
    if(isDefined(s_spawn.target)) {
      mdl_clip = getent(s_spawn.target, "targetname");
      mdl_clip delete();
    }
  }

  array::delete_all(a_s_spawns);
}

function_a5f3cb45(s_spawn) {
  if(isDefined(s_spawn.var_6efb24e2) && s_spawn.var_6efb24e2 || isDefined(s_spawn.var_3816dc63) && s_spawn.var_3816dc63) {
    return;
  }

  self thread zm_utility::move_zombie_spawn_location(s_spawn);
}

function_9f8c0587() {
  self.var_3816dc63 = 1;

  while(true) {
    ai_zombie = zombie_utility::spawn_zombie(array::random(level.zombie_spawners), undefined, self);

    if(isDefined(ai_zombie)) {
      break;
    }

    waitframe(1);
  }

  ai_zombie.no_eye_glow = 1;
  ai_zombie.ignore_round_spawn_failsafe = 1;

  if(zm_custom::function_901b751c(#"zmdoorstate") != 2) {
    ai_zombie.b_ignore_cleanup = 1;
  }

  ai_zombie.start_inert = 1;
  ai_zombie forceteleport(self.origin, self.angles);
  ai_zombie dontinterpolate();

  if(isDefined(self.target)) {
    mdl_clip = getent(self.target, "targetname");
    mdl_clip delete();
  }

  ai_zombie thread function_690aab3e();
  ai_zombie thread companys_();
  return ai_zombie;
}

function_690aab3e() {
  level endon(#"hash_1cf28f130f16e2eb");
  self waittill(#"damage", #"death");
  level notify(#"hash_1cf28f130f16e2eb");
}

companys_() {
  self endon(#"death");
  self thread scene::play(#"aib_zm_red_ampthtr_zombie_trnsfxd", "Shot 1", self);
  level waittill(#"hash_1cf28f130f16e2eb");
  self.no_eye_glow = undefined;
  self thread zombie_utility::zombie_eye_glow();
  wait randomfloatrange(1.6, 2.9);
  self thread scene::play(#"aib_zm_red_ampthtr_zombie_trnsfxd", "Shot 2", self);
}

function_eba3496(var_cd13b40e = 1, var_4e4cc9a9 = 1) {
  str_model = level.var_b0ccfa4c[randomint(level.var_b0ccfa4c.size)];
  mdl_zombie = util::spawn_model(str_model, self.origin, self.angles);
  mdl_zombie.target = self.target;
  mdl_zombie.var_e259ad71 = self.var_e259ad71;
  mdl_zombie.sp_model = getent(str_model, "targetname");
  mdl_zombie thread scene::play(#"aib_zm_red_ampthtr_zombie_trnsfxd", "Shot 1", mdl_zombie);

  if(var_cd13b40e) {
    mdl_zombie thread function_fb3ab798(var_4e4cc9a9);
  }

  return mdl_zombie;
}

function_a4e2970b(var_4e4cc9a9 = 1, s_damage) {
  if(isDefined(self.var_a7cbb3cb) && self.var_a7cbb3cb) {
    return;
  }

  self.var_a7cbb3cb = 1;
  s_spawn = struct::spawn(self.origin, self.angles);
  s_spawn.var_3816dc63 = 1;

  while(true) {
    if(isDefined(self.sp_model)) {
      ai_zombie = zombie_utility::spawn_zombie(self.sp_model, undefined, s_spawn);
    } else {
      ai_zombie = zombie_utility::spawn_zombie(array::random(level.zombie_spawners), undefined, s_spawn);
    }

    if(isDefined(ai_zombie)) {
      break;
    }

    waitframe(1);
  }

  s_spawn struct::delete();
  ai_zombie.start_inert = 1;
  ai_zombie forceteleport(self.origin, self.angles);
  ai_zombie dontinterpolate();

  if(isDefined(self.target)) {
    mdl_clip = getent(self.target, "targetname");
    mdl_clip delete();
  }

  b_killed = 0;

  if(isDefined(s_damage)) {
    n_damage = s_damage.amount;

    if(n_damage >= ai_zombie.health) {
      b_killed = 1;
    }

    e_attacker = s_damage.attacker;
    ai_zombie dodamage(n_damage, s_damage.position, e_attacker, s_damage.inflictor, "none", s_damage.mod, -1, s_damage.weapon);
  }

  if(!b_killed) {
    ai_zombie.ignore_round_spawn_failsafe = 1;

    if(zm_custom::function_901b751c(#"zmdoorstate") != 2) {
      ai_zombie.b_ignore_cleanup = 1;
    }

    ai_zombie.var_126d7bef = 1;
    ai_zombie.no_powerups = 1;

    if(var_4e4cc9a9) {
      level zm_transform::function_5db4f2f5(ai_zombie);
      ai_zombie.ignore_enemy_count = 1;
      ai_zombie.var_12745932 = 1;
      ai_zombie.var_ae4569d5 = 1;
      ai_zombie.var_e259ad71 = self.var_e259ad71;
      ai_zombie thread zm_red_power_quest::function_2a80a9cc();
    }

    if(isDefined(self.str_scene)) {
      self thread scene::play(self.str_scene, "breakout", self);
    } else {
      self thread scene::play(#"aib_zm_red_ampthtr_zombie_trnsfxd", "Shot 2", self);
    }

    if(zm_utility::is_trials() && var_4e4cc9a9) {
      self thread function_19a28e98();
    } else {
      self thread util::delayed_delete(float(function_60d95f53()) / 1000);
    }

    ai_zombie clientfield::increment("" + #"zombie_breakout");

    if(isDefined(self.mdl_chaos)) {
      if(zm_utility::is_trials() && var_4e4cc9a9) {
        self.mdl_chaos thread function_19a28e98();
      } else {
        self.mdl_chaos delete();
      }
    }

    if(isDefined(self.str_scene)) {
      self scene::play(self.str_scene, "breakout", self);
    } else {
      self scene::play(#"aib_zm_red_ampthtr_zombie_trnsfxd", "Shot 2", self);
    }

    if(!var_4e4cc9a9 && isDefined(ai_zombie)) {
      ai_zombie thread zombie_utility::round_spawn_failsafe();
      ai_zombie.ignore_round_spawn_failsafe = undefined;
      ai_zombie.b_ignore_cleanup = undefined;
      ai_zombie.var_126d7bef = undefined;
    }
  }

  if(isDefined(self)) {
    if(zm_utility::is_trials() && var_4e4cc9a9) {
      self thread function_19a28e98();
      return;
    }

    self delete();
  }
}

function_19a28e98() {
  self notify("ce3924c2a8d8ee7");
  self endon("ce3924c2a8d8ee7");
  self endon(#"death");

  if(!isstruct(self)) {
    self hide();
  }

  level flag::wait_till(#"pegasus_rescue");

  if(isstruct(self)) {
    self struct::delete();
    return;
  }

  self delete();
}

function_fb3ab798(var_4e4cc9a9 = 1) {
  self endon(#"death");
  self val::set(#"hash_58d304d03782fc3c", "takedamage", 1);
  self.health = 99999999;

  while(true) {
    s_waitresult = self waittill(#"damage");
    e_attacker = s_waitresult.attacker;

    if(isplayer(e_attacker) && zm_utility::is_player_valid(e_attacker, 0, 0, 0)) {
      if(!var_4e4cc9a9) {
        break;
      }

      var_168ccd6b = getent("vol_power_quest_kill_zone", "targetname");

      if(e_attacker istouching(var_168ccd6b)) {
        break;
      }
    }
  }

  if(var_4e4cc9a9 && !level flag::get(#"hash_dc34ebe02d09532")) {
    level.var_2f2b78fb.var_5bf6d1df++;

    if(level.var_2f2b78fb.var_5bf6d1df >= 2) {
      level flag::set(#"hash_dc34ebe02d09532");
    }
  }

  if(!(isDefined(self.var_a7cbb3cb) && self.var_a7cbb3cb)) {
    if(level flag::get(#"hash_dc34ebe02d09532")) {
      level thread zm_red_power_quest::function_b8848794(self.var_e259ad71, 0);
    }

    if(var_4e4cc9a9) {
      self thread function_a4e2970b(var_4e4cc9a9, s_waitresult);
      return;
    }

    level thread function_a14d96ed();
  }
}

function_a14d96ed() {
  foreach(starting_zombie in level.a_mdl_zombies) {
    if(isDefined(starting_zombie)) {
      starting_zombie thread function_a4e2970b(0);
      wait 0.5;
    }
  }
}

function_4e4950d1(poi) {
  vol_amphitheater = getent("vol_power_quest_kill_zone", "targetname");

  if(isDefined(vol_amphitheater) && poi[1] istouching(vol_amphitheater)) {
    poi[1].var_fd141207 = 1;
  }

  reachable = self function_6f6cc58(poi[1]);
  return reachable;
}

function_6f6cc58(e_player) {
  if(!isDefined(e_player) || !isDefined(self)) {
    return false;
  }

  if(level flag::get(#"hash_70efff113b745513") && !isDefined(self.var_ae4569d5) && isDefined(e_player.var_fd141207) && e_player.var_fd141207) {
    var_9e80f473 = array("zone_amphitheater", "zone_amphitheater_house");
    str_zone = self zm_utility::get_current_zone();

    if(isDefined(str_zone) && !isinarray(var_9e80f473, str_zone)) {
      return false;
    }
  }

  vol_light_side = getent("vol_light_side", "targetname");
  vol_dark_side = getent("vol_dark_side", "targetname");
  var_9b9fe2ad = self istouching(vol_light_side);
  var_ecad7bb = e_player istouching(vol_light_side);
  var_59248979 = self istouching(vol_dark_side);
  var_ef8cbe1f = e_player istouching(vol_dark_side);

  if(var_59248979 && var_ecad7bb) {
    return false;
  }

  if(var_9b9fe2ad && var_ef8cbe1f) {
    return false;
  }

  vol_gaia_combat = getent("vol_gaia_combat", "script_noteworthy");
  var_6b56dfbd = self istouching(vol_gaia_combat);
  var_c944a910 = e_player istouching(vol_gaia_combat);

  if(var_6b56dfbd && !var_c944a910 || var_c944a910 && !var_6b56dfbd) {
    return false;
  }

  vol_charon_combat = getent("vol_charon_combat", "script_noteworthy");
  var_397d0352 = self istouching(vol_charon_combat);
  var_cb8ad8e2 = e_player istouching(vol_charon_combat);

  if(var_397d0352 && !var_cb8ad8e2 || var_cb8ad8e2 && !var_397d0352) {
    return false;
  }

  vol_hemera_combat = getent("vol_hemera_combat", "script_noteworthy");
  var_670f0524 = self istouching(vol_hemera_combat);
  var_4a314340 = e_player istouching(vol_hemera_combat);

  if(var_670f0524 && !var_4a314340 || var_4a314340 && !var_670f0524) {
    return false;
  }

  vol_ouranos_combat = getent("vol_ouranos_combat", "script_noteworthy");
  var_ee73da02 = self istouching(vol_ouranos_combat);
  var_863a1e1f = e_player istouching(vol_ouranos_combat);

  if(var_ee73da02 && !var_863a1e1f || var_863a1e1f && !var_ee73da02) {
    return false;
  }

  if(!var_ecad7bb && !var_ef8cbe1f && !var_863a1e1f && !var_4a314340 && !var_c944a910 && !var_cb8ad8e2) {
    return false;
  }

  if(zm_utility::is_ee_enabled() || zm_utility::is_trials()) {
    if(isDefined(self.var_be2fc36d) && self.var_be2fc36d) {
      s_play = level.var_28dcf408;

      if(isDefined(s_play)) {
        a_e_participants = s_play.a_e_participants;
        str_ww = self.var_8ca159b2;
        e_target = a_e_participants[str_ww];

        if(isDefined(e_target) && e_target != e_player) {
          return false;
        }
      }
    }
  }

  return true;
}

function_9f50079d() {
  zm_loadout::register_tactical_grenade_for_level("zhield_zpear_dw", 1);
}

offhand_weapon_give_override(str_weapon) {
  self endon(#"death");

  if(zm_loadout::is_tactical_grenade(str_weapon) && isDefined(self zm_loadout::get_player_tactical_grenade()) && !self zm_loadout::is_player_tactical_grenade(str_weapon)) {
    self setweaponammoclip(self zm_loadout::get_player_tactical_grenade(), 0);
    self takeweapon(self zm_loadout::get_player_tactical_grenade());
  }

  return false;
}

sndfunctions() {
  if(zm_utility::is_standard()) {
    level.zmannouncerprefix = "rush";
  } else {
    level.zmannouncerprefix = "prst";
  }

  level.sndweaponpickupoverride = array(#"wonder");
  zm_utility::add_sound("zmb_heavy_door_open", "zmb_heavy_door_open");
  level thread setupmusic();
  level thread custom_add_vox();
  level thread setup_personality_character_exerts();
}

custom_add_vox() {
  zm_audio::loadplayervoicecategories(#"hash_41c3d60c9fdc1c1a");
  zm_audio::loadplayervoicecategories(#"hash_5963a3db3032ab46");
  zm_audio::loadplayervoicecategories(#"hash_37db46ab64d46fca");
}

setupmusic() {
  zm_audio::musicstate_create("round_start", 3, "red_roundstart_1", "red_roundstart_2");
  zm_audio::musicstate_create("round_end", 3, "red_roundend_1", "red_roundend_2");
  zm_audio::musicstate_create("game_over", 5, "red_death");
  zm_audio::musicstate_create("ee_song", 4, "ee_song");
  zm_audio::musicstate_create("poweron_event_start", 4, "poweron_event_start");
  zm_audio::musicstate_create("poweron_event_complete", 4, "poweron_event_complete");
  zm_audio::musicstate_create("play", 4, "play");
  zm_audio::musicstate_create("the_ride", 4, "the_ride");
  zm_audio::musicstate_create("pap_complete", 4, "pap_complete");
}

setup_personality_character_exerts() {
  level.exert_sounds[1][#"hitmed"] = "vox_plr_1_exert_pain";
  level.exert_sounds[2][#"hitmed"] = "vox_plr_2_exert_pain";
  level.exert_sounds[3][#"hitmed"] = "vox_plr_3_exert_pain";
  level.exert_sounds[4][#"hitmed"] = "vox_plr_4_exert_pain";
  level.exert_sounds[1][#"hitlrg"] = "vox_plr_1_exert_pain";
  level.exert_sounds[2][#"hitlrg"] = "vox_plr_2_exert_pain";
  level.exert_sounds[3][#"hitlrg"] = "vox_plr_2_exert_pain";
  level.exert_sounds[4][#"hitlrg"] = "vox_plr_3_exert_pain";
  level.exert_sounds[1][#"drowning"] = "vox_plr_1_exert_underwater_air_low";
  level.exert_sounds[2][#"drowning"] = "vox_plr_2_exert_underwater_air_low";
  level.exert_sounds[3][#"drowning"] = "vox_plr_3_exert_underwater_air_low";
  level.exert_sounds[4][#"drowning"] = "vox_plr_4_exert_underwater_air_low";
  level.exert_sounds[1][#"cough"] = "vox_plr_1_exert_gas_cough";
  level.exert_sounds[2][#"cough"] = "vox_plr_2_exert_gas_cough";
  level.exert_sounds[3][#"cough"] = "vox_plr_3_exert_gas_cough";
  level.exert_sounds[4][#"cough"] = "vox_plr_4_exert_gas_cough";
  level.exert_sounds[1][#"underwater_emerge"] = "vox_plr_1_exert_underwater_emerge_breath";
  level.exert_sounds[2][#"underwater_emerge"] = "vox_plr_2_exert_underwater_emerge_breath";
  level.exert_sounds[3][#"underwater_emerge"] = "vox_plr_3_exert_underwater_emerge_breath";
  level.exert_sounds[4][#"underwater_emerge"] = "vox_plr_4_exert_underwater_emerge_breath";
  level.exert_sounds[1][#"underwater_gasp"] = "vox_plr_1_exert_underwater_emerge_gasp";
  level.exert_sounds[2][#"underwater_gasp"] = "vox_plr_2_exert_underwater_emerge_gasp";
  level.exert_sounds[3][#"underwater_gasp"] = "vox_plr_3_exert_underwater_emerge_gasp";
  level.exert_sounds[4][#"underwater_gasp"] = "vox_plr_4_exert_underwater_emerge_gasp";
}

play_outro() {
  foreach(player in getplayers()) {
    if(isDefined(player)) {
      player disableweaponfire();
    }

    if(player clientfield::get("" + #"chakram_whirlwind_fx")) {
      player clientfield::set("" + #"chakram_whirlwind_fx", 0);
    }
  }

  namespace_c8efdadc::function_53bac096(1);

  foreach(e_player in util::get_active_players()) {
    e_player val::set(#"outro", "freezecontrols", 1);
    e_player.var_16735873 = 1;

    if(e_player laststand::player_is_in_laststand()) {
      e_player thread zm_laststand::auto_revive(e_player, 0, 0);
    }

    e_player val::set(#"outro", "takedamage", 0);
    e_player val::set(#"outro", "ignoreme", 1);
    e_player notify(#"bgb_update");
  }

  zm_devgui::zombie_devgui_open_sesame();

    level zm_vo::function_3c173d37((0, 0, 0), 2147483647);
  level zm_audio::sndvoxoverride(1);
  zombie_utility::clear_all_corpses();
  util::set_lighting_state(0);
  scene::play(#"cin_zm_red_outro_temple");
  scene::play(#"cin_zm_red_outro_temple_part2");
  scene::play(#"cin_zm_red_outro_temple_part3");
  scene::play(#"cin_zm_red_outro_temple_part4");
  level scene::function_f81475ae(#"cin_zm_red_outro_temple_part4");

  foreach(player in getplayers()) {
    if(isDefined(player)) {
      player enableweaponfire();
    }
  }

  level notify(#"end_game");
}

function_eeb6a1e7() {
  s_wallbuy = struct::get("tr_leveraction_t8", "zombie_weapon_upgrade");
  var_8651c21a = struct::get(s_wallbuy.target);
  mdl_wallbuy = getent(var_8651c21a.target, "targetname");
  mdl_wallbuy hide();
  level clientfield::set(s_wallbuy.trigger_stub.clientfieldname, 0);
  mdl_wallbuy clientfield::set("wallbuy_ambient_fx", 0);
}

function_bff9977d(a_ents) {
  if(isDefined(a_ents[#"scarlett_eyes"])) {
    scarlett_eyes = a_ents[#"scarlett_eyes"];
    level waittill(#"eyes_start");
    scarlett_eyes clientfield::set("" + #"medusa_eyes", 1);
  }
}

function_b5670bb7(a_ents) {
  if(isDefined(a_ents[#"scarlett_eyes"])) {
    scarlett_eyes = a_ents[#"scarlett_eyes"];
    scarlett_eyes clientfield::set("" + #"medusa_eyes", 1);
    level waittill(#"eyes_done");
    scarlett_eyes clientfield::set("" + #"medusa_eyes", 0);
  }
}

function_924ba3d(a_ents) {
  foreach(player in getplayers()) {
    player clientfield::set_to_player("" + #"eye_vignette", 1);
  }

  if(isDefined(a_ents[#"medusa_eyes"])) {
    medusa_eyes = a_ents[#"medusa_eyes"];
    level waittill(#"eyes_start");
    medusa_eyes clientfield::set("" + #"medusa_eyes", 1);
    level waittill(#"eyes_done");
    medusa_eyes clientfield::set("" + #"medusa_eyes", 0);
  }
}

function_b648a6d9(a_ents) {
  if(isDefined(a_ents[#"medusa_eyes"])) {
    medusa_eyes = a_ents[#"medusa_eyes"];
    medusa_eyes clientfield::set("" + #"medusa_eyes", 1);
    level waittill(#"eyes_done");
    medusa_eyes clientfield::set("" + #"medusa_eyes", 0);
  }
}

function_5b984671(a_ents) {
  zm_utility::function_9ad5aeb1(0, 1, 1, 0);
  level clientfield::set("" + #"postfx_play", 1);
  zm_red_challenges::function_304fb042();

  foreach(e_player in util::get_active_players()) {
    e_player val::reset(#"outro", "freezecontrols");
  }

  array::run_all(getEntArray("zm_red_temple_clutter_left", "targetname"), &delete);
  array::run_all(getEntArray("zm_red_temple_clutter_right", "targetname"), &delete);
  array::run_all(getEntArray("zm_red_temple_clutter_oracle", "targetname"), &delete);
  hidemiscmodels("zm_red_temple_clutter_oracle_pile");
  hidemiscmodels("zm_red_oracle_floor_door");
}

function_509bbc5b(a_ents) {
  level thread scene::init_streamer(#"cin_zm_red_outro_temple_part4", #"allies", 0, 0);
}

function_75ef7b1f(a_ents) {
  level scene::function_f81475ae(#"cin_zm_red_outro_temple");
  level scene::function_27f5972e(#"cin_zm_red_outro_temple_part4");
  level clientfield::set("" + #"postfx_play", 2);

  foreach(e_player in util::get_active_players()) {
    e_player val::reset(#"outro", "freezecontrols");
  }
}

function_883a1fb8(a_ents) {
  level clientfield::set("" + #"postfx_play", 3);

  foreach(e_player in util::get_active_players()) {
    e_player val::reset(#"outro", "freezecontrols");
  }
}

function_ea8d45ef(a_ents) {
  level clientfield::set("" + #"postfx_play", 0);
}

function_625a9bcf() {
  level zm_audio::function_6191af93(#"shield_piece", #"pickup", "", "");
  w_component = zm_crafting::get_component(#"zitem_zhield_zpear_part_1");
  zm_items::function_4d230236(w_component, &function_a3fd9b43);
  w_component = zm_crafting::get_component(#"zitem_zhield_zpear_part_2");
  zm_items::function_4d230236(w_component, &function_3fbc19fb);
  w_component = zm_crafting::get_component(#"zitem_zhield_zpear_part_3");
  zm_items::function_4d230236(w_component, &function_9f645f7);
}

function_a3fd9b43(e_holder, w_item) {
  self thread zm_audio::create_and_play_dialog(#"shield_piece", #"pickup_1", undefined, 1);
}

function_3fbc19fb(e_holder, w_item) {
  self thread zm_audio::create_and_play_dialog(#"shield_piece", #"pickup_3");
}

function_9f645f7(e_holder, w_item) {
  self thread zm_audio::create_and_play_dialog(#"shield_piece", #"pickup_2");
}

function_8f72e6b8() {
  w_component = zm_crafting::get_component(#"zitem_red_strike_part_1");
  w_component.var_62a98b13 = #"anvil_brontes";
  w_component = zm_crafting::get_component(#"zitem_red_strike_part_2");
  w_component.var_62a98b13 = #"hammer_arges";
  w_component = zm_crafting::get_component(#"zitem_red_strike_part_3");
  w_component.var_62a98b13 = #"hash_2ac16e115b8e401a";
}

function_f2427bae(slot, weapon) {
  if(weapon == level.w_thunderstorm) {
    self.var_424c161e = 1;
    return;
  }

  self.var_cad44cf2 = weapon;
  self.var_424c161e = 0;
}

function_46159bb7(a_s_valid_respawn_points) {
  if(level flag::get(#"hash_7943879f3be8ccc6")) {
    return a_s_valid_respawn_points;
  }

  var_65c6fc29 = array("zone_river_upper", "zone_river_lower", "zone_cliff_tombs_upper", "zone_cliff_tombs_center", "zone_cliff_tombs_forge", "zone_cliff_tombs_lower", "zone_serpent_pass_upper", "zone_serpent_pass_center", "zone_serpent_pass_lower", "zone_serpent_pass_bridge", "zone_drakaina_arena", "zone_cliff_tombs_bridge");
  a_s_respawn_points = arraycopy(a_s_valid_respawn_points);

  foreach(s_respawn_point in a_s_valid_respawn_points) {
    if(isinarray(var_65c6fc29, s_respawn_point.script_noteworthy)) {
      arrayremovevalue(a_s_respawn_points, s_respawn_point);
    }
  }

  return a_s_respawn_points;
}

function_598a6222() {
  vol_amphitheater = getent("vol_power_quest_kill_zone", "targetname");

  if(isDefined(vol_amphitheater) && self istouching(vol_amphitheater) && !level flag::get(#"hash_3dba794053dea40e")) {
    return false;
  }

  if(self flag::exists(#"hash_3247dad158e8b329") && self flag::get(#"hash_3247dad158e8b329")) {
    return false;
  }

  return true;
}

function_d4ff1dd6(waitresult) {
  if(waitresult.activator.health <= 0) {
    iprintlnbold("<dev string:x51>" + waitresult.activator.origin);
  }
}

  function function_c02e63(var_2753f06a) {
    wait 1;

    if(!isDefined(level.host)) {
      return false;
    }

    str_host = level.host zm_vo::function_82f9bc9f();

    if(getplayers().size === 1) {
      switch (var_2753f06a) {
        case 0:
          if(str_host == "brun") {
            level.host zm_vo::vo_say(#"hash_6d9e1d549cc1b3ba", undefined, undefined, undefined, undefined, 1);
            level.host zm_vo::vo_say(#"hash_72533b3d4278425d", 0.5);
          } else {
            level.host zm_vo::function_a2bd5a0c(#"vox_solo_game_start_" + str_host, 0, 1);
          }

          break;
        case 1:
          if(str_host == "brun") {
            level.host zm_vo::vo_say(#"hash_6f1df3b4e6354472", 0.5);
            level.host zm_vo::vo_say(#"hash_31a9fb6be6fe1013", undefined, undefined, undefined, undefined, 1);
          } else {
            level.host zm_vo::function_a2bd5a0c(#"vox_solo_end_round1_" + str_host, 0, 1);
          }

          break;
        case 2:
          if(str_host == "brun") {
            level.host zm_vo::vo_say(#"hash_166f0f941a5b1e45", 0.5);
            level.host zm_vo::vo_say(#"hash_2c81ea0c696b6232", undefined, undefined, undefined, undefined, 1);
          } else {
            level.host zm_vo::function_a2bd5a0c(#"vox_solo_end_round2_" + str_host, 0, 1);
          }

          break;
      }
    } else {
      switch (var_2753f06a) {
        case 0:
          if(str_host == "brun") {
            level.host zm_vo::vo_say(#"hash_54180fda77534ccd", undefined, undefined, undefined, undefined, 1);
            level.host zm_vo::function_a2bd5a0c(#"hash_3d803349cfe68c13", 0.5);
          } else {
            level.host zm_vo::function_a2bd5a0c(#"hash_4c0be2bb6d0c80b0" + str_host);
          }

          break;
        case 1:
          switch (str_host) {
            case #"scar":
              level.host zm_vo::vo_say(#"hash_1da6407e4cd932bf");
              break;
            case #"dieg":
              level.host zm_vo::vo_say(#"hash_1cdc8a3e02fcfce3");
              break;
            case #"brun":
              level.host zm_vo::vo_say(#"hash_590040ddc7032e94");
              break;
            case #"shaw":
              level.host zm_vo::vo_say(#"hash_7f40dc2d71347256");
              break;
          }

          break;
        case 2:
          switch (str_host) {
            case #"scar":
              level.host zm_vo::vo_say(#"hash_6c4dee81df419edc");
              break;
            case #"dieg":
              level.host zm_vo::vo_say(#"hash_24d7b7428867b4f0");
              break;
            case #"brun":
              level.host zm_vo::vo_say(#"hash_42880967b7a32953");
              break;
            case #"shaw":
              level.host zm_vo::vo_say(#"hash_5fb3938045de5389");
              break;
          }

          break;
        case 3:
          switch (str_host) {
            case #"scar":
              level.host zm_vo::vo_say(#"hash_394a9cfe79112d79");
              break;
            case #"dieg":
              level.host zm_vo::vo_say(#"hash_2abbc74b0d21d3f9");
              break;
            case #"brun":
              level.host zm_vo::vo_say(#"hash_171f4130f28f8812");
              break;
            case #"shaw":
              level.host zm_vo::vo_say(#"hash_7db0de42b6aa9784");
              break;
          }

          break;
      }

      level thread function_b35c3e0b(str_host, var_2753f06a);
    }

    return true;
  }

function_b35c3e0b(str_host, n_index) {
  a_players = util::get_active_players();
  var_9103f439 = [];

  if(isDefined(a_players) && a_players.size > 1) {
    foreach(player in a_players) {
      if(player zm_vo::function_82f9bc9f() != str_host) {
        var_9103f439[var_9103f439.size] = player;
      }
    }

    player = array::random(var_9103f439);

    if(isDefined(player)) {
      player zm_vo::function_a2bd5a0c(#"hash_71bde3a512edb440" + n_index + "_" + str_host, 0.5);
    }
  }
}

function_7edd912b(var_2753f06a) {}

function_7722c6f0(var_404e4288, var_8dd554ee) {
  if(math::cointoss()) {
    var_6095c0b6 = zm_round_logic::function_4e8157cd(var_404e4288, var_8dd554ee);

    if(isalive(var_6095c0b6.ai_spawned)) {
      zm_transform::function_d2374144(var_6095c0b6.ai_spawned, #"blight_father");
    }
  } else {
    ai = zombie_gegenees_util::spawn_single(1);

    if(isDefined(ai)) {
      ai.ignore_enemy_count = 0;
      level.zombie_total--;
    }
  }

  return true;
}

function_c8ce0a17(var_404e4288, var_8dd554ee) {
  if(math::cointoss()) {
    var_6095c0b6 = zm_round_logic::function_4e8157cd(var_404e4288, var_8dd554ee);

    if(isalive(var_6095c0b6.ai_spawned)) {
      zm_transform::function_d2374144(var_6095c0b6.ai_spawned, array::random(array(#"catalyst_corrosive", #"catalyst_electric", #"catalyst_plasma", #"catalyst_water")));
    }
  } else {
    var_862206ea = zombie_skeleton_util::function_1ea880bd(1);

    if(isDefined(var_862206ea)) {
      level.zombie_total--;
    }
  }

  return true;
}

function_338bae81(e_player) {
  if(!isDefined(e_player.var_4674988e)) {
    e_player.var_4674988e = 0;
  }

  n_time = gettime() / 1000;
  dt = n_time - e_player.var_4674988e;

  if(dt > 15) {
    e_player thread zm_audio::create_and_play_dialog(#"peg_summon", #"use");
    e_player.var_4674988e = n_time;
  }
}

function_7c7c6a1(weapon) {
  if(weapon.name == #"thunderstorm") {
    self thread zm_audio::create_and_play_dialog(#"magicbox", #"peg", undefined, 1);
    return true;
  }

  return false;
}

function_443f6873(str_weapon) {
  var_a7c8ee36 = undefined;

  if(isDefined(str_weapon)) {
    switch (str_weapon) {
      case #"zhield_zpear_dw":
        var_a7c8ee36 = #"novox";
        break;
    }
  }

  return var_a7c8ee36;
}

function_fbf0e632() {
  self endon(#"powerup_timedout", #"powerup_stolen", #"death");
  self playSound(#"hash_e3e5f7c83015171");
  self playLoopSound(#"hash_2adfa98b79668366");
  waitresult = self waittill(#"powerup_grabbed");

  if(isDefined(waitresult.e_grabber) && isplayer(waitresult.e_grabber)) {
    waitresult.e_grabber playSound(#"hash_1c696244a9a3dbbf");
  }
}

function_acb5b0ec() {
  zm_devgui::add_custom_devgui_callback(&function_76dc48b8);
  adddebugcommand("<dev string:x67>");
  adddebugcommand("<dev string:xb5>");
  adddebugcommand("<dev string:x105>");
  adddebugcommand("<dev string:x162>");
  adddebugcommand("<dev string:x1bd>");
  adddebugcommand("<dev string:x232>");
  adddebugcommand("<dev string:x288>");
  adddebugcommand("<dev string:x2e0>");
  adddebugcommand("<dev string:x338>");
  adddebugcommand("<dev string:x392>");
  adddebugcommand("<dev string:x3ee>");
  adddebugcommand("<dev string:x444>");
  adddebugcommand("<dev string:x49c>");
  adddebugcommand("<dev string:x4f4>");
  adddebugcommand("<dev string:x554>");
  adddebugcommand("<dev string:x5a4>");
  adddebugcommand("<dev string:x5f2>");
  adddebugcommand("<dev string:x63e>");
  adddebugcommand("<dev string:x68c>");
  adddebugcommand("<dev string:x6f0>");
  adddebugcommand("<dev string:x754>");
  adddebugcommand("<dev string:x7b8>");
  adddebugcommand("<dev string:x818>");
  adddebugcommand("<dev string:x87c>");
  adddebugcommand("<dev string:x8e0>");
  adddebugcommand("<dev string:x944>");
  adddebugcommand("<dev string:x9a4>");
  adddebugcommand("<dev string:xa0e>");
  adddebugcommand("<dev string:xa81>");
  adddebugcommand("<dev string:xaf4>");
  adddebugcommand("<dev string:xb57>");
  adddebugcommand("<dev string:xbbe>");
  adddebugcommand("<dev string:xc29>");
  adddebugcommand("<dev string:xc90>");
  adddebugcommand("<dev string:xcff>");
  adddebugcommand("<dev string:xd64>");
  adddebugcommand("<dev string:xdd9>");
  adddebugcommand("<dev string:xe4e>");
  adddebugcommand("<dev string:xeba>");
  adddebugcommand("<dev string:xf26>");
  adddebugcommand("<dev string:xf8f>");
  adddebugcommand("<dev string:xff2>");
  adddebugcommand("<dev string:x105a>");
  adddebugcommand("<dev string:x10ba>");
  adddebugcommand("<dev string:x1120>");
  adddebugcommand("<dev string:x1181>");
  adddebugcommand("<dev string:x11d5>");
  adddebugcommand("<dev string:x1255>");
  adddebugcommand("<dev string:x12c5>");
  adddebugcommand("<dev string:x1351>");
  adddebugcommand("<dev string:x13d7>");
  adddebugcommand("<dev string:x1455>");
  adddebugcommand("<dev string:x14d8>");
  adddebugcommand("<dev string:x1559>");
  adddebugcommand("<dev string:x15e5>");
  adddebugcommand("<dev string:x1665>");
  adddebugcommand("<dev string:x16d9>");
  adddebugcommand("<dev string:x1759>");
  adddebugcommand("<dev string:x17d1>");
  adddebugcommand("<dev string:x184d>");
  adddebugcommand("<dev string:x18c3>");
  adddebugcommand("<dev string:x1933>");
  adddebugcommand("<dev string:x19a3>");
  adddebugcommand("<dev string:x1a11>");
  adddebugcommand("<dev string:x1a8f>");
  adddebugcommand("<dev string:x1b07>");
  adddebugcommand("<dev string:x1b7a>");
  adddebugcommand("<dev string:x1bf0>");
  adddebugcommand("<dev string:x1c5d>");
  adddebugcommand("<dev string:x1cc4>");
  adddebugcommand("<dev string:x1d2b>");
  adddebugcommand("<dev string:x1d92>");
  adddebugcommand("<dev string:x1df9>");
  adddebugcommand("<dev string:x1e6a>");
  adddebugcommand("<dev string:x1ecd>");
  adddebugcommand("<dev string:x1f30>");

  if(zm_utility::is_ee_enabled()) {
    adddebugcommand("<dev string:x1f93>");
    adddebugcommand("<dev string:x1ff0>");
    adddebugcommand("<dev string:x2040>");
    adddebugcommand("<dev string:x208a>");
    adddebugcommand("<dev string:x20d2>");
    adddebugcommand("<dev string:x211a>");
    adddebugcommand("<dev string:x2162>");
    adddebugcommand("<dev string:x21aa>");
    adddebugcommand("<dev string:x21ec>");
    adddebugcommand("<dev string:x2261>");
    adddebugcommand("<dev string:x22e9>");
    adddebugcommand("<dev string:x236a>");
    adddebugcommand("<dev string:x23e2>");
    adddebugcommand("<dev string:x244a>");
  }
}

function_76dc48b8(cmd) {
  switch (cmd) {
    case #"hash_6eb30455e9df06a1":
      level thread function_71a6c3ea();
      function_eeb6a1e7();
      scene::add_scene_func("<dev string:x24be>", &function_5b984671, "<dev string:x24d8>");
      scene::add_scene_func("<dev string:x24be>", &function_ea8d45ef, "<dev string:x24df>");
      scene::play("<dev string:x24be>");
      return 1;
    case #"hash_6eb30155e9df0188":
      level thread function_71a6c3ea();
      function_eeb6a1e7();
      scene::add_scene_func("<dev string:x24e6>", &function_75ef7b1f, "<dev string:x24d8>");
      scene::add_scene_func("<dev string:x24e6>", &function_ea8d45ef, "<dev string:x24df>");
      scene::play("<dev string:x24e6>");
      return 1;
    case #"hash_6eb30255e9df033b":
      level thread function_71a6c3ea();
      function_eeb6a1e7();
      scene::add_scene_func("<dev string:x2506>", &function_883a1fb8, "<dev string:x24d8>");
      scene::add_scene_func("<dev string:x2506>", &function_ea8d45ef, "<dev string:x24df>");
      scene::play("<dev string:x2506>");
      return 1;
    case #"hash_6eb30755e9df0bba":
      level thread function_71a6c3ea();
      function_eeb6a1e7();
      scene::play("<dev string:x2526>");
      return 1;
    case #"play_all":
      level.var_7652563c = 1;
      function_eeb6a1e7();
      level thread play_outro();
      return 1;
    case #"hash_50d92ca3c6c7c2a8":
      level thread function_71a6c3ea();
      return 1;
    case #"enable_cave_zone":
      level thread function_f39d0796();
      return 1;
    case #"hash_4abb72859ec9576c":
      level thread function_3594d78b();
      break;
    case #"hash_2f2a0c012b9587d3":
      level thread function_590ce3bd();
      break;
    case #"hash_23e8dfb7c173d426":
      level thread function_80b73b4();
      break;
    case #"hash_661d906e81e681a0":
      level thread function_313ff13();
      return 1;
    case #"spawn_pegasus":
      level thread spawn_pegasus();
      return 1;
    case #"ride_pegasus":
      level thread ride_pegasus();
      return 1;
    case #"free_eagles":
      level thread free_eagles();
      return 1;
    case #"complete_pap":
      level thread complete_pap();
      return 1;
    case #"hash_6429644808eb1a0e":
      level thread zm_red_ww_quests::function_9dc3d269();
      return 1;
    case #"hash_137588aac1c5e8a4":
      level thread zm_red_ww_quests::function_34c06bf9();
      return 1;
    case #"hash_78f0de868a955048":
      level thread zm_red_ww_quests::function_e3a8b066(#"light");
      return 1;
    case #"hash_76f44a33d967751a":
      level thread zm_red_ww_quests::function_e3a8b066(#"death");
      return 1;
    case #"hash_76a546919ae7f290":
      level thread zm_red_ww_quests::function_e3a8b066(#"earth");
      return 1;
    case #"hash_6ad4284ef1b3e750":
      level thread zm_red_ww_quests::function_e3a8b066(#"air");
      return 1;
    case #"hash_3e4ac36ee130ef3c":
      level thread zm_red_ww_quests::function_51a8e408(#"light");
      return 1;
    case #"hash_5890d948dcfe86a6":
      level thread zm_red_ww_quests::function_51a8e408(#"death");
      return 1;
    case #"hash_3b720308ca9b47d4":
      level thread zm_red_ww_quests::function_51a8e408(#"earth");
      return 1;
    case #"hash_651e411e90da7f94":
      level thread zm_red_ww_quests::function_51a8e408(#"air");
      return 1;
    case #"hash_182705f03ec3d976":
      level thread zm_red_ww_quests::function_f241b684();
      return 1;
    case #"hash_4fa27fb98665fe3a":
      level thread zm_red_ww_quests::function_6bf10cf9();
      return 1;
    case #"hash_170c2110b1de2872":
      level thread zm_red_ww_quests::function_11a0f6f8();
      return 1;
    case #"hash_290820a2a3f4b0b9":
      level thread zm_red_ww_quests::function_c5d7d69b();
      return 1;
    case #"hash_16ca21dc88e8049b":
      level thread zm_red_ww_quests::function_681ce100();
      return 1;
    case #"hash_4cd02ce602240df9":
      level thread zm_red_ww_quests::function_9fe8bfeb();
      return 1;
    case #"hash_4135904306940f66":
      level thread zm_red_ww_quests::function_dcfed198();
      return 1;
    case #"hash_5b980405c2fb2366":
      level thread zm_red_ww_quests::function_d6e30032();
      return 1;
    case #"hash_566accf8fdcd834c":
      level thread zm_red_ww_quests::function_ec9bf2a();
      return 1;
    case #"hash_655e705781bfd2af":
      level thread zm_red_ww_quests::function_30ecec0c();
      return 1;
    case #"hash_eef0c3bf29481cd":
      level thread zm_red_ww_quests::function_a5efeb8d();
      return 1;
    case #"hash_fea23dfe07cc931":
      level thread zm_red_ww_quests::function_4594e669();
      return 1;
    case #"hash_2f8409a9af0b7b4b":
      level thread zm_red_ww_quests::function_b8b8845();
      return 1;
    case #"hash_52a251650604890f":
      level thread zm_red_ww_quests::function_318c3039();
      return 1;
    case #"hash_71a15c94ec8d4c2a":
      level thread zm_red_ww_quests::function_37deb555();
      return 1;
    case #"hash_3046318853a1f0f9":
      level thread zm_red_ww_quests::function_d8765f3d();
      return 1;
    case #"hash_6540cece460115d8":
      level thread zm_red_ww_quests::function_233156e3();
      return 1;
    case #"hash_46ef6728b784e895":
      level thread zm_red_ww_quests::function_c4614158();
      return 1;
    case #"hash_15fba8108df788e7":
      level thread zm_red_ww_quests::function_d963daa9();
      return 1;
    case #"hash_522749387ee44839":
      level thread zm_red_ww_quests::function_405e6a83();
      return 1;
    case #"hash_5e2fc595f8d3d7bd":
      level thread zm_red_power_quest::devgui_complete();
      return 1;
    case #"hash_55435ba74ce9b712":
      level.var_656c1a37 = 0;
      level thread zm_red_challenges::start_challenge();
      break;
    case #"hash_71fe4179fafd7f3":
      level.var_656c1a37 = 11;
      level thread zm_red_challenges::start_challenge();
      break;
    case #"hash_6ae2b92946638ba0":
      level.var_656c1a37 = 1;
      level.var_4427ebb1 = zm_red_challenges::function_49e4f4ca(level.var_656c1a37);
      level thread zm_red_challenges::start_challenge();
      break;
    case #"hash_3b5e1577a3ac05f9":
      level.var_656c1a37 = 2;
      level.var_4427ebb1 = zm_red_challenges::function_49e4f4ca(level.var_656c1a37);
      level thread zm_red_challenges::start_challenge();
      break;
    case #"hash_72ef3034042f03e2":
      level.var_656c1a37 = 3;
      level.var_4427ebb1 = zm_red_challenges::function_49e4f4ca(level.var_656c1a37);
      level thread zm_red_challenges::start_challenge();
      break;
    case #"hash_3bc45b4ec610c6ea":
      level.var_656c1a37 = 4;
      level.var_4427ebb1 = zm_red_challenges::function_49e4f4ca(level.var_656c1a37);
      level thread zm_red_challenges::start_challenge();
      break;
    case #"hash_53ee2bdf0d2847c4":
      level.var_656c1a37 = 5;
      level.var_4427ebb1 = zm_red_challenges::function_49e4f4ca(level.var_656c1a37);
      level thread zm_red_challenges::start_challenge();
      break;
    case #"hash_2915d280a9091d5d":
      level.var_656c1a37 = 6;
      level.var_4427ebb1 = zm_red_challenges::function_49e4f4ca(level.var_656c1a37);
      level thread zm_red_challenges::start_challenge();
      break;
    case #"hash_38eb67ea5f4036f3":
      level.var_656c1a37 = 7;
      level.var_4427ebb1 = zm_red_challenges::function_49e4f4ca(level.var_656c1a37);
      level thread zm_red_challenges::start_challenge();
      break;
    case #"hash_555ae35b6c19f641":
      level.var_656c1a37 = 13;
      level thread zm_red_challenges::start_challenge();
      break;
    case #"hash_2cc5d2651dded199":
      level.var_656c1a37 = 10;
      level thread zm_red_challenges::start_challenge();
      break;
    case #"hash_7629cafaf2e465e3":
      level.var_656c1a37 = 9;
      level thread zm_red_challenges::start_challenge();
      break;
    case #"hash_368aef09ae7ed576":
      level.var_656c1a37 = 12;
      level thread zm_red_challenges::start_challenge();
      break;
    case #"hash_2e0e00c6ad36186f":
      level.var_656c1a37 = 8;
      level thread zm_red_challenges::start_challenge();
      break;
    case #"hash_359525c5c273d324":
      level.var_656c1a37 = 14;
      level thread zm_red_challenges::start_challenge();
      break;
    case #"hash_8cff6d431ab1efe":
      level.var_656c1a37 = 15;
      level thread zm_red_challenges::start_challenge();
      break;
    case #"hash_45c7d33388c20473":
      level.var_656c1a37 = 16;
      level thread zm_red_challenges::start_challenge();
      break;
    case #"hash_6d8584607d816e70":
      level.var_656c1a37 = 17;
      level thread zm_red_challenges::start_challenge();
      break;
    case #"hash_7768dba8fad5836b":
      level.var_656c1a37 = 18;
      level thread zm_red_challenges::start_challenge();
      break;
    case #"hash_2793bc8d461b411":
      level.var_656c1a37 = 19;
      level thread zm_red_challenges::start_challenge();
      break;
    case #"hash_1d8f7ff87b40f80f":
      level.var_656c1a37 = 20;
      level thread zm_red_challenges::start_challenge();
      break;
    case #"hash_2eba8518b711ac1":
      foreach(player in getplayers()) {
        player function_7c8b5f27();
      }

      break;
    case #"hash_73599762d232fa70":
      e_player = getplayers()[0];
      e_player function_7c8b5f27();
      break;
    case #"hash_46d64f2b7aa21161":
      a_players = getplayers();

      if(a_players.size >= 2) {
        a_players[1] function_7c8b5f27();
      }

      break;
    case #"hash_4ae61e7d270a0f16":
      a_players = getplayers();

      if(a_players.size >= 3) {
        a_players[2] function_7c8b5f27();
      }

      break;
    case #"hash_580b4b8b0d03657f":
      a_players = getplayers();

      if(a_players.size >= 4) {
        a_players[3] function_7c8b5f27();
      }

      break;
    case #"challenge_phase_1":
      level.var_6e5099bb = 1;
      iprintlnbold("<dev string:x2546>");
      break;
    case #"challenge_phase_2":
      level.var_6e5099bb = 2;
      iprintlnbold("<dev string:x2565>");
      break;
    case #"challenge_phase_3":
      level.var_6e5099bb = 3;
      iprintlnbold("<dev string:x2584>");
      break;
    case #"hash_7a9bab3c50ff294d":
      level flag::set("<dev string:x25a3>");
      break;
    case #"hash_e3eb39f2ce05aff":
      level thread zm_red_main_quest::function_69e1a1fc();
      break;
    case #"hash_6fa14c9cc4ed8317":
      level thread function_bb5a8b5e(0);
      break;
    case #"hash_1226dc3756e1cbe4":
      level thread function_bb5a8b5e(1);
      break;
    case #"ignite_shield":
      level thread zm_red_main_quest::function_25bb4829(0);
      break;
    case #"greek_fire":
      level thread zm_red_main_quest::function_25bb4829(1);
      break;
    case #"hash_4e0fd48904ba6582":
      foreach(player in getplayers()) {
        player.var_6a885e6e = 0;
        player.s_boons[0].b_available = 1;
        player.s_boons[1].b_available = 1;
        player.s_boons[2].b_available = 1;
        player.s_boons[3].b_available = 1;
        player.s_boons[4].b_available = 1;
        player.s_boons[5].b_available = 1;
        player.s_boons[6].b_available = 1;
      }

      break;
    case #"hash_7bf7f5b60c83cf1f":
      foreach(player in getplayers()) {
        player.var_6a885e6e = 0;
        player.s_boons[0].b_available = 1;
      }

      break;
    case #"hash_66233ad30c165ffd":
      foreach(player in getplayers()) {
        player.var_6a885e6e = 0;
        player.s_boons[1].b_available = 1;
      }

      break;
    case #"hash_5151955e310b4ba3":
      foreach(player in getplayers()) {
        player.var_6a885e6e = 0;
        player.s_boons[2].b_available = 1;
      }

      break;
    case #"hash_382a97b59a98fb71":
      foreach(player in getplayers()) {
        player.var_6a885e6e = 0;
        player.s_boons[3].b_available = 1;
      }

      break;
    case #"hash_5e97858955d10c64":
      foreach(player in getplayers()) {
        player.var_6a885e6e = 0;
        player.s_boons[4].b_available = 1;
      }

      break;
    case #"hash_5176fcfc9d31845d":
      foreach(player in getplayers()) {
        player.var_6a885e6e = 0;
        player.s_boons[5].b_available = 1;
      }

      break;
    case #"hash_6b98535cc00fb057":
      foreach(player in getplayers()) {
        player.var_6a885e6e = 0;
        player.s_boons[6].b_available = 1;
      }

      break;
    case #"hash_6502e8f99bd18fcd":
      level thread zm_red_util::function_a94baf7b();
      return 1;
  }
}

function_7c8b5f27() {
  if(level flag::get("<dev string:x25b8>")) {
    n_amount = level.var_8b7ab859 / 4;
    self zm_red_challenges_rewards::function_53a333a8(undefined, n_amount);
  }
}

function_71a6c3ea() {
  zm_devgui::zombie_devgui_open_sesame();
  scene::init("<dev string:x25c3>");
  level complete_pap();
}

function_313ff13() {
  if(isDefined(level.var_c89378af)) {
    level.var_c89378af hide();
  }

  level flag::set(#"hash_3764b0cb106568ec");
}

spawn_pegasus() {
  level flag::set(#"hash_3dba794053dea40e");
  level flag::set("<dev string:x25b8>");
}

ride_pegasus() {
  level flag::set(#"hash_3764b0cb106568ec");
  level flag::set(#"hash_3dba794053dea40e");
  level flag::set("<dev string:x25b8>");
  level flag::set(#"hash_32ff7a456732ef09");
  level flag::set(#"hash_1b6616e730b1235b");
  level flag::set(#"pegasus_exited");
  level scene::init("<dev string:x25c3>");
  zm_devgui::zombie_devgui_open_sesame();
  level zm_utility::function_9ad5aeb1(1);
  s_ride = struct::get("<dev string:x25e6>");
  a_players = getplayers();

  foreach(player in a_players) {
    player setorigin(s_ride.origin + (randomintrange(-16, 16), randomintrange(-16, 16), 0));
  }

  wait 1;
}

free_eagles() {
  level flag::set(#"hash_3764b0cb106568ec");
  level flag::set(#"hash_3dba794053dea40e");
  level flag::set("<dev string:x25b8>");
  level flag::set(#"hash_32ff7a456732ef09");
  level flag::set(#"hash_1b6616e730b1235b");
  level scene::init("<dev string:x25c3>");
  zm_devgui::zombie_devgui_open_sesame();
  level zm_utility::function_9ad5aeb1(1);
  wait 1;
  level flag::set(#"hash_4083e9da0ba41dec");
  var_ff91be3a = struct::get_array("<dev string:x25fb>", "<dev string:x44>");
  var_a10268d3 = level.players;

  for(i = 0; i < var_a10268d3.size; i++) {
    var_a10268d3[i] setorigin(var_ff91be3a[i].origin);
    var_a10268d3[i] setplayerangles(var_ff91be3a[i].angles);
  }

  level thread zm_red_pap_quest::function_a2b76316();
  level thread zm_red_pap_quest::function_5a4d8124();
  level flag::set(#"cage_dropped");
  level flag::set(#"eagle_attack");
  level flag::set(#"hash_67695ee69c57c0b2");
  level flag::set(#"hash_61de3b8fe6f6a35");
}

complete_pap() {
  level.b_skip = 1;

  if(isDefined(level.var_c89378af)) {
    level.var_c89378af delete();
  }

  level flag::set(#"hash_3764b0cb106568ec");
  level flag::set(#"hash_3dba794053dea40e");
  level flag::set("<dev string:x25b8>");
  level flag::set(#"hash_32ff7a456732ef09");
  level flag::set(#"hash_4083e9da0ba41dec");
  level flag::set(#"pap_quest_completed");
  level flag::set(#"zm_red_fasttravel_open");
  level flag::set(#"cage_dropped");
  level flag::set(#"hash_67695ee69c57c0b2");
  level flag::set(#"hash_61de3b8fe6f6a35");
  level flag::set(#"hash_7943879f3be8ccc6");
  level thread zm_red_power_quest::devgui_complete();
  level thread scene::play(#"p8_fxanim_zm_red_omphalos_crystal_left_bundle", "<dev string:x260e>");
  level thread scene::play(#"p8_fxanim_zm_red_omphalos_crystal_front_bundle", "<dev string:x260e>");
  level thread scene::play(#"p8_fxanim_zm_red_omphalos_crystal_right_bundle", "<dev string:x260e>");
  level thread scene::play(#"p8_fxanim_zm_red_omphalos_crystal_left_bundle", "<dev string:x2618>");
  level thread scene::play(#"p8_fxanim_zm_red_omphalos_crystal_front_bundle", "<dev string:x2618>");
  level thread scene::play(#"p8_fxanim_zm_red_omphalos_crystal_right_bundle", "<dev string:x2618>");
  level thread scene::play(#"p8_fxanim_zm_red_omphalos_crystal_left_bundle", "<dev string:x2622>");
  level thread scene::play(#"p8_fxanim_zm_red_omphalos_crystal_front_bundle", "<dev string:x2622>");
  level scene::play(#"p8_fxanim_zm_red_omphalos_crystal_right_bundle", "<dev string:x2622>");
  var_6800d950 = getent("<dev string:x262c>", "<dev string:x44>");

  if(isDefined(var_6800d950)) {
    var_6800d950 delete();
  }

  level flag::set(#"eagle_attack");
  level flag::set(#"egg_free");
}

function_f39d0796() {
  level flag::set(#"hash_4083e9da0ba41dec");
}

function_3594d78b() {
  zombie_gegenees_util::spawn_single(1);
}

function_590ce3bd() {
  zombie_skeleton_util::function_1ea880bd(1);
}

function_80b73b4() {
  self notify("<dev string:x263d>");
  self endon("<dev string:x263d>");

  if(getdvarint(#"hash_49d01fe7f6492094", 0) == 0) {
    setdvar(#"hash_49d01fe7f6492094", 1);
  } else {
    setdvar(#"hash_49d01fe7f6492094", 0);
    return;
  }

  while(getdvarint(#"hash_49d01fe7f6492094", 0)) {
    function_e8760afa(level.zm_loc_types[#"zombie_location"]);
    function_e8760afa(level.zm_loc_types[#"gegenees_location"]);
    function_e8760afa(level.zm_loc_types[#"blight_father_location"]);
    waitframe(1);
  }
}

function_e8760afa(a_s_locs) {
  foreach(s_loc in a_s_locs) {
    var_91d1913b = distance2d(level.players[0].origin, s_loc.origin);
    n_radius = 0.015 * var_91d1913b;

    if(n_radius > 768) {
      n_radius = 768;
    }

    if(var_91d1913b > 64 && var_91d1913b < 2000) {
      sphere(s_loc.origin, n_radius, (0, 0, 1), 1, 0, 10, 1);
      print3d(s_loc.origin + (0, 0, 24), s_loc.script_noteworthy, (0, 0, 1), 1, 1, 1);
    }
  }
}

function_bb5a8b5e(b_charged) {
  if(b_charged) {
    a_w_ww = array(level.w_hand_charon, level.w_hand_gaia, level.w_hand_ouranos, level.w_hand_hemera);
  } else {
    a_w_ww = array(level.w_hand_charon_uncharged, level.w_hand_gaia_uncharged, level.w_hand_ouranos_uncharged, level.w_hand_hemera_uncharged);
  }

  a_w_ww = array::randomize(a_w_ww);

  foreach(i, e_player in getplayers()) {
    var_3ba4bf7d = e_player getweaponslistprimaries();

    if(var_3ba4bf7d.size > 1) {
      w_current = e_player getcurrentweapon();

      if(isDefined(w_current) && isinarray(var_3ba4bf7d, w_current)) {
        e_player takeweapon(w_current);
      } else {
        return;
      }
    }

    w_ww = a_w_ww[i];
    e_player giveweapon(w_ww);
    e_player switchtoweaponimmediate(w_ww, 1);
  }
}

