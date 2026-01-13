/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3408.gsc
************************/

try_collect_from_lost_and_found(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_1.have_things_in_lost_and_found) && can_collect_lost_and_found_items(var_1) && isDefined(var_1.lost_and_found_spot) && var_1.lost_and_found_spot == var_0) {
    restore_player_status(var_1);
  }

  level.timesitemspicked++;
}

save_items_to_lost_and_found(var_0) {
  clear_previous_lost_and_found(var_0);
  var_1 = undefined;
  var_2 = scripts\engine\utility::getstructarray("lost_and_found", "script_noteworthy");
  var_2 = scripts\engine\utility::array_randomize_objects(var_2);
  foreach(var_4 in var_2) {
    if(scripts\engine\utility::array_contains(level.current_interaction_structs, var_4)) {
      var_1 = var_4;
    }
  }

  if(!isDefined(var_1)) {
    var_1 = scripts\engine\utility::random(var_2);
  }

  var_6 = spawn("script_model", var_1.origin + (0, 0, 45));
  var_6 store_player_status(var_6, var_0);
  var_6 thread lost_and_found_clean_up_monitor(var_6, var_0);
  var_0 thread delay_set_lost_and_found_omnvars(var_0, var_6);
  var_0.lost_and_found_spot = var_1;
  var_0.lost_and_found_ent = var_6;
}

delay_set_lost_and_found_omnvars(var_0, var_1) {
  var_0 endon("disconnect");
  scripts\engine\utility::waitframe();
  if(isDefined(var_0.lost_and_found_ent)) {
    var_0 setclientomnvar("zm_lostandfound_target", var_1);
    var_0 setclientomnvar("zm_lostandfound_timer", 1);
  }
}

store_player_status(var_0, var_1) {
  var_0.copy_fullweaponlist = var_1.copy_fullweaponlist;
  var_0.copy_weapon_current = var_1.copy_weapon_current;
  var_0.copy_weapon_ammo_clip = var_1.copy_weapon_ammo_clip;
  var_0.copy_weapon_ammo_stock = var_1.copy_weapon_ammo_stock;
  if(isDefined(var_1.saved_last_stand_pistol)) {
    var_0.last_stand_pistol = var_1.saved_last_stand_pistol;
    var_1.saved_last_stand_pistol = undefined;
  } else {
    var_0.last_stand_pistol = var_1.last_stand_pistol;
  }

  var_0.weapon_levels = var_1.copy_weapon_level;
  if(isDefined(var_1.current_crafting_struct)) {
    var_0.copy_crafting_struct = var_1.current_crafting_struct;
    var_1 scripts\cp\utility::remove_crafting_item();
  } else if(isDefined(var_1.puzzle_piece)) {
    var_1 scripts\cp\utility::remove_crafting_item();
  }

  if(isDefined(var_1.current_crafted_inventory)) {
    var_0.current_crafted_inventory = var_1.current_crafted_inventory;
    var_1.current_crafted_inventory = undefined;
    var_1 setclientomnvar("zom_crafted_weapon", 0);
  }

  var_0.copy_all_perks = var_1 scripts\cp\zombies\zombies_perk_machines::get_data_for_all_perks();
  var_0.copy_all_powers = var_1.pre_laststand_powers;
  var_0.copy_special_ammo_type = var_1.special_ammo_type;
  if(var_1.copy_fullweaponlist.size > 2) {
    var_1.lost_and_found_ent = var_0;
    var_1.have_things_in_lost_and_found = 1;
  }
}

restore_player_status(var_0) {
  var_0 notify("weapon_purchased");
  var_1 = var_0.lost_and_found_ent;
  var_0 takeallweapons();
  var_0.copy_fullweaponlist = var_1.copy_fullweaponlist;
  var_0.copy_weapon_current = var_1.copy_weapon_current;
  var_0.copy_weapon_ammo_clip = var_1.copy_weapon_ammo_clip;
  var_0.copy_weapon_ammo_stock = var_1.copy_weapon_ammo_stock;
  var_0.copy_all_powers = var_1.copy_all_powers;
  var_0.copy_weapon_level = var_1.weapon_levels;
  var_0 scripts\cp\utility::restore_primary_weapons_only();
  var_0 scripts\cp\utility::restore_super_weapon();
  var_0 scripts\cp\powers\coop_powers::restore_powers(var_0, var_0.copy_all_powers);
  if(isDefined(var_1.copy_crafting_struct)) {
    var_0.current_crafting_struct = var_1.copy_crafting_struct;
    var_0[[level.crafting_icon_create_func]](var_0.current_crafting_struct);
  }

  if(isDefined(var_1.current_crafted_inventory)) {
    level thread[[var_1.current_crafted_inventory.restore_func]](undefined, var_0);
  }

  var_0.special_ammo_type = var_1.copy_special_ammo_type;
  var_0.have_things_in_lost_and_found = 0;
  var_0 thread scripts\cp\utility::usegrenadegesture(var_0, "iw7_pickup_zm");
  var_0.last_stand_pistol = var_1.last_stand_pistol;
  var_0 notify("lost_and_found_collected");
  var_0.lost_and_found_primary_count = undefined;
}

can_collect_lost_and_found_items(var_0) {
  if(scripts\cp\cp_laststand::player_in_laststand(var_0)) {
    return 0;
  }

  if(!var_0 scripts\engine\utility::isweaponswitchallowed()) {
    return 0;
  }

  if(scripts\engine\utility::istrue(var_0.kung_fu_mode)) {
    return 0;
  }

  return 1;
}

lost_and_found_clean_up_monitor(var_0, var_1) {
  level endon("game_ended");
  var_1 thread lost_and_found_time_out(var_0, var_1);
  var_1 scripts\engine\utility::waittill_any_3("disconnect", "clear_previous_tombstone", "lost_and_found_collected", "lost_and_found_time_out");
  if(isDefined(var_1)) {
    var_1 setclientomnvar("zm_lostandfound_timer", 0);
    var_1 setclientomnvar("zm_lostandfound_target", undefined);
    scripts\cp\zombies\zombie_analytics::log_lostandfound(level.timesitemspicked, level.timesitemstimedout, level.timeslfused);
  }

  var_0 delete();
}

lost_and_found_time_out(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("death");
  var_1 endon("disconnect");
  var_1 endon("death");
  var_1 endon("clear_previous_tombstone");
  var_1 endon("lost_and_found_collected");
  var_1 endon("lost_and_found_time_out");
  var_2 = 0;
  while(var_2 <= 90) {
    wait(0.5);
    var_2 = var_2 + 0.5;
    var_3 = 90 - var_2 / 90;
    var_1 setclientomnvar("zm_lostandfound_timer", var_3);
  }

  level.timesitemstimedout++;
  var_1.have_things_in_lost_and_found = 0;
  var_1.lost_and_found_primary_count = undefined;
  var_1 notify("lost_and_found_time_out");
}

clear_previous_lost_and_found(var_0) {
  var_0 notify("clear_previous_tombstone");
}

refill_forge_weapon(var_0) {
  var_1 = var_0 getweaponslistprimaries();
  foreach(var_3 in var_1) {
    if(scripts\cp\cp_weapon::isforgefreezeweapon(var_3) || scripts\cp\cp_weapon::issteeldragon(var_3)) {
      var_0 setweaponammoclip(var_3, weaponclipsize(var_3));
    }
  }
}

init_lost_and_found() {
  if(isDefined(level.lost_and_found_func)) {
    [[level.lost_and_found_func]]();
  }
}

get_lost_and_found_hintstring(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
    return "";
  }

  if(scripts\engine\utility::istrue(var_1.have_things_in_lost_and_found)) {
    if(can_collect_lost_and_found_items(var_1)) {
      var_2 = scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player);
      if(isDefined(var_1.lost_and_found_spot) && var_1.lost_and_found_spot == var_0) {
        if(isDefined(var_1.lost_and_found_primary_count) && var_1.lost_and_found_primary_count.size > 2) {
          if(var_2) {
            return &"ZOMBIE_LOST_AND_FOUND_COLLECT_2_SOLO";
          }

          return &"ZOMBIE_LOST_AND_FOUND_COLLECT_2";
        }

        if(var_2) {
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