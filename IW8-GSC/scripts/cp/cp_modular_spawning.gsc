/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_modular_spawning.gsc
***********************************************/

function init_modular_spawning() {
  init_modular_spawning_flags();
  init_spawn_vars_and_pointers();
  setup_aitypes_array();
  thread init_enemy_type_tracking();
  thread init_trigger_spawn_groups();
  level thread scripts\cp\cp_escalation::main();

  if(isDefined(level.ambientgroupinit)) {
    level thread[[level.ambientgroupinit]]();
  }

  modular_spawning_debug_init();
  scripts\cp\cp_wave_spawning::init_wave_spawning();

  if(getdvarint("scr_init_cover_node_spawners", 1)) {
    thread init_spawnpoints_from_cover_nodes();
    return;
  }
}

function init_modular_spawning_flags() {
  scripts\engine\utility::flag_init("pause_wave_progression");
  scripts\engine\utility::flag_init("trigger_modules_initialized");
  scripts\engine\utility::flag_init("spawner_scoring");
  scripts\engine\utility::flag_init("pause_always_on_spawning");
  scripts\engine\utility::flag_init("disable_vehicle_spawning");
  scripts\engine\utility::flag_init("disable_air_vehicle_spawning");
  scripts\engine\utility::flag_init("disable_ground_vehicle_spawning");
  scripts\engine\utility::flag_init("cover_spawners_initialized");
  scripts\engine\utility::flag_init("make_ai_aggro");
}

function init_spawn_vars_and_pointers() {
  level.ignoredbycheck = &isentignoredbyme;
  level.spawn_queue = 0;
  level.active_spawn_modules = [];
  level.module_group_id = 0;
  level.spawnloopupdatefunc = &update_spawn_data_on_death;
  level.enemy_monitor_func = &enemy_monitor;
  level.ref_11ca7 = [];
  level.nearbyposarray = [];
  level.ambientgroups = [];
  level.current_uid = 0;
  level.dynamic_spawn_locations = [];
  level.static_spawn_locations = [];
  level.current_num_spawned_enemies = 0;
  level.current_num_spawned_soldiers = 0;
  level.current_num_spawned_juggernauts = 0;
  level.current_num_spawned_zombies = 0;
  level.total_spawned_enemies = 0;
  level.reserved_spawn_slots = [];
  level.soft_reserved_spawn_slots = 0;
  level.delayed_spawn_slots = 0;
  level.desired_enemy_deaths_this_wave = 0;
  level.current_enemy_deaths = 0;
  level.max_static_spawned_enemies = 0;
  level.max_dynamic_spawners = 0;
  level.lastsoldierspawned = undefined;
  level.spawned_enemies = [];
  level.spawned_allies = [];
  level.spawned_ai = [];
  level.max_enemy_count = 20;
  level.spawned_soldiers = [];
  level.spawned_juggernauts = [];
  level.health_scale = [];
  level.respawn_enemy_list = [];
  level.parentspawnstruct = [];
  level.active_spawn_module_structs = [];
  level.next_heli_spawn = 0;
  level.spawner_script_funcs = [];
  level.requested_spawns_count = 0;
  level.requested_spawns_groups = [];
  level.all_air_vehicle_spawn_points = [];
  level.valid_air_vehicle_spawn_points = [];
  level.ground_vehicle_spawn_points = [];
  level.landing_pos_array = [];
  level.all_spawned_vehicles = [];
  level.cluster_spawners = [];
  level.grouped_modules = [];
  level.requested_spawners = [];
  level.wave_spawner_overrides = [];
  level.spawn_scoring_pois = [];
  level.aitype_override = [];
  level.aitype_override_weights = [];
  level.aitype_override_cumulative_weight = 0;
  level.can_kill_off_list = [];
  level.cover_node_spawners_override = [];
  level.cover_node_spawners_override_id = 0;
  level.spawn_module_structs_memory = [];
  level.hideallunselectedextractpads = [];
  level.show_active_modules = 0;
  level.stack_patch_waittill_leaf = [];
  level.ref_13648 = [];
  level.ref_133bd = 0;
  level.wasexecuted = [];
  scripts\cp\cp_skits::setup_spawn_skits();
  scripts\cp\cp_vehicles::vehicle_ai_spawn_funcs();
  init_passive_wave_struct(level);
}

function setup_aitypes_array() {
  level.aitypes = [];
  level.random_aitype_list = ["ar", "smg", "shotgun"];
  scripts\cp\cp_spawning_util::init_airlock("actor_converted_vehicle_ai");
  var_0 = ["dx_cps_kama_callout_armored_spawning_10", "dx_cps_kama_callout_armored_spawning_20"];
  var_1 = ["dx_cps_kama_callout_drone_thrower_spawning_10", "dx_cps_kama_callout_drone_thrower_spawning_20"];
  var_2 = ["dx_cps_kama_callout_enemy_squad_spawning_10", "dx_cps_kama_callout_enemy_squad_spawning_20", "dx_cps_kama_callout_enemy_squad_spawning_30", "dx_cps_lass_callout_enemy_squad_spawning_10", "dx_cps_lass_callout_enemy_squad_spawning_20", "dx_cps_lass_callout_enemy_squad_spawning_30"];
  var_3 = ["dx_cps_kama_callout_juggernaut_spawning_10", "dx_cps_kama_callout_juggernaut_spawning_20", "dx_cps_lass_callout_juggernaut_spawning_10", "dx_cps_lass_callout_juggernaut_spawning_10"];
  var_4 = ["dx_cps_kama_callout_sniper_spawning_10", "dx_cps_kama_callout_sniper_spawning_20", "dx_cps_kama_callout_sniper_spawning_30", "dx_cps_lass_callout_sniper_spawning_10", "dx_cps_lass_callout_sniper_spawning_20", "dx_cps_lass_callout_sniper_spawning_30"];
  var_5 = ["dx_cps_kama_callout_suicide_bomber_spawning_10", "dx_cps_kama_callout_suicide_bomber_spawning_20", "dx_cps_lass_callout_suicide_bomber_spawning_10", "dx_cbc_aq1_reaction_hostile_burst", "dx_cbc_aq2_reaction_hostile_burst", "dx_cbc_aq3_reaction_hostile_burst", "dx_cbc_aq4_reaction_hostile_burst", "dx_cps_lass_callout_suicide_bomber_spawning_20"];
  register_aitype_setup("juggernaut", "actor_enemy_cp_rus_juggernaut", undefined, &set_juggernaut_flags, undefined, var_3);
  register_aitype_setup("goliath", "actor_enemy_cp_rus_desert_ar_goliath", undefined, &select_patrol_nine_spawners, undefined, var_2);
  register_aitype_setup("goliath_heavy", "actor_enemy_cp_rus_desert_ar_goliath", undefined, &select_patrol_nine_spawners, undefined, var_0);
  register_aitype_setup("goliath_rpg", "actor_enemy_cp_rus_desert_rpg_goliath", undefined, undefined, undefined, var_2);
  register_aitype_setup("smg", "actor_enemy_cp_alq_desert_smg", undefined, &circleorigin, undefined, undefined);
  register_aitype_setup("smg_heavy", "actor_enemy_cp_rus_desert_smg", undefined, &calloutmarkerpingvohandlerpool, undefined, var_0);
  register_aitype_setup("ar", "actor_enemy_cp_alq_desert_ar", undefined, &circleorigin, undefined, var_2);
  register_aitype_setup("ar_heavy", "actor_enemy_cp_rus_desert_ar_ak", undefined, &calloutmarkerpingvohandlerpool, undefined, var_0);
  register_aitype_setup("ar_heavy_laser", "actor_enemy_cp_rus_desert_ar_ak_laser", undefined, &calloutmarkerpingvohandlerpool, undefined, var_0);
  register_aitype_setup("shotgun", "actor_enemy_cp_alq_desert_shotgun", undefined, &circleorigin, undefined, undefined);
  register_aitype_setup("shotgun_heavy", "actor_enemy_cp_rus_desert_shotgun", undefined, &calloutmarkerpingvohandlerpool, undefined, var_0);
  register_aitype_setup("suicidebomber", "actor_enemy_cp_alq_desert_bomber", &suicide_bomber_combat_func, &cp_suicidebomber_init, undefined, var_5);
  register_aitype_setup("suicidebomber_heavy", "actor_enemy_cp_alq_desert_bomber", &suicide_bomber_combat_func, &cp_suicidebomber_init, undefined, var_5);
  register_aitype_setup("rpg", "actor_enemy_cp_alq_desert_rpg", undefined, undefined, undefined, undefined);
  register_aitype_setup("rpg_heavy", "actor_enemy_cp_alq_desert_rpg", undefined, undefined, undefined, undefined);
  register_aitype_setup("riotshield", "actor_enemy_cp_rus_riotshield", undefined, undefined, undefined, var_0);
  register_aitype_setup("riotshield_heavy", "actor_enemy_cp_rus_riotshield", undefined, undefined, undefined, var_0);
  register_aitype_setup("sniper", "actor_enemy_cp_alq_desert_sniper", undefined, undefined, undefined, var_4);
  register_aitype_setup("sniper_heavy", "actor_enemy_cp_alq_desert_sniper", undefined, undefined, undefined, var_0);
  register_aitype_setup("lmg", "actor_enemy_cp_alq_desert_lmg", undefined, undefined, undefined, undefined);
  register_aitype_setup("lmg_heavy", "actor_enemy_cp_rus_desert_lmg", undefined, &calloutmarkerpingvohandlerpool, undefined, var_0);
  register_aitype_setup("soldier_lw", "actor_enemy_lw_base", undefined, &circleorigin, undefined, var_2);
  register_aitype_setup("vehicle_ai", "actor_converted_vehicle_ai", undefined, &circleorigin, undefined, undefined);
  register_aitype_setup("hvt", "actor_enemy_cp_alq_desert_ar_hvt", undefined, undefined, undefined, undefined);
  register_aitype_setup("ally_ar", "actor_ally_cp_usmc_ar", undefined, &circleorigin, undefined, undefined);
  register_aitype_setup("goliath_bomber", "actor_enemy_cp_alq_desert_crowd", &test_combat_func, undefined, undefined, var_0);
  register_aitype_setup("suits", "actor_enemy_cp_rus_desert_ar_goliath_suits", undefined, undefined, undefined, undefined);
  register_aitype_setup("bombvest_hostage", "actor_ally_cp_bombvest_hostage", undefined, &circleorigin, undefined, undefined);
  register_aitype_setup("hadir", "actor_ally_cp_hero_hadir_urban", undefined, &circleorigin, undefined, undefined);
  register_aitype_setup("informant", "actor_enemy_cp_alq_desert_sniper", undefined, &setup_informant, undefined, undefined);
  register_aitype_setup("ar_gasmask", "enemy_cp_rus_desert_ar_gasmask", undefined, &calloutmarkerpingvohandlerpool, undefined, var_2);
  register_aitype_setup("lmg_gasmask", "enemy_cp_rus_desert_lmg_gasmask", undefined, &calloutmarkerpingvohandlerpool, undefined, undefined);
  register_aitype_setup("rpg_gasmask", "enemy_cp_rus_desert_rpg_gasmask", undefined, undefined, undefined, undefined);
  register_aitype_setup("shotgun_gasmask", "enemy_cp_rus_desert_shotgun_gasmask", undefined, &calloutmarkerpingvohandlerpool, undefined, undefined);
  register_aitype_setup("smg_gasmask", "enemy_cp_rus_desert_smg_gasmask", undefined, &calloutmarkerpingvohandlerpool, undefined, undefined);
  register_aitype_setup("sniper_gasmask", "enemy_cp_rus_desert_sniper_gasmask", undefined, undefined, undefined, var_4);
}

function cp_suicidebomber_init() {
  self.bombercanexplodebehindtarget = 1;
  self.bomberusegrenade = 0;
  self.combatmode = "no_cover";
  self.suicidebomberchants = 0;
  thread killcam_timescalefactor();
}

function killcam_timescalefactor() {
  self endon("death");
  waitframe();

  if(istrue(level.creategulagloadoutarry)) {
    self enabletraversals(1, "soldier");
    return;
  }

  self enabletraversals(0, "soldier");
}

function mousetrapsfound() {
  level.creategulagloadoutarry = 1;
}

function set_juggernaut_flags() {
  self.disablegrenaderesponse = 1;
  self.meleechargedistvsplayer = getdvarint("scr_jugg_meleeChargeDistVsPlayer", self.meleechargedistvsplayer);
  self.meleechargedist = getdvarint("scr_jugg_meleeChargeDist", self.meleechargedist);
  self.meleestopattackdistsq = squared(getdvarint("scr_jugg_meleeStopAttackDistSq", sqrt(self.meleestopattackdistsq)));
  self.meleedamageoverride = getdvarint("scr_jugg_meleeDamageOverride", self.meleedamageoverride);
  self.attackeraccuracy = getdvarint("scr_jugg_attackeraccuracy", self.attackeraccuracy);
  self.juggernautwalkdist = getdvarint("scr_jugg_juggernautWalkDist", self.juggernautwalkdist);
  self.minpaindamage = getdvarint("scr_jugg_minPainDamage", self.minpaindamage);
  self.maxhealth = getdvarint("scr_jugg_maxhealth", self.maxhealth);
  self.health = self.maxhealth;
  self.immune_to_melee_damage = 1;
  self.recent_player_attackers = [];
  self allowedstances("stand");
  self setscriptablepartstate("loop_sounds", "music", 1);
  self sethitlocdamagetable("mp_lochit_dmgtable");

  if(getdvarint("scr_jugg_disable_pain", 1)) {
    scripts\engine\utility::disable_pain();
  }

  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    level.players[var_0] setplayermusicstate("cp_juggernaut_intro");
  }

  thread pain_threshold_watcher();
  thread jugg_music();
}

function jugg_music() {
  var_0 = spawn("script_origin", self.origin);
  var_0 linkTo(self);
  wait 0.1;
  var_0 setModel("juggernaut_scriptable");
  scripts\engine\utility::ref_143a6("juggernaut_end", "disconnect", "death");
  var_0 delete();
}

function pain_threshold_watcher() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    var_0 = get_jugg_minpaindamage();
    self waittill("damage", var_1, var_2);
    var_3 = level.players.size;

    if(isDefined(var_2) && var_2 scripts\cp\utility::is_valid_player() && var_3 > 0) {
      self.recent_player_attackers[var_2.name] = 1;
      thread remove_player_from_attacker_list(var_2);
      var_4 = getdvarint("scr_jugg_add_player_mod", 75);
      var_5 = self.recent_player_attackers.size;
      var_6 = int(max(1, var_0 * var_3 / var_5 - (var_5 - 1) * var_4));
      self.minpaindamage = var_6;
    }
  }
}

function remove_player_from_attacker_list(var_0) {
  var_0 notify("remove_player_from_attacker_list");
  var_0 endon("remove_player_from_attacker_list");
  var_0 endon("disconnect");
  self endon("death");
  self.recent_player_attackers[var_0.name] = 1;
  wait getdvarfloat("scr_jugg_pain_window", 0.5);
  self.recent_player_attackers[var_0.name] = undefined;

  if(self.recent_player_attackers.size < 1) {
    self.minpaindamage = get_jugg_minpaindamage();
    return;
  }
}

function get_jugg_minpaindamage() {
  return getdvarint("scr_jugg_minPainDamage", 200);
}

function unset_ai_events() {
  set_dont_enter_combat_flag();
}

function test_combat_func() {
  var_0 = 1;
}

function register_aitype_setup(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6.agent_type = var_1;
  var_6.combat_func = var_2;
  var_6.spawn_func = var_3;
  var_6.info_func = var_4;
  var_6.ref_135f3 = var_5;
  level.wasexecuted[var_0] = -99999;
  level.aitypes[var_0] = var_6;
}

function get_aitype_settings() {
  var_0 = undefined;

  if(isDefined(var_0)) {
    self.post_spawn_ai_funcs[self.post_spawn_ai_funcs.size] = var_0;
    return;
  }
}

function get_aitypes_from_spawner() {
  var_0 = [];

  if(!isDefined(self.script_noteworthy)) {
    return level.random_aitype_list;
  }

  var_1 = strtok(self.script_noteworthy, " ");

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(isDefined(level.aitypes[var_3])) {
      var_0 = var_3;
    }
  }

  if(var_0.size > 0) {
    return var_0;
  }

  return level.random_aitype_list;
}

function init_enemy_type_tracking() {
  level.spawned_enemy_types["soldier"] = 0;
  level.spawned_enemy_types["armored"] = 0;
  level.spawned_enemy_types["armored_helmet"] = 0;
  level.spawned_enemy_types["juggernaut"] = 0;
  level.allowed_enemy_types["soldier"] = 99;
  level.allowed_enemy_types["armored"] = 20;
  level.allowed_enemy_types["armored_helmet"] = 5;
  level.allowed_enemy_types["juggernaut"] = 1;
  level.heavy_chance = 0;
  level.elite_chance = 0;

  if(isDefined(level.enemy_info_table)) {
    init_floor_enemy_info_table();
    update_floor_enemy_info(0);
    return;
  }
}

function init_floor_enemy_info_table(var_0) {
  if(!isDefined(var_0)) {
    var_0 = "cp/cp_lab_enemy_table.csv";
  }

  for(var_1 = 0;; var_1++) {
    var_2 = tablelookupbyrow(var_0, var_1, 0);

    if(var_2 == "") {
      break;
    }

    var_3 = spawnStruct();
    var_3.index = int(var_2);
    var_3.floor_num = int(tablelookup(var_0, 0, var_2, 1));
    var_3.group_name = tablelookup(var_0, 0, var_2, 2);
    var_3.max_in_group = int(tablelookup(var_0, 0, var_2, 3));
    var_3.min_heavy = int(tablelookup(var_0, 0, var_2, 4));
    var_3.max_heavy = int(tablelookup(var_0, 0, var_2, 5));
    var_3.heavy_chance = int(tablelookup(var_0, 0, var_2, 6));
    var_3.allowed_light = tablelookup(var_0, 0, var_2, 7);
    var_3.allowed_heavy = tablelookup(var_0, 0, var_2, 8);
    var_3.min_elite = int(tablelookup(var_0, 0, var_2, 9));
    var_3.max_elite = int(tablelookup(var_0, 0, var_2, 10));
    var_3.elite_chance = int(tablelookup(var_0, 0, var_2, 11));
    var_3.allowed_elite = tablelookup(var_0, 0, var_2, 12);
    var_4 = strtok(var_3.allowed_light, ",");
    var_3.allowed_light = var_4;
    var_4 = strtok(var_3.allowed_heavy, ",");
    var_3.allowed_heavy = var_4;
    var_4 = strtok(var_3.allowed_elite, ",");
    var_3.allowed_elite = var_4;
    level.enemyinfotabledata[var_3.floor_num][var_3.group_name] = var_3;
  }
}

function update_floor_enemy_info(var_0) {
  level.spawned_enemy_types["soldier"] = 0;
  level.spawned_enemy_types["armored"] = 0;
  level.spawned_enemy_types["armored_helmet"] = 0;
  level.spawned_enemy_types["juggernaut"] = 0;
  level.allowed_enemy_types["soldier"] = 0;
  level.allowed_enemy_types["armored"] = 0;
  level.allowed_enemy_types["armored_helmet"] = 0;
  level.allowed_enemy_types["juggernaut"] = 0;
  var_1 = "group_0";
  var_2 = level.enemyinfotabledata[var_0][var_1].allowed_light;
  var_3 = 99;

  foreach(var_5 in var_2) {
    level.allowed_enemy_types[var_5] = var_3;
  }

  level.heavy_chance = level.enemyinfotabledata[var_0][var_1].heavy_chance;

  if(level.heavy_chance > 0) {
    var_2 = level.enemyinfotabledata[var_0][var_1].allowed_heavy;
    var_3 = level.enemyinfotabledata[var_0][var_1].max_heavy;

    foreach(var_5 in var_2) {
      level.allowed_enemy_types[var_5] = var_3;
    }
  }

  level.elite_chance = level.enemyinfotabledata[var_0][var_1].elite_chance;

  if(level.elite_chance > 0) {
    var_2 = level.enemyinfotabledata[var_0][var_1].allowed_elite;
    var_3 = level.enemyinfotabledata[var_0][var_1].max_elite;

    foreach(var_5 in var_2) {
      level.allowed_enemy_types[var_5] = var_3;
    }

    return;
  }
}

function init_trigger_spawn_groups() {
  level endon("game_ended");
  register_trigger_func("run_spawn_module", &trigger_run_spawn_module, &register_triggered_module);
  register_trigger_func("run_spawn_module_looping", &trigger_run_module_once, &register_triggered_looping_module);
  register_trigger_func("run_spawn_module_infinite", &trigger_run_module_once, &register_triggered_infinite_module);
  register_trigger_func("run_spawn_module_timeout_loop", &trigger_run_module_once, &register_triggered_timeout_module);
  register_trigger_func("run_spawn_module_list", &trigger_choose_func_from_list, &register_triggered_timeout_module);
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("introscreen_over");
  scripts\engine\utility::flag_wait("infil_complete");
  scripts\engine\utility::flag_wait("interactions_initialized");
  var_0 = getEntArray("module_update", "targetname");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.target) && isDefined(var_2.script_function)) {
      [[run_triggered_module_registration(var_2.script_function)]](var_2);
      thread run_script_func_when_triggered(var_2);
    }
  }

  scripts\engine\utility::flag_set("trigger_modules_initialized");
}

function run_triggered_module_registration(var_0) {
  if(isDefined(level.trigger_spawn_module_func[var_0])) {
    return level.trigger_spawn_module_func[var_0];
  }

  return &register_triggered_module;
}

function register_triggered_timeout_module(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  var_2 = scripts\engine\utility::ter_op(isDefined(var_0.script_count), int(var_0.script_count), undefined);
  var_3 = scripts\engine\utility::ter_op(isDefined(var_0.script_count_min), int(var_0.script_count_min), 0);
  var_4 = scripts\engine\utility::ter_op(isDefined(var_0.script_count_max), int(var_0.script_count_max), var_1.size);
  registerambientgroup(var_0.target, var_3, var_4, var_2, [ &wait_time_from_active_count, 0.25, 5, 0.8], undefined, var_0.target, undefined, var_0.target, 30);
  set_spawn_scoring_params_for_group(var_0.target, undefined, undefined, var_0.script_maxdist, undefined);
}

function watch_for_players(var_0, var_1, var_2, var_3, var_4) {
  if(scripts\cp\coop_stealth::ref_132d7()) {
    return;
  }

  self endon("death");

  if(isDefined(self.group)) {
    self.group endon("weapons_free");
  }

  var_1 = define_var_if_undefined(var_1, 562500);
  var_2 = define_var_if_undefined(var_2, 45);
  var_4 = define_var_if_undefined(var_4, 2.5);
  var_5 = 0;

  for(;;) {
    self waittill("known_event", var_6);

    if(isDefined(var_6) && isPlayer(var_6)) {
      if(var_6 scripts\cp\utility::is_valid_player() && !istrue(var_6.ignoreme)) {
        if(scripts\engine\trace::can_see_origin(var_6 getEye(), 0)) {
          wait var_4;
          var_7 = distancesquared(self.origin, var_6.origin);

          if(isDefined(var_3)) {
            if(var_7 <= var_3) {
              self.group scripts\engine\utility::ent_flag_set("weapons_free");
              level notify("weapons_checked_in");
            } else if(var_7 <= var_1) {
              if(!var_5) {
                var_5 = 1;
                set_demeanor_from_unittype("alert");
              }
            }
          } else if(var_7 <= var_1) {
            self.group scripts\engine\utility::ent_flag_set("weapons_free");
            level notify("weapons_checked_in");
          }
        }
      }
    }
  }
}

function set_script_count_on_spawns(var_0, var_1, var_2, var_3) {
  var_4 = getarraykeys(level.active_spawn_module_structs);

  for(var_5 = 0; var_5 < level.active_spawn_module_structs.size; var_5++) {
    var_6 = level.active_spawn_module_structs[var_4[var_5]];

    if(isarray(var_6)) {
      for(var_7 = 0; var_7 < var_6.size; var_7++) {
        var_8 = var_6[var_7];

        if(var_8.group_name != var_0) {
          var_9 = process_module_var(var_8, var_8.spawn_points);

          for(var_10 = 0; var_10 < var_9.size; var_10++) {
            var_8.spawn_points[var_10].script_count = 1;
            var_8.spawn_points[var_10].script_timeout = undefined;
          }
        }
      }

      continue;
    }

    if(var_6.group_name != var_0) {
      for(var_10 = 0; var_10 < var_6.spawn_points.size; var_10++) {
        var_6.spawn_points[var_10].script_count = 1;
        var_6.spawn_points[var_10].script_timeout = undefined;
      }
    }
  }
}

function wait_random_time(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1) && isDefined(var_2)) {
    wait randomfloatrange(var_1, var_2);
    return;
  }

  if(isDefined(var_2)) {
    wait var_2;
    return;
  }

  if(isDefined(var_1)) {
    wait var_1;
    return;
  }

  wait 0.25;
}

function wait_time_from_active_count(var_0, var_1, var_2, var_3) {
  var_4 = var_0.activecount;
  var_5 = process_module_var(var_0, var_0.max_size);

  if(var_4 / var_5 >= var_3) {
    return var_2;
  }

  return var_1;
}

function register_triggered_infinite_module(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  registerambientgroup(var_0.target, 0, var_1.size, undefined, 0.25, undefined, var_0.target, undefined, undefined, undefined);
  set_spawn_scoring_params_for_group(var_0.target, undefined, undefined, var_0.script_maxdist, undefined);
}

function register_triggered_looping_module(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  registerambientgroup(var_0.target, 0, var_1.size, var_1.size, 0.25, &wait_for_all_group_dead, var_0.target, undefined, var_0.target, undefined);
  set_spawn_scoring_params_for_group(var_0.target, undefined, undefined, var_0.script_maxdist, undefined);
}

function register_triggered_module(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  registerambientgroup(var_0.target, 0, var_1.size, var_1.size, 0.25, undefined, var_0.target, undefined, undefined, undefined);
  set_spawn_scoring_params_for_group(var_0.target, undefined, undefined, var_0.script_maxdist, undefined);
}

function register_triggered_module_maze_jugg(var_0) {
  var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
  registerambientgroup(var_0.target, 0, var_1.size, var_1.size, 0.25, undefined, var_0.target, undefined, undefined, undefined);
  register_module_ai_spawn_func(var_0.target, &scripts\cp\cp_spawning_util::disable_juggernaut_move_behavior);
  register_module_ai_spawn_func(var_0.target, &scripts\cp\cp_spawning_util::disable_cover_node_behavior);
  register_module_ai_spawn_func(var_0.target, &watch_for_players);
  register_module_weapons_free_func(var_0.target, &scripts\cp\cp_spawning_util::enable_juggernaut_move_behavior);
}

function register_trigger_func(var_0, var_1, var_2) {
  if(!isDefined(level.trigger_spawn_func)) {
    level.trigger_spawn_func = [];
  }

  if(!isDefined(level.trigger_spawn_module_func)) {
    level.trigger_spawn_module_func = [];
  }

  level.trigger_spawn_func[var_0] = var_1;
  level.trigger_spawn_module_func[var_0] = var_2;
}

function run_script_func_when_triggered(var_0) {
  var_0 notify("run_script_func_when_triggered");
  var_0 endon("run_script_func_when_triggered");
  var_0 endon("death");
  level endon("game_ended");
  var_0 scripts\engine\utility::thread_on_notify("disable_trigger", &scripts\engine\utility::trigger_off);

  if(!isDefined(level.trigger_spawn_func)) {
    var_0 notify("disable_trigger");
    return;
  }

  if(!isDefined(level.trigger_spawn_func[var_0.script_function])) {
    var_0 notify("disable_trigger");
    return;
  }

  var_1 = level.trigger_spawn_func[var_0.script_function];

  for(;;) {
    var_0 waittill("trigger", var_2);

    if(isPlayer(var_2)) {
      [[var_1]](var_0, var_2);
    }
  }
}

function isentignoredbyme(var_0, var_1) {
  if(!isagent(var_0)) {
    return 0;
  }

  if(istrue(var_1.ignoreme)) {
    return 1;
  }

  var_2 = var_0 getthreatbiasgroup();
  var_3 = var_1 getthreatbiasgroup();

  if(isDefined(level.ignoremegroups) && isDefined(level.ignoremegroups[var_3])) {
    if(scripts\engine\utility::array_contains(level.ignoremegroups[var_3], var_2)) {
      return 1;
    }

    return 0;
  }

  return 0;
}

function debug_kill_soldier(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 scripts\engine\utility::enable_pain();
  var_0 animmode("normal");
  set_goal_radius(var_0, 32);
  var_0 scripts\asm\shared\mp\utility::bunkercounteruav();
  var_0 notify("alerted");
  var_0 notify("enter_combat");
  var_0.nocorpse = undefined;
  var_0.scripted_mode = 0;
  var_0.entered_combat = 1;

  if(isDefined(var_0.spawnpoint.target)) {
    var_1 = scripts\engine\utility::getStruct(var_0.spawnpoint.target, "targetname");
    set_goal_pos(var_0, var_1.origin);
  }

  var_0 scripts\engine\utility::ref_143a5("goal_reached", "goal");
  wait 2;
  var_0 dodamage(var_0.health + 1000, var_0.origin, var_0, var_0, "MOD_SUICIDE");
}

function spawn_soldier_scripted(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1)) {
    var_4 = var_1;
  } else {
    var_4 = choose_spawnpoint(var_1);
  }

  var_1.respawning = undefined;

  if(!isDefined(var_4)) {
    change_module_status(var_1, undefined, "No Spawner");
    return 0;
  }

  if(istrue(var_1.ref_133be)) {
    return 1;
  }

  return spawn_soldier_scripted_internal(var_1, var_4, 0, undefined, var_3, var_4);
}

function ref_13bac(var_0, var_1) {
  var_1 = define_var_if_undefined(var_1, 1);
  var_0.ref_133be = var_1;
}

function spawn_soldier_scripted_internal(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_3 = undefined;

  if(isDefined(var_1.pos_override_struct)) {
    var_7 = var_1.pos_override_struct.origin;
    var_8 = var_1.pos_override_struct.angles;
  } else if(isDefined(var_1.vehicle_position)) {
    var_7 = var_1.origin;
    var_8 = var_1.angles;
  }

  if(isDefined(var_1.specs)) {
    if(!isarray(var_1.specs)) {
      var_1.specs = [var_1.specs];
    }

    var_3 = scripts\engine\utility::random(var_1.specs);
    var_6 = var_3;
  }

  var_9 = spawn_ai(var_1, var_7, var_8, var_3, var_0);

  if(isDefined(var_9)) {
    if(isDefined(var_0.cargo_truck_mg_init)) {
      if(isDefined(level.players[var_0.cargo_truck_mg_init])) {
        level.players[var_0.cargo_truck_mg_init].cargo_truck_mg_gunnerdamagemodignorefunc++;
        var_9.cargo_truck_mg_initdamage = level.players[var_0.cargo_truck_mg_init];
      }
    }

    change_module_status(var_0, undefined, "Found Agent");
    var_1 notify("spawn_success", var_1);
    level notify("spawned_group_soldier", var_9);
    level notify("ai_spawn_successful", var_9, var_1, var_1.origin, var_0);
    return run_ai_post_spawn_init(var_0, var_9, var_1, var_4, var_6, var_2, var_5);
  }

  change_module_status(var_0, undefined, "No Free Agent");
  var_1 notify("spawn_failed", var_1);
  var_1.aitype = undefined;

  if(istrue(var_5)) {
    return undefined;
  }

  return 0;
}

function run_ai_post_spawn_init(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_1 endon("death");
  set_default_values(var_1, undefined, var_2, var_3, var_0);
  node_fields_pre_goal(var_1, var_2);

  if(isDefined(var_0) && var_0 scripts\cp\cp_spawning_util::module_disables_spawners_until_owner_death()) {
    var_1 thread scripts\cp\cp_spawning_util::disable_spawner_until_owner_death(var_2);
  }

  copy_to_soldier_from_spawn_point(var_2, var_1);
  ref_12ddc(var_1, undefined, var_2, var_3, var_0);
  set_default_spawner_values(var_2);
  var_1 scripts\cp\cp_squadmanager::addtosquad();
  run_spawner_post_spawn_actions(var_2, var_0);
  run_ai_post_spawn_actions(var_1);
  run_aitype_spawn_func(var_1);

  if(isDefined(var_2.specs) && isDefined(var_4)) {
    if(scripts\engine\utility::array_contains(var_2.specs, var_4)) {
      var_2.specs = scripts\engine\utility::array_remove(var_2.specs, var_4);

      if(var_2.specs.size < 1) {
        var_2.specs = undefined;
      }
    }
  }

  var_7 = undefined;

  if(isDefined(var_2.script_animation_type)) {
    if(!isDefined(var_0) || !var_0 scripts\engine\utility::ent_flag("weapons_free")) {
      var_8 = strtok(var_2.script_animation_type, ",");
      var_7 = scripts\engine\utility::random(var_8);
    }
  }

  if(isDefined(var_2.script_function)) {
    if(isDefined(level.spawner_script_funcs[var_2.script_function]) && isDefined(var_2.ai_infil_type)) {
      var_1[[level.spawner_script_funcs[var_2.script_function].script_function]](var_0, var_2, var_2.ai_infil_type);
    }
  } else if(isDefined(var_7) && isDefined(level.spawn_skits[var_7])) {
    thread enter_combat_after_stealth();
    var_1 thread[[level.spawn_skits[var_7].skit_func]]();
  } else if(is_door_spawn(var_1)) {
    if(istrue(var_5)) {
      thread agent_use_door_spawner(var_1, var_2.doors[0], var_1, var_2.doors, var_2.doors[0].origin, var_2.doors[0].angles, &debug_kill_soldier);
    } else {
      thread agent_use_door_spawner(var_1, var_2.doors[0], var_1, var_2.doors, var_2.doors[0].origin, var_2.doors[0].angles, undefined);
    }
  } else {
    scripts\engine\utility::delaythread(5, &unset_used_recently, var_2);

    if(is_patroller(var_1) || is_pacifist(var_1)) {
      if(!isDefined(var_0) || !var_0 scripts\engine\utility::ent_flag("weapons_free")) {
        if(!isDefined(var_2.script_demeanor)) {
          if(is_specified_unittype("civilian")) {
            set_demeanor_from_unittype(var_1, "panic");
          } else if(is_specified_unittype("juggernaut")) {
            if(ref_13655(var_1.spawnpoint, 512)) {
              var_1 scripts\cp\cp_spawning_util::disable_juggernaut_move_behavior(var_0);
            }
          } else if(nullweapon(var_1.primaryweapon)) {
            set_demeanor_from_unittype(var_1, "patrol");
          } else {
            set_demeanor_from_unittype(var_1, "patrol");
          }
        }

        thread start_patrol();
      } else {
        thread enter_combat();
      }
    } else if(isDefined(var_2.target)) {
      thread enter_combat_after_go_to_node();
    } else {
      thread enter_combat();
    }
  }

  var_2.aitype = undefined;

  if(istrue(var_6)) {
    return var_1;
  }

  return 1;
}

function run_aitype_spawn_func() {
  if(isDefined(self.aitype) && isDefined(level.aitypes[self.aitype]) && isDefined(level.aitypes[self.aitype].spawn_func)) {
    self thread[[level.aitypes[self.aitype].spawn_func]]();
  }

  if(ref_132c7()) {
    thread loschecktime(self.aitype);
    return;
  }
}

function ref_132c7() {
  var_0 = istrue(self.pacifist) || istrue(self.ignoreme) || istrue(self.ignoreall) || isDefined(level.global_stealth_broken) && !istrue(level.global_stealth_broken) || istrue(level.announcer_vo_playing) || istrue(level.ref_135f4) || istrue(level.validatealivecount) || istrue(level.ref_139b5);
  return !var_0;
}

function loschecktime(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  if(level.wasexecuted[var_0] + 60000 > gettime()) {
    return;
  }

  if(isDefined(level.aitypes[var_0]) && isDefined(level.aitypes[var_0].ref_135f3)) {
    var_1 = level.aitypes[var_0].ref_135f3;
    level.ref_135f4 = 1;

    if(isarray(var_1)) {
      var_2 = scripts\engine\utility::random(var_1);
      level scripts\cp\cp_vo::try_to_play_vo_on_team(var_2, "allies");
    } else {
      level scripts\cp\cp_vo::try_to_play_vo_on_team(var_1, "allies");
    }

    level.wasexecuted[var_0] = gettime();
    level.ref_135f4 = 0;
    return;
  }
}

function set_demeanor_from_unittype(var_0) {
  var_0 = ref_140c4(var_0);

  if(is_specified_unittype("civilian")) {
    scripts\asm\asm_bb::bb_setcivilianstate(var_0);
    return;
  }

  if(!is_specified_unittype("juggernaut")) {
    scripts\common\utility::demeanor_override(var_0);
    return;
  }
}

function ref_140c4(var_0) {
  switch (var_0) {
    case "casual_gun":
    case "casual":
      return "patrol";
    default:
      return var_0;
  }
}

function give_soldier_armor() {
  if(!issubstr(self.agent_type, "_armor") && !is_juggernaut_aitype()) {}

  self.wearing_armor = 1;
}

function ref_12bf1() {
  self.wearing_armor = undefined;
}

function give_soldier_helmet() {
  if(!issubstr(self.agent_type, "_helmet") && !is_juggernaut_aitype()) {}

  self.wearing_helmet = 1;
}

function set_character_models(var_0, var_1, var_2) {
  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
  }

  if(isDefined(var_0)) {
    self setModel(var_0);
  }

  if(isDefined(var_1)) {
    self attach(var_1, "", 1);
    self.headmodel = var_1;
    return;
  }
}

function watch_for_bad_path() {
  level endon("game_ended");
  self endon("death");
  var_0 = 0;
  var_1 = 0;
  wait 5;

  for(;;) {
    self waittill("bad_path", var_2);

    if(getdvarint("scr_disable_bad_path_cleanup", 0)) {
      break;
    }

    if(!has_never_kill_off_flag()) {
      var_3 = gettime();

      if(var_3 - var_1 > 5000) {
        var_0 = 0;
        var_1 = var_3;
      } else {
        var_0++;
        var_1 = var_3;

        if(var_0 >= 10) {
          if(passed_kill_off_time_checks(gettime())) {
            teleport_to_nearby_spawner("Bad Path", var_2);
          }
        }

        wait 0.5;
      }
    }
  }
}

function watch_for_ai_events() {
  level endon("game_ended");
  self endon("death");
  self endon("enter_combat");
  self notify("watch_for_ai_events");
  self endon("watch_for_ai_events");

  for(;;) {
    self waittill("ai_events", var_0);

    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      var_2 = var_0[var_1];

      if(has_func_for_aievent(var_2.type)) {
        run_aievent_func(var_2.type, var_0);
      }

      switch (var_2.type) {
        case "projectile_impact":
        case "gunshot_teammate":
        case "silenced_shot":
        case "gunshot":
        case "bulletwhizby":
        case "explode":
          var_3 = 1;

          if(scripts\cp\coop_stealth::ref_132d7()) {
            var_3 = !isDefined(self.stealth);
          }

          if(var_3) {
            thread enter_combat();
          }

          break;
        default:
          break;
      }
    }
  }
}

function register_aievent_func_for_group(var_0, var_1, var_2) {
  if(isDefined(level.ambientgroups[var_0]) && isarray(level.ambientgroups[var_0])) {
    for(var_3 = 0; var_3 < level.ambientgroups[var_0].size; var_3++) {
      if(!isDefined(level.ambientgroups[var_0][var_3].aievent_funcs)) {
        level.ambientgroups[var_0][var_3].aievent_funcs = [];
      }

      level.ambientgroups[var_0][var_3].aievent_funcs[var_1] = var_2;
    }

    return;
  }

  if(!isDefined(level.ambientgroups[var_0].aievent_funcs)) {
    level.ambientgroups[var_0].aievent_funcs = [];
  }

  level.ambientgroups[var_0].aievent_funcs[var_1] = var_2;
}

function has_func_for_aievent(var_0) {
  if(isDefined(self.group.aievent_funcs) && isDefined(self.group.aievent_funcs[var_0]) && isbuiltinfunction(self.group.aievent_funcs[var_0])) {
    return 1;
  }

  return 0;
}

function run_aievent_func(var_0, var_1) {
  self thread[[self.group.aievent_funcs[var_0]]](var_0, var_1);
}

function get_nervous(var_0, var_1) {
  if(!isDefined(self.nervousness)) {
    self.nervousness = 0;
  }

  thread increment_and_decay_nervousness();
  var_2 = undefined;

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_4 = var_1[var_3];

    switch (var_4.type) {
      case "footstep_sprint":
        if(self.nervousness >= randomintrange(15, 45)) {
          self.nervousness = undefined;
          thread enter_combat();
          return;
        }

        var_2 = ["You're drawing attention to yourself."];
        break;
      case "player_ads_threat":
        var_2 = ["Watch where you point that thing.", "Rude.", "You're drawing attention to yourself.", "Calm down!"];

        if(self.nervousness >= randomintrange(5, 15)) {
          self.nervousness = undefined;
          thread enter_combat();
          return;
        }

        break;
    }

    if(isDefined(var_2) && isDefined(var_4.entity) && isPlayer(var_4.entity)) {
      thread apply_and_remove_attention_flag();
      give_message_to_player(var_4.entity, scripts\engine\utility::random(var_2));
    }
  }
}

function give_message_to_player(var_0) {
  if(!isDefined(self.next_hint_time) || gettime() > self.next_hint_time) {
    self.next_hint_time = gettime() + randomintrange(3, 5) * 1000;
    self iprintlnbold(var_0);
    return;
  }
}

function apply_and_remove_attention_flag() {
  self notify("apply_and_remove_attention_flag");
  self endon("apply_and_remove_attention_flag");
  self.has_drawn_attention_recently = 1;
  wait 5;
  self.has_drawn_attention_recently = undefined;
}

function increment_and_decay_nervousness() {
  self notify("increment_and_decay_nervousness");
  self endon("increment_and_decay_nervousness");
  self endon("death");
  self endon("enter_combat");
  self.nervousness++;
  wait 5;
  self.nervousness--;
}

function attempt_to_give_info(var_0, var_1) {
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(isDefined(var_3.type) && var_3.type == "footstep_sprint") {
      var_4 = ["You're drawing attention to yourself."];
    } else {
      var_4 = ["He's wearing a mask.", "He has no sleeves on his shirt.", "He's not like us.", "He's wearing boots.", "He's carries a lot of equipment on his waste.", "He may attack soon.", "There may be a group of them.", "There may be a group of them.", "There may be a group of them."];
    }

    if(isDefined(var_3.entity) && isPlayer(var_3.entity)) {
      give_message_to_player(var_3.entity, scripts\engine\utility::random(var_4));
    }
  }
}

function copy_to_soldier_from_spawn_point(var_0, var_1) {
  var_1.spawnpoint = var_0;

  if(!istrue(var_0 scripts\cp\cp_vehicles::is_vehicle_spawnpoint())) {
    var_1.target = var_0.target;
  }

  var_1.script_squadname = var_0.script_squadname;
  var_1.script_stealthgroup = var_0.script_stealthgroup;
  var_1.script_demeanor_post = var_0.script_demeanor_post;
  var_1.script_goalheight = var_0.script_goalheight;
  var_1.script_radius = var_0.script_radius;
  var_1.dontkilloff = var_0.dontkilloff;
  var_1.script_patroller = var_0.script_patroller;
  var_1.equip_helmet = var_0.equip_helmet;
  var_1.is_on_platform = var_0.is_on_platform;
  var_1.door_spawner = var_0.door_spawner;
  var_1.dont_enter_combat = var_0.dont_enter_combat;
  var_1.script_origin_other = var_0.script_origin_other;
  var_1.aitype = var_0.aitype;

  if(isDefined(var_0.script_enemyselector)) {
    var_1.script_enemyselector = var_0.script_enemyselector;
  }

  if(isDefined(var_0.script_goalvolume)) {
    var_1.script_goalvolume = getEnt(var_0.script_goalvolume, "targetname");
    return;
  }
}

function unset_used_recently(var_0) {
  if(isDefined(var_0)) {
    var_0.used_recently = undefined;
    return;
  }
}

function choose_spawnpoint(var_0, var_1, var_2) {
  if(isDefined(var_0.vehicle)) {
    return find_spawn_loc_from_vehicle_spawner(var_0.vehicle.spawn_point, var_0);
  }

  if(istrue(var_1)) {
    var_0.respawning = 1;
  }

  var_3 = process_module_var(var_0, var_0, var_0.spawn_points);
  var_4 = var_0 scripts\cp\cp_spawner_scoring::score_ai_spawns(var_3, var_1, undefined, var_2);
  var_0.ref_127ed = undefined;
  var_0 scripts\cp\cp_spawner_scoring::ref_12891(var_4);

  if(!isDefined(var_4)) {
    return undefined;
  }

  if(istrue(var_4 scripts\cp\cp_vehicles::is_vehicle_spawnpoint())) {
    return find_spawn_loc_from_vehicle_spawner(var_4, var_0);
  } else if(isDefined(var_4.script_reuse_max)) {
    var_4.script_reuse_max = int(var_4.script_reuse_max);

    if(!isDefined(var_4.count)) {
      var_4.count = 1;
    } else {
      var_4.count = int(var_4.count);
      var_4.count++;
    }

    if(var_4.count >= var_4.script_reuse_max) {
      var_4.used_recently = 1;
      thread reset_spawn_vars(var_4);
    }
  } else {
    var_4.used_recently = 1;
  }

  return var_4;
}

function find_spawn_loc_from_vehicle_spawner(var_0) {
  if(!isDefined(self.vehicle)) {
    if(!spawn_vehicle_at_vehicle_spawner(var_0)) {
      return undefined;
    }
  }

  if(isDefined(self.vehicle) && self.vehicle scripts\common\vehicle_aianim::vehicle_hasavailablespots()) {
    level notify("vehicle_spawned", var_0, self.vehicle);
    var_0 notify("vehicle_spawned", var_0, self.vehicle);

    if(isDefined(self.veh_spawn_point) && isDefined(self.veh_spawn_point.script_vehiclegroup)) {
      return get_near_vehicle_spawner();
    }

    self.pos_override_struct = self.vehicle;
    return self;
  }

  return undefined;
}

function get_near_vehicle_spawner() {
  var_0 = scripts\engine\utility::getStructArray(self.veh_spawn_point.script_vehiclegroup, "targetname");

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(var_0[var_1] == self.veh_spawn_point) {
      continue;
    }

    if(!istrue(var_0[var_1].disabled)) {
      self.pos_override_struct = var_0[var_1];
      var_0[var_1].disabled = 1;
      return self;
    }
  }

  return undefined;
}

function spawn_vehicle_at_vehicle_spawner(var_0) {
  if(!isDefined(self.script_function)) {
    return 0;
  }

  if(has_vehicle_type_exceeded_module_cap(var_0, self.script_function)) {
    return 0;
  }

  if([[level.ai_spawn_vehicle_func[self.script_function].vehicle_spawn_func]](var_0, self, self.script_function)) {
    if(isDefined(var_0.vehicle)) {
      ref_14206(var_0.vehicle, var_0.vehicle);
      thread ref_14187(var_0.vehicle);
    }

    return 1;
  }

  return 0;
}

function ref_14206(var_0) {
  level.ref_11ca7[var_0 getentitynumber()] = var_0;
}

function ref_14187(var_0) {
  level endon("game_ended");
  var_1 = var_0 getentitynumber();
  var_0 waittill("death");

  if(isDefined(var_0.vehiclename)) {
    scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(var_0);
  }

  level.ref_11ca7[var_1] = undefined;
}

function set_last_spawn_time() {}

function get_last_spawn_time() {}

function disable_spawn_point(var_0, var_1, var_2) {
  if(isDefined(var_1) && var_1 > 0) {
    little_bird_mg_givetakegunnerturrettimeout(var_0);

    if(isDefined(var_2)) {
      var_2.longer_spawn_delay = 1;
    }

    wait var_1;

    if(isDefined(var_2)) {
      var_2.longer_spawn_delay = 0;
    }

    mounted(var_0);
    return;
  }

  little_bird_mg_givetakegunnerturrettimeout(var_0);
}

function spawn_is_vehicle_spawn(var_0) {
  if(!isnode(var_0) && isDefined(var_0.spawnflags)) {
    var_1 = int(var_0.spawnflags);
    var_2 = 16;
    var_3 = 8;
    var_4 = 512;

    if(var_1 &var_2) {
      define_spawner(var_0, "vehicle_spawner");
      remove_from_spawner_flags(var_0, 8);
      add_to_spawner_flags(var_0, 16);

      if(!isDefined(var_0.script_function)) {
        var_0.script_function = "random_ground_vehicle_spawn";
      }
    }

    if(var_1 &var_3) {
      define_spawner(var_0, "vehicle_spawner");
      add_to_spawner_flags(var_0, 8);
      remove_from_spawner_flags(var_0, 16);
      var_0.script_goalyaw = 1;

      if(!isDefined(var_0.script_function)) {
        var_0.script_function = "random_air_vehicle_spawn";
      }

      level.valid_air_vehicle_spawn_points[level.valid_air_vehicle_spawn_points.size] = var_0;
      level.all_air_vehicle_spawn_points[level.all_air_vehicle_spawn_points.size] = var_0;

      if(!(var_1 & 32)) {
        var_0.heli_path_func = &scripts\cp\cp_vehicles::create_heli_path;
      }
    }

    if((spawner_flags_check(var_0, 16) || spawner_flags_check(var_0, 8)) && var_1 &var_4) {
      var_0.veh_model_spawner = 1;
      var_0.dontgetonpath = 1;
    }

    if(var_1 &var_3 || var_1 &var_2) {
      return 1;
    }

    return undefined;
  }

  return undefined;
}

function barkov_execution_path(var_0) {
  if(isDefined(self.spawnflags)) {
    if(!ref_13655(var_0)) {
      self.spawnflags += var_0;
      return;
    }

    return;
  }

  self.spawnflags = var_0;
}

function ref_12bd2(var_0) {
  if(isDefined(self.spawnflags) && self.spawnflags &var_0) {
    self.spawnflags -= var_0;
    return;
  }
}

function define_spawner(var_0) {
  switch (var_0) {
    case "cluster_spawner":
      define_as_cluster_spawner();
      break;
    case "vehicle_spawner":
      define_as_vehicle_spawner();
      break;
  }
}

function ref_13655(var_0) {
  return isDefined(self.spawnflags) && self.spawnflags &var_0;
}

function spawner_flags_check(var_0) {
  return isDefined(self.spawner_flags) && self.spawner_flags &var_0;
}

function add_to_spawner_flags(var_0) {
  if(isDefined(self.spawner_flags)) {
    if(!spawner_flags_check(var_0)) {
      self.spawner_flags += var_0;
      return;
    }

    return;
  }

  self.spawner_flags = var_0;
}

function remove_from_spawner_flags(var_0) {
  if(isDefined(self.spawner_flags) && self.spawner_flags &var_0) {
    self.spawner_flags -= var_0;
    return;
  }
}

function ref_12bc9() {
  if(isDefined(self.spawnpoint) && isstruct(self.spawnpoint)) {
    if(isDefined(self.spawnpoint.spawnflags) && self.spawnpoint.spawnflags & 1024) {
      self.spawnpoint.spawnflags -= 1024;
      return;
    }

    return;
  }
}

function define_as_cluster_spawner() {
  if(isDefined(self.spawner_flags)) {
    if(!spawner_flags_check(4)) {
      self.spawner_flags += 4;
      return;
    }

    return;
  }

  self.spawner_flags = 4;
}

function define_as_vehicle_spawner() {
  if(isDefined(self.spawner_flags)) {
    if(!spawner_flags_check(2)) {
      self.spawner_flags += 2;
      return;
    }

    return;
  }

  self.spawner_flags = 2;
}

function reset_spawn_vars(var_0) {}

function returnzeroifundefined(var_0) {
  if(isDefined(var_0)) {
    return var_0;
  }

  return 0;
}

function returnblankfuncifundefined(var_0) {
  if(isDefined(var_0)) {
    return var_0;
  }

  return &blankmodulefunc;
}

function blankmodulefunc(var_0, var_1, var_2, var_3, var_4, var_5) {}

function registerambientgroup(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = spawnStruct();
  var_11 = strtok(var_0, "/");

  if(var_11.size > 1) {
    var_10.group_name = var_11[1];
  } else {
    var_10.group_name = var_0;
  }

  var_10.min_size = returnzeroifundefined(var_1);
  var_10.max_size = returnzeroifundefined(var_2);
  var_10.time_between_spawns = returnzeroifundefined(var_4);
  var_10.post_module_delay = returnzeroifundefined(var_5);
  var_10.activecount = 0;
  var_10.spawn_count = 0;
  var_10.ai_spawned = [];
  var_10.module_vehicles = [];
  var_10.ref_11cb0 = 0;
  var_10.ref_13be5 = 0;
  var_10.cqb_module = 0;
  var_10.debug_struct = create_module_debug_struct(var_10);

  if(isDefined(var_6)) {
    if(isbuiltinfunction(var_6)) {
      var_10.spawn_points = var_6;
    } else if(isarray(var_6)) {
      foreach(var_13 in var_6) {
        var_10.spawn_points = scripts\engine\utility::array_combine(var_10.spawn_points, scripts\engine\utility::getStructArray(var_13, "targetname"));
      }

      for(var_15 = 0; var_15 < var_10.spawn_points.size; var_15++) {
        var_16 = var_10.spawn_points[var_15];
        thread spawner_init();
      }

      var_10.spawn_points = [ &return_spawners_by_targetname, var_6];
    } else {
      var_11.spawn_points = scripts\engine\utility::getStructArray(var_7, "targetname");

      foreach(var_16 in var_11.spawn_points) {
        thread spawner_init();
      }
    }
  }

  var_11.totalspawns = returnzeroifundefined(var_4);
  var_11.start_func = returnblankfuncifundefined(var_8);
  var_11.nextgroup = var_9;
  var_11.timeout_action = var_10;
  var_11.currentmodulekills = 0;
  var_11.currentmoduledeaths = 0;
  var_11.set_chosen_spawner_from_uid = ["frag_grenade_mp", "molotov_mp", "semtex_mp", "flash_grenade_mp", "concussion_grenade_mp", "smoke_grenade_mp", "gas_mp"];
  var_11.serverroomrewardroll = [0.5, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1];

  if(isDefined(level.ambientgroups[var_11.group_name])) {
    if(isarray(level.ambientgroups[var_11.group_name])) {
      var_19 = [];

      foreach(var_21 in level.ambientgroups[var_11.group_name]) {
        var_19 = scripts\engine\utility::array_add(var_19, var_21);
      }

      var_19 = scripts\engine\utility::array_add(var_19, var_11);
      level.ambientgroups[var_11.group_name] = var_19;
    } else {
      var_23 = level.ambientgroups[var_11.group_name];
      level.ambientgroups[var_11.group_name] = [var_11, var_23];
    }

    var_11.moduleid = level.module_group_id;
    level.module_group_id++;
  } else {
    var_11.moduleid = level.module_group_id;
    level.module_group_id++;
    level.ambientgroups[var_11.group_name] = var_11;
  }

  var_24 = ":0/" + var_1 + ":" + level.ambientgroups.size;
  var_25 = "devgui_cmd \"CP Debug:2 / CP Module Spawning:3 / Start Module" + var_24 + "\" \"set scr_debug_spawning spawn_module_change &" + var_11.group_name + "\" \n";
  scripts\cp\utility::addentrytodevgui(var_25);
  var_25 = "devgui_cmd \"CP Debug:2 / CP Module Spawning:3 / Stop Module" + var_24 + "\" \"set scr_debug_spawning stop_module_change &" + var_11.group_name + "\" \n";
  scripts\cp\utility::addentrytodevgui(var_25);
}

function return_spawners_by_targetname(var_0, var_1) {
  if(!isarray(var_1)) {
    var_1 = [var_1];
  } else {
    var_2 = [];

    for(var_3 = 0; var_3 < var_1.size; var_3++) {
      var_2 = var_1[var_3];
    }

    var_1 = var_2;
  }

  var_4 = [];

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_4 = scripts\engine\utility::array_combine(var_4, scripts\engine\utility::getStructArray(var_1[var_3], "targetname"));
  }

  return var_4;
}

function delay_start_specified_module() {
  if(getDvar("scr_module_spawning", "") != "") {
    scripts\engine\utility::flag_wait("strike_init_done");
    scripts\engine\utility::flag_wait("introscreen_over");
    scripts\engine\utility::flag_wait("infil_complete");
    scripts\engine\utility::flag_wait("interactions_initialized");
    wait 2;
    var_0 = run_spawn_module(getDvar("scr_module_spawning", ""));
    return;
  }
}

function delay_start_cover_node_spawning() {
  if(getdvarint("scr_cover_node_spawning", 0)) {
    scripts\engine\utility::flag_wait("strike_init_done");
    scripts\engine\utility::flag_wait("introscreen_over");
    scripts\engine\utility::flag_wait("infil_complete");
    scripts\engine\utility::flag_wait("interactions_initialized");
    wait 2;
    var_0 = run_spawn_module("cover_node_spawning");
    run_func_on_group_by_groupname("cover_node_spawning", [ &override_spawn_scoring_for_module_struct, undefined, undefined, 10000, undefined]);
    run_func_on_group_by_groupname("cover_node_spawning", [ &toggle_always_attempt_killoff, 1]);
    return;
  }
}

function delay_start_wave_spawning() {
  if(getdvarint("scr_wave_spawning", 0)) {
    scripts\engine\utility::flag_wait("strike_init_done");
    scripts\engine\utility::flag_wait("introscreen_over");
    scripts\engine\utility::flag_wait("infil_complete");
    scripts\engine\utility::flag_wait("interactions_initialized");
    wait 2;
    var_0 = run_spawn_module("wave_spawning");
    return;
  }
}

function init_spawnpoints_from_cover_nodes() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("strike_init_done");
  scripts\engine\utility::flag_wait("introscreen_over");
  scripts\engine\utility::flag_wait("infil_complete");
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\cp\coop_stealth::coop_stealth_init();
  registerambientgroup("no_group_ai", 0, &get_max_agent_count, undefined, 0.05, undefined, undefined, undefined, undefined, undefined);
  registerambientgroup("pre_wave_spawning_dwn_twn", 0, 24, undefined, 0.1, undefined, "dwn_twn_patrol_structs", undefined, undefined);
  set_spawn_scoring_params_for_group("pre_wave_spawning_dwn_twn", 1250, 2000, 5000, 1);
  register_module_ai_spawn_func("pre_wave_spawning_dwn_twn", &set_pre_wave_spawning_spawn_funcs);
  register_module_weapons_free_func("pre_wave_spawning_dwn_twn", &pre_wave_weapons_free);
  registerambientgroup("pre_wave_spawning", 0, 24, undefined, 0.1, &unset_pre_wave_spawning, &return_cover_spawners, &init_pre_wave_spawning, "wave_spawning");
  set_spawn_scoring_params_for_group("pre_wave_spawning", 750, 2000, 5000, 1);
  register_module_ai_spawn_func("pre_wave_spawning", &set_pre_wave_spawning_spawn_funcs);
  registerambientgroup("cover_node_spawning", [ &get_ambient_min_count, 0], [ &get_ambient_max_count, 24], undefined, &module_wave_spawn, undefined, &return_cover_spawners, &wait_for_spawners_created);
  register_module_as_passive("cover_node_spawning");
  set_spawn_scoring_params_for_group("cover_node_spawning", 750, 2000, 5000, 1);
  thread delay_start_cover_node_spawning();
  thread delay_start_wave_spawning();
  var_0 = scripts\engine\utility::getStructArray("cover_node_parents", "targetname");
  var_1 = get_all_nodes();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_1[var_2].script_index = undefined;
    var_3 = isDefined(var_1[var_2].spawnflags) && var_1[var_2].spawnflags & 16384;
    var_4 = var_1[var_2].type == "Error";

    if(var_4 || var_3) {
      var_1[var_2] disconnectnode();
    }
  }

  if(var_0.size < 1) {
    var_5 = 0;
    var_6 = [];
    var_7 = 0;

    for(;;) {
      var_5++;
      var_8 = var_1[0];
      var_9 = [];
      var_6 = var_8;

      if(var_1.size > 1) {
        for(var_10 = 0; var_10 < var_1.size; var_10++) {
          var_11 = var_1[var_10];
          var_11.script_index = undefined;
          var_9 = var_11;
          LOC_00000231:
        }

        var_1 = var_9;
        var_6 = var_9;
        break;
      }

      break;
    }

    var_1 = undefined;
    var_0 = split_array_into_quadrants(var_6);
    var_6 = undefined;
  }

  for(var_10 = 0; var_10 < var_0.size; var_10++) {
    define_spawner(var_0[var_10], "cluster_spawner");
    thread spawner_init();
    init_cluster_parent(var_0[var_10]);
    var_0[var_10].child_spawners = undefined;
  }

  level.cover_node_spawners = var_0;
  scripts\engine\utility::flag_set("cover_spawners_initialized");
}

function get_all_nodes() {
  return getallnodes();
}

function attempt_throttle(var_0) {
  var_0++;

  if(var_0 % 2000 == 0) {
    waitframe();
  }

  return var_0;
}

function return_cover_spawners(var_0) {
  if(istrue(var_0.use_only_veh_spawners)) {
    return [];
  }

  if(isDefined(var_0.cover_node_spawners_override) && var_0.cover_node_spawners_override.size > 0) {
    var_1 = [];
    var_2 = getarraykeys(var_0.cover_node_spawners_override);

    for(var_3 = 0; var_3 < var_0.cover_node_spawners_override.size; var_3++) {
      var_1 = scripts\engine\utility::array_combine(var_1, var_0.cover_node_spawners_override[var_2[var_3]]);
    }

    if(var_1.size > 0) {
      return var_1;
    }
  } else if(isDefined(var_0.wave_spawner_overrides) && var_0.wave_spawner_overrides.size > 0) {
    var_1 = [];

    for(var_3 = 0; var_3 < var_0.wave_spawner_overrides.size; var_3++) {
      var_4 = scripts\engine\utility::getStructArray(var_0.wave_spawner_overrides[var_3], "targetname");
      var_1 = scripts\engine\utility::array_combine(var_1, var_4);
    }

    if(var_1.size > 0) {
      return var_1;
    }
  } else if(isDefined(var_0.requested_spawners) && var_0.requested_spawners.size > 0) {
    var_1 = [];

    for(var_3 = 0; var_3 < var_0.requested_spawners.size; var_3++) {
      var_4 = scripts\engine\utility::getStructArray(var_0.requested_spawners[var_3], "targetname");
      var_1 = scripts\engine\utility::array_combine(var_1, var_4);
    }

    if(var_1.size > 0) {
      if(isDefined(level.cover_node_spawners)) {
        return scripts\engine\utility::array_combine(level.cover_node_spawners, var_1);
      } else {
        return var_1;
      }
    } else if(isDefined(level.cover_node_spawners)) {
      return level.cover_node_spawners;
    } else {
      return [];
    }
  }

  if(isDefined(level.cover_node_spawners)) {
    return level.cover_node_spawners;
  }

  return [];
}

function use_cover_node_spawners_around_pos(var_0) {
  scripts\engine\utility::flag_wait("cover_spawners_initialized");

  if(isDefined(self.cover_node_spawners)) {
    var_1 = scripts\engine\utility::get_array_of_closest(var_0, self.cover_node_spawners, undefined, 5, undefined, undefined);
    self.cover_node_spawners_override[self.cover_node_spawners_override_id] = var_1;
    var_2 = self.cover_node_spawners_override_id;
    self.cover_node_spawners_override_id++;
    return var_2;
  }

  return undefined;
}

function remove_cover_node_spawners_around_pos_with_id(var_0) {
  if(isDefined(self.cover_node_spawners_override[var_0])) {
    self.cover_node_spawners_override[var_0] = undefined;
    return;
  }
}

function init_wave_settings(var_0) {
  var_0.wave_reference = 1;
}

function init_pre_wave_spawning(var_0) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("cover_spawners_initialized");
  add_global_spawn_function("axis", &stay_passive_if_not_weapons_free);
  add_global_spawn_function("axis", &set_aggro_flag_on_enter_combat);
  add_global_spawn_function("axis", &watch_for_players, undefined, 1000000, 45);
}

function unset_pre_wave_spawning(var_0) {
  remove_global_spawn_function("axis", &stay_passive_if_not_weapons_free);
  remove_global_spawn_function("axis", &set_aggro_flag_on_enter_combat);
  remove_global_spawn_function("axis", &watch_for_players);
}

function setup_wave_vars(var_0) {
  var_0.spawn_aitype_counts = [];
}

function wait_for_spawners_created(var_0) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("cover_spawners_initialized");
}

function split_array_into_quadrants(var_0) {
  if(isDefined(var_0) && var_0.size < 1) {
    return [];
  }

  var_1 = scripts\cp\utility::get_center_point_of_array(var_0);
  var_2 = spawnStruct();
  var_2.origin = var_1;
  var_2.angles = (0, 0, 0);
  var_3 = [];
  var_4 = [];
  var_5 = [];
  var_6 = [];
  var_7 = [];
  var_8 = [];
  var_9 = [];
  var_10 = [];
  var_11 = [];
  var_12 = [];

  for(var_13 = 0; var_13 < var_0.size; var_13++) {
    var_14 = var_0[var_13];
    var_15 = var_2 scripts\cp\cp_spawning_util::increase_wave_ai_killed_counter(var_14.origin);
    var_16 = var_2 scripts\cp\cp_spawning_util::increase_wave_ai_spawned_counter(var_14.origin);

    if(var_15 && var_16) {
      var_3 = var_14;
      continue;
    }

    if(!var_15 && !var_16) {
      var_6 = var_14;
      continue;
    }

    if(!var_15 && var_16) {
      var_5 = var_14;
      continue;
    }

    if(var_15 && !var_16) {
      var_4 = var_14;
    }
  }

  if(isDefined(var_3)) {
    if(var_3.size > 64) {
      var_9 = split_array_into_quadrants(var_3);

      for(var_13 = 0; var_13 < var_9.size; var_13++) {
        var_17 = var_9[var_13];

        if(isDefined(var_17.child_spawners) && var_17.child_spawners.size > 0) {
          var_17.origin = scripts\cp\utility::get_center_point_of_array(var_17.child_spawners);
          var_17.angles = (0, 0, 0);
          var_7 = var_17;
        }
      }
    } else {
      var_17 = spawnStruct();
      var_17.child_spawners = var_4;

      if(isDefined(var_17.child_spawners) && var_17.child_spawners.size > 0) {
        var_17.origin = scripts\cp\utility::get_center_point_of_array(var_17.child_spawners);
        var_17.angles = (0, 0, 0);
        var_8 = var_17;
      }
    }
  }

  if(isDefined(var_5)) {
    if(var_5.size > 64) {
      var_11 = split_array_into_quadrants(var_5);

      for(var_14 = 0; var_14 < var_11.size; var_14++) {
        var_17 = var_11[var_14];

        if(isDefined(var_17.child_spawners) && var_17.child_spawners.size > 0) {
          var_17.origin = scripts\cp\utility::get_center_point_of_array(var_17.child_spawners);
          var_17.angles = (0, 0, 0);
          var_8 = var_17;
        }
      }
    } else {
      var_17 = spawnStruct();
      var_17.child_spawners = var_6;

      if(isDefined(var_17.child_spawners) && var_17.child_spawners.size > 0) {
        var_17.origin = scripts\cp\utility::get_center_point_of_array(var_17.child_spawners);
        var_17.angles = (0, 0, 0);
        var_9 = var_17;
      }
    }
  }

  if(isDefined(var_7)) {
    if(var_7.size > 64) {
      var_13 = split_array_into_quadrants(var_7);

      for(var_15 = 0; var_15 < var_13.size; var_15++) {
        var_17 = var_13[var_15];

        if(isDefined(var_17.child_spawners) && var_17.child_spawners.size > 0) {
          var_17.origin = scripts\cp\utility::get_center_point_of_array(var_17.child_spawners);
          var_17.angles = (0, 0, 0);
          var_9 = var_17;
        }
      }
    } else {
      var_17 = spawnStruct();
      var_17.child_spawners = var_8;

      if(isDefined(var_17.child_spawners) && var_17.child_spawners.size > 0) {
        var_17.origin = scripts\cp\utility::get_center_point_of_array(var_17.child_spawners);
        var_17.angles = (0, 0, 0);
        var_10 = var_17;
      }
    }
  }

  if(isDefined(var_9)) {
    if(var_9.size > 64) {
      var_15 = split_array_into_quadrants(var_9);

      for(var_16 = 0; var_16 < var_15.size; var_16++) {
        var_17 = var_15[var_16];

        if(isDefined(var_17.child_spawners) && var_17.child_spawners.size > 0) {
          var_17.origin = scripts\cp\utility::get_center_point_of_array(var_17.child_spawners);
          var_17.angles = (0, 0, 0);
          var_10 = var_17;
        }
      }
    } else {
      var_17 = spawnStruct();
      var_17.child_spawners = var_10;

      if(isDefined(var_17.child_spawners) && var_17.child_spawners.size > 0) {
        var_17.origin = scripts\cp\utility::get_center_point_of_array(var_17.child_spawners);
        var_17.angles = (0, 0, 0);
        var_11 = var_17;
      }
    }
  }

  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;
  var_12 = undefined;
  var_13 = undefined;
  var_14 = undefined;
  var_15 = undefined;
  var_16 = undefined;
  return var_11;
}

function assign_spawnpoints_to_parent_structs(var_0) {
  var_1 = scripts\cp\utility::get_center_point_of_array(var_0);

  for(var_2 = 0; var_2 < var_0.size; var_2++) {}
}

function register_module_as_passive(var_0) {
  if(isDefined(level.ambientgroups[var_0])) {
    if(isarray(level.ambientgroups[var_0])) {
      for(var_1 = 0; var_1 < level.ambientgroups[var_0].size; var_1++) {
        level.ambientgroups[var_0][var_1].is_passive = 1;
      }

      return;
    }

    level.ambientgroups[var_0].is_passive = 1;
    return;
  }
}

function register_module_ai_spawn_func(var_0, var_1) {
  if(isDefined(level.ambientgroups[var_0])) {
    if(isarray(level.ambientgroups[var_0])) {
      for(var_2 = 0; var_2 < level.ambientgroups[var_0].size; var_2++) {
        if(!isDefined(level.ambientgroups[var_0][var_2].ai_spawn_func)) {
          level.ambientgroups[var_0][var_2].ai_spawn_func = [];
        }

        level.ambientgroups[var_0][var_2].ai_spawn_func[level.ambientgroups[var_0][var_2].ai_spawn_func.size] = var_1;
      }

      return;
    }

    if(!isDefined(level.ambientgroups[var_0].ai_spawn_func)) {
      level.ambientgroups[var_0].ai_spawn_func = [];
    }

    level.ambientgroups[var_0].ai_spawn_func[level.ambientgroups[var_0].ai_spawn_func.size] = var_1;
    return;
  }
}

function awardbunker11blueprint(var_0, var_1) {
  if(isDefined(level.active_spawn_module_structs[var_0])) {
    if(isarray(level.active_spawn_module_structs[var_0])) {
      for(var_2 = 0; var_2 < level.active_spawn_module_structs[var_0].size; var_2++) {
        if(!isDefined(level.active_spawn_module_structs[var_0][var_2].ai_spawn_func)) {
          level.active_spawn_module_structs[var_0][var_2].ai_spawn_func = [];
        }

        level.active_spawn_module_structs[var_0][var_2].ai_spawn_func[level.active_spawn_module_structs[var_0][var_2].ai_spawn_func.size] = var_1;
      }

      return;
    }

    if(!isDefined(level.active_spawn_module_structs[var_0].ai_spawn_func)) {
      level.active_spawn_module_structs[var_0].ai_spawn_func = [];
    }

    level.active_spawn_module_structs[var_0].ai_spawn_func[level.active_spawn_module_structs[var_0].ai_spawn_func.size] = var_1;
    return;
  }
}

function apply_func_to_all_in_group(var_0, var_1) {
  if(isDefined(level.active_spawn_module_structs[var_0])) {
    var_2 = level.active_spawn_module_structs[var_0];

    if(isarray(var_2)) {
      for(var_3 = 0; var_3 < var_2.size; var_3++) {
        var_4 = var_2[var_3];

        for(var_5 = 0; var_5 < var_4.ai_spawned.size; var_5++) {
          var_4.ai_spawned[var_5] thread[[var_1]]();
        }
      }

      return;
    }

    return;
  }
}

function register_module_weapons_free_func(var_0, var_1) {
  if(isDefined(level.ambientgroups[var_0])) {
    if(isarray(level.ambientgroups[var_0])) {
      for(var_2 = 0; var_2 < level.ambientgroups[var_0].size; var_2++) {
        if(!isDefined(level.ambientgroups[var_0][var_2].fn_weapons_free)) {
          level.ambientgroups[var_0][var_2].fn_weapons_free = [];
        }

        level.ambientgroups[var_0][var_2].fn_weapons_free[level.ambientgroups[var_0][var_2].fn_weapons_free.size] = var_1;
      }

      return;
    }

    if(!isDefined(level.ambientgroups[var_0].fn_weapons_free)) {
      level.ambientgroups[var_0].fn_weapons_free = [];
    }

    level.ambientgroups[var_0].fn_weapons_free[level.ambientgroups[var_0].fn_weapons_free.size] = var_1;
    return;
  }
}

function register_module_ai_death_func(var_0, var_1) {
  if(isDefined(level.ambientgroups[var_0])) {
    if(isarray(level.ambientgroups[var_0])) {
      for(var_2 = 0; var_2 < level.ambientgroups[var_0].size; var_2++) {
        if(!isDefined(level.ambientgroups[var_0][var_2].ai_death_func)) {
          level.ambientgroups[var_0][var_2].ai_death_func = [];
        }

        level.ambientgroups[var_0][var_2].ai_death_func[level.ambientgroups[var_0][var_2].ai_death_func.size] = var_1;
      }

      return;
    }

    if(!isDefined(level.ambientgroups[var_0].ai_death_func)) {
      level.ambientgroups[var_0].ai_death_func = [];
    }

    level.ambientgroups[var_0].ai_death_func[level.ambientgroups[var_0].ai_death_func.size] = var_1;
    return;
  }
}

function register_module_run_func_after_notify(var_0, var_1, var_2) {
  if(isDefined(level.ambientgroups[var_0])) {
    if(isarray(level.ambientgroups[var_0])) {
      for(var_3 = 0; var_3 < level.ambientgroups[var_0].size; var_3++) {
        if(!isDefined(level.ambientgroups[var_0][var_3].funcs_after_notifies)) {
          level.ambientgroups[var_0][var_3].funcs_after_notifies = [];
        }

        level.ambientgroups[var_0][var_3].funcs_after_notifies[var_1] = var_2;
      }

      return;
    }

    if(!isDefined(level.ambientgroups[var_0].funcs_after_notifies)) {
      level.ambientgroups[var_0].funcs_after_notifies = [];
    }

    level.ambientgroups[var_0].funcs_after_notifies[var_1] = var_2;
    return;
  }
}

function module_run_func_after_notify() {
  if(isDefined(self.funcs_after_notifies)) {
    self endon("all_group_spawns_dead");
    var_0 = getarraykeys(self.funcs_after_notifies);

    for(;;) {
      var_1 = level scripts\engine\utility::waittill_any_in_array_return(var_0);
      self thread[[self.funcs_after_notifies[var_1]]]();
    }

    return;
  }
}

function set_kill_off_vars(var_0, var_1, var_2) {
  var_0.kill_off_time_override = var_1;
  var_0.last_seen_time_override = var_2;
}

function toggle_always_attempt_killoff(var_0, var_1) {}

function module_always_attempt_killoff(var_0) {
  if(isDefined(level.ambientgroups[var_0])) {
    if(isarray(level.ambientgroups[var_0])) {
      for(var_1 = 0; var_1 < level.ambientgroups[var_0].size; var_1++) {
        level.ambientgroups[var_0][var_1].always_attempt_killoff = 1;
      }

      return;
    }

    level.ambientgroups[var_0].always_attempt_killoff = 1;
    return;
  }
}

function force_module_cqb_scoring(var_0) {
  if(isDefined(level.ambientgroups[var_0])) {
    if(isarray(level.ambientgroups[var_0])) {
      for(var_1 = 0; var_1 < level.ambientgroups[var_0].size; var_1++) {
        level.ambientgroups[var_0][var_1].cqb_module = 1;
      }

      return;
    }

    level.ambientgroups[var_0].cqb_module = 1;
    return;
  }
}

function override_spawn_scoring_for_module_struct(var_0, var_1, var_2, var_3, var_4) {
  create_spawn_scoring_struct(var_0, var_1, var_2, var_3, var_4);
}

function ref_130e7(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_4)) {
    var_5 = level.gametype;
    var_6 = strtok(var_4, " ");

    for(var_7 = 0; var_7 < var_6.size; var_7++) {
      if(var_6[var_7] == var_5) {
        break;
      }
    }

    return;
  }

  level.spawn_scoring_overrides = create_spawn_scoring_struct(var_3, var_4, var_5, var_6);
}

function set_spawn_scoring_params_for_group(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_5)) {
    var_6 = level.gametype;
    var_7 = strtok(var_5, " ");

    for(var_8 = 0; var_8 < var_7.size; var_8++) {
      if(var_7[var_8] == var_6) {
        break;
      }
    }

    return;
  }

  if(isDefined(level.ambientgroups[var_3])) {
    if(isarray(level.ambientgroups[var_3])) {
      for(var_8 = 0; var_8 < level.ambientgroups[var_3].size; var_8++) {
        level.ambientgroups[var_3][var_8].spawn_scoring_overrides = create_spawn_scoring_struct(var_4, var_5, var_6, var_7);
      }

      return;
    }

    level.ambientgroups[var_3].spawn_scoring_overrides = create_spawn_scoring_struct(var_4, var_5, var_6, var_7);
    return;
  }
}

function create_spawn_scoring_struct(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();

  if(isDefined(var_0)) {
    var_4.close_dist = int(var_0);
  } else {
    var_4.close_dist = 1024;
  }

  var_4.close_dist_sq = var_4.close_dist * var_4.close_dist;

  if(isDefined(var_1)) {
    var_4.far_dist = int(var_1);
  } else {
    var_4.far_dist = 2048;
  }

  var_4.far_dist_sq = var_4.far_dist * var_4.far_dist;

  if(isDefined(var_2)) {
    var_4.ref_13bdb = int(var_2);
    var_4.too_far_dist_sq = var_4.ref_13bdb * var_4.ref_13bdb;
  } else {
    var_4.ref_13bdb = 4096;
    var_4.too_far_dist_sq = 16777216;
  }

  if(isDefined(var_3)) {
    var_4.far_score = int(var_3);
  } else {
    var_4.far_score = 20;
  }

  return var_4;
}

function get_spawned_ai_from_group_struct(var_0) {
  var_1 = [];

  if(isstruct(self)) {
    if(isarray(self)) {
      for(var_2 = 0; var_2 < self.size; var_2++) {
        var_1 = scripts\engine\utility::array_combine(var_1, self[var_2].ai_spawned);
      }
    } else {
      var_1 = self.ai_spawned;
    }
  } else if(isDefined(level.active_spawn_module_structs[var_0])) {
    var_3 = level.active_spawn_module_structs[var_0];

    if(isarray(var_3)) {
      for(var_4 = 0; var_4 < var_3.size; var_4++) {
        var_5 = var_3[var_4];
        var_1 = scripts\engine\utility::array_combine(var_1, var_5.ai_spawned);
      }
    } else {
      var_1 = scripts\engine\utility::array_combine(var_1, var_3.ai_spawned);
    }
  }

  return var_1;
}

function make_ai_usable(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_1)) {
    self.onuse = var_1;
  } else {
    self.onuse = &follow_triggering_player;
  }

  self.trigger = spawn("script_model", self.origin + (0, 0, 30));
  self.trigger linkTo(self);
  self.trigger makeusable();
  self.trigger setuseprioritymax();
  self.trigger setCursorHint("HINT_BUTTON");
  self.trigger sethintdisplayrange(148);
  self.trigger sethintdisplayfov(90);
  self.trigger setuserange(72);
  self.trigger setusefov(45);
  self.trigger sethintonobstruction("show");
  self.trigger sethintrequiresholding(1);
  self.trigger setuseholdduration("duration_short");

  if(isDefined(var_2)) {
    self.trigger setHintString(var_2);
  }

  if(isDefined(var_4)) {
    set_goal_radius(var_4);
  }

  if(isDefined(var_5)) {
    self.goalheight = var_5;
  }

  thread scripts\engine\utility::delete_on_death(self.trigger);
  thread ai_used_think(var_3);
}

function ai_used_think(var_0) {
  self endon("death");
  self endon("downed");
  self endon("exfil");
  self.trigger endon("death");

  for(;;) {
    self.trigger waittill("trigger", var_1);

    if(!var_1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(isDefined(self.onuse)) {
      self thread[[self.onuse]](var_1, var_0);
    }
  }
}

function follow_triggering_player(var_0, var_1) {
  self notify("follow_triggering_player");
  self endon("follow_triggering_player");
  self endon("death");
  var_0 endon("death_or_disconnect");
  var_0 endon("last_stand");

  if(isDefined(var_1)) {
    create_head_icon_for_ai(var_1);
  }

  for(;;) {
    set_goal_ent(var_0);
    wait 1;
    var_0 = scripts\cp\utility::get_closest_living_player();
  }
}

function create_head_icon_for_ai(var_0) {
  self.headicon = deleteheadicon(self);
  setheadiconfriendlyimage(self.headicon, var_0);
  setheadicondrawthroughgeo(self.headicon, 1);
  setheadiconsnaptoedges(self.headicon, 29000);
  setheadiconmaxdistance(self.headicon, 10);
  addclienttoheadiconmask(self.headicon, 10);
  thread remove_headicon_on_death();
}

function remove_headicon_on_death() {
  if(!isDefined(self.headicon)) {
    return;
  }

  var_0 = self.headicon;
  var_1 = scripts\engine\utility::ref_143a5("death", "remove_headicon");
  setheadiconimage(var_0);
}

function disable_kill_off(var_0, var_1, var_2, var_3) {
  var_0.disable_kill_off = 1;
}

function quarry_hacks_count(var_0) {
  if(isDefined(level.ambientgroups) && isDefined(level.ambientgroups[var_0])) {
    return level.ambientgroups[var_0];
  }

  return undefined;
}

function isambientspawningpaused(var_0) {
  self endon("death");

  if(scripts\engine\utility::ent_flag_exist("pause_group") && scripts\engine\utility::ent_flag("pause_group")) {
    scripts\engine\utility::ent_flag_waitopen("pause_group");
    return true;
  }

  if(istrue(level.spawnpoint_debug)) {
    level waittill("end_spawnpoint_debug");
  }

  if(istrue(level.ambient_spawning_paused)) {
    wait 0.25;
    return true;
  }

  return false;
}

function allowed_to_spawn_agent(var_0, var_1, var_2, var_3) {
  var_4 = get_total_reserved_slot_count();
  var_5 = get_max_agent_count();
  var_6 = var_5 - var_4;
  var_7 = level.spawned_ai.size - level.delayed_spawn_slots;
  var_8 = var_6 - var_7;

  if(isDefined(var_0)) {
    var_9 = get_comp_count(var_0);

    if(!isDefined(var_9)) {
      return 0;
    }

    var_10 = var_9 - get_activecount_from_group(var_0, 1);
    var_11 = get_reserved_slot_count_by_string_id(var_3);
    var_6 = var_5 - var_4 + var_11;

    if(!istrue(var_0.kill_off_enemies)) {
      if(var_10 > 0 && var_8 > 0) {
        return 1;
      }

      return 0;
    }

    if(var_10 > 0 && var_8 > 0) {
      return 1;
    }

    if(!istrue(var_0.min_spawn_requested)) {
      var_0.min_spawn_requested = 1;
      increase_reserved_spawn_slots(var_0, 1, var_0.moduleid, var_0);
    }

    var_12 = 0;

    if(!istrue(var_0.disable_kill_off)) {
      var_13 = int(abs(var_8));
      var_12 = kill_off_enemies(var_0, int(clamp(var_13, 1, var_6)), istrue(var_0.kill_off_enemies) || istrue(var_1));
    }

    if(var_12 > 0) {
      wait 0.1;
    }

    var_14 = level.spawned_ai.size - level.delayed_spawn_slots;
    var_15 = var_6 - var_14;
    return var_15;
  }

  if(var_11 < 1) {
    var_13 = int(abs(var_11));
    var_12 = kill_off_enemies(undefined, int(clamp(var_13, 1, var_9)), istrue(var_4));

    if(var_12 > 0) {
      wait 0.1;
    }

    var_14 = level.spawned_ai.size - level.delayed_spawn_slots;
    var_15 = var_9 - var_14;
    return var_15;
  }

  return var_15;
}

function get_max_agent_count(var_0) {
  var_1 = getdvarint("scr_default_maxagents", 32);
  var_2 = 32;
  var_3 = getdvarint("scr_maxagents_override", var_1);

  if(var_2 > var_1) {
    return int(var_2);
  }

  return int(clamp(var_3, var_2, var_1));
}

function is_agent_in_group(var_0, var_1) {
  if(!isDefined(var_1.enemy_group)) {
    return false;
  }

  if(var_0 == var_1.enemy_group) {
    return true;
  }

  return false;
}

function propent(var_0, var_1) {
  var_2 = project(var_0);
  var_3 = project(var_1);
  return var_2 > var_3;
}

function ref_134d3() {
  if(isDefined(self.group)) {
    if(self.group.group_name != "wave_spawning") {
      return 1;
    }

    return 0;
  }

  return 0;
}

function project() {
  var_0 = 1073741824;
  var_1 = undefined;

  foreach(var_3 in level.players) {
    var_4 = distancesquared(self.origin, var_3.origin);

    if(var_4 < var_0) {
      var_1 = var_3;
      var_0 = var_4;
    }
  }

  return var_0;
}

function vehicle_preventplayercollisiondamagefortimeafterexit() {
  self endon("death");
  self.ref_133b6 = 1;
  self.playeriszombie = 1;
  self.ref_12fc1 = 1;

  for(;;) {
    var_0 = passive_kill_off_ai(1);

    if(isDefined(var_0) && !var_0) {
      self.ref_133b6 = undefined;
      self.playeriszombie = undefined;
      break;
    }

    wait 0.25;
  }
}

function kill_off_enemies(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_5 = gettime();

  if(isDefined(var_0)) {
    level.compare_group_name = var_0.group_name;
  }

  if(istrue(var_2) && var_1 > var_4) {
    var_6 = getaiarray("axis");
    var_7 = scripts\engine\utility::array_sort_with_func(var_6, &propent);
    var_7 = scripts\cp\utility::array_sort_by_handler(var_7, &ref_134d3);

    for(var_8 = 0; var_8 < var_7.size; var_8++) {
      if(passive_kill_off_ai(var_7[var_8], 1)) {
        var_4++;

        if(var_1 <= var_4) {
          return var_4;
        }
      }
    }

    var_7 = scripts\engine\utility::array_removedead(var_7);

    for(var_8 = 0; var_8 < var_7.size; var_8++) {
      var_9 = var_7[var_8];

      if(has_never_kill_off_flag(var_9)) {
        continue;
      }

      if(istrue(scripts\engine\utility::script_func("ai_is_carrying_hvt", var_9))) {
        continue;
      }

      if(!isDefined(var_9) || !isalive(var_9) || var_9.health <= 0) {
        continue;
      }

      if(isDefined(var_9.team) && var_9.team == "allies") {
        continue;
      }

      if(isDefined(var_0) && scripts\engine\utility::is_equal(var_9.enemy_group, var_0.group_name)) {
        thread teleport_to_nearby_spawner(var_9);
        continue;
      }

      script_kill_ai(var_9);
      var_4++;

      if(var_1 <= var_4) {
        return var_4;
      }
    }
  }

  return var_4;
}

function passed_kill_off_time_checks(var_0) {
  if(isDefined(self.killofftime) && var_0 <= self.killofftime) {
    return 0;
  }

  return 1;
}

function get_see_recently_time_overrides() {
  if(isDefined(self.ref_12fc1)) {
    return self.ref_12fc1;
  }

  if(isDefined(self.group)) {
    if(isDefined(self.group.last_seen_time_override)) {
      return self.group.last_seen_time_override;
    }

    if(istrue(self.group.cqb_module)) {
      return 2;
    }

    return 6;
  }

  return 6;
}

function can_be_script_killed(var_0, var_1) {
  if(istrue(self.marked_for_death)) {
    return 0;
  }

  if(has_dont_kill_off_flag()) {
    return 0;
  }

  if(istrue(self.playing_skit)) {
    return 0;
  }

  if(is_riding_vehicle()) {
    return 0;
  }

  if(isDefined(self.killofftime) && gettime() <= self.killofftime) {
    return 0;
  }

  if(is_specified_unittype("juggernaut")) {
    return 0;
  }

  if(isDefined(self.group)) {
    if(get_activecount_from_group(self.group) <= process_module_var(self.group, self.group.min_size)) {
      if(!isDefined(var_0) || var_0 != self.group) {
        return 0;
      }
    }
  }

  if(var_1 && isDefined(self.enemy_group) && isDefined(var_0)) {
    if(self.enemy_group != var_0.group_name) {
      return 0;
    }
  }

  if(isDefined(self.enemy) && self canshootenemy()) {
    return 0;
  }
}

function dont_kill_flag() {
  return istrue(self.dontkilloff);
}

function is_always_on_group() {
  if(isDefined(self.enemy_group)) {
    if(istrue(self.group.is_passive)) {
      return 1;
    }

    if(self.enemy_group == "always_on") {
      return 1;
    }

    return 0;
  }

  return 0;
}

function can_be_seen() {
  return istrue(self.bcansee);
}

function is_bad_path() {
  return istrue(self.badpath);
}

function is_same_group() {
  if(!isDefined(level.compare_group_name)) {
    return 1;
  }

  return isDefined(self.enemy_group) && self.enemy_group == level.compare_group_name;
}

function kill_off_sort() {
  var_0 = 0;

  if(!is_riding_vehicle()) {
    var_0 += 15;
  }

  if(is_same_group()) {
    var_0 += 15;
  }

  if(!is_bad_path()) {
    var_0 += 10;
  }

  if(!is_always_on_group()) {
    var_0 += 25;
  }

  return var_0;
}

function get_killoff_time() {
  if(isDefined(self.killofftime)) {
    return self.killofftime;
  }

  return 0;
}

function watch_for_all_groups_dead(var_0, var_1) {
  level endon("group_" + var_1 + "_ended");
  var_2 = 0;
  var_3 = [];

  foreach(var_5 in var_0) {
    thread notify_when_group_ends(var_5, var_1, var_2);
    var_3 = var_1 + var_2 + "_completed";
    var_2++;
  }

  level scripts\engine\utility::waittill_all_in_array(var_3);
  level notify("module_group " + var_1 + " completed");
}

function notify_when_group_ends(var_0, var_1, var_2) {
  level endon("group_" + var_1 + "_ended");
  var_0 waittill("group_spawning_completed");
  level notify(var_1 + var_2 + "_completed");
}

function run_spawn_module(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");

  if(getdvarint("scr_always_on_always", 0)) {
    if(var_0 != "always_on" && var_0 != "Max Agent Test") {
      return;
    }
  }

  if(getdvarint("scr_only_passive_spawning", 0)) {
    if(isDefined(level.ambientgroups[var_0]) && !istrue(level.ambientgroups[var_0].is_passive)) {
      return;
    }
  }

  level notify("new_spawn_module_requested_" + var_0);
  level.active_spawn_modules[level.active_spawn_modules.size] = var_0;

  if(!isDefined(level.active_spawn_module_structs[var_0])) {
    level.active_spawn_module_structs[var_0] = [];
  }

  if(!isDefined(level.spawn_module_structs_memory[var_0])) {
    level.spawn_module_structs_memory[var_0] = [];
  }

  var_5 = create_module_struct(var_0);

  if(isDefined(var_5)) {
    if(isarray(var_5)) {
      thread watch_for_all_groups_dead(var_5, var_5);

      foreach(var_2 in var_5) {
        thread add_and_watch_group(level, var_2);
      }

      foreach(var_2 in var_5) {
        thread ref_12dda(level, var_2);
      }
    } else {
      thread add_and_watch_group(level, var_5);
      thread ref_12dda(level, var_5);
    }

    return var_5;
  }
}

function add_and_watch_group(var_0, var_1) {
  level endon("game_ended");
  level.active_spawn_module_structs[var_1][level.active_spawn_module_structs[var_1].size] = var_0;
  level.spawn_module_structs_memory[var_1][level.spawn_module_structs_memory[var_1].size] = var_0;
  var_0 waittill("death");

  if(get_activecount_from_group(var_0, 1) < 1) {
    scripts\cp\cp_spawning_util::ref_12bd3(var_0);

    if(isDefined(level.spawn_module_structs_memory[var_0.group_name]) && scripts\engine\utility::array_contains(level.spawn_module_structs_memory[var_0.group_name], var_0)) {
      level.spawn_module_structs_memory[var_0.group_name] = scripts\engine\utility::array_remove(level.spawn_module_structs_memory[var_0.group_name], var_0);

      if(isDefined(level.spawn_module_structs_memory[var_0.group_name]) && level.spawn_module_structs_memory[var_0.group_name].size < 1) {
        level.spawn_module_structs_memory[var_0.group_name] = undefined;
      }
    }
  }

  if(scripts\engine\utility::array_contains(level.active_spawn_module_structs[var_1], var_0)) {
    level.active_spawn_module_structs[var_1] = scripts\engine\utility::array_remove(level.active_spawn_module_structs[var_1], var_0);

    if(isDefined(level.active_spawn_module_structs[var_1]) && level.active_spawn_module_structs[var_1].size < 1) {
      level.active_spawn_module_structs[var_1] = undefined;
      return;
    }

    return;
  }
}

function create_module_struct(var_0) {
  var_1 = quarry_hacks_count(var_0);

  if(isDefined(var_1)) {
    if(isarray(var_1)) {
      var_2 = [];

      foreach(var_4 in var_1) {
        var_5 = copy_from_level_struct(var_4);
        var_2 = scripts\engine\utility::array_add(var_2, var_5);
      }

      return var_2;
    }

    var_5 = copy_from_level_struct(var_6);
    return var_5;
  }
}

function copy_from_level_struct(var_0) {
  var_1 = spawnStruct();
  var_1.group_name = var_0.group_name;
  var_1.min_size = var_0.min_size;
  var_1.max_size = var_0.max_size;
  var_1.time_between_spawns = var_0.time_between_spawns;
  var_1.post_module_delay = var_0.post_module_delay;
  var_1.activecount = var_0.activecount;
  var_1.spawn_count = var_0.spawn_count;
  var_1.ai_spawned = var_0.ai_spawned;
  var_1.spawn_points = var_0.spawn_points;
  var_1.totalspawns = var_0.totalspawns;
  var_1.start_func = var_0.start_func;
  var_1.nextgroup = var_0.nextgroup;
  var_1.timeout_action = var_0.timeout_action;
  var_1.currentmodulekills = var_0.currentmodulekills;
  var_1.currentmoduledeaths = var_0.currentmoduledeaths;
  var_1.moduleid = var_0.moduleid;
  var_1.ai_spawn_func = var_0.ai_spawn_func;
  var_1.ai_death_func = var_0.ai_death_func;
  var_1.fn_weapons_free = var_0.fn_weapons_free;
  var_1.cqb_module = var_0.cqb_module;
  var_1.always_attempt_killoff = var_0.always_attempt_killoff;
  var_1.status = var_0.status;
  var_1.spawn_scoring_overrides = var_0.spawn_scoring_overrides;
  var_1.aievent_funcs = var_0.aievent_funcs;
  var_1.is_passive = var_0.is_passive;
  var_1.module_vehicles = var_0.module_vehicles;
  var_1.ref_11cb0 = var_0.ref_11cb0;
  var_1.disable_spawners_until_owner_death = var_0.disable_spawners_until_owner_death;
  var_1.combined_counters = var_0.combined_counters;
  var_1.ref_141b3 = var_0.ref_141b3;
  var_1.debug_data = var_0.debug_data;
  var_1.ref_13be5 = var_0.ref_13be5;
  var_1.set_chosen_spawner_from_uid = var_0.set_chosen_spawner_from_uid;
  var_1.serverroomrewardroll = var_0.serverroomrewardroll;
  var_1.lightsfloor02 = var_0.lightsfloor02;
  var_1.level_module_struct = var_0;
  level.requested_spawns_groups[var_1.moduleid] = 0;
  var_1 scripts\engine\utility::ent_flag_init("pause_group");
  var_1 scripts\engine\utility::ent_flag_init("weapons_free");
  return var_1;
}

function add_to_module_vehicles_list(var_0, var_1) {
  if(isDefined(var_1)) {
    if(!isDefined(var_0.vehicle_caps_counter)) {
      var_0.vehicle_caps_counter = [];
    }

    if(!isDefined(var_0.vehicle_caps_counter[var_1])) {
      var_0.vehicle_caps_counter[var_1] = 1;
    } else {
      var_0.vehicle_caps_counter[var_1]++;
    }
  }

  var_0.ref_11cb0++;
  var_0.module_vehicles[var_0.module_vehicles.size] = self;
  thread scripts\engine\utility::thread_on_notify_no_endon_death("death", &remove_from_module_vehicles_list, var_0, var_1);
}

function has_vehicle_type_exceeded_module_cap(var_0, var_1) {
  if(!isDefined(var_0.vehicle_caps)) {
    return false;
  }

  if(isDefined(var_0.vehicle_caps[var_1])) {
    if(!isDefined(var_0.vehicle_caps_counter)) {
      return false;
    }

    if(!isDefined(var_0.vehicle_caps_counter[var_1])) {
      return false;
    }

    if(triggerenterfunc(var_0.vehicle_caps_counter[var_1], var_0.vehicle_caps[var_1])) {
      return true;
    }
  }

  return false;
}

function remove_from_module_vehicles_list(var_0, var_1) {
  if(isDefined(var_1)) {
    if(isDefined(var_0.vehicle_caps_counter)) {
      if(isDefined(var_0.vehicle_caps_counter[var_1])) {
        var_0.vehicle_caps_counter[var_1]--;

        if(var_0.vehicle_caps_counter[var_1] < 0) {
          var_0.vehicle_caps_counter[var_1] = 0;
        }
      }
    }
  }

  if(scripts\engine\utility::array_contains(var_0.module_vehicles, self)) {
    var_0.module_vehicles = scripts\engine\utility::array_remove(var_0.module_vehicles, self);
  }

  var_0 notify("vehicle_removed_from_group");
}

function timeout_group_after_duration() {
  self endon("death");
  level notify("timeout_group_after_duration_" + self.moduleid);
  level endon("timeout_group_after_duration_" + self.moduleid);
  level endon("group_" + self.group_name + "_ended");
  var_0 = process_module_var(self, self.timeout_action);

  if(isDefined(var_0) && isnumber(var_0)) {
    wait var_0;
  }

  level notify("spawnModuleTimedOut_" + self.moduleid);
}

function ref_12dda(var_0, var_1) {
  level notify("run_current_spawn_group" + var_0.moduleid);
  level endon("game_ended");
  var_0 endon("death");
  thread watch_for_module_endons();
  thread ref_12df3();
  thread module_run_func_after_notify();

  if(isDefined(var_0.timeout_action)) {
    thread timeout_group_after_duration();
  }

  change_module_status(var_0, undefined, "Init Funcs");
  var_0 scripts\cp\cp_spawning_util::run_module_init_funcs_on_module_struct();

  if(isDefined(var_0.start_func)) {
    change_module_status(var_0, undefined, "Start Func");
    process_module_var(var_0, var_0.start_func);
  }

  thread run_weapons_free_funcs();

  if(getDvar("scr_module_iso", "") != "" && getDvar("scr_module_iso", "") == var_0.group_name) {
    thread ref_12e20(level, var_0);
  } else {
    thread runspawnmodule(level, var_0);
  }

  var_0 waittill("death");
}

function run_weapons_free_funcs() {
  if(isDefined(self.fn_weapons_free)) {
    scripts\engine\utility::ent_flag_wait("weapons_free");

    for(var_0 = 0; var_0 < self.fn_weapons_free.size; var_0++) {
      thread process_module_var(self, self.fn_weapons_free[var_0]);
    }

    return;
  }
}

function ref_12ddd() {
  if(isDefined(self.group.lightsfloor02)) {
    for(var_0 = 0; var_0 < self.group.lightsfloor02.size; var_0++) {
      thread process_module_var(self.group, self.group.lightsfloor02[var_0]);
    }

    return;
  }
}

function ref_12df3() {
  level endon("game_ended");
  self endon("death");
  var_0 = level scripts\engine\utility::ref_143ad("spawn_module_" + self.moduleid + "_completed", "spawnModuleTimedOut_" + self.moduleid);

  if(isDefined(self.post_module_delay)) {
    var_1 = process_module_var(self, self.post_module_delay);

    if(isDefined(var_1) && isnumberandgreaterthanzero(var_1)) {
      level scripts\engine\utility::ref_143b9(var_1, "new_module_requested");
    }

    level notify("group_" + self.group_name + "_post_module_complete");
  }

  if(isDefined(self.nextgroup)) {
    var_2 = process_module_var(self, self.nextgroup);

    if(isDefined(var_2) && isstring(var_2)) {
      thread run_spawn_module(level, var_2, undefined);
    }
  }

  self notify("death");
}

function remove_pacifist_from_enemies() {
  for(var_0 = 0; var_0 < level.spawned_enemies.size; var_0++) {
    level.spawned_enemies[var_0].pacifist = 0;
    level.spawned_enemies[var_0].script_pacifist = undefined;
    thread enter_combat_after_stealth();
  }
}

function remove_pacifist_from_guy() {
  self.pacifist = 0;
  self.script_pacifist = undefined;
}

function demeanor_override_all_enemies(var_0) {
  for(var_1 = 0; var_1 < level.spawned_enemies.size; var_1++) {
    set_demeanor_from_unittype(level.spawned_enemies[var_1], var_0);
  }
}

function set_dont_enter_combat_flag(var_0) {
  self.dont_enter_combat = 1;
}

function clear_dont_enter_combat_flag() {
  self.dont_enter_combat = undefined;
}

function watch_for_module_endons() {
  level endon("game_ended");
  self endon("death");
  var_0 = ["run_current_spawn_group" + self.moduleid, "end_spawn_module_" + self.moduleid, "end_spawn_module_" + self.group_name];
  level scripts\engine\utility::waittill_any_in_array_return(var_0);
  self notify("death");
}

function isnumberandgreaterthanzero(var_0) {
  if(isDefined(var_0) && isnumber(var_0) && var_0 > 0) {
    return 1;
  }

  return 0;
}

function runspawnmodule(var_0, var_1) {
  level endon("game_ended");
  level notify("runSpawnModule_" + var_0.moduleid);
  level endon("runSpawnModule_" + var_0.moduleid);
  var_0 endon("death");
  thread resetgroupvariables();
  waittillframeend();

  for(;;) {
    if(isambientspawningpaused(var_0)) {
      change_module_status(var_0, undefined, "Module Paused");
      continue;
    }

    var_2 = process_module_var(var_0, var_0.totalspawns);
    var_0.debug_data.totalspawns = var_2;

    if(var_2 > 0 && get_activecount_from_group(var_0, 1) + var_0.currentmodulekills >= var_2) {
      level notify("spawn_module_" + var_0.moduleid + "_completed");
      return;
    }

    var_2 = process_module_var(var_0, var_0.totalspawns);
    var_0.debug_data.totalspawns = var_2;
    var_3 = get_comp_count(var_0);
    var_4 = get_comp_count(var_0, 0);
    var_5 = allowed_to_spawn_agent(var_0);

    if(var_5) {
      if(isDefined(var_3) && isDefined(var_4) && get_activecount_from_group(var_0, 1) < var_3 && get_activecount_from_group(var_0) < var_4) {
        spawn_soldier_scripted(var_0, var_0);
      }

      var_6 = process_module_var(var_0, var_0.time_between_spawns);

      if(isnumberandgreaterthanzero(var_6)) {
        wait var_6;
      } else {
        waitframe();
      }

      continue;
    }

    wait 0.1;
  }
}

function ref_12e20(var_0, var_1) {
  level endon("game_ended");
  level notify("runSpawnModule_" + var_0.moduleid);
  level endon("runSpawnModule_" + var_0.moduleid);
  var_0 endon("death");
  thread resetgroupvariables();

  for(;;) {
    if(isambientspawningpaused(var_0)) {
      change_module_status(var_0, undefined, "Module Paused");
      continue;
    }

    var_2 = process_module_var(var_0, var_0.totalspawns);
    var_0.debug_data.totalspawns = var_2;

    if(var_2 > 0 && get_activecount_from_group(var_0, 1) + var_0.currentmodulekills >= var_2) {
      level notify("spawn_module_" + var_0.moduleid + "_completed");
      return;
    }

    var_2 = process_module_var(var_0, var_0.totalspawns);
    var_0.debug_data.totalspawns = var_2;
    var_3 = get_comp_count(var_0);
    var_4 = get_comp_count(var_0, 0);
    var_5 = allowed_to_spawn_agent(var_0);

    if(var_5) {
      if(isDefined(var_3) && isDefined(var_4) && get_activecount_from_group(var_0, 1) < var_3 && get_activecount_from_group(var_0) < var_4) {
        spawn_soldier_scripted(var_0, var_0);
      }

      var_6 = process_module_var(var_0, var_0.time_between_spawns);

      if(isnumberandgreaterthanzero(var_6)) {
        wait var_6;
      }

      continue;
    }

    wait 0.1;
  }
}

function get_comp_count(var_0) {
  var_1 = process_module_var(self, self.min_size);
  self.debug_data.min_size = var_1;
  self.kill_off_enemies = undefined;
  var_0 = define_var_if_undefined(var_0, 1);

  if(isDefined(var_1) && get_activecount_from_group(var_0) < var_1) {
    self.kill_off_enemies = 1;
    level.requested_spawns_groups[self.moduleid] = var_1;
    return var_1;
  }

  var_2 = process_module_var(self, self.max_size);
  self.debug_data.max_size = var_2;

  if(isDefined(var_2) && get_activecount_from_group(var_0) < var_2) {
    level.requested_spawns_groups[self.moduleid] = var_2;
    return var_2;
  }

  return undefined;
}

function send_aievent_to_others_in_group(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_5)) {
    var_5 = self;
  }

  if(isDefined(var_1)) {
    if(isarray(self.group)) {
      var_6 = [];

      for(var_7 = 0; var_7 < self.group.size; var_7++) {
        var_6 = scripts\engine\utility::array_add(var_6, self.group[var_7].ai_spawned);
      }

      var_8 = scripts\engine\utility::get_array_of_closest(self.origin, var_6, undefined, undefined, var_1, 0);
    } else {
      var_8 = scripts\engine\utility::get_array_of_closest(self.origin, self.group.ai_spawned, undefined, undefined, var_2, 0);
    }
  } else if(isarray(self.group)) {
    var_6 = [];

    for(var_7 = 0; var_7 < self.group.size; var_7++) {
      var_6 = scripts\engine\utility::array_add(var_6, self.group[var_7].ai_spawned);
    }

    var_8 = var_6;
  } else {
    var_8 = self.group.ai_spawned;
  }

  for(var_7 = 0; var_7 < var_8.size; var_7++) {
    if(var_8[var_7] == self) {
      if(istrue(var_8)) {
        var_8[var_7] aieventlistenerevent(var_3, var_8, self.origin);
        continue;
      } else {
        continue;
      }
    }

    if(istrue(var_5) && !scripts\engine\utility::within_fov(self.origin, self.angles, var_8[var_7].origin, cos(65))) {
      continue;
    }

    if(istrue(var_8) && !self aiphysicstracepassed(self.origin, var_8[var_7].origin, 15, 60)) {
      continue;
    }

    var_8[var_7] aieventlistenerevent(var_3, var_8, self.origin);
  }
}

function notify_others_in_group(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4)) {
    var_5 = getaiarray("axis");
  } else {
    var_5 = self.group.ai_spawned;
  }

  if(isDefined(var_2)) {
    var_5 = scripts\engine\utility::get_array_of_closest(self.origin, var_5, undefined, undefined, var_2, 0);
  }

  for(var_6 = 0; var_6 < var_5.size; var_6++) {
    if(var_5[var_6] == self) {
      continue;
    }

    if(istrue(var_3) && !scripts\engine\utility::within_fov(var_5[var_6].origin, var_5[var_6].angles, self.origin, cos(65))) {
      continue;
    }

    if(istrue(var_4) && !var_5[var_6] cansee(self)) {
      continue;
    }

    var_5[var_6] notify(var_1);
  }
}

function get_requested_spawn_count(var_0) {
  var_1 = 0;

  foreach(var_3 in level.requested_spawns_groups) {
    if(isDefined(var_0) && var_0 == var_4) {
      continue;
    }

    var_1 += var_3;
  }

  return var_1;
}

function run_func_on_group_by_groupname(var_0, var_1) {
  foreach(var_3 in level.active_spawn_module_structs) {
    if(isarray(var_3)) {
      foreach(var_5 in var_3) {
        if(var_5.group_name == var_0) {
          process_module_var(var_5, var_5, var_1);
        }
      }

      continue;
    }

    if(var_3.group_name == var_0) {
      process_module_var(var_3, var_3, var_1);
    }
  }
}

function pause_all_other_groups(var_0) {
  foreach(var_2 in level.active_spawn_module_structs) {
    if(isarray(var_2)) {
      foreach(var_4 in var_2) {
        if(var_4.group_name != var_0) {
          if(getdvarint("scr_show_module_pauses", 0)) {
            announcement(var_4.group_name + " ^1Paused");
          }

          var_4 scripts\engine\utility::ent_flag_set("pause_group");
        }
      }

      continue;
    }

    if(var_2.group_name != var_0) {
      if(getdvarint("scr_show_module_pauses", 0)) {
        announcement(var_2.group_name + " ^1Paused");
      }

      var_2 scripts\engine\utility::ent_flag_set("pause_group");
    }
  }
}

function unpause_all_other_groups(var_0) {
  foreach(var_2 in level.active_spawn_module_structs) {
    if(isarray(var_2)) {
      foreach(var_4 in var_2) {
        if(var_4.group_name != var_0) {
          if(getdvarint("scr_show_module_pauses", 0)) {
            announcement(var_4.group_name + " ^3Unpaused");
          }

          var_4 scripts\engine\utility::ent_flag_clear("pause_group");
        }
      }

      continue;
    }

    if(var_2.group_name != var_0) {
      if(getdvarint("scr_show_module_pauses", 0)) {
        announcement(var_2.group_name + " ^3Unpaused");
      }

      var_2 scripts\engine\utility::ent_flag_clear("pause_group");
    }
  }
}

function pause_group_by_id(var_0, var_1) {
  foreach(var_3 in level.active_spawn_module_structs) {
    if(isarray(var_3)) {
      foreach(var_5 in var_3) {
        if(var_5.group_name == var_0 && var_5.moduleid == var_1) {
          if(getdvarint("scr_show_module_pauses", 0)) {
            announcement(var_5.group_name + " ^1Paused");
          }

          var_5 scripts\engine\utility::ent_flag_set("pause_group");
        }
      }

      continue;
    }

    if(var_3.group_name == var_0 && var_3.moduleid == var_1) {
      if(getdvarint("scr_show_module_pauses", 0)) {
        announcement(var_3.group_name + " ^1Paused");
      }

      var_3 scripts\engine\utility::ent_flag_set("pause_group");
    }
  }
}

function unpause_group_by_id(var_0, var_1) {
  foreach(var_3 in level.active_spawn_module_structs) {
    if(isarray(var_3)) {
      foreach(var_5 in var_3) {
        if(var_5.group_name == var_0 && var_5.moduleid == var_1) {
          if(getdvarint("scr_show_module_pauses", 0)) {
            announcement(var_5.group_name + " ^3Unpaused");
          }

          var_5 scripts\engine\utility::ent_flag_clear("pause_group");
        }
      }

      continue;
    }

    if(var_3.group_name == var_0 && var_3.moduleid == var_1) {
      if(getdvarint("scr_show_module_pauses", 0)) {
        announcement(var_3.group_name + " ^3Unpaused");
      }

      var_3 scripts\engine\utility::ent_flag_clear("pause_group");
    }
  }
}

function set_weapons_free_for_all_groups() {
  foreach(var_1 in level.spawn_module_structs_memory) {
    if(isarray(var_1)) {
      foreach(var_3 in var_1) {
        var_3 scripts\engine\utility::ent_flag_set("weapons_free");
      }

      continue;
    }

    var_1 scripts\engine\utility::ent_flag_set("weapons_free");
  }
}

function pause_group_by_group_name(var_0) {
  foreach(var_2 in level.active_spawn_module_structs) {
    if(isarray(var_2)) {
      foreach(var_4 in var_2) {
        if(var_4.group_name == var_0) {
          if(getdvarint("scr_show_module_pauses", 0)) {
            announcement(var_4.group_name + " ^1Paused");
          }

          var_4 scripts\cp\cp_spawning_util::ref_12dee();
          var_4 scripts\engine\utility::ent_flag_set("pause_group");
        }
      }

      continue;
    }

    if(var_2.group_name == var_0) {
      if(getdvarint("scr_show_module_pauses", 0)) {
        announcement(var_2.group_name + " ^1Paused");
      }

      var_2 scripts\cp\cp_spawning_util::ref_12dee();
      var_2 scripts\engine\utility::ent_flag_set("pause_group");
    }
  }
}

function unpause_group_by_group_name(var_0) {
  foreach(var_2 in level.active_spawn_module_structs) {
    if(isarray(var_2)) {
      foreach(var_4 in var_2) {
        if(var_4.group_name == var_0) {
          if(getdvarint("scr_show_module_pauses", 0)) {
            announcement(var_2.group_name + " ^3Unpaused");
          }

          var_4 scripts\cp\cp_spawning_util::ref_12def();
          var_4 scripts\engine\utility::ent_flag_clear("pause_group");
        }
      }

      continue;
    }

    if(var_2.group_name == var_0) {
      if(getdvarint("scr_show_module_pauses", 0)) {
        announcement(var_2.group_name + " ^3Unpaused");
      }

      var_2 scripts\cp\cp_spawning_util::ref_12def();
      var_2 scripts\engine\utility::ent_flag_clear("pause_group");
    }
  }
}

function stop_all_groups() {
  var_0 = getarraykeys(level.active_spawn_module_structs);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    stop_module_by_groupname(var_0[var_1]);
  }
}

function stop_module_by_id(var_0) {
  level notify("end_spawn_module_" + var_0);
}

function stop_module_by_groupname(var_0, var_1) {
  if(isDefined(level.active_spawn_module_structs[var_0])) {
    var_2 = level.active_spawn_module_structs[var_0];

    if(isarray(var_2)) {
      foreach(var_4 in var_2) {
        if(istrue(var_1)) {
          level notify("spawn_module_" + var_4.moduleid + "_completed");
          continue;
        }

        var_4 notify("death");
      }

      return;
    }

    if(istrue(var_1)) {
      level notify("spawn_module_" + var_2.moduleid + "_completed");
      return;
    }

    var_2 notify("death");
    return;
  }
}

function initialize_as_veh_spawner() {
  define_spawner("vehicle_spawner");
  remove_from_spawner_flags(8);
  add_to_spawner_flags(16);
  self.script_function = "techo_phys";
  self.veh_model_spawner = 1;
  scripts\cp\utility::addtostructarray("targetname", "ground_veh_exit", self);
  scripts\cp\utility::addtostructarray("script_noteworthy", "deleteme", self);
}

function process_module_var(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_0 endon("death");
  self endon("var_param_race_timeout");

  if(!isDefined(var_1)) {
    return "empty";
  }

  var_4 = var_1;

  if(isstring(var_1)) {
    return var_1;
  } else if(isnumberandgreaterthanzero(var_1)) {
    return var_1;
  } else if(isarray(var_1)) {
    if(isarray(var_1[0])) {
      for(var_5 = 0; var_5 < var_1.size; var_5++) {
        var_4 = process_module_var(var_0, var_1[var_5], var_2);
      }
    } else if(isbuiltinfunction(var_1[0])) {
      var_6 = var_1[0];
      var_7 = [];
      var_8 = process_module_params(var_0, var_1);
      var_4 = run_modular_spawning_func(var_0, var_6, var_8, var_3);
    } else {
      var_4 = var_1;
    }
  } else if(isbuiltinfunction(var_1)) {
    if(istrue(var_2)) {
      return var_1;
    } else {
      var_4 = [[var_1]](var_0);
    }
  }

  return var_4;
}

function process_module_params(var_0, var_1) {
  var_2 = [];

  if(var_1.size < 2) {
    return var_2;
  } else {
    var_3 = spawnStruct();
    var_3.var_params = [];
    var_4 = min(var_1.size, 9);

    for(var_5 = 1; var_5 < var_4; var_5++) {
      var_6 = var_1[var_5];
      thread send_notify_after_frame_end(var_3);
      var_3.var_params[var_5 - 1] = process_module_var(var_3, var_0, var_6, 1);
    }
  }

  return var_3;
}

function send_notify_after_frame_end(var_0) {
  self endon("death");
  waittillframeend();
  self notify(var_0);
}

function run_modular_spawning_func(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    var_3 = var_2;
  } else {
    var_3 = self;
  }

  if(!isDefined(var_2.var_params)) {
    return var_3[[var_1]](self);
  }

  if(var_2.var_params.size == 1) {
    return var_3[[var_1]](self, return_undefined_param_if_empty(var_2.var_params[0]));
  }

  if(var_2.var_params.size == 2) {
    return var_3[[var_1]](self, return_undefined_param_if_empty(var_2.var_params[0]), return_undefined_param_if_empty(var_2.var_params[1]));
  }

  if(var_2.var_params.size == 3) {
    return var_3[[var_1]](self, return_undefined_param_if_empty(var_2.var_params[0]), return_undefined_param_if_empty(var_2.var_params[1]), return_undefined_param_if_empty(var_2.var_params[2]));
  }

  if(var_2.var_params.size == 4) {
    return var_3[[var_1]](self, return_undefined_param_if_empty(var_2.var_params[0]), return_undefined_param_if_empty(var_2.var_params[1]), return_undefined_param_if_empty(var_2.var_params[2]), return_undefined_param_if_empty(var_2.var_params[3]));
  }

  if(var_2.var_params.size == 5) {
    return var_3[[var_1]](self, return_undefined_param_if_empty(var_2.var_params[0]), return_undefined_param_if_empty(var_2.var_params[1]), return_undefined_param_if_empty(var_2.var_params[2]), return_undefined_param_if_empty(var_2.var_params[3]), return_undefined_param_if_empty(var_2.var_params[4]));
  }

  if(var_2.var_params.size == 6) {
    return var_3[[var_1]](self, return_undefined_param_if_empty(var_2.var_params[0]), return_undefined_param_if_empty(var_2.var_params[1]), return_undefined_param_if_empty(var_2.var_params[2]), return_undefined_param_if_empty(var_2.var_params[3]), return_undefined_param_if_empty(var_2.var_params[4]), return_undefined_param_if_empty(var_2.var_params[5]));
  }

  if(var_2.var_params.size == 7) {
    return var_3[[var_1]](self, return_undefined_param_if_empty(var_2.var_params[0]), return_undefined_param_if_empty(var_2.var_params[1]), return_undefined_param_if_empty(var_2.var_params[2]), return_undefined_param_if_empty(var_2.var_params[3]), return_undefined_param_if_empty(var_2.var_params[4]), return_undefined_param_if_empty(var_2.var_params[5]), return_undefined_param_if_empty(var_2.var_params[6]));
  }

  if(var_2.var_params.size == 8) {
    return var_3[[var_1]](self, return_undefined_param_if_empty(var_2.var_params[0]), return_undefined_param_if_empty(var_2.var_params[1]), return_undefined_param_if_empty(var_2.var_params[2]), return_undefined_param_if_empty(var_2.var_params[3]), return_undefined_param_if_empty(var_2.var_params[4]), return_undefined_param_if_empty(var_2.var_params[5]), return_undefined_param_if_empty(var_2.var_params[6]), return_undefined_param_if_empty(var_2.var_params[7]));
  }

  return undefined;
}

function return_undefined_param_if_empty(var_0) {
  if(isDefined(var_0)) {
    if(isstring(var_0) && var_0 == "empty") {
      return undefined;
    }

    return var_0;
  }

  return undefined;
}

function resetgroupvariables() {
  level endon("game_ended");
  self waittill("death");
  self.currentmodulekills = 0;
  level.requested_spawns_groups[self.moduleid] = undefined;
}

function spawn_ai(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    change_module_status(var_3, undefined, "attempt spawn_ai");
  }

  var_4 = self.origin;
  var_5 = self.angles;

  if(isDefined(var_0)) {
    var_4 = var_0;
  }

  if(isDefined(var_1)) {
    var_5 = (0, var_1[1], 0);
  }

  var_6 = undefined;
  var_7 = undefined;

  if(isDefined(var_3) && isDefined(var_3.spawn_aitype_counts) && var_3.spawn_aitype_counts.size > 0 && !isDefined(self.vehicle)) {
    var_6 = choose_and_decrement_from_aitype_list(var_3);
    var_7 = level.aitypes[var_6].agent_type;
  } else if(isDefined(var_3) && isDefined(var_3.aitype_override) && var_3.aitype_override.size && !isDefined(self.vehicle)) {
    var_8 = weighted_array_randomize(var_3.aitype_override, var_3.aitype_override_weights);
    var_7 = level.aitypes[var_8].agent_type;
    var_6 = var_8;
  } else if(isDefined(level.aitype_override) && level.aitype_override.size && !isDefined(self.vehicle)) {
    var_8 = weighted_array_randomize(level.aitype_override, level.aitype_override_weights);
    var_7 = level.aitypes[var_8].agent_type;
    var_6 = var_8;
  } else if(isDefined(var_2)) {
    var_7 = level.aitypes[var_2].agent_type;
    var_6 = var_2;
  } else {
    var_9 = get_aitypes_from_spawner();
    var_8 = scripts\engine\utility::random(var_9);
    var_7 = level.aitypes[var_8].agent_type;
    var_6 = var_8;
  }

  if(isDefined(level.playerisprop)) {
    var_8 = scripts\engine\utility::random(level.playerisprop);

    if(isDefined(level.aitypes[var_8]) && isDefined(level.aitypes[var_8].agent_type)) {
      var_7 = level.aitypes[var_8].agent_type;
      var_6 = var_8;
    }
  }

  var_10 = undefined;

  if(istrue(level.playerismatchpending) || is_armored()) {
    if(isDefined(level.aitypes[var_6 + "_heavy"]) && isDefined(level.aitypes[var_6 + "_heavy"].agent_type)) {
      var_7 = level.aitypes[var_6 + "_heavy"].agent_type;
      var_6 += "_heavy";
      var_10 = 1;
    }
  }

  if(!isDefined(var_7)) {
    var_8 = scripts\engine\utility::random(level.random_aitype_list);
    var_7 = level.aitypes[var_8].agent_type;
    var_6 = var_8;
  }

  var_11 = var_7;

  if(isDefined(var_3)) {
    change_module_status(var_3, undefined, "Chose agent_type");
  }

  if(isDefined(var_3)) {
    change_module_status(var_3, undefined, "In Spawn Queue");
  }

  enter_spawn_queue();
  self.aitype = var_6;
  self.agent_type = var_7;

  if(isDefined(var_3) && istrue(var_3.min_spawn_requested)) {
    var_12 = undefined;
    change_module_status(var_3, undefined, "Force Spawn Loop");

    for(;;) {
      var_12 = scripts\mp\mp_agent::spawnnewagentaitype(var_11, var_4, var_5);

      if(isDefined(var_12)) {
        break;
      }

      waitframe();
    }

    var_3.min_spawn_requested = undefined;

    if(get_reserved_slot_count_by_string_id(var_3.moduleid) > 0) {
      decrease_reserved_spawn_slots(1, var_3.moduleid);
    }
  } else {
    if(isDefined(var_4)) {
      change_module_status(var_4, undefined, "Spawn Attempt");
    }

    var_12 = scripts\mp\mp_agent::spawnnewagentaitype(var_12, var_5, var_6);
  }

  if(isDefined(var_12) && istrue(var_11)) {
    var_12.equip_armor = 1;
  }

  return var_12;
}

function triggerenterfunc(var_0, var_1) {
  return var_0 >= var_1;
}

function choose_and_decrement_from_aitype_list() {
  var_0 = getarraykeys(self.spawn_aitype_counts);

  foreach(var_2 in var_0) {
    if(isDefined(self.spawn_aitype_counts[var_2]) && isint(self.spawn_aitype_counts[var_2]) && triggerenterfunc(self.spawn_aitype_counts[var_2], 1)) {
      for(var_3 = 0; var_3 < level.spawn_module_structs_memory[self.group_name].size; var_3++) {
        var_4 = level.spawn_module_structs_memory[self.group_name][var_3];

        if(isDefined(var_4.spawn_aitype_counts[var_2])) {
          var_4.spawn_aitype_counts[var_2]--;

          if(var_4.spawn_aitype_counts[var_2] <= 0) {
            var_4.spawn_aitype_counts[var_2] = undefined;
          }
        }
      }

      var_5 = level.aitypes[var_2].agent_type;
      var_6 = var_2;
      return var_6;
    }
  }

  var_4 = undefined;
  var_6 = undefined;
  return undefined;
}

function weighted_array_randomize(var_0, var_1) {
  var_2 = 0;

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_2 += var_1[var_3];
  }

  var_4 = randomfloat(var_2);
  var_5 = 0;

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_5 += var_1[var_3];

    if(var_5 >= var_4) {
      return var_0[var_3];
    }
  }
}

function enter_spawn_queue() {
  level endon("game_ended");
  level.spawn_queue++;

  if(level.spawn_queue > 1) {
    wait level.spawn_queue * 0.05;
  }

  level.spawn_queue--;
}

function start_patrol() {
  self endon("death");
  self notify("start_patrol");
  self endon("start_patrol");
  self endon("enter_combat");
  level endon("game_ended");
  thread enter_combat_after_stealth();

  if(isDefined(self.script_linkto)) {
    thread go_to_node(get_next_node_array());
    return;
  }

  if(isDefined(self.spawnpoint.target) || isDefined(self.spawnpoint.script_linkto) && !is_door_spawn()) {
    thread go_to_node(get_next_node_array(self.spawnpoint));
    return;
  }

  if(should_roam()) {
    thread patrol_using_cover_nodes();
    return;
  }
}

function patrol_using_cover_nodes() {
  self endon("enter_combat");
  self endon("death");

  if(!isDefined(self.dot_override)) {
    self.dot_override = 0;
  }

  if(self.goalradius < 256) {
    var_0 = 1024;
  } else {
    var_0 = self.goalradius;
  }

  set_goal_radius(64);
  var_1 = 64;
  var_2 = 256;
  var_3 = undefined;
  var_4 = undefined;
  jumpiffalse(isDefined(self.script_goalheight)) LOC_00000065;
  var_2 = int(self.script_goalheight);

  for(;;) {
    if(isDefined(self.script_origin_other)) {
      var_5 = self.script_origin_other;
    } else {
      var_5 = self.origin;
    }

    if(istrue(self.find_new_patrol)) {
      wait 0.25;
      continue;
    }

    var_6 = -1;
    var_4 = undefined;
    var_7 = undefined;
    var_8 = getnodesinradiussorted(var_5, var_0, var_1, var_2, "all");
    var_9 = [];

    if(isDefined(var_8) && var_8.size > 0) {
      for(var_10 = 0; var_10 < var_8.size; var_10++) {
        if(isDefined(var_3) && var_8[var_10] == var_3) {
          continue;
        }

        if(isDefined(showcinematicletterboxing(var_8[var_10]))) {
          continue;
        }

        if(isDefined(self.dot_override)) {
          var_11 = self.angles + (0, self.dot_override, 0);
        } else {
          var_11 = self.angles;
        }

        var_12 = scripts\engine\math::get_dot(self.origin, var_11, var_8[var_10].origin);

        if(var_12 < 0.3) {
          if(var_12 > var_6) {
            var_4 = var_8[var_10];
            var_6 = var_12;
          }

          continue;
        }

        var_9 = var_8[var_10];
      }
    }

    if(var_9.size > 0) {
      var_7 = get_least_used_from_array(var_9);
    }

    var_13 = gettime();

    if(isDefined(var_7)) {
      self.dot_override = undefined;
      var_3 = var_7;
      go_to_node(var_7);
      var_14 = gettime();

      if(var_14 <= var_13) {
        waitframe();
      }

      continue;
    }

    if(isDefined(var_4)) {
      self.dot_override = undefined;
      var_3 = var_4;
      go_to_node(var_4);
      var_14 = gettime();

      if(var_14 <= var_13) {
        waitframe();
      }

      continue;
    }

    wait 1;
  }
}

function enter_combat_after_stealth(var_0) {
  if(scripts\cp\coop_stealth::ref_132d7()) {
    return;
  }

  self notify("enter_combat_after_stealth");
  self endon("enter_combat_after_stealth");
  self endon("death");
  self endon("enter_combat");
  var_1 = [];
  var_2 = [];
  var_3 = undefined;

  if(isDefined(self.team)) {
    if(isDefined(self.group) && self.group scripts\engine\utility::ent_flag_exist("weapons_free") && !self.group scripts\engine\utility::ent_flag("weapons_free")) {
      if(self.team == "allies") {
        var_2 = [self, level];
        scripts\engine\utility::waittill_any_ents_array(var_2, "damage", "stealth_combat", "stealth_over", "weapons_free", "bulletwhizby");
      } else if(istrue(self.aggressive)) {
        return;
      } else if(is_pacifist()) {
        var_2 = [self, self.group, level];
        scripts\engine\utility::waittill_any_ents_array(var_2, "weapons_free", "saw_death");
      } else {
        var_2 = [self, self.group, level];
        var_3 = scripts\engine\utility::waittill_any_ents_return(level, "weapons_free", self.group, "weapons_free", self, "saw_death", self, "known_event");
      }
    }
  }

  if(isDefined(level.enter_combat_flag) && !scripts\engine\utility::flag(level.enter_combat_flag)) {
    scripts\engine\utility::flag_set(level.enter_combat_flag);
  }

  thread enter_combat();
}

function set_default_spawner_values() {
  self.lastspawntime = gettime();
}

function set_default_values(var_0, var_1, var_2, var_3) {
  self endon("death");

  if(!is_specified_unittype("civilian") && (is_pacifist() || is_patroller())) {
    thread watch_for_ai_events();
  }

  if(isDefined(var_0) && isDefined(var_0.groupname)) {
    self.groupname = var_0.groupname;
  }

  set_kill_off_time();

  if(isDefined(self.script_radius)) {
    set_goal_radius(self.script_radius);
  } else {
    set_goal_radius(2048);
  }

  if(isDefined(self.script_goalheight)) {
    self.goalheight = self.script_goalheight;
  } else {
    self.goalheight = 256;
  }

  self.og_goalradius = self.goalradius;
  self.spawnpoint = var_1;
  self.qsetgoalpos = 1;
  self.spawn_parameter_array = var_2;

  if(istrue(self.equip_helmet) || is_juggernaut_aitype()) {
    give_soldier_helmet();
  }

  if(is_armored() || is_juggernaut_aitype()) {
    give_soldier_armor();
  }

  stoppingpower_getweaponhcrdata();
}

function ref_12ddc(var_0, var_1, var_2, var_3) {
  self endon("death");
  thread watch_for_bad_path();

  if(isDefined(var_3)) {
    join_module_group(var_3, self);
  }

  if(isDefined(level.global_ai_func_array) && level.global_ai_func_array.size > 0) {
    if(isDefined(self.team) && self.team == "axis") {
      var_4 = self.team;

      for(var_5 = 0; var_5 < level.global_ai_func_array[var_4].size; var_5++) {
        var_6 = level.global_ai_func_array[var_4][var_5];

        if(isDefined(var_6["param4"])) {
          self thread[[var_6["function"]]](var_6["param1"], var_6["param2"], var_6["param3"], var_6["param4"]);
          continue;
        }

        if(isDefined(var_6["param3"])) {
          self thread[[var_6["function"]]](var_6["param1"], var_6["param2"], var_6["param3"]);
          continue;
        }

        if(isDefined(var_6["param2"])) {
          self thread[[var_6["function"]]](var_6["param1"], var_6["param2"]);
          continue;
        }

        if(isDefined(var_6["param1"])) {
          self thread[[var_6["function"]]](var_6["param1"]);
          continue;
        }

        self thread[[var_6["function"]]]();
      }
    }
  }

  if(!is_specified_unittype("civilian") && (is_pacifist() || is_patroller())) {
    thread watch_for_ai_events();
  }

  if(isDefined(level.enemy_monitor_func)) {
    self thread[[level.enemy_monitor_func]](self.unittype);
    return;
  }
}

function stoppingpower_getweaponhcrdata() {
  self.dropweapon = 0;

  if(!isDefined(self.sidearm)) {
    self.sidearm = isundefinedweapon();
  }

  scripts\common\utility::initweapon(self.primaryweapon);
  scripts\common\utility::initweapon(self.sidearm);

  if(!is_specified_unittype("civilian")) {
    scripts\anim\shared::placeweaponon(self.primaryweapon, "primary");
    scripts\anim\shared::placeweaponon(self.sidearm, "sidearm");
    scripts\cp\utility::set_battlechatter(1);
    return;
  }
}

function set_kill_off_time(var_0) {
  if(isDefined(var_0)) {
    var_1 = var_0 * 1000;
  } else if(isDefined(self.group) && isDefined(self.group.kill_off_time_override)) {
    var_1 = self.group.kill_off_time_override * 1000;
  } else if(isDefined(self.spawnpoint) && isDefined(self.spawnpoint.script_timer)) {
    var_1 = self.spawnpoint.script_timer * 1000;
  } else if(isDefined(self.group) && istrue(self.group.cqb_module)) {
    var_1 = 2500000;
  } else {
    var_1 = 20000;
  }

  var_2 = gettime() + var_1;

  if(!isDefined(self.killofftime) || var_2 > self.killofftime) {
    self.killofftime = var_2;
  }

  if(istrue(self.entered_combat)) {
    var_3 = var_1 / 1000;
    thread add_to_kill_off_list(var_3);
    return;
  }

  remove_from_kill_off_list();
}

function add_to_kill_off_list(var_0) {
  self notify("add_to_kill_off_list");
  self endon("add_to_kill_off_list");
  self endon("death");
  remove_from_kill_off_list();
  wait var_0;

  if(isDefined(self.entity_number)) {
    level.can_kill_off_list[self.entity_number] = self;
  } else {
    level.can_kill_off_list[self getentitynumber()] = self;
  }

  if(level.can_kill_off_list.size == 1) {
    thread passive_kill_off_loop();
    return;
  }
}

function passive_kill_off_loop() {
  level notify("stop_kill_off_loop");
  level endon("stop_kill_off_loop");
  level endon("game_ended");
  var_0 = level.frameduration / 1000;

  for(;;) {
    var_1 = 1;
    var_2 = getarraykeys(level.can_kill_off_list);

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      if(!isDefined(level.can_kill_off_list[var_2[var_3]])) {
        continue;
      }

      var_4 = thread passive_kill_off_ai();

      if(!isDefined(var_4) || var_4) {
        if(var_1 > var_0) {
          var_1 -= var_0;
        }

        waitframe();
      }
    }

    wait var_1;
  }
}

function passive_kill_off_ai(var_0) {
  if(!isalive(self)) {
    return false;
  }

  if(self.health < 1) {
    return false;
  }

  if(has_dont_kill_off_flag()) {
    return false;
  }

  if(istrue(scripts\engine\utility::script_func("ai_is_carrying_hvt", self))) {
    return false;
  }

  if(istrue(self.attempting_teleport)) {
    return false;
  }

  if(istrue(self.playing_skit)) {
    return false;
  }

  if(is_specified_unittype("juggernaut")) {
    return false;
  }

  if(istrue(self.tripledefenderkill)) {
    set_kill_off_time(20);
    return false;
  }

  if(!istrue(self.playeriszombie)) {
    if(is_riding_vehicle()) {
      return false;
    }

    if(isDefined(self.enemy) && self canshootenemy()) {
      return false;
    }
  }

  var_1 = get_see_recently_time_overrides();

  if(isDefined(self.group) && istrue(self.group.cqb_module)) {
    var_2 = 2250000;
  } else {
    var_2 = 25000000;
  }

  for(var_3 = 0; var_3 < level.players.size; var_3++) {
    var_4 = level.players[var_3];

    if(distancesquared(var_4.origin, self.origin) < var_2) {
      return false;
    }

    if(self seerecently(var_4, var_2)) {
      return false;
    }
  }

  if(!vo_nag_hangar()) {
    if(!istrue(var_1)) {
      return true;
    }
  }

  teleport_to_nearby_spawner("Passive Kill-Off", undefined, 0);
  return true;
}

function vo_nag_hangar() {
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    var_1 = level.players[var_0];

    if(self hastacvis(var_1, 0, 64, 1)) {
      return false;
    }

    if(var_1 hastacvis(self, 0, 64, 1)) {
      return false;
    }
  }

  var_2 = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 1);
  var_3 = self getapproxeyepos();

  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    var_4 = level.players[var_0];

    if(scripts\engine\trace::ray_trace_passed(var_4 getEye(), var_3, [var_4, self], var_2)) {
      return false;
    }
  }

  return true;
}

function is_riding_vehicle() {
  return isDefined(self.ridingvehicle);
}

function is_specified_unittype(var_0) {
  return isDefined(self.unittype) && self.unittype == var_0;
}

function is_juggernaut_aitype() {
  return isDefined(self.unittype) && self.unittype == "juggernaut";
}

function set_default_rpg_values() {
  self endon("death");
  wait 0.5;
  set_goal_radius(150);
  self.og_goalradius = self.goalradius;
  self.rocketammo = 100;
}

function suicide_bomber_combat_func(var_0) {
  thread ref_13791();

  if(isDefined(level.suicide_bomber_combat_func)) {
    self thread[[level.suicide_bomber_combat_func]]();
    return;
  }

  thread juggernaut_state();
}

function ref_13791() {
  self endon("death");
  self.suicidebomberchants = 0;
  wait 3;
  var_0 = self.origin;

  while(distance(var_0, self.origin) < 750) {
    self.suicidebomberchants = 0;
    wait 0.5;
  }

  self.suicidebomberchants = 1;
  thread scripts\aitypes\suicidebomber\combat::dochants();
}

function juggernaut_state() {
  self endon("death");

  for(;;) {
    prepickupweapon();

    if(isDefined(self.enemy)) {
      if(isDefined(self.enemy.vehicle_riding_on)) {
        self.bombertarget = self.enemy.vehicle_riding_on;
      } else {
        self.bombertarget = undefined;
      }
    }

    wait 1;
  }
}

function setup_informant() {
  self.ignoreall = 1;
  self.goalradius = 4;
  self.goalheight = 32;
  self.combatmode = "no_cover";
  self allowedstances("stand");
}

function set_default_sniper_values() {
  self endon("death");
  self.no_fallback = 1;
  wait 0.5;
  set_goal_radius(250);
  self.og_goalradius = self.goalradius;
}

function assign_soldier_spec(var_0, var_1) {
  if(isDefined(var_0) && isDefined(level.soldier_agent_specialize_func)) {
    if(isDefined(level.soldier_agent_specialize_func[var_0])) {
      var_1[[level.soldier_agent_specialize_func[var_0]]]();

      if(isDefined(var_1.spec)) {
        level.spawned_enemy_types[var_1.spec]++;
        return;
      }

      return;
    }

    return;
  }
}

function attempt_to_join_squad() {
  if(isDefined(self.script_goalvolume)) {
    return;
  }

  if(is_no_squad()) {
    return;
  }

  if(scripts\anim\utility_common::islongrangeai()) {
    return;
  }

  if(isDefined(self.unittype) && self.unittype == "juggernaut") {
    return;
  }

  level.squad_max_size = getdvarint("scr_squad_max", 4);
  level.squad_leader_group_size = getdvarint("scr_squad_leader_max", 2);
  scripts\cp\cp_squadmanager::addtosquad();
}

function run_spawner_post_spawn_actions(var_0) {
  if(isDefined(var_0) && isDefined(self.post_spawn_spawner_funcs)) {
    foreach(var_2 in self.post_spawn_spawner_funcs) {
      self[[var_2]](var_0);
    }

    return;
  }
}

function run_ai_post_spawn_actions() {
  if(isDefined(self.spawnpoint.post_spawn_ai_funcs)) {
    foreach(var_1 in self.spawnpoint.post_spawn_ai_funcs) {
      self[[var_1]]();
    }

    return;
  }
}

function join_module_group(var_0, var_1) {
  var_1.enemy_group = var_0.group_name;
  var_1.moduleid = var_0.moduleid;
  var_1.group = var_0;
  var_1.group.activecount++;
  var_1.group.spawn_count++;
  var_0.ai_spawned[var_0.ai_spawned.size] = var_1;
  var_0 thread scripts\cp\utility::add_to_notify_queue("spawned_group_soldier", var_1);

  if(isDefined(var_0.threatbiasoverride)) {
    var_1.threatbiasoverride = var_0.threatbiasoverride;
  }

  if(isDefined(var_0.ai_spawn_func)) {
    for(var_2 = 0; var_2 < var_0.ai_spawn_func.size; var_2++) {
      thread process_module_var(var_1, var_0, var_0.ai_spawn_func[var_2], undefined);
    }

    return;
  }
}

function last_spawn_time() {
  if(isDefined(self.lastspawntime)) {
    return self.lastspawntime;
  }

  return gettime();
}

function set_spawner_init_flag() {
  add_to_spawner_flags(1);
}

function is_spawner_initialized() {
  return isDefined(self.spawner_flags) && self.spawner_flags & 1;
}

function spawner_init() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(is_spawner_initialized()) {
    return;
  }

  set_spawner_init_flag();
  remove_default_kvps();
  ref_130e8();

  if(!trying_to_spawn_boss()) {
    remove_from_spawner_flags(4);
    remove_from_spawner_flags(2);
    return;
  }

  spawn_is_vehicle_spawn(self);
  self.lastspawntime = 0;

  if(isstruct(self) && isDefined(self.spawnflags)) {
    self.spawnflags = int(self.spawnflags);
  }

  if(isDefined(self.script_parent)) {
    var_0 = scripts\engine\utility::getStructArray(self.script_parent, "targetname");

    if(var_0.size > 0) {
      self.child_spawners = [];
      self.child_spawners = var_0;
      init_cluster_parent();
      scripts\engine\utility::array_thread(var_0, &spawner_init);
      return;
    }

    return;
  }

  var_1 = 2;
  var_2 = 64;
  var_3 = 128;
  var_4 = 256;

  if(!isnode(self) && isDefined(self.spawnflags)) {
    if(!isint(self.spawnflags)) {
      self.spawnflags = int(self.spawnflags);
    }

    if(self.spawnflags &var_1) {
      self.equip_armor = 1;
    }

    if(self.spawnflags &var_2) {
      add_to_spawner_flags(512);
      self.is_on_platform = 1;
    }

    if(!istrue(scripts\cp\cp_vehicles::is_vehicle_spawnpoint())) {
      var_5 = 8;

      if(self.spawnflags &var_5) {
        self.dont_enter_combat = 1;
      }
    }
  }

  if(isDefined(self.script_count) || isDefined(self.script_timeout)) {
    self.post_spawn_spawner_funcs = [];
    self.post_spawn_spawner_funcs[self.post_spawn_spawner_funcs.size] = &spawner_disable_after_count;
  }

  get_aitype_settings();
}

function trying_to_spawn_boss() {
  var_0 = "^0";
  var_1 = "^1";
  var_2 = "^2";
  var_3 = "^3";
  var_4 = "^4";
  var_5 = "^5";
  var_6 = "^6";
  var_7 = "^7";
  var_8 = "^8";
  var_9 = "^9";
  var_10 = var_1 + "SPAWNER DISABLED: ";

  if(isDefined(self.targetname)) {
    var_11 = var_0 + "targetname = (" + self.targetname + ")";
  } else {
    var_11 = "";
  }

  var_12 = scripts\engine\utility::ter_op(isstruct(self), var_1 + "(struct) " + var_11 + var_4 + "spawner", var_1 + "(node)" + var_11 + var_4 + " spawner");

  if(isDefined(self.script_difficulty) && level.gameskill <= 1 && scripts\engine\utility::is_equal(self.script_difficulty, "hard")) {
    little_bird_mg_givetakegunnerturrettimeout();
    return false;
  }

  var_13 = scripts\cp\cp_vehicles::is_vehicle_spawnpoint();

  if(!spawner_flags_check(4)) {
    if(isDefined(self.origin)) {
      var_14 = getgroundposition(self.origin, 1, 100, 16);

      if(var_13) {
        if(!isDefined(self.ref_133bb) && !ispointonnavmesh(var_14)) {
          little_bird_mg_givetakegunnerturrettimeout();
          return false;
        } else {
          return true;
        }
      } else {
        var_14 = self.origin;
      }

      var_15 = getclosestpointonnavmesh(var_14);

      if(distance2dsquared(var_15, self.origin) <= 4096) {
        if(isstruct(self)) {
          var_15 = scripts\engine\utility::drop_to_ground(var_15, 32, -1000);
          self.origin = var_15;
        }
      } else {
        little_bird_mg_givetakegunnerturrettimeout();
        return false;
      }
    } else {
      little_bird_mg_givetakegunnerturrettimeout();
      return false;
    }
  }

  return true;
}

function little_bird_mg_givetakegunnerturrettimeout() {
  add_to_spawner_flags(1024);
}

function mounted() {
  remove_from_spawner_flags(1024);
}

function ref_130e8() {
  if(isDefined(self.spawnflags) && !isnode(self)) {
    var_0 = int(self.spawnflags);
    var_1 = 16;
    var_2 = 8;

    if(var_0 &var_1) {
      define_spawner("vehicle_spawner");
    }

    if(var_0 &var_2) {
      define_spawner("vehicle_spawner");
    }
  }

  if(isDefined(self.script_parent)) {
    var_3 = scripts\engine\utility::getStructArray(self.script_parent, "targetname");

    if(var_3.size > 0) {
      define_spawner("cluster_spawner");
      return;
    }

    return;
  }
}

function remove_default_kvps() {
  if(scripts\engine\utility::is_equal(self.target, "default")) {
    self.target = undefined;
  }

  if(scripts\engine\utility::is_equal(self.script_noteworthy, "default")) {
    self.script_noteworthy = undefined;
  }

  if(scripts\engine\utility::is_equal(self.script_forcespawn, 0)) {
    self.script_forcespawn = undefined;
  }

  if(scripts\engine\utility::is_equal(self.script_team, "axis")) {
    self.script_team = undefined;
  }

  if(scripts\engine\utility::is_equal(self.script_radius, 0)) {
    self.script_radius = undefined;
  }

  if(scripts\engine\utility::is_equal(self.script_goalheight, 0)) {
    self.script_goalheight = undefined;
  }

  if(scripts\engine\utility::is_equal(self.script_origin_other, (0, 0, 0))) {
    self.script_origin_other = undefined;
  }

  if(scripts\engine\utility::is_equal(self.script_count, 0)) {
    self.script_count = undefined;
  }

  if(scripts\engine\utility::is_equal(self.script_timeout, 0)) {
    self.script_timeout = undefined;
  }

  if(scripts\engine\utility::is_equal(self.script_dot, 0)) {
    self.script_dot = undefined;
  }

  if(scripts\engine\utility::is_equal(self.script_dist_only, 0)) {
    self.script_dist_only = undefined;
  }

  if(scripts\engine\utility::is_equal(self.script_demeanor, "default")) {
    self.script_demeanor = undefined;
  }

  if(scripts\engine\utility::is_equal(self.script_speed, 0)) {
    self.script_speed = undefined;
  }

  if(scripts\engine\utility::is_equal(self.script_linkto, "default")) {
    self.script_linkto = undefined;
  }

  if(scripts\engine\utility::is_equal(self.script_linkname, "default")) {
    self.script_linkname = undefined;
  }

  if(isDefined(self.script_unload)) {
    if(isstring(self.script_unload) && scripts\engine\utility::is_equal(self.script_unload, "-1")) {
      self.script_unload = undefined;
      return;
    }

    if(isint(self.script_unload) && scripts\engine\utility::is_equal(self.script_unload, -1)) {
      self.script_unload = undefined;
      return;
    }

    return;
  }
}

function is_door_spawn() {
  var_0 = 32;

  if(isDefined(self.spawnpoint)) {
    if(istrue(self.spawnpoint.door_spawner)) {
      return 1;
    }

    if(!isnode(self.spawnpoint) && isDefined(self.spawnpoint.spawnflags)) {
      if(self.spawnpoint.spawnflags &var_0 && !(self.spawnpoint.spawnflags & 8)) {
        if(isDefined(self.spawnpoint.script_linkto)) {
          var_1 = getEntArray(self.spawnpoint.script_linkto, "script_linkname");

          if(!isDefined(var_1) || var_1.size < 1) {
            var_1 = scripts\engine\utility::getStructArray(self.spawnpoint.script_linkto, "script_linkname");
          }

          if(isDefined(var_1) && var_1.size > 0) {
            for(var_2 = 0; var_2 < var_1.size; var_2++) {
              var_3 = var_1[var_2];

              if(isDefined(var_3.targetname) && var_3.targetname == "ai_spawn_doors") {
                if(!isDefined(self.spawnpoint.doors)) {
                  self.spawnpoint.doors = [var_3];
                } else {
                  self.spawnpoint.doors[self.spawnpoint.doors.size] = var_3;
                }

                continue;
              }

              if(isDefined(var_1[0].script_noteworthy) && var_1[0].script_noteworthy == "spawn_door_single") {
                if(!isDefined(self.spawnpoint.doors)) {
                  self.spawnpoint.doors = [var_3];
                  continue;
                }

                self.spawnpoint.doors[self.spawnpoint.doors.size] = var_3;
              }
            }

            if(isDefined(self.spawnpoint.doors) && self.spawnpoint.doors > 0) {
              self.spawnpoint.door_spawner = 1;
              return 1;
            }

            return 0;
          }

          return 0;
        }

        return 0;
      }

      return 0;
    }

    if(isDefined(self.spawnpoint.script_linkto)) {
      var_1 = getEntArray(self.spawnpoint.script_linkto, "script_linkname");

      if(!isDefined(var_1) || var_1.size < 1) {
        var_1 = scripts\engine\utility::getStructArray(self.spawnpoint.script_linkto, "script_linkname");
      }

      if(isDefined(var_1) && var_1.size > 0) {
        for(var_2 = 0; var_2 < var_1.size; var_2++) {
          var_3 = var_1[var_2];

          if(isDefined(var_3.targetname) && var_3.targetname == "ai_spawn_doors") {
            if(!isDefined(self.spawnpoint.doors)) {
              self.spawnpoint.doors = [var_3];
            } else {
              self.spawnpoint.doors[self.spawnpoint.doors.size] = var_3;
            }

            continue;
          }

          if(isDefined(var_1[0].script_noteworthy) && var_1[0].script_noteworthy == "spawn_door_single") {
            if(!isDefined(self.spawnpoint.doors)) {
              self.spawnpoint.doors = [var_3];
              continue;
            }

            self.spawnpoint.doors[self.spawnpoint.doors.size] = var_3;
          }
        }

        if(isDefined(self.spawnpoint.doors) && self.spawnpoint.doors.size > 0) {
          self.spawnpoint.door_spawner = 1;
          return 1;
        }

        return 0;
      }

      return 0;
    }

    return 0;
  }

  return 0;
}

function is_no_squad() {
  if(isDefined(self.spawnpoint)) {
    if(!isnode(self.spawnpoint) && isDefined(self.spawnpoint.spawnflags)) {
      return (self.spawnpoint.spawnflags & 1);
    }

    return 0;
  }

  return istrue(self.nosquad);
}

function is_armored() {
  if(isDefined(self.spawnpoint)) {
    if(!isnode(self.spawnpoint) && isDefined(self.spawnpoint.spawnflags)) {
      return (self.spawnpoint.spawnflags & 2);
    }

    if(istrue(self.wearing_armor)) {
      return 1;
    }

    if(istrue(self.equip_armor)) {
      return 1;
    }

    return 0;
  }

  return istrue(self.equip_armor);
}

function is_patroller() {
  if(isDefined(self.spawnpoint)) {
    if(!isnode(self.spawnpoint) && isDefined(self.spawnpoint.spawnflags)) {
      return (self.spawnpoint.spawnflags & 128);
    }

    return 0;
  }

  return istrue(self.script_patroller);
}

function is_pacifist() {
  if(istrue(self.pacifist_override)) {
    return 1;
  }

  if(isDefined(self.spawnpoint)) {
    if(!isnode(self.spawnpoint) && isDefined(self.spawnpoint.spawnflags)) {
      return (self.spawnpoint.spawnflags & 256);
    }

    return 0;
  }

  return istrue(self.script_pacifist);
}

function remove_pacifist_spawn_flag() {
  if(isDefined(self.spawnflags)) {
    if(!isnode(self.spawnpoint) && self.spawnflags & 256) {
      self.spawnflags -= 256;
      return;
    }

    return;
  }
}

function update_script_demeanor_for_all_spawners_in_group(var_0) {
  var_1 = process_module_var(self, self.spawn_points);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(isstruct(var_1[var_2])) {
      var_1[var_2].script_demeanor = var_0;
    }
  }
}

function has_dont_kill_off_flag() {
  if(isDefined(self.birthtime) && self.birthtime >= gettime()) {
    return 1;
  }

  if(has_never_kill_off_flag()) {
    return 1;
  }

  if(istrue(self.ref_133b6)) {
    return 0;
  }

  if(istrue(self.dontkilloff)) {
    return 1;
  }

  if(isDefined(self.spawnpoint)) {
    if(!isnode(self.spawnpoint) && isDefined(self.spawnpoint.spawnflags)) {
      return (self.spawnpoint.spawnflags & 1024);
    }

    return 0;
  }

  return 0;
}

function has_never_kill_off_flag() {
  if(isDefined(self.birthtime) && self.birthtime >= gettime()) {
    return 1;
  }

  if(istrue(self.never_kill_off)) {
    return 1;
  }

  if(isDefined(self.spawnpoint)) {
    if(!isnode(self.spawnpoint) && isDefined(self.spawnpoint.spawnflags)) {
      return (self.spawnpoint.spawnflags & 2048);
    }

    return 0;
  }

  return 0;
}

function should_roam() {
  if(isDefined(self.spawnpoint) && !istrue(spawn_is_vehicle_spawn(self.spawnpoint))) {
    if(!isnode(self.spawnpoint) && isDefined(self.spawnpoint.spawnflags)) {
      if(self.spawnpoint.spawnflags & 512) {
        return 0;
      }

      return 1;
    }

    return 1;
  }

  return 1;
}

function parent_spawner_disable_after_count(var_0, var_1) {
  var_0 endon("death");
  self notify("parent_spawner_disable_after_count");
  self endon("parent_spawner_disable_after_count");
  var_1 endon("spawn_failed");
  var_1 waittill("spawn_success");

  if(isDefined(self.script_count)) {
    self.script_count--;

    if(self.script_count < 1) {
      thread disable_spawn_point(self, self.script_timeout, var_0);
      return;
    }

    return;
  }

  if(isDefined(self.script_timeout)) {
    if(!isDefined(self.lastspawntime)) {
      self.lastspawntime = 0;
    }

    self.lastspawntime = gettime() + self.script_timeout * 1000 + 10000;
    return;
  }
}

function spawner_disable_after_count(var_0) {
  if(isDefined(self.script_count)) {
    self.script_count--;

    if(self.script_count < 1) {
      thread disable_spawn_point(self, self.script_timeout, var_0);
      return;
    }

    return;
  }

  if(isDefined(self.script_timeout)) {
    if(!isDefined(self.lastspawntime)) {
      spawner_init();
    }

    self.lastspawntime = gettime() + self.script_timeout * 1000 + 10000;
    return;
  }
}

function init_cluster_parent() {
  define_spawner("cluster_spawner");
}

function watch_for_nearby_disable() {
  for(;;) {
    level waittill("disable_nearby_spawners_for_time", var_0);

    if(distance2dsquared(self.origin, var_0) <= 65536) {
      set_default_spawner_values();
    }
  }
}

function init_score_data(var_0) {}

function get_ideal_dist(var_0) {
  if(!isDefined(var_0.script_noteworthy)) {
    return 1250;
  }

  if(istrue(var_0 scripts\cp\cp_vehicles::is_vehicle_spawnpoint())) {
    return 5000;
  }

  switch (var_0.script_noteworthy) {
    case "sniper":
      return 2500;
    case "ar":
      return 1250;
    case "smg":
      return 1250;
    case "shotgun":
      return 1250;
    case "rpg":
      return 1250;
    case "soldier":
      return 1250;
    case "soldier_armored":
      return 1250;
    case "soldier_armored_helmet":
      return 1250;
    case "juggernaut":
      return 1250;
    case "soldier_random":
    default:
      return 1250;
  }
}

function enemy_monitor(var_0, var_1) {
  level endon("game_ended");
  update_spawn_data_on_spawn(var_0, var_1);

  if(getdvarint("scr_dmg_enemies_water", 0) != 0) {
    thread kill_agent_when_in_water();
    return;
  }
}

function kill_agent_when_in_water() {
  self endon("death");

  for(;;) {
    var_0 = scripts\engine\trace::_bullet_trace(self.origin + (0, 0, 10), self.origin + (0, 0, -10), 0, self);
    self.hit_water = var_0["surfacetype"] == "surftype_water";

    if(istrue(self.hit_water)) {
      if(istrue(level.bshockactive)) {
        if(isDefined(level.soldiershockfunc)) {
          self[[level.soldiershockfunc]](2);
        }
      }
    }

    wait 1;
  }
}

function update_spawn_data_on_spawn(var_0, var_1) {
  var_2 = 1;

  if(isDefined(self.team)) {
    if(self.team == "axis") {
      level.spawned_enemies[level.spawned_enemies.size] = self;
      level.current_num_spawned_enemies += var_2;
    } else if(self.team == "allies") {
      level.spawned_allies[level.spawned_allies.size] = self;
    }
  }

  level.spawned_ai[level.spawned_ai.size] = self;

  if(isDefined(var_0)) {
    if(var_0 == "juggernaut") {
      level.spawned_juggernauts[level.spawned_juggernauts.size] = self;
      level.current_num_spawned_juggernauts += var_2;
    }

    if(var_0 == "soldier_agent" || var_0 == "soldier") {
      level.spawned_soldiers[level.spawned_soldiers.size] = self;
      level.current_num_spawned_soldiers += var_2;
      return;
    }

    return;
  }
}

function _update_spawn_data_on_death(var_0, var_1) {
  level endon("game_ended");
  self endon("update_spawn_data_on_death");
  self waittill("death");
  thread update_spawn_data_on_death(var_0, var_1);
}

function remove_from_kill_off_list() {
  if(isDefined(level.can_kill_off_list)) {
    if(isDefined(self.entity_number) && isDefined(level.can_kill_off_list[self.entity_number])) {
      level.can_kill_off_list[self.entity_number] = undefined;
    } else if(isDefined(level.can_kill_off_list[self getentitynumber()])) {
      level.can_kill_off_list[self getentitynumber()] = undefined;
    }

    if(level.can_kill_off_list.size < 1) {
      level notify("stop_kill_off_loop");
      return;
    }

    return;
  }
}

function update_spawn_data_on_death(var_0, var_1) {
  self notify("update_spawn_data_on_death");
  self endon("update_spawn_data_on_death");
  level endon("game_ended");
  thread remove_from_kill_off_list();

  if(!isDefined(self.group)) {
    level notify("no group defined");
  }

  var_2 = 1;

  if(isDefined(self.cargo_truck_mg_initdamage)) {
    if(isDefined(self.cargo_truck_mg_initdamage.cargo_truck_mg_gunnerdamagemodignorefunc)) {
      self.cargo_truck_mg_initdamage.cargo_truck_mg_gunnerdamagemodignorefunc--;

      if(self.cargo_truck_mg_initdamage.cargo_truck_mg_gunnerdamagemodignorefunc < 1) {
        self.cargo_truck_mg_initdamage.cargo_truck_mg_gunnerdamagemodignorefunc = 0;
      }
    }
  }

  if(isDefined(self.team)) {
    if(self.team == "axis") {
      if(scripts\engine\utility::array_contains(level.spawned_enemies, self)) {
        level.spawned_enemies = scripts\engine\utility::array_remove(level.spawned_enemies, self);
        level.current_num_spawned_enemies -= var_2;
      }
    } else if(self.team == "allies") {
      if(scripts\engine\utility::array_contains(level.spawned_allies, self)) {
        level.spawned_allies = scripts\engine\utility::array_remove(level.spawned_allies, self);
      }
    }
  }

  remove_from_enemy_list();

  if(isDefined(self.ridingvehicle)) {
    self.ridingvehicle thread scripts\cp\utility::add_to_notify_queue("passenger_died");
  }

  if(scripts\engine\utility::array_contains(level.spawned_ai, self)) {
    level.spawned_ai = scripts\engine\utility::array_remove(level.spawned_ai, self);
  }

  if(isDefined(self.group)) {
    var_3 = is_my_group_an_active_module();

    if(get_activecount_from_group(self.group) - var_2 >= 1) {
      self.group.activecount = int(clamp(self.group.activecount - var_2, 0, self.group.activecount - var_2));
    } else {
      self.group.activecount = 0;
    }

    self.group.ai_spawned = scripts\engine\utility::array_remove(self.group.ai_spawned, self);

    if(var_3) {
      if(!istrue(self.died_poorly)) {
        self.group.currentmodulekills += var_2;
      }
    } else {
      self.group.currentmodulekills += var_2;
    }

    var_4 = process_module_var(self.group, self.group.totalspawns);

    if(isDefined(var_4) && var_4 > 0) {
      if(var_3 && self.group.currentmodulekills >= var_4) {
        self.group notify("spawn_module_" + self.group.moduleid + "_completed");
        self.group notify("group_spawning_completed");
        self.group notify("reached_total_spawns");
        level notify("group_spawning_completed");

        if(get_activecount_from_group(self.group, 1) < 1) {
          scripts\cp\cp_spawning_util::ref_12bd3(self.group);
          self.group notify("all_group_spawns_dead");

          if(scripts\engine\utility::array_contains(level.spawn_module_structs_memory[self.group.group_name], self.group)) {
            level.spawn_module_structs_memory[self.group.group_name] = scripts\engine\utility::array_remove(level.spawn_module_structs_memory[self.group.group_name], self.group);

            if(isDefined(level.spawn_module_structs_memory[self.group.group_name]) && level.spawn_module_structs_memory[self.group.group_name].size < 1) {
              level.spawn_module_structs_memory[self.group.group_name] = undefined;
            }
          }
        }
      } else if(!var_3 && get_activecount_from_group(self.group, 1) < 1) {
        scripts\cp\cp_spawning_util::ref_12bd3(self.group);
        self.group notify("all_group_spawns_dead");

        if(scripts\engine\utility::array_contains(level.spawn_module_structs_memory[self.group.group_name], self.group)) {
          level.spawn_module_structs_memory[self.group.group_name] = scripts\engine\utility::array_remove(level.spawn_module_structs_memory[self.group.group_name], self.group);

          if(isDefined(level.spawn_module_structs_memory[self.group.group_name]) && level.spawn_module_structs_memory[self.group.group_name].size < 1) {
            level.spawn_module_structs_memory[self.group.group_name] = undefined;
          }
        }
      } else if(var_3 && get_activecount_from_group(self.group, 1) < 1) {
        self.group notify("active_all_group_spawns_dead");
      }
    } else if(!var_3 && get_activecount_from_group(self.group, 1) < 1) {
      scripts\cp\cp_spawning_util::ref_12bd3(self.group);
      self.group notify("all_group_spawns_dead");

      if(scripts\engine\utility::array_contains(level.spawn_module_structs_memory[self.group.group_name], self.group)) {
        level.spawn_module_structs_memory[self.group.group_name] = scripts\engine\utility::array_remove(level.spawn_module_structs_memory[self.group.group_name], self.group);

        if(isDefined(level.spawn_module_structs_memory[self.group.group_name]) && level.spawn_module_structs_memory[self.group.group_name].size < 1) {
          level.spawn_module_structs_memory[self.group.group_name] = undefined;
        }
      }
    } else if(var_3 && get_activecount_from_group(self.group, 1) < 1) {
      self.group notify("active_all_group_spawns_dead");
    }

    if(!istrue(self.died_poorly)) {
      thread run_group_death_funcs();
    } else {
      thread ref_12ddd();
    }

    if(scripts\cp\cp_spawning_util::group_has_combined_counters(self.group.group_name)) {
      var_5 = self.group scripts\cp\cp_spawning_util::propwatchdeath();

      if(isDefined(var_5)) {
        var_6 = level.hideallunselectedextractpads[var_5];

        if(isDefined(var_6) && var_6.size > 0) {
          for(var_7 = 0; var_7 < var_6.size; var_7++) {
            thread send_notify_to_groups_from_groupname(level, var_6[var_7].group_name, "activeCount_changed");
          }
        } else {
          thread send_notify_to_groups_from_groupname(level, self.group.group_name, "activeCount_changed");
        }
      } else {
        thread send_notify_to_groups_from_groupname(level, self.group.group_name, "activeCount_changed");
      }
    } else {
      thread send_notify_to_groups_from_groupname(level, self.group.group_name, "activeCount_changed");
    }
  }

  if(isDefined(self.unittype)) {
    if(isDefined(self.unittype) && self.unittype == "juggernaut") {
      level.spawned_juggernauts = scripts\engine\utility::array_remove(level.spawned_juggernauts, self);
      level.current_num_spawned_juggernauts -= var_2;
    }

    if(self.unittype == "soldier") {
      level.spawned_soldiers = scripts\engine\utility::array_remove(level.spawned_soldiers, self);
      level.current_num_spawned_soldiers -= var_2;
      return;
    }

    return;
  }
}

function toggle_force_stop_wave_from_groupname(var_0, var_1, var_2) {
  if(isDefined(level.spawn_module_structs_memory[var_0])) {
    for(var_3 = 0; var_3 < level.spawn_module_structs_memory[var_0].size; var_3++) {
      level.spawn_module_structs_memory[var_0][var_3].stop_wave_spawning = var_1;

      if(!istrue(var_1)) {
        level.spawn_module_structs_memory[var_0][var_3] notify("wave_spawn");
      }

      if(isDefined(var_2)) {
        change_module_status(level.spawn_module_structs_memory[var_0][var_3], undefined, var_2);
      }
    }

    return;
  }
}

function get_spawn_count_from_groupname(var_0) {
  var_1 = 0;

  if(isDefined(level.spawn_module_structs_memory[var_0])) {
    for(var_2 = 0; var_2 < level.spawn_module_structs_memory[var_0].size; var_2++) {
      if(isDefined(level.spawn_module_structs_memory[var_0][var_2].spawn_count)) {
        var_1 += level.spawn_module_structs_memory[var_0][var_2].spawn_count;
      }
    }
  }

  return var_1;
}

function barkov_crawl_scene_nostab(var_0) {
  var_0.spawn_count++;
}

function ref_1393e(var_0) {
  var_0.spawn_count--;
}

function reset_spawn_count_from_groupname(var_0) {
  if(isDefined(level.spawn_module_structs_memory[var_0])) {
    for(var_1 = 0; var_1 < level.spawn_module_structs_memory[var_0].size; var_1++) {
      if(isDefined(level.spawn_module_structs_memory[var_0][var_1].spawn_count)) {
        level.spawn_module_structs_memory[var_0][var_1].spawn_count = 0;
      }
    }

    return;
  }
}

function send_notify_to_groups_from_groupname(var_0, var_1, var_2, var_3) {
  if(isDefined(level.spawn_module_structs_memory[var_0])) {
    for(var_4 = 0; var_4 < level.spawn_module_structs_memory[var_0].size; var_4++) {
      var_5 = level.spawn_module_structs_memory[var_0][var_4];
      var_5 thread scripts\cp\utility::add_to_notify_queue(var_1, var_2);
    }

    return;
  }
}

function get_activecount_from_group(var_0) {
  if(istrue(self.ref_133be)) {
    return self.ref_11cb0;
  }

  var_1 = 0;

  if(!istrue(var_0) && isDefined(self.hide_rocket_fuel_readings_to_player)) {
    var_2 = level.hideallunselectedextractpads[self.hide_rocket_fuel_readings_to_player];

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_4 = var_2[var_3];

      if(isDefined(var_4.activecount)) {
        var_1 += var_4.activecount;
      }
    }
  } else if(isDefined(self.activecount)) {
    var_1 = self.activecount;
  }

  return var_1;
}

function set_wave_settings_for_all_with_groupname(var_0, var_1, var_2, var_3) {
  if(isDefined(level.active_spawn_module_structs[var_0])) {
    for(var_4 = 0; var_4 < level.active_spawn_module_structs[var_0].size; var_4++) {
      var_5 = level.active_spawn_module_structs[var_0][var_4];
      var_5.wave_reference = var_1;
      var_5.last_wave_ref = var_2;
      var_5.last_wave_num = var_3;
    }

    return;
  }
}

function toggle_teleport_enemy_info_loop(var_0) {
  self.should_teleport_to_nearby_target = 1;
}

function stay_passive_if_not_weapons_free() {
  if(!scripts\engine\utility::flag("make_ai_aggro")) {
    self.pacifist_override = 1;
    set_demeanor_from_unittype("patrol");
    enter_combat_after_stealth();
    watch_for_ai_events();
    return;
  }
}

function set_aggro_flag_on_enter_combat() {
  self endon("death");
  self notify("set_aggro_flag_on_enter_combat");
  self endon("set_aggro_flag_on_enter_combat");
  self waittill("enter_combat");
  self.group notify("weapons_free");
  level notify("spawn_module_" + self.group.moduleid + "_completed");
  scripts\engine\utility::flag_set("make_ai_aggro");
}

function pre_wave_weapons_free(var_0) {
  level notify("spawn_module_" + var_0.moduleid + "_completed");
}

function set_pre_wave_spawning_spawn_funcs(var_0) {
  if(getdvarint("scr_pre_wave_use_patrol_structs", 1)) {
    var_1 = scripts\engine\utility::getStructArray("dwn_twn_patrol_structs", "targetname");
    var_2 = scripts\engine\utility::getclosest(self.origin, var_1);

    if(isDefined(var_2) && isDefined(var_2.script_linkname)) {
      self.script_linkto = var_2.script_linkname;
    }
  } else {
    thread set_script_origin_other_to_center_of_players();
  }

  var_3 = self;
  var_3.sightmaxdistance = 2200;
  var_3.pacifist_override = 1;
  var_3 thread scripts\cp\coop_stealth::run_common_functions(var_3, 1, 1, 60, 250000);
}

function set_script_origin_other_to_center_of_players() {
  for(;;) {
    if(!isDefined(self)) {
      break;
    }

    if(istrue(self.entered_combat)) {
      break;
    }

    self.script_origin_other = scripts\cp\utility::get_center_point_of_array(level.players);
    wait 2;
  }
}

function toggle_kamikaze_for_group(var_0, var_1) {
  var_0.kamikaze = var_1;
}

function numfound() {
  if(!isDefined(self.group)) {
    var_0 = ["frag_grenade_mp", "molotov_mp", "semtex_mp", "flash_grenade_mp", "concussion_grenade_mp", "smoke_grenade_mp", "gas_mp"];
    var_1 = [0.5, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1];
  } else {
    var_0 = self.group.set_chosen_spawner_from_uid;
    var_1 = self.group.serverroomrewardroll;
  }

  var_2 = scripts\engine\utility::array_sum(var_1);
  var_3 = randomfloatrange(0, var_2);
  var_4 = 0;

  for(var_5 = 0; var_5 < var_0.size; var_5++) {
    var_4 += var_1[var_5];

    if(var_4 >= var_3) {
      self.grenadeweapon = getcompleteweaponname(var_0[var_5]);
      self.grenadeammo = 2;
      return;
    }
  }
}

function propwaitminigamehudinit(var_0) {
  if(isDefined(var_0) && isDefined(var_0.set_chosen_spawner_from_uid)) {
    return;
  }
}

function select_patrol_nine_spawners(var_0) {
  ref_12bf1();
  thread circleorigin(var_0);
}

function calloutmarkerpingvohandlerpool(var_0) {
  give_soldier_armor();
  thread circleorigin(var_0);
}

function circleorigin(var_0) {
  if(isDefined(self.script_origin_other)) {
    return;
  }

  if(istrue(self.ref_133b2)) {
    return;
  }

  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return;
  }

  self notify("basic_combat");
  self endon("basic_combat");
  level endon("game_ended");
  self endon("death");

  if(!istrue(self.entered_combat)) {
    self waittill("enter_combat");
  }

  if(isDefined(self.a) && !is_specified_unittype("juggernaut") && !istrue(self.clearsoundsubmixmpbrinfilanim)) {
    self.a.disablelongdeath = 0;
  } else {
    self.a.disablelongdeath = 1;
  }

  numfound();

  if(!scripts\cp\utility::turn_off_sniper_laser()) {
    self.maxfaceenemydist = 1200;
  }

  set_goal_radius(2048);
  var_1 = randomintrange(10, 20);
  wait var_1;

  while(istrue(self.playing_skit)) {
    wait 1;
  }

  set_goal_radius(1536);
  var_1 = randomintrange(10, 20);
  wait var_1;

  while(istrue(self.playing_skit)) {
    wait 1;
  }

  if(!scripts\cp\utility::turn_off_sniper_laser()) {
    self.aggressivemode = 1;
  }

  self.ignoresuppression = 1;
  set_goal_radius(1024);
  var_1 = randomintrange(10, 20);
  wait var_1;

  while(istrue(self.playing_skit)) {
    wait 1;
  }

  set_goal_radius(512);
}

function wave_go_kamikaze(var_0) {
  level endon("game_ended");

  if(isDefined(var_0)) {
    var_0 notify("wave_go_kamikaze");
    var_0 endon("wave_go_kamikaze");
    var_0 endon("death");

    if(isDefined(var_0.timeout_after_min_count) && var_0.timeout_after_min_count > 0) {
      scripts\cp\cp_wave_spawning::ref_13f81(0, var_0);
      thread timeout_wave(var_0);
    }
  }

  wait 1.5;
  level notify("wave_ending");
}

function ref_1451f(var_0) {
  level endon("game_ended");
  level endon("timeout_wave");
  level notify("wave_failsafe_end");
  level endon("wave_failsafe_end");

  if(!scripts\cp\utility::turn_off_sniper_laser()) {
    return;
  }

  var_1 = 0;
  var_2 = 45;
  var_3 = int(var_2 / 2);

  for(;;) {
    var_4 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

    if(var_4.size == 0) {
      var_1++;
    }

    if(var_1 >= var_2) {
      break;
    }

    wait 1;
  }

  scripts\cp\cp_wave_spawning::ref_13f81(0, var_0);
  thread timeout_wave(var_0);
}

function timeout_wave(var_0) {
  level endon("game_ended");
  level notify("timeout_wave");
  level endon("timeout_wave");
  self endon("death");
  setomnvar("cp_countdown_color", 0);

  if(getdvarint("scr_wave_time_set", -1) != -1) {
    var_0 = getdvarint("scr_wave_time_set", -1);
  }

  if(isDefined(level.ref_14529) && level.ref_14529 > 10) {
    var_0 = level.ref_14529;
  }

  notify_all_groups_in_module(self.group_name, "threshold_timeout");
  toggle_force_stop_wave_from_groupname(self.group_name, 1, "wave_delay");
  toggle_force_stop_wave_from_groupname("wave_paratroopers", 1, "wave_delay");
  wave_cooldown_time(var_0);
  scripts\cp\cp_wave_spawning::ref_13f81(0, self);

  if(!istrue(self.disable_wave_hud)) {
    wait 0.1;

    for(var_1 = 0; var_1 < level.players.size; var_1++) {
      level.players[var_1] thread scripts\cp\vehicles\vehicle_compass_cp::ref_12003();
      level.players[var_1] thread scripts\cp\cp_hud_message::showsplash("cp_wave_ended", level.logfriendlyfire, undefined);

      if(level.logfriendlyfire >= 20) {
        thread playerhudupdatenumconsumed();
      }
    }
  }

  if(scripts\cp\utility::turn_off_sniper_laser()) {
    thread ref_14521();

    if(var_0 > 10.1) {
      wait var_0 - 10;

      for(var_1 = 0; var_1 < 10; var_1++) {
        setomnvar("cp_countdown_color", 2);
        wait 1;
      }
    } else {
      wait var_0;
    }
  } else {
    wait var_0;
  }

  setomnvar("cp_wave_timer", 0);
  scripts\cp\cp_wave_spawning::increase_wave_num();
  run_func_on_group_by_groupname(self.group_name, [ &toggle_kamikaze_for_group, undefined]);
  toggle_force_stop_wave_from_groupname(self.group_name, undefined, "new_wave_starting");
  toggle_force_stop_wave_from_groupname("wave_paratroopers", undefined, "new_wave_starting");
}

function ref_14521() {
  wait 2.5;
  level notify("timeout_wave_complete");
}

function playerhudupdatenumconsumed() {
  self notify("force_give_wave_completion");
  self endon("force_give_wave_completion");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    scripts\mp\ammorestock::ref_12062();
    wait 5;
  }
}

function notify_all_groups_in_module(var_0, var_1) {
  if(isDefined(level.spawn_module_structs_memory[var_0])) {
    for(var_2 = 0; var_2 < level.spawn_module_structs_memory[var_0].size; var_2++) {
      level.spawn_module_structs_memory[var_0][var_2] notify(var_1);
    }

    return;
  }
}

function group_wait_for_activecount_notify(var_0) {
  self endon("death");
  self endon("threshold_timeout");

  for(;;) {
    self waittill("activeCount_changed", var_1);

    if(getdvarfloat("scr_wave_threshold_timeout", 0) != 0) {
      GscBinSkip4(0x35, getdvarfloat("scr_wave_threshold_timeout"));
    }

    if(var_1 <= var_0) {
      self notify("start_threshold_timeout");
      break;
    }
  }
}

function start_threshold_timeout(var_0) {
  self notify("start_threshold_timeout");
  self endon("start_threshold_timeout");
  wait var_0;
  self notify("threshold_timeout");
}

function run_group_death_funcs() {
  if(isDefined(self.group) && isDefined(self.group.ai_death_func)) {
    for(var_0 = 0; var_0 < self.group.ai_death_func.size; var_0++) {
      self thread[[self.group.ai_death_func[var_0]]]();
    }

    return;
  }
}

function is_my_group_an_active_module() {
  var_0 = getarraykeys(level.active_spawn_module_structs);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = level.active_spawn_module_structs[var_0[var_1]];

    if(isarray(var_2)) {
      for(var_3 = 0; var_3 < var_2.size; var_3++) {
        if(var_2[var_3] == self.group) {
          return true;
        }
      }

      continue;
    }

    if(var_2 == self.group) {
      return true;
    }
  }

  return false;
}

function get_total_reserved_slot_count() {
  var_0 = 0;

  foreach(var_2 in level.reserved_spawn_slots) {
    var_0 += var_2;
  }

  return var_0;
}

function get_reserved_slot_count_by_string_id(var_0) {
  if(isDefined(var_0) && isDefined(level.reserved_spawn_slots[var_0])) {
    return level.reserved_spawn_slots[var_0];
  }

  return 0;
}

function increase_reserved_spawn_slots(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    if(!isDefined(level.reserved_spawn_slots[var_1])) {
      level.reserved_spawn_slots[var_1] = 0;
    }
  } else {
    var_1 = "default";
  }

  level.reserved_spawn_slots[var_1] += var_0;
  allowed_to_spawn_agent(var_2, 1, level.reserved_spawn_slots[var_1], var_1);
}

function decrease_reserved_spawn_slots(var_0, var_1) {
  if(isDefined(var_1)) {
    if(isDefined(level.reserved_spawn_slots[var_1])) {
      var_2 = level.reserved_spawn_slots[var_1];
      level.reserved_spawn_slots[var_1] = int(clamp(var_2 - var_0, 0, var_2 - var_0));

      if(level.reserved_spawn_slots[var_1] < 1) {
        level.reserved_spawn_slots[var_1] = undefined;
        return;
      }

      return;
    }

    return;
  }

  var_1 = "default";

  if(isDefined(level.reserved_spawn_slots[var_1])) {
    var_2 = level.reserved_spawn_slots[var_1];
    level.reserved_spawn_slots[var_1] = int(clamp(var_2 - var_0, 0, var_2 - var_0));

    if(level.reserved_spawn_slots[var_1] < 1) {
      level.reserved_spawn_slots[var_1] = undefined;
      return;
    }

    return;
  }
}

function increase_delayed_spawn_slots(var_0) {
  level.delayed_spawn_slots += var_0;
}

function decrease_delayed_spawn_slots(var_0) {
  level.delayed_spawn_slots -= var_0;
}

function fake_flashlight(var_0) {
  self notify("fake_flashlight");
  self endon("fake_flashlight");
  self endon("death");

  if(getdvarint("disable_enemy_flashlight", 0) != 0) {
    return;
  }

  wait 0.25;
  var_1 = "npc_flashlight";

  if(isDefined(var_0)) {
    var_1 = var_0;
  }

  if(!isDefined(level._effect[var_1])) {
    return;
  }

  var_2 = [];
  GscBinSkip0(0x2e, var_2.size, "tag_flash");
}

function enter_combat(var_0) {
  if(istrue(self.aggressive) || istrue(self.dont_enter_combat)) {
    return;
  }

  self notify("alerted");
  self notify("enter_combat");
  self notify("stop_going_to_node");
  self endon("death");
  level endon("game_ended");
  set_kill_off_time();
  set_demeanor_from_unittype("combat");

  if(getdvarint("scr_ai_outline_debug", 0)) {
    scripts\cp\cp_outline::enable_outline_for_players(self, level.players, "outline_nodepth_green", "high");
  }

  self.pacifist_override = undefined;
  self.scripted_mode = 0;
  self.entered_combat = 1;
  self.script_pacifist = undefined;
  self.pacifist = 0;
  self.currentnode = undefined;

  if(!is_specified_unittype("juggernaut")) {
    var_1 = randomintrange(180, 220);
    scripts\engine\utility::set_movement_speed(var_1);
  }

  if(!is_specified_unittype("suicidebomber") && !is_specified_unittype("civilian")) {
    thread get_enemy_info_loop();
  }

  run_combat_func();
}

function run_combat_func(var_0, var_1) {
  if(isDefined(self.combat_func_override)) {
    var_2 = self.combat_func_override;
  } else {
    var_2 = self.aitype;
  }

  if(isDefined(var_2)) {
    if(isDefined(level.aitypes[var_2]) && isDefined(level.aitypes[var_2].combat_func)) {
      if(isDefined(var_1) && isDefined(var_2)) {
        self thread[[level.aitypes[var_2].combat_func]](var_1, var_2);
        return;
      }

      if(isDefined(var_1)) {
        self thread[[level.aitypes[var_2].combat_func]](var_1);
        return;
      }

      self thread[[level.aitypes[var_2].combat_func]]();
      return;
    }

    return;
  }
}

function get_enemy_info_loop(var_0) {
  level endon("game_ended");
  self notify("get_enemy_info_loop");
  self endon("get_enemy_info_loop");
  self endon("death");

  if(istrue(self.attempting_teleport)) {
    self.ignoreall = 0;
    self.is_on_platform = undefined;
    self.attempting_teleport = undefined;
    self show();
    set_kill_off_time(20);
  }

  if(!isDefined(var_0)) {
    var_0 = 2;
  }

  var_1 = 0;
  var_2 = 1;
  var_3 = projectilewaittilstucktimeout();
  var_4 = &prepickupweapon;
  var_5 = &progression_main;

  for(;;) {
    if(ref_132db()) {
      var_1 = 0;
      self.target_enemy = undefined;
    } else {
      var_7 = var_3;

      if(var_2) {
        var_7 = undefined;
      }

      var_6 = self[[var_4]](var_7);
      var_8 = self[[var_5]](var_7, var_6);

      if(isDefined(var_8)) {
        var_2 = 0;

        if(isDefined(self.script_origin_other)) {
          var_9 = self.script_origin_other;
        } else {
          var_9 = var_9.origin;
        }

        if(scripts\cp\utility::turn_off_sniper_laser()) {
          set_goal_pos_check_for_offset(var_9.origin);
        } else if(!has_dont_kill_off_flag() && z_is_excessive(var_9)) {
          if(passed_kill_off_time_checks(gettime())) {
            teleport_to_nearby_spawner("Too Far From Target", var_9);
          }
        } else {
          set_kill_off_time(var_1);
          set_demeanor_from_unittype("combat");

          if(isDefined(self.goal_pos_override) && !isDefined(self.last_set_goalent)) {
            self.goal_pos_override = undefined;
            set_goal_radius(self.last_goalradius);
          }

          update_target_player(var_9);

          if(isDefined(self.group)) {
            self.group scripts\engine\utility::ent_flag_set("weapons_free");
          }

          if(isDefined(self.script_goalvolume)) {
            self setgoalvolumeauto(self.script_goalvolume);
          } else {
            self cleargoalvolume();

            if(!istrue(self.combat_func_active)) {
              if(!istrue(self.is_on_platform) && isDefined(self.engagemaxdist)) {
                var_10 = 6;

                if(self seerecently(var_9, var_10)) {
                  var_11 = distancesquared(var_9, self.origin);
                  var_12 = var_11 <= self.engagemaxdist * self.engagemaxdist;

                  if(istrue(var_2) && var_12 || isDefined(var_9.vehicle_riding_on)) {
                    var_2 = 0;
                    set_goal_pos_check_for_offset(self.origin);
                  } else if(!istrue(var_2) && !var_12) {
                    var_2 = 1;
                    set_goal_pos_check_for_offset(var_9.origin);
                  }
                } else {
                  var_2 = 1;
                  set_goal_pos_check_for_offset(var_9.origin);
                }
              } else {
                self.goal_pos_override = undefined;
                set_goal_pos_check_for_offset(self.origin);
              }
            }
          }
        }
      } else if(!istrue(self.combat_func_active)) {
        var_2 = 0;
        self.target_enemy = undefined;
        self.goal_pos_override = undefined;

        if(isDefined(self.script_origin_other)) {
          set_goal_pos_check_for_offset(self.script_origin_other);
        } else if(istrue(self.is_on_platform)) {
          set_goal_pos_check_for_offset(self.origin);
        } else if(isDefined(self.script_goalvolume)) {
          self setgoalvolumeauto(self.script_goalvolume);
        } else if(!has_dont_kill_off_flag()) {
          if(passed_kill_off_time_checks(gettime())) {
            teleport_to_nearby_spawner("No Target Found", self.origin);
          } else {
            set_goal_pos_check_for_offset(self.origin);
            set_demeanor_from_unittype("cqb");
          }
        } else {
          set_goal_pos_check_for_offset(self.origin);
          set_demeanor_from_unittype("cqb");
        }
      }
    }

    wait var_1;
  }
}

function projectilewaittilstucktimeout() {
  if(isDefined(self.group)) {
    if(isDefined(self.group.spawn_scoring_overrides)) {
      var_0 = self.group.spawn_scoring_overrides.ref_13bdb;
    } else if(istrue(self.group.cqb_module)) {
      var_0 = 2333;
    } else {
      var_0 = 4096;
    }
  } else if(istrue(level.spawn_scoring_overrides)) {
    var_0 = level.spawn_scoring_overrides.ref_13bdb;
  } else {
    var_0 = 4096;
  }

  var_0 = int(min(var_0, 2500));
  return var_0;
}

function ref_132db() {
  if(istrue(self.ignoreall) || istrue(self.scripted_mode)) {
    return 1;
  }

  return 0;
}

function prepdoorsforunload() {
  for(var_0 = 0; var_0 < level.players.size; var_0++) {
    self getenemyinfo(level.players[var_0]);
  }
}

function prepickupweapon(var_0) {
  self notify("get_all_players_enemy_info_new");
  self endon("get_all_players_enemy_info_new");
  var_1 = [];

  if(!scripts\engine\utility::is_equal(self.demeanoroverride, "combat")) {
    self endon("death");
    wait 5;
  }

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    if(quickdropremoveammofrominventory(level.players[var_2])) {
      var_1 = level.players[var_2];
    }
  }

  return var_1;
}

function quickdropremoveammofrominventory(var_0) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    var_0.warp_player_debug = gettime();
    self getenemyinfo(var_0);
    return true;
  }

  var_1 = 5;
  var_2 = 5;

  if(self seerecently(var_0, var_1)) {
    var_0.warp_player_debug = gettime();
    self getenemyinfo(var_0);
    return true;
  } else if(isDefined(var_0.warp_player_debug) && gettime() < var_0.warp_player_debug + var_2 * 1000) {
    self getenemyinfo(var_0);
    return true;
  } else if(isDefined(self.pathgoalpos) && distancesquared(self.pathgoalpos, var_0.origin) < 262144 && self pathdisttogoal() < 2048) {
    return true;
  }

  return false;
}

function z_is_excessive(var_0) {
  var_1 = self.origin;
  var_2 = 256;

  if(scripts\anim\utility_common::isasniper()) {
    var_2 = 512;
  }

  var_3 = undefined;

  if(isDefined(var_0)) {
    var_3 = var_0[2];
  }

  for(var_4 = 0; var_4 < level.players.size; var_4++) {
    if(!isDefined(var_0)) {
      var_3 = level.players[var_4].origin[2];
    }

    if(int(abs(var_1[2] - var_3)) >= var_2 && !spawnsighttrace(undefined, level.players[var_4].origin, var_1)) {
      return true;
    }
  }

  return false;
}

function set_goal_pos_to_center_of_nearby_ai() {
  self endon("death");

  if(!isDefined(self.goal_pos_override)) {
    set_goal_radius(1024);
  }

  var_0 = level.spawned_enemies;
  var_1 = scripts\engine\utility::get_array_of_closest(self.origin, var_0, undefined, 10);
  var_2 = scripts\cp\utility::get_center_point_of_array(var_1);

  if(!isDefined(self.goal_pos_override) || distance2dsquared(self.goal_pos_override, var_2) >= 262144) {
    self.goal_pos_override = var_2;
    set_goal_pos(self.goal_pos_override);
  }

  wait 5;
}

function has_seen_any_player_recently_watcher() {
  self endon("death");
  var_0 = 10;
  var_1 = gettime() / level.frameduration % var_0;
  var_2 = self getentitynumber() % var_0;

  if(var_1 != var_2) {
    wait(var_2 + var_0 - var_1) % var_0 * level.frameduration / 1000;
  }

  while(has_seen_any_player_recently()) {
    wait 0.5;
  }
}

function has_seen_any_player_recently() {
  var_0 = 3;

  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    if(self seerecently(level.players[var_1], var_0)) {
      return true;
    }
  }

  if(!vo_nag_hangar()) {
    return true;
  }

  return false;
}

function teleport_to_nearby_spawner(var_0, var_1, var_2) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return;
  }

  if(istrue(self.marked_for_death) || istrue(self.attempting_teleport)) {
    return;
  }

  if(has_never_kill_off_flag()) {
    if(isDefined(var_0)) {
      if(getdvarint("scr_show_teleport_reason", 0)) {
        var_3 = 1;

        if(isDefined(var_1)) {
          if(var_3) {
            announcement("(NKO)Agent at: " + self.origin + " attempted teleport because: " + var_0);
          }
        } else if(var_3) {
          announcement("(NKO)Agent at: " + self.origin + " attempted teleport because: " + var_0);
        }
      }
    }

    return;
  }

  if(istrue(self.playeriszombie) || !isDefined(self.group)) {
    script_kill_ai();
    return;
  }

  self endon("death");
  self notify("teleport_to_nearby_spawner");
  self endon("teleport_to_nearby_spawner");

  if(getdvarint("scr_show_teleport_reason", 0)) {
    self hudoutlineenable("outline_cp_teleport_debug");
  }

  if(getdvarint("scr_block_teleport", 0)) {
    self notify("get_enemy_info_loop");
    self.ignoreall = 1;
    self.ignoreme = 1;
    self.marked_for_death = 1;
    set_goal_pos(self.origin);
    self waittill("forever");
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(var_2) {
    has_seen_any_player_recently_watcher();
  }

  if(istrue(self.playing_skit)) {
    script_kill_ai(1);
    return;
  }

  if(is_riding_vehicle()) {
    script_kill_ai();
    return;
  }

  var_4 = choose_spawnpoint(self.group, 1, self);

  if(isDefined(var_4)) {
    if(isDefined(var_0)) {
      if(getdvarint("scr_show_teleport_reason", 0)) {
        var_3 = 1;

        if(isDefined(var_1)) {
          if(var_3) {
            announcement("Agent at: " + self.origin + " teleported because: " + var_0);
          }
        } else if(var_3) {
          announcement("Agent at: " + self.origin + " teleported because: " + var_0);
        }
      }
    }

    var_4 notify("spawn_success", var_4);
    self endon("death");
    self.combat_func_active = undefined;
    self.attempting_teleport = 1;
    self.ignoreall = 1;
    set_kill_off_time(20);
    self hide();
    set_default_spawner_values(var_4);
    wait 0.1;
    self dontinterpolate();
    var_5 = (0, 0, 0);

    if(isDefined(var_4.angles)) {
      var_5 = var_4.angles;
    }

    self forceteleport(var_4.origin, var_5, 10000, 1);
    self.goal_pos_override = undefined;
    set_goal_pos(self.origin);
    wait 0.1;
    self.ignoreall = 0;
    self.is_on_platform = undefined;
    self.attempting_teleport = undefined;
    self show();
    set_kill_off_time(20);
    var_6 = get_closest_available_player();
    update_target_player(var_6);
    return;
  }

  if(isDefined(var_0)) {
    if(var_0 == "Bad Path") {
      return;
    }

    if(var_0 == "Too Far From Target") {
      if(isDefined(var_1)) {}

      set_goal_pos_to_center_of_nearby_ai();
      return;
    }

    script_kill_ai();
    return;
  }

  script_kill_ai();
}

function script_kill_ai(var_0) {
  remove_from_kill_off_list();

  if(self.birthtime >= gettime()) {
    waitframe();
  }

  self.marked_for_death = 1;

  if(!istrue(var_0)) {
    self.nocorpse = 1;
  }

  self.died_poorly = 1;
  self.died_poorly_health = self.health;
  self kill();
}

function is_in_combat_volume() {
  return false;
}

function remove_from_enemy_list(var_0) {
  if(!isDefined(var_0) && isDefined(self.target_enemy)) {
    var_0 = self.target_enemy;
  }

  if(isDefined(var_0)) {
    if(scripts\engine\utility::array_contains(var_0.enemy_list, self)) {
      var_0.enemy_list = scripts\engine\utility::array_remove(var_0.enemy_list, self);
      return;
    }

    return;
  }
}

function get_closest_available_player(var_0) {
  var_1 = undefined;

  if(isDefined(var_0)) {
    var_2 = scripts\common\utility::playersnear(self.origin, var_0);
  } else {
    var_2 = scripts\cp\utility::get_array_of_valid_players();
  }

  var_2 = sortbydistance(var_2, self.origin);
  var_3 = var_1;

  if(var_2.size > 0) {
    var_2 = var_2[0];

    for(var_4 = 0; var_4 < var_2.size; var_4++) {
      var_5 = var_2[var_4];

      if(istrue(var_5.ignoreme)) {
        continue;
      }

      if(!var_5 scripts\cp\utility::is_valid_player(1, 1)) {
        continue;
      }

      if(isDefined(self.enemy) && var_5 == self.enemy) {
        return var_5;
      }

      if(scripts\cp\cp_spawning_util::increase_wave_ai_killed_counter(var_5.origin)) {
        var_2 = var_5;
        break;
      }
    }
  }

  if(isDefined(var_2)) {
    return var_2;
  }

  return undefined;
}

function progression_main(var_0, var_1) {
  var_2 = undefined;

  if(isDefined(var_0) && !scripts\cp\utility::turn_off_sniper_laser()) {
    var_3 = playersnearcustom(self.origin, var_0, var_1);
  } else {
    var_3 = scripts\cp\utility::get_array_of_valid_players();
  }

  var_3 = sortbydistance(var_3, self.origin);
  var_4 = var_1;

  if(var_3.size > 0) {
    var_3 = var_3[0];

    for(var_5 = 0; var_5 < var_3.size; var_5++) {
      var_6 = var_3[var_5];

      if(istrue(var_6.ignoreme)) {
        continue;
      }

      if(!var_6 scripts\cp\utility::is_valid_player(1, 1)) {
        continue;
      }

      if(isDefined(self.enemy) && var_6 == self.enemy) {
        return var_6;
      }

      if(var_6 scripts\cp\cp_spawning_util::increase_wave_ai_killed_counter(self.origin)) {
        var_3 = var_6;
        break;
      }
    }
  }

  if(isDefined(var_3)) {
    return var_3;
  }

  return undefined;
}

function playersnearcustom(var_0, var_1, var_2) {
  var_3 = physics_createcontents(["physicscontents_player"]);
  var_4 = (var_1, var_1, var_1);
  var_5 = var_0 - var_4;
  var_6 = var_0 + var_4;
  var_7 = [];
  var_8 = physics_aabbbroadphasequery(var_5, var_6, var_3, []);

  for(var_9 = 0; var_9 < var_8.size; var_9++) {
    if(isPlayer(var_8[var_9])) {
      if(scripts\engine\utility::array_contains(var_2, var_8[var_9])) {
        var_7 = scripts\engine\utility::array_add(var_7, var_8[var_9]);
      }
    }
  }

  return var_7;
}

function set_default_ar_values() {
  self.maxfaceenemydist = 768;
  scripts\engine\utility::set_movement_speed(75);
  self setengagementmindist(128, 64);
  self setengagementmaxdist(512, 640);
}

function shotgunner_info_loop(var_0) {
  if(!isDefined(var_0)) {
    var_0 = get_closest_available_player();
  }

  if(!isDefined(var_0)) {
    set_demeanor_from_unittype("sprint");
    set_goal_radius(2000);
    return;
  }

  update_target_player(var_0);
  set_goal_ent(var_0);
  self setgoalentity(var_0, 250);
  set_goal_radius(512);
  set_demeanor_from_unittype("combat");
}

function shotgunner_combat(var_0) {
  if(!isDefined(var_0)) {
    var_0 = get_closest_available_player();
  }

  if(!isDefined(var_0)) {
    set_demeanor_from_unittype("sprint");
    set_goal_radius(2000);
    return;
  }

  self.combat_func_active = 1;
  set_goal_ent(var_0);
  set_goal_radius(256);
  set_demeanor_from_unittype("combat");
}

function update_target_player(var_0) {
  if(isDefined(var_0)) {
    if(!isDefined(var_0.enemy_list)) {
      var_0.enemy_list = [];
    }

    if(!isDefined(self.target_enemy) || self.target_enemy != var_0) {
      self notify("changed_target");
      remove_from_enemy_list(var_0);
    }

    run_combat_func(var_0);
  }

  self.target_enemy = var_0;
}

function shotgunner_spawn() {}

function sniper_combat() {
  self endon("death");
  level endon("game_ended");

  if(isDefined(self.script_goalvolume)) {
    self setgoalvolumeauto(self.script_goalvolume);
  }

  self.defaultcoverselector = "cover_sniper_cp";
  set_demeanor_from_unittype("frantic");
  self setengagementmindist(1024, 0);
  self setengagementmaxdist(2048, 4096);
  self waittill("enemy");
  self enableavoidance(1, 1);
  self setavoidanceradius(64);
  self setavoidancereciprocity(1);
}

function play_rappel_intro_anim(var_0, var_1, var_2) {
  var_0 endon("death");
  var_0.ignoreall = 1;
  var_0 scripts\asm\shared\mp\utility::burnfxstates("sdr_com_inter_rappel_window", var_1.origin, var_1.angles);
  var_0.ignoreall = 0;
  var_0 scripts\asm\shared\mp\utility::bunkercounteruav();

  if(isDefined(var_2)) {
    var_0 thread[[var_2]](var_0);
    return;
  }
}

function trigger_choose_func_from_list(var_0, var_1) {}

function trigger_run_module_once(var_0, var_1) {
  level endon("game_ended");
  var_2 = run_spawn_module(var_0.target);
  var_0 notify("disable_trigger");
}

function trigger_run_spawn_module(var_0, var_1) {
  level endon("game_ended");
  var_2 = run_spawn_module(var_0.target);

  if(isDefined(var_2)) {
    wait_for_all_group_dead(var_2);
    return;
  }
}

function set_dontkilloff_flag() {
  self.dontkilloff = 1;
}

function wait_for_all_multi_group_dead(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1)) {
    level scripts\engine\utility::ref_143b9(var_1, "module_group " + var_0.group_name + " completed");
    return;
  }

  level waittill("module_group " + var_0.group_name + " completed");
}

function wait_for_all_group_dead(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1)) {
    var_0 scripts\engine\utility::ref_143b9(var_1, "group_spawning_completed");
    return;
  }

  var_0 waittill("group_spawning_completed");
}

function wait_at_spawn_counts(var_0, var_1, var_2, var_3) {
  level endon("game_ended");

  if(var_0.spawn_count % var_1 == 0) {
    return var_2;
  }

  return var_3;
}

function return_random_number(var_0, var_1, var_2) {
  var_1 = define_var_if_undefined(var_1, 3);
  var_2 = define_var_if_undefined(var_2, 5);
  return randomintrange(var_1, var_2);
}

function waittill_spawn_notify_after_count(var_0, var_1) {
  if(var_0.spawn_count == 0) {
    level waittill(var_1);
    return;
  }

  if(var_0.max_size % var_0.spawn_count == 0) {
    level waittill(var_1);
    return;
  }

  return 0.1;
}

function ref_145d3(var_0, var_1, var_2, var_3) {
  var_0 endon("death");

  if(!isarray(var_1)) {
    var_1 = [var_1];
  }

  if(!isarray(var_2)) {
    var_2 = [var_2];
  }

  if(var_1.size != var_2.size) {
    return;
  }

  var_4 = [];

  for(var_5 = 0; var_5 < var_1.size; var_5++) {
    var_6 = "within_bounds_" + var_5;
    var_4 = var_6;
    watch_for_players_beyond_point(var_0, var_1[var_5], var_2[var_5], undefined, var_6, 1);
  }

  var_0 scripts\engine\utility::waittill_all_in_array(var_4);
  var_0 notify("stop_watching_beyond_point");

  if(isDefined(var_3)) {
    var_0 thread[[var_3]]();
    return;
  }
}

function watch_for_players_beyond_point(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread watch_for_players_beyond_point_internal(var_0, var_1, var_2, var_3, var_4, var_5);
}

function mp_hideout_patch() {
  stop_module_by_groupname(self.group_name, 1);
}

function watch_for_players_beyond_point_internal(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("death");
  var_0 endon("stop_watching_beyond_point");
  var_6 = spawnStruct();
  var_6.origin = var_1;
  var_6.angles = var_2;

  for(;;) {
    for(var_7 = 0; var_7 < level.players.size; var_7++) {
      if(var_6 scripts\cp\cp_spawning_util::increase_wave_ai_killed_counter(level.players[var_7].origin)) {
        if(isDefined(var_4)) {
          var_0 notify(var_4);
        }

        if(isDefined(var_3)) {
          var_0 thread[[var_3]]();
        }

        if(!istrue(var_5)) {
          return;
        }
      }
    }

    wait 0.5;
  }
}

function ref_14340(var_0) {
  var_0 scripts\engine\utility::ent_flag_wait("weapons_free");
}

function set_heavy_hitter(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 2048;
  }

  var_2 = get_spawned_ai_from_group_struct(var_0);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    set_goal_radius(var_2[var_3], var_1);
  }
}

function set_initial_goalheight(var_0, var_1) {
  thread ref_13f33(var_1);
}

function ref_13f33(var_0) {
  level endon("game_ended");
  self endon("death");
  level waittill(var_0);
  self.ignoreall = 0;
}

function set_initial_goalRadius(var_0, var_1) {
  var_2 = get_spawned_ai_from_group_struct(var_0);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_2[var_3] scripts\cp\cp_spawning_util::enable_juggernaut_move_behavior();
  }
}

function ref_1309b(var_0) {
  level notify("weapons_free");

  if(scripts\engine\utility::flag_exist("weapons_free")) {
    scripts\engine\utility::flag_set("weapons_free");
    return;
  }
}

function group_fallback_to_pos(var_0, var_1) {
  var_2 = get_spawned_ai_from_group_struct(var_0);
  set_script_origin_other_for_group(var_0, var_1);
}

function fallback_to_pos_if_weapons_free(var_0, var_1) {
  if(var_0 scripts\engine\utility::ent_flag("weapons_free")) {
    set_script_origin_other_on_ai(var_1);
    return;
  }
}

function stop_and_start_group(var_0, var_1, var_2) {
  run_spawn_module(var_2);
  stop_module_by_groupname(var_1);
}

function module_wave_spawn(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_1 = define_var_if_undefined(var_1, get_passive_wave_spawn_time());
  var_2 = define_var_if_undefined(var_2, get_passive_spawn_window_time());
  var_3 = define_var_if_undefined(var_3, 0.1);
  var_7 = define_var_if_undefined(var_6, get_activecount_from_group(var_0));
  var_4 = get_passive_wave_low_threshold(var_0, var_4);
  var_5 = get_passive_wave_high_threshold(var_0, var_5);

  if(istrue(var_0.spawn_window_open)) {
    if(!istrue(var_0.disable_wave_hud)) {
      setomnvar("cp_wave_timer", 0);
    }

    return var_3;
  }

  var_8 = gettime();

  if(isDefined(var_4) && isDefined(var_5)) {
    if(isDefined(var_6)) {
      if(var_0.spawn_count > 0 && var_0.spawn_count % var_5 == 0) {
        change_module_status(var_0, undefined, "low_threshold: " + var_4);
        group_wait_for_activecount_notify(var_0, var_4);
        change_module_status(var_0, undefined, "wave_delay");
        wave_cooldown_time(var_0, var_1);
        wait var_1;

        if(!istrue(var_0.disable_wave_hud)) {
          setomnvar("cp_wave_timer", 0);
        }

        var_0 scripts\cp\cp_wave_spawning::increase_wave_num();
        change_module_status(var_0, undefined, "spawning_after_low_threshold");
        return;
      }

      change_module_status(var_0, undefined, "spawning_to_high_threshold");
      return var_3;
    }

    if(var_7 >= var_5) {
      change_module_status(var_0, undefined, "low_threshold: " + var_4);
      group_wait_for_activecount_notify(var_0, var_4);
      change_module_status(var_0, undefined, "wave_delay");
      wave_cooldown_time(var_0, var_1);
      wait var_1;

      if(!istrue(var_0.disable_wave_hud)) {
        setomnvar("cp_wave_timer", 0);
      }

      var_0 scripts\cp\cp_wave_spawning::increase_wave_num();
      change_module_status(var_0, undefined, "spawning_after_low_threshold");
      return;
    }

    change_module_status(var_0, undefined, "spawning_to_high_threshold");
    return var_3;
  }

  if(!isDefined(var_0.last_wave_time)) {
    change_module_status(var_0, undefined, "first_spawn_window");
    var_0.spawn_window_open = 1;
    var_0 scripts\engine\utility::delaythread(var_2, &disable_spawn_window);
    var_0 scripts\engine\utility::delaythread(var_2, &wave_cooldown_time, var_1);
    return var_3;
  }

  var_9 = var_0.last_wave_time + var_1 * 1000 - var_8;

  if(var_9 < 0) {
    change_module_status(var_0, undefined, "full_spawn_window");
    var_0.spawn_window_open = 1;
    var_0 scripts\engine\utility::delaythread(var_2, &disable_spawn_window);
    var_0 scripts\engine\utility::delaythread(var_2, &wave_cooldown_time, var_1);
    return var_3;
  }

  change_module_status(var_0, undefined, "wave_delay");
  return var_1;
}

function wave_cooldown_time(var_0) {
  if(!istrue(level.wave_cooldown_active)) {
    thread monitor_wave_cooldown(level);
    thread ref_1451b(level);

    if(!istrue(self.disable_wave_hud)) {
      var_1 = gettime() + var_0 * 1000;
      setomnvar("cp_wave_timer", int(var_1));
      return;
    }

    return;
  }
}

function monitor_wave_cooldown(var_0) {
  level endon("game_ended");
  level.wave_cooldown_active = 1;
  wait var_0;
  level.wave_cooldown_active = undefined;
}

function ref_1451b(var_0) {
  level endon("game_ended");
  level endon("wave_starting");
  level endon("stop_wave_sounds");

  if(!scripts\cp\utility::turn_off_sniper_laser()) {
    return;
  }

  if(isDefined(level.ref_14531) && level.ref_14531 <= level.logfriendlyfire) {
    return;
  }

  var_1 = var_0;

  while(var_1 > 0) {
    var_1--;
    var_2 = scripts\cp\utility::relic_bang_and_boom_dropfunc(var_1);

    foreach(var_4 in level.players) {
      var_4 playlocalsound(var_2);
    }

    if(var_1 == 30 || var_1 == 10) {
      var_6 = scripts\cp\utility::respawn_flare_wavesv_used_playereffects(var_1);

      if(isDefined(var_6)) {
        level thread scripts\cp\cp_vo::try_to_play_vo_on_team(var_6, "allies");
      }
    }

    wait 1;
  }
}

function override_spawner_aitypes(var_0, var_1, var_2, var_3) {
  var_4 = [];

  if(isDefined(var_1)) {
    GscBinSkip0(0x2e, var_4.size, var_1);
  }

  if(isDefined(var_2)) {
    GscBinSkip0(0x2e, var_4.size, var_2);
  }

  if(isDefined(var_3)) {
    GscBinSkip0(0x2e, var_4.size, var_3);
  }

  for(var_5 = 0; var_5 < var_0.spawn_points.size; var_5++) {
    var_6 = var_0.spawn_points[var_5];
    var_6.script_noteworthy = var_4;
  }
}

function set_count_based_on_grouped_modules(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.grouped_modules[var_1])) {
    level.grouped_modules[var_1] = [];
  }

  if(!scripts\engine\utility::array_contains(level.grouped_modules[var_1], var_0)) {
    level.grouped_modules[var_1][level.grouped_modules[var_1].size] = var_0;
  }

  var_4 = var_0.activecount;
  var_5 = get_active_from_grouped_modules(level.grouped_modules[var_1]);

  if(var_5 < var_2) {
    return var_3;
  }

  return 0;
}

function shipfx(var_0) {
  var_1 = rear_spotlight_speed(var_0);

  if(!isDefined(var_1)) {
    return false;
  }

  var_2 = rear_spotlight_speed(var_0);

  if(!isDefined(var_2)) {
    return false;
  }

  return var_1 < var_2;
}

function rear_spotlight_speed(var_0) {
  if(isDefined(var_0.ref_13959)) {
    return var_0.ref_13959;
  }

  return undefined;
}

function recharge_equipment_update_slot(var_0) {
  if(isDefined(var_0.ref_13be9)) {
    return var_0.ref_13be9;
  }

  return undefined;
}

function ref_130f7(var_0, var_1) {
  var_0.ref_13be9 = var_1;
}

function get_active_from_grouped_modules(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1 += var_0[var_2].activecount;
  }

  return var_1;
}

function define_var_if_undefined(var_0, var_1) {
  if(!isDefined(var_0)) {
    if(isbuiltinfunction(var_1)) {
      return [[var_1]]();
    }

    return var_1;
  }

  return var_0;
}

function disable_spawn_window(var_0) {
  self.spawn_window_open = undefined;
  self.last_wave_time = gettime();
}

function wave_reinforce(var_0, var_1, var_2, var_3) {
  level endon("game_ended");

  if(get_activecount_from_group(var_0) <= var_0.min_size) {
    if(var_1 > 0.05) {
      return randomfloatrange(0.05, var_1);
    } else {
      return 0.05;
    }
  }

  if(var_0.activecount >= var_0.max_size) {
    while(get_activecount_from_group(var_0) > var_0.min_size) {
      wait 0.25;
    }

    return var_2;
  }

  if(isDefined(var_1)) {
    return var_1;
  }

  if(isDefined(var_2)) {
    return var_2;
  }

  return 0.05;
}

function set_wave_show_hud(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  var_0.disable_wave_hud = !var_1;
}

function go_to_node(var_0, var_1, var_2) {
  if(!isDefined(var_0) || isarray(var_0) && var_0.size < 1) {
    var_0 = get_next_node_array(self.spawnpoint);

    if(var_0.size == 0) {
      self notify("reached_path_end");

      if(isDefined(var_1)) {
        [[var_1]]();
      }

      return;
    }
  } else if(!isarray(var_0)) {
    var_0 = [var_0];
  }

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(isvector(var_0[var_3])) {
      var_4 = spawnStruct();
      var_4.origin = var_0[var_3];
      var_4.angles = (0, 0, 0);
      var_0 = var_4;
    }
  }

  go_to_node_internal(var_0, var_1, var_2);
}

function get_next_node_array() {
  var_0 = get_linkto_goals();

  if(var_0.size < 1) {
    if(isDefined(self.target)) {
      var_0 = get_target_goals(self.target);
    }
  }

  return var_0;
}

function get_target_goals(var_0) {
  var_1 = getnodearray(var_0, "targetname");
  var_2 = scripts\engine\utility::getStructArray(var_0, "targetname");

  foreach(var_4 in var_2) {
    var_1 = var_4;
  }

  var_2 = getEntArray(var_0, "targetname");

  for(var_6 = 0; var_6 < var_2.size; var_6++) {
    var_4 = var_2[var_6];

    if(!is_target_goal_valid(var_4)) {
      continue;
    }

    var_1 = var_4;
  }

  return var_1;
}

function get_linkto_goals() {
  var_0 = [];

  if(isDefined(self.script_linkto)) {
    var_1 = scripts\engine\utility::get_linked_ents();
    var_2 = scripts\engine\utility::get_linked_structs();
    var_3 = scripts\engine\utility::get_linked_nodes();
    var_0 = scripts\engine\utility::array_combine(var_1, var_2, var_3);
  }

  return var_0;
}

function go_to_node_internal(var_0, var_1, var_2) {
  self notify("stop_going_to_node");
  self endon("stop_going_to_node");
  self endon("death");
  level endon("game_ended");

  if(!isarray(var_0)) {
    var_0 = [var_0];
  }

  thread go_to_node_end();
  var_3 = 0;
  var_4 = 0;
  var_5 = undefined;
  var_6 = var_0[0];

  for(;;) {
    if(!var_3) {
      var_0 = get_least_used_from_array(var_0);
      var_5 = get_path_array(var_0, var_6);

      if(var_5.size > 1) {
        var_3 = 1;
      }
    }

    self.currentnode = var_0;

    if(var_3) {
      var_0 = var_5[var_5.size - 1];
      go_through_patharray(var_5, var_1, var_2);
      var_5 = undefined;
      var_3 = 0;
    } else {
      node_fields_pre_goal(var_0);
      go_to_node_set_goal(var_0);
      self waittill("goal");
    }

    var_0 notify("trigger", self);
    node_fields_after_goal(var_0, var_1);
    ref_11e9e(var_0);
    var_0 scripts\engine\utility::script_delay();

    if(isDefined(var_0.script_flag_wait)) {
      scripts\engine\utility::flag_wait(var_0.script_flag_wait);
    }

    if(isDefined(var_0.script_ent_flag_wait)) {
      scripts\engine\utility::ent_flag_wait(var_0.script_ent_flag_wait);
    }

    var_0 scripts\engine\utility::script_wait();
    node_fields_after_goal_and_wait(var_0, var_2);

    if(!isDefined(var_0.target) && !isDefined(var_0.script_linkto)) {
      break;
    }

    var_7 = get_next_node_array(var_0);

    if(!var_7.size) {
      break;
    }

    var_0 = var_7;
  }

  self notify("reached_path_end");

  if(isDefined(self.script_forcegoal)) {
    return;
  }

  var_8 = self getgoalvolume();

  if(isDefined(var_8)) {
    self setgoalvolumeauto(var_8, get_cover_volume_forward(var_8));
    return;
  }
}

function get_least_used_from_array(var_0) {
  if(var_0.size == 1) {
    return var_0[0];
  }

  var_0 = scripts\engine\utility::array_randomize(var_0);
  var_1 = var_0[0];

  if(!isDefined(var_1.used_time)) {
    var_1.used_time = 0;
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_3 = var_0[var_2];

    if(!isDefined(var_3.used_time)) {
      var_3.used_time = 0;
    }

    if(var_3.used_time < var_1.used_time) {
      var_1 = var_3;
    }
  }

  var_1.used_time = gettime();
  return var_1;
}

function get_path_array(var_0, var_1) {
  var_2 = [];
  var_3 = 0;

  for(;;) {
    var_2 = var_0;
    var_3++;

    if(var_3 == 16) {
      break;
    }

    if(go_to_node_should_stop(var_0)) {
      break;
    }

    if(!isDefined(var_0.target) && !isDefined(var_0.script_linkto)) {
      break;
    }

    var_4 = get_next_node_array(var_0);

    if(!var_4.size) {
      break;
    }

    var_0 = get_least_used_from_array(var_4);

    if(var_0 == var_1) {
      break;
    }
  }

  return var_2;
}

function go_through_patharray(var_0, var_1, var_2) {
  self setgoalpath(var_0);

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_4 = var_3;
    var_5 = var_0[var_3];
    self.currentnode = var_5;
    node_fields_pre_goal(var_5);
    var_6 = waittill_subgoal();

    if(var_4 == var_0.size - 1) {
      self waittill("goal");
      break;
    }

    var_5 notify("trigger", self);
    node_fields_after_goal(var_5, var_1);
    ref_11e9e(var_5);
    node_fields_after_goal_and_wait(var_5, var_2);
  }
}

function node_fields_pre_goal(var_0) {
  if(isDefined(var_0.radius)) {
    set_goal_radius(var_0.radius);
  }

  if(isDefined(var_0.script_radius)) {
    self.script_radius = var_0.script_radius;
    set_goal_radius(var_0.script_radius);
  }

  if(isDefined(var_0.height)) {
    self.goalheight = var_0.height;
  }

  if(isDefined(var_0.script_demeanor)) {
    set_demeanor_from_unittype(var_0.script_demeanor);
  }

  if(istrue(var_0.script_pacifist) || isDefined(var_0.spawnflags) && var_0.spawnflags & 256) {
    self.pacifist = 1;
  }

  if(isDefined(var_0.script_ignoreall)) {
    self.ignoreall = var_0.script_ignoreall;
  }

  if(isDefined(var_0.script_ignoreme)) {
    self.ignoreme = var_0.script_ignoreme;
  }

  if(isDefined(var_0.script_flag)) {
    scripts\engine\utility::flag_init(var_0.script_flag);
  }

  if(isDefined(var_0.script_speed)) {
    scripts\engine\utility::set_movement_speed(var_0.script_speed);
    return;
  }
}

function node_fields_after_goal(var_0, var_1) {
  if(isDefined(var_1)) {
    [[var_1]](var_0);
  }

  if(isDefined(var_0.script_flag_set)) {
    scripts\engine\utility::flag_set(var_0.script_flag_set);
  }

  if(isDefined(var_0.script_ent_flag_set)) {
    scripts\engine\utility::ent_flag_set(var_0.script_ent_flag_set);
  }

  if(isDefined(var_0.script_flag_clear)) {
    scripts\engine\utility::flag_clear(var_0.script_flag_clear);
    return;
  }
}

function ref_11e9e(var_0) {
  level endon("game_ended");
  self endon("death");

  if(!istrue(level.global_stealth_broken) && !istrue(self.entered_combat) && isDefined(var_0.script_animation_type)) {
    var_1 = undefined;
    var_2 = strtok(var_0.script_animation_type, ",");
    var_1 = scripts\engine\utility::random(var_2);

    if(isDefined(var_1)) {
      if(!istrue(var_0.script_looping)) {
        self.ref_133a4 = 1;
      } else {
        self.ref_133a4 = undefined;
      }

      self.playing_skit = 1;
      ref_1241b(var_0, var_1);
      self.playing_skit = undefined;

      while(istrue(self.playing_skit)) {
        wait 0.05;
      }

      return;
    }

    return;
  }
}

function ref_1241b(var_0, var_1) {
  self endon("death");

  if(istrue(self.ref_133a4)) {
    self endon("patrol_" + var_1 + "_loop");
  }

  set_goal_pos(var_0.origin);
  self thread[[level.spawn_skits[var_1].skit_func]]();

  while(istrue(self.playing_skit)) {
    wait 0.05;
  }
}

function node_fields_after_goal_and_wait(var_0, var_1) {
  if(isDefined(var_0.script_soundalias)) {
    if(soundexists(var_0.script_soundalias)) {
      self playSound(var_0.script_soundalias);
    }
  }

  if(isDefined(var_0.script_forcegoal)) {
    set_goal_radius(var_0.script_forcegoal);
  }

  if(isDefined(self.post_wait_func)) {
    [[self.post_wait_func]]();
  }

  if(isDefined(var_0.script_delay_post)) {
    wait var_0.script_delay_post;
  }

  while(isDefined(var_0.script_requires_player)) {
    var_0.script_requires_player = 0;

    if(go_to_node_wait_for_player(var_0, &get_next_node_array)) {
      var_0.script_requires_player = 1;
      var_0 notify("script_requires_player");
      break;
    }

    wait 0.25;
  }

  if(isDefined(var_0.script_demeanor_post)) {
    set_demeanor_from_unittype(var_0.script_demeanor_post);
  }

  if(isDefined(var_1)) {
    [[var_1]](var_0);
  }

  if(isDefined(var_0.script_death) && var_0.script_death) {
    script_kill_ai();
  }

  if(isDefined(var_0.script_delete) && var_0.script_delete) {
    self delete();
    return;
  }
}

function go_to_node_wait_for_player(var_0, var_1) {
  var_2 = 0;

  while(var_2 < level.players.size) {
    var_3 = level.players[var_2];

    if(distancesquared(var_3.origin, var_0.origin) < distancesquared(self.origin, var_0.origin)) {
      return 1;
    }

    if(!isDefined(var_0.script_dist_only)) {
      var_4 = anglesToForward(self.angles);

      if(isDefined(var_0.target)) {
        var_5 = var_0[[var_1]](var_0.target);

        if(var_5.size == 1) {
          var_4 = vectorNormalize(var_5[0].origin - var_0.origin);
        } else if(isDefined(var_0.angles)) {
          var_4 = anglesToForward(var_0.angles);
        }
      } else if(isDefined(var_0.angles)) {
        var_4 = anglesToForward(var_0.angles);
      }

      var_6 = [];
      GscBinSkip0(0x2e, var_6.size, vectorNormalize(var_3.origin - self.origin));
    }

    var_10 = 300;

    if(var_2.script_requires_player > var_10) {
      var_10 = var_2.script_requires_player;
    }

    if(distancesquared(var_6.origin, self.origin) < squared(var_10)) {
      return 1;
    }

    return 0;
  }
}

function waittill_subgoal() {
  self endon("goal");
  self waittill("subgoal", var_0);
  return var_0;
}

function go_to_node_should_stop(var_0) {
  if(!isDefined(var_0)) {
    return true;
  }

  if(!isDefined(var_0.target)) {
    return true;
  }

  if(isDefined(var_0.script_delay)) {
    return true;
  }

  if(isDefined(var_0.script_delay_min)) {
    return true;
  }

  if(isDefined(var_0.script_delay_max)) {
    return true;
  }

  if(isDefined(var_0.script_wait)) {
    return true;
  }

  if(isDefined(var_0.script_wait_add)) {
    return true;
  }

  if(isDefined(var_0.script_wait_min)) {
    return true;
  }

  if(isDefined(var_0.script_wait_max)) {
    return true;
  }

  if(isDefined(var_0.script_flag_wait)) {
    return true;
  }

  if(isDefined(var_0.script_ent_flag_wait)) {
    return true;
  }

  if(isDefined(var_0.script_delay_post)) {
    return true;
  }

  if(isDefined(var_0.script_requires_player)) {
    return true;
  }

  if(isDefined(var_0.script_idle)) {
    return true;
  }

  if(isDefined(var_0.script_stopnode)) {
    return true;
  }

  return false;
}

function get_cover_volume_forward() {
  if(isDefined(self.goalvolumecoveryaw)) {
    return anglesToForward((0, self.goalvolumecoveryaw, 0));
  }

  return undefined;
}

function go_to_node_set_goal(var_0) {
  if(isnode(var_0)) {
    go_to_node_set_goal_node(var_0);
  } else if(isstruct(var_0)) {
    go_to_node_set_goal_pos(var_0);
  } else if(isent(var_0)) {
    go_to_node_set_goal_ent(var_0);
  }

  if(isstruct(var_0) || isnode(var_0)) {
    var_0.patrol_stop = go_to_node_should_stop(var_0);
    return;
  }
}

function go_to_node_set_goal_ent(var_0) {
  if(var_0.code_classname == "info_volume") {
    self setgoalvolumeauto(var_0, get_cover_volume_forward(var_0));
    self notify("go_to_node_new_goal");
    return;
  }

  go_to_node_set_goal_pos(var_0);
}

function go_to_node_set_goal_pos(var_0) {
  set_goal_ent(var_0);
  self notify("go_to_node_new_goal");
}

function enter_combat_after_go_to_node() {
  level endon("game_ended");
  self endon("death");
  go_to_node(get_next_node_array(self.spawnpoint));
  thread enter_combat();
}

function set_goal_ent(var_0) {
  set_goal_pos(var_0.origin);
  self.last_set_goalent = var_0;

  if(isstruct(var_0) && !isDefined(var_0.type)) {
    var_0.type = "struct";
    return;
  }
}

function set_goal_pos(var_0) {
  if(istrue(self.fixednode)) {
    return;
  }

  self.last_set_goalnode = undefined;
  self.last_set_goalpos = var_0;
  self.last_set_goalent = undefined;
  self setgoalpos(getclosestpointonnavmesh(var_0));
  self notify("new_goal_pos");
}

function go_to_node_set_goal_node(var_0) {
  set_goal_node(var_0);
  self notify("go_to_node_new_goal");
}

function set_goal_node(var_0) {
  self.last_set_goalnode = var_0;
  self.last_set_goalpos = undefined;
  self.last_set_goalent = undefined;
  self setgoalnode(var_0);
}

function go_to_node_end() {
  self notify("go_to_node_end");
  self endon("go_to_node_end");
  self endon("death");
  level endon("game_ended");
  self.using_goto_node = 1;
  var_0 = scripts\engine\utility::ref_143ad("reached_path_end", "stop_going_to_node");
  self.using_goto_node = undefined;
  self.patharray = undefined;
  self.patharrayindex = undefined;
}

function is_target_goal_valid(var_0) {
  if(isspawner(var_0)) {
    return false;
  }

  switch (var_0.code_classname) {
    case "trigger_once":
    case "trigger_multiple":
    case "trigger_radius":
    case "misc_turret":
      return false;
  }

  return true;
}

function set_goal_radius(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 2048;
  }

  self.last_goalradius = self.goalradius;
  self.goalradius = int(var_0);
}

function return_to_last_goalRadius() {
  if(isDefined(self.last_goalradius)) {
    set_goal_radius(self.last_goalradius);
    return;
  }
}

function set_goal_pos_check_for_offset(var_0) {
  if(isDefined(self.script_origin_other)) {
    var_0 = self.script_origin_other;
  }

  set_goal_pos(var_0);
}

function set_script_origin_other_for_group(var_0) {
  if(isarray(self)) {
    var_1 = [];

    for(var_2 = 0; var_2 < self.size; var_2++) {
      var_1 = scripts\engine\utility::array_add(var_1, self[var_2].ai_spawned);
    }

    var_3 = var_1;
  } else {
    var_3 = self.ai_spawned;
  }

  for(var_2 = 0; var_2 < var_3.size; var_2++) {
    set_kill_off_time(var_3[var_2]);
    set_script_origin_other_on_ai(var_3[var_2], var_3);
  }
}

function ref_11cae(var_0) {
  self.ref_133b2 = 1;
}

function ref_11cac(var_0, var_1) {
  set_goal_radius(var_1);
}

function ref_11cab(var_0, var_1) {
  self.goalheight = var_1;
}

function ref_11cb2(var_0, var_1) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait(var_1);
  scripts\engine\utility::flag_waitopen(var_1);
}

function ref_12ce2(var_0) {
  return var_0.group_name;
}

function ref_11cb1(var_0, var_1) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait(var_1);
}

function ref_11cad(var_0, var_1) {
  self.script_origin_other = var_1;
}

function set_script_origin_other_on_ai(var_0) {
  self.script_origin_other = var_0;
}

function clear_script_origin_other_on_ai(var_0) {
  self.script_origin_other = undefined;
}

function modular_spawning_debug_init() {
  delay_start_specified_module();
  setDvar("scr_show_agent_stats", 0);
  setdvarifuninitialized("scr_show_spawn_spec_info", 0);
  setdvarifuninitialized("scr_pause_spawning", 0);
  setdvarifuninitialized("scr_disable_bad_path_cleanup", 0);
  setdvarifuninitialized("scr_ai_outline_debug", 0);
  setdvarifuninitialized("scr_show_kill_off_stats", 0);
  setdvarifuninitialized("scr_always_on_always", 0);
  setdvarifuninitialized("scr_print_spawner_disables", 0);
  setdvarifuninitialized("scr_print_dialogue_alias", 0);
  setdvarifuninitialized("scr_module_spawning", "");
  setdvarifuninitialized("scr_cover_node_spawning", 0);
  setdvarifuninitialized("scr_init_cover_node_spawners", 1);
  setdvarifuninitialized("scr_wave_spawning", 0);
  setdvarifuninitialized("scr_only_passive_spawning", 0);
  setdvarifuninitialized("scr_show_teleport_reason", 0);
  setdvarifuninitialized("scr_block_teleport", 0);
  setdvarifuninitialized("scr_show_spawn_selection", 0);
  setdvarifuninitialized("scr_wave_high_threshold", -1);
  setdvarifuninitialized("scr_wave_low_threshold", -1);
  setdvarifuninitialized("scr_wave_cooldown_time", -1);
  setdvarifuninitialized("scr_wave_min_count", -1);
  setdvarifuninitialized("scr_wave_max_count", -1);
  setdvarifuninitialized("scr_wave_num", "");
  setdvarifuninitialized("scr_wave_max_spawns", 0);
  setdvarifuninitialized("scr_wave_threshold_timeout", 0);
  setdvarifuninitialized("scr_pre_wave_use_patrol_structs", 1);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Show Agent Stats:1 / Disable:0\" \"togglep scr_show_agent_stats 0\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);

  for(var_1 = 4; var_1 < 4 + get_max_agent_count(); var_1++) {
    var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Show Agent Stats:1 / e" + var_1 + ":" + var_1 + "\" \"togglep scr_show_agent_stats " + var_1 + "\" \n";
    scripts\cp\utility::addentrytodevgui(var_0);
  }

  var_0 = "devgui_cmd \"CP Debug:2 / Debug / Print Dialogue Aliases\" \"togglep scr_print_dialogue_alias 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Print Spawner Disables:2\" \"togglep scr_print_spawner_disables 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Show Cleanup Stats:2\" \"togglep scr_show_kill_off_stats 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Pause Spawning:0\" \"togglep scr_pause_spawning 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Print Spec Info\" \"togglep scr_show_spawn_spec_info 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Toggle Ambient Spawning\" \"togglep scr_always_on_always 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Disable badpath cleanup:3\" \"togglep scr_disable_bad_path_cleanup 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Show Teleport Reasons:3\" \"togglep scr_show_teleport_reason 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Use Wave Spawning\" \"togglep scr_wave_spawning 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Init Nodes As Spawners\" \"togglep scr_init_cover_node_spawners 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Use Cover Node Spawning\" \"togglep scr_cover_node_spawning 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Only Use Passive Spawning\" \"togglep scr_only_passive_spawning 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / AI Outline Debug:4\" \"togglep scr_ai_outline_debug 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Cleanup Vehicles:4\" \"set scr_debug_spawning cleanup_vehicles\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Stop All Groups:4\" \"set scr_debug_spawning stop_all_groups\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / whyAmINotShooting\" \"togglep ai_whyaminotshooting 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / whyAmINotMoving\" \"togglep ai_whyaminotmoving 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Stealth / Debug\" \"togglep debug_stealth 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Stealth / Chat\" \"togglep debug_stealth_chat 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / Stealth / fov\" \"togglep debug_stealth_fov 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  level.spawnpoint_debug = 0;
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Spawnpoint Debug / Toggle:4\" \"set scr_debug_spawning spawnpoint_debug\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Show Spawnpoint Selection\" \"togglep scr_show_spawn_selection 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Spawnpoint Debug / Add Proxy Player At Loc:4\" \"set scr_debug_spawning proxy_add_player\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Spawnpoint Debug / Delete All Proxy Players:4\" \"set scr_debug_spawning proxy_delete_all\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Spawnpoint Debug / Delete Selected Proxy Player:4\" \"set scr_debug_spawning proxy_delete_selected\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Show Active Spawn Modules\" \"set scr_debug_spawning show_active_spawn_modules\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  var_0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning:3 / Convert Nodes To Spawners\" \"set scr_debug_spawning convert_nodes\" \n";
  scripts\cp\utility::addentrytodevgui(var_0);
  registerambientgroup("DEBUG:0/Max Agent Test", 0, &get_max_agent_count, undefined, 0.1, undefined, &get_all_cluster_spawners, undefined, undefined, undefined);
  registerambientgroup("DEBUG:0/Vehicles/Vehicle_Spawn_Test", 0, 24, undefined, 0.1, undefined, &redshirt_drop_off_behavior, undefined, undefined, undefined);
}

function redshirt_drop_off_behavior(var_0) {
  if(getDvar("scr_veh_spawn_test", "") != "") {
    var_1 = scripts\engine\utility::getStructArray(getDvar("scr_veh_spawn_test", ""), "targetname");

    if(var_1.size > 0) {
      return var_1;
    }

    return [];
  }

  return [];
}

function get_all_cluster_spawners(var_0) {
  if(isDefined(level.cluster_spawners) && level.cluster_spawners.size > 0) {
    return level.cluster_spawners;
  }

  return undefined;
}

function print_active_modules_to_screen() {
  level notify("print_active_modules_to_screen");
  level endon("print_active_modules_to_screen");
  level.show_active_modules = !level.show_active_modules;

  if(!level.show_active_modules) {
    if(isDefined(level.menu_background)) {
      level.menu_background destroy();
    }

    return;
  }

  create_background();

  for(;;) {
    var_0 = 150;
    var_1 = " ";
    var_2 = "|Active| Min| Max|Deaths| Total";
    var_3 = "Active Modules| Spawn Count: " + level.spawned_ai.size + "/" + get_max_agent_count();
    var_3 = var_3 + getsubstr(var_1, 0, var_1.size - var_3.size + var_2.size) + var_2;
    var_0 += 15;
    var_4 = " ";
    var_5 = getsubstr(var_1, 0, var_1.size - var_4.size * 5 - 4);

    if(isDefined(level.spawn_module_structs_memory) && level.spawn_module_structs_memory.size > 0) {
      var_6 = getarraykeys(level.spawn_module_structs_memory);

      for(var_7 = 0; var_7 < var_6.size; var_7++) {
        var_8 = var_6[var_7];
        var_9 = level.spawn_module_structs_memory[var_8];

        for(var_10 = 0; var_10 < var_9.size; var_10++) {
          var_11 = var_9[var_10];

          if(var_8 == "wave_spawning") {
            var_12 = get_current_wave_ref(var_11);
            var_8 = "wave: " + var_12;
          }

          var_13 = get_module_debug_data(var_11);

          if(isDefined(level.active_spawn_module_structs) && is_group_active(var_11)) {
            var_14 = (1, 1, 1);
          } else {
            var_14 = (1, 1, 0);
          }

          var_15 = add_space_to_string("| A:" + get_activecount_from_group(var_11, 1), var_4);
          var_16 = add_space_to_string("| m:" + var_13.min_size, var_4);
          var_17 = add_space_to_string("| M:" + var_13.max_size, var_4);
          var_18 = add_space_to_string("| T:" + var_13.totalspawns, var_4);
          var_19 = add_space_to_string("| D:" + var_11.currentmodulekills, var_4);
          var_3 = add_space_to_string(var_13.status + "|" + var_8, var_5) + "[" + var_10 + "] " + var_15 + var_16 + var_17 + var_19 + var_18;
          var_0 += 15;
        }
      }
    }

    waitframe();
  }
}

function create_background() {
  level.menu_background = create_hudelem();
  level.menu_background setshader("black", 350, 110);
  level.menu_background.color = (0.2, 0.2, 0.2);
  level.menu_background.alpha = 0.1;
  level.menu_background.sort = -20;
}

function create_hudelem(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  if(!isDefined(var_5)) {
    var_5 = 20;
  }

  var_6 = newhudelem();
  var_6.location = 0;
  var_6.alignx = "left";
  var_6.aligny = "middle";
  var_6.vertalign = "top";
  var_6.horzalign = "left";
  var_6.foreground = 1;
  var_6.fontscale = 1;
  var_6.sort = define_var_if_undefined(var_5, 1);
  var_6.alpha = define_var_if_undefined(var_4, 0.1);
  var_6.x = define_var_if_undefined(var_1, 0);
  var_6.y = define_var_if_undefined(var_2, 85);
  var_6.og_scale = 1;
  var_6.archived = 0;

  if(isDefined(var_0)) {
    var_6.text = var_0;

    if(isnumber(var_0)) {
      var_6 setvalue(var_0);
    } else {
      var_6 clearalltextafterhudelem();
    }
  }

  return var_6;
}

function add_space_to_string(var_0, var_1) {
  if(var_0.size > var_1.size) {
    return getsubstr(var_0, 0, var_1.size);
  }

  var_2 = getsubstr(var_1, 0, var_1.size - var_0.size);

  if(isDefined(var_2) && var_2.size > 0) {
    return (var_0 + var_2);
  }

  return var_0;
}

function is_group_active() {
  if(isDefined(level.active_spawn_module_structs) && level.active_spawn_module_structs.size > 0) {
    var_0 = getarraykeys(level.active_spawn_module_structs);

    for(var_1 = 0; var_1 < level.active_spawn_module_structs.size; var_1++) {
      var_2 = var_0[var_1];

      if(scripts\engine\utility::array_contains(level.active_spawn_module_structs[var_2], self)) {
        return 1;
      }
    }

    return 0;
  }

  return 0;
}

function create_module_debug_struct() {
  var_0 = spawnStruct();
  var_0.status = "running";
  var_0.min_size = 0;
  var_0.max_size = 0;
  var_0.totalspawns = 0;
  self.debug_data = var_0;
}

function change_module_status(var_0, var_1) {}

function get_module_debug_data() {
  return self.debug_data;
}

function agent_use_door_spawner(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 notify("door_being_used");
  var_1 notify("door_being_used");
  var_1 endon("door_being_used");

  foreach(var_8 in var_2) {
    if(!var_8 scripts\engine\utility::ent_flag_exist("max_spawns_reached")) {
      var_8 scripts\engine\utility::ent_flag_init("max_spawns_reached");
    }

    if(!var_8 scripts\engine\utility::ent_flag_exist("using_intro_anim")) {
      var_8 scripts\engine\utility::ent_flag_init("using_intro_anim");
    }
  }

  var_1 asmsetstate(var_1.asmname, "animscripted");
  var_1 scripts\asm\asm_bb::bb_setanimScripted();
  var_1.ignoreall = 1;
  var_1.scripted_mode = 1;
  var_10 = undefined;
  var_11 = 2;
  var_12 = undefined;
  thread decrement_door_count_on_death(var_1, var_0, var_1, var_6);

  if(isDefined(level.spawn_ldoor_anims)) {
    if(var_0.spawners_using == 1) {
      foreach(var_8 in var_2) {
        set_door_state(var_8, "open_started", var_6);
      }

      thread soldier_wait_for_door_open_sequence(var_1, var_0, var_1, var_2, var_3, var_4, var_5, var_6);
      return;
    }

    thread soldier_wait_for_door_open_sequence(var_1, var_0, var_1, var_2, var_3, var_4, var_5);
    return;
  }

  foreach(var_8 in var_2) {
    set_door_state(var_8, "open_started", var_6);
  }

  thread soldier_wait_for_door_open_sequence(var_1, var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

function decrement_door_count_on_death(var_0, var_1, var_2, var_3) {
  level endon("game_ended");

  if(!isDefined(var_0.spawners_using)) {
    var_0.spawners_using = 0;
  }

  var_0.spawners_using++;

  if(isDefined(var_2) && isDefined(var_2.script_reuse_max)) {
    var_4 = var_2.script_reuse_max;
  } else {
    var_4 = 3;
  }

  if(var_1.spawners_using >= var_4) {
    foreach(var_6 in var_4) {
      var_6 thread scripts\engine\utility::ent_flag_set_delayed("max_spawns_reached", 0.25);
    }
  }

  var_2 scripts\engine\utility::ref_143a5("death", "door_infil_anim_completed");
  decrement_spawners_using_count(var_1, var_4);
}

function decrement_spawners_using_count(var_0, var_1) {
  var_2 = var_0.spawners_using;

  if(var_2 <= 0) {
    var_2 = 0;
  } else {
    var_2--;
  }

  var_0.spawners_using = var_2;

  if(var_0.spawners_using <= 0) {
    foreach(var_4 in var_1) {
      set_door_state(var_4, "door_closing");
    }

    return;
  }
}

function soldier_wait_for_door_open_sequence(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_1 notify("soldier_wait_for_door_open_sequence");
  var_1 endon("soldier_wait_for_door_open_sequence");
  var_1 endon("death");
  var_8 = undefined;
  var_9 = undefined;
  var_10 = 7;
  var_1.invulnerable = 1;
  var_1.animname = "ai_spawn_door_soldier";
  var_11 = 0;
  var_12 = undefined;
  var_1 scripts\engine\utility::disable_pain();

  if(isDefined(var_0.anim_node)) {
    var_13 = var_0.anim_node;
  } else {
    var_13 = var_1;
  }

  if(istrue(var_8) || !isDefined(var_1.last_ai_spawn_anim)) {
    if(getDvar("scr_door_anim_override", "") != "") {
      var_14 = getDvar("scr_door_anim_override", "");
      var_2.ai_door_anim = var_14;
    } else {
      var_14 = scripts\cp\cp_ai_spawn_anim_skits::get_spawn_anim(var_2, var_8, var_3);
      var_3.ai_door_anim = var_14;
    }

    thread ai_spawn_door_interal(var_2, var_2, var_3, var_13, var_4, var_5, var_6);
  } else {
    if(var_3 scripts\engine\utility::ent_flag("using_intro_anim")) {
      var_3 scripts\engine\utility::ent_flag_waitopen("using_intro_anim");
    }

    var_14 = get_follow_anim_from_breach_anim(var_3.last_ai_spawn_anim);
    var_4.ai_door_anim = var_14;
  }

  if(var_3 scripts\engine\utility::ent_flag("using_intro_anim")) {
    var_3 scripts\engine\utility::ent_flag_waitopen("using_intro_anim");
  }

  if(var_3 scripts\engine\utility::ent_flag("using_intro_anim")) {
    var_3 scripts\engine\utility::ent_flag_waitopen("using_intro_anim");
  }

  if(var_4.agent_type != "juggernaut") {
    var_4.ai_door_anim = var_14;
    var_3.last_ai_spawn_anim = var_14;
  }

  var_3 scripts\engine\utility::ent_flag_wait("max_spawns_reached");

  if(var_4.agent_type != "juggernaut") {
    var_11 = var_4 scripts\asm\asm::asm_lookupanimfromalias("animscripted", var_4.ai_door_anim);
    var_12 = var_4 scripts\asm\asm::asm_getxanim("animscripted", var_11);
    var_15 = var_14.origin;
    var_16 = var_14.angles;

    if(scripts\cp\cp_ai_spawn_anim_skits::is_double_door(var_9)) {
      var_15 = scripts\cp\cp_ai_spawn_anim_skits::get_double_door_mid_point(var_9);
    }

    var_6 = getstartorigin(var_15, var_16, var_12);
    var_7 = getstartangles(var_15, var_16, var_12);
    var_4 dontinterpolate();
    var_4 forceteleport(var_6, var_7);
  }

  foreach(var_18 in var_5) {
    set_door_state(var_18, "opening", var_9);
  }

  var_3 scripts\engine\utility::ent_flag_wait("door_opening");
  var_4.invulnerable = undefined;

  if(var_4.agent_type != "juggernaut") {
    var_4 aisetanim("animscripted", var_11);
    var_4 animmode("noclip");
    var_13 = getanimlength(var_12);
    run_door_spawn_end_funcs(var_4, var_3, var_8, var_13, var_5, var_14);
    return;
  }

  if(isDefined(var_4.enemy)) {
    set_goal_pos(var_4, var_4.enemy.origin);
  } else {
    var_20 = scripts\cp\utility::get_array_of_valid_players(1, var_4.origin)[0];

    if(isDefined(var_20)) {
      set_goal_pos(var_4, var_20.origin);
    }
  }

  run_door_spawn_end_funcs(var_4, var_3, var_8, var_13, var_5);
}

function play_intro_animation(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_1 endon("death");
  var_0.last_ai_spawn_anim = var_2;
  var_4 = var_1 scripts\asm\asm::asm_lookupanimfromalias("animscripted", var_2);
  var_5 = var_1 scripts\asm\asm::asm_getxanim("animscripted", var_4);
  var_6 = var_0.origin;
  var_7 = var_0.angles;
  var_8 = getstartorigin(var_6, var_7, var_5);
  var_9 = getstartangles(var_6, var_7, var_5);
  var_1 dontinterpolate();
  var_1 forceteleport(var_8, var_9);
  var_10 = spawn("script_model", var_0.origin);
  var_10 setModel("offhand_wm_grenade_smoke");
  wait 0.2;
  var_1 aisetanim("animscripted", var_4);
  var_1 animmode("noclip");
  var_11 = getanimlength(var_5);
  var_12 = get_door_anim_from_ai_anim(var_2);

  if(isDefined(var_0.linkedpents)) {
    foreach(var_14 in var_0.linkedpents) {
      var_14.animname = "ai_spawn_door";
      var_14 useanimtree(level.scr_animtree[var_14.animname]);
      var_0 thread scripts\common\anim::anim_single_solo(var_14, var_12);
    }
  } else if(isDefined(var_0.targetmodels)) {
    foreach(var_14 in var_0.targetmodels) {
      var_14.animname = "ai_spawn_door";
      var_14 useanimtree(level.scr_animtree[var_14.animname]);
      var_0 thread scripts\common\anim::anim_single_solo(var_14, var_12);
    }
  } else if(isent(var_0)) {
    var_0.animname = "ai_spawn_door";
    var_0 useanimtree(level.scr_animtree[var_0.animname]);
    var_0 thread scripts\common\anim::anim_single_solo(var_0, var_12);
  }

  wait var_11;
  var_10 delete();
  wait 1;

  foreach(var_19 in var_3) {
    var_19 scripts\engine\utility::ent_flag_clear("using_intro_anim");
  }
}

function ai_spawn_door_interal(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 notify("ai_spawn_door_interal");
  var_0 endon("ai_spawn_door_interal");
  var_2 = "wood_door_kick";
  var_7 = get_door_anim_from_ai_anim(var_1.ai_door_anim);

  if(isDefined(level.scr_anim["ai_spawn_door"][var_7])) {
    var_8 = getanimlength(level.scr_anim["ai_spawn_door"][var_7]);
    var_9 = 0.5;
  } else {
    var_8 = 5;
    var_9 = 0.5;
  }

  thread run_open_door_anim(var_2, var_2, var_4, var_9, var_8, var_9, var_8);

  if(var_2 scripts\engine\utility::ent_flag("using_intro_anim")) {
    var_2 scripts\engine\utility::ent_flag_waitopen("using_intro_anim");
  }

  var_2 scripts\engine\utility::ent_flag_wait_or_timeout("max_spawns_reached", 3);

  foreach(var_11 in var_5) {
    var_11 scripts\engine\utility::ent_flag_set("max_spawns_reached");
  }

  var_2 scripts\engine\utility::ent_flag_wait("door_opening");
  wait 0.75;

  if(isDefined(var_4) && soundexists(var_4)) {
    scripts\cp\utility::playsoundinspace(var_4, var_6);
    return;
  }
}

function run_door_spawn_end_funcs(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("death");

  if(isDefined(var_3)) {
    var_0 thread scripts\cp\utility::notify_delay("door_infil_anim_completed", var_3);
    var_6 = max(0.05, var_3 - 0.25);
    wait var_6;
  }

  var_0.ignoreall = 0;

  if(isDefined(var_2)) {
    [[var_2]](var_0);
    return;
  }

  if(var_0.agent_type != "juggernaut") {
    set_goal_radius(var_0, 2000);
    var_0 scripts\engine\utility::enable_pain();
    var_0 animmode("normal");
  } else {
    set_goal_radius(var_0, 128);
  }

  var_0 scripts\asm\shared\mp\utility::bunkercounteruav();

  if(isDefined(var_0.spawnpoint.target)) {
    thread start_patrol();
    return;
  }

  thread enter_combat();
}

function run_open_door_anim(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_0 notify("run_open_door_anim");
  var_0 endon("run_open_door_anim");
  var_0 scripts\engine\utility::ent_flag_wait("door_opening");

  if(isDefined(var_0.anim_node)) {
    var_7 = var_0.anim_node;
  } else {
    var_7 = var_1;
  }

  if(isDefined(var_1.linkedpents)) {
    foreach(var_9 in var_1.linkedpents) {
      var_9.animname = "ai_spawn_door";
      var_9 useanimtree(level.scr_animtree[var_9.animname]);
      var_7 thread scripts\common\anim::anim_single_solo(var_9, var_3);
      var_9 notify("door_opened");
    }
  } else if(isDefined(var_1.targetmodels)) {
    foreach(var_9 in var_1.targetmodels) {
      var_9.animname = "ai_spawn_door";
      var_9 useanimtree(level.scr_animtree[var_9.animname]);
      var_7 thread scripts\common\anim::anim_single_solo(var_9, var_3);
      var_9 notify("door_opened");
    }
  } else if(isent(var_1)) {
    var_1.animname = "ai_spawn_door";
    var_1 useanimtree(level.scr_animtree[self.animname]);
    var_7 thread scripts\common\anim::anim_single_solo(var_1, var_3);
    var_1 notify("door_opened");
  }

  wait_for_door_anim_end(var_1, var_4, var_5, var_6, var_7, var_3);
}

function wait_for_door_anim_end(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  var_0 notify("wait_for_door_anim_end");
  var_0 endon("wait_for_door_anim_end");

  foreach(var_7 in var_4) {
    set_door_state(var_7, "opened", var_3);
  }

  wait max(0, var_1 + 1.25);

  foreach(var_7 in var_4) {
    set_door_state(var_7, "closed", var_3);
  }
}

function subway_black_screen() {
  if(!scripts\engine\utility::ent_flag_exist("door_closed")) {
    scripts\engine\utility::ent_flag_init("door_closed");
  }

  if(!scripts\engine\utility::ent_flag_exist("door_opened")) {
    scripts\engine\utility::ent_flag_init("door_opened");
  }

  if(!scripts\engine\utility::ent_flag_exist("door_opening")) {
    scripts\engine\utility::ent_flag_init("door_opening");
  }

  if(!scripts\engine\utility::ent_flag_exist("door_closing")) {
    scripts\engine\utility::ent_flag_init("door_closing");
  }

  if(!scripts\engine\utility::ent_flag_exist("door_open_started")) {
    scripts\engine\utility::ent_flag_init("door_open_started");
    return;
  }
}

function set_door_state(var_0, var_1, var_2) {
  subway_black_screen(var_0);
  var_0.current_state = var_1;
  var_0 scripts\engine\utility::ent_flag_clear("using_intro_anim");

  switch (var_1) {
    case "opening":
      var_0 scripts\engine\utility::ent_flag_clear("door_closed");
      var_0 scripts\engine\utility::ent_flag_clear("door_opened");
      var_0 scripts\engine\utility::ent_flag_set("door_opening");
      var_0 scripts\engine\utility::ent_flag_clear("door_closing");
      var_0 scripts\engine\utility::ent_flag_clear("door_open_started");
      break;
    case "door_closing":
      var_0 scripts\engine\utility::ent_flag_clear("door_closed");
      var_0 scripts\engine\utility::ent_flag_clear("door_opened");
      var_0 scripts\engine\utility::ent_flag_clear("door_opening");
      var_0 scripts\engine\utility::ent_flag_set("door_closing");
      var_0 scripts\engine\utility::ent_flag_clear("door_open_started");
      break;
    case "opened":
      var_0 scripts\engine\utility::ent_flag_clear("door_closed");
      var_0 scripts\engine\utility::ent_flag_set("door_opened");
      var_0 scripts\engine\utility::ent_flag_clear("door_opening");
      var_0 scripts\engine\utility::ent_flag_clear("door_closing");
      var_0 scripts\engine\utility::ent_flag_clear("door_open_started");
      break;
    case "closed":
      var_0 scripts\engine\utility::ent_flag_set("door_closed");
      var_0 scripts\engine\utility::ent_flag_clear("door_opened");
      var_0 scripts\engine\utility::ent_flag_clear("door_opening");
      var_0 scripts\engine\utility::ent_flag_clear("door_closing");
      var_0 scripts\engine\utility::ent_flag_clear("door_open_started");
      var_0.last_ai_spawn_anim = undefined;
      var_0.spawners_using = 0;
      var_0 scripts\engine\utility::ent_flag_clear("max_spawns_reached");

      if(isDefined(var_2)) {
        mounted(var_2);
        var_2.door = undefined;
        var_2.used_recently = undefined;
        var_2.count = 0;
      }

      break;
    case "open_started":
      var_0 scripts\engine\utility::ent_flag_clear("door_closed");
      var_0 scripts\engine\utility::ent_flag_clear("door_opened");
      var_0 scripts\engine\utility::ent_flag_clear("door_opening");
      var_0 scripts\engine\utility::ent_flag_clear("door_closing");
      var_0 scripts\engine\utility::ent_flag_set("door_open_started");
      break;
  }
}

function get_follow_anim_from_breach_anim(var_0) {
  switch (var_0) {
    case "sdr_com_inter_ldoor_kick_ex_run_a_alt":
    case "sdr_com_inter_ldoor_kick_ex_run_a":
      return "sdr_com_inter_ldoor_kick_ex_run_b";
    case "sdr_com_inter_ldoor_kick_ex_run_b":
      return "sdr_com_inter_ldoor_kick_ex_run_c";
    case "sdr_com_inter_ldoor_kick_ex_run_c":
      return scripts\engine\utility::random(level.spawn_ldoor_anims);
    case "sdr_com_inter_ldoor_kick_ex_cqb_a":
      return "sdr_com_inter_ldoor_kick_ex_cqb_b";
    case "sdr_com_inter_ldoor_kick_ex_cqb_b":
      return "sdr_com_inter_ldoor_kick_ex_cqb_c";
    case "sdr_com_inter_ldoor_kick_ex_cqb_c":
      return scripts\engine\utility::random(level.spawn_dbldoor_anims);
    case "sdr_com_inter_dbldoor_kick_ex_run_a":
      return "sdr_com_inter_dbldoor_kick_ex_run_b";
    case "sdr_com_inter_dbldoor_kick_ex_run_b":
      return "sdr_com_inter_dbldoor_kick_ex_run_c";
    case "sdr_com_inter_dbldoor_kick_ex_run_c":
      return scripts\engine\utility::random(level.spawn_dbldoor_anims);
    case "sdr_com_inter_dbldoor_kick_ex_cqb_a":
      return "sdr_com_inter_dbldoor_kick_ex_cqb_b";
    case "sdr_com_inter_dbldoor_kick_ex_cqb_b":
      return "sdr_com_inter_dbldoor_kick_ex_cqb_c";
    case "sdr_com_inter_dbldoor_kick_ex_cqb_c":
      return scripts\engine\utility::random(level.spawn_dbldoor_anims);
    case "sdr_com_inter_ldoor_wall_kick_ex_run_a":
      return "sdr_com_inter_ldoor_wall_kick_ex_run_b";
    case "sdr_com_inter_ldoor_wall_kick_ex_run_b":
      return "sdr_com_inter_ldoor_wall_kick_ex_run_c";
    case "sdr_com_inter_ldoor_wall_kick_ex_run_c":
      return scripts\engine\utility::random(level.spawn_ldoor_anims);
    case "sdr_com_inter_ldoor_wall_kick_ex_cqb_a":
      return "sdr_com_inter_ldoor_wall_kick_ex_cqb_b";
    case "sdr_com_inter_ldoor_wall_kick_ex_cqb_b":
      return "sdr_com_inter_ldoor_wall_kick_ex_cqb_c";
    case "sdr_com_inter_ldoor_wall_kick_ex_cqb_c":
      return scripts\engine\utility::random(level.spawn_ldoor_anims);
    case "sdr_com_inter_rdoor_wall_kick_ex_run_a":
      return "sdr_com_inter_rdoor_wall_kick_ex_run_b";
    case "sdr_com_inter_rdoor_wall_kick_ex_run_b":
      return "sdr_com_inter_rdoor_wall_kick_ex_run_c";
    case "sdr_com_inter_rdoor_wall_kick_ex_run_c":
      return scripts\engine\utility::random(level.spawn_rdoor_anims);
    case "sdr_com_inter_rdoor_wall_kick_ex_cqb_a":
      return "sdr_com_inter_rdoor_wall_kick_ex_cqb_b";
    case "sdr_com_inter_rdoor_wall_kick_ex_cqb_b":
      return "sdr_com_inter_rdoor_wall_kick_ex_cqb_c";
    case "sdr_com_inter_rdoor_wall_kick_ex_cqb_c":
      return scripts\engine\utility::random(level.spawn_rdoor_anims);
    case "sdr_com_inter_ldoor_wall_tac_ex_cqb_a":
      return "sdr_com_inter_ldoor_wall_tac_ex_cqb_b";
    case "sdr_com_inter_ldoor_wall_tac_ex_cqb_b":
      return "sdr_com_inter_ldoor_wall_tac_ex_cqb_c";
    case "sdr_com_inter_ldoor_wall_tac_ex_cqb_c":
      return scripts\engine\utility::random(level.spawn_ldoor_anims);
    case "sdr_com_inter_ldoor_tac_ex_cqb_a":
      return "sdr_com_inter_ldoor_tac_ex_cqb_b";
    case "sdr_com_inter_ldoor_tac_ex_cqb_b":
      return "sdr_com_inter_ldoor_tac_ex_cqb_c";
    case "sdr_com_inter_ldoor_tac_ex_cqb_c":
      return scripts\engine\utility::random(level.spawn_ldoor_anims);
    case "sdr_com_inter_rdoor_wall_tac_ex_cqb_a":
      return "sdr_com_inter_rdoor_wall_tac_ex_cqb_b";
    case "sdr_com_inter_rdoor_wall_tac_ex_cqb_b":
      return "sdr_com_inter_rdoor_wall_tac_ex_cqb_c";
    case "sdr_com_inter_rdoor_wall_tac_ex_cqb_c":
      return scripts\engine\utility::random(level.spawn_rdoor_anims);
    case "sdr_com_inter_ldoor_90_pull_ex_idle_a":
      return "sdr_com_inter_ldoor_90_pull_ex_idle_b";
    case "sdr_com_inter_ldoor_90_pull_ex_idle_b":
      return "sdr_com_inter_ldoor_90_pull_ex_idle_c";
    case "sdr_com_inter_ldoor_90_pull_ex_idle_c":
      return scripts\engine\utility::random(level.spawn_ldoor_anims);
    case "sdr_com_inter_rdoor_90_pull_ex_idle_a":
      return "sdr_com_inter_rdoor_90_pull_ex_idle_b";
    case "sdr_com_inter_rdoor_90_pull_ex_idle_b":
      return "sdr_com_inter_rdoor_90_pull_ex_idle_c";
    case "sdr_com_inter_rdoor_90_pull_ex_idle_c":
      return scripts\engine\utility::random(level.spawn_rdoor_anims);
    case "sdr_com_inter_rdoor_tac_ex_cqb_a":
      return "sdr_com_inter_rdoor_tac_ex_cqb_b";
    case "sdr_com_inter_rdoor_tac_ex_cqb_b":
      return "sdr_com_inter_rdoor_tac_ex_cqb_c";
    case "sdr_com_inter_rdoor_tac_ex_cqb_c":
      return scripts\engine\utility::random(level.spawn_rdoor_anims);
    case "sdr_com_inter_ldoor_wall_shoulder_ex_run_a":
      return "sdr_com_inter_ldoor_wall_shoulder_ex_run_b";
    case "sdr_com_inter_ldoor_wall_shoulder_ex_run_b":
      return "sdr_com_inter_ldoor_wall_shoulder_ex_run_c";
    case "sdr_com_inter_ldoor_wall_shoulder_ex_run_c":
      return scripts\engine\utility::random(level.spawn_ldoor_anims);
    case "sdr_com_inter_ldoor_shoulder_ex_run_a":
      return "sdr_com_inter_ldoor_shoulder_ex_run_b";
    case "sdr_com_inter_ldoor_shoulder_ex_run_b":
      return "sdr_com_inter_ldoor_shoulder_ex_run_c";
    case "sdr_com_inter_ldoor_shoulder_ex_run_c":
      return scripts\engine\utility::random(level.spawn_ldoor_anims);
    case "sdr_com_inter_rdoor_wall_shoulder_ex_run_a":
      return "sdr_com_inter_rdoor_wall_shoulder_ex_run_b";
    case "sdr_com_inter_rdoor_wall_shoulder_ex_run_b":
      return "sdr_com_inter_rdoor_wall_shoulder_ex_run_c";
    case "sdr_com_inter_rdoor_wall_shoulder_ex_run_c":
      return scripts\engine\utility::random(level.spawn_rdoor_anims);
    case "sdr_com_inter_ldoor_flash_a":
      return "sdr_com_inter_ldoor_flash_grenade";
    case "sdr_com_inter_ldoor_flash_grenade":
      return "sdr_com_inter_ldoor_flash_a";
    case "sdr_com_inter_ldoor_smoke_a":
      return "sdr_com_inter_ldoor_smoke_grenade";
    case "sdr_com_inter_ldoor_smoke_grenade":
      return "sdr_com_inter_ldoor_smoke_a";
    case "sdr_com_inter_rdoor_flash_a":
      return "sdr_com_inter_rdoor_flash_grenade";
    case "sdr_com_inter_rdoor_flash_grenade":
      return "sdr_com_inter_rdoor_flash_a";
    case "sdr_com_inter_rdoor_smoke_a":
      return "sdr_com_inter_rdoor_smoke_grenade";
    case "sdr_com_inter_rdoor_smoke_grenade":
      return "sdr_com_inter_rdoor_smoke_a";
  }
}

function get_door_anim_from_ai_anim(var_0) {
  if(!isDefined(var_0)) {
    return "sdr_com_inter_rdoor_wall_kick_ex_run_door";
  }

  switch (var_0) {
    case "sdr_com_inter_ldoor_90_pull_ex_idle_a":
      return "sdr_com_inter_ldoor_90_pull_ex_idle_door";
    case "sdr_com_inter_rdoor_90_pull_ex_idle_a":
      return "sdr_com_inter_rdoor_90_pull_ex_idle_door";
    case "sdr_com_inter_ldoor_kick_ex_run_a_alt":
    case "sdr_com_inter_ldoor_kick_ex_run_a":
      return "sdr_com_inter_ldoor_kick_ex_run_door";
    case "sdr_com_inter_ldoor_kick_ex_cqb_a":
      return "sdr_com_inter_ldoor_kick_ex_cqb_door";
    case "sdr_com_inter_dbldoor_kick_ex_run_a":
      return "sdr_com_inter_dbldoor_kick_ex_run_doorr";
    case "sdr_com_inter_dbldoor_kick_ex_cqb_a":
      return "sdr_com_inter_dbldoor_kick_ex_cqb_doorr";
    case "sdr_com_inter_ldoor_wall_kick_ex_run_a":
      return "sdr_com_inter_ldoor_wall_kick_ex_run_door";
    case "sdr_com_inter_ldoor_wall_kick_ex_cqb_a":
      return "sdr_com_inter_ldoor_wall_kick_ex_cqb_door";
    case "sdr_com_inter_rdoor_wall_kick_ex_run_a":
      return "sdr_com_inter_rdoor_wall_kick_ex_run_door";
    case "sdr_com_inter_rdoor_wall_kick_ex_cqb_a":
      return "sdr_com_inter_rdoor_wall_kick_ex_cqb_door";
    case "sdr_com_inter_ldoor_wall_tac_ex_cqb_a":
      return "sdr_com_inter_ldoor_wall_tac_ex_cqb_door";
    case "sdr_com_inter_ldoor_tac_ex_cqb_a":
      return "sdr_com_inter_ldoor_tac_ex_cqb_door";
    case "sdr_com_inter_rdoor_wall_tac_ex_cqb_a":
      return "sdr_com_inter_rdoor_wall_tac_ex_cqb_door";
    case "sdr_com_inter_rdoor_tac_ex_cqb_a":
      return "sdr_com_inter_rdoor_tac_ex_cqb_door";
    case "sdr_com_inter_ldoor_wall_shoulder_ex_run_a":
      return "sdr_com_inter_ldoor_wall_shoulder_ex_run_door";
    case "sdr_com_inter_ldoor_shoulder_ex_run_a":
      return "sdr_com_inter_ldoor_shoulder_ex_run_door";
    case "sdr_com_inter_rdoor_wall_shoulder_ex_run_a":
      return "sdr_com_inter_rdoor_wall_shoulder_ex_run_door";
    case "sdr_com_inter_ldoor_flash_a":
      return "sdr_com_inter_ldoor_flash_door";
    case "sdr_com_inter_ldoor_flash_grenade":
      return "sdr_com_inter_ldoor_flash_door";
    case "sdr_com_inter_ldoor_smoke_a":
      return "sdr_com_inter_ldoor_smoke_door";
    case "sdr_com_inter_ldoor_smoke_grenade":
      return "sdr_com_inter_ldoor_smoke_door";
    case "sdr_com_inter_rdoor_flash_a":
      return "sdr_com_inter_rdoor_flash_door";
    case "sdr_com_inter_rdoor_flash_grenade":
      return "sdr_com_inter_rdoor_flash_a";
    case "sdr_com_inter_rdoor_smoke_a":
      return "sdr_com_inter_rdoor_smoke_door";
    case "sdr_com_inter_rdoor_smoke_grenade":
      return "sdr_com_inter_rdoor_smoke_a";
  }

  return var_0;
}

function _open_door(var_0, var_1) {
  var_0.angles = var_0.vopenedangles;

  if(isDefined(var_0.linkedpents)) {
    set_door_state(var_0, "opening");

    foreach(var_3 in var_0.linkedpents) {
      if(isDefined(var_3.collision)) {
        var_3.collision connectpaths();

        if(istrue(var_1)) {
          var_3.collision delete();
        }
      }

      var_3 rotateTo(var_0.angles, 0.75);
    }

    wait 0.75;
  }

  set_door_state(var_0, "opened");
  scripts\cp\coop_personal_ents::update_special_mode_for_all_players();
}

function add_global_spawn_function(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level.global_ai_func_array)) {
    level.global_ai_func_array = [];
  }

  if(!isDefined(level.global_ai_func_array[var_0])) {
    level.global_ai_func_array[var_0] = [];
  }

  var_6 = [];
  GscBinSkip0(0x2e, "function", var_1);
}

function remove_global_spawn_function(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < level.global_ai_func_array[var_0].size; var_3++) {
    if(level.global_ai_func_array[var_0][var_3]["function"] != var_1) {
      var_2 = level.global_ai_func_array[var_0][var_3];
    }
  }

  level.global_ai_func_array[var_0] = var_2;
}

function exists_global_spawn_function(var_0, var_1) {
  if(!isDefined(level.global_ai_func_array)) {
    return false;
  }

  for(var_2 = 0; var_2 < level.global_ai_func_array[var_0].size; var_2++) {
    if(level.global_ai_func_array[var_0][var_2]["function"] == var_1) {
      return true;
    }
  }

  return false;
}

function init_passive_wave_struct() {
  var_0 = spawnStruct();
  var_0.high_threshold = undefined;
  var_0.low_threshold = undefined;
  var_0.spawn_window_time = 5;
  var_0.wave_spawn_time = 15;
  var_0.min_count = 0;
  var_0.max_count = 48;
  var_0.wave_time_between_spawns = 1;
  var_0.disable_wave_hud = 0;
  self.passive_wave_settings = var_0;
}

function override_passive_wave_spawning_spawners(var_0) {
  if(!scripts\engine\utility::array_contains(self.wave_spawner_overrides, var_0)) {
    self.wave_spawner_overrides[self.wave_spawner_overrides.size] = var_0;
    return;
  }
}

function remove_passive_wave_spawning_spawner_override(var_0) {
  if(scripts\engine\utility::array_contains(self.wave_spawner_overrides, var_0)) {
    self.wave_spawner_overrides = scripts\engine\utility::array_remove(self.wave_spawner_overrides, var_0);
    return;
  }
}

function add_spawners_to_passive_wave_spawning(var_0) {
  if(!scripts\engine\utility::array_contains(self.requested_spawners, var_0)) {
    var_1 = scripts\engine\utility::getStructArray(var_0, "targetname");

    if(var_1.size > 0) {
      self.requested_spawners[self.requested_spawners.size] = var_0;
      scripts\engine\utility::array_thread(var_1, &spawner_init);
      return;
    }

    return;
  }
}

function remove_spawners_from_passive_wave_spawning(var_0) {
  if(scripts\engine\utility::array_contains(self.requested_spawners, var_0)) {
    self.requested_spawners = scripts\engine\utility::array_remove(self.requested_spawners, var_0);
    return;
  }
}

function battle_stations(var_0) {
  if(!scripts\engine\utility::array_contains(self.ref_12c43, var_0)) {
    var_1 = scripts\engine\utility::getStructArray(var_0, "targetname");

    if(var_1.size > 0) {
      self.ref_12c43[self.ref_12c43.size] = var_0;
      scripts\engine\utility::array_thread(var_1, &spawner_init);
      return;
    }

    return;
  }
}

function ref_12bfb(var_0) {
  if(scripts\engine\utility::array_contains(self.ref_12c43, var_0)) {
    self.ref_12c43 = scripts\engine\utility::array_remove(self.ref_12c43, var_0);
    return;
  }
}

function set_passive_wave_high_threshold(var_0) {
  if(isDefined(self.passive_wave_settings)) {
    self.passive_wave_settings.high_threshold = var_0;
    return;
  }
}

function add_spawn_scoring_poi(var_0, var_1, var_2) {
  var_1 = define_var_if_undefined(var_1, 1024);
  var_2 = define_var_if_undefined(var_2, 2048);
  var_3 = spawnStruct();
  var_3.origin = var_0;
  var_3.angles = (0, 0, 0);
  var_3.radius = var_1;
  var_3.activation_radius_sq = var_2 * var_2;
  self.spawn_scoring_pois[self.spawn_scoring_pois.size] = var_3;
}

function remove_spawn_scoring_poi(var_0) {
  var_1 = self.spawn_scoring_pois;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_1[var_2].origin == var_0) {
      self.spawn_scoring_pois = scripts\engine\utility::array_remove(var_1, var_1[var_2]);
    }
  }
}

function init_airlock_buttons(var_0, var_1) {
  if(!isDefined(self.aitype_override)) {
    self.aitype_override = [];
    self.aitype_override_weights = [];
    self.aitype_override_cumulative_weight = 0;
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    self.aitype_override[self.aitype_override.size] = var_0[var_2];
    var_3 = define_var_if_undefined(var_1[var_2], 10);
    self.aitype_override_weights[self.aitype_override_weights.size] = var_3;
    self.aitype_override_cumulative_weight += var_3;
  }
}

function remove_aitype_spawner_override(var_0) {
  if(isDefined(self.aitype_override)) {
    var_1 = self.aitype_override;
    var_2 = self.aitype_override_weights;

    for(var_3 = 0; var_3 < var_1.size; var_3++) {
      if(var_1[var_3] == var_0) {
        self.aitype_override = scripts\engine\utility::array_remove(var_1, var_1[var_3]);
        self.aitype_override_weights = scripts\engine\utility::array_remove_index(var_2, var_3);
        self.aitype_override_cumulative_weight -= var_2[var_3];
      }
    }

    return;
  }
}

function get_passive_wave_high_threshold(var_0, var_1) {
  if(getdvarint("scr_wave_high_threshold", -1) != -1) {
    return getdvarint("scr_wave_high_threshold");
  }

  if(isDefined(self.passive_wave_settings) && isDefined(self.passive_wave_settings.high_threshold)) {
    return self.passive_wave_settings.high_threshold;
  }

  if(isDefined(var_1)) {
    return process_module_var(var_0, var_1);
  }

  return undefined;
}

function set_passive_wave_low_threshold(var_0) {
  if(isDefined(self.passive_wave_settings)) {
    self.passive_wave_settings.low_threshold = var_0;
    return;
  }
}

function get_passive_wave_low_threshold(var_0, var_1) {
  if(getdvarint("scr_wave_low_threshold", -1) != -1) {
    return getdvarint("scr_wave_low_threshold");
  }

  if(isDefined(self.passive_wave_settings) && isDefined(self.passive_wave_settings.low_threshold)) {
    return self.passive_wave_settings.low_threshold;
  }

  if(isDefined(var_1)) {
    return process_module_var(var_0, var_1);
  }

  return undefined;
}

function set_passive_spawn_window_time(var_0) {
  if(isDefined(self.passive_wave_settings)) {
    self.passive_wave_settings.spawn_window_time = var_0;
    return;
  }
}

function get_passive_spawn_window_time(var_0) {
  if(getdvarint("scr_spawn_window_time", 0) != 0) {
    return getdvarint("scr_spawn_window_time");
  }

  if(isDefined(self.passive_wave_settings) && isDefined(self.passive_wave_settings.spawn_window_time)) {
    return self.passive_wave_settings.spawn_window_time;
  }

  return 5;
}

function set_passive_wave_spawn_time(var_0) {
  if(isDefined(self.passive_wave_settings)) {
    self.passive_wave_settings.wave_spawn_time = var_0;
    return;
  }
}

function get_passive_wave_spawn_time(var_0) {
  if(getdvarint("scr_wave_cooldown_time", -1) != -1) {
    return getdvarint("scr_wave_cooldown_time");
  }

  if(isDefined(self.timeout_after_min_count)) {
    return self.timeout_after_min_count;
  }

  if(isDefined(self.passive_wave_settings) && isDefined(self.passive_wave_settings.wave_spawn_time)) {
    return self.passive_wave_settings.wave_spawn_time;
  }

  return 15;
}

function set_ambient_min_count(var_0) {
  if(isDefined(self.passive_wave_settings)) {
    self.passive_wave_settings.min_count = var_0;
    return;
  }
}

function get_ambient_min_count(var_0, var_1) {
  if(getdvarint("scr_wave_min_count", -1) != -1) {
    return getdvarint("scr_wave_min_count");
  }

  if(isDefined(self.passive_wave_settings) && isDefined(self.passive_wave_settings.min_count)) {
    return self.passive_wave_settings.min_count;
  }

  return var_1;
}

function set_ambient_max_count(var_0) {
  if(isDefined(self.passive_wave_settings)) {
    self.passive_wave_settings.max_count = var_0;
    return;
  }
}

function get_ambient_max_count(var_0, var_1) {
  if(getdvarint("scr_wave_max_count", -1) != -1) {
    return getdvarint("scr_wave_max_count");
  }

  if(isDefined(self.passive_wave_settings) && isDefined(self.passive_wave_settings.max_count)) {
    return self.passive_wave_settings.max_count;
  }

  return var_1;
}

function get_spawn_time_from_wave(var_0, var_1) {
  if(isDefined(self.wave_time_between_spawns)) {
    return self.wave_time_between_spawns;
  }

  return var_1;
}

function regenhealthaddfunc(var_0, var_1) {
  if(isDefined(var_0.min_count)) {
    return int(var_0.min_count);
  }

  return var_1;
}

function get_wave_high_threshold(var_0) {
  if(isDefined(var_0.high_threshold)) {
    return int(var_0.high_threshold);
  }

  return int(var_0.spawn_wave_total);
}

function get_current_wave_ref() {
  if(isDefined(level.first_wave_override)) {
    var_0 = level.first_wave_override;
    level.first_wave_override = undefined;
    return var_0;
  }

  if(isDefined(self.wave_reference_override)) {
    var_0 = self.wave_reference_override;
    self.wave_reference_override = undefined;
    return var_0;
  }

  if(isDefined(self.wave_reference)) {
    return self.wave_reference;
  }

  return undefined;
}

function set_wave_ref_override(var_0) {
  if(trophy_protection_success("wave_spawning")) {
    run_func_on_group_by_groupname("wave_spawning", [ &battle_tracks_clearbattletracks, var_0]);
    var_1 = get_module_structs_by_groupname("wave_spawning");

    if(isDefined(var_1) && var_1.size > 0) {
      var_1[0] thread scripts\cp\cp_wave_spawning::start_wave();
    }
  } else {
    level.first_wave_override = var_1;
    var_1 = run_spawn_module("wave_spawning");
  }

  return var_1;
}

function battle_tracks_clearbattletracks(var_0, var_1) {
  level notify("timeout_wave");
  var_0 notify("wave_spawn");
  var_0 notify("wave_go_kamikaze");
  toggle_force_stop_wave_from_groupname("wave_spawning", undefined, "new_wave_starting");
  toggle_force_stop_wave_from_groupname("wave_paratroopers", undefined, "new_wave_starting");
  run_func_on_group_by_groupname("wave_spawning", [ &toggle_kamikaze_for_group, undefined]);
  set_wave_settings_for_all_with_groupname("wave_spawning", var_1, var_0.wave_reference, var_0.last_wave_num);
  var_0.next_wave = var_1;
  var_0.wave_reference_override = var_1;
}

function trophy_protection_success(var_0) {
  return isDefined(level.active_spawn_module_structs[var_0]);
}

function clear_wave_ref_override() {
  self.wave_reference_override = undefined;
}

function get_wave_max_spawns() {
  if(getdvarint("scr_wave_max_spawns", 0) != 0) {
    return getdvarint("scr_wave_max_spawns");
  }

  if(isDefined(self.wave_max_spawns)) {
    return self.wave_max_spawns;
  }

  return undefined;
}

function get_module_structs_by_groupname(var_0, var_1) {
  var_2 = [];

  if(!isarray(var_0)) {
    var_0 = [var_0];
  }

  if(istrue(var_1)) {
    var_3 = getarraykeys(level.spawn_module_structs_memory);
    var_4 = level.spawn_module_structs_memory;
  } else {
    var_3 = getarraykeys(level.active_spawn_module_structs);
    var_4 = level.active_spawn_module_structs;
  }

  for(var_5 = 0; var_5 < var_4.size; var_5++) {
    var_6 = var_4[var_3[var_5]];

    if(isarray(var_6)) {
      for(var_7 = 0; var_7 < var_6.size; var_7++) {
        var_8 = var_6[var_7];

        for(var_9 = 0; var_9 < var_2.size; var_9++) {
          if(var_8.group_name == var_2[var_9]) {
            var_4 = var_8;
          }
        }
      }

      continue;
    }

    for(var_9 = 0; var_9 < var_2.size; var_9++) {
      if(var_6.group_name == var_2[var_9]) {
        var_4 = var_6;
      }
    }
  }

  return var_4;
}

function remove_all_aitype_overrides() {
  remove_aitype_spawner_override("civ");
  remove_aitype_spawner_override("suits");
  remove_aitype_spawner_override("goliath");
  remove_aitype_spawner_override("goliath_bomber");
  remove_aitype_spawner_override("goliath_rpg");
  remove_aitype_spawner_override("smg");
  remove_aitype_spawner_override("hvt");
  remove_aitype_spawner_override("ar");
  remove_aitype_spawner_override("shotgun");
  remove_aitype_spawner_override("juggernaut");
  remove_aitype_spawner_override("suicidebomber");
  remove_aitype_spawner_override("rpg");
  remove_aitype_spawner_override("lmg");
  remove_aitype_spawner_override("sniper");
  remove_aitype_spawner_override("suicidebomber");
  remove_aitype_spawner_override("informant");
}

function show_all_player_wave_started_splash() {
  level endon("game_ended");
  self endon("death");
  self endon("show_all_player_wave_started_splash");

  if(turn_off_steam() || scripts\cp\utility::turn_off_sniper_laser()) {
    level notify("wave_starting");

    if(!isDefined(level.logfriendlyfire)) {
      level.logfriendlyfire = 1;
    } else {
      level.logfriendlyfire += 1;
    }

    setomnvar("cp_wave_number", level.logfriendlyfire);
    wait 0.1;

    for(var_0 = 0; var_0 < level.players.size; var_0++) {
      level.players[var_0] thread scripts\cp\cp_hud_message::showsplash("cp_wave_started", level.logfriendlyfire, undefined);
      level.players[var_0] setplayerdata("cp", "alienSession", "waveNum", level.logfriendlyfire);
      scripts\cp\cp_persistence::update_player_career_highest_wave(level.players[var_0], level.logfriendlyfire, level.players.size);
    }
  }

  wait 2;
}

function turn_off_steam() {
  return !istrue(self.disable_wave_hud);
}

function set_wave_settings() {
  if(isDefined(level.wave_table)) {
    var_0 = level.wave_table;
  } else if(getDvar("MOLPOSLOMO") == "cp_wave_sv") {
    var_0 = "cp/" + getDvar("NSQLTTMRMP") + "_wave_table.csv";
  } else {
    var_0 = "cp/cp_donetsk_wave_table.csv";
  }

  if(getdvarint("scr_use_wave_table", 1) && tableexists(var_0)) {
    var_1 = var_0;
    var_2 = "wave_spawning";

    if(isDefined(level.spawn_module_structs_memory[var_2])) {
      for(var_3 = 0; var_3 < level.spawn_module_structs_memory[var_2].size; var_3++) {
        var_4 = level.spawn_module_structs_memory[var_2][var_3];
        var_5 = get_current_wave_ref(var_4);
        var_4.valid_vehicles = [];
        var_4.valid_vehicles["lbravo_carrier"] = int(tablelookup(var_1, 0, var_5, 15));
        var_4.valid_vehicles["mindia8"] = int(tablelookup(var_1, 0, var_5, 16));
        var_4.valid_vehicles["mindia8_jugg"] = int(tablelookup(var_1, 0, var_5, 17));
        var_4.valid_vehicles["attack_heli"] = int(tablelookup(var_1, 0, var_5, 19));

        if(scripts\engine\utility::array_sum(var_4.valid_vehicles) > 0) {
          var_4.wave_use_vehicles = 1;
        }

        var_4.spawn_aitype_counts = [];
        var_4.spawn_aitype_counts["ar"] = int(tablelookup(var_1, 0, var_5, 1));
        var_4.spawn_aitype_counts["ar_heavy"] = int(tablelookup(var_1, 0, var_5, 2));
        var_4.spawn_aitype_counts["ar_heavy_laser"] = int(tablelookup(var_1, 0, var_5, 3));
        var_4.spawn_aitype_counts["smg"] = int(tablelookup(var_1, 0, var_5, 4));
        var_4.spawn_aitype_counts["smg_heavy"] = int(tablelookup(var_1, 0, var_5, 5));
        var_4.spawn_aitype_counts["shotgun"] = int(tablelookup(var_1, 0, var_5, 6));
        var_4.spawn_aitype_counts["shotgun_heavy"] = int(tablelookup(var_1, 0, var_5, 7));
        var_4.spawn_aitype_counts["rpg"] = int(tablelookup(var_1, 0, var_5, 8));
        var_4.spawn_aitype_counts["lmg"] = int(tablelookup(var_1, 0, var_5, 9));
        var_4.spawn_aitype_counts["lmg_heavy"] = int(tablelookup(var_1, 0, var_5, 10));
        var_4.spawn_aitype_counts["sniper"] = int(tablelookup(var_1, 0, var_5, 11));
        var_4.spawn_aitype_counts["goliath"] = int(tablelookup(var_1, 0, var_5, 12));
        var_4.spawn_aitype_counts["suicidebomber"] = int(tablelookup(var_1, 0, var_5, 13));
        var_4.spawn_aitype_counts["juggernaut"] = int(tablelookup(var_1, 0, var_5, 14));
        var_4.spawn_aitype_counts = remove_invalid_aitypes(var_4);
        var_4.wave_difficulty = int(tablelookup(var_1, 0, var_5, 22));
        var_4.high_threshold = int(tablelookup(var_1, 0, var_5, 23));
        var_4.min_count = int(tablelookup(var_1, 0, var_5, 24));
        var_4.ref_11e6b = int(tablelookup(var_1, 0, var_5, 25));
        var_4.timeout_after_min_count = int(tablelookup(var_1, 0, var_5, 26));
        var_4.next_wave = tablelookup(var_1, 0, var_5, 29);
        var_4.use_only_veh_spawners = int(tablelookup(var_1, 0, var_5, 32));
        var_4.paratroopers_allowed = int(tablelookup(var_1, 0, var_5, 20));
        var_4.ref_1451a = int(tablelookup(var_1, 0, var_5, 21));
        var_6 = float(tablelookup(var_1, 0, var_5, 30));
        var_4.wave_time_between_spawns = scripts\engine\utility::ter_op(var_6 > 0, var_6, 1);

        if(scripts\cp\utility::turn_off_sniper_laser()) {
          var_4.disable_wave_hud = int(tablelookup(var_1, 0, var_5, 31));
        } else {
          var_4.disable_wave_hud = 1;
        }

        var_4.spawn_wave_total = scripts\engine\utility::array_sum(var_4.spawn_aitype_counts) + var_4.paratroopers_allowed * 8;
        var_4.ref_13be5 = 0;
        var_4.requested_spawners = [];
        var_7 = strtok(tablelookup(var_1, 0, var_5, 27), ",");

        if(isDefined(var_7) && var_7.size > 0) {
          for(var_8 = 0; var_8 < var_7.size; var_8++) {
            add_spawners_to_passive_wave_spawning(var_4, var_7[var_8]);
          }
        }

        var_4.ref_12c43 = [];
        var_7 = strtok(tablelookup(var_1, 0, var_5, 28), ",");

        if(isDefined(var_7) && var_7.size > 0) {
          for(var_8 = 0; var_8 < var_7.size; var_8++) {
            battle_stations(var_4, var_7[var_8]);
          }
        }
      }

      return;
    }

    return;
  }
}

function ignoredeathsdoor(var_0, var_1) {
  if(isDefined(level.spawn_module_structs_memory[var_1])) {
    var_2 = level.spawn_module_structs_memory[var_1][0];
    var_0.high_threshold = var_2.high_threshold;
    var_0.ref_11e6b = var_2.ref_11e6b;
    var_0.min_count = var_2.min_count;
    var_0.disable_wave_hud = var_2.disable_wave_hud;
    return;
  }

  var_0.spawn_wave_total = var_0.totalspawns;
}

function pressure_stability_event_init(var_0) {
  var_1 = [];

  if(isDefined(self.script_type) && isDefined(var_0) && isarray(var_0) && var_0.size > 0) {
    if(!isarray(self.script_type)) {
      var_2 = strtok(self.script_type, ",");
      self.script_type = [];

      for(var_3 = 0; var_3 < var_2.size; var_3++) {
        self.script_type[self.script_type.size] = var_2[var_3];
      }
    }

    for(var_3 = 0; var_3 < self.script_type.size; var_3++) {
      if(scripts\engine\utility::array_contains(var_0, self.script_type[var_3])) {
        var_1 = self.script_type[var_3];
      }
    }

    return var_1;
  }

  return var_1;
}

function pressure_stability_event_start() {
  var_0 = [];
  var_1 = getarraykeys(self.valid_vehicles);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(self.valid_vehicles[var_1[var_2]] > 0) {
      var_0 = var_1[var_2];
    }
  }

  if(var_0.size > 0) {
    return var_0;
  }

  return undefined;
}

function remove_invalid_aitypes() {
  var_0 = getarraykeys(self.spawn_aitype_counts);

  for(var_1 = 0; var_1 < level.spawn_module_structs_memory[self.group_name].size; var_1++) {
    var_2 = level.spawn_module_structs_memory[self.group_name][var_1];

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      var_4 = var_0[var_3];

      if(isDefined(var_2.spawn_aitype_counts[var_4]) && var_2.spawn_aitype_counts[var_4] < 1) {
        var_2.spawn_aitype_counts[var_4] = undefined;
      }
    }
  }

  return self.spawn_aitype_counts;
}