/********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_rave\cp_rave_crafting.gsc
********************************************************/

init_crafting() {
  level.crafting_table = "scripts\cp\maps\cp_rave\cp_rave_crafting.csv";
  level.max_crafting_drops = 1;
  level.num_crafting_drops = 0;
  level.last_crafting_item_drop_time = gettime();
  level.crafting_item_min_drop_time = 25000;
  level.crafting_item_max_drop_time = -5536;
  level.next_crafting_item_drop_time = gettime() + 180000;
  level.crafting_item_drop_func = ::zmb_crafting_item_drop_func;
  level.crafting_item_debug_drop = ::zmb_crafting_item_debug_drop;
  level.crafting_item_models = get_crafting_models_from_table(level.crafting_table);
  level.craftable_items_list = get_craftable_items_from_table(level.crafting_table);
  level.crafting_item_ordered_list = level.crafting_item_models;
  level.placed_crafted_traps = [];
  level.interaction_post_activate_update_func = ::rave_post_activate_update_func;
  level.crafting_totem_areas = [];
  level.crafting_totem_uses = 0;
  level.crafting_icon_create_func = ::create_player_crafting_item_icon;
}

set_crafting_starting_location(var_0) {
  level.crafting_totem_starting_location = var_0;
  level.last_crafting_totem_area = var_0;
}

activate_crafting_totem(var_0) {
  self.powered_on = 1;
  self.enabled = 1;
  level.crafting_totem_uses = 0;
  self.available_ingredient_slots = 3;
  scripts\cp\cp_interaction::add_to_current_interaction_list(self);
  self.totem setscriptablepartstate("eyes", "eyes_on");
  self.totem setscriptablepartstate("hideshow", "show");
}

deactivate_crafting_totem(var_0) {
  self.powered_on = 1;
  self.enabled = 0;
  self.available_ingredient_slots = 3;
  scripts\cp\cp_interaction::remove_from_current_interaction_list(self);
  self.totem setscriptablepartstate("eyes", "eyes_off");
}

move_crafting_totem_to_new_location() {
  for(;;) {
    var_0 = scripts\engine\utility::random(level.crafting_totem_areas);
    if(var_0 != level.last_crafting_totem_area) {
      level.current_crafting_totem.totem setscriptablepartstate("hideshow", "off");
      move_crafting_totem(var_0);
      return;
    }
  }
}

move_crafting_totem(var_0) {
  level.last_crafting_totem_area = var_0;
  foreach(var_2 in level.crafting_totems) {
    var_2 activate_crafting_totem(var_0);
  }
}

init_crafting_station() {
  level.crafting_totems = scripts\engine\utility::getstructarray("crafting_station", "script_noteworthy");
  foreach(var_1 in level.crafting_totems) {
    var_1 thread init_crafting_totem();
  }

  wait(6);
  move_crafting_totem(level.crafting_totem_starting_location);
}

get_area(var_0) {
  var_1 = getEntArray("spawn_volume", "targetname");
  foreach(var_3 in var_1) {
    if(ispointinvolume(var_0.origin + (0, 0, 50), var_3)) {
      if(isDefined(var_3.basename)) {
        return var_3.basename;
      }
    }
  }

  return undefined;
}

init_crafting_totem() {
  wait(5);
  var_0 = getEntArray(self.target, "targetname");
  self.totem = undefined;
  foreach(var_2 in var_0) {
    if(var_2.classname == "scriptable") {
      self.totem = var_2;
    }
  }

  var_0 = scripts\engine\utility::getstructarray(self.target, "targetname");
  foreach(var_2 in var_0) {
    if(var_2.script_noteworthy == "crafting_item_spot") {
      self.craft_item_spot = var_2;
    }
  }

  self.area_name = get_area(self);
  level.crafting_totem_areas[level.crafting_totem_areas.size] = self.area_name;
  self.powered_on = 1;
  self.enabled = 0;
  self.available_ingredient_slots = 3;
  self.totem setscriptablepartstate("eyes", "eyes_off");
}

use_crafting_station(var_0, var_1) {
  if(!scripts\engine\utility::array_contains(level.current_interaction_structs, var_0)) {
    return;
  }

  if(var_0.available_ingredient_slots > 0) {
    if(!isDefined(var_1.current_crafting_struct)) {
      return;
    }

    if(getweaponbasename(var_1 getcurrentweapon()) != "iw7_penetrationrail_mp") {
      var_1 setweaponammostock("iw7_souvenircoin_zm", 1);
      var_1 giveandfireoffhand("iw7_souvenircoin_zm");
    }

    var_2 = "orange";
    switch (var_1.current_crafting_struct.crafting_model) {
      case "cp_rave_crafting_totem_gem_topaz":
        var_2 = "blue";
        break;

      case "cp_rave_crafting_totem_gem_amethyst":
        var_2 = "purple";
        break;
    }

    switch (var_0.available_ingredient_slots) {
      case 3:
        var_0.totem setscriptablepartstate("socket_0", var_2);
        break;

      case 2:
        var_0.totem setscriptablepartstate("socket_1", var_2);
        break;

      case 1:
        var_0.totem setscriptablepartstate("socket_2", var_2);
        break;
    }

    if(!isDefined(var_0.ingredient_list)) {
      var_0.ingredient_list = [];
    }

    var_0.ingredient_list[3 - var_0.available_ingredient_slots] = var_1.current_crafting_struct.crafting_model;
    playsoundatpos(var_0.origin, "zmb_rave_crafting_totem_item_place");
    var_1 setclientomnvar("zombie_souvenir_piece_index", 0);
    var_1.last_interaction_point = undefined;
    var_1.current_crafting_struct = undefined;
    var_0.available_ingredient_slots--;
    var_1 scripts\cp\cp_merits::processmerit("mt_used_crafting");
    if(var_0.available_ingredient_slots > 0) {
      return;
    }

    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    var_0.craft_item_fx = spawnfx(level._effect["altar_item_flame"], var_0.craft_item_spot.origin + (0, 0, 5));
    playFX(level._effect["crafting_souvenir"], var_0.craft_item_spot.origin + (0, 0, 5));
    playsoundatpos(var_0.craft_item_spot.origin, "zmb_rave_crafting_totem_item_craft");
    wait(1);
    var_0.totem setscriptablepartstate("eyes", "active");
    craft_souvenir(var_0, var_1);
    if(isDefined(var_1)) {
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("souvenir_craft_success", "zmb_comment_vo", "low", 10, 0, 0, 0, 50);
    }

    triggerfx(var_0.craft_item_fx);
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
    while(isDefined(var_0.souvenir)) {
      wait(0.1);
    }

    var_0.totem setscriptablepartstate("eyes", "eyes_on");
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
    playsoundatpos(var_0.origin, "zmb_rave_crafting_totem_item_pickup");
    if(isDefined(var_1)) {
      var_1 playlocalsound("zmb_item_pickup");
    }

    playFX(level._effect["souvenir_pickup"], var_0.craft_item_spot.origin);
    var_0.available_ingredient_slots = 3;
    var_0.ingredient_list = [];
    if(isDefined(var_1)) {
      var_1.last_interaction_point = undefined;
    }

    level.crafting_totem_uses++;
    wait(1);
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
  }
}

zmb_crafting_item_drop_func(var_0, var_1, var_2) {
  if(!should_drop_crafting_item(var_1)) {
    return 0;
  }

  level thread spawn_crafting_item(var_1);
  return 1;
}

zmb_crafting_item_debug_drop(var_0, var_1) {
  switch (var_1) {
    case "zmb_coin_alien":
      var_1 = "cp_rave_crafting_totem_gem_amber";
      break;

    case "zmb_coin_space":
      var_1 = "cp_rave_crafting_totem_gem_amethyst";
      break;

    case "zmb_coin_ice":
      var_1 = "cp_rave_crafting_totem_gem_topaz";
      break;
  }

  level thread spawn_crafting_item(var_0, var_1);
}

spawn_crafting_item(var_0, var_1) {
  level.num_crafting_drops++;
  level.last_crafting_item_drop_time = gettime();
  level.next_crafting_item_drop_time = level.last_crafting_item_drop_time + 30000 + randomintrange(level.crafting_item_min_drop_time, level.crafting_item_max_drop_time);
  var_2 = spawn("script_model", var_0 + (0, 0, 45));
  var_2.angles = (90, 0, 0);
  var_2.og_angles = (90, 0, 0);
  var_3 = scripts\engine\utility::random(level.crafting_item_ordered_list);
  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  var_2 setModel(var_3);
  var_2.script_noteworthy = "crafting_item";
  var_4 = "purple";
  if(var_2.model == "cp_rave_crafting_totem_gem_amber") {
    var_4 = "orange";
  } else if(var_2.model == "cp_rave_crafting_totem_gem_topaz") {
    var_4 = "blue";
  }

  var_2 setscriptablepartstate("fx", var_4);
  var_2.glow_type = var_4;
  var_5 = create_crafting_pickup_interaction(var_2, 25);
  var_2 thread crafting_item_timeout(var_5);
}

create_crafting_pickup_interaction(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.script_noteworthy = "crafting_pickup";
  var_2.origin = var_0.origin - (0, 0, 45);
  var_2.randomintrange = var_0;
  var_2.requires_power = 0;
  var_2.powered_on = 1;
  var_2.script_parameters = "crafting_pickup";
  var_2.name = "crafting_pickup";
  var_2.time_remaining = var_1;
  var_2.crafting_model = var_0.model;
  var_2.crafting_icon = "";
  var_2.spend_type = "souvenir_coin";
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_2);
  return var_2;
}

crafting_item_pickup(var_0, var_1) {
  if(!isDefined(var_0.randomintrange)) {
    return;
  }

  if(isDefined(var_0.randomintrange.beingpickedup)) {
    return;
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  if(!isDefined(level.collect_tokens_vo)) {
    level.collect_tokens_vo = 1;
    if(scripts\cp\utility::map_check(0)) {
      level thread scripts\cp\cp_vo::add_to_nag_vo("dj_souvenircoin_collect_nag", "zmb_dj_vo", 60, 60, 2);
    }
  }

  var_2 = var_0.origin + (0, 0, 45);
  var_0.randomintrange setscriptablepartstate("fx", "pickup_" + var_0.randomintrange.glow_type);
  scripts\engine\utility::waitframe();
  if(isDefined(var_1.current_crafting_struct)) {
    var_1 playlocalsound("zmb_crystal_swap");
    var_3 = spawnStruct();
    var_3.script_noteworthy = "crafting_pickup";
    var_3.origin = var_0.origin;
    var_3.randomintrange = spawn("script_model", var_2);
    var_3.randomintrange.angles = (90, 0, 0);
    var_3.randomintrange.og_angles = (90, 0, 0);
    var_3.requires_power = 0;
    var_3.powered_on = 1;
    var_3.script_parameters = var_1.current_crafting_struct.script_parameters;
    var_3.name = var_1.current_crafting_struct.name;
    var_3.time_remaining = var_0.time_remaining;
    var_3.crafting_model = var_1.current_crafting_struct.crafting_model;
    var_3.crafting_icon = "";
    var_3.randomintrange setModel(var_3.crafting_model);
    var_1.current_crafting_struct = var_0;
    var_1 create_player_crafting_item_icon(var_0);
    var_3.randomintrange thread crafting_item_timeout(var_3);
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_3);
    wait(0.3);
    var_4 = "purple";
    if(var_3.randomintrange.model == "cp_rave_crafting_totem_gem_amber") {
      var_4 = "orange";
    } else if(var_3.randomintrange.model == "cp_rave_crafting_totem_gem_topaz") {
      var_4 = "blue";
    }

    var_3.randomintrange setscriptablepartstate("fx", var_4);
    var_3.randomintrange.glow_type = var_4;
  } else {
    var_1 playlocalsound("zmb_crystal_pickup");
    level.num_crafting_drops--;
    var_1.current_crafting_struct = var_0;
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("pillage_craft", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
    var_1 create_player_crafting_item_icon(var_0);
  }

  wait(1);
  if(isDefined(var_0.randomintrange)) {
    var_0.randomintrange delete();
  }

  if(isDefined(var_0)) {
    var_0 = undefined;
  }
}

create_player_crafting_item_icon(var_0) {
  var_1 = get_icon_index_based_on_model(var_0.crafting_model);
  self setclientomnvar("zombie_souvenir_piece_index", int(var_1));
}

get_icon_index_based_on_model(var_0) {
  return tablelookup("scripts\cp\maps\cp_rave\cp_rave_crafting.csv", 1, var_0, 0);
}

crafting_item_timeout(var_0) {
  self endon("death");
  self endon("vacuum");
  self notify("timeout");
  self endon("timeout");
  var_1 = 25;
  if(isDefined(var_0.time_remaining)) {
    var_1 = int(var_0.time_remaining);
  }

  var_2 = gettime() + var_1 * 1000;
  var_3 = 0;
  var_4 = 0;
  while(gettime() < var_2) {
    if(var_4 == 0) {
      self rotateyaw(360, 2);
      self movez(5, 2);
    }

    if(var_4 == 2) {
      self rotateyaw(360, 2);
      self movez(-5, 2);
    }

    if(var_4 == 4) {
      var_4 = 0;
      continue;
    }

    wait(1);
    var_4++;
    var_0.time_remaining = var_0.time_remaining - 1;
  }

  playsoundatpos(self.origin, "zmb_crystal_disappear");
  var_0.randomintrange setscriptablepartstate("fx", "pickup_" + var_0.randomintrange.glow_type);
  level.num_crafting_drops--;
  if(level.num_crafting_drops < 0) {
    level.num_crafting_drops = 0;
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  scripts\engine\utility::waitframe();
  self delete();
}

should_drop_crafting_item(var_0) {
  if(level.num_crafting_drops >= level.max_crafting_drops) {
    return 0;
  }

  if(!self.entered_playspace) {
    return 0;
  }

  foreach(var_2 in level.spawn_volume_array) {
    if(var_2.basename != "island") {
      continue;
    }

    if(ispointinvolume(var_0, var_2)) {
      return 0;
    }
  }

  if(isDefined(level.active_volume_check)) {
    if(![
        [level.active_volume_check]
      ](var_0)) {
      return 0;
    }
  }

  if(isDefined(level.invalid_spawn_volume_array)) {
    if(!scripts\cp\cp_weapon::isinvalidzone(var_0, level.invalid_spawn_volume_array, undefined, undefined, 1)) {
      return 0;
    }
  } else if(!scripts\cp\cp_weapon::isinvalidzone(var_0, undefined, undefined, undefined, 1)) {
    return 0;
  }

  if(randomint(100) < 30) {
    return 0;
  }

  if(level.next_crafting_item_drop_time > gettime()) {
    return 0;
  }

  return 1;
}

craft_souvenir(var_0, var_1) {
  var_2 = get_crafted_souvenir(var_0);
  if(!isDefined(var_2)) {
    var_2 = "money";
  }

  switch (var_2) {
    case "crafted_trap_balloon":
    case "crafted_trap_mower":
    case "crafted_gascan":
    case "crafted_revocator":
    case "crafted_boombox":
    case "crafted_electric_trap":
    case "crafted_medusa":
    case "crafted_ims":
    case "crafted_autosentry":
    case "crafted_windowtrap":
      var_0.script_noteworthy = var_2;
      var_0.spend_type = "craftable";
      var_0.requires_power = 0;
      var_0.powered_on = 1;
      var_0.script_parameters = var_2;
      var_0.name = var_2;
      var_0.souvenir = 1;
      var_0.post_activate_update = 1;
      var_0.crafted_souvenir = 1;
      break;

    default:
      foreach(var_1 in level.players) {
        var_1 scripts\cp\cp_persistence::give_player_currency(500);
        break;
      }

      break;
  }

  scripts\cp\zombies\zombie_analytics::log_itemcrafted(level.wave_num, var_2);
  if(isDefined(var_1)) {
    var_1.itemtype = var_2;
  }
}

get_crafted_souvenir(var_0) {
  foreach(var_2 in level.craftable_items_list) {
    var_3 = 0;
    var_4 = var_2;
    foreach(var_6 in var_0.ingredient_list) {
      if(scripts\engine\utility::array_contains(var_4, var_6)) {
        var_3++;
        var_4 = remove_ingredient(var_4, var_6);
      }
    }

    if(var_3 == 3) {
      return var_2[0];
    }
  }

  return undefined;
}

remove_ingredient(var_0, var_1) {
  var_2 = 0;
  var_3 = [];
  for(var_4 = 0; var_4 < var_0.size; var_4++) {
    if(!var_2 && var_0[var_4] == var_1) {
      var_2 = 1;
      continue;
    }

    var_3[var_3.size] = var_0[var_4];
  }

  return var_3;
}

get_crafting_models_from_table(var_0) {
  var_1 = [];
  for(var_2 = 1; var_2 < 99; var_2++) {
    var_3 = table_look_up(var_0, var_2, 1);
    if(var_3 == "") {
      break;
    }

    var_1[var_1.size] = var_3;
  }

  return var_1;
}

get_craftable_items_from_table(var_0) {
  var_1 = 1;
  var_2 = 2;
  var_3 = [];
  for(var_4 = 100; var_4 <= 199; var_4++) {
    var_5 = undefined;
    var_5 = table_look_up(var_0, var_4, var_1);
    if(var_5 == "") {
      break;
    }

    var_6 = strtok(table_look_up(var_0, var_4, var_2), " ");
    var_6 = scripts\engine\utility::array_insert(var_6, var_5, 0);
    var_3[var_3.size] = var_6;
  }

  return var_3;
}

table_look_up(var_0, var_1, var_2) {
  return tablelookup(var_0, 0, var_1, var_2);
}

rave_post_activate_update_func(var_0, var_1) {
  if(isDefined(var_0.souvenir)) {
    var_0.script_noteworthy = "crafting_station";
    var_0.requires_power = 1;
    var_0.powered_on = 1;
    var_0.script_parameters = "requires_power";
    var_0.name = "crafting_station";
    if(isDefined(var_0.souvenir_fx)) {
      var_0.souvenir_fx delete();
    }

    var_0.souvenir = undefined;
    var_0.post_activate_update = undefined;
    var_0.power_name = undefined;
    var_0.crafted_souvenir = undefined;
    var_0.craft_item_fx delete();
    if(var_1 scripts\cp\utility::is_valid_player()) {
      var_1 playlocalsound("zmb_item_pickup");
    }

    var_0.totem setscriptablepartstate("socket_0", "empty");
    var_0.totem setscriptablepartstate("socket_1", "empty");
    var_0.totem setscriptablepartstate("socket_2", "empty");
  }
}