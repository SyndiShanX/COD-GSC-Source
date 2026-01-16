/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\pain.gsc
*****************************************************/

#include animscripts\Utility;
#include animscripts\weaponList;
#include common_scripts\utility;
#include animscripts\Combat_Utility;
#using_animtree("generic_human");

main() {
  self setflashbanged(false);
  self flamethrower_stop_shoot();
  if(isDefined(self.longDeathStarting)) {
    self waittill("killanimscript");
    return;
  }
  if([
      [anim.pain_test]
    ]())
    return;
  if(self.a.disablePain) {
    return;
  }
  self notify("kill_long_death");
  self.a.painTime = gettime();
  if(self.a.flamepainTime > self.a.painTime) {
    return;
  }
  if(self.a.nextStandingHitDying)
    self.health = 1;
  dead = false;
  stumble = false;
  ratio = self.health / self.maxHealth;
  self trackScriptState("Pain Main", "code");
  self notify("anim entered pain");
  self endon("killanimscript");
  animscripts\utility::initialize("pain");
  self animmode("gravity");
  self animscripts\face::SayGenericDialogue("pain");
  if(self.damageLocation == "helmet")
    self animscripts\death::helmetPop();
  if(getDvarInt("scr_forceCornerGrenadeDeath") == 1) {
    if(self TryCornerRightGrenadeDeath())
      return;
  }
  if(self.a.special == "corner_right_mode_b" && TryCornerRightGrenadeDeath()) {
    return;
  }
  if(crawlingPain()) {
    return;
  }
  if(specialPain(self.a.special)) {
    return;
  }
  self.a.special = "none";
  painAnim = getPainAnim();
  if(getdvarint("scr_paindebug") == 1)
    println("^2Playing pain: ", painAnim, " ; pose is ", self.a.pose);
  playPainAnim(painAnim);
}

wasDamagedByExplosive() {
  if(self.damageWeapon != "none") {
    if(weaponClass(self.damageWeapon) == "rocketlauncher" || weaponClass(self.damageWeapon) == "grenade" || self.damageWeapon == "fraggrenade" || self.damageWeapon == "c4" || self.damageWeapon == "claymore" || self.damageWeapon == "satchel_charge_new") {
      self.mayDoUpwardsDeath = (self.damageTaken > 300);
      return true;
    }
  }
  if(gettime() - anim.lastCarExplosionTime <= 50) {
    rangesq = anim.lastCarExplosionRange * anim.lastCarExplosionRange * 1.2 * 1.2;
    if(distanceSquared(self.origin, anim.lastCarExplosionDamageLocation) < rangesq) {
      upwardsDeathRangeSq = rangesq * 0.5 * 0.5;
      self.mayDoUpwardsDeath = (distanceSquared(self.origin, anim.lastCarExplosionLocation) < upwardsDeathRangeSq);
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
  } else if(self.a.pose == "prone") {
    self.a.movement = "stop";
    return getPronePainAnim();
  } else {
    assert(self.a.pose == "back");
    self.a.movement = "stop";
    return % back_pain;
  }
}

get_flamethrower_pain() {
  if(self usingGasWeapon()) {
    painArray = array( % ai_flamethrower_wounded_stand_arm, % ai_flamethrower_wounded_stand_chest, % ai_flamethrower_wounded_stand_head, % ai_flamethrower_wounded_stand_leg);
  } else {
    painArray = array( % ai_flame_wounded_stand_a, % ai_flame_wounded_stand_b, % ai_flame_wounded_stand_c, % ai_flame_wounded_stand_d);
  }
  tagArray = array("J_Elbow_RI", "J_Wrist_LE", "J_Wrist_RI", "J_Head");
  painArray = removeBlockedAnims(painArray);
  if(!painArray.size) {
    self.a.movement = "stop";
    return getStandPainAnim();
  }
  anim_num = RandomInt(painArray.size);
  if(self.team == "axis" && isDefined(level._effect["character_fire_pain_sm"])) {
    PlayFxOnTag(level._effect["character_fire_pain_sm"], self, tagArray[anim_num]);
  } else {
    println("^3ANIMSCRIPT WARNING: You are missing level._effect[\"character_fire_pain_sm\"], please set it in your levelname_fx.gsc. Use \"env/fire/fx_fire_player_sm\"");
  }
  pain_anim = painArray[anim_num];
  time = GetAnimLength(pain_anim);
  self.a.flamepainTime = GetTime() + (time * 1000);
  return pain_anim;
}

get_flamethrower_crouch_pain() {
  painArray = array( % ai_flame_wounded_crouch_a, % ai_flame_wounded_crouch_b, % ai_flame_wounded_crouch_c, % ai_flame_wounded_crouch_d);
  tagArray = array("J_Elbow_LE", "J_Wrist_LE", "J_Wrist_RI", "J_Head");
  painArray = removeBlockedAnims(painArray);
  if(!painArray.size) {
    self.a.movement = "stop";
    return getStandPainAnim();
  }
  anim_num = RandomInt(painArray.size);
  if(self.team == "axis" && isDefined(level._effect["character_fire_pain_sm"])) {
    PlayFxOnTag(level._effect["character_fire_pain_sm"], self, tagArray[anim_num]);
  } else {
    println("^3ANIMSCRIPT WARNING: You are missing level._effect[\"character_fire_pain_sm\"], please set it in your levelname_fx.gsc. Use \"env/fire/fx_fire_player_sm\"");
  }
  pain_anim = painArray[anim_num];
  time = GetAnimLength(pain_anim);
  self.a.flamepainTime = GetTime() + (time * 1000);
  return pain_anim;
}

getRunningForwardPainAnim() {
  painArray = array( % run_pain_fallonknee, % run_pain_fallonknee_02, % run_pain_fallonknee_03, % run_pain_stomach, % run_pain_stumble);
  painArray = removeBlockedAnims(painArray);
  if(!painArray.size) {
    self.a.movement = "stop";
    return getStandPainAnim();
  }
  return painArray[randomint(painArray.size)];
}

getStandPainAnim() {
  painArray = [];
  if(weaponAnims() == "pistol") {
    if(self damageLocationIsAny("torso_upper", "torso_lower", "left_arm_upper", "right_arm_upper", "neck"))
      painArray[painArray.size] = % pistol_stand_pain_chest;
    if(self damageLocationIsAny("torso_lower", "left_leg_upper", "right_leg_upper"))
      painArray[painArray.size] = % pistol_stand_pain_groin;
    if(self damageLocationIsAny("head", "neck"))
      painArray[painArray.size] = % pistol_stand_pain_head;
    if(self damageLocationIsAny("left_arm_lower", "left_arm_upper", "torso_upper"))
      painArray[painArray.size] = % pistol_stand_pain_leftshoulder;
    if(self damageLocationIsAny("right_arm_lower", "right_arm_upper", "torso_upper"))
      painArray[painArray.size] = % pistol_stand_pain_rightshoulder;
    if(painArray.size < 2)
      painArray[painArray.size] = % pistol_stand_pain_chest;
    if(painArray.size < 2)
      painArray[painArray.size] = % pistol_stand_pain_groin;
  } else if(self usingGasWeapon()) {
    painArray[painArray.size] = % ai_flamethrower_stand_pain;
  } else {
    damageAmount = self.damageTaken / self.maxhealth;
    if(damageAmount > .4 && !damageLocationIsAny("left_hand", "right_hand", "left_foot", "right_foot", "helmet")) {
      if(!isDefined(self.exposedSet) || self.exposedSet == 0)
        painArray[painArray.size] = % exposed_pain_2_crouch;
      else
        painArray[painArray.size] = % exposed2_pain_2_crouch;
    }
    if(self damageLocationIsAny("torso_upper", "torso_lower", "left_arm_upper", "right_arm_upper", "neck")) {
      if(!isDefined(self.exposedSet) || self.exposedSet == 0)
        painArray[painArray.size] = % exposed_pain_back;
      else
        painArray[painArray.size] = % exposed2_pain_back;
    }
    if(self damageLocationIsAny("right_hand", "right_arm_upper", "right_arm_lower", "torso_upper")) {
      if(!isDefined(self.exposedSet) || self.exposedSet == 0)
        painArray[painArray.size] = % exposed_pain_dropgun;
      else
        painArray[painArray.size] = % exposed2_pain_dropgun;
    }
    if(self damageLocationIsAny("torso_lower", "left_leg_upper", "right_leg_upper")) {
      if(!isDefined(self.exposedSet) || self.exposedSet == 0)
        painArray[painArray.size] = % exposed_pain_groin;
      else
        painArray[painArray.size] = % exposed2_pain_groin;
    }
    if(self damageLocationIsAny("left_hand", "left_arm_lower", "left_arm_upper")) {
      if(!isDefined(self.exposedSet) || self.exposedSet == 0)
        painArray[painArray.size] = % exposed_pain_left_arm;
      else
        painArray[painArray.size] = % exposed2_pain_left_arm;
    }
    if(self damageLocationIsAny("right_hand", "right_arm_lower", "right_arm_upper")) {
      if(!isDefined(self.exposedSet) || self.exposedSet == 0)
        painArray[painArray.size] = % exposed_pain_right_arm;
      else
        painArray[painArray.size] = % exposed2_pain_right_arm;
    }
    if(self damageLocationIsAny("left_foot", "right_foot", "left_leg_lower", "right_leg_lower", "left_leg_upper", "right_leg_upper")) {
      if(!isDefined(self.exposedSet) || self.exposedSet == 0)
        painArray[painArray.size] = % exposed_pain_leg;
      else
        painArray[painArray.size] = % exposed2_pain_leg;
    }
    if(painArray.size < 2) {
      if(!isDefined(self.exposedSet) || self.exposedSet == 0)
        painArray[painArray.size] = % exposed_pain_back;
      else
        painArray[painArray.size] = % exposed2_pain_back;
    }
    if(painArray.size < 2) {
      if(!isDefined(self.exposedSet) || self.exposedSet == 0)
        painArray[painArray.size] = % exposed_pain_dropgun;
      else
        painArray[painArray.size] = % exposed2_pain_dropgun;
    }
  }
  assertex(painArray.size > 0, painArray.size);
  return painArray[randomint(painArray.size)];
}

removeBlockedAnims(array) {
  newArray = [];
  for (index = 0; index < array.size; index++) {
    localDeltaVector = getMoveDelta(array[index], 0, 1);
    endPoint = self localToWorldCoords(localDeltaVector);
    if(self mayMoveToPoint(endPoint))
      newArray[newArray.size] = array[index];
  }
  return newArray;
}

getCrouchPainAnim() {
  painArray = [];
  if(self usingGasWeapon()) {
    painArray[painArray.size] = % ai_flamethrower_crouch_pain;
  } else {
    if(damageLocationIsAny("torso_upper", "torso_lower", "left_arm_upper", "right_arm_upper", "neck"))
      painArray[painArray.size] = % exposed_crouch_pain_chest;
    if(damageLocationIsAny("head", "neck", "torso_upper"))
      painArray[painArray.size] = % exposed_crouch_pain_headsnap;
    if(damageLocationIsAny("left_hand", "left_arm_lower", "left_arm_upper"))
      painArray[painArray.size] = % exposed_crouch_pain_left_arm;
    if(damageLocationIsAny("right_hand", "right_arm_lower", "right_arm_upper"))
      painArray[painArray.size] = % exposed_crouch_pain_right_arm;
    if(painArray.size < 2)
      painArray[painArray.size] = % exposed_crouch_pain_flinch;
    if(painArray.size < 2)
      painArray[painArray.size] = % exposed_crouch_pain_chest;
  }
  assertex(painArray.size > 0, painArray.size);
  return painArray[randomint(painArray.size)];
}

getPronePainAnim() {
  if(randomint(2) == 0)
    return % prone_reaction_A;
  else
    return % prone_reaction_B;
}

playPainAnim(painAnim) {
  if(isDefined(self.magic_bullet_shield))
    rate = 1.5;
  else
    rate = self.animPlayBackRate;
  self setFlaggedAnimKnobAllRestart("painanim", painAnim, % body, 1, .1, rate);
  if(self.a.pose == "prone")
    self UpdateProne( % prone_legs_up, % prone_legs_down, 1, 0.1, 1);
  if(animHasNotetrack(painAnim, "start_aim")) {
    self thread notifyStartAim("painanim");
    self endon("start_aim");
  }
  self animscripts\shared::DoNoteTracks("painanim");
}

notifyStartAim(animFlag) {
  self endon("killanimscript");
  self waittillmatch(animFlag, "start_aim");
  self notify("start_aim");
}

specialPain(anim_special) {
  if(anim_special == "none")
    return false;
  if(self usingGasWeapon()) {
    return false;
  }
  switch (anim_special) {
    case "cover_left":
      if(self.a.pose == "stand") {
        painArray = [];
        if(self damageLocationIsAny("torso_lower", "left_leg_upper", "right_leg_upper") || randomfloat(10) < 3)
          painArray[painArray.size] = % corner_standl_painB;
        if(self damageLocationIsAny("torso_lower", "torso_upper", "left_arm_upper", "right_arm_upper", "neck") || randomfloat(10) < 3)
          painArray[painArray.size] = % corner_standl_painC;
        if(self damageLocationIsAny("left_leg_upper", "left_leg_lower", "left_foot") || randomfloat(10) < 3)
          painArray[painArray.size] = % corner_standl_painD;
        if(self damageLocationIsAny("right_leg_upper", "right_leg_lower", "right_foot") || randomfloat(10) < 3)
          painArray[painArray.size] = % corner_standl_painE;
        if(painArray.size < 2)
          painArray[painArray.size] = % corner_standl_pain;
        DoPainFromArray(painArray);
        handled = true;
      } else
        handled = false;
      break;
    case "cover_right":
      if(self.a.pose == "stand") {
        painArray = [];
        if(self damageLocationIsAny("right_arm_upper", "torso_upper", "neck") || randomfloat(10) < 3)
          painArray[painArray.size] = % corner_standr_pain;
        if(self damageLocationIsAny("right_leg_upper", "right_leg_lower", "right_foot") || randomfloat(10) < 3)
          painArray[painArray.size] = % corner_standr_painB;
        if(self damageLocationIsAny("torso_lower", "left_leg_upper", "right_leg_upper") || randomfloat(10) < 3)
          painArray[painArray.size] = % corner_standr_painC;
        if(painArray.size == 0) {
          painArray[0] = % corner_standr_pain;
          painArray[1] = % corner_standr_painB;
          painArray[2] = % corner_standr_painC;
        }
        DoPainFromArray(painArray);
        handled = true;
      } else
        handled = false;
      break;
    case "cover_crouch":
      handled = false;
      break;
    case "cover_stand":
      painArray = [];
      if(self damageLocationIsAny("torso_lower", "left_leg_upper", "right_leg_upper") || randomfloat(10) < 3)
        painArray[painArray.size] = % coverstand_pain_groin;
      if(self damageLocationIsAny("torso_lower", "torso_upper", "left_arm_upper", "right_arm_upper", "neck") || randomfloat(10) < 3)
        painArray[painArray.size] = % coverstand_pain_groin;
      if(self damageLocationIsAny("left_leg_upper", "left_leg_lower", "left_foot") || randomfloat(10) < 3)
        painArray[painArray.size] = % coverstand_pain_leg;
      if(self damageLocationIsAny("right_leg_upper", "right_leg_lower", "right_foot") || randomfloat(10) < 3)
        painArray[painArray.size] = % coverstand_pain_leg;
      if(painArray.size < 2)
        painArray[painArray.size] = % coverstand_pain_leg;
      DoPainFromArray(painArray);
      handled = true;
      break;
    case "saw":
      if(self.a.pose == "stand")
        painAnim = % saw_gunner_pain;
      else if(self.a.pose == "crouch")
        painAnim = % saw_gunner_lowwall_pain_02;
      else
        painAnim = % saw_gunner_prone_pain;
      self setflaggedanimknob("painanim", painAnim, 1, .3, 1);
      self animscripts\shared::DoNoteTracks("painanim");
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
    case "dying_crawl":
      handled = false;
      break;
    default:
      println("Unexpected anim_special value : " + anim_special + " in specialPain.");
      handled = false;
  }
  return handled;
}

painDeathNotify() {
  self endon("death");
  wait .05;
  self notify("pain_death");
}

DoPainFromArray(painArray) {
  painAnim = painArray[randomint(painArray.size)];
  self setflaggedanimknob("painanim", painAnim, 1, .3, 1);
  self animscripts\shared::DoNoteTracks("painanim");
}

mg42pain(pose) {
  assertEx(isDefined(level.mg_animmg), "You're missing maps\\_mganim::main();Add it to your level.");
  {
    println("	maps\\_mganim::main();");
    return;
  }
  self setflaggedanimknob("painanim", level.mg_animmg["pain_" + pose], 1, .1, 1);
  self animscripts\shared::DoNoteTracks("painanim");
}

waitSetStop(timetowait, killmestring) {
  self endon("killanimscript");
  self endon("death");
  if(isDefined(killmestring))
    self endon(killmestring);
  wait timetowait;
  self.a.movement = "stop";
}

PlayHitAnimation() {
  animWeights = animscripts\utility::QuadrantAnimWeights(self.damageYaw + 180);
  playHitAnim = 1;
  switch (self.damageLocation) {
    case "torso_upper":
    case "torso_lower":
      frontAnim = % minorpain_chest_front;
      backAnim = % minorpain_chest_back;
      leftAnim = % minorpain_chest_left;
      rightAnim = % minorpain_chest_right;
      break;
    case "helmet":
    case "head":
    case "neck":
      frontAnim = % minorpain_head_front;
      backAnim = % minorpain_head_back;
      leftAnim = % minorpain_head_left;
      rightAnim = % minorpain_head_right;
      break;
    case "left_arm_upper":
    case "left_arm_lower":
    case "left_hand":
      frontAnim = % minorpain_leftarm_front;
      backAnim = % minorpain_leftarm_back;
      leftAnim = % minorpain_leftarm_left;
      rightAnim = % minorpain_leftarm_right;
      break;
    case "right_arm_upper":
    case "right_arm_lower":
    case "right_hand":
    case "gun":
      frontAnim = % minorpain_rightarm_front;
      backAnim = % minorpain_rightarm_back;
      leftAnim = % minorpain_rightarm_left;
      rightAnim = % minorpain_rightarm_right;
      break;
    case "none":
    case "left_leg_upper":
    case "left_leg_lower":
    case "left_foot":
    case "right_leg_upper":
    case "right_leg_lower":
    case "right_foot":
      return;
    default:
      assertmsg("pain.gsc/HitAnimation: unknown hit location " + self.damageLocation);
      return;
  }
  if(playHitAnim) {
    if(self.damageTaken > 200)
      weight = 1;
    else
      weight = (self.damageTaken + 50.0) / 250;
    self clearanim( % minor_pain, 0.1);
    self setanim(frontAnim, animWeights["front"], 0.05, 1);
    self setanim(backAnim, animWeights["back"], 0.05, 1);
    self setanim(leftAnim, animWeights["left"], 0.05, 1);
    self setanim(rightAnim, animWeights["right"], 0.05, 1);
    self setanim( % minor_pain, weight, (0.05 / weight), 1);
    wait 0.05;
    if(!isDefined(self))
      return;
    self clearanim( % minor_pain, (0.2 / weight));
    wait 0.2;
  }
}

crawlingPain() {
  if(getDvarInt("scr_forceCrawl") == 1 && !isDefined(self.magic_bullet_shield)) {
    self.health = 10;
    self thread crawlingPistol();
    self waittill("killanimscript");
    return true;
  }
  legHit = self damageLocationIsAny("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower", "left_foot", "right_foot");
  if(legHit && self.health < self.maxhealth * .4) {
    if(gettime() < anim.nextCrawlingPainTimeFromLegDamage)
      return false;
  } else {
    if(anim.numDeathsUntilCrawlingPain > 0)
      return false;
    if(gettime() < anim.nextCrawlingPainTime)
      return false;
  }
  if(self.team != "axis")
    return false;
  if(self.a.disableLongDeath || (isDefined(self.dieQuietly) && self.dieQuietly))
    return false;
  if(self.damageMod == "MOD_BURNED") {
    return false;
  }
  if(self usingGasWeapon()) {
    return false;
  }
  if(self.a.pose != "prone" && self.a.pose != "crouch" && self.a.pose != "stand")
    return false;
  if(isDefined(self.deathFunction))
    return false;
  players = GetPlayers();
  if(players.size == 0)
    return false;
  anybody_nearby = 0;
  for (i = 0; i < players.size; i++) {
    if(isDefined(players[i]) && distance(self.origin, players[i].origin) < 175) {
      anybody_nearby = 1;
      break;
    }
  }
  if(!anybody_nearby)
    return false;
  if(self damageLocationIsAny("head", "helmet", "gun", "right_hand", "left_hand"))
    return false;
  if(usingSidearm())
    return false;
  if(self depthinwater() > 8)
    return false;
  anim.nextCrawlingPainTime = gettime() + 3000;
  anim.nextCrawlingPainTimeFromLegDamage = gettime() + 3000;
  self thread crawlingPistol();
  self waittill("killanimscript");
  return true;
}

crawlingPistol() {
  self endon("kill_long_death");
  self endon("death");
  self.a.array = [];
  self.a.array["stand_2_crawl"] = array( % dying_stand_2_crawl_v1, % dying_stand_2_crawl_v2, % dying_stand_2_crawl_v3);
  self.a.array["crouch_2_crawl"] = array( % dying_crouch_2_crawl);
  self.a.array["crawl"] = % dying_crawl;
  self.a.array["death"] = array( % dying_crawl_death_v1, % dying_crawl_death_v2);
  self.a.array["prone_2_back"] = array( % dying_crawl_2_back);
  self.a.array["stand_2_back"] = array( % dying_stand_2_back_v1, % dying_stand_2_back_v2, % dying_stand_2_back_v3);
  self.a.array["crouch_2_back"] = array( % dying_crouch_2_back);
  self.a.array["back_idle"] = % dying_back_idle;
  self.a.array["back_idle_twitch"] = array( % dying_back_twitch_A, % dying_back_twitch_B);
  self.a.array["back_crawl"] = % dying_crawl_back;
  self.a.array["back_fire"] = % dying_back_fire;
  self.a.array["back_death"] = array( % dying_back_death_v1, % dying_back_death_v2, % dying_back_death_v3);
  self thread preventPainForAShortTime("crawling");
  self.a.special = "none";
  self thread painDeathNotify();
  level notify("ai_crawling", self);
  self thread crawling_stab_achievement();
  self.isSniper = false;
  self setAnimKnobAll( % dying, % body, 1, 0.1, 1);
  if(!self dyingCrawl()) {
    return;
  }
  assert(self.a.pose == "stand" || self.a.pose == "crouch" || self.a.pose == "prone");
  transAnimSlot = self.a.pose + "_2_back";
  transAnim = animArrayPickRandom(transAnimSlot);
  self setFlaggedAnimKnob("transition", transAnim, 1, 0.5, 1);
  self animscripts\shared::DoNoteTracksIntercept("transition", ::handleBackCrawlNotetracks);
  if(self.a.pose != "back") {
    println("Anim \"", transAnim, "\" is missing an 'anim_pose = \"back\"' notetrack.");
    assert(self.a.pose == "back");
  }
  self.a.special = "dying_crawl";
  self thread dyingCrawlBackAim();
  decideNumCrawls();
  while (shouldKeepCrawling()) {
    crawlAnim = animArray("back_crawl");
    delta = getMoveDelta(crawlAnim, 0, 1);
    endPos = self localToWorldCoords(delta);
    if(!self mayMoveToPoint(endPos)) {
      break;
    }
    self setFlaggedAnimKnobRestart("back_crawl", crawlAnim, 1, 0.1, 1.0);
    self animscripts\shared::DoNoteTracksIntercept("back_crawl", ::handleBackCrawlNotetracks);
  }
  self.desiredTimeOfDeath = gettime() + randomintrange(4000, 20000);
  while (shouldStayAlive()) {
    if(self canSeeEnemy() && self aimedSomewhatAtEnemy()) {
      backAnim = animArray("back_fire");
      self setFlaggedAnimKnobRestart("back_idle_or_fire", backAnim, 1, 0.2, 1.0);
      self animscripts\shared::DoNoteTracks("back_idle_or_fire");
    } else {
      backAnim = animArray("back_idle");
      if(randomfloat(1) < .4)
        backAnim = animArrayPickRandom("back_idle_twitch");
      self setFlaggedAnimKnobRestart("back_idle_or_fire", backAnim, 1, 0.1, 1.0);
      timeRemaining = getAnimLength(backAnim);
      while (timeRemaining > 0) {
        if(self canSeeEnemy() && self aimedSomewhatAtEnemy()) {
          break;
        }
        interval = 0.5;
        if(interval > timeRemaining) {
          interval = timeRemaining;
          timeRemaining = 0;
        } else {
          timeRemaining -= interval;
        }
        self animscripts\shared::DoNoteTracksForTime(interval, "back_idle_or_fire");
      }
    }
  }
  self notify("end_dying_crawl_back_aim");
  self clearAnim( % dying_back_aim_4_wrapper, .3);
  self clearAnim( % dying_back_aim_6_wrapper, .3);
  self.a.nodeath = true;
  animscripts\death::play_death_anim(animArrayPickRandom("back_death"));
  self doDamage(self.health + 5, (0, 0, 0));
  self.a.special = "none";
}

crawling_stab_achievement() {
  if(self.team == "allies")
    return;
  self endon("end_dying_crawl_back_aim");
  self waittill("death", attacker, type);
  if(!isDefined(self) || !isDefined(attacker) || !IsPlayer(attacker))
    return;
}

shouldStayAlive() {
  if(!enemyIsInGeneralDirection(anglesToForward(self.angles)))
    return false;
  return gettime() < self.desiredTimeOfDeath;
}

dyingCrawl() {
  if(self.a.pose == "prone")
    return true;
  if(self.a.movement == "stop") {
    if(randomfloat(1) < .2) {
      if(randomfloat(1) < .5)
        return true;
    } else {
      if(abs(self.damageYaw) > 90)
        return true;
    }
  } else {
    if(abs(self getMotionAngle()) > 90)
      return true;
  }
  self setFlaggedAnimKnob("falling", animArrayPickRandom(self.a.pose + "_2_crawl"), 1, 0.5, 1);
  self animscripts\shared::DoNoteTracks("falling");
  assert(self.a.pose == "prone");
  self.a.special = "dying_crawl";
  decideNumCrawls();
  while (shouldKeepCrawling()) {
    crawlAnim = animArray("crawl");
    delta = getMoveDelta(crawlAnim, 0, 1);
    endPos = self localToWorldCoords(delta);
    if(!self mayMoveToPoint(endPos))
      return true;
    self setFlaggedAnimKnobRestart("crawling", crawlAnim, 1, 0.1, 1.0);
    self animscripts\shared::DoNoteTracks("crawling");
  }
  if(enemyIsInGeneralDirection(anglesToForward(self.angles) * -1))
    return true;
  self.a.nodeath = true;
  animscripts\death::play_death_anim(animArrayPickRandom("death"));
  self doDamage(self.health + 5, (0, 0, 0));
  self.a.special = "none";
  return false;
}

dyingCrawlBackAim() {
  self endon("kill_long_death");
  self endon("death");
  self endon("end_dying_crawl_back_aim");
  if(isDefined(self.dyingCrawlAiming))
    return;
  self.dyingCrawlAiming = true;
  self setAnimLimited( % dying_back_aim_4, 1, 0);
  self setAnimLimited( % dying_back_aim_6, 1, 0);
  prevyaw = 0;
  while (1) {
    aimyaw = self getYawToEnemy();
    diff = AngleClamp180(aimyaw - prevyaw);
    if(abs(diff) > 3)
      diff = sign(diff) * 3;
    aimyaw = AngleClamp180(prevyaw + diff);
    if(aimyaw < 0) {
      if(aimyaw < -45.0)
        aimyaw = -45.0;
      weight = aimyaw / -45.0;
      self setAnim( % dying_back_aim_4_wrapper, weight, .05);
      self setAnim( % dying_back_aim_6_wrapper, 0, .05);
    } else {
      if(aimyaw > 45.0)
        aimyaw = 45.0;
      weight = aimyaw / 45.0;
      self setAnim( % dying_back_aim_6_wrapper, weight, .05);
      self setAnim( % dying_back_aim_4_wrapper, 0, .05);
    }
    prevyaw = aimyaw;
    wait .05;
  }
}

startDyingCrawlBackAimSoon() {
  self endon("kill_long_death");
  self endon("death");
  wait 0.5;
  self thread dyingCrawlBackAim();
}

handleBackCrawlNotetracks(note) {
  if(note == "fire_spray") {
    if(!self canSeeEnemy())
      return true;
    if(!self aimedSomewhatAtEnemy())
      return true;
    self shootEnemyWrapper();
    return true;
  } else if(note == "pistol_pickup") {
    self thread startDyingCrawlBackAimSoon();
    return false;
  }
  return false;
}

aimedSomewhatAtEnemy() {
  assert(isValidEnemy(self.enemy));
  enemyShootAtPos = self.enemy getShootAtPos();
  weaponAngles = self gettagangles("tag_weapon");
  anglesToEnemy = vectorToAngles(enemyShootAtPos - self gettagorigin("tag_weapon"));
  absyawdiff = AbsAngleClamp180(weaponAngles[1] - anglesToEnemy[1]);
  if(absyawdiff > 25) {
    if(distanceSquared(self getShootAtPos(), enemyShootAtPos) > 64 * 64 || absyawdiff > 45)
      return false;
  }
  return AbsAngleClamp180(weaponAngles[0] - anglesToEnemy[0]) <= 30;
}

enemyIsInGeneralDirection(dir) {
  if(!isValidEnemy(self.enemy))
    return false;
  toenemy = vectorNormalize(self.enemy getShootAtPos() - self getEye());
  return (vectorDot(toenemy, dir) > 0.5);
}

preventPainForAShortTime(type) {
  self endon("kill_long_death");
  self endon("death");
  self.flashBangImmunity = true;
  self.longDeathStarting = true;
  self.doingLongDeath = true;
  self notify("long_death");
  self.health = 10000;
  wait .75;
  if(self.health > 1)
    self.health = 1;
  wait .05;
  self.longDeathStarting = undefined;
  self.a.mayOnlyDie = true;
  if(type == "crawling") {
    wait 1.0;
    players = GetPlayers();
    anybody_nearby = 0;
    for (i = 0; i < players.size; i++) {
      if(isDefined(players[i]) && distanceSquared(self.origin, players[i].origin) < 1048576) {
        anybody_nearby = 1;
        break;
      }
    }
    if(anybody_nearby) {
      anim.numDeathsUntilCrawlingPain = randomintrange(10, 30);
      anim.nextCrawlingPainTime = gettime() + randomintrange(15000, 60000);
    } else {
      anim.numDeathsUntilCrawlingPain = randomintrange(5, 12);
      anim.nextCrawlingPainTime = gettime() + randomintrange(5000, 25000);
    }
    anim.nextCrawlingPainTimeFromLegDamage = gettime() + randomintrange(7000, 13000);
    if(getDebugDvarInt("scr_crawldebug") == 1) {
      thread printLongDeathDebugText(self.origin + (0, 0, 64), "crawl death");
      return;
    }
  } else if(type == "corner_grenade") {
    wait 1.0;
    players = GetPlayers();
    anybody_nearby = 0;
    for (i = 0; i < players.size; i++) {
      if(isDefined(players[i]) && distanceSquared(self.origin, players[i].origin) < 490000) {
        anybody_nearby = 1;
        break;
      }
    }
    if(anybody_nearby) {
      anim.numDeathsUntilCornerGrenadeDeath = randomintrange(10, 30);
      anim.nextCornerGrenadeDeathTime = gettime() + randomintrange(15000, 60000);
    } else {
      anim.numDeathsUntilCornerGrenadeDeath = randomintrange(5, 12);
      anim.nextCornerGrenadeDeathTime = gettime() + randomintrange(5000, 25000);
    }
    if(getDebugDvarInt("scr_cornergrenadedebug") == 1) {
      thread printLongDeathDebugText(self.origin + (0, 0, 64), "grenade death");
      return;
    }
  }
}

printLongDeathDebugText(loc, text) {
  for (i = 0; i < 100; i++) {
    print3d(loc, text);
    wait .05;
  }
}

decideNumCrawls() {
  self.a.numCrawls = randomIntRange(0, 5);
}
shouldKeepCrawling() {
  assert(isDefined(self.a.numCrawls));
  if(!self.a.numCrawls) {
    self.a.numCrawls = undefined;
    return false;
  }
  self.a.numCrawls--;
  return true;
}

TryCornerRightGrenadeDeath() {
  if(getDvarInt("scr_forceCornerGrenadeDeath") == 1) {
    self thread CornerRightGrenadeDeath();
    self waittill("killanimscript");
    return true;
  }
  if(self usingGasWeapon()) {
    return false;
  }
  if(anim.numDeathsUntilCornerGrenadeDeath > 0)
    return false;
  if(gettime() < anim.nextCornerGrenadeDeathTime)
    return false;
  if(self.team != "axis")
    return false;
  if(self.a.disableLongDeath || (isDefined(self.dieQuietly) && self.dieQuietly))
    return false;
  if(isDefined(self.deathFunction))
    return false;
  players = GetPlayers();
  if(players.size == 0)
    return false;
  anybody_nearby = 0;
  for (i = 0; i < players.size; i++) {
    if(isDefined(players[i]) && distance(self.origin, players[i].origin) < 175) {
      anybody_nearby = 1;
      break;
    }
  }
  if(anybody_nearby)
    return false;
  anim.nextCornerGrenadeDeathTime = gettime() + 3000;
  self thread CornerRightGrenadeDeath();
  self waittill("killanimscript");
  return true;
}

CornerRightGrenadeDeath() {
  self endon("kill_long_death");
  self endon("death");
  self thread painDeathNotify();
  self thread preventPainForAShortTime("corner_grenade");
  self thread maps\_utility::set_battlechatter(false);
  self.threatbias = -1000;
  self setFlaggedAnimKnobAllRestart("corner_grenade_pain", % corner_standR_death_grenade_hit, % body, 1, .1);
  self waittillmatch("corner_grenade_pain", "dropgun");
  self animscripts\shared::DropAllAIWeapons();
  self waittillmatch("corner_grenade_pain", "anim_pose = \"back\"");
  self.a.pose = "back";
  self waittillmatch("corner_grenade_pain", "grenade_left");
  model = getWeaponModel("fraggrenade");
  self attach(model, "tag_inhand");
  self.deathFunction = ::prematureCornerGrenadeDeath;
  self waittillmatch("corner_grenade_pain", "end");
  desiredDeathTime = gettime() + randomintrange(25000, 60000);
  self setFlaggedAnimKnobAllRestart("corner_grenade_idle", % corner_standR_death_grenade_idle, % body, 1, .2);
  self thread watchEnemyVelocity();
  while (!enemyIsApproaching()) {
    if(gettime() >= desiredDeathTime) {
      break;
    }
    self animscripts\shared::DoNoteTracksForTime(0.1, "corner_grenade_idle");
  }
  dropAnim = % corner_standR_death_grenade_slump;
  self setFlaggedAnimKnobAllRestart("corner_grenade_release", dropAnim, % body, 1, .2);
  dropTimeArray = getNotetrackTimes(dropAnim, "grenade_drop");
  assert(dropTimeArray.size == 1);
  dropTime = dropTimeArray[0] * getAnimLength(dropAnim);
  wait dropTime - 1.0;
  self animscripts\death::PlayDeathSound();
  wait 0.7;
  self.deathFunction = ::waitTillGrenadeDrops;
  velocity = (0, 0, 30) - anglesToRight(self.angles) * 70;
  self CornerDeathReleaseGrenade(velocity, randomfloatrange(2.0, 3.0));
  wait .05;
  self detach(model, "tag_inhand");
  self thread killSelf();
}

CornerDeathReleaseGrenade(velocity, fusetime) {
  releasePoint = self getTagOrigin("tag_inhand");
  releasePointLifted = releasePoint + (0, 0, 20);
  releasePointDropped = releasePoint - (0, 0, 20);
  trace = bullettrace(releasePointLifted, releasePointDropped, false, undefined);
  if(trace["fraction"] < .5)
    releasePoint = trace["position"];
  surfaceType = "default";
  if(trace["surfacetype"] != "none")
    surfaceType = trace["surfacetype"];
  thread playSoundAtPoint("grenade_bounce_" + surfaceType, releasePoint);
  self.grenadeWeapon = "fraggrenade";
  self magicGrenadeManual(releasePoint, velocity, fusetime);
}

playSoundAtPoint(alias, origin) {
  org = spawn("script_origin", origin);
  org playsound(alias, "sounddone");
  org waittill("sounddone");
  org delete();
}

killSelf() {
  self.a.nodeath = true;
  self doDamage(self.health + 5, (0, 0, 0));
  self startragdoll();
  wait .1;
  self notify("grenade_drop_done");
}

enemyIsApproaching() {
  if(!isValidEnemy(self.enemy))
    return false;
  if(distanceSquared(self.origin, self.enemy.origin) > 384 * 384)
    return false;
  if(distanceSquared(self.origin, self.enemy.origin) < 128 * 128)
    return true;
  predictedEnemyPos = self.enemy.origin + self.enemyVelocity * 3.0;
  nearestPos = self.enemy.origin;
  if(self.enemy.origin != predictedEnemyPos)
    nearestPos = pointOnSegmentNearestToPoint(self.enemy.origin, predictedEnemyPos, self.origin);
  if(distanceSquared(self.origin, nearestPos) < 128 * 128)
    return true;
  return false;
}

prematureCornerGrenadeDeath() {
  deathArray = array( % dying_back_death_v1, % dying_back_death_v2, % dying_back_death_v3, % dying_back_death_v4);
  deathAnim = deathArray[randomint(deathArray.size)];
  self animscripts\death::PlayDeathSound();
  self setFlaggedAnimKnobAllRestart("corner_grenade_die", deathAnim, % body, 1, .2);
  velocity = getGrenadeDropVelocity();
  self CornerDeathReleaseGrenade(velocity, 3.0);
  model = getWeaponModel("fraggrenade");
  self detach(model, "tag_inhand");
  wait .05;
  self startragdoll();
  self waittillmatch("corner_grenade_die", "end");
}

waitTillGrenadeDrops() {
  self waittill("grenade_drop_done");
}

watchEnemyVelocity() {
  self endon("kill_long_death");
  self endon("death");
  self.enemyVelocity = (0, 0, 0);
  prevenemy = undefined;
  prevpos = self.origin;
  interval = .15;
  while (1) {
    if(isDefined(self.enemy) && isDefined(prevenemy) && self.enemy == prevenemy) {
      curpos = self.enemy.origin;
      self.enemyVelocity = vectorScale(curpos - prevpos, 1 / interval);
      prevpos = curpos;
    } else {
      if(isDefined(self.enemy))
        prevpos = self.enemy.origin;
      else
        prevpos = self.origin;
      prevenemy = self.enemy;
      self.shootEntVelocity = (0, 0, 0);
    }
    wait interval;
  }
}