/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\alien\_alien_elite.gsc
*************************************************/

#include maps\mp\alien\_utility;

ALIEN_CHARGE_ATTACK_DISTANCE_MAX = 500;
ALIEN_CHARGE_ATTACK_DISTANCE_MIN = 350;
ALIEN_CHARGE_COOLDOWN_MSEC = 12000;

ALIEN_SLAM_MIN_DISTANCE = 175;
ALIEN_SLAM_RADIUS = 250;
ELITE_SWIPE_OFFSET_XY = 125;
ELITE_MAX_SWIPE_DAMAGE_DIST = 175;

ANGERED_DAMAGE_SCALAR = 1.25;

ELITE_ATTACK_START_SOUND = "";
CHARGE_HIT_SOUND = "";
CHARGE_ATTACK_START_SOUND = "";
ELITE_REGEN_START_SOUND = "";

elite_approach(enemy, attack_counter) {
  /# maps\mp\agents\alien\_alien_think::debug_alien_ai_state( "elite_approach" ); #/ /
  # maps\mp\agents\alien\_alien_think::debug_alien_attacker_state("attacking");

  if(DistanceSquared(enemy.origin, self.origin) > ALIEN_CHARGE_ATTACK_DISTANCE_MAX * ALIEN_CHARGE_ATTACK_DISTANCE_MAX) {
    self maps\mp\agents\alien\_alien_think::run_near_enemy(ALIEN_CHARGE_ATTACK_DISTANCE_MAX, enemy);
  }

  while(true) {
    if(can_do_charge_attack(enemy)) {
      return "charge";
    } else if(run_to_slam(enemy)) {
      return "slam";
    }

    wait 0.05;
  }
}

run_to_slam(enemy) {
  self thread monitor_charge_range(enemy);
  self thread run_to_enemy(enemy);

  msg = self common_scripts\utility::waittill_any_return("run_to_slam_complete", "in_charge_range", "enemy", "bad_path");
  if(!self AgentCanSeeSentient(enemy)) {
    return false;
  }

  return (msg == "run_to_slam_complete");
}

run_to_enemy(enemy) {
  enemy endon("death");
  self endon("enemy");
  self endon("bad_path");

  startTime = GetTime();

  self maps\mp\agents\alien\_alien_think::run_near_enemy(ALIEN_SLAM_MIN_DISTANCE, enemy);

  if(startTime == GetTime()) {
    wait 0.05;
  }

  self notify("run_to_slam_complete");
}

monitor_charge_range(enemy) {
  self endon("goal_reached");
  enemy endon("death");
  self endon("enemy");
  self endon("bad_path");

  chargeRangeSquared = ALIEN_CHARGE_ATTACK_DISTANCE_MIN * ALIEN_CHARGE_ATTACK_DISTANCE_MIN;
  wait 0.05;

  while(true) {
    if(DistanceSquared(self.origin, enemy.origin) >= chargeRangeSquared) {
      break;
    }

    wait 0.2;
  }

  self notify("in_charge_range");
}

can_do_charge_attack(enemy) {
  if(gettime() < self.last_charge_time + ALIEN_CHARGE_COOLDOWN_MSEC) {
    return false;
  }

  if(DistanceSquared(self.origin, enemy.origin) < ALIEN_CHARGE_ATTACK_DISTANCE_MIN * ALIEN_CHARGE_ATTACK_DISTANCE_MIN) {
    return false;
  }

  if(!maps\mp\agents\_scriptedagents::CanMovePointToPoint(self.origin, enemy.origin)) {
    return false;
  }

  return self maps\mp\alien\_utility::is_normal_upright(anglesToUp(self.angles));
}

ground_slam(enemy) {
  self.melee_type = "slam";
  maps\mp\agents\alien\_alien_think::alien_melee(enemy);
}

ALIEN_ELITE_GROUND_SLAM_IMPULSE = 800;

do_ground_slam(enemy) {
  self endon("death");

  self maps\mp\agents\alien\_alien_anim_utils::turnTowardsEntity(enemy);
  self ScrAgentSetOrientMode("face enemy");

  self maps\mp\agents\alien\_alien_melee::try_preliminary_swipes("swipe", enemy, ELITE_SWIPE_OFFSET_XY, ELITE_MAX_SWIPE_DAMAGE_DIST);
  self maps\mp\agents\_scriptedagents::PlayAnimNUntilNotetrack("attack_melee_swipe", 2, "attack_melee", "alien_slam_big");

  min_damage = level.alien_types[self.alien_type].attributes["slam_min_damage"];
  max_damage = level.alien_types[self.alien_type].attributes["slam_max_damage"];

  if(isDefined(self.elite_angered)) {
    min_damage *= get_angered_damage_scalar();
    max_damage *= get_angered_damage_scalar();
  }
  self area_damage_and_impulse(ALIEN_SLAM_RADIUS, min_damage, max_damage, ALIEN_ELITE_GROUND_SLAM_IMPULSE);
  self maps\mp\agents\_scriptedagents::WaitUntilNotetrack("attack_melee", "end");

  if(!isDefined(self.elite_angered)) {
    meleeSuccess = self maps\mp\agents\alien\_alien_melee::move_back(enemy, true);
  }
  self set_alien_emissive_default(0.2);
}

charge_attack(enemy) {
  /# maps\mp\agents\alien\_alien_think::debug_alien_ai_state( "charge_attack" );

  if(enemy being_charged()) {
    wait 0.2;
    return;
  }

  self.melee_type = "charge";
  maps\mp\agents\alien\_alien_think::alien_melee(enemy);
  enemy.being_charged = false;
}

angered(enemy) {
  /# maps\mp\agents\alien\_alien_think::debug_alien_ai_state( "health_regen" );

  self.melee_type = "angered";
  maps\mp\agents\alien\_alien_think::alien_melee(enemy);
}

do_charge_attack(enemy) {
  self endon("death");

  enemy.being_charged = true;
  self.last_charge_time = gettime();
  self set_alien_emissive(0.2, 1.0);
  self maps\mp\agents\alien\_alien_anim_utils::turnTowardsEntity(enemy);

  self ScrAgentSetAnimMode("anim deltas");
  self ScrAgentSetPhysicsMode("gravity");
  self ScrAgentSetOrientMode("face enemy");

  charge_start_index = get_charge_start_index();
  self maps\mp\agents\_scriptedagents::PlayAnimNAtRateUntilNotetrack("charge_attack_start", charge_start_index, 1.15, "charge_attack_start", "end", ::chargeStartNotetrackHandler);

  if(isAlive(enemy) && can_see_enemy(enemy)) {
    self thread track_enemy(enemy);
    self SetAnimState("charge_attack", charge_start_index, 1.0);

    result = watch_charge_hit(enemy, charge_start_index);
    self notify("charge_complete");
    self ScrAgentSetOrientMode("face angle abs", self.angles);

    if(!isDefined(result)) {
      result = "fail";
    }

    switch (result) {
      case "success":
        self maps\mp\agents\_scriptedagents::SafelyPlayAnimNAtRateUntilNotetrack("charge_attack_bump", charge_start_index, 1.0, "charge_attack_bump", "end", ::chargeEndNotetrackHandler);
        break;
      case "fail":
        self play_stop_anim(charge_start_index);
        break;
      default:
        assertmsg("Unknown charge hit result: " + result);
        break;
    }
    self ScrAgentSetAnimMode("code_move");
  }

  self set_alien_emissive_default(0.2);
}

can_see_enemy(enemy) {
  return SightTracePassed(self getEye(), enemy getEye(), false, self);
}

track_enemy(enemy) {
  self endon("death");
  self endon("charge_complete");

  STOP_TRACKING_DISTANCE_SQ = 325 * 325;
  self.charge_tracking_enemy = true;

  while(true) {
    if(DistanceSquared(self.origin, enemy.origin) < STOP_TRACKING_DISTANCE_SQ) {
      break;
    }

    wait 0.05;
  }

  self ScrAgentSetOrientMode("face angle abs", self.angles);
  self.charge_tracking_enemy = false;
}

play_stop_anim(anim_index) {
  FORWARD_CLEARANCE = 120;

  if(hit_geo(FORWARD_CLEARANCE)) {
    go_hit_geo();
  } else {
    self maps\mp\agents\_scriptedagents::SafelyPlayAnimNAtRateUntilNotetrack("charge_attack_stop", anim_index, 1.0, "charge_attack_stop", "end", ::chargeEndNotetrackHandler);
  }
}

go_hit_geo() {
  hit_geo_index = get_hit_geo_index();
  hit_geo_anim = self GetAnimEntry("charge_hit_geo", hit_geo_index);
  notetrack_time = GetNotetrackTimes(hit_geo_anim, "forward_end");
  forward_delta = length(GetMoveDelta(hit_geo_anim, 0.0, notetrack_time[0]));

  while(true) {
    if(hit_geo(forward_delta)) {
      break;
    }

    common_scripts\utility::waitframe();
  }
  self maps\mp\agents\_scriptedagents::SafelyPlayAnimNAtRateUntilNotetrack("charge_hit_geo", hit_geo_index, 1.0, "charge_hit_geo", "end", ::chargeEndNotetrackHandler);
}

watch_charge_hit(enemy, anim_index) {
  self endon("death");
  enemy endon("death");

  MIN_CHARGE_TIME = 3.0;
  MAX_CHARGE_TIME = 6.0;
  FRAME_TIME = 0.05;

  chargeStopAnim = self GetAnimEntry("charge_attack_stop", anim_index);
  num_loops = int(randomFloatRange(MIN_CHARGE_TIME, MAX_CHARGE_TIME) / FRAME_TIME);
  animDistance = Length(GetMoveDelta(chargeStopAnim));
  animLength = GetAnimLength(chargeStopAnim);
  shortLookAheadDistance = (animDistance / animLength) * FRAME_TIME * 3;

  for(i = 0; i < num_loops; i++) {
    if(hit_player()) {
      return "success";
    }

    if(self.charge_tracking_enemy) {
      lookAheadDistance = Distance(enemy.origin, self.origin);
    } else {
      lookAheadDistance = shortlookAheadDistance;
    }

    if(hit_geo(lookAheadDistance)) {
      return "fail";
    }

    if(!self.charge_tracking_enemy && missed_enemy(enemy)) {
      return "fail";
    }

    common_scripts\utility::waitframe();
  }
  return "fail";
}

ALIEN_ELITE_CHARGE_IMPULSE = 1200;

hit_player() {
  CHARGE_HIT_DIST = 140;

  foreach(player in level.players) {
    if(distanceSquared(self.origin, player.origin) < CHARGE_HIT_DIST * CHARGE_HIT_DIST &&
      might_hit_enemy(player)
    ) {
      self maps\mp\agents\alien\_alien_melee::melee_DoDamage(player, "charge");
      player player_fly_back(ALIEN_ELITE_CHARGE_IMPULSE, vectorNormalize(player.origin - self.origin));
      return true;
    }
  }
  return false;
}

hit_geo(lookAheadDistance) {
  OFFSET_HEIGHT = 18.0;
  COS_30 = 0.866;

  traceStart = self.origin + (0, 0, OFFSET_HEIGHT);
  traceEnd = traceStart + anglesToForward(self.angles) * lookAheadDistance;

  hitInfo = self AIPhysicsTrace(traceStart, traceEnd, self.radius, self.height - OFFSET_HEIGHT, true, true);
  return hitInfo["fraction"] < 1.0 && hitInfo["normal"][2] < COS_30;
}

player_fly_back(impulse, direction) {
  MAX_SPEED = 600.0;
  original_velocity = self GetVelocity();
  impluse_velocity = direction * impulse;

  final_velocity = (original_velocity + impluse_velocity) * (1, 1, 0);
  speed = Length(final_velocity);

  if(speed >= 400.0) {
    final_velocity = VectorNormalize(final_velocity) * 400.0;
  }

  self SetVelocity(final_velocity);
}

might_hit_enemy(enemy) {
  CONE_LIMIT = 0.866;

  can_see_enemy = can_see_enemy(enemy);

  self_to_enemy = vectorNormalize(enemy.origin - self.origin);
  self_forward = anglesToForward(self.angles);
  enemy_in_front_cone = VectorDot(self_to_enemy, self_forward) > CONE_LIMIT;

  return (can_see_enemy && enemy_in_front_cone);
}

missed_enemy(enemy) {
  pastEnemyDistance = -256;
  can_see_enemy = can_see_enemy(enemy);

  if(!can_see_enemy) {
    return true;
  }

  self_to_enemy = enemy.origin - self.origin;
  self_forward = anglesToForward(self.angles);
  distancePast = VectorDot(self_to_enemy, self_forward);

  if(distancePast > 0) {
    return false;
  }

  return distancePast < pastEnemyDistance;
}

being_charged() {
  return (isDefined(self.being_charged) && self.being_charged);
}

get_charge_start_index() {
  animWeights = [40,
    30,
    30
  ];
  return get_weighted_index("charge_attack_start", animWeights);
}

get_hit_geo_index() {
  animWeights = [15,
    25,
    60
  ];
  return get_weighted_index("charge_hit_geo", animWeights);
}

get_weighted_index(animState, animWeights) {
  nEntries = self GetAnimEntryCount(animState);
  assert(animWeights.size == nEntries);
  return maps\mp\alien\_utility::GetRandomIndex(animWeights);
}

load_queen_fx() {
  level._effect["queen_shield_impact"] = Loadfx("fx/impacts/large_metalhit_1");
  level._effect["queen_ground_spawn"] = LoadFX("vfx/gameplay/alien/vfx_alien_elite_ground_spawn");
}

elite_init() {
  self.next_health_regen_time = getTime();
  self.last_charge_time = gettime();
  if(!isPlayingSolo()) {
    self.elite_angered = true;
    self.moveplaybackrate = 1.2;
  }
}

activate_angered_state() {
  prepare_to_regenerate();

  CONST_HEALTH_REGEN_TIME = 10.0;
  CONST_HEALTH_REGEN_COOL_DOWN = 60000;

  self.elite_angered = true;
  self.moveplaybackrate = 1.2;

  activate_health_regen_shield();
}

activate_health_regen() {
  level endon("game_ended");
  self endon("death");

  prepare_to_regenerate();

  CONST_HEALTH_REGEN_TIME = 10.0;
  CONST_HEALTH_REGEN_COOL_DOWN = 60000;

  self.next_health_regen_time = getTime() + CONST_HEALTH_REGEN_COOL_DOWN;

  thread play_health_regen_anim();

  activate_health_regen_shield();
  thread queen_health_regen(CONST_HEALTH_REGEN_TIME);

  self common_scripts\utility::waittill_any_timeout(CONST_HEALTH_REGEN_TIME, "stop_queen_health_regen");

  disable_health_regen_shield();
}

ALIEN_ELITE_REGEN_IMPULSE_RADIUS = 200;
ALIEN_ELITE_REGEN_IMPULSE = 800;

prepare_to_regenerate() {
  self ScrAgentSetAnimMode("anim deltas");
  self ScrAgentSetOrientMode("face angle abs", self.angles);

  maps\mp\agents\_scriptedagents::PlayAnimNAtRateUntilNotetrack("prepare_to_regen", 0, 2.0, "prepare_to_regen", "end");

  min_damage = level.alien_types[self.alien_type].attributes["explode_min_damage"];
  max_damage = level.alien_types[self.alien_type].attributes["explode_max_damage"];

  if(isDefined(self.elite_angered)) {
    min_damage *= get_angered_damage_scalar();
    max_damage *= get_angered_damage_scalar();
  }
  area_damage_and_impulse(ALIEN_ELITE_REGEN_IMPULSE_RADIUS, min_damage, max_damage, ALIEN_ELITE_REGEN_IMPULSE);
}

play_health_regen_anim() {
  level endon("game_ended");
  self endon("death");
  self endon("stop_queen_health_regen");

  self ScrAgentSetAnimMode("anim deltas");
  self ScrAgentSetOrientMode("face angle abs", self.angles);

  anim_state = "regen";

  while(true) {
    maps\mp\agents\_scriptedagents::PlayAnimUntilNotetrack(anim_state, anim_state, "end");
  }
}

queen_health_regen(CONST_HEALTH_REGEN_TIME) {
  level endon("game_ended");
  self endon("death");
  self endon("stop_queen_health_regen");

  CONST_HEALTH_REGEN_INTERVAL = 1.0;

  num_of_regen = int(CONST_HEALTH_REGEN_TIME / CONST_HEALTH_REGEN_INTERVAL);
  total_health_to_regen = (self.maxhealth - self.health) / 2;
  health_each_regen = int(total_health_to_regen / num_of_regen);

  for(i = 0; i < num_of_regen; i++) {
    wait(CONST_HEALTH_REGEN_INTERVAL);
    self.health += health_each_regen;
  }
}

activate_health_regen_shield() {}

disable_health_regen_shield() {
  self SetScriptablePartState("body", "normal");
}

clean_up_on_owner_death(owner) {
  level endon("game_ended");
  self endon("death");
  owner endon("stop_queen_health_regen");

  owner waittill("death");
  self delete();
}

deploy_health_regen_shield() {
  shield = spawn("script_model", self.origin);
  shield setModel("alien_shield_bubble_distortion");
  shield linkTo(self, "tag_origin");
  shield setCanDamage(true);

  return shield;
}

play_shield_impact_fx(vPoint, vDir) {
  if(isDefined(vDir)) {
    forward_vector = vDir * -1;
  } else {
    forward_vector = anglesToForward(self.angles);
  }

  up_vector = anglesToUp(vectorToAngles(forward_vector));
  playFX(level._effect["queen_shield_impact"], vPoint, forward_vector, up_vector);
}

ALIEN_ELITE_EXPLOSIVE_RESISTANCE = 0.5;

eliteDamageProcessing(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, timeOffset) {
  switch (sMeansOfDeath) {
    case "MOD_EXPLOSIVE":
    case "MOD_GRENADE_SPLASH":
    case "MOD_GRENADE":
    case "MOD_PROJECTILE":
    case "MOD_PROJECTILE_SPLASH":
      iDamage *= ALIEN_ELITE_EXPLOSIVE_RESISTANCE;
    default:
      break;
  }

  return iDamage;
}

ALIEN_ELITE_JUMP_IMPULSE = 500;

on_jump_impact() {
  DAMAGE_RADIUS = 256;
  MAX_DAMAGE = 30;
  MIN_DAMAGE = 10;

  alienUp = anglesToUp(self.angles);
  if(!maps\mp\alien\_utility::is_normal_upright(alienUp)) {
    return;
  }
  area_damage_and_impulse(DAMAGE_RADIUS, MIN_DAMAGE, MAX_DAMAGE, ALIEN_ELITE_JUMP_IMPULSE);
}

area_damage_and_impulse(damage_radius, min_damage, max_damage, impulse) {
  RadiusDamage(self.origin, damage_radius, max_damage, min_damage, self, "MOD_EXPLOSIVE", "alienrhinoslam_mp");
  damage_radius_squared = damage_radius * damage_radius;

  foreach(player in level.players) {
    if(DistanceSquared(self.origin, player.origin) > damage_radius_squared) {
      continue;
    }
    pushDirection = VectorNormalize(player.origin - self.origin);
    player player_fly_back(impulse, pushDirection);
  }
}

get_angered_damage_scalar() {
  return ANGERED_DAMAGE_SCALAR;
}

chargeStartNotetrackHandler(note, animState, animIndex, animTime) {
  switch (note) {
    case "queen_roll_start":
      self playLoopSound("queen_roll");
      break;

    default:
      break;
  }
}

chargeEndNotetrackHandler(note, animState, animIndex, animTime) {
  switch (note) {
    case "queen_roll_stop":
      self stopLoopSound("queen_roll");
      break;

    default:
      break;
  }
}