/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58336.gsc
***********************************************/

function claymore_crate_use(var0, var1) {
  if(claymore_crate_spawn(var1)) {
    clean_up_vandalize(var1);

    if(!circlesettingsassert(var0, var1)) {
      clean_up_strafe(var1);
    }
  }

  if(clean_up_minigun(var0)) {
    claymore_stunned(var0, var1, 0);
    return;
  }
}

function cleanuparenamolotovs(var0, var1, var2, var3) {
  var4 = scripts\cp_mp\vehicles\vehicle_occupancy::ref_141df(var0, var2);
  var5 = claymore_crate_player_at_max_ammo(var0, var1);
  cleanup_target_stats_thermal(var0, var1, var3);
  claymore_blockdamageuntilframeend(var1);

  if(var4) {
    if(!var5) {
      clean_up_steam_triggers(var0);
      cleanup_trap_room(var0, var1);
    }

    if(clean_up_minigun(var0)) {
      claymore_load_spawning(var0);
    }

    if(!classify_players_based_on_laststand(var0)) {
      thread cleanup_loot_pickups(var1, var1);
      return;
    }

    return;
  }
}

function claymore_forceclampangles(var0, var1, var2) {
  clean_up_search(var0.cleanuplinkent, var1, 0);
  cleanup_target_stats_thermal(var0, var1, var2);
  claymore_blockdamageuntilframeend(var1);
  var3 = claymore_crate_player_at_max_ammo(var0, var1);

  if(var3) {
    clean_up_steam_triggers(var0);
    circleposattime(var0);
    return;
  }
}

function claymore_crate_update_hint_logic_alt(var0) {
  level endon("game_ended");
  var0 endon("disconnect");

  for(;;) {
    cleanup_target_stats(var0);
    wait 0.5;
  }
}

function cleanup_trap_room(var0, var1) {
  var0.cleanupkeybindings = [];
  var0.cleanuppropcontrolshud = var1;
  var0.cleanuplinkent = "";

  if(clean_up_eliminate_drone(var0, var1)) {
    cleanup_triggers(var0, var1, 1, 9);
  } else {
    cleanup_triggers(var0, var1, 0, 9);
  }

  var0.cleanupkeybindings = scripts\engine\utility::array_randomize(var0.cleanupkeybindings);
}

function cleanup_triggers(var0, var1, var2, var3) {
  for(var4 = var2; var4 <= var3; var4++) {
    var5 = civcontroller(var0, var1, var4);

    if(isDefined(var5) && var5 > 1) {
      var6 = circuitbreakerswitchesinit(var5);

      if(var6 != "") {
        var0.cleanupkeybindings = scripts\engine\utility::array_add(var0.cleanupkeybindings, var6);
        clean_up_ents(var0, var5);
      }
    }
  }
}

function clean_up_ents(var0, var1) {
  var2 = circletestaroundplayer(var1);

  if(var0.cleanuplinkent == "") {
    var0.cleanuplinkent = var2;
    return;
  }
}

function clean_up_eliminate_drone(var0, var1) {
  var2 = civcontroller(var0, var1, 0);
  return isDefined(var2) && var2 == 1;
}

function civcontroller(var0, var1, var2) {
  var3 = circletimestruct(var0);

  if(isDefined(var3)) {
    var4 = var1 getplayerdata(level.loadoutsgroup, "customizationSetup", "vehicleCustomization", var3, "tracks", var2);
    return var4;
  }

  return undefined;
}

function circuitbreakerswitchesinit(var0) {
  var1 = tablelookup("mp_cp/vehicletracks.csv", 0, var0, 7);
  return var1;
}

function circletestaroundplayer(var0) {
  var1 = tablelookup("mp_cp/vehicletracks.csv", 0, var0, 8);
  return var1;
}

function claymore_load_spawning(var0) {
  var1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var0, 1);

  foreach(var3 in var1) {
    claymore_stunned(var0, var3, 0);
  }
}

function clean_up_steam_triggers(var0) {
  var1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var0, 1);

  foreach(var3 in var1) {
    clean_up_search(var0.cleanuplinkent, var3, 0);
  }
}

function claymore_stunned(var0, var1, var2) {
  var3 = claymore_crate_player_at_max_ammo(var0, var1);

  if(isDefined(var0.cleanuplinkent) && isDefined(var0.cleanupkeybindings) && isDefined(var1)) {
    if(isDefined(var0.cleanuppropcontrolshud) && (var3 || var2 || var1 finishzeroarrival())) {
      var4 = circlesetup(var0);

      if(!civilians_killed_stat_row(var0, var1, var4)) {
        var1.cleanuplinkent = var0.cleanuplinkent;
        var1.cleanupkeybindingsondeath = var4;
        var1 setplayermusicstate(var0.cleanuplinkent, var0.cleanupkeybindings);
      }
    }

    if(!var3 && !var2) {
      thread clampstepbulletdamage(var1, var1);
      return;
    }

    return;
  }
}

function civilians_killed_stat_row(var0, var1, var2) {
  if(!isDefined(var1.cleanuplinkent)) {
    return false;
  }

  if(!isDefined(var1.cleanupkeybindingsondeath)) {
    return false;
  }

  return var1.cleanuplinkent == var0.cleanuplinkent && var1.cleanupkeybindingsondeath == var2;
}

function clean_up_search(var0, var1, var2) {
  if(claymore_crate_spawn(var1)) {
    if(isDefined(var0) && isDefined(var1)) {
      var1.cleanuplinkent = undefined;
      var1.cleanupkeybindingsondeath = undefined;
      var1 clearoverridearchetype_code(var0);

      if(!var2) {
        var1 notify("stop_battle_tracks_option_watch");
        return;
      }

      return;
    }

    return;
  }
}

function claymore_crate_spawn(var0) {
  return isDefined(var0.cleanuplinkent) && isDefined(var0.cleanupkeybindingsondeath);
}

function claymore_crate_player_at_max_ammo(var0, var1) {
  return isDefined(var0.cleanuppropcontrolshud) && var0.cleanuppropcontrolshud == var1;
}

function circleposattime(var0) {
  var0.cleanuppropcontrolshud = undefined;
  var0.cleanupkeybindings = undefined;
  var0.cleanuplinkent = undefined;
}

function classify_players_based_on_laststand(var0) {
  if(!isDefined(var0.cleanupkeybindings)) {
    return true;
  }

  if(var0.cleanupkeybindings.size == 0) {
    return true;
  }

  return false;
}

function cleanup_loot_pickups(var0, var1) {
  var0 notify("stop_battle_tracks_toggle_think");
  var0 endon("stop_battle_tracks_toggle_think");
  var0 endon("death_or_disconnect");
  var0 endon("last_stand_start");
  cleanup_spawned_exposed_node(var0);
  var2 = civ_thread(var0);
  cleanupallbutxcratesforteam(var0, var1, var2);

  if(var0 scripts\engine\utility::is_player_gamepad_enabled()) {
    var0 notifyonplayercommand("update_battle_tracks_toggle_state", "+stance");
    goto LOC_00000065;
  }

  var0 notifyonplayercommand("update_battle_tracks_toggle_state", "nightvision");

  for(;;) {
    var0 waittill("update_battle_tracks_toggle_state");
    var3 = circletimernext(var0);
    cleanupallbutxcratesforteam(var0, var1, var3);
  }
}

function cleanupallbutxcratesforteam(var0, var1, var2) {
  switch (var2) {
    case "on":
      cleanup_goal_population(var0, var1);
      break;
    case "off":
      cleanup_fake_ai_on_death(var0, var1);
      break;
  }
}

function cleanup_goal_population(var0, var1) {
  clean_up_func(var0, "on");
  claymore_load_spawning(var1);
}

function cleanup_fake_ai_on_death(var0, var1) {
  clean_up_func(var0, "off");
  clean_up_steam_triggers(var1);
}

function circletimernext(var0) {
  switch (var0.pers["battleTracksToggleState"]) {
    case "on":
      return "off";
    case "off":
      return "on";
  }
}

function cleanup_spawned_exposed_node(var0) {
  if(!isDefined(var0.pers["battleTracksToggleState"])) {
    clean_up_func(var0, "on");
    return;
  }
}

function clean_up_func(var0, var1) {
  var0.pers["battleTracksToggleState"] = var1;
  var2 = var0 calloutmarkerping_entityzoffset("ui_veh_battle_tracks_toggle_state");

  switch (var1) {
    case "on":
      var0 setclientomnvar("ui_veh_battle_tracks_toggle_state", 1);
      break;
    case "off":
      var0 setclientomnvar("ui_veh_battle_tracks_toggle_state", 2);
      break;
  }
}

function claymore_blockdamageuntilframeend(var0) {
  if(isDefined(var0)) {
    var1 = var0 calloutmarkerping_entityzoffset("ui_veh_battle_tracks_toggle_state");
    var0 setclientomnvar("ui_veh_battle_tracks_toggle_state", 0);
    return;
  }
}

function civ_thread(var0) {
  return var0.pers["battleTracksToggleState"];
}

function cleanup_lights(var0, var1) {
  return isDefined(var0.pers["battleTracksToggleState"]) && var0.pers["battleTracksToggleState"] == var1;
}

function cleanup_target_stats_thermal(var0, var1, var2) {
  var3 = isDefined(var2) && scripts\cp_mp\vehicles\vehicle_occupancy::ref_141df(var0, var2);

  if(var3) {
    cleanup_corpses(var1, var1);
    return;
  }
}

function cleanup_corpses(var0) {
  var0 notify("stop_battle_tracks_toggle_think");
}

function civ_death() {
  var0 = level.gametype;

  if(var0 == "br") {
    var1 = getDvar("scr_br_gametype", "");

    if(var1 != "") {
      return var1;
    }
  }

  return var0;
}

function clean_up_minigun(var0) {
  if(civ_death() == "x2") {
    return false;
  }

  if(classify_players_based_on_laststand(var0)) {
    return false;
  }

  if(isDefined(var0.cleanuppropcontrolshud) && cleanup_lights(var0.cleanuppropcontrolshud, "off")) {
    return false;
  }

  return true;
}

function circletimestruct(var0) {
  switch (var0.targetname) {
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
      if(isDefined(var0.spawndata.usealtmodel)) {
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

function cleanup_target_stats(var0) {
  var1 = var0 getmovingplatformparent();

  if(clean_up_laser_trap_ents(var1, var0)) {
    thread clean_up_rocket(var0, var1);

    if(!clean_up_none(var1, var0)) {
      clean_up_strafe(var0);
      claymoreshitby(var1, var0);
      return;
    }

    return;
  }
}

function claymoreshitby(var0, var1) {
  claymore_stunned(var0, var1, 0);
}

function clean_up_strafe(var0) {
  if(claymore_crate_spawn(var0)) {
    clean_up_vandalize(var0);
    clean_up_steam(var0);
    return;
  }
}

function clean_up_vandalize(var0) {
  var0 notify("battle_tracks_standingOnVehicleTimeout");
}

function clean_up_rocket(var0, var1) {
  level endon("game_ended");
  var1 endon("disconnect");
  var1 notify("battle_tracks_standingOnVehicleTimeout");
  var1 endon("battle_tracks_standingOnVehicleTimeout");
  wait 1;
  clean_up_steam(var1);
}

function clampstepbulletdamage(var0, var1) {
  level endon("game_ended");
  var0 endon("disconnect");
  var0 endon("stop_battle_tracks_option_watch");

  for(var2 = var0 finishzeroarrival();; var2 = var3) {
    wait 0.5;
    var3 = var0 finishzeroarrival();

    if(var3 != var2) {
      if(var3) {
        if(clean_up_minigun(var1)) {
          claymore_stunned(var1, var0, 1);
        }

        continue;
      }

      clean_up_search(var1.cleanuplinkent, var0, 1);
    }
  }
}

function clean_up_steam(var0) {
  clean_up_search(var0.cleanuplinkent, var0, 0);
}

function clean_up_laser_trap_ents(var0, var1) {
  if(!isDefined(var0)) {
    return false;
  }

  if(!var0 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    return false;
  }

  if(!cleanupallclones(var0)) {
    return false;
  }

  if(!scripts\cp_mp\vehicles\vehicle::ref_141b9(var0, var1)) {
    return false;
  }

  if(!clean_up_minigun(var0)) {
    return false;
  }

  if(!clean_and_spawn_carriables(var0, var1)) {
    return false;
  }

  return true;
}

function clean_up_none(var0, var1) {
  if(!isDefined(var1.cleanupkeybindingsondeath)) {
    return false;
  }

  var2 = circlesetup(var0);
  return var2 == var1.cleanupkeybindingsondeath;
}

function circlesettingsassert(var0, var1) {
  if(classify_players_based_on_laststand(var0)) {
    return false;
  }

  return clean_up_none(var0, var1);
}

function circlesetup(var0) {
  var1 = var0 getentitynumber() + "";
  var2 = var0.cleanuppropcontrolshud getentitynumber() + "";
  return var1 + var2;
}

function clean_and_spawn_carriables(var0, var1) {
  switch (var0.targetname) {
    case "cargo_truck_mg":
    case "cargo_truck":
      return _calloutmarkerping_handleluinotify_enemyrepinged::updatelocationbesttime(var1, var0, "tag_origin", -85, 0, 77, 185, 125, 40);
    default:
      return 0;
  }
}

function cleanupallclones(var0) {
  if(isDefined(var0.targetname)) {
    switch (var0.targetname) {
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