/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3408.gsc
************************/

try_collect_from_lost_and_found(param_00, param_01) {
  if(scripts\engine\utility::istrue(param_01.have_things_in_lost_and_found) && can_collect_lost_and_found_items(param_01) && isDefined(param_01.lost_and_found_spot) && param_01.lost_and_found_spot == param_00) {
    restore_player_status(param_01);
  }

  level.timesitemspicked++;
}

save_items_to_lost_and_found(param_00) {
  clear_previous_lost_and_found(param_00);
  var_01 = undefined;
  var_02 = scripts\engine\utility::getstructarray("lost_and_found", "script_noteworthy");
  var_02 = scripts\engine\utility::array_randomize_objects(var_02);
  foreach(var_04 in var_02) {
    if(scripts\engine\utility::array_contains(level.current_interaction_structs, var_04)) {
      var_01 = var_04;
    }
  }

  if(!isDefined(var_01)) {
    var_01 = scripts\engine\utility::random(var_02);
  }

  var_06 = spawn("script_model", var_01.origin + (0, 0, 45));
  var_06 store_player_status(var_06, param_00);
  var_06 thread lost_and_found_clean_up_monitor(var_06, param_00);
  param_00 thread delay_set_lost_and_found_omnvars(param_00, var_06);
  param_00.lost_and_found_spot = var_01;
  param_00.lost_and_found_ent = var_06;
}

delay_set_lost_and_found_omnvars(param_00, param_01) {
  param_00 endon("disconnect");
  scripts\engine\utility::waitframe();
  if(isDefined(param_00.lost_and_found_ent)) {
    param_00 setclientomnvar("zm_lostandfound_target", param_01);
    param_00 setclientomnvar("zm_lostandfound_timer", 1);
  }
}

store_player_status(param_00, param_01) {
  param_00.copy_fullweaponlist = param_01.copy_fullweaponlist;
  param_00.copy_weapon_current = param_01.copy_weapon_current;
  param_00.copy_weapon_ammo_clip = param_01.copy_weapon_ammo_clip;
  param_00.copy_weapon_ammo_stock = param_01.copy_weapon_ammo_stock;
  if(isDefined(param_01.saved_last_stand_pistol)) {
    param_00.last_stand_pistol = param_01.saved_last_stand_pistol;
    param_01.saved_last_stand_pistol = undefined;
  } else {
    param_00.last_stand_pistol = param_01.last_stand_pistol;
  }

  param_00.weapon_levels = param_01.copy_weapon_level;
  if(isDefined(param_01.current_crafting_struct)) {
    param_00.copy_crafting_struct = param_01.current_crafting_struct;
    param_01 scripts\cp\utility::remove_crafting_item();
  } else if(isDefined(param_01.puzzle_piece)) {
    param_01 scripts\cp\utility::remove_crafting_item();
  }

  if(isDefined(param_01.current_crafted_inventory)) {
    param_00.current_crafted_inventory = param_01.current_crafted_inventory;
    param_01.current_crafted_inventory = undefined;
    param_01 setclientomnvar("zom_crafted_weapon", 0);
  }

  param_00.copy_all_perks = param_01 scripts\cp\zombies\zombies_perk_machines::get_data_for_all_perks();
  param_00.copy_all_powers = param_01.pre_laststand_powers;
  param_00.copy_special_ammo_type = param_01.special_ammo_type;
  if(param_01.copy_fullweaponlist.size > 2) {
    param_01.lost_and_found_ent = param_00;
    param_01.have_things_in_lost_and_found = 1;
  }
}

restore_player_status(param_00) {
  param_00 notify("weapon_purchased");
  var_01 = param_00.lost_and_found_ent;
  param_00 takeallweapons();
  param_00.copy_fullweaponlist = var_01.copy_fullweaponlist;
  param_00.copy_weapon_current = var_01.copy_weapon_current;
  param_00.copy_weapon_ammo_clip = var_01.copy_weapon_ammo_clip;
  param_00.copy_weapon_ammo_stock = var_01.copy_weapon_ammo_stock;
  param_00.copy_all_powers = var_01.copy_all_powers;
  param_00.copy_weapon_level = var_01.weapon_levels;
  param_00 scripts\cp\utility::restore_primary_weapons_only();
  param_00 scripts\cp\utility::restore_super_weapon();
  param_00 scripts\cp\powers\coop_powers::restore_powers(param_00, param_00.copy_all_powers);
  if(isDefined(var_01.copy_crafting_struct)) {
    param_00.current_crafting_struct = var_01.copy_crafting_struct;
    param_00[[level.crafting_icon_create_func]](param_00.current_crafting_struct);
  }

  if(isDefined(var_01.current_crafted_inventory)) {
    level thread[[var_01.current_crafted_inventory.restore_func]](undefined, param_00);
  }

  param_00.special_ammo_type = var_01.copy_special_ammo_type;
  param_00.have_things_in_lost_and_found = 0;
  param_00 thread scripts\cp\utility::usegrenadegesture(param_00, "iw7_pickup_zm");
  param_00.last_stand_pistol = var_01.last_stand_pistol;
  param_00 notify("lost_and_found_collected");
  param_00.lost_and_found_primary_count = undefined;
}

can_collect_lost_and_found_items(param_00) {
  if(scripts\cp\cp_laststand::player_in_laststand(param_00)) {
    return 0;
  }

  if(!param_00 scripts\engine\utility::isweaponswitchallowed()) {
    return 0;
  }

  if(scripts\engine\utility::istrue(param_00.kung_fu_mode)) {
    return 0;
  }

  return 1;
}

lost_and_found_clean_up_monitor(param_00, param_01) {
  level endon("game_ended");
  param_01 thread lost_and_found_time_out(param_00, param_01);
  param_01 scripts\engine\utility::waittill_any_3("disconnect", "clear_previous_tombstone", "lost_and_found_collected", "lost_and_found_time_out");
  if(isDefined(param_01)) {
    param_01 setclientomnvar("zm_lostandfound_timer", 0);
    param_01 setclientomnvar("zm_lostandfound_target", undefined);
    scripts\cp\zombies\zombie_analytics::log_lostandfound(level.timesitemspicked, level.timesitemstimedout, level.timeslfused);
  }

  param_00 delete();
}

lost_and_found_time_out(param_00, param_01) {
  level endon("game_ended");
  param_00 endon("death");
  param_01 endon("disconnect");
  param_01 endon("death");
  param_01 endon("clear_previous_tombstone");
  param_01 endon("lost_and_found_collected");
  param_01 endon("lost_and_found_time_out");
  var_02 = 0;
  while(var_02 <= 90) {
    wait(0.5);
    var_02 = var_02 + 0.5;
    var_03 = 90 - var_02 / 90;
    param_01 setclientomnvar("zm_lostandfound_timer", var_03);
  }

  level.timesitemstimedout++;
  param_01.have_things_in_lost_and_found = 0;
  param_01.lost_and_found_primary_count = undefined;
  param_01 notify("lost_and_found_time_out");
}

clear_previous_lost_and_found(param_00) {
  param_00 notify("clear_previous_tombstone");
}

refill_forge_weapon(param_00) {
  var_01 = param_00 getweaponslistprimaries();
  foreach(var_03 in var_01) {
    if(scripts\cp\cp_weapon::isforgefreezeweapon(var_03) || scripts\cp\cp_weapon::issteeldragon(var_03)) {
      param_00 setweaponammoclip(var_03, weaponclipsize(var_03));
    }
  }
}

init_lost_and_found() {
  if(isDefined(level.lost_and_found_func)) {
    [[level.lost_and_found_func]]();
  }
}

get_lost_and_found_hintstring(param_00, param_01) {
  if(scripts\engine\utility::istrue(param_01.kung_fu_mode)) {
    return "";
  }

  if(scripts\engine\utility::istrue(param_01.have_things_in_lost_and_found)) {
    if(can_collect_lost_and_found_items(param_01)) {
      var_02 = scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player);
      if(isDefined(param_01.lost_and_found_spot) && param_01.lost_and_found_spot == param_00) {
        if(isDefined(param_01.lost_and_found_primary_count) && param_01.lost_and_found_primary_count.size > 2) {
          if(var_02) {
            return &"ZOMBIE_LOST_AND_FOUND_COLLECT_2_SOLO";
          }

          return &"ZOMBIE_LOST_AND_FOUND_COLLECT_2";
        }

        if(var_02) {
          return &"ZOMBIE_LOST_AND_FOUND_COLLECT_1_SOLO";
        }

        return &"ZOMBIE_LOST_AND_FOUND_COLLECT_1";
      }

      return &"ZOMBIE_LOST_AND_FOUND_ITEM_AT_NEXT_WINDOW";
    }

    return &"ZOMBIE_LOST_AND_FOUND_CANNOT_COLLECT";
  }

  return &"ZOMBIE_LOST_AND_FOUND_NO_ITEM";
}

register_interactions() {
  scripts\cp\cp_interaction::register_interaction("lost_and_found", "lost_and_found", 1, ::get_lost_and_found_hintstring, ::try_collect_from_lost_and_found, 2000, 0, ::init_lost_and_found);
}