/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_motorcycle.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_vehicle;
#include maps\_vehicle_aianim;
#include animscripts\utility;
#using_animtree("vehicles");
main() {
  build_aianims(::setanims, ::set_vehicle_anims);
}

#using_animtree("generic_human");
setanims() {
  positions = [];
  for(i = 0; i < 9; i++) {
    positions[i] = spawnStruct();
  }
  positions[0].sittag = "tag_driver";
  positions[0].idle = % crew_bike_m72_drive_straight;
  positions[0].getin = % crew_bike_m72_drive_straight;
  positions[0].getout = % crew_bike_m72_drive_straight;
  return positions;
}

set_vehicle_anims(positions) {
  return positions;
}

ride_and_shoot(bike) {
  self.ridingvehicle = bike;
  self AnimCustom(::ai_ride_and_shoot);
}

ai_ride_and_shoot() {
  self endon("death");
  self endon("start_ragdoll");
  self endon("stop_riding");
  self.bikerIsArmed = false;
  self.bikerIsAiming = false;
  self.bikerShouldJump = false;
  self.bikerShouldLand = false;
  self.prevBikerYawAimWeight = 0;
  self.prevBikerPitchAimWeight = 0;
  self.prevSideAnimWeight = 99999;
  self.max_bike_aim_yaw_angle = 70;
  self.max_bike_aim_pitch_angle = 60;
  self.max_bike_aim_angle_delta = 30;
  self.max_bike_side_yaw_angle = 90;
  if(!isDefined(self.max_bike_total_yaw_angle)) {
    self.max_bike_total_yaw_angle = self.max_bike_side_yaw_angle + self.max_bike_aim_yaw_angle;
  }
  self.max_bike_roll_angle = 30;
  if(!isDefined(self.min_blindspot_time)) {
    self.min_blindspot_time = 0.5;
  }
  blindSpotTime = 0;
  if(!isDefined(level.ai_motorcycle_death_launch_vector)) {
    level.ai_motorcycle_death_launch_vector = (200, 200, 40);
  }
  self maps\_utility::disable_pain();
  self maps\_utility::disable_react();
  self.overrideActorDamage = ::ai_ride_and_shoot_damage_override;
  self animscripts\shared::placeWeaponOn(self.primaryweapon, "left");
  self AnimMode("point relative");
  self.fixedLinkYawOnly = false;
  self ai_ride_and_shoot_linkto_bike();
  self ai_ride_and_shoot_idle();
  self thread ai_ride_and_shoot_watch_jump();
  self thread call_overloaded_func("animscripts\shoot_behavior", "decideWhatAndHowToShoot", "normal");
  while(1) {
    if(isDefined(self.shootEnt)) {
      shootPos = self.shootEnt GetShootAtPos(self, self, self);
      shootFromPos = self animscripts\shared::trackLoopGetShootFromPos();
      shootFromAngles = self animscripts\shared::trackLoopGetShootFromAngles();
      vectorToShootPos = shootPos - shootFromPos;
      anglesToShootPos = VectorToAngles(vectorToShootPos);
      facingVector = anglesToForward(shootFromAngles);
      yawToEnemy = AngleClamp180(shootFromAngles[1] - anglesToShootPos[1]);
      pitchToEnemy = AngleClamp180(shootFromAngles[0] - anglesToShootPos[0]);
      realYawToEnemy = self GetYawToOrigin(shootPos);
      if(abs(realYawToEnemy) < self.max_bike_total_yaw_angle) {
        if(!self.bikerIsArmed) {
          self ai_ride_and_shoot_gun_pullout();
          continue;
        }
        yawAimWeight = abs(yawToEnemy / self.max_bike_aim_yaw_angle);
        aimDelta = yawAimWeight - self.prevBikerYawAimWeight;
        maxWeightChange = self.max_bike_aim_angle_delta / self.max_bike_aim_yaw_angle;
        if(abs(aimDelta) > maxWeightChange) {
          yawAimWeight = self.prevBikerYawAimWeight + maxWeightChange * sign(aimDelta);
        }
        if(yawAimWeight > 1) {
          yawAimWeight = 1;
        }
        if(yawToEnemy < 0) {
          self SetAnimLimited( % moto_aim_4, yawAimWeight, 0.05);
          self SetAnimLimited( % moto_aim_6, 0, 0.05);
        } else {
          self SetAnimLimited( % moto_aim_6, yawAimWeight, 0.05);
          self SetAnimLimited( % moto_aim_4, 0, 0.05);
        }
        pitchAimWeight = abs(pitchToEnemy / self.max_bike_aim_pitch_angle);
        if(abs(pitchAimWeight) > 1) {
          pitchAimWeight = sign(pitchAimWeight);
        }
        aimDelta = pitchAimWeight - self.prevBikerPitchAimWeight;
        maxWeightChange = self.max_bike_aim_angle_delta / self.max_bike_aim_pitch_angle;
        if(abs(aimDelta) > maxWeightChange) {
          pitchAimWeight = self.prevBikerPitchAimWeight + maxWeightChange * sign(aimDelta);
        }
        if(pitchToEnemy < 0) {
          self SetAnimLimited( % moto_aim_2, pitchAimWeight, 0.05);
          self SetAnimLimited( % moto_aim_8, 0, 0.05);
        } else {
          self SetAnimLimited( % moto_aim_8, pitchAimWeight, 0.05);
          self SetAnimLimited( % moto_aim_2, 0, 0.05);
        }
        self.prevBikerYawAimWeight = yawAimWeight;
        self.prevBikerPitchAimWeight = pitchAimWeight;
        blindSpotTime = 0;
      } else {
        blindSpotTime += 0.05;
        if(blindSpotTime > self.min_blindspot_time) {
          self ai_ride_and_shoot_gun_blindfire();
          self ai_ride_and_shoot_gun_putaway(0);
          blindSpotTime = 0;
          continue;
        } else if(self.bikerIsArmed) {
          self ai_ride_and_shoot_gun_putaway();
        }
      }
    } else if(self.bikerIsArmed) {
      self ai_ride_and_shoot_gun_putaway();
    }
    if(self.bikerIsArmed) {
      self ai_ride_and_shoot_aim_idle();
    } else {
      self ai_ride_and_shoot_idle();
    }
    wait(0.05);
  }
}

ai_ride_stop_riding() {
  self endon("death");
  self endon("start_ragdoll");
  self notify("stop_riding");
  self ClearAnim( % root, 0);
  self Unlink();
}

ai_ride_and_shoot_linkto_bike() {
  assert(isDefined(self.ridingvehicle));
  tag_driver_origin = self.ridingvehicle GetTagOrigin("tag_driver");
  tag_driver_angles = self.ridingvehicle GetTagAngles("tag_driver");
  self ForceTeleport(tag_driver_origin, tag_driver_angles);
  self LinkTo(self.ridingvehicle, "tag_driver");
  self ClearAnim( % root, 0);
}

ai_ride_and_shoot_aiming_on(sideAnimWeight) {
  if(!isDefined(sideAnimWeight)) {
    sideAnimWeight = 0;
  }
  if(sideAnimWeight < 0) {
    sideAnimWeight = abs(sideAnimWeight);
    self SetAnimKnobLimited( % crew_bike_m72_aim_l_2, sideAnimWeight, 0);
    self SetAnimKnobLimited( % crew_bike_m72_aim_l_4, sideAnimWeight, 0);
    self SetAnimKnobLimited( % crew_bike_m72_aim_l_6, sideAnimWeight, 0);
    self SetAnimKnobLimited( % crew_bike_m72_aim_l_8, sideAnimWeight, 0);
    if(sideAnimWeight > 0.5) {
      self SetFlaggedAnimLimited("fireAnim", % crew_bike_m72_l_fire, sideAnimWeight, 0);
    } else {
      self SetAnimLimited( % crew_bike_m72_l_fire, sideAnimWeight, 0);
    }
  } else {
    self SetAnimKnobLimited( % crew_bike_m72_aim_r_2, sideAnimWeight, 0);
    self SetAnimKnobLimited( % crew_bike_m72_aim_r_4, sideAnimWeight, 0);
    self SetAnimKnobLimited( % crew_bike_m72_aim_r_6, sideAnimWeight, 0);
    self SetAnimKnobLimited( % crew_bike_m72_aim_r_8, sideAnimWeight, 0);
    if(sideAnimWeight > 0.5) {
      self SetFlaggedAnimLimited("fireAnim", % crew_bike_m72_r_fire, sideAnimWeight, 0);
    } else {
      self SetAnimLimited( % crew_bike_m72_r_fire, sideAnimWeight, 0);
    }
  }
  self SetAnimLimited( % crew_bike_m72_aim_f_2, 1 - sideAnimWeight, 0);
  self SetAnimLimited( % crew_bike_m72_aim_f_4, 1 - sideAnimWeight, 0);
  self SetAnimLimited( % crew_bike_m72_aim_f_6, 1 - sideAnimWeight, 0);
  self SetAnimLimited( % crew_bike_m72_aim_f_8, 1 - sideAnimWeight, 0);
  if(sideAnimWeight < 1) {
    if(sideAnimWeight < 0.5) {
      self SetFlaggedAnimLimited("fireAnim", % crew_bike_m72_f_fire, 1 - sideAnimWeight, 0);
    } else {
      self SetAnimLimited( % crew_bike_m72_f_fire, 1 - sideAnimWeight, 0);
    }
  }
  self animscripts\weaponList::RefillClip();
}

ai_ride_and_shoot_idle() {
  if(self.bikerShouldJump) {
    self ai_ride_and_shoot_jump();
    return;
  }
  self.bikerIsAiming = false;
  self.bikerIsArmed = false;
  rollAnimWeight = 0;
  self SetAnim( % crew_bike_m72_drive_straight, 1 - rollAnimWeight, 0.2, 1);
}

ai_ride_and_shoot_aim_idle(blendTime) {
  if(self.bikerShouldJump) {
    self ai_ride_and_shoot_jump();
    return;
  }
  self.bikerIsAiming = true;
  assert(isDefined(self.shootEnt));
  realYawToEnemy = self GetYawToOrigin(self.shootEnt.origin);
  sideAnimWeight = realYawToEnemy / self.max_bike_side_yaw_angle;
  if(abs(sideAnimWeight) > 1) {
    sideAnimWeight = sign(sideAnimWeight);
  }
  if(self.prevSideAnimWeight == sideAnimWeight) {
    return;
  }
  self.prevSideAnimWeight = sideAnimWeight;
  ai_ride_and_shoot_aiming_on(sideAnimWeight);
  if(!isDefined(blendTime)) {
    blendTime = 0.05;
  }
  if(sideAnimWeight < 0) {
    sideAnimWeight = abs(sideAnimWeight);
    self SetAnim( % crew_bike_m72_aim_l_5, sideAnimWeight, blendTime, 1);
    self SetAnim( % crew_bike_m72_aim_r_5, 0, blendTime, 1);
  } else {
    self SetAnim( % crew_bike_m72_aim_r_5, sideAnimWeight, blendTime, 1);
    self SetAnim( % crew_bike_m72_aim_l_5, 0, blendTime, 1);
  }
  self SetAnim( % crew_bike_m72_aim_f_5, 1 - sideAnimWeight, blendTime, 1);
}

ai_ride_and_shoot_lean() {
  rollAnimWeight = abs(self.ridingvehicle.angles[2]) / self.max_bike_roll_angle;
  if(rollAnimWeight > 1) {
    rollAnimWeight = 1;
  }
  if(self.bikerIsAiming) {
    if(self.ridingvehicle.angles[2] < 0) {
      self SetAnim( % crew_bike_m72_lean_left_armed, rollAnimWeight, 0.2, 1);
      self SetAnim( % crew_bike_m72_lean_right_armed, 0, 0.2, 1);
    } else {
      self SetAnim( % crew_bike_m72_lean_left_armed, 0, 0.2, 1);
      self SetAnim( % crew_bike_m72_lean_right_armed, rollAnimWeight, 0.2, 1);
    }
  } else {
    if(self.ridingvehicle.angles[2] < 0) {
      self SetAnim( % crew_bike_m72_lean_left_unarmed, rollAnimWeight, 0.2, 1);
      self SetAnim( % crew_bike_m72_lean_right_unarmed, 0, 0.2, 1);
    } else {
      self SetAnim( % crew_bike_m72_lean_left_unarmed, 0, 0.2, 1);
      self SetAnim( % crew_bike_m72_lean_right_unarmed, rollAnimWeight, 0.2, 1);
    }
  }
  return rollAnimWeight;
}

ai_ride_and_shoot_gun_pullout() {
  self SetFlaggedAnimKnobAllRestart("ride", % crew_bike_m72_aim_gun_pullot, % body, 1, 0.2, 1);
  self waittillmatch("ride", "end");
  self.prevSideAnimWeight = 99999;
  blendTime = 0.2;
  if(isDefined(self.shootEnt)) {
    self ClearAnim( % crew_bike_m72_aim_gun_pullot, blendTime);
    self ClearAnim( % crew_bike_m72_lean_left_unarmed, blendTime);
    self ClearAnim( % crew_bike_m72_lean_right_unarmed, blendTime);
    self.bikerIsArmed = true;
    self.prevBikerYawAimWeight = 0;
    self.prevBikerPitchAimWeight = 0;
    self ai_ride_and_shoot_aim_idle(blendTime);
    wait(blendTime);
    self thread ai_ride_and_shoot_gun_shoot();
  } else {
    self ai_ride_and_shoot_gun_putaway(0);
  }
}

ai_ride_and_shoot_gun_putaway(aimForwardTime) {
  self notify("stopShooting");
  self SetAnim( % moto_fire, 0, 0);
  if(!isDefined(aimForwardTime)) {
    aimForwardTime = 0.3;
  }
  self SetAnimLimited( % moto_aim_4, 0, aimForwardTime);
  self SetAnimLimited( % moto_aim_6, 0, aimForwardTime);
  wait(aimForwardTime);
  self SetFlaggedAnimKnobAllRestart("ride", % crew_bike_m72_aim_gun_putaway, % body, 1, 0.2, 1);
  self waittillmatch("ride", "end");
  self ClearAnim( % crew_bike_m72_aim_gun_putaway, 0.2);
  self ClearAnim( % crew_bike_m72_lean_left_armed, 0.2);
  self ClearAnim( % crew_bike_m72_lean_right_armed, 0.2);
  self.bikerIsArmed = false;
  self ai_ride_and_shoot_idle();
}

ai_ride_and_shoot_gun_shoot() {
  self endon("death");
  self endon("stopShooting");
  self endon("start_ragdoll");
  self SetAnim( % moto_fire, 1, 0);
  while(1) {
    self waittillmatch("fireAnim", "fire");
    self shootEnemyWrapper();
    wait(0.05);
  }
}

ai_ride_and_shoot_jump() {
  self endon("death");
  self endon("start_ragdoll");
  if(self.bikerIsArmed) {
    self notify("stopShooting");
    self SetFlaggedAnimKnobAllRestart("jump", % crew_bike_m72_jump_start_armed, % body, 1, 0.2, 1);
    while(!self.bikerShouldLand) {
      wait(0.05);
    }
    self SetFlaggedAnimKnobAllRestart("jump", % crew_bike_m72_jump_land_armed, % body, 1, 0.2, 1);
    self waittillmatch("jump", "end");
    self ClearAnim( % crew_bike_m72_jump_land_armed, 0.2);
    self.prevSideAnimWeight = 99999;
    self thread ai_ride_and_shoot_gun_shoot();
  } else {
    self SetFlaggedAnimKnobAllRestart("jump", % crew_bike_m72_jump_start_unarmed, % body, 1, 0.2, 1);
    while(!self.bikerShouldLand) {
      wait(0.05);
    }
    self SetFlaggedAnimKnobAllRestart("jump", % crew_bike_m72_jump_land_unarmed, % body, 1, 0.2, 1);
    self waittillmatch("jump", "end");
    self ClearAnim( % crew_bike_m72_jump_land_unarmed, 0.2);
  }
  self.bikerShouldJump = false;
  if(self.bikerIsArmed && isDefined(self.shootEnt)) {
    self ai_ride_and_shoot_aim_idle();
  } else {
    self ai_ride_and_shoot_idle();
  }
}

ai_ride_and_shoot_watch_jump() {
  self endon("death");
  self endon("start_ragdoll");
  while(1) {
    self.ridingvehicle waittill("veh_inair");
    self.bikerShouldLand = false;
    self.bikerShouldJump = true;
    self.ridingvehicle waittill("veh_landed");
    self.bikerShouldLand = true;
    self.bikerShouldJump = false;
  }
}

ai_ride_and_shoot_gun_blindfire() {
  self notify("stopShooting");
  if(!self.bikerIsArmed) {
    self SetFlaggedAnimKnobAllRestart("ride", % crew_bike_m72_aim_gun_pullot, % body, 1, 0.2, 1);
    self waittillmatch("ride", "end");
    self.prevSideAnimWeight = 99999;
    blendTime = 0.2;
    self ClearAnim( % crew_bike_m72_aim_gun_pullot, blendTime);
    self ClearAnim( % crew_bike_m72_lean_left_unarmed, blendTime);
    self ClearAnim( % crew_bike_m72_lean_right_unarmed, blendTime);
    self.bikerIsArmed = true;
  }
  self SetFlaggedAnimKnobAllRestart("blindfire", % crew_bike_m72_blindfire, % body, 1, 0.2, 1);
  self animscripts\shared::DoNotetracks("blindfire");
  self ClearAnim( % crew_bike_m72_blindfire, 0.2);
  self thread ai_ride_and_shoot_gun_shoot();
  self.prevSideAnimWeight = 99999;
}

ai_ride_and_shoot_damage_override(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc, modelIndex, psOffsetTime) {
  self.deathFunction = ::ai_ride_and_shoot_ragdoll_death;
  return self.health + 10;
}

ai_ride_and_shoot_ragdoll_death() {
  self.a.doingRagdollDeath = true;
  self animscripts\shared::DropAllAIWeapons();
  velocity = anglesToForward(self.angles);
  assert(isDefined(level.ai_motorcycle_death_launch_vector));
  velocity = (velocity[0] * level.ai_motorcycle_death_launch_vector[0],
    velocity[1] * level.ai_motorcycle_death_launch_vector[1],
    level.ai_motorcycle_death_launch_vector[2]);
  self Unlink();
  self StartRagdoll();
  self LaunchRagdoll(velocity);
  recordLine(self.origin, self.origin + velocity, (1, 0, 0), "Script", self);
  return true;
}