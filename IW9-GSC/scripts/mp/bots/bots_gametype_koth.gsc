/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_koth.gsc
**************************************************/

main() {
  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587() && !getdvarint("dvar_131A7029DB1ED456", 0)) {
    _id_26508F2DE04C7A52::_id_892DB361940E142D();
    return;
  }

  setup_callbacks();
  setup_bot_koth();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_koth_think;
  level.bot_funcs["should_start_cautious_approach"] = ::should_start_cautious_approach_koth;

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587() && getdvarint("dvar_131A7029DB1ED456", 0)) {
    level.bot_funcs["player_spawned_gamemode"] = _id_27FDECE778E999D8::_id_5F51C5C13FD2911B;
    level.modifyplayerdamage = _id_27FDECE778E999D8::modifyplayerdamage;
  }
}

setup_bot_koth() {
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
    level.bot_hp_allow_predictive_capping = 1;
    _id_88D0B3970808D066 = level.zone;

    if(!isDefined(_id_88D0B3970808D066))
      _id_88D0B3970808D066 = scripts\engine\utility::random(level.objectives);

    _id_7F989E71B934C9FC::bot_cache_entrances_to_zones([_id_88D0B3970808D066]);
    level.bot_gametype_zones_precached[_id_88D0B3970808D066.trigger getentitynumber()] = 1;
    level.bot_gametype_precaching_done = 1;
    thread bot_cache_entrances_to_other_zones(_id_88D0B3970808D066);
  }
}

bot_cache_entrances_to_other_zones(_id_A39BA4E297C944AC) {
  for(_id_1AF20A675DEC3E10 = scripts\engine\utility::array_remove(level.objectives, _id_A39BA4E297C944AC); _id_1AF20A675DEC3E10.size > 0; _id_1AF20A675DEC3E10 = scripts\engine\utility::array_remove(_id_1AF20A675DEC3E10, _id_BFA517469DBF11EE)) {
    _id_BFA517469DBF11EE = undefined;
    current_zone = level.zone;

    if(isDefined(current_zone) && scripts\engine\utility::array_contains(_id_1AF20A675DEC3E10, current_zone))
      _id_BFA517469DBF11EE = current_zone;
    else
      _id_BFA517469DBF11EE = scripts\engine\utility::random(_id_1AF20A675DEC3E10);

    _id_7F989E71B934C9FC::bot_cache_entrances_to_zones([_id_BFA517469DBF11EE]);
    level.bot_gametype_zones_precached[_id_BFA517469DBF11EE.trigger getentitynumber()] = 1;
  }
}

bot_koth_think() {
  self notify("bot_koth_think");
  self endon("bot_koth_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);
  _id_F89468CD9A401388 = undefined;
  _id_46AAEC4CCF788DAD = level.zone;

  for(;;) {
    wait 0.05;

    if(self.health <= 0) {
      continue;
    }
    if(!isDefined(level.zone) || !isDefined(level.bot_gametype_zones_precached[level.zone.trigger getentitynumber()])) {
      if(scripts\mp\bots\bots_util::bot_is_defending())
        scripts\mp\bots\bots_strategy::bot_defend_stop();

      self.current_zone = undefined;
      self[[self.personality_update_function]]();
      continue;
    }

    if(_id_46AAEC4CCF788DAD != level.zone) {
      _id_F89468CD9A401388 = undefined;
      _id_46AAEC4CCF788DAD = level.zone;
    }

    if(!istrue(level.zone.trigger.trigger_off) && isDefined(level.zoneendtime) && !isDefined(_id_F89468CD9A401388) && !level.zonerandomlocationorder && level.bot_hp_allow_predictive_capping) {
      _id_7A8AE257730D6C26 = level.zoneendtime - gettime();

      if(_id_7A8AE257730D6C26 > 0 && _id_7A8AE257730D6C26 < 10000) {
        _id_5F20A57C87FB6002 = level.zone scripts\mp\gameobjects::getownerteam() == self.team;

        if(!_id_5F20A57C87FB6002) {
          _id_CE5BD620EEDDF1AA = level.zone.zone_bounds.radius * 6;

          if(_id_7A8AE257730D6C26 < 5000)
            _id_CE5BD620EEDDF1AA = level.zone.zone_bounds.radius * 3;

          _id_87F2F08F7437A411 = distance(level.zone.zone_bounds.center, self.origin);

          if(_id_87F2F08F7437A411 > _id_CE5BD620EEDDF1AA)
            _id_F89468CD9A401388 = bot_should_cap_next_zone();
        } else {
          _id_6ACE8681F94CDC7C = scripts\mp\bots\bots_util::bot_get_max_players_on_team(self.team);
          _id_9BBD8A880A88652E = ceil(_id_6ACE8681F94CDC7C / 2);

          if(_id_7A8AE257730D6C26 < 5000)
            _id_9BBD8A880A88652E = ceil(_id_6ACE8681F94CDC7C / 3);

          _id_66DF858E06A4F668 = bot_get_num_teammates_capturing_zone(level.zone);

          if(_id_66DF858E06A4F668 + 1 > _id_9BBD8A880A88652E)
            _id_F89468CD9A401388 = bot_should_cap_next_zone();
        }
      }
    }

    _id_E6065833510C1C0C = level.zone;

    if(istrue(_id_F89468CD9A401388)) {
      _id_9906019056AEEE60 = (level.prevzoneindex + 1) % level.objectives.size;

      if(_id_9906019056AEEE60 == 0)
        _id_9906019056AEEE60 = 1;

      _id_E6065833510C1C0C = level.objectives[scripts\engine\utility::string(_id_9906019056AEEE60)];
    }

    if(!bot_is_capturing_zone(_id_E6065833510C1C0C))
      bot_capture_koth_zone(_id_E6065833510C1C0C);
  }
}

bot_should_cap_next_zone() {
  if(level.zonerandomlocationorder)
    return 0;
  else {
    strategy_level = self botgetdifficultysetting("strategyLevel");
    _id_0B79D6AC8174AFEB = 0;

    if(strategy_level == 1)
      _id_0B79D6AC8174AFEB = 0.1;
    else if(strategy_level == 2)
      _id_0B79D6AC8174AFEB = 0.5;
    else if(strategy_level == 3)
      _id_0B79D6AC8174AFEB = 0.8;

    return randomfloat(1.0) < _id_0B79D6AC8174AFEB;
  }
}

bot_get_num_teammates_capturing_zone(zone) {
  return bot_get_teammates_capturing_zone(zone).size;
}

bot_get_teammates_capturing_zone(zone) {
  _id_25B7E3EA39CD9F57 = [];

  foreach(_id_5ECABDFE40A96663 in level.participants) {
    if(_id_5ECABDFE40A96663 != self && scripts\mp\utility\entity::isteamparticipant(_id_5ECABDFE40A96663) && isalliedsentient(self, _id_5ECABDFE40A96663)) {
      if(_id_5ECABDFE40A96663 istouching(level.zone.trigger)) {
        if(!isai(_id_5ECABDFE40A96663) || _id_5ECABDFE40A96663 bot_is_capturing_zone(zone))
          _id_25B7E3EA39CD9F57[_id_25B7E3EA39CD9F57.size] = _id_5ECABDFE40A96663;
      }
    }
  }

  return _id_25B7E3EA39CD9F57;
}

bot_is_capturing_zone(zone) {
  if(!scripts\mp\bots\bots_util::bot_is_capturing())
    return 0;

  return self.current_zone == zone;
}

bot_capture_koth_zone(zone) {
  self.current_zone = zone;
  optional_params["entrance_points_index"] = zone.entrance_indices;
  optional_params["override_origin_node"] = zone.center_node;
  scripts\mp\bots\bots_strategy::bot_capture_zone(zone.trigger.origin, zone.nodes, zone.trigger, optional_params);
}

should_start_cautious_approach_koth(_id_44770B14726E7A47) {
  if(_id_44770B14726E7A47) {
    team = level.zone scripts\mp\gameobjects::getownerteam();

    if(team == "neutral" || team == self.team)
      return 0;
  }

  return scripts\mp\bots\bots_strategy::should_start_cautious_approach_default(_id_44770B14726E7A47);
}