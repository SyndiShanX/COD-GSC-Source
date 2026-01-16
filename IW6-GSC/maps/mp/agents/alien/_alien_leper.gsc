/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\alien\_alien_leper.gsc
*************************************************/

#include maps\mp\alien\_utility;

LEPER_NODE_WAIT = 5.0;
LEPER_SPAWN_DURATION = 35000;
LEPER_MIN_SAFE_PLAYER_DIST_SQR = 1048576;
LEPER_DAMAGE_MOVE_DELAY = 1.5;

leper_init() {
  self.leperDespawnTime = getTime() + LEPER_SPAWN_DURATION;
  self thread handle_favorite_enemy();
}

leper_combat(enemy) {
  self endon("death");
  enemy endon("death");

  self leper_retreat(enemy);
}

leper_retreat(enemy) {
  while(1) {
    self leper_approach(enemy);
    self leper_wait_at_node(enemy);
  }
}

leper_challenge_despawn(despawn_time) {
  self endon("leper_despawn");
  self endon("death");

  wait despawn_time;
  self leper_despawn();
}

handle_favorite_enemy() {
  self endon("death");

  while(1) {
    self.favoriteenemy = self get_closest_living_player();
    wait 5;
  }
}

leper_despawn() {
  self endon("death");
  self.health = 30000;
  self.maxhealth = 30000;

  self ScrAgentSetGoalPos(self.origin);
  self ScrAgentSetGoalRadius(2048);
  playFXOnTag(level._effect["alien_teleport"], self, "tag_origin");
  wait 1.0;
  self Suicide();
}

leper_approach(enemy) {
  retreat_node = self get_leper_retreat_node(enemy);
  if(!isDefined(retreat_node)) {
    wait 1;
    return;
  }

  self ScrAgentSetGoalNode(retreat_node);
  self ScrAgentSetGoalRadius(64);
  self waittill("goal_reached");
}

leave_node_on_distance_breach(enemy) {
  enemy endon("death");
  self endon("death");
  self endon("enemy");
  self endon("alien_main_loop_restart");
  self endon("leave_node ");

  while(1) {
    if(DistanceSquared(enemy.origin, self.origin) < LEPER_MIN_SAFE_PLAYER_DIST_SQR) {
      self notify("leave_node");
    }
    wait 1;
  }
}

leave_node_on_attacked(enemy) {
  enemy endon("death");
  self endon("death");
  self endon("enemy");
  self endon("alien_main_loop_restart");
  self endon("leave_node ");

  self waittill("damage");
  wait LEPER_DAMAGE_MOVE_DELAY;

  self notify("leave_node");
}

leper_wait_at_node(enemy) {
  self endon("leave_node");

  self thread leave_node_on_attacked(enemy);
  self thread leave_node_on_distance_breach(enemy);
  wait LEPER_NODE_WAIT;
}

get_leper_retreat_node(enemy) {
  retreat_nodes = get_named_retreat_nodes();
  if(!isDefined(retreat_nodes))
    retreat_nodes = get_possible_retreat_nodes();

  filters = [];
  filters["direction"] = "override";
  filters["direction_override"] = get_direction_away_from_players();
  filters["direction_weight"] = 2.0;
  filters["min_height"] = 64.0;
  filters["max_height"] = 500.0;
  filters["height_weight"] = 2.0;
  filters["enemy_los"] = false;
  filters["enemy_los_weight"] = 2.0;
  filters["min_dist_from_enemy"] = 500.0;
  filters["max_dist_from_enemy"] = 2048.0;
  filters["desired_dist_from_enemy"] = 1500.0;
  filters["dist_from_enemy_weight"] = 3.0;
  filters["min_dist_from_all_enemies"] = 800.0;
  filters["min_dist_from_all_enemies_weight"] = 5.0;
  filters["not_recently_used_weight"] = 4.0;
  filters["random_weight"] = 1.5;

  result = maps\mp\agents\alien\_alien_think::get_retreat_node_rated(enemy, filters, retreat_nodes);

  return result;
}

get_possible_retreat_nodes() {
  jump_nodes = GetNodesInRadius(self.origin, 1024, 400, 500, "jump");
  return jump_nodes;
}

get_direction_away_from_players() {
  if(level.players.size == 0)
    return self.origin + anglesToForward(self.angles) * 100;

  centralLocation = (0, 0, 0);

  foreach(player in level.players)
  centralLocation += player.origin;

  centralLocation = centralLocation / level.players.size;

  return self.origin - centralLocation;
}

leper_attack() {
  return;
}

get_named_retreat_nodes() {
  current_area = get_current_area_name();
  possible_nodes = getnodearray(current_area + "_leper_location", "targetname");
  if(isDefined(possible_nodes) && possible_nodes.size > 0)
    return possible_nodes;

  return undefined;
}