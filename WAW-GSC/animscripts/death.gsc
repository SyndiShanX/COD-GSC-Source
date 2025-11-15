/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\death.gsc
*****************************************************/

#include common_scripts\utility;
#include animscripts\utility;
#using_animtree("generic_human");

main() {
  self trackScriptState("Death Main", "code");
  self endon("killanimscript");
  self stopsounds();
  self flamethrower_stop_shoot();
  if(isDefined(level.missionCallbacks)) {
    maps\_challenges_coop::doMissionCallback("actorKilled", self);
  }
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
  if(isDefined(self.deathtestfunction)) {
    self[[self.deathtestfunction]]();
  }
  changeTime = 0.3;
  self clearanim( % scripted_look_straight, changeTime);
  self clearanim( % scripted_talking, changeTime);
  animscripts\utility::initialize("death");
  self notify("never look at anything again");
  removeSelfFrom_SquadLastSeenEnemyPos(self.origin);
  anim.numDeathsUntilCrawlingPain--;
  anim.numDeathsUntilCornerGrenadeDeath--;
  if(isDefined(self.deathanim)) {
    if(!animHasNoteTrack(self.deathanim, "dropgun") && !animHasNoteTrack(self.deathanim, "fire_spray")) {
      self animscripts\shared::DropAllAIWeapons();
    }
    self thread do_gib();
    self SetFlaggedAnimKnobAll("deathanim", self.deathanim, % root, 1, .05, 1);
    if(!animHasNotetrack(self.deathanim, "start_ragdoll")) {
      self thread waitForRagdoll(getanimlength(self.deathanim) * 0.35);
    }
    if(isDefined(self.is_zombie) && (!isDefined(self.in_the_ground) || !self.in_the_ground)) {
      self thread death_anim_short_circuit();
    }
    self animscripts\shared::DoNoteTracks("deathanim");
    if(isDefined(self.deathanimloop)) {
      self SetFlaggedAnimKnobAll("deathanim", self.deathanimloop, % root, 1, .05, 1);
      for(;;) {
        self animscripts\shared::DoNoteTracks("deathanim");
      }
    }
    if(isDefined(self.deathanimscript)) {
      self[[self.deathanimscript]]();
    }
    return;
  }
  explosiveDamage = self animscripts\pain::wasDamagedByExplosive();
  if(self.damageLocation == "helmet") {
    self helmetPop();
  } else if(explosiveDamage && randomint(2) == 0) {
    self helmetPop();
  }
  self clearanim( % root, 0.3);
  if(!damageLocationIsAny("head", "helmet")) {
    if(!isDefined(self.dieQuietly) || !self.dieQuietly) {
      PlayDeathSound();
    }
  }
  if(damageLocationIsAny("head", "helmet")) {
    if(self.damageLocation == "helmet" && isDefined(self.hatModel) &&
      ModelHasPhysPreset(self.hatModel) &&
      issubstr(self.hatmodel, "helm")) {
      self playSound("bullet_impact_headshot_helmet");
    } else {
      self playSound("bullet_impact_headshot");
    }
  }
  if(maps\_collectibles::has_collectible("collectible_thunder")) {
    if(damageLocationIsAny("head", "helmet")) {
      if(!isDefined(self.attacker) || !IsPlayer(self.attacker)) {} else if(!isDefined(self.team) || self.team != "axis") {} else if(self.damagemod == "MOD_PISTOL_BULLET" || self.damagemod == "MOD_RIFLE_BULLET" || self.damagemod == "MOD_IMPACT") {
        playFXOnTag(level._effect["thunder"], self, "j_head");
        self startragdoll();
        self launchragdoll((0, 0, 100));
        self.thunder_death = true;
        self.gib_override = true;
      }
    }
  }
  if(explosiveDamage && play_explosion_death()) {
    return;
  }
  if(special_death()) {
    return;
  }
  if(play_flame_death_anim()) {
    return;
  }
  if(play_bulletgibbed_death_anim()) {
    return;
  }
  if(play_bayonet_death_anim()) {
    return;
  }
  deathAnim = get_death_anim();
  if(getdvarint("scr_paindebug") == 1) {
    println("^2Playing death: ", deathAnim, " ; pose is ", self.a.pose);
  }
  play_death_anim(deathAnim);
}

waitForRagdoll(time) {
  wait(time);
  do_ragdoll = true;
  if(isDefined(self.nodeathragdoll) && self.nodeathragdoll) {
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
  if(deathAnim == % ai_deadly_wounded_flamedA_hit) {
    deathSeq[0] = % ai_deadly_wounded_flamedA_hit;
    deathSeq[1] = % ai_deadly_wounded_flamedA_loop;
    deathSeq[2] = % ai_deadly_wounded_flamedA_die;
  } else if(deathAnim == % ai_deadly_wounded_flamedB_hit) {
    deathSeq[0] = % ai_deadly_wounded_flamedB_hit;
    deathSeq[1] = % ai_deadly_wounded_flamedB_loop;
    deathSeq[2] = % ai_deadly_wounded_flamedB_die;
  } else if(deathAnim == % ai_deadly_wounded_leg_L_hit) {
    deathSeq[0] = % ai_deadly_wounded_leg_L_hit;
    deathSeq[1] = % ai_deadly_wounded_leg_L_loop;
    deathSeq[2] = % ai_deadly_wounded_leg_L_die;
  } else if(deathAnim == % ai_deadly_wounded_leg_R_hit) {
    deathSeq[0] = % ai_deadly_wounded_leg_R_hit;
    deathSeq[1] = % ai_deadly_wounded_leg_R_loop;
    deathSeq[2] = % ai_deadly_wounded_leg_R_die;
  } else if(deathAnim == % ai_deadly_wounded_torso_hit) {
    deathSeq[0] = % ai_deadly_wounded_torso_hit;
    deathSeq[1] = % ai_deadly_wounded_torso_loop;
    deathSeq[2] = % ai_deadly_wounded_torso_die;
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
    return;
  }
  self thread death_anim_short_circuit();
  if(!animHasNoteTrack(deathAnim, "dropgun") && !animHasNoteTrack(deathAnim, "fire_spray")) {
    self animscripts\shared::DropAllAIWeapons();
  }
  if(animHasNoteTrack(deathAnim, "death_neckgrab_spurt") && is_mature()) {
    playFXOnTag(anim._effect["death_neckgrab_spurt"], self, "j_neck");
  }
  if(isDefined(self.skipDeathAnim) && self.skipDeathAnim) {
    self thread do_gib();
    self launch_ragdoll_based_on_damage_type();
    wait 0.5;
    return;
  } else {
    self setFlaggedAnimKnobAllRestart("deathanim", deathAnim, % body, 1, .1);
  }
  self thread do_gib();
  if(!animHasNotetrack(deathanim, "start_ragdoll")) {
    self thread waitForRagdoll(getanimlength(deathanim) * 0.35);
  }
  if(getdebugdvar("debug_grenadehand") == "on") {
    if(animhasnotetrack(deathAnim, "bodyfall large")) {
      return;
    }
    if(animhasnotetrack(deathAnim, "bodyfall small")) {
      return;
    }
    println("Death animation ", deathAnim, " does not have a bodyfall notetrack");
    iprintlnbold("Death animation needs fixing( check console and report bug in the animation to Boon )");
  }
  self animscripts\shared::DoNoteTracks("deathanim");
  self animscripts\shared::DropAllAIWeapons();
}

testPrediction() {
  self BeginPrediction();
  self animscripts\predict::start();
  self animscripts\predict::_setAnim( % balcony_stumble_forward, 1, .05, 1);
  if(self animscripts\predict::stumbleWall(1)) {
    self animMode("nogravity");
    self animscripts\predict::_setFlaggedAnimKnobAll("deathanim", % balcony_tumble_railing36_forward, % root, 1, 0.05, 1);
    if(self animscripts\predict::tumbleWall("deathanim")) {
      self EndPrediction();
      return true;
    }
  }
  self EndPrediction();
  self BeginPrediction();
  self animscripts\predict::start();
  self animscripts\predict::_setAnim( % balcony_stumble_forward, 1, .05, 1);
  if(self animscripts\predict::stumbleWall(1)) {
    self animMode("nogravity");
    self animscripts\predict::_setFlaggedAnimKnobAll("deathanim", % balcony_tumble_railing44_forward, % root, 1, 0.05, 1);
    if(self animscripts\predict::tumbleWall("deathanim")) {
      self EndPrediction();
      return true;
    }
  }
  self EndPrediction();
  self animscripts\predict::end();
  return false;
}

special_death() {
  if(self.a.special == "none") {
    return false;
  }
  switch (self.a.special) {
    case "cover_right":
      if(self.a.pose == "stand") {
        deathArray = [];
        deathArray[0] = % corner_standr_deathA;
        deathArray[1] = % corner_standr_deathB;
        DoDeathFromArray(deathArray);
      } else {
        assert(self.a.pose == "crouch");
        return false;
      }
      return true;
    case "cover_left":
      if(self.a.pose == "stand") {
        deathArray = [];
        deathArray[0] = % corner_standl_deathA;
        deathArray[1] = % corner_standl_deathB;
        DoDeathFromArray(deathArray);
      } else {
        assert(self.a.pose == "crouch");
        return false;
      }
      return true;
    case "cover_stand":
      deathArray = [];
      deathArray[0] = % coverstand_death_left;
      deathArray[1] = % coverstand_death_right;
      DoDeathFromArray(deathArray);
      return true;
    case "cover_crouch":
      deathArray = [];
      if(damageLocationIsAny("head", "neck") && (self.damageyaw > 135 || self.damageyaw <= -45)) {
        deathArray[deathArray.size] = % covercrouch_death_1;
      }
      if((self.damageyaw > -45) && (self.damageyaw <= 45)) {
        deathArray[deathArray.size] = % covercrouch_death_3;
      }
      deathArray[deathArray.size] = % covercrouch_death_2;
      DoDeathFromArray(deathArray);
      return true;
    case "saw":
      if(self.a.pose == "stand") {
        DoDeathFromArray(array( % saw_gunner_death));
      } else if(self.a.pose == "crouch") {
        DoDeathFromArray(array( % saw_gunner_lowwall_death));
      } else {
        DoDeathFromArray(array( % saw_gunner_prone_death));
      }
      return true;
    case "dying_crawl":
      if(self.a.pose == "back") {
        deathArray = array( % dying_back_death_v2, % dying_back_death_v3, % dying_back_death_v4);
        DoDeathFromArray(deathArray);
      } else {
        assertex(self.a.pose == "prone", self.a.pose);
        deathArray = array( % dying_crawl_death_v1, % dying_crawl_death_v2);
        DoDeathFromArray(deathArray);
      }
      return true;
  }
  return false;
}

DoDeathFromArray(deathArray) {
  deathAnim = deathArray[randomint(deathArray.size)];
  play_death_anim(deathAnim);
  if(isDefined(self.deathanimscript)) {
    self[[self.deathanimscript]]();
  }
}

PlayDeathSound() {
  self animscripts\face::SayGenericDialogue("death");
}

print3dfortime(place, text, time) {
  numframes = time * 20;
  for(i = 0; i < numframes; i++) {
    print3d(place, text);
    wait .05;
  }
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
  launchForce = launchForce * randomFloatRange(1100, 4000);
  forcex = launchForce[0];
  forcey = launchForce[1];
  forcez = randomFloatRange(800, 3000);
  contactPoint = self.origin + (randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-1, 1)) * 5;
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
    self.sightTime = gettime();
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
  deathArray[deathArray.size] = tryAddDeathAnim( % run_death_facedown);
  deathArray[deathArray.size] = tryAddDeathAnim( % run_death_roll);
  if((self.damageyaw >= 135) || (self.damageyaw <= -135)) {
    deathArray[deathArray.size] = tryAddDeathAnim( % run_death_fallonback);
    deathArray[deathArray.size] = tryAddDeathAnim( % run_death_fallonback_02);
  } else if((self.damageyaw >= -45) && (self.damageyaw <= 45)) {
    deathArray[deathArray.size] = tryAddDeathAnim( % run_death_roll);
    deathArray[deathArray.size] = tryAddDeathAnim( % run_death_facedown);
  }
  deathArray = tempClean(deathArray);
  deathArray = animscripts\pain::removeBlockedAnims(deathArray);
  if(!deathArray.size) {
    return getStandDeathAnim();
  }
  return deathArray[randomint(deathArray.size)];
}

tempClean(array) {
  newArray = [];
  for(index = 0; index < array.size; index++) {
    if(!isDefined(array[index])) {
      continue;
    }
    newArray[newArray.size] = array[index];
  }
  return newArray;
}

getStandDeathAnim() {
  deathArray = [];
  if(weaponAnims() == "pistol") {
    if(abs(self.damageYaw) < 50) {
      deathArray[deathArray.size] = % pistol_death_2;
    } else {
      if(abs(self.damageYaw) < 110) {
        deathArray[deathArray.size] = % pistol_death_2;
      }
      if(damageLocationIsAny("torso_lower", "torso_upper", "left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower")) {
        deathArray[deathArray.size] = % pistol_death_3;
        if(!damageLocationIsAny("torso_upper")) {
          deathArray[deathArray.size] = % pistol_death_3;
        }
      }
      if(!damageLocationIsAny("head", "neck", "helmet", "left_foot", "right_foot", "left_hand", "right_hand", "gun") && randomint(2) == 0) {
        deathArray[deathArray.size] = % pistol_death_4;
      }
      if(deathArray.size == 0 || damageLocationIsAny("torso_lower", "torso_upper", "neck", "head", "helmet", "right_arm_upper", "left_arm_upper")) {
        deathArray[deathArray.size] = % pistol_death_1;
      }
    }
  }
  if(self usingGasWeapon()) {
    deathArray[deathArray.size] = % ai_flamethrower_stand_death;
  } else {
    if(randomint(3) < 2) {
      deathArray[deathArray.size] = tryAddDeathAnim( % exposed_death);
    }
    if(randomint(3) < 2) {
      deathArray[deathArray.size] = tryAddDeathAnim( % exposed_death_firing_02);
    }
    if(damageLocationIsAny("torso_lower", "left_leg_upper", "left_leg_lower", "right_leg_lower", "right_leg_lower")) {
      deathArray[deathArray.size] = tryAddDeathAnim( % exposed_death_groin);
    }
    if(damageLocationIsAny("left_leg_upper", "left_leg_lower", "left_foot")) {
      deathArray[deathArray.size] = tryAddDeathAnim( % ai_deadly_wounded_leg_L_hit);
    } else if(damageLocationIsAny("right_leg_upper", "right_leg_lower", "right_foot")) {
      deathArray[deathArray.size] = tryAddDeathAnim( % ai_deadly_wounded_leg_R_hit);
    } else if(damageLocationIsAny("torso_upper", "torso_lower")) {
      deathArray[deathArray.size] = tryAddDeathAnim( % ai_deadly_wounded_torso_hit);
    }
    if(damageLocationIsAny("head", "neck", "helmet")) {
      deathArray[deathArray.size] = tryAddDeathAnim( % exposed_death_headshot);
      deathArray[deathArray.size] = tryAddDeathAnim( % exposed_death_headtwist);
    }
    if(damageLocationIsAny("torso_upper", "neck")) {
      deathArray[deathArray.size] = tryAddDeathAnim( % exposed_death_nerve);
      if(self.damageTaken <= 70) {
        deathArray[deathArray.size] = tryAddDeathAnim( % exposed_death_neckgrab);
      }
    }
    if((self.damageyaw > 135) || (self.damageyaw <= -135)) {
      deathArray[deathArray.size] = tryAddDeathAnim( % exposed_death_02);
      if(damageLocationIsAny("torso_upper", "left_arm_upper", "right_arm_upper")) {
        deathArray[deathArray.size] = tryAddDeathAnim( % exposed_death_firing);
      }
      if(damageLocationIsAny("torso_upper", "neck", "head", "helmet")) {
        deathArray[deathArray.size] = tryAddDeathAnim( % exposed_death_falltoknees_02);
      }
    } else if((self.damageyaw > 45) && (self.damageyaw <= 135)) {
      deathArray[deathArray.size] = tryAddDeathAnim( % exposed_death_falltoknees_02);
    } else if((self.damageyaw > -45) && (self.damageyaw <= 45)) {
      if(usingGasWeapon()) {
        deathArray = [];
        deathArray[0] = tryAddDeathAnim( % death_explosion_up10);
      } else {
        deathArray[deathArray.size] = tryAddDeathAnim( % exposed_death_falltoknees);
        deathArray[deathArray.size] = tryAddDeathAnim( % exposed_death_falltoknees_02);
      }
    } else {
      if(damageLocationIsAny("torso_upper", "left_arm_upper", "head")) {
        deathArray[deathArray.size] = tryAddDeathAnim( % exposed_death_twist);
      }
      deathArray[deathArray.size] = tryAddDeathAnim( % exposed_death_falltoknees_02);
    }
    assertex(deathArray.size > 0, deathArray.size);
  }
  deathArray = tempClean(deathArray);
  if(deathArray.size == 0) {
    deathArray[deathArray.size] = % exposed_death;
  }
  return deathArray[randomint(deathArray.size)];
}

getCrouchDeathAnim() {
  deathArray = [];
  if(self usingGasWeapon()) {
    deathArray[deathArray.size] = % ai_flamethrower_crouch_death;
  } else {
    if(damageLocationIsAny("head", "neck")) {
      deathArray[deathArray.size] = tryAddDeathAnim( % exposed_crouch_death_fetal);
    }
    if(damageLocationIsAny("torso_upper", "torso_lower", "left_arm_upper", "right_arm_upper", "neck")) {
      deathArray[deathArray.size] = tryAddDeathAnim( % exposed_crouch_death_flip);
    }
    if(deathArray.size < 2) {
      deathArray[deathArray.size] = tryAddDeathAnim( % exposed_crouch_death_twist);
    }
    if(deathArray.size < 2) {
      deathArray[deathArray.size] = tryAddDeathAnim( % exposed_crouch_death_flip);
    }
  }
  deathArray = tempClean(deathArray);
  assertex(deathArray.size > 0, deathArray.size);
  return deathArray[randomint(deathArray.size)];
}

getProneDeathAnim() {
  return % prone_death_quickdeath;
}

getBackDeathAnim() {
  deathArray = array( % dying_back_death_v1, % dying_back_death_v2, % dying_back_death_v3, % dying_back_death_v4);
  return deathArray[randomint(deathArray.size)];
}

tryAddDeathAnim(animName) {
  if(!animHasNoteTrack(animName, "fire") && !animHasNoteTrack(animName, "fire_spray")) {
    return animName;
  }
  if(self.a.weaponPos["right"] == "none") {
    return undefined;
  }
  if(weaponIsSemiAuto(self.weapon)) {
    return undefined;
  }
  if(WeaponAnims() != "rifle") {
    return undefined;
  }
  if(isDefined(self.dieQuietly) && self.dieQuietly) {
    return undefined;
  }
  return animName;
}

play_explosion_death() {
  if(GetDvar("gib_test") != "") {
    deathAnim = % death_explosion_up10;
    get_gib_ref("right");
    localDeltaVector = getMoveDelta(deathAnim, 0, 1);
    endPoint = self localToWorldCoords(localDeltaVector);
    if(!self mayMoveToPoint(endPoint)) {
      return false;
    }
    self animMode("nogravity");
    play_death_anim(deathAnim);
    return true;
  }
  if(self.damageLocation != "none") {
    return false;
  }
  deathArray = [];
  if(self.a.movement != "run") {
    if(self.mayDoUpwardsDeath && getTime() > anim.lastUpwardsDeathTime + 6000) {
      deathArray[deathArray.size] = tryAddDeathAnim( % death_explosion_stand_UP_v1);
      deathArray[deathArray.size] = tryAddDeathAnim( % death_explosion_stand_UP_v2);
      anim.lastUpwardsDeathTime = getTime();
      get_gib_ref("up");
    } else {
      if((self.damageyaw > 135) || (self.damageyaw <= -135)) {
        deathArray[deathArray.size] = tryAddDeathAnim( % death_explosion_stand_B_v1);
        deathArray[deathArray.size] = tryAddDeathAnim( % death_explosion_stand_B_v2);
        deathArray[deathArray.size] = tryAddDeathAnim( % death_explosion_stand_B_v3);
        deathArray[deathArray.size] = tryAddDeathAnim( % death_explosion_stand_B_v4);
        get_gib_ref("back");
      } else if((self.damageyaw > 45) && (self.damageyaw <= 135)) {
        deathArray[deathArray.size] = tryAddDeathAnim( % death_explosion_stand_L_v1);
        deathArray[deathArray.size] = tryAddDeathAnim( % death_explosion_stand_L_v2);
        deathArray[deathArray.size] = tryAddDeathAnim( % death_explosion_stand_L_v3);
        get_gib_ref("left");
      } else if((self.damageyaw > -45) && (self.damageyaw <= 45)) {
        deathArray[deathArray.size] = tryAddDeathAnim( % death_explosion_stand_F_v1);
        deathArray[deathArray.size] = tryAddDeathAnim( % death_explosion_stand_F_v2);
        deathArray[deathArray.size] = tryAddDeathAnim( % death_explosion_stand_F_v3);
        deathArray[deathArray.size] = tryAddDeathAnim( % death_explosion_stand_F_v4);
        get_gib_ref("forward");
      } else {
        deathArray[deathArray.size] = tryAddDeathAnim( % death_explosion_stand_R_v1);
        deathArray[deathArray.size] = tryAddDeathAnim( % death_explosion_stand_R_v2);
        get_gib_ref("right");
      }
    }
  } else {
    if(self.mayDoUpwardsDeath && getTime() > anim.lastUpwardsDeathTime + 2000) {
      deathArray[deathArray.size] = tryAddDeathAnim( % death_explosion_stand_UP_v1);
      deathArray[deathArray.size] = tryAddDeathAnim( % death_explosion_stand_UP_v2);
      anim.lastUpwardsDeathTime = getTime();
      get_gib_ref("up");
    } else {
      if((self.damageyaw > 135) || (self.damageyaw <= -135)) {
        deathArray[deathArray.size] = tryAddDeathAnim( % death_explosion_run_B_v1);
        deathArray[deathArray.size] = tryAddDeathAnim( % death_explosion_run_B_v2);
        get_gib_ref("back");
      } else if((self.damageyaw > 45) && (self.damageyaw <= 135)) {
        deathArray[deathArray.size] = tryAddDeathAnim( % death_explosion_run_L_v1);
        deathArray[deathArray.size] = tryAddDeathAnim( % death_explosion_run_L_v2);
        get_gib_ref("left");
      } else if((self.damageyaw > -45) && (self.damageyaw <= 45)) {
        deathArray[deathArray.size] = tryAddDeathAnim( % death_explosion_run_F_v1);
        deathArray[deathArray.size] = tryAddDeathAnim( % death_explosion_run_F_v2);
        deathArray[deathArray.size] = tryAddDeathAnim( % death_explosion_run_F_v3);
        deathArray[deathArray.size] = tryAddDeathAnim( % death_explosion_run_F_v4);
        get_gib_ref("forward");
      } else {
        deathArray[deathArray.size] = tryAddDeathAnim( % death_explosion_run_R_v1);
        deathArray[deathArray.size] = tryAddDeathAnim( % death_explosion_run_R_v2);
        get_gib_ref("right");
      }
    }
  }
  deathAnim = deathArray[randomint(deathArray.size)];
  if(getdvar("scr_expDeathMayMoveCheck") == "on") {
    localDeltaVector = getMoveDelta(deathAnim, 0, 1);
    endPoint = self localToWorldCoords(localDeltaVector);
    if(!self mayMoveToPoint(endPoint, false)) {
      return false;
    }
  }
  self animMode("nogravity");
  if(try_gib_extended_death(50)) {
    return true;
  }
  play_death_anim(deathAnim);
  return true;
}

play_flame_death_anim() {
  if(self.damagemod == "MOD_MELEE")
    return false;
  if(is_german_build())
    return false;
  if(self.team == "axis") {
    level.bcOnFireTime = gettime();
    level.bcOnFireOrg = self.origin;
  }
  if(!isDefined(self.a.forceflamedeath) || !self.a.forceflamedeath) {
    if(WeaponClass(self.damageWeapon) == "turret") {
      if(!isDefined(WeaponType(self.damageWeapon)) || WeaponType(self.damageWeapon) != "gas") {
        return false;
      }
    } else if(weaponClass(self.damageWeapon) != "gas" && self.damageWeapon != "molotov" && WeaponType(self.damageWeapon) != "gas") {
      return false;
    }
  }
  deathArray = [];
  if(self usingGasWeapon()) {
    if(self.a.pose == "crouch") {
      deathArray[0] = % ai_flame_death_crouch_a;
      deathArray[1] = % ai_flame_death_crouch_b;
      deathArray[2] = % ai_flame_death_crouch_c;
      deathArray[3] = % ai_flame_death_crouch_d;
      deathArray[4] = % ai_flame_death_crouch_e;
      deathArray[5] = % ai_flame_death_crouch_f;
      deathArray[6] = % ai_flame_death_crouch_g;
      deathArray[7] = % ai_flame_death_crouch_h;
    } else {
      deathArray[0] = % ai_flamethrower_death_b;
    }
  } else {
    if(self.a.pose == "prone") {
      deathArray[0] = get_death_anim();
    } else if(self.a.pose == "back") {
      deathArray[0] = get_death_anim();
    } else if(self.a.pose == "crouch") {
      deathArray[0] = % ai_flame_death_crouch_a;
      deathArray[1] = % ai_flame_death_crouch_b;
      deathArray[2] = % ai_flame_death_crouch_c;
      deathArray[3] = % ai_flame_death_crouch_d;
      deathArray[4] = % ai_flame_death_crouch_e;
      deathArray[5] = % ai_flame_death_crouch_f;
      deathArray[6] = % ai_flame_death_crouch_g;
      deathArray[7] = % ai_flame_death_crouch_h;
    } else {
      deathArray[0] = % ai_flame_death_A;
      deathArray[1] = % ai_flame_death_B;
      deathArray[2] = % ai_flame_death_C;
      deathArray[3] = % ai_flame_death_D;
      deathArray[4] = % ai_flame_death_E;
      deathArray[5] = % ai_flame_death_F;
      deathArray[6] = % ai_flame_death_G;
      deathArray[7] = % ai_flame_death_H;
      deathArray[8] = % ai_deadly_wounded_flamedA_hit;
      deathArray[9] = % ai_deadly_wounded_flamedB_hit;
    }
  }
  self.fire_footsteps = true;
  if(deathArray.size == 0) {
    println("^3ANIMSCRIPT WARNING: None of the Flame-Deaths exist!!");
    return false;
  }
  deathArray = animscripts\pain::removeBlockedAnims(deathArray);
  if(deathArray.size == 0) {
    println("^3ANIMSCRIPT WARNING: All of the Flame-Death Animations are blocked by geometry, cannot use any!!");
    return false;
  }
  randomChoice = randomint(deathArray.size);
  self thread flame_death_fx();
  deathAnim = deathArray[randomChoice];
  play_death_anim(deathAnim);
  return true;
}

flame_death_fx() {
  self endon("death");
  if(isDefined(self.is_on_fire) && self.is_on_fire) {
    return;
  }
  self.is_on_fire = true;
  self thread on_fire_timeout();
  self StartTanning();
  if(self.team == "axis") {
    level.bcOnFireTime = gettime();
    level.bcOnFireOrg = self.origin;
  }
  if(isDefined(level._effect) && isDefined(level._effect["character_fire_death_torso"])) {
    if(self.classname != "actor_zombie_dog") {
      playFXOnTag(level._effect["character_fire_death_torso"], self, "J_SpineLower");
    }
  } else {
    println("^3ANIMSCRIPT WARNING: You are missing level._effect[\"character_fire_death_torso\"], please set it in your levelname_fx.gsc. Use \"env/fire/fx_fire_player_torso\"");
  }
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
  } else {
    println("^3ANIMSCRIPT WARNING: You are missing level._effect[\"character_fire_death_sm\"], please set it in your levelname_fx.gsc. Use \"env/fire/fx_fire_player_sm\"");
  }
}

on_fire_timeout() {
  self endon("death");
  wait 12;
  if(isDefined(self) && isalive(self)) {
    self.is_on_fire = false;
    self notify("stop_flame_damage");
  }
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
  if(WeaponClass(self.damageWeapon) == "spread") {
    maxDist = 300;
    shotty_gib = true;
    distSquared = DistanceSquared(self.origin, self.attacker.origin);
    if(distSquared < 110 * 110) {
      gib_chance = 100;
    } else if(distSquared < 200 * 200) {
      gib_chance = 75;
    } else if(distSquared < 270 * 270) {
      gib_chance = 50;
    } else if(distSquared < 330 * 330) {
      if(RandomInt(100) < 50) {
        gib_chance = 50;
      } else {
        return false;
      }
    } else {
      return false;
    }
  } else if(WeaponClass(self.damageWeapon) == "turret" || WeaponMountable(self.damageWeapon)) {
    maxDist = 750;
  } else if(self.damageWeapon == "dp28" || self.damageWeapon == "dp28_wet" ||
    self.damageWeapon == "type99_lmg" || self.damageWeapon == "type99_lmg_wet" ||
    self.damageWeapon == "30cal" || self.damageWeapon == "30cal_wet" ||
    self.damageWeapon == "mg42" || self.damageWeapon == "fg42" ||
    self.damageWeapon == "30cal_bipod" || self.damageWeapon == "30cal_bipod_wet") {
    maxDist = 1000;
  } else if(self.damageWeapon == "ptrs41") {
    maxDist = 3500;
  } else if(self.damageWeapon == "triple25_turret") {
    maxDist = 3500;
    gib_chance = 100;
    anim.lastGibTime = anim.lastGibTime - 3000;
  } else if(isDefined(self.gib_override) && self.gib_override) {
    maxDist = 6000;
  } else {
    return false;
  }
  if(!isDefined(self.attacker) || !isDefined(self.damageLocation)) {
    return false;
  }
  if(self.damagetaken < 50 && !shotty_gib) {
    return false;
  }
  self.a.gib_ref = undefined;
  distSquared = DistanceSquared(self.origin, self.attacker.origin);
  if(RandomInt(100) < gib_chance && distSquared < maxDist * maxDist && GetTime() > anim.lastGibTime + anim.gibDelay) {
    anim.lastGibTime = GetTime();
    refs = [];
    switch (self.damageLocation) {
      case "torso_upper":
      case "torso_lower":
        refs[refs.size] = "guts";
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
    if(isDefined(self.thunder_death) && self.thunder_death) {
      refs = [];
      refs[refs.size] = "guts";
      refs[refs.size] = "right_arm";
      refs[refs.size] = "left_arm";
      refs[refs.size] = "right_leg";
      refs[refs.size] = "left_leg";
      refs[refs.size] = "no_legs";
      refs[refs.size] = "head";
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
  self thread do_gib();
  self animscripts\shared::DropAllAIWeapons();
  deathAnim = get_death_anim();
  self setFlaggedAnimKnobAllRestart("deathanim", deathAnim, % body, 1, .1);
  wait 0.05;
  self launch_ragdoll_based_on_damage_type(2.0);
  self thread death_anim_short_circuit();
  wait 0.5;
  return true;
}

try_gib_extended_death(chance) {
  if(RandomInt(100) >= chance) {
    return false;
  }
  if(self.a.pose == "prone" || self.a.pose == "back") {
    return false;
  }
  if((!isDefined(self.dieQuietly) || !self.dieQuietly) && self.type == "human") {
    self thread animscripts\face::SaySpecificDialogue(undefined, "generic_gib_" + self.voice, 1.0);
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
  self thread death_anim_short_circuit();
  self setFlaggedAnimKnobAllRestart("deathhitanim", deathSeq[0], % body, 1, .1);
  self animscripts\shared::DoNoteTracks("deathhitanim");
  self notify("stop_death_anim_short_circuit");
  self thread end_extended_death(deathSeq);
  numDeathLoops = RandomInt(2) + 1;
  self thread extended_death_loop(deathSeq, numDeathLoops);
  self waittill("extended_death_ended");
}

end_extended_death(deathSeq) {
  assert(isDefined(deathSeq[2]));
  self waittill_any("damage", "ending_extended_death");
  self setFlaggedAnimKnobAllRestart("deathdieanim", deathSeq[2], % body, 1, .1);
  self animscripts\shared::DoNoteTracks("deathdieanim");
  self notify("extended_death_ended");
}

extended_death_loop(deathSeq, numLoops) {
  self endon("damage");
  assert(isDefined(deathSeq[1]));
  animLength = GetAnimLength(deathSeq[1]);
  for(i = 0; i < numLoops; i++) {
    self setFlaggedAnimKnobAllRestart("deathloopanim", deathSeq[1], % body, 1, .1);
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
  if(isDefined(hitfrom) && isDefined(gib_ref)) {
    hitIndex = 0;
    loopIndex = 1;
    dieIndex = 2;
    switch (gib_ref) {
      case "guts":
        deathSeq[hitIndex] = % ai_gib_torso_gib;
        deathSeq[loopIndex] = % ai_gib_torso_loop;
        deathSeq[dieIndex] = % ai_gib_torso_death;
        break;
      case "no_legs":
        deathSeq[hitIndex] = % ai_gib_bothlegs_gib;
        deathSeq[loopIndex] = % ai_gib_bothlegs_loop;
        deathSeq[dieIndex] = % ai_gib_bothlegs_death;
        break;
      case "left_leg":
        if(hitfrom == "front") {
          deathSeq[hitIndex] = % ai_gib_leftleg_front_gib;
          deathSeq[loopIndex] = % ai_gib_leftleg_front_loop;
          deathSeq[dieIndex] = % ai_gib_leftleg_front_death;
        } else {
          deathSeq[hitIndex] = % ai_gib_leftleg_back_gib;
          deathSeq[loopIndex] = % ai_gib_leftleg_back_loop;
          deathSeq[dieIndex] = % ai_gib_leftleg_back_death;
        }
        break;
      case "right_leg":
        if(hitfrom == "front") {
          deathSeq[hitIndex] = % ai_gib_rightleg_front_gib;
          deathSeq[loopIndex] = % ai_gib_rightleg_front_loop;
          deathSeq[dieIndex] = % ai_gib_rightleg_front_death;
        } else {
          deathSeq[hitIndex] = % ai_gib_rightleg_back_gib;
          deathSeq[loopIndex] = % ai_gib_rightleg_back_loop;
          deathSeq[dieIndex] = % ai_gib_rightleg_back_death;
        }
        break;
      case "left_arm":
        if(hitfrom == "front") {
          deathSeq[hitIndex] = % ai_gib_leftarm_front_gib;
          deathSeq[loopIndex] = % ai_gib_leftarm_front_loop;
          deathSeq[dieIndex] = % ai_gib_leftarm_front_death;
        } else {
          deathSeq[hitIndex] = % ai_gib_leftarm_back_gib;
          deathSeq[loopIndex] = % ai_gib_leftarm_back_loop;
          deathSeq[dieIndex] = % ai_gib_leftarm_back_death;
        }
        break;
      case "right_arm":
        if(hitfrom == "front") {
          deathSeq[hitIndex] = % ai_gib_rightarm_front_gib;
          deathSeq[loopIndex] = % ai_gib_rightarm_front_loop;
          deathSeq[dieIndex] = % ai_gib_rightarm_front_death;
        } else {
          deathSeq[hitIndex] = % ai_gib_rightarm_back_gib;
          deathSeq[loopIndex] = % ai_gib_rightarm_back_loop;
          deathSeq[dieIndex] = % ai_gib_rightarm_back_death;
        }
        break;
    }
  }
  return deathSeq;
}

randomize_array(array) {
  for(i = 0; i < array.size; i++) {
    j = RandomInt(array.size);
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
    deathAnim = % ai_bayonet_back_death;
    side = "back";
  } else if((self.damageyaw > 45) && (self.damageyaw <= 135)) {
    deathAnim = % ai_bayonet_right_death;
    side = "right";
  } else if((self.damageyaw < -45) && (self.damageyaw >= -135)) {
    deathAnim = % ai_bayonet_left_death;
    side = "left";
  } else if(damageLocationIsAny("helmet", "head", "neck", "torso_upper")) {
    deathAnim = % ai_bayonet_shoulder_death;
    side = "front";
  } else {
    deathAnim = % ai_bayonet_thrust_death;
    side = "front";
  }
  if(GetDvarInt("cg_blood") > 0) {
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
  } else {
    println("^3ANIMSCRIPT WARNING: You are missing level._effect[\"character_bayonet_blood_in\"], please set it in your levelname_fx.gsc. Use \"impacts/fx_flesh_bayonet_impact\"");
  }
  wait 0.2;
  if(isDefined(level._effect)) {
    if(!isDefined(level._effect["character_bayonet_blood_front"]) ||
      !isDefined(level._effect["character_bayonet_blood_back"]) ||
      !isDefined(level._effect["character_bayonet_blood_left"]) ||
      !isDefined(level._effect["character_bayonet_blood_right"])) {
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
  } else {
    println("^3ANIMSCRIPT WARNING: You are missing level._effect");
  }
}

get_gib_ref(direction) {
  if(GetDvarInt("gib_delay") > 0) {
    anim.gibDelay = GetDvarInt("gib_delay");
  }
  if(GetDvar("gib_test") != "") {
    self.a.gib_ref = GetDvar("gib_test");
    return;
  }
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
        refs[refs.size] = "guts";
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
        refs[refs.size] = "guts";
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
  return array[RandomInt(array.size)];
}

do_gib() {
  if(!is_mature()) {
    return;
  }
  if(is_german_build()) {
    return;
  }
  if(!isDefined(self.a.gib_ref)) {
    return;
  }
  if(self is_zombie() && isDefined(self.is_on_fire) && self.is_on_fire) {
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
  maps\_challenges_coop::doMissionCallback("playerGib", self);
  gib_ref = self.a.gib_ref;
  limb_data = get_limb_data(gib_ref);
  if(!isDefined(limb_data)) {
    println("^3animscripts\death.gsc - limb_data is not setup for gib_ref on model: " + self.model + " and gib_ref of: " + self.a.gib_ref);
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
  PlaySoundAtPosition("death_gibs", self.origin);
  self thread throw_gib(limb_data["spawn_models"], limb_data["spawn_tags"], velocities);
  self setModel(limb_data["body_model"]);
  self Attach(limb_data["legs_model"]);
}

precache_gib_fx() {
  anim._effect["animscript_gib_fx"] = LoadFx("weapon/bullet/fx_flesh_gib_fatal_01");
  anim._effect["animscript_gibtrail_fx"] = LoadFx("trail/fx_trail_blood_streak");
  anim._effect["death_neckgrab_spurt"] = LoadFx("impacts/flesh_hit_neck_fatal");
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

gib_delete() {
  wait(10 + RandomFloat(5));
  for(i = 0; i < 100; i++) {
    if(!self IsBeingWatched()) {
      break;
    }
    wait(1);
  }
  self Delete();
}

death_anim_short_circuit() {
  self endon("stop_death_anim_short_circuit");
  wait 0.3;
  totalDamageTaken = 0;
  while(1) {
    self waittill("damage", damagetaken, attacker, dir, point, mod);
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
  if(self animscripts\pain::wasDamagedByExplosive()) {
    force = 1.6;
  } else if(WeaponClass(self.damageWeapon) == "spread") {
    distSquared = DistanceSquared(self.origin, self.attacker.origin);
    force = .3;
    force += .7 * (1.0 - (distSquared / (300 * 300)));
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

draw_line(pos1, pos2) {
  while(1) {
    line(pos1, pos2);
    wait(0.05);
  }
}