/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\pvpe\pvpe.gsc
***********************************************/

init_pvpe() {
  increment_round_number();
  randomize_team_id_to_team_number_mapping();
  randomize_session_team_to_team_number_mapping();
  cap_round_number();
  set_up_pvpe_callback();
  set_up_team_score();
  reset_in_pvpe_end_game();
  setup_play_test_name_to_team_id_mapping();
  level thread pvpe_terrorist_players_respawn_timer();
  level thread pvpe_round_timer();
  level thread pvpe_player_connect_monitor();
  level thread kidnapper_laststand_hero_watcher();
}

reset_in_pvpe_end_game() {
  game["_encstr_A26911E84271496373DD1075BE4B0E3FA6DA30"] = 0;
}

set_up_team_score() {
  if(game["_encstr_A6040D589883D39DFF28D387B14AE5"] == 1) {
    game["_encstr_8F7C1ACE2DA32D61B75FA8F8B7A8194D6A5945DD069A874B734770E0"] = 0;
    game["_encstr_829F1ACB5DFDF8BD614B4F77CF3A75408F3973A1465DB9EE5A3F7D7B"] = 0;
    game["_encstr_AB812383481D13B74967AEAD6F98BF3B48E65B7A11F91FAA907FCAB5573082BFE6FB024218"] = 0;
    game["_encstr_856A23FBA0334D4326FDB7D7AFA80F125F89230248EBC9C79968BAD538B1AB1EEFA87A3AD8"] = 0;
    level thread delay_reset_team_score_omnvar();
  } else if(game["_encstr_A6040D589883D39DFF28D387B14AE5"] == 2)
    level thread delay_set_team_score_omnvar();
}

delay_set_team_score_omnvar() {
  wait 5;
  set_team_score_for_players("_encstr_AD0E1057E059283507AA9E6B9197FE38AA4D", -1);
  wait 0.1;
  set_team_score_for_players("_encstr_BAA910196A27D8CD923F2FFBDF9B06B8A287", 0);

  for(var_0 = 0; var_0 <= game["_encstr_8F7C1ACE2DA32D61B75FA8F8B7A8194D6A5945DD069A874B734770E0"]; var_0++) {
    set_team_score_for_players("_encstr_AD0E1057E059283507AA9E6B9197FE38AA4D", var_0);
    wait 0.1;

    if(var_0 < game["_encstr_8F7C1ACE2DA32D61B75FA8F8B7A8194D6A5945DD069A874B734770E0"])
      set_team_score_for_players("_encstr_B25B1BA09B99D3CFF30D279F401608DFD710B138103280894B37DFDAAD", 1);
    else
      set_team_score_for_players("_encstr_B25B1BA09B99D3CFF30D279F401608DFD710B138103280894B37DFDAAD", game["_encstr_AB812383481D13B74967AEAD6F98BF3B48E65B7A11F91FAA907FCAB5573082BFE6FB024218"]);

    wait 0.1;
  }
}

delay_reset_team_score_omnvar() {
  wait 5;
  set_team_score_for_players("_encstr_AD0E1057E059283507AA9E6B9197FE38AA4D", -1);
  set_team_score_for_players("_encstr_BAA910196A27D8CD923F2FFBDF9B06B8A287", -1);
  waitframe();
  set_team_score_for_players("_encstr_AD0E1057E059283507AA9E6B9197FE38AA4D", 0);
  set_team_score_for_players("_encstr_BAA910196A27D8CD923F2FFBDF9B06B8A287", 0);
  set_team_score_for_players("_encstr_B25B1BA09B99D3CFF30D279F401608DFD710B138103280894B37DFDAAD", 0);
  set_team_score_for_players("_encstr_A3B81B06D321AC827F13BF7E0F94BBF198FB3C8D88384CF94E27777B53", 0);
}

increment_round_number() {
  if(!isDefined(game["_encstr_A6040D589883D39DFF28D387B14AE5"]))
    game["_encstr_A6040D589883D39DFF28D387B14AE5"] = 1;
  else
    game["_encstr_A6040D589883D39DFF28D387B14AE5"]++;
}

cap_round_number() {
  if(game["_encstr_A6040D589883D39DFF28D387B14AE5"] > 2)
    game["_encstr_A6040D589883D39DFF28D387B14AE5"] = 1;
}

randomize_team_id_to_team_number_mapping() {
  if(game["_encstr_A6040D589883D39DFF28D387B14AE5"] > 2)
    game["_encstr_8BF61F0B89A0F709F1E8B72C6268886B50C128288FBA62A352AFF7892B42736D5F"] = undefined;

  if(isDefined(game["_encstr_8BF61F0B89A0F709F1E8B72C6268886B50C128288FBA62A352AFF7892B42736D5F"])) {
    return;
  }
  var_0 = [0, 1];

  for(var_1 = 5; var_1 > 0; var_1--)
    var_0 = scripts\engine\utility::array_randomize(var_0);

  game["_encstr_8BF61F0B89A0F709F1E8B72C6268886B50C128288FBA62A352AFF7892B42736D5F"] = var_0;
}

randomize_session_team_to_team_number_mapping() {
  if(game["_encstr_A6040D589883D39DFF28D387B14AE5"] > 2)
    game["_encstr_88A7249A9F97DB54BA88B69D6B030A6F109F791CB776CA27F8FF9A804DB27F01BE6239E2B5AF"] = undefined;

  if(isDefined(game["_encstr_88A7249A9F97DB54BA88B69D6B030A6F109F791CB776CA27F8FF9A804DB27F01BE6239E2B5AF"])) {
    return;
  }
  var_0 = [0, 1];

  for(var_1 = 5; var_1 > 0; var_1--)
    var_0 = scripts\engine\utility::array_randomize(var_0);

  game["_encstr_88A7249A9F97DB54BA88B69D6B030A6F109F791CB776CA27F8FF9A804DB27F01BE6239E2B5AF"] = [];
  game["_encstr_88A7249A9F97DB54BA88B69D6B030A6F109F791CB776CA27F8FF9A804DB27F01BE6239E2B5AF"]["_encstr_8E8405EA382B2A"] = var_0[0];
  game["_encstr_88A7249A9F97DB54BA88B69D6B030A6F109F791CB776CA27F8FF9A804DB27F01BE6239E2B5AF"]["_encstr_9A8507BA4040188D08"] = var_0[1];
}

set_up_pvpe_callback() {
  level.player_is_terrorist_func = ::player_is_terrorist;
  level.playerspawnteamassignmentfunc = ::pvpe_playerspawnteamassignmentfunc;
  level.playerspawnsessionteamassignmentfunc = ::pvpe_playerspawnsessionteamassignmentfunc;
  level.coop_gameshouldendfunc = ::pvpe_gameshouldendfunc;
  level.allow_munitions = ::pvpe_allow_munitions;
  level.get_num_of_charges_for_power = ::pvpe_get_num_of_charges_for_power;
  level.allow_super = ::pvpe_allow_super;
  level.pre_map_restart_func = ::pvpe_pre_map_restart_func;
  level.endgame = ::pvpe_end_game;
  level.change_to_terrorist_model_func = ::change_to_terrorist_model;
  level.allow_players_to_restart = ::pvpe_allow_players_to_restart;
  level.forceendgame = ::pvpe_force_end_game;
  level.revive_ent_usability_func = ::pvpe_revive_ent_usability_func;
  level.disable_bleedout_ent_usability_func = ::pvpe_disable_bleedout_ent_usability_func;
  level.enable_bleedout_ent_usability_func = ::pvpe_enable_bleedout_ent_usability_func;
}

pvpe_revive_ent_usability_func(var_0, var_1) {
  var_1 endon("_encstr_AD75063D571AE108");

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
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_3);
    var_3 thread delay_disable_use(var_3, var_1);
  }
}

pvpe_disable_bleedout_ent_usability_func(var_0) {
  foreach(var_2 in level.players)
  var_0.executeent disableplayeruse(var_2);
}

pvpe_enable_bleedout_ent_usability_func(var_0) {
  foreach(var_2 in level.players) {
    if(!istrue(var_2.waiting_to_spawn) && player_is_kidnapper(var_2))
      var_0.executeent enableplayeruse(var_2);
  }
}

delay_disable_use(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_AD75063D571AE108");
  var_0 waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");
  waitframe();

  if(player_is_terrorist(var_0))
    var_1 disableplayeruse(var_0);
}

pvpe_enabled() {
  return getdvarint("_encstr_93670CB2370B313659D7C1CE38CA", 0) != 0;
}

player_is_terrorist(var_0) {
  if(!pvpe_enabled())
    return 0;

  return var_0.team_number == 1;
}

pvpe_playerspawnteamassignmentfunc(var_0) {
  var_1 = ["_encstr_9A8507BA4040188D08", "_encstr_8E8405EA382B2A", "_encstr_8DB30A47B216ADEB99EDAE39", "_encstr_93ED097B8081DD415F0BD8"];

  if(isDefined(var_0.team_number))
    return var_1[var_0.team_number];
  else
    return "_encstr_BD78059C33C543";
}

pvpe_playerspawnsessionteamassignmentfunc(var_0, var_1) {
  return var_1;
}

pvpe_gameshouldendfunc(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      continue;
    }
    if(player_is_terrorist(var_2)) {
      continue;
    }
    if(!scripts\cp\cp_laststand::player_in_laststand(var_2))
      return 0;
  }

  return 1;
}

pvpe_allow_munitions(var_0) {
  if(player_is_terrorist(var_0))
    return 0;

  return 1;
}

pvpe_get_num_of_charges_for_power(var_0) {
  if(player_is_terrorist(var_0))
    return 1;

  return scripts\cp\cp_loadout::get_default_num_equipment_charges();
}

pvpe_allow_super(var_0) {
  if(player_is_terrorist(var_0))
    return 0;

  return 1;
}

pvpe_pre_map_restart_func(var_0) {
  var_1 = get_winning_team_name();

  if(var_1 == "_encstr_8D19048EA595") {
    foreach(var_3 in level.players)
    var_3 thread scripts\cp\cp_hud_message::tutorialprint(&"_encstr_83C50E6882FA9A8A4A4AA58AF28A4A15", 4);
  } else {
    foreach(var_3 in level.players) {
      if(var_3.pers["_encstr_8AEF05472BC2D6"] == var_1) {
        var_3 thread scripts\cp\cp_hud_message::tutorialprint(&"_encstr_9B3C120D41D7A9A24A4A6954BCAC52A1A2F4922B", 4);
        continue;
      }

      var_3 thread scripts\cp\cp_hud_message::tutorialprint(&"_encstr_8F30112E9A792F0FD25F2941DE1CE5CD60763D", 4);
    }
  }

  wait 3;
}

on_spawn_terrorist_player(var_0) {
  var_0.self_revive = 1;
  var_0 scripts\cp\utility::allow_player_ignore_me(1);
  var_0.unable_to_trigger_radius_detection_monitor = 1;
  var_0.terrorist_overlay = scripts\cp\utility::create_client_overlay("_encstr_B28311ABA5BE378DB0C9CCEBDB3BB2271B585E", 1.0, self);
}

terrorists_respawn(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  exit_ragdoll_focus_camera(var_0);
  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin + (0, 0, 100));
  var_4 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_4.angles = vectortoangles((0, 0, -1));
  var_0 cameralinkTo(var_4, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_0.terrorist_respawn_camera = var_4;
  var_0 thread delay_turn_on_birds_eye_hud(var_0, var_3);
  var_0 thread play_marker_vfx_on_enemy_players(var_0);
  var_0 thread play_marker_vfx_on_friendly_players(var_0);
  var_0 thread terrorist_move_through_respawners_think(var_0, var_1, var_2, var_3);
  var_5 = getassignedspawnpointbasedonteam(var_0);
  var_0 setOrigin(var_5.origin, 1);
  var_0 waittill("_encstr_8C33133AACE49CDB27B4CD3ABE4EB2DCB038EE736E", var_6);
  level thread play_terrorist_respawn_music();
  var_0 stop_marker_vfx_on_enemy_players(var_0);
  var_0 stop_marker_vfx_on_friendly_players(var_0);
  delete_respawner_markers(var_0);
  terrorist_camera_move_to(var_6.origin + (0, 0, 85), var_0);
  var_0.terrorist_respawn_camera delete();
  var_0 setclientomnvar("_encstr_8A6E12BAD2F5C4A5E48C9BFA2B5E59BECE2DCABB", 0);
  var_0 cameraunlink();
  var_0 setOrigin(var_6.origin);

  if(isDefined(var_6.angles))
    var_0 setplayerangles(var_6.angles);

  var_0 allowmovement(1);
  var_0 allowjump(1);
  var_0 playershow();
  var_0 enableweapons();
  var_0.waiting_to_spawn = 0;
  var_0.terrorist_overlay = scripts\cp\utility::create_client_overlay("_encstr_B28311ABA5BE378DB0C9CCEBDB3BB2271B585E", 1.0, var_0);
  var_0 change_to_terrorist_archetype_selected(var_0);
  var_0 thread delay_play_marker_vfx_to_players_waiting_to_respawn(var_0);
}

delay_turn_on_birds_eye_hud(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_AF100EBFFE4B212FCF7A8051C2E61379");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(game["_encstr_A26911E84271496373DD1075BE4B0E3FA6DA30"] == 1) {
    return;
  }
  if(istrue(var_1))
    var_0 waittill("_encstr_9695073995D94BD959");

  var_0 thread archetype_selection_monitor(var_0);
  var_0 setclientomnvar("_encstr_8A6E12BAD2F5C4A5E48C9BFA2B5E59BECE2DCABB", 1);
}

archetype_selection_monitor(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8C33133AACE49CDB27B4CD3ABE4EB2DCB038EE736E");
  var_0.terrorist_archetype_selected = 0;

  for(;;) {
    var_0 waittill("_encstr_8DEB10B1FD2F404F8B0A906083E72D1B7782", var_1, var_2);

    if(isDefined(var_1) && var_1 == "_encstr_B283199395E60785BBB9EB8E5E38B2F51A5AD91AD84BEC43E85632")
      var_0.terrorist_archetype_selected = var_2;
  }
}

stop_marker_vfx_on_enemy_players(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      continue;
    }
    if(var_2.team_number == 1) {
      continue;
    }
    stopfxontagforclients(level._effect["_encstr_BEEF12E87518C7DF1560E26AEA606FBE60D77552"], var_2, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_0);
  }
}

stop_marker_vfx_on_friendly_players(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      continue;
    }
    if(var_2.team_number == 0) {
      continue;
    }
    stopfxontagforclients(level._effect["_encstr_8EAD15D94E2A1880B30330B9EA93C12009BD0355CBD7E8"], var_2, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_0);
  }
}

delete_respawner_markers(var_0) {
  if(isDefined(var_0.terrorist_selected_respawner_marker))
    var_0.terrorist_selected_respawner_marker delete();

  foreach(var_2 in var_0.terrorist_nearby_respawner_markers) {
    if(isDefined(var_2))
      var_2 delete();
  }

  reset_respawner_markers(var_0);
}

play_terrorist_respawn_music() {
  var_0 = "_encstr_B65812C0F71213877314FE05E10BEB7B787F50A8";
  var_1 = 7;

  if(istrue(level.playing_terrorist_respawn_music)) {
    return;
  }
  level.playing_terrorist_respawn_music = 1;

  foreach(var_3 in level.players)
  var_3 playlocalsound(var_0);

  wait(var_1);
  level.playing_terrorist_respawn_music = 0;
}

play_marker_vfx_on_enemy_players(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8C33133AACE49CDB27B4CD3ABE4EB2DCB038EE736E");

  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      continue;
    }
    if(var_2.team_number == 1) {
      continue;
    }
    playfxontagforclients(level._effect["_encstr_BEEF12E87518C7DF1560E26AEA606FBE60D77552"], var_2, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_0);
    waitframe();
  }
}

delay_play_marker_vfx_to_players_waiting_to_respawn(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8C33133AACE49CDB27B4CD3ABE4EB2DCB038EE736E");
  wait 0.5;

  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      continue;
    }
    if(var_2.team_number == 0) {
      continue;
    }
    if(istrue(var_2.waiting_to_spawn))
      play_marker_vfx_on_friendly_player(var_0, var_2);

    waitframe();
  }
}

play_marker_vfx_on_friendly_players(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8C33133AACE49CDB27B4CD3ABE4EB2DCB038EE736E");

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

play_marker_vfx_on_friendly_player(var_0, var_1) {
  playfxontagforclients(level._effect["_encstr_8EAD15D94E2A1880B30330B9EA93C12009BD0355CBD7E8"], var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_1);
  var_0 thread stop_marker_vfx_on_friendly_player_think(var_0, var_1);
}

stop_marker_vfx_on_friendly_player_think(var_0, var_1) {
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_8C33133AACE49CDB27B4CD3ABE4EB2DCB038EE736E");
  var_0 waittill("_encstr_8CBE0BD1BED30936AB03C0B02B");
  stopfxontagforclients(level._effect["_encstr_8EAD15D94E2A1880B30330B9EA93C12009BD0355CBD7E8"], var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_1);
}

terrorist_move_through_respawners_think(var_0, var_1, var_2, var_3) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8C33133AACE49CDB27B4CD3ABE4EB2DCB038EE736E");
  reset_respawner_markers(var_0);
  mark_selected_terrorist_respawner(var_0, var_1);
  var_0 move_terrorist_respawn_camera(var_0);
  var_0 thread terrorist_decide_respawn_think(var_0, var_3);
  var_0 thread respawn_camera_movement_think(var_0);
  var_0 thread respawner_selection_think(var_0, var_2);
}

respawner_selection_think(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8C33133AACE49CDB27B4CD3ABE4EB2DCB038EE736E");

  for(;;) {
    if(isDefined(var_0.terrorist_respawner_selected) && distance2dsquared(var_0.terrorist_respawner_selected.origin, var_0.terrorist_respawn_camera.origin) > 40000)
      unmark_selected_terrorist_respawner(var_0);

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

show_terrorist_respawner(var_0, var_1) {
  if(scripts\engine\utility::array_contains(var_0.terrorist_nearby_respawners, var_1)) {
    return;
  }
  var_2 = spawnfxforclient(level._effect["_encstr_8CD1140E3BE0B2D79BAC582713CBFAE61C58DD9B9527"], get_adjusted_marker_vfx_pos(var_1.origin) + (0, 0, 50), var_0, (0, 0, 1), (1, 0, 0));
  triggerfx(var_2);
  var_1.marker_vfx = var_2;
  var_0.terrorist_nearby_respawner_markers[var_0.terrorist_nearby_respawner_markers.size] = var_2;
  var_0.terrorist_nearby_respawners[var_0.terrorist_nearby_respawners.size] = var_1;
}

unshow_terrorist_respawner(var_0, var_1) {
  if(scripts\engine\utility::array_contains(var_0.terrorist_nearby_respawners, var_1)) {
    var_1.marker_vfx delete();
    var_0.terrorist_nearby_respawners = scripts\engine\utility::array_remove(var_0.terrorist_nearby_respawners, var_1);
  }
}

unmark_selected_terrorist_respawner(var_0) {
  var_0.terrorist_respawner_selected = undefined;

  if(isDefined(var_0.terrorist_selected_respawner_marker))
    var_0.terrorist_selected_respawner_marker delete();

  if(game["_encstr_A26911E84271496373DD1075BE4B0E3FA6DA30"] == 0) {
    if(!istrue(var_0.in_respawn_delay)) {
      var_0 scripts\cp\utility::hint_prompt("_encstr_BD410D4ECAB91C85EECDEBA1B4733A", 0);
      var_0 scripts\cp\utility::hint_prompt("_encstr_BDCD11B995D8CA6C1DF593B2DC83B0BB73B2C9", 1);
    }
  }
}

respawn_camera_movement_think(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8C33133AACE49CDB27B4CD3ABE4EB2DCB038EE736E");
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
    } else
      var_0.moving_respawn_camera = 0;

    waitframe();
  }
}

wait_for_global_respawn_timer() {
  level waittill("_encstr_88E7236392AB23976BAB62200FAB527FA3C0D0EEE62007F35A6A0B2B865C897DC7234703E3", var_0);
  wait(var_0);
}

terrorist_decide_respawn_think(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_AF100EBFFE4B212FCF7A8051C2E61379");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(game["_encstr_A26911E84271496373DD1075BE4B0E3FA6DA30"] == 1) {
    return;
  }
  if(istrue(var_1)) {
    var_0 waittill("_encstr_9695073995D94BD959");
    var_0 scripts\cp\utility::hint_prompt("_encstr_ADC611A3B78370478BBBB7D7A7D21918278BA8", 1);
    var_0.in_respawn_delay = 1;
    var_0 setclientomnvar("_encstr_922C131FA80148FB77B3565BBA7B25716319BB9B32", 1);
    wait_for_global_respawn_timer();
    var_0 setclientomnvar("_encstr_922C131FA80148FB77B3565BBA7B25716319BB9B32", 0);
    var_0 scripts\cp\utility::hint_prompt("_encstr_ADC611A3B78370478BBBB7D7A7D21918278BA8", 0);
    var_0.in_respawn_delay = 0;
  }

  if(isDefined(var_0.terrorist_respawner_selected))
    var_0 scripts\cp\utility::hint_prompt("_encstr_BD410D4ECAB91C85EECDEBA1B4733A", 1);
  else
    var_0 scripts\cp\utility::hint_prompt("_encstr_BDCD11B995D8CA6C1DF593B2DC83B0BB73B2C9", 1);

  var_0 notifyonplayercommand("_encstr_AAF01FBB906B5895C2B4184D91C3E154E5D908B90319CA1FC0874233CEFC957560", "_encstr_B44609DFE7078F394E1651");

  for(;;) {
    var_0 waittill("_encstr_AAF01FBB906B5895C2B4184D91C3E154E5D908B90319CA1FC0874233CEFC957560");

    if(isDefined(var_0.terrorist_respawner_selected)) {
      break;
    }
  }

  var_0 scripts\cp\utility::hint_prompt("_encstr_BD410D4ECAB91C85EECDEBA1B4733A", 0);
  var_0 scripts\cp\utility::hint_prompt("_encstr_BDCD11B995D8CA6C1DF593B2DC83B0BB73B2C9", 0);
  var_0 notify("_encstr_8C33133AACE49CDB27B4CD3ABE4EB2DCB038EE736E", var_0.terrorist_respawner_selected);
}

move_terrorist_respawn_camera(var_0) {
  var_1 = var_0.terrorist_respawner_selected;
  var_2 = (var_1.origin[0], var_1.origin[1], var_1.origin[2] + 4000);
  terrorist_camera_move_to(var_2, var_0);
}

terrorist_camera_move_to(var_0, var_1) {
  var_2 = distance(var_1.terrorist_respawn_camera.origin, var_0);
  var_3 = var_2 / 7000;
  var_1.terrorist_respawn_camera moveTo(var_0, var_3);
  wait(var_3);
}

reset_respawner_markers(var_0) {
  var_0.terrorist_nearby_respawners = [];
  var_0.terrorist_nearby_respawner_markers = [];
  var_0.terrorist_selected_respawner_marker = undefined;
}

mark_selected_terrorist_respawner(var_0, var_1) {
  if(isDefined(var_0.terrorist_respawner_selected) && var_0.terrorist_respawner_selected == var_1) {
    return;
  }
  if(game["_encstr_A26911E84271496373DD1075BE4B0E3FA6DA30"] == 0) {
    if(!istrue(var_0.in_respawn_delay)) {
      var_0 scripts\cp\utility::hint_prompt("_encstr_BDCD11B995D8CA6C1DF593B2DC83B0BB73B2C9", 0);
      var_0 scripts\cp\utility::hint_prompt("_encstr_BD410D4ECAB91C85EECDEBA1B4733A", 1);
    }
  }

  var_0.terrorist_respawner_selected = var_1;
  var_2 = spawnfxforclient(level._effect["_encstr_BAE4166FCB539BA63BD75818A754B9C10932E77F634A53CB"], get_adjusted_marker_vfx_pos(var_0.terrorist_respawner_selected.origin) + (0, 0, 50), var_0, (0, 0, 1), (1, 0, 0));
  triggerfx(var_2);
  var_0.terrorist_selected_respawner_marker = var_2;
}

get_closest_respawner_on_direction(var_0, var_1) {
  var_2 = scripts\engine\utility::getStructArray("_encstr_9376192017F233A75334DE65814B9919518F980123BDAB518A5B58", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  if(isDefined(var_1)) {
    var_3 = get_respawners_in_desired_direction(var_0, var_1, var_2);

    if(var_3.size > 0) {
      return scripts\engine\utility::getclosest(var_0, var_3);
      return;
    }

    return undefined;
    return;
  } else
    return scripts\engine\utility::getclosest(var_0, var_2);
}

get_respawners_in_desired_direction(var_0, var_1, var_2) {
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = var_5.origin - var_0;
    var_6 = (var_6[0], var_6[1], 0);

    if(distance2dsquared(var_0, var_5.origin) < 2500) {
      continue;
    }
    if(vectordot(var_6, var_1) > 0)
      var_3[var_3.size] = var_5;
  }

  return var_3;
}

getassignedspawnpointbasedonteam(var_0) {
  var_1 = get_spawn_point_targetname(var_0);
  var_2 = scripts\engine\utility::getStructArray(var_1, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_3 = var_2[var_0.slot_number];
  return var_3;
}

get_spawn_point_targetname(var_0) {
  if(var_0.team_number == 0)
    return "_encstr_977415C0B27F2B43438C503F7C9F0AFBA2B9C0C86A1249";
  else
    return "_encstr_927A178B936E733FD868E22BC6A0741A433B2BAF27958AFAD0";
}

update_respawners_vfx(var_0) {
  delete_respawner_markers(var_0);
  var_1 = spawnfxforclient(level._effect["_encstr_BAE4166FCB539BA63BD75818A754B9C10932E77F634A53CB"], get_adjusted_marker_vfx_pos(var_0.terrorist_respawner_selected.origin) + (0, 0, 50), var_0, (0, 0, 1), (1, 0, 0));
  triggerfx(var_1);
  var_0.terrorist_selected_respawner_marker = var_1;
  var_2 = get_nearby_respawners(var_0);
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = spawnfxforclient(level._effect["_encstr_8CD1140E3BE0B2D79BAC582713CBFAE61C58DD9B9527"], get_adjusted_marker_vfx_pos(var_5.origin) + (0, 0, 50), var_0, (0, 0, 1), (1, 0, 0));
    triggerfx(var_6);
    var_3[var_3.size] = var_6;
  }

  var_0.terrorist_nearby_respawner_markers = var_3;
}

get_nearby_respawners(var_0) {
  var_1 = [];
  var_2 = ["_encstr_A36E1CDAEDECCAAF3AEDAF39569B381677735993D7DB37BE1D4395AFAE07", "_encstr_93591E6B7BD9B2BE8EDED739B2B907C2EE37B239BEDECDEB3AA159EB23B77737", "_encstr_B4171EF8620B537673C7AF8EA507DB23331A2088D9E58D8EABF81510B467C1C1", "_encstr_AAF41FDFC07BE099C435794E40C34359EC78805BEF153A1FF0B3C7C10AF3D7F350"];

  foreach(var_4 in var_2) {
    var_5 = get_closest_respawner_on_direction(var_0.terrorist_respawner_selected.origin, get_desired_direction_based_on_input(var_4));

    if(isDefined(var_5) && !scripts\engine\utility::array_contains(var_1, var_5))
      var_1[var_1.size] = var_5;
  }

  return var_1;
}

get_desired_direction_based_on_input(var_0) {
  switch (var_0) {
    case "_encstr_A36E1CDAEDECCAAF3AEDAF39569B381677735993D7DB37BE1D4395AFAE07":
      return (1, 0, 0);
    case "_encstr_93591E6B7BD9B2BE8EDED739B2B907C2EE37B239BEDECDEB3AA159EB23B77737":
      return (-1, 0, 0);
    case "_encstr_B4171EF8620B537673C7AF8EA507DB23331A2088D9E58D8EABF81510B467C1C1":
      return (0, 1, 0);
    case "_encstr_AAF41FDFC07BE099C435794E40C34359EC78805BEF153A1FF0B3C7C10AF3D7F350":
      return (0, -1, 0);
  }
}

player_moving_respawn_camera(var_0, var_1) {
  if(abs(var_0) != 0)
    return 1;

  if(abs(var_1) != 0)
    return 1;

  return 0;
}

get_adjusted_marker_vfx_pos(var_0) {
  return scripts\engine\trace::ray_trace_detail(var_0 + (0, 0, 5000), var_0)["_encstr_BD260953AA97E3F014279D"];
}

initialize_player_team_slot_assignment() {
  var_0 = [];

  for(var_1 = 0; var_1 < 4; var_1++)
    var_0[var_0.size] = var_1;

  for(var_2 = 0; var_2 < 5; var_2++)
    var_0 = scripts\engine\utility::array_randomize(var_0);

  var_3 = [];

  for(var_4 = 0; var_4 < 4; var_4++)
    var_3[var_3.size] = var_4;

  for(var_5 = 0; var_5 < 5; var_5++)
    var_3 = scripts\engine\utility::array_randomize(var_3);

  level.team_id_one_slot_assignment_index = 0;
  level.team_id_zero_slot_assignment_index = 0;
  level.team_id_one_slot_index_list = var_0;
  level.team_id_zero_slot_index_list = var_3;
}

assign_pvpe_team_and_slot_number(var_0) {
  var_1 = var_0 getplayerdata("_encstr_850703B7D9", "_encstr_8AC50A4D327B2B96039F9F95", "_encstr_8BD6092BB3484AE75EE3E3");
  var_2 = get_team_and_slot_number_struct(var_0, var_1);
  var_3 = var_2.team_number;
  var_4 = var_2.slot_number;
  var_0.team_number = var_3;
  var_0.slot_number = var_4;
  var_0.team_and_slot_number_struct = var_2;
  set_player_playing_as_terrorist_omnvar(var_0);
  assign_player_team(var_0);

  if(game["_encstr_A6040D589883D39DFF28D387B14AE5"] == 1)
    var_0 setclientomnvar("_encstr_932D1309F7E120C09AA37B3A77E8F7AF6DE9A86D27", var_3);

  if(should_disable_infil_for_player(var_0))
    disableplayerinfil(var_0);
}

assign_player_team(var_0) {
  if(var_0.team_number == 0)
    var_0.pers["_encstr_8AEF05472BC2D6"] = "_encstr_9A8507BA4040188D08";
  else
    var_0.pers["_encstr_8AEF05472BC2D6"] = "_encstr_8E8405EA382B2A";
}

should_disable_infil_for_player(var_0) {
  return player_is_terrorist(var_0);
}

disableplayerinfil(var_0) {
  var_0.infil_disabled = 1;
}

terrorist_self_revive_time_override(var_0) {
  if(var_0.team_number == 1)
    var_0.self_revive_wait_override = 0.05;
}

get_team_and_slot_number_struct(var_0, var_1) {
  if(player_in_party(var_1))
    return get_team_id_zero_assignment_first(var_0);
  else
    return get_team_id_one_assignment_first(var_0);
}

get_team_id_zero_assignment_first(var_0) {
  if(more_team_id_zero_slot_available())
    return make_team_id_zero_team_and_slot_number_struct(var_0);
  else
    return make_team_id_one_team_and_slot_number_struct(var_0);
}

more_team_id_zero_slot_available() {
  return level.team_id_zero_slot_assignment_index < 4;
}

make_team_id_zero_team_and_slot_number_struct(var_0) {
  var_1 = get_team_id_zero_slot();
  var_2 = get_team_number(var_0, 0);
  return make_team_and_slot_number_struct(var_2, var_1);
}

make_team_id_one_team_and_slot_number_struct(var_0) {
  var_1 = get_team_id_one_slot();
  var_2 = get_team_number(var_0, 1);
  return make_team_and_slot_number_struct(var_2, var_1);
}

get_team_number(var_0, var_1) {
  if(game["_encstr_A6040D589883D39DFF28D387B14AE5"] == 1) {
    if(isDefined(game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower(var_0.name)]))
      var_2 = game["_encstr_8BF61F0B89A0F709F1E8B72C6268886B50C128288FBA62A352AFF7892B42736D5F"][game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower(var_0.name)]];
    else if(player_selected_team_in_front_end(var_0))
      var_2 = game["_encstr_88A7249A9F97DB54BA88B69D6B030A6F109F791CB776CA27F8FF9A804DB27F01BE6239E2B5AF"][var_0.sessionteam];
    else
      var_2 = game["_encstr_8BF61F0B89A0F709F1E8B72C6268886B50C128288FBA62A352AFF7892B42736D5F"][var_1];

    if(var_0.sessionteam == "_encstr_9A8507BA4040188D08")
      var_2 = 0;
    else if(var_0.sessionteam == "_encstr_8E8405EA382B2A")
      var_2 = 1;

    var_0.pers["_encstr_AD341B83B30E56D7C9DEBAB923F5DB372BAFE8ACC26BF59BAB5B26599C"] = var_2;
    return var_2;
  } else if(game["_encstr_A6040D589883D39DFF28D387B14AE5"] == 2) {
    switch (var_0.pers["_encstr_AD341B83B30E56D7C9DEBAB923F5DB372BAFE8ACC26BF59BAB5B26599C"]) {
      case 0:
        return 1;
      case 1:
        return 0;
    }
  }
}

set_player_playing_as_terrorist_omnvar(var_0) {
  if(var_0.team_number == 1)
    var_0 setclientomnvar("_encstr_BD6712AE505F2BF176A3C1E01ACA8580B3E12E9D", 1);
  else
    var_0 setclientomnvar("_encstr_BD6712AE505F2BF176A3C1E01ACA8580B3E12E9D", 0);
}

player_selected_team_in_front_end(var_0) {
  if(isDefined(var_0.sessionteam))
    return var_0.sessionteam == "_encstr_8E8405EA382B2A" || var_0.sessionteam == "_encstr_9A8507BA4040188D08";

  return 0;
}

get_team_id_zero_slot() {
  var_0 = level.team_id_zero_slot_index_list[level.team_id_zero_slot_assignment_index];
  level.team_id_zero_slot_assignment_index++;
  return var_0;
}

make_team_and_slot_number_struct(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.team_number = var_0;
  var_2.slot_number = var_1;
  return var_2;
}

get_team_id_one_slot() {
  var_0 = level.team_id_one_slot_index_list[level.team_id_one_slot_assignment_index];
  level.team_id_one_slot_assignment_index++;
  return var_0;
}

player_in_party(var_0) {
  return var_0 != -1;
}

get_team_id_one_assignment_first(var_0) {
  if(more_team_one_slot_available())
    return make_team_id_one_team_and_slot_number_struct(var_0);
  else
    return make_team_id_zero_team_and_slot_number_struct(var_0);
}

more_team_one_slot_available() {
  return level.team_id_one_slot_assignment_index < 4;
}

pvpe_force_end_game() {
  level thread scripts\cp\cp_endgame::endgame(get_winning_team_name(), scripts\cp\cp_endgame::get_end_game_string_index("_encstr_BA970939F8483496FDA8C0"));
}

pvpe_end_game(var_0, var_1) {
  level notify("_encstr_AF100EBFFE4B212FCF7A8051C2E61379");
  game["_encstr_A26911E84271496373DD1075BE4B0E3FA6DA30"] = 1;
  turn_off_players_birds_view_hud();

  if(pvpe_game_should_really_end()) {
    scripts\cp\cp_endgame::endgame(var_0, var_1);
    return;
  }

  foreach(var_3 in level.players)
  var_3 thread scripts\cp\cp_hud_message::tutorialprint(&"_encstr_953A1925B11003494F730FD9256729DC370D3CB91448E16F8CC18B", 5);

  scripts\cp\cp_endgame::freezeallplayers(1.0, "_encstr_A11E0A5D8FF1E1519E04D72C", 1);
  wait 5;
  setomnvar("_encstr_BE51134A8548B7C3DFD8F55DDD85E30EA7D1CB58E8", 1);
  setomnvarforallclients("_encstr_8F221028C7DFA391C4B9557B8FB3B3584DF0", 0);
  map_restart(1);
}

turn_off_players_birds_view_hud() {
  foreach(var_1 in level.players) {
    var_1 setclientomnvar("_encstr_8A6E12BAD2F5C4A5E48C9BFA2B5E59BECE2DCABB", 0);
    var_1 scripts\cp\utility::hint_prompt("_encstr_ADC611A3B78370478BBBB7D7A7D21918278BA8", 0);
    var_1 scripts\cp\utility::hint_prompt("_encstr_BD410D4ECAB91C85EECDEBA1B4733A", 0);
    var_1 scripts\cp\utility::hint_prompt("_encstr_BDCD11B995D8CA6C1DF593B2DC83B0BB73B2C9", 0);
  }
}

pvpe_game_should_really_end() {
  return game["_encstr_A6040D589883D39DFF28D387B14AE5"] == 2;
}

delay_give_archetype_loadout(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 waittill("_encstr_B4C40E582257FDB09BB4077FC103B8B0");
  remove_all_primaries_weapon(var_0);

  if(!isDefined(var_0.terrorist_archetype_selected)) {
    var_0 give_default_terrorist_loadout(var_0);
    return;
  }
}

remove_all_powers(var_0) {
  foreach(var_3, var_2 in var_0.powers)
  var_0 scripts\cp\cp_powers::removepower(var_3);
}

give_poison_gas_loadout(var_0) {
  var_1 = scripts\cp\cp_weapon::buildweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C", [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
  var_0 giveweapon(var_1);
  var_0 switchtoweaponimmediate(var_1);
  var_0 thread scripts\cp\cp_powers::givepower("_encstr_87CB0E0B177C92B2411875BD7030E71B", "_encstr_BA7F0830B3A7859B60B0", undefined, undefined, undefined, undefined, 1, 5);
  var_0 thread scripts\cp\cp_powers::givepower("_encstr_8D7C09102FE7216D71A66D", "_encstr_AC8F0AE74163F85AAA380AD8", undefined, undefined, undefined, undefined, 1, 1);
}

give_kidnapper_loadout(var_0) {
  var_1 = scripts\cp\cp_weapon::buildweapon("_encstr_BED80D7C9C59D95BF870DBDFA9F018", [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
  var_0 giveweapon(var_1);
  var_0 switchtoweaponimmediate(var_1);
  var_0 setweaponammoclip("_encstr_BEB611F03B72BB3B07E435BCF9772051117388", 1);
  var_0 thread scripts\cp\cp_powers::givepower("_encstr_B8F514D0A28B93131F1C5B4EEF57B87D7708B8908AA7", "_encstr_BA7F0830B3A7859B60B0", undefined, undefined, undefined, undefined, 1, 2);
  var_0 thread scripts\cp\cp_powers::givepower("_encstr_ABE813B8E843EAD21733C8EF4C832F8BBB8581C741", "_encstr_AC8F0AE74163F85AAA380AD8", undefined, undefined, undefined, undefined, 1, 2);
  var_0 thread kidnapper_enable_execute(var_0);
  var_0 thread kidnapper_target_think(var_0);
  var_0 thread kidnapper_disguise_think(var_0);
  var_0 thread kidnapper_clean_up(var_0);
}

kidnapper_clean_up(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 scripts\engine\utility::_id_143A5("_encstr_8CBE0BD1BED30936AB03C0B02B", "_encstr_9991113D543BC7AB6937D8EA2FADA107E27A2E");
  var_0 scripts\cp\utility::hint_prompt("_encstr_A28A0F9BE858C9D1AF23B4CD9DEAB4B956", 0);
  var_0 unmark_kidnapper_target(var_0);
  var_0 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0);
  var_0 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
  level.execute_entities = scripts\engine\utility::array_removeundefined(level.execute_entities);

  foreach(var_2 in level.execute_entities)
  var_2 disableplayeruse(var_0);
}

kidnapper_laststand_hero_watcher() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level.execute_entities = [];

  for(;;) {
    level waittill("_encstr_B49925EEC2968ED2CDECEB47EDD731ACFA93B23B2D67B291F5CC93DEADFAB12CE63AB91DB0E623", var_0);

    if(var_0.team_number == 1) {
      continue;
    }
    var_1 = scripts\cp\cp_laststand::makeexecuteentity(var_0, var_0.origin);
    var_1 disable_all_players_use(var_1);
    level.execute_entities[level.execute_entities.size] = var_1;
    level notify("_encstr_95E113CDCABBD7CA1ECAB1AB47567D59DC4796D1CB", var_1);
  }
}

disable_all_players_use(var_0) {
  foreach(var_2 in level.players)
  var_0 disableplayeruse(var_2);
}

kidnapper_enable_execute(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  level.execute_entities = scripts\engine\utility::array_removeundefined(level.execute_entities);

  foreach(var_2 in level.execute_entities)
  var_2 enableplayeruse(var_0);

  for(;;) {
    level waittill("_encstr_95E113CDCABBD7CA1ECAB1AB47567D59DC4796D1CB", var_4);
    var_4 enableplayeruse(var_0);
  }
}

kidnapper_disguise_think(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 endon("_encstr_9991113D543BC7AB6937D8EA2FADA107E27A2E");

  for(;;) {
    wait_for_super_button_pressed(var_0);

    if(isDefined(var_0.kidnapper_target_player)) {
      var_1 = var_0.kidnapper_target_player;
      var_0 scripts\cp\utility::hint_prompt("_encstr_A28A0F9BE858C9D1AF23B4CD9DEAB4B956", 0);
      var_0.is_putting_on_disguise = 1;
      var_0 cameraset("_encstr_ADC71F81B69DD8CEEA7FCFFBD7639850178D2B39DCEC51A72153DFFDA79AD020C5");
      var_2 = super_hold_think(var_0, 13, 1.5);

      if(var_2 == "_encstr_88E30897BDF1B71F7823") {
        var_0 disguise_as_enemy(var_0, var_1);
        var_0 scripts\cp\utility::_setperk("_encstr_B6E812E233105BA29FF1F3FFAFBEFB89D8F99DEF");
        var_0 thread remove_spygame_when_down(var_0);
        wait 0.5;
        var_0.is_putting_on_disguise = 0;
        var_0 cameradefault();
        var_0 notify("_encstr_9991113D543BC7AB6937D8EA2FADA107E27A2E");
      } else {
        var_0.is_putting_on_disguise = 0;
        var_0 cameradefault();
      }
    }
  }
}

remove_spygame_when_down(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 waittill("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 scripts\cp\utility::_unsetperk("_encstr_B6E812E233105BA29FF1F3FFAFBEFB89D8F99DEF");
}

disguise_as_enemy(var_0, var_1) {
  var_0 setcustomization(var_1.setcustomization_body, var_1.setcustomization_head);
  var_2 = var_1.bodymodel;
  var_3 = var_1.headmodel;
  var_4 = var_1.viewmodel;
  change_to_terrorist_model_internal(var_0, var_2, var_3, var_4);
}

wait_for_super_button_pressed(var_0) {
  for(;;) {
    var_0 waittill("_encstr_A2600E386AB2399AF3D9B99FA3BDBAA0", var_1);

    if(issameweapon(var_1) && createheadicon(var_1) == "_encstr_BEB611F03B72BB3B07E435BCF9772051117388") {
      var_0 setweaponammoclip("_encstr_BEB611F03B72BB3B07E435BCF9772051117388", 1);
      return;
    }
  }
}

kidnapper_target_think(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 endon("_encstr_9991113D543BC7AB6937D8EA2FADA107E27A2E");

  for(;;) {
    var_1 = get_all_hero_players();
    var_2 = [];

    foreach(var_4 in var_1) {
      var_5 = is_hero_player_within_reticle(var_4, var_0);

      if(var_5) {
        var_6 = does_hero_player_pass_traces(var_4, var_0);

        if(var_6)
          var_2[var_2.size] = var_4;
      }

      waitframe();
    }

    if(var_2.size > 0) {
      if(!istrue(var_0.is_putting_on_disguise))
        var_0 scripts\cp\utility::hint_prompt("_encstr_A28A0F9BE858C9D1AF23B4CD9DEAB4B956", 1);

      var_8 = scripts\engine\utility::getclosest(var_0.origin, var_2);

      if(isDefined(var_0.kidnapper_target_player)) {
        if(var_0.kidnapper_target_player != var_8) {
          unmark_kidnapper_target(var_0);
          mark_hero_as_kidnapper_target(var_8, var_0);
        }
      } else
        mark_hero_as_kidnapper_target(var_8, var_0);
    } else {
      var_0 scripts\cp\utility::hint_prompt("_encstr_A28A0F9BE858C9D1AF23B4CD9DEAB4B956", 0);
      unmark_kidnapper_target(var_0);
    }

    waitframe();
  }
}

mark_hero_as_kidnapper_target(var_0, var_1) {
  var_0 hudoutlineenableforclient(var_1, "_encstr_9B0F12DE5DE8B15AB9B2F53295834734F54E59C8");
  var_1.kidnapper_target_player = var_0;
}

unmark_kidnapper_target(var_0) {
  if(isDefined(var_0.kidnapper_target_player)) {
    var_0.kidnapper_target_player hudoutlinedisableforclient(var_0);
    var_0.kidnapper_target_player = undefined;
  }
}

does_hero_player_pass_traces(var_0, var_1) {
  var_2 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_990C1A3886E537A5B1CD1BBDB98EACB91DCDFA85D2CDDE9BA5EC1A8E"]);

  if(scripts\engine\trace::ray_trace_passed(var_1 getEye(), var_0 getEye(), [var_1], var_2))
    return 1;

  if(scripts\engine\trace::ray_trace_passed(var_1 getEye(), var_0.origin, [var_1], var_2))
    return 1;

  return 0;
}

is_hero_player_within_reticle(var_0, var_1) {
  if(var_1 worldpointinreticle_circle(var_0 getEye(), 65, 115))
    return 1;

  if(var_1 worldpointinreticle_circle(var_0.origin, 65, 115))
    return 1;

  return 0;
}

get_all_hero_players() {
  var_0 = [];

  if(!isDefined(level.players))
    return var_0;

  foreach(var_2 in level.players) {
    if(var_2.team_number == 0)
      var_0[var_0.size] = var_2;
  }

  return var_0;
}

give_suicide_bomber_loadout(var_0) {
  var_0 thread suicide_bomber_think(var_0);
  var_0 thread suicide_bomber_clean_up(var_0);
}

suicide_bomber_think(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_1 = scripts\cp\cp_weapon::buildweapon("_encstr_A7660DA5EE0EAFCCD237D1DC7D6B1C", [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
  var_0 giveweapon(var_1);
  var_0 switchtoweaponimmediate(var_1);
  var_0 scripts\cp\utility::hint_prompt("_encstr_BE3A162C1B47B4B32C1DB2F59B572D6CD223AC7D3B59DC8E", 1);
  var_0 notifyonplayercommand("_encstr_BE3A162C1B47B4B32C1DB2F59B572D6CD223AC7D3B59DC8E", "_encstr_97410B23BD6B976233901AF2F8");
  var_0 notifyonplayercommand("_encstr_B1B21D7DD935E01E0369B9E1C3DF54684B2D87CF6D5CE86B5BE2764B3A9F0D", "_encstr_AA2A0BA05B7B203642ABFFEBA3");
  var_0 notifyonplayercommand("_encstr_AB4A1623983BD75A03FD9701660362632038BF47F8F103C3", "_encstr_97410B23BD6B976233901AF2F8");

  for(;;) {
    var_0 waittill("_encstr_BE3A162C1B47B4B32C1DB2F59B572D6CD223AC7D3B59DC8E");
    var_0 playLoopSound("_encstr_997D1AB107FACD5DA51B2D3256BECECACD3A7DE61BB7DDD713B22B07");
    var_2 = use_hold_think(var_0, 13, 3.5);
    var_0 stoploopsound("_encstr_997D1AB107FACD5DA51B2D3256BECECACD3A7DE61BB7DDD713B22B07");

    if(var_2 == "_encstr_88E30897BDF1B71F7823") {
      break;
    }
  }

  var_0 playLoopSound("_encstr_83FB1A360EFADCAEA536B423ACF567CA6E1DD7660BCD3AFAC42B9538");
  var_0 thread suicide_vest_timer(var_0);
  var_0 thread target_within_range_think(var_0);
  var_0 scripts\cp\utility::hint_prompt("_encstr_BE3A162C1B47B4B32C1DB2F59B572D6CD223AC7D3B59DC8E", 0);
  var_0 scripts\cp\utility::hint_prompt("_encstr_AB4A1623983BD75A03FD9701660362632038BF47F8F103C3", 1);
  var_0 waittill("_encstr_B1B21D7DD935E01E0369B9E1C3DF54684B2D87CF6D5CE86B5BE2764B3A9F0D");
  var_0 waittill("_encstr_AB4A1623983BD75A03FD9701660362632038BF47F8F103C3");
  var_0 stoploopsound("_encstr_83FB1A360EFADCAEA536B423ACF567CA6E1DD7660BCD3AFAC42B9538");
  var_0 scripts\cp\utility::hint_prompt("_encstr_AB4A1623983BD75A03FD9701660362632038BF47F8F103C3", 0);
  var_0 thread suicide_bomber_explodes(var_0, 1);
}

target_within_range_think(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");

  for(;;) {
    var_1 = get_potential_hero_players_as_target();
    var_2 = [];

    foreach(var_4 in var_1) {
      if(distancesquared(var_0.origin, var_4.origin) <= 50625)
        var_2[var_2.size] = var_4;
    }

    var_0.potential_hero_players_as_target_in_range = var_2;

    foreach(var_7 in level.players) {
      if(scripts\engine\utility::array_contains(var_0.potential_hero_players_as_target_in_range, var_7)) {
        var_7 hudoutlineenableforclient(var_0, "_encstr_865D19FAA0E11DA730459681E958B7A77B20D30289BFD2BFE8BC9D");
        continue;
      }

      var_7 hudoutlinedisableforclient(var_0);
    }

    waitframe();
  }
}

get_potential_hero_players_as_target() {
  var_0 = [];

  foreach(var_2 in level.players) {
    if(var_2.team_number == 1) {
      continue;
    }
    if(scripts\cp\cp_laststand::player_in_laststand(var_2)) {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

suicide_bomber_clean_up(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 waittill("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 stoploopsound("_encstr_997D1AB107FACD5DA51B2D3256BECECACD3A7DE61BB7DDD713B22B07");
  var_0 stoploopsound("_encstr_83FB1A360EFADCAEA536B423ACF567CA6E1DD7660BCD3AFAC42B9538");
  var_0 scripts\cp\utility::hint_prompt("_encstr_BE3A162C1B47B4B32C1DB2F59B572D6CD223AC7D3B59DC8E", 0);
  var_0 scripts\cp\utility::hint_prompt("_encstr_AB4A1623983BD75A03FD9701660362632038BF47F8F103C3", 0);

  foreach(var_2 in level.players)
  var_2 hudoutlinedisableforclient(var_0);
}

suicide_bomber_explodes(var_0, var_1) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0);
  var_0 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
  var_0 playSound("_encstr_92D8199AB81EE685CBE6F30933D7DBFBEF5888D348783912C8F9ED");
  playFX(level._effect["_encstr_88A41A5AD39BCDD97B05701673098A6FA09FF50AB7B2E9CFF3EB8AE8"], var_0.origin);
  earthquake(0.3, 1.5, var_0.origin, 150);
  do_damage_to_target_in_range(var_0);

  if(istrue(var_1))
    var_0 dodamage(var_0.health + 50, var_0.origin);
}

do_damage_to_target_in_range(var_0) {
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
    var_0 iprintlnbold("_encstr_B40703A9CB" + var_1 + "_encstr_8F2C152F6E081D1639B3B2A350E65210B6B4C636B24624");
    var_0 thread scripts\cp\cp_damagefeedback::updatedamagefeedback("_encstr_BEF30DDC48FB9D412091E803212033");
  }
}

suicide_vest_timer(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_1 = 5;
  wait(var_1);

  for(var_2 = 5; var_2 > 0; var_2--) {
    var_0 iprintlnbold("_encstr_BA8F1F35EAB46CD2192B103B599B1D40AC0F1C36DE8C96B99D044B3701B871C580" + var_2);
    wait 1;
  }

  var_0 thread suicide_bomber_explodes(var_0, 1);
}

super_hold_think(var_0, var_1, var_2) {
  var_3 = 0;
  var_0 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", var_1);
  var_0 notifyonplayercommand("_encstr_8B1D0B8360C03542BFEDB17D56", "_encstr_BA4B07AD67E85D273D");
  var_0 notifyonplayercommand("_encstr_851D0BB293396320A3AAD1F950", "_encstr_AC5C06364D466A1F");

  for(;;) {
    var_4 = var_0 scripts\engine\utility::waittill_any_in_array_or_timeout(["_encstr_8B1D0B8360C03542BFEDB17D56", "_encstr_851D0BB293396320A3AAD1F950"], 0.05);

    if(var_4 == "_encstr_995408F398012F656821") {
      var_3 = var_3 + 0.05;
      var_0 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", var_3 / var_2);

      if(var_3 >= var_2) {
        var_0 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 1);
        var_0 thread delay_hide_progress_widget(var_0);
        return "_encstr_88E30897BDF1B71F7823";
      }
    } else {
      var_0 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0);
      var_0 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
      return "_encstr_BD79059C51C351";
    }
  }
}

delay_hide_progress_widget(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  waitframe();
  var_0 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
}

use_hold_think(var_0, var_1, var_2) {
  var_3 = 0;
  var_0 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", var_1);

  for(;;) {
    waitframe();

    if(var_0 useButtonPressed()) {
      var_3 = var_3 + 0.05;
      var_0 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", var_3 / var_2);

      if(var_3 >= var_2) {
        var_0 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 1);
        var_0 thread delay_hide_progress_widget(var_0);
        return "_encstr_88E30897BDF1B71F7823";
      }
    } else {
      var_0 setclientomnvar("_encstr_AAB915BA96D76EB2C6EA9C2D3776EBC19CBD3BE4566ECD", 0);
      var_0 setclientomnvar("_encstr_83370CD0DF271BBB5A3B66E3D532", 0);
      return "_encstr_BD79059C51C351";
    }
  }
}

give_armor_loadout(var_0) {
  var_1 = scripts\cp\cp_weapon::buildweapon("_encstr_A1AF15733C88381B0A0E8743929044085DAF9A1DBF905B", [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
  var_0 giveweapon(var_1);
  var_0 setweaponammoclip(var_1, weaponclipsize(var_1));
  var_0 setweaponammostock(var_1, weaponmaxammo(var_1));
  var_1 = scripts\cp\cp_weapon::buildweapon("_encstr_86F5155AEE83F55B56D7E4D2ED8EE6D0B4AC36C8F55BC1", [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
  var_0 giveweapon(var_1);
  var_0 switchtoweaponimmediate(var_1);
}

give_long_range_loadout(var_0) {
  var_1 = scripts\cp\cp_weapon::buildweapon("_encstr_8F091280BBC06FBB63BF57D988A321732AC128D0", ["_encstr_885E09D8B0B959E4C219B9"], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
  var_0 giveweapon(var_1);
  var_0 setweaponammoclip(var_1, weaponclipsize(var_1));
  var_0 setweaponammostock(var_1, weaponmaxammo(var_1));
  var_0 switchtoweaponimmediate(var_1);
  var_0 thread long_range_laser_ent_think(var_0);
  var_0 thread long_range_laser_vfx_think(var_0);
}

long_range_laser_ent_think(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0 gettagorigin("_encstr_A1190BD4FABB9396DC47EB8DAC"));
  var_1 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_1 linkTo(var_0, "_encstr_A1190BD4FABB9396DC47EB8DAC");
  var_1 thread laser_ent_clean_up_monitor(var_1, var_0);
  var_0.laser_start_ent = var_1;
  var_2 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0 gettagorigin("_encstr_A130084D2FDAD8AA8F62"));
  var_2 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_2 thread laser_ent_clean_up_monitor(var_2, var_0);
  var_0.laser_end_ent = var_2;
  var_3 = physics_createcontents(["_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_990C1A3886E537A5B1CD1BBDB98EACB91DCDFA85D2CDDE9BA5EC1A8E"]);

  for(;;) {
    var_4 = var_0 gettagorigin("_encstr_A130084D2FDAD8AA8F62");
    var_5 = anglesToForward(var_0 getplayerangles());
    var_6 = var_4 + var_5 * 20000;
    var_7 = scripts\engine\trace::ray_trace(var_4, var_6, undefined, var_3)["_encstr_BD260953AA97E3F014279D"];
    var_2 moveTo(var_7, 0.1);
    waitframe();
  }
}

long_range_laser_vfx_think(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 notifyonplayercommand("_encstr_976F1563EDB93BAF3985CDEC59EBB93A8539E87D0A2235", "_encstr_97120D65B983599519EB1D86C9B7EE");

  for(;;) {
    var_0 waittill("_encstr_976F1563EDB93BAF3985CDEC59EBB93A8539E87D0A2235");
    var_1 = playfxontagsbetweenclients(level._effect["_encstr_B43424AB1849FFDF1020FEEFD03BEFC59F68C16338E572678B1BEBF4C803A70F47B8AAAB50BD"], var_0.laser_start_ent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37", var_0.laser_end_ent, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    wait 0.5;

    while(var_0 adsButtonPressed())
      waitframe();

    var_1 delete();
  }
}

laser_ent_clean_up_monitor(var_0, var_1) {
  var_1 scripts\engine\utility::_id_143A5("_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_8CBE0BD1BED30936AB03C0B02B");
  var_0 delete();
}

give_default_terrorist_loadout(var_0) {
  var_1 = scripts\cp\cp_weapon::buildweapon("_encstr_B8B7134BEE70EB0ED2FA5BB4D69526721398D7AD07", [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
  var_0 giveweapon(var_1);
  var_0 switchtoweapon(var_1);
}

precache_pvpe_vfx() {
  level._effect["_encstr_BAE4166FCB539BA63BD75818A754B9C10932E77F634A53CB"] = loadfx("_encstr_96422B9B67C9D0E0DB7FC13E38552BF4BA7F60502B70CDE581D6F03950B06BFF0189E37230E3FE22836DF3ECE0");
  level._effect["_encstr_8CD1140E3BE0B2D79BAC582713CBFAE61C58DD9B9527"] = loadfx("_encstr_8B7229FBAF40428B33AAEF9FA39E4CB0E849AD91528BD83EE98B83A3B3B213319B1A09ABFDED38D89383B1");
  level._effect["_encstr_BEEF12E87518C7DF1560E26AEA606FBE60D77552"] = loadfx("_encstr_8C972067333CF25ABB83D7C6E0E59D99F0FA6BC2E4D62B27BECACD595B2FE267661E");
  level._effect["_encstr_8EAD15D94E2A1880B30330B9EA93C12009BD0355CBD7E8"] = loadfx("_encstr_915223F316CB5014BFA239F7E01E2ECA3919818FE3CA414ECF818062C3500528FB652ED0D2");
  level._effect["_encstr_B43424AB1849FFDF1020FEEFD03BEFC59F68C16338E572678B1BEBF4C803A70F47B8AAAB50BD"] = loadfx("_encstr_8F3E208B0322DE5A982B4FB31305CBB5D9F0C3BF7D4FB1835F5FDED9D387C0230388");
  level._effect["_encstr_88A41A5AD39BCDD97B05701673098A6FA09FF50AB7B2E9CFF3EB8AE8"] = loadfx("_encstr_87D9371B6633A0CF54C80F675A72176FDFDAF8A2E4D7AE607B785692D55ACF3B55CB61FA130BF127A613B3400E72A4F101996051BA96339EC2");
}

delay_start_gun_game(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 waittill("_encstr_B4C40E582257FDB09BB4077FC103B8B0");
  var_1 = get_player_gun_game_level(var_0);
  gun_game_change_to_weapon_at_level(var_0, var_1);
}

gun_game_change_to_weapon_at_level(var_0, var_1) {
  if(!isDefined(level.max_gun_game_level))
    determine_max_gun_game_level();

  if(var_1 > level.max_gun_game_level) {
    return;
  }
  if(!holding_gun_game_max_level_weapon(var_0)) {
    remove_all_primaries_weapon(var_0);
    var_2 = get_gun_game_weapon_at_level(var_1);
    var_3 = scripts\cp\cp_weapon::buildweapon(var_2, [], "_encstr_8BBA05185F8B99", "_encstr_8BBA05185F8B99", -1);
    var_0 giveweapon(var_3);
    var_0 switchtoweapon(var_3);
  }
}

remove_all_primaries_weapon(var_0) {
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1)
  var_0 takeweapon(var_3);
}

holding_gun_game_max_level_weapon(var_0) {
  var_1 = var_0 getweaponslistprimaries();

  foreach(var_3 in var_1) {
    if(var_3.basename == level.max_gun_game_weapon_name)
      return 1;
  }

  return 0;
}

get_gun_game_weapon_at_level(var_0) {
  var_1 = tablelookup("_encstr_9AB726B1075E8DC1BE3BAEDCFAD916DA95AFBBCAB0837BCDBE0727DED94EACE6CDA5F673171BB9EC", 0, var_0, 2);
  return var_1;
}

determine_max_gun_game_level() {
  level.max_gun_game_level = 0;
  level.max_gun_game_weapon_name = undefined;

  for(var_0 = 1; var_0 <= 100; var_0++) {
    var_1 = tablelookup("_encstr_9AB726B1075E8DC1BE3BAEDCFAD916DA95AFBBCAB0837BCDBE0727DED94EACE6CDA5F673171BB9EC", 0, var_0, 2);

    if(var_1 == "_encstr_B40101") {
      break;
    }

    level.max_gun_game_level++;
    level.max_gun_game_weapon_name = var_1;
  }
}

increase_player_gun_game_level(var_0) {
  if(!isDefined(level.max_gun_game_level))
    determine_max_gun_game_level();

  if(!isDefined(level.players_gun_game_level))
    level.players_gun_game_level = [];

  var_1 = var_0.name;

  if(!isDefined(level.players_gun_game_level[var_1]))
    level.players_gun_game_level[var_1] = 1;

  var_2 = level.players_gun_game_level[var_1];

  if(var_2 >= level.max_gun_game_level) {
    return;
  }
  level.players_gun_game_level[var_1]++;
}

get_player_gun_game_level(var_0) {
  if(!isDefined(level.players_gun_game_level))
    level.players_gun_game_level = [];

  var_1 = var_0.name;

  if(!isDefined(level.players_gun_game_level[var_1]))
    level.players_gun_game_level[var_1] = 1;

  return level.players_gun_game_level[var_1];
}

pvpe_terrorist_players_respawn_timer() {
  level endon("_encstr_AF100EBFFE4B212FCF7A8051C2E61379");
  level notify("_encstr_9BF72538B31C597D472BC939ED27B4CD8EF507B116CBCA939BBE9C5637380BDDCDEB8E96DA5627");
  level endon("_encstr_9BF72538B31C597D472BC939ED27B4CD8EF507B116CBCA939BBE9C5637380BDDCDEB8E96DA5627");

  for(;;) {
    var_0 = gettime() + 25000;
    setomnvar("_encstr_BDBA0E36077D77C26795EB1D2DADB293", var_0);

    for(var_1 = 25; var_1 >= 0; var_1--) {
      level notify("_encstr_88E7236392AB23976BAB62200FAB527FA3C0D0EEE62007F35A6A0B2B865C897DC7234703E3", var_1);
      wait 1;
    }

    level notify("_encstr_8E281D149DA02ABEB2E6566BE57DA052D76ED1C293A3D7E638C2BB9B4BCD3B");
  }
}

change_to_terrorist_archetype_selected(var_0) {
  remove_all_primaries_weapon(var_0);
  remove_all_powers(var_0);

  switch (var_0.terrorist_archetype_selected) {
    case 0:
      var_0 kidnapper(var_0);
      break;
    case 1:
      var_0 riot_shield(var_0);
      break;
    case 2:
      var_0 sniper(var_0);
      break;
    case 3:
      var_0 scripts\cp\cp_juggernaut::jugg_makejuggernaut(jugg_createconfig());
      break;
    default:
      var_0 suicide_bomber(var_0);
      break;
  }
}

player_is_kidnapper(var_0) {
  return isDefined(var_0.terrorist_archetype_selected) && var_0.terrorist_archetype_selected == 0;
}

kidnapper(var_0) {
  change_to_terrorist_model_internal(var_0, "_encstr_A3FE1ABAF0D9822940E018E2316A4B5F6318014BE24BF7A88EFFF7CA", "_encstr_818E1934952C91F5AD1CF52BB037E8ACE437EB58D3D593BE98F598");
  give_kidnapper_loadout(var_0);
}

suicide_bomber(var_0) {
  change_to_terrorist_model_internal(var_0, "_encstr_8F511913F6C8F2BED61CEB950BDC8E59E49BEB2C3DAB4EAF99BEC4", "_encstr_868E1960B74191A7C212A84DAEDB0979BA035190630D2BEF0FF197");
  give_suicide_bomber_loadout(var_0);
}

riot_shield(var_0) {
  change_to_terrorist_model_internal(var_0, "_encstr_8CC31913B719F2D7AD83D75958DCD15639CD7D8916B1ACF54CEB26", "_encstr_B8B019842591CC89F8F0CF528330BCC95A3AF77BD8C1EA7979216F");
  give_armor_loadout(var_0);
}

sniper(var_0) {
  change_to_terrorist_model_internal(var_0, "_encstr_8C5E2231DEC8BCD7AD1CD756B09BA3B2C937EBAD9C95AEB395397D26D798AF342C3BF6DA", "_encstr_959D1CD3BBDF2A370853811769A044722ED587473D75E3C7A03B890AC69A");
  give_long_range_loadout(var_0);
}

jugg_createconfig(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.maxhealth = 3000;
  var_2.startinghealth = var_2.maxhealth;
  var_2.movespeedscalar = -0.2;
  var_2.forcetostand = 1;
  var_2.suit = "_encstr_934212925C82495C700FDF7F3A22E3AB1B11EAC7";
  var_2.clothtype = "_encstr_A96C0A3BAF8B58CB528FFDEB";
  var_2.infiniteammo = 1;
  var_2.infiniteammoupdaterate = undefined;
  var_2.classstruct = scripts\cp\cp_juggernaut::jugg_getdefaultclassstruct();
  var_2.allows = [];
  var_2.allows["_encstr_83290B682399813F110463F9DD"] = 1;
  var_2.allows["_encstr_A9350D834DDE8871B8C7AD38FF21E2"] = 1;
  var_2.allows["_encstr_A19315D78019CFB47BA36942A0592FFFB674295325204F"] = 1;
  var_2.allows["_encstr_8E400866D8589B1AB2C8"] = 1;
  var_2.allows["_encstr_8ED90887F39B73AD5BFF"] = 1;
  var_2.allows["_encstr_922406F1A6FD5E05"] = 1;
  var_2.allows["_encstr_BE8F0A272F9B2BE97268AE8B"] = 1;
  var_2.allows["_encstr_9BE40A0BC09BCEF7C0F33441"] = 1;
  var_2.allows["_encstr_BEF4071AA87BDF5220"] = 1;
  var_2.allows["_encstr_85190CAB8B3971B0A4DB2BCAC253"] = 1;
  var_2.allows["_encstr_BD6B06A64C87A9E3"] = 1;
  var_2.allows["_encstr_AF4D07932B1BDE5846"] = 1;
  var_2.allows["_encstr_A1AF107FB41FA3596A69773FD20858C85627"] = 1;
  var_2.allows["_encstr_914C0EDDB20B837BB97D38D2365BAB83"] = 1;
  var_2.allows["_encstr_B24E11E8C140668309413A234F0BE9176B9185"] = 0;
  var_2.perks = [];
  return var_2;
}

change_to_terrorist_model(var_0) {
  change_to_terrorist_model_internal(var_0, "_encstr_AB0C1998B7C8CBF5B50EAFAC2C9B8ECA3973EBE9C237CABEC4EB26", "_encstr_AC7D1930E711E1D7B242F8FD1E0BD9896AB301385FA6191F9FA1C7");
}

change_to_terrorist_model_internal(var_0, var_1, var_2, var_3) {
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

  if(isDefined(var_3))
    var_0 setviewmodel(var_3);
}

pvpe_round_timer() {
  level endon("_encstr_AF100EBFFE4B212FCF7A8051C2E61379");
  var_0 = 1;
  wait 5;
  setomnvar("_encstr_A9300F0658510B75782FF718FB0392EECD", 1);
  var_1 = gettime() + 420000;
  setomnvar("_encstr_B8A90F6F6B5996C8CD254926CB89804523", var_1);
  var_2 = 360;
  wait(var_2 - var_0);
  iprintlnbold("_encstr_A1021389025B96CDBAE8B2104EB2B5B05A732D373B");
  wait 30;
  iprintlnbold("_encstr_99A515CC1840B9CA36DB378CB901C995B685A5DCA5733B");
  wait(20 + var_0);

  if(game["_encstr_A6040D589883D39DFF28D387B14AE5"] == 1) {
    for(var_3 = 10; var_3 > 0; var_3--) {
      iprintlnbold("_encstr_B8DA172377A03396B14B38228677C861B76737C860359E4551" + var_3);
      wait 1;
    }
  } else {
    for(var_3 = 10; var_3 > 0; var_3--) {
      iprintlnbold("_encstr_8BFE15B0495DE77472B3EEEC43E87F320BCDDE0E3818A2" + var_3);
      wait 1;
    }
  }

  level thread[[level.endgame]](get_winning_team_name(), level.end_game_string_index["_encstr_91190447C232"]);
}

set_score_fraction_to_hero_team(var_0) {
  var_0 = int(var_0 * 100);
  var_0 = clamp(var_0 / 100, 0, 1);

  if(game["_encstr_A6040D589883D39DFF28D387B14AE5"] == 1) {
    game["_encstr_AB812383481D13B74967AEAD6F98BF3B48E65B7A11F91FAA907FCAB5573082BFE6FB024218"] = var_0;
    set_team_score_for_players("_encstr_B25B1BA09B99D3CFF30D279F401608DFD710B138103280894B37DFDAAD", var_0);
  } else if(game["_encstr_A6040D589883D39DFF28D387B14AE5"] == 2) {
    game["_encstr_856A23FBA0334D4326FDB7D7AFA80F125F89230248EBC9C79968BAD538B1AB1EEFA87A3AD8"] = var_0;
    set_team_score_for_players("_encstr_A3B81B06D321AC827F13BF7E0F94BBF198FB3C8D88384CF94E27777B53", var_0);

    if(game_should_end_early())
      level thread[[level.endgame]](get_winning_team_name(), level.end_game_string_index["_encstr_91190447C232"]);
  }
}

give_score_to_hero_team() {
  foreach(var_1 in level.players) {
    if(var_1.team_number == 0) {
      var_1 iprintlnbold("_encstr_92E7230E4A91B075F35A0923772A17E117341123561588AE4A5711B1B7C28D5A084D9818EB");
      continue;
    }

    var_1 iprintlnbold("_encstr_8FE124117A7B757F4863F8A4759107AE2532FA7AC0096FA743C085ACBF78C30701A0F272B049");
  }

  if(game["_encstr_A6040D589883D39DFF28D387B14AE5"] == 1) {
    game["_encstr_8F7C1ACE2DA32D61B75FA8F8B7A8194D6A5945DD069A874B734770E0"]++;
    game["_encstr_AB812383481D13B74967AEAD6F98BF3B48E65B7A11F91FAA907FCAB5573082BFE6FB024218"] = 0;
    set_team_score_for_players("_encstr_AD0E1057E059283507AA9E6B9197FE38AA4D", game["_encstr_8F7C1ACE2DA32D61B75FA8F8B7A8194D6A5945DD069A874B734770E0"]);
    set_team_score_for_players("_encstr_B25B1BA09B99D3CFF30D279F401608DFD710B138103280894B37DFDAAD", 0);
  } else if(game["_encstr_A6040D589883D39DFF28D387B14AE5"] == 2) {
    game["_encstr_829F1ACB5DFDF8BD614B4F77CF3A75408F3973A1465DB9EE5A3F7D7B"]++;
    game["_encstr_856A23FBA0334D4326FDB7D7AFA80F125F89230248EBC9C79968BAD538B1AB1EEFA87A3AD8"] = 0;
    set_team_score_for_players("_encstr_BAA910196A27D8CD923F2FFBDF9B06B8A287", game["_encstr_829F1ACB5DFDF8BD614B4F77CF3A75408F3973A1465DB9EE5A3F7D7B"]);
    set_team_score_for_players("_encstr_A3B81B06D321AC827F13BF7E0F94BBF198FB3C8D88384CF94E27777B53", 0);

    if(game_should_end_early())
      level thread[[level.endgame]](get_winning_team_name(), level.end_game_string_index["_encstr_91190447C232"]);
  }
}

get_winning_team_name() {
  var_0 = game["_encstr_8F7C1ACE2DA32D61B75FA8F8B7A8194D6A5945DD069A874B734770E0"] + game["_encstr_AB812383481D13B74967AEAD6F98BF3B48E65B7A11F91FAA907FCAB5573082BFE6FB024218"];
  var_1 = game["_encstr_829F1ACB5DFDF8BD614B4F77CF3A75408F3973A1465DB9EE5A3F7D7B"] + game["_encstr_856A23FBA0334D4326FDB7D7AFA80F125F89230248EBC9C79968BAD538B1AB1EEFA87A3AD8"];

  if(var_0 == var_1)
    return "_encstr_8D19048EA595";
  else if(var_0 > var_1)
    return "_encstr_8E8405EA382B2A";
  else
    return "_encstr_9A8507BA4040188D08";
}

game_should_end_early() {
  var_0 = game["_encstr_8F7C1ACE2DA32D61B75FA8F8B7A8194D6A5945DD069A874B734770E0"] + game["_encstr_AB812383481D13B74967AEAD6F98BF3B48E65B7A11F91FAA907FCAB5573082BFE6FB024218"];
  var_1 = game["_encstr_829F1ACB5DFDF8BD614B4F77CF3A75408F3973A1465DB9EE5A3F7D7B"] + game["_encstr_856A23FBA0334D4326FDB7D7AFA80F125F89230248EBC9C79968BAD538B1AB1EEFA87A3AD8"];
  return var_1 > var_0;
}

set_team_score_for_players(var_0, var_1) {
  foreach(var_3 in level.players)
  var_3 setclientomnvar(var_0, var_1);
}

terrorist_enter_laststand(var_0, var_1) {
  if(player_is_suicide_bomber(var_0))
    var_0 thread suicide_bomber_explodes(var_0, 0);

  if(should_do_ragdoll(var_0))
    do_terrorist_ragdoll(var_0);

  var_0 playerhide();
  var_0 disableweapons();
  var_0 allowmovement(0);
  var_0 allowjump(0);
  var_0.waiting_to_spawn = 1;
  var_0.terrorist_overlay destroy();
  enter_ragdoll_focus_camera(var_0, var_1);
  wait 2;
  var_0 thread terrorists_respawn(var_0, get_closest_respawner_on_direction(var_0.origin, undefined), scripts\engine\utility::getStructArray("_encstr_9376192017F233A75334DE65814B9919518F980123BDAB518A5B58", "_encstr_B2CE0BA1D0FB19FDC54613D9BF"), 1);
}

should_do_ragdoll(var_0) {
  if(player_is_suicide_bomber(var_0))
    return 1;

  return 1;
}

player_is_suicide_bomber(var_0) {
  return isDefined(var_0.terrorist_archetype_selected) && var_0.terrorist_archetype_selected == 0;
}

enter_ragdoll_focus_camera(var_0, var_1) {
  var_2 = 250;
  var_3 = 45;

  if(!isPlayer(var_1))
    var_1 = get_fake_attacker_struct(var_0);

  var_4 = vectorNormalize(var_0.origin - var_1.origin);
  var_4 = (var_4[0], var_4[1], 0);
  var_5 = var_0 getEye();
  var_6 = var_5 + var_4 * var_2 + (0, 0, 1) * var_3;
  var_7 = physics_createcontents(["_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_990C1A3886E537A5B1CD1BBDB98EACB91DCDFA85D2CDDE9BA5EC1A8E"]);
  var_8 = scripts\engine\trace::ray_trace(var_5, var_6, var_0, var_7)["_encstr_BD260953AA97E3F014279D"];
  var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_8);
  var_9 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_9.angles = vectortoangles(var_1.origin - var_8);
  var_9 thread ragdoll_focus_camera_clean_up_monitor(var_9, var_0);
  var_0 cameralinkTo(var_9, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_0.ragdoll_focus_camera = var_9;
}

get_fake_attacker_struct(var_0) {
  var_1 = 180;
  var_2 = spawnStruct();
  var_3 = anglesToForward(var_0 getplayerangles());
  var_4 = var_0 gettagorigin("_encstr_A130084D2FDAD8AA8F62");
  var_2.origin = var_4 + var_3 * var_1;
  return var_2;
}

ragdoll_focus_camera_clean_up_monitor(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 delete();
}

exit_ragdoll_focus_camera(var_0) {
  var_0 cameraunlink();

  if(isDefined(var_0.ragdoll_focus_camera))
    var_0.ragdoll_focus_camera delete();
}

do_terrorist_ragdoll(var_0) {
  var_1 = var_0 cloneplayer(0);
  var_1 startragdoll();
}

pvpe_allow_players_to_restart(var_0) {
  if(var_0 == 4)
    return 0;

  return 1;
}

pvpe_player_connect_monitor() {
  level notify("_encstr_A38E1CC3830845F1538DAFD0530A87AEF8D8D5874263B6AD27AB0C339043");
  level endon("_encstr_A38E1CC3830845F1538DAFD0530A87AEF8D8D5874263B6AD27AB0C339043");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_AF100EBFFE4B212FCF7A8051C2E61379");

  for(;;) {
    level waittill("_encstr_AA940A6CB7DC9B2B6C3ACA91", var_0);
    var_0 thread terrorist_player_initial_spawn_select(var_0);
  }
}

terrorist_player_initial_spawn_select(var_0) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 waittill("_encstr_B4C40E582257FDB09BB4077FC103B8B0");
  waitframe();

  if(player_is_terrorist(var_0)) {
    var_0.terrorist_archetype_selected = var_0.slot_number;

    if(var_0.terrorist_archetype_selected > 2)
      var_0.terrorist_archetype_selected = randomint(3);

    var_0 change_to_terrorist_archetype_selected(var_0);
  }
}

setup_play_test_name_to_team_id_mapping() {
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"] = [];
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_8183089830E36FFFC686")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_8DAF0B94ABD40AC6B4692D367B")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_A6C70B52EA35A0D89631A5B60B")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_91BD0BA4AE53411BD253B4AD59")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_83BC0F01ECEC03B36341DA4330CB9E6FA3")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_84EC0C80FFB15B934AB7435B83D8")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_87DF0B947535418D5A142C1CC2")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_B2030DD1F76BFB3ED2D305A8F22F4A")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_93CD0C8B4F459114BE211058BA5F")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_BDF50DE897D9C30BE237F1C54D20E6")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_A94A0C94BA5328D8692AC2E69DDE")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_92C408D00A7DB45A1BDE")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_B2FB081E1161783F60E3")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_83F408CE379FF0414018")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_824D0CCF611058D7B301FD063918")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_8AC70A3BD981AD4F36A1B38F")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_B49A0868A0F50AC20E2C")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_9ABA0B4D3277A19562B38B8F96")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_A66A097169B9D598CFE530")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_8AC00A4D3A77B19B62F3A58B")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_868209B08F28DBD6E057CF")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_8AEF0C94BA9A05D8FAA5D236ED4C")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_A21D0C94EAA982B1BE9896B60B26")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_B2C30C998F9DC7A531ED031AFF8F")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_8BEB1064E9C9EF9F710BAD45033538FBB87B")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_AF560D9357AD79EC8F188BB1C20327")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_B4C40CFCA1E7E77A11907B51C9D2")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_814F0E59373FE7824727CB6DF61FFF12")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_8E8B0D1F97913106D16FC54DA178C9")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_B1B10E23E7FD29BCDFA9B821A3B3DFEA")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_BDC10D29AB53A063FA45B0CD3B7B26")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_B2AF0A96371AD5DCF5550D39")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_84850C13B98DC653482962EDC0C8")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_83040A0914A94B099CC2D9F6")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_BAE40A7642070B6524837838")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_A23C0A5662272B4406F31058")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_85D40B8A31F799996B44235DE3")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_97BD092105A94B2D5AB1DB")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_A9D909962F63DE5C3870A7")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_A9CF092105A6B49AD2DAB2")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_868C0D316315B885E293B5496EBA05")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_86160C7C2F50836322AB97C69F0A")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_9A8B0D255D9A054D966AA52B39E4B0")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_A7DF0C1C045D77BE9DEAF80345FF")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_ADBB0DF1FFF970B51599A33982A25F")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_B2A90BA48793E17E1B5B61E7A8")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_9BBB0C21C7017AA6E194B3BAB9A6")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_A6D10F78373DF157262117B023CF5E9DEB")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_8D140BF1C9ED61637E9D636A8D")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_A70D0BB4BF3C574350C370691E")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_BAE30B2975531453B45A96D8BD")] = 0;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_BE5E0D73079DBA470D8DF3D17308F5")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_957D0C094F8FAA7F5214DB99A742")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_B6690C29EA3528C6D2847B4795D8")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_AB8C0BD0AFE10BC33AD70F04BD")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_85680E486143C20A68E4AFC095EB2793")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_837B0BA94F89F232795DCA82E0")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_A2FD0C780749B37B92896D7CF128")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_B4A70E09B9DC1F7C06DE9BE22219987A")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_8A520C946B8D41DC1EDB3D233302")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_ADB50C4B8708F752C5BE78F31C71")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_ACDB0A34417D4957634B5947")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_8C06093BD9812C3BB5A082")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_85310949130F4497036701")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_912408E9F1217710B36E")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_AD4C0B3482AFC8DB878EE4B7D1")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_8E36089740D921B6A30A")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_8F3609A7B29FE92F205B4F")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_8BF90BED2F514FB0F9587B31C2")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_8FF70A77F996C2A34BB44DD2")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_B4290977A7C9B6F9F20B03")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_93840E25EA358263AF29AE8DA5598E26")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_AD650DE914E0019FFF514E01BB9BFA")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_A9410D4ABA6A826C7D12BD1D563613")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_AAF30C4F019749C3EF3FF841588B")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_9B1F0F235478CF13BE035F9A219A6F3CB2")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_8BC10C29CF0972B2C0DD4A02600F")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_93060DEB2F25F1741720F1D80BC7AF")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_84BB0F91A98D412397B3C34F7AA330E37A")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_A6860D106F21CB03691DD2C95DC08A")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_8B9C0D9F011490A7776FCDC2D333EF")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_9210092E97AB168DA19067")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_ABC90C240A4D6964DEF03AC9BD1D")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_92220921414DB4D1DE8D66")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_8B0F0A4814A969247B47568D")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_BE150A1282A65AA79B36C29C")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_9B74093B91B5FE7828134E")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_974B0B604FDDFE1AF893020DB7")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_845F0A653A055A1ECAF7838F")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_A1B90BD0AB0B0629103948B5E6")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_B4FB0A8DD2FDA2E5C2632F37")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_99840C25D5D441A9A550B1E01A85")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_AA4D0C495454BBBBABF9C3CA6017")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_A9EC0E5C2C78F77D9D7EC9F3DADC40AD")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_8ECD0CC0F113FFAE15E913119B3B")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_875A0B5C014747C22D259F8127")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_B1AD0E97D1D981DEED3147593815E899")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_83480B52EA9A826A69D1B76399")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_8DA50CA475A682535A84B7E895D8")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_92D40C0BCFC511153E10B0F9FAE7")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_83030D25D56A14D44B94D5C6B4B21D")] = 1;
  game["_encstr_8ABD183A29BB4BD8604041B4CD5A323F81BBE7E5393B7FA2F0E7"][tolower("_encstr_8D9E1025D5F52985DAB237BE0D0D2BB9FA64")] = 1;
}