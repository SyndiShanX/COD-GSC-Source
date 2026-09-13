/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_hq.gsc
************************************************/

main() {
  setup_callbacks();
  bot_hq_start();
}

bot_hq_start() {
  setup_bot_hq();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_hq_think;
  level.bot_funcs["should_start_cautious_approach"] = ::should_start_cautious_approach_hq;
}

setup_bot_hq() {
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();
  _id_794C62D4A40CACBD = 0;

  foreach(objective in level.objectives) {
    objective thread _id_7F989E71B934C9FC::monitor_zone_control();
    _id_C24B62A774E2496B = 0;

    if(istrue(objective.trigger.trigger_off)) {
      objective.trigger scripts\engine\utility::trigger_on();
      _id_C24B62A774E2496B = 1;
    }

    objective.nodes = _id_7F989E71B934C9FC::bot_get_valid_nodes_in_trigger(objective.trigger);

    if(_id_C24B62A774E2496B)
      objective.trigger scripts\engine\utility::trigger_off();
  }

  level.bot_set_zone_nodes = 1;

  if(!_id_794C62D4A40CACBD) {
    _id_0A8A529C46AF43D6 = find_current_radio();

    if(!isDefined(_id_0A8A529C46AF43D6))
      _id_0A8A529C46AF43D6 = scripts\engine\utility::random(level.objectives);

    _id_7F989E71B934C9FC::bot_cache_entrances_to_zones([_id_0A8A529C46AF43D6]);
    level.bot_gametype_radios_precached[_id_0A8A529C46AF43D6.trigger getentitynumber()] = 1;
    level.bot_gametype_precaching_done = 1;
    thread bot_cache_entrances_to_other_radios(_id_0A8A529C46AF43D6);
  }
}

bot_cache_entrances_to_other_radios(_id_4BD8B490F1D21801) {
  for(_id_E82E204DBA2AC737 = scripts\engine\utility::array_remove(level.objectives, _id_4BD8B490F1D21801); _id_E82E204DBA2AC737.size > 0; _id_E82E204DBA2AC737 = scripts\engine\utility::array_remove(_id_E82E204DBA2AC737, _id_4687ED96EC4DD607)) {
    _id_4687ED96EC4DD607 = undefined;
    _id_0A8A529C46AF43D6 = find_current_radio();

    if(isDefined(_id_0A8A529C46AF43D6) && scripts\engine\utility::array_contains(_id_E82E204DBA2AC737, _id_0A8A529C46AF43D6))
      _id_4687ED96EC4DD607 = _id_0A8A529C46AF43D6;
    else
      _id_4687ED96EC4DD607 = scripts\engine\utility::random(_id_E82E204DBA2AC737);

    _id_7F989E71B934C9FC::bot_cache_entrances_to_zones([_id_4687ED96EC4DD607]);
    level.bot_gametype_radios_precached[_id_4687ED96EC4DD607.trigger getentitynumber()] = 1;
  }
}

bot_hq_think() {
  self notify("bot_hq_think");
  self endon("bot_hq_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);

  for(;;) {
    wait 0.05;

    if(self.health <= 0) {
      continue;
    }
    _id_0A8A529C46AF43D6 = find_current_radio();

    if(!isDefined(_id_0A8A529C46AF43D6) || !istrue(_id_0A8A529C46AF43D6.active) || !isDefined(level.bot_gametype_radios_precached[_id_0A8A529C46AF43D6.trigger getentitynumber()])) {
      bot_clear_hq_zone();
      self[[self.personality_update_function]]();
      continue;
    }

    _id_B3757ACF241CF25B = level.zone scripts\mp\gameobjects::getownerteam();

    if(self.team != _id_B3757ACF241CF25B) {
      if(!bot_is_capturing_hq_zone(_id_0A8A529C46AF43D6))
        bot_capture_hq_zone(_id_0A8A529C46AF43D6);

      continue;
    }

    enemy_team = scripts\engine\utility::get_enemy_team(self.team);
    _id_5C16102FDFF3E853 = level.zone.touchlist[enemy_team].size > 0;

    if(_id_5C16102FDFF3E853) {
      if(!bot_is_capturing_hq_zone(_id_0A8A529C46AF43D6))
        bot_capture_hq_zone(_id_0A8A529C46AF43D6);

      continue;
    }

    if(!bot_is_protecting_hq_zone(_id_0A8A529C46AF43D6)) {
      if(bot_is_capturing_hq_zone(_id_0A8A529C46AF43D6)) {
        wait(randomfloat(2));
        bot_clear_hq_zone();
        continue;
      }

      bot_protect_hq_zone(_id_0A8A529C46AF43D6);
    }
  }
}

find_current_radio() {
  foreach(radio in level.objectives) {
    if(isDefined(level.zone) && radio.trigger == level.zone.trigger)
      return radio;
  }
}

bot_is_capturing_hq_zone(zone) {
  if(!scripts\mp\bots\bots_util::bot_is_capturing())
    return 0;

  return isDefined(self.current_zone) && self.current_zone == zone;
}

bot_is_protecting_hq_zone(zone) {
  if(!scripts\mp\bots\bots_util::bot_is_protecting())
    return 0;

  return isDefined(self.current_zone) && self.current_zone == zone;
}

bot_capture_hq_zone(zone) {
  self.current_zone = zone;
  optional_params["entrance_points_index"] = zone.entrance_indices;
  optional_params["override_origin_node"] = zone.center_node;
  scripts\mp\bots\bots_strategy::bot_capture_zone(zone.trigger.origin, zone.nodes, zone.trigger, optional_params);
}

bot_protect_hq_zone(zone) {
  self.current_zone = zone;
  _id_376B1E7B1E7525F2 = length(zone.zone_bounds.half_size) * 2;
  optional_params["override_origin_node"] = zone.center_node;
  scripts\mp\bots\bots_strategy::bot_protect_point(zone.center_node.origin, _id_376B1E7B1E7525F2, optional_params);
}

bot_clear_hq_zone() {
  if(scripts\mp\bots\bots_util::bot_is_defending())
    scripts\mp\bots\bots_strategy::bot_defend_stop();

  self.current_zone = undefined;
}

should_start_cautious_approach_hq(_id_44770B14726E7A47) {
  if(_id_44770B14726E7A47) {
    team = level.zone scripts\mp\gameobjects::getownerteam();

    if(team == "neutral" || team == self.team)
      return 0;
  }

  return scripts\mp\bots\bots_strategy::should_start_cautious_approach_default(_id_44770B14726E7A47);
}