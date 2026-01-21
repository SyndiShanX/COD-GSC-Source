/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\death.gsc
**************************************/

#include common_scripts\utility;
#include animscripts\utility;
#include animscripts\anims;
#include maps\_utility;
#using_animtree("generic_human");
main() {
  self trackScriptState("Death Main", "code");
  self endon("killanimscript");
  self stopsounds();
  if(isDefined(self.coverLookAtTrigger)) {
    self.coverLookAtTrigger Delete();
  }
  self flamethrower_stop_shoot();
  self LookAtEntity();
  if(isDefined(level.missionCallbacks)) {}
  if(self.a.nodeath == true) {
    wait 0.1;
    return;
  }
  if(isDefined(self.deathFunction)) {
    successful_death = self[[self.deathFunction]]();
    if(!isDefined(successful_death) || successful_death) {
      return;
    }
  }
  changeTime = 0.3;
  self ClearAnim(%scripted_look_straight, changeTime);
  self ClearAnim(%scripted_talking, changeTime);
  animscripts\utility::initialize("death");
  self notify("never look at anything again");
  removeSelfFrom_SquadLastSeenEnemyPos(self.origin);
  anim.numDeathsUntilCrawlingPain--;
  anim.numDeathsUntilCornerGrenadeDeath--;
  if(isDefined(self.deathanim)) {
    return playCustomDeathAnim();
  }
  explosiveDamage = self call_overloaded_func("animscripts\pain", "wasDamagedByExplosive");
  explosiveDamage = explosiveDamage && (!isDefined(self.noExplosiveDeathAnim) || !self.noExplosiveDeathAnim);
  if(self.damageLocation == "helmet") {
    self helmetPop();
  } else if(explosiveDamage && randomInt(2) == 0) {
    self helmetPop();
  }
  self ClearAnim(%root, 0.3);
  playDeathSound();
  if(explosiveDamage && play_explosion_death()) {
    return;
  }
  if(special_death()) {
    return;
  }
  if(play_flame_death_anim()) {
    return;
  }
  if(play_gas_death_anim()) {
    return;
  }
  if(play_bulletgibbed_death_anim()) {
    return;
  }
  if(GetDvarFloat(#"kill_slowmo_time") > 0) {
    if(damageLocationIsAny("head", "helmet")) {
      self thread goSlowMo();
    }
  }
  if(play_bayonet_death_anim()) {
    return;
  }
  if(play_hit_by_vehicle_anim()) {
    return;
  }
  deathAnim = get_death_anim();
  play_death_anim(deathAnim);
}

play_hit_by_vehicle_anim() {
  if(self.damagemod == "MOD_CRUSH") {
    deathAnim = get_death_anim();
    self thread play_death_anim(deathAnim);
    self thread do_gib();
    self launch_ragdoll_based_on_damage_type();
    wait 0.5;
    return true;
  }
  return false;
}

goSlowMo() {
  if(GetPlayers().size > 1) {
    return;
  }
  if(!IsPlayer(self.attacker)) {
    return;
  }
  if(self.team == self.attacker.team) {
    return;
  }
  SetTimeScale(0.2);
  time = GetDvarFloat(#"kill_slowmo_time");
  wait(time);
  SetTimeScale(1);
}

waitForRagdoll(time) {
  wait(time);
  do_ragdoll = true;
  if(is_true(self.nodeathragdoll)) {
    do_ragdoll = false;
  }
  if(isDefined(self) && do_ragdoll) {
    self StartRagDoll();
  }
  if(isDefined(self)) {
    self animscripts\shared::DropAllAIWeapons();
  }
}

get_extended_death_seq(deathAnim) {
  deathSeq = [];
  if(animArrayExist("flameA_start") && deathAnim == animArray("flameA_start")) {
    deathSeq[0] = animArray("flameA_start");
    deathSeq[1] = animArray("flameA_loop");
    deathSeq[2] = animArray("flameA_end");
  } else if(animArrayExist("flameB_start") && deathAnim == animArray("flameB_start")) {
    deathSeq[0] = animArray("flameB_start");
    deathSeq[1] = animArray("flameB_loop");
    deathSeq[2] = animArray("flameB_end");
  } else if(animArrayExist("gasA_start") && deathAnim == animArray("gasA_start")) {
    deathSeq[0] = animArray("gasA_start");
    deathSeq[1] = animArray("gasA_loop");
    deathSeq[2] = animArray("gasA_end");
  } else if(animArrayExist("gasB_start") && deathAnim == animArray("gasB_start")) {
    deathSeq[0] = animArray("gasB_start");
    deathSeq[1] = animArray("gasB_loop");
    deathSeq[2] = animArray("gasB_end");
  } else if(animArrayExist("left_leg_start") && deathAnim == animArray("left_leg_start")) {
    deathSeq[0] = animArray("left_leg_start");
    deathSeq[1] = animArray("left_leg_loop");
    deathSeq[2] = animArray("left_leg_end");
  } else if(animArrayExist("right_leg_start") && deathAnim == animArray("right_leg_start")) {
    deathSeq[0] = animArray("right_leg_start");
    deathSeq[1] = animArray("right_leg_loop");
    deathSeq[2] = animArray("right_leg_end");
  } else if(animArrayExist("torso_start") && deathAnim == animArray("torso_start")) {
    deathSeq[0] = animArray("torso_start");
    deathSeq[1] = animArray("torso_loop");
    deathSeq[2] = animArray("torso_end");
  }
  if(deathSeq.size == 3) {
    return deathSeq;
  }
  return undefined;
}

play_death_anim(deathAnim) {
  deathSeq = get_extended_death_seq(deathAnim);
  if(isDefined(deathSeq)) {
    do_extended_death(deathSeq);
    self maps\_dds::dds_notify_casualty();
    return;
  }
  self thread death_anim_short_circuit();
  if(!animHasNoteTrack(deathAnim, "dropgun") && !animHasNoteTrack(deathAnim, "fire_spray")) {
    self animscripts\shared::DropAllAIWeapons();
  }
  if(animHasNoteTrack(deathAnim, "death_neckgrab_spurt") && is_mature()) {
    playFXOnTag(anim._effect["death_neckgrab_spurt"], self, "j_neck");
  }
  if(is_true(self.skipDeathAnim)) {
    self thread do_gib();
    self launch_ragdoll_based_on_damage_type();
    wait 0.5;
    return;
  } else {
    if(isDefined(self.animTranslationScale) && self.animTranslationScale > 0) {
      self setFlaggedAnimKnobAllRestart("deathanim", deathAnim, %body, 1, .1, 1.0 / self.animTranslationScale);
    } else {
      self setFlaggedAnimKnobAllRestart("deathanim", deathAnim, %body, 1, .1);
    }
  }
  self thread do_gib();
  if(!animHasNotetrack(deathanim, "start_ragdoll")) {
    self thread waitForRagdoll(getanimlength(deathanim) * 0.35);
  }
  self animscripts\shared::DoNoteTracks("deathanim");
  self animscripts\shared::DropAllAIWeapons();
  self maps\_dds::dds_notify_casualty();
}

special_death() {
  if(self.a.special == "none") {
    return false;
  }
  switch (self.a.special) {
    case "cover_right":
      if(self.a.pose == "stand") {
        deathArray = animArray("cover_right_front");
        DoDeathFromArray(deathArray);
      } else {
        assert(self.a.pose == "crouch");
        return false;
      }
      return true;
    case "cover_left":
      if(self.a.pose == "stand") {
        deathArray = animArray("cover_left_front");
        DoDeathFromArray(deathArray);
      } else {
        assert(self.a.pose == "crouch");
        return false;
      }
      return true;
    case "cover_stand":
      if(self.a.pose == "stand") {
        deathArray = animArray("cover_stand_front");
      } else {
        assert(self.a.pose == "crouch");
        deathArray = array(animArray("cover_crouch_front_1"), animArray("cover_crouch_front_2"));
      }
      DoDeathFromArray(deathArray);
      return true;
    case "cover_crouch":
      deathArray = [];
      if(damageLocationIsAny("head", "neck") && (self.damageyaw > 135 || self.damageyaw <= -45)) {
        deathArray[deathArray.size] = animArray("cover_crouch_front_1");
      }
      if((self.damageyaw > -45) && (self.damageyaw <= 45)) {
        deathArray[deathArray.size] = animArray("cover_crouch_back");
      }
      deathArray[deathArray.size] = animArray("cover_crouch_front_2");
      DoDeathFromArray(deathArray);
      return true;
    case "cover_pillar":
      deathArray = [];
      if((self.damageyaw > -135) && (self.damageyaw <= -45)) {
        deathArray[deathArray.size] = animArrayPickRandom("cover_pillar_left");
      }
      if((self.damageyaw < 135) && (self.damageyaw > 45)) {
        deathArray[deathArray.size] = animArrayPickRandom("cover_pillar_right");
      } else {
        deathArray[deathArray.size] = animArrayPickRandom("cover_pillar_front");
      }
      DoDeathFromArray(deathArray);
      return true;
    case "saw":
      DoDeathFromArray(array(animArray("front")));
      return true;
    case "dying_crawl":
      assertex(self.a.pose == "prone" || self.a.pose == "back", self.a.pose);
      deathArray = animArray("crawl");
      DoDeathFromArray(deathArray);
      return true;
    case "bleeder_death":
      if(self.a.pose == "back") {
        deathArray = animArray("crawl");
        DoDeathFromArray(deathArray);
        return true;
      }
      return false;
  }
  return false;
}

DoDeathFromArray(deathArray) {
  deathAnim = deathArray[randomInt(deathArray.size)];
  play_death_anim(deathAnim);
}

helmetPop() {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.hatModel) || !ModelHasPhysPreset(self.hatModel)) {
    return;
  }
  partName = GetPartName(self.hatModel, 0);
  origin = self GetTagOrigin(partName);
  angles = self GetTagAngles(partName);
  helmetLaunch(self.hatModel, origin, angles, self.damageDir);
  hatModel = self.hatModel;
  self.hatModel = undefined;
  self.helmetPopper = self.attacker;
  wait 0.05;
  if(!isDefined(self)) {
    return;
  }
  self detach(hatModel, "");
}

helmetLaunch(model, origin, angles, damageDir) {
  launchForce = damageDir;
  launchForce = launchForce * RandomFloatRange(1100, 4000);
  forcex = launchForce[0];
  forcey = launchForce[1];
  forcez = RandomFloatRange(800, 3000);
  contactPoint = self.origin + (RandomFloatRange(-1, 1), RandomFloatRange(-1, 1), RandomFloatRange(-1, 1)) * 5;
  CreateDynEntAndLaunch(model, origin, angles, contactPoint, (forcex, forcey, forcez));
}

removeSelfFrom_SquadLastSeenEnemyPos(org) {
  for(i = 0; i < anim.squadIndex.size; i++) {
    anim.squadIndex[i] clearSightPosNear(org);
  }
}

clearSightPosNear(org) {
  if(!isDefined(self.sightPos)) {
    return;
  }
  if(distance(org, self.sightPos) < 80) {
    self.sightPos = undefined;
    self.sightTime = GetTime();
  }
}

shouldDoRunningForwardDeath() {
  if(self.a.movement != "run") {
    return false;
  }
  if(self getMotionAngle() > 60 || self getMotionAngle() < -60) {
    return false;
  }
  if((self.damageyaw >= 135) || (self.damageyaw <= -135)) {
    return true;
  }
  if((self.damageyaw >= -45) && (self.damageyaw <= 45)) {
    return true;
  }
  return false;
}

get_death_anim() {
  if(self.a.pose == "stand") {
    if(shouldDoRunningForwardDeath()) {
      return getRunningForwardDeathAnim();
    }
    return getStandDeathAnim();
  } else if(self.a.pose == "crouch") {
    return getCrouchDeathAnim();
  } else if(self.a.pose == "prone") {
    return getProneDeathAnim();
  } else {
    assert(self.a.pose == "back");
    return getBackDeathAnim();
  }
}

getRunningForwardDeathAnim() {
  deathArray = [];
  if(WeaponClass(self.damageWeapon) == "spread") {
    deathArray = getStandPowerDeathAnimArray();
  } else if(animscripts\combat_utility::isCrossbow(self.damageWeapon)) {
    deathArray = getRunCrossbowDeathAnimArray();
  } else {
    deathArray[deathArray.size] = animArray("run_back_1", "death");
    deathArray[deathArray.size] = animArray("run_back_2", "death");
    if((self.damageyaw >= 135) || (self.damageyaw <= -135)) {
      deathArray[deathArray.size] = animArray("run_front_1", "death");
      deathArray[deathArray.size] = animArray("run_front_2", "death");
    } else if((self.damageyaw >= -45) && (self.damageyaw <= 45)) {
      deathArray[deathArray.size] = animArray("run_back_1", "death");
      deathArray[deathArray.size] = animArray("run_back_2", "death");
    }
  }
  deathArray = array_removeUndefined(deathArray);
  deathArray = call_overloaded_func("animscripts\pain", "removeBlockedAnims", deathArray);
  if(!deathArray.size) {
    return getStandDeathAnim();
  }
  return deathArray[randomInt(deathArray.size)];
}

getStandDeathAnim() {
  deathArray = [];
  if(weaponAnims() == "pistol") {
    deathArray = getStandPistolDeathAnimArray();
  } else if(self usingGasWeapon()) {
    deathArray[deathArray.size] = animArray("front", "death");
  } else if(self usingRocketLauncher() && RandomFloat(1) > 0.65) {
    deathArray = getStandRPGDeathAnimArray();
  } else if(WeaponClass(self.damageWeapon) == "spread") {
    deathArray = getStandPowerDeathAnimArray();
  } else if(animscripts\combat_utility::isSniperRifle(self.damageWeapon)) {
    deathArray = getStandSniperDeathAnimArray();
  } else if(animscripts\combat_utility::isCrossbow(self.damageWeapon)) {
    deathArray = getStandCrossbowDeathAnimArray();
  } else {
    if(damageLocationIsAny("torso_lower", "left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower")) {
      deathArray[deathArray.size] = animArray("groin", "death");
      deathArray[deathArray.size] = animArray("gutshot", "death");
      deathArray[deathArray.size] = animArray("crotch", "death");
      deathArray[deathArray.size] = animArray("guts", "death");
      deathArray[deathArray.size] = animArray("leg", "death");
    } else if(damageLocationIsAny("torso_upper", "torso_lower")) {
      deathArray[deathArray.size] = animArray("torso_start", "death");
      deathArray[deathArray.size] = animArray("deadfallknee", "death");
      deathArray[deathArray.size] = animArray("forwardtoface", "death");
      if(damageLocationIsAny("torso_upper")) {
        deathArray[deathArray.size] = animArray("nerve", "death");
        deathArray[deathArray.size] = animArray("tumbleforward", "death");
        deathArray[deathArray.size] = animArray("fallside", "death");
      }
    } else if(damageLocationIsAny("head", "helmet")) {
      deathArray[deathArray.size] = animArray("head_1", "death");
      deathArray[deathArray.size] = animArray("head_2", "death");
      deathArray[deathArray.size] = animArray("collapse", "death");
    } else if(damageLocationIsAny("neck")) {
      deathArray[deathArray.size] = animArray("neckgrab", "death");
      deathArray[deathArray.size] = animArray("neckgrab2", "death");
    }
    if(longDeathAllowed()) {
      if(damageLocationIsAny("left_leg_upper", "left_leg_lower", "left_foot")) {
        deathArray[deathArray.size] = animArray("left_leg_start", "death");
      } else if(damageLocationIsAny("right_leg_upper", "right_leg_lower", "right_foot")) {
        deathArray[deathArray.size] = animArray("right_leg_start", "death");
      }
    }
    if((self.damageyaw > 135) || (self.damageyaw <= -135)) {
      if(damageLocationIsAny("torso_upper", "left_arm_upper", "right_arm_upper")) {
        if(firingDeathAllowed() && randomInt(100) < 35) {
          deathArray[deathArray.size] = animArray("firing_1", "death");
          deathArray[deathArray.size] = animArray("firing_2", "death");
        }
      }
      if(damageLocationIsAny("neck", "head", "helmet")) {
        deathArray[deathArray.size] = animArray("face", "death");
        deathArray[deathArray.size] = animArray("headshot_slowfall", "death");
        deathArray[deathArray.size] = animArray("head_straight_back", "death");
      } else if(damageLocationIsAny("torso_upper")) {
        deathArray[deathArray.size] = animArray("tumbleback", "death");
        deathArray[deathArray.size] = animArray("chest_stunned", "death");
        deathArray[deathArray.size] = animArray("fall_to_knees_2", "death");
      } else if(damageLocationIsAny("left_arm_upper")) {
        deathArray[deathArray.size] = animArray("shoulder_stumble", "death");
        deathArray[deathArray.size] = animArray("shoulder_spin", "death");
        deathArray[deathArray.size] = animArray("shoulderback", "death");
      }
    } else if((self.damageyaw > 45) && (self.damageyaw <= 135)) {
      if(damageLocationIsAny("torso_upper", "right_arm_upper", "head")) {
        deathArray[deathArray.size] = animArray("fallforward", "death");
      }
      deathArray[deathArray.size] = animArray("fall_to_knees_2", "death");
    } else if((self.damageyaw > -45) && (self.damageyaw <= 45)) {
      if(usingGasWeapon()) {
        deathArray = [];
        deathArray[0] = animArray("back", "death");
      } else {
        deathArray[deathArray.size] = animArray("fall_to_knees_1", "death");
        deathArray[deathArray.size] = animArray("fall_to_knees_2", "death");
        deathArray[deathArray.size] = animArray("stumblefall", "death");
      }
    } else {
      if(damageLocationIsAny("torso_upper", "left_arm_upper", "head")) {
        deathArray[deathArray.size] = animArray("twist", "death");
        deathArray[deathArray.size] = animArray("fallforward_b", "death");
      }
      deathArray[deathArray.size] = animArray("fall_to_knees_2", "death");
    }
    if(deathArray.size < 2 || randomInt(100) < 15) {
      deathArray[deathArray.size] = animArray("front", "death");
      deathArray[deathArray.size] = animArray("front_2", "death");
    }
    assertex(deathArray.size > 0, deathArray.size);
  }
  deathArray = array_removeUndefined(deathArray);
  if(deathArray.size == 0) {
    deathArray[deathArray.size] = animArray("front", "death");
  }
  return deathArray[randomInt(deathArray.size)];
}

getStandRPGDeathAnimArray() {
  deathArray = [];
  deathArray[deathArray.size] = animArray("front", "death");
  deathArray[deathArray.size] = animArray("stagger", "death");
  return deathArray;
}

getStandPistolDeathAnimArray() {
  deathArray = [];
  if(abs(self.damageYaw) < 50) {
    deathArray[deathArray.size] = animArray("back", "death");
  } else {
    if(abs(self.damageYaw) < 110) {
      deathArray[deathArray.size] = animArray("back", "death");
    }
    if(damageLocationIsAny("torso_lower", "torso_upper", "left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower")) {
      deathArray[deathArray.size] = animArray("groin", "death");
      if(!damageLocationIsAny("torso_upper")) {
        deathArray[deathArray.size] = animArray("groin", "death");
      }
    }
    if(!damageLocationIsAny("head", "neck", "helmet", "left_foot", "right_foot", "left_hand", "right_hand", "gun") && randomInt(2) == 0) {
      deathArray[deathArray.size] = animArray("head", "death");
    }
    if(deathArray.size == 0 || damageLocationIsAny("torso_lower", "torso_upper", "neck", "head", "helmet", "right_arm_upper", "left_arm_upper")) {
      deathArray[deathArray.size] = animArray("front", "death");
    }
  }
  return deathArray;
}

getStandPowerDeathAnimArray() {
  deathArray = [];
  if(damageLocationIsAny("neck")) {
    deathArray[deathArray.size] = animArray("neckgrab", "death");
    deathArray[deathArray.size] = animArray("neckgrab2", "death");
  }
  if((self.damageyaw > 135) || (self.damageyaw <= -135)) {
    if(damageLocationIsAny("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower")) {
      deathArray[deathArray.size] = animArray("faceplant", "death");
    } else {
      deathArray[deathArray.size] = animArray("armslegsforward", "death");
      deathArray[deathArray.size] = animArray("flyback", "death");
      deathArray[deathArray.size] = animArray("flyback_far", "death");
      deathArray[deathArray.size] = animArray("jackiespin_inplace", "death");
      deathArray[deathArray.size] = animArray("heavy_flyback", "death");
      deathArray[deathArray.size] = animArray("chest_blowback", "death");
      deathArray[deathArray.size] = animArray("chest_spin", "death");
    }
  } else if((self.damageyaw > 45) && (self.damageyaw <= 135)) {
    if(damageLocationIsAny("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower")) {
      deathArray[deathArray.size] = animArray("legsout_right", "death");
    } else {
      deathArray[deathArray.size] = animArray("jackiespin_left", "death");
      deathArray[deathArray.size] = animArray("chest_spin", "death");
    }
  } else if((self.damageyaw > -45) && (self.damageyaw <= 45)) {
    if(damageLocationIsAny("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower")) {
      deathArray[deathArray.size] = animArray("gib_no_legs_start", "death");
    } else {
      deathArray[deathArray.size] = animArray("jackiespin_vertical", "death");
      deathArray[deathArray.size] = animArray("faceplant", "death");
    }
  } else {
    if(damageLocationIsAny("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower")) {
      deathArray[deathArray.size] = animArray("legsout_left", "death");
    } else {
      deathArray[deathArray.size] = animArray("jackiespin_right", "death");
    }
  }
  assertex(deathArray.size > 0, deathArray.size);
  return deathArray;
}

getStandSniperDeathAnimArray() {
  deathArray = [];
  if((self.damageyaw > 135) || (self.damageyaw <= -135)) {
    if(damageLocationIsAny("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower")) {
      deathArray[deathArray.size] = animArray("faceplant", "death");
    } else if(damageLocationIsAny("torso_upper", "neck", "head", "helmet")) {
      deathArray[deathArray.size] = animArray("upontoback", "death");
    } else {
      deathArray[deathArray.size] = animArray("flatonback", "death");
    }
  } else if((self.damageyaw > 45) && (self.damageyaw <= 135)) {
    if(damageLocationIsAny("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower")) {
      deathArray[deathArray.size] = animArray("legsout_right", "death");
    } else {
      deathArray[deathArray.size] = animArray("legsout_left", "death");
    }
  } else if((self.damageyaw > -45) && (self.damageyaw <= 45)) {
    if(damageLocationIsAny("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower")) {
      deathArray[deathArray.size] = animArray("gib_no_legs_start", "death");
    } else {
      deathArray[deathArray.size] = animArray("faceplant", "death");
    }
  } else {
    if(damageLocationIsAny("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower")) {
      deathArray[deathArray.size] = animArray("legsout_left", "death");
    } else {
      deathArray[deathArray.size] = animArray("legsout_right", "death");
    }
  }
  assertex(deathArray.size > 0, deathArray.size);
  return deathArray;
}

getStandCrossbowDeathAnimArray() {
  deathArray = [];
  if(damageLocationIsAny("left_leg_upper", "left_leg_lower", "left_foot")) {
    deathArray[deathArray.size] = animArray("crossbow_l_leg", "death");
    deathArray[deathArray.size] = animArray("left_leg_start", "death");
  } else if(damageLocationIsAny("right_leg_upper", "right_leg_lower", "right_foot")) {
    deathArray[deathArray.size] = animArray("crossbow_r_leg", "death");
    deathArray[deathArray.size] = animArray("right_leg_start", "death");
  } else if(damageLocationIsAny("left_arm_upper", "left_arm_lower", "left_hand")) {
    deathArray[deathArray.size] = animArray("crossbow_l_arm", "death");
  } else if(damageLocationIsAny("right_arm_upper", "right_arm_lower", "right_arm")) {
    deathArray[deathArray.size] = animArray("crossbow_r_arm", "death");
  } else if(damageLocationIsAny("neck")) {
    deathArray[deathArray.size] = animArray("neckgrab", "death");
    deathArray[deathArray.size] = animArray("neckgrab2", "death");
  } else if(damageLocationIsAny("head", "helmet")) {
    deathArray[deathArray.size] = animArray("head_1", "death");
    deathArray[deathArray.size] = animArray("head_2", "death");
    deathArray[deathArray.size] = animArray("collapse", "death");
  } else if((self.damageyaw > 135) || (self.damageyaw <= -135)) {
    deathArray[deathArray.size] = animArray("crossbow_front", "death");
    deathArray[deathArray.size] = animArray("front", "death");
    deathArray[deathArray.size] = animArray("front_2", "death");
  } else if((self.damageyaw > -45) && (self.damageyaw <= 45)) {
    deathArray[deathArray.size] = animArray("crossbow_back", "death");
    deathArray[deathArray.size] = animArray("fall_to_knees_1", "death");
    deathArray[deathArray.size] = animArray("fall_to_knees_2", "death");
    deathArray[deathArray.size] = animArray("stumblefall", "death");
  } else {
    deathArray[deathArray.size] = animArray("front", "death");
    deathArray[deathArray.size] = animArray("front_2", "death");
  }
  assertex(deathArray.size > 0, deathArray.size);
  return deathArray;
}

getRunCrossbowDeathAnimArray() {
  deathArray = [];
  if(damageLocationIsAny("left_leg_upper", "left_leg_lower", "left_foot")) {
    deathArray[deathArray.size] = animArray("crossbow_run_l_leg", "death");
  } else if(damageLocationIsAny("right_leg_upper", "right_leg_lower", "right_foot")) {
    deathArray[deathArray.size] = animArray("crossbow_run_r_leg", "death");
  } else if(damageLocationIsAny("left_arm_upper", "left_arm_lower", "left_hand")) {
    deathArray[deathArray.size] = animArray("crossbow_run_l_arm", "death");
  } else if(damageLocationIsAny("right_arm_upper", "right_arm_lower", "right_arm")) {
    deathArray[deathArray.size] = animArray("crossbow_run_r_arm", "death");
  } else if((self.damageyaw > -45) && (self.damageyaw <= 45)) {
    deathArray[deathArray.size] = animArray("crossbow_run_back", "death");
  } else if((self.damageyaw > 135) || (self.damageyaw <= -135)) {
    if(damageLocationIsAny("head", "helmet", "neck")) {
      deathArray[deathArray.size] = animArray("run_front_2", "death");
    } else {
      deathArray[deathArray.size] = animArray("crossbow_run_front", "death");
    }
  } else {
    deathArray[deathArray.size] = animArray("crossbow_run_front", "death");
  }
  deathArray = array_removeUndefined(deathArray);
  deathArray = call_overloaded_func("animscripts\pain", "removeBlockedAnims", deathArray);
  if(!deathArray.size) {
    deathArray[deathArray.size] = getStandDeathAnim();
  }
  return deathArray;
}

getCrouchDeathAnim() {
  deathArray = [];
  if(self usingGasWeapon()) {
    deathArray[deathArray.size] = animArray("front", "death");
  } else {
    if(damageLocationIsAny("head", "neck")) {
      deathArray[deathArray.size] = animArray("front", "death");
    }
    if(damageLocationIsAny("torso_upper", "torso_lower", "left_arm_upper", "right_arm_upper", "neck")) {
      deathArray[deathArray.size] = animArray("front_3", "death");
    }
    if(deathArray.size < 2) {
      deathArray[deathArray.size] = animArray("front_2", "death");
    }
    if(deathArray.size < 2) {
      deathArray[deathArray.size] = animArray("front_3", "death");
    }
  }
  deathArray = array_removeUndefined(deathArray);
  assertex(deathArray.size > 0, deathArray.size);
  return deathArray[randomInt(deathArray.size)];
}

getProneDeathAnim() {
  return animArray("front", "death");
}

getBackDeathAnim() {
  return animArrayPickRandom("front", "death");
}

tryAddDeathAnim(animName) {
  assert(!animHasNoteTrack(animName, "fire") && !animHasNoteTrack(animName, "fire_spray"));
  return animName;
}

tryAddFiringDeathAnim(animName) {
  assert(animHasNoteTrack(animName, "fire") || animHasNoteTrack(animName, "fire_spray"));
  return animName;
}

firingDeathAllowed() {
  if(!isDefined(self.weapon) || !self animscripts\weaponList::usingAutomaticWeapon())
    return false;
  if(self.a.weaponPos["right"] == "none")
    return false;
  if(is_true(self.dieQuietly))
    return false;
  if(is_false(self.dofiringdeath))
    return false;
  return true;
}

longDeathAllowed() {
  if(is_true(level.disableLongDeaths))
    return false;
  if(is_true(self.a.disableLongDeath))
    return false;
  return true;
}

play_explosion_death() {
  if(self.damageLocation != "none") {
    return false;
  }
  if(self.a.pose == "prone") {
    return false;
  }
  wantUpwardsDeath = false;
  deathArray = [];
  if(self.a.movement != "run") {
    if(self.mayDoUpwardsDeath && GetTime() > anim.lastUpwardsDeathTime + 6000) {
      deathArray[deathArray.size] = tryAddDeathAnim(animArray("explode_up_1"));
      deathArray[deathArray.size] = tryAddDeathAnim(animArray("explode_up_2"));
      wantUpwardsDeath = true;
      get_gib_ref("up");
    } else {
      if((self.damageyaw > 135) || (self.damageyaw <= -135)) {
        deathArray[deathArray.size] = tryAddDeathAnim(animArray("explode_front_1"));
        deathArray[deathArray.size] = tryAddDeathAnim(animArray("explode_front_2"));
        deathArray[deathArray.size] = tryAddDeathAnim(animArray("explode_front_3"));
        deathArray[deathArray.size] = tryAddDeathAnim(animArray("explode_front_4"));
        get_gib_ref("back");
      } else if((self.damageyaw > 45) && (self.damageyaw <= 135)) {
        deathArray[deathArray.size] = tryAddDeathAnim(animArray("explode_right_1"));
        deathArray[deathArray.size] = tryAddDeathAnim(animArray("explode_right_2"));
        deathArray[deathArray.size] = tryAddDeathAnim(animArray("explode_right_3"));
        get_gib_ref("left");
      } else if((self.damageyaw > -45) && (self.damageyaw <= 45)) {
        deathArray[deathArray.size] = tryAddDeathAnim(animArray("explode_back_1"));
        deathArray[deathArray.size] = tryAddDeathAnim(animArray("explode_back_2"));
        deathArray[deathArray.size] = tryAddDeathAnim(animArray("explode_back_3"));
        deathArray[deathArray.size] = tryAddDeathAnim(animArray("explode_back_4"));
        get_gib_ref("forward");
      } else {
        deathArray[deathArray.size] = tryAddDeathAnim(animArray("explode_left_1"));
        deathArray[deathArray.size] = tryAddDeathAnim(animArray("explode_left_2"));
        get_gib_ref("right");
      }
    }
  } else {
    if(self.mayDoUpwardsDeath && GetTime() > anim.lastUpwardsDeathTime + 2000) {
      deathArray[deathArray.size] = tryAddDeathAnim(animArray("explode_up_1"));
      deathArray[deathArray.size] = tryAddDeathAnim(animArray("explode_up_2"));
      wantUpwardsDeath = true;
      get_gib_ref("up");
    } else {
      if((self.damageyaw > 135) || (self.damageyaw <= -135)) {
        deathArray[deathArray.size] = tryAddDeathAnim(animArray("explode_run_front_1"));
        deathArray[deathArray.size] = tryAddDeathAnim(animArray("explode_run_front_2"));
        get_gib_ref("back");
      } else if((self.damageyaw > 45) && (self.damageyaw <= 135)) {
        deathArray[deathArray.size] = tryAddDeathAnim(animArray("explode_run_right_1"));
        deathArray[deathArray.size] = tryAddDeathAnim(animArray("explode_run_right_2"));
        get_gib_ref("left");
      } else if((self.damageyaw > -45) && (self.damageyaw <= 45)) {
        deathArray[deathArray.size] = tryAddDeathAnim(animArray("explode_run_back_1"));
        deathArray[deathArray.size] = tryAddDeathAnim(animArray("explode_run_back_2"));
        deathArray[deathArray.size] = tryAddDeathAnim(animArray("explode_run_back_3"));
        deathArray[deathArray.size] = tryAddDeathAnim(animArray("explode_run_back_4"));
        get_gib_ref("forward");
      } else {
        deathArray[deathArray.size] = tryAddDeathAnim(animArray("explode_run_left_1"));
        deathArray[deathArray.size] = tryAddDeathAnim(animArray("explode_run_left_2"));
        get_gib_ref("right");
      }
    }
  }
  gib_chance = 50;
  deathAnim = deathArray[randomInt(deathArray.size)];
  if(getDvar(#"scr_expDeathMayMoveCheck") == "on") {
    localDeltaVector = getMoveDelta(deathAnim, 0, 1);
    endPoint = self localToWorldCoords(localDeltaVector);
    if(!self mayMoveToPoint(endPoint, false)) {
      if(try_gib_extended_death(gib_chance)) {
        return true;
      }
      return false;
    }
  }
  self AnimMode("nogravity");
  if(try_gib_extended_death(gib_chance)) {
    return true;
  }
  if(wantUpwardsDeath) {
    anim.lastUpwardsDeathTime = GetTime();
  }
  play_death_anim(deathAnim);
  return true;
}

play_flame_death_anim() {
  if(self.damagemod == "MOD_MELEE") {
    return false;
  }
  if(!is_mature()) {
    return false;
  }
  if(is_gib_restricted_build()) {
    return false;
  }
  if(self.team == "axis") {
    level.bcOnFireTime = GetTime();
    level.bcOnFireOrg = self.origin;
  }
  if(!isDefined(self.a.forceflamedeath) || !self.a.forceflamedeath) {
    if(self.damagemod != "MOD_BURNED") {
      return false;
    }
  }
  deathArray = [];
  if(self usingGasWeapon()) {
    if(self.a.pose == "crouch") {
      deathArray[0] = animArray("flame_front_1");
      deathArray[1] = animArray("flame_front_2");
      deathArray[2] = animArray("flame_front_3");
      deathArray[3] = animArray("flame_front_4");
      deathArray[4] = animArray("flame_front_5");
      deathArray[5] = animArray("flame_front_6");
      deathArray[6] = animArray("flame_front_7");
      deathArray[7] = animArray("flame_front_8");
    } else {
      deathArray[0] = animArray("flame_front_2");
    }
  } else {
    if(self.a.pose == "prone") {
      deathArray[0] = get_death_anim();
    } else if(self.a.pose == "back") {
      deathArray[0] = get_death_anim();
    } else if(self.a.pose == "crouch") {
      deathArray[0] = animArray("flame_front_1");
      deathArray[1] = animArray("flame_front_2");
      deathArray[2] = animArray("flame_front_3");
      deathArray[3] = animArray("flame_front_4");
      deathArray[4] = animArray("flame_front_5");
      deathArray[5] = animArray("flame_front_6");
      deathArray[6] = animArray("flame_front_7");
      deathArray[7] = animArray("flame_front_8");
    } else {
      deathArray[0] = animArray("flame_front_1");
      deathArray[1] = animArray("flame_front_2");
      deathArray[2] = animArray("flame_front_3");
      deathArray[3] = animArray("flame_front_4");
      deathArray[4] = animArray("flame_front_5");
      deathArray[5] = animArray("flame_front_6");
      deathArray[6] = animArray("flame_front_7");
      deathArray[7] = animArray("flame_front_8");
      deathArray[8] = animArray("flameA_start");
      deathArray[9] = animArray("flameB_start");
    }
  }
  self.fire_footsteps = true;
  if(deathArray.size == 0) {
    return false;
  }
  deathArray = call_overloaded_func("animscripts\pain", "removeBlockedAnims", deathArray);
  if(deathArray.size == 0) {
    return false;
  }
  randomChoice = randomInt(deathArray.size);
  self thread flame_death_fx();
  deathAnim = deathArray[randomChoice];
  play_death_anim(deathAnim);
  return true;
}

flame_death_fx() {
  self endon("death");
  if(is_true(self.is_on_fire)) {
    return;
  }
  self.is_on_fire = true;
  self thread on_fire_timeout();
  if(getDvar(#"zombiemode") != "1") {
    if(isDefined(level.ACTOR_CHARRING)) {
      self SetClientFlag(level.ACTOR_CHARRING);
    }
    self StartTanning();
  }
  if(self.team == "axis") {
    level.bcOnFireTime = GetTime();
    level.bcOnFireOrg = self.origin;
  }
  if(isDefined(level._effect) && isDefined(level._effect["character_fire_death_torso"])) {
    playFXOnTag(level._effect["character_fire_death_torso"], self, "J_SpineLower");
  } else {}
  if(isDefined(level._effect) && isDefined(level._effect["character_fire_death_sm"])) {
    wait 1;
    tagArray = [];
    tagArray[0] = "J_Elbow_LE";
    tagArray[1] = "J_Elbow_RI";
    tagArray[2] = "J_Knee_RI";
    tagArray[3] = "J_Knee_LE";
    tagArray = randomize_array(tagArray);
    playFXOnTag(level._effect["character_fire_death_sm"], self, tagArray[0]);
    wait 1;
    tagArray[0] = "J_Wrist_RI";
    tagArray[1] = "J_Wrist_LE";
    if(!isDefined(self.a.gib_ref) || self.a.gib_ref != "no_legs") {
      tagArray[2] = "J_Ankle_RI";
      tagArray[3] = "J_Ankle_LE";
    }
    tagArray = randomize_array(tagArray);
    playFXOnTag(level._effect["character_fire_death_sm"], self, tagArray[0]);
    playFXOnTag(level._effect["character_fire_death_sm"], self, tagArray[1]);
  } else {}
}

on_fire_timeout() {
  self endon("death");
  wait 12;
  if(isDefined(self) && IsAlive(self)) {
    self.is_on_fire = false;
    self notify("stop_flame_damage");
  }
}

play_gas_death_anim() {
  if(!is_mature()) {
    return false;
  }
  if(is_gib_restricted_build()) {
    return false;
  }
  if(!isDefined(self.a.forcegasdeath) || !self.a.forcegasdeath) {
    if(self.damagemod != "MOD_GAS") {
      return false;
    }
  }
  deathArray = [];
  if(self.a.pose == "stand") {
    deathArray[0] = animArray("gas_front_1");
    deathArray[1] = animArray("gas_front_2");
    deathArray[2] = animArray("gas_front_3");
    deathArray[3] = animArray("gas_front_4");
    deathArray[4] = animArray("gas_front_5");
    deathArray[5] = animArray("gas_front_6");
    deathArray[6] = animArray("gas_front_7");
    deathArray[7] = animArray("gas_front_8");
    deathArray[8] = animArray("gasA_start");
    deathArray[9] = animArray("gasB_start");
  } else {
    deathArray[0] = get_death_anim();
  }
  if(deathArray.size == 0) {
    return false;
  }
  deathArray = call_overloaded_func("animscripts\pain", "removeBlockedAnims", deathArray);
  if(deathArray.size == 0) {
    return false;
  }
  randomChoice = randomInt(deathArray.size);
  deathAnim = deathArray[randomChoice];
  play_death_anim(deathAnim);
  return true;
}

play_bulletgibbed_death_anim() {
  maxDist = 300;
  if(self.damagemod == "MOD_MELEE") {
    return false;
  }
  if(isDefined(self.no_gib) && (self.no_gib == 1)) {
    return false;
  }
  gib_chance = 75;
  shotty_gib = false;
  force_gib = isDefined(self.force_gib) && self.force_gib;
  if(WeaponClass(self.damageWeapon) == "spread") {
    maxDist = 300;
    shotty_gib = true;
    distSquared = distanceSquared(self.origin, self.attacker.origin);
    if(distSquared < 110 * 110) {
      gib_chance = 100;
    } else if(distSquared < 200 * 200) {
      gib_chance = 75;
    } else if(distSquared < 270 * 270) {
      gib_chance = 50;
    } else if(distSquared < 330 * 330) {
      if(randomInt(100) < 50) {
        gib_chance = 50;
      } else {
        return false;
      }
    } else {
      return false;
    }
  } else if(isDefined(self.damageWeapon) && self.damageWeapon != "none" && IsSubStr(self.damageWeapon, "dragunov")) {
    maxDist = WeaponMaxGibDistance(self.damageWeapon);
    gib_chance = 30;
  } else if(isDefined(self.damageWeapon) && self.damageWeapon != "none" && WeaponDoGibbing(self.damageWeapon)) {
    maxDist = WeaponMaxGibDistance(self.damageWeapon);
    gib_chance = 101;
  } else if(!force_gib) {
    return false;
  }
  if(force_gib) {
    maxDist = 6000;
    gib_chance = 101;
  }
  if(!isDefined(self.attacker) || !isDefined(self.damageLocation)) {
    return false;
  }
  if(self.damagetaken < 50 && !shotty_gib && !force_gib) {
    return false;
  }
  self.a.gib_ref = undefined;
  distSquared = distanceSquared(self.origin, self.attacker.origin);
  if(randomInt(100) < gib_chance && distSquared < maxDist * maxDist && (force_gib || GetTime() > anim.lastGibTime + anim.gibDelay)) {
    anim.lastGibTime = GetTime();
    refs = [];
    switch (self.damageLocation) {
      case "torso_upper":
      case "torso_lower":
        refs[refs.size] = "right_arm";
        refs[refs.size] = "left_arm";
        break;
      case "right_arm_upper":
      case "right_arm_lower":
      case "right_hand":
        refs[refs.size] = "right_arm";
        break;
      case "left_arm_upper":
      case "left_arm_lower":
      case "left_hand":
        refs[refs.size] = "left_arm";
        break;
      case "right_leg_upper":
      case "right_leg_lower":
      case "right_foot":
        refs[refs.size] = "right_leg";
        refs[refs.size] = "no_legs";
        break;
      case "left_leg_upper":
      case "left_leg_lower":
      case "left_foot":
        refs[refs.size] = "left_leg";
        refs[refs.size] = "no_legs";
        break;
      case "helmet":
      case "head":
        refs[refs.size] = "head";
        break;
    }
    if(is_true(self.thunder_death)) {
      refs = [];
      refs[refs.size] = "right_arm";
      refs[refs.size] = "left_arm";
      refs[refs.size] = "right_leg";
      refs[refs.size] = "left_leg";
      refs[refs.size] = "no_legs";
      refs[refs.size] = "head";
    }
    if(isDefined(self.custom_gib_refs)) {
      refs = self.custom_gib_refs;
    }
    if(refs.size) {
      self.a.gib_ref = get_random(refs);
    }
  }
  range = 600;
  nrange = -600;
  self.gib_vel = self.damagedir * RandomIntRange(500, 900);
  self.gib_vel += (RandomIntRange(nrange, range), RandomIntRange(nrange, range), RandomIntRange(400, 1000));
  if(try_gib_extended_death(50)) {
    return true;
  }
  deathAnim = get_death_anim();
  play_death_anim(deathAnim);
  return true;
}

isValidGibRef(gib_ref) {
  refs = [];
  refs[refs.size] = "right_arm";
  refs[refs.size] = "left_arm";
  refs[refs.size] = "right_leg";
  refs[refs.size] = "left_leg";
  refs[refs.size] = "no_legs";
  refs[refs.size] = "head";
  if(is_in_array(refs, gib_ref))
    return true;
  return false;
}

try_gib_extended_death(chance) {
  if(randomInt(100) >= chance) {
    return false;
  }
  if(self.a.pose == "prone" || self.a.pose == "back") {
    return false;
  }
  if(is_true(self.noGibDeathAnim)) {
    return false;
  }
  if(!is_true(self.dieQuietly) && self.type == "human") {
    self thread animscripts\face::SaySpecificDialogue(undefined, "chr_spl_generic_gib_" + self.voice, 1.6);
  }
  deathseq = get_gib_extended_death_anims();
  if(deathSeq.size == 3) {
    do_extended_death(deathSeq);
    return true;
  }
  return false;
}

do_extended_death(deathSeq) {
  self animscripts\shared::DropAllAIWeapons();
  self thread do_gib();
  self SetPlayerCollision(false);
  self thread death_anim_short_circuit();
  self setFlaggedAnimKnobAllRestart("deathhitanim", deathSeq[0], %body, 1, .1);
  self animscripts\shared::DoNoteTracks("deathhitanim");
  self notify("stop_death_anim_short_circuit");
  self thread end_extended_death(deathSeq);
  numDeathLoops = randomInt(2) + 1;
  self thread extended_death_loop(deathSeq, numDeathLoops);
  self waittill("extended_death_ended");
}

end_extended_death(deathSeq) {
  assert(isDefined(deathSeq[2]));
  self waittill_any("damage_afterdeath", "ending_extended_death");
  self setFlaggedAnimKnobAllRestart("deathdieanim", deathSeq[2], %body, 1, .1);
  self animscripts\shared::DoNoteTracks("deathdieanim");
  self notify("extended_death_ended");
}

extended_death_loop(deathSeq, numLoops) {
  self endon("damage");
  assert(isDefined(deathSeq[1]));
  animLength = GetAnimLength(deathSeq[1]);
  for(i = 0; i < numLoops; i++) {
    self setFlaggedAnimKnobAllRestart("deathloopanim", deathSeq[1], %body, 1, .1);
    self animscripts\shared::DoNoteTracks("deathloopanim");
  }
  self notify("ending_extended_death");
}

get_gib_extended_death_anims() {
  hitfrom = undefined;
  if((self.damageyaw > 90) || (self.damageyaw <= -90)) {
    hitfrom = "front";
  } else {
    hitfrom = "back";
  }
  gib_ref = self.a.gib_ref;
  deathSeq = [];
  if(isDefined(hitfrom) && isDefined(gib_ref) && gib_ref != "head") {
    hitIndex = 0;
    loopIndex = 1;
    dieIndex = 2;
    if(gib_ref == "guts" || gib_ref == "no_legs") {
      hitfrom = "";
    } else {
      hitfrom = "_" + hitfrom;
    }
    deathSeq[hitIndex] = animArray("gib_" + gib_ref + hitfrom + "_start");
    deathSeq[loopIndex] = animArray("gib_" + gib_ref + hitfrom + "_loop");
    deathSeq[dieIndex] = animArray("gib_" + gib_ref + hitfrom + "_end");
  }
  return deathSeq;
}

randomize_array(array) {
  for(i = 0; i < array.size; i++) {
    j = randomInt(array.size);
    temp = array[i];
    array[i] = array[j];
    array[j] = temp;
  }
  return array;
}

play_bayonet_death_anim() {
  if(self.damagemod != "MOD_BAYONET") {
    return false;
  }
  if(self.a.pose != "stand") {
    return false;
  }
  deathAnim = "";
  side = "front";
  if((self.damageyaw > -45) && (self.damageyaw <= 45)) {
    deathAnim = animArray("bayonet_back");
    side = "back";
  } else if((self.damageyaw > 45) && (self.damageyaw <= 135)) {
    deathAnim = animArray("bayonet_right");
    side = "right";
  } else if((self.damageyaw < -45) && (self.damageyaw >= -135)) {
    deathAnim = animArray("bayonet_left");
    side = "left";
  } else if(damageLocationIsAny("helmet", "head", "neck", "torso_upper")) {
    deathAnim = animArray("bayonet_head");
    side = "front";
  } else {
    deathAnim = animArray("bayonet_front");
    side = "front";
  }
  if(GetDvarInt(#"cg_blood") > 0) {
    self thread bayonet_death_fx(side);
  }
  play_death_anim(deathAnim);
  return true;
}

get_tag_for_damage_location() {
  tag = "J_SpineLower";
  if(self.damagelocation == "helmet") {
    tag = "j_head";
  } else if(self.damagelocation == "head") {
    tag = "j_head";
  } else if(self.damagelocation == "neck") {
    tag = "j_neck";
  } else if(self.damagelocation == "torso_upper") {
    tag = "j_spineupper";
  } else if(self.damagelocation == "torso_lower") {
    tag = "j_spinelower";
  } else if(self.damagelocation == "right_arm_upper") {
    tag = "j_elbow_ri";
  } else if(self.damagelocation == "left_arm_upper") {
    tag = "j_elbow_le";
  } else if(self.damagelocation == "right_arm_lower") {
    tag = "j_wrist_ri";
  } else if(self.damagelocation == "left_arm_lower") {
    tag = "j_wrist_le";
  }
  return tag;
}

bayonet_death_fx(side) {
  tag = self get_tag_for_damage_location();
  if(isDefined(level._effect) && isDefined(level._effect["character_bayonet_blood_in"])) {
    playFXOnTag(level._effect["character_bayonet_blood_in"], self, tag);
  } else {}
  wait 0.2;
  if(isDefined(level._effect)) {
    if(!isDefined(level._effect["character_bayonet_blood_front"]) || !isDefined(level._effect["character_bayonet_blood_back"]) || !isDefined(level._effect["character_bayonet_blood_left"]) || !isDefined(level._effect["character_bayonet_blood_right"])) {
      println("^3ANIMSCRIPT WARNING: You are missing level._effect[\"character_bayonet_blood_out\"], please set it in your levelname_fx.gsc.");
      println("^3\"impacts/fx_flesh_bayonet_fatal_fr\" and ");
      println("^3\"impacts/fx_flesh_bayonet_fatal_bk\" and ");
      println("^3\"impacts/fx_flesh_bayonet_fatal_rt\" and ");
      println("^3\"impacts/fx_flesh_bayonet_fatal_lf\".");
    } else {
      if(side == "front") {
        playFXOnTag(level._effect["character_bayonet_blood_front"], self, "j_spine4");
      } else if(side == "back") {
        playFXOnTag(level._effect["character_bayonet_blood_back"], self, "j_spine4");
      } else if(side == "right") {
        playFXOnTag(level._effect["character_bayonet_blood_right"], self, "j_spine4");
      } else if(side == "left") {
        playFXOnTag(level._effect["character_bayonet_blood_left"], self, "j_spine4");
      }
    }
  } else {}
}

get_gib_ref(direction) {
  if(isDefined(self.a.gib_ref)) {
    return;
  }
  if(self.damageTaken < 165) {
    return;
  }
  if(GetTime() > anim.lastGibTime + anim.gibDelay && anim.totalGibs > 0) {
    anim.totalGibs--;
    anim thread set_last_gib_time();
    refs = [];
    switch (direction) {
      case "right":
        refs[refs.size] = "left_arm";
        refs[refs.size] = "left_leg";
        gib_ref = get_random(refs);
        break;
      case "left":
        refs[refs.size] = "right_arm";
        refs[refs.size] = "right_leg";
        gib_ref = get_random(refs);
        break;
      case "forward":
        refs[refs.size] = "right_arm";
        refs[refs.size] = "left_arm";
        refs[refs.size] = "right_leg";
        refs[refs.size] = "left_leg";
        refs[refs.size] = "no_legs";
        gib_ref = get_random(refs);
        break;
      case "back":
        refs[refs.size] = "right_arm";
        refs[refs.size] = "left_arm";
        refs[refs.size] = "right_leg";
        refs[refs.size] = "left_leg";
        refs[refs.size] = "no_legs";
        gib_ref = get_random(refs);
        break;
      default:
        refs[refs.size] = "right_arm";
        refs[refs.size] = "left_arm";
        refs[refs.size] = "right_leg";
        refs[refs.size] = "left_leg";
        refs[refs.size] = "no_legs";
        gib_ref = get_random(refs);
        break;
    }
    self.a.gib_ref = gib_ref;
  } else {
    self.a.gib_ref = undefined;
  }
}

set_last_gib_time() {
  anim notify("stop_last_gib_time");
  anim endon("stop_last_gib_time");
  wait(0.05);
  anim.lastGibTime = GetTime();
  anim.totalGibs = RandomIntRange(anim.minGibs, anim.maxGibs);
}

get_random(array) {
  return array[randomInt(array.size)];
}

do_gib() {
  if(!is_mature()) {
    return;
  }
  if(is_gib_restricted_build()) {
    return;
  }
  if(!isDefined(self.a.gib_ref)) {
    return;
  }
  if(self is_zombie_gibbed()) {
    return;
  }
  if(isDefined(self.damageWeapon)) {
    if(isSubStr(self.damageWeapon, "flame") || isSubStr(self.damageWeapon, "molotov") || isSubStr(self.damageWeapon, "napalmblob")) {
      return;
    }
  }
  self set_zombie_gibbed();
  if(GetDvarFloat(#"kill_slowmo_time") > 0) {
    self thread goSlowMo();
  }
  gib_ref = self.a.gib_ref;
  limb_data = get_limb_data(gib_ref);
  if(!isDefined(limb_data)) {
    return;
  }
  forward = undefined;
  velocity = undefined;
  pos1 = [];
  pos2 = [];
  velocities = [];
  if(gib_ref == "head") {
    self Detach(self.headModel, "");
    self helmetPop();
    if(isDefined(self.hatModel)) {
      self detach(self.hatModel, "");
      self.hatModel = undefined;
    }
  }
  if(limb_data["spawn_tags"][0] != "") {
    if(isDefined(self.gib_vel)) {
      for(i = 0; i < limb_data["spawn_tags"].size; i++) {
        velocities[i] = self.gib_vel;
      }
    } else {
      for(i = 0; i < limb_data["spawn_tags"].size; i++) {
        pos1[pos1.size] = self GetTagOrigin(limb_data["spawn_tags"][i]);
      }
      wait(0.05);
      for(i = 0; i < limb_data["spawn_tags"].size; i++) {
        pos2[pos2.size] = self GetTagOrigin(limb_data["spawn_tags"][i]);
      }
      for(i = 0; i < pos1.size; i++) {
        forward = VectorNormalize(pos2[i] - pos1[i]);
        velocities[i] = forward * RandomIntRange(600, 1000);
        velocities[i] = velocities[i] + (0, 0, RandomIntRange(400, 700));
      }
    }
  }
  if(isDefined(limb_data["fx"])) {
    for(i = 0; i < limb_data["spawn_tags"].size; i++) {
      if(limb_data["spawn_tags"][i] == "") {
        continue;
      }
      playFXOnTag(anim._effect[limb_data["fx"]], self, limb_data["spawn_tags"][i]);
    }
  }
  PlaySoundAtPosition("chr_death_gibs", self.origin);
  self thread maps\_dds::dds_notify("gib", (self.team != "allies"));
  self thread throw_gib(limb_data["spawn_models"], limb_data["spawn_tags"], velocities);
  self setModel(limb_data["body_model"]);
  self Attach(limb_data["legs_model"]);
}

precache_gib_fx() {
  anim._effect["animscript_gib_fx"] = LoadFx("weapon/bullet/fx_flesh_gib_fatal_01");
  anim._effect["animscript_gibtrail_fx"] = LoadFx("trail/fx_trail_blood_streak");
  anim._effect["death_neckgrab_spurt"] = LoadFx("impacts/fx_flesh_hit_neck_fatal");
}

get_limb_data(gib_ref) {
  temp_array = [];
  torsoDmg1_defined = isDefined(self.torsoDmg1);
  torsoDmg2_defined = isDefined(self.torsoDmg2);
  torsoDmg3_defined = isDefined(self.torsoDmg3);
  torsoDmg4_defined = isDefined(self.torsoDmg4);
  torsoDmg5_defined = isDefined(self.torsoDmg5);
  legDmg1_defined = isDefined(self.legDmg1);
  legDmg2_defined = isDefined(self.legDmg2);
  legDmg3_defined = isDefined(self.legDmg3);
  legDmg4_defined = isDefined(self.legDmg4);
  gibSpawn1_defined = isDefined(self.gibSpawn1);
  gibSpawn2_defined = isDefined(self.gibSpawn2);
  gibSpawn3_defined = isDefined(self.gibSpawn3);
  gibSpawn4_defined = isDefined(self.gibSpawn4);
  gibSpawn5_defined = isDefined(self.gibSpawn5);
  gibSpawnTag1_defined = isDefined(self.gibSpawnTag1);
  gibSpawnTag2_defined = isDefined(self.gibSpawnTag2);
  gibSpawnTag3_defined = isDefined(self.gibSpawnTag3);
  gibSpawnTag4_defined = isDefined(self.gibSpawnTag4);
  gibSpawnTag5_defined = isDefined(self.gibSpawnTag5);
  if(torsoDmg2_defined && legDmg1_defined && gibSpawn1_defined && gibSpawnTag1_defined) {
    temp_array["right_arm"]["body_model"] = self.torsoDmg2;
    temp_array["right_arm"]["legs_model"] = self.legDmg1;
    temp_array["right_arm"]["spawn_models"][0] = self.gibSpawn1;
    temp_array["right_arm"]["spawn_tags"][0] = self.gibSpawnTag1;
    temp_array["right_arm"]["fx"] = "animscript_gib_fx";
  }
  if(torsoDmg3_defined && legDmg1_defined && gibSpawn2_defined && gibSpawnTag2_defined) {
    temp_array["left_arm"]["body_model"] = self.torsoDmg3;
    temp_array["left_arm"]["legs_model"] = self.legDmg1;
    temp_array["left_arm"]["spawn_models"][0] = self.gibSpawn2;
    temp_array["left_arm"]["spawn_tags"][0] = self.gibSpawnTag2;
    temp_array["left_arm"]["fx"] = "animscript_gib_fx";
  }
  if(torsoDmg1_defined && legDmg2_defined && gibSpawn3_defined && gibSpawnTag3_defined) {
    temp_array["right_leg"]["body_model"] = self.torsoDmg1;
    temp_array["right_leg"]["legs_model"] = self.legDmg2;
    temp_array["right_leg"]["spawn_models"][0] = self.gibSpawn3;
    temp_array["right_leg"]["spawn_tags"][0] = self.gibSpawnTag3;
    temp_array["right_leg"]["fx"] = "animscript_gib_fx";
  }
  if(torsoDmg1_defined && legDmg3_defined && gibSpawn4_defined && gibSpawnTag4_defined) {
    temp_array["left_leg"]["body_model"] = self.torsoDmg1;
    temp_array["left_leg"]["legs_model"] = self.legDmg3;
    temp_array["left_leg"]["spawn_models"][0] = self.gibSpawn4;
    temp_array["left_leg"]["spawn_tags"][0] = self.gibSpawnTag4;
    temp_array["left_leg"]["fx"] = "animscript_gib_fx";
  }
  if(torsoDmg1_defined && legDmg4_defined && gibSpawn4_defined && gibSpawn3_defined && gibSpawnTag3_defined && gibSpawnTag4_defined) {
    temp_array["no_legs"]["body_model"] = self.torsoDmg1;
    temp_array["no_legs"]["legs_model"] = self.legDmg4;
    temp_array["no_legs"]["spawn_models"][0] = self.gibSpawn4;
    temp_array["no_legs"]["spawn_models"][1] = self.gibSpawn3;
    temp_array["no_legs"]["spawn_tags"][0] = self.gibSpawnTag4;
    temp_array["no_legs"]["spawn_tags"][1] = self.gibSpawnTag3;
    temp_array["no_legs"]["fx"] = "animscript_gib_fx";
  }
  if(torsoDmg4_defined && legDmg1_defined) {
    temp_array["guts"]["body_model"] = self.torsoDmg4;
    temp_array["guts"]["legs_model"] = self.legDmg1;
    temp_array["guts"]["spawn_models"][0] = "";
    temp_array["guts"]["spawn_tags"][0] = "";
    temp_array["guts"]["fx"] = "animscript_gib_fx";
  }
  if(torsoDmg5_defined && legDmg1_defined) {
    temp_array["head"]["body_model"] = self.torsoDmg5;
    temp_array["head"]["legs_model"] = self.legDmg1;
    if(gibSpawn5_defined && gibSpawnTag5_defined) {
      temp_array["head"]["spawn_models"][0] = self.gibSpawn5;
      temp_array["head"]["spawn_tags"][0] = self.gibSpawnTag5;
    } else {
      temp_array["head"]["spawn_models"][0] = "";
      temp_array["head"]["spawn_tags"][0] = "";
    }
    temp_array["head"]["fx"] = "animscript_gib_fx";
  }
  if(isDefined(temp_array[gib_ref])) {
    return temp_array[gib_ref];
  } else {
    return undefined;
  }
}

throw_gib(spawn_models, spawn_tags, velocities) {
  if(velocities.size < 1) {
    return;
  }
  for(i = 0; i < spawn_models.size; i++) {
    origin = self GetTagOrigin(spawn_tags[i]);
    angles = self GetTagAngles(spawn_tags[i]);
    CreateDynEntAndLaunch(spawn_models[i], origin, angles, origin, velocities[i], anim._effect["animscript_gibtrail_fx"], 1);
  }
}

death_anim_short_circuit() {
  self endon("stop_death_anim_short_circuit");
  wait 0.3;
  totalDamageTaken = 0;
  while(1) {
    self waittill("damage_afterdeath", damagetaken, attacker, dir, point, mod);
    waittillframeend;
    if(isDefined(self.damageMod) && self.damageMod != "MOD_BURNED") {
      totalDamageTaken += self.damageTaken;
      if(totalDamageTaken > 100) {
        self launch_ragdoll_based_on_damage_type();
        break;
      }
    }
  }
}

launch_ragdoll_based_on_damage_type(bullet_scale) {
  if(self call_overloaded_func("animscripts\pain", "wasDamagedByExplosive")) {
    force = 1.6;
  } else if(WeaponClass(self.damageWeapon) == "spread") {
    distSquared = distanceSquared(self.origin, self.attacker.origin);
    maxDistSquared = 300 * 300;
    if(distSquared > maxDistSquared) {
      distSquared = maxDistSquared;
    }
    force = .3;
    force += .7 * (1.0 - (distSquared / (maxDistSquared)));
  } else {
    if(self.damagetaken < 75) {
      force = .35;
    } else {
      force = .45;
    }
    if(isDefined(bullet_scale)) {
      force *= bullet_scale;
    }
  }
  initial_force = self.damagedir + (0, 0, 0.2);
  initial_force *= 60 * force;
  if(damageLocationIsAny("head", "helmet", "neck")) {
    initial_force *= 0.5;
  }
  self startragdoll();
  self launchragdoll(initial_force, self.damageLocation);
}

playCustomDeathAnim() {
  if(!animHasNoteTrack(self.deathanim, "dropgun") && !animHasNoteTrack(self.deathanim, "fire_spray")) {
    self animscripts\shared::DropAllAIWeapons();
  }
  self thread do_gib();
  self SetFlaggedAnimKnobAll("deathanim", self.deathanim, %root, 1, .05, 1);
  if(!animHasNotetrack(self.deathanim, "start_ragdoll")) {
    self thread waitForRagdoll(getanimlength(self.deathanim) * 0.35);
  }
  self animscripts\shared::DoNoteTracks("deathanim");
  if(isDefined(self.deathanimloop)) {
    self SetFlaggedAnimKnobAll("deathanim", self.deathanimloop, %root, 1, .05, 1);
    for(;;) {
      self animscripts\shared::DoNoteTracks("deathanim");
    }
  }
  return;
}

playDeathSound() {
  if(!damageLocationIsAny("head", "helmet")) {
    if(!is_true(self.dieQuietly)) {
      self animscripts\face::SayGenericDialogue("death");
      if(isDefined(self.team)) {
        self maps\_dds::dds_notify_mod((self.team != "allies"));
      }
    }
  } else {
    if(self.damageLocation == "helmet" && isDefined(self.hatModel) && ModelHasPhysPreset(self.hatModel) && issubstr(self.hatmodel, "helm")) {
      self playSound("prj_bullet_impact_headshot_helmet");
    } else {
      self playSound("prj_bullet_impact_headshot");
    }
    if(isDefined(self.team)) {
      self maps\_dds::dds_notify_mod((self.team != "allies"), "headshot");
    }
  }
}