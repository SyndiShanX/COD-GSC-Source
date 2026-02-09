/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\alien\_alien_spitter.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\alien\_utility;

ALIEN_SPIT_ATTACK_DISTANCE_MAX_SQ = 1440000;
ALIEN_ESCAPE_SPIT_ATTACK_DISTANCE_MAX_SQ = 3240000;
MIN_SPIT_TIMES = 3;
MAX_SPIT_TIMES = 6;

SPITTER_NODE_DURATION = 10;
SPITTER_FIRE_INTERVAL_MIN = 1.5;
SPITTER_FIRE_INTERVAL_MAX = 3.0;
SPITTER_PROJECTILE_BARRAGE_SIZE_MIN = 2;
SPITTER_PROJECTILE_BARRAGE_SIZE_MAX = 3;

SPITTER_GAS_CLOUD_FIRE_INTERVAL_MIN = 10.0;
SPITTER_GAS_CLOUD_FIRE_INTERVAL_MAX = 15.0;
SPITTER_GAS_CLOUD_MAX_COUNT = 3;

SPITTER_NODE_DAMAGE_DELAY = 0.1;
SPITTER_MIN_PLAYER_DISTANCE_SQ = 90000.0;
SPITTER_MOVE_MIN_PLAYER_DISTANCE_SQ = 40000.0;
SPITTER_NODE_INITIAL_FIRE_DELAY_SCALE = 0.5;
SPITTER_NO_TARGET_NODE_MOVE_TIME = 1.0;

SPITTER_AOE_HEIGHT = 128;
SPITTER_AOE_RADIUS = 150;
SPITTER_AOE_DURATION = 10.0;
SPITTER_AOE_DELAY = 2.0;
SPITTER_AOE_DAMAGE_PER_SECOND = 12.0;

SPITTER_TIME_BETWEEN_SPITS = 3.33;

SPITTER_LOOK_AHEAD_PERCENTAGE = 0.5;
SPITTER_ESCAPE_LOOK_AHEAD_PERCENTAGE = 1.0;

load_spitter_fx() {
  level._effect["spit_AOE"] = LoadFX("vfx/gameplay/alien/vfx_alien_spitter_gas_cloud");
  level._effect["spit_AOE_small"] = LoadFX("vfx/gameplay/alien/vfx_alien_spitter_gas_cloud_64");
}

spitter_init() {
  self.gas_cloud_available = true;
}

spitter_death() {
  release_spit_node();
}

is_escape_sequence_active() {
  return (flag_exist("hives_cleared") && flag("hives_cleared"));
}

get_max_spit_distance_squared() {
  if(is_escape_sequence_active())
    return ALIEN_ESCAPE_SPIT_ATTACK_DISTANCE_MAX_SQ;

  return ALIEN_SPIT_ATTACK_DISTANCE_MAX_SQ;
}

get_lookahead_percentage() {
  if(is_escape_sequence_active())
    return SPITTER_ESCAPE_LOOK_AHEAD_PERCENTAGE;

  return SPITTER_LOOK_AHEAD_PERCENTAGE;
}

spit_projectile(enemy) {
  if(self.spit_type == "gas_cloud") {
    level.spitter_last_cloud_time = gettime();
  }

  self.melee_type = "spit";

  self.spit_target = enemy;
  maps\mp\agents\alien\_alien_think::alien_melee(enemy);
}

spit_attack(enemy) {
  maps\mp\agents\alien\_alien_think::debug_alien_ai_state("spit_attack");
  self endon("melee_pain_interrupt");
  isEnemyChopper = isDefined(enemy) && isDefined(enemy.code_classname) && enemy.code_classname == "script_vehicle";

  if(isEnemyChopper)
    targetedEnemy = enemy;
  else
    targetedEnemy = self.spit_target;

  targetedEnemy endon("death");
  self maps\mp\agents\alien\_alien_anim_utils::turnTowardsEntity(targetedEnemy);

  if(IsAlive(targetedEnemy)) {
    self.spit_target = targetedEnemy;

    if(isEnemyChopper) {
      aim_ahead_factor = 5;
      aim_ahead_unit_vec = VectorNormalize(anglesToForward(targetedEnemy.angles));
      aim_ahead_speed_mag = Length(targetedEnemy Vehicle_GetVelocity()) * aim_ahead_factor;
      aim_ahead_vec = aim_ahead_unit_vec * aim_ahead_speed_mag;

      self.spit_target_location = targetedEnemy.origin + aim_ahead_vec + (0, 0, 32);
    } else {
      self.spit_target_location = targetedEnemy.origin;
    }

    self.looktarget = targetedEnemy;

    self set_alien_emissive(0.2, 1.0);

    if(isDefined(self.current_spit_node) && !maps\mp\alien\_utility::is_normal_upright(AnglesToUp(self.current_spit_node.angles))) {
      up = AnglesToUp(self.current_spit_node.angles);
      forward = anglesToForward(self.angles);
      left = VectorCross(up, forward);
      forward = VectorCross(left, up);
      right = (0, 0, 0) - left;
      anglesToFace = AxisToAngles(forward, right, up);
      self ScrAgentSetOrientMode("face angle abs", anglesToFace);
    } else if(isDefined(self.enemy) && targetedEnemy == self.enemy) {
      self ScrAgentSetOrientMode("face enemy");
    } else {
      forward = VectorNormalize(targetedEnemy.origin - self.origin);
      if(isDefined(self.current_spit_node))
        up = AnglesToUp(self.current_spit_node.angles);
      else
        up = AnglesToUp(self.angles);
      left = VectorCross(up, forward);
      forward = VectorCross(left, up);
      right = (0, 0, 0) - left;
      anglesToFace = AxisToAngles(forward, right, up);
      self ScrAgentSetOrientMode("face angle abs", anglesToFace);
    }

    if(self.oriented)
      self ScrAgentSetAnimMode("anim angle delta");
    else
      self ScrAgentSetAnimMode("anim deltas");
    play_spit_anim();
  }

  self set_alien_emissive_default(0.2);
  self.looktarget = undefined;
  self.spit_target = undefined;
  self.spit_target_location = undefined;
  self.spit_type = undefined;
}

play_spit_anim() {
  switch (self.spit_type) {
    case "close_range":
      self maps\mp\agents\_scriptedagents::PlayAnimUntilNotetrack("close_spit_attack", "spit_attack", "end", ::handleAttackNotetracks);
      break;
    case "gas_cloud":
      self maps\mp\agents\_scriptedagents::PlayAnimUntilNotetrack("gas_spit_attack", "spit_attack", "end", ::handleAttackNotetracks);
      break;
    case "long_range":
      barrage_count = RandomIntRange(SPITTER_PROJECTILE_BARRAGE_SIZE_MIN, SPITTER_PROJECTILE_BARRAGE_SIZE_MAX);
      for(spitIndex = 0; spitIndex < barrage_count; spitIndex++)
        self maps\mp\agents\_scriptedagents::PlayAnimUntilNotetrack("long_range_spit_attack", "spit_attack", "end", ::handleAttackNotetracks);
      break;
    default:
      AssertMsg(self.spit_type + " is an invalid spit type!");
      break;
  }
}

get_best_spit_target(targeted_enemy) {
  if(cointoss() && get_alien_type() != "seeder") {
    griefTargets = get_grief_targets();

    foreach(griefTarget in griefTargets) {
      if(is_valid_spit_target(griefTarget, false))
        return griefTarget;
    }
    wait 0.05;
  }

  if(isDefined(targeted_enemy)) {
    if(IsAlive(targeted_enemy) && is_valid_spit_target(targeted_enemy, false))
      return targeted_enemy;
  }

  possibleTargets = self get_current_possible_targets();
  MAX_TARGET_TESTS_PER_FRAME = 4;
  currentTestsThisFrame = 0;

  foreach(possibleTarget in possibleTargets) {
    if(!IsAlive(possibleTarget)) {
      continue;
    }
    if(isDefined(targeted_enemy) && possibleTarget == targeted_enemy) {
      continue;
    }
    if(is_valid_spit_target(possibleTarget, true))
      return possibleTarget;

    currentTestsThisFrame++;
    if(currentTestsThisFrame >= MAX_TARGET_TESTS_PER_FRAME) {
      waitframe();
      currentTestsThisFrame = 0;
    }
  }

  return undefined;
}

get_grief_targets() {
  griefTargets = [];
  if(!can_spit_gas_cloud() || is_pet())
    return griefTargets;

  foreach(player in level.players) {
    if(!IsAlive(player)) {
      continue;
    }
    if(isDefined(player.inLastStand) && player.inLastStand)
      griefTargets[griefTargets.size] = player;
  }

  if(isDefined(level.drill) && isDefined(level.drill.state) && level.drill.state == "offline")
    griefTargets[griefTargets.size] = level.drill;

  return array_randomize(griefTargets);
}

is_valid_spit_target(spit_target, check_attacker_values) {
  if(!isAlive(spit_target)) {
    return false;
  }

  if(check_attacker_values && isPlayer(spit_target) && !has_attacker_space(spit_target)) {
    return false;
  }

  maxValidDistanceSq = get_max_spit_distance_squared();

  flatDistanceToTargetSquared = Distance2DSquared(self.origin, spit_target.origin);
  if(flatDistanceToTargetSquared > maxValidDistanceSq)
    return false;

  self.looktarget = spit_target;

  if(!isAlive(spit_target)) {
    return false;
  }

  if((isPlayer(spit_target) || IsSentient(spit_target)) && !isDefined(spit_target.usingRemote))
    endPos = spit_target getEye();
  else
    endPos = spit_target.origin;

  spitFirePos = self GetTagOrigin("TAG_BREATH");
  return BulletTracePassed(spitFirePos, endPos, false, self);
}

get_spit_fire_pos(spit_target) {
  return self GetTagOrigin("TAG_BREATH");
}

has_attacker_space(player) {
  maxValidAttackerValue = level.maxAlienAttackerDifficultyValue - level.alien_types[self.alien_type].attributes["attacker_difficulty"];

  targetedAttackerScore = maps\mp\agents\alien\_alien_think::get_current_attacker_value(player);

  return (targetedAttackerScore <= maxValidAttackerValue);
}

handleAttackNotetracks(note, animState, animIndex, animTime) {
  if(isDefined(level.dlc_attacknotetrack_override_func)) {
    self[[level.dlc_attacknotetrack_override_func]](note, animState, animIndex, animTime);
    return;
  }

  if(note == "spit")
    return self fire_spit_projectile();
}

fire_spit_projectile() {
  if(!isDefined(self.spit_target) && !isDefined(self.spit_target_location)) {
    return;
  }
  hasValidTarget = IsAlive(self.spit_target);
  isTargetChopper = isDefined(self.spit_target.code_classname) && self.spit_target.code_classname == "script_vehicle";
  if(hasValidTarget && !isTargetChopper)
    targetLocation = self.spit_target.origin;
  else
    targetLocation = self.spit_target_location;

  if(self.spit_type == "gas_cloud") {
    spit_gas_cloud_projectile(targetLocation);
  } else if(hasValidTarget) {
    PROJECTILE_SPEED = 1400;
    targetLocation = get_lookahead_target_location(PROJECTILE_SPEED, self.spit_target, false);
    if(!BulletTracePassed(targetLocation, get_spit_fire_pos(targetLocation), false, self))
      targetLocation = get_lookahead_target_location(PROJECTILE_SPEED, self.spit_target, true);

    spit_basic_projectile(targetLocation);
  }
}

get_lookahead_target_location(projectile_speed, target, use_eye_location) {
  if(!isPlayer(target))
    return target.origin;

  lookAheadPercentage = get_lookahead_percentage();

  if(use_eye_location && !isDefined(target.usingRemote))
    targetLocation = target getEye();
  else
    targetLocation = target.origin;

  distanceToTarget = Distance(self.origin, targetLocation);
  timeToImpact = distanceToTarget / projectile_speed;
  targetVelocity = target GetVelocity();

  return targetLocation + targetVelocity * lookAheadPercentage * timeToImpact;
}

can_spit_gas_cloud() {
  if(!self.gas_cloud_available)
    return false;

  if(isDefined(self.enemy) && isDefined(self.enemy.no_gas_cloud_attack) && self.enemy.no_gas_cloud_attack)
    return false;

  time_since_last_spit = (gettime() - level.spitter_last_cloud_time) * 0.001;

  return level.spitter_gas_cloud_count < SPITTER_GAS_CLOUD_MAX_COUNT && time_since_last_spit > SPITTER_TIME_BETWEEN_SPITS;
}

spit_basic_projectile(targetLocation) {
  spitFirePos = get_spit_fire_pos(targetLocation);
  spitProjectile = MagicBullet("alienspit_mp", spitFirePos, targetLocation, self);
  spitProjectile.owner = self;

  if(isDefined(spitProjectile))
    spitProjectile thread spit_basic_projectile_impact_monitor(self);
}

spit_basic_projectile_impact_monitor(owner) {
  self waittill("explode", explodeLocation);

  if(!isDefined(explodeLocation)) {
    return;
  }
  playFX(level._effect["spit_AOE_small"], explodeLocation + (0, 0, 8), (0, 0, 1), (1, 0, 0));
}

spit_gas_cloud_projectile(targetLocation) {
  spitFirePos = get_spit_fire_pos(targetLocation);
  spitProjectile = MagicBullet("alienspit_gas_mp", spitFirePos, targetLocation, self);
  spitProjectile.owner = self;

  if(isDefined(spitProjectile))
    spitProjectile thread spit_gas_cloud_projectile_impact_monitor(self);

  self thread gas_cloud_available_timer();
}

gas_cloud_available_timer() {
  self endon("death");

  self.gas_cloud_available = false;
  cloudInterval = RandomFloatRange(SPITTER_GAS_CLOUD_FIRE_INTERVAL_MIN, SPITTER_GAS_CLOUD_FIRE_INTERVAL_MAX);
  wait cloudInterval;
  self.gas_cloud_available = true;
}

spit_gas_cloud_projectile_impact_monitor(owner) {
  self waittill("explode", explodeLocation);

  if(!isDefined(explodeLocation)) {
    return;
  }
  trigger = spawn("trigger_radius", explodeLocation, 0, SPITTER_AOE_RADIUS, SPITTER_AOE_HEIGHT);

  if(!isDefined(trigger)) {
    return;
  }
  level.spitter_gas_cloud_count++;
  trigger.onPlayer = true;
  playFX(level._effect["spit_AOE"], explodeLocation + (0, 0, 8), (0, 0, 1), (1, 0, 0));
  thread spit_aoe_cloud_damage(explodeLocation, trigger);
  level notify("spitter_spit", explodeLocation);

  wait SPITTER_AOE_DURATION;
  trigger Delete();
  level.spitter_gas_cloud_count--;
}

spit_aoe_cloud_damage(impact_location, trigger) {
  trigger endon("death");

  wait SPITTER_AOE_DELAY;

  while(true) {
    trigger waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    if(!IsAlive(player)) {
      continue;
    }
    disorient_player(player);
    damage_player(player, trigger);
  }
}

damage_player(player, trigger) {
  DAMAGE_INTERVAL = 0.5;

  currentTime = GetTime();

  if(!isDefined(player.last_spitter_gas_damage_time)) {
    elapsedTime = DAMAGE_INTERVAL;
  } else if(player.last_spitter_gas_damage_time + DAMAGE_INTERVAL * 1000.0 > currentTime) {
    return;
  } else {
    elapsedTime = Min(DAMAGE_INTERVAL, (currentTime - player.last_spitter_gas_damage_time) * 0.001);
  }

  gas_damage_scalar = player maps\mp\alien\_perk_utility::perk_GetGasDamageScalar();
  damageAmount = int(SPITTER_AOE_DAMAGE_PER_SECOND * elapsedTime * gas_damage_scalar);
  if(damageAmount > 0) {
    player thread[[level.callbackPlayerDamage]](trigger, trigger, damageAmount, 0, "MOD_SUICIDE", "alienspit_gas_mp", trigger.origin, (0, 0, 0), "none", 0);
  }
  player.last_spitter_gas_damage_time = currentTime;
}

disorient_player(player) {
  if(is_chaos_mode() && player maps\mp\alien\_perk_utility::perk_GetGasDamageScalar() == 0)
    return;
  else if(!player maps\mp\alien\_perk_utility::has_perk("perk_medic", [1, 2, 3, 4])) {
    if(isDefined(level.shell_shock_override))
      player[[level.shell_shock_override]](0.5);
    else
      player ShellShock("alien_spitter_gas_cloud", 0.5);
  }
}

get_RL_toward(target) {
  self_to_target_angles = VectorToAngles(target.origin - self.origin);
  target_direction = anglesToRight(self_to_target_angles);

  if(common_scripts\utility::cointoss())
    target_direction *= -1;

  return target_direction;
}

spitter_combat(enemy) {
  self endon("bad_path");
  self endon("death");
  self endon("alien_main_loop_restart");

  while(true) {
    attackNode = find_spitter_attack_node(self.enemy);

    if(isDefined(attackNode)) {
      move_to_spitter_attack_node(attackNode);
      spitter_attack(self.enemy);
    } else {
      wait 0.05;
    }
  }
}

release_spit_node() {
  if(isDefined(self.current_spit_node)) {
    self ScrAgentRelinquishClaimedNode(self.current_spit_node);
    self.current_spit_node.claimed = false;
    self.current_spit_node = undefined;
  }
}

claim_spit_node(spit_node) {
  self.current_spit_node = spit_node;
  spit_node.claimed = true;
  self ScrAgentClaimNode(spit_node);
}

move_to_spitter_attack_node(attack_node) {
  self endon("player_proximity_during_move");

  release_spit_node();
  claim_spit_node(attack_node);

  self ScrAgentSetGoalNode(attack_node);
  self ScrAgentSetGoalRadius(64);
  self thread enemy_proximity_during_move_monitor();
  self waittill("goal_reached");
}

enemy_proximity_during_move_monitor() {
  self endon("death");
  self endon("goal_reached");
  self endon("alien_main_loop_restart");

  while(true) {
    wait 0.05;

    if(!is_normal_upright(AnglesToUp(self.angles))) {
      continue;
    }
    if(!self maps\mp\agents\alien\_alien_think::melee_okay()) {
      continue;
    }
    if(isDefined(self.valid_moving_spit_attack_time) && GetTime() < self.valid_moving_spit_attack_time) {
      continue;
    }
    closePlayer = find_player_within_distance(SPITTER_MOVE_MIN_PLAYER_DISTANCE_SQ);
    if(isDefined(closePlayer)) {
      break;
    }
  }

  release_spit_node();
  self notify("player_proximity_during_move");
  self ScrAgentSetGoalEntity(closePlayer);
  self ScrAgentSetGoalRadius(2048.0);
  self waittill("goal_reached");
}

get_possible_spitter_attack_nodes(target_entity) {
  if(get_alien_type() == "seeder")
    attackNodes = GetNodesInRadius(target_entity.origin, 768, 128, 512, "jump attack");
  else
    attackNodes = GetNodesInRadius(target_entity.origin, 1000, 300, 512, "jump attack");

  validNodes = [];

  foreach(attackNode in attackNodes) {
    if(isDefined(attackNode.claimed) && attackNode.claimed) {
      continue;
    }
    validNodes[validNodes.size] = attackNode;
  }

  return validNodes;
}

is_pet() {
  return (isDefined(self.pet) && self.pet);
}

get_current_possible_targets() {
  if(is_pet())
    return level.agentArray;
  else
    return level.players;
}

find_spitter_attack_node(target_enemy) {
  nearbySpitNodes = [];

  if(is_escape_sequence_active() && isDefined(level.escape_spitter_target_node)) {
    nearbySpitNodes = get_possible_spitter_attack_nodes(level.escape_spitter_target_node);
    if(nearbySpitNodes.size > 0)
      target_enemy = level.escape_spitter_target_node;
  }

  if(nearbySpitNodes.size == 0 && isDefined(target_enemy))
    nearbySpitNodes = get_possible_spitter_attack_nodes(target_enemy);

  if(nearbySpitNodes.size == 0) {
    possibleTargets = self get_current_possible_targets();
    foreach(possibleTarget in possibleTargets) {
      wait 0.05;

      if(!IsAlive(possibleTarget)) {
        continue;
      }
      if(isDefined(target_enemy) && possibleTarget == target_enemy) {
        continue;
      }
      nearbySpitNodes = get_possible_spitter_attack_nodes(possibleTarget);
      if(nearbySpitNodes.size > 0) {
        target_enemy = possibleTarget;
        break;
      }
    }
  }

  if(nearbySpitNodes.size == 0)
    nearbySpitNodes = get_possible_spitter_attack_nodes(self);

  if(nearbySpitNodes.size == 0)
    return undefined;

  filters = [];

  if(isDefined(target_enemy)) {
    filters["dist_from_enemy_weight"] = 8.0;
    filters["enemy_los_weight"] = 6.0;
    filters["height_weight"] = 4.0;
    target_direction = get_RL_toward(target_enemy);
    target_enemy endon("death");
  } else {
    filters["dist_from_enemy_weight"] = 0.0;
    filters["enemy_los_weight"] = 0.0;
    filters["height_weight"] = 0.0;
    target_direction = get_central_enemies_direction();
  }

  filters["direction"] = "override";
  filters["direction_override"] = target_direction;
  filters["direction_weight"] = 1.0;
  filters["min_height"] = 64.0;
  filters["max_height"] = 400.0;
  filters["enemy_los"] = true;
  filters["min_dist_from_enemy"] = 300.0;
  filters["max_dist_from_enemy"] = 800.0;
  filters["desired_dist_from_enemy"] = 600.0;
  filters["min_dist_from_all_enemies"] = 300.0;
  filters["min_dist_from_all_enemies_weight"] = 5.0;
  filters["not_recently_used_weight"] = 10.0;
  filters["recently_used_time_limit"] = 30.0;
  filters["random_weight"] = 1.0;

  result = maps\mp\agents\alien\_alien_think::get_retreat_node_rated(target_enemy, filters, nearbySpitNodes);

  return result;
}

get_central_enemies_direction() {
  possibleTargets = self get_current_possible_targets();

  if(possibleTargets.size == 0)
    return self.origin + anglesToForward(self.angles) * 100;

  centralLocation = (0, 0, 0);

  foreach(possibleTarget in possibleTargets)
  centralLocation += possibleTarget.origin;

  centralLocation = centralLocation / possibleTargets.size;

  return centralLocation - self.origin;
}

spitter_attack(enemy) {
  self endon("spitter_node_move_requested");

  if(!isDefined(self.current_spit_node)) {
    choose_spit_type("close_range");
    spit_projectile(enemy);
    self.valid_moving_spit_attack_time = GetTime() + RandomFloatRange(SPITTER_FIRE_INTERVAL_MIN, SPITTER_FIRE_INTERVAL_MAX) * 1000.0;
    return;
  }

  set_up_attack_node_watchers();

  if(!is_escape_sequence_active())
    wait RandomFloatRange(SPITTER_FIRE_INTERVAL_MIN, SPITTER_FIRE_INTERVAL_MAX) * SPITTER_NODE_INITIAL_FIRE_DELAY_SCALE;

  while(true) {
    targetedEnemy = undefined;
    no_target_time = 0.0;
    while(!isDefined(targetedEnemy)) {
      no_target_time += 0.2;
      if(no_target_time >= SPITTER_NO_TARGET_NODE_MOVE_TIME) {
        return;
      }
      wait 0.2;

      if(isDefined(enemy) && isDefined(enemy.code_classname) && enemy.code_classname == "script_vehicle") {
        targetedEnemy = enemy;
      } else {
        targetedEnemy = get_best_spit_target(enemy);
      }
    }

    choose_spit_type("long_range");
    spit_projectile(targetedEnemy);
    wait RandomFloatRange(SPITTER_FIRE_INTERVAL_MIN, SPITTER_FIRE_INTERVAL_MAX);
  }
}

choose_spit_type(default_type) {
  if(!is_pet() && can_spit_gas_cloud())
    self.spit_type = "gas_cloud";
  else
    self.spit_type = default_type;
}

set_up_attack_node_watchers() {
  self thread spitter_node_duration_monitor(SPITTER_NODE_DURATION);
  self thread spitter_node_attacked_monitor(SPITTER_NODE_DAMAGE_DELAY);

  if(!is_pet())
    self thread spitter_node_player_proximity(SPITTER_MIN_PLAYER_DISTANCE_SQ);
}

spitter_node_duration_monitor(duration) {
  self endon("spitter_node_move_requested");
  self endon("death");
  self endon("alien_main_loop_restart");

  wait duration;

  self notify("spitter_node_move_requested");
}

spitter_node_attacked_monitor(damage_delay) {
  self endon("spitter_node_move_requested");
  self endon("death");
  self endon("alien_main_loop_restart");

  self waittill("damage");
  wait damage_delay;

  self notify("spitter_node_move_requested");
}

spitter_node_player_proximity(min_player_distances_sq) {
  self endon("spitter_node_move_requested");
  self endon("death");
  self endon("alien_main_loop_restart");

  while(true) {
    closePlayer = find_player_within_distance(min_player_distances_sq);
    if(isDefined(closePlayer)) {
      break;
    }

    wait 0.2;
  }

  self notify("spitter_node_move_requested");
}

find_player_within_distance(distance_sq) {
  foreach(player in level.players) {
    if(!IsAlive(player)) {
      continue;
    }
    flatDistanceToPlayerSq = Distance2DSquared(self.origin, player.origin);
    if(flatDistanceToPlayerSq < distance_sq)
      return player;
  }

  return undefined;
}