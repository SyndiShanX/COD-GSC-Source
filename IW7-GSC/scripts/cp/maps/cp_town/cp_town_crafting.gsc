/********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
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
  var_00 = scripts\engine\utility::getstructarray("crafting_station", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_03 = getent(var_02.target, "targetname");
    var_03 setscriptablepartstate("crafting_bench", "off");
  }
}

init_crafting_pieces() {
  level.crafting_pieces = [];
  var_00 = scripts\engine\utility::getstructarray("crafting_piece", "script_noteworthy");
  foreach(var_02 in var_00) {
    var_03 = strtok(var_02.name, "_");
    if(!isDefined(level.crafting_pieces[var_03[0]])) {
      level.crafting_pieces[var_03[0]] = [];
    }

    if(!isDefined(level.crafting_pieces[var_03[0]][var_03[1]])) {
      level.crafting_pieces[var_03[0]][var_03[1]] = [];
    }

    var_02.part_location_struct = scripts\engine\utility::getstruct(var_02.target, "targetname");
    var_02.part_model = var_02.part_location_struct.script_parameters;
    level.crafting_pieces[var_03[0]][var_03[1]] = scripts\engine\utility::array_add_safe(level.crafting_pieces[var_03[0]][var_03[1]], var_02);
  }

  spawn_crafting_pieces("chem", "beaker", "clamp", "burner");
  spawn_crafting_pieces("violetray", "bulbs", "light", "shifter");
  spawn_crafting_pieces("seismic", "leg", "magnet", "piston");
  spawn_crafting_pieces("mindcontrol", "speaker", "jukebox", "battery");
  spawn_crafting_pieces("hypnosis", "bulbs", "cage", "radio");
}

spawn_crafting_pieces(param_00, param_01, param_02, param_03) {
  var_04 = scripts\engine\utility::random(level.crafting_pieces[param_00][param_01]);
  var_05 = scripts\engine\utility::random(level.crafting_pieces[param_00][param_02]);
  var_06 = scripts\engine\utility::random(level.crafting_pieces[param_00][param_03]);
  spawn_crafting_piece(var_04);
  spawn_crafting_piece(var_05);
  spawn_crafting_piece(var_06);
}

spawn_crafting_piece(param_00) {
  param_00.randomintrange = spawn("script_model", param_00.part_location_struct.origin);
  param_00.randomintrange setModel(param_00.part_model);
  if(isDefined(param_00.part_location_struct.angles)) {
    param_00.randomintrange.angles = param_00.part_location_struct.angles;
  }

  if(param_00.part_model == "cp_town_seismic_wave_device_leg") {
    param_00.randomintrange.origin = param_00.randomintrange.origin + (15, -1, 6.2);
  }
}

init_crafting_blueprints() {
  var_00 = scripts\engine\utility::getstructarray("violetray_blueprint", "script_noteworthy");
  var_01 = scripts\engine\utility::getstructarray("seismic_blueprint", "script_noteworthy");
  var_02 = scripts\engine\utility::getstructarray("mindcontrol_blueprint", "script_noteworthy");
  var_03 = scripts\engine\utility::getstructarray("hypnosis_blueprint", "script_noteworthy");
  spawn_crafting_blueprint(var_00, "cp_town_blueprint_violet_xray_roll");
  spawn_crafting_blueprint(var_01, "cp_town_blueprint_seismic_wave_roll");
  spawn_crafting_blueprint(var_02, "cp_town_blueprint_mind_control_roll");
  spawn_crafting_blueprint(var_03, "cp_town_blueprint_hypnosis_roll");
}

spawn_crafting_blueprint(param_00, param_01) {
  var_02 = scripts\engine\utility::random(param_00);
  var_03 = spawn("script_model", scripts\engine\utility::getstruct(var_02.target, "targetname").origin);
  var_03 setModel(param_01);
  var_03.angles = scripts\engine\utility::getstruct(var_02.target, "targetname").angles;
  var_02.blueprintmodel = var_03;
}

use_crafting_station(param_00, param_01) {
  if(isDefined(param_00.parts_added) && param_00.parts_added == 3) {
    param_01 thread scripts\cp\utility::usegrenadegesture(param_01, "iw7_pickup_zm");
    param_01 give_crafted_item(param_00.active_blueprint, param_00);
    crafting_cooldown(param_00);
    switch (param_00.active_blueprint) {
      case "violetray":
        show_crafted_item(param_01, param_00, "crafted_violetray", 0);
        break;

      case "portal":
        show_crafted_item(param_01, param_00, "crafted_portal", 0);
        break;

      case "hypnosis":
        show_crafted_item(param_01, param_00, "crafted_hypnosis", 0);
        break;

      case "seismic":
        show_crafted_item(param_01, param_00, "crafted_seismic", 0);
        break;

      case "mindcontrol":
        show_crafted_item(param_01, param_00, "crafted_mindcontrol", 0);
        break;
    }

    return;
  }

  if(!scripts\engine\utility::istrue(param_00.blueprint_added) && !isDefined(param_01.has_blueprint)) {
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("missing_item_misc", "town_comment_vo");
    param_01 playlocalsound("perk_machine_deny");
    return;
  }

  if(!scripts\engine\utility::istrue(param_00.blueprint_added) && isDefined(param_01.has_blueprint)) {
    param_01 scripts\cp\utility::play_interaction_gesture("iw7_souvenircoin_zm");
    param_00.blueprint_added = 1;
    param_00.var_113AF = getent(param_00.target, "targetname");
    param_00.var_113AF.blueprint = spawn("script_model", param_00.var_113AF.origin);
    param_00.var_113AF.blueprint.angles = param_00.var_113AF.angles;
    param_00.active_blueprint = param_01.has_blueprint;
    param_00.var_113AF setscriptablepartstate("crafting_bench", "on");
    param_01 playlocalsound("zmb_item_pickup");
    param_00.parts_added = 0;
    var_02 = undefined;
    switch (param_00.active_blueprint) {
      case "seismic":
        var_02 = "cp_town_blueprint_seismic_wave";
        break;

      case "violetray":
        var_02 = "cp_town_blueprint_violet_xray";
        break;

      case "hypnosis":
        var_02 = "cp_town_blueprint_hypnosis";
        break;

      case "mindcontrol":
        var_02 = "cp_town_blueprint_mind_control";
        break;

      default:
        var_02 = "cp_town_blueprint_violet_xray";
        break;
    }

    param_00.var_113AF.blueprint setModel(var_02);
    param_01.has_blueprint = undefined;
    param_01.blueprint_interaction = undefined;
    param_01 setclientomnvar("zm_hud_inventory_1", 0);
    param_01 notify("reset_blueprint_on_disconnect");
    var_03 = scripts\engine\utility::getstructarray("fan_sound", "targetname");
    if(var_03.size > 0) {
      var_04 = scripts\engine\utility::getclosest(param_01.origin, var_03);
      level thread scripts\engine\utility::play_loopsound_in_space("town_fan_lp", var_04.origin);
    }
  }

  if(scripts\engine\utility::istrue(param_00.blueprint_added) && isDefined(param_01.crafting_piece)) {
    if(is_valid_crafting_piece(param_01, param_00)) {
      param_01 scripts\cp\utility::play_interaction_gesture("iw7_souvenircoin_zm");
      var_05 = scripts\engine\utility::getstructarray(param_00.target, "targetname");
      foreach(var_07 in var_05) {
        if(param_01.crafting_piece == var_07.name) {
          if(!isDefined(param_00.added_parts)) {
            param_00.added_parts = [];
          }

          var_08 = spawn("script_model", var_07.origin);
          var_08.angles = var_07.angles;
          if(isDefined(var_07.script_noteworthy)) {
            var_08 setModel(var_07.script_noteworthy);
          } else if(isDefined(var_07.script_parameters)) {
            var_08 setModel(var_07.script_parameters);
          }

          if(var_08.model == "cp_town_seismic_wave_device_leg") {
            var_08.angles = var_08.angles + (0, -100, 0);
          }

          param_00.added_parts = scripts\engine\utility::array_add_safe(param_00.added_parts, var_08);
          param_01 playlocalsound("town_crafting_placement");
          playFX(level._effect["generic_pickup"], var_07.origin);
        }
      }

      param_01.crafting_piece = undefined;
      param_01.crafting_interaction = undefined;
      param_01 notify("reset_crafting_on_disconnect");
      param_01 setclientomnvar("zombie_souvenir_piece_index", 0);
      param_00.parts_added++;
      if(param_00.parts_added == 3) {
        if(isDefined(param_00.added_parts)) {
          foreach(var_0B in param_00.added_parts) {
            var_0B delete();
          }
        }

        param_01 scripts\cp\cp_merits::processmerit("mt_used_crafting");
        switch (param_00.active_blueprint) {
          case "violetray":
            show_crafted_item(param_01, param_00, "crafted_violetray", 1);
            break;

          case "portal":
            show_crafted_item(param_01, param_00, "crafted_portal", 1);
            break;

          case "hypnosis":
            show_crafted_item(param_01, param_00, "crafted_hypnosis", 1);
            break;

          case "seismic":
            show_crafted_item(param_01, param_00, "crafted_seismic", 1);
            break;

          case "mindcontrol":
            show_crafted_item(param_01, param_00, "crafted_mindcontrol", 1);
            break;
        }

        return;
      }

      return;
    }

    var_09 playlocalsound("perk_machine_deny");
    return;
  }
}

use_crafting_station_chem_set(param_00, param_01) {
  if(!isDefined(param_00.parts_added)) {
    param_00.parts_added = 0;
  }

  if(isDefined(level.chem_pieces) && level.chem_pieces.size > param_00.parts_added) {
    foreach(var_03 in level.chem_pieces) {
      var_04 = "";
      switch (var_03) {
        case "chem_beaker":
          var_04 = "bong";
          level scripts\cp\utility::set_completed_quest_mark(6);
          break;

        case "chem_clamp":
          var_04 = "chem_computer";
          level scripts\cp\utility::set_completed_quest_mark(8);
          break;

        case "chem_burner":
          var_04 = "pipe";
          level scripts\cp\utility::set_completed_quest_mark(7);
          break;
      }

      level thread show_chem_parts_based_on_found_piece(var_04);
    }

    param_00.parts_added = level.chem_pieces.size;
    playsoundatpos(param_00.origin, "chemistry_placement");
    if(param_00.parts_added == 3) {
      level.crafted_chem_set = 1;
      level.computer_model setscriptablepartstate("screen", "on");
      level.computer_model setscriptablepartstate("yellowlight", "on");
      scripts\engine\utility::flag_set("chemistry_step1");
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("key_phase_2_success_chemistry", "town_comment_vo");
      foreach(var_07 in level.chemical_containers) {
        playFX(level._effect["generic_pickup"], var_07.origin);
        var_07.model show();
      }

      foreach(var_0A in level.chemical_compounds_created) {
        playFX(level._effect["generic_pickup"], var_0A.interaction.origin);
        var_0A.interaction.model show();
      }

      level scripts\cp\utility::set_completed_quest_mark(3);
      scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
      setomnvar("zm_ui_lab_screen_ent", level.lab_screen);
      return;
    }

    return;
  }

  var_0B playlocalsound("perk_machine_deny");
}

give_chem_item_debug(param_00, param_01) {
  foreach(var_03 in level.players) {
    var_03.crafting_piece = param_00;
  }

  level scripts\cp\utility::set_quest_icon(param_01);
}

show_chem_parts_based_on_found_piece(param_00) {
  foreach(var_02 in level.chemistry_set_parts) {
    if(!isDefined(var_02.var_336)) {
      if(level.chem_pieces.size == 2) {
        var_02 show();
      }

      continue;
    }

    if(issubstr(var_02.var_336, param_00)) {
      if(param_00 == "chem_computer") {
        level.computer_model = var_02;
        foreach(var_04 in level.h_p_button_objects) {
          playFX(level._effect["generic_pickup"], var_04.origin);
          var_04.model show();
        }
      }

      playFX(level._effect["generic_pickup"], var_02.origin);
      var_02 show();
    }
  }
}

show_crafted_item(param_00, param_01, param_02, param_03) {
  param_00 scripts\cp\cp_interaction::refresh_interaction();
  if(scripts\engine\utility::istrue(param_03)) {
    param_00 playlocalsound("town_craft_magic");
  }

  var_04 = scripts\engine\utility::getstructarray("crafting_fx_spot", "targetname");
  param_01.crafting_fx = spawnfx(level._effect[param_02], scripts\engine\utility::getclosest(param_01.origin, var_04).origin + (0, 0, 5));
  param_01.fx_spot = scripts\engine\utility::getclosest(param_01.origin, var_04);
  wait(1);
  triggerfx(param_01.crafting_fx);
}

is_valid_crafting_piece(param_00, param_01) {
  var_02 = strtok(param_00.crafting_piece, "_");
  if(var_02[0] == param_01.active_blueprint) {
    return 1;
  }

  return 0;
}

create_player_crafting_item_icon() {
  self setclientomnvar("zombie_souvenir_piece_index", 1);
}

pickup_crafting_piece(param_00, param_01) {
  param_01 playlocalsound("part_pickup");
  param_01 thread scripts\cp\utility::usegrenadegesture(param_01, "iw7_pickup_zm");
  param_01 thread scripts\cp\cp_vo::try_to_play_vo("collect_craft_misc", "town_comment_vo");
  playFX(level._effect["generic_pickup"], param_00.randomintrange.origin);
  param_00.randomintrange hide();
  param_00.randomintrange.hidden = 1;
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  if(is_chem_piece(param_00)) {
    if(!isDefined(level.chem_pieces)) {
      level.chem_pieces = [];
    }

    level.chem_pieces = scripts\engine\utility::array_add_safe(level.chem_pieces, param_00.name);
    var_02 = 0;
    switch (param_00.name) {
      case "chem_beaker":
        var_02 = 12;
        break;

      case "chem_clamp":
        var_02 = 14;
        break;

      case "chem_burner":
        var_02 = 13;
        break;
    }

    level scripts\cp\utility::set_quest_icon(var_02);
    return;
  }

  if(isDefined(var_02.crafting_piece)) {
    var_02 notify("bad_part");
    wait(0.05);
  }

  var_02.crafting_piece = param_01.name;
  var_02.crafting_interaction = param_01;
  var_02 = 0;
  switch (param_00.name) {
    case "violetray_shifter":
      var_02 = 12;
      break;

    case "violetray_bulbs":
      var_02 = 10;
      break;

    case "violetray_light":
      var_02 = 11;
      break;

    case "seismic_leg":
      var_02 = 8;
      break;

    case "seismic_piston":
      var_02 = 7;
      break;

    case "seismic_magnet":
      var_02 = 9;
      break;

    case "mindcontrol_speaker":
      var_02 = 6;
      break;

    case "mindcontrol_jukebox":
      var_02 = 5;
      break;

    case "mindcontrol_battery":
      var_02 = 4;
      break;

    case "hypnosis_bulbs":
      var_02 = 3;
      break;

    case "hypnosis_cage":
      var_02 = 2;
      break;

    case "hypnosis_radio":
      var_02 = 1;
      break;
  }

  param_01 setclientomnvar("zombie_souvenir_piece_index", var_02);
  param_01 thread reset_crafting_piece_on_disconnect_or_bad_part();
}

is_chem_piece(param_00) {
  if(issubstr(param_00.name, "chem")) {
    return 1;
  }

  return 0;
}

reset_crafting_piece_on_disconnect_or_bad_part() {
  self notify("reset_crafting_on_disconnect");
  self endon("reset_crafting_on_disconnect");
  var_00 = self.crafting_interaction;
  var_01 = scripts\engine\utility::waittill_any_return_no_endon_death_3("disconnect", "bad_part");
  var_00.randomintrange show();
  var_00.randomintrange.hidden = undefined;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_00);
  if(isDefined(var_01) && var_01 == "bad_part") {
    self.crafting_interaction = undefined;
    self.crafting_piece = undefined;
    self setclientomnvar("zombie_souvenir_piece_index", 0);
  }
}

reset_blueprint_on_disconnect() {
  self notify("reset_blueprint_on_disconnect");
  self endon("reset_blueprint_on_disconnect");
  var_00 = self.blueprint_interaction;
  var_01 = scripts\engine\utility::waittill_any_return_no_endon_death_3("disconnect");
  var_00.blueprintmodel show();
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_00);
}

crafting_station_chem_hint(param_00, param_01) {
  if(!isDefined(param_00.parts_added)) {
    param_00.parts_added = 0;
  }

  if(isDefined(level.chem_pieces) && level.chem_pieces.size > param_00.parts_added) {
    return level.interaction_hintstrings["crafting_station_add_part"];
  }

  return "";
}

crafting_station_hint(param_00, param_01) {
  if(scripts\engine\utility::istrue(param_00.cooling_down)) {
    return &"COOP_INTERACTIONS_COOLDOWN";
  }

  if(scripts\engine\utility::istrue(param_00.blueprint_added)) {
    if(isDefined(param_01.crafting_piece) && is_valid_crafting_piece(param_01, param_00)) {
      return level.interaction_hintstrings["crafting_station_add_part"];
    }

    if(isDefined(param_00.parts_added) && param_00.parts_added == 3) {
      switch (param_00.active_blueprint) {
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

  if(!isDefined(param_01.has_blueprint)) {
    return &"CP_TOWN_INTERACTIONS_CRAFTING_MISSING_BLUEPRINT";
  }

  return level.interaction_hintstrings["crafting_station_add_blueprint"];
}

pickup_crafting_blueprint(param_00, param_01) {
  if(isDefined(param_01.has_blueprint)) {
    param_01.has_blueprint = undefined;
    param_01.blueprint_interaction.blueprintmodel show();
    playFX(level._effect["generic_pickup"], param_01.blueprint_interaction.blueprintmodel.origin);
    scripts\cp\cp_interaction::add_to_current_interaction_list(param_01.blueprint_interaction);
    param_01.blueprint_interaction = undefined;
  }

  param_01 thread scripts\cp\utility::usegrenadegesture(param_01, "iw7_pickup_zm");
  param_01 playlocalsound("town_pickup_blueprint");
  playFX(level._effect["generic_pickup"], param_00.blueprintmodel.origin);
  param_01.has_blueprint = param_00.name;
  param_01.blueprint_interaction = param_00;
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  param_00.blueprintmodel hide();
  switch (param_00.name) {
    case "seismic":
      param_01 setclientomnvar("zm_hud_inventory_1", 3);
      break;

    case "hypnosis":
      param_01 setclientomnvar("zm_hud_inventory_1", 1);
      break;

    case "mindcontrol":
      param_01 setclientomnvar("zm_hud_inventory_1", 2);
      break;

    case "violetray":
      param_01 setclientomnvar("zm_hud_inventory_1", 4);
      break;
  }

  param_01 thread scripts\cp\cp_vo::try_to_play_vo("collect_craft_blueprint", "town_comment_vo");
  param_01 thread reset_blueprint_on_disconnect();
}

crafting_cooldown(param_00) {
  param_00.cooling_down = 1;
  level scripts\engine\utility::waittill_any_return("regular_wave_starting", "event_wave_starting");
  wait(1);
  level scripts\engine\utility::waittill_any_return("regular_wave_starting", "event_wave_starting");
  param_00.cooling_down = undefined;
  var_01 = 5184;
  foreach(var_03 in level.players) {
    if(distancesquared(var_03.origin, param_00.origin) >= var_01) {
      continue;
    }

    var_03 scripts\cp\cp_interaction::refresh_interaction();
  }
}

give_crafted_item(param_00, param_01) {
  switch (param_00) {
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

  param_01.crafting_fx delete();
  playFX(level._effect["generic_pickup"], param_01.fx_spot.origin);
  self playlocalsound("zmb_item_pickup");
}