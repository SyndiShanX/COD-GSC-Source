/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_hq.gsc
************************************************/

#using scripts\engine\utility;
#using scripts\mp\bots\bots_gametype_common;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;
#using scripts\mp\gameobjects;
#namespace bots_gametype_hq;

function main() {
  setup_callbacks();
  bot_hq_start();
}

function function_e45e46b7c35deadb() {}

function bot_hq_start() {
  setup_bot_hq();
}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_hq_think;
  level.bot_funcs["should_start_cautious_approach"] = &should_start_cautious_approach_hq;
}

function setup_bot_hq() {
  bot_waittill_bots_enabled();
  var_794c62d4a40cacbd = 0;

  foreach(objective in level.objectives) {
    objective thread monitor_zone_control();
    var_c24b62a774e2496b = 0;

    if(istrue(objective.trigger.trigger_off)) {
      objective.trigger trigger_on();
      var_c24b62a774e2496b = 1;
    }

    objective.nodes = bot_get_valid_nodes_in_trigger(objective.trigger);

    if(var_c24b62a774e2496b) {
      objective.trigger trigger_off();
    }

    if(objective.nodes.size < 5) {
      wait 5;

      if(objective.nodes.size < 3) {
        var_794c62d4a40cacbd = 1;
      }
    }

  }

  level.bot_set_zone_nodes = 1;

  if(!var_794c62d4a40cacbd) {
    current_radio = find_current_radio();

    if(!isDefined(current_radio)) {
      current_radio = random(level.objectives);
    }

    bot_cache_entrances_to_zones([current_radio]);
    level.bot_gametype_radios_precached[current_radio.trigger getentitynumber()] = 1;
    level.bot_gametype_precaching_done = 1;
    thread bot_cache_entrances_to_other_radios(current_radio);
  }
}

function bot_cache_entrances_to_other_radios(radio_done) {
  for(radios_left = array_remove(level.objectives, radio_done); radios_left.size > 0; radios_left = array_remove(radios_left, radio_precaching)) {
    radio_precaching = undefined;
    current_radio = find_current_radio();

    if(isDefined(current_radio) && array_contains(radios_left, current_radio)) {
      radio_precaching = current_radio;
    } else {
      radio_precaching = random(radios_left);
    }

    bot_cache_entrances_to_zones([radio_precaching]);
    level.bot_gametype_radios_precached[radio_precaching.trigger getentitynumber()] = 1;
  }
}

function bot_hq_think() {
  self notify("bot_hq_think");
  self endon("bot_hq_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait 0.05;
  }

  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);

  while(true) {
    if(getdvarint(@ "hash_c2de8ca6dc8512c1")) {
      wait 0.05;
      continue;
    }

    wait 0.05;

    if(self.health <= 0) {
      continue;
    }

    current_radio = find_current_radio();

    if(!isDefined(current_radio) || !istrue(current_radio.active) || !isDefined(level.bot_gametype_radios_precached[current_radio.trigger getentitynumber()])) {
      bot_clear_hq_zone();
      self[[self.personality_update_function]]();
      continue;
    }

    hqowningteam = level.zone scripts\mp\gameobjects::getownerteam();

    if(self.team != hqowningteam) {
      if(!bot_is_capturing_hq_zone(current_radio)) {
        bot_capture_hq_zone(current_radio);
      }

      continue;
    }

    enemy_team = get_enemy_team(self.team);
    enemies_inside_zone = level.zone.touchlist[enemy_team].size > 0;

    if(enemies_inside_zone) {
      if(!bot_is_capturing_hq_zone(current_radio)) {
        bot_capture_hq_zone(current_radio);
      }

      continue;
    }

    if(!bot_is_protecting_hq_zone(current_radio)) {
      if(bot_is_capturing_hq_zone(current_radio)) {
        wait randomfloat(2);
        bot_clear_hq_zone();
        continue;
      }

      bot_protect_hq_zone(current_radio);
    }
  }
}

function find_current_radio() {
  foreach(radio in level.objectives) {
    if(isDefined(level.zone) && radio.trigger == level.zone.trigger) {
      return radio;
    }
  }
}

function bot_is_capturing_hq_zone(zone) {
  if(!bot_is_capturing()) {
    return false;
  }

  return isDefined(self.current_zone) && self.current_zone == zone;
}

function bot_is_protecting_hq_zone(zone) {
  if(!bot_is_protecting()) {
    return false;
  }

  return isDefined(self.current_zone) && self.current_zone == zone;
}

function bot_capture_hq_zone(zone) {
  self.current_zone = zone;
  optional_params["entrance_points_index"] = zone.entrance_indices;
  optional_params["override_origin_node"] = zone.center_node;
  bot_capture_zone(zone.trigger.origin, zone.nodes, zone.trigger, optional_params);
}

function bot_protect_hq_zone(zone) {
  self.current_zone = zone;
  zone_radius = length(zone.zone_bounds.half_size) * 2;
  optional_params["override_origin_node"] = zone.center_node;
  bot_protect_point(zone.center_node.origin, zone_radius, optional_params);
}

function bot_clear_hq_zone() {
  if(bot_is_defending()) {
    bot_defend_stop();
  }

  self.current_zone = undefined;
}

function should_start_cautious_approach_hq(firstcheck) {
  if(firstcheck) {
    team = level.zone scripts\mp\gameobjects::getownerteam();

    if(team == "neutral" || team == self.team) {
      return 0;
    }
  }

  return should_start_cautious_approach_default(firstcheck);
}