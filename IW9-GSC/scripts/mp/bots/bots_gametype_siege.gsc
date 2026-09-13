/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_siege.gsc
***************************************************/

main() {
  setup_callbacks();

  if(level.isgroundwarsiege)
    _id_0E494DD5DEBDA9C7::setup_bot_war();
  else {
    thread bot_siege_manager_think();
    setup_bot_siege();
  }
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_siege_think;
}

setup_bot_siege() {
  level.bot_gametype_precaching_done = 1;
}

bot_siege_manager_think() {
  level.siege_bot_team_need_flags = [];
  scripts\mp\flags::gameflagwait("prematch_done");
  level.siege_bot_team_triple_cap_check = [];
  level.siege_bot_team_had_advantage = [];

  for(;;) {
    level.siege_bot_team_need_flags = [];

    foreach(player in level.players) {
      if(!scripts\mp\utility\player::isreallyalive(player) && player.hasspawned) {
        if(player.team != "spectator" && player.team != "neutral")
          level.siege_bot_team_need_flags[player.team] = 1;
      }
    }

    _id_B13458786205DC2B = [];

    foreach(objective in level.objectives) {
      team = objective scripts\mp\gameobjects::getownerteam();

      if(team != "neutral") {
        if(!isDefined(_id_B13458786205DC2B[team])) {
          _id_B13458786205DC2B[team] = 1;
          continue;
        }

        _id_B13458786205DC2B[team]++;
      }
    }

    foreach(team, count in _id_B13458786205DC2B) {
      if(count >= 2) {
        enemyteam = scripts\mp\utility\game::getotherteam(team)[0];
        level.siege_bot_team_need_flags[enemyteam] = 1;

        if(count == 2 && !istrue(level.siege_bot_team_triple_cap_check[team])) {
          if(randomint(100) > 75)
            level.siege_bot_team_need_flags[team] = 1;
          else
            level.siege_bot_team_triple_cap_check[team] = 0;

          level.siege_bot_team_had_advantage[team] = 1;
        }

        continue;
      }

      if(count < 2 && istrue(level.siege_bot_team_had_advantage[team])) {
        level.siege_bot_team_had_advantage[team] = 0;
        level.siege_bot_team_triple_cap_check[team] = 0;
      }
    }

    wait 1.0;
  }
}

bot_siege_think() {
  self notify("bot_siege_think");
  self endon("bot_siege_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done))
    wait 0.05;

  while(!isDefined(level.siege_bot_team_need_flags))
    wait 0.05;

  self botsetflag("separation", 0);
  self botsetflag("use_obj_path_style", 1);

  for(;;) {
    if(isDefined(level.siege_bot_team_need_flags[self.team]) && level.siege_bot_team_need_flags[self.team])
      bot_choose_flag();
    else if(isDefined(self.goalflag)) {
      if(scripts\mp\bots\bots_util::bot_is_defending())
        scripts\mp\bots\bots_strategy::bot_defend_stop();

      self.goalflag = undefined;
    }

    wait 1.0;
  }
}

bot_choose_flag() {
  goalflag = undefined;
  _id_F355C50166CA2903 = undefined;

  foreach(objective in level.objectives) {
    team = objective scripts\mp\gameobjects::getownerteam();

    if(team != self.team) {
      _id_B995B947954EFF32 = distancesquared(self.origin, objective.trigger.origin);

      if(!isDefined(_id_F355C50166CA2903) || _id_B995B947954EFF32 < _id_F355C50166CA2903) {
        _id_F355C50166CA2903 = _id_B995B947954EFF32;
        goalflag = objective;
      }
    }
  }

  if(isDefined(goalflag)) {
    if(!isDefined(self.goalflag) || self.goalflag != goalflag) {
      self.goalflag = goalflag;
      scripts\mp\bots\bots_strategy::bot_capture_point(goalflag.trigger.origin, 100);
    }
  }
}