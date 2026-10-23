/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_gametype_ctf.gsc
*******************************************************/

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
  level.bot_gametype_allied_attackers_for_team = ::_id_4091;
  level.bot_gametype_allied_defenders_for_team = ::_id_4092;
  level.bot_gametype_allowed_to_switch_to_defender = ::_id_1984;
  level.bot_gametype_human_player_always_attacker = ::_id_1990;
  maps\mp\bots\_bots_util::bot_waittill_bots_enabled();

  while(!isDefined(level.teamflags)) {
    waitframe();
  }

  level.teamflags["allies"].shootblank = "allies";
  level.teamflags["axis"].shootblank = "axis";
  maps\mp\bots\_bots_gametype_common::bot_cache_entrances_to_gametype_array(level.teamflags, "flag_");
  var_0 = _getzonenearest(level.teamflags["allies"].origin);

  if(isDefined(var_0)) {
    _botzonesetteam(var_0, "allies");
  }

  var_0 = _getzonenearest(level.teamflags["axis"].origin);

  if(isDefined(var_0)) {
    _botzonesetteam(var_0, "axis");
  }

  level.capzones["allies"].nearest_node = level.teamflags["allies"].nearest_node;
  level.capzones["axis"].nearest_node = level.teamflags["axis"].nearest_node;
  thread bot_ctf_ai_director_update();
  level.bot_gametype_precaching_done = 1;
}

crate_can_use(var_0) {
  if(_isagent(self) && !isDefined(var_0.boxtype)) {
    return 0;
  }

  if(_id_1991()) {
    return 0;
  }

  return _id_1986(self.team);
}

bot_ctf_think() {
  self notify("bot_ctf_think");
  self endon("bot_ctf_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done)) {
    waitframe();
  }

  self.next_flag_hide_time = 0;
  self botsetflag("separation", 0);
  self botsetflag("use_obj_path_style", 1);
  var_0 = 0;
  var_1 = 0;

  for(;;) {
    waitframe();

    if(self.health <= 0) {
      continue;
    }
    if(!isDefined(self.role)) {
      maps\mp\bots\_bots_gametype_common::bot_gametype_initialize_attacker_defender_role();
    }

    if(_id_1986(self.team)) {
      if(isDefined(level._id_1A53) && isDefined(level._id_1A53[level.otherteam[self.team]])) {
        level._id_1A53[level.otherteam[self.team]] = undefined;
      }
    }

    var_2 = 0;

    if(self.role == "attacker") {
      if(_id_1991()) {
        var_2 = 1;
      } else if(!_id_1985()) {
        var_2 = distancesquared(self.origin, level.teamflags[level.otherteam[self.team]].curorigin) < _squared(get_flag_protect_radius());
      }
    } else if(!_id_1986(self.team))
      var_2 = !_id_1989();

    self botsetflag("force_sprint", var_2);
    var_1 = 0;

    if(_id_1991()) {
      if(_id_1986(self.team)) {
        clear_defend();
        var_1 = 1;

        if(!var_0) {
          var_0 = 1;
          self botsetpathingstyle("scripted");
        }

        self botsetscriptgoal(level.capzones[self.team].curorigin, 16, "critical");
      } else if(maps\mp\bots\_bots_gametype_common::bot_gametype_get_num_players_on_team(self.team) == 1)
        _id_1992();
      else if(gettime() > self.next_flag_hide_time) {
        clear_defend();
        var_3 = _getnodesinradius(level.capzones[self.team].curorigin, 900, 0, 300);
        var_4 = self botnodepick(var_3, var_3.size * 0.15, "node_hide_anywhere");

        if(!isDefined(var_4)) {
          var_4 = level.capzones[self.team].nearest_node;
        }

        var_5 = self botsetscriptgoalnode(var_4, "critical");

        if(var_5) {
          self.next_flag_hide_time = gettime() + 15000;
        }
      }
    } else if(self.role == "attacker") {
      if(_id_1985()) {
        if(!maps\mp\bots\_bots_util::bot_is_bodyguarding()) {
          clear_defend();
          self botclearscriptgoal();
          var_6 = level.teamflags[level.otherteam[self.team]].carrier;
          maps\mp\bots\_bots_strategy::bot_guard_player(var_6, 500);
        }
      } else {
        clear_defend();

        if(self botgetscriptgoaltype() == "critical") {
          self botclearscriptgoal();
        }

        self botsetscriptgoal(level.teamflags[level.otherteam[self.team]].curorigin, 16, "objective", undefined, 300);
      }
    } else if(!_id_1986(self.team))
      _id_1992();
    else if(!is_protecting_flag()) {
      self botclearscriptgoal();
      var_7["score_flags"] = "strict_los";
      var_7["entrance_points_index"] = "flag_" + level.teamflags[self.team].shootblank;
      var_7["nearest_node_to_center"] = level.teamflags[self.team].nearest_node;
      maps\mp\bots\_bots_strategy::bot_protect_point(level.teamflags[self.team].curorigin, get_flag_protect_radius(), var_7);
    }

    if(var_0 && !var_1) {
      var_0 = 0;
      self botsetpathingstyle(undefined);
    }
  }
}

_id_1992() {
  var_0 = undefined;
  var_1 = level.teamflags[self.team];
  var_2 = var_1.carrier;

  if(!isDefined(var_2)) {
    var_0 = var_1.curorigin;
  } else if(self botcanseeentity(var_2)) {
    var_0 = var_2.origin;

    if(self botgetdifficultysetting("strategyLevel") > 0 && !_id_1986(self.team)) {
      if(!isDefined(level._id_1A53)) {
        level._id_1A53 = [];
      }

      if(!isDefined(level._id_1A53[var_2.team])) {
        level._id_1A53[var_2.team] = [];
      }

      level._id_1A53[var_2.team]["origin"] = var_0;
      level._id_1A53[var_2.team]["time"] = gettime();
    }
  } else if(isDefined(var_1.curcarrierorigin)) {
    if(isDefined(var_1.compassicons["friendly"])) {
      if(var_1.objidpingfriendly) {
        var_0 = var_1.curcarrierorigin;
      } else {
        var_0 = var_2.origin;
      }
    }
  } else
    var_0 = var_1.curorigin;

  if(isDefined(var_0)) {
    clear_defend();
    self botsetscriptgoal(var_0, 16, "critical");
  } else {
    var_3 = undefined;
    var_4 = undefined;

    if(self botgetdifficultysetting("strategyLevel") > 0) {
      if(isDefined(level._id_1A53) && isDefined(level._id_1A53[var_2.team])) {
        var_4 = gettime() - level._id_1A53[var_2.team]["time"];

        if(var_4 < 10000) {
          var_3 = level._id_1A53[var_2.team]["origin"];
        }
      }
    }

    if(isDefined(var_3)) {
      if(var_4 < 5000) {
        clear_defend();
        self botsetscriptgoal(var_3, 16, "critical");
      } else if(!maps\mp\bots\_bots_util::bot_is_patrolling()) {
        maps\mp\bots\_bots_strategy::bot_defend_stop();
        maps\mp\bots\_bots_strategy::bot_patrol_area(var_3, 400);
      }
    } else {
      clear_defend();
      var_5 = self botgetscriptgoaltype();

      if(var_5 == "objective" || var_5 == "critical") {
        self botclearscriptgoal();
      }

      maps\mp\bots\_bots_personality::update_personality_default();
    }
  }
}

clear_defend() {
  if(maps\mp\bots\_bots_util::bot_is_defending()) {
    maps\mp\bots\_bots_strategy::bot_defend_stop();
  }
}

is_protecting_flag() {
  return maps\mp\bots\_bots_util::bot_is_protecting();
}

get_flag_protect_radius() {
  if(isalive(self) && !isDefined(level.protect_radius)) {
    var_0 = self botgetworldsize();
    var_1 = (var_0[0] + var_0[1]) / 2;
    level.protect_radius = _min(800, var_1 / 5.5);
  }

  if(!isDefined(level.protect_radius)) {
    return 900;
  }

  return level.protect_radius;
}

ctf_bot_attacker_limit_for_team(var_0) {
  var_1 = maps\mp\bots\_bots_gametype_common::bot_gametype_get_num_players_on_team(var_0);

  if(var_1 == 1) {
    return 1;
  }

  if(_id_1986(var_0)) {
    var_2 = var_1 * 0.67;
  } else if(_id_1986(level.otherteam[var_0])) {
    var_2 = var_1 * 0.5;
  } else {
    var_2 = var_1 * 0.4;
  }

  var_3 = int(_round(var_2));
  var_4 = game["teamScores"][var_0];
  var_5 = game["teamScores"][common_scripts\utility::get_enemy_team(var_0)];

  if(var_4 + 1 < var_5) {
    var_3 = int(_min(var_3 + 1, var_1));
  }

  return var_3;
}

ctf_bot_defender_limit_for_team(var_0) {
  var_1 = maps\mp\bots\_bots_gametype_common::bot_gametype_get_num_players_on_team(var_0);
  return var_1 - ctf_bot_attacker_limit_for_team(var_0);
}

_id_4091(var_0) {
  return maps\mp\bots\_bots_gametype_common::bot_gametype_get_allied_attackers_for_team(var_0, level.capzones[var_0].curorigin, get_flag_protect_radius());
}

_id_4092(var_0) {
  return maps\mp\bots\_bots_gametype_common::bot_gametype_get_allied_defenders_for_team(var_0, level.capzones[var_0].curorigin, get_flag_protect_radius());
}

bot_ctf_ai_director_update() {
  level notify("bot_ctf_ai_director_update");
  level endon("bot_ctf_ai_director_update");
  level endon("game_ended");
  thread maps\mp\bots\_bots_gametype_common::bot_gametype_attacker_defender_ai_director_update();
}

bot_ctf_get_node_chance(var_0) {
  if(var_0 == self.node_closest_to_defend_center) {
    return 1.0;
  }

  if(!is_protecting_flag()) {
    return 1.0;
  }

  var_1 = var_0 maps\mp\bots\_bots_util::node_is_on_path_from_labels("flag_allies", "flag_axis");

  if(var_1) {
    return 1.0;
  }

  return 0.2;
}

_id_1986(var_0) {
  return level.teamflags[var_0] _id_04D1::ishome();
}

_id_1987(var_0) {
  return isDefined(level.teamflags[var_0].carrier);
}

_id_1989() {
  return _id_1987(self.team);
}

_id_1985() {
  return _id_1987(level.otherteam[self.team]);
}

_id_1991() {
  return isDefined(self.carryflag);
}

_id_1984() {
  if(_id_1991()) {
    return 0;
  }

  return 1;
}

_id_1990() {
  if(_id_1991()) {
    return 1;
  }

  return 0;
}