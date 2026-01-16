/**********************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_hp.gsc
**********************************************/

main() {
  setup_callbacks();
  setup_bot_hp();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_hp_think;
  level.bot_funcs["should_start_cautious_approach"] = ::should_start_cautious_approach_hp;
}

setup_bot_hp() {
  maps\mp\bots\_bots_util::bot_waittill_bots_enabled();
  var_0 = 0;

  for (var_1 = 0; var_1 < level.all_hp_zones.size; var_1++) {
    var_2 = level.all_hp_zones[var_1];
    var_2.script_label = "zone_" + var_1;
    var_2 thread maps\mp\bots\_bots_gametype_common::monitor_zone_control();
    var_3 = 0;

    if(isdefined(var_2.trig.trigger_off) && var_2.trig.trigger_off) {
      var_2.trig common_scripts\utility::trigger_on();
      var_3 = 1;
    }

    var_2.nodes = maps\mp\bots\_bots_gametype_common::bot_get_valid_nodes_in_trigger(var_2.trig);

    if(var_3)
      var_2.trig common_scripts\utility::trigger_off();
  }

  level.bot_set_zone_nodes = 1;

  if(!var_0) {
    level.bot_hp_allow_predictive_capping = 1;
    var_4 = level.zone;

    if(!isdefined(var_4))
      var_4 = common_scripts\utility::random(level.all_hp_zones);

    maps\mp\bots\_bots_gametype_common::bot_cache_entrances_to_zones([var_4]);
    level.bot_gametype_zones_precached[var_4 getentitynumber()] = 1;
    level.bot_gametype_precaching_done = 1;
    thread bot_cache_entrances_to_other_zones(var_4);
  }
}

bot_cache_entrances_to_other_zones(var_0) {
  for (var_1 = common_scripts\utility::array_remove(level.all_hp_zones, var_0); var_1.size > 0; var_1 = common_scripts\utility::array_remove(var_1, var_2)) {
    var_2 = undefined;
    var_3 = level.zone;

    if(isdefined(var_3) && common_scripts\utility::array_contains(var_1, var_3))
      var_2 = var_3;
    else
      var_2 = common_scripts\utility::random(var_1);

    maps\mp\bots\_bots_gametype_common::bot_cache_entrances_to_zones([var_2]);
    level.bot_gametype_zones_precached[var_2 getentitynumber()] = 1;
  }
}

bot_hp_think() {
  self notify("bot_hp_think");
  self endon("bot_hp_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while (!isdefined(level.bot_gametype_precaching_done))
    wait 0.05;

  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);
  var_0 = undefined;
  var_1 = level.zone;

  for (;;) {
    wait 0.05;

    if(self.health <= 0) {
      continue;
    }
    if(!isdefined(level.zone) || !isdefined(level.bot_gametype_zones_precached[level.zone getentitynumber()])) {
      if(maps\mp\bots\_bots_util::bot_is_defending())
        maps\mp\bots\_bots_strategy::bot_defend_stop();

      self.current_zone = undefined;
      self[[self.personality_update_function]]();
      continue;
    }

    if(var_1 != level.zone) {
      var_0 = undefined;
      var_1 = level.zone;
    }

    if(isdefined(level.zonemovetime) && !isdefined(var_0) && level.randomzonespawn == 0 && level.bot_hp_allow_predictive_capping) {
      var_2 = level.zonemovetime - gettime();

      if(var_2 > 0 && var_2 < 10000) {
        var_3 = level.zone.gameobject maps\mp\gametypes\_gameobjects::getownerteam() == self.team;

        if(!var_3) {
          var_4 = level.zone.zone_bounds.radius * 6;

          if(var_2 < 5000)
            var_4 = level.zone.zone_bounds.radius * 3;

          var_5 = distance(level.zone.zone_bounds.center, self.origin);

          if(var_5 > var_4)
            var_0 = bot_should_cap_next_zone();
        } else {
          var_6 = maps\mp\bots\_bots_util::bot_get_max_players_on_team(self.team);
          var_7 = ceil(var_6 / 2);

          if(var_2 < 5000)
            var_7 = ceil(var_6 / 3);

          var_8 = bot_get_num_teammates_capturing_zone(level.zone);

          if(var_8 + 1 > var_7)
            var_0 = bot_should_cap_next_zone();
        }
      }
    }

    var_9 = level.zone;

    if(isdefined(var_0) && var_0)
      var_9 = level.zones[(level.prevzoneindex + 1) % level.zones.size];

    if(!bot_is_capturing_zone(var_9))
      bot_capture_hp_zone(var_9);
  }
}

bot_should_cap_next_zone() {
  if(level.randomzonespawn)
    return 0;
  else {
    var_0 = self botgetdifficultysetting("strategyLevel");
    var_1 = 0;

    if(var_0 == 1)
      var_1 = 0.1;
    else if(var_0 == 2)
      var_1 = 0.5;
    else if(var_0 == 3)
      var_1 = 0.8;

    return randomfloat(1.0) < var_1;
  }
}

bot_get_num_teammates_capturing_zone(var_0) {
  return bot_get_teammates_capturing_zone(var_0).size;
}

bot_get_teammates_capturing_zone(var_0) {
  var_1 = [];

  foreach(var_3 in level.participants) {
    if(var_3 != self && maps\mp\_utility::isteamparticipant(var_3) && isalliedsentient(self, var_3)) {
      if(var_3 istouching(level.zone.trig)) {
        if(!isai(var_3) || var_3 bot_is_capturing_zone(var_0))
          var_1[var_1.size] = var_3;
      }
    }
  }

  return var_1;
}

bot_is_capturing_zone(var_0) {
  if(!maps\mp\bots\_bots_util::bot_is_capturing())
    return 0;

  return self.current_zone == var_0;
}

bot_capture_hp_zone(var_0) {
  self.current_zone = var_0;
  var_1["entrance_points_index"] = var_0.entrance_indices;
  var_1["override_origin_node"] = var_0.center_node;
  maps\mp\bots\_bots_strategy::bot_capture_zone(var_0.origin, var_0.nodes, var_0.trig, var_1);
}

should_start_cautious_approach_hp(var_0) {
  if(var_0) {
    var_1 = level.zone.gameobject maps\mp\gametypes\_gameobjects::getownerteam();

    if(var_1 == "neutral" || var_1 == self.team)
      return 0;
  }

  return maps\mp\bots\_bots_strategy::should_start_cautious_approach_default(var_0);
}