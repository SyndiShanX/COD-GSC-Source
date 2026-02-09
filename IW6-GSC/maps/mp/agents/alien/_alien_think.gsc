/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\alien\_alien_think.gsc
*************************************************/

#include common_scripts\utility;
#include maps\mp\alien\_utility;

MIN_ATTACK_SEQUENCES = 6;
MAX_ATTACK_SEQUENCES = 9;

MIN_ATTACKS = 3;
MAX_ATTACKS = 6;

LEAP_OFFSET_XY = 48;
RECENT_TIME_LIMIT = 10.0;

onEnterAnimState(prevState, nextState) {
  self onExitAnimState(prevState, nextState);

  self.currentAnimState = nextState;

  switch (nextState) {
    case "idle":
      self maps\mp\agents\alien\_alien_idle::main();
      break;
    case "move":
      self maps\mp\agents\alien\_alien_move::main();
      break;
    case "traverse":
      self maps\mp\agents\alien\_alien_traverse::main();
      break;
    case "melee":
      self maps\mp\agents\alien\_alien_melee::main();
      break;
  }
}

onExitAnimState(prevState, nextState) {
  self notify("killanimscript");

  switch (prevState) {
    case "idle":
      self maps\mp\agents\alien\_alien_idle::end_script();
      break;
    case "move":
      self maps\mp\agents\alien\_alien_move::end_script();
      break;
    case "traverse":
      self maps\mp\agents\alien\_alien_traverse::end_script();
      break;
    case "melee":
      self maps\mp\agents\alien\_alien_melee::end_script();
      break;
  }
}

MonitorFlash() {
  self endon("death");
  while(true) {
    self waittill("flashbang", origin, percent_distance, percent_angle, attacker, teamName, extraDuration);
    switch (self.currentAnimState) {
      case "idle":
        break;
      case "move":
        self maps\mp\agents\alien\_alien_move::onFlashbanged();
        break;
    }
  }
}

onDamageFinish(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset) {
  self FinishAgentDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset, 0.0);

  if(self.health <= 0)
    return true;

  trap_damage = self is_trap(eInflictor);

  registerDamage(iDamage);

  if(isDefined(eAttacker)) {
    if(isPlayer(eAttacker) || (isDefined(eAttacker.owner) && isPlayer(eAttacker.owner))) {
      if(!trap_damage)
        eAttacker maps\mp\alien\_damage::check_for_special_damage(self, sWeapon, sMeansOfDeath);

      if(iDamage > 0)
        level.alienBBData["damage_done"] += iDamage;
    }
  }

  is_stun = should_do_stun_damage(sWeapon, sMeansOfDeath, eAttacker);

  if(!is_stun) {
    belowPainThreshold = self belowCumulativePainThreshold(eAttacker, sWeapon);

    if(sMeansOfDeath != "MOD_MELEE" && belowPainThreshold) {
      return;
    }
    if(sMeansOfDeath == "MOD_MELEE" && !belowPainThreshold && !should_melee_pushback())
      return;
  }

  if(!isDefined(vDir))
    vDir = anglesToForward(self.angles);

  notifyJumpPain(vDir, sHitLoc, iDamage, is_stun);
  clearDamageHistory();

  if(is_stun && !trap_damage) {
    self thread maps\mp\alien\_alien_fx::fx_stun_damage();
    iDFlags = iDFlags | level.iDFLAGS_STUN;
  }

  switch (self.currentAnimState) {
    case "idle":
      self maps\mp\agents\alien\_alien_idle::onDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);
      break;
    case "move":
      self maps\mp\agents\alien\_alien_move::onDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);
      break;
    case "melee":
      self maps\mp\agents\alien\_alien_melee::onDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset);
      break;
  }

  return true;
}

should_do_stun_damage(sWeapon, sMeansofDeath, eAttacker) {
  if(self get_alien_type() == "elite")
    return false;

  if(is_true(self.is_burning))
    return false;

  if(isDefined(eAttacker) && isPlayer(eAttacker) && sMeansofDeath != "MOD_MELEE") {
    using_primary = isDefined(sWeapon) && (sWeapon == eAttacker GetCurrentPrimaryWeapon());

    return using_primary && (eAttacker maps\mp\alien\_utility::has_stun_ammo());
  }
  return false;
}

should_melee_pushback() {
  if(self get_alien_type() == "elite")
    return false;

  return true;
}

notifyJumpPain(damageDirection, hitLocation, iDamage, stun) {
  self notify("jump_pain", damageDirection, hitLocation, iDamage, stun);
}

clearDamageHistory() {
  self.recentDamages = [];
  self.damageListIndex = 0;
}

registerDamage(iDamage) {
  damageInfo = [];
  damageInfo["amount"] = iDamage;
  damageInfo["time"] = getTime();

  self.recentDamages[self.damageListIndex] = damageInfo;
  self.damageListIndex++;

  if(self.damageListIndex == level.damageListSize)
    self.damageListIndex = 0;
}

belowCumulativePainThreshold(eAttacker, sWeapon) {
  alien_type = get_alien_type();
  recentCumulativeDamage = getCumulativeDamage();

  threshold = level.alien_types[alien_type].attributes["min_cumulative_pain_threshold"];

  return (recentCumulativeDamage < threshold);
}

getCumulativeDamage() {
  alien_type = get_alien_type();
  lookBackTime = level.alien_types[alien_type].attributes["min_cumulative_pain_buffer_time"] * 1000.0;

  recentCumDamage = 0;
  currentTime = getTime();
  for(i = 0; i < self.recentDamages.size; i++) {
    if(currentTime - self.recentDamages[i]["time"] < lookBackTime)
      recentCumDamage += self.recentDamages[i]["amount"];
  }
  return recentCumDamage;
}

GetTargetPredictedPosition(target, timeFromNow) {
  targetVel = target GetEntityVelocity();
  predictedPos = target.origin + (timeFromNow * targetVel);

  return predictedPos;
}

GetAttackPosition(target, attackDist, timeFromNow) {
  alienRadius = 15;

  targetPredictedPosition = self GetTargetPredictedPosition(target, timeFromNow);

  targetToMe = VectorNormalize(self.origin - targetPredictedPosition);
  attackPos = targetPredictedPosition + targetToMe * attackDist;

  attackPos = GetGroundPosition(attackPos, alienRadius, 64, 64);

  return attackPos;
}

AttemptMelee() {
  if(!isDefined(self.enemy))
    return false;

  self ScrAgentBeginMelee(self.enemy);
  return true;
}

ALIEN_LEAP_MELEE_DISTANCE_MAX = 400;
ALIEN_APPROACH_DIST_SQR = 250000.0;
ALIEN_JOG_CHANGE_DISTANCE = 2000;
ALIEN_LEAP_MELEE_DISTANCE_MIN = 208;
ALIEN_MIN_MELEE_DISTANCE = 100;
ALIEN_DISTANCE_DO_DAMAGE_WHEN_RETREAT = 256;
ALIEN_PROXIMITY_CHECK_ACTIVATION_DISTANCE = 256;
ALIEN_GOAL_RADIUS_ADJUSTMENT = -48;
ALIEN_NODE_GOAL_RADIUS = 64;

main() {
  self endon("death");

  waitframe();

  debugTestDome = false;
  debugTestEnvPrototype = false;

  if(should_react_to_downed_enemies())
    self thread downed_enemy_monitor();

  while(1) {
    if(debugTestDome)
      self alien_test_loop();
    else if(debugTestEnvPrototype)
      self alien_test_jump();
    else
      self alien_main_loop();
  }
}

should_react_to_downed_enemies() {
  switch (get_alien_type()) {
    case "elite":
    case "spitter":
    case "seeder":
    case "minion":
    case "gargoyle":
      return false;
    default:
      return true;
  }
}

downed_enemy_monitor() {
  self endon("death");

  while(true) {
    if(!isPlayer(self.enemy)) {
      wait 0.05;
      continue;
    }

    self thread monitor_enemy_for_downed(self.enemy);
    self common_scripts\utility::waittill_any("downed_enemy", "enemy");
  }
}

monitor_enemy_for_downed(enemy) {
  self endon("enemy");
  self endon("death");

  enemy waittill_any("death", "last_stand");

  MAX_DISTANCE_FOR_DOWNED_SQ = 256 * 256;

  if(DistanceSquared(enemy.origin, self.origin) < MAX_DISTANCE_FOR_DOWNED_SQ) {
    self.enemy_downed = true;
    self.downed_enemy_location = enemy.origin;
  }

  self notify("downed_enemy");
}

alien_test_loop() {
  movePosList = [(-296, 448, -352), (808, 300, -368), (1320.6, 482.8, -320)];

  wait(10);

  while(true) {
    foreach(pos in movePosList) {
      if(DistanceSquared(self.origin, pos) < 100) {
        continue;
      }
      self ScrAgentSetGoalPos(pos);
      self waittill("goal_reached");
      wait(3);
    }
  }
}

alien_test_jump() {
  movePosList = [(-203.3, -898, 151.03304), (-1282.2, -669.1, -26.529)];

  wait(10);

  while(true) {
    foreach(pos in movePosList) {
      if(DistanceSquared(self.origin, pos) < 100) {
        continue;
      }
      self ScrAgentSetGoalPos(pos);
      self waittill("goal_reached");
      wait(3);
    }
  }
}

handle_attractor_flare(flare, is_active) {
  if(is_active) {
    self.attractor_flare = flare;
  } else {
    if(!isDefined(self.attractor_flare)) {
      return;
    }
    if(isDefined(flare) && flare != self.attractor_flare) {
      return;
    }
    self.attractor_flare = undefined;
  }

  self notify("alien_main_loop_restart");
}

react_to_attractor_flare() {
  MIN_WAIT_TIME = 3.0;
  MAX_WAIT_TIME = 6.0;

  attractNode = get_flare_node();
  if(isDefined(attractNode)) {
    self ScrAgentSetGoalNode(attractNode);
    self ScrAgentSetGoalRadius(64.0);
    self waittill("goal_reached");

    while(isDefined(self.attractor_flare))
      wait 0.2;
  }
}

get_flare_node() {
  attractNodes = GetNodesInRadius(self.attractor_flare.origin, 300, 50, 128, "path");

  if(attractNodes.size == 0)
    return undefined;

  inBetweenNodes = [];
  flareToAlien = VectorNormalize(self.origin - self.attractor_flare.origin);

  foreach(possibleNode in attractNodes) {
    flareToNode = VectorNormalize(possibleNode.origin - self.attractor_flare.origin);
    if(VectorDot(flareToNode, flareToAlien) < 0) {
      continue;
    }
    inBetweenNodes[inBetweenNodes.size] = possibleNode;
  }

  if(inBetweenNodes.size == 0)
    return attractNodes[RandomInt(attractNodes.size)];

  return inBetweenNodes[RandomInt(inBetweenNodes.size)];
}

alien_main_loop() {
  self endon("alien_main_loop_restart");
  while(1) {
    self.looktarget = undefined;
    enemy = self.enemy;
    if(isDefined(self.alien_scripted) && self.alien_scripted == true) {} else if(isDefined(self.attractor_flare)) {
      react_to_attractor_flare();
    } else if(isDefined(self.enemy_downed) && self.enemy_downed) {
      posture_after_enemy_downed();
      self.enemy_downed = false;
      self.downed_enemy_location = undefined;
    } else if(IsAlive(enemy)) {
      if(self.badpath) {
        [[level.alien_funcs[get_alien_type()]["badpath"]]](enemy);
      } else {
        [[level.alien_funcs[get_alien_type()]["combat"]]](enemy);
      }
    } else {
      if(isDefined(self.pet) && self.pet) {
        alien_pet_follow();
      } else {
        alien_noncombat();
      }
    }
    wait 0.05;
  }
}

posture_after_enemy_downed() {
  self endon("damage");
  self endon("enemy_downed_proximity_breached");

  MIN_WAIT_TIME = 4.0;
  MAX_WAIT_TIME = 6.0;

  postureNode = get_downed_posture_node();

  if(isDefined(postureNode)) {
    self ScrAgentSetGoalNode(postureNode);
    self ScrAgentSetGoalRadius(64.0);
    self waittill("goal_reached");
  }

  self thread monitor_enemy_proximity_during_enemy_downed();
  wait RandomFloatRange(MIN_WAIT_TIME, MAX_WAIT_TIME);
}

monitor_enemy_proximity_during_enemy_downed() {
  self endon("death");
  self endon("damage");
  self endon("alien_main_loop_restart");

  ENEMY_PROXIMITY_RANGE_SQ = 128 * 128;

  while(true) {
    foreach(player in level.players) {
      if(DistanceSquared(player.origin, self.origin) < ENEMY_PROXIMITY_RANGE_SQ) {
        self notify("enemy_downed_proximity_breached");
        return;
      }
    }

    wait 0.1;
  }
}

get_downed_posture_node() {
  postureNodes = GetNodesInRadius(self.origin, 300, 50, 128, "path");
  if(postureNodes.size == 0) {
    return;
  }

  filters = [];

  filters["direction"] = "override";
  filters["direction_override"] = VectorNormalize(self.origin - self.downed_enemy_location);
  filters["direction_weight"] = 10.0;
  filters["min_height"] = 64.0;
  filters["max_height"] = 400.0;
  filters["height_weight"] = 0.0;
  filters["enemy_los"] = false;
  filters["enemy_los_weight"] = 0.0;
  filters["min_dist_from_enemy"] = 400.0;
  filters["max_dist_from_enemy"] = 800.0;
  filters["desired_dist_from_enemy"] = 600.0;
  filters["dist_from_enemy_weight"] = 0.0;
  filters["min_dist_from_all_enemies"] = 200.0;
  filters["min_dist_from_all_enemies_weight"] = 6.0;
  filters["not_recently_used_weight"] = 2.0;
  filters["random_weight"] = 1.0;

  result = get_retreat_node_rated(self.enemy, filters, postureNodes);

  return result;
}

default_alien_combat(enemy) {
  enemy endon("death");
  self endon("enemy");
  self endon("bad_path");

  self clear_attacking(enemy);

  while(IsAlive(enemy)) {
    self.looktarget = enemy;
    if(should_i_attack(enemy)) {
      self set_attacking(enemy);
      self alien_attack_enemy(enemy);
      self clear_attacking(enemy);

      if(should_i_retreat(enemy))
        alien_retreat(enemy);
    } else {
      alien_wait_for_combat(enemy);
    }
  }
}

alien_attack_enemy(enemy) {
  if(use_synched_attack(enemy))
    self alien_synch_attack_enemy(enemy);
  else
    self alien_attack_sequence(enemy);
}

use_synched_attack(enemy) {
  switch (get_alien_type()) {
    case "elite":
    case "spitter":
    case "seeder":
    case "minion":
    case "locust":
    case "gargoyle":
    case "mammoth":
      return false;

    default:
      break;
  }

  return isDefined(enemy.synch_attack_setup);
}

alien_attack_sequence(enemy) {
  num_attack_sequences = get_attack_sequence_num();
  for(attack_sequences = 0; attack_sequences < num_attack_sequences; attack_sequences++) {
    num_attacks = get_attack_num();
    for(attack = 0; attack < num_attacks; attack++) {
      if(has_attack_abort_been_requested(self)) {
        return;
      }
      attack_type = [[level.alien_funcs[get_alien_type()]["approach"]]](enemy, attack);

      alien_attack(enemy, attack_type);

      if(DistanceSquared(self.origin, self.enemy.origin) < 64 * 64) {
        break;
      }
    }
  }
}

alien_synch_attack_enemy(enemy) {
  if(Distance2DSquared(self.origin, enemy.origin) > ALIEN_MIN_MELEE_DISTANCE) {
    self ScrAgentSetGoalRadius(ALIEN_MIN_MELEE_DISTANCE);
    self ScrAgentSetGoalEntity(enemy);
    self waittill("goal_reached");
  }

  hasValidSynchAttacker = (IsAlive(enemy.synch_attack_setup.primary_attacker) && enemy.synch_attack_setup.primary_attacker != self);
  canbeAttacked = true;
  if(isDefined(enemy.synch_attack_setup.can_synch_attack_func))
    canbeAttacked = enemy[[enemy.synch_attack_setup.can_synch_attack_func]]();

  if(!hasValidSynchAttacker && canbeAttacked) {
    enemy.synch_attack_setup.primary_attacker = self;
    select_synch_index(enemy);

    if(should_move_to_synch_attack_pos(enemy)) {
      self ScrAgentSetGoalRadius(30);
      self ScrAgentSetGoalPos(self.synch_attack_pos);
      self waittill("goal_reached");
    }

    synch_melee(enemy);
  } else {
    swipe_static_melee(enemy);
  }
}

select_synch_index(enemy) {
  synchList = enemy get_synch_direction_list(self);
  enemyToSelf = VectorNormalize(self.origin - enemy.origin);
  bestSynchAttackIndex = undefined;
  bestSynchAnimState = undefined;
  bestSynchAttackPos = undefined;
  bestOffsetAngle = -1.1;

  foreach(index, synchPos in synchList) {
    synchAnimState = synchPos["attackerAnimState"];
    attackAnim = self GetAnimEntry(synchAnimState, 0);

    offsetPos = GetStartOrigin(enemy.origin, enemy.angles, attackAnim);
    offset = Length(offsetPos - enemy.origin);
    rotatedOffset = synchPos["offset_direction"] * offset;
    synchAttackPos = enemy LocalToWorldCoords(rotatedOffset);

    enemyToSynchPos = VectorNormalize(synchAttackPos - enemy.origin);
    offsetAngle = VectorDot(enemyToSynchPos, enemyToSelf);

    if(offsetAngle > bestOffsetAngle) {
      bestSynchAttackIndex = index;
      bestSynchAnimState = synchAnimState;
      bestSynchAttackPos = synchAttackPos;
      bestOffsetAngle = offsetAngle;
    }
  }

  self.synch_attack_index = bestSynchAttackIndex;
  self.synch_anim_state = bestSynchAnimState;
  self.synch_attack_pos = bestSynchAttackPos;
}

should_move_to_synch_attack_pos(enemy) {
  COS_45 = 0.707;

  enemyToPos = VectorNormalize(self.synch_attack_pos - enemy.origin);
  enemyToSelf = VectorNormalize(self.origin - enemy.origin);
  isInSameDirection = VectorDot(enemyToPos, enemyToSelf) > COS_45;
  isFurther = DistanceSquared(enemy.origin, self.origin) > DistanceSquared(enemy.origin, self.synch_attack_pos);

  return isFurther || !isInSameDirection;
}

alien_attack(enemy, attack_type) {
  self notify("start_attack");

  switch (attack_type) {
    case "swipe":
      swipe_melee(enemy);
      break;
    case "leap":
      leap_melee(enemy);
      break;
    case "wall":
      wall_leap_melee(enemy);
      break;
    case "badpath_jump":
      badpath_jump(enemy);
      break;
    case "spit":
      maps\mp\agents\alien\_alien_spitter::spit_projectile(enemy);
      break;
    case "charge":
      maps\mp\agents\alien\_alien_elite::charge_attack(enemy);
      break;
    case "slam":
      maps\mp\agents\alien\_alien_elite::ground_slam(enemy);
      break;
    case "angered":
      maps\mp\agents\alien\_alien_elite::angered(enemy);
      break;
    case "synch":
      synch_melee(enemy);
      break;
    case "swipe_static":
      swipe_static_melee(enemy);
      break;
    case "explode":
      maps\mp\agents\alien\_alien_minion::explode_attack(enemy);
    case "none":

      break;
    default:
      if(isDefined(level.alien_attack_override_func))
        if([[level.alien_attack_override_func]](enemy, attack_type)) {
          break;
        }

      iprintln("Invalid alien attack_type: " + attack_type);
      wait 1;
      break;
  }
}

MAX_BADPATH_MELEE_NODE_DISTANCE = 256;
MAX_BADPATH_SWIPE_HEIGHT_DIFFERENCE = 50;
MAX_BADPATH_JUMP_HEIGHT_DIFFERENCE = 128;
MAX_BADPATH_LEAP_DROP_DISTANCE = 256;
MAX_BADPATH_MELEE_DISTANCE = 150;

handle_badpath(enemy) {
  enemy endon("death");
  enemy endon("disconnect");
  self endon("bad_path");
  debug_alien_ai_state("handle_badpath");
  self.badpath = false;

  if(!can_attempt_badpath_move()) {
    return;
  }
  if(self.badpathcount > 3) {
    if(attempt_bad_path_move_nearby_node(enemy))
      self.badpathcount = 0;

    return;
  }

  if(!should_bad_path_melee()) {
    return;
  }
  if(self.badpathcount == 1)
    moveSuccess = attempt_badpath_move_to_node(enemy, 0, ALIEN_MIN_MELEE_DISTANCE, MAX_BADPATH_SWIPE_HEIGHT_DIFFERENCE);
  else
    moveSuccess = false;

  if(!moveSuccess) {
    moveSuccess = attempt_badpath_move_to_node(enemy, ALIEN_MIN_MELEE_DISTANCE, MAX_BADPATH_MELEE_NODE_DISTANCE, MAX_BADPATH_JUMP_HEIGHT_DIFFERENCE);
    if(!moveSuccess)
      return;
  }

  if(attempt_bad_path_melee(enemy))
    self.badpathcount = 0;
}

can_attempt_badpath_move() {
  switch (self.currentAnimState) {
    case "traverse":
      return false;
    default:
      return true;
  }
}

should_bad_path_melee() {
  switch (get_alien_type()) {
    case "spitter":
    case "seeder":
      return false;
    default:
      return true;
  }
}

attempt_bad_path_move_nearby_node(enemy) {
  MIN_JUMP_NODE_DISTANCE = 128;
  MAX_JUMP_NODE_DISTANCE = 512;

  nodes = GetNodesInRadius(self.origin, MAX_JUMP_NODE_DISTANCE, MIN_JUMP_NODE_DISTANCE, 256, "node_pathnode");
  if(nodes.size == 0)
    return false;

  self ScrAgentSetGoalPos(self.origin);
  self ScrAgentSetGoalRadius(2048);
  targetNode = nodes[RandomInt(nodes.size)];
  if(self attempt_badpath_jump(enemy, targetNode)) {
    return true;
  } else {
    self ScrAgentSetGoalNode(targetNode);
    self ScrAgentSetGoalRadius(64);
    self waittill("goal_reached");
    return true;
  }

  return false;
}

attempt_bad_path_melee(enemy) {
  heightDifference = abs(self.origin[2] - enemy.origin[2]);
  distanceToEnemy = Distance2D(self.origin, enemy.origin);

  if(distanceToEnemy > MAX_BADPATH_MELEE_NODE_DISTANCE)
    return false;

  canSeeEnemy = self AgentCanSeeSentient(enemy);

  if(canSeeEnemy && heightDifference <= MAX_BADPATH_SWIPE_HEIGHT_DIFFERENCE && distanceToEnemy <= MAX_BADPATH_MELEE_DISTANCE) {
    self.bad_path_handled = true;

    if(maps\mp\alien\_utility::should_explode()) {
      alien_attack(enemy, "explode");
      return true;
    } else if(is_normal_upright(AnglesToUp(self.angles))) {
      alien_attack(enemy, "swipe");
      return true;
    }
  }

  self.leapEndPos = self maps\mp\agents\alien\_alien_melee::get_leap_end_pos(1.0, LEAP_OFFSET_XY, enemy);
  leapEndGroundPos = maps\mp\agents\_scriptedAgents::DropPosToGround(self.leapEndPos, MAX_BADPATH_LEAP_DROP_DISTANCE);

  if(!isDefined(leapEndGroundPos)) {
    return false;
  }

  if(!TrajectoryCanAttemptAccurateJump(self.origin, AnglesToUp(self.angles), self.leapEndPos, AnglesToUp(enemy.angles), level.alien_jump_melee_gravity, 1.01 * level.alien_jump_melee_speed)) {
    return false;
  }

  nodes = GetNodesInRadiusSorted(leapEndGroundPos, 256, 0, 256);
  if(!nodes.size) {
    return false;
  }

  pathdist = GetPathDist(leapEndGroundPos, nodes[0].origin, 512);
  if(pathDist < 0) {
    return false;
  }

  leap_melee(enemy);
  return true;
}

attempt_badpath_move_to_node(enemy, min_distance, max_distance, height_difference) {
  nodes = GetNodesInradius(enemy.origin, max_distance, min_distance, height_difference);

  if(nodes.size > 0) {
    moveNode = nodes[RandomInt(nodes.size)];
    self ScrAgentSetGoalNode(moveNode);
    self ScrAgentSetGoalRadius(ALIEN_NODE_GOAL_RADIUS);
    self waittill("goal_reached");
    return true;
  }

  wait 0.1;
  return false;
}

attempt_badpath_jump(enemy, node) {
  traceResult = TrajectoryCanAttemptAccurateJump(self.origin, AnglesToUp(self.angles), node.origin, AnglesToUp(node.angles), level.alien_jump_melee_gravity, 1.01 * level.alien_jump_melee_speed);

  if(traceResult || self.oriented) {
    self.leapEndPos = node.origin;
    self.leapEndAngles = node.angles;
    self alien_attack(enemy, "badpath_jump");
    self ScrAgentSetGoalPos(self.origin);
    self ScrAgentSetGoalRadius(2048);
    self waittill("goal_reached");
  }
  wait 0.5;

  return traceResult;
}

restart_loop_near_enemy(enemy) {
  self endon("alien_main_loop_restart");
  enemy endon("death");
  self endon("death");
  self endon("bad_path");

  DIST_TO_ENEMY_SQR = 256.0 * 256.0;
  while(1) {
    if(DistanceSquared(self.origin, enemy.origin) < DIST_TO_ENEMY_SQR) {
      self notify("alien_main_loop_restart");
    }
    wait 0.05;
  }
}

set_attacking(enemy) {
  assert(!array_contains(enemy.current_attackers, self));

  enemy.current_attackers[enemy.current_attackers.size] = self;
  self.attacking_player = true;
  self.bypass_max_attacker_counter = false;
}

clear_attacking(enemy) {
  if(!isDefined(enemy.current_attackers))
    enemy.current_attackers = [];

  enemy.current_attackers = array_remove(enemy.current_attackers, self);
  self.attacking_player = false;
  self.abort_attack_requested = false;
}

clean_up_attackers() {
  new_attackers = [];
  foreach(enemy in self.current_attackers) {
    if(isAlive(enemy) && isAlive(enemy.enemy) && enemy.enemy == self) {
      new_attackers[new_attackers.size] = enemy;
    }
  }

  self.current_attackers = new_attackers;
}

should_i_attack(enemy) {
  if(!is_idle_state_locked() && self.stateLocked)
    return false;

  enemy clean_up_attackers();

  return true;
}

should_i_retreat(enemy) {
  if(isDefined(level.dlc_alien_can_retreat_override_func)) {
    if(![[level.dlc_alien_can_retreat_override_func]](enemy))
      return false;
  }

  switch (get_alien_type()) {
    case "elite":
      return false;
    default:
      return true;
  }
}

replace_attacker_request(attacker) {
  attacker.abort_attack_requested = true;
}

has_attack_abort_been_requested(attacker) {
  return isDefined(attacker.abort_attack_requested) && attacker.abort_attack_requested;
}

find_attacker_to_replace(enemy, current_attacker_value) {
  priority = level.alien_types[self.alien_type].attributes["attacker_priority"];
  requiredReplaceValue = level.alien_types[self.alien_type].attributes["attacker_difficulty"] - (level.maxAlienAttackerDifficultyValue - current_attacker_value);
  replacedAttackers = [];
  foreach(attacker in enemy.current_attackers) {
    if(has_attack_abort_been_requested(attacker)) {
      continue;
    }
    if(priority < level.alien_types[attacker.alien_type].attributes["attacker_priority"]) {
      requiredReplaceValue -= level.alien_types[attacker.alien_type].attributes["attacker_difficulty"];
      replacedAttackers[replacedAttackers.size] = attacker;

      if(requiredReplaceValue <= 0) {
        break;
      }
    }
  }

  return replacedAttackers;
}

get_current_attacker_value(enemy) {
  attackerValue = 0.0;
  if(!isDefined(enemy.current_attackers))
    return attackerValue;

  foreach(attacker in enemy.current_attackers) {
    if(!IsAlive(attacker)) {
      continue;
    }
    if(has_attack_abort_been_requested(attacker)) {
      continue;
    }
    attackerValue += level.alien_types[attacker.alien_type].attributes["attacker_difficulty"];
  }

  return attackerValue;
}

alien_noncombat() {
  self ScrAgentSetGoalPos(self.origin);
  while(1) {
    if(IsAlive(self.enemy)) {
      break;
    }

    wait 1;
  }
}

alien_pet_follow() {
  follow_dist = 768;
  if(isDefined(self.petFollowDist))
    follow_dist = self.petFollowDist;

  follow_dist_sqr = follow_dist * follow_dist;

  self ScrAgentSetGoalRadius(follow_dist);

  while(!IsAlive(self.enemy)) {
    if(!isDefined(self.owner) || !IsAlive(self.owner)) {
      alive_player = undefined;
      foreach(player in level.players) {
        if(isalive(player)) {
          alive_player = player;
          break;
        }
      }
      if(isDefined(alive_player)) {
        self.owner = alive_player;
      } else {
        self ScrAgentSetGoalPos(self.origin);
      }
    } else {
      current_dist_sqr = DistanceSquared(self.owner.origin, self.origin);
      if(current_dist_sqr > follow_dist_sqr) {
        target_node = self get_pet_follow_node(self.owner);
        if(!isDefined(target_node)) {
          wait 1.0;
          continue;
        }
        self ScrAgentSetGoalNode(target_node);
        self ScrAgentSetGoalRadius(ALIEN_NODE_GOAL_RADIUS);
        self waittill("goal_reached");
        wait RandomFloatRange(0.5, 1.5);
      }
    }
    wait 0.05;
  }
}

alien_wait_for_combat(enemy) {
  self endon("go to combat");

  debug_alien_ai_state("wait_for_combat");
  self thread monitor_proximity_with_enemy(enemy);
  self thread watch_for_damage(enemy);
  self thread random_movemode_change(0, 70, 30, 1.5, 3.0);

  while(1) {
    should_go_left = cointoss();

    nodes = GetNodesInRadius(self.origin, 512, 256, 256);

    if(nodes.size == 0) {
      wait 1;
      self notify("go to combat");
      return;
    }

    enemy_to_alien_vector = self.origin - enemy.origin;
    enemy_to_alien_angle = VectorToAngles(enemy_to_alien_vector);
    override_vector = AnglesToRight(enemy_to_alien_angle);
    if(should_go_left) {
      override_vector = override_vector * -1;
    }
    filters = [];
    filters["direction"] = "override";
    filters["direction_weight"] = 2.0;
    filters["min_height"] = -32.0;
    filters["max_height"] = 128.0;
    filters["height_weight"] = 1.0;
    filters["enemy_los"] = true;
    filters["enemy_los_weight"] = 2.0;
    filters["min_dist_from_enemy"] = 600.0;
    filters["max_dist_from_enemy"] = 1000.0;
    filters["desired_dist_from_enemy"] = 800.0;
    filters["dist_from_enemy_weight"] = 3.0;
    filters["min_dist_from_all_enemies"] = 400.0;
    filters["min_dist_from_all_enemies_weight"] = 1.0;
    filters["not_recently_used_weight"] = 4.0;
    filters["random_weight"] = 1.0;
    filters["direction_override"] = override_vector;

    node_to_go = get_retreat_node_rated(enemy, filters, nodes);
    self ScrAgentSetGoalNode(node_to_go);
    self ScrAgentSetGoalRadius(ALIEN_NODE_GOAL_RADIUS);
    self waittill("goal_reached");
    wait RandomFloatRange(1.5, 3.5);

    if(should_i_attack(enemy)) {
      self notify("go to combat");
      break;
    }
  }
}

alien_retreat(enemy) {
  self notify("start retreat");
  self set_alien_movemode("run");

  retreat_type = "elevated_delay";
  retreat_direction = "alien_forward";

  if(!isDefined(retreat_type) || retreat_type == "")
    retreat_type = "randomize";
  if(!isDefined(retreat_direction) || retreat_direction == "")
    retreat_direction = "alien_forward";

  if(retreat_type == "randomize") {
    random_array = ["elevated_delay", "cover", "cover", "cover"];
    choice = randomint(4);
    retreat_type = random_array[choice];
  }

  switch (retreat_type) {
    case "elevated_delay":
      elevated_delay_retreat(enemy, retreat_direction);
      break;
    case "cover":
      cover_retreat(enemy, retreat_direction);
      break;
    default:
      iprintln("Invalid alien_retreat_type: " + retreat_type);
      wait 1;
      break;
  }
}

monitor_proximity_with_enemy(enemy) {
  self endon("go to combat");
  self endon("damage");
  self endon("death");
  self endon("alien_main_loop_restart");
  enemy endon("death");
  enemy endon("disconnect");

  wait_for_proximity_check_activation(enemy);

  while(1) {
    if(DistanceSquared(self.origin, enemy.origin) < ALIEN_DISTANCE_DO_DAMAGE_WHEN_RETREAT * ALIEN_DISTANCE_DO_DAMAGE_WHEN_RETREAT) {
      self.attack_sequence_num = 1;
      self.attack_num = 1;
      self.bypass_max_attacker_counter = true;
      self notify("go to combat");
      break;
    }
    waitframe();
  }
}

watch_for_damage(enemy) {
  self endon("go to combat");
  self endon("death");
  self endon("alien_main_loop_restart");
  enemy endon("death");

  self waittill("damage");

  self.bypass_max_attacker_counter = true;
  self notify("go to combat");
}

wait_for_proximity_check_activation(enemy) {
  time_out_sec = 2;
  current_time = getTime();

  while(1) {
    if(DistanceSquared(self.origin, enemy.origin) > ALIEN_PROXIMITY_CHECK_ACTIVATION_DISTANCE * ALIEN_PROXIMITY_CHECK_ACTIVATION_DISTANCE) {
      break;
    } else if((getTime() - current_time) > time_out_sec * 1000) {
      break;
    }
    waitframe();
  }
}

elevated_delay_retreat(enemy, direction) {
  debug_alien_ai_state("elevated_delay_retreat");
  elevated_jump_node = self get_elevated_jump_node(enemy, direction);
  if(!isDefined(elevated_jump_node)) {
    wait 0.05;
    return;
  }

  self ScrAgentSetGoalNode(elevated_jump_node);
  self ScrAgentSetGoalRadius(32);
  self waittill("goal_reached");
  wait 1.5;
}

get_elevated_jump_node(enemy, direction) {
  jump_nodes = GetNodesInRadius(enemy.origin, 800, 400, 256, "jump");
  if(jump_nodes.size == 0) {
    return;
  }

  filters = [];
  if(GetDvarInt("alien_retreat_towards_spawn") == 1) {
    filters["direction"] = "override";
    filters["direction_override"] = VectorNormalize(self.spawnOrigin - enemy.origin);
    filters["direction_weight"] = 8.0;
  } else {
    filters["direction"] = direction;
    filters["direction_weight"] = 1.0;
  }

  filters["min_height"] = 64.0;
  filters["max_height"] = 400.0;
  filters["height_weight"] = 2.0;
  filters["enemy_los"] = true;
  filters["enemy_los_weight"] = 2.0;
  filters["min_dist_from_enemy"] = 400.0;
  filters["max_dist_from_enemy"] = 800.0;
  filters["desired_dist_from_enemy"] = 600.0;
  filters["dist_from_enemy_weight"] = 3.0;
  filters["min_dist_from_all_enemies"] = 200.0;
  filters["min_dist_from_all_enemies_weight"] = 1.0;
  filters["not_recently_used_weight"] = 4.0;
  filters["random_weight"] = 1.0;

  result = get_retreat_node_rated(enemy, filters, jump_nodes);

  return result;
}

cover_retreat(enemy, direction) {
  EXTRA_COVER_NODE_AFTER_1ST_COVER = 1;

  debug_alien_ai_state("cover_retreat");
  self endon("go to combat");

  self thread monitor_proximity_with_enemy(enemy);
  self thread watch_for_damage(enemy);

  filters = [];
  if(GetDvarInt("alien_cover_node_retreat") == 1) {
    filters["direction"] = "cover";
    filters["direction_weight"] = 2.0;
    filters["enemy_los_weight"] = 0.0;
    filters["max_dist_from_enemy"] = 1200.0;
  } else if(GetDvarInt("alien_retreat_towards_spawn") == 1) {
    filters["direction"] = "override";
    filters["direction_override"] = VectorNormalize(self.spawnOrigin - enemy.origin);
    filters["direction_weight"] = 8.0;
    filters["enemy_los_weight"] = 6.0;
    filters["max_dist_from_enemy"] = 800.0;
  } else {
    filters["direction"] = direction;
    filters["direction_weight"] = 1.0;
    filters["enemy_los_weight"] = 6.0;
    filters["max_dist_from_enemy"] = 800.0;
  }

  filters["min_height"] = -32.0;
  filters["max_height"] = 128.0;
  filters["height_weight"] = 1.0;
  filters["enemy_los"] = false;
  filters["min_dist_from_enemy"] = 400.0;
  filters["desired_dist_from_enemy"] = 600.0;
  filters["dist_from_enemy_weight"] = 2.0;
  filters["min_dist_from_all_enemies"] = 200.0;
  filters["min_dist_from_all_enemies_weight"] = 1.0;
  filters["min_dist_from_current_position"] = 256.0;
  filters["min_dist_from_current_position_weight"] = 3.0;
  filters["not_recently_used_weight"] = 4.0;
  filters["random_weight"] = 1.0;

  cover_node = self get_cover_node(enemy, filters);
  if(!isDefined(cover_node)) {
    return;
  }

  self ScrAgentSetGoalNode(cover_node);
  self ScrAgentSetGoalRadius(ALIEN_NODE_GOAL_RADIUS);
  self waittill("goal_reached");

  for(i = 0; i < EXTRA_COVER_NODE_AFTER_1ST_COVER; i++) {
    filters["direction"] = "alien_forward";
    cover_node = self get_cover_node(enemy, filters);
    if(!isDefined(cover_node)) {
      return;
    }

    self ScrAgentSetGoalNode(cover_node);
    self ScrAgentSetGoalRadius(ALIEN_NODE_GOAL_RADIUS);
    self waittill("goal_reached");
  }
}

get_cover_node(enemy, filters) {
  if(GetDvarInt("alien_cover_node_retreat") == 1)
    nodes = GetNodesInRadius(enemy.origin, 800, 400, 256, "cover stand");
  else
    nodes = GetNodesInRadius(enemy.origin, 800, 400, 256);

  if(nodes.size == 0) {
    return undefined;
  }

  result = get_retreat_node_rated(enemy, filters, nodes);

  return result;
}

circling_retreat(enemy, direction) {
  debug_alien_ai_state("circling_retreat");
  self endon("go to combat");

  self thread monitor_proximity_with_enemy(enemy);
  self thread watch_for_damage(enemy);

  nodes = GetNodesInRadius(enemy.origin, 800, 400, 256);

  if(nodes.size == 0) {
    alien_path_error("Unable to find any node within 150-unit to 800-unit radius.Talk to level designer.");
    nodes = GetNodesInRadius(enemy.origin, 2000, 400, 256);
  }

  filters = [];
  filters["direction"] = direction;
  filters["direction_weight"] = 1.0;
  filters["min_height"] = -32.0;
  filters["max_height"] = 32.0;
  filters["height_weight"] = 2.0;
  filters["enemy_los"] = true;
  filters["enemy_los_weight"] = 2.0;
  filters["min_dist_from_enemy"] = 400.0;
  filters["max_dist_from_enemy"] = 800.0;
  filters["desired_dist_from_enemy"] = 600.0;
  filters["dist_from_enemy_weight"] = 3.0;
  filters["min_dist_from_all_enemies"] = 200.0;
  filters["min_dist_from_all_enemies_weight"] = 1.0;
  filters["not_recently_used_weight"] = 4.0;
  filters["random_weight"] = 2.0;

  first_circle_node = get_retreat_node_rated(enemy, filters, nodes);

  self ScrAgentSetGoalNode(first_circle_node);
  self ScrAgentSetGoalRadius(ALIEN_NODE_GOAL_RADIUS);
  self waittill("goal_reached");

  should_go_left = RandomInt(2);
  for(i = 0; i < (GetDvarInt("alien_circling_retreat_num_nodes") - 1); i++) {
    enemy_to_alien_vector = self.origin - enemy.origin;
    enemy_to_alien_angle = VectorToAngles(enemy_to_alien_vector);
    override_vector = AnglesToRight(enemy_to_alien_angle);
    if(should_go_left) {
      override_vector = override_vector * -1;
    }
    nodes = GetNodesInRadius(enemy.origin, 800, 500, 256);
    if(nodes.size == 0) {
      alien_path_error("Unable to find any node within 500-unit to 800-unit radius.Talk to level designer.");
      nodes = GetNodesInRadius(enemy.origin, 2000, 400, 256);
    }

    filters["direction"] = "override";
    filters["direction_override"] = override_vector;
    filters["direction_weight"] = 2.0;
    filters["random_weight"] = 1.0;
    filters["min_dist_from_current_position"] = 256.0;
    filters["min_dist_from_current_position_weight"] = 3.0;
    next_circle_node = get_retreat_node_rated(enemy, filters, nodes);

    self ScrAgentSetGoalNode(next_circle_node);
    self ScrAgentSetGoalRadius(ALIEN_NODE_GOAL_RADIUS);
    self waittill("goal_reached");
  }
}

elevated_circling_retreat(enemy, direction) {
  debug_alien_ai_state("elevated_circling_retreat");
  self endon("go to combat");

  self thread monitor_proximity_with_enemy(enemy);
  self thread watch_for_damage(enemy);

  elevated_jump_node = self get_elevated_jump_node(enemy, direction);
  if(!isDefined(elevated_jump_node)) {
    return;
  }

  self ScrAgentSetGoalNode(elevated_jump_node);
  self ScrAgentSetGoalRadius(ALIEN_NODE_GOAL_RADIUS);
  self waittill("goal_reached");

  filters = [];
  filters["direction"] = direction;
  filters["direction_weight"] = 1.0;
  filters["min_height"] = -32.0;
  filters["max_height"] = 32.0;
  filters["height_weight"] = 2.0;
  filters["enemy_los"] = true;
  filters["enemy_los_weight"] = 2.0;
  filters["min_dist_from_enemy"] = 400.0;
  filters["max_dist_from_enemy"] = 800.0;
  filters["desired_dist_from_enemy"] = 600.0;
  filters["dist_from_enemy_weight"] = 3.0;
  filters["min_dist_from_all_enemies"] = 200.0;
  filters["min_dist_from_all_enemies_weight"] = 1.0;
  filters["not_recently_used_weight"] = 4.0;
  filters["random_weight"] = 2.0;

  should_go_left = RandomInt(2);
  for(i = 0; i < (GetDvarInt("alien_circling_retreat_num_nodes") - 1); i++) {
    enemy_to_alien_vector = self.origin - enemy.origin;
    enemy_to_alien_angle = VectorToAngles(enemy_to_alien_vector);
    override_vector = AnglesToRight(enemy_to_alien_angle);
    if(should_go_left) {
      override_vector = override_vector * -1;
    }

    jump_nodes = GetNodesInRadius(self.origin, 800, 250, 256, "jump");
    if(jump_nodes.size == 0) {
      return;
    }
    filters["direction"] = "override";
    filters["direction_override"] = override_vector;
    filters["direction_weight"] = 2.0;
    filters["random_weight"] = 1.0;
    filters["min_dist_from_current_position"] = 256.0;
    filters["min_dist_from_current_position_weight"] = 3.0;
    next_circle_node = get_retreat_node_rated(enemy, filters, jump_nodes);

    self ScrAgentSetGoalNode(next_circle_node);
    self ScrAgentSetGoalRadius(ALIEN_NODE_GOAL_RADIUS);
    self waittill("goal_reached");
  }
}

close_range_retreat(enemy) {
  debug_alien_ai_state("close_range_retreat");
  self endon("go to combat");

  self thread monitor_proximity_with_enemy(enemy);
  self thread watch_for_damage(enemy);
  self set_alien_movemode("run");

  MIN_OFFSET_YAW = 55;
  MAX_OFFSET_YAW = 75;
  MIN_OFFSET_DISTANCE = 256;
  MAX_OFFSET_DISTANCE = 256;

  retreatLocation = get_offset_location_from_enemy(enemy, MIN_OFFSET_DISTANCE, MAX_OFFSET_DISTANCE, MIN_OFFSET_YAW, MAX_OFFSET_YAW);

  nodes = GetNodesInRadius(retreatLocation, 256, 0, 128, "path");

  if(nodes.size == 0) {
    alien_path_error("Unable to find any node within 300-unit radius.Retreat location: " + retreatLocation);
    nodes = GetNodesInRadius(retreatLocation, 500, 256, 128, "path");
  }

  if(nodes.size == 0) {
    wait 0.2;
    return;
  }

  filters = [];
  if(GetDvarInt("alien_retreat_towards_spawn") == 1) {
    filters["direction_weight"] = 8.0;
  } else {
    filters["direction_weight"] = 3.0;
  }

  filters["direction"] = "override";
  filters["direction_override"] = VectorNormalize(retreatLocation - self.origin);
  filters["min_height"] = -32.0;
  filters["max_height"] = 32.0;
  filters["height_weight"] = 6.0;
  filters["enemy_los"] = false;
  filters["enemy_los_weight"] = 0.0;
  filters["min_dist_from_enemy"] = 150.0;
  filters["max_dist_from_enemy"] = 800.0;
  filters["desired_dist_from_enemy"] = 200.0;
  filters["dist_from_enemy_weight"] = 3.0;
  filters["min_dist_from_all_enemies"] = 150.0;
  filters["min_dist_from_all_enemies_weight"] = 1.0;
  filters["not_recently_used_weight"] = 4.0;
  filters["random_weight"] = 2.0;

  close_range_node = get_retreat_node_rated(enemy, filters, nodes);

  self ScrAgentSetGoalNode(close_range_node);
  self ScrAgentSetGoalRadius(ALIEN_NODE_GOAL_RADIUS);
  self waittill("goal_reached");
}

get_retreat_node_rated(enemy, filters, nodes) {
  if(nodes.size == 0) {
    return undefined;
  }

  direction = filters["direction"];
  direction_weight = filters["direction_weight"];
  min_height = filters["min_height"];
  max_height = filters["max_height"];
  height_weight = filters["height_weight"];
  enemy_los = filters["enemy_los"];
  enemy_los_weight = filters["enemy_los_weight"];
  min_dist_from_enemy = filters["min_dist_from_enemy"];
  max_dist_from_enemy = filters["max_dist_from_enemy"];
  desired_dist_from_enemy = filters["desired_dist_from_enemy"];
  dist_from_enemy_weight = filters["dist_from_enemy_weight"];
  min_dist_from_all_enemies = filters["min_dist_from_all_enemies"];
  min_dist_from_all_enemies_weight = filters["min_dist_from_all_enemies_weight"];
  min_dist_from_current_position = filters["min_dist_from_current_position"];
  min_dist_from_current_position_weight = filters["min_dist_from_current_position_weight"];
  not_recently_used_weight = filters["not_recently_used_weight"];
  random_weight = filters["random_weight"];

  if(isDefined(filters["recently_used_time_limit"]))
    recently_used_time_limit = filters["recently_used_time_limit"];
  else
    recently_used_time_limit = RECENT_TIME_LIMIT;

  if(isDefined(filters["test_offset"]))
    test_offset = filters["test_offset"];
  else
    test_offset = (0.0, 0.0, 0.0);

  enemy_forward_vector = undefined;
  if(isPlayer(enemy)) {
    enemy_forward_vector = anglesToForward(enemy GetPlayerAngles());
  } else if(isDefined(enemy)) {
    enemy_forward_vector = anglesToForward(enemy.angles);
  }
  target_vector = undefined;
  use_cover_target_vector = false;
  if(direction == "player_front") {
    target_vector = enemy_forward_vector;
  } else if(direction == "player_behind") {
    target_vector = enemy_forward_vector * -1;
  } else if(direction == "alien_forward") {
    target_vector = anglesToForward(self.angles);
  } else if(direction == "alien_backward") {
    target_vector = anglesToForward(self.angles) * -1;
  } else if(direction == "cover") {
    use_cover_target_vector = true;
  } else if(direction == "override") {
    assert(isDefined(filters["direction_override"]));
    target_vector = filters["direction_override"];
  } else {
    AssertMsg("Invalid direction.It should be 'front', 'behind', or 'alien forward'");
  }

  index = 0;
  best_node_rating = -1.0;
  best_index = 0;
  wait_count = 0;

  while(index < nodes.size) {
    node = nodes[index];
    node_origin = node.origin + test_offset;
    rating = 0.0;

    if(height_Weight > 0.0) {
      if((node_origin[2] - enemy.origin[2]) > min_height && (node_origin[2] - enemy.origin[2]) < max_height) {
        rating += height_weight;
      }
    }

    compare_vector = undefined;
    if(use_cover_target_vector) {
      target_vector = anglesToForward(node.angles);
      compare_vector = VectorNormalize(enemy.origin - node_origin);
    } else {
      compare_vector = VectorNormalize(node_origin - self.origin);
    }

    dot = VectorDot(target_vector, compare_vector);
    rating += (dot + 1.0) * 0.5 * direction_weight;

    if(dist_from_enemy_weight > 0.0) {
      dist = distance(node_origin, enemy.origin);
      if(dist > min_dist_from_enemy && dist < max_dist_from_enemy) {
        dist_rating = 0.0;
        if(dist > desired_dist_from_enemy) {
          dist_rating += 1 - ((dist - desired_dist_from_enemy) / (max_dist_from_enemy - desired_dist_from_enemy));
        } else {
          dist_rating += (dist - min_dist_from_enemy) / (desired_dist_from_enemy - min_dist_from_enemy);
        }
        rating += dist_rating * dist_from_enemy_weight;
      }
    }

    if(min_dist_from_all_enemies_weight) {
      min_dist_success = true;
      foreach(player in level.players) {
        if(!isDefined(enemy) || player != enemy) {
          if(DistanceSquared(node_origin, player.origin) < min_dist_from_all_enemies * min_dist_from_all_enemies) {
            min_dist_success = false;
            break;
          }
        }
      }

      if(min_dist_success) {
        rating += min_dist_from_all_enemies_weight;
      }
    }

    if(isDefined(min_dist_from_current_position_weight) && min_dist_from_current_position_weight > 0.0) {
      if(DistanceSquared(self.origin, node_origin) > min_dist_from_current_position * min_dist_from_current_position) {
        rating += min_dist_from_current_position_weight;
      }
    }

    if(!node_recently_used(node, recently_used_time_limit)) {
      rating += not_recently_used_weight;
    }

    if(random_weight > 0.0) {
      rating += RandomFloat(random_weight);
    }

    if(enemy_los_weight > 0.0 && rating > best_node_rating - enemy_los_weight) {
      while(max_traces_reached()) {
        wait_count++;
        if(wait_count >= 20) {
          break;
        }

        waitframe();
      }

      if(isDefined(enemy)) {
        trace_passed = SightTracePassed(enemy get_eye_position(), node_origin + (0, 0, 50), false, self);

        level.nodeFilterTracesThisFrame++;
        if(enemy_los == trace_passed) {
          rating += enemy_los_weight;
        }
      }
    }

    if(rating > best_node_rating) {
      best_node_rating = rating;
      best_index = index;
    }

    index++;
  }

  register_node(nodes[best_index]);
  return nodes[best_index];
}

get_eye_position() {
  assert(isDefined(self));
  if(isAlive(self) && (isPlayer(self) || isAgent(self))) {
    return self getEye();
  }

  return self.origin;
}

max_traces_reached() {
  MAX_TRACE_COUNT_PER_FRAME = 5;
  if(gettime() > level.nodeFilterTracesTime) {
    level.nodeFilterTracesTime = gettime();
    level.nodeFilterTracesThisFrame = 0;
  }

  return level.nodeFilterTracesThisFrame >= MAX_TRACE_COUNT_PER_FRAME;
}

default_approach(enemy, attack_counter) {
  debug_alien_ai_state("default_approach");
  /
  # debug_alien_attacker_state("attacking");

  approach_node = do_initial_approach(enemy);

  swipe_chance = self.swipeChance;
  should_swipe = (RandomFloat(1.0) < swipe_chance);

  if(!should_swipe && self go_to_leaping_melee_position(enemy)) {
    return "leap";
  }

  return go_for_swipe(enemy, approach_node);
}

do_initial_approach(enemy) {
  self thread jogWhenCloseToEnemy(enemy);

  approach_node = undefined;
  if(DistanceSquared(self.origin, enemy.origin) > ALIEN_APPROACH_DIST_SQR)
    approach_node = approach_enemy(ALIEN_LEAP_MELEE_DISTANCE_MAX, enemy, 3);

  return approach_node;
}

jogWhenCloseToEnemy(enemy) {
  self notify("jogWhenCloseToEnemy");
  self endon("jogWhenCloseToEnemy");
  self endon("death");
  enemy endon("death");
  enemy endon("disconnect");
  level endon("game_ended");

  if(distanceSquared(self.origin, enemy.origin) >= ALIEN_JOG_CHANGE_DISTANCE * ALIEN_JOG_CHANGE_DISTANCE)
    self set_alien_movemode("run");

  while(true) {
    wait(1.0);

    if(distanceSquared(self.origin, enemy.origin) < ALIEN_JOG_CHANGE_DISTANCE * ALIEN_JOG_CHANGE_DISTANCE) {
      break;
    }
  }
  switchToJog();
}

switchToJog() {
  if(self.movemode == "jog") {
    return;
  }
  SLOWER_PLAYBACK_RATE = 0.9;

  self set_alien_movemode("jog");
  self.moveplaybackrate *= SLOWER_PLAYBACK_RATE;
  self thread backToRunOnDamage(true);
}

backToRunOnDamage(whizby) {
  self notify("backToRunOnDamage");
  self endon("backToRunOnDamage");
  self endon("death");
  level endon("game_ended");

  if(isDefined(whizby) && whizby)
    self waittill_any("damage", "start_attack", "bulletwhizby");
  else
    self waittill_any("damage", "start_attack");

  self set_alien_movemode("run");
  self.moveplaybackrate = self.defaultmoveplaybackrate;
}

sneak_up_on(enemy) {
  self endon("death");
  self endon("start_attack");

  self set_alien_movemode("walk");
  ENEMY_GET_AWAY_SCALER = 1.05;

  while(true) {
    wait(1.0);

    if(in_front_players() || distanceSquared(self.origin, enemy.origin) > ALIEN_LEAP_MELEE_DISTANCE_MAX * ALIEN_LEAP_MELEE_DISTANCE_MAX * ENEMY_GET_AWAY_SCALER) {
      self set_alien_movemode("run");
      break;
    }
  }
}

in_front_players() {
  foreach(player in level.players) {
    if(in_front_of(player))
      return true;
  }
  return false;
}

in_front_of(enemy) {
  CONE_LIMIT = 0.5;

  enemy_to_self = self.origin - enemy.origin;
  enemy_forward = anglesToForward(enemy.angles);
  dot_product = VectorDot(enemy_to_self, enemy_forward);

  if(dot_product < 0)
    return false;

  inside_front_cone = dot_product > CONE_LIMIT;
  return inside_front_cone;
}

go_for_swipe(enemy, approach_node) {
  melee_distance = GetDvarInt("alien_melee_distance");
  if(melee_distance < ALIEN_MIN_MELEE_DISTANCE)
    melee_distance = ALIEN_MIN_MELEE_DISTANCE;

  self run_near_enemy(melee_distance, enemy);
  if(!self AgentCanSeeSentient(enemy))
    return "none";

  return "swipe";
}

find_wall_leap_node(enemy) {
  dist_to_enemy = Distance(self.origin, enemy.origin);
  if(dist_to_enemy < 200) {
    return;
  }

  vec_to_enemy = enemy.origin - self.origin;
  center_point = self.origin + (vec_to_enemy * 0.5);

  enemy_eye = enemy get_eye_position();
  COS_MAX_VERTICAL_ANGLE = 0.95757;

  jump_nodes = GetNodesInRadius(center_point, dist_to_enemy + 100.0, 100.0, 256.0, "node_jump");

  qualified_nodes = [];

  foreach(jump_node in jump_nodes) {
    if(jump_node.origin[2] < enemy.origin[2] + 32.0) {
      continue;
    }

    enemy_to_node = enemy.origin - jump_node.origin;
    enemy_to_alien = self.origin - enemy.origin;
    if(VectorDot(enemy_to_alien, enemy_to_node) > 0) {
      continue;
    }

    alien_to_node = self.origin - jump_node.origin;
    alien_to_enemy = enemy_to_alien * -1;
    if(VectorDot(alien_to_enemy, alien_to_node) > 0) {
      continue;
    }

    if(DistanceSquared(self.origin, jump_node.origin) < 256.0 * 256.0) {
      continue;
    }

    if(DistanceSquared(enemy.origin, jump_node.origin) < 256.0 * 256.0) {
      continue;
    }

    enemy_eye_to_node = VectorNormalize(jump_node.origin - enemy_eye);
    enemy_eye_to_node_no_z = VectorNormalize(enemy_eye_to_node * (1, 1, 0));
    dot = VectorDot(enemy_eye_to_node, enemy_eye_to_node_no_z);
    if(dot < COS_MAX_VERTICAL_ANGLE) {
      continue;
    }

    alien_eye = self getEye();
    jump_node_offset = jump_node.origin + (0, 0, 32);
    trace_result = bulletTrace(alien_eye, jump_node_offset, false, self);
    if(trace_result["surfacetype"] != "none") {
      continue;
    }

    enemy_eye = enemy get_eye_position();
    trace_result = bulletTrace(jump_node_offset, enemy_eye, false, enemy);
    if(trace_result["surfacetype"] != "none") {
      continue;
    }

    qualified_nodes[qualified_nodes.size] = jump_node;
  }

  if(qualified_nodes.size == 0) {
    return undefined;
  } else {
    filters = [];
    filters["direction"] = "alien_forward";
    filters["direction_weight"] = 1.0;
    filters["height_weight"] = 0.0;
    filters["enemy_los_weight"] = 0.0;
    filters["dist_from_enemy_weight"] = 0.0;
    filters["min_dist_from_all_enemies_weight"] = 0.0;
    filters["not_recently_used_weight"] = 4.0;
    filters["random_weight"] = 1.0;
    wall_leap_node = get_retreat_node_rated(enemy, filters, qualified_nodes);

    return wall_leap_node;
  }
}

swipe_melee(enemy) {
  debug_alien_ai_state("swipe_melee");
  self.melee_type = "swipe";
  alien_melee(enemy);
}

leap_melee(enemy) {
  debug_alien_ai_state("leap_melee");
  self.melee_type = "leap";
  alien_melee(enemy);
}

wall_leap_melee(enemy) {
  debug_alien_ai_state("wall_leap_melee");
  self.melee_type = "wall";
  assert(isDefined(self.wall_leap_melee_node));
  alien_melee(enemy);
}

synch_melee(enemy) {
  debug_alien_ai_state("synch_melee");
  self.melee_type = "synch";
  alien_melee(enemy);
}

badpath_jump(enemy) {
  debug_alien_ai_state("badpath_jump");
  self.melee_type = "badpath_jump";
  alien_melee(enemy);
}

swipe_static_melee(enemy) {
  debug_alien_ai_state("swipe_static_melee");
  self.melee_type = "swipe_static";
  alien_melee(enemy);
}

alien_melee(enemy) {
  if(melee_okay() && self AttemptMelee()) {
    if(self get_alien_type() != "spitter" && self get_alien_type() != "seeder") {
      self ScrAgentSetGoalEntity(enemy);
      self ScrAgentSetGoalRadius(4096.0);
    }
    self waittill("melee_complete");
  } else {
    wait 0.2;
  }
}

watch_for_scripted() {
  self endon("death");

  while(1) {
    if(isDefined(self.alien_scripted) && self.alien_scripted == true) {
      self notify("alien_main_loop_restart");
      while(isDefined(self.alien_scripted) && self.alien_scripted == true) {
        wait 0.05;
      }
    }
    wait 0.05;
  }
}

watch_for_badpath() {
  self endon("death");

  self.badpath = false;
  while(1) {
    self waittill("bad_path", start_pos, end_pos);

    self.badpath = true;

    if(!isDefined(self.badpathcount) || (isDefined(self.badpathtime) && gettime() > self.badpathtime + 2000)) {
      self.badpathcount = 0;
    }

    self.badpathtime = gettime();
    self.badpathcount++;
    self notify("alien_main_loop_restart");
    wait 0.05;
  }
}

set_alien_movemode(mode) {
  switch (mode) {
    case "run":
    case "walk":
    case "jog":
      self.movemode = mode;
      break;
    default:
      AssertMsg("Invalid alien movemode: " + mode);
      break;
  }
}

watch_for_insolid() {
  self endon("death");
  if(self.insolid) {
    self HandleInSolid();
  }

  while(1) {
    self waittill("insolid");
    self HandleInSolid();
  }
}

HandleInSolid() {
  while(self.insolid) {
    wait 0.2;
  }

  self ScrAgentSetGoalPos(self.origin);
  self notify("alien_main_loop_restart");
}

approach_enemy(max_distance, enemy, maxNodeTries) {
  if(max_distance < 32)
    max_distance = 32;

  approachNode = get_approach_node(enemy);
  maxDistanceSq = max_distance * max_distance;
  nodeTries = 0;

  while(isDefined(approachNode) && nodeTries < maxNodeTries) {
    if(run_to_approach_node(approachNode, max_distance, enemy)) {
      return approachNode;
    }

    if(DistanceSquared(self.origin, enemy.origin) < ALIEN_APPROACH_DIST_SQR) {
      break;
    }

    nodeTries++;
    approachNode = get_approach_node(enemy);
  }

  run_to_enemy(max_distance, enemy);
}

run_to_approach_node(approach_node, max_distance, enemy) {
  self notify("approach_goal_invalid");

  self ScrAgentSetGoalRadius(ALIEN_NODE_GOAL_RADIUS);
  self ScrAgentSetGoalNode(approach_node);

  wait_till_reached_goal_or_distance_from_enemy(approach_node, max_distance, enemy);

  return DistanceSquared(enemy.origin, self.origin) <= max_distance * max_distance;
}

run_to_enemy(max_distance, enemy) {
  self notify("approach_goal_invalid");

  goal_radius = max(max_distance + ALIEN_GOAL_RADIUS_ADJUSTMENT, 32);
  self ScrAgentSetGoalRadius(goal_radius);
  self ScrAgentSetGoalEntity(enemy);

  wait_till_distance_from_enemy(max_distance, enemy);
}

wait_till_reached_goal_or_distance_from_enemy(goal_node, max_distance, enemy) {
  self endon("goal_reached");
  self endon("approach_goal_invalid");

  self thread monitor_approach_goal_invalid(goal_node, enemy);
  wait_till_distance_from_enemy(max_distance, enemy);
}

monitor_approach_goal_invalid(goal_node, enemy) {
  self endon("goal_reached");
  self endon("death");
  self endon("approach_goal_invalid");
  enemy endon("death");

  DISTANCE_TOLERANCE_SQ = 450 * 450;

  while(isDefined(goal_node) && isDefined(enemy)) {
    if(DistanceSquared(goal_node.origin, enemy.origin) > DISTANCE_TOLERANCE_SQ) {
      break;
    }

    enemyToSelf = VectorNormalize(self.origin - enemy.origin);
    enemyToGoal = VectorNormalize(goal_node.origin - enemy.origin);

    if(VectorDot(enemytoSelf, enemyToGoal) < 0) {
      break;
    }

    wait 0.2;
  }

  self notify("approach_goal_invalid");
}

wait_till_distance_from_enemy(max_distance, enemy) {
  max_distance_sqr = max_distance * max_distance;

  while(true) {
    if(get_distance_squared_to_enemy(enemy) < max_distance_sqr) {
      break;
    }

    waitframe();
  }
}

get_distance_squared_to_enemy(enemy) {
  if(isPlayer(enemy) && enemy IsOnLadder())
    return Distance2DSquared(self.origin, enemy.origin);

  return DistanceSquared(self.origin, enemy.origin);
}

run_near_enemy(max_distance, enemy, approach_node) {
  if(max_distance < 32) {
    max_distance = 32;
  }

  if(!isDefined(approach_node) || !run_to_approach_node(approach_node, max_distance, enemy))
    run_to_enemy(max_distance, enemy);
}

get_offset_location_from_enemy(enemy, minOffsetDistance, maxOffsetDistance, minOffsetYaw, maxOffsetYaw) {
  if(GetDvarInt("alien_retreat_towards_spawn") == 1)
    targetLocation = self.spawnOrigin;
  else
    targetLocation = self.origin;

  flatEnemyToTarget = VectorNormalize((targetLocation - enemy.origin) * (1, 1, 0));
  yawValue = RandomIntRange(minOffsetYaw, maxOffsetYaw);
  if(cointoss())
    yawValue *= -1;

  rotateAngles = (0, yawValue, 0);
  offsetDir = RotateVector(flatEnemyToTarget, rotateAngles);
  offsetDistance = minOffsetDistance;
  if(minOffsetDistance < maxOffsetDistance)
    offsetDistance = RandomIntRange(minOffsetDistance, maxOffsetDistance);

  return enemy.origin + offsetDir * offsetDistance;
}

get_approach_node(enemy) {
  MIN_OFFSET_YAW = 20;
  MAX_OFFSET_YAW = 30;

  approachDistance = GetDvarInt("alien_melee_distance");
  if(approachDistance < ALIEN_MIN_MELEE_DISTANCE)
    approachDistance = ALIEN_MIN_MELEE_DISTANCE;

  approachLocation = get_offset_location_from_enemy(enemy, approachDistance, approachDistance, MIN_OFFSET_YAW, MAX_OFFSET_YAW);
  nodes = GetNodesInRadius(approachLocation, 150, 0, 128, "path");

  if(nodes.size == 0)
    nodes = GetNodesInRadius(approachLocation, 300, 150, 128, "path");

  filters = [];
  filters["direction"] = "override";
  filters["direction_weight"] = 6.0;
  filters["direction_override"] = VectorNormalize(enemy.origin - self.origin);
  filters["min_height"] = -32.0;
  filters["max_height"] = 32.0;
  filters["height_weight"] = 6.0;
  filters["enemy_los"] = false;
  filters["enemy_los_weight"] = 0.0;
  filters["min_dist_from_enemy"] = 150.0;
  filters["max_dist_from_enemy"] = 800.0;
  filters["desired_dist_from_enemy"] = Distance(approachLocation, enemy.origin);
  filters["dist_from_enemy_weight"] = 3.0;
  filters["min_dist_from_all_enemies"] = 150.0;
  filters["min_dist_from_all_enemies_weight"] = 1.0;
  filters["not_recently_used_weight"] = 4.0;
  filters["random_weight"] = 2.0;

  return get_retreat_node_rated(enemy, filters, nodes);
}

wait_for_valid_leap_melee(enemy) {
  random_max_dist = RandomIntRange(-100, 100) + ALIEN_LEAP_MELEE_DISTANCE_MAX;
  target_dist_squared = random_max_dist * random_max_dist;
  min_jump_dist_squared = ALIEN_LEAP_MELEE_DISTANCE_MIN * ALIEN_LEAP_MELEE_DISTANCE_MIN;

  while(1) {
    if(DistanceSquared(self.origin, enemy.origin) < target_dist_squared) {
      break;
    }
    wait 0.05;
  }

  while(1) {
    if(!isAlive(enemy)) {
      return false;
    }

    if(DistanceSquared(self.origin, enemy.origin) < min_jump_dist_squared) {
      return false;
    }

    if(self can_leap_melee(enemy, ALIEN_LEAP_MELEE_DISTANCE_MAX, ALIEN_LEAP_MELEE_DISTANCE_MIN)) {
      return true;
    }

    wait 0.05;
  }
}

go_to_leaping_melee_position(enemy) {
  debug_alien_ai_state("go_to_leaping_melee_position");
  self ScrAgentSetGoalEntity(enemy);
  self ScrAgentSetGoalRadius(ALIEN_LEAP_MELEE_DISTANCE_MIN + ALIEN_GOAL_RADIUS_ADJUSTMENT);

  return wait_for_valid_leap_melee(enemy);
}

go_to_leaping_melee_node(enemy) {
  debug_alien_ai_state("go_to_leaping_melee_node (badpath)");
  nodes = GetNodesInRadius(enemy.origin, 512.0, 200.0, 256.0, "node_jump");
  valid_nodes = [];
  enemy_eye = enemy get_eye_position();
  node_offset = (0, 0, 32);
  chosen_node = undefined;
  foreach(node in nodes) {
    trace_result = BulletTracePassed(node.origin + node_offset, enemy_eye, false, self);
    if(trace_result) {
      chosen_node = node;
      break;
    }
  }

  if(!isDefined(chosen_node)) {
    return false;
  }

  self ScrAgentSetGoalNode(chosen_node);
  self ScrAgentSetGoalRadius(ALIEN_LEAP_MELEE_DISTANCE_MIN + ALIEN_GOAL_RADIUS_ADJUSTMENT);

  target_dist_squared = ALIEN_LEAP_MELEE_DISTANCE_MAX * ALIEN_LEAP_MELEE_DISTANCE_MAX;
  min_jump_dist_squared = 0.0;
  return wait_for_valid_leap_melee(enemy);
}

can_leap_melee(enemy, max_distance, min_distance) {
  if(!(self melee_okay())) {
    return false;
  }

  if(isDefined(max_distance)) {
    if(DistanceSquared(self.origin, enemy.origin) > max_distance * max_distance) {
      return false;
    }
  }

  alien_eye = self.origin + (0, 0, 32);
  enemy_eye = enemy get_eye_position();
  leapEndPos = self maps\mp\agents\alien\_alien_melee::get_melee_position(1.0, LEAP_OFFSET_XY, enemy);
  self.leapEndPos = leapEndPos;

  if(!isDefined(leapEndPos)) {
    return false;
  }

  if(DistanceSquared(self.origin, leapEndPos) < min_distance) {
    return false;
  }

  traceResult = TrajectoryCanAttemptAccurateJump(self.origin, AnglesToUp(self.angles), leapEndPos, AnglesToUp(enemy.angles), level.alien_jump_melee_gravity, 1.01 * level.alien_jump_melee_speed);

  return traceResult;
}

melee_okay() {
  switch (self.currentAnimState) {
    case "move":
      return true;
    case "melee":
      return true;
    case "idle":
      return true;
    default:
      return false;
  }
}

register_node(node) {
  assert(isDefined(node));
  node_info = [];
  node_info["node"] = node;
  node_info["time_stamp"] = getTime();
  level.used_nodes[level.used_nodes_list_index] = node_info;
  level.used_nodes_list_index++;
  if(level.used_nodes_list_index == level.used_nodes_list_size) {
    level.used_nodes_list_index = 0;
  }
}

node_recently_used(node, time_limit) {
  result = false;
  for(i = 0; i < level.used_nodes_list_size; i++) {
    index_scanner = level.used_nodes_list_index - i;
    if(index_scanner < 0) {
      index_scanner = level.used_nodes_list_size + index_scanner;
    }

    if(isDefined(level.used_nodes[index_scanner])) {
      node_info = level.used_nodes[index_scanner];
      if((node == node_info["node"])) {
        if((getTime() - node_info["time_stamp"]) < time_limit * 1000) {
          result = true;
        }
        break;
      }
    }
  }
  return result;
}

get_attack_sequence_num() {
  if(isDefined(self.bypass_max_attacker_counter) && self.bypass_max_attacker_counter == true) {
    return 1;
  }

  if(isDefined(self.attack_sequence_num)) {
    override_value = self.attack_sequence_num;
    self.attack_sequence_num = undefined;
    return override_value;
  }

  switch (get_alien_type()) {
    case "elite":
    case "spitter":
    case "seeder":
    case "locust":
    case "gargoyle":
      return 1;
    default:
      return RandomInt(MAX_ATTACK_SEQUENCES - MIN_ATTACK_SEQUENCES) + MIN_ATTACK_SEQUENCES;
  }
}

get_attack_num() {
  if(isDefined(self.attack_num)) {
    override_value = self.attack_num;
    self.attack_num = undefined;
    return override_value;
  }

  switch (get_alien_type()) {
    case "locust":
    case "gargoyle":
      return 1;
    default:
      return RandomInt(MAX_ATTACKS) + MIN_ATTACKS;
  }
}

random_movemode_change(run_weight, jog_weight, walk_weight, min_change_time, max_change_time) {
  self endon("go to combat");
  self endon("death");

  movemode_weight = [];
  movemode_weight["run"] = run_weight;
  movemode_weight["jog"] = jog_weight;
  movemode_weight["walk"] = walk_weight;

  total_weight = run_weight + jog_weight + walk_weight;

  min_dist_walk_sqr = 512.0 * 512.0;

  while(true) {
    if(maps\mp\alien\_utility::any_player_nearby(self.origin, min_dist_walk_sqr)) {
      next_movemode = "run";
    } else {
      weight_sum = 0;
      rand_index = RandomIntRange(0, total_weight);
      next_movemode = undefined;
      foreach(movemode, weight in movemode_weight) {
        weight_sum += weight;
        if(rand_index <= weight_sum) {
          next_movemode = movemode;
          break;
        }
      }
    }

    self set_alien_movemode(next_movemode);
    wait(randomFloatRange(min_change_time, max_change_time));
  }
}

armorMitigation(vPoint, vDir, sHitLoc) {}

play_shield_impact_fx(vPoint, vDir) {
  if(!isDefined(vDir) || !isDefined(vPoint)) {
    return;
  }

  forward_vector = vDir * -1;
  up_vector = anglesToUp(vectorToAngles(forward_vector));
  playFX(level._effect["shield_impact"], vPoint, forward_vector, up_vector);
  self playSound("bullet_large_metal");
}

has_shock_ammo(sWeapon) {
  baseweapon = getRawBaseWeaponName(sWeapon);
  if(isDefined(self.special_ammocount) && isDefined(self.special_ammocount[baseweapon]) && self.special_ammocount[baseweapon] > 0) {
    return true;
  }
  return false;
}

get_pet_follow_node(owner) {
  jump_nodes = GetNodesInRadius(owner.origin, 512, 128, 350, "node_jump");
  filters = [];
  filters["direction"] = "player_front";
  filters["direction_weight"] = 2.0;
  filters["min_height"] = -32.0;
  filters["max_height"] = 350.0;
  filters["height_weight"] = 2.0;
  filters["enemy_los"] = true;
  filters["enemy_los_weight"] = 2.0;
  filters["min_dist_from_enemy"] = 128.0;
  filters["max_dist_from_enemy"] = 512.0;
  filters["desired_dist_from_enemy"] = 350.0;
  filters["dist_from_enemy_weight"] = 3.0;
  filters["min_dist_from_all_enemies"] = 200.0;
  filters["min_dist_from_all_enemies_weight"] = 0.0;
  filters["not_recently_used_weight"] = 4.0;
  filters["random_weight"] = 2.0;
  next_node = get_retreat_node_rated(owner, filters, jump_nodes);
  return next_node;
}

debug_alien_ai_state(text) {
  if(GetDvarInt("alien_debug_ai_state") == 1) {
    self thread debug_alien_ai_state_internal(text);
  }
}

debug_alien_ai_state_internal(text) {
  self endon("death");
  self notify("debug_alien_ai_state");
  self endon("debug_alien_ai_state");
  while(1) {
    print3d(self.origin + (0, 0, 64), text, (.9, .3, .3), 1.0, 1.0);
    wait 0.05;
  }
}

debug_alien_attacker_state(text) {
  if(GetDvarInt("alien_debug_ai_state") == 1) {
    self thread debug_alien_attacker_state_internal(text);
  }
}

debug_alien_attacker_state_internal(text) {
  self endon("death");
  self endon("start retreat");
  self notify("debug_alien_attacker_state");
  self endon("debug_alien_attacker_state");
  while(1) {
    print3d(self.origin + (0, 0, 84), text, (.3, .7, .7), 1.0, 1.0);
    wait 0.05;
  }
}

alien_path_error(error_text) {
  if(GetDvarInt("alien_dev_path_error") == 1) {
    error(error_text);
  }
}
# /