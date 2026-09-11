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
  var0 = getEnt("hvt_door_clip", "targetname");
  var0 disconnectPaths();
  thread remove_extra_structs();
  var1 = scripts\engine\utility::getStructArray("bank_roof_munition_remove", "targetname");

  foreach(var3 in var1) {
    level thread scripts\cp\cp_munitions::ref_12be1(var3.origin, 200);
  }

  level.rooftop_1_mortar = getEnt("bank_rooftop_1_mortar", "targetname");
  level.rooftop_2_mortar = getEnt("bank_rooftop_2_mortar", "targetname");
  level.rooftop_3_mortar = getEnt("bank_rooftop_3_mortar", "targetname");
  level.rooftop_1_mortar hidepart("j_mortar_shell", "misc_wm_mortar");
  level.rooftop_2_mortar hidepart("j_mortar_shell", "misc_wm_mortar");
  level.rooftop_3_mortar hidepart("j_mortar_shell", "misc_wm_mortar");
}

function lbravo_spawner_jammer2(var0) {
  var1 = var0.player;
  var2 = 0;
  var3 = var0.stepstructs.size;
  var4 = 90000;
  objective_setplayintro(var0.id, 0);

  for(var5 = var3 - 1; var5 >= var2; var5--) {
    if(var5 > 0) {
      var6 = distancesquared(var1.origin, var0.stepstructs[var5]);
      var7 = distancesquared(var0.stepstructs[var5], var0.stepstructs[var5 - 1]);

      if(var6 < var7) {
        var8 = var0.stepstructs[var5][2] + 50;
        var9 = var0.stepstructs[var5 - 1][2] - 50;

        if(var1.origin[2] <= var8 && var1.origin[2] >= var9) {
          return var5;
        }

        var8 = var0.stepstructs[var5 - 1][2] + 50;
        var9 = var0.stepstructs[var5][2] - 50;

        if(var1.origin[2] <= var8 && var1.origin[2] >= var9) {
          return var5;
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
  var0 = ["stair_door_2", "stair_door_3", "stair_door_roof", "stair_door_2_2", "stair_door_3_2", "stair_door_1_2", "stair_door_5_2", "stair_door_roof_2"];

  foreach(var2 in var0) {
    create_door(var2);
    wait 0.1;
  }

  scripts\engine\utility::flag_set("stair_doors_init");
}

function create_door(var0) {
  var1 = getEntArray("clip64x64x8", "targetname");
  var2 = var1[0];
  var3 = scripts\engine\utility::getStructArray(var0, "targetname");
  var4 = var3[0];

  if(isDefined(var4)) {
    var5 = spawn("script_model", var4.origin);
    var5.angles = var4.angles;
    wait 0.1;
    var5 setModel("door_metal_double_b_l_02_grey");
    var5.open_ang = (0, 105, 0);
    level.bank_stair_doors[var0] = var5;

    if(isDefined(var2)) {
      var6 = scripts\engine\utility::getStructArray(var0 + "_clip", "targetname");
      var7 = var6[0];
      var8 = spawn("script_model", var7.origin);
      var8.angles = var7.angles;
      var8 clonebrushmodeltoscriptmodel(var2);
      var8 disconnectPaths();
      level.bank_stair_doors_clip[var0] = var8;
      return;
    }

    return;
  }
}

function create_door_clip() {
  wait 5;
  level.bank_roof_doors_clip = [];
  var0 = scripts\engine\utility::getStructArray("bank_door_roof_clip", "targetname");
  var1 = getEntArray("clip128x128x128", "targetname");
  var2 = var1[0];
  var3 = "scriptable_scriptable_door_metal_single_b_02_grey";
  var4 = getentitylessscriptablearrayinradius(var3, "classname");

  foreach(var6 in var4) {
    var6 setscriptablepartstate("door", "unusable");
  }

  foreach(var9 in var0) {
    var10 = spawn("script_model", var9.origin);
    var10.angles = var9.angles;
    var10 clonebrushmodeltoscriptmodel(var2);
    var10 disconnectPaths();
    level.bank_roof_doors_clip[level.bank_roof_doors_clip.size] = var10;
  }
}

function connect_doorway_paths() {
  if(scripts\engine\utility::flag_exist("create_script_initialized")) {
    scripts\engine\utility::flag_wait("create_script_initialized");
  }

  var0 = ["top_floor_stair_door_clip_2", "second_floor_stair_door_clip_2", "top_floor_stair_door_clip_1", "second_floor_stair_door_clip_1"];

  foreach(var2 in var0) {
    var3 = getEnt(var2, "targetname");

    if(isDefined(var3)) {
      var3 connectpaths();
      var3 notsolid();
    }

    wait 0.1;
  }
}

function prox_open_door(var0) {
  var1 = level.bank_stair_doors[var0];

  for(;;) {
    if(distance(level.players[0].origin, var1.origin) < 100) {
      open_door(var0);
      return;
    }

    wait 0.1;
  }
}

function open_door(var0) {
  var1 = level.bank_stair_doors[var0];
  var2 = level.bank_stair_doors_clip[var0];
  var1 rotateTo(var1.angles + var1.open_ang, 0.25);

  if(isDefined(var2)) {
    var2 connectpaths();
    var2 notsolid();
    return;
  }
}

function remove_extra_structs() {
  if(level.struct_class_names["targetname"]["player_exfil"].size > 1) {
    var0 = level.struct_class_names["targetname"]["player_exfil"][0];

    for(var1 = 0; var1 < level.struct_class_names["targetname"]["player_exfil"].size; var1++) {
      if(isDefined(level.struct_class_names["targetname"]["player_exfil"][var1].classname_mp)) {
        var0 = level.struct_class_names["targetname"]["player_exfil"][var1];
      }
    }

    level.struct_class_names["targetname"]["player_exfil"] = [];
    level.struct_class_names["targetname"]["player_exfil"][0] = var0;
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
  var0 = ["frag_grenade_mp", "molotov_mp", "semtex_mp", "flash_grenade_mp"];
  var1 = [0.5, 0.1, 0.1, 0.1];
  scripts\cp\cp_spawning_util::ref_12ae3("bank_combat_cut", var0, var1);
  scripts\cp\cp_spawning_util::ref_12ae3("bank_combat_cut_2", var0, var1);
  scripts\cp\cp_spawning_util::ref_12ae3("bank_combat_cut_3", var0, var1);
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
  var0 = [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 15, 5, 0.1, 8, 16];
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat", 0, 12, undefined, var0, undefined, "bank_combat_2", [ &show_players_breadcrumbs_to_safe_house, (23893, -18455, -22), (0, 220, 0)]);
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat_bombers", 0, 8, 16, var0, undefined, "bank_combat_bombers", [ &show_players_breadcrumbs_to_safe_house, (23893, -18455, -22), (0, 220, 0)]);
  var0 = [ &scripts\cp\cp_modular_spawning::module_wave_spawn, 10, 5, 0.1, 8, 16];
  scripts\cp\cp_modular_spawning::registerambientgroup("bank_combat_post_vault", 0, 16, undefined, var0, undefined, "bank_combat_2");
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("bank_combat_post_vault", [ &scripts\cp\cp_modular_spawning::ref_11cad, (22743, -20318, 187)]);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("bank_combat_post_vault", [ &scripts\cp\cp_modular_spawning::ref_11cac, 512]);
  var1 = scripts\engine\utility::getStruct("bank_obj_pos", "targetname");
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
  scripts\cp\cp_modular_spawning::register_module_weapons_free_func("bank_combat_init", [ &scripts\cp\cp_modular_spawning::group_fallback_to_pos, var1.origin]);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("bank_combat_init_cover", &spawn_in_cover);
  scripts\cp\cp_modular_spawning::register_module_weapons_free_func("bank_combat_init_sniper", [ &scripts\cp\cp_modular_spawning::set_heavy_hitter, 128]);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("bank_combat_init_sniper", &mark_never_remove);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("bank_combat_init_rpg", &mark_never_remove);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("bank_combat_init", &mark_never_remove);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("bank_combat_init_cover", &mark_never_remove);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func("bank_combat_init_lmg", &mark_never_remove);
}

function ref_13f15(var0) {
  thread ref_13f16(var0);
}

function ref_13f16(var0) {
  level endon("game_ended");
  var0 scripts\engine\utility::ent_flag_wait("weapons_free");

  for(var1 = 0; var1 < var0.module_vehicles.size; var1++) {
    ref_13f13(var0.module_vehicles[var1]);
  }
}

function ref_13f13() {
  self vehicle_setspeedimmediate(0, 30, 30);
  scripts\common\vehicle::vehicle_unload();
}

function show_players_breadcrumbs_to_safe_house(var0, var1, var2, var3) {
  var0 endon("death");
  var0 endon("weapons_free");
  level endon("weapons_free");
  var0 scripts\cp\cp_modular_spawning::watch_for_players_beyond_point_internal(var0, var1, var2, &scripts\cp\cp_modular_spawning::mp_hideout_patch);
}

function show_player_clip(var0, var1, var2, var3) {
  var0 endon("death");
  var0 endon("weapons_free");
  var0 scripts\cp\cp_modular_spawning::watch_for_players_beyond_point_internal(var0, var1, var2, var3, "end_module_if_weapons_free");
}

function mp_aniyah_patch() {
  self endon("end_module_if_weapons_free");
  level waittill("weapons_free");
  scripts\cp\cp_modular_spawning::mp_hideout_patch();
}

function balloon_deposit_cash_nags(var0) {
  scripts\cp\cp_modular_spawning::register_module_weapons_free_func(var0, &scripts\cp\cp_modular_spawning::ref_1309b);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func(var0, &scripts\cp\cp_modular_spawning::watch_for_players);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func(var0, &give_guy_pacifist_override);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func(var0, &scripts\cp\cp_modular_spawning::enter_combat_after_stealth);
  scripts\cp\cp_modular_spawning::register_module_ai_spawn_func(var0, &alert_when_see_player);
}

function give_guy_pacifist_override(var0) {
  self.pacifist_override = 1;
  self.sightmaxdistance = 2200;
  thread scripts\cp\coop_stealth::run_common_functions(self, 1, 1, 60, 250000);
}

function alert_when_see_player(var0) {
  if(scripts\cp\coop_stealth::ref_132d7()) {
    return;
  }

  level endon("game_ended");
  self endon("death");
  return_when_cansee_player();

  foreach(var2 in var0.ai_spawned) {
    var2 notify("bulletwhizby");
  }
}

function return_when_cansee_player() {
  self endon("mission_compromised");
  self endon("enter_combat");

  for(;;) {
    var0 = scripts\engine\utility::get_array_of_closest(self.origin, level.players, undefined, undefined, 1024);

    for(var1 = 0; var1 < var0.size; var1++) {
      if(self cansee(level.players[var1])) {
        return;
      }
    }

    wait 0.25;
  }
}

function players_entered_bank(var0) {}

function spawn_per_player(var0, var1, var2, var3) {
  var4 = max(var1, var2 * level.players.size);
  var4 = min(var4, 24);
  return var4;
}

function spawn_in_cover(var0) {
  var1 = self getnearestnode();

  if(isDefined(var1)) {
    var2 = var1.angles;
    var3 = var1.origin;

    if(!issubstr(var1.type, "Prone")) {
      if(issubstr(var1.type, "Left")) {
        var2 += (0, 90, 0);
      } else if(issubstr(var1.type, "Right") || issubstr(var1.type, "Cover Crouch") || issubstr(var1.type, "Conceal") || issubstr(var1.type, "Cover Stand")) {
        var2 -= (0, 90, 0);
      }
    }

    self forceteleport(var3, var2);
    self usecovernode(var1, 1);
    self setgoalnode(var1);
    self.goalradius = 8;
    return;
  }
}

function spawn_wave(var0, var1, var2, var3) {
  return scripts\cp\cp_modular_spawning::wave_reinforce(var0, var1, var2, var3);
}

function end_p1_spawn_loop(var0) {
  level waittill("end_p1_spawn_loops");
  level notify("stop_" + var0 + "_loop");
  wait 0.1;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname(var0);
}

function p1_intel_death_func() {
  self.spawner scripts\cp\cp_modular_spawning::little_bird_mg_givetakegunnerturrettimeout();
  scripts\cp\cp_escalation::increase_escalation_counter();
}

function watch_for_spawn_min_required(var0, var1, var2, var3) {
  if(isDefined(level.active_spawn_module_structs) && level.active_spawn_module_structs.size > 1) {
    return 0;
  }

  var4 = var2 - scripts\cp\cp_modular_spawning::get_requested_spawn_count(var0.moduleid);
  var4 = clamp(var4, 0, var2);

  if(var4 <= 0) {
    return 0;
  }

  var5 = int(min(clamp(var1, 0, var4), var1));
  return var5;
}

function wait_after_max_spawn(var0, var1, var2, var3) {}

function reset_active_count(var0) {
  var0.activecount = 0;
  var0.currentmodulekills = 0;
}

function isshuttingdown(var0) {
  debug_trigger_objective_events(var0);
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "vault_assault_debug_start");
}

function debug_vault_assault_obj_start(var0) {
  debug_trigger_objective_events(var0);
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "vault_assault_debug_start");
}

function debug_vault_assault_cut(var0) {
  debug_trigger_objective_events(var0);
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "vault_assault_cut_debug_start");
}

function debug_vault_assault_vault(var0) {
  debug_trigger_objective_events(var0);
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "vault_assault_cut_debug_start");
}

function debug_vault_assault_crypto(var0) {
  scripts\cp\cp_spawning_util::ref_13bbd(0);
  debug_trigger_objective_events(var0);
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "vault_assault_crypto_debug_start");
}

function debug_vault_assault_roof_obj_start(var0) {
  debug_trigger_objective_events(var0);

  while(!isDefined(level.heli)) {
    wait 0.1;
  }

  level.heli waittill("heli_landed");
  thread heli_force_search();
  scripts\engine\utility::flag_set("hvt_gone");
  scripts\engine\utility::flag_set("init_roof_combat");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "vault_assault_elevator_pos_roof_debug");
}

function debug_vault_assault_roof_defend_start(var0) {
  wait 5;
  debug_trigger_objective_events(var0);
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "vault_assault_elevator_pos_roof_debug");
}

function debug_vault_assault_roof_exfil_start(var0) {
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "vault_assault_elevator_pos_roof_debug");
}

function delay_debug_roof_start() {
  if(isDefined(level.spawned_enemies)) {
    foreach(var1 in level.spawned_enemies) {
      var1 dodamage(var1.health + 1000, var1.origin);
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

function debug_trigger_objective_events(var0) {
  scripts\engine\utility::flag_set("cp_dwn_twn_create_script");
  scripts\engine\utility::flag_wait("cp_dwn_twn_create_script_completed");
  scripts\engine\utility::flag_set("cp_dwn_twn_bank_vehicle_create_script");
  scripts\engine\utility::flag_wait("cp_dwn_twn_bank_vehicle_create_script_completed");
  scripts\engine\utility::flag_wait("objectives_registered");
  scripts\engine\utility::flag_wait("va_spawn_modules_registered");

  switch (var0.ref) {
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
  var0 = 0;

  while(!var0) {
    foreach(var2 in level.players) {
      if(var2.model != "") {
        scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_safehouse::script_struct_add(var2);
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

  var0 = scripts\engine\utility::getStruct("rooftop_org", "targetname");
  var1 = var0.radius;
  var2 = var1 * var1;

  foreach(var4 in level.littlebirds) {
    if(distance2dsquared(var4.origin, var0.origin) < var2) {
      var4 delete();
    }
  }
}

function debugbeatobjective(var0) {}

function init_pre_vault_assault(var0, var1) {
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\engine\utility::flag_wait("cp_donetsk_safehouse_downtown_cs_completed");
}

function start_pre_vault_assault(var0, var1) {
  scripts\engine\utility::flag_set("cp_dwn_twn_create_script");
  scripts\engine\utility::flag_wait("cp_dwn_twn_create_script_completed");
  scripts\engine\utility::flag_set("cp_dwn_twn_bank_vehicle_create_script");
  scripts\engine\utility::flag_wait("cp_dwn_twn_bank_vehicle_create_script_completed");
  scripts\engine\utility::flag_set("ml_p3_done");
  scripts\engine\utility::flag_set("return_to_safehouse");
  scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_safehouse::ref_1234e(var0);
  level waittill("mission_selected", var2);
}

function team_planted_bomb(var0, var1) {
  level endon("game_ended");
  scripts\engine\utility::flag_set("cp_dwn_twn_create_script");
  scripts\engine\utility::flag_wait("cp_dwn_twn_create_script_completed");
  thread scripts\mp\vehicles\vehicle_damage_mp::ref_12e56(getEntArray("gunshop_safehouse_loot", "targetname"));
  init_out_of_bounds_triggers();
  level.default_player_spawns = "vault_assault_infil_start";
  level.initlocs_bunkertest = scripts\engine\utility::getStructArray("vault_assault_infil_start", "targetname");
  scripts\cp\utility::teleportallplayersinteamtostructs("allies", "vault_assault_infil_start");
  ref_140f4();
  level thread scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_safehouse::ref_1234e(var0);
  level.initlethalmaxoffsetmap = "vault_assault";
  scripts\engine\utility::flag_init("enemy_alert");
  scripts\cp\utility::skydivestreamhintdvars("ml_p1");
  spawn_static_trucks();
}

function init_out_of_bounds_triggers() {
  var0 = scripts\engine\utility::getStruct("vault_assault_loadout_select", "targetname");
  var1 = spawn("script_model", var0.origin);
  var1.angles = var0.angles;
  var1 setModel("military_carepackage_01_friendly");
  var2 = getEnt("care_package_col", "targetname");
  var3 = spawn("script_model", var0.origin);
  var3.angles = var0.angles;
  var3 clonebrushmodeltoscriptmodel(var2);
  var3 linkTo(var1);
  var4 = spawn("script_model", var0.origin + (0, 0, 35));
  var4 setModel("tag_origin");
  var4 scripts\cp\utility::sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_STRIKE/EDIT_LOADOUT", 25, "duration_short", "hide", 256, 75, 128, 75);
  var4.headicon = deleteheadicon(var1);
  setheadiconfriendlyimage(var4.headicon, "hud_icon_survival_weapon");
  setheadicondrawthroughgeo(var4.headicon, 0);
  setheadiconsnaptoedges(var4.headicon, 1024);
  setheadiconmaxdistance(var4.headicon, 256);
  addclienttoheadiconmask(var4.headicon, -5);
  var1.collision = var3;
  var1.interaction = var4;
  var4 thread scripts\mp\brclientmatchdata::getnextcombatareaid(var1);
}

function tarmac_techo_start_first(var0) {
  scripts\engine\utility::flag_init("infil_driver_spawned");
}

function keypad_activate_func(var0) {
  level.stepstructsproximity = self;
  self.nocorpse = 1;
  scripts\engine\utility::flag_set("infil_driver_spawned");
}

function ref_140f4() {
  scripts\cp\cp_modular_spawning::run_spawn_module("vault_assault_driver");
}

function ref_13829(var0, var1) {
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

function hiding_munitions_purchase(var0, var1) {
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("vault_assault_saw_patrollers");
  thread scripts\cp\cp_objectives::run_objective("vault_assault");
}

function end_pre_vault_assault(var0, var1) {}

function init_vault_assault(var0, var1) {
  level endon("game_ended");
  scripts\engine\utility::flag_set("cp_dwn_twn_create_script");
  scripts\engine\utility::flag_wait("cp_dwn_twn_create_script_completed");
  scripts\engine\utility::flag_set("cp_dwn_twn_bank_vehicle_create_script");
  scripts\engine\utility::flag_wait("cp_dwn_twn_bank_vehicle_create_script_completed");
  level.initlethalmaxoffsetmap = "vault_assault";
  level.initlocationcircle = "vault_assault";
  ref_12bc4();
  level.max_agents_override = 24;

  if(isDefined(var0)) {
    var2 = scripts\engine\utility::getStructArray("bank_obj_pos", "targetname");
    var3 = var2[0];
    objective_icon(var0.objectiveindex, "icon_waypoint_objective_general");
    objective_position(var0.objectiveindex, var3.origin);
    objective_state(var0.objectiveindex, "current");

    if(var0.ref == "pre_vault_assault") {
      var4 = scripts\engine\utility::getStructArray("vault_assault_start", "targetname");
      var5 = var4[0];
      var6 = 0;
      var7 = 49000000;

      while(!var6) {
        foreach(var9 in level.players) {
          if(distance2dsquared(var9.origin, var5.origin) < var7) {
            var6 = 1;
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

function start_vault_assault(var0, var1) {
  level endon("game_ended");
  level endon("end_vault_assault");
  wait 5;
  thread nag_get_in_bank();
  var2 = scripts\engine\utility::getStructArray("vault_assault_start", "targetname");
  var3 = var2[0];
  var4 = var3.origin;
  thread notify_when_player_nearby(level, "vault_assault_cut_start", var4);
  var5 = scripts\engine\utility::getStructArray("vault_door_cut_interaction", "targetname");
  var4 = var5[0].origin;
  thread notify_when_player_nearby(level, "vault_assault_cut_start", var4);
  level waittill("vault_assault_cut_start");
  scripts\cp\cp_objectives::overridenextstep(var0, "vault_assault_cut");
}

function end_vault_assault(var0, var1) {}

function ref_123ca() {
  scripts\mp\vehicles\vehicle_damage_mp::ref_12409("kama");
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_bank_intro_20");
  scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_ml_p1::ref_123cb("conv_generic_affirm");
}

function gettimetogulagclosed(var0) {
  var1 = scripts\engine\utility::random(var0);
  scripts\cp\cp_dialogue::play_vo_to_all(var1);
}

function cap_wave_spawning() {
  level endon("game_ended");

  for(;;) {
    var0 = 0;
    var0 = level.spawned_enemies.size;
    var1 = 24 - var0;
    var2 = max(var1, 0);

    if(isDefined(level.active_spawn_module_structs["wave_spawning"])) {
      var3 = level.active_spawn_module_structs["wave_spawning"];

      for(var4 = 0; var4 < var3.size; var4++) {
        var5 = var3[var4];
        var5 scripts\cp\cp_modular_spawning::set_ambient_max_count(var2);
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

function notify_when_player_nearby(var0, var1, var2) {
  level endon("game_ended");
  wait_for_player_nearby(var1, var2);
  level notify(var0);
}

function init_vault_assault_cut(var0, var1) {
  level thread scripts\cp\maps\cp_dwn_twn\cp_dwn_twn_door_cut::main(var0);
  scripts\cp\cp_spawning_util::ref_13bbd(0);
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_init_sniper");
}

function start_vault_assault_cut(var0, var1) {
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
  objective_position(var0.objectiveindex, getEnt("vault_gate_door", "targetname").origin + (0, 0, 50));
  objective_setplayintro(var0.objectiveindex, 1);
  objective_setshowprogress(var0.objectiveindex, 1);
  objective_setlabel(var0.objectiveindex, &"CP_BR_SYRK_OBJECTIVES/CUT_HINT");
  level.cut_progress_objective = var0.objectiveindex;
  scripts\engine\utility::flag_set("activate_door_cut");
  mark_group_as_killable("bank_combat_init_sniper");
  mark_group_as_killable("bank_combat_init_rpg");
  thread cycle_bank_combat_cut_spawn_modules();

  while(!istrue(level.vault_door_broken)) {
    wait 0.1;
  }

  scripts\cp\utility::ref_123fe("mus_cp_money_cut_vault");
  level notify("vault_door_broken");
  scripts\cp\cp_objectives::overridenextstep(var0, "vault_assault_vault");
}

function end_vault_assault_cut(var0, var1) {}

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
  var0 = ["bank_combat_init"];

  for(var1 = 0; var1 < var0.size; var1++) {
    var2 = scripts\cp\cp_modular_spawning::get_module_structs_by_groupname(var0[var1], 1);

    for(var3 = 0; var3 < var2.size; var3++) {
      var4 = var2[var3];
      scripts\cp\cp_modular_spawning::group_fallback_to_pos(var4, (22686, -19207, -22));
    }
  }

  scripts\cp\cp_modular_spawning::stop_module_by_groupname("vault_assault_saw_patrollers");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_bombers");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_vehicle_reinforcement");

  while(!istrue(level.vault_door_broken)) {
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_cut");
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_cut_3");
    var4 = scripts\cp\cp_modular_spawning::run_spawn_module("bank_combat_cut_2");
    wait 15;
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_cut");
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_cut_2");
    var4 = scripts\cp\cp_modular_spawning::run_spawn_module("bank_combat_cut_3");
    wait 15;
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_cut_2");
    scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_cut_3");
    var4 = scripts\cp\cp_modular_spawning::run_spawn_module("bank_combat_cut");
    wait 15;
  }
}

function init_vault_assault_vault(var0, var1) {
  scripts\cp\cp_spawning_util::ref_13bbd(0);
  thread open_vault_gate();
  level.deposit_box_interactions = [];
  var2 = scripts\engine\utility::getStructArray("vault_deposit_box_interaction", "targetname");

  for(var3 = 0; var3 < var2.size; var3++) {
    var4 = 0;

    foreach(var6 in level.deposit_box_interactions) {
      if(var6.origin == var2[var3].origin) {
        var4 = 1;
      }
    }

    if(!var4) {
      var8 = create_deposit_box_interaction(var2[var3]);
      level.deposit_box_interactions[level.deposit_box_interactions.size] = var8;

      if(getdvarint("scr_va_force_key") != 0) {
        var8.key_card = 1;
      }
    }
  }

  var9 = randomint(level.deposit_box_interactions.size);
  level.deposit_box_interactions[var9].key_card = 1;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("vault_assault_saw_patrollers");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_init");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_vehicle_reinforcement");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_cut");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_cut_2");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_cut_3");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_bombers");
  var10 = ["bank_combat_cut", "bank_combat_cut_2", "bank_combat_cut_3"];

  for(var3 = 0; var3 < var10.size; var3++) {
    var11 = scripts\cp\cp_modular_spawning::get_module_structs_by_groupname(var10[var3], 1);

    for(var12 = 0; var12 < var11.size; var12++) {
      scripts\cp\cp_modular_spawning::group_fallback_to_pos(var11[var12], (22374, -19506, -197));
    }
  }

  open_vault_door();

  if(isDefined(var0) && isDefined(var0.objectiveindex)) {
    scripts\cp\cp_objectives::ref_11f80(var0.objectiveindex);
    return;
  }
}

function start_vault_assault_vault(var0, var1) {
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_bank_intel_search_10");
  var2 = scripts\engine\utility::getStructArray("vault_assault_vault", "targetname");
  var3 = var2[0];
  var4 = var3.origin;
  level.crypto_key_objective = var0;
  wait_for_player_nearby(var4, 500);
  level thread scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_bank_key_deposit_boxes_10");
  thread nag_vault_search();

  while(!level.key_card_acquired) {
    wait 0.1;
  }

  level notify("key_card_acquired");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_vault_wave");
}

function end_vault_assault_vault(var0, var1) {
  scripts\cp\cp_objectives::overridenextstep(var0, "vault_assault_vault_fake_end");
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
  var0 = scripts\engine\utility::getStructArray("bank_vault_door_closed", "targetname");
  var1 = var0[0];
  level.vault_door.origin = var1.origin;
  level.vault_door.angles = var1.angles;
}

function open_vault_door() {
  if(isDefined(level.vault_door)) {
    level.vault_door rotateTo(level.vault_door.open_ang, 5, 0.1, 0.5);
    level.vault_door playSound("cp_bank_vault_open");
    return;
  }
}

function create_key_card(var0, var1) {
  var2 = scripts\engine\utility::getStructArray("key_card_interaction", "targetname");
  var3 = var2[0];

  if(isDefined(var0)) {
    var4 = var0.origin + anglestoright(var0.angles) * 10 + anglesToForward(var0.angles) * -5;
    var3.origin = var4;
    var3.angles = var0.angles;
  }

  create_usb_pickup_interaction(var3, var1);
}

function open_vault_gate() {
  while(!istrue(level.waiting_for_door_cut)) {
    wait 0.1;
  }

  if(isDefined(level.door_cut_interactions)) {
    foreach(var1 in level.door_cut_interactions) {
      if(isDefined(var1)) {
        var1 delete();
      }
    }
  }

  wait 1;
  level.vault_door_broken = 1;
  level notify("end_door_cut_wait");
}

function init_vault_assault_vault_fake_end(var0, var1) {
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("vault_assault_saw_patrollers");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_cut");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_cut_2");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_cut_3");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_vault_wave");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_vault_bombers");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_vault_fill");
}

function start_vault_assault_vault_fake_end(var0, var1) {
  scripts\cp\cp_modular_spawning::run_spawn_module("bank_combat_atrium_init");
  wait 4;
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_bank_good_find_10");
  wait 1;
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_bank_hvt_update_10");
  wait 1;
  scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_bank_hvt_update_20");
}

function end_vault_assault_vault_fake_end(var0, var1) {
  scripts\cp\cp_objectives::overridenextstep(var0, "vault_assault_crypto");
}

function init_vault_assault_crypto(var0, var1) {
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
  scripts\cp\cp_objectives::ref_11f80(var0.objectiveindex);
}

function ref_135cc(var0) {
  var1 = scripts\engine\utility::getStructArray(var0, "targetname");

  if(!isDefined(var1)) {
    return;
  }

  for(var2 = 0; var2 < var1.size; var2++) {
    thread ref_1353b(var1[var2]);
  }
}

function ref_1353b(var0) {
  var1 = scripts\mp\carriable::ref_131ea(var0);
  var1.matchdata_logaward = 1;
}

function start_vault_assault_crypto(var0, var1) {
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

function end_vault_assault_crypto(var0, var1) {
  scripts\cp\cp_objectives::overridenextstep(var0, "vault_assault_rooftop_heli");
}

function open_stairwell_doors() {
  scripts\engine\utility::flag_wait("stair_doors_init");
  var0 = ["stair_door_2", "stair_door_3", "stair_door_2_2", "stair_door_3_2", "stair_door_1_2"];

  foreach(var2 in var0) {
    open_door(var2);
    wait 0.1;
  }
}

function open_roof_doors() {
  scripts\engine\utility::flag_wait("stair_doors_init");
  var0 = ["stair_door_roof", "stair_door_5_2", "stair_door_roof_2"];

  foreach(var2 in var0) {
    open_door(var2);
    wait 0.1;
  }
}

function roof_combat_start(var0) {
  scripts\engine\utility::flag_wait("init_roof_combat");
  scripts\cp\cp_modular_spawning::run_spawn_module("bank_combat_roof_init");
  scripts\cp\cp_modular_spawning::run_spawn_module("bank_roof_juggernaut_1");
  scripts\cp\cp_modular_spawning::run_spawn_module("bank_roof_juggernaut_2");
}

function roof_jugg_spawn_func(var0) {
  thread roof_jugg_wake_logic();
}

function roof_jugg_wake_logic() {
  level endon("game_ended");
  self endon("death");
  self.ignoreall = 1;
  self setgoalpos(self.origin);
  var0 = scripts\engine\utility::getStructArray("jugg_room", "targetname");
  self.room_struct = sortbydistance(var0, self.origin)[0];
  var1 = 1;
  var2 = gettime() + (30 + randomint(10)) * 1000;
  var3 = self.origin[2] - 20;
  var4 = self.room_struct.radius * self.room_struct.radius;

  while(var1) {
    foreach(var6 in level.players) {
      if(distancesquared(var6.origin, self.room_struct.origin) <= var4) {
        if(isDefined(var3)) {
          if(var6.origin[2] < var3) {
            continue;
          }
        }

        var1 = 0;
      }
    }

    if(gettime() > var2) {
      var1 = 0;
    }

    wait 0.1;
  }

  self.goalradius = 1024;
  self.ignoreall = 0;
}

function player_sees_hvt() {
  var0 = scripts\engine\utility::getStructArray("vault_assault_crypto_hvt_desk", "targetname");
  var1 = var0[0];
  var2 = var1.origin;
  wait_for_player_nearby(var2, 800, -50, 200);
  wait 1;
  level.player_sees_hvt = 1;
}

function player_sees_hvt_timeout(var0) {
  wait var0;
  level.player_sees_hvt_timeout = 1;
}

function move_juggs_in_elevator() {
  scripts\engine\utility::flag_wait("init_roof_combat");
  wait 3;
  level.hvt_elevator_jugg dodamage(level.hvt_elevator_jugg.health + 1000, level.hvt_elevator_jugg.origin);
}

function hvt_jugg_spawn_func(var0) {
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

function hvt_jugg_skit_spawn_func(var0) {
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

function move_objective_to_hvt(var0) {
  thread setup_breadcrumbs_to_hvt(level);
  var1 = scripts\engine\utility::getStructArray("vault_assault_hvt_desk_computer", "targetname");
  var2 = var1[0];
  var3 = spawn("script_model", var2.origin);
  var3.angles = var2.angles;
  var3 setModel("computer_pc_tower_01");
  thread break_pc_on_damage();

  while(!isDefined(level.bank_hvt)) {
    wait 0.1;
  }

  level waittill("objective_on_hvt");
  thread spawninfo();
  wait 1;
  level.hvt_obj_num = var0.objectiveindex;
  objective_setplayintro(level.hvt_obj_num, 0);
  objective_setplayoutro(level.hvt_obj_num, 0);
  objective_setbackground(level.hvt_obj_num, 0);
  objective_state(level.hvt_obj_num, "current");
  objective_icon(level.hvt_obj_num, "icon_waypoint_objective_general");
  objective_onentity(level.hvt_obj_num, level.bank_hvt);
  objective_setzoffset(level.hvt_obj_num, 70);
}

function spawninfo() {
  var0 = 500;
  var1 = var0 * var0;
  var2 = cos(45);

  foreach(var4 in level.players) {
    if(distancesquared(var4.origin, level.bank_hvt.origin) < var1) {
      if(scripts\engine\utility::within_fov(var4.origin, var4.angles, level.bank_hvt.origin, var2)) {
        thread ref_124ec(level);
        return;
      }
    }
  }
}

function ref_124ec(var0) {
  wait 0.5;
  scripts\cp\cp_player_battlechatter::trysaylocalsound(var0, "obj_target_visual");
}

function break_pc_on_damage() {
  self setCanDamage(1);
  self waittill("damage");
  self setModel("computer_pc_tower_01_broken_destr");
  playFXOnTag(level._effect["pc_break"], self, "tag_origin");
  playsoundatpos(self.origin, "dst_personal_computer");
}

function setup_breadcrumbs_to_hvt(var0) {
  level endon("game_ended");
  var0.objbreadcrumbs = scripts\cp\cp_objectives::create_breadcrumb_for_team("allies", "va_hvt_breadcrumb");
  thread clean_up_breadcrumbs_to_hvt(level);
}

function clean_up_breadcrumbs_to_hvt(var0) {
  level endon("game_ended");
  level waittill("hvt_leaving");
  scripts\cp\cp_objectives::delete_breadcrumb_array(var0.objbreadcrumbs);
}

function spawninsafehouse() {
  var0 = 500;
  var1 = var0 * var0;
  var2 = cos(45);
  var3 = level.players[0];

  foreach(var5 in level.players) {
    if(distancesquared(var5.origin, level.bank_hvt.origin) < var1) {
      if(scripts\engine\utility::within_fov(var5.origin, var5.angles, level.bank_hvt.origin, var2)) {
        var3 = var5;
        break;
      }
    }
  }

  ref_124eb(var3);
}

function ref_124eb(var0) {
  wait 0.25;
  scripts\cp\cp_player_battlechatter::trysaylocalsound(var0, "flavor_negative");
  wait 8;
  scripts\cp\cp_player_battlechatter::trysaylocalsound(var0, "obj_target_moving");
}

function setup_breadcrumbs_to_roof(var0) {
  level endon("game_ended");
  level waittill("hvt_leaving");
  var0.objbreadcrumbs = scripts\cp\cp_objectives::create_breadcrumb_for_team("allies", "va_roof_breadcrumb");
  thread clean_up_breadcrumbs_to_roof(level);
}

function clean_up_breadcrumbs_to_roof(var0) {
  level endon("game_ended");
  level waittill("everyone_on_exfil_heli");
  scripts\cp\cp_objectives::delete_breadcrumb_array(var0.objbreadcrumbs);
}

function tagleaderwithheadicon(var0) {
  level.tmtyl_headicon = deleteheadicon(var0);
  setheadiconfriendlyimage(level.tmtyl_headicon, "hud_icon_hardpoint_diamond");
  setheadiconsnaptoedges(level.tmtyl_headicon, 0);
}

function watchforvipdeath(var0) {
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

function wait_for_jugg_death(var0) {
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

function hvt_think_func(var0) {
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

function send_hvt_to_elevator(var0) {
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

function ref_133b3(var0) {
  level.ref_13b13 = 1;
  wait var0;
  level notify("charge_planted");
  wait 1;
  scripts\engine\utility::flag_set("heli_engage");
}

function allow_breach_charge() {
  level thread scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_kama_bank_breach_door_10");
  var0 = scripts\engine\utility::getStructArray("c4_interact", "targetname");
  var1 = var0[0];
  var2 = scripts\cp\cp_breach_c4::setup_c4(var1);
  var2 scripts\engine\utility::ent_flag_wait("c4_exploded");
  var3 = anglestoright(var2.angles);
  var4 = anglestoup(var3);
  playFX(level._effect["vfx_gen_c4_exp2_ch"], var2.origin, var3, var4);
  var5 = getEnt("hvt_door", "targetname");
  var5 setModel("door_reinforced_door_damaged");
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
  var0 = scripts\engine\utility::getStructArray("vault_assault_hvt_ar_prop", "targetname");
  var1 = var0[0];
  level.hvt_ar = spawn("script_model", var1.origin);
  level.hvt_ar setModel("weapon_vm_ar_akilo47_brprop");
  level.hvt_ar.angles = var1.angles;
  wait 1;
  level.monitor_lookat_ent = spawn("script_model", (6116, 1499, 378));

  if(isDefined(level.bank_hvt) && isDefined(level.bank_hvt_jugg)) {
    var2 = scripts\cp\cp_weapon::buildweapon("iw8_pi_golf21_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
    level.bank_hvt giveweapon(var2);
    level.bank_hvt takeweapon(level.bank_hvt.weapon);
    level.bank_hvt setspawnweapon(var2);
    level.bank_hvt scripts\common\utility::initweapon(var2);
    level.bank_hvt scripts\anim\shared::placeweaponon(var2, "right");
    level.bank_hvt.sidearm = var2;
    var3 = scripts\engine\utility::getStructArray("heistguy", "targetname");
    var4 = var3[0];
    level.bank_hvt_cig = spawn("script_model", level.bank_hvt gettagorigin("tag_eye") + (0, 0, -3));
    level.bank_hvt_usb = spawn("script_model", var4.origin);
    level.bank_hvt_cig.angles = level.bank_hvt gettagangles("tag_eye");
    level.bank_hvt.animstruct = var4;
    level.bank_hvt_cig setModel("tag_origin");
    level.bank_hvt_cig linkTo(level.bank_hvt, "tag_eye", (2.75, -0.5, -2.85), (0, 0, 0));
    level.bank_hvt_usb setModel("electronics_usb_thumb_drive");
    level.bank_hvt_usb scriptmodelplayanimdeltamotionfrompos("cp_bank_heist_office_usb_start", var4.origin, var4.angles);
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
    var0 = scripts\cp\utility::get_closest_living_player();

    if(!isDefined(var0)) {
      self setlookatentity();
      wait 3;
      continue;
    }

    if(distance(var0.origin, self.origin) < 1000) {
      self setlookatentity(var0);
    } else {
      self setlookatentity();
    }

    wait 5;
  }
}

function hvt_idle() {
  level endon("charge_planted");
  thread lookat_players();
  var0 = level.bank_hvt scripts\asm\asm::asm_lookupanimfromalias("animscripted", "bank_heist_guy_idle");
  var1 = level.bank_hvt_jugg scripts\asm\asm::asm_lookupanimfromalias("animscripted", "bank_heist_idle");
  var2 = level.bank_hvt_jugg scripts\asm\asm::asm_getxanim("animscripted", var1);

  for(;;) {
    level.bank_hvt_usb scriptmodelplayanimdeltamotionfrompos("cp_bank_heist_office_usb_idle", level.bank_hvt.animstruct.origin, level.bank_hvt.animstruct.angles);
    level.bank_hvt aisetanim("animscripted", var0);
    level.bank_hvt_jugg aisetanim("animscripted", var1);
    wait getanimlength(var2);
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

function clear_animpos(var0) {
  var0 scripts\asm\shared\mp\utility::bunkercounteruav();
  var0 setlookatentity();
  var0.ignoreall = 0;
  var0.playing_skit = undefined;
  var0.invulnerable = 0;
}

function go_into_elevator() {
  if(isDefined(level.bank_hvt)) {
    var0 = scripts\engine\utility::getStruct("hvt_elevator_pos", "targetname");
    scripts\cp\cp_modular_spawning::set_goal_pos(var0.origin);
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
    var0 = spawn("script_origin", self.origin);
    self linkTo(var0);
    var1 = scripts\engine\utility::getStructArray("hvt_roof_spawn", "targetname");
    var2 = var1[0];
    var0 moveTo(var2.origin, 5);
    var0 waittill("movedone");
    self unlink();
    self.origin = var2.origin;
    self.angles = var2.angles;
    self.ignoreall = 1;
    scripts\cp\cp_modular_spawning::set_goal_pos(self.origin);
    self.goalradius = 8;
    var0 delete();
    return;
  }
}

function roof_jugg_logic(var0) {
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
  var0 = scripts\engine\utility::getStructArray("hvt_roof_exfil", "targetname");
  var1 = var0[0];
  scripts\cp\cp_modular_spawning::set_goal_pos(var1.origin);
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

function ignore_players_not_on_roof(var0, var1, var2, var3) {
  level endon("game_ended");
  self endon("death");
  var4 = var0 * var0;
  var5 = 0;

  while(!var5) {
    for(var6 = 0; var6 < level.players.size; var6++) {
      var7 = level.players[var6];

      if(distancesquared(var7.origin, var1) <= var4) {
        if(isDefined(var2)) {
          if(var7.origin[2] > var2) {
            continue;
          }
        }

        if(isDefined(var3)) {
          if(var7.origin[2] < var3) {
            continue;
          }
        }

        var5 = 1;
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
    var0 = scripts\cp\cp_weapon::buildweapon("iw8_ar_akilo47_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
    level.bank_hvt giveweapon(var0);
    level.bank_hvt takeweapon(level.bank_hvt.weapon);
    level.bank_hvt setspawnweapon(var0);
    level.bank_hvt scripts\common\utility::initweapon(var0);
    level.bank_hvt scripts\anim\shared::placeweaponon(var0, "right");
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
    var0 = scripts\engine\utility::getStructArray("hvt_roof_exfil", "targetname");
    var1 = var0[0];
    scripts\cp\cp_modular_spawning::set_goal_pos(var1.origin);
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

function spawnhandled(var0) {
  if(isPlayer(var0.eattacker)) {
    scripts\cp\cp_player_battlechatter::trysaylocalsound(var0.eattacker, "obj_target_eliminated");
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

function setup_hvt_in_heli(var0, var1, var2) {
  var3 = "tag_pilot";

  if(isDefined(var0)) {
    var3 = var0;
  }

  var4 = (0, 0, 0);

  if(isDefined(var1)) {
    var4 = var1;
  }

  var5 = (0, 0, 0);

  if(isDefined(var2)) {
    var5 = var2;
  }

  if(!self tagexists(var3)) {
    var3 = "tag_pilot1";
  }

  self.hvt_in_heli = spawn("script_model", self gettagorigin(var3));
  self.hvt_in_heli setModel("british_pilot_fullbody");
  self.hvt_in_heli linkTo(self, var3, var4, var5);
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

function should_drop_hvt_key(var0) {
  if(istrue(self.bank_hvt)) {
    return true;
  }

  return false;
}

function drop_hvt_key(var0) {
  var1 = spawnStruct();
  var1.origin = self.origin;
  var1.angles = (0, 0, 0);
  level.spawnhumandogtags = 1;
  create_key_card(var1);
}

function waittill_players_on_roof() {
  var0 = scripts\engine\utility::getStructArray("hvt_roof_spawn", "targetname");
  var1 = var0[0];
  var2 = -200;
  wait_for_player_nearby(var1.origin, 4000, var2);
  level.players_on_roof = 1;
}

function init_vault_assault_rooftop(var0, var1) {
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_post_vault");
  scripts\cp\cp_spawning_util::ref_13bbd(0);
}

function start_vault_assault_rooftop(var0, var1) {
  var2 = scripts\cp\cp_modular_spawning::get_spawned_ai_from_group_struct("bank_combat_init");

  if(isDefined(var2)) {
    foreach(var4 in var2) {
      var4 scripts\cp\cp_modular_spawning::script_kill_ai();
    }
  }

  var2 = scripts\cp\cp_modular_spawning::get_spawned_ai_from_group_struct("bank_combat_init_sniper");

  if(isDefined(var2)) {
    foreach(var4 in var2) {
      var4 scripts\cp\cp_modular_spawning::script_kill_ai();
    }
  }

  var2 = scripts\cp\cp_modular_spawning::get_spawned_ai_from_group_struct("bank_combat_init_rpg");

  if(isDefined(var2)) {
    foreach(var4 in var2) {
      var4 scripts\cp\cp_modular_spawning::script_kill_ai();
    }

    return;
  }
}

function end_vault_assault_rooftop(var0, var1) {
  scripts\cp\cp_objectives::overridenextstep(var0, "vault_assault_rooftop_heli");
}

function ref_12d84(var0) {
  self.never_kill_off = 1;
  thread ref_1301d();
}

function ref_1301d() {
  self endon("death");
  var0 = ["rooftop_back_org_target", "rooftop_front_org_target"];
  var1 = [];

  foreach(var3 in var0) {
    var4 = scripts\engine\utility::getStruct(var3, "targetname");
    var1 = scripts\engine\utility::array_add(var1, var4);
  }

  var6 = scripts\engine\utility::getclosest(self.origin, var1);
  scripts\cp\cp_modular_spawning::set_goal_radius(96);
  scripts\cp\cp_modular_spawning::set_goal_pos(var6.origin);
  scripts\engine\utility::ref_143ad("goal", "goal_reached");
  self.never_kill_off = undefined;
  scripts\cp\cp_modular_spawning::return_to_last_goalRadius();
}

function ref_140bf(var0, var1) {
  var0 scripts\cp\cp_modular_spawning::spawner_init();

  if(isDefined(level.ref_14682) && var0.origin[2] > level.ref_14682) {
    return 0;
  }

  return scripts\cp\cp_spawner_scoring::standard_spawnpoint_valid(var0, var1);
}

function ref_140be(var0, var1) {
  if(isDefined(level.ref_14682) && var0.origin[2] > level.ref_14682) {
    return 0;
  }

  return scripts\cp\cp_spawner_scoring::cluster_spawnpoint_valid(var0, var1);
}

function init_vault_assault_rooftop_heli(var0, var1) {
  scripts\cp\cp_spawning_util::ref_13bbd(0);
}

function start_vault_assault_rooftop_heli(var0, var1) {
  var2 = scripts\engine\utility::getStruct("vault_assault_start", "targetname");
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
  scripts\cp\cp_objectives::overridenextstep(var0, "vault_assault_rooftop_defend");
}

function end_vault_assault_rooftop_heli(var0, var1) {}

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
  level waittill("rpg_picked_up", var0);
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

function tag_heli_with_head_icon(var0) {
  level.heli_headicon = deleteheadicon(var0);
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

function init_vault_assault_rooftop_defend(var0, var1) {
  scripts\cp\cp_spawning_util::ref_13bbd(0);
}

function start_vault_assault_rooftop_defend(var0, var1) {
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
  var2 = scripts\engine\utility::getStructArray("vault_assault_rooftop", "targetname");
  var3 = var2[0];
  level notify("call_exfil", var3.origin, 1);
  level notify("stop_paratroopers");

  foreach(var5 in level.players) {
    var5 notify("drop_saw");
  }

  while(!isDefined(level.exfil_heli)) {
    wait 0.1;
  }

  level waittill("arrive_at_exfil_location");
}

function end_vault_assault_rooftop_defend(var0, var1) {
  scripts\cp\cp_objectives::overridenextstep(var0, "vault_assault_rooftop_exfil");
}

function ref_13e3c(var0) {
  wait var0;
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_heli_roof_low");
  scripts\cp\cp_modular_spawning::stop_module_by_groupname("bank_combat_heli_roof_high");
}

function init_vault_assault_rooftop_exfil(var0, var1) {
  scripts\cp\cp_spawning_util::ref_13bbd(0);
}

function start_vault_assault_rooftop_exfil(var0, var1) {
  thread delay_and_play_vo_to_team(level, 10);
  level waittill("ready_to_exfil");
  level.battlechatterenabled = 0;
  scripts\cp\utility::ref_123fe("mus_cp_money_helo_exfil");

  foreach(var3 in level.players) {
    level notify("kill_queued_bc_sound_" + var3.name);
    var3 setsoundsubmix("cp_matchend_music", 5);
  }

  wait 2;

  if(istrue(level.spawninfluencepoints)) {
    foreach(var3 in level.players) {
      var3 scripts\cp_mp\xmike109::scriptable_callback("downtown_2");
    }

    level thread scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_bank_mission_successful_intel_10");
  } else {
    level thread scripts\cp\cp_dialogue::play_vo_to_all("dx_cps_lass_bank_mission_successful_10");
  }

  foreach(var3 in level.players) {
    var3 scripts\cp_mp\xmike109::scriptable_callback("downtown_3");

    if(scripts\cp\cp_relics::calldropbag()) {
      if(scripts\cp\cp_gameskill::get_gameskill() != 3) {
        var3 thread scripts\cp_mp\xmike109::scriptable_callback("strongbox_mod");
        continue;
      }

      var3 thread scripts\cp_mp\xmike109::scriptable_callback("strongbox_mod_vet");
    }
  }

  thread mp_shipment_patch();
}

function end_vault_assault_rooftop_exfil(var0, var1) {}

function mp_shipment_patch() {
  foreach(var1 in level.players) {
    var1 thread scripts\mp\vehicles\vehicle_damage_mp::ref_1340d(2, 1, 1);
  }

  wait 2;

  foreach(var1 in level.players) {
    if(!istrue(var1.try_to_punish_with_jugg)) {
      var1.invulnerable = 1;
      var1 allowmovement(0);
    }

    var4 = scripts\engine\utility::getStruct("vaultassault_camera_ending", "targetname");
    var5 = var4.origin;
    var6 = scripts\engine\utility::getStruct(var4.target, "targetname");
    var7 = spawn("script_model", var5);
    var7 setModel("tag_origin");
    var7.angles = var4.angles;
    var7 moveTo(var6.origin, 20, 1, 1);
    var1 playerhide();
    var1 allowfire(0);
    var1 disableoffhandweapons();
    var1 disableusability();
    var1 allowmovement(0);
    var1 setclientomnvar("ui_hide_hud", 1);
    spawn_endgame_camera(var1, var7);
    var1 lerpfovscalefactor(0, 0);
  }
}

function spawn_endgame_camera(var0) {
  self.ignoreme = 1;
  self cameralinkTo(var0, "tag_origin", 1);
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

function wait_for_player_nearby(var0, var1, var2, var3) {
  var4 = var1 * var1;
  var5 = undefined;

  if(isDefined(var2)) {
    var5 = var0[2] + var2;
  }

  var6 = undefined;
  jumpiffalse(isDefined(var3)) LOC_00000029;
  var6 = var0[2] + var3;

  for(;;) {
    var7 = 0;

    foreach(var9 in level.players) {
      if(distance2dsquared(var9.origin, var0) <= var4) {
        if(isDefined(var5)) {
          if(var9.origin[2] < var5) {
            continue;
          }
        }

        if(isDefined(var6)) {
          if(var9.origin[2] > var6) {
            continue;
          }
        }

        var7 = 1;
      }
    }

    if(var7) {
      break;
    }

    wait 0.1;
  }
}

function send_heli_reinforcements(var0) {
  level endon("stop_heli_rein");

  for(;;) {
    wait var0;

    while(level.spawned_enemies.size > 12) {
      wait 0.1;
    }
  }
}

function drop_intel_from_hvt() {}

function open_elevator_doors_roof() {
  var0 = getEntArray("elevator_door", "targetname");

  foreach(var2 in var0) {
    var2.starting_pos = var2.origin;

    if(isDefined(var2.target)) {
      var3 = scripts\engine\utility::getStruct(var2.target, "targetname");
      var2 moveTo(var3.origin, 2, 0.1, 0.1);
    }
  }

  wait 2;
}

function close_elevator_doors_roof() {
  var0 = getEntArray("elevator_door", "targetname");

  foreach(var2 in var0) {
    if(isDefined(var2.starting_pos)) {
      var2 moveTo(var2.starting_pos, 2, 0.1, 0.1);
    }
  }

  wait 2;
}

function open_elevator_doors(var0, var1) {
  var2 = getEntArray("elevator_door" + var0, "targetname");
  var3 = undefined;

  foreach(var5 in var2) {
    if(!isDefined(var3)) {
      var3 = var5;
    }

    if(!istrue(var5.open)) {
      var5.starting_pos = var5.origin;

      if(isDefined(var5.target)) {
        var6 = scripts\engine\utility::getStructArray(var5.target, "targetname");
        var7 = var6[0];
        var5 moveTo(var7.origin, 2, 0.1, 0.1);
      }
    }
  }

  if(isDefined(var3)) {
    var9 = (0, 0, 0);
    var10 = var3.origin + var9;
    playsoundatpos(var10, "scn_cp_bank_heist_elevator_open_2sec");
  }

  wait 2;

  foreach(var5 in var2) {
    var5.open = 1;
    var5 connectpaths();
  }

  if(isDefined(var1)) {
    level notify(var1);
    return;
  }
}

function close_elevator_doors(var0) {
  var1 = getEntArray("elevator_door" + var0, "targetname");
  var2 = undefined;

  foreach(var4 in var1) {
    if(!isDefined(var2)) {
      var2 = var4;
    }

    if(istrue(var4.open)) {
      if(isDefined(var4.starting_pos)) {
        var4 moveTo(var4.starting_pos, 2, 0.1, 0.1);
      }
    }
  }

  if(isDefined(var2)) {
    var6 = (0, 0, 0);
    var7 = var2.origin + var6;
    playsoundatpos(var7, "scn_cp_bank_heist_elevator_close_2sec");
  }

  wait 2;

  foreach(var4 in var1) {
    var4.open = undefined;
    var4 disconnectPaths();
  }
}

function setup_module_groups() {}

function create_deposit_box_interaction(var0) {
  var1 = spawn("script_model", var0.origin);
  var1 setModel("lm_hardware_bank_safety_deposit_door_a_01_cp");
  waitframe();
  var1 setHintString(&"CP_DWN_TWN_OBJECTIVES/DEPOSIT_BOX");
  var1 setCursorHint("HINT_BUTTON");
  var1 sethintdisplayrange(200);
  var1 sethintdisplayfov(65);
  var1 setuserange(72);
  var1 setusefov(65);
  var1 sethinttag("tag_hint");
  var1 sethintonobstruction("show");
  var1 setuseholdduration("duration_none");
  var1 makeusable();
  var1.targetname = "interaction";

  if(isDefined(var0.angles)) {
    var1.angles = var0.angles;
  } else {
    var1.angles = (0, 0, 0);
  }

  thread deposit_box_activate(var1);
  return var1;
}

function create_usb_pickup_interaction(var0, var1) {
  var2 = spawn("script_model", var0.origin);
  var2 setModel("electronics_usb_thumb_drive");
  var2 setHintString(&"CP_DWN_TWN_OBJECTIVES/KEY_CARD");
  var2 setCursorHint("HINT_BUTTON");
  var2 sethintdisplayrange(200);
  var2 sethintdisplayfov(65);
  var2 setuserange(72);
  var2 setusefov(65);
  var2 sethintonobstruction("show");
  var2 setuseholdduration("duration_none");
  var2 makeusable();

  if(istrue(var1)) {
    objective_position(level.crypto_key_objective.objectiveindex, var2.origin + (0, 0, 10));
    objective_setbackground(level.crypto_key_objective.objectiveindex, 2);
  }

  var2 hudoutlineenable("outlinefill_depth_cyan");
  level notify("deposit_usb_found");

  for(;;) {
    var2 waittill("trigger", var3);

    if(!var3 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    level.key_card_acquired = 1;
    var2 hide();
    var2 hudoutlinedisable();
    thread ref_12501(level);
    var3 scripts\cp\intel\cp_intel::give_intel_weapon("intel_put_usb_in_tablet");

    if(istrue(level.spawnhumandogtags)) {
      level.spawninfluencepoints = 1;
    }

    if(istrue(var1)) {
      objective_state(level.crypto_key_objective.objectiveindex, "done");
    }

    break;
  }

  wait 0.1;
  var2 delete();
}

function ref_12501(var0) {
  var0 endon("death");
  wait 2;
  scripts\cp\cp_player_battlechatter::trysaylocalsound(var0, "obj_package");
}

function create_key_card_interaction(var0) {
  var1 = spawnStruct();
  var1.origin = var0.origin;
  var1.targetname = "interaction";
  var1.script_noteworthy = "key_card_interaction";
  var1.requires_power = 0;
  var1.spend_type = "null";
  var1.model = spawn("script_model", var1.origin);
  var1.model setModel("electronics_usb_thumb_drive");

  if(isDefined(var0.angles)) {
    var1.model.angles = var0.angles;
  } else {
    var1.model.angles = (0, 0, 0);
  }

  var1.model hudoutlineenable("outlinefill_depth_red");
  var1.cost = 0;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var1);
}

function tag_key_card_with_head_icon(var0) {
  level.key_card_headicon = deleteheadicon(var0);
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

function delay_then_run_cover_node_spawning(var0, var1) {
  level endon("stop_delayed_spawn_module");
  wait var1;
  level.passive_wave_settings.high_threshold = 18;
  var2 = 36 - level.spawned_enemies.size;
  level.passive_wave_settings.max_count = max(0, var2);
  scripts\cp\cp_modular_spawning::run_spawn_module(var0);
}

function delay_then_run_spawn_module(var0, var1, var2) {
  level endon("stop_delayed_spawn_module");
  wait var1;
  var3 = undefined;

  if(isDefined(var2)) {
    var3 = scripts\cp\cp_modular_spawning::set_wave_ref_override(var2);
    return;
  }
}

function ref_1337e(var0) {
  wait var0;
  var1 = scripts\engine\utility::getStruct("vault_assault_start", "targetname");
  var2 = scripts\cp\cp_modular_spawning::get_module_structs_by_groupname("wave_spawning");

  foreach(var4 in var2) {
    thread ref_1337d(var4);
  }
}

function ref_1337d(var0) {
  scripts\cp\cp_modular_spawning::add_spawn_scoring_poi(var0.origin, 3000, 10000);
  wait_for_player_nearby(var0.origin, 3500);
  scripts\cp\cp_modular_spawning::remove_spawn_scoring_poi(var0.origin);
  scripts\cp\cp_modular_spawning::add_spawn_scoring_poi(var0.origin, 2000, 4000);
}

function short_and_long_delay(var0, var1, var2, var3) {
  if(istrue(var0.longer_spawn_delay)) {
    return var2;
  }

  return var1;
}

function should_run_event(var0) {
  return false;
}

function spawn_static_trucks() {
  level endon("game_ended");
  wait 1;
  level.static_trucks = [];
  level.static_ks_crates = [];
  var0 = scripts\engine\utility::getStructArray("static_ks_crate", "targetname");

  for(var1 = 0; var1 < var0.size; var1++) {
    var2 = 0;

    foreach(var4 in level.static_ks_crates) {
      if(var4.origin == var0[var1].origin) {
        var2 = 1;
      }
    }

    if(!var2) {
      var4 = spawn("script_model", var0[var1].origin);
      var4 setModel("military_carepackage_01_friendly");
      level.static_ks_crates[level.static_ks_crates.size] = var4;
    }
  }

  level.static_ks_tablets = [];
  var6 = scripts\engine\utility::getStructArray("static_ks_tablet", "targetname");

  for(var1 = 0; var1 < var6.size; var1++) {
    var2 = 0;

    foreach(var8 in level.static_ks_tablets) {
      if(var8.origin == var6[var1].origin) {
        var2 = 1;
      }
    }

    if(!var2) {
      var8 = spawn("script_model", var6[var1].origin);
      var8 setModel("offhand_wm_tablet");

      if(isDefined(var6[var1].target)) {
        var8.target = var6[var1].target;
      }

      thread activate_ks_on_use();
      level.static_ks_tablets[level.static_ks_tablets.size] = var8;
    }
  }

  level.static_rpgs = [];
  var10 = scripts\engine\utility::getStructArray("rpg_pickup", "targetname");

  for(var1 = 0; var1 < var10.size; var1++) {
    var2 = 0;

    foreach(var12 in level.static_rpgs) {
      if(var12.origin == var10[var1].origin) {
        var2 = 1;
      }
    }

    if(!var2) {
      var12 = spawn("script_model", var10[var1].origin);
      var12.angles = var10[var1].angles;
      waitframe();
      var12 setModel("weapon_wm_la_rpapa7");
      thread activate_rpgs_on_use();
      level.static_rpgs[level.static_rpgs.size] = var12;
    }
  }

  thread spawn_enemy_tanks();
  thread ref_135fa();
}

function spawn_enemy_tanks() {
  var0 = scripts\engine\utility::getStructArray("bank_tank", "targetname");
  level.altgunnerturret = "sentry_minigun_mp";
  level.enemy_tanks = [];

  foreach(var2 in var0) {
    level thread scripts\mp\challenges_mp::spawn_enemy_tank(var2);
    wait randomintrange(3, 7);
  }
}

function ref_135fa() {
  var0 = scripts\engine\utility::getStructArray("bank_wheelson", "targetname");
  var1 = 0;

  foreach(var3 in var0) {
    var4 = scripts\engine\utility::getStruct(var3.target, "targetname");
    thread spawn_remote_tank(level, var4, "tank" + var1);
    var1++;
    wait 1;
  }

  var0 = scripts\engine\utility::getStructArray("bank_wheelson_lobby", "targetname");

  foreach(var3 in var0) {
    var4 = scripts\engine\utility::getStruct(var3.target, "targetname");
    thread spawn_remote_tank(level, var4, "tank" + var1);
    var1++;
    wait 1;
  }
}

function activate_ks_on_use() {
  level endon("game_ended");
  var0 = &"CP_BR/DRONE_STRIKE";
  self setHintString(var0);
  self setCursorHint("HINT_BUTTON");
  self sethintdisplayrange(500);
  self sethintdisplayfov(65);
  self setuserange(72);
  self setusefov(65);
  self sethintonobstruction("show");
  self setuseholdduration("duration_none");
  self makeusable();

  for(;;) {
    self waittill("trigger", var1);

    if(!var1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(isDefined(self.target)) {
      var1.drone_strike_dir_override = scripts\engine\utility::getStruct(self.target, "targetname");
    }

    var1 thread scripts\cp\crafting_system::giveitembasedoncraftingstruct("cruise_missile");
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
  var0 = &"CP_BR/RPG_PICKUP";
  self setHintString(var0);
  self setCursorHint("HINT_BUTTON");
  self sethintdisplayrange(500);
  self sethintdisplayfov(65);
  self setuserange(72);
  self setusefov(65);
  self sethintonobstruction("hide");
  self setuseholdduration("duration_none");
  self makeusable();

  for(;;) {
    self waittill("trigger", var1);

    if(!var1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(!var1 scripts\common\utility::is_weapon_pickup_allowed()) {
      continue;
    }

    var2 = getentarrayinradius("dropped_weapon", "targetname", self.origin, 512);

    if(isDefined(var2) && var2.size > 0) {
      foreach(var4 in var2) {
        if(isDefined(var4) && isDefined(var4.classname) && issubstr(var4.classname, "iw8_la_rpapa7_mp")) {
          var4 delete();
        }
      }
    }

    var6 = spawnStruct();
    var6.loadoutprimary = "iw8_la_rpapa7_mp";
    var6.loadoutprimaryattachments = ["none", "none", "none", "none", "none", "none"];
    var6.loadoutprimarycamo = "none";
    var6.loadoutprimaryreticle = "none";
    var6.loadoutprimaryvariantid = -1;
    var1.entnumber = var1 getentitynumber();
    var6.loadoutprimarypaintjobid = 0;
    var6.loadoutprimarycosmeticattachment = "none";
    var6.loadoutprimaryobject = scripts\cp\cp_weapon::buildweapon(var6.loadoutprimary);
    var6.loadoutprimaryfullname = createheadicon(var6.loadoutprimaryobject);
    var7 = ref_1247d(var1);
    var8 = ref_12475(var1);
    var9 = var6.loadoutprimaryobject;

    if(!var1 hasweapon("iw8_la_rpapa7_mp")) {
      if(scripts\cp\cp_weapon::ref_124ad(var1)) {
        scripts\cp\cp_weapon::minigamefinishcount(var1);
        var1 waittill("weapon_change");

        while(scripts\cp\cp_weapon::ref_124ad(var1)) {
          waitframe();
        }

        while(nullweapon(var1 getcurrentweapon())) {
          waitframe();
        }
      }

      if(!var8) {
        var1 scripts\cp\cp_weapons::minigun_track_target_think();
        var1 giveweapon(var9);
      } else {
        var9 = raise_airlock(var1);
      }
    }

    var10 = weaponclipsize(var9);
    var11 = weaponmaxammo(var9);
    var1 setweaponammoclip(var9, var10);
    var1 setweaponammostock(var9, var11);

    if(!var7 && !scripts\cp\cp_weapon::ref_124ad(var1)) {
      var1 switchtoweaponimmediate(var9);
    }

    level notify("rpg_picked_up", var1);
    wait 3;
  }

  self delete();
}

function ref_1247d() {
  var0 = self getcurrentprimaryweapon();

  if(var0.basename == "iw8_la_rpapa7_mp") {
    return true;
  }

  return false;
}

function ref_12475() {
  foreach(var1 in self getweaponslistprimaries()) {
    if(var1.basename == "iw8_la_rpapa7_mp") {
      return true;
    }
  }

  return false;
}

function raise_airlock() {
  foreach(var1 in self getweaponslistprimaries()) {
    if(var1.basename == "iw8_la_rpapa7_mp") {
      return var1;
    }
  }
}

function modescorewinner(var0, var1, var2, var3, var4) {
  level endon("game_ended");

  if(isDefined(var4)) {
    level endon(var4);
  }

  if(!isDefined(var2)) {
    var2 = 2000;
  }

  if(!isDefined(var3)) {
    var3 = 1;
  } else {
    var3 = max(var3, 0.05);
  }

  GscBinSkip4(0x35, var0, var1, var2, var3);
}

function modespawn(var0, var1, var2, var3) {
  for(;;) {
    var4 = getentarrayinradius("dropped_weapon", "targetname", var1, var2);

    if(isDefined(var4) && var4.size > 0) {
      foreach(var6 in var4) {
        if(isDefined(var6) && isDefined(var6.classname) && issubstr(var6.classname, var0)) {
          var6 delete();
        }
      }
    }

    wait var3;
  }
}

function spawn_remote_tank(var0, var1, var2) {
  var3 = var0;

  if(isDefined(var3)) {
    if(!isDefined(var3.angles)) {
      var3.angles = (0, 0, 0);
    }

    var4 = scripts\cp\cp_remote_tank::spawn_remote_tank(var3, var1);
    var4 thread scripts\cp\cp_remote_tank::fire_on_nearby_players();
    var4.enemy_notify_range = 2000;
    var4.max_detection_sq = 2250000;
    var4 makeunusable();
    var4.mgturret makeunusable();
    thread damage_monitor();
    thread init_global_cp_script_funcs();
    thread ref_12bc0(var4, var0);
    return;
  }
}

function ref_12bc0(var0, var1) {
  self endon("death");

  if(isDefined(var1)) {
    scripts\engine\utility::flag_wait(var1);
  }

  scripts\engine\utility::flag_wait("activate_wheelsons");
  wait 5;
  self vehicle_setspeed(1, 1, 1);
  thread ref_145b3(var0);
}

function init_global_cp_script_funcs() {
  var0 = createnavobstaclebyent(self);
  self waittill("death");

  if(isDefined(var0)) {
    destroynavobstacle(var0);
    return;
  }
}

function ref_145b3(var0) {
  self endon("death");
  var1 = ref_145ad(var0);
  var2 = 1;
  var3 = 3;
  var4 = 40000;

  if(var1.size < 2) {
    return;
  }

  var5 = fire_sfx_org(var0);
  self startpathnodes(var1, var5, 1, 0.5, 0.5, 0, 1);
}

function ref_145ad(var0) {
  self endon("death");
  var1 = [];
  var2 = var0;

  for(var1 = var2.origin; isDefined(var2) && isDefined(var2.target); var1 = var2.origin) {
    var2 = scripts\engine\utility::getStruct(var2.target, "targetname");
  }

  return var1;
}

function fire_sfx_org(var0) {
  self endon("death");
  var1 = [];
  var2 = var0;

  for(var1 = 4; isDefined(var2) && isDefined(var2.target); var1 = 8) {
    var2 = scripts\engine\utility::getStruct(var2.target, "targetname");
  }

  return var1;
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
  var0 = 0.25;

  for(;;) {
    self waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);

    if(!isDefined(var2)) {
      continue;
    } else if(isvector(var2)) {
      continue;
    }

    if(isDefined(var2.owner) && !isPlayer(var2.owner)) {
      continue;
    } else if(!isPlayer(var2)) {
      continue;
    }

    var11 = undefined;
    var12 = "standard";

    if(isDefined(var10)) {
      if(var10.basename == "cruise_proj_mp") {
        var1 = 1000;
      }

      if(var10.classname == "rocketlauncher") {
        var1 = max(var1, self.ref_13c4f / 2 + 10);
      }
    }

    if(self.currenthealth - var1 < 0) {
      var11 = 1;
    }

    if(isDefined(var2)) {
      if(isDefined(var10)) {
        switch (var10.basename) {
          case "molotov_mp":
            thread ref_11cbb(6, var2, var4);
            break;
          case "thermite_mp":
            thread ref_13b1b(7, var2, var4);
            break;
          default:
            break;
        }

        var1 = scripts\cp\cp_damage::handleapdamage(var10, var5, var1, var2);
      }

      if(isDefined(var2.owner)) {
        var2.owner thread scripts\cp\cp_damagefeedback::updatedamagefeedback(var12, var11, var1, 0);
      } else {
        var2 thread scripts\cp\cp_damagefeedback::updatedamagefeedback(var12, var11, var1, 0);
      }
    }

    var13 = isDefined(var2) && isPlayer(var2);
    var14 = isDefined(var2.owner) && isPlayer(var2.owner);
    var15 = isDefined(var2.classname) && var2.classname == "script_vehicle" && isDefined(var2.owner) && isPlayer(var2.owner);
    var16 = var15 && var5 == "MOD_CRUSH";

    if(var13 || var14 || var16) {
      if(!scripts\cp\utility::tryingtoleave() && isDefined(var10)) {
        if(var14) {
          var2 = var2.owner;
        }

        scripts\cp\cp_agent_damage::addattacker(self, var2, var2, var10, var1, var4, var3, undefined, undefined, var5);
      }
    }

    if(scripts\engine\utility::isbulletdamage(var5)) {
      level notify("enemy_spotted", self);
      var1 *= var0;
    }

    if(istrue(var11)) {
      self notify("death");
      return;
    }

    self.currenthealth -= var1;

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

function ref_11cbb(var0, var1, var2) {
  self endon("death");
  var3 = 2025;

  if(isDefined(var2)) {
    if(distancesquared(var2, self.origin) > var3) {
      return;
    }
  }

  var4 = gettime() + var0 * 1000;

  while(var4 > gettime()) {
    self dodamage(15, self.origin, var1);
    wait 1;
  }
}

function ref_13b1b(var0, var1, var2) {
  self endon("death");
  var3 = 2025;

  if(isDefined(var2)) {
    if(distancesquared(var2, self.origin) > var3) {
      return;
    }
  }

  var4 = gettime() + var0 * 1000;

  while(var4 > gettime()) {
    self dodamage(125, self.origin, var1);
    wait 1;
  }
}

function ref_13a41() {
  level endon("game_ended");
  self waittill("death");

  if(isDefined(self.attackerdata)) {
    foreach(var1 in level.players) {
      if(!isDefined(var1)) {
        continue;
      }

      if(!isDefined(var1.guid)) {
        continue;
      }

      if(!isDefined(self.attackerdata[var1.guid])) {
        continue;
      }

      if(!isDefined(self.attackerdata[var1.guid].damage)) {
        continue;
      }

      var2 = 0;

      if(self.attackerdata[var1.guid].damage >= self.maxhealth * 0.1) {
        var2 = 1;
      }

      if(self.attackerdata[var1.guid].damage >= self.maxhealth * 0.2) {
        var2 = 2;
      }

      if(var2 >= 1) {
        var1 thread scripts\cp\drone\emp_drone::giverankxp("destroyed_pac_sentry", scripts\cp\drone\emp_drone::getscoreinfovalue("destroyed_pac_sentry"));
      }
    }
  }

  playFX(level._effect["remote_tank_explode"], self.origin);
  self.mgturret delete();
  self delete();
}

function listen_for_enemy_alert() {
  level endon("enemy_alert");
  level waittill("enemy_spotted", var0);
  thread alert_enemy_soldiers();
  scripts\engine\utility::flag_set("enemy_alert");
}

function proximity_alert() {
  level endon("game_ended");
  level endon("enemy_alert");
  var0 = scripts\engine\utility::getStructArray("prox_alert", "targetname");
  var1 = 0;

  while(!var1) {
    foreach(var3 in level.players) {
      foreach(var5 in var0) {
        var6 = var5.script_radius * var5.script_radius;

        if(distance2dsquared(var3.origin, var5.origin) < var6) {
          var1 = 1;
          break;
        }
      }

      if(var1) {
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
  var0 = spawnStruct();
  var0.type = "bulletwhizby";

  foreach(var2 in level.spawned_enemies) {
    var2 notify("ai_events", [var0]);
  }
}

function elevator_button_hint(var0, var1) {
  if(var0.floor_num == "third") {
    return &"CP_DWN_TWN_OBJECTIVES/ELEVATOR_BASEMENT";
  }

  if(var0.floor_num == "basement") {
    return &"CP_DWN_TWN_OBJECTIVES/ELEVATOR_ROOF";
  }

  return "";
}

function elevator_button_activate(var0, var1) {
  if(istrue(var0.elevator_moving)) {
    return;
  }

  var2 = 1;
  var3 = 3600;
  var4 = scripts\engine\utility::getStruct("vault_assault_elevator_trigger", "targetname");
  var5 = var4.origin;

  foreach(var1 in level.players) {
    if(distance2dsquared(var1.origin, var5) > var3) {
      var2 = 0;
      break;
    }
  }

  if(!var2) {
    iprintlnbold("all players needed in elevator");
    return;
  }

  var0.elevator_moving = 1;
  send_players_to_floor(var0);
}

function send_players_to_floor(var0) {
  if(var0.floor_num == "third") {
    close_elevator_doors("_" + var0.floor_num);
    level.bank_elevator = "basement";
    wait 1;
    scripts\cp\utility::teleportallplayersinteamtostructs("allies", "vault_assault_elevator_pos_crypto");
    wait 3;
    var0.floor_num = "basement";
    var0.elevator_moving = 0;
    open_elevator_doors("_" + var0.floor_num);
    return;
  }

  if(var0.floor_num == "basement") {
    close_elevator_doors("_" + var0.floor_num);
    level.bank_elevator = "roof";
    wait 1;
    scripts\cp\utility::teleportallplayersinteamtostructs("allies", "vault_assault_elevator_pos_roof");
    wait 3;
    var0.floor_num = "";
    open_elevator_doors(var0.floor_num);
    return;
  }
}

function deposit_box_hint(var0, var1) {
  return &"CP_DWN_TWN_OBJECTIVES/DEPOSIT_BOX";
}

function deposit_box_activate(var0) {
  self endon("death");
  self endon("game_ended");

  for(;;) {
    self waittill("trigger", var1);
    self playSound("cp_bank_deposit_open");

    if(isDefined(var1)) {
      if(!var1 scripts\cp\utility::is_valid_player()) {
        continue;
      }
    }

    level.deposit_box_search = 1;

    if(istrue(var0.key_card)) {
      thread create_key_card(var0, 1);
    }

    var0 rotateTo(var0.angles + (0, 60, 0), 0.25);
    var0 makeunusable();
  }
}

function key_card_hint(var0, var1) {
  if(!istrue(var0.started_hack)) {
    return &"CP_DWN_TWN_OBJECTIVES/KEY_CARD";
  }

  return "";
}

function key_card_activate(var0, var1) {
  if(istrue(var0.started_hack)) {
    return;
  }

  var0.started_hack = 1;
  level.key_card_acquired = 1;
  var0.model hide();
  remove_key_card_head_icon();
}

function hvt_skit_notetrack_handler() {
  self endon("death");

  for(;;) {
    self waittill("animscripted", var0);

    if(!isDefined(var0)) {
      var0 = ["undefined"];
    }

    if(!isarray(var0)) {
      var0 = [var0];
    }

    var1 = undefined;

    foreach(var3 in var0) {
      switch (var3) {
        case "start_firing":
          thread start_firing();
          var4 = getEnt("hvt_door", "targetname");
          var4 playSound("scn_cp_bank_heist_jugg_door_bullet_imps");
          break;
        case "fire_weapon":
          self shoot();
          break;
        case "stop_firing":
          self notify("stop_firing");
          break;
        case "door_kick":
          var5 = getEnt("hvt_door_clip", "targetname");
          var4 = getEnt("hvt_door", "targetname");
          var4 rotateby((0, 0, 90), 0.35);
          var5 connectpaths();
          var5 notsolid();
          var4 playSound("scn_cp_bank_heist_jugg_door_kick_settle");
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

function delay_and_play_vo_to_team(var0, var1) {
  level endon("game_ended");
  wait var0;
  level thread scripts\cp\cp_dialogue::play_vo_to_all(var1);
}

function mark_never_remove(var0) {
  self.never_kill_off = 1;
}

function mark_group_as_killable(var0) {
  var1 = scripts\cp\cp_modular_spawning::get_module_structs_by_groupname(var0);
  var1 = level.spawn_module_structs_memory[var0];

  if(isDefined(var1)) {
    foreach(var3 in var1) {
      foreach(var5 in var3.ai_spawned) {
        var5.never_kill_off = undefined;
      }
    }

    return;
  }
}

function start_mortars() {
  level.get_mortar_impact_pos = &get_mortar_impact_spot;
  mortar_launch_think();
}

function get_mortar_impact_spot(var0) {
  if(!isDefined(var0.targets)) {
    return undefined;
  }

  var1 = scripts\engine\utility::random(var0.targets);
  var2 = var1.origin + (randomintrange(-50, 50), randomintrange(-50, 50), 0);
  var3 = scripts\engine\trace::ray_trace(var2 + (0, 0, 500), var2);
  return var3["position"];
}

function mortar_launch_think() {
  scripts\cp\cp_modular_spawning::increase_reserved_spawn_slots(3, "bank_roof_mortar");
  var0 = scripts\cp\cp_modular_spawning::run_spawn_module("bank_roof_mortar");
  thread mortar_think(level.rooftop_1_mortar);
  thread mortar_think(level.rooftop_2_mortar);
  thread mortar_think(level.rooftop_3_mortar);
}

function mortar_think(var0) {
  self.targets = undefined;

  for(;;) {
    var1 = get_players_on_rooftop(var0);

    if(var1.size) {
      self.targets = var1;
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

  var0 = ["dx_cps_kama_callout_paratrooper_spawning_10", "dx_cps_kama_callout_paratrooper_spawning_20", "dx_cps_lass_callout_paratrooper_spawning_10", "dx_cps_lass_callout_paratrooper_spawning_20"];
  level scripts\cp\cp_vo::try_to_play_vo_on_team(scripts\engine\utility::random(var0), "allies");
  level.ref_121d5 = gettime() + 30000;
}

function get_players_on_rooftop(var0) {
  var1 = scripts\engine\utility::getStructArray("hvt_roof_spawn", "targetname");
  var2 = var1[0];
  var3 = var2.origin + (0, 0, -25);
  var4 = [];

  foreach(var6 in level.players) {
    if(!var6 scripts\cp\utility::is_valid_player() || !var6 isonground() || var6 isonladder()) {
      continue;
    }

    if(var6.origin[2] > var3[2]) {
      var4 = var6;
    }
  }

  return var4;
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