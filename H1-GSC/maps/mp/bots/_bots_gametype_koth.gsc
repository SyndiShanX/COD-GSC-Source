/************************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_koth.gsc
************************************************/

main() {
  setup_callbacks();
  bot_koth_start();
}

bot_koth_start() {
  setup_bot_koth();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_koth_think;
  level.bot_funcs["should_start_cautious_approach"] = ::should_start_cautious_approach_koth;
}

setup_bot_koth() {
  maps\mp\bots\_bots_util::bot_waittill_bots_enabled();
  var_0 = 0;

  for (var_1 = 0; var_1 < level.radios.size; var_1++) {
    var_2 = level.radios[var_1];
    var_2.script_label = "radio_" + var_1;
    var_2 thread maps\mp\bots\_bots_gametype_common::monitor_zone_control();
    var_3 = 0;

    if(isdefined(var_2.trig.trigger_off) && var_2.trig.trigger_off) {
      var_2.trig common_scripts\utility::trigger_on();
      var_3 = 1;
    }

    var_4 = 0;

    if(!var_2.visible) {
      var_2 maps\mp\gametypes\koth::makeradiovisible();
      var_4 = 1;
    }

    var_2.nodes = maps\mp\bots\_bots_gametype_common::bot_get_valid_nodes_in_trigger(var_2.trig);

    if(var_3)
      var_2.trig common_scripts\utility::trigger_off();

    if(var_4)
      var_2 maps\mp\gametypes\koth::makeradioinvisible();
  }

  level.bot_set_zone_nodes = 1;

  if(!var_0) {
    var_5 = find_current_radio();

    if(!isdefined(var_5))
      var_5 = common_scripts\utility::random(level.radios);

    maps\mp\bots\_bots_gametype_common::bot_cache_entrances_to_zones([var_5]);
    level.bot_gametype_radios_precached[var_5 getentitynumber()] = 1;
    level.bot_gametype_precaching_done = 1;
    thread bot_cache_entrances_to_other_radios(var_5);
  }
}

bot_cache_entrances_to_other_radios(var_0) {
  for (var_1 = common_scripts\utility::array_remove(level.radios, var_0); var_1.size > 0; var_1 = common_scripts\utility::array_remove(var_1, var_2)) {
    var_2 = undefined;
    var_3 = find_current_radio();

    if(isdefined(var_3) && common_scripts\utility::array_contains(var_1, var_3))
      var_2 = var_3;
    else
      var_2 = common_scripts\utility::random(var_1);

    maps\mp\bots\_bots_gametype_common::bot_cache_entrances_to_zones([var_2]);
    level.bot_gametype_radios_precached[var_2 getentitynumber()] = 1;
  }
}

bot_koth_think() {
  self notify("bot_koth_think");
  self endon("bot_koth_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while (!isdefined(level.bot_gametype_precaching_done))
    wait 0.05;

  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);

  for (;;) {
    wait 0.05;

    if(self.health <= 0) {
      continue;
    }
    var_0 = find_current_radio();

    if(!isdefined(var_0) || !isdefined(level.bot_gametype_radios_precached[var_0 getentitynumber()])) {
      bot_clear_koth_zone();
      self[[self.personality_update_function]]();
      continue;
    }

    var_1 = level.radioobject maps\mp\gametypes\_gameobjects::getownerteam();

    if(self.team != var_1) {
      if(!bot_is_capturing_koth_zone(var_0))
        bot_capture_koth_zone(var_0);

      continue;
    }

    var_2 = common_scripts\utility::get_enemy_team(self.team);
    var_3 = level.radioobject.touchlist[var_2].size > 0;

    if(var_3) {
      if(!bot_is_capturing_koth_zone(var_0))
        bot_capture_koth_zone(var_0);

      continue;
    }

    if(!bot_is_protecting_koth_zone(var_0)) {
      if(bot_is_capturing_koth_zone(var_0)) {
        wait(randomfloat(2));
        bot_clear_koth_zone();
        continue;
      }

      bot_protect_koth_zone(var_0);
    }
  }
}

find_current_radio() {
  foreach(var_1 in level.radios) {
    if(isdefined(level.radioobject) && var_1.trig == level.radioobject.trigger)
      return var_1;
  }
}

bot_is_capturing_koth_zone(var_0) {
  if(!maps\mp\bots\_bots_util::bot_is_capturing())
    return 0;

  return isdefined(self.current_zone) && self.current_zone == var_0;
}

bot_is_protecting_koth_zone(var_0) {
  if(!maps\mp\bots\_bots_util::bot_is_protecting())
    return 0;

  return isdefined(self.current_zone) && self.current_zone == var_0;
}

bot_capture_koth_zone(var_0) {
  self.current_zone = var_0;
  var_1["entrance_points_index"] = var_0.entrance_indices;
  var_1["override_origin_node"] = var_0.center_node;
  maps\mp\bots\_bots_strategy::bot_capture_zone(var_0.origin, var_0.nodes, var_0.trig, var_1);
}

bot_protect_koth_zone(var_0) {
  self.current_zone = var_0;
  var_1 = length(var_0.zone_bounds.half_size) * 2;
  var_2["override_origin_node"] = var_0.center_node;
  maps\mp\bots\_bots_strategy::bot_protect_point(var_0.center_node.origin, var_1, var_2);
}

bot_clear_koth_zone() {
  if(maps\mp\bots\_bots_util::bot_is_defending())
    maps\mp\bots\_bots_strategy::bot_defend_stop();

  self.current_zone = undefined;
}

should_start_cautious_approach_koth(var_0) {
  if(var_0) {
    var_1 = level.radioobject maps\mp\gametypes\_gameobjects::getownerteam();

    if(var_1 == "neutral" || var_1 == self.team)
      return 0;
  }

  return maps\mp\bots\_bots_strategy::should_start_cautious_approach_default(var_0);
}