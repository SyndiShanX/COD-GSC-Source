/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\alien\_alien_melee.gsc
*************************************************/

#include maps\mp\agents\_scriptedAgents;
#include maps\mp\agents\alien\_alien_anim_utils;
#include maps\mp\alien\_utility;
#include common_scripts\utility;

SWIPE_ATTACK_START_SOUND = "alien_attack";
LEAP_ATTACK_START_SOUND = "alien_jump";
WALL_ATTACK_START_SOUND = "alien_attack";
ALIEN_MELEE_POSTURE_PERCENT = 20;
ALIEN_MELEE_COMBAT_STRAFE_PERCENT = 100;
ALIEN_MELEE_COMBAT_STRAFE_MIN_DIST_SQR = 20000.0;
MP_ALIEN_DLC3_DRILL_MELEE_SCALAR = 2;

ALIEN_MELEE_MOVE_SIDE_PERCENT = 60;
MAX_SWIPE_DAMAGE_DIST = 90;
MAX_LONG_RANGE_DAMAGE_DIST = 200;
SWIPE_OFFSET_XY = 56;
LEAP_OFFSET_XY = 48;

main() {
  self endon("killanimscript");

  assert(isDefined(self.enemy));
  assert(isDefined(self.melee_type));

  self.enemy thread melee_clean_up(self);

  self ScrAgentSetOrientMode("face enemy");
  self.playing_pain_animation = false;
  self.melee_jumping = false;
  self.melee_jumping_to_wall = false;
  self.melee_success = false;
  self.melee_synch = false;

  startTime = gettime();
  self.lastAttackTime = startTime;

  switch (self.melee_type) {
    case "swipe":
      self melee_swipe(self.enemy);
      break;
    case "leap":
      self melee_leap(self.enemy);
      break;
    case "wall":
      self melee_wall(self.enemy);
      break;
    case "synch":
      self melee_synch_attack(self.enemy);
      break;
    case "swipe_static":
      self melee_swipe_static(self.enemy);
      break;
    case "badpath_jump":
      self badpath_jump(self.enemy);
      break;
    case "spit":
      self maps\mp\agents\alien\_alien_spitter::spit_attack(self.enemy);
      break;
    case "charge":
      self maps\mp\agents\alien\_alien_elite::do_charge_attack(self.enemy);
      break;
    case "slam":
      self maps\mp\agents\alien\_alien_elite::do_ground_slam(self.enemy);
      break;
    case "angered":

      self maps\mp\agents\alien\_alien_elite::activate_angered_state();
      break;
    case "explode":
      self maps\mp\agents\alien\_alien_minion::explode(self.enemy);
      break;
    default:

      if(isDefined(level.dlc_melee_override_func)) {
        self[[level.dlc_melee_override_func]](self.enemy);
      } else
        assertmsg(self.melee_type + " unimplemented or you didnt setup a level specific dlc_melee_override_func");
      break;
  }

  if(self.playing_pain_animation) {
    self waittill("pain_finished");
  }

  if(starttime == gettime()) {
    wait 0.05;
  }

  self notify("melee_complete");
}

end_script() {
  self.allowpain = true;
  self ScrAgentSetAnimScale(1, 1);
  self.previousAnimState = "melee";
  self.melee_in_move_back = false;
  self set_alien_emissive_default(0.2);
}

melee_swipe(enemy) {
  self endon("melee_pain_interrupt");

  attack_type = Random(["swipe", "bite", "random"]);

  successfulSwipeCount = try_preliminary_swipes(attack_type, enemy, SWIPE_OFFSET_XY, MAX_SWIPE_DAMAGE_DIST);

  if(successfulSwipeCount != 2) {
    result3 = do_single_swipe(attack_type, 2, enemy, 0.8, SWIPE_OFFSET_XY, MAX_SWIPE_DAMAGE_DIST);

    if(!result3 && successfulSwipeCount == 0) {
      try_leap_melee(enemy);
    }
  }

  self move_back(enemy);
}

MAX_LEAP_MELEE_DROP_DISTANCE = 64;

try_leap_melee(enemy) {
  MIN_LEAP_DISTANCE_SQ = 10000;

  if(!isDefined(enemy)) {
    return;
  }
  self.leapEndPos = get_leap_end_pos(1.0, LEAP_OFFSET_XY, enemy);
  self.leapEndPos = DropPosToGround(self.leapEndPos, MAX_LEAP_MELEE_DROP_DISTANCE);

  if(!isDefined(self.leapEndPos)) {
    return;
  }

  if(DistanceSquared(self.origin, self.leapEndPos) < MIN_LEAP_DISTANCE_SQ) {
    return;
  }

  if(!TrajectoryCanAttemptAccurateJump(self.origin, AnglesToUp(self.angles), self.leapEndPos, AnglesToUp(enemy.angles), level.alien_jump_melee_gravity, 1.01 * level.alien_jump_melee_speed)) {
    return;
  }

  nodes = GetNodesInRadiusSorted(self.leapEndPos, 256, 0, 256);
  if(!nodes.size) {
    return;
  }

  pathdist = GetPathDist(self.leapEndPos, nodes[0].origin, 512);
  if(pathDist < 0) {
    return;
  }

  self melee_leap(enemy);
}

try_preliminary_swipes(attack_type, enemy, swipe_offset, max_damage_distance) {
  successfulSwipeCount = 0;
  if(do_single_swipe(attack_type, 0, enemy, 1.0, swipe_offset, max_damage_distance))
    successfulSwipeCount = 1;

  if(cointoss()) {
    result2 = do_single_swipe(attack_type, 1, enemy, 1.0, swipe_offset, max_damage_distance);
  } else {
    result2 = false;
  }

  if(result2)
    successfulSwipeCount++;

  return successfulSwipeCount;
}

do_single_swipe(meleeType, animEntry, enemy, tracking_amount, swipe_offset, max_damage_dist) {
  animState = get_anim_state_from_melee_type(meleeType);

  result = false;
  if(!isAlive(enemy)) {
    return false;
  }

  self set_alien_emissive(0.2, 1.0);
  self PlaySoundOnMovingEnt(SWIPE_ATTACK_START_SOUND);

  attackAnim = self GetAnimEntry(animState, animEntry);
  animLength = GetAnimLength(attackAnim);
  target_pos = self get_melee_position(animLength, swipe_offset, enemy, tracking_amount);
  if(isDefined(target_pos) && is_valid_swipe_position(target_pos)) {
    attackAnim = self GetAnimEntry(animState, animEntry);
    attackTranslation = GetMoveDelta(attackAnim);
    animXY = Length2D(attackTranslation);

    meToTarget = target_pos - self.origin;
    meToEnemy = enemy.origin - self.origin;
    if((animXY == 0) || VectorDot(meToTarget, meToEnemy) < 0) {
      animXYScale = 0;
    } else {
      meToTargetDistXY = Max(0, Length2D(meToTarget));
      animXYScale = meToTargetDistXY / animXY;
    }
    result = perform_swipe(animState, animEntry, enemy, max_damage_dist, animXYScale);
  } else {
    result = perform_swipe("attack_melee_swipe", animEntry, enemy, MAX_LONG_RANGE_DAMAGE_DIST, 0.0);
  }

  return result;
}

perform_swipe(animState, animEntry, enemy, max_damage_dist, anim_XY_scale) {
  result = false;
  self ScrAgentSetPhysicsMode("gravity");
  self ScrAgentSetAnimScale(anim_XY_scale, 0.0);
  self ScrAgentSetAnimMode("anim deltas");
  self ScrAgentSetOrientMode("face enemy");
  animRate = RandomFloatRange(0.9, 1.0);
  self PlayAnimNAtRateUntilNotetrack(animState, animEntry, animRate, "attack_melee", "start_melee");
  self set_alien_emissive_default(0.2);

  if(isAlive(enemy)) {
    dist_sqr = DistanceSquared(self.origin, enemy.origin);

    if(DistanceSquared(self.origin, enemy.origin) < max_damage_dist * max_damage_dist) {
      self melee_DoDamage(enemy, "swipe");
      result = true;
    }
  }

  self WaitUntilNotetrack("attack_melee", "end");
  return result;
}

get_anim_state_from_melee_type(meleeType) {
  animStates = ["attack_melee_swipe", "attack_melee_swipe", "attack_melee_bite", "attack_melee_bite_2"];

  switch (meleeType) {
    case "random":
      return Random(animStates);
    case "swipe":
      return "attack_melee_swipe";
    case "bite":
      return Random(["attack_melee_bite", "attack_melee_bite_2"]);
    default:
      AssertMsg("Invalid meleeType specified");
      break;
  }

  return undefined;
}

is_valid_swipe_position(swipe_pos) {
  MAX_SWIPE_ANIM_DISTANCE_SQR = 90000.0;
  ALIEN_SWIPE_STEP_SIZE = 17.0;
  if(DistanceSquared(self.origin, swipe_pos) > MAX_SWIPE_ANIM_DISTANCE_SQR) {
    return false;
  }

  return CanMovePointToPoint(self.origin, swipe_pos, ALIEN_SWIPE_STEP_SIZE);
}

get_leap_end_pos(timeUntilAttack, offset, enemy, tracking_amount) {
  enemy_to_self = self.origin - enemy.origin;

  enemy_to_self *= (1, 1, 0);
  enemy_to_self = VectorNormalize(enemy_to_self) * offset;

  if(!isDefined(tracking_amount)) {
    tracking_amount = 1.0;
  }

  if(isPlayer(enemy)) {
    velocity = enemy GetVelocity();
    TRACKING_VELOCITY_CAP = 200.0;
    if(LengthSquared(velocity) > TRACKING_VELOCITY_CAP * TRACKING_VELOCITY_CAP) {
      velocity = VectorNormalize(velocity);
      velocity *= TRACKING_VELOCITY_CAP;
    }
    velocity *= tracking_amount;
    velocity *= timeUntilAttack;
  } else {
    velocity = (0, 0, 0);
  }

  return enemy.origin + enemy_to_self + velocity;
}

get_melee_position(timeUntilAttack, offset, enemy, tracking_amount) {
  assert(IsAlive(enemy));

  leapEndPos = get_leap_end_pos(timeUntilAttack, offset, enemy, tracking_amount);

  if(isDefined(self.bad_path_handled) && self.bad_path_handled) {
    minDropDistance = 40.0;
    self.bad_path_handled = false;
  } else {
    minDropDistance = 18.0;
  }

  MAX_SLOPE = 0.57735;
  MAX_DROP_DISTANCE = 56.0;
  dropDistance = clamp(MAX_SLOPE * Distance2D(self.origin, leapEndPos), minDropDistance, MAX_DROP_DISTANCE);

  leapEndPos = DropPosToGround(leapEndPos, dropDistance);

  if(!isDefined(leapEndPos)) {
    println("get_melee_position: Failed to DropPosToGround: " + enemy.origin);
  } else {
    if(GetDvarInt("alien_debug_melee_position") == 1) {
      line(enemy.origin + (0, 0, 32), enemy.origin, (1, 0, 0), 1, 0, 100);
      line(self.origin + (0, 0, 32), self.origin, (0, 1, 0), 1, 0, 100);
      line(leapEndPos + (0, 0, 32), leapEndPos, (0, 0, 1), 1, 0, 100);
      println("Dist from leapEndPos to enemy: " + Distance(leapEndPos, enemy.origin));
    }
  }

  return leapEndPos;
}

melee_leap(enemy) {
  melee_leap_internal(enemy, "leap");
}

melee_leap_internal(enemy, melee_type) {
  play_leap_start_sound(melee_type);

  jumpCBs = spawnStruct();
  jumpCBs.fnSetAnimStates = ::melee_SetJumpAnimStates;
  jumpCBs.fnLandAnimStateChoice = ::melee_ChooseJumpArrival;

  assert(isDefined(self.leapEndPos));

  leapEndPos = self.leapEndPos;

  if(isDefined(leapEndPos)) {
    shouldExplode = maps\mp\alien\_utility::should_explode();

    if(!shouldExplode)
      self thread melee_LeapWaitForDamage(enemy, melee_type);

    self.melee_jumping = true;
    self set_alien_emissive(0.2, 1.0);
    self maps\mp\agents\alien\_alien_jump::Jump(self.origin, self.angles, leapEndPos, enemy.angles, undefined, jumpCBs);
    self set_alien_emissive_default(0.2);
    self.melee_jumping = false;

    if(shouldExplode)
      self maps\mp\agents\alien\_alien_minion::explode(self.enemy);
    else
      self move_back(enemy);
  } else {
    println("Leap Melee failed");

    wait 0.05;
  }
}

play_leap_start_sound(melee_type) {
  switch (melee_type) {
    case "leap":
      self PlaySoundOnMovingEnt(LEAP_ATTACK_START_SOUND);
      break;
    case "wall":
      self PlaySoundOnMovingEnt(WALL_ATTACK_START_SOUND);
      break;
    default:
      break;
  }
}

melee_LeapWaitForDamage(enemy, melee_type) {
  self endon("killanimscript");
  self endon("melee_pain_interrupt");
  self endon("jump_pain_interrupt");

  cMeleeDistanceSq = 80 * 80;

  while(true) {
    if(!isDefined(enemy) || !IsAlive(enemy)) {
      break;
    }

    if(Distance2DSquared(self.origin, enemy.origin) <= cMeleeDistanceSq) {
      self melee_DoDamage(enemy, melee_type);
      break;
    }

    wait(0.1);
  }
}

melee_SetJumpAnimStates(jumpInfo, jumpAnimStates) {
  jumpAnimStates.landAnimState = "attack_leap_swipe";
  jumpAnimStates.landAnimEntry = GetRandomAnimEntry("attack_leap_swipe");
}

melee_ChooseJumpArrival(jumpInfo, jumpAnimStates) {
  COS_45 = 0.707;
  if(isAlive(self.enemy)) {
    assert(isDefined(jumpInfo.landOrigin));
    assert(isDefined(jumpInfo.endAngles));
    landToEnemy = VectorNormalize(self.enemy.origin - jumpInfo.landOrigin);
    landForward = anglesToForward(jumpInfo.endAngles);
    forward_dot = VectorDot(landToEnemy, landForward);

    if(forward_dot > COS_45) {
      return;
    }
    landRight = AnglesToRight(jumpInfo.endAngles);
    right_dot = VectorDot(landToEnemy, landRight);
    if(right_dot > COS_45) {
      jumpAnimStates.landAnimState = "attack_leap_swipe_right";
      jumpAnimStates.landAnimEntry = GetRandomAnimEntry("attack_leap_swipe_right");
    } else if(right_dot < COS_45 * -1) {
      jumpAnimStates.landAnimState = "attack_leap_swipe_left";
      jumpAnimStates.landAnimEntry = GetRandomAnimEntry("attack_leap_swipe_left");
    }
  }
}

melee_swipe_static(enemy) {
  self endon("melee_pain_interrupt");

  if(!do_single_swipe("swipe", 2, enemy, 1.0, SWIPE_OFFSET_XY, MAX_SWIPE_DAMAGE_DIST))
    wait 0.05;
}

melee_synch_attack(enemy) {
  if(isDefined(self.xyanimscale))
    self ScrAgentSetAnimScale(self.xyanimscale, 1.0);

  self.melee_synch = true;
  attackAnim = self GetAnimEntry(self.synch_anim_state, 0);
  synchList = enemy get_synch_direction_list(self);

  up = AnglesToUp(enemy.angles);
  forward = VectorNormalize(enemy.origin - self.synch_attack_pos);
  right = VectorCross(forward, up);
  attackAngles = AxisToAngles(forward, right, up);

  self maps\mp\agents\alien\_alien_anim_utils::turnTowardsVector(anglesToForward(attackAngles));

  if(!isDefined(enemy)) {
    return;
  }
  self SetPlayerAngles(attackAngles);
  self ScrAgentSetOrientMode("face angle abs", attackAngles);
  self thread synch_attack_anim_lerp(attackAnim, self.synch_attack_pos, attackAngles);

  animLabel = synchList[self.synch_attack_index]["attackerAnimLabel"];
  self play_synch_attack(self.synch_attack_index, self.synch_anim_state, enemy, animLabel, synchList);

  if(isDefined(enemy))
    enemy notify("synched_attack_over");

  maps\mp\agents\_scriptedagents::PlayAnimNUntilNotetrack(self.synch_anim_state, 2, animLabel, "end");
  self.melee_synch = false;
}

play_synch_attack(attack_index, anim_state, enemy, anim_label, synch_list) {
  level endon("game_ended");

  foreach(endNotify in enemy.synch_attack_setup.end_notifies)
  enemy endon(endNotify);

  endAnim = self GetAnimEntry(anim_state, 2);
  endAnimTime = GetAnimLength(endAnim);
  enemy thread enemy_process_synch_attack(self, attack_index, endAnimTime, synch_list);

  startAnim = self GetAnimEntry(anim_state, 0);
  enemyAnim = synch_list[attack_index]["enterAnim"];
  enemy[[enemy.synch_attack_setup.begin_attack_func]](enemyAnim);
  maps\mp\agents\_scriptedagents::PlayAnimNUntilNotetrack(anim_state, 0, anim_label, "end");

  if(!isDefined(enemy)) {
    return;
  }
  enemyAnim = synch_list[attack_index]["loopAnim"];
  self thread apply_synch_attack_damage(enemy);

  while(isDefined(enemy)) {
    enemy[[enemy.synch_attack_setup.loop_attack_func]](enemyAnim);
    maps\mp\agents\_scriptedagents::PlayAnimNUntilNotetrack(anim_state, 1, anim_label, "end");
  }
}

apply_synch_attack_damage(enemy) {
  self endon("death");
  self endon("enemy");
  enemy endon("enemy_synch_end_notify");
  enemy endon("synched_attack_over");
  enemy endon("death");

  foreach(endNotify in enemy.synch_attack_setup.end_notifies)
  enemy endon(endNotify);

  damage_amount = 1.0;
  if(isDefined(self.alien_type)) {
    min_damage = level.alien_types[self.alien_type].attributes["synch_min_damage_per_second"] * level.cycle_damage_scalar;
    max_damage = level.alien_types[self.alien_type].attributes["synch_max_damage_per_second"] * level.cycle_damage_scalar;
    damage_amount = RandomFloatRange(min_damage, max_damage);
  }

  lastDamageTime = GetTime();

  while(true) {
    currentTime = GetTime();
    timeElapsed = (currentTime - lastDamageTime) * 0.001;
    scaledDamage = damage_amount * timeElapsed;

    enemy DoDamage(scaledDamage, self.origin, self, self);
    wait 0.1;

    lastDamageTime = currentTime;
  }
}

synch_attack_anim_lerp(start_anim, begin_pos, begin_angles) {
  self endon("death");

  startAnimLength = GetAnimLength(start_anim);
  lerp_time = Min(0.2, startAnimLength);
  lerpMoveDelta = GetMoveDelta(start_anim, 0, lerp_time / startAnimLength);
  if(isDefined(self.xyanimscale))
    lerpMoveDelta *= self.xyanimscale;

  lerpMoveOffset = RotateVector(lerpMoveDelta, begin_angles);
  self ScrAgentDoAnimLerp(self.origin, begin_pos + lerpMoveOffset, lerp_time);
  wait lerp_time;
  self ScrAgentSetAnimMode("anim deltas");
}

enemy_process_synch_attack(attacker, attackIndex, endAnimTime, synchList) {
  shouldPlayExitAnim = enemy_wait_for_synch_attack_end(attacker, attackIndex);

  if(!isDefined(self)) {
    return;
  }
  animName = undefined;
  if(shouldPlayExitAnim)
    animName = synchList[attackIndex]["exitAnim"];

  self[[self.synch_attack_setup.end_attack_func]](animName, endAnimTime);

  if(isDefined(self))
    self.synch_attack_setup.primary_attacker = undefined;
}

enemy_wait_for_synch_attack_end(attacker, attackIndex) {
  self thread enemy_wait_for_synch_invalid_enemy(attacker);
  foreach(endNotify in self.synch_attack_setup.end_notifies)
  self thread enemy_wait_for_synch_end_notify(endNotify);

  msg = self waittill_any_return("enemy_synch_end_notify", "synched_attack_over", "enemy_synch_invalid_enemy");

  return (isDefined(msg) && msg != "enemy_synch_end_notify");
}

enemy_wait_for_synch_end_notify(end_notify) {
  self endon("enemy_synch_end_notify");
  self endon("synched_attack_over");
  self endon("enemy_synch_invalid_enemy");

  self waittill(end_notify);
  self notify("enemy_synch_end_notify");
}

enemy_wait_for_synch_invalid_enemy(attacker) {
  self endon("synched_attack_over");
  self endon("enemy_synch_end_notify");
  self endon("death");
  level endon("game_ended");

  wait 0.05;

  while(true) {
    if(!IsAlive(attacker)) {
      break;
    }

    if(!isDefined(attacker.enemy) || attacker.enemy != self) {
      break;
    }

    wait 0.05;
  }

  self notify("enemy_synch_invalid_enemy");
}

melee_wall(enemy) {
  MAX_DIST_WALL_MELEE = 800;
  MIN_DIST_WALL_MELEE = 168;

  assert(isDefined(self.wall_leap_melee_node));

  target_jump_node = self.wall_leap_melee_node;

  self.melee_jumping_to_wall = true;
  self maps\mp\agents\alien\_alien_jump::Jump(self.origin, self.angles, target_jump_node.origin, target_jump_node.angles, enemy.origin);
  self.melee_jumping_to_wall = false;
  if(!isAlive(enemy)) {
    return;
  }

  if(maps\mp\agents\alien\_alien_think::can_leap_melee(enemy, MAX_DIST_WALL_MELEE, MIN_DIST_WALL_MELEE)) {
    melee_leap_internal(enemy, "wall");
  }
}

badpath_jump(enemy) {
  assert(isDefined(self.leapEndPos));
  assert(isDefined(self.leapEndAngles));
  self.melee_jumping = true;
  self maps\mp\agents\alien\_alien_jump::Jump(self.origin, self.angles, self.leapEndPos, self.leapEndAngles, undefined);
  self.melee_jumping = false;
}

melee_DoDamage(enemy, melee_type) {
  if(!isAlive(enemy)) {
    return;
  }

  self.melee_success = true;
  damage_amount = 1;
  if(isDefined(self.alien_type)) {
    min_damage = level.alien_types[self.alien_type].attributes[melee_type + "_min_damage"];
    max_damage = level.alien_types[self.alien_type].attributes[melee_type + "_max_damage"];

    if(self get_alien_type() == "elite" && isDefined(self.elite_angered)) {
      min_damage *= maps\mp\agents\alien\_alien_elite::get_angered_damage_scalar();
      max_damage *= maps\mp\agents\alien\_alien_elite::get_angered_damage_scalar();
    }

    damage_amount = RandomFloatRange(min_damage, max_damage);
  }

  if(isDefined(self.pet) && self.pet) {
    if(is_true(self.upgraded))
      damage_amount *= 10;
    else
      damage_amount *= 6;
  }

  if(isPlayer(enemy)) {
    enemy_blocked = self check_for_block(enemy);
    player_meleeing = self check_for_player_meleeing(enemy);
    if(enemy_blocked || player_meleeing) {
      return;
    } else {
      if(isDefined(enemy.isJuggernaut) && enemy.isJuggernaut) {
        damage_amount *= 0.65;
        Earthquake(0.25, 0.25, enemy.origin, 100);
      }
      enemy set_damage_viewkick(damage_amount);
      enemy PlayLocalSound("Player_hit_sfx_alien");
    }
  }

  if(enemy.model == "mp_laser_drill" && level.script == "mp_alien_dlc3")
    damage_amount *= MP_ALIEN_DLC3_DRILL_MELEE_SCALAR;

  enemy DoDamage(damage_amount, self.origin, self, self);
}

set_damage_viewkick(damage_amount) {
  MAX_VIEWKICK = 10;
  BASE_VIEWKICK = 2;
  DAMAGE_SCALE_BASE = 50;
  if(self maps\mp\alien\_persistence::is_upgrade_enabled("less_flinch_upgrade"))
    MAX_VIEWKICK = 0;
  additional_viewkick_scale = min(1, damage_amount / DAMAGE_SCALE_BASE);
  additional_viewkick = (MAX_VIEWKICK - BASE_VIEWKICK) * additional_viewkick_scale;

  viewkick_scale = BASE_VIEWKICK + additional_viewkick;
  if(is_chaos_mode()) {
    if(maps\mp\alien\_utility::isPlayingSolo())
      viewkick_scale = (viewkick_scale / 1.6);
    else
      viewkick_scale = (viewkick_scale / 2.2);
  }
  self SetViewKickScale(viewkick_scale);
}

move_back(enemy, force_posture) {
  self endon("melee_pain_interrupt");

  if(!isDefined(force_posture))
    force_posture = false;

  if(force_posture || self should_move_back(enemy)) {
    move_back_state = self GetMoveBackState();
    move_back_entry = self GetMoveBackEntry(move_back_state);
    moveBackAnim = self GetAnimEntry(move_back_state, move_back_entry);
    availableMoveBackScale = GetSafeAnimMoveDeltaPercentage(moveBackAnim);

    if(has_room_to_move_back(availableMoveBackScale)) {
      self.melee_in_move_back = true;

      self ScrAgentSetAnimMode("anim deltas");
      self ScrAgentSetPhysicsMode("gravity");

      self ScrAgentSetAnimScale(availableMoveBackScale, 1.0);
      self SetAnimState(move_back_state, move_back_entry, 1.0);

      self WaitUntilNotetrack("move_back", "finish");
      self.melee_in_move_back = false;
    }

    if(force_posture || should_posture(enemy)) {
      self.melee_in_posture = true;

      self set_alien_emissive(0.2, 0.8);
      random_entry = GetRandomAnimEntry("posture");
      self SetAnimState("posture", random_entry, 1.0);
      self ScrAgentSetOrientMode("face angle abs", self.angles);
      self WaitUntilNotetrack("posture", "end");
      self set_alien_emissive_default(0.2);

      self.melee_in_posture = false;
    } else if(should_move_side(enemy)) {
      self move_side();
    }
  }
}

move_side() {
  self endon("melee_pain_interrupt");

  if(cointoss()) {
    if(!self try_move_side("melee_move_side_left")) {
      self try_move_side("melee_move_side_right");
    }
  } else {
    if(!self try_move_side("melee_move_side_right")) {
      self try_move_side("melee_move_side_left");
    }
  }
}

try_move_side(animState) {
  animEntry = GetRandomAnimEntry(animState);
  sideMoveAnim = self GetAnimEntry(animState, animEntry);
  availableSideMoveScale = GetSafeAnimMoveDeltaPercentage(sideMoveAnim);
  availableSideMoveScale = min(availableSideMoveScale, self.xyanimscale);
  if(availableSideMoveScale > 0.5) {
    self ScrAgentSetAnimMode("anim deltas");
    self ScrAgentSetPhysicsMode("gravity");

    self ScrAgentSetAnimScale(availableSideMoveScale, 1.0);
    self SetAnimState(animState, animEntry, 1.0);

    self WaitUntilNotetrack("move_side", "finish");
    return true;
  }

  return false;
}

should_move_back(enemy) {
  MAX_MOVE_BACK_DISTANCE_SQR = 10000.0;
  if(isAlive(enemy) && DistanceSquared(self.origin, enemy.origin) > MAX_MOVE_BACK_DISTANCE_SQR) {
    return false;
  }
  return true;
}

should_posture(enemy) {
  return (isAlive(enemy) && RandomInt(100) < ALIEN_MELEE_POSTURE_PERCENT);
}

should_move_side(enemy) {
  switch (maps\mp\alien\_utility::get_alien_type()) {
    case "elite":
    case "mammoth":
    case "spitter":
    case "seeder":
      return false;
    default:
      return (isAlive(enemy) && RandomInt(100) < ALIEN_MELEE_MOVE_SIDE_PERCENT);
  }
}

has_room_to_move_back(availableMoveBackScale) {
  MIN_MOVE_BACK_SCALE = 0.5;

  return availableMoveBackScale >= MIN_MOVE_BACK_SCALE;
}

GetMoveBackState() {
  return "melee_move_back";
}

GetMoveBackEntry(move_back_state) {
  randomInteger = RandomIntRange(0, 101);
  runningTotal = 0;
  randomIndex = undefined;
  for(i = 0; i < level.alienAnimData.alienMoveBackAnimChance.size; i++) {
    runningTotal += level.alienAnimData.alienMoveBackAnimChance[i];
    if(randomInteger <= runningTotal) {
      randomIndex = i;
      break;
    }
  }
  return randomIndex;
}

onDamage(eInflictor, eAttacker, iThatDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset) {
  if(canDoPain(sMeansOfDeath, eAttacker))
    self DoPain(iDFlags, iThatDamage, sMeansOfDeath, vDir, sHitLoc);
}

canDoPain(sMeansOfDeath, eAttacker) {
  if(isDefined(level.dlc_can_do_pain_override_func)) {
    painAllowed = [[level.dlc_can_do_pain_override_func]]("melee");
    if(!painAllowed)
      return false;
  }

  switch (maps\mp\alien\_utility::get_alien_type()) {
    case "elite":
    case "mammoth":
      return false;
    default:
      painIsAvailable = maps\mp\alien\_utility::is_pain_available(eAttacker, sMeansOfDeath);
      return (painIsAvailable && !self.melee_jumping && !self.melee_jumping_to_wall && !self.playing_pain_animation && !self.stateLocked && !self.melee_synch);
  }
}

DoPain(iDFlags, iDamage, sMeansOfDeath, vDir, sHitLoc) {
  self endon("killanimscript");

  self.playing_pain_animation = true;
  self notify("melee_pain_interrupt");

  if(isDefined(self.oriented) && self.oriented) {
    self ScrAgentSetAnimMode("code_move");
  } else {
    self ScrAgentSetOrientMode("face angle abs", self.angles);
    self ScrAgentSetAnimMode("anim deltas");
  }

  is_stun = iDFlags &level.iDFLAGS_STUN;

  animStateInfo = get_melee_painState_info(iDamage, sMeansOfDeath, is_stun);
  animIndex = getMeleePainAnimIndex(animStateInfo["anim_state"], vDir, sHitLoc);
  anime = self GetAnimEntry(animStateInfo["anim_state"], animIndex);
  self maps\mp\alien\_utility::always_play_pain_sound(anime);
  self maps\mp\alien\_utility::register_pain(anime);

  self PlayAnimNUntilNotetrack(animStateInfo["anim_state"], animIndex, animStateInfo["anim_label"]);
  self.playing_pain_animation = false;

  self notify("pain_finished");
}

getMeleePainAnimIndex(animState, damageDirection, hitLocation) {
  switch (animState) {
    case "pain_pushback":
      return maps\mp\agents\alien\_alien_anim_utils::getPainAnimIndex("push_back", damageDirection);

    case "idle_pain_light":
    case "idle_pain_heavy":
      return maps\mp\agents\alien\_alien_anim_utils::getPainAnimIndex("idle", damageDirection, hitLocation);

    case "move_back_pain_light":
    case "move_back_pain_heavy":
      return maps\mp\agents\alien\_alien_anim_utils::getPainAnimIndex("move_back", damageDirection);

    case "melee_pain_light":
    case "melee_pain_heavy":
      return maps\mp\agents\alien\_alien_anim_utils::getPainAnimIndex("melee", damageDirection);

    default:
      AssertMsg("Unsupported anim state: " + animState);
  }
}

check_for_player_meleeing(player) {
  playerForwardVector = anglesToForward(player.angles);
  playerToEnemyVector = VectorNormalize(self.origin - player.origin);
  dotProduct = VectorDot(playerToEnemyVector, playerForwardVector);

  if(player meleeButtonPressed() && isDefined(player.meleeStrength) && player.meleeStrength == 1 && dotProduct > 0.5)
    return true;
  else
    return false;
}

check_for_block(player) {
  if(!(isPlayer(player)))
    return false;
  if(!player.hasriotshield)
    return false;

  enemy_in_front = false;
  enemy_in_back = false;
  front_block = false;
  back_block = false;

  riot_shield = player riotShieldName();

  if(!isDefined(riot_shield))
    return false;

  shield_weapon_health = player GetWeaponAmmoClip(riot_shield);

  playerForwardVector = anglesToForward(player.angles);
  playerToEnemyVector = VectorNormalize(self.origin - player.origin);
  dotProduct = VectorDot(playerToEnemyVector, playerForwardVector);

  if(dotProduct > 0.5) {
    enemy_in_front = true;
  }

  if(dotProduct < -0.5) {
    enemy_in_back = true;
  }

  if(player.hasriotshieldequipped && enemy_in_front && (shield_weapon_health > 0)) {
    front_block = true;
  } else if(!player.hasriotshieldequipped && enemy_in_back && (shield_weapon_health > 0)) {
    back_block = true;
    is_fire_back_block = should_catch_fire(player);

    if(is_fire_back_block)
      self thread maps\mp\alien\_damage::catch_alien_on_fire(player, 1, 75);
  }

  if(front_block || back_block) {
    player SetWeaponAmmoClip(riot_shield, (shield_weapon_health - 1));
    player notify("riotshield_block");
    player SetClientOmnvar("ui_alien_stowed_riotshield_ammo", shield_weapon_health - 1);
    player playSound("melee_riotshield_impact");
    Earthquake(0.75, 0.5, player.origin, 100);
    if(self should_snare(player))
      player maps\mp\alien\_damage::applyAlienSnare();

    if(player GetWeaponAmmoClip(riot_shield) == 0) {
      if(player HasWeapon(riot_shield)) {
        player TakeWeapon(riot_shield);
        player.hasRiotShield = false;
        player.hasRiotshieldequipped = false;

        if(front_block) {
          player DetachShieldModel("weapon_riot_shield_iw6", "tag_weapon_right");
          player playSound("melee_riotshield_impact");
          player IPrintLnBold(&"ALIENS_HANDY_RIOT_DESTROYED");
        }

        if(back_block) {
          player DetachShieldModel("weapon_riot_shield_iw6", "tag_shield_back");
          player playSound("melee_riotshield_impact");
          player IPrintLnBold(&"ALIENS_STOWED_RIOT_DESTROYED");
        }

        player setclientomnvar("ui_alien_riotshield_equipped", -1);
      }

      weapon_list = player GetWeaponsList("primary");
      Assert(weapon_list.size);

      if(weapon_list.size > 0 && front_block) {
        player SwitchToWeapon(weapon_list[0]);
      }
    }
    return true;
  }
  return false;
}

should_catch_fire(player) {
  if(player maps\mp\alien\_persistence::is_upgrade_enabled("riotshield_back_upgrade") && self.alien_type != "spider" && self.alien_type != "kraken_tentacle" && self.alien_type != "kraken")
    return true;
  else
    return false;
}

melee_clean_up(attacker) {
  self endon("death");
  self endon("disconnect");

  attacker_alien_type = attacker maps\mp\alien\_utility::get_alien_type();

  attacker waittill("killanimscript");

  if(attacker_alien_type == "elite" || attacker_alien_type == "mammoth")
    self.being_charged = false;
}

get_melee_painState_info(iDamage, sMeansOfDeath, is_stun) {
  result = [];

  if(sMeansOfDeath == "MOD_MELEE") {
    result["anim_label"] = "pain_pushback";
    result["anim_state"] = "pain_pushback";
    return result;
  }

  switch (self.melee_type) {
    case "spit":
      result["anim_state"] = "idle_pain_light";
      result["anim_label"] = "idle_pain";
      break;
    default:
      if(self.melee_in_move_back) {
        primaryAnimState = "move_back_pain";
        result["anim_label"] = "move_back_pain";
      } else if(self.melee_in_posture) {
        primaryAnimState = "idle_pain";
        result["anim_label"] = "idle_pain";
      } else {
        primaryAnimState = "melee_pain";
        result["anim_label"] = "melee_pain";
      }

      result["anim_state"] = self maps\mp\agents\alien\_alien_anim_utils::getPainAnimState(primaryAnimState, iDamage, is_stun);
      break;
  }

  return result;
}