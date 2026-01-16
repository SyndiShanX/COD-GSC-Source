/********************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_town\cp_town_crab_boss_death_wall.gsc
********************************************************************/

wall_of_death() {
  wall_of_death_zombie_spawn_initial_settings();
  level thread instant_player_revive_loop();
  level thread try_wait_for_players_activate_teleporter();
  level thread escort_teleporter_manager();
  level thread crab_boss_wall_of_death_logic();
  level waittill("wall_of_death_completed");
}

instant_player_revive_loop() {
  level endon("game_ended");
  level endon("players_trigger_vehicle_teleporter");
  var_0 = 60;
  for(;;) {
    revive_players_from_afterlife();
    wait(var_0);
  }
}

wall_of_death_zombie_spawn_initial_settings() {
  level.allow_wave_spawn = 0;
  scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_max_zombie_spawn(15, 15, 15, 15);
  scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_zombie_spawn_delay(1, 1, 1, 1);
  scripts\engine\utility::flag_set("crab_boss_zombie_spawn");
}

wall_of_death_zombie_spawn_post_activation_settings() {
  scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_max_zombie_spawn(15, 15, 15, 15);
  scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_zombie_spawn_delay(0.2, 0.2, 0.2, 0.2);
}

crab_boss_wall_of_death_logic() {
  level.crab_boss toxic_gas_attack();
}

try_wait_for_players_activate_teleporter() {
  if(!scripts\engine\utility::istrue(level.player_activated_teleporter)) {
    level thread scripts\cp\cp_vo::try_to_play_vo("el_evirasbook_1", "rave_announcer_vo", "highest", 70, 0, 0, 1);
    level waittill("players_trigger_vehicle_teleporter");
    activate_final_sequence_blocker();
    level thread teleport_trapped_ai();
    scripts\cp\maps\cp_town\cp_town_crab_boss_death_ray::disable_all_death_ray_cannons();
    level.player_activated_teleporter = 1;
  }
}

teleport_trapped_ai() {
  level endon("game_ended");
  scripts\engine\utility::waitframe();
  foreach(var_1 in level.spawned_enemies) {
    if(!isDefined(var_1) && isalive(var_1)) {
      continue;
    }

    if(var_1.agent_type == "crab_boss") {
      continue;
    }

    if(agent_is_trapped(var_1)) {
      teleport_to_clear_pos(var_1);
    }
  }

  if(isDefined(level.elvira_ai) && agent_is_trapped(level.elvira_ai)) {
    teleport_to_clear_pos(level.elvira_ai);
  }
}

agent_is_trapped(var_0) {
  if(var_0.origin[2] >= -56) {
    return 1;
  }

  if(var_0.origin[1] <= 1700) {
    return 1;
  }

  if(var_0.origin[0] >= 3600) {
    return 1;
  }

  return 0;
}

teleport_to_clear_pos(var_0) {
  var_1 = (3004, 1587, -77);
  var_2 = 100;
  var_3 = randomfloatrange(var_2 * -1, var_2);
  var_4 = randomfloatrange(var_2 * -1, var_2);
  var_5 = var_1 + (var_3, var_4, 0);
  var_5 = getclosestpointonnavmesh(var_5) + (0, 0, 2);
  var_0 dontinterpolate();
  var_0 setorigin(var_5);
}

toxic_gas_attack() {
  for(;;) {
    level.crab_boss do_taunt();
    if(scripts\engine\utility::istrue(level.escort_vehicle.teleporter_activated)) {
      break;
    }
  }

  wall_of_death_zombie_spawn_post_activation_settings();
  scripts\cp\cp_vo::try_to_play_vo_on_all_players("boss_phase_4_wod_retreat");
  for(var_0 = 1; var_0 <= 3; var_0++) {
    adjust_zombie_spawn(var_0);
    level thread wall_goo_geiger_sfx(var_0);
    if(scripts\engine\utility::istrue(level.first_wall_of_death_complete)) {
      level.crab_boss_toxic_attack_index = var_0;
      if(var_0 == 3) {
        scripts\engine\utility::flag_clear("crab_boss_zombie_spawn");
      }

      level.crab_boss toxic_attack();
      level.crab_boss do_toxic_spawn();
      continue;
    }

    level.crab_boss_toxic_attack_index = var_0;
    level.crab_boss toxic_attack();
    level.crab_boss do_toxic_spawn();
    if(var_0 == 3) {
      scripts\engine\utility::flag_clear("crab_boss_zombie_spawn");
    }

    level.crab_boss do_taunt();
    level.crab_boss do_toxic_spawn();
    level.crab_boss do_taunt();
  }

  level.first_wall_of_death_complete = 1;
  level notify("wall_of_death_completed");
}

wall_goo_geiger_sfx(var_0) {
  switch (var_0) {
    case 1:
      level.boss_goo_geiger_1 = thread scripts\engine\utility::play_loopsound_in_space("town_geiger_counter_boss_lvl1", (2757, 2698, -20));
      level.boss_goo_geiger_2 = thread scripts\engine\utility::play_loopsound_in_space("town_geiger_counter_boss_lvl1", (3136, 2574, -20));
      level.boss_goo_geiger_3 = thread scripts\engine\utility::play_loopsound_in_space("town_geiger_counter_boss_lvl1", (3742, 2512, -20));
      level.boss_goo_bubble_1 = thread scripts\engine\utility::play_loopsound_in_space("boss_goo_bubble_large_lp_01", (2763, 2999, -126));
      level.boss_goo_bubble_2 = thread scripts\engine\utility::play_loopsound_in_space("boss_goo_bubble_large_lp_02", (3325, 2627, -106));
      break;

    case 2:
      if(isDefined(level.boss_goo_geiger_1)) {
        level.boss_goo_geiger_1 moveto((2638, 2200, -130), 2);
      }

      if(isDefined(level.boss_goo_geiger_2)) {
        level.boss_goo_geiger_2 moveto((3545, 2058, -113), 2);
      }

      if(isDefined(level.boss_goo_geiger_3)) {
        level.boss_goo_geiger_3 moveto((3461, 1862, -50), 2);
      }

      if(isDefined(level.boss_goo_bubble_1)) {
        level.boss_goo_bubble_1 moveto((2638, 2200, -130), 2);
      }

      if(isDefined(level.boss_goo_bubble_2)) {
        level.boss_goo_bubble_2 moveto((3480, 2310, -102), 2);
      }
      break;

    case 3:
      if(isDefined(level.boss_goo_geiger_1)) {
        level.boss_goo_geiger_1 moveto((2818, 1258, -40), 2);
      }

      if(isDefined(level.boss_goo_bubble_1)) {
        level.boss_goo_bubble_1 moveto((2818, 1258, -40), 2);
      }

      if(isDefined(level.boss_goo_geiger_2)) {
        level.boss_goo_geiger_2 delete();
      }

      if(isDefined(level.boss_goo_geiger_3)) {
        level.boss_goo_geiger_3 delete();
      }

      if(isDefined(level.boss_goo_bubble_2)) {
        level.boss_goo_bubble_2 delete();
      }
      break;

    case 4:
      if(isDefined(level.boss_goo_geiger_1)) {
        level.boss_goo_geiger_1 delete();
      }

      if(isDefined(level.boss_goo_geiger_2)) {
        level.boss_goo_geiger_2 delete();
      }

      if(isDefined(level.boss_goo_geiger_3)) {
        level.boss_goo_geiger_3 delete();
      }

      if(isDefined(level.boss_goo_bubble_1)) {
        level.boss_goo_bubble_1 delete();
      }

      if(isDefined(level.boss_goo_bubble_2)) {
        level.boss_goo_bubble_2 delete();
      }
      break;
  }
}

escort_teleporter_manager() {
  level endon("game_ended");
  level endon("boss_fight_finished");
  if(scripts\engine\utility::istrue(level.escort_teleporter_manager)) {
    return;
  }

  level.escort_teleporter_manager = 1;
  var_0 = make_vehicle_teleporter_interaction();
  var_1 = level.escort_vehicle;
  for(;;) {
    level.vehicle_teleporter_is_charged = 0;
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
    refresh_interaction_for_all_players();
    wail_all_player_trigger_teleporter(undefined, "players_trigger_vehicle_teleporter");
    var_1 thread play_charging_up_sfx(var_1);
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    playFXOnTag(level._effect["vfx_bomb_portal_chargeup_beach"], var_1, "tag_bomb");
    level.escort_vehicle.teleporter_activated = 1;
    level waittill("sonic_ring_start");
    var_1 thread play_charged_up_sfx(var_1);
    level.vehicle_teleporter_is_charged = 1;
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
    refresh_interaction_for_all_players();
    stopFXOnTag(level._effect["vfx_bomb_portal_chargeup_beach"], var_1, "tag_bomb");
    playFXOnTag(level._effect["vfx_bomb_portal_charged_beach"], var_1, "tag_bomb");
    var_2 = level scripts\engine\utility::waittill_any_return("sonic_ring_success", "sonic_ring_fail");
    stopFXOnTag(level._effect["vfx_bomb_portal_charged_beach"], var_1, "tag_bomb");
    var_1 thread stop_charged_up_sfx(var_1, var_2);
    level.escort_vehicle.teleporter_activated = 0;
  }
}

play_charging_up_sfx(var_0) {
  level endon("boss_fight_finished");
  level endon("sonic_ring_start");
  var_0 playSound("cp_town_bomb_charge_start");
  var_0 playLoopSound("cp_town_bomb_charge_lp");
}

play_charged_up_sfx(var_0) {
  var_0 stoploopsound("cp_town_bomb_charge_lp");
  var_0 playLoopSound("cp_town_bomb_charged_up_lp");
}

stop_charged_up_sfx(var_0, var_1) {
  var_0 stoploopsound("cp_town_bomb_charged_up_lp");
  if(var_1 == "sonic_ring_fail") {
    var_0 playSound("cp_town_bomb_charge_fail");
  }
}

refresh_interaction_for_all_players() {
  foreach(var_1 in level.players) {
    var_1 scripts\cp\cp_interaction::refresh_interaction();
  }
}

make_vehicle_teleporter_interaction() {
  var_0 = spawnStruct();
  var_0.name = "vehicle_teleporter";
  var_0.script_noteworthy = "vehicle_teleporter";
  var_0.origin = (3001, 2858, -158);
  var_0.cost = 0;
  var_0.powered_on = 1;
  var_0.spend_type = undefined;
  var_0.script_parameters = "";
  var_0.requires_power = 0;
  var_0.hint_func = ::vehicle_teleporter_hint_func;
  var_0.activation_func = scripts\cp\maps\cp_town\cp_town_interactions::blankusefunc;
  var_0.enabled = 1;
  var_0.disable_guided_interactions = 0;
  level.interactions["vehicle_teleporter"] = var_0;
  var_0 thread vehicle_teleporter_interaction_clean_up(var_0);
  return var_0;
}

vehicle_teleporter_interaction_clean_up(var_0) {
  level waittill("boss_fight_finished");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
}

adjust_zombie_spawn(var_0) {
  switch (var_0) {
    case 1:
      scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_max_zombie_spawn(15, 14, 12, 10);
      scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_zombie_spawn_delay(1.5, 1.8, 2.1, 2.5);
      level.max_wave_spawn_num = 20;
      level.wait_time_between_wave = 15;
      break;

    case 2:
      scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_max_zombie_spawn(15, 14, 13, 12);
      scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_zombie_spawn_delay(1.3, 1.5, 1.7, 2);
      level.max_wave_spawn_num = 20;
      level.wait_time_between_wave = 15;
      break;

    case 3:
      scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_max_zombie_spawn(10, 9, 8, 7);
      scripts\cp\maps\cp_town\cp_town_crab_boss_fight::set_crab_boss_zombie_spawn_delay(1.5, 1.8, 2.1, 2.5);
      level.max_wave_spawn_num = 20;
      level.wait_time_between_wave = 15;
      break;
  }
}

do_taunt() {
  level.crab_boss scripts\aitypes\crab_boss\behaviors::dotaunt(0);
  level.crab_boss waittill("taunt_done");
}

do_toxic_spawn() {
  level.crab_boss scripts\aitypes\crab_boss\behaviors::dotoxicspawn();
  level.crab_boss waittill("toxic_spawn_done");
}

toxic_attack() {
  level.crab_boss scripts\aitypes\crab_boss\behaviors::dogasattack(0);
  level.crab_boss waittill("toxic_done");
}

activate_toxic_patch_and_trigger(var_0) {
  play_toxic_ground_vfx(var_0);
  var_1 = getent("toxic_waste_patch_" + var_0, "targetname");
  var_1 dontinterpolate();
  var_2 = get_toxic_patch_offset(var_0);
  var_1.origin = var_1.origin + (0, 0, 1026 - var_2);
  var_3 = get_toxic_patch_move_time(var_0);
  var_1 moveto(var_1.origin + (0, 0, var_2), var_3, 0, var_3);
  var_1 waittill("movedone");
  var_1.activated = 1;
  var_4 = getent("toxic_waste_trigger_" + var_0, "targetname");
  var_4 dontinterpolate();
  var_4.origin = var_4.origin + (0, 0, 1024);
  var_4 thread func_D051(var_4);
  if(var_0 > 1) {
    deactivate_toxic_patch_and_trigger(var_0 - 1);
  }
}

get_toxic_patch_offset(var_0) {
  switch (var_0) {
    case 1:
      return 6;

    case 2:
      return 6;

    case 3:
      return 6;
  }
}

get_toxic_patch_move_time(var_0) {
  switch (var_0) {
    case 1:
      return 7;

    case 2:
      return 7;

    case 3:
      return 7;
  }
}

func_D051(var_0) {
  var_0 endon("stop_toxic_trigger_monitor");
  for(;;) {
    var_0 waittill("trigger", var_1);
    if(isplayer(var_1)) {
      if(scripts\engine\utility::istrue(var_1.inlaststand)) {
        continue;
      }

      try_sonic_beam_damage_player(var_1);
    }
  }
}

try_sonic_beam_damage_player(var_0) {
  if(!isDefined(var_0.next_toxic_trigger_damage_time)) {
    var_0.next_toxic_trigger_damage_time = 0;
  }

  var_1 = gettime();
  if(!isDefined(var_0.geiger_counter)) {
    var_0.geiger_counter = 1;
    var_0 playlocalsound("town_geiger_counter_lvl4_plr");
    var_0 thread delay_stop_geiger_counter(var_0);
  }

  if(var_0.next_toxic_trigger_damage_time > var_1) {
    return;
  }

  var_0.next_toxic_trigger_damage_time = var_1 + 750;
  var_0 dodamage(int(var_0.maxhealth * 0.2), var_0.origin);
  var_0 setscriptablepartstate("screen_effects", "screen_goo");
}

delay_stop_geiger_counter(var_0) {
  var_0 notify("delay_stop_geiger_counter");
  var_0 endon("disconnect");
  var_0 endon("delay_stop_geiger_counter");
  wait(0.75);
  if(isDefined(var_0.geiger_counter)) {
    var_0.geiger_counter = undefined;
    var_0 scripts\cp\utility::stoplocalsound_safe("town_geiger_counter_lvl4_plr");
  }
}

deactivate_toxic_patch_and_trigger(var_0) {
  var_1 = getent("toxic_waste_patch_" + var_0, "targetname");
  var_2 = getent("toxic_waste_trigger_" + var_0, "targetname");
  if(scripts\engine\utility::istrue(var_1.activated)) {
    var_1 dontinterpolate();
    var_2 dontinterpolate();
    var_3 = get_toxic_patch_offset(var_0);
    var_1 thread toxic_patch_submerge(var_1, var_3, var_0);
    var_2.origin = var_2.origin + (0, 0, -1024);
    var_2 notify("stop_toxic_trigger_monitor");
  }
}

get_patch_submerge_time() {
  return 1;
}

toxic_patch_submerge(var_0, var_1, var_2) {
  var_3 = get_patch_submerge_time();
  var_0 moveto(var_0.origin - (0, 0, var_1), var_3);
  var_0 waittill("movedone");
  var_0.origin = var_0.origin + (0, 0, -1024 + var_1);
  var_0.activated = 0;
}

activate_final_sequence_blocker() {
  if(scripts\engine\utility::istrue(level.final_sequence_blocker_activated)) {
    return;
  }

  level.wall_of_death_blocker_models = [];
  var_0 = scripts\engine\utility::getstructarray("death_wall_door_model", "targetname");
  foreach(var_2 in var_0) {
    var_3 = spawn("script_model", var_2.origin);
    var_3 setModel("cp_disco_street_barricade");
    var_3.angles = var_2.angles;
    level.wall_of_death_blocker_models[level.wall_of_death_blocker_models.size] = var_3;
  }

  var_5 = getent("death_wall_door_clip", "targetname");
  var_5 dontinterpolate();
  var_5.origin = var_5.origin + (0, 0, 1024);
  level.final_sequence_blocker_activated = 1;
}

deactivate_final_sequence_blocker() {
  if(isDefined(level.wall_of_death_blocker_models)) {
    foreach(var_1 in level.wall_of_death_blocker_models) {
      if(isDefined(var_1)) {
        var_1 delete();
      }
    }
  }

  var_3 = getent("death_wall_door_clip", "targetname");
  if(isDefined(var_3)) {
    var_3 delete();
  }
}

end_wall_of_death() {
  level thread wall_goo_geiger_sfx(4);
  play_outro_vfx();
  deactivate_toxic_patch_and_trigger(3);
}

debug_beat_wall_of_death() {}

wail_all_player_trigger_teleporter(var_0, var_1) {
  if(isDefined(var_0)) {
    level endon(var_0);
  }

  var_2 = 22500;
  for(;;) {
    var_3 = 1;
    foreach(var_5 in level.players) {
      if(scripts\engine\utility::istrue(var_5.inlaststand)) {
        var_3 = 0;
        break;
      }

      if(scripts\engine\utility::istrue(var_5.iscarrying)) {
        var_3 = 0;
        break;
      }

      if(distancesquared(var_5.origin, (3001, 2858, -158)) > var_2) {
        var_3 = 0;
        break;
      }

      if(!var_5 usebuttonpressed()) {
        var_3 = 0;
        break;
      }
    }

    wait(0.25);
    if(var_3) {
      var_3 = 1;
      foreach(var_5 in level.players) {
        if(scripts\engine\utility::istrue(var_5.inlaststand)) {
          var_3 = 0;
          break;
        }

        if(scripts\engine\utility::istrue(var_5.iscarrying)) {
          var_3 = 0;
          break;
        }

        if(distancesquared(var_5.origin, (3001, 2858, -158)) > var_2) {
          var_3 = 0;
          break;
        }

        if(!var_5 usebuttonpressed()) {
          var_3 = 0;
          break;
        }
      }
    }

    if(var_3) {
      if(isDefined(var_1)) {
        level notify(var_1);
      }

      return;
    }

    scripts\engine\utility::waitframe();
  }
}

death_wall_zombie_spawning_logic() {
  level endon("stop_death_wall_zombie_spawning");
  wait(1.5);
  var_0 = [(2744, 3725, -197), (3498, 2990, -197)];
  foreach(var_3, var_2 in var_0) {
    var_0[var_3] = ::scripts\engine\utility::drop_to_ground(var_0[var_3], 0, -500);
  }

  var_4 = randomint(2);
  for(;;) {
    spawn_group_of_zombies_at(var_0[var_4 % var_0.size]);
    var_4++;
    wait(3);
  }
}

spawn_group_of_zombies_at(var_0) {
  var_1 = min(18, 22 - level.spawned_enemies.size);
  var_2 = level.players.size;
  var_3 = min(var_1, var_2);
  for(var_4 = 0; var_4 < var_3; var_4++) {
    spawn_one_zombie(var_0);
    scripts\engine\utility::waitframe();
  }
}

spawn_one_zombie(var_0) {
  var_1 = 70;
  var_2 = randomfloatrange(var_1 * -1, var_1);
  var_3 = randomfloatrange(var_1 * -1, var_1);
  var_0 = (var_0[0] + var_2, var_0[1] + var_3, var_0[2]);
  var_0 = getclosestpointonnavmesh(var_0);
  var_4 = make_zombie_spawner(var_0);
  var_5 = var_4 scripts\cp\zombies\zombies_spawning::spawn_wave_enemy("generic_zombie", 1, var_4);
}

make_zombie_spawner(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = var_0;
  var_2.angles = vectortoangles((-26, -110, 18));
  return var_2;
}

play_outro_vfx() {
  foreach(var_1 in level.toxic_loop_vfx) {
    playFX(level._effect["toxic_ground_outro"], var_1.origin);
    var_1 delete();
  }

  level.toxic_loop_vfx = [];
}

load_death_wall_vfx() {
  level.toxic_loop_vfx = [];
  level._effect["toxic_ground_intro"] = loadfx("vfx\iw7\levels\cp_town\crog\vfx_toxic_ground_intro.vfx");
  level._effect["toxic_ground_loop"] = loadfx("vfx\iw7\levels\cp_town\crog\vfx_toxic_ground_loop.vfx");
  level._effect["toxic_ground_outro"] = loadfx("vfx\iw7\levels\cp_town\crog\vfx_toxic_ground_outro.vfx");
}

play_toxic_ground_vfx(var_0) {
  var_1 = get_toxic_ground_vfx_locs(var_0);
  foreach(var_3 in var_1) {
    level thread play_toxic_ground_vfx_at_pos(var_3);
  }
}

get_toxic_ground_vfx_locs(var_0) {
  switch (var_0) {
    case 1:
      return [(2574, 2950, -168), (2668, 2518, -169), (3037, 2661, -175), (3341, 2505, -156), (3547, 2580, -163)];

    case 2:
      return [(2679, 2262, -147), (2693, 2023, -133), (2555, 2098, -128), (3028, 2045, -75), (3132, 1926, -93), (3418, 1883, -112), (3569, 2089, -129)];

    case 3:
      return [(2741, 1705, -116), (3037, 1613, -89), (2839, 1407, -83), (2630, 1172, -72), (2849, 1067, -65)];
  }
}

play_toxic_ground_vfx_at_pos(var_0) {
  var_1 = scripts\engine\utility::drop_to_ground(var_0, 10, -50);
  playFX(level._effect["toxic_ground_intro"], var_1);
  wait(1.5);
  var_2 = spawnfx(level._effect["toxic_ground_loop"], var_1);
  triggerfx(var_2);
  level.toxic_loop_vfx[level.toxic_loop_vfx.size] = var_2;
}

revive_players_from_afterlife() {
  foreach(var_1 in level.players) {
    if(scripts\cp\zombies\zombie_afterlife_arcade::is_in_afterlife_arcade(var_1)) {
      var_1 scripts\cp\cp_laststand::instant_revive(var_1);
    }
  }
}

vehicle_teleporter_hint_func(var_0, var_1) {
  if(scripts\engine\utility::istrue(level.vehicle_teleporter_is_charged)) {
    return &"CP_TOWN_INTERACTIONS_VEHICLE_TELEPORT_READY";
  }

  return &"CP_TOWN_INTERACTIONS_ACTIVATE_TELEPORT";
}