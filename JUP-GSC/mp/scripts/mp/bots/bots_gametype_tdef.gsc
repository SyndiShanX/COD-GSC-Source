/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\bots\bots_gametype_tdef.gsc
*****************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\bots\bots_gametype_common;
#using scripts\mp\bots\bots_personality;
#using scripts\mp\bots\bots_strategy;
#using scripts\mp\bots\bots_util;
#using scripts\mp\gamelogic;
#using scripts\mp\utility\entity;
#using scripts\mp\utility\game;
#using scripts\mp\utility\script;
#namespace bots_gametype_tdef;

function main() {
  setup_callbacks();
  setup_bot_flag();
  thread monitor_flag_carrier();
}

function function_e45e46b7c35deadb() {}

function setup_callbacks() {
  level.bot_funcs["gametype_think"] = &bot_tdef_think;
}

function setup_bot_flag() {
  bot_waittill_bots_enabled(1);
  level.protect_radius = 600;
  level.bodyguard_radius = 400;
  thread bot_flag_ai_director_update();
  level.bot_gametype_precaching_done = 1;
}

function bot_get_tdef_flag() {
  return level.defenderflag;
}

function bot_get_flag_carrier() {
  if(isDefined(level.defenderflag.carrier)) {
    return level.defenderflag.carrier;
  }

  return undefined;
}

function bot_get_enemy_team() {
  if(self.team == "allies") {
    return "axis";
  }

  return "allies";
}

function bot_tdef_think() {
  self notify("bot_flag_think");
  self endon("bot_flag_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait 0.05;
  }

  self botsetflag("separation", 0);
  snappedgoalpos = undefined;
  var_78bff961df1c9fbd = undefined;

  while(true) {
    wait 0.05;

    if(!isDefined(self.role)) {
      initialize_flag_role();
      snappedgoalpos = undefined;
    }

    if(bot_has_tactical_goal()) {
      snappedgoalpos = undefined;
      continue;
    }

    if(self.role != "carrier" && isDefined(self.carryobject)) {
      snappedgoalpos = undefined;
      flag_set_role("carrier");
    }

    if(self.role == "carrier") {
      if(isDefined(self.carryobject)) {
        disttoenemysq = 0;

        if(isDefined(self.enemy)) {
          disttoenemysq = distancesquared(self.enemy.origin, self.origin);
        }

        if(isDefined(self.enemy) && disttoenemysq < 9216) {}

        self botclearscriptgoal();

        if(!isDefined(var_78bff961df1c9fbd)) {
          var_78bff961df1c9fbd = gettime() + randomintrange(500, 1000);
        }

        if(gettime() > var_78bff961df1c9fbd) {
          var_78bff961df1c9fbd = gettime() + randomintrange(500, 1000);
        }
      } else {
        var_cb042fafee68e950 = bot_get_tdef_flag();

        if(!isDefined(var_cb042fafee68e950)) {
          carrier = bot_get_flag_carrier();

          if(isDefined(carrier) && carrier != self) {
            initialize_flag_role();
          }
        } else {
          self botsetscriptgoal(var_cb042fafee68e950.curorigin, 16, "objective");
          continue;
        }
      }
    } else {
      snappedgoalpos = undefined;
    }

    if(self.role == "attacker") {
      var_cb042fafee68e950 = bot_get_tdef_flag();

      if(!isDefined(var_cb042fafee68e950)) {
        carrier = bot_get_flag_carrier();

        if(isDefined(carrier)) {
          if(!bot_is_guarding_player(carrier)) {
            bot_guard_player(carrier, level.bodyguard_radius);
          }
        }
      } else if(!istrue(var_cb042fafee68e950.isresetting) && !istrue(var_cb042fafee68e950.in_goal)) {
        defend_point = getclosestpointonnavmesh(var_cb042fafee68e950.curorigin);

        if(!bot_is_defending_point(defend_point)) {
          bot_protect_point(defend_point, level.protect_radius);
        }
      }

      continue;
    }

    if(self.role == "defender") {
      var_da0e11b0a9fa934b = level.defenderflag.carrier;
      goal = var_da0e11b0a9fa934b.origin;

      if(!bot_is_defending_point(goal)) {
        bot_protect_point(goal, level.protect_radius);
      }
    }
  }
}

function initialize_flag_role() {
  attackers = get_allied_attackers_for_team(self.team);
  defenders = get_allied_defenders_for_team(self.team);
  attacker_limit = flag_bot_attacker_limit_for_team(self.team);
  defender_limit = flag_bot_defender_limit_for_team(self.team);
  personality_type = level.bot_personality_type[self.personality];

  if(personality_type == "active") {
    if(attackers.size >= attacker_limit) {
      var_8668b3fa2350c9b3 = 0;

      foreach(attacker in attackers) {
        if(isai(attacker) && level.bot_personality_type[attacker.personality] == "stationary") {
          attacker.role = undefined;
          var_8668b3fa2350c9b3 = 1;
          break;
        }
      }

      if(var_8668b3fa2350c9b3) {
        flag_set_role("attacker");
      } else {
        flag_set_role("defender");
      }
    } else {
      flag_set_role("attacker");
    }

    return;
  }

  if(personality_type == "stationary") {
    if(defenders.size >= defender_limit) {
      var_8668b3fa2350c9b3 = 0;

      foreach(defender in defenders) {
        if(isai(defender) && level.bot_personality_type[defender.personality] == "active") {
          defender.role = undefined;
          var_8668b3fa2350c9b3 = 1;
          break;
        }
      }

      if(var_8668b3fa2350c9b3) {
        flag_set_role("defender");
      } else {
        flag_set_role("attacker");
      }

      return;
    }

    flag_set_role("defender");
  }
}

function bot_flag_ai_director_update() {
  level notify("bot_flag_ai_director_update");
  level endon("bot_flag_ai_director_update");
  level endon("game_ended");
  teams[0] = "allies";
  teams[1] = "axis";
  var_352c449f6f15c3c8 = [];

  while(true) {
    foreach(team in teams) {
      attacker_limit = flag_bot_attacker_limit_for_team(team);
      defender_limit = flag_bot_defender_limit_for_team(team);
      attackers = get_allied_attackers_for_team(team);
      defenders = get_allied_defenders_for_team(team);

      if(attackers.size > attacker_limit) {
        ai_attackers = [];
        removed_attacker = 0;

        foreach(attacker in attackers) {
          if(isai(attacker)) {
            if(level.bot_personality_type[attacker.personality] == "stationary") {
              attacker flag_set_role("defender");
              removed_attacker = 1;
              break;
            }

            ai_attackers = array_add(ai_attackers, attacker);
          }
        }

        if(!removed_attacker && ai_attackers.size > 0) {
          random(ai_attackers) flag_set_role("defender");
        }
      }

      if(defenders.size > defender_limit) {
        ai_defenders = [];
        removed_defender = 0;

        foreach(defender in defenders) {
          if(isai(defender)) {
            if(level.bot_personality_type[defender.personality] == "active") {
              defender flag_set_role("attacker");
              removed_defender = 1;
              break;
            }

            ai_defenders = array_add(ai_defenders, defender);
          }
        }

        if(!removed_defender && ai_defenders.size > 0) {
          random(ai_defenders) flag_set_role("attacker");
        }
      }

      var_cb042fafee68e950 = bot_get_tdef_flag();

      if(isDefined(var_cb042fafee68e950)) {
        idealcarrier = pick_flagcarrier(team, var_cb042fafee68e950);

        if(isDefined(idealcarrier) && isDefined(idealcarrier.role) && idealcarrier.role != "carrier") {
          if(!isDefined(idealcarrier.carryobject)) {
            previouscarrier = var_352c449f6f15c3c8[team];

            if(isDefined(previouscarrier)) {
              previouscarrier flag_set_role(undefined);
            }

            idealcarrier flag_set_role("carrier");
            var_352c449f6f15c3c8[idealcarrier.team] = idealcarrier;
          }
        }
      }
    }

    wait 1;
  }
}

function flag_bot_attacker_limit_for_team(team) {
  team_limit = flag_num_players_on_team(team);
  return team_limit;
}

function flag_bot_defender_limit_for_team(team) {
  return false;
}

function flag_num_players_on_team(team) {
  var_35b2ace44b93c013 = 0;

  foreach(player in level.participants) {
    if(isteamparticipant(player) && isDefined(player.team) && player.team == team) {
      var_35b2ace44b93c013++;
    }
  }

  return var_35b2ace44b93c013;
}

function pick_flagcarrier(team, var_cb042fafee68e950) {
  closestbot = undefined;
  closestdistsq = undefined;

  foreach(player in level.participants) {
    if(!isDefined(player.team)) {
      continue;
    }

    if(player.team != team) {
      continue;
    }

    if(!isalive(player)) {
      continue;
    }

    if(!isai(player)) {
      continue;
    }

    if(isDefined(player.role) && player.role == "defender") {
      continue;
    }

    distsq = distancesquared(player.origin, var_cb042fafee68e950.curorigin);

    if(!isDefined(closestdistsq) || distsq < closestdistsq) {
      closestdistsq = distsq;
      closestbot = player;
    }
  }

  if(isDefined(closestbot)) {
    return closestbot;
  }

  return undefined;
}

function get_allied_attackers_for_team(team) {
  attackers = get_players_by_role("attacker", team);
  return attackers;
}

function get_allied_defenders_for_team(team) {
  defenders = get_players_by_role("defender", team);
  return defenders;
}

function flag_set_role(new_role) {
  self.role = new_role;
  self botclearscriptgoal();
  bot_defend_stop();
}

function get_players_by_role(role, team) {
  players = [];

  foreach(player in level.participants) {
    if(!isDefined(player.team)) {
      continue;
    }

    if(isalive(player) && isteamparticipant(player) && player.team == team && isDefined(player.role) && player.role == role) {
      players[players.size] = player;
    }
  }

  return players;
}

function monitor_flag_carrier() {
  level endon("game_ended");
  last_carrier = undefined;

  while(true) {
    carrier = bot_get_flag_carrier();

    if(!isDefined(last_carrier) || !isDefined(carrier) || carrier != last_carrier) {
      if(isDefined(last_carrier) && last_carrier.threatbias == 505) {
        last_carrier.threatbias = 0;
      }

      last_carrier = carrier;
    }

    if(isDefined(carrier) && carrier.threatbias == 0) {
      carrier.threatbias = 505;
    }

    wait 0.05;
  }
}