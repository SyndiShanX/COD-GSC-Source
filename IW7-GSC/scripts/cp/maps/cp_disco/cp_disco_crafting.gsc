/**********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_disco\cp_disco_crafting.gsc
**********************************************************/

init_crafting() {
  level.placed_crafted_traps = [];
  level.crafting_icon_create_func = ::create_player_crafting_item_icon;
  init_crafting_station("craft_lavalamp", (1, 1, 1));
  init_crafting_station("craft_boombox", (1, 0, 0));
  init_crafting_station("craft_turret", (0, 1, 0));
  init_crafting_station("craft_robot", (0, 0, 1));
  init_crafting_station("craft_zombgone", (1, 1, 0));
  var_0 = scripts\engine\utility::getStructArray("puzzle", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2.custom_search_dist = 96;
    var_2.disable_guided_interactions = 1;
  }
}

is_valid_tile_spot() {
  var_0 = [(-1803, 2629, 937), (-1138, 3784, 782), (-2407.5, 3456, 494.5), (-1928.5, 3815.5, 750.5), (-1911, 4188.5, 742)];
  foreach(var_2 in var_0) {
    if(self.origin == var_2) {
      return 0;
    }
  }

  return 1;
}

init_crafting_station(var_0, var_1) {
  var_2 = scripts\engine\utility::getstruct(var_0, "script_noteworthy");
  var_2.targets = getEntArray(var_2.target, "targetname");
  foreach(var_4 in var_2.targets) {
    if(issubstr(var_4.model, "tile")) {
      var_4.ispuzzlepiece = 1;
      var_4.table_pos = var_4.origin;
      var_5 = get_puzzle_piece_location(var_0);
      var_4.origin = var_5.origin;
      var_5.randomintrange = var_4;
      if(isDefined(var_5.angles)) {
        var_4.angles = var_5.angles;
      }

      continue;
    }

    var_2.crafted_item = var_4;
  }

  var_7 = scripts\engine\utility::getStructArray("puzzle", "script_noteworthy");
  foreach(var_9 in var_7) {
    if(var_9.name == var_0 && !scripts\engine\utility::istrue(var_9.used)) {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_9);
    }
  }

  var_2.remaining_pieces = 3;
  var_2.puzzle_complete = 0;
  level.interactions[var_0].disable_guided_interactions = 1;
}

use_crafting_station(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
    var_1 playlocalsound("perk_machine_deny");
    return;
  }

  if(!scripts\engine\utility::array_contains(level.current_interaction_structs, var_0)) {
    return;
  }

  if(var_0.remaining_pieces > 0) {
    if(!isDefined(var_1.puzzle_piece)) {
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("missing_item_misc", "disco_comment_vo");
      return;
    }

    if(var_1.puzzle_piece != var_0.script_noteworthy) {
      var_1 playlocalsound("perk_machine_deny");
      return;
    }

    var_1 playlocalsound("zmb_coin_sounvenir_place");
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("place_puzzle", "disco_comment_vo");
    show_next_piece(var_0);
    var_1 setclientomnvar("zombie_souvenir_piece_index", 0);
    var_1.puzzle_piece = undefined;
    var_1.last_interaction_point = undefined;
    var_0.remaining_pieces--;
    var_1 scripts\cp\cp_merits::processmerit("mt_used_crafting");
    if(var_0.remaining_pieces > 0) {
      var_1 scripts\cp\utility::play_interaction_gesture("iw7_souvenircoin_zm");
      return;
    }

    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    playFX(level._effect["crafting_souvenir"], var_0.crafted_item.origin);
    wait(2);
    var_0.crafted_item show();
    var_0.scriptable_part_name = var_0.script_noteworthy;
    var_0.crafted_item setscriptablepartstate("active", var_0.scriptable_part_name);
    var_0.puzzle_complete = 1;
    var_0.crafted_item playSound("zmb_coin_appear");
    if(var_1 scripts\cp\utility::is_valid_player()) {
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("puzzle_craft_success", "zmb_comment_vo", "low", 10, 0, 0, 0, 50);
    }

    scripts\cp\cp_vo::remove_from_nag_vo("nag_puzzle");
    switch (var_0.script_noteworthy) {
      case "craft_zombgone":
        var_0.script_noteworthy = "purchase_zombgone";
        break;

      case "craft_turret":
        var_0.script_noteworthy = "purchase_turret";
        break;

      case "craft_boombox":
        var_0.script_noteworthy = "purchase_boombox";
        break;

      case "craft_lavalamp":
        var_0.script_noteworthy = "purchase_lavalamp";
        break;

      case "craft_robot":
        var_0.script_noteworthy = "purchase_robot";
        break;
    }

    scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
    level.interactions[var_0.script_noteworthy].disable_guided_interactions = 0;
    return;
  }

  var_1 scripts\cp\utility::play_interaction_gesture();
  var_1.craftables = scripts\engine\utility::array_remove(var_1.craftables, var_0.script_noteworthy);
  var_1 playlocalsound("part_pickup");
  switch (var_0.script_noteworthy) {
    case "purchase_zombgone":
      var_2 = ["collect_craft_misc", "collect_craft_zombgone"];
      var_1 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_2), "disco_comment_vo");
      var_1 thread scripts\cp\powers\coop_powers::givepower("power_holyWater", "secondary", undefined, undefined, undefined, 0, 0);
      var_0.crafted_item setscriptablepartstate("active", "pickup_zbc");
      var_1 notify("new_power", "crafted_zombgone");
      break;

    case "purchase_turret":
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("collect_craft_misc", "disco_comment_vo");
      scripts\cp\cp_weapon_autosentry::give_crafted_sentry(var_0, var_1);
      var_0.crafted_item setscriptablepartstate("active", "pickup_turret");
      break;

    case "purchase_boombox":
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("collect_craft_misc", "disco_comment_vo");
      scripts\cp\zombies\craftables\_boombox::give_crafted_boombox(var_0, var_1);
      var_0.crafted_item setscriptablepartstate("active", "pickup_boombox");
      break;

    case "purchase_lavalamp":
      var_2 = ["collect_craft_misc", "collect_craft_lava"];
      var_1 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_2), "disco_comment_vo");
      scripts\cp\crafted_trap_lavalamp::give_crafted_lavalamp_trap(var_0, var_1);
      var_0.crafted_item setscriptablepartstate("active", "pickup_lavalamp");
      break;

    case "purchase_robot":
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("collect_craft_misc", "disco_comment_vo");
      scripts\cp\crafted_trap_robot::give_crafted_robot_trap(var_0, var_1);
      var_0.crafted_item setscriptablepartstate("active", "pickup_robot");
      break;

    default:
      break;
  }

  crafting_cooldown(var_0);
  var_0.crafted_item setscriptablepartstate("active", "default");
  wait(1);
  var_0.crafted_item setscriptablepartstate("active", var_0.scriptable_part_name);
}

crafting_cooldown(var_0, var_1) {
  var_0.cooling_down = 1;
  level scripts\engine\utility::waittill_any_return("regular_wave_starting", "event_wave_starting");
  wait(1);
  level scripts\engine\utility::waittill_any_return("regular_wave_starting", "event_wave_starting");
  var_0.cooling_down = undefined;
  var_2 = 5184;
  foreach(var_4 in level.players) {
    if(distancesquared(var_4.origin, var_0.origin) >= var_2) {
      continue;
    }

    var_4 scripts\cp\cp_interaction::refresh_interaction();
  }
}

show_next_piece(var_0) {
  foreach(var_2 in var_0.targets) {
    if(scripts\engine\utility::istrue(var_2.ispuzzlepiece) && scripts\engine\utility::istrue(var_2.hidden)) {
      var_2.origin = var_2.table_pos;
      var_2 show();
      var_2.hidden = undefined;
      switch (var_0.script_noteworthy) {
        case "craft_zombgone":
          playFX(level._effect["zbc_tile_pup"], var_2.origin + (0, 0, 5));
          break;

        case "craft_turret":
          playFX(level._effect["turret_tile_pup"], var_2.origin + (0, 0, 5));
          break;

        case "craft_boombox":
          playFX(level._effect["boombox_tile_pup"], var_2.origin + (0, 0, 5));
          break;

        case "craft_lavalamp":
          playFX(level._effect["lavalamp_tile_pup"], var_2.origin + (0, 0, 5));
          break;

        case "craft_robot":
          playFX(level._effect["robot_tile_pup"], var_2.origin + (0, 0, 5));
          break;
      }

      return;
    }
  }
}

create_player_crafting_item_icon() {
  self setclientomnvar("zombie_souvenir_piece_index", 1);
}

craft_souvenir(var_0, var_1) {}

table_look_up(var_0, var_1, var_2) {
  return tablelookup(var_0, 0, var_1, var_2);
}

get_icon_index_based_on_model(var_0) {
  return tablelookup("scripts\cp\maps\cp_zmb\cp_zmb_crafting.csv", 1, var_0, 0);
}

get_puzzle_piece_location(var_0) {
  var_1 = scripts\engine\utility::getStructArray("puzzle", "script_noteworthy");
  var_2 = [];
  foreach(var_4 in var_1) {
    if(!var_4 is_valid_tile_spot()) {
      continue;
    }

    if(var_4.name == var_0 && !scripts\engine\utility::istrue(var_4.used)) {
      var_2[var_2.size] = var_4;
    }
  }

  var_2 = scripts\engine\utility::array_randomize(var_2);
  var_2[0].used = 1;
  return var_2[0];
}

repopulate_puzzle_piece() {
  self.puzzle_interaction.randomintrange show();
  self.puzzle_interaction.randomintrange.hidden = undefined;
  scripts\cp\cp_interaction::add_to_current_interaction_list(self.puzzle_interaction);
  self.puzzle_piece = undefined;
  self.puzzle_interaction = undefined;
}

pickup_puzzle(var_0, var_1) {
  if(isDefined(var_1.puzzle_piece) || scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
    var_1 playlocalsound("perk_machine_deny");
    return;
  }

  var_1 playlocalsound("zmb_coin_pickup");
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("collect_puzzle", "disco_comment_vo");
  var_1 scripts\cp\cp_vo::add_to_nag_vo("nag_puzzle", "disco_comment_vo", 120, 120, 4, 1);
  var_1.puzzle_piece = var_0.name;
  var_1.puzzle_interaction = var_0;
  var_0.randomintrange hide();
  var_0.randomintrange.hidden = 1;
  var_2 = 1;
  switch (var_0.name) {
    case "craft_boombox":
      var_2 = 1;
      playFX(level._effect["boombox_tile_pup"], var_0.randomintrange.origin + (0, 0, 5));
      break;

    case "craft_zombgone":
      var_2 = 2;
      playFX(level._effect["zbc_tile_pup"], var_0.randomintrange.origin + (0, 0, 5));
      break;

    case "craft_turret":
      var_2 = 3;
      playFX(level._effect["turret_tile_pup"], var_0.randomintrange.origin + (0, 0, 5));
      break;

    case "craft_lavalamp":
      var_2 = 4;
      playFX(level._effect["lavalamp_tile_pup"], var_0.randomintrange.origin + (0, 0, 5));
      break;

    case "craft_robot":
      var_2 = 5;
      playFX(level._effect["robot_tile_pup"], var_0.randomintrange.origin + (0, 0, 5));
      break;
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_1 setclientomnvar("zombie_souvenir_piece_index", var_2);
  var_1 thread reset_puzzle_piece_on_disconnect();
}

reset_puzzle_piece_on_disconnect() {
  self notify("reset_puzzle_piece_on_disconnect");
  self endon("reset_puzzle_piece_on_disconnect");
  self endon("death");
  var_0 = self.puzzle_interaction;
  self waittill("disconnect");
  var_0.randomintrange show();
  var_0.randomintrange.hidden = undefined;
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}