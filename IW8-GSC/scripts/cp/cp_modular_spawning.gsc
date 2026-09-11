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
  var0 = ["dx_cps_kama_callout_armored_spawning_10", "dx_cps_kama_callout_armored_spawning_20"];
  var1 = ["dx_cps_kama_callout_drone_thrower_spawning_10", "dx_cps_kama_callout_drone_thrower_spawning_20"];
  var2 = ["dx_cps_kama_callout_enemy_squad_spawning_10", "dx_cps_kama_callout_enemy_squad_spawning_20", "dx_cps_kama_callout_enemy_squad_spawning_30", "dx_cps_lass_callout_enemy_squad_spawning_10", "dx_cps_lass_callout_enemy_squad_spawning_20", "dx_cps_lass_callout_enemy_squad_spawning_30"];
  var3 = ["dx_cps_kama_callout_juggernaut_spawning_10", "dx_cps_kama_callout_juggernaut_spawning_20", "dx_cps_lass_callout_juggernaut_spawning_10", "dx_cps_lass_callout_juggernaut_spawning_10"];
  var4 = ["dx_cps_kama_callout_sniper_spawning_10", "dx_cps_kama_callout_sniper_spawning_20", "dx_cps_kama_callout_sniper_spawning_30", "dx_cps_lass_callout_sniper_spawning_10", "dx_cps_lass_callout_sniper_spawning_20", "dx_cps_lass_callout_sniper_spawning_30"];
  var5 = ["dx_cps_kama_callout_suicide_bomber_spawning_10", "dx_cps_kama_callout_suicide_bomber_spawning_20", "dx_cps_lass_callout_suicide_bomber_spawning_10", "dx_cbc_aq1_reaction_hostile_burst", "dx_cbc_aq2_reaction_hostile_burst", "dx_cbc_aq3_reaction_hostile_burst", "dx_cbc_aq4_reaction_hostile_burst", "dx_cps_lass_callout_suicide_bomber_spawning_20"];
  register_aitype_setup("juggernaut", "actor_enemy_cp_rus_juggernaut", undefined, &set_juggernaut_flags, undefined, var3);
  register_aitype_setup("goliath", "actor_enemy_cp_rus_desert_ar_goliath", undefined, &select_patrol_nine_spawners, undefined, var2);
  register_aitype_setup("goliath_heavy", "actor_enemy_cp_rus_desert_ar_goliath", undefined, &select_patrol_nine_spawners, undefined, var0);
  register_aitype_setup("goliath_rpg", "actor_enemy_cp_rus_desert_rpg_goliath", undefined, undefined, undefined, var2);
  register_aitype_setup("smg", "actor_enemy_cp_alq_desert_smg", undefined, &circleorigin, undefined, undefined);
  register_aitype_setup("smg_heavy", "actor_enemy_cp_rus_desert_smg", undefined, &calloutmarkerpingvohandlerpool, undefined, var0);
  register_aitype_setup("ar", "actor_enemy_cp_alq_desert_ar", undefined, &circleorigin, undefined, var2);
  register_aitype_setup("ar_heavy", "actor_enemy_cp_rus_desert_ar_ak", undefined, &calloutmarkerpingvohandlerpool, undefined, var0);
  register_aitype_setup("ar_heavy_laser", "actor_enemy_cp_rus_desert_ar_ak_laser", undefined, &calloutmarkerpingvohandlerpool, undefined, var0);
  register_aitype_setup("shotgun", "actor_enemy_cp_alq_desert_shotgun", undefined, &circleorigin, undefined, undefined);
  register_aitype_setup("shotgun_heavy", "actor_enemy_cp_rus_desert_shotgun", undefined, &calloutmarkerpingvohandlerpool, undefined, var0);
  register_aitype_setup("suicidebomber", "actor_enemy_cp_alq_desert_bomber", &suicide_bomber_combat_func, &cp_suicidebomber_init, undefined, var5);
  register_aitype_setup("suicidebomber_heavy", "actor_enemy_cp_alq_desert_bomber", &suicide_bomber_combat_func, &cp_suicidebomber_init, undefined, var5);
  register_aitype_setup("rpg", "actor_enemy_cp_alq_desert_rpg", undefined, undefined, undefined, undefined);
  register_aitype_setup("rpg_heavy", "actor_enemy_cp_alq_desert_rpg", undefined, undefined, undefined, undefined);
  register_aitype_setup("riotshield", "actor_enemy_cp_rus_riotshield", undefined, undefined, undefined, var0);
  register_aitype_setup("riotshield_heavy", "actor_enemy_cp_rus_riotshield", undefined, undefined, undefined, var0);
  register_aitype_setup("sniper", "actor_enemy_cp_alq_desert_sniper", undefined, undefined, undefined, var4);
  register_aitype_setup("sniper_heavy", "actor_enemy_cp_alq_desert_sniper", undefined, undefined, undefined, var0);
  register_aitype_setup("lmg", "actor_enemy_cp_alq_desert_lmg", undefined, undefined, undefined, undefined);
  register_aitype_setup("lmg_heavy", "actor_enemy_cp_rus_desert_lmg", undefined, &calloutmarkerpingvohandlerpool, undefined, var0);
  register_aitype_setup("soldier_lw", "actor_enemy_lw_base", undefined, &circleorigin, undefined, var2);
  register_aitype_setup("vehicle_ai", "actor_converted_vehicle_ai", undefined, &circleorigin, undefined, undefined);
  register_aitype_setup("hvt", "actor_enemy_cp_alq_desert_ar_hvt", undefined, undefined, undefined, undefined);
  register_aitype_setup("ally_ar", "actor_ally_cp_usmc_ar", undefined, &circleorigin, undefined, undefined);
  register_aitype_setup("goliath_bomber", "actor_enemy_cp_alq_desert_crowd", &test_combat_func, undefined, undefined, var0);
  register_aitype_setup("suits", "actor_enemy_cp_rus_desert_ar_goliath_suits", undefined, undefined, undefined, undefined);
  register_aitype_setup("bombvest_hostage", "actor_ally_cp_bombvest_hostage", undefined, &circleorigin, undefined, undefined);
  register_aitype_setup("hadir", "actor_ally_cp_hero_hadir_urban", undefined, &circleorigin, undefined, undefined);
  register_aitype_setup("informant", "actor_enemy_cp_alq_desert_sniper", undefined, &setup_informant, undefined, undefined);
  register_aitype_setup("ar_gasmask", "enemy_cp_rus_desert_ar_gasmask", undefined, &calloutmarkerpingvohandlerpool, undefined, var2);
  register_aitype_setup("lmg_gasmask", "enemy_cp_rus_desert_lmg_gasmask", undefined, &calloutmarkerpingvohandlerpool, undefined, undefined);
  register_aitype_setup("rpg_gasmask", "enemy_cp_rus_desert_rpg_gasmask", undefined, undefined, undefined, undefined);
  register_aitype_setup("shotgun_gasmask", "enemy_cp_rus_desert_shotgun_gasmask", undefined, &calloutmarkerpingvohandlerpool, undefined, undefined);
  register_aitype_setup("smg_gasmask", "enemy_cp_rus_desert_smg_gasmask", undefined, &calloutmarkerpingvohandlerpool, undefined, undefined);
  register_aitype_setup("sniper_gasmask", "enemy_cp_rus_desert_sniper_gasmask", undefined, undefined, undefined, var4);
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

  for(var0 = 0; var0 < level.players.size; var0++) {
    level.players[var0] setplayermusicstate("cp_juggernaut_intro");
  }

  thread pain_threshold_watcher();
  thread jugg_music();
}

function jugg_music() {
  var0 = spawn("script_origin", self.origin);
  var0 linkTo(self);
  wait 0.1;
  var0 setModel("juggernaut_scriptable");
  scripts\engine\utility::ref_143a6("juggernaut_end", "disconnect", "death");
  var0 delete();
}

function pain_threshold_watcher() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    var0 = get_jugg_minpaindamage();
    self waittill("damage", var1, var2);
    var3 = level.players.size;

    if(isDefined(var2) && var2 scripts\cp\utility::is_valid_player() && var3 > 0) {
      self.recent_player_attackers[var2.name] = 1;
      thread remove_player_from_attacker_list(var2);
      var4 = getdvarint("scr_jugg_add_player_mod", 75);
      var5 = self.recent_player_attackers.size;
      var6 = int(max(1, var0 * var3 / var5 - (var5 - 1) * var4));
      self.minpaindamage = var6;
    }
  }
}

function remove_player_from_attacker_list(var0) {
  var0 notify("remove_player_from_attacker_list");
  var0 endon("remove_player_from_attacker_list");
  var0 endon("disconnect");
  self endon("death");
  self.recent_player_attackers[var0.name] = 1;
  wait getdvarfloat("scr_jugg_pain_window", 0.5);
  self.recent_player_attackers[var0.name] = undefined;

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
  var0 = 1;
}

function register_aitype_setup(var0, var1, var2, var3, var4, var5) {
  var6 = spawnStruct();
  var6.agent_type = var1;
  var6.combat_func = var2;
  var6.spawn_func = var3;
  var6.info_func = var4;
  var6.ref_135f3 = var5;
  level.wasexecuted[var0] = -99999;
  level.aitypes[var0] = var6;
}

function get_aitype_settings() {
  var0 = undefined;

  if(isDefined(var0)) {
    self.post_spawn_ai_funcs[self.post_spawn_ai_funcs.size] = var0;
    return;
  }
}

function get_aitypes_from_spawner() {
  var0 = [];

  if(!isDefined(self.script_noteworthy)) {
    return level.random_aitype_list;
  }

  var1 = strtok(self.script_noteworthy, " ");

  for(var2 = 0; var2 < var1.size; var2++) {
    var3 = var1[var2];

    if(isDefined(level.aitypes[var3])) {
      var0 = var3;
    }
  }

  if(var0.size > 0) {
    return var0;
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

function init_floor_enemy_info_table(var0) {
  if(!isDefined(var0)) {
    var0 = "cp/cp_lab_enemy_table.csv";
  }

  for(var1 = 0;; var1++) {
    var2 = tablelookupbyrow(var0, var1, 0);

    if(var2 == "") {
      break;
    }

    var3 = spawnStruct();
    var3.index = int(var2);
    var3.floor_num = int(tablelookup(var0, 0, var2, 1));
    var3.group_name = tablelookup(var0, 0, var2, 2);
    var3.max_in_group = int(tablelookup(var0, 0, var2, 3));
    var3.min_heavy = int(tablelookup(var0, 0, var2, 4));
    var3.max_heavy = int(tablelookup(var0, 0, var2, 5));
    var3.heavy_chance = int(tablelookup(var0, 0, var2, 6));
    var3.allowed_light = tablelookup(var0, 0, var2, 7);
    var3.allowed_heavy = tablelookup(var0, 0, var2, 8);
    var3.min_elite = int(tablelookup(var0, 0, var2, 9));
    var3.max_elite = int(tablelookup(var0, 0, var2, 10));
    var3.elite_chance = int(tablelookup(var0, 0, var2, 11));
    var3.allowed_elite = tablelookup(var0, 0, var2, 12);
    var4 = strtok(var3.allowed_light, ",");
    var3.allowed_light = var4;
    var4 = strtok(var3.allowed_heavy, ",");
    var3.allowed_heavy = var4;
    var4 = strtok(var3.allowed_elite, ",");
    var3.allowed_elite = var4;
    level.enemyinfotabledata[var3.floor_num][var3.group_name] = var3;
  }
}

function update_floor_enemy_info(var0) {
  level.spawned_enemy_types["soldier"] = 0;
  level.spawned_enemy_types["armored"] = 0;
  level.spawned_enemy_types["armored_helmet"] = 0;
  level.spawned_enemy_types["juggernaut"] = 0;
  level.allowed_enemy_types["soldier"] = 0;
  level.allowed_enemy_types["armored"] = 0;
  level.allowed_enemy_types["armored_helmet"] = 0;
  level.allowed_enemy_types["juggernaut"] = 0;
  var1 = "group_0";
  var2 = level.enemyinfotabledata[var0][var1].allowed_light;
  var3 = 99;

  foreach(var5 in var2) {
    level.allowed_enemy_types[var5] = var3;
  }

  level.heavy_chance = level.enemyinfotabledata[var0][var1].heavy_chance;

  if(level.heavy_chance > 0) {
    var2 = level.enemyinfotabledata[var0][var1].allowed_heavy;
    var3 = level.enemyinfotabledata[var0][var1].max_heavy;

    foreach(var5 in var2) {
      level.allowed_enemy_types[var5] = var3;
    }
  }

  level.elite_chance = level.enemyinfotabledata[var0][var1].elite_chance;

  if(level.elite_chance > 0) {
    var2 = level.enemyinfotabledata[var0][var1].allowed_elite;
    var3 = level.enemyinfotabledata[var0][var1].max_elite;

    foreach(var5 in var2) {
      level.allowed_enemy_types[var5] = var3;
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
  var0 = getEntArray("module_update", "targetname");

  foreach(var2 in var0) {
    if(isDefined(var2.target) && isDefined(var2.script_function)) {
      [[run_triggered_module_registration(var2.script_function)]](var2);
      thread run_script_func_when_triggered(var2);
    }
  }

  scripts\engine\utility::flag_set("trigger_modules_initialized");
}

function run_triggered_module_registration(var0) {
  if(isDefined(level.trigger_spawn_module_func[var0])) {
    return level.trigger_spawn_module_func[var0];
  }

  return &register_triggered_module;
}

function register_triggered_timeout_module(var0) {
  var1 = scripts\engine\utility::getStructArray(var0.target, "targetname");
  var2 = scripts\engine\utility::ter_op(isDefined(var0.script_count), int(var0.script_count), undefined);
  var3 = scripts\engine\utility::ter_op(isDefined(var0.script_count_min), int(var0.script_count_min), 0);
  var4 = scripts\engine\utility::ter_op(isDefined(var0.script_count_max), int(var0.script_count_max), var1.size);
  registerambientgroup(var0.target, var3, var4, var2, [ &wait_time_from_active_count, 0.25, 5, 0.8], undefined, var0.target, undefined, var0.target, 30);
  set_spawn_scoring_params_for_group(var0.target, undefined, undefined, var0.script_maxdist, undefined);
}

function watch_for_players(var0, var1, var2, var3, var4) {
  if(scripts\cp\coop_stealth::ref_132d7()) {
    return;
  }

  self endon("death");

  if(isDefined(self.group)) {
    self.group endon("weapons_free");
  }

  var1 = define_var_if_undefined(var1, 562500);
  var2 = define_var_if_undefined(var2, 45);
  var4 = define_var_if_undefined(var4, 2.5);
  var5 = 0;

  for(;;) {
    self waittill("known_event", var6);

    if(isDefined(var6) && isPlayer(var6)) {
      if(var6 scripts\cp\utility::is_valid_player() && !istrue(var6.ignoreme)) {
        if(scripts\engine\trace::can_see_origin(var6 getEye(), 0)) {
          wait var4;
          var7 = distancesquared(self.origin, var6.origin);

          if(isDefined(var3)) {
            if(var7 <= var3) {
              self.group scripts\engine\utility::ent_flag_set("weapons_free");
              level notify("weapons_checked_in");
            } else if(var7 <= var1) {
              if(!var5) {
                var5 = 1;
                set_demeanor_from_unittype("alert");
              }
            }
          } else if(var7 <= var1) {
            self.group scripts\engine\utility::ent_flag_set("weapons_free");
            level notify("weapons_checked_in");
          }
        }
      }
    }
  }
}

function set_script_count_on_spawns(var0, var1, var2, var3) {
  var4 = getarraykeys(level.active_spawn_module_structs);

  for(var5 = 0; var5 < level.active_spawn_module_structs.size; var5++) {
    var6 = level.active_spawn_module_structs[var4[var5]];

    if(isarray(var6)) {
      for(var7 = 0; var7 < var6.size; var7++) {
        var8 = var6[var7];

        if(var8.group_name != var0) {
          var9 = process_module_var(var8, var8.spawn_points);

          for(var10 = 0; var10 < var9.size; var10++) {
            var8.spawn_points[var10].script_count = 1;
            var8.spawn_points[var10].script_timeout = undefined;
          }
        }
      }

      continue;
    }

    if(var6.group_name != var0) {
      for(var10 = 0; var10 < var6.spawn_points.size; var10++) {
        var6.spawn_points[var10].script_count = 1;
        var6.spawn_points[var10].script_timeout = undefined;
      }
    }
  }
}

function wait_random_time(var0, var1, var2, var3) {
  if(isDefined(var1) && isDefined(var2)) {
    wait randomfloatrange(var1, var2);
    return;
  }

  if(isDefined(var2)) {
    wait var2;
    return;
  }

  if(isDefined(var1)) {
    wait var1;
    return;
  }

  wait 0.25;
}

function wait_time_from_active_count(var0, var1, var2, var3) {
  var4 = var0.activecount;
  var5 = process_module_var(var0, var0.max_size);

  if(var4 / var5 >= var3) {
    return var2;
  }

  return var1;
}

function register_triggered_infinite_module(var0) {
  var1 = scripts\engine\utility::getStructArray(var0.target, "targetname");
  registerambientgroup(var0.target, 0, var1.size, undefined, 0.25, undefined, var0.target, undefined, undefined, undefined);
  set_spawn_scoring_params_for_group(var0.target, undefined, undefined, var0.script_maxdist, undefined);
}

function register_triggered_looping_module(var0) {
  var1 = scripts\engine\utility::getStructArray(var0.target, "targetname");
  registerambientgroup(var0.target, 0, var1.size, var1.size, 0.25, &wait_for_all_group_dead, var0.target, undefined, var0.target, undefined);
  set_spawn_scoring_params_for_group(var0.target, undefined, undefined, var0.script_maxdist, undefined);
}

function register_triggered_module(var0) {
  var1 = scripts\engine\utility::getStructArray(var0.target, "targetname");
  registerambientgroup(var0.target, 0, var1.size, var1.size, 0.25, undefined, var0.target, undefined, undefined, undefined);
  set_spawn_scoring_params_for_group(var0.target, undefined, undefined, var0.script_maxdist, undefined);
}

function register_triggered_module_maze_jugg(var0) {
  var1 = scripts\engine\utility::getStructArray(var0.target, "targetname");
  registerambientgroup(var0.target, 0, var1.size, var1.size, 0.25, undefined, var0.target, undefined, undefined, undefined);
  register_module_ai_spawn_func(var0.target, &scripts\cp\cp_spawning_util::disable_juggernaut_move_behavior);
  register_module_ai_spawn_func(var0.target, &scripts\cp\cp_spawning_util::disable_cover_node_behavior);
  register_module_ai_spawn_func(var0.target, &watch_for_players);
  register_module_weapons_free_func(var0.target, &scripts\cp\cp_spawning_util::enable_juggernaut_move_behavior);
}

function register_trigger_func(var0, var1, var2) {
  if(!isDefined(level.trigger_spawn_func)) {
    level.trigger_spawn_func = [];
  }

  if(!isDefined(level.trigger_spawn_module_func)) {
    level.trigger_spawn_module_func = [];
  }

  level.trigger_spawn_func[var0] = var1;
  level.trigger_spawn_module_func[var0] = var2;
}

function run_script_func_when_triggered(var0) {
  var0 notify("run_script_func_when_triggered");
  var0 endon("run_script_func_when_triggered");
  var0 endon("death");
  level endon("game_ended");
  var0 scripts\engine\utility::thread_on_notify("disable_trigger", &scripts\engine\utility::trigger_off);

  if(!isDefined(level.trigger_spawn_func)) {
    var0 notify("disable_trigger");
    return;
  }

  if(!isDefined(level.trigger_spawn_func[var0.script_function])) {
    var0 notify("disable_trigger");
    return;
  }

  var1 = level.trigger_spawn_func[var0.script_function];

  for(;;) {
    var0 waittill("trigger", var2);

    if(isPlayer(var2)) {
      [[var1]](var0, var2);
    }
  }
}

function isentignoredbyme(var0, var1) {
  if(!isagent(var0)) {
    return 0;
  }

  if(istrue(var1.ignoreme)) {
    return 1;
  }

  var2 = var0 getthreatbiasgroup();
  var3 = var1 getthreatbiasgroup();

  if(isDefined(level.ignoremegroups) && isDefined(level.ignoremegroups[var3])) {
    if(scripts\engine\utility::array_contains(level.ignoremegroups[var3], var2)) {
      return 1;
    }

    return 0;
  }

  return 0;
}

function debug_kill_soldier(var0) {
  level endon("game_ended");
  var0 endon("death");
  var0 scripts\engine\utility::enable_pain();
  var0 animmode("normal");
  set_goal_radius(var0, 32);
  var0 scripts\asm\shared\mp\utility::bunkercounteruav();
  var0 notify("alerted");
  var0 notify("enter_combat");
  var0.nocorpse = undefined;
  var0.scripted_mode = 0;
  var0.entered_combat = 1;

  if(isDefined(var0.spawnpoint.target)) {
    var1 = scripts\engine\utility::getStruct(var0.spawnpoint.target, "targetname");
    set_goal_pos(var0, var1.origin);
  }

  var0 scripts\engine\utility::ref_143a5("goal_reached", "goal");
  wait 2;
  var0 dodamage(var0.health + 1000, var0.origin, var0, var0, "MOD_SUICIDE");
}

function spawn_soldier_scripted(var0, var1, var2, var3) {
  if(isDefined(var1)) {
    var4 = var1;
  } else {
    var4 = choose_spawnpoint(var1);
  }

  var1.respawning = undefined;

  if(!isDefined(var4)) {
    change_module_status(var1, undefined, "No Spawner");
    return 0;
  }

  if(istrue(var1.ref_133be)) {
    return 1;
  }

  return spawn_soldier_scripted_internal(var1, var4, 0, undefined, var3, var4);
}

function ref_13bac(var0, var1) {
  var1 = define_var_if_undefined(var1, 1);
  var0.ref_133be = var1;
}

function spawn_soldier_scripted_internal(var0, var1, var2, var3, var4, var5) {
  var6 = undefined;
  var7 = undefined;
  var8 = undefined;
  var3 = undefined;

  if(isDefined(var1.pos_override_struct)) {
    var7 = var1.pos_override_struct.origin;
    var8 = var1.pos_override_struct.angles;
  } else if(isDefined(var1.vehicle_position)) {
    var7 = var1.origin;
    var8 = var1.angles;
  }

  if(isDefined(var1.specs)) {
    if(!isarray(var1.specs)) {
      var1.specs = [var1.specs];
    }

    var3 = scripts\engine\utility::random(var1.specs);
    var6 = var3;
  }

  var9 = spawn_ai(var1, var7, var8, var3, var0);

  if(isDefined(var9)) {
    if(isDefined(var0.cargo_truck_mg_init)) {
      if(isDefined(level.players[var0.cargo_truck_mg_init])) {
        level.players[var0.cargo_truck_mg_init].cargo_truck_mg_gunnerdamagemodignorefunc++;
        var9.cargo_truck_mg_initdamage = level.players[var0.cargo_truck_mg_init];
      }
    }

    change_module_status(var0, undefined, "Found Agent");
    var1 notify("spawn_success", var1);
    level notify("spawned_group_soldier", var9);
    level notify("ai_spawn_successful", var9, var1, var1.origin, var0);
    return run_ai_post_spawn_init(var0, var9, var1, var4, var6, var2, var5);
  }

  change_module_status(var0, undefined, "No Free Agent");
  var1 notify("spawn_failed", var1);
  var1.aitype = undefined;

  if(istrue(var5)) {
    return undefined;
  }

  return 0;
}

function run_ai_post_spawn_init(var0, var1, var2, var3, var4, var5, var6) {
  var1 endon("death");
  set_default_values(var1, undefined, var2, var3, var0);
  node_fields_pre_goal(var1, var2);

  if(isDefined(var0) && var0 scripts\cp\cp_spawning_util::module_disables_spawners_until_owner_death()) {
    var1 thread scripts\cp\cp_spawning_util::disable_spawner_until_owner_death(var2);
  }

  copy_to_soldier_from_spawn_point(var2, var1);
  ref_12ddc(var1, undefined, var2, var3, var0);
  set_default_spawner_values(var2);
  var1 scripts\cp\cp_squadmanager::addtosquad();
  run_spawner_post_spawn_actions(var2, var0);
  run_ai_post_spawn_actions(var1);
  run_aitype_spawn_func(var1);

  if(isDefined(var2.specs) && isDefined(var4)) {
    if(scripts\engine\utility::array_contains(var2.specs, var4)) {
      var2.specs = scripts\engine\utility::array_remove(var2.specs, var4);

      if(var2.specs.size < 1) {
        var2.specs = undefined;
      }
    }
  }

  var7 = undefined;

  if(isDefined(var2.script_animation_type)) {
    if(!isDefined(var0) || !var0 scripts\engine\utility::ent_flag("weapons_free")) {
      var8 = strtok(var2.script_animation_type, ",");
      var7 = scripts\engine\utility::random(var8);
    }
  }

  if(isDefined(var2.script_function)) {
    if(isDefined(level.spawner_script_funcs[var2.script_function]) && isDefined(var2.ai_infil_type)) {
      var1[[level.spawner_script_funcs[var2.script_function].script_function]](var0, var2, var2.ai_infil_type);
    }
  } else if(isDefined(var7) && isDefined(level.spawn_skits[var7])) {
    thread enter_combat_after_stealth();
    var1 thread[[level.spawn_skits[var7].skit_func]]();
  } else if(is_door_spawn(var1)) {
    if(istrue(var5)) {
      thread agent_use_door_spawner(var1, var2.doors[0], var1, var2.doors, var2.doors[0].origin, var2.doors[0].angles, &debug_kill_soldier);
    } else {
      thread agent_use_door_spawner(var1, var2.doors[0], var1, var2.doors, var2.doors[0].origin, var2.doors[0].angles, undefined);
    }
  } else {
    scripts\engine\utility::delaythread(5, &unset_used_recently, var2);

    if(is_patroller(var1) || is_pacifist(var1)) {
      if(!isDefined(var0) || !var0 scripts\engine\utility::ent_flag("weapons_free")) {
        if(!isDefined(var2.script_demeanor)) {
          if(is_specified_unittype("civilian")) {
            set_demeanor_from_unittype(var1, "panic");
          } else if(is_specified_unittype("juggernaut")) {
            if(ref_13655(var1.spawnpoint, 512)) {
              var1 scripts\cp\cp_spawning_util::disable_juggernaut_move_behavior(var0);
            }
          } else if(nullweapon(var1.primaryweapon)) {
            set_demeanor_from_unittype(var1, "patrol");
          } else {
            set_demeanor_from_unittype(var1, "patrol");
          }
        }

        thread start_patrol();
      } else {
        thread enter_combat();
      }
    } else if(isDefined(var2.target)) {
      thread enter_combat_after_go_to_node();
    } else {
      thread enter_combat();
    }
  }

  var2.aitype = undefined;

  if(istrue(var6)) {
    return var1;
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
  var0 = istrue(self.pacifist) || istrue(self.ignoreme) || istrue(self.ignoreall) || isDefined(level.global_stealth_broken) && !istrue(level.global_stealth_broken) || istrue(level.announcer_vo_playing) || istrue(level.ref_135f4) || istrue(level.validatealivecount) || istrue(level.ref_139b5);
  return !var0;
}

function loschecktime(var0) {
  if(!isDefined(var0)) {
    return;
  }

  if(level.wasexecuted[var0] + 60000 > gettime()) {
    return;
  }

  if(isDefined(level.aitypes[var0]) && isDefined(level.aitypes[var0].ref_135f3)) {
    var1 = level.aitypes[var0].ref_135f3;
    level.ref_135f4 = 1;

    if(isarray(var1)) {
      var2 = scripts\engine\utility::random(var1);
      level scripts\cp\cp_vo::try_to_play_vo_on_team(var2, "allies");
    } else {
      level scripts\cp\cp_vo::try_to_play_vo_on_team(var1, "allies");
    }

    level.wasexecuted[var0] = gettime();
    level.ref_135f4 = 0;
    return;
  }
}

function set_demeanor_from_unittype(var0) {
  var0 = ref_140c4(var0);

  if(is_specified_unittype("civilian")) {
    scripts\asm\asm_bb::bb_setcivilianstate(var0);
    return;
  }

  if(!is_specified_unittype("juggernaut")) {
    scripts\common\utility::demeanor_override(var0);
    return;
  }
}

function ref_140c4(var0) {
  switch (var0) {
    case "casual_gun":
    case "casual":
      return "patrol";
    default:
      return var0;
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

function set_character_models(var0, var1, var2) {
  if(isDefined(self.headmodel)) {
    self detach(self.headmodel);
  }

  if(isDefined(var0)) {
    self setModel(var0);
  }

  if(isDefined(var1)) {
    self attach(var1, "", 1);
    self.headmodel = var1;
    return;
  }
}

function watch_for_bad_path() {
  level endon("game_ended");
  self endon("death");
  var0 = 0;
  var1 = 0;
  wait 5;

  for(;;) {
    self waittill("bad_path", var2);

    if(getdvarint("scr_disable_bad_path_cleanup", 0)) {
      break;
    }

    if(!has_never_kill_off_flag()) {
      var3 = gettime();

      if(var3 - var1 > 5000) {
        var0 = 0;
        var1 = var3;
      } else {
        var0++;
        var1 = var3;

        if(var0 >= 10) {
          if(passed_kill_off_time_checks(gettime())) {
            teleport_to_nearby_spawner("Bad Path", var2);
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
    self waittill("ai_events", var0);

    for(var1 = 0; var1 < var0.size; var1++) {
      var2 = var0[var1];

      if(has_func_for_aievent(var2.type)) {
        run_aievent_func(var2.type, var0);
      }

      switch (var2.type) {
        case "projectile_impact":
        case "gunshot_teammate":
        case "silenced_shot":
        case "gunshot":
        case "bulletwhizby":
        case "explode":
          var3 = 1;

          if(scripts\cp\coop_stealth::ref_132d7()) {
            var3 = !isDefined(self.stealth);
          }

          if(var3) {
            thread enter_combat();
          }

          break;
        default:
          break;
      }
    }
  }
}

function register_aievent_func_for_group(var0, var1, var2) {
  if(isDefined(level.ambientgroups[var0]) && isarray(level.ambientgroups[var0])) {
    for(var3 = 0; var3 < level.ambientgroups[var0].size; var3++) {
      if(!isDefined(level.ambientgroups[var0][var3].aievent_funcs)) {
        level.ambientgroups[var0][var3].aievent_funcs = [];
      }

      level.ambientgroups[var0][var3].aievent_funcs[var1] = var2;
    }

    return;
  }

  if(!isDefined(level.ambientgroups[var0].aievent_funcs)) {
    level.ambientgroups[var0].aievent_funcs = [];
  }

  level.ambientgroups[var0].aievent_funcs[var1] = var2;
}

function has_func_for_aievent(var0) {
  if(isDefined(self.group.aievent_funcs) && isDefined(self.group.aievent_funcs[var0]) && isbuiltinfunction(self.group.aievent_funcs[var0])) {
    return 1;
  }

  return 0;
}

function run_aievent_func(var0, var1) {
  self thread[[self.group.aievent_funcs[var0]]](var0, var1);
}

function get_nervous(var0, var1) {
  if(!isDefined(self.nervousness)) {
    self.nervousness = 0;
  }

  thread increment_and_decay_nervousness();
  var2 = undefined;

  for(var3 = 0; var3 < var1.size; var3++) {
    var4 = var1[var3];

    switch (var4.type) {
      case "footstep_sprint":
        if(self.nervousness >= randomintrange(15, 45)) {
          self.nervousness = undefined;
          thread enter_combat();
          return;
        }

        var2 = ["You're drawing attention to yourself."];
        break;
      case "player_ads_threat":
        var2 = ["Watch where you point that thing.", "Rude.", "You're drawing attention to yourself.", "Calm down!"];

        if(self.nervousness >= randomintrange(5, 15)) {
          self.nervousness = undefined;
          thread enter_combat();
          return;
        }

        break;
    }

    if(isDefined(var2) && isDefined(var4.entity) && isPlayer(var4.entity)) {
      thread apply_and_remove_attention_flag();
      give_message_to_player(var4.entity, scripts\engine\utility::random(var2));
    }
  }
}

function give_message_to_player(var0) {
  if(!isDefined(self.next_hint_time) || gettime() > self.next_hint_time) {
    self.next_hint_time = gettime() + randomintrange(3, 5) * 1000;
    self iprintlnbold(var0);
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

function attempt_to_give_info(var0, var1) {
  for(var2 = 0; var2 < var1.size; var2++) {
    var3 = var1[var2];

    if(isDefined(var3.type) && var3.type == "footstep_sprint") {
      var4 = ["You're drawing attention to yourself."];
    } else {
      var4 = ["He's wearing a mask.", "He has no sleeves on his shirt.", "He's not like us.", "He's wearing boots.", "He's carries a lot of equipment on his waste.", "He may attack soon.", "There may be a group of them.", "There may be a group of them.", "There may be a group of them."];
    }

    if(isDefined(var3.entity) && isPlayer(var3.entity)) {
      give_message_to_player(var3.entity, scripts\engine\utility::random(var4));
    }
  }
}

function copy_to_soldier_from_spawn_point(var0, var1) {
  var1.spawnpoint = var0;

  if(!istrue(var0 scripts\cp\cp_vehicles::is_vehicle_spawnpoint())) {
    var1.target = var0.target;
  }

  var1.script_squadname = var0.script_squadname;
  var1.script_stealthgroup = var0.script_stealthgroup;
  var1.script_demeanor_post = var0.script_demeanor_post;
  var1.script_goalheight = var0.script_goalheight;
  var1.script_radius = var0.script_radius;
  var1.dontkilloff = var0.dontkilloff;
  var1.script_patroller = var0.script_patroller;
  var1.equip_helmet = var0.equip_helmet;
  var1.is_on_platform = var0.is_on_platform;
  var1.door_spawner = var0.door_spawner;
  var1.dont_enter_combat = var0.dont_enter_combat;
  var1.script_origin_other = var0.script_origin_other;
  var1.aitype = var0.aitype;

  if(isDefined(var0.script_enemyselector)) {
    var1.script_enemyselector = var0.script_enemyselector;
  }

  if(isDefined(var0.script_goalvolume)) {
    var1.script_goalvolume = getEnt(var0.script_goalvolume, "targetname");
    return;
  }
}

function unset_used_recently(var0) {
  if(isDefined(var0)) {
    var0.used_recently = undefined;
    return;
  }
}

function choose_spawnpoint(var0, var1, var2) {
  if(isDefined(var0.vehicle)) {
    return find_spawn_loc_from_vehicle_spawner(var0.vehicle.spawn_point, var0);
  }

  if(istrue(var1)) {
    var0.respawning = 1;
  }

  var3 = process_module_var(var0, var0, var0.spawn_points);
  var4 = var0 scripts\cp\cp_spawner_scoring::score_ai_spawns(var3, var1, undefined, var2);
  var0.ref_127ed = undefined;
  var0 scripts\cp\cp_spawner_scoring::ref_12891(var4);

  if(!isDefined(var4)) {
    return undefined;
  }

  if(istrue(var4 scripts\cp\cp_vehicles::is_vehicle_spawnpoint())) {
    return find_spawn_loc_from_vehicle_spawner(var4, var0);
  } else if(isDefined(var4.script_reuse_max)) {
    var4.script_reuse_max = int(var4.script_reuse_max);

    if(!isDefined(var4.count)) {
      var4.count = 1;
    } else {
      var4.count = int(var4.count);
      var4.count++;
    }

    if(var4.count >= var4.script_reuse_max) {
      var4.used_recently = 1;
      thread reset_spawn_vars(var4);
    }
  } else {
    var4.used_recently = 1;
  }

  return var4;
}

function find_spawn_loc_from_vehicle_spawner(var0) {
  if(!isDefined(self.vehicle)) {
    if(!spawn_vehicle_at_vehicle_spawner(var0)) {
      return undefined;
    }
  }

  if(isDefined(self.vehicle) && self.vehicle scripts\common\vehicle_aianim::vehicle_hasavailablespots()) {
    level notify("vehicle_spawned", var0, self.vehicle);
    var0 notify("vehicle_spawned", var0, self.vehicle);

    if(isDefined(self.veh_spawn_point) && isDefined(self.veh_spawn_point.script_vehiclegroup)) {
      return get_near_vehicle_spawner();
    }

    self.pos_override_struct = self.vehicle;
    return self;
  }

  return undefined;
}

function get_near_vehicle_spawner() {
  var0 = scripts\engine\utility::getStructArray(self.veh_spawn_point.script_vehiclegroup, "targetname");

  for(var1 = 0; var1 < var0.size; var1++) {
    if(var0[var1] == self.veh_spawn_point) {
      continue;
    }

    if(!istrue(var0[var1].disabled)) {
      self.pos_override_struct = var0[var1];
      var0[var1].disabled = 1;
      return self;
    }
  }

  return undefined;
}

function spawn_vehicle_at_vehicle_spawner(var0) {
  if(!isDefined(self.script_function)) {
    return 0;
  }

  if(has_vehicle_type_exceeded_module_cap(var0, self.script_function)) {
    return 0;
  }

  if([[level.ai_spawn_vehicle_func[self.script_function].vehicle_spawn_func]](var0, self, self.script_function)) {
    if(isDefined(var0.vehicle)) {
      ref_14206(var0.vehicle, var0.vehicle);
      thread ref_14187(var0.vehicle);
    }

    return 1;
  }

  return 0;
}

function ref_14206(var0) {
  level.ref_11ca7[var0 getentitynumber()] = var0;
}

function ref_14187(var0) {
  level endon("game_ended");
  var1 = var0 getentitynumber();
  var0 waittill("death");

  if(isDefined(var0.vehiclename)) {
    scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(var0);
  }

  level.ref_11ca7[var1] = undefined;
}

function set_last_spawn_time() {}

function get_last_spawn_time() {}

function disable_spawn_point(var0, var1, var2) {
  if(isDefined(var1) && var1 > 0) {
    little_bird_mg_givetakegunnerturrettimeout(var0);

    if(isDefined(var2)) {
      var2.longer_spawn_delay = 1;
    }

    wait var1;

    if(isDefined(var2)) {
      var2.longer_spawn_delay = 0;
    }

    mounted(var0);
    return;
  }

  little_bird_mg_givetakegunnerturrettimeout(var0);
}

function spawn_is_vehicle_spawn(var0) {
  if(!isnode(var0) && isDefined(var0.spawnflags)) {
    var1 = int(var0.spawnflags);
    var2 = 16;
    var3 = 8;
    var4 = 512;

    if(var1 &var2) {
      define_spawner(var0, "vehicle_spawner");
      remove_from_spawner_flags(var0, 8);
      add_to_spawner_flags(var0, 16);

      if(!isDefined(var0.script_function)) {
        var0.script_function = "random_ground_vehicle_spawn";
      }
    }

    if(var1 &var3) {
      define_spawner(var0, "vehicle_spawner");
      add_to_spawner_flags(var0, 8);
      remove_from_spawner_flags(var0, 16);
      var0.script_goalyaw = 1;

      if(!isDefined(var0.script_function)) {
        var0.script_function = "random_air_vehicle_spawn";
      }

      level.valid_air_vehicle_spawn_points[level.valid_air_vehicle_spawn_points.size] = var0;
      level.all_air_vehicle_spawn_points[level.all_air_vehicle_spawn_points.size] = var0;

      if(!(var1 & 32)) {
        var0.heli_path_func = &scripts\cp\cp_vehicles::create_heli_path;
      }
    }

    if((spawner_flags_check(var0, 16) || spawner_flags_check(var0, 8)) && var1 &var4) {
      var0.veh_model_spawner = 1;
      var0.dontgetonpath = 1;
    }

    if(var1 &var3 || var1 &var2) {
      return 1;
    }

    return undefined;
  }

  return undefined;
}

function barkov_execution_path(var0) {
  if(isDefined(self.spawnflags)) {
    if(!ref_13655(var0)) {
      self.spawnflags += var0;
      return;
    }

    return;
  }

  self.spawnflags = var0;
}

function ref_12bd2(var0) {
  if(isDefined(self.spawnflags) && self.spawnflags &var0) {
    self.spawnflags -= var0;
    return;
  }
}

function define_spawner(var0) {
  switch (var0) {
    case "cluster_spawner":
      define_as_cluster_spawner();
      break;
    case "vehicle_spawner":
      define_as_vehicle_spawner();
      break;
  }
}

function ref_13655(var0) {
  return isDefined(self.spawnflags) && self.spawnflags &var0;
}

function spawner_flags_check(var0) {
  return isDefined(self.spawner_flags) && self.spawner_flags &var0;
}

function add_to_spawner_flags(var0) {
  if(isDefined(self.spawner_flags)) {
    if(!spawner_flags_check(var0)) {
      self.spawner_flags += var0;
      return;
    }

    return;
  }

  self.spawner_flags = var0;
}

function remove_from_spawner_flags(var0) {
  if(isDefined(self.spawner_flags) && self.spawner_flags &var0) {
    self.spawner_flags -= var0;
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

function reset_spawn_vars(var0) {}

function returnzeroifundefined(var0) {
  if(isDefined(var0)) {
    return var0;
  }

  return 0;
}

function returnblankfuncifundefined(var0) {
  if(isDefined(var0)) {
    return var0;
  }

  return &blankmodulefunc;
}

function blankmodulefunc(var0, var1, var2, var3, var4, var5) {}

function registerambientgroup(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  var10 = spawnStruct();
  var11 = strtok(var0, "/");

  if(var11.size > 1) {
    var10.group_name = var11[1];
  } else {
    var10.group_name = var0;
  }

  var10.min_size = returnzeroifundefined(var1);
  var10.max_size = returnzeroifundefined(var2);
  var10.time_between_spawns = returnzeroifundefined(var4);
  var10.post_module_delay = returnzeroifundefined(var5);
  var10.activecount = 0;
  var10.spawn_count = 0;
  var10.ai_spawned = [];
  var10.module_vehicles = [];
  var10.ref_11cb0 = 0;
  var10.ref_13be5 = 0;
  var10.cqb_module = 0;
  var10.debug_struct = create_module_debug_struct(var10);

  if(isDefined(var6)) {
    if(isbuiltinfunction(var6)) {
      var10.spawn_points = var6;
    } else if(isarray(var6)) {
      foreach(var13 in var6) {
        var10.spawn_points = scripts\engine\utility::array_combine(var10.spawn_points, scripts\engine\utility::getStructArray(var13, "targetname"));
      }

      for(var15 = 0; var15 < var10.spawn_points.size; var15++) {
        var16 = var10.spawn_points[var15];
        thread spawner_init();
      }

      var10.spawn_points = [ &return_spawners_by_targetname, var6];
    } else {
      var11.spawn_points = scripts\engine\utility::getStructArray(var7, "targetname");

      foreach(var16 in var11.spawn_points) {
        thread spawner_init();
      }
    }
  }

  var11.totalspawns = returnzeroifundefined(var4);
  var11.start_func = returnblankfuncifundefined(var8);
  var11.nextgroup = var9;
  var11.timeout_action = var10;
  var11.currentmodulekills = 0;
  var11.currentmoduledeaths = 0;
  var11.set_chosen_spawner_from_uid = ["frag_grenade_mp", "molotov_mp", "semtex_mp", "flash_grenade_mp", "concussion_grenade_mp", "smoke_grenade_mp", "gas_mp"];
  var11.serverroomrewardroll = [0.5, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1];

  if(isDefined(level.ambientgroups[var11.group_name])) {
    if(isarray(level.ambientgroups[var11.group_name])) {
      var19 = [];

      foreach(var21 in level.ambientgroups[var11.group_name]) {
        var19 = scripts\engine\utility::array_add(var19, var21);
      }

      var19 = scripts\engine\utility::array_add(var19, var11);
      level.ambientgroups[var11.group_name] = var19;
    } else {
      var23 = level.ambientgroups[var11.group_name];
      level.ambientgroups[var11.group_name] = [var11, var23];
    }

    var11.moduleid = level.module_group_id;
    level.module_group_id++;
  } else {
    var11.moduleid = level.module_group_id;
    level.module_group_id++;
    level.ambientgroups[var11.group_name] = var11;
  }

  var24 = ":0/" + var1 + ":" + level.ambientgroups.size;
  var25 = "devgui_cmd \"CP Debug:2 / CP Module Spawning:3 / Start Module" + var24 + "\" \"set scr_debug_spawning spawn_module_change &" + var11.group_name + "\" \n";
  scripts\cp\utility::addentrytodevgui(var25);
  var25 = "devgui_cmd \"CP Debug:2 / CP Module Spawning:3 / Stop Module" + var24 + "\" \"set scr_debug_spawning stop_module_change &" + var11.group_name + "\" \n";
  scripts\cp\utility::addentrytodevgui(var25);
}

function return_spawners_by_targetname(var0, var1) {
  if(!isarray(var1)) {
    var1 = [var1];
  } else {
    var2 = [];

    for(var3 = 0; var3 < var1.size; var3++) {
      var2 = var1[var3];
    }

    var1 = var2;
  }

  var4 = [];

  for(var3 = 0; var3 < var1.size; var3++) {
    var4 = scripts\engine\utility::array_combine(var4, scripts\engine\utility::getStructArray(var1[var3], "targetname"));
  }

  return var4;
}

function delay_start_specified_module() {
  if(getDvar("scr_module_spawning", "") != "") {
    scripts\engine\utility::flag_wait("strike_init_done");
    scripts\engine\utility::flag_wait("introscreen_over");
    scripts\engine\utility::flag_wait("infil_complete");
    scripts\engine\utility::flag_wait("interactions_initialized");
    wait 2;
    var0 = run_spawn_module(getDvar("scr_module_spawning", ""));
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
    var0 = run_spawn_module("cover_node_spawning");
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
    var0 = run_spawn_module("wave_spawning");
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
  var0 = scripts\engine\utility::getStructArray("cover_node_parents", "targetname");
  var1 = get_all_nodes();

  for(var2 = 0; var2 < var1.size; var2++) {
    var1[var2].script_index = undefined;
    var3 = isDefined(var1[var2].spawnflags) && var1[var2].spawnflags & 16384;
    var4 = var1[var2].type == "Error";

    if(var4 || var3) {
      var1[var2] disconnectnode();
    }
  }

  if(var0.size < 1) {
    var5 = 0;
    var6 = [];
    var7 = 0;

    for(;;) {
      var5++;
      var8 = var1[0];
      var9 = [];
      var6 = var8;

      if(var1.size > 1) {
        for(var10 = 0; var10 < var1.size; var10++) {
          var11 = var1[var10];
          var11.script_index = undefined;
          var9 = var11;
          LOC_00000231:
        }

        var1 = var9;
        var6 = var9;
        break;
      }

      break;
    }

    var1 = undefined;
    var0 = split_array_into_quadrants(var6);
    var6 = undefined;
  }

  for(var10 = 0; var10 < var0.size; var10++) {
    define_spawner(var0[var10], "cluster_spawner");
    thread spawner_init();
    init_cluster_parent(var0[var10]);
    var0[var10].child_spawners = undefined;
  }

  level.cover_node_spawners = var0;
  scripts\engine\utility::flag_set("cover_spawners_initialized");
}

function get_all_nodes() {
  return getallnodes();
}

function attempt_throttle(var0) {
  var0++;

  if(var0 % 2000 == 0) {
    waitframe();
  }

  return var0;
}

function return_cover_spawners(var0) {
  if(istrue(var0.use_only_veh_spawners)) {
    return [];
  }

  if(isDefined(var0.cover_node_spawners_override) && var0.cover_node_spawners_override.size > 0) {
    var1 = [];
    var2 = getarraykeys(var0.cover_node_spawners_override);

    for(var3 = 0; var3 < var0.cover_node_spawners_override.size; var3++) {
      var1 = scripts\engine\utility::array_combine(var1, var0.cover_node_spawners_override[var2[var3]]);
    }

    if(var1.size > 0) {
      return var1;
    }
  } else if(isDefined(var0.wave_spawner_overrides) && var0.wave_spawner_overrides.size > 0) {
    var1 = [];

    for(var3 = 0; var3 < var0.wave_spawner_overrides.size; var3++) {
      var4 = scripts\engine\utility::getStructArray(var0.wave_spawner_overrides[var3], "targetname");
      var1 = scripts\engine\utility::array_combine(var1, var4);
    }

    if(var1.size > 0) {
      return var1;
    }
  } else if(isDefined(var0.requested_spawners) && var0.requested_spawners.size > 0) {
    var1 = [];

    for(var3 = 0; var3 < var0.requested_spawners.size; var3++) {
      var4 = scripts\engine\utility::getStructArray(var0.requested_spawners[var3], "targetname");
      var1 = scripts\engine\utility::array_combine(var1, var4);
    }

    if(var1.size > 0) {
      if(isDefined(level.cover_node_spawners)) {
        return scripts\engine\utility::array_combine(level.cover_node_spawners, var1);
      } else {
        return var1;
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

function use_cover_node_spawners_around_pos(var0) {
  scripts\engine\utility::flag_wait("cover_spawners_initialized");

  if(isDefined(self.cover_node_spawners)) {
    var1 = scripts\engine\utility::get_array_of_closest(var0, self.cover_node_spawners, undefined, 5, undefined, undefined);
    self.cover_node_spawners_override[self.cover_node_spawners_override_id] = var1;
    var2 = self.cover_node_spawners_override_id;
    self.cover_node_spawners_override_id++;
    return var2;
  }

  return undefined;
}

function remove_cover_node_spawners_around_pos_with_id(var0) {
  if(isDefined(self.cover_node_spawners_override[var0])) {
    self.cover_node_spawners_override[var0] = undefined;
    return;
  }
}

function init_wave_settings(var0) {
  var0.wave_reference = 1;
}

function init_pre_wave_spawning(var0) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("cover_spawners_initialized");
  add_global_spawn_function("axis", &stay_passive_if_not_weapons_free);
  add_global_spawn_function("axis", &set_aggro_flag_on_enter_combat);
  add_global_spawn_function("axis", &watch_for_players, undefined, 1000000, 45);
}

function unset_pre_wave_spawning(var0) {
  remove_global_spawn_function("axis", &stay_passive_if_not_weapons_free);
  remove_global_spawn_function("axis", &set_aggro_flag_on_enter_combat);
  remove_global_spawn_function("axis", &watch_for_players);
}

function setup_wave_vars(var0) {
  var0.spawn_aitype_counts = [];
}

function wait_for_spawners_created(var0) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("cover_spawners_initialized");
}

function split_array_into_quadrants(var0) {
  if(isDefined(var0) && var0.size < 1) {
    return [];
  }

  var1 = scripts\cp\utility::get_center_point_of_array(var0);
  var2 = spawnStruct();
  var2.origin = var1;
  var2.angles = (0, 0, 0);
  var3 = [];
  var4 = [];
  var5 = [];
  var6 = [];
  var7 = [];
  var8 = [];
  var9 = [];
  var10 = [];
  var11 = [];
  var12 = [];

  for(var13 = 0; var13 < var0.size; var13++) {
    var14 = var0[var13];
    var15 = var2 scripts\cp\cp_spawning_util::increase_wave_ai_killed_counter(var14.origin);
    var16 = var2 scripts\cp\cp_spawning_util::increase_wave_ai_spawned_counter(var14.origin);

    if(var15 && var16) {
      var3 = var14;
      continue;
    }

    if(!var15 && !var16) {
      var6 = var14;
      continue;
    }

    if(!var15 && var16) {
      var5 = var14;
      continue;
    }

    if(var15 && !var16) {
      var4 = var14;
    }
  }

  if(isDefined(var3)) {
    if(var3.size > 64) {
      var9 = split_array_into_quadrants(var3);

      for(var13 = 0; var13 < var9.size; var13++) {
        var17 = var9[var13];

        if(isDefined(var17.child_spawners) && var17.child_spawners.size > 0) {
          var17.origin = scripts\cp\utility::get_center_point_of_array(var17.child_spawners);
          var17.angles = (0, 0, 0);
          var7 = var17;
        }
      }
    } else {
      var17 = spawnStruct();
      var17.child_spawners = var4;

      if(isDefined(var17.child_spawners) && var17.child_spawners.size > 0) {
        var17.origin = scripts\cp\utility::get_center_point_of_array(var17.child_spawners);
        var17.angles = (0, 0, 0);
        var8 = var17;
      }
    }
  }

  if(isDefined(var5)) {
    if(var5.size > 64) {
      var11 = split_array_into_quadrants(var5);

      for(var14 = 0; var14 < var11.size; var14++) {
        var17 = var11[var14];

        if(isDefined(var17.child_spawners) && var17.child_spawners.size > 0) {
          var17.origin = scripts\cp\utility::get_center_point_of_array(var17.child_spawners);
          var17.angles = (0, 0, 0);
          var8 = var17;
        }
      }
    } else {
      var17 = spawnStruct();
      var17.child_spawners = var6;

      if(isDefined(var17.child_spawners) && var17.child_spawners.size > 0) {
        var17.origin = scripts\cp\utility::get_center_point_of_array(var17.child_spawners);
        var17.angles = (0, 0, 0);
        var9 = var17;
      }
    }
  }

  if(isDefined(var7)) {
    if(var7.size > 64) {
      var13 = split_array_into_quadrants(var7);

      for(var15 = 0; var15 < var13.size; var15++) {
        var17 = var13[var15];

        if(isDefined(var17.child_spawners) && var17.child_spawners.size > 0) {
          var17.origin = scripts\cp\utility::get_center_point_of_array(var17.child_spawners);
          var17.angles = (0, 0, 0);
          var9 = var17;
        }
      }
    } else {
      var17 = spawnStruct();
      var17.child_spawners = var8;

      if(isDefined(var17.child_spawners) && var17.child_spawners.size > 0) {
        var17.origin = scripts\cp\utility::get_center_point_of_array(var17.child_spawners);
        var17.angles = (0, 0, 0);
        var10 = var17;
      }
    }
  }

  if(isDefined(var9)) {
    if(var9.size > 64) {
      var15 = split_array_into_quadrants(var9);

      for(var16 = 0; var16 < var15.size; var16++) {
        var17 = var15[var16];

        if(isDefined(var17.child_spawners) && var17.child_spawners.size > 0) {
          var17.origin = scripts\cp\utility::get_center_point_of_array(var17.child_spawners);
          var17.angles = (0, 0, 0);
          var10 = var17;
        }
      }
    } else {
      var17 = spawnStruct();
      var17.child_spawners = var10;

      if(isDefined(var17.child_spawners) && var17.child_spawners.size > 0) {
        var17.origin = scripts\cp\utility::get_center_point_of_array(var17.child_spawners);
        var17.angles = (0, 0, 0);
        var11 = var17;
      }
    }
  }

  var7 = undefined;
  var8 = undefined;
  var9 = undefined;
  var10 = undefined;
  var12 = undefined;
  var13 = undefined;
  var14 = undefined;
  var15 = undefined;
  var16 = undefined;
  return var11;
}

function assign_spawnpoints_to_parent_structs(var0) {
  var1 = scripts\cp\utility::get_center_point_of_array(var0);

  for(var2 = 0; var2 < var0.size; var2++) {}
}

function register_module_as_passive(var0) {
  if(isDefined(level.ambientgroups[var0])) {
    if(isarray(level.ambientgroups[var0])) {
      for(var1 = 0; var1 < level.ambientgroups[var0].size; var1++) {
        level.ambientgroups[var0][var1].is_passive = 1;
      }

      return;
    }

    level.ambientgroups[var0].is_passive = 1;
    return;
  }
}

function register_module_ai_spawn_func(var0, var1) {
  if(isDefined(level.ambientgroups[var0])) {
    if(isarray(level.ambientgroups[var0])) {
      for(var2 = 0; var2 < level.ambientgroups[var0].size; var2++) {
        if(!isDefined(level.ambientgroups[var0][var2].ai_spawn_func)) {
          level.ambientgroups[var0][var2].ai_spawn_func = [];
        }

        level.ambientgroups[var0][var2].ai_spawn_func[level.ambientgroups[var0][var2].ai_spawn_func.size] = var1;
      }

      return;
    }

    if(!isDefined(level.ambientgroups[var0].ai_spawn_func)) {
      level.ambientgroups[var0].ai_spawn_func = [];
    }

    level.ambientgroups[var0].ai_spawn_func[level.ambientgroups[var0].ai_spawn_func.size] = var1;
    return;
  }
}

function awardbunker11blueprint(var0, var1) {
  if(isDefined(level.active_spawn_module_structs[var0])) {
    if(isarray(level.active_spawn_module_structs[var0])) {
      for(var2 = 0; var2 < level.active_spawn_module_structs[var0].size; var2++) {
        if(!isDefined(level.active_spawn_module_structs[var0][var2].ai_spawn_func)) {
          level.active_spawn_module_structs[var0][var2].ai_spawn_func = [];
        }

        level.active_spawn_module_structs[var0][var2].ai_spawn_func[level.active_spawn_module_structs[var0][var2].ai_spawn_func.size] = var1;
      }

      return;
    }

    if(!isDefined(level.active_spawn_module_structs[var0].ai_spawn_func)) {
      level.active_spawn_module_structs[var0].ai_spawn_func = [];
    }

    level.active_spawn_module_structs[var0].ai_spawn_func[level.active_spawn_module_structs[var0].ai_spawn_func.size] = var1;
    return;
  }
}

function apply_func_to_all_in_group(var0, var1) {
  if(isDefined(level.active_spawn_module_structs[var0])) {
    var2 = level.active_spawn_module_structs[var0];

    if(isarray(var2)) {
      for(var3 = 0; var3 < var2.size; var3++) {
        var4 = var2[var3];

        for(var5 = 0; var5 < var4.ai_spawned.size; var5++) {
          var4.ai_spawned[var5] thread[[var1]]();
        }
      }

      return;
    }

    return;
  }
}

function register_module_weapons_free_func(var0, var1) {
  if(isDefined(level.ambientgroups[var0])) {
    if(isarray(level.ambientgroups[var0])) {
      for(var2 = 0; var2 < level.ambientgroups[var0].size; var2++) {
        if(!isDefined(level.ambientgroups[var0][var2].fn_weapons_free)) {
          level.ambientgroups[var0][var2].fn_weapons_free = [];
        }

        level.ambientgroups[var0][var2].fn_weapons_free[level.ambientgroups[var0][var2].fn_weapons_free.size] = var1;
      }

      return;
    }

    if(!isDefined(level.ambientgroups[var0].fn_weapons_free)) {
      level.ambientgroups[var0].fn_weapons_free = [];
    }

    level.ambientgroups[var0].fn_weapons_free[level.ambientgroups[var0].fn_weapons_free.size] = var1;
    return;
  }
}

function register_module_ai_death_func(var0, var1) {
  if(isDefined(level.ambientgroups[var0])) {
    if(isarray(level.ambientgroups[var0])) {
      for(var2 = 0; var2 < level.ambientgroups[var0].size; var2++) {
        if(!isDefined(level.ambientgroups[var0][var2].ai_death_func)) {
          level.ambientgroups[var0][var2].ai_death_func = [];
        }

        level.ambientgroups[var0][var2].ai_death_func[level.ambientgroups[var0][var2].ai_death_func.size] = var1;
      }

      return;
    }

    if(!isDefined(level.ambientgroups[var0].ai_death_func)) {
      level.ambientgroups[var0].ai_death_func = [];
    }

    level.ambientgroups[var0].ai_death_func[level.ambientgroups[var0].ai_death_func.size] = var1;
    return;
  }
}

function register_module_run_func_after_notify(var0, var1, var2) {
  if(isDefined(level.ambientgroups[var0])) {
    if(isarray(level.ambientgroups[var0])) {
      for(var3 = 0; var3 < level.ambientgroups[var0].size; var3++) {
        if(!isDefined(level.ambientgroups[var0][var3].funcs_after_notifies)) {
          level.ambientgroups[var0][var3].funcs_after_notifies = [];
        }

        level.ambientgroups[var0][var3].funcs_after_notifies[var1] = var2;
      }

      return;
    }

    if(!isDefined(level.ambientgroups[var0].funcs_after_notifies)) {
      level.ambientgroups[var0].funcs_after_notifies = [];
    }

    level.ambientgroups[var0].funcs_after_notifies[var1] = var2;
    return;
  }
}

function module_run_func_after_notify() {
  if(isDefined(self.funcs_after_notifies)) {
    self endon("all_group_spawns_dead");
    var0 = getarraykeys(self.funcs_after_notifies);

    for(;;) {
      var1 = level scripts\engine\utility::waittill_any_in_array_return(var0);
      self thread[[self.funcs_after_notifies[var1]]]();
    }

    return;
  }
}

function set_kill_off_vars(var0, var1, var2) {
  var0.kill_off_time_override = var1;
  var0.last_seen_time_override = var2;
}

function toggle_always_attempt_killoff(var0, var1) {}

function module_always_attempt_killoff(var0) {
  if(isDefined(level.ambientgroups[var0])) {
    if(isarray(level.ambientgroups[var0])) {
      for(var1 = 0; var1 < level.ambientgroups[var0].size; var1++) {
        level.ambientgroups[var0][var1].always_attempt_killoff = 1;
      }

      return;
    }

    level.ambientgroups[var0].always_attempt_killoff = 1;
    return;
  }
}

function force_module_cqb_scoring(var0) {
  if(isDefined(level.ambientgroups[var0])) {
    if(isarray(level.ambientgroups[var0])) {
      for(var1 = 0; var1 < level.ambientgroups[var0].size; var1++) {
        level.ambientgroups[var0][var1].cqb_module = 1;
      }

      return;
    }

    level.ambientgroups[var0].cqb_module = 1;
    return;
  }
}

function override_spawn_scoring_for_module_struct(var0, var1, var2, var3, var4) {
  create_spawn_scoring_struct(var0, var1, var2, var3, var4);
}

function ref_130e7(var0, var1, var2, var3, var4) {
  if(isDefined(var4)) {
    var5 = level.gametype;
    var6 = strtok(var4, " ");

    for(var7 = 0; var7 < var6.size; var7++) {
      if(var6[var7] == var5) {
        break;
      }
    }

    return;
  }

  level.spawn_scoring_overrides = create_spawn_scoring_struct(var3, var4, var5, var6);
}

function set_spawn_scoring_params_for_group(var0, var1, var2, var3, var4, var5) {
  if(isDefined(var5)) {
    var6 = level.gametype;
    var7 = strtok(var5, " ");

    for(var8 = 0; var8 < var7.size; var8++) {
      if(var7[var8] == var6) {
        break;
      }
    }

    return;
  }

  if(isDefined(level.ambientgroups[var3])) {
    if(isarray(level.ambientgroups[var3])) {
      for(var8 = 0; var8 < level.ambientgroups[var3].size; var8++) {
        level.ambientgroups[var3][var8].spawn_scoring_overrides = create_spawn_scoring_struct(var4, var5, var6, var7);
      }

      return;
    }

    level.ambientgroups[var3].spawn_scoring_overrides = create_spawn_scoring_struct(var4, var5, var6, var7);
    return;
  }
}

function create_spawn_scoring_struct(var0, var1, var2, var3) {
  var4 = spawnStruct();

  if(isDefined(var0)) {
    var4.close_dist = int(var0);
  } else {
    var4.close_dist = 1024;
  }

  var4.close_dist_sq = var4.close_dist * var4.close_dist;

  if(isDefined(var1)) {
    var4.far_dist = int(var1);
  } else {
    var4.far_dist = 2048;
  }

  var4.far_dist_sq = var4.far_dist * var4.far_dist;

  if(isDefined(var2)) {
    var4.ref_13bdb = int(var2);
    var4.too_far_dist_sq = var4.ref_13bdb * var4.ref_13bdb;
  } else {
    var4.ref_13bdb = 4096;
    var4.too_far_dist_sq = 16777216;
  }

  if(isDefined(var3)) {
    var4.far_score = int(var3);
  } else {
    var4.far_score = 20;
  }

  return var4;
}

function get_spawned_ai_from_group_struct(var0) {
  var1 = [];

  if(isstruct(self)) {
    if(isarray(self)) {
      for(var2 = 0; var2 < self.size; var2++) {
        var1 = scripts\engine\utility::array_combine(var1, self[var2].ai_spawned);
      }
    } else {
      var1 = self.ai_spawned;
    }
  } else if(isDefined(level.active_spawn_module_structs[var0])) {
    var3 = level.active_spawn_module_structs[var0];

    if(isarray(var3)) {
      for(var4 = 0; var4 < var3.size; var4++) {
        var5 = var3[var4];
        var1 = scripts\engine\utility::array_combine(var1, var5.ai_spawned);
      }
    } else {
      var1 = scripts\engine\utility::array_combine(var1, var3.ai_spawned);
    }
  }

  return var1;
}

function make_ai_usable(var0, var1, var2, var3, var4, var5) {
  if(isDefined(var1)) {
    self.onuse = var1;
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

  if(isDefined(var2)) {
    self.trigger setHintString(var2);
  }

  if(isDefined(var4)) {
    set_goal_radius(var4);
  }

  if(isDefined(var5)) {
    self.goalheight = var5;
  }

  thread scripts\engine\utility::delete_on_death(self.trigger);
  thread ai_used_think(var3);
}

function ai_used_think(var0) {
  self endon("death");
  self endon("downed");
  self endon("exfil");
  self.trigger endon("death");

  for(;;) {
    self.trigger waittill("trigger", var1);

    if(!var1 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(isDefined(self.onuse)) {
      self thread[[self.onuse]](var1, var0);
    }
  }
}

function follow_triggering_player(var0, var1) {
  self notify("follow_triggering_player");
  self endon("follow_triggering_player");
  self endon("death");
  var0 endon("death_or_disconnect");
  var0 endon("last_stand");

  if(isDefined(var1)) {
    create_head_icon_for_ai(var1);
  }

  for(;;) {
    set_goal_ent(var0);
    wait 1;
    var0 = scripts\cp\utility::get_closest_living_player();
  }
}

function create_head_icon_for_ai(var0) {
  self.headicon = deleteheadicon(self);
  setheadiconfriendlyimage(self.headicon, var0);
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

  var0 = self.headicon;
  var1 = scripts\engine\utility::ref_143a5("death", "remove_headicon");
  setheadiconimage(var0);
}

function disable_kill_off(var0, var1, var2, var3) {
  var0.disable_kill_off = 1;
}

function quarry_hacks_count(var0) {
  if(isDefined(level.ambientgroups) && isDefined(level.ambientgroups[var0])) {
    return level.ambientgroups[var0];
  }

  return undefined;
}

function isambientspawningpaused(var0) {
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

function allowed_to_spawn_agent(var0, var1, var2, var3) {
  var4 = get_total_reserved_slot_count();
  var5 = get_max_agent_count();
  var6 = var5 - var4;
  var7 = level.spawned_ai.size - level.delayed_spawn_slots;
  var8 = var6 - var7;

  if(isDefined(var0)) {
    var9 = get_comp_count(var0);

    if(!isDefined(var9)) {
      return 0;
    }

    var10 = var9 - get_activecount_from_group(var0, 1);
    var11 = get_reserved_slot_count_by_string_id(var3);
    var6 = var5 - var4 + var11;

    if(!istrue(var0.kill_off_enemies)) {
      if(var10 > 0 && var8 > 0) {
        return 1;
      }

      return 0;
    }

    if(var10 > 0 && var8 > 0) {
      return 1;
    }

    if(!istrue(var0.min_spawn_requested)) {
      var0.min_spawn_requested = 1;
      increase_reserved_spawn_slots(var0, 1, var0.moduleid, var0);
    }

    var12 = 0;

    if(!istrue(var0.disable_kill_off)) {
      var13 = int(abs(var8));
      var12 = kill_off_enemies(var0, int(clamp(var13, 1, var6)), istrue(var0.kill_off_enemies) || istrue(var1));
    }

    if(var12 > 0) {
      wait 0.1;
    }

    var14 = level.spawned_ai.size - level.delayed_spawn_slots;
    var15 = var6 - var14;
    return var15;
  }

  if(var11 < 1) {
    var13 = int(abs(var11));
    var12 = kill_off_enemies(undefined, int(clamp(var13, 1, var9)), istrue(var4));

    if(var12 > 0) {
      wait 0.1;
    }

    var14 = level.spawned_ai.size - level.delayed_spawn_slots;
    var15 = var9 - var14;
    return var15;
  }

  return var15;
}

function get_max_agent_count(var0) {
  var1 = getdvarint("scr_default_maxagents", 32);
  var2 = 32;
  var3 = getdvarint("scr_maxagents_override", var1);

  if(var2 > var1) {
    return int(var2);
  }

  return int(clamp(var3, var2, var1));
}

function is_agent_in_group(var0, var1) {
  if(!isDefined(var1.enemy_group)) {
    return false;
  }

  if(var0 == var1.enemy_group) {
    return true;
  }

  return false;
}

function propent(var0, var1) {
  var2 = project(var0);
  var3 = project(var1);
  return var2 > var3;
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
  var0 = 1073741824;
  var1 = undefined;

  foreach(var3 in level.players) {
    var4 = distancesquared(self.origin, var3.origin);

    if(var4 < var0) {
      var1 = var3;
      var0 = var4;
    }
  }

  return var0;
}

function vehicle_preventplayercollisiondamagefortimeafterexit() {
  self endon("death");
  self.ref_133b6 = 1;
  self.playeriszombie = 1;
  self.ref_12fc1 = 1;

  for(;;) {
    var0 = passive_kill_off_ai(1);

    if(isDefined(var0) && !var0) {
      self.ref_133b6 = undefined;
      self.playeriszombie = undefined;
      break;
    }

    wait 0.25;
  }
}

function kill_off_enemies(var0, var1, var2, var3) {
  var4 = 0;
  var5 = gettime();

  if(isDefined(var0)) {
    level.compare_group_name = var0.group_name;
  }

  if(istrue(var2) && var1 > var4) {
    var6 = getaiarray("axis");
    var7 = scripts\engine\utility::array_sort_with_func(var6, &propent);
    var7 = scripts\cp\utility::array_sort_by_handler(var7, &ref_134d3);

    for(var8 = 0; var8 < var7.size; var8++) {
      if(passive_kill_off_ai(var7[var8], 1)) {
        var4++;

        if(var1 <= var4) {
          return var4;
        }
      }
    }

    var7 = scripts\engine\utility::array_removedead(var7);

    for(var8 = 0; var8 < var7.size; var8++) {
      var9 = var7[var8];

      if(has_never_kill_off_flag(var9)) {
        continue;
      }

      if(istrue(scripts\engine\utility::script_func("ai_is_carrying_hvt", var9))) {
        continue;
      }

      if(!isDefined(var9) || !isalive(var9) || var9.health <= 0) {
        continue;
      }

      if(isDefined(var9.team) && var9.team == "allies") {
        continue;
      }

      if(isDefined(var0) && scripts\engine\utility::is_equal(var9.enemy_group, var0.group_name)) {
        thread teleport_to_nearby_spawner(var9);
        continue;
      }

      script_kill_ai(var9);
      var4++;

      if(var1 <= var4) {
        return var4;
      }
    }
  }

  return var4;
}

function passed_kill_off_time_checks(var0) {
  if(isDefined(self.killofftime) && var0 <= self.killofftime) {
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

function can_be_script_killed(var0, var1) {
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
      if(!isDefined(var0) || var0 != self.group) {
        return 0;
      }
    }
  }

  if(var1 && isDefined(self.enemy_group) && isDefined(var0)) {
    if(self.enemy_group != var0.group_name) {
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
  var0 = 0;

  if(!is_riding_vehicle()) {
    var0 += 15;
  }

  if(is_same_group()) {
    var0 += 15;
  }

  if(!is_bad_path()) {
    var0 += 10;
  }

  if(!is_always_on_group()) {
    var0 += 25;
  }

  return var0;
}

function get_killoff_time() {
  if(isDefined(self.killofftime)) {
    return self.killofftime;
  }

  return 0;
}

function watch_for_all_groups_dead(var0, var1) {
  level endon("group_" + var1 + "_ended");
  var2 = 0;
  var3 = [];

  foreach(var5 in var0) {
    thread notify_when_group_ends(var5, var1, var2);
    var3 = var1 + var2 + "_completed";
    var2++;
  }

  level scripts\engine\utility::waittill_all_in_array(var3);
  level notify("module_group " + var1 + " completed");
}

function notify_when_group_ends(var0, var1, var2) {
  level endon("group_" + var1 + "_ended");
  var0 waittill("group_spawning_completed");
  level notify(var1 + var2 + "_completed");
}

function run_spawn_module(var0, var1, var2, var3, var4) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");

  if(getdvarint("scr_always_on_always", 0)) {
    if(var0 != "always_on" && var0 != "Max Agent Test") {
      return;
    }
  }

  if(getdvarint("scr_only_passive_spawning", 0)) {
    if(isDefined(level.ambientgroups[var0]) && !istrue(level.ambientgroups[var0].is_passive)) {
      return;
    }
  }

  level notify("new_spawn_module_requested_" + var0);
  level.active_spawn_modules[level.active_spawn_modules.size] = var0;

  if(!isDefined(level.active_spawn_module_structs[var0])) {
    level.active_spawn_module_structs[var0] = [];
  }

  if(!isDefined(level.spawn_module_structs_memory[var0])) {
    level.spawn_module_structs_memory[var0] = [];
  }

  var5 = create_module_struct(var0);

  if(isDefined(var5)) {
    if(isarray(var5)) {
      thread watch_for_all_groups_dead(var5, var5);

      foreach(var2 in var5) {
        thread add_and_watch_group(level, var2);
      }

      foreach(var2 in var5) {
        thread ref_12dda(level, var2);
      }
    } else {
      thread add_and_watch_group(level, var5);
      thread ref_12dda(level, var5);
    }

    return var5;
  }
}

function add_and_watch_group(var0, var1) {
  level endon("game_ended");
  level.active_spawn_module_structs[var1][level.active_spawn_module_structs[var1].size] = var0;
  level.spawn_module_structs_memory[var1][level.spawn_module_structs_memory[var1].size] = var0;
  var0 waittill("death");

  if(get_activecount_from_group(var0, 1) < 1) {
    scripts\cp\cp_spawning_util::ref_12bd3(var0);

    if(isDefined(level.spawn_module_structs_memory[var0.group_name]) && scripts\engine\utility::array_contains(level.spawn_module_structs_memory[var0.group_name], var0)) {
      level.spawn_module_structs_memory[var0.group_name] = scripts\engine\utility::array_remove(level.spawn_module_structs_memory[var0.group_name], var0);

      if(isDefined(level.spawn_module_structs_memory[var0.group_name]) && level.spawn_module_structs_memory[var0.group_name].size < 1) {
        level.spawn_module_structs_memory[var0.group_name] = undefined;
      }
    }
  }

  if(scripts\engine\utility::array_contains(level.active_spawn_module_structs[var1], var0)) {
    level.active_spawn_module_structs[var1] = scripts\engine\utility::array_remove(level.active_spawn_module_structs[var1], var0);

    if(isDefined(level.active_spawn_module_structs[var1]) && level.active_spawn_module_structs[var1].size < 1) {
      level.active_spawn_module_structs[var1] = undefined;
      return;
    }

    return;
  }
}

function create_module_struct(var0) {
  var1 = quarry_hacks_count(var0);

  if(isDefined(var1)) {
    if(isarray(var1)) {
      var2 = [];

      foreach(var4 in var1) {
        var5 = copy_from_level_struct(var4);
        var2 = scripts\engine\utility::array_add(var2, var5);
      }

      return var2;
    }

    var5 = copy_from_level_struct(var6);
    return var5;
  }
}

function copy_from_level_struct(var0) {
  var1 = spawnStruct();
  var1.group_name = var0.group_name;
  var1.min_size = var0.min_size;
  var1.max_size = var0.max_size;
  var1.time_between_spawns = var0.time_between_spawns;
  var1.post_module_delay = var0.post_module_delay;
  var1.activecount = var0.activecount;
  var1.spawn_count = var0.spawn_count;
  var1.ai_spawned = var0.ai_spawned;
  var1.spawn_points = var0.spawn_points;
  var1.totalspawns = var0.totalspawns;
  var1.start_func = var0.start_func;
  var1.nextgroup = var0.nextgroup;
  var1.timeout_action = var0.timeout_action;
  var1.currentmodulekills = var0.currentmodulekills;
  var1.currentmoduledeaths = var0.currentmoduledeaths;
  var1.moduleid = var0.moduleid;
  var1.ai_spawn_func = var0.ai_spawn_func;
  var1.ai_death_func = var0.ai_death_func;
  var1.fn_weapons_free = var0.fn_weapons_free;
  var1.cqb_module = var0.cqb_module;
  var1.always_attempt_killoff = var0.always_attempt_killoff;
  var1.status = var0.status;
  var1.spawn_scoring_overrides = var0.spawn_scoring_overrides;
  var1.aievent_funcs = var0.aievent_funcs;
  var1.is_passive = var0.is_passive;
  var1.module_vehicles = var0.module_vehicles;
  var1.ref_11cb0 = var0.ref_11cb0;
  var1.disable_spawners_until_owner_death = var0.disable_spawners_until_owner_death;
  var1.combined_counters = var0.combined_counters;
  var1.ref_141b3 = var0.ref_141b3;
  var1.debug_data = var0.debug_data;
  var1.ref_13be5 = var0.ref_13be5;
  var1.set_chosen_spawner_from_uid = var0.set_chosen_spawner_from_uid;
  var1.serverroomrewardroll = var0.serverroomrewardroll;
  var1.lightsfloor02 = var0.lightsfloor02;
  var1.level_module_struct = var0;
  level.requested_spawns_groups[var1.moduleid] = 0;
  var1 scripts\engine\utility::ent_flag_init("pause_group");
  var1 scripts\engine\utility::ent_flag_init("weapons_free");
  return var1;
}

function add_to_module_vehicles_list(var0, var1) {
  if(isDefined(var1)) {
    if(!isDefined(var0.vehicle_caps_counter)) {
      var0.vehicle_caps_counter = [];
    }

    if(!isDefined(var0.vehicle_caps_counter[var1])) {
      var0.vehicle_caps_counter[var1] = 1;
    } else {
      var0.vehicle_caps_counter[var1]++;
    }
  }

  var0.ref_11cb0++;
  var0.module_vehicles[var0.module_vehicles.size] = self;
  thread scripts\engine\utility::thread_on_notify_no_endon_death("death", &remove_from_module_vehicles_list, var0, var1);
}

function has_vehicle_type_exceeded_module_cap(var0, var1) {
  if(!isDefined(var0.vehicle_caps)) {
    return false;
  }

  if(isDefined(var0.vehicle_caps[var1])) {
    if(!isDefined(var0.vehicle_caps_counter)) {
      return false;
    }

    if(!isDefined(var0.vehicle_caps_counter[var1])) {
      return false;
    }

    if(triggerenterfunc(var0.vehicle_caps_counter[var1], var0.vehicle_caps[var1])) {
      return true;
    }
  }

  return false;
}

function remove_from_module_vehicles_list(var0, var1) {
  if(isDefined(var1)) {
    if(isDefined(var0.vehicle_caps_counter)) {
      if(isDefined(var0.vehicle_caps_counter[var1])) {
        var0.vehicle_caps_counter[var1]--;

        if(var0.vehicle_caps_counter[var1] < 0) {
          var0.vehicle_caps_counter[var1] = 0;
        }
      }
    }
  }

  if(scripts\engine\utility::array_contains(var0.module_vehicles, self)) {
    var0.module_vehicles = scripts\engine\utility::array_remove(var0.module_vehicles, self);
  }

  var0 notify("vehicle_removed_from_group");
}

function timeout_group_after_duration() {
  self endon("death");
  level notify("timeout_group_after_duration_" + self.moduleid);
  level endon("timeout_group_after_duration_" + self.moduleid);
  level endon("group_" + self.group_name + "_ended");
  var0 = process_module_var(self, self.timeout_action);

  if(isDefined(var0) && isnumber(var0)) {
    wait var0;
  }

  level notify("spawnModuleTimedOut_" + self.moduleid);
}

function ref_12dda(var0, var1) {
  level notify("run_current_spawn_group" + var0.moduleid);
  level endon("game_ended");
  var0 endon("death");
  thread watch_for_module_endons();
  thread ref_12df3();
  thread module_run_func_after_notify();

  if(isDefined(var0.timeout_action)) {
    thread timeout_group_after_duration();
  }

  change_module_status(var0, undefined, "Init Funcs");
  var0 scripts\cp\cp_spawning_util::run_module_init_funcs_on_module_struct();

  if(isDefined(var0.start_func)) {
    change_module_status(var0, undefined, "Start Func");
    process_module_var(var0, var0.start_func);
  }

  thread run_weapons_free_funcs();

  if(getDvar("scr_module_iso", "") != "" && getDvar("scr_module_iso", "") == var0.group_name) {
    thread ref_12e20(level, var0);
  } else {
    thread runspawnmodule(level, var0);
  }

  var0 waittill("death");
}

function run_weapons_free_funcs() {
  if(isDefined(self.fn_weapons_free)) {
    scripts\engine\utility::ent_flag_wait("weapons_free");

    for(var0 = 0; var0 < self.fn_weapons_free.size; var0++) {
      thread process_module_var(self, self.fn_weapons_free[var0]);
    }

    return;
  }
}

function ref_12ddd() {
  if(isDefined(self.group.lightsfloor02)) {
    for(var0 = 0; var0 < self.group.lightsfloor02.size; var0++) {
      thread process_module_var(self.group, self.group.lightsfloor02[var0]);
    }

    return;
  }
}

function ref_12df3() {
  level endon("game_ended");
  self endon("death");
  var0 = level scripts\engine\utility::ref_143ad("spawn_module_" + self.moduleid + "_completed", "spawnModuleTimedOut_" + self.moduleid);

  if(isDefined(self.post_module_delay)) {
    var1 = process_module_var(self, self.post_module_delay);

    if(isDefined(var1) && isnumberandgreaterthanzero(var1)) {
      level scripts\engine\utility::ref_143b9(var1, "new_module_requested");
    }

    level notify("group_" + self.group_name + "_post_module_complete");
  }

  if(isDefined(self.nextgroup)) {
    var2 = process_module_var(self, self.nextgroup);

    if(isDefined(var2) && isstring(var2)) {
      thread run_spawn_module(level, var2, undefined);
    }
  }

  self notify("death");
}

function remove_pacifist_from_enemies() {
  for(var0 = 0; var0 < level.spawned_enemies.size; var0++) {
    level.spawned_enemies[var0].pacifist = 0;
    level.spawned_enemies[var0].script_pacifist = undefined;
    thread enter_combat_after_stealth();
  }
}

function remove_pacifist_from_guy() {
  self.pacifist = 0;
  self.script_pacifist = undefined;
}

function demeanor_override_all_enemies(var0) {
  for(var1 = 0; var1 < level.spawned_enemies.size; var1++) {
    set_demeanor_from_unittype(level.spawned_enemies[var1], var0);
  }
}

function set_dont_enter_combat_flag(var0) {
  self.dont_enter_combat = 1;
}

function clear_dont_enter_combat_flag() {
  self.dont_enter_combat = undefined;
}

function watch_for_module_endons() {
  level endon("game_ended");
  self endon("death");
  var0 = ["run_current_spawn_group" + self.moduleid, "end_spawn_module_" + self.moduleid, "end_spawn_module_" + self.group_name];
  level scripts\engine\utility::waittill_any_in_array_return(var0);
  self notify("death");
}

function isnumberandgreaterthanzero(var0) {
  if(isDefined(var0) && isnumber(var0) && var0 > 0) {
    return 1;
  }

  return 0;
}

function runspawnmodule(var0, var1) {
  level endon("game_ended");
  level notify("runSpawnModule_" + var0.moduleid);
  level endon("runSpawnModule_" + var0.moduleid);
  var0 endon("death");
  thread resetgroupvariables();
  waittillframeend();

  for(;;) {
    if(isambientspawningpaused(var0)) {
      change_module_status(var0, undefined, "Module Paused");
      continue;
    }

    var2 = process_module_var(var0, var0.totalspawns);
    var0.debug_data.totalspawns = var2;

    if(var2 > 0 && get_activecount_from_group(var0, 1) + var0.currentmodulekills >= var2) {
      level notify("spawn_module_" + var0.moduleid + "_completed");
      return;
    }

    var2 = process_module_var(var0, var0.totalspawns);
    var0.debug_data.totalspawns = var2;
    var3 = get_comp_count(var0);
    var4 = get_comp_count(var0, 0);
    var5 = allowed_to_spawn_agent(var0);

    if(var5) {
      if(isDefined(var3) && isDefined(var4) && get_activecount_from_group(var0, 1) < var3 && get_activecount_from_group(var0) < var4) {
        spawn_soldier_scripted(var0, var0);
      }

      var6 = process_module_var(var0, var0.time_between_spawns);

      if(isnumberandgreaterthanzero(var6)) {
        wait var6;
      } else {
        waitframe();
      }

      continue;
    }

    wait 0.1;
  }
}

function ref_12e20(var0, var1) {
  level endon("game_ended");
  level notify("runSpawnModule_" + var0.moduleid);
  level endon("runSpawnModule_" + var0.moduleid);
  var0 endon("death");
  thread resetgroupvariables();

  for(;;) {
    if(isambientspawningpaused(var0)) {
      change_module_status(var0, undefined, "Module Paused");
      continue;
    }

    var2 = process_module_var(var0, var0.totalspawns);
    var0.debug_data.totalspawns = var2;

    if(var2 > 0 && get_activecount_from_group(var0, 1) + var0.currentmodulekills >= var2) {
      level notify("spawn_module_" + var0.moduleid + "_completed");
      return;
    }

    var2 = process_module_var(var0, var0.totalspawns);
    var0.debug_data.totalspawns = var2;
    var3 = get_comp_count(var0);
    var4 = get_comp_count(var0, 0);
    var5 = allowed_to_spawn_agent(var0);

    if(var5) {
      if(isDefined(var3) && isDefined(var4) && get_activecount_from_group(var0, 1) < var3 && get_activecount_from_group(var0) < var4) {
        spawn_soldier_scripted(var0, var0);
      }

      var6 = process_module_var(var0, var0.time_between_spawns);

      if(isnumberandgreaterthanzero(var6)) {
        wait var6;
      }

      continue;
    }

    wait 0.1;
  }
}

function get_comp_count(var0) {
  var1 = process_module_var(self, self.min_size);
  self.debug_data.min_size = var1;
  self.kill_off_enemies = undefined;
  var0 = define_var_if_undefined(var0, 1);

  if(isDefined(var1) && get_activecount_from_group(var0) < var1) {
    self.kill_off_enemies = 1;
    level.requested_spawns_groups[self.moduleid] = var1;
    return var1;
  }

  var2 = process_module_var(self, self.max_size);
  self.debug_data.max_size = var2;

  if(isDefined(var2) && get_activecount_from_group(var0) < var2) {
    level.requested_spawns_groups[self.moduleid] = var2;
    return var2;
  }

  return undefined;
}

function send_aievent_to_others_in_group(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var5)) {
    var5 = self;
  }

  if(isDefined(var1)) {
    if(isarray(self.group)) {
      var6 = [];

      for(var7 = 0; var7 < self.group.size; var7++) {
        var6 = scripts\engine\utility::array_add(var6, self.group[var7].ai_spawned);
      }

      var8 = scripts\engine\utility::get_array_of_closest(self.origin, var6, undefined, undefined, var1, 0);
    } else {
      var8 = scripts\engine\utility::get_array_of_closest(self.origin, self.group.ai_spawned, undefined, undefined, var2, 0);
    }
  } else if(isarray(self.group)) {
    var6 = [];

    for(var7 = 0; var7 < self.group.size; var7++) {
      var6 = scripts\engine\utility::array_add(var6, self.group[var7].ai_spawned);
    }

    var8 = var6;
  } else {
    var8 = self.group.ai_spawned;
  }

  for(var7 = 0; var7 < var8.size; var7++) {
    if(var8[var7] == self) {
      if(istrue(var8)) {
        var8[var7] aieventlistenerevent(var3, var8, self.origin);
        continue;
      } else {
        continue;
      }
    }

    if(istrue(var5) && !scripts\engine\utility::within_fov(self.origin, self.angles, var8[var7].origin, cos(65))) {
      continue;
    }

    if(istrue(var8) && !self aiphysicstracepassed(self.origin, var8[var7].origin, 15, 60)) {
      continue;
    }

    var8[var7] aieventlistenerevent(var3, var8, self.origin);
  }
}

function notify_others_in_group(var0, var1, var2, var3, var4) {
  if(istrue(var4)) {
    var5 = getaiarray("axis");
  } else {
    var5 = self.group.ai_spawned;
  }

  if(isDefined(var2)) {
    var5 = scripts\engine\utility::get_array_of_closest(self.origin, var5, undefined, undefined, var2, 0);
  }

  for(var6 = 0; var6 < var5.size; var6++) {
    if(var5[var6] == self) {
      continue;
    }

    if(istrue(var3) && !scripts\engine\utility::within_fov(var5[var6].origin, var5[var6].angles, self.origin, cos(65))) {
      continue;
    }

    if(istrue(var4) && !var5[var6] cansee(self)) {
      continue;
    }

    var5[var6] notify(var1);
  }
}

function get_requested_spawn_count(var0) {
  var1 = 0;

  foreach(var3 in level.requested_spawns_groups) {
    if(isDefined(var0) && var0 == var4) {
      continue;
    }

    var1 += var3;
  }

  return var1;
}

function run_func_on_group_by_groupname(var0, var1) {
  foreach(var3 in level.active_spawn_module_structs) {
    if(isarray(var3)) {
      foreach(var5 in var3) {
        if(var5.group_name == var0) {
          process_module_var(var5, var5, var1);
        }
      }

      continue;
    }

    if(var3.group_name == var0) {
      process_module_var(var3, var3, var1);
    }
  }
}

function pause_all_other_groups(var0) {
  foreach(var2 in level.active_spawn_module_structs) {
    if(isarray(var2)) {
      foreach(var4 in var2) {
        if(var4.group_name != var0) {
          if(getdvarint("scr_show_module_pauses", 0)) {
            announcement(var4.group_name + " ^1Paused");
          }

          var4 scripts\engine\utility::ent_flag_set("pause_group");
        }
      }

      continue;
    }

    if(var2.group_name != var0) {
      if(getdvarint("scr_show_module_pauses", 0)) {
        announcement(var2.group_name + " ^1Paused");
      }

      var2 scripts\engine\utility::ent_flag_set("pause_group");
    }
  }
}

function unpause_all_other_groups(var0) {
  foreach(var2 in level.active_spawn_module_structs) {
    if(isarray(var2)) {
      foreach(var4 in var2) {
        if(var4.group_name != var0) {
          if(getdvarint("scr_show_module_pauses", 0)) {
            announcement(var4.group_name + " ^3Unpaused");
          }

          var4 scripts\engine\utility::ent_flag_clear("pause_group");
        }
      }

      continue;
    }

    if(var2.group_name != var0) {
      if(getdvarint("scr_show_module_pauses", 0)) {
        announcement(var2.group_name + " ^3Unpaused");
      }

      var2 scripts\engine\utility::ent_flag_clear("pause_group");
    }
  }
}

function pause_group_by_id(var0, var1) {
  foreach(var3 in level.active_spawn_module_structs) {
    if(isarray(var3)) {
      foreach(var5 in var3) {
        if(var5.group_name == var0 && var5.moduleid == var1) {
          if(getdvarint("scr_show_module_pauses", 0)) {
            announcement(var5.group_name + " ^1Paused");
          }

          var5 scripts\engine\utility::ent_flag_set("pause_group");
        }
      }

      continue;
    }

    if(var3.group_name == var0 && var3.moduleid == var1) {
      if(getdvarint("scr_show_module_pauses", 0)) {
        announcement(var3.group_name + " ^1Paused");
      }

      var3 scripts\engine\utility::ent_flag_set("pause_group");
    }
  }
}

function unpause_group_by_id(var0, var1) {
  foreach(var3 in level.active_spawn_module_structs) {
    if(isarray(var3)) {
      foreach(var5 in var3) {
        if(var5.group_name == var0 && var5.moduleid == var1) {
          if(getdvarint("scr_show_module_pauses", 0)) {
            announcement(var5.group_name + " ^3Unpaused");
          }

          var5 scripts\engine\utility::ent_flag_clear("pause_group");
        }
      }

      continue;
    }

    if(var3.group_name == var0 && var3.moduleid == var1) {
      if(getdvarint("scr_show_module_pauses", 0)) {
        announcement(var3.group_name + " ^3Unpaused");
      }

      var3 scripts\engine\utility::ent_flag_clear("pause_group");
    }
  }
}

function set_weapons_free_for_all_groups() {
  foreach(var1 in level.spawn_module_structs_memory) {
    if(isarray(var1)) {
      foreach(var3 in var1) {
        var3 scripts\engine\utility::ent_flag_set("weapons_free");
      }

      continue;
    }

    var1 scripts\engine\utility::ent_flag_set("weapons_free");
  }
}

function pause_group_by_group_name(var0) {
  foreach(var2 in level.active_spawn_module_structs) {
    if(isarray(var2)) {
      foreach(var4 in var2) {
        if(var4.group_name == var0) {
          if(getdvarint("scr_show_module_pauses", 0)) {
            announcement(var4.group_name + " ^1Paused");
          }

          var4 scripts\cp\cp_spawning_util::ref_12dee();
          var4 scripts\engine\utility::ent_flag_set("pause_group");
        }
      }

      continue;
    }

    if(var2.group_name == var0) {
      if(getdvarint("scr_show_module_pauses", 0)) {
        announcement(var2.group_name + " ^1Paused");
      }

      var2 scripts\cp\cp_spawning_util::ref_12dee();
      var2 scripts\engine\utility::ent_flag_set("pause_group");
    }
  }
}

function unpause_group_by_group_name(var0) {
  foreach(var2 in level.active_spawn_module_structs) {
    if(isarray(var2)) {
      foreach(var4 in var2) {
        if(var4.group_name == var0) {
          if(getdvarint("scr_show_module_pauses", 0)) {
            announcement(var2.group_name + " ^3Unpaused");
          }

          var4 scripts\cp\cp_spawning_util::ref_12def();
          var4 scripts\engine\utility::ent_flag_clear("pause_group");
        }
      }

      continue;
    }

    if(var2.group_name == var0) {
      if(getdvarint("scr_show_module_pauses", 0)) {
        announcement(var2.group_name + " ^3Unpaused");
      }

      var2 scripts\cp\cp_spawning_util::ref_12def();
      var2 scripts\engine\utility::ent_flag_clear("pause_group");
    }
  }
}

function stop_all_groups() {
  var0 = getarraykeys(level.active_spawn_module_structs);

  for(var1 = 0; var1 < var0.size; var1++) {
    stop_module_by_groupname(var0[var1]);
  }
}

function stop_module_by_id(var0) {
  level notify("end_spawn_module_" + var0);
}

function stop_module_by_groupname(var0, var1) {
  if(isDefined(level.active_spawn_module_structs[var0])) {
    var2 = level.active_spawn_module_structs[var0];

    if(isarray(var2)) {
      foreach(var4 in var2) {
        if(istrue(var1)) {
          level notify("spawn_module_" + var4.moduleid + "_completed");
          continue;
        }

        var4 notify("death");
      }

      return;
    }

    if(istrue(var1)) {
      level notify("spawn_module_" + var2.moduleid + "_completed");
      return;
    }

    var2 notify("death");
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

function process_module_var(var0, var1, var2, var3) {
  level endon("game_ended");
  var0 endon("death");
  self endon("var_param_race_timeout");

  if(!isDefined(var1)) {
    return "empty";
  }

  var4 = var1;

  if(isstring(var1)) {
    return var1;
  } else if(isnumberandgreaterthanzero(var1)) {
    return var1;
  } else if(isarray(var1)) {
    if(isarray(var1[0])) {
      for(var5 = 0; var5 < var1.size; var5++) {
        var4 = process_module_var(var0, var1[var5], var2);
      }
    } else if(isbuiltinfunction(var1[0])) {
      var6 = var1[0];
      var7 = [];
      var8 = process_module_params(var0, var1);
      var4 = run_modular_spawning_func(var0, var6, var8, var3);
    } else {
      var4 = var1;
    }
  } else if(isbuiltinfunction(var1)) {
    if(istrue(var2)) {
      return var1;
    } else {
      var4 = [[var1]](var0);
    }
  }

  return var4;
}

function process_module_params(var0, var1) {
  var2 = [];

  if(var1.size < 2) {
    return var2;
  } else {
    var3 = spawnStruct();
    var3.var_params = [];
    var4 = min(var1.size, 9);

    for(var5 = 1; var5 < var4; var5++) {
      var6 = var1[var5];
      thread send_notify_after_frame_end(var3);
      var3.var_params[var5 - 1] = process_module_var(var3, var0, var6, 1);
    }
  }

  return var3;
}

function send_notify_after_frame_end(var0) {
  self endon("death");
  waittillframeend();
  self notify(var0);
}

function run_modular_spawning_func(var0, var1, var2) {
  if(isDefined(var2)) {
    var3 = var2;
  } else {
    var3 = self;
  }

  if(!isDefined(var2.var_params)) {
    return var3[[var1]](self);
  }

  if(var2.var_params.size == 1) {
    return var3[[var1]](self, return_undefined_param_if_empty(var2.var_params[0]));
  }

  if(var2.var_params.size == 2) {
    return var3[[var1]](self, return_undefined_param_if_empty(var2.var_params[0]), return_undefined_param_if_empty(var2.var_params[1]));
  }

  if(var2.var_params.size == 3) {
    return var3[[var1]](self, return_undefined_param_if_empty(var2.var_params[0]), return_undefined_param_if_empty(var2.var_params[1]), return_undefined_param_if_empty(var2.var_params[2]));
  }

  if(var2.var_params.size == 4) {
    return var3[[var1]](self, return_undefined_param_if_empty(var2.var_params[0]), return_undefined_param_if_empty(var2.var_params[1]), return_undefined_param_if_empty(var2.var_params[2]), return_undefined_param_if_empty(var2.var_params[3]));
  }

  if(var2.var_params.size == 5) {
    return var3[[var1]](self, return_undefined_param_if_empty(var2.var_params[0]), return_undefined_param_if_empty(var2.var_params[1]), return_undefined_param_if_empty(var2.var_params[2]), return_undefined_param_if_empty(var2.var_params[3]), return_undefined_param_if_empty(var2.var_params[4]));
  }

  if(var2.var_params.size == 6) {
    return var3[[var1]](self, return_undefined_param_if_empty(var2.var_params[0]), return_undefined_param_if_empty(var2.var_params[1]), return_undefined_param_if_empty(var2.var_params[2]), return_undefined_param_if_empty(var2.var_params[3]), return_undefined_param_if_empty(var2.var_params[4]), return_undefined_param_if_empty(var2.var_params[5]));
  }

  if(var2.var_params.size == 7) {
    return var3[[var1]](self, return_undefined_param_if_empty(var2.var_params[0]), return_undefined_param_if_empty(var2.var_params[1]), return_undefined_param_if_empty(var2.var_params[2]), return_undefined_param_if_empty(var2.var_params[3]), return_undefined_param_if_empty(var2.var_params[4]), return_undefined_param_if_empty(var2.var_params[5]), return_undefined_param_if_empty(var2.var_params[6]));
  }

  if(var2.var_params.size == 8) {
    return var3[[var1]](self, return_undefined_param_if_empty(var2.var_params[0]), return_undefined_param_if_empty(var2.var_params[1]), return_undefined_param_if_empty(var2.var_params[2]), return_undefined_param_if_empty(var2.var_params[3]), return_undefined_param_if_empty(var2.var_params[4]), return_undefined_param_if_empty(var2.var_params[5]), return_undefined_param_if_empty(var2.var_params[6]), return_undefined_param_if_empty(var2.var_params[7]));
  }

  return undefined;
}

function return_undefined_param_if_empty(var0) {
  if(isDefined(var0)) {
    if(isstring(var0) && var0 == "empty") {
      return undefined;
    }

    return var0;
  }

  return undefined;
}

function resetgroupvariables() {
  level endon("game_ended");
  self waittill("death");
  self.currentmodulekills = 0;
  level.requested_spawns_groups[self.moduleid] = undefined;
}

function spawn_ai(var0, var1, var2, var3) {
  if(isDefined(var3)) {
    change_module_status(var3, undefined, "attempt spawn_ai");
  }

  var4 = self.origin;
  var5 = self.angles;

  if(isDefined(var0)) {
    var4 = var0;
  }

  if(isDefined(var1)) {
    var5 = (0, var1[1], 0);
  }

  var6 = undefined;
  var7 = undefined;

  if(isDefined(var3) && isDefined(var3.spawn_aitype_counts) && var3.spawn_aitype_counts.size > 0 && !isDefined(self.vehicle)) {
    var6 = choose_and_decrement_from_aitype_list(var3);
    var7 = level.aitypes[var6].agent_type;
  } else if(isDefined(var3) && isDefined(var3.aitype_override) && var3.aitype_override.size && !isDefined(self.vehicle)) {
    var8 = weighted_array_randomize(var3.aitype_override, var3.aitype_override_weights);
    var7 = level.aitypes[var8].agent_type;
    var6 = var8;
  } else if(isDefined(level.aitype_override) && level.aitype_override.size && !isDefined(self.vehicle)) {
    var8 = weighted_array_randomize(level.aitype_override, level.aitype_override_weights);
    var7 = level.aitypes[var8].agent_type;
    var6 = var8;
  } else if(isDefined(var2)) {
    var7 = level.aitypes[var2].agent_type;
    var6 = var2;
  } else {
    var9 = get_aitypes_from_spawner();
    var8 = scripts\engine\utility::random(var9);
    var7 = level.aitypes[var8].agent_type;
    var6 = var8;
  }

  if(isDefined(level.playerisprop)) {
    var8 = scripts\engine\utility::random(level.playerisprop);

    if(isDefined(level.aitypes[var8]) && isDefined(level.aitypes[var8].agent_type)) {
      var7 = level.aitypes[var8].agent_type;
      var6 = var8;
    }
  }

  var10 = undefined;

  if(istrue(level.playerismatchpending) || is_armored()) {
    if(isDefined(level.aitypes[var6 + "_heavy"]) && isDefined(level.aitypes[var6 + "_heavy"].agent_type)) {
      var7 = level.aitypes[var6 + "_heavy"].agent_type;
      var6 += "_heavy";
      var10 = 1;
    }
  }

  if(!isDefined(var7)) {
    var8 = scripts\engine\utility::random(level.random_aitype_list);
    var7 = level.aitypes[var8].agent_type;
    var6 = var8;
  }

  var11 = var7;

  if(isDefined(var3)) {
    change_module_status(var3, undefined, "Chose agent_type");
  }

  if(isDefined(var3)) {
    change_module_status(var3, undefined, "In Spawn Queue");
  }

  enter_spawn_queue();
  self.aitype = var6;
  self.agent_type = var7;

  if(isDefined(var3) && istrue(var3.min_spawn_requested)) {
    var12 = undefined;
    change_module_status(var3, undefined, "Force Spawn Loop");

    for(;;) {
      var12 = scripts\mp\mp_agent::spawnnewagentaitype(var11, var4, var5);

      if(isDefined(var12)) {
        break;
      }

      waitframe();
    }

    var3.min_spawn_requested = undefined;

    if(get_reserved_slot_count_by_string_id(var3.moduleid) > 0) {
      decrease_reserved_spawn_slots(1, var3.moduleid);
    }
  } else {
    if(isDefined(var4)) {
      change_module_status(var4, undefined, "Spawn Attempt");
    }

    var12 = scripts\mp\mp_agent::spawnnewagentaitype(var12, var5, var6);
  }

  if(isDefined(var12) && istrue(var11)) {
    var12.equip_armor = 1;
  }

  return var12;
}

function triggerenterfunc(var0, var1) {
  return var0 >= var1;
}

function choose_and_decrement_from_aitype_list() {
  var0 = getarraykeys(self.spawn_aitype_counts);

  foreach(var2 in var0) {
    if(isDefined(self.spawn_aitype_counts[var2]) && isint(self.spawn_aitype_counts[var2]) && triggerenterfunc(self.spawn_aitype_counts[var2], 1)) {
      for(var3 = 0; var3 < level.spawn_module_structs_memory[self.group_name].size; var3++) {
        var4 = level.spawn_module_structs_memory[self.group_name][var3];

        if(isDefined(var4.spawn_aitype_counts[var2])) {
          var4.spawn_aitype_counts[var2]--;

          if(var4.spawn_aitype_counts[var2] <= 0) {
            var4.spawn_aitype_counts[var2] = undefined;
          }
        }
      }

      var5 = level.aitypes[var2].agent_type;
      var6 = var2;
      return var6;
    }
  }

  var4 = undefined;
  var6 = undefined;
  return undefined;
}

function weighted_array_randomize(var0, var1) {
  var2 = 0;

  for(var3 = 0; var3 < var1.size; var3++) {
    var2 += var1[var3];
  }

  var4 = randomfloat(var2);
  var5 = 0;

  for(var3 = 0; var3 < var0.size; var3++) {
    var5 += var1[var3];

    if(var5 >= var4) {
      return var0[var3];
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
    var0 = 1024;
  } else {
    var0 = self.goalradius;
  }

  set_goal_radius(64);
  var1 = 64;
  var2 = 256;
  var3 = undefined;
  var4 = undefined;
  jumpiffalse(isDefined(self.script_goalheight)) LOC_00000065;
  var2 = int(self.script_goalheight);

  for(;;) {
    if(isDefined(self.script_origin_other)) {
      var5 = self.script_origin_other;
    } else {
      var5 = self.origin;
    }

    if(istrue(self.find_new_patrol)) {
      wait 0.25;
      continue;
    }

    var6 = -1;
    var4 = undefined;
    var7 = undefined;
    var8 = getnodesinradiussorted(var5, var0, var1, var2, "all");
    var9 = [];

    if(isDefined(var8) && var8.size > 0) {
      for(var10 = 0; var10 < var8.size; var10++) {
        if(isDefined(var3) && var8[var10] == var3) {
          continue;
        }

        if(isDefined(showcinematicletterboxing(var8[var10]))) {
          continue;
        }

        if(isDefined(self.dot_override)) {
          var11 = self.angles + (0, self.dot_override, 0);
        } else {
          var11 = self.angles;
        }

        var12 = scripts\engine\math::get_dot(self.origin, var11, var8[var10].origin);

        if(var12 < 0.3) {
          if(var12 > var6) {
            var4 = var8[var10];
            var6 = var12;
          }

          continue;
        }

        var9 = var8[var10];
      }
    }

    if(var9.size > 0) {
      var7 = get_least_used_from_array(var9);
    }

    var13 = gettime();

    if(isDefined(var7)) {
      self.dot_override = undefined;
      var3 = var7;
      go_to_node(var7);
      var14 = gettime();

      if(var14 <= var13) {
        waitframe();
      }

      continue;
    }

    if(isDefined(var4)) {
      self.dot_override = undefined;
      var3 = var4;
      go_to_node(var4);
      var14 = gettime();

      if(var14 <= var13) {
        waitframe();
      }

      continue;
    }

    wait 1;
  }
}

function enter_combat_after_stealth(var0) {
  if(scripts\cp\coop_stealth::ref_132d7()) {
    return;
  }

  self notify("enter_combat_after_stealth");
  self endon("enter_combat_after_stealth");
  self endon("death");
  self endon("enter_combat");
  var1 = [];
  var2 = [];
  var3 = undefined;

  if(isDefined(self.team)) {
    if(isDefined(self.group) && self.group scripts\engine\utility::ent_flag_exist("weapons_free") && !self.group scripts\engine\utility::ent_flag("weapons_free")) {
      if(self.team == "allies") {
        var2 = [self, level];
        scripts\engine\utility::waittill_any_ents_array(var2, "damage", "stealth_combat", "stealth_over", "weapons_free", "bulletwhizby");
      } else if(istrue(self.aggressive)) {
        return;
      } else if(is_pacifist()) {
        var2 = [self, self.group, level];
        scripts\engine\utility::waittill_any_ents_array(var2, "weapons_free", "saw_death");
      } else {
        var2 = [self, self.group, level];
        var3 = scripts\engine\utility::waittill_any_ents_return(level, "weapons_free", self.group, "weapons_free", self, "saw_death", self, "known_event");
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

function set_default_values(var0, var1, var2, var3) {
  self endon("death");

  if(!is_specified_unittype("civilian") && (is_pacifist() || is_patroller())) {
    thread watch_for_ai_events();
  }

  if(isDefined(var0) && isDefined(var0.groupname)) {
    self.groupname = var0.groupname;
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
  self.spawnpoint = var1;
  self.qsetgoalpos = 1;
  self.spawn_parameter_array = var2;

  if(istrue(self.equip_helmet) || is_juggernaut_aitype()) {
    give_soldier_helmet();
  }

  if(is_armored() || is_juggernaut_aitype()) {
    give_soldier_armor();
  }

  stoppingpower_getweaponhcrdata();
}

function ref_12ddc(var0, var1, var2, var3) {
  self endon("death");
  thread watch_for_bad_path();

  if(isDefined(var3)) {
    join_module_group(var3, self);
  }

  if(isDefined(level.global_ai_func_array) && level.global_ai_func_array.size > 0) {
    if(isDefined(self.team) && self.team == "axis") {
      var4 = self.team;

      for(var5 = 0; var5 < level.global_ai_func_array[var4].size; var5++) {
        var6 = level.global_ai_func_array[var4][var5];

        if(isDefined(var6["param4"])) {
          self thread[[var6["function"]]](var6["param1"], var6["param2"], var6["param3"], var6["param4"]);
          continue;
        }

        if(isDefined(var6["param3"])) {
          self thread[[var6["function"]]](var6["param1"], var6["param2"], var6["param3"]);
          continue;
        }

        if(isDefined(var6["param2"])) {
          self thread[[var6["function"]]](var6["param1"], var6["param2"]);
          continue;
        }

        if(isDefined(var6["param1"])) {
          self thread[[var6["function"]]](var6["param1"]);
          continue;
        }

        self thread[[var6["function"]]]();
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

function set_kill_off_time(var0) {
  if(isDefined(var0)) {
    var1 = var0 * 1000;
  } else if(isDefined(self.group) && isDefined(self.group.kill_off_time_override)) {
    var1 = self.group.kill_off_time_override * 1000;
  } else if(isDefined(self.spawnpoint) && isDefined(self.spawnpoint.script_timer)) {
    var1 = self.spawnpoint.script_timer * 1000;
  } else if(isDefined(self.group) && istrue(self.group.cqb_module)) {
    var1 = 2500000;
  } else {
    var1 = 20000;
  }

  var2 = gettime() + var1;

  if(!isDefined(self.killofftime) || var2 > self.killofftime) {
    self.killofftime = var2;
  }

  if(istrue(self.entered_combat)) {
    var3 = var1 / 1000;
    thread add_to_kill_off_list(var3);
    return;
  }

  remove_from_kill_off_list();
}

function add_to_kill_off_list(var0) {
  self notify("add_to_kill_off_list");
  self endon("add_to_kill_off_list");
  self endon("death");
  remove_from_kill_off_list();
  wait var0;

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
  var0 = level.frameduration / 1000;

  for(;;) {
    var1 = 1;
    var2 = getarraykeys(level.can_kill_off_list);

    for(var3 = 0; var3 < var2.size; var3++) {
      if(!isDefined(level.can_kill_off_list[var2[var3]])) {
        continue;
      }

      var4 = thread passive_kill_off_ai();

      if(!isDefined(var4) || var4) {
        if(var1 > var0) {
          var1 -= var0;
        }

        waitframe();
      }
    }

    wait var1;
  }
}

function passive_kill_off_ai(var0) {
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

  var1 = get_see_recently_time_overrides();

  if(isDefined(self.group) && istrue(self.group.cqb_module)) {
    var2 = 2250000;
  } else {
    var2 = 25000000;
  }

  for(var3 = 0; var3 < level.players.size; var3++) {
    var4 = level.players[var3];

    if(distancesquared(var4.origin, self.origin) < var2) {
      return false;
    }

    if(self seerecently(var4, var2)) {
      return false;
    }
  }

  if(!vo_nag_hangar()) {
    if(!istrue(var1)) {
      return true;
    }
  }

  teleport_to_nearby_spawner("Passive Kill-Off", undefined, 0);
  return true;
}

function vo_nag_hangar() {
  for(var0 = 0; var0 < level.players.size; var0++) {
    var1 = level.players[var0];

    if(self hastacvis(var1, 0, 64, 1)) {
      return false;
    }

    if(var1 hastacvis(self, 0, 64, 1)) {
      return false;
    }
  }

  var2 = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 1);
  var3 = self getapproxeyepos();

  for(var0 = 0; var0 < level.players.size; var0++) {
    var4 = level.players[var0];

    if(scripts\engine\trace::ray_trace_passed(var4 getEye(), var3, [var4, self], var2)) {
      return false;
    }
  }

  return true;
}

function is_riding_vehicle() {
  return isDefined(self.ridingvehicle);
}

function is_specified_unittype(var0) {
  return isDefined(self.unittype) && self.unittype == var0;
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

function suicide_bomber_combat_func(var0) {
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
  var0 = self.origin;

  while(distance(var0, self.origin) < 750) {
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

function assign_soldier_spec(var0, var1) {
  if(isDefined(var0) && isDefined(level.soldier_agent_specialize_func)) {
    if(isDefined(level.soldier_agent_specialize_func[var0])) {
      var1[[level.soldier_agent_specialize_func[var0]]]();

      if(isDefined(var1.spec)) {
        level.spawned_enemy_types[var1.spec]++;
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

function run_spawner_post_spawn_actions(var0) {
  if(isDefined(var0) && isDefined(self.post_spawn_spawner_funcs)) {
    foreach(var2 in self.post_spawn_spawner_funcs) {
      self[[var2]](var0);
    }

    return;
  }
}

function run_ai_post_spawn_actions() {
  if(isDefined(self.spawnpoint.post_spawn_ai_funcs)) {
    foreach(var1 in self.spawnpoint.post_spawn_ai_funcs) {
      self[[var1]]();
    }

    return;
  }
}

function join_module_group(var0, var1) {
  var1.enemy_group = var0.group_name;
  var1.moduleid = var0.moduleid;
  var1.group = var0;
  var1.group.activecount++;
  var1.group.spawn_count++;
  var0.ai_spawned[var0.ai_spawned.size] = var1;
  var0 thread scripts\cp\utility::add_to_notify_queue("spawned_group_soldier", var1);

  if(isDefined(var0.threatbiasoverride)) {
    var1.threatbiasoverride = var0.threatbiasoverride;
  }

  if(isDefined(var0.ai_spawn_func)) {
    for(var2 = 0; var2 < var0.ai_spawn_func.size; var2++) {
      thread process_module_var(var1, var0, var0.ai_spawn_func[var2], undefined);
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
    var0 = scripts\engine\utility::getStructArray(self.script_parent, "targetname");

    if(var0.size > 0) {
      self.child_spawners = [];
      self.child_spawners = var0;
      init_cluster_parent();
      scripts\engine\utility::array_thread(var0, &spawner_init);
      return;
    }

    return;
  }

  var1 = 2;
  var2 = 64;
  var3 = 128;
  var4 = 256;

  if(!isnode(self) && isDefined(self.spawnflags)) {
    if(!isint(self.spawnflags)) {
      self.spawnflags = int(self.spawnflags);
    }

    if(self.spawnflags &var1) {
      self.equip_armor = 1;
    }

    if(self.spawnflags &var2) {
      add_to_spawner_flags(512);
      self.is_on_platform = 1;
    }

    if(!istrue(scripts\cp\cp_vehicles::is_vehicle_spawnpoint())) {
      var5 = 8;

      if(self.spawnflags &var5) {
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
  var0 = "^0";
  var1 = "^1";
  var2 = "^2";
  var3 = "^3";
  var4 = "^4";
  var5 = "^5";
  var6 = "^6";
  var7 = "^7";
  var8 = "^8";
  var9 = "^9";
  var10 = var1 + "SPAWNER DISABLED: ";

  if(isDefined(self.targetname)) {
    var11 = var0 + "targetname = (" + self.targetname + ")";
  } else {
    var11 = "";
  }

  var12 = scripts\engine\utility::ter_op(isstruct(self), var1 + "(struct) " + var11 + var4 + "spawner", var1 + "(node)" + var11 + var4 + " spawner");

  if(isDefined(self.script_difficulty) && level.gameskill <= 1 && scripts\engine\utility::is_equal(self.script_difficulty, "hard")) {
    little_bird_mg_givetakegunnerturrettimeout();
    return false;
  }

  var13 = scripts\cp\cp_vehicles::is_vehicle_spawnpoint();

  if(!spawner_flags_check(4)) {
    if(isDefined(self.origin)) {
      var14 = getgroundposition(self.origin, 1, 100, 16);

      if(var13) {
        if(!isDefined(self.ref_133bb) && !ispointonnavmesh(var14)) {
          little_bird_mg_givetakegunnerturrettimeout();
          return false;
        } else {
          return true;
        }
      } else {
        var14 = self.origin;
      }

      var15 = getclosestpointonnavmesh(var14);

      if(distance2dsquared(var15, self.origin) <= 4096) {
        if(isstruct(self)) {
          var15 = scripts\engine\utility::drop_to_ground(var15, 32, -1000);
          self.origin = var15;
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
    var0 = int(self.spawnflags);
    var1 = 16;
    var2 = 8;

    if(var0 &var1) {
      define_spawner("vehicle_spawner");
    }

    if(var0 &var2) {
      define_spawner("vehicle_spawner");
    }
  }

  if(isDefined(self.script_parent)) {
    var3 = scripts\engine\utility::getStructArray(self.script_parent, "targetname");

    if(var3.size > 0) {
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
  var0 = 32;

  if(isDefined(self.spawnpoint)) {
    if(istrue(self.spawnpoint.door_spawner)) {
      return 1;
    }

    if(!isnode(self.spawnpoint) && isDefined(self.spawnpoint.spawnflags)) {
      if(self.spawnpoint.spawnflags &var0 && !(self.spawnpoint.spawnflags & 8)) {
        if(isDefined(self.spawnpoint.script_linkto)) {
          var1 = getEntArray(self.spawnpoint.script_linkto, "script_linkname");

          if(!isDefined(var1) || var1.size < 1) {
            var1 = scripts\engine\utility::getStructArray(self.spawnpoint.script_linkto, "script_linkname");
          }

          if(isDefined(var1) && var1.size > 0) {
            for(var2 = 0; var2 < var1.size; var2++) {
              var3 = var1[var2];

              if(isDefined(var3.targetname) && var3.targetname == "ai_spawn_doors") {
                if(!isDefined(self.spawnpoint.doors)) {
                  self.spawnpoint.doors = [var3];
                } else {
                  self.spawnpoint.doors[self.spawnpoint.doors.size] = var3;
                }

                continue;
              }

              if(isDefined(var1[0].script_noteworthy) && var1[0].script_noteworthy == "spawn_door_single") {
                if(!isDefined(self.spawnpoint.doors)) {
                  self.spawnpoint.doors = [var3];
                  continue;
                }

                self.spawnpoint.doors[self.spawnpoint.doors.size] = var3;
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
      var1 = getEntArray(self.spawnpoint.script_linkto, "script_linkname");

      if(!isDefined(var1) || var1.size < 1) {
        var1 = scripts\engine\utility::getStructArray(self.spawnpoint.script_linkto, "script_linkname");
      }

      if(isDefined(var1) && var1.size > 0) {
        for(var2 = 0; var2 < var1.size; var2++) {
          var3 = var1[var2];

          if(isDefined(var3.targetname) && var3.targetname == "ai_spawn_doors") {
            if(!isDefined(self.spawnpoint.doors)) {
              self.spawnpoint.doors = [var3];
            } else {
              self.spawnpoint.doors[self.spawnpoint.doors.size] = var3;
            }

            continue;
          }

          if(isDefined(var1[0].script_noteworthy) && var1[0].script_noteworthy == "spawn_door_single") {
            if(!isDefined(self.spawnpoint.doors)) {
              self.spawnpoint.doors = [var3];
              continue;
            }

            self.spawnpoint.doors[self.spawnpoint.doors.size] = var3;
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

function update_script_demeanor_for_all_spawners_in_group(var0) {
  var1 = process_module_var(self, self.spawn_points);

  for(var2 = 0; var2 < var1.size; var2++) {
    if(isstruct(var1[var2])) {
      var1[var2].script_demeanor = var0;
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

function parent_spawner_disable_after_count(var0, var1) {
  var0 endon("death");
  self notify("parent_spawner_disable_after_count");
  self endon("parent_spawner_disable_after_count");
  var1 endon("spawn_failed");
  var1 waittill("spawn_success");

  if(isDefined(self.script_count)) {
    self.script_count--;

    if(self.script_count < 1) {
      thread disable_spawn_point(self, self.script_timeout, var0);
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

function spawner_disable_after_count(var0) {
  if(isDefined(self.script_count)) {
    self.script_count--;

    if(self.script_count < 1) {
      thread disable_spawn_point(self, self.script_timeout, var0);
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
    level waittill("disable_nearby_spawners_for_time", var0);

    if(distance2dsquared(self.origin, var0) <= 65536) {
      set_default_spawner_values();
    }
  }
}

function init_score_data(var0) {}

function get_ideal_dist(var0) {
  if(!isDefined(var0.script_noteworthy)) {
    return 1250;
  }

  if(istrue(var0 scripts\cp\cp_vehicles::is_vehicle_spawnpoint())) {
    return 5000;
  }

  switch (var0.script_noteworthy) {
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

function enemy_monitor(var0, var1) {
  level endon("game_ended");
  update_spawn_data_on_spawn(var0, var1);

  if(getdvarint("scr_dmg_enemies_water", 0) != 0) {
    thread kill_agent_when_in_water();
    return;
  }
}

function kill_agent_when_in_water() {
  self endon("death");

  for(;;) {
    var0 = scripts\engine\trace::_bullet_trace(self.origin + (0, 0, 10), self.origin + (0, 0, -10), 0, self);
    self.hit_water = var0["surfacetype"] == "surftype_water";

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

function update_spawn_data_on_spawn(var0, var1) {
  var2 = 1;

  if(isDefined(self.team)) {
    if(self.team == "axis") {
      level.spawned_enemies[level.spawned_enemies.size] = self;
      level.current_num_spawned_enemies += var2;
    } else if(self.team == "allies") {
      level.spawned_allies[level.spawned_allies.size] = self;
    }
  }

  level.spawned_ai[level.spawned_ai.size] = self;

  if(isDefined(var0)) {
    if(var0 == "juggernaut") {
      level.spawned_juggernauts[level.spawned_juggernauts.size] = self;
      level.current_num_spawned_juggernauts += var2;
    }

    if(var0 == "soldier_agent" || var0 == "soldier") {
      level.spawned_soldiers[level.spawned_soldiers.size] = self;
      level.current_num_spawned_soldiers += var2;
      return;
    }

    return;
  }
}

function _update_spawn_data_on_death(var0, var1) {
  level endon("game_ended");
  self endon("update_spawn_data_on_death");
  self waittill("death");
  thread update_spawn_data_on_death(var0, var1);
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

function update_spawn_data_on_death(var0, var1) {
  self notify("update_spawn_data_on_death");
  self endon("update_spawn_data_on_death");
  level endon("game_ended");
  thread remove_from_kill_off_list();

  if(!isDefined(self.group)) {
    level notify("no group defined");
  }

  var2 = 1;

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
        level.current_num_spawned_enemies -= var2;
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
    var3 = is_my_group_an_active_module();

    if(get_activecount_from_group(self.group) - var2 >= 1) {
      self.group.activecount = int(clamp(self.group.activecount - var2, 0, self.group.activecount - var2));
    } else {
      self.group.activecount = 0;
    }

    self.group.ai_spawned = scripts\engine\utility::array_remove(self.group.ai_spawned, self);

    if(var3) {
      if(!istrue(self.died_poorly)) {
        self.group.currentmodulekills += var2;
      }
    } else {
      self.group.currentmodulekills += var2;
    }

    var4 = process_module_var(self.group, self.group.totalspawns);

    if(isDefined(var4) && var4 > 0) {
      if(var3 && self.group.currentmodulekills >= var4) {
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
      } else if(!var3 && get_activecount_from_group(self.group, 1) < 1) {
        scripts\cp\cp_spawning_util::ref_12bd3(self.group);
        self.group notify("all_group_spawns_dead");

        if(scripts\engine\utility::array_contains(level.spawn_module_structs_memory[self.group.group_name], self.group)) {
          level.spawn_module_structs_memory[self.group.group_name] = scripts\engine\utility::array_remove(level.spawn_module_structs_memory[self.group.group_name], self.group);

          if(isDefined(level.spawn_module_structs_memory[self.group.group_name]) && level.spawn_module_structs_memory[self.group.group_name].size < 1) {
            level.spawn_module_structs_memory[self.group.group_name] = undefined;
          }
        }
      } else if(var3 && get_activecount_from_group(self.group, 1) < 1) {
        self.group notify("active_all_group_spawns_dead");
      }
    } else if(!var3 && get_activecount_from_group(self.group, 1) < 1) {
      scripts\cp\cp_spawning_util::ref_12bd3(self.group);
      self.group notify("all_group_spawns_dead");

      if(scripts\engine\utility::array_contains(level.spawn_module_structs_memory[self.group.group_name], self.group)) {
        level.spawn_module_structs_memory[self.group.group_name] = scripts\engine\utility::array_remove(level.spawn_module_structs_memory[self.group.group_name], self.group);

        if(isDefined(level.spawn_module_structs_memory[self.group.group_name]) && level.spawn_module_structs_memory[self.group.group_name].size < 1) {
          level.spawn_module_structs_memory[self.group.group_name] = undefined;
        }
      }
    } else if(var3 && get_activecount_from_group(self.group, 1) < 1) {
      self.group notify("active_all_group_spawns_dead");
    }

    if(!istrue(self.died_poorly)) {
      thread run_group_death_funcs();
    } else {
      thread ref_12ddd();
    }

    if(scripts\cp\cp_spawning_util::group_has_combined_counters(self.group.group_name)) {
      var5 = self.group scripts\cp\cp_spawning_util::propwatchdeath();

      if(isDefined(var5)) {
        var6 = level.hideallunselectedextractpads[var5];

        if(isDefined(var6) && var6.size > 0) {
          for(var7 = 0; var7 < var6.size; var7++) {
            thread send_notify_to_groups_from_groupname(level, var6[var7].group_name, "activeCount_changed");
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
      level.current_num_spawned_juggernauts -= var2;
    }

    if(self.unittype == "soldier") {
      level.spawned_soldiers = scripts\engine\utility::array_remove(level.spawned_soldiers, self);
      level.current_num_spawned_soldiers -= var2;
      return;
    }

    return;
  }
}

function toggle_force_stop_wave_from_groupname(var0, var1, var2) {
  if(isDefined(level.spawn_module_structs_memory[var0])) {
    for(var3 = 0; var3 < level.spawn_module_structs_memory[var0].size; var3++) {
      level.spawn_module_structs_memory[var0][var3].stop_wave_spawning = var1;

      if(!istrue(var1)) {
        level.spawn_module_structs_memory[var0][var3] notify("wave_spawn");
      }

      if(isDefined(var2)) {
        change_module_status(level.spawn_module_structs_memory[var0][var3], undefined, var2);
      }
    }

    return;
  }
}

function get_spawn_count_from_groupname(var0) {
  var1 = 0;

  if(isDefined(level.spawn_module_structs_memory[var0])) {
    for(var2 = 0; var2 < level.spawn_module_structs_memory[var0].size; var2++) {
      if(isDefined(level.spawn_module_structs_memory[var0][var2].spawn_count)) {
        var1 += level.spawn_module_structs_memory[var0][var2].spawn_count;
      }
    }
  }

  return var1;
}

function barkov_crawl_scene_nostab(var0) {
  var0.spawn_count++;
}

function ref_1393e(var0) {
  var0.spawn_count--;
}

function reset_spawn_count_from_groupname(var0) {
  if(isDefined(level.spawn_module_structs_memory[var0])) {
    for(var1 = 0; var1 < level.spawn_module_structs_memory[var0].size; var1++) {
      if(isDefined(level.spawn_module_structs_memory[var0][var1].spawn_count)) {
        level.spawn_module_structs_memory[var0][var1].spawn_count = 0;
      }
    }

    return;
  }
}

function send_notify_to_groups_from_groupname(var0, var1, var2, var3) {
  if(isDefined(level.spawn_module_structs_memory[var0])) {
    for(var4 = 0; var4 < level.spawn_module_structs_memory[var0].size; var4++) {
      var5 = level.spawn_module_structs_memory[var0][var4];
      var5 thread scripts\cp\utility::add_to_notify_queue(var1, var2);
    }

    return;
  }
}

function get_activecount_from_group(var0) {
  if(istrue(self.ref_133be)) {
    return self.ref_11cb0;
  }

  var1 = 0;

  if(!istrue(var0) && isDefined(self.hide_rocket_fuel_readings_to_player)) {
    var2 = level.hideallunselectedextractpads[self.hide_rocket_fuel_readings_to_player];

    for(var3 = 0; var3 < var2.size; var3++) {
      var4 = var2[var3];

      if(isDefined(var4.activecount)) {
        var1 += var4.activecount;
      }
    }
  } else if(isDefined(self.activecount)) {
    var1 = self.activecount;
  }

  return var1;
}

function set_wave_settings_for_all_with_groupname(var0, var1, var2, var3) {
  if(isDefined(level.active_spawn_module_structs[var0])) {
    for(var4 = 0; var4 < level.active_spawn_module_structs[var0].size; var4++) {
      var5 = level.active_spawn_module_structs[var0][var4];
      var5.wave_reference = var1;
      var5.last_wave_ref = var2;
      var5.last_wave_num = var3;
    }

    return;
  }
}

function toggle_teleport_enemy_info_loop(var0) {
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

function pre_wave_weapons_free(var0) {
  level notify("spawn_module_" + var0.moduleid + "_completed");
}

function set_pre_wave_spawning_spawn_funcs(var0) {
  if(getdvarint("scr_pre_wave_use_patrol_structs", 1)) {
    var1 = scripts\engine\utility::getStructArray("dwn_twn_patrol_structs", "targetname");
    var2 = scripts\engine\utility::getclosest(self.origin, var1);

    if(isDefined(var2) && isDefined(var2.script_linkname)) {
      self.script_linkto = var2.script_linkname;
    }
  } else {
    thread set_script_origin_other_to_center_of_players();
  }

  var3 = self;
  var3.sightmaxdistance = 2200;
  var3.pacifist_override = 1;
  var3 thread scripts\cp\coop_stealth::run_common_functions(var3, 1, 1, 60, 250000);
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

function toggle_kamikaze_for_group(var0, var1) {
  var0.kamikaze = var1;
}

function numfound() {
  if(!isDefined(self.group)) {
    var0 = ["frag_grenade_mp", "molotov_mp", "semtex_mp", "flash_grenade_mp", "concussion_grenade_mp", "smoke_grenade_mp", "gas_mp"];
    var1 = [0.5, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1];
  } else {
    var0 = self.group.set_chosen_spawner_from_uid;
    var1 = self.group.serverroomrewardroll;
  }

  var2 = scripts\engine\utility::array_sum(var1);
  var3 = randomfloatrange(0, var2);
  var4 = 0;

  for(var5 = 0; var5 < var0.size; var5++) {
    var4 += var1[var5];

    if(var4 >= var3) {
      self.grenadeweapon = getcompleteweaponname(var0[var5]);
      self.grenadeammo = 2;
      return;
    }
  }
}

function propwaitminigamehudinit(var0) {
  if(isDefined(var0) && isDefined(var0.set_chosen_spawner_from_uid)) {
    return;
  }
}

function select_patrol_nine_spawners(var0) {
  ref_12bf1();
  thread circleorigin(var0);
}

function calloutmarkerpingvohandlerpool(var0) {
  give_soldier_armor();
  thread circleorigin(var0);
}

function circleorigin(var0) {
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
  var1 = randomintrange(10, 20);
  wait var1;

  while(istrue(self.playing_skit)) {
    wait 1;
  }

  set_goal_radius(1536);
  var1 = randomintrange(10, 20);
  wait var1;

  while(istrue(self.playing_skit)) {
    wait 1;
  }

  if(!scripts\cp\utility::turn_off_sniper_laser()) {
    self.aggressivemode = 1;
  }

  self.ignoresuppression = 1;
  set_goal_radius(1024);
  var1 = randomintrange(10, 20);
  wait var1;

  while(istrue(self.playing_skit)) {
    wait 1;
  }

  set_goal_radius(512);
}

function wave_go_kamikaze(var0) {
  level endon("game_ended");

  if(isDefined(var0)) {
    var0 notify("wave_go_kamikaze");
    var0 endon("wave_go_kamikaze");
    var0 endon("death");

    if(isDefined(var0.timeout_after_min_count) && var0.timeout_after_min_count > 0) {
      scripts\cp\cp_wave_spawning::ref_13f81(0, var0);
      thread timeout_wave(var0);
    }
  }

  wait 1.5;
  level notify("wave_ending");
}

function ref_1451f(var0) {
  level endon("game_ended");
  level endon("timeout_wave");
  level notify("wave_failsafe_end");
  level endon("wave_failsafe_end");

  if(!scripts\cp\utility::turn_off_sniper_laser()) {
    return;
  }

  var1 = 0;
  var2 = 45;
  var3 = int(var2 / 2);

  for(;;) {
    var4 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

    if(var4.size == 0) {
      var1++;
    }

    if(var1 >= var2) {
      break;
    }

    wait 1;
  }

  scripts\cp\cp_wave_spawning::ref_13f81(0, var0);
  thread timeout_wave(var0);
}

function timeout_wave(var0) {
  level endon("game_ended");
  level notify("timeout_wave");
  level endon("timeout_wave");
  self endon("death");
  setomnvar("cp_countdown_color", 0);

  if(getdvarint("scr_wave_time_set", -1) != -1) {
    var0 = getdvarint("scr_wave_time_set", -1);
  }

  if(isDefined(level.ref_14529) && level.ref_14529 > 10) {
    var0 = level.ref_14529;
  }

  notify_all_groups_in_module(self.group_name, "threshold_timeout");
  toggle_force_stop_wave_from_groupname(self.group_name, 1, "wave_delay");
  toggle_force_stop_wave_from_groupname("wave_paratroopers", 1, "wave_delay");
  wave_cooldown_time(var0);
  scripts\cp\cp_wave_spawning::ref_13f81(0, self);

  if(!istrue(self.disable_wave_hud)) {
    wait 0.1;

    for(var1 = 0; var1 < level.players.size; var1++) {
      level.players[var1] thread scripts\cp\vehicles\vehicle_compass_cp::ref_12003();
      level.players[var1] thread scripts\cp\cp_hud_message::showsplash("cp_wave_ended", level.logfriendlyfire, undefined);

      if(level.logfriendlyfire >= 20) {
        thread playerhudupdatenumconsumed();
      }
    }
  }

  if(scripts\cp\utility::turn_off_sniper_laser()) {
    thread ref_14521();

    if(var0 > 10.1) {
      wait var0 - 10;

      for(var1 = 0; var1 < 10; var1++) {
        setomnvar("cp_countdown_color", 2);
        wait 1;
      }
    } else {
      wait var0;
    }
  } else {
    wait var0;
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

function notify_all_groups_in_module(var0, var1) {
  if(isDefined(level.spawn_module_structs_memory[var0])) {
    for(var2 = 0; var2 < level.spawn_module_structs_memory[var0].size; var2++) {
      level.spawn_module_structs_memory[var0][var2] notify(var1);
    }

    return;
  }
}

function group_wait_for_activecount_notify(var0) {
  self endon("death");
  self endon("threshold_timeout");

  for(;;) {
    self waittill("activeCount_changed", var1);

    if(getdvarfloat("scr_wave_threshold_timeout", 0) != 0) {
      GscBinSkip4(0x35, getdvarfloat("scr_wave_threshold_timeout"));
    }

    if(var1 <= var0) {
      self notify("start_threshold_timeout");
      break;
    }
  }
}

function start_threshold_timeout(var0) {
  self notify("start_threshold_timeout");
  self endon("start_threshold_timeout");
  wait var0;
  self notify("threshold_timeout");
}

function run_group_death_funcs() {
  if(isDefined(self.group) && isDefined(self.group.ai_death_func)) {
    for(var0 = 0; var0 < self.group.ai_death_func.size; var0++) {
      self thread[[self.group.ai_death_func[var0]]]();
    }

    return;
  }
}

function is_my_group_an_active_module() {
  var0 = getarraykeys(level.active_spawn_module_structs);

  for(var1 = 0; var1 < var0.size; var1++) {
    var2 = level.active_spawn_module_structs[var0[var1]];

    if(isarray(var2)) {
      for(var3 = 0; var3 < var2.size; var3++) {
        if(var2[var3] == self.group) {
          return true;
        }
      }

      continue;
    }

    if(var2 == self.group) {
      return true;
    }
  }

  return false;
}

function get_total_reserved_slot_count() {
  var0 = 0;

  foreach(var2 in level.reserved_spawn_slots) {
    var0 += var2;
  }

  return var0;
}

function get_reserved_slot_count_by_string_id(var0) {
  if(isDefined(var0) && isDefined(level.reserved_spawn_slots[var0])) {
    return level.reserved_spawn_slots[var0];
  }

  return 0;
}

function increase_reserved_spawn_slots(var0, var1, var2) {
  if(isDefined(var1)) {
    if(!isDefined(level.reserved_spawn_slots[var1])) {
      level.reserved_spawn_slots[var1] = 0;
    }
  } else {
    var1 = "default";
  }

  level.reserved_spawn_slots[var1] += var0;
  allowed_to_spawn_agent(var2, 1, level.reserved_spawn_slots[var1], var1);
}

function decrease_reserved_spawn_slots(var0, var1) {
  if(isDefined(var1)) {
    if(isDefined(level.reserved_spawn_slots[var1])) {
      var2 = level.reserved_spawn_slots[var1];
      level.reserved_spawn_slots[var1] = int(clamp(var2 - var0, 0, var2 - var0));

      if(level.reserved_spawn_slots[var1] < 1) {
        level.reserved_spawn_slots[var1] = undefined;
        return;
      }

      return;
    }

    return;
  }

  var1 = "default";

  if(isDefined(level.reserved_spawn_slots[var1])) {
    var2 = level.reserved_spawn_slots[var1];
    level.reserved_spawn_slots[var1] = int(clamp(var2 - var0, 0, var2 - var0));

    if(level.reserved_spawn_slots[var1] < 1) {
      level.reserved_spawn_slots[var1] = undefined;
      return;
    }

    return;
  }
}

function increase_delayed_spawn_slots(var0) {
  level.delayed_spawn_slots += var0;
}

function decrease_delayed_spawn_slots(var0) {
  level.delayed_spawn_slots -= var0;
}

function fake_flashlight(var0) {
  self notify("fake_flashlight");
  self endon("fake_flashlight");
  self endon("death");

  if(getdvarint("disable_enemy_flashlight", 0) != 0) {
    return;
  }

  wait 0.25;
  var1 = "npc_flashlight";

  if(isDefined(var0)) {
    var1 = var0;
  }

  if(!isDefined(level._effect[var1])) {
    return;
  }

  var2 = [];
  GscBinSkip0(0x2e, var2.size, "tag_flash");
}

function enter_combat(var0) {
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
    var1 = randomintrange(180, 220);
    scripts\engine\utility::set_movement_speed(var1);
  }

  if(!is_specified_unittype("suicidebomber") && !is_specified_unittype("civilian")) {
    thread get_enemy_info_loop();
  }

  run_combat_func();
}

function run_combat_func(var0, var1) {
  if(isDefined(self.combat_func_override)) {
    var2 = self.combat_func_override;
  } else {
    var2 = self.aitype;
  }

  if(isDefined(var2)) {
    if(isDefined(level.aitypes[var2]) && isDefined(level.aitypes[var2].combat_func)) {
      if(isDefined(var1) && isDefined(var2)) {
        self thread[[level.aitypes[var2].combat_func]](var1, var2);
        return;
      }

      if(isDefined(var1)) {
        self thread[[level.aitypes[var2].combat_func]](var1);
        return;
      }

      self thread[[level.aitypes[var2].combat_func]]();
      return;
    }

    return;
  }
}

function get_enemy_info_loop(var0) {
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

  if(!isDefined(var0)) {
    var0 = 2;
  }

  var1 = 0;
  var2 = 1;
  var3 = projectilewaittilstucktimeout();
  var4 = &prepickupweapon;
  var5 = &progression_main;

  for(;;) {
    if(ref_132db()) {
      var1 = 0;
      self.target_enemy = undefined;
    } else {
      var7 = var3;

      if(var2) {
        var7 = undefined;
      }

      var6 = self[[var4]](var7);
      var8 = self[[var5]](var7, var6);

      if(isDefined(var8)) {
        var2 = 0;

        if(isDefined(self.script_origin_other)) {
          var9 = self.script_origin_other;
        } else {
          var9 = var9.origin;
        }

        if(scripts\cp\utility::turn_off_sniper_laser()) {
          set_goal_pos_check_for_offset(var9.origin);
        } else if(!has_dont_kill_off_flag() && z_is_excessive(var9)) {
          if(passed_kill_off_time_checks(gettime())) {
            teleport_to_nearby_spawner("Too Far From Target", var9);
          }
        } else {
          set_kill_off_time(var1);
          set_demeanor_from_unittype("combat");

          if(isDefined(self.goal_pos_override) && !isDefined(self.last_set_goalent)) {
            self.goal_pos_override = undefined;
            set_goal_radius(self.last_goalradius);
          }

          update_target_player(var9);

          if(isDefined(self.group)) {
            self.group scripts\engine\utility::ent_flag_set("weapons_free");
          }

          if(isDefined(self.script_goalvolume)) {
            self setgoalvolumeauto(self.script_goalvolume);
          } else {
            self cleargoalvolume();

            if(!istrue(self.combat_func_active)) {
              if(!istrue(self.is_on_platform) && isDefined(self.engagemaxdist)) {
                var10 = 6;

                if(self seerecently(var9, var10)) {
                  var11 = distancesquared(var9, self.origin);
                  var12 = var11 <= self.engagemaxdist * self.engagemaxdist;

                  if(istrue(var2) && var12 || isDefined(var9.vehicle_riding_on)) {
                    var2 = 0;
                    set_goal_pos_check_for_offset(self.origin);
                  } else if(!istrue(var2) && !var12) {
                    var2 = 1;
                    set_goal_pos_check_for_offset(var9.origin);
                  }
                } else {
                  var2 = 1;
                  set_goal_pos_check_for_offset(var9.origin);
                }
              } else {
                self.goal_pos_override = undefined;
                set_goal_pos_check_for_offset(self.origin);
              }
            }
          }
        }
      } else if(!istrue(self.combat_func_active)) {
        var2 = 0;
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

    wait var1;
  }
}

function projectilewaittilstucktimeout() {
  if(isDefined(self.group)) {
    if(isDefined(self.group.spawn_scoring_overrides)) {
      var0 = self.group.spawn_scoring_overrides.ref_13bdb;
    } else if(istrue(self.group.cqb_module)) {
      var0 = 2333;
    } else {
      var0 = 4096;
    }
  } else if(istrue(level.spawn_scoring_overrides)) {
    var0 = level.spawn_scoring_overrides.ref_13bdb;
  } else {
    var0 = 4096;
  }

  var0 = int(min(var0, 2500));
  return var0;
}

function ref_132db() {
  if(istrue(self.ignoreall) || istrue(self.scripted_mode)) {
    return 1;
  }

  return 0;
}

function prepdoorsforunload() {
  for(var0 = 0; var0 < level.players.size; var0++) {
    self getenemyinfo(level.players[var0]);
  }
}

function prepickupweapon(var0) {
  self notify("get_all_players_enemy_info_new");
  self endon("get_all_players_enemy_info_new");
  var1 = [];

  if(!scripts\engine\utility::is_equal(self.demeanoroverride, "combat")) {
    self endon("death");
    wait 5;
  }

  for(var2 = 0; var2 < level.players.size; var2++) {
    if(quickdropremoveammofrominventory(level.players[var2])) {
      var1 = level.players[var2];
    }
  }

  return var1;
}

function quickdropremoveammofrominventory(var0) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    var0.warp_player_debug = gettime();
    self getenemyinfo(var0);
    return true;
  }

  var1 = 5;
  var2 = 5;

  if(self seerecently(var0, var1)) {
    var0.warp_player_debug = gettime();
    self getenemyinfo(var0);
    return true;
  } else if(isDefined(var0.warp_player_debug) && gettime() < var0.warp_player_debug + var2 * 1000) {
    self getenemyinfo(var0);
    return true;
  } else if(isDefined(self.pathgoalpos) && distancesquared(self.pathgoalpos, var0.origin) < 262144 && self pathdisttogoal() < 2048) {
    return true;
  }

  return false;
}

function z_is_excessive(var0) {
  var1 = self.origin;
  var2 = 256;

  if(scripts\anim\utility_common::isasniper()) {
    var2 = 512;
  }

  var3 = undefined;

  if(isDefined(var0)) {
    var3 = var0[2];
  }

  for(var4 = 0; var4 < level.players.size; var4++) {
    if(!isDefined(var0)) {
      var3 = level.players[var4].origin[2];
    }

    if(int(abs(var1[2] - var3)) >= var2 && !spawnsighttrace(undefined, level.players[var4].origin, var1)) {
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

  var0 = level.spawned_enemies;
  var1 = scripts\engine\utility::get_array_of_closest(self.origin, var0, undefined, 10);
  var2 = scripts\cp\utility::get_center_point_of_array(var1);

  if(!isDefined(self.goal_pos_override) || distance2dsquared(self.goal_pos_override, var2) >= 262144) {
    self.goal_pos_override = var2;
    set_goal_pos(self.goal_pos_override);
  }

  wait 5;
}

function has_seen_any_player_recently_watcher() {
  self endon("death");
  var0 = 10;
  var1 = gettime() / level.frameduration % var0;
  var2 = self getentitynumber() % var0;

  if(var1 != var2) {
    wait(var2 + var0 - var1) % var0 * level.frameduration / 1000;
  }

  while(has_seen_any_player_recently()) {
    wait 0.5;
  }
}

function has_seen_any_player_recently() {
  var0 = 3;

  for(var1 = 0; var1 < level.players.size; var1++) {
    if(self seerecently(level.players[var1], var0)) {
      return true;
    }
  }

  if(!vo_nag_hangar()) {
    return true;
  }

  return false;
}

function teleport_to_nearby_spawner(var0, var1, var2) {
  if(scripts\cp\utility::turn_off_sniper_laser()) {
    return;
  }

  if(istrue(self.marked_for_death) || istrue(self.attempting_teleport)) {
    return;
  }

  if(has_never_kill_off_flag()) {
    if(isDefined(var0)) {
      if(getdvarint("scr_show_teleport_reason", 0)) {
        var3 = 1;

        if(isDefined(var1)) {
          if(var3) {
            announcement("(NKO)Agent at: " + self.origin + " attempted teleport because: " + var0);
          }
        } else if(var3) {
          announcement("(NKO)Agent at: " + self.origin + " attempted teleport because: " + var0);
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

  if(!isDefined(var2)) {
    var2 = 1;
  }

  if(var2) {
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

  var4 = choose_spawnpoint(self.group, 1, self);

  if(isDefined(var4)) {
    if(isDefined(var0)) {
      if(getdvarint("scr_show_teleport_reason", 0)) {
        var3 = 1;

        if(isDefined(var1)) {
          if(var3) {
            announcement("Agent at: " + self.origin + " teleported because: " + var0);
          }
        } else if(var3) {
          announcement("Agent at: " + self.origin + " teleported because: " + var0);
        }
      }
    }

    var4 notify("spawn_success", var4);
    self endon("death");
    self.combat_func_active = undefined;
    self.attempting_teleport = 1;
    self.ignoreall = 1;
    set_kill_off_time(20);
    self hide();
    set_default_spawner_values(var4);
    wait 0.1;
    self dontinterpolate();
    var5 = (0, 0, 0);

    if(isDefined(var4.angles)) {
      var5 = var4.angles;
    }

    self forceteleport(var4.origin, var5, 10000, 1);
    self.goal_pos_override = undefined;
    set_goal_pos(self.origin);
    wait 0.1;
    self.ignoreall = 0;
    self.is_on_platform = undefined;
    self.attempting_teleport = undefined;
    self show();
    set_kill_off_time(20);
    var6 = get_closest_available_player();
    update_target_player(var6);
    return;
  }

  if(isDefined(var0)) {
    if(var0 == "Bad Path") {
      return;
    }

    if(var0 == "Too Far From Target") {
      if(isDefined(var1)) {}

      set_goal_pos_to_center_of_nearby_ai();
      return;
    }

    script_kill_ai();
    return;
  }

  script_kill_ai();
}

function script_kill_ai(var0) {
  remove_from_kill_off_list();

  if(self.birthtime >= gettime()) {
    waitframe();
  }

  self.marked_for_death = 1;

  if(!istrue(var0)) {
    self.nocorpse = 1;
  }

  self.died_poorly = 1;
  self.died_poorly_health = self.health;
  self kill();
}

function is_in_combat_volume() {
  return false;
}

function remove_from_enemy_list(var0) {
  if(!isDefined(var0) && isDefined(self.target_enemy)) {
    var0 = self.target_enemy;
  }

  if(isDefined(var0)) {
    if(scripts\engine\utility::array_contains(var0.enemy_list, self)) {
      var0.enemy_list = scripts\engine\utility::array_remove(var0.enemy_list, self);
      return;
    }

    return;
  }
}

function get_closest_available_player(var0) {
  var1 = undefined;

  if(isDefined(var0)) {
    var2 = scripts\common\utility::playersnear(self.origin, var0);
  } else {
    var2 = scripts\cp\utility::get_array_of_valid_players();
  }

  var2 = sortbydistance(var2, self.origin);
  var3 = var1;

  if(var2.size > 0) {
    var2 = var2[0];

    for(var4 = 0; var4 < var2.size; var4++) {
      var5 = var2[var4];

      if(istrue(var5.ignoreme)) {
        continue;
      }

      if(!var5 scripts\cp\utility::is_valid_player(1, 1)) {
        continue;
      }

      if(isDefined(self.enemy) && var5 == self.enemy) {
        return var5;
      }

      if(scripts\cp\cp_spawning_util::increase_wave_ai_killed_counter(var5.origin)) {
        var2 = var5;
        break;
      }
    }
  }

  if(isDefined(var2)) {
    return var2;
  }

  return undefined;
}

function progression_main(var0, var1) {
  var2 = undefined;

  if(isDefined(var0) && !scripts\cp\utility::turn_off_sniper_laser()) {
    var3 = playersnearcustom(self.origin, var0, var1);
  } else {
    var3 = scripts\cp\utility::get_array_of_valid_players();
  }

  var3 = sortbydistance(var3, self.origin);
  var4 = var1;

  if(var3.size > 0) {
    var3 = var3[0];

    for(var5 = 0; var5 < var3.size; var5++) {
      var6 = var3[var5];

      if(istrue(var6.ignoreme)) {
        continue;
      }

      if(!var6 scripts\cp\utility::is_valid_player(1, 1)) {
        continue;
      }

      if(isDefined(self.enemy) && var6 == self.enemy) {
        return var6;
      }

      if(var6 scripts\cp\cp_spawning_util::increase_wave_ai_killed_counter(self.origin)) {
        var3 = var6;
        break;
      }
    }
  }

  if(isDefined(var3)) {
    return var3;
  }

  return undefined;
}

function playersnearcustom(var0, var1, var2) {
  var3 = physics_createcontents(["physicscontents_player"]);
  var4 = (var1, var1, var1);
  var5 = var0 - var4;
  var6 = var0 + var4;
  var7 = [];
  var8 = physics_aabbbroadphasequery(var5, var6, var3, []);

  for(var9 = 0; var9 < var8.size; var9++) {
    if(isPlayer(var8[var9])) {
      if(scripts\engine\utility::array_contains(var2, var8[var9])) {
        var7 = scripts\engine\utility::array_add(var7, var8[var9]);
      }
    }
  }

  return var7;
}

function set_default_ar_values() {
  self.maxfaceenemydist = 768;
  scripts\engine\utility::set_movement_speed(75);
  self setengagementmindist(128, 64);
  self setengagementmaxdist(512, 640);
}

function shotgunner_info_loop(var0) {
  if(!isDefined(var0)) {
    var0 = get_closest_available_player();
  }

  if(!isDefined(var0)) {
    set_demeanor_from_unittype("sprint");
    set_goal_radius(2000);
    return;
  }

  update_target_player(var0);
  set_goal_ent(var0);
  self setgoalentity(var0, 250);
  set_goal_radius(512);
  set_demeanor_from_unittype("combat");
}

function shotgunner_combat(var0) {
  if(!isDefined(var0)) {
    var0 = get_closest_available_player();
  }

  if(!isDefined(var0)) {
    set_demeanor_from_unittype("sprint");
    set_goal_radius(2000);
    return;
  }

  self.combat_func_active = 1;
  set_goal_ent(var0);
  set_goal_radius(256);
  set_demeanor_from_unittype("combat");
}

function update_target_player(var0) {
  if(isDefined(var0)) {
    if(!isDefined(var0.enemy_list)) {
      var0.enemy_list = [];
    }

    if(!isDefined(self.target_enemy) || self.target_enemy != var0) {
      self notify("changed_target");
      remove_from_enemy_list(var0);
    }

    run_combat_func(var0);
  }

  self.target_enemy = var0;
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

function play_rappel_intro_anim(var0, var1, var2) {
  var0 endon("death");
  var0.ignoreall = 1;
  var0 scripts\asm\shared\mp\utility::burnfxstates("sdr_com_inter_rappel_window", var1.origin, var1.angles);
  var0.ignoreall = 0;
  var0 scripts\asm\shared\mp\utility::bunkercounteruav();

  if(isDefined(var2)) {
    var0 thread[[var2]](var0);
    return;
  }
}

function trigger_choose_func_from_list(var0, var1) {}

function trigger_run_module_once(var0, var1) {
  level endon("game_ended");
  var2 = run_spawn_module(var0.target);
  var0 notify("disable_trigger");
}

function trigger_run_spawn_module(var0, var1) {
  level endon("game_ended");
  var2 = run_spawn_module(var0.target);

  if(isDefined(var2)) {
    wait_for_all_group_dead(var2);
    return;
  }
}

function set_dontkilloff_flag() {
  self.dontkilloff = 1;
}

function wait_for_all_multi_group_dead(var0, var1, var2, var3) {
  if(isDefined(var1)) {
    level scripts\engine\utility::ref_143b9(var1, "module_group " + var0.group_name + " completed");
    return;
  }

  level waittill("module_group " + var0.group_name + " completed");
}

function wait_for_all_group_dead(var0, var1, var2, var3) {
  if(isDefined(var1)) {
    var0 scripts\engine\utility::ref_143b9(var1, "group_spawning_completed");
    return;
  }

  var0 waittill("group_spawning_completed");
}

function wait_at_spawn_counts(var0, var1, var2, var3) {
  level endon("game_ended");

  if(var0.spawn_count % var1 == 0) {
    return var2;
  }

  return var3;
}

function return_random_number(var0, var1, var2) {
  var1 = define_var_if_undefined(var1, 3);
  var2 = define_var_if_undefined(var2, 5);
  return randomintrange(var1, var2);
}

function waittill_spawn_notify_after_count(var0, var1) {
  if(var0.spawn_count == 0) {
    level waittill(var1);
    return;
  }

  if(var0.max_size % var0.spawn_count == 0) {
    level waittill(var1);
    return;
  }

  return 0.1;
}

function ref_145d3(var0, var1, var2, var3) {
  var0 endon("death");

  if(!isarray(var1)) {
    var1 = [var1];
  }

  if(!isarray(var2)) {
    var2 = [var2];
  }

  if(var1.size != var2.size) {
    return;
  }

  var4 = [];

  for(var5 = 0; var5 < var1.size; var5++) {
    var6 = "within_bounds_" + var5;
    var4 = var6;
    watch_for_players_beyond_point(var0, var1[var5], var2[var5], undefined, var6, 1);
  }

  var0 scripts\engine\utility::waittill_all_in_array(var4);
  var0 notify("stop_watching_beyond_point");

  if(isDefined(var3)) {
    var0 thread[[var3]]();
    return;
  }
}

function watch_for_players_beyond_point(var0, var1, var2, var3, var4, var5) {
  thread watch_for_players_beyond_point_internal(var0, var1, var2, var3, var4, var5);
}

function mp_hideout_patch() {
  stop_module_by_groupname(self.group_name, 1);
}

function watch_for_players_beyond_point_internal(var0, var1, var2, var3, var4, var5) {
  var0 endon("death");
  var0 endon("stop_watching_beyond_point");
  var6 = spawnStruct();
  var6.origin = var1;
  var6.angles = var2;

  for(;;) {
    for(var7 = 0; var7 < level.players.size; var7++) {
      if(var6 scripts\cp\cp_spawning_util::increase_wave_ai_killed_counter(level.players[var7].origin)) {
        if(isDefined(var4)) {
          var0 notify(var4);
        }

        if(isDefined(var3)) {
          var0 thread[[var3]]();
        }

        if(!istrue(var5)) {
          return;
        }
      }
    }

    wait 0.5;
  }
}

function ref_14340(var0) {
  var0 scripts\engine\utility::ent_flag_wait("weapons_free");
}

function set_heavy_hitter(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 2048;
  }

  var2 = get_spawned_ai_from_group_struct(var0);

  for(var3 = 0; var3 < var2.size; var3++) {
    set_goal_radius(var2[var3], var1);
  }
}

function set_initial_goalheight(var0, var1) {
  thread ref_13f33(var1);
}

function ref_13f33(var0) {
  level endon("game_ended");
  self endon("death");
  level waittill(var0);
  self.ignoreall = 0;
}

function set_initial_goalRadius(var0, var1) {
  var2 = get_spawned_ai_from_group_struct(var0);

  for(var3 = 0; var3 < var2.size; var3++) {
    var2[var3] scripts\cp\cp_spawning_util::enable_juggernaut_move_behavior();
  }
}

function ref_1309b(var0) {
  level notify("weapons_free");

  if(scripts\engine\utility::flag_exist("weapons_free")) {
    scripts\engine\utility::flag_set("weapons_free");
    return;
  }
}

function group_fallback_to_pos(var0, var1) {
  var2 = get_spawned_ai_from_group_struct(var0);
  set_script_origin_other_for_group(var0, var1);
}

function fallback_to_pos_if_weapons_free(var0, var1) {
  if(var0 scripts\engine\utility::ent_flag("weapons_free")) {
    set_script_origin_other_on_ai(var1);
    return;
  }
}

function stop_and_start_group(var0, var1, var2) {
  run_spawn_module(var2);
  stop_module_by_groupname(var1);
}

function module_wave_spawn(var0, var1, var2, var3, var4, var5, var6) {
  var1 = define_var_if_undefined(var1, get_passive_wave_spawn_time());
  var2 = define_var_if_undefined(var2, get_passive_spawn_window_time());
  var3 = define_var_if_undefined(var3, 0.1);
  var7 = define_var_if_undefined(var6, get_activecount_from_group(var0));
  var4 = get_passive_wave_low_threshold(var0, var4);
  var5 = get_passive_wave_high_threshold(var0, var5);

  if(istrue(var0.spawn_window_open)) {
    if(!istrue(var0.disable_wave_hud)) {
      setomnvar("cp_wave_timer", 0);
    }

    return var3;
  }

  var8 = gettime();

  if(isDefined(var4) && isDefined(var5)) {
    if(isDefined(var6)) {
      if(var0.spawn_count > 0 && var0.spawn_count % var5 == 0) {
        change_module_status(var0, undefined, "low_threshold: " + var4);
        group_wait_for_activecount_notify(var0, var4);
        change_module_status(var0, undefined, "wave_delay");
        wave_cooldown_time(var0, var1);
        wait var1;

        if(!istrue(var0.disable_wave_hud)) {
          setomnvar("cp_wave_timer", 0);
        }

        var0 scripts\cp\cp_wave_spawning::increase_wave_num();
        change_module_status(var0, undefined, "spawning_after_low_threshold");
        return;
      }

      change_module_status(var0, undefined, "spawning_to_high_threshold");
      return var3;
    }

    if(var7 >= var5) {
      change_module_status(var0, undefined, "low_threshold: " + var4);
      group_wait_for_activecount_notify(var0, var4);
      change_module_status(var0, undefined, "wave_delay");
      wave_cooldown_time(var0, var1);
      wait var1;

      if(!istrue(var0.disable_wave_hud)) {
        setomnvar("cp_wave_timer", 0);
      }

      var0 scripts\cp\cp_wave_spawning::increase_wave_num();
      change_module_status(var0, undefined, "spawning_after_low_threshold");
      return;
    }

    change_module_status(var0, undefined, "spawning_to_high_threshold");
    return var3;
  }

  if(!isDefined(var0.last_wave_time)) {
    change_module_status(var0, undefined, "first_spawn_window");
    var0.spawn_window_open = 1;
    var0 scripts\engine\utility::delaythread(var2, &disable_spawn_window);
    var0 scripts\engine\utility::delaythread(var2, &wave_cooldown_time, var1);
    return var3;
  }

  var9 = var0.last_wave_time + var1 * 1000 - var8;

  if(var9 < 0) {
    change_module_status(var0, undefined, "full_spawn_window");
    var0.spawn_window_open = 1;
    var0 scripts\engine\utility::delaythread(var2, &disable_spawn_window);
    var0 scripts\engine\utility::delaythread(var2, &wave_cooldown_time, var1);
    return var3;
  }

  change_module_status(var0, undefined, "wave_delay");
  return var1;
}

function wave_cooldown_time(var0) {
  if(!istrue(level.wave_cooldown_active)) {
    thread monitor_wave_cooldown(level);
    thread ref_1451b(level);

    if(!istrue(self.disable_wave_hud)) {
      var1 = gettime() + var0 * 1000;
      setomnvar("cp_wave_timer", int(var1));
      return;
    }

    return;
  }
}

function monitor_wave_cooldown(var0) {
  level endon("game_ended");
  level.wave_cooldown_active = 1;
  wait var0;
  level.wave_cooldown_active = undefined;
}

function ref_1451b(var0) {
  level endon("game_ended");
  level endon("wave_starting");
  level endon("stop_wave_sounds");

  if(!scripts\cp\utility::turn_off_sniper_laser()) {
    return;
  }

  if(isDefined(level.ref_14531) && level.ref_14531 <= level.logfriendlyfire) {
    return;
  }

  var1 = var0;

  while(var1 > 0) {
    var1--;
    var2 = scripts\cp\utility::relic_bang_and_boom_dropfunc(var1);

    foreach(var4 in level.players) {
      var4 playlocalsound(var2);
    }

    if(var1 == 30 || var1 == 10) {
      var6 = scripts\cp\utility::respawn_flare_wavesv_used_playereffects(var1);

      if(isDefined(var6)) {
        level thread scripts\cp\cp_vo::try_to_play_vo_on_team(var6, "allies");
      }
    }

    wait 1;
  }
}

function override_spawner_aitypes(var0, var1, var2, var3) {
  var4 = [];

  if(isDefined(var1)) {
    GscBinSkip0(0x2e, var4.size, var1);
  }

  if(isDefined(var2)) {
    GscBinSkip0(0x2e, var4.size, var2);
  }

  if(isDefined(var3)) {
    GscBinSkip0(0x2e, var4.size, var3);
  }

  for(var5 = 0; var5 < var0.spawn_points.size; var5++) {
    var6 = var0.spawn_points[var5];
    var6.script_noteworthy = var4;
  }
}

function set_count_based_on_grouped_modules(var0, var1, var2, var3) {
  if(!isDefined(level.grouped_modules[var1])) {
    level.grouped_modules[var1] = [];
  }

  if(!scripts\engine\utility::array_contains(level.grouped_modules[var1], var0)) {
    level.grouped_modules[var1][level.grouped_modules[var1].size] = var0;
  }

  var4 = var0.activecount;
  var5 = get_active_from_grouped_modules(level.grouped_modules[var1]);

  if(var5 < var2) {
    return var3;
  }

  return 0;
}

function shipfx(var0) {
  var1 = rear_spotlight_speed(var0);

  if(!isDefined(var1)) {
    return false;
  }

  var2 = rear_spotlight_speed(var0);

  if(!isDefined(var2)) {
    return false;
  }

  return var1 < var2;
}

function rear_spotlight_speed(var0) {
  if(isDefined(var0.ref_13959)) {
    return var0.ref_13959;
  }

  return undefined;
}

function recharge_equipment_update_slot(var0) {
  if(isDefined(var0.ref_13be9)) {
    return var0.ref_13be9;
  }

  return undefined;
}

function ref_130f7(var0, var1) {
  var0.ref_13be9 = var1;
}

function get_active_from_grouped_modules(var0) {
  var1 = 0;

  for(var2 = 0; var2 < var0.size; var2++) {
    var1 += var0[var2].activecount;
  }

  return var1;
}

function define_var_if_undefined(var0, var1) {
  if(!isDefined(var0)) {
    if(isbuiltinfunction(var1)) {
      return [[var1]]();
    }

    return var1;
  }

  return var0;
}

function disable_spawn_window(var0) {
  self.spawn_window_open = undefined;
  self.last_wave_time = gettime();
}

function wave_reinforce(var0, var1, var2, var3) {
  level endon("game_ended");

  if(get_activecount_from_group(var0) <= var0.min_size) {
    if(var1 > 0.05) {
      return randomfloatrange(0.05, var1);
    } else {
      return 0.05;
    }
  }

  if(var0.activecount >= var0.max_size) {
    while(get_activecount_from_group(var0) > var0.min_size) {
      wait 0.25;
    }

    return var2;
  }

  if(isDefined(var1)) {
    return var1;
  }

  if(isDefined(var2)) {
    return var2;
  }

  return 0.05;
}

function set_wave_show_hud(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 1;
  }

  var0.disable_wave_hud = !var1;
}

function go_to_node(var0, var1, var2) {
  if(!isDefined(var0) || isarray(var0) && var0.size < 1) {
    var0 = get_next_node_array(self.spawnpoint);

    if(var0.size == 0) {
      self notify("reached_path_end");

      if(isDefined(var1)) {
        [[var1]]();
      }

      return;
    }
  } else if(!isarray(var0)) {
    var0 = [var0];
  }

  for(var3 = 0; var3 < var0.size; var3++) {
    if(isvector(var0[var3])) {
      var4 = spawnStruct();
      var4.origin = var0[var3];
      var4.angles = (0, 0, 0);
      var0 = var4;
    }
  }

  go_to_node_internal(var0, var1, var2);
}

function get_next_node_array() {
  var0 = get_linkto_goals();

  if(var0.size < 1) {
    if(isDefined(self.target)) {
      var0 = get_target_goals(self.target);
    }
  }

  return var0;
}

function get_target_goals(var0) {
  var1 = getnodearray(var0, "targetname");
  var2 = scripts\engine\utility::getStructArray(var0, "targetname");

  foreach(var4 in var2) {
    var1 = var4;
  }

  var2 = getEntArray(var0, "targetname");

  for(var6 = 0; var6 < var2.size; var6++) {
    var4 = var2[var6];

    if(!is_target_goal_valid(var4)) {
      continue;
    }

    var1 = var4;
  }

  return var1;
}

function get_linkto_goals() {
  var0 = [];

  if(isDefined(self.script_linkto)) {
    var1 = scripts\engine\utility::get_linked_ents();
    var2 = scripts\engine\utility::get_linked_structs();
    var3 = scripts\engine\utility::get_linked_nodes();
    var0 = scripts\engine\utility::array_combine(var1, var2, var3);
  }

  return var0;
}

function go_to_node_internal(var0, var1, var2) {
  self notify("stop_going_to_node");
  self endon("stop_going_to_node");
  self endon("death");
  level endon("game_ended");

  if(!isarray(var0)) {
    var0 = [var0];
  }

  thread go_to_node_end();
  var3 = 0;
  var4 = 0;
  var5 = undefined;
  var6 = var0[0];

  for(;;) {
    if(!var3) {
      var0 = get_least_used_from_array(var0);
      var5 = get_path_array(var0, var6);

      if(var5.size > 1) {
        var3 = 1;
      }
    }

    self.currentnode = var0;

    if(var3) {
      var0 = var5[var5.size - 1];
      go_through_patharray(var5, var1, var2);
      var5 = undefined;
      var3 = 0;
    } else {
      node_fields_pre_goal(var0);
      go_to_node_set_goal(var0);
      self waittill("goal");
    }

    var0 notify("trigger", self);
    node_fields_after_goal(var0, var1);
    ref_11e9e(var0);
    var0 scripts\engine\utility::script_delay();

    if(isDefined(var0.script_flag_wait)) {
      scripts\engine\utility::flag_wait(var0.script_flag_wait);
    }

    if(isDefined(var0.script_ent_flag_wait)) {
      scripts\engine\utility::ent_flag_wait(var0.script_ent_flag_wait);
    }

    var0 scripts\engine\utility::script_wait();
    node_fields_after_goal_and_wait(var0, var2);

    if(!isDefined(var0.target) && !isDefined(var0.script_linkto)) {
      break;
    }

    var7 = get_next_node_array(var0);

    if(!var7.size) {
      break;
    }

    var0 = var7;
  }

  self notify("reached_path_end");

  if(isDefined(self.script_forcegoal)) {
    return;
  }

  var8 = self getgoalvolume();

  if(isDefined(var8)) {
    self setgoalvolumeauto(var8, get_cover_volume_forward(var8));
    return;
  }
}

function get_least_used_from_array(var0) {
  if(var0.size == 1) {
    return var0[0];
  }

  var0 = scripts\engine\utility::array_randomize(var0);
  var1 = var0[0];

  if(!isDefined(var1.used_time)) {
    var1.used_time = 0;
  }

  for(var2 = 0; var2 < var0.size; var2++) {
    var3 = var0[var2];

    if(!isDefined(var3.used_time)) {
      var3.used_time = 0;
    }

    if(var3.used_time < var1.used_time) {
      var1 = var3;
    }
  }

  var1.used_time = gettime();
  return var1;
}

function get_path_array(var0, var1) {
  var2 = [];
  var3 = 0;

  for(;;) {
    var2 = var0;
    var3++;

    if(var3 == 16) {
      break;
    }

    if(go_to_node_should_stop(var0)) {
      break;
    }

    if(!isDefined(var0.target) && !isDefined(var0.script_linkto)) {
      break;
    }

    var4 = get_next_node_array(var0);

    if(!var4.size) {
      break;
    }

    var0 = get_least_used_from_array(var4);

    if(var0 == var1) {
      break;
    }
  }

  return var2;
}

function go_through_patharray(var0, var1, var2) {
  self setgoalpath(var0);

  for(var3 = 0; var3 < var0.size; var3++) {
    var4 = var3;
    var5 = var0[var3];
    self.currentnode = var5;
    node_fields_pre_goal(var5);
    var6 = waittill_subgoal();

    if(var4 == var0.size - 1) {
      self waittill("goal");
      break;
    }

    var5 notify("trigger", self);
    node_fields_after_goal(var5, var1);
    ref_11e9e(var5);
    node_fields_after_goal_and_wait(var5, var2);
  }
}

function node_fields_pre_goal(var0) {
  if(isDefined(var0.radius)) {
    set_goal_radius(var0.radius);
  }

  if(isDefined(var0.script_radius)) {
    self.script_radius = var0.script_radius;
    set_goal_radius(var0.script_radius);
  }

  if(isDefined(var0.height)) {
    self.goalheight = var0.height;
  }

  if(isDefined(var0.script_demeanor)) {
    set_demeanor_from_unittype(var0.script_demeanor);
  }

  if(istrue(var0.script_pacifist) || isDefined(var0.spawnflags) && var0.spawnflags & 256) {
    self.pacifist = 1;
  }

  if(isDefined(var0.script_ignoreall)) {
    self.ignoreall = var0.script_ignoreall;
  }

  if(isDefined(var0.script_ignoreme)) {
    self.ignoreme = var0.script_ignoreme;
  }

  if(isDefined(var0.script_flag)) {
    scripts\engine\utility::flag_init(var0.script_flag);
  }

  if(isDefined(var0.script_speed)) {
    scripts\engine\utility::set_movement_speed(var0.script_speed);
    return;
  }
}

function node_fields_after_goal(var0, var1) {
  if(isDefined(var1)) {
    [[var1]](var0);
  }

  if(isDefined(var0.script_flag_set)) {
    scripts\engine\utility::flag_set(var0.script_flag_set);
  }

  if(isDefined(var0.script_ent_flag_set)) {
    scripts\engine\utility::ent_flag_set(var0.script_ent_flag_set);
  }

  if(isDefined(var0.script_flag_clear)) {
    scripts\engine\utility::flag_clear(var0.script_flag_clear);
    return;
  }
}

function ref_11e9e(var0) {
  level endon("game_ended");
  self endon("death");

  if(!istrue(level.global_stealth_broken) && !istrue(self.entered_combat) && isDefined(var0.script_animation_type)) {
    var1 = undefined;
    var2 = strtok(var0.script_animation_type, ",");
    var1 = scripts\engine\utility::random(var2);

    if(isDefined(var1)) {
      if(!istrue(var0.script_looping)) {
        self.ref_133a4 = 1;
      } else {
        self.ref_133a4 = undefined;
      }

      self.playing_skit = 1;
      ref_1241b(var0, var1);
      self.playing_skit = undefined;

      while(istrue(self.playing_skit)) {
        wait 0.05;
      }

      return;
    }

    return;
  }
}

function ref_1241b(var0, var1) {
  self endon("death");

  if(istrue(self.ref_133a4)) {
    self endon("patrol_" + var1 + "_loop");
  }

  set_goal_pos(var0.origin);
  self thread[[level.spawn_skits[var1].skit_func]]();

  while(istrue(self.playing_skit)) {
    wait 0.05;
  }
}

function node_fields_after_goal_and_wait(var0, var1) {
  if(isDefined(var0.script_soundalias)) {
    if(soundexists(var0.script_soundalias)) {
      self playSound(var0.script_soundalias);
    }
  }

  if(isDefined(var0.script_forcegoal)) {
    set_goal_radius(var0.script_forcegoal);
  }

  if(isDefined(self.post_wait_func)) {
    [[self.post_wait_func]]();
  }

  if(isDefined(var0.script_delay_post)) {
    wait var0.script_delay_post;
  }

  while(isDefined(var0.script_requires_player)) {
    var0.script_requires_player = 0;

    if(go_to_node_wait_for_player(var0, &get_next_node_array)) {
      var0.script_requires_player = 1;
      var0 notify("script_requires_player");
      break;
    }

    wait 0.25;
  }

  if(isDefined(var0.script_demeanor_post)) {
    set_demeanor_from_unittype(var0.script_demeanor_post);
  }

  if(isDefined(var1)) {
    [[var1]](var0);
  }

  if(isDefined(var0.script_death) && var0.script_death) {
    script_kill_ai();
  }

  if(isDefined(var0.script_delete) && var0.script_delete) {
    self delete();
    return;
  }
}

function go_to_node_wait_for_player(var0, var1) {
  var2 = 0;

  while(var2 < level.players.size) {
    var3 = level.players[var2];

    if(distancesquared(var3.origin, var0.origin) < distancesquared(self.origin, var0.origin)) {
      return 1;
    }

    if(!isDefined(var0.script_dist_only)) {
      var4 = anglesToForward(self.angles);

      if(isDefined(var0.target)) {
        var5 = var0[[var1]](var0.target);

        if(var5.size == 1) {
          var4 = vectorNormalize(var5[0].origin - var0.origin);
        } else if(isDefined(var0.angles)) {
          var4 = anglesToForward(var0.angles);
        }
      } else if(isDefined(var0.angles)) {
        var4 = anglesToForward(var0.angles);
      }

      var6 = [];
      GscBinSkip0(0x2e, var6.size, vectorNormalize(var3.origin - self.origin));
    }

    var10 = 300;

    if(var2.script_requires_player > var10) {
      var10 = var2.script_requires_player;
    }

    if(distancesquared(var6.origin, self.origin) < squared(var10)) {
      return 1;
    }

    return 0;
  }
}

function waittill_subgoal() {
  self endon("goal");
  self waittill("subgoal", var0);
  return var0;
}

function go_to_node_should_stop(var0) {
  if(!isDefined(var0)) {
    return true;
  }

  if(!isDefined(var0.target)) {
    return true;
  }

  if(isDefined(var0.script_delay)) {
    return true;
  }

  if(isDefined(var0.script_delay_min)) {
    return true;
  }

  if(isDefined(var0.script_delay_max)) {
    return true;
  }

  if(isDefined(var0.script_wait)) {
    return true;
  }

  if(isDefined(var0.script_wait_add)) {
    return true;
  }

  if(isDefined(var0.script_wait_min)) {
    return true;
  }

  if(isDefined(var0.script_wait_max)) {
    return true;
  }

  if(isDefined(var0.script_flag_wait)) {
    return true;
  }

  if(isDefined(var0.script_ent_flag_wait)) {
    return true;
  }

  if(isDefined(var0.script_delay_post)) {
    return true;
  }

  if(isDefined(var0.script_requires_player)) {
    return true;
  }

  if(isDefined(var0.script_idle)) {
    return true;
  }

  if(isDefined(var0.script_stopnode)) {
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

function go_to_node_set_goal(var0) {
  if(isnode(var0)) {
    go_to_node_set_goal_node(var0);
  } else if(isstruct(var0)) {
    go_to_node_set_goal_pos(var0);
  } else if(isent(var0)) {
    go_to_node_set_goal_ent(var0);
  }

  if(isstruct(var0) || isnode(var0)) {
    var0.patrol_stop = go_to_node_should_stop(var0);
    return;
  }
}

function go_to_node_set_goal_ent(var0) {
  if(var0.code_classname == "info_volume") {
    self setgoalvolumeauto(var0, get_cover_volume_forward(var0));
    self notify("go_to_node_new_goal");
    return;
  }

  go_to_node_set_goal_pos(var0);
}

function go_to_node_set_goal_pos(var0) {
  set_goal_ent(var0);
  self notify("go_to_node_new_goal");
}

function enter_combat_after_go_to_node() {
  level endon("game_ended");
  self endon("death");
  go_to_node(get_next_node_array(self.spawnpoint));
  thread enter_combat();
}

function set_goal_ent(var0) {
  set_goal_pos(var0.origin);
  self.last_set_goalent = var0;

  if(isstruct(var0) && !isDefined(var0.type)) {
    var0.type = "struct";
    return;
  }
}

function set_goal_pos(var0) {
  if(istrue(self.fixednode)) {
    return;
  }

  self.last_set_goalnode = undefined;
  self.last_set_goalpos = var0;
  self.last_set_goalent = undefined;
  self setgoalpos(getclosestpointonnavmesh(var0));
  self notify("new_goal_pos");
}

function go_to_node_set_goal_node(var0) {
  set_goal_node(var0);
  self notify("go_to_node_new_goal");
}

function set_goal_node(var0) {
  self.last_set_goalnode = var0;
  self.last_set_goalpos = undefined;
  self.last_set_goalent = undefined;
  self setgoalnode(var0);
}

function go_to_node_end() {
  self notify("go_to_node_end");
  self endon("go_to_node_end");
  self endon("death");
  level endon("game_ended");
  self.using_goto_node = 1;
  var0 = scripts\engine\utility::ref_143ad("reached_path_end", "stop_going_to_node");
  self.using_goto_node = undefined;
  self.patharray = undefined;
  self.patharrayindex = undefined;
}

function is_target_goal_valid(var0) {
  if(isspawner(var0)) {
    return false;
  }

  switch (var0.code_classname) {
    case "trigger_once":
    case "trigger_multiple":
    case "trigger_radius":
    case "misc_turret":
      return false;
  }

  return true;
}

function set_goal_radius(var0) {
  if(!isDefined(var0)) {
    var0 = 2048;
  }

  self.last_goalradius = self.goalradius;
  self.goalradius = int(var0);
}

function return_to_last_goalRadius() {
  if(isDefined(self.last_goalradius)) {
    set_goal_radius(self.last_goalradius);
    return;
  }
}

function set_goal_pos_check_for_offset(var0) {
  if(isDefined(self.script_origin_other)) {
    var0 = self.script_origin_other;
  }

  set_goal_pos(var0);
}

function set_script_origin_other_for_group(var0) {
  if(isarray(self)) {
    var1 = [];

    for(var2 = 0; var2 < self.size; var2++) {
      var1 = scripts\engine\utility::array_add(var1, self[var2].ai_spawned);
    }

    var3 = var1;
  } else {
    var3 = self.ai_spawned;
  }

  for(var2 = 0; var2 < var3.size; var2++) {
    set_kill_off_time(var3[var2]);
    set_script_origin_other_on_ai(var3[var2], var3);
  }
}

function ref_11cae(var0) {
  self.ref_133b2 = 1;
}

function ref_11cac(var0, var1) {
  set_goal_radius(var1);
}

function ref_11cab(var0, var1) {
  self.goalheight = var1;
}

function ref_11cb2(var0, var1) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait(var1);
  scripts\engine\utility::flag_waitopen(var1);
}

function ref_12ce2(var0) {
  return var0.group_name;
}

function ref_11cb1(var0, var1) {
  level endon("game_ended");
  scripts\engine\utility::flag_wait(var1);
}

function ref_11cad(var0, var1) {
  self.script_origin_other = var1;
}

function set_script_origin_other_on_ai(var0) {
  self.script_origin_other = var0;
}

function clear_script_origin_other_on_ai(var0) {
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
  var0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Show Agent Stats:1 / Disable:0\" \"togglep scr_show_agent_stats 0\" \n";
  scripts\cp\utility::addentrytodevgui(var0);

  for(var1 = 4; var1 < 4 + get_max_agent_count(); var1++) {
    var0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Show Agent Stats:1 / e" + var1 + ":" + var1 + "\" \"togglep scr_show_agent_stats " + var1 + "\" \n";
    scripts\cp\utility::addentrytodevgui(var0);
  }

  var0 = "devgui_cmd \"CP Debug:2 / Debug / Print Dialogue Aliases\" \"togglep scr_print_dialogue_alias 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var0);
  var0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Print Spawner Disables:2\" \"togglep scr_print_spawner_disables 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var0);
  var0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Show Cleanup Stats:2\" \"togglep scr_show_kill_off_stats 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var0);
  var0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Pause Spawning:0\" \"togglep scr_pause_spawning 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var0);
  var0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Print Spec Info\" \"togglep scr_show_spawn_spec_info 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var0);
  var0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Toggle Ambient Spawning\" \"togglep scr_always_on_always 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var0);
  var0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Disable badpath cleanup:3\" \"togglep scr_disable_bad_path_cleanup 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var0);
  var0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Show Teleport Reasons:3\" \"togglep scr_show_teleport_reason 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var0);
  var0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Use Wave Spawning\" \"togglep scr_wave_spawning 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var0);
  var0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Init Nodes As Spawners\" \"togglep scr_init_cover_node_spawners 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var0);
  var0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Use Cover Node Spawning\" \"togglep scr_cover_node_spawning 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var0);
  var0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Only Use Passive Spawning\" \"togglep scr_only_passive_spawning 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var0);
  var0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / AI Outline Debug:4\" \"togglep scr_ai_outline_debug 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var0);
  var0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Cleanup Vehicles:4\" \"set scr_debug_spawning cleanup_vehicles\" \n";
  scripts\cp\utility::addentrytodevgui(var0);
  var0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Stop All Groups:4\" \"set scr_debug_spawning stop_all_groups\" \n";
  scripts\cp\utility::addentrytodevgui(var0);
  var0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / whyAmINotShooting\" \"togglep ai_whyaminotshooting 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var0);
  var0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / whyAmINotMoving\" \"togglep ai_whyaminotmoving 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var0);
  var0 = "devgui_cmd \"CP Debug:2 / Stealth / Debug\" \"togglep debug_stealth 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var0);
  var0 = "devgui_cmd \"CP Debug:2 / Stealth / Chat\" \"togglep debug_stealth_chat 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var0);
  var0 = "devgui_cmd \"CP Debug:2 / Stealth / fov\" \"togglep debug_stealth_fov 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var0);
  level.spawnpoint_debug = 0;
  var0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Spawnpoint Debug / Toggle:4\" \"set scr_debug_spawning spawnpoint_debug\" \n";
  scripts\cp\utility::addentrytodevgui(var0);
  var0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Show Spawnpoint Selection\" \"togglep scr_show_spawn_selection 0 1\" \n";
  scripts\cp\utility::addentrytodevgui(var0);
  var0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Spawnpoint Debug / Add Proxy Player At Loc:4\" \"set scr_debug_spawning proxy_add_player\" \n";
  scripts\cp\utility::addentrytodevgui(var0);
  var0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Spawnpoint Debug / Delete All Proxy Players:4\" \"set scr_debug_spawning proxy_delete_all\" \n";
  scripts\cp\utility::addentrytodevgui(var0);
  var0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Spawnpoint Debug / Delete Selected Proxy Player:4\" \"set scr_debug_spawning proxy_delete_selected\" \n";
  scripts\cp\utility::addentrytodevgui(var0);
  var0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning / Show Active Spawn Modules\" \"set scr_debug_spawning show_active_spawn_modules\" \n";
  scripts\cp\utility::addentrytodevgui(var0);
  var0 = "devgui_cmd \"CP Debug:2 / CP Module Spawning:3 / Convert Nodes To Spawners\" \"set scr_debug_spawning convert_nodes\" \n";
  scripts\cp\utility::addentrytodevgui(var0);
  registerambientgroup("DEBUG:0/Max Agent Test", 0, &get_max_agent_count, undefined, 0.1, undefined, &get_all_cluster_spawners, undefined, undefined, undefined);
  registerambientgroup("DEBUG:0/Vehicles/Vehicle_Spawn_Test", 0, 24, undefined, 0.1, undefined, &redshirt_drop_off_behavior, undefined, undefined, undefined);
}

function redshirt_drop_off_behavior(var0) {
  if(getDvar("scr_veh_spawn_test", "") != "") {
    var1 = scripts\engine\utility::getStructArray(getDvar("scr_veh_spawn_test", ""), "targetname");

    if(var1.size > 0) {
      return var1;
    }

    return [];
  }

  return [];
}

function get_all_cluster_spawners(var0) {
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
    var0 = 150;
    var1 = " ";
    var2 = "|Active| Min| Max|Deaths| Total";
    var3 = "Active Modules| Spawn Count: " + level.spawned_ai.size + "/" + get_max_agent_count();
    var3 = var3 + getsubstr(var1, 0, var1.size - var3.size + var2.size) + var2;
    var0 += 15;
    var4 = " ";
    var5 = getsubstr(var1, 0, var1.size - var4.size * 5 - 4);

    if(isDefined(level.spawn_module_structs_memory) && level.spawn_module_structs_memory.size > 0) {
      var6 = getarraykeys(level.spawn_module_structs_memory);

      for(var7 = 0; var7 < var6.size; var7++) {
        var8 = var6[var7];
        var9 = level.spawn_module_structs_memory[var8];

        for(var10 = 0; var10 < var9.size; var10++) {
          var11 = var9[var10];

          if(var8 == "wave_spawning") {
            var12 = get_current_wave_ref(var11);
            var8 = "wave: " + var12;
          }

          var13 = get_module_debug_data(var11);

          if(isDefined(level.active_spawn_module_structs) && is_group_active(var11)) {
            var14 = (1, 1, 1);
          } else {
            var14 = (1, 1, 0);
          }

          var15 = add_space_to_string("| A:" + get_activecount_from_group(var11, 1), var4);
          var16 = add_space_to_string("| m:" + var13.min_size, var4);
          var17 = add_space_to_string("| M:" + var13.max_size, var4);
          var18 = add_space_to_string("| T:" + var13.totalspawns, var4);
          var19 = add_space_to_string("| D:" + var11.currentmodulekills, var4);
          var3 = add_space_to_string(var13.status + "|" + var8, var5) + "[" + var10 + "] " + var15 + var16 + var17 + var19 + var18;
          var0 += 15;
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

function create_hudelem(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var4)) {
    var4 = 1;
  }

  if(!isDefined(var3)) {
    var3 = 1;
  }

  if(!isDefined(var5)) {
    var5 = 20;
  }

  var6 = newhudelem();
  var6.location = 0;
  var6.alignx = "left";
  var6.aligny = "middle";
  var6.vertalign = "top";
  var6.horzalign = "left";
  var6.foreground = 1;
  var6.fontscale = 1;
  var6.sort = define_var_if_undefined(var5, 1);
  var6.alpha = define_var_if_undefined(var4, 0.1);
  var6.x = define_var_if_undefined(var1, 0);
  var6.y = define_var_if_undefined(var2, 85);
  var6.og_scale = 1;
  var6.archived = 0;

  if(isDefined(var0)) {
    var6.text = var0;

    if(isnumber(var0)) {
      var6 setvalue(var0);
    } else {
      var6 clearalltextafterhudelem();
    }
  }

  return var6;
}

function add_space_to_string(var0, var1) {
  if(var0.size > var1.size) {
    return getsubstr(var0, 0, var1.size);
  }

  var2 = getsubstr(var1, 0, var1.size - var0.size);

  if(isDefined(var2) && var2.size > 0) {
    return (var0 + var2);
  }

  return var0;
}

function is_group_active() {
  if(isDefined(level.active_spawn_module_structs) && level.active_spawn_module_structs.size > 0) {
    var0 = getarraykeys(level.active_spawn_module_structs);

    for(var1 = 0; var1 < level.active_spawn_module_structs.size; var1++) {
      var2 = var0[var1];

      if(scripts\engine\utility::array_contains(level.active_spawn_module_structs[var2], self)) {
        return 1;
      }
    }

    return 0;
  }

  return 0;
}

function create_module_debug_struct() {
  var0 = spawnStruct();
  var0.status = "running";
  var0.min_size = 0;
  var0.max_size = 0;
  var0.totalspawns = 0;
  self.debug_data = var0;
}

function change_module_status(var0, var1) {}

function get_module_debug_data() {
  return self.debug_data;
}

function agent_use_door_spawner(var0, var1, var2, var3, var4, var5, var6) {
  var0 notify("door_being_used");
  var1 notify("door_being_used");
  var1 endon("door_being_used");

  foreach(var8 in var2) {
    if(!var8 scripts\engine\utility::ent_flag_exist("max_spawns_reached")) {
      var8 scripts\engine\utility::ent_flag_init("max_spawns_reached");
    }

    if(!var8 scripts\engine\utility::ent_flag_exist("using_intro_anim")) {
      var8 scripts\engine\utility::ent_flag_init("using_intro_anim");
    }
  }

  var1 asmsetstate(var1.asmname, "animscripted");
  var1 scripts\asm\asm_bb::bb_setanimScripted();
  var1.ignoreall = 1;
  var1.scripted_mode = 1;
  var10 = undefined;
  var11 = 2;
  var12 = undefined;
  thread decrement_door_count_on_death(var1, var0, var1, var6);

  if(isDefined(level.spawn_ldoor_anims)) {
    if(var0.spawners_using == 1) {
      foreach(var8 in var2) {
        set_door_state(var8, "open_started", var6);
      }

      thread soldier_wait_for_door_open_sequence(var1, var0, var1, var2, var3, var4, var5, var6);
      return;
    }

    thread soldier_wait_for_door_open_sequence(var1, var0, var1, var2, var3, var4, var5);
    return;
  }

  foreach(var8 in var2) {
    set_door_state(var8, "open_started", var6);
  }

  thread soldier_wait_for_door_open_sequence(var1, var0, var1, var2, var3, var4, var5, var6);
}

function decrement_door_count_on_death(var0, var1, var2, var3) {
  level endon("game_ended");

  if(!isDefined(var0.spawners_using)) {
    var0.spawners_using = 0;
  }

  var0.spawners_using++;

  if(isDefined(var2) && isDefined(var2.script_reuse_max)) {
    var4 = var2.script_reuse_max;
  } else {
    var4 = 3;
  }

  if(var1.spawners_using >= var4) {
    foreach(var6 in var4) {
      var6 thread scripts\engine\utility::ent_flag_set_delayed("max_spawns_reached", 0.25);
    }
  }

  var2 scripts\engine\utility::ref_143a5("death", "door_infil_anim_completed");
  decrement_spawners_using_count(var1, var4);
}

function decrement_spawners_using_count(var0, var1) {
  var2 = var0.spawners_using;

  if(var2 <= 0) {
    var2 = 0;
  } else {
    var2--;
  }

  var0.spawners_using = var2;

  if(var0.spawners_using <= 0) {
    foreach(var4 in var1) {
      set_door_state(var4, "door_closing");
    }

    return;
  }
}

function soldier_wait_for_door_open_sequence(var0, var1, var2, var3, var4, var5, var6, var7) {
  var1 notify("soldier_wait_for_door_open_sequence");
  var1 endon("soldier_wait_for_door_open_sequence");
  var1 endon("death");
  var8 = undefined;
  var9 = undefined;
  var10 = 7;
  var1.invulnerable = 1;
  var1.animname = "ai_spawn_door_soldier";
  var11 = 0;
  var12 = undefined;
  var1 scripts\engine\utility::disable_pain();

  if(isDefined(var0.anim_node)) {
    var13 = var0.anim_node;
  } else {
    var13 = var1;
  }

  if(istrue(var8) || !isDefined(var1.last_ai_spawn_anim)) {
    if(getDvar("scr_door_anim_override", "") != "") {
      var14 = getDvar("scr_door_anim_override", "");
      var2.ai_door_anim = var14;
    } else {
      var14 = scripts\cp\cp_ai_spawn_anim_skits::get_spawn_anim(var2, var8, var3);
      var3.ai_door_anim = var14;
    }

    thread ai_spawn_door_interal(var2, var2, var3, var13, var4, var5, var6);
  } else {
    if(var3 scripts\engine\utility::ent_flag("using_intro_anim")) {
      var3 scripts\engine\utility::ent_flag_waitopen("using_intro_anim");
    }

    var14 = get_follow_anim_from_breach_anim(var3.last_ai_spawn_anim);
    var4.ai_door_anim = var14;
  }

  if(var3 scripts\engine\utility::ent_flag("using_intro_anim")) {
    var3 scripts\engine\utility::ent_flag_waitopen("using_intro_anim");
  }

  if(var3 scripts\engine\utility::ent_flag("using_intro_anim")) {
    var3 scripts\engine\utility::ent_flag_waitopen("using_intro_anim");
  }

  if(var4.agent_type != "juggernaut") {
    var4.ai_door_anim = var14;
    var3.last_ai_spawn_anim = var14;
  }

  var3 scripts\engine\utility::ent_flag_wait("max_spawns_reached");

  if(var4.agent_type != "juggernaut") {
    var11 = var4 scripts\asm\asm::asm_lookupanimfromalias("animscripted", var4.ai_door_anim);
    var12 = var4 scripts\asm\asm::asm_getxanim("animscripted", var11);
    var15 = var14.origin;
    var16 = var14.angles;

    if(scripts\cp\cp_ai_spawn_anim_skits::is_double_door(var9)) {
      var15 = scripts\cp\cp_ai_spawn_anim_skits::get_double_door_mid_point(var9);
    }

    var6 = getstartorigin(var15, var16, var12);
    var7 = getstartangles(var15, var16, var12);
    var4 dontinterpolate();
    var4 forceteleport(var6, var7);
  }

  foreach(var18 in var5) {
    set_door_state(var18, "opening", var9);
  }

  var3 scripts\engine\utility::ent_flag_wait("door_opening");
  var4.invulnerable = undefined;

  if(var4.agent_type != "juggernaut") {
    var4 aisetanim("animscripted", var11);
    var4 animmode("noclip");
    var13 = getanimlength(var12);
    run_door_spawn_end_funcs(var4, var3, var8, var13, var5, var14);
    return;
  }

  if(isDefined(var4.enemy)) {
    set_goal_pos(var4, var4.enemy.origin);
  } else {
    var20 = scripts\cp\utility::get_array_of_valid_players(1, var4.origin)[0];

    if(isDefined(var20)) {
      set_goal_pos(var4, var20.origin);
    }
  }

  run_door_spawn_end_funcs(var4, var3, var8, var13, var5);
}

function play_intro_animation(var0, var1, var2, var3) {
  level endon("game_ended");
  var1 endon("death");
  var0.last_ai_spawn_anim = var2;
  var4 = var1 scripts\asm\asm::asm_lookupanimfromalias("animscripted", var2);
  var5 = var1 scripts\asm\asm::asm_getxanim("animscripted", var4);
  var6 = var0.origin;
  var7 = var0.angles;
  var8 = getstartorigin(var6, var7, var5);
  var9 = getstartangles(var6, var7, var5);
  var1 dontinterpolate();
  var1 forceteleport(var8, var9);
  var10 = spawn("script_model", var0.origin);
  var10 setModel("offhand_wm_grenade_smoke");
  wait 0.2;
  var1 aisetanim("animscripted", var4);
  var1 animmode("noclip");
  var11 = getanimlength(var5);
  var12 = get_door_anim_from_ai_anim(var2);

  if(isDefined(var0.linkedpents)) {
    foreach(var14 in var0.linkedpents) {
      var14.animname = "ai_spawn_door";
      var14 useanimtree(level.scr_animtree[var14.animname]);
      var0 thread scripts\common\anim::anim_single_solo(var14, var12);
    }
  } else if(isDefined(var0.targetmodels)) {
    foreach(var14 in var0.targetmodels) {
      var14.animname = "ai_spawn_door";
      var14 useanimtree(level.scr_animtree[var14.animname]);
      var0 thread scripts\common\anim::anim_single_solo(var14, var12);
    }
  } else if(isent(var0)) {
    var0.animname = "ai_spawn_door";
    var0 useanimtree(level.scr_animtree[var0.animname]);
    var0 thread scripts\common\anim::anim_single_solo(var0, var12);
  }

  wait var11;
  var10 delete();
  wait 1;

  foreach(var19 in var3) {
    var19 scripts\engine\utility::ent_flag_clear("using_intro_anim");
  }
}

function ai_spawn_door_interal(var0, var1, var2, var3, var4, var5, var6) {
  var0 notify("ai_spawn_door_interal");
  var0 endon("ai_spawn_door_interal");
  var2 = "wood_door_kick";
  var7 = get_door_anim_from_ai_anim(var1.ai_door_anim);

  if(isDefined(level.scr_anim["ai_spawn_door"][var7])) {
    var8 = getanimlength(level.scr_anim["ai_spawn_door"][var7]);
    var9 = 0.5;
  } else {
    var8 = 5;
    var9 = 0.5;
  }

  thread run_open_door_anim(var2, var2, var4, var9, var8, var9, var8);

  if(var2 scripts\engine\utility::ent_flag("using_intro_anim")) {
    var2 scripts\engine\utility::ent_flag_waitopen("using_intro_anim");
  }

  var2 scripts\engine\utility::ent_flag_wait_or_timeout("max_spawns_reached", 3);

  foreach(var11 in var5) {
    var11 scripts\engine\utility::ent_flag_set("max_spawns_reached");
  }

  var2 scripts\engine\utility::ent_flag_wait("door_opening");
  wait 0.75;

  if(isDefined(var4) && soundexists(var4)) {
    scripts\cp\utility::playsoundinspace(var4, var6);
    return;
  }
}

function run_door_spawn_end_funcs(var0, var1, var2, var3, var4, var5) {
  var0 endon("death");

  if(isDefined(var3)) {
    var0 thread scripts\cp\utility::notify_delay("door_infil_anim_completed", var3);
    var6 = max(0.05, var3 - 0.25);
    wait var6;
  }

  var0.ignoreall = 0;

  if(isDefined(var2)) {
    [[var2]](var0);
    return;
  }

  if(var0.agent_type != "juggernaut") {
    set_goal_radius(var0, 2000);
    var0 scripts\engine\utility::enable_pain();
    var0 animmode("normal");
  } else {
    set_goal_radius(var0, 128);
  }

  var0 scripts\asm\shared\mp\utility::bunkercounteruav();

  if(isDefined(var0.spawnpoint.target)) {
    thread start_patrol();
    return;
  }

  thread enter_combat();
}

function run_open_door_anim(var0, var1, var2, var3, var4, var5, var6) {
  var0 notify("run_open_door_anim");
  var0 endon("run_open_door_anim");
  var0 scripts\engine\utility::ent_flag_wait("door_opening");

  if(isDefined(var0.anim_node)) {
    var7 = var0.anim_node;
  } else {
    var7 = var1;
  }

  if(isDefined(var1.linkedpents)) {
    foreach(var9 in var1.linkedpents) {
      var9.animname = "ai_spawn_door";
      var9 useanimtree(level.scr_animtree[var9.animname]);
      var7 thread scripts\common\anim::anim_single_solo(var9, var3);
      var9 notify("door_opened");
    }
  } else if(isDefined(var1.targetmodels)) {
    foreach(var9 in var1.targetmodels) {
      var9.animname = "ai_spawn_door";
      var9 useanimtree(level.scr_animtree[var9.animname]);
      var7 thread scripts\common\anim::anim_single_solo(var9, var3);
      var9 notify("door_opened");
    }
  } else if(isent(var1)) {
    var1.animname = "ai_spawn_door";
    var1 useanimtree(level.scr_animtree[self.animname]);
    var7 thread scripts\common\anim::anim_single_solo(var1, var3);
    var1 notify("door_opened");
  }

  wait_for_door_anim_end(var1, var4, var5, var6, var7, var3);
}

function wait_for_door_anim_end(var0, var1, var2, var3, var4, var5) {
  level endon("game_ended");
  var0 notify("wait_for_door_anim_end");
  var0 endon("wait_for_door_anim_end");

  foreach(var7 in var4) {
    set_door_state(var7, "opened", var3);
  }

  wait max(0, var1 + 1.25);

  foreach(var7 in var4) {
    set_door_state(var7, "closed", var3);
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

function set_door_state(var0, var1, var2) {
  subway_black_screen(var0);
  var0.current_state = var1;
  var0 scripts\engine\utility::ent_flag_clear("using_intro_anim");

  switch (var1) {
    case "opening":
      var0 scripts\engine\utility::ent_flag_clear("door_closed");
      var0 scripts\engine\utility::ent_flag_clear("door_opened");
      var0 scripts\engine\utility::ent_flag_set("door_opening");
      var0 scripts\engine\utility::ent_flag_clear("door_closing");
      var0 scripts\engine\utility::ent_flag_clear("door_open_started");
      break;
    case "door_closing":
      var0 scripts\engine\utility::ent_flag_clear("door_closed");
      var0 scripts\engine\utility::ent_flag_clear("door_opened");
      var0 scripts\engine\utility::ent_flag_clear("door_opening");
      var0 scripts\engine\utility::ent_flag_set("door_closing");
      var0 scripts\engine\utility::ent_flag_clear("door_open_started");
      break;
    case "opened":
      var0 scripts\engine\utility::ent_flag_clear("door_closed");
      var0 scripts\engine\utility::ent_flag_set("door_opened");
      var0 scripts\engine\utility::ent_flag_clear("door_opening");
      var0 scripts\engine\utility::ent_flag_clear("door_closing");
      var0 scripts\engine\utility::ent_flag_clear("door_open_started");
      break;
    case "closed":
      var0 scripts\engine\utility::ent_flag_set("door_closed");
      var0 scripts\engine\utility::ent_flag_clear("door_opened");
      var0 scripts\engine\utility::ent_flag_clear("door_opening");
      var0 scripts\engine\utility::ent_flag_clear("door_closing");
      var0 scripts\engine\utility::ent_flag_clear("door_open_started");
      var0.last_ai_spawn_anim = undefined;
      var0.spawners_using = 0;
      var0 scripts\engine\utility::ent_flag_clear("max_spawns_reached");

      if(isDefined(var2)) {
        mounted(var2);
        var2.door = undefined;
        var2.used_recently = undefined;
        var2.count = 0;
      }

      break;
    case "open_started":
      var0 scripts\engine\utility::ent_flag_clear("door_closed");
      var0 scripts\engine\utility::ent_flag_clear("door_opened");
      var0 scripts\engine\utility::ent_flag_clear("door_opening");
      var0 scripts\engine\utility::ent_flag_clear("door_closing");
      var0 scripts\engine\utility::ent_flag_set("door_open_started");
      break;
  }
}

function get_follow_anim_from_breach_anim(var0) {
  switch (var0) {
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

function get_door_anim_from_ai_anim(var0) {
  if(!isDefined(var0)) {
    return "sdr_com_inter_rdoor_wall_kick_ex_run_door";
  }

  switch (var0) {
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

  return var0;
}

function _open_door(var0, var1) {
  var0.angles = var0.vopenedangles;

  if(isDefined(var0.linkedpents)) {
    set_door_state(var0, "opening");

    foreach(var3 in var0.linkedpents) {
      if(isDefined(var3.collision)) {
        var3.collision connectpaths();

        if(istrue(var1)) {
          var3.collision delete();
        }
      }

      var3 rotateTo(var0.angles, 0.75);
    }

    wait 0.75;
  }

  set_door_state(var0, "opened");
  scripts\cp\coop_personal_ents::update_special_mode_for_all_players();
}

function add_global_spawn_function(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(level.global_ai_func_array)) {
    level.global_ai_func_array = [];
  }

  if(!isDefined(level.global_ai_func_array[var0])) {
    level.global_ai_func_array[var0] = [];
  }

  var6 = [];
  GscBinSkip0(0x2e, "function", var1);
}

function remove_global_spawn_function(var0, var1) {
  var2 = [];

  for(var3 = 0; var3 < level.global_ai_func_array[var0].size; var3++) {
    if(level.global_ai_func_array[var0][var3]["function"] != var1) {
      var2 = level.global_ai_func_array[var0][var3];
    }
  }

  level.global_ai_func_array[var0] = var2;
}

function exists_global_spawn_function(var0, var1) {
  if(!isDefined(level.global_ai_func_array)) {
    return false;
  }

  for(var2 = 0; var2 < level.global_ai_func_array[var0].size; var2++) {
    if(level.global_ai_func_array[var0][var2]["function"] == var1) {
      return true;
    }
  }

  return false;
}

function init_passive_wave_struct() {
  var0 = spawnStruct();
  var0.high_threshold = undefined;
  var0.low_threshold = undefined;
  var0.spawn_window_time = 5;
  var0.wave_spawn_time = 15;
  var0.min_count = 0;
  var0.max_count = 48;
  var0.wave_time_between_spawns = 1;
  var0.disable_wave_hud = 0;
  self.passive_wave_settings = var0;
}

function override_passive_wave_spawning_spawners(var0) {
  if(!scripts\engine\utility::array_contains(self.wave_spawner_overrides, var0)) {
    self.wave_spawner_overrides[self.wave_spawner_overrides.size] = var0;
    return;
  }
}

function remove_passive_wave_spawning_spawner_override(var0) {
  if(scripts\engine\utility::array_contains(self.wave_spawner_overrides, var0)) {
    self.wave_spawner_overrides = scripts\engine\utility::array_remove(self.wave_spawner_overrides, var0);
    return;
  }
}

function add_spawners_to_passive_wave_spawning(var0) {
  if(!scripts\engine\utility::array_contains(self.requested_spawners, var0)) {
    var1 = scripts\engine\utility::getStructArray(var0, "targetname");

    if(var1.size > 0) {
      self.requested_spawners[self.requested_spawners.size] = var0;
      scripts\engine\utility::array_thread(var1, &spawner_init);
      return;
    }

    return;
  }
}

function remove_spawners_from_passive_wave_spawning(var0) {
  if(scripts\engine\utility::array_contains(self.requested_spawners, var0)) {
    self.requested_spawners = scripts\engine\utility::array_remove(self.requested_spawners, var0);
    return;
  }
}

function battle_stations(var0) {
  if(!scripts\engine\utility::array_contains(self.ref_12c43, var0)) {
    var1 = scripts\engine\utility::getStructArray(var0, "targetname");

    if(var1.size > 0) {
      self.ref_12c43[self.ref_12c43.size] = var0;
      scripts\engine\utility::array_thread(var1, &spawner_init);
      return;
    }

    return;
  }
}

function ref_12bfb(var0) {
  if(scripts\engine\utility::array_contains(self.ref_12c43, var0)) {
    self.ref_12c43 = scripts\engine\utility::array_remove(self.ref_12c43, var0);
    return;
  }
}

function set_passive_wave_high_threshold(var0) {
  if(isDefined(self.passive_wave_settings)) {
    self.passive_wave_settings.high_threshold = var0;
    return;
  }
}

function add_spawn_scoring_poi(var0, var1, var2) {
  var1 = define_var_if_undefined(var1, 1024);
  var2 = define_var_if_undefined(var2, 2048);
  var3 = spawnStruct();
  var3.origin = var0;
  var3.angles = (0, 0, 0);
  var3.radius = var1;
  var3.activation_radius_sq = var2 * var2;
  self.spawn_scoring_pois[self.spawn_scoring_pois.size] = var3;
}

function remove_spawn_scoring_poi(var0) {
  var1 = self.spawn_scoring_pois;

  for(var2 = 0; var2 < var1.size; var2++) {
    if(var1[var2].origin == var0) {
      self.spawn_scoring_pois = scripts\engine\utility::array_remove(var1, var1[var2]);
    }
  }
}

function init_airlock_buttons(var0, var1) {
  if(!isDefined(self.aitype_override)) {
    self.aitype_override = [];
    self.aitype_override_weights = [];
    self.aitype_override_cumulative_weight = 0;
  }

  for(var2 = 0; var2 < var0.size; var2++) {
    self.aitype_override[self.aitype_override.size] = var0[var2];
    var3 = define_var_if_undefined(var1[var2], 10);
    self.aitype_override_weights[self.aitype_override_weights.size] = var3;
    self.aitype_override_cumulative_weight += var3;
  }
}

function remove_aitype_spawner_override(var0) {
  if(isDefined(self.aitype_override)) {
    var1 = self.aitype_override;
    var2 = self.aitype_override_weights;

    for(var3 = 0; var3 < var1.size; var3++) {
      if(var1[var3] == var0) {
        self.aitype_override = scripts\engine\utility::array_remove(var1, var1[var3]);
        self.aitype_override_weights = scripts\engine\utility::array_remove_index(var2, var3);
        self.aitype_override_cumulative_weight -= var2[var3];
      }
    }

    return;
  }
}

function get_passive_wave_high_threshold(var0, var1) {
  if(getdvarint("scr_wave_high_threshold", -1) != -1) {
    return getdvarint("scr_wave_high_threshold");
  }

  if(isDefined(self.passive_wave_settings) && isDefined(self.passive_wave_settings.high_threshold)) {
    return self.passive_wave_settings.high_threshold;
  }

  if(isDefined(var1)) {
    return process_module_var(var0, var1);
  }

  return undefined;
}

function set_passive_wave_low_threshold(var0) {
  if(isDefined(self.passive_wave_settings)) {
    self.passive_wave_settings.low_threshold = var0;
    return;
  }
}

function get_passive_wave_low_threshold(var0, var1) {
  if(getdvarint("scr_wave_low_threshold", -1) != -1) {
    return getdvarint("scr_wave_low_threshold");
  }

  if(isDefined(self.passive_wave_settings) && isDefined(self.passive_wave_settings.low_threshold)) {
    return self.passive_wave_settings.low_threshold;
  }

  if(isDefined(var1)) {
    return process_module_var(var0, var1);
  }

  return undefined;
}

function set_passive_spawn_window_time(var0) {
  if(isDefined(self.passive_wave_settings)) {
    self.passive_wave_settings.spawn_window_time = var0;
    return;
  }
}

function get_passive_spawn_window_time(var0) {
  if(getdvarint("scr_spawn_window_time", 0) != 0) {
    return getdvarint("scr_spawn_window_time");
  }

  if(isDefined(self.passive_wave_settings) && isDefined(self.passive_wave_settings.spawn_window_time)) {
    return self.passive_wave_settings.spawn_window_time;
  }

  return 5;
}

function set_passive_wave_spawn_time(var0) {
  if(isDefined(self.passive_wave_settings)) {
    self.passive_wave_settings.wave_spawn_time = var0;
    return;
  }
}

function get_passive_wave_spawn_time(var0) {
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

function set_ambient_min_count(var0) {
  if(isDefined(self.passive_wave_settings)) {
    self.passive_wave_settings.min_count = var0;
    return;
  }
}

function get_ambient_min_count(var0, var1) {
  if(getdvarint("scr_wave_min_count", -1) != -1) {
    return getdvarint("scr_wave_min_count");
  }

  if(isDefined(self.passive_wave_settings) && isDefined(self.passive_wave_settings.min_count)) {
    return self.passive_wave_settings.min_count;
  }

  return var1;
}

function set_ambient_max_count(var0) {
  if(isDefined(self.passive_wave_settings)) {
    self.passive_wave_settings.max_count = var0;
    return;
  }
}

function get_ambient_max_count(var0, var1) {
  if(getdvarint("scr_wave_max_count", -1) != -1) {
    return getdvarint("scr_wave_max_count");
  }

  if(isDefined(self.passive_wave_settings) && isDefined(self.passive_wave_settings.max_count)) {
    return self.passive_wave_settings.max_count;
  }

  return var1;
}

function get_spawn_time_from_wave(var0, var1) {
  if(isDefined(self.wave_time_between_spawns)) {
    return self.wave_time_between_spawns;
  }

  return var1;
}

function regenhealthaddfunc(var0, var1) {
  if(isDefined(var0.min_count)) {
    return int(var0.min_count);
  }

  return var1;
}

function get_wave_high_threshold(var0) {
  if(isDefined(var0.high_threshold)) {
    return int(var0.high_threshold);
  }

  return int(var0.spawn_wave_total);
}

function get_current_wave_ref() {
  if(isDefined(level.first_wave_override)) {
    var0 = level.first_wave_override;
    level.first_wave_override = undefined;
    return var0;
  }

  if(isDefined(self.wave_reference_override)) {
    var0 = self.wave_reference_override;
    self.wave_reference_override = undefined;
    return var0;
  }

  if(isDefined(self.wave_reference)) {
    return self.wave_reference;
  }

  return undefined;
}

function set_wave_ref_override(var0) {
  if(trophy_protection_success("wave_spawning")) {
    run_func_on_group_by_groupname("wave_spawning", [ &battle_tracks_clearbattletracks, var0]);
    var1 = get_module_structs_by_groupname("wave_spawning");

    if(isDefined(var1) && var1.size > 0) {
      var1[0] thread scripts\cp\cp_wave_spawning::start_wave();
    }
  } else {
    level.first_wave_override = var1;
    var1 = run_spawn_module("wave_spawning");
  }

  return var1;
}

function battle_tracks_clearbattletracks(var0, var1) {
  level notify("timeout_wave");
  var0 notify("wave_spawn");
  var0 notify("wave_go_kamikaze");
  toggle_force_stop_wave_from_groupname("wave_spawning", undefined, "new_wave_starting");
  toggle_force_stop_wave_from_groupname("wave_paratroopers", undefined, "new_wave_starting");
  run_func_on_group_by_groupname("wave_spawning", [ &toggle_kamikaze_for_group, undefined]);
  set_wave_settings_for_all_with_groupname("wave_spawning", var1, var0.wave_reference, var0.last_wave_num);
  var0.next_wave = var1;
  var0.wave_reference_override = var1;
}

function trophy_protection_success(var0) {
  return isDefined(level.active_spawn_module_structs[var0]);
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

function get_module_structs_by_groupname(var0, var1) {
  var2 = [];

  if(!isarray(var0)) {
    var0 = [var0];
  }

  if(istrue(var1)) {
    var3 = getarraykeys(level.spawn_module_structs_memory);
    var4 = level.spawn_module_structs_memory;
  } else {
    var3 = getarraykeys(level.active_spawn_module_structs);
    var4 = level.active_spawn_module_structs;
  }

  for(var5 = 0; var5 < var4.size; var5++) {
    var6 = var4[var3[var5]];

    if(isarray(var6)) {
      for(var7 = 0; var7 < var6.size; var7++) {
        var8 = var6[var7];

        for(var9 = 0; var9 < var2.size; var9++) {
          if(var8.group_name == var2[var9]) {
            var4 = var8;
          }
        }
      }

      continue;
    }

    for(var9 = 0; var9 < var2.size; var9++) {
      if(var6.group_name == var2[var9]) {
        var4 = var6;
      }
    }
  }

  return var4;
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

    for(var0 = 0; var0 < level.players.size; var0++) {
      level.players[var0] thread scripts\cp\cp_hud_message::showsplash("cp_wave_started", level.logfriendlyfire, undefined);
      level.players[var0] setplayerdata("cp", "alienSession", "waveNum", level.logfriendlyfire);
      scripts\cp\cp_persistence::update_player_career_highest_wave(level.players[var0], level.logfriendlyfire, level.players.size);
    }
  }

  wait 2;
}

function turn_off_steam() {
  return !istrue(self.disable_wave_hud);
}

function set_wave_settings() {
  if(isDefined(level.wave_table)) {
    var0 = level.wave_table;
  } else if(getDvar("MOLPOSLOMO") == "cp_wave_sv") {
    var0 = "cp/" + getDvar("NSQLTTMRMP") + "_wave_table.csv";
  } else {
    var0 = "cp/cp_donetsk_wave_table.csv";
  }

  if(getdvarint("scr_use_wave_table", 1) && tableexists(var0)) {
    var1 = var0;
    var2 = "wave_spawning";

    if(isDefined(level.spawn_module_structs_memory[var2])) {
      for(var3 = 0; var3 < level.spawn_module_structs_memory[var2].size; var3++) {
        var4 = level.spawn_module_structs_memory[var2][var3];
        var5 = get_current_wave_ref(var4);
        var4.valid_vehicles = [];
        var4.valid_vehicles["lbravo_carrier"] = int(tablelookup(var1, 0, var5, 15));
        var4.valid_vehicles["mindia8"] = int(tablelookup(var1, 0, var5, 16));
        var4.valid_vehicles["mindia8_jugg"] = int(tablelookup(var1, 0, var5, 17));
        var4.valid_vehicles["attack_heli"] = int(tablelookup(var1, 0, var5, 19));

        if(scripts\engine\utility::array_sum(var4.valid_vehicles) > 0) {
          var4.wave_use_vehicles = 1;
        }

        var4.spawn_aitype_counts = [];
        var4.spawn_aitype_counts["ar"] = int(tablelookup(var1, 0, var5, 1));
        var4.spawn_aitype_counts["ar_heavy"] = int(tablelookup(var1, 0, var5, 2));
        var4.spawn_aitype_counts["ar_heavy_laser"] = int(tablelookup(var1, 0, var5, 3));
        var4.spawn_aitype_counts["smg"] = int(tablelookup(var1, 0, var5, 4));
        var4.spawn_aitype_counts["smg_heavy"] = int(tablelookup(var1, 0, var5, 5));
        var4.spawn_aitype_counts["shotgun"] = int(tablelookup(var1, 0, var5, 6));
        var4.spawn_aitype_counts["shotgun_heavy"] = int(tablelookup(var1, 0, var5, 7));
        var4.spawn_aitype_counts["rpg"] = int(tablelookup(var1, 0, var5, 8));
        var4.spawn_aitype_counts["lmg"] = int(tablelookup(var1, 0, var5, 9));
        var4.spawn_aitype_counts["lmg_heavy"] = int(tablelookup(var1, 0, var5, 10));
        var4.spawn_aitype_counts["sniper"] = int(tablelookup(var1, 0, var5, 11));
        var4.spawn_aitype_counts["goliath"] = int(tablelookup(var1, 0, var5, 12));
        var4.spawn_aitype_counts["suicidebomber"] = int(tablelookup(var1, 0, var5, 13));
        var4.spawn_aitype_counts["juggernaut"] = int(tablelookup(var1, 0, var5, 14));
        var4.spawn_aitype_counts = remove_invalid_aitypes(var4);
        var4.wave_difficulty = int(tablelookup(var1, 0, var5, 22));
        var4.high_threshold = int(tablelookup(var1, 0, var5, 23));
        var4.min_count = int(tablelookup(var1, 0, var5, 24));
        var4.ref_11e6b = int(tablelookup(var1, 0, var5, 25));
        var4.timeout_after_min_count = int(tablelookup(var1, 0, var5, 26));
        var4.next_wave = tablelookup(var1, 0, var5, 29);
        var4.use_only_veh_spawners = int(tablelookup(var1, 0, var5, 32));
        var4.paratroopers_allowed = int(tablelookup(var1, 0, var5, 20));
        var4.ref_1451a = int(tablelookup(var1, 0, var5, 21));
        var6 = float(tablelookup(var1, 0, var5, 30));
        var4.wave_time_between_spawns = scripts\engine\utility::ter_op(var6 > 0, var6, 1);

        if(scripts\cp\utility::turn_off_sniper_laser()) {
          var4.disable_wave_hud = int(tablelookup(var1, 0, var5, 31));
        } else {
          var4.disable_wave_hud = 1;
        }

        var4.spawn_wave_total = scripts\engine\utility::array_sum(var4.spawn_aitype_counts) + var4.paratroopers_allowed * 8;
        var4.ref_13be5 = 0;
        var4.requested_spawners = [];
        var7 = strtok(tablelookup(var1, 0, var5, 27), ",");

        if(isDefined(var7) && var7.size > 0) {
          for(var8 = 0; var8 < var7.size; var8++) {
            add_spawners_to_passive_wave_spawning(var4, var7[var8]);
          }
        }

        var4.ref_12c43 = [];
        var7 = strtok(tablelookup(var1, 0, var5, 28), ",");

        if(isDefined(var7) && var7.size > 0) {
          for(var8 = 0; var8 < var7.size; var8++) {
            battle_stations(var4, var7[var8]);
          }
        }
      }

      return;
    }

    return;
  }
}

function ignoredeathsdoor(var0, var1) {
  if(isDefined(level.spawn_module_structs_memory[var1])) {
    var2 = level.spawn_module_structs_memory[var1][0];
    var0.high_threshold = var2.high_threshold;
    var0.ref_11e6b = var2.ref_11e6b;
    var0.min_count = var2.min_count;
    var0.disable_wave_hud = var2.disable_wave_hud;
    return;
  }

  var0.spawn_wave_total = var0.totalspawns;
}

function pressure_stability_event_init(var0) {
  var1 = [];

  if(isDefined(self.script_type) && isDefined(var0) && isarray(var0) && var0.size > 0) {
    if(!isarray(self.script_type)) {
      var2 = strtok(self.script_type, ",");
      self.script_type = [];

      for(var3 = 0; var3 < var2.size; var3++) {
        self.script_type[self.script_type.size] = var2[var3];
      }
    }

    for(var3 = 0; var3 < self.script_type.size; var3++) {
      if(scripts\engine\utility::array_contains(var0, self.script_type[var3])) {
        var1 = self.script_type[var3];
      }
    }

    return var1;
  }

  return var1;
}

function pressure_stability_event_start() {
  var0 = [];
  var1 = getarraykeys(self.valid_vehicles);

  for(var2 = 0; var2 < var1.size; var2++) {
    if(self.valid_vehicles[var1[var2]] > 0) {
      var0 = var1[var2];
    }
  }

  if(var0.size > 0) {
    return var0;
  }

  return undefined;
}

function remove_invalid_aitypes() {
  var0 = getarraykeys(self.spawn_aitype_counts);

  for(var1 = 0; var1 < level.spawn_module_structs_memory[self.group_name].size; var1++) {
    var2 = level.spawn_module_structs_memory[self.group_name][var1];

    for(var3 = 0; var3 < var0.size; var3++) {
      var4 = var0[var3];

      if(isDefined(var2.spawn_aitype_counts[var4]) && var2.spawn_aitype_counts[var4] < 1) {
        var2.spawn_aitype_counts[var4] = undefined;
      }
    }
  }

  return self.spawn_aitype_counts;
}