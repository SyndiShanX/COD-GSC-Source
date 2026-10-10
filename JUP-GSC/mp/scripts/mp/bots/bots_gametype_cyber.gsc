/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\bots\bots_gametype_cyber.gsc
******************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\bots\bots;
#using scripts\mp\bots\bots_gametype_common;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;
#using scripts\mp\gamelogic;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\player;
#using scripts\mp\utility\teams;
#namespace bots_gametype_cyber;

function main() {
  setup_callbacks();
  setup_bot_cyber();
}

function function_e45e46b7c35deadb() {}

function setup_callbacks() {
  level.bot_funcs["crate_can_use"] = &crate_can_use;
  level.bot_funcs["gametype_think"] = &bot_cyber_think;
  level.bot_funcs["know_enemies_on_start"] = undefined;
  level.bot_funcs["emp_picked_up_cancel"] = &bot_abort_emp_pickup;
  level.bot_funcs["tactical_revive_override"] = &bot_abort_tactical_goal_for_revive;
}

function setup_bot_cyber() {
  bot_setup_objective_bottargets();
  bot_waittill_bots_enabled();
  succeeded = bot_verify_and_cache_bombzones(["_allies", "_axis"]);

  if(succeeded) {
    foreach(bombzone in level.objectives) {
      bombzone thread monitor_bombzone_control();
    }

    level.protect_radius = 600;
    level.bot_gametype_precaching_done = 1;
  }
}

function bot_cyber_think() {
  self notify("bot_sab_think");
  self endon("bot_sab_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait 0.05;
  }

  init_bot_game_cyber();
  self botsetflag("separation", 0);
  self botsetflag("grenade_objectives", 1);
  self botsetflag("use_obj_path_style", 1);
  self.next_time_hunt_carrier = gettime();

  if(!isDefined(level.next_game_update_time)) {
    level.next_game_update_time = gettime() + 100;
  }

  for(;;) {
    wait 0.05;

    if(gettime() >= level.next_game_update_time) {
      update_game_cyber();
      level.next_game_update_time = gettime() + 100;
    }

    if(!scripts\mp\utility\player::isreallyalive(self)) {
      continue;
    }

    if(!isDefined(level.team_planted_bomb)) {
      if(!isDefined(level.bomb_carrier)) {
        if(bot_has_tactical_goal("seek_cyber_emp", undefined) == 0) {
          action_thread = &cyber_bot_pickup_emp;
          extra_params = spawnStruct();
          extra_params.object = level.cyberemp.trigger;
          extra_params.script_goal_radius = 16;
          extra_params.should_abort = level.bot_funcs["emp_picked_up_cancel"];
          extra_params.action_thread = action_thread;
          var_db532bb6d3e2f8e6 = getclosestpointonnavmesh(level.cyberemp.curorigin, self);
          bot_new_tactical_goal("seek_cyber_emp", var_db532bb6d3e2f8e6, 99, extra_params);
        }
      } else if(self.isbombcarrier) {
        if(!bot_has_tactical_goal()) {
          bombzone = level.objectives[get_enemy_team(self.team)];
          var_735fd56db96f509c = get_bombzone_node_to_plant_on(bombzone, 1);
          self botclearscriptgoal();
          self botsetscriptgoal(var_735fd56db96f509c.origin, 0, "critical", var_735fd56db96f509c.angles[1]);
          pathresult = bot_waittill_goal_or_fail();

          if(pathresult == "goal") {
            self botpressbutton("use", level.planttime + 2);
            level waittill_any_timeout_1(level.planttime + 2, "bomb_planted");
          }

          self botclearscriptgoal();
        }
      } else if(level.bomb_carrier.team == self.team) {
        if(!bot_is_defending()) {
          bot_guard_player(level.bomb_carrier, 400);
        }
      } else if(gettime() > self.next_time_hunt_carrier || sighttracepassed(self.origin + (0, 0, 77), level.bomb_carrier.origin + (0, 0, 77), 0, self)) {
        self botsetscriptgoal(level.bomb_carrier.origin, 16, "hunt");
        self.next_time_hunt_carrier = gettime() + randomintrange(4500, 5500);
      }

      continue;
    }

    bombzone = level.objectives[get_enemy_team(level.team_planted_bomb)];

    if(self.team == level.team_planted_bomb) {
      if(!is_defending_bombzone()) {
        bot_protect_point(bombzone.curorigin, 600);
      }

      continue;
    }

    if(isDefined(level.bomb_defuser) && level.bomb_defuser == self) {
      var_2fea4b3d4aab8868 = get_bombzone_node_to_defuse_on(bombzone).origin;
      self botsetscriptgoal(var_2fea4b3d4aab8868, 20, "critical");
      result = bot_waittill_goal_or_fail(undefined, "no_longer_bomb_defuser");

      if(result == "goal") {
        self botpressbutton("use", level.defusetime + 2);
        waittill_usebutton_released_or_time_or_bomb_planted(level.defusetime + 2);
      }

      continue;
    }

    if(!bot_is_defending()) {
      optional_params["entrance_points_index"] = "zone" + bombzone.label;
      bot_capture_point(bombzone.curorigin, 200, optional_params);
    }
  }
}

function bot_abort_emp_pickup(goal) {
  if(isDefined(level.cyberemp.carrier)) {
    return true;
  }

  return false;
}

function cyber_bot_pickup_emp(goal) {
  self botpressbutton("use", 0.5);
  botpersonality = self botgetpersonality();

  if(botpersonality == "default" || botpersonality == "camper") {
    wait 0.5;
  }
}

function waittill_usebutton_released_or_time_or_bomb_planted(time) {
  time_started = gettime();
  var_f36002d69d048db6 = time_started + time * 1000;
  wait 0.05;

  while(self useButtonPressed() && gettime() < var_f36002d69d048db6 && level.bombplanted) {
    wait 0.05;
  }
}

function is_defending_bombzone() {
  return bot_is_protecting();
}

function init_bot_game_cyber() {
  if(isDefined(level.bots_gametype_initialized) && level.bots_gametype_initialized) {
    return;
  }

  level.bots_gametype_initialized = 1;
}

function update_game_cyber() {
  if(!level.bombplanted) {
    if(isDefined(level.team_planted_bomb)) {
      level.team_planted_bomb = undefined;
      level.bomb_carrier = undefined;
    }

    prev_carrier = level.bomb_carrier;
    level.bomb_carrier = undefined;

    foreach(player in level.participants) {
      if(isalive(player) && player.isbombcarrier) {
        level.bomb_carrier = player;
      }
    }

    var_af5fb37a7fbc388 = 0;

    if(!isDefined(prev_carrier) && isDefined(level.bomb_carrier)) {
      assert(isteamparticipant(level.bomb_carrier));
      var_af5fb37a7fbc388 = 1;

      if(isai(level.bomb_carrier)) {
        level.bomb_carrier thread bomber_think();
      }
    } else if(isDefined(prev_carrier) && !isDefined(level.bomb_carrier)) {
      var_af5fb37a7fbc388 = 1;
    }

    if(var_af5fb37a7fbc388) {
      foreach(player in level.participants) {
        if(isaiteamparticipant(player)) {
          player bot_defend_stop();
        }
      }
    }

    return;
  }

  if(isDefined(level.bombowner) && !isDefined(level.team_planted_bomb)) {
    level.team_planted_bomb = level.bombowner.team;
    level.last_time_calc_defuser = gettime();
  }

  if(!isDefined(level.bomb_defuser) || !isalive(level.bomb_defuser) || gettime() > level.last_time_calc_defuser + 1000) {
    defusers = [];

    foreach(player in level.participants) {
      if(isalive(player) && isaiteamparticipant(player) && player.team != level.team_planted_bomb) {
        defusers[defusers.size] = player;
      }
    }

    if(defusers.size > 0) {
      bombzone = level.objectives[get_enemy_team(level.team_planted_bomb)];
      var_8518445c76f3e0b8 = get_array_of_closest(bombzone.curorigin, defusers);

      if(!isDefined(level.bomb_defuser) || level.bomb_defuser != var_8518445c76f3e0b8[0]) {
        prev_defuser = level.bomb_defuser;
        level.bomb_defuser = var_8518445c76f3e0b8[0];
        level.bomb_defuser bot_defend_stop();

        if(isDefined(prev_defuser)) {
          prev_defuser notify("no_longer_bomb_defuser");
        }
      }
    }
  }
}

function bomber_think() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!level.bombplanted && self.isbombcarrier) {
    followers = [];

    foreach(player in level.participants) {
      if(isalive(player) && isaiteamparticipant(player) && player.team == self.team && player bot_is_defending()) {
        followers[followers.size] = player;
      }
    }

    num_behind = 0;

    foreach(follower in followers) {
      var_c267021f983a459b = distancesquared(self.origin, follower.origin);
      var_3a0de1e171a0895f = follower.bot_defending_radius * follower.bot_defending_radius;
      var_e7f967c527a728a7 = follower.bot_defending_radius * 2 * follower.bot_defending_radius * 2;

      if(var_c267021f983a459b > var_3a0de1e171a0895f && var_c267021f983a459b < var_e7f967c527a728a7) {
        num_behind++;
      }
    }

    self setmovespeedscale(1 - 0.15 * num_behind);
    wait 1;
  }
}

function crate_can_use(crate) {
  if(isagent(self) && !isDefined(crate.boxtype)) {
    return false;
  }

  if(!scripts\mp\bots\bots::function_9bd84cede4fe8f24(crate)) {
    return false;
  }

  if(self.isbombcarrier) {
    return false;
  }

  if(!bot_is_defending() && !bot_is_protecting() && !bot_is_bodyguarding()) {
    return true;
  }

  return false;
}

function bot_abort_tactical_goal_for_revive() {
  if(level.bombplanted) {
    return false;
  }

  if(isDefined(level.cyberemp.carrier) && self == level.cyberemp.carrier) {
    return false;
  }

  if(istrue(self.isbotmedicrole)) {
    return false;
  }

  totalaliveplayers = getteamdata(self.team, "aliveCount");
  totalteamplayers = getteamdata(self.team, "teamCount");
  totaldeadplayers = totalteamplayers - totalaliveplayers;

  if(totaldeadplayers == 0) {
    return false;
  }

  medics = 0;
  var_365ca68607befb50 = 0;

  foreach(player in getteamdata(self.team, "players")) {
    if(istrue(self.isbotmedicrole)) {
      medics++;
    }
  }

  var_698a5ae4108aaa6b = int(clamp(totalteamplayers - 2, 1, 3));

  if(medics < var_698a5ae4108aaa6b + 1) {
    var_365ca68607befb50 = 1;
  }

  if(var_365ca68607befb50) {
    if(totalteamplayers == 2) {
      var_51ca3cc37c90bcb3 = 1;
    } else {
      var_51ca3cc37c90bcb3 = totalaliveplayers / totalteamplayers <= 0.7;
    }

    if(var_51ca3cc37c90bcb3) {
      return true;
    }
  }

  return false;
}