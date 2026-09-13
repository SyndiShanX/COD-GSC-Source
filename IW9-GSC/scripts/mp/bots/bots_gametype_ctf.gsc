/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_ctf.gsc
*************************************************/

main() {
  setup_callbacks();
  setup_bot_ctf();
}

setup_callbacks() {
  level.bot_funcs["crate_can_use"] = ::crate_can_use;
  level.bot_funcs["gametype_think"] = ::bot_ctf_think;
  level.bot_funcs["get_watch_node_chance"] = ::bot_ctf_get_node_chance;
}

setup_bot_ctf() {
  level.bot_gametype_attacker_limit_for_team = ::ctf_bot_attacker_limit_for_team;
  level.bot_gametype_defender_limit_for_team = ::ctf_bot_defender_limit_for_team;
  level.bot_gametype_allied_attackers_for_team = ::get_allied_attackers_for_team;
  level.bot_gametype_allied_defenders_for_team = ::get_allied_defenders_for_team;
  level.bot_gametype_allowed_to_switch_to_defender = ::bot_ctf_can_switch_to_defender;
  level.bot_gametype_human_player_always_attacker = ::bot_ctf_player_always_attacker;
  scripts\mp\bots\bots_util::bot_waittill_bots_enabled();

  while(!isDefined(level.teamflags))
    wait 0.05;

  level.teamflags["allies"].objectivekey = "allies";
  level.teamflags["axis"].objectivekey = "axis";
  _id_7F989E71B934C9FC::bot_cache_entrances_to_gametype_array(level.teamflags, "flag_");
  zone = getzonenearest(level.teamflags["allies"].curorigin);

  if(isDefined(zone))
    botzonesetteam(zone, "allies");

  zone = getzonenearest(level.teamflags["axis"].curorigin);

  if(isDefined(zone))
    botzonesetteam(zone, "axis");

  level.capzones["allies"].nearest_node = level.teamflags["allies"].trigger.nearest_node;
  level.capzones["axis"].nearest_node = level.teamflags["axis"].trigger.nearest_node;
  thread bot_ctf_ai_director_update();
  level.bot_gametype_precaching_done = 1;
}

crate_can_use(crate) {
  if(isagent(self) && !isDefined(crate.boxtype))
    return 0;

  if(bot_ctf_player_has_flag())
    return 0;

  return bot_ctf_flag_is_home_of_team(self.team);
}

bot_ctf_think() {
  self notify("bot_ctf_think");
  self endon("bot_ctf_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  self.next_flag_hide_time = 0;
  self botsetflag("separation", 0);
  self botsetflag("use_obj_path_style", 1);
  set_scripted_pathing_style = 0;
  _id_A4775E629F031993 = 0;

  for(;;) {
    wait 0.05;

    if(self.health <= 0) {
      continue;
    }
    if(!isDefined(self.role))
      _id_7F989E71B934C9FC::bot_gametype_initialize_attacker_defender_role();

    enemy_team = scripts\mp\utility\game::getotherteam(self.team)[0];

    if(bot_ctf_flag_is_home_of_team(self.team)) {
      if(isDefined(level.bot_known_flag_carrier_loc) && isDefined(level.bot_known_flag_carrier_loc[enemy_team]))
        level.bot_known_flag_carrier_loc[enemy_team] = undefined;
    }

    _id_B3E8AEB3E9FE5518 = 0;

    if(self.role == "attacker") {
      if(bot_ctf_player_has_flag())
        _id_B3E8AEB3E9FE5518 = 1;
      else if(!bot_ctf_enemy_team_flag_is_picked_up())
        _id_B3E8AEB3E9FE5518 = distancesquared(self.origin, level.teamflags[enemy_team].curorigin) < squared(get_flag_protect_radius());
    } else if(!bot_ctf_flag_is_home_of_team(self.team))
      _id_B3E8AEB3E9FE5518 = !bot_ctf_my_team_flag_is_picked_up();

    self botsetflag("force_sprint", _id_B3E8AEB3E9FE5518);
    _id_A4775E629F031993 = 0;

    if(bot_ctf_player_has_flag()) {
      if(bot_ctf_flag_is_home_of_team(self.team)) {
        clear_defend();
        _id_A4775E629F031993 = 1;

        if(!set_scripted_pathing_style) {
          set_scripted_pathing_style = 1;
          self botsetpathingstyle("scripted");
        }

        self botsetscriptgoal(level.capzones[self.team].curorigin, 16, "critical");
      } else if(_id_7F989E71B934C9FC::bot_gametype_get_num_players_on_team(self.team) == 1)
        bot_ctf_recover_flag();
      else if(gettime() > self.next_flag_hide_time) {
        clear_defend();
        nodes = getnodesinradius(level.capzones[self.team].curorigin, 900, 0, 300);
        _id_7E939D9754FB78DE = self botnodepick(nodes, nodes.size * 0.15, "node_hide_anywhere");

        if(!isDefined(_id_7E939D9754FB78DE))
          _id_7E939D9754FB78DE = level.capzones[self.team].nearest_node;

        success = self botsetscriptgoalnode(_id_7E939D9754FB78DE, "critical");

        if(success)
          self.next_flag_hide_time = gettime() + 15000;
      }
    } else if(self.role == "attacker") {
      if(bot_ctf_enemy_team_flag_is_picked_up()) {
        if(!scripts\mp\bots\bots_util::bot_is_bodyguarding()) {
          clear_defend();
          self botclearscriptgoal();
          _id_85BA43086F4DDE82 = level.teamflags[enemy_team].carrier;
          scripts\mp\bots\bots_strategy::bot_guard_player(_id_85BA43086F4DDE82, 500);
        }
      } else {
        clear_defend();

        if(self botgetscriptgoaltype() == "critical")
          self botclearscriptgoal();

        self botsetscriptgoal(level.teamflags[enemy_team].curorigin, 16, "objective", undefined, 300);
      }
    } else if(!bot_ctf_flag_is_home_of_team(self.team))
      bot_ctf_recover_flag();
    else if(!is_protecting_flag()) {
      self botclearscriptgoal();
      optional_params["score_flags"] = "strict_los";
      optional_params["entrance_points_index"] = "flag_" + level.teamflags[self.team].objectivekey;
      optional_params["nearest_node_to_center"] = level.teamflags[self.team].trigger.nearest_node;
      scripts\mp\bots\bots_strategy::bot_protect_point(level.teamflags[self.team].curorigin, get_flag_protect_radius(), optional_params);
    }

    if(set_scripted_pathing_style && !_id_A4775E629F031993) {
      set_scripted_pathing_style = 0;
      self botsetpathingstyle(undefined);
    }
  }
}

bot_ctf_recover_flag() {
  _id_DB965920AA486082 = undefined;
  _id_F1826F769CFE617A = level.teamflags[self.team];
  _id_C80369FC0F449358 = _id_F1826F769CFE617A.carrier;

  if(!isDefined(_id_C80369FC0F449358))
    _id_DB965920AA486082 = _id_F1826F769CFE617A.curorigin;
  else if(self botcanseeentity(_id_C80369FC0F449358)) {
    _id_DB965920AA486082 = _id_C80369FC0F449358.origin;

    if(self botgetdifficultysetting("strategyLevel") > 0 && !bot_ctf_flag_is_home_of_team(self.team)) {
      if(!isDefined(level.bot_known_flag_carrier_loc))
        level.bot_known_flag_carrier_loc = [];

      if(!isDefined(level.bot_known_flag_carrier_loc[_id_C80369FC0F449358.team]))
        level.bot_known_flag_carrier_loc[_id_C80369FC0F449358.team] = [];

      level.bot_known_flag_carrier_loc[_id_C80369FC0F449358.team]["origin"] = _id_DB965920AA486082;
      level.bot_known_flag_carrier_loc[_id_C80369FC0F449358.team]["time"] = gettime();
    }
  } else if(isDefined(_id_F1826F769CFE617A.curcarrierorigin)) {
    if(isDefined(_id_F1826F769CFE617A.compassicons["friendly"])) {
      if(_id_F1826F769CFE617A.objidpingfriendly)
        _id_DB965920AA486082 = _id_F1826F769CFE617A.curcarrierorigin;
      else
        _id_DB965920AA486082 = _id_C80369FC0F449358.origin;
    }
  } else
    _id_DB965920AA486082 = _id_F1826F769CFE617A.curorigin;

  if(isDefined(_id_DB965920AA486082)) {
    clear_defend();
    self botsetscriptgoal(_id_DB965920AA486082, 16, "critical");
  } else {
    _id_C74E2E565EE3FE18 = undefined;
    _id_3AD830DC9D89106D = undefined;

    if(self botgetdifficultysetting("strategyLevel") > 0) {
      if(isDefined(level.bot_known_flag_carrier_loc) && isDefined(level.bot_known_flag_carrier_loc[_id_C80369FC0F449358.team])) {
        _id_3AD830DC9D89106D = gettime() - level.bot_known_flag_carrier_loc[_id_C80369FC0F449358.team]["time"];

        if(_id_3AD830DC9D89106D < 10000)
          _id_C74E2E565EE3FE18 = level.bot_known_flag_carrier_loc[_id_C80369FC0F449358.team]["origin"];
      }
    }

    if(isDefined(_id_C74E2E565EE3FE18)) {
      if(_id_3AD830DC9D89106D < 5000) {
        clear_defend();
        self botsetscriptgoal(_id_C74E2E565EE3FE18, 16, "critical");
      } else if(!scripts\mp\bots\bots_util::bot_is_patrolling()) {
        scripts\mp\bots\bots_strategy::bot_defend_stop();
        scripts\mp\bots\bots_strategy::bot_patrol_area(_id_C74E2E565EE3FE18, 400);
      }
    } else {
      clear_defend();
      _id_E7073093C8C51701 = self botgetscriptgoaltype();

      if(_id_E7073093C8C51701 == "objective" || _id_E7073093C8C51701 == "critical")
        self botclearscriptgoal();

      scripts\mp\bots\bots_personality::update_personality_default();
    }
  }
}

clear_defend() {
  if(scripts\mp\bots\bots_util::bot_is_defending())
    scripts\mp\bots\bots_strategy::bot_defend_stop();
}

is_protecting_flag() {
  return scripts\mp\bots\bots_util::bot_is_protecting();
}

get_flag_protect_radius() {
  if(isalive(self) && !isDefined(level.protect_radius)) {
    _id_FA52693CF4679C62 = self botgetworldsize();
    _id_DD6786927BDE6332 = (_id_FA52693CF4679C62[0] + _id_FA52693CF4679C62[1]) / 2;
    level.protect_radius = min(800, _id_DD6786927BDE6332 / 5.5);
  }

  if(!isDefined(level.protect_radius))
    return 900;

  return level.protect_radius;
}

ctf_bot_attacker_limit_for_team(team) {
  _id_6ACE8681F94CDC7C = _id_7F989E71B934C9FC::bot_gametype_get_num_players_on_team(team);

  if(_id_6ACE8681F94CDC7C == 1)
    return 1;

  if(bot_ctf_flag_is_home_of_team(team))
    _id_5995918EC569A5B3 = _id_6ACE8681F94CDC7C * 0.67;
  else {
    enemy_team = scripts\mp\utility\game::getotherteam(team)[0];

    if(bot_ctf_flag_is_home_of_team(enemy_team))
      _id_5995918EC569A5B3 = _id_6ACE8681F94CDC7C * 0.5;
    else
      _id_5995918EC569A5B3 = _id_6ACE8681F94CDC7C * 0.4;
  }

  _id_363DA16EB06140FE = int(scripts\mp\utility\script::roundup(_id_5995918EC569A5B3));
  _id_CD5052914E11EB6A = game["teamScores"][team];
  _id_5A293D5E08A8B462 = game["teamScores"][scripts\engine\utility::get_enemy_team(team)];

  if(_id_CD5052914E11EB6A + 1 < _id_5A293D5E08A8B462)
    _id_363DA16EB06140FE = int(min(_id_363DA16EB06140FE + 1, _id_6ACE8681F94CDC7C));

  return _id_363DA16EB06140FE;
}

ctf_bot_defender_limit_for_team(team) {
  _id_6ACE8681F94CDC7C = _id_7F989E71B934C9FC::bot_gametype_get_num_players_on_team(team);
  return _id_6ACE8681F94CDC7C - ctf_bot_attacker_limit_for_team(team);
}

get_allied_attackers_for_team(team) {
  return _id_7F989E71B934C9FC::bot_gametype_get_allied_attackers_for_team(team, level.capzones[team].curorigin, get_flag_protect_radius());
}

get_allied_defenders_for_team(team) {
  return _id_7F989E71B934C9FC::bot_gametype_get_allied_defenders_for_team(team, level.capzones[team].curorigin, get_flag_protect_radius());
}

bot_ctf_ai_director_update() {
  level notify("bot_ctf_ai_director_update");
  level endon("bot_ctf_ai_director_update");
  level endon("game_ended");
  thread _id_7F989E71B934C9FC::bot_gametype_attacker_defender_ai_director_update();
}

bot_ctf_get_node_chance(node) {
  if(node == self.node_closest_to_defend_center)
    return 1.0;

  if(!is_protecting_flag())
    return 1.0;

  _id_4DB0BB626FC52479 = node scripts\mp\bots\bots_util::node_is_on_path_from_labels("flag_allies", "flag_axis");

  if(_id_4DB0BB626FC52479)
    return 1.0;

  return 0.2;
}

bot_ctf_flag_is_home_of_team(team) {
  return level.teamflags[team] scripts\mp\gameobjects::ishome();
}

bot_ctf_flag_picked_up_of_team(team) {
  return isDefined(level.teamflags[team].carrier);
}

bot_ctf_my_team_flag_is_picked_up() {
  return bot_ctf_flag_picked_up_of_team(self.team);
}

bot_ctf_enemy_team_flag_is_picked_up() {
  enemy_team = scripts\mp\utility\game::getotherteam(self.team)[0];
  return bot_ctf_flag_picked_up_of_team(enemy_team);
}

bot_ctf_player_has_flag() {
  return isDefined(self.carryflag);
}

bot_ctf_can_switch_to_defender() {
  if(bot_ctf_player_has_flag())
    return 0;

  return 1;
}

bot_ctf_player_always_attacker() {
  if(bot_ctf_player_has_flag())
    return 1;

  return 0;
}