/********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_town\cp_town_crafting.gsc
********************************************************/

register_crafting() {
  level.interaction_hintstrings["crafting_station"] = &"CP_TOWN_INTERACTIONS_CRAFTING_MISSING_BLUEPRINT";
  level.interaction_hintstrings["crafting_station_add_part"] = &"CP_TOWN_INTERACTIONS_ADD_PART";
  level.interaction_hintstrings["crafting_station_add_blueprint"] = &"CP_TOWN_INTERACTIONS_ADD_BLUEPRINT";
  level.interaction_hintstrings["crafting_piece"] = "";
  scripts\cp\cp_interaction::register_interaction("crafting_station", "crafting", undefined, ::crafting_station_hint, ::use_crafting_station, 0, 0);
  scripts\cp\cp_interaction::register_interaction("crafting_station_chem", "crafting", undefined, ::crafting_station_chem_hint, ::use_crafting_station_chem_set, 0, 0);
  scripts\cp\cp_interaction::register_interaction("crafting_piece", "crafting", undefined, undefined, ::pickup_crafting_piece, 0, 0);
  level.interactions["crafting_piece"].disable_guided_interactions = 1;
  level.interaction_hintstrings["violetray_blueprint"] = &"CP_TOWN_INTERACTIONS_VIOLETRAY_BLUEPRINT";
  scripts\cp\cp_interaction::register_interaction("violetray_blueprint", "crafting", undefined, undefined, ::pickup_crafting_blueprint, 0, 0);
  level.interactions["violetray_blueprint"].disable_guided_interactions = 1;
  scripts\cp\cp_interaction::register_interaction("portal_blueprint", "crafting", undefined, undefined, ::pickup_crafting_blueprint, 0, 0);
  level.interaction_hintstrings["seismic_blueprint"] = &"CP_TOWN_INTERACTIONS_SEISMIC_BLUEPRINT";
  scripts\cp\cp_interaction::register_interaction("seismic_blueprint", "crafting", undefined, undefined, ::pickup_crafting_blueprint, 0, 0);
  level.interactions["seismic_blueprint"].disable_guided_interactions = 1;
  level.interaction_hintstrings["mindcontrol_blueprint"] = &"CP_TOWN_INTERACTIONS_MINDCONTROL_BLUEPRINT";
  scripts\cp\cp_interaction::register_interaction("mindcontrol_blueprint", "crafting", undefined, undefined, ::pickup_crafting_blueprint, 0, 0);
  level.interactions["mindcontrol_blueprint"].disable_guided_interactions = 1;
  level.interaction_hintstrings["hypnosis_blueprint"] = &"CP_TOWN_INTERACTIONS_HYPNOSIS_BLUEPRINT";
  scripts\cp\cp_interaction::register_interaction("hypnosis_blueprint", "crafting", undefined, undefined, ::pickup_crafting_blueprint, 0, 0);
  level.interactions["hypnosis_blueprint"].disable_guided_interactions = 1;
  level.interaction_hintstrings["create_chemistry_set"] = &"CP_TOWN_INTERACTIONS_TAKE_PORTAL";
  scripts\cp\cp_interaction::register_interaction("create_chemistry_set", "crafting", undefined, undefined, ::use_crafting_station_chem_set, 0, 0);
  level.interactions["create_chemistry_set"].disable_guided_interactions = 1;
}

init_crafting() {
  level.placed_crafted_traps = [];
  level.crafting_icon_create_func = ::create_player_crafting_item_icon;
  init_crafting_pieces();
  init_crafting_blueprints();
  level thread setup_crafting_stations();
}

setup_crafting_stations() {
  wait(15);
  var_0 = scripts\engine\utility::getStructArray("crafting_station", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_3 = getent(var_2.target, "targetname");
    var_3 setscriptablepartstate("crafting_bench", "off");
  }
}

init_crafting_pieces() {
  level.crafting_pieces = [];
  var_0 = scripts\engine\utility::getStructArray("crafting_piece", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_3 = strtok(var_2.name, "_");
    if(!isDefined(level.crafting_pieces[var_3[0]])) {
      level.crafting_pieces[var_3[0]] = [];
    }

    if(!isDefined(level.crafting_pieces[var_3[0]][var_3[1]])) {
      level.crafting_pieces[var_3[0]][var_3[1]] = [];
    }

    var_2.part_location_struct = scripts\engine\utility::getstruct(var_2.target, "targetname");
    var_2.part_model = var_2.part_location_struct.script_parameters;
    level.crafting_pieces[var_3[0]][var_3[1]] = ::scripts\engine\utility::add_to_array(level.crafting_pieces[var_3[0]][var_3[1]], var_2);
  }

  spawn_crafting_pieces("chem", "beaker", "clamp", "burner");
  spawn_crafting_pieces("violetray", "bulbs", "light", "shifter");
  spawn_crafting_pieces("seismic", "leg", "magnet", "piston");
  spawn_crafting_pieces("mindcontrol", "speaker", "jukebox", "battery");
  spawn_crafting_pieces("hypnosis", "bulbs", "cage", "radio");
}

spawn_crafting_pieces(var_0, var_1, var_2, var_3) {
  var_4 = scripts\engine\utility::random(level.crafting_pieces[var_0][var_1]);
  var_5 = scripts\engine\utility::random(level.crafting_pieces[var_0][var_2]);
  var_6 = scripts\engine\utility::random(level.crafting_pieces[var_0][var_3]);
  spawn_crafting_piece(var_4);
  spawn_crafting_piece(var_5);
  spawn_crafting_piece(var_6);
}

spawn_crafting_piece(var_0) {
  var_0.randomintrange = spawn("script_model", var_0.part_location_struct.origin);
  var_0.randomintrange setModel(var_0.part_model);
  if(isDefined(var_0.part_location_struct.angles)) {
    var_0.randomintrange.angles = var_0.part_location_struct.angles;
  }

  if(var_0.part_model == "cp_town_seismic_wave_device_leg") {
    var_0.randomintrange.origin = var_0.randomintrange.origin + (15, -1, 6.2);
  }
}

init_crafting_blueprints() {
  var_0 = scripts\engine\utility::getStructArray("violetray_blueprint", "script_noteworthy");
  var_1 = scripts\engine\utility::getStructArray("seismic_blueprint", "script_noteworthy");
  var_2 = scripts\engine\utility::getStructArray("mindcontrol_blueprint", "script_noteworthy");
  var_3 = scripts\engine\utility::getStructArray("hypnosis_blueprint", "script_noteworthy");
  spawn_crafting_blueprint(var_0, "cp_town_blueprint_violet_xray_roll");
  spawn_crafting_blueprint(var_1, "cp_town_blueprint_seismic_wave_roll");
  spawn_crafting_blueprint(var_2, "cp_town_blueprint_mind_control_roll");
  spawn_crafting_blueprint(var_3, "cp_town_blueprint_hypnosis_roll");
}

spawn_crafting_blueprint(var_0, var_1) {
  var_2 = scripts\engine\utility::random(var_0);
  var_3 = spawn("script_model", scripts\engine\utility::getstruct(var_2.target, "targetname").origin);
  var_3 setModel(var_1);
  var_3.angles = scripts\engine\utility::getstruct(var_2.target, "targetname").angles;
  var_2.blueprintmodel = var_3;
}

use_crafting_station(var_0, var_1) {
  if(isDefined(var_0.parts_added) && var_0.parts_added == 3) {
    var_1 thread scripts\cp\utility::usegrenadegesture(var_1, "iw7_pickup_zm");
    var_1 give_crafted_item(var_0.active_blueprint, var_0);
    crafting_cooldown(var_0);
    switch (var_0.active_blueprint) {
      case "violetray":
        show_crafted_item(var_1, var_0, "crafted_violetray", 0);
        break;

      case "portal":
        show_crafted_item(var_1, var_0, "crafted_portal", 0);
        break;

      case "hypnosis":
        show_crafted_item(var_1, var_0, "crafted_hypnosis", 0);
        break;

      case "seismic":
        show_crafted_item(var_1, var_0, "crafted_seismic", 0);
        break;

      case "mindcontrol":
        show_crafted_item(var_1, var_0, "crafted_mindcontrol", 0);
        break;
    }

    return;
  }

  if(!scripts\engine\utility::istrue(var_0.blueprint_added) && !isDefined(var_1.has_blueprint)) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("missing_item_misc", "town_comment_vo");
    var_1 playlocalsound("perk_machine_deny");
    return;
  }

  if(!scripts\engine\utility::istrue(var_0.blueprint_added) && isDefined(var_1.has_blueprint)) {
    var_1 scripts\cp\utility::play_interaction_gesture("iw7_souvenircoin_zm");
    var_0.blueprint_added = 1;
    var_0.var_113AF = getent(var_0.target, "targetname");
    var_0.var_113AF.blueprint = spawn("script_model", var_0.var_113AF.origin);
    var_0.var_113AF.blueprint.angles = var_0.var_113AF.angles;
    var_0.active_blueprint = var_1.has_blueprint;
    var_0.var_113AF setscriptablepartstate("crafting_bench", "on");
    var_1 playlocalsound("zmb_item_pickup");
    var_0.parts_added = 0;
    var_2 = undefined;
    switch (var_0.active_blueprint) {
      case "seismic":
        var_2 = "cp_town_blueprint_seismic_wave";
        break;

      case "violetray":
        var_2 = "cp_town_blueprint_violet_xray";
        break;

      case "hypnosis":
        var_2 = "cp_town_blueprint_hypnosis";
        break;

      case "mindcontrol":
        var_2 = "cp_town_blueprint_mind_control";
        break;

      default:
        var_2 = "cp_town_blueprint_violet_xray";
        break;
    }

    var_0.var_113AF.blueprint setModel(var_2);
    var_1.has_blueprint = undefined;
    var_1.blueprint_interaction = undefined;
    var_1 setclientomnvar("zm_hud_inventory_1", 0);
    var_1 notify("reset_blueprint_on_disconnect");
    var_3 = scripts\engine\utility::getStructArray("fan_sound", "targetname");
    if(var_3.size > 0) {
      var_4 = scripts\engine\utility::getclosest(var_1.origin, var_3);
      level thread scripts\engine\utility::play_loopsound_in_space("town_fan_lp", var_4.origin);
    }
  }

  if(scripts\engine\utility::istrue(var_0.blueprint_added) && isDefined(var_1.crafting_piece)) {
    if(is_valid_crafting_piece(var_1, var_0)) {
      var_1 scripts\cp\utility::play_interaction_gesture("iw7_souvenircoin_zm");
      var_5 = scripts\engine\utility::getStructArray(var_0.target, "targetname");
      foreach(var_7 in var_5) {
        if(var_1.crafting_piece == var_7.name) {
          if(!isDefined(var_0.added_parts)) {
            var_0.added_parts = [];
          }

          var_8 = spawn("script_model", var_7.origin);
          var_8.angles = var_7.angles;
          if(isDefined(var_7.script_noteworthy)) {
            var_8 setModel(var_7.script_noteworthy);
          } else if(isDefined(var_7.script_parameters)) {
            var_8 setModel(var_7.script_parameters);
          }

          if(var_8.model == "cp_town_seismic_wave_device_leg") {
            var_8.angles = var_8.angles + (0, -100, 0);
          }

          var_0.added_parts = scripts\engine\utility::add_to_array(var_0.added_parts, var_8);
          var_1 playlocalsound("town_crafting_placement");
          playFX(level._effect["generic_pickup"], var_7.origin);
        }
      }

      var_1.crafting_piece = undefined;
      var_1.crafting_interaction = undefined;
      var_1 notify("reset_crafting_on_disconnect");
      var_1 setclientomnvar("zombie_souvenir_piece_index", 0);
      var_0.parts_added++;
      if(var_0.parts_added == 3) {
        if(isDefined(var_0.added_parts)) {
          foreach(var_11 in var_0.added_parts) {
            var_11 delete();
          }
        }

        var_1 scripts\cp\cp_merits::processmerit("mt_used_crafting");
        switch (var_0.active_blueprint) {
          case "violetray":
            show_crafted_item(var_1, var_0, "crafted_violetray", 1);
            break;

          case "portal":
            show_crafted_item(var_1, var_0, "crafted_portal", 1);
            break;

          case "hypnosis":
            show_crafted_item(var_1, var_0, "crafted_hypnosis", 1);
            break;

          case "seismic":
            show_crafted_item(var_1, var_0, "crafted_seismic", 1);
            break;

          case "mindcontrol":
            show_crafted_item(var_1, var_0, "crafted_mindcontrol", 1);
            break;
        }

        return;
      }

      return;
    }

    var_9 playlocalsound("perk_machine_deny");
    return;
  }
}

use_crafting_station_chem_set(var_0, var_1) {
  if(!isDefined(var_0.parts_added)) {
    var_0.parts_added = 0;
  }

  if(isDefined(level.chem_pieces) && level.chem_pieces.size > var_0.parts_added) {
    foreach(var_3 in level.chem_pieces) {
      var_4 = "";
      switch (var_3) {
        case "chem_beaker":
          var_4 = "bong";
          level scripts\cp\utility::set_completed_quest_mark(6);
          break;

        case "chem_clamp":
          var_4 = "chem_computer";
          level scripts\cp\utility::set_completed_quest_mark(8);
          break;

        case "chem_burner":
          var_4 = "pipe";
          level scripts\cp\utility::set_completed_quest_mark(7);
          break;
      }

      level thread show_chem_parts_based_on_found_piece(var_4);
    }

    var_0.parts_added = level.chem_pieces.size;
    playsoundatpos(var_0.origin, "chemistry_placement");
    if(var_0.parts_added == 3) {
      level.crafted_chem_set = 1;
      level.computer_model setscriptablepartstate("screen", "on");
      level.computer_model setscriptablepartstate("yellowlight", "on");
      scripts\engine\utility::flag_set("chemistry_step1");
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("key_phase_2_success_chemistry", "town_comment_vo");
      foreach(var_7 in level.chemical_containers) {
        playFX(level._effect["generic_pickup"], var_7.origin);
        var_7.model show();
      }

      foreach(var_10 in level.chemical_compounds_created) {
        playFX(level._effect["generic_pickup"], var_10.interaction.origin);
        var_10.interaction.model show();
      }

      level scripts\cp\utility::set_completed_quest_mark(3);
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
      setomnvar("zm_ui_lab_screen_ent", level.lab_screen);
      return;
    }

    return;
  }

  var_11 playlocalsound("perk_machine_deny");
}

give_chem_item_debug(var_0, var_1) {
  foreach(var_3 in level.players) {
    var_3.crafting_piece = var_0;
  }

  level scripts\cp\utility::set_quest_icon(var_1);
}

show_chem_parts_based_on_found_piece(var_0) {
  foreach(var_2 in level.chemistry_set_parts) {
    if(!isDefined(var_2.var_336)) {
      if(level.chem_pieces.size == 2) {
        var_2 show();
      }

      continue;
    }

    if(issubstr(var_2.var_336, var_0)) {
      if(var_0 == "chem_computer") {
        level.computer_model = var_2;
        foreach(var_4 in level.h_p_button_objects) {
          playFX(level._effect["generic_pickup"], var_4.origin);
          var_4.model show();
        }
      }

      playFX(level._effect["generic_pickup"], var_2.origin);
      var_2 show();
    }
  }
}

show_crafted_item(var_0, var_1, var_2, var_3) {
  var_0 scripts\cp\cp_interaction::refresh_interaction();
  if(scripts\engine\utility::istrue(var_3)) {
    var_0 playlocalsound("town_craft_magic");
  }

  var_4 = scripts\engine\utility::getStructArray("crafting_fx_spot", "targetname");
  var_1.crafting_fx = spawnfx(level._effect[var_2], scripts\engine\utility::getclosest(var_1.origin, var_4).origin + (0, 0, 5));
  var_1.fx_spot = scripts\engine\utility::getclosest(var_1.origin, var_4);
  wait(1);
  triggerfx(var_1.crafting_fx);
}

is_valid_crafting_piece(var_0, var_1) {
  var_2 = strtok(var_0.crafting_piece, "_");
  if(var_2[0] == var_1.active_blueprint) {
    return 1;
  }

  return 0;
}

create_player_crafting_item_icon() {
  self setclientomnvar("zombie_souvenir_piece_index", 1);
}

pickup_crafting_piece(var_0, var_1) {
  var_1 playlocalsound("part_pickup");
  var_1 thread scripts\cp\utility::usegrenadegesture(var_1, "iw7_pickup_zm");
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("collect_craft_misc", "town_comment_vo");
  playFX(level._effect["generic_pickup"], var_0.randomintrange.origin);
  var_0.randomintrange hide();
  var_0.randomintrange.hidden = 1;
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  if(is_chem_piece(var_0)) {
    if(!isDefined(level.chem_pieces)) {
      level.chem_pieces = [];
    }

    level.chem_pieces = scripts\engine\utility::add_to_array(level.chem_pieces, var_0.name);
    var_2 = 0;
    switch (var_0.name) {
      case "chem_beaker":
        var_2 = 12;
        break;

      case "chem_clamp":
        var_2 = 14;
        break;

      case "chem_burner":
        var_2 = 13;
        break;
    }

    level scripts\cp\utility::set_quest_icon(var_2);
    return;
  }

  if(isDefined(var_2.crafting_piece)) {
    var_2 notify("bad_part");
    wait(0.05);
  }

  var_2.crafting_piece = var_1.name;
  var_2.crafting_interaction = var_1;
  var_2 = 0;
  switch (var_0.name) {
    case "violetray_shifter":
      var_2 = 12;
      break;

    case "violetray_bulbs":
      var_2 = 10;
      break;

    case "violetray_light":
      var_2 = 11;
      break;

    case "seismic_leg":
      var_2 = 8;
      break;

    case "seismic_piston":
      var_2 = 7;
      break;

    case "seismic_magnet":
      var_2 = 9;
      break;

    case "mindcontrol_speaker":
      var_2 = 6;
      break;

    case "mindcontrol_jukebox":
      var_2 = 5;
      break;

    case "mindcontrol_battery":
      var_2 = 4;
      break;

    case "hypnosis_bulbs":
      var_2 = 3;
      break;

    case "hypnosis_cage":
      var_2 = 2;
      break;

    case "hypnosis_radio":
      var_2 = 1;
      break;
  }

  var_1 setclientomnvar("zombie_souvenir_piece_index", var_2);
  var_1 thread reset_crafting_piece_on_disconnect_or_bad_part();
}

is_chem_piece(var_0) {
  if(issubstr(var_0.name, "chem")) {
    return 1;
  }

  return 0;
}

reset_crafting_piece_on_disconnect_or_bad_part() {
  self notify("reset_crafting_on_disconnect");
  self endon("reset_crafting_on_disconnect");
  var_0 = self.crafting_interaction;
  var_1 = scripts\engine\utility::waittill_any_return_no_endon_death_3("disconnect", "bad_part");
  var_0.randomintrange show();
  var_0.randomintrange.hidden = undefined;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
  if(isDefined(var_1) && var_1 == "bad_part") {
    self.crafting_interaction = undefined;
    self.crafting_piece = undefined;
    self setclientomnvar("zombie_souvenir_piece_index", 0);
  }
}

reset_blueprint_on_disconnect() {
  self notify("reset_blueprint_on_disconnect");
  self endon("reset_blueprint_on_disconnect");
  var_0 = self.blueprint_interaction;
  var_1 = scripts\engine\utility::waittill_any_return_no_endon_death_3("disconnect");
  var_0.blueprintmodel show();
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

crafting_station_chem_hint(var_0, var_1) {
  if(!isDefined(var_0.parts_added)) {
    var_0.parts_added = 0;
  }

  if(isDefined(level.chem_pieces) && level.chem_pieces.size > var_0.parts_added) {
    return level.interaction_hintstrings["crafting_station_add_part"];
  }

  return "";
}

crafting_station_hint(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_0.cooling_down)) {
    return &"COOP_INTERACTIONS_COOLDOWN";
  }

  if(scripts\engine\utility::istrue(var_0.blueprint_added)) {
    if(isDefined(var_1.crafting_piece) && is_valid_crafting_piece(var_1, var_0)) {
      return level.interaction_hintstrings["crafting_station_add_part"];
    }

    if(isDefined(var_0.parts_added) && var_0.parts_added == 3) {
      switch (var_0.active_blueprint) {
        case "violetray":
          return &"CP_TOWN_INTERACTIONS_TAKE_VIOLETRAY";

        case "portal":
          return &"CP_TOWN_INTERACTIONS_TAKE_PORTAL";

        case "seismic":
          return &"CP_TOWN_INTERACTIONS_TAKE_SEISMIC";

        case "mindcontrol":
          return &"CP_TOWN_INTERACTIONS_TAKE_MINDCONTROL";

        case "hypnosis":
          return &"CP_TOWN_INTERACTIONS_TAKE_HYPNOSIS";
      }

      return;
    }

    return "";
  }

  if(!isDefined(var_1.has_blueprint)) {
    return &"CP_TOWN_INTERACTIONS_CRAFTING_MISSING_BLUEPRINT";
  }

  return level.interaction_hintstrings["crafting_station_add_blueprint"];
}

pickup_crafting_blueprint(var_0, var_1) {
  if(isDefined(var_1.has_blueprint)) {
    var_1.has_blueprint = undefined;
    var_1.blueprint_interaction.blueprintmodel show();
    playFX(level._effect["generic_pickup"], var_1.blueprint_interaction.blueprintmodel.origin);
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_1.blueprint_interaction);
    var_1.blueprint_interaction = undefined;
  }

  var_1 thread scripts\cp\utility::usegrenadegesture(var_1, "iw7_pickup_zm");
  var_1 playlocalsound("town_pickup_blueprint");
  playFX(level._effect["generic_pickup"], var_0.blueprintmodel.origin);
  var_1.has_blueprint = var_0.name;
  var_1.blueprint_interaction = var_0;
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_0.blueprintmodel hide();
  switch (var_0.name) {
    case "seismic":
      var_1 setclientomnvar("zm_hud_inventory_1", 3);
      break;

    case "hypnosis":
      var_1 setclientomnvar("zm_hud_inventory_1", 1);
      break;

    case "mindcontrol":
      var_1 setclientomnvar("zm_hud_inventory_1", 2);
      break;

    case "violetray":
      var_1 setclientomnvar("zm_hud_inventory_1", 4);
      break;
  }

  var_1 thread scripts\cp\cp_vo::try_to_play_vo("collect_craft_blueprint", "town_comment_vo");
  var_1 thread reset_blueprint_on_disconnect();
}

crafting_cooldown(var_0) {
  var_0.cooling_down = 1;
  level scripts\engine\utility::waittill_any_return("regular_wave_starting", "event_wave_starting");
  wait(1);
  level scripts\engine\utility::waittill_any_return("regular_wave_starting", "event_wave_starting");
  var_0.cooling_down = undefined;
  var_1 = 5184;
  foreach(var_3 in level.players) {
    if(distancesquared(var_3.origin, var_0.origin) >= var_1) {
      continue;
    }

    var_3 scripts\cp\cp_interaction::refresh_interaction();
  }
}

give_crafted_item(var_0, var_1) {
  switch (var_0) {
    case "violetray":
      level thread scripts\cp\crafted_trap_violetray::give_crafted_violetray_trap(undefined, self);
      break;

    case "portal":
      level thread scripts\cp\crafted_trap_portal::give_crafted_portal(undefined, self);
      break;

    case "seismic":
      level thread scripts\cp\crafted_trap_seismic::give_crafted_seismic_trap(undefined, self);
      break;

    case "mindcontrol":
      level thread scripts\cp\crafted_trap_mindcontrol::give_crafted_mindcontrol_trap(undefined, self);
      break;

    case "hypnosis":
      level thread scripts\cp\crafted_trap_hypnosis::give_crafted_hypnosis(undefined, self);
      break;
  }

  var_1.crafting_fx delete();
  playFX(level._effect["generic_pickup"], var_1.fx_spot.origin);
  self playlocalsound("zmb_item_pickup");
}