/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\zombie_pain.gsc
***************************************/

#include animscripts\zombie_utility;
#include animscripts\weaponList;
#include common_scripts\utility;
#include animscripts\Combat_Utility;
#include maps\_utility;
#using_animtree("generic_human");

main() {
  self SetFlashBanged(false);
  if(isDefined(self.longDeathStarting)) {
    self waittill("killanimscript");
    return;
  }
  if(is_true(self.lander_knockdown) && (self.animname == "zombie" || self.animname == "napalm_zombie" || self.animname == "sonic_zombie")) {
    self playThundergunPainAnim();
    self.lander_knockdown = undefined;
    return;
  }
  if(isDefined(self.damageweapon) && (self.damageweapon == "thundergun_zm" || self.damageweapon == "thundergun_upgraded_zm") && (self.damagemod != "MOD_GRENADE" && self.damagemod != "MOD_GRENADE_SPLASH") && self.animname == "zombie") {
    self playThundergunPainAnim();
    return;
  }
  if([[anim.pain_test]]()) {
    return;
  }
  if(self.a.disablePain) {
    return;
  }
  self notify("kill_long_death");
  self.a.painTime = GetTime();
  if(self.a.flamepainTime > self.a.painTime) {
    return;
  }
  if(self.a.nextStandingHitDying) {
    self.health = 1;
  }
  dead = false;
  stumble = false;
  ratio = self.health / self.maxHealth;
  self trackScriptState("Pain Main", "code");
  self notify("anim entered pain");
  self endon("killanimscript");
  animscripts\zombie_utility::initialize("zombie_pain");
  self AnimMode("gravity");
  self animscripts\face::SayGenericDialogue("pain");
  if(self.damageLocation == "helmet") {
    self animscripts\zombie_death::helmetPop();
  }
  if(specialPain(self.a.special)) {
    return;
  }
  self.a.special = "none";
  painAnim = getPainAnim();
  playPainAnim(painAnim);
}
wasDamagedByExplosive() {
  if(self.damageWeapon != "none") {
    if(weaponClass(self.damageWeapon) == "rocketlauncher" || weaponClass(self.damageWeapon) == "grenade" || self.damageWeapon == "fraggrenade" || self.damageWeapon == "c4" || self.damageWeapon == "claymore" || self.damageWeapon == "satchel_charge_new" || self.damageWeapon == "frag_grenade_sp") {
      self.mayDoUpwardsDeath = (self.damageTaken > 300);
      return true;
    }
  }
  if(GetTime() - anim.lastCarExplosionTime <= 50) {
    rangesq = anim.lastCarExplosionRange * anim.lastCarExplosionRange * 1.2 * 1.2;
    if(DistanceSquared(self.origin, anim.lastCarExplosionDamageLocation) < rangesq) {
      upwardsDeathRangeSq = rangesq * 0.5 * 0.5;
      self.mayDoUpwardsDeath = (DistanceSquared(self.origin, anim.lastCarExplosionLocation) < upwardsDeathRangeSq);
      return true;
    }
  }
  return false;
}
getPainAnim() {
  if(self.a.pose == "stand") {
    if(isDefined(self.damagemod) && self.damagemod == "MOD_BURNED") {
      return get_flamethrower_pain();
    } else if(self.a.movement == "run" && (self getMotionAngle() < 60) && (self getMotionAngle() > -60)) {
      return getRunningForwardPainAnim();
    }
    self.a.movement = "stop";
    return getStandPainAnim();
  } else if(self.a.pose == "crouch") {
    if(isDefined(self.damagemod) && self.damagemod == "MOD_BURNED") {
      return get_flamethrower_crouch_pain();
    }
    self.a.movement = "stop";
    return getCrouchPainAnim();
  } else {
    assert(self.a.pose == "back");
    self.a.movement = "stop";
    return % back_pain;
  }
}
get_flamethrower_pain() {
  painArray = array(%ai_flame_wounded_stand_a, %ai_flame_wounded_stand_b, %ai_flame_wounded_stand_c, %ai_flame_wounded_stand_d);
  tagArray = array("J_Elbow_RI", "J_Wrist_LE", "J_Wrist_RI", "J_Head");
  painArray = removeBlockedAnims(painArray);
  if(!painArray.size) {
    self.a.movement = "stop";
    return getStandPainAnim();
  }
  anim_num = RandomInt(painArray.size);
  if(self.team == "axis" && isDefined(level._effect["character_fire_pain_sm"])) {
    playFXOnTag(level._effect["character_fire_pain_sm"], self, tagArray[anim_num]);
  } else {}
  pain_anim = painArray[anim_num];
  time = GetAnimLength(pain_anim);
  self.a.flamepainTime = GetTime() + (time * 1000);
  return pain_anim;
}
get_flamethrower_crouch_pain() {
  painArray = array(%ai_flame_wounded_crouch_a, %ai_flame_wounded_crouch_b, %ai_flame_wounded_crouch_c, %ai_flame_wounded_crouch_d);
  tagArray = array("J_Elbow_LE", "J_Wrist_LE", "J_Wrist_RI", "J_Head");
  painArray = removeBlockedAnims(painArray);
  if(!painArray.size) {
    self.a.movement = "stop";
    return getStandPainAnim();
  }
  anim_num = RandomInt(painArray.size);
  if(self.team == "axis" && isDefined(level._effect["character_fire_pain_sm"])) {
    playFXOnTag(level._effect["character_fire_pain_sm"], self, tagArray[anim_num]);
  } else {}
  pain_anim = painArray[anim_num];
  time = GetAnimLength(pain_anim);
  self.a.flamepainTime = GetTime() + (time * 1000);
  return pain_anim;
}
getRunningForwardPainAnim() {
  painArray = array(%run_pain_fallonknee, %run_pain_fallonknee_02, %run_pain_fallonknee_03, %run_pain_stomach, %run_pain_stumble);
  painArray = removeBlockedAnims(painArray);
  if(!painArray.size) {
    self.a.movement = "stop";
    return getStandPainAnim();
  }
  return painArray[RandomInt(painArray.size)];
}
getStandPainAnim() {
  painArray = [];
  damageAmount = self.damageTaken / self.maxhealth;
  if(damageAmount > .4 && !damageLocationIsAny("left_hand", "right_hand", "left_foot", "right_foot", "helmet")) {
    painArray[painArray.size] = % exposed_pain_2_crouch;
  }
  if(self damageLocationIsAny("torso_upper", "torso_lower", "left_arm_upper", "right_arm_upper", "neck")) {
    painArray[painArray.size] = % exposed_pain_back;
  }
  if(self damageLocationIsAny("right_hand", "right_arm_upper", "right_arm_lower", "torso_upper")) {
    painArray[painArray.size] = % exposed_pain_dropgun;
  }
  if(self damageLocationIsAny("torso_lower", "left_leg_upper", "right_leg_upper")) {
    painArray[painArray.size] = % exposed_pain_groin;
  }
  if(self damageLocationIsAny("left_hand", "left_arm_lower", "left_arm_upper")) {
    painArray[painArray.size] = % exposed_pain_left_arm;
  }
  if(self damageLocationIsAny("right_hand", "right_arm_lower", "right_arm_upper")) {
    painArray[painArray.size] = % exposed_pain_right_arm;
  }
  if(self damageLocationIsAny("left_foot", "right_foot", "left_leg_lower", "right_leg_lower", "left_leg_upper", "right_leg_upper")) {
    painArray[painArray.size] = % exposed_pain_leg;
  }
  if(painArray.size < 2) {
    painArray[painArray.size] = % exposed_pain_back;
  }
  if(painArray.size < 2) {
    painArray[painArray.size] = % exposed_pain_dropgun;
  }
  assertex(painArray.size > 0, painArray.size);
  return painArray[RandomInt(painArray.size)];
}
removeBlockedAnims(array) {
  newArray = [];
  for(index = 0; index < array.size; index++) {
    localDeltaVector = getMoveDelta(array[index], 0, 1);
    endPoint = self localToWorldCoords(localDeltaVector);
    if(self mayMoveToPoint(endPoint)) {
      newArray[newArray.size] = array[index];
    }
  }
  return newArray;
}
getCrouchPainAnim() {
  painArray = [];
  if(damageLocationIsAny("torso_upper", "torso_lower", "left_arm_upper", "right_arm_upper", "neck")) {
    painArray[painArray.size] = % exposed_crouch_pain_chest;
  }
  if(damageLocationIsAny("head", "neck", "torso_upper")) {
    painArray[painArray.size] = % exposed_crouch_pain_headsnap;
  }
  if(damageLocationIsAny("left_hand", "left_arm_lower", "left_arm_upper")) {
    painArray[painArray.size] = % exposed_crouch_pain_left_arm;
  }
  if(damageLocationIsAny("right_hand", "right_arm_lower", "right_arm_upper")) {
    painArray[painArray.size] = % exposed_crouch_pain_right_arm;
  }
  if(painArray.size < 2) {
    painArray[painArray.size] = % exposed_crouch_pain_flinch;
  }
  if(painArray.size < 2) {
    painArray[painArray.size] = % exposed_crouch_pain_chest;
  }
  assertex(painArray.size > 0, painArray.size);
  return painArray[RandomInt(painArray.size)];
}
playPainAnim(painAnim) {
  if(isDefined(self.magic_bullet_shield)) {
    rate = 1.5;
  } else {
    rate = self.animPlayBackRate;
  }
  self SetFlaggedAnimKnobAllRestart("painanim", painAnim, %body, 1, .1, rate);
  self animscripts\zombie_shared::DoNoteTracks("painanim");
}
playThundergunPainAnim() {
  self notify("end_play_thundergun_pain_anim");
  self endon("killanimscript");
  self endon("death");
  self endon("end_play_thundergun_pain_anim");
  if(isDefined(self.marked_for_death) && self.marked_for_death) {
    return;
  }
  if(self.damageYaw <= -135 || self.damageYaw >= 135) {
    if(!self.has_legs) {
      fallAnim = random(level._zombie_knockdowns[self.animname]["front"]["no_legs"]);
      if(isDefined(level.thundergun_last_knockdown_anim) && level.thundergun_last_knockdown_anim == fallAnim) {
        fallAnim = random(level._zombie_knockdowns[self.animname]["front"]["no_legs"]);
      }
    } else {
      fallAnim = random(level._zombie_knockdowns[self.animname]["front"]["has_legs"]);
      if(isDefined(level.thundergun_last_knockdown_anim) && level.thundergun_last_knockdown_anim == fallAnim) {
        fallAnim = random(level._zombie_knockdowns[self.animname]["front"]["has_legs"]);
      }
    }
    level.thundergun_last_knockdown_anim = fallAnim;
    if(fallAnim == % ai_zombie_thundergun_hit_deadfallknee || fallAnim == % ai_zombie_thundergun_hit_forwardtoface) {
      getupAnim = random(level._zombie_getups[self.animname]["belly"]["early"]);
    } else {
      getupAnim = random(level._zombie_getups[self.animname]["back"]["early"]);
    }
  } else if(self.damageYaw > -135 && self.damageYaw < -45) {
    fallAnim = random(level._zombie_knockdowns[self.animname]["left"]);
    getupAnim = random(level._zombie_getups[self.animname]["belly"]["early"]);
  } else if(self.damageYaw > 45 && self.damageYaw < 135) {
    fallAnim = random(level._zombie_knockdowns[self.animname]["right"]);
    getupAnim = random(level._zombie_getups[self.animname]["belly"]["early"]);
  } else {
    fallAnim = random(level._zombie_knockdowns[self.animname]["back"]);
    getupAnim = random(level._zombie_getups[self.animname]["belly"]["early"]);
  }
  self SetFlaggedAnimKnobAllRestart("painanim", fallAnim, %body, 1, .2, self.animPlayBackRate);
  self animscripts\zombie_shared::DoNoteTracks("painanim", self.thundergun_handle_pain_notetracks);
  if(!isDefined(self) || !IsAlive(self) || !self.has_legs || (isDefined(self.marked_for_death) && self.marked_for_death)) {
    return;
  }
  if(getupAnim == % ai_zombie_thundergun_getup_quick_a && (self.a.gib_ref == "left_arm" || self.a.gib_ref == "right_arm")) {
    return;
  }
  self SetFlaggedAnimKnobAllRestart("painanim", getupAnim, %body, 1, .2, self.animPlayBackRate);
  self animscripts\zombie_shared::DoNoteTracks("painanim");
}
specialPain(anim_special) {
  if(anim_special == "none") {
    return false;
  }
  switch (anim_special) {
    case "cover_left":
      if(self.a.pose == "stand") {
        painArray = [];
        if(self damageLocationIsAny("torso_lower", "left_leg_upper", "right_leg_upper") || RandomFloat(10) < 3) {
          painArray[painArray.size] = % corner_standl_painB;
        }
        if(self damageLocationIsAny("torso_lower", "torso_upper", "left_arm_upper", "right_arm_upper", "neck") || RandomFloat(10) < 3) {
          painArray[painArray.size] = % corner_standl_painC;
        }
        if(self damageLocationIsAny("left_leg_upper", "left_leg_lower", "left_foot") || RandomFloat(10) < 3) {
          painArray[painArray.size] = % corner_standl_painD;
        }
        if(self damageLocationIsAny("right_leg_upper", "right_leg_lower", "right_foot") || RandomFloat(10) < 3) {
          painArray[painArray.size] = % corner_standl_painE;
        }
        if(painArray.size < 2) {
          painArray[painArray.size] = % corner_standl_pain;
        }
        DoPainFromArray(painArray);
        handled = true;
      } else {
        handled = false;
      }
      break;
    case "cover_right":
      if(self.a.pose == "stand") {
        painArray = [];
        if(self damageLocationIsAny("right_arm_upper", "torso_upper", "neck") || RandomFloat(10) < 3) {
          painArray[painArray.size] = % corner_standr_pain;
        }
        if(self damageLocationIsAny("right_leg_upper", "right_leg_lower", "right_foot") || RandomFloat(10) < 3) {
          painArray[painArray.size] = % corner_standr_painB;
        }
        if(self damageLocationIsAny("torso_lower", "left_leg_upper", "right_leg_upper") || RandomFloat(10) < 3) {
          painArray[painArray.size] = % corner_standr_painC;
        }
        if(painArray.size == 0) {
          painArray[0] = % corner_standr_pain;
          painArray[1] = % corner_standr_painB;
          painArray[2] = % corner_standr_painC;
        }
        DoPainFromArray(painArray);
        handled = true;
      } else {
        handled = false;
      }
      break;
    case "cover_crouch":
      handled = false;
      break;
    case "cover_stand":
      painArray = [];
      if(self damageLocationIsAny("torso_lower", "left_leg_upper", "right_leg_upper") || RandomFloat(10) < 3) {
        painArray[painArray.size] = % coverstand_pain_groin;
      }
      if(self damageLocationIsAny("torso_lower", "torso_upper", "left_arm_upper", "right_arm_upper", "neck") || RandomFloat(10) < 3) {
        painArray[painArray.size] = % coverstand_pain_groin;
      }
      if(self damageLocationIsAny("left_leg_upper", "left_leg_lower", "left_foot") || RandomFloat(10) < 3) {
        painArray[painArray.size] = % coverstand_pain_leg;
      }
      if(self damageLocationIsAny("right_leg_upper", "right_leg_lower", "right_foot") || RandomFloat(10) < 3) {
        painArray[painArray.size] = % coverstand_pain_leg;
      }
      if(painArray.size < 2) {
        painArray[painArray.size] = % coverstand_pain_leg;
      }
      DoPainFromArray(painArray);
      handled = true;
      break;
    case "saw":
      if(self.a.pose == "stand") {
        painAnim = % saw_gunner_pain;
      } else {
        painAnim = % saw_gunner_lowwall_pain_02;
      }
      self SetFlaggedAnimKnob("painanim", painAnim, 1, .3, 1);
      self animscripts\zombie_shared::DoNoteTracks("painanim");
      handled = true;
      break;
    case "mg42":
      mg42pain(self.a.pose);
      handled = true;
      break;
    case "corner_right_mode_b":
    case "rambo_left":
    case "rambo_right":
    case "rambo":
      handled = false;
      break;
    default:
      println("Unexpected anim_special value : " + anim_special + " in specialPain.");
      handled = false;
  }
  return handled;
}
DoPainFromArray(painArray) {
  painAnim = painArray[RandomInt(painArray.size)];
  self SetFlaggedAnimKnob("painanim", painAnim, 1, .3, 1);
  self animscripts\zombie_shared::DoNoteTracks("painanim");
}
mg42pain(pose) {
  self SetFlaggedAnimKnob("painanim", level.mg_animmg["pain_" + pose], 1, .1, 1);
  self animscripts\zombie_shared::DoNoteTracks("painanim");
}