/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_gametype_ball.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_gamelogic;
#include maps\mp\bots\_bots_util;
#include maps\mp\bots\_bots_strategy;
#include maps\mp\bots\_bots_personality;
#include maps\mp\bots\_bots_gametype_common;

SCR_CONST_BALL_BOTS_IGNORE_HUMAN_PLAYER_ROLES = false;
SCR_CONST_BALL_OVERRIDE_ROLE = undefined;

SCR_CONST_BOT_BALL_OBJ_RADIUS = 180;
SCR_CONST_BALL_NODE_MAX_DIST = 375;
SCR_CONST_BALL_MAX_ENEMY_THROW_DIST = 350;

main() {
  setup_callbacks();
  setup_bot_ball();

  thread bot_ball_debug();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::bot_ball_think;
  level.bot_funcs["crate_can_use"] = ::crate_can_use;
}

setup_bot_ball() {
  if(SCR_CONST_BALL_BOTS_IGNORE_HUMAN_PLAYER_ROLES) {
    level.bot_gametype_ignore_human_player_roles = true;
  }

  level.bot_gametype_attacker_limit_for_team = ::bot_ball_attacker_limit_for_team;
  level.bot_gametype_defender_limit_for_team = ::bot_ball_defender_limit_for_team;
  level.bot_gametype_allied_attackers_for_team = ::get_allied_attackers_for_team;
  level.bot_gametype_allied_defenders_for_team = ::get_allied_defenders_for_team;

  bot_waittill_bots_enabled();

  while(!isDefined(level.ball_goals)) {
    wait(0.05);
  }

  level.ball_goals["allies"].script_label = "allies";
  level.ball_goals["axis"].script_label = "axis";

  bot_setup_ball_jump_nodes();

  zone = GetZoneNearest(level.ball_goals["allies"].origin);
  if(isDefined(zone)) {
    BotZoneSetTeam(zone, "allies");
  }

  zone = GetZoneNearest(level.ball_goals["axis"].origin);
  if(isDefined(zone)) {
    BotZoneSetTeam(zone, "axis");
  }

  foreach(ball in level.balls) {
    ball thread monitor_ball();
  }

  use_override_role = false;

  thread bot_gametype_attacker_defender_ai_director_update();

  if(isDefined(SCR_CONST_BALL_OVERRIDE_ROLE)) {
    wait(0.1);
    level notify("bot_gametype_attacker_defender_ai_director_update");
  }

  level.bot_gametype_precaching_done = true;
}

monitor_ball() {
  last_origin = self.visuals[0].origin;
  self.nearest_node = GetClosestNodeInSight(last_origin);
  while(1) {
    cur_origin = self.visuals[0].origin;
    self.ball_at_rest = bot_vectors_are_equal(last_origin, cur_origin);

    if(!self.ball_at_rest) {
      nearest_node = GetClosestNodeInSight(cur_origin);
      if(!isDefined(nearest_node)) {
        nodes = GetNodesInRadiusSorted(cur_origin, 512, 0, 6000);
        if(nodes.size > 0) {
          nearest_node = nodes[0];
        }
      }

      if(isDefined(nearest_node)) {
        self.nearest_node = nearest_node;
      }
    }

    last_origin = cur_origin;

    wait(0.2);
  }
}

bot_setup_ball_jump_nodes() {
  wait(1.0);

  num_traces = 0;
  increment = 10;

  foreach(goal in level.ball_goals) {
    goal.ball_jump_nodes = [];

    nodes = GetNodesInRadius(goal.origin, SCR_CONST_BALL_NODE_MAX_DIST, 0);
    foreach(node in nodes) {
      if(node.type == "End") {
        continue;
      }

      num_traces++;
      if(bot_ball_origin_can_see_goal(node.origin, goal, true)) {
        goal.ball_jump_nodes[goal.ball_jump_nodes.size] = node;
      }

      if((num_traces % increment) == 0) {
        wait(0.05);
      }
    }

    nearest_node_2d_dist_sq = 999999999;
    foreach(node in goal.ball_jump_nodes) {
      dist_2d_sq_to_node = Distance2DSquared(node.origin, goal.origin);
      if(dist_2d_sq_to_node < nearest_node_2d_dist_sq) {
        goal.nearest_node = node;
        nearest_node_2d_dist_sq = dist_2d_sq_to_node;
      }
    }

    AssertEx(goal.ball_jump_nodes.size > 0, "Uplink goal at " + goal.origin + " needs pathnodes within a " + SCR_CONST_BALL_NODE_MAX_DIST + " unit radius with sight to the goal");
    wait(0.05);
  }
}

bot_ball_origin_can_see_goal(origin, goal, thorough) {
  trace_succeeded = self bot_ball_trace_to_origin(origin, goal.origin);
  if(isDefined(thorough) && thorough) {
    if(!trace_succeeded) {
      goal_origin = goal.origin - (0, 0, goal.radius * 0.5);
      trace_succeeded = self bot_ball_trace_to_origin(origin, goal_origin);
    }

    if(!trace_succeeded) {
      goal_origin = goal.origin + (0, 0, goal.radius * 0.5);
      trace_succeeded = self bot_ball_trace_to_origin(origin, goal_origin);
    }
  }

  return trace_succeeded;
}

bot_ball_trace_to_origin(start_origin, end_origin) {
  if(isDefined(self) && (isPlayer(self) || IsAgent(self))) {
    hitPos = PlayerPhysicsTrace(start_origin, end_origin, self);
  } else {
    hitPos = PlayerPhysicsTrace(start_origin, end_origin);
  }
  return (DistanceSquared(hitPos, end_origin) < 1);
}

bot_ball_debug() {
  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait(0.05);
  }

  while(1) {
    if(GetDvarInt("bot_DrawDebugGametype") == 1) {
      foreach(goal in level.ball_goals) {
        foreach(node in goal.ball_jump_nodes) {
          color = undefined;
          if(node == goal.nearest_node) {
            color = (0, 1, 0);
          } else if(goal.team == "allies") {
            color = (0, 0, 1);
          } else if(goal.team == "axis") {
            color = (1, 0, 0);
          }

          bot_draw_cylinder(node.origin, 10, 10, 0.05, undefined, color, true, 4);
          Line(goal.origin, node.origin, color, 1.0, true);
        }
      }

      foreach(ball in level.balls) {
        if(!isDefined(ball.carrier)) {
          bot_draw_cylinder(ball.nearest_node.origin, 10, 10, 0.05, undefined, (0, 1, 0), true, 4);
          Line(ball bot_ball_get_origin(), ball.nearest_node.origin, (0, 1, 0), 1.0, true);
        }
      }
    }

    wait(0.05);
  }
}

crate_can_use(crate) {
  if(IsAgent(self) && !isDefined(crate.boxType)) {
    return false;
  }

  if(self has_ball()) {
    return false;
  }

  return true;
}

bot_ball_think() {
  self notify("bot_ball_think");
  self endon("bot_ball_think");

  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("owner_disconnect");

  while(!isDefined(level.bot_gametype_precaching_done)) {
    wait(0.05);
  }

  self BotSetFlag("separation", 0);

  can_predict_carrier_loc = RandomInt(100) < (self BotGetDifficultySetting("strategyLevel") * 25);
  next_predict_carrier_location_time = 0;
  self.last_pass_throw_check = 0;
  self.ball_can_pass_ally = RandomInt(100) < (self BotGetDifficultySetting("strategyLevel") * 25);
  self.ball_can_pass_enemy = RandomInt(100) < (self BotGetDifficultySetting("strategyLevel") * 25);
  self.ball_can_throw = RandomInt(100) < (self BotGetDifficultySetting("strategyLevel") * 25);

  my_goal = level.ball_goals[self.team];
  enemy_goal = level.ball_goals[get_enemy_team(self.team)];

  self childthread watch_ball_pickup_and_loss();

  while(true) {
    if(self.health <= 0) {
      continue;
    }

    needs_new_role = !isDefined(self.role);

    if(needs_new_role && isDefined(SCR_CONST_BALL_OVERRIDE_ROLE)) {
      needs_new_role = false;
      self.role = SCR_CONST_BALL_OVERRIDE_ROLE;
    }

    if(needs_new_role) {
      self bot_gametype_initialize_attacker_defender_role();
    }

    self BotSetFlag("force_sprint", false);

    ally_balls_carried = bot_ball_get_balls_carried_by_team(self.team);
    enemy_balls_carried = bot_ball_get_balls_carried_by_team(get_enemy_team(self.team));

    foreach(ball in enemy_balls_carried) {
      ball_carried_origin = ball bot_ball_get_origin() - (0, 0, 75);
      self BotGetImperfectEnemyInfo(ball.carrier, ball_carried_origin);
    }

    if(self has_ball()) {
      self BotSetFlag("force_sprint", true);

      distance_to_goal_sq = DistanceSquared(self.origin, enemy_goal.nearest_node.origin);
      if(distance_to_goal_sq > 600 * 600) {
        goal_jump_node_picked = enemy_goal.nearest_node;
        goal_radius = 600;
      } else {
        goal_jump_node_picked = get_array_of_closest(self.origin, enemy_goal.ball_jump_nodes)[0];
        goal_radius = 16;
      }

      self clear_defend_or_goal_if_necessary();
      self BotSetScriptGoal(goal_jump_node_picked.origin, goal_radius, "critical");
      result = self bot_waittill_goal_or_fail(undefined, "bot_no_longer_has_ball");

      if(result == "goal" && DistanceSquared(self.origin, goal_jump_node_picked.origin) <= 16 * 16) {
        self BotClearScriptGoal();
        look_dir = VectorNormalize(enemy_goal.origin - self getEye());
        if(VectorDot(look_dir, (0, 0, 1)) < 0.93) {
          self BotLookAtPoint(enemy_goal.origin, 5.0, "script_forced");
        }

        time_waited = 0;
        has_dodged_toward_goal = false;
        last_height = self.origin[2];
        while(time_waited < 4.0 && self has_ball()) {
          self BotSetScriptMove(VectorToYaw(enemy_goal.origin - self.origin), 0.05);
          if(time_waited == 0.30 || time_waited == 0.75) {
            self BotPressButton("jump");
          }

          reached_jump_apex = (time_waited > 1.25) && (self.origin[2] < last_height);
          last_height = self.origin[2];
          if(!has_dodged_toward_goal) {
            z_dist_to_goal = abs(self.origin[2] - enemy_goal.origin[2]);
            dist_to_goal_2d = Distance2D(self.origin, enemy_goal.origin);

            if(z_dist_to_goal < 10 || (reached_jump_apex && dist_to_goal_2d > 200)) {
              self BotPressButton("sprint");
              has_dodged_toward_goal = true;
            }
          }

          wait(0.05);
          time_waited += 0.05;
          if(!self has_ball() || (time_waited > 0.75 && self IsOnGround())) {
            time_waited = 5.0;
          }
        }
        self BotLookAtPoint(undefined);
      }
      self BotClearScriptGoal();
    } else if(self.role == "attacker") {
      free_balls = bot_ball_get_free_balls();
      if(free_balls.size <= 0) {
        if(enemy_balls_carried.size > 0) {
          closest_enemy_ball = self bot_ball_get_closest_ball(enemy_balls_carried);
          closest_enemy_ball_loc = closest_enemy_ball bot_ball_get_origin() - (0, 0, 75);
          if(can_predict_carrier_loc) {
            if(GetTime() > next_predict_carrier_location_time) {
              next_predict_carrier_location_time = GetTime() + 5000;

              predicted_loc = undefined;
              path_to_goal = GetNodesOnPath(closest_enemy_ball_loc, my_goal.nearest_node.origin);
              if(isDefined(path_to_goal) && path_to_goal.size > 0) {
                predicted_loc = path_to_goal[Int(path_to_goal.size * RandomFloatRange(0.25, 0.75))].origin;
              }

              self clear_defend_or_goal_if_necessary();
              if(isDefined(predicted_loc) && self find_ambush_node(predicted_loc, 512)) {
                self BotSetScriptGoalNode(self.node_ambushing_from, "guard", self.ambush_yaw);
              } else {
                self BotSetScriptGoal(closest_enemy_ball_loc, 16, "guard");
              }
            }
          } else {
            self clear_defend_or_goal_if_necessary();
            self BotSetScriptGoal(closest_enemy_ball_loc, 16, "guard");
          }
        } else if(ally_balls_carried.size > 0) {
          if(!self bot_is_bodyguarding()) {
            closest_ally_ball = self bot_ball_get_closest_ball(ally_balls_carried);

            self clear_defend_or_goal_if_necessary();
            self bot_guard_player(closest_ally_ball.carrier, 500);
          }
        } else {
          ball_starts_sorted = get_array_of_closest(self.origin, level.ball_starts);
          self clear_defend_or_goal_if_necessary();
          self BotSetScriptGoal(ball_starts_sorted[0].origin, 16, "guard");
        }
      } else {
        ball_chosen = self bot_ball_get_closest_ball(free_balls);
        Assert(isDefined(ball_chosen));

        self clear_defend_or_goal_if_necessary("objective");
        if(ball_chosen.ball_at_rest) {
          ball_origin = ball_chosen bot_ball_get_origin();
          if(!self BotHasScriptGoal() || !bot_vectors_are_equal(ball_origin, self BotGetScriptGoal())) {
            self BotSetScriptGoal(ball_origin, 16, "objective", undefined, SCR_CONST_BOT_BALL_OBJ_RADIUS);
          }
        } else {
          self BotSetScriptGoal(ball_chosen.nearest_node.origin, 16, "objective", undefined, SCR_CONST_BOT_BALL_OBJ_RADIUS);
        }
      }
    } else {
      Assert(self.role == "defender");

      ball_to_get_rid_of = undefined;
      free_balls = bot_ball_get_free_balls();
      foreach(ball in free_balls) {
        ball_dist_to_my_goal_sq = Distance2DSquared(ball bot_ball_get_origin(), my_goal.origin);
        if(ball_dist_to_my_goal_sq < squared(get_ball_goal_protect_radius())) {
          ball_to_get_rid_of = ball;
          break;
        }
      }

      if(isDefined(ball_to_get_rid_of)) {
        self clear_defend_or_goal_if_necessary();
        if(ball_to_get_rid_of.ball_at_rest) {
          self BotSetScriptGoal(ball_to_get_rid_of bot_ball_get_origin(), 16, "guard");
        } else {
          self BotSetScriptGoal(ball_to_get_rid_of.nearest_node.origin, 16, "guard");
        }
        self bot_waittill_goal_or_fail(1.0);
      } else if(!self bot_is_protecting()) {
        self BotClearScriptGoal();
        optional_params["score_flags"] = "strict_los";
        optional_params["override_origin_node"] = my_goal.nearest_node;
        self bot_protect_point(my_goal.nearest_node.origin, get_ball_goal_protect_radius(), optional_params);
      }
    }

    wait(0.05);
  }
}

watch_ball_pickup_and_loss() {
  had_ball = false;
  while(1) {
    if(self has_ball() && !had_ball) {
      self childthread monitor_pass_throw();
      had_ball = true;
      self BotSetFlag("melee_critical_path", true);
    } else if(!self has_ball() && had_ball) {
      self notify("bot_no_longer_has_ball");
      had_ball = false;
      self BotSetFlag("melee_critical_path", false);
    }

    wait(0.05);
  }
}

monitor_pass_throw() {
  self endon("bot_no_longer_has_ball");

  my_goal = level.ball_goals[self.team];
  enemy_goal = level.ball_goals[get_enemy_team(self.team)];

  while(1) {
    if(self.ball_can_pass_ally) {
      if(isDefined(self.pass_target)) {
        can_pass_ally = true;

        if(bot_gametype_ignore_human_player_roles() && !IsAI(self.pass_target)) {
          can_pass_ally = false;
        }

        if(can_pass_ally) {
          my_dist_to_goal_sq = DistanceSquared(self.origin, enemy_goal.origin);
          ally_dist_to_goal_sq = DistanceSquared(self.pass_target.origin, enemy_goal.origin);

          if(ally_dist_to_goal_sq <= my_dist_to_goal_sq) {
            bot_dir = anglesToForward(self GetPlayerAngles());
            bot_to_ally = VectorNormalize(self.pass_target.origin - self.origin);
            dot = VectorDot(bot_dir, bot_to_ally);
            if(dot > 0.70) {
              self BotLookAtPoint(self.pass_target.origin + (0, 0, 40), 1.25, "script_forced");
              wait(0.25);
              self BotPressButton("throw");
              wait(1.0);
            }
          }
        }
      }
    }

    if(self.ball_can_pass_enemy) {
      if(isDefined(self.enemy) && IsAlive(self.enemy) && self BotCanSeeEntity(self.enemy)) {
        can_throw_enemy = true;

        if(bot_gametype_ignore_human_player_roles() && !IsAI(self.enemy)) {
          can_throw_enemy = false;
        }

        if(can_throw_enemy) {
          my_dist_to_my_goal_sq = DistanceSquared(self.origin, my_goal.origin);
          too_close_to_goal = my_dist_to_my_goal_sq < squared(get_ball_goal_protect_radius());
          if(!too_close_to_goal && DistanceSquared(self.origin, self.enemy.origin) < squared(SCR_CONST_BALL_MAX_ENEMY_THROW_DIST)) {
            enemy_dir = anglesToForward(self.enemy GetPlayerAngles());
            enemy_to_bot = VectorNormalize(self.origin - self.enemy.origin);
            dot = VectorDot(enemy_dir, enemy_to_bot);
            if(dot > 0.50) {
              bot_dir = anglesToForward(self GetPlayerAngles());
              bot_to_enemy = -1 * enemy_to_bot;
              dot = VectorDot(bot_dir, bot_to_enemy);
              if(dot > 0.77) {
                self BotLookAtPoint(self.enemy.origin + (0, 0, 40), 1.25, "script_forced");
                wait(0.25);
                self BotPressButton("attack");
                wait(1.0);
              }
            }
          }
        }
      }
    }

    if(self.ball_can_throw) {
      if(self.health < 100 && self bot_ball_origin_can_see_goal(self.origin, enemy_goal)) {
        self BotLookAtPoint(enemy_goal.origin, 1.25, "script_forced");
        wait(0.25);
        self BotPressButton("attack");
        wait(1.0);
      } else if(self.role == "defender") {
        my_dist_to_my_goal_sq = DistanceSquared(self.origin, my_goal.origin);
        if(my_dist_to_my_goal_sq < squared(get_ball_goal_protect_radius())) {
          ball_throw_dir = anglesToForward((self GetPlayerAngles() * (0, 1, 1)) + (-30, 0, 0));
          self BotLookAtPoint(self getEye() + ball_throw_dir * 200, 1.25, "script_forced");
          wait(0.25);
          self BotPressButton("attack");
          wait(1.0);
        }
      }
    }

    wait(0.05);
  }
}

ball_carrier_is_almost_visible(ball_carrier) {
  Assert(ball_carrier has_ball());

  nearest_node_self = self GetNearestNode();
  nearest_node_carrier = ball_carrier GetNearestNode();
  if(isDefined(nearest_node_self) && isDefined(nearest_node_carrier)) {
    if(NodesVisible(nearest_node_self, nearest_node_carrier, true)) {
      return nearest_node_carrier;
    }

    linked_nodes = GetLinkedNodes(nearest_node_carrier);
    foreach(node in linked_nodes) {
      if(NodesVisible(nearest_node_self, node, true)) {
        return node;
      }
    }
  }

  return undefined;
}

bot_ball_is_resetting() {
  return (self.compassIcons["friendly"] == "waypoint_ball_download") || (self.compassIcons["friendly"] == "waypoint_ball_upload");
}

bot_ball_get_closest_ball(balls) {
  if(balls.size == 1) {
    return balls[0];
  }

  closest_dist_sq = 99999999;
  closest_ball = undefined;

  foreach(ball in balls) {
    dist_to_ball_sq = DistanceSquared(self.origin, ball bot_ball_get_origin());
    if(dist_to_ball_sq < closest_dist_sq) {
      closest_dist_sq = dist_to_ball_sq;
      closest_ball = ball;
    }
  }

  return closest_ball;
}

bot_ball_get_origin() {
  if(isDefined(self.carrier)) {
    return self.curorigin;
  } else {
    return self.visuals[0].origin;
  }
}

clear_defend_or_goal_if_necessary(expected_new_goal_type) {
  if(self bot_is_defending()) {
    self bot_defend_stop();
  }

  if(self BotGetScriptGoalType() == "objective") {
    new_goal_is_objective = isDefined(expected_new_goal_type) && expected_new_goal_type == "objective";
    if(!new_goal_is_objective) {
      self BotClearScriptGoal();
    }
  }
}

has_ball() {
  return isDefined(self.ball_carried);
}

bot_ball_get_free_balls() {
  free_balls = [];
  foreach(ball in level.balls) {
    if(ball bot_ball_is_resetting()) {
      continue;
    }

    if(!isDefined(ball.carrier)) {
      free_balls[free_balls.size] = ball;
    }
  }

  return free_balls;
}

bot_ball_get_balls_carried_by_team(team) {
  team_balls = [];
  foreach(ball in level.balls) {
    if(ball bot_ball_is_resetting()) {
      continue;
    }

    if(isDefined(ball.carrier) && ball.carrier.team == team) {
      team_balls[team_balls.size] = ball;
    }
  }

  return team_balls;
}

bot_ball_attacker_limit_for_team(team) {
  team_limit = bot_gametype_get_num_players_on_team(team);
  num_attackers_wanted_raw = team_limit * 0.67;

  floor_num = floor(num_attackers_wanted_raw);
  ceil_num = ceil(num_attackers_wanted_raw);
  dist_to_floor = num_attackers_wanted_raw - floor_num;
  dist_to_ceil = ceil_num - num_attackers_wanted_raw;

  if(dist_to_floor < dist_to_ceil) {
    num_attackers_wanted = int(floor_num);
  } else {
    num_attackers_wanted = int(ceil_num);
  }

  return num_attackers_wanted;
}

bot_ball_defender_limit_for_team(team) {
  team_limit = bot_gametype_get_num_players_on_team(team);
  return (team_limit - bot_ball_attacker_limit_for_team(team));
}

get_ball_goal_protect_radius() {
  if(IsAlive(self) && !isDefined(level.protect_radius)) {
    worldBounds = self BotGetWorldSize();
    average_side = (worldBounds[0] + worldBounds[1]) / 2;
    level.protect_radius = min(800, average_side / 5.5);
  }

  if(!isDefined(level.protect_radius)) {
    return 900;
  }

  return level.protect_radius;
}

get_allied_attackers_for_team(team) {
  return bot_gametype_get_allied_attackers_for_team(team, level.ball_goals[team].origin, get_ball_goal_protect_radius());
}

get_allied_defenders_for_team(team) {
  return bot_gametype_get_allied_defenders_for_team(team, level.ball_goals[team].origin, get_ball_goal_protect_radius());
}