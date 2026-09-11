/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58336.gsc
***********************************************/

function claymore_crate_use(var_0, var_1) {
  if(claymore_crate_spawn(var_1)) {
    clean_up_vandalize(var_1);

    if(!circlesettingsassert(var_0, var_1)) {
      clean_up_strafe(var_1);
    }
  }

  if(clean_up_minigun(var_0)) {
    claymore_stunned(var_0, var_1, 0);
    return;
  }
}

function cleanuparenamolotovs(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141df(var_0, var_2);
  var_5 = claymore_crate_player_at_max_ammo(var_0, var_1);
  cleanup_target_stats_thermal(var_0, var_1, var_3);
  claymore_blockdamageuntilframeend(var_1);

  if(var_4) {
    if(!var_5) {
      clean_up_steam_triggers(var_0);
      cleanup_trap_room(var_0, var_1);
    }

    if(clean_up_minigun(var_0)) {
      claymore_load_spawning(var_0);
    }

    if(!classify_players_based_on_laststand(var_0)) {
      thread cleanup_loot_pickups(var_1, var_1);
      return;
    }

    return;
  }
}

function claymore_forceclampangles(var_0, var_1, var_2) {
  clean_up_search(var_0.cleanuplinkent, var_1, 0);
  cleanup_target_stats_thermal(var_0, var_1, var_2);
  claymore_blockdamageuntilframeend(var_1);
  var_3 = claymore_crate_player_at_max_ammo(var_0, var_1);

  if(var_3) {
    clean_up_steam_triggers(var_0);
    circleposattime(var_0);
    return;
  }
}

function claymore_crate_update_hint_logic_alt(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");

  for(;;) {
    cleanup_target_stats(var_0);
    wait 0.5;
  }
}

function cleanup_trap_room(var_0, var_1) {
  var_0.cleanupkeybindings = [];
  var_0.cleanuppropcontrolshud = var_1;
  var_0.cleanuplinkent = "";

  if(clean_up_eliminate_drone(var_0, var_1)) {
    cleanup_triggers(var_0, var_1, 1, 9);
  } else {
    cleanup_triggers(var_0, var_1, 0, 9);
  }

  var_0.cleanupkeybindings = scripts\engine\utility::array_randomize(var_0.cleanupkeybindings);
}

function cleanup_triggers(var_0, var_1, var_2, var_3) {
  for(var_4 = var_2; var_4 <= var_3; var_4++) {
    var_5 = civcontroller(var_0, var_1, var_4);

    if(isDefined(var_5) && var_5 > 1) {
      var_6 = circuitbreakerswitchesinit(var_5);

      if(var_6 != "") {
        var_0.cleanupkeybindings = scripts\engine\utility::array_add(var_0.cleanupkeybindings, var_6);
        clean_up_ents(var_0, var_5);
      }
    }
  }
}

function clean_up_ents(var_0, var_1) {
  var_2 = circletestaroundplayer(var_1);

  if(var_0.cleanuplinkent == "") {
    var_0.cleanuplinkent = var_2;
    return;
  }
}

function clean_up_eliminate_drone(var_0, var_1) {
  var_2 = civcontroller(var_0, var_1, 0);
  return isDefined(var_2) && var_2 == 1;
}

function civcontroller(var_0, var_1, var_2) {
  var_3 = circletimestruct(var_0);

  if(isDefined(var_3)) {
    var_4 = var_1 getplayerdata(level.loadoutsgroup, "customizationSetup", "vehicleCustomization", var_3, "tracks", var_2);
    return var_4;
  }

  return undefined;
}

function circuitbreakerswitchesinit(var_0) {
  var_1 = tablelookup("mp_cp/vehicletracks.csv", 0, var_0, 7);
  return var_1;
}

function circletestaroundplayer(var_0) {
  var_1 = tablelookup("mp_cp/vehicletracks.csv", 0, var_0, 8);
  return var_1;
}

function claymore_load_spawning(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0, 1);

  foreach(var_3 in var_1) {
    claymore_stunned(var_0, var_3, 0);
  }
}

function clean_up_steam_triggers(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0, 1);

  foreach(var_3 in var_1) {
    clean_up_search(var_0.cleanuplinkent, var_3, 0);
  }
}

function claymore_stunned(var_0, var_1, var_2) {
  var_3 = claymore_crate_player_at_max_ammo(var_0, var_1);

  if(isDefined(var_0.cleanuplinkent) && isDefined(var_0.cleanupkeybindings) && isDefined(var_1)) {
    if(isDefined(var_0.cleanuppropcontrolshud) && (var_3 || var_2 || var_1 finishzeroarrival())) {
      var_4 = circlesetup(var_0);

      if(!civilians_killed_stat_row(var_0, var_1, var_4)) {
        var_1.cleanuplinkent = var_0.cleanuplinkent;
        var_1.cleanupkeybindingsondeath = var_4;
        var_1 setplayermusicstate(var_0.cleanuplinkent, var_0.cleanupkeybindings);
      }
    }

    if(!var_3 && !var_2) {
      thread clampstepbulletdamage(var_1, var_1);
      return;
    }

    return;
  }
}

function civilians_killed_stat_row(var_0, var_1, var_2) {
  if(!isDefined(var_1.cleanuplinkent)) {
    return false;
  }

  if(!isDefined(var_1.cleanupkeybindingsondeath)) {
    return false;
  }

  return var_1.cleanuplinkent == var_0.cleanuplinkent && var_1.cleanupkeybindingsondeath == var_2;
}

function clean_up_search(var_0, var_1, var_2) {
  if(claymore_crate_spawn(var_1)) {
    if(isDefined(var_0) && isDefined(var_1)) {
      var_1.cleanuplinkent = undefined;
      var_1.cleanupkeybindingsondeath = undefined;
      var_1 clearoverridearchetype_code(var_0);

      if(!var_2) {
        var_1 notify("stop_battle_tracks_option_watch");
        return;
      }

      return;
    }

    return;
  }
}

function claymore_crate_spawn(var_0) {
  return isDefined(var_0.cleanuplinkent) && isDefined(var_0.cleanupkeybindingsondeath);
}

function claymore_crate_player_at_max_ammo(var_0, var_1) {
  return isDefined(var_0.cleanuppropcontrolshud) && var_0.cleanuppropcontrolshud == var_1;
}

function circleposattime(var_0) {
  var_0.cleanuppropcontrolshud = undefined;
  var_0.cleanupkeybindings = undefined;
  var_0.cleanuplinkent = undefined;
}

function classify_players_based_on_laststand(var_0) {
  if(!isDefined(var_0.cleanupkeybindings)) {
    return true;
  }

  if(var_0.cleanupkeybindings.size == 0) {
    return true;
  }

  return false;
}

function cleanup_loot_pickups(var_0, var_1) {
  var_0 notify("stop_battle_tracks_toggle_think");
  var_0 endon("stop_battle_tracks_toggle_think");
  var_0 endon("death_or_disconnect");
  var_0 endon("last_stand_start");
  cleanup_spawned_exposed_node(var_0);
  var_2 = civ_thread(var_0);
  cleanupallbutxcratesforteam(var_0, var_1, var_2);

  if(var_0 scripts\engine\utility::is_player_gamepad_enabled()) {
    var_0 notifyonplayercommand("update_battle_tracks_toggle_state", "+stance");
    goto LOC_00000065;
  }

  var_0 notifyonplayercommand("update_battle_tracks_toggle_state", "nightvision");

  for(;;) {
    var_0 waittill("update_battle_tracks_toggle_state");
    var_3 = circletimernext(var_0);
    cleanupallbutxcratesforteam(var_0, var_1, var_3);
  }
}

function cleanupallbutxcratesforteam(var_0, var_1, var_2) {
  switch (var_2) {
    case "on":
      cleanup_goal_population(var_0, var_1);
      break;
    case "off":
      cleanup_fake_ai_on_death(var_0, var_1);
      break;
  }
}

function cleanup_goal_population(var_0, var_1) {
  clean_up_func(var_0, "on");
  claymore_load_spawning(var_1);
}

function cleanup_fake_ai_on_death(var_0, var_1) {
  clean_up_func(var_0, "off");
  clean_up_steam_triggers(var_1);
}

function circletimernext(var_0) {
  switch (var_0.pers["battleTracksToggleState"]) {
    case "on":
      return "off";
    case "off":
      return "on";
  }
}

function cleanup_spawned_exposed_node(var_0) {
  if(!isDefined(var_0.pers["battleTracksToggleState"])) {
    clean_up_func(var_0, "on");
    return;
  }
}

function clean_up_func(var_0, var_1) {
  var_0.pers["battleTracksToggleState"] = var_1;
  var_2 = var_0 calloutmarkerping_entityzoffset("ui_veh_battle_tracks_toggle_state");

  switch (var_1) {
    case "on":
      var_0 setclientomnvar("ui_veh_battle_tracks_toggle_state", 1);
      break;
    case "off":
      var_0 setclientomnvar("ui_veh_battle_tracks_toggle_state", 2);
      break;
  }
}

function claymore_blockdamageuntilframeend(var_0) {
  if(isDefined(var_0)) {
    var_1 = var_0 calloutmarkerping_entityzoffset("ui_veh_battle_tracks_toggle_state");
    var_0 setclientomnvar("ui_veh_battle_tracks_toggle_state", 0);
    return;
  }
}

function civ_thread(var_0) {
  return var_0.pers["battleTracksToggleState"];
}

function cleanup_lights(var_0, var_1) {
  return isDefined(var_0.pers["battleTracksToggleState"]) && var_0.pers["battleTracksToggleState"] == var_1;
}

function cleanup_target_stats_thermal(var_0, var_1, var_2) {
  var_3 = isDefined(var_2) && scripts\cp_mp\vehicles\vehicle_occupancy::ref_141df(var_0, var_2);

  if(var_3) {
    cleanup_corpses(var_1, var_1);
    return;
  }
}

function cleanup_corpses(var_0) {
  var_0 notify("stop_battle_tracks_toggle_think");
}

function civ_death() {
  var_0 = level.gametype;

  if(var_0 == "br") {
    var_1 = getDvar("scr_br_gametype", "");

    if(var_1 != "") {
      return var_1;
    }
  }

  return var_0;
}

function clean_up_minigun(var_0) {
  if(civ_death() == "x2") {
    return false;
  }

  if(classify_players_based_on_laststand(var_0)) {
    return false;
  }

  if(isDefined(var_0.cleanuppropcontrolshud) && cleanup_lights(var_0.cleanuppropcontrolshud, "off")) {
    return false;
  }

  return true;
}

function circletimestruct(var_0) {
  switch (var_0.targetname) {
    case "apc_russian":
      return "apc";
    case "atv":
      return "atv";
    case "cargo_truck_mg":
    case "cargo_truck":
      return "cargo_truck";
    case "jeep":
      return "jeep";
    case "little_bird_mg":
    case "little_bird":
      return "little_bird";
    case "tac_rover":
      return "tac_rover";
    case "light_tank":
      if(isDefined(var_0.spawndata.usealtmodel)) {
        return "tank_east";
      } else {
        return "tank_west";
      }
    case "motorcycle":
      return "motorcycle";
    case "open_jeep_carpoc":
      return "open_jeep_carpoc";
    default:
      return undefined;
  }
}

function cleanup_target_stats(var_0) {
  var_1 = var_0 getmovingplatformparent();

  if(clean_up_laser_trap_ents(var_1, var_0)) {
    thread clean_up_rocket(var_0, var_1);

    if(!clean_up_none(var_1, var_0)) {
      clean_up_strafe(var_0);
      claymoreshitby(var_1, var_0);
      return;
    }

    return;
  }
}

function claymoreshitby(var_0, var_1) {
  claymore_stunned(var_0, var_1, 0);
}

function clean_up_strafe(var_0) {
  if(claymore_crate_spawn(var_0)) {
    clean_up_vandalize(var_0);
    clean_up_steam(var_0);
    return;
  }
}

function clean_up_vandalize(var_0) {
  var_0 notify("battle_tracks_standingOnVehicleTimeout");
}

function clean_up_rocket(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("disconnect");
  var_1 notify("battle_tracks_standingOnVehicleTimeout");
  var_1 endon("battle_tracks_standingOnVehicleTimeout");
  wait 1;
  clean_up_steam(var_1);
}

function clampstepbulletdamage(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_0 endon("stop_battle_tracks_option_watch");

  for(var_2 = var_0 finishzeroarrival();; var_2 = var_3) {
    wait 0.5;
    var_3 = var_0 finishzeroarrival();

    if(var_3 != var_2) {
      if(var_3) {
        if(clean_up_minigun(var_1)) {
          claymore_stunned(var_1, var_0, 1);
        }

        continue;
      }

      clean_up_search(var_1.cleanuplinkent, var_0, 1);
    }
  }
}

function clean_up_steam(var_0) {
  clean_up_search(var_0.cleanuplinkent, var_0, 0);
}

function clean_up_laser_trap_ents(var_0, var_1) {
  if(!isDefined(var_0)) {
    return false;
  }

  if(!var_0 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    return false;
  }

  if(!cleanupallclones(var_0)) {
    return false;
  }

  if(!scripts\cp_mp\vehicles\vehicle::ref_141b9(var_0, var_1)) {
    return false;
  }

  if(!clean_up_minigun(var_0)) {
    return false;
  }

  if(!clean_and_spawn_carriables(var_0, var_1)) {
    return false;
  }

  return true;
}

function clean_up_none(var_0, var_1) {
  if(!isDefined(var_1.cleanupkeybindingsondeath)) {
    return false;
  }

  var_2 = circlesetup(var_0);
  return var_2 == var_1.cleanupkeybindingsondeath;
}

function circlesettingsassert(var_0, var_1) {
  if(classify_players_based_on_laststand(var_0)) {
    return false;
  }

  return clean_up_none(var_0, var_1);
}

function circlesetup(var_0) {
  var_1 = var_0 getentitynumber() + "";
  var_2 = var_0.cleanuppropcontrolshud getentitynumber() + "";
  return var_1 + var_2;
}

function clean_and_spawn_carriables(var_0, var_1) {
  switch (var_0.targetname) {
    case "cargo_truck_mg":
    case "cargo_truck":
      return _calloutmarkerping_handleluinotify_enemyrepinged::updatelocationbesttime(var_1, var_0, "tag_origin", -85, 0, 77, 185, 125, 40);
    default:
      return 0;
  }
}

function cleanupallclones(var_0) {
  if(isDefined(var_0.targetname)) {
    switch (var_0.targetname) {
      case "cargo_truck_mg":
      case "cargo_truck":
        return 1;
      default:
        return 0;
    }

    return;
  }

  return 0;
}