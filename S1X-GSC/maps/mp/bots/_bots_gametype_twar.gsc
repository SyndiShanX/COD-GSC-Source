/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_twar.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_gamelogic;
#include maps\mp\bots\_bots_util;
#include maps\mp\bots\_bots_strategy;
#include maps\mp\bots\_bots_personality;
#include maps\mp\bots\_bots_gametype_common;

main() {
  level.bot_ignore_precalc_paths = false;
  if(level.currentgen) {
    level.bot_ignore_precalc_paths = true;
  }

  setup_callbacks();
  setup_bot_twar();

  thread bot_twar_debug();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_twar_think;
  level.bot_funcs["should_start_cautious_approach"] = ::bot_twar_should_start_cautious_approach;
  if(!level.bot_ignore_precalc_paths) {
    level.bot_funcs["get_watch_node_chance"] = ::bot_twar_get_node_chance;
  }
}

setup_bot_twar() {
  bot_waittill_bots_enabled(true);

  for(i = 0; i < level.twar_zones.size; i++) {
    level.twar_zones[i].script_label = "_" + i;
  }

  bot_cache_entrances_to_gametype_array(level.twar_zones, "zone", level.bot_ignore_precalc_paths);

  zone_z_offset_down = 55;
  fail_num = 0;
  foreach(zone in level.twar_zones) {
    if(!isDefined(zone.nearest_node)) {
      return;
    }

    zone thread monitor_zone_control();

    zone_real_middle = ((zone.origin - (0, 0, zone_z_offset_down)) + (zone.origin + (0, 0, level.zone_height))) / 2.0;
    zone_real_half_height = (level.zone_height + zone_z_offset_down) / 2.0;
    zone.nodes = GetNodesInRadius(zone_real_middle, level.zone_radius, 0, zone_real_half_height);

    if(zone.nodes.size < 6) {
      fail_num++;
      if(fail_num == 1) {
        wait(5);
      } else {
        wait(1);
      }
      assertmsg("Momentum zone in level '" + level.script + "' at location " + zone.origin + " needs at least 6 nodes in its radius");
    }
  }

  level.bot_gametype_precaching_done = true;
}

monitor_zone_control() {
  self notify("monitor_zone_control");
  self endon("monitor_zone_control");
  self endon("death");
  level endon("game_ended");

  for(;;) {
    wait(1.0);
    team = self.owner;

    if(team == "none" && level.twar_use_obj.useRate > 0) {
      Assert(level.twar_use_obj.zone == self);

      team = level.twar_use_obj.claimteam;
    }

    if(team != "none") {
      zone = GetZoneNearest(self.origin);
      if(isDefined(zone)) {
        BotZoneSetTeam(zone, team);
      }
    }
  }
}

bot_twar_debug() {
  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait(0.05);
  }

  while(1) {
    if(GetDvarInt("bot_DrawDebugGametype") == 1) {
      foreach(zone in level.twar_zones) {
        bot_draw_cylinder(zone.origin, level.zone_radius, level.zone_height, 0.05, undefined, (0, 1, 0), true);

        foreach(node in zone.nodes) {
          bot_draw_cylinder(node.origin, 10, 10, 0.05, undefined, (0, 1, 0), true, 4);
        }
      }
    }

    wait(0.05);
  }
}

bot_twar_think() {
  self notify("bot_twar_think");
  self endon("bot_twar_think");

  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("owner_disconnect");

  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait(0.05);
  }

  self BotSetFlag("separation", 0);
  self BotSetPathingStyle("beeline");
  self BotSetFlag("force_sprint", 1);

  while(true) {
    if(!bot_twar_is_capturing_zone(level.twar_use_obj.zone)) {
      bot_twar_capture_zone(level.twar_use_obj.zone);
    }

    wait(0.05);
  }
}

bot_twar_capture_zone(zone) {
  self.current_zone = zone;
  optional_params["entrance_points_index"] = bot_twar_get_zone_label(zone);
  optional_params["nearest_node_to_center"] = zone.nearest_node;
  optional_params["objective_radius"] = 500;
  self bot_capture_point(zone.origin, level.zone_radius, optional_params);
}

bot_twar_is_capturing_zone(zone) {
  if(self bot_is_capturing()) {
    if(self.current_zone == zone) {
      return true;
    }
  }

  return false;
}

bot_twar_get_node_chance(node) {
  node_on_safe_path = false;

  self_current_zone_label = bot_twar_get_zone_label(level.twar_use_obj.zone);
  ally_zones = bot_twar_get_zones_for_team(self.team);
  node_on_safe_path = false;
  foreach(ally_zone in ally_zones) {
    Assert(ally_zone != level.twar_use_obj.zone);

    if(node node_is_on_path_from_labels(self_current_zone_label, bot_twar_get_zone_label(ally_zone))) {
      node_on_safe_path = true;
      break;
    }
  }

  if(node_on_safe_path) {
    enemy_zones = bot_twar_get_zones_for_team(get_enemy_team(self.team));
    foreach(enemy_zone in enemy_zones) {
      Assert(enemy_zone != level.twar_use_obj.zone);

      if(node node_is_on_path_from_labels(self_current_zone_label, bot_twar_get_zone_label(enemy_zone))) {
        node_on_safe_path = false;
        break;
      }
    }
  }

  if(node_on_safe_path) {
    return 0.2;
  }

  return 1.0;
}

bot_twar_get_zones_for_team(team) {
  zones = [];
  foreach(zone in level.twar_zones) {
    if(zone.owner == team) {
      zones[zones.size] = zone;
    }
  }

  return zones;
}

bot_twar_get_zone_label(zone) {
  return "zone" + zone.script_label;
}

bot_twar_should_start_cautious_approach(firstCheck) {
  return false;
}