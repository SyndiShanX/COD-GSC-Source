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

  for(var0 = 0; var0 <= game["round_one_hero_team_score"]; var0++) {
    set_team_score_for_players("cp_team_0_score", var0);
    wait 0.1;

    if(var0 < game["round_one_hero_team_score"]) {
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

  var0 = [0, 1];

  for(var1 = 5; var1 > 0; var1--) {
    var0 = scripts\engine\utility::array_randomize(var0);
  }

  game["team_id_to_team_number_mapping"] = var0;
}

function randomize_session_team_to_team_number_mapping() {
  if(game["round_number"] > 2) {
    game["session_team_to_team_number_mapping"] = undefined;
  }

  if(isDefined(game["session_team_to_team_number_mapping"])) {
    return;
  }

  var0 = [0, 1];

  for(var1 = 5; var1 > 0; var1--) {
    var0 = scripts\engine\utility::array_randomize(var0);
  }

  game["session_team_to_team_number_mapping"] = [];
  game["session_team_to_team_number_mapping"]["axis"] = var0[0];
  game["session_team_to_team_number_mapping"]["allies"] = var0[1];
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

function pvpe_revive_ent_usability_func(var0, var1) {
  var1 endon("death");

  foreach(var3 in level.players) {
    if(var3 == var0) {
      continue;
    }

    if(var3.team_number == 0) {
      continue;
    }

    var1 disableplayeruse(var3);
  }

  for(;;) {
    level waittill("connected", var3);
    thread delay_disable_use(var3, var3);
  }
}

function pvpe_disable_bleedout_ent_usability_func(var0) {
  foreach(var2 in level.players) {
    var0.executeent disableplayeruse(var2);
  }
}

function pvpe_enable_bleedout_ent_usability_func(var0) {
  foreach(var2 in level.players) {
    if(!istrue(var2.waiting_to_spawn) && player_is_kidnapper(var2)) {
      var0.executeent enableplayeruse(var2);
    }
  }
}

function delay_disable_use(var0, var1) {
  var0 endon("disconnect");
  var1 endon("death");
  var0 waittill("spawned_player");
  waitframe();

  if(player_is_terrorist(var0)) {
    var1 disableplayeruse(var0);
    return;
  }
}

function pvpe_enabled() {
  return getdvarint("enable_pvpe", 0) != 0;
}

function player_is_terrorist(var0) {
  if(!pvpe_enabled()) {
    return false;
  }

  return var0.team_number == 1;
}

function pvpe_playerspawnteamassignmentfunc(var0) {
  var1 = ["allies", "axis", "team_four", "team_six"];

  if(isDefined(var0.team_number)) {
    return var1[var0.team_number];
  }

  return "free";
}

function pvpe_playerspawnsessionteamassignmentfunc(var0, var1) {
  return var1;
}

function pvpe_gameshouldendfunc(var0) {
  foreach(var2 in level.players) {
    if(var2 == var0) {
      continue;
    }

    if(player_is_terrorist(var2)) {
      continue;
    }

    if(!scripts\cp\cp_laststand::player_in_laststand(var2)) {
      return false;
    }
  }

  return true;
}

function pvpe_allow_munitions(var0) {
  if(player_is_terrorist(var0)) {
    return false;
  }

  return true;
}

function pvpe_get_num_of_charges_for_power(var0) {
  if(player_is_terrorist(var0)) {
    return 1;
  }

  return scripts\cp\cp_loadout::get_default_num_equipment_charges();
}

function pvpe_allow_super(var0) {
  if(player_is_terrorist(var0)) {
    return false;
  }

  return true;
}

function pvpe_pre_map_restart_func(var0) {
  var1 = get_winning_team_name();
  jumpiffalse(var1 == "tie") LOC_0000004d;

  foreach(var3 in level.players) {
    var3 thread scripts\cp\cp_hud_message::tutorialprint(&"CP_STRIKE/TIE", 4);
  }

  goto LOC_000000a7;
}

function on_spawn_terrorist_player(var0) {
  var0.self_revive = 1;
  var0 scripts\cp\utility::allow_player_ignore_me(1);
  var0.unable_to_trigger_radius_detection_monitor = 1;
  var0.terrorist_overlay = scripts\cp\utility::create_client_overlay("ui_scarf_overlay", 1, self);
}

function terrorists_respawn(var0, var1, var2, var3) {
  level endon("game_ended");
  var0 endon("disconnect");
  exit_ragdoll_focus_camera(var0);
  var4 = spawn("script_model", var0.origin + (0, 0, 100));
  var4 setModel("tag_origin");
  var4.angles = vectortoangles((0, 0, -1));
  var0 cameralinkTo(var4, "tag_origin");
  var0.terrorist_respawn_camera = var4;
  thread delay_turn_on_birds_eye_hud(var0, var0);
  thread play_marker_vfx_on_enemy_players(var0);
  thread play_marker_vfx_on_friendly_players(var0);
  thread terrorist_move_through_respawners_think(var0, var0, var1, var2);
  var5 = getassignedspawnpointbasedonteam(var0);
  var0 setOrigin(var5.origin, 1);
  var0 waittill("terrorist_resapwns", var6);
  thread play_terrorist_respawn_music();
  stop_marker_vfx_on_enemy_players(var0, var0);
  stop_marker_vfx_on_friendly_players(var0, var0);
  delete_respawner_markers(var0);
  terrorist_camera_move_to(var6.origin + (0, 0, 85), var0);
  var0.terrorist_respawn_camera delete();
  var0 setclientomnvar("ui_birds_eye_view", 0);
  var0 cameraunlink();
  var0 setOrigin(var6.origin);

  if(isDefined(var6.angles)) {
    var0 setplayerangles(var6.angles);
  }

  var0 allowmovement(1);
  var0 allowjump(1);
  var0 playershow();
  var0 enableweapons();
  var0.waiting_to_spawn = 0;
  var0.terrorist_overlay = scripts\cp\utility::create_client_overlay("ui_scarf_overlay", 1, var0);
  change_to_terrorist_archetype_selected(var0, var0);
  thread delay_play_marker_vfx_to_players_waiting_to_respawn(var0);
}

function delay_turn_on_birds_eye_hud(var0, var1) {
  level endon("game_ended");
  level endon("pvpe_end_game");
  var0 endon("disconnect");

  if(game["in_pvpe_end_game"] == 1) {
    return;
  }

  if(istrue(var1)) {
    var0 waittill("revive");
  }

  thread archetype_selection_monitor(var0);
  var0 setclientomnvar("ui_birds_eye_view", 1);
}

function archetype_selection_monitor(var0) {
  var0 endon("disconnect");
  var0 endon("terrorist_resapwns");
  var0.terrorist_archetype_selected = 0;

  for(;;) {
    var0 waittill("luinotifyserver", var1, var2);

    if(isDefined(var1) && var1 == "respawn_type_highlighted") {
      var0.terrorist_archetype_selected = var2;
    }
  }
}

function stop_marker_vfx_on_enemy_players(var0) {
  foreach(var2 in level.players) {
    if(var2 == var0) {
      continue;
    }

    if(var2.team_number == 1) {
      continue;
    }

    stopfxontagforclients(level._effect["pvpe_enemy_marker"], var2, "tag_origin", var0);
  }
}

function stop_marker_vfx_on_friendly_players(var0) {
  foreach(var2 in level.players) {
    if(var2 == var0) {
      continue;
    }

    if(var2.team_number == 0) {
      continue;
    }

    stopfxontagforclients(level._effect["pvpe_friendly_marker"], var2, "tag_origin", var0);
  }
}

function delete_respawner_markers(var0) {
  if(isDefined(var0.terrorist_selected_respawner_marker)) {
    var0.terrorist_selected_respawner_marker delete();
  }

  foreach(var2 in var0.terrorist_nearby_respawner_markers) {
    if(isDefined(var2)) {
      var2 delete();
    }
  }

  reset_respawner_markers(var0);
}

function play_terrorist_respawn_music() {
  var0 = "terrorist_respawn";
  var1 = 7;

  if(istrue(level.playing_terrorist_respawn_music)) {
    return;
  }

  level.playing_terrorist_respawn_music = 1;

  foreach(var3 in level.players) {
    var3 playlocalsound(var0);
  }

  wait var1;
  level.playing_terrorist_respawn_music = 0;
}

function play_marker_vfx_on_enemy_players(var0) {
  var0 endon("disconnect");
  var0 endon("terrorist_resapwns");

  foreach(var2 in level.players) {
    if(var2 == var0) {
      continue;
    }

    if(var2.team_number == 1) {
      continue;
    }

    playfxontagforclients(level._effect["pvpe_enemy_marker"], var2, "tag_origin", var0);
    waitframe();
  }
}

function delay_play_marker_vfx_to_players_waiting_to_respawn(var0) {
  var0 endon("disconnect");
  var0 endon("terrorist_resapwns");
  wait 0.5;

  foreach(var2 in level.players) {
    if(var2 == var0) {
      continue;
    }

    if(var2.team_number == 0) {
      continue;
    }

    if(istrue(var2.waiting_to_spawn)) {
      play_marker_vfx_on_friendly_player(var0, var2);
    }

    waitframe();
  }
}

function play_marker_vfx_on_friendly_players(var0) {
  var0 endon("disconnect");
  var0 endon("terrorist_resapwns");

  foreach(var2 in level.players) {
    if(var2 == var0) {
      continue;
    }

    if(var2.team_number == 0) {
      continue;
    }

    if(istrue(var2.waiting_to_spawn)) {
      continue;
    }

    play_marker_vfx_on_friendly_player(var2, var0);
    waitframe();
  }
}

function play_marker_vfx_on_friendly_player(var0, var1) {
  playfxontagforclients(level._effect["pvpe_friendly_marker"], var0, "tag_origin", var1);
  thread stop_marker_vfx_on_friendly_player_think(var0, var0);
}

function stop_marker_vfx_on_friendly_player_think(var0, var1) {
  var1 endon("disconnect");
  var1 endon("terrorist_resapwns");
  var0 waittill("last_stand");
  stopfxontagforclients(level._effect["pvpe_friendly_marker"], var0, "tag_origin", var1);
}

function terrorist_move_through_respawners_think(var0, var1, var2, var3) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 endon("terrorist_resapwns");
  reset_respawner_markers(var0);
  mark_selected_terrorist_respawner(var0, var1);
  move_terrorist_respawn_camera(var0, var0);
  thread terrorist_decide_respawn_think(var0, var0);
  thread respawn_camera_movement_think(var0);
  thread respawner_selection_think(var0, var0);
}

function respawner_selection_think(var0, var1) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 endon("terrorist_resapwns");

  for(;;) {
    if(isDefined(var0.terrorist_respawner_selected) && distance2dsquared(var0.terrorist_respawner_selected.origin, var0.terrorist_respawn_camera.origin) > 40000) {
      unmark_selected_terrorist_respawner(var0);
    }

    if(istrue(var0.moving_respawn_camera)) {
      foreach(var3 in var1) {
        if(distance2dsquared(var0.terrorist_respawn_camera.origin, var3.origin) <= 40000) {
          mark_selected_terrorist_respawner(var0, var3);
          continue;
        }

        if(distance2dsquared(var0.terrorist_respawn_camera.origin, var3.origin) <= 100000000) {
          show_terrorist_respawner(var0, var3);
          continue;
        }

        unshow_terrorist_respawner(var0, var3);
      }
    }

    waitframe();
  }
}

function show_terrorist_respawner(var0, var1) {
  if(scripts\engine\utility::array_contains(var0.terrorist_nearby_respawners, var1)) {
    return;
  }

  var2 = spawnfxforclient(level._effect["pvpe_nearby_spawner"], get_adjusted_marker_vfx_pos(var1.origin) + (0, 0, 50), var0, (0, 0, 1), (1, 0, 0));
  triggerfx(var2);
  var1.marker_vfx = var2;
  var0.terrorist_nearby_respawner_markers[var0.terrorist_nearby_respawner_markers.size] = var2;
  var0.terrorist_nearby_respawners[var0.terrorist_nearby_respawners.size] = var1;
}

function unshow_terrorist_respawner(var0, var1) {
  if(scripts\engine\utility::array_contains(var0.terrorist_nearby_respawners, var1)) {
    var1.marker_vfx delete();
    var0.terrorist_nearby_respawners = scripts\engine\utility::array_remove(var0.terrorist_nearby_respawners, var1);
    return;
  }
}

function unmark_selected_terrorist_respawner(var0) {
  var0.terrorist_respawner_selected = undefined;

  if(isDefined(var0.terrorist_selected_respawner_marker)) {
    var0.terrorist_selected_respawner_marker delete();
  }

  if(game["in_pvpe_end_game"] == 0) {
    if(!istrue(var0.in_respawn_delay)) {
      var0 scripts\cp\utility::hint_prompt("respawn_hint", 0);
      var0 scripts\cp\utility::hint_prompt("select_respawner", 1);
      return;
    }

    return;
  }
}

function respawn_camera_movement_think(var0) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 endon("terrorist_resapwns");
  var1 = 150;
  var0.moving_respawn_camera = 0;

  for(;;) {
    var2 = var0 getnormalizedmovement();
    var3 = var2[0];
    var4 = var2[1];

    if(player_moving_respawn_camera(var3, var4)) {
      var0.moving_respawn_camera = 1;
      var5 = (var3 * var1, var4 * var1 * -1, 0);
      var6 = var0.terrorist_respawn_camera.origin + var5;
      terrorist_camera_move_to(var6, var0);
    } else {
      var0.moving_respawn_camera = 0;
    }

    waitframe();
  }
}

function wait_for_global_respawn_timer() {
  level waittill("terrorist_players_respawn_timer_at", var0);
  wait var0;
}

function terrorist_decide_respawn_think(var0, var1) {
  level endon("game_ended");
  level endon("pvpe_end_game");
  var0 endon("disconnect");

  if(game["in_pvpe_end_game"] == 1) {
    return;
  }

  if(istrue(var1)) {
    var0 waittill("revive");
    var0 scripts\cp\utility::hint_prompt("respawn_cooldown", 1);
    var0.in_respawn_delay = 1;
    var0 setclientomnvar("cp_show_wave_timer", 1);
    wait_for_global_respawn_timer();
    var0 setclientomnvar("cp_show_wave_timer", 0);
    var0 scripts\cp\utility::hint_prompt("respawn_cooldown", 0);
    var0.in_respawn_delay = 0;
  }

  if(isDefined(var0.terrorist_respawner_selected)) {
    var0 scripts\cp\utility::hint_prompt("respawn_hint", 1);
  } else {
    var0 scripts\cp\utility::hint_prompt("select_respawner", 1);
  }

  var0 notifyonplayercommand("terrorist_selected_a_respawner", "+goStand");

  for(;;) {
    var0 waittill("terrorist_selected_a_respawner");

    if(isDefined(var0.terrorist_respawner_selected)) {
      break;
    }
  }

  var0 scripts\cp\utility::hint_prompt("respawn_hint", 0);
  var0 scripts\cp\utility::hint_prompt("select_respawner", 0);
  var0 notify("terrorist_resapwns", var0.terrorist_respawner_selected);
}

function move_terrorist_respawn_camera(var0) {
  var1 = var0.terrorist_respawner_selected;
  var2 = (var1.origin[0], var1.origin[1], var1.origin[2] + 4000);
  terrorist_camera_move_to(var2, var0);
}

function terrorist_camera_move_to(var0, var1) {
  var2 = distance(var1.terrorist_respawn_camera.origin, var0);
  var3 = var2 / 7000;
  var1.terrorist_respawn_camera moveTo(var0, var3);
  wait var3;
}

function reset_respawner_markers(var0) {
  var0.terrorist_nearby_respawners = [];
  var0.terrorist_nearby_respawner_markers = [];
  var0.terrorist_selected_respawner_marker = undefined;
}

function mark_selected_terrorist_respawner(var0, var1) {
  if(isDefined(var0.terrorist_respawner_selected) && var0.terrorist_respawner_selected == var1) {
    return;
  }

  if(game["in_pvpe_end_game"] == 0) {
    if(!istrue(var0.in_respawn_delay)) {
      var0 scripts\cp\utility::hint_prompt("select_respawner", 0);
      var0 scripts\cp\utility::hint_prompt("respawn_hint", 1);
    }
  }

  var0.terrorist_respawner_selected = var1;
  var2 = spawnfxforclient(level._effect["pvpe_selected_spawner"], get_adjusted_marker_vfx_pos(var0.terrorist_respawner_selected.origin) + (0, 0, 50), var0, (0, 0, 1), (1, 0, 0));
  triggerfx(var2);
  var0.terrorist_selected_respawner_marker = var2;
}

function get_closest_respawner_on_direction(var0, var1) {
  var2 = scripts\engine\utility::getStructArray("terrorist_player_respawn", "targetname");

  if(isDefined(var1)) {
    var3 = get_respawners_in_desired_direction(var0, var1, var2);

    if(var3.size > 0) {
      return scripts\engine\utility::getclosest(var0, var3);
    }

    return undefined;
  }

  return scripts\engine\utility::getclosest(var0, var2);
}

function get_respawners_in_desired_direction(var0, var1, var2) {
  var3 = [];

  foreach(var5 in var2) {
    var6 = var5.origin - var0;
    var6 = (var6[0], var6[1], 0);

    if(distance2dsquared(var0, var5.origin) < 2500) {
      continue;
    }

    if(vectordot(var6, var1) > 0) {
      var3 = var5;
    }
  }

  return var3;
}

function getassignedspawnpointbasedonteam(var0) {
  var1 = get_spawn_point_targetname(var0);
  var2 = scripts\engine\utility::getStructArray(var1, "targetname");
  var3 = var2[var0.slot_number];
  return var3;
}

function get_spawn_point_targetname(var0) {
  if(var0.team_number == 0) {
    return "default_player_start";
  }

  return "terrorist_player_start";
}

function update_respawners_vfx(var0) {
  delete_respawner_markers(var0);
  var1 = spawnfxforclient(level._effect["pvpe_selected_spawner"], get_adjusted_marker_vfx_pos(var0.terrorist_respawner_selected.origin) + (0, 0, 50), var0, (0, 0, 1), (1, 0, 0));
  triggerfx(var1);
  var0.terrorist_selected_respawner_marker = var1;
  var2 = get_nearby_respawners(var0);
  var3 = [];

  foreach(var5 in var2) {
    var6 = spawnfxforclient(level._effect["pvpe_nearby_spawner"], get_adjusted_marker_vfx_pos(var5.origin) + (0, 0, 50), var0, (0, 0, 1), (1, 0, 0));
    triggerfx(var6);
    var3 = var6;
  }

  var0.terrorist_nearby_respawner_markers = var3;
}

function get_nearby_respawners(var0) {
  var1 = [];
  var2 = ["move_to_respawner_on_the_up", "move_to_respawner_on_the_down", "move_to_respawner_on_the_left", "move_to_respawner_on_the_right"];

  foreach(var4 in var2) {
    var5 = get_closest_respawner_on_direction(var0.terrorist_respawner_selected.origin, get_desired_direction_based_on_input(var4));

    if(isDefined(var5) && !scripts\engine\utility::array_contains(var1, var5)) {
      var1 = var5;
    }
  }

  return var1;
}

function get_desired_direction_based_on_input(var0) {
  switch (var0) {
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

function player_moving_respawn_camera(var0, var1) {
  if(abs(var0) != 0) {
    return true;
  }

  if(abs(var1) != 0) {
    return true;
  }

  return false;
}

function get_adjusted_marker_vfx_pos(var0) {
  return scripts\engine\trace::ray_trace_detail(var0 + (0, 0, 5000), var0)["position"];
}

function initialize_player_team_slot_assignment() {
  var0 = [];

  for(var1 = 0; var1 < 4; var1++) {
    var0 = var1;
  }

  for(var2 = 0; var2 < 5; var2++) {
    var0 = scripts\engine\utility::array_randomize(var0);
  }

  var3 = [];

  for(var4 = 0; var4 < 4; var4++) {
    var3 = var4;
  }

  for(var5 = 0; var5 < 5; var5++) {
    var3 = scripts\engine\utility::array_randomize(var3);
  }

  level.team_id_one_slot_assignment_index = 0;
  level.team_id_zero_slot_assignment_index = 0;
  level.team_id_one_slot_index_list = var0;
  level.team_id_zero_slot_index_list = var3;
}

function assign_pvpe_team_and_slot_number(var0) {
  var1 = var0 getplayerdata("cp", "CPSession", "subParty");
  var2 = get_team_and_slot_number_struct(var0, var1);
  var3 = var2.team_number;
  var4 = var2.slot_number;
  var0.team_number = var3;
  var0.slot_number = var4;
  var0.team_and_slot_number_struct = var2;
  set_player_playing_as_terrorist_omnvar(var0);
  assign_player_team(var0);

  if(game["round_number"] == 1) {
    var0 setclientomnvar("cp_player_team_num", var3);
  }

  if(should_disable_infil_for_player(var0)) {
    disableplayerinfil(var0);
    return;
  }
}

function assign_player_team(var0) {
  if(var0.team_number == 0) {
    var0.pers["team"] = "allies";
    return;
  }

  var0.pers["team"] = "axis";
}

function should_disable_infil_for_player(var0) {
  return player_is_terrorist(var0);
}

function disableplayerinfil(var0) {
  var0.infil_disabled = 1;
}

function terrorist_self_revive_time_override(var0) {
  if(var0.team_number == 1) {
    var0.self_revive_wait_override = 0.05;
    return;
  }
}

function get_team_and_slot_number_struct(var0, var1) {
  if(player_in_party(var1)) {
    return get_team_id_zero_assignment_first(var0);
  }

  return get_team_id_one_assignment_first(var0);
}

function get_team_id_zero_assignment_first(var0) {
  if(more_team_id_zero_slot_available()) {
    return make_team_id_zero_team_and_slot_number_struct(var0);
  }

  return make_team_id_one_team_and_slot_number_struct(var0);
}

function more_team_id_zero_slot_available() {
  return level.team_id_zero_slot_assignment_index < 4;
}

function make_team_id_zero_team_and_slot_number_struct(var0) {
  var1 = get_team_id_zero_slot();
  var2 = get_team_number(var0, 0);
  return make_team_and_slot_number_struct(var2, var1);
}

function make_team_id_one_team_and_slot_number_struct(var0) {
  var1 = get_team_id_one_slot();
  var2 = get_team_number(var0, 1);
  return make_team_and_slot_number_struct(var2, var1);
}

function get_team_number(var0, var1) {
  if(game["round_number"] == 1) {
    if(isDefined(game["name_to_team_id_mapping"][tolower(var0.name)])) {
      var2 = game["team_id_to_team_number_mapping"][game["name_to_team_id_mapping"][tolower(var0.name)]];
    } else if(player_selected_team_in_front_end(var1)) {
      var2 = game["session_team_to_team_number_mapping"][var1.sessionteam];
    } else {
      var2 = game["team_id_to_team_number_mapping"][var2];
    }

    if(var2.sessionteam == "allies") {
      var2 = 0;
    } else if(var2.sessionteam == "axis") {
      var2 = 1;
    }

    var2.pers["pvpe_round_one_team_number"] = var2;
    return var2;
  }

  if(game["round_number"] == 2) {
    switch (var2.pers["pvpe_round_one_team_number"]) {
      case 0:
        return 1;
      case 1:
        return 0;
    }

    return;
  }
}

function set_player_playing_as_terrorist_omnvar(var0) {
  if(var0.team_number == 1) {
    var0 setclientomnvar("cp_play_terrorist", 1);
    return;
  }

  var0 setclientomnvar("cp_play_terrorist", 0);
}

function player_selected_team_in_front_end(var0) {
  if(isDefined(var0.sessionteam)) {
    return (var0.sessionteam == "axis" || var0.sessionteam == "allies");
  }

  return false;
}

function get_team_id_zero_slot() {
  var0 = level.team_id_zero_slot_index_list[level.team_id_zero_slot_assignment_index];
  level.team_id_zero_slot_assignment_index++;
  return var0;
}

function make_team_and_slot_number_struct(var0, var1) {
  var2 = spawnStruct();
  var2.team_number = var0;
  var2.slot_number = var1;
  return var2;
}

function get_team_id_one_slot() {
  var0 = level.team_id_one_slot_index_list[level.team_id_one_slot_assignment_index];
  level.team_id_one_slot_assignment_index++;
  return var0;
}

function player_in_party(var0) {
  return var0 != -1;
}

function get_team_id_one_assignment_first(var0) {
  if(more_team_one_slot_available()) {
    return make_team_id_one_team_and_slot_number_struct(var0);
  }

  return make_team_id_zero_team_and_slot_number_struct(var0);
}

function more_team_one_slot_available() {
  return level.team_id_one_slot_assignment_index < 4;
}

function pvpe_force_end_game() {
  level thread scripts\cp\cp_endgame::endgame(get_winning_team_name(), scripts\cp\cp_endgame::get_end_game_string_index("host_end"));
}

function pvpe_end_game(var0, var1) {
  level notify("pvpe_end_game");
  game["in_pvpe_end_game"] = 1;
  turn_off_players_birds_view_hud();

  if(pvpe_game_should_really_end()) {
    scripts\cp\cp_endgame::endgame(var0, var1);
    return;
  }

  foreach(var3 in level.players) {
    var3 thread scripts\cp\cp_hud_message::tutorialprint(&"CP_STRIKE/SWITCHING_SIDE", 5);
  }

  scripts\cp\cp_endgame::freezeallplayers(1, "NSSLSNKPN", 1);
  wait 5;
  setomnvar("allow_server_pause", 1);
  setomnvarforallclients("post_game_state", 0);
  map_restart(1);
}

function turn_off_players_birds_view_hud() {
  foreach(var1 in level.players) {
    var1 setclientomnvar("ui_birds_eye_view", 0);
    var1 scripts\cp\utility::hint_prompt("respawn_cooldown", 0);
    var1 scripts\cp\utility::hint_prompt("respawn_hint", 0);
    var1 scripts\cp\utility::hint_prompt("select_respawner", 0);
  }
}

function pvpe_game_should_really_end() {
  return game["round_number"] == 2;
}

function delay_give_archetype_loadout(var0) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 waittill("loadout_given");
  remove_all_primaries_weapon(var0);

  if(!isDefined(var0.terrorist_archetype_selected)) {
    give_default_terrorist_loadout(var0, var0);
    return;
  }
}

function remove_all_powers(var0) {
  foreach(var2 in var0.powers) {
    var0 scripts\cp\cp_powers::removepower(var3);
  }
}

function give_poison_gas_loadout(var0) {
  var1 = scripts\cp\cp_weapon::buildweapon("iw8_fists_mp", [], "none", "none", -1);
  var0 giveweapon(var1);
  var0 switchtoweaponimmediate(var1);
  var0 thread scripts\cp\cp_powers::givepower("power_molotov", "primary", undefined, undefined, undefined, undefined, 1, 5);
  var0 thread scripts\cp\cp_powers::givepower("power_c4", "secondary", undefined, undefined, undefined, undefined, 1, 1);
}

function give_kidnapper_loadout(var0) {
  var1 = scripts\cp\cp_weapon::buildweapon("iw8_knife_mp", [], "none", "none", -1);
  var0 giveweapon(var1);
  var0 switchtoweaponimmediate(var1);
  var0 setweaponammoclip("super_default_zm", 1);
  var0 thread scripts\cp\cp_powers::givepower("power_throwingKnife", "primary", undefined, undefined, undefined, undefined, 1, 2);
  var0 thread scripts\cp\cp_powers::givepower("power_smokeGrenade", "secondary", undefined, undefined, undefined, undefined, 1, 2);
  thread kidnapper_enable_execute(var0);
  thread kidnapper_target_think(var0);
  thread kidnapper_disguise_think(var0);
  thread kidnapper_clean_up(var0);
}

function kidnapper_clean_up(var0) {
  var0 endon("disconnect");
  var0 scripts\engine\utility::ref_143a5("last_stand", "disguise success");
  var0 scripts\cp\utility::hint_prompt("start_disguise", 0);
  unmark_kidnapper_target(var0, var0);
  var0 setclientomnvar("ui_securing_progress", 0);
  var0 setclientomnvar("ui_securing", 0);
  level.execute_entities = scripts\engine\utility::array_removeundefined(level.execute_entities);

  foreach(var2 in level.execute_entities) {
    var2 disableplayeruse(var0);
  }
}

function kidnapper_laststand_hero_watcher() {
  level endon("game_ended");
  level.execute_entities = [];

  for(;;) {
    level waittill("waiting_to_be_revived_from_laststand", var0);

    if(var0.team_number == 1) {
      continue;
    }

    var1 = scripts\cp\cp_laststand::makeexecuteentity(var0, var0.origin);
    disable_all_players_use(var1, var1);
    level.execute_entities[level.execute_entities.size] = var1;
    level notify("new_execute_entity", var1);
  }
}

function disable_all_players_use(var0) {
  foreach(var2 in level.players) {
    var0 disableplayeruse(var2);
  }
}

function kidnapper_enable_execute(var0) {
  var0 endon("disconnect");
  var0 endon("last_stand");
  level.execute_entities = scripts\engine\utility::array_removeundefined(level.execute_entities);

  foreach(var2 in level.execute_entities) {
    var2 enableplayeruse(var0);
  }

  for(;;) {
    level waittill("new_execute_entity", var4);
    var4 enableplayeruse(var0);
  }
}

function kidnapper_disguise_think(var0) {
  var0 endon("disconnect");
  var0 endon("last_stand");
  var0 endon("disguise success");

  for(;;) {
    wait_for_super_button_pressed(var0);

    if(isDefined(var0.kidnapper_target_player)) {
      var1 = var0.kidnapper_target_player;
      var0 scripts\cp\utility::hint_prompt("start_disguise", 0);
      var0.is_putting_on_disguise = 1;
      var0 cameraset("camera_custom_orbit_0_noremote");
      var2 = super_hold_think(var0, 13, 1.5);

      if(var2 == "success") {
        disguise_as_enemy(var0, var0, var1);
        var0 scripts\cp\utility::_setperk("specialty_spygame");
        thread remove_spygame_when_down(var0);
        wait 0.5;
        var0.is_putting_on_disguise = 0;
        var0 cameradefault();
        var0 notify("disguise success");
      } else {
        var0.is_putting_on_disguise = 0;
        var0 cameradefault();
      }
    }
  }
}

function remove_spygame_when_down(var0) {
  var0 endon("disconnect");
  var0 waittill("last_stand");
  var0 scripts\cp\utility::_unsetperk("specialty_spygame");
}

function disguise_as_enemy(var0, var1) {
  var0 setcustomization(var1.setcustomization_body, var1.setcustomization_head);
  var2 = var1.bodymodel;
  var3 = var1.headmodel;
  var4 = var1.viewmodel;
  change_to_terrorist_model_internal(var0, var2, var3, var4);
}

function wait_for_super_button_pressed(var0) {
  for(;;) {
    var0 waittill("offhand_fired", var1);

    if(issameweapon(var1) && createheadicon(var1) == "super_default_zm") {
      var0 setweaponammoclip("super_default_zm", 1);
      return;
    }
  }
}

function kidnapper_target_think(var0) {
  var0 endon("disconnect");
  var0 endon("last_stand");
  var0 endon("disguise success");

  for(;;) {
    var1 = get_all_hero_players();
    var2 = [];

    foreach(var4 in var1) {
      var5 = is_hero_player_within_reticle(var4, var0);

      if(var5) {
        var6 = does_hero_player_pass_traces(var4, var0);

        if(var6) {
          var2 = var4;
        }
      }

      waitframe();
    }

    if(var2.size > 0) {
      if(!istrue(var0.is_putting_on_disguise)) {
        var0 scripts\cp\utility::hint_prompt("start_disguise", 1);
      }

      var8 = scripts\engine\utility::getclosest(var0.origin, var2);

      if(isDefined(var0.kidnapper_target_player)) {
        if(var0.kidnapper_target_player != var8) {
          unmark_kidnapper_target(var0);
          mark_hero_as_kidnapper_target(var8, var0);
        }
      } else {
        mark_hero_as_kidnapper_target(var8, var0);
      }
    } else {
      var0 scripts\cp\utility::hint_prompt("start_disguise", 0);
      unmark_kidnapper_target(var0);
    }

    waitframe();
  }
}

function mark_hero_as_kidnapper_target(var0, var1) {
  var0 hudoutlineenableforclient(var1, "outline_depth_red");
  var1.kidnapper_target_player = var0;
}

function unmark_kidnapper_target(var0) {
  if(isDefined(var0.kidnapper_target_player)) {
    var0.kidnapper_target_player hudoutlinedisableforclient(var0);
    var0.kidnapper_target_player = undefined;
    return;
  }
}

function does_hero_player_pass_traces(var0, var1) {
  var2 = physics_createcontents(["physicscontents_solid", "physicscontents_ainosight"]);

  if(scripts\engine\trace::ray_trace_passed(var1 getEye(), var0 getEye(), [var1], var2)) {
    return true;
  }

  if(scripts\engine\trace::ray_trace_passed(var1 getEye(), var0.origin, [var1], var2)) {
    return true;
  }

  return false;
}

function is_hero_player_within_reticle(var0, var1) {
  if(var1 worldpointinreticle_circle(var0 getEye(), 65, 115)) {
    return true;
  }

  if(var1 worldpointinreticle_circle(var0.origin, 65, 115)) {
    return true;
  }

  return false;
}

function get_all_hero_players() {
  var0 = [];

  if(!isDefined(level.players)) {
    return var0;
  }

  foreach(var2 in level.players) {
    if(var2.team_number == 0) {
      var0 = var2;
    }
  }

  return var0;
}

function give_suicide_bomber_loadout(var0) {
  thread suicide_bomber_think(var0);
  thread suicide_bomber_clean_up(var0);
}

function suicide_bomber_think(var0) {
  var0 endon("disconnect");
  var0 endon("last_stand");
  var1 = scripts\cp\cp_weapon::buildweapon("iw8_fists_mp", [], "none", "none", -1);
  var0 giveweapon(var1);
  var0 switchtoweaponimmediate(var1);
  var0 scripts\cp\utility::hint_prompt("activate_suicide_vest", 1);
  var0 notifyonplayercommand("activate_suicide_vest", "+usereload");
  var0 notifyonplayercommand("finish_activate_suicide_vest", "-usereload");
  var0 notifyonplayercommand("detonate_suicide_vest", "+usereload");

  for(;;) {
    var0 waittill("activate_suicide_vest");
    var0 playLoopSound("cp_suicide_vest_slow_beep");
    var2 = use_hold_think(var0, 13, 3.5);
    var0 stoploopsound("cp_suicide_vest_slow_beep");

    if(var2 == "success") {
      break;
    }
  }

  var0 playLoopSound("cp_suicide_vest_fast_beep");
  thread suicide_vest_timer(var0);
  thread target_within_range_think(var0);
  var0 scripts\cp\utility::hint_prompt("activate_suicide_vest", 0);
  var0 scripts\cp\utility::hint_prompt("detonate_suicide_vest", 1);
  var0 waittill("finish_activate_suicide_vest");
  var0 waittill("detonate_suicide_vest");
  var0 stoploopsound("cp_suicide_vest_fast_beep");
  var0 scripts\cp\utility::hint_prompt("detonate_suicide_vest", 0);
  thread suicide_bomber_explodes(var0, var0);
}

function target_within_range_think(var0) {
  var0 endon("disconnect");
  var0 endon("last_stand");

  for(;;) {
    var1 = get_potential_hero_players_as_target();
    var2 = [];

    foreach(var4 in var1) {
      if(distancesquared(var0.origin, var4.origin) <= 50625) {
        var2 = var4;
      }
    }

    var0.potential_hero_players_as_target_in_range = var2;

    foreach(var7 in level.players) {
      if(scripts\engine\utility::array_contains(var0.potential_hero_players_as_target_in_range, var7)) {
        var7 hudoutlineenableforclient(var0, "outlinefill_depth_orange");
        continue;
      }

      var7 hudoutlinedisableforclient(var0);
    }

    waitframe();
  }
}

function get_potential_hero_players_as_target() {
  var0 = [];

  foreach(var2 in level.players) {
    if(var2.team_number == 1) {
      continue;
    }

    if(scripts\cp\cp_laststand::player_in_laststand(var2)) {
      continue;
    }

    var0 = var2;
  }

  return var0;
}

function suicide_bomber_clean_up(var0) {
  var0 endon("disconnect");
  var0 waittill("last_stand");
  var0 stoploopsound("cp_suicide_vest_slow_beep");
  var0 stoploopsound("cp_suicide_vest_fast_beep");
  var0 scripts\cp\utility::hint_prompt("activate_suicide_vest", 0);
  var0 scripts\cp\utility::hint_prompt("detonate_suicide_vest", 0);

  foreach(var2 in level.players) {
    var2 hudoutlinedisableforclient(var0);
  }
}

function suicide_bomber_explodes(var0, var1) {
  var0 endon("disconnect");
  var0 setclientomnvar("ui_securing_progress", 0);
  var0 setclientomnvar("ui_securing", 0);
  var0 playSound("cp_suicide_vest_explo_lr");
  playFX(level._effect["pvpe_suicide_bomber_explo"], var0.origin);
  earthquake(0.3, 1.5, var0.origin, 150);
  do_damage_to_target_in_range(var0);

  if(istrue(var1)) {
    var0 dodamage(var0.health + 50, var0.origin);
    return;
  }
}

function do_damage_to_target_in_range(var0) {
  var1 = 0;

  if(isDefined(var0.potential_hero_players_as_target_in_range)) {
    foreach(var3 in var0.potential_hero_players_as_target_in_range) {
      if(isDefined(var3) && !scripts\cp\cp_laststand::player_in_laststand(var3)) {
        var3 dodamage(500, var0.origin);
        var1++;
      }
    }
  }

  if(var1 > 0) {
    var0 iprintlnbold("^1" + var1 + "^7 target(s) killed!");
    var0 thread scripts\cp\cp_damagefeedback::updatedamagefeedback("hitlaststand");
    return;
  }
}

function suicide_vest_timer(var0) {
  var0 endon("disconnect");
  var0 endon("last_stand");
  var1 = 5;
  wait var1;

  for(var2 = 5; var2 > 0; var2--) {
    var0 iprintlnbold("Suicide vest exploding in ... " + var2);
    wait 1;
  }

  thread suicide_bomber_explodes(var0, var0);
}

function super_hold_think(var0, var1, var2) {
  var3 = 0;
  var0 setclientomnvar("ui_securing", var1);
  var0 notifyonplayercommand("release_LB", "-smoke");
  var0 notifyonplayercommand("release_RB", "-frag");

  for(;;) {
    var4 = var0 scripts\engine\utility::waittill_any_in_array_or_timeout(["release_LB", "release_RB"], 0.05);

    if(var4 == "timeout") {
      var3 += 0.05;
      var0 setclientomnvar("ui_securing_progress", var3 / var2);

      if(var3 >= var2) {
        var0 setclientomnvar("ui_securing_progress", 1);
        thread delay_hide_progress_widget(var0);
        return "success";
      }

      continue;
    }

    var0 setclientomnvar("ui_securing_progress", 0);
    var0 setclientomnvar("ui_securing", 0);
    return "fail";
  }
}

function delay_hide_progress_widget(var0) {
  var0 endon("disconnect");
  waitframe();
  var0 setclientomnvar("ui_securing", 0);
}

function use_hold_think(var0, var1, var2) {
  var3 = 0;
  var0 setclientomnvar("ui_securing", var1);

  for(;;) {
    waitframe();

    if(var0 useButtonPressed()) {
      var3 += 0.05;
      var0 setclientomnvar("ui_securing_progress", var3 / var2);

      if(var3 >= var2) {
        var0 setclientomnvar("ui_securing_progress", 1);
        thread delay_hide_progress_widget(var0);
        return "success";
      }

      continue;
    }

    var0 setclientomnvar("ui_securing_progress", 0);
    var0 setclientomnvar("ui_securing", 0);
    return "fail";
  }
}

function give_armor_loadout(var0) {
  var1 = scripts\cp\cp_weapon::buildweapon("iw8_sh_charlie725_mp", [], "none", "none", -1);
  var0 giveweapon(var1);
  var0 setweaponammoclip(var1, weaponclipsize(var1));
  var0 setweaponammostock(var1, weaponmaxammo(var1));
  var1 = scripts\cp\cp_weapon::buildweapon("iw8_me_riotshield_mp", [], "none", "none", -1);
  var0 giveweapon(var1);
  var0 switchtoweaponimmediate(var1);
}

function give_long_range_loadout(var0) {
  var1 = scripts\cp\cp_weapon::buildweapon("iw8_sn_alpha50_mp", ["laserads"], "none", "none", -1);
  var0 giveweapon(var1);
  var0 setweaponammoclip(var1, weaponclipsize(var1));
  var0 setweaponammostock(var1, weaponmaxammo(var1));
  var0 switchtoweaponimmediate(var1);
  thread long_range_laser_ent_think(var0);
  thread long_range_laser_vfx_think(var0);
}

function long_range_laser_ent_think(var0) {
  var0 endon("disconnect");
  var0 endon("last_stand");
  var1 = spawn("script_model", var0 gettagorigin("j_wrist_le"));
  var1 setModel("tag_origin");
  var1 linkTo(var0, "j_wrist_le");
  thread laser_ent_clean_up_monitor(var1, var1);
  var0.laser_start_ent = var1;
  var2 = spawn("script_model", var0 gettagorigin("tag_eye"));
  var2 setModel("tag_origin");
  thread laser_ent_clean_up_monitor(var2, var2);
  var0.laser_end_ent = var2;
  var3 = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_ainosight"]);

  for(;;) {
    var4 = var0 gettagorigin("tag_eye");
    var5 = anglesToForward(var0 getplayerangles());
    var6 = var4 + var5 * 20000;
    var7 = scripts\engine\trace::ray_trace(var4, var6, undefined, var3)["position"];
    var2 moveTo(var7, 0.1);
    waitframe();
  }
}

function long_range_laser_vfx_think(var0) {
  var0 endon("disconnect");
  var0 endon("last_stand");
  var0 notifyonplayercommand("long_range_start_ADS", "+speed_throw");

  for(;;) {
    var0 waittill("long_range_start_ADS");
    var1 = playfxontagsbetweenclients(level._effect["pvpe_long_range_terrorist_red_laser"], var0.laser_start_ent, "tag_origin", var0.laser_end_ent, "tag_origin");
    wait 0.5;

    while(var0 adsButtonPressed()) {
      waitframe();
    }

    var1 delete();
  }
}

function laser_ent_clean_up_monitor(var0, var1) {
  var1 scripts\engine\utility::ref_143a5("disconnect", "last_stand");
  var0 delete();
}

function give_default_terrorist_loadout(var0) {
  var1 = scripts\cp\cp_weapon::buildweapon("iw8_pi_mike1911_mp", [], "none", "none", -1);
  var0 giveweapon(var1);
  var0 switchtoweapon(var1);
}

function precache_pvpe_vfx() {
  level._effect["pvpe_selected_spawner"] = loadfx("vfx/iw8_cp/vfx_marker_selected_spawner.vfx");
  level._effect["pvpe_nearby_spawner"] = loadfx("vfx/iw8_cp/vfx_marker_nearby_spawner.vfx");
  level._effect["pvpe_enemy_marker"] = loadfx("vfx/iw8_cp/vfx_marker_enemy.vfx");
  level._effect["pvpe_friendly_marker"] = loadfx("vfx/iw8_cp/vfx_marker_friendly.vfx");
  level._effect["pvpe_long_range_terrorist_red_laser"] = loadfx("vfx/iw8_cp/vfx_red_laser_cp.vfx");
  level._effect["pvpe_suicide_bomber_explo"] = loadfx("vfx/iw8/weap/_explo/suicide/vfx_explo_suicide_bomb.vfx");
}

function delay_start_gun_game(var0) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 waittill("loadout_given");
  var1 = get_player_gun_game_level(var0);
  gun_game_change_to_weapon_at_level(var0, var1);
}

function gun_game_change_to_weapon_at_level(var0, var1) {
  if(!isDefined(level.max_gun_game_level)) {
    determine_max_gun_game_level();
  }

  if(var1 > level.max_gun_game_level) {
    return;
  }

  if(!holding_gun_game_max_level_weapon(var0)) {
    remove_all_primaries_weapon(var0);
    var2 = get_gun_game_weapon_at_level(var1);
    var3 = scripts\cp\cp_weapon::buildweapon(var2, [], "none", "none", -1);
    var0 giveweapon(var3);
    var0 switchtoweapon(var3);
    return;
  }
}

function remove_all_primaries_weapon(var0) {
  var1 = var0 getweaponslistprimaries();

  foreach(var3 in var1) {
    var0 takeweapon(var3);
  }
}

function holding_gun_game_max_level_weapon(var0) {
  var1 = var0 getweaponslistprimaries();

  foreach(var3 in var1) {
    if(var3.basename == level.max_gun_game_weapon_name) {
      return true;
    }
  }

  return false;
}

function get_gun_game_weapon_at_level(var0) {
  var1 = tablelookup("cp/cp_gun_game_weapon_progression.csv", 0, var0, 2);
  return var1;
}

function determine_max_gun_game_level() {
  level.max_gun_game_level = 0;
  level.max_gun_game_weapon_name = undefined;

  for(var0 = 1; var0 <= 100; var0++) {
    var1 = tablelookup("cp/cp_gun_game_weapon_progression.csv", 0, var0, 2);

    if(var1 == "") {
      break;
    }

    level.max_gun_game_level++;
    level.max_gun_game_weapon_name = var1;
  }
}

function increase_player_gun_game_level(var0) {
  if(!isDefined(level.max_gun_game_level)) {
    determine_max_gun_game_level();
  }

  if(!isDefined(level.players_gun_game_level)) {
    level.players_gun_game_level = [];
  }

  var1 = var0.name;

  if(!isDefined(level.players_gun_game_level[var1])) {
    level.players_gun_game_level[var1] = 1;
  }

  var2 = level.players_gun_game_level[var1];

  if(var2 >= level.max_gun_game_level) {
    return;
  }

  level.players_gun_game_level[var1]++;
}

function get_player_gun_game_level(var0) {
  if(!isDefined(level.players_gun_game_level)) {
    level.players_gun_game_level = [];
  }

  var1 = var0.name;

  if(!isDefined(level.players_gun_game_level[var1])) {
    level.players_gun_game_level[var1] = 1;
  }

  return level.players_gun_game_level[var1];
}

function pvpe_terrorist_players_respawn_timer() {
  level endon("pvpe_end_game");
  level notify("pvpe_terrorist_players_respawn_timer");
  level endon("pvpe_terrorist_players_respawn_timer");

  for(;;) {
    var0 = gettime() + 25000;
    setomnvar("cp_wave_timer", var0);

    for(var1 = 25; var1 >= 0; var1--) {
      level notify("terrorist_players_respawn_timer_at", var1);
      wait 1;
    }

    level notify("PvPE_enemy_AI_start_spawning");
  }
}

function change_to_terrorist_archetype_selected(var0) {
  remove_all_primaries_weapon(var0);
  remove_all_powers(var0);

  switch (var0.terrorist_archetype_selected) {
    case 0:
      kidnapper(var0, var0);
      break;
    case 1:
      riot_shield(var0, var0);
      break;
    case 2:
      sniper(var0, var0);
      break;
    case 3:
      var0 scripts\cp\cp_juggernaut::jugg_makejuggernaut(jugg_createconfig());
      break;
    default:
      suicide_bomber(var0, var0);
      break;
  }
}

function player_is_kidnapper(var0) {
  return isDefined(var0.terrorist_archetype_selected) && var0.terrorist_archetype_selected == 0;
}

function kidnapper(var0) {
  change_to_terrorist_model_internal(var0, "body_mp_eastern_dingo_1_1", "head_mp_eastern_azur_1_1");
  give_kidnapper_loadout(var0);
}

function suicide_bomber(var0) {
  change_to_terrorist_model_internal(var0, "body_mp_eastern_azur_3_1", "head_mp_eastern_azur_3_1");
  give_suicide_bomber_loadout(var0);
}

function riot_shield(var0) {
  change_to_terrorist_model_internal(var0, "body_mp_eastern_bale_1_1", "head_mp_eastern_bale_1_1");
  give_armor_loadout(var0);
}

function sniper(var0) {
  change_to_terrorist_model_internal(var0, "body_mp_eastern_kreuger_1_1_havok", "head_mp_eastern_kreuger_1_1");
  give_long_range_loadout(var0);
}

function jugg_createconfig(var0, var1) {
  var2 = spawnStruct();
  var2.maxhealth = 3000;
  var2.startinghealth = var2.maxhealth;
  var2.movespeedscalar = -0.2;
  var2.forcetostand = 1;
  var2.suit = "iw8_juggernaut_mp";
  var2.clothtype = "vestheavy";
  var2.infiniteammo = 1;
  var2.infiniteammoupdaterate = undefined;
  var2.classstruct = scripts\cp\cp_juggernaut::jugg_getdefaultclassstruct();
  var2.allows = [];
  var2.allows["stick_kill"] = 1;
  var2.allows["health_regen"] = 1;
  var2.allows["one_hit_melee_victim"] = 1;
  var2.allows["flashed"] = 1;
  var2.allows["stunned"] = 1;
  var2.allows["prone"] = 1;
  var2.allows["equipment"] = 1;
  var2.allows["usability"] = 1;
  var2.allows["supers"] = 1;
  var2.allows["killstreaks"] = 1;
  var2.allows["slide"] = 1;
  var2.allows["reload"] = 1;
  var2.allows["offhand_weapons"] = 1;
  var2.allows["weapon_pickup"] = 1;
  var2.allows["execution_victim"] = 0;
  var2.perks = [];
  return var2;
}

function change_to_terrorist_model(var0) {
  change_to_terrorist_model_internal(var0, "body_mp_eastern_zane_1_1", "head_mp_eastern_zane_1_1");
}

function change_to_terrorist_model_internal(var0, var1, var2, var3) {
  if(isDefined(var0.headmodel)) {
    var0 detach(var0.headmodel);
    var0.headmodel = undefined;
  }

  var0 setcustomization(var1, var2);

  if(isDefined(var2)) {
    var0 attach(var2);
    var0.headmodel = var2;
  }

  var0 setModel(var1);

  if(isDefined(var3)) {
    var0 setviewmodel(var3);
    return;
  }
}

function pvpe_round_timer() {
  level endon("pvpe_end_game");
  var0 = 1;
  wait 5;
  setomnvar("cp_pvpe_active", 1);
  var1 = gettime() + 420000;
  setomnvar("cp_round_timer", var1);
  var2 = 360;
  wait var2 - var0;
  iprintlnbold("1 minute remaining");
  wait 30;
  iprintlnbold("30 seconds remaining");
  wait 20 + var0;

  if(game["round_number"] == 1) {
    for(var3 = 10; var3 > 0; var3--) {
      iprintlnbold("Switching side in ... " + var3);
      wait 1;
    }
  } else {
    for(var3 = 10; var3 > 0; var3--) {
      iprintlnbold("Match ending in ... " + var3);
      wait 1;
    }
  }

  level thread[[level.endgame]](get_winning_team_name(), level.end_game_string_index["win"]);
}

function set_score_fraction_to_hero_team(var0) {
  var0 = int(var0 * 100);
  var0 = clamp(var0 / 100, 0, 1);

  if(game["round_number"] == 1) {
    game["round_one_hero_team_score_fraction"] = var0;
    set_team_score_for_players("cp_team_0_fractional_score", var0);
    return;
  }

  if(game["round_number"] == 2) {
    game["round_two_hero_team_score_fraction"] = var0;
    set_team_score_for_players("cp_team_1_fractional_score", var0);

    if(game_should_end_early()) {
      level thread[[level.endgame]](get_winning_team_name(), level.end_game_string_index["win"]);
      return;
    }

    return;
  }
}

function give_score_to_hero_team() {
  foreach(var1 in level.players) {
    if(var1.team_number == 0) {
      var1 iprintlnbold("^2Your team ^7has earned one point");
      continue;
    }

    var1 iprintlnbold("^1Enemy team ^7has earned one point");
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
  var0 = game["round_one_hero_team_score"] + game["round_one_hero_team_score_fraction"];
  var1 = game["round_two_hero_team_score"] + game["round_two_hero_team_score_fraction"];

  if(var0 == var1) {
    return "tie";
  }

  if(var0 > var1) {
    return "axis";
  }

  return "allies";
}

function game_should_end_early() {
  var0 = game["round_one_hero_team_score"] + game["round_one_hero_team_score_fraction"];
  var1 = game["round_two_hero_team_score"] + game["round_two_hero_team_score_fraction"];
  return var1 > var0;
}

function set_team_score_for_players(var0, var1) {
  foreach(var3 in level.players) {
    var3 setclientomnvar(var0, var1);
  }
}

function terrorist_enter_laststand(var0, var1) {
  if(player_is_suicide_bomber(var0)) {
    thread suicide_bomber_explodes(var0, var0);
  }

  if(should_do_ragdoll(var0)) {
    do_terrorist_ragdoll(var0);
  }

  var0 playerhide();
  var0 disableweapons();
  var0 allowmovement(0);
  var0 allowjump(0);
  var0.waiting_to_spawn = 1;
  var0.terrorist_overlay destroy();
  enter_ragdoll_focus_camera(var0, var1);
  wait 2;
  thread terrorists_respawn(var0, var0, get_closest_respawner_on_direction(var0.origin, undefined), scripts\engine\utility::getStructArray("terrorist_player_respawn", "targetname"));
}

function should_do_ragdoll(var0) {
  if(player_is_suicide_bomber(var0)) {
    return true;
  }

  return true;
}

function player_is_suicide_bomber(var0) {
  return isDefined(var0.terrorist_archetype_selected) && var0.terrorist_archetype_selected == 0;
}

function enter_ragdoll_focus_camera(var0, var1) {
  var2 = 250;
  var3 = 45;

  if(!isPlayer(var1)) {
    var1 = get_fake_attacker_struct(var0);
  }

  var4 = vectorNormalize(var0.origin - var1.origin);
  var4 = (var4[0], var4[1], 0);
  var5 = var0 getEye();
  var6 = var5 + var4 * var2 + (0, 0, 1) * var3;
  var7 = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_solid", "physicscontents_ainosight"]);
  var8 = scripts\engine\trace::ray_trace(var5, var6, var0, var7)["position"];
  var9 = spawn("script_model", var8);
  var9 setModel("tag_origin");
  var9.angles = vectortoangles(var1.origin - var8);
  thread ragdoll_focus_camera_clean_up_monitor(var9, var9);
  var0 cameralinkTo(var9, "tag_origin");
  var0.ragdoll_focus_camera = var9;
}

function get_fake_attacker_struct(var0) {
  var1 = 180;
  var2 = spawnStruct();
  var3 = anglesToForward(var0 getplayerangles());
  var4 = var0 gettagorigin("tag_eye");
  var2.origin = var4 + var3 * var1;
  return var2;
}

function ragdoll_focus_camera_clean_up_monitor(var0, var1) {
  var0 endon("death");
  var1 waittill("disconnect");
  var0 delete();
}

function exit_ragdoll_focus_camera(var0) {
  var0 cameraunlink();

  if(isDefined(var0.ragdoll_focus_camera)) {
    var0.ragdoll_focus_camera delete();
    return;
  }
}

function do_terrorist_ragdoll(var0) {
  var1 = var0 cloneplayer(0);
  var1 startragdoll();
}

function pvpe_allow_players_to_restart(var0) {
  if(var0 == 4) {
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
    level waittill("connected", var0);
    thread terrorist_player_initial_spawn_select(var0);
  }
}

function terrorist_player_initial_spawn_select(var0) {
  var0 endon("disconnect");
  var0 waittill("loadout_given");
  waitframe();

  if(player_is_terrorist(var0)) {
    var0.terrorist_archetype_selected = var0.slot_number;

    if(var0.terrorist_archetype_selected > 2) {
      var0.terrorist_archetype_selected = randomint(3);
    }

    change_to_terrorist_archetype_selected(var0, var0);
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