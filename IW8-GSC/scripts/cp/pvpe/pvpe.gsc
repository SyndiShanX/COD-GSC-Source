/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\pvpe\pvpe.gsc
***********************************************/

function init_pvpe() {
  increment_round_number();
  randomize_team_id_to_team_number_mapping();
  randomize_session_team_to_team_number_mapping();
  cap_round_number();
  set_up_pvpe_callback();
  set_up_team_score();
  reset_in_pvpe_end_game();
  setup_play_test_name_to_team_id_mapping();
  thread pvpe_terrorist_players_respawn_timer();
  thread pvpe_round_timer();
  thread pvpe_player_connect_monitor();
  thread kidnapper_laststand_hero_watcher();
}

function reset_in_pvpe_end_game() {
  game["in_pvpe_end_game"] = 0;
}

function set_up_team_score() {
  if(game["round_number"] == 1) {
    game["round_one_hero_team_score"] = 0;
    game["round_two_hero_team_score"] = 0;
    game["round_one_hero_team_score_fraction"] = 0;
    game["round_two_hero_team_score_fraction"] = 0;
    thread delay_reset_team_score_omnvar();
    return;
  }

  if(game["round_number"] == 2) {
    thread delay_set_team_score_omnvar();
    return;
  }
}

function delay_set_team_score_omnvar() {
  wait 5;
  set_team_score_for_players("cp_team_0_score", -1);
  wait 0.1;
  set_team_score_for_players("cp_team_1_score", 0);

  for(var_0 = 0; var_0 <= game["round_one_hero_team_score"]; var_0++) {
    set_team_score_for_players("cp_team_0_score", var_0);
    wait 0.1;

    if(var_0 < game["round_one_hero_team_score"]) {
      set_team_score_for_players("cp_team_0_fractional_score", 1);
    } else {
      set_team_score_for_players("cp_team_0_fractional_score", game["round_one_hero_team_score_fraction"]);
    }

    wait 0.1;
  }
}

function delay_reset_team_score_omnvar() {
  wait 5;
  set_team_score_for_players("cp_team_0_score", -1);
  set_team_score_for_players("cp_team_1_score", -1);
  waitframe();
  set_team_score_for_players("cp_team_0_score", 0);
  set_team_score_for_players("cp_team_1_score", 0);
  set_team_score_for_players("cp_team_0_fractional_score", 0);
  set_team_score_for_players("cp_team_1_fractional_score", 0);
}

function increment_round_number() {
  if(!isDefined(game["round_number"])) {
    game["round_number"] = 1;
    return;
  }

  game["round_number"]++;
}

function cap_round_number() {
  if(game["round_number"] > 2) {
    game["round_number"] = 1;
    return;
  }
}

function randomize_team_id_to_team_number_mapping() {
  if(game["round_number"] > 2) {
    game["team_id_to_team_number_mapping"] = undefined;
  }

  if(isDefined(game["team_id_to_team_number_mapping"])) {
    return;
  }

  var_0 = [0, 1];

  for(var_1 = 5; var_1 > 0; var_1--) {
    var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  game["team_id_to_team_number_mapping"] = var_0;
}

function randomize_session_team_to_team_number_mapping() {
  if(game["round_number"] > 2) {
    game["session_team_to_team_number_mapping"] = undefined;
  }

  if(isDefined(game["session_team_to_team_number_mapping"])) {
    return;
  }

  var_0 = [0, 1];

  for(var_1 = 5; var_1 > 0; var_1--) {
    var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  game["session_team_to_team_number_mapping"] = [];
  game["session_team_to_team_number_mapping"]["axis"] = var_0[0];
  game["session_team_to_team_number_mapping"]["allies"] = var_0[1];
}

function set_up_pvpe_callback() {
  level.player_is_terrorist_func = &player_is_terrorist;
  level.playerspawnteamassignmentfunc = &pvpe_playerspawnteamassignmentfunc;
  level.playerspawnsessionteamassignmentfunc = &pvpe_playerspawnsessionteamassignmentfunc;
  level.coop_gameshouldendfunc = &pvpe_gameshouldendfunc;
  level.allow_munitions = &pvpe_allow_munitions;
  level.get_num_of_charges_for_power = &pvpe_get_num_of_charges_for_power;
  level.allow_super = &pvpe_allow_super;
  level.pre_map_restart_func = &pvpe_pre_map_restart_func;
  level.endgame = &pvpe_end_game;
  level.change_to_terrorist_model_func = &change_to_terrorist_model;
  level.allow_players_to_restart = &pvpe_allow_players_to_restart;
  level.forceendgame = &pvpe_force_end_game;
  level.revive_ent_usability_func = &pvpe_revive_ent_usability_func;
  level.disable_bleedout_ent_usability_func = &pvpe_disable_bleedout_ent_usability_func;
  level.enable_bleedout_ent_usability_func = &pvpe_enable_bleedout_ent_usability_func;
}

function pvpe_revive_ent_usability_func(var_0, var_1) {
  var_1 endon("death");

  foreach(var_3 in level.players) {
    if(var_3 == var_0) {
      continue;
    }

    if(var_3.team_number == 0) {
      continue;
    }

    var_1 disableplayeruse(var_3);
  }

  for(;;) {
    level waittill("connected", var_3);
    thread delay_disable_use(var_3, var_3);
  }
}

function pvpe_disable_bleedout_ent_usability_func(var_0) {
  foreach(var_2 in level.players) {
    var_0.executeent disableplayeruse(var_2);
  }
}

function pvpe_enable_bleedout_ent_usability_func(var_0) {
  foreach(var_2 in level.players) {
    if(!istrue(var_2.waiting_to_spawn) && player_is_kidnapper(var_2)) {
      var_0.executeent enableplayeruse(var_2);
    }
  }
}

function delay_disable_use(var_0, var_1) {
  var_0 endon("disconnect");
  var_1 endon("death");
  var_0 waittill("spawned_player");
  waitframe();

  if(player_is_terrorist(var_0)) {
    var_1 disableplayeruse(var_0);
    return;
  }
}

function pvpe_enabled() {
  return getdvarint("enable_pvpe", 0) != 0;
}

function player_is_terrorist(var_0) {
  if(!pvpe_enabled()) {
    return false;
  }

  return var_0.team_number == 1;
}

function pvpe_playerspawnteamassignmentfunc(var_0) {
  var_1 = ["allies", "axis", "team_four", "team_six"];

  if(isDefined(var_0.team_number)) {
    return var_1[var_0.team_number];
  }

  return "free";
}

function pvpe_playerspawnsessionteamassignmentfunc(var_0, var_1) {
  return var_1;
}

function pvpe_gameshouldendfunc(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      continue;
    }

    if(player_is_terrorist(var_2)) {
      continue;
    }

    if(!scripts\cp\cp_laststand::player_in_laststand(var_2)) {
      return false;
    }
  }

  return true;
}

function pvpe_allow_munitions(var_0) {
  if(player_is_terrorist(var_0)) {
    return false;
  }

  return true;
}

function pvpe_get_num_of_charges_for_power(var_0) {
  if(player_is_terrorist(var_0)) {
    return 1;
  }

  return scripts\cp\cp_loadout::get_default_num_equipment_charges();
}

function pvpe_allow_super(var_0) {
  if(player_is_terrorist(var_0)) {
    return false;
  }

  return true;
}

function pvpe_pre_map_restart_func(var_0) {
  var_1 = get_winning_team_name();
  jumpiffalse(var_1 == "tie") LOC_0000004d;

  foreach(var_3 in level.players) {
    var_3 thread scripts\cp\cp_hud_message::tutorialprint(&"CP_STRIKE/TIE", 4);
  }

  goto LOC_000000a7;
}

function on_spawn_terrorist_player(var_0) {
  var_0.self_revive = 1;
  var_0 scripts\cp\utility::allow_player_ignore_me(1);
  var_0.unable_to_trigger_radius_detection_monitor = 1;
  var_0.terrorist_overlay = scripts\cp\utility::create_client_overlay("ui_scarf_overlay", 1, self);
}

function terrorists_respawn(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_0 endon("disconnect");
  exit_ragdoll_focus_camera(var_0);
  var_4 = spawn("script_model", var_0.origin + (0, 0, 100));
  var_4 setModel("tag_origin");
  var_4.angles = vectortoangles((0, 0, -1));
  var_0 cameralinkTo(var_4, "tag_origin");
  var_0.terrorist_respawn_camera = var_4;
  thread delay_turn_on_birds_eye_hud(var_0, var_0);
  thread play_marker_vfx_on_enemy_players(var_0);
  thread play_marker_vfx_on_friendly_players(var_0);
  thread terrorist_move_through_respawners_think(var_0, var_0, var_1, var_2);
  var_5 = getassignedspawnpointbasedonteam(var_0);
  var_0 setOrigin(var_5.origin, 1);
  var_0 waittill("terrorist_resapwns", var_6);
  thread play_terrorist_respawn_music();
  stop_marker_vfx_on_enemy_players(var_0, var_0);
  stop_marker_vfx_on_friendly_players(var_0, var_0);
  delete_respawner_markers(var_0);
  terrorist_camera_move_to(var_6.origin + (0, 0, 85), var_0);
  var_0.terrorist_respawn_camera delete();
  var_0 setclientomnvar("ui_birds_eye_view", 0);
  var_0 cameraunlink();
  var_0 setOrigin(var_6.origin);

  if(isDefined(var_6.angles)) {
    var_0 setplayerangles(var_6.angles);
  }

  var_0 allowmovement(1);
  var_0 allowjump(1);
  var_0 playershow();
  var_0 enableweapons();
  var_0.waiting_to_spawn = 0;
  var_0.terrorist_overlay = scripts\cp\utility::create_client_overlay("ui_scarf_overlay", 1, var_0);
  change_to_terrorist_archetype_selected(var_0, var_0);
  thread delay_play_marker_vfx_to_players_waiting_to_respawn(var_0);
}

function delay_turn_on_birds_eye_hud(var_0, var_1) {
  level endon("game_ended");
  level endon("pvpe_end_game");
  var_0 endon("disconnect");

  if(game["in_pvpe_end_game"] == 1) {
    return;
  }

  if(istrue(var_1)) {
    var_0 waittill("revive");
  }

  thread archetype_selection_monitor(var_0);
  var_0 setclientomnvar("ui_birds_eye_view", 1);
}

function archetype_selection_monitor(var_0) {
  var_0 endon("disconnect");
  var_0 endon("terrorist_resapwns");
  var_0.terrorist_archetype_selected = 0;

  for(;;) {
    var_0 waittill("luinotifyserver", var_1, var_2);

    if(isDefined(var_1) && var_1 == "respawn_type_highlighted") {
      var_0.terrorist_archetype_selected = var_2;
    }
  }
}

function stop_marker_vfx_on_enemy_players(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      continue;
    }

    if(var_2.team_number == 1) {
      continue;
    }

    stopfxontagforclients(level._effect["pvpe_enemy_marker"], var_2, "tag_origin", var_0);
  }
}

function stop_marker_vfx_on_friendly_players(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      continue;
    }

    if(var_2.team_number == 0) {
      continue;
    }

    stopfxontagforclients(level._effect["pvpe_friendly_marker"], var_2, "tag_origin", var_0);
  }
}

function delete_respawner_markers(var_0) {
  if(isDefined(var_0.terrorist_selected_respawner_marker)) {
    var_0.terrorist_selected_respawner_marker delete();
  }

  foreach(var_2 in var_0.terrorist_nearby_respawner_markers) {
    if(isDefined(var_2)) {
      var_2 delete();
    }
  }

  reset_respawner_markers(var_0);
}

function play_terrorist_respawn_music() {
  var_0 = "terrorist_respawn";
  var_1 = 7;

  if(istrue(level.playing_terrorist_respawn_music)) {
    return;
  }

  level.playing_terrorist_respawn_music = 1;

  foreach(var_3 in level.players) {
    var_3 playlocalsound(var_0);
  }

  wait var_1;
  level.playing_terrorist_respawn_music = 0;
}

function play_marker_vfx_on_enemy_players(var_0) {
  var_0 endon("disconnect");
  var_0 endon("terrorist_resapwns");

  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      continue;
    }

    if(var_2.team_number == 1) {
      continue;
    }

    playfxontagforclients(level._effect["pvpe_enemy_marker"], var_2, "tag_origin", var_0);
    waitframe();
  }
}

function delay_play_marker_vfx_to_players_waiting_to_respawn(var_0) {
  var_0 endon("disconnect");
  var_0 endon("terrorist_resapwns");
  wait 0.5;

  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      continue;
    }

    if(var_2.team_number == 0) {
      continue;
    }

    if(istrue(var_2.waiting_to_spawn)) {
      play_marker_vfx_on_friendly_player(var_0, var_2);
    }

    waitframe();
  }
}

function play_marker_vfx_on_friendly_players(var_0) {
  var_0 endon("disconnect");
  var_0 endon("terrorist_resapwns");

  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      continue;
    }

    if(var_2.team_number == 0) {
      continue;
    }

    if(istrue(var_2.waiting_to_spawn)) {
      continue;
    }

    play_marker_vfx_on_friendly_player(var_2, var_0);
    waitframe();
  }
}

function play_marker_vfx_on_friendly_player(var_0, var_1) {
  playfxontagforclients(level._effect["pvpe_friendly_marker"], var_0, "tag_origin", var_1);
  thread stop_marker_vfx_on_friendly_player_think(var_0, var_0);
}

function stop_marker_vfx_on_friendly_player_think(var_0, var_1) {
  var_1 endon("disconnect");
  var_1 endon("terrorist_resapwns");
  var_0 waittill("last_stand");
  stopfxontagforclients(level._effect["pvpe_friendly_marker"], var_0, "tag_origin", var_1);
}

function terrorist_move_through_respawners_think(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("terrorist_resapwns");
  reset_respawner_markers(var_0);
  mark_selected_terrorist_respawner(var_0, var_1);
  move_terrorist_respawn_camera(var_0, var_0);
  thread terrorist_decide_respawn_think(var_0, var_0);
  thread respawn_camera_movement_think(var_0);
  thread respawner_selection_think(var_0, var_0);
}

function respawner_selection_think(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("terrorist_resapwns");

  for(;;) {
    if(isDefined(var_0.terrorist_respawner_selected) && distance2dsquared(var_0.terrorist_respawner_selected.origin, var_0.terrorist_respawn_camera.origin) > 40000) {
      unmark_selected_terrorist_respawner(var_0);
    }

    if(istrue(var_0.moving_respawn_camera)) {
      foreach(var_3 in var_1) {
        if(distance2dsquared(var_0.terrorist_respawn_camera.origin, var_3.origin) <= 40000) {
          mark_selected_terrorist_respawner(var_0, var_3);
          continue;
        }

        if(distance2dsquared(var_0.terrorist_respawn_camera.origin, var_3.origin) <= 100000000) {
          show_terrorist_respawner(var_0, var_3);
          continue;
        }

        unshow_terrorist_respawner(var_0, var_3);
      }
    }

    waitframe();
  }
}

function show_terrorist_respawner(var_0, var_1) {
  if(scripts\engine\utility::array_contains(var_0.terrorist_nearby_respawners, var_1)) {
    return;
  }

  var_2 = spawnfxforclient(level._effect["pvpe_nearby_spawner"], get_adjusted_marker_vfx_pos(var_1.origin) + (0, 0, 50), var_0, (0, 0, 1), (1, 0, 0));
  triggerfx(var_2);
  var_1.marker_vfx = var_2;
  var_0.terrorist_nearby_respawner_markers[var_0.terrorist_nearby_respawner_markers.size] = var_2;
  var_0.terrorist_nearby_respawners[var_0.terrorist_nearby_respawners.size] = var_1;
}

function unshow_terrorist_respawner(var_0, var_1) {
  if(scripts\engine\utility::array_contains(var_0.terrorist_nearby_respawners, var_1)) {
    var_1.marker_vfx delete();
    var_0.terrorist_nearby_respawners = scripts\engine\utility::array_remove(var_0.terrorist_nearby_respawners, var_1);
    return;
  }
}

function unmark_selected_terrorist_respawner(var_0) {
  var_0.terrorist_respawner_selected = undefined;

  if(isDefined(var_0.terrorist_selected_respawner_marker)) {
    var_0.terrorist_selected_respawner_marker delete();
  }

  if(game["in_pvpe_end_game"] == 0) {
    if(!istrue(var_0.in_respawn_delay)) {
      var_0 scripts\cp\utility::hint_prompt("respawn_hint", 0);
      var_0 scripts\cp\utility::hint_prompt("select_respawner", 1);
      return;
    }

    return;
  }
}

function respawn_camera_movement_think(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("terrorist_resapwns");
  var_1 = 150;
  var_0.moving_respawn_camera = 0;

  for(;;) {
    var_2 = var_0 getnormalizedmovement();
    var_3 = var_2[0];
    var_4 = var_2[1];

    if(player_moving_respawn_camera(var_3, var_4)) {
      var_0.moving_respawn_camera = 1;
      var_5 = (var_3 * var_1, var_4 * var_1 * -1, 0);
      var_6 = var_0.terrorist_respawn_camera.origin + var_5;
      terrorist_camera_move_to(var_6, var_0);
    } else {
      var_0.moving_respawn_camera = 0;
    }

    waitframe();
  }
}

function wait_for_global_respawn_timer() {
  level waittill("terrorist_players_respawn_timer_at", var_0);
  wait var_0;
}

function terrorist_decide_respawn_think(var_0, var_1) {
  level endon("game_ended");
  level endon("pvpe_end_game");
  var_0 endon("disconnect");

  if(game["in_pvpe_end_game"] == 1) {
    return;
  }

  if(istrue(var_1)) {
    var_0 waittill("revive");
    var_0 scripts\cp\utility::hint_prompt("respawn_cooldown", 1);
    var_0.in_respawn_delay = 1;
    var_0 setclientomnvar("cp_show_wave_timer", 1);
    wait_for_global_respawn_timer();
    var_0 setclientomnvar("cp_show_wave_timer", 0);
    var_0 scripts\cp\utility::hint_prompt("respawn_cooldown", 0);
    var_0.in_respawn_delay = 0;
  }

  if(isDefined(var_0.terrorist_respawner_selected)) {
    var_0 scripts\cp\utility::hint_prompt("respawn_hint", 1);
  } else {
    var_0 scripts\cp\utility::hint_prompt("select_respawner", 1);
  }

  var_0 notifyonplayercommand("terrorist_selected_a_respawner", "+goStand");

  for(;;) {
    var_0 waittill("terrorist_selected_a_respawner");

    if(isDefined(var_0.terrorist_respawner_selected)) {
      break;
    }
  }

  var_0 scripts\cp\utility::hint_prompt("respawn_hint", 0);
  var_0 scripts\cp\utility::hint_prompt("select_respawner", 0);
  var_0 notify("terrorist_resapwns", var_0.terrorist_respawner_selected);
}

function move_terrorist_respawn_camera(var_0) {
  var_1 = var_0.terrorist_respawner_selected;
  var_2 = (var_1.origin[0], var_1.origin[1], var_1.origin[2] + 4000);
  terrorist_camera_move_to(var_2, var_0);
}

function terrorist_camera_move_to(var_0, var_1) {
  var_2 = distance(var_1.terrorist_respawn_camera.origin, var_0);
  var_3 = var_2 / 7000;
  var_1.terrorist_respawn_camera moveTo(var_0, var_3);
  wait var_3;
}

function reset_respawner_markers(var_0) {
  var_0.terrorist_nearby_respawners = [];
  var_0.terrorist_nearby_respawner_markers = [];
  var_0.terrorist_selected_respawner_marker = undefined;
}

function mark_selected_terrorist_respawner(var_0, var_1) {
  if(isDefined(var_0.terrorist_respawner_selected) && var_0.terrorist_respawner_selected == var_1) {
    return;
  }

  if(game["in_pvpe_end_game"] == 0) {
    if(!istrue(var_0.in_respawn_delay)) {
      var_0 scripts\cp\utility::hint_prompt("select_respawner", 0);
      var_0 scripts\cp\utility::hint_prompt("respawn_hint", 1);
    }
  }

  var_0.terrorist_respawner_selected = var_1;
  var_2 = spawnfxforclient(level._effect["pvpe_selected_spawner"], get_adjusted_marker_vfx_pos(var_0.terrorist_respawner_selected.origin) + (0, 0, 50), var_0, (0, 0, 1), (1, 0, 0));
  triggerfx(var_2);
  var_0.terrorist_selected_respawner_marker = var_2;
}

function get_closest_respawner_on_direction(var_0, var_1) {
  var_2 = scripts\engine\utility::getStructArray("terrorist_player_respawn", "targetname");

  if(isDefined(var_1)) {
    var_3 = get_respawners_in_desired_direction(var_0, var_1, var_2);

    if(var_3.size > 0) {
      return scripts\engine\utility::getclosest(var_0, var_3);
    }

    return undefined;
  }

  return scripts\engine\utility::getclosest(var_0, var_2);
}

function get_respawners_in_desired_direction(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = var_5.origin - var_0;
    var_6 = (var_6[0], var_6[1], 0);

    if(distance2dsquared(var_0, var_5.origin) < 2500) {
      continue;
    }

    if(vectordot(var_6, var_1) > 0) {
      var_3 = var_5;
    }
  }

  return var_3;
}

function getassignedspawnpointbasedonteam(var_0) {
  var_1 = get_spawn_point_targetname(var_0);
  var_2 = scripts\engine\utility::getStructArray(var_1, "targetname");
  var_3 = var_2[var_0.slot_number];
  return var_3;
}

function get_spawn_point_targetname(var_0) {
  if(var_0.team_number == 0) {
    return "default_player_start";
  }

  return "terrorist_player_start";
}

function update_respawners_vfx(var_0) {
  delete_respawner_markers(var_0);
  var_1 = spawnfxforclient(level._effect["pvpe_selected_spawner"], get_adjusted_marker_vfx_pos(var_0.terrorist_respawner_selected.origin) + (0, 0, 50), var_0, (0, 0, 1), (1, 0, 0));
  triggerfx(var_1);
  var_0.terrorist_selected_respawner_marker = var_1;
  var_2 = get_nearby_respawners(var_0);
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = spawnfxforclient(level._effect["pvpe_nearby_spawner"], get_adjusted_marker_vfx_pos(var_5.origin) + (0, 0, 50), var_0, (0, 0, 1), (1, 0, 0));
    triggerfx(var_6);
    var_3 = var_6;
  }

  var_0.terrorist_nearby_respawner_markers = var_3;
}

function get_nearby_respawners(var_0) {
  var_1 = [];
  var_2 = ["move_to_respawner_on_the_up", "move_to_respawner_on_the_down", "move_to_respawner_on_the_left", "move_to_respawner_on_the_right"];

  foreach(var_4 in var_2) {
    var_5 = get_closest_respawner_on_direction(var_0.terrorist_respawner_selected.origin, get_desired_direction_based_on_input(var_4));

    if(isDefined(var_5) && !scripts\engine\utility::array_contains(var_1, var_5)) {
      var_1 = var_5;
    }
  }

  return var_1;
}

function get_desired_direction_based_on_input(var_0) {
  switch (var_0) {
    case "move_to_respawner_on_the_up":
      return (1, 0, 0);
    case "move_to_respawner_on_the_down":
      return (-1, 0, 0);
    case "move_to_respawner_on_the_left":
      return (0, 1, 0);
    case "move_to_respawner_on_the_right":
      return (0, -1, 0);
  }
}

function player_moving_respawn_camera(var_0, var_1) {
  if(abs(var_0) != 0) {
    return true;
  }

  if(abs(var_1) != 0) {
    return true;
  }

  return false;
}

function get_adjusted_marker_vfx_pos(var_0) {
  return scripts\engine\trace::ray_trace_detail(var_0 + (0, 0, 5000), var_0)["position"];
}

function initialize_player_team_slot_assignment() {
  var_0 = [];

  for(var_1 = 0; var_1 < 4; var_1++) {
    var_0 = var_1;
  }

  for(var_2 = 0; var_2 < 5; var_2++) {
    var_0 = scripts\engine\utility::array_randomize(var_0);
  }

  var_3 = [];

  for(var_4 = 0; var_4 < 4; var_4++) {
    var_3 = var_4;
  }

  for(var_5 = 0; var_5 < 5; var_5++) {
    var_3 = scripts\engine\utility::array_randomize(var_3);
  }

  level.team_id_one_slot_assignment_index = 0;
  level.team_id_zero_slot_assignment_index = 0;
  level.team_id_one_slot_index_list = var_0;
  level.team_id_zero_slot_index_list = var_3;
}

function assign_pvpe_team_and_slot_number(var_0) {
  var_1 = var_0 getplayerdata("cp", "CPSession", "subParty");
  var_2 = get_team_and_slot_number_struct(var_0, var_1);
  var_3 = var_2.team_number;
  var_4 = var_2.slot_number;
  var_0.team_number = var_3;
  var_0.slot_number = var_4;
  var_0.team_and_slot_number_struct = var_2;
  set_player_playing_as_terrorist_omnvar(var_0);
  assign_player_team(var_0);

  if(game["round_number"] == 1) {
    var_0 setclientomnvar("cp_player_team_num", var_3);
  }

  if(should_disable_infil_for_player(var_0)) {
    disableplayerinfil(var_0);
    return;
  }
}

function assign_player_team(var_0) {
  if(var_0.team_number == 0) {
    var_0.pers["team"] = "allies";
    return;
  }

  var_0.pers["team"] = "axis";
}

function should_disable_infil_for_player(var_0) {
  return player_is_terrorist(var_0);
}

function disableplayerinfil(var_0) {
  var_0.infil_disabled = 1;
}

function terrorist_self_revive_time_override(var_0) {
  if(var_0.team_number == 1) {
    var_0.self_revive_wait_override = 0.05;
    return;
  }
}

function get_team_and_slot_number_struct(var_0, var_1) {
  if(player_in_party(var_1)) {
    return get_team_id_zero_assignment_first(var_0);
  }

  return get_team_id_one_assignment_first(var_0);
}

function get_team_id_zero_assignment_first(var_0) {
  if(more_team_id_zero_slot_available()) {
    return make_team_id_zero_team_and_slot_number_struct(var_0);
  }

  return make_team_id_one_team_and_slot_number_struct(var_0);
}

function more_team_id_zero_slot_available() {
  return level.team_id_zero_slot_assignment_index < 4;
}

function make_team_id_zero_team_and_slot_number_struct(var_0) {
  var_1 = get_team_id_zero_slot();
  var_2 = get_team_number(var_0, 0);
  return make_team_and_slot_number_struct(var_2, var_1);
}

function make_team_id_one_team_and_slot_number_struct(var_0) {
  var_1 = get_team_id_one_slot();
  var_2 = get_team_number(var_0, 1);
  return make_team_and_slot_number_struct(var_2, var_1);
}

function get_team_number(var_0, var_1) {
  if(game["round_number"] == 1) {
    if(isDefined(game["name_to_team_id_mapping"][tolower(var_0.name)])) {
      var_2 = game["team_id_to_team_number_mapping"][game["name_to_team_id_mapping"][tolower(var_0.name)]];
    } else if(player_selected_team_in_front_end(var_1)) {
      var_2 = game["session_team_to_team_number_mapping"][var_1.sessionteam];
    } else {
      var_2 = game["team_id_to_team_number_mapping"][var_2];
    }

    if(var_2.sessionteam == "allies") {
      var_2 = 0;
    } else if(var_2.sessionteam == "axis") {
      var_2 = 1;
    }

    var_2.pers["pvpe_round_one_team_number"] = var_2;
    return var_2;
  }

  if(game["round_number"] == 2) {
    switch (var_2.pers["pvpe_round_one_team_number"]) {
      case 0:
        return 1;
      case 1:
        return 0;
    }

    return;
  }
}

function set_player_playing_as_terrorist_omnvar(var_0) {
  if(var_0.team_number == 1) {
    var_0 setclientomnvar("cp_play_terrorist", 1);
    return;
  }

  var_0 setclientomnvar("cp_play_terrorist", 0);
}

function player_selected_team_in_front_end(var_0) {
  if(isDefined(var_0.sessionteam)) {
    return (var_0.sessionteam == "axis" || var_0.sessionteam == "allies");
  }

  return false;
}

function get_team_id_zero_slot() {
  var_0 = level.team_id_zero_slot_index_list[level.team_id_zero_slot_assignment_index];
  level.team_id_zero_slot_assignment_index++;
  return var_0;
}

function make_team_and_slot_number_struct(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.team_number = var_0;
  var_2.slot_number = var_1;
  return var_2;
}

function get_team_id_one_slot() {
  var_0 = level.team_id_one_slot_index_list[level.team_id_one_slot_assignment_index];
  level.team_id_one_slot_assignment_index++;
  return var_0;
}

function player_in_party(var_0) {
  return var_0 != -1;
}

function get_team_id_one_assignment_first(var_0) {
  if(more_team_one_slot_available()) {
    return make_team_id_one_team_and_slot_number_struct(var_0);
  }

  return make_team_id_zero_team_and_slot_number_struct(var_0);
}

function more_team_one_slot_available() {
  return level.team_id_one_slot_assignment_index < 4;
}

function pvpe_force_end_game() {
  level thread scripts\cp\cp_endgame::endgame(get_winning_team_name(), scripts\cp\cp_endgame::get_end_game_string_index("host_end"));
}

function pvpe_end_game(var_0, var_1) {
  level notify("pvpe_end_game");
  game["in_pvpe_end_game"] = 1;
  turn_off_players_birds_view_hud();

  if(pvpe_game_should_really_end()) {
    scripts\cp\cp_endgame::endgame(var_0, var_1);
    return;
  }

  foreach(var_3 in level.players) {
    var_3 thread scripts\cp\cp_hud_message::tutorialprint(&"CP_STRIKE/SWITCHING_SIDE", 5);
  }

  scripts\cp\cp_endgame::freezeallplayers(1, "cg_fovScale", 1);
  wait 5;
  setomnvar("allow_server_pause", 1);
  setomnvarforallclients("post_game_state", 0);
  map_restart(1);
}

function turn_off_players_birds_view_hud() {
  foreach(var_1 in level.players) {
    var_1 setclientomnvar("ui_birds_eye_view", 0);
    var_1 scripts\cp\utility::hint_prompt("respawn_cooldown", 0);
    var_1 scripts\cp\utility::hint_prompt("respawn_hint", 0);
    var_1 scripts\cp\utility::hint_prompt("select_respawner", 0);
  }
}

function pvpe_game_should_really_end() {
  return game["round_number"] == 2;
}

function delay_give_archetype_loadout(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 waittill("loadout_given");
  remove_all_primaries_weapon(var_0);

  if(!isDefined(var_0.terrorist_archetype_selected)) {
    give_default_terrorist_loadout(var_0, var_0);
    return;
  }
}

function remove_all_powers(var_0) {
  foreach(var_2 in var_0.powers) {
    var_0 scripts\cp\cp_powers::removepower(var_3);
  }
}

function give_poison_gas_loadout(var_0) {
  var_1 = scripts\cp\cp_weapon::buildweapon("iw8_fists_mp", [], "none", "none", -1);
  var_0 giveweapon(var_1);
  var_0 switchtoweaponimmediate(var_1);
  var_0 thread scripts\cp\cp_powers::givepower("power_molotov", "primary", undefined, undefined, undefined, undefined, 1, 5);
  var_0 thread scripts\cp\cp_powers::givepower("power_c4", "secondary", undefined, undefined, undefined, undefined, 1, 1);
}

function give_kidnapper_loadout(var_0) {
  var_1 = scripts\cp\cp_weapon::buildweapon("iw8_knife_mp", [], "none", "none", -1);
  var_0 giveweapon(var_1);
  var_0 switchtoweaponimmediate(var_1);
  var_0 setweaponammoclip("super_default_zm", 1);
  var_0 thread scripts\cp\cp_powers::givepower("power_throwingKnife", "primary", undefined, undefined, undefined, undefined, 1, 2);
  var_0 thread scripts\cp\cp_powers::givepower("power_smokeGrenade", "secondary", undefined, undefined, undefined, undefined, 1, 2);
  thread kidnapper_enable_execute(var_0);
  thread kidnapper_target_think(var_0);
  thread kidnapper_disguise_think(var_0);
  thread kidnapper_clean_up(var_0);
}

function kidnapper_clean_up(var_0) {
  var_0 endon("disconnect");
  var_0 scripts\engine\utility::ref_143a5("last_stand", "disguise success");
  var_0 scripts\cp\utility::hint_prompt("start_disguise", 0);
  unmark_kidnapper_target(var_0, var_0);
  var_0 setclientomnvar("ui_securing_progress", 0);
  var_0 setclientomnvar("ui_securing", 0);
  level.execute_entities = scripts\engine\utility::array_removeundefined(level.execute_entities);

  foreach(var_2 in level.execute_entities) {
    var_2 disableplayeruse(var_0);
  }
}

function kidnapper_laststand_hero_watcher() {
  level endon("game_ended");
  level.execute_entities = [];

  for(;;) {
    level waittill("waiting_to_be_revived_from_laststand", var_0);

    if(var_0.team_number == 1) {
      continue;
    }

    var_1 = scripts\cp\cp_laststand::makeexecuteentity(var_0, var_0.origin);
    disable_all_players_use(var_1, var_1);
    level.execute_entities[level.execute_entities.size] = var_1;
    level notify("new_execute_entity", var_1);
  }
}

function disable_all_players_use(var_0) {
  foreach(var_2 in level.players) {
    var_0 disableplayeruse(var_2);
  }
}

function kidnapper_enable_execute(var_0) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  level.execute_entities = scripts\engine\utility::array_removeundefined(level.execute_entities);

  foreach(var_2 in level.execute_entities) {
    var_2 enableplayeruse(var_0);
  }

  for(;;) {
    level waittill("new_execute_entity", var_4);
    var_4 enableplayeruse(var_0);
  }
}

function kidnapper_disguise_think(var_0) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("disguise success");

  for(;;) {
    wait_for_super_button_pressed(var_0);

    if(isDefined(var_0.kidnapper_target_player)) {
      var_1 = var_0.kidnapper_target_player;
      var_0 scripts\cp\utility::hint_prompt("start_disguise", 0);
      var_0.is_putting_on_disguise = 1;
      var_0 cameraset("camera_custom_orbit_0_noremote");
      var_2 = super_hold_think(var_0, 13, 1.5);

      if(var_2 == "success") {
        disguise_as_enemy(var_0, var_0, var_1);
        var_0 scripts\cp\utility::_setperk("specialty_spygame");
        thread remove_spygame_when_down(var_0);
        wait 0.5;
        var_0.is_putting_on_disguise = 0;
        var_0 cameradefault();
        var_0 notify("disguise success");
      } else {
        var_0.is_putting_on_disguise = 0;
        var_0 cameradefault();
      }
    }
  }
}

function remove_spygame_when_down(var_0) {
  var_0 endon("disconnect");
  var_0 waittill("last_stand");
  var_0 scripts\cp\utility::_unsetperk("specialty_spygame");
}

function disguise_as_enemy(var_0, var_1) {
  var_0 setcustomization(var_1.setcustomization_body, var_1.setcustomization_head);
  var_2 = var_1.bodymodel;
  var_3 = var_1.headmodel;
  var_4 = var_1.viewmodel;
  change_to_terrorist_model_internal(var_0, var_2, var_3, var_4);
}

function wait_for_super_button_pressed(var_0) {
  for(;;) {
    var_0 waittill("offhand_fired", var_1);

    if(issameweapon(var_1) && createheadicon(var_1) == "super_default_zm") {
      var_0 setweaponammoclip("super_default_zm", 1);
      return;
    }
  }
}

function kidnapper_target_think(var_0) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 endon("disguise success");

  for(;;) {
    var_1 = get_all_hero_players();
    var_2 = [];

    foreach(var_4 in var_1) {
      var_5 = is_hero_player_within_reticle(var_4, var_0);

      if(var_5) {
        var_6 = does_hero_player_pass_traces(var_4, var_0);

        if(var_6) {
          var_2 = var_4;
        }
      }

      waitframe();
    }

    if(var_2.size > 0) {
      if(!istrue(var_0.is_putting_on_disguise)) {
        var_0 scripts\cp\utility::hint_prompt("start_disguise", 1);
      }

      var_8 = scripts\engine\utility::getclosest(var_0.origin, var_2);

      if(isDefined(var_0.kidnapper_target_player)) {
        if(var_0.kidnapper_target_player != var_8) {
          unmark_kidnapper_target(var_0);
          mark_hero_as_kidnapper_target(var_8, var_0);
        }
      } else {
        mark_hero_as_kidnapper_target(var_8, var_0);
      }
    } else {
      var_0 scripts\cp\utility::hint_prompt("start_disguise", 0);
      unmark_kidnapper_target(var_0);
    }

    waitframe();
  }
}

function mark_hero_as_kidnapper_target(var_0, var_1) {
  var_0 hudoutlineenableforclient(var_1, "outline_depth_red");
  var_1.kidnapper_target_player = var_0;
}

function unmark_kidnapper_target(var_0) {
  if(isDefined(var_0.kidnapper_target_player)) {
    var_0.kidnapper_target_player hudoutlinedisableforclient(var_0);
    var_0.kidnapper_target_player = undefined;
    return;
  }
}

function does_hero_player_pass_traces(var_0, var_1) {
  var_2 = physics_createcontents(["physicscontents_solid", "physicscontents_ainosight"]);

  if(scripts\engine\trace::ray_trace_passed(var_1 getEye(), var_0 getEye(), [var_1], var_2)) {
    return true;
  }

  if(scripts\engine\trace::ray_trace_passed(var_1 getEye(), var_0.origin, [var_1], var_2)) {
    return true;
  }

  return false;
}

function is_hero_player_within_reticle(var_0, var_1) {
  if(var_1 worldpointinreticle_circle(var_0 getEye(), 65, 115)) {
    return true;
  }

  if(var_1 worldpointinreticle_circle(var_0.origin, 65, 115)) {
    return true;
  }

  return false;
}

function get_all_hero_players() {
  var_0 = [];

  if(!isDefined(level.players)) {
    return var_0;
  }

  foreach(var_2 in level.players) {
    if(var_2.team_number == 0) {
      var_0 = var_2;
    }
  }

  return var_0;
}

function give_suicide_bomber_loadout(var_0) {
  thread suicide_bomber_think(var_0);
  thread suicide_bomber_clean_up(var_0);
}

function suicide_bomber_think(var_0) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_1 = scripts\cp\cp_weapon::buildweapon("iw8_fists_mp", [], "none", "none", -1);
  var_0 giveweapon(var_1);
  var_0 switchtoweaponimmediate(var_1);
  var_0 scripts\cp\utility::hint_prompt("activate_suicide_vest", 1);
  var_0 notifyonplayercommand("activate_suicide_vest", "+usereload");
  var_0 notifyonplayercommand("finish_activate_suicide_vest", "-usereload");
  var_0 notifyonplayercommand("detonate_suicide_vest", "+usereload");

  for(;;) {
    var_0 waittill("activate_suicide_vest");
    var_0 playLoopSound("cp_suicide_vest_slow_beep");
    var_2 = use_hold_think(var_0, 13, 3.5);
    var_0 stoploopsound("cp_suicide_vest_slow_beep");

    if(var_2 == "success") {
      break;
    }
  }

  var_0 playLoopSound("cp_suicide_vest_fast_beep");
  thread suicide_vest_timer(var_0);
  thread target_within_range_think(var_0);
  var_0 scripts\cp\utility::hint_prompt("activate_suicide_vest", 0);
  var_0 scripts\cp\utility::hint_prompt("detonate_suicide_vest", 1);
  var_0 waittill("finish_activate_suicide_vest");
  var_0 waittill("detonate_suicide_vest");
  var_0 stoploopsound("cp_suicide_vest_fast_beep");
  var_0 scripts\cp\utility::hint_prompt("detonate_suicide_vest", 0);
  thread suicide_bomber_explodes(var_0, var_0);
}

function target_within_range_think(var_0) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");

  for(;;) {
    var_1 = get_potential_hero_players_as_target();
    var_2 = [];

    foreach(var_4 in var_1) {
      if(distancesquared(var_0.origin, var_4.origin) <= 50625) {
        var_2 = var_4;
      }
    }

    var_0.potential_hero_players_as_target_in_range = var_2;

    foreach(var_7 in level.players) {
      if(scripts\engine\utility::array_contains(var_0.potential_hero_players_as_target_in_range, var_7)) {
        var_7 hudoutlineenableforclient(var_0, "outlinefill_depth_orange");
        continue;
      }

      var_7 hudoutlinedisableforclient(var_0);
    }

    waitframe();
  }
}

function get_potential_hero_players_as_target() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(var_2.team_number == 1) {
      continue;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(var_2)) {
      continue;
    }

    var_0 = var_2;
  }

  return var_0;
}

function suicide_bomber_clean_up(var_0) {
  var_0 endon("disconnect");
  var_0 waittill("last_stand");
  var_0 stoploopsound("cp_suicide_vest_slow_beep");
  var_0 stoploopsound("cp_suicide_vest_fast_beep");
  var_0 scripts\cp\utility::hint_prompt("activate_suicide_vest", 0);
  var_0 scripts\cp\utility::hint_prompt("detonate_suicide_vest", 0);

  foreach(var_2 in level.players) {
    var_2 hudoutlinedisableforclient(var_0);
  }
}

function suicide_bomber_explodes(var_0, var_1) {
  var_0 endon("disconnect");
  var_0 setclientomnvar("ui_securing_progress", 0);
  var_0 setclientomnvar("ui_securing", 0);
  var_0 playSound("cp_suicide_vest_explo_lr");
  playFX(level._effect["pvpe_suicide_bomber_explo"], var_0.origin);
  earthquake(0.3, 1.5, var_0.origin, 150);
  do_damage_to_target_in_range(var_0);

  if(istrue(var_1)) {
    var_0 dodamage(var_0.health + 50, var_0.origin);
    return;
  }
}

function do_damage_to_target_in_range(var_0) {
  var_1 = 0;

  if(isDefined(var_0.potential_hero_players_as_target_in_range)) {
    foreach(var_3 in var_0.potential_hero_players_as_target_in_range) {
      if(isDefined(var_3) && !scripts\cp\cp_laststand::player_in_laststand(var_3)) {
        var_3 dodamage(500, var_0.origin);
        var_1++;
      }
    }
  }

  if(var_1 > 0) {
    var_0 iprintlnbold("^1" + var_1 + "^7 target(s) killed!");
    var_0 thread scripts\cp\cp_damagefeedback::updatedamagefeedback("hitlaststand");
    return;
  }
}

function suicide_vest_timer(var_0) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_1 = 5;
  wait var_1;

  for(var_2 = 5; var_2 > 0; var_2--) {
    var_0 iprintlnbold("Suicide vest exploding in ... " + var_2);
    wait 1;
  }

  thread suicide_bomber_explodes(var_0, var_0);
}

function super_hold_think(var_0, var_1, var_2) {
  var_3 = 0;
  var_0 setclientomnvar("ui_securing", var_1);
  var_0 notifyonplayercommand("release_LB", "-smoke");
  var_0 notifyonplayercommand("release_RB", "-frag");

  for(;;) {
    var_4 = var_0 scripts\engine\utility::waittill_any_in_array_or_timeout(["release_LB", "release_RB"], 0.05);

    if(var_4 == "timeout") {
      var_3 += 0.05;
      var_0 setclientomnvar("ui_securing_progress", var_3 / var_2);

      if(var_3 >= var_2) {
        var_0 setclientomnvar("ui_securing_progress", 1);
        thread delay_hide_progress_widget(var_0);
        return "success";
      }

      continue;
    }

    var_0 setclientomnvar("ui_securing_progress", 0);
    var_0 setclientomnvar("ui_securing", 0);
    return "fail";
  }
}

function delay_hide_progress_widget(var_0) {
  var_0 endon("disconnect");
  waitframe();
  var_0 setclientomnvar("ui_securing", 0);
}

function use_hold_think(var_0, var_1, var_2) {
  var_3 = 0;
  var_0 setclientomnvar("ui_securing", var_1);

  for(;;) {
    waitframe();

    if(var_0 useButtonPressed()) {
      var_3 += 0.05;
      var_0 setclientomnvar("ui_securing_progress", var_3 / var_2);

      if(var_3 >= var_2) {
        var_0 setclientomnvar("ui_securing_progress", 1);
        thread delay_hide_progress_widget(var_0);
        return "success";
      }

      continue;
    }

    var_0 setclientomnvar("ui_securing_progress", 0);
    var_0 setclientomnvar("ui_securing", 0);
    return "fail";
  }
}

function give_armor_loadout(var_0) {
  var_1 = scripts\cp\cp_weapon::buildweapon("iw8_sh_charlie725_mp", [], "none", "none", -1);
  var_0 giveweapon(var_1);
  var_0 setweaponammoclip(var_1, weaponclipsize(var_1));
  var_0 setweaponammostock(var_1, weaponmaxammo(var_1));
  var_1 = scripts\cp\cp_weapon::buildweapon("iw8_me_riotshield_mp", [], "none", "none", -1);
  var_0 giveweapon(var_1);
  var_0 switchtoweaponimmediate(var_1);
}

function give_long_range_loadout(var_0) {
  var_1 = scripts\cp\cp_weapon::buildweapon("iw8_sn_alpha50_mp", ["laserads"], "none", "none", -1);
  var_0 giveweapon(var_1);
  var_0 setweaponammoclip(var_1, weaponclipsize(var_1));
  var_0 setweaponammostock(var_1, weaponmaxammo(var_1));
  var_0 switchtoweaponimmediate(var_1);
  thread long_range_laser_ent_think(var_0);
  thread long_range_laser_vfx_think(var_0);
}

function long_range_laser_ent_think(var_0) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_1 = spawn("script_model", var_0 gettagorigin("j_wrist_le"));
  var_1 setModel("tag_origin");
  var_1 linkTo(var_0, "j_wrist_le");
  thread laser_ent_clean_up_monitor(var_1, var_1);
  var_0.laser_start_ent = var_1;
  var_2 = spawn("script_model", var_0 gettagorigin("tag_eye"));
  var_2 setModel("tag_origin");
  thread laser_ent_clean_up_monitor(var_2, var_2);
  var_0.laser_end_ent = var_2;
  var_3 = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_ainosight"]);

  for(;;) {
    var_4 = var_0 gettagorigin("tag_eye");
    var_5 = anglesToForward(var_0 getplayerangles());
    var_6 = var_4 + var_5 * 20000;
    var_7 = scripts\engine\trace::ray_trace(var_4, var_6, undefined, var_3)["position"];
    var_2 moveTo(var_7, 0.1);
    waitframe();
  }
}

function long_range_laser_vfx_think(var_0) {
  var_0 endon("disconnect");
  var_0 endon("last_stand");
  var_0 notifyonplayercommand("long_range_start_ADS", "+speed_throw");

  for(;;) {
    var_0 waittill("long_range_start_ADS");
    var_1 = playfxontagsbetweenclients(level._effect["pvpe_long_range_terrorist_red_laser"], var_0.laser_start_ent, "tag_origin", var_0.laser_end_ent, "tag_origin");
    wait 0.5;

    while(var_0 adsButtonPressed()) {
      waitframe();
    }

    var_1 delete();
  }
}

function laser_ent_clean_up_monitor(var_0, var_1) {
  var_1 scripts\engine\utility::ref_143a5("disconnect", "last_stand");
  var_0 delete();
}

function give_default_terrorist_loadout(var_0) {
  var_1 = scripts\cp\cp_weapon::buildweapon("iw8_pi_mike1911_mp", [], "none", "none", -1);
  var_0 giveweapon(var_1);
  var_0 switchtoweapon(var_1);
}

function precache_pvpe_vfx() {
  level._effect["pvpe_selected_spawner"] = loadfx("vfx/iw8_cp/vfx_marker_selected_spawner.vfx");
  level._effect["pvpe_nearby_spawner"] = loadfx("vfx/iw8_cp/vfx_marker_nearby_spawner.vfx");
  level._effect["pvpe_enemy_marker"] = loadfx("vfx/iw8_cp/vfx_marker_enemy.vfx");
  level._effect["pvpe_friendly_marker"] = loadfx("vfx/iw8_cp/vfx_marker_friendly.vfx");
  level._effect["pvpe_long_range_terrorist_red_laser"] = loadfx("vfx/iw8_cp/vfx_red_laser_cp.vfx");
  level._effect["pvpe_suicide_bomber_explo"] = loadfx("vfx/iw8/weap/_explo/suicide/vfx_explo_suicide_bomb.vfx");
}

function delay_start_gun_game(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 waittill("loadout_given");
  var_1 = get_player_gun_game_level(var_0);
  gun_game_change_to_weapon_at_level(var_0, var_1);
}

function gun_game_change_to_weapon_at_level(var_0, var_1) {
  if(!isDefined(level.max_gun_game_level)) {
    determine_max_gun_game_level();
  }

  if(var_1 > level.max_gun_game_level) {
    return;
  }

  if(!holding_gun_game_max_level_weapon(var_0)) {
    remove_all_primaries_weapon(var_0);
    var_2 = get_gun_game_weapon_at_level(var_1);
    var_3 = scripts\cp\cp_weapon::buildweapon(var_2, [], "none", "none", -1);
    var_0 giveweapon(var_3);
    var_0 switchtoweapon(var_3);
    return;
  }
}

function remove_all_primaries_weapon(var_0) {
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    var_0 takeweapon(var_3);
  }
}

function holding_gun_game_max_level_weapon(var_0) {
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(var_3.basename == level.max_gun_game_weapon_name) {
      return true;
    }
  }

  return false;
}

function get_gun_game_weapon_at_level(var_0) {
  var_1 = tablelookup("cp/cp_gun_game_weapon_progression.csv", 0, var_0, 2);
  return var_1;
}

function determine_max_gun_game_level() {
  level.max_gun_game_level = 0;
  level.max_gun_game_weapon_name = undefined;

  for(var_0 = 1; var_0 <= 100; var_0++) {
    var_1 = tablelookup("cp/cp_gun_game_weapon_progression.csv", 0, var_0, 2);

    if(var_1 == "") {
      break;
    }

    level.max_gun_game_level++;
    level.max_gun_game_weapon_name = var_1;
  }
}

function increase_player_gun_game_level(var_0) {
  if(!isDefined(level.max_gun_game_level)) {
    determine_max_gun_game_level();
  }

  if(!isDefined(level.players_gun_game_level)) {
    level.players_gun_game_level = [];
  }

  var_1 = var_0.name;

  if(!isDefined(level.players_gun_game_level[var_1])) {
    level.players_gun_game_level[var_1] = 1;
  }

  var_2 = level.players_gun_game_level[var_1];

  if(var_2 >= level.max_gun_game_level) {
    return;
  }

  level.players_gun_game_level[var_1]++;
}

function get_player_gun_game_level(var_0) {
  if(!isDefined(level.players_gun_game_level)) {
    level.players_gun_game_level = [];
  }

  var_1 = var_0.name;

  if(!isDefined(level.players_gun_game_level[var_1])) {
    level.players_gun_game_level[var_1] = 1;
  }

  return level.players_gun_game_level[var_1];
}

function pvpe_terrorist_players_respawn_timer() {
  level endon("pvpe_end_game");
  level notify("pvpe_terrorist_players_respawn_timer");
  level endon("pvpe_terrorist_players_respawn_timer");

  for(;;) {
    var_0 = gettime() + 25000;
    setomnvar("cp_wave_timer", var_0);

    for(var_1 = 25; var_1 >= 0; var_1--) {
      level notify("terrorist_players_respawn_timer_at", var_1);
      wait 1;
    }

    level notify("PvPE_enemy_AI_start_spawning");
  }
}

function change_to_terrorist_archetype_selected(var_0) {
  remove_all_primaries_weapon(var_0);
  remove_all_powers(var_0);

  switch (var_0.terrorist_archetype_selected) {
    case 0:
      kidnapper(var_0, var_0);
      break;
    case 1:
      riot_shield(var_0, var_0);
      break;
    case 2:
      sniper(var_0, var_0);
      break;
    case 3:
      var_0 scripts\cp\cp_juggernaut::jugg_makejuggernaut(jugg_createconfig());
      break;
    default:
      suicide_bomber(var_0, var_0);
      break;
  }
}

function player_is_kidnapper(var_0) {
  return isDefined(var_0.terrorist_archetype_selected) && var_0.terrorist_archetype_selected == 0;
}

function kidnapper(var_0) {
  change_to_terrorist_model_internal(var_0, "body_mp_eastern_dingo_1_1", "head_mp_eastern_azur_1_1");
  give_kidnapper_loadout(var_0);
}

function suicide_bomber(var_0) {
  change_to_terrorist_model_internal(var_0, "body_mp_eastern_azur_3_1", "head_mp_eastern_azur_3_1");
  give_suicide_bomber_loadout(var_0);
}

function riot_shield(var_0) {
  change_to_terrorist_model_internal(var_0, "body_mp_eastern_bale_1_1", "head_mp_eastern_bale_1_1");
  give_armor_loadout(var_0);
}

function sniper(var_0) {
  change_to_terrorist_model_internal(var_0, "body_mp_eastern_kreuger_1_1_havok", "head_mp_eastern_kreuger_1_1");
  give_long_range_loadout(var_0);
}

function jugg_createconfig(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.maxhealth = 3000;
  var_2.startinghealth = var_2.maxhealth;
  var_2.movespeedscalar = -0.2;
  var_2.forcetostand = 1;
  var_2.suit = "iw8_juggernaut_mp";
  var_2.clothtype = "vestheavy";
  var_2.infiniteammo = 1;
  var_2.infiniteammoupdaterate = undefined;
  var_2.classstruct = scripts\cp\cp_juggernaut::jugg_getdefaultclassstruct();
  var_2.allows = [];
  var_2.allows["stick_kill"] = 1;
  var_2.allows["health_regen"] = 1;
  var_2.allows["one_hit_melee_victim"] = 1;
  var_2.allows["flashed"] = 1;
  var_2.allows["stunned"] = 1;
  var_2.allows["prone"] = 1;
  var_2.allows["equipment"] = 1;
  var_2.allows["usability"] = 1;
  var_2.allows["supers"] = 1;
  var_2.allows["killstreaks"] = 1;
  var_2.allows["slide"] = 1;
  var_2.allows["reload"] = 1;
  var_2.allows["offhand_weapons"] = 1;
  var_2.allows["weapon_pickup"] = 1;
  var_2.allows["execution_victim"] = 0;
  var_2.perks = [];
  return var_2;
}

function change_to_terrorist_model(var_0) {
  change_to_terrorist_model_internal(var_0, "body_mp_eastern_zane_1_1", "head_mp_eastern_zane_1_1");
}

function change_to_terrorist_model_internal(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0.headmodel)) {
    var_0 detach(var_0.headmodel);
    var_0.headmodel = undefined;
  }

  var_0 setcustomization(var_1, var_2);

  if(isDefined(var_2)) {
    var_0 attach(var_2);
    var_0.headmodel = var_2;
  }

  var_0 setModel(var_1);

  if(isDefined(var_3)) {
    var_0 setviewmodel(var_3);
    return;
  }
}

function pvpe_round_timer() {
  level endon("pvpe_end_game");
  var_0 = 1;
  wait 5;
  setomnvar("cp_pvpe_active", 1);
  var_1 = gettime() + 420000;
  setomnvar("cp_round_timer", var_1);
  var_2 = 360;
  wait var_2 - var_0;
  iprintlnbold("1 minute remaining");
  wait 30;
  iprintlnbold("30 seconds remaining");
  wait 20 + var_0;

  if(game["round_number"] == 1) {
    for(var_3 = 10; var_3 > 0; var_3--) {
      iprintlnbold("Switching side in ... " + var_3);
      wait 1;
    }
  } else {
    for(var_3 = 10; var_3 > 0; var_3--) {
      iprintlnbold("Match ending in ... " + var_3);
      wait 1;
    }
  }

  level thread[[level.endgame]](get_winning_team_name(), level.end_game_string_index["win"]);
}

function set_score_fraction_to_hero_team(var_0) {
  var_0 = int(var_0 * 100);
  var_0 = clamp(var_0 / 100, 0, 1);

  if(game["round_number"] == 1) {
    game["round_one_hero_team_score_fraction"] = var_0;
    set_team_score_for_players("cp_team_0_fractional_score", var_0);
    return;
  }

  if(game["round_number"] == 2) {
    game["round_two_hero_team_score_fraction"] = var_0;
    set_team_score_for_players("cp_team_1_fractional_score", var_0);

    if(game_should_end_early()) {
      level thread[[level.endgame]](get_winning_team_name(), level.end_game_string_index["win"]);
      return;
    }

    return;
  }
}

function give_score_to_hero_team() {
  foreach(var_1 in level.players) {
    if(var_1.team_number == 0) {
      var_1 iprintlnbold("^2Your team ^7has earned one point");
      continue;
    }

    var_1 iprintlnbold("^1Enemy team ^7has earned one point");
  }

  if(game["round_number"] == 1) {
    game["round_one_hero_team_score"]++;
    game["round_one_hero_team_score_fraction"] = 0;
    set_team_score_for_players("cp_team_0_score", game["round_one_hero_team_score"]);
    set_team_score_for_players("cp_team_0_fractional_score", 0);
    return;
  }

  if(game["round_number"] == 2) {
    game["round_two_hero_team_score"]++;
    game["round_two_hero_team_score_fraction"] = 0;
    set_team_score_for_players("cp_team_1_score", game["round_two_hero_team_score"]);
    set_team_score_for_players("cp_team_1_fractional_score", 0);

    if(game_should_end_early()) {
      level thread[[level.endgame]](get_winning_team_name(), level.end_game_string_index["win"]);
      return;
    }

    return;
  }
}

function get_winning_team_name() {
  var_0 = game["round_one_hero_team_score"] + game["round_one_hero_team_score_fraction"];
  var_1 = game["round_two_hero_team_score"] + game["round_two_hero_team_score_fraction"];

  if(var_0 == var_1) {
    return "tie";
  }

  if(var_0 > var_1) {
    return "axis";
  }

  return "allies";
}

function game_should_end_early() {
  var_0 = game["round_one_hero_team_score"] + game["round_one_hero_team_score_fraction"];
  var_1 = game["round_two_hero_team_score"] + game["round_two_hero_team_score_fraction"];
  return var_1 > var_0;
}

function set_team_score_for_players(var_0, var_1) {
  foreach(var_3 in level.players) {
    var_3 setclientomnvar(var_0, var_1);
  }
}

function terrorist_enter_laststand(var_0, var_1) {
  if(player_is_suicide_bomber(var_0)) {
    thread suicide_bomber_explodes(var_0, var_0);
  }

  if(should_do_ragdoll(var_0)) {
    do_terrorist_ragdoll(var_0);
  }

  var_0 playerhide();
  var_0 disableweapons();
  var_0 allowmovement(0);
  var_0 allowjump(0);
  var_0.waiting_to_spawn = 1;
  var_0.terrorist_overlay destroy();
  enter_ragdoll_focus_camera(var_0, var_1);
  wait 2;
  thread terrorists_respawn(var_0, var_0, get_closest_respawner_on_direction(var_0.origin, undefined), scripts\engine\utility::getStructArray("terrorist_player_respawn", "targetname"));
}

function should_do_ragdoll(var_0) {
  if(player_is_suicide_bomber(var_0)) {
    return true;
  }

  return true;
}

function player_is_suicide_bomber(var_0) {
  return isDefined(var_0.terrorist_archetype_selected) && var_0.terrorist_archetype_selected == 0;
}

function enter_ragdoll_focus_camera(var_0, var_1) {
  var_2 = 250;
  var_3 = 45;

  if(!isPlayer(var_1)) {
    var_1 = get_fake_attacker_struct(var_0);
  }

  var_4 = vectorNormalize(var_0.origin - var_1.origin);
  var_4 = (var_4[0], var_4[1], 0);
  var_5 = var_0 getEye();
  var_6 = var_5 + var_4 * var_2 + (0, 0, 1) * var_3;
  var_7 = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_ainosight"]);
  var_8 = scripts\engine\trace::ray_trace(var_5, var_6, var_0, var_7)["position"];
  var_9 = spawn("script_model", var_8);
  var_9 setModel("tag_origin");
  var_9.angles = vectortoangles(var_1.origin - var_8);
  thread ragdoll_focus_camera_clean_up_monitor(var_9, var_9);
  var_0 cameralinkTo(var_9, "tag_origin");
  var_0.ragdoll_focus_camera = var_9;
}

function get_fake_attacker_struct(var_0) {
  var_1 = 180;
  var_2 = spawnStruct();
  var_3 = anglesToForward(var_0 getplayerangles());
  var_4 = var_0 gettagorigin("tag_eye");
  var_2.origin = var_4 + var_3 * var_1;
  return var_2;
}

function ragdoll_focus_camera_clean_up_monitor(var_0, var_1) {
  var_0 endon("death");
  var_1 waittill("disconnect");
  var_0 delete();
}

function exit_ragdoll_focus_camera(var_0) {
  var_0 cameraunlink();

  if(isDefined(var_0.ragdoll_focus_camera)) {
    var_0.ragdoll_focus_camera delete();
    return;
  }
}

function do_terrorist_ragdoll(var_0) {
  var_1 = var_0 cloneplayer(0);
  var_1 startragdoll();
}

function pvpe_allow_players_to_restart(var_0) {
  if(var_0 == 4) {
    return false;
  }

  return true;
}

function pvpe_player_connect_monitor() {
  level notify("pvpe_player_connect_monitor");
  level endon("pvpe_player_connect_monitor");
  level endon("game_ended");
  level endon("pvpe_end_game");

  for(;;) {
    level waittill("connected", var_0);
    thread terrorist_player_initial_spawn_select(var_0);
  }
}

function terrorist_player_initial_spawn_select(var_0) {
  var_0 endon("disconnect");
  var_0 waittill("loadout_given");
  waitframe();

  if(player_is_terrorist(var_0)) {
    var_0.terrorist_archetype_selected = var_0.slot_number;

    if(var_0.terrorist_archetype_selected > 2) {
      var_0.terrorist_archetype_selected = randomint(3);
    }

    change_to_terrorist_archetype_selected(var_0, var_0);
    return;
  }
}

function setup_play_test_name_to_team_id_mapping() {
  game["name_to_team_id_mapping"] = [];
  game["name_to_team_id_mapping"][tolower("James_C")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP6-Kilo")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP6-Lima")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP6-Mike")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP6-November")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP6-Oscar")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP6-Papa")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP6-Quebec")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP6-Romeo")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP6-Sierra")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP6-Tango")] = 0;
  game["name_to_team_id_mapping"][tolower("CP_Kilo")] = 0;
  game["name_to_team_id_mapping"][tolower("CP_Lima")] = 0;
  game["name_to_team_id_mapping"][tolower("CP_Mike")] = 0;
  game["name_to_team_id_mapping"][tolower("CP_November")] = 0;
  game["name_to_team_id_mapping"][tolower("CP_Oscar1")] = 0;
  game["name_to_team_id_mapping"][tolower("CP_Papa")] = 0;
  game["name_to_team_id_mapping"][tolower("CP_Quebec1")] = 0;
  game["name_to_team_id_mapping"][tolower("CP_Romeo")] = 0;
  game["name_to_team_id_mapping"][tolower("Cp_Sierra")] = 0;
  game["name_to_team_id_mapping"][tolower("CP_Tango")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP6_Kilo1")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP6_Lima1")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP6_Mike1")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP6_November1")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP6_Oscar1")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP6_Papa1")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP6_Quebec1")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP6_Romeo1")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP6_Sierra1")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP6_Tango1")] = 0;
  game["name_to_team_id_mapping"][tolower("BP5-Delta")] = 0;
  game["name_to_team_id_mapping"][tolower("BP5-Charlie")] = 0;
  game["name_to_team_id_mapping"][tolower("BP5-Bravo")] = 0;
  game["name_to_team_id_mapping"][tolower("BP5-Alpha")] = 0;
  game["name_to_team_id_mapping"][tolower("BP5-India")] = 0;
  game["name_to_team_id_mapping"][tolower("BP5-Juliet")] = 0;
  game["name_to_team_id_mapping"][tolower("BP5-Kilo")] = 0;
  game["name_to_team_id_mapping"][tolower("BP5-Lima")] = 0;
  game["name_to_team_id_mapping"][tolower("BP5-Mike")] = 0;
  game["name_to_team_id_mapping"][tolower("BP5-November")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP5-Tango")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP5-Sierra")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP5-Romeo")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP5-Quebec")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP5-Papa")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP5-Oscar")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP5-November")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP5-Mike")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP5-Lima")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP5-Kilo")] = 0;
  game["name_to_team_id_mapping"][tolower("IWMP6-Juliet")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP6-India")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP6-Hotel")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP6-Golf")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP6-Foxtrot")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP6-Echo")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP6-Delta")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP6-Charlie")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP6-Bravo")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP6-Alpha")] = 1;
  game["name_to_team_id_mapping"][tolower("CP_Juliet")] = 1;
  game["name_to_team_id_mapping"][tolower("CP_India")] = 1;
  game["name_to_team_id_mapping"][tolower("CP_Hotel")] = 1;
  game["name_to_team_id_mapping"][tolower("CP_Golf")] = 1;
  game["name_to_team_id_mapping"][tolower("CP_Foxtrot")] = 1;
  game["name_to_team_id_mapping"][tolower("CP_Echo")] = 1;
  game["name_to_team_id_mapping"][tolower("CP_Delta")] = 1;
  game["name_to_team_id_mapping"][tolower("CP_Charlie")] = 1;
  game["name_to_team_id_mapping"][tolower("CP_Bravo1")] = 1;
  game["name_to_team_id_mapping"][tolower("CP_Alpha")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP6_Juliet1")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP6_India1")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP6_Hotel1")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP6_Golf1")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP6_Foxtrot1")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP6_Echo1")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP6_Delta1")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP6_Charlie1")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP6_Bravo1")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP6_Alpha1")] = 1;
  game["name_to_team_id_mapping"][tolower("BP5-Echo")] = 1;
  game["name_to_team_id_mapping"][tolower("BP5-Foxtrot")] = 1;
  game["name_to_team_id_mapping"][tolower("BP5-Golf")] = 1;
  game["name_to_team_id_mapping"][tolower("BP5-Hotel")] = 1;
  game["name_to_team_id_mapping"][tolower("BP5-Oscar")] = 1;
  game["name_to_team_id_mapping"][tolower("BP5-Papa")] = 1;
  game["name_to_team_id_mapping"][tolower("BP5-Quebec")] = 1;
  game["name_to_team_id_mapping"][tolower("BP5-Romeo")] = 1;
  game["name_to_team_id_mapping"][tolower("BP5-Sierra")] = 1;
  game["name_to_team_id_mapping"][tolower("BP5-Tango")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP5-Alpha")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP5-Bravo")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP5-Charlie")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP5-Delta")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP5-Echo")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP5-Foxtrot")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP5-Golf")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP5-Hotel")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP5-India")] = 1;
  game["name_to_team_id_mapping"][tolower("IWMP5-Juliet")] = 1;
  game["name_to_team_id_mapping"][tolower("IW_James_Chen_2")] = 1;
}