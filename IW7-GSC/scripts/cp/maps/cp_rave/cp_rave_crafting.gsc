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

set_crafting_starting_location(param_00) {
  level.crafting_totem_starting_location = param_00;
  level.last_crafting_totem_area = param_00;
}

activate_crafting_totem(param_00) {
  self.powered_on = 1;
  self.enabled = 1;
  level.crafting_totem_uses = 0;
  self.available_ingredient_slots = 3;
  scripts\cp\cp_interaction::add_to_current_interaction_list(self);
  self.totem setscriptablepartstate("eyes", "eyes_on");
  self.totem setscriptablepartstate("hideshow", "show");
}

deactivate_crafting_totem(param_00) {
  self.powered_on = 1;
  self.enabled = 0;
  self.available_ingredient_slots = 3;
  scripts\cp\cp_interaction::remove_from_current_interaction_list(self);
  self.totem setscriptablepartstate("eyes", "eyes_off");
}

move_crafting_totem_to_new_location() {
  for(;;) {
    var_00 = scripts\engine\utility::random(level.crafting_totem_areas);
    if(var_00 != level.last_crafting_totem_area) {
      level.current_crafting_totem.totem setscriptablepartstate("hideshow", "off");
      move_crafting_totem(var_00);
      return;
    }
  }
}

move_crafting_totem(param_00) {
  level.last_crafting_totem_area = param_00;
  foreach(var_02 in level.crafting_totems) {
    var_02 activate_crafting_totem(param_00);
  }
}

init_crafting_station() {
  level.crafting_totems = scripts\engine\utility::getstructarray("crafting_station", "script_noteworthy");
  foreach(var_01 in level.crafting_totems) {
    var_01 thread init_crafting_totem();
  }

  wait(6);
  move_crafting_totem(level.crafting_totem_starting_location);
}

get_area(param_00) {
  var_01 = getEntArray("spawn_volume", "targetname");
  foreach(var_03 in var_01) {
    if(ispointinvolume(param_00.origin + (0, 0, 50), var_03)) {
      if(isDefined(var_03.basename)) {
        return var_03.basename;
      }
    }
  }

  return undefined;
}

init_crafting_totem() {
  wait(5);
  var_00 = getEntArray(self.target, "targetname");
  self.totem = undefined;
  foreach(var_02 in var_00) {
    if(var_02.classname == "scriptable") {
      self.totem = var_02;
    }
  }

  var_00 = scripts\engine\utility::getstructarray(self.target, "targetname");
  foreach(var_02 in var_00) {
    if(var_02.script_noteworthy == "crafting_item_spot") {
      self.craft_item_spot = var_02;
    }
  }

  self.area_name = get_area(self);
  level.crafting_totem_areas[level.crafting_totem_areas.size] = self.area_name;
  self.powered_on = 1;
  self.enabled = 0;
  self.available_ingredient_slots = 3;
  self.totem setscriptablepartstate("eyes", "eyes_off");
}

use_crafting_station(param_00, param_01) {
  if(!scripts\engine\utility::array_contains(level.current_interaction_structs, param_00)) {
    return;
  }

  if(param_00.available_ingredient_slots > 0) {
    if(!isDefined(param_01.current_crafting_struct)) {
      return;
    }

    if(getweaponbasename(param_01 getcurrentweapon()) != "iw7_penetrationrail_mp") {
      param_01 setweaponammostock("iw7_souvenircoin_zm", 1);
      param_01 giveandfireoffhand("iw7_souvenircoin_zm");
    }

    var_02 = "orange";
    switch (param_01.current_crafting_struct.crafting_model) {
      case "cp_rave_crafting_totem_gem_topaz":
        var_02 = "blue";
        break;

      case "cp_rave_crafting_totem_gem_amethyst":
        var_02 = "purple";
        break;
    }

    switch (param_00.available_ingredient_slots) {
      case 3:
        param_00.totem setscriptablepartstate("socket_0", var_02);
        break;

      case 2:
        param_00.totem setscriptablepartstate("socket_1", var_02);
        break;

      case 1:
        param_00.totem setscriptablepartstate("socket_2", var_02);
        break;
    }

    if(!isDefined(param_00.ingredient_list)) {
      param_00.ingredient_list = [];
    }

    param_00.ingredient_list[3 - param_00.available_ingredient_slots] = param_01.current_crafting_struct.crafting_model;
    playsoundatpos(param_00.origin, "zmb_rave_crafting_totem_item_place");
    param_01 setclientomnvar("zombie_souvenir_piece_index", 0);
    param_01.last_interaction_point = undefined;
    param_01.current_crafting_struct = undefined;
    param_00.available_ingredient_slots--;
    param_01 scripts\cp\cp_merits::processmerit("mt_used_crafting");
    if(param_00.available_ingredient_slots > 0) {
      return;
    }

    scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
    param_00.craft_item_fx = spawnfx(level._effect["altar_item_flame"], param_00.craft_item_spot.origin + (0, 0, 5));
    playFX(level._effect["crafting_souvenir"], param_00.craft_item_spot.origin + (0, 0, 5));
    playsoundatpos(param_00.craft_item_spot.origin, "zmb_rave_crafting_totem_item_craft");
    wait(1);
    param_00.totem setscriptablepartstate("eyes", "active");
    craft_souvenir(param_00, param_01);
    if(isDefined(param_01)) {
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("souvenir_craft_success", "zmb_comment_vo", "low", 10, 0, 0, 0, 50);
    }

    triggerfx(param_00.craft_item_fx);
    scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
    while(isDefined(param_00.souvenir)) {
      wait(0.1);
    }

    param_00.totem setscriptablepartstate("eyes", "eyes_on");
    scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
    playsoundatpos(param_00.origin, "zmb_rave_crafting_totem_item_pickup");
    if(isDefined(param_01)) {
      param_01 playlocalsound("zmb_item_pickup");
    }

    playFX(level._effect["souvenir_pickup"], param_00.craft_item_spot.origin);
    param_00.available_ingredient_slots = 3;
    param_00.ingredient_list = [];
    if(isDefined(param_01)) {
      param_01.last_interaction_point = undefined;
    }

    level.crafting_totem_uses++;
    wait(1);
    scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
  }
}

zmb_crafting_item_drop_func(param_00, param_01, param_02) {
  if(!should_drop_crafting_item(param_01)) {
    return 0;
  }

  level thread spawn_crafting_item(param_01);
  return 1;
}

zmb_crafting_item_debug_drop(param_00, param_01) {
  switch (param_01) {
    case "zmb_coin_alien":
      param_01 = "cp_rave_crafting_totem_gem_amber";
      break;

    case "zmb_coin_space":
      param_01 = "cp_rave_crafting_totem_gem_amethyst";
      break;

    case "zmb_coin_ice":
      param_01 = "cp_rave_crafting_totem_gem_topaz";
      break;
  }

  level thread spawn_crafting_item(param_00, param_01);
}

spawn_crafting_item(param_00, param_01) {
  level.num_crafting_drops++;
  level.last_crafting_item_drop_time = gettime();
  level.next_crafting_item_drop_time = level.last_crafting_item_drop_time + 30000 + randomintrange(level.crafting_item_min_drop_time, level.crafting_item_max_drop_time);
  var_02 = spawn("script_model", param_00 + (0, 0, 45));
  var_02.angles = (90, 0, 0);
  var_02.og_angles = (90, 0, 0);
  var_03 = scripts\engine\utility::random(level.crafting_item_ordered_list);
  if(isDefined(param_01)) {
    var_03 = param_01;
  }

  var_02 setModel(var_03);
  var_02.script_noteworthy = "crafting_item";
  var_04 = "purple";
  if(var_02.model == "cp_rave_crafting_totem_gem_amber") {
    var_04 = "orange";
  } else if(var_02.model == "cp_rave_crafting_totem_gem_topaz") {
    var_04 = "blue";
  }

  var_02 setscriptablepartstate("fx", var_04);
  var_02.glow_type = var_04;
  var_05 = create_crafting_pickup_interaction(var_02, 25);
  var_02 thread crafting_item_timeout(var_05);
}

create_crafting_pickup_interaction(param_00, param_01) {
  var_02 = spawnStruct();
  var_02.script_noteworthy = "crafting_pickup";
  var_02.origin = param_00.origin - (0, 0, 45);
  var_02.randomintrange = param_00;
  var_02.requires_power = 0;
  var_02.powered_on = 1;
  var_02.script_parameters = "crafting_pickup";
  var_02.name = "crafting_pickup";
  var_02.time_remaining = param_01;
  var_02.crafting_model = param_00.model;
  var_02.crafting_icon = "";
  var_02.spend_type = "souvenir_coin";
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_02);
  return var_02;
}

crafting_item_pickup(param_00, param_01) {
  if(!isDefined(param_00.randomintrange)) {
    return;
  }

  if(isDefined(param_00.randomintrange.beingpickedup)) {
    return;
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  if(!isDefined(level.collect_tokens_vo)) {
    level.collect_tokens_vo = 1;
    if(scripts\cp\utility::map_check(0)) {
      level thread scripts\cp\cp_vo::add_to_nag_vo("dj_souvenircoin_collect_nag", "zmb_dj_vo", 60, 60, 2);
    }
  }

  var_02 = param_00.origin + (0, 0, 45);
  param_00.randomintrange setscriptablepartstate("fx", "pickup_" + param_00.randomintrange.glow_type);
  scripts\engine\utility::waitframe();
  if(isDefined(param_01.current_crafting_struct)) {
    param_01 playlocalsound("zmb_crystal_swap");
    var_03 = spawnStruct();
    var_03.script_noteworthy = "crafting_pickup";
    var_03.origin = param_00.origin;
    var_03.randomintrange = spawn("script_model", var_02);
    var_03.randomintrange.angles = (90, 0, 0);
    var_03.randomintrange.og_angles = (90, 0, 0);
    var_03.requires_power = 0;
    var_03.powered_on = 1;
    var_03.script_parameters = param_01.current_crafting_struct.script_parameters;
    var_03.name = param_01.current_crafting_struct.name;
    var_03.time_remaining = param_00.time_remaining;
    var_03.crafting_model = param_01.current_crafting_struct.crafting_model;
    var_03.crafting_icon = "";
    var_03.randomintrange setModel(var_03.crafting_model);
    param_01.current_crafting_struct = param_00;
    param_01 create_player_crafting_item_icon(param_00);
    var_03.randomintrange thread crafting_item_timeout(var_03);
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_03);
    wait(0.3);
    var_04 = "purple";
    if(var_03.randomintrange.model == "cp_rave_crafting_totem_gem_amber") {
      var_04 = "orange";
    } else if(var_03.randomintrange.model == "cp_rave_crafting_totem_gem_topaz") {
      var_04 = "blue";
    }

    var_03.randomintrange setscriptablepartstate("fx", var_04);
    var_03.randomintrange.glow_type = var_04;
  } else {
    param_01 playlocalsound("zmb_crystal_pickup");
    level.num_crafting_drops--;
    param_01.current_crafting_struct = param_00;
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("pillage_craft", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
    param_01 create_player_crafting_item_icon(param_00);
  }

  wait(1);
  if(isDefined(param_00.randomintrange)) {
    param_00.randomintrange delete();
  }

  if(isDefined(param_00)) {
    param_00 = undefined;
  }
}

create_player_crafting_item_icon(param_00) {
  var_01 = get_icon_index_based_on_model(param_00.crafting_model);
  self setclientomnvar("zombie_souvenir_piece_index", int(var_01));
}

get_icon_index_based_on_model(param_00) {
  return tablelookup("scripts\cp\maps\cp_rave\cp_rave_crafting.csv", 1, param_00, 0);
}

crafting_item_timeout(param_00) {
  self endon("death");
  self endon("vacuum");
  self notify("timeout");
  self endon("timeout");
  var_01 = 25;
  if(isDefined(param_00.time_remaining)) {
    var_01 = int(param_00.time_remaining);
  }

  var_02 = gettime() + var_01 * 1000;
  var_03 = 0;
  var_04 = 0;
  while(gettime() < var_02) {
    if(var_04 == 0) {
      self rotateyaw(360, 2);
      self movez(5, 2);
    }

    if(var_04 == 2) {
      self rotateyaw(360, 2);
      self movez(-5, 2);
    }

    if(var_04 == 4) {
      var_04 = 0;
      continue;
    }

    wait(1);
    var_04++;
    param_00.time_remaining = param_00.time_remaining - 1;
  }

  playsoundatpos(self.origin, "zmb_crystal_disappear");
  param_00.randomintrange setscriptablepartstate("fx", "pickup_" + param_00.randomintrange.glow_type);
  level.num_crafting_drops--;
  if(level.num_crafting_drops < 0) {
    level.num_crafting_drops = 0;
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  scripts\engine\utility::waitframe();
  self delete();
}

should_drop_crafting_item(param_00) {
  if(level.num_crafting_drops >= level.max_crafting_drops) {
    return 0;
  }

  if(!self.entered_playspace) {
    return 0;
  }

  foreach(var_02 in level.spawn_volume_array) {
    if(var_02.basename != "island") {
      continue;
    }

    if(ispointinvolume(param_00, var_02)) {
      return 0;
    }
  }

  if(isDefined(level.active_volume_check)) {
    if(![
        [level.active_volume_check]
      ](param_00)) {
      return 0;
    }
  }

  if(isDefined(level.invalid_spawn_volume_array)) {
    if(!scripts\cp\cp_weapon::isinvalidzone(param_00, level.invalid_spawn_volume_array, undefined, undefined, 1)) {
      return 0;
    }
  } else if(!scripts\cp\cp_weapon::isinvalidzone(param_00, undefined, undefined, undefined, 1)) {
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

craft_souvenir(param_00, param_01) {
  var_02 = get_crafted_souvenir(param_00);
  if(!isDefined(var_02)) {
    var_02 = "money";
  }

  switch (var_02) {
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
      param_00.script_noteworthy = var_02;
      param_00.spend_type = "craftable";
      param_00.requires_power = 0;
      param_00.powered_on = 1;
      param_00.script_parameters = var_02;
      param_00.name = var_02;
      param_00.souvenir = 1;
      param_00.post_activate_update = 1;
      param_00.crafted_souvenir = 1;
      break;

    default:
      foreach(param_01 in level.players) {
        param_01 scripts\cp\cp_persistence::give_player_currency(500);
        break;
      }

      break;
  }

  scripts\cp\zombies\zombie_analytics::log_itemcrafted(level.wave_num, var_02);
  if(isDefined(param_01)) {
    param_01.itemtype = var_02;
  }
}

get_crafted_souvenir(param_00) {
  foreach(var_02 in level.craftable_items_list) {
    var_03 = 0;
    var_04 = var_02;
    foreach(var_06 in param_00.ingredient_list) {
      if(scripts\engine\utility::array_contains(var_04, var_06)) {
        var_03++;
        var_04 = remove_ingredient(var_04, var_06);
      }
    }

    if(var_03 == 3) {
      return var_02[0];
    }
  }

  return undefined;
}

remove_ingredient(param_00, param_01) {
  var_02 = 0;
  var_03 = [];
  for(var_04 = 0; var_04 < param_00.size; var_04++) {
    if(!var_02 && param_00[var_04] == param_01) {
      var_02 = 1;
      continue;
    }

    var_03[var_03.size] = param_00[var_04];
  }

  return var_03;
}

get_crafting_models_from_table(param_00) {
  var_01 = [];
  for(var_02 = 1; var_02 < 99; var_02++) {
    var_03 = table_look_up(param_00, var_02, 1);
    if(var_03 == "") {
      break;
    }

    var_01[var_01.size] = var_03;
  }

  return var_01;
}

get_craftable_items_from_table(param_00) {
  var_01 = 1;
  var_02 = 2;
  var_03 = [];
  for(var_04 = 100; var_04 <= 199; var_04++) {
    var_05 = undefined;
    var_05 = table_look_up(param_00, var_04, var_01);
    if(var_05 == "") {
      break;
    }

    var_06 = strtok(table_look_up(param_00, var_04, var_02), " ");
    var_06 = scripts\engine\utility::array_insert(var_06, var_05, 0);
    var_03[var_03.size] = var_06;
  }

  return var_03;
}

table_look_up(param_00, param_01, param_02) {
  return tablelookup(param_00, 0, param_01, param_02);
}

rave_post_activate_update_func(param_00, param_01) {
  if(isDefined(param_00.souvenir)) {
    param_00.script_noteworthy = "crafting_station";
    param_00.requires_power = 1;
    param_00.powered_on = 1;
    param_00.script_parameters = "requires_power";
    param_00.name = "crafting_station";
    if(isDefined(param_00.souvenir_fx)) {
      param_00.souvenir_fx delete();
    }

    param_00.souvenir = undefined;
    param_00.post_activate_update = undefined;
    param_00.power_name = undefined;
    param_00.crafted_souvenir = undefined;
    param_00.craft_item_fx delete();
    if(param_01 scripts\cp\utility::is_valid_player()) {
      param_01 playlocalsound("zmb_item_pickup");
    }

    param_00.totem setscriptablepartstate("socket_0", "empty");
    param_00.totem setscriptablepartstate("socket_1", "empty");
    param_00.totem setscriptablepartstate("socket_2", "empty");
  }
}