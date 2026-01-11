/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_outline_proto.gsc
********************************************/

#include maps\mp\alien\_utility;
#include common_scripts\utility;

CONST_MIN_PLAYER_OUTLINE_ENABLE_DIST_SQUARED = 2250000;
CONST_MAX_ITEM_OUTLINE_ENABLE_DIST_SQUARED = 122500;
CONST_MAX_PILLAGE_OUTLINE_ENABLE_DIST_SQUARED = 27225;
CONST_MAX_WEAPON_OUTLINE_ENABLE_DIST_SQUARED = 1000000;
CONST_MAX_DRILL_OUTLINE_ENABLE_DIST_SQUARED = 1000000;
PLAYER_COLOR_INDEX_BOOSTED_HEALTH = 0;
PLAYER_COLOR_INDEX_GOOD_HEALTH = 3;
PLAYER_COLOR_INDEX_OKAY_HEALTH = 5;
PLAYER_COLOR_INDEX_BAD_HEALTH = 4;
ITEM_COLOR_INDEX_ENOUGH_MONEY = 3;
ITEM_COLOR_INDEX_NOT_ENOUGH_MONEY = 4;
CONST_HEALTH_INVULNERABLE = 20000;
CONST_OUTLINE_COLOR_RED = 4;
CONST_OUTLINE_COLOR_GREEN = 3;
CONST_OUTLINE_COLOR_NONE = 0;

outline_init() {
  level.outline_watch_list = [];
  level.outline_pillage_watch_list = [];
  level.outline_weapon_watch_list = [];
  level.outline_drill_watch_list = [];
  level.outline_hive_watch_list = [];
  level.outline_drill_preplant_watch_list = [];
}

outline_monitor() {
  self endon("disconnect");
  level endon("game_ended");

  self waittill("spawned");
  self childthread outline_monitor_think();
}

outline_monitor_think() {
  while(true) {
    prof_begin("outline_monitor");

    self player_outline();
    waitframe();
    self item_outline();
    waitframe();
    self item_outline_pillage();
    waitframe();
    self intel_outline();
    waitframe();
    self item_outline_weapon_monitor();
    waitframe();
    self item_outline_drill_monitor();
    waitframe();
    self hive_outline_monitor();
    waitframe();
    self drill_preplant_outline_monitor();
    waitframe();

    prof_end("outline_monitor");
  }
}

update_drill_outline() {
  level waittill_any_timeout(1, "drill_spawned");

  foreach(player in level.players) {
    outline_color = player get_item_outline_color(level.drill);

    if(outline_color == CONST_OUTLINE_COLOR_GREEN || outline_color == CONST_OUTLINE_COLOR_RED) {
      enable_outline_for_player(level.drill, player, outline_color, false, "high");
    } else {
      disable_outline_for_player(level.drill, player);
    }
  }
}

player_outline() {
  self endon("refresh_outline");
  foreach(player in level.players) {
    if(self == player) {
      continue;
    }
    if(should_put_player_outline_on(player)) {
      enable_outline_for_player(player, self, get_color_index_player(player), false, "high");
    } else {
      disable_outline_for_player(player, self);
    }
  }
}

set_alien_outline() {
  self endon("unset_adrenaline");
  self endon("switchblade_over");
  self endon("disconnect");
  self endon("death");
  level endon("game_ended");

  while(true) {
    foreach(alien in maps\mp\alien\_spawnlogic::get_alive_enemies()) {
      if(isDefined(level.kraken) && alien == level.kraken) {
        continue;
      }
      if(isDefined(alien.agent_type) && alien.agent_type == "kraken_tentacle") {
        continue;
      }
      if(isDefined(alien.damaged_by_players)) {
        continue;
      }
      if(isDefined(alien.marked_for_challenge)) {
        continue;
      }
      if(isDefined(alien.pet)) {
        continue;
      } else {
        if(!isDefined(alien.no_outline_on_alien)) {
          if(isDefined(alien.feral_occludes)) {
            enable_outline_for_player(alien, self, 4, true, "high");
          } else {
            enable_outline_for_player(alien, self, 4, false, "high");
          }
        }
      }
    }
    wait(0.5);
  }
}

unset_alien_outline() {
  foreach(alien in maps\mp\alien\_spawnlogic::get_alive_enemies()) {
    if(isDefined(alien.damaged_by_players)) {
      continue;
    }
    if(isDefined(alien.marked_for_challenge)) {
      continue;
    }
    if(!isDefined(alien.pet)) {
      disable_outline_for_player(alien, self);
    }
  }

}

hive_outline_monitor() {
  self endon("refresh_outline");
  foreach(index, item in level.outline_hive_watch_list) {
    enable_outline_for_player(item, self, 4, true, "medium");
    if(index % 10 == 0) {
      waitframe();
    }
  }
}

drill_preplant_outline_monitor() {
  self endon("refresh_outline");
  foreach(index, item in level.outline_drill_preplant_watch_list) {
    if(!isDefined(item)) {
      continue;
    }
    if(should_put_drill_outline_on(item)) {
      enable_outline_for_player(item, self, 3, false, "high");
    } else {
      disable_outline_for_player(item, self);
    }

    if(index % 6 == 0) {
      waitframe();
    }
  }

}

item_outline() {
  self endon("refresh_outline");
  foreach(index, item in level.outline_watch_list) {
    if(!isDefined(item)) {
      continue;
    }
    outline_color = get_item_outline_color(item);

    if(outline_color == CONST_OUTLINE_COLOR_GREEN) {
      enable_outline_for_player(item, self, get_color_index_item(item), true, "low");
    } else if(outline_color == CONST_OUTLINE_COLOR_RED) {
      enable_outline_for_player(item, self, 4, true, "low");
    } else {
      disable_outline_for_player(item, self);
    }

    if(index % 6 == 0) {
      waitframe();
    }
  }

}

item_outline_pillage() {
  self endon("refresh_outline");
  foreach(index, item in level.outline_pillage_watch_list) {
    if(!isDefined(item)) {
      continue;
    }
    outline_color = get_pillage_item_outline_color(item);

    if(outline_color == CONST_OUTLINE_COLOR_GREEN) {
      enable_outline_for_player(item, self, 3, false, "low");
    } else if(outline_color == CONST_OUTLINE_COLOR_RED) {
      enable_outline_for_player(item, self, CONST_OUTLINE_COLOR_RED, false, "low");
    } else {
      disable_outline_for_player(item, self);
    }

    if(index % 10 == 0) {
      waitframe();
    }
  }

}

intel_outline() {
  if(isDefined(level.intel_outline_func)) {
    [[level.intel_outline_func]]();
  }
}

item_outline_weapon_monitor() {
  self endon("refresh_outline");
  foreach(index, item in level.outline_weapon_watch_list) {
    if(!isDefined(item)) {
      continue;
    }
    weapon_flag = true;
    outline_color = get_weapon_outline_color(item);

    if(outline_color == CONST_OUTLINE_COLOR_GREEN) {
      enable_outline_for_player(item, self, get_color_index_item(item, weapon_flag), true, "low");
    } else if(outline_color == CONST_OUTLINE_COLOR_RED) {
      enable_outline_for_player(item, self, 4, true, "low");
    } else {
      disable_outline_for_player(item, self);
    }

    if(index % 6 == 0) {
      waitframe();
    }
  }

}

item_outline_drill_monitor() {
  if(isDefined(level.item_outline_drill_monitor_override)) {
    [[level.item_outline_drill_monitor_override]]();
    return;
  }
  self endon("refresh_outline");
  last_used_index = undefined;

  foreach(drill in level.outline_drill_watch_list) {
    ratio = (level.drill.health - CONST_HEALTH_INVULNERABLE) / (level.drill.maxhealth - CONST_HEALTH_INVULNERABLE);

    if(ratio < 0.75) {
      if(should_put_drill_outline_on(drill)) {
        enable_outline_for_player(drill, self, get_drill_widget_color(drill), false, "high");
      } else {
        disable_outline_for_player(drill, self);
      }
    } else
      disable_outline_for_player(drill, self);
    if(isDefined(level.drill) && drill == level.drill) {
      index = get_drill_widget_color(drill);

      if(isDefined(last_used_index) && last_used_index == index) {
        continue;
      }
      last_used_index = index;
    }
  }

}

get_drill_widget_color(drill) {
  ratio = (level.drill.health - CONST_HEALTH_INVULNERABLE) / (level.drill.maxhealth - CONST_HEALTH_INVULNERABLE);

  if(ratio <= 0.30) {
    return PLAYER_COLOR_INDEX_BAD_HEALTH;
  } else if(ratio <= 0.75) {
    return PLAYER_COLOR_INDEX_OKAY_HEALTH;
  } else if(ratio <= 1) {
    return PLAYER_COLOR_INDEX_GOOD_HEALTH;
  } else {
    return PLAYER_COLOR_INDEX_BOOSTED_HEALTH;
  }
}

get_color_index_item(item, weapon_flag) {
  if(self has_pistols_only_relic_and_no_deployables() && is_true(weapon_flag)) {
    cost = level.pistol_ammo_cost;
  } else {
    cost = item.cost;
  }

  if(maps\mp\alien\_persistence::player_has_enough_currency(cost) || is_true(item.enabled)) {
    return ITEM_COLOR_INDEX_ENOUGH_MONEY;
  } else {
    return ITEM_COLOR_INDEX_NOT_ENOUGH_MONEY;
  }
}

get_color_index_player(player) {
  health_ratio = player.health / 100;

  if(health_ratio <= 0.33 || player.inlaststand) {
    return PLAYER_COLOR_INDEX_BAD_HEALTH;
  } else if(health_ratio <= 0.66) {
    return PLAYER_COLOR_INDEX_OKAY_HEALTH;
  } else if(health_ratio <= 1.0) {
    return PLAYER_COLOR_INDEX_GOOD_HEALTH;
  } else {
    return PLAYER_COLOR_INDEX_BOOSTED_HEALTH;
  }
}

get_item_outline_color(item) {
  if(isDefined(item.classname) && item.classname == "misc_turret" && isDefined(item.owner)) {
    return CONST_OUTLINE_COLOR_NONE;
  }

  in_close_proximity = distanceSquared(self.origin, item.origin) < CONST_MAX_ITEM_OUTLINE_ENABLE_DIST_SQUARED;
  if(!in_close_proximity) {
    return CONST_OUTLINE_COLOR_NONE;
  }

  if(self has_special_weapon()) {
    if(isDefined(item.targetname) && (item.targetname == "fire_trap_barrel" || item.targetname == "puddle_generator" || item.targetname == "fence_generator")) {
      return CONST_OUTLINE_COLOR_GREEN;
    } else if(isDefined(item.classname) && item.classname == "misc_turret") {
      return CONST_OUTLINE_COLOR_GREEN;
    } else {
      return CONST_OUTLINE_COLOR_RED;
    }
  } else if(self is_holding_deployable()) {
    return CONST_OUTLINE_COLOR_RED;
  }

  return CONST_OUTLINE_COLOR_GREEN;
}

get_pillage_item_outline_color(item) {
  if(!isDefined(item)) {
    return CONST_OUTLINE_COLOR_NONE;
  }

  in_close_proximity = distanceSquared(self.origin, item.origin) < CONST_MAX_PILLAGE_OUTLINE_ENABLE_DIST_SQUARED;
  if(!in_close_proximity) {
    return CONST_OUTLINE_COLOR_NONE;
  }

  if(isDefined(item.is_locker) && item.is_locker && !isDefined(self.locker_key)) {
    return CONST_OUTLINE_COLOR_NONE;
  }

  if(self is_holding_deployable() || self has_special_weapon()) {
    return CONST_OUTLINE_COLOR_RED;
  }

  return CONST_OUTLINE_COLOR_GREEN;
}

get_weapon_outline_color(item) {
  in_close_proximity = distanceSquared(self.origin, item.origin) < CONST_MAX_WEAPON_OUTLINE_ENABLE_DIST_SQUARED;
  if(!in_close_proximity) {
    return CONST_OUTLINE_COLOR_NONE;
  }

  if(is_chaos_mode() && maps\mp\alien\_chaos::is_weapon_recently_picked_up(self, item.weapon_ref)) {
    return CONST_OUTLINE_COLOR_RED;
  }

  if(self is_holding_deployable()) {
    return CONST_OUTLINE_COLOR_RED;
  }

  if(!is_true(item.is_recipe_table) && self maps\mp\alien\_prestige::prestige_getPistolsOnly() == 1 && !self maps\mp\alien\_prestige::prestige_getNoDeployables() == 1) {
    return CONST_OUTLINE_COLOR_RED;
  }

  if(isDefined(level.get_custom_weapon_outline_func) && [[level.get_custom_weapon_outline_func]](item)) {
    return CONST_OUTLINE_COLOR_RED;
  }

  if(self has_special_weapon() && !is_true(item.is_recipe_table)) {
    if(isDefined(level.drill) && item == level.drill) {
      return CONST_OUTLINE_COLOR_GREEN;
    } else {
      return CONST_OUTLINE_COLOR_RED;
    }
  }

  return CONST_OUTLINE_COLOR_GREEN;
}

should_put_drill_outline_on(item) {
  in_close_proximity = distanceSquared(self.origin, item.origin) < CONST_MAX_WEAPON_OUTLINE_ENABLE_DIST_SQUARED;
  if(!in_close_proximity) {
    return false;
  }
  return true;
}

should_put_player_outline_on(player) {
  if(!isAlive(player) || !isDefined(player.maxhealth) || !player.maxhealth) {
    return false;
  }

  not_close_proximity = distanceSquared(self.origin, player.origin) > CONST_MIN_PLAYER_OUTLINE_ENABLE_DIST_SQUARED;
  if(not_close_proximity) {
    return true;
  }

  not_in_LOS = !BulletTracePassed(self getEye(), player getEye(), false, self);
  return (not_in_LOS);
}

add_to_outline_watch_list(item, cost) {
  item.cost = cost;
  level.outline_watch_list[level.outline_watch_list.size] = item;
}

remove_from_outline_watch_list(item) {
  level.outline_watch_list = common_scripts\utility::array_remove(level.outline_watch_list, item);
  thread remove_outline(item);
}

add_to_drill_preplant_watch_list(item) {
  level.outline_drill_preplant_watch_list[level.outline_drill_preplant_watch_list.size] = item;
}

remove_from_drill_preplant_watch_list(item) {
  level.outline_drill_preplant_watch_list = common_scripts\utility::array_remove(level.outline_drill_preplant_watch_list, item);
  thread remove_outline(item);
}

add_to_outline_hive_watch_list(item) {
  level.outline_hive_watch_list[level.outline_hive_watch_list.size] = item;
}

remove_from_outline_hive_watch_list(item) {
  level.outline_hive_watch_list = common_scripts\utility::array_remove(level.outline_hive_watch_list, item);
  thread remove_outline(item);
}

add_to_outline_pillage_watch_list(item, cost) {
  if(!array_contains(level.outline_pillage_watch_list, item)) {
    item.cost = cost;
    level.outline_pillage_watch_list[level.outline_pillage_watch_list.size] = item;
  }
}

remove_from_outline_pillage_watch_list(item) {
  level.outline_pillage_watch_list = common_scripts\utility::array_remove(level.outline_pillage_watch_list, item);
  thread remove_outline(item);
}

add_to_outline_weapon_watch_list(item, cost) {
  item.cost = cost;
  level.outline_weapon_watch_list[level.outline_weapon_watch_list.size] = item;
}

remove_from_outline_weapon_watch_list(item) {
  level.outline_weapon_watch_list = common_scripts\utility::array_remove(level.outline_weapon_watch_list, item);
  thread remove_outline(item);
}

add_to_outline_drill_watch_list(item, cost) {
  item.cost = cost;
  level.outline_drill_watch_list[level.outline_drill_watch_list.size] = item;
}

remove_from_outline_drill_watch_list(item) {
  level.outline_drill_watch_list = common_scripts\utility::array_remove(level.outline_drill_watch_list, item);
  thread remove_outline(item);
}

remove_outline(item) {
  if(!isDefined(item)) {
    return;
  }
  foreach(player in level.players) {
    if(isDefined(player)) {
      player notify("refresh_outline");
      disable_outline_for_player(item, player);
    }
  }
}

enable_outline_for_players(item, players, color_index, depth_enable, priority) {
  item HudOutlineEnableForClients(players, color_index, depth_enable);
}

enable_outline_for_player(item, player, color_index, depth_enable, priority) {
  item HudOutlineEnableForClient(player, color_index, depth_enable);
}

disable_outline_for_players(item, players) {
  item HudOutlineDisableForClients(players);
}

disable_outline_for_player(item, player) {
  item HudOutlineDisableForClient(player);
}

enable_outline(item, color_index, depth_enable) {
  item HudOutlineEnable(color_index, depth_enable);
}

disable_outline(item) {
  item HudOutlineDisable();
}

outline_proto_enabled() {
  return (GetDvarInt("enable_outline_proto") == 1);
}
is_host(player) {
  return player isHost();
}