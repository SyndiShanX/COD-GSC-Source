/**********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_dwn_twn\objectives\cp_vault_assault.gsc
**********************************************************************/

function main() {
  level.vault_assault_objective_func = &register_vault_assault_objectives;

  if(!isDefined(level.should_run_event_func)) {
    level.should_run_event_func = &should_run_event;
  }

  if(!isDefined(level.ambientgroupinit)) {
    level.ambientgroupinit = &setup_module_groups;
  }

  level._effect["hvt_cig"] = loadfx("vfx/iw8_cp/vfx_cigarette_lit_hand_htv.vfx");
  level._effect["cig_hit"] = loadfx("vfx/iw8_cp/prop/vfx_cigarette_window_hit.vfx");
  level._effect["pc_break"] = loadfx("vfx/iw8/prop/scriptables/vfx_computer_pc_tower_01_debris.vfx");
  level._effect["vfx_gen_c4_exp2_ch"] = loadfx("vfx/iw8_mp/equipment/c4/vfx_gen_c4_exp2_ch.vfx");
  scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_heli_boss::heli_boss_precache();
  level thread scripts\cp\cp_remote_tank::init_remote_tank();
  level.bank_elevator = "third";
  level.key_card_acquired = 0;
  level.ref_12fc3 = 0;
  level.disable_hvt_pickup = &lbravo_spawner_jammer2;
  level.ref_1247c = &ref_13f05;
  scripts\engine\utility::flag_init("hvt_gone");
  scripts\engine\utility::flag_init("heli_engage");
  scripts\engine\utility::flag_init("bank_roof_mortar_start");
  scripts\engine\utility::flag_init("roof_elevator_open");
  scripts\engine\utility::flag_init("stair_doors_init");
  scripts\engine\utility::flag_init("init_roof_combat");
  scripts\engine\utility::flag_init("va_spawn_modules_registered");
  scripts\engine\utility::flag_init("activate_wheelsons");
  scripts\engine\utility::flag_init("saws_have_been_used");
  scripts\engine\utility::flag_init("activate_door_cut");
  scripts\cp\maps\cp_dwn_twn\cp_dwn_twn_door_cut::door_cut_precache();
  scripts\cp\cp_breach_c4::main();
  thread init_cs_ents();
}

function init_cs_ents() {
  level endon("game_ended");

  if(!scripts\engine\utility::flag_exist("cp_dwn_twn_create_script_completed")) {
    scripts\engine\utility::flag_init("cp_dwn_twn_create_script_completed");
  }

  scripts\engine\utility::flag_wait("cp_dwn_twn_create_script_completed");

  if(!scripts\engine\utility::flag_exist("cp_dwn_twn_bank_vehicle_create_script_completed")) {
    scripts\engine\utility::flag_init("cp_dwn_twn_bank_vehicle_create_script_completed");
  }

  scripts\engine\utility::flag_wait("cp_dwn_twn_bank_vehicle_create_script_completed");
  thread init_vault_door();
  var_0 = getEnt("hvt_door_clip", "targetname");
  var_0 disconnectPaths();
  thread remove_extra_structs();
  var_1 = scripts\engine\utility::getStructArray("bank_roof_munition_remove", "targetname");

  foreach(var_3 in var_1) {
    level thread scripts\cp\cp_munitions::ref_12be1(var_3.origin, 200);
  }

  level.rooftop_1_mortar = getEnt("bank_rooftop_1_mortar", "targetname");
  level.rooftop_2_mortar = getEnt("bank_rooftop_2_mortar", "targetname");
  level.rooftop_3_mortar = getEnt("bank_rooftop_3_mortar", "targetname");
  level.rooftop_1_mortar hidepart("j_mortar_shell", "misc_wm_mortar");
  level.rooftop_2_mortar hidepart("j_mortar_shell", "misc_wm_mortar");
  level.rooftop_3_mortar hidepart("j_mortar_shell", "misc_wm_mortar");
}

function lbravo_spawner_jammer2(var_0) {
  var_1 = var_0.player;
  var_2 = 0;
  var_3 = var_0.stepstructs.size;
  var_4 = 90000;
  objective_setplayintro(var_0.id, 0);

  for(var_5 = var_3 - 1; var_5 >= var_2; var_5--) {
    if(var_5 > 0) {
      var_6 = distancesquared(var_1.origin, var_0.stepstructs[var_5]);
      var_7 = distancesquared(var_0.stepstructs[var_5], var_0.stepstructs[var_5 - 1]);

      if(var_6 < var_7) {
        var_8 = var_0.stepstructs[var_5][2] + 50;
        var_9 = var_0.stepstructs[var_5 - 1][2] - 50;

        if(var_1.origin[2] <= var_8 && var_1.origin[2] >= var_9) {
          return var_5;
        }

        var_8 = var_0.stepstructs[var_5 - 1][2] + 50;
        var_9 = var_0.stepstructs[var_5][2] - 50;

        if(var_1.origin[2] <= var_8 && var_1.origin[2] >= var_9) {
          return var_5;
        }
      }
    }
  }

  return 0;
}

function create_stair_doors() {
  wait 5;
  level.bank_stair_doors = [];
  level.bank_stair_doors_clip = [];
  var_0 = ["stair_door_2", "stair_door_3", "stair_door_roof", "stair_door_2_2", "stair_door_3_2", "stair_door_1_2", "stair_door_5_2", "stair_door_roof_2"];

  foreach(var_2 in var_0) {
    create_door(var_2);
    wait 0.1;
  }

  scripts\engine\utility::flag_set("stair_doors_init");
}

function create_door(var_0) {
  var_1 = getEntArray("clip64x64x8", "targetname");
  var_2 = var_1[0];
  var_3 = scripts\engine\utility::getStructArray(var_0, "targetname");
  var_4 = var_3[0];

  if(isDefined(var_4)) {
    var_5 = spawn("script_model", var_4.origin);
    var_5.angles = var_4.angles;
    wait 0.1;
    var_5 setModel("door_metal_double_b_l_02_grey");
    var_5.open_ang = (0, 105, 0);
    level.bank_stair_doors[var_0] = var_5;

    if(isDefined(var_2)) {
      var_6 = scripts\engine\utility::getStructArray(var_0 + "_clip", "targetname");
      var_7 = var_6[0];
      var_8 = spawn("script_model", var_7.origin);
      var_8.angles = var_7.angles;
      var_8 clonebrushmodeltoscriptmodel(var_2);
      var_8 disconnectPaths();
      level.bank_stair_doors_clip[var_0] = var_8;
      return;
    }

    return;
  }
}

function create_door_clip() {
  wait 5;
  level.bank_roof_doors_clip = [];
  var_0 = scripts\engine\utility::getStructArray("bank_door_roof_clip", "targetname");
  var_1 = getEntArray("clip128x128x128", "targetname");
  var_2 = var_1[0];
  var_3 = "scriptable_scriptable_door_metal_single_b_02_grey";
  var_4 = getentitylessscriptablearrayinradius(var_3, "classname");

  foreach(var_6 in var_4) {
    var_6 setscriptablepartstate("door", "unusable");
  }

  foreach(var_9 in var_0) {
    var_10 = spawn("script_model", var_9.origin);
    var_10.angles = var_9.angles;
    var_10 clonebrushmodeltoscriptmodel(var_2);
    var_10 disconnectPaths();
    level.bank_roof_doors_clip[level.bank_roof_doors_clip.size] = var_10;
  }
}

function connect_doorway_paths() {
  if(scripts\engine\utility::flag_exist("create_script_initialized")) {
    scripts\engine\utility::flag_wait("create_script_initialized");
  }

  var_0 = ["top_floor_stair_door_clip_2", "second_floor_stair_door_clip_2", "top_floor_stair_door_clip_1", "second_floor_stair_door_clip_1"];

  foreach(var_2 in var_0) {
    var_3 = getEnt(var_2, "targetname");

    if(isDefined(var_3)) {
      var_3 connectpaths();
      var_3 notsolid();
    }

    wait 0.1;
  }
}

function prox_open_door(var_0) {
  var_1 = level.bank_stair_doors[var_0];

  for(;;) {
    if(distance(level.players[0].origin, var_1.origin) < 100) {
      open_door(var_0);
      return;
    }

    wait 0.1;
  }
}

function open_door(var_0) {
  var_1 = level.bank_stair_doors[var_0];
  var_2 = level.bank_stair_doors_clip[var_0];
  var_1 rotateTo(var_1.angles + var_1.open_ang, 0.25);

  if(isDefined(var_2)) {
    var_2 connectpaths();
    var_2 notsolid();
    return;
  }
}

function remove_extra_structs() {
  if(level.struct_class_names["targetname"]["player_exfil"].size > 1) {
    var_0 = level.struct_class_names["targetname"]["player_exfil"][0];

    for(var_1 = 0; var_1 < level.struct_class_names["targetname"]["player_exfil"].size; var_1++) {
      if(isDefined(level.struct_class_names["targetname"]["player_exfil"][var_1].classname_mp)) {
        var_0 = level.struct_class_names["targetname"]["player_exfil"][var_1];
      }
    }

    level.struct_class_names["targetname"]["player_exfil"] = [];
    level.struct_class_names["targetname"]["player_exfil"][0] = var_0;
    return;
  }
}

function register_vault_assault_objectives() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("interactions_initialized");

  if(!istrue(level.vault_assault_objectives_registered)) {
    level.vault_assault_objectives_registered = 1;
  } else {
    return;
  }

  scripts\cp\cp_objectives::registerobjective("vault_assault_retrieve_saw", &team_planted_bomb, &ref_13829, &hiding_munitions_purchase, &debugbeatobjective, &isshuttingdown);
  scripts\cp\cp_objectives::registerobjective("vault_assault", &init_vault_assault, &start_vault_assault, &end_vault_assault, &debugbeatobjective, &debug_vault_assault_obj_start);
  scripts\cp\cp_objectives::registerobjective("vault_assault_cut", &init_vault_assault_cut, &start_vault_assault_cut, &end_vault_assault_cut, &debugbeatobjective, &debug_vault_assault_cut);
  scripts\cp\cp_objectives::registerobjective("vault_assault_vault", &init_vault_assault_vault, &start_vault_assault_vault, &end_vault_assault_vault, &debugbeatobjective, &debug_vault_assault_vault);
  scripts\cp\cp_objectives::registerobjective("vault_assault_vault_fake_end", &init_vault_assault_vault_fake_end, &start_vault_assault_vault_fake_end, &end_vault_assault_vault_fake_end, &debugbeatobjective, undefined);
  scripts\cp\cp_objectives::registerobjective("vault_assault_crypto", &init_vault_assault_crypto, &start_vault_assault_crypto, &end_vault_assault_crypto, &debugbeatobjective, &debug_vault_assault_crypto);
  scripts\cp\cp_objectives::registerobjective("vault_assault_rooftop", &init_vault_assault_rooftop, &start_vault_assault_rooftop, &end_vault_assault_rooftop, &debugbeatobjective, &debug_vault_assault_roof_obj_start);
  scripts\cp\cp_objectives::registerobjective("vault_assault_rooftop_heli", &init_vault_assault_rooftop_heli, &start_vault_assault_rooftop_heli, &end_vault_assault_rooftop_heli, &debugbeatobjective, undefined);
  scripts\cp\cp_objectives::registerobjective("vault_assault_rooftop_defend", &init_vault_assault_rooftop_defend, &start_vault_assault_rooftop_defend, &end_vault_assault_rooftop_defend, &debugbeatobjective, &debug_vault_assault_roof_defend_start);
  scripts\cp\cp_objectives::registerobjective("vault_assault_rooftop_exfil", &init_vault_assault_rooftop_exfil, &start_vault_assault_rooftop_exfil, &end_vault_assault_rooftop_exfil, &debugbeatobjective, &debug_vault_assault_roof_defend_start);
  init_bank_interactions();
  spawn_functions_init();
}

function register_ml_p1_objectives() {}

function spawn_functions_init() {
  level endon("game_ended");

  if(!isDefined(level.ambientgroups)) {
    level.ambientgroups = [];
  }

  if(!isDefined(level.active_spawn_modules)) {
    level.active_spawn_modules = [];
  }

  thread register_spawn_functions();
}

function register_spawn_functions() {
  if(scripts\engine\utility::flag_exist("interactions_initialized")) {
    scripts\engine\utility::flag_wait("interactions_initialized");
  }

  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
  }

  if(scripts\engine\utility::flag_exist("introscreen_over")) {
    scripts\engine\utility::flag_wait("introscreen_over");
  }

  if(!scripts\engine\utility::flag_exist("cp_dwn_twn_create_script_completed")) {
    scripts\engine\utility::flag_init("cp_dwn_twn_create_script_completed");
  }

  scripts\engine\utility::flag_wait("cp_dwn_twn_create_script_completed");
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat_heli", 0, 6, undefined, [ &short_and_long_delay, 0.05, 5], undefined, "bank_combat_heli");
  ref_12ae4();
  ref_12ad5();
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_vehicle_reinforcement", 0, 16, undefined, &scripts\cp\cp_modular_spawning::module_wave_spawn, undefined, "bank_vehicle_reinforcement");
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat_hvt", 1, 1, 1, 0.1, undefined, "bank_hvt");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("bank_combat_hvt", &hvt_think_func);
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat_vault", 3, 3, 3, 0.1, undefined, "bank_combat_vault");
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat_vault_wave", 0, 20, 100, [ &spawn_wave, 0.1, 45], undefined, ["bank_combat_3", "bank_combat_3_side", "bank_combat_3_back"]);
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat_atrium_init", 0, 6, 6, 0.1, undefined, "bank_combat_atrium_init");
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat_roof", 6, 10, undefined, 0.1, undefined, "bank_combat_roof");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("bank_combat_roof", &ref_12d84);
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_roof_juggernaut_1", 1, 1, 1, 0.1, undefined, "bank_roof_juggernaut_1");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("bank_roof_juggernaut_1", &roof_jugg_spawn_func);
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_roof_juggernaut_2", 1, 1, 1, 0.1, undefined, "bank_roof_juggernaut_2");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("bank_roof_juggernaut_2", &roof_jugg_spawn_func);
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat_roof_init", 6, 6, 6, 0.1, undefined, "bank_combat_roof_init");
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_roof_mortar", 3, 3, 3, 0.1, undefined, "bank_roof_mortar");
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat_heli_roof_low", 6, 6, 6, 0.1, undefined, ["bank_combat_heli_roof_1", "bank_combat_heli_roof_2"]);
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat_heli_roof_high", 6, 6, 6, 0.1, undefined, ["bank_combat_heli_roof_3", "bank_combat_heli_roof_4"]);
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_roof_paratroopers_high", 6, 6, 6, 0.5, 0, "bank_roof_paratroopers_high");
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_roof_paratroopers_low", 6, 6, 6, 0.5, 0, "bank_roof_paratroopers_low");
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_hvt_juggernaut_skit", 1, 1, 1, 0.1, undefined, "bank_hvt_juggernaut_skit");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("bank_hvt_juggernaut_skit", &hvt_jugg_skit_spawn_func);
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_hvt_juggernaut", 1, 1, 1, 0.1, undefined, "bank_hvt_juggernaut");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("bank_hvt_juggernaut", &hvt_jugg_spawn_func);
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_roof_hvt_juggernaut", 1, 1, 1, 0.1, undefined, "bank_roof_hvt_juggernaut");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("bank_roof_hvt_juggernaut", &roof_jugg_logic);

  if(!scripts\engine\utility::flag_exist("init_spawn_volumes_done")) {
    scripts\engine\utility::flag_init("init_spawn_volumes_done");
  }

  scripts\engine\utility::flag_set("init_spawn_volumes_done");
  scripts\engine\utility::flag_set("va_spawn_modules_registered");
}

function ref_12ad5() {
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat_cut", 0, 14, undefined, 0.1, undefined, "bank_combat_3");
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat_cut_2", 0, 14, undefined, 0.1, undefined, "bank_combat_3_side");
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat_cut_3", 0, 14, undefined, 0.1, undefined, "bank_combat_3_back");
  var_0 = ["frag_grenade_mp", "molotov_mp", "semtex_mp", "flash_grenade_mp"];
  var_1 = [0.5, 0.1, 0.1, 0.1];
  scripts\cp\cp_spawning_util::ref_12ae3("bank_combat_cut", var_0, var_1);
  scripts\cp\cp_spawning_util::ref_12ae3("bank_combat_cut_2", var_0, var_1);
  scripts\cp\cp_spawning_util::ref_12ae3("bank_combat_cut_3", var_0, var_1);
}

function ref_12ae4() {
  scripts\cp\cp_modular_spawning::registerambientgroup("vault_assault_driver", 1, 1, 1, 0.1, undefined, "vault_assault_driver", &tarmac_techo_start_first);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("vault_assault_driver", &keypad_activate_func);
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat_init", 0, 24, 24, 0.1, undefined, "bank_combat_init", undefined, undefined, 5);
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat_init_lmg", 2, 2, 2, 0.1, undefined, "bank_combat_init_lmg");
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat_init_rpg", 2, 2, 2, 0.1, undefined, "bank_combat_init_rpg");
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat_init_sniper", 4, 4, 4, 0.1, undefined, "bank_combat_init_sniper");
  scripts\cp\cp_modular_spawning::registerambientgroup("vault_assault_saw_patrollers", 0, 24, undefined, 0.1, undefined, "vault_assault_saw_patrollers");
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat_vault_jugg", 1, 1, 1, 0.1, &scripts\cp\cp_modular_spawning::ref_14340, "bank_combat_vault_jugg", undefined, "bank_combat_vault_bombers");
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat_vault_bombers", 0, 8, undefined, 0.1, undefined, "bank_combat_bombers");
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat_vault_fill", 0, 8, undefined, 0.1, undefined, "bank_combat_2");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("bank_combat_vault_fill", [ &scripts\cp\cp_modular_spawning::ref_11cad, (22374, -19506, -197)]);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("bank_combat_vault_fill", [ &scripts\cp\cp_modular_spawning::ref_11cac, 512]);
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat_lbravo", 0, 8, 8, 0.1, undefined, "bank_combat_lbravo");
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat_init_cover", 6, 6, 6, 0.1, undefined, "bank_combat_init_cover", [ &show_player_clip, (24538, -17807, -135), (0, 215, 0)]);
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat_init_back", 4, 4, 4, 0.1, undefined, "bank_combat_init_back");
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat_init_left", 2, 2, 2, 0.1, undefined, "bank_combat_init_left");
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat_init_right", 11, 11, 11, 0.1, undefined, "bank_combat_init_right");
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat_init_truck", 0, 10, 5, 0.1, undefined, "bank_combat_init_truck");
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_init_truck_patrol", 0, 10, 5, 0.1, undefined, "bank_init_truck_patrol");
  var_0 = [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 15, 5, 0.1, 8, 16];
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat", 0, 12, undefined, var_0, undefined, "bank_combat_2", [ &show_players_breadcrumbs_to_safe_house, (23893, -18455, -22), (0, 220, 0)]);
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat_bombers", 0, 8, 16, var_0, undefined, "bank_combat_bombers", [ &show_players_breadcrumbs_to_safe_house, (23893, -18455, -22), (0, 220, 0)]);
  var_0 = [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 10, 5, 0.1, 8, 16];
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat_post_vault", 0, 16, undefined, var_0, undefined, "bank_combat_2");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("bank_combat_post_vault", [ &scripts\cp\cp_modular_spawning::ref_11cad, (22743, -20318, 187)]);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("bank_combat_post_vault", [ &scripts\cp\cp_modular_spawning::ref_11cac, 512]);
  var_1 = scripts\engine\utility::getStruct("bank_obj_pos", "targetname");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("bank_combat_vault_jugg", [ &scripts\cp\cp_modular_spawning::set_initial_goalheight, "vault_door_broken"]);
  scripts\cp\cp_modular_spawning::register_module_weapons_free_func("bank_combat_init", &scripts\cp\cp_modular_spawning::set_heavy_hitter);
  scripts\cp\cp_spawning_util::register_module_init_func("bank_combat_init_truck", &ref_13f15);
  balloon_deposit_cash_nags("vault_assault_saw_patrollers");
  balloon_deposit_cash_nags("bank_combat_init_truck");
  balloon_deposit_cash_nags("bank_combat_init_truck");
  balloon_deposit_cash_nags("bank_combat_lbravo");
  balloon_deposit_cash_nags("bank_combat_init");
  balloon_deposit_cash_nags("bank_combat_init_lmg");
  balloon_deposit_cash_nags("bank_combat_init_sniper");
  balloon_deposit_cash_nags("bank_combat_init_rpg");
  balloon_deposit_cash_nags("bank_combat_init_cover");
  balloon_deposit_cash_nags("bank_combat_init_back");
  balloon_deposit_cash_nags("bank_combat_init_left");
  balloon_deposit_cash_nags("bank_combat_init_right");
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("vault_assault_saw_patrollers", undefined, 2500, 10000, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("bank_combat", undefined, 2500, 5000, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("bank_combat_bombers", undefined, 2500, 5000, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("bank_combat_init", undefined, 2500, 20000, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("bank_combat_init_rpg", undefined, 2500, 20000, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("bank_combat_init_lmg", undefined, 2500, 20000, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("bank_combat_init_cover", undefined, 2500, 20000, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("bank_combat_init_back", undefined, 2500, 20000, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("bank_combat_init_left", undefined, 2500, 20000, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("bank_combat_init_right", undefined, 2500, 20000, undefined);
  scripts\cp\cp_modular_spawning::set_spawn_scoring_params_for_group("bank_combat_init_sniper", undefined, 2500, 25000, undefined);
  scripts\cp\cp_modular_spawning::register_module_weapons_free_func("bank_combat_init", [ &scripts\cp\cp_modular_spawning::group_fallback_to_pos, var_1.origin]);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("bank_combat_init_cover", &spawn_in_cover);
  scripts\cp\cp_modular_spawning::register_module_weapons_free_func("bank_combat_init_sniper", [ &scripts\cp\cp_modular_spawning::set_heavy_hitter, 128]);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("bank_combat_init_sniper", &mark_never_remove);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("bank_combat_init_rpg", &mark_never_remove);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("bank_combat_init", &mark_never_remove);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("bank_combat_init_cover", &mark_never_remove);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("bank_combat_init_lmg", &mark_never_remove);
}

function ref_13f15(var_0) {
  thread ref_13f16(var_0);
}

function ref_13f16(var_0) {
  level endon("game_ended");
  var_0 scripts\engine\utility::ent_flag_wait("weapons_free");

  for(var_1 = 0; var_1 < var_0.module_vehicles.size; var_1++) {
    ref_13f13(var_0.module_vehicles[var_1]);
  }
}

function ref_13f13() {
  self vehicle_setspeedimmediate(0, 30, 30);
  scripts\common\vehicle::vehicle_unload();
}

function show_players_breadcrumbs_to_safe_house(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  var_0 endon("weapons_free");
  level endon("weapons_free");
  var_0 scripts\cp\cp_modular_spawning::watch_for_players_beyond_point_internal(var_0, var_1, var_2, &scripts\cp\cp_modular_spawning::mp_hideout_patch);
}

function show_player_clip(var_0, var_1, var_2, var_3) {
  var_0 endon("death");
  var_0 endon("weapons_free");
  var_0 scripts\cp\cp_modular_spawning::watch_for_players_beyond_point_internal(var_0, var_1, var_2, var_3, "end_module_if_weapons_free");
}

function mp_aniyah_patch() {
  self endon("end_module_if_weapons_free");
  level waittill("weapons_free");
  scripts\cp\cp_modular_spawning::mp_hideout_patch();
}

function balloon_deposit_cash_nags(var_0) {
  scripts\cp\cp_modular_spawning::register_module_weapons_free_func(var_0, &scripts\cp\cp_modular_spawning::ref_1309b);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func(var_0, &scripts\cp\cp_modular_spawning::watch_for_players);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func(var_0, &give_guy_pacifist_override);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func(var_0, &scripts\cp\cp_modular_spawning::enter_combat_after_stealth);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func(var_0, &alert_when_see_player);
}

function give_guy_pacifist_override(var_0) {
  self.pacifist_override = 1;
  self.sightmaxdistance = 2200;
  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 250000);
}

function alert_when_see_player(var_0) {
  if(scripts\cp\coop_stealth::ref_132d7()) {
    return;
  }

  level endon("game_ended");
  self endon("death");
  return_when_cansee_player();

  foreach(var_2 in var_0.ai_spawned) {
    var_2 notify("bulletwhizby");
  }
}

function return_when_cansee_player() {
  self endon("mission_compromised");
  self endon("enter_combat");

  for(;;) {
    var_0 = scripts\engine\utility::get_array_of_closest(self.origin, level.players, undefined, undefined, 1024);

    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      if(self cansee(level.players[var_1])) {
        return;
      }
    }

    wait 0.25;
  }
}

function players_entered_bank(var_0) {}

function spawn_per_player(var_0, var_1, var_2, var_3) {
  var_4 = max(var_1, var_2 * level.players.size);
  var_4 = min(var_4, 24);
  return var_4;
}

function spawn_in_cover(var_0) {
  var_1 = self getnearestnode();

  if(isDefined(var_1)) {
    var_2 = var_1.angles;
    var_3 = var_1.origin;

    if(!issubstr(var_1.type, "Prone")) {
      if(issubstr(var_1.type, "Left")) {
        var_2 += (0, 90, 0);
      } else if(issubstr(var_1.type, "Right") || issubstr(var_1.type, "Cover Crouch") || issubstr(var_1.type, "Conceal") || issubstr(var_1.type, "Cover Stand")) {
        var_2 -= (0, 90, 0);
      }
    }

    self forceteleport(var_3, var_2);
    self usecovernode(var_1, 1);
    self setgoalnode(var_1);
    self.goalradius = 8;
    return;
  }
}

function spawn_wave(var_0, var_1, var_2, var_3) {
  return scripts\cp\cp_modular_spawning::wave_reinforce(var_0, var_1, var_2, var_3);
}

function end_p1_spawn_loop(var_0) {
  level waittill("end_p1_spawn_loops");
  level notify("stop_" + var_0 + "_loop");
  wait 0.1;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname(var_0);
}

function p1_intel_death_func() {
  self.spawner scripts\cp\cp_modular_spawning::little_bird_mg_givetakegunnerturrettimeout();
  scripts\cp\cp_escalation::increase_escalation_counter();
}

function watch_for_spawn_min_required(var_0, var_1, var_2, var_3) {
  if(isDefined(level.active_spawn_module_structs) && level.active_spawn_module_structs.size > 1) {
    return 0;
  }

  var_4 = var_2 - scripts\cp\cp_modular_spawning::get_requested_spawn_count(var_0.moduleid);
  var_4 = clamp(var_4, 0, var_2);

  if(var_4 <= 0) {
    return 0;
  }

  var_5 = int(min(clamp(var_1, 0, var_4), var_1));
  return var_5;
}

function wait_after_max_spawn(var_0, var_1, var_2, var_3) {}

function reset_active_count(var_0) {
  var_0.activecount = 0;
  var_0.currentmodulekills = 0;
}

function isshuttingdown(var_0) {
  debug_trigger_objective_events(var_0);
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "vault_assault_debug_start");
}

function debug_vault_assault_obj_start(var_0) {
  debug_trigger_objective_events(var_0);
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "vault_assault_debug_start");
}

function debug_vault_assault_cut(var_0) {
  debug_trigger_objective_events(var_0);
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "vault_assault_cut_debug_start");
}

function debug_vault_assault_vault(var_0) {
  debug_trigger_objective_events(var_0);
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "vault_assault_cut_debug_start");
}

function debug_vault_assault_crypto(var_0) {
  scripts\cp\cp_spawning_util::ref_13bbd(0);
  debug_trigger_objective_events(var_0);
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "vault_assault_crypto_debug_start");
}

function debug_vault_assault_roof_obj_start(var_0) {
  debug_trigger_objective_events(var_0);

  while(!isDefined(level.heli)) {
    wait 0.1;
  }

  level.heli waittill("heli_landed");
  thread heli_force_search();
  scripts\engine\utility::flag_set("hvt_gone");
  scripts\engine\utility::flag_set("init_roof_combat");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "vault_assault_elevator_pos_roof_debug");
}

function debug_vault_assault_roof_defend_start(var_0) {
  wait 5;
  debug_trigger_objective_events(var_0);
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "vault_assault_elevator_pos_roof_debug");
}

function debug_vault_assault_roof_exfil_start(var_0) {
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "vault_assault_elevator_pos_roof_debug");
}

function delay_debug_roof_start() {
  if(isDefined(level.spawned_enemies)) {
    foreach(var_1 in level.spawned_enemies) {
      var_1 dodamage(var_1.health + 1000, var_1.origin);
    }
  }

  level.ambient_spawning_paused = 1;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_init_rpg");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_init_sniper");
  level notify("stop_delayed_spawn_module");
  wait 5;
  level.ambient_spawning_paused = undefined;
  level.bank_elevator = "roof";
}

function debug_trigger_objective_events(var_0) {
  scripts\engine\utility::flag_set("cp_dwn_twn_create_script");
  scripts\engine\utility::flag_wait("cp_dwn_twn_create_script_completed");
  scripts\engine\utility::flag_set("cp_dwn_twn_bank_vehicle_create_script");
  scripts\engine\utility::flag_wait("cp_dwn_twn_bank_vehicle_create_script_completed");
  scripts\engine\utility::flag_wait("objectives_registered");
  scripts\engine\utility::flag_wait("va_spawn_modules_registered");

  switch (var_0.ref) {
    case "vault_assault_rooftop_defend":
      spawn_static_trucks();
      init_vault_assault();
      init_vault_assault_cut();
      init_vault_assault_vault();
      break;
    case "vault_assault_rooftop_heli":
    case "vault_assault_rooftop":
      spawn_static_trucks();
      init_vault_assault();
      init_vault_assault_cut();
      init_vault_assault_vault();
      init_vault_assault_crypto();
      break;
    case "vault_assault_crypto":
      spawn_static_trucks();
      init_vault_assault();
      init_vault_assault_cut();
      init_vault_assault_vault();
      thread delay_then_run_spawn_module(level, "wave_spawning");
      break;
    case "vault_assault_vault":
      spawn_static_trucks();
      init_vault_assault();
      init_vault_assault_cut();
      break;
    case "vault_assault_cut":
      spawn_static_trucks();
      init_vault_assault();
      thread scriptable_carriable_damage_internal();
      break;
    case "vault_assault":
      thread scriptable_carriable_damage_internal();
      break;
    default:
      break;
  }

  thread ref_12bc4();
}

function scriptable_carriable_damage_internal() {
  while(!isDefined(level.players)) {
    wait 0.1;
  }

  while(level.players.size < 1) {
    wait 0.1;
  }

  wait 2;
  var_0 = 0;

  while(!var_0) {
    foreach(var_2 in level.players) {
      if(var_2.model != "") {
        scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_safehouse::script_struct_add(var_2);
        return;
      }
    }

    wait 0.1;
  }
}

function ref_12bc4() {
  if(!isDefined(level.littlebirds)) {
    level waittill("little_birds_done_spawning");
  }

  var_0 = scripts\engine\utility::getStruct("rooftop_org", "targetname");
  var_1 = var_0.radius;
  var_2 = var_1 * var_1;

  foreach(var_4 in level.littlebirds) {
    if(distance2dsquared(var_4.origin, var_0.origin) < var_2) {
      var_4 delete();
    }
  }
}

function debugbeatobjective(var_0) {}

function init_pre_vault_assault(var_0, var_1) {
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\engine\utility::flag_wait("cp_donetsk_safehouse_downtown_cs_completed");
}

function start_pre_vault_assault(var_0, var_1) {
  scripts\engine\utility::flag_set("cp_dwn_twn_create_script");
  scripts\engine\utility::flag_wait("cp_dwn_twn_create_script_completed");
  scripts\engine\utility::flag_set("cp_dwn_twn_bank_vehicle_create_script");
  scripts\engine\utility::flag_wait("cp_dwn_twn_bank_vehicle_create_script_completed");
  scripts\engine\utility::flag_set("ml_p3_done");
  scripts\engine\utility::flag_set("return_to_safehouse");
  scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_safehouse::ref_1234e(var_0);
  level waittill("mission_selected", var_2);
}

function team_planted_bomb(var_0, var_1) {
  level endon("game_ended");
  scripts\engine\utility::flag_set("cp_dwn_twn_create_script");
  scripts\engine\utility::flag_wait("cp_dwn_twn_create_script_completed");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_12e56(getEntArray("gunshop_safehouse_loot", "targetname"));
  init_out_of_bounds_triggers();
  level.default_player_spawns = "vault_assault_infil_start";
  level.initlocs_bunkertest = scripts\engine\utility::getStructArray("vault_assault_infil_start", "targetname");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "vault_assault_infil_start");
  ref_140f4();
  level thread scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_safehouse::ref_1234e(var_0);
  level.initlethalmaxoffsetmap = "vault_assault";
  scripts\engine\utility::flag_init("enemy_alert");
  scripts\cp\utility::skydivestreamhintdvars("ml_p1");
  spawn_static_trucks();
}

function init_out_of_bounds_triggers() {
  var_0 = scripts\engine\utility::getStruct("vault_assault_loadout_select", "targetname");
  var_1 = spawn("script_model", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 setModel("military_carepackage_01_friendly");
  var_2 = getEnt("care_package_col", "targetname");
  var_3 = spawn("script_model", var_0.origin);
  var_3.angles = var_0.angles;
  var_3 clonebrushmodeltoscriptmodel(var_2);
  var_3 linkTo(var_1);
  var_4 = spawn("script_model", var_0.origin + (0, 0, 35));
  var_4 setModel("tag_origin");
  var_4 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_STRIKE/EDIT_LOADOUT", 25, "duration_short", "hide", 256, 75, 128, 75);
  var_4.headicon = deleteheadicon(var_1);
  setheadiconfriendlyimage(var_4.headicon, "hud_icon_survival_weapon");
  setheadicondrawthroughgeo(var_4.headicon, 0);
  setheadiconsnaptoedges(var_4.headicon, 1024);
  setheadiconmaxdistance(var_4.headicon, 256);
  addclienttoheadiconmask(var_4.headicon, -5);
  var_1.collision = var_3;
  var_1.interaction = var_4;
  var_4 thread scripts\mp\brclientmatchdata::getnextcombatareaid(var_1);
}

function tarmac_techo_start_first(var_0) {
  scripts\engine\utility::flag_init("infil_driver_spawned");
}

function keypad_activate_func(var_0) {
  level.stepstructsproximity = self;
  self.nocorpse = 1;
  scripts\engine\utility::flag_set("infil_driver_spawned");
}

function ref_140f4() {
  scripts\cp\cp_modular_spawning::run_spawn_module("vault_assault_driver");
}

function ref_13829(var_0, var_1) {
  scripts\cp\cp_modular_spawning::run_spawn_module("vault_assault_saw_patrollers");
  scripts\cp\cp_modular_spawning::run_spawn_module("bank_combat_vault_jugg");
  scripts\cp\cp_modular_spawning::run_spawn_module("bank_combat_init_sniper");
  scripts\cp\cp_modular_spawning::run_spawn_module("bank_combat_init");
  scripts\cp\cp_modular_spawning::run_spawn_module("bank_combat_init_lmg");
  scripts\cp\cp_modular_spawning::run_spawn_module("bank_combat_init_rpg");
  scripts\cp\cp_modular_spawning::run_spawn_module("bank_combat_init_cover");
  scripts\cp\cp_modular_spawning::run_spawn_module("bank_combat");
  scripts\cp\cp_modular_spawning::run_spawn_module("bank_combat_bombers");
  thread ref_135cc(level);
  thread ref_135cc(level);
  level waittill("saw_pickedup");
  scripts\cp\cp_modular_spawning::run_spawn_module("bank_combat_init_truck");
}

function hiding_munitions_purchase(var_0, var_1) {
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("vault_assault_saw_patrollers");
  thread scripts\cp\cp_objectives::run_objective("vault_assault");
}

function end_pre_vault_assault(var_0, var_1) {}

function init_vault_assault(var_0, var_1) {
  level endon("game_ended");
  scripts\engine\utility::flag_set("cp_dwn_twn_create_script");
  scripts\engine\utility::flag_wait("cp_dwn_twn_create_script_completed");
  scripts\engine\utility::flag_set("cp_dwn_twn_bank_vehicle_create_script");
  scripts\engine\utility::flag_wait("cp_dwn_twn_bank_vehicle_create_script_completed");
  level.initlethalmaxoffsetmap = "vault_assault";
  level.initlocationcircle = "vault_assault";
  ref_12bc4();
  level.max_agents_override = 24;

  if(isDefined(var_0)) {
    var_2 = scripts\engine\utility::getStructArray("bank_obj_pos", "targetname");
    var_3 = var_2[0];
    objective_icon(var_0.objectiveindex, "icon_waypoint_objective_general");
    objective_position(var_0.objectiveindex, var_3.origin);
    objective_state(var_0.objectiveindex, "current");

    if(var_0.ref == "pre_vault_assault") {
      var_4 = scripts\engine\utility::getStructArray("vault_assault_start", "targetname");
      var_5 = var_4[0];
      var_6 = 0;
      var_7 = 49000000;

      while(!var_6) {
        foreach(var_9 in level.players) {
          if(distance2dsquared(var_9.origin, var_5.origin) < var_7) {
            var_6 = 1;
          }
        }

        wait 1;
      }
    }
  }

  scripts\cp\utility::skydivestreamhintdvars("ml_p1");
  scripts\engine\utility::flag_init("enemy_alert");
  thread listen_for_enemy_alert();
}

function start_vault_assault(var_0, var_1) {
  level endon("game_ended");
  level endon("end_vault_assault");
  wait 5;
  thread nag_get_in_bank();
  var_2 = scripts\engine\utility::getStructArray("vault_assault_start", "targetname");
  var_3 = var_2[0];
  var_4 = var_3.origin;
  thread notify_when_player_nearby(level, "vault_assault_cut_start", var_4);
  var_5 = scripts\engine\utility::getStructArray("vault_door_cut_interaction", "targetname");
  var_4 = var_5[0].origin;
  thread notify_when_player_nearby(level, "vault_assault_cut_start", var_4);
  level waittill("vault_assault_cut_start");
  scripts\cp\cp_objectives::overridenextstep(var_0, "vault_assault_cut");
}

function end_vault_assault(var_0, var_1) {}

function ref_123ca() {
  scripts\mp\vehicles\vehicle_damage_mp::ref_12409("kama");
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_bank_intro_20");
  scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_ml_p1::ref_123cb("conv_generic_affirm");
}

function gettimetogulagclosed(var_0) {
  var_1 = scripts\engine\utility::random(var_0);
  scripts\cp\cp_dialogue::play_vo_to_all(var_1);
}

function cap_wave_spawning() {
  level endon("game_ended");

  for(;;) {
    var_0 = 0;
    var_0 = level.spawned_enemies.size;
    var_1 = 24 - var_0;
    var_2 = max(var_1, 0);

    if(isDefined(level.active_spawn_module_structs["wave_spawning"])) {
      var_3 = level.active_spawn_module_structs["wave_spawning"];

      for(var_4 = 0; var_4 < var_3.size; var_4++) {
        var_5 = var_3[var_4];
        var_5 scripts\cp\cp_modular_spawning::set_ambient_max_count(var_2);
      }
    }

    wait 1;
  }
}

function nag_get_in_bank() {
  level endon("game_ended");
  level endon("vault_assault_cut_start");

  for(;;) {
    wait 60;
    scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_bank_push_10");
  }
}

function notify_when_player_nearby(var_0, var_1, var_2) {
  level endon("game_ended");
  wait_for_player_nearby(var_1, var_2);
  level notify(var_0);
}

function init_vault_assault_cut(var_0, var_1) {
  level thread scripts\cp\maps\cp_dwn_twn\cp_dwn_twn_door_cut::main(var_0);
  scripts\cp\cp_spawning_util::ref_13bbd(0);
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_init_sniper");
}

function start_vault_assault_cut(var_0, var_1) {
  level endon("game_ended");
  level endon("end_vault_assault");
  scripts\cp\utility::ref_123fe("mus_cp_money_breach_vault");

  if(randomint(100) < 50) {
    scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_bank_cut_down_gate_10");
  } else {
    scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_bank_vault_gate_10");
  }

  thread nag_door_cut();
  scripts\engine\utility::flag_set("activate_wheelsons");
  objective_position(var_0.objectiveindex, getEnt("vault_gate_door", "targetname").origin + (0, 0, 50));
  objective_setplayintro(var_0.objectiveindex, 1);
  objective_setshowprogress(var_0.objectiveindex, 1);
  objective_setlabel(var_0.objectiveindex, &"CP_BR_SYRK_OBJECTIVES/CUT_HINT");
  level.cut_progress_objective = var_0.objectiveindex;
  scripts\engine\utility::flag_set("activate_door_cut");
  mark_group_as_killable("bank_combat_init_sniper");
  mark_group_as_killable("bank_combat_init_rpg");
  thread cycle_bank_combat_cut_spawn_modules();

  while(!istrue(level.vault_door_broken)) {
    wait 0.1;
  }

  scripts\cp\utility::ref_123fe("mus_cp_money_cut_vault");
  level notify("vault_door_broken");
  scripts\cp\cp_objectives::overridenextstep(var_0, "vault_assault_vault");
}

function end_vault_assault_cut(var_0, var_1) {}

function nag_door_cut() {
  level endon("vault_door_broken");

  for(;;) {
    wait 60;

    if(!isDefined(level.total_cut_progress) || level.total_cut_progress == 0) {
      scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_bank_gate_cut_start_10");
      continue;
    }

    scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_bank_gate_cut_finish_10");
  }
}

function cycle_bank_combat_cut_spawn_modules() {
  level endon("game_ended");
  level endon("end_vault_assault");
  level endon("vault_door_broken");
  level waittill("start_cut_spawn_modules");
  var_0 = ["bank_combat_init"];

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = scripts\cp\cp_modular_spawning::get_module_structs_by_groupname(var_0[var_1], 1);

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_4 = var_2[var_3];
      scripts\cp\cp_modular_spawning::group_fallback_to_pos(var_4, (22686, -19207, -22));
    }
  }

  scripts\cp\cp_modular_spawning::stop_module_by_groupname("vault_assault_saw_patrollers");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_bombers");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_vehicle_reinforcement");

  while(!istrue(level.vault_door_broken)) {
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_cut");
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_cut_3");
    var_4 = scripts\cp\cp_modular_spawning::run_spawn_module("bank_combat_cut_2");
    wait 15;
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_cut");
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_cut_2");
    var_4 = scripts\cp\cp_modular_spawning::run_spawn_module("bank_combat_cut_3");
    wait 15;
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_cut_2");
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_cut_3");
    var_4 = scripts\cp\cp_modular_spawning::run_spawn_module("bank_combat_cut");
    wait 15;
  }
}

function init_vault_assault_vault(var_0, var_1) {
  scripts\cp\cp_spawning_util::ref_13bbd(0);
  thread open_vault_gate();
  level.deposit_box_interactions = [];
  var_2 = scripts\engine\utility::getStructArray("vault_deposit_box_interaction", "targetname");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = 0;

    foreach(var_6 in level.deposit_box_interactions) {
      if(var_6.origin == var_2[var_3].origin) {
        var_4 = 1;
      }
    }

    if(!var_4) {
      var_8 = create_deposit_box_interaction(var_2[var_3]);
      level.deposit_box_interactions[level.deposit_box_interactions.size] = var_8;

      if(getdvarint("scr_va_force_key") != 0) {
        var_8.key_card = 1;
      }
    }
  }

  var_9 = randomint(level.deposit_box_interactions.size);
  level.deposit_box_interactions[var_9].key_card = 1;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("vault_assault_saw_patrollers");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_init");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_vehicle_reinforcement");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_cut");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_cut_2");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_cut_3");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_bombers");
  var_10 = ["bank_combat_cut", "bank_combat_cut_2", "bank_combat_cut_3"];

  for(var_3 = 0; var_3 < var_10.size; var_3++) {
    var_11 = scripts\cp\cp_modular_spawning::get_module_structs_by_groupname(var_10[var_3], 1);

    for(var_12 = 0; var_12 < var_11.size; var_12++) {
      scripts\cp\cp_modular_spawning::group_fallback_to_pos(var_11[var_12], (22374, -19506, -197));
    }
  }

  open_vault_door();

  if(isDefined(var_0) && isDefined(var_0.objectiveindex)) {
    scripts\cp\cp_objectives::ref_11f80(var_0.objectiveindex);
    return;
  }
}

function start_vault_assault_vault(var_0, var_1) {
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_bank_intel_search_10");
  var_2 = scripts\engine\utility::getStructArray("vault_assault_vault", "targetname");
  var_3 = var_2[0];
  var_4 = var_3.origin;
  level.crypto_key_objective = var_0;
  wait_for_player_nearby(var_4, 500);
  level thread scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_bank_key_deposit_boxes_10");
  thread nag_vault_search();

  while(!level.key_card_acquired) {
    wait 0.1;
  }

  level notify("key_card_acquired");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_vault_wave");
}

function end_vault_assault_vault(var_0, var_1) {
  scripts\cp\cp_objectives::overridenextstep(var_0, "vault_assault_vault_fake_end");
}

function nag_vault_search() {
  level endon("key_card_acquired");
  level endon("deposit_usb_found");

  for(;;) {
    wait 60;

    if(!istrue(level.deposit_box_search)) {
      scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_bank_intel_keep_searching_10");
      continue;
    }

    scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_bank_intel_keep_searching_20");
  }
}

function init_vault_door() {
  level.vault_door = getEnt("bank_vault_door_open", "targetname");
  level.vault_door.open_pos = level.vault_door.origin;
  level.vault_door.open_ang = level.vault_door.angles;
  var_0 = scripts\engine\utility::getStructArray("bank_vault_door_closed", "targetname");
  var_1 = var_0[0];
  level.vault_door.origin = var_1.origin;
  level.vault_door.angles = var_1.angles;
}

function open_vault_door() {
  if(isDefined(level.vault_door)) {
    level.vault_door rotateTo(level.vault_door.open_ang, 5, 0.1, 0.5);
    level.vault_door playSound("cp_bank_vault_open");
    return;
  }
}

function create_key_card(var_0, var_1) {
  var_2 = scripts\engine\utility::getStructArray("key_card_interaction", "targetname");
  var_3 = var_2[0];

  if(isDefined(var_0)) {
    var_4 = var_0.origin + anglestoright(var_0.angles) * 10 + anglesToForward(var_0.angles) * -5;
    var_3.origin = var_4;
    var_3.angles = var_0.angles;
  }

  create_usb_pickup_interaction(var_3, var_1);
}

function open_vault_gate() {
  while(!istrue(level.waiting_for_door_cut)) {
    wait 0.1;
  }

  if(isDefined(level.door_cut_interactions)) {
    foreach(var_1 in level.door_cut_interactions) {
      if(isDefined(var_1)) {
        var_1 delete();
      }
    }
  }

  wait 1;
  level.vault_door_broken = 1;
  level notify("end_door_cut_wait");
}

function init_vault_assault_vault_fake_end(var_0, var_1) {
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("vault_assault_saw_patrollers");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_cut");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_cut_2");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_cut_3");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_vault_wave");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_vault_bombers");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_vault_fill");
}

function start_vault_assault_vault_fake_end(var_0, var_1) {
  scripts\cp\cp_modular_spawning::run_spawn_module("bank_combat_atrium_init");
  wait 4;
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_bank_good_find_10");
  wait 1;
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_bank_hvt_update_10");
  wait 1;
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_bank_hvt_update_20");
}

function end_vault_assault_vault_fake_end(var_0, var_1) {
  scripts\cp\cp_objectives::overridenextstep(var_0, "vault_assault_crypto");
}

function init_vault_assault_crypto(var_0, var_1) {
  if(!scripts\engine\utility::flag_exist("cp_dwn_twn_create_script_completed")) {
    scripts\engine\utility::flag_init("cp_dwn_twn_create_script_completed");
  }

  scripts\engine\utility::flag_wait("cp_dwn_twn_create_script_completed");
  level.hvt_in_heli = 0;
  level.player_sees_hvt = 0;
  level.player_sees_hvt_timeout = 0;
  level thread scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_heli_boss::spawn_enemy_lbravo("heli_engage");
  scripts\cp\cp_modular_spawning::increase_reserved_spawn_slots(1, "bank_combat_hvt");
  scripts\cp\cp_agent_damage::register_drop_func("hvt_key", &drop_hvt_key, &should_drop_hvt_key, 0);
  level.hvt_module_struct = scripts\cp\cp_modular_spawning::run_spawn_module("bank_combat_hvt");
  scripts\cp\cp_modular_spawning::run_spawn_module("bank_hvt_juggernaut_skit");
  scripts\cp\cp_modular_spawning::run_spawn_module("bank_hvt_juggernaut");
  thread open_stairwell_doors();
  thread roof_combat_start(level);
  scripts\cp\cp_objectives::ref_11f80(var_0.objectiveindex);
}

function ref_135cc(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0, "targetname");

  if(!isDefined(var_1)) {
    return;
  }

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    thread ref_1353b(var_1[var_2]);
  }
}

function ref_1353b(var_0) {
  var_1 = scripts\mp\carriable::ref_131ea(var_0);
  var_1.matchdata_logaward = 1;
}

function start_vault_assault_crypto(var_0, var_1) {
  while(!isDefined(level.bank_hvt)) {
    wait 0.1;
  }

  thread move_objective_to_hvt(level);
  thread player_sees_hvt();

  while(isDefined(level.bank_hvt) && !level.player_sees_hvt && !level.player_sees_hvt_timeout) {
    waitframe();
  }

  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_atrium");
  scripts\cp\cp_modular_spawning::run_spawn_module("bank_combat_post_vault");
  thread setup_breadcrumbs_to_roof(level);
  level waittill("hvt_leaving");
  scripts\engine\utility::flag_wait("hvt_gone");

  while(!istrue(level.players_on_roof)) {
    wait 0.1;
  }
}

function end_vault_assault_crypto(var_0, var_1) {
  scripts\cp\cp_objectives::overridenextstep(var_0, "vault_assault_rooftop_heli");
}

function open_stairwell_doors() {
  scripts\engine\utility::flag_wait("stair_doors_init");
  var_0 = ["stair_door_2", "stair_door_3", "stair_door_2_2", "stair_door_3_2", "stair_door_1_2"];

  foreach(var_2 in var_0) {
    open_door(var_2);
    wait 0.1;
  }
}

function open_roof_doors() {
  scripts\engine\utility::flag_wait("stair_doors_init");
  var_0 = ["stair_door_roof", "stair_door_5_2", "stair_door_roof_2"];

  foreach(var_2 in var_0) {
    open_door(var_2);
    wait 0.1;
  }
}

function roof_combat_start(var_0) {
  scripts\engine\utility::flag_wait("init_roof_combat");
  scripts\cp\cp_modular_spawning::run_spawn_module("bank_combat_roof_init");
  scripts\cp\cp_modular_spawning::run_spawn_module("bank_roof_juggernaut_1");
  scripts\cp\cp_modular_spawning::run_spawn_module("bank_roof_juggernaut_2");
}

function roof_jugg_spawn_func(var_0) {
  thread roof_jugg_wake_logic();
}

function roof_jugg_wake_logic() {
  level endon("game_ended");
  self endon("death");
  self.ignoreall = 1;
  self setgoalpos(self.origin);
  var_0 = scripts\engine\utility::getStructArray("jugg_room", "targetname");
  self.room_struct = sortbydistance(var_0, self.origin)[0];
  var_1 = 1;
  var_2 = gettime() + (30 + randomint(10)) * 1000;
  var_3 = self.origin[2] - 20;
  var_4 = self.room_struct.radius * self.room_struct.radius;

  while(var_1) {
    foreach(var_6 in level.players) {
      if(distancesquared(var_6.origin, self.room_struct.origin) <= var_4) {
        if(isDefined(var_3)) {
          if(var_6.origin[2] < var_3) {
            continue;
          }
        }

        var_1 = 0;
      }
    }

    if(gettime() > var_2) {
      var_1 = 0;
    }

    wait 0.1;
  }

  self.goalradius = 1024;
  self.ignoreall = 0;
}

function player_sees_hvt() {
  var_0 = scripts\engine\utility::getStructArray("vault_assault_crypto_hvt_desk", "targetname");
  var_1 = var_0[0];
  var_2 = var_1.origin;
  wait_for_player_nearby(var_2, 800, -50, 200);
  wait 1;
  level.player_sees_hvt = 1;
}

function player_sees_hvt_timeout(var_0) {
  wait var_0;
  level.player_sees_hvt_timeout = 1;
}

function move_juggs_in_elevator() {
  scripts\engine\utility::flag_wait("init_roof_combat");
  wait 3;
  level.hvt_elevator_jugg dodamage(level.hvt_elevator_jugg.health + 1000, level.hvt_elevator_jugg.origin);
}

function hvt_jugg_spawn_func(var_0) {
  if(!isDefined(level.hvt_jugg)) {
    level.hvt_jugg = [];
  }

  level.hvt_jugg[level.hvt_jugg.size] = self;
  self.hvt_jugg = 1;
  level.hvt_elevator_jugg = self;
  self.scripted_mode = 1;
  self.ignoreall = 1;
  self.invulnerable = 1;
  self.dont_enter_combat = 1;
  scripts\cp\cp_modular_spawning::set_goal_pos(self.origin);
  self.goalradius = 8;
}

function hvt_jugg_skit_spawn_func(var_0) {
  level.bank_hvt_jugg = self;
  self.bank_hvt_jugg = 1;

  if(!isDefined(level.hvt_jugg)) {
    level.hvt_jugg = [];
  }

  level.hvt_jugg[level.hvt_jugg.size] = self;
  self.hvt_jugg = 1;
  self.scripted_mode = 1;
  self.ignoreall = 1;
  self.invulnerable = 1;
  self.dont_enter_combat = 1;
  self.allowpain = 0;
  scripts\cp\cp_modular_spawning::set_goal_pos(self.origin);
  self.goalradius = 8;
}

function move_objective_to_hvt(var_0) {
  thread setup_breadcrumbs_to_hvt(level);
  var_1 = scripts\engine\utility::getStructArray("vault_assault_hvt_desk_computer", "targetname");
  var_2 = var_1[0];
  var_3 = spawn("script_model", var_2.origin);
  var_3.angles = var_2.angles;
  var_3 setModel("computer_pc_tower_01");
  thread break_pc_on_damage();

  while(!isDefined(level.bank_hvt)) {
    wait 0.1;
  }

  level waittill("objective_on_hvt");
  thread spawninfo();
  wait 1;
  level.hvt_obj_num = var_0.objectiveindex;
  objective_setplayintro(level.hvt_obj_num, 0);
  objective_setplayoutro(level.hvt_obj_num, 0);
  objective_setbackground(level.hvt_obj_num, 0);
  objective_state(level.hvt_obj_num, "current");
  objective_icon(level.hvt_obj_num, "icon_waypoint_objective_general");
  objective_onentity(level.hvt_obj_num, level.bank_hvt);
  objective_setzoffset(level.hvt_obj_num, 70);
}

function spawninfo() {
  var_0 = 500;
  var_1 = var_0 * var_0;
  var_2 = cos(45);

  foreach(var_4 in level.players) {
    if(distancesquared(var_4.origin, level.bank_hvt.origin) < var_1) {
      if(scripts\engine\utility::within_fov(var_4.origin, var_4.angles, level.bank_hvt.origin, var_2)) {
        thread ref_124ec(level);
        return;
      }
    }
  }
}

function ref_124ec(var_0) {
  wait 0.5;
  scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "obj_target_visual");
}

function break_pc_on_damage() {
  self setCanDamage(1);
  self waittill("damage");
  self setModel("computer_pc_tower_01_broken_destr");
  playFXOnTag(level._effect["pc_break"], self, "tag_origin");
  playsoundatpos(self.origin, "dst_personal_computer");
}

function setup_breadcrumbs_to_hvt(var_0) {
  level endon("game_ended");
  var_0.objbreadcrumbs = scripts\cp\cp_objectives::create_breadcrumb_for_team("allies", "va_hvt_breadcrumb");
  thread clean_up_breadcrumbs_to_hvt(level);
}

function clean_up_breadcrumbs_to_hvt(var_0) {
  level endon("game_ended");
  level waittill("hvt_leaving");
  scripts\cp\cp_objectives::delete_breadcrumb_array(var_0.objbreadcrumbs);
}

function spawninsafehouse() {
  var_0 = 500;
  var_1 = var_0 * var_0;
  var_2 = cos(45);
  var_3 = level.players[0];

  foreach(var_5 in level.players) {
    if(distancesquared(var_5.origin, level.bank_hvt.origin) < var_1) {
      if(scripts\engine\utility::within_fov(var_5.origin, var_5.angles, level.bank_hvt.origin, var_2)) {
        var_3 = var_5;
        break;
      }
    }
  }

  ref_124eb(var_3);
}

function ref_124eb(var_0) {
  wait 0.25;
  scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "flavor_negative");
  wait 8;
  scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "obj_target_moving");
}

function setup_breadcrumbs_to_roof(var_0) {
  level endon("game_ended");
  level waittill("hvt_leaving");
  var_0.objbreadcrumbs = scripts\cp\cp_objectives::create_breadcrumb_for_team("allies", "va_roof_breadcrumb");
  thread clean_up_breadcrumbs_to_roof(level);
}

function clean_up_breadcrumbs_to_roof(var_0) {
  level endon("game_ended");
  level waittill("everyone_on_exfil_heli");
  scripts\cp\cp_objectives::delete_breadcrumb_array(var_0.objbreadcrumbs);
}

function tagleaderwithheadicon(var_0) {
  level.tmtyl_headicon = deleteheadicon(var_0);
  setheadiconfriendlyimage(level.tmtyl_headicon, "hud_icon_hardpoint_diamond");
  setheadiconsnaptoedges(level.tmtyl_headicon, 0);
}

function watchforvipdeath(var_0) {
  level endon("game_ended");
  self waittill("death");

  if(isDefined(level.tmtyl_headicon)) {
    setheadiconimage(level.tmtyl_headicon);
  }

  thread heli_force_search();
  scripts\engine\utility::flag_set("hvt_gone");
  level.bank_hvt = undefined;
  scripts\cp\cp_modular_spawning::decrease_reserved_spawn_slots(1, "bank_combat_hvt");
}

function wait_for_jugg_death(var_0) {
  level endon("game_ended");
  self waittill("death");
  scripts\cp\cp_modular_spawning::decrease_reserved_spawn_slots(1, "bank_hvt_juggernaut");
}

function heli_force_search() {
  if(isDefined(level.heli)) {
    level.heli.force_search = 1;
    wait 1;
    level.heli.force_search = undefined;
    return;
  }
}

function hvt_think_func(var_0) {
  level.bank_hvt = self;
  self.bank_hvt = 1;
  self.invulnerable = 1;
  self.never_kill_off = 1;
  self.ref_11e50 = 1;
  self.allowpain = 0;
  self.ignoreall = 1;
  scripts\cp\cp_modular_spawning::set_goal_pos(self.origin);
  self.goalradius = 8;
  thread watchforvipdeath();
  thread send_hvt_to_elevator();
  thread move_juggs_in_elevator();
  scripts\cp\cp_modular_spawning::set_character_models("body_al_qatala_urban_civ_1_1", "head_sc_m_money_civ");
}

function send_hvt_to_elevator(var_0) {
  level endon("game_ended");
  level.players_on_roof = 0;

  while(isDefined(level.bank_hvt) && !level.player_sees_hvt && !level.player_sees_hvt_timeout) {
    waitframe();
  }

  scripts\engine\utility::delaythread(8, &allow_breach_charge);
  scripts\cp\utility::ref_123fe("mus_cp_money_juggernaut_appear");
  spawn_bodyguard_and_go_to_desk();
  hvt_idle();
  scripts\cp\utility::ref_123fe("mus_cp_money_juggernaut_appear");
  hvt_exit();
  level notify("hvt_leaving");
  wait 1;
  scripts\engine\utility::flag_set("init_roof_combat");

  if(isDefined(level.bank_hvt)) {
    move_up_to_roof();
    scripts\cp\cp_modular_spawning::run_spawn_module("bank_roof_hvt_juggernaut");
  } else {
    scripts\cp\cp_objectives::update_objective("vault_assault_crypto", "current", (4238, 710, 836), undefined, undefined, 2, "icon_waypoint_marker", 0, 1, 1);
  }

  waittill_players_on_roof();
  level thread scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_bank_hvt_escape_10");
  thread move_marker_to_heli();
  scripts\cp\cp_modular_spawning::run_spawn_module("bank_combat_roof");
  give_hvt_ar();
  open_elevator_doors("");
  scripts\engine\utility::flag_set("roof_elevator_open");
  hvt_run_to_heli();
  hvt_made_it_to_heli();
}

function ref_133b3(var_0) {
  level.ref_13b13 = 1;
  wait var_0;
  level notify("charge_planted");
  wait 1;
  scripts\engine\utility::flag_set("heli_engage");
}

function allow_breach_charge() {
  level thread scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_bank_breach_door_10");
  var_0 = scripts\engine\utility::getStructArray("c4_interact", "targetname");
  var_1 = var_0[0];
  var_2 = scripts\cp\cp_breach_c4::setup_c4(var_1);
  var_2 scripts\engine\utility::ent_flag_wait("c4_exploded");
  var_3 = anglestoright(var_2.angles);
  var_4 = anglestoup(var_3);
  playFX(level._effect["vfx_gen_c4_exp2_ch"], var_2.origin, var_3, var_4);
  var_5 = getEnt("hvt_door", "targetname");
  var_5 setModel("door_reinforced_door_damaged");
  level notify("charge_planted");
  thread getcashnags();
}

function getcashnags() {
  spawninsafehouse();
  wait 1;
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_bank_door_reinforced_10");
  wait 1;
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_bank_hvt_rooftop_10");
  wait 5;
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_bank_hvt_escape_10");
}

function spawn_bodyguard_and_go_to_desk() {
  var_0 = scripts\engine\utility::getStructArray("vault_assault_hvt_ar_prop", "targetname");
  var_1 = var_0[0];
  level.hvt_ar = spawn("script_model", var_1.origin);
  level.hvt_ar setModel("weapon_vm_ar_akilo47_brprop");
  level.hvt_ar.angles = var_1.angles;
  wait 1;
  level.monitor_lookat_ent = spawn("script_model", (6116, 1499, 378));

  if(isDefined(level.bank_hvt) && isDefined(level.bank_hvt_jugg)) {
    var_2 = scripts\cp\cp_weapon::buildweapon("iw8_pi_golf21_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
    level.bank_hvt giveweapon(var_2);
    level.bank_hvt takeweapon(level.bank_hvt.weapon);
    level.bank_hvt setspawnweapon(var_2);
    level.bank_hvt scripts\common\utility::initweapon(var_2);
    level.bank_hvt scripts\anim\shared::placeweaponon(var_2, "right");
    level.bank_hvt.sidearm = var_2;
    var_3 = scripts\engine\utility::getStructArray("heistguy", "targetname");
    var_4 = var_3[0];
    level.bank_hvt_cig = spawn("script_model", level.bank_hvt gettagorigin("tag_eye") + (0, 0, -3));
    level.bank_hvt_usb = spawn("script_model", var_4.origin);
    level.bank_hvt_cig.angles = level.bank_hvt gettagangles("tag_eye");
    level.bank_hvt.animstruct = var_4;
    level.bank_hvt_cig setModel("tag_origin");
    level.bank_hvt_cig linkTo(level.bank_hvt, "tag_eye", (2.75, -0.5, -2.85), (0, 0, 0));
    level.bank_hvt_usb setModel("electronics_usb_thumb_drive");
    level.bank_hvt_usb scriptmodelplayanimdeltamotionfrompos("cp_bank_heist_office_usb_start", var_4.origin, var_4.angles);
    thread hvt_skit_notetrack_handler();
    thread hvt_skit_notetrack_handler();
    thread open_elevator_doors(level, "_third");
    GscBinSkip4(0x6e, level, "objective_on_hvt", level.bank_hvt_jugg, level.bank_hvt);
  }
}

function spawnheight() {
  wait 0.1;
  playFXOnTag(level._effect["hvt_cig"], level.bank_hvt_cig, "tag_origin");
}

function lookat_players() {
  self endon("stop_lookat");
  self endon("death");

  for(;;) {
    var_0 = scripts\cp\utility::get_closest_living_player();

    if(!isDefined(var_0)) {
      self setlookatentity();
      wait 3;
      continue;
    }

    if(distance(var_0.origin, self.origin) < 1000) {
      self setlookatentity(var_0);
    } else {
      self setlookatentity();
    }

    wait 5;
  }
}

function hvt_idle() {
  level endon("charge_planted");
  thread lookat_players();
  var_0 = level.bank_hvt scripts\asm\asm::asm_lookupanimfromalias("animscripted", "bank_heist_guy_idle");
  var_1 = level.bank_hvt_jugg scripts\asm\asm::asm_lookupanimfromalias("animscripted", "bank_heist_idle");
  var_2 = level.bank_hvt_jugg scripts\asm\asm::asm_getxanim("animscripted", var_1);

  for(;;) {
    level.bank_hvt_usb scriptmodelplayanimdeltamotionfrompos("cp_bank_heist_office_usb_idle", level.bank_hvt.animstruct.origin, level.bank_hvt.animstruct.angles);
    level.bank_hvt aisetanim("animscripted", var_0);
    level.bank_hvt_jugg aisetanim("animscripted", var_1);
    wait getanimlength(var_2);
  }
}

function hvt_exit() {
  level.bank_hvt_jugg notify("stop_lookat");
  level.bank_hvt_jugg setlookatentity();
  level.bank_hvt_usb scriptmodelplayanimdeltamotionfrompos("cp_bank_heist_office_usb_end", level.bank_hvt.animstruct.origin, level.bank_hvt.animstruct.angles);
  thread spawnflags_check();
  level.bank_hvt_jugg scripts\asm\shared\mp\utility::burndowntime("bank_heist_end");
  clear_animpos(level.bank_hvt_jugg);
  select_bunker_roof_spawners(level.bank_hvt_jugg);
  level.bank_hvt.ignoreall = 1;
}

function select_bunker_roof_spawners() {
  scripts\cp\cp_modular_spawning::set_goal_pos(self.origin);
  self.goalradius = 1024;
  self.demeanoroverride = "combat";
  scripts\asm\asm_bb::bb_requestmovetype("combat");
}

function spawnflags_check() {
  level.bank_hvt scripts\asm\shared\mp\utility::burndowntime("bank_heist_guy_end");
  close_elevator_doors("_third");
}

function clear_animpos(var_0) {
  var_0 scripts\asm\shared\mp\utility::bunkercounteruav();
  var_0 setlookatentity();
  var_0.ignoreall = 0;
  var_0.playing_skit = undefined;
  var_0.invulnerable = 0;
}

function go_into_elevator() {
  if(isDefined(level.bank_hvt)) {
    var_0 = scripts\engine\utility::getStruct("hvt_elevator_pos", "targetname");
    scripts\cp\cp_modular_spawning::set_goal_pos(var_0.origin);
    self.goalradius = 8;
    scripts\engine\utility::ref_143a7("goal_reached", "goal", "near_goal", "death");

    if(isDefined(level.bank_hvt)) {
      thread scripts\cp\utility::cp_add_dialogue_line(&"CP_DWN_TWN_OBJECTIVES/HVT_ROOF");
      return;
    }

    return;
  }
}

function move_up_to_roof() {
  if(isDefined(level.bank_hvt)) {
    objective_state(level.hvt_obj_num, "current");
    var_0 = spawn("script_origin", self.origin);
    self linkTo(var_0);
    var_1 = scripts\engine\utility::getStructArray("hvt_roof_spawn", "targetname");
    var_2 = var_1[0];
    var_0 moveTo(var_2.origin, 5);
    var_0 waittill("movedone");
    self unlink();
    self.origin = var_2.origin;
    self.angles = var_2.angles;
    self.ignoreall = 1;
    scripts\cp\cp_modular_spawning::set_goal_pos(self.origin);
    self.goalradius = 8;
    var_0 delete();
    return;
  }
}

function roof_jugg_logic(var_0) {
  self.ignoreall = 1;
  scripts\cp\cp_modular_spawning::set_goal_pos(self.origin);
  self.goalradius = 8;
  thread roof_jugg_run_once_doors_open();
}

function roof_jugg_run_once_doors_open() {
  self endon("death");
  scripts\engine\utility::flag_wait("roof_elevator_open");
  self notify("enter_combat");
  self.ignoreall = 1;
  var_0 = scripts\engine\utility::getStructArray("hvt_roof_exfil", "targetname");
  var_1 = var_0[0];
  scripts\cp\cp_modular_spawning::set_goal_pos(var_1.origin);
  self.goalradius = 8;
  self.demeanoroverride = "sprint";
  scripts\asm\asm_bb::bb_requestmovetype("sprint");
  self allowedstances("stand");
  thread ignore_players_not_on_roof(4000, self.origin, self.origin[2] + 500, self.origin[2] - 50);
  thread hasbrspecialistbonus();
}

function hasbrspecialistbonus() {
  self endon("death");
  scripts\engine\utility::flag_wait("heli_engage");
  scripts\cp\cp_modular_spawning::set_goal_pos(self.origin);
  self.goalradius = 1024;
  self.demeanoroverride = "combat";
  scripts\asm\asm_bb::bb_requestmovetype("combat");
}

function ignore_players_not_on_roof(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  self endon("death");
  var_4 = var_0 * var_0;
  var_5 = 0;

  while(!var_5) {
    for(var_6 = 0; var_6 < level.players.size; var_6++) {
      var_7 = level.players[var_6];

      if(distancesquared(var_7.origin, var_1) <= var_4) {
        if(isDefined(var_2)) {
          if(var_7.origin[2] > var_2) {
            continue;
          }
        }

        if(isDefined(var_3)) {
          if(var_7.origin[2] < var_3) {
            continue;
          }
        }

        var_5 = 1;
      }
    }

    wait 1;
  }

  self.ignoreall = 0;
}

function give_hvt_ar() {
  if(isDefined(level.hvt_ar)) {
    level.hvt_ar delete();
  }

  if(isDefined(level.bank_hvt)) {
    var_0 = scripts\cp\cp_weapon::buildweapon("iw8_ar_akilo47_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
    level.bank_hvt giveweapon(var_0);
    level.bank_hvt takeweapon(level.bank_hvt.weapon);
    level.bank_hvt setspawnweapon(var_0);
    level.bank_hvt scripts\common\utility::initweapon(var_0);
    level.bank_hvt scripts\anim\shared::placeweaponon(var_0, "right");
    return;
  }
}

function hvt_run_to_heli() {
  if(isDefined(level.bank_hvt)) {
    clear_animpos(level.bank_hvt);
    level.bank_hvt.allowpain = 1;
    level.bank_hvt.ignore_all = 1;
    level.bank_hvt.force_drop = "hvt_key";
    wait 1;
    objective_state(level.hvt_obj_num, "current");
    self notify("enter_combat");
    self.ignoreall = 1;
    var_0 = scripts\engine\utility::getStructArray("hvt_roof_exfil", "targetname");
    var_1 = var_0[0];
    scripts\cp\cp_modular_spawning::set_goal_pos(var_1.origin);
    self.goalradius = 8;
    self.demeanoroverride = "sprint";
    scripts\asm\asm_bb::bb_requestmovetype("sprint");
    self allowedstances("stand");
    thread hvt_if_heli_destroyed();
    thread set_hvt_gone_flag();
    scripts\engine\utility::ref_143a7("goal_reached", "goal", "near_goal", "death");
    return;
  }

  scripts\engine\utility::flag_set("heli_engage");
}

function set_hvt_gone_flag() {
  self.isinlaststand = &spawnhandled;
  self waittill("death");
  scripts\engine\utility::flag_set("heli_engage");
}

function spawnhandled(var_0) {
  if(isPlayer(var_0.eattacker)) {
    scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0.eattacker, "obj_target_eliminated");
    return;
  }
}

function hvt_if_heli_destroyed() {
  self endon("death");
  scripts\engine\utility::flag_wait("heli_engage");
  self.ignoreall = 0;
  scripts\cp\cp_modular_spawning::set_goal_pos(self.origin);
  self.goalradius = 1024;
}

function hvt_made_it_to_heli() {
  if(!scripts\engine\utility::flag("heli_engage")) {
    if(isDefined(level.bank_hvt) && isalive(level.bank_hvt)) {
      thread setup_hvt_in_heli(level.heli, "tag_pilot2");
      self.nocorpse = 1;
      self dodamage(self.health + 1000, self.origin);
      level.hvt_in_heli = 1;
      level thread scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_bank_hvt_escape_chopper_10");
      return;
    }

    thread ref_13aed();
    return;
  }
}

function ref_13aed() {
  wait 4;
  level thread scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_bank_hvt_down_10");
}

function setup_hvt_in_heli(var_0, var_1, var_2) {
  var_3 = "tag_pilot";

  if(isDefined(var_0)) {
    var_3 = var_0;
  }

  var_4 = (0, 0, 0);

  if(isDefined(var_1)) {
    var_4 = var_1;
  }

  var_5 = (0, 0, 0);

  if(isDefined(var_2)) {
    var_5 = var_2;
  }

  if(!self tagexists(var_3)) {
    var_3 = "tag_pilot1";
  }

  self.hvt_in_heli = spawn("script_model", self gettagorigin(var_3));
  self.hvt_in_heli setModel("british_pilot_fullbody");
  self.hvt_in_heli linkTo(self, var_3, var_4, var_5);
  self.hvt_in_heli scriptmodelplayanim("vh_blima_rappel_pilot");
  thread clean_up_on_heli_death();
}

function clean_up_on_heli_death() {
  self waittill("death");

  if(isDefined(self.hvt_in_heli)) {
    self.hvt_in_heli delete();
  }

  wait 3;
  level thread scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_bank_clear_lz_10");
}

function should_drop_hvt_key(var_0) {
  if(istrue(self.bank_hvt)) {
    return true;
  }

  return false;
}

function drop_hvt_key(var_0) {
  var_1 = spawnStruct();
  var_1.origin = self.origin;
  var_1.angles = (0, 0, 0);
  level.spawnhumandogtags = 1;
  create_key_card(var_1);
}

function waittill_players_on_roof() {
  var_0 = scripts\engine\utility::getStructArray("hvt_roof_spawn", "targetname");
  var_1 = var_0[0];
  var_2 = -200;
  wait_for_player_nearby(var_1.origin, 4000, var_2);
  level.players_on_roof = 1;
}

function init_vault_assault_rooftop(var_0, var_1) {
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_post_vault");
  scripts\cp\cp_spawning_util::ref_13bbd(0);
}

function start_vault_assault_rooftop(var_0, var_1) {
  var_2 = scripts\cp\cp_modular_spawning::get_spawned_ai_from_group_struct("bank_combat_init");

  if(isDefined(var_2)) {
    foreach(var_4 in var_2) {
      var_4 scripts\cp\cp_modular_spawning::script_kill_ai();
    }
  }

  var_2 = scripts\cp\cp_modular_spawning::get_spawned_ai_from_group_struct("bank_combat_init_sniper");

  if(isDefined(var_2)) {
    foreach(var_4 in var_2) {
      var_4 scripts\cp\cp_modular_spawning::script_kill_ai();
    }
  }

  var_2 = scripts\cp\cp_modular_spawning::get_spawned_ai_from_group_struct("bank_combat_init_rpg");

  if(isDefined(var_2)) {
    foreach(var_4 in var_2) {
      var_4 scripts\cp\cp_modular_spawning::script_kill_ai();
    }

    return;
  }
}

function end_vault_assault_rooftop(var_0, var_1) {
  scripts\cp\cp_objectives::overridenextstep(var_0, "vault_assault_rooftop_heli");
}

function ref_12d84(var_0) {
  self.never_kill_off = 1;
  thread ref_1301d();
}

function ref_1301d() {
  self endon("death");
  var_0 = ["rooftop_back_org_target", "rooftop_front_org_target"];
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = scripts\engine\utility::getStruct(var_3, "targetname");
    var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  var_6 = scripts\engine\utility::getclosest(self.origin, var_1);
  scripts\cp\cp_modular_spawning::set_goal_radius(96);
  scripts\cp\cp_modular_spawning::set_goal_pos(var_6.origin);
  scripts\engine\utility::ref_143ad("goal", "goal_reached");
  self.never_kill_off = undefined;
  scripts\cp\cp_modular_spawning::return_to_last_goalRadius();
}

function ref_140bf(var_0, var_1) {
  var_0 scripts\cp\cp_modular_spawning::spawner_init();

  if(isDefined(level.ref_14682) && var_0.origin[2] > level.ref_14682) {
    return 0;
  }

  return scripts\cp\cp_spawner_scoring::standard_spawnpoint_valid(var_0, var_1);
}

function ref_140be(var_0, var_1) {
  if(isDefined(level.ref_14682) && var_0.origin[2] > level.ref_14682) {
    return 0;
  }

  return scripts\cp\cp_spawner_scoring::cluster_spawnpoint_valid(var_0, var_1);
}

function init_vault_assault_rooftop_heli(var_0, var_1) {
  scripts\cp\cp_spawning_util::ref_13bbd(0);
}

function start_vault_assault_rooftop_heli(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct("vault_assault_start", "targetname");
  scripts\cp\cp_modular_spawning::pause_group_by_group_name("wave_spawning");
  thread start_mortars();
  level.exfil_delay = gettime() + 120000;
  level.mark_heli = 1;

  if(isDefined(level.heli)) {
    thread play_kill_heli_nags();
  }

  level.ref_121c0 = ["bank_roof_paratroopers_low"];
  thread ref_135af();

  while(isDefined(level.heli)) {
    wait 0.1;
  }

  level.ref_121c0 = ["bank_roof_paratroopers_low", "bank_roof_paratroopers_high"];
  scripts\cp\utility::ref_123fe("mus_cp_money_helo_destroyed");
  level notify("enemy_heli_eliminated");
  level thread scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_bank_defend_rooftop_10");
  level.mark_heli = 0;
  scripts\cp\cp_objectives::overridenextstep(var_0, "vault_assault_rooftop_defend");
}

function end_vault_assault_rooftop_heli(var_0, var_1) {}

function ref_135af() {
  level endon("stop_paratroopers");

  for(;;) {
    while(level.spawned_ai.size >= 16) {
      wait 1;
    }

    if(isDefined(level.heli)) {
      scripts\cp\cp_aiparachute::request_paratroopers(scripts\engine\utility::random(level.ref_121c0), undefined, (-13512, 66432, 5904));
      thread ref_142ec();
    } else if(randomint(100) > 50) {
      scripts\cp\cp_modular_spawning::run_spawn_module("bank_combat_heli_roof_low");
    } else {
      scripts\cp\cp_modular_spawning::run_spawn_module("bank_combat_heli_roof_high");
    }

    wait 10;
  }
}

function play_kill_heli_nags() {
  level endon("enemy_heli_eliminated");
  level endon("game_ended");
  thread set_flag_when_rpg_picked_up();

  for(;;) {
    wait 60;

    if(!istrue(level.rpg_picked_up)) {
      scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_bank_grab_rpg_10");
      continue;
    }

    scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_bank_enemy_heli_10");
  }
}

function set_flag_when_rpg_picked_up() {
  level endon("enemy_heli_eliminated");
  level endon("game_ended");
  level waittill("rpg_picked_up", var_0);
  level.rpg_picked_up = 1;
}

function move_marker_to_heli() {
  while(isDefined(level.bank_hvt)) {
    wait 0.1;
  }

  wait 0.1;

  if(isDefined(level.heli)) {
    objective_setplayintro(level.hvt_obj_num, 0);
    objective_setplayoutro(level.hvt_obj_num, 0);
    objective_setbackground(level.hvt_obj_num, 0);
    objective_state(level.hvt_obj_num, "current");
    objective_icon(level.hvt_obj_num, "icon_waypoint_objective_general");
    objective_onentity(level.hvt_obj_num, level.heli);
    objective_setzoffset(level.hvt_obj_num, 70);
    thread watchforhelideath();
    return;
  }

  scripts\cp\cp_objectives::freeworldid("bank_hvt");
}

function tag_heli_with_head_icon(var_0) {
  level.heli_headicon = deleteheadicon(var_0);
  setheadiconfriendlyimage(level.heli_headicon, "hud_icon_hardpoint_diamond");
  setheadiconsnaptoedges(level.heli_headicon, 0);
}

function watchforhelideath() {
  level endon("game_ended");
  level endon("tmtyl_squad_complete");
  self waittill("death");

  if(isDefined(level.heli_headicon)) {
    setheadiconimage(level.heli_headicon);
  }

  scripts\cp\cp_objectives::freeworldid("bank_hvt");
  level thread scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_bank_defend_rooftop_10");
}

function init_vault_assault_rooftop_defend(var_0, var_1) {
  scripts\cp\cp_spawning_util::ref_13bbd(0);
}

function start_vault_assault_rooftop_defend(var_0, var_1) {
  level thread scripts\cp\infilexfil\blima_exfil::listen_for_exfil();

  if(isDefined(level.exfil_delay)) {
    while(gettime() < level.exfil_delay) {
      wait 0.1;
    }
  }

  while(isDefined(level.heli)) {
    wait 0.1;
  }

  wait 0.1;
  level notify("stop_heli_rein");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_roof");
  wait 0.1;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_roof_juggernaut");
  wait 0.1;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_heli_roof");
  var_2 = scripts\engine\utility::getStructArray("vault_assault_rooftop", "targetname");
  var_3 = var_2[0];
  level notify("call_exfil", var_3.origin, 1);
  level notify("stop_paratroopers");

  foreach(var_5 in level.players) {
    var_5 notify("drop_saw");
  }

  while(!isDefined(level.exfil_heli)) {
    wait 0.1;
  }

  level waittill("arrive_at_exfil_location");
}

function end_vault_assault_rooftop_defend(var_0, var_1) {
  scripts\cp\cp_objectives::overridenextstep(var_0, "vault_assault_rooftop_exfil");
}

function ref_13e3c(var_0) {
  wait var_0;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_heli_roof_low");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_heli_roof_high");
}

function init_vault_assault_rooftop_exfil(var_0, var_1) {
  scripts\cp\cp_spawning_util::ref_13bbd(0);
}

function start_vault_assault_rooftop_exfil(var_0, var_1) {
  thread delay_and_play_vo_to_team(level, 10);
  level waittill("ready_to_exfil");
  level.battlechatterenabled = 0;
  scripts\cp\utility::ref_123fe("mus_cp_money_helo_exfil");

  foreach(var_3 in level.players) {
    level notify("kill_queued_bc_sound_" + var_3.name);
    var_3 setsoundsubmix("cp_matchend_music", 5);
  }

  wait 2;

  if(istrue(level.spawninfluencepoints)) {
    foreach(var_3 in level.players) {
      var_3 scripts\cp_mp\xmike109::scriptable_callback("downtown_2");
    }

    level thread scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_bank_mission_successful_intel_10");
  } else {
    level thread scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_bank_mission_successful_10");
  }

  foreach(var_3 in level.players) {
    var_3 scripts\cp_mp\xmike109::scriptable_callback("downtown_3");

    if(scripts\cp\cp_relics::calldropbag()) {
      if(scripts\cp\cp_gameskill::get_gameskill() != 3) {
        var_3 thread scripts\cp_mp\xmike109::scriptable_callback("strongbox_mod");
        continue;
      }

      var_3 thread scripts\cp_mp\xmike109::scriptable_callback("strongbox_mod_vet");
    }
  }

  thread mp_shipment_patch();
}

function end_vault_assault_rooftop_exfil(var_0, var_1) {}

function mp_shipment_patch() {
  foreach(var_1 in level.players) {
    var_1 thread scripts\mp\vehicles\vehicle_damage_mp::ref_1340d(2, 1, 1);
  }

  wait 2;

  foreach(var_1 in level.players) {
    if(!istrue(var_1.try_to_punish_with_jugg)) {
      var_1.invulnerable = 1;
      var_1 allowmovement(0);
    }

    var_4 = scripts\engine\utility::getStruct("vaultassault_camera_ending", "targetname");
    var_5 = var_4.origin;
    var_6 = scripts\engine\utility::getStruct(var_4.target, "targetname");
    var_7 = spawn("script_model", var_5);
    var_7 setModel("tag_origin");
    var_7.angles = var_4.angles;
    var_7 moveTo(var_6.origin, 20, 1, 1);
    var_1 playerhide();
    var_1 allowfire(0);
    var_1 disableoffhandweapons();
    var_1 disableusability();
    var_1 allowmovement(0);
    var_1 setclientomnvar("ui_hide_hud", 1);
    spawn_endgame_camera(var_1, var_7);
    var_1 lerpfovscalefactor(0, 0);
  }
}

function spawn_endgame_camera(var_0) {
  self.ignoreme = 1;
  self cameralinkTo(var_0, "tag_origin", 1);
  self setclientdvar("LQKPQMPRQN", 1);
  self setdepthoffield(0, 128, 512, 4000, 6, 1.8);

  if(self isconsoleplayer()) {
    self setclientdvar("QTSPTNLOL", "50");
    return;
  }
}

function play_get_on_heli_nags() {
  level endon("ready_to_exfil");
  level endon("game_ended");

  for(;;) {
    wait 30;
    level thread scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_ovl_bank_heli_extract_10");
  }
}

function wait_for_player_nearby(var_0, var_1, var_2, var_3) {
  var_4 = var_1 * var_1;
  var_5 = undefined;

  if(isDefined(var_2)) {
    var_5 = var_0[2] + var_2;
  }

  var_6 = undefined;
  jumpiffalse(isDefined(var_3)) LOC_00000029;
  var_6 = var_0[2] + var_3;

  for(;;) {
    var_7 = 0;

    foreach(var_9 in level.players) {
      if(distance2dsquared(var_9.origin, var_0) <= var_4) {
        if(isDefined(var_5)) {
          if(var_9.origin[2] < var_5) {
            continue;
          }
        }

        if(isDefined(var_6)) {
          if(var_9.origin[2] > var_6) {
            continue;
          }
        }

        var_7 = 1;
      }
    }

    if(var_7) {
      break;
    }

    wait 0.1;
  }
}

function send_heli_reinforcements(var_0) {
  level endon("stop_heli_rein");

  for(;;) {
    wait var_0;

    while(level.spawned_enemies.size > 12) {
      wait 0.1;
    }
  }
}

function drop_intel_from_hvt() {}

function open_elevator_doors_roof() {
  var_0 = getEntArray("elevator_door", "targetname");

  foreach(var_2 in var_0) {
    var_2.starting_pos = var_2.origin;

    if(isDefined(var_2.target)) {
      var_3 = scripts\engine\utility::getStruct(var_2.target, "targetname");
      var_2 moveTo(var_3.origin, 2, 0.1, 0.1);
    }
  }

  wait 2;
}

function close_elevator_doors_roof() {
  var_0 = getEntArray("elevator_door", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.starting_pos)) {
      var_2 moveTo(var_2.starting_pos, 2, 0.1, 0.1);
    }
  }

  wait 2;
}

function open_elevator_doors(var_0, var_1) {
  var_2 = getEntArray("elevator_door" + var_0, "targetname");
  var_3 = undefined;

  foreach(var_5 in var_2) {
    if(!isDefined(var_3)) {
      var_3 = var_5;
    }

    if(!istrue(var_5.open)) {
      var_5.starting_pos = var_5.origin;

      if(isDefined(var_5.target)) {
        var_6 = scripts\engine\utility::getStructArray(var_5.target, "targetname");
        var_7 = var_6[0];
        var_5 moveTo(var_7.origin, 2, 0.1, 0.1);
      }
    }
  }

  if(isDefined(var_3)) {
    var_9 = (0, 0, 0);
    var_10 = var_3.origin + var_9;
    playsoundatpos(var_10, "scn_cp_bank_heist_elevator_open_2sec");
  }

  wait 2;

  foreach(var_5 in var_2) {
    var_5.open = 1;
    var_5 connectpaths();
  }

  if(isDefined(var_1)) {
    level notify(var_1);
    return;
  }
}

function close_elevator_doors(var_0) {
  var_1 = getEntArray("elevator_door" + var_0, "targetname");
  var_2 = undefined;

  foreach(var_4 in var_1) {
    if(!isDefined(var_2)) {
      var_2 = var_4;
    }

    if(istrue(var_4.open)) {
      if(isDefined(var_4.starting_pos)) {
        var_4 moveTo(var_4.starting_pos, 2, 0.1, 0.1);
      }
    }
  }

  if(isDefined(var_2)) {
    var_6 = (0, 0, 0);
    var_7 = var_2.origin + var_6;
    playsoundatpos(var_7, "scn_cp_bank_heist_elevator_close_2sec");
  }

  wait 2;

  foreach(var_4 in var_1) {
    var_4.open = undefined;
    var_4 disconnectPaths();
  }
}

function setup_module_groups() {}

function create_deposit_box_interaction(var_0) {
  var_1 = spawn("script_model", var_0.origin);
  var_1 setModel("lm_hardware_bank_safety_deposit_door_a_01_cp");
  waitframe();
  var_1 setHintString(&"CP_DWN_TWN_OBJECTIVES/DEPOSIT_BOX");
  var_1 setCursorHint("HINT_BUTTON");
  var_1 sethintdisplayrange(200);
  var_1 sethintdisplayfov(65);
  var_1 setuserange(72);
  var_1 setusefov(65);
  var_1 sethinttag("tag_hint");
  var_1 sethintonobstruction("show");
  var_1 setuseholdduration("duration_none");
  var_1 makeusable();
  var_1.targetname = "interaction";

  if(isDefined(var_0.angles)) {
    var_1.angles = var_0.angles;
  } else {
    var_1.angles = (0, 0, 0);
  }

  thread deposit_box_activate(var_1);
  return var_1;
}

function create_usb_pickup_interaction(var_0, var_1) {
  var_2 = spawn("script_model", var_0.origin);
  var_2 setModel("electronics_usb_thumb_drive");
  var_2 setHintString(&"CP_DWN_TWN_OBJECTIVES/KEY_CARD");
  var_2 setCursorHint("HINT_BUTTON");
  var_2 sethintdisplayrange(200);
  var_2 sethintdisplayfov(65);
  var_2 setuserange(72);
  var_2 setusefov(65);
  var_2 sethintonobstruction("show");
  var_2 setuseholdduration("duration_none");
  var_2 makeusable();

  if(istrue(var_1)) {
    objective_position(level.crypto_key_objective.objectiveindex, var_2.origin + (0, 0, 10));
    objective_setbackground(level.crypto_key_objective.objectiveindex, 2);
  }

  var_2 hudoutlineenable("outlinefill_depth_cyan");
  level notify("deposit_usb_found");

  for(;;) {
    var_2 waittill("trigger", var_3);

    if(!var_3 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    level.key_card_acquired = 1;
    var_2 hide();
    var_2 hudoutlinedisable();
    thread ref_12501(level);
    var_3 scripts\cp\intel\cp_intel::give_intel_weapon("intel_put_usb_in_tablet");

    if(istrue(level.spawnhumandogtags)) {
      level.spawninfluencepoints = 1;
    }

    if(istrue(var_1)) {
      objective_state(level.crypto_key_objective.objectiveindex, "done");
    }

    break;
  }

  wait 0.1;
  var_2 delete();
}

function ref_12501(var_0) {
  var_0 endon("death");
  wait 2;
  scripts\cp\cp_player_battlechatter::trysaylocalsound(var_0, "obj_package");
}

function create_key_card_interaction(var_0) {
  var_1 = spawnStruct();
  var_1.origin = var_0.origin;
  var_1.targetname = "interaction";
  var_1.script_noteworthy = "key_card_interaction";
  var_1.requires_power = 0;
  var_1.spend_type = "null";
  var_1.model = spawn("script_model", var_1.origin);
  var_1.model setModel("electronics_usb_thumb_drive");

  if(isDefined(var_0.angles)) {
    var_1.model.angles = var_0.angles;
  } else {
    var_1.model.angles = (0, 0, 0);
  }

  var_1.model hudoutlineenable("outlinefill_depth_red");
  var_1.cost = 0;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_1);
}

function tag_key_card_with_head_icon(var_0) {
  level.key_card_headicon = deleteheadicon(var_0);
  setheadiconfriendlyimage(level.key_card_headicon, "hud_icon_hardpoint_diamond");
  setheadiconsnaptoedges(level.key_card_headicon, 0);
}

function remove_key_card_head_icon() {
  if(isDefined(level.key_card_headicon)) {
    setheadiconimage(level.key_card_headicon);
    return;
  }
}

function init_bank_interactions() {
  scripts\cp\cp_interaction::register_interaction("key_card_interaction", "null", undefined, &key_card_hint, &key_card_activate, 0, 0, undefined);
  scripts\cp\cp_interaction::register_interaction("vault_elevator_button_interaction", "null", undefined, &elevator_button_hint, &elevator_button_activate, 0, 0, undefined);
}

function delay_then_run_cover_node_spawning(var_0, var_1) {
  level endon("stop_delayed_spawn_module");
  wait var_1;
  level.passive_wave_settings.high_threshold = 18;
  var_2 = 36 - level.spawned_enemies.size;
  level.passive_wave_settings.max_count = max(0, var_2);
  scripts\cp\cp_modular_spawning::run_spawn_module(var_0);
}

function delay_then_run_spawn_module(var_0, var_1, var_2) {
  level endon("stop_delayed_spawn_module");
  wait var_1;
  var_3 = undefined;

  if(isDefined(var_2)) {
    var_3 = scripts\cp\cp_modular_spawning::set_wave_ref_override(var_2);
    return;
  }
}

function ref_1337e(var_0) {
  wait var_0;
  var_1 = scripts\engine\utility::getStruct("vault_assault_start", "targetname");
  var_2 = scripts\cp\cp_modular_spawning::get_module_structs_by_groupname("wave_spawning");

  foreach(var_4 in var_2) {
    thread ref_1337d(var_4);
  }
}

function ref_1337d(var_0) {
  scripts\cp\cp_modular_spawning::add_spawn_scoring_poi(var_0.origin, 3000, 10000);
  wait_for_player_nearby(var_0.origin, 3500);
  scripts\cp\cp_modular_spawning::remove_spawn_scoring_poi(var_0.origin);
  scripts\cp\cp_modular_spawning::add_spawn_scoring_poi(var_0.origin, 2000, 4000);
}

function short_and_long_delay(var_0, var_1, var_2, var_3) {
  if(istrue(var_0.longer_spawn_delay)) {
    return var_2;
  }

  return var_1;
}

function should_run_event(var_0) {
  return false;
}

function spawn_static_trucks() {
  level endon("game_ended");
  wait 1;
  level.static_trucks = [];
  level.static_ks_crates = [];
  var_0 = scripts\engine\utility::getStructArray("static_ks_crate", "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = 0;

    foreach(var_4 in level.static_ks_crates) {
      if(var_4.origin == var_0[var_1].origin) {
        var_2 = 1;
      }
    }

    if(!var_2) {
      var_4 = spawn("script_model", var_0[var_1].origin);
      var_4 setModel("military_carepackage_01_friendly");
      level.static_ks_crates[level.static_ks_crates.size] = var_4;
    }
  }

  level.static_ks_tablets = [];
  var_6 = scripts\engine\utility::getStructArray("static_ks_tablet", "targetname");

  for(var_1 = 0; var_1 < var_6.size; var_1++) {
    var_2 = 0;

    foreach(var_8 in level.static_ks_tablets) {
      if(var_8.origin == var_6[var_1].origin) {
        var_2 = 1;
      }
    }

    if(!var_2) {
      var_8 = spawn("script_model", var_6[var_1].origin);
      var_8 setModel("offhand_wm_tablet");

      if(isDefined(var_6[var_1].target)) {
        var_8.target = var_6[var_1].target;
      }

      thread activate_ks_on_use();
      level.static_ks_tablets[level.static_ks_tablets.size] = var_8;
    }
  }

  level.static_rpgs = [];
  var_10 = scripts\engine\utility::getStructArray("rpg_pickup", "targetname");

  for(var_1 = 0; var_1 < var_10.size; var_1++) {
    var_2 = 0;

    foreach(var_12 in level.static_rpgs) {
      if(var_12.origin == var_10[var_1].origin) {
        var_2 = 1;
      }
    }

    if(!var_2) {
      var_12 = spawn("script_model", var_10[var_1].origin);
      var_12.angles = var_10[var_1].angles;
      waitframe();
      var_12 setModel("weapon_wm_la_rpapa7");
      thread activate_rpgs_on_use();
      level.static_rpgs[level.static_rpgs.size] = var_12;
    }
  }

  thread spawn_enemy_tanks();
  thread ref_135fa();
}

function spawn_enemy_tanks() {
  var_0 = scripts\engine\utility::getStructArray("bank_tank", "targetname");
  level.altgunnerturret = "sentry_minigun_mp";
  level.enemy_tanks = [];

  foreach(var_2 in var_0) {
    level thread scripts\mp\challenges_mp::spawn_enemy_tank(var_2);
    wait randomintrange(3, 7);
  }
}

function ref_135fa() {
  var_0 = scripts\engine\utility::getStructArray("bank_wheelson", "targetname");
  var_1 = 0;

  foreach(var_3 in var_0) {
    var_4 = scripts\engine\utility::getStruct(var_3.target, "targetname");
    thread spawn_remote_tank(level, var_4, "tank" + var_1);
    var_1++;
    wait 1;
  }

  var_0 = scripts\engine\utility::getStructArray("bank_wheelson_lobby", "targetname");

  foreach(var_3 in var_0) {
    var_4 = scripts\engine\utility::getStruct(var_3.target, "targetname");
    thread spawn_remote_tank(level, var_4, "tank" + var_1);
    var_1++;
    wait 1;
  }
}

function activate_ks_on_use() {
  level endon("game_ended");
  var_0 = &"CP_BR/DRONE_STRIKE";
  self setHintString(var_0);
  self setCursorHint("HINT_BUTTON");
  self sethintdisplayrange(500);
  self sethintdisplayfov(65);
  self setuserange(72);
  self setusefov(65);
  self sethintonobstruction("show");
  self setuseholdduration("duration_none");
  self makeusable();

  for(;;) {
    self waittill("trigger", var_1);

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(isDefined(self.target)) {
      var_1.drone_strike_dir_override = scripts\engine\utility::getStruct(self.target, "targetname");
    }

    var_1 thread scripts\cp\crafting_system::giveitembasedoncraftingstruct("cruise_missile");
    thread make_enemies_ignore_you();
    self makeunusable();
    break;
  }

  self delete();
}

function make_enemies_ignore_you() {
  scripts\cp\utility::allow_player_ignore_me(1);
  wait 10;
  scripts\cp\utility::allow_player_ignore_me(0);
  self.drone_strike_dir_override = undefined;
}

function activate_rpgs_on_use() {
  level endon("game_ended");
  var_0 = &"CP_BR/RPG_PICKUP";
  self setHintString(var_0);
  self setCursorHint("HINT_BUTTON");
  self sethintdisplayrange(500);
  self sethintdisplayfov(65);
  self setuserange(72);
  self setusefov(65);
  self sethintonobstruction("hide");
  self setuseholdduration("duration_none");
  self makeusable();

  for(;;) {
    self waittill("trigger", var_1);

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(!var_1 scripts\common\utility::is_weapon_pickup_allowed()) {
      continue;
    }

    var_2 = getentarrayinradius("dropped_weapon", "targetname", self.origin, 512);

    if(isDefined(var_2) && var_2.size > 0) {
      foreach(var_4 in var_2) {
        if(isDefined(var_4) && isDefined(var_4.classname) && issubstr(var_4.classname, "iw8_la_rpapa7_mp")) {
          var_4 delete();
        }
      }
    }

    var_6 = spawnStruct();
    var_6.loadoutprimary = "iw8_la_rpapa7_mp";
    var_6.loadoutprimaryattachments = ["none", "none", "none", "none", "none", "none"];
    var_6.loadoutprimarycamo = "none";
    var_6.loadoutprimaryreticle = "none";
    var_6.loadoutprimaryvariantid = -1;
    var_1.entnumber = var_1 getentitynumber();
    var_6.loadoutprimarypaintjobid = 0;
    var_6.loadoutprimarycosmeticattachment = "none";
    var_6.loadoutprimaryobject = scripts\cp\cp_weapon::buildweapon(var_6.loadoutprimary);
    var_6.loadoutprimaryfullname = createheadicon(var_6.loadoutprimaryobject);
    var_7 = ref_1247d(var_1);
    var_8 = ref_12475(var_1);
    var_9 = var_6.loadoutprimaryobject;

    if(!var_1 hasweapon("iw8_la_rpapa7_mp")) {
      if(scripts\cp\cp_weapon::ref_124ad(var_1)) {
        scripts\cp\cp_weapon::minigamefinishcount(var_1);
        var_1 waittill("weapon_change");

        while(scripts\cp\cp_weapon::ref_124ad(var_1)) {
          waitframe();
        }

        while(nullweapon(var_1 getcurrentweapon())) {
          waitframe();
        }
      }

      if(!var_8) {
        var_1 scripts\cp\cp_weapons::minigun_track_target_think();
        var_1 giveweapon(var_9);
      } else {
        var_9 = raise_airlock(var_1);
      }
    }

    var_10 = weaponclipsize(var_9);
    var_11 = weaponmaxammo(var_9);
    var_1 setweaponammoclip(var_9, var_10);
    var_1 setweaponammostock(var_9, var_11);

    if(!var_7 && !scripts\cp\cp_weapon::ref_124ad(var_1)) {
      var_1 switchtoweaponimmediate(var_9);
    }

    level notify("rpg_picked_up", var_1);
    wait 3;
  }

  self delete();
}

function ref_1247d() {
  var_0 = self getcurrentprimaryweapon();

  if(var_0.basename == "iw8_la_rpapa7_mp") {
    return true;
  }

  return false;
}

function ref_12475() {
  foreach(var_1 in self getweaponslistprimaries()) {
    if(var_1.basename == "iw8_la_rpapa7_mp") {
      return true;
    }
  }

  return false;
}

function raise_airlock() {
  foreach(var_1 in self getweaponslistprimaries()) {
    if(var_1.basename == "iw8_la_rpapa7_mp") {
      return var_1;
    }
  }
}

function modescorewinner(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");

  if(isDefined(var_4)) {
    level endon(var_4);
  }

  if(!isDefined(var_2)) {
    var_2 = 2000;
  }

  if(!isDefined(var_3)) {
    var_3 = 1;
  } else {
    var_3 = max(var_3, 0.05);
  }

  GscBinSkip4(0x35, var_0, var_1, var_2, var_3);
}

function modespawn(var_0, var_1, var_2, var_3) {
  for(;;) {
    var_4 = getentarrayinradius("dropped_weapon", "targetname", var_1, var_2);

    if(isDefined(var_4) && var_4.size > 0) {
      foreach(var_6 in var_4) {
        if(isDefined(var_6) && isDefined(var_6.classname) && issubstr(var_6.classname, var_0)) {
          var_6 delete();
        }
      }
    }

    wait var_3;
  }
}

function spawn_remote_tank(var_0, var_1, var_2) {
  var_3 = var_0;

  if(isDefined(var_3)) {
    if(!isDefined(var_3.angles)) {
      var_3.angles = (0, 0, 0);
    }

    var_4 = scripts\cp\cp_remote_tank::spawn_remote_tank(var_3, var_1);
    var_4 thread scripts\cp\cp_remote_tank::fire_on_nearby_players();
    var_4.enemy_notify_range = 2000;
    var_4.max_detection_sq = 2250000;
    var_4 makeunusable();
    var_4.mgturret makeunusable();
    thread damage_monitor();
    thread init_global_cp_script_funcs();
    thread ref_12bc0(var_4, var_0);
    return;
  }
}

function ref_12bc0(var_0, var_1) {
  self endon("death");

  if(isDefined(var_1)) {
    scripts\engine\utility::flag_wait(var_1);
  }

  scripts\engine\utility::flag_wait("activate_wheelsons");
  wait 5;
  self vehicle_setspeed(1, 1, 1);
  thread ref_145b3(var_0);
}

function init_global_cp_script_funcs() {
  var_0 = createnavobstaclebyent(self);
  self waittill("death");

  if(isDefined(var_0)) {
    destroynavobstacle(var_0);
    return;
  }
}

function ref_145b3(var_0) {
  self endon("death");
  var_1 = ref_145ad(var_0);
  var_2 = 1;
  var_3 = 3;
  var_4 = 40000;

  if(var_1.size < 2) {
    return;
  }

  var_5 = fire_sfx_org(var_0);
  self startpathnodes(var_1, var_5, 1, 0.5, 0.5, 0, 1);
}

function ref_145ad(var_0) {
  self endon("death");
  var_1 = [];
  var_2 = var_0;

  for(var_1 = var_2.origin; isDefined(var_2) && isDefined(var_2.target); var_1 = var_2.origin) {
    var_2 = scripts\engine\utility::getStruct(var_2.target, "targetname");
  }

  return var_1;
}

function fire_sfx_org(var_0) {
  self endon("death");
  var_1 = [];
  var_2 = var_0;

  for(var_1 = 4; isDefined(var_2) && isDefined(var_2.target); var_1 = 8) {
    var_2 = scripts\engine\utility::getStruct(var_2.target, "targetname");
  }

  return var_1;
}

function damage_monitor() {
  self endon("stop_damage_monitor");
  self endon("death");
  thread ref_13a41();
  self setCanDamage(1);
  self.health = 100000;
  self.currenthealth = 900;
  self.ref_13c4f = 900;
  self.currentdamagestate = 0;
  var_0 = 0.25;

  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(!isDefined(var_2)) {
      continue;
    } else if(isvector(var_2)) {
      continue;
    }

    if(isDefined(var_2.owner) && !isPlayer(var_2.owner)) {
      continue;
    } else if(!isPlayer(var_2)) {
      continue;
    }

    var_11 = undefined;
    var_12 = "standard";

    if(isDefined(var_10)) {
      if(var_10.basename == "cruise_proj_mp") {
        var_1 = 1000;
      }

      if(var_10.classname == "rocketlauncher") {
        var_1 = max(var_1, self.ref_13c4f / 2 + 10);
      }
    }

    if(self.currenthealth - var_1 < 0) {
      var_11 = 1;
    }

    if(isDefined(var_2)) {
      if(isDefined(var_10)) {
        switch (var_10.basename) {
          case "molotov_mp":
            thread ref_11cbb(6, var_2, var_4);
            break;
          case "thermite_mp":
            thread ref_13b1b(7, var_2, var_4);
            break;
          default:
            break;
        }

        var_1 = scripts\cp\cp_damage::handleapdamage(var_10, var_5, var_1, var_2);
      }

      if(isDefined(var_2.owner)) {
        var_2.owner thread scripts\cp\cp_damagefeedback::updatedamagefeedback(var_12, var_11, var_1, 0);
      } else {
        var_2 thread scripts\cp\cp_damagefeedback::updatedamagefeedback(var_12, var_11, var_1, 0);
      }
    }

    var_13 = isDefined(var_2) && isPlayer(var_2);
    var_14 = isDefined(var_2.owner) && isPlayer(var_2.owner);
    var_15 = isDefined(var_2.classname) && var_2.classname == "script_vehicle" && isDefined(var_2.owner) && isPlayer(var_2.owner);
    var_16 = var_15 && var_5 == "MOD_CRUSH";

    if(var_13 || var_14 || var_16) {
      if(!scripts\cp\utility::tryingtoleave() && isDefined(var_10)) {
        if(var_14) {
          var_2 = var_2.owner;
        }

        scripts\cp\cp_agent_damage::addattacker(self, var_2, var_2, var_10, var_1, var_4, var_3, undefined, undefined, var_5);
      }
    }

    if(scripts\engine\utility::isbulletdamage(var_5)) {
      level notify("enemy_spotted", self);
      var_1 *= var_0;
    }

    if(istrue(var_11)) {
      self notify("death");
      return;
    }

    self.currenthealth -= var_1;

    if(self.currenthealth <= int(self.ref_13c4f / 1.2) && self.currentdamagestate == 0) {
      self.currentdamagestate = 1;
      self setscriptablepartstate("body_damage_light", "on");
      continue;
    }

    if(self.currenthealth <= int(self.ref_13c4f / 2) && self.currentdamagestate == 1) {
      self.currentdamagestate = 2;
      self setscriptablepartstate("body_damage_medium", "on");
    }
  }
}

function ref_11cbb(var_0, var_1, var_2) {
  self endon("death");
  var_3 = 2025;

  if(isDefined(var_2)) {
    if(distancesquared(var_2, self.origin) > var_3) {
      return;
    }
  }

  var_4 = gettime() + var_0 * 1000;

  while(var_4 > gettime()) {
    self dodamage(15, self.origin, var_1);
    wait 1;
  }
}

function ref_13b1b(var_0, var_1, var_2) {
  self endon("death");
  var_3 = 2025;

  if(isDefined(var_2)) {
    if(distancesquared(var_2, self.origin) > var_3) {
      return;
    }
  }

  var_4 = gettime() + var_0 * 1000;

  while(var_4 > gettime()) {
    self dodamage(125, self.origin, var_1);
    wait 1;
  }
}

function ref_13a41() {
  level endon("game_ended");
  self waittill("death");

  if(isDefined(self.attackerdata)) {
    foreach(var_1 in level.players) {
      if(!isDefined(var_1)) {
        continue;
      }

      if(!isDefined(var_1.guid)) {
        continue;
      }

      if(!isDefined(self.attackerdata[var_1.guid])) {
        continue;
      }

      if(!isDefined(self.attackerdata[var_1.guid].damage)) {
        continue;
      }

      var_2 = 0;

      if(self.attackerdata[var_1.guid].damage >= self.maxhealth * 0.1) {
        var_2 = 1;
      }

      if(self.attackerdata[var_1.guid].damage >= self.maxhealth * 0.2) {
        var_2 = 2;
      }

      if(var_2 >= 1) {
        var_1 thread scripts\cp\drone\emp_drone::giverankxp("destroyed_pac_sentry", scripts\cp\drone\emp_drone::getscoreinfovalue("destroyed_pac_sentry"));
      }
    }
  }

  playFX(level._effect["remote_tank_explode"], self.origin);
  self.mgturret delete();
  self delete();
}

function listen_for_enemy_alert() {
  level endon("enemy_alert");
  level waittill("enemy_spotted", var_0);
  thread alert_enemy_soldiers();
  scripts\engine\utility::flag_set("enemy_alert");
}

function proximity_alert() {
  level endon("game_ended");
  level endon("enemy_alert");
  var_0 = scripts\engine\utility::getStructArray("prox_alert", "targetname");
  var_1 = 0;

  while(!var_1) {
    foreach(var_3 in level.players) {
      foreach(var_5 in var_0) {
        var_6 = var_5.script_radius * var_5.script_radius;

        if(distance2dsquared(var_3.origin, var_5.origin) < var_6) {
          var_1 = 1;
          break;
        }
      }

      if(var_1) {
        break;
      }

      wait 0.1;
    }

    wait 0.1;
  }

  thread alert_enemy_soldiers();
  scripts\engine\utility::flag_set("enemy_alert");
}

function alert_enemy_soldiers() {
  var_0 = spawnStruct();
  var_0.type = "bulletwhizby";

  foreach(var_2 in level.spawned_enemies) {
    var_2 notify("ai_events", [var_0]);
  }
}

function elevator_button_hint(var_0, var_1) {
  if(var_0.floor_num == "third") {
    return &"CP_DWN_TWN_OBJECTIVES/ELEVATOR_BASEMENT";
  }

  if(var_0.floor_num == "basement") {
    return &"CP_DWN_TWN_OBJECTIVES/ELEVATOR_ROOF";
  }

  return "";
}

function elevator_button_activate(var_0, var_1) {
  if(istrue(var_0.elevator_moving)) {
    return;
  }

  var_2 = 1;
  var_3 = 3600;
  var_4 = scripts\engine\utility::getStruct("vault_assault_elevator_trigger", "targetname");
  var_5 = var_4.origin;

  foreach(var_1 in level.players) {
    if(distance2dsquared(var_1.origin, var_5) > var_3) {
      var_2 = 0;
      break;
    }
  }

  if(!var_2) {
    iprintlnbold("all players needed in elevator");
    return;
  }

  var_0.elevator_moving = 1;
  send_players_to_floor(var_0);
}

function send_players_to_floor(var_0) {
  if(var_0.floor_num == "third") {
    close_elevator_doors("_" + var_0.floor_num);
    level.bank_elevator = "basement";
    wait 1;
    scripts\cp\utility::teleportallplayersinteamtostructs("allies", "vault_assault_elevator_pos_crypto");
    wait 3;
    var_0.floor_num = "basement";
    var_0.elevator_moving = 0;
    open_elevator_doors("_" + var_0.floor_num);
    return;
  }

  if(var_0.floor_num == "basement") {
    close_elevator_doors("_" + var_0.floor_num);
    level.bank_elevator = "roof";
    wait 1;
    scripts\cp\utility::teleportallplayersinteamtostructs("allies", "vault_assault_elevator_pos_roof");
    wait 3;
    var_0.floor_num = "";
    open_elevator_doors(var_0.floor_num);
    return;
  }
}

function deposit_box_hint(var_0, var_1) {
  return &"CP_DWN_TWN_OBJECTIVES/DEPOSIT_BOX";
}

function deposit_box_activate(var_0) {
  self endon("death");
  self endon("game_ended");

  for(;;) {
    self waittill("trigger", var_1);
    self playSound("cp_bank_deposit_open");

    if(isDefined(var_1)) {
      if(!var_1 scripts\cp\utility::is_valid_player()) {
        continue;
      }
    }

    level.deposit_box_search = 1;

    if(istrue(var_0.key_card)) {
      thread create_key_card(var_0, 1);
    }

    var_0 rotateTo(var_0.angles + (0, 60, 0), 0.25);
    var_0 makeunusable();
  }
}

function key_card_hint(var_0, var_1) {
  if(!istrue(var_0.started_hack)) {
    return &"CP_DWN_TWN_OBJECTIVES/KEY_CARD";
  }

  return "";
}

function key_card_activate(var_0, var_1) {
  if(istrue(var_0.started_hack)) {
    return;
  }

  var_0.started_hack = 1;
  level.key_card_acquired = 1;
  var_0.model hide();
  remove_key_card_head_icon();
}

function hvt_skit_notetrack_handler() {
  self endon("death");

  for(;;) {
    self waittill("animscripted", var_0);

    if(!isDefined(var_0)) {
      var_0 = ["undefined"];
    }

    if(!isarray(var_0)) {
      var_0 = [var_0];
    }

    var_1 = undefined;

    foreach(var_3 in var_0) {
      switch (var_3) {
        case "start_firing":
          thread start_firing();
          var_4 = getEnt("hvt_door", "targetname");
          var_4 playSound("scn_cp_bank_heist_jugg_door_bullet_imps");
          break;
        case "fire_weapon":
          self shoot();
          break;
        case "stop_firing":
          self notify("stop_firing");
          break;
        case "door_kick":
          var_5 = getEnt("hvt_door_clip", "targetname");
          var_4 = getEnt("hvt_door", "targetname");
          var_4 rotateby((0, 0, 90), 0.35);
          var_5 connectpaths();
          var_5 notsolid();
          var_4 playSound("scn_cp_bank_heist_jugg_door_kick_settle");
          break;
        case "hide_usb":
          level.bank_hvt_usb hide();
          break;
        case "show_usb":
          level.bank_hvt_usb show();
          break;
        case "hvt_roof":
          break;
        case "link_cig":
          level.bank_hvt_cig linkTo(level.bank_hvt, "j_wrist_le", (2, 1, 0), (0, 0, 0));
          break;
        case "flick_cig":
          level.bank_hvt_cig unlink();
          level.bank_hvt_cig moveTo(level.bank_hvt_cig.origin + anglesToForward(level.bank_hvt.angles) * 125, 0.35);
          wait 0.35;
          playFX(level._effect["cig_hit"], level.bank_hvt_cig.origin);
          level.bank_hvt_cig delete();
          break;
        case "start_lookat":
          self notify("stop_lookat");
          thread lookat_players();
          break;
        case "stop_lookat":
          self notify("stop_lookat");
          self setlookatentity();
          break;
        case "lookat_monitor":
          self notify("stop_lookat");
          self setlookatentity(level.monitor_lookat_ent);
          break;
        case "hvt_exit":
          self notify("stop_lookat");
          self setlookatentity();
          break;
      }
    }
  }
}

function start_firing() {
  self endon("stop_firing");

  for(;;) {
    self shoot();
    wait weaponfiretime(self.primaryweapon);
  }
}

function delay_and_play_vo_to_team(var_0, var_1) {
  level endon("game_ended");
  wait var_0;
  level thread scripts\cp\cp_dialogue::play_vo_to_all(var_1);
}

function mark_never_remove(var_0) {
  self.never_kill_off = 1;
}

function mark_group_as_killable(var_0) {
  var_1 = scripts\cp\cp_modular_spawning::get_module_structs_by_groupname(var_0);
  var_1 = level.spawn_module_structs_memory[var_0];

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      foreach(var_5 in var_3.ai_spawned) {
        var_5.never_kill_off = undefined;
      }
    }

    return;
  }
}

function start_mortars() {
  level.get_mortar_impact_pos = &get_mortar_impact_spot;
  mortar_launch_think();
}

function get_mortar_impact_spot(var_0) {
  if(!isDefined(var_0.targets)) {
    return undefined;
  }

  var_1 = scripts\engine\utility::random(var_0.targets);
  var_2 = var_1.origin + (randomintrange(-50, 50), randomintrange(-50, 50), 0);
  var_3 = scripts\engine\trace::ray_trace(var_2 + (0, 0, 500), var_2);
  return var_3["position"];
}

function mortar_launch_think() {
  scripts\cp\cp_modular_spawning::increase_reserved_spawn_slots(3, "bank_roof_mortar");
  var_0 = scripts\cp\cp_modular_spawning::run_spawn_module("bank_roof_mortar");
  thread mortar_think(level.rooftop_1_mortar);
  thread mortar_think(level.rooftop_2_mortar);
  thread mortar_think(level.rooftop_3_mortar);
}

function mortar_think(var_0) {
  self.targets = undefined;

  for(;;) {
    var_1 = get_players_on_rooftop(var_0);

    if(var_1.size) {
      self.targets = var_1;
      scripts\cp\maps\cp_donetsk\milbase\ai_flare::attract_agent_to_mortar(self, 1, 500);
      self.targets = undefined;
      wait randomintrange(10, 20);
      continue;
    }

    wait 1;
  }
}

function ref_142ec() {
  if(!isDefined(level.ref_121d5)) {
    level.ref_121d5 = gettime() - 1000;
  }

  if(level.ref_121d5 > gettime()) {
    return;
  }

  var_0 = ["dx_cps_kama_callout_paratrooper_spawning_10", "dx_cps_kama_callout_paratrooper_spawning_20", "dx_cps_lass_callout_paratrooper_spawning_10", "dx_cps_lass_callout_paratrooper_spawning_20"];
  level scripts\cp\cp_vo::try_to_play_vo_on_team(scripts\engine\utility::random(var_0), "allies");
  level.ref_121d5 = gettime() + 30000;
}

function get_players_on_rooftop(var_0) {
  var_1 = scripts\engine\utility::getStructArray("hvt_roof_spawn", "targetname");
  var_2 = var_1[0];
  var_3 = var_2.origin + (0, 0, -25);
  var_4 = [];

  foreach(var_6 in level.players) {
    if(!var_6 scripts\cp\utility::is_valid_player() || !var_6 isonground() || var_6 isonladder()) {
      continue;
    }

    if(var_6.origin[2] > var_3[2]) {
      var_4 = var_6;
    }
  }

  return var_4;
}

function ref_13f05() {
  self endon("disconnect");
  self waittill("loadout_given");
  wait 3;

  while(istrue(self.hostmigrationcontrolsfrozen)) {
    waitframe();
  }

  if(istrue(self.controlsfrozen)) {
    scripts\cp\utility::freezecontrolswrapper(0);
    return;
  }
}