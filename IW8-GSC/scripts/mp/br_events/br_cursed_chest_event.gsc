/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\br_events\br_cursed_chest_event.gsc
**********************************************************/

function init() {
  test_bag_pickup();
  initvfx();
  initloottables();
  thread tracegroundheightexfil();
  scripts\engine\scriptable::scriptable_addusedcallback(&scriptable_used);
  _testing_ending::teamplunderexfiltimer();
  access_card::initzombievariables();
  _keypadscriptableused_bunkeralt::init();
  _ispointinbadarea::init();
  _keypadscriptableused::init();
  _initignoredtabspergamemode::init();
  scripts\mp\utility\sound::besttime("br_event_cursed_chest");
  thread spawncursedchestinmap();
  scripts\cp_mp\utility\script_utility::registersharedfunc("zombie", "hitByGasZombie", &onhitbypoisonzombie);
}

function scriptable_used(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0) || !isDefined(var_0.type) || var_0.type != "br_loot_cursed_chest") {
    return;
  }

  var_0 setscriptablepartstate("body", "phase_0");
  var_0 notify("player_interacted", var_3);
}

function initvfx() {
  if(isDefined(level.cursed_chest_vfx_init)) {
    return;
  }

  level._effect["cursed_chest_ring"] = loadfx("vfx/iw8_br/island/equip/cursed_chest/vfx_chest_fire_ring_rnr_01");
  level._effect["cursed_chest_charged_state_1"] = loadfx("vfx/iw8_br/island/equip/cursed_chest/vfx_chest_charged_state_25");
  level._effect["cursed_chest_charged_state_2"] = loadfx("vfx/iw8_br/island/equip/cursed_chest/vfx_chest_charged_state_50");
  level._effect["cursed_chest_charged_state_3"] = loadfx("vfx/iw8_br/island/equip/cursed_chest/vfx_chest_charged_state_75");
  level._effect["cursed_chest_explosion"] = loadfx("vfx/iw8_br/island/equip/cursed_chest/vfx_chest_explosion");
  level._effect["cursed_chest_zombie_death"] = loadfx("vfx/iw8_br/island/equip/cursed_chest/vfx_chest_nrg_zombie_death");
  level._effect["cursed_chest_zombie_soul_absorb"] = loadfx("vfx/iw8_br/island/equip/cursed_chest/vfx_chest_nrg_zombie_suction_chd_01");
  level._effect["cursed_chest_zombie_soul_absorb_stop"] = loadfx("vfx/iw8_br/island/equip/cursed_chest/vfx_chest_nrg_zombie_chest_reaction");
  level._effect["cursed_chest_super_zombie_flare"] = loadfx("vfx/iw8_br/island/equip/cursed_chest/vfx_chest_super_zombie_upgrade_flare");
  level._effect["cursed_chest_super_zombie_pre_flare"] = loadfx("vfx/iw8_br/island/equip/cursed_chest/vfx_chest_super_zombie_pre_upgrade_flare");
  level._effect["cursed_chest_super_zombie_helmet_distortion"] = loadfx("vfx/iw8_br/island/equip/cursed_chest/vfx_chest_super_zombie_helmet_armor");
  level._effect["cursed_chest_super_zombie_helmet_break"] = loadfx("vfx/iw8_br/island/equip/cursed_chest/vfx_chest_super_zombie_helmet_armor_break");
  level.cursed_chest_vfx_init = 1;
}

function tracegroundheightexfil() {
  waitframe();

  if(!isDefined(game["dialogForAllTeams"])) {
    game["dialogForAllTeams"] = [];
  }

  register_cursed_chest_dialogue("cursedchest_charge_100", "dx_bra_bchr_cursed_chest_charge_100");
  register_cursed_chest_dialogue("cursedchest_charge_75", "dx_bra_bchr_cursed_chest_charge_75");
  register_cursed_chest_dialogue("cursedchest_charge_50", "dx_bra_bchr_cursed_chest_charge_50");
  register_cursed_chest_dialogue("cursedchest_charge_25", "dx_bra_bchr_cursed_chest_charge_25");
  register_cursed_chest_dialogue("cursedchest_enemy_join", "dx_bra_bchr_cursed_enemy_join");
  register_cursed_chest_dialogue("cursedchest_event_complete", "dx_bra_bchr_cursed_event_complete");
  register_cursed_chest_dialogue("cursedchest_event_failed", "dx_bra_bchr_cursed_event_failed");
  register_cursed_chest_dialogue("cursedchest_event_start", "dx_bra_bchr_cursed_event_start");
}

function register_cursed_chest_dialogue(var_0, var_1) {
  game["dialog"][var_0] = var_1;
  game["dialogForAllTeams"][var_0] = 1;
}

function initloottables() {
  _handlevehiclerepair::init();
  var_0 = [];
  var_0["brloot_plunder_cash_uncommon_1"] = 3;
  var_0["brloot_plunder_cash_uncommon_2"] = 0.8;
  var_0["brloot_plunder_cash_uncommon_3"] = 0.6;
  _handlevehiclerepair::ref_11A45("cursed_chest_event_cash", var_0);
  var_0 = [];
  var_0["brloot_killstreak_clusterstrike"] = 1;
  var_0["brloot_killstreak_precision_airstrike"] = 1;
  var_0["brloot_killstreak_uav"] = 1;
  _handlevehiclerepair::ref_11A45("cursed_chest_event_killstreaks", var_0);
  var_0 = [];
  var_0["brloot_specialist_bonus"] = 0.5;
  var_0["brloot_perk_point_shrapnel"] = 0.1;
  var_0["brloot_perk_point_tune_up"] = 0.1;
  var_0["brloot_perk_point_hardline"] = 0.1;
  var_0["brloot_perk_point_eod"] = 0.1;
  var_0["brloot_perk_point_kill_chain"] = 0.1;
  var_0["brloot_perk_point_tracker"] = 0.1;
  var_0["brloot_perk_point_amped"] = 0.1;
  var_0["brloot_perk_point_double_time"] = 0.1;
  var_0["brloot_perk_point_cold_blooded"] = 0.1;
  var_0["brloot_perk_point_quick_fix"] = 0.1;
  var_0["brloot_perk_point_tempered"] = 0.1;
  var_0["brloot_perk_point_ghost"] = 0.1;
  var_0["brloot_perk_point_engineer"] = 0.1;
  var_0["brloot_perk_point_combat_scout"] = 0.1;
  var_0["brloot_perk_point_battle_hardened"] = 0.1;
  var_0["brloot_perk_point_serpentine"] = 0.1;
  var_0["brloot_perk_point_high_alert"] = 0.1;
  var_0["brloot_perk_point_pointman"] = 0.1;
  var_0["brloot_perk_point_restock"] = 0.1;
  var_0["brloot_perk_point_scavenger"] = 0.1;
  _handlevehiclerepair::ref_11A45("cursed_chest_event_perk_tokens", var_0);
  var_0 = [];
  var_0["nothing"] = 1;
  var_0["brloot_offhand_numbers_grenade"] = 1;
  var_0["brloot_self_revive"] = 0.5;
  _handlevehiclerepair::ref_11A45("cursed_chest_event_equipment", var_0);
  var_0 = [];
  var_0["nothing"] = 1;
  var_0["brloot_rumble_powerup_double_points"] = 0.06;
  var_0["brloot_rumble_powerup_speed_boost"] = 0.06;
  var_0["brloot_rumble_powerup_killmonger"] = 0.06;
  _handlevehiclerepair::ref_11A45("cursed_chest_event_zombie_death_powerups", var_0);
  var_0 = [];
  var_0["nothing"] = 1;
  var_0["brloot_ammo_killer_based"] = 0.8;
  _handlevehiclerepair::ref_11A45("cce_on_zombie_death_ammo_killer_based", var_0);
  var_0 = [];
  var_0["nothing"] = 2.5;
  var_0["brloot_plunder_cash_common_1"] = 1;
  _handlevehiclerepair::ref_11A45("cce_on_zombie_death_cash", var_0);
  var_0 = [];
  var_0["nothing"] = 3;
  var_0["brloot_armor_plate"] = 0.8;
  _handlevehiclerepair::ref_11A45("cce_on_zombie_death_gear", var_0);
  var_0 = [];
  var_0["nothing"] = 35;
  var_0["brloot_perk_point_shrapnel"] = 0.1;
  var_0["brloot_perk_point_tune_up"] = 0.1;
  var_0["brloot_perk_point_hardline"] = 0.1;
  var_0["brloot_perk_point_eod"] = 0.1;
  var_0["brloot_perk_point_kill_chain"] = 0.1;
  var_0["brloot_perk_point_tracker"] = 0.1;
  var_0["brloot_perk_point_amped"] = 0.1;
  var_0["brloot_perk_point_double_time"] = 0.1;
  var_0["brloot_perk_point_cold_blooded"] = 0.1;
  var_0["brloot_perk_point_quick_fix"] = 0.1;
  var_0["brloot_perk_point_tempered"] = 0.1;
  var_0["brloot_perk_point_ghost"] = 0.1;
  var_0["brloot_perk_point_engineer"] = 0.1;
  var_0["brloot_perk_point_combat_scout"] = 0.1;
  var_0["brloot_perk_point_battle_hardened"] = 0.1;
  var_0["brloot_perk_point_serpentine"] = 0.1;
  var_0["brloot_perk_point_high_alert"] = 0.1;
  var_0["brloot_perk_point_pointman"] = 0.1;
  var_0["brloot_perk_point_restock"] = 0.1;
  var_0["brloot_perk_point_scavenger"] = 0.1;
  _handlevehiclerepair::ref_11A45("cce_on_zombie_death_perk_tokens", var_0);
}

function test_bag_pickup() {
  if(isDefined(level.cursed_chest_dvar_init)) {
    return;
  }

  if(!isDefined(level.cursed_chest_event)) {
    level.cursed_chest_event = spawnStruct();
    level.cursed_chest_event.registered_spawn_locations = [];
    level.cursed_chest_event.instances = [];
  }

  level.cursed_chest_event.participation_radius = getdvarint("scr_cursed_chest_participation_radius", 1700);
  level.cursed_chest_event.timeout_duration = getdvarint("scr_cursed_chest_event_timeout_duration", 240);
  level.cursed_chest_event.ref_129E0 = getdvarint("scr_cursed_chest_harvest_radius", 2000);
  level.cursed_chest_event.radius_height = getdvarint("scr_cursed_chest_harvest_radius_height", 400);
  level.cursed_chest_event.score_to_complete = getdvarint("scr_cursed_chest_event_points_to_complete", 25);
  level.cursed_chest_event.max_instances_to_spawn = getdvarint("scr_cursed_chest_max_instances_to_spawn", 2);
  level.cursed_chest_event.phase_0_start_at_score = getdvarint("scr_cursed_chest_phase_1_start_at_score", 0);
  level.cursed_chest_event.phase_1_start_at_score = getdvarint("scr_cursed_chest_phase_2_start_at_score", 10);
  level.cursed_chest_event.phase_2_start_at_score = getdvarint("scr_cursed_chest_phase_3_start_at_score", 15);
  level.cursed_chest_event.phase_3_start_at_score = getdvarint("scr_cursed_chest_phase_4_start_at_score", 20);
  level.cursed_chest_event.start_phase = getdvarint("scr_cursed_chest_start_phase", 0);
  level.cursed_chest_event.zombie_count_max_per_instance = getdvarint("scr_cursed_chest_event_zombie_count_max_per_instance", 10);
  level.cursed_chest_event.zombie_spawn_radius_max = getdvarint("scr_cursed_chest_event_zombie_spawn_radius_max", 600);
  level.cursed_chest_event.zombie_spawn_radius_min = getdvarint("scr_cursed_chest_event_zombie_spawn_radius_min", 300);
  level.cursed_chest_event.super_zombie_score_yield = getdvarint("scr_cursed_chest_event_super_zombie_score_yield", 3);
  level.cursed_chest_event.super_zombie_health_value = getdvarint("scr_cursed_chest_event_super_zombie_health_value", 1000);
  level.cursed_chest_event.super_zombie_armor_value = getdvarint("scr_cursed_chest_event_super_zombie_armor_value", 700);
  level.cursed_chest_event.zombie_types = ["walker", "runner", "sprinter", "gas_thrower", "weakpoint"];
  level.cursed_chest_event.zombie_types_spawn_ratio_phase_0 = [];
  level.cursed_chest_event.zombie_types_spawn_ratio_phase_0["walker"] = getdvarfloat("scr_cursed_chest_event_spawn_ratio_walker_phase_0", 1);
  level.cursed_chest_event.zombie_types_spawn_ratio_phase_1 = [];
  level.cursed_chest_event.zombie_types_spawn_ratio_phase_1["walker"] = getdvarfloat("scr_cursed_chest_event_spawn_ratio_walker_phase_1", 0.4);
  level.cursed_chest_event.zombie_types_spawn_ratio_phase_1["runner"] = getdvarfloat("scr_cursed_chest_event_spawn_ratio_runner_phase_1", 0.6);
  level.cursed_chest_event.zombie_types_spawn_ratio_phase_2 = [];
  level.cursed_chest_event.zombie_types_spawn_ratio_phase_2["walker"] = getdvarfloat("scr_cursed_chest_event_spawn_ratio_walker_phase_2", 0.2);
  level.cursed_chest_event.zombie_types_spawn_ratio_phase_2["runner"] = getdvarfloat("scr_cursed_chest_event_spawn_ratio_runner_phase_2", 0.8);
  level.cursed_chest_event.zombie_types_spawn_ratio_phase_2["gas_thrower"] = getdvarfloat("scr_cursed_chest_event_spawn_ratio_gas_thrower_phase_2", 0.9);
  level.cursed_chest_event.zombie_types_spawn_ratio_phase_3 = [];
  level.cursed_chest_event.zombie_types_spawn_ratio_phase_3["walker"] = getdvarfloat("scr_cursed_chest_event_spawn_ratio_walker_phase_3", 0.2);
  level.cursed_chest_event.zombie_types_spawn_ratio_phase_3["runner"] = getdvarfloat("scr_cursed_chest_event_spawn_ratio_runner_phase_3", 0.5);
  level.cursed_chest_event.zombie_types_spawn_ratio_phase_3["gas_thrower"] = getdvarfloat("scr_cursed_chest_event_spawn_ratio_gas_thrower_phase_3", 0.9);
  level.cursed_chest_event.zombie_type_spawn_ratio_phases = [];
  level.cursed_chest_event.zombie_type_spawn_ratio_phases[0] = level.cursed_chest_event.zombie_types_spawn_ratio_phase_0;
  level.cursed_chest_event.zombie_type_spawn_ratio_phases[1] = level.cursed_chest_event.zombie_types_spawn_ratio_phase_1;
  level.cursed_chest_event.zombie_type_spawn_ratio_phases[2] = level.cursed_chest_event.zombie_types_spawn_ratio_phase_2;
  level.cursed_chest_event.zombie_type_spawn_ratio_phases[3] = level.cursed_chest_event.zombie_types_spawn_ratio_phase_3;
  level.cursed_chest_event.super_zombie_spawn_chance_for_phase = [];
  level.cursed_chest_event.super_zombie_spawn_chance_for_phase[0] = getdvarfloat("scr_cursed_chest_event_super_zombie_spawn_chance_phase", 0.05);
  level.cursed_chest_event.super_zombie_spawn_chance_for_phase[1] = getdvarfloat("scr_cursed_chest_event_super_zombie_spawn_chance_phase", 0.15);
  level.cursed_chest_event.super_zombie_spawn_chance_for_phase[2] = getdvarfloat("scr_cursed_chest_event_super_zombie_spawn_chance_phase", 0.2);
  level.cursed_chest_event.super_zombie_spawn_chance_for_phase[3] = getdvarfloat("scr_cursed_chest_event_super_zombie_spawn_chance_phase", 0.25);
  level.cursed_chest_event.debug_show_spawn_nodes = getdvarint("scr_cursed_chest_event_debug_show_spawn_nodes", 0);
  level.cursed_chest_event.debug_show_event_info = getdvarint("scr_cursed_chest_event_debug_show_event_info", 0);
  level.cursed_chest_event.debug_disable_vfx = getdvarint("scr_cursed_chest_event_debug_disable_vfx", 0);
  level.cursed_chest_event.debug_spawn_at_all_registered_locations = getdvarint("scr_cursed_chest_event_debug_spawn_at_all_registered_locations", 0);
  level.cursed_chest_dvar_init = 1;
}

function playvoineventarea(var_0) {
  foreach(var_2 in self.active_participants) {
    if(scripts\mp\utility\player::isreallyalive(var_2)) {
      level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward(var_0, var_2);
    }
  }
}

function spawncursedchest(var_0, var_1, var_2) {
  var_3 = spawnStruct();

  if(istrue(var_2)) {
    var_3.origin = var_0;
  } else {
    var_3.origin = getgroundposition(var_0, 10, 300, 100);
  }

  var_3.angles = var_1;
  var_3.chest = easepower("br_loot_cursed_chest", var_3.origin, var_3.angles + (0, 90, 0));
  var_3.chest.computer_force_player_to_exit = 1;
  level.cursed_chest_event.instances = scripts\engine\utility::array_add(level.cursed_chest_event.instances, var_3);
  thread event_waitforplayerinteraction();
}

function spawncursedchestinmap() {
  level endon("game_ended");

  if(!scripts\mp\flags::playerzombiethermalcleanup("prematch_fade_done")) {
    scripts\mp\flags::gameflaginit("prematch_fade_done", 0);
  }

  while(!scripts\mp\flags::gameflag("prematch_fade_done")) {
    waitframe();
  }

  wait 2;

  switch (level.mapname) {
    case "mp_sm_island_1":
      registereventlocation((9266, -352.5, 399), (0, 60, 0));
      registereventlocation((-6639.5, 503.5, 871), (0, 90, 0));
      var_0 = 1;
      registereventlocation((3114, 6777, 1180), (0, 60, 0), var_0);
      registereventlocation((-1278, 3704, 1365), (0, 195, 0), var_0);
      registereventlocation((-1427, -1055, 186), (0, 105, 0), undefined, 1);
      break;
  }

  if(level.cursed_chest_event.registered_spawn_locations.size <= 0) {
    return;
  }

  var_1 = 0;

  if(level.cursed_chest_event.debug_spawn_at_all_registered_locations) {
    var_1 = level.cursed_chest_event.registered_spawn_locations.size;
  } else {
    var_1 = level.cursed_chest_event.max_instances_to_spawn;
  }

  for(var_2 = 0; var_2 < var_1; var_2++) {
    if(level.cursed_chest_event.registered_spawn_locations.size <= 0) {
      continue;
    }

    var_3 = scripts\engine\utility::random(level.cursed_chest_event.registered_spawn_locations);
    spawncursedchest(var_3.origin, var_3.angles, var_3.b_position_absolute);
    level.cursed_chest_event.registered_spawn_locations = scripts\engine\utility::array_remove(level.cursed_chest_event.registered_spawn_locations, var_3);

    if(!level.cursed_chest_event.debug_spawn_at_all_registered_locations && isDefined(var_3.spawn_group)) {
      foreach(var_5 in level.cursed_chest_event.registered_spawn_locations) {
        if(!isDefined(var_5.spawn_group)) {
          continue;
        }

        if(var_5.spawn_group == var_3.spawn_group) {
          level.cursed_chest_event.registered_spawn_locations = scripts\engine\utility::array_remove(level.cursed_chest_event.registered_spawn_locations, var_5);
        }
      }
    }
  }
}

function registereventlocation(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.origin = var_0;
  var_4.angles = var_1;
  var_4.b_position_absolute = var_3;

  if(isDefined(var_2)) {
    var_4.spawn_group = var_2;
  }

  level.cursed_chest_event.registered_spawn_locations = scripts\engine\utility::array_add(level.cursed_chest_event.registered_spawn_locations, var_4);
}

function event_waitforplayerinteraction() {
  level endon("game_ended");
  self endon("end_event");
  self.event_active = 0;
  thread event_timeoutwatcher();
  self.chest waittill("player_interacted", var_0);

  if(istrue(self.event_pending_to_end)) {
    return;
  }

  self.player_who_activated = var_0;
  self.team_who_activated = var_0.team;
  thread event_startcursedchest();
}

function event_startcursedchest() {
  self.participants = [];
  self.active_participants = [];
  self.event_active = 1;
  self.event_pending_to_end = 0;
  self.current_score = 0;
  self.current_phase = level.cursed_chest_event.start_phase;
  self.phase_score_thresholds = [level.cursed_chest_event.phase_0_start_at_score, level.cursed_chest_event.phase_1_start_at_score, level.cursed_chest_event.phase_2_start_at_score, level.cursed_chest_event.phase_3_start_at_score];
  self.played25chargebark = 0;
  self.played50chargebark = 0;
  self.played75chargebark = 0;
  self.played100chargebark = 0;
  self.currentlyplayingvo = 0;
  event_changephase(self.current_phase);
  self.score_to_complete = level.cursed_chest_event.score_to_complete;
  self.ref_13B97 = gettime();
  self.ref_13B96 = gettime() + level.cursed_chest_event.timeout_duration * 1000;
  self.ref_129E0 = level.cursed_chest_event.ref_129E0;
  self.radius_height = level.cursed_chest_event.radius_height;
  self.points_to_complete = level.cursed_chest_event.points_to_complete;
  self.spawned_zombies = [];
  self.zombie_spawn_radius_max = level.cursed_chest_event.zombie_spawn_radius_max;
  self.zombie_spawn_radius_min = level.cursed_chest_event.zombie_spawn_radius_min;
  self.zombie_spawn_table_for_phase = [];

  foreach(var_2, var_1 in level.cursed_chest_event.zombie_type_spawn_ratio_phases) {
    self.zombie_spawn_table_for_phase[var_2] = event_calculatezombiespawnchances("zombie_spawns_phase_" + var_2, level.cursed_chest_event.zombie_type_spawn_ratio_phases[var_2]);
  }

  self.spawn_nodes = [];
  self.spawn_nodes_selected = [];
  spawnnode_spawnallnodes();
  thread createeventtrigger();
  self.zombiespendingspawn = 0;

  for(var_3 = 0; var_3 < 10; var_3++) {
    thread event_spawnzombiefromspawntable(self.zombie_spawn_table_for_phase[self.current_phase]);
  }

  thread event_zombiereinforcementwatcher();
  thread event_registernearbyplayers();
  playvoineventarea("cursedchest_event_start");
  thread vo_bark_lockout(lookupsoundlength("cursedchest_event_start", 1) / 1000);
  thread event_showsplashafterregistration();
  scripts\common\vehicle_code::vehicle_start_ai_avoidance();
}

function event_showsplashafterregistration() {
  level endon("game_ended");
  self waittill("players_registered");

  foreach(var_1 in self.active_participants) {
    if(!isDefined(var_1)) {
      continue;
    }

    var_1 thread scripts\mp\hud_message::showsplash("cursed_chest_begin");
  }
}

function event_registernearbyplayers() {
  level endon("game_ended");
  waitframe();

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }

    var_2 = distance2dsquared(self.origin, var_1.origin) < squared(level.cursed_chest_event.participation_radius);

    if(var_2) {
      event_registeractiveparticipant(var_1);
    }
  }

  self notify("players_registered");
}

function event_addtoscorecount(var_0) {
  if(self.event_pending_to_end) {
    return;
  }

  if(self.current_score >= level.cursed_chest_event.score_to_complete) {
    return;
  }

  self.current_score = self.current_score + var_0;

  if(!self.currentlyplayingvo) {
    var_1 = self.current_score / level.cursed_chest_event.score_to_complete;

    if(var_1 >= 0.75 && !self.played75chargebark) {
      playvoineventarea("cursedchest_charge_75");
      thread vo_bark_lockout(lookupsoundlength("cursedchest_charge_75", 1) / 1000);
      self.played75chargebark = 1;
      self.played50chargebark = 1;
      self.played25chargebark = 1;
    } else if(var_1 >= 0.5 && !self.played50chargebark) {
      playvoineventarea("cursedchest_charge_50");
      thread vo_bark_lockout(lookupsoundlength("cursedchest_charge_50", 1) / 1000);
      self.played50chargebark = 1;
      self.played25chargebark = 1;
    } else if(var_1 >= 0.25 && !self.played25chargebark) {
      playvoineventarea("cursedchest_charge_25");
      thread vo_bark_lockout(lookupsoundlength("cursedchest_charge_25", 1) / 1000);
      self.played25chargebark = 1;
    }
  }

  var_2 = self.phase_score_thresholds[int(clamp(self.current_phase + 1, 0, self.phase_score_thresholds.size - 1))];
  var_3 = self.phase_score_thresholds.size - 1;
  ui_updateallparticipantshud();

  if(!self.event_pending_to_end && self.current_score >= self.score_to_complete) {
    thread vo_play_completed_sounds();
    thread event_completeevent("complete", 4.0);
    return;
  }

  if(self.current_score >= var_2 && self.current_phase < var_3) {
    event_changephase(self.current_phase + 1);
    thread event_setsuperstatustozombies(self.current_phase);
  }
}

function vo_play_completed_sounds() {
  level endon("game_ended");
  playvoineventarea("cursedchest_charge_100");
  wait lookupsoundlength("cursedchest_charge_100", 1) / 1000;
  playvoineventarea("cursedchest_event_complete");
}

function vo_bark_lockout(var_0) {
  self endon("end_event");
  level endon("game_ended");
  self.currentlyplayingvo = 1;
  wait var_0;
  self.currentlyplayingvo = 0;
}

function event_changephase(var_0) {
  self.current_phase = var_0;
  var_1 = "phase_" + int(var_0 * 25);
  self.chest setscriptablepartstate("body", var_1);
  var_2 = self.phase_score_thresholds[self.current_phase];

  if(self.current_score != var_2) {
    self.current_score = var_2;
    return;
  }
}

function event_completeevent(var_0, var_1) {
  level endon("game_ended");
  self notify("end_event");
  self.event_pending_to_end = 1;

  if(isDefined(var_1)) {
    wait var_1;
  }

  if(!self.event_active) {
    self.chest freescriptable();
    return;
  }

  if(var_0 == "ended_by_gas") {
    self.chest freescriptable();
  }

  thread event_killallzombies();
  self.trigger.mapcircle delete();

  switch (var_0) {
    case "complete":
      foreach(var_3 in self.active_participants) {
        if(!isDefined(var_3)) {
          continue;
        }

        scripts\mp\gametypes\br_quest_util::displayplayersplash(var_3, "cursed_chest_success");
      }

      break;
    case "failed":
      foreach(var_3 in self.active_participants) {
        if(!isDefined(var_3)) {
          continue;
        }

        scripts\mp\gametypes\br_quest_util::displayplayersplash(var_3, "cursed_chest_fail");
      }

      break;
  }

  ui_deleteallparticipantshud();
  scripts\common\vehicle_code::vehicle_stop_ai_avoidance();
  var_7 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 0.1);
  wait var_7;

  switch (var_0) {
    case "complete":
      thread event_spawnrewards();
      break;
    case "failed":
      thread event_resetevent();
      break;
  }

  if(isDefined(self.vfx_charge_state)) {
    self.vfx_charge_state delete();
  }

  level.cursed_chest_event.instances = scripts\engine\utility::array_remove(level.cursed_chest_event.instances, self);
}

function event_resetevent() {
  wait 30;

  if(isDefined(self.chest)) {
    self.chest freescriptable();
  }

  level.cursed_chest_event.instances = scripts\engine\utility::array_remove(level.cursed_chest_event.instances, self);
  spawncursedchest(self.origin, self.angles);
}

function event_timeoutwatcher() {
  level endon("game_ended");
  self endon("end_event");

  for(;;) {
    if(self.event_active && gettime() > self.ref_13B96) {
      thread event_completeevent("failed");
      playvoineventarea("cursedchest_event_failed");
      break;
    }

    if(getdvarint("scr_br_circle_disable") == 0) {
      var_0 = !scripts\mp\gametypes\br_circle::ispointincurrentsafecircle(self.origin);

      if(var_0) {
        thread event_startgasendtimer();
        break;
      }
    }

    wait 1;
  }
}

function event_startgasendtimer() {
  level endon("game_ended");
  self endon("end_event");
  wait 30;
  thread event_completeevent("ended_by_gas");
}

function event_killallzombies() {
  level endon("game_ended");

  foreach(var_1 in self.spawned_zombies) {
    var_1.death_by_cursed_chest = 1;
    thread event_killzombieondelay();
  }
}

function event_killzombieondelay() {
  level endon("game_ended");
  self endon("death");
  wait randomfloatrange(0, 1);
  self dodamage(self.health, self.origin, self, undefined, "MOD_TRIGGER_HURT", undefined);
}

function event_spawnrewards() {
  level endon("game_ended");
  self.chest setscriptablepartstate("body", "opening");
  wait 0.7;
  self.chest setscriptablepartstate("body", "phase_100");
  level thread _handlevehiclerepair::ref_13673("cursed_chest_event_cash", self.origin + (0, 0, 35), 10, 1);
  level thread _handlevehiclerepair::ref_13673("cursed_chest_event_killstreaks", self.origin + (0, 0, 35), 3, 0);
  level thread _handlevehiclerepair::ref_13673("cursed_chest_event_perk_tokens", self.origin + (0, 0, 35), 5, 0);
  level thread _handlevehiclerepair::ref_13673("cursed_chest_event_equipment", self.origin + (0, 0, 35), 1, 0);
}

function createeventtrigger() {
  self.trigger = spawn("trigger_radius", self.origin, 0, self.ref_129E0, self.radius_height);
  scripts\mp\utility\trigger::makeenterexittrigger(self.trigger, &eventtrigger_onenter, &eventtrigger_onexit, undefined, undefined, &eventtrigger_filterfunc);
  self.trigger.event_instance = self;
  self.trigger scripts\mp\gametypes\br_quest_util::init_tactical_boxes(6, 0, 0, self.origin);
  self.trigger scripts\mp\gametypes\br_quest_util::ref_1316F(level.cursed_chest_event.ref_129E0);
}

function eventtrigger_onenter(var_0, var_1) {
  var_2 = var_0;
  event_registeractiveparticipant(var_1.event_instance, var_2, 1);
}

function eventtrigger_onexit(var_0, var_1) {
  var_2 = var_0;
}

function eventtrigger_filterfunc(var_0, var_1) {
  if(isPlayer(var_0) || isbot(var_0)) {
    return false;
  }

  return true;
}

function event_registeractiveparticipant(var_0, var_1) {
  if(!scripts\engine\utility::array_contains(self.participants, var_0)) {
    self.participants = scripts\engine\utility::array_add(self.participants, var_0);

    if(isDefined(var_1) && var_1 && !self.currentlyplayingvo && !self.event_pending_to_end) {
      foreach(var_3 in self.active_participants) {
        if(scripts\mp\utility\player::isreallyalive(var_3) && var_0.team != var_3.team) {
          level thread scripts\mp\gametypes\br_public::dmztut_endgamewithreward("cursedchest_enemy_join", var_3);
        }
      }

      thread vo_bark_lockout(lookupsoundlength("cursedchest_enemy_join", 1) / 1000);
    }
  }

  if(!scripts\engine\utility::array_contains(self.active_participants, var_0)) {
    self.active_participants = scripts\engine\utility::array_add(self.active_participants, var_0);
    thread event_participantwatcher(var_0);
    return;
  }
}

function event_deregisteractiveparticipant(var_0) {
  if(scripts\engine\utility::array_contains(self.active_participants, var_0)) {
    self.active_participants = scripts\engine\utility::array_remove(self.active_participants, var_0);

    if(isDefined(var_0)) {
      if(isDefined(self.trigger.mapcircle)) {
        self.trigger scripts\mp\gametypes\br_quest_util::spawn_dogtags(var_0);
      }

      ui_hideeventhud(var_0);
      return;
    }

    return;
  }
}

function event_participantwatcher(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  if(self.event_pending_to_end) {
    return;
  }

  level endon("game_ended");
  var_0 notify("cursed_chest_end_participant_watcher");
  var_0 endon("cursed_chest_end_participant_watcher");
  var_1 = gettime();
  var_2 = undefined;
  self.trigger scripts\mp\gametypes\br_quest_util::ref_1336A(var_0);
  var_0.cursed_chest_event = self;
  ui_showeventhud(var_0);

  while(!self.event_pending_to_end) {
    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      break;
    }

    var_3 = distance2dsquared(self.origin, var_0.origin);

    if(var_3 >= squared(level.cursed_chest_event.participation_radius)) {
      if(!isDefined(var_2)) {
        var_2 = gettime();
      } else if(gettime() >= var_2 + 10000) {
        break;
      }
    } else if(isDefined(var_2)) {
      var_2 = undefined;
    }

    wait 1;
  }

  if(self.event_pending_to_end) {
    return;
  }

  event_deregisteractiveparticipant(var_0);
}

function event_calculatezombiespawnchances(var_0, var_1) {
  var_2 = [];
  var_3 = 0;

  foreach(var_5 in var_1) {
    var_3 += var_5;
  }

  var_7 = 0;
  var_8 = getarraykeys(var_1);
  var_9 = undefined;

  foreach(var_14, var_5 in var_1) {
    var_2 = [];
    var_11 = var_5 / var_3;

    if(var_7 == 0) {
      var_12 = 0;
      var_13 = var_11;
    } else {
      var_12 = var_9[3];
      var_13 = var_12 + var_11;
    }

    var_2 = [var_5, var_11, var_12, var_13];
    var_9 = var_2[var_14];
    var_7++;
  }

  return var_2;
}

function event_spawnzombiefromspawntable(var_0) {
  if(self.zombiespendingspawn + self.spawned_zombies.size >= level.cursed_chest_event.zombie_count_max_per_instance) {
    return;
  }

  var_1 = randomfloat(1);

  foreach(var_3 in var_0) {
    var_4 = var_3[2];
    var_5 = var_3[3];

    if(var_1 >= var_4 && var_1 <= var_5) {
      self.zombiespendingspawn++;
      thread zombie_spawnagent(scripts\engine\utility::random(self.spawn_nodes_selected), var_6);
      break;
    }
  }
}

function event_setsuperstatustozombies(var_0) {
  foreach(var_2 in self.spawned_zombies) {
    if(var_3 == var_0) {
      return;
    }

    if(istrue(var_2.super_zombie_pending) || istrue(var_2.is_super_zombie)) {
      continue;
    }

    if(!isalive(var_2)) {
      var_0 += 1;
      continue;
    }

    thread zombie_setsuperzombiestatus();
  }
}

function event_zombiereinforcementwatcher() {
  level endon("game_ended");
  self endon("end_event");

  for(;;) {
    if(self.spawned_zombies.size <= 7) {
      var_0 = level.cursed_chest_event.zombie_count_max_per_instance - self.spawned_zombies.size;
      var_1 = randomintrange(1, var_0 + 1);

      for(var_2 = 0; var_2 < var_1; var_2++) {
        thread event_spawnzombiefromspawntable(self.zombie_spawn_table_for_phase[self.current_phase]);
      }
    }

    wait 3;
  }
}

function event_zombietoofarfromeventwatcher() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    var_0 = distance2dsquared(self.origin, self.cursed_chest_event.origin) > squared(2000);

    if(var_0) {
      self.death_by_cursed_chest = 1;
      self dodamage(self.health, self.origin, self, undefined, "MOD_TRIGGER_HURT", undefined);
      break;
    }

    wait 5;
  }
}

function zombie_spawnagent(var_0, var_1, var_2) {
  level endon("game_ended");
  self endon("end_event");

  if(!istrue(var_2)) {
    wait randomfloatrange(0, 8);
  }

  var_3 = ["base", "explosion_on_death", "gas_on_death", "emp"];

  if(!isDefined(var_1)) {
    var_1 = scripts\engine\utility::random(var_3);
  }

  var_4 = zombie_getzombietypeparameters(var_1);
  var_5 = _testing_ending::spawnnewzombieagent(var_0.origin, var_0.angles, 0, "enemy_lw_zombie_default", var_4.asethetic_type);
  self.zombiespendingspawn--;

  if(!isDefined(var_5)) {
    return;
  }

  var_5 hide();
  waitframe();
  var_5 show();

  if(isDefined(self.chest)) {
    self.spawned_zombies[self.spawned_zombies.size] = var_5;
    var_5.cursed_chest_event = self;
    var_5.intelused = &zombie_cursedchestondeathcallback;
    var_5.cursed_chest_on_damage_finished_callback = &zombie_cursedchestondamagefinishedcallback;
  }

  var_5.entered_playspace = 1;
  var_5.point_value = var_4.point_value;
  var_5.zombie_event_type = var_1;
  var_5.poisonimmune = 1;
  var_5 accesscard::ref_13173(var_4.movement_type);

  if(var_5.zombie_event_type == "gas_thrower") {
    var_5 thread _luidecision::ref_1447F(var_5, -1);
  }

  if(istrue(var_4.is_super_zombie)) {
    thread zombie_setsuperzombiestatus();
  }

  thread event_zombietoofarfromeventwatcher();
}

function zombie_setsuperzombiestatus(var_0) {
  level endon("game_ended");
  self endon("death");

  if(!isDefined(var_0) || !var_0) {
    self.super_zombie_pending = 1;
    var_1 = easepower("br_loot_cursed_chest_zombie_super_upgrade_audio", self.origin);
    thread helper_cleanupaudioscriptableintime(level, var_1);
    waitframe();
    var_1 setscriptablepartstate("cc_zmb_super_upgrade", "cc_zmb_super_upgrade_charge");
    playFXOnTag(scripts\engine\utility::getfx("cursed_chest_super_zombie_pre_flare"), self, "tag_origin");
    wait 2;
  }

  playFXOnTag(scripts\engine\utility::getfx("cursed_chest_super_zombie_helmet_distortion"), self, "j_head");
  playFX(scripts\engine\utility::getfx("cursed_chest_super_zombie_flare"), self.origin + (0, 0, 10));
  var_2 = easepower("br_loot_cursed_chest_zombie_super_upgrade_audio", self.origin);
  thread helper_cleanupaudioscriptableintime(level, var_2);
  waitframe();
  var_2 setscriptablepartstate("cc_zmb_super_upgrade", "cc_zmb_super_upgrade_flare");
  self.is_super_zombie = 1;
  self.maxhealth = level.cursed_chest_event.super_zombie_health_value;
  self.health = level.cursed_chest_event.super_zombie_health_value;
  self.hashelmet = 1;
  _testing_ending::scriptable_token_scriptable_touched_callback(level.cursed_chest_event.super_zombie_armor_value);
  accesscard::ref_13173("sprint");
  self setscriptablepartstate("ai_glow", "super_loop");
}

function helper_cleanupaudioscriptableintime(var_0, var_1) {
  self endon("game_ended");
  wait var_1;
  var_0 freescriptable();
}

function zombie_getzombietypeparameters(var_0) {
  var_1 = spawnStruct();

  switch (var_0) {
    case "walker":
      var_1.asethetic_type = "base";
      var_1.movement_type = "walk";
      var_1.point_value = 1;
      break;
    case "runner":
      var_1.asethetic_type = "explosion_on_death";
      var_1.movement_type = "run";
      var_1.point_value = 1;
      break;
    case "sprinter":
      var_1.asethetic_type = "emp";
      var_1.movement_type = "sprint";
      var_1.point_value = 1;
      break;
    case "gas_thrower":
      var_1.asethetic_type = "ranger";
      var_1.movement_type = "run";
      var_1.point_value = 1;
      break;
    case "weakpoint":
      var_1.asethetic_type = "weakpoint";
      var_1.movement_type = "walk";
      var_1.point_value = 1;
      break;
    default:
      var_1.asethetic_type = "base";
      var_1.movement_type = "walk";
      var_1.point_value = 1;
      break;
  }

  if(isDefined(self.current_phase)) {
    var_1.is_super_zombie = 0;
  }

  return var_1;
}

function zombie_cursedchestondeathcallback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = distance2dsquared(self.cursed_chest_event.origin, self.origin);

  if(self.cursed_chest_event.event_pending_to_end || var_9 <= squared(self.cursed_chest_event.ref_129E0)) {
    if(istrue(self.is_super_zombie)) {
      for(var_10 = 0; var_10 < level.cursed_chest_event.super_zombie_score_yield - 1; var_10++) {
        thread zombie_sendhellfiretochest();
      }
    }

    thread zombie_sendhellfiretochest();
    var_11 = scripts\engine\utility::ter_op(istrue(self.is_super_zombie), level.cursed_chest_event.super_zombie_score_yield, self.point_value);

    if(istrue(var_1.ref_12827)) {
      var_11 *= 2;
    }

    event_addtoscorecount(self.cursed_chest_event, var_11);
  }

  self.cursed_chest_event.spawned_zombies = scripts\engine\utility::array_remove(self.cursed_chest_event.spawned_zombies, self);
  var_12 = spawnStruct();
  var_12.attacker = var_1;
  var_12.victim = self;
  _initignoredtabspergamemode::ref_11FF1(var_12);
  _ispointinbadarea::ref_11FF1(var_12);

  if(istrue(self.death_by_cursed_chest)) {
    return;
  }

  if(isDefined(var_1) && (isPlayer(var_1) || isbot(var_1))) {
    var_13 = distance2dsquared(self.origin, var_1.origin) < squared(level.cursed_chest_event.participation_radius);

    if(var_13) {
      event_registeractiveparticipant(self.cursed_chest_event, var_1);
    }

    if(isDefined(self.is_super_zombie) && self.is_super_zombie) {
      var_1 thread scripts\mp\rank::giverankxp("br_zai_killed_super", 50, var_1 getcurrentweapon());
      var_1 thread scripts\mp\rank::scoreeventpopup("br_zai_killed_super");
    } else {
      var_1 thread scripts\mp\rank::giverankxp("br_zai_killed", 10, var_1 getcurrentweapon());
      var_1 thread scripts\mp\rank::scoreeventpopup("br_zai_killed");
    }
  }

  GscBinSkip1(0x45, "eAttacker", var_1);
}

function zombie_cursedchestondamagefinishedcallback(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14) {
  if(scripts\mp\damage::armorvest_wasbroke(var_1)) {
    stopFXOnTag(scripts\engine\utility::getfx("cursed_chest_super_zombie_helmet_distortion"), self, "j_head");
    playFXOnTag(scripts\engine\utility::getfx("cursed_chest_super_zombie_helmet_break"), self, "j_head");
    self.hashelmet = 0;
    return;
  }
}

function zombie_sendhellfiretochest() {
  if(!level.cursed_chest_event.debug_disable_vfx) {
    playFX(scripts\engine\utility::getfx("cursed_chest_zombie_death"), self.origin + (0, 0, 50));
  }

  var_0 = self.cursed_chest_event;
  thread sfx_playdeathsoundviascriptable(level, self.origin, "br_loot_cursed_chest_zombie_death_audio", "cursed_chest_zombie_death_audio");
  var_1 = spawn("script_model", self.origin + (0, 0, 50));
  var_1 setModel("tag_origin");
  waitframe();
  playFXOnTag(scripts\engine\utility::getfx("cursed_chest_zombie_soul_absorb"), var_1, "tag_origin");
  var_2 = self.origin + (0, 0, 50);
  var_3 = var_0.origin + (0, 0, 10);
  var_1.angles = vectortoangles(var_3 - var_2);
  var_4 = distance(var_2, var_3);
  var_5 = var_4 / var_0.ref_129E0;
  var_6 = 200 * var_5 + 50;
  var_6 += randomfloatrange(-1 * var_6 * 0.2 / 2, var_6 * 0.2 / 2);

  if(var_6 < 50) {
    var_6 = 50;
  }

  if(var_6 > 250) {
    var_6 = 250;
  }

  var_7 = var_4 / var_6;
  var_8 = gettime();
  var_9 = var_8;
  var_10 = var_8 + var_7 * 1000;
  var_11 = randomint(360);
  var_12 = randomfloatrange(3, 4);
  var_13 = randomintrange(50, 100);
  var_14 = 0;
  var_15 = var_2[2] - var_3[2];

  if(var_15 < 80) {
    var_16 = randomintrange(40, 80) + var_15 / 2;
  } else if(var_16 < 160) {
    var_16 = randomintrange(0, 40) + var_16 / 2;
  } else {
    var_16 = randomintrange(-40, 0) + var_16 / 2;
  }

  var_17 = 0;

  while(var_17 < 1) {
    var_11 = gettime();
    var_18 = var_13 + var_14 * var_17 * 180;
    var_19 = sin(var_17 * 180) * var_15;
    var_20 = rotatepointaroundvector(anglesToForward(var_3.angles), var_19 * anglestoright(var_3.angles), var_18);
    var_21 = (0, 0, var_16 * sin(var_17 * 180 + sin(var_17 * 180) / -1));
    var_22 = vectorlerp(var_4, var_5, var_17) + var_21 + var_20;
    var_3.origin = var_22;
    var_17 = pow((var_11 - var_10) / 1000 / var_9, 1.7);
    waitframe();
  }

  playFX(scripts\engine\utility::getfx("cursed_chest_zombie_soul_absorb_stop"), var_5);
  stopFXOnTag(scripts\engine\utility::getfx("cursed_chest_zombie_soul_absorb"), var_3, "tag_origin");
  wait 2;
  var_3 delete();
}

function onhitbypoisonzombie(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0) && isDefined(var_0.zombie_event_type) && var_0.zombie_event_type == "gas_thrower") {
    if(isDefined(var_1)) {
      if(isDefined(var_2) && isalive(var_2)) {
        var_4 = easepower("vfx_chem_rounds_enemy_hit", var_1);
        thread ref_12AAB(var_4);

        if(!istrue(var_2.updateteamplunderscore)) {
          if(isPlayer(var_2)) {
            stopfxontagforclients(level._effects["vfx_nova_round_scrnfx"], var_2, "j_head", var_2);
            playfxontagforclients(level._effects["vfx_nova_round_scrnfx"], var_2, "j_head", var_2);
          }

          var_2.updateteamplunderscore = 1;

          if(isDefined(self)) {
            self playlocalsound("bullet_chem_round_dmg_plr_trans");
          }
        }

        var_2 thread _luidecision::ref_1447F(var_0, 3);
        return;
      }

      return;
    }

    return;
  }
}

function ref_12AAB(var_0) {
  level endon("game_ended");
  wait var_0;
  self freescriptable();
}

function sfx_playdeathsoundviascriptable(var_0, var_1, var_2, var_3) {
  var_4 = easepower(var_1, var_0);
  waitframe();
  var_4 setscriptablepartstate(var_2, var_3);
  wait 5;
  var_4 freescriptable();
}

function spawnnode_spawn(var_0) {
  var_1 = spawnStruct();
  var_1.index = self.spawn_nodes.size;
  var_1.origin = var_0;
  var_1.angles = (0, 0, 0);
  var_1.state = "valid";
  var_1.parent = undefined;
  var_1.ref_14293 = undefined;
  var_2 = distance(var_1.origin, self.origin);
  var_1.loot_getitemcountlefthand = self.zombie_spawn_radius_max - var_2;
  self.spawn_nodes[self.spawn_nodes.size] = var_1;
}

function spawnnode_spawnallnodes() {
  var_0 = spawnStruct();
  var_1 = self.zombie_spawn_radius_max;
  var_0.ref_11A58 = self.origin + (var_1 * -1, var_1 * -1, 0);
  var_0.ref_11A59 = self.origin + (var_1, var_1 * -1, 0);
  var_0.ref_14039 = self.origin + (var_1 * -1, var_1, 0);
  var_0.ref_1403A = self.origin + (var_1, var_1, 0);
  var_2 = 10;
  var_3 = self.zombie_spawn_radius_max * 2;
  var_4 = var_3 / var_2;
  var_5 = (self.origin[0] - self.zombie_spawn_radius_max, self.origin[1] - self.zombie_spawn_radius_max, self.origin[2]);

  for(var_6 = 0; var_6 < var_2; var_6++) {
    for(var_7 = 0; var_7 < var_2; var_7++) {
      var_8 = var_4 * var_6;
      var_9 = (var_8, 0, 0);
      var_10 = var_4 * var_7;
      var_11 = (0, var_10, 0);
      var_12 = var_5 + var_9 + var_11;

      if(distance2dsquared(var_12, self.origin) < squared(self.zombie_spawn_radius_max)) {
        if(distance2dsquared(var_12, self.origin) > squared(self.zombie_spawn_radius_min)) {
          spawnnode_spawn(var_12);
        }
      }
    }
  }

  thread spawnnode_selectnodestospawnon();
}

function spawnnode_selectnodestospawnon() {
  foreach(var_1 in self.spawn_nodes) {
    if(var_1.state != "valid") {
      continue;
    }

    spawnnode_spawnonnodegrid(var_1);
  }
}

function spawnnode_spawnonnodegrid(var_0) {
  if(var_0.state != "valid") {
    return;
  }

  var_0.state = "selected";
  var_1 = physics_createcontents(["physicscontents_solid", "physicscontents_water"]);
  var_2 = (0, 0, 250);
  var_3 = var_0.origin + var_2;
  var_4 = var_0.origin - var_2;
  var_5 = [];
  var_6 = physics_raycast(var_3, var_4, var_1, var_5, 0, "physicsquery_closest", 1);
  var_7 = var_0.origin;

  if(isDefined(var_6) && var_6.size > 0) {
    var_7 = var_6[0]["position"];
    var_0.origin = getclosestpointonnavmesh(var_7);
    self.spawn_nodes_selected[self.spawn_nodes_selected.size] = var_0;
  }

  var_8 = risk_flagspawncount();

  foreach(var_10 in self.spawn_nodes) {
    if(var_10.state != "valid") {
      continue;
    }

    var_11 = distance2dsquared(var_0.origin, var_10.origin);

    if(var_11 <= squared(150)) {
      var_10.parent = var_0;
      var_10.state = "occupied";
      var_10.color = var_8;
    }
  }
}

function risk_flagspawncount() {
  var_0 = randomfloatrange(0.4, 1);
  var_1 = randomfloatrange(0.3, 0.6);
  var_2 = randomfloatrange(0.3, 1);
  return (var_0, var_1, var_2);
}

function ui_showeventhud() {
  if(!isDefined(self.cursed_chest_event_ui)) {
    self.cursed_chest_event_ui = [];
    self.cursed_chest_event_ui["score_display"] = ui_createhudelement(&"BR_CURSED_CHEST_EVENT/SCORE_DISPLAY", self.cursed_chest_event.current_score, 1, (1, 1, 1), undefined, 0, 50);
  }

  foreach(var_1 in self.cursed_chest_event_ui) {
    var_1 scripts\mp\hud_util::showelem();
  }

  if(isDefined(self.cursed_chest_event)) {
    self.cursed_chest_event_ui["score_display"] setvalue(self.cursed_chest_event.current_score);
    return;
  }
}

function ui_hideeventhud() {
  if(!isDefined(self.cursed_chest_event_ui)) {
    return;
  }

  foreach(var_1 in self.cursed_chest_event_ui) {
    var_1 scripts\mp\hud_util::hideelem();
  }
}

function ui_deleteeventhud() {
  if(!isDefined(self.cursed_chest_event_ui)) {
    return;
  }

  foreach(var_1 in self.cursed_chest_event_ui) {
    var_1 scripts\mp\hud_util::destroyelem();
  }

  self.cursed_chest_event_ui = undefined;
}

function ui_updateallparticipantshud() {
  foreach(var_1 in self.active_participants) {
    if(!isDefined(var_1)) {
      return;
    }

    var_1.cursed_chest_event_ui["score_display"] setvalue(self.current_score);
    thread ui_scorepop();
  }
}

function ui_deleteallparticipantshud() {
  foreach(var_1 in self.active_participants) {
    if(!isDefined(var_1)) {
      return;
    }

    ui_deleteeventhud(var_1);
  }
}

function ui_createhudelement(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_4)) {
    var_4 = "TOPLEFT";
  }

  if(!isDefined(var_5)) {
    var_5 = 0;
  }

  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  var_7 = scripts\mp\hud_util::createfontstring("default", var_2);
  var_7.label = var_0;
  var_7.color = var_3;
  var_8 = 40;
  var_9 = (1 - getdvarfloat("hudBounds_adjusted_horizontal", 0)) * var_8;
  var_10 = (1 - getdvarfloat("hudBounds_adjusted_vertical", 0)) * var_8 / 2;
  var_7 scripts\mp\hud_util::setpoint(var_4, var_4, 143 + var_9, var_6 + var_10);

  if(isDefined(var_1)) {
    var_7 setvalue(var_1);
  }

  return var_7;
}

function ui_scorepop() {
  level endon("game_ended");
  self notify("score_pop_triggered");
  self endon("score_pop_triggered");
  var_0 = 0.35;
  var_1 = 0;
  var_2 = gettime();
  var_3 = var_2;
  var_4 = var_2 + var_0 * 1000;

  while(var_1 < 1) {
    if(!isDefined(self)) {
      break;
    }

    var_5 = 2;
    var_6 = 1;

    if(var_1 < 0.5) {
      var_6 = var_1 * 2 * var_5;
    } else {
      var_6 = var_5 + var_5 * (1 - var_1 * 2);
    }

    var_1 = (var_3 - var_2) / 1000 / var_0;
    scripts\mp\hud_util::setsize(var_6, var_6);
    waitframe();
  }
}